--[[
    Bro at this point its just plain pasting for 1 - 4.... bro isdtg these guys dont know 
    wat they are doing 🙏, setting the players health to 0 aint insta hit 😭

    - https://discord.gg/uQvYbgTW | https://drank.cc/
]]

-- Instant Hit Function
local function instantHit()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    
    -- Function to perform the hit
    local function performHit(target)
    -- Ensure target is a valid part of another player's character
    if target and target.Parent and target.Parent ~= LocalPlayer.Character then
    local humanoid = target.Parent:FindFirstChildOfClass("Humanoid")
    if humanoid then
    humanoid:TakeDamage(100) -- Inflict 100 damage or adjust as needed
    end
    end
    end
    
    Mouse.Button1Down:Connect(function()
    if Mouse.Target then
    performHit(Mouse.Target)
    end
    end)
    end
    
    -- Execute the instant hit function
    instantHit()
    
    print("Instant Hit Script for Project Delta Loaded")