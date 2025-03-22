local Repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Sirius/refs/heads/request/library/sense/source.lua'))()
Sense.Load()

local Library = loadstring(game:HttpGet(Repo .. 'Library.lua'))()
-- local Library = loadstring(readfile('Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(Repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(Repo .. 'addons/SaveManager.lua'))()

local Workspace = game:GetService('Workspace')
local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TeleportService = game:GetService('TeleportService')
local Stats = game:GetService('Stats')
local Lighting = game:GetService('Lighting')
local VirtualUser = game:GetService('VirtualUser')
local RunService = game:GetService('RunService')
local StarterGui = game:GetService('StarterGui')

-- TODO --
-- Add Fast attack
-- Add Hitbox Expander
-- Literally make an auto farm because thats the whole point of a blox fruits script? 😭😭😭😭😭😭
-- Smart Teleport from hoho hub?

-- Functions

local CameraShaker = require(ReplicatedStorage.Util.CameraShaker)
CameraShaker:Stop()
-- i cant make this a toggle, it turns off but doesnt turn on because idk how to turn it on again
-- i tried with CameraShaker:Play()

Players.LocalPlayer.Idled:Connect(function()
    print('Anti AFK saved your ass')
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

pcall(function()
    if Players.LocalPlayer.PlayerGui:FindFirstChild('Main (minimal)') then
        local MainUI = Players.LocalPlayer.PlayerGui['Main (minimal)']
        repeat task.wait()
            if MainUI.ChooseTeam.Visible == true then
                if TeamSelected == 'Pirates' then
                    for i, v in pairs(getconnections(MainUI.ChooseTeam.Container.Pirates.Frame.TextButton.Activated)) do
                        v.Function()
                    end
                elseif TeamSelected == 'Marines' then
                    for i, v in pairs(getconnections(MainUI.ChooseTeam.Container.Marines.Frame.TextButton.Activated)) do
                        v.Function()
                    end
                else
                    for i, v in pairs(getconnections(MainUI.ChooseTeam.Container.Pirates.Frame.TextButton.Activated)) do
                        v.Function()
                    end
                end
            end
        until Players.LocalPlayer.Team ~= nil and game:IsLoaded()
    end
end)

local function EquipTool(Tool)
    Players.LocalPlayer.Character.Humanoid:EquipTool(Players.LocalPlayer.Backpack[Tool])
end

local function AutoClick()
    print('Autoclicking (hell nah)')
    VirtualUser:CaptureController()
    VirtualUser:Button1Down(Vector2.new(960, 540))
end

local function BringMonster(TargetName, TargetCFrame)
    local sethiddenproperty = sethiddenproperty or (function(...) return ... end)
    for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == TargetName then
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < tonumber(BringDis) then
                    v.HumanoidRootPart.CFrame = TargetCFrame
                    -- v.HumanoidRootPart.CanCollide = false
                    -- v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                    -- v.HumanoidRootPart.Transparency = 1
                    -- v.Humanoid:ChangeState(11)
                    -- v.Humanoid:ChangeState(14)
                    if v.Humanoid:FindFirstChild("Animator") then
                        v.Humanoid.Animator:Destroy()
                    end
                    --sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                end
            end
        end
    end
    pcall(sethiddenproperty, game.Players.LocalPlayer, "SimulationRadius", math.huge)
end

task.spawn(function()
    while task.wait() do
        if BringMobs and (LevelFarmQuest or LevelFarmNoQuest) then
            pcall(function()
                BringMonster(Level_Farm_Name, Level_Farm_CFrame)
            end)

        elseif BringMobs and Farm_Bone then
            pcall(function()
                BringMonster(Bone_Farm_Name, Bone_Farm_CFrame)
            end)

        elseif BringMobs and Farm_Ectoplasm then
            pcall(function()
                BringMonster(Ecto_Farm_Name, Ecto_Farm_CFrame)
            end)

        elseif BringMobs and Nearest_Farm then
            pcall(function()
                BringMonster(Nearest_Farm_Name, Nearest_Farm_CFrame)
            end)

        elseif BringMobs and (SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm) then
            pcall(function()
                BringMonster(SelectMonster_Farm_Name, SelectMonster_Farm_CFrame)
            end)

        elseif BringMobs and Auto_Farm_Material then
            pcall(function()
                BringMonster(Material_Farm_Name, Material_Farm_CFrame)
            end)

        elseif BringMobs and (GunMastery_Farm or DevilMastery_Farm) then
            pcall(function()
                BringMonster(Mastery_Farm_Name, Mastery_Farm_CFrame)
            end)

        elseif BringMobs and AutoRengoku then
            pcall(function()
                BringMonster(Rengoku_Farm_Name, Rengoku_Farm_CFrame)
            end)

        elseif BringMobs and AutoCakePrince then
            pcall(function()
                BringMonster(CakePrince_Farm_Name, CakePrince_Farm_CFrame)
            end)

        elseif BringMobs and _G.AutoDoughKing then
            pcall(function()
                BringMonster(DoughKing_Farm_Name, DoughKing_Farm_CFrame)
            end)

        elseif BringMobs and AutoCitizen then
            pcall(function()
                BringMonster(Citizen_Farm_Name, Citizen_Farm_CFrame)
            end)

        elseif BringMobs and AutoEvoRace then
            pcall(function()
                BringMonster(EvoV2_Farm_Name, EvoV2_Farm_CFrame)
            end)

        elseif BringMobs and AutoBartilo then
            pcall(function()
                BringMonster(Bartilo_Farm_Name, Bartilo_Farm_CFrame)
            end)

        elseif BringMobs and AutoSoulGuitar then
            pcall(function()
                BringMonster(SoulGuitar_Farm_Name, SoulGuitar_Farm_CFrame)
            end)

        elseif BringMobs and AutoMusketeer then
            pcall(function()
                BringMonster(Musketere_Farm_Name, Musketere_Farm_CFrame)
            end)
            
        elseif BringMobs and AutoTrain then
            pcall(function()
                BringMonster(Ancient_Farm_Name, Ancient_Farm_CFrame)
            end)

        elseif BringMobs and AutoPirateCastle then
            pcall(function()
                BringMonster(PirateCastle_Name, PirateCastle_CFrame)
            end)
        elseif BringMobs and BlazeEmberFarm then
            pcall(function()
                BringMonster(BlazeEmber_Farm_Name, BlazeEmber_Farm_CFrame)
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Nearest_Farm then
            pcall(function()
                for i,v in pairs (Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if v.Name then
                            if (Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= 1000 then
                                repeat RunService.Heartbeat:Wait()
                                    EquipTool(SelectedWeapon)
                                    Tween(v.HumanoidRootPart.CFrame)
                                    Nearest_Farm_Name = v.Name
                                    Nearest_Farm_CFrame = v.HumanoidRootPart.CFrame
                                    AutoClick()
                                until not Nearest_Farm or not v.Parent or v.Humanoid.Health <= 0 or not Workspace.Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

local function GetNPCs()
    local NPCs = {}

    for i, v in pairs(Workspace.NPCs:GetChildren()) do
        if v:IsA('Model') then
            table.insert(NPCs, v.Name)
        end
    end

    for i, v in pairs(ReplicatedStorage.NPCs:GetChildren()) do
        if v:IsA('Model') then
            table.insert(NPCs, v.Name)
        end
    end

    table.sort(NPCs)
    return NPCs
end

local function GetIslands()
    local Islands = {}

    for i, v in pairs(Workspace.Map:GetChildren()) do
        if v:IsA('Model') then
            table.insert(Islands, v.Name)
        end
    end

    table.sort(Islands)
    return Islands
end

task.spawn(function()
    Workspace.DescendantAdded:Connect(function(fruit)
        if fruit.Name:find('Fruit') and fruit:IsA('Tool') then
            StarterGui:SetCore('SendNotification', {
                Title = 'Fruit Found: ' .. fruit.Name,
                Text = 'Auto Collect Fruits will get it for you',
                Duration = 5,
            })
        end
    end)
end)

local function fAutoCollectFruits()

    for i, v in pairs(Workspace:GetDescendants()) do
        if v.Name:find('Fruit') and v:IsA('Tool') then
            if v:FindFirstChild('Fruit') and v:FindFirstChild('Fruit'):IsA('Model') then
                print('Fruit:', v)
                local Fruit = v.Fruit.CFrame
            end
        end
    end

    Tween(Fruit)
end


local function fAutoCollectChests() -- tem que ficar mais rapido, assim que tocar no bau ja vai pra outro

    if Workspace.ChestModels:GetChildren() then
        for i, v in pairs(Workspace.ChestModels:GetChildren()) do
            if v.Name:find('Chest') and v:IsA('Model') then
                ChestModels = v.PrimaryPart.CFrame
            end
        end

        Tween(ChestModels)
    else
        for i, v in pairs(Workspace.Map:GetDescendants()) do
            if v.Name:find('Chest') and v:IsA('Part') and v.CanTouch then
                ChestPart = v.CFrame
            end
        end

        Tween(ChestPart)
    end
end

function Tween(Target)
    local RootPart = Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
    
    if RootPart and Target then
        
        if Target == TweenPlayer then
            Target = Workspace.Characters:FindFirstChild(TweenPlayer).PrimaryPart.CFrame
            
        elseif Target == TweenNPC then
            tOffsetX, tOffsetY, tOffsetZ = 0, 0, 0
            if Workspace.NPCs:FindFirstChild(TweenNPC) then
                Target = Workspace.NPCs:FindFirstChild(TweenNPC).PrimaryPart.CFrame
            else
                Target = ReplicatedStorage.NPCs:FindFirstChild(TweenNPC).PrimaryPart.CFrame
            end
            
        elseif Target == TweenIsland then
            Target = Workspace.Map:FindFirstChild(TweenIsland).WorldPivot
            
        elseif Target == ChestPart or ChestModels or Fruit then
            tOffsetX, tOffsetY, tOffsetZ = 0, 0, 0
        end
        local Distance = (Target.Position - Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

        local Tween = TweenService:Create(RootPart, TweenInfo.new((Distance - 150)/TweenSpeed, Enum.EasingStyle.Linear), {CFrame = Target + Vector3.new(tOffsetX, tOffsetY, tOffsetZ)})
        Tween:Play()
        Tween.Completed:Wait()
    end
end

-- UI Elements
task.wait(2)

StarterGui:SetCore('SendNotification', {
    Title = 'Fatality Loaded',
    Text = 'Fatality Loaded Successfully',
    Duration = '3',
})

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
    Visuals = Window:AddTab('Visuals'),
    Shop = Window:AddTab('Shop'),
    Misc = Window:AddTab('Misc'),
    Config = Window:AddTab('Config'),
}

local MenuGroup = Tabs.Config:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function()
    Library:Unload()
end)

MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'LeftControl', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind


-- Left Group Box Tweening
local Tweening = Tabs.Main:AddLeftGroupbox('Tweening')

Tweening:AddDropdown('PlayersDropdown', {SpecialType = 'Player', Text = 'Players', Callback = function(Value) end})

Options.PlayersDropdown:OnChanged(function()
    TweenPlayer = Options.PlayersDropdown.Value
end)


Tweening:AddToggle('SpectatePlayerToggle', {Text = 'Spectate Player', Default = false, Callback = function(Value) end})

Toggles.SpectatePlayerToggle:OnChanged(function()
    if Toggles.SpectatePlayerToggle.Value then
        Workspace.CurrentCamera.CameraSubject = Workspace.Characters[TweenPlayer]
    else
        Workspace.CurrentCamera.CameraSubject = Players.LocalPlayer.Character
    end
end)


Tweening:AddToggle('TweenToPlayersToggle', {Text = 'Tween To Players', Default = false, Callback = function(Value) end})

Toggles.TweenToPlayersToggle:OnChanged(function()
    while Toggles.TweenToPlayersToggle.Value do
        task.wait(1/60)
        Tween(TweenPlayer)
    end
end)


Tweening:AddDropdown('NPCsDropdown', {Values = GetNPCs(), Default = 'Barista Cousin', Multi = false, Text = 'NPCs', Callback = function(Value) end})

Options.NPCsDropdown:OnChanged(function()
    TweenNPC = Options.NPCsDropdown.Value
end)


Tweening:AddToggle('TweenToNPCToggle', {Text = 'Tween To NPC', Default = false, Callback = function(Value) end})

Toggles.TweenToNPCToggle:OnChanged(function()
    while Toggles.TweenToNPCToggle.Value do
        task.wait(1/60)
        Tween(TweenNPC)
    end
end)


Tweening:AddDropdown('IslandsDropdown', {Values = GetIslands(), Default = 'Boat Castle', Multi = false, Text = 'Islands', Callback = function(Value) end})

Options.IslandsDropdown:OnChanged(function()
    TweenIsland = Options.IslandsDropdown.Value
end)


Tweening:AddToggle('TweenToIslandToggle', { Text = 'Tween To Island', Default = false, Callback = function(Value) end})
Toggles.TweenToIslandToggle:OnChanged(function()
    while Toggles.TweenToIslandToggle.Value do
        task.wait(1/60)
        Tween(TweenIsland)
    end
end)


Tweening:AddSlider('TweenSpeed', {Text = 'Tween Speed', Default = 325, Min = 0, Max = 400, Rounding = 0, Compact = false,Callback = function(Value) end})
Options.TweenSpeed:OnChanged(function() TweenSpeed = Options.TweenSpeed.Value end)


Tweening:AddSlider('tOffsetX', {Text = 'Offset X', Default = 0, Min = 0, Max = 200, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.tOffsetX:OnChanged(function() tOffsetX = Options.tOffsetX.Value end)


Tweening:AddSlider('tOffsetY', {Text = 'Offset Y', Default = 20, Min = 0, Max = 200, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.tOffsetY:OnChanged(function() tOffsetY = Options.tOffsetY.Value end)


Tweening:AddSlider('tOffsetZ', {Text = 'Offset Z', Default = 0, Min = 0, Max = 200, Rounding = 0, Compact = false,Callback = function(Value) end})
Options.tOffsetZ:OnChanged(function() tOffsetZ = Options.tOffsetZ.Value end)


-- Auto Collect GroupBox
local AutoCollect = Tabs.Main:AddLeftGroupbox('Auto Collect')

AutoCollect:AddToggle('AutoCollectChests', {Text = 'Auto Collect Chests', Default = false, Callback = function(Value) end})
Toggles.AutoCollectChests:OnChanged(function()
    while Toggles.AutoCollectChests.Value do
        task.wait(1/60)
        fAutoCollectChests()
    end
end)


AutoCollect:AddToggle('AutoCollectFruit', {Text = 'Auto Collect Fruit', Default = false, Callback = function(Value) end})
Toggles.AutoCollectFruit:OnChanged(function()
    while Toggles.AutoCollectFruit.Value do
        task.wait(1/60)
        fAutoCollectFruits()
    end
end)


-- Local Player GroupBox
local LocalPlayerGroupBox = Tabs.Main:AddRightGroupbox('Local Player')

local Player = Players.LocalPlayer
local Humanoid = Player.Character.Humanoid
local HumanoidRootPart = Player.Character.HumanoidRootPart

Player.CharacterAdded:Connect(function(plr)
    local Humanoid = plr:WaitForChild("Humanoid")
    local HumanoidRootPart = plr:WaitForChild("HumanoidRootPart")
end)

LocalPlayerGroupBox:AddDropdown('Team', {Values = {'Pirates', 'Marines'}, Default = 'Pirates', Multi = false, Text = 'Team', Callback = function(Value) end})
Options.Team:OnChanged(function()
    TeamSelected = Options.Team.Value
end)


LocalPlayerGroupBox:AddButton({Text = 'Change Team', Func = function()
    if TeamSelected == 'Pirates' then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    elseif TeamSelected == 'Marines' then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    end
end})


LocalPlayerGroupBox:AddSlider('SpeedHack', {Text = 'WalkSpeed', Default = Humanoid.WalkSpeed, Min = 0, Max = 400, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.SpeedHack:OnChanged(function()
    Humanoid.WalkSpeed = Options.SpeedHack.Value
end)


LocalPlayerGroupBox:AddSlider('JumpHack', {Text = 'JumpPower', Default = Humanoid.JumpPower, Min = 0, Max = 600, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.JumpHack:OnChanged(function()
    Humanoid.JumpPower = Options.JumpHack.Value
end)


LocalPlayerGroupBox:AddSlider('GravitySlider', {Text = 'Gravity', Default = Workspace.Gravity, Min = 0, Max = 1000, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.GravitySlider:OnChanged(function()
    Workspace.Gravity = Options.GravitySlider.Value
end)

LocalPlayerGroupBox:AddSlider('FrictionSlider', {Text = 'Friction', Default = HumanoidRootPart.CustomPhysicalProperties.Density, Min = 0, Max = 100, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.FrictionSlider:OnChanged(function()
    local currentProperties = HumanoidRootPart.CustomPhysicalProperties

    HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(
        Options.FrictionSlider.Value,
        currentProperties.Friction,
        currentProperties.Elasticity,
        currentProperties.FrictionWeight,
        currentProperties.ElasticityWeight
    )
end)

-- Ultra mega anti cheat bypass (this is healthier than looping it with while/task.wait/heartbeat btw) learn scripters, learn
--------------------------------------------------
Workspace:GetPropertyChangedSignal('Gravity'):Connect(function()
    Workspace.Gravity = Options.GravitySlider.Value
end)

Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(function()
    Humanoid.WalkSpeed = Options.SpeedHack.Value
end)

Humanoid:GetPropertyChangedSignal('JumpPower'):Connect(function()
    Humanoid.JumpPower = Options.JumpHack.Value
end)
HumanoidRootPart:GetPropertyChangedSignal('CustomPhysicalProperties'):Connect(function()
    local currentProperties = HumanoidRootPart.CustomPhysicalProperties

    HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(
        Options.FrictionSlider.Value,
        currentProperties.Friction,
        currentProperties.Elasticity,
        currentProperties.FrictionWeight,
        currentProperties.ElasticityWeight
    )
end)
--------------------------------------------------


LocalPlayerGroupBox:AddSlider('UnlimitedZoom', {Text = 'Zoom Distance', Default = Player.CameraMaxZoomDistance, Min = 1, Max = 10000, Rounding = 0, Compact = false, Callback = function(Value) end})
Options.UnlimitedZoom:OnChanged(function()
    Player.CameraMaxZoomDistance = Options.UnlimitedZoom.Value
end)


LocalPlayerGroupBox:AddToggle('NoclipCam', {Text = 'Noclip Camera', Default = true, Callback = function(Value) end})
Toggles.NoclipCam:OnChanged(function()
    if Toggles.NoclipCam.Value then
        Player.DevCameraOcclusionMode = 'Invisicam'
    else
        Player.DevCameraOcclusionMode = 'Zoom'
    end
end)


LocalPlayerGroupBox:AddToggle('WalkOnWater', {Text = 'Walk on Water', Default = true, Callback = function(Value) end})
Toggles.WalkOnWater:OnChanged(function()
    if Toggles.WalkOnWater.Value then
        Workspace.Map['WaterBase-Plane'].Size = Vector3.new(1000,112,1000)
    else
        Workspace.Map['WaterBase-Plane'].Size = Vector3.new(1000,80,1000)
    end
end)


local originalLighting = {}
local dFogStart = Lighting.FogStart
local dFogEnd = Lighting.FogEnd
for i, v in pairs(Lighting:GetDescendants()) do
    if v:IsA('Atmosphere') then
        table.insert(originalLighting, v:Clone())
    end
end


LocalPlayerGroupBox:AddToggle('DelFog', {Text = 'Remove Weather/Fog', Default = true, Callback =  function(Value) end})
Toggles.DelFog:OnChanged(function()
    if Toggles.DelFog.Value then
    
        Lighting.FogStart = math.huge
        Lighting.FogEnd = math.huge

        Lighting:GetPropertyChangedSignal('FogStart'):Connect(function()
            Lighting.FogStart = math.huge
        end)
        Lighting:GetPropertyChangedSignal('FogEnd'):Connect(function()
            Lighting.FogEnd = math.huge
        end)

        for i, v in pairs(Lighting:GetDescendants()) do
            if v:IsA('Atmosphere') then
                v:Destroy()
            end
        end

        Lighting.DescendantAdded:Connect(function(Descendant)
            if Descendant:IsA('Atmosphere') then
                Descendant:Destroy()
            end
        end)
    else -- restore
        if antifog then
            Lighting.DescendantAddedConnection:Disconnect()
            Lighting.DescendantAddedConnection = nil
        end
        Lighting.FogStart = dFogStart
        Lighting.FogEnd = dFogEnd
        for i, v in pairs(originalLighting) do
            v.Parent = Lighting
        end
    end
end)


LocalPlayerGroupBox:AddToggle('DelKenBlur', {Text = 'Remove Instinct Blur', Default = true, Callback = function(Value) end})
Toggles.DelKenBlur:OnChanged(function()
    if Toggles.DelKenBlur.Value then

        Lighting.Blur:GetPropertyChangedSignal('Enabled'):Connect(function()
            Lighting.Blur.Enabled = false
        end)

        for i, v in pairs(Lighting:GetChildren()) do
            if v:IsA('ColorCorrectionEffect') then
                v:GetPropertyChangedSignal('Enabled'):Connect(function()
                    v.Enabled = false
                end)
            end
        end
    end -- ken blur restores itself
end)


LocalPlayerGroupBox:AddToggle('Noclip', {Text = 'Noclip', Default = false, Callback = function(Value) end})
Toggles.Noclip:OnChanged(function()
    if Toggles.Noclip.Value then
        for i, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA('BasePart') and v.CanCollide == true then
                v.CanCollide = false
            end
        end
    else
        for i, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA('BasePart') and v.CanCollide == false then
                v.CanCollide = true
            end
        end
    end
end)


-- Servers GroupBox
local Servers = Tabs.Main:AddRightGroupbox('Servers')

Servers:AddButton({Text = 'Travel to First Sea', Func = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer('TravelMain')
end})

Servers:AddButton({Text = 'Travel to Second Sea', Func = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer('TravelDressrosa')
end})

Servers:AddButton({Text = 'Travel to Third Sea', Func = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer('TravelZou')
end})

Servers:AddButton({Text = 'Server Hop', Func = function()
    -- infinite yield server hop ofc
    local PlaceId = game.PlaceId
    local JobId = game.JobId
    local HttpService = game:GetService('HttpService')
    local HttpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    
    if HttpRequest then
        local servers = {}
        local req = HttpRequest({Url = string.format('https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true', PlaceId)})
        local body = HttpService:JSONDecode(req.Body)
        
        if body and body.data then
            for i, v in next, body.data do
                if type(v) == 'table' and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end
        
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
        else
            print('Couldnt find a server.')
        end
    end
end})

Servers:AddButton({Text = 'Rejoin', Func = function()
    -- infinite yield rejoin ofc
    local PlaceId = game.PlaceId
    local JobId = game.JobId
    
    if #Players:GetPlayers() <= 1 then
        Players.LocalPlayer:Kick('\nRejoining...')
        wait()
        TeleportService:Teleport(PlaceId, Players.LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
    end
end})


-- Scripts Groupbox
local Scripts = Tabs.Main:AddRightGroupbox('Scripts')

Scripts:AddButton({Text = 'Infinite Yield', Func = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end})

Scripts:AddButton({Text = 'Dex Explorer', Func = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
end})

Scripts:AddButton({Text = 'Remote Spy', Func = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua'))()
end})

-- Auto Farm Tab
local AutoFarmSettings = Tabs.AutoFarm:AddLeftGroupbox('Auto Farm Settings')

local WeaponList = {'Melee', 'Blox Fruit', 'Sword', 'Gun'}

AutoFarmSettings:AddDropdown('Weapon', {Values = WeaponList, Default = 1, Multi = false, Text = 'Weapons', Callback = function(Value) end})

Options.Weapon:OnChanged(function()
    SelectWeaponFarm = Options.Weapon.Value

    if SelectWeaponFarm == 'Melee' then
        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == 'Melee' then
                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                    SelectedWeapon = v.Name
                end
            end
        end
    elseif SelectWeaponFarm == 'Sword' then
        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == 'Sword' then
                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                    SelectedWeapon = v.Name
                end
            end
        end
    elseif SelectWeaponFarm == 'Blox Fruit' then
        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == 'Blox Fruit' then
                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                    SelectedWeapon = v.Name
                end
            end
        end
    elseif SelectWeaponFarm == 'Gun' then
        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == 'Gun' then
                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                    SelectedWeapon = v.Name
                end
            end
        end
    end
end)

AutoFarmSettings:AddToggle('BringMobs', {Text = 'Bring Mobs', Default = false, Callback = function(Value) end})

Toggles.BringMobs:OnChanged(function()
    BringMobs = Toggles.BringMobs.Value
end)


AutoFarmSettings:AddSlider('BringRange', {Text = 'Bring Mobs Range', Default = 250, Min = 0, Max = 500, Rounding = 0, Compact = false,Callback = function(Value) end})
Options.BringRange:OnChanged(function()
    BringDis = Options.BringRange.Value
end)

local AutoFarm = Tabs.AutoFarm:AddLeftGroupbox('Auto Farm')
AutoFarm:AddToggle('AutoFarmToggle', {Text = 'Auto Farm (Placeholder)', Default = false, Callback = function(Value) end})
Toggles.AutoFarmToggle:OnChanged(function()

end)


AutoFarm:AddToggle('AutoFarmNearestToggle', {Text = 'Auto Farm Nearest', Default = false, Callback = function(Value) end})
Toggles.AutoFarmNearestToggle:OnChanged(function()
    Nearest_Farm = Toggles.AutoFarmNearestToggle.Value
end)


AutoFarm:AddToggle('BonesFarm', {Text = 'Auto Farm Bones', Default = false, Callback = function(Value) end})
Toggles.BonesFarm:OnChanged(function()
    Bone_Farm = Toggles.BonesFarm.Value
end)

-- Misc Tab
local Misc = Tabs.Misc:AddLeftGroupbox('Misc')

-- Shop Tab
local Shop = Tabs.Shop:AddLeftGroupbox('Shop')

Shop:AddToggle('RandomSurprise', {Text = 'Auto Random Surprise', Default = false, Callback = function(Value) end})
Toggles.RandomSurprise:OnChanged(function()
    while Toggles.RandomSurprise.Value do
        local args = {
            [1] = 'Bones',
            [2] = 'Buy',
            [3] = 1,
            [4] = 1
        }
        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    end
end)

-- Visuals Tab
Sense.teamSettings.enemy.box = false
Sense.teamSettings.enemy.healthBar = true
Sense.teamSettings.enemy.healthText = true
Sense.teamSettings.enemy.box3d = true
Sense.teamSettings.enemy.name = true
Sense.teamSettings.enemy.distance = true
Sense.teamSettings.enemy.chams = true

local Visuals = Tabs.Visuals:AddLeftGroupbox('Visuals')

Visuals:AddToggle('Wallhack', {Text = 'Sense ESP Master Switch', Default = false, Callback = function(Value) end})

Toggles.Wallhack:OnChanged(function()
    if Toggles.Wallhack.Value then
        Sense.teamSettings.enemy.enabled = true
    else
        Sense.teamSettings.enemy.enabled = false
    end
end)

-- Library functions
Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = RunService.RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;
    
    Library:SetWatermark(('fatality.win | %s fps | %s ms | | %s RAM | %s'):format(
        math.floor(Stats.Workspace.Heartbeat:GetValue()),
        math.floor(Stats.PerformanceStats.Ping:GetValue()),
        math.floor(Stats.PerformanceStats.Memory:GetValue()),
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