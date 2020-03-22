local bongo
local totem1
local totem2


local feedbackFont = love.graphics.newFont("assets/bebas_neue.ttf", 30)
local music = love.audio.newSource("assets/music.wav", "stream")

function getCurrentSongTime()
	return music:tell("seconds")
end

hook.Add("newScene", "mainScene", function(curScene, newScene)
	if curScene == "main" then
		if bongo then
			bongo:Remove()
			bongo = nil
		end
		for k, v in pairs(ALLBEATS) do
			v:Remove()
		end
		for k, v in pairs(BEATMAP) do
			v.finished = nil
			v.entity = nil
		end
		hook.Remove("draw", "beatTimeline")
		hook.Remove("think", "beatProgress")
		if totem1 then
			totem1:Remove()
			totem1 = nil
		end
		if totem2 then
			totem2:Remove()
			totem2 = nil
		end
		music:stop()
	elseif newScene == "main" then

		GAME.score = {
			combo = 0,
			comboHighest = 0,
			beatsHit = 0
		}
		GAME.feedback = 0



		love.audio.setVolume(0.5)
		music:play()

		bongo = CreateBongo()
		bongo:SetSize(400, 400)
		bongo:SetPos(100, 320)

		hook.Add("draw", "beatTimeline", function(w, h)
			love.graphics.setFont(feedbackFont)
			love.graphics.setColor(1, 1, 1)
			love.graphics.printf("Combo: "..GAME.score.combo.."x", 0, 0, w-5, "right")

			love.graphics.setColor(0.4, 0.4, 0.4, 0.9)
			love.graphics.rectangle("fill", 0, h*0.1, w, h*0.2)
			love.graphics.setColor(1, 1, 1)
			love.graphics.rectangle("fill", w-40, h*0.1, 5, h*0.2)
			love.graphics.setColor(1, 1, 1, 0.5)
			for i=0, 4 do
				love.graphics.rectangle("fill", 0, (h*0.1) + ((h*0.05)*i), w, 5)
			end
			love.graphics.setColor(1, 1, 1)
			love.graphics.printf("Q", 0, (h*0.1) + ((h*0.05)*0), w-50, "right")
			love.graphics.printf("W", 0, (h*0.1) + ((h*0.05)*1), w-50, "right")
			love.graphics.printf("E", 0, (h*0.1) + ((h*0.05)*2), w-50, "right")
			love.graphics.printf("R", 0, (h*0.1) + ((h*0.05)*3), w-50, "right")
		end)

		local w, h = love.graphics.getDimensions()
		hook.Add("think", "beatProgress", function()
			for k, v in ipairs(BEATMAP) do
				if ((v.start - 2) < getCurrentSongTime()) and not v.finished then
					if not v.entity then
						v.entity = CreateBeat()
						v.entity.created = getCurrentSongTime()
						v.entity:SetPos(0, (h*0.1) + ((h*0.05)*(v.channel-1)) + 10)
						v.entity:SetSize((h*0.1)-15, (h*0.05)-15)
						v.entity.channel = v.channel
					end
					local x, y = v.entity:GetPos()
					v.entity:SetPos(w*((getCurrentSongTime()-v.entity.created)*0.25), y)
					if x > w then
						v.finished = true
						if not v.entity.hit then
							GAME.feedback = GAME.feedback - 0.1
							if GAME.feedback < -1 then 
								ChangeScene("lose")
							end
							if GAME.score.combo > GAME.score.comboHighest then
								GAME.score.comboHighest = GAME.score.combo
							end
							GAME.score.combo = 0
						end

						if v.entity then
							v.entity:Remove()
						end

						if k == #BEATMAP then
							ChangeScene("win")
						end
					end
				end
			end
		end)

		totem1 = CreateTotem()
		totem1:SetPos(80, h-140)

		totem2 = CreateTotem()
		totem2:SetPos(w-(totem2:GetWide()/3), h-40)
	end
end)