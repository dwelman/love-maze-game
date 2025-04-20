local Concord = require("Concord")

-- Position3D component for storing 3D coordinates
Concord.component("position3d", function(component, x, y, z)
    component.x = x or 0
    component.y = y or 0
    component.z = z or 0
end) 