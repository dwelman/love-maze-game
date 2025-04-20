local Concord = require("Concord")

-- Edge component to connect two vertices
-- from: entity ID of the starting vertex
-- to: entity ID of the ending vertex
Concord.component("edge", function(component, fromId, toId)
    component.fromId = fromId
    component.toId = toId
end) 