local Concord = require("Concord")

-- Wireframe Renderer System
local WireframeRenderer = Concord.system({
    vertices = { "vertex", "position3d" },
    edges = { "edge" },
    cameras = { "camera" }
})

-- Project 3D point to 2D screen space
function WireframeRenderer:project3Dto2D(point3D, camera)
    -- Translate point relative to camera position
    local dx = point3D.x - camera.x
    local dy = point3D.y - camera.y
    local dz = point3D.z - camera.z
    
    -- Simple rotation around Y axis (yaw)
    local cos = math.cos(camera.rotY)
    local sin = math.sin(camera.rotY)
    
    local rotX = dx * cos - dz * sin
    local rotZ = dx * sin + dz * cos
    
    -- Don't render points behind the camera
    if rotZ <= camera.near then
        return nil
    end
    
    -- Perspective projection
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local fovFactor = math.tan(camera.fov / 2)
    
    -- Calculate 2D screen coordinates
    local scale = 1 / (rotZ * fovFactor)
    local screenX = screenWidth / 2 + rotX * scale * screenHeight
    local screenY = screenHeight / 2 - dy * scale * screenHeight
    
    return screenX, screenY, rotZ
end

function WireframeRenderer:draw()
    if #self.cameras > 0 then
        local camera = self.cameras[1]:get("camera")
        
        -- Create a lookup table for vertices by ID
        local vertexPositions = {}
        for _, entity in ipairs(self.vertices) do
            local vertex = entity:get("vertex")
            local position = entity:get("position3d")
            vertexPositions[vertex.id] = {
                x = position.x,
                y = position.y,
                z = position.z
            }
        end
        
        -- Draw edges
        love.graphics.setColor(1, 1, 1)
        for _, entity in ipairs(self.edges) do
            local edge = entity:get("edge")
            
            -- Get the 3D positions of the connected vertices
            local fromVertex = vertexPositions[edge.fromId]
            local toVertex = vertexPositions[edge.toId]
            
            if fromVertex and toVertex then
                -- Project to 2D screen space
                local fromX, fromY, fromZ = self:project3Dto2D(fromVertex, camera)
                local toX, toY, toZ = self:project3Dto2D(toVertex, camera)
                
                -- Draw line if both points are in front of the camera
                if fromX and toX then
                    love.graphics.line(fromX, fromY, toX, toY)
                end
            end
        end
        
        -- Draw vertices
        love.graphics.setPointSize(5)
        for _, entity in ipairs(self.vertices) do
            local position = entity:get("position3d")
            local x, y, z = self:project3Dto2D(position, camera)
            
            if x then
                love.graphics.setColor(1, 0, 0)
                love.graphics.points(x, y)
            end
        end
    end
end

return WireframeRenderer 