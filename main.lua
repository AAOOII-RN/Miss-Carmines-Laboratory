function love.load()
	print("Game Starting...")
	Font = love.graphics.setNewFont("assets/fonts/font.ttf", 30)
	Ww, Wh = love.graphics.getDimensions()
	Ticker = 0

	-- Story
	Chapter = "Introduction"
	Scene = 1
	Typewriter = 0
	Handlifted = 0
	EnableClickNextScene = true
	Handwriting = {}
	MovingHandwriting = {}
	Blink = 0

	-- modules
	Flux = require("lib.modules.flux")
	Object = require("lib.modules.classic")
	Btnui = require("lib.modules.btnui")()
	Sm = require("lib.modules.state").new()
	Pal = require("lib.modules.palette")
	Voices = require("Processed.list")

	-- script
	require("states.syringe")
	require("states.paper")

	-- classes
	Ui = require("lib.classes.ui-handler")()
	Act = require("lib.classes.actions")()

	-- images
	local bg_path = "assets/img/background/"
	Gradient = love.graphics.newImage("assets/img/gradient.png")
	Img = {
		carmine = {
			img = love.graphics.newImage("assets/img/missCarms.png"),
			show = 0,
			x = 500,
			y = 0,
			jumpTimer = 0,
			scale = 1,
		},
		goo = {
			img = love.graphics.newImage("assets/img/goo.png"),
			show = 0,
		},
		redVignette = {
			img = love.graphics.newImage("assets/img/red vignette.png"),
			show = 0,
		},
		testPaper = {
			img = love.graphics.newImage("assets/img/test.png"),
			show = 0,
			vy = 0,
			y = 0,
		},
		damptest = {
			img = love.graphics.newImage("assets/img/damptest.png"),
			show = 0,
			y = 1500 - Wh,
		},
		bloodyhand = {
			img = love.graphics.newArrayImage({
				"assets/img/hand/hand.png",
				"assets/img/hand/hand1.png",
				"assets/img/hand/hand2.png",
				"assets/img/hand/hand3.png",
				"assets/img/hand/hand4.png",
				"assets/img/hand/hand5.png",
				"assets/img/hand/hand6.png",
				"assets/img/hand/hand7.png",
				"assets/img/hand/hand8.png",
				"assets/img/hand/hand9.png",
				"assets/img/hand/hand10.png",
			}),
			show = 0,
			index = 1,
			shaking = 0,
			y = 0,
		},
	}

	-- audio
	VoiceOvers = {}
	for chapter, v in pairs(Voices) do
		VoiceOvers[chapter] = {}
		for _, o in pairs(v) do
			VoiceOvers[chapter][o:match("([^/]+)%.mp3$")] = love.audio.newSource(o, "stream")
		end
	end
	love.audio.play(VoiceOvers["Introduction"]["I woke up"])

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
	for id, obj in pairs(Btnui.buttons) do
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
	Img.testPaper.vy = Img.testPaper.vy * 0.95

	if Img.testPaper.y < Wh - Img.testPaper.img:getHeight() * 0.8 * Ui.scale then
		Img.testPaper.vy = Img.testPaper.vy - 2
	end
	if Img.testPaper.y > 0 then
		Img.testPaper.vy = Img.testPaper.vy + 2
	end

	Flux.update(dt)
	Act:update(dt)
	Sm:update(dt)
end

function love.mousepressed(mx, my)
	if EnableClickNextScene then
		Scene = Scene + 1
		if Scene > #Story[Chapter] then
			Scene = #Story[Chapter]
		end
		Typewriter = 0
		love.audio.stop()
		if VoiceOvers[Chapter] then
			for id, v in pairs(VoiceOvers[Chapter]) do
				if string.find(Story[Chapter][Scene][2]:lower():gsub("[%p]", ""), string.lower(id):lower()) then
					love.audio.play(v)
				end
			end
		end
	end
	Act:mousepressed(mx, my)
	Sm:mousepressed(mx, my)
	Ui:mousepressed(mx, my)
end

function love.keypressed(key)
	Act:keypressed(key)
end

function love.wheelmoved(x, y)
	Act:wheelmoved(x, y)
end

