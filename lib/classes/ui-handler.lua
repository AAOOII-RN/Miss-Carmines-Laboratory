local UI_HANDLER = Object:extend()

function UI_HANDLER:new()
	Story = require("assets.tiled.Story")
	self.scale =
		math.min((Wh * Story.width / Story.height) / Story.width, (Ww * Story.height / Story.width) / Story.height)
	self.gapX = Ww / 2 - Story.width * self.scale / 2
	self.gapY = Wh / 2 - Story.height * self.scale / 2

	self.chapters = {}
	self.scenes = {}
	self.elements = {}

	print("Setting up the story...")
	for _, chapters in pairs(Story.layers) do
		self.chapters[chapters.name] = chapters
		self.scenes[chapters.name] = {}
		self.elements[chapters.name] = {}
		print("# " .. chapters.name)
		for _, scenes in pairs(chapters.layers) do
			self.scenes[chapters.name][scenes.name] = scenes
			self.elements[chapters.name][scenes.name] = {}
			self.elements[chapters.name][scenes.name].text = {}
			print("---# " .. scenes.name)
			for _, elements in pairs(scenes.objects) do
				if elements.shape == "text" then
					self.elements[chapters.name][scenes.name].text[elements.name] = elements
				elseif elements.shape == "rectangle" then
					Btnui:newRect(
						chapters.name .. "-" .. scenes.name .. "-" .. elements.name,
						self.gapX + elements.x * self.scale,
						self.gapY + elements.y * self.scale,
						elements.width * self.scale,
						elements.height * self.scale,
						true
					)
				elseif elements.name == "Line" then
					self.elements[chapters.name][scenes.name].line = elements.y
				end
				print("------# " .. elements.shape .. "-" .. elements.name)
			end
		end
	end
end

function UI_HANDLER:mousepressed(mx, my)
	for _, obj in pairs(Ui.scenes[Chapter][Scene].objects) do
		if Btnui:isHovered(OnState .. "-" .. obj.name, mx, my) and obj.type == "ButtonGoto" then
			OnState = obj.properties["goto"]
			Sm:switch(OnState)
		end
	end
end

function UI_HANDLER:draw()
	for _, obj in pairs(Ui.scenes[Chapter][Scene].objects) do
		if obj.type == "ButtonGoto" or obj.type == "Placeholder" then
			local feedback = Btnui:isHovered(OnState .. "-" .. obj.name, love.mouse.getX(), love.mouse.getY()) and 8
				or 0
			love.graphics.setColor(Pal[obj.properties["color"]])
			love.graphics.rectangle(
				"fill",
				obj.x * Ui.scale + Ui.gapX - feedback / 2,
				obj.y * Ui.scale + Ui.gapY - feedback / 2,
				obj.width * Ui.scale + feedback,
				obj.height * Ui.scale + feedback,
				obj.properties["roundness"] * Ui.scale
			)
			love.graphics.setColor(1, 1, 1, 1)
		end
		if obj.shape == "text" then
			--[[
			local text = self.scenes[Chapter][Scene].textSettings
			love.graphics.printf(
				text.text,
				text.x * Ui.scale + Ui.gapX,
				text.y * Ui.scale + Ui.gapY,
				text.width * (100 / text.pixelsize / Ui.scale) * Ui.scale,
				text.halign,
				0,
				text.pixelsize / 100 * Ui.scale
			)
      ]]
			local speaker = self.elements[Chapter][Scene].text["Speaker"]
			local dialogue = self.elements[Chapter][Scene].text["Dialogue"]
			local line = self.elements[Chapter][Scene].line
			love.graphics.setColor(love.math.colorFromBytes(unpack(speaker.color)))
			love.graphics.printf(
				speaker.text,
				speaker.x * Ui.scale + Ui.gapX,
				speaker.y * Ui.scale + Ui.gapY,
				speaker.width * (100 / speaker.pixelsize / Ui.scale) * Ui.scale,
				speaker.halign,
				0,
				speaker.pixelsize / 100 * Ui.scale
			)
			love.graphics.setColor(love.math.colorFromBytes(unpack(dialogue.color)))
			love.graphics.printf(
				dialogue.text,
				dialogue.x * Ui.scale + Ui.gapX,
				dialogue.y * Ui.scale + Ui.gapY,
				dialogue.width * (100 / dialogue.pixelsize / Ui.scale) * Ui.scale,
				dialogue.halign,
				0,
				dialogue.pixelsize / 100 * Ui.scale
			)
			love.graphics.setColor(0, 0, 0, 1)
			love.graphics.line(60 * Ui.scale, line * Ui.scale, Ww - 60 * Ui.scale, line * Ui.scale)
			love.graphics.draw(
				Gradient,
				Ww / 2,
				Wh / 2,
				0,
				math.max(Gradient:getWidth(), Gradient:getHeight()) / Gradient:getWidth() * Ui.scale,
				math.max(Gradient:getWidth(), Gradient:getHeight()) / Gradient:getHeight() * Ui.scale,
				Gradient:getWidth() / 2,
				Gradient:getHeight() / 2
			)
		end
	end
end

return UI_HANDLER
