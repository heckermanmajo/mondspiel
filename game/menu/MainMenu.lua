MainMenu = {}
MainMenu.__index = MainMenu

function MainMenu.new()
    local self = setmetatable({}, MainMenu)
    -- Initialize main menu properties here
    return self
end

function MainMenu:update(dt)
    T.number(dt)
end

function MainMenu:render()
    love.graphics.clear(0.1, 0.1, 0.1)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Main Menu", 0, love.graphics.getHeight() / 2 - 40, love.graphics.getWidth(), "center")
    love.graphics.printf("Press Enter to Start Battle", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
end