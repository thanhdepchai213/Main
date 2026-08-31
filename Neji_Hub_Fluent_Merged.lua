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
local Remotes = {
    RFSubmarineWorkerSpeak = replicated.Modules.Net["RF/SubmarineWorkerSpeak"],
    RFJobsRemoteFunction = replicated.Modules.Net["RF/JobsRemoteFunction"], 
    RFCraft = replicated:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/Craft")
}
local DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
local RenMon = {"Snow Lurker","Arctic Warrior","Hidden Key","Awakened Ice Admiral"}
local CursedTables = {["Mob"] = "Mythological Pirate",["Mob2"] = "Cursed Skeleton","Hell's Messenger",["Mob3"] = "Cursed Skeleton","Heaven's Guardian"}
local Past = {"Part","SpawnLocation","Terrain","WedgePart","MeshPart"}
local BartMon = {"Swan Pirate","Jeremy"}
local CitizenTable = {"Forest Pirate","Captain Elephant"}
local Human_v3_Mob = {"Fajita","Jeremy","Diamond"}
local AllBoats = {"Beast Hunter","Lantern","Guardian","Grand Brigade","Dinghy","Sloop","The Sentinel"}
local mastery1 = {"Cookie Crafter"}
local mastery2 = {"Reborn Skeleton"}
local PosMsList = {["Pirate Millionaire"] = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625),["Pistol Billionaire"] = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625),["Dragon Crew Warrior"] = CFrame.new(7021.50439453125, 55.76270294189453, -730.1290893554688),["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),["Venomous Assailant"] = CFrame.new(4902, 670, 39), ["Marine Commodore"] = CFrame.new(2401, 123, -7589),["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),["Fishman Raider"] = CFrame.new(-10941, 332, -8760),["Fishman Captain"] = CFrame.new(-11035, 332, -9087),["Forest Pirate"] = CFrame.new(-13446, 413, -7760),["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),["Living Zombie"] = CFrame.new(-10227, 421, 6161),["Demonic Soul"] = CFrame.new(-9579, 6, 6194),["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),["Peanut Scout"] = CFrame.new(-1993, 187, -10103),["Peanut President"] = CFrame.new(-2215, 159, -10474),["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),["Cake Guard"] = CFrame.new(-2024, 38, -12026),["Baking Staff"] = CFrame.new(-1932, 38, -12848),["Head Baker"] = CFrame.new(-1932, 38, -12848),["Cocoa Warrior"] = CFrame.new(95, 73, -12309),["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),["Sweet Thief"] = CFrame.new(116, 36, -12478),["Candy Rebel"] = CFrame.new(47, 61, -12889),["Ghost"] = CFrame.new(5251, 5, 1111)}
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
local Rock = workspace:FindFirstChild("Rocks")
if Rock then Rock:Destroy()end
gay = (function()
  local lighting = game:GetService("Lighting")
  local lightingLayers = lighting:FindFirstChild("LightingLayers")
end)()
  if lightingLayers and game:GetService("Lighting") and game:GetService("Lighting") then
    local darkFog = lightingLayers:FindFirstChild("DarkFog")
    if darkFog then darkFog:Destroy() end
  end
-- deg
local Attack = {}
Attack.__index = Attack
Attack.Alive = function(model) if not model then return end local Humanoid = model:FindFirstChild("Humanoid") return Humanoid and Humanoid.Health > 0 end
Attack.Pos = function(model,dist) return (Root.Position - mode.Position).Magnitude <= dist end
Attack.Dist = function(model,dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist end
Attack.DistH = function(model,dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude > dist end
Attack.Kill = function(model,Succes)
  if model and Succes then
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
  if model and Succes then
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
  if model and Succes then
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
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  weaponSc("Sword")
  _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
  if RandomCFrame then wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
Attack.Mas = function(model,Succes)
  if model and Succes then
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
  if model and Succes then
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
  if model and Succes then
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
_G.SpeedB = _G.SpeedB or 300
_G.MobM = _G.MobM or 6

local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local plr = Players.LocalPlayer

local function isBossMob(mob)
	if not BossList then return false end
	for _, b in ipairs(BossList) do
		if mob.Name == b then return true end
	end
	return false
end

BringEnemy = function()
	if not _B then return end
	if not PosMon then return end

	local char = plr.Character
	local hrpPlr = char and char:FindFirstChild("HumanoidRootPart")
	if not hrpPlr then return end

	local range = tonumber(_G.BringRange) or 350
	local speed = tonumber(_G.SpeedB) or 300
	local maxMob = tonumber(_G.MobM) or 6

	local list = {}
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if #list >= maxMob then break end
		if isBossMob(v) then continue end

		local hum = v:FindFirstChildOfClass("Humanoid")
		local pp = v.PrimaryPart or v:FindFirstChild("HumanoidRootPart")
		if hum and pp and hum.Health > 0 then
			if (pp.Position - PosMon).Magnitude <= range then
				list[#list + 1] = {mob = v, hum = hum, pp = pp}
			end
		end
	end

	if #list <= 1 then return end

	pcall(function()
		sethiddenproperty(plr, "SimulationRadius", math.huge)
	end)

	for _, it in ipairs(list) do
		local v, hum, pp = it.mob, it.hum, it.pp

		pp.CanCollide = true
		hum.WalkSpeed = 0
		hum.JumpPower = 0
		if hum:FindFirstChild("Animator") then
			hum.Animator:Destroy()
		end

		local targetCF = CFrame.new(PosMon)

		if speed <= 0 then
			pp.CFrame = targetCF
		else
			local dist = (pp.Position - PosMon).Magnitude
			local t = math.max(0.05, dist / speed)
			TS:Create(pp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = targetCF}):Play()
		end

		pp.AssemblyLinearVelocity = Vector3.zero
		pp.AssemblyAngularVelocity = Vector3.zero
	end
end
_G.Raiding = false
LockedIsland = nil
CurrentIslandIndex = 1

local Islands = {"Island 1", "Island 2", "Island 3", "Island 4", "Island 5"}
local ISLAND_RADIUS = 750  -- tăng nhẹ để an toàn hơn

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Locations = workspace:WaitForChild("_WorldOrigin"):WaitForChild("Locations")

local lastTP = 0
local TP_COOLDOWN = 0.55  -- tăng lên để tránh rubberband

local function TP(cf)
    if tick() - lastTP < TP_COOLDOWN + math.random(0, 200)/1000 then 
        return 
    end
    lastTP = tick()
    pcall(function()
        -- Thay _tp bằng hàm teleport của hub bạn (Fluxus, Delta, Arceus, v.v.)
        -- Ví dụ: game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
        -- hoặc hook của hub: getgenv()._tp(cf) / fireRemote / etc.
        _tp(cf)  -- <--- GIỮ NGUYÊN HOẶC THAY BẰNG HÀM TP CỦA HUB
    end)
end

local function GetChar()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return end
    return char, hrp, hum
end

local function InRaid()
    local pg = plr:FindFirstChild("PlayerGui")
    if not pg then return false end
    local main = pg:FindFirstChild("Main")
    if not main then return false end
    local top = main:FindFirstChild("TopHUDList")
    if not top then return false end
    local timer = top:FindFirstChild("RaidTimer")
    return timer and timer.Visible
end

local function HasAliveMobInIsland(islandPos)
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return false end
    
    for _, mob in pairs(enemies:GetChildren()) do
        local hum = mob:FindFirstChildOfClass("Humanoid")
        local root = mob:FindFirstChild("HumanoidRootPart")
        if hum and root and hum.Health > 0.1 and root.Parent == mob then
            local dist = (root.Position - islandPos).Magnitude
            if dist <= ISLAND_RADIUS + 80 then
                return true
            end
        end
    end
    return false
end

local function KillMobsInIsland(islandPos)
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return false end

    local didHit = false
    
    for _, mob in pairs(enemies:GetChildren()) do
        if not _G.Raiding or not InRaid() then break end
        
        local hum = mob:FindFirstChildOfClass("Humanoid")
        local root = mob:FindFirstChild("HumanoidRootPart")
        if not (hum and root and hum.Health > 0.1) then continue end
        
        local dist = (root.Position - islandPos).Magnitude
        if dist > ISLAND_RADIUS + 100 then continue end
        
        didHit = true
        print("[DEBUG] Đang farm: " .. mob.Name .. " | HP: " .. math.floor(hum.Health) .. " | Dist: " .. math.floor(dist))
        
        local startTime = tick()
        while _G.Raiding and mob.Parent and hum.Health > 0.1 and InRaid() do
            if (root.Position - islandPos).Magnitude > ISLAND_RADIUS + 120 then break end
            
            -- TP sát mob (đứng sau lưng cho an toàn)
            TP(root.CFrame * CFrame.new(0, 5, -7))
            
            -- PHẦN GÂY SÁT THƯƠNG - CHỌN 1 TRONG 2 CÁCH DƯỚI
            
            -- Cách 1: Nếu hub có Attack.Kill hoạt động thật (ít hub còn giữ được)
            if Attack and Attack.Kill then
                pcall(function()
                    Attack.Kill(mob, true)
                end)
            end
            
            -- Cách 2: Spam skill thủ công (ổn định hơn 2025-2026)
            --[[
            pcall(function()
                -- Ví dụ spam Z X C V (tùy fruit bạn dùng)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                task.wait(0.05)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Z, false, game)
                
                -- Thêm các skill khác nếu cần: X, C, V...
            end)
            --]]
            
            task.wait(0.12 + math.random(0,80)/1000)  -- tránh spam quá nhanh
            
            if tick() - startTime > 12 then 
                print("[DEBUG] Timeout kill mob: " .. mob.Name)
                break 
            end
        end
    end
    
    return didHit
end

_G.KillAuraFull = false  -- Bắt đầu tắt kill aura
local Range = 500
local Delay = 2

spawn(function()
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

local function FindBestIslandIndex()
    -- Ưu tiên island cao nhất còn mob sống
    for i = #Islands, 1, -1 do
        local isl = Locations:FindFirstChild(Islands[i])
        if isl and HasAliveMobInIsland(isl.Position) then
            print("[DEBUG] Chọn island có mob: " .. Islands[i])
            return i
        end
    end
    
    -- Nếu không còn mob nào, chọn island cao nhất tồn tại
    for i = #Islands, 1, -1 do
        local isl = Locations:FindFirstChild(Islands[i])
        if isl then
            print("[DEBUG] Chọn island trống cao nhất: " .. Islands[i])
            return i
        end
    end
    
    print("[DEBUG] Không tìm thấy island nào")
    return 1
end

local function EnsureLockedIsland()
    if LockedIsland and LockedIsland.Parent then
        return LockedIsland
    end
    
    CurrentIslandIndex = FindBestIslandIndex()
    LockedIsland = Locations:FindFirstChild(Islands[CurrentIslandIndex])
    return LockedIsland
end

local RaidThread = nil

local function StartRaid()
    if RaidThread then return end
    _G.Raiding = true
    
    RaidThread = task.spawn(function()
        print("[RAID AUTO] Bắt đầu farm raid...")
        
        while task.wait(0.3) do
            if not _G.Raiding then break end
            
            if not InRaid() then
                print("[DEBUG] Không còn trong raid → reset island")
                LockedIsland = nil
                CurrentIslandIndex = 1
                continue
            end
            
            local _, hrp = GetChar()
            if not hrp then continue end
            
            local island = EnsureLockedIsland()
            if not island then continue end
            
            local distToIsland = (hrp.Position - island.Position).Magnitude
            if distToIsland > ISLAND_RADIUS + 150 then
                print("[DEBUG] TP về island: " .. Islands[CurrentIslandIndex] .. " (dist: " .. math.floor(distToIsland) .. ")")
                TP(island.CFrame * CFrame.new(0, 60, 0))
                task.wait(0.8)
                continue
            end
            
            local hasMob = false
            if CurrentIslandIndex == 4 then
                -- Đặc biệt cho island 4: Kích hoạt kill aura, đứng im clear quái
                print("[DEBUG] Đến island 4 → Kích hoạt kill aura và đứng im clear")
                _G.KillAuraFull = true
                
                -- Chờ đến khi không còn mob alive ở island này
                while HasAliveMobInIsland(island.Position) do
                    task.wait(0.5)  -- Chờ và để kill aura làm việc
                end
                
                _G.KillAuraFull = false
                print("[DEBUG] Island 4 cleared bằng kill aura → Tiếp tục")
                hasMob = false  -- Đánh dấu cleared để chuyển island
            else
                -- Farm bình thường cho các island khác
                hasMob = KillMobsInIsland(island.Position)
            end
            
            if not hasMob or not HasAliveMobInIsland(island.Position) then
                print("[DEBUG] Island cleared → tìm island tiếp theo")
                LockedIsland = nil
                CurrentIslandIndex = FindBestIslandIndex()
                
                local nextIsland = Locations:FindFirstChild(Islands[CurrentIslandIndex])
                if nextIsland then
                    TP(nextIsland.CFrame * CFrame.new(0, 60, 0))
                    task.wait(1)
                end
            end
        end
        
        print("[RAID AUTO] Đã dừng")
        RaidThread = nil
    end)
end

local function StopRaid()
    _G.Raiding = false
    _G.KillAuraFull = false  -- Tắt kill aura nếu đang bật
    LockedIsland = nil
    CurrentIslandIndex = 1
    if RaidThread then
        task.cancel(RaidThread)
        RaidThread = nil
    end
    print("[RAID AUTO] Đã dừng thủ công")
end

-- Để chạy: gọi StartRaid() / StopRaid()
-- Ví dụ:
-- StartRaid()
-- StopRaid()
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
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
  local method = getnamecallmethod()
  local args = {...}    
    if tostring(method) == "FireServer" then
      if tostring(args[1]) == "RemoteEvent" then
        if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
          if (_G.FarmMastery_G and not SoulGuitar) or (_G.FarmMastery_Dev) or (_G.FarmBlazeEM) or (_G.Prehis_Skills) or (_G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1 or _G.Complete_Trials) or (_G.AimMethod and ABmethod == "AimBots Skill") or (_G.AimMethod and ABmethod == "Auto Aimbots") then
            args[2] = MousePos
            return old(unpack(args))
          end
        end
      end
    end
  return old(...)
end)
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
local block = Instance.new("Part", workspace)
block.Size = Vector3.new(1, 1, 1)
block.Name = "Rip_Indra"
block.Anchored = true
block.CanCollide = false
block.CanTouch = false
block.Transparency = 1
local blockfind = workspace:FindFirstChild(block.Name)
if blockfind and blockfind ~= block then blockfind:Destroy() end
task.spawn(function()while task.wait()do if block and block.Parent==workspace then if shouldTween then getgenv().OnFarm=true else getgenv().OnFarm=false end else getgenv().OnFarm=false end end end)
task.spawn(function()local a=game.Players.LocalPlayer;repeat task.wait()until a.Character and a.Character.PrimaryPart;block.CFrame=a.Character.PrimaryPart.CFrame;while task.wait()do pcall(function()if getgenv().OnFarm then if block and block.Parent==workspace then local b=a.Character and a.Character.PrimaryPart;if b and(b.Position-block.Position).Magnitude<=200 then b.CFrame=block.CFrame else block.CFrame=b.CFrame end end;local c=a.Character;if c then for d,e in pairs(c:GetChildren())do if e:IsA("BasePart")then e.CanCollide=false end end end else local c=a.Character;if c then for d,e in pairs(c:GetChildren())do if e:IsA("BasePart")then e.CanCollide=true end end end end end)end end)
_tp = function(target)
  local character = plr.Character
  if not character or not character:FindFirstChild("HumanoidRootPart") then return end
  local rootPart = character.HumanoidRootPart
  local distance = (target.Position - rootPart.Position).Magnitude
  local tweenInfo = TweenInfo.new(distance / 300, Enum.EasingStyle.Linear)
  local tween = game:GetService("TweenService"):Create(block, tweenInfo, {CFrame = target})    
  if plr.Character.Humanoid.Sit == true then
    block.CFrame = CFrame.new(block.Position.X, target.Y, block.Position.Z)
  end  
  tween:Play()    
  task.spawn(function() while tween.PlaybackState == Enum.PlaybackState.Playing do if not shouldTween then tween:Cancel() break end task.wait(0.1) end end)
end
TeleportToTarget = function(targetCFrame) if (targetCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude > 1000 then _tp(targetCFrame)else _tp(targetCFrame)end end
notween = function(p) plr.Character.HumanoidRootPart.CFrame = p end
function BTP(p)
    local player = game.Players.LocalPlayer
    local humanoidRootPart = player.Character.HumanoidRootPart
    local humanoid = player.Character.Humanoid
    local playerGui = player.PlayerGui.Main
    local targetPosition = p.Position
    local lastPosition = humanoidRootPart.Position
    repeat
        humanoid.Health = 0
        humanoidRootPart.CFrame = p
        playerGui.Quest.Visible = false
        if (humanoidRootPart.Position - lastPosition).Magnitude > 1 then
            lastPosition = humanoidRootPart.Position
            humanoidRootPart.CFrame = p
        end
        task.wait(0.5)
    until (p.Position - humanoidRootPart.Position).Magnitude <= 2000
end
spawn(function()
  while task.wait() do
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
    Test.FillColor = Color3.fromRGB(255,0,0)
    Test.OutlineColor = Color3.fromRGB(255,255,255)
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
			if a == 1500 or a <= 1524 then
				Mon = "Pirate Millionaire"
				Qdata = 1;
				Qname = "PiratePortQuest"
				NameMon = "Pirate Millionaire"
				PosQ = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625)
				PosM = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625)
			elseif a == 1525 or a <= 1574 then
				Mon = "Pistol Billionaire"
				Qdata = 2;
				Qname = "PiratePortQuest"
				NameMon = "Pistol Billionaire"
				PosQ = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625)
				PosM = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625)
			elseif a == 1575 or a <= 1599 then
				Mon = "Dragon Crew Warrior"
				Qdata = 1;
				Qname = "AmazonQuest"
				NameMon = "Dragon Crew Warrior"
				PosQ = CFrame.new(6779.03271484375, 111.16865539550781, -801.2130737304688)
				PosM = CFrame.new(6779.03271484375, 111.16865539550781, -801.2130737304688)
			elseif a == 1600 or a <= 1624 then
				Mon = "Dragon Crew Archer"
				Qname = "AmazonQuest"
				Qdata = 2;
				NameMon = "Dragon Crew Archer"
				PosQ = CFrame.new(6955.8974609375, 546.6658935546875, 309.0401306152344)
				PosM = CFrame.new(6955.8974609375, 546.6658935546875, 309.0401306152344)
			elseif a == 1625 or a <= 1649 then
				Mon = "Hydra Enforcer"
				Qname = "VenomCrewQuest"
				Qdata = 1;
				NameMon = "Hydra Enforcer"
				PosQ = CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219)
				PosM = CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219)
			elseif a == 1650 or a <= 1699 then
				Mon = "Venomous Assailant"
				Qname = "VenomCrewQuest"
				Qdata = 2;
				NameMon = "Venomous Assailant"
				PosQ = CFrame.new(4697.5918, 1100.65137, 946.401978, 0.579397917, -4.19689783e-10, 0.81504482, -1.49287818e-10, 1, 6.21053986e-10, -0.81504482, -4.81513662e-10, 0.579397917)
				PosM = CFrame.new(4697.5918, 1100.65137, 946.401978, 0.579397917, -4.19689783e-10, 0.81504482, -1.49287818e-10, 1, 6.21053986e-10, -0.81504482, -4.81513662e-10, 0.579397917)
			elseif a == 1700 or a <= 1724 then
				Mon = "Marine Commodore"
				Qdata = 1;
				Qname = "MarineTreeIsland"
				NameMon = "Marine Commodore"
				PosQ = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
				PosM = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
			elseif a == 1725 or a <= 1774 then
				Mon = "Marine Rear Admiral"
				NameMon = "Marine Rear Admiral"
				Qname = "MarineTreeIsland"
				Qdata = 2;
				PosQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
				PosM = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
			elseif a == 1775 or a <= 1799 then
				Mon = "Fishman Raider"
				Qdata = 1;
				Qname = "DeepForestIsland3"
				NameMon = "Fishman Raider"
				PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
				PosM = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
			elseif a == 1800 or a <= 1824 then
				Mon = "Fishman Captain"
				Qdata = 2;
				Qname = "DeepForestIsland3"
				NameMon = "Fishman Captain"
				PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
				PosM = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
			elseif a == 1825 or a <= 1849 then
				Mon = "Forest Pirate"
				Qdata = 1;
				Qname = "DeepForestIsland"
				NameMon = "Forest Pirate"
				PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
				PosM = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
			elseif a == 1850 or a <= 1899 then
				Mon = "Mythological Pirate"
				Qdata = 2;
				Qname = "DeepForestIsland"
				NameMon = "Mythological Pirate"
				PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
				PosM = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
			elseif a == 1900 or a <= 1924 then
				Mon = "Jungle Pirate"
				Qdata = 1;
				Qname = "DeepForestIsland2"
				NameMon = "Jungle Pirate"
				PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
				PosM = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
			elseif a == 1925 or a <= 1974 then
				Mon = "Musketeer Pirate"
				Qdata = 2;
				Qname = "DeepForestIsland2"
				NameMon = "Musketeer Pirate"
				PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
				PosM = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
			elseif a == 1975 or a <= 1999 then
				Mon = "Reborn Skeleton"
				Qdata = 1;
				Qname = "HauntedQuest1"
				NameMon = "Reborn Skeleton"
				PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
				PosM = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
			elseif a == 2000 or a <= 2024 then
				Mon = "Living Zombie"
				Qdata = 2;
				Qname = "HauntedQuest1"
				NameMon = "Living Zombie"
				PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
				PosM = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
			elseif a == 2025 or a <= 2049 then
				Mon = "Demonic Soul"
				Qdata = 1;
				Qname = "HauntedQuest2"
				NameMon = "Demonic Soul"
				PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
			elseif a == 2050 or a <= 2074 then
				Mon = "Posessed Mummy"
				Qdata = 2;
				Qname = "HauntedQuest2"
				NameMon = "Posessed Mummy"
				PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
			elseif a == 2075 or a <= 2099 then
				Mon = "Peanut Scout"
				Qdata = 1;
				Qname = "NutsIslandQuest"
				NameMon = "Peanut Scout"
				PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
			elseif a == 2100 or a <= 2124 then
				Mon = "Peanut President"
				Qdata = 2;
				Qname = "NutsIslandQuest"
				NameMon = "Peanut President"
				PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
			elseif a == 2125 or a <= 2149 then
				Mon = "Ice Cream Chef"
				Qdata = 1;
				Qname = "IceCreamIslandQuest"
				NameMon = "Ice Cream Chef"
				PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
			elseif a == 2150 or a <= 2199 then
				Mon = "Ice Cream Commander"
				Qdata = 2;
				Qname = "IceCreamIslandQuest"
				NameMon = "Ice Cream Commander"
				PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				PosM = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
			elseif a == 2200 or a <= 2224 then
				Mon = "Cookie Crafter"
				Qdata = 1;
				Qname = "CakeQuest1"
				NameMon = "Cookie Crafter"
				PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
				PosM = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
			elseif a == 2225 or a <= 2249 then
				Mon = "Cake Guard"
				Qdata = 2;
				Qname = "CakeQuest1"
				NameMon = "Cake Guard"
				PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
				PosM = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
			elseif a == 2250 or a <= 2274 then
				Mon = "Baking Staff"
				Qdata = 1;
				Qname = "CakeQuest2"
				NameMon = "Baking Staff"
				PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
				PosM = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
			elseif a == 2275 or a <= 2299 then
				Mon = "Head Baker"
				Qdata = 2;
				Qname = "CakeQuest2"
				NameMon = "Head Baker"
				PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
				PosM = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
			elseif a == 2300 or a <= 2324 then
				Mon = "Cocoa Warrior"
				Qdata = 1;
				Qname = "ChocQuest1"
				NameMon = "Cocoa Warrior"
				PosQ = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
				PosM = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
			elseif a == 2325 or a <= 2349 then
				Mon = "Chocolate Bar Battler"
				Qdata = 2;
				Qname = "ChocQuest1"
				NameMon = "Chocolate Bar Battler"
				PosQ = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
				PosM = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
			elseif a == 2350 or a <= 2374 then
				Mon = "Sweet Thief"
				Qdata = 1;
				Qname = "ChocQuest2"
				NameMon = "Sweet Thief"
				PosQ = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
				PosM = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
			elseif a == 2375 or a <= 2399 then
				Mon = "Candy Rebel"
				Qdata = 2;
				Qname = "ChocQuest2"
				NameMon = "Candy Rebel"
				PosQ = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
				PosM = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
			elseif a == 2400 or a <= 2449 then
				Mon = "Candy Pirate"
				Qdata = 1;
				Qname = "CandyQuest1"
				NameMon = "Candy Pirate"
				PosQ = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
				PosM = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
			elseif a == 2450 or a <= 2474 then
				Mon = "Isle Outlaw"
				Qdata = 1;
				Qname = "TikiQuest1"
				NameMon = "Isle Outlaw"
				PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566)
				PosM = CFrame.new(-16479.900390625, 226.6117401123047, -300.3114318847656)
			elseif a == 2475 or a <= 2499 then
				Mon = "Island Boy"
				Qdata = 2;
				Qname = "TikiQuest1"
				NameMon = "Island Boy"
				PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566)
				PosM = CFrame.new(-16849.396484375, 192.86505126953125, -150.7853240966797)
			elseif a == 2500 or a <= 2524 then
				Mon = "Sun-kissed Warrior"
				Qdata = 1;
				Qname = "TikiQuest2"
				NameMon = "kissed Warrior"
				PosM = CFrame.new(-16347, 64, 984)
				PosQ = CFrame.new(-16538, 55, 1049)
			elseif a == 2525 or a <= 2550 then
				Mon = "Isle Champion"
				Qdata = 2;
				Qname = "TikiQuest2"
				NameMon = "Isle Champion"
				PosQ = CFrame.new(-16541.0215, 57.3082275, 1051.46118, 0.0410757065, -0, -0.999156058, 0, 1, -0, 0.999156058, 0, 0.0410757065)
				PosM = CFrame.new(-16602.1015625, 130.38734436035156, 1087.24560546875)-- Tiki Outpost
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


