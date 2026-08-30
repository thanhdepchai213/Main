do
  ply = game.Players
  plr = ply.LocalPlayer
  Root = plr.Character.HumanoidRootPart
  replicated = game:GetService("ReplicatedStorage")
  Lv = game.Players.LocalPlayer.Data.Level.Value
  TeleportService = game:GetService("TeleportService")
  TW = game:GetService("TweenService")
  Lighting = game:GetService("Lighting")
  Enemies = workspace.Enemies
  vim1 = game:GetService("VirtualInputManager")
  vim2 = game:GetService("VirtualUser")
  TeamSelf = plr.Team
  RunSer = game:GetService("RunService")
  Stats = game:GetService("Stats")
  Energy = plr.Character.Energy.Value
  BringConnections = {}
  BossList = {}
  MaterialList = {}
  NPCList = {}
  shouldTween = false
  SoulGuitar = false
  KenTest = true
  debug = false
  Brazier1 = false
  Brazier2 = false
  Brazier3 = false
  Sec = 0.1
  ClickState = 0
  Num_self = 25
end
repeat local start = plr.PlayerGui:WaitForChild("Main"):WaitForChild("Loading") and game:IsLoaded() wait() until start
World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089
Sea = World1 or World2 or World3
Marines = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Marines") end
Pirates = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Pirates") end
if World1 then BossList = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
elseif World2 then BossList = {"Diamond","Jeremy","Orbitus","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
elseif World3 then BossList = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Dough King","Longma","Soul Reaper","Tyrant of the Skies"}
end
if World1 then MaterialList = {"Leather + Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail"}
elseif World2 then MaterialList = {"Leather + Scrap Metal", "Radioactive Material", "Ectoplasm", "Mystic Droplet", "Magma Ore", "Vampire Fang"}
elseif World3 then MaterialList = {"Scrap Metal", "Demonic Wisp", "Conjured Cocoa", "Dragon Scale", "Gunpowder", "Fish Tail", "Mini Tusk"}
end
Remotes = {
    RFSubmarineWorkerSpeak = replicated.Modules.Net["RF/SubmarineWorkerSpeak"],
    RFJobsRemoteFunction = replicated.Modules.Net["RF/JobsRemoteFunction"], 
    RFCraft = replicated:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/Craft")
}
DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
RenMon = {"Snow Lurker","Arctic Warrior","Hidden Key","Awakened Ice Admiral"}
CursedTables = {["Mob"] = "Mythological Pirate",["Mob2"] = "Cursed Skeleton","Hell's Messenger",["Mob3"] = "Cursed Skeleton","Heaven's Guardian"}
Past = {"Part","SpawnLocation","Terrain","WedgePart","MeshPart"}
BartMon = {"Swan Pirate","Jeremy"}
CitizenTable = {"Forest Pirate","Captain Elephant"}
Human_v3_Mob = {"Fajita","Jeremy","Diamond"}
AllBoats = {"Beast Hunter","Lantern","Guardian","Grand Brigade","Dinghy","Sloop","The Sentinel"}
mastery1 = {"Cookie Crafter"}
mastery2 = {"Reborn Skeleton"}
PosMsList = {["Pirate Millionaire"] = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625),["Pistol Billionaire"] = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625),["Dragon Crew Warrior"] = CFrame.new(7021.50439453125, 55.76270294189453, -730.1290893554688),["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),["Venomous Assailant"] = CFrame.new(4902, 670, 39), ["Marine Commodore"] = CFrame.new(2401, 123, -7589),["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),["Fishman Raider"] = CFrame.new(-10941, 332, -8760),["Fishman Captain"] = CFrame.new(-11035, 332, -9087),["Forest Pirate"] = CFrame.new(-13446, 413, -7760),["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),["Living Zombie"] = CFrame.new(-10227, 421, 6161),["Demonic Soul"] = CFrame.new(-9579, 6, 6194),["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),["Peanut Scout"] = CFrame.new(-1993, 187, -10103),["Peanut President"] = CFrame.new(-2215, 159, -10474),["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),["Cake Guard"] = CFrame.new(-2024, 38, -12026),["Baking Staff"] = CFrame.new(-1932, 38, -12848),["Head Baker"] = CFrame.new(-1932, 38, -12848),["Cocoa Warrior"] = CFrame.new(95, 73, -12309),["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),["Sweet Thief"] = CFrame.new(116, 36, -12478),["Candy Rebel"] = CFrame.new(47, 61, -12889),["Ghost"] = CFrame.new(5251, 5, 1111)}
EquipWeapon = function(text)
  if not text then return end
  if plr.Backpack:FindFirstChild(text) then
	plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(text))
  end
end
weaponSc = function(weapon)
  for __in, v in pairs(plr.Backpack:GetChildren()) do
    if v:IsA("Tool") then
      if v.ToolTip == weapon then EquipWeapon(v.Name) end
    end
  end
end
hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death),function() end)
hookfunction(require(game:GetService("ReplicatedStorage"):WaitForChild("GuideModule")).ChangeDisplayedNPC,function()end)
hookfunction(error, function()end)
hookfunction(warn, function()end)
Rock = workspace:FindFirstChild("Rocks")
if Rock then Rock:Destroy()end
gay = (function()
  local lightingLayers = nil
  local lighting = game:GetService("Lighting")
  lightingLayers = lighting:FindFirstChild("LightingLayers")

  if lightingLayers then
    local darkFog = lightingLayers:FindFirstChild("DarkFog")
    if darkFog then darkFog:Destroy() end
  end
end)()       -- ← thêm dòng này
-- deg
Attack = {}
Attack.__index = Attack
Attack.Alive = function(model) if not model or not model.Parent then return end local Humanoid = model:FindFirstChild("Humanoid") return Humanoid and Humanoid.Health > 0 end
Attack.Pos = function(model, dist)
  return (Root.Position - model.Position).Magnitude <= dist
end
Attack.Dist = function(model,dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist end
Attack.DistH = function(model,dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude > dist end
Attack.Kill = function(model,Succes)
  if model and model.Parent and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  EquipWeapon(_G.SelectWeapon)
  local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
  local ToolTip = Equipped.ToolTip
  if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0) * CFrame.Angles(0,math.rad(180),0))end
  if RandomCFrame then wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
Attack.Kill2 = function(model,Succes)
  if model and model.Parent and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  EquipWeapon(_G.SelectWeapon)
  local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
  local ToolTip = Equipped.ToolTip
  if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,8) * CFrame.Angles(0,math.rad(180),0))end
  if RandomCFrame then wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
Attack.KillSea = function(model,Succes)
  if model and model.Parent and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  EquipWeapon(_G.SelectWeapon)
  local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
  local ToolTip = Equipped.ToolTip
  if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else notween(model.HumanoidRootPart.CFrame * CFrame.new(0,50,8)) wait(.85)notween(model.HumanoidRootPart.CFrame * CFrame.new(0,400,0)) wait(1)end
  end
end
Attack.Sword = function(model,Succes)
  if model and model.Parent and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  weaponSc("Sword")
  _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
  if RandomCFrame then wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
Attack.Mas = function(model,Succes)
  if model and model.Parent and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
    if model.Humanoid.Health <= HealthM then
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
      Useskills("Blox Fruit","Z")
      Useskills("Blox Fruit","X")
      Useskills("Blox Fruit","C")
    else
      weaponSc("Melee")
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
    end
  end
end
Attack.Masgun = function(model,Succes)
  if model and model.Parent and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
    if model.Humanoid.Health <= HealthM then
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,35,8))
      Useskills("Gun","Z")
      Useskills("Gun","X")
    else
      weaponSc("Melee")
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
    end
  end
end
Attack.dungeon = function(model,Succes)
  if model and model.Parent and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  EquipWeapon(_G.SelectWeapon)
  local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
  local ToolTip = Equipped.ToolTip
  if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0) * CFrame.Angles(0,math.rad(180),0))end
  if RandomCFrame then wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
statsSetings = function(Num, value)
  if Num == "Melee" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Melee",value)
    end
  elseif Num == "Defense" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Defense",value)
    end
  elseif Num == "Sword" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Sword",value)
    end
  elseif Num == "Gun" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Gun",value)
    end
  elseif Num == "Devil" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Demon Fruit",value)
    end
  end
end
_B = _B or false
_G.BringRange = _G.BringRange or 350
_G.SpeedB = _G.SpeedB or 180
_G.MobM = _G.MobM or 8

local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local plr = Players.LocalPlayer
local plrUserId = tostring(plr.UserId)

local BringingMobs = {}

local function isBossMob(mob)
    if not BossList then return false end
    for _, b in ipairs(BossList) do
        if mob.Name == b then return true end
    end
    return false
end

local function IsValidMob(v)
    if not v or not v.Parent then return false end
    local hum = v:FindFirstChildOfClass("Humanoid")
    local pp = v.PrimaryPart or v:FindFirstChild("HumanoidRootPart")
    if not hum or not pp then return false end
    if hum.Health <= 0 then return false end
    if hum:GetState() == Enum.HumanoidStateType.Dead then return false end
    local transparent = true
    for _, part in pairs(v:GetDescendants()) do
        if part:IsA("BasePart") then
            if part.Transparency < 0.9 then
                transparent = false
                break
            end
        end
    end
    if transparent then return false end
    return true
end

local TAG_KEY     = "BringOwner"
-- FIX: tăng timeout lên 10s, đủ để đánh xong 1 mob
local TAG_TIMEOUT = 10

local function IsMobTaggedByOther(pp)
    local ok, tag = pcall(function() return pp:GetAttribute(TAG_KEY) end)
    if not ok or not tag then return false end
    local parts = string.split(tostring(tag), ":")
    if #parts ~= 2 then return false end
    local tagOwner = parts[1]
    local tagTime  = tonumber(parts[2]) or 0
    if (tick() - tagTime) > TAG_TIMEOUT then return false end
    if tagOwner == plrUserId then return false end
    return true
end

local function TagMob(pp)
    pcall(function()
        pp:SetAttribute(TAG_KEY, plrUserId .. ":" .. tostring(tick()))
    end)
end

local function UntagMob(pp)
    pcall(function()
        pp:SetAttribute(TAG_KEY, nil)
    end)
end

local function ResetMobPhysics(pp)
    pcall(function()
        pp.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
        pp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        pp.CanCollide = false
    end)
end

-- FIX: Keep-alive loop refresh tag cho mob đang bị farm
-- Chạy song song, untag khi mob chết hoặc _B tắt
local FarmingMobs = {} -- track mob đang bị farm (sau khi bring xong)

local function StartFarmTag(mob, pp)
    local mobKey = mob:GetFullName()
    if FarmingMobs[mobKey] then return end
    FarmingMobs[mobKey] = true

    task.spawn(function()
        while _B and IsValidMob(mob) do
            TagMob(pp)
            task.wait(1) -- refresh mỗi 1s, dưới TAG_TIMEOUT
        end
        -- Mob chết hoặc farm tắt → untag
        UntagMob(pp)
        FarmingMobs[mobKey] = nil
    end)
end

BringEnemy = function()
    if not _B then
        -- FIX: Tắt farm → untag tất cả mob đang giữ
        for mobKey in pairs(FarmingMobs) do
            FarmingMobs[mobKey] = nil
        end
        return
    end

    local bringTarget = FarmPos or PosMon
    if not bringTarget then return end

    local char   = plr.Character
    local hrpPlr = char and char:FindFirstChild("HumanoidRootPart")
    if not hrpPlr then return end

    local range  = tonumber(_G.BringRange) or 350
    local speed  = tonumber(_G.SpeedB)     or 180
    local maxMob = tonumber(_G.MobM)       or 8

    pcall(function()
        if sethiddenproperty then sethiddenproperty(plr, "SimulationRadius", math.huge) end
        if setscriptable then setscriptable(plr, "SimulationRadius", true) end
    end)

    -- Dọn cache mob đã chết/mất
    for mobKey in pairs(BringingMobs) do
        local parts = string.split(mobKey, ".")
        local found = workspace.Enemies:FindFirstChild(parts[#parts])
        if not found then BringingMobs[mobKey] = nil end
    end

    local list = {}

    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if isBossMob(v) then continue end
        if not IsValidMob(v) then continue end

        local mobKey = v:GetFullName()
        if BringingMobs[mobKey] then continue end

        local pp = v.PrimaryPart or v:FindFirstChild("HumanoidRootPart")
        if IsMobTaggedByOther(pp) then continue end

        local dist = (pp.Position - bringTarget).Magnitude
        if dist <= range then
            table.insert(list, { mob = v, pp = pp, dist = dist })
        end
    end

    table.sort(list, function(a, b) return a.dist < b.dist end)
    if #list == 0 then return end

    local count = 0
    for _, it in ipairs(list) do
        if count >= maxMob then break end

        local v, pp = it.mob, it.pp
        if not IsValidMob(v) then continue end
        if IsMobTaggedByOther(pp) then continue end

        count = count + 1

        local mobKey = v:GetFullName()
        BringingMobs[mobKey] = true
        TagMob(pp)

        pcall(function()
            ResetMobPhysics(pp)

            local offsetX  = math.random(-5, 5)
            local offsetZ  = math.random(-5, 5)
            local targetCF = CFrame.new(
                bringTarget.X + offsetX,
                bringTarget.Y,
                bringTarget.Z + offsetZ
            )

            local duration  = math.max(it.dist / speed, 0.1)
            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local move      = HD_TrackTween(TS:Create(pp, tweenInfo, { CFrame = targetCF }))
            move:Play()

            task.spawn(function()
                while move.PlaybackState == Enum.PlaybackState.Playing do
                    task.wait(0.05)
                    if not IsValidMob(v) then
                        move:Cancel()
                        break
                    end
                    TagMob(pp)
                    ResetMobPhysics(pp)
                end

                pcall(function()
                    pp.CanCollide = true
                end)

                BringingMobs[mobKey] = nil

                -- FIX: Sau khi bring xong → bắt đầu keep-alive tag
                -- Mob sẽ bị giữ tag cho đến khi chết hoặc _B tắt
                if IsValidMob(v) and _B then
                    StartFarmTag(v, pp)
                else
                    UntagMob(pp)
                end
            end)

            move.Completed:Connect(function(state)
                pcall(function()
                    ResetMobPhysics(pp)
                    if state == Enum.PlaybackState.Completed then
                        pp.CanCollide = true
                    end
                end)
                BringingMobs[mobKey] = nil
            end)
        end)
    end
end

Useskills = function(weapon, skill)
  if weapon == "Melee" then
    weaponSc("Melee")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    elseif skill == "C" then
      vim1:SendKeyEvent(true, "C", false, game);
      vim1:SendKeyEvent(false, "C", false, game);
    end
  elseif weapon == "Sword" then
    weaponSc("Sword")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    end
  elseif weapon == "Blox Fruit" then
    weaponSc("Blox Fruit")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    elseif skill == "C" then
      vim1:SendKeyEvent(true, "C", false, game);
      vim1:SendKeyEvent(false, "C", false, game);        
    elseif skill == "V" then
      vim1:SendKeyEvent(true, "V", false, game);
      vim1:SendKeyEvent(false, "V", false, game);
    end
  elseif weapon == "Gun" then
    weaponSc("Gun")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    end
  end
  if weapon == "nil" and skill == "Y" then
    vim1:SendKeyEvent(true, "Y", false, game);
    vim1:SendKeyEvent(false, "Y", false, game);
  end
end
getgenv().AimSkill = false
getgenv().AimRadius = 2500
getgenv().AimPos = nil
getgenv().AimTarget = nil 
-- Biến này sẽ chứa Player được chọn từ Dropdown
getgenv().SelectedPlayer = nil 

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")

-- Hàm lấy vị trí mục tiêu
local function GetTarget()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end

    -- ƯU TIÊN 1: Nếu có mục tiêu được chọn từ Dropdown
    if getgenv().SelectedPlayer then
        local p = getgenv().SelectedPlayer
        if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
            if p.Character.Humanoid.Health > 0 then
                return p.Character.HumanoidRootPart
            end
        end
    end

    -- ƯU TIÊN 2: Nếu không chọn ai hoặc người đó chết/thoát, tự động quét người gần nhất (Optional)
    -- Nếu bạn CHỈ muốn bắn người chọn trong Dropdown, hãy xóa phần code dưới này
    local closestPart = nil
    local shortestDistance = getgenv().AimRadius

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer 
           and player.Character 
           and player.Character:FindFirstChild("HumanoidRootPart") 
           and player.Character:FindFirstChild("Humanoid") 
           and player.Character.Humanoid.Health > 0 
           and player.Team ~= LocalPlayer.Team then
            
            local targetRoot = player.Character.HumanoidRootPart
            local distance = (myChar.HumanoidRootPart.Position - targetRoot.Position).Magnitude

            if distance < shortestDistance then
                closestPart = targetRoot
                shortestDistance = distance
            end
        end
    end
    return closestPart
end

-- Cập nhật vị trí mục tiêu liên tục
RunService.Heartbeat:Connect(function()
    if getgenv().AimSkill then
        local targetPart = GetTarget()
        if targetPart then
            getgenv().AimTarget = targetPart
            -- Bạn có thể cộng thêm Vector3.new(0, 2, 0) nếu muốn aim vào đầu
            getgenv().AimPos = targetPart.Position 
        else
            getgenv().AimTarget = nil
            getgenv().AimPos = nil
        end
    end
end)

-- [Giữ nguyên phần Metatable Hook bên dưới của bạn]
local MT = getrawmetatable(game)
local OldNameCall = MT.__namecall
local OldIndex = MT.__index
setreadonly(MT, false)

MT.__index = newcclosure(function(self, key)
    if getgenv().AimSkill and getgenv().AimPos and getgenv().AimTarget then
        if self == Mouse then
            if key == "Hit" or key == "hit" then
                return CFrame.new(getgenv().AimPos)
            elseif key == "Target" or key == "target" then
                return getgenv().AimTarget
            end
        end
    end
    return OldIndex(self, key)
end)

MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    local Args = {...}
    if getgenv().AimSkill and getgenv().AimPos then
        if Method == "FireServer" or Method == "InvokeServer" then
            for i, v in pairs(Args) do
                if typeof(v) == "Vector3" then
                    Args[i] = getgenv().AimPos
                elseif typeof(v) == "CFrame" then
                    Args[i] = CFrame.new(getgenv().AimPos)
                end
            end
            return OldNameCall(self, unpack(Args))
        end
    end
    return OldNameCall(self, ...)
end)
setreadonly(MT, true)
GetConnectionEnemies = function(a)
  for i,v in pairs(replicated:GetChildren()) do
    if v:IsA("Model") and  ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
      return v
    end
  end
  for i,v in next,game.Workspace.Enemies:GetChildren() do
    if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a)  and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
      return v
    end
  end
end
LowCpu = function()
  local decalsyeeted = true
  local g = game
  local w = g.Workspace
  local l = g.Lighting
  local t = w.Terrain
  t.WaterWaveSize = 0
  t.WaterWaveSpeed = 0
  t.WaterReflectance = 0
  t.WaterTransparency = 0
  l.GlobalShadows = false
  l.FogEnd = 9e9
  l.Brightness = 0
  settings().Rendering.QualityLevel = "Level01"
  for i, v in pairs(g:GetDescendants()) do
    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
      v.Material = "Plastic"
      v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
      v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
      v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
      v.BlastPressure = 1
      v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
      v.Enabled = false
    elseif v:IsA("MeshPart") then
      v.Material = "Plastic"
      v.Reflectance = 0
      v.TextureID = 10385902758728957
    end
  end
  for i, e in pairs(l:GetChildren()) do
    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
      e.Enabled = false
    end
  end
end
CheckF = function()
  if GetBP("Dragon-Dragon") or GetBP("Gas-Gas") or GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune") or GetBP("T-Rex-T-Rex") then return true end
end
CheckBoat = function()
  for i, v in pairs(workspace.Boats:GetChildren()) do
    if tostring(v.Owner.Value) == tostring(plr.Name) then
      return v    
end;
  end;
  return false
end;
CheckEnemiesBoat = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "FishBoat") and v:FindFirstChild("Health").Value > 0 then
      return true    
end;
  end;
  return false
end;
CheckPirateGrandBrigade = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "PirateGrandBrigade" or v.Name == "PirateBrigade") and v:FindFirstChild("Health").Value > 0 then
      return true
    end
  end
  return false
end
CheckShark = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == "Shark" and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckTerrorShark = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == "Terrorshark" and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckPiranha = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == "Piranha" and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckFishCrew = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "Fish Crew Member" or v.Name == "Haunted Crew Member") and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckHauntedCrew = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "Haunted Crew Member") and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckSeaBeast = function()
  if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
    return true  
end;
  return false
end;
CheckLeviathan = function()
  if workspace.SeaBeasts:FindFirstChild("Leviathan") then
    return true  
end;
  return false
end;
UpdStFruit = function()
  for z,x in next, plr.Backpack:GetChildren() do
  StoreFruit = x:FindFirstChild("EatRemote", true)
    if StoreFruit then
      replicated.Remotes.CommF_:InvokeServer("StoreFruit",StoreFruit.Parent:GetAttribute("OriginalName"),
      plr.Backpack:FindFirstChild(x.Name))
    end
  end
end
collectFruits = function(Succes)
  if Succes then
    local Character = plr.Character
    for _,v1 in pairs(workspace:GetChildren()) do
    if string.find(v1.Name, "Fruit") then v1.Handle.CFrame = Character.HumanoidRootPart.CFrame end
    end
  end
end
Getmoon = function()
  if World1 then
    return Lighting.FantasySky.MoonTextureId
  elseif World2 then
    return Lighting.FantasySky.MoonTextureId
  elseif World3 then
    return Lighting.Sky.MoonTextureId
  end
end
DropFruits = function()
  for _,v3 in next, plr.Backpack:GetChildren() do
    if string.find(v3.Name, "Fruit") then
      EquipWeapon(v3.Name) wait(.1)
      if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end EquipWeapon(v3.Name) plr.Character:FindFirstChild(v3.Name).EatRemote:InvokeServer("Drop")
    end
  end
  for a,b2 in pairs(plr.Character:GetChildren()) do
    if string.find(b2.Name, "Fruit") then EquipWeapon(b2.Name) wait(.1)
    if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end EquipWeapon(b2.Name) plr.Character:FindFirstChild(b2.Name).EatRemote:InvokeServer("Drop")
    end
  end
end
GetBP = function(v)
  return plr.Backpack:FindFirstChild(v) or plr.Character:FindFirstChild(v)
end
GetIn = function(Name)
  for _ ,v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(v1) == "table" then
      if v1.Name == Name or plr.Character:FindFirstChild(Name) or plr.Backpack:FindFirstChild(Name) then
        return true
	 end
    end
  end
  return false
end
GetM = function(Name)
  for _,tab in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(tab) == "table" then
	  if tab.Type == "Material" then
	    if tab.Name == Name then
		  return tab.Count
	    end
	  end
    end
  end
return 0
end
GetWP = function(nametool)
  for _,v4 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(v4) == "table" then
      if v4.Type == "Sword" then
        if v4.Name == nametool or plr.Character:FindFirstChild(nametool) or plr.Backpack:FindFirstChild(nametool) then
	     return true
	     end
	   end
      end
    end
  return false
end 
getInfinity_Ability = function(Method, Var)
  if not Root then return end
  if Method == "Soru" and Var then
    for _,gc in next, getgc() do
      if plr.Character.Soru then
        if ((typeof(gc) == "function") and (getfenv(gc).script == plr.Character.Soru)) then
          for _, v in next, getupvalues(gc) do
            if (typeof(v) == "table") then
              repeat wait(Sec) v.LastUse = 0 until not Var or (plr.Character.Humanoid.Health <= 0)
            end
          end
        end
      end
    end    
  elseif Method == "Energy" and Var then
    plr.Character.Energy.Changed:connect(function()
      if Var then plr.Character.Energy.Value = Energy end 
    end)
  elseif Method == "Observation" and Var then
    local VisionRadius = plr.VisionRadius
    VisionRadius.Value = math.huge
  end
end
Hop = function()
  pcall(function()
    for count = math.random(1, math.random(40, 75)), 100 do
      local remote = replicated.__ServerBrowser:InvokeServer(count)
	  for _, v in next, remote do
	  if tonumber(v['Count']) < 12 then TeleportService:TeleportToPlaceInstance(game.PlaceId, _) end
	  end    
    end
  end)
end
block = Instance.new("Part", workspace)
block.Size = Vector3.new(1, 1, 1)
block.Name = "Rip_Indra"
block.Anchored = true
block.CanCollide = false
block.CanTouch = false
block.Transparency = 1
blockfind = workspace:FindFirstChild(block.Name)
if blockfind and blockfind ~= block then blockfind:Destroy() end

getgenv().TweenSpeedFar  = 300
getgenv().TweenSpeedNear = 600

_tp = function(I)
    local e = plr.Character
    if not e or not e:FindFirstChild("HumanoidRootPart") then return end

    local HRP = e.HumanoidRootPart

    shouldTween = true
    getgenv().OnFarm = false

    if HRP.Anchored then
        HRP.Anchored = false
        task.wait()
    end

    local dist = (I.Position - HRP.Position).Magnitude
    if dist < 1 then
        getgenv().OnFarm = true
        return
    end

    local speed = dist <= 15
        and (getgenv().TweenSpeedNear or 600)
        or  (getgenv().TweenSpeedFar  or 300)

    local info  = TweenInfo.new(dist / speed, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(HRP, info, { CFrame = I })

    tween:Play()

    task.spawn(function()
        while tween.PlaybackState == Enum.PlaybackState.Playing do
            if not shouldTween then
                tween:Cancel()
                break
            end
            task.wait(0.1)
        end
        getgenv().OnFarm = true
    end)
end

notween = function(I)
    plr.Character.HumanoidRootPart.CFrame = I
end

TeleportToTarget = function(I)
    _tp(I)
end


task.spawn(function()
  while task.wait(0.05) do
    pcall(function()
      if _G.SailBoat_Hydra or _G.WardenBoss or _G.AutoFactory or _G.HighestMirage or _G.HCM or _G.PGB or _G.Leviathan1 or _G.UPGDrago or _G.Complete_Trials or _G.TpDrago_Prehis or _G.BuyDrago or _G.AutoFireFlowers or _G.DT_Uzoth or _G.AutoBerry or _G.Prehis_Find or _G.Prehis_Skills or _G.Prehis_DB or _G.Prehis_DE or _G.FarmBlazeEM or _G.Dojoo or _G.CollectPresent or _G.AutoLawKak or _G.TpLab or _G.AutoPhoenixF or _G.AutoFarmChest or _G.AutoHytHallow or _G.LongsWord or _G.BlackSpikey or _G.AutoHolyTorch or _G.TrainDrago  or _G.AutoSaber or _G.FarmMastery_Dev or _G.CitizenQuest or _G.AutoEctoplasm or _G.KeysRen or _G.Auto_Rainbow_Haki or _G.obsFarm or _G.AutoBigmom or _G.Doughv2 or _G.AuraBoss or _G.Raiding or _G.Auto_Cavender or _G.TpPly or _G.Bartilo_Quest or _G.Level or _G.Dungeonh or _G.FarmEliteHunt or _G.AutoZou or _G.AutoFarm_Bone or getgenv().AutoMaterial or _G.CraftVM or _G.FrozenTP or _G.TPDoor or _G.AcientOne or _G.AutoFarmNear or _G.AutoRaidCastle or _G.DarkBladev3 or _G.AutoFarmRaid or _G.Auto_Cake_Prince or _G.Addealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.FarmChestM or _G.Shark or _G.TerrorShark or _G.Piranha or _G.MobCrew or _G.SeaBeast1 or _G.FishBoat or _G.AutoPole or _G.AutoPoleV2 or _G.Auto_SuperHuman or _G.AutoDeathStep or _G.Auto_SharkMan_Karate or _G.Auto_Electric_Claw or _G.AutoDragonTalon or _G.Auto_Def_DarkCoat or _G.Auto_God_Human or _G.Auto_Tushita or _G.AutoMatSoul or _G.AutoKenVTWO or _G.AutoSerpentBow or _G.AutoFMon or _G.Auto_Soul_Guitar or _G.TPGEAR or _G.AutoSaw or _G.AutoTridentW2 or _G.Auto_StartRaid or _G.AutoEvoRace or _G.AutoGetQuestBounty or _G.MarinesCoat or _G.TravelDres or _G.Defeating or _G.DummyMan or _G.Auto_Yama or _G.Auto_SwanGG or _G.SwanCoat or _G.AutoEcBoss or _G.Auto_Mink or _G.Auto_Human or _G.Auto_Skypiea or _G.Auto_Fish or _G.CDK_TS or _G.CDK_YM or _G.CDK or _G.AutoFarmGodChalice or _G.AutoFistDarkness or _G.AutoMiror or _G.Teleport or _G.AutoKilo or _G.AutoGetUsoap or _G.Praying or _G.TryLucky or _G.AutoColShad or _G.AutoUnHaki or _G.Auto_DonAcces or _G.AutoRipIngay or _G.DragoV3 or _G.DragoV1 or _G.SailBoats or NextIs or _G.FarmGodChalice or _G.IceBossRen or senth or senth2 or _G.Lvthan or _G.beasthunter or _G.DangerLV or _G.Relic123 or _G.tweenKitsune or _G.Collect_Ember or _G.AutofindKitIs or _G.snaguine or _G.TwFruits or _G.tweenKitShrine or _G.Tp_LgS or _G.Tp_MasterA or _G.tweenShrine or _G.FarmMastery_G or _G.FarmMastery_S or getgenv().AutoFarmBoss or getgenv().AutoFarmAllBoss or _G.AutoFishSlap or getgenv().FarmTyrant or getgenv().FarmPhaBinh or getgenv().UpgradeRaceV2 or _G.AutoSpawnCP or _G.AutoBerryH or _G.AutoChestBP or _G.FarmEliteHop or _G.AutoHop_Dough or _G.AutoDoughKing or _G.AutoChipFruit or _G.AutoChipBeli or _G.StartEvent or _G.AutoTrickOrTreat or _G.FarmUnboundWerewolf then
        shouldTween = true
        if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
          local Noclip = Instance.new("BodyVelocity")
          Noclip.Name = "BodyClip"
          Noclip.Parent = plr.Character.HumanoidRootPart
          Noclip.MaxForce = Vector3.new(100000,100000,100000)
          Noclip.Velocity = Vector3.new(0,0,0)
        end        
      if not plr.Character:FindFirstChild("highlight") then
    local Test = Instance.new("Highlight")
    Test.Name = "highlight"
    Test.Enabled = true
    Test.FillColor = Color3.fromRGB(255,165,0)
    Test.OutlineColor = Color3.fromRGB(255,0,0)
    Test.FillTransparency = 0.5
    Test.OutlineTransparency = 0.2
    Test.Parent = plr.Character
end
        for _, no in pairs(plr.Character:GetDescendants()) do if no:IsA("BasePart") then no.CanCollide = false end end
      else
        shouldTween = false
        if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then plr.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy() end
        if plr.Character:FindFirstChild('highlight') then plr.Character:FindFirstChild('highlight'):Destroy() end	        
      end
    end)
  end
end)
QuestB=function()if World1 then if _G.FindBoss=="The Gorilla King"then bMon="The Gorilla King"Qname="JungleQuest"Qdata=3;PosQBoss=CFrame.new(-1601.6553955078,36.85213470459,153.38809204102)PosB=CFrame.new(-1088.75977,8.13463783,-488.559906,-0.707134247,0,0.707079291,0,1,0,-0.707079291,0,-0.707134247)elseif _G.FindBoss=="Bobby"then bMon="Bobby"Qname="BuggyQuest1"Qdata=3;PosQBoss=CFrame.new(-1140.1761474609,4.752049446106,3827.4057617188)PosB=CFrame.new(-1087.3760986328,46.949409484863,4040.1462402344)elseif _G.FindBoss=="The Saw"then bMon="The Saw"PosB=CFrame.new(-784.89715576172,72.427383422852,1603.5822753906)elseif _G.FindBoss=="Yeti"then bMon="Yeti"Qname="SnowQuest"Qdata=3;PosQBoss=CFrame.new(1386.8073730469,87.272789001465,-1298.3576660156)PosB=CFrame.new(1218.7956542969,138.01184082031,-1488.0262451172)elseif _G.FindBoss=="Mob Leader"then bMon="Mob Leader"PosB=CFrame.new(-2844.7307128906,7.4180502891541,5356.6723632813)elseif _G.FindBoss=="Vice Admiral"then bMon="Vice Admiral"Qname="MarineQuest2"Qdata=2;PosQBoss=CFrame.new(-5036.2465820313,28.677835464478,4324.56640625)PosB=CFrame.new(-5006.5454101563,88.032081604004,4353.162109375)elseif _G.FindBoss=="Saber Expert"then bMon="Saber Expert"PosB=CFrame.new(-1458.89502,29.8870335,-50.633564)elseif _G.FindBoss=="Warden"then bMon="Warden"Qname="ImpelQuest"Qdata=1;PosB=CFrame.new(5278.04932,2.15167475,944.101929,0.220546961,-4.49946401e-06,0.975376427,-1.95412576e-05,1,9.03162072e-06,-0.975376427,-2.10519756e-05,0.220546961)PosQBoss=CFrame.new(5191.86133,2.84020686,686.438721,-0.731384635,0,0.681965172,0,1,0,-0.681965172,0,-0.731384635)elseif _G.FindBoss=="Chief Warden"then bMon="Chief Warden"Qname="ImpelQuest"Qdata=2;PosB=CFrame.new(5206.92578,0.997753382,814.976746,0.342041343,-0.00062915677,0.939684749,0.00191645394,0.999998152,-2.80422337e-05,-0.939682961,0.00181045406,0.342041939)PosQBoss=CFrame.new(5191.86133,2.84020686,686.438721,-0.731384635,0,0.681965172,0,1,0,-0.681965172,0,-0.731384635)elseif _G.FindBoss=="Swan"then bMon="Swan"Qname="ImpelQuest"Qdata=3;PosB=CFrame.new(5325.09619,7.03906584,719.570679,-0.309060812,0,0.951042235,0,1,0,-0.951042235,0,-0.309060812)PosQBoss=CFrame.new(5191.86133,2.84020686,686.438721,-0.731384635,0,0.681965172,0,1,0,-0.681965172,0,-0.731384635)elseif _G.FindBoss=="Magma Admiral"then bMon="Magma Admiral"Qname="MagmaQuest"Qdata=3;PosQBoss=CFrame.new(-5314.6220703125,12.262420654297,8517.279296875)PosB=CFrame.new(-5765.8969726563,82.92064666748,8718.3046875)elseif _G.FindBoss=="Fishman Lord"then bMon="Fishman Lord"Qname="FishmanQuest"Qdata=3;PosQBoss=CFrame.new(61122.65234375,18.497442245483,1569.3997802734)PosB=CFrame.new(61260.15234375,30.950881958008,1193.4329833984)elseif _G.FindBoss=="Wysper"then bMon="Wysper"Qname="SkyExp1Quest"Qdata=3;PosQBoss=CFrame.new(-7861.947265625,5545.517578125,-379.85974121094)PosB=CFrame.new(-7866.1333007813,5576.4311523438,-546.74816894531)elseif _G.FindBoss=="Thunder God"then bMon="Thunder God"Qname="SkyExp2Quest"Qdata=3;PosQBoss=CFrame.new(-7903.3828125,5635.9897460938,-1410.923828125)PosB=CFrame.new(-7994.984375,5761.025390625,-2088.6479492188)elseif _G.FindBoss=="Cyborg"then bMon="Cyborg"Qname="FountainQuest"Qdata=3;PosQBoss=CFrame.new(5258.2788085938,38.526931762695,4050.044921875)PosB=CFrame.new(6094.0249023438,73.770050048828,3825.7348632813)elseif _G.FindBoss=="Ice Admiral"then bMon="Ice Admiral"Qdata=nil;PosQBoss=CFrame.new(1266.08948,26.1757946,-1399.57678,-0.573599219,0,-0.81913656,0,1,0,0.81913656,0,-0.573599219)PosB=CFrame.new(1266.08948,26.1757946,-1399.57678,-0.573599219,0,-0.81913656,0,1,0,0.81913656,0,-0.573599219)elseif _G.FindBoss=="Greybeard"then bMon="Greybeard"Qdata=nil;PosQBoss=CFrame.new(-5081.3452148438,85.221641540527,4257.3588867188)PosB=CFrame.new(-5081.3452148438,85.221641540527,4257.3588867188)end end;if World2 then if _G.FindBoss=="Diamond"then bMon="Diamond"Qname="Area1Quest"Qdata=3;PosQBoss=CFrame.new(-427.5666809082,73.313781738281,1835.4208984375)PosB=CFrame.new(-1576.7166748047,198.59265136719,13.724286079407)elseif _G.FindBoss=="Jeremy"then bMon="Jeremy"Qname="Area2Quest"Qdata=3;PosQBoss=CFrame.new(636.79943847656,73.413787841797,918.00415039063)PosB=CFrame.new(2006.9261474609,448.95666503906,853.98284912109)elseif _G.FindBoss=="Fajita"then bMon="Fajita"Qname="MarineQuest3"Qdata=3;PosQBoss=CFrame.new(-2441.986328125,73.359344482422,-3217.5324707031)PosB=CFrame.new(-2172.7399902344,103.32216644287,-4015.025390625)elseif _G.FindBoss=="Don Swan"then bMon="Don Swan"PosB=CFrame.new(2286.2004394531,15.177839279175,863.8388671875)elseif _G.FindBoss=="Smoke Admiral"then bMon="Smoke Admiral"Qname="IceSideQuest"Qdata=3;PosQBoss=CFrame.new(-5429.0473632813,15.977565765381,-5297.9614257813)PosB=CFrame.new(-5275.1987304688,20.757257461548,-5260.6669921875)elseif _G.FindBoss=="Awakened Ice Admiral"then bMon="Awakened Ice Admiral"Qname="FrostQuest"Qdata=3;PosQBoss=CFrame.new(5668.9780273438,28.519989013672,-6483.3520507813)PosB=CFrame.new(6403.5439453125,340.29766845703,-6894.5595703125)elseif _G.FindBoss=="Tide Keeper"then bMon="Tide Keeper"Qname="ForgottenQuest"Qdata=3;PosQBoss=CFrame.new(-3053.9814453125,237.18954467773,-10145.0390625)PosB=CFrame.new(-3795.6423339844,105.88877105713,-11421.307617188)elseif _G.FindBoss=="Darkbeard"then bMon="Darkbeard"Qdata=nil;PosQBoss=CFrame.new(3677.08203125,62.751937866211,-3144.8332519531)PosB=CFrame.new(3677.08203125,62.751937866211,-3144.8332519531)elseif _G.FindBoss=="Cursed Captaim"then bMon="Cursed Captain"Qdata=nil;PosQBoss=CFrame.new(916.928589,181.092773,33422)PosB=CFrame.new(916.928589,181.092773,33422)elseif _G.FindBoss=="Order"then bMon="Order"Qdata=nil;PosQBoss=CFrame.new(-6217.2021484375,28.047645568848,-5053.1357421875)PosB=CFrame.new(-6217.2021484375,28.047645568848,-5053.1357421875)end end;if World3 then if _G.FindBoss=="Stone"then bMon="Stone"Qname="PiratePortQuest"Qdata=3;PosQBoss=CFrame.new(-289.76705932617,43.819011688232,5579.9384765625)PosB=CFrame.new(-1027.6512451172,92.404174804688,6578.8530273438)elseif _G.FindBoss=="Hydra Leader"then bMon="Hydra Leader"Qname="AmazonQuest2"Qdata=3;PosQBoss=CFrame.new(5821.89794921875,1019.0950927734375,-73.71923065185547)PosB=CFrame.new(5821.89794921875,1019.0950927734375,-73.71923065185547)elseif _G.FindBoss=="Kilo Admiral"then bMon="Kilo Admiral"Qname="MarineTreeIsland"Qdata=3;PosQBoss=CFrame.new(2179.3010253906,28.731239318848,-6739.9741210938)PosB=CFrame.new(2764.2233886719,432.46154785156,-7144.4580078125)elseif _G.FindBoss=="Captain Elephant"then bMon="Captain Elephant"Qname="DeepForestIsland"Qdata=3;PosQBoss=CFrame.new(-13232.682617188,332.40396118164,-7626.01171875)PosB=CFrame.new(-13376.7578125,433.28689575195,-8071.392578125)elseif _G.FindBoss=="Beautiful Pirate"then bMon="Beautiful Pirate"Qname="DeepForestIsland2"Qdata=3;PosQBoss=CFrame.new(-12682.096679688,390.88653564453,-9902.1240234375)PosB=CFrame.new(5283.609375,22.56223487854,-110.78285217285)elseif _G.FindBoss=="Cake Queen"then bMon="Cake Queen"Qname="IceCreamIslandQuest"Qdata=3;PosQBoss=CFrame.new(-819.376709,64.9259796,-10967.2832,-0.766061664,0,0.642767608,0,1,0,-0.642767608,0,-0.766061664)PosB=CFrame.new(-678.648804,381.353943,-11114.2012,-0.908641815,0.00149294338,0.41757378,0.00837114919,0.999857843,0.0146408929,-0.417492568,0.0167988986,-0.90852499)elseif _G.FindBoss=="Longma"then bMon="Longma"Qdata=nil;PosQBoss=CFrame.new(-10238.875976563,389.7912902832,-9549.7939453125)PosB=CFrame.new(-10238.875976563,389.7912902832,-9549.7939453125)elseif _G.FindBoss=="Soul Reaper"then bMon="Soul Reaper"Qdata=nil;PosQBoss=CFrame.new(-9524.7890625,315.80429077148,6655.7192382813)PosB=CFrame.new(-9524.7890625,315.80429077148,6655.7192382813)end end end
QuestBeta = function()
  local Neta = QuestB()
  return {
    [0] = _G.FindBoss,
    [1] = bMon,
    [2] = Qdata,
    [3] = Qname,
    [4] = PosB
    }  
end
QuestCheck=function()local a=game.Players.LocalPlayer.Data.Level.Value;
if World1 then
			if a == 1 or a <= 9 then
				if tostring(TeamSelf) == "Marines" then
					Mon = "Trainee"
					Qname = "MarineQuest"
					Qdata = 1;
					NameMon = "Trainee"
					PosM = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929)
					PosQ = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929)
				elseif tostring(TeamSelf) == "Pirates" then
					Mon = "Bandit"
					Qdata = 1;
					Qname = "BanditQuest1"
					NameMon = "Bandit"
					PosM = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
					PosQ = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
				end
			elseif a == 10 or a <= 14 then
				Mon = "Monkey"
				Qdata = 1;
				Qname = "JungleQuest"
				NameMon = "Monkey"
				PosQ = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
				PosM = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
			elseif a == 15 or a <= 29 then
				Mon = "Gorilla"
				Qdata = 2;
				Qname = "JungleQuest"
				NameMon = "Gorilla"
				PosQ = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
				PosM = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
			elseif a == 30 or a <= 39 then
				Mon = "Pirate"
				Qdata = 1;
				Qname = "BuggyQuest1"
				NameMon = "Pirate"
				PosQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
				PosM = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
			elseif a == 40 or a <= 59 then
				Mon = "Brute"
				Qdata = 2;
				Qname = "BuggyQuest1"
				NameMon = "Brute"
				PosQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
				PosM = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
			elseif a == 60 or a <= 74 then
				Mon = "Desert Bandit"
				Qdata = 1;
				Qname = "DesertQuest"
				NameMon = "Desert Bandit"
				PosQ = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
				PosM = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
			elseif a == 75 or a <= 89 then
				Mon = "Desert Officer"
				Qdata = 2;
				Qname = "DesertQuest"
				NameMon = "Desert Officer"
				PosQ = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
				PosM = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
			elseif a == 90 or a <= 99 then
				Mon = "Snow Bandit"
				Qdata = 1;
				Qname = "SnowQuest"
				NameMon = "Snow Bandit"
				PosQ = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
				PosM = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
			elseif a == 100 or a <= 119 then
				Mon = "Snowman"
				Qdata = 2;
				Qname = "SnowQuest"
				NameMon = "Snowman"
				PosQ = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
				PosM = CFrame.new(6241.9951171875, 51.522083282471, -1243.9771728516)
			elseif a == 120 or a <= 149 then
				Mon = "Chief Petty Officer"
				Qdata = 1;
				Qname = "MarineQuest2"
				NameMon = "Chief Petty Officer"
				PosQ = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
			elseif a == 150 or a <= 174 then
				Mon = "Sky Bandit"
				Qdata = 1;
				Qname = "SkyQuest"
				NameMon = "Sky Bandit"
				PosQ = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
				PosM = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
			elseif a == 175 or a <= 189 then
				Mon = "Dark Master"
				Qdata = 2;
				Qname = "SkyQuest"
				NameMon = "Dark Master"
				PosQ = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
				PosM = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
			elseif a == 190 or a <= 209 then
				Mon = "Prisoner"
				Qdata = 1;
				Qname = "PrisonerQuest"
				NameMon = "Prisoner"
				PosQ = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
				PosM = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
			elseif a == 210 or a <= 249 then
				Mon = "Dangerous Prisoner"
				Qdata = 2;
				Qname = "PrisonerQuest"
				NameMon = "Dangerous Prisoner"
				PosQ = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
				PosM = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
			elseif a == 250 or a <= 274 then
				Mon = "Toga Warrior"
				Qdata = 1;
				Qname = "ColosseumQuest"
				NameMon = "Toga Warrior"
				PosQ = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
				PosM = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
			elseif a == 275 or a <= 299 then
				Mon = "Gladiator"
				Qdata = 2;
				Qname = "ColosseumQuest"
				NameMon = "Gladiator"
				PosQ = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
				PosM = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
			elseif a == 300 or a <= 324 then
				Boubty = false;
				Mon = "Military Soldier"
				Qdata = 1;
				Qname = "MagmaQuest"
				NameMon = "Military Soldier"
				PosQ = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
				PosM = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
			elseif a == 325 or a <= 374 then
				Mon = "Military Spy"
				Qdata = 2;
				Qname = "MagmaQuest"
				NameMon = "Military Spy"
				PosQ = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
				PosM = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
			elseif a == 375 or a <= 399 then
				Mon = "Fishman Warrior"
				Qdata = 1;
				Qname = "FishmanQuest"
				NameMon = "Fishman Warrior"
				PosQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
				PosM = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
				end
			elseif a == 400 or a <= 449 then
				Mon = "Fishman Commando"
				Qdata = 2;
				Qname = "FishmanQuest"
				NameMon = "Fishman Commando"
				PosQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
				PosM = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
				end
			elseif a == 450 or a <= 474 then
				Mon = "God's Guard"
				Qdata = 1;
				Qname = "SkyExp1Quest"
				NameMon = "God's Guard"
				PosQ = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
				PosM = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688))
				end
			elseif a == 475 or a <= 524 then
				Mon = "Shanda"
				Qdata = 2;
				Qname = "SkyExp1Quest"
				NameMon = "Shanda"
				PosQ = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
				PosM = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
				end
			elseif a == 525 or a <= 549 then
				Mon = "Royal Squad"
				Qdata = 1;
				Qname = "SkyExp2Quest"
				NameMon = "Royal Squad"
				PosQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
			elseif a == 550 or a <= 624 then
				Mon = "Royal Soldier"
				Qdata = 2;
				Qname = "SkyExp2Quest"
				NameMon = "Royal Soldier"
				PosQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
			elseif a == 625 or a <= 649 then
				Mon = "Galley Pirate"
				Qdata = 1;
				Qname = "FountainQuest"
				NameMon = "Galley Pirate"
				PosQ = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
				PosM = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
			elseif a >= 650 then
				Mon = "Galley Captain"
				Qdata = 2;
				Qname = "FountainQuest"
				NameMon = "Galley Captain"
				PosQ = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
				PosM = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
			end
		elseif World2 then
			if a == 700 or a <= 724 then
				Mon = "Raider"
				Qdata = 1;
				Qname = "Area1Quest"
				NameMon = "Raider"
				PosQ = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
				PosM = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
			elseif a == 725 or a <= 774 then
				Mon = "Mercenary"
				Qdata = 2;
				Qname = "Area1Quest"
				NameMon = "Mercenary"
				PosQ = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
				PosM = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
			elseif a == 775 or a <= 799 then
				Mon = "Swan Pirate"
				Qdata = 1;
				Qname = "Area2Quest"
				NameMon = "Swan Pirate"
				PosQ = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
				PosM = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
			elseif a == 800 or a <= 874 then
				Mon = "Factory Staff"
				Qname = "Area2Quest"
				Qdata = 2;
				NameMon = "Factory Staff"
				PosQ = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
				PosM = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
			elseif a == 875 or a <= 899 then
				Mon = "Marine Lieutenant"
				Qdata = 1;
				Qname = "MarineQuest3"
				NameMon = "Marine Lieutenant"
				PosQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
				PosM = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
			elseif a == 900 or a <= 949 then
				Mon = "Marine Captain"
				Qdata = 2;
				Qname = "MarineQuest3"
				NameMon = "Marine Captain"
				PosQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
				PosM = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
			elseif a == 950 or a <= 974 then
				Mon = "Zombie"
				Qdata = 1;
				Qname = "ZombieQuest"
				NameMon = "Zombie"
				PosQ = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
				PosM = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
			elseif a == 975 or a <= 999 then
				Mon = "Vampire"
				Qdata = 2;
				Qname = "ZombieQuest"
				NameMon = "Vampire"
				PosQ = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
				PosM = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
			elseif a == 1000 or a <= 1049 then
				Mon = "Snow Trooper"
				Qdata = 1;
				Qname = "SnowMountainQuest"
				NameMon = "Snow Trooper"
				PosQ = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
				PosM = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
			elseif a == 1050 or a <= 1099 then
				Mon = "Winter Warrior"
				Qdata = 2;
				Qname = "SnowMountainQuest"
				NameMon = "Winter Warrior"
				PosQ = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
				PosM = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
			elseif a == 1100 or a <= 1124 then
				Mon = "Lab Subordinate"
				Qdata = 1;
				Qname = "IceSideQuest"
				NameMon = "Lab Subordinate"
				PosQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
				PosM = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
			elseif a == 1125 or a <= 1174 then
				Mon = "Horned Warrior"
				Qdata = 2;
				Qname = "IceSideQuest"
				NameMon = "Horned Warrior"
				PosQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
				PosM = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
			elseif a == 1175 or a <= 1199 then
				Mon = "Magma Ninja"
				Qdata = 1;
				Qname = "FireSideQuest"
				NameMon = "Magma Ninja"
				PosQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
				PosM = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
			elseif a == 1200 or a <= 1249 then
				Mon = "Lava Pirate"
				Qdata = 2;
				Qname = "FireSideQuest"
				NameMon = "Lava Pirate"
				PosQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
				PosM = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
			elseif a == 1250 or a <= 1274 then
				Mon = "Ship Deckhand"
				Qdata = 1;
				Qname = "ShipQuest1"
				NameMon = "Ship Deckhand"
				PosQ = CFrame.new(1037.80127, 125.092171, 32911.6016)
				PosM = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif a == 1275 or a <= 1299 then
				Mon = "Ship Engineer"
				Qdata = 2;
				Qname = "ShipQuest1"
				NameMon = "Ship Engineer"
				PosQ = CFrame.new(1037.80127, 125.092171, 32911.6016)
				PosM = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif a == 1300 or a <= 1324 then
				Mon = "Ship Steward"
				Qdata = 1;
				Qname = "ShipQuest2"
				NameMon = "Ship Steward"
				PosQ = CFrame.new(968.80957, 125.092171, 33244.125)
				PosM = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif a == 1325 or a <= 1349 then
				Mon = "Ship Officer"
				Qdata = 2;
				Qname = "ShipQuest2"
				NameMon = "Ship Officer"
				PosQ = CFrame.new(968.80957, 125.092171, 33244.125)
				PosM = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif a == 1350 or a <= 1374 then
				Mon = "Arctic Warrior"
				Qdata = 1;
				Qname = "FrostQuest"
				NameMon = "Arctic Warrior"
				PosQ = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
				PosM = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
					BTP(PosM)
				end
			elseif a == 1375 or a <= 1424 then
				Mon = "Snow Lurker"
				Qdata = 2;
				Qname = "FrostQuest"
				NameMon = "Snow Lurker"
				PosQ = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
				PosM = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
			elseif a == 1425 or a <= 1449 then
				Mon = "Sea Soldier"
				Qdata = 1;
				Qname = "ForgottenQuest"
				NameMon = "Sea Soldier"
				PosQ = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
				PosM = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
			elseif a >= 1450 then
				Mon = "Water Fighter"
				Qdata = 2;
				Qname = "ForgottenQuest"
				NameMon = "Water Fighter"
				PosQ = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
				PosM = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
			end
		elseif World3 then
			if a >= 1500 and a <= 1524 then
				Mon = "Pirate Millionaire"
				Qdata = 1;
				Qname = "PiratePortQuest"
				NameMon = "Pirate Millionaire"
				PosQ = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625)
				PosM = CFrame.new(-327.5, 98.0, 5788.5) -- Vị trí spawn Pirate Millionaire
			elseif a >= 1525 and a <= 1574 then
				Mon = "Pistol Billionaire"
				Qdata = 2;
				Qname = "PiratePortQuest"
				NameMon = "Pistol Billionaire"
				PosQ = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625)
				PosM = CFrame.new(-84.8556900024414, 85.62061309814453, 6132.0087890625) -- Vị trí spawn Pistol Billionaire
			elseif a >= 1575 and a <= 1599 then
				Mon = "Dragon Crew Warrior"
				Qdata = 1;
				Qname = "DragonCrewQuest"
				NameMon = "Dragon Crew Warrior"
				PosQ = CFrame.new(6735.12695, 127.15757, -711.057617, -0.908269227, 0.0241198279, -0.417690575, 0.00184117199, 0.998557687, 0.0536587685, 0.418382287, 0.0479675643, -0.907003582)
				PosM = CFrame.new(6820, 50, -630)
			elseif a >= 1600 and a <= 1624 then
				Mon = "Dragon Crew Archer"
				Qname = "DragonCrewQuest"
				Qdata = 2;
				NameMon = "Dragon Crew Archer"
				PosQ = CFrame.new(6955.8974609375, 546.6658935546875, 309.0401306152344)
				PosM = CFrame.new(6625, 378, 244) -- Vị trí spawn Dragon Crew Archer
			elseif a >= 1625 and a <= 1649 then
				Mon = "Hydra Enforcer"
				Qname = "VenomCrewQuest"
				Qdata = 1;
				NameMon = "Hydra Enforcer"
				PosQ = CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219)
				PosM = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375) -- Vị trí spawn Hydra Enforcer
			elseif a >= 1650 and a <= 1699 then
				Mon = "Venomous Assailant"
				Qname = "VenomCrewQuest"
				Qdata = 2;
				NameMon = "Venomous Assailant"
				PosQ = CFrame.new(4697.5918, 1100.65137, 946.401978, 0.579397917, -4.19689783e-10, 0.81504482, -1.49287818e-10, 1, 6.21053986e-10, -0.81504482, -4.81513662e-10, 0.579397917)
				PosM = CFrame.new(4902, 670, 39) -- Vị trí spawn Venomous Assailant
			elseif a >= 1700 and a <= 1724 then
				Mon = "Marine Commodore"
				Qdata = 1;
				Qname = "MarineTreeIsland"
				NameMon = "Marine Commodore"
				PosQ = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
				PosM = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
			elseif a >= 1725 and a <= 1774 then
				Mon = "Marine Rear Admiral"
				NameMon = "Marine Rear Admiral"
				Qname = "MarineTreeIsland"
				Qdata = 2;
				PosQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
				PosM = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
			elseif a >= 1775 and a <= 1799 then
				Mon = "Fishman Raider"
				Qdata = 1;
				Qname = "DeepForestIsland3"
				NameMon = "Fishman Raider"
				PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
				PosM = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
			elseif a >= 1800 and a <= 1824 then
				Mon = "Fishman Captain"
				Qdata = 2;
				Qname = "DeepForestIsland3"
				NameMon = "Fishman Captain"
				PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
				PosM = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
			elseif a >= 1825 and a <= 1849 then
				Mon = "Forest Pirate"
				Qdata = 1;
				Qname = "DeepForestIsland"
				NameMon = "Forest Pirate"
				PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
				PosM = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
			elseif a >= 1850 and a <= 1899 then
				Mon = "Mythological Pirate"
				Qdata = 2;
				Qname = "DeepForestIsland"
				NameMon = "Mythological Pirate"
				PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
				PosM = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
			elseif a >= 1900 and a <= 1924 then
				Mon = "Jungle Pirate"
				Qdata = 1;
				Qname = "DeepForestIsland2"
				NameMon = "Jungle Pirate"
				PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
				PosM = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
			elseif a >= 1925 and a <= 1974 then
				Mon = "Musketeer Pirate"
				Qdata = 2;
				Qname = "DeepForestIsland2"
				NameMon = "Musketeer Pirate"
				PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
				PosM = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
			elseif a >= 1975 and a <= 1999 then
				Mon = "Reborn Skeleton"
				Qdata = 1;
				Qname = "HauntedQuest1"
				NameMon = "Reborn Skeleton"
				PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
				PosM = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
			elseif a >= 2000 and a <= 2024 then
				Mon = "Living Zombie"
				Qdata = 2;
				Qname = "HauntedQuest1"
				NameMon = "Living Zombie"
				PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
				PosM = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
			elseif a >= 2025 and a <= 2049 then
				Mon = "Demonic Soul"
				Qdata = 1;
				Qname = "HauntedQuest2"
				NameMon = "Demonic Soul"
				PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
			elseif a >= 2050 and a <= 2074 then
				Mon = "Posessed Mummy"
				Qdata = 2;
				Qname = "HauntedQuest2"
				NameMon = "Posessed Mummy"
				PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
			elseif a >= 2075 and a <= 2099 then
				Mon = "Peanut Scout"
				Qdata = 1;
				Qname = "NutsIslandQuest"
				NameMon = "Peanut Scout"
				PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
			elseif a >= 2100 and a <= 2124 then
				Mon = "Peanut President"
				Qdata = 2;
				Qname = "NutsIslandQuest"
				NameMon = "Peanut President"
				PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
			elseif a >= 2125 and a <= 2149 then
				Mon = "Ice Cream Chef"
				Qdata = 1;
				Qname = "IceCreamIslandQuest"
				NameMon = "Ice Cream Chef"
				PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
			elseif a >= 2150 and a <= 2199 then
				Mon = "Ice Cream Commander"
				Qdata = 2;
				Qname = "IceCreamIslandQuest"
				NameMon = "Ice Cream Commander"
				PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
			elseif a >= 2200 and a <= 2224 then
				Mon = "Cookie Crafter"
				Qdata = 1;
				Qname = "CakeQuest1"
				NameMon = "Cookie Crafter"
				PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
				PosM = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
			elseif a >= 2225 and a <= 2249 then
				Mon = "Cake Guard"
				Qdata = 2;
				Qname = "CakeQuest1"
				NameMon = "Cake Guard"
				PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
				PosM = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
			elseif a >= 2250 and a <= 2274 then
				Mon = "Baking Staff"
				Qdata = 1;
				Qname = "CakeQuest2"
				NameMon = "Baking Staff"
				PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
				PosM = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
			elseif a >= 2275 and a <= 2299 then
				Mon = "Head Baker"
				Qdata = 2;
				Qname = "CakeQuest2"
				NameMon = "Head Baker"
				PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
				PosM = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
			elseif a >= 2300 and a <= 2324 then
				Mon = "Cocoa Warrior"
				Qdata = 1;
				Qname = "ChocQuest1"
				NameMon = "Cocoa Warrior"
				PosQ = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
				PosM = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
			elseif a >= 2325 and a <= 2349 then
				Mon = "Chocolate Bar Battler"
				Qdata = 2;
				Qname = "ChocQuest1"
				NameMon = "Chocolate Bar Battler"
				PosQ = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
				PosM = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
			elseif a >= 2350 and a <= 2374 then
				Mon = "Sweet Thief"
				Qdata = 1;
				Qname = "ChocQuest2"
				NameMon = "Sweet Thief"
				PosQ = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
				PosM = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
			elseif a >= 2375 and a <= 2399 then
				Mon = "Candy Rebel"
				Qdata = 2;
				Qname = "ChocQuest2"
				NameMon = "Candy Rebel"
				PosQ = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
				PosM = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
			elseif a >= 2400 and a <= 2449 then
				Mon = "Candy Pirate"
				Qdata = 1;
				Qname = "CandyQuest1"
				NameMon = "Candy Pirate"
				PosQ = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
				PosM = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
			elseif a >= 2450 and a <= 2474 then
				Mon = "Isle Outlaw"
				Qdata = 1;
				Qname = "TikiQuest1"
				NameMon = "Isle Outlaw"
				PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566)
				PosM = CFrame.new(-16479.900390625, 226.6117401123047, -300.3114318847656)
			elseif a >= 2475 and a <= 2499 then
				Mon = "Island Boy"
				Qdata = 2;
				Qname = "TikiQuest1"
				NameMon = "Island Boy"
				PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566)
				PosM = CFrame.new(-16849.396484375, 192.86505126953125, -150.7853240966797)
			elseif a >= 2500 and a <= 2524 then
				Mon = "Sun-kissed Warrior"
				Qdata = 1;
				Qname = "TikiQuest2"
				NameMon = "Sun-kissed Warrior"
				PosQ = CFrame.new(-16538, 55, 1049)
				PosM = CFrame.new(-16347, 64, 984)
			elseif a >= 2525 and a <= 2550 then
				Mon = "Isle Champion"
				Qdata = 2;
				Qname = "TikiQuest2"
				NameMon = "Isle Champion"
				PosQ = CFrame.new(-16541.0215, 57.3082275, 1051.46118, 0.0410757065, -0, -0.999156058, 0, 1, -0, 0.999156058, 0, 0.0410757065)
				PosM = CFrame.new(-16602.1015625, 130.38734436035156, 1087.24560546875) -- Tiki Outpost
	-- TIKI OUTPOST
			elseif a >= 2551 and a <= 2574 then
				Mon = "Serpent Hunter"
				Qdata = 1;
				Qname = "TikiQuest3";
				NameMon = "Serpent Hunter"
				PosQ = CFrame.new(-16679.4785, 176.7473, 1474.3995)
				PosM = CFrame.new(-16679.4785, 176.7473, 1474.3995)
			elseif a >= 2575 and a <= 2599 then -- CHỈ TỚI 2599, để 2600 chuyển qua Submarine
				Mon = "Skull Slayer"
				Qdata = 2;
				Qname = "TikiQuest3";
				NameMon = "Skull Slayer"
				PosQ = CFrame.new(-16759.5898, 71.2837, 1595.3399)
				PosM = CFrame.new(-16759.5898, 71.2837, 1595.3399)

	-- SUBMARINE AREA (đúng mốc 2600 / 2625 / 2650 / 2675)
			elseif a >= 2600 and a <= 2624 then
				Mon = "Reef Bandit"
				Qdata = 1;
				Qname = "SubmergedQuest1";
				NameMon = "Reef Bandit"
				PosQ = CFrame.new(10882.264, -2086.322, 10034.226) -- NPC Submerged
				PosM = CFrame.new(10736.6191, -2087.8439, 9338.4882)
			elseif a >= 2625 and a <= 2649 then
				Mon = "Coral Pirate"
				Qdata = 2;
				Qname = "SubmergedQuest1";
				NameMon = "Coral Pirate"
				PosQ = CFrame.new(10882.264, -2086.322, 10034.226)
				PosM = CFrame.new(10965.1025, -2158.8842, 9177.2597)
			elseif a >= 2650 and a <= 2674 then
				Mon = "Sea Chanter"
				Qdata = 1;
				Qname = "SubmergedQuest2";
				NameMon = "Sea Chanter"
				PosQ = CFrame.new(10882.264, -2086.322, 10034.226)
				PosM = CFrame.new(10621.0342, -2087.8440, 10102.0332)
			elseif a >= 2675 and a <= 2699 then
				Mon = "Ocean Prophet"
				Qdata = 2;
				Qname = "SubmergedQuest2";
				NameMon = "Ocean Prophet"
				PosQ = CFrame.new(10882.264, -2086.322, 10034.226)
				PosM = CFrame.new(11056.1445, -2001.6717, 10117.4493)
			elseif a >= 2700 and a <= 2724 then
				Mon = "High Disciple"
				Qdata = 1;
				Qname = "SubmergedQuest3";
				NameMon = "High Disciple"
				PosQ = CFrame.new(9636.52441, -1992.19507, 9609.52832)
				PosM = CFrame.new(9828.087890625, -1940.908935546875, 9693.0634765625)
			elseif a >= 2725 and a <= 2800 then
				Mon = "Grand Devotee"
				Qdata = 2;
				Qname = "SubmergedQuest3";
				NameMon = "Grand Devotee"
				PosQ = CFrame.new(9636.52441, -1992.19507, 9609.52832)
				PosM = CFrame.new(9557.5849609375, -1928.0404052734375, 9859.1826171875)
			end
		end
	end
MaterialMon=function()local a=game.Players.LocalPlayer;local b=a.Character and a.Character:FindFirstChild("HumanoidRootPart")if not b then return end;shouldRequestEntrance=function(c,d)local e=(b.Position-c).Magnitude;if e>=d then replicated.Remotes.CommF_:InvokeServer("requestEntrance",c)end end;if World1 then if SelectMaterial=="Angel Wings"then MMon={"Shanda","Royal Squad","Royal Soldier","Wysper","Thunder God"}MPos=CFrame.new(-4698,845,-1912)SP="Default"local c=Vector3.new(-4607.82275,872.54248,-1667.55688)shouldRequestEntrance(c,10000)elseif SelectMaterial=="Leather + Scrap Metal"then MMon={"Brute","Pirate"}MPos=CFrame.new(-1145,15,4350)SP="Default"elseif SelectMaterial=="Magma Ore"then MMon={"Military Soldier","Military Spy","Magma Admiral"}MPos=CFrame.new(-5815,84,8820)SP="Default"elseif SelectMaterial=="Fish Tail"then MMon={"Fishman Warrior","Fishman Commando","Fishman Lord"}MPos=CFrame.new(61123,19,1569)SP="Default"local c=Vector3.new(61163.8515625,5.342342376708984,1819.7841796875)shouldRequestEntrance(c,17000)end elseif World2 then if SelectMaterial=="Leather + Scrap Metal"then MMon={"Marine Captain"}MPos=CFrame.new(-2010.5059814453125,73.00115966796875,-3326.620849609375)SP="Default"elseif SelectMaterial=="Magma Ore"then MMon={"Magma Ninja","Lava Pirate"}MPos=CFrame.new(-5428,78,-5959)SP="Default"elseif SelectMaterial=="Ectoplasm"then MMon={"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer"}MPos=CFrame.new(911.35827636719,125.95812988281,33159.5390625)SP="Default"local c=Vector3.new(61163.8515625,5.342342376708984,1819.7841796875)shouldRequestEntrance(c,18000)elseif SelectMaterial=="Mystic Droplet"then MMon={"Water Fighter"}MPos=CFrame.new(-3385,239,-10542)SP="Default"elseif SelectMaterial=="Radioactive Material"then MMon={"Factory Staff"}MPos=CFrame.new(295,73,-56)SP="Default"elseif SelectMaterial=="Vampire Fang"then MMon={"Vampire"}MPos=CFrame.new(-6033,7,-1317)SP="Default"end elseif World3 then if SelectMaterial=="Scrap Metal"then MMon={"Jungle Pirate","Forest Pirate"}MPos=CFrame.new(-11975.78515625,331.7734069824219,-10620.0302734375)SP="Default"elseif SelectMaterial=="Fish Tail"then MMon={"Fishman Raider","Fishman Captain"}MPos=CFrame.new(-10993,332,-8940)SP="Default"elseif SelectMaterial=="Conjured Cocoa"then MMon={"Chocolate Bar Battler","Cocoa Warrior"}MPos=CFrame.new(620.6344604492188,78.93644714355469,-12581.369140625)SP="Default"elseif SelectMaterial=="Dragon Scale"then MMon={"Dragon Crew Archer","Dragon Crew Warrior"}MPos=CFrame.new(6594,383,139)SP="Default"elseif SelectMaterial=="Gunpowder"then MMon={"Pistol Billionaire"}MPos=CFrame.new(-84.8556900024414, 85.62061309814453, 6132.0087890625)SP="Default"elseif SelectMaterial=="Mini Tusk"then MMon={"Mythological Pirate"}MPos=CFrame.new(-13545,470,-6917)SP="Default"elseif SelectMaterial=="Demonic Wisp"then MMon={"Demonic Soul"}MPos=CFrame.new(-9495.6806640625,453.58624267578125,5977.3486328125)SP="Default"end end end
QuestNeta = function()
  local Neta = QuestCheck()
  return {
    [1] = Mon,
    [2] = Qdata,
    [3] = Qname,
    [4] = PosM,
    [5] = NameMon,
    [6] = PosQ
  }
end


-- Fluent UI conversion: all tabs/functions from Nevoteam source
local Fluent, SaveManager, InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/OBFUP/refs/heads/main/GET.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Daicho Hub ",
    SubTitle = "- Blox fruit [By Thanh]",
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl,
    TabWidth = 160
})


-- Stop Tween Controller
local HD_StopTween_Registry = {}
local function HD_TrackTween(t) if t then table.insert(HD_StopTween_Registry,t) end return t end
local function HD_StopAllTweens()
    shouldTween = false
    for i=#HD_StopTween_Registry,1,-1 do pcall(function() HD_StopTween_Registry[i]:Cancel() end); HD_StopTween_Registry[i]=nil end
    pcall(function() if sea_activeTween then sea_activeTween:Cancel(); sea_activeTween=nil end end)
end

-- Floating Stop Tween button
local HD_StopTweenGui=Instance.new("ScreenGui"); HD_StopTweenGui.Name="HD_StopTween_Button"; HD_StopTweenGui.ResetOnSpawn=false; pcall(function() HD_StopTweenGui.Parent=game:GetService("CoreGui") end); if not HD_StopTweenGui.Parent then HD_StopTweenGui.Parent=plr:WaitForChild("PlayerGui") end
local HD_StopTween_Button=Instance.new("TextButton"); HD_StopTween_Button.Size=UDim2.fromOffset(82,48); HD_StopTween_Button.Position=UDim2.new(0,12,.52,0); HD_StopTween_Button.BackgroundColor3=Color3.fromRGB(255,235,0); HD_StopTween_Button.BorderSizePixel=2; HD_StopTween_Button.TextColor3=Color3.fromRGB(0,0,0); HD_StopTween_Button.Text="Stop\nTween"; HD_StopTween_Button.TextSize=17; HD_StopTween_Button.Font=Enum.Font.GothamBold; HD_StopTween_Button.ZIndex=50; HD_StopTween_Button.Parent=HD_StopTweenGui
Instance.new("UICorner",HD_StopTween_Button).CornerRadius=UDim.new(0,6)
HD_StopTween_Button.Activated:Connect(function() HD_StopAllTweens(); HD_StopTween_Button.Text="Stopped"; task.delay(.7,function() if HD_StopTween_Button.Parent then HD_StopTween_Button.Text="Stop\nTween" end end) end)

local Tabs = {
    Settings = Window:AddTab({Title = "Tab Setting", Icon = "cog"}),
    Config = Window:AddTab({Title = "Config", Icon = "settings"}),
    Main = Window:AddTab({Title = "Tab Main Farm", Icon = "home"}),
    Quests = Window:AddTab({Title = "Tab Multi Farm/Item", Icon = "swords"}),
    SeaEvent = Window:AddTab({Title = "Tab Sea Events", Icon = "rbxassetid://6035078898"}),
    Fish = Window:AddTab({Title = "Tab Fishing", Icon = "rbxassetid://127664059821666"}),
    Mirage = Window:AddTab({Title = "Tab Mirage", Icon = "mountain"}),
    Info = Window:AddTab({Title = "Tab status", Icon = "rbxassetid://10734984606"}),
    Race = Window:AddTab({Title = "Tab Upgrade Race", Icon = "dna"}),
    Drago = Window:AddTab({Title = "Tab Dragon Dojo", Icon = "flame"}),
    Prehistoric = Window:AddTab({Title = "Tab Prehistoric", Icon = "tent"}),
    Raids = Window:AddTab({Title = "Tab Fruit And Raid", Icon = "apple"}),
    PlayerPVP = Window:AddTab({Title = "Tab PvP/Visual/ESP", Icon = "crosshair"}),
    Travel = Window:AddTab({Title = "Tab Teleport", Icon = "rbxassetid://10723434557"}),
    Shop = Window:AddTab({Title = "Tab Shop", Icon = "shop"}),
    Misc = Window:AddTab({Title = "Tab Miscellaneous", Icon = "anchor"})
}

Tabs.Info:AddSection("Trạng Thái Máy Chủ")
Time = Tabs.Info:AddParagraph({
    Title = "Múi Giờ",
    Content = ""
})
function UpdateOS()
    local date = os.date("*t")
    local hour = (date.hour) % 24
    local ampm = hour < 12 and "Sáng" or "Tối"
    local timezone = string.format("%02i:%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, date.sec, ampm)
    local datetime = string.format("%02d/%02d/%04d", date.day, date.month, date.year)    
    local LocalizationService = game:GetService("LocalizationService")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local name = player.Name
    local result, code    
    if not getgenv().countryRegionCode then
        result, code = pcall(function()
            return LocalizationService:GetCountryRegionForPlayerAsync(player)
        end)
        if result then
            getgenv().countryRegionCode = code
        else
            getgenv().countryRegionCode = "Unknown"
        end
    else
        code = getgenv().countryRegionCode
    end
    Time:SetDesc(datetime.." - "..timezone.." [ " .. code .. " ]")
end
task.spawn(function()
    while true do
        UpdateOS()
        wait(1)
    end
end)
Timmessss = Tabs.Info:AddParagraph({
    Title = "Thời Gian",
    Content = ""
})
function UpdateTime()
    local GameTime = math.floor(workspace.DistributedGameTime + 0.5)
    local Hour = math.floor(GameTime / (60^2)) % 24
    local Minute = math.floor(GameTime / (60^1)) % 60
    local Second = math.floor(GameTime / (60^0)) % 60
    Timmessss:SetDesc(Hour.." Hour (h) "..Minute.." Minute (m) "..Second.." Second (s) ")
end
task.spawn(function()
    while true do
        UpdateTime()
        wait(1)
    end
end)
Miragecheck = Tabs.Info:AddParagraph({
    Title = "Đảo Bí Ẩn",
    Content = "Status: "
})
previousStatus = ""
task.spawn(function()
    pcall(function()
        while true do
            wait(1)            
            local mirageIslandExists = game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') ~= nil
            local currentStatus = mirageIslandExists and '✅️' or '❌️'
            if currentStatus ~= previousStatus then
                Miragecheck:SetDesc('Status: ' .. currentStatus)
                previousStatus = currentStatus
            end
        end
    end)
end)
Kitsunecheck = Tabs.Info:AddParagraph({
    Title = "Đảo Cáo",
    Content = "Status: "
})
task.spawn(function()
    local previousStatus = ""
    while task.wait(1) do
        local currentStatus = game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") and '✅️' or '❌️'
        if currentStatus ~= previousStatus then
            Kitsunecheck:SetDesc('Status: ' .. currentStatus)
            previousStatus = currentStatus
        end
    end
end)
CPrehistoriccheck = Tabs.Info:AddParagraph({
    Title = "Đảo Rồng",
    Desc = "Status: "
})
task.spawn(function()
    local previousStatus = ""
    while task.wait(1) do
        local currentStatus = game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and '✅️' or '❌️'
        if currentStatus ~= previousStatus then
            CPrehistoriccheck:SetDesc("Status: " .. currentStatus)
            previousStatus = currentStatus
        end
    end
end)
FrozenIsland = Tabs.Info:AddParagraph({
    Title = "Đảo Leviathan",
    Content = "Status: "
})
task.spawn(function()
    local previousStatus = ""
    while task.wait(1) do
        local currentStatus = game.Workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') and '✅️' or '❌️'
        if currentStatus ~= previousStatus then
            FrozenIsland:SetDesc('Status: ' .. currentStatus)
            previousStatus = currentStatus
        end
    end
end)
MobCakePrince = Tabs.Info:AddParagraph({
    Title = "Dimension Killed",
    Content = ""
})
task.spawn(function()
    while task.wait(1) do
        local cakePrince = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
        local killStatus = "Cake Prince: ✅️"
        if string.len(cakePrince) >= 86 then
            local killCount = string.sub(cakePrince, 39, 41)
            killStatus = "Kill: " .. killCount
        end
        MobCakePrince:SetDesc(killStatus)
    end
end)
CheckRip = Tabs.Info:AddParagraph({
    Title = "Rip_Indra",
    Content = "Status: "
})
task.spawn(function()
    local previousStatus = ""
    while task.wait(1) do
        local currentStatus = game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") and '✅️' or '❌️'
        if currentStatus ~= previousStatus then
            CheckRip:SetDesc("Status: " .. currentStatus)
            previousStatus = currentStatus
        end
    end
end)
CheckDoughKing = Tabs.Info:AddParagraph({
    Title = "Dough King",
    Content = "Status: "
})
task.spawn(function()
    local previousStatus = ""
    while task.wait(1) do
        local currentStatus = game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King") and '✅️' or '❌️'
        if currentStatus ~= previousStatus then
            CheckDoughKing:SetDesc("Status: " .. currentStatus)
            previousStatus = currentStatus
        end
    end
end)
EliteHunter = Tabs.Info:AddParagraph({
    Title = "Elite Hunter",
    Content = "Status: "
})
task.spawn(function()
    local previousStatus = ""
    while task.wait(1) do
        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) and '✅️' or '❌️'
        local progress = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress")
        if currentStatus ~= previousStatus then
            EliteHunter:SetDesc("Status: " .. currentStatus .. " | Killed: " .. progress)
            previousStatus = currentStatus
        end
    end
end)
FM = Tabs.Info:AddParagraph({
    Title = "Full Moon",
    Content = ""
})
task.spawn(function()
    while task.wait(1) do
        local moonTextureId = game:GetService("Lighting").Sky.MoonTextureId
        local moonStatus = "Moon: 0/5"
        if moonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
            moonStatus = "Moon: 5/5"
        elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
            moonStatus = "Moon: 4/5"
        elseif moonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
            moonStatus = "Moon: 3/5"
        elseif moonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
            moonStatus = "Moon: 2/5"
        elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
            moonStatus = "Moon: 1/5"
        end
        FM:SetDesc(moonStatus)
    end
end)
LegendarySword = Tabs.Info:AddParagraph({
    Title = "Legendary Sword",
    Content = "Status: "
})
task.spawn(function()
    local previousStatus = ""
    while task.wait(1) do
        local swordStatus = "Not Found Legend Swords"
        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") then
            swordStatus = "Shisui"
        elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2") then
            swordStatus = "Wando"
        elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3") then
            swordStatus = "Saddi"
        end
        LegendarySword:SetDesc(swordStatus)
    end
end)
StatusBone = Tabs.Info:AddParagraph({
    Title = "Xương",
    Content = ""
})
task.spawn(function()
    while task.wait(1) do
        StatusBone:SetDesc("You Have: " .. tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")) .. " Bones")
    end
end)

Tabs.Main:AddButton({
    Title = "HD Hub - community",
    Description = "Vào Discord Để Nhận Update Mới",
    Callback = function()
        pcall(function()
            if setclipboard then
                setclipboard("https://discord.gg/redz-Hub")
                Fluent:Notify({Title = "Discord", Content = "Đã copy link Discord", Duration = 2})
            end
        end)
    end
})
WeaponDropdown = Tabs.Main:AddDropdown("WeaponDropdown", {
    Title = "Chọn Vũ Khí",
    Flag = "WeaponDropdown",
    Values = {"Melee","Sword","Blox Fruit","Gun"},
    Default = "Melee",
    Callback = function(Value)
    _G.ChooseWP = Value
end})


task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if _G.ChooseWP == "Melee" then
                for _,v in pairs(plr.Backpack:GetChildren()) do
                    if v.ToolTip == "Melee" then
                        _G.SelectWeapon = v.Name
                    end
                end
            elseif _G.ChooseWP == "Sword" then
                for _,v in pairs(plr.Backpack:GetChildren()) do
                    if v.ToolTip == "Sword" then
                        _G.SelectWeapon = v.Name
                    end
                end
            elseif _G.ChooseWP == "Gun" then
                for _,v in pairs(plr.Backpack:GetChildren()) do
                    if v.ToolTip == "Gun" then
                        _G.SelectWeapon = v.Name
                    end
                end
            elseif _G.ChooseWP == "Blox Fruit" then
                for _,v in pairs(plr.Backpack:GetChildren()) do
                    if v.ToolTip == "Blox Fruit" then
                        _G.SelectWeapon = v.Name
                    end
                end
            end
        end)
    end
end)


-- Compatibility helper for the original UI Scale dropdown.
local Library = Library or {}
function Library:SetUIScale(scale)
    scale = tonumber(scale) or 1
    local target
    local function scan(container)
        for _, obj in ipairs(container:GetDescendants()) do
            if obj:IsA("TextLabel") and string.find(obj.Text or "", "HD Hub : Blox Fruits", 1, true) then
                target = obj:FindFirstAncestorWhichIsA("Frame")
                if target then return true end
            end
        end
        return false
    end
    pcall(function()
        local cg = game:GetService("CoreGui")
        scan(cg)
        if not target then scan(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")) end
        if target then
            local uiScale = target:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
            uiScale.Parent = target
            uiScale.Scale = scale
        end
    end)
end

ScaleDropdown = Tabs.Main:AddDropdown("ScaleDropdown", {

    Title = "UI Scale",

    Description = "",

    Values = {

        "Small",

        "Normal",

        "Large",

        "Extra Large"

    },

    Default = "Normal",

    Callback = function(value)

        if value == "Small" then

            Library:SetUIScale(0.6)

        elseif value == "Normal" then

            Library:SetUIScale(1.0)

        elseif value == "Large" then

            Library:SetUIScale(1.4)

        elseif value == "Extra Large" then

            Library:SetUIScale(1.6)

        end

    end

})


Tabs.Main:AddSection("First Farming")

Test = Tabs.Main:AddDropdown("Test", {
Title = "Chọn Vật Liệu",
Flag = "Test",
		Description = "",
		Values = MaterialList,
		,
		Callback = function(Value)
			getgenv().SelectMaterial = Value
		end
		})
Toggle = Tabs.Main:AddToggle("Toggle", {
Title = "Tự Động Materials", 
Flag = "Toggle",
Description = "", 
Default = false,
Callback = function(Value)
    getgenv().AutoMaterial = Value
end})
task.spawn(function()
  local function processEnemy(v, EnemyName)
    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
      if v.Name == EnemyName then repeat wait() Attack.Kill(v,getgenv().AutoMaterial) until not getgenv().AutoMaterial or not v.Parent or v.Humanoid.Health <= 0 end
    end
  end
  local function handleEnemySpawns()
    for _, v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
      for _, EnemyName in ipairs(MMon) do
        if string.find(v.Name, EnemyName) then
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude >= 10 then
            _tp(v.CFrame * Pos)
          end
        end
      end
    end
  end
  while task.wait(0.1) do
    if getgenv().AutoMaterial then
      pcall(function()
        if getgenv().SelectMaterial then MaterialMon(getgenv().SelectMaterial) _tp(MPos) end
        for _, EnemyName in ipairs(MMon) do
          for _, v in pairs(workspace.Enemies:GetChildren()) do processEnemy(v, EnemyName) end
        end
        handleEnemySpawns()
      end)
    end
  end
end)

-- Biến trạng thái NGOÀI toggle (module-level)
alreadyTeleported = false
teleporting = false
farmRunning = false  -- kiểm soát vòng lặp

FarmLevel = Tabs.Main:AddToggle("FarmLevel", {
    Title = "Tự Động Cày Cấp",
    Flag = "FarmLevel",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Level = Value

        if Value == true then
            -- Reset hoàn toàn khi bật lại
            alreadyTeleported = false
            teleporting = false
            farmRunning = false  -- dừng loop cũ nếu có
            task.wait(0.1)       -- đợi loop cũ dừng hẳn
            farmRunning = true

            -- Khởi động loop mới
            task.spawn(function()
                FarmLoop()
            end)
        else
            -- Tắt toggle → dừng loop
            farmRunning = false
            teleporting = false
        end
    end
})

local function IsInSubmergedIsland()
    local char = plr.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local islandXZ = Vector3.new(11520.8017578125, 0, 9829.513671875)
    local playerXZ = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
    return (playerXZ - islandXZ).Magnitude < 2000
end

THIRD_SEA_PLACE_IDS = {
    7449423635,
    100117331123089,
}

local function IsInThirdSea()
    for _, id in ipairs(THIRD_SEA_PLACE_IDS) do
        if game.PlaceId == id then return true end
    end
    return false
end

-- Toàn bộ logic farm đặt trong hàm riêng
function FarmLoop()
    alreadyTeleported = false
    teleporting = false
    FarmPos = nil
    local lastMon = nil  -- Theo dõi tên mob đang farm, reset FarmPos khi đổi vùng

    while farmRunning and _G.Level do
        task.wait(Sec)

        pcall(function()
            local char = plr.Character
            if not char then return end
            local Root = char:FindFirstChild("HumanoidRootPart")
            if not Root then return end

            Root.Anchored = false

            local myLevel = plr.Data.Level.Value
            local inSub = IsInSubmergedIsland()
            local inSea3 = IsInThirdSea()
            local questUI = plr.PlayerGui.Main.Quest
            local QuestTitle = questUI.Container.QuestTitle.Title.Text

            if inSub then
                alreadyTeleported = true
                teleporting = false
            end

            ----------------------------------------------------------------
            -- BƯỚC 1: Teleport xuống Submerged Island nếu đủ điều kiện
            ----------------------------------------------------------------
            if myLevel >= 2600
               and inSea3
               and not inSub
               and not alreadyTeleported
               and not teleporting
            then
                teleporting = true

                local npcPos = CFrame.new(-16269.1016, 29.5177539, 1372.3204)

                repeat
                    task.wait(Sec)
                    if (Root.Position - npcPos.Position).Magnitude > 5 then
                        _tp(npcPos)
                    end
                until not farmRunning
                   or not _G.Level
                   or (Root.Position - npcPos.Position).Magnitude <= 5

                if not farmRunning or not _G.Level then
                    teleporting = false
                    return
                end

                task.wait(0.5)

                if (Root.Position - npcPos.Position).Magnitude <= 5 then
                    pcall(function()
                        Remotes.RFSubmarineWorkerSpeak:InvokeServer("TravelToSubmergedIsland")
                    end)
                end

                local timeout = tick()
                repeat
                    task.wait(Sec)
                until IsInSubmergedIsland()
                   or tick() - timeout > 10
                   or not farmRunning
                   or not _G.Level

                if IsInSubmergedIsland() then
                    alreadyTeleported = true
                end

                teleporting = false
                return
            end

            ----------------------------------------------------------------
            -- BƯỚC 2: Farm quest
            ----------------------------------------------------------------
            -- Bỏ quest sai
            if questUI.Visible and QuestNeta()[5] and not string.find(QuestTitle, QuestNeta()[5]) then
                replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
            end

            -- Reset FarmPos khi tên mob thay đổi (đổi vùng farm)
            local currentMon = QuestNeta()[1]
            if currentMon ~= lastMon then
                FarmPos = nil
                lastMon = currentMon
            end

            -- Chưa có quest → lấy quest
            if not questUI.Visible then
                local questPos = QuestNeta()[6]
                if (Root.Position - questPos.Position).Magnitude > 5 then
                    _tp(questPos)
                end
                task.wait(0.1)
                if (Root.Position - questPos.Position).Magnitude <= 5 then
                    pcall(function()
                        replicated.Remotes.CommF_:InvokeServer("StartQuest", QuestNeta()[3], QuestNeta()[2])
                    end)
                end
            else
                -- Đã có quest → farm enemy
                local enemyName = QuestNeta()[1]
                local foundAny = false

                local function findEnemy()
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if Attack.Alive(v) and v.Name == enemyName then
                            return v
                        end
                    end
                    return nil
                end

                local enemy = findEnemy()
                if enemy then
                    foundAny = true
                    repeat
                        task.wait(Sec)
                        if not farmRunning or not _G.Level then break end
                        if not Attack.Alive(enemy) then
                            enemy = findEnemy()
                            if not enemy then break end
                        end
                        local enemyCFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                        if (Root.Position - enemyCFrame.Position).Magnitude > 5 then
                            _tp(enemyCFrame)
                        end
                        Attack.Kill(enemy, _G.Level)
                    until not farmRunning
                       or not _G.Level
                       or not questUI.Visible
                end

                -- Không thấy enemy → tp vị trí farm
                if not foundAny then
                    local farmPos = QuestNeta()[4]
                    if (Root.Position - farmPos.Position).Magnitude > 5 then
                        _tp(farmPos)
                    end
                end
            end
        end)
    end

    farmRunning = false
    teleporting = false
    FarmPos = nil
end


ClosetMons = Tabs.Main:AddToggle("ClosetMons", {
    Title = "Auto Accept Quests",

    Default = false,

    Callback = function(Value)

        _G.AcceptQuestC = Value

    end

})


ClosetMons = Tabs.Main:AddToggle("ClosetMons", {
Title = "Tự Động Farm Quái Gần", 
Flag = "ClosetMons",
Description = "", 
Default = false, 
Callback = function(Value)
  _G.AutoFarmNear = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    pcall(function()
      if _G.AutoFarmNear then
        for i,v in pairs(workspace.Enemies:GetChildren()) do
          if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") then
            if v.Humanoid.Health > 0 then
              repeat wait() Attack.Kill(v,_G.AutoFarmNear) until not _G.AutoFarmNear or not v.Parent or v.Humanoid.Health <= 0
            end
          end
        end
      end
    end)
  end
end)


Tabs.Main:AddSection("Collect Chest")

ChestTW = Tabs.Main:AddToggle("ChestTW", {
    Title = "Tự Động Nhặt Rương", 
    Flag = "ChestTW",
    Description = "", 
    Default = false,
    Callback = function(Value)
        _G.AutoFarmChest = Value
    end
})

task.spawn(function()
    while task.wait() do -- Dùng task.wait() thay vì wait() để tối ưu hơn
        if _G.AutoFarmChest then
            pcall(function()
                local CollectionService = game:GetService("CollectionService")
                local Players = game:GetService("Players")
                local Player = Players.LocalPlayer
                local Character = Player.Character
                if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
                
                local MyPos = Character.HumanoidRootPart.Position
                local Chests = CollectionService:GetTagged("_ChestTagged")      
                local Distance, Nearest = math.huge, nil  

                -- Tìm rương gần nhất
                for _, Chest in pairs(Chests) do
                    if Chest and (Chest:IsA("BasePart") or Chest:IsA("Model")) then
                        local ChestPos = Chest:GetPivot().Position
                        local Mag = (ChestPos - MyPos).Magnitude
                        
                        if (not SelectedIsland or Chest:IsDescendantOf(SelectedIsland)) then
                            if not Chest:GetAttribute("IsDisabled") and Mag < Distance then
                                Distance = Mag
                                Nearest = Chest
                            end
                        end
                    end
                end

                -- Xử lý di chuyển
                if Nearest then
                    local TargetCFrame = Nearest:GetPivot()
                    _tp(TargetCFrame)
                end
            end)
        end
    end
end)



StopI = Tabs.Main:AddToggle("StopI", {
Title = "Dừng Khi Có Vật Phẩm", 
Flag = "StopI",
Description = "", 
Default = true,
Callback = function(Value)
    _G.StopWhenChalice = Value
end})

task.spawn(function()
    while task.wait(0.2) do
        if _G.StopWhenChalice and (_G.AutoFarmChest or _G.AutoChestBP) then
            pcall(function()
                if GetBP("God's Chalice") or GetBP("Sweet Chalice") or GetBP("Fist of Darkness") then
                    _G.AutoFarmChest = false
                    _G.AutoChestBP = false
                end
            end)
        end
    end
end)

Tabs.Main:AddSection("Collect Berry")

Berry = Tabs.Main:AddToggle("Berry", {
Title = "Tự Động Nhặt Berry", 
Flag = "Berry",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoBerry = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.AutoBerry then
      local CollectionService= game:GetService("CollectionService")
      local Players= game:GetService("Players")
      local Player = Players.LocalPlayer
      local BerryBush = CollectionService:GetTagged("BerryBush")      
      local Distance, Nearest = math.huge      
      for i = 1, #BerryBush do
        local Bush = BerryBush[i]        
        for AttributeName, BerryName in pairs(Bush:GetAttributes()) do
          if not BerryArray or table.find(BerryArray, BerryName) then           
            _tp(Bush.Parent:GetPivot())
            for i = 1, #BerryBush do
            local Bush = BerryBush[i]        
              for AttributeName, BerryName in pairs(Bush:GetChildren()) do
                if not BerryArray or table.find(BerryArray, BerryName) then
                  _tp(BerryName.WorldPivot)
                  fireproximityprompt(BerryName.ProximityPrompt,math.huge)
                end
              end
            end      
          end
        end
      end      
    end
  end
end)



BerryH = Tabs.Main:AddToggle("BerryH", {
Title = "Tự Động Nhặt Berry + Đổi Sever", 
Flag = "BerryH",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoBerryH = Value
end})

task.spawn(function()
    while task.wait(Sec) do
        if _G.AutoBerryH then
            local CollectionService = game:GetService("CollectionService")
            local Players = game:GetService("Players")
            local Player = Players.LocalPlayer
            local BerryBush = CollectionService:GetTagged("BerryBush")
            
            -- Kiểm tra nếu không có BerryBush
            if #BerryBush == 0 then
                -- Server Hop khi không tìm thấy BerryBush
                local TeleportService = game:GetService("TeleportService")
                local ServerList = {}
                
                -- Lấy danh sách server
                local Success, Error = pcall(function()
                    ServerList = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                end)
                
                if Success and ServerList.data then
                    for _, Server in pairs(ServerList.data) do
                        if Server.playing < Server.maxPlayers and Server.id ~= game.JobId then
                            TeleportService:TeleportToPlaceInstance(game.PlaceId, Server.id, Player)
                            break
                        end
                    end
                end
            else
                -- Code farm Berry khi có BerryBush
                for i = 1, #BerryBush do
                    local Bush = BerryBush[i]
                    
                    for AttributeName, BerryName in pairs(Bush:GetAttributes()) do
                        if not BerryArray or table.find(BerryArray, BerryName) then
                            _tp(Bush.Parent:GetPivot())
                            
                            for j = 1, #BerryBush do
                                local Bush2 = BerryBush[j]
                                
                                for _, BerryChild in pairs(Bush2:GetChildren()) do
                                    if not BerryArray or table.find(BerryArray, BerryChild.Name) then
                                        _tp(BerryChild.WorldPivot)
                                        fireproximityprompt(BerryChild.ProximityPrompt, math.huge)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

Tabs.Main:AddSection("Farm Elite Hunter")

Process = Tabs.Main:AddParagraph({
Title = "Elites Process ",
Content = ""})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()    
      Process:SetDesc("Elite Procress :  " ..replicated.Remotes.CommF_:InvokeServer("EliteHunter","Progress"))
    end)
  end
end)

EliteHunter = Tabs.Main:AddParagraph({
    Title = "Elite Xuất Hiện",
    Content = "Status: "
})
task.spawn(function()
    local previousStatus = ""
    while task.wait(1) do
        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) and '✅️' or '❌️'
        local progress = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress")
        if currentStatus ~= previousStatus then
            EliteHunter:SetDesc("Status: " .. currentStatus .. " | Killed: " .. progress)
            previousStatus = currentStatus
        end
    end
end)

EliteQ = Tabs.Main:AddToggle("EliteQ", {
    Title = "Tự Động Farm Elite",
    Flag = "EliteQ",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.FarmEliteHunt = Value
end})

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if _G.FarmEliteHunt then
                local questGui = plr.PlayerGui.Main.Quest
                local questTitle = questGui.Container.QuestTitle.Title.Text

                -- Nếu chưa có nhiệm vụ
                if not questGui.Visible then
                    -- Nhận nhiệm vụ Elite
                    local result = replicated.Remotes.CommF_:InvokeServer("EliteHunter")
                    if result == nil or string.find(result, "Cooldown") then
                        -- Nếu đang cooldown hoặc chưa có boss
                        wait(10)
                        return
                    end
                    task.wait(1)
                else
                    -- Đã có nhiệm vụ => xác định boss nào
                    local eliteName = nil
                    for _, name in pairs({"Diablo", "Urban", "Deandre"}) do
                        if string.find(questTitle, name) then
                            eliteName = name
                            break
                        end
                    end

                    if eliteName then
                        local boss = nil
                        -- Tìm boss trong Replicated hoặc Enemies
                        for _, v in pairs(replicated:GetChildren()) do
                            if v.Name == eliteName and v:FindFirstChild("HumanoidRootPart") then
                                boss = v
                                break
                            end
                        end
                        for _, v in pairs(Enemies:GetChildren()) do
                            if v.Name == eliteName and Attack.Alive(v) then
                                boss = v
                                break
                            end
                        end

                        if boss and boss:FindFirstChild("HumanoidRootPart") then
                            _tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            repeat
                                wait()
                                Attack.Kill(boss, _G.FarmEliteHunt)
                            until not _G.FarmEliteHunt or not boss.Parent or boss.Humanoid.Health <= 0 or not questGui.Visible
                        else
                            -- Không thấy boss → đợi boss spawn lại
                            wait(5)
                        end
                    else
                        -- Nếu quest title lỗi hoặc bug → bỏ quest
                        replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                    end
                end
            end
        end)
    end
end)

EliteH = Tabs.Main:AddToggle("EliteH", {
	Title = "Tự Động Farm Elite + Đổi Sever",
	Flag = "EliteH",
	Description = "",
	Default = false,
	Callback = function(Value)
	_G.FarmEliteH = Value
end})

-- === Hàm HOP SERVER ===
local function HopServer()
	local Http = game:GetService("HttpService")
	local TPS = game:GetService("TeleportService")
	local Api = "https://games.roblox.com/v1/games/"
	local PlaceID = game.PlaceId
	local Servers = {}
	local Cursor = ""
	local foundServer = false

	repeat
		local success, result = pcall(function()
			return game:HttpGet(Api .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. Cursor)
		end)
		if success and result then
			local data = Http:JSONDecode(result)
			if data.data then
				for _, v in pairs(data.data) do
					if v.playing < v.maxPlayers and v.id ~= game.JobId then
						foundServer = true
						TPS:TeleportToPlaceInstance(PlaceID, v.id)
						break
					end
				end
				Cursor = data.nextPageCursor or ""
			end
		end
	until not Cursor or foundServer
end

-- === FARM ELITE ===
task.spawn(function()
	while task.wait(1) do
		pcall(function()
			if _G.FarmEliteH then
				local questGui = plr.PlayerGui.Main.Quest
				local questTitle = questGui.Container.QuestTitle.Title.Text

				-- Nếu chưa có nhiệm vụ
				if not questGui.Visible then
					local result = replicated.Remotes.CommF_:InvokeServer("EliteHunter")
					if result == nil or string.find(result, "Cooldown") then
						-- Nếu cooldown hoặc chưa có boss → hop
						HopServer()
						return
					end
					task.wait(1)

				else
					-- Xác định boss Elite
					local eliteName = nil
					for _, name in pairs({"Diablo", "Urban", "Deandre"}) do
						if string.find(questTitle, name) then
							eliteName = name
							break
						end
					end

					if eliteName then
						local boss = nil
						for _, v in pairs(replicated:GetChildren()) do
							if v.Name == eliteName and v:FindFirstChild("HumanoidRootPart") then
								boss = v
								break
							end
						end
						for _, v in pairs(workspace.Enemies:GetChildren()) do
							if v.Name == eliteName and Attack.Alive(v) then
								boss = v
								break
							end
						end

						if boss and boss:FindFirstChild("HumanoidRootPart") then
							_tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
							repeat
								wait()
								Attack.Kill(boss, _G.FarmEliteH)
							until not _G.FarmEliteH or not boss.Parent or boss.Humanoid.Health <= 0 or not questGui.Visible
						else
							-- Không thấy boss sau vài giây → hop server
							task.wait(5)
							HopServer()
						end
					else
						-- Quest lỗi → hủy và hop luôn
						replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
						task.wait(1)
						HopServer()
					end
				end
			end
		end)
	end
end)


Tabs.Main:AddSection("Unlocked Dungeon")

DouD = Tabs.Main:AddToggle("DouD", {
Title = "Tự Động Mở Khoá Raid Bột", 
Flag = "DouD",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Doughv2 = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.Doughv2 then
      pcall(function()
	    if not workspace.Map.CakeLoaf:FindFirstChild("RedDoor") then
	      if GetBP("Red Key") then
	        replicated.Remotes.CommF_:InvokeServer("CakeScientist","Check")
	        replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Check")
		  end
	    elseif workspace.Map.CakeLoaf:FindFirstChild("RedDoor") then
          if GetBP("Red Key") then
		    repeat wait() _tp(CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782)) until not _G.Doughv2 or (plr.Character.HumanoidRootPart.CFrame - CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782)).Magnitude <= 5
		    EquipWeapon("Red Key")
		  end
		  elseif GetConnectionEnemies("Dough King") then
		    local v = GetConnectionEnemies("Dough King")
            if v then
              repeat wait() Attack.Kill(v,_G.Doughv2) until not _G.Doughv2 or not v.Parent or v.Humanoid.Health <= 0
            else
              _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) 
            end
	      end
		  if GetBP("Sweet Chalice") then
		    replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
		    _G.AutoMiror = true
	      else
	        _G.AutoMiror = false
          end
	      if GetBP("God's Chalice") and GetM("Conjured Cocoa") >= 10 then
		    replicated.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
		  end
	      if not plr.Backpack:FindFirstChild("God's Chalice") or plr.Character:FindFirstChild("God's Chalice") then
	        _G.FarmEliteHunt = true
		  else
		    _G.FarmEliteHunt = false
		  end
	      if GetM("Conjured Cocoa") <= 10 then	        
		  local cocoa3 = {"Cocoa Warrior","Chocolate Bar Battler"}
		  local v = GetConnectionEnemies(cocoa3)
            if v then
            repeat wait() Attack.Kill(v,_G.Doughv2) until _G.Doughv2 == false or not v.Parent or v.Humanoid.Health <= 0
          else
            _tp(CFrame.new(402.7189025878906, 81.06050109863281, -12259.54296875))
          end	      
        end
      end)
    end
  end
end)
PhoD = Tabs.Main:AddToggle("PhoD", {
Title = "Tự Động Mở Khoá Raid Phượng Hoàng", 
Flag = "PhoD",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoPhoenixF = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.AutoPhoenixF then
      pcall(function()
        if GetBP("Bird-Bird: Phoenix") then
          if plr.Backpack:FindFirstChild(plr.Data.DevilFruit.Value) then
            if plr.Backpack:FindFirstChild(plr.Data.DevilFruit.Value).Level.Value >= 400 then
               _tp(CFrame.new(-2812.76708984375, 254.803466796875, -12595.560546875))
               if (CFrame.new(-2812.76708984375, 254.803466796875, -12595.560546875).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                 replicated.Remotes.CommF_:InvokeServer("SickScientist","Check")
                 replicated.Remotes.CommF_:InvokeServer("SickScientist","Heal")
               end
             end
             elseif plr.Character:FindFirstChild(plr.Data.DevilFruit.Value) then
             if plr.Character:FindFirstChild(plr.Data.DevilFruit.Value).Level.Value >= 400 then
               _tp(CFrame.new(-2812.76708984375, 254.803466796875, -12595.560546875))
              if (CFrame.new(-2812.76708984375, 254.803466796875, -12595.560546875).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                replicated.Remotes.CommF_:InvokeServer("SickScientist","Check")
                replicated.Remotes.CommF_:InvokeServer("SickScientist","Heal")
              end
            end
          end
        end
      end)
    end 
  end
end)

Tabs.Main:AddSection("Tyrant of the Skies")

TyrantStatus = Tabs.Main:AddParagraph({
    Title = "Boss Xuất Hiện",
    Content = ""
})

task.spawn(function()
    pcall(function()
        while task.wait(1) do
            if workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                TyrantStatus:SetDesc("✅")
            else
                TyrantStatus:SetDesc("❌")
            end
        end
    end)
end)

FarmTyrant = Tabs.Main:AddToggle("FarmTyrant", {
Title = "Tự Động Đánh Boss", 
Flag = "FarmTyrant",
Description = "", 
Default = false,
Callback = function(Value) 
    getgenv().FarmTyrant = Value 
end})

task.spawn(function()
    while task.wait(Sec) do
        if getgenv().FarmTyrant then
            pcall(function()
                if not plr.Character then return end
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                local bossPos = Vector3.new(-16268.287, 152.616, 1390.773)
                
                -- Teleport đến boss nếu xa
                if (hrp.Position - bossPos).Magnitude > 5 then
                    _tp(CFrame.new(bossPos))
                    repeat wait() until not getgenv().FarmTyrant or (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and (plr.Character.HumanoidRootPart.Position - bossPos).Magnitude <= 5)
                end

                -- Tìm và farm boss
                local boss = workspace.Enemies:FindFirstChild("Tyrant of the Skies")
                if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                    repeat
                        if not getgenv().FarmTyrant then break end
                        if Attack and Attack.Kill then
                            Attack.Kill(boss, getgenv().FarmTyrant)
                        end
                        wait()
                    until not getgenv().FarmTyrant or not boss.Parent or boss.Humanoid.Health <= 0
                    return
                end

                -- Farm mob nếu boss chưa spawn
                local mobList = {"Serpent Hunter","Skull Slayer","Isle Champion","Sun-kissed Warrior"}
                for _, mobName in ipairs(mobList) do
                    if not getgenv().FarmTyrant then break end
                    for _, mob in pairs(workspace.Enemies:GetChildren()) do
                        if not getgenv().FarmTyrant then break end
                        if mob and mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            if (hrp.Position - mob.HumanoidRootPart.Position).Magnitude > 5000 then
                                _tp(mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                local t0 = tick()
                                repeat wait() hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") until not getgenv().FarmTyrant or not hrp or (hrp.Position - mob.HumanoidRootPart.Position).Magnitude <= 6 or tick() - t0 > 8
                            end
                            repeat
                                if not getgenv().FarmTyrant then break end
                                if Attack and Attack.Kill then
                                    Attack.Kill(mob, getgenv().FarmTyrant)
                                end
                                wait()
                            until not getgenv().FarmTyrant or not mob.Parent or mob.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)

FarmPhaBinh = Tabs.Main:AddToggle("FarmPhaBinh", {
Title = "Tự Động Triệu Hồi Boss", 
Flag = "FarmPhaBinh",
Description = "", 
Default = false,
Callback = function(Value)
    getgenv().FarmPhaBinh = Value
end})

local function sendSkillKey(skillKey)
    local virtualInputManager = game:GetService("VirtualInputManager")
    virtualInputManager:SendKeyEvent(true, skillKey, false, game)
    wait(0.05)
    virtualInputManager:SendKeyEvent(false, skillKey, false, game)
end

local function equipAndUseSkill(toolType)
    local character = plr.Character
    local backpack = plr.Backpack
    if not (character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0) then return end

    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.ToolTip == toolType then
            item.Parent = character
            wait(0.12)
            for _, skill in ipairs({"Z", "X", "C", "V", "F"}) do
                if not getgenv().FarmPhaBinh then break end
                pcall(function() sendSkillKey(skill) end)
                wait(0.12)
            end
            item.Parent = backpack
            break
        end
    end
end

PhaBinhPoints = {
    CFrame.new(-16332.5263671875, 158.07200622558594, 1440.324951171875),
    CFrame.new(-16288.609375, 158.16700744628906, 1470.3680419921875),
    CFrame.new(-16245.412109375, 158.43699645996094, 1463.365966796875),
    CFrame.new(-16212.46875, 158.16700744628906, 1466.343994140625),
    CFrame.new(-16211.9462890625, 158.07200622558594, 1322.39794921875),
    CFrame.new(-16260.921875, 154.92100524902344, 1323.615966796875),
    CFrame.new(-16297.0595703125, 159.322998046875, 1317.2239990234375),
    CFrame.new(-16335.0966796875, 159.33399963378906, 1324.885986328125),
}

task.spawn(function()
    while task.wait(Sec) do
        if getgenv().FarmPhaBinh then
            pcall(function()
                if not (plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0) then return end

                for _, point in ipairs(PhaBinhPoints) do
                    if not getgenv().FarmPhaBinh then break end

                    _tp(point)

                    local arrived = false
                    local start = tick()
                    while tick() - start < 12 and not arrived and getgenv().FarmPhaBinh do
                        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                        if not hrp then break end
                        local dist = (hrp.Position - point.Position).Magnitude
                        if dist <= 3 then
                            arrived = true
                            break
                        end
                        wait(0.1)
                    end

                    if getgenv().FarmPhaBinh and arrived then
                        equipAndUseSkill("Melee")
                        equipAndUseSkill("Sword")
                        equipAndUseSkill("Gun")
                    end
                end
            end)
        end
    end
end)


Tabs.Main:AddSection("Farm Material Ectoplasm")


Ecto = Tabs.Main:AddToggle("Ecto", {
Title = "Tự Động Cày Ectoplasm", 
Flag = "Ecto",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoEctoplasm = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.AutoEctoplasm then
        local EctoTable = {"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior"}    
        local v = GetConnectionEnemies(EctoTable)
		if Attack.Alive(v) then
		  repeat wait() Attack.Kill(v, _G.AutoEctoplasm)until not _G.AutoEctoplasm or not v.Parent or v.Humanoid.Health <= 0		        
	    else
	      replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
	    end
      end
    end)
  end
end)


Tabs.Main:AddSection("Farm Boss")

if World1 then 
    BossList = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
elseif World2 then 
    BossList = {"Diamond","Jeremy","Orbitus","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
elseif World3 then 
    BossList = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Dough King","Longma","Soul Reaper","Tyrant of the Skies"}
end

-- ==============================
-- STORAGE
-- ==============================
_G.BossStorage = _G.BossStorage or {
    SelectBoss    = nil,
    AutoFarmBoss  = false,
    StatusRunning = true,
}
BS = _G.BossStorage

-- ==============================
-- BOSS STATUS LABEL
-- ==============================
BossStatus = Tabs.Main:AddParagraph({
    Title = "Trạng Thái Boss",
    Content = "Chưa Chọn Boss"
})

-- ==============================
-- UTILITIES
-- ==============================
local function SetStatus(text)
    pcall(function() BossStatus:SetDesc(tostring(text)) end)
end

local function FindBoss(targetName)
    local result = nil
    local upper = string.upper(targetName)
    pcall(function()
        local enemies = workspace:FindFirstChild("Enemies")
        if not enemies then return end
        for _, model in ipairs(enemies:GetChildren()) do
            pcall(function()
                if not model or not model.Parent then return end
                if not string.find(string.upper(model.Name), upper, 1, true) then return end
                local hum = model:FindFirstChildWhichIsA("Humanoid")
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 0 then
                    result = {model = model, hum = hum, hrp = hrp}
                end
            end)
            if result then break end
        end
    end)
    return result
end

-- ==============================
-- LOOP STATUS (đơn giản, nhẹ)
-- ==============================
task.spawn(function()
    while BS.StatusRunning do
        pcall(function()
            local boss = BS.SelectBoss
            if not boss or boss == "" then
                SetStatus("Chưa Chọn Boss")
                return
            end

            local found = FindBoss(boss)
            if found then
                local hp    = math.floor(found.hum.Health)
                local maxHp = math.floor(found.hum.MaxHealth)
                local pct   = math.floor((hp / maxHp) * 100)
                SetStatus(string.format("✅ %s\nHP: %d/%d (%d%%)", found.model.Name, hp, maxHp, pct))
            else
                SetStatus("❌ Chưa Spawn - Quá Xa Không Thể Check")
            end
        end)

        task.wait(0.5)
    end
end)

-- ==============================
-- DROPDOWN CHỌN BOSS
-- ==============================
BossDropdown = Tabs.Main:AddDropdown("BossDropdown", {
    Title = "Chọn Boss",
    Flag = "BossDropdown",
    Description = "",
    Values = BossList,
    ,
    Callback = function(value)
        BS.SelectBoss        = value
        getgenv().SelectBoss = value
        _G.SelectBoss        = value
        SetStatus("Đang Tìm: " .. tostring(value) .. "...")
        print("[Chọn Boss] " .. tostring(value))
    end
})

-- ==============================
-- TOGGLE FARM BOSS
-- ==============================
FarmBossToggle = Tabs.Main:AddToggle("FarmBossToggle", {
    Title = "Tự Động Đánh Boss",
    Flag = "FarmBossToggle",
    Description = "",
    Default = false,
    Callback = function(Value)
        BS.AutoFarmBoss        = Value
        getgenv().AutoFarmBoss = Value
        print("[Farm Boss] " .. (Value and "BẬT" or "TẮT"))
    end
})

-- ==============================
-- LOOP FARM BOSS
-- ==============================
task.spawn(function()
    while task.wait(0.2) do
        if not BS.AutoFarmBoss or not BS.SelectBoss then continue end

        pcall(function()
            local plr  = game.Players.LocalPlayer
            local char = plr.Character
            local hrp  = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local found = FindBoss(BS.SelectBoss)

            if found then
                -- Boss đang stream -> TP tới và đánh
                _tp(found.hrp.CFrame * CFrame.new(0, 35, 0))
                if Attack and typeof(Attack.Kill) == "function" then
                    Attack.Kill(found.model, true)
                end
            else
                -- Boss chưa stream -> TP tới vị trí spawn để kéo stream
                local upper = string.upper(BS.SelectBoss)
                pcall(function()
                    for _, rep in ipairs(game.ReplicatedStorage:GetChildren()) do
                        if string.find(string.upper(rep.Name), upper, 1, true) then
                            local part = rep:FindFirstChild("HumanoidRootPart")
                                      or rep:FindFirstChildWhichIsA("BasePart")
                            if part then
                                _tp(part.CFrame * CFrame.new(0, 15, 0))
                                break
                            end
                        end
                    end
                end)
            end
        end)
    end
end)
Tabs.Main:AddSection("Farming Mastery")
posMastery = {"Cake","Bone"}
Mastery_Config = Tabs.Main:AddDropdown("Mastery_Config", {
Title = "Chọn Địa Điểm Farm",
Flag = "Mastery_Config",
		Description = "",
		Values = posMastery,
		,
		Callback = function(Value)
  SelectIsland = Value
end})
-- Biến lưu % máu, mặc định là 70%
_G.FarmMasteryHealth = 70 

MasteryFruits = Tabs.Main:AddToggle("MasteryFruits", {
    Title = "Tự Động Thông Thạo Trái", 
    Flag = "MasteryFruits",
    Description = "", 
    Default = false,
    Callback = function(Value)
        _G.FarmMastery_Dev = Value
    end
})

-- Thêm thanh Slider để chỉnh % máu
MasteryHealthSlider = Tabs.Main:AddSlider("MasteryHealthSlider", {
    Title = "Phần Trăm Máu Kết Liễu",
    Flag = "MasteryHealthSlider",
    Description = "",
    Default = 70,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        _G.FarmMasteryHealth = Value
    end
})

task.spawn(function()
    task.spawn(function()
        while task.wait(0.5) do
            pcall(function()
                if _G.FarmMastery_Dev or _G.FarmMastery_G or _G.FarmMastery_S then 
                    for a,b in pairs(plr.PlayerGui.Notifications:GetChildren()) do 
                        if b.Name=="NotificationTemplate" then 
                            if string.find(b.Text,"Skill locked!") then 
                                b:Destroy()
                            end 
                        end 
                    end 
                end 
            end)
        end
    end)
end)

task.spawn(function()
  while task.wait(Sec) do
    if _G.FarmMastery_Dev then
      pcall(function()
        if SelectIsland == "Cake" then         
          local v = GetConnectionEnemies(mastery1)
          if v then		   
            -- Thay thế số 70 cứng thành biến _G.FarmMasteryHealth của thanh Slider
            HealthM = v.Humanoid.MaxHealth * (_G.FarmMasteryHealth / 100)
            repeat wait()
              MousePos = v.HumanoidRootPart.Position
              Attack.Mas(v,_G.FarmMastery_Dev)
            until _G.FarmMastery_Dev == false or v.Humanoid.Health <= 0 or not v.Parent         		         		        
          else
            _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) 
          end
        elseif SelectIsland == "Bone" then
          local v = GetConnectionEnemies(mastery2)
          if v then		
            -- Thay thế số 70 cứng thành biến _G.FarmMasteryHealth của thanh Slider
            HealthM = v.Humanoid.MaxHealth * (_G.FarmMasteryHealth / 100)
            repeat wait()
              MousePos = v.HumanoidRootPart.Position
              Attack.Mas(v,_G.FarmMastery_Dev)
            until _G.FarmMastery_Dev == false or v.Humanoid.Health <= 0 or not v.Parent		        
          else
            _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 		    
          end
        end
      end)
    end
  end
end)

-- Biến lưu % máu, mặc định là 70%
_G.FarmMasteryHealth = _G.FarmMasteryHealth or 70 

MasteryGun = Tabs.Main:AddToggle("MasteryGun", {
    Title = "Tự Động Thông Thạo Súng", 
    Flag = "MasteryGun",
    Description = "", 
    Default = false,
    Callback = function(Value)
        _G.FarmMastery_G = Value
    end
})

-- Thêm thanh Slider chỉnh % máu cho Quái (Áp dụng cho Gun)
MasteryHealthSliderGun = Tabs.Main:AddSlider("MasteryHealthSliderGun", {
    Title = "Phần Trăm Máu Kết Liễu",
    Flag = "MasteryHealthSliderGun",
    Description = "",
    Default = 70,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        _G.FarmMasteryHealth = Value
    end
})

task.spawn(function()
  while task.wait(Sec) do
    if _G.FarmMastery_G then
      pcall(function()
        if SelectIsland == "Cake" then
          local v = GetConnectionEnemies(mastery1)
          if v then		      
            -- Sử dụng biến _G.FarmMasteryHealth từ thanh Slider
            HealthM = v.Humanoid.MaxHealth * (_G.FarmMasteryHealth / 100)
            repeat wait()
              MousePos = v.HumanoidRootPart.Position
              Attack.Masgun(v,_G.FarmMastery_G)
              local Modules = replicated:FindFirstChild("Modules")
              local Net = Modules:FindFirstChild("Net")
              local RE_ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent")    
              if plr.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then return end
              if plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name == 'Skull Guitar' then
                SoulGuitar = true
                plr.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
                if _G.FarmMastery_G then
                  vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1);wait(0.05)
                  vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1);wait(0.05)
                end
              elseif plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name ~= 'Skull Guitar' then
                SoulGuitar = false
                RE_ShootGunEvent:FireServer(MousePos, { v.HumanoidRootPart })
                if _G.FarmMastery_G then
                  vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1);wait(0.05)
                  vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1);wait(0.05)
                end
              end		            		
            until _G.FarmMastery_G == false or v.Humanoid.Health <= 0 or not v.Parent    
            SoulGuitar = false     		         		        
          else
            _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) 		    
          end
        elseif SelectIsland == "Bone" then
          local v = GetConnectionEnemies(mastery2)
          if v then		      
            -- Sử dụng biến _G.FarmMasteryHealth từ thanh Slider
            HealthM = v.Humanoid.MaxHealth * (_G.FarmMasteryHealth / 100)
            repeat wait()
              MousePos = v.HumanoidRootPart.Position
              Attack.Masgun(v,_G.FarmMastery_G)
              local Modules = replicated:FindFirstChild("Modules")
              local Net = Modules:FindFirstChild("Net")
              local RE_ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent")    
              if plr.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then return end
              if plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name == 'Skull Guitar' then
                SoulGuitar = true
                plr.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
                if _G.FarmMastery_G then
                  vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1);wait(0.05)
                  vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1);wait(0.05)
                end
              elseif plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name ~= 'Skull Guitar' then
                SoulGuitar = false
                RE_ShootGunEvent:FireServer(MousePos, { v.HumanoidRootPart })
                if _G.FarmMastery_G then
                  vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1);wait(0.05)
                  vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1);wait(0.05)
                end
              end		            		
            until _G.FarmMastery_G == false or v.Humanoid.Health <= 0 or not v.Parent    
            SoulGuitar = false     		         		        
          else
            _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 
          end
        end
      end)
    end
  end
end)


_G.DragonStormHealth = _G.DragonStormHealth or 70

MasteryGunDS = Tabs.Main:AddToggle("MasteryGunDS", {
    Title = "Tự Động Mastery Dragon Storm", 
    Flag = "MasteryGunDS",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.FarmMastery_DS = Value
    end
})

MasteryHealthSliderDS = Tabs.Main:AddSlider("MasteryHealthSliderDS", {
    Title = "Phần Trăm Máu Kết Liễu",
    Flag = "MasteryHealthSliderDS",
    Description = "",
    Default = 70,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        _G.DragonStormHealth = Value
    end
})


getgenv().PMT_GunFarm_Range = getgenv().PMT_GunFarm_Range or 2500
getgenv().PMT_GunFarm_Delay = getgenv().PMT_GunFarm_Delay or 0.01

P = game:GetService("Players")
R = game:GetService("ReplicatedStorage")
L = P.LocalPlayer
S = R:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/ShootGunEvent")

local function Ch() return L.Character or L.CharacterAdded:Wait() end
local function Rt() local c = Ch() return c and c:FindFirstChild("HumanoidRootPart") end
local function Alive(m)
    if not (m and m.Parent) then return false end
    local h = m:FindFirstChildOfClass("Humanoid")
    local r = m:FindFirstChild("HumanoidRootPart")
    return h and r and h.Health > 0
end

local function Hdl(e)
    if not e then return end
    for _, d in ipairs(e:GetDescendants()) do
        if d:IsA("Accessory") then
            local h = d:FindFirstChild("Handle")
            if h and h:IsA("BasePart") then return h end
        end
    end
    for _, d in ipairs(e:GetDescendants()) do
        if d:IsA("BasePart") and d.Name == "Handle" then return d end
    end
end

local function Near(rg)
    local r = Rt() if not r then return end
    local f = workspace:FindFirstChild("Enemies") if not f then return end
    local rp = r.Position
    local best, bestd = nil, (rg or math.huge)^2
    for _, m in ipairs(f:GetChildren()) do
        if Alive(m) then
            -- Thêm kiểm tra điều kiện máu cho Dragon Storm
            local maxH = m.Humanoid.MaxHealth
            local currentH = m.Humanoid.Health
            local healthThreshold = maxH * (_G.DragonStormHealth / 100)
            
            
            if currentH <= healthThreshold then
                local p = m.HumanoidRootPart.Position
                local dx, dy, dz = p.X - rp.X, p.Y - rp.Y, p.Z - rp.Z
                local d2 = dx*dx + dy*dy + dz*dz
                if d2 < bestd then bestd, best = d2, m end
            end
        end
    end
    return best
end

local function Fire(m)
    if not (m and m.Parent) then return end
    local hrp = m:FindFirstChild("HumanoidRootPart") if not hrp then return end
    local h = Hdl(m) if not h then return end
    local p = hrp.Position
    local v = (vector and vector.create) and vector.create(p.X, p.Y, p.Z) or Vector3.new(p.X, p.Y, p.Z)
    S:FireServer(v, {h})
end


task.spawn(function()
    while task.wait(getgenv().PMT_GunFarm_Delay) do
        if _G.FarmMastery_DS then
            pcall(function()
                local m = Near(getgenv().PMT_GunFarm_Range)
                if m then 
                    Fire(m) 
                end
            end)
        end
    end
end)

MasterySword = Tabs.Main:AddToggle("MasterySword", {
Title = "Tự Động Mastery All Kiếm", 
Flag = "MasterySword",
Description = "", 
Default = false,
Callback = function(Value)
  _G.FarmMastery_S = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.FarmMastery_S then
        if SelectIsland == "Cake" then
          for _, v in next, replicated.Remotes.CommF_:InvokeServer("getInventory") do          
            if type(v) == "table" then
              if v.Type == "Sword" then
                SwordName = v.Name
                if tonumber(v.Mastery) >= 1 or tonumber(v.Mastery) <= 599 then
                  local v = GetConnectionEnemies(mastery1)
                  if GetBP(SwordName) then                    
		            if v then
                      repeat wait() Attack.Sword(v,_G.FarmMastery_S) until _G.FarmMastery_S == false or not v.Parent or v.Humanoid.Health <= 0		                  
		            else
		              _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) 
		            end                    
                  else
                    replicated.Remotes.CommF_:InvokeServer("LoadItem",SwordName)   
                  end   
              elseif tonumber(v.Mastery) >= 600 then
                if GetBP(SwordName) then return nil else replicated.Remotes.CommF_:InvokeServer("LoadItem",SwordName) end       
              end
                break
              end
            end         
          end
        elseif SelectIsland == "Bone" then
          for _, v in next, replicated.Remotes.CommF_:InvokeServer("getInventory") do          
            if type(v) == "table" then
              if v.Type == "Sword" then
                SwordName = v.Name
                if tonumber(v.Mastery) >= 1 or tonumber(v.Mastery) <= 599 then
                  local v = GetConnectionEnemies(mastery2)
                  if GetBP(SwordName) then                    
		            if v then
                      repeat wait() Attack.Sword(v,_G.FarmMastery_S) until _G.FarmMastery_S == false or not v.Parent or v.Humanoid.Health <= 0		                  
		            else
		              _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 
		            end                    
                  else
                    replicated.Remotes.CommF_:InvokeServer("LoadItem",SwordName)   
                  end   
                elseif tonumber(v.Mastery) >= 600 then
                  if GetBP(SwordName) then return nil else replicated.Remotes.CommF_:InvokeServer("LoadItem",SwordName) end       
                end
                break
              end
            end         
          end
        end
      end
    end)
  end
end)






Tabs.Settings:AddSection("Settings / Configure")

Tabs.Settings:AddButton({
    Title = "Xoá Hiệu Ứng [ Siêu Mượt Mobile ]",
    Description = "Tắt bóng đổ, ánh sáng và các hiệu ứng hạt",
    Callback = function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        pcall(function() Lighting.ShadowMapLightingInfo = false end)
        
        task.spawn(function()
            local descendants = Workspace:GetDescendants()
            for i, v in ipairs(descendants) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.CastShadow = false
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                    v.Enabled = false
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v:Destroy()
                end
                if i % 500 == 0 then task.wait() end 
            end
        end)
    end
})


Tabs.Settings:AddButton({
    Title = "Xoá Map [ Tăng Tốc FPS Tối Đa ]",
    Description = "Làm trong suốt bản đồ, giữ lại va chạm để tránh lỗi rớt map",
    Callback = function()
        task.spawn(function()
            local MapFolder = Workspace:FindFirstChild("Map") or Workspace:FindFirstChild("SeaOutputs")
            local itemsToClear = MapFolder and MapFolder:GetDescendants() or Workspace:GetDescendants()
            
            for i, v in ipairs(itemsToClear) do
                if v.Parent and v.Parent.Name ~= "Enemies" and v.Parent.Name ~= "Players" and v.Parent.Name ~= plr.Name then
                    if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                        v.Transparency = 1
                        v.CastShadow = false
                        v.Material = Enum.Material.SmoothPlastic
                    elseif v:IsA("Decal") or v:IsA("Texture") then
                        v:Destroy()
                    end
                end
                if i % 500 == 0 then task.wait() end
            end
            
            pcall(function() 
                Workspace.Terrain.WaterTransparency = 1 
                Workspace.Terrain.WaterWaveSize = 0
                Workspace.Terrain.WaterWaveSpeed = 0
                -- ✅ Sửa typo: EnviromentalPhysicsThrottle → EnvironmentalPhysicsThrottle
                settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnvironmentalPhysicsThrottle.DefaultAuto
            end)
        end)
    end
})




-- ========== TOGGLE ==========
Tabs.Settings:AddToggle("Auto_AddToggle_1", {
    Title = "M1 Fruits (Đánh Siêu Nhanh)",
    Default = true,
    Flag = "hieudz",
    Callback = function(v)
        _G.Nhi1 = v
    end
})

-- ========== MAIN SCRIPT ==========
task.spawn(function()
    local plr = game:GetService("Players").LocalPlayer
    local enemies = workspace:WaitForChild("Enemies")
    
    -- Delay giữa các lần quét (giảm để tăng tốc)
    local scanDelay = 0.01  -- 1/100 giây
    
    while task.wait(scanDelay) do
        if not _G.Nhi1 then continue end
        
        -- Đợi nhân vật xuất hiện
        local char = plr.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            continue
        end
        local root = char.HumanoidRootPart
        
        -- Tìm Remote LeftClickRemote trong Tool đang cầm hoặc Backpack
        local remote = nil
        
        -- Kiểm tra tool trong tay
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("Tool") then
                remote = v:FindFirstChild("LeftClickRemote", true)
                if remote then break end
            end
        end
        
        -- Nếu chưa có, tìm trong Backpack
        if not remote then
            local backpack = plr:WaitForChild("Backpack")
            for _, v in pairs(backpack:GetChildren()) do
                if v:IsA("Tool") then
                    remote = v:FindFirstChild("LeftClickRemote", true)
                    if remote then break end
                end
            end
        end
        
        if not remote then continue end
        
        -- Tìm enemy gần nhất
        local closestDist = math.huge
        local closestTarget = nil
        
        for _, enemy in pairs(enemies:GetChildren()) do
            local hum = enemy:FindFirstChildOfClass("Humanoid")
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local dist = (hrp.Position - root.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestTarget = hrp
                end
            end
        end
        
        if closestTarget then
            -- Tính hướng từ người chơi đến enemy
            local direction = (closestTarget.Position - root.Position)
            if direction.Magnitude == 0 then
                direction = Vector3.zero
            else
                direction = direction.Unit
            end
            
            -- Gửi 3 đòn liên tiếp trong cùng một lần quét (tăng tốc cực mạnh)
            -- Tham số cuối FALSE để tắt knockback (không bị văng)
            for i = 1, 3 do
                remote:FireServer(direction, 1, false)
                task.wait(0)  -- nhường nhịn xử lý, tránh quá tải
            end
        end
    end
end)
Initialize = Tabs.Settings:AddToggle("Initialize", {
Title = "Đánh Nhanh", 
Flag = "Initialize",
Description = "", 
Default = true,
Callback = function(Value)
  _G.Seriality = Value
end})
Bringmob = Tabs.Settings:AddToggle("Bringmob", {
    Title = "Kéo Quái", 
    Flag = "Bringmob",
    Description = "", 
    Default = true,
    Callback = function(Value)
        _B = Value
        _G.BringMob = Value
    end
})

Tabs.Settings:AddSlider("Auto_AddSlider_1", {
    Title = "Số Lượng Quái Kéo",
    Flag = "MobAmount",
    Description = "Kéo Max Lên Nhé",
    Min = 8,
    Max = 16,
    Default = _G.MobM,
    Increment = 1,
    Callback = function(Value)
        _G.MobM = Value
    end
})

Tabs.Settings:AddSlider("Auto_AddSlider_2", {
    Title = "Range Kéo Quái",
    Flag = "BringRange",
    Description = "",
    Min = 300,
    Max = 350,
    Default = _G.BringRange,
    Increment = 10,
    Callback = function(Value)
        _G.BringRange = Value
    end
})


-- 🌀 Toggle Auto Server Hop mỗi 30 phút
HopToggle = Tabs.Settings:AddToggle("HopToggle", {
    Title = "Tự Động Chuyển Server Mỗi 30 Phút",
    Flag = "HopToggle",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.AutoHopServer = Value
end})

-- 🕒 Bộ đếm và xử lý hop
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if _G.AutoHopServer then
                if not _G.HopTimer then
                    _G.HopTimer = tick()
                end
                local elapsed = tick() - _G.HopTimer
                if elapsed >= 1800 then -- 1800s = 30 phút
                    _G.HopTimer = tick()
                    if syn and syn.queue_on_teleport then
                        syn.queue_on_teleport("loadstring(game:HttpGet('https://pastefy.app/iiFOhcot/raw'))()")
                    end
                    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
                end
            else
                _G.HopTimer = nil
            end
        end)
    end
end)
BusuAura = Tabs.Settings:AddToggle("BusuAura", {
Title = "Tự Động Bật Haki", 
Flag = "BusuAura",
Description = "", 
Default = true,
Callback = function(Value)
  Boud = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if Boud then
      local _HasBuso = {"HasBuso","Buso"}
  	  if not plr.Character:FindFirstChild(_HasBuso[1]) then replicated.Remotes.CommF_:InvokeServer(_HasBuso[2]) end
      end
    end)
  end
end)
RaceV3Aura = Tabs.Settings:AddToggle("RaceV3Aura", {
Title = "Tự Động Bật Tộc V3", 
Flag = "RaceV3Aura",
Description = "", 
Default = false,
Callback = function(Value)
  _G.RaceClickAutov3 = Value
end})
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()
      if _G.RaceClickAutov3 then
        repeat
          replicated.Remotes.CommE:FireServer("ActivateAbility") 
          wait(30)
        until not _G.RaceClickAutov3   
      end 
    end)
  end
end)
RaceV4Aura = Tabs.Settings:AddToggle("RaceV4Aura", {
Title = "Tự Động Bật Tộc V4", 
Flag = "RaceV4Aura",
Description = "", 
Default = false,
Callback = function(Value)
  _G.RaceClickAutov4 = Value
end})
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()
      if _G.RaceClickAutov4 then
  	    if plr.Character:FindFirstChild("RaceEnergy") then
        if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then Useskills("nil","Y") end
        end        
      end 
    end)
  end
end)
RandomAround = Tabs.Settings:AddToggle("RandomAround", {
Title = "Tự Động Bật Xoay Position", 
Flag = "RandomAround",
Description = "", 
Default = false,
Callback = function(Value)
  RandomCFrame = Value
end})
Byp = Tabs.Settings:AddToggle("Byp", {
Title = "Bật Bypass Dịch Chuyển", 
Flag = "Byp",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Bypass = Value
end})
SafeModes = Tabs.Settings:AddToggle("SafeModes", {
Title = "Panic Mode", 
Flag = "SafeModes",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Safemode = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
	  if _G.Safemode then
  	  local Calc_Health = plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth * 100
  	  if Calc_Health < Num_self then shouldTween=true _tp(Root.CFrame * CFrame.new(0,500,0)) else shouldTween=false end
      end
    end)
  end
end)

DisableHitVFX = Tabs.Settings:AddToggle("DisableHitVFX", {
    Title = "Xoá Hiệu Ứng Đánh",
    Flag = "DisableHitVFX",
    Description = "Removes slash and sword visual effects for better visibility",
    Default = false,
    Callback = function(Value)
        _G.DestroyHit = Value
    end
})

-- 🌀 Danh sách hiệu ứng cần xóa
HitEffects = {"SlashHit", "CurvedRing", "SwordSlash", "SlashTail"}

-- 🧹 Vòng lặp Redz style
task.spawn(function()
    while task.wait(Sec) do
        if _G.DestroyHit then
            pcall(function()
                for _, v in pairs(workspace["_WorldOrigin"]:GetChildren()) do
                    if table.find(HitEffects, v.Name) then
                        v:Destroy()
                    end
                end
            end)
        end
    end
end)
RmvVFX = Tabs.Settings:AddToggle("RmvVFX", {
Title = "Xoá Hiệu Ứng Chết Và Đánh", 
Flag = "RmvVFX",
Description = "", 
Default = false,
Callback = function(Value)
  RDeath = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if RDeath then
	  if replicated.Effect.Container:FindFirstChild("Death") then replicated.Effect.Container.Death:Destroy() end
      if replicated.Effect.Container:FindFirstChild("Respawn") then replicated.Effect.Container.Respawn:Destroy() end
	  end
    end)
  end
end)	
DisblesNotify = Tabs.Settings:AddToggle("DisblesNotify", {
Title = "Tắt Thông Báo", 
Flag = "DisblesNotify",
Description = "", 
Default = false,
Callback = function(Value)
  RemoveDamage = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if RemoveDamage then
        replicated.Assets.GUI.DamageCounter.Enabled = false
        plr.PlayerGui.Notifications.Enabled = false
	  else
        replicated.Assets.GUI.DamageCounter.Enabled = true
        plr.PlayerGui.Notifications.Enabled = true
      end
    end)
  end
end)      
Players = game:GetService("Players")
VirtualUser = game:GetService("VirtualUser")

plr = Players.LocalPlayer
AntiKick = true
AntiKickDelay = 18 * 60 -- 18 phút (an toàn hơn 20)


AntiAFK = Tabs.Settings:AddToggle("AntiAFK", {
    Title = "Chống Kick",
    Flag = "AntiAFK",
    Description = "",
    Default = true,
    Callback = function(Value)
        AntiKick = Value
    end
})
plr.Idled:Connect(function()
    if AntiKick then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)
task.spawn(function()
    while task.wait(AntiKickDelay) do
        pcall(function()
            if AntiKick then
                VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end
        end)
    end
end)
HttpService = game:GetService("HttpService")
CoreGui = game:GetService("CoreGui")

_G.AutoTranslate = false
_G.TargetLang = "vi" 
TranslatedCache = {} 

LanguageList = {
    -- Tiếng Việt
    ["Tiếng Việt"] = "vi",
    ["Tieng Viet"] = "vi-nodau",
    ["English (US)"] = "en-US",
    -- Đông Nam Á
    ["ภาษาไทย"] = "th",              -- Thái Lan
    ["Indonesia"] = "id",            -- Indonesia
    ["Filipino"] = "tl",             -- Philippines
    ["Melayu"] = "ms",               -- Malaysia
    ["မြန်မာဘာသာ"] = "my",            -- Myanmar
    ["ខ្មែរ"] = "km",                  -- Campuchia
    ["ລາວ"] = "lo",                    -- Lào

    -- Đông Á
    ["日本語"] = "ja",                -- Nhật Bản
    ["简体中文"] = "zh-CN",            -- Trung Quốc (Giản)
    ["繁體中文"] = "zh-TW",            -- Đài Loan (Phồn)
    ["한국어"] = "ko",                -- Hàn Quốc

    -- Châu Âu (Tây & Bắc Âu)
    ["Português (Brasil)"] = "pt",     -- Brazil (Rất quan trọng)
    ["Español"] = "es",                -- Tây Ban Nha
    ["Français"] = "fr",               -- Pháp
    ["Deutsch"] = "de",                -- Đức
    ["Italiano"] = "it",               -- Ý
    ["Nederlands"] = "nl",             -- Hà Lan
    ["Svenska"] = "sv",                -- Thụy Điển
    ["Norsk"] = "no",                  -- Na Uy
    ["Dansk"] = "da",                  -- Đan Mạch
    ["Suomi"] = "fi",                  -- Phần Lan

    -- Đông Âu & Trung Á
    ["Русский"] = "ru",                -- Nga
    ["Українська"] = "uk",             -- Ukraine
    ["Polski"] = "pl",                 -- Ba Lan
    ["Türkçe"] = "tr",                 -- Thổ Nhĩ Kỳ
    ["Română"] = "ro",                 -- Romania
    ["Magyar"] = "hu",                 -- Hungary
    ["Čeština"] = "cs",                -- Séc
    ["Ελληνικά"] = "el",               -- Hy Lạp

    -- Trung Đông & Nam Á
‎    ["العربية"] = "ar",                 -- Ả Rập
    ["हिन्दी"] = "hi",                   -- Ấn Độ (Hindi)
    ["বাংলা"] = "bn",                   -- Bangladesh
‎    ["اردو"] = "ur",                    -- Pakistan
‎    ["עברית"] = "he",                  -- Do Thái
}

LanguageOptions = {}
for Name, _ in pairs(LanguageList) do table.insert(LanguageOptions, Name) end
table.sort(LanguageOptions)

local function GoogleTranslate(text)
    if text == "" or tonumber(text) or #text < 2 then return text end
    local cacheKey = _G.TargetLang .. ":" .. text
    if TranslatedCache[cacheKey] then return TranslatedCache[cacheKey] end
    
    local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=".._G.TargetLang.."&dt=t&q=" .. HttpService:UrlEncode(text)
    local success, response = pcall(function() return game:HttpGet(url) end)
    
    if success then
        local decoded = HttpService:JSONDecode(response)
        if decoded and decoded[1] and decoded[1][1] then
            local result = decoded[1][1][1]
            TranslatedCache[cacheKey] = result
            return result
        end
    end
    return text
end

local function UpdateUI(obj)
    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
        if not obj:GetAttribute("RawText") then
            obj:SetAttribute("RawText", obj.Text)
        end
        local raw = obj:GetAttribute("RawText")
        
        if _G.AutoTranslate then
            task.spawn(function()
                local translated = GoogleTranslate(raw)
                if obj.Text ~= translated then obj.Text = translated end
            end)
        else
            if obj.Text ~= raw then obj.Text = raw end
        end
    end
end


Tabs.Misc:AddDropdown("Auto_AddDropdown_1", {
    Title = "Select Language",
    Values = LanguageOptions,
    Default = "English",
    Callback = function(Value)
        _G.TargetLang = LanguageList[Value]
        if _G.AutoTranslate then
            for _, v in ipairs(CoreGui:GetDescendants()) do UpdateUI(v) end
        end
    end
})

Tabs.Misc:AddToggle("Auto_AddToggle_2", {
    Title = "Auto Translation",
    Default = false,
    Callback = function(Value)
        _G.AutoTranslate = Value
        for _, v in ipairs(CoreGui:GetDescendants()) do UpdateUI(v) end
        if not _G.TranslationWatcher then
            _G.TranslationWatcher = CoreGui.DescendantAdded:Connect(function(obj)
                task.wait(0.3)
                UpdateUI(obj)
            end)
        end
    end
})





-- ==============================
-- ESP CORE
-- ==============================
Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
CollectionService = game:GetService("CollectionService")

ESPPlayer = false
_G.ChestESP = false
DevilFruitESP = false
IslandESP = false

Number = math.random(1, 1000000)

local function round(v)
    return math.floor(tonumber(v) + 0.5)
end

-- ==============================
-- ESP ISLAND
-- ==============================
function UpdateIslandESP()
    for _, island in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
        pcall(function()
            if IslandESP and island.Name ~= "Sea" then
                if not island:FindFirstChild("NameEsp") then
                    local gui = Instance.new("BillboardGui", island)
                    gui.Name = "NameEsp"
                    gui.Size = UDim2.new(1,200,1,30)
                    gui.ExtentsOffset = Vector3.new(0,1,0)
                    gui.Adornee = island
                    gui.AlwaysOnTop = true

                    local txt = Instance.new("TextLabel", gui)
                    txt.Size = UDim2.new(1,0,1,0)
                    txt.BackgroundTransparency = 1
                    txt.TextStrokeTransparency = 0.5
                    txt.Font = Enum.Font.GothamSemibold
                    txt.TextWrapped = true
                    txt.TextColor3 = Color3.new(1,1,1)
                else
                    island.NameEsp.TextLabel.Text =
                        island.Name .. "\n" ..
                        round((LocalPlayer.Character.Head.Position - island.Position).Magnitude / 3) .. "m"
                end
            elseif island:FindFirstChild("NameEsp") then
                island.NameEsp:Destroy()
            end
        end)
    end
end

-- ==============================
-- ESP PLAYER
-- ==============================
function UpdatePlayerChams()
    for _, plr in pairs(Players:GetPlayers()) do
        pcall(function()
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                local head = plr.Character.Head
                local guiName = "NameEsp" .. Number

                if not ESPPlayer then
                    if head:FindFirstChild(guiName) then
                        head[guiName]:Destroy()
                    end
                else
                    if not head:FindFirstChild(guiName) then
                        local gui = Instance.new("BillboardGui", head)
                        gui.Name = guiName
                        gui.Size = UDim2.new(1,200,1,30)
                        gui.ExtentsOffset = Vector3.new(0,1,0)
                        gui.Adornee = head
                        gui.AlwaysOnTop = true

                        local txt = Instance.new("TextLabel", gui)
                        txt.Size = UDim2.new(1,0,1,0)
                        txt.BackgroundTransparency = 1
                        txt.TextStrokeTransparency = 0.5
                        txt.Font = Enum.Font.GothamSemibold
                        txt.TextWrapped = true
                        txt.TextColor3 =
                            (plr.Team == LocalPlayer.Team)
                            and Color3.fromRGB(0,255,0)
                            or Color3.fromRGB(255,0,0)
                    else
                        head[guiName].TextLabel.Text =
                            plr.Name .. " | " ..
                            round((LocalPlayer.Character.Head.Position - head.Position).Magnitude / 3) ..
                            "m\nHP: " ..
                            round(plr.Character.Humanoid.Health * 100 / plr.Character.Humanoid.MaxHealth) .. "%"
                    end
                end
            end
        end)
    end
end

-- ==============================
-- ESP CHEST
-- ==============================
function UpdateChestESP()
    for _, chest in pairs(CollectionService:GetTagged("_ChestTagged")) do
        pcall(function()
            if _G.ChestESP and not chest:GetAttribute("IsDisabled") then
                if not chest:FindFirstChild("ChestEsp") then
                    local gui = Instance.new("BillboardGui", chest)
                    gui.Name = "ChestEsp"
                    gui.Size = UDim2.new(1,200,1,30)
                    gui.ExtentsOffset = Vector3.new(0,1,0)
                    gui.Adornee = chest
                    gui.AlwaysOnTop = true

                    local txt = Instance.new("TextLabel", gui)
                    txt.Size = UDim2.new(1,0,1,0)
                    txt.BackgroundTransparency = 1
                    txt.TextStrokeTransparency = 0.5
                    txt.Font = Enum.Font.Code
                    txt.TextWrapped = true
                    txt.TextColor3 = Color3.fromRGB(255,215,0)
                else
                    chest.ChestEsp.TextLabel.Text =
                        "Chest\n" ..
                        round((LocalPlayer.Character.Head.Position - chest:GetPivot().Position).Magnitude / 3) .. "m"
                end
            elseif chest:FindFirstChild("ChestEsp") then
                chest.ChestEsp:Destroy()
            end
        end)
    end
end

-- ==============================
-- ESP DEVIL FRUIT
-- ==============================
function UpdateDevilChams()
    for _, fruit in pairs(workspace:GetChildren()) do
        pcall(function()
            if DevilFruitESP and string.find(fruit.Name, "Fruit") and fruit:FindFirstChild("Handle") then
                local handle = fruit.Handle
                local guiName = "NameEsp" .. Number

                if not handle:FindFirstChild(guiName) then
                    local gui = Instance.new("BillboardGui", handle)
                    gui.Name = guiName
                    gui.Size = UDim2.new(1,200,1,30)
                    gui.ExtentsOffset = Vector3.new(0,1,0)
                    gui.Adornee = handle
                    gui.AlwaysOnTop = true

                    local txt = Instance.new("TextLabel", gui)
                    txt.Size = UDim2.new(1,0,1,0)
                    txt.BackgroundTransparency = 1
                    txt.TextStrokeTransparency = 0.5
                    txt.Font = Enum.Font.GothamSemibold
                    txt.TextWrapped = true
                    txt.TextColor3 = Color3.new(1,1,1)
                else
                    handle[guiName].TextLabel.Text =
                        fruit.Name .. "\n" ..
                        round((LocalPlayer.Character.Head.Position - handle.Position).Magnitude / 3) .. "m"
                end
            elseif fruit:FindFirstChild("Handle")
                and fruit.Handle:FindFirstChild("NameEsp" .. Number) then
                fruit.Handle["NameEsp" .. Number]:Destroy()
            end
        end)
    end
end

-- ==============================
-- ESP LOOP (DUY NHẤT)
-- ==============================
task.spawn(function()
    while task.wait(0.5) do
        if ESPPlayer then UpdatePlayerChams() end
        if _G.ChestESP then UpdateChestESP() end
        if DevilFruitESP then UpdateDevilChams() end
        if IslandESP then UpdateIslandESP() end
    end
end)

-- ==============================
-- ESP TOGGLE UI
-- ==============================
Tabs.PlayerPVP:AddSection("ESP | Định vị")

Tabs.PlayerPVP:AddToggle("Auto_AddToggle_3", {
    Title = "Định Vị Người Chơi",
    Default = false,
    Callback = function(v)
        ESPPlayer = v
        if not v then UpdatePlayerChams() end
    end
})

Tabs.PlayerPVP:AddToggle("Auto_AddToggle_4", {
    Title = "Định Vị Rương",
    Default = false,
    Callback = function(v)
        _G.ChestESP = v
        if not v then UpdateChestESP() end
    end
})

Tabs.PlayerPVP:AddToggle("Auto_AddToggle_5", {
    Title = "ESP Trái Ác Quỷ",
    Default = false,
    Callback = function(v)
        DevilFruitESP = v
        if not v then UpdateDevilChams() end
    end
})

Tabs.PlayerPVP:AddToggle("Auto_AddToggle_6", {
    Title = "Định Vị Đảo",
    Default = false,
    Callback = function(v)
        IslandESP = v
        if not v then UpdateIslandESP() end
    end
})
Tabs.Settings:AddSection("Stats Upgrade")
StatusSelect = Tabs.Settings:AddSlider("StatusSelect", {
Title = "Stats Value",
Flag = "StatusSelect",
Description = "",
Default = 10,
Min = 0,
Max = 1000,
Rounding = 1, 
Callback = function(Value)
  pSats = Value
end})

StatsUpg = Tabs.Settings:AddToggle("StatsUpg", {
Title = "Tự Động Melee", 
Flag = "StatsUpg",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Melee = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
    if _G.Auto_Melee then statsSetings("Melee",pSats) end
    end)
  end
end)

StatsUpg = Tabs.Settings:AddToggle("StatsUpg", {
Title = "Tự Động Swords", 
Flag = "StatsUpg_2",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Sword = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
    if _G.Auto_Sword then statsSetings("Sword",pSats) end
    end)
  end
end)
StatsUpg = Tabs.Settings:AddToggle("StatsUpg", {
Title = "Tự Động Súng", 
Flag = "StatsUpg_3",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Gun = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
    if _G.Auto_Gun then statsSetings("Gun",pSats) end
    end)
  end
end)
StatsUpg = Tabs.Settings:AddToggle("StatsUpg", {
Title = "Tự Động Blox Trái Ác Quỷ", 
Flag = "StatsUpg_4",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_DevilFruit = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
    if _G.Auto_DevilFruit then statsSetings("Devil",pSats) end
    end)
  end
end)
StatsUpg = Tabs.Settings:AddToggle("StatsUpg", {
Title = "Tự Động Defense", 
Flag = "StatsUpg_5",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Defense = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
    if _G.Auto_Defense then statsSetings("Defense",pSats) end
    end)
  end
end)

Tabs.Fish:AddSection("Fishing")


BaitDropdown = Tabs.Fish:AddDropdown("BaitDropdown", {
    Title = "Chọn Bait",
    Flag = "BaitDropdown",
    Description = "",
    Values = {"Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait"},
    Multi = false,
    ,
    Callback = function(Value)
        _G.SelectedBait = Value
        if _G.AutoBuyBait then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})

BuyBaitToggle = Tabs.Fish:AddToggle("BuyBaitToggle", {
    Title = "Tự Động Mua Mồi Câu",
    Flag = "BuyBaitToggle",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoBuyBait = Value
        if Value then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})


task.spawn(function()
    while task.wait(2) do
        if _G.AutoBuyBait and _G.SelectedBait then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
end)




Fishing = Tabs.Fish:AddToggle("Fishing", {
Title = "Tự Động Fishing", 
Flag = "Fishing",
Description = "",
Default = false,
Callback = function(Value)
    _G.AutoFishing = Value
end})


Players2 = game:GetService("Players")
LocalPlayer2 = Players2.LocalPlayer
Workspace2 = game:GetService("Workspace")
FishReplicated2 = game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated")
FishingRequest2 = FishReplicated2:WaitForChild("FishingRequest")
Config2 = require(FishReplicated2.FishingClient.Config)
GetWaterHeight2 = require(game:GetService("ReplicatedStorage").Util.GetWaterHeightAtLocation)
maxdistance2 = Config2.Rod.MaxLaunchDistance


task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoFishing then
            pcall(function()
                local Char = LocalPlayer2.Character or LocalPlayer2.CharacterAdded:Wait()
                local hrm = Char:FindFirstChild("HumanoidRootPart")
                local Tool = Char:FindFirstChildOfClass("Tool")
                if not (hrm and Tool) then return end

                local waterHeight = GetWaterHeight2(hrm.Position)
                local _, hitPos = Workspace2:FindPartOnRayWithIgnoreList(
                    Ray.new(Char.Head.Position, hrm.CFrame.LookVector * maxdistance2),
                    {Char, Workspace2.Characters, Workspace2.Enemies}
                )
                local pos = Vector3.new(hitPos.X, math.max(hitPos.Y, waterHeight), hitPos.Z)
                local State = Tool:GetAttribute("State")
                local ServerState = Tool:GetAttribute("ServerState")

                if State == "ReeledIn" or ServerState == "ReeledIn" then
                    FishingRequest2:InvokeServer("StartCasting")
                    task.wait()
                    FishingRequest2:InvokeServer("CastLineAtLocation", pos, 100, true)
                elseif ServerState == "Biting" then
                    FishingRequest2:InvokeServer("Catching", true)
                    task.wait(0.1)
                    FishingRequest2:InvokeServer("Catch", 1)
                end
            end)
        end
    end
end)


FishingQ = Tabs.Fish:AddToggle("FishingQ", {
Title = "Tự Động Nhiệm Vụ Fishing", 
Flag = "FishingQ",
Description = "",
Default = false,
Callback = function(Value)
    _G.AutoFishingQuest = Value
end})


Players3 = game:GetService("Players")
LocalPlayer3 = Players3.LocalPlayer
ReplicatedStorage3 = game:GetService("ReplicatedStorage")
RFJobsRemoteFunction3 = ReplicatedStorage3.Modules.Net:WaitForChild("RF/JobsRemoteFunction")

local function HasQuest3()
    local questGui = LocalPlayer3.PlayerGui:FindFirstChild("Quest") or LocalPlayer3.PlayerGui:FindFirstChild("QuestGui")
    if questGui and questGui:FindFirstChild("Container") and questGui.Container:FindFirstChild("QuestTitle") then
        return true
    end
    return false
end

task.spawn(function()
    while task.wait(1) do
        if _G.AutoFishingQuest then
            pcall(function()
                if not HasQuest3() then
                    RFJobsRemoteFunction3:InvokeServer("FishingNPC", "Angler", "AskQuest")
                end
            end)
        end
    end
end)


QuestToggle = Tabs.Fish:AddToggle("QuestToggle", {
    Title = "Tự Động Complete Nhiệm Vụ",
    Flag = "QuestToggle",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoQuestComplete = Value

        if Value then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
            end)
        end
    end
})


task.spawn(function()
    while task.wait(5) do 
        if _G.AutoQuestComplete then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
            end)
        end
    end
end)


SellFishToggle = Tabs.Fish:AddToggle("SellFishToggle", {
    Title = "Tự Động Sell Fish",
    Flag = "SellFishToggle",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoSellFish = Value

        if Value then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
            end)
        end
    end
})


task.spawn(function()
    while task.wait(5) do 
        if _G.AutoSellFish then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
            end)
        end
    end
end)


SpamSkillZ = Tabs.Fish:AddToggle("SpamSkillZ", {
Title = "Tự Động Spam Skill Z", 
Flag = "SpamSkillZ",
Description = "",
Default = false,
Callback = function(Value)
    _G.AutoSkillZ = Value
end})


ReplicatedStorage4 = game:GetService("ReplicatedStorage")
RFJobToolAbilities4 = ReplicatedStorage4.Modules.Net:WaitForChild("RF/JobToolAbilities")

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoSkillZ then
            pcall(function()
                RFJobToolAbilities4:InvokeServer("Z", true)
            end)
        end
    end
end)

TravelDress = Tabs.Quests:AddToggle("TravelDress", {
Title = "Tự Động Nhiệm Vụ Biển 2", 
Flag = "TravelDress",
Description = "", 
Default = false,
Callback = function(Value)
  _G.TravelDres = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.lDres then
        if plr.Data.Level.Value >= 700 then
          if workspace.Map.Ice.Door.CanCollide == true and workspace.Map.Ice.Door.Transparency == 0 then
            replicated.Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
		    EquipWeapon("Key")
		    repeat wait() _tp(CFrame.new(1347.7124, 37.3751602, -1325.6488)) until not _G.TravelDres or (Root.Position == CFrame.new(1347.7124, 37.3751602, -1325.6488).Position)
	      elseif workspace.Map.Ice.Door.CanCollide == false and workspace.Map.Ice.Door.Transparency == 1 then
            if Enemies:FindFirstChild("Ice Admiral") then
              for _,xz in pairs(Enemies:GetChildren()) do
                if xz.Name == "Ice Admiral" and Attack.Alive(xz) then
              	  repeat task.wait() Attack.Kill(xz,_G.TravelDres) until _G.TravelDres == false or xz.Humanoid.Health <= 0
                  replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
                end
              end
            else
              _tp(CFrame.new(1347.7124, 37.3751602, -1325.6488))
            end
	      else
		    replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
	      end
        end
      end
    end)
  end
end)
Zou = Tabs.Quests:AddToggle("Zou", {
Title = "Tự Động Nhiệm Vụ Biển 3", 
Flag = "Zou",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoZou = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.AutoZou then
   	    if plr.Data.Level.Value >= 1500 then
          if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 then
            if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
              replicated.Remotes.CommF_:InvokeServer("F_","TravelZou")
              if replicated.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
                local v = GetConnectionEnemies("rip_indra")
                if v then
                  repeat wait() Attack.Kill(v,_G.AutoZou) until not _G.AutoZou or not v.Parent or v.Humanoid.Health <= 0
                  Check = 2
                  repeat wait()replicated.Remotes.CommF_:InvokeServer("F_","TravelZou")until Check == 1                   
                else
                  replicated.Remotes.CommF_:InvokeServer("F_","ZQuestProgress","Check") wait(.1)
                  replicated.Remotes.CommF_:InvokeServer("F_","ZQuestProgress","Begin")
                end
              elseif replicated.Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
                replicated.Remotes.CommF_:InvokeServer("F_","TravelZou")
              else
                local v = GetConnectionEnemies("Don Swan")
                if v then
                  repeat wait() Attack.Kill(v,_G.AutoZou)until not _G.AutoZou or not v.Parent or v.Humanoid.Health<=0                  
                else
                  repeat wait() _tp(CFrame.new(2288.802, 15.1870775, 863.034607)) until not _G.AutoZou or (Root.Position == CFrame.new(2288.802, 15.1870775, 863.034607).Position)
                  if (Root.CFrame == CFrame.new(2288.802, 15.1870775, 863.034607)) then notween(CFrame.new(2288.802, 15.1870775, 863.034607)) end
                end
              end
            else
            if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
              TabelDevilFruitStore = {}
              TabelDevilFruitOpen = {}
              for i,v in pairs(replicated.Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
                for i1,v1 in pairs(v) do
                  if i1 == "Name" then table.insert(TabelDevilFruitStore,v1)end
                end
              end
              for i,v in next, game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
                if v.Price >= 1000000 then table.insert(TabelDevilFruitOpen,v.Name) end
              end
              for i,DevilFruitOpenDoor in pairs(TabelDevilFruitOpen) do
                for i1,DevilFruitStore in pairs(TabelDevilFruitStore) do
                  if DevilFruitOpenDoor == DevilFruitStore and replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
                    if not plr.Backpack:FindFirstChild(DevilFruitStore) then
                      replicated.Remotes.CommF_:InvokeServer("F_","LoadFruit",DevilFruitStore)
                    else
                      replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","1")
                      replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","2")
                      replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","3")
                    end
                  end
                end
              end
                replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","1")
                replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","2")
                replicated.Remotes.CommF_:InvokeServer("F_","TalkTrevor","3")
              end
            end
          else
            if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
              if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and plr.PlayerGui.Main.Quest.Visible == true then                
                local v = GetConnectionEnemies("Swan Pirate")
                if v then
                  pcall(function() repeat wait() Attack.Kill(v,_G.AutoZou) until not v.Parent or v.Humanoid.Health <= 0 or _G.AutoZou == false or plr.PlayerGui.Main.Quest.Visible == false end)                    
                else
                  _tp(CFrame.new(1057.92761, 137.614319, 1242.08069))
                end
              else
                _tp(CFrame.new(-456.28952, 73.0200958, 299.895966))
              end
            elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
              local v = GetConnectionEnemies("Jeremy")
              if v then
                repeat wait() Attack.Kill(v,_G.AutoZou) until not v.Parent or v.Humanoid.Health <= 0 or _G.AutoZou == false
              else
                _tp(CFrame.new(2099.88159, 448.931, 648.997375))
              end
            elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
              repeat wait() _tp(CFrame.new(-1836, 11, 1714)) until not _G.AutoZou or (Root.Position == CFrame.new(-1836, 11, 1714).Position)
              if (Root.CFrame == CFrame.new(-1836, 11, 1714)) then notween(CFrame.new(-1836, 11, 1714))end
              notween(CFrame.new(-1850.49329, 13.1789551, 1750.89685))
              wait(.1)
              notween(CFrame.new(-1858.87305, 19.3777466, 1712.01807))
              wait(.1)
              notween(CFrame.new(-1803.94324, 16.5789185, 1750.89685))
              wait(.1)
              notween(CFrame.new(-1858.55835, 16.8604317, 1724.79541))
              wait(.1)
              notween(CFrame.new(-1869.54224, 15.987854, 1681.00659))
              wait(.1)
              notween(CFrame.new(-1800.0979, 16.4978027, 1684.52368))
              wait(.1)
              notween(CFrame.new(-1819.26343, 14.795166, 1717.90625))
              wait(.1)
              notween(CFrame.new(-1813.51843, 14.8604736, 1724.79541))
            end
          end
        end
      end
    end)
  end
end)

FactoryRaids = Tabs.Quests:AddToggle("FactoryRaids", {
Title = "Tự Động Đánh Nhà Máy", 
Flag = "FactoryRaids",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoFactory = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.AutoFactory then
        local v = GetConnectionEnemies("Core")
        if v then
          repeat wait()
            EquipWeapon(_G.SelectWeapon)
            _tp(CFrame.new(448.46756, 199.356781, -441.389252))
          until v.Humanoid.Health <= 0 or _G.AutoFactory == false
        else
          _tp(CFrame.new(448.46756, 199.356781, -441.389252))
        end
      end
    end)
  end
end)


_G.AutoRaidCastle = false
local Castle_Mob = {
    "Galley Pirate","Galley Captain","Raider","Mercenary","Vampire","Zombie",
    "Snow Trooper","Winter Warrior","Lab Subordinate","Horned Warrior",
    "Magma Ninja","Lava Pirate","Ship Deckhand","Ship Engineer","Ship Steward",
    "Ship Officer","Arctic Warrior","Snow Lurker","Sea Soldier","Water Fighter"
}

local CFrameCastleRaid = CFrame.new(-5496.17432, 313.768921, -2841.53027)
local CastleCenter = Vector3.new(-5539.3115234375, 313.800537109375, -2972.372314453125)
local _castleKilling = false 

task.spawn(function()
    while task.wait(0.4) do 
        if not _G.AutoRaidCastle then continue end
        if _castleKilling then continue end 

        local ok = pcall(function()
            local char = plr.Character
            if not char then return end
            local Root = char:FindFirstChild("HumanoidRootPart")
            local Hum = char:FindFirstChildOfClass("Humanoid")
            if not Root or not Hum or Hum.Health <= 0 then return end

            local distToCastle = (CastleCenter - Root.Position).Magnitude

            -- 1. KIỂM TRA VỊ TRÍ: Di chuyển đến lâu đài
            if distToCastle > 500 then
                _tp(CFrameCastleRaid)
                task.wait(1.5) 
                return
            end

            -- 2. DÒ TÌM MỤC TIÊU HỢP LỆ
            local targetMob = nil
            local enemiesFolder = workspace:FindFirstChild("Enemies")
            if not enemiesFolder then return end

            for _, v in ipairs(enemiesFolder:GetChildren()) do
                if table.find(Castle_Mob, v.Name) then
                    local hrp = v:FindFirstChild("HumanoidRootPart")
                    local hum = v:FindFirstChild("Humanoid")
                    if hrp and hum and hum.Health > 0 then
                        if (hrp.Position - CastleCenter).Magnitude <= 600 then
                            targetMob = v
                            break 
                        end
                    end
                end
            end

            -- 3. KHỞI CHẠY TIẾN TRÌNH DIỆT MOB BẤT ĐỒNG BỘ
            if targetMob then
                _castleKilling = true
                
                task.spawn(function()
                    local killStart = tick()
                    
                    local firstHRP = targetMob:FindFirstChild("HumanoidRootPart")
                    if firstHRP then _tp(firstHRP.CFrame * CFrame.new(0, 10, 0)) end

                    while _G.AutoRaidCastle 
                        and targetMob.Parent 
                        and targetMob:FindFirstChild("Humanoid") 
                        and targetMob.Humanoid.Health > 0 
                        and (tick() - killStart) < 8 
                    do
                        -- FIX SCOPE: Cập nhật Root liên tục chống lỗi khi hồi sinh
                        local myRoot = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                        local mobHRP = targetMob:FindFirstChild("HumanoidRootPart")
                        
                        if mobHRP and myRoot then
                            -- TỐI ƯU MOBILE: Chỉ TP bám đuổi khi quái văng quá tầm đấm (> 20 studs)
                            if (myRoot.Position - mobHRP.Position).Magnitude > 20 then
                                _tp(mobHRP.CFrame * CFrame.new(0, 10, 0))
                            end
                            
                            pcall(function()
                                Attack.Kill(targetMob, _G.AutoRaidCastle)
                            end)
                        end
                        task.wait(0.15)
                    end
                    
                    -- LUÔN LUÔN GIẢI PHÓNG LUỒNG
                    _castleKilling = false
                end)
            else
                -- 4. KHÔNG CÓ MOB: Quay về điểm chờ (Chỉ chạy khi đứng lệch tâm > 50 studs)
                if distToCastle > 50 then
                    _tp(CFrameCastleRaid)
                    task.wait(1)
                end
            end
        end)
    end
end)

CastleRaids = Tabs.Quests:AddToggle("CastleRaids", {
    Title = "Tự Động Đánh Hải Tặc", 
    Flag = "CastleRaids",
    Description = "", 
    Default = false,
    Callback = function(Value)
        _G.AutoRaidCastle = Value
        if not Value then
            -- SỬA CHUẨN EDGE CASE: Chờ luồng con tự kết thúc rồi mới xóa Flag
            task.wait(0.35)
            _castleKilling = false
        else
            _castleKilling = false
        end
    end
})


Tabs.Quests:AddSection("Fish Slap")
_G.MiNigame=_G.MiNigame or false

Tabs.Quests:AddToggle("Auto_AddToggle_7", {
	Title ="Auto Fish Slap",
	Default=false,
	Callback=function(v) _G.MiNigame=v end
})

Players=game:GetService("Players")
RS=game:GetService("RunService")
LP=Players.LocalPlayer

local function getFishUI()
	local pg=LP:FindFirstChildOfClass("PlayerGui"); if not pg then return end
	local g=pg:FindFirstChild("FishSlapMinigame"); if not g then return end
	local bar=g:FindFirstChild("Bar"); if not bar then return end
	return bar:FindFirstChild("GreenZone"), bar:FindFirstChild("Tick"), g:FindFirstChild("SlapButton")
end

local function getContinueBtn()
	local pg=LP:FindFirstChildOfClass("PlayerGui"); if not pg then return end
	local cs=pg:FindFirstChild("ContinueScreen"); if not cs then return end
	return cs:FindFirstChild("Continue")
end

local function rect(o)
	if not (o and o.AbsoluteSize) then return end
	local p,s=o.AbsolutePosition,o.AbsoluteSize
	return p.X,p.Y,p.X+s.X,p.Y+s.Y
end

local function overlap(a,b)
	local ax1,ay1,ax2,ay2=rect(a); local bx1,by1,bx2,by2=rect(b)
	if not (ax1 and bx1) then return false end
	return ax1<bx2 and ax2>bx1 and ay1<by2 and ay2>by1
end

local function fire(btn)
	if not btn then return false end
	local ok=false
	pcall(function()
		if firesignal then
			local ev=btn.Activated or btn.MouseButton1Click
			if ev then firesignal(ev); ok=true end
		end
	end)
	if not ok then pcall(function() btn:Activate(); ok=true end) end
	return ok
end

if _G.__FishSlapConn then pcall(function() _G.__FishSlapConn:Disconnect() end) end

last,lastC,prev=0,0,false
_G.__FishSlapConn=RS.RenderStepped:Connect(function()
	if not _G.MiNigame then prev=false return end

	local gz,tk,btn=getFishUI()
	if gz and tk and btn then
		local over=overlap(tk,gz)
		local now=tick()
		if over and not prev and now-last>=0.03 then
			if fire(btn) then last=now end
		end
		prev=over
	else
		prev=false
	end

	local c=getContinueBtn()
	if c and c.Visible and tick()-lastC>=0.25 then
		if fire(c) then lastC=tick() end
	end
end)
Tabs.Quests:AddSection("Farming Cake")
MobKilled = Tabs.Quests:AddParagraph({
    Title = "Hoàng Tử Bột:",
    Content = ""
})
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()
  	  local Killed = string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"),"%d+")
      if Killed then
        MobKilled:SetDesc(" Killed : " ..(500 - Killed))
      end
    end)
  end
end)


CakeSM = Tabs.Quests:AddToggle("CakeSM", {
    Title = "Tự Động Triệu Hồi Hoàng Tử Bột",
    Flag = "CakeSM",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.AutoSpawnCP = Value
end})

task.spawn(function()
    while task.wait(2) do
        if _G.AutoSpawnCP then
            pcall(function()
                local CommF = game.ReplicatedStorage.Remotes.CommF_
                local enemies = workspace.Enemies
                local bigMirror = workspace.Map.CakeLoaf:FindFirstChild("BigMirror")
                if not bigMirror then return end
                if enemies:FindFirstChild("Cake Prince") then return end
                if bigMirror.Other.Transparency == 0 then return end

                CommF:InvokeServer("CakePrinceSpawner", true)
            end)
        end
    end
end)

DoughKingFarm = Tabs.Quests:AddToggle("DoughKingFarm", {
    Title = "Tự Động Cày Bột Đế Vương",
    Flag = "DoughKingFarm",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.AutoDoughKing = Value
end})

task.spawn(function()
    while task.wait(Sec) do
        pcall(function()
            if not _G.AutoDoughKing then return end

            local player = game.Players.LocalPlayer
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            local map = workspace.Map.CakeLoaf
            local enemies = workspace.Enemies

            -- 1️⃣ Thiếu Cocoa => farm quái Chocolate/Cocoa
            if GetM("Conjured Cocoa") < 10 then
                local v = GetConnectionEnemies({"Cocoa Warrior", "Chocolate Bar Battler"})
                if v then
                    repeat task.wait()
                        Attack.Kill(v, _G.AutoDoughKing)
                    until not _G.AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0
                else
                    _tp(CFrame.new(402.7, 81.06, -12259.54))
                end
                return
            end

            -- 2️⃣ Thiếu God's Chalice => bật farm elite
            if not GetBP("God's Chalice") then
                _G.FarmEliteHunt = true
                return
            end

            -- 3️⃣ Đủ nguyên liệu => craft Sweet Chalice
            if GetM("Conjured Cocoa") >= 10 and GetBP("God's Chalice") and not GetBP("Sweet Chalice") then
                replicated.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
                return
            end

            -- 4️⃣ Đã có Sweet Chalice => vẫn farm Cake quái cho đến khi Mirror mở
            local CakeMobs = {"Cookie Crafter","Cake Guard","Baking Staff","Head Baker"}
            if not map:FindFirstChild("RedDoor") then
                local v = GetConnectionEnemies(CakeMobs)
                if v then
                    repeat task.wait()
                        Attack.Kill(v, _G.AutoDoughKing)
                    until not _G.AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0
                else
                    _tp(CFrame.new(-2077, 252, -12373))
                end
                return
            end

            -- 5️⃣ Nếu Mirror đã mở (tức summon được) => Equip chén và summon boss
            if GetBP("Sweet Chalice") or player.Character:FindFirstChild("Sweet Chalice") then
                EquipWeapon("Sweet Chalice")
                replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
                task.wait(1)
                _tp(CFrame.new(-2682, 64, -12854)) -- vị trí cửa vào Dough King
            end

            -- 6️⃣ Khi boss Dough King spawn => farm boss
            local boss = GetConnectionEnemies("Dough King")
            if boss then
                repeat task.wait()
                    Attack.Kill(boss, _G.AutoDoughKing)
                until not _G.AutoDoughKing or not boss.Parent or boss.Humanoid.Health <= 0
            end
        end)
    end
end)

HopDough = Tabs.Quests:AddToggle("HopDough", {
Title = "Tự Động Đổi Sever Bột Đế Vương", 
Flag = "HopDough",
Description = "", 
Default = false,
Callback = function(Value)
    _G.AutoHop_Dough = Value
end})

task.spawn(function()
    while task.wait(5) do
        if _G.AutoHop_Dough then
            pcall(function()
                local player = game.Players.LocalPlayer
                local enemies = workspace.Enemies
                local boss = enemies:FindFirstChild("Dough King")
                local mirror = workspace.Map.CakeLoaf:FindFirstChild("BigMirror")

                if boss then
                    _tp(CFrame.new(-1943.6765, 251.5095, -12337.8808))
                    task.wait(40)
                else
                    local HttpService = game:GetService("HttpService")
                    local req = syn and syn.request or http_request or request
                    if not req then return end
                    local response = req({Url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"})
                    local data = HttpService:JSONDecode(response.Body)
                    for _, v in pairs(data.data) do
                        if v.playing < v.maxPlayers then
                            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id, player)
                            break
                        end
                    end
                end
            end)
        end
    end
end)

Tabs.Quests:AddSection("Farming Bone")

CheckingBone = Tabs.Quests:AddParagraph({
    Title = " Xương :",
    Content = ""
})
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()
      CheckingBone:SetDesc(" Bones : " ..GetM("Bones"))          
    end)
  end
end)
Bone = Tabs.Quests:AddToggle("Bone", {
    Title = "Tự Động Farm Xương",
    Flag = "Bone",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm_Bone = Value
    end
})

local BonesTable = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}
local BoneSpawnPos = Vector3.new(-9495.68, 453.58, 5977.34)

task.spawn(function()
    while task.wait(Sec) do
        pcall(function()
            if not _G.AutoFarm_Bone then return end

            if getgenv().OnFarm == false and shouldTween == true then return end

            local char = plr.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then return end

            local bone, bestDist = nil, math.huge
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if table.find(BonesTable, mob.Name) then
                    local hum = mob:FindFirstChild("Humanoid")
                    local hrp = mob:FindFirstChild("HumanoidRootPart")
                    if hum and hrp and hum.Health > 0 then
                        local dist = (hrp.Position - root.Position).Magnitude
                        if dist < bestDist then
                            bestDist = dist
                            bone = mob
                        end
                    end
                end
            end

            if not bone then
                PosMon = BoneSpawnPos
                _tp(CFrame.new(BoneSpawnPos))
                return
            end

            local boneHum = bone:FindFirstChild("Humanoid")
            local boneHRP = bone:FindFirstChild("HumanoidRootPart")
            if not boneHum or not boneHRP or boneHum.Health <= 0 then return end

            PosMon = boneHRP.Position

            repeat
                task.wait()
                Attack.Kill(bone, _G.AutoFarm_Bone)
            until not _G.AutoFarm_Bone
                or not bone.Parent
                or boneHum.Health <= 0
        end)
    end
end)




Tabs.Quests:AddToggle("Auto_AddToggle_8", {
Title = "Tự Động Thần Chết", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoHytHallow = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.AutoHytHallow then
      pcall(function()
        local v = GetConnectionEnemies("Soul Reaper")
	    if v then
          repeat task.wait() Attack.Kill(v,_G.AutoHytHallow) until v.Humanoid.Health <= 0 or _G.AutoHytHallow == false
        else
          if not GetBP("Hallow Essence") then
            repeat task.wait(.1)replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)until _G.AutoHytHallow == false or GetBP("Hallow Essence")
          else
            repeat wait(.1) _tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))until _G.AutoHytHallow == false or (plr.Character.HumanoidRootPart.CFrame == CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
		    EquipWeapon("Hallow Essence")
          end
        end
      end)
    end
  end
end)
RanBone = Tabs.Quests:AddToggle("RanBone", {
Title = "Tự Động Quay Xương", 
Flag = "RanBone",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Random_Bone = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Auto_Random_Bone then    
  	    repeat task.wait() replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1) until not _G.Auto_Random_Bone
      end
    end)
  end
end)
Lucky = Tabs.Quests:AddToggle("Lucky", {
Title = "Tự Động Thử Vận May Bia Mộ", 
Flag = "Lucky",
Description = "", 
Default = false,
Callback = function(Value)
  _G.TryLucky = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.TryLucky then
    local try_bones_luck = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)
      if (plr.Character.HumanoidRootPart.CFrame ~= try_bones_luck) then
        _tp(CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813))
	 elseif (plr.Character.HumanoidRootPart.CFrame == try_bones_luck) then
	   replicated.Remotes.CommF_:InvokeServer("gravestoneEvent",1)
      end
    end
  end
end)
Pray = Tabs.Quests:AddToggle("Pray", {
Title = "Tự Động Cầu Nguyện Bia Mộ", 
Flag = "Pray",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Praying = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.Praying then
    local try_bones_luck = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)
      if (plr.Character.HumanoidRootPart.CFrame ~= try_bones_luck) then
	   _tp(CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813))
      elseif (plr.Character.HumanoidRootPart.CFrame == try_bones_luck) then
	   replicated.Remotes.CommF_:InvokeServer("gravestoneEvent",2)
      end
    end
  end
end)
Tabs.Quests:AddSection("Tushita + Yama")


Q = Tabs.Quests:AddToggle("Q", {
    Title = "Auto Tushita Sword",
    Flag = "Q",
    Default = false,
    Callback = function(Value)
        _G.Auto_Tushita = Value
    end
})

local function GetIndra()
    return workspace:FindFirstChild("rip_indra", true)
end

local function HasTorch()
    return GetBP("Holy Torch")
        or (plr.Character and plr.Character:FindFirstChild("Holy Torch"))
end

local function GetGate()
    return workspace:FindFirstChild("TushitaGate", true)
end

local function TP(cf)
    local start = tick()
    repeat
        task.wait(0.1)
        _tp(cf)
    until (cf.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
        or tick() - start > 5
end

local HYDRA_GATE_CF = CFrame.new(5821, 1019, -73)

TorchPoints = {
    CFrame.new(-10752, 417, -9366),
    CFrame.new(-11672, 334, -9474),
    CFrame.new(-12132, 521, -10655),
    CFrame.new(-13336, 486, -6985),
    CFrame.new(-13489, 332, -7925),
}

task.spawn(function()
    while task.wait(0.5) do
        if not _G.Auto_Tushita then continue end
        pcall(function()
            local indra = GetIndra()
            if not indra or not Attack.Alive(indra) then
                return
            end

            if not HasTorch() and not GetGate() then
                TP(HYDRA_GATE_CF)
                task.wait(1)
                return
            end

            if not GetGate() and HasTorch() then
                EquipWeapon("Holy Torch")
                task.wait(0.5)
                for _, cf in ipairs(TorchPoints) do
                    if not _G.Auto_Tushita then return end
                    TP(cf)
                    task.wait(0.8)
                end
                return
            end

            if GetGate() then
                local longma = GetConnectionEnemies("Longma")
                if longma and Attack.Alive(longma) then
                    Attack.Kill(longma, true)
                else
                    local lm = workspace:FindFirstChild("Longma", true)
                    if lm and lm:FindFirstChild("HumanoidRootPart") then
                        TP(lm.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
                    else
                        TP(CFrame.new(-10941, 332, -8760))
                    end
                end
            end
        end)
    end
end)

Q = Tabs.Quests:AddToggle("Q", {
    Title = "Tự Động Lấy Kiếm Yama",
    Flag = "Q_2",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Auto_Yama = Value
    end
})

task.spawn(function()
    while task.wait(Sec) do
        pcall(function()
            if _G.Auto_Yama then
                if replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") < 30 then
                    _G.FarmEliteHunt = true
                elseif replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") > 30 then
                    _G.FarmEliteHunt = false
                    if (workspace.Map.Waterfall.SealedKatana.Handle.Position - plr.Character.HumanoidRootPart.Position).Magnitude >= 20 then
                        _tp(workspace.Map.Waterfall.SealedKatana.Handle.CFrame)
                        local zx = GetConnectionEnemies("Ghost")
                        if zx then
                            repeat
                                wait()
                                Attack.Kill(zx, _G.Auto_Yama)
                            until zx.Humanoid.Health <= 0 or not zx.Parent or not _G.Auto_Yama
                            fireclickdetector(workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
                        end
                    end
                end
            end
        end)
    end
end)

Tabs.Quests:AddSection("Cursed Dual Katana")
CheckCDK = Tabs.Quests:AddParagraph({
Title = " Number Cursed dual katana quests ",
Content = "Quest Numbers :"})
task.spawn(function()  
  while task.wait(0.2) do 
    if QuestYama_1 == true then 
	 CheckCDK:SetDesc(" Quest Numbers : yama quest 1") 
    elseif QuestYama_2 == true then
	  CheckCDK:SetDesc(" Quest Numbers : yama quest 2") 
    elseif QuestYama_3 == true then
	  CheckCDK:SetDesc(" Quest Numbers : yama quest 3") 
    elseif QuestTushita_1 == true then
	  CheckCDK:SetDesc(" Quest Numbers : tushita quest 1") 
    elseif QuestTushita_2 == true then
	  CheckCDK:SetDesc(" Quest Numbers : tushita quest 2") 
    elseif QuestTushita_1 == true then
	  CheckCDK:SetDesc(" Quest Numbers: tushita quest 2") 
	elseif GetWP("Cursed Dual Katana") then
	  CheckCDK:SetDesc(" Quest Numbers: CDK done!!")
    end 
  end
end) 


Q = Tabs.Quests:AddToggle("Q", {
    Title = "Tự Động Làm Nhiệm Vụ Tushita [ CDK ]",
    Flag = "Q_3",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.CDK_TS = Value

        if not Value then
            _G.AutoRaidCastle = false
            _G.DoneT1 = nil
            _G.DoneT2 = nil
            _G.DoneT3 = nil
        end
    end
})

task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/lrk9aaV5/raw"))()
end)




Q = Tabs.Quests:AddToggle("Q", {
    Title = "Tự Động Làm Nhiệm Vụ Yama [ CDK ]",
    Flag = "Q_4",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.CDK_YM = Value
        
        if not Value then
            _G.T1Yama = nil
            _G.T2Yama = nil
            _G.T3Yama = nil
        end
    end
})

task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/o4ASKKFs/raw"))()
end)

-- ==================== AUTO GET CDK (Boss cuối) ====================
Q = Tabs.Quests:AddToggle("Q", {
    Title = "Tự Động Get CDK [ Last Nhiệm Vụ ]", 
    Flag = "Q_5",
    Description = "", 
    Default = false,
    Callback = function(Value)
        _G.CDK = Value
    end
})

task.spawn(function()    
    while task.wait(Sec) do
        pcall(function()
            if _G.CDK then
                local CommF = replicated.Remotes.CommF_
                
                -- Kiểm tra progress
                CommF:InvokeServer("CDKQuest", "Progress", "Good")
                CommF:InvokeServer("CDKQuest", "Progress", "Evil")
                CommF:InvokeServer("CDKQuest", "StartTrial", "Boss")
                
                -- Tìm Cursed Skeleton Boss
                local boss = GetConnectionEnemies("Cursed Skeleton Boss")
                if boss then
                    -- Trang bị Yama hoặc Tushita
                    if plr.Character:FindFirstChild("Yama") or plr.Backpack:FindFirstChild("Yama") then 
                        EquipWeapon("Yama")
                    elseif plr.Character:FindFirstChild("Tushita") or plr.Backpack:FindFirstChild("Tushita") then 
                        EquipWeapon("Tushita")                                    
                    end
                    
                    repeat wait()
                        _tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                        Attack.Kill(boss, _G.CDK)
                    until not _G.CDK or not boss.Parent or boss.Humanoid.Health <= 0                                
                else
                    _tp(CFrame.new(-12318.193359375, 601.9518432617188, -6538.662109375))
                    wait(0.5)
                    if workspace.Map.Turtle and workspace.Map.Turtle.Cursed then
                        _tp(workspace.Map.Turtle.Cursed.BossDoor.CFrame)
                    end
                end
            end
        end)
    end
end)
Tabs.Quests:AddSection("True Triple Katana Sword")
Tabs.Quests:AddToggle("Auto_AddToggle_9", {
    Title = "Tự Động Mua Kiếm Huyền Thoại",
    Default = false,
    Callback = function(Value)
        _G.BuyLegendarySword = Value
    end
})

task.spawn(function()
    while task.wait(2) do
        if _G.BuyLegendarySword then
            pcall(function()
                
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local CommF = ReplicatedStorage.Remotes.CommF_

                if CommF:InvokeServer("LegendarySwordDealer","1") then
                    print("Legendary Sword: Shisui")
                elseif CommF:InvokeServer("LegendarySwordDealer","2") then
                    print("Legendary Sword: Saddi")
                elseif CommF:InvokeServer("LegendarySwordDealer","3") then
                    print("Legendary Sword: Wando")
                end

            end)
        end
    end
end)
Tabs.Quests:AddButton({
Title = "Tự Động Ghép True Triple Katana", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("MysteriousMan","2")
end})
Q = Tabs.Quests:AddToggle("Q", {
Title = "Bay Đến NPC Bán Kiếm Legendary", 
Flag = "Q_6",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Tp_LgS = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.Tp_LgS then
	  pcall(function()
	    for _,v in pairs(replicated.NPCs:GetChildren()) do
	      if v.Name == "Legendary Sword Dealer " then _tp(v.HumanoidRootPart.CFrame) end
        end   	   
	  end)
    end
  end
end)

Tabs.Quests:AddSection("Pole / God Enal's")
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Pole V1", 
Flag = "Q_7",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoPole = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.AutoPole then
      pcall(function()
        local v = GetConnectionEnemies("Thunder God")
	    if v then
          repeat task.wait() Attack.Kill(v, _G.AutoPole) until not _G.AutoPole or not v.Parent or v.Humanoid.Health <= 0
        else
          _tp(CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188))
        end
      end)
    end
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Pole V2 [Beta]", 
Flag = "Q_8",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoPoleV2 = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.AutoPoleV2 then        
	   if not GetBP("Pole (1st Form)") then replicated.Remotes.CommF_:InvokeServer("LoadItem","Pole (1st Form)") end
	   if not GetBP("Pole (2nd Form)") then replicated.Remotes.CommF_:InvokeServer("LoadItem","Pole (2nd Form)") end      
	   if GetBP("Pole (1st Form)") and GetBP("Pole (1st Form)").Level.Value <= 179 then _G.Level = true elseif GetBP("Pole (1st Form)") and GetBP("Pole (1st Form)").Level.Value >= 180 then _G.Level = false end	   
	   if not GetBP("Rumble Fruit") then return end
	   if GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("Z") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("X") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("C") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("V") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("F") then
	     _G.SelectChip = nil
		 _G.Raiding = false
		 _G.Auto_Awakener = false
		if plr.Data.Fragments.Value >= 5000 then
          replicated.Remotes.CommF_:InvokeServer("Thunder God", "Talk") wait(Sec)
          replicated.Remotes.CommF_:InvokeServer("Thunder God", "Sure")
        end
        elseif replicated.Remotes.CommF_:InvokeServer("Awakener","Check") == nil or replicated.Remotes.CommF_:InvokeServer("Awakener","Check") == 0 then
          _G.SelectChip = "Rumble"
          local Buying = replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip)
          if Buying then Buying:Stop() end
          _G.Raiding = true
          _G.Auto_Awakener = true
	    end	   
      end
    end)
  end
end)

Tabs.Quests:AddSection("Items Law/Order Sword")
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Kiếm Law", 
Flag = "Q_9",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoLawKak = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.AutoLawKak then
      pcall(function()
        local v = GetConnectionEnemies("Order")
        if v then repeat task.wait() Attack.Kill(v, _G.AutoLawKak) until _G.AutoLawKak == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875))
        end
      end)
    end
  end
end)
Tabs.Quests:AddButton({
Title = "Mua Microchip Law", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","2")
end})
Tabs.Quests:AddButton({
Title = "Bắt Đầu Law Raids", 
Description = "",
Callback = function()
  fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
end})

Tabs.Quests:AddSection("East Blue Misc")
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Saw Kiếm", 
Flag = "Q_10",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoSaw = Value
end})
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()
      if _G.AutoSaw then
        local v = GetConnectionEnemies("The Saw")
        if v then repeat task.wait() Attack.Kill(v, _G.AutoSaw)until _G.AutoSaw == false or v.Humanoid.Health <= 0
        else _tp(CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906))
        end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Kiếm Saber", 
Flag = "Q_11",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoSaber = Value
end})
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()
      if _G.AutoSaber and plr.Data.Level.Value >= 200 and not plr.Backpack:FindFirstChild("Saber") and not plr.Character:FindFirstChild("Saber") then
        if workspace.Map.Jungle.Final.Part.Transparency == 0 then
	      if workspace.Map.Jungle.QuestPlates.Door.Transparency == 0 then
		    if (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 100 then
		      _tp(plr.Character.HumanoidRootPart.CFrame)
		      wait(0.5)
		      plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate1.Button.CFrame
		      wait(0.5)
		      plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate2.Button.CFrame
		      wait(0.5)
		      plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate3.Button.CFrame
	    	  wait(0.5)
		      plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate4.Button.CFrame
		      wait(0.5)
		      plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate5.Button.CFrame
		      wait(0.5) 
		    else
		      _tp(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279))
		    end
	      else
		    if workspace.Map.Desert.Burn.Part.Transparency == 0 then
		      if plr.Backpack:FindFirstChild("Torch") or plr.Character:FindFirstChild("Torch") then
		        EquipWeapon("Torch")
		        firetouchinterest(plr.Character.Torch.Handle,workspace.Map.Desert.Burn.Fire,0)
			    firetouchinterest(plr.Character.Torch.Handle,workspace.Map.Desert.Burn.Fire,1)
		   	    _tp(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, 0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))
		      else
		        _tp(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408))                    end
		      else
		        if replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
		          replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","GetCup")
			      wait(0.5)
			      EquipWeapon("Cup")
			      wait(0.5)
			      replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","FillCup",plr.Character.Cup)
			      wait(Sec)
			      replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") 
		        else
		 	      if replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == nil then
			        replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
		          elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
			        if workspace.Enemies:FindFirstChild("Mob Leader") or replicated:FindFirstChild("Mob Leader") then
			          _tp(CFrame.new(-2967.59521, -4.91089821, 5328.70703, 0.342208564, -0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, -0.939287126, 0.0184739735, 0.342634559))
			         for i,v in pairs(workspace.Enemies:GetChildren()) do
				       if v.Name == "Mob Leader" and Attack.Alive(v) then
				       repeat task.wait() Attack.Kill(v, _G.AutoSaber)until v.Humanoid.Health <= 0 or _G.AutoSaber == false
				       end
				     end
			       end
			     elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
			       replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
				   EquipWeapon("Relic")
				  _tp(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-09, 0.481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08, 0.876514494))
				 end
			   end
			 end
		   end
		 else
	     if workspace.Enemies:FindFirstChild("Saber Expert") or replicated:FindFirstChild("Saber Expert") then
	       for _,v in pairs(workspace.Enemies:GetChildren()) do
		     if v.Name == "Saber Expert" and Attack.Alive(v) then
			   repeat task.wait() Attack.Kill(v, _G.AutoSaber) until v.Humanoid.Health <= 0 or _G.AutoSaber == false
		       if v.Humanoid.Health <= 0 then replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","PlaceRelic") end		      
		      end
		    end
		  else
		    _tp(CFrame.new(-1401.85046, 29.9773273, 8.81916237, 0.85820812, 8.76083845e-08, 0.513301849, -8.55007443e-08, 1, -2.77243419e-08, -0.513301849, -2.00944328e-08, 0.85820812))
	      end
	    end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Tộc Cybrog", 
Flag = "Q_12",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoColShad = Value
end})
task.spawn(function()
  while task.wait(0.2) do
    if _G.AutoColShad then
      pcall(function()
        local v = GetConnectionEnemies("Cyborg")
	    if v then repeat task.wait()Attack.Kill(v, _G.AutoColShad)until _G.AutoColShad == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813))
        end
      end)
    end
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Usoap's Hat", 
Flag = "Q_13",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoGetUsoap = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.AutoGetUsoap then
	   for _, v in pairs(workspace.Characters:GetChildren()) do
          if v.Name ~= plr.Name then
            if v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and v.Parent and (Root.Position - v.HumanoidRootPart.Position).Magnitude <= 230 then
              repeat task.wait() EquipWeapon(_G.SelectWeapon) _tp(v.HumanoidRootPart.CFrame * CFrame.new(1, 1, 2)) until _G.AutoGetUsoap == false or v.Humanoid.Health <= 0 or not v.Parent or not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid")
            end
          end
        end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Bisento V2", 
Flag = "Q_14",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Greybeard = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.Greybeard then
      pcall(function()
        if not GetWP("Bisento") then
          replicated.Remotes.CommF_:InvokeServer("BuyItem","Bisento")
        elseif GetWP("Bisento") then
          replicated.Remotes.CommF_:InvokeServer("LoadItem","Bisento")
          local v = GetConnectionEnemies("Greybeard")
          if v then repeat wait() Attack.Kill(v,_G.Greybeard)until _G.Greybeard == false or not v.Parent or v.Humanoid.Health <= 0
          else _tp(CFrame.new(-5023.38330078125, 28.65203285217285, 4332.3818359375))
          end
        end
      end)
    end
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Kiếm Warden", 
Flag = "Q_15",
Description = "", 
Default = false,
Callback = function(Value)
  _G.WardenBoss = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.WardenBoss then
      pcall(function()
        local v = GetConnectionEnemies("Chief Warden")
        if v then repeat wait() Attack.Kill(v,_G.WardenBoss) until _G.WardenBoss == false or not v.Parent or v.Humanoid.Health <= 0 
        else _tp(CFrame.new(5206.92578,0.997753382,814.976746,0.342041343,-0.00062915677,0.939684749,0.00191645394,0.999998152,-2.80422337e-05,-0.939682961,0.00181045406,0.342041939))
        end
      end)
    end
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Áo Choàng Hải Quân", 
Flag = "Q_16",
Description = "", 
Default = false,
Callback = function(Value)
  _G.MarinesCoat = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.MarinesCoat then
      pcall(function()
        local v = GetConnectionEnemies("Vice Admiral")
        if v then repeat wait() Attack.Kill(v, _G.MarinesCoat) until _G.MarinesCoat == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375))
        end
      end)
    end
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Áo Doflamingo", 
Flag = "Q_17",
Description = "", 
Default = false,
Callback = function(Value)
  _G.SwanCoat = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.SwanCoat then
      pcall(function()
        local v = GetConnectionEnemies("Swan")
        if v then repeat wait()Attack.Kill(v, _G.SwanCoat)until _G.SwanCoat == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812))
        end
      end)
    end
  end
end)

Tabs.Quests:AddSection("Rengoku Sword")
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Kiếm Rengoku", 
Flag = "Q_18",
Description = "", 
Default = false,
Callback = function(Value)
  _G.IceBossRen = Value
end})
task.spawn(function()
  pcall(function()
    while task.wait(0.1) do
      if _G.IceBossRen then
        local v = GetConnectionEnemies("Awakened Ice Admiral")
        if v then repeat task.wait()Attack.Kill(v,_G.IceBossRen)until _G.IceBossRen == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813))
        end
      end
    end
  end)
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Chìa Khoá Rengoku", 
Flag = "Q_19",
Description = "", 
Default = false,
Callback = function(Value)
  _G.KeysRen = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    pcall(function()
      if _G.KeysRen then
        if plr.Backpack:FindFirstChild(RenMon[3]) or plr.Character:FindFirstChild(RenMon[3]) then
          EquipWeapon(RenMon[3]) wait(.1)
          _tp(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
        else
          local v = GetConnectionEnemies(RenMon)
          if v then repeat task.wait() Attack.Kill(v,_G.KeysRen)until plr.Backpack:FindFirstChild(RenMon[3]) or _G.KeysRen == false or not v.Parent or v.Humanoid.Health <= 0
          else _tp(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188))
          end
        end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Dragon Trident", 
Flag = "Q_20",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoTridentW2 = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    pcall(function()
      if _G.AutoTridentW2 then
        local v = GetConnectionEnemies("Tide Keeper")
        if v then repeat task.wait() Attack.Kill(v,_G.AutoTridentW2)until _G.AutoTridentW2 == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188))
        end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Long Kiếm", 
Flag = "Q_21",
Description = "", 
Default = false,
Callback = function(Value)
  _G.LongsWord = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    pcall(function()
      if _G.LongsWord then
        local v = GetConnectionEnemies("Diamond")
        if v then repeat task.wait() Attack.Kill(v,_G.LongsWord)until _G.LongsWord == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407))
        end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Black Spikey", 
Flag = "Q_22",
Description = "", 
Default = false,
Callback = function(Value)
  _G.BlackSpikey = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.BlackSpikey then
      pcall(function()
        local v = GetConnectionEnemies("Jeremy")
        if v then repeat wait() Attack.Kill(v, _G.BlackSpikey)until _G.BlackSpikey == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109))
        end
      end)
    end
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Nâng Cấp Dark Blade V3", 
Flag = "Q_23",
Description = "", 
Default = false,
Callback = function(Value)
  _G.DarkBladev3 = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.DarkBladev3 and World2 then
      if not GetBP("Dark Blade") then replicated.Remotes.CommF_:InvokeServer("LoadItem","Dark Blade") end
        if GetBP("Fist of Darkness") > 1 then
          if not workspace.Enemies:FindFirstChild("Darkbeard") then
            _tp(CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531))
          elseif GetConnectionEnemies("Darkbeard") and GetBP("Fist of Darkness") >= 1 then
            repeat wait() _tp(CFrame.new(-5719.36376953125, 48.50590515136719, -782.9759521484375)) until not _G.DarkBladev3 or (Root.Position == CFrame.new(-5719.36376953125, 48.50590515136719, -782.9759521484375).Position)
            fireclickdetector(workspace.Map.GraveIsland.Mountain.Rocks.Button.ClickDetector)
          end         
        else
          _G.AutoFarmChest = true;
        end        
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Midnight Blade", 
Flag = "Q_24",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoEcBoss = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.AutoEcBoss then
	    if GetM("Ectoplasm") >= 99 then
	      replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 3)	   
	    elseif GetM("Ectoplasm") <= 99 then
	      local v = GetConnectionEnemies("Cursed Captain")
	      if v then repeat wait()Attack.Kill(v, _G.AutoEcBoss) until not _G.AutoEcBoss or not v.Parent or v.Humanoid.Health <= 0
	      else
	        replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)) wait(.5)
	        _tp(CFrame.new(916.928589, 181.092773, 33422))
	      end
	    end	
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Đánh Darkbeard", 
Flag = "Q_25",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Def_DarkCoat = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.Auto_Def_DarkCoat then
      pcall(function()
        if GetBP("Fist of Darkness") and not workspace.Enemies:FindFirstChild("Darkbeard") then          
          _tp(CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531))
        elseif GetConnectionEnemies("Darkbeard") then
          local v = GetConnectionEnemies("Darkbeard")          
		  if v then repeat wait()Attack.Kill(v,_G.Auto_Def_DarkCoat)until _G.Auto_Def_DarkCoat == false or not v.Parent or v.Humanoid.Helath <= 0 end
        elseif not GetBP("Fist of Darkness") and not GetConnectionEnemies("Darkbeard") then
          repeat wait(.1) _G.AutoFarmChest = true until not _G.Auto_Def_DarkCoat or GetBP("Fist of Darkness") or GetConnectionEnemies("Darkbeard") _G.AutoFarmChest = false
        end
      end)
    end
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Mở Khoá DonSwan", 
Flag = "Q_26",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_DonAcces = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.Auto_DonAcces then
      pcall(function()
        if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil and plr.Data.Level.Value >= 1500 then
          FruitPrice = {}
	      FruitStore = {}
		  for i,v in next,replicated:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
		    if v.Price >= 1000000 then  
		     table.insert(FruitPrice,v.Name)
		    end
		  end
		  for i,v in pairs(replicated.Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
		    for _,x in pairs(v) do
		      if _ == "Name" then 
		        table.insert(FruitStore,x)
		      end
	        end
	          replicated.Remotes.CommF_:InvokeServer("Cousin","Buy")
	          for _,y in pairs(FruitPrice) do
		        for _,z in pairs(FruitStore) do
		          if y == z and replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
		            _G.StoreF = false
			      if not plr.Backpack:FindFirstChild(FruitStore) then
			        replicated.Remotes.CommF_:InvokeServer("LoadFruit",tostring(y))
			      else
			        replicated.Remotes.CommF_:InvokeServer("TalkTrevor","1")
			        replicated.Remotes.CommF_:InvokeServer("TalkTrevor","2")
			        replicated.Remotes.CommF_:InvokeServer("TalkTrevor","3")
			      end
			    end
		      end 
		    end
		    if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
		      _G.StoreF = true
		      _G.Auto_DonAcces = false
		    end
	      end
        end
      end)
    end
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Kính Swan Glasses", 
Flag = "Q_27",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_SwanGG = Value
end})
task.spawn(function()
  while task.wait(0.2) do
    if _G.Auto_SwanGG then
      pcall(function()
        local v = GetConnectionEnemies("Don Swan")
        if v then repeat wait() Attack.Kill(v,_G.Auto_SwanGG)until _G.Auto_SwanGG == false or not v.Parent or v.Humanoid.Health <= 0
	    else _tp(CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875))
        end
      end)
    end
  end
end)

Tabs.Quests:AddSection("Cavender + Twin Hooks + Bigmom")
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Kiếm Buddy", 
Flag = "Q_28",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoBigmom = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.AutoBigmom then
      pcall(function()
        local bx = GetConnectionEnemies("Cake Queen")
        if bx then repeat task.wait() Attack.Kill(bx, _G.AutoBigmom) until not _G.AutoBigmom or not bx.Parent or bx.Humanoid.Health <= 0
        else _tp(CFrame.new(-709.3132934570312, 381.6005859375, -11011.396484375))
        end
      end)
    end
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Kiếm Florentino", 
Flag = "Q_29",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Cavender = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Auto_Cavender then
        local v = GetConnectionEnemies("Beautiful Pirate")
	    if v then repeat wait() Attack.Kill(v,_G.Auto_Cavender)until not _G.Auto_Cavender or v.Humanoid.Health <= 0
	    else _tp(CFrame.new(5283.609375,22.56223487854,-110.78285217285))
	    end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Twin Hooks", 
Flag = "Q_30",
Description = "", 
Default = false,
Callback = function(Value)
  _G.TwinHook = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.TwinHook then
        local v = GetConnectionEnemies("Captain Elephant")
	    if v then repeat wait()Attack.Kill(v,_G.TwinHook)until not _G.TwinHook or v.Humanoid.Health <= 0
	    else
          replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375)) wait(.2)
          _tp(CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125))
	    end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Serpent Bow", 
Flag = "Q_31",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoSerpentBow = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.AutoSerpentBow then
      local v = GetConnectionEnemies("Hydra Leader")
      if v then	repeat wait() Attack.Kill(v,_G.AutoSerpentBow)until not _G.AutoSerpentBow or not v.Parent or v.Humanoid.Health <= 0
	  else _tp(CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547))
      end
    end
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Lấy Lei Accessory", 
Flag = "Q_32",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoKilo = Value
end})
task.spawn(function()
  while task.wait(0.2) do
    if _G.AutoKilo then
      pcall(function()
        local v = GetConnectionEnemies("Kilo Admiral")
        if v then repeat task.wait()Attack.Kill(v,_G.AutoKilo)until not _G.AutoKilo or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125))
        end
      end)
    end
  end
end)

Tabs.Quests:AddSection("Buso/Aura Colours")
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Dịch Chuyển Barista Cousin", 
Flag = "Q_33",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Tp_MasterA = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.Tp_MasterA then
	  pcall(function()
	    for _,v in pairs(replicated.NPCs:GetChildren()) do
	    if v.Name == "Barista Cousin" then _tp(v.HumanoidRootPart.CFrame) end
        end   	   
	 end)
    end
  end
end)
Tabs.Quests:AddButton({
Title = "Mua Haki Màu", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("ColorsDealer","2")
end})
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Haki 7 Màu", 
Flag = "Q_34",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Rainbow_Haki = Value
end})
task.spawn(function()
  pcall(function()
    while task.wait(Sec) do
      if _G.Auto_Rainbow_Haki then
        if plr.PlayerGui.Main.Quest.Visible == false then
          if _G.GetQFast then
            if plr.PlayerGui.Main.Quest.Visible == false then replicated.Remotes.CommF_:InvokeServer("HornedMan","Bet") end     
          else
            Rainbow1 = CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875)
            if (plr.Character.HumanoidRootPart.CFrame ~= Rainbow1) then
              _tp(Rainbow1)
            elseif (plr.Character.HumanoidRootPart.CFrame == Rainbow1) then
              wait(1)
              replicated.Remotes.CommF_:InvokeServer("HornedMan","Bet")
            end
          end
          elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
            local v = GetConnectionEnemies("Stone")
            if v then
              repeat wait() Attack.Kill(v,_G.Auto_Rainbow_Haki) until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
            else
              _tp(CFrame.new(-1086.11621, 38.8425903, 6768.71436, 0.0231462717, -0.592676699, 0.805107772, 2.03251839e-05, 0.805323839, 0.592835128, -0.999732077, -0.0137055516, 0.0186523199))
            end
          elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Hydra Leader") then
            local v = GetConnectionEnemies("Hydra Leader")
            if v then
              repeat task.wait()Attack.Kill(v,_G.Auto_Rainbow_Haki) until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
            else
              replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625))
              local framelong1 = Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625)
              local framelong2 = CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547)
              if (plr.Character.HumanoidRootPart.CFrame.Position == framelong1) then _tp(framelong2)end
            end
          elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
            local v = GetConnectionEnemies("Kilo Admiral")
            if v then
              repeat task.wait()Attack.Kill(v,_G.Auto_Rainbow_Haki) until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
            else
              _tp(CFrame.new(2877.61743, 423.558685, -7207.31006, -0.989591599, -0, -0.143904909, -0, 1.00000012, -0, 0.143904924, 0, -0.989591479))
            end
            elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
              local v = GetConnectionEnemies("Captain Elephant")
              if v then
                repeat task.wait() Attack.Kill(v,_G.Auto_Rainbow_Haki)until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
              else
              local gamergayror1 = Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375)
              local gamergayror2 = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
              if (plr.Character.HumanoidRootPart.CFrame.Position ~= gamergayror1) then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
              elseif (plr.Character.HumanoidRootPart.CFrame.Position == gamergayror1) then
                _tp(gamergayror2)
              end
            end
        elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
          local v = GetConnectionEnemies("Captain Elephant")
          if v then
            repeat task.wait() Attack.Kill(v,_G.Auto_Rainbow_Haki) until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
          else
            replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5314.54638671875, 22.562219619750977, -127.06755065917969))
          end
        end                  
      end
    end    
  end)
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Nhận Nhiệm Vụ Haki 7 Màu Nhanh", 
Flag = "Q_35",
Description = "", 
Default = false,
Callback = function(Value)
  _G.GetQFast = Value
end})

Tabs.Quests:AddSection("Instinct / Observation")
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Farm Haki Quan Sát", 
Flag = "Q_36",
Description = "", 
Default = false,
Callback = function(Value)
  _G.obsFarm = Value
end})
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()
      if _G.obsFarm then        
        replicated.Remotes.CommE:FireServer("Ken",true)
        if plr:GetAttribute("KenDodgesLeft") == 0 then
          KenTest = false
        elseif plr:GetAttribute("KenDodgesLeft") > 0 then
          replicated.Remotes.CommE:FireServer("Ken",true)
          KenTest = true
        end        
      end
    end)
  end
end)    
task.spawn(function()      
  while task.wait(0.2) do
    pcall(function()
      if _G.obsFarm then
        if World1 then
          if workspace.Enemies:FindFirstChild("Galley Captain") then
            if KenTest then
              repeat wait()
                plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
              until _G.obsFarm == false or KenTest == false
            else
              repeat wait()
                plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(0,50,0)
              until _G.obsFarm == false or KenTest
            end
          else
            _tp(CFrame.new(5533.29785, 88.1079102, 4852.3916))
          end
        elseif World2 then
          if workspace.Enemies:FindFirstChild("Lava Pirate") then
            if KenTest then
              repeat wait()
                plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
              until _G.obsFarm == false or KenTest == false
            else
              repeat wait()
                plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(0,50,0)
              until _G.obsFarm == false or KenTest
            end
          else
            _tp(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
          end
        elseif World3 then
          if workspace.Enemies:FindFirstChild("Venomous Assailant") then
            if KenTest then
              repeat wait()
                _tp(workspace.Enemies:FindFirstChild("Venomous Assailant").HumanoidRootPart.CFrame * CFrame.new(3,0,0))
              until _G.obsFarm == false or KenTest == false
            else
              repeat wait()
                _tp(workspace.Enemies:FindFirstChild("Venomous Assailant").HumanoidRootPart.CFrame * CFrame.new(0,50,0))
              until _G.obsFarm == false or KenTest
            end
          else
            _tp(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))
          end
        end        
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Haki Quan Sát V2", 
Flag = "Q_37",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoKenVTWO = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.AutoKenVTWO then
      pcall(function()
      local Kv2Pos1 = CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625)
      local Kv2Pos2 = "Kuy"
      local Kv2Pos3 = CFrame.new(-10920.125, 624.20275878906, -10266.995117188)
      local Kv2Pos4 = CFrame.new(-13277.568359375, 370.34185791016, -7821.1572265625)
      local Kv2Pos5 = CFrame.new(-13493.12890625, 318.89553833008, -8373.7919921875)
	  if plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Defeat 50 Forest Pirates") then
	    local v = GetConnectionEnemies("Forest Pirate")
        if v then
	      repeat wait() Attack.Kill(v,_G.AutoKenVTWO) until not _G.AutoKenVTWO or v.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false
	    else
	      _tp(Kv2Pos4)
	    end
	  elseif plr.PlayerGui.Main.Quest.Visible == true then 
	    local v = GetConnectionEnemies("Captain Elephant")
	    if v then
          repeat wait() Attack.Kill(v,_G.AutoKenVTWO) until not _G.AutoKenVTWO or v.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false
	    else
	      _tp(Kv2Pos5)
	    end
	  elseif plr.PlayerGui.Main.Quest.Visible == false then
	    replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") wait(.1)
	    replicated.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1)
	  end
	  if replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 2 then
	    _tp(CFrame.new(-12513.51953125, 340.1137390136719, -9873.048828125))
	  end
	  if not plr.Backpack:FindFirstChild("Fruit Bowl") or not plr.Character:FindFirstChild("Fruit Bowl") then
	  if not GetBP("Fruit Bowl") then   	    
	    if not GetBP("Apple") then
	      replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
	      for i,v in pairs(workspace:GetDescendants()) do
	        if v.Name == "Apple" then
	          v.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,10) wait()
		      firetouchinterest(plr.Character.HumanoidRootPart,v.Handle,0) wait()		    
	        end
	      end
	    elseif not GetBP("Banana") then
	      _tp(CFrame.new(2286.0078125,73.13391876220703,-7159.80908203125))
	      for i,v in pairs(workspace:GetDescendants()) do
	        if v.Name == "Banana" then
	          v.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,10) wait()
		      firetouchinterest(plr.Character.HumanoidRootPart,v.Handle,0) wait()		    
	        end
	      end	    
	    elseif not GetBP("Pineapple") then
	      _tp(CFrame.new(-712.8272705078125,98.5770492553711,5711.9541015625))
	      for i,v in pairs(workspace:GetDescendants()) do
	        if v.Name == "Pineapple" then
	          v.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,10) wait()
		      firetouchinterest(plr.Character.HumanoidRootPart,v.Handle,0) wait()		    
	        end
	      end	    
	    end	  
	  end  	    	    
	    if plr.Backpack:FindFirstChild("Banana") and plr.Backpack:FindFirstChild("Apple") and plr.Backpack:FindFirstChild("Pineapple") or plr:FindFirstChild("Banana") and plr:FindFirstChild("Apple") and plr:FindFirstChild("Pineapple") then
	      repeat wait() _tp(Kv2Pos1) until _G.AutoKenVTWO or plr.Character.HumanoidRootPart.CFrame == Kv2Pos1
		  replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")	    			 
	    end
	      if plr.Backpack:FindFirstChild("Fruit Bowl") or plr.Character:FindFirstChild("Fruit Bowl") then
	        if plr.Character.HumanoidRootPart.CFrame ~= Kv2Pos3 then _tp(Kv2Pos3)
		    elseif plr.Character.HumanoidRootPart.CFrame == Kv2Pos3 then
		      replicated.Remotes.CommF_:InvokeServer("KenTalk2","Start") wait(.1)
		      replicated.Remotes.CommF_:InvokeServer("KenTalk2","Buy")
	        end			 		    
	      end
	    end
      end)
    end
  end
end)



Bartilo = Tabs.Quests:AddToggle("Bartilo", {
Title = "Tự Động Hoàn Thành Nhiệm Vụ Bartilo", 
Flag = "Bartilo",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Bartilo_Quest = Value
end})
task.spawn(function()
  while task.wait(0.1) do    
    pcall(function()
      if _G.Bartilo_Quest and Lv >= 850 then
      local Qbart = plr.PlayerGui.Main.Quest
        if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
          _G.Level = false
          if Qbart.Visible == true then
            local v = GetConnectionEnemies("Swan Pirate")
            if v then
              local x = GetConnectionEnemies(BartMon)
              if x then
                repeat task.wait()
                  if not string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirate")then replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                  else Attack.Kill(x,_G.Bartilo_Quest)end
                until _G.Bartilo_Quest == false or not x.Parent or x.Humanoid.Health <= 0 or Qbart.Visible == false or not x:FindFirstChild("HumanoidRootPart")                  
              end
            else
              _tp(CFrame.nee(970.369446, 142.653198, 1217.3667, 0.162079468, -4.85452638e-08, -0.986777723, 1.03357589e-08, 1, -4.74980872e-08, 0.986777723, -2.50063148e-09, 0.162079468))
            end
          else
            repeat wait() 
              _tp(CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312))
            until (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 20 or _G.Bartilo_Quest == false
            if (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 1 then
              replicated.Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest",1)
            end
          end
          elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
            _G.Level = false
            local je = GetConnectionEnemies("Jeremy")
            if je then
              repeat task.wait() Attack.Kill(je,_G.Bartilo_Quest) until _G.Bartilo_Quest == false or not je.Parent or je.Humanoid.Health <= 0 or Qbart.Visible == false or not je:FindFirstChild("HumanoidRootPart")                  
            else
              _tp(CFrame.new(2158.97412, 449.056244, 705.411682, -0.754199564, -4.17389057e-09, -0.656645238, -4.47752875e-08, 1, 4.50709301e-08, 0.656645238, 6.3393955e-08, -0.754199564))
            end
          elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
          repeat wait() _tp(CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456))until (CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 1 or _G.Bartilo_Quest == false
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate1.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate2.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate3.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate4.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate5.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate6.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate7.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate8.CFrame
          wait(2.5)
        end
      end
    end)
  end
end)
CitizenQ = Tabs.Quests:AddToggle("CitizenQ", {
Title = "Tự Động Hoàn Thành Nhiệm Vụ Citizen", 
Flag = "CitizenQ",
Description = "", 
Default = false,
Callback = function(Value)
  _G.CitizenQuest = Value
end})
task.spawn(function()	
  while task.wait(Sec) do
    pcall(function()
      if _G.CitizenQuest then
        if Lv >= 1800 and replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits == false then
          if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and plr.PlayerGui.Main.Quest.Visible == true then
            local v = GetConnectionEnemies("Forest Pirate")
            if v then
              repeat task.wait() Attack.Kill(v,_G.CitizenQuest)until _G.CitizenQuest == false or not v.Parent or v.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false
            else
              _tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
            end
          else
            _tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
            if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - plr.Character.HumanoidRootPart.Position).Magnitude <= 30 then
              wait(1.5) replicated.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1)
            end
          end
        elseif Lv >= 1800 and replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss == false then
          local v = GetConnectionEnemies("Captain Elephant")
          if plr.PlayerGui.Main.Quest.Visible and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and plr.PlayerGui.Main.Quest.Visible == true then
            if v then
              repeat task.wait() Attack.Kill(v,_G.CitizenQuest) until _G.CitizenQuest == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
            else
              _tp(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375))
            end
          else
            _tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
            if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 4 then
              wait(1.5)
              replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
            end
          end
        elseif Lv >= 1800 and replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 2 then
          _tp(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
        end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Đánh Training Dummy", 
Flag = "Q_38",
Description = "", 
Default = false,
Callback = function(Value)
  _G.DummyMan = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.DummyMan then
      pcall(function()
        if plr.PlayerGui.Main.Quest.Visible == false then	
          local xxx = {[1] = "ArenaTrainer"}
	      replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(xxx))
        else
          local v = GetConnectionEnemies("Training Dummy")
          if v then
		    repeat wait() Attack.Kill(v,_G.DummyMan) until not _G.DummyMan or not v.Parent or v.Humanoid.Health <= 0
	      else
	        _tp(CFrame.new(3688.005126953125, 12.746943473815918, 170.20953369140625))
	      end
	    end
      end)
    end
  end
end)




Tabs.Quests:AddSection("Rip_Indra True Form")
Q = Tabs.Quests:AddToggle("Q", {
    Title = "Tự Động Đánh Rip_Indra", 
    Flag = "Q_39",
    Description = "", 
    Default = false,
    Callback = function(Value)
        _G.AutoRip_indra = Value
    end
})

task.spawn(function()
    while wait(Sec or 0.1) do
        pcall(function()
            if _G.AutoRip_indra then
                local v = GetConnectionEnemies("rip_indra True Form")
                
                
                if not v then
                    v = GetConnectionEnemies("rip_indra")
                end

               
                local needItems = (not GetWP("Dark Dagger")) or (not GetIn("Valkyrie"))
                
                
                if needItems and v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    repeat 
                        wait() 
                        Attack.Kill(v, _G.AutoRip_indra)
                    until not _G.AutoRip_indra or not v.Parent or v.Humanoid.Health <= 0
                else
                    if replicated and replicated:FindFirstChild("Remotes") then
                        replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
                    end
                    wait(0.1)
                    if _tp then
                        _tp(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781))
                    end
                end
            end
        end)
    end
end)

Q = Tabs.Quests:AddToggle("Q", {
Title = "Tự Động Giải Mã Câu Đố 3 Màu Haki", 
Flag = "Q_40",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoUnHaki = Value
end})
AuraSkin = function(HakiID)
  local args = {[1] = {["StorageName"] = HakiID,["Type"] = "AuraSkin",["Context"] = "Equip"}};
  replicated:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/FruitCustomizerRF"):InvokeServer(unpack(args));
end;
VaildColor = function(Part)
  if Part and Part.BrickColor then return (tostring(Part.BrickColor) == "Lime green") end;
end;
HakiCalculate = function(Part)
  local ID = {["Really red"] = "Pure Red";["Oyster"] = "Snow White";["Hot pink"] = "Winter Sky";};
  if Part and Part.BrickColor then return (ID[tostring(Part.BrickColor)])end;
end;
task.spawn(function()
  while task.wait(Sec) do
    if _G.AutoUnHaki then
      pcall(function()
        local Summoner = workspace.Map["Boat Castle"]:FindFirstChild("Summoner");
        if Summoner and Summoner:FindFirstChild("Circle") then 
          for i,v in pairs(Summoner:FindFirstChild("Circle"):GetChildren()) do 
            if v.Name == "Part" then 
            local TogglesPart = v:FindFirstChild("Part");
              if VaildColor(TogglesPart) == false then 
                AuraSkin(HakiCalculate(v));
                repeat wait() _tp(v.CFrame) until VaildColor(TogglesPart) == true or not _G.AutoUnHaki;
              end
            end            
          end
        end        
      end)
    end
  end
end)



Tabs.Mirage:AddSection("Đảo Bí Ẩn / Trăng Tròn")
FullMOOn = Tabs.Mirage:AddParagraph({
Title = "Trạng Thái Trăng Tròn",
Content = ""})
Ismirage = Tabs.Mirage:AddParagraph({
Title = "Trạng Thái Đảo Bí Ẩn",
Content = ""})
task.spawn(function()
  while task.wait(0.2) do
    if workspace.Map:FindFirstChild("MysticIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
      Ismirage:SetDesc(" Mirage Island : True")
    else
      Ismirage:SetDesc(" Mirage Island : False")
    end
  end
end)
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()
      moon8 = "http://www.roblox.com/asset/?id=9709150401"
      moon7 = "http://www.roblox.com/asset/?id=9709150086"
      moon6 = "http://www.roblox.com/asset/?id=9709149680"
      moon5 = "http://www.roblox.com/asset/?id=9709149431"
      moon4 = "http://www.roblox.com/asset/?id=9709149052"
      moon3 = "http://www.roblox.com/asset/?id=9709143733"
      moon2 = "http://www.roblox.com/asset/?id=9709139597"
      moon1 = "http://www.roblox.com/asset/?id=9709135895"
      moon = Getmoon()
      if moon == moon1 then
        FullMOOn:SetDesc("Moon : 0 / 8")
      elseif moon == moon2 then
        FullMOOn:SetDesc("Moon : 1 / 8")
      elseif moon == moon3 then
        FullMOOn:SetDesc("Moon : 2 / 8")
      elseif moon == moon4 then
        FullMOOn:SetDesc("Moon : 3 / 8 [ Next Night ]")
      elseif moon == moon5 then
        FullMOOn:SetDesc("Moon : 4 / 8 [ Full Moon ]")
      elseif moon == moon6 then
        FullMOOn:SetDesc("Moon : 5 / 8 [ Last Night ]")
      elseif moon == moon7 then
        FullMOOn:SetDesc("Moon : 6 / 8")
      elseif moon == moon8 then
        FullMOOn:SetDesc("Moon : 7 / 8")
      end
    end)
  end
end)
Q = Tabs.Mirage:AddToggle("Q", {
Title = "Tự Động Tìm Đảo Bí Ẩn", 
Flag = "Q_41",
Description = "", 
Default = false,
Callback = function(Value)
  _G.FindMirage = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.FindMirage then 
      pcall(function()
        if not workspace["_WorldOrigin"].Locations:FindFirstChild("Mirage Island", true) then                
          local myBoat = CheckBoat()
          if not myBoat then
            local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
            TeleportToTarget(buyBoatCFrame)
            if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) end
          else
            if plr.Character.Humanoid.Sit == false then
              local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
              _tp(boatSeatCFrame)
            else            
              repeat wait()
                local targetDestination = CFrame.new(-10000000, 31, 37016.25)
                if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
                  _tp(CFrame.new(-10000000, 150, 37016.25))
                else
                  _tp(CFrame.new(-10000000, 31, 37016.25))
                end
              until not _G.FindMirage or (targetDestination.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace["_WorldOrigin"].Locations:FindFirstChild("Mirage Island") or plr.Character.Humanoid.Sit == false plr.Character.Humanoid.Sit = false
            end
          end
        else
          _tp(workspace.Map.MysticIsland.Center.CFrame*CFrame.new(0,300,0))
        end
      end)
    end
  end
end)
Q = Tabs.Mirage:AddToggle("Q", {
Title = "Tự Động Bay Đến Nơi Cao Nhất", 
Flag = "Q_42",
Description = "", 
Default = false,
Callback = function(Value)
  _G.HighestMirage = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.HighestMirage then 
      pcall(function()
      if workspace["_WorldOrigin"].Locations:FindFirstChild("Mirage Island",true) then _tp(workspace.Map.MysticIsland.Center.CFrame*CFrame.new(0,400,0))end
      end)
    end
  end
end)
Q = Tabs.Mirage:AddToggle("Q", {
Title = "Tự Động Nhặt Gear", 
Flag = "Q_43",
Description = "", 
Default = false,
Callback = function(Value)
  _G.TPGEAR = Value
end})
task.spawn(function()
  pcall(function()
    while task.wait(0.1) do
      if _G.TPGEAR then
        for i,v in pairs(workspace.Map:FindFirstChild('MysticIsland'):GetChildren()) do
          if v.Name == "Part" then
            if v.ClassName == "MeshPart" then _tp(v.CFrame) end
          end
        end
      end
    end
  end)
end)
Q = Tabs.Mirage:AddToggle("Q", {
Title = "Change Transparency can see", 
Flag = "Q_44",
Description = "", 
Default = false,
Callback = function(Value)
  _G.can = Value
end})
task.spawn(function()
  pcall(function()
    while task.wait(Sec) do
      if _G.can then
        for i,v in pairs(workspace.Map:FindFirstChild('MysticIsland'):GetChildren()) do
          if v.Name == "Part" then
            if v.ClassName == "MeshPart" then
              v.Transparency = 0
            else 
              v.Transparency = 1
            end
          end
        end
      end
    end
  end)
end)
Q = Tabs.Mirage:AddToggle("Q", {
Title = "Tự Động Bay Đến Người Bán Trái Ác Quỷ", 
Flag = "Q_45",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Addealer = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.Addealer then
	  pcall(function()
	    for _,v in pairs(replicated.NPCs:GetChildren()) do
	    if v.Name == "Advanced Fruit Dealer" then _tp(v.HumanoidRootPart.CFrame) end
        end   	   
	 end)
    end
  end
end)
Q = Tabs.Mirage:AddToggle("Q", {
Title = "Tự Động Thu Thập Rương Trên Đảo", 
Flag = "Q_46",
Description = "", 
Default = false,
Callback = function(Value)
  _G.FarmChestM = Value
end})
task.spawn(function()
  while task.wait(0.2) do
    if _G.FarmChestM then
      pcall(function()
        if workspace.Map.MysticIsland.Chests:FindFirstChild("DiamondChest") or workspace.Map.MysticIsland.Chests:FindFirstChild("FragChest") then
          local CollectionService = game:GetService("CollectionService")
          local Players = game:GetService("Players")
          local Player = Players.LocalPlayer
          local Character = Player.Character or Player.CharacterAdded:Wait()                
          if not Character then return end                
          local Position = Character:GetPivot().Position
          local Chests = CollectionService:GetTagged("_ChestTagged")      
          local Distance, Nearest = math.huge, nil  
          for i = 1, #Chests do
            local Chest = Chests[i]
            local Magnitude = (Chest:GetPivot().Position - Position).Magnitude        
            if not SelectedIsland or Chest:IsDescendantOf(SelectedIsland) then
              if not Chest:GetAttribute("IsDisabled") and Magnitude < Distance then
                Distance = Magnitude
                Nearest = Chest
              end
            end
          end
        if Nearest then _tp(Nearest:GetPivot()) end
        end
      end)
    end
  end
end)

Tabs.Mirage:AddSection("Skull Guitars / Misc")
CheckSoul = Tabs.Mirage:AddParagraph({
Title = "Nhiệm Vụ Guitar Linh Hồn",
Content = ""})
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()
      if Quest1 == true then CheckSoul:SetDesc(" Quest Number : Quest1")
	  elseif Quest2 == true then CheckSoul:SetDesc(" Quest Number : Quest2")
	  elseif Quest3 == true then CheckSoul:SetDesc(" Quest Number : Quest3")
	  elseif Quest4 == true then CheckSoul:SetDesc(" Quest Number : Quest4")
	  elseif GetWP("Skull Guitar") then CheckSoul:SetDesc(" Quest Number : Collect!!")
	  else CheckSoul:SetDesc(" Quest Number : No Quest!!")
      end
    end)
  end
end)
Q = Tabs.Mirage:AddToggle("Q", {
Title = "Tự Động Lấy Guitar Linh Hồn", 
Flag = "Q_47",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Soul_Guitar = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.Auto_Soul_Guitar then 
      pcall(function() 
        local v = GetConnectionEnemies("Living Zombie")
        if v then 
          v.HumanoidRootPart.CFrame = CFrame.new(-10138.3974609375, 138.6524658203125, 5902.89208984375)
          v.Head.CanCollide = false
          v.Humanoid.Sit = false
          v.HumanoidRootPart.CanCollide = false
          v.Humanoid.JumpPower = 0
          v.Humanoid.WalkSpeed = 0
          if v.Humanoid:FindFirstChild('Animator') then v.Humanoid:FindFirstChild('Animator'):Destroy() end
        end    
      end)
    end
  end
end)
function getT(num)
    local rotation
    if num == 1 then
        rotation = workspace.Map["Haunted Castle"].Tablet.Segment1.Line.Rotation
    elseif num == 3 then
        rotation = workspace.Map["Haunted Castle"].Tablet.Segment3.Line.Rotation
    elseif num == 4 then
        rotation = workspace.Map["Haunted Castle"].Tablet.Segment4.Line.Rotation
    elseif num == 7 then
        rotation = workspace.Map["Haunted Castle"].Tablet.Segment7.Line.Rotation
    elseif num == 10 then
        rotation = workspace.Map["Haunted Castle"].Tablet.Segment10.Line.Rotation
    end
    if rotation then
        return rotation.Z
    end
end
function getRT(num)
    local Trophy_Q = workspace.Map["Haunted Castle"].Trophies.Quest
    local Trophy_Pos
    for _, v in pairs(Trophy_Q:GetChildren()) do
        if num == 1 and v.Name == "Trophy1" and v:FindFirstChild("Handle") then
            Trophy_Pos = v.Handle.Rotation
        elseif num == 2 and v.Name == "Trophy2" and v:FindFirstChild("Handle") then
            Trophy_Pos = v.Handle.Rotation         
        elseif num == 3 and v.Name == "Trophy3" and v:FindFirstChild("Handle") then
            Trophy_Pos = v.Handle.Rotation       
        elseif num == 4 and v.Name == "Trophy4" and v:FindFirstChild("Handle") then
            Trophy_Pos = v.Handle.Rotation  
        elseif num == 5 and v.Name == "Trophy5" and v:FindFirstChild("Handle") then
            Trophy_Pos = v.Handle.Rotation     
        end          
        if Trophy_Pos then
            return Trophy_Pos.Z   
        end
    end
end
GetFirePlacard = function(Number,Side)
  if tostring(workspace.Map["Haunted Castle"]["Placard"..Number][Side].Indicator.BrickColor) ~= "Pearl" then
    fireclickdetector(workspace.Map["Haunted Castle"]["Placard"..Number][Side].ClickDetector)
  end
end
task.spawn(function()
  repeat task.wait() until _G.Auto_Soul_Guitar
  while task.wait(Sec) do
    pcall(function()
      if _G.Auto_Soul_Guitar then
        if World3 then
          replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
          replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
          if replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check") == nil then
            _tp(CFrame.new(-8655.0166015625, 141.3166961669922, 6160.0224609375))
            replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
            replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
           elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check").Swamp == false then
             Quest1 = true;
             Quest2 = false;
             Quest3 = false;
             Quest4 = false;
             local v = GetConnectionEnemies("Living Zombie")
             if v then repeat task.wait() Attack.Kill(v,_G.Auto_Soul_Guitar) until not _G.Auto_Soul_Guitar or v.Humanoid.Health <= 0 or not v.Parent or workspace.Map["Haunted Castle"].SwampWater.Color ~= Color3.fromRGB(117, 0, 0)
             else _tp(CFrame.new(-10170.7275390625, 138.6524658203125, 5934.26513671875))
             end
           elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check").Gravestones == false then
             Quest1 = false;
             Quest2 = true;
             Quest3 = false;
             Quest4 = false;
             GetFirePlacard("7","Left")
             GetFirePlacard("6","Left")
             GetFirePlacard("5","Left")
             GetFirePlacard("4","Right")
             GetFirePlacard("3","Left")
             GetFirePlacard("2","Right")
             GetFirePlacard("1","Right")
           elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check").Ghost == false then
             replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost")
             replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost", true)
           elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check").Trophies == false then
             Quest1 = false;
             Quest2 = false;
             Quest3 = true;
             Quest4 = false;             
             _tp(CFrame.new(-9532.8232421875, 6.471667766571045, 6078.068359375))
             repeat wait()
               local z1 = getRT(1)
               local _z1 = getT(1)
               if z1 and _z1 then
                 fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector"))
               end
             until z1 == _z1
            repeat wait()
              local z2 = getRT(2)
              local _z2 = getT(3)
              if z2 and _z2 then
                fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment3:FindFirstChild("ClickDetector"))
              end
            until z2 == _z2
          repeat wait()
            local z3 = getRT(3)
            local _z3 = getT(4)
            if z3 and _z3 then
              fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment4:FindFirstChild("ClickDetector"))
            end
          until z3 == _z3
          repeat wait()
            local z4 = getRT(4)
            local _z4 = getT(7)
            if z4 and _z4 then
              fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment7:FindFirstChild("ClickDetector"))
            end
          until z4 == _z4
        repeat wait()
          local z5 = getRT(5)
          local _z5 = getT(10)
          if z5 and _z5 then
            fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment10:FindFirstChild("ClickDetector"))    
          end
        until z5 == _z5
        repeat wait()    
          fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment2:FindFirstChild("ClickDetector"))
          fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment5:FindFirstChild("ClickDetector"))
          fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment6:FindFirstChild("ClickDetector"))
          fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment8:FindFirstChild("ClickDetector"))
          fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment9:FindFirstChild("ClickDetector"))       
        until workspace.Map["Haunted Castle"].Tablet.Segment2.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment5.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment6.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment8.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment9.Line.Rotation.Z == 0
          elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check").Pipes == false then
            Quest1 = false;
            Quest2 = false;
            Quest3 = false;
            Quest4 = true;
           _tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.CFrame)
		   fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.ClickDetector)
		   _tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.CFrame)
		   fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
		   fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
		   fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
		   _tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.CFrame)
		   fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
		   fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
		   _tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.CFrame)
		   fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.ClickDetector)
	   	   _tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.CFrame)
		   fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
	       fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
	       fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
          end
        end
      end
    end)
  end
end)
Q = Tabs.Mirage:AddToggle("Q", {
Title = "Tự Động Farm Nguyên Liệu Guitar Linh Hồn", 
Flag = "Q_48",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoMatSoul = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.AutoMatSoul and GetWP("Skull Guitar") == false then
	    if GetM("Bones") >= 500 and GetM("Ectoplasm") >= 250 and GetM("Dark Fragment") >= 1 then
	      replicated.Remotes.CommF_:InvokeServer("soulGuitarBuy",true)
		else
		  if GetM("Ectoplasm") <= 250 then
		    if _G.AutoMatSoul and World2 then
		      local EctoTable = {"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior"}    
		      local xz = GetConnectionEnemies(EctoTable)
              if xz then repeat task.wait() Attack.Kill(xz, _G.AutoMatSoul)until not _G.AutoMatSoul or not xz.Parent or xz.Humanoid.Health <= 0
			  else replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
			  end
		    else replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
		    end
		  elseif GetM("Dark Fragment") < 1 then
		    if _G.AutoMatSoul and World2 then
		      local black = GetConnectionEnemies("Darkbeard")
		      if black then repeat task.wait()Attack.Kill(black, _G.AutoMatSoul)until _G.AutoMatSoul or black.Humanoid.Health <= 0
		      else _tp(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625))
		      end
		    else replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
			end
		     if not GetConnectionEnemies("Darkbeard") then Hop() end
	         elseif GetM("Bones") <= 500 then
		       if _G.AutoMatSoul and World3 then
			     local BonesTable = {"Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy"}
			     local zx = GetConnectionEnemies(BonesTable)			   
	             if zx then repeat task.wait()Attack.Kill(zx, _G.AutoMatSoul)until not _G.AutoMatSoul or zx.Humanoid.Health <= 0 or not zx.Parent or zx.Humanoid.Health <= 0
				 else _tp(CFrame.new(-9504.8564453125, 172.14292907714844, 6057.259765625))
			   end
		     else
		       replicated.Remotes.CommF_:InvokeServer("TravelZou")
		     end
		   end
	     end
	   end
    end)
  end
end)
Tabs.Mirage:AddButton({
Title = "Nói Chuyện Với Tảng Đá", 
Description = "",
Callback = function()
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Begin")
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Check")
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Teleport")
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Continue")
end})
Q = Tabs.Mirage:AddToggle("Q", {
Title = "Tự Động Look At Moon", 
Flag = "Q_49",
Description = "", 
Default = false,
Callback = function(Value)
  LookM = Value
end})
function MoveCamtoMoon()
workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position,Lighting:GetMoonDirection() + workspace.CurrentCamera.CFrame.Position)
plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position,Lighting:GetMoonDirection() + plr.Character.HumanoidRootPart.CFrame.Position)
end
task.spawn(function()
  while task.wait() do
    if LookM then
      MoveCamtoMoon()
      wait(.1)
      replicated.Remotes.CommE:FireServer("ActivateAbility")
    end
  end
end)


Tabs.Race:AddSection("Upgrade Races V3")
RaceMink = Tabs.Race:AddToggle("RaceMink", {
Title = "Tự Động Nâng Thỏ V3", 
Flag = "RaceMink",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Mink = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Auto_Mink then
        if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") ~= 2 then
          if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 0 then
            replicated.Remotes.CommF_:InvokeServer("Alchemist","2")
          elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 1 then
            if not plr.Backpack:FindFirstChild("Flower 1") and not plr.Character:FindFirstChild("Flower 1") then
              _tp(workspace.Flower1.CFrame)
            elseif not plr.Backpack:FindFirstChild("Flower 2") and not plr.Character:FindFirstChild("Flower 2") then
              _tp(workspace.Flower2.CFrame)
            elseif not plr.Backpack:FindFirstChild("Flower 3") and not plr.Character:FindFirstChild("Flower 3") then
              local v = GetConnectionEnemies("Swan Pirate")
              if v then repeat wait() Attack.Kill(v,_G.Auto_Mink) until GetBP("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or _G.Auto_Mink == false
              else _tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))end            
            end        
          elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 2 then
	        replicated.Remotes.CommF_:InvokeServer("Alchemist","3")
	      end
        elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 0 then
          replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","2")
        elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 1 then
		  _G.AutoFarmChest = true
	    else
	      _G.AutoFarmChest = false
        end
      end
    end)
  end
end)
RaceHuman = Tabs.Race:AddToggle("RaceHuman", {
Title = "Tự Động Nâng Human V3", 
Flag = "RaceHuman",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Human = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Auto_Human then
        if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") ~= -2 then
	     if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 0 then
		  replicated.Remotes.CommF_:InvokeServer("Alchemist","2")
		elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 1 then
		  if not plr.Backpack:FindFirstChild("Flower 1") and not plr.Character:FindFirstChild("Flower 1") then
		    _tp(workspace.Flower1.CFrame)
		  elseif not plr.Backpack:FindFirstChild("Flower 2") and not plr.Character:FindFirstChild("Flower 2") then
		    _tp(workspace.Flower2.CFrame)
		  elseif not plr.Backpack:FindFirstChild("Flower 3") and not plr.Character:FindFirstChild("Flower 3") then
		    local v = GetConnectionEnemies("Swan Pirate")
            if v then repeat wait() Attack.Kill(v,_G.Auto_Human) until plr.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or _G.Auto_Human == false
		    else _tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))end
		  end
		  elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 2 then
		    replicated.Remotes.CommF_:InvokeServer("Alchemist","3")
		  end
		  elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 0 then
		    replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","2")
		  elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 1 then
		  local v = GetConnectionEnemies(Human_v3_Mob[1])
          if v then repeat wait()Attack.Kill(v,_G.Auto_Human)until v.Humanoid.Health <= 0 or not v.Parent or not _G.Auto_Human			           
	      else _tp(CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625))
		  end		      
		  local v = GetConnectionEnemies(Human_v3_Mob[2])
          if v then repeat wait()Attack.Kill(v,_G.Auto_Human)until v.Humanoid.Health <= 0 or not v.Parent or not _G.Auto_Human			           
	      else _tp(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109))
		  end		      
		  local v = GetConnectionEnemies(Human_v3_Mob[3])
          if v then repeat wait()Attack.Kill(v,_G.Auto_Human)until v.Humanoid.Health <= 0 or not v.Parent or not _G.Auto_Human			           
          else _tp(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407))
	      end		      		
        end
      end
    end)
  end
end)
RaceSky = Tabs.Race:AddToggle("RaceSky", {
Title = "Tự Động Nâng Tộc Thiên Thần V3", 
Flag = "RaceSky",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Skypiea = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Auto_Skypiea then
        if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") ~= -2 then
	      if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 0 then
		    replicated.Remotes.CommF_:InvokeServer("Alchemist","2")
		  elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 1 then
		    if not plr.Backpack:FindFirstChild("Flower 1") and not plr.Character:FindFirstChild("Flower 1") then
		      _tp(workspace.Flower1.CFrame)
		    elseif not plr.Backpack:FindFirstChild("Flower 2") and not plr.Character:FindFirstChild("Flower 2") then
		      _tp(workspace.Flower2.CFrame)
		    elseif not plr.Backpack:FindFirstChild("Flower 3") and not plr.Character:FindFirstChild("Flower 3") then
		      local v = GetConnectionEnemies("Swan Pirate")
		      if v then
			    repeat wait()Attack.Kill(v,_G.Auto_Skypiea)until plr.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or _G.Auto_Skypiea == false
		      else
		        _tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
		      end
		    end
	      elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 2 then
            replicated.Remotes.CommF_:InvokeServer("Alchemist","3")
          end
		  elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 0 then
	        replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","2")
	    elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 1 then
	      for i,v in pairs(game.Players:GetChildren()) do
            if v.Name ~= plr.Name and tostring(v.Data.Race.Value) == "Skypiea" then
		      repeat task.wait() _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,8,0) * CFrame.Angles(math.rad(-45),0,0))until v.Humanoid.Health <= 0 or _G.Auto_Skypiea == false
	        end
	      end
        end          
      end
    end)
  end
end)
RaceFish = Tabs.Race:AddToggle("RaceFish", {
Title = "Tự Động Nâng Cá V3", 
Flag = "RaceFish",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Fish = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Auto_Fish then
        if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") ~= -2 then
	      if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 0 then
		    replicated.Remotes.CommF_:InvokeServer("Alchemist","2")
		  elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 1 then
	        if not plr.Backpack:FindFirstChild("Flower 1") and not plr.Character:FindFirstChild("Flower 1") then
		      _tp(workspace.Flower1.CFrame)
	        elseif not plr.Backpack:FindFirstChild("Flower 2") and not plr.Character:FindFirstChild("Flower 2") then
	          _tp(workspace.Flower2.CFrame)
	        elseif not plr.Backpack:FindFirstChild("Flower 3") and not plr.Character:FindFirstChild("Flower 3") then
	          local v = GetConnectionEnemies("Swan Pirate")
		      if v then
			    repeat wait()Attack.Kill(v,_G.Auto_Fish)until plr.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or _G.Auto_Fish == false
	          else
		       _tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
	          end
            end
	      elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 2 then
            replicated.Remotes.CommF_:InvokeServer("Alchemist","3")
          end
        elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 0 then
	      replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","2")
	    elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 1 then
          warn("Sea Beast Soon")
        end
      end
    end)
  end
end)



Tabs.Race:AddSection("Trials Quest V4")
CheckTier = Tabs.Race:AddParagraph({
Title = " Trạng Thái Gear V4 ",
Content = ""})
task.spawn(function()
  pcall(function()
    while task.wait(0.2) do
      CheckTier:SetDesc(" Tiers - V4  :" .." "..plr.Data.Race.C.Value)
    end
  end)
end)
PullLv = Tabs.Race:AddToggle("PullLv", {
Title = "Tự Động Gạt Cần", 
Flag = "PullLv",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Lver = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.Lver then
      pcall(function()
        for x,c in pairs(workspace.Map["Temple of Time"]:GetDescendants()) do
        if c.Name == "ProximityPrompt" then fireproximityprompt(c,math.huge)end
        end
      end)
    end
  end
end)
Train = Tabs.Race:AddToggle("Train", {
Title = "Tự Động Train V4", 
Flag = "Train",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AcientOne = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.AcientOne then
        local BonesTable = {"Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy"}
	    for i=1,#BonesTable do
          if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then
            vim1:SendKeyEvent(true, "Y", false, game)
            replicated.Remotes.CommF_:InvokeServer("UpgradeRace","Buy")
            _tp(CFrame.new(-8987.041015625, 215.862060546875, 5886.71044921875))
	      elseif plr.Character:FindFirstChild("RaceTransformed").Value == false then
	        local v = GetConnectionEnemies(BonesTable)
	        if v then repeat wait() Attack.Kill(v, _G.AcientOne) until _G.AcientOne == false or v.Humanoid.Health <= 0 or not v.Parent
		    else _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 
		    end
	      end
        end
      end
    end)
  end
end)
Tabs.Race:AddButton({
    Title = "Dịch Chuyển Đến Temple of Time", 
    Description = "",
    Callback = function()
        task.spawn(function()
            pcall(function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                -- Tọa độ cổng ngoài Temple of Time
                local doorCFrame = CFrame.new(3032.78003, 2280.85107, -7325.47803, -0.845704913, 0, -0.533651173, 0, 1, 0, 0.533651173, 0, -0.845704913)
                
                -- Tính toán thời gian bay (Tốc độ 300)
                local distance = (hrp.Position - doorCFrame.Position).Magnitude
                local speed = 280 
                local timeToReach = distance / speed
                
                local TweenService = game:GetService("TweenService")
                local tweenInfo = TweenInfo.new(timeToReach, Enum.EasingStyle.Linear)
                
                -- TẠO BODYVELOCITY ĐỂ GIỮ NGƯỜI LƠ LỬNG
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.Parent = hrp
                
                -- BẬT NOCLIP (ĐI XUYÊN TƯỜNG TRONG LÚC BAY)
                local noclip = game:GetService("RunService").Stepped:Connect(function()
                    if plr.Character then
                        for _, v in pairs(plr.Character:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                end)
                
                -- BAY TRỰC TIẾP (Bỏ qua _tp bị lỗi của Script)
                local tween = TweenService:Create(hrp, tweenInfo, {CFrame = doorCFrame})
                tween:Play()
                
                -- Đợi nhân vật bay đến nơi
                tween.Completed:Wait()
                
                -- Dọn dẹp hiệu ứng bay
                noclip:Disconnect()
                if bv then bv:Destroy() end
                
                task.wait(0.5) -- Chờ nửa giây để server đồng bộ vị trí
                
                -- ĐÃ TỚI CỔNG -> BẮN LỆNH ĐI VÀO TRONG
                if (hrp.Position - doorCFrame.Position).Magnitude <= 20 then
                    local insideVector = Vector3.new(-12538.421875, 340.893585, -7817.070801)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", insideVector)
                end
            end)
        end)
    end
})


Tabs.Race:AddButton({
Title = "Dịch Chuyển to Ancient One", 
Description = "",
Callback = function()
  notween(CFrame.new(28981.552734375, 14888.4267578125, - 120.245849609375))
end})
Tabs.Race:AddButton({
Title = "Dịch Chuyển to Ancient Clock", 
Description = "",
Callback = function()
  notween(CFrame.new(29549, 15069, -88))
end})
Doors = Tabs.Race:AddToggle("Doors", {
Title = "Tự Động Dịch Chuyển to Race Doors", 
Flag = "Doors",
Description = "", 
Default = false,
Callback = function(Value)
  _G.TPDoor = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.TPDoor then
	    if tostring(plr.Data.Race.Value) == "Mink" then
          _tp(CFrame.new(29020.66015625, 14889.4267578125, -379.2682800292969))
	    elseif tostring(plr.Data.Race.Value) == "Fishman" then
          _tp(CFrame.new(28224.056640625, 14889.4267578125, -210.5872039794922))
	    elseif tostring(plr.Data.Race.Value) == "Cyborg" then
          _tp(CFrame.new(28492.4140625, 14894.4267578125, -422.1100158691406))
	    elseif tostring(plr.Data.Race.Value) == "Skypiea" then
          _tp(CFrame.new(28967.408203125, 14918.0751953125, 234.31198120117188))
	    elseif tostring(plr.Data.Race.Value) == "Ghoul" then
          _tp(CFrame.new(28672.720703125, 14889.1279296875, 454.5961608886719))
	    elseif tostring(plr.Data.Race.Value) == "Human" then
          _tp(CFrame.new(29237.294921875, 14889.4267578125, -206.94955444335938))
	    end
      end
    end)
  end
end)                   
Q = Tabs.Race:AddToggle("Q", {
    Title = "Tự Động Hoàn Thành Trial Race",
    Default = false,
    Callback = function(Value)
        _G.Complete_Trials = Value
    end
})

GetSeaBeastTrial = function()
  if not workspace.Map:FindFirstChild("FishmanTrial") then return nil end
  if workspace["_WorldOrigin"].Locations:FindFirstChild("Trial of Water") then FishmanTrial = workspace["_WorldOrigin"].Locations:FindFirstChild("Trial of Water") end
  if FishmanTrial then
    for _,v in next, workspace.SeaBeasts:GetChildren() do
      if v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - FishmanTrial.Position).Magnitude <= 1500 then
      if v.Health.Value > 0 then return v end
      end
    end
  end
end
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Complete_Trials then
        if tostring(plr.Data.Race.Value) == "Mink" then
          notween(workspace.Map.MinkTrial.Ceiling.CFrame * CFrame.new(0,-20,0))
	   end
      end
    end)
  end
end)
task.spawn(function()
  while task.wait(Sec) do
    pcall(function() 
      if _G.Complete_Trials then
	    if tostring(plr.Data.Race.Value) == "Fishman" then
	      if GetSeaBeastTrial() then            
            repeat task.wait()
              task.spawn(function()_tp(CFrame.new(GetSeaBeastTrial().HumanoidRootPart.Position.X,game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 300,GetSeaBeastTrial().HumanoidRootPart.Position.Z))end)
		      MousePos = GetSeaBeastTrial().HumanoidRootPart.Position
              Useskills("Melee","Z")
	          Useskills("Melee","X")
	          Useskills("Melee","C")
              wait(.1)
              Useskills("Sword","Z")
              Useskills("Sword","X")
              wait(.1)
              Useskills("Blox Fruit","Z")
              Useskills("Blox Fruit","X")
              Useskills("Blox Fruit","C")
              wait(.1)
              Useskills("Gun","Z")
              Useskills("Gun","X")
            until _G.Complete_Trials == false or not GetSeaBeastTrial()
          end          
	    end
      end
    end)
  end
end)
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Complete_Trials then
        if tostring(plr.Data.Race.Value) == "Cyborg" then
         _tp(workspace.Map.CyborgTrial.Floor.CFrame * CFrame.new(0,500,0))
   	   end
      end
    end)
  end
end)
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Complete_Trials then
        if tostring(plr.Data.Race.Value) == "Skypiea" then
          notween(workspace.Map.SkyTrial.Model.FinishPart.CFrame)
  	   end
      end
    end)
  end
end)
task.spawn(function()
  while task.wait(0.1) do   
    pcall(function()
      if _G.Complete_Trials then
	    if tostring(plr.Data.Race.Value) == "Human" or tostring(plr.Data.Race.Value) == "Ghoul" then	      
	      local TrialsTables = {"Ancient Vampire","Ancient Zombie"}
	      local v = GetConnectionEnemies(TrialsTables)
          if v then repeat wait() Attack.Kill(v, _G.Complete_Trials)until _G.Complete_Trials == false or not v.Parent or v.Humanoid.Health <= 0 end		
        end
      end
    end)
  end
end)
AutoKill = Tabs.Race:AddToggle("AutoKill", {
Title = "Tự Động Giết Người Chơi", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Defeating = Value
end})
spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Defeating then
	    for _, v in pairs(workspace.Characters:GetChildren()) do
          if v.Name ~= plr.Name then
            if v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and v.Parent and (Root.Position - v.HumanoidRootPart.Position).Magnitude <= 250 then
              repeat task.wait() EquipWeapon(_G.SelectWeapon) _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,0,15)) sethiddenproperty(plr, "SimulationRadius", math.huge)until _G.Defeating == false or v.Humanoid.Health <= 0 or not v.Parent or not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid")
            end
          end
        end
      end
    end)
  end
end)

Tabs.Drago:AddSection("Dojo Quest & Drago Race")
DojoQ = Tabs.Drago:AddToggle("DojoQ", {
Title = "Tự Động Lấy Đai", 
Flag = "DojoQ",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Dojoo = Value
end})
function printBeltName(data) if type(data) == "table" and data.Quest["BeltName"] then return data.Quest["BeltName"] end end
task.spawn(function()
  while task.wait(Sec) do
    if _G.Dojoo then
      pcall(function()
        local args = {[1] = {["NPC"] = "Dojo Trainer",["Command"] = "RequestQuest"}}        
        local progress = replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
        local NameBelt = printBeltName(progress)
        if debug == false and not progress and not NameBelt then
          _tp(CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875))
          debug = true
        elseif debug == true and (CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 50 then
          if NameBelt == "White" then
            local v = GetConnectionEnemies("Skull Slayer")
            if v then repeat task.wait() Attack.Kill(v, _G.Dojoo) until not progress or not _G.Dojoo or not Attack.Alive(v)
            else _tp(CFrame.new(-16759.58984375, 71.28376770019531, 1595.3399658203125))
            end
          elseif NameBelt == "Yellow" then
            repeat task.wait()
              _G.SeaBeast1 = true
              _G.TerrorShark = true
              _G.Shark = true
              _G.Piranha = true
              _G.MobCrew = true
              _G.FishBoat = true
              _G.SailBoats = true
            until not _G.Dojoo or not progress
            _G.SeaBeast1 = false
            _G.TerrorShark = false
            _G.Shark = false
            _G.Piranha = false
            _G.MobCrew = false
            _G.FishBoat = false
            _G.SailBoats = false               
          elseif NameBelt == "Green" then
            repeat task.wait()
              _G.SailBoats = true
            until not _G.Dojoo or not progress
            _G.SailBoats = false
          elseif NameBelt == "Purple" then
            repeat task.wait()
              _G.FarmEliteHunt = true
            until not _G.Dojoo or not progress
            _G.FarmEliteHunt = false
          elseif NameBelt == "Red" then
            repeat task.wait()
              _G.SailBoats = true
              _G.FishBoat = true
            until not _G.Dojoo or not progress
            _G.SailBoats = false
            _G.FishBoat = false                      
          elseif NameBelt == "Black" then
            repeat task.wait()              
              if workspace.Map:FindFirstChild("PrehistoricIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then    
                _G.Prehis_Find = true                   
                if workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt",true) then
                  _G.Prehis_Skills = false
                  _G.Prehis_Find = true
                else
                  _G.Prehis_Skills = true
                  _G.Prehis_Find = false
                end
              else
                _G.Prehis_Find = true
                _G.Prehis_Skills = false
              end
            until not _G.Dojoo or not progress
            _G.Prehis_Find = false
            _G.Prehis_Skills = false                        
          elseif NameBelt == "Orange" or NameBelt == "Blue" then
            return nil
          end
        end
        if not progress then
          debug = false
          local args = {[1] = {["NPC"] = "Dojo Trainer",["Command"] = "ClaimQuest"}}
          replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
        end
      end)
    end
  end
end)
BlazeEM = Tabs.Drago:AddToggle("BlazeEM", {
Title = "Tự Động Dragon Hunter", 
Flag = "BlazeEM",
Description = "", 
Default = false,
Callback = function(Value)
  _G.FarmBlazeEM = Value
end})
checkQuesta=function()local a={[1]={["Context"]="Check"}}local b=nil;pcall(function()local c={[1]={["Context"]="RequestQuest"}}game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack(c))end)local d,e=pcall(function()b=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack(a))end)local f=false;local g;local h;local i;if b then if b.Text then f=true;local j=b.Text;if string.find(tostring(j),"Defeat")then i=1;g=string.sub(tostring(j),8,9)g=tonumber(g)local k={"Hydra Enforcer","Venomous Assailant"}for l,m in pairs(k)do if string.find(j,m)then h=m;break end end elseif string.find(tostring(j),"Destroy")then g=10;i=2;h=nil end end end;return f,h,g,i end
BackTODoJo=function()for a,b in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren())do if b.Name=="NotificationTemplate"then if string.find(b.Text,"Head back to the Dojo to complete more tasks")then return true end end end;return false end
DragonMobClear=function(a,b,c)if workspace.Enemies:FindFirstChild(b)then for d,e in pairs(workspace.Enemies:GetChildren())do if e.Name==b and Attack.Alive(e)then if a then Attack.Kill(e,a)end end end else _tp(c)end end
task.spawn(function()
  while task.wait(0.1) do 
    if _G.FarmBlazeEM then
      pcall(function()              
        local a,v,h,x = checkQuesta()                  
        if a == true and not BackTODoJo() then
          if x == 1 then
            if v == "Hydra Enforcer" or v == "Venomous Assailant" then            
              repeat wait()
                DragonMobClear(true, v, CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219))
              until not _G.FarmBlazeEM or not a or BackTODoJo()                            
            end      
          elseif x == 2 then
            if workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true) then
              repeat wait()                
                task.spawn(function() _tp(workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).CFrame * CFrame.new(4,0,0)) end)
                if (workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).Position - Root.Position).Magnitude <= 200 then
                MousePos = workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).Position
                Useskills("Melee","Z")
	            Useskills("Melee","X")
	            Useskills("Melee","C")
                wait(.5)
                Useskills("Sword","Z")
                Useskills("Sword","X")
                wait(.5)
                Useskills("Blox Fruit","Z")
                Useskills("Blox Fruit","X")
                Useskills("Blox Fruit","C")
                wait(.5)
                Useskills("Gun","Z")
                Useskills("Gun","X")
                end
              until not _G.FarmBlazeEM or not a or BackTODoJo()
            end
          end
        else
          _tp(CFrame.new(5813, 1208, 884))
          DragonMobClear(false, nil, nil) 
        end
      end)
    end
  end
end)
task.spawn(function()
  while task.wait(0.1) do 
    if _G.FarmBlazeEM then
      pcall(function()              
        if workspace.EmberTemplate:FindFirstChild("Part") then
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.EmberTemplate.Part.CFrame        
        end
      end)
    end
  end
end)

Tabs.Drago:AddSection("Drago Trial")
GetQuestDracoLevel = function()
  local v371 = {[1] = {NPC = "Dragon Wizard",Command = "Upgrade"}};
  return replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(v371))
end
Toggle = Tabs.Drago:AddToggle("Toggle", {
Title = "Tween To Upgrade Droco Trial", 
Flag = "Toggle_2",
Description = "", 
Default = false,
Callback = function(Value)
  _G.UPGDrago = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.UPGDrago then     
        if GetQuestDracoLevel() == false then
          return nil
        elseif GetQuestDracoLevel() == true then
          if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938).Position - Root.Position).Magnitude >= 300 then
            _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938));
          else
            _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938));
            local v371 = {[1] = {NPC = "Dragon Wizard",Command = "Upgrade"}};
            replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(v371));
          end
        end
      end
    end)
  end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
Title = "Tự Động Nâng Tộc Drago (V1)", 
Flag = "Toggle_3",
Description = "", 
Default = false,
Callback = function(Value)
  _G.DragoV1 = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.DragoV1 then     
        if GetM("Dragon Egg") <= 0 then
        repeat wait()
          _G.Prehis_Find = true
          _G.Prehis_Skills = true
          _G.Prehis_DE = true
        until not _G.DragoV1 or GetM("Dragon Egg") >= 1
          _G.Prehis_Find = false
          _G.Prehis_Skills = false
          _G.Prehis_DE = false
        end
      end
    end)
  end
end)
fireflower = Tabs.Drago:AddToggle("fireflower", {
Title = "Tự Động Nâng Tộc Drago (V2)", 
Flag = "fireflower",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoFireFlowers = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.AutoFireFlowers then
      local FireFlower = workspace:FindFirstChild("FireFlowers")
      local v = GetConnectionEnemies("Forest Pirate")
      if v then repeat wait() Attack.Kill(v,_G.AutoFireFlowers) until not _G.AutoFireFlowers or not v.Parent or v.Humanoid.Health <= 0 or FireFlower
      else _tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
      end      
      if FireFlower then
        for i, v in pairs(FireFlower:GetChildren()) do
          if (v:IsA("Model") and v.PrimaryPart) then
            local FlowerPos = v.PrimaryPart.Position;
            local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
            local Magnited = (FlowerPos - playerRoot).Magnitude;
            if (Magnited <= 100) then
              vim1:SendKeyEvent(true, "E", false, game) wait(1.5) vim1:SendKeyEvent(false, "E", false, game)
            else
              _tp(CFrame.new(FlowerPos));
            end
          end
        end
      end
    end
  end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
Title = "Tự Động Nâng Tộc Drago (V3)", 
Flag = "Toggle_4",
Description = "", 
Default = false,
Callback = function(Value)
  _G.DragoV3 = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.DragoV3 then     
        repeat wait()
          _G.DangerSc = "Lv Infinite"
          _G.SailBoats = true
          _G.TerrorShark = true
        until not _G.DragoV3
        _G.DangerSc = "Lv 1"
        _G.SailBoats = false
        _G.TerrorShark = false
      end
    end)
  end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
Title = "Tự Động Thắp Đèn V4 [Thử Nghiệm]", 
Flag = "Toggle_5",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Relic123 = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.Relic123 then
      pcall(function()
        if workspace.Map:FindFirstChild("DracoTrial") then
          replicated.Remotes.DracoTrial:InvokeServer()                  
          wait(.5)
          repeat wait() _tp(CFrame.new(-39934.9765625, 10685.359375, 22999.34375)) until not _G.Relic123 or (Root.Position == CFrame.new(-39934.9765625, 10685.359375, 22999.34375).Position)
          repeat wait() _tp(CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625)) until not _G.Relic123 or (Root.Position == CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625).Position)
          wait(2.5)
          repeat wait() _tp(CFrame.new(-39914.65625, 10685.384765625, 23000.177734375)) until not _G.Relic123 or (Root.Position == CFrame.new(-39914.65625, 10685.384765625, 23000.177734375).Position)
          repeat wait() _tp(CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375)) until not _G.Relic123 or (Root.Position == CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375).Position)
          wait(2.5)
          repeat wait() _tp(CFrame.new(-39908.5, 10685.4052734375, 22990.04296875)) until not _G.Relic123 or (Root.Position == CFrame.new(-39908.5, 10685.4052734375, 22990.04296875).Position)
          repeat wait() _tp(CFrame.new(-39609.5, 9376.400390625, 23472.94335975)) until not _G.Relic123 or (Root.Position == CFrame.new(-39609.5, 9376.400390625, 23472.94335975).Position) 
        else
          local drago = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")
          if drago and drago:IsA("Part") then _tp(CFrame.new(drago.Position)) end        
        end
      end)
    end
  end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
Title = "Tự Động Train Drago v4", 
Flag = "Toggle_6",
Description = "", 
Default = false,
Callback = function(Value)
  _G.TrainDrago = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.TrainDrago then
        local DragoM = {"Venomous Assailant","Hydra Enforcer"}
	    for i=1,#DragoM do
          if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then
            vim1:SendKeyEvent(true, "Y", false, game)
            replicated.Remotes.CommF_:InvokeServer("UpgradeRace","Buy",2)
            _tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219))
	      elseif plr.Character:FindFirstChild("RaceTransformed").Value == false then
	        local v = GetConnectionEnemies(DragoM)
	        if v then repeat wait() Attack.Kill(v, _G.TrainDrago) until _G.TrainDrago == false or v.Humanoid.Health <= 0 or not v.Parent                    		
		    else _tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219))
		    end
	      end
        end
      end
    end)
  end
end)
dragoTpVolcano = Tabs.Drago:AddToggle("dragoTpVolcano", {
Title = "Bay Đến Nơi Up Tộc Rồng V4", 
Flag = "dragoTpVolcano",
Description = "", 
Default = false,
Callback = function(Value)
  _G.TpDrago_Prehis = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.TpDrago_Prehis then
      local v748 = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport");
      if (v748 and v748:IsA("Part")) then _tp(CFrame.new(v748.Position)) end
    end
  end
end)
bdrago = Tabs.Drago:AddToggle("bdrago", {
Title = "Chuyển Đổi Tộc Rồng", 
Flag = "bdrago",
Description = "", 
Default = false,
Callback = function(Value)
  _G.BuyDrago = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.BuyDrago then
      pcall(function()
        if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938).Position - Root.Position).Magnitude >= 300 then
          _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938));
        else
          _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938));
          local v371 = {[1] = {NPC = "Dragon Wizard",Command = "DragonRace"}};
          replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(v371));
        end
      end)
    end
  end
end)
UpTalon = Tabs.Drago:AddToggle("UpTalon", {
Title = "Nâng Cấp Dragon Talon V3", 
Flag = "UpTalon",
Description = "", 
Default = false,
Callback = function(Value)
  _G.DT_Uzoth = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.DT_Uzoth then
      local Uz_POS = CFrame.new(5661.89014, 1211.31909, 864.836731, 0.811413169, -1.36805838e-08, -0.584473014, 4.75227395e-08, 1, 4.25682458e-08, 0.584473014, -6.23161966e-08, 0.811413169)
      _tp(Uz_POS)
      if (Uz_POS.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 25 then
        local ohTable1 = {["NPC"] = "Uzoth",["Command"] = "Upgrade"}
        replicated.Modules.Net["RF/InteractDragonQuest"]:InvokeServer(ohTable1)
      end
    end
  end
end)

Tabs.Prehistoric:AddSection("Volcanic Magnet")

Toggle = Tabs.Prehistoric:AddToggle("Toggle", {
    Title = "Tự Động Chế Tạo Volcanic Magnet",
    Flag = "Toggle_7",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.CraftVM = Value
end})

Tabs.Prehistoric:AddButton({
    Title = "Chế Tạo Volcanic Magnet",
    Description = "",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
    end
})


local function AutoCraftVolcanicMagnet()
    replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
    task.wait(1.5) 
end


task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if _G.CraftVM then
                AutoCraftVolcanicMagnet()
            end
        end)
    end
end)
Tabs.Prehistoric:AddSection("Prehistoric Island")
Check_Volcano = Tabs.Prehistoric:AddParagraph({
Title = " Trạng Thái Đảo Tiền Sử",
Content = ""})
task.spawn(function()
  while task.wait(0.2) do
    if workspace.Map:FindFirstChild("PrehistoricIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
      Check_Volcano:SetDesc(" Prehistoric Island : True")
    else
      Check_Volcano:SetDesc(" Prehistoric Island : False")
    end
  end
end)
Vocan = Tabs.Prehistoric:AddToggle("Vocan", {
Title = "Tự Động Tìm Đảo Rồng", 
Flag = "Vocan",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Prehis_Find = Value
end
})
targetDestination = nil
task.spawn(function()
  while task.wait(0.1) do
    if _G.Prehis_Find then 
      pcall(function()
        if not workspace["_WorldOrigin"].Locations:FindFirstChild("Prehistoric Island", true) then                
          local myBoat = CheckBoat()
          if not myBoat then
            local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
            TeleportToTarget(buyBoatCFrame)
            if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) end
          else
            if plr.Character.Humanoid.Sit == false then
              local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
              _tp(boatSeatCFrame)
            else                            
              repeat wait() 
                local targetDestination = CFrame.new(-10000000, 31, 37016.25)
                if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
                  _tp(CFrame.new(-10000000, 150, 37016.25))
                else
                  _tp(CFrame.new(-10000000, 31, 37016.25))
                end
              until not _G.Prehis_Find or (targetDestination.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace["_WorldOrigin"].Locations:FindFirstChild("Prehistoric Island") or plr.Character.Humanoid.Sit == false plr.Character.Humanoid.Sit = false
            end
          end
        else
          if (workspace["_WorldOrigin"].Locations:FindFirstChild("Prehistoric Island").CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 then _tp(workspace["_WorldOrigin"].Locations:FindFirstChild("Prehistoric Island").CFrame)end
          if workspace.Map:FindFirstChild("PrehistoricIsland", true) or workspace["_WorldOrigin"].Locations:FindFirstChild("Prehistoric Island", true) then            
            if workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt", true) then
              if plr:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame.Position) <= 150 then
                fireproximityprompt(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt, math.huge)
                vim1:SendKeyEvent(true, "E", false, game) wait(1.5) vim1:SendKeyEvent(false, "E", false, game)
              end
              _tp(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)              
            end
          end
        end
      end)
    end
  end
end)
Tabs.Prehistoric:AddButton({
    Title = "Xoá Dung Nham Đảo Rồng",
    Callback = function()
        for i, v in pairs(game.Workspace:GetDescendants()) do
            if v.Name == "Lava" then
                v:Destroy()
            end
        end
        for i, v in pairs(game.ReplicatedStorage:GetDescendants()) do
            if v.Name == "Lava" then
                v:Destroy()
            end
        end
    end
})
Patch = Tabs.Prehistoric:AddToggle("Patch", {
Title = "Tự Động Kích Hoạt Đầu Lâu", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.Prehis_Skills = Value
end
})
task.spawn(function()
  while task.wait(0.1) do
    if _G.Prehis_Skills then
      local prehistoricIsland = game.Workspace.Map:FindFirstChild("PrehistoricIsland")
      if prehistoricIsland then
        for _, obj in pairs(prehistoricIsland:GetDescendants()) do
        if obj:IsA("Part") and obj.Name:lower():find("lava") then obj:Destroy() end
        if obj:IsA("MeshPart") and obj.Name:lower():find("lava") then obj:Destroy() end
        end
        local lavaModel = game.Workspace.Map.PrehistoricIsland.Core:FindFirstChild("InteriorLava")
        if lavaModel and lavaModel:IsA("Model") then lavaModel:Destroy() end
        local Island = workspace.Map:FindFirstChild("PrehistoricIsland")
        if Island then   
          local trialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")   
          for _, v in pairs(Island:GetDescendants()) do
            if v.Name == "TouchInterest" then
              if not (trialTeleport and v:IsDescendantOf(trialTeleport)) then
                v.Parent:Destroy()
              end
            end
          end
        end  
      end
    end
  end
end)
task.spawn(function()
  while task.wait(0.1) do
    pcall(function()
      if _G.Prehis_Skills then
        if workspace.Enemies:FindFirstChild("Lava Golem") then
          local v = GetConnectionEnemies("Lava Golem")
          if v then repeat wait()Attack.Kill(v,_G.Prehis_Skills) v.Humanoid:ChangeState(15)until not _G.Prehis_Skills or not v.Parent or v.Humanoid.Health <= 0 end
        end
        for i,v in pairs(game.Workspace.Map.PrehistoricIsland.Core.VolcanoRocks:GetChildren()) do
          if v:FindFirstChild("VFXLayer") then
            if v:FindFirstChild("VFXLayer").At0.Glow.Enabled == true or v.VFXLayer.At0.Glow.Enabled == true then
              repeat wait()
                _tp(v.VFXLayer.CFrame)
                if v.VFXLayer.At0.Glow.Enabled == true and plr:DistanceFromCharacter(v.VFXLayer.CFrame.Position) <= 150 then
                  MousePos = v.VFXLayer.CFrame.Position
                  Useskills("Melee","Z") wait(.5)
          	      Useskills("Melee","X") wait(.5)
	              Useskills("Melee","C") wait(.5)
                  Useskills("Blox Fruit","Z") wait(.5)
                  Useskills("Blox Fruit","X") wait(.5)
                  Useskills("Blox Fruit","C")
                end   
              until not _G.Prehis_Skills or v:FindFirstChild("VFXLayer").At0.Glow.Enabled == false or v.VFXLayer.At0.Glow.Enabled == false            
            end
          end
        end
      end
    end)
  end
end)
Kaura = Tabs.Prehistoric:AddToggle("Kaura", {
    Title = "Kill Aura",
    Flag = "Kaura",
    Description = "",
    Default = false,
    Callback = function(Value)
    _G.KillAuraFull = Value
end})

Range = 500
Delay = 2   

task.spawn(function()
    while task.wait(Delay) do
        if _G.KillAuraFull then
            pcall(function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                sethiddenproperty(plr, "SimulationRadius", math.huge)

                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
                        local dist = (enemy.HumanoidRootPart.Position - hrp.Position).Magnitude
                        if dist <= Range and enemy.Humanoid.Health > 0 then
                            enemy.Humanoid.Health = 0
                            enemy.HumanoidRootPart.CanCollide = false
                            enemy:BreakJoints()
                        end
                    end
                end
            end)
        end
    end
end)
Vocan = Tabs.Prehistoric:AddToggle("Vocan", {
Title = "Tự Động Lụm Xương Rồng", 
Flag = "Vocan_2",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Prehis_DB = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Prehis_DB then
        if workspace:FindFirstChild("DinoBone") then
          for i,v in pairs(workspace:GetChildren()) do
            if v.Name == "DinoBone" then _tp(v.CFrame) end
          end
        end
      end
    end)
  end
end)
Vocan = Tabs.Prehistoric:AddToggle("Vocan", {
Title = "Tự Động Lụm Trứng Rồng", 
Flag = "Vocan_3",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Prehis_DE = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Prehis_DE then
      if workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg") then _tp(workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg").Molten.CFrame) fireproximityprompt(workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs.DragonEgg.Molten.ProximityPrompt, 30) end        
      end
    end)
  end
end)
Toggle = Tabs.Prehistoric:AddToggle("Toggle", {
Title = "Tự Động Chết Khi Hoàn Thành Đảo Rồng", 
Flag = "Toggle_8",
Description = "", 
Default = false,
Callback = function(Value)
  _G.ResetPH = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.ResetPH then
        local v748 = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport");
        if (v748 and v748:FindFirstChild("TouchInterest")) then
          plr.Character.Humanoid.Health = 0 
        else
          if workspace:FindFirstChild("DinoBone") then
            for i,v in pairs(workspace:GetChildren()) do
              if v.Name == "DinoBone" then _tp(v.CFrame) end
            end
          end
        end
      end
    end)
  end
end)

Tabs.SeaEvent:AddSection("Sea Event / Setting Sail")
ListSeaBoat={"Guardian","PirateGrandBrigade","MarineGrandBrigade","PirateBrigade","MarineBrigade","PirateSloop","MarineSloop","Beast Hunter"}
ListSeaZone={"Lv 1","Lv 2","Lv 3","Lv 4","Lv 5","Lv 6","Lv Infinite"}
SPYING = Tabs.SeaEvent:AddParagraph({
Title = " Trạng Thái Điệp Viên",
Content = ""})
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()
      local spycheck = string.match(replicated.Remotes.CommF_:InvokeServer("InfoLeviathan","1"),"%d+")
      if spycheck then SPYING:SetDesc(" Spy Leviathan  : "..tostring(spycheck))
        if tostring(spycheck) == 5 then
          SPYING:SetDesc(" Spy Leviathan : Already Done!!")
        end
      end
    end)
  end
end)
Tabs.SeaEvent:AddButton({
Title = "Mua Chuộc Điệp Viên", 
Description = "",
Callback = function()
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("InfoLeviathan","2")
end})
FloD = Tabs.SeaEvent:AddParagraph({
Title = " Trạng Thái Đảo Leviathan",
Content = ""})
task.spawn(function()
  pcall(function()
    while task.wait(0.2) do
      if workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') then
        FloD:SetDesc(' Flozen Dimension : True')
      else
        FloD:SetDesc(' Flozen Dimension : False')
      end
    end
  end)
end)
Q = Tabs.SeaEvent:AddToggle("Q", {
Title = "Tự Động Dịch Chuyển Đến Frozen Dimension", 
Flag = "Q_50",
Description = "", 
Default = false,
Callback = function(Value)
  _G.FrozenTP = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.FrozenTP then
      pcall(function()
      if workspace.Map:FindFirstChild("LeviathanGate") then _tp(workspace.Map.LeviathanGate.CFrame) replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("OpenLeviathanGate") end
      end)
    end
  end
end)
Q = Tabs.SeaEvent:AddToggle("Q", {
Title = "Tự Động Lái Thuyền Tới Hydra Island", 
Flag = "Q_51",
Description = "", 
Default = false,
Callback = function(Value)
  _G.SailBoat_Hydra = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.SailBoat_Hydra then 
      pcall(function()        
        local myBoat = CheckBoat()
        if not myBoat then
          local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
          TeleportToTarget(buyBoatCFrame)
          if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) end
        elseif myBoat then
          if plr.Character.Humanoid.Sit == false then
            local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
            _tp(boatSeatCFrame)
          else                         
            repeat wait() 
              if CheckEnemiesBoat() or CheckPirateGrandBrigade() or CheckTerrorShark() then
                _tp(CFrame.new(5433, 150, 290))
              else
                _tp(CFrame.new(5433, 35, 290))
              end           
            until _G.SailBoat_Hydra==false or plr.Character:WaitForChild("Humanoid").Sit==false plr.Character.Humanoid.Sit = false
          end
        end
      end)
    end
  end
end)

Tabs.SeaEvent:AddButton({
Title = "Mua Thuyền", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyBoat",_G.SelectedBoat)
end})


local SEA_MOB_MAP = {
    AutoSharkEnabled       = { names = {"Shark"},                                folder = "Enemies"   },
    AutoPiranhaEnabled     = { names = {"Piranha"},                              folder = "Enemies"   },
    AutoTerrorSharkEnabled = { names = {"Terrorshark"},                          folder = "Enemies"   },
    AutoFishCrewEnabled    = { names = {"Fish Crew Member"},                     folder = "Enemies"   },
    AutoHauntedCrewEnabled = { names = {"Haunted Crew Member"},                  folder = "Enemies"   },
    AutoPirateGrandEnabled = { names = {"PirateGrandBrigade","PirateBrigade"},   folder = "Enemies",   isBoat = true },
    AutoFishBoatEnabled    = { names = {"FishBoat"},                             folder = "Enemies",   isBoat = true },
    AutoSeaBeastEnabled    = { names = {"SeaBeast1","SeaBeast"},                 folder = "SeaBeasts", isSeaBeast = true },
}

local SEA_MELEE_MOB_NAMES = {
    ["Shark"]               = true,
    ["Piranha"]             = true,
    ["TerrorShark"]         = true,
    ["FishCrewMember"]      = true,
    ["HauntedCrewMember"]   = true,
}

local WEAPON_SKILLS = {
    ["Melee"]      = {"Z", "X", "C"},
    ["Sword"]      = {"Z", "X"},
    ["Blox Fruit"] = {"Z", "X", "C"},
    ["Gun"]        = {"Z", "X"},
}
local WEAPON_TYPES = {"Melee", "Sword", "Blox Fruit", "Gun"}

local BUY_BOAT_CFRAME = CFrame.new(-16927.451, 12, 433.864)

local SEA_ZONE_CFRAMES = {
    ["Lv 1"]        = CFrame.new(-21998.375,  35, -682.309143),
    ["Lv 2"]        = CFrame.new(-26779.5215, 35, -822.858032),
    ["Lv 3"]        = CFrame.new(-31171.957,  35, -2256.93774),
    ["Lv 4"]        = CFrame.new(-34054.6875, 35, -2560.12012),
    ["Lv 5"]        = CFrame.new(-38887.5547, 35, -2162.99023),
    ["Lv 6"]        = CFrame.new(-44541.7617, 35, -1244.8584),
    ["Lv Infinite"] = CFrame.new(-10000000,   35,  37016.25),
}

local sea_noclipConn = nil
local function SeaSetNoclip(enabled)
    if enabled then
        if sea_noclipConn then return end
        sea_noclipConn = RunService.Stepped:Connect(function()
            local char = plr.Character
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    else
        if sea_noclipConn then sea_noclipConn:Disconnect() sea_noclipConn = nil end
    end
end

local sea_bvLoopConn = nil
local function SeaSetBodyVelocity(enabled)
    if enabled then
        if sea_bvLoopConn then return end
        sea_bvLoopConn = RunService.Heartbeat:Connect(function()
            local char = plr.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local bv = hrp:FindFirstChild("SeaFarmBV")
            if not bv then
                bv        = Instance.new("BodyVelocity")
                bv.Name   = "SeaFarmBV"
                bv.Parent = hrp
            end
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.P        = 9999
        end)
    else
        if sea_bvLoopConn then sea_bvLoopConn:Disconnect() sea_bvLoopConn = nil end
        local char = plr.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bv = hrp:FindFirstChild("SeaFarmBV")
                if bv then bv:Destroy() end
            end
        end
    end
end

local function SeaEquipWeapon(weaponName)
    if not weaponName then return end
    local char = plr.Character
    if not char then return end
    local equipped = char:FindFirstChildOfClass("Tool")
    if equipped and equipped.Name == weaponName then return end
    local tool = plr.Backpack:FindFirstChild(weaponName)
    if tool then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum:EquipTool(tool) end
    end
end

local sea_weaponLoopConn = nil
local function SeaStartWeaponLoop(getWeaponFn)
    if sea_weaponLoopConn then sea_weaponLoopConn:Disconnect() sea_weaponLoopConn = nil end
    local lastEquip = 0
    sea_weaponLoopConn = RunService.Heartbeat:Connect(function()
        if (tick() - lastEquip) < 0.15 then return end
        lastEquip = tick()
        pcall(function()
            local wName = getWeaponFn()
            if wName then SeaEquipWeapon(wName) end
        end)
    end)
end

local function SeaStopWeaponLoop()
    if sea_weaponLoopConn then sea_weaponLoopConn:Disconnect() sea_weaponLoopConn = nil end
end

local function SeaGetWeaponForMob(genvKey)
    local data = SEA_MOB_MAP[genvKey]
    if not data then return nil end
    if (data.isSeaBeast or data.isBoat) and getgenv().AutoM1FruitEnabled then
        local char = plr.Character
        if char then
            for _, v in ipairs(plr.Backpack:GetChildren()) do
                if v.ToolTip == "Blox Fruit" then return v.Name end
            end
            local eq = char:FindFirstChildOfClass("Tool")
            if eq and eq.ToolTip == "Blox Fruit" then return eq.Name end
        end
        return nil
    end
    if SEA_MELEE_MOB_NAMES[genvKey] or (data and not data.isBoat and not data.isSeaBeast) then
        return _G.SelectWeapon
    end
    return nil
end

local sea_skillSpamThread = nil
local function SeaStartSkillSpamLoop(stopFn)
    if sea_skillSpamThread then task.cancel(sea_skillSpamThread) sea_skillSpamThread = nil end
    sea_skillSpamThread = task.spawn(function()
        local prevWeapon = nil
        while not stopFn() do
            if getgenv().AutoM1FruitEnabled then
                weaponSc("Blox Fruit")
                task.wait(0.1)
            else
                local available = {}
                for _, w in ipairs(WEAPON_TYPES) do
                    if w ~= prevWeapon then table.insert(available, w) end
                end
                local chosenWeapon = available[math.random(#available)]
                prevWeapon = chosenWeapon
                local skills = WEAPON_SKILLS[chosenWeapon]
                local deadline = tick() + 0.3
                local si = 1
                while not stopFn() and tick() < deadline do
                    if getgenv().AutoM1FruitEnabled then break end
                    pcall(Useskills, chosenWeapon, skills[si])
                    si = (si % #skills) + 1
                    task.wait(0.1)
                end
            end
        end
    end)
end

local function SeaStopSkillSpamLoop()
    if sea_skillSpamThread then task.cancel(sea_skillSpamThread) sea_skillSpamThread = nil end
end

--// ===================================================================
--//              SEA EVENT: BOAT FUNCTIONS
--// ===================================================================

local function SeaGetBoatRoot(boat)
    if not boat then return nil end
    return boat:FindFirstChild("Engine") or boat.PrimaryPart or boat:FindFirstChildWhichIsA("VehicleSeat", true)
end

local sea_boatNoclipConn = nil
local function SeaSetBoatNoclip(boat, enabled)
    if enabled then
        if sea_boatNoclipConn then sea_boatNoclipConn:Disconnect() sea_boatNoclipConn = nil end
        sea_boatNoclipConn = RunService.Stepped:Connect(function()
            if not boat or not boat.Parent then sea_boatNoclipConn:Disconnect() sea_boatNoclipConn = nil return end
            for _, p in ipairs(boat:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end)
    else
        if sea_boatNoclipConn then sea_boatNoclipConn:Disconnect() sea_boatNoclipConn = nil end
    end
end

local sea_boatBvConn = nil
local function SeaSetBoatBodyVelocity(boat, enabled)
    if enabled then
        if sea_boatBvConn then sea_boatBvConn:Disconnect() sea_boatBvConn = nil end
        sea_boatBvConn = RunService.Heartbeat:Connect(function()
            if not boat or not boat.Parent then sea_boatBvConn:Disconnect() sea_boatBvConn = nil return end
            local root = SeaGetBoatRoot(boat)
            if not root then return end
            local bv = root:FindFirstChild("SeaBoatBV")
            if not bv then
                bv = Instance.new("BodyVelocity")
                bv.Name = "SeaBoatBV"
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.MaxForce = Vector3.new(0, math.huge, 0)
                bv.P = 9999
                bv.Parent = root
            end
        end)
    else
        if sea_boatBvConn then sea_boatBvConn:Disconnect() sea_boatBvConn = nil end
        if boat and boat.Parent then
            local root = SeaGetBoatRoot(boat)
            if root then local bv = root:FindFirstChild("SeaBoatBV") if bv then bv:Destroy() end end
        end
    end
end

local sea_boatTweenConn    = nil
local sea_boatTweenRunning = false

local function SeaTweenBoatTo(boat, targetCF, callback)
    sea_boatTweenRunning = false
    if sea_boatTweenConn then sea_boatTweenConn:Disconnect() sea_boatTweenConn = nil end
    if not boat or not boat.Parent then if callback then callback() end return end

    local startCF  = boat:GetPivot()
    local dist     = (startCF.Position - targetCF.Position).Magnitude
    local speed    = getgenv().TweenSpeed or 300
    local duration = math.max(0.05, dist / speed)
    local startT   = tick()
    sea_boatTweenRunning = true

    sea_boatTweenConn = RunService.Heartbeat:Connect(function()
        if not sea_boatTweenRunning or not boat or not boat.Parent then
            if sea_boatTweenConn then sea_boatTweenConn:Disconnect() sea_boatTweenConn = nil end
            return
        end
        local alpha    = math.clamp((tick() - startT) / duration, 0, 1)
        local lerpedCF = startCF:Lerp(targetCF, alpha)
        pcall(function() boat:PivotTo(lerpedCF) end)
        if alpha >= 1 then
            sea_boatTweenRunning = false
            sea_boatTweenConn:Disconnect()
            sea_boatTweenConn = nil
            if callback then callback() end
        end
    end)
end

local function SeaTweenBoatToSync(boat, targetCF)
    local done = false
    SeaTweenBoatTo(boat, targetCF, function() done = true end)
    while not done and sea_boatTweenRunning do task.wait() end
end

local function SeaCancelBoatTween()
    sea_boatTweenRunning = false
    if sea_boatTweenConn then sea_boatTweenConn:Disconnect() sea_boatTweenConn = nil end
end

local sea_activeTween = nil
local function SeaTweenTo(targetCF, callback)
    if sea_activeTween then sea_activeTween:Cancel() sea_activeTween = nil end
    local char = plr.Character
    if not char then if callback then callback() end return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then if callback then callback() end return end

    SeaSetBodyVelocity(true)

    local dist     = (hrp.Position - targetCF.Position).Magnitude
    local speed    = getgenv().TweenSpeed or 300
    local duration = math.max(0.05, dist / speed)

    local tw = HD_TrackTween(TW:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {CFrame = targetCF}))
    sea_activeTween = tw
    tw:Play()
    tw.Completed:Connect(function(state)
        if state == Enum.PlaybackState.Completed then
            sea_activeTween = nil
            if callback then callback() end
        end
    end)
    return tw
end

local function SeaTweenToSync(targetCF)
    local done = false
    SeaTweenTo(targetCF, function() done = true end)
    while not done do task.wait() end
end

local function SeaGetNearestBoat()
    local char = plr.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local boatsFolder = workspace:FindFirstChild("Boats")
    if not boatsFolder then return nil end
    local MAX_BOAT_RANGE = 3500
    local bestBoat, bestDist = nil, math.huge
    for _, boat in ipairs(boatsFolder:GetChildren()) do
        local seat = boat:FindFirstChildWhichIsA("VehicleSeat", true)
        if seat then
            local dist = (seat.Position - hrp.Position).Magnitude
            if dist < bestDist and dist <= MAX_BOAT_RANGE then
                bestDist = dist
                bestBoat = boat
            end
        end
    end
    return bestBoat
end

-- ══ FIX: SeaIsOnBoat kiểm tra seat có thực sự thuộc workspace.Boats ══
local function SeaIsOnBoat()
    local char = plr.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or not hum.Sit then return false end

    -- Lấy SeatPart mà Humanoid đang ngồi
    local seatPart = hum.SeatPart
    if not seatPart then return false end

    -- Verify seat thuộc workspace.Boats (đồng nhất với SeaGetNearestBoat)
    local boatsFolder = workspace:FindFirstChild("Boats")
    if not boatsFolder then return false end

    return seatPart:IsDescendantOf(boatsFolder)
end

local function SeaSitOnBoat(boat)
    if not boat then return false end
    local seat = boat:FindFirstChildWhichIsA("VehicleSeat", true)
    if not seat then return false end
    local char = plr.Character
    if not char then return false end
    SeaTweenToSync(seat.CFrame * CFrame.new(0, 2.5, 0))
    task.wait(0.3)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then seat:Sit(hum) end
    task.wait(0.6)
    return SeaIsOnBoat()
end

local sea_lastJumpTime = 0
local function SeaPerformJump(bypass)
    local char = plr.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    local now = tick()
    if not bypass and (now - sea_lastJumpTime) < 1 then return end
    hum:ChangeState(Enum.HumanoidStateType.Jumping)
    sea_lastJumpTime = now
end

local function SeaResetPlayer()
    local char = plr.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if hum then hum.Health = 0 end
end

--// ===================================================================
--//              SEA EVENT: MOB DETECTION & COMBAT
--// ===================================================================

local function SeaIsAnyMobToggleOn()
    for genvKey in pairs(SEA_MOB_MAP) do
        if getgenv()[genvKey] then return true end
    end
    return false
end

local function SeaFindNearestMob()
    local char = plr.Character
    if not char then return nil, nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil, nil end

    local bestDist, bestMob, bestKey = math.huge, nil, nil

    for genvKey, data in pairs(SEA_MOB_MAP) do
        if getgenv()[genvKey] then
            local folder = workspace:FindFirstChild(data.folder)
            if folder then
                for _, mob in ipairs(folder:GetChildren()) do
                    local nameMatch = false
                    for _, n in ipairs(data.names) do
                        if mob.Name == n then nameMatch = true break end
                    end
                    if nameMatch then
                        local alive, rootPos = false, nil
                        if data.isSeaBeast then
                            local hp = mob:FindFirstChild("Health")
                            alive = hp and hp.Value > 0
                            local rp = mob:FindFirstChild("HumanoidRootPart")
                            rootPos = rp and rp.Position
                        elseif data.isBoat then
                            local hp = mob:FindFirstChild("Health")
                            local vs = mob:FindFirstChild("VehicleSeat")
                            alive = hp and hp.Value > 0 and vs ~= nil
                            local eng = mob:FindFirstChild("Engine")
                            rootPos = eng and eng.Position
                        else
                            local hum = mob:FindFirstChild("Humanoid")
                            alive = hum and hum.Health > 0
                            local rp = mob:FindFirstChild("HumanoidRootPart")
                            rootPos = rp and rp.Position
                        end
                        if alive and rootPos then
                            local dist = (rootPos - hrp.Position).Magnitude
                            if dist <= 2000 and dist < bestDist then
                                bestDist = dist
                                bestMob  = mob
                                bestKey  = genvKey
                            end
                        end
                    end
                end
            end
        end
    end
    return bestMob, bestKey
end

local function SeaIsMobAlive(mob, genvKey)
    if not mob or not mob.Parent then return false end
    local data = SEA_MOB_MAP[genvKey]
    if not data then return false end
    if data.isSeaBeast then
        local hp = mob:FindFirstChild("Health")
        return hp and hp.Value > 0
    elseif data.isBoat then
        local hp = mob:FindFirstChild("Health")
        return hp and hp.Value > 0 and mob:FindFirstChild("VehicleSeat") ~= nil
    else
        local hum = mob:FindFirstChild("Humanoid")
        return hum and hum.Health > 0
    end
end

local function SeaGetMobFarmCFrame(mob, genvKey)
    local data = SEA_MOB_MAP[genvKey]
    if not data then return nil end
    if data.isBoat then
        local eng = mob:FindFirstChild("Engine")
        if not eng then return nil end
        if mob.Name == "PirateGrandBrigade" or mob.Name == "PirateBrigade" then
            local offset = (mob.Name == "PirateGrandBrigade") and CFrame.new(0, 10, -50) or CFrame.new(0, 30, -10)
            return eng.CFrame * offset
       elseif mob.Name == "FishBoat" then
    return eng.CFrame * CFrame.new(0, 50, -25)
else
    return eng.CFrame * CFrame.new(0, 55, 0)
end
    elseif data.isSeaBeast then
        local rp = mob:FindFirstChild("HumanoidRootPart")
        if not rp then return nil end
        return CFrame.new(rp.Position.X, 60, rp.Position.Z)
    else
        local rp = mob:FindFirstChild("HumanoidRootPart")
        if not rp then return nil end
        local wp = _G.ChooseWP or "Melee"
        local yOff = (wp == "Melee" or wp == "Sword") and 40 or (wp == "Blox Fruit") and 13 or 70
        return CFrame.new(rp.Position.X, rp.Position.Y + yOff, rp.Position.Z)
    end
end

local sea_dodgeThread = nil
local sea_isDodging   = false

local function SeaStartDodgeLoop(mob, genvKey)
    if sea_dodgeThread then task.cancel(sea_dodgeThread) sea_dodgeThread = nil end
    sea_isDodging = false

    local data       = SEA_MOB_MAP[genvKey]
    local isSeaBeast = data and data.isSeaBeast
    local isTerror   = (genvKey == "AutoTerrorSharkEnabled")
    if not (isSeaBeast or isTerror) then return end

    local waterBase = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("WaterBase-Plane")
    local safeY     = waterBase and (waterBase.Position.Y + 200) or 200
    local farmY     = 35

    sea_dodgeThread = task.spawn(function()
        while sea_farmRunning and SeaIsMobAlive(mob, genvKey) do
            if not getgenv().DodgeSkillsEnabled then
                task.wait(0.05)
            elseif isSeaBeast then
                local wo = workspace:FindFirstChild("_WorldOrigin")
                local splash = wo and wo:FindFirstChild("Typhoon Splash")
                if splash and not sea_isDodging then
                    sea_isDodging = true
                    local char = plr.Character
                    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.CFrame = CFrame.new(hrp.Position.X, safeY, hrp.Position.Z) end
                    task.wait(1.5)
                    local extra = 0
                    while extra < 3 do
                        local wo2 = workspace:FindFirstChild("_WorldOrigin")
                        if not (wo2 and wo2:FindFirstChild("Typhoon Splash")) then break end
                        task.wait(0.05) extra += 0.05
                    end
                    if sea_farmRunning then
                        local tgtCF = SeaGetMobFarmCFrame(mob, genvKey)
                        if tgtCF then
                            local c2 = plr.Character
                            local h2 = c2 and c2:FindFirstChild("HumanoidRootPart")
                            if h2 then h2.CFrame = CFrame.new(tgtCF.Position.X, farmY, tgtCF.Position.Z) end
                        end
                    end
                    sea_isDodging = false
                else
                    task.wait(0.05)
                end
            elseif isTerror then
                local wo = workspace:FindFirstChild("_WorldOrigin")
                local splash = wo and wo:FindFirstChild("Typhoon Splash")
                if splash and not sea_isDodging then
                    sea_isDodging = true
                    local char = plr.Character
                    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.CFrame = CFrame.new(hrp.Position.X, safeY, hrp.Position.Z) end
                    local waited = 0
                    while waited < 5 do
                        local wo2 = workspace:FindFirstChild("_WorldOrigin")
                        if not (wo2 and wo2:FindFirstChild("Typhoon Splash")) then break end
                        task.wait(0.05) waited += 0.05
                    end
                    if sea_farmRunning then
                        local tgtCF = SeaGetMobFarmCFrame(mob, genvKey)
                        if tgtCF then
                            local c2 = plr.Character
                            local h2 = c2 and c2:FindFirstChild("HumanoidRootPart")
                            if h2 then h2.CFrame = tgtCF end
                        end
                    end
                    sea_isDodging = false
                else
                    task.wait(0.05)
                end
            end
        end
    end)
end

local function SeaStopDodgeLoop()
    sea_isDodging = false
    if sea_dodgeThread then task.cancel(sea_dodgeThread) sea_dodgeThread = nil end
end

--// ===================================================================
--//              SEA EVENT: MAIN STATE MACHINE
--// ===================================================================

getgenv().AutoSailEnabled        = false
getgenv().AutoSharkEnabled       = false
getgenv().AutoPiranhaEnabled     = false
getgenv().AutoTerrorSharkEnabled = false
getgenv().AutoFishCrewEnabled    = false
getgenv().AutoHauntedCrewEnabled = false
getgenv().AutoPirateGrandEnabled = false
getgenv().AutoFishBoatEnabled    = false
getgenv().AutoSeaBeastEnabled    = false
getgenv().AutoM1FruitEnabled     = false
getgenv().ResetCharacterEnabled  = false
getgenv().DodgeSkillsEnabled     = false

sea_farmRunning = false
local sea_farmThread  = nil

local function SeaStopFarm()
    sea_farmRunning = false
    if sea_farmThread then task.cancel(sea_farmThread) sea_farmThread = nil end
    SeaSetNoclip(false)
    SeaSetBodyVelocity(false)
    SeaStopWeaponLoop()
    SeaStopSkillSpamLoop()
    SeaStopDodgeLoop()
    if sea_activeTween then sea_activeTween:Cancel() sea_activeTween = nil end
    SeaCancelBoatTween()
    if sea_boatNoclipConn then sea_boatNoclipConn:Disconnect() sea_boatNoclipConn = nil end
    if sea_boatBvConn then sea_boatBvConn:Disconnect() sea_boatBvConn = nil end
end

local function SeaFarmLoop()
    sea_farmRunning = true
    SeaSetNoclip(true)
    SeaSetBodyVelocity(true)

    while sea_farmRunning do
        if not getgenv().AutoSailEnabled and not SeaIsAnyMobToggleOn() then
            SeaStopFarm()
            break
        end

        local ok = pcall(function()
            local char = plr.Character
            if not char then task.wait(1) return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then task.wait(1) return end

            local autoSail     = getgenv().AutoSailEnabled
            local anyMobToggle = SeaIsAnyMobToggleOn()

            if not autoSail and not anyMobToggle then task.wait(0.5) return end

            -- ══ CHẾ ĐỘ CHỈ MOB TOGGLE ══
            if anyMobToggle and not autoSail then
                local mob, genvKey = SeaFindNearestMob()
                if not mob then task.wait(0.5) return end

                local data2 = SEA_MOB_MAP[genvKey]
                local isBoatOrBeast2 = data2 and (data2.isBoat or data2.isSeaBeast)

                SeaSetNoclip(true)
                SeaSetBodyVelocity(true)

                if isBoatOrBeast2 then
                    local alive2 = true
                    SeaStartSkillSpamLoop(function()
                        return not (sea_farmRunning and alive2
                            and getgenv().AutoSailEnabled == false
                            and SeaIsAnyMobToggleOn())
                    end)
                    SeaStartDodgeLoop(mob, genvKey)

                    local timeout = 0
                    while sea_farmRunning and getgenv().AutoSailEnabled == false
                        and SeaIsAnyMobToggleOn() and SeaIsMobAlive(mob, genvKey) do
                        if not sea_isDodging then
                            local tgtCF = SeaGetMobFarmCFrame(mob, genvKey)
                            if tgtCF then SeaTweenTo(tgtCF) end
                        end
                        task.wait(0.1)
                        timeout += 0.1
                        if timeout > 60 then break end
                    end

                    alive2 = false
                    SeaStopSkillSpamLoop()
                    SeaStopDodgeLoop()
                else
                    SeaStartWeaponLoop(function() return SeaGetWeaponForMob(genvKey) end)

                    local timeout = 0
                    while sea_farmRunning and getgenv().AutoSailEnabled == false
                        and SeaIsAnyMobToggleOn() and SeaIsMobAlive(mob, genvKey) do
                        local tgtCF = SeaGetMobFarmCFrame(mob, genvKey)
                        if tgtCF then SeaTweenTo(tgtCF) end
                        task.wait(0.1)
                        timeout += 0.1
                        if timeout > 60 then break end
                    end

                    SeaStopWeaponLoop()
                end

                SeaSetNoclip(false)
                SeaSetBodyVelocity(false)
                if sea_activeTween then sea_activeTween:Cancel() sea_activeTween = nil end
                return
            end

            -- ══ CHẾ ĐỘ AUTOSAIL ══
            local myBoat = SeaGetNearestBoat()
            if not myBoat then
                if getgenv().ResetCharacterEnabled then
                    SeaResetPlayer() task.wait(6) return
                else
                    SeaTweenToSync(BUY_BOAT_CFRAME)
                    if not sea_farmRunning then return end
                    task.wait(0.5)
                    pcall(function() replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) end)
                    task.wait(1.5)
                    myBoat = SeaGetNearestBoat()
                    if not myBoat then task.wait(2) return end
                end
            end

            if not SeaIsOnBoat() then
                local sat = SeaSitOnBoat(myBoat)
                if not sat then task.wait(1) return end
            end
            if not sea_farmRunning then return end

            local targetSeaCF = SEA_ZONE_CFRAMES[_G.DangerSc] or SEA_ZONE_CFRAMES["Lv 1"]
            local boatRoot    = SeaGetBoatRoot(myBoat)
            if not boatRoot then task.wait(1) return end

            SeaSetBoatNoclip(myBoat, true)
            SeaSetBoatBodyVelocity(myBoat, true)

            local startPos  = boatRoot.Position
            local endPos    = targetSeaCF.Position
            local totalDist = (endPos - startPos).Magnitude
            local steps     = math.max(1, math.ceil(totalDist / 500))
            local interrupted = false

            for i = 1, steps do
                if not sea_farmRunning then
                    SeaCancelBoatTween() SeaSetBoatNoclip(myBoat, false) SeaSetBoatBodyVelocity(myBoat, false) return
                end
                -- ══ FIX: dùng SeaIsOnBoat() đã được fix thay vì check trực tiếp ══
                if not SeaIsOnBoat() then break end

                local t      = i / steps
                local stepPos = startPos + (endPos - startPos) * t
                local stepCF  = CFrame.new(stepPos.X, math.max(stepPos.Y, 35), stepPos.Z)

                SeaTweenBoatToSync(myBoat, stepCF)
                if not sea_farmRunning then
                    SeaCancelBoatTween() SeaSetBoatNoclip(myBoat, false) SeaSetBoatBodyVelocity(myBoat, false) return
                end

                if SeaIsAnyMobToggleOn() then
                    local mob, _ = SeaFindNearestMob()
                    if mob then interrupted = true break end
                end
            end

            SeaCancelBoatTween()
            SeaSetBoatNoclip(myBoat, false)
            SeaSetBoatBodyVelocity(myBoat, false)
            if not sea_farmRunning then return end

            if interrupted and SeaIsAnyMobToggleOn() then
                SeaPerformJump(true)
                task.wait(0.6)
                SeaSetNoclip(true)
                SeaSetBodyVelocity(true)

                while sea_farmRunning and SeaIsAnyMobToggleOn() do
                    local mob, genvKey = SeaFindNearestMob()
                    if not mob then break end

                    local data = SEA_MOB_MAP[genvKey]
                    local isBoatOrBeast = data and (data.isBoat or data.isSeaBeast)

                    if isBoatOrBeast then
                        local alive = true
                        SeaStartSkillSpamLoop(function()
                            return not (sea_farmRunning and alive and SeaIsAnyMobToggleOn())
                        end)
                        SeaStartDodgeLoop(mob, genvKey)

                        local timeout = 0
                        while sea_farmRunning and SeaIsMobAlive(mob, genvKey) do
                            if not sea_isDodging then
                                local tgtCF = SeaGetMobFarmCFrame(mob, genvKey)
                                if tgtCF then SeaTweenTo(tgtCF) end
                            end
                            task.wait(0.1)
                            timeout += 0.1
                            if timeout > 60 then break end
                        end

                        alive = false
                        SeaStopSkillSpamLoop()
                        SeaStopDodgeLoop()
                    else
                        SeaStartWeaponLoop(function() return SeaGetWeaponForMob(genvKey) end)

                        local timeout = 0
                        while sea_farmRunning and SeaIsMobAlive(mob, genvKey) do
                            local tgtCF = SeaGetMobFarmCFrame(mob, genvKey)
                            if tgtCF then SeaTweenTo(tgtCF) end
                            task.wait(0.1)
                            timeout += 0.1
                            if timeout > 60 then break end
                        end

                        SeaStopWeaponLoop()
                    end

                    task.wait(0.2)
                end

                SeaSetNoclip(false)
                SeaSetBodyVelocity(false)
                if sea_activeTween then sea_activeTween:Cancel() sea_activeTween = nil end
                if not sea_farmRunning then return end

                myBoat = SeaGetNearestBoat()
                if myBoat then
                    local sat = SeaSitOnBoat(myBoat)
                    if not sat then task.wait(1) end
                else
                    if getgenv().ResetCharacterEnabled then SeaResetPlayer() end
                    task.wait(4)
                end
            else
                task.wait(3)
            end
        end)

        if not ok then task.wait(1) end
    end
    sea_farmThread = nil
end

-- ─── Phát hiện thuyền vỡ ─────────────────────────────────────────────
task.spawn(function()
    while true do
        task.wait(1)
        if not sea_farmRunning then continue end
        pcall(function()
            if SeaIsOnBoat() then
                local myBoat = SeaGetNearestBoat()
                if not myBoat then
                    if getgenv().ResetCharacterEnabled then SeaResetPlayer() end
                    task.wait(4)
                end
            end
        end)
    end
end)

-- ─── Sau khi respawn: restart loop ───────────────────────────────────
plr.CharacterAdded:Connect(function(char)
    if not sea_farmRunning then return end
    if sea_activeTween then sea_activeTween:Cancel() sea_activeTween = nil end
    SeaCancelBoatTween()
    if sea_farmThread then task.cancel(sea_farmThread) sea_farmThread = nil end

    task.wait(2)
    if not sea_farmRunning then return end

    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if not hrp then return end

    SeaSetNoclip(true)
    SeaSetBodyVelocity(true)
    SeaTweenToSync(BUY_BOAT_CFRAME)
    if not sea_farmRunning then return end

    task.wait(0.5)
    pcall(function() replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) end)

    local waited = 0
    while waited < 5 do
        task.wait(0.5) waited += 0.5
        if SeaGetNearestBoat() then break end
    end

    if not sea_farmRunning then return end
    sea_farmThread = task.spawn(SeaFarmLoop)
end)

--// ===================================================================
--//              SEA EVENT: UI (Entity Sea Event Section)
--// ===================================================================

Tabs.SeaEvent:AddSection("Entity Sea Event")

local SeaToggleList = {
    { id = "AutoSharkToggle",       title = "Tự Động Giết Cá Mập",                   genv = "AutoSharkEnabled"         },
    { id = "AutoPiranhaToggle",     title = "Tự Động Giết Piranha",                   genv = "AutoPiranhaEnabled"       },
    { id = "AutoTerrorSharkToggle", title = "Tự Động Giết Terror Shark",              genv = "AutoTerrorSharkEnabled"   },
    { id = "AutoFishCrewToggle",    title = "Tự Động Giết Fish Crew Member",          genv = "AutoFishCrewEnabled"      },
    { id = "AutoHauntedCrewToggle", title = "Tự Động Đánh Haunted Crew",              genv = "AutoHauntedCrewEnabled"   },
    { id = "AutoPirateGrandToggle", title = "Tự Động Đánh Pirate Ship",              genv = "AutoPirateGrandEnabled"   },
    { id = "AutoFishBoatToggle",    title = "Tự Động Đánh Fish Boat",                genv = "AutoFishBoatEnabled"      },
    { id = "AutoSeaBeastToggle",    title = "Tự Động Đánh Sea Beast",                genv = "AutoSeaBeastEnabled"      },
}

for _, t in ipairs(SeaToggleList) do
    Tabs.SeaEvent:AddToggle("Auto_AddToggle_10", {
        Title = t.title,
        Default = false,
        Callback = function(Value)
            getgenv()[t.genv] = Value
            if Value then
                if not sea_farmRunning then
                    sea_farmThread = task.spawn(SeaFarmLoop)
                end
            else
                if not SeaIsAnyMobToggleOn() and not getgenv().AutoSailEnabled then
                    SeaStopFarm()
                end
            end
        end
    })
    getgenv()[t.genv] = false
end

Tabs.SeaEvent:AddToggle("Auto_AddToggle_11", {
    Title = "Auto M1 Fruit For Sea Event",
    Description = "",
    Default     = false,
    Callback    = function(Value)
        getgenv().AutoM1FruitEnabled = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto_AddToggle_12", {
    Title = "Reset Character",
    Description = "",
    Default     = false,
    Callback    = function(Value)
        getgenv().ResetCharacterEnabled = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto_AddToggle_13", {
    Title = "Dodge Skills Terro + Sea Beast",
    Description = "Tự dodge Typhoon Splash",
    Default     = false,
    Callback    = function(Value)
        getgenv().DodgeSkillsEnabled = Value
    end
})

task.spawn(function()
    while task.wait(Sec) do
        pcall(function()
            for a, b in pairs(workspace.Boats:GetChildren()) do
                for c, d in pairs(workspace.Boats[b.Name]:GetDescendants()) do
                    if d:IsA("BasePart") then
                        if _G.SailBoats or _G.Prehis_Find or _G.FindMirage or _G.SailBoat_Hydra or _G.AutofindKitIs then
                            d.CanCollide = false
                        else
                            d.CanCollide = true
                        end
                    end
                end
            end
        end)
    end
end)

Tabs.SeaEvent:AddToggle("Auto_AddToggle_14", {
    Title = "Tự Động Lái Thuyền",
    Flag        = "Q_54",
    Description = "Chọn Thuyền -> Chọn Cấp Biển -> Tự Động Lái Thuyền",
    Default     = false,
    Callback    = function(Value)
        getgenv().AutoSailEnabled = Value
        if Value then
            if not sea_farmRunning then
                sea_farmThread = task.spawn(SeaFarmLoop)
            end
        else
            if not SeaIsAnyMobToggleOn() then
                SeaStopFarm()
            end
        end
    end
})

Q = Tabs.SeaEvent:AddDropdown("Q", {
    Title = "Chọn Thuyền",
    Flag = "Q_52",
    Values = ListSeaBoat,
    ,
    Callback = function(Value)
        _G.SelectedBoat = Value
    end
})

Q = Tabs.SeaEvent:AddDropdown("Q", {
    Title = "Choose Biển Cấp",
    Flag = "Q_53",
    Values = ListSeaZone,
    ,
    Callback = function(Value)
        _G.DangerSc = Value
    end
})

Tabs.SeaEvent:AddSection("Kitsune Island / Event")
Check_Kitsu = Tabs.SeaEvent:AddParagraph({
Title = " Trạng Thái Đảo Cáo Quỷ",
Content = ""})
task.spawn(function()
  while task.wait(0.2) do
    if workspace.Map:FindFirstChild("KitsuneIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
      Check_Kitsu:SetDesc(" Kitsune Island : True")
    else
      Check_Kitsu:SetDesc(" Kitsune Island : False")
    end
  end
end)
Q = Tabs.SeaEvent:AddToggle("Q", {
Title = "Tự Động Tìm Đảo Cáo", 
Flag = "Q_55",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutofindKitIs = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.AutofindKitIs then 
      pcall(function()
        if not workspace["_WorldOrigin"].Locations:FindFirstChild("Kitsune Island", true) then                
          local myBoat = CheckBoat()
          if not myBoat then
            local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
            TeleportToTarget(buyBoatCFrame)
            if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) end
          else
            if plr.Character.Humanoid.Sit == false then
              local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
              _tp(boatSeatCFrame)
            else
              local targetDestination = CFrame.new(-10000000, 31, 37016.25)              
              repeat wait() 
                if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
                  _tp(CFrame.new(-10000000, 150, 37016.25))
                else
                  _tp(CFrame.new(-10000000, 31, 37016.25))
                end
              until not _G.AutofindKitIs or (targetDestination.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace["_WorldOrigin"].Locations:FindFirstChild("Kitsune Island") or plr.Character.Humanoid.Sit == false plr.Character.Humanoid.Sit = false
            end
          end
        else
          _tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame*CFrame.new(0,500,0))
        end
      end)
    end
  end
end)
Q = Tabs.SeaEvent:AddToggle("Q", {
Title = "Tự Động Kích Hoạt Đảo Cáo", 
Flag = "Q_56",
Description = "", 
Default = false,
Callback = function(Value)
  _G.tweenShrine = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.tweenShrine then
      pcall(function()
      local kit_is = workspace.Map:FindFirstChild("KitsuneIsland") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")
      local shrineActive = kit_is:FindFirstChild("ShrineActive")
        if shrineActive then
          for _, v in next, shrineActive:GetDescendants() do
            if v:IsA("BasePart") and v.Name:find("NeonShrinePart") then
              replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
              repeat wait() _tp(v.CFrame * CFrame.new(0,2,0)) until _G.tweenShrine == false or not kit_is
            end
          end
        else
          _tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0,500,0))        
        end
      end)
    end
  end
end)
Q = Tabs.SeaEvent:AddToggle("Q", {
Title = "Tự Động Thu Thập Azure Ember", 
Flag = "Q_57",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Collect_Ember = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.Collect_Ember then
      pcall(function()
        if workspace:WaitForChild("AttachedAzureEmber") or workspace:WaitForChild("EmberTemplate") then
        notween(workspace:WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)
        else
          _tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0,500,0))        
          replicated.Modules.Net["RF/KitsuneStatuePray"]:InvokeServer()
        end
      end)
    end
  end
end)
Q = Tabs.SeaEvent:AddToggle("Q", {
Title = "Tự Động Trao Đổi Azure Ember", 
Flag = "Q_58",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Trade_Ember = Value
end})
task.spawn(function()
  while task.wait(0.1) do
    if _G.Trade_Ember then
      pcall(function()
        if workspace["_WorldOrigin"].Locations:FindFirstChild("Kitsune Island",true) then
          replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
        end
      end)
    end
  end
end)
Tabs.SeaEvent:AddButton({
Title = "Trao Đổi Vật Phẩm Azure", 
Description = "",
Callback = function()
  replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
end})
Tabs.SeaEvent:AddButton({
Title = "Talk with kitsune statue", 
Description = "",
Callback = function()
  replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
end})

Tabs.Raids:AddSection("Fruits Options")

RandomFF = Tabs.Raids:AddToggle("RandomFF", {
Title = "Tự Động Random Trái Ác Quỷ", 
Flag = "RandomFF",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Random_Auto = Value
end})
task.spawn(function()
  while task.wait(Sec) do
   	pcall(function()
      if _G.Random_Auto then replicated.Remotes.CommF_:InvokeServer("Cousin","Buy") end 
    end)
  end
end)
DropF = Tabs.Raids:AddToggle("DropF", {
Title = "Tự Động Drop Trái Ác Quỷ", 
Flag = "DropF",
Description = "", 
Default = false,
Callback = function(Value)
  _G.DropFruit = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.DropFruit then
      pcall(function() DropFruits() end)
    end
  end
end)
StoredF = Tabs.Raids:AddToggle("StoredF", {
Title = "Tự Động Store Trái Ác Quỷ", 
Flag = "StoredF",
Description = "", 
Default = false,
Callback = function(Value)
  _G.StoreF = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.StoreF then
      pcall(function() UpdStFruit() end)
    end
  end
end)
-- ==============================
-- FIX TWEEN ĐẾN TRÁI ÁC QUỶ
-- shouldTween phải = true khi dùng _tp
-- ==============================
TwF = Tabs.Raids:AddToggle("TwF", {
    Title = "Tự Động Bay Đến Trái Ác Quỷ",
    Flag = "TwF",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.TwFruits = Value
    end
})

task.spawn(function()
    while task.wait(Sec) do
        if _G.TwFruits then
            pcall(function()
                for _, fruit in pairs(workspace:GetChildren()) do
                    if string.find(fruit.Name, "Fruit") then
                        local handle = fruit:FindFirstChild("Handle")
                        if handle then
                            shouldTween = true  -- BẬT tween trước khi _tp
                            _tp(handle.CFrame)
                            task.wait(0.5)      -- đợi tween xong
                            shouldTween = false -- TẮT lại sau khi đến nơi
                        end
                    end
                end
            end)
        end
    end
end)

Tabs.Raids:AddSection("Dungeon Event / Raiding")
RaidS = Tabs.Raids:AddParagraph({
Title = " Raiding Status ",
Content = ""})
task.spawn(function()
  while task.wait(0.2) do
    pcall(function()      
      if plr.PlayerGui.Main.Timer.Visible == true then
        RaidS:SetDesc(" Raiding Statud : True")
      else
        RaidS:SetDesc(" Raiding Statud : False")
      end      
    end)
  end
end)
DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
Q = Tabs.Raids:AddDropdown("Q", {
Title = "Chọn Chip",
Flag = "Q_59",
Description = "",
Values = DungeonTables,
,
Callback = function(Value)
  _G.SelectChip = Value
end})
Q = Tabs.Raids:AddToggle("Q", {
Title = "Tự Động Chọn Dungeon Chip", 
Flag = "Q_60",
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoSelectDungeon = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    if _G.AutoSelectDungeon then
      pcall(function()
        if GetBP("Flame-Flame") then
          _G.SelectChip = "Flame"
        elseif GetBP("Ice-Ice") then
          _G.SelectChip = "Ice"
        elseif GetBP("Quake-Quake") then
          _G.SelectChip = "Quake"
        elseif GetBP("Light-Light") then
          _G.SelectChip = "Light"
        elseif GetBP("Dark-Dark") then
          _G.SelectChip = "Dark"
        elseif GetBP("String-String") then
          _G.SelectChip = "String"
        elseif GetBP("Rumble-Rumble") then
          _G.SelectChip = "Rumble"
         elseif GetBP("Magma-Magma") then
          _G.SelectChip = "Magma"
         elseif GetBP("Human-Human: Buddha Fruit") then
          _G.SelectChip = "Human: Buddha"
        elseif GetBP("Dough-Dough") then
          _G.SelectChip = "Dough"
        elseif GetBP("Sand-Sand") then
          _G.SelectChip = "Sand"
        elseif GetBP("Bird-Bird: Phoenix") then
          _G.SelectChip = "Bird: Phoenix"
        else
          _G.SelectChip = "Ice"
        end
      end)
    end
  end
end)
Tabs.Raids:AddButton({
Title = "Mua Raid Chips [Beli]", 
Description = "",
Callback = function()
  if not GetBP("Special Microchip") then replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip) end
end})
Tabs.Raids:AddButton({
Title = "Mua Chip Raid[Trái Ác Quỷ]", 
Description = "",
Callback = function()
  if GetBP("Special Microchip") then return end
  local FruitPrice = {}
  local FruitStore = {}
  for i,v in next,replicated:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
    if v.Price <= 490000 then table.insert(FruitPrice,v.Name) end 
  end    
  for _,y in pairs(FruitPrice) do    
    for i,v in pairs(DungeonTables) do 
      if not GetBP("Special Microchip") then     
        replicated.Remotes.CommF_:InvokeServer("LoadFruit",tostring(y))	      
	    replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip)	
	  end            
    end    
  end
end})

Tabs.Raids:AddSection("Raiding Menu")

-- [Giữ nguyên toggle Auto Start Raid gốc]
Q = Tabs.Raids:AddToggle("Q", {
Title = "Tự Động Bắt Đầu Raid",
Flag = "Q_61",
Description = "",
Default = false,
Callback = function(Value)
    _G.Auto_StartRaid = Value
end})
task.spawn(function()
    while task.wait(Sec) do
        pcall(function()
            if _G.Auto_StartRaid then
                if plr.PlayerGui.Main.TopHUDList.RaidTimer.Visible == false then
                    if GetBP("Special Microchip") then
                        if World2 then
                            _tp(CFrame.new(-6438.73535, 250.645355, -4501.50684))
                            fireclickdetector(workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                        elseif World3 then
                            replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
                            fireclickdetector(workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                        end
                    end
                end
            end
        end)
    end
end)


local function _RaidGetIslandNode(islandName)
    return workspace["_WorldOrigin"].Locations:FindFirstChild(islandName)
end

local function _RaidEnemyAlive(enemy)
    if not enemy or not enemy.Parent then return false end
    local h = enemy:FindFirstChild("Humanoid")
    return h and h.Health > 0
end

local function _RaidGetEnemiesNear(islandPos, radius)
    local list = {}
    for _, e in ipairs(workspace.Enemies:GetChildren()) do
        local eHRP = e:FindFirstChild("HumanoidRootPart")
        if _RaidEnemyAlive(e) and eHRP then
            if (eHRP.Position - islandPos).Magnitude <= radius then
                table.insert(list, e)
            end
        end
    end
    return list
end


_G.Raiding = false
local _raidIslands = {"Island 1", "Island 2", "Island 3", "Island 4", "Island 5"}
local _raidCurrentIsland = nil
local _raidKilling = false

local function _RaidReset()
    _raidCurrentIsland = nil
    _raidKilling = false
end

task.spawn(function()
    while task.wait(0.3) do
        if not _G.Raiding then continue end
        if _raidKilling then continue end

        local ok = pcall(function()
            local raidTimer = plr.PlayerGui.Main.TopHUDList.RaidTimer
            if not raidTimer or not raidTimer.Visible then
                _raidCurrentIsland = nil
                return
            end

            local char = plr.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum  = char:FindFirstChildOfClass("Humanoid")
            if not root or not hum or hum.Health <= 0 then return end
            if hum.Sit or hum.PlatformStand or root.Anchored then return end

            -- LOGIC MỚI: Quét đảo nào đang có quái thật sự
            local targetIsland = nil
            local activeEnemies = {}

            for _, name in ipairs(_raidIslands) do
                local node = _RaidGetIslandNode(name)
                if node then
                    local enemiesOnIsland = _RaidGetEnemiesNear(node.Position, 500)
                    if #enemiesOnIsland > 0 then
                        targetIsland = name
                        activeEnemies = enemiesOnIsland
                        break
                    end
                end
            end

            _raidCurrentIsland = targetIsland

            if #activeEnemies > 0 then
                local enemy = activeEnemies[1]
                if not _RaidEnemyAlive(enemy) then return end

                _raidKilling = true

                task.spawn(function()
                    local killStart = tick()

                    local eHRP = enemy:FindFirstChild("HumanoidRootPart")
                    if eHRP then _tp(eHRP.CFrame * CFrame.new(0, 10, 0)) end

                    while _G.Raiding
                        and enemy.Parent
                        and _RaidEnemyAlive(enemy)
                        and (tick() - killStart) < 7
                    do
                        -- FIX SCOPE: Lấy root mới mỗi frame tránh nil khi respawn
                        local myRoot = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                        if not myRoot then break end

                        local currentEHRP = enemy:FindFirstChild("HumanoidRootPart")
                        if currentEHRP then
                            local distance = (myRoot.Position - currentEHRP.Position).Magnitude
                            if distance > 20 then
                                _tp(currentEHRP.CFrame * CFrame.new(0, 10, 0))
                            end
                            pcall(function()
                                Attack.Kill(enemy, _G.Raiding)
                            end)
                        end
                        task.wait(0.15)
                    end

                    _raidKilling = false
                end)

            else
                -- Không có quái trên bất kỳ đảo nào
                -- Định vị đảo gần nhất để tiến tới đảo kế tiếp
                local nearDist = math.huge
                local myCurrentIslandIdx = 1

                for i, name in ipairs(_raidIslands) do
                    local node = _RaidGetIslandNode(name)
                    if node then
                        local d = (root.Position - node.Position).Magnitude
                        if d < nearDist then
                            nearDist = d
                            myCurrentIslandIdx = i
                        end
                    end
                end

                local nextName = _raidIslands[myCurrentIslandIdx + 1]
                if nextName then
                    local nextNode = _RaidGetIslandNode(nextName)
                    if nextNode then
                        _tp(nextNode.CFrame * CFrame.new(0, 45, 120))
                    end
                    task.wait(2.5)
                else
                    task.wait(2)
                end
            end
        end)
    end
end)

Tabs.Raids:AddToggle("Auto_AddToggle_15", {
    Title = "Tự Động Hoàn Thành Raid [ An Toàn ]",
    Flag = "Q_AutoRaidNextIsland",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Raiding = Value
        if not Value then
            task.wait(0.35)
            _RaidReset()
        else
            _RaidReset()
        end
    end
})





Q = Tabs.Raids:AddToggle("Q", {
Title = "Tự Động Thức Tỉnh", 
Flag = "Q_62",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Auto_Awakener = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.Auto_Awakener then
        replicated.Remotes.CommF_:InvokeServer("Awakener","Check")
        replicated.Remotes.CommF_:InvokeServer("Awakener","Awaken")
      end
    end)
  end
end)
Tabs.Raids:AddSection("Dungeon Event")
Dungoenvp = Tabs.Raids:AddToggle("Dungoenvp", {
    Title = "Tự Động Farm Dungeon + Qua Cửa",
    Flag = "Dungoenvp",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Dungeonh = Value
    end
})

task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/10LRDk2J/raw"))()
end)
AllCards={"Lifesteal","All Cooldowns","HYPER!","Fruit M1 Speed","Armor","Sniper","Overflow","Gun","Melee","Fruit","Defense","Fortress"}

_G.Select_Cards=_G.Select_Cards or {Melee=true}

Card = Tabs.Raids:AddDropdown("Card", {
	Title = "Chọn Thẻ",
	Values =AllCards,
	MultiSelect=true,
	Flag="SelectCards",
	Callback=function(v)
		_G.Select_Cards=v
		if ResetPick then ResetPick() end
	end
})

Pickcard = Tabs.Raids:AddToggle("Pickcard", {
	Title = "Tự Động Chọn Thẻ Dungeon",
	Flag = "Pickcard",
	Description = "",
	Default = true,
	Callback = function(Value)
		_G.Pickcard = Value
		if not Value then ResetPick() end
	end
})
Tabs.PlayerPVP:AddSection("Player PvP")

Players = game:GetService("Players")
RunService = game:GetService("RunService")
LocalPlayer = Players.LocalPlayer

_G.TargetPlayerAim = nil 
_G.TpPly = false
_G.AimbotEnabled = false 
getgenv().AimbotGun = false
PRED_TIME = 0.12 -- Độ đón đầu

local function GetPlayersList()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then 
            table.insert(list, p.Name) 
        end
    end
    return list
end

playerDropdown = nil

local function RefreshPlayerList()
    if not playerDropdown then return end
    local newList = GetPlayersList()
    playerDropdown:Refresh(newList, true)
    
    -- Reset target nếu player cũ đã rời game
    if _G.TargetPlayerAim and not Players:FindFirstChild(_G.TargetPlayerAim.Name) then
        _G.TargetPlayerAim = nil
    end
end

Tabs.PlayerPVP:AddDropdown("Auto_AddDropdown_2", {
    Title = "Chọn Player PVP",
    Values = GetPlayersList(),
    ,
    Callback = function(Value)
        getgenv().SelectedPlayer = game.Players:FindFirstChild(Value)
    end
})

-- 2. Nút làm mới thủ công
Tabs.PlayerPVP:AddButton({
    Title = "Làm Mới Danh Sách",
    Callback = function()
        RefreshPlayerList()
    end
})

-- 3. TỰ ĐỘNG LÀM MỚI KHI CÓ NGƯỜI VÀO/RỜI
Players.PlayerAdded:Connect(function()
    task.wait(0.5) -- Chờ 0.5s để game xử lý
    RefreshPlayerList()
end)

Players.PlayerRemoving:Connect(function()
    RefreshPlayerList()
end)

-- 4. TỰ ĐỘNG LÀM MỚI MỖI 5 GIÂY (DỰ PHÒNG)
task.spawn(function()
    while task.wait(5) do
        RefreshPlayerList()
    end
end)


Tabs.PlayerPVP:AddToggle("Auto_AddToggle_16", {
    Title = "Tàng Hình",
    Default = false,
    Description = "Đứng Ở Vùng An Toàn Rồi Bật",
    Callback = function(value)
        raknet.desync(value)
        if value then
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end
    end
})
-- Toggle bật tắt Aimbot
Tabs.PlayerPVP:AddToggle("Auto_AddToggle_17", {
    Title = "Bật Aimbot Skill",
    Default = false,
    Callback = function(Value)
        getgenv().AimSkill = Value
        if not Value then
            -- Reset mục tiêu khi tắt để tránh lỗi kẹt tâm ngắm
            getgenv().AimTarget = nil
            getgenv().AimPos = nil
        end
    end
})

-- Slider điều chỉnh tầm quét
Tabs.PlayerPVP:AddSlider("Auto_AddSlider_3", {
    Title = "Khoảng Cách Aimbot",
    Min = 100,
    Max = 5000,
    Default = 2500,
    Description = "Chỉnh Max Lên",
    Callback = function(Value)
        getgenv().AimRadius = Value
    end
})

Tabs.PlayerPVP:AddToggle("Auto_AddToggle_18", {
    Title = "Tự Động Aimbot Camera",
    Default = false,
    Callback = function(Value)
        getgenv().AutoAimbotCamera = Value
    end
})
task.spawn(function()
    local ply = game:GetService("Players")
    local plr = ply.LocalPlayer
    local camera = workspace.CurrentCamera
    local function closestplayer()
        local dist = math.huge
        local target = nil
        for _, v in next, ply:GetPlayers() do
            if v ~= plr then
                if v.Character
                    and v.Character:FindFirstChild("Head")
                    and v.Character:FindFirstChild("HumanoidRootPart")
                    and v.Character:FindFirstChildOfClass("Humanoid").Health > 0
                then
                    local Mag = (v.Character.Head.Position - plr.Character.Head.Position).Magnitude
                    if Mag < dist then
                        dist = Mag
                        target = v
                    end
                end
            end
        end
        return target
    end
    while task.wait(0.1) do
        pcall(function()
            if getgenv().AutoAimbotCamera then
                repeat
                    task.wait()
                    local target = closestplayer()
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        camera.CFrame = CFrame.new(camera.CFrame.Position,target.Character.HumanoidRootPart.Position)
                    end
                until not getgenv().AutoAimbotCamera
            end
        end)
    end
end)

Tabs.PlayerPVP:AddToggle("Auto_AddToggle_19", {
    Title = "Lướt Liên Tục [ No Cooldown ]",
    Default = false,
    Callback = function(Value)
        getgenv().DodgeNoCD = Value
    end
})
local function NoCooldown()
    local dodgeScript = game.Players.LocalPlayer.Character:WaitForChild("Dodge")
    for i, v in next, getgc() do
        if typeof(v) == "function" then
            local funcEnv = getfenv(v)
            if funcEnv.script == dodgeScript then
                for i2, v2 in next, getupvalues(v) do
                    if tostring(v2) == "0.4" then
                        setupvalue(v, i2, 0)
                    end
                end
            end
        end
    end
end
task.spawn(function()
    while task.wait(0.5) do
        if getgenv().DodgeNoCD then
            pcall(NoCooldown)
        end
    end
end)
Tabs.PlayerPVP:AddToggle("Auto_AddToggle_20", {
    Title = "Vô Hạn Soru",
    Default = false,
    Callback = function(Value)
        getgenv().InfiniteSoru = Value
    end
})
local function InfiniteSoruLoop()
    while getgenv().InfiniteSoru do
        local character = game:GetService("Players").LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            for i, v in next, getgc() do
                if typeof(v) == "function" and getfenv(v).script == character:WaitForChild("Soru") then
                    for i2, v2 in pairs(debug.getupvalues(v)) do
                        if type(v2) == "table" and v2.LastUse then
                            setupvalue(v, i2, { LastAfter = 0, LastUse = 0 })
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().InfiniteSoru then
            pcall(function()
                InfiniteSoruLoop()
            end)
        end
    end
end)
Tabs.PlayerPVP:AddToggle("Auto_AddToggle_21", {
    Title = "Vô Hạn Né",
    Default = false,
    Callback = function(Value)
        getgenv().InfiniteGeppo = Value
    end
})
local function InfiniteGeppoLoop()
    while getgenv().InfiniteGeppo do
        for i, v in next, getgc() do
            if typeof(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character:WaitForChild("Geppo") then
                for i2, v2 in next, getupvalues(v) do
                    if tostring(v2) == "0" then
                        setupvalue(v, i2, 0)
                    end
                end
            end
        end
        task.wait(0.1)
    end
end
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().InfiniteGeppo then
            pcall(function()
                InfiniteGeppoLoop()
            end)
        end
    end
end)
Tabs.PlayerPVP:AddToggle("Auto_AddToggle_22", {
    Title = "Xuyên Tường",
    Default = false,
    Callback = function(Value)
        getgenv().NoClip = Value
    end
})
task.spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if getgenv().NoClip then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") or v:IsA("Part") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
end)

getgenv().PMT_GunFarm_Range = getgenv().PMT_GunFarm_Range or 2500
getgenv().PMT_GunFarm_Delay = getgenv().PMT_GunFarm_Delay or 0.01

_G.FarmMastery_DS = _G.FarmMastery_DS or false

do
P = game:GetService("Players")
R = game:GetService("ReplicatedStorage")
L = P.LocalPlayer
S = R:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/ShootGunEvent")

-- Toggle
Tabs.PlayerPVP:AddToggle("Auto_AddToggle_23", {
    Title = "Aimbot Dragon Strom [ 100% Ban ]",
    Default = false,
    Callback = function(Value)
        _G.FarmMastery_DS = Value
    end
})

-- Utils
local function Ch()
    return L.Character or L.CharacterAdded:Wait()
end

local function Rt()
    local c = Ch()
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function Alive(m)
    if not (m and m.Parent) then return false end
    local h = m:FindFirstChildOfClass("Humanoid")
    local r = m:FindFirstChild("HumanoidRootPart")
    return h and r and h.Health > 0
end

local function Hdl(e)
    for _, d in ipairs(e:GetDescendants()) do
        if d:IsA("Accessory") then
            local h = d:FindFirstChild("Handle")
            if h then return h end
        end
    end
    for _, d in ipairs(e:GetDescendants()) do
        if d:IsA("BasePart") and d.Name == "Handle" then
            return d
        end
    end
end

-- Tìm mob gần nhất (KHÔNG check máu nữa)
local function Near(range)
    local root = Rt()
    if not root then return end

    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return end

    local rp = root.Position
    local best, bestDist = nil, (range or math.huge)^2

    for _, m in ipairs(enemies:GetChildren()) do
        if Alive(m) then
            local pos = m.HumanoidRootPart.Position
            local dx = pos.X - rp.X
            local dy = pos.Y - rp.Y
            local dz = pos.Z - rp.Z
            local dist = dx*dx + dy*dy + dz*dz

            if dist < bestDist then
                bestDist = dist
                best = m
            end
        end
    end

    return best
end

-- Bắn
local function Fire(m)
    if not m then return end

    local hrp = m:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local handle = Hdl(m)
    if not handle then return end

    local pos = hrp.Position
    local vec = (vector and vector.create)
        and vector.create(pos.X, pos.Y, pos.Z)
        or Vector3.new(pos.X, pos.Y, pos.Z)

    S:FireServer(vec, {handle})
end

-- Loop Kill Aura
task.spawn(function()
    while task.wait(getgenv().PMT_GunFarm_Delay) do
        if _G.FarmMastery_DS then
            pcall(function()
                local mob = Near(getgenv().PMT_GunFarm_Range)
                if mob then
                    Fire(mob)
                end
            end)
        end
    end
end)



Loaded_InstantKill = false -- Biến kiểm tra

Tabs.PlayerPVP:AddButton({
    Title = "Instant Kill",
    Description = "Click",
    Callback = function()
        if not Loaded_InstantKill then
            Loaded_InstantKill = true
            task.spawn(function()
                loadstring(game:HttpGet("https://pastefy.app/mcYpDq6u/raw"))()
            end)
        else
        end
    end
})



Players = game:GetService("Players")
lp = Players.LocalPlayer

-- Giá trị mặc định
getgenv().WalkSpeedValue = 30
getgenv().JumpValue = 50

-- ==============================
-- 1. HÀM ÉP BUỘC HUMANOID
-- ==============================
local function ApplyHumanoid(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if not hum then return end

    local isApplying = false -- ✅ Flag chống loop conflict

    local function SetJump()
        if isApplying then return end
        isApplying = true
        hum.UseJumpPower = true
        hum.JumpPower = getgenv().JumpValue
        isApplying = false
    end

    local function SetSpeed()
        hum.WalkSpeed = getgenv().WalkSpeedValue
    end

    -- Gán giá trị ban đầu
    SetJump()
    SetSpeed()

    -- ✅ FIX CHÍNH: Bắt đúng state để reapply
    hum.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Landed then
            task.wait(0.05) -- Chờ physics ổn định
            SetJump()
        elseif newState == Enum.HumanoidStateType.Jumping then
            -- Giữ JumpPower trong lúc nhảy
            SetJump()
        elseif newState == Enum.HumanoidStateType.Freefall then
            SetJump()
        elseif newState == Enum.HumanoidStateType.Running
            or newState == Enum.HumanoidStateType.RunningNoPhysics then
            SetJump()
        end
    end)

    -- Chống game tắt UseJumpPower
    hum:GetPropertyChangedSignal("UseJumpPower"):Connect(function()
        if not hum.UseJumpPower then
            SetJump()
        end
    end)

    -- Chống game đổi WalkSpeed
    hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if hum.WalkSpeed ~= getgenv().WalkSpeedValue then
            SetSpeed()
        end
    end)

    -- ✅ Bỏ GetPropertyChangedSignal("JumpPower") vì nó gây conflict loop
    -- Thay bằng loop ngắn riêng bên dưới
end

-- ==============================
-- 2. KHI NHÂN VẬT XUẤT HIỆN
-- ==============================
lp.CharacterAdded:Connect(function(char)
    ApplyHumanoid(char)
end)

if lp.Character then
    ApplyHumanoid(lp.Character)
end

-- ==============================
-- 3. LOOP DỰ PHÒNG
-- ==============================
task.spawn(function()
    while task.wait(0.2) do
        local char = lp.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                -- Chỉ fix khi đang đứng/chạy, KHÔNG fix khi đang nhảy
                local state = hum:GetState()
                local isMidAir = (
                    state == Enum.HumanoidStateType.Jumping or
                    state == Enum.HumanoidStateType.Freefall
                )

                if not isMidAir then
                    if not hum.UseJumpPower then
                        hum.UseJumpPower = true
                    end
                    if hum.JumpPower ~= getgenv().JumpValue then
                        hum.JumpPower = getgenv().JumpValue
                    end
                end

                if hum.WalkSpeed ~= getgenv().WalkSpeedValue then
                    hum.WalkSpeed = getgenv().WalkSpeedValue
                end
            end
        end
    end
end)

-- ==============================
-- 4. SLIDER UI
-- ==============================

-- Slider Tăng Tốc Chạy
Tabs.PlayerPVP:AddSlider("Auto_AddSlider_4", {
    Title = "Tăng Tốc Chạy",
    Min = 100,
    Max = 300,
    Default = getgenv().WalkSpeedValue,
    Callback = function(Value)
        getgenv().WalkSpeedValue = Value
        local hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = Value
        end
    end
})

-- Slider Tăng Sức Bật Nhảy
Tabs.PlayerPVP:AddSlider("Auto_AddSlider_5", {
    Title = "Tăng Sức Bật Nhảy",
    Min = 70,
    Max = 350,
    Default = getgenv().JumpValue,
    Description = "Chỉnh Tối Đa Từ 200-300 Là Ngon Nhất",
    Callback = function(Value)
        getgenv().JumpValue = Value
        local hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = Value
        end
    end
})


Tabs.PlayerPVP:AddSection("Visual")
Tabs.PlayerPVP:AddButton({
    Title = "Bật Chiêu V Control",
    Callback = function()
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local ControlVCutscene = require(ReplicatedStorage.Effect.Container.ControlRework.V_Cutscene)
        ControlVCutscene({
            Stage = 2,
            Player = player,
            Root = root,
            Character = character,
            Origin = root.Position,
            CaughtPlayers = {}
        })
    end
})
Tabs.PlayerPVP:AddButton({
    Title = "Bật Chiêu V Gravity",
    Callback = function()
        local P   = game:GetService("Players").LocalPlayer
        local C   = P.Character or P.CharacterAdded:Wait()
        local R   = C:WaitForChild("HumanoidRootPart")
        local pos = R.Position + R.CFrame.LookVector * 15
        local hit = workspace:Raycast(pos + Vector3.yAxis * 20, Vector3.yAxis * -100)

        if hit then pos = hit.Position end

        local h   = Instance.new("BoolValue", C)
        h.Name    = "Holding"
        h.Value   = true

        pcall(require(game.ReplicatedStorage.Effect.Container.Gravity.V), {
            Stage          = 4,
            Root           = R,
            Origin         = R.Position,
            Caster         = P,
            Character      = C,
            TargetPosition = pos,
            CanUltimate    = true,
            NightShift     = true,
            CaughtCutscene = {P},
            CaughtLighting = {P},
            Holding        = h,
        })

        task.delay(15, function() h:Destroy() end)
    end
})
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local plr = Players.LocalPlayer

Tabs.PlayerPVP:AddButton({
    Title = "Mưa Thiên Thạch",
    Callback = function()
        local char = plr.Character
        if not char then return end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local ok, module = pcall(function()
            return require(RS:WaitForChild("Effect"):WaitForChild("Container"):WaitForChild("UzothSpec"))
        end)

        if ok and module then
            pcall(function()
                module({
                    Position = root.Position
                })
            end)
        end
    end
})
Tabs.PlayerPVP:AddButton({
    Title = "Tensei",
    Callback = function()
        local player = game.Players.LocalPlayer
        if not player then return end

        local orbPart = game.ReplicatedStorage.Effect.Container.tensei.orb.Part
        if not orbPart:FindFirstChild("sfx") then
            local sfx = Instance.new("Sound")
            sfx.Name = "sfx"
            sfx.SoundId = "rbxassetid://3848081992"
            sfx.Parent = orbPart
        end

        local effectModule = require(game.ReplicatedStorage.Effect.Container.tensei)

        -- Xóa tool cũ nếu có
        local oldTool = player.Backpack:FindFirstChild("tensei") 
            or (player.Character and player.Character:FindFirstChild("tensei"))
        if oldTool then oldTool:Destroy() end

        local tool = Instance.new("Tool")
        tool.Name = "tensei"
        tool.RequiresHandle = false
        tool.CanBeDropped = false
        tool.Parent = player:WaitForChild("Backpack")

        local mouse = player:GetMouse()
        local equipped = false

        tool.Equipped:Connect(function() equipped = true end)
        tool.Unequipped:Connect(function() equipped = false end)

        tool.Activated:Connect(function()
            if not equipped or not mouse.Target then return end

            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            local targetPos = mouse.Hit.Position

            if (targetPos - hrp.Position).Magnitude > 350 then return end

            local spawnPos = targetPos + Vector3.new(0, 115, 0)
            local targetCF = CFrame.new(spawnPos) * CFrame.Angles(math.rad(-90), 0, 0)

            effectModule({
                char     = char,
                target   = mouse.Target,
                max      = 20,
                targetCF = targetCF,
            })
        end)
    end
})
Tabs.PlayerPVP:AddButton({
    Title = "Divine Art",
    Callback = function()
        local Players = game:GetService("Players")
        local RS = game:GetService("ReplicatedStorage")
        local Lighting = game:GetService("Lighting")
        local LP = Players.LocalPlayer

        -- Lấy module điều khiển di chuyển của Roblox
        local PlayerScripts = LP:WaitForChild("PlayerScripts")
        local ControlModule = require(PlayerScripts:WaitForChild("PlayerModule")):GetControls()

        local ToolIconID = "rbxassetid://78757128347056" 

        local originalAmbient = nil
        local originalOutdoor = nil

        -- Xóa tool + UI cũ
        local oldTool = LP.Backpack:FindFirstChild("Divine Art")
            or (LP.Character and LP.Character:FindFirstChild("Divine Art"))
        if oldTool then oldTool:Destroy() end
        local oldGui = game.CoreGui:FindFirstChild("DivineArtUI")
        if oldGui then oldGui:Destroy() end

        -- Tool
        local tool = Instance.new("Tool")
        tool.Name = "Divine Art"
        tool.RequiresHandle = false
        tool.TextureId = ToolIconID
        tool.Parent = LP.Backpack

        -- Logic ép thanh Hotbar hiển thị ảnh thay vì chữ
        local function FixHotbarIcon()
            task.wait(0.2)
            local PlayerGui = LP:FindFirstChildOfClass("PlayerGui")
            if PlayerGui then
                for _, v in ipairs(PlayerGui:GetDescendants()) do
                    if v:IsA("TextLabel") and v.Text == "Divine Art" then
                        v.Text = ""
                        if not v:FindFirstChild("CustomIcon") then
                            local img = Instance.new("ImageLabel")
                            img.Name = "CustomIcon"
                            img.Size = UDim2.new(0.8, 0, 0.8, 0)
                            img.Position = UDim2.new(0.1, 0, 0.1, 0)
                            img.BackgroundTransparency = 1
                            img.Image = ToolIconID
                            img.Parent = v
                        end
                    end
                end
            end
        end
        task.spawn(FixHotbarIcon)

        local Cont = RS.Effect.Container
        local m1 = require(Cont.Angel.M1)
        local m2 = require(Cont.Angel2.M1)
        local Effect = require(RS.Effect)

        local S = { cc = 0, lt = 0, db = false }

        local function getHRP()
            local c = LP.Character
            return c and c:FindFirstChild("HumanoidRootPart")
        end

        local function getClosestEnemy(R)
            local target, bestDist = nil, math.huge
            for _, mob in ipairs(workspace.Enemies:GetChildren()) do
                local hrp = mob:FindFirstChild("HumanoidRootPart")
                local hum = mob:FindFirstChild("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    local dist = (hrp.Position - R.Position).Magnitude
                    if dist < bestDist then bestDist = dist target = hrp end
                end
            end
            return target
        end

        local Combo = {
            [1] = { Name = "Strike",  Action = function(hrp) for i = 1, 4 do m1({ hrp = hrp, index = i }) task.wait(0.10) end end },
            [2] = { Name = "Rush",    Action = function(hrp) for i = 1, 4 do m2({ hrp = hrp, index = i }) task.wait(0.10) end end },
            [3] = { Name = "Rush II", Action = function(hrp) for i = 1, 4 do m2({ hrp = hrp, index = i }) task.wait(0.08) end end },
            [4] = { Name = "Burst",   Action = function(hrp) for i = 4, 1, -1 do m2({ hrp = hrp, index = i }) task.wait(0.07) end end },
            [5] = { Name = "Flurry",  Action = function(hrp) for i = 1, 4 do m1({ hrp = hrp, index = i }) task.wait(0.07) m2({ hrp = hrp, index = i }) task.wait(0.07) end end },
            [6] = { Name = "Storm",   Action = function(hrp) for i = 1, 8 do m2({ hrp = hrp, index = (i % 4) + 1 }) task.wait(0.06) end end },
            [7] = { Name = "Finale",  Action = function(hrp)
                for i = 1, 4 do m1({ hrp = hrp, index = i }) task.wait(0.05) end
                for i = 1, 4 do m2({ hrp = hrp, index = i }) task.wait(0.05) end
                for i = 4, 1, -1 do m2({ hrp = hrp, index = i }) task.wait(0.04) end
            end },
        }

        -- UI
        local gui = Instance.new("ScreenGui")
        gui.Name = "DivineArtUI"
        gui.ResetOnSpawn = false
        gui.Enabled = false
        gui.Parent = game.CoreGui

        local function MakeBtn(name, pos, cb)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 65, 0, 65)
            btn.Position = pos
            btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            btn.BackgroundTransparency = 0.5
            btn.BorderSizePixel = 0
            btn.Text = name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextScaled = true
            btn.Font = Enum.Font.GothamBold
            btn.Parent = gui

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0.5, 0)
            corner.Parent = btn

            local stroke = Instance.new("UIStroke")
            stroke.Thickness = 2.5
            stroke.Color = Color3.fromRGB(200, 200, 200)
            stroke.Transparency = 0.2
            stroke.Parent = btn

            btn.MouseButton1Click:Connect(cb)
        end

        -- Skill Z
        MakeBtn("Z", UDim2.new(1, -120, 1, -240), function()
            local R = getHRP()
            if not R then return end
            local target = getClosestEnemy(R)

            pcall(function()
                local holdingVal = Instance.new("BoolValue")
                holdingVal.Value = true

                require(Cont.Angel.Z)({
                    Root         = R,
                    Character    = LP.Character,
                    EnemyRoot    = target or R,
                    ExplosionPos = target and target.Position or R.Position + R.CFrame.LookVector * 20,
                    Hakai        = false,
                    CFrame       = R.CFrame,
                    Holding      = holdingVal,
                    hrp          = R,
                    player       = LP,
                })

                task.wait(2)
                holdingVal.Value = false
            end)
        end)

        -- Skill X
        MakeBtn("X", UDim2.new(1, -165, 1, -165), function()
            local R = getHRP()
            if not R then return end

            local args = {
                delayUntilImpact = 1.2,
                lastsFor         = 2.5,
                player           = LP,
                hrp              = R,
                Root             = R,
                Character        = LP.Character,
                impactPos        = R.Position + R.CFrame.LookVector * 30,
            }
            pcall(function()
                require(Cont.Angel.XCameraChains)(args)
                require(Cont.Angel.XCharChains)(args)
            end)
        end)

        -- Skill C (Đã thêm logic vô hiệu hóa di chuyển, nhảy, lướt hoàn toàn)
        MakeBtn("C", UDim2.new(1, -210, 1, -90), function()
            local R = getHRP()
            local Char = LP.Character
            if not R or not Char then return end
            local Hum = Char:FindFirstChildOfClass("Humanoid")

            pcall(function()
                -- 1. KHÓA DI CHUYỂN, LƯỚT VÀ NHẢY NGAY LẬP TỨC
                ControlModule:Disable() -- Khóa phím di chuyển WASD / Joystick trên điện thoại (chặn cả lướt)
                local oldJumpPower = Hum.JumpPower
                local oldJumpHeight = Hum.JumpHeight
                Hum.JumpPower = 0 -- Khóa nhảy
                Hum.JumpHeight = 0

                Lighting.Ambient = Color3.fromRGB(100, 100, 100)
                Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)

                local ccEffect = Lighting:FindFirstChild("DivineArtDarkness")
                if not ccEffect then
                    ccEffect = Instance.new("ColorCorrectionEffect")
                    ccEffect.Name = "DivineArtDarkness"
                    ccEffect.Contrast = 0.25 
                    ccEffect.Brightness = -0.05 
                    ccEffect.Parent = Lighting
                end

                local airPart = nil
                local raycastParams = RaycastParams.new()
                raycastParams.FilterDescendantsInstances = {Char}
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude

                local rayResult = workspace:Raycast(R.Position, Vector3.new(0, -30, 0), raycastParams)
                if not rayResult or (R.Position.Y - rayResult.Position.Y) > 5 then
                    airPart = Instance.new("Part")
                    airPart.Name = "DivineAirPlatform"
                    airPart.Size = Vector3.new(25, 1, 25)
                    airPart.CFrame = R.CFrame * CFrame.new(0, -3.5, 0)
                    airPart.Transparency = 1 
                    airPart.Anchored = true
                    airPart.CanCollide = true
                    airPart.Parent = workspace
                end

                local holdingVal = Instance.new("BoolValue")
                holdingVal.Value = true

                local Util = require(RS.Util)
                local animTrack = Util.Anims:Get(Char, "AngelCStart")
                if animTrack then animTrack:Play() end

                require(Cont.Angel2.C)({
                    Root      = R,
                    Character = Char,
                    hrp       = R,
                    CFrame    = R.CFrame,
                    player    = LP,
                    Holding   = holdingVal,
                    Charge    = holdingVal,
                    Color     = Color3.fromRGB(255, 215, 0),
                    Size      = 500, 
                    Range     = 500,
                    Radius    = 500,
                })

                -- Đợi 3.5 giây skill chạy xong để dọn dẹp và mở khóa nhân vật
                task.delay(1.9, function()
                    holdingVal.Value = false
                    if airPart then airPart:Destroy() end
                    if ccEffect then ccEffect:Destroy() end
                    if animTrack then animTrack:Stop() end
                    
                    if originalAmbient and originalOutdoor then
                        Lighting.Ambient = originalAmbient
                        Lighting.OutdoorAmbient = originalOutdoor
                    end

                    -- 2. MỞ KHÓA DI CHUYỂN, LƯỚT VÀ NHẢY TRỞ LẠI BÌNH THƯỜNG
                    ControlModule:Enable() -- Bật lại hệ thống di chuyển gốc
                    if Hum then
                        Hum.JumpPower = oldJumpPower
                        Hum.JumpHeight = oldJumpHeight
                    end
                end)
            end)
        end)

        tool.Equipped:Connect(function() 
            gui.Enabled = true 
            if Lighting.Ambient ~= Color3.fromRGB(100,100,100) and Lighting.Ambient ~= Color3.fromRGB(0,0,0) then
                originalAmbient = Lighting.Ambient
                originalOutdoor = Lighting.OutdoorAmbient
            end
        end)
        
        tool.Unequipped:Connect(function() 
            gui.Enabled = false 
            ControlModule:Enable() -- Đảm bảo không bị kẹt khóa di chuyển khi cất tool đột ngột
            local platform = workspace:FindFirstChild("DivineAirPlatform")
            if platform then platform:Destroy() end
        end)
        
        tool.Destroying:Connect(function() 
            if gui then gui:Destroy() end 
            ControlModule:Enable()
            local platform = workspace:FindFirstChild("DivineAirPlatform")
            if platform then platform:Destroy() end
        end)

        tool.Activated:Connect(function()
            if S.db then return end
            local hrp = getHRP()
            if not hrp then return end
            local now = tick()
            if now - S.lt > 0.5 then S.cc = 0 end
            S.lt = now
            S.cc = S.cc + 1
            local cb = Combo[S.cc]
            if not cb then S.cc = 0 return end
            S.db = true
            cb.Action(hrp)
            S.db = false
            if S.cc >= #Combo then S.cc = 0 end
        end)
    end
})


Tabs.PlayerPVP:AddButton({
    Title = "View Leviathan",
    Callback = function()
        local Players = game:GetService("Players")
        local plr     = Players.LocalPlayer
        local char    = plr.Character or plr.CharacterAdded:Wait()
        local hrp     = char:WaitForChild("HumanoidRootPart")
        local folder  = plr.PlayerScripts:WaitForChild("LeviathanCinematicc")
        local cine    = require(folder.Intro)()
        local offset  = hrp.Position + hrp.CFrame.LookVector * 120

        for _, v in ipairs(workspace:GetChildren()) do
            if v.Name:match("Leviathan") then
                local root = v:FindFirstChild("RootPart")
                if root then v:PivotTo(CFrame.new(offset)) end
            end
        end

        cine:Play()
        task.delay(14, function() cine:Destroy() end)
    end
})
Tabs.PlayerPVP:AddButton({
    Title = "Mưa Trái Ác Quỷ",
    Callback = function()
        task.spawn(function()
            local g = game
            local plr = g.Players.LocalPlayer
            local char = plr.Character or plr.CharacterAdded:Wait()
            local Backpack = plr:WaitForChild("Backpack")
            local HRP = char:WaitForChild("HumanoidRootPart")

            local objs = g:GetObjects("rbxassetid://96375671161494")
            if not objs[1] then return end

            local root = objs[1]:FindFirstChildOfClass("Folder") or objs[1]:GetChildren()[1]
            if not root then return end

            for _, Fruit in ipairs(root:GetChildren()) do
                for _, d in ipairs(Fruit:GetDescendants()) do
                    if d:IsA("BasePart") then
                        d.CanCollide = true
                        d.CanTouch = true
                    end
                end

                Fruit.Parent = workspace
                Fruit:MoveTo(HRP.Position + Vector3.new(math.random(-50,50), 100, math.random(-50,50)))

                if Fruit:FindFirstChild("Handle") then
                    Fruit.Handle.Touched:Connect(function(hit)
                        if hit.Parent == char then
                            Fruit.Parent = Backpack
                            char.Humanoid:EquipTool(Fruit)
                        end
                    end)
                end
            end
        end)
    end
})


Tabs.Travel:AddSection("Travel - Worlds")

Tabs.Travel:AddButton({
Title = "Dịch Chuyển To World 1", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelMain")
end})
Tabs.Travel:AddButton({
Title = "Dịch Chuyển To World 2", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
end})
Tabs.Travel:AddButton({
Title = "Dịch Chuyển To World 3", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelZou")
end})
Tabs.Travel:AddSection("Travel - Island")
Location = {}
for i,v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do  
  table.insert(Location ,v.Name)
end
Travelllll = Tabs.Travel:AddDropdown("Travelllll", {
Title = "Chọn Travelling",
Flag = "Travelllll",
Description = "",
Values = Location,
,
Callback = function(Value)
  _G.Island = Value
end})
GoIsland = Tabs.Travel:AddToggle("GoIsland", {
Title = "Tự Động Travel", 
Flag = "GoIsland",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Teleport = Value
  if Value then
    for i,v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do
      if v.Name == _G.Island then
        repeat wait()
	     _tp(v.CFrame * CFrame.new(0, 30, 0)) 
        until not _G.Teleport or Root.CFrame == v.CFrame
      end
    end
  end
end
})





Tabs.Shop:AddSection("Shop Options")
Tabs.Shop:AddButton({
Title = "Mua Haki Tay", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Buso")
end})
Tabs.Shop:AddButton({
Title = "Mua Nhảy Liên Tục", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
end})
Tabs.Shop:AddButton({
Title = "Mua Dịch Chuyển", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Soru")
end})
Tabs.Shop:AddButton({
Title = "Mua Haki Quan Sát", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("KenTalk","Buy")
end})

Tabs.Shop:AddSection("Fighting - Style")


do
World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

lp = game:GetService("Players").LocalPlayer
replicated = game:GetService("ReplicatedStorage")
TweenService = game:GetService("TweenService")
RunService = game:GetService("RunService")

MeleeCoords = {
    ["Dark Step"] = { Key = "BuyBlackLeg", Pos = World1 and CFrame.new(-985, 13, 3988) or World2 and CFrame.new(-4753, 35, -4850) or World3 and CFrame.new(-5045, 371, -3181) },
    ["Electric"] = { Key = "BuyElectro", Pos = World1 and CFrame.new(-5384, 13, -2148) or World2 and CFrame.new(-4867, 35, -4766) or World3 and CFrame.new(-4995, 314, -3203) },
    ["Water Kung Fu"] = { Key = "BuyFishmanKarate", Pos = World1 and CFrame.new(61585, 18, 987) or World2 and CFrame.new(-4958, 35, -4668) or World3 and CFrame.new(-5023, 371, -3190) },
    ["Dragon Breath"] = { Key = "BuyDragonClaw", Pos = World2 and CFrame.new(701, 187, 655) or World3 and CFrame.new(-4981, 371, -3207) },
    ["Superhuman"] = { Key = "BuySuperhuman", Pos = World2 and CFrame.new(1374, 247, -5192) or World3 and CFrame.new(-5004, 371, -3198) },
    ["Death Step"] = { Key = "BuyDeathStep", Pos = World2 and CFrame.new(6357, 296, -6762) or World3 and CFrame.new(-4999, 314, -3221) },
    ["Sharkman Karate"] = { Key = "BuySharkmanKarate", Pos = World2 and CFrame.new(-2602, 238, -10316) or World3 and CFrame.new(-4972, 314, -3222) },
    ["Dragon Talon"] = { Key = "BuyDragonTalon", Pos = World3 and CFrame.new(5661, 1211, 865) },
    ["Electric Claw"] = { Key = "BuyElectricClaw", Pos = World3 and CFrame.new(-10371, 331, -10131) },
    ["Godhuman"] = { Key = "BuyGodhuman", Pos = World3 and CFrame.new(-13776, 334, -9879) },
    ["Sanguine Art"] = { Key = "BuySanguineArt", Pos = World3 and CFrame.new(-16353, 160, 99) }
}


local function TweenTo(targetCFrame)
    if not targetCFrame then return end
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = char.HumanoidRootPart
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local speed = 300 -- Tốc độ bay (chuẩn an toàn của Blox Fruits)
    local tweenTime = distance / speed
    
    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    
    -- 1. Tạo BodyVelocity để giữ nhân vật lơ lửng, chống lại trọng lực (Cách fix giật màn hình)
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Parent = hrp
    
    -- 2. Bật Xuyên tường (NoClip) liên tục để không va đập vào núi đá khi bay
    local noclip
    noclip = RunService.Stepped:Connect(function()
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
    
    -- 3. Bắt đầu bay
    tween:Play()
    tween.Completed:Wait() -- Chờ bay đến nơi
    
    -- 4. Dọn dẹp sau khi bay xong (hạ cánh)
    if bv then bv:Destroy() end
    if noclip then noclip:Disconnect() end
    
    task.wait(0.5) -- Đợi 0.5s để Server load NPC và map (Rất quan trọng để mua không bị xịt)
end


local function CreateMeleeButton(DisplayName, DictName)
    Tabs.Shop:AddButton({
        Title = DisplayName, 
        Description = "Tween Đến & Mua",
        Callback = function()
            local data = MeleeCoords[DictName]
            if data then
                -- 1. Bay tới NPC
                if data.Pos then
                    TweenTo(data.Pos)
                else
                    warn("Võ này không có ở Sea hiện tại!")
                    return
                end
                
                -- 2. Gọi lệnh mua an toàn
                if data.Key == "BuyDragonClaw" then
                    local res = replicated.Remotes.CommF_:InvokeServer("BuyDragonClaw")
                    if not res then
                        replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
                    end
                else
                    -- Ép gửi lệnh mua 2 lần để vượt qua hộp thoại xác nhận của NPC
                    replicated.Remotes.CommF_:InvokeServer(data.Key)
                    task.wait(0.2)
                    replicated.Remotes.CommF_:InvokeServer(data.Key)
                end
            end
        end
    })
end

-- Tự động tạo các nút Shop
CreateMeleeButton("Mua Hắc Cước (Black Leg)", "Dark Step")
CreateMeleeButton("Mua Electro", "Electric")
CreateMeleeButton("Mua Võ Người Cá V1", "Water Kung Fu")
CreateMeleeButton("Mua Dragon Claw", "Dragon Breath")
CreateMeleeButton("Mua Superhuman", "Superhuman")
CreateMeleeButton("Mua Death Step", "Death Step")
CreateMeleeButton("Mua Võ Cá V2 (Sharkman)", "Sharkman Karate")
CreateMeleeButton("Mua Vuốt Điện V2 (Electric Claw)", "Electric Claw")
CreateMeleeButton("Mua Võ Rồng V2 (Dragon Talon)", "Dragon Talon")
CreateMeleeButton("Mua Thần Diệt Quyền (Godhuman)", "Godhuman")
CreateMeleeButton("Mua Sanguine Art", "Sanguine Art")




Tabs.Shop:AddSection("Accessory")
Tabs.Shop:AddButton({
Title = "Mua Tomoe Ring", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Tomoe Ring")
end})
Tabs.Shop:AddButton({
Title = "Mua Black Cape", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Black Cape")
end})
Tabs.Shop:AddButton({
Title = "Mua Swordsman Hat", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Swordsman Hat")
end})
Tabs.Shop:AddButton({
Title = "Mua Bizarre Rifle", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 1)
end})
Tabs.Shop:AddButton({
Title = "Mua Ghoul Mask", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 2)
end})

Tabs.Shop:AddSection("Accessory SeaEvent")
Tabs.Shop:AddButton({
Title = "Chế Tạo Dragonheart", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","Dragonheart");
end})
Tabs.Shop:AddButton({
Title = "Chế Tạo Dragonstorm", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","Dragonstorm");
end})
Tabs.Shop:AddButton({
Title = "Chế Tạo DinoHood", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","DinoHood");
end})   
Tabs.Shop:AddButton({
Title = "Chế Tạo SharkTooth", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","SharkTooth");
end})   
Tabs.Shop:AddButton({
Title = "Chế Tạo TerrorJaw", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","TerrorJaw");
end})   
Tabs.Shop:AddButton({
Title = "Chế Tạo SharkAnchor", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","SharkAnchor");
end})   
Tabs.Shop:AddButton({
Title = "Chế Tạo LeviathanCrown", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","LeviathanCrown");
end})   
Tabs.Shop:AddButton({
Title = "Chế Tạo LeviathanShield", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","LeviathanShield");
end})   
Tabs.Shop:AddButton({
Title = "Chế Tạo LeviathanBoat", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","LeviathanBoat");
end})   
Tabs.Shop:AddButton({
Title = "Chế Tạo LegendaryScroll", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","LegendaryScroll");
end})   
Tabs.Shop:AddButton({
Title = "Chế Tạo MythicalScroll", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","MythicalScroll");
end})   

Tabs.Shop:AddSection("Weapon World1")
Tabs.Shop:AddButton({
Title = "Mua Cutlass", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
end})
Tabs.Shop:AddButton({
Title = "Mua Katana", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Katana")
end})
Tabs.Shop:AddButton({
Title = "Mua Iron Mace", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
end})   
Tabs.Shop:AddButton({
Title = "Mua Duel Katana", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
end})   
Tabs.Shop:AddButton({
Title = "Mua Triple Katana", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
end})  
Tabs.Shop:AddButton({
Title = "Mua Pipe", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Pipe")
end})  
Tabs.Shop:AddButton({
Title = "Mua Dual-Headed Blade", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
end})   
Tabs.Shop:AddButton({
Title = "Mua Bisento", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Bisento")
end})  
Tabs.Shop:AddButton({
Title = "MuaSoul Cane", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
end})
Tabs.Shop:AddButton({
Title = "Mua Slingshot", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Slingshot")
end})
Tabs.Shop:AddButton({
Title = "Mua Musket", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Musket")
end})    
Tabs.Shop:AddButton({
Title = "Mua Dual Flintlock", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Dual Flintlock")
end})   
Tabs.Shop:AddButton({
Title = "Mua Flintlock", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Flintlock")
end})   
Tabs.Shop:AddButton({
Title = "Mua Refined Flintlock", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock")
end})   
Tabs.Shop:AddButton({
Title = "Mua Cannon", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Cannon")
end}) 
Tabs.Shop:AddButton({
Title = "Mua Kabucha", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
end})

Tabs.Shop:AddSection("Fragments shop")
Tabs.Shop:AddButton({
Title = "Hoàn Lại Chỉ Số", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
end})
Tabs.Shop:AddButton({
Title = "Đổi Tộc", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
end})   
Tabs.Shop:AddButton({
Title = "Mua Tộc Quỷ (2.5k)", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm"," Change", 4)
end})	
Tabs.Shop:AddButton({
Title = "Mua Tộc Người Máy (2.5k)", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CyborgTrainer"," Buy")
end})

end
Tabs.Misc:AddSection("Server - Function")
Tabs.Misc:AddButton({
Title = "Vào Lại Server", 
Description = "",
Callback = function()
  game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end})
Tabs.Misc:AddButton({
Title = "Chuyển Server", 
Description = "",
Callback = function()
  Hop()
end})
Tabs.Misc:AddButton({
Title = "Chuyển Đến Sever Ít Người", 
Description = "",
Callback = function()
  local Http = game:GetService("HttpService")
  local TPS = game:GetService("TeleportService")
  local Api = "https://games.roblox.com/v1/games/"
  local _place = game.PlaceId
  local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
   function ListServers(cursor)
     local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
     return Http:JSONDecode(Raw)
   end
   local Server, Next; repeat
   local Servers = ListServers(Next)
   Server = Servers.data[1]
   Next = Servers.nextPageCursor
  until Server
  TPS:TeleportToPlaceInstance(_place,Server.id,plr)
end})

Tabs.Misc:AddButton({
Title = "Chuyển Đến Sever Ping Thấp", 
Description = "",
Callback = function()
HTTPService = game:GetService("HttpService")
TeleportService = game:GetService("TeleportService")
StatsService = game:GetService("Stats")
local function fetchServersData(placeId, limit)
    local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?limit=%d", placeId, limit)
    local success, response = pcall(function()
        return HTTPService:JSONDecode(game:HttpGet(url))
    end)
  if success and response and response.data then
	return response.data
  end
    return nil
  end
  local placeId = game.PlaceId
  local serverLimit = 100
  local servers = fetchServersData(placeId, serverLimit)
  if not servers then return end
  local lowestPingServer = servers[1]
  for _, server in pairs(servers) do
    if server["ping"] < lowestPingServer["ping"] and server.maxPlayers > server.playing then
      lowestPingServer = server
    end
  end
  local commonLoadTime = 0.5
  task.wait(commonLoadTime)
  local pingThreshold = 100
  local serverStats = StatsService.Network.ServerStatsItem
  local dataPing = serverStats["Data Ping"]:GetValueString()
  local pingValue = tonumber(dataPing:match("(%d+)"))
  if pingValue >= pingThreshold then
    TeleportService:TeleportToPlaceInstance(placeId, lowestPingServer.id)
  else
    --pings
  end
end})


targetJobID = ""

Tabs.Misc:AddInput("JobID_Input", {
    Title = "Nhập Job ID",
    Default = "",
    Placeholder = "Dán Job ID Vào Đây",
    Callback = function(Value)
        targetJobID = Value
    end
})

Tabs.Misc:AddButton({
    Title = "Dịch Chuyển [Job ID]",
    Callback = function()
        if targetJobID ~= "" then
            replicated['__ServerBrowser']:InvokeServer("teleport", targetJobID)
        else
            warn("Vui Lòng Nhập Job ID!")
        end
    end
})

Tabs.Misc:AddButton({
Title = "Copy JobID", 
Description = "",
Callback = function()
  setclipboard(tostring(game.JobId))
end})

Tabs.Misc:AddSection("Player Gui / Others")

Tabs.Misc:AddButton({
Title = "Mở Chuyên Gia Thức Tỉnh", 
Description = "",
Callback = function()
  plr.PlayerGui.Main.AwakeningToggler.Visible = true
end})
Tabs.Misc:AddButton({
Title = "Mở Lựa Chọn Danh Hiệu", 
Description = "",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("getTitles",true)
  plr.PlayerGui.Main.Titles.Visible = true
end})
DisbleChat = Tabs.Misc:AddToggle("DisbleChat", {
Title = "Vô Hiệu Hoá Khung Chat", 
Flag = "DisbleChat",
Description = "", 
Default = false,
Callback = function(Value)
  _G.Rechat = Value
  if  _G.Rechat == true then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)    
  elseif _G.chat == false then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)    
  end
end
})

DisbleLeaderB = Tabs.Misc:AddToggle("DisbleLeaderB", {
Title = "Vô Hiệu Hóa Giao Diện Bảng Xếp Hạng", 
Flag = "DisbleLeaderB",
Description = "", 
Default = false,
Callback = function(Value)
  ReLeader = Value
  if ReLeader == true then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)   
  elseif ReLeader == false then
    local StarterGui = game:GetService('StarterGui')
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)   
  end
end
})
Tabs.Misc:AddButton({
Title = "Sang Hải Tặc", 
Description = "",
Callback = function()
  Pirates()
end})  
Tabs.Misc:AddButton({
Title = "Sang Hải Quân", 
Description = "",
Callback = function()
  Marines()
end})
UnPortal = Tabs.Misc:AddToggle("UnPortal", {
Title = "Unlock All Portals", 
Flag = "UnPortal",
Description = "", 
Default = false,
Callback = function(Value)
  _G.PortalUnLock = Value
end})
task.spawn(function()
  while task.wait(Sec) do
    pcall(function()
      if _G.PortalUnLock then        
         if Attack.Pos(CstlePos_Miti,8) then
           replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
         elseif Attack.Pos(Man3Pos_Miti,8) then
           replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5072.08984375, 314.5412902832, -3151.1098632812))
         elseif Attack.Pos(HydraPos_Miti,8) then                    
           replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5748.7587890625, 610.44982910156, -267.81704711914))
         elseif Attack.Pos(HydratoCastle,8) then                   
           replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5072.08984375, 314.5412902832, -3151.1098632812))
        end
      end
    end)
  end
end)
Tabs.Misc:AddButton({
    Title = "Redeem All Codes",
    Description = "",
    Default = false,
    Callback = function(Value)  -- Value nil/false, không ảnh hưởng
        print("[Redeem Button] Bắt đầu redeem codes WORKING 2026...")

        -- DANH SÁCH WORKING (cập nhật 02/2026 - chỉ codes active)
        local codes = {
            "LIGHTNINGABUSE",          -- 2x EXP 20p (mới nhất, active)
            "KITT_RESET",              -- Stat Reset
            "SUB2GAMERROBOT_RESET1",   -- Stat Reset
            "Sub2UncleKizaru",         -- Stat Reset
            "Sub2CaptainMaui",         -- 2x EXP 20p
            "kittgaming",              -- 2x EXP 20p
            "Sub2Fer999",              -- 2x EXP 20p
            "Enyu_is_Pro",             -- 2x EXP 20p
            "Magicbus",                -- 2x EXP 20p
            "JCWK",                    -- 2x EXP 20p
            "Starcodeheo",             -- 2x EXP 20p
            "Bluxxy",                  -- 2x EXP 20p (hoặc BLUXXY)
            "Axiore",                  -- 2x EXP 20p
            "SUB2OFFICIALNOOBIE",      -- 2x EXP 20p
            "AXIORE",                  -- 2x EXP 20p
            "BIGNEWS",                 -- Title "BIGNEWS"
            "fudd10_v2",               -- $2 Beli
            "Fudd10",                  -- $1 Beli
            "Chandler",                -- Reward nhỏ hoặc title
            "SUB2NOOBMASTER123",       -- 2x EXP (từ một số nguồn)
            "Sub2Daigrock",            -- 2x EXP
            "TantaiGaming",            -- 2x EXP
            "StrawHatMaine",           -- 2x EXP
            "THEGREATACE"              -- 2x EXP
        }

        local total = #codes
        local successCount = 0

        for i, code in ipairs(codes) do
            print(string.format("[%d/%d] Thử redeem: %s", i, total, code))

            local success, err = pcall(function()
                game:GetService("ReplicatedStorage")
                    :WaitForChild("Remotes")
                    :WaitForChild("Redeem")
                    :InvokeServer(code)
            end)

            if success then
                successCount = successCount + 1
            else
                warn("Lỗi redeem " .. code .. ": " .. tostring(err or "Unknown"))
            end

            task.wait(0.45)  -- Delay 0.45s → an toàn hơn, tránh kick
        end

        print("Hoàn thành! Đã thử redeem " .. successCount .. "/" .. total .. " codes.")
        print("Lưu ý: Codes đã redeem trước hoặc hết hạn sẽ không cho reward mới.")

        -- Notify popup trong game
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Redeem Codes",
                Text = "Đã Redeem " .. successCount .. "/" .. total .. " Code",
                Duration = 8
            })
        end)
    end
})
Tabs.Misc:AddSection("Graphics / Haki Stats")

HakiSt = {"State 0","State 1","State 2","State 3","State 4","State 5"}
HakiStat = Tabs.Misc:AddDropdown("HakiStat", {
Title = "Chọn Haki States",
Flag = "HakiStat",
Values = HakiSt,
,
Callback = function(Value)
  _G.SelectStateHaki = Value
end})
Tabs.Misc:AddButton({
Title = "ChangeBusoStage", 
Description = "",
Callback = function()
  if _G.SelectStateHaki == "State 0" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",0)
  elseif _G.SelectStateHaki == "State 1" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",1)
  elseif _G.SelectStateHaki == "State 2" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",2)
  elseif _G.SelectStateHaki == "State 3" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",3)
  elseif _G.SelectStateHaki == "State 4" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",4)
  elseif _G.SelectStateHaki == "State 5" then
    replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",5)
  end
end})
rtxM = Tabs.Misc:AddToggle("rtxM", {
Title = "Bật RTX Mode", 
Flag = "rtxM",
Description = "", 
Default = false,
Callback = function(Value)
  _G.RTXMode = Value
  local a = game.Lighting
  local c = Instance.new("ColorCorrectionEffect", a)
  local e = Instance.new("ColorCorrectionEffect", a)
  OldAmbient = a.Ambient
  OldBrightness = a.Brightness
  OldColorShift_Top = a.ColorShift_Top
  OldBrightnessc = c.Brightness
  OldContrastc = c.Contrast
  OldTintColorc = c.TintColor
  OldTintColore = e.TintColor    
  if not _G.RTXMode then return end
  while _G.RTXMode do wait()
    a.Ambient = Color3.fromRGB(33, 33, 33)
    a.Brightness = 0.3
    c.Brightness = 0.176
    c.Contrast = 0.39
    c.TintColor = Color3.fromRGB(217, 145, 57)
    game.Lighting.FogEnd = 999
    if not plr.Character.HumanoidRootPart:FindFirstChild("PointLight") then
      local a2 = Instance.new("PointLight")
      a2.Parent = plr.Character.HumanoidRootPart
      a2.Range = 15
      a2.Color = Color3.fromRGB(217, 145, 57)
    end
    if not _G.RTXMode then
      a.Ambient = OldAmbient
      a.Brightness = OldBrightness
      a.ColorShift_Top = OldColorShift_Top
      c.Contrast = OldContrastc
      c.Brightness = OldBrightnessc
      c.TintColor = OldTintColorc
      e.TintColor = OldTintColore
      game.Lighting.FogEnd = 2500
      plr.Character.HumanoidRootPart:FindFirstChild("PointLight"):Destroy()
    end
  end
end
})
Tabs.Misc:AddButton({
Title = "Bật Chế Độ Nhanh", 
Description = "",
Callback = function()
  for _,zx in next, workspace:GetDescendants() do
  if table.find(Past, zx.ClassName) then  zx.Material = "Plastic" end
  end
end})
Tabs.Misc:AddButton({
Title = "Bật Chế Độ CPU Thấp", 
Description = "",
Callback = function()
  LowCpu()
end})
Tabs.Misc:AddButton({
Title = "Bật Tăng Tốc Thuyền", 
Description = "",
Callback = function()
  for _, v in pairs(workspace.Boats:GetDescendants()) do
    if table.find(ListSeaBoat, v.Name) and tostring(v.Owner.Value) == tostring(plr.Name) then              
      v.VehicleSeat.MaxSpeed = 350
      v.VehicleSeat.Torque = 0.2
      v.VehicleSeat.TurnSpeed = 5
      v.VehicleSeat.HeadsUpDisplay = true
    end
  end
end})
Tabs.Misc:AddButton({
Title = "Xoá Sương Mù", 
Description = "",
Callback = function()
  if Lighting:FindFirstChild("LightingLayers") then Lighting.LightingLayers:Destroy() end
  if Lighting:FindFirstChild("SeaTerrorCC") then Lighting.SeaTerrorCC:Destroy() end
  if Lighting:FindFirstChild("FantasySky") then Lighting.FantasySky:Destroy() end
end})

Tabs.Misc:AddSection("Configure - God")
briggt1 = Tabs.Misc:AddToggle("briggt1", {
Title = "Bật Max Tầm Nhìn", 
Flag = "briggt1",
Description = "", 
Default = false,
Callback = function(Value)
  bright = Value
  if Value == true then
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
    Lighting.ColorShift_Top = Color3.new(1, 1, 1)
  else
    Lighting.Ambient = Color3.new(0, 0, 0)
    Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
    Lighting.ColorShift_Top = Color3.new(0, 0, 0)
  end  
end
})


DayN = Tabs.Misc:AddDropdown("DayN", {
Title = "Chọn Thời Gian",
Flag = "DayN",
Description = "",
Values = {"Sáng", "Tối"},
,
Callback = function(Value)
  _G.SelectDN = Value
end})
dayornight = Tabs.Misc:AddToggle("dayornight", {
Title = "Bật Time", 
Flag = "dayornight",
Description = "", 
Default = false,
Callback = function(Value)
  _G.daylightN = Value
end})
task.spawn(function()
  while task.wait() do
    if _G.daylightN then
      if _G.SelectDN == "Day" then
        Lighting.ClockTime = 12
      elseif _G.SelectDN == "Night" then
        Lighting.ClockTime = 0
      end
    end
  end
end)
walkWater = Tabs.Misc:AddToggle("walkWater", {
Title = "Bật Đi Trên Nước", 
Flag = "walkWater",
Description = "", 
Default = true,
Callback = function(Value)
  _G.WalkWater_Part = Value
  if _G.WalkWater_Part then
    game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
  else
    game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
  end
end
})
iceWalk = Tabs.Misc:AddToggle("iceWalk", {
Title = "Bật Chế Độ Đi Bộ Trên Băng", 
Flag = "iceWalk",
Description = "", 
Default = false,
Callback = function(Value)
  _G.WalkWater = Value
end})
task.spawn(function()
  while task.wait() do
    if _G.WalkWater then
      pcall(function()
	   if plr.Character and plr.Character:FindFirstChild("LeftFoot") then
	   local upval0 = replicated.Assets.Models.IceSpikes4:Clone()
        upval0.Parent = workspace
        upval0.Size = Vector3.new(3+math.random(10,12),1.7,3+math.random(10,12))
        upval0.Color = Color3.fromRGB(128,187,219)
        upval0.CFrame = CFrame.new(plr.Character.Head.Position.X,-3.8,plr.Character.Head.Position.Z)*CFrame.Angles((math.random()-0.5)*0.06, math.random()*7,(math.random()-0.5)*0.07)
        local var85={};
        var85.Size=Vector3.new(0,0.3,0)
        local var3=TW:Create(upval0,TweenInfo.new(2,Enum.EasingStyle.Quad,Enum.EasingDirection.In),var85)
        var3.Completed:Connect(function()
          upval0:Destroy()
        end)
          var3:Play()
	    end	
      end)
    end
  end
end)

Players = game:GetService("Players")
RS = game:GetService("ReplicatedStorage")
RunService = game:GetService("RunService")

plr = Players.LocalPlayer

v1 = next
v2 = {
    RS:WaitForChild("Util"),
    RS:WaitForChild("Common"),
    RS:WaitForChild("Remotes"),
    RS:WaitForChild("Assets"),
    RS:WaitForChild("FX"),
}

v3 = nil
u4 = nil -- RemoteEvent found
u5 = nil -- Id attribute

do
    while true do
        local folder
        v3, folder = v1(v2, v3)
        if v3 == nil then break end

        for _, obj in ipairs(folder:GetChildren()) do
            if obj:IsA("RemoteEvent") and obj:GetAttribute("Id") then
                u5 = obj:GetAttribute("Id")
                u4 = obj
            end
        end

        -- listen new children
        folder.ChildAdded:Connect(function(obj)
            if obj:IsA("RemoteEvent") and obj:GetAttribute("Id") then
                u5 = obj:GetAttribute("Id")
                u4 = obj
            end
        end)
    end
end

local function BuildHits(character, range)
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return {} end

    local hits = {}
    for _, container in ipairs({workspace:FindFirstChild("Enemies"), workspace:FindFirstChild("Characters")}) do
        if container then
            for _, mob in ipairs(container:GetChildren()) do
                if mob ~= character then
                    local mhrp = mob:FindFirstChild("HumanoidRootPart")
                    local hum = mob:FindFirstChildOfClass("Humanoid") or mob:FindFirstChild("Humanoid")
                    if mhrp and hum and hum.Health > 0 then
                        if (mhrp.Position - hrp.Position).Magnitude <= range then
                            for _, part in ipairs(mob:GetChildren()) do
                                if part:IsA("BasePart") then
                                    if (mhrp.Position - hrp.Position).Magnitude <= range then
                                        hits[#hits+1] = {mob, part}
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return hits
end


do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")

    local Player = Players.LocalPlayer
    local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
    local RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
    local RegisterHit = Net:WaitForChild("RE/RegisterHit")

    local ATTACK_RANGE = 65
    local ATTACK_COOLDOWN = 0.2
    local SCAN_INTERVAL = 0.25

    local enemyCache = {}
    local lastAttackTime = 0
    local lastScanTime = 0

    local function UpdateEnemyCache()
        local character = Player.Character
        if not character then return end
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end

        local newCache = {}
        local enemies = Workspace:FindFirstChild("Enemies")
        if not enemies then return end

        for _, enemy in pairs(enemies:GetChildren()) do
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            local hum = enemy:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                if (hrp.Position - rootPart.Position).Magnitude <= ATTACK_RANGE then
                    table.insert(newCache, enemy)
                end
            end
        end
        enemyCache = newCache
    end

    local function SendHits()
        local now = tick()
        if now - lastAttackTime < ATTACK_COOLDOWN then return end

        if now - lastScanTime >= SCAN_INTERVAL then
            lastScanTime = now
            UpdateEnemyCache()
        end

        if #enemyCache == 0 then return end

        local args = { [1] = nil, [2] = {} }

        for idx, enemy in ipairs(enemyCache) do
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            if hrp then
                if not args[1] then
                    args[1] = enemy:FindFirstChild("Head") or hrp
                end
                args[2][idx] = { [1] = enemy, [2] = hrp }
            end
        end

        if not args[1] or #args[2] == 0 then return end

        pcall(function()
            RegisterAttack:FireServer(0)
            RegisterHit:FireServer(unpack(args))
        end)

        lastAttackTime = now
    end

    RunService.Heartbeat:Connect(function()
        SendHits()
    end)

    Player.CharacterAdded:Connect(function()
        enemyCache = {}
        lastScanTime = 0
        lastAttackTime = 0
    end)
end


pcall(function()
    SaveManager:SetLibrary(Fluent)
    SaveManager:SetFolder("HDHub")
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({"SaveManager_ConfigName", "SaveManager_ConfigList"})
    SaveManager:BuildConfigSection(Tabs.Config)
    SaveManager:LoadAutoloadConfig()
    InterfaceManager:SetLibrary(Fluent)
    InterfaceManager:SetFolder("HDHub")
    InterfaceManager:BuildInterfaceSection(Tabs.Config)
end)

end
