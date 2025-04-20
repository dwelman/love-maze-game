function test_loader()
    -- Print the directory the executable is running in
    print("Current directory: " .. love.filesystem.getSourceBaseDirectory())
    local Loader = require 'loader'
    -- Use a programmatic path that works with LÖVE's filesystem
    local test_path = "test/testdata/"
    Loader:loadComponents(test_path.."components")
    Loader:loadSystems(test_path.."systems")
end

