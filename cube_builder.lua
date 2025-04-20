local Concord = require("Concord")

-- Utility to create a cube with vertices and edges
local CubeBuilder = {}

-- Creates a wireframe cube centered at the given position with the given size
function CubeBuilder.createCube(world, centerX, centerY, centerZ, size)
    local halfSize = size / 2
    
    -- Create vertices (8 corners of the cube)
    local vertices = {}
    
    -- Bottom vertices (y = centerY + halfSize)
    vertices[1] = Concord.entity(world)
        :give("position3d", centerX - halfSize, centerY + halfSize, centerZ - halfSize)
        :give("vertex", 1)
    
    vertices[2] = Concord.entity(world)
        :give("position3d", centerX + halfSize, centerY + halfSize, centerZ - halfSize)
        :give("vertex", 2)
    
    vertices[3] = Concord.entity(world)
        :give("position3d", centerX + halfSize, centerY + halfSize, centerZ + halfSize)
        :give("vertex", 3)
    
    vertices[4] = Concord.entity(world)
        :give("position3d", centerX - halfSize, centerY + halfSize, centerZ + halfSize)
        :give("vertex", 4)
    
    -- Top vertices (y = centerY - halfSize)
    vertices[5] = Concord.entity(world)
        :give("position3d", centerX - halfSize, centerY - halfSize, centerZ - halfSize)
        :give("vertex", 5)
    
    vertices[6] = Concord.entity(world)
        :give("position3d", centerX + halfSize, centerY - halfSize, centerZ - halfSize)
        :give("vertex", 6)
    
    vertices[7] = Concord.entity(world)
        :give("position3d", centerX + halfSize, centerY - halfSize, centerZ + halfSize)
        :give("vertex", 7)
    
    vertices[8] = Concord.entity(world)
        :give("position3d", centerX - halfSize, centerY - halfSize, centerZ + halfSize)
        :give("vertex", 8)
    
    -- Create edges (12 edges of the cube)
    -- Bottom face
    Concord.entity(world):give("edge", 1, 2)
    Concord.entity(world):give("edge", 2, 3)
    Concord.entity(world):give("edge", 3, 4)
    Concord.entity(world):give("edge", 4, 1)
    
    -- Top face
    Concord.entity(world):give("edge", 5, 6)
    Concord.entity(world):give("edge", 6, 7)
    Concord.entity(world):give("edge", 7, 8)
    Concord.entity(world):give("edge", 8, 5)
    
    -- Connecting edges
    Concord.entity(world):give("edge", 1, 5)
    Concord.entity(world):give("edge", 2, 6)
    Concord.entity(world):give("edge", 3, 7)
    Concord.entity(world):give("edge", 4, 8)
    
    return vertices
end

return CubeBuilder 