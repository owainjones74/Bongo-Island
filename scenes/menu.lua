-- buttons
local buttons = {}

local headerFont = love.graphics.newFont("assets/bebas_neue.ttf", 50)
local subheaderFont = love.graphics.newFont("assets/bebas_neue.ttf", 30)
hook.Add("newScene", "menuScene", function(curScene, newScene)
	if curScene == "menu" then
		for k, v in pairs(buttons) do
			v:Remove()
		end
		hook.Remove("draw", "menuText")
	elseif newScene == "menu" then
		local w, h = love.graphics.getDimensions()
		-- Start the game
		buttons.start = CreateButton(function() ChangeScene("main") end)
		buttons.start:SetPos(w-buttons.start:GetWide()-10, h-buttons.start:GetTall()-10-buttons.start:GetTall()-10)
		buttons.start:SetText("Start")
		-- Quit the game
		buttons.quit = CreateButton(function() love.event.quit() end)
		buttons.quit:SetPos(w-buttons.quit:GetWide()-10, h-buttons.quit:GetTall()-10)
		buttons.quit:SetText("Quit")

		hook.Add("draw", "menuText", function(w, h)
			local start = 40
			-- Background
			love.graphics.setColor(0.4, 0.4, 0.4, 0.9)
			love.graphics.rectangle("fill", 0, start, w, 90)
			love.graphics.setColor(1, 1, 1)
			love.graphics.rectangle("fill", 0, start, w, 5)
			love.graphics.rectangle("fill", 0, start+85, w, 5)

			-- Text
			love.graphics.setFont(headerFont)
			love.graphics.setColor(1, 1, 1)
			love.graphics.printf("BONGO ISLAND", 0, start+5, w, "center")
			love.graphics.setFont(subheaderFont)
			love.graphics.setColor(1, 1, 1)
			love.graphics.printf("You're the last hope to make the totems happy!", 0, start+50, w, "center")
		end)
	end
end)