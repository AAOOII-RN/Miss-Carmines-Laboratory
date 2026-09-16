local ACTIONS = Object:extend()

function ACTIONS:new()
	self.options = {}
	self:makeOptions("Introduction", 19, { "Bedroom...", "Dining Table..." })
	self:makeOptions("Dining table", #Story["Dining table"], { "Next Chapter" })
	self:makeOptions("Bedroom", #Story["Bedroom"], { "Next Chapter" })
	self:makeOptions("Laboratory", #Story["Laboratory"], { "Next Chapter" })
	self:makeOptions("Laboratory 2", #Story["Laboratory 2"], { "Next Chapter" })
	self:makeOptions("Laboratory 3", #Story["Laboratory 3"], { "Refuse the syringe...", "Let her inject me..." })
end

function ACTIONS:makeOptions(chapter, scene, options)
	self.options[chapter .. "-" .. scene] = {}
	for i, option in pairs(options) do
		print(option)
		self.options[chapter .. "-" .. scene][option] = Btnui:newRect(
			chapter .. "-" .. scene .. "-" .. option,
			Ww / 2 - 150 * Ui.scale,
			Wh / 2 - 12.5 - 50 * (i - math.floor(#options / 2)),
			300 * Ui.scale,
			25 * Ui.scale,
			false
		)
	end
end

function ACTIONS:update(dt)
	CheckBtnui()
	for i, obj in pairs(self.options) do
		if i == Chapter .. "-" .. Scene then
			for j, v in pairs(obj) do
				print(j)
				v.sleep = false
			end
		end
	end
end

local function switchChapter(chapter)
	Chapter = chapter
	Scene = 1
end

function ACTIONS:mousepressed(mx, my)
	if Btnui:isHovered("Introduction-19-Dining Table...", mx, my) then
		switchChapter("Dining table")
	end
	if Btnui:isHovered("Introduction-19-Bedroom...", mx, my) then
		switchChapter("Bedroom")
	end

	if Btnui:isHovered("Dining table-" .. #Story["Dining table"] .. "-Next Chapter", mx, my) then
		switchChapter("Laboratory")
	end

	if Btnui:isHovered("Bedroom-" .. #Story["Bedroom"] .. "-Next Chapter", mx, my) then
		switchChapter("Laboratory")
	end

	if Btnui:isHovered("Laboratory-" .. #Story["Laboratory"] .. "-Next Chapter", mx, my) then
		switchChapter("Laboratory 2")
	end

	if Btnui:isHovered("Laboratory 2-" .. #Story["Laboratory 2"] .. "-Next Chapter", mx, my) then
		switchChapter("Laboratory 3")
	end

	if Btnui:isHovered("Laboratory 3-" .. #Story["Laboratory 3"] .. "-Let her inject me...", mx, my) then
		switchChapter("Succumbing to the probability")
	end
	if Btnui:isHovered("Laboratory 3-" .. #Story["Laboratory 3"] .. "-Refuse the syringe...", mx, my) then
		switchChapter("Strawberry Gelato")
	end
end

function ACTIONS:keypressed(key) end

function ACTIONS:draw() end

return ACTIONS
