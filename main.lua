function love.load()
	print("Game Starting...")
	Font = love.graphics.setNewFont("assets/fonts/font.ttf", 100)
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
		["Bedroom"] = love.graphics.newImage(bg_path .. "Bedroom.png"),
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
	love.graphics.draw(
		Background["Bedroom"],
		Ww / 2,
		Wh / 2,
		0,
		math.max(Background["Bedroom"]:getWidth(), Background["Bedroom"]:getHeight())
			/ Background["Bedroom"]:getWidth()
			* Ui.scale,
		math.max(Background["Bedroom"]:getWidth(), Background["Bedroom"]:getHeight())
			/ Background["Bedroom"]:getHeight()
			* Ui.scale,
		Background["Bedroom"]:getWidth() / 2,
		Background["Bedroom"]:getHeight() / 2
	)
	Ui:draw()
	Btnui:draw()
end
