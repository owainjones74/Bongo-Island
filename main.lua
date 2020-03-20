-- Load libs
require("libs/hooks")
require("classes/button")
require("classes/bongo")
require("scenes/menu")
require("scenes/main")

-- cache

-- Other
GAME = {}
GAME.scene = nil

function love.load()
	-- Set up frame
	love.window.setMode(800, 800)
	love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

	-- Other stuff
--	ChangeScene("menu")
	ChangeScene("main")
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
	hook.Call("draw", w, h)
end

function GetCurrentPressLocation()
	return love.mouse.getX(), love.mouse.getY()
end

function ChangeScene(scene)
	hook.Call("newScene", GAME.scene, scene)
	GAME.scene = scene
end

local clickCursor = love.mouse.getSystemCursor("hand")
hook.Add("think", "cursorClicker", function(w, h)
	love.mouse.setCursor()
	for k, v in pairs(ALLBUTTONS) do
		if v.isHovered then
			love.mouse.setCursor(clickCursor)
			break
		end
	end
end)
