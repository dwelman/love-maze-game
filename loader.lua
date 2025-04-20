local Loader = {
    base_path = "",
}

function Loader:setBasePath(path)
    if path ~= "" and path:sub(-1) ~= "/" then
        path = path .. "/"
    end
    self.base_path = path
end

function Loader:loadComponents(path)
    if love.filesystem.getInfo(self.base_path .. path) then
        for _, file in ipairs(love.filesystem.getDirectoryItems(self.base_path .. path)) do
            if file:match("%.lua$") then
                local name = file:gsub("%.lua$", "")
                print("Loading component: " .. name)
                local chunk = love.filesystem.load(self.base_path .. path .. "/" .. file)
                if chunk then
                    chunk()
                else
                    print("Error loading component: " .. name)
                end
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
                local chunk = love.filesystem.load(self.base_path .. path .. "/" .. file)
                if chunk then
                    chunk()
                else
                    print("Error loading system: " .. name)
                end
            end
        end
    else
        print("Error: " .. self.base_path .. path .. " does not exist")
    end
end

return Loader