_G.HeartBoss=_G.HeartBoss or false

local function FarmBossEvent()
	if not _G.HeartBoss then return end

	local sea=(World3 and "Sea3") or (World2 and "Sea2") or "Sea1"
	local list=({
		Sea3={
			["Beautiful Pirate"]=CFrame.new(5368.95459,18.7312012,-215.565369,-1,0,0,0,1,0,0,0,-1),
			["Hydra Leader"]=CFrame.new(5863.11475,1015.27264,-101.904381,-0.544665575,0,0.838653445,0,1,0,-0.838653445,0,-0.544665575),
			["Captain Elephant"]=CFrame.new(-13226.5586,319.618652,-8522.31934,-3.23057175e-05,-0.707060337,0.707153201,-1,3.23057175e-05,-1.33812428e-05,-1.33812428e-05,-0.707153201,-0.707060337),
		["Cake Queen"]=CFrame.new(-678.648804,381.353943,-11114.2012,-0.908641815,0.00149294338,0.41757378,0.00837114919,0.999857843,0.0146408929,-0.417492568,0.0167988986,-0.90852499),
		["Longma"]=CFrame.new(-10238.875976563,389.7912902832,-9549.7939453125)
		},
		Sea2={
			["Orbitus"]=CFrame.new(-2046.20801,67.8339996,-4244.25195,-0.788017035,0,-0.615653694,0,1,0,0.615653694,0,-0.788017035),
			["Diamond"]=CFrame.new(-1774.07837,193.830765,-65.1594696,6.55651093e-06,0.173615217,0.984813571,-1,6.55651093e-06,5.48362732e-06,-5.48362732e-06,-0.984813571,0.173615217),
			["Jeremy"]=CFrame.new(2338.50439,445.128601,760.178589,-0.707134247,0,0.707079291,0,1,0,-0.707079291,0,-0.707134247),

		["Don Swan"]=CFrame.new(2286.2004394531,15.177839279175,863.8388671875),
		["Smoke Admiral"]=CFrame.new(-5275.1987304688,20.757257461548,-5260.6669921875),
		["Awakened Ice Admiral"]=CFrame.new(6403.5439453125,340.29766845703,-6894.5595703125),
		["Tide Keeper"]=CFrame.new(-3795.6423339844,105.88877105713,-11421.307617188)
		},
		Sea1={
			["Thunder God"]=CFrame.new(-7811.88721,5602.6001,-2417.37695,-0.484826207,0,0.874610603,0,1,0,-0.874610603,0,-0.484826207),
			["Wysper"]=CFrame.new(-7896.33691,5543.12793,-617.458984,-0.999848008,0.017434394,-0.000263410155,0.017434394,0.999391556,-0.0302081089,-0.000263410155,-0.0302081089,-0.999543548),
			["The Gorilla King"]=CFrame.new(-1121.46399,38.4680023,-438.395996,-0.824771285,-0.0706752539,0.561032414,-0.0858078003,0.996311486,-0.000636750832,-0.558917999,-0.0486661345,-0.827793598),
["Bobby"]=CFrame.new(-1087.3760986328,46.949409484863,4040.1462402344),
		["The Saw"]=CFrame.new(-784.89715576172,72.427383422852,1603.5822753906),
		["Yeti"]=CFrame.new(1218.7956542969,138.01184082031,-1488.0262451172),
		["Mob Leader"]=CFrame.new(-2844.7307128906,7.4180502891541,5356.6723632813),
		["Vice Admiral"]=CFrame.new(-5006.5454101563,88.032081604004,4353.162109375),
["Saber Expert"]=CFrame.new(-1458.89502,29.8870335,-50.633564),
["Warden"]=CFrame.new(5278.04932,2.15167475,944.101929,0.220546961,-4.49946401e-06,0.975376427,-1.95412576e-05,1,9.03162072e-06,-0.975376427,-2.10519756e-05,0.220546961),
		}
	})[sea]

	if not list then return end
	local enemies=workspace:FindFirstChild("Enemies"); if not enemies then return end

	for name,cf in pairs(list) do
		if not _G.HeartBoss then break end

		pcall(function() _tp(cf) end)

		local t0=tick()
		local boss
		repeat
			if not _G.HeartBoss then return end
			task.wait(0.2)
			boss=enemies:FindFirstChild(name)
		until (boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health>0) or (tick()-t0>8)

		if not _G.HeartBoss then break end
		if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health>0 then
			while _G.HeartBoss and boss and boss.Parent==enemies and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health>0 do
				pcall(function()
					if Attack and Attack.Kill then Attack.Kill(boss,true)
					elseif Attack and Attack.kill then Attack.kill(boss,true) end
				end)
				task.wait(0.1)
			end
		end
	end
end

local Fluent, SaveManager, InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/OBFUP/refs/heads/main/GET.lua"))()

local Window = Fluent:CreateWindow({
    Title = "NEJI Hub",
    SubTitle = "Blox Fruit",
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl,
    TabWidth = 160
})

local function WrapNejiTab(tab)
    local t = {_tab = tab, _id = 0}
    function t:_idFor(prefix)
        self._id = self._id + 1
        return "Neji_" .. prefix .. "_" .. self._id
    end
    function t:AddSection(name)
        return self._tab:AddSection(type(name) == "table" and name[1] or tostring(name))
    end
    function t:AddParagraph(o)
        o=o or {}
        return self._tab:AddParagraph({
            Title=o.Title or o.Name or "",
            Content=o.Content or o.Desc or o.Description or ""
        })
    end
    function t:AddButton(o)
        o=o or {}
        return self._tab:AddButton({
            Title=o.Title or o.Name or "Button",
            Description=o.Description or o.Desc or "",
            Callback=o.Callback or function() end
        })
    end
    function t:AddToggle(o)
        o=o or {}
        return self._tab:AddToggle(o.Flag or self:_idFor("Toggle"), {
            Title=o.Title or o.Name or "Toggle",
            Description=o.Description or o.Desc or "",
            Default=o.Default == true,
            Callback=o.Callback or function() end
        })
    end
    function t:AddDropdown(o)
        o=o or {}
        local default=o.Default
        if default == false then default=nil end
        return self._tab:AddDropdown(o.Flag or self:_idFor("Dropdown"), {
            Title=o.Title or o.Name or "Dropdown",
            Description=o.Description or o.Desc or "",
            Values=o.Values or o.Options or {},
            Multi=o.Multi == true,
            Default=default,
            Callback=o.Callback or function() end
        })
    end
    function t:AddSlider(o)
        o=o or {}
        return self._tab:AddSlider(o.Flag or self:_idFor("Slider"), {
            Title=o.Title or o.Name or "Slider",
            Description=o.Description or o.Desc or "",
            Min=o.Min or 0,
            Max=o.Max or 100,
            Default=o.Default or o.Min or 0,
            Rounding=o.Rounding or 0,
            Callback=o.Callback or function() end
        })
    end
    function t:AddTextBox(o)
        o=o or {}
        return self._tab:AddInput(o.Flag or self:_idFor("Input"), {
            Title=o.Title or o.Name or "Input",
            Description=o.Description or o.Desc or "",
            Default=o.Default or "",
            Placeholder=o.Placeholder or "",
            Finished=o.Finished ~= false,
            Callback=o.Callback or function() end
        })
    end
    function t:AddDiscordInvite(o)
        o=o or {}
        local invite=tostring(o.Invite or "")
        return self._tab:AddButton({
            Title=o.Title or "Discord",
            Description=o.Description or invite,
            Callback=function()
                if setclipboard then
                    pcall(setclipboard, invite)
                    pcall(function()
                        Fluent:Notify({Title="Discord",Content="Đã copy link Discord",Duration=2})
                    end)
                end
            end
        })
    end
    return t
end

local Tabs = {
    Info=WrapNejiTab(Window:AddTab({Title="Info And Status",Icon="info"})),
    Main=WrapNejiTab(Window:AddTab({Title="Farming",Icon="home"})),
    Settings=WrapNejiTab(Window:AddTab({Title="Setting",Icon="settings"})),
    Fish=WrapNejiTab(Window:AddTab({Title="Fishing",Icon="fish"})),
    Quests=WrapNejiTab(Window:AddTab({Title="Stack Farm",Icon="scroll"})),
    SeaEvent=WrapNejiTab(Window:AddTab({Title="Sea Events",Icon="waves"})),
    Mirage=WrapNejiTab(Window:AddTab({Title="Mirage",Icon="mountain"})),
    Race=WrapNejiTab(Window:AddTab({Title="Upgrade Race",Icon="accessibility"})),
    Drago=WrapNejiTab(Window:AddTab({Title="Dragon Dojo",Icon="flame"})),
    Prehistoric=WrapNejiTab(Window:AddTab({Title="Prehistoric",Icon="tent"})),
    Raids=WrapNejiTab(Window:AddTab({Title="Fruit And Raid",Icon="apple"})),
    Travel=WrapNejiTab(Window:AddTab({Title="Teleport",Icon="map-pin"})),
    Shop=WrapNejiTab(Window:AddTab({Title="Shopping",Icon="shopping-bag"})),
    Misc=WrapNejiTab(Window:AddTab({Title="Miscellaneous",Icon="settings-2"}))
}

Tabs.Info:AddSection("Information")

    Tabs.Info:AddDiscordInvite({
    Title = "TikTok - NEJI",
    Description = "Flow Me!!!",
    Logo = "rbxassetid://123060196429580",
    Invite = "@tiktokacckhoe1",
})
    Tabs.Info:AddDiscordInvite({
    Title = "Discord - NEJI",
    Description = "Vào Discord Để Nhận Thông Báo Cập Nhật Script!!!",
    Logo = "rbxassetid://123060196429580",
    Invite = "https://discord.gg/vCqfSB2tev",
})

Tabs.Info:AddSection("Status Server")

Time = Tabs.Info:AddParagraph({
    Title = "Time Zone",
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
spawn(function()
    while true do
        UpdateOS()
        wait(1)
    end
end)
Timmessss = Tabs.Info:AddParagraph({
    Title = "Time",
    Content = ""
})
function UpdateTime()
    local GameTime = math.floor(workspace.DistributedGameTime + 0.5)
    local Hour = math.floor(GameTime / (60^2)) % 24
    local Minute = math.floor(GameTime / (60^1)) % 60
    local Second = math.floor(GameTime / (60^0)) % 60
    Timmessss:SetDesc(Hour.." Hour (h) "..Minute.." Minute (m) "..Second.." Second (s) ")
end
spawn(function()
    while true do
        UpdateTime()
        wait(1)
    end
end)
Miragecheck = Tabs.Info:AddParagraph({
    Title = "Mirage Island",
    Content = "Status: "
})
local previousStatus = ""
spawn(function()
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
    Title = "Kitsune Island",
    Content = "Status: "
})
spawn(function()
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
    Title = "Prehistoric Island",
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
    Title = "Frozen  Dimension",
    Content = "Status: "
})
spawn(function()
    local previousStatus = ""
    while wait(1) do
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
spawn(function()
    while wait(1) do
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
    Title = "Rip Indra",
    Content = "Status: "
})
spawn(function()
    local previousStatus = ""
    while wait(1) do
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
spawn(function()
    local previousStatus = ""
    while wait(1) do
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
spawn(function()
    local previousStatus = ""
    while wait(1) do
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
spawn(function()
    local previousStatus = ""
    while wait(1) do
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
    Title = "Bone",
    Content = ""
})
spawn(function()
    while wait(1) do
        StatusBone:SetDesc("You Have: " .. tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")) .. " Bones")
    end
end)

WeaponDropdown = Tabs.Main:AddDropdown({
    Name = "Choose Weapon",
    Options = {"Melee","Sword","Blox Fruit","Gun"},
    Default = "Melee",
    Callback = function(Value)
    _G.ChooseWP = Value
end})


spawn(function()
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

AttackDropdown = Tabs.Main:AddDropdown({
    Name = "Choose Attack Speed",
    Options = {"Normal Attack","Fast Attack","Super Fast Attack","NEJI Attack"},
    Default = "Fast Attack",
    Callback = function(Value)
    _G.FastAttackGravity_Mode = Value
end})


local DelayConfig = {
    ["Normal Attack"] = 0.25,
    ["Fast Attack"] = 0.15,
    ["Super Fast Attack"] = 0.05,
    ["NEJI Attack"] = 0.1
}

spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if _G.FastAttackGravity_Mode and DelayConfig[_G.FastAttackGravity_Mode] then
                _G.Fast_Delay = DelayConfig[_G.FastAttackGravity_Mode]
            end
        end)
    end
end)

Tabs.Main:AddToggle({
	Name = "Fast Attack Buddha",
	Description = "",
	Default = false,
	Flag = "FastAttackBuddha",
	Callback = function(v)
		getgenv().FA_Buddha = v
		pcall(function()
			local cfg = getgenv().FA_Config
			if typeof(cfg) == "table" then
				cfg.AttackDistance = v and getgenv().FA_BuddhaDist or getgenv().FA_DefaultDist
			end
		end)
	end
})

Tabs.Main:AddSection({"Farming"})

FarmLevel = Tabs.Main:AddToggle({
    Name = "Auto Farm Level",
    Description = "Tự Động Cày Cấp Độ",
    Default = false,
    Callback = function(Value)
        _G.Level = Value
        
        -- Reset trạng thái quan trọng mỗi khi bật lại
        if Value == true then
            alreadyTeleported = false
            teleporting = false
        end
    end
})

-- Biến trạng thái (khởi tạo ban đầu)
local alreadyTeleported = false
local teleporting = false

-- Hàm kiểm tra đang ở Submerged Island (dựa trên khoảng cách XZ)
local function IsInSubmergedIsland()
    local char = plr.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local islandXZ = Vector3.new(11520.8017578125, 0, 9829.513671875)
    local playerXZ = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
    return (playerXZ - islandXZ).Magnitude < 2000
end

-- Table PlaceId của Third Sea (cập nhật 2025-2026, dựa trên dữ liệu bạn cung cấp + phổ biến)
local THIRD_SEA_PLACE_IDS = {
    7449423635,          -- PlaceId chính thức Third Sea (Rolimon's & cộng đồng)
    100117331123089,     -- PlaceId variant bạn cung cấp
    -- Thêm nếu cần trong tương lai
}

-- Hàm kiểm tra đang ở Third Sea
local function IsInThirdSea()
    local currentPlaceId = game.PlaceId
    for _, id in ipairs(THIRD_SEA_PLACE_IDS) do
        if currentPlaceId == id then
            return true
        end
    end
    return false
end

-- Loop chính auto farm
task.spawn(function()
    while task.wait(Sec) do  -- Sec là biến delay của bạn (giả sử đã define ở đâu đó, ví dụ 0.1 hoặc 0.3)
        if not _G.Level then
            teleporting = false
            continue
        end

        pcall(function()
            local char = plr.Character or plr.CharacterAdded:Wait()
            local Root = char:WaitForChild("HumanoidRootPart", 5)
            if not Root then return end
            
            -- Fix tiềm ẩn: Đảm bảo không anchored
            Root.Anchored = false
            
            local myLevel = plr.Data.Level.Value
            local inSub = IsInSubmergedIsland()
            local inSea3 = IsInThirdSea()
            local questUI = plr.PlayerGui.Main.Quest
            local QuestTitle = questUI.Container.QuestTitle.Title.Text

            --------------------------------------------------------------------
            -- Phần TELEPORT xuống Submerged Island (chỉ khi ĐỦ điều kiện)
            --------------------------------------------------------------------
            if myLevel >= 2600 
               and inSea3 
               and not inSub 
               and not alreadyTeleported 
               and not teleporting 
            then
                teleporting = true

                -- Vị trí NPC Submarine Worker tại Tiki Outpost
                local npcPos = CFrame.new(-16269.1016, 29.5177539, 1372.3204)

                -- Teleport đến NPC và ĐẢM BẢO gần mới gọi remote
                repeat
                    task.wait(Sec)
                    if (Root.Position - npcPos.Position).Magnitude > 5 then  -- Thay >10 thành >5 để nghiêm ngặt hơn
                        _tp(npcPos)  -- Gọi hàm _tp gốc
                        -- Xóa fallback set trực tiếp để tránh sync issue, chỉ dùng _tp (giả sử _tp dùng Tween an toàn)
                    end
                until not _G.Level or (Root.Position - npcPos.Position).Magnitude <= 5

                -- Thêm delay để sync vị trí client-server
                task.wait(0.5)

                -- Chỉ gọi remote NẾU THỰC SỰ GẦN NPC
                if (Root.Position - npcPos.Position).Magnitude <= 5 then
                    pcall(function()
                        Remotes.RFSubmarineWorkerSpeak:InvokeServer("TravelToSubmergedIsland")
                    end)
                end

                -- Chờ confirm vào đảo (tăng timeout lên 10 giây để an toàn)
                local timeout = tick()
                repeat
                    task.wait(Sec)
                until IsInSubmergedIsland() or tick() - timeout > 10 or not _G.Level

                -- Chỉ đánh dấu đã teleport nếu THỰC SỰ vào được đảo
                if IsInSubmergedIsland() then
                    alreadyTeleported = true
                end
                
                teleporting = false
            end

            --------------------------------------------------------------------
            -- Logic farm quest CHUNG (chạy ở Sea thường hoặc Submerged)
            --------------------------------------------------------------------
            -- Đánh dấu nếu đang ở Submerged
            if inSub then
                alreadyTeleported = true
                teleporting = false
            end

            -- Bỏ quest nếu không phải quest mong muốn (QuestNeta()[5] là string match)
            if not string.find(QuestTitle, QuestNeta()[5]) then
                replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
            end

            -- Chưa có quest → đi lấy quest
            if not questUI.Visible then
                local questPos = QuestNeta()[6]
                if (Root.Position - questPos.Position).Magnitude > 5 then  -- Thay >10 thành >5
                    _tp(questPos)  -- Gọi hàm _tp gốc
                    -- Xóa fallback để tránh issue
                end
                task.wait(0.1)

                if (Root.Position - questPos.Position).Magnitude <= 5 then
                    pcall(function()
                        replicated.Remotes.CommF_:InvokeServer("StartQuest", QuestNeta()[3], QuestNeta()[2])
                    end)
                end
            else
                -- Đã có quest → tìm và farm enemy
                local enemyName = QuestNeta()[1]
                local foundEnemy = false

                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if Attack.Alive(v) and v.Name == enemyName then
                        foundEnemy = true
                        repeat
                            task.wait(Sec)
                            local enemyCFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                            if (Root.Position - enemyCFrame.Position).Magnitude > 5 then  -- Thay >10
                                _tp(enemyCFrame)  -- Gọi hàm _tp gốc
                                -- Xóa fallback
                            end
                            Attack.Kill(v, _G.Level)
                        until not _G.Level 
                           or not v.Parent 
                           or v.Humanoid.Health <= 0 
                           or not questUI.Visible
                        break  -- Chỉ farm 1 con/lần để ổn định, bỏ break nếu muốn farm multi
                    end
                end

                -- Không thấy enemy → tp đến vị trí farm mặc định
                if not foundEnemy then
                    local farmPos = QuestNeta()[4]
                    if (Root.Position - farmPos.Position).Magnitude > 5 then
                        _tp(farmPos)  -- Gọi hàm _tp gốc
                        -- Xóa fallback
                    end
                end
            end
        end)
    end
end)

ClosetMons = Tabs.Main:AddToggle({
Name = "Auto Farm Nearest", 
Description = "Tự Động Đánh Quái Ở Gần", 
Default = false, 
Callback = function(Value)
  _G.AutoFarmNear = Value
end})
spawn(function()
  while wait() do
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
FactoryRaids = Tabs.Main:AddToggle({
Name = "Auto Factory Raid", 
Description = "Tự Động Đánh Nhà Máy", 
Default = false,
Callback = function(Value)
  _G.AutoFactory = Value
end})
spawn(function()
  while wait(Sec) do
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

CastleRaids = Tabs.Main:AddToggle({
Name = "Auto Pirate Raid", 
Description = "Tự Động Đánh Hải Tặc Đột Kích", 
Default = false,
Callback = function(Value)
  _G.AutoRaidCastle = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoRaidCastle then
      pcall(function()
      local CFrameCastleRaid = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)
        if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - Root.Position).Magnitude <= 500 then
          for i,v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
              if v.Name then
                if (v.HumanoidRootPart.Position - Root.Position).Magnitude <= 2000 then
                  repeat wait() Attack.Kill(v,_G.AutoRaidCastle) until not _G.AutoRaidCastle or not v.Parent or v.Humanoid.Health <= 0 or not workspace.Enemies:FindFirstChild(v.Name)
                end
              end
            end
          end
        else
          local Castle_Mob = {"Galley Pirate","Galley Captain","Raider","Mercenary","Vampire","Zombie","Snow Trooper","Winter Warrior","Lab Subordinate","Horned Warrior","Magma Ninja","Lava Pirate","Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior","Snow Lurker","Sea Soldier","Water Fighter"}
          for i = 1,#Castle_Mob do
            if replicated:FindFirstChild(Castle_Mob[i]) then
              for _,v in pairs(replicated:GetChildren()) do
                if table.find(Castle_Mob, v.Name) then _tp(CFrameCastleRaid) end
              end
            end
          end
        end
      end)
    end
  end
end)

Ecto = Tabs.Main:AddToggle({
Name = "Auto Farm Ectoplasm", 
Description = "Tự Động Cày Ngoại Chất", 
Default = false,
Callback = function(Value)
  _G.AutoEctoplasm = Value
end})
spawn(function()
  while wait(Sec) do
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

local RS = game:GetService("ReplicatedStorage")
local Remote = RS.Modules.Net:WaitForChild("RE/EasterServiceRE")

Tabs.Main:AddSection({"Collect Chest"})

ChestTW = Tabs.Main:AddToggle({
Name = "Auto Farm Chest", 
Description = "Tự Động Nhặt Rương", 
Default = false,
Callback = function(Value)
  _G.AutoFarmChest = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoFarmChest then
      pcall(function()
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
      end)
    end
  end
end)


StopI = Tabs.Main:AddToggle({
Name = "Stop Item", 
Description = "Dừng Khi Có Vật Phẩm", 
Default = true,
Callback = function(Value)
    _G.StopWhenChalice = Value
end})

spawn(function()
    while wait(0.2) do
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

Tabs.Main:AddSection({"Collect Berry"})

Berry = Tabs.Main:AddToggle({
Name = "Auto Collect Berry", 
Description = "Tự Động Nhặt Berry", 
Default = false,
Callback = function(Value)
  _G.AutoBerry = Value
end})
spawn(function()
  while wait(Sec) do
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



BerryH = Tabs.Main:AddToggle({
Name = "Auto Collect Berry + Hop Server", 
Description = "Tự Động Nhặt Berry + Chuyển Máy Chủ", 
Default = false,
Callback = function(Value)
  _G.AutoBerryH = Value
end})

spawn(function()
    while wait(Sec) do
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

Tabs.Main:AddSection({"Farm Elite Hunter"})

Process = Tabs.Main:AddParagraph({
Title = "Elites Process",
Content = ""})
spawn(function()
  while wait(Sec) do
    pcall(function()    
      Process:SetDesc("Elite Procress :  " ..replicated.Remotes.CommF_:InvokeServer("EliteHunter","Progress"))
    end)
  end
end)

EliteHunter = Tabs.Main:AddParagraph({
    Title = "Elite Spam",
    Content = "Status: "
})
spawn(function()
    local previousStatus = ""
    while wait(1) do
        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) and '✅️' or '❌️'
        local progress = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress")
        if currentStatus ~= previousStatus then
            EliteHunter:SetDesc("Status: " .. currentStatus .. " | Killed: " .. progress)
            previousStatus = currentStatus
        end
    end
end)

EliteQ = Tabs.Main:AddToggle({
    Name = "Auto Farm Elite",
    Description = "Tự Động Đánh Elite",
    Default = false,
    Callback = function(Value)
    _G.FarmEliteHunt = Value
end})

spawn(function()
    while wait(1) do
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

EliteH = Tabs.Main:AddToggle({
	Name = "Auto Farm Elite + Hop Server",
	Description = "Tự Động Đánh Elite + Chuyển Máy Chủ",
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
spawn(function()
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

Tabs.Main:AddSection({"Farming Cake"})
MobKilled = Tabs.Main:AddParagraph({
    Title = "Cake Prince:",
    Content = ""
})
spawn(function()
  while wait(.2) do
    pcall(function()
  	  local Killed = string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"),"%d+")
      if Killed then
        MobKilled:SetDesc(" Killed : " ..(500 - Killed))
      end
    end)
  end
end)

-- Toggle 2: Auto Farm Cake Prince
Cake = Tabs.Main:AddToggle({
    Name = "Auto Farm Cake Prince",
    Description = "Tự Động Cày Hoàng Tử Bột",
    Default = false,
    Callback = function(Value)
    _G.Auto_Cake_Prince = Value
end})

spawn(function()
    while task.wait() do
        -- Chỉ farm Cake nếu Pirate không bật
        if _G.Auto_Cake_Prince and not _G.AutoRaidCastle then
            pcall(function()
                local player = game.Players.LocalPlayer
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                local enemies = workspace.Enemies
                local bigMirror = workspace.Map:FindFirstChild("CakeLoaf") and workspace.Map.CakeLoaf:FindFirstChild("BigMirror")
                if not root then return end

                -- Nếu chưa đến đảo Cake, teleport xuống farm quái
                if not workspace.Map:FindFirstChild("CakeLoaf") then
                    _tp(CFrame.new(-2077, 252, -12373))
                    task.wait(2)
                    return
                end

                if bigMirror and (bigMirror.Other.Transparency == 0 or enemies:FindFirstChild("Cake Prince")) then
                    -- Farm boss Cake Prince
                    local boss = GetConnectionEnemies("Cake Prince")
                    if boss then
                        repeat task.wait()
                            Attack.Kill2(boss, _G.Auto_Cake_Prince)
                        until not _G.Auto_Cake_Prince or not boss.Parent or boss.Humanoid.Health <= 0
                    else
                        _tp(CFrame.new(-2151.82, 149.32, -12404.91))
                    end
                else
                    -- Farm quái mở boss
                    local CakeMobs = {"Cookie Crafter","Cake Guard","Baking Staff","Head Baker"}
                    local mob = GetConnectionEnemies(CakeMobs)
                    if mob then
                        repeat task.wait()
                            Attack.Kill(mob, _G.Auto_Cake_Prince)
                        until not _G.Auto_Cake_Prince or not mob.Parent or mob.Humanoid.Health <= 0 or (bigMirror and bigMirror.Other.Transparency == 0)
                    else
                        _tp(CFrame.new(-2077, 252, -12373))
                    end
                end
            end)
        end
    end
end)


CakeSM = Tabs.Main:AddToggle({
    Name = "Auto Summon Cake Prince",
    Description = "Tự Động Triệu Hồi Hoàng Tử Bột",
    Default = false,
    Callback = function(Value)
    _G.AutoSpawnCP = Value
end})

spawn(function()
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

DoughKingFarm = Tabs.Main:AddToggle({
    Name = "Auto Farm Dough King",
    Description = "Tự Động Đánh Bột Đế Vương",
    Default = false,
    Callback = function(Value)
    _G.AutoDoughKing = Value
end})

spawn(function()
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

HopDough = Tabs.Main:AddToggle({
Name = "Auto Hop Dough King", 
Description = "Tự Động Chuyển Máy Bột Đế Vương", 
Default = false,
Callback = function(Value)
    _G.AutoHop_Dough = Value
end})

spawn(function()
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

Tabs.Main:AddSection({"Unlocked Dungeon"})

DouD = Tabs.Main:AddToggle({
Name = "Auto Unlock Dough Dungeon", 
Description = "Tự Động Mở Khoá Dungeon Bột", 
Default = false,
Callback = function(Value)
  _G.Doughv2 = Value
end})
spawn(function()
  while wait(Sec) do
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
PhoD = Tabs.Main:AddToggle({
Name = "Auto Unlock Phoenix Dungeon", 
Description = "Tự Động Mở Khoá Dungeon Phượng Hoàng", 
Default = false,
Callback = function(Value)
  _G.AutoPhoenixF = Value
end})
spawn(function()
  while wait(.1) do
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

Tabs.Main:AddSection({"Farming Bone"})

CheckingBone = Tabs.Main:AddParagraph({
    Title = " Bone:",
    Content = ""
})
spawn(function()
  while wait(.2) do
    pcall(function()
      CheckingBone:SetDesc(" Bones : " ..GetM("Bones"))          
    end)
  end
end)
Bone = Tabs.Main:AddToggle({
Name = "Auto Farm Bone", 
Description = "Tự Động Cày Xương", 
Default = false,
Callback = function(Value)
    _G.AutoFarm_Bone = Value
end})

spawn(function()
    while task.wait(Sec) do
        if _G.AutoFarm_Bone then
            pcall(function()
                local player = game.Players.LocalPlayer
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if not root then return end

                local BonesTable = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}
                local bone = GetConnectionEnemies(BonesTable)

                if bone then
                    repeat
                        task.wait()
                        Attack.Kill(bone, _G.AutoFarm_Bone)
                    until not _G.AutoFarm_Bone or bone.Humanoid.Health <= 0 or not bone.Parent
                else
                    _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
                end
            end)
        end
    end
end)



Tabs.Main:AddToggle({
Name = "Auto Soul Reaper", 
Description = "Tự Động Đánh Soul Reaper", 
Default = false,
Callback = function(Value)
  _G.AutoHytHallow = Value
end})
spawn(function()
  while wait(Sec) do
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
RanBone = Tabs.Main:AddToggle({
Name = "Auto Random Bone", 
Description = "Tự Động Đổi Xương", 
Default = false,
Callback = function(Value)
  _G.Auto_Random_Bone = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_Random_Bone then    
  	    repeat task.wait() replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1) until not _G.Auto_Random_Bone
      end
    end)
  end
end)
Lucky = Tabs.Main:AddToggle({
Name = "Auto Try Luck Gravestone", 
Description = "Tự Động Thử Vận May Bia Mộ", 
Default = false,
Callback = function(Value)
  _G.TryLucky = Value
end})
spawn(function()
  while wait(Sec) do
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
Pray = Tabs.Main:AddToggle({
Name = "Auto Pray Gravestone", 
Description = "Tự Động Cầu Nguyện Bia Mộ", 
Default = false,
Callback = function(Value)
  _G.Praying = Value
end})
spawn(function()
  while wait(Sec) do
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


Tabs.Main:AddSection({"Tyrant Of The Skies"})

TyrantStatus = Tabs.Main:AddParagraph({
    Title = "Boss Spam",
    Content = ""
})

spawn(function()
    pcall(function()
        while wait(1) do
            if workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                TyrantStatus:SetDesc("✅")
            else
                TyrantStatus:SetDesc("❌")
            end
        end
    end)
end)

FarmTyrant = Tabs.Main:AddToggle({
Name = "Auto Farm Boss", 
Description = "Tự Động Đánh Boss", 
Default = false,
Callback = function(Value) 
    getgenv().FarmTyrant = Value 
end})

spawn(function()
    while wait(Sec) do
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

FarmPhaBinh = Tabs.Main:AddToggle({
Name = "Auto Summon Boss", 
Description = "Tự Động Triệu Hồi Boss", 
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

local PhaBinhPoints = {
    CFrame.new(-16332.5263671875, 158.07200622558594, 1440.324951171875),
    CFrame.new(-16288.609375, 158.16700744628906, 1470.3680419921875),
    CFrame.new(-16245.412109375, 158.43699645996094, 1463.365966796875),
    CFrame.new(-16212.46875, 158.16700744628906, 1466.343994140625),
    CFrame.new(-16211.9462890625, 158.07200622558594, 1322.39794921875),
    CFrame.new(-16260.921875, 154.92100524902344, 1323.615966796875),
    CFrame.new(-16297.0595703125, 159.322998046875, 1317.2239990234375),
    CFrame.new(-16335.0966796875, 159.33399963378906, 1324.885986328125),
}

spawn(function()
    while wait(Sec) do
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


Tabs.Main:AddSection({"Farm Material"})

Test = Tabs.Main:AddDropdown({
Name = "Select Material",
		Description = "",
		Options = MaterialList,
		Default = false,
		Callback = function(Value)
			getgenv().SelectMaterial = Value
		end
		})
Toggle = Tabs.Main:AddToggle({
Name = "Auto Farm Materials", 
Description = "Tự Động Cày Nguyên Liệu", 
Default = false,
Callback = function(Value)
    getgenv().AutoMaterial = Value
end})
spawn(function()
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
  while wait() do
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


Tabs.Main:AddSection({"Farm Boss"})
-- ==============================
-- BOSS LISTS THEO TỪNG SEA (CHÍNH XÁC NHƯ BẠN CUNG CẤP)
-- ==============================
if World1 then 
    BossList = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
elseif World2 then 
    BossList = {"Diamond","Jeremy","Orbitus","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
elseif World3 then 
    BossList = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Dough King","Longma","Soul Reaper","Tyrant of the Skies"}
end

-- === Dropdown Chọn Boss ===
BossDropdown = Tabs.Main:AddDropdown({
    Name = "Select Boss",
    Description = "",
    Options = BossList,
    Default = nil,
    Callback = function(value)
        getgenv().SelectBoss = value
        print("[Chọn Boss] " .. tostring(value))
        task.spawn(UpdateBossStatus)
    end
})

-- === Toggle Farm Boss Đã Chọn ===
FarmBossToggle = Tabs.Main:AddToggle({
    Name = "Auto Farm Boss",
    Description = "Tự Động Đánh Boss",
    Default = false,
    Callback = function(Value)
        getgenv().AutoFarmBoss = Value
        print("[Farm Boss] " .. (Value and "BẬT" or "TẮT"))
    end
})

-- === Loop Farm Boss Đã Chọn ===
task.spawn(function()
    while task.wait(0.2) do
        if not getgenv().AutoFarmBoss or not getgenv().SelectBoss then continue end

        pcall(function()
            local plr = game.Players.LocalPlayer
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local targetName = getgenv().SelectBoss
            local enemies = workspace:FindFirstChild("Enemies")
            if not enemies then return end

            local candidates = {}
            for _, model in pairs(enemies:GetChildren()) do
                local hum = model:FindFirstChildWhichIsA("Humanoid")
                local part = model:FindFirstChild("HumanoidRootPart")
                if hum and part and hum.Health > 0 and string.find(string.upper(model.Name), string.upper(targetName)) then
                    local dist = (hrp.Position - part.Position).Magnitude
                    table.insert(candidates, {model = model, dist = dist, part = part})
                end
            end

            if #candidates > 0 then
                table.sort(candidates, function(a, b) return a.dist < b.dist end)
                local best = candidates[1]
                _tp(best.part.CFrame * CFrame.new(0, 35, 0))
                if Attack and typeof(Attack.Kill) == "function" then
                    Attack.Kill(best.model, true)
                end
            else
                -- TP về ReplicatedStorage rep
                for _, rep in pairs(game.ReplicatedStorage:GetChildren()) do
                    if string.find(string.upper(rep.Name), string.upper(targetName)) and rep:FindFirstChild("HumanoidRootPart") then
                        _tp(rep.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                        break
                    end
                end
            end
        end)
    end
end)
Tabs.Main:AddSection({"Farming Mastery"})
local posMastery = {"Cake","Bone"}
local Mastery_Config = Tabs.Main:AddDropdown({
Name = "Choose Location Farm",
		Description = "",
		Options = posMastery,
		Default = false,
		Callback = function(Value)
  SelectIsland = Value
end})
local MasteryFruits = Tabs.Main:AddToggle({
Name = "Auto Mastery Fruit", 
Description = "Tự Động Cày Thông Thạo Trái", 
Default = false,
Callback = function(Value)
  _G.FarmMastery_Dev = Value
end})
spawn(function()RunSer.RenderStepped:Connect(function() pcall(function()if _G.FarmMastery_Dev or _G.FarmMastery_G or _G.FarmMastery_S then for a,b in pairs(plr.PlayerGui.Notifications:GetChildren())do if b.Name=="NotificationTemplate"then if string.find(b.Text,"Skill locked!")then b:Destroy()end end end end end)end) end)
spawn(function()
  while wait(Sec) do
    if _G.FarmMastery_Dev then
      pcall(function()
        if SelectIsland == "Cake" then         
          local v = GetConnectionEnemies(mastery1)
		  if v then		   
		    HealthM = v.Humanoid.MaxHealth * 70 / 100
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
		    HealthM = v.Humanoid.MaxHealth * 70 / 100
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
local MasteryGun = Tabs.Main:AddToggle({
Name = "Auto Mastery Gun", 
Description = "Tự Động Cày Thông Thạo Súng", 
Default = false,
Callback = function(Value)
  _G.FarmMastery_G = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.FarmMastery_G then
      pcall(function()
        if SelectIsland == "Cake" then
          local v = GetConnectionEnemies(mastery1)
		  if v then		      
		    HealthM = v.Humanoid.MaxHealth * 70 / 100
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
		    HealthM = v.Humanoid.MaxHealth * 70 / 100
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
local MasteryGun = Tabs.Main:AddToggle({
    Name = "Auto Mastery Dragon Storm", 
    Description = "Tự Động Cày Thông Thạo Dragon Storm",
    Default = false,
    Callback = function(Value)
        _G.FarmMastery_G = Value
    end
})

-- Globals cho range/delay (có thể chỉnh trong script hoặc UI khác)
getgenv().PMT_GunFarm_Range = getgenv().PMT_GunFarm_Range or 2500
getgenv().PMT_GunFarm_Delay = getgenv().PMT_GunFarm_Delay or 0.01

local P = game:GetService("Players")
local R = game:GetService("ReplicatedStorage")
local L = P.LocalPlayer
local S = R:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/ShootGunEvent")

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
            local p = m.HumanoidRootPart.Position
            local dx, dy, dz = p.X - rp.X, p.Y - rp.Y, p.Z - rp.Z
            local d2 = dx*dx + dy*dy + dz*dz
            if d2 < bestd then bestd, best = d2, m end
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

-- Main loop farm mastery gun (Dragon Storm)
task.spawn(function()
    while task.wait(getgenv().PMT_GunFarm_Delay) do
        if _G.FarmMastery_G then
            pcall(function()
                local m = Near(getgenv().PMT_GunFarm_Range)
                if m then 
                    Fire(m) 
                end
            end)
        end
    end
end)
local MasterySword = Tabs.Main:AddToggle({
Name = "Auto Mastery All Sword", 
Description = "Tự Động Cày Thông Thạo Tất Cả Kiếm", 
Default = false,
Callback = function(Value)
  _G.FarmMastery_S = Value
end})
spawn(function()
  while wait(Sec) do
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

Tabs.Settings:AddSection({"Settings / Configure"})

AutoBuddhaZ = Tabs.Settings:AddToggle({
    Name = "Auto Use Skill Z Buddha",
    Description = "Tự Động Dùng Chiêu Z Buddha Để Farm",
    Default = false,
    Callback = function(Value)
        _G.AutoBuddhaZ = Value
    end
})

-- ========== KHỞI TẠO ==========
_G.AutoBuddhaZ = _G.AutoBuddhaZ or false
_G.EquippedBuddhaThisLife = false
_G.ZUsedThisLife = false
_G.WasTransformed = false

local UIS = game:GetService("UserInputService")
local vim1 = game:GetService("VirtualInputManager")
local player = game.Players.LocalPlayer

-- ========== HÀM EQUIP BUDDHA ==========
local function EquipBuddha()
    local char = player.Character
    if not char then return false end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return false end

    -- Nếu đang cầm Buddha rồi thì không cần làm gì
    local currentTool = char:FindFirstChildOfClass("Tool")
    if currentTool and (currentTool.Name == "Human: Buddha" or currentTool.Name == "Buddha-Buddha" or currentTool.Name == "Buddha") then
        return true
    end

    -- Tìm Buddha trong Backpack (ưu tiên "Buddha-Buddha")
    local buddhaTool = nil
    for _, tool in pairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name == "Buddha-Buddha" or tool.Name == "Buddha Fruit" or tool.Name == "Buddha-Buddha Fruit" or tool.Name == "Buddha") then
            buddhaTool = tool
            break
        end
    end

    if buddhaTool then
        humanoid:EquipTool(buddhaTool)
        task.wait(0.5) -- Chờ equip
        return true
    end
    return false
end

-- ========== HÀM KIỂM TRA ĐANG CẦM BUDDHA ==========
local function IsHoldingBuddha()
    local char = player.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    return tool and (tool.Name == "Human: Buddha" or tool.Name == "Buddha-Buddha" or tool.Name == "Buddha")
end

-- ========== HÀM KIỂM TRA TRANSFORM ==========
local function IsTransformed()
    local char = player.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    return root and root.Size.Y > 6
end

-- ========== HÀM NHẤN Z ==========
local function PressZ()
    if UIS:GetFocusedTextBox() then return false end
    vim1:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
    task.wait(0.09)
    vim1:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
    return true
end

-- ========== RESET KHI CHẾT ==========
player.CharacterAdded:Connect(function()
    _G.EquippedBuddhaThisLife = false
    _G.ZUsedThisLife = false
    _G.WasTransformed = false
end)

-- Reset ban đầu nếu đang có character
if player.Character then
    _G.EquippedBuddhaThisLife = false
    _G.ZUsedThisLife = false
    _G.WasTransformed = false
end

-- ========== LOOP CHÍNH ==========
task.spawn(function()
    while task.wait(1) do
        -- Kiểm tra nhân vật còn sống
        local char = player.Character
        if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
            _G.EquippedBuddhaThisLife = false
            _G.ZUsedThisLife = false
            _G.WasTransformed = false
            continue
        end

        if not _G.AutoBuddhaZ then continue end

        -- ===== AUTO EQUIP BUDDHA NẾU CHƯA CẦM =====
        if not IsHoldingBuddha() and not _G.EquippedBuddhaThisLife then
            local success = EquipBuddha()
            if success then
                _G.EquippedBuddhaThisLife = true
            end
        end

        -- ===== AUTO BUDDHA Z =====
        if IsHoldingBuddha() then
            local transformed = IsTransformed()
            if transformed then
                _G.WasTransformed = true
            else
                -- Nếu trước đó đã transform mà giờ mất → cần dùng lại Z
                if _G.WasTransformed then
                    _G.ZUsedThisLife = false
                    _G.WasTransformed = false
                end
            end

            -- Nếu chưa dùng Z trong life này (hoặc đã reset)
            if not _G.ZUsedThisLife then
                local success = PressZ()
                if success then
                    _G.ZUsedThisLife = true
                    task.wait(0.5)
                    _G.WasTransformed = IsTransformed()
                end
            end
        end
    end
end)
Initialize = Tabs.Settings:AddToggle({
Name = "Fast Attack", 
Description = "Đánh Nhanh", 
Default = true,
Callback = function(Value)
  _G.Seriality = Value
end})

local Bringmob = Tabs.Settings:AddToggle({
Name = "Bring Mob", 
Description = "Gom Quái", 
Default = true,
Callback = function(Value)
  _B = Value
end})
-- 🌀 Toggle Auto Server Hop mỗi 30 phút
HopToggle = Tabs.Settings:AddToggle({
    Name = "Auto Hop [Evevry 30 Minutes]",
    Description = "Tự Động Chuyển Máy Chủ [Mỗi 30 Phút]",
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
BusuAura = Tabs.Settings:AddToggle({
Name = "Auto Turn On Haki", 
Description = "Tự Động Bật Haki", 
Default = true,
Callback = function(Value)
  Boud = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if Boud then
      local _HasBuso = {"HasBuso","Buso"}
  	  if not plr.Character:FindFirstChild(_HasBuso[1]) then replicated.Remotes.CommF_:InvokeServer(_HasBuso[2]) end
      end
    end)
  end
end)
RaceV3Aura = Tabs.Settings:AddToggle({
Name = "Auto Turn On V3", 
Description = "Tự Động Bật V3", 
Default = false,
Callback = function(Value)
  _G.RaceClickAutov3 = Value
end})
spawn(function()
  while wait(.2) do
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
RaceV4Aura = Tabs.Settings:AddToggle({
Name = "Auto Turn On V4", 
Description = "Tự Động Bật V4", 
Default = false,
Callback = function(Value)
  _G.RaceClickAutov4 = Value
end})
spawn(function()
  while wait(.2) do
    pcall(function()
      if _G.RaceClickAutov4 then
  	    if plr.Character:FindFirstChild("RaceEnergy") then
        if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then Useskills("nil","Y") end
        end        
      end 
    end)
  end
end)
RandomAround = Tabs.Settings:AddToggle({
Name = "Auto Turn On Spin Position", 
Description = "Tự Động Bật Spin Position", 
Default = false,
Callback = function(Value)
  RandomCFrame = Value
end})
Byp = Tabs.Settings:AddToggle({
Name = "Turn On Bypass Teleport", 
Description = "Bật Dịch Chuyển Bypass", 
Default = false,
Callback = function(Value)
  _G.Bypass = Value
end})
SafeModes = Tabs.Settings:AddToggle({
Name = "Panic Mode", 
Description = "Chế Độ Hoảng Loạn", 
Default = false,
Callback = function(Value)
  _G.Safemode = Value
end})
spawn(function()
  while task.wait(Sec) do
    pcall(function()
	  if _G.Safemode then
  	  local Calc_Health = plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth * 100
  	  if Calc_Health < Num_self then shouldTween=true _tp(Root.CFrame * CFrame.new(0,500,0)) else shouldTween=false end
      end
    end)
  end
end)

DisableHitVFX = Tabs.Settings:AddToggle({
    Name = "Remove Hit",
    Description = "Xoá Hiệu Ứng Chém Và Kiếm Để Có Khả Năng Hiển Thị Tốt Hơn",
    Default = false,
    Callback = function(Value)
        _G.DestroyHit = Value
    end
})

-- 🌀 Danh sách hiệu ứng cần xóa
local HitEffects = {"SlashHit", "CurvedRing", "SwordSlash", "SlashTail"}

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
RmvVFX = Tabs.Settings:AddToggle({
Name = "Remove Death And Respamed", 
Description = "Xoá Hiệu Ứng Chết Và Hồi Sinh", 
Default = false,
Callback = function(Value)
  RDeath = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if RDeath then
	  if replicated.Effect.Container:FindFirstChild("Death") then replicated.Effect.Container.Death:Destroy() end
      if replicated.Effect.Container:FindFirstChild("Respawn") then replicated.Effect.Container.Respawn:Destroy() end
	  end
    end)
  end
end)	
DisblesNotify = Tabs.Settings:AddToggle({
Name = "Disable Notify", 
Description = "Tắt Thông Báo", 
Default = false,
Callback = function(Value)
  RemoveDamage = Value
end})
spawn(function()
  while wait(Sec) do
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
--==================================================
-- SERVICES
--==================================================
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local plr = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================
local AntiKick = true
local AntiKickDelay = 18 * 60 -- 18 phút (an toàn hơn 20)

--==================================================
-- TOGGLE (Settings Tab)
--==================================================
AntiAFK = Tabs.Settings:AddToggle({
    Name = "Anti Kick",
    Description = "Chống Kick",
    Default = true,
    Callback = function(Value)
        AntiKick = Value
    end
})

--==================================================
-- ANTI AFK LOGIC
--==================================================
plr.Idled:Connect(function()
    if AntiKick then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

--==================================================
-- BACKUP LOOP (phòng game anti mạnh)
--==================================================
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

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

getgenv().WalkSpeedValue = 30
getgenv().JumpValue = 50

-- ==============================
-- APPLY HUMANOID
-- ==============================
local function ApplyHumanoid(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if not hum then return end

    hum.WalkSpeed = getgenv().WalkSpeedValue
    hum.JumpPower = getgenv().JumpValue

    hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        hum.WalkSpeed = getgenv().WalkSpeedValue
    end)
end

lp.CharacterAdded:Connect(ApplyHumanoid)
if lp.Character then
    ApplyHumanoid(lp.Character)
end

-- ==============================
-- SLIDER : SPEED
-- ==============================
Tabs.Settings:AddSlider({
    Name = "Auto Speed",
    Min = 26,
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

-- ==============================
-- SLIDER : JUMP
-- ==============================
Tabs.Settings:AddSlider({
    Name = "Auto Jump",
    Min = 50,
    Max = 500,
    Default = getgenv().JumpValue,
    Callback = function(Value)
        getgenv().JumpValue = Value
        local hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
        if hum then
            hum.JumpPower = Value
        end
    end
})

-- ==============================
-- TOGGLE : DELETE LAVA
-- ==============================
Tabs.Settings:AddToggle({
    Name = "Remove Lava",
    Description = "Xoá Dung Nham",
    Default = false,
    Callback = function(Value)
        _G.RemoveLava = Value
    end
})

task.spawn(function()
    while task.wait(1) do
        if _G.RemoveLava then
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and string.find(v.Name:lower(), "lava") then
                    pcall(function()
                        v:Destroy()
                    end)
                end
            end
        end
    end
end)

-- ==============================
-- ESP CORE
-- ==============================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CollectionService = game:GetService("CollectionService")

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
Tabs.Settings:AddSection("ESP")

Tabs.Settings:AddToggle({
    Name = "Esp Player",
    Default = false,
    Callback = function(v)
        ESPPlayer = v
        if not v then UpdatePlayerChams() end
    end
})

Tabs.Settings:AddToggle({
    Name = "Esp Chest",
    Default = false,
    Callback = function(v)
        _G.ChestESP = v
        if not v then UpdateChestESP() end
    end
})

Tabs.Settings:AddToggle({
    Name = "Esp Fruit",
    Default = false,
    Callback = function(v)
        DevilFruitESP = v
        if not v then UpdateDevilChams() end
    end
})

Tabs.Settings:AddToggle({
    Name = "Esp Island",
    Default = false,
    Callback = function(v)
        IslandESP = v
        if not v then UpdateIslandESP() end
    end
})
Tabs.Settings:AddSection({"Stats Upgrade"})
StatusSelect = Tabs.Settings:AddSlider({
Name = "Stats Value",
Description = "",
Default = 10,
Min = 0,
Max = 1000,
Rounding = 1, 
Callback = function(Value)
  pSats = Value
end})

StatsUpg = Tabs.Settings:AddToggle({
Name = "Auto Melee", 
Description = "Tự Động Nâng Cận Chiến", 
Default = false,
Callback = function(Value)
  _G.Auto_Melee = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
    if _G.Auto_Melee then statsSetings("Melee",pSats) end
    end)
  end
end)

StatsUpg = Tabs.Settings:AddToggle({
Name = "Auto Swords", 
Description = "Tự Động Nâng Kiếm", 
Default = false,
Callback = function(Value)
  _G.Auto_Sword = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
    if _G.Auto_Sword then statsSetings("Sword",pSats) end
    end)
  end
end)
StatsUpg = Tabs.Settings:AddToggle({
Name = "Auto Gun", 
Description = "Tự Động Nâng Súng", 
Default = false,
Callback = function(Value)
  _G.Auto_Gun = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
    if _G.Auto_Gun then statsSetings("Gun",pSats) end
    end)
  end
end)
StatsUpg = Tabs.Settings:AddToggle({
Name = "Auto Blox Fruit", 
Description = "Tự Động Nâng Trái", 
Default = false,
Callback = function(Value)
  _G.Auto_DevilFruit = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
    if _G.Auto_DevilFruit then statsSetings("Devil",pSats) end
    end)
  end
end)
StatsUpg = Tabs.Settings:AddToggle({
Name = "Auto Defense", 
Description = "Tự Động Nâng Phòng Thủ", 
Default = false,
Callback = function(Value)
  _G.Auto_Defense = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
    if _G.Auto_Defense then statsSetings("Defense",pSats) end
    end)
  end
end)

Tabs.Fish:AddSection({"Fishing"})


BaitDropdown = Tabs.Fish:AddDropdown({
    Name = "Choose Bait",
    Description = "",
    Options = {"Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait"},
    Multi = false,
    Default = _G.SelectedBait,
    Callback = function(Value)
        _G.SelectedBait = Value
        if _G.AutoBuyBait then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})

BuyBaitToggle = Tabs.Fish:AddToggle({
    Name = "Auto Buy Bait",
    Description = "Tự Động Mua Mồi",
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




Fishing = Tabs.Fish:AddToggle({
Name = "Auto Fishing", 
Description = "Tự Động Câu Cá",
Default = false,
Callback = function(Value)
    _G.AutoFishing = Value
end})


local Players2 = game:GetService("Players")
local LocalPlayer2 = Players2.LocalPlayer
local Workspace2 = game:GetService("Workspace")
local FishReplicated2 = game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated")
local FishingRequest2 = FishReplicated2:WaitForChild("FishingRequest")
local Config2 = require(FishReplicated2.FishingClient.Config)
local GetWaterHeight2 = require(game:GetService("ReplicatedStorage").Util.GetWaterHeightAtLocation)
local maxdistance2 = Config2.Rod.MaxLaunchDistance


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


FishingQ = Tabs.Fish:AddToggle({
Name = "Auto Quest Fishing", 
Description = "Tự Động Nhận Nhiệm Vụ Câu Cá",
Default = false,
Callback = function(Value)
    _G.AutoFishingQuest = Value
end})


local Players3 = game:GetService("Players")
local LocalPlayer3 = Players3.LocalPlayer
local ReplicatedStorage3 = game:GetService("ReplicatedStorage")
local RFJobsRemoteFunction3 = ReplicatedStorage3.Modules.Net:WaitForChild("RF/JobsRemoteFunction")

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


QuestToggle = Tabs.Fish:AddToggle({
    Name = "Auto Complete Quest",
    Description = "Tự Động Hoàn Thành Nhiệm Vụ",
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


SellFishToggle = Tabs.Fish:AddToggle({
    Name = "Auto Sell Fish",
    Description = "Tự Động Bán Cá",
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


SpamSkillZ = Tabs.Fish:AddToggle({
Name = "Auto Spam Skill Z", 
Description = "Tự Động Spam Chiêu Z",
Default = false,
Callback = function(Value)
    _G.AutoSkillZ = Value
end})


local ReplicatedStorage4 = game:GetService("ReplicatedStorage")
local RFJobToolAbilities4 = ReplicatedStorage4.Modules.Net:WaitForChild("RF/JobToolAbilities")

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoSkillZ then
            pcall(function()
                RFJobToolAbilities4:InvokeServer("Z", true)
            end)
        end
    end
end)

TravelDress = Tabs.Quests:AddToggle({
Name = "Auto Quest Sea 2", 
Description = "Tự Động Làm Nhiệm Vụ Sea 2", 
Default = false,
Callback = function(Value)
  _G.TravelDres = Value
end})
spawn(function()
  while wait(Sec) do
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
Zou = Tabs.Quests:AddToggle({
Name = "Auto Quest Sea 3", 
Description = "Tự Động Làm Nhiệm Vụ Sea 3", 
Default = false,
Callback = function(Value)
  _G.AutoZou = Value
end})
spawn(function()
  while wait(Sec) do
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




Tabs.Quests:AddSection({"Tushita And Yama"})

Q = Tabs.Quests:AddToggle({
Name = "Auto Get Tushita", 
Description = "Tự Động Lấy Tushita", 
Default = false,
Callback = function(Value)
  _G.Auto_Tushita = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_Tushita then
        if workspace.Map.Turtle:FindFirstChild("TushitaGate") then
          if not GetBP("Holy Torch") then
            _tp(CFrame.new(5148.03613, 162.352493, 910.548218))
            wait(0.7)
          else
            EquipWeapon("Holy Torch")
            task.wait(1)
            repeat task.wait() _tp(CFrame.new(-10752, 417, -9366)) until not _G.Auto_Tushita or (CFrame.new(-10752, 417, -9366).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
            wait(.7)
            repeat task.wait() _tp(CFrame.new(-11672, 334, -9474)) until not _G.Auto_Tushita or (CFrame.new(-11672, 334, -9474).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
            wait(.7)
            repeat task.wait() _tp(CFrame.new(-12132, 521, -10655)) until not _G.Auto_Tushita or (CFrame.new(-12132, 521, -10655).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
            wait(.7)
            repeat task.wait() _tp(CFrame.new(-13336, 486, -6985)) until not _G.Auto_Tushita or (CFrame.new(-13336, 486, -6985).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
            wait(.7)
            repeat task.wait() _tp(CFrame.new(-13489, 332, -7925)) until not _G.Auto_Tushita or (CFrame.new(-13489, 332, -7925).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
          end
        else
          local v = GetConnectionEnemies("Longma")
          if v then repeat task.wait() Attack.Kill(v,_G.Auto_Tushita) until v.Humanoid.Health <= 0 or not _G.Auto_Tushita or not v.Parent
          else 
          if replicated:FindFirstChild("Longma") then _tp(replicated:FindFirstChild("Longma").HumanoidRootPart.CFrame * CFrame.new(0,40,0)) end
          end                     
        end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Yama", 
Description = "Tự Động Lấy Yama", 
Default = false,
Callback = function(Value)
  _G.Auto_Yama = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_Yama then
	    if replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") < 30 then
	      _G.FarmEliteHunt = true
	    elseif replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") > 30 then
	      _G.FarmEliteHunt = false
	      if (workspace.Map.Waterfall.SealedKatana.Handle.Position-plr.Character.HumanoidRootPart.Position).Magnitude >= 20 then
            _tp(workspace.Map.Waterfall.SealedKatana.Handle.CFrame)
            local zx = GetConnectionEnemies("Ghost")
            if zx then
              repeat wait() Attack.Kill(zx,_G.Auto_Yama) until zx.Humanoid.Health <= 0 or not zx.Parent or not _G.Auto_Yama               
			  fireclickdetector(workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
            end
          end
	    end
      end
    end)
  end
end)

Tabs.Quests:AddSection({"Cursed Dual Katana"})
CheckCDK = Tabs.Quests:AddParagraph({
Title = " Number Cursed Dual Katana Quest ",
Content = "Quest Numbers :"})
spawn(function()  
  while wait(.2) do 
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get CDK", 
Description = "Tự Động Lấy Song Kiếm Nguyền Rủa", 
Default = false,
Callback = function(Value)
  _G.CDK = Value
end})
spawn(function()    
  while wait(Sec) do
    pcall(function()
      if _G.CDK then
        replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Good")
        replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Evil")
        replicated.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Boss")
        local v = GetConnectionEnemies("Cursed Skeleton Boss")
        if v then
          repeat wait()
            if plr.Character:FindFirstChild("Yama") or plr.Backpack:FindFirstChild("Yama") then EquipWeapon("Yama")
            elseif plr.Character:FindFirstChild("Tushita") or plr.Backpack:FindFirstChild("Tushita") then EquipWeapon("Tushita")                                    
            end _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
          until not _G.CDK or not v.Parent or v.Humanoid.Health <= 0                                
        else
          _tp(CFrame.new(-12318.193359375, 601.9518432617188, -6538.662109375)) wait(.5)
          _tp(workspace.Map.Turtle.Cursed.BossDoor.CFrame)
        end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle({
Name = "Auto Quest Yama [CDK]", 
Description = "Tự Động Nhiệm Vụ Yama [CDK]", 
Default = false,
Callback = function(Value)
  _G.CDK_YM = Value
end})
spawn(function()
  while wait() do
    pcall(function()
      if _G.CDK_YM then
        if tostring(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then                  
          replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
          replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
        else
          if replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Finished"] == nil then
            replicated.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil")
            replicated.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil")
          elseif replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Finished"] == false then                        
            if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == -3 then
              QuestYama_1 = true QuestYama_2 = false QuestYama_3 = false
              repeat task.wait()
                if not workspace.Enemies:FindFirstChild("Forest Pirate") then
                  _tp(CFrame.new(-13223.521484375, 428.1938171386719, -7766.06787109375))
                else
                  local v = GetConnectionEnemies("Forest Pirate")
                  if v then _tp(workspace.Enemies:FindFirstChild("Forest Pirate").HumanoidRootPart.CFrame)end
                end
              until tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == 1 or not _G.CDK_YM
            elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == -4 then
              QuestYama_1 = false QuestYama_2 = true QuestYama_3 = false
              for ix,HitMon in pairs(game:GetService("Players").LocalPlayer.QuestHaze:GetChildren()) do
                for NameMonHaze, CFramePos in pairs(PosMsList) do
                  if string.find(NameMonHaze,HitMon.Name) and HitMon.Value > 0 then
                    if (CFramePos.Position - Root.Position).Magnitude <= 1000 and workspace.Enemies:FindFirstChild(NameMonHaze) then
                      for i,v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 and v:FindFirstChild("HazeESP") then
                          repeat wait() Attack.Kill(v, _G.CDK_YM) until not _G.CDK_YM or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == 2 or not v:FindFirstChild("HazeESP") or v.Humanoid.Health <= 0
                        end
                      end
                    else   
                      _tp(CFramePos)                               
                    end
                  end
                end
              end
            elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == -5 then
              QuestYama_1 = false QuestYama_2 = false QuestYama_3 = true
              if workspace.Map:FindFirstChild("HellDimension") then
                if (Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000 then
                  for gg,ez in pairs(workspace.Map.HellDimension.Exit:GetChildren()) do
                    if tonumber(gg) == 2 then
                      repeat task.wait() Root.CFrame = workspace.Map.HellDimension.Exit.CFrame until not _G.CDK_YM or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == 3
                    end
                  end
                  EquipWeapon(_G.SelectWeapon)
                  if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) ~= 3 then
                  repeat task.wait()
                    repeat task.wait() 
                      _tp(workspace.Map.HellDimension.Torch1.Particles.CFrame) 
                      for i, v in pairs(workspace.Map.HellDimension:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                      end
                    until (workspace.Map.HellDimension.Torch1.Particles.Position - Root.Position).Magnitude < 5
                    wait(2) _G.T1Yama = true
                  until not _G.CDK_YM or _G.T1Yama or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == 3
                  repeat task.wait()
                    repeat task.wait()
                      _tp(workspace.Map.HellDimension.Torch2.Particles.CFrame) 
                      for i, v in pairs(workspace.Map.HellDimension:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then fireproximityprompt(v)end
                      end
                    until (workspace.Map.HellDimension.Torch2.Particles.Position - Root.Position).Magnitude < 5
                    wait(2) _G.T2Yama = true
                  until _G.T2Yama or _G.CDK_YM == false or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == 3
                    repeat wait()
                      repeat task.wait() 
                        _tp(workspace.Map.HellDimension.Torch3.Particles.CFrame) 
                        for i, v in pairs(workspace.Map.HellDimension:GetDescendants()) do
                          if v:IsA("ProximityPrompt") then fireproximityprompt(v)end
                        end
                      until (workspace.Map.HellDimension.Torch3.Particles.Position - Root.Position).Magnitude < 5 
                      wait(2) _G.T3Yama = true
                    until _G.T3Yama or _G.CDK_YM == false or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == 3
                  end
                  for i,v in pairs(workspace.Enemies:GetChildren()) do
                    if (v:FindFirstChild("HumanoidRootPart").Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 300 then
                      if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                        repeat task.wait() Attack.Kill(v,_G.CDK_YM) until not _G.CDK_YM or v.Humanoid.Health <= 0 or not v.Parent or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == 3
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
  end
end)
spawn(function()
  while wait() do
    pcall(function()
      if _G.CDK_YM then
        if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == -5 then
          if not workspace.Map:FindFirstChild("HellDimension") or (Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude > 1000 then
            local v = GetConnectionEnemies("Soul Reaper")
            if v then repeat task.wait()_tp(v.HumanoidRootPart.CFrame) until v.Humanoid.Health <= 0 or not _G.CDK_YM or not v.Parent or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Evil"]) == 3 or (workspace.Map:FindFirstChild("HellDimension") and (Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000)
            elseif plr.Backpack:FindFirstChild("Hallow Essence") or plr.Character:FindFirstChild("Hallow Essence") then
            repeat _tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125)) task.wait() until (CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125).Position - Root.Position).Magnitude <= 8
            EquipWeapon("Hallow Essence")
            elseif replicated:FindFirstChild("Soul Reaper") and replicated:FindFirstChild("Soul Reaper").Humanoid.Health > 0 then
              _tp(replicated:FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame)
            else
              if replicated.Remotes.CommF_:InvokeServer("Bones","Check") < 50 and not workspace.Enemies:FindFirstChild("Soul Reaper") and not replicated:FindFirstChild("Soul Reaper") and not workspace.Map:FindFirstChild("HellDimension") then
                if workspace.Enemies:FindFirstChild("Reborn Skeleton") or workspace.Enemies:FindFirstChild("Living Zombie") or workspace.Enemies:FindFirstChild("Domenic Soul") or workspace.Enemies:FindFirstChild("Posessed Mummy") then
                  for i,v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                      if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                        repeat task.wait() Attack.Kill(v,_G.CDK_YM)until not _G.CDK_YM or v.Humanoid.Health <= 0 or not v.Parent
                      end
                    end
                  end
                else
                  _tp(CFrame.new(-9515.2255859375, 164.0062255859375, 5785.38330078125))
                end
              else
                replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
              end
            end
          end
        end
      end
    end)
  end
end)

Q = Tabs.Quests:AddToggle({
Name = "Auto Quest Tushita [CDK]", 
Description = "Tự Động Nhiệm Vụ Tushita [CDK]", 
Default = false,
Callback = function(Value)
  _G.CDK_TS = Value
end})
spawn(function()
  while wait() do
    pcall(function()
      if _G.CDK_TS then
        if tostring(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
          wait(.7) replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
          wait(.3) replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
        else
          if replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Finished"] == nil then
            replicated.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Good")
          elseif replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Finished"] == false then
            if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Good"]) == -3 then
              QuestTushita_1 = true
              QuestTushita_2 = false
              QuestTushita_3 = false
              repeat wait() _tp(CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875)) until (CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CDK_TS or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Good"]) == 1
              if (CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                wait(.7) replicated.Remotes.CommF_:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"),"Check")
                wait(.5) replicated.Remotes.CommF_:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
              end
                wait(1) repeat wait() _tp(CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125)) until (CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CDK_TS or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Good"]) == 1
                if (CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                wait(.7) replicated.Remotes.CommF_:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"),"Check")
                wait(.5) replicated.Remotes.CommF_:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
                end
                  wait(1) repeat wait() _tp(CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625)) until (CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CDK_TS or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Good"]) == 1
                  if (CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                    wait(.7) replicated.Remotes.CommF_:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"),"Check")
                    wait(.5) replicated.Remotes.CommF_:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
                  end
                  wait(1)
                  elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Good"]) == -4 then
                    QuestTushita_1 = false
                    QuestTushita_2 = true
                    QuestTushita_3 = false
                    repeat wait()
                      _G.AutoRaidCastle = true
                    until not _G.CDK_TS or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Good"]) == 2 
                      _G.AutoRaidCastle = false         
                  elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Good"]) == -5 then
                    QuestTushita_1 = false
                    QuestTushita_2 = false
                    QuestTushita_3 = true
                    if workspace.Enemies:FindFirstChild("Cake Queen") then
                      for i,v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == "Cake Queen" then
                          if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            repeat wait()
                              Attack.Kill(v, _G.CDK_TS)
                            until not _G.CDK_TS or not v.Parent or v.Humanoid.Health <= 0 or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Good"]) == 3
                          end
                        end
                      end
                     elseif replicated:FindFirstChild("Cake Queen") and replicated:FindFirstChild("Cake Queen").Humanoid.Health > 0 then
                       _tp(replicated:FindFirstChild("Cake Queen").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                     else
                   if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.HeavenlyDimension.Spawn.Position).Magnitude <= 1000 then
                     for i,v in pairs(workspace.Map.HeavenlyDimension.Exit:GetChildren()) do
                       Ex = i
                     end
                     if Ex == 2 then
                       repeat wait()
                         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.HeavenlyDimension.Exit.CFrame
                       until not _G.CDK_TS or tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")["Good"]) == 3
                    end
                   repeat wait()
                     repeat wait() 
                       _tp(CFrame.new(-22529.6171875, 5275.77392578125, 3873.5712890625)) 
                       for i, v in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
                         if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                       end
                     until (CFrame.new(-22529.6171875, 5275.77392578125, 3873.5712890625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
                     wait(2)
                    _G.DoneT1 = true
                  until not _G.CDK_TS or _G.DoneT1
                  repeat wait()
                    repeat wait()
                      _tp(CFrame.new(-22637.291015625, 5281.365234375, 3749.28857421875)) 
                       for i, v in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
                         if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                       end
                    until (CFrame.new(-22637.291015625, 5281.365234375, 3749.28857421875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
                    wait(2) _G.DoneT2 = true
                  until _G.DoneT2 or _G.CDK_TS == false
                  repeat wait()
                    repeat task.wait() 
                      _tp(CFrame.new(-22791.14453125, 5277.16552734375, 3764.570068359375)) 
                      for i, v in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                      end
                    until (CFrame.new(-22791.14453125, 5277.16552734375, 3764.570068359375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
                    wait(2) _G.DoneT3 = true
                  until _G.DoneT3 or _G.CDK_TS == false
                  for i,v in pairs(workspace.Enemies:GetChildren()) do
                    if (v:FindFirstChild("HumanoidRootPart").Position - CFrame.new(-22695.7012, 5270.93652, 3814.42847, 0.11794927, 3.32185834e-08, 0.99301964, -8.73070718e-08, 1, -2.30819008e-08, -0.99301964, -8.3975138e-08, 0.11794927).Position).Magnitude <= 300 then
                      if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                        repeat wait()
                          Attack.Kill(v, _G.CDK_TS)
                        until not _G.CDK_TS or v.Humanoid.Health <= 0 or not v.Parent                      
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
  end
end)
Tabs.Quests:AddSection({"True Triple Katana Sword"})
Tabs.Quests:AddButton({
Name = "Auto Buy Legendary Sword",
Description = "Tự Động Mua Kiếm Lagendary",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","1")
  replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","2")
  replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","3")
end})
Tabs.Quests:AddButton({
Name = "Auto Craft True Triple Katana", 
Description = "Tự Động Chế Tạo True Triple Katana",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("MysteriousMan","2")
end})
Q = Tabs.Quests:AddToggle({
Name = "Tween To Legendary Sword Seller NPC", 
Description = "Bay Đến NPC Bán Kiếm Legendary", 
Default = false,
Callback = function(Value)
  _G.Tp_LgS = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.Tp_LgS then
	  pcall(function()
	    for _,v in pairs(replicated.NPCs:GetChildren()) do
	      if v.Name == "Legendary Sword Dealer " then _tp(v.HumanoidRootPart.CFrame) end
        end   	   
	  end)
    end
  end
end)

Tabs.Quests:AddSection({"Pole / God Enal's"})
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Pole V1", 
Description = "Tự Động Lấy Pole V1", 
Default = false,
Callback = function(Value)
  _G.AutoPole = Value
end})
spawn(function()
  while wait(Sec) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Pole V2 [Beta]", 
Description = "Tự Động Lấy Pole V2 [Thử Nghiệm]", 
Default = false,
Callback = function(Value)
  _G.AutoPoleV2 = Value
end})
spawn(function()
  while wait(Sec) do
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

Tabs.Quests:AddSection({"Items Law / Order Sword"})
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Law Sword", 
Description = "Tự Động Lấy Kiếm Law", 
Default = false,
Callback = function(Value)
  _G.AutoLawKak = Value
end})
spawn(function()
  while wait(Sec) do
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

Tabs.Quests:AddSection({"East Blue Misc"})
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Saw Sword", 
Description = "Tự Động Lấy Kiếm Saw", 
Default = false,
Callback = function(Value)
  _G.AutoSaw = Value
end})
spawn(function()
  while wait(.2) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Saber Sword", 
Description = "Tự Động Lấy Kiếm Saber", 
Default = false,
Callback = function(Value)
  _G.AutoSaber = Value
end})
spawn(function()
  while wait(.2) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Cybrog", 
Description = "Tự Động Lấy Người Máy", 
Default = false,
Callback = function(Value)
  _G.AutoColShad = Value
end})
spawn(function()
  while wait(.2) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Usoap's Hat", 
Description = "Tự Động Lấy Mũ Usoap", 
Default = false,
Callback = function(Value)
  _G.AutoGetUsoap = Value
end})
spawn(function()
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Bisento V2", 
Description = "Tự Động Lấy Đại Đao V2", 
Default = false,
Callback = function(Value)
  _G.Greybeard = Value
end})
spawn(function()
  while wait(Sec) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Warden Sword", 
Description = "Tự Động Lấy Kiếm Warden", 
Default = false,
Callback = function(Value)
  _G.WardenBoss = Value
end})
spawn(function()
  while wait(.1) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Marine Coat", 
Description = "Tự Động Lấy Áo Choàng Hải Quân", 
Default = false,
Callback = function(Value)
  _G.MarinesCoat = Value
end})
spawn(function()
  while wait(.1) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Swan Coat", 
Description = "Tự Động Lấy Áo Choàng Swan", 
Default = false,
Callback = function(Value)
  _G.SwanCoat = Value
end})
spawn(function()
  while wait(.1) do
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

Tabs.Quests:AddSection({"Rengoku Sword"})
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Rengoku Sword", 
Description = "Tự Động Lấy Kiếm Rengoku", 
Default = false,
Callback = function(Value)
  _G.IceBossRen = Value
end})
spawn(function()
  pcall(function()
    while wait(.1) do
      if _G.IceBossRen then
        local v = GetConnectionEnemies("Awakened Ice Admiral")
        if v then repeat task.wait()Attack.Kill(v,_G.IceBossRen)until _G.IceBossRen == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813))
        end
      end
    end
  end)
end)
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Key Rengoku", 
Description = "Tự Động Lấy Chìa Khoá Rengoku", 
Default = false,
Callback = function(Value)
  _G.KeysRen = Value
end})
spawn(function()
  while wait(.1) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Dragon Trident", 
Description = "Tự Động Lấy Dragon Trident", 
Default = false,
Callback = function(Value)
  _G.AutoTridentW2 = Value
end})
spawn(function()
  while wait(.1) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Long Sword", 
Description = "Tự Động Lấy Kiếm Dài", 
Default = false,
Callback = function(Value)
  _G.LongsWord = Value
end})
spawn(function()
  while wait(.1) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Black Spikey", 
Description = "Tự Động Lấy Black Spikey", 
Default = false,
Callback = function(Value)
  _G.BlackSpikey = Value
end})
spawn(function()
  while wait(.1) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Dark Blade V3", 
Description = "Tự Động Lấy Dark Blade V3", 
Default = false,
Callback = function(Value)
  _G.DarkBladev3 = Value
end})
spawn(function()
  while wait(Sec) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Midnight Blade", 
Description = "Tự Động Lấy Midnight Blade", 
Default = false,
Callback = function(Value)
  _G.AutoEcBoss = Value
end})
spawn(function()
  while wait(Sec) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Farm Darkbeard", 
Description = "Tự Động Đánh Râu Đen", 
Default = false,
Callback = function(Value)
  _G.Auto_Def_DarkCoat = Value
end})
spawn(function()
  while wait(.1) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Unlock DonSwan", 
Description = "Tự Động Mở Khoá DonSwan", 
Default = false,
Callback = function(Value)
  _G.Auto_DonAcces = Value
end})
spawn(function()
  while wait(.1) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Swan Glasses", 
Description = "Tự Động Lấy Kính Swan", 
Default = false,
Callback = function(Value)
  _G.Auto_SwanGG = Value
end})
spawn(function()
  while wait(.2) do
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

Tabs.Quests:AddSection({"Cavender + Twin Hooks + Bigmom"})
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Buddy Sword", 
Description = "Tự Động Lấy Kiếm Buddy", 
Default = false,
Callback = function(Value)
  _G.AutoBigmom = Value
end})
spawn(function()
  while wait(Sec) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Florentino Sword", 
Description = "Tự Động Lấy Kiếm Florentino", 
Default = false,
Callback = function(Value)
  _G.Auto_Cavender = Value
end})
spawn(function()
  while wait(Sec) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Twin Hooks", 
Description = "Tự Động Lấy Móc Đôi", 
Default = false,
Callback = function(Value)
  _G.TwinHook = Value
end})
spawn(function()
  while wait(Sec) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Serpent Bow", 
Description = "Tự Động Lấy Serpent Bow", 
Default = false,
Callback = function(Value)
  _G.AutoSerpentBow = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoSerpentBow then
      local v = GetConnectionEnemies("Hydra Leader")
      if v then	repeat wait() Attack.Kill(v,_G.AutoSerpentBow)until not _G.AutoSerpentBow or not v.Parent or v.Humanoid.Health <= 0
	  else _tp(CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547))
      end
    end
  end
end)
Q = Tabs.Quests:AddToggle({
Name = "Auto Get Lei Accessory", 
Description = "Tự Động Lấy Lai Accessory", 
Default = false,
Callback = function(Value)
  _G.AutoKilo = Value
end})
spawn(function()
  while wait(.2) do
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

Tabs.Quests:AddSection({"Buso / Aura Colours"})
Q = Tabs.Quests:AddToggle({
Name = "Auto Teleport Barista Cousin", 
Description = "Tự Động Dịch Chuyển Đến Barista Cousin", 
Default = false,
Callback = function(Value)
  _G.Tp_MasterA = Value
end})
spawn(function()
  while wait() do
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
Name = "Buy Color Haki", 
Description = "Mua Màu Haki",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("ColorsDealer","2")
end})
Q = Tabs.Quests:AddToggle({
Name = "Auto Haki Rainbow", 
Description = "Tự Động Lấy Haki 7 Màu", 
Default = false,
Callback = function(Value)
  _G.Auto_Rainbow_Haki = Value
end})
spawn(function()
  pcall(function()
    while wait(Sec) do
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
Q = Tabs.Quests:AddToggle({
Name = "Get Quest Haki Rainbow", 
Description = "Nhận Nhiệm Vụ Haki 7 Màu", 
Default = false,
Callback = function(Value)
  _G.GetQFast = Value
end})

Tabs.Quests:AddSection({"Instinct / Observation"})
Q = Tabs.Quests:AddToggle({
Name = "Auto Farm Haki Observation", 
Description = "Tự Động Cày Điểm Né Haki Quan Sát", 
Default = false,
Callback = function(Value)
  _G.obsFarm = Value
end})
spawn(function()
  while wait(.2) do
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
spawn(function()      
  while wait(.2) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Haki Observation V2", 
Description = "Tự Động Lấy Haki Quan Sát V2", 
Default = false,
Callback = function(Value)
  _G.AutoKenVTWO = Value
end})
spawn(function()
  while wait(Sec) do
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



Bartilo = Tabs.Quests:AddToggle({
Name = "Auto Complete Quest Bartilo", 
Description = "Tự Động Hoàn Thành Nhiệm Vụ Bartilo", 
Default = false,
Callback = function(Value)
  _G.Bartilo_Quest = Value
end})
spawn(function()
  while wait(.1) do    
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
CitizenQ = Tabs.Quests:AddToggle({
Name = "Auto Complete Quest Citizen", 
Description = "Tự Động Hoàn Thành Nhiệm Vụ Citizen", 
Default = false,
Callback = function(Value)
  _G.CitizenQuest = Value
end})
spawn(function()	
  while wait(Sec) do
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
Q = Tabs.Quests:AddToggle({
Name = "Auto Farm Training Dummy", 
Description = "Tự Động Đánh Training Dummy", 
Default = false,
Callback = function(Value)
  _G.DummyMan = Value
end})
spawn(function()
  while wait(Sec) do
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




Tabs.Quests:AddSection({"Dark Dragger + Valkyrie"})
Q = Tabs.Quests:AddToggle({
Name = "Auto Farm Rip Indra", 
Description = "Tự Động Đánh Rip Indra", 
Default = false,
Callback = function(Value)
  _G.AutoRipIngay = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.AutoRipIngay then
        local v = GetConnectionEnemies("rip_indra")
	    if not GetWP("Dark Dagger") or not GetIn("Valkyrie") and v then
	      repeat wait() Attack.Kill(v,_G.AutoRipIngay)until not _G.AutoRipIngay or not v.Parent or v.Humanoid.Health <= 0
        else
          replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
		  wait(.1)_tp(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781))
	    end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle({
Name = "Auto Three Color Haki", 
Description = "Tự Động Giải Mã 3 Màu Haki", 
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
spawn(function()
  while wait(Sec) do
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

Tabs.Quests:AddSection({"Fighting Melee Styles"})
SuperHuman = Tabs.Quests:AddToggle({
Name = "Auto Get Superhuman", 
Description = "Tự Động Lấy Thượng Nhân Quyền", 
Default = false,
Callback = function(Value)
  _G.Auto_SuperHuman = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_SuperHuman then
      local M_Beli = plr.Data.Beli.Value
	  local M_Frag = plr.Data.Fragments.Value
        if plr:FindFirstChild("WeaponAssetCache") then
          if not GetBP("Superhuman") then                    
            if not GetBP("Black Leg") then
            if (M_Beli >= 150000) then replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg") end
            elseif GetBP("Black Leg") and GetBP("Black Leg").Level.Value < 299 then _G.Level = true elseif GetBP("Black Leg") and GetBP("Black Leg").Level.Value >= 300 then _G.Level = false end                        
            if not GetBP("Electro") then
            if (M_Beli >= 500000) then replicated.Remotes.CommF_:InvokeServer("BuyElectro") end
            elseif GetBP("Electro") and GetBP("Electro").Level.Value < 299 then _G.Level = true elseif GetBP("Electro") and GetBP("Electro").Level.Value >= 300 then _G.Level = false end                        
            if not GetBP("Fishman Karate") then
            if (M_Beli >= 750000) then replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate") end
            elseif GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value < 299 then _G.Level = true elseif GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value >= 300 then _G.Level = false end                        
            if not GetBP("Dragon Claw") then
            if (M_Frag >= 1500) then replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2") end
            elseif GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value < 299 then _G.Level = true elseif GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value >= 300 then _G.Level = false end
            replicated.Remotes.CommF_:InvokeServer("BuySuperhuman")          
          end
        end        
      end
    end)
  end
end)
DeathStep = Tabs.Quests:AddToggle({
Name = "Auto Get DeathStep", 
Description = "Tự Động Lấy Tử Cước", 
Default = false,
Callback = function(Value)
  _G.AutoDeathStep = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoDeathStep then
      pcall(function()
        if plr:FindFirstChild("WeaponAssetCache") then  
          if not GetBP("Death Step") then          
            if not GetBP("Black Leg") then replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg") end
            if GetBP("Black Leg") and GetBP("Black Leg").Level.Value >= 400 then replicated.Remotes.CommF_:InvokeServer("BuyDeathStep") _G.Level = false elseif GetBP("Black Leg") and GetBP("Black Leg").Level.Value < 399 then _G.Level = true end
            if GetBP("Black Leg") or GetBP("Black Leg").Level.Value >= 400 then
            if workspace.Map.IceCastle.Hall.LibraryDoor.PhoeyuDoor.Transparency == 0 then            
              if GetBP("Library Key") then repeat wait() _tp(CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375)) until not _G.AutoDeathStep or (Root.Position == CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375).Position)
		        if (Root.CFrame == CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375)) then replicated.Remotes.CommF_:InvokeServer("BuyDeathStep") end     
		        elseif not GetBP("Library Key") then
		          local v = GetConnectionEnemies("Awakened Ice Admiral")
		          if v then	repeat wait() Attack.Kill(v,_G.AutoDeathStep) until not v.Parent or v.Humanoid.Health <= 0 or _G.AutoDeathStep == false or GetBP("Library Key") or GetBP("Death Step")
	              else _tp(CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813))
	              end
		        end		    
              end
            end          
          end
        end
      end)
    end
  end
end)
SharkManV2 = Tabs.Quests:AddToggle({
Name = "Auto Get Sharkman Karate", 
Description = "Tự Động Lấy Karate Cá Mập", 
Default = false,
Callback = function(Value)
  _G.Auto_SharkMan_Karate = Value
end})
spawn(function() 
  while wait(Sec) do
    if _G.Auto_SharkMan_Karate then
      pcall(function()
        if plr:FindFirstChild("WeaponAssetCache") then  
          if not GetBP("Sharkman Karate") then          
            if not GetBP("Fishman Karate") then replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate") end
            if GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value >= 400 then replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate") _G.Level = false elseif GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value < 399 then _G.Level = true end
            if GetBP("Fishman Karate") or GetBP("Fishman Karate").Level.Value >= 400 then           
              if GetBP("Water Key") then
		        if string.find(replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate"), "keys") then  
			      if GetBP("Water Key") then
			        repeat wait() _tp(CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365)) until not _G.Auto_SharkMan_Karate or (Root.Position == CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365).Position)
	                replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
		          end
		        end
		      elseif not GetBP("Water Key") then
		        local v = GetConnectionEnemies("Tide Keeper")
		        if v then repeat wait() Attack.Kill(v,_G.Auto_SharkMan_Karate)until not v.Parent or v.Humanoid.Health <= 0 or _G.Auto_SharkMan_Karate == false or GetBP("Water Key") or GetBP("Sharkman Karate")		
	            else _tp(CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625))
	            end
		      end		                  
            end          
          end
        end
      end)
    end
  end
end)
ElectricClaw = Tabs.Quests:AddToggle({
Name = "Auto Get ElectricClaw", 
Description = "Tự Động Lấy Lôi Trảo", 
Default = false,
Callback = function(Value)
  _G.Auto_Electric_Claw = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.Auto_Electric_Claw then
      pcall(function()
        if plr:FindFirstChild("WeaponAssetCache") then 
        if not GetBP("Electro") then replicated.Remotes.CommF_:InvokeServer("BuyElectro") end        
          if GetBP("Electro") and GetBP("Electro").Level.Value >= 400 then
            if replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start") == nil then notween(CFrame.new(-12548, 337, -7481)) end
            replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw")
          elseif GetBP("Electro") and GetBP("Electro").Level.Value < 400 then
            repeat _G.AutoFarm_Bone = true wait() until not _G.Auto_Electric_Claw or GetBP("Electric Claw") _G.AutoFarm_Bone = false
          end
        end       
      end)
    end
  end
end)
DragonTalon = Tabs.Quests:AddToggle({
Name = "Auto Get DragonTalon", 
Description = "Tự Động Lấy Hoả Long Quyền", 
Default = false,
Callback = function(Value)
  _G.AutoDragonTalon = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoDragonTalon then
      pcall(function()
        if plr:FindFirstChild("WeaponAssetCache") then 
        if not GetBP("Dragon Claw") then replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2") end        
          if GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value >= 400 then replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1) replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon")
          elseif GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value < 400 then repeat _G.AutoFarm_Bone = true wait() until not _G.AutoDragonTalon or GetBP("Dragon Talon") _G.AutoFarm_Bone = false
          end         
        end
      end)
    end
  end
end)
Godhuman = Tabs.Quests:AddToggle({
Name = "Auto Get GodHuman", 
Description = "Tự Động Lấy Thần Diệt Quyền", 
Default = false,
Callback = function(Value)
  _G.Auto_God_Human = Value
end})
spawn(function()
  while wait() do
    pcall(function()
      if _G.Auto_God_Human then
        if replicated.Remotes.CommF_:InvokeServer("BuyGodhuman",true) == "Bring me 20 Fish Tails, 20 Magma Ore, 10 Dragon Scales and 10 Mystic Droplets." then
          if GetM("Dragon Scale") == false or GetM("Dragon Scale") < 10 then
            if World3 then
              Lv = 1575
              _G.Level = true
            else
              replicated.Remotes.CommF_:InvokeServer("TravelZou")
            end
          elseif GetM("Fish Tail") == false or GetM("Fish Tail") < 20 then
            if World3 then
              Lv = 1775
              _G.Level = true
            else
              replicated.Remotes.CommF_:InvokeServer("TravelZou")
            end
          elseif GetM("Mystic Droplet") == false or GetM("Mystic Droplet") < 10 then
            if World2 then
              Lv = 1425
              _G.Level = true
            else
              replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
            end
          elseif GetM("Magma Ore") == false or GetM("Magma Ore") < 20 then
            if World2 then
              Lv = 1175
              _G.Level = true
            else
              replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
            end  
          end
        elseif replicated.Remotes.CommF_:InvokeServer("BuyGodhuman",true) == 3 then
          return nil
        else
          replicated.Remotes.CommF_:InvokeServer("BuyGodhuman")
        end
      end
    end)
  end
end)
SanguineArt = Tabs.Quests:AddToggle({
Name = "Auto Get SanguineArt", 
Description = "Tự Động Lấy Huyết Quỷ Thuật", 
Default = false,
Callback = function(Value)
  _G.Snaguine = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.Snaguine then
      pcall(function()
        if not GetBP("Sanguine Art") then replicated.Remotes.CommF_:InvokeServer("Sanguine Art") end
        if not GetBP("Sanguine Art") then
          if GetM("Leviathan Heart") >= 1 then print("Completed!!")
          else
          if World3 then _G.DangerSc = "Lv Infinite" _G.SailBoats = true; else _G.SailBoats = false; end end
          if GetM("Vampire Fang") <= 19 then
            if World2 then
              local n = GetConnectionEnemies("Vampire")
              if n then repeat task.wait() Attack.Kill(n,_G.Snaguine) until not _G.Snaguine or n.Humanoid.Health <= 0 or not n.Parent
              else _tp(CFrame.new(-6041.29248046875, 6.402710914611816, -1304.63330078125))
              end
            else
              replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
            end
          end                                      
          if GetM("Vampire Fang") >= 20 and GetM("Demonic Wisp") <= 19 then
            if World3 then
              local n = GetConnectionEnemies("Demonic Soul")
		      if n then repeat task.wait() Attack.Kill(n,_G.Snaguine) until not _G.Snaguine or n.Humanoid.Health <= 0 or not n.Parent
              else _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 
              end
             else
               replicated.Remotes.CommF_:InvokeServer("TravelZou")
             end
           end
           if GetM("Vampire Fang") >= 20 and GetM("Demonic Wisp") >= 20 and GetM("Dark Fragment") <= 1 then
             if World2 then
               local n = GetConnectionEnemies("Darkbeard")
		       if n then repeat task.wait() Attack.Kill(black,_G.Snaguine) until _G.Snaguine or black.Humanoid.Health <= 0 or not black.Parent
		      else _tp(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625))
		      end
		    else replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
	        end
          end
        else replicated.Remotes.CommF_:InvokeServer("BuySanguineArt")
        end
      end)
    end
  end
end)

Tabs.Mirage:AddSection({"Mystic Island / Full Moon"})
FullMOOn = Tabs.Mirage:AddParagraph({
Title = " FullMoon Status ",
Content = ""})
Ismirage = Tabs.Mirage:AddParagraph({
Title = " Mirage Island Status ",
Content = ""})
spawn(function()
  while wait(.2) do
    if workspace.Map:FindFirstChild("MysticIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
      Ismirage:SetDesc(" Mirage Island : True")
    else
      Ismirage:SetDesc(" Mirage Island : False")
    end
  end
end)
spawn(function()
  while wait(.2) do
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
Q = Tabs.Mirage:AddToggle({
Name = "Auto Find Mirage Island", 
Description = "Tự Động Tìm Đảo Bí Ẩn", 
Default = false,
Callback = function(Value)
  _G.FindMirage = Value
end})
spawn(function()
  while wait() do
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
Q = Tabs.Mirage:AddToggle({
Name = "Tween To Mirage Island", 
Description = "Bay Đến Đảo Bí Ẩn", 
Default = false,
Callback = function(Value)
  _G.HighestMirage = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.HighestMirage then 
      pcall(function()
      if workspace["_WorldOrigin"].Locations:FindFirstChild("Mirage Island",true) then _tp(workspace.Map.MysticIsland.Center.CFrame*CFrame.new(0,400,0))end
      end)
    end
  end
end)
Q = Tabs.Mirage:AddToggle({
Name = "Auto Collect Gear", 
Description = "Tự Động Nhặt Bánh Răng", 
Default = false,
Callback = function(Value)
  _G.TPGEAR = Value
end})
spawn(function()
  pcall(function()
    while wait(0.1) do
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
Q = Tabs.Mirage:AddToggle({
Name = "Change Transparency Can See", 
Description = "Thay Đổi Tính Minh Bạch Có Thể Thấy", 
Default = false,
Callback = function(Value)
  _G.can = Value
end})
spawn(function()
  pcall(function()
    while wait(Sec) do
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
Q = Tabs.Mirage:AddToggle({
Name = "Auto Tween To Advanced Fruit Dealer", 
Description = "Tự Động Bay Đến Đại Lý Bán Trái", 
Default = false,
Callback = function(Value)
  _G.Addealer = Value
end})
spawn(function()
  while wait() do
    if _G.Addealer then
	  pcall(function()
	    for _,v in pairs(replicated.NPCs:GetChildren()) do
	    if v.Name == "Advanced Fruit Dealer" then _tp(v.HumanoidRootPart.CFrame) end
        end   	   
	 end)
    end
  end
end)
Q = Tabs.Mirage:AddToggle({
Name = "Auto Collect Mirage Chest", 
Description = "Tự Động Nhặt Rương Bí Ẩn", 
Default = false,
Callback = function(Value)
  _G.FarmChestM = Value
end})
spawn(function()
  while wait(.2) do
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

Tabs.Mirage:AddSection({"Skull Guitars / Misc"})
CheckSoul = Tabs.Mirage:AddParagraph({
Title = "Get Quest Soul Guitar",
Content = ""})
spawn(function()
  while wait(.2) do
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
Q = Tabs.Mirage:AddToggle({
Name = "Auto Get Skull Guitar", 
Description = "Tự Động Lấy Skull Guitar", 
Default = false,
Callback = function(Value)
  _G.Auto_Soul_Guitar = Value
end})
task.spawn(function()
  while wait() do
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
spawn(function()
  repeat task.wait() until _G.Auto_Soul_Guitar
  while wait(Sec) do
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
Q = Tabs.Mirage:AddToggle({
Name = "Auto Farm Materials Skull Guitar", 
Description = "Tự Động Cày Nguyên Liệu Lấy Skull Guitar", 
Default = false,
Callback = function(Value)
  _G.AutoMatSoul = Value
end})
spawn(function()
  while wait(Sec) do
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
Name = "Talk With Stone", 
Description = "Nói Chuyện Với Tảng Đá",
Callback = function()
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Begin")
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Check")
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Teleport")
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Continue")
end})
Q = Tabs.Mirage:AddToggle({
Name = "Auto Look At Moon", 
Description = "Tự Động Nhìn Trăng", 
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


Tabs.Race:AddSection({"Upgrade Races V3"})
RaceMink = Tabs.Race:AddToggle({
Name = "Auto Upgrade Mink V3", 
Description = "Tự Động Nâng Tộc Thỏ V3", 
Default = false,
Callback = function(Value)
  _G.Auto_Mink = Value
end})
spawn(function()
  while wait(Sec) do
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
RaceHuman = Tabs.Race:AddToggle({
Name = "Auto Upgrade Human V3", 
Description = "Tự Động Nâng Tộc Người V3", 
Default = false,
Callback = function(Value)
  _G.Auto_Human = Value
end})
spawn(function()
  while wait(Sec) do
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
RaceSky = Tabs.Race:AddToggle({
Name = "Auto Upgrade Angel V3", 
Description = "Tự Động Nâng Tộc Thiên Thần V3", 
Default = false,
Callback = function(Value)
  _G.Auto_Skypiea = Value
end})
spawn(function()
  while wait(Sec) do
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
RaceFish = Tabs.Race:AddToggle({
Name = "Auto Upgrade Fish V3", 
Description = "Tự Động Nâng Tộc Cá V3", 
Default = false,
Callback = function(Value)
  _G.Auto_Fish = Value
end})
spawn(function()
  while wait(Sec) do
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


Tabs.Race:AddSection({"Trials Quest V4"})
CheckTier = Tabs.Race:AddParagraph({
Title = "Tier V4",
Content = ""})
spawn(function()
  pcall(function()
    while wait(.2) do
      CheckTier:SetDesc(" Tiers - V4  :" .." "..plr.Data.Race.C.Value)
    end
  end)
end)
PullLv = Tabs.Race:AddToggle({
Name = "Auto Pull Lever", 
Description = "Tự Động Gạt Cần", 
Default = false,
Callback = function(Value)
  _G.Lver = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.Lver then
      pcall(function()
        for x,c in pairs(workspace.Map["Temple of Time"]:GetDescendants()) do
        if c.Name == "ProximityPrompt" then fireproximityprompt(c,math.huge)end
        end
      end)
    end
  end
end)
Train = Tabs.Race:AddToggle({
Name = "Auto Train V4", 
Description = "Tự Động Train V4", 
Default = false,
Callback = function(Value)
  _G.AcientOne = Value
end})
spawn(function()
  while wait(Sec) do
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
Name = "Teleport To Temple of Time", 
Description = "Dịch Chuyển Đến Đền Thời Gian",
Callback = function()
  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12538.421875,340.893585,-7817.070801))
end})
Tabs.Race:AddButton({
Name = "Teleport To Ancient One", 
Description = "Dịch Chuyển Đến Ancient One",
Callback = function()
  notween(CFrame.new(28981.552734375, 14888.4267578125, - 120.245849609375))
end})
Tabs.Race:AddButton({
Name = "Teleport To Ancient Clock", 
Description = "Dịch Chuyển Đến Ancient Clock",
Callback = function()
  notween(CFrame.new(29549, 15069, -88))
end})
Doors = Tabs.Race:AddToggle({
Name = "Auto Teleport To Race Doors", 
Description = "Dịch Chuyển Đến Race Doors", 
Default = false,
Callback = function(Value)
  _G.TPDoor = Value
end})
spawn(function()
  while wait(Sec) do
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
Trials = Tabs.Race:AddToggle({
Name = "Auto Complete Trial Race", 
Description = "Tự Động Hoàn Thành Trial", 
Default = false,
Callback = function(Value)
  _G.Complete_Trials = Value
end})
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
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Complete_Trials then
        if tostring(plr.Data.Race.Value) == "Mink" then
          notween(workspace.Map.MinkTrial.Ceiling.CFrame * CFrame.new(0,-20,0))
	   end
      end
    end)
  end
end)
spawn(function()
  while wait(Sec) do
    pcall(function() 
      if _G.Complete_Trials then
	    if tostring(plr.Data.Race.Value) == "Fishman" then
	      if GetSeaBeastTrial() then            
            repeat task.wait()
              spawn(function()_tp(CFrame.new(GetSeaBeastTrial().HumanoidRootPart.Position.X,game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 300,GetSeaBeastTrial().HumanoidRootPart.Position.Z))end)
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
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Complete_Trials then
        if tostring(plr.Data.Race.Value) == "Cyborg" then
         _tp(workspace.Map.CyborgTrial.Floor.CFrame * CFrame.new(0,500,0))
   	   end
      end
    end)
  end
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Complete_Trials then
        if tostring(plr.Data.Race.Value) == "Skypiea" then
          notween(workspace.Map.SkyTrial.Model.FinishPart.CFrame)
  	   end
      end
    end)
  end
end)
spawn(function()
  while wait(.1) do   
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
AutoKill = Tabs.Race:AddToggle({
Name = "Auto Kill Player After Trial", 
Description = "Tự Động Giết Các Người Chơi Khác Sau Trial", 
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

Tabs.Drago:AddSection({"Dojo Quest & Drago Race"})
DojoQ = Tabs.Drago:AddToggle({
Name = "Auto Dojo Trainer", 
Description = "Tự Động Lấy Đai", 
Default = false,
Callback = function(Value)
  _G.Dojoo = Value
end})
function printBeltName(data) if type(data) == "table" and data.Quest["BeltName"] then return data.Quest["BeltName"] end end
spawn(function()
  while wait(Sec) do
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
BlazeEM = Tabs.Drago:AddToggle({
Name = "Auto Dragon Hunter", 
Description = "Tự Động Dragon Hunter", 
Default = false,
Callback = function(Value)
  _G.FarmBlazeEM = Value
end})
checkQuesta=function()local a={[1]={["Context"]="Check"}}local b=nil;pcall(function()local c={[1]={["Context"]="RequestQuest"}}game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack(c))end)local d,e=pcall(function()b=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack(a))end)local f=false;local g;local h;local i;if b then if b.Text then f=true;local j=b.Text;if string.find(tostring(j),"Defeat")then i=1;g=string.sub(tostring(j),8,9)g=tonumber(g)local k={"Hydra Enforcer","Venomous Assailant"}for l,m in pairs(k)do if string.find(j,m)then h=m;break end end elseif string.find(tostring(j),"Destroy")then g=10;i=2;h=nil end end end;return f,h,g,i end
BackTODoJo=function()for a,b in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren())do if b.Name=="NotificationTemplate"then if string.find(b.Text,"Head back to the Dojo to complete more tasks")then return true end end end;return false end
DragonMobClear=function(a,b,c)if workspace.Enemies:FindFirstChild(b)then for d,e in pairs(workspace.Enemies:GetChildren())do if e.Name==b and Attack.Alive(e)then if a then Attack.Kill(e,a)end end end else _tp(c)end end
spawn(function()
  while wait() do 
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
                spawn(function() _tp(workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).CFrame * CFrame.new(4,0,0)) end)
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
spawn(function()
  while wait(.1) do 
    if _G.FarmBlazeEM then
      pcall(function()              
        if workspace.EmberTemplate:FindFirstChild("Part") then
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.EmberTemplate.Part.CFrame        
        end
      end)
    end
  end
end)

Tabs.Drago:AddSection({"Drago Trial"})
GetQuestDracoLevel = function()
  local v371 = {[1] = {NPC = "Dragon Wizard",Command = "Upgrade"}};
  return replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(v371))
end
Toggle = Tabs.Drago:AddToggle({
Name = "Tween To Upgrade Draco Trial", 
Description = "Bay Đến Trial Nâng Cấp Draco", 
Default = false,
Callback = function(Value)
  _G.UPGDrago = Value
end})
spawn(function()
  while wait(Sec) do
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
Toggle = Tabs.Drago:AddToggle({
Name = "Auto Draco V1", 
Description = "Tự Động Lấy Tộc Draco V1", 
Default = false,
Callback = function(Value)
  _G.DragoV1 = Value
end})
spawn(function()
  while wait(Sec) do
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
fireflower = Tabs.Drago:AddToggle({
Name = "Auto Draco V2", 
Description = "Tự Động Lấy Tộc Draco V2", 
Default = false,
Callback = function(Value)
  _G.AutoFireFlowers = Value
end})
spawn(function()
  while wait(Sec) do
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
Toggle = Tabs.Drago:AddToggle({
Name = "Auto Draco V3", 
Description = "Tự Động Lấy Tộc Draco V", 
Default = false,
Callback = function(Value)
  _G.DragoV3 = Value
end})
spawn(function()
  while wait(Sec) do
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
Toggle = Tabs.Drago:AddToggle({
Name = "Auto Relic Draco Trial V4", 
Description = "Tự Động Thắp Đèn Trial Draco V4", 
Default = false,
Callback = function(Value)
  _G.Relic123 = Value
end})
spawn(function()
  while wait(Sec) do
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
Toggle = Tabs.Drago:AddToggle({
Name = "Auto Train Draco v4", 
Description = "Tự Động Train Draco V4", 
Default = false,
Callback = function(Value)
  _G.TrainDrago = Value
end})
spawn(function()
  while wait(Sec) do
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
dragoTpVolcano = Tabs.Drago:AddToggle({
Name = "Tween To Draco Trial V4", 
Description = "Bay Đến Nơi Trial Draco V4", 
Default = false,
Callback = function(Value)
  _G.TpDrago_Prehis = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.TpDrago_Prehis then
      local v748 = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport");
      if (v748 and v748:IsA("Part")) then _tp(CFrame.new(v748.Position)) end
    end
  end
end)
bdrago = Tabs.Drago:AddToggle({
Name = "Swap Draco Race", 
Description = "Chuyển Đổi Tộc Draco", 
Default = false,
Callback = function(Value)
  _G.BuyDrago = Value
end})
spawn(function()
  while wait(Sec) do
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
UpTalon = Tabs.Drago:AddToggle({
Name = "Upgrade Dragon Talon V3", 
Description = "Nâng Cấp Dragon Talon V3", 
Default = false,
Callback = function(Value)
  _G.DT_Uzoth = Value
end})
spawn(function()
  while wait(Sec) do
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

Tabs.Prehistoric:AddSection({"Volcanic Magnet"})

Toggle = Tabs.Prehistoric:AddToggle({
    Name = "Auto Craft Volcanic Magnet",
    Description = "Tự Động Chế Tạo Volcanic Magnet",
    Default = false,
    Callback = function(Value)
    _G.CraftVM = Value
end})

Tabs.Prehistoric:AddButton({
    Name = "Craft Volcanic Magnet",
    Description = "Chế Tạo Volcanic Magnet",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
    end
})


local function AutoCraftVolcanicMagnet()
    replicated.Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
    task.wait(1.5) 
end


spawn(function()
    while task.wait(2) do
        pcall(function()
            if _G.CraftVM then
                AutoCraftVolcanicMagnet()
            end
        end)
    end
end)
Tabs.Prehistoric:AddSection({"Prehistoric Island"})
Check_Volcano = Tabs.Prehistoric:AddParagraph({
Title = " Prehistoric Island Status",
Content = ""})
spawn(function()
  while wait(.2) do
    if workspace.Map:FindFirstChild("PrehistoricIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
      Check_Volcano:SetDesc(" Prehistoric Island : True")
    else
      Check_Volcano:SetDesc(" Prehistoric Island : False")
    end
  end
end)
Vocan = Tabs.Prehistoric:AddToggle({
Name = "Auto Find Prehistoric Island", 
Description = "Tự Động Tìm Đảo Núi Lửa", 
Default = false,
Callback = function(Value)
  _G.Prehis_Find = Value
end
})
local targetDestination = nil
spawn(function()
  while wait() do
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
Patch = Tabs.Prehistoric:AddToggle({
Name = "Auto Start Event", 
Description = "Tự Động Bắt Đầu Sự Kiện", 
Default = false,
Callback = function(Value)
  _G.Prehis_Skills = Value
end
})
spawn(function()
  while wait() do
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
spawn(function()
  while wait() do
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
Kaura = Tabs.Prehistoric:AddToggle({
    Name = "Kill Aura",
    Description = "Giết Hào Quang",
    Default = false,
    Callback = function(Value)
    _G.KillAuraFull = Value
end})

local Range = 500
local Delay = 2   

spawn(function()
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
Vocan = Tabs.Prehistoric:AddToggle({
Name = "Auto Collect Bones", 
Description = "Tự Động Nhặt Xương", 
Default = false,
Callback = function(Value)
  _G.Prehis_DB = Value
end})
spawn(function()
  while wait(Sec) do
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
Vocan = Tabs.Prehistoric:AddToggle({
Name = "Auto Collect Dragon Egg", 
Description = "Tự Động Nhặt Trứng Rồng", 
Default = false,
Callback = function(Value)
  _G.Prehis_DE = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Prehis_DE then
      if workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg") then _tp(workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg").Molten.CFrame) fireproximityprompt(workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs.DragonEgg.Molten.ProximityPrompt, 30) end        
      end
    end)
  end
end)
Toggle = Tabs.Prehistoric:AddToggle({
Name = "Auto Reset When Complete", 
Description = "Tự Động Đặt Lại Khi Hoàn Thành", 
Default = false,
Callback = function(Value)
  _G.ResetPH = Value
end})
spawn(function()
  while wait(Sec) do
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

Tabs.SeaEvent:AddSection({"Sea Event / Setting Sail"})
local ListSeaBoat={"Guardian","PirateGrandBrigade","MarineGrandBrigade","PirateBrigade","MarineBrigade","PirateSloop","MarineSloop","Beast Hunter"}
local ListSeaZone={"Lv 1","Lv 2","Lv 3","Lv 4","Lv 5","Lv 6","Lv Infinite"}
SPYING = Tabs.SeaEvent:AddParagraph({
Title = " Spy Status",
Content = ""})
spawn(function()
  while wait(.2) do
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
Name = "Buy Spy", 
Description = "Mua Spy",
Callback = function()
  replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("InfoLeviathan","2")
end})
FloD = Tabs.SeaEvent:AddParagraph({
Title = " Frozen Dimension status",
Content = ""})
spawn(function()
  pcall(function()
    while wait(.2) do
      if workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') then
        FloD:SetDesc(' Flozen Dimension : True')
      else
        FloD:SetDesc(' Flozen Dimension : False')
      end
    end
  end)
end)
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Teleport Frozen Dimension", 
Description = "Tự Động Dịch Chuyển Đến Frozen Dimension",  
Default = false,
Callback = function(Value)
  _G.FrozenTP = Value
end})
spawn(function()
  while wait(.1) do
    if _G.FrozenTP then
      pcall(function()
      if workspace.Map:FindFirstChild("LeviathanGate") then _tp(workspace.Map.LeviathanGate.CFrame) replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("OpenLeviathanGate") end
      end)
    end
  end
end)
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Drive To Hydra Island", 
Description = "Tự Động Lái Đến Đảo Phụ Nữ",  
Default = false,
Callback = function(Value)
  _G.SailBoat_Hydra = Value
end})
spawn(function()
  while wait() do
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
Q = Tabs.SeaEvent:AddDropdown({
    Name = "Choose Boat",
	Options = ListSeaBoat,
	Default = false,
	Callback = function(Value)
        _G.SelectedBoat = Value
    end
})
Tabs.SeaEvent:AddButton({
Name = "Buy Boat", 
Description = "Mua Thuyền",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyBoat",_G.SelectedBoat)
end})
Q = Tabs.SeaEvent:AddDropdown({
Name = "Choose Sea Level",
Options = ListSeaZone,
Default = false,
Callback = function(Value)
  _G.DangerSc = Value
end})
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Sail [Sit Down And Turn On]", 
Description = "Tự Động Lái [Ngồi Vào Chỗ Rồi Bật]", 
Default = false,
Callback = function(Value)
  _G.SailBoats = Value
end})
spawn(function()
  while wait() do
    if _G.SailBoats then 
      pcall(function()        
        local myBoat = CheckBoat()
        if not myBoat and not(CheckShark()and _G.Shark or CheckTerrorShark()and _G.TerrorShark or CheckFishCrew()and _G.MobCrew or CheckPiranha()and _G.Piranha)and not(CheckEnemiesBoat()and _G.FishBoat)and not(CheckSeaBeast()and _G.SeaBeast1)and not(_G.PGB and CheckPirateGrandBrigade())and not(_G.HCM and CheckHauntedCrew())and not(_G.Leviathan1 and CheckLeviathan())then
          local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
          TeleportToTarget(buyBoatCFrame)
          if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) end
        elseif myBoat and not(CheckShark()and _G.Shark or CheckTerrorShark()and _G.TerrorShark or CheckFishCrew()and _G.MobCrew or CheckPiranha()and _G.Piranha)and not(CheckEnemiesBoat()and _G.FishBoat)and not(CheckSeaBeast()and _G.SeaBeast1)and not(_G.PGB and CheckPirateGrandBrigade())and not(_G.HCM and CheckHauntedCrew())and not(_G.Leviathan1 and CheckLeviathan())then
          if plr.Character.Humanoid.Sit == false then
            local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
            _tp(boatSeatCFrame)
          else                         
            if _G.DangerSc == "Lv 1" then CFrameSelectedZone = CFrame.new(-21998.375, 30.0006084, -682.309143)
            elseif _G.DangerSc == "Lv 2" then CFrameSelectedZone = CFrame.new(-26779.5215, 30.0005474, -822.858032)
            elseif _G.DangerSc == "Lv 3" then CFrameSelectedZone = CFrame.new(-31171.957, 30.0001011, -2256.93774)
            elseif _G.DangerSc == "Lv 4" then CFrameSelectedZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012)
            elseif _G.DangerSc == "Lv 5" then CFrameSelectedZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023)
            elseif _G.DangerSc == "Lv 6" then CFrameSelectedZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584)
            elseif _G.DangerSc == "Lv Infinite" then CFrameSelectedZone = CFrame.new(-10000000, 31, 37016.25)
            end           
            repeat wait() 
              if (not _G.FishBoat and CheckEnemiesBoat()) or (not _G.PGB and CheckPirateGrandBrigade()) or (not _G.TerrorShark and CheckTerrorShark()) then
                _tp(CFrameSelectedZone * CFrame.new(0,150,0))
              else
                _tp(CFrameSelectedZone)
              end           
            until _G.SailBoats==false or(CheckShark()and _G.Shark or CheckTerrorShark()and _G.TerrorShark or CheckFishCrew()and _G.MobCrew or CheckPiranha()and _G.Piranha)or CheckSeaBeast()and _G.SeaBeast1 or CheckEnemiesBoat()and _G.FishBoat or _G.Leviathan1 and CheckLeviathan() or _G.HCM and CheckHauntedCrew() or _G.PGB and CheckPirateGrandBrigade() or plr.Character:WaitForChild("Humanoid").Sit==false plr.Character.Humanoid.Sit = false
          end
        end
      end)
    end
  end
end)
spawn(function()while wait(Sec)do pcall(function()for a,b in pairs(workspace.Boats:GetChildren())do for c,d in pairs(workspace.Boats[b.Name]:GetDescendants())do if d:IsA("BasePart")then if _G.SailBoats or _G.Prehis_Find or _G.FindMirage or _G.SailBoat_Hydra or _G.AutofindKitIs then d.CanCollide=false else d.CanCollide=true end end end end end)end end)

Tabs.SeaEvent:AddSection({"Entity Sea Event"})

Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Kill Shark", 
Description = "Tự Động Giết Cá Mập", 
Default = false,
Callback = function(Value)
  _G.Shark = Value
end})
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Kill Piranha", 
Description = "Tự Động Giết Cá Piranha", 
Default = false,
Callback = function(Value)
  _G.Piranha = Value
end})
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Kill Terror Shark", 
Description = "Tự Động Giết Cá Mập Tận Thế", 
Default = false,
Callback = function(Value)
  _G.TerrorShark = Value
end})
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Attack Fish Crew Member", 
Description = "Tự Động Đánh Thành Viên Đội Đánh Cá", 
Default = false,
Callback = function(Value)
  _G.MobCrew = Value
end})
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Attack Haunted Crew Member", 
Description = "Tự Động Đánh Thành Viên Ohi Hành Đoàn Bị Ám", 
Default = false,
Callback = function(Value)
  _G.HCM = Value
end})
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Attack Pirate Ship", 
Description = "Tự Động Đánh Tàu Hải Tặc", 
Default = false,
Callback = function(Value)
  _G.PGB = Value
end})
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Attack Fish Boat", 
Description = "Tự Động Đánh Tàu Bắt Cá", 
Default = false,
Callback = function(Value)
  _G.FishBoat = Value
end})
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Attack Sea Beast", 
Description = "Tự Động Đánh Sea Beast", 
Default = false,
Callback = function(Value)
  _G.SeaBeast1 = Value
end})
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Attack Leviathan", 
Description = "Tự Động Đánh Leviathan", 
Default = false,
Callback = function(Value)
  _G.Leviathan1 = Value
end})
spawn(function()
  while wait() do
    pcall(function()	
      if _G.Shark then local a={"Shark"}if CheckShark()then for b,c in pairs(workspace.Enemies:GetChildren())do if table.find(a,c.Name)then if Attack.Alive(c)then repeat task.wait()Attack.Kill(c,_G.Shark)until _G.Shark==false or not c.Parent or c.Humanoid.Health<=0 end end end end end
      if _G.TerrorShark then local a={"Terrorshark"}if CheckTerrorShark()then for b,c in pairs(workspace.Enemies:GetChildren())do if table.find(a,c.Name)then if Attack.Alive(c)then repeat task.wait()Attack.KillSea(c,_G.TerrorShark)until _G.TerrorShark==false or not c.Parent or c.Humanoid.Health<=0 end end end end end
      if _G.Piranha then local a={"Piranha"}if CheckPiranha()then for b,c in pairs(workspace.Enemies:GetChildren())do if table.find(a,c.Name)then if Attack.Alive(c)then repeat task.wait()Attack.Kill(c,_G.Piranha)until _G.Piranha==false or not c.Parent or c.Humanoid.Health<=0 end end end end end
      if _G.MobCrew then local a={"Fish Crew Member"}if CheckFishCrew()then for b,c in pairs(workspace.Enemies:GetChildren())do if table.find(a,c.Name)then if Attack.Alive(c)then repeat task.wait()Attack.Kill(c,_G.MobCrew)until _G.MobCrew==false or not c.Parent or c.Humanoid.Health<=0 end end end end end                 
      if _G.HCM then local a={"Haunted Crew Member"}if CheckHauntedCrew()then for b,c in pairs(workspace.Enemies:GetChildren())do if table.find(a,c.Name)then if Attack.Alive(c)then repeat task.wait()Attack.Kill(c,_G.HCM)until _G.HCM==false or not c.Parent or c.Humanoid.Health<=0 end end end end end
      if _G.SeaBeast1 then if workspace.SeaBeasts:FindFirstChild("SeaBeast1")then for a,b in pairs(workspace.SeaBeasts:GetChildren())do if b:FindFirstChild("HumanoidRootPart")and b:FindFirstChild("Health")and b.Health.Value>0 then repeat task.wait()spawn(function()_tp(CFrame.new(b.HumanoidRootPart.Position.X,game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y+200,b.HumanoidRootPart.Position.Z))end)if plr:DistanceFromCharacter(b.HumanoidRootPart.CFrame.Position)<=500 then AitSeaSkill_Custom=b.HumanoidRootPart.CFrame;MousePos=AitSeaSkill_Custom.Position;if CheckF()then weaponSc("Blox Fruit")Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")else Useskills("Melee","Z")Useskills("Melee","X")Useskills("Melee","C")wait(.1)Useskills("Sword","Z")Useskills("Sword","X")wait(.1)Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")wait(.1)Useskills("Gun","Z")Useskills("Gun","X")end end until _G.SeaBeast1==false or not b:FindFirstChild("HumanoidRootPart")or not b.Parent or b.Health.Value<=0 end end end end
      if _G.Leviathan1 then if workspace.SeaBeasts:FindFirstChild("Leviathan")then for a,b in pairs(workspace.SeaBeasts:GetChildren())do if b:FindFirstChild("HumanoidRootPart")and b:FindFirstChild("Leviathan Segment")and b:FindFirstChild("Health")and b.Health.Value>0 then repeat task.wait()spawn(function()_tp(CFrame.new(b.HumanoidRootPart.Position.X,game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y+200,b.HumanoidRootPart.Position.Z))end)if plr:DistanceFromCharacter(b.HumanoidRootPart.CFrame.Position)<=500 then MousePos=b:FindFirstChild("Leviathan Segment").Position;if CheckF()then weaponSc("Blox Fruit")Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")else Useskills("Melee","Z")Useskills("Melee","X")Useskills("Melee","C")wait(.1)Useskills("Sword","Z")Useskills("Sword","X")wait(.1)Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")wait(.1)Useskills("Gun","Z")Useskills("Gun","X")end end until _G.Leviathan1==false or not b:FindFirstChild("HumanoidRootPart")or not b.Parent or b.Health.Value<=0 end end end end
      if _G.FishBoat then if CheckEnemiesBoat()then for a,b in pairs(workspace.Enemies:GetChildren())do if b:FindFirstChild("Health")and b.Health.Value>0 and b:FindFirstChild("VehicleSeat")then repeat task.wait()spawn(function()if b.Name=="FishBoat"then _tp(b.Engine.CFrame*CFrame.new(0,-50,-25))end end)if plr:DistanceFromCharacter(b.Engine.CFrame.Position)<=150 then AitSeaSkill_Custom=b.Engine.CFrame;MousePos=AitSeaSkill_Custom.Position;if CheckF()then weaponSc("Blox Fruit")Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")else Useskills("Melee","Z")Useskills("Melee","X")Useskills("Melee","C")wait(.1)Useskills("Sword","Z")Useskills("Sword","X")wait(.1)Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")wait(.1)Useskills("Gun","Z")Useskills("Gun","X")end end until _G.FishBoat==false or not b:FindFirstChild("VehicleSeat")or b.Health.Value<=0 end end end end
      if _G.PGB then if CheckPirateGrandBrigade()then for a,b in pairs(workspace.Enemies:GetChildren())do if b:FindFirstChild("Health")and b.Health.Value>0 and b:FindFirstChild("VehicleSeat")then repeat task.wait()spawn(function()if b.Name=="PirateBrigade"then _tp(b.Engine.CFrame*CFrame.new(0,-30,-10))elseif b.Name=="PirateGrandBrigade"then _tp(b.Engine.CFrame*CFrame.new(0,-50,-50))end end)if plr:DistanceFromCharacter(b.Engine.CFrame.Position)<=150 then AitSeaSkill_Custom=b.Engine.CFrame;MousePos=AitSeaSkill_Custom.Position;if CheckF()then weaponSc("Blox Fruit")Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")else Useskills("Melee","Z")Useskills("Melee","X")Useskills("Melee","C")wait(.1)Useskills("Sword","Z")Useskills("Sword","X")wait(.1)Useskills("Blox Fruit","Z")Useskills("Blox Fruit","X")Useskills("Blox Fruit","C")wait(.1)Useskills("Gun","Z")Useskills("Gun","X")end end until _G.PGB==false or not b:FindFirstChild("VehicleSeat")or b.Health.Value<=0 end end end end
    end)
  end
end)

Tabs.SeaEvent:AddSection({"Kitsune Island / Event"})
Check_Kitsu = Tabs.SeaEvent:AddParagraph({
Title = " Kitsune Island Status",
Content = ""})
spawn(function()
  while wait(.2) do
    if workspace.Map:FindFirstChild("KitsuneIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
      Check_Kitsu:SetDesc(" Kitsune Island : True")
    else
      Check_Kitsu:SetDesc(" Kitsune Island : False")
    end
  end
end)
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Find Kitsune Island", 
Description = "Tự Động Tìm Đảo Cáo", 
Default = false,
Callback = function(Value)
  _G.AutofindKitIs = Value
end})
spawn(function()
  while wait() do
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
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Shrine Actived", 
Description = "Tự Động Kích Hoạt", 
Default = false,
Callback = function(Value)
  _G.tweenShrine = Value
end})
spawn(function()
  while wait(.1) do
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
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Collect Azure Ember", 
Description = "Tự Động Nhặt Azure Ember", 
Default = false,
Callback = function(Value)
  _G.Collect_Ember = Value
end})
spawn(function()
  while wait(.1) do
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
Q = Tabs.SeaEvent:AddToggle({
Name = "Auto Trade Azure Ember", 
Description = "Tự Động Đổi Azure Ember", 
Default = false,
Callback = function(Value)
  _G.Trade_Ember = Value
end})
spawn(function()
  while wait(.1) do
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
Name = "Trade Item Azure", 
Description = "Đổi Vật Phẩm Azure",
Callback = function()
  replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
end})
Tabs.SeaEvent:AddButton({
Name = "Talk With Kitsune Statue", 
Description = "Nói Chuyện Với Tượng Cáo",
Callback = function()
  replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
end})

Tabs.Raids:AddSection({"Fruits Options"})

RandomFF = Tabs.Raids:AddToggle({
Name = "Auto Random Fruit", 
Description = "Tự Động Quay Trái", 
Default = false,
Callback = function(Value)
  _G.Random_Auto = Value
end})
spawn(function()
  while wait(Sec) do
   	pcall(function()
      if _G.Random_Auto then replicated.Remotes.CommF_:InvokeServer("Cousin","Buy") end 
    end)
  end
end)
DropF = Tabs.Raids:AddToggle({
Name = "Auto Drop Fruit", 
Description = "Tự Động Thả Trái", 
Default = false,
Callback = function(Value)
  _G.DropFruit = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.DropFruit then
      pcall(function() DropFruits() end)
    end
  end
end)
StoredF = Tabs.Raids:AddToggle({
Name = "Auto Store Fruit", 
Description = "Tự Động Lưu Trữ Trái", 
Default = false,
Callback = function(Value)
  _G.StoreF = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.StoreF then
      pcall(function() UpdStFruit() end)
    end
  end
end)
TwF = Tabs.Raids:AddToggle({
Name = "Auto Tween To Fruit", 
Description = "Tự Động Bay Đến Trái", 
Default = false,
Callback = function(Value)
  _G.TwFruits = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.TwFruits then
      pcall(function()
        for _,x1 in pairs(workspace:GetChildren()) do
	    if string.find(x1.Name, "Fruit") then _tp(x1.Handle.CFrame) end
	    end
      end)
    end
  end
end)
BringF = Tabs.Raids:AddToggle({
Name = "Auto Collect Fruit", 
Description = "Tự Động Nhặt Trái", 
Default = false,
Callback = function(Value)
  _G.InstanceF = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.InstanceF then
      pcall(function() collectFruits(_G.InstanceF) end)
    end
  end
end)

Tabs.Raids:AddSection({"Dungeon Event / Raiding"})
RaidS = Tabs.Raids:AddParagraph({
Title = " Raiding Status",
Content = ""})
spawn(function()
  while wait(.2) do
    pcall(function()      
      if plr.PlayerGui.Main.Timer.Visible == true then
        RaidS:SetDesc(" Raiding Status: True")
      else
        RaidS:SetDesc(" Raiding Status: False")
      end      
    end)
  end
end)
DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
Q = Tabs.Raids:AddDropdown({
Name = "Select Chip",
Description = "",
Options = DungeonTables,
Default = false,
Callback = function(Value)
  _G.SelectChip = Value
end})
Q = Tabs.Raids:AddToggle({
Name = "Auto Choose Dungeon Chip", 
Description = "Tự Động Chọn Chip Dungeon", 
Default = false,
Callback = function(Value)
  _G.AutoSelectDungeon = Value
end})
spawn(function()
  while wait(Sec) do
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
Name = "Buy Raid Chips [Beli]", 
Description = "Mua Chip Raid [Bằng Tiền Beli]",
Callback = function()
  if not GetBP("Special Microchip") then replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip) end
end})
Tabs.Raids:AddButton({
Name = "Buy Microchip Law", 
Description = "Mua Microchip Law",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","2")
end})
Tabs.Raids:AddButton({
Name = "Buy Dungeon Chips [Devil Fruit]", 
Description = "Mua Chip Dungeon [Bằng Trái Ác Quỷ]",
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

Tabs.Raids:AddSection({"Raiding Menu"})
Q = Tabs.Raids:AddToggle({
Name = "Auto Start Raid", 
Description = "Tự Động Bắt Đầu Raid", 
Default = false,
Callback = function(Value)
  _G.Auto_StartRaid = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_StartRaid then
        if plr.PlayerGui.Main.TopHUDList.RaidTimer.Visible == false then
          if GetBP("Special Microchip") then
            if World2 then
              _tp(CFrame.new(-6438.73535, 250.645355, -4501.50684))
              fireclickdetector(workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
            elseif World3 then                   
              replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
              fireclickdetector(workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
            end
          end
        end
      end
    end)
  end
end)    

Raiding = Tabs.Raids:AddToggle({
    Name = "Auto Raid [Safe]",
    Description = "Tự Động Raid [An Toàn]",
    Default = false,
    Callback = function(Value)
        _G.Raiding = Value
        if Value then
            StartRaid()
        else
            StopRaid()
        end
    end
})

Q = Tabs.Raids:AddToggle({
Name = "Auto Awakening", 
Description = "Tự Động Thức Tỉnh", 
Default = false,
Callback = function(Value)
  _G.Auto_Awakener = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_Awakener then
        replicated.Remotes.CommF_:InvokeServer("Awakener","Check")
        replicated.Remotes.CommF_:InvokeServer("Awakener","Awaken")
      end
    end)
  end
end)

Tabs.Raids:AddToggle({
Name = "Start Law Raids", 
Description = "Bắt Đầu Raid Law",
Default = false,
Callback = function()
  fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
end})	

Tabs.Travel:AddSection({"Travel - Worlds"})

Tabs.Travel:AddButton({
Name = "Teleport To Sea 1", 
Description = "Dịch Chuyển Đến Sea 1",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelMain")
end})
Tabs.Travel:AddButton({
Name = "Teleport To Sea 2", 
Description = "Dịch Chuyển Đến Sea 2",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
end})
Tabs.Travel:AddButton({
Name = "Teleport To Sea 3", 
Description = "Dịch Chuyển Đến Sea 3",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("TravelZou")
end})

Tabs.Travel:AddSection({"Travel - Island"})
Location = {}
for i,v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do  
  table.insert(Location ,v.Name)
end
Travelllll = Tabs.Travel:AddDropdown({
Name = "Select Travelling",
Description = "",
Options = Location,
Default = false,
Callback = function(Value)
  _G.Island = Value
end})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Biến Global
_G.Teleport = false
_G.Island = _G.Island or ""
_G.PlayersList = nil
_G.TpPly = false
_G.TargetPlayerAim = nil

-- Hàm lấy danh sách người chơi
local function GetPlayersList()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then 
            table.insert(list, p.Name) 
        end
    end
    return list
end

-- 1. Toggle Auto Travel
Tabs.Travel:AddToggle({
    Name = "Auto Travel", 
    Description = "Tự Động Du Lịch Đến", 
    Default = false,
    Callback = function(Value)
        _G.Teleport = Value
        if Value then
            task.spawn(function()
                while _G.Teleport do
                    pcall(function()
                        local locations = workspace:FindFirstChild("_WorldOrigin") and workspace["_WorldOrigin"]:FindFirstChild("Locations")
                        if locations then
                            local targetIsland = locations:FindFirstChild(_G.Island)
                            if targetIsland then
                                _tp(targetIsland.CFrame * CFrame.new(0, 30, 0))
                            end
                        end
                    end)
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Travel:AddSection({"Teleport - Player"})
-- 2. Dropdown Chọn Người Chơi
Tabs.Travel:AddDropdown({
    Name = "Choose Player",
    Options = GetPlayersList(),
    Default = nil,
    Callback = function(Value)
        _G.PlayersList = Value
        -- Cập nhật target ngay lập tức khi chọn
        local p = Players:FindFirstChild(Value)
        if p then
            _G.TargetPlayerAim = p
        end
    end
})

-- 3. Toggle Teleport To Player (Bản đã sửa lỗi đóng ngoặc)
Tabs.Travel:AddToggle({
    Name = "Teleport To Player",
    Description = "Dịch Chuyển Đến Người Chơi",
    Default = false,
    Callback = function(Value)
        _G.TpPly = Value
        if Value then
            task.spawn(function()
                while _G.TpPly do
                    pcall(function()
                        local target = game:GetService("Players"):FindFirstChild(_G.PlayersList)
                        if target and target.Character then
                            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
                            local myHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            
                            if targetHRP and myHRP then
                                -- Đứng sau lưng 3 studs
                                myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 7)
                            end
                        end
                    end)
                    task.wait()
                end
            end)
        end
    end 
})


Tabs.Shop:AddSection({"Shop Options"})
Tabs.Shop:AddButton({
Name = "Buy Buso", 
Description = "Mua Haki Tay",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Buso")
end})
Tabs.Shop:AddButton({
Name = "Buy Geppo", 
Description = "Mua Nhảy Liên Tục",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
end})
Tabs.Shop:AddButton({
Name = "Buy Soru", 
Description = "Mua Dịch Chuyển Tức Thời",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyHaki","Soru")
end})
Tabs.Shop:AddButton({
Name = "Buy Ken", 
Description = "Mua Haki Quan Sát",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("KenTalk","Buy")
end})
Tabs.Shop:AddSection({"Fighting - Style"})

local lp = game:GetService("Players").LocalPlayer
local replicated = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
local World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
local World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

_G.BuyingMelee = false 

-- 1. HÀM ESP "CƯỠNG ÉP" (Dùng vòng lặp nhanh hơn để không bị đè)
task.spawn(function()
    while task.wait(0.1) do -- Quét liên tục mỗi 0.1 giây[span_2](start_span)[span_2](end_span)
        pcall(function()
            local char = lp.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                -- Nếu đang mua Melee HOẶC đang chạy các farm khác có sẵn
                if _G.BuyingMelee == true or _G.Raiding or _G.Level or _G.AutoFarm then 
                    if not char:FindFirstChild("NEJI_FIX_ESP") then
                        local h = Instance.new("Highlight")
                        h.Name = "NEJI_FIX_ESP"
                        h.FillColor = Color3.fromRGB(255, 0, 0) -- Màu đỏ đặc trưng của NEJI Hub
                        h.OutlineColor = Color3.fromRGB(255, 255, 255)
                        h.FillAlpha = 0.4
                        h.OutlineTransparency = 0
                        h.Parent = char
                    end
                else
                    -- Chỉ xóa khi KHÔNG có bất kỳ hoạt động nào đang bật
                    if char:FindFirstChild("NEJI_FIX_ESP") then
                        char.NEJI_FIX_ESP:Destroy()
                    end
                end
            end
        end)
    end
end)

-- 2. HÀM TWEEN TỐI ƯU (Không làm treo Sea Event và bật ESP chuẩn)
local function TweenTo(targetCFrame)
    if not targetCFrame then return end
    
    -- Bật biến ESP ngay lập tức TRƯỚC khi chạy luồng spawn để đảm bảo nhận diện[span_3](start_span)[span_3](end_span)
    _G.BuyingMelee = true 
    
    task.spawn(function()
        local char = lp.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then 
            _G.BuyingMelee = false 
            return 
        end

        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        local tweenTime = distance / 300
        local tween = TweenService:Create(hrp, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
        
        -- Chống rơi và ổn định nhân vật
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0,0,0)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        -- Noclip để xuyên vật thể
        local noclip = RunService.Stepped:Connect(function()
            if char then
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end)

        tween:Play()
        
        -- Đợi tween xong nhưng không dùng .Wait() để tránh đứng script[span_4](start_span)[span_4](end_span)
        tween.Completed:Connect(function()
            bv:Destroy()
            if noclip then noclip:Disconnect() end
            
            -- Đợi thêm 1.5 giây sau khi tới NPC rồi mới tắt ESP để mắt kịp nhìn[span_5](start_span)[span_5](end_span)
            task.wait(1.5) 
            _G.BuyingMelee = false 
        end)
    end)
end

Tabs.Shop:AddButton({
Name = "Buy Black Leg", 
Description = "Mua Hắc Cước",
Callback = function()
  local Pos = World1 and CFrame.new(-985, 13, 3988) or World2 and CFrame.new(-4753, 35, -4850) or World3 and CFrame.new(-5045, 371, -3181)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg")
end})

Tabs.Shop:AddButton({
Name = "Buy Electro", 
Description = "Mua Điện",
Callback = function()
  local Pos = World1 and CFrame.new(-5384, 13, -2148) or World2 and CFrame.new(-4867, 35, -4766) or World3 and CFrame.new(-4995, 314, -3203)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BuyElectro")
end})

Tabs.Shop:AddButton({
Name = "Buy Fishman Karate", 
Description = "Mua Karate Người Cá",
Callback = function()
  local Pos = World1 and CFrame.new(61585, 18, 987) or World2 and CFrame.new(-4958, 35, -4668) or World3 and CFrame.new(-5023, 371, -3190)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
end})

Tabs.Shop:AddButton({
Name = "Buy DragonBreath", 
Description = "Mua Hơi Thở Của Rồng",
Callback = function()
  local Pos = World2 and CFrame.new(701, 187, 655) or World3 and CFrame.new(-4981, 371, -3207)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
end})

Tabs.Shop:AddButton({
Name = "Buy Superhuman", 
Description = "Mua Thượng Nhân Quyền",
Callback = function()
  local Pos = World2 and CFrame.new(1374, 247, -5192) or World3 and CFrame.new(-5004, 371, -3198)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BuySuperhuman")
end})

Tabs.Shop:AddButton({
Name = "Buy Death Step", 
Description = "Mua Tử Cước",
Callback = function()
  local Pos = World2 and CFrame.new(6357, 296, -6762) or World3 and CFrame.new(-4999, 314, -3221)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BuyDeathStep")
end})

Tabs.Shop:AddButton({
Name = "Buy Sharkman Karate", 
Description = "Mua Karate Cá Mập",
Callback = function()
  local Pos = World2 and CFrame.new(-2602, 238, -10316) or World3 and CFrame.new(-4972, 314, -3222)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
end})

Tabs.Shop:AddButton({
Name = "Buy ElectricClaw", 
Description = "Mua Lôi Trảo",
Callback = function()
  local Pos = World3 and CFrame.new(-10371, 331, -10131)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw")
end})

Tabs.Shop:AddButton({
Name = "Buy DragonTalon", 
Description = "Mua Hoả Long Quyền",
Callback = function()
  local Pos = World3 and CFrame.new(5661, 1211, 865)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon")
end})

Tabs.Shop:AddButton({
Name = "Buy GodHuman", 
Description = "Mua Thần Diệt Quyền",
Callback = function()
  local Pos = World3 and CFrame.new(-13776, 334, -9879)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BuyGodhuman")
end})

Tabs.Shop:AddButton({
Name = "Buy SanguineArt", 
Description = "Mua Huyết Quỷ Thuật",
Callback = function()
  local Pos = World3 and CFrame.new(-16353, 160, 99)
  TweenTo(Pos)
  replicated.Remotes.CommF_:InvokeServer("BuySanguineArt")
end})

Tabs.Shop:AddSection({"Accessory"})
Tabs.Shop:AddButton({
Name = "Buy Tomoe Ring", 
Description = "Mua Tomoe Ring",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Tomoe Ring")
end})
Tabs.Shop:AddButton({
Name = "Buy Black Cape", 
Description = "Mua Black Cape",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Black Cape")
end})
Tabs.Shop:AddButton({
Name = "Buy Swordsman Hat", 
Description = "Mua Mũ Swordsman",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Swordsman Hat")
end})
Tabs.Shop:AddButton({
Name = "Buy Bizarre Rifle", 
Description = "Mua Súng Trường Kỳ Quái",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 1)
end})
Tabs.Shop:AddButton({
Name = "Buy Ghoul Mask", 
Description = "Mua Mặt Nạ Ma Cà Rồng",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 2)
end})

Tabs.Shop:AddSection({"Accessory SeaEvent"})
Tabs.Shop:AddButton({
Name = "Craft DragonHeart", 
Description = "Chế Tạo DragonHeart",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","Dragonheart");
end})
Tabs.Shop:AddButton({
Name = "Craft DragonStorm", 
Description = "Chế Tạo DragonStorm",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","Dragonstorm");
end})
Tabs.Shop:AddButton({
Name = "Craft Dino Hood", 
Description = "Chế Tạo Dino Hood",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","DinoHood");
end})   
Tabs.Shop:AddButton({
Name = "Craft Shark Tooth", 
Description = "Chế Tạo Răng Cá Mập",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","SharkTooth");
end})   
Tabs.Shop:AddButton({
Name = "Craft Terror Jaw", 
Description = "Chế Tạo Hàm Terror",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","TerrorJaw");
end})   
Tabs.Shop:AddButton({
Name = "Craft Shark Anchor", 
Description = "Chế Tạo Mỏ Neo",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","SharkAnchor");
end})   
Tabs.Shop:AddButton({
Name = "Craft Leviathan Crown", 
Description = "Chế Tạo Vương Miện Leviathan",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","LeviathanCrown");
end})   
Tabs.Shop:AddButton({
Name = "Craft Leviathan Shield", 
Description = "Chế Tạo Khiêng Leviathan",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","LeviathanShield");
end})   
Tabs.Shop:AddButton({
Name = "Craft Leviathan Boat", 
Description = "Chế Tạo Thuyền Leviathan",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","LeviathanBoat");
end})   
Tabs.Shop:AddButton({
Name = "Craft LegendaryScroll", 
Description = "Chế Tạo Cuộn Huyền Thoại",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","LegendaryScroll");
end})   
Tabs.Shop:AddButton({
Name = "Craft MythicalScroll", 
Description = "Chế Tạo Cuộn Thần Thoại",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CraftItem","Craft","MythicalScroll");
end})   

Tabs.Shop:AddSection({"Weapon World 1"})
Tabs.Shop:AddButton({
Name = "Buy Cutlass", 
Description = "Mua Đao Hải Tặc",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
end})
Tabs.Shop:AddButton({
Name = "Buy Katana", 
Description = "Mua Kiếm Katana",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Katana")
end})
Tabs.Shop:AddButton({
Name = "Buy Iron Mace", 
Description = "Mua Chuỳ Sắt",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
end})   
Tabs.Shop:AddButton({
Name = "Buy Duel Katana", 
Description = "Mua Song Kiếm Katana",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
end})   
Tabs.Shop:AddButton({
Name = "Buy Triple Katana", 
Description = "Mua Tam Kiếm Katana",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
end})  
Tabs.Shop:AddButton({
Name = "Buy Pipe", 
Description = "Mua Ống Nước",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Pipe")
end})  
Tabs.Shop:AddButton({
Name = "Buy Dual-Headed Blade", 
Description = "Mua Lưỡi Dao Hai Đầu",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
end})   
Tabs.Shop:AddButton({
Name = "Buy Bisento", 
Description = "Mua Đại Đao",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Bisento")
end})  
Tabs.Shop:AddButton({
Name = "Buy Soul Cane", 
Description = "Mua Gậy Linh Hồn",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
end})
Tabs.Shop:AddButton({
Name = "Buy SlingShot", 
Description = "Mua Ná Cao Su",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Slingshot")
end})
Tabs.Shop:AddButton({
Name = "Buy Musket", 
Description = "Mua Súng Hoả Mai",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Musket")
end})    
Tabs.Shop:AddButton({
Name = "Buy Dual Flintlock", 
Description = "Mua Súng Kíp Đôi",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Dual Flintlock")
end})   
Tabs.Shop:AddButton({
Name = "Buy Flintlock", 
Description = "Mua Súng Kíp",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Flintlock")
end})   
Tabs.Shop:AddButton({
Name = "Buy Refined Flintlock", 
Description = "Mua Súng Kíp Tinh Luyện",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock")
end})   
Tabs.Shop:AddButton({
Name = "Buy Cannon", 
Description = "Mua Đại Bác",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BuyItem","Cannon")
end}) 
Tabs.Shop:AddButton({
Name = "Buy Kabucha", 
Description = "Mua Ná Kabucha",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
end})

Tabs.Shop:AddSection({"Fragments shop"})
Tabs.Shop:AddButton({
Name = "Refund Stats", 
Description = "Hoàn Lại Chỉ Số",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
end})
Tabs.Shop:AddButton({
Name = "Reroll Race", 
Description = "Đổi Tộc",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
end})   
Tabs.Shop:AddButton({
Name = "Buy Ghoul Race", 
Description = "Mua Tộc Quỷ",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("Ectoplasm"," Change", 4)
end})	
Tabs.Shop:AddButton({
Name = "Buy Cyborg Race", 
Description = "Mua Tộc Người Máy",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("CyborgTrainer"," Buy")
end})

Tabs.Misc:AddSection({"Server - Function"})
Tabs.Misc:AddButton({
Name = "Rejoin Server", 
Description = "Vào Lại Máy Chủ",
Callback = function()
  game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end})
Tabs.Misc:AddButton({
Name = "Hop Server", 
Description = "Chuyển Máy Chủ",
Callback = function()
  Hop()
end})
Tabs.Misc:AddButton({
Name = "Hop Server Lowest Player", 
Description = "Tham Gia Máy Chủ Ít Người",
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
Name = "Hop Server Lowest Ping", 
Description = "Tham Gia Máy Chủ Ping Thấp",
Callback = function()
local HTTPService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local StatsService = game:GetService("Stats")
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

Tabs.Misc:AddTextBox({
    Name = "Input Job ID",
    Placeholder = "...",
    ClearOnFocus = true,
    Callback = function(Value)
        getgenv().JobId = Value
    end
})

local function JoinServerById(jobId)
    if not jobId or jobId == "" then
        warn("Please Enter Job ID")
        return false
    end
    
    pcall(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, game.Players.LocalPlayer)
    end)
    return true
end

Tabs.Misc:AddButton({
    Name = "Teleport [Job ID]", 
    Description = "Dịch Chuyển [Job ID]",
    Callback = function()
        JoinServerById(getgenv().JobId)
    end
})

Tabs.Misc:AddButton({
Name = "Copy Job ID", 
Description = "Sao Chép Job ID Máy Chủ",
Callback = function()
  setclipboard(tostring(game.JobId))
end})

Tabs.Misc:AddSection({"Player Gui / Others"})

Tabs.Misc:AddButton({
Name = "Open Awakening Expert", 
Description = "Mở Chuyên Gia Thức Tỉnh",
Callback = function()
  plr.PlayerGui.Main.AwakeningToggler.Visible = true
end})
Tabs.Misc:AddButton({
Name = "Open Title Select", 
Description = "Mở Lựa Chọn Danh Hiệu",
Callback = function()
  replicated.Remotes.CommF_:InvokeServer("getTitles",true)
  plr.PlayerGui.Main.Titles.Visible = true
end})
DisbleChat = Tabs.Misc:AddToggle({
Name = "Disable Chat", 
Description = "Tắt Chat", 
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
DisbleLeaderB = Tabs.Misc:AddToggle({
Name = "Disable Leader Board", 
Description = "Tắt Khung Chat", 
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
Name = "Set Pirate Team", 
Description = "Vào Đội Hải Tặc",
Callback = function()
  Pirates()
end})  
Tabs.Misc:AddButton({
Name = "Set Marine Team", 
Description = "Vào Đội Hải Quân",
Callback = function()
  Marines()
end})
UnPortal = Tabs.Misc:AddToggle({
Name = "Unlock All Portals", 
Description = "Nhảy Vô Hạn Bằng Trái Portal", 
Default = false,
Callback = function(Value)
  _G.PortalUnLock = Value
end})
spawn(function()
  while wait(Sec) do
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
    Name = "Redeem All Codes",
    Description = "Đổi Tất Cả Mã",
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
Tabs.Misc:AddSection({"Graphics / Haki Stats"})

HakiSt = {"State 0","State 1","State 2","State 3","State 4","State 5"}
HakiStat = Tabs.Misc:AddDropdown({
Name = "Select Haki States",
Options = HakiSt,
Default = false,
Callback = function(Value)
  _G.SelectStateHaki = Value
end})
Tabs.Misc:AddButton({
Name = "ChangeBusoStage", 
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
rtxM = Tabs.Misc:AddToggle({
Name = "Turn On RTX Mode", 
Description = "Bật Chế Độ RTX", 
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
Name = "Turn On Fast Mode", 
Description = "Bật Chế Độ Nhanh",
Callback = function()
  for _,zx in next, workspace:GetDescendants() do
  if table.find(Past, zx.ClassName) then  zx.Material = "Plastic" end
  end
end})
Tabs.Misc:AddButton({
Name = "Turn On Low CPU", 
Description = "Bật CPU Thấp",
Callback = function()
  LowCpu()
end})
Tabs.Misc:AddButton({
Name = "Turn On Increase Boat", 
Description = "Bật Tăng Tốc Thuyền",
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
Name = "Remove Sky Fog", 
Description = "Xoá Sương Mù",
Callback = function()
  if Lighting:FindFirstChild("LightingLayers") then Lighting.LightingLayers:Destroy() end
  if Lighting:FindFirstChild("SeaTerrorCC") then Lighting.SeaTerrorCC:Destroy() end
  if Lighting:FindFirstChild("FantasySky") then Lighting.FantasySky:Destroy() end
end})

Tabs.Misc:AddSection({"Configure - God"})
Tabs.Misc:AddButton({
Name = "Devil Fruit Rain Update 2450", 
Description = "Mưa Trái Ác Quảy Cập Nhật Cấp 2450",
Callback = function()
  for i, v in pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren()) do
    v.Parent = game.Workspace.Map
    v:MoveTo(plr.Character.PrimaryPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))
    if v.Fruit:FindFirstChild("AnimationController") then
      v.Fruit:FindFirstChild("AnimationController"):LoadAnimation(v.Fruit:FindFirstChild("Idle")):Play()
    end
    v.Handle.Touched:Connect(function(otherPart)
      if otherPart.Parent == plr.Character then
        v.Parent = plr.Backpack
        plr.Character.Humanoid:EquipTool(v)
      end
    end)
  end
end})
Tabs.Misc:AddToggle({
    Title = "Unlock Zoom Limit",
    Description = "Mở Khoá Giới Hạn Thu Phóng",
    Default = false,
    Callback = function(Value)
        local player = game:GetService("Players").LocalPlayer
        if Value then
            -- Mở khóa zoom
            player.CameraMaxZoomDistance = 100000
        else
            -- Về mặc định
            player.CameraMaxZoomDistance = 128
        end
    end
})
briggt1 = Tabs.Misc:AddToggle({
Name = "FullBright", 
Description = "Sáng Màn Hình", 
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
Tabs.Misc:AddToggle({
    Name = "Noclip",
    Description = "Đi Xuyên Tường",
    Default = false,
    Callback = function(Value)
        getgenv().NoClip = Value
    end
})
spawn(function()
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
getgenv().UiSettingsModule = { currentTheme = Color3.fromRGB(255, 255, 255) }
getgenv().OthersStuffsModule = {
    LoadSettings = function() return {} end,
    SaveSettings = function() end,
    ApplySettings = function() end
}
getgenv().Library = {
    ToggleUI = function() end
}

local SilentAimModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/jaanu91/Ip/refs/heads/main/Bg"))()

Tabs.Misc:AddToggle({
    Name = "Silent Aim",
    Description = "Aim Chiêu Vào Người Chơi",
    Default = false,
    Callback = function()
        pcall(function()
           SilentAimModule:SetPlayerSilentAim(true)
            SilentAimModule:SetPrediction(true)
        end)
    end
})
DayN = Tabs.Misc:AddDropdown({
Name = "Select Time",
Description = "",
Options = {"Morning", "Evening"},
Default = false,
Callback = function(Value)
  _G.SelectDN = Value
end})
dayornight = Tabs.Misc:AddToggle({
Name = "Turn On Time", 
Description = "Bật Thời Gian", 
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
walkWater = Tabs.Misc:AddToggle({
Name = "Turn On Walk On Water", 
Description = "Bật Đi Trên Nước", 
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
iceWalk = Tabs.Misc:AddToggle({
Name = "Turn On Ice Walk", 
Description = "Bật Đi Trên Băng", 
Default = false,
Callback = function(Value)
  _G.WalkWater = Value
end})
spawn(function()
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

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local plr = Players.LocalPlayer

local v1 = next
local v2 = {
    RS:WaitForChild("Util"),
    RS:WaitForChild("Common"),
    RS:WaitForChild("Remotes"),
    RS:WaitForChild("Assets"),
    RS:WaitForChild("FX"),
}

local v3 = nil
local u4 = nil -- RemoteEvent found
local u5 = nil -- Id attribute

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

loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhDzaiScript/Setting/refs/heads/main/FastMax.lua"))()
local function GetBladeHits()
    local targets = {}
    local function GetDistance(v)
        return (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    end
    
    for _, part in pairs({game.Workspace.Enemies, game.Workspace.Characters}) do
        for _, v in pairs(part:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") then
                if GetDistance(v.HumanoidRootPart) < 60 then
                    table.insert(targets, v)
                end
            end
        end
    end

    return targets
end

local function AttackAll()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end

    local equippedWeapon = character:FindFirstChild("EquippedWeapon")
    if not equippedWeapon then return end


    local enemies = GetBladeHits()
    if #enemies > 0 then
        local netModule = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net")
        netModule:WaitForChild("RE/RegisterAttack"):FireServer(-math.huge)
        
        local args = {nil, {}}
        for i, v in pairs(enemies) do
            if not args[1] then
                args[1] = v.Head
            end
            args[2][i] = {v, v.HumanoidRootPart}
        end
        
        netModule:WaitForChild("RE/RegisterHit"):FireServer(unpack(args))
    end
end

spawn(function()
    while task.wait() do AttackAll() end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Net = Modules:WaitForChild("Net")
local RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
local RegisterHit = Net:WaitForChild("RE/RegisterHit")
local ShootGunEvent = Net:WaitForChild("RE/ShootGunEvent")
local GunValidator = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Validator2")

local Config = {
    AttackDistance = 65,
    AttackMobs = true,
    AttackPlayers = true,
    AttackCooldown = 0.01,
    ComboResetTime = 0.3,
    MaxCombo = 4,
    HitboxLimbs = {"RightLowerArm", "RightUpperArm", "LeftLowerArm", "LeftUpperArm", "RightHand", "LeftHand"},
    AutoClickEnabled = true
}
getgenv().FA_Config = Config
getgenv().FA_Buddha = getgenv().FA_Buddha or false
getgenv().FA_BuddhaDist = getgenv().FA_BuddhaDist or 999
getgenv().FA_DefaultDist = getgenv().FA_DefaultDist or 65

task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			local cfg = getgenv().FA_Config
			if typeof(cfg) ~= "table" then return end
			cfg.AttackDistance = getgenv().FA_Buddha and getgenv().FA_BuddhaDist or getgenv().FA_DefaultDist
		end)
	end
end)
local FastAttack = {}
FastAttack.__index = FastAttack

function FastAttack.new()
    local self = setmetatable({
        Debounce = 0,
        ComboDebounce = 0,
        ShootDebounce = 0,
        M1Combo = 0,
        EnemyRootPart = nil,
        Connections = {},
        Overheat = {Dragonstorm = {MaxOverheat = 3, Cooldown = 0, TotalOverheat = 0, Distance = 350, Shooting = false}},
        ShootsPerTarget = {["Dual Flintlock"] = 2},
        SpecialShoots = {["Skull Guitar"] = "TAP", ["Bazooka"] = "Position", ["Cannon"] = "Position", ["Dragonstorm"] = "Overheat"}
    }, FastAttack)
    
    pcall(function()
        self.CombatFlags = require(Modules.Flags).COMBAT_REMOTE_THREAD
        self.ShootFunction = getupvalue(require(ReplicatedStorage.Controllers.CombatController).Attack, 9)
        local LocalScript = Player:WaitForChild("PlayerScripts"):FindFirstChildOfClass("LocalScript")
        if LocalScript and getsenv then
            self.HitFunction = getsenv(LocalScript)._G.SendHitsToServer
        end
    end)
    
    return self
end

function FastAttack:IsEntityAlive(entity)
    local humanoid = entity and entity:FindFirstChild("Humanoid")
    return humanoid and humanoid.Health > 0
end

function FastAttack:CheckStun(Character, Humanoid, ToolTip)
    local Stun = Character:FindFirstChild("Stun")
    local Busy = Character:FindFirstChild("Busy")
    if Humanoid.Sit and (ToolTip == "Sword" or ToolTip == "Melee" or ToolTip == "Blox Fruit") then
        return false
    elseif Stun and Stun.Value > 0 or Busy and Busy.Value then
        return false
    end
    return true
end

function FastAttack:GetBladeHits(Character, Distance)
    local Position = Character:GetPivot().Position
    local BladeHits = {}
    Distance = Distance or Config.AttackDistance
    
    local function ProcessTargets(Folder, CanAttack)
        for _, Enemy in ipairs(Folder:GetChildren()) do
            if Enemy ~= Character and self:IsEntityAlive(Enemy) then
                local BasePart = Enemy:FindFirstChild(Config.HitboxLimbs[math.random(#Config.HitboxLimbs)]) or Enemy:FindFirstChild("HumanoidRootPart")
                if BasePart and (Position - BasePart.Position).Magnitude <= Distance then
                    if not self.EnemyRootPart then
                        self.EnemyRootPart = BasePart
                    else
                        table.insert(BladeHits, {Enemy, BasePart})
                    end
                end
            end
        end
    end
    
    if Config.AttackMobs then ProcessTargets(Workspace.Enemies) end
    if Config.AttackPlayers then ProcessTargets(Workspace.Characters, true) end
    
    return BladeHits
end

function FastAttack:GetClosestEnemy(Character, Distance)
    local BladeHits = self:GetBladeHits(Character, Distance)
    local Closest, MinDistance = nil, math.huge
    
    for _, Hit in ipairs(BladeHits) do
        local Magnitude = (Character:GetPivot().Position - Hit[2].Position).Magnitude
        if Magnitude < MinDistance then
            MinDistance = Magnitude
            Closest = Hit[2]
        end
    end
    return Closest
end

function FastAttack:GetCombo()
    local Combo = (tick() - self.ComboDebounce) <= Config.ComboResetTime and self.M1Combo or 0
    Combo = Combo >= Config.MaxCombo and 1 or Combo + 1
    self.ComboDebounce = tick()
    self.M1Combo = Combo
    return Combo
end

function FastAttack:ShootInTarget(TargetPosition)
    local Character = Player.Character
    if not self:IsEntityAlive(Character) then return end
    
    local Equipped = Character:FindFirstChildOfClass("Tool")
    if not Equipped or Equipped.ToolTip ~= "Gun" then return end
    
    local Cooldown = Equipped:FindFirstChild("Cooldown") and Equipped.Cooldown.Value or 0.3
    if (tick() - self.ShootDebounce) < Cooldown then return end
    
    local ShootType = self.SpecialShoots[Equipped.Name] or "Normal"
    if ShootType == "Position" or (ShootType == "TAP" and Equipped:FindFirstChild("RemoteEvent")) then
        Equipped:SetAttribute("LocalTotalShots", (Equipped:GetAttribute("LocalTotalShots") or 0) + 1)
        GunValidator:FireServer(self:GetValidator2())
        
        if ShootType == "TAP" then
            Equipped.RemoteEvent:FireServer("TAP", TargetPosition)
        else
            ShootGunEvent:FireServer(TargetPosition)
        end
        self.ShootDebounce = tick()
    else
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        self.ShootDebounce = tick()
    end
end

function FastAttack:GetValidator2()
    local v1 = getupvalue(self.ShootFunction, 15)
    local v2 = getupvalue(self.ShootFunction, 13)
    local v3 = getupvalue(self.ShootFunction, 16)
    local v4 = getupvalue(self.ShootFunction, 17)
    local v5 = getupvalue(self.ShootFunction, 14)
    local v6 = getupvalue(self.ShootFunction, 12)
    local v7 = getupvalue(self.ShootFunction, 18)
    
    local v8 = v6 * v2
    local v9 = (v5 * v2 + v6 * v1) % v3
    v9 = (v9 * v3 + v8) % v4
    v5 = math.floor(v9 / v3)
    v6 = v9 - v5 * v3
    v7 = v7 + 1
    
    setupvalue(self.ShootFunction, 15, v1)
    setupvalue(self.ShootFunction, 13, v2)
    setupvalue(self.ShootFunction, 16, v3)
    setupvalue(self.ShootFunction, 17, v4)
    setupvalue(self.ShootFunction, 14, v5)
    setupvalue(self.ShootFunction, 12, v6)
    setupvalue(self.ShootFunction, 18, v7)
    
    return math.floor(v9 / v4 * 16777215), v7
end

function FastAttack:UseNormalClick(Character, Humanoid, Cooldown)
    self.EnemyRootPart = nil
    local BladeHits = self:GetBladeHits(Character)
    
    if self.EnemyRootPart then
        RegisterAttack:FireServer(Cooldown)
        if self.CombatFlags and self.HitFunction then
            self.HitFunction(self.EnemyRootPart, BladeHits)
        else
            RegisterHit:FireServer(self.EnemyRootPart, BladeHits)
        end
    end
end

function FastAttack:UseFruitM1(Character, Equipped, Combo)
    local Targets = self:GetBladeHits(Character)
    if not Targets[1] then return end
    
    local Direction = (Targets[1][2].Position - Character:GetPivot().Position).Unit
    Equipped.LeftClickRemote:FireServer(Direction, Combo)
end

function FastAttack:Attack()
    if not Config.AutoClickEnabled or (tick() - self.Debounce) < Config.AttackCooldown then return end
    local Character = Player.Character
    if not Character or not self:IsEntityAlive(Character) then return end
    
    local Humanoid = Character.Humanoid
    local Equipped = Character:FindFirstChildOfClass("Tool")
    if not Equipped then return end
    
    local ToolTip = Equipped.ToolTip
    if not table.find({"Melee", "Blox Fruit", "Sword", "Gun"}, ToolTip) then return end
    
    local Cooldown = Equipped:FindFirstChild("Cooldown") and Equipped.Cooldown.Value or Config.AttackCooldown
    if not self:CheckStun(Character, Humanoid, ToolTip) then return end
    
    local Combo = self:GetCombo()
    Cooldown = Cooldown + (Combo >= Config.MaxCombo and 0.05 or 0)
    self.Debounce = Combo >= Config.MaxCombo and ToolTip ~= "Gun" and (tick() + 0.05) or tick()
    
    if ToolTip == "Blox Fruit" and Equipped:FindFirstChild("LeftClickRemote") then
        self:UseFruitM1(Character, Equipped, Combo)
    elseif ToolTip == "Gun" then
        local Target = self:GetClosestEnemy(Character, 120)
        if Target then
            self:ShootInTarget(Target.Position)
        end
    else
        self:UseNormalClick(Character, Humanoid, Cooldown)
    end
end

local AttackInstance = FastAttack.new()
table.insert(AttackInstance.Connections, RunService.Stepped:Connect(function()
    AttackInstance:Attack()
end))

for _, v in pairs(getgc(true)) do
    if typeof(v) == "function" and iscclosure(v) then
        local name = debug.getinfo(v).name
        if name == "Attack" or name == "attack" or name == "RegisterHit" then
            hookfunction(v, function(...)
                AttackInstance:Attack()
                return v(...)
            end)
        end
    end
end
---Fast 2 ---
local Modules = game.ReplicatedStorage.Modules
local Net = Modules.Net
local Register_Hit, Register_Attack = Net:WaitForChild("RE/RegisterHit"), Net:WaitForChild("RE/RegisterAttack")
local Funcs = {}
function GetAllBladeHits()
    bladehits = {}
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 
        and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 65 then
            table.insert(bladehits, v)
        end
    end
    return bladehits
end
function Getplayerhit()
    bladehits = {}
    for _, v in pairs(workspace.Characters:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 
        and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 65 then
            table.insert(bladehits, v)
        end
    end
    return bladehits
end
function Funcs:Attack()
    local bladehits = {}
    for r,v in pairs(GetAllBladeHits()) do
        table.insert(bladehits, v)
    end
    for r,v in pairs(Getplayerhit()) do
        table.insert(bladehits, v)
    end
    if #bladehits == 0 then return end
    local args = {
        [1] = nil;
        [2] = {},
        [4] = "078da341"
    }
    for r, v in pairs(bladehits) do
        Register_Attack:FireServer(0)
        if not args[1] then
            args[1] = v.Head
        end
        args[2][r] = {
	            [1] = v,
            [2] = v.HumanoidRootPart
        }
    end
    Register_Hit:FireServer(unpack(args))
end

pcall(function()
    SaveManager:SetLibrary(Fluent)
    SaveManager:SetFolder("NejiHub")
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({"SaveManager_ConfigName","SaveManager_ConfigList"})
    SaveManager:BuildConfigSection(Tabs.Settings._tab)
    SaveManager:LoadAutoloadConfig()

    InterfaceManager:SetLibrary(Fluent)
    InterfaceManager:SetFolder("NejiHub")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings._tab)
end)

pcall(function()
    Fluent:Notify({
        Title="NEJI Hub",
        Content="Fluent UI loaded",
        Duration=3
    })
end)
