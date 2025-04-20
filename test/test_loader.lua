function test_loader()
    local Loader = require 'loader'
    local test_path = "testdata/test_loader"
    Loader:setBasePath(test_path)
    Loader:loadComponents("components")
    Loader:loadSystems("systems")
end

