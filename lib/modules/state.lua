--- Simple state machine manager.
local StateManager = {}
StateManager.__index = StateManager

function StateManager.new()
    return setmetatable({
        states = {},
        current = nil,
    }, StateManager)
end

function StateManager:add(name, state)
    self.states[name] = state
end

function StateManager:switch(name, ...)
    if self.current and self.current.exit then
        self.current:exit()
    end
    self.current = self.states[name]
    if self.current and self.current.enter then
        self.current:enter(...)
    end
end

function StateManager:update(dt)
    if self.current and self.current.update then
        self.current:update(dt)
    end
end

function StateManager:draw()
    if self.current and self.current.draw then
        self.current:draw()
    end
end

function StateManager:keypressed(key)
    if self.current and self.current.keypressed then
        self.current:keypressed(key)
    end
end

function StateManager:mousepressed(x, y, button)
    if self.current and self.current.mousepressed then
        self.current:mousepressed(x, y, button)
    end
end

return StateManager
