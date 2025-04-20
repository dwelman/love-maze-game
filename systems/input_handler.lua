local Concord = require("Concord")

-- Input Handler System
local InputHandler = Concord.system({
    inputs = { "input" }
})

function InputHandler:init()
    -- Register input event callbacks
    self:bindKeyCallbacks()
end

function InputHandler:bindKeyCallbacks()
    -- Store original keyboard callbacks
    self.originalKeyPressed = love.keypressed
    self.originalKeyReleased = love.keyreleased
    
    -- Override love.keypressed
    love.keypressed = function(key, scancode, isrepeat)
        -- Call original callback if it exists
        if self.originalKeyPressed then
            self.originalKeyPressed(key, scancode, isrepeat)
        end
        
        -- Handle key press in our system
        self:keyPressed(key, scancode, isrepeat)
    end
    
    -- Override love.keyreleased
    love.keyreleased = function(key, scancode)
        -- Call original callback if it exists
        if self.originalKeyReleased then
            self.originalKeyReleased(key, scancode)
        end
        
        -- Handle key release in our system
        self:keyReleased(key, scancode)
    end
end

function InputHandler:keyPressed(key, scancode, isrepeat)
    if #self.inputs > 0 then
        local input = self.inputs[1]:get("input")
        
        -- Map keys to actions
        if key == "space" then
            input.actions.jump = true
        elseif key == "lshift" then
            input.actions.crouch = true
        elseif key == "left" then
            input.actions.turnLeft = true
        elseif key == "right" then
            input.actions.turnRight = true
        end
    end
end

function InputHandler:keyReleased(key, scancode)
    if #self.inputs > 0 then
        local input = self.inputs[1]:get("input")
        
        -- Map keys to actions
        if key == "space" then
            input.actions.jump = false
        elseif key == "lshift" then
            input.actions.crouch = false
        elseif key == "left" then
            input.actions.turnLeft = false
        elseif key == "right" then
            input.actions.turnRight = false
        end
    end
end

function InputHandler:update(dt)
    if #self.inputs > 0 then
        local input = self.inputs[1]:get("input")
        
        -- Reset axes
        input.horizontal = 0
        input.vertical = 0
        
        -- Update horizontal axis (A/D keys)
        if love.keyboard.isDown("a") then
            input.horizontal = input.horizontal - 1
        end
        if love.keyboard.isDown("d") then
            input.horizontal = input.horizontal + 1
        end
        
        -- Update vertical axis (W/S keys)
        if love.keyboard.isDown("w") then
            input.vertical = input.vertical + 1
        end
        if love.keyboard.isDown("s") then
            input.vertical = input.vertical - 1
        end
    end
end

return InputHandler 