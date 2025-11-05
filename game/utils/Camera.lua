--- @class Camera
--- Camera for the game world with zoom, drag and WASD movement
---
--- The Camera manages the position and zoom level of the game view.
--- Features:
--- - WASD movement (automatically adapts to zoom level)
--- - Middle Mouse Button Drag
--- - Scroll-Wheel Zoom
--- - Zoom-adaptive movement speed (more movement when zoomed out, less when zoomed in)
---
--- @field x number The X-position of the camera in the game world
--- @field y number The Y-position of the camera in the game world
--- @field zoom number The current zoom level (1.0 = normal, >1 = closer, <1 = further away)
--- @field move_speed number The base movement speed (adjusted by zoom)
--- @field zoom_speed number The speed of zooming
--- @field min_zoom number The minimum zoom level
--- @field max_zoom number The maximum zoom level
--- @field dragging boolean Whether the camera is currently being dragged
--- @field drag_start_x number The X-position of the mouse pointer at the start of the drag
--- @field drag_start_y number The Y-position of the mouse pointer at the start of the drag
--- @field drag_start_cam_x number The X-position of the camera at the start of the drag
--- @field drag_start_cam_y number The Y-position of the camera at the start of the drag
Camera = {}
Camera.__index = Camera

--- Creates a new Camera instance
--- @param x number|nil The initial X-position (default: 0)
--- @param y number|nil The initial Y-position (default: 0)
--- @param zoom number|nil The initial zoom level (default: 1.0)
--- @param move_speed number|nil The base movement speed (default: 500)
--- @param zoom_speed number|nil The zoom speed (default: 0.1)
--- @param min_zoom number|nil The minimum zoom level (default: 0.1)
--- @param max_zoom number|nil The maximum zoom level (default: 5.0)
--- @return Camera The new Camera instance
function Camera.new(x, y, zoom, move_speed, zoom_speed, min_zoom, max_zoom)
    T.optional_number(x, "Camera.new: x must be a number or nil")
    T.optional_number(y, "Camera.new: y must be a number or nil")
    T.optional_number(zoom, "Camera.new: zoom must be a number or nil")
    T.optional_number(move_speed, "Camera.new: move_speed must be a number or nil")
    T.optional_number(zoom_speed, "Camera.new: zoom_speed must be a number or nil")
    T.optional_number(min_zoom, "Camera.new: min_zoom must be a number or nil")
    T.optional_number(max_zoom, "Camera.new: max_zoom must be a number or nil")

    local self = setmetatable({}, Camera)

    -- Position and zoom
    self.x = x or 0
    self.y = y or 0
    self.zoom = zoom or 1.0

    -- Movement and zoom settings
    self.move_speed = move_speed or 500
    self.zoom_speed = zoom_speed or 0.1
    self.min_zoom = min_zoom or 0.1
    self.max_zoom = max_zoom or 5.0

    -- Drag state
    self.dragging = false
    self.drag_start_x = 0
    self.drag_start_y = 0
    self.drag_start_cam_x = 0
    self.drag_start_cam_y = 0

    return self
end

--- Update method for WASD movement
--- Should be called in love.update(dt)
--- The movement speed automatically adapts to the zoom level:
--- At low zoom (further away) the camera moves faster
--- At high zoom (closer) the camera moves slower
--- @param dt number Delta time since the last frame
function Camera:update(dt)
    T.number(dt, "Camera:update: dt must be a number")

    -- Calculate the zoom-adjusted movement speed
    -- The further we are zoomed out (zoom < 1), the faster we move
    -- The further we are zoomed in (zoom > 1), the slower we move
    -- This ensures that the movement feels the same for the user
    local adjusted_speed = self.move_speed * (1.0 / self.zoom) * dt

    -- WASD movement
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        self.y = self.y - adjusted_speed
    end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        self.y = self.y + adjusted_speed
    end
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        self.x = self.x - adjusted_speed
    end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        self.x = self.x + adjusted_speed
    end
end

--- Mousepressed handler for Middle Mouse Button drag
--- Should be called in love.mousepressed(x, y, button)
--- @param x number The X-position of the mouse pointer
--- @param y number The Y-position of the mouse pointer
--- @param button number The mouse button number (3 = Middle Mouse Button)
function Camera:mousepressed(x, y, button)
    T.number(x, "Camera:mousepressed: x must be a number")
    T.number(y, "Camera:mousepressed: y must be a number")
    T.number(button, "Camera:mousepressed: button must be a number")

    -- Middle Mouse Button = 3 in LÖVE2D
    if button == 3 then
        self.dragging = true
        self.drag_start_x = x
        self.drag_start_y = y
        self.drag_start_cam_x = self.x
        self.drag_start_cam_y = self.y
    end
end

--- Mousereleased handler for Middle Mouse Button drag
--- Should be called in love.mousereleased(x, y, button)
--- @param x number The X-position of the mouse pointer
--- @param y number The Y-position of the mouse pointer
--- @param button number The mouse button number (3 = Middle Mouse Button)
function Camera:mousereleased(x, y, button)
    T.number(x, "Camera:mousereleased: x must be a number")
    T.number(y, "Camera:mousereleased: y must be a number")
    T.number(button, "Camera:mousereleased: button must be a number")

    -- Middle Mouse Button = 3 in LÖVE2D
    if button == 3 then
        self.dragging = false
    end
end

--- Mousemoved handler for Middle Mouse Button drag
--- Should be called in love.mousemoved(x, y, dx, dy)
--- @param x number The current X-position of the mouse pointer
--- @param y number The current Y-position of the mouse pointer
--- @param dx number The change in X direction since the last frame
--- @param dy number The change in Y direction since the last frame
function Camera:mousemoved(x, y, dx, dy)
    T.number(x, "Camera:mousemoved: x must be a number")
    T.number(y, "Camera:mousemoved: y must be a number")
    T.number(dx, "Camera:mousemoved: dx must be a number")
    T.number(dy, "Camera:mousemoved: dy must be a number")

    if self.dragging then
        -- Calculate the difference between the current and start position
        local delta_x = x - self.drag_start_x
        local delta_y = y - self.drag_start_y

        -- Move the camera accordingly (negative, because we're moving the world, not the mouse pointer)
        -- The movement is also adjusted by the zoom
        self.x = self.drag_start_cam_x - (delta_x / self.zoom)
        self.y = self.drag_start_cam_y - (delta_y / self.zoom)
    end
end

--- Wheelmoved handler for zoom
--- Should be called in love.wheelmoved(x, y)
--- @param x number The horizontal scroll direction (not used)
--- @param y number The vertical scroll direction (positive = up, negative = down)
function Camera:wheelmoved(x, y)
    T.number(x, "Camera:wheelmoved: x must be a number")
    T.number(y, "Camera:wheelmoved: y must be a number")

    -- Zoom in on scroll up, zoom out on scroll down
    local zoom_delta = y * self.zoom_speed
    self.zoom = self.zoom + zoom_delta

    -- Clamp zoom between min_zoom and max_zoom
    if self.zoom < self.min_zoom then
        self.zoom = self.min_zoom
    elseif self.zoom > self.max_zoom then
        self.zoom = self.max_zoom
    end
end

--- Applies the camera transformation to the current drawing operation
--- Should be called before drawing the game world
--- Afterwards love.graphics.origin() or love.graphics.pop() must be called
function Camera:apply()
    love.graphics.push()

    -- Center the camera on the screen
    local screen_center_x = love.graphics.getWidth() / 2
    local screen_center_y = love.graphics.getHeight() / 2

    -- Translate to center, then zoom, then translate to camera position
    love.graphics.translate(screen_center_x, screen_center_y)
    love.graphics.scale(self.zoom, self.zoom)
    love.graphics.translate(-self.x, -self.y)
end

--- Resets the camera transformation
--- Should be called after drawing the game world
function Camera:reset()
    love.graphics.pop()
end

--- Converts screen coordinates to world coordinates
--- @param screen_x number The X-position on the screen
--- @param screen_y number The Y-position on the screen
--- @return number, number The X and Y position in the game world
function Camera:screenToWorld(screen_x, screen_y)
    T.number(screen_x, "Camera:screenToWorld: screen_x must be a number")
    T.number(screen_y, "Camera:screenToWorld: screen_y must be a number")

    local screen_center_x = love.graphics.getWidth() / 2
    local screen_center_y = love.graphics.getHeight() / 2

    local world_x = (screen_x - screen_center_x) / self.zoom + self.x
    local world_y = (screen_y - screen_center_y) / self.zoom + self.y

    return world_x, world_y
end

--- Converts world coordinates to screen coordinates
--- @param world_x number The X-position in the game world
--- @param world_y number The Y-position in the game world
--- @return number, number The X and Y position on the screen
function Camera:worldToScreen(world_x, world_y)
    T.number(world_x, "Camera:worldToScreen: world_x must be a number")
    T.number(world_y, "Camera:worldToScreen: world_y must be a number")

    local screen_center_x = love.graphics.getWidth() / 2
    local screen_center_y = love.graphics.getHeight() / 2

    local screen_x = (world_x - self.x) * self.zoom + screen_center_x
    local screen_y = (world_y - self.y) * self.zoom + screen_center_y

    return screen_x, screen_y
end

--- Sets the position of the camera
--- @param x number The new X-position
--- @param y number The new Y-position
function Camera:setPosition(x, y)
    T.number(x, "Camera:setPosition: x must be a number")
    T.number(y, "Camera:setPosition: y must be a number")

    self.x = x
    self.y = y
end

--- Sets the zoom level of the camera
--- @param zoom number The new zoom level
function Camera:setZoom(zoom)
    T.number(zoom, "Camera:setZoom: zoom must be a number")

    self.zoom = zoom

    -- Clamp zoom between min_zoom and max_zoom
    if self.zoom < self.min_zoom then
        self.zoom = self.min_zoom
    elseif self.zoom > self.max_zoom then
        self.zoom = self.max_zoom
    end
end

--- Returns the current position of the camera
--- @return number, number The X and Y position of the camera
function Camera:getPosition()
    return self.x, self.y
end

--- Returns the current zoom level
--- @return number The zoom level
function Camera:getZoom()
    return self.zoom
end
