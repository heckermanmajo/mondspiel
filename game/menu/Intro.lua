IntroMenu = {}
IntroMenu.__index = IntroMenu

function IntroMenu.new()
    local self = setmetatable({}, IntroMenu)
    self.time_til_end = 5.0
    return self
end

function IntroMenu:update(dt)
    T.number(dt)
    self.time_til_end = self.time_til_end - dt
    if self.time_til_end <= 0 then
        App.current_menu = App.MENUS.MAIN
    end
end

function IntroMenu:render()
    love.graphics.clear(0, 0, 0)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Welcome to the Game!", 0, love.graphics.getHeight() / 2 - 20, love.graphics.getWidth(), "center")
    love.graphics.printf("Loading...", 0, love.graphics.getHeight() / 2 + 20, love.graphics.getWidth(), "center")
end