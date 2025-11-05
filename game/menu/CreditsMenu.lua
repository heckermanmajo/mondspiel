--- @class CreditsMenu Display game credits
CreditsMenu = {}
CreditsMenu.__index = CreditsMenu

function CreditsMenu.new()
    local self = setmetatable({}, CreditsMenu)

    -- Get screen dimensions for positioning
    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    -- Create back button
    local button_width = 200
    local button_height = 50
    local center_x = (screen_width - button_width) / 2

    self.back_button = Button.new(
        center_x,
        screen_height - 100,
        button_width,
        button_height,
        "Back to Main Menu",
        function()
            App.current_menu = App.MENUS.MAIN
        end
    )

    return self
end

function CreditsMenu:update(dt)
    T.number(dt)

    -- Update button state based on mouse position
    local mouse_x, mouse_y = love.mouse.getPosition()
    self.back_button:update(mouse_x, mouse_y)
end

function CreditsMenu:mouse_pressed(x, y, button)
    T.number(x)
    T.number(y)
    T.number(button)

    if button == 1 then -- Left mouse button
        if self.back_button:is_clicked(x, y) then
            self.back_button:click()
        end
    end
end

function CreditsMenu:render()
    -- Background
    love.graphics.clear(0.08, 0.08, 0.12)

    local screen_width = love.graphics.getWidth()
    local y = 60

    -- Title
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("CREDITS", 0, y, screen_width, "center")
    y = y + 60

    -- Credits sections
    love.graphics.setColor(0.9, 0.9, 1)

    love.graphics.printf("GAME DESIGN & PROGRAMMING", 0, y, screen_width, "center")
    y = y + 30
    love.graphics.printf("heckermanmajo", 0, y, screen_width, "center")
    y = y + 50

    love.graphics.printf("POWERED BY", 0, y, screen_width, "center")
    y = y + 30
    love.graphics.printf("LÖVE2D Game Framework", 0, y, screen_width, "center")
    y = y + 30
    love.graphics.printf("Lua Programming Language", 0, y, screen_width, "center")
    y = y + 50

    love.graphics.printf("SPECIAL THANKS", 0, y, screen_width, "center")
    y = y + 30
    love.graphics.printf("To the LÖVE2D community", 0, y, screen_width, "center")
    y = y + 30
    love.graphics.printf("And all contributors", 0, y, screen_width, "center")
    y = y + 50

    love.graphics.setColor(0.6, 0.6, 0.7)
    love.graphics.printf("© 2025 MONDSPIEL", 0, y, screen_width, "center")

    -- Render back button
    self.back_button:render()
end
