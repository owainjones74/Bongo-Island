-- buttons
local buttons = {}
local headerFont = love.graphics.newFont("assets/bebas_neue.ttf", 50)
local subheaderFont = love.graphics.newFont("assets/bebas_neue.ttf", 30)
hook.Add("newScene", "loseScene", function(curScene, newScene)
	if curScene == "lose" then
		for k, v in pairs(buttons) do
			v:Remove()
		end
		hook.Remove("draw", "loseText")
	elseif newScene == "lose" then
		local w, h = love.graphics.getDimensions()
		-- restart
		buttons.restart = CreateButton(function() ChangeScene("main") end)
		buttons.restart:SetPos(w-buttons.restart:GetWide()-10, h-buttons.restart:GetTall()-10-buttons.restart:GetTall()-10)
		buttons.restart:SetText("Try Again")
		-- Quit the game
		buttons.quit = CreateButton(function() love.event.quit() end)
		buttons.quit:SetPos(w-buttons.quit:GetWide()-10, h-buttons.quit:GetTall()-10)
		buttons.quit:SetText("Quit")

		hook.Add("draw", "loseText", function(w, h)
			local start = 40
			-- Background
			love.graphics.setColor(0.4, 0.4, 0.4, 0.9)
			love.graphics.rectangle("fill", 0, start, w, 90)
			love.graphics.setColor(1, 1, 1)
			love.graphics.rectangle("fill", 0, start, w, 5)
			love.graphics.rectangle("fill", 0, start+85, w, 5)

			-- Text
			love.graphics.setFont(headerFont)
			love.graphics.setColor(1, 0, 0)
			love.graphics.printf("You lose!", 0, start+5, w, "center")
			love.graphics.setFont(subheaderFont)
			love.graphics.setColor(1, 1, 1)
			love.graphics.printf("Seems the totems hated your bongo skills :/", 0, start+50, w, "center")


			-- Stats
			local start = h*0.25
			-- Background
			love.graphics.setColor(0.4, 0.4, 0.4, 0.9)
			love.graphics.rectangle("fill", 0, start, w, 110)
			love.graphics.setColor(1, 1, 1)
			love.graphics.rectangle("fill", 0, start, w, 5)
			love.graphics.rectangle("fill", 0, start+110, w, 5)
			-- Text
			love.graphics.setFont(headerFont)
			love.graphics.setColor(0, 0, 1)
			love.graphics.printf("Score:", 0, start+5, w, "center")
			love.graphics.setFont(subheaderFont)
			love.graphics.setColor(1, 1, 1)
			love.graphics.printf("Beats Hit: "..math.floor((GAME.score.beatsHit/#BEATMAP)*100).."%", 0, start+50, w, "center")
			love.graphics.printf("Highest Combo: "..GAME.score.comboHighest.."x", 0, start+75, w, "center")
		end)
	end
end)