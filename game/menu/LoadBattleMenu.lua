LoadBattleMenu = {}
LoadBattleMenu.__index = LoadBattleMenu

function LoadBattleMenu.new()
    local self = setmetatable({}, LoadBattleMenu)
    self.selection = 1
    return self
end

function LoadBattleMenu:update(dt)
    T.number(dt)
    -- placeholder: could navigate list of saved battles
end

function LoadBattleMenu:render()
    love.graphics.clear(0.12, 0.12, 0.12)
    love.graphics.setColor(1,1,1)
    love.graphics.printf("Load Battle Menu", 0, love.graphics.getHeight() / 2 - 20, love.graphics.getWidth(), "center")
end

