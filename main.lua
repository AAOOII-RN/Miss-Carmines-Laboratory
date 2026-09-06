function love.load()
	print("Game Starting...")
	Font = love.graphics.setNewFont("assets/fonts/font.ttf", 30)
	Ww, Wh = love.graphics.getDimensions()
	Ticker = 0

	-- modules
	Object = require("lib.modules.classic")
	Btnui = require("lib.modules.btnui")()
	Sm = require("lib.modules.state").new()
	Pal = require("lib.modules.palette")

	-- classes
	Ui = require("lib.classes.ui-handler")()

	-- Story
	Chapter = "Laboratory 3"
	Scene = 1

	-- states
	OnState = "Blank"
	Sm:add("Blank", require("states.blank"))
	Sm:switch(OnState)

	-- images
	local bg_path = "assets/img/Background/"
	Gradient = love.graphics.newImage("assets/img/gradient.png")
	Background = {
		["Dining Room"] = love.graphics.newImage(bg_path .. "Dining Room.png"),
		["Laboratory"] = love.graphics.newImage(bg_path .. "Laboratory.png"),
	}
end

function Switch()
	print("Switched to: " .. OnState)
	for _, obj in pairs(Btnui.buttons) do
		obj.sleep = true
	end
end

function Lerp(a, b, t)
	return a + t * (b - a)
end

function LerpColor(a, b, t)
	local color = {}
	for i = 1, math.max(#a, #b) do
		local av = a[i] or 0
		local bv = b[i] or 0
		color[i] = av + t * (bv - av)
	end
	return color
end

function love.update(dt)
	Ticker = Ticker + dt

	Sm:update(dt)
end

function love.mousepressed(mx, my)
	Sm:mousepressed(mx, my)
	Ui:mousepressed(mx, my)
end

function love.draw()
	local background = "Dining Room"
	love.graphics.draw(
		Background[background],
		Ww / 2,
		Wh / 2,
		0,
		math.max(Ww / Background[background]:getWidth(), Wh / Background[background]:getHeight()),
		math.max(Ww / Background[background]:getWidth(), Wh / Background[background]:getHeight()),
		Background[background]:getWidth() / 2,
		Background[background]:getHeight() / 2
	)
	if Story[Chapter][Scene][1] ~= "" then
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.line(60 * Ui.scale, 332 * Ui.scale, Ww - 60 * Ui.scale, 332 * Ui.scale)
		love.graphics.draw(
			Gradient,
			Ww / 2,
			Wh / 2,
			0,
			math.max(Ww / Gradient:getWidth(), Wh / Gradient:getHeight()),
			math.max(Ww / Gradient:getWidth(), Wh / Gradient:getHeight()),
			Gradient:getWidth() / 2,
			Gradient:getHeight() / 2
		)
	end

	Ui:draw()
	Btnui:draw()
end
