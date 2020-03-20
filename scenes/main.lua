local bongo
hook.Add("newScene", "mainScene", function(curScene, newScene)
	print("main", curScene, newScene)
	if curScene == "main" then
		if bongo then
			bongo:Remove()
			bongo = nil
		end
	elseif newScene == "main" then
		bongo = CreateBongo()
		bongo:SetSize(500, 500)
		bongo:SetPos(150, 420)
	end
end)