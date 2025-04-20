local Concord = require("Concord")

-- Input component for storing input state
Concord.component("input", function(component)
    -- Axes (range from -1.0 to 1.0)
    component.horizontal = 0  -- Left/Right movement axis
    component.vertical = 0    -- Forward/Backward movement axis
    
    -- Actions (boolean states)
    component.actions = {
        jump = false,     -- Up (space)
        crouch = false,   -- Down (shift)
        turnLeft = false, -- Turn Left (left arrow)
        turnRight = false -- Turn Right (right arrow)
    }
end) 