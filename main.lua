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
	Chapter = "Dining Room"
	Scene = "Scene 1"

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
	print(Ui.scenes[Chapter][Scene].objects)
	for _, obj in pairs(Ui.scenes[Chapter][Scene].objects) do
		if Btnui.buttons[Chapter .. "-" .. Scene .. "-" .. obj.name] then
			Btnui.buttons[Chapter .. "-" .. Scene .. "-" .. obj.name].sleep = false
		end
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
	local background = Ui.scenes[Chapter][Scene].properties
	love.graphics.draw(
		Background[background["Background"]],
		Ww / 2 + background["Bg offset"][1] * Ui.scale,
		Wh / 2 + background["Bg offset"][2] * Ui.scale,
		0,
		math.max(
			Ww / Background[background["Background"]]:getWidth(),
			Wh / Background[background["Background"]]:getHeight()
		),
		math.max(
			Ww / Background[background["Background"]]:getWidth(),
			Wh / Background[background["Background"]]:getHeight()
		),
		Background[background["Background"]]:getWidth() / 2,
		Background[background["Background"]]:getHeight() / 2
	)
	Ui:draw()
	Btnui:draw()
end
