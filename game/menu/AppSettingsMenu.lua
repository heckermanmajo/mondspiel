--- @class AppSettingsMenu Menu for application settings
AppSettingsMenu = {}
AppSettingsMenu.__index = AppSettingsMenu

function AppSettingsMenu.new()
    local self = setmetatable({}, AppSettingsMenu)

    -- Mock settings (will be connected to actual game settings later)
    self.options = {
        { name = "Master Volume", value = 100, min = 0, max = 100, type = "slider" },
        { name = "Music Volume", value = 80, min = 0, max = 100, type = "slider" },
        { name = "SFX Volume", value = 90, min = 0, max = 100, type = "slider" },
        { name = "Fullscreen", value = false, type = "toggle" },
        { name = "VSync", value = true, type = "toggle" },
        { name = "Show FPS", value = true, type = "toggle" },
        { name = "Resolution", value = "1280x720", type = "text" },
    }
    self.selected_option = 1

    -- Get screen dimensions for positioning
    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    -- Create buttons
    local button_width = 200
    local button_height = 50
    local center_x = (screen_width - button_width) / 2

    self.apply_button = Button.new(
        center_x - 110,
        screen_height - 100,
        button_width,
        button_height,
        "Apply Settings",
        function()
            -- TODO: Will apply settings to the game
            print("Applying settings...")
        end
    )

    self.back_button = Button.new(
        center_x + 110,
        screen_height - 100,
        button_width,
        button_height,
        "Back",
        function()
            App.current_menu = App.MENUS.MAIN
        end
    )

    return self
end

function AppSettingsMenu:update(dt)
    T.number(dt)

    -- Update button states
    local mouse_x, mouse_y = love.mouse.getPosition()
    self.apply_button:update(mouse_x, mouse_y)
    self.back_button:update(mouse_x, mouse_y)
end

function AppSettingsMenu:key_pressed(key)
    T.string(key)

    local option = self.options[self.selected_option]

    -- Navigate through options with arrow keys
    if key == "up" then
        self.selected_option = math.max(1, self.selected_option - 1)
    elseif key == "down" then
        self.selected_option = math.min(#self.options, self.selected_option + 1)
    elseif key == "left" then
        -- Decrease value for sliders
        if option.type == "slider" then
            option.value = math.max(option.min, option.value - 5)
        elseif option.type == "toggle" then
            option.value = not option.value
        end
    elseif key == "right" then
        -- Increase value for sliders
        if option.type == "slider" then
            option.value = math.min(option.max, option.value + 5)
        elseif option.type == "toggle" then
            option.value = not option.value
        end
    elseif key == "space" or key == "return" then
        -- Toggle boolean options
        if option.type == "toggle" then
            option.value = not option.value
        end
    end
end

function AppSettingsMenu:mouse_pressed(x, y, button)
    T.number(x)
    T.number(y)
    T.number(button)

    if button == 1 then -- Left mouse button
        if self.apply_button:is_clicked(x, y) then
            self.apply_button:click()
        elseif self.back_button:is_clicked(x, y) then
            self.back_button:click()
        end

        -- Check if an option was clicked
        for i, option in ipairs(self.options) do
            local screen_width = love.graphics.getWidth()
            local option_y = 150 + (i - 1) * 50
            local option_x = screen_width / 2 - 300
            if x >= option_x and x <= option_x + 600 and
               y >= option_y and y <= option_y + 40 then
                self.selected_option = i

                -- Toggle if it's a toggle type
                if option.type == "toggle" then
                    option.value = not option.value
                end
            end
        end
    end
end

function AppSettingsMenu:render()
    -- Background
    love.graphics.clear(0.05, 0.05, 0.08)

    local screen_width = love.graphics.getWidth()

    -- Title
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("OPTIONS", 0, 40, screen_width, "center")

    -- Description
    love.graphics.setColor(0.7, 0.7, 0.8)
    love.graphics.printf("Configure game settings", 0, 80, screen_width, "center")

    -- Render options
    for i, option in ipairs(self.options) do
        local option_y = 150 + (i - 1) * 50
        local option_x = screen_width / 2 - 300

        -- Highlight selected option
        if i == self.selected_option then
            love.graphics.setColor(0.2, 0.3, 0.4, 0.5)
            love.graphics.rectangle("fill", option_x, option_y, 600, 40, 2, 2)
        end

        -- Draw option name
        if i == self.selected_option then
            love.graphics.setColor(1, 1, 0.8)
        else
            love.graphics.setColor(1, 1, 1)
        end
        love.graphics.print(option.name, option_x + 10, option_y + 10)

        -- Draw option value based on type
        if option.type == "slider" then
            -- Draw slider bar
            love.graphics.setColor(0.3, 0.3, 0.4)
            love.graphics.rectangle("fill", option_x + 400, option_y + 15, 180, 10, 2, 2)

            -- Draw slider fill
            local fill_width = (option.value - option.min) / (option.max - option.min) * 180
            love.graphics.setColor(0.4, 0.6, 0.8)
            love.graphics.rectangle("fill", option_x + 400, option_y + 15, fill_width, 10, 2, 2)

            -- Draw value text
            love.graphics.setColor(0.8, 0.8, 0.9)
            love.graphics.print(tostring(option.value), option_x + 350, option_y + 10)
        elseif option.type == "toggle" then
            -- Draw toggle indicator
            local toggle_text = option.value and "[ON]" or "[OFF]"
            if option.value then
                love.graphics.setColor(0.4, 0.8, 0.4)
            else
                love.graphics.setColor(0.8, 0.4, 0.4)
            end
            love.graphics.print(toggle_text, option_x + 400, option_y + 10)
        else
            -- Draw text value
            love.graphics.setColor(0.7, 0.7, 0.8)
            love.graphics.print(tostring(option.value), option_x + 400, option_y + 10)
        end
    end

    -- Render buttons
    self.apply_button:render()
    self.back_button:render()

    -- Help text
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.printf("Use arrow keys to navigate and adjust values, or click with mouse", 0, love.graphics.getHeight() - 40, screen_width, "center")
end
