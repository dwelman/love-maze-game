local Loader = {
    base_path = "",
}

function Loader:setBasePath(path)
    self.base_path = path
end

function Loader:loadComponents(path)
    if love.filesystem.getInfo(self.base_path .. path) then
        for _, file in ipairs(love.filesystem.getDirectoryItems(self.base_path .. path)) do
            if file:match("%.lua$") then
                local name = file:gsub("%.lua$", "")
                print("Loading component: " .. name)
                require("components." .. name)
            end
        end
    else
        print("Error: " .. self.base_path .. path .. " does not exist")
    end
end

function Loader:loadSystems(path)
    if love.filesystem.getInfo(self.base_path .. path) then
        for _, file in ipairs(love.filesystem.getDirectoryItems(self.base_path .. path)) do
            if file:match("%.lua$") then
                local name = file:gsub("%.lua$", "")
                print("Loading system: " .. name)
                require("systems." .. name)
            end
        end
    else
        print("Error: " .. self.base_path .. path .. " does not exist")
    end
end

return Loader
