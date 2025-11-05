--- @class MainMenu The main menu of the game
MainMenu = {}
MainMenu.__index = MainMenu

function MainMenu.new()
    local self = setmetatable({}, MainMenu)

    -- Get screen dimensions for positioning
    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    -- Button dimensions and spacing
    local button_width = 300
    local button_height = 50
    local button_spacing = 20
    local total_height = (button_height * 5) + (button_spacing * 4)
    local start_y = (screen_height - total_height) / 2
    local center_x = (screen_width - button_width) / 2

    -- Create buttons for each menu option
    self.buttons = {
        Button.new(center_x, start_y, button_width, button_height, "Start New Camptrail", function()
            App.current_menu = App.MENUS.START_CAMP
        end),
        Button.new(center_x, start_y + (button_height + button_spacing) * 1, button_width, button_height, "Load Camptrail", function()
            App.current_menu = App.MENUS.LOAD_CAMP
        end),
        Button.new(center_x, start_y + (button_height + button_spacing) * 2, button_width, button_height, "Options", function()
            App.current_menu = App.MENUS.APP_SETTINGS
        end),
        Button.new(center_x, start_y + (button_height + button_spacing) * 3, button_width, button_height, "Credits", function()
            App.current_menu = App.MENUS.CREDITS
        end),
        Button.new(center_x, start_y + (button_height + button_spacing) * 4, button_width, button_height, "Exit", function()
            love.event.quit()
        end),
    }

    return self
end

function MainMenu:update(dt)
    T.number(dt)

    -- Update button states based on mouse position
    local mouse_x, mouse_y = love.mouse.getPosition()
    for _, button in ipairs(self.buttons) do
        button:update(mouse_x, mouse_y)
    end
end

function MainMenu:mouse_pressed(x, y, button)
    T.number(x)
    T.number(y)
    T.number(button)

    if button == 1 then -- Left mouse button
        for _, btn in ipairs(self.buttons) do
            if btn:is_clicked(x, y) then
                btn:click()
                break
            end
        end
    end
end

function MainMenu:render()
    -- Background
    love.graphics.clear(0.1, 0.1, 0.15)

    -- Title
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("MONDSPIEL", 0, 80, love.graphics.getWidth(), "center")
    love.graphics.printf("2D RTS Strategy Game", 0, 120, love.graphics.getWidth(), "center")

    -- Render all buttons
    for _, button in ipairs(self.buttons) do
        button:render()
    end

    -- Footer
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.printf("Use mouse to navigate", 0, love.graphics.getHeight() - 40, love.graphics.getWidth(), "center")
end