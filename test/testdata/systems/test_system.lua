local Concord = require 'Concord'
local System = Concord.system

local TestSystem = System({test_pool = {"test_component"}})

function TestSystem:init(world)
    self.world = world
end

function TestSystem:getMessages()
    local messages = {}
    for _, entity in ipairs(self.test_pool) do
        table.insert(messages, entity.test_component.message)
    end
    return messages
end

return TestSystem
