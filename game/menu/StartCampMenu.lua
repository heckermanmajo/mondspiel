--- @class StartCampMenu Menu for starting a new campaign trail
StartCampMenu = {}
StartCampMenu.__index = StartCampMenu

function StartCampMenu.new()
    local self = setmetatable({}, StartCampMenu)

    -- Get screen dimensions for positioning
    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    -- Button dimensions
    local button_width = 250
    local button_height = 50

    -- Mock campaign options
    self.campaigns = {
        {name = "Medieval Campaign", desc = "Fight through the Middle Ages"},
        {name = "Landsknecht Era", desc = "Renaissance mercenary warfare"},
        {name = "Modern Warfare", desc = "Contemporary military conflicts"},
    }
    self.selected_campaign = 1

    -- Create buttons
    local center_x = (screen_width - button_width) / 2

    self.start_button = Button.new(
        center_x - 130,
        screen_height - 100,
        button_width,
        button_height,
        "Start Campaign",
        function()
            -- TODO: Will start the selected campaign
            print("Starting campaign: " .. self.campaigns[self.selected_campaign].name)
        end
    )

    self.back_button = Button.new(
        center_x + 130,
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

function StartCampMenu:update(dt)
    T.number(dt)

    -- Update button states
    local mouse_x, mouse_y = love.mouse.getPosition()
    self.start_button:update(mouse_x, mouse_y)
    self.back_button:update(mouse_x, mouse_y)
end

function StartCampMenu:key_pressed(key)
    T.string(key)

    -- Navigate through campaigns with arrow keys
    if key == "up" then
        self.selected_campaign = math.max(1, self.selected_campaign - 1)
    elseif key == "down" then
        self.selected_campaign = math.min(#self.campaigns, self.selected_campaign + 1)
    end
end

function StartCampMenu:mouse_pressed(x, y, button)
    T.number(x)
    T.number(y)
    T.number(button)

    if button == 1 then -- Left mouse button
        if self.start_button:is_clicked(x, y) then
            self.start_button:click()
        elseif self.back_button:is_clicked(x, y) then
            self.back_button:click()
        end

        -- Check if a campaign was clicked
        for i, campaign in ipairs(self.campaigns) do
            local screen_width = love.graphics.getWidth()
            local campaign_y = 180 + (i - 1) * 100
            local campaign_x = screen_width / 2 - 250
            if x >= campaign_x and x <= campaign_x + 500 and
               y >= campaign_y and y <= campaign_y + 80 then
                self.selected_campaign = i
            end
        end
    end
end

function StartCampMenu:render()
    -- Background
    love.graphics.clear(0.09, 0.09, 0.12)

    local screen_width = love.graphics.getWidth()

    -- Title
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("START NEW CAMPTRAIL", 0, 40, screen_width, "center")

    -- Description
    love.graphics.setColor(0.7, 0.7, 0.8)
    love.graphics.printf("Select a campaign trail to begin your conquest", 0, 80, screen_width, "center")

    -- Render campaign options
    for i, campaign in ipairs(self.campaigns) do
        local campaign_y = 180 + (i - 1) * 100
        local campaign_x = screen_width / 2 - 250

        -- Draw campaign box
        if i == self.selected_campaign then
            love.graphics.setColor(0.3, 0.4, 0.5)
        else
            love.graphics.setColor(0.2, 0.2, 0.25)
        end
        love.graphics.rectangle("fill", campaign_x, campaign_y, 500, 80, 4, 4)

        -- Draw border
        if i == self.selected_campaign then
            love.graphics.setColor(0.5, 0.7, 0.9)
        else
            love.graphics.setColor(0.4, 0.4, 0.5)
        end
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", campaign_x, campaign_y, 500, 80, 4, 4)

        -- Draw campaign name
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(campaign.name, campaign_x + 20, campaign_y + 15)

        -- Draw campaign description
        love.graphics.setColor(0.7, 0.7, 0.8)
        love.graphics.print(campaign.desc, campaign_x + 20, campaign_y + 45)
    end

    -- Render buttons
    self.start_button:render()
    self.back_button:render()

    -- Help text
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.printf("Use UP/DOWN arrows or click to select a campaign", 0, screen_width - 40, screen_width, "center")
end

