-- Cache
local bongoTexture = love.graphics.newImage("assets/bongos.png")

-- Create the bongo
function CreateBongo()
	local BONGO = {}

	function BONGO:Int()
		self.wide = 200
		self.tall = 200

		self.x, self.y = love.graphics.getDimensions()
		self.x = self.x/2-self.wide/2
		self.y = self.y/2-self.tall/2

		self.drums = {
			[1] = {cooldown = 0, key = "q", active = false, offset = function(w, h) return w*0.3, h*0.1 end}, --,  sound = love.audio.newSource("assets/agogo_h.wav", "stream")},
			[2] = {cooldown = 0, key = "w", active = false, offset = function(w, h) return w*0.70, h*0.15 end}, -- sound = love.audio.newSource("assets/agogo_l.wav", "stream")},
			[3] = {cooldown = 0, key = "e", active = false, offset = function(w, h) return w*0.35, h*0.35 end}, -- sound = love.audio.newSource("assets/conga_h.wav", "stream")},
			[4] = {cooldown = 0, key = "r", active = false, offset = function(w, h) return w*0.65, h*0.45 end} -- sound = love.audio.newSource("assets/bongo_l.wav", "stream")},
		}

		hook.Add("think", "bongo", function()
			self:Think()
		end)
		hook.Add("drawBongo", "bongo", function()
			self:Draw(self.x, self.y, self.wide, self.tall)
		end)
	end
	
	local w, h = love.graphics.getDimensions()
	local counter = 0
	function BONGO:DrumPressed(index)
		counter = counter + 1
		
		local drum = self.drums[index]
		drum.cooldown = love.timer.getTime()
		drum.active = true

		love.audio.setVolume(0.5)
--		drum.sound:play()

		for k, v in pairs(ALLBEATS) do
			if v:InCollision(w-40) and (v.channel == index) then
				GAME.feedback = GAME.feedback + 0.05
				GAME.score.combo = GAME.score.combo + 1
				GAME.score.beatsHit = GAME.score.beatsHit + 1
				v.hit = true
				
				if GAME.feedback > 1 then 
					GAME.feedback = 1
				end
			end
		end

		-- visual note
		local note = CreateNote()
		local offsetx, offsety = drum.offset(self.wide, self.tall)
		note:SetPos(self.x+offsetx, self.y+offsety)
	end

	function BONGO:Think()
		for k, v in pairs(self.drums) do
			if v.cooldown + 0.4 < love.timer.getTime() then 
				if love.keyboard.isDown(v.key) then
					self:DrumPressed(k)
					return
				end
				v.active = false
--				v.sound:stop()
			end
		end
	end

	function BONGO:Draw(x, y, w, h)
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(bongoTexture, self.x, self.y, 0, self.wide/bongoTexture:getWidth(), self.tall/bongoTexture:getHeight())
	end


	function BONGO:SetSize(w, h)
		self.wide, self.tall = w, h
	end
	
	function BONGO:GetSize()
		return self.wide, self.tall
	end

	function BONGO:GetWide()
		return self.wide
	end

	function BONGO:GetTall()
		return self.tall
	end
	
	function BONGO:SetPos(x, y)
		self.x, self.y = x, y
	end
	
	function BONGO:GetPos()
		return self.x, self.y
	end
	
	function BONGO:Remove()
		hook.Remove("think", "bongo")
		hook.Remove("drawBongo", "bongo")
		self = nil
	end

	BONGO:Int()

	return BONGO
end

