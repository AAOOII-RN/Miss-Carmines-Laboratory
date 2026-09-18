local SYRINGE = Object:extend()

function SYRINGE:new()
	self.size = 512
	self.grid = {}

	for x = 1, self.size do
		self.grid[x] = {}
		for y = 1, self.size do
			self.grid[x][y] = 0
		end
	end
end

function SYRINGE:mousepressed(mx, my) end

function SYRINGE:draw()
	for x = 1, self.size do
		for y = 1, self.size do
			love.graphics.rectangle("fill", x * 10 + Ww / 2 - self.size * 5, y * 10 + Ww / 2 - self.size * 5, 10, 10)
		end
	end
end

return SYRINGE
