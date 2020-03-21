local bongo

local start = love.timer.getTime()
local function getCurrentSongTime()
	return love.timer.getTime() - start
end

hook.Add("newScene", "mainScene", function(curScene, newScene)
	print("main", curScene, newScene)
	if curScene == "main" then
		if bongo then
			bongo:Remove()
			bongo = nil
		end
		hook.Remove("draw", "beatTimeline")
	elseif newScene == "main" then
		bongo = CreateBongo()
		bongo:SetSize(500, 500)
		bongo:SetPos(150, 420)


		hook.Add("draw", "beatTimeline", function(w, h)
			love.graphics.setColor(0.4, 0.4, 0.4, 0.9)
			love.graphics.rectangle("fill", 0, h*0.1, w, h*0.2)
			love.graphics.setColor(1, 1, 1)
			love.graphics.rectangle("fill", w-40, h*0.1, 5, h*0.2)
			love.graphics.setColor(1, 1, 1, 0.5)
			for i=0, 4 do
				love.graphics.rectangle("fill", 0, (h*0.1) + ((h*0.05)*i), w, 5)
			end
		end)
		hook.Add("think", "beatProgress", function()
			local w, h = love.graphics.getDimensions()

			for k, v in pairs(BEATMAP) do
				if ((v.start - 2) < getCurrentSongTime()) and not v.finished then
					if not v.entity then
						v.entity = CreateBeat()
						v.entity.created = getCurrentSongTime()
						v.entity:SetPos(0, (h*0.1) + ((h*0.05)*(v.channel-1)) + 10)
						v.entity:SetSize((h*0.05)-15, (h*0.05)-15)
					end
					local x, y = v.entity:GetPos()
					v.entity:SetPos(w*((getCurrentSongTime()-v.entity.created)*0.25), y)
					if x > w then
						v.entity:Remove()
						v.finished = true
					end
				end
			end
		end)
	end
end)