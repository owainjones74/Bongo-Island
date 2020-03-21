-- Cache
local id = 0
ALLTOTEMS = {}

-- Create the button
function CreateTotem()
	local TOTEM = {}

	function TOTEM:Int()
		id = id + 1
		self.id = id

		self.wide = 200
		self.tall = 200
		self.x, self.y = love.graphics.getDimensions()
		self.x = self.x/2-self.wide/2
		self.y = self.y/2-self.tall/2

		self.lastClick = 0
		self.text = "Example Text"
		self.color = {r = 0.2, g = 0.25, b = 1}
		self.func = func

		hook.Add("think", "totem"..id, function()
			self:Think()
		end)
		hook.Add("drawTotem", "totem"..id, function()
			self:Draw(self.x, self.y, self.wide, self.tall)
		end)
		ALLTOTEMS[id] = self
	end
	
	function TOTEM:Think()
	end
	
	function TOTEM:Draw(x, y, w, h)
		love.graphics.setColor(self.color.r, self.color.g, self.color.b)
		love.graphics.rectangle("fill", x, y, w, h)
	end

	function TOTEM:SetSize(w, h)
		self.wide, self.tall = w, h
	end
	
	function TOTEM:GetSize()
		return self.wide, self.tall
	end

	function TOTEM:GetWide()
		return self.wide
	end

	function TOTEM:GetTall()
		return self.tall
	end
	
	function TOTEM:SetPos(x, y)
		self.x, self.y = x, y
	end
	
	function TOTEM:GetPos()
		return self.x, self.y
	end
	
	function TOTEM:SetState(state)
		self.state = state
	end
	
	function TOTEM:GetState()
		return self.state
	end
	
	function TOTEM:Remove()
		print("Removing button")
		hook.Remove("think", "button"..self.id)
		hook.Remove("drawTotem", "button"..self.id)
		ALLTOTEMS[id] = nil
		self = nil
	end

	TOTEM:Int()

	return TOTEM
end

