local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local useServerHop = false
local timeout = 60 -- seconds
-- serverhop timeout in case it glitches for any reason
-- it shouldnt take more than 1 minute to spend all the dodges

task.wait(3)

repeat task.wait()
    if Players.LocalPlayer.PlayerGui:FindFirstChild('Main (minimal)') then
        local Main = Players.LocalPlayer.PlayerGui['Main (minimal)']
        if Main.ChooseTeam.Visible == true then
            for i, v in pairs(getconnections(Main.ChooseTeam.Container.Pirates.Frame.TextButton.Activated)) do
                v.Function()
            end
        end
    end
until Players.LocalPlayer.Team ~= nil and game:IsLoaded()

task.wait(2)

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

local function Ken()
    while task.wait() do
        local KenActive = plr:GetAttribute('KenActive')
        if not KenActive then
            VirtualInputManager:SendKeyEvent(true, "E", false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, "E", false, game)
        end
    end
end

task.spawn(Ken)

local function getNearestEnemy()
    local nearestEnemy = nil

    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name:find('Shanda') and v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
            nearestEnemy = v.HumanoidRootPart
            break
        end
    end

    if not nearestEnemy then
        for _, v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
            if v.Name:find('Shanda') and v:IsA("Part") then
                nearestEnemy = v
                break
            end
        end
    end

    return nearestEnemy
end

local function tweenToPosition(target)
    local info = TweenInfo.new((plr:DistanceFromCharacter(target.CFrame.Position))/340, Enum.EasingStyle.Linear)
    local t = TweenService:Create(root, info, {CFrame = target.CFrame})
    t:Play()
    t.Completed:Wait()
end

local function serverHop()
    while task.wait() do
        local PlaceId = game.PlaceId
        local JobId = game.JobId

        if not useServerHop then
            print('Rejoining 🥀')
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, plr)
            break
        end

        print('Server Shopping 🛒🛒👨‍🦯🏃‍♂️')

        local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        
        if httprequest then
            local servers = {}
            local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId)})
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
                print("Serverhop", "Couldn't find a server.")
            end
        end
        task.wait(1)
    end
end

local function startClock()
    local startTime = os.time()
    task.spawn(function()
        while task.wait(1) do
            if os.time() - startTime > timeout then
                serverHop()
                break
            end
        end
    end)
end

startClock()

while task.wait(1) do
    local dodges = plr:GetAttribute('KenDodgesLeft')
    local tar = getNearestEnemy()
    print('tar', tar)
    if tar and dodges > 0 then
        tweenToPosition(tar)
    else
        serverHop()
        break
    end
end