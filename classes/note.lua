-- Cache
local id = 0
ALLNOTES = {}
local noteTextures = {}
for i=1, 3 do
	noteTextures[i] = love.graphics.newImage("assets/note"..i..".png")
end

-- Create the button
function CreateNote()
	local NOTE = {}

	function NOTE:Int()
		id = id + 1
		self.id = id

		self.wide = 50
		self.tall = 50
		self.x, self.y = love.graphics.getDimensions()
		self.x = self.x/2-self.wide/2
		self.y = self.y/2-self.tall/2

		self.sin = math.random(5, 10)
		self.texture = noteTextures[math.random(#noteTextures)]

		hook.Add("think", "note"..id, function()
			self:Think()
		end)
		hook.Add("drawNotes", "note"..id, function()
			self:Draw(self.x, self.y, self.wide, self.tall)
		end)
		ALLNOTES[id] = self
	end
	
	local w, h = love.graphics.getDimensions()
	function NOTE:Think()
		self:SetPos(self.x + (2*math.sin(love.timer.getTime()*self.sin)), self.y - (h*0.015))
	end
	
	function NOTE:Draw(x, y, w, h)
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(self.texture, x, y, 0, self.wide/self.texture:getWidth(), self.tall/self.texture:getHeight())
	end

	function NOTE:SetSize(w, h)
		self.wide, self.tall = w, h
	end
	
	function NOTE:GetSize()
		return self.wide, self.tall
	end

	function NOTE:GetWide()
		return self.wide
	end

	function NOTE:GetTall()
		return self.tall
	end
	
	function NOTE:SetPos(x, y)
		self.x, self.y = x, y
	end
	
	function NOTE:GetPos()
		return self.x, self.y
	end

	function NOTE:Remove()
		hook.Remove("think", "note"..self.id)
		hook.Remove("drawNotes", "note"..self.id)
		ALLNOTES[self.id] = nil
		self = nil
	end

	NOTE:Int()

	return NOTE
end

