StartCampMenu = {}
StartCampMenu.__index = StartCampMenu

function StartCampMenu.new()
    local self = setmetatable({}, StartCampMenu)
    return self
end

function StartCampMenu:update(dt)
    T.number(dt)
end

function StartCampMenu:render()
    love.graphics.clear(0.09, 0.09, 0.09)
    love.graphics.setColor(1,1,1)
    love.graphics.printf("Start Campaign Menu", 0, love.graphics.getHeight() / 2 - 20, love.graphics.getWidth(), "center")
end

