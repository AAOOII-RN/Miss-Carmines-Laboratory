local utf8 = require("utf8")

local UI_HANDLER = Object:extend()

function UI_HANDLER:new()
	Story = require("assets.tiled.Script")
	self.scale = math.min((Wh * 1.7777) / 800, (Ww * 0.5625) / 450)
	self.gapX = Ww / 2 - 800 * self.scale / 2
	self.gapY = Wh / 2 - 450 * self.scale / 2
end

function UI_HANDLER:mousepressed(mx, my) end

local function utf8sub(str, n)
	local byteIndex = utf8.offset(str, n + 1)
	if byteIndex then
		return str:sub(1, byteIndex - 1)
	end
	return str
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
					utf8sub(obj[2], math.floor(Typewriter)),
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
	for id, btn in pairs(Btnui.buttons) do
		local hovered = Btnui:isHovered(id, love.mouse.getX(), love.mouse.getY()) and 5 or 0
		love.graphics.setColor(0.1, 0.1, 0.15, btn.sleep and 0 or 0.9)
		love.graphics.rectangle(
			"fill",
			btn.x - hovered,
			btn.y - hovered,
			btn.width + hovered * 2,
			btn.height + hovered * 2,
			16
		)
		love.graphics.setColor(1, 1, 1, btn.sleep and 0 or 1)
		love.graphics.printf(
			id:match("-([^-]+)$"),
			btn.x,
			btn.y + Font:getHeight() * 6 / 30 * Ui.scale,
			btn.width * (30 / 24 / Ui.scale) * Ui.scale,
			"center",
			0,
			12 / 30 * Ui.scale
		)
	end
end

return UI_HANDLER
