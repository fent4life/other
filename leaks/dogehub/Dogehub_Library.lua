--[[
    Pated sumhub as a baseplate or sumthing evberything says swimhub even when u make a config on dogehub... 
    😭🙏

    - https://discord.gg/uQvYbgTW | https://drank.cc/
]]


local function getfile(name)
    local repo = "https://raw.githubusercontent.com/SWIMHUBISWIMMING/swimhub/main/"
    local success, content = pcall(game.HttpGet, game, repo..name)
    if success then return content else return print("getfile returned error \""..content.."\"") end
end
local function loadswimhubfile(file)
    if not isfile("swimhub/new/files/"..file) then return print("File \"".."swimhub/new/files/"..file.."\" not found.") end
    local success, returns = pcall(loadfile, "swimhub/new/files/"..file)
    if success then return returns else return print(returns) end
end
local function readdswimhubfile(file)
    if not isfile("swimhub/new/files/"..file) then return print("File \"".."swimhub/new/files/"..file.."\" not found.") end
    local success, returns = pcall(readfile, "swimhub/new/files/"..file)
    if success then return returns else return print(returns) end
end
local function getswimhubasset(file)
    if not isfile("swimhub/new/files/"..file) then return print("File \""..file.."\" not found.") end
    local success, returns = pcall(getcustomasset, "swimhub/new/files/"..file)
    if success then return returns else return print(returns) end
end
local function getfiles(force)
    if not isfolder("swimhub") then makefolder("swimhub") end
    if not isfolder("swimhub/new") then makefolder("swimhub/new") end
    if not isfolder("swimhub/new/files") then makefolder("swimhub/new/files") end
    local file_list = {
        "grad90r.png",
        "grad90l.png",
        "grad180u.png",
        "grad180d.png",
        "grad45lrd.png",
        "grad45lru.png",
        "grad45rld.png",
        "grad45rlu.png",
        "library_main.lua",
        "library_save.lua",
        "library_theme.lua",
        "esp_library.lua",
        "version.txt"
    }
    for _, file in pairs(file_list) do
        if (force or not force and not isfile("swimhub/new/files/"..file)) then
            writefile("swimhub/new/files/"..file, getfile(file))
        end
    end
end
getfiles(false)
local newversion = getfile("version.txt")
local currentversion = readdswimhubfile("version.txt")
if not (currentversion == newversion) then getfiles(true) end
-- swimhub main
local workspace = cloneref(game:GetService("Workspace"))
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local Lighting = cloneref(game:GetService("Lighting"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local GuiInset = cloneref(game:GetService("GuiService")):GetGuiInset()
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local cheat = {
    Library = nil,
    Toggles = nil,
    Options = nil,
    ThemeManager = nil,
    SaveManager = nil,
    connections = {
        heartbeats = {},
        renderstepped = {}
    },
    drawings = {},
    hooks = {}
}
cheat.utility = {} do
    cheat.utility.new_heartbeat = function(func)
        local obj = {}
        cheat.connections.heartbeats[func] = func
        function obj:Disconnect()
            cheat.connections.heartbeats[func] = nil
            func = nil
        end
        return obj
    end
    cheat.utility.new_renderstepped = function(func)
        local obj = {}
        cheat.connections.renderstepped[func] = func
        function obj:Disconnect()
            cheat.connections.renderstepped[func] = nil
            func = nil
        end
        return obj
    end
    cheat.utility.new_drawing = function(drawobj, args)
        local obj = Drawing.new(drawobj)
        for i, v in pairs(args) do
            obj[i] = v
        end
        cheat.drawings[obj] = obj
        return obj
    end
    cheat.utility.new_hook = function(f, newf, usecclosure) LPH_NO_VIRTUALIZE(function()
        if usecclosure then
            local old; old = hookfunction(f, newcclosure(function(...)
                return newf(old, ...)
            end))
            cheat.hooks[f] = old
            return old
        else
            local old; old = hookfunction(f, function(...)
                return newf(old, ...)
            end)
            cheat.hooks[f] = old
            return old
        end
    end)() end
    local connection; connection = RunService.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(delta)
        for _, func in pairs(cheat.connections.heartbeats) do
            func(delta)
        end
    end))
    local connection1; connection1 = RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(delta)
        for _, func in pairs(cheat.connections.renderstepped) do
            func(delta)
        end
    end))
    cheat.utility.unload = function()
        connection:Disconnect()
        connection1:Disconnect()
        for key, _ in pairs(cheat.connections.heartbeats) do
            cheat.connections.heartbeats[key] = nil
        end
        for key, _ in pairs(cheat.connections.renderstepped) do
            cheat.connections.heartbeats[key] = nil
        end
        for _, drawing in pairs(cheat.drawings) do
            drawing:Remove()
            cheat.drawings[_] = nil
        end
        for hooked, original in pairs(cheat.hooks) do
            if type(original) == "function" then
                hookfunction(hooked, clonefunction(original))
            else
                hookmetamethod(original["instance"], original["metamethod"], clonefunction(original["func"]))
            end
        end
    end
end
cheat.Library, cheat.Toggles, cheat.Options = loadswimhubfile("library_main.lua")()
cheat.ThemeManager = loadswimhubfile("library_theme.lua")()
cheat.SaveManager = loadswimhubfile("library_save.lua")()
local ui = {
    window = cheat.Library:CreateWindow({
        Title="swimhub free",
    Center=true,AutoShow=true,TabPadding=8})
}