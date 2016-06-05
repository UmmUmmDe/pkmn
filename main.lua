_INFO = {
	_VERSION = "Alpha 1.0",
	_AUTHOR = "UmmUmmDe"
}

la = love.audio
le = love.event
lf = love.filesystem
lft = love.font
lg = love.graphics
li = love.image
lj = love.joystick
lk = love.keyboard
lm = love.math
lmou = love.mouse
ls = love.sound
lsys = love.system
lt = love.thread
ltm = love.timer
ltc = love.touch
lv = love.video
lw = love.window

if lf.exists("scripts/override.lua") then
	require("scripts.override")
end

inspect = require("src.inspect")
class = require("src.30log")
States = require("src.states")
require("src.tiled")
require("src.loader")
require("src.player")

function love.load(args)
	state = States.LOADING
	map = Map("test")
	player = Player()
	res:startLoading()
end

function love.update(dt)
	if state == States.LOADING then
		res:loadUpdate(dt)
	elseif state == States.OVERWORLD then
		map:update(dt)
	end
	Tween.update(dt)
end

function love.draw()
	if res.res.font then
		lg.setFont(res.res.font)
	end
	if state == States.LOADING then
		res:loadDraw()
	elseif state == States.OVERWORLD then
		map:draw()
	end
end

function love.keypressed(key)
	if key == "escape" then
		le.quit()
	end
end