function love.draw()
	local background = Story[Chapter][Scene][3]

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.push("transform")
	love.graphics.translate((Ww / 2 - love.mouse.getX()) * 0.04, (Wh / 2 - love.mouse.getY()) * 0.02)
	love.graphics.draw(
		Background[background],
		Ww / 2 + math.random() * Img.bloodyhand.shaking / 5,
		Wh / 2 + math.random() * Img.bloodyhand.shaking / 5,
		0,
		1.2 * math.max(Ww / Background[background]:getWidth(), Wh / Background[background]:getHeight()),
		1.2 * math.max(Ww / Background[background]:getWidth(), Wh / Background[background]:getHeight()),
		Background[background]:getWidth() / 2,
		Background[background]:getHeight() / 2
	)
	love.graphics.translate((Ww / 2 - love.mouse.getX()) * 0.06, (Wh / 2 - love.mouse.getY()) * 0.03)
	local Carmine = Img.carmine.img
	love.graphics.setColor(1, 1, 1, Img.carmine.show)
	love.graphics.draw(
		Carmine,
		Ww / 2 + Img.carmine.x * Ui.scale,
		8 * Wh / 8 + Img.carmine.y * Ui.scale - 100 * math.abs(math.sin(Img.carmine.jumpTimer * math.pi)) * Ui.scale,
		0,
		math.max(Ww / Carmine:getWidth(), Wh / Carmine:getHeight()) * Ui.scale * 0.15 * Img.carmine.scale,
		math.max(Ww / Carmine:getWidth(), Wh / Carmine:getHeight()) * Ui.scale * 0.15 * Img.carmine.scale,
		Carmine:getWidth() / 2,
		Carmine:getHeight() / 2
	)
	local dampTest = Img.damptest.img
	love.graphics.setColor(1, 1, 1, Img.damptest.show)
	love.graphics.draw(
		dampTest,
		Ww / 2,
		Wh / 2 + Img.damptest.y,
		0,
		0.3 * Ui.scale,
		0.3 * Ui.scale,
		dampTest:getWidth() / 2,
		dampTest:getHeight() / 2
	)

	local bloodyhand = Img.bloodyhand.img
	love.graphics.setColor(1, 1, 1, Img.bloodyhand.show)
	love.graphics.drawLayer(
		bloodyhand,
		Img.bloodyhand.index,
		Ww / 2 + math.random() * Img.bloodyhand.shaking,
		Wh / 2 + math.random() * Img.bloodyhand.shaking + Img.bloodyhand.y * Ui.scale,
		0,
		1 * Ui.scale,
		1 * Ui.scale,
		bloodyhand:getWidth() / 2,
		bloodyhand:getHeight() / 2
	)
	love.graphics.pop()

	local Goo = Img.goo.img
	love.graphics.setColor(1, 1, 1, Img.goo.show * 0.75)
	love.graphics.draw(
		Goo,
		Ww / 2 + math.sin(7 * Ticker / 10) * Ui.scale * 500,
		Wh / 2 + math.cos(5 * Ticker / 10) * Ui.scale * 500,
		0,
		math.max(Ww / Goo:getWidth(), Wh / Goo:getHeight()) * Ui.scale * 2,
		math.max(Ww / Goo:getWidth(), Wh / Goo:getHeight()) * Ui.scale * 2,
		Goo:getWidth() / 2,
		Goo:getHeight() / 2
	)

	local redVignette = Img.redVignette.img
	love.graphics.setColor(
		0.7,
		0.7,
		0.7,
		Img.redVignette.show * (0.9 + 0.1 * math.sin(Ticker * Img.redVignette.show * 4) ^ 2)
	)
	love.graphics.draw(
		redVignette,
		Ww / 2,
		Wh / 2,
		0,
		math.max(Ww / Goo:getWidth(), Wh / Goo:getHeight()) * Ui.scale,
		math.max(Ww / Goo:getWidth(), Wh / Goo:getHeight()) * Ui.scale,
		redVignette:getWidth() / 2,
		redVignette:getHeight() / 2
	)

	local testPaper = Img.testPaper.img
	love.graphics.setColor(1, 1, 1, Img.testPaper.show)
	love.graphics.draw(testPaper, Ww / 2, Img.testPaper.y, 0, 0.8 * Ui.scale, 0.8 * Ui.scale, testPaper:getWidth() / 2)

	love.graphics.setColor(0.1, 0.1, 0.15, Img.testPaper.show)
	for a, v in pairs(Handwriting) do
		MovingHandwriting[a] = {}
		for b, y in pairs(v) do
			table.insert(MovingHandwriting[a], b, y + Img.testPaper.y * math.fmod(b + 1, 2))
		end
	end

	for _, scribble in pairs(MovingHandwriting) do
		if #scribble >= 4 then
			love.graphics.line(scribble)
		end
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
	love.graphics.setColor(0, 0, 0, math.abs(math.sin(Blink * math.pi)))
	love.graphics.rectangle("fill", 0, 0, Ww, Wh)

	Act:draw()
	Ui:draw()
	--Btnui:draw()
	love.graphics.setColor(1, 1, 1, 1)
end
