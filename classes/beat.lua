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

		self.wide = 20
		self.tall = 10
		self.x, self.y = love.graphics.getDimensions()
		self.x = self.x/2-self.wide/2
		self.y = self.y/2-self.tall/2

		math.randomseed(os.time()) -- An attempt to prevent grey
		self.color = {r = math.random(0.7, 0.9), g = math.random(0.5, 0.8), b = math.random(0.6, 0.8)}

		hook.Add("think", "beat"..id, function()
			self:Think()
		end)
		hook.Add("drawBeats", "beat"..id, function()
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
		if (x < self.x) then return false end -- Too far to the left
		if (x > (self.x + self.wide)) then return false end -- Too far to the right

		return true -- Just right
	end
	
	function BEAT:Remove()
		hook.Remove("think", "beat"..self.id)
		hook.Remove("drawBeats", "beat"..self.id)
		ALLBEATS[self.id] = nil
		self = nil
	end

	BEAT:Int()

	return BEAT
end

