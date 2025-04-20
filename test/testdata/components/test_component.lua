local Concord = require 'Concord'

Concord.component("test_component", function(component, message)
    component.message = message or ""
end)