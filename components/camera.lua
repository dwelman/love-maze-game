local Concord = require("Concord")

-- Camera component for the player's view
Concord.component("camera", function(component, x, y, z, rotY, rotX)
    component.x = x or 0
    component.y = y or 0
    component.z = z or 0
    component.rotY = rotY or 0  -- Rotation around Y axis (yaw - left/right)
    component.rotX = rotX or 0  -- Rotation around X axis (pitch - up/down)
    component.fov = math.pi / 3 -- 60 degrees field of view
    component.near = 0.1        -- Near clipping plane
    component.far = 100         -- Far clipping plane
    component.aspect = love.graphics.getWidth() / love.graphics.getHeight()
end) 