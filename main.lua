-- Load libs
require("beatmap")
require("libs/hooks")
require("classes/button")
require("classes/bongo")
require("classes/beat")
require("classes/totem")
require("classes/note")
require("scenes/menu")
require("scenes/main")
require("scenes/lose")
require("scenes/win")

-- cache

-- Other
GAME = {}
GAME.scene = nil
GAME.feedback = 0

function love.load()
	-- Set up frame
	love.window.setMode(600, 600)
	love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
	love.window.setTitle("Bongo Island")

	-- Other stuff
	ChangeScene("menu")
--	ChangeScene("main")

end

-- Limit the think logic, although it probably won't matter in this game
local tickPeriod = 1/50 -- seconds per tick
local accumulator = 0.0
function love.update(dt)
	accumulator = accumulator + dt
	if accumulator >= tickPeriod then
		-- Here be your fixed timestep.
		acumulator = accumulator - tickPeriod

		-- Code to run for each tick
		hook.Call("think", dt)
		-- End that code :D
	end
end

local w, h = love.graphics.getDimensions()
function love.draw()
	w, h = love.graphics.getDimensions()
	hook.Call("drawBackground", w, h)
	hook.Call("drawTotem", w, h)
	hook.Call("drawBongo", w, h)
	hook.Call("drawNotes", w, h)
	hook.Call("draw", w, h)
	hook.Call("drawBeats", w, h)
end

function GetCurrentPressLocation()
	return love.mouse.getX(), love.mouse.getY()
end

function ChangeScene(scene)
	hook.Call("newScene", GAME.scene, scene)
	GAME.scene = scene
end

local clickCursor = love.mouse.getSystemCursor("hand")
hook.Add("think", "cursorClicker", function()
	love.mouse.setCursor()
	for k, v in pairs(ALLBUTTONS) do
		if v.isHovered then
			love.mouse.setCursor(clickCursor)
			break
		end
	end
end)


local backgroundTexture = love.graphics.newImage("assets/background.png")
hook.Add("drawBackground", "main", function(w, h)
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(backgroundTexture, 0, 0, 0, w/backgroundTexture:getWidth(), h/backgroundTexture:getHeight())
end)
