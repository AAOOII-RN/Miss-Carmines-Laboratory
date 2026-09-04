function love.load()
	print("Game Starting...")
	love.graphics.setDefaultFilter("nearest")
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

	-- states
	OnState = "Blank"
	Sm:add("Blank", require("states.blank"))
	Sm:switch(OnState)

	-- images
	ShowBg = ""
	Background = {}
end

function Switch()
	print("Switched to: " .. OnState)
	for _, obj in pairs(Btnui.buttons) do
		obj.sleep = true
	end
	for _, obj in pairs(Ui.layerObj[OnState]) do
		if Btnui.buttons[OnState .. "-" .. obj.name] then
			Btnui.buttons[OnState .. "-" .. obj.name].sleep = false
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
	Btnui:draw()
	--Ui:draw()
end
