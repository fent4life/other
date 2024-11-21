--[[
    Bro idk wat they were even tranna do for project prob sum ChatPGT insta hit 🙏
    Solara support insta hit defo!!

    - https://discord.gg/uQvYbgTW | https://drank.cc/
]]




-- Compatibility check for Solara Executor
local executor = identifyexecutor or getexecutorname
if executor ~= "Solara" then
warn("This script is designed for Solara Executor. Please use the Solara Executor.")
return
end

-- Load Solara Library
local SolaraLib = loadstring(game:HttpGet("https://example.com/solara_lib.lua"))() -- Replace this URL with the actual Solara library URL if needed

-- Instant Hit Function 
local function instantHit()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Adjust remote path based on the game structure
local hitRemote = game:GetService("ReplicatedStorage"):WaitForChild("HitRemote")

Mouse.Button1Down:Connect(function()
if Mouse.Target then
hitRemote:FireServer(Mouse.Target, Mouse.Target.Position)
end
end)
end

-- Execute the instant hit function using Solara Library
SolaraLib:Execute(function()
instantHit()
end)

print("Instant Hit Script for Project Delta Loaded with Solara Support")