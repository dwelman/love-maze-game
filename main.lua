-- Import required libraries
local Concord = require("Concord")
local Loader = require("loader")
local lovetest = require("lovetest")
local CubeBuilder = require("cube_builder")

function love.load(arg)
  -- Check for the testing command line flags
  if lovetest.detect(arg) then
    print("Running tests")
    -- Run the tests
    lovetest.run()
  end

  -- Initialize game
  love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    
  -- Set up ECS world
  world = Concord.world()
  
  -- Load components and systems
  Loader:setBasePath("")
  Loader:loadComponents("components")
  Loader:loadSystems("systems")
  
  -- Add systems to the world
  world:addSystems(
    require("systems.input_handler"), -- Input handler system should come first
    require("systems.camera_controller"),
    require("systems.wireframe_renderer")
  )
  
  -- Create input entity
  Concord.entity(world)
    :give("input")
  
  -- Create camera entity
  Concord.entity(world)
    :give("camera", 0, 0, -5) -- Position camera 5 units back from origin
  
  -- Create a cube
  CubeBuilder.createCube(world, 0, 0, 0, 2) -- Create a cube at origin with size 2
  
  print("3D Wireframe Renderer Initialized")
  print("\nControls:")
  print("  WASD - Move camera forward, backward, left, right")
  print("  Space/Shift - Move camera up/down")
  print("  Left/Right Arrow - Rotate camera left/right")
  print("  Up/Down Arrow - Rotate camera up/down")
  print("  Escape - Quit")
end

function love.update(dt)
  -- Update game logic
  world:emit("update", dt)
end

function love.draw()
  -- Clear the screen
  love.graphics.clear(0.1, 0.1, 0.1)
  
  -- Draw the wireframe
  world:emit("draw")
  
  -- Draw FPS counter
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

