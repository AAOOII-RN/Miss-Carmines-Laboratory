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
	Chapter = "Laboratory 2"
	Scene = 1

	-- states
	OnState = "Blank"
	Sm:add("Blank", require("states.blank"))
	Sm:switch(OnState)

	-- images
	local bg_path = "assets/img/Background/"
	Gradient = love.graphics.newImage("assets/img/gradient.png")
	Background = {
		["Dining table"] = love.graphics.newImage(bg_path .. "Dining table.png"),
		["Laboratory"] = love.graphics.newImage(bg_path .. "Laboratory.png"),
		["Bloodied hallway"] = love.graphics.newImage(bg_path .. "Bloodied hallway.png"),
		["Hallway"] = love.graphics.newImage(bg_path .. "Hallway.png"),
		["Laboratory floor"] = love.graphics.newImage(bg_path .. "Laboratory floor.png"),
		["Test room"] = love.graphics.newImage(bg_path .. "Test room.png"),
		["Bedroom"] = love.graphics.newImage(bg_path .. "Bedroom.png"),
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
	local background = Story[Chapter][Scene][3]
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
