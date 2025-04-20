local Concord = require("Concord")

-- Camera Controller System
local CameraController = Concord.system({
    cameras = { "camera" },
    inputs = { "input" }
})

function CameraController:update(dt)
    if #self.cameras > 0 and #self.inputs > 0 then
        local camera = self.cameras[1]:get("camera")
        local input = self.inputs[1]:get("input")
        
        -- Movement speed
        local moveSpeed = 2.0 * dt
        local rotSpeed = 1.5 * dt
        
        -- TODO: Make a movement system that handles all movement logic, and normalise the movement vector
        -- Forward/backward movement (vertical axis)
        if input.vertical ~= 0 then
            camera.x = camera.x + math.sin(camera.rotY) * moveSpeed * input.vertical
            camera.z = camera.z + math.cos(camera.rotY) * moveSpeed * input.vertical
        end
        
        -- Strafe left/right (horizontal axis)
        if input.horizontal ~= 0 then
            camera.x = camera.x + math.cos(camera.rotY) * moveSpeed * input.horizontal
            camera.z = camera.z - math.sin(camera.rotY) * moveSpeed * input.horizontal
        end
        
        -- Up/down movement (actions)
        if input.actions.jump then
            camera.y = camera.y + moveSpeed
        elseif input.actions.crouch then
            camera.y = camera.y - moveSpeed
        end
        
        -- Rotation (left/right actions)
        if input.actions.turnLeft then
            camera.rotY = camera.rotY - rotSpeed
        elseif input.actions.turnRight then
            camera.rotY = camera.rotY + rotSpeed
        end
    end
end

return CameraController 