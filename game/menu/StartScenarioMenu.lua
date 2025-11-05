StartScenarioMenu = {}
StartScenarioMenu.__index = StartScenarioMenu

function StartScenarioMenu.new()
    local self = setmetatable({}, StartScenarioMenu)
    return self
end

function StartScenarioMenu:update(dt)
    T.number(dt)
end

function StartScenarioMenu:render()
    love.graphics.clear(0.09, 0.07, 0.07)
    love.graphics.setColor(1,1,1)
    love.graphics.printf("Start Scenario Menu", 0, love.graphics.getHeight() / 2 - 20, love.graphics.getWidth(), "center")
end

