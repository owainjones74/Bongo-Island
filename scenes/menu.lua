-- buttons
local buttons = {}

hook.Add("newScene", "menuScene", function(curScene, newScene)
	print("menu", curScene, newScene)
	if curScene == "menu" then
		for k, v in pairs(buttons) do
			v:Remove()
		end
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
	end
end)