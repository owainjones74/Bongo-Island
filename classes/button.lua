-- Cache
local id = 0
ALLBUTTONS = {}

local buttonFont = love.graphics.newFont("assets/bebas_neue.ttf", 20)
-- Create the button
function CreateButton(func)
	local realm = realm or ""
	local BUTTON = {}

	function BUTTON:Int()
		id = id + 1
		self.id = id

		self.wide = 200
		self.tall = 50
		self.x, self.y = love.graphics.getDimensions()
		self.x = self.x/2-self.wide/2
		self.y = self.y/2-self.tall/2

		self.lastClick = 0
		self.text = "Example Text"
		self.color = {r = 0.2, g = 0.25, b = 1}
		self.func = func

		hook.Add("think", "button"..id, function()
			self:Think()
		end)
		hook.Add("draw", "button"..id, function()
			self:Draw(self.x, self.y, self.wide, self.tall)
			self:DrawText(self.x, self.y, self.wide, self.tall)
		end)
		ALLBUTTONS[id] = self
	end
	
	function BUTTON:Think()
		if self.lastClick + 1 > love.timer.getTime() then return end

		local x, y = GetCurrentPressLocation()
		if (x > self.x) and (x < self.x+self.wide) and (y > self.y) and (y < self.y+self.tall) then
			self.isHovered = true
			if love.mouse.isDown(1) then
				self.lastClick = love.timer.getTime()
				self:OnClick()
			end
		else
			self.isHovered = false
		end
	end
	
	function BUTTON:Draw(x, y, w, h)
		love.graphics.setColor(self.color.r, self.color.g, self.color.b)
		--love.graphics.rectangle("fill", x, y, w, h)
		love.graphics.polygon("fill",
			x+10, y,
			x+w, y,
			x+w, y+h,
			x, y+h
		)
	end
	function BUTTON:DrawText(x, y, w, h)
		love.graphics.setFont(buttonFont)
		love.graphics.setColor(1, 1, 1)
		love.graphics.printf(self.text, x, y+(h*0.5)-(buttonFont:getHeight()*0.5), w, "center")
	end
	
	function BUTTON:OnClick()
		self.isHovered = false
		self.func(self)
	end

	function BUTTON:SetSize(w, h)
		self.wide, self.tall = w, h
	end
	
	function BUTTON:GetSize()
		return self.wide, self.tall
	end

	function BUTTON:GetWide()
		return self.wide
	end

	function BUTTON:GetTall()
		return self.tall
	end
	
	function BUTTON:SetPos(x, y)
		self.x, self.y = x, y
	end
	
	function BUTTON:GetPos()
		return self.x, self.y
	end
	
	function BUTTON:SetText(text)
		self.text = text
	end
	
	function BUTTON:SetColor(r, g, b)
		self.color = {r = r, g = g, b = b}
	end
	
	function BUTTON:Remove()
		print("Removing button")
		hook.Remove("think", "button"..self.id)
		hook.Remove("draw", "button"..self.id)
		ALLBUTTONS[id] = nil
		self = nil
	end

	BUTTON:Int()

	return BUTTON
end

