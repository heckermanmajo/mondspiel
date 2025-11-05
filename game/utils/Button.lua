--- @class Button A clickable button UI component
Button = {}
Button.__index = Button

--- Creates a new button
--- @param x number X position
--- @param y number Y position
--- @param width number Button width
--- @param height number Button height
--- @param text string Button text
--- @param callback function Function to call when clicked
--- @return Button
function Button.new(x, y, width, height, text, callback)
    T.number(x)
    T.number(y)
    T.number(width)
    T.number(height)
    T.string(text)
    T.func(callback)

    local self = setmetatable({}, Button)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text
    self.callback = callback
    self.is_hovered = false
    self.is_pressed = false
    return self
end

--- Updates button state based on mouse position
--- @param mouse_x number Mouse X position
--- @param mouse_y number Mouse Y position
function Button:update(mouse_x, mouse_y)
    T.number(mouse_x)
    T.number(mouse_y)

    self.is_hovered = mouse_x >= self.x and mouse_x <= self.x + self.width and
                      mouse_y >= self.y and mouse_y <= self.y + self.height
end

--- Checks if the button was clicked
--- @param mouse_x number Mouse X position
--- @param mouse_y number Mouse Y position
--- @return boolean True if button was clicked
function Button:is_clicked(mouse_x, mouse_y)
    T.number(mouse_x)
    T.number(mouse_y)

    if mouse_x >= self.x and mouse_x <= self.x + self.width and
       mouse_y >= self.y and mouse_y <= self.y + self.height then
        return true
    end
    return false
end

--- Executes the button's callback
function Button:click()
    if self.callback then
        self.callback()
    end
end

--- Renders the button
function Button:render()
    -- Draw button background
    if self.is_hovered then
        love.graphics.setColor(0.3, 0.4, 0.6)
    else
        love.graphics.setColor(0.2, 0.25, 0.35)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 4, 4)

    -- Draw button border
    love.graphics.setColor(0.5, 0.6, 0.8)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, 4, 4)

    -- Draw button text
    love.graphics.setColor(1, 1, 1)
    local font = love.graphics.getFont()
    local text_width = font:getWidth(self.text)
    local text_height = font:getHeight()
    love.graphics.print(self.text,
                       self.x + (self.width - text_width) / 2,
                       self.y + (self.height - text_height) / 2)
end
