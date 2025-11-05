--- @class LoadCampMenu Menu for loading saved campaign trails
LoadCampMenu = {}
LoadCampMenu.__index = LoadCampMenu

function LoadCampMenu.new()
    local self = setmetatable({}, LoadCampMenu)

    -- Get screen dimensions for positioning
    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    -- Mock saved campaigns (will be loaded from files later)
    self.saved_campaigns = {
        {
            name = "Medieval Campaign - Save 1",
            date = "2025-11-05 14:30",
            desc = "Progress: 5/12 scenarios completed",
            faction = "Kingdom of Francia"
        },
        {
            name = "Landsknecht Era - Save 1",
            date = "2025-11-04 18:45",
            desc = "Progress: 2/8 scenarios completed",
            faction = "Holy Roman Empire"
        },
        {
            name = "Modern Warfare - Autosave",
            date = "2025-11-03 20:15",
            desc = "Progress: 8/10 scenarios completed",
            faction = "Allied Forces"
        },
    }
    self.selected_save = 1

    -- Create buttons
    local button_width = 200
    local button_height = 50
    local center_x = (screen_width - button_width) / 2

    self.load_button = Button.new(
        center_x - 110,
        screen_height - 100,
        button_width,
        button_height,
        "Load Save",
        function()
            -- TODO: Will load the selected save
            print("Loading save: " .. self.saved_campaigns[self.selected_save].name)
        end
    )

    self.delete_button = Button.new(
        center_x + 110,
        screen_height - 100,
        button_width,
        button_height,
        "Delete Save",
        function()
            -- TODO: Will delete the selected save
            print("Deleting save: " .. self.saved_campaigns[self.selected_save].name)
        end
    )

    self.back_button = Button.new(
        center_x,
        screen_height - 40,
        button_width,
        button_height,
        "Back",
        function()
            App.current_menu = App.MENUS.MAIN
        end
    )

    return self
end

function LoadCampMenu:update(dt)
    T.number(dt)

    -- Update button states
    local mouse_x, mouse_y = love.mouse.getPosition()
    self.load_button:update(mouse_x, mouse_y)
    self.delete_button:update(mouse_x, mouse_y)
    self.back_button:update(mouse_x, mouse_y)
end

function LoadCampMenu:key_pressed(key)
    T.string(key)

    -- Navigate through saved campaigns with arrow keys
    if key == "up" then
        self.selected_save = math.max(1, self.selected_save - 1)
    elseif key == "down" then
        self.selected_save = math.min(#self.saved_campaigns, self.selected_save + 1)
    end
end

function LoadCampMenu:mouse_pressed(x, y, button)
    T.number(x)
    T.number(y)
    T.number(button)

    if button == 1 then -- Left mouse button
        if self.load_button:is_clicked(x, y) then
            self.load_button:click()
        elseif self.delete_button:is_clicked(x, y) then
            self.delete_button:click()
        elseif self.back_button:is_clicked(x, y) then
            self.back_button:click()
        end

        -- Check if a save was clicked
        for i, save in ipairs(self.saved_campaigns) do
            local screen_width = love.graphics.getWidth()
            local save_y = 150 + (i - 1) * 120
            local save_x = screen_width / 2 - 300
            if x >= save_x and x <= save_x + 600 and
               y >= save_y and y <= save_y + 100 then
                self.selected_save = i
            end
        end
    end
end

function LoadCampMenu:render()
    -- Background
    love.graphics.clear(0.08, 0.08, 0.12)

    local screen_width = love.graphics.getWidth()

    -- Title
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("LOAD CAMPTRAIL", 0, 40, screen_width, "center")

    -- Description
    love.graphics.setColor(0.7, 0.7, 0.8)
    love.graphics.printf("Select a saved campaign to continue", 0, 80, screen_width, "center")

    -- Message if no saves
    if #self.saved_campaigns == 0 then
        love.graphics.setColor(0.8, 0.5, 0.5)
        love.graphics.printf("No saved campaigns found", 0, 250, screen_width, "center")
        love.graphics.setColor(0.6, 0.6, 0.7)
        love.graphics.printf("Start a new campaign trail to create a save", 0, 280, screen_width, "center")
    end

    -- Render saved campaign entries
    for i, save in ipairs(self.saved_campaigns) do
        local save_y = 150 + (i - 1) * 120
        local save_x = screen_width / 2 - 300

        -- Draw save box
        if i == self.selected_save then
            love.graphics.setColor(0.25, 0.35, 0.45)
        else
            love.graphics.setColor(0.15, 0.15, 0.2)
        end
        love.graphics.rectangle("fill", save_x, save_y, 600, 100, 4, 4)

        -- Draw border
        if i == self.selected_save then
            love.graphics.setColor(0.5, 0.7, 0.9)
        else
            love.graphics.setColor(0.3, 0.3, 0.4)
        end
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", save_x, save_y, 600, 100, 4, 4)

        -- Draw save details
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(save.name, save_x + 15, save_y + 12)

        love.graphics.setColor(0.6, 0.8, 1)
        love.graphics.print("Faction: " .. save.faction, save_x + 15, save_y + 38)

        love.graphics.setColor(0.7, 0.7, 0.8)
        love.graphics.print(save.desc, save_x + 15, save_y + 58)
        love.graphics.print("Last played: " .. save.date, save_x + 15, save_y + 78)
    end

    -- Render buttons
    if #self.saved_campaigns > 0 then
        self.load_button:render()
        self.delete_button:render()
    end
    self.back_button:render()

    -- Help text
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.printf("Use UP/DOWN arrows or click to select a save", 0, screen_width - 70, screen_width, "center")
end
