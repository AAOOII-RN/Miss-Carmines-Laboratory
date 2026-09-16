function love.load()
	print("Game Starting...")
	Font = love.graphics.setNewFont("assets/fonts/font.ttf", 30)
	Ww, Wh = love.graphics.getDimensions()
	Ticker = 0

	-- Story
	Chapter = "Introduction"
	Scene = 1
	Typewriter = 0

	-- modules
	Object = require("lib.modules.classic")
	Btnui = require("lib.modules.btnui")()
	Sm = require("lib.modules.state").new()
	Pal = require("lib.modules.palette")

	-- classes
	Ui = require("lib.classes.ui-handler")()
	Act = require("lib.classes.actions")()

	-- states
	OnState = "Blank"
	Sm:add("Blank", require("states.blank"))
	Sm:switch(OnState)

	-- images
	local bg_path = "assets/img/Background/"
	Gradient = love.graphics.newImage("assets/img/gradient.png")
	Carmine = love.graphics.newImage("assets/img/missCarms.png")
	CarmineShow = false
	Goo = love.graphics.newImage("assets/img/goo.png")
	GooShow = true
	Background = {
		["Dining table"] = love.graphics.newImage(bg_path .. "Dining table.png"),
		["Laboratory"] = love.graphics.newImage(bg_path .. "Laboratory.png"),
		["Bloodied hallway"] = love.graphics.newImage(bg_path .. "Bloodied hallway.png"),
		["Hallway"] = love.graphics.newImage(bg_path .. "Hallway.png"),
		["Laboratory floor"] = love.graphics.newImage(bg_path .. "Laboratory floor.png"),
		["Test room"] = love.graphics.newImage(bg_path .. "Test room.png"),
		["Bedroom"] = love.graphics.newImage(bg_path .. "Bedroom.png"),
	}
	print(#Story["Dining table"])
end

function CheckBtnui()
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
	Typewriter = Typewriter + dt * 45

	if Scene > #Story[Chapter] then
		Scene = #Story[Chapter]
	elseif Scene < 1 then
		Scene = 1
	end

	Act:update(dt)
	Sm:update(dt)
end

function love.mousepressed(mx, my)
	Act:mousepressed(mx, my)
	Sm:mousepressed(mx, my)
	Ui:mousepressed(mx, my)
end

function love.keypressed(key)
	if key == "right" then
		Scene = Scene + 1
		Typewriter = 0
	elseif key == "left" then
		Scene = Scene - 1
		Typewriter = 0
	end

	Act:keypressed(key)
end

function love.draw()
	local background = Story[Chapter][Scene][3]

	love.graphics.push("transform")
	love.graphics.translate((Ww / 2 - love.mouse.getX()) * 0.02, (Wh / 2 - love.mouse.getY()) * 0.02)
	love.graphics.draw(
		Background[background],
		Ww / 2,
		Wh / 2,
		0,
		1.2 * math.max(Ww / Background[background]:getWidth(), Wh / Background[background]:getHeight()),
		1.2 * math.max(Ww / Background[background]:getWidth(), Wh / Background[background]:getHeight()),
		Background[background]:getWidth() / 2,
		Background[background]:getHeight() / 2
	)
	love.graphics.translate((Ww / 2 - love.mouse.getX()) * 0.03, (Wh / 2 - love.mouse.getY()) * 0.03)
	if CarmineShow then
		love.graphics.draw(
			Carmine,
			Ww / 2,
			8 * Wh / 8,
			0,
			math.max(Ww / Carmine:getWidth(), Wh / Carmine:getHeight()) * Ui.scale * 0.15,
			math.max(Ww / Carmine:getWidth(), Wh / Carmine:getHeight()) * Ui.scale * 0.15,
			Carmine:getWidth() / 2,
			Carmine:getHeight() / 2
		)
	end
	love.graphics.pop()
	if GooShow then
		love.graphics.setColor(1, 1, 1, 0.75)
		love.graphics.draw(
			Goo,
			Ww / 2,
			Wh / 2,
			0,
			math.max(Ww / Goo:getWidth(), Wh / Goo:getHeight()),
			math.max(Ww / Goo:getWidth(), Wh / Goo:getHeight()),
			Goo:getWidth() / 2,
			Goo:getHeight() / 2
		)
		love.graphics.setColor(1, 1, 1, 1)
	end

	love.graphics.setColor(1, 1, 1)
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

	Act:draw()
	Ui:draw()
	Btnui:draw()
end
