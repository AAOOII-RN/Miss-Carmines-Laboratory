local UI_HANDLER = Object:extend()

function UI_HANDLER:new()
	Story = require("assets.tiled.Story")
	self.scale = math.min((Wh * 1.7777) / 800, (Ww * 0.5625) / 450)
	self.gapX = Ww / 2 - 800 * self.scale / 2
	self.gapY = Wh / 2 - 450 * self.scale / 2
end

function UI_HANDLER:mousepressed(mx, my)
	Scene = Scene + 1

	if Scene >= #Story[Chapter] then
		Scene = 1
	end
end

function UI_HANDLER:draw()
	for scene, obj in pairs(Story[Chapter]) do
		if scene == Scene then
			if obj[1] == "Miss Carmine" then
				love.graphics.setColor(1, 0.3411, 0.3411)
			elseif obj[1] == "#1430" or obj[1] == "???" then
				love.graphics.setColor(1, 0.8901, 0.7019)
			end
			if obj[1] ~= "" then
				love.graphics.printf(
					obj[1],
					320 * Ui.scale + Ui.gapX,
					304 * Ui.scale + Ui.gapY,
					160 * (30 / 21 / Ui.scale) * Ui.scale,
					"center",
					0,
					21 / 30 * Ui.scale
				)
				love.graphics.setColor(1, 1, 1, 1)
				love.graphics.printf(
					obj[2],
					67 * Ui.scale + Ui.gapX,
					338 * Ui.scale + Ui.gapY,
					664 * (30 / 12 / Ui.scale) * Ui.scale,
					"center",
					0,
					12 / 30 * Ui.scale
				)
			end
		end
	end
end

return UI_HANDLER
