-- Cache
local id = 0
ALLBEATS = {}

-- Create a beat note
function CreateBeat()
	local realm = realm or ""
	local BEAT = {}

	function BEAT:Int()
		id = id + 1
		self.id = id

		self.wide = 10
		self.tall = 10
		self.x, self.y = love.graphics.getDimensions()
		self.x = self.x/2-self.wide/2
		self.y = self.y/2-self.tall/2

		self.color = {r = 0.2, g = 0.25, b = 1}

		hook.Add("think", "beat"..id, function()
			self:Think()
		end)
		hook.Add("draw", "beat"..id, function()
			self:Draw(self.x, self.y, self.wide, self.tall)
		end)
		ALLBEATS[id] = self
	end
	
	function BEAT:Think()
	end
	
	function BEAT:Draw(x, y, w, h)
		love.graphics.setColor(self.color.r, self.color.g, self.color.b)
		love.graphics.rectangle("fill", x, y, w, h)
	end

	function BEAT:SetSize(w, h)
		self.wide, self.tall = w, h
	end
	
	function BEAT:GetSize()
		return self.wide, self.tall
	end

	function BEAT:GetWide()
		return self.wide
	end

	function BEAT:GetTall()
		return self.tall
	end
	
	function BEAT:SetPos(x, y)
		self.x, self.y = x, y
	end
	
	function BEAT:GetPos()
		return self.x, self.y
	end
	
	function BEAT:SetColor(r, g, b)
		self.color = {r = r, g = g, b = b}
	end

	function BEAT:InCollision(x, y)
		-- x axis
		if (x < self.x) then print("left") return false end -- Too far to the left
		if (x > (self.x + self.wide)) then print("right") return false end -- Too far to the right
		--y axis
		if (y < self.y) then print("up") return false end -- Too high
		if (y > (self.y + self.tall)) then print("down") return false end -- Too low

		return true -- Just right
	end
	
	function BEAT:Remove()
		hook.Remove("think", "beat"..self.id)
		hook.Remove("draw", "beat"..self.id)
		ALLBEATS[id] = nil
		self = nil
	end

	BEAT:Int()

	return BEAT
end

