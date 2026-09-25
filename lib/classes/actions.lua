local ACTIONS = Object:extend()

function ACTIONS:new()
	mxdist, mydist = 0, 0
	self.options = {}
	self:makeOptions("Introduction", #Story["Introduction"], { "Bedroom...", "Dining Table..." })
	self:makeOptions("Laboratory 3", #Story["Laboratory 3"], { "Refuse the syringe...", "Let her inject me..." })

	self.finishTest =
		Btnui:newRect("Laboratory-39-Finish", Ww - 157 * Ui.scale, Wh - 117 * Ui.scale, 67 * Ui.scale, 25 * Ui.scale)
end

function ACTIONS:makeOptions(chapter, scene, options)
	self.options[chapter .. "-" .. scene] = {}
	for i, option in pairs(options) do
		self.options[chapter .. "-" .. scene][option] = Btnui:newRect(
			chapter .. "-" .. scene .. "-" .. option,
			Ww / 2 - 150 * Ui.scale,
			Wh / 2 - 12.5 - 60 * (i - math.floor(#options / 2)),
			300 * Ui.scale,
			25 * Ui.scale,
			false
		)
	end
end

function ACTIONS:update(dt)
	CheckBtnui()
	if VoiceOvers[Chapter] then
		for i, obj in pairs(self.options) do
			if i == Chapter .. "-" .. Scene then
				for j, v in pairs(obj) do
					print(j)
					v.sleep = false
				end
			end
		end
	end

	if Chapter == "Laboratory" and Scene == 39 then
		if love.mouse.isDown(1) then
			if math.sqrt((mxdist - love.mouse.getX()) ^ 2 + (mydist - love.mouse.getY()) ^ 2) > 5 then
				table.insert(Handwriting[Handlifted], love.mouse.getX())
				table.insert(Handwriting[Handlifted], love.mouse.getY() - Img.testPaper.y)
				mxdist, mydist = love.mouse.getX(), love.mouse.getY()
			end
		end
	end

	if Chapter == "Introduction" then
		if Scene == 5 then
			Flux.to(Img.carmine, 3, { x = 0, jumpTimer = 2 }):ease("expoout")
			Flux.to(Img.carmine, 1.5, { show = 1 }):ease("expoout")
		end
		if Scene == 7 then
			Flux.to(Img.goo, 1, { show = 0 })
		end
		if Scene == 8 then
			Flux.to(Img.carmine, 2, { y = 200, scale = 2 }):ease("backinout")
		end
		if Scene == 12 then
			Flux.to(Img.carmine, 1, { y = 0, scale = 1 }):ease("expoout")
		end
	end
	if Chapter == "Dining table" then
		if Scene == 1 then
			Img.carmine.show = 0
		end
		if Scene == 3 then
			Flux.to(Img.carmine, 1.5, { show = 1 }):ease("expoout")
		end
	end
	if Chapter == "Laboratory" then
		if Scene == 1 then
			Img.carmine.show = 0
		end
		if Scene == 6 then
			Img.goo.show = 1
		end
		if Scene == 9 then
			Flux.to(Img.carmine, 1.5, { show = 1 }):ease("expoout")
			Flux.to(Img.goo, 1, { show = 0 })
		end
		if Scene == 32 then
			Img.carmine.show = 0
		end
		if Scene == 33 then
			Flux.to(Img.carmine, 1.5, { show = 1 }):ease("expoout")
		end
		if Scene == 34 then
			Img.carmine.show = 0
		end
		if Scene == 35 then
			Img.carmine.show = 0
		end
		if Scene == 36 then
			Flux.to(Img.carmine, 1.5, { show = 1 }):ease("expoout")
		end
		if Scene == 39 then
			self.finishTest.sleep = false
			Flux.to(Img.testPaper, 2, { show = 1 }):ease("expoout")
			Img.testPaper.y = Img.testPaper.y - Img.testPaper.vy
		end
	end
	if Chapter == "Laboratory 2" then
		if Scene == 1 then
			self.finishTest.sleep = true
			Img.carmine.show = 0
			Flux.to(Img.testPaper, 0.5, { show = 0 })
			Flux.to(Img.damptest, 2, { y = 0, show = 1 }):ease("backout")
		end
		if Scene == 3 then
			Flux.to(Img.damptest, 0.5, { show = 0 })
			Img.bloodyhand.show = 1
		end
		if Scene == 4 then
			Img.bloodyhand.index = 2
		end
		if Scene == 6 then
			Flux.to(Img.bloodyhand, 15, { index = 10, shaking = 20 }):ease("expoout")
			Flux.to(Img.redVignette, 15, { show = 1 }):ease("expoout")
		end
		if Scene == 9 then
			Flux.to(Img.carmine, 1.5, { show = 1 }):ease("expoout")
			Flux.to(Img.bloodyhand, 1, { y = 1500 - Wh, show = 0 }):ease("expoout")
		end
		if Scene == 11 then
			Img.carmine.show = 0
		end
		if Scene == 15 then
			Flux.to(Img.goo, 1, { show = 1 })
		end
	end
	if Chapter == "Laboratory 3" then
		if Scene == 1 then
			Img.carmine.show = 1
			Img.bloodyhand.shaking = 0
			Img.redVignette.show = 0
		end
		if Scene == 2 then
			Flux.to(Img.goo, 1, { show = 0 })
		end
	end
	if Chapter == "Strawberry gelato" then
		if Scene == 26 then
			Flux.to(Img.carmine, 1, { y = 800 }):ease("expoout")
		end
		if Scene == 27 then
			Img.carmine.show = 0
		end
	end
end

local function switchChapter(chapter)
	if not Story[chapter] then
		print("Unknown chapter:", tostring(chapter))
		return
	end

	Chapter = chapter
	Scene = 1
	if VoiceOvers[Chapter] then
		for id, v in pairs(VoiceOvers[Chapter]) do
			if Story[Chapter][Scene] and Story[Chapter][Scene][2] then
				if string.find(Story[Chapter][Scene][2]:lower():gsub("[%p]", ""), string.lower(id):lower()) then
					love.audio.play(v)
				end
			end
		end
	end
end

function ACTIONS:mousepressed(mx, my)
	if Btnui:isHovered("Introduction-18-Dining Table...", mx, my) then
		switchChapter("Dining table")
	end
	if Btnui:isHovered("Introduction-18-Bedroom...", mx, my) then
		switchChapter("Bedroom")
	end

	if Chapter == "Dining table" and Scene == #Story["Dining table"] then
		switchChapter("Laboratory")
	end

	if Chapter == "Bedroom" and Scene == #Story["Bedroom"] then
		switchChapter("Laboratory")
	end

	if Btnui:isHovered("Laboratory-39-Finish", mx, my) then
		switchChapter("Laboratory 2")
	end

	if Chapter == "Laboratory 2" and Scene == #Story["Laboratory 2"] then
		switchChapter("Laboratory 3")
	end

	if Chapter == "Laboratory 3" and Scene == #Story["Laboratory 3"] then
		switchChapter("Strawberry gelato")
	end
	if Chapter == "Laboratory" and Scene == 39 then
		Handlifted = Handlifted + 1
		Handwriting[Handlifted] = {}
	end
end

function ACTIONS:keypressed(key) end

function ACTIONS:wheelmoved(x, y)
	Img.testPaper.vy = Img.testPaper.vy - y * 10
end

function ACTIONS:draw() end

return ACTIONS
