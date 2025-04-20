local Concord = require("Concord")

-- Vertex component for cube vertices
-- id: unique identifier for this vertex
Concord.component("vertex", function(component, id)
    component.id = id or 0
end) 