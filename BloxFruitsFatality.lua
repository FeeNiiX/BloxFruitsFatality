local Repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(Repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(Repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(Repo .. 'addons/SaveManager.lua'))()

local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TeleportService = game:GetService('TeleportService')

-- TODO --
-- Remove weather/fog
-- Add Fast attack
-- Add Hitbox Expander
-- Literally make an auto farm because thats the whole point of a blox fruits script? 😭😭😭😭😭😭
-- Smart Teleport from hoho hub?

-- Functions

function GetNPCs()
    local NPCs = {}
    for _,v in pairs(ReplicatedStorage.NPCs:GetChildren()) do
        if v:IsA('Model') then
            table.insert(NPCs, v.Name)
        end
    end
    for _,v in pairs(workspace.NPCs:GetChildren()) do
        if v:IsA('Model') then
            table.insert(NPCs, v.Name)
        end
    end
    return NPCs
end

function GetIslands()
    local Islands = {}
    for _,v in pairs(workspace.Map:GetChildren()) do
        if v:IsA('Model') then
            table.insert(Islands, v.Name)
        end
    end
    return Islands
end

function GetFruits()
    for _,v in pairs(workspace:GetChildren()) do
        if v.Name:find("Fruit") then
            for _, v in pairs(v:GetChildren()) do
                if v.Name:find('Fruit') and v:IsA('Model') then
                    Fruits = v.PrimaryPart.CFrame
                end
            end
        end
    end
    return Fruits
end

function GetChests()
    for _,v in pairs(workspace:GetDescendants()) do
        if v.Name:find('Chest') and v:IsA('Model') and v:FindFirstChild('PrimaryPart') then
            Chests = v.PrimaryPart.CFrame.Position
        elseif v.Name:find('Chest') and v:IsA('Part') and v.CanTouch then
            Chests = v.CFrame
        end
    end
    return Chests
end

function TweenToPosition(Target)
    local plr = Players.LocalPlayer
    local t = game.TweenService
    local chr = plr.Character
    
    if chr.HumanoidRootPart and Target then
        if Target == TweenPlayer then
            Target = workspace.Characters:FindFirstChild(TweenPlayer).PrimaryPart.CFrame
        elseif Target == TweenNPC then
            tOffsetX, tOffsetY, tOffsetZ = 0, 0, 0
            if ReplicatedStorage.NPCs:FindFirstChild(TweenNPC) then
                Target = ReplicatedStorage.NPCs:FindFirstChild(TweenNPC).PrimaryPart.CFrame
            else
                Target = workspace.NPCs:FindFirstChild(TweenNPC).PrimaryPart.CFrame
            end
        elseif Target == TweenIsland then
            tOffsetX, tOffsetY, tOffsetZ = 0, 100, 100
            Target = workspace.Map:FindFirstChild(TweenIsland).WorldPivot
        else
            tOffsetX, tOffsetY, tOffsetZ = 0, 0, 0
            Target = Target
        end
        
        t:Create(chr.HumanoidRootPart, TweenInfo.new((plr:DistanceFromCharacter(Target.Position)-200)/TweenSpeed, Enum.EasingStyle.Linear), {CFrame = Target + Vector3.new(tOffsetX, tOffsetY, tOffsetZ)}):Play()
    end
end

function WalkOnWaterPart()
    local part = Instance.new("Part")
    part.Size = Vector3.new(100, 1, 100)
    part.Anchored = true
    part.CanCollide = true
    part.Transparency = 1
    part.Parent = workspace

    game:GetService('RunService').Heartbeat:Connect(function()
        if part then
            local HumanoidRootPart = Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
            part.Position = Vector3.new(HumanoidRootPart.Position.X, -4, HumanoidRootPart.Position.Z)
        end
    end)
end

-- UI Elements

local Window = Library:CreateWindow({
    Title = 'fatality.win',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0
})

local Tabs = {
    Main = Window:AddTab('Main'),
    AutoFarm = Window:AddTab('AutoFarm'),
    Config = Window:AddTab('Config'),
}

local MenuGroup = Tabs.Config:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() 
    if workspace:FindFirstChild('Part') then
        workspace.Part:Destroy()
    end
    Library:Unload()
end)

-- Left Group Box Tweening
--------------------------------------------------
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Tweening')

-- Players Dropdown
--------------------------------------------------
LeftGroupBox:AddDropdown('PlayersDropdown', { SpecialType = 'Player', Text = 'Players', Callback = function(Value) end})
Options.PlayersDropdown:OnChanged(function() TweenPlayer = Options.PlayersDropdown.Value end)
--------------------------------------------------

-- Tween To Players Toggle
--------------------------------------------------
LeftGroupBox:AddToggle('TweenToPlayersToggle', { Text = 'Tween To Players', Default = false, Callback = function(Value) end})

Toggles.TweenToPlayersToggle:OnChanged(function()
    while Toggles.TweenToPlayersToggle.Value do
        task.wait(0.016)
        TweenToPosition(TweenPlayer)
    end
end)
--------------------------------------------------

-- Tween To NPCs Dropdown
--------------------------------------------------
LeftGroupBox:AddDropdown('NPCsDropdown', { Values = GetNPCs(), Default = 'Barista Cousin', Multi = false, Text = 'NPCs', Callback = function(Value) end})
Options.NPCsDropdown:OnChanged(function() TweenNPC = Options.NPCsDropdown.Value end)
--------------------------------------------------

-- Tween To NPCs Toggle
--------------------------------------------------
LeftGroupBox:AddToggle('TweenToNPCToggle', { Text = 'Tween To NPC', Default = false, Callback = function(Value) end})

Toggles.TweenToNPCToggle:OnChanged(function()
    while Toggles.TweenToNPCToggle.Value do
        task.wait(0.016)
        TweenToPosition(TweenNPC)
    end
end)
--------------------------------------------------

-- Tween To Island Dropdown
--------------------------------------------------
LeftGroupBox:AddDropdown('IslandsDropdown', { Values = GetIslands(), Default = 'Boat Castle', Multi = false, Text = 'Islands', Callback = function(Value) end})
Options.IslandsDropdown:OnChanged(function() TweenIsland = Options.IslandsDropdown.Value end)
--------------------------------------------------

-- Tween To Island Toogle
--------------------------------------------------
LeftGroupBox:AddToggle('TweenToIslandToggle', { Text = 'Tween To Island', Default = false, Callback = function(Value) end})

Toggles.TweenToIslandToggle:OnChanged(function()
    while Toggles.TweenToIslandToggle.Value do
        task.wait(0.016)
        TweenToPosition(TweenIsland)
    end
end)
--------------------------------------------------

-- Tween Speed Slider
--------------------------------------------------

LeftGroupBox:AddSlider('TweenSpeed', {Text = 'Tween Speed', Default = 300, Min = 0, Max = 400, Rounding = 0, Compact = false,Callback = function(Value) end})
Options.TweenSpeed:OnChanged(function() TweenSpeed = Options.TweenSpeed.Value end)

LeftGroupBox:AddSlider('tOffsetX', {Text = 'Offset X', Default = 0, Min = 0, Max = 200, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.tOffsetX:OnChanged(function() tOffsetX = Options.tOffsetX.Value end)

LeftGroupBox:AddSlider('tOffsetY', {Text = 'Offset Y', Default = 20, Min = 0, Max = 200, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.tOffsetY:OnChanged(function() tOffsetY = Options.tOffsetY.Value end)

LeftGroupBox:AddSlider('tOffsetZ', {Text = 'Offset Z', Default = 0, Min = 0, Max = 200, Rounding = 0, Compact = false,Callback = function(Value) end})
Options.tOffsetZ:OnChanged(function() tOffsetZ = Options.tOffsetZ.Value end)

-- Auto Collect Group Box
--------------------------------------------------
local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox('Auto Collect')

LeftGroupBox2:AddToggle('AutoCollectChests', {Text = 'Auto Collect Chests', Default = false, Callback = function(Value) end})

Toggles.AutoCollectChests:OnChanged(function()
    while Toggles.AutoCollectChests.Value do
        task.wait(0.1)
        TweenToPosition(GetChests())
    end
end)

LeftGroupBox2:AddToggle('AutoCollectFruit', {Text = 'Auto Collect Fruit', Default = false, Callback = function(Value) end})
Toggles.AutoCollectFruit:OnChanged(function()
    while Toggles.AutoCollectFruit.Value do
        task.wait(0.1)
        TweenToPosition(GetFruits())
    end
end)
--------------------------------------------------

-- Local Player GroupBox
--------------------------------------------------
local RightGroupbox = Tabs.Main:AddRightGroupbox('Local Player');

local WalkSpeed = Players.LocalPlayer.Character:FindFirstChild('Humanoid').WalkSpeed
local JumpPower = Players.LocalPlayer.Character:FindFirstChild('Humanoid').JumpPower
local CameraMaxZoom = Players.LocalPlayer.CameraMaxZoomDistance

RightGroupbox:AddSlider('Walkspeed', {Text = 'Walkspeed', Default = WalkSpeed, Min = 0, Max = 200, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.Walkspeed:OnChanged(function()
    Players.LocalPlayer.Character.Humanoid.WalkSpeed = Options.Walkspeed.Value
end)

RightGroupbox:AddSlider('JumpPower', {Text = 'Jump Power', Default = JumpPower, Min = 0, Max = 200, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.JumpPower:OnChanged(function()
    Players.LocalPlayer.Character.Humanoid.JumpPower = Options.JumpPower.Value
end)

game:GetService('RunService').RenderStepped:Connect(function()
    Players.LocalPlayer.Character.Humanoid.WalkSpeed = Options.Walkspeed.Value
    Players.LocalPlayer.Character.Humanoid.JumpPower = Options.JumpPower.Value
end)

RightGroupbox:AddToggle('NoclipCam', {Text = 'Noclip Camera', Default = true, Callback = function(Value) end})

Toggles.NoclipCam:OnChanged(function()
    if Toggles.NoclipCam.Value then
        Players.LocalPlayer.DevCameraOcclusionMode = 'Invisicam'
    else
        Players.LocalPlayer.DevCameraOcclusionMode = 'Zoom'
    end
end)

RightGroupbox:AddToggle('UnlimitedZoom', {Text = 'Unlimited Zoom', Default = true, Callback = function(Value) end})

Toggles.UnlimitedZoom:OnChanged(function()
    if Toggles.UnlimitedZoom.Value then
        Players.LocalPlayer.CameraMaxZoomDistance = CameraMaxZoom * 20
    else
        Players.LocalPlayer.CameraMaxZoomDistance = CameraMaxZoom
    end
    -- 😰
end)

RightGroupbox:AddToggle('WalkOnWater', { Text = 'Walk on Water', Default = true, Callback = function(Value) end})

Toggles.WalkOnWater:OnChanged(function()
    if Toggles.WalkOnWater.Value then
        WalkOnWaterPart()
    elseif workspace:FindFirstChild('part') then
        workspace.Part:Destroy()
    end
end)


RightGroupbox:AddButton({ Text = 'Server Hop', Func = function()
    -- infinite yield server hop ofc
    local PlaceId = game.PlaceId
    local JobId = game.JobId
    local HttpService = game:GetService('HttpService')
    local HttpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    
    if HttpRequest then
        local servers = {}
        local req = HttpRequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId)})
        local body = HttpService:JSONDecode(req.Body)
        
        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end
        
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
        else
            print("Couldn't find a server.")
        end
    end
end})

RightGroupbox:AddButton({ Text = 'Rejoin', Func = function()
    -- infinite yield rejoin ofc
    local PlaceId = game.PlaceId
    local JobId = game.JobId
    
    if #Players:GetPlayers() <= 1 then
        Players.LocalPlayer:Kick("\nRejoining...")
        wait()
        TeleportService:Teleport(PlaceId, Players.LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
    end
end})

local RightGroupbox2 = Tabs.Main:AddRightGroupbox('Scripts')

RightGroupbox2:AddButton({ Text = 'Infinite Yield', Func = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end})

RightGroupbox2:AddButton({ Text = 'Dex Explorer', Func = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
end})

RightGroupbox2:AddButton({ Text = 'Remote Spy', Func = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua'))()
end})

-- Auto Farm Group Box
--------------------------------------------------
local LeftGroupBox3 = Tabs.AutoFarm:AddLeftGroupbox('Auto Farm (Placeholder)')

LeftGroupBox3:AddToggle('AutoFarmToggle', {Text = 'Auto Farm', Default = false, Callback = function(Value) end})
Toggles.AutoFarmToggle:OnChanged(function() end)
--------------------------------------------------

-- Library functions

Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;
    
    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;
    
    Library:SetWatermark(('fatality.win | %s fps | %s ms | | %s RAM | %s'):format(
        math.floor(game:GetService("Stats").Workspace.Heartbeat:GetValue()),
        math.floor(game:GetService("Stats").PerformanceStats.Ping:GetValue()),
        math.floor(game:GetService("Stats").PerformanceStats.Memory:GetValue()),
        os.date('%X')
    ));
end);

Library.KeybindFrame.Visible = true;

Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI Settings
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Home', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('FatalityWin')
SaveManager:SetFolder('FatalityWin/BloxFruits')

SaveManager:BuildConfigSection(Tabs['Config'])

ThemeManager:ApplyToTab(Tabs['Config'])

ThemeManager:ApplyTheme('Fatality')

SaveManager:LoadAutoloadConfig()
