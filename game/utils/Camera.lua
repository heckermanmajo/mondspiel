--- @class Camera
--- Camera für die Spielwelt mit Zoom, Drag und WASD Bewegung
---
--- Die Camera verwaltet die Position und den Zoom-Level der Spielansicht.
--- Features:
--- - WASD Bewegung (passt sich automatisch an Zoom-Level an)
--- - Middle Mouse Button Drag
--- - Scroll-Wheel Zoom
--- - Zoom-adaptive Bewegungsgeschwindigkeit (mehr Bewegung bei weiter rausgezoomt, weniger bei rein gezoomt)
---
--- @field x number Die X-Position der Camera in der Spielwelt
--- @field y number Die Y-Position der Camera in der Spielwelt
--- @field zoom number Der aktuelle Zoom-Level (1.0 = normal, >1 = näher, <1 = weiter weg)
--- @field move_speed number Die Basis-Bewegungsgeschwindigkeit (wird durch Zoom angepasst)
--- @field zoom_speed number Die Geschwindigkeit des Zoomens
--- @field min_zoom number Der minimale Zoom-Level
--- @field max_zoom number Der maximale Zoom-Level
--- @field dragging boolean Ob die Camera gerade gedragged wird
--- @field drag_start_x number Die X-Position des Mauszeigers beim Start des Drags
--- @field drag_start_y number Die Y-Position des Mauszeigers beim Start des Drags
--- @field drag_start_cam_x number Die X-Position der Camera beim Start des Drags
--- @field drag_start_cam_y number Die Y-Position der Camera beim Start des Drags
Camera = {}
Camera.__index = Camera

--- Erstellt eine neue Camera-Instanz
--- @param x number|nil Die initiale X-Position (default: 0)
--- @param y number|nil Die initiale Y-Position (default: 0)
--- @param zoom number|nil Der initiale Zoom-Level (default: 1.0)
--- @param move_speed number|nil Die Basis-Bewegungsgeschwindigkeit (default: 500)
--- @param zoom_speed number|nil Die Zoom-Geschwindigkeit (default: 0.1)
--- @param min_zoom number|nil Der minimale Zoom-Level (default: 0.1)
--- @param max_zoom number|nil Der maximale Zoom-Level (default: 5.0)
--- @return Camera Die neue Camera-Instanz
function Camera.new(x, y, zoom, move_speed, zoom_speed, min_zoom, max_zoom)
    T.optional_number(x, "Camera.new: x must be a number or nil")
    T.optional_number(y, "Camera.new: y must be a number or nil")
    T.optional_number(zoom, "Camera.new: zoom must be a number or nil")
    T.optional_number(move_speed, "Camera.new: move_speed must be a number or nil")
    T.optional_number(zoom_speed, "Camera.new: zoom_speed must be a number or nil")
    T.optional_number(min_zoom, "Camera.new: min_zoom must be a number or nil")
    T.optional_number(max_zoom, "Camera.new: max_zoom must be a number or nil")

    local self = setmetatable({}, Camera)

    -- Position und Zoom
    self.x = x or 0
    self.y = y or 0
    self.zoom = zoom or 1.0

    -- Bewegungs- und Zoom-Einstellungen
    self.move_speed = move_speed or 500
    self.zoom_speed = zoom_speed or 0.1
    self.min_zoom = min_zoom or 0.1
    self.max_zoom = max_zoom or 5.0

    -- Drag-State
    self.dragging = false
    self.drag_start_x = 0
    self.drag_start_y = 0
    self.drag_start_cam_x = 0
    self.drag_start_cam_y = 0

    return self
end

--- Update-Methode für WASD Bewegung
--- Sollte in love.update(dt) aufgerufen werden
--- Die Bewegungsgeschwindigkeit passt sich automatisch an den Zoom-Level an:
--- Bei niedrigem Zoom (weiter weg) bewegt sich die Camera schneller
--- Bei hohem Zoom (näher dran) bewegt sich die Camera langsamer
--- @param dt number Delta-Zeit seit dem letzten Frame
function Camera:update(dt)
    T.number(dt, "Camera:update: dt must be a number")

    -- Berechne die zoom-angepasste Bewegungsgeschwindigkeit
    -- Je weiter wir rausgezoomt sind (zoom < 1), desto schneller bewegen wir uns
    -- Je weiter wir reingezoomt sind (zoom > 1), desto langsamer bewegen wir uns
    -- Dies sorgt dafür, dass sich die Bewegung für den Nutzer gleich anfühlt
    local adjusted_speed = self.move_speed * (1.0 / self.zoom) * dt

    -- WASD Bewegung
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

--- Mousepressed-Handler für Middle Mouse Button Drag
--- Sollte in love.mousepressed(x, y, button) aufgerufen werden
--- @param x number Die X-Position des Mauszeigers
--- @param y number Die Y-Position des Mauszeigers
--- @param button number Die Maus-Button-Nummer (3 = Middle Mouse Button)
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

--- Mousereleased-Handler für Middle Mouse Button Drag
--- Sollte in love.mousereleased(x, y, button) aufgerufen werden
--- @param x number Die X-Position des Mauszeigers
--- @param y number Die Y-Position des Mauszeigers
--- @param button number Die Maus-Button-Nummer (3 = Middle Mouse Button)
function Camera:mousereleased(x, y, button)
    T.number(x, "Camera:mousereleased: x must be a number")
    T.number(y, "Camera:mousereleased: y must be a number")
    T.number(button, "Camera:mousereleased: button must be a number")

    -- Middle Mouse Button = 3 in LÖVE2D
    if button == 3 then
        self.dragging = false
    end
end

--- Mousemoved-Handler für Middle Mouse Button Drag
--- Sollte in love.mousemoved(x, y, dx, dy) aufgerufen werden
--- @param x number Die aktuelle X-Position des Mauszeigers
--- @param y number Die aktuelle Y-Position des Mauszeigers
--- @param dx number Die Änderung in X-Richtung seit dem letzten Frame
--- @param dy number Die Änderung in Y-Richtung seit dem letzten Frame
function Camera:mousemoved(x, y, dx, dy)
    T.number(x, "Camera:mousemoved: x must be a number")
    T.number(y, "Camera:mousemoved: y must be a number")
    T.number(dx, "Camera:mousemoved: dx must be a number")
    T.number(dy, "Camera:mousemoved: dy must be a number")

    if self.dragging then
        -- Berechne die Differenz zwischen der aktuellen und der Start-Position
        local delta_x = x - self.drag_start_x
        local delta_y = y - self.drag_start_y

        -- Bewege die Camera entsprechend (negativ, weil wir die Welt bewegen, nicht den Mauszeiger)
        -- Die Bewegung wird auch durch den Zoom angepasst
        self.x = self.drag_start_cam_x - (delta_x / self.zoom)
        self.y = self.drag_start_cam_y - (delta_y / self.zoom)
    end
end

--- Wheelmoved-Handler für Zoom
--- Sollte in love.wheelmoved(x, y) aufgerufen werden
--- @param x number Die horizontale Scroll-Richtung (wird nicht verwendet)
--- @param y number Die vertikale Scroll-Richtung (positiv = hoch, negativ = runter)
function Camera:wheelmoved(x, y)
    T.number(x, "Camera:wheelmoved: x must be a number")
    T.number(y, "Camera:wheelmoved: y must be a number")

    -- Zoom in bei Scroll hoch, Zoom out bei Scroll runter
    local zoom_delta = y * self.zoom_speed
    self.zoom = self.zoom + zoom_delta

    -- Clamp zoom zwischen min_zoom und max_zoom
    if self.zoom < self.min_zoom then
        self.zoom = self.min_zoom
    elseif self.zoom > self.max_zoom then
        self.zoom = self.max_zoom
    end
end

--- Wendet die Camera-Transformation auf die aktuelle Zeichenoperation an
--- Sollte vor dem Zeichnen der Spielwelt aufgerufen werden
--- Danach muss love.graphics.origin() oder love.graphics.pop() aufgerufen werden
function Camera:apply()
    love.graphics.push()

    -- Zentriere die Camera auf dem Bildschirm
    local screen_center_x = love.graphics.getWidth() / 2
    local screen_center_y = love.graphics.getHeight() / 2

    -- Translate to center, then zoom, then translate to camera position
    love.graphics.translate(screen_center_x, screen_center_y)
    love.graphics.scale(self.zoom, self.zoom)
    love.graphics.translate(-self.x, -self.y)
end

--- Setzt die Camera-Transformation zurück
--- Sollte nach dem Zeichnen der Spielwelt aufgerufen werden
function Camera:reset()
    love.graphics.pop()
end

--- Konvertiert Bildschirm-Koordinaten in Welt-Koordinaten
--- @param screen_x number Die X-Position auf dem Bildschirm
--- @param screen_y number Die Y-Position auf dem Bildschirm
--- @return number, number Die X- und Y-Position in der Spielwelt
function Camera:screenToWorld(screen_x, screen_y)
    T.number(screen_x, "Camera:screenToWorld: screen_x must be a number")
    T.number(screen_y, "Camera:screenToWorld: screen_y must be a number")

    local screen_center_x = love.graphics.getWidth() / 2
    local screen_center_y = love.graphics.getHeight() / 2

    local world_x = (screen_x - screen_center_x) / self.zoom + self.x
    local world_y = (screen_y - screen_center_y) / self.zoom + self.y

    return world_x, world_y
end

--- Konvertiert Welt-Koordinaten in Bildschirm-Koordinaten
--- @param world_x number Die X-Position in der Spielwelt
--- @param world_y number Die Y-Position in der Spielwelt
--- @return number, number Die X- und Y-Position auf dem Bildschirm
function Camera:worldToScreen(world_x, world_y)
    T.number(world_x, "Camera:worldToScreen: world_x must be a number")
    T.number(world_y, "Camera:worldToScreen: world_y must be a number")

    local screen_center_x = love.graphics.getWidth() / 2
    local screen_center_y = love.graphics.getHeight() / 2

    local screen_x = (world_x - self.x) * self.zoom + screen_center_x
    local screen_y = (world_y - self.y) * self.zoom + screen_center_y

    return screen_x, screen_y
end

--- Setzt die Position der Camera
--- @param x number Die neue X-Position
--- @param y number Die neue Y-Position
function Camera:setPosition(x, y)
    T.number(x, "Camera:setPosition: x must be a number")
    T.number(y, "Camera:setPosition: y must be a number")

    self.x = x
    self.y = y
end

--- Setzt den Zoom-Level der Camera
--- @param zoom number Der neue Zoom-Level
function Camera:setZoom(zoom)
    T.number(zoom, "Camera:setZoom: zoom must be a number")

    self.zoom = zoom

    -- Clamp zoom zwischen min_zoom und max_zoom
    if self.zoom < self.min_zoom then
        self.zoom = self.min_zoom
    elseif self.zoom > self.max_zoom then
        self.zoom = self.max_zoom
    end
end

--- Gibt die aktuelle Position der Camera zurück
--- @return number, number Die X- und Y-Position der Camera
function Camera:getPosition()
    return self.x, self.y
end

--- Gibt den aktuellen Zoom-Level zurück
--- @return number Der Zoom-Level
function Camera:getZoom()
    return self.zoom
end
