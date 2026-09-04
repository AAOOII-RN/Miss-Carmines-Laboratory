local UI_HANDLER = Object:extend()

function UI_HANDLER:new()
	Uimap = require("assets.tiled.uimap")
	self.scale =
		math.min((Wh * Uimap.width / Uimap.height) / Uimap.width, (Ww * Uimap.height / Uimap.width) / Uimap.height)
	self.gapX = Ww / 2 - Uimap.width * self.scale / 2
	self.gapY = Wh / 2 - Uimap.height * self.scale / 2
	self.layerObj = {}
	self.groupObj = {}
	for _, group in pairs(Uimap.layers) do
		self.groupObj[group.name] = group
		self.layerObj[group.name] = {}
		for _, obj in pairs(group.objects) do
			self.layerObj[group.name][obj.name] = obj
			if obj.shape == "rectangle" then
				Btnui:newRect(
					group.name .. "-" .. obj.name,
					self.gapX + obj.x * self.scale,
					self.gapY + obj.y * self.scale,
					obj.width * self.scale,
					obj.height * self.scale,
					true
				)
			end
		end
	end
end

function UI_HANDLER:mousepressed(mx, my)
	for _, obj in pairs(Ui.layerObj[OnState]) do
		if Btnui:isHovered(OnState .. "-" .. obj.name, mx, my) and obj.type == "ButtonGoto" then
			OnState = obj.properties["goto"]
			Sm:switch(OnState)
		end
	end
end

function UI_HANDLER:draw()
	for _, obj in pairs(Ui.layerObj[OnState]) do
		if obj.type == "ButtonGoto" or obj.type == "Placeholder" then
			local feedback = Btnui:isHovered(OnState .. "-" .. obj.name, love.mouse.getX(), love.mouse.getY()) and 8
				or 0
			love.graphics.setColor(Pal[obj.properties["color"]])
			love.graphics.rectangle(
				"fill",
				obj.x * Ui.scale + Ui.gapX - feedback / 2,
				obj.y * Ui.scale + Ui.gapY - feedback / 2 + math.sin(Ticker * 2 + obj.id) * 5,
				obj.width * Ui.scale + feedback,
				obj.height * Ui.scale + feedback,
				obj.properties["roundness"] * Ui.scale
			)
		end
	end
end

return UI_HANDLER
