--[[
    Bro idk wat they were even tranna do for project prob sum ChatPGT insta hit 🙏

    - https://discord.gg/uQvYbgTW | https://drank.cc/
]]

-- Compatibility layer for Solara and Wave Executors
local executor = identifyexecutor
if not executor then
executor = getexecutorname or warn("Executor not supported")
end

-- Instant Hit Function
local function instantHit()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    
    -- Remote path might need adjustment based on the game structure
    local hitRemote = game:GetService("ReplicatedStorage"):FindFirstChild("HitRemote")

    if not hitRemote then
        warn("HitRemote not found. Please ensure the correct remote path.")
        return
    end

    Mouse.Button1Down:Connect(function()
        if Mouse.Target then
            hitRemote:FireServer(Mouse.Target, Mouse.Target.Position)
        end
    end)
end

-- Load the compatibility layer for Solara and Wave Executors
if executor == "Solara" then
    SolaraLib = loadstring(game:HttpGet("https://example.com/solara_lib.lua"))()
    SolaraLib:Execute(function()
        instantHit()
    end)
elseif executor == "Wave" then
    WaveLib = loadstring(game:HttpGet("https://example.com/wave_lib.lua"))()
    WaveLib:Execute(function()
        instantHit()
    end)
else
    instantHit()
end