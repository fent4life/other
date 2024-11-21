
--[[
    This is dogehubs take on auto shoot for a game called Project Delta,
    I aint got a clue wat this man was taking when he type this shit on 
    ChatGPT...

    - https://discord.gg/uQvYbgTW | https://drank.cc/
]]


-- Auto Shoot Script for Project Delta
-- Get the camera and the closest player
local camera = game.Workspace.CurrentCamera
local players = game.Players:GetPlayers()
local closestPlayer = nil
local closestDistance = math.huge

-- Find the closest player
local function findClosestPlayer()
    for _, player in pairs(players) do
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local distance = (humanoidRootPart.Position - camera.CFrame.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
end

-- Raycast from camera to closest player
local function raycastToClosestPlayer()
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true
    raycastParams.FilterDescendantsInstances = {camera} -- Add the camera to the filter
    local raycastResult = workspace:Raycast(camera.CFrame.Position, closestPlayer.Character.HumanoidRootPart.Position - camera.CFrame.Position, raycastParams)
    return raycastResult
end

-- Check if the raycast connection is visible
local function checkRaycastConnection(raycastResult)
    if raycastResult and raycastResult.Instance == closestPlayer.Character.HumanoidRootPart then
        -- Auto shoot
        local weapon = game.Players.LocalPlayer.Character:FindFirstChild("Weapon")
        if weapon then
            local ammo = weapon:FindFirstChild("Ammo")
            if ammo then
                while ammo.Value > 0 do
                    weapon:FindFirstChild("Fire"):FireServer()
                    wait(0.1) -- Adjust the delay according to your game's requirements
                end
            end
        end
    end
end

-- Main loop
while true do
    findClosestPlayer()
    local raycastResult = raycastToClosestPlayer()
    checkRaycastConnection(raycastResult)
    wait(0.1) -- Adjust the delay according to your game's requirements
end
