-- Integrated Fluent UI port based on supplied source.
-- Key system and Secret Quest removed. External source logic is preserved where possible.
-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
-- Join SL Discord for more leaked sources & hubs: https://discord.gg/zNyHGU6eUK
do pcall(function() getgenv().SL_SourceLeak = "Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]" end) end
-- Removed unrelated startup remote loader from original source.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local Stats = game:GetService("Stats")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local plr = Players.LocalPlayer

getgenv().Configs = {
	["Auto Active Race V4"] = true,
	["Boost FPS"] = true,
	["FPS Limit"] = 15,
	Gun = {
		"Skull Guitar",
		"Kabucha",
		"Venom Bow",
		"Musket",
		"Flintlock",
		-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		"Refined Slingshot",
		"Magma Blaster",
		"Dual Flintlock",
		"Cannon",
		"Bizarre Revolver",
		"Bazooka",
	},
	Quest = {
		["Evo Race V1"] = true,
		["Evo Race V2"] = true,
		["Pull Lerver"] = true,
		["RGB Haki"] = true,
	},
	Sword = {
		"Dual-Headed Blade",
		"Smoke Admiral",
		"Wardens Sword",
		"Cutlass",
		"Katana",
		"Dual Katana",
		"Triple Katana",
		"Iron Mace",
		"Saber",
		"Pole (1st Form)",
		"Gravity Blade",
		"Longsword",
		"Rengoku",
		"Midnight Blade",
		"Soul Cane",
		"Bisento",
		-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
		"Yama",
		"Tushita",
		"Cursed Dual Katana",
	},
}
getgenv().RealKidHubRunning = true


-- Key system and authorization helpers intentionally removed.




local function GetBP(toolName)
	local bp = plr and plr:FindFirstChild("Backpack")
	if bp and bp:FindFirstChild(toolName) then
		return true
	end
	local char = plr and plr.Character
	if char and char:FindFirstChild(toolName) then
		return true
		-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
	end
	return false
end

local function GetInventory(forceRefresh)
	local genv = getgenv()
	local cache = genv.RealKidInventoryCache
	if not forceRefresh then
		if
			type(cache) == "table"
			and type(cache.Items) == "table"
			and type(cache.ByName) == "table"
			and type(cache.ByType) == "table"
			and type(cache.Materials) == "table"
			and (tick() - (cache.Time or 0) < 3)
		then
			return cache.Items
		end
	end
	local ok, result = pcall(function()
		local mods = genv.RealKidInventoryModules
		if type(mods) ~= "table" then
			mods = {
				Service = require(ReplicatedStorage.ItemReplicationService),
				Config = require(ReplicatedStorage.ItemConfig),
				Keys = require(ReplicatedStorage.ItemReplicationService.KEYS),
			}
			genv.RealKidInventoryModules = mods
		end
		local items, byName, byType, materials = {}, {}, {}, {}
		-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
		for _, bag in pairs(mods.Service:GetClientInventoryIterator()) do
			for itemId, rawItem in pairs(bag) do
				local cfg = mods.Config[itemId]
				if type(cfg) == "table" then
					local name = cfg.Name or tostring(itemId)
					local itemType = cfg.Type or ""
					local count = tonumber(rawItem[mods.Keys.Count]) or 1
					local mastery = tonumber(rawItem[mods.Keys.Mastery]) or 0
					local entry = {
						Id = itemId,
						Name = name,
						DisplayName = cfg.DisplayName or name,
						Type = itemType,
						Count = count,
						Mastery = mastery,
						MasteryRequirements = cfg.MasteryRequirements,
						Rarity = cfg.Rarity or 0,
						Value = cfg.Value,
						Raw = rawItem,
						Config = cfg,
					}
					items[#items + 1] = entry
					byName[name] = entry
					if not byType[itemType] then
						byType[itemType] = {}
					end
					byType[itemType][name] = entry
					if itemType == "Material" then
						materials[name] = count
					end
					-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
				end
			end
		end
		genv.RealKidInventoryCache = {
			Time = tick(),
			Items = items,
			ByName = byName,
			ByType = byType,
			Materials = materials,
		}
		return items
	end)
	if ok and type(result) == "table" then
		return result
	end
	return (type(cache) == "table" and type(cache.Items) == "table") and cache.Items or {}
end

local function GetMaterialCount(materialName)
	GetInventory()
	local cache = getgenv().RealKidInventoryCache
	return (type(cache) == "table" and type(cache.Materials) == "table" and tonumber(cache.Materials[materialName])) or 0
end

local function HasItem(itemName)
	if GetBP(itemName) then
		return true
	end
	GetInventory()
	local cache = getgenv().RealKidInventoryCache
	-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
	return (type(cache) == "table" and type(cache.ByName) == "table" and cache.ByName[itemName] ~= nil) or false
end

local function GetItemsByType(itemType)
	GetInventory()
	local cache = getgenv().RealKidInventoryCache
	return (type(cache) == "table" and type(cache.ByType) == "table" and cache.ByType[itemType]) or {}
end

local activeTween = nil
local isFarming = false
local shouldTween = false
local targetTweenPos = Vector3.zero

local function TweenToTarget(targetCFrame)
	local ok, err = pcall(function()
		local char = plr and plr.Character
		if not char then
			return
		end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hum or not hrp or hum.Health <= 0 then
			return
		end
		if not targetCFrame then
			return
		end
		local destPos = targetCFrame.Position
		local dist = (destPos - hrp.Position).Magnitude
		-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
		if dist <= 250 then
			if activeTween then
				pcall(function() activeTween:Cancel() end)
				activeTween = nil
			end
			hrp.CFrame = targetCFrame
			return
		end
		local speed = tonumber(getgenv().TweenSpeed) or 160
		local info = TweenInfo.new(dist / speed, Enum.EasingStyle.Linear)
		activeTween = TweenService:Create(hrp, info, { CFrame = targetCFrame })
		activeTween:Play()
	end)
	if not ok then
		warn("topos error:", err)
	end
end

local originalNamecall = getgenv().RealKidOriginalNamecall
local function AimbotNamecallHook(self, ...)
	local method = getnamecallmethod and getnamecallmethod() or ""
	local args = { ... }
	local aimCF = MousePos and (_G.AimMethod and getgenv().AimPos or CFrame.new(MousePos))
	local shouldRedirect = (
		method == "FireServer"
		and self.Name == "RemoteEvent"
		and aimCF
		and tostring(aimCF.X) ~= "nan"
		and (
			(_G.FarmMastery_G and not SoulGuitar)
			-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
			or _G.FarmMastery_Dev
			or _G.FarmBlazeEM
			or _G.Prehis_Skills
			or _G.SeaBeast1
			or _G.FishBoat
			or _G.PGB
			or _G.Leviathan1
			or _G.AutoTrialRace
			or _G.Defeating
			or _G.Auto_RaceV3
			or _G.AimMethod
		)
	)
	if shouldRedirect then
		if #args == 1 and typeof(args[1]) == "Vector3" then
			args[1] = aimCF.Position
			if originalNamecall then
				return originalNamecall(self, unpack(args))
			end
		elseif #args >= 1 and typeof(args[1]) == "CFrame" then
			args[1] = aimCF
			if originalNamecall then
				return originalNamecall(self, unpack(args))
			end
		end
	end
	if originalNamecall then
		return originalNamecall(self, ...)
	end
end
-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK

local lastFarmCheckTick = 0
local hasFarmHighlight = false
local prevIsFarming = false
local FARM_GLOBAL_FLAGS = {
	"AutoFarm", "AutoFarmLevel", "AutoFarmNearest", "AutoFarmBone",
	"AutoFarmEctoplasm", "AutoFarmCakePrince", "AutoFarmBoss", "AutoRaid",
	"AutoDungeon", "AutoSeaEvent", "AutoMirage", "AutoKitsune", "AutoPrehistoric",
}

local function OnHeartbeatFarmUpdate()
	getgenv().OnFarm = shouldTween and true or false
	local char = plr and plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local now = tick()
	if now - lastFarmCheckTick < 0.1 then
		return
	end
	lastFarmCheckTick = now
	isFarming = false
	if _G.AutoMaterial or NextIs or senth or senth2 then
		isFarming = true
	else
		for _, flagName in ipairs(FARM_GLOBAL_FLAGS) do
			if _G[flagName] then
				isFarming = true
				break
			end
		end
	end
	-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then
		return
	end
	if isFarming then
		shouldTween = true
		local inBoat = hum.Sit and (_G.SailBoat_Hydra or _G.SailBoat_Tiki)
		if inBoat and hrp:FindFirstChild("BodyClip") then
			hrp.BodyClip:Destroy()
		elseif not inBoat and not hrp:FindFirstChild("BodyClip") then
			local bv = Instance.new("BodyVelocity")
			bv.Name = "BodyClip"
			bv.Parent = hrp
			bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			bv.Velocity = Vector3.zero
		end
		if not hasFarmHighlight then
			local hl = Instance.new("Highlight", char)
			hl.Name = "highlight"
			hl.FillColor = Color3.fromRGB(0, 191, 255)
			hl.OutlineColor = Color3.fromRGB(255, 255, 255)
			hl.FillTransparency = 0.5
			hl.OutlineTransparency = 0.2
			hasFarmHighlight = true
		end
		for _, part in pairs(char:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
		-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
	else
		shouldTween = false
		if activeTween then
			pcall(function() activeTween:Cancel() end)
			activeTween = nil
		end
		targetTweenPos = Vector3.zero
		if isFarming ~= prevIsFarming then
			for _, part in pairs(char:GetChildren()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
		if hrp:FindFirstChild("BodyClip") then
			hrp.BodyClip:Destroy()
		end
		if char:FindFirstChild("highlight") then
			char.highlight:Destroy()
			hasFarmHighlight = false
		end
	end
	prevIsFarming = isFarming
end

local function OnHeartbeatBoatAndTweenUpdate(dt)
	if not shouldTween then
		return
	end
	local char = plr and plr.Character
	--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then
		return
	end
	local ghost = workspace:FindFirstChild("_TpGhost")
	if ghost and activeTween and (hrp.Position - targetTweenPos).Magnitude > 5 then
		hrp.CFrame = CFrame.new(ghost.Position) * (hrp.CFrame - hrp.Position)
	end
end

local function OnSteppedNoClipUpdate()
	if not shouldTween and not isFarming then
		getgenv().NoClip = false
		return
	end
	getgenv().NoClip = true
	local char = plr and plr.Character
	if char then
		for _, desc in pairs(char:GetDescendants()) do
			if desc:IsA("BasePart") then
				desc.CanCollide = false
			end
		end
	end -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
end


local ConfigData = {
	AntiAFK = true,
	--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
	AutoActiveRaceV3 = false,
	AutoActiveRaceV4 = false,
	AutoAwakening = false,
	AutoBartiloQuest = false,
	AutoBuyBoat = "Miracle",
	AutoBuyChip = false,
	AutoBuyLegendarySword = false,
	AutoBuySpy = false,
	AutoCakePrince = false,
	AutoChest = false,
	AutoCitizenQuest = false,
	AutoCollectBerry = false,
	AutoCollectEgg = false,
	AutoCollectFireFlowers = false,
	AutoCraftCommonScroll = false,
	AutoCraftLeviathanHeart = false,
	AutoCraftLeviathanShield = false,
	AutoCraftMonsterMagnet = false,
	AutoCraftMythicalScroll = false,
	AutoCraftRareScroll = false,
	AutoCraftTerrorJaw = false,
	AutoCraftTooth = false,
	AutoDarkDagger = false,
	AutoDeathStep = false,
	AutoDefeatBlazeEmber = false,
	AutoDestroyTree = true,
	AutoDojoTrainer = false,
	AutoDoughKing = false,
	AutoDragonTalon = false,
	AutoDragonstorm = false,
	-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
	AutoDragoV1 = false,
	AutoDragoV3 = false,
	AutoDropFruits = false,
	AutoDungeon = false,
	AutoElectricClaw = false,
	AutoEliteHunter = false,
	AutoEnhance = false,
	AutoEvoRaceV2 = false,
	AutoFarmBerry = false,
	AutoFarmBlazeEmber = false,
	AutoFarmBone = false,
	AutoFarmBoss = false,
	AutoFarmChest = false,
	AutoFarmChestInstant = false,
	AutoFarmDragonScale = false,
	AutoFarmEctoplasm = false,
	AutoFarmFishCrew = false,
	AutoFarmFishTail = false,
	AutoFarmGunPowder = false,
	AutoFarmKitsune = false,
	AutoFarmLeather = false,
	AutoFarmMagmaOre = false,
	AutoFarmMiniTusk = false,
	AutoFarmMysticDroplet = false,
	AutoFarmObservation = false,
	AutoFarmPirateBrigade = false,
	AutoFarmPirateGrandBrigade = false,
	AutoFarmRadioactive = false,
	AutoFarmScrapMetal = false,
	AutoFarmSeaBeast = false,
	-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
	AutoFarmShark = false,
	AutoFarmSharkTooth = false,
	AutoFarmTerrorShark = false,
	AutoFarmVampireFang = false,
	AutoFarmYetiFur = false,
	AutoFish = false,
	AutoFishSlap = false,
	AutoFixLag = false,
	AutoFlyKitsune = false,
	AutoFreezingHydra = false,
	AutoGacha = false,
	AutoGetCDK = false,
	AutoGetCyborg = false,
	AutoGetGhoul = false,
	AutoGetHollowScythe = false,
	AutoGetPole = false,
	AutoGetRainbowHaki = false,
	AutoGetRengoku = false,
	AutoGetSaber = false,
	AutoGetSaddi = false,
	AutoGetSharkAnchor = false,
	AutoGetShisui = false,
	AutoGetSkullGuitar = false,
	AutoGetSoulGuitar = false,
	AutoGetSpikeyTrident = false,
	AutoGetTushita = false,
	AutoGetWando = false,
	AutoGetWardenSword = false,
	AutoGetYama = false,
	AutoGodhuman = false,
	-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
	AutoHakiColor = false,
	AutoHolyTorch = false,
	AutoHopKitsune = false,
	AutoHopMirage = false,
	AutoHopPrehistoric = false,
	AutoHopRipIndra = false,
	AutoIceAdmiral = false,
	AutoKen = false,
	AutoKillGolem = false,
	AutoKillLaw = false,
	AutoKillLeviathan = false,
	AutoKillPlayers = false,
	AutoKillSeaEvent = false,
	AutoKillTerrorshark = false,
	AutoKitsune = false,
	AutoLoadScript = true,
	AutoLookMoon = false,
	AutoLowCPU = false,
	AutoMasteryFruit = false,
	AutoMasteryGun = false,
	AutoMirrorFractal = false,
	AutoMob = false,
	AutoMusketeerHat = false,
	AutoNextIsland = false,
	AutoNumericStats = 1,
	AutoObservationV2 = false,
	AutoOpenLibraryDoor = false,
	AutoOpenWaterKey = false,
	AutoPaleScarf = false,
	AutoPickChest = false,
	-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
	AutoPirateRaid = false,
	AutoPlushie = false,
	AutoPrehistoric = false,
	AutoPray = false,
	AutoPullLever = false,
	AutoQuestBoss = false,
	AutoQuestPrehistoric = false,
	AutoQuestYama = false,
	AutoRaceV3 = false,
	AutoRaceV4 = false,
	AutoRaid = false,
	AutoRandomBone = false,
	AutoRandomFruit = false,
	AutoRandomSurprise = false,
	AutoRejoin = true,
	AutoRelic = false,
	AutoRemoveFog = false,
	AutoRemoveLava = true,
	AutoremoveSkyFog = false,
	AutoRipIndra = false,
	AutoSaber = false,
	AutoSailBoat = false,
	AutoSanguineArt = false,
	AutoSaw = false,
	AutoSeabeast = false,
	AutoSecondSea = false,
	AutoSellFish = false,
	AutoSerpentBow = false,
	AutoSetSpawnPoint = true,
	AutoSharkmanKarate = false,
	-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
	Autoskull = false,
	AutoSlapEvent = false,
	AutoSoulReaper = false,
	AutoSpawnCakePrince = false,
	AutoSpawnDoughKing = false,
	AutoStartRaid = false,
	AutoStatsDefense = false,
	AutoStatsFruit = false,
	AutoStatsGun = false,
	AutoStatsMelee = false,
	AutoStatsSword = false,
	AutoStoreFruit = false,
	AutoSuperhuman = false,
	AutoSwanGlasses = false,
	AutoTeleportBarista = false,
	AutoThirdSea = false,
	AutoTrainRace = false,
	AutoTravel = false,
	AutoTrial = false,
	AutoTushita = false,
	AutoTweenEventFishingSpot = false,
	AutoTwinHooks = false,
	AutoUnstoreFruit = false,
	AutoUpgradeAnchor = false,
	AutoUpgradeDrago = false,
	AutoUpgradeGun = false,
	AutoUpgradeRace = false,
	AutoUpgradeSword = false,
	AutoValkyrie = false,
	AutoVolcano = false,
	-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
	AutoYama = false,
	Berry = false,
	BringMobMax = "6",
	BringMode = "400",
	Bringmob = true,
	BusuAura = true,
	Chest = false,
	DisableNotify = false,
	DungeonAccountStart = false,
	DungeonAutoJoin = false,
	EspBerries = false,
	EspChests = false,
	EspFruits = false,
	EspIslandLocation = false,
	EspPlayers = false,
	FarmMastery_G = false,
	FastAttackPlayers = true,
	GoToSharkmanNPC = false,
	HopBerry = false,
	Initialize = true,
	JumpPower = false,
	KenAura2 = false,
	MagicFruits = false,
	MasterySword = false,
	RaceV3Aura = false,
	RaceV4Aura = false,
	RandomAround = false,
	RemoveDeathRespawnVFX = false,
	RemoveHitVFX = false,
	SafeMode = false,
	-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
	SpectatePlayer = false,
	StopWhenChalice = true,
	SwapDragoRace = false,
	TeleportToPlayer = false,
	TweenSpeedV4 = 190,
	WalkSpeed = false,
	accept_quests = false,
	account_pick_slot_raid = false,
	auto_buy_style = false,
	auto_destroy_lava = true,
	auto_factory_raid = false,
	auto_farm_general = false,
	auto_farm_materials = false,
	auto_farm_nearest = false,
	auto_farm_sea_event = false,
	auto_load_script = true,
	auto_low_cpu_once = false,
	auto_mastery_fruits = false,
	auto_multi_raid = false,
	auto_sea_event_friend = false,
	auto_training_dummy = false,
	auto_travel_dressrosa = false,
	auto_zou_quest = false,
	autoshootgun = true,
	autotwfruits = false,
	discord_fruit_rarities = { "Common", "Uncommon", "Rare", "Legendary", "Mythical" },
	discord_notice_frozen = false,
	discord_notice_mirage = false,
	discord_notice_prehistoric = false,
	discord_notice_profile = false,
	-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
	discord_notice_spy = false,
	discord_notice_stored_fruit = false,
	discord_ping_id = false,
	discord_ping_mode = "Không ping",
	farm_m1_fruit_sea = false,
	farm_m1_gun_sea = false,
	global_skill_delay = 100,
	global_skill_hold_c = 10,
	global_skill_hold_f = 10,
	global_skill_hold_v = 10,
	global_skill_hold_x = 10,
	global_skill_hold_z = 10,
	global_skill_keys = { "Z", "X", "C" },
	global_skill_weapons = { "Melee", "Sword", "Blox Fruit", "Gun" },
	hopantirs = false,
	ignore_cake_prince = false,
	mastery_health_percent = 30,
	material_choice = false,
	multi_raid_players = {},
	raidnew = false,
	sea_event_friend = false,
	selected_farm_target = "Auto Level",
	selected_fighting_style = "Black Leg",
	selected_sea_events = {},
	selected_team = "Marines",
	toggle_portal_tp = true,
	weapon_choice = "Melee",
}

-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
local function SaveConfig(key, value)
	if key ~= nil then
		ConfigData[key] = value
		if type(getgenv().Flags) == "table" then
			getgenv().Flags[key] = value
		end
	end
	pcall(function()
		local json = HttpService:JSONEncode(ConfigData)
		writefile("RealKidHub/save2/" .. Players.LocalPlayer.Name .. ".json", json)
	end)
end


wait()
game:IsLoaded()
wait()
getgenv().Team = "Marines"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CommF_ = Remotes:WaitForChild("CommF_")
wait()
Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
wait()
workspace:FindFirstChild("Map")
local module = require(ReplicatedStorage.Reparent)
module.Unparent = function(arg, arg2)
end
task.wait(0.4)
game:IsLoaded()
-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
local Main = Players.LocalPlayer.PlayerGui:WaitForChild("Main", 9000000000)
Main:WaitForChild("Loading", 9000000000)
task.wait()
Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
Players.LocalPlayer.Character:WaitForChild("Energy")
local Data = Players.LocalPlayer:WaitForChild("Data")
Data:WaitForChild("Level")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
workspace:WaitForChild("Enemies")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local Stats = game:GetService("Stats")
Players.LocalPlayer.CharacterAdded:Connect(function(character)
	character:WaitForChild("HumanoidRootPart")
end)
-- Optional Rocks cleanup removed to avoid deleting game objects.
getgenv().RealKidOriginalNamecall = function(arg3, arg4)
end
local Part = Instance.new("Part")
Part.Name = "_TpGhost"
Part.Size = Vector3.new(1, 1, 1)
Part.Anchored = true
Part.CanCollide = false
Part.CanTouch = false
Part.Transparency = 1
Part.Parent = workspace
RunService.Stepped:Connect(OnSteppedNoClipUpdate)
-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
RunService.Heartbeat:Connect(OnHeartbeatFarmUpdate)
RunService.Heartbeat:Connect(OnHeartbeatBoatAndTweenUpdate)
local Quests = ReplicatedStorage:WaitForChild("Quests")
require(Quests)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
getgenv().Flags = getgenv().Flags or {}
getgenv().FlagNamesMapping = getgenv().FlagNamesMapping or {}
getgenv().IsScriptLoading = true
getgenv().PendingConfigCallbacks = {}
local Window = Fluent:CreateWindow({
    Title = "Legacy Hub ",
    SubTitle = "- BF : Script By real_Thanh",
    Icon = "rbxassetid://127729348105692",
    TabWidth = 120,
    Size = UDim2.fromOffset(560, 440),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl,
})
local tabMethods = setmetatable({}, { __mode = "k" })
local function safeTitle(value)
    return tostring(value or "Option"):gsub("[^%w]+", "_")
end
local function makeGroup(tab, groupTitle)
    local native = tabMethods[tab]
    native.AddSection(tab, tostring(groupTitle or "Options"))
    local group = {}
    function group:AddSection(title) native.AddSection(tab, tostring(title)) end
    function group:AddLabel(text)
        local paragraph = native.AddParagraph(tab, { Title = tostring(text or ""), Content = "" })
        local label = {}
        function label:SetText(newText)
            pcall(function() if paragraph.SetDesc then paragraph:SetDesc(tostring(newText)) end end)
            pcall(function() if paragraph.SetTitle then paragraph:SetTitle(tostring(newText)) end end)
        end
        return label
    end
    function group:AddButton(opts)
        opts = opts or {}
        native.AddButton(tab, { Title = tostring(opts.Title or "Button"), Description = tostring(opts.Desc or opts.Description or ""), Callback = function()
            if type(opts.Callback) == "function" then pcall(opts.Callback, true, nil) end
        end })
    end
    function group:AddToggle(id, opts)
        opts = opts or {}
        native.AddToggle(tab, tostring(id or opts.Title or "Toggle"), {
            Title = tostring(opts.Title or id or "Toggle"),
            Description = tostring(opts.Desc or opts.Description or ""),
            Default = opts.Default == true,
            Callback = function(value)
                if type(opts.Callback) == "function" then pcall(opts.Callback, value, nil) end
            end,
        })
    end
    function group:AddDropdown(id, opts)
        opts = opts or {}
        native.AddDropdown(tab, tostring(id or opts.Title or "Dropdown"), {
            Title = tostring(opts.Title or id or "Dropdown"),
            Description = tostring(opts.Desc or opts.Description or ""),
            Values = opts.Values or opts.Options or {},
            Default = opts.Default,
            Multi = opts.Multi == true,
            Callback = function(value)
                if type(opts.Callback) == "function" then pcall(opts.Callback, value, nil) end
            end,
        })
    end
    function group:AddSlider(opts)
        opts = opts or {}
        local title = tostring(opts.Title or "Slider")
        native.AddSlider(tab, safeTitle(title), {
            Title = title,
            Description = tostring(opts.Desc or opts.Description or ""),
            Min = tonumber(opts.Min) or 0,
            Max = tonumber(opts.Max) or 100,
            Default = tonumber(opts.Default) or tonumber(opts.Min) or 0,
            Rounding = tonumber(opts.Rounding) or 0,
            Callback = function(value)
                if type(opts.Callback) == "function" then pcall(opts.Callback, value, nil) end
            end,
        })
    end
    function group:AddInput(id, opts)
        opts = opts or {}
        native.AddInput(tab, tostring(id or opts.Title or "Input"), {
            Title = tostring(opts.Title or id or "Input"),
            Description = tostring(opts.Desc or opts.Description or ""),
            Default = opts.Default or "",
            Placeholder = opts.Placeholder or "",
            Numeric = opts.Numeric == true,
            Finished = opts.Finished == true,
            Callback = function(value)
                if type(opts.Callback) == "function" then pcall(opts.Callback, value, nil) end
            end,
        })
    end
    return group
end
local fluentAddTab = Window.AddTab
function Window:AddTab(arg)
    local cfg = type(arg) == "table" and arg or { Title = tostring(arg or "Tab") }
    local tab = fluentAddTab(self, { Title = tostring(cfg.Title or cfg.Name or "Tab"), Icon = cfg.Icon or "rbxassetid://127729348105692" })
    tabMethods[tab] = { AddSection = tab.AddSection, AddParagraph = tab.AddParagraph, AddButton = tab.AddButton, AddToggle = tab.AddToggle, AddDropdown = tab.AddDropdown, AddSlider = tab.AddSlider, AddInput = tab.AddInput }
    function tab:AddLeftGroupbox(title) return makeGroup(self, title) end
    function tab:AddRightGroupbox(title) return makeGroup(self, title) end
        function tab:AddButton(opts) return makeGroup(self, ""):AddButton(opts) end
    function tab:AddToggle(id, opts) return makeGroup(self, ""):AddToggle(id, opts) end
    function tab:AddDropdown(id, opts) return makeGroup(self, ""):AddDropdown(id, opts) end
    function tab:AddSlider(opts) return makeGroup(self, ""):AddSlider(opts) end
    function tab:AddInput(id, opts) return makeGroup(self, ""):AddInput(id, opts) end
    return tab
end
function Window:MakeTab(arg) return self:AddTab(arg) end
function Window:Notify(arg)
    arg = arg or {}
    Fluent:Notify({ Title = tostring(arg.Title or "Light Hub"), Content = tostring(arg.Content or arg.Desc or ""), Duration = tonumber(arg.Duration) or 3 })
end
local result2 = {}
function result2:Notify(arg) Window:Notify(arg) end
Window.NewMinimizer = function() end
pcall(function() makefolder("RealKidHub") end)
pcall(function() makefolder("RealKidHub/save2") end)
getgenv().TweenSpeed = 160
getgenv().BoatSpeed = 140
local Tab = Window:AddTab("Discord")
local LeftGroupbox = Tab:AddLeftGroupbox("ReadKid Hub | Community")
LeftGroupbox:AddLabel("Join our discord community to receive information about the next update")
LeftGroupbox:AddButton({
	Title = "Copy Link Discord",
	Callback = function(state, arg12)
		setclipboard("https://discord.gg/s8R9b5NfsU")
		result2:Notify({ Title = "Thành Công", Desc = "Đã chép link Discord!", Duration = 3 })
		-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
	end
})
local LeftGroupbox2 = Tab:AddLeftGroupbox("Debug Farm")
local Label = LeftGroupbox2:AddLabel("Checking Farm\nĐang kiểm tra...")
task.spawn(function(...)
	while task.wait(0.3) do
		Label:SetText("Checking Farm\n🔴 Hiện tại không có chức năng nào được kích hoạt.")
	end
end)
local Tab2 = Window:AddTab("Server")
local LeftGroupbox3 = Tab2:AddLeftGroupbox("Chức Năng Server")
local Label2 = LeftGroupbox3:AddLabel("Server Uptime\nĐang tải dữ liệu...")
local Label3 = LeftGroupbox3:AddLabel("Time in Server\nĐang đếm...")
local Label4 = LeftGroupbox3:AddLabel("Dự đoán Rương (Fist of Darkness / Chalice)\nĐang tính toán...")
task.spawn(function(...)
	while task.wait(1) do
		Label3:SetText("Time in Server\n01h 20m 58s")
		local _WorldOrigin = workspace:FindFirstChild("_WorldOrigin")
		local Locations = _WorldOrigin:FindFirstChild("Locations")
		local children = Locations:GetChildren()
		for i, v in ipairs(children) do
			v:GetAttribute("TimeIn")
		end
		Label2:SetText("Server Uptime\nKhông xác định")
		Label4:SetText("Dự đoán Rương (Fist of Darkness / Chalice)\nĐang chờ tải Map...")
	end
end)
LeftGroupbox3:AddLabel("Place ID\n0")
_G.JobId = false
LeftGroupbox3:AddInput("JobID", {
-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
	Title = "JobID",
	Placeholder = "Nhập JobID...",
	Callback = function(state, arg14)
		if state then
			_G.JobId = state
		end
	end
})
LeftGroupbox3:AddButton({
	Title = "Teleport [Job ID]",
	Desc = "Di Chuyển Map Id Vừa Chọn",
	Callback = function(state, arg16)
		ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", false)
	end
})
LeftGroupbox3:AddButton({
	Title = "Sao Chép Job ID",
	Desc = "Copy Job ID vào clipboard",
	Callback = function(state, arg18)
		setclipboard(tostring(game.JobId))
	end
})
local LeftGroupbox4 = Tab2:AddLeftGroupbox("Chuyển Server")
LeftGroupbox4:AddToggle("Anti-Ban Server Hop", {
	Title = "Anti-Ban Server Hop",
	Desc = "Tự động đổi server mỗi 30 phút để tránh bị reset hoặc ban",
	Default = false,
	Callback = function(state, arg20)
		if state then
			SaveConfig()
			--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
		else
			SaveConfig()
		end
	end
})
LeftGroupbox4:AddButton({
	Title = "Rejoin Server",
	Desc = "Vào lại server hiện tại của bạn",
	Callback = function(state, arg22)
		ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", game.JobId)
	end
})
LeftGroupbox4:AddButton({
	Title = "Random Server Hop",
	Desc = "Chuyển sang một server công khai ngẫu nhiên",
	Callback = function(arg23, arg24)
		local __ServerBrowser = ReplicatedStorage:WaitForChild("__ServerBrowser")
		task.delay(0.02, function(...)
			local response14 = __ServerBrowser:InvokeServer(1)
			for k21, v51 in pairs(response14) do
			end
		end)
		task.delay(0.04, function(...)
			local response18 = __ServerBrowser:InvokeServer(2)
			for k25, v55 in pairs(response18) do
			end
		end)
		task.delay(0.06, function(...)
			local response21 = __ServerBrowser:InvokeServer(3)
			for k28, v58 in pairs(response21) do --[=[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] ]=]
			--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
			end
		end)
		task.delay(0.08, function(...)
			local response22 = __ServerBrowser:InvokeServer(4)
			for k29, v59 in pairs(response22) do
			end
		end)
		task.delay(0.1, function(...)
			local response27 = __ServerBrowser:InvokeServer(5)
			for k34, v64 in pairs(response27) do
			end
		end)
		task.delay(0.12, function(...)
			local response28 = __ServerBrowser:InvokeServer(6)
			for k35, v65 in pairs(response28) do
			end
		end)
		task.delay(0.14, function(...)
			local response31 = __ServerBrowser:InvokeServer(7)
			for k38, v68 in pairs(response31) do
			end
		end)
		task.delay(0.16, function(...)
			local response34 = __ServerBrowser:InvokeServer(8)
			for k41, v71 in pairs(response34) do
			end
		end)
		task.delay(0.18, function(...)
			local response39 = __ServerBrowser:InvokeServer(9)
			for k46, v76 in pairs(response39) do
			-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(0.2, function(...)
			local response41 = __ServerBrowser:InvokeServer(10)
			for k48, v78 in pairs(response41) do -- Source Leak (SL) | Join our Discord: https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(0.22, function(...)
			local response43 = __ServerBrowser:InvokeServer(11)
			for k50, v80 in pairs(response43) do
			end
		end)
		task.delay(0.24, function(...)
			local response47 = __ServerBrowser:InvokeServer(12)
			for k54, v84 in pairs(response47) do
			end
		end)
		task.delay(0.26, function(...)
			local response50 = __ServerBrowser:InvokeServer(13)
			for k57, v87 in pairs(response50) do
			end
		end)
		task.delay(0.28, function(...)
			local response52 = __ServerBrowser:InvokeServer(14)
			for k59, v89 in pairs(response52) do
			end
		end)
		task.delay(0.3, function(...)
			local response57 = __ServerBrowser:InvokeServer(15)
			for k64, v94 in pairs(response57) do
			-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(0.32, function(...)
			local response58 = __ServerBrowser:InvokeServer(16)
			for k65, v95 in pairs(response58) do
			end
		end)
		task.delay(0.34, function(...)
			local response61 = __ServerBrowser:InvokeServer(17)
			for k68, v98 in pairs(response61) do -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
			end
		end)
		task.delay(0.36, function(...)
			local response65 = __ServerBrowser:InvokeServer(18)
			for k72, v102 in pairs(response65) do
			end
		end)
		task.delay(0.38, function(...)
			local response67 = __ServerBrowser:InvokeServer(19)
			for k74, v104 in pairs(response67) do
			end
		end)
		task.delay(0.4, function(...)
			local response71 = __ServerBrowser:InvokeServer(20)
			for k78, v108 in pairs(response71) do
			end
		end)
		task.delay(0.42, function(...)
			local response74 = __ServerBrowser:InvokeServer(21)
			for k81, v111 in pairs(response74) do
			-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
			end
		end)
		task.delay(0.44, function(...)
			local response78 = __ServerBrowser:InvokeServer(22)
			for k85, v115 in pairs(response78) do
			end
		end)
		task.delay(0.46, function(...)
			local response80 = __ServerBrowser:InvokeServer(23)
			for k87, v117 in pairs(response80) do
			end
		end)
		task.delay(0.48, function(...)
			local response83 = __ServerBrowser:InvokeServer(24)
			for k90, v120 in pairs(response83) do -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
			end
		end)
		task.delay(0.5, function(...)
			local response86 = __ServerBrowser:InvokeServer(25)
			for k93, v123 in pairs(response86) do
				if ("Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]") ~= "" then
					local _sl = ("Leaked By " .. "SL | " .. "https://discord.gg/" .. "zNyHGU6eUK")
				end
			end
		end)
		task.delay(0.52, function(...)
			local response90 = __ServerBrowser:InvokeServer(26)
			for k97, v127 in pairs(response90) do
			end
		end)
		task.delay(0.54, function(...)
			local response91 = __ServerBrowser:InvokeServer(27)
			for k98, v128 in pairs(response91) do
			-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
			end
		end)
		task.delay(0.56, function(...)
			local response95 = __ServerBrowser:InvokeServer(28)
			for k102, v132 in pairs(response95) do
			end
		end)
		task.delay(0.58, function(...)
			local response98 = __ServerBrowser:InvokeServer(29)
			for k105, v135 in pairs(response98) do
			end
		end)
		task.delay(0.6, function(...)
			local response102 = __ServerBrowser:InvokeServer(30)
			for k109, v139 in pairs(response102) do
			end
		end)
		task.delay(0.62, function(...)
			local response104 = __ServerBrowser:InvokeServer(31)
			for k111, v141 in pairs(response104) do -- Join SL Discord: https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(0.64, function(...)
			local response106 = __ServerBrowser:InvokeServer(32)
			for k113, v143 in pairs(response106) do
			end
		end)
		task.delay(0.66, function(...)
			local response109 = __ServerBrowser:InvokeServer(33)
			for k116, v146 in pairs(response109) do
			-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(0.68, function(...)
			local response113 = __ServerBrowser:InvokeServer(34)
			for k120, v150 in pairs(response113) do
			end
		end)
		task.delay(0.7, function(...)
			local response115 = __ServerBrowser:InvokeServer(35)
			for k122, v152 in pairs(response115) do
			end
		end)
		task.delay(0.72, function(...)
			local response118 = __ServerBrowser:InvokeServer(36)
			for k125, v155 in pairs(response118) do
			end
		end)
		task.delay(0.74, function(...)
			local response123 = __ServerBrowser:InvokeServer(37)
			for k130, v160 in pairs(response123) do
			end
		end)
		task.delay(0.76, function(...)
			local response126 = __ServerBrowser:InvokeServer(38)
			for k133, v163 in pairs(response126) do --[[ Leaked By SL | https://discord.gg/zNyHGU6eUK ]]
			end
		end)
		task.delay(0.78, function(...)
			local response127 = __ServerBrowser:InvokeServer(39)
			for k134, v164 in pairs(response127) do
			-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(0.8, function(...)
			local response132 = __ServerBrowser:InvokeServer(40)
			for k139, v169 in pairs(response132) do
			end
		end)
		task.delay(0.82, function(...)
			local response133 = __ServerBrowser:InvokeServer(41)
			for k140, v170 in pairs(response133) do
			end
		end)
		task.delay(0.84, function(...)
			local response136 = __ServerBrowser:InvokeServer(42)
			for k143, v173 in pairs(response136) do
			end
		end)
		task.delay(0.86, function(...)
			local response141 = __ServerBrowser:InvokeServer(43)
			for k148, v178 in pairs(response141) do
			end
		end)
		task.delay(0.88, function(...)
			local response144 = __ServerBrowser:InvokeServer(44)
			for k151, v181 in pairs(response144) do
			end
		end)
		task.delay(0.9, function(...)
			local response145 = __ServerBrowser:InvokeServer(45)
			for k152, v182 in pairs(response145) do -- Leaked by SL | Join https://discord.gg/zNyHGU6eUK for more leaks
			-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
			end
		end)
		task.delay(0.92, function(...)
			local response149 = __ServerBrowser:InvokeServer(46)
			for k156, v186 in pairs(response149) do
			end
		end)
		task.delay(0.94, function(...)
			local response152 = __ServerBrowser:InvokeServer(47)
			for k159, v189 in pairs(response152) do
			end
		end)
		task.delay(0.96, function(...)
			local response154 = __ServerBrowser:InvokeServer(48)
			for k161, v191 in pairs(response154) do
			end
		end)
		task.delay(0.98, function(...)
			local response157 = __ServerBrowser:InvokeServer(49)
			for k164, v194 in pairs(response157) do
			end
		end)
		task.delay(1, function(...)
			local response160 = __ServerBrowser:InvokeServer(50)
			for k167, v197 in pairs(response160) do
			end
		end)
		task.delay(1.02, function(...)
			local response165 = __ServerBrowser:InvokeServer(51)
			for k172, v202 in pairs(response165) do
			-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(1.04, function(...)
			local response166 = __ServerBrowser:InvokeServer(52)
			for k173, v203 in pairs(response166) do -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(1.06, function(...)
			local response169 = __ServerBrowser:InvokeServer(53)
			for k176, v206 in pairs(response169) do
				do -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
					local _sl = "Join SL Discord for more leaks: " .. "https://discord.gg/zNyHGU6eUK"
				end
			end
		end)
		task.delay(1.08, function(...)
			local response174 = __ServerBrowser:InvokeServer(54)
			for k181, v211 in pairs(response174) do
			end
		end)
		task.delay(1.1, function(...)
			local response176 = __ServerBrowser:InvokeServer(55)
			for k183, v213 in pairs(response176) do
			end
		end)
		task.delay(1.12, function(...)
			local response179 = __ServerBrowser:InvokeServer(56)
			for k186, v216 in pairs(response179) do
			end
		end)
		task.delay(1.14, function(...)
			local response183 = __ServerBrowser:InvokeServer(57)
			for k190, v220 in pairs(response183) do
			-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
			end
		end)
		task.delay(1.16, function(...)
			local response186 = __ServerBrowser:InvokeServer(58)
			for k193, v223 in pairs(response186) do
			end
		end)
		task.delay(1.18, function(...)
			local response189 = __ServerBrowser:InvokeServer(59)
			for k196, v226 in pairs(response189) do --[=[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] ]=]
			end
		end)
		task.delay(1.2, function(...)
			local response191 = __ServerBrowser:InvokeServer(60)
			for k198, v228 in pairs(response191) do
			end
		end)
		task.delay(1.22, function(...)
			local response194 = __ServerBrowser:InvokeServer(61)
			for k201, v231 in pairs(response194) do
			end
		end)
		task.delay(1.24, function(...)
			local response198 = __ServerBrowser:InvokeServer(62)
			for k205, v235 in pairs(response198) do
			end
		end)
		task.delay(1.26, function(...)
			local response200 = __ServerBrowser:InvokeServer(63)
			for k207, v237 in pairs(response200) do
			-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(1.28, function(...)
			local response203 = __ServerBrowser:InvokeServer(64)
			for k210, v240 in pairs(response203) do
			end
		end)
		task.delay(1.3, function(...)
			local response207 = __ServerBrowser:InvokeServer(65)
			for k214, v244 in pairs(response207) do
			end
		end)
		task.delay(1.32, function(...)
			local response209 = __ServerBrowser:InvokeServer(66)
			for k216, v246 in pairs(response209) do -- Source Leak (SL) | Join our Discord: https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(1.34, function(...)
			local response212 = __ServerBrowser:InvokeServer(67)
			for k219, v249 in pairs(response212) do
			end
		end)
		task.delay(1.36, function(...)
			local response214 = __ServerBrowser:InvokeServer(68)
			for k221, v251 in pairs(response214) do
			end
		end)
		task.delay(1.38, function(...)
			local response218 = __ServerBrowser:InvokeServer(69)
			for k225, v255 in pairs(response218) do
			-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(1.4, function(...)
			local response220 = __ServerBrowser:InvokeServer(70)
			for k227, v257 in pairs(response220) do
			end
		end)
		task.delay(1.42, function(...)
			local response224 = __ServerBrowser:InvokeServer(71)
			for k231, v261 in pairs(response224) do
			end
		end)
		task.delay(1.44, function(...)
			local response227 = __ServerBrowser:InvokeServer(72)
			for k234, v264 in pairs(response227) do
			end
		end)
		task.delay(1.46, function(...)
			local response230 = __ServerBrowser:InvokeServer(73)
			for k237, v267 in pairs(response230) do -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
			end
		end)
		task.delay(1.48, function(...)
			local response233 = __ServerBrowser:InvokeServer(74)
			for k240, v270 in pairs(response233) do
			end
		end)
		task.delay(1.5, function(...)
			local response237 = __ServerBrowser:InvokeServer(75)
			for k244, v274 in pairs(response237) do
			-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(1.52, function(...)
			local response239 = __ServerBrowser:InvokeServer(76)
			for k246, v276 in pairs(response239) do
			end
		end)
		task.delay(1.54, function(...)
			local response243 = __ServerBrowser:InvokeServer(77)
			for k250, v280 in pairs(response243) do
			end
		end)
		task.delay(1.56, function(...)
			local response246 = __ServerBrowser:InvokeServer(78)
			for k253, v283 in pairs(response246) do
			end
		end)
		task.delay(1.58, function(...)
			local response248 = __ServerBrowser:InvokeServer(79)
			for k255, v285 in pairs(response248) do
			end
		end)
		task.delay(1.6, function(...)
			local response250 = __ServerBrowser:InvokeServer(80)
			for k257, v287 in pairs(response250) do -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
			end
		end)
		task.delay(1.62, function(...)
			local response253 = __ServerBrowser:InvokeServer(81)
			for k260, v290 in pairs(response253) do
			-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
				if true then -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
					local _sl = { "Leaked By SL", "Source Leak", "https://discord.gg/zNyHGU6eUK" }
				end
			end
		end)
		task.delay(1.64, function(...)
			local response256 = __ServerBrowser:InvokeServer(82)
			for k263, v293 in pairs(response256) do
			end
		end)
		task.delay(1.66, function(...)
			local response260 = __ServerBrowser:InvokeServer(83)
			for k267, v297 in pairs(response260) do
			end
		end)
		task.delay(1.68, function(...)
			local response262 = __ServerBrowser:InvokeServer(84)
			for k269, v299 in pairs(response262) do
			end
		end)
		task.delay(1.7, function(...)
			local response266 = __ServerBrowser:InvokeServer(85)
			for k273, v303 in pairs(response266) do
			end
		end)
		task.delay(1.72, function(...)
			local response270 = __ServerBrowser:InvokeServer(86)
			for k277, v307 in pairs(response270) do
			end
		end)
		task.delay(1.74, function(...)
			local response271 = __ServerBrowser:InvokeServer(87)
			for k278, v308 in pairs(response271) do -- Join SL Discord: https://discord.gg/zNyHGU6eUK
			--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
			end
		end)
		task.delay(1.76, function(...)
			local response274 = __ServerBrowser:InvokeServer(88)
			for k281, v311 in pairs(response274) do
			end
		end)
		task.delay(1.78, function(...)
			local response278 = __ServerBrowser:InvokeServer(89)
			for k285, v315 in pairs(response278) do
			end
		end)
		task.delay(1.8, function(...)
			local response282 = __ServerBrowser:InvokeServer(90)
			for k289, v319 in pairs(response282) do
			end
		end)
		task.delay(1.82, function(...)
			local response285 = __ServerBrowser:InvokeServer(91)
			for k292, v322 in pairs(response285) do
			end
		end)
		task.delay(1.84, function(...)
			local response286 = __ServerBrowser:InvokeServer(92)
			for k293, v323 in pairs(response286) do
			end
		end)
		task.delay(1.86, function(...)
			local response291 = __ServerBrowser:InvokeServer(93)
			for k298, v328 in pairs(response291) do
			--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
			end
		end)
		task.delay(1.88, function(...)
			local response292 = __ServerBrowser:InvokeServer(94)
			for k299, v329 in pairs(response292) do --[[ Leaked By SL | https://discord.gg/zNyHGU6eUK ]]
			end
		end)
		task.delay(1.9, function(...)
			local response297 = __ServerBrowser:InvokeServer(95)
			for k304, v334 in pairs(response297) do
			end
		end)
		task.delay(1.92, function(...)
			local response299 = __ServerBrowser:InvokeServer(96)
			for k306, v336 in pairs(response299) do
			end
		end)
		task.delay(1.94, function(...)
			local response301 = __ServerBrowser:InvokeServer(97)
			for k308, v338 in pairs(response301) do
			end
		end)
		task.delay(1.96, function(...)
			local response305 = __ServerBrowser:InvokeServer(98)
			for k312, v342 in pairs(response305) do
			end
		end)
		task.delay(1.98, function(...)
			local response309 = __ServerBrowser:InvokeServer(99)
			for k316, v346 in pairs(response309) do
			-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
			end
		end)
		task.delay(2, function(...)
			local response311 = __ServerBrowser:InvokeServer(100)
			for k318, v348 in pairs(response311) do
			end
		end)
		task.wait()
		task.wait()
	end -- Leaked by SL | Join https://discord.gg/zNyHGU6eUK for more leaks
})
LeftGroupbox4:AddButton({
	Title = "Lowest Player Server",
	Desc = "Chuyển đến server có ít người chơi nhất",
	Callback = function(arg25, arg26)
		local __ServerBrowser2 = ReplicatedStorage:WaitForChild("__ServerBrowser")
		task.delay(0.02, function(...)
			local response13 = __ServerBrowser2:InvokeServer(1)
			for k20, v50 in pairs(response13) do
			end
		end)
		task.delay(0.04, function(...)
			local response17 = __ServerBrowser2:InvokeServer(2)
			for k24, v54 in pairs(response17) do
			end
		end)
		task.delay(0.06, function(...)
			local response19 = __ServerBrowser2:InvokeServer(3)
			for k26, v56 in pairs(response19) do
			end
			-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(0.08, function(...)
			local response23 = __ServerBrowser2:InvokeServer(4)
			for k30, v60 in pairs(response23) do
			end
		end)
		task.delay(0.1, function(...)
			local response25 = __ServerBrowser2:InvokeServer(5)
			for k32, v62 in pairs(response25) do
			end
		end)
		task.delay(0.12, function(...)
			local response30 = __ServerBrowser2:InvokeServer(6)
			-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
			-- Join SL Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
			for k37, v67 in pairs(response30) do
			end -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
		end)
		task.delay(0.14, function(...)
			local response32 = __ServerBrowser2:InvokeServer(7)
			for k39, v69 in pairs(response32) do
			end
		end)
		task.delay(0.16, function(...)
			local response35 = __ServerBrowser2:InvokeServer(8)
			for k42, v72 in pairs(response35) do
			end
		end)
		task.delay(0.18, function(...)
			local response38 = __ServerBrowser2:InvokeServer(9)
			for k45, v75 in pairs(response38) do
			end
			-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
		end)
		task.delay(0.2, function(...)
			local response40 = __ServerBrowser2:InvokeServer(10)
			for k47, v77 in pairs(response40) do
			end
		end)
		task.delay(0.22, function(...)
			local response45 = __ServerBrowser2:InvokeServer(11)
			for k52, v82 in pairs(response45) do
			end
		end)
		task.delay(0.24, function(...)
			local response46 = __ServerBrowser2:InvokeServer(12)
			for k53, v83 in pairs(response46) do
			end
		end)
		task.delay(0.26, function(...)
			local response51 = __ServerBrowser2:InvokeServer(13)
			for k58, v88 in pairs(response51) do
			end --[=[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] ]=]
		end)
		task.delay(0.28, function(...)
			local response53 = __ServerBrowser2:InvokeServer(14)
			for k60, v90 in pairs(response53) do
			end
		end)
		task.delay(0.3, function(...)
			local response55 = __ServerBrowser2:InvokeServer(15)
			for k62, v92 in pairs(response55) do
			end
			-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
		end)
		task.delay(0.32, function(...)
			local response60 = __ServerBrowser2:InvokeServer(16)
			for k67, v97 in pairs(response60) do
			end
		end)
		task.delay(0.34, function(...)
			local response63 = __ServerBrowser2:InvokeServer(17)
			for k70, v100 in pairs(response63) do
			end
		end)
		task.delay(0.36, function(...)
			local response66 = __ServerBrowser2:InvokeServer(18)
			for k73, v103 in pairs(response66) do
			end
		end)
		task.delay(0.38, function(...)
			local response68 = __ServerBrowser2:InvokeServer(19)
			for k75, v105 in pairs(response68) do
			end
		end)
		task.delay(0.4, function(...)
			local response70 = __ServerBrowser2:InvokeServer(20)
			for k77, v107 in pairs(response70) do
			end -- Source Leak (SL) | Join our Discord: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(0.42, function(...)
			local response73 = __ServerBrowser2:InvokeServer(21)
			for k80, v110 in pairs(response73) do
			end
			-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(0.44, function(...)
			local response76 = __ServerBrowser2:InvokeServer(22)
			for k83, v113 in pairs(response76) do
			end
		end)
		task.delay(0.46, function(...)
			local response81 = __ServerBrowser2:InvokeServer(23)
			for k88, v118 in pairs(response81) do
			end
		end)
		task.delay(0.48, function(...)
			local response82 = __ServerBrowser2:InvokeServer(24)
			for k89, v119 in pairs(response82) do
			end
		end)
		task.delay(0.5, function(...)
			local response87 = __ServerBrowser2:InvokeServer(25)
			for k94, v124 in pairs(response87) do
			end
		end)
		task.delay(0.52, function(...)
			local response89 = __ServerBrowser2:InvokeServer(26)
			for k96, v126 in pairs(response89) do
			end
		end)
		task.delay(0.54, function(...)
			local response93 = __ServerBrowser2:InvokeServer(27)
			for k100, v130 in pairs(response93) do
			end -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
			-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(0.56, function(...)
			local response96 = __ServerBrowser2:InvokeServer(28)
			for k103, v133 in pairs(response96) do
			end
		end)
		task.delay(0.58, function(...)
			local response99 = __ServerBrowser2:InvokeServer(29)
			for k106, v136 in pairs(response99) do
			end
		end)
		task.delay(0.6, function(...)
			local response100 = __ServerBrowser2:InvokeServer(30)
			for k107, v137 in pairs(response100) do
			end
		end)
		task.delay(0.62, function(...)
			local response105 = __ServerBrowser2:InvokeServer(31)
			for k112, v142 in pairs(response105) do
			end
		end)
		task.delay(0.64, function(...)
			local response108 = __ServerBrowser2:InvokeServer(32)
			for k115, v145 in pairs(response108) do
			end
		end)
		task.delay(0.66, function(...)
			local response111 = __ServerBrowser2:InvokeServer(33)
			for k118, v148 in pairs(response111) do
			end
			-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		end)
		task.delay(0.68, function(...)
			local response112 = __ServerBrowser2:InvokeServer(34)
			for k119, v149 in pairs(response112) do
			end -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		end)
		task.delay(0.7, function(...)
			local response117 = __ServerBrowser2:InvokeServer(35)
			for k124, v154 in pairs(response117) do
			end
		end)
		task.delay(0.72, function(...)
			local response119 = __ServerBrowser2:InvokeServer(36)
			for k126, v156 in pairs(response119) do
			end
		end)
		task.delay(0.74, function(...)
			local response121 = __ServerBrowser2:InvokeServer(37)
			for k128, v158 in pairs(response121) do
			end
		end)
		task.delay(0.76, function(...)
			local response124 = __ServerBrowser2:InvokeServer(38)
			for k131, v161 in pairs(response124) do
			end
		end)
		task.delay(0.78, function(...)
			local response128 = __ServerBrowser2:InvokeServer(39)
			for k135, v165 in pairs(response128) do
			end
			-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(0.8, function(...)
			local response131 = __ServerBrowser2:InvokeServer(40)
			for k138, v168 in pairs(response131) do
			end
		end)
		task.delay(0.82, function(...)
			local response134 = __ServerBrowser2:InvokeServer(41)
			for k141, v171 in pairs(response134) do
			end -- Join SL Discord: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(0.84, function(...)
			local response138 = __ServerBrowser2:InvokeServer(42)
			for k145, v175 in pairs(response138) do
			end
		end)
		task.delay(0.86, function(...)
			local response140 = __ServerBrowser2:InvokeServer(43)
			for k147, v177 in pairs(response140) do
			end
		end)
		task.delay(0.88, function(...)
			local response142 = __ServerBrowser2:InvokeServer(44)
			for k149, v179 in pairs(response142) do
			end
		end)
		task.delay(0.9, function(...)
			local response146 = __ServerBrowser2:InvokeServer(45)
			for k153, v183 in pairs(response146) do
			end
			-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
		end)
		task.delay(0.92, function(...)
			local response150 = __ServerBrowser2:InvokeServer(46)
			for k157, v187 in pairs(response150) do
			end
		end)
		task.delay(0.94, function(...)
			local response151 = __ServerBrowser2:InvokeServer(47)
			for k158, v188 in pairs(response151) do
			end
		end)
		task.delay(0.96, function(...)
			local response155 = __ServerBrowser2:InvokeServer(48)
			for k162, v192 in pairs(response155) do
			end --[[ Leaked By SL | https://discord.gg/zNyHGU6eUK ]]
		end)
		task.delay(0.98, function(...)
			local response158 = __ServerBrowser2:InvokeServer(49)
			for k165, v195 in pairs(response158) do
			end
		end)
		task.delay(1, function(...)
			local response162 = __ServerBrowser2:InvokeServer(50)
			for k169, v199 in pairs(response162) do
			end
		end)
		task.delay(1.02, function(...)
			local response164 = __ServerBrowser2:InvokeServer(51)
			for k171, v201 in pairs(response164) do
			end
			-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
		end)
		task.delay(1.04, function(...)
			local response168 = __ServerBrowser2:InvokeServer(52)
			for k175, v205 in pairs(response168) do
			end
		end)
		task.delay(1.06, function(...)
			local response170 = __ServerBrowser2:InvokeServer(53)
			for k177, v207 in pairs(response170) do
			end
		end)
		task.delay(1.08, function(...)
			local response173 = __ServerBrowser2:InvokeServer(54)
			for k180, v210 in pairs(response173) do
			end
		end)
		task.delay(1.1, function(...)
			local response177 = __ServerBrowser2:InvokeServer(55)
			for k184, v214 in pairs(response177) do
			end -- Leaked by SL | Join https://discord.gg/zNyHGU6eUK for more leaks
		end)
		task.delay(1.12, function(...)
			local response180 = __ServerBrowser2:InvokeServer(56)
			for k187, v217 in pairs(response180) do
			end
		end)
		task.delay(1.14, function(...)
			local response181 = __ServerBrowser2:InvokeServer(57)
			for k188, v218 in pairs(response181) do
			end
			-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
		end)
		task.delay(1.16, function(...)
			local response184 = __ServerBrowser2:InvokeServer(58)
			for k191, v221 in pairs(response184) do
			end
		end)
		task.delay(1.18, function(...)
			local response187 = __ServerBrowser2:InvokeServer(59)
			for k194, v224 in pairs(response187) do
			end
		end)
		task.delay(1.2, function(...)
			local response192 = __ServerBrowser2:InvokeServer(60)
			for k199, v229 in pairs(response192) do
			end
		end)
		task.delay(1.22, function(...)
			local response195 = __ServerBrowser2:InvokeServer(61)
			for k202, v232 in pairs(response195) do
			end
		end)
		task.delay(1.24, function(...)
			local response196 = __ServerBrowser2:InvokeServer(62)
			for k203, v233 in pairs(response196) do
			end -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
		end)
		task.delay(1.26, function(...)
			local response199 = __ServerBrowser2:InvokeServer(63)
			for k206, v236 in pairs(response199) do
			end
			-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(1.28, function(...)
			local response204 = __ServerBrowser2:InvokeServer(64)
			for k211, v241 in pairs(response204) do
			end
		end)
		task.delay(1.3, function(...)
			local response205 = __ServerBrowser2:InvokeServer(65)
			for k212, v242 in pairs(response205) do
			end
		end)
		task.delay(1.32, function(...)
			local response208 = __ServerBrowser2:InvokeServer(66)
			for k215, v245 in pairs(response208) do
			end
		end)
		task.delay(1.34, function(...)
			local response213 = __ServerBrowser2:InvokeServer(67)
			for k220, v250 in pairs(response213) do
			end
		end)
		task.delay(1.36, function(...)
			local response216 = __ServerBrowser2:InvokeServer(68)
			for k223, v253 in pairs(response216) do
			end
		end)
		task.delay(1.38, function(...)
			local response217 = __ServerBrowser2:InvokeServer(69)
			for k224, v254 in pairs(response217) do
			end --[=[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] ]=]
			-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
		end)
		task.delay(1.4, function(...)
			local response221 = __ServerBrowser2:InvokeServer(70)
			for k228, v258 in pairs(response221) do
			end
		end)
		task.delay(1.42, function(...)
			local response225 = __ServerBrowser2:InvokeServer(71)
			for k232, v262 in pairs(response225) do
			end
		end)
		task.delay(1.44, function(...)
			local response228 = __ServerBrowser2:InvokeServer(72)
			for k235, v265 in pairs(response228) do
			end
		end)
		task.delay(1.46, function(...)
			local response229 = __ServerBrowser2:InvokeServer(73)
			for k236, v266 in pairs(response229) do
			end
		end)
		task.delay(1.48, function(...)
			local response234 = __ServerBrowser2:InvokeServer(74)
			for k241, v271 in pairs(response234) do
			end
		end)
		task.delay(1.5, function(...)
			local response235 = __ServerBrowser2:InvokeServer(75)
			for k242, v272 in pairs(response235) do
			end
			--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
		end)
		task.delay(1.52, function(...)
			local response240 = __ServerBrowser2:InvokeServer(76)
			for k247, v277 in pairs(response240) do
			end -- Source Leak (SL) | Join our Discord: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(1.54, function(...)
			local response241 = __ServerBrowser2:InvokeServer(77)
			for k248, v278 in pairs(response241) do
			end
		end)
		task.delay(1.56, function(...)
			local response244 = __ServerBrowser2:InvokeServer(78)
			for k251, v281 in pairs(response244) do
			end
		end)
		task.delay(1.58, function(...)
			local response247 = __ServerBrowser2:InvokeServer(79)
			for k254, v284 in pairs(response247) do
			end
		end)
		task.delay(1.6, function(...)
			local response252 = __ServerBrowser2:InvokeServer(80)
			for k259, v289 in pairs(response252) do
			end
		end)
		task.delay(1.62, function(...)
			local response255 = __ServerBrowser2:InvokeServer(81)
			for k262, v292 in pairs(response255) do
			end
			--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
		end)
		task.delay(1.64, function(...)
			local response257 = __ServerBrowser2:InvokeServer(82)
			for k264, v294 in pairs(response257) do
			end
		end)
		task.delay(1.66, function(...)
			local response259 = __ServerBrowser2:InvokeServer(83)
			for k266, v296 in pairs(response259) do
			end -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		end)
		task.delay(1.68, function(...)
			local response264 = __ServerBrowser2:InvokeServer(84)
			for k271, v301 in pairs(response264) do
			end
		end)
		task.delay(1.7, function(...)
			local response265 = __ServerBrowser2:InvokeServer(85)
			for k272, v302 in pairs(response265) do
			end
		end)
		task.delay(1.72, function(...)
			local response269 = __ServerBrowser2:InvokeServer(86)
			for k276, v306 in pairs(response269) do
			end
		end)
		task.delay(1.74, function(...)
			local response272 = __ServerBrowser2:InvokeServer(87)
			for k279, v309 in pairs(response272) do
			end
			-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(1.76, function(...)
			local response276 = __ServerBrowser2:InvokeServer(88)
			for k283, v313 in pairs(response276) do
			end
		end)
		task.delay(1.78, function(...)
			local response279 = __ServerBrowser2:InvokeServer(89)
			for k286, v316 in pairs(response279) do
			end
		end)
		task.delay(1.8, function(...)
			local response280 = __ServerBrowser2:InvokeServer(90)
			for k287, v317 in pairs(response280) do
			end -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		end)
		task.delay(1.82, function(...)
			local response284 = __ServerBrowser2:InvokeServer(91)
			for k291, v321 in pairs(response284) do
			end
		end)
		task.delay(1.84, function(...)
			local response288 = __ServerBrowser2:InvokeServer(92)
			for k295, v325 in pairs(response288) do
			end
		end)
		task.delay(1.86, function(...)
			local response289 = __ServerBrowser2:InvokeServer(93)
			for k296, v326 in pairs(response289) do
			end
			-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(1.88, function(...)
			local response293 = __ServerBrowser2:InvokeServer(94)
			for k300, v330 in pairs(response293) do
			end
		end)
		task.delay(1.9, function(...)
			local response296 = __ServerBrowser2:InvokeServer(95)
			for k303, v333 in pairs(response296) do
			end
		end)
		task.delay(1.92, function(...)
			local response300 = __ServerBrowser2:InvokeServer(96)
			for k307, v337 in pairs(response300) do
			end
		end)
		task.delay(1.94, function(...)
			local response303 = __ServerBrowser2:InvokeServer(97)
			for k310, v340 in pairs(response303) do
			end -- Join SL Discord: https://discord.gg/zNyHGU6eUK
		end)
		task.delay(1.96, function(...)
			local response306 = __ServerBrowser2:InvokeServer(98)
			for k313, v343 in pairs(response306) do
			end
		end)
		task.delay(1.98, function(...)
			local response308 = __ServerBrowser2:InvokeServer(99)
			for k315, v345 in pairs(response308) do
			end
			-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
		end)
		task.delay(2, function(...)
			local response312 = __ServerBrowser2:InvokeServer(100)
			for k319, v349 in pairs(response312) do
			end
		end)
		task.wait()
		task.wait()
	end
})
LeftGroupbox4:AddButton({
	Title = "Lowest Ping Server",
	Desc = "Tìm server có ping thấp nhất (theo region)",
	Callback = function(arg27, arg28)
		local __ServerBrowser3 = ReplicatedStorage:WaitForChild("__ServerBrowser")
		task.delay(0.02, function(...)
			local response15 = __ServerBrowser3:InvokeServer(1)
			for k22, v52 in pairs(response15) do
			end
		end)
		task.delay(0.04, function(...)
			local response16 = __ServerBrowser3:InvokeServer(2)
			for k23, v53 in pairs(response16) do
			end
		end) --[[ Leaked By SL | https://discord.gg/zNyHGU6eUK ]]
		task.delay(0.06, function(...)
			local response20 = __ServerBrowser3:InvokeServer(3)
			for k27, v57 in pairs(response20) do
			end
		end)
		-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
		task.delay(0.08, function(...)
			local response24 = __ServerBrowser3:InvokeServer(4)
			for k31, v61 in pairs(response24) do
			end
		end)
		task.delay(0.1, function(...)
			local response26 = __ServerBrowser3:InvokeServer(5)
			for k33, v63 in pairs(response26) do
			end
		end)
		task.delay(0.12, function(...)
			local response29 = __ServerBrowser3:InvokeServer(6)
			for k36, v66 in pairs(response29) do
			end
		end)
		task.delay(0.14, function(...)
			local response33 = __ServerBrowser3:InvokeServer(7)
			for k40, v70 in pairs(response33) do
			end
		end)
		task.delay(0.16, function(...)
			local response36 = __ServerBrowser3:InvokeServer(8)
			for k43, v73 in pairs(response36) do
			end
		end)
		task.delay(0.18, function(...)
			local response37 = __ServerBrowser3:InvokeServer(9)
			for k44, v74 in pairs(response37) do
			end
		end) -- Leaked by SL | Join https://discord.gg/zNyHGU6eUK for more leaks
		-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
		task.delay(0.2, function(...)
			local response42 = __ServerBrowser3:InvokeServer(10)
			for k49, v79 in pairs(response42) do
			end
		end)
		task.delay(0.22, function(...)
			local response44 = __ServerBrowser3:InvokeServer(11)
			for k51, v81 in pairs(response44) do
			end
		end)
		task.delay(0.24, function(...)
			local response48 = __ServerBrowser3:InvokeServer(12)
			for k55, v85 in pairs(response48) do
			end
		end)
		task.delay(0.26, function(...)
			local response49 = __ServerBrowser3:InvokeServer(13)
			for k56, v86 in pairs(response49) do
			end
		end)
		task.delay(0.28, function(...)
			local response54 = __ServerBrowser3:InvokeServer(14)
			for k61, v91 in pairs(response54) do
			end
		end)
		task.delay(0.3, function(...)
			local response56 = __ServerBrowser3:InvokeServer(15)
			for k63, v93 in pairs(response56) do
			end
		end)
		-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
		task.delay(0.32, function(...)
			local response59 = __ServerBrowser3:InvokeServer(16)
			for k66, v96 in pairs(response59) do
			end
		end) -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
		task.delay(0.34, function(...)
			local response62 = __ServerBrowser3:InvokeServer(17)
			for k69, v99 in pairs(response62) do
			end
		end)
		task.delay(0.36, function(...)
			local response64 = __ServerBrowser3:InvokeServer(18)
			for k71, v101 in pairs(response64) do
			end
		end)
		task.delay(0.38, function(...)
			local response69 = __ServerBrowser3:InvokeServer(19)
			for k76, v106 in pairs(response69) do
			end
		end)
		task.delay(0.4, function(...)
			local response72 = __ServerBrowser3:InvokeServer(20)
			for k79, v109 in pairs(response72) do
			end
		end)
		task.delay(0.42, function(...)
			local response75 = __ServerBrowser3:InvokeServer(21)
			for k82, v112 in pairs(response75) do
			end
		end)
		-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		task.delay(0.44, function(...)
			local response77 = __ServerBrowser3:InvokeServer(22)
			for k84, v114 in pairs(response77) do
			end
		end)
		task.delay(0.46, function(...)
			local response79 = __ServerBrowser3:InvokeServer(23)
			for k86, v116 in pairs(response79) do
			end
		end) --[=[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] ]=]
		task.delay(0.48, function(...)
			local response84 = __ServerBrowser3:InvokeServer(24)
			for k91, v121 in pairs(response84) do
			end
		end)
		task.delay(0.5, function(...)
			local response85 = __ServerBrowser3:InvokeServer(25)
			for k92, v122 in pairs(response85) do
			end
		end)
		task.delay(0.52, function(...)
			local response88 = __ServerBrowser3:InvokeServer(26)
			for k95, v125 in pairs(response88) do
			end
		end)
		task.delay(0.54, function(...)
			local response92 = __ServerBrowser3:InvokeServer(27)
			for k99, v129 in pairs(response92) do
			end
		end)
		-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
		task.delay(0.56, function(...)
			local response94 = __ServerBrowser3:InvokeServer(28)
			for k101, v131 in pairs(response94) do
			end
		end)
		task.delay(0.58, function(...)
			local response97 = __ServerBrowser3:InvokeServer(29)
			for k104, v134 in pairs(response97) do
			end
		end)
		task.delay(0.6, function(...)
			local response101 = __ServerBrowser3:InvokeServer(30)
			for k108, v138 in pairs(response101) do
			end
		end) -- Source Leak (SL) | Join our Discord: https://discord.gg/zNyHGU6eUK
		task.delay(0.62, function(...)
			local response103 = __ServerBrowser3:InvokeServer(31)
			for k110, v140 in pairs(response103) do
			end
		end)
		task.delay(0.64, function(...)
			local response107 = __ServerBrowser3:InvokeServer(32)
			for k114, v144 in pairs(response107) do
			end
		end)
		task.delay(0.66, function(...)
			local response110 = __ServerBrowser3:InvokeServer(33)
			for k117, v147 in pairs(response110) do
			end
		end)
		-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
		task.delay(0.68, function(...)
			local response114 = __ServerBrowser3:InvokeServer(34)
			for k121, v151 in pairs(response114) do
			end
		end)
		task.delay(0.7, function(...)
			local response116 = __ServerBrowser3:InvokeServer(35)
			for k123, v153 in pairs(response116) do
			end
		end)
		task.delay(0.72, function(...)
			local response120 = __ServerBrowser3:InvokeServer(36)
			for k127, v157 in pairs(response120) do
			end
		end)
		task.delay(0.74, function(...)
			local response122 = __ServerBrowser3:InvokeServer(37)
			for k129, v159 in pairs(response122) do
			end
		end) -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		task.delay(0.76, function(...)
			local response125 = __ServerBrowser3:InvokeServer(38)
			for k132, v162 in pairs(response125) do
			end
		end)
		task.delay(0.78, function(...)
			local response129 = __ServerBrowser3:InvokeServer(39)
			for k136, v166 in pairs(response129) do
			end
		end)
		-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
		task.delay(0.8, function(...)
			local response130 = __ServerBrowser3:InvokeServer(40)
			for k137, v167 in pairs(response130) do
			end
		end)
		task.delay(0.82, function(...)
			local response135 = __ServerBrowser3:InvokeServer(41)
			for k142, v172 in pairs(response135) do
			end
		end)
		task.delay(0.84, function(...)
			local response137 = __ServerBrowser3:InvokeServer(42)
			for k144, v174 in pairs(response137) do
			end
		end)
		task.delay(0.86, function(...)
			local response139 = __ServerBrowser3:InvokeServer(43)
			for k146, v176 in pairs(response139) do
			end
		end)
		task.delay(0.88, function(...)
			local response143 = __ServerBrowser3:InvokeServer(44)
			for k150, v180 in pairs(response143) do
			end
		end) -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		task.delay(0.9, function(...)
			local response147 = __ServerBrowser3:InvokeServer(45)
			for k154, v184 in pairs(response147) do
			end
		end)
		-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
		task.delay(0.92, function(...)
			local response148 = __ServerBrowser3:InvokeServer(46)
			for k155, v185 in pairs(response148) do
			end
		end)
		task.delay(0.94, function(...)
			local response153 = __ServerBrowser3:InvokeServer(47)
			for k160, v190 in pairs(response153) do
			end
		end)
		task.delay(0.96, function(...)
			local response156 = __ServerBrowser3:InvokeServer(48)
			for k163, v193 in pairs(response156) do
			end
		end)
		task.delay(0.98, function(...)
			local response159 = __ServerBrowser3:InvokeServer(49)
			for k166, v196 in pairs(response159) do
			end
		end)
		task.delay(1, function(...)
			local response161 = __ServerBrowser3:InvokeServer(50)
			for k168, v198 in pairs(response161) do
			end
		end)
		task.delay(1.02, function(...)
			local response163 = __ServerBrowser3:InvokeServer(51)
			for k170, v200 in pairs(response163) do
			end
		end) -- Join SL Discord: https://discord.gg/zNyHGU6eUK
		-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
		task.delay(1.04, function(...)
			local response167 = __ServerBrowser3:InvokeServer(52)
			for k174, v204 in pairs(response167) do
			end
		end)
		task.delay(1.06, function(...)
			local response171 = __ServerBrowser3:InvokeServer(53)
			for k178, v208 in pairs(response171) do
			end
		end)
		task.delay(1.08, function(...)
			local response172 = __ServerBrowser3:InvokeServer(54)
			for k179, v209 in pairs(response172) do
			end
		end)
		task.delay(1.1, function(...)
			local response175 = __ServerBrowser3:InvokeServer(55)
			for k182, v212 in pairs(response175) do
			end
		end)
		task.delay(1.12, function(...)
			local response178 = __ServerBrowser3:InvokeServer(56)
			for k185, v215 in pairs(response178) do
			end
		end)
		task.delay(1.14, function(...)
			local response182 = __ServerBrowser3:InvokeServer(57)
			for k189, v219 in pairs(response182) do
			end
		end)
		-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
		task.delay(1.16, function(...)
			local response185 = __ServerBrowser3:InvokeServer(58)
			for k192, v222 in pairs(response185) do
			end
		end) --[[ Leaked By SL | https://discord.gg/zNyHGU6eUK ]]
		task.delay(1.18, function(...)
			local response188 = __ServerBrowser3:InvokeServer(59)
			for k195, v225 in pairs(response188) do
			end
		end)
		task.delay(1.2, function(...)
			local response190 = __ServerBrowser3:InvokeServer(60)
			for k197, v227 in pairs(response190) do
			end
		end)
		task.delay(1.22, function(...)
			local response193 = __ServerBrowser3:InvokeServer(61)
			for k200, v230 in pairs(response193) do
			end
		end)
		task.delay(1.24, function(...)
			local response197 = __ServerBrowser3:InvokeServer(62)
			for k204, v234 in pairs(response197) do
			end
		end)
		task.delay(1.26, function(...)
			local response201 = __ServerBrowser3:InvokeServer(63)
			for k208, v238 in pairs(response201) do
			end
		end)
		--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
		task.delay(1.28, function(...)
			local response202 = __ServerBrowser3:InvokeServer(64)
			for k209, v239 in pairs(response202) do
			end
		end)
		task.delay(1.3, function(...)
			local response206 = __ServerBrowser3:InvokeServer(65)
			for k213, v243 in pairs(response206) do
			end
		end) -- Leaked by SL | Join https://discord.gg/zNyHGU6eUK for more leaks
		task.delay(1.32, function(...)
			local response210 = __ServerBrowser3:InvokeServer(66)
			for k217, v247 in pairs(response210) do
			end
		end)
		task.delay(1.34, function(...)
			local response211 = __ServerBrowser3:InvokeServer(67)
			for k218, v248 in pairs(response211) do
			end
		end)
		task.delay(1.36, function(...)
			local response215 = __ServerBrowser3:InvokeServer(68)
			for k222, v252 in pairs(response215) do
			end
		end)
		task.delay(1.38, function(...)
			local response219 = __ServerBrowser3:InvokeServer(69)
			for k226, v256 in pairs(response219) do
			end
		end)
		--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
		task.delay(1.4, function(...)
			local response222 = __ServerBrowser3:InvokeServer(70)
			for k229, v259 in pairs(response222) do
			end
		end)
		task.delay(1.42, function(...)
			local response223 = __ServerBrowser3:InvokeServer(71)
			for k230, v260 in pairs(response223) do
			end
		end)
		task.delay(1.44, function(...)
			local response226 = __ServerBrowser3:InvokeServer(72)
			for k233, v263 in pairs(response226) do
			end
		end) -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
		task.delay(1.46, function(...)
			local response231 = __ServerBrowser3:InvokeServer(73)
			for k238, v268 in pairs(response231) do
			end
		end)
		task.delay(1.48, function(...)
			local response232 = __ServerBrowser3:InvokeServer(74)
			for k239, v269 in pairs(response232) do
			end
		end)
		task.delay(1.5, function(...)
			local response236 = __ServerBrowser3:InvokeServer(75)
			for k243, v273 in pairs(response236) do
			end
		end)
		-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
		task.delay(1.52, function(...)
			local response238 = __ServerBrowser3:InvokeServer(76)
			for k245, v275 in pairs(response238) do
			end
		end)
		task.delay(1.54, function(...)
			local response242 = __ServerBrowser3:InvokeServer(77)
			for k249, v279 in pairs(response242) do
			end
		end)
		task.delay(1.56, function(...)
			local response245 = __ServerBrowser3:InvokeServer(78)
			for k252, v282 in pairs(response245) do
			end
		end)
		task.delay(1.58, function(...)
			local response249 = __ServerBrowser3:InvokeServer(79)
			for k256, v286 in pairs(response249) do
			end
		end) --[=[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] ]=]
		task.delay(1.6, function(...)
			local response251 = __ServerBrowser3:InvokeServer(80)
			for k258, v288 in pairs(response251) do
			end
		end)
		task.delay(1.62, function(...)
			local response254 = __ServerBrowser3:InvokeServer(81)
			for k261, v291 in pairs(response254) do
			end
		end)
		-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
		task.delay(1.64, function(...)
			local response258 = __ServerBrowser3:InvokeServer(82)
			for k265, v295 in pairs(response258) do
			end
		end)
		task.delay(1.66, function(...)
			local response261 = __ServerBrowser3:InvokeServer(83)
			for k268, v298 in pairs(response261) do
			end
		end)
		task.delay(1.68, function(...)
			local response263 = __ServerBrowser3:InvokeServer(84)
			for k270, v300 in pairs(response263) do
			end
		end)
		task.delay(1.7, function(...)
			local response267 = __ServerBrowser3:InvokeServer(85)
			for k274, v304 in pairs(response267) do
			end
		end)
		task.delay(1.72, function(...)
			local response268 = __ServerBrowser3:InvokeServer(86)
			for k275, v305 in pairs(response268) do
			end
		end) -- Source Leak (SL) | Join our Discord: https://discord.gg/zNyHGU6eUK
		task.delay(1.74, function(...)
			local response273 = __ServerBrowser3:InvokeServer(87)
			for k280, v310 in pairs(response273) do
			end
		end)
		-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
		task.delay(1.76, function(...)
			local response275 = __ServerBrowser3:InvokeServer(88)
			for k282, v312 in pairs(response275) do
			end
		end)
		task.delay(1.78, function(...)
			local response277 = __ServerBrowser3:InvokeServer(89)
			for k284, v314 in pairs(response277) do
			end
		end)
		task.delay(1.8, function(...)
			local response281 = __ServerBrowser3:InvokeServer(90)
			for k288, v318 in pairs(response281) do
			end
		end)
		task.delay(1.82, function(...)
			local response283 = __ServerBrowser3:InvokeServer(91)
			for k290, v320 in pairs(response283) do
			end
		end)
		task.delay(1.84, function(...)
			local response287 = __ServerBrowser3:InvokeServer(92)
			for k294, v324 in pairs(response287) do
			end
		end)
		task.delay(1.86, function(...)
			local response290 = __ServerBrowser3:InvokeServer(93)
			for k297, v327 in pairs(response290) do
			end
		end) -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
		task.delay(1.88, function(...)
			local response294 = __ServerBrowser3:InvokeServer(94)
			for k301, v331 in pairs(response294) do
			end
		end)
		task.delay(1.9, function(...)
			local response295 = __ServerBrowser3:InvokeServer(95)
			for k302, v332 in pairs(response295) do
			end
		end)
		task.delay(1.92, function(...)
			local response298 = __ServerBrowser3:InvokeServer(96)
			for k305, v335 in pairs(response298) do
			end
		end)
		task.delay(1.94, function(...)
			local response302 = __ServerBrowser3:InvokeServer(97)
			for k309, v339 in pairs(response302) do
			end
		end)
		task.delay(1.96, function(...)
			local response304 = __ServerBrowser3:InvokeServer(98)
			for k311, v341 in pairs(response304) do
			end
		end)
		task.delay(1.98, function(...)
			local response307 = __ServerBrowser3:InvokeServer(99)
			for k314, v344 in pairs(response307) do
			end
		end)
		-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
		task.delay(2, function(...)
			local response310 = __ServerBrowser3:InvokeServer(100)
			for k317, v347 in pairs(response310) do
			end
		end) -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		task.wait()
		task.wait()
	end
})
local Tab3 = Window:AddTab("Shop")
local LeftGroupbox5 = Tab3:AddLeftGroupbox("Melee")
_G.SelectedFightingStyle = false
LeftGroupbox5:AddDropdown("Chọn Fighting Style", {
	Title = "Chọn Fighting Style",
	Default = "Black Leg",
	Multi = false,
	Values = {
		"Black Leg",
		"Death Step",
		"Dragon Claw",
		"Dragon Talon",
		"Electric Claw",
		"Electro",
		"Fishman Karate",
		"Godhuman",
		"Sanguine Art",
		"Sharkman Karate",
		"Superhuman"
	},
	Callback = function(state, arg30)
	-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
		if state then
			SaveConfig()
			_G.SelectedFightingStyle = state
		else
			SaveConfig()
		end
	end
})
_G.SelectedFightingStyle = "Black Leg"
LeftGroupbox5:AddToggle("Auto Buy Fighting Style", {
	Title = "Auto Buy Fighting Style",
	Desc = "Tự động mua style đã chọn",
	Default = false,
	Callback = function(state, arg32)
		if state then
			SaveConfig()
		else
			SaveConfig()
		end
	end
})
local LeftGroupbox6 = Tab3:AddLeftGroupbox("Sword")
LeftGroupbox6:AddButton({
	Title = "Cutlass [ 1,000 Beli ]",
	Callback = function(state, arg34)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")
	end
})
LeftGroupbox6:AddButton({
	Title = "Katana [ 1,000 Beli ]",
	-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
	Callback = function(state, arg36)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Katana")
	end
})
LeftGroupbox6:AddButton({
	Title = "Iron Mace [ 25,000 Beli ]",
	Callback = function(state, arg38)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")
	end
})
LeftGroupbox6:AddButton({
	Title = "Dual Katana [ 12,000 Beli ]",
	Callback = function(state, arg40)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")
	end -- Join SL Discord: https://discord.gg/zNyHGU6eUK
})
LeftGroupbox6:AddButton({
	Title = "Triple Katana [ 60,000 Beli ]",
	Callback = function(state, arg42)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")
	end
})
LeftGroupbox6:AddButton({
	Title = "Pipe [ 100,000 Beli ]",
	Callback = function(state, arg44)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Pipe")
	end
})
LeftGroupbox6:AddButton({
	Title = "Dual-Headed Blade [ 400,000 Beli ]",
	-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
	Callback = function(state, arg46)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")
	end
})
LeftGroupbox6:AddButton({
	Title = "Bisento [ 1,200,000 Beli ]",
	Callback = function(state, arg48)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
	end
})
LeftGroupbox6:AddButton({
	Title = "Soul Cane [ 750,000 Beli ]",
	Callback = function(state, arg50)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")
	end
})
LeftGroupbox6:AddButton({
	Title = "Pole v.2 [ 5,000 Fragments ]",
	Callback = function(state, arg52)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk")
	end
})
local LeftGroupbox7 = Tab3:AddLeftGroupbox("Gun")
LeftGroupbox7:AddButton({
	Title = "Slingshot [ 5,000 Beli ]",
	Callback = function(state, arg54)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Slingshot")
	end
})
LeftGroupbox7:AddButton({
-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
	Title = "Musket [ 8,000 Beli ]",
	Callback = function(state, arg56)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Musket")
	end
})
LeftGroupbox7:AddButton({
	Title = "Flintlock [ 10,500 Beli ]",
	Callback = function(state, arg58)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Flintlock")
	end
})
LeftGroupbox7:AddButton({
	Title = "Refined Slingshot [ 30,000 Beli ]",
	Callback = function(state, arg60)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock")
	end
})
LeftGroupbox7:AddButton({
	Title = "Dual Flintlock [ 65,000 Beli ]",
	Callback = function(state, arg62)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")
	end
})
LeftGroupbox7:AddButton({
	Title = "Cannon [ 100,000 Beli ]",
	Callback = function(state, arg64)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Cannon")
	end
})
LeftGroupbox7:AddButton({
-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
	Title = "Kabucha [ 1,500 Fragments ]",
	Callback = function(state, arg66)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "1")
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2")
	end
})
LeftGroupbox7:AddButton({
	Title = "Bizarre Rifle [ 250 Ectoplasm ]",
	Callback = function(state, arg68)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1)
	end
})
local LeftGroupbox8 = Tab3:AddLeftGroupbox("Abilities Shop")
LeftGroupbox8:AddButton({
	Title = "Skyjump [ 10,000 Beli ]",
	Callback = function(state, arg70)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
	end
})
LeftGroupbox8:AddButton({
	Title = "Buso Haki [ 25,000 Beli ]",
	Callback = function(state, arg72)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
	end
})
LeftGroupbox8:AddButton({
	Title = "Observation Haki [ 750,000 Beli ]",
	Callback = function(state, arg74)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk", "Buy")
		-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
	end
})
LeftGroupbox8:AddButton({
	Title = "Soru [ 100,000 Beli ]",
	Callback = function(state, arg76)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
	end
})
local LeftGroupbox9 = Tab3:AddLeftGroupbox("Misc Shop")
LeftGroupbox9:AddButton({
	Title = "Buy Refund Stat [ 2,500 Fragments ]",
	Callback = function(state, arg78)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
	end
})
LeftGroupbox9:AddButton({
	Title = "Buy Reroll Race [ 3,000 Fragments ]",
	Callback = function(state, arg80)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1")
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
	end
})
LeftGroupbox9:AddButton({
	Title = "Buy Ghoul Race",
	Callback = function(state, arg82)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4)
	end
})
LeftGroupbox9:AddButton({
-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
	Title = "Buy Cyborg Race [ 2,500 Fragments ]",
	Callback = function(state, arg84)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
	end
})
LeftGroupbox9:AddToggle("Buy Drago Race", {
	Title = "Buy Drago Race",
	Desc = "Đổi tộc Tày (Rồng)",
	Default = false,
	Callback = function(state, arg86)
		if state then
			SaveConfig()
		else
			SaveConfig()
		end
	end
})
local Tab4 = Window:AddTab("Farm")
local Tab5 = Window:AddTab("Skill Settings")
local LeftGroupbox10 = Tab5:AddLeftGroupbox("Global Skill Spam")
_G.SelectedGlobalSkillWeapons = { "Melee", "Sword", "Blox Fruit", "Gun" }
_G.SelectedGlobalSkills = { "Z", "X", "C" }
_G.GlobalSkillDelay = 0.1
LeftGroupbox10:AddDropdown("Choose Skill Weapon", {
	Title = "Choose Skill Weapon",
	Default = { "Melee", "Sword", "Blox Fruit", "Gun" },
	Multi = true,
	Values = { "Melee", "Sword", "Blox Fruit", "Gun" },
	Callback = function(state, arg88)
	end
	-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
})
_G.SelectedGlobalSkillWeapons = { "Melee", "Sword", "Blox Fruit", "Gun" }
LeftGroupbox10:AddDropdown("Choose Skills", {
	Title = "Choose Skills",
	Default = { "Z", "X", "C" },
	Multi = true,
	Values = { "Z", "X", "C", "V", "F" },
	Callback = function(state, arg90)
	end
})
_G.SelectedGlobalSkills = { "Z", "X", "C" }
_G.GlobalSkillDelay = 0.1
LeftGroupbox10:AddSlider({
	Title = "Skill Delay (ms)",
	Default = 100,
	Max = 1000,
	Min = 50,
	Callback = function(state, arg92)
		if state then
			SaveConfig("global_skill_delay", math.clamp(tonumber(state), 50, 1000))
		else
			_G.GlobalSkillDelay = (math.clamp(tonumber(state), 50, 1000) / 1000)
			SaveConfig("global_skill_delay", 100)
		end
	end
})
_G.GlobalSkillHold = {}
LeftGroupbox10:AddSlider({
	Title = "Hold Skill Z (ms)",
	Default = 10,
	--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
	Max = 2000,
	Min = 10,
	Callback = function(state, arg94)
		if state then
			SaveConfig("global_skill_hold_z", math.clamp(tonumber(state), 10, 2000))
		else
			SaveConfig("global_skill_hold_z", 10)
		end
	end
})
LeftGroupbox10:AddSlider({
	Title = "Hold Skill X (ms)",
	Default = 10,
	Max = 2000,
	Min = 10,
	Callback = function(state, arg96)
		if state then
			SaveConfig("global_skill_hold_x", math.clamp(tonumber(state), 10, 2000))
		else
			SaveConfig("global_skill_hold_x", 10)
		end
	end
})
LeftGroupbox10:AddSlider({
	Title = "Hold Skill C (ms)",
	Default = 10,
	Max = 2000,
	Min = 10,
	Callback = function(state, arg98)
		if state then
		--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
			SaveConfig("global_skill_hold_c", math.clamp(tonumber(state), 10, 2000))
		else
			SaveConfig("global_skill_hold_c", 10)
		end
	end
})
LeftGroupbox10:AddSlider({
	Title = "Hold Skill V (ms)",
	Default = 10,
	Max = 2000,
	Min = 10,
	Callback = function(state, arg100)
		if state then
			SaveConfig("global_skill_hold_v", math.clamp(tonumber(state), 10, 2000))
		else
			SaveConfig("global_skill_hold_v", 10)
		end
	end
})
LeftGroupbox10:AddSlider({ --[[ Leaked By SL | https://discord.gg/zNyHGU6eUK ]]
	Title = "Hold Skill F (ms)",
	Default = 10,
	Max = 2000,
	Min = 10,
	Callback = function(state, arg102)
		if state then
			SaveConfig("global_skill_hold_f", math.clamp(tonumber(state), 10, 2000))
		else
			SaveConfig("global_skill_hold_f", 10)
		end
		-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
	end
})
local Tab6 = Window:AddTab("Hop Farm")
local LeftGroupbox11 = Tab6:AddLeftGroupbox("Hop Farm")
LeftGroupbox11:AddLabel("Crash, use new hop\nBấm vào đây để copy script hop mới.")
LeftGroupbox11:AddButton({
	Title = "Open Menu Hop Farm",
	Desc = "Mở Menu Hop Farm",
	Callback = function(state, arg104)
		task.spawn(function(...)
			getgenv().RealKidMenuHopOpening = 1700004858.7833042
			ReplicatedStorage:WaitForChild("__ServerBrowser")
			local response4 = game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/redz-V5-remake/main.luau")
			local result3 = loadstring(response4)()
			makefolder("realkid_hop_data")
			makefolder("realkid_hop_data" .. "\\" .. Players.LocalPlayer.Name)
			local Window2 = result3:MakeWindow({ Title = "Light Hub", ScriptFolder = "realkid_hop_data" .. "\\" .. Players.LocalPlayer.Name, SubTitle = "Menu Hop" })
			local Tab7 = Window2:MakeTab({ Title = "Auto Hop" })
			Tab7:AddSection("Auto Hop")
			Tab7:AddDropdown({
	Name = "Select Event",
	Flag = "SelectedAutoHopEvent",
	Options = {
	-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
		"Fruits",
		"Berries",
		"Pink Pig Berry",
		"Red Cherry Berry",
		"White Cloud Berry",
		"Server 4 Hours",
		"Pirate Raid",
		"Haki Colors",
		"Rip Indra",
		"Dough King",
		"Cake Queen",
		"Cake Prince",
		"Elite Hunter",
		"Darkbeard",
		"Cursed Captain",
		"Tyrant of Skies",
		"Soul Reaper",
		"Mirage Island",
		"Kitsune Island",
		"Prehistoric Island",
		"Near Full Moon",
		"Full Moon",
		"Legendary Swords",
		"Factory Raid",
		"Sweet Chalice",
		"Fist of Darkness",
		"God's Chalice"
	},
	Callback = function(state, arg106)
				end -- Leaked by SL | Join https://discord.gg/zNyHGU6eUK for more leaks
				-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
})
			Tab7:AddToggle({
	Name = "Auto Hop Selected Event",
	Default = false,
	Flag = "AutoHopSelectedEvent",
	Callback = function(state, arg108)
					if state then
						task.spawn(function(...)
							task.wait(0.5)
							Window2:Notify({ Title = "Auto Hop", Content = "Chưa chọn sự kiện", Duration = 3 })
						end)
					end
				end
})
			local Tab8 = Window2:MakeTab({ Title = "Fruits" })
			Tab8:AddSection("Săn Trái Hop")
			Tab8:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg110)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded = HttpService:UrlEncode("AllFruits")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded })
						end)
					else
						local encoded2 = HttpService:UrlEncode("AllFruits")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded2 })
							-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
})
			local Tab9 = Window2:MakeTab({ Title = "Berries" })
			Tab9:AddSection("Săn Berry")
			Tab9:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg112)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded3 = HttpService:UrlEncode("Berries")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded3 })
						end)
					else
						local encoded4 = HttpService:UrlEncode("Berries")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded4 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab10 = Window2:MakeTab({ Title = "Server 4 Hours" })
			Tab10:AddSection("Server đủ 4 tiếng")
			-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
			Tab10:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg114)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded5 = HttpService:UrlEncode("Server 4 Hours")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded5 })
						end) --[=[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] ]=]
					else
						local encoded6 = HttpService:UrlEncode("Server 4 Hours")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded6 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab11 = Window2:MakeTab({ Title = "Pirate Raid" })
			Tab11:AddSection("Săn Hải Tặc")
			Tab11:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg116)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded7 = HttpService:UrlEncode("Pirate Raid")
						task.spawn(function(...)
						-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded7 })
						end)
					else
						local encoded8 = HttpService:UrlEncode("Pirate Raid")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded8 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab12 = Window2:MakeTab({ Title = "Haki Colors" })
			Tab12:AddSection("Săn Công Thức Haki Màu")
			Tab12:AddButton({ -- Source Leak (SL) | Join our Discord: https://discord.gg/zNyHGU6eUK
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg118)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded9 = HttpService:UrlEncode("Snow White")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded9 })
						end)
						task.wait()
						local encoded10 = HttpService:UrlEncode("Pure Red")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded10 })
						end)
						task.wait()
						-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
						local encoded11 = HttpService:UrlEncode("Winter Sky")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded11 })
						end)
					else
						local encoded12 = HttpService:UrlEncode("Snow White")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded12 })
						end)
						task.wait()
						local encoded13 = HttpService:UrlEncode("Pure Red")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded13 })
						end)
						task.wait()
						local encoded14 = HttpService:UrlEncode("Winter Sky")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded14 })
						end)
					end -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab13 = Window2:MakeTab({ Title = "Rip Indra" })
			Tab13:AddSection("Rip Indra")
			Tab13:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg120)
	-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded15 = HttpService:UrlEncode("Rip_Indra")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded15 })
						end)
						task.wait()
						local encoded16 = HttpService:UrlEncode("rip_indra")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded16 })
						end)
						task.wait()
						local encoded17 = HttpService:UrlEncode("rip_indra True Form")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded17 })
						end)
					else
						local encoded18 = HttpService:UrlEncode("Rip_Indra")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded18 })
						end)
						task.wait()
						local encoded19 = HttpService:UrlEncode("rip_indra")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded19 })
						end)
						task.wait()
						local encoded20 = HttpService:UrlEncode("rip_indra True Form")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded20 })
							-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab14 = Window2:MakeTab({ Title = "Dough King" })
			Tab14:AddSection("Dough King")
			Tab14:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg122)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded21 = HttpService:UrlEncode("Dough King")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded21 })
						end)
					else
						local encoded22 = HttpService:UrlEncode("Dough King")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded22 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab15 = Window2:MakeTab({ Title = "Cake Queen" })
			Tab15:AddSection("Cake Queen")
			-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
			Tab15:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg124)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded23 = HttpService:UrlEncode("Cake Queen")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded23 })
						end)
					else
						local encoded24 = HttpService:UrlEncode("Cake Queen")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded24 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab16 = Window2:MakeTab({ Title = "Cake Prince" })
			Tab16:AddSection("Cake Prince")
			Tab16:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg126)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded25 = HttpService:UrlEncode("Cake Prince")
						task.spawn(function(...)
						-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded25 })
						end)
					else
						local encoded26 = HttpService:UrlEncode("Cake Prince")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded26 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab17 = Window2:MakeTab({ Title = "Elite Hunter" })
			Tab17:AddSection("Elite Hunter")
			Tab17:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg128)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded27 = HttpService:UrlEncode("Diablo")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded27 })
						end)
						task.wait()
						local encoded28 = HttpService:UrlEncode("Deandre")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded28 })
						end)
						task.wait()
						-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
						local encoded29 = HttpService:UrlEncode("Urban")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded29 })
						end)
					else
						local encoded30 = HttpService:UrlEncode("Diablo")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded30 })
						end)
						task.wait()
						local encoded31 = HttpService:UrlEncode("Deandre")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded31 })
						end)
						task.wait()
						local encoded32 = HttpService:UrlEncode("Urban")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded32 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab18 = Window2:MakeTab({ Title = "Darkbeard" })
			Tab18:AddSection("Darkbeard")
			Tab18:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg130)
	-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded33 = HttpService:UrlEncode("Darkbeard")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded33 })
						end)
					else
						local encoded34 = HttpService:UrlEncode("Darkbeard")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded34 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
})
			local Tab19 = Window2:MakeTab({ Title = "Cursed Captain" })
			Tab19:AddSection("Cursed Captain")
			Tab19:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg132)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded35 = HttpService:UrlEncode("Cursed Captain")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded35 })
						-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
						-- Join SL Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
						end)
					else
						local encoded36 = HttpService:UrlEncode("Cursed Captain")
						--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded36 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab20 = Window2:MakeTab({ Title = "Tyrant of Skies" })
			Tab20:AddSection("Tyrant of the Skies")
			Tab20:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg134)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded37 = HttpService:UrlEncode("Tyrant of the Skies")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded37 })
						end) -- Join SL Discord: https://discord.gg/zNyHGU6eUK
					else
						local encoded38 = HttpService:UrlEncode("Tyrant of the Skies")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded38 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
			local Tab21 = Window2:MakeTab({ Title = "Soul Reaper" })
			Tab21:AddSection("Soul Reaper")
			Tab21:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg136)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded39 = HttpService:UrlEncode("Soul Reaper")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded39 })
						end)
					else
						local encoded40 = HttpService:UrlEncode("Soul Reaper")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded40 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab22 = Window2:MakeTab({ Title = "Mirage Island" })
			Tab22:AddSection("Mirage Island")
			Tab22:AddButton({ --[[ Leaked By SL | https://discord.gg/zNyHGU6eUK ]]
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg138)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
					-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
						local encoded41 = HttpService:UrlEncode("Mirage Island")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded41 })
						end)
						task.wait()
						local encoded42 = HttpService:UrlEncode("MysticIsland")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded42 })
						end)
					else
						local encoded43 = HttpService:UrlEncode("Mirage Island")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded43 })
						end)
						task.wait()
						local encoded44 = HttpService:UrlEncode("MysticIsland")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded44 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab23 = Window2:MakeTab({ Title = "Kitsune Island" })
			Tab23:AddSection("Kitsune Island")
			Tab23:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg140)
	-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded45 = HttpService:UrlEncode("Kitsune Island")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded45 })
						end)
						task.wait()
						local encoded46 = HttpService:UrlEncode("KitsuneIsland")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded46 })
						end)
					else
						local encoded47 = HttpService:UrlEncode("Kitsune Island")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded47 })
						end)
						task.wait()
						local encoded48 = HttpService:UrlEncode("KitsuneIsland")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded48 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab24 = Window2:MakeTab({ Title = "Prehistoric Island" })
			Tab24:AddSection("Prehistoric Island")
			Tab24:AddButton({
	Name = "Làm mới danh sách",
	-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
	Debounce = 5,
	Callback = function(state, arg142)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded49 = HttpService:UrlEncode("Prehistoric Island")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded49 })
						end)
						task.wait()
						local encoded50 = HttpService:UrlEncode("PrehistoricIsland")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded50 })
						end)
					else
						local encoded51 = HttpService:UrlEncode("Prehistoric Island")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded51 })
						end)
						task.wait()
						local encoded52 = HttpService:UrlEncode("PrehistoricIsland")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded52 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab25 = Window2:MakeTab({ Title = "Near Full Moon" })
			Tab25:AddSection("Sắp Trăng Tròn")
			-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
			Tab25:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg144)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded53 = HttpService:UrlEncode("Near Full Moon")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded53 })
						end) -- Leaked by SL | Join https://discord.gg/zNyHGU6eUK for more leaks
					else
						local encoded54 = HttpService:UrlEncode("Near Full Moon")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded54 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab26 = Window2:MakeTab({ Title = "Full Moon" })
			Tab26:AddSection("Đang Trăng Tròn")
			Tab26:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg146)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded55 = HttpService:UrlEncode("Full Moon 5/5")
						task.spawn(function(...)
						-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded55 })
						end)
					else
						local encoded56 = HttpService:UrlEncode("Full Moon 5/5")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded56 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab27 = Window2:MakeTab({ Title = "Legendary Swords" })
			Tab27:AddSection("Legendary Swords (Sea 2)")
			Tab27:AddButton({ -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg148)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded57 = HttpService:UrlEncode("Shizu")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded57 })
						end)
						task.wait()
						local encoded58 = HttpService:UrlEncode("Oroshi")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded58 })
						end)
						task.wait()
						-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
						local encoded59 = HttpService:UrlEncode("Saishi")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded59 })
						end)
					else
						local encoded60 = HttpService:UrlEncode("Shizu")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded60 })
						end)
						task.wait()
						local encoded61 = HttpService:UrlEncode("Oroshi")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded61 })
						end)
						task.wait()
						local encoded62 = HttpService:UrlEncode("Saishi")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded62 })
						end)
					end --[=[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] ]=]
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab28 = Window2:MakeTab({ Title = "Factory Raid" })
			Tab28:AddSection("Săn Nhà Máy")
			Tab28:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg150)
	-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded63 = HttpService:UrlEncode("Core")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded63 })
						end)
						task.wait()
						local encoded64 = HttpService:UrlEncode("Factory Core")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded64 })
						end)
					else
						local encoded65 = HttpService:UrlEncode("Core")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded65 })
						end)
						task.wait()
						local encoded66 = HttpService:UrlEncode("Factory Core")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded66 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end -- Source Leak (SL) | Join our Discord: https://discord.gg/zNyHGU6eUK
})
			local Tab29 = Window2:MakeTab({ Title = "Sweet Chalice" })
			Tab29:AddSection("Sweet Chalice")
			Tab29:AddButton({
	Name = "Làm mới danh sách",
	-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
	Debounce = 5,
	Callback = function(state, arg152)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded67 = HttpService:UrlEncode("Sweet Chalice")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded67 })
						end)
					else
						local encoded68 = HttpService:UrlEncode("Sweet Chalice")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded68 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab30 = Window2:MakeTab({ Title = "Fist of Darkness" })
			Tab30:AddSection("Fist of Darkness")
			Tab30:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg154)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded69 = HttpService:UrlEncode("Fist of Darkness")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded69 })
						end) -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
						-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
					else
						local encoded70 = HttpService:UrlEncode("Fist of Darkness")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded70 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
				end
})
			local Tab31 = Window2:MakeTab({ Title = "God's Chalice" })
			Tab31:AddSection("God's Chalice")
			Tab31:AddButton({
	Name = "Làm mới danh sách",
	Debounce = 5,
	Callback = function(state, arg156)
					Window2:Notify({ Title = "Đang quét", Content = "Đang tải dữ liệu...", Duration = 2 })
					if state then
						local encoded71 = HttpService:UrlEncode("God's Chalice")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded71 })
						end)
					else
						local encoded72 = HttpService:UrlEncode("God's Chalice")
						task.spawn(function(...)
							request({ Method = "GET", Url = "https://realkidapi.online/api.php" .. "?placeId=" .. "0" .. "&target=" .. encoded72 })
						end)
					end
					task.wait()
					Window2:Notify({ Title = "Trống", Content = "Hiện tại không có server nào hoạt động", Duration = 3 })
					-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
				end
})
		end)
	end
})
LeftGroupbox11:AddToggle("Auto Open Menu Hop Farm", {
	Title = "Auto Open Menu Hop Farm",
	Desc = "Tự động mở Menu Hop Farm khi vào game",
	Default = false,
	Callback = function(state, arg158)
		if state then
			SaveConfig("AutoOpenMenuHopFarm", false)
		else
			SaveConfig()
		end
	end
})
local LeftGroupbox12 = Tab4:AddLeftGroupbox("Select tool")
_G.ChooseWP = false
LeftGroupbox12:AddDropdown("Choose Weapon", {
	Title = "Choose Weapon",
	Default = "Melee",
	Multi = false,
	Values = { "Melee", "Blox Fruit", "Sword", "Gun" },
	Callback = function(state, arg160)
		if state then
			SaveConfig("weapon_choice", state)
			_G.ChooseWP = state
		else
			SaveConfig("weapon_choice", false)
			-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
		end
	end
})
_G.ChooseWP = "Melee"
task.spawn(function(...)
	while task.wait(0.3) do
		local children3 = Players.LocalPlayer.Backpack:GetChildren()
		for i4, v4 in ipairs(children3) do
		end
	end -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
end)
_G.FarmHeight = 30
LeftGroupbox12:AddSlider({
	Title = "Độ cao Farm (Melee/Sword)",
	Default = 30,
	Max = 100,
	Min = 10,
	Callback = function(state, arg162)
		if state then
			SaveConfig("farm_height_2", math.clamp(tonumber(state), 10, 100))
			_G.FarmHeight = math.clamp(tonumber(state), 10, 100)
		else
			SaveConfig("farm_height_2", 30)
		end
	end
})
-- Secret Quest controls removed as requested.
local LeftGroupbox14 = Tab4:AddLeftGroupbox("Farm")
local Label6 = LeftGroupbox14:AddLabel("Cake Prince\nKilled: Đang tải...")
task.spawn(function(...)
	while task.wait(0.5) do
		local response7 = ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
		Label6:SetText("Cake Prince" .. "\n" .. "Còn lại: " .. (500 - tonumber(string.match(tostring(response7), "%d+"))) .. " / 500")
	end
end)
local Label7 = LeftGroupbox14:AddLabel("Bones\nBones: Đang tải...")
task.spawn(function(...)
--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
	task.wait(0.2)
	local module2 = require(ReplicatedStorage.ItemReplicationService)
	local module3 = require(ReplicatedStorage.ItemConfig)
	local module4 = require(ReplicatedStorage.ItemReplicationService.KEYS)
	getgenv().RealKidInventoryModules = { Config = module3, Keys = module4, Service = module2 }
	module2:GetItems(module4.IS_OWNED)
	getgenv().RealKidItemMetaCache = {}
	getgenv().RealKidInventoryCache = { ByName = {}, ByType = {}, Items = {}, Materials = {}, Time = 1700004858.9141376 }
	Label7:SetText("Bones\nBones: 0")
	task.wait(0.2)
	Label7:SetText("Bones\nBones: 0")
	task.wait(0.2)
end)
_G.SelectedFarmTarget = false
LeftGroupbox14:AddDropdown("Choose Farm Target", {
	Title = "Choose Farm Target",
	Default = "Auto Level",
	Multi = false,
	Values = { "Auto Level", "Cake Prince", "Bones" },
	Callback = function(state, arg169)
		if state then
			SaveConfig("selected_farm_target", state)
			_G.SelectedFarmTarget = state
		else
			SaveConfig("selected_farm_target", false)
		end
	end
})
_G.SelectedFarmTarget = "Auto Level"
LeftGroupbox14:AddToggle("Auto Farm", {
--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
	Title = "Auto Farm",
	Desc = "Tự động farm mục tiêu đã chọn",
	Default = false,
	Callback = function(state, arg171)
		if state then
			SaveConfig("auto_farm_general", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox14:AddToggle("Ignore Cake Prince", {
	Title = "Ignore Cake Prince",
	Desc = "Bỏ qua Cake Prince khi farm",
	Default = false,
	Callback = function(state, arg173)
		if state then
			SaveConfig("ignore_cake_prince", false)
		else
			SaveConfig()
		end
	end
})
task.spawn(function(...)
	local Remotes2 = ReplicatedStorage:WaitForChild("Remotes")
	Remotes2:WaitForChild("CommF_")
	workspace:WaitForChild("Enemies")
	workspace:WaitForChild("Map")
	task.wait(0.3)
	task.wait(0.3)
	-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
end)
LeftGroupbox14:AddToggle("Accept Quests", {
	Title = "Accept Quests",
	Desc = "Chấp nhận nhiệm vụ",
	Default = false,
	Callback = function(state, arg175)
		if state then
			SaveConfig("accept_quests", false)
		else
			SaveConfig()
		end
	end
})
_G.FindBoss = false
LeftGroupbox14:AddDropdown("Choose Boss", {
	Title = "Choose Boss",
	Default = "",
	Multi = false,
	Values = {},
	Callback = function(state, arg177)
		if state then
			SaveConfig("Select_Boss_Farm", state)
			_G.FindBoss = state
		else
			SaveConfig("Select_Boss_Farm", false)
		end
	end
})
_G.FindBoss = ""
local Label8 = LeftGroupbox14:AddLabel("Boss Status\nChưa chọn Boss")
-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
LeftGroupbox14:AddToggle("Auto Accept Quest", {
	Title = "Auto Accept Quest",
	Desc = "Tự động nhận nhiệm vụ từ NPC trước khi đánh",
	Default = false,
	Callback = function(state, arg179)
		if state then
			SaveConfig("AutoQuestBoss", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox14:AddToggle("Auto Farm Boss", {
	Title = "Auto Farm Boss",
	Desc = "Tự động dịch chuyển và tiêu diệt Boss",
	Default = false,
	Callback = function(state, arg181)
		if state then
			SaveConfig("AutoBossToggle", false)
		else
			SaveConfig()
		end
	end
})
task.spawn(function(...)
	task.wait(1)
	Label8:SetText("Boss Status\nChưa chọn Boss")
	task.wait(1)
end)
local LeftGroupbox15 = Tab4:AddLeftGroupbox("Miscellanea / Quest")
-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
_G.AutoFarmNearRange = 500
LeftGroupbox15:AddSlider({
	Title = "Farm Around Range",
	Default = 500,
	Max = 2000,
	Min = 50,
	Callback = function(state, arg183)
		if state then
			SaveConfig("auto_farm_nearest_range", math.clamp(tonumber(state), 50, 2000))
			_G.AutoFarmNearRange = tonumber(math.clamp(tonumber(state), 50, 2000))
		else
			SaveConfig("auto_farm_nearest_range", 500)
		end
	end
})
LeftGroupbox15:AddToggle("Auto Farm Nearest", {
	Title = "Auto Farm Nearest",
	Desc = "Farm Xung Quanh",
	Default = false,
	Callback = function(state, arg185)
		if state then
			SaveConfig("auto_farm_nearest", false)
		else
			SaveConfig()
		end
	end
})
getgenv().SelectMaterial = false
LeftGroupbox15:AddDropdown("Choose Material", {
	Title = "Choose Material",
	-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
	Multi = false,
	Values = {},
	Callback = function(state, arg187)
		if state then
			SaveConfig("material_choice", state)
			getgenv().SelectMaterial = state
		else
			SaveConfig("material_choice", false)
		end
	end
})
LeftGroupbox15:AddToggle("Auto Materials", {
	Title = "Auto Materials",
	Desc = "Farm Nguyên Liệu",
	Default = false,
	Callback = function(state, arg189)
		if state then
			SaveConfig("auto_farm_materials", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox15:AddToggle("Auto Training Dummy", {
	Title = "Auto Training Dummy",
	Desc = "Huấn Luyện Hình Nộm",
	Default = false,
	Callback = function(state, arg191)
		if state then
			SaveConfig("auto_training_dummy", false)
			-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
		else
			SaveConfig()
		end
	end
})
LeftGroupbox15:AddToggle("Auto Collect Berry", {
	Title = "Auto Collect Berry",
	Desc = "Thu thập tất cả Berry trên Map",
	Default = false,
	Callback = function(state, arg193)
		if state then
			SaveConfig("Berry", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox15:AddToggle("Auto Hop Find Berry", {
	Title = "Auto Hop Find Berry",
	Desc = "Đổi Server khi hết Berry",
	Default = false,
	Callback = function(state, arg195)
		if state then
			SaveConfig("HopBerry", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox15:AddToggle("Auto Collect Chest", {
-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
	Title = "Auto Collect Chest",
	Desc = "Nhặt Rương (AN TOÀN)",
	Default = false,
	Callback = function(state, arg197)
		if state then
			SaveConfig("Chest", false)
		else
			SaveConfig()
		end
	end
})
getgenv().MaxChestHop = 45
LeftGroupbox15:AddSlider({
	Title = "Chest Limit to Hop",
	Default = 45,
	Max = 72,
	Min = 1,
	Callback = function(state, arg199)
		if state then
			SaveConfig("MaxChestHop", math.clamp(tonumber(state), 1, 72))
			getgenv().MaxChestHop = math.clamp(tonumber(state), 1, 72)
		else
			SaveConfig("MaxChestHop", 45)
		end
	end -- Join SL Discord: https://discord.gg/zNyHGU6eUK
})
LeftGroupbox15:AddToggle("Auto Hop Server", {
	Title = "Auto Hop Server",
	Desc = "Bật để tự đổi Server khi nhặt đủ số lượng rương",
	Default = false,
	-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
	Callback = function(state, arg201)
		if state then
			SaveConfig("AutoHopChest", false)
		else
			SaveConfig()
		end
	end
})
task.spawn(function(...)
	task.wait(0.3)
	Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice")
	task.wait(0.3)
end)
local LeftGroupbox16 = Tab4:AddLeftGroupbox("Miscellanea / Mastery")
_G.MasteryHealthPercent = 30
LeftGroupbox16:AddSlider({
	Title = "Choose Health Percent",
	Default = 30,
	Max = 100,
	Min = 10,
	Callback = function(state, arg203)
		if state then
			SaveConfig("mastery_health_percent", math.clamp(tonumber(state), 10, 100))
			_G.MasteryHealthPercent = math.clamp(tonumber(state), 10, 100)
		else
			SaveConfig("mastery_health_percent", 30)
		end
	end
})
LeftGroupbox16:AddToggle("Auto Mastery Fruits", {
-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
	Title = "Auto Mastery Fruits",
	Desc = "Cày thông thạo trái",
	Default = false,
	Callback = function(state, arg205)
		if state then
			SaveConfig("auto_mastery_fruits", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox16:AddToggle("Auto Mastery Gun", {
	Title = "Auto Mastery Gun",
	Desc = "Cày thông thạo súng",
	Default = false,
	Callback = function(state, arg207)
		if state then
			SaveConfig("FarmMastery_G", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox16:AddToggle("Auto Mastery All Sword", {
	Title = "Auto Mastery All Sword",
	Desc = "Cày thông thạo tất cả kiểm",
	Default = false,
	Callback = function(state, arg209)
		if state then
			SaveConfig("MasterySword", false)
			-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
		else
			SaveConfig()
		end
	end
})
Tab4:AddLeftGroupbox("Generals Quests / Items")
local LeftGroupbox17 = Tab4:AddLeftGroupbox("Buso/Aura Colours")
LeftGroupbox17:AddToggle("Auto Teleport Barista Cousin", {
	Title = "Auto Teleport Barista Cousin",
	Desc = "Teleport Barista Cousin",
	Default = false,
	Callback = function(state, arg211)
		if state then
			SaveConfig("AutoTeleportBarista", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox17:AddButton({
	Title = "Buy Buso Haki Recipes",
	Desc = "Mua haki màu từ Barista Cousin",
	Callback = function(state, arg213)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
	end
})
LeftGroupbox17:AddToggle("Auto Buy Haki Recipes", {
	Title = "Auto Buy Haki Recipes",
	Desc = "Tự mua công thức haki từ Barista Cousin",
	Default = false,
	-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
	Callback = function(state, arg215)
		if state then
			SaveConfig("AutoBuyHakiRecipes", false)
		else
			SaveConfig()
		end
	end
})
local LeftGroupbox18 = Tab4:AddLeftGroupbox("Instinct / Observation")
local Label9 = LeftGroupbox18:AddLabel("Observation\nĐiểm né hiện tại: Đang tải...")
task.spawn(function(...)
	while task.wait(3) do
		local response9 = ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk", "Status")
		Label9:SetText("Observation" .. "\n" .. "Điểm né hiện tại: " .. tonumber(string.match(tostring(response9), "%d+")))
	end
end)
LeftGroupbox18:AddToggle("Auto Farm Observation", {
	Title = "Auto Farm Observation",
	Desc = "Tự động farm haki quan sát",
	Default = false,
	Callback = function(state, arg217)
		if state then
			SaveConfig("AutoFarmObservation", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox18:AddToggle("Auto Farm Observation Hop", {
	Title = "Auto Farm Observation Hop",
	-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
	Desc = "Tự động chuyển server khi hết đòn né",
	Default = false,
	Callback = function(state, arg219)
		if state then
			SaveConfig("AutoFarmObservationHop", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox18:AddToggle("Auto Observation V2", {
	Title = "Auto Observation V2",
	Desc = "Tự động farm haki quan sát (V2)",
	Default = false,
	Callback = function(state, arg221)
		if state then
			SaveConfig("AutoObservationV2", false)
		else
			SaveConfig()
		end
	end
})
local Tab32 = Window:AddTab("Stack Farming")
local LeftGroupbox19 = Tab32:AddLeftGroupbox("Quest Farming")
LeftGroupbox19:AddToggle("Auto Travel Dressrosa", {
	Title = "Auto Travel Dressrosa",
	Desc = "Tự động lên sea 2 (yêu cầu level 700)",
	Default = false,
	Callback = function(state, arg223)
		if state then
		-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
			SaveConfig("auto_travel_dressrosa", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox19:AddToggle("Auto Zou Quest", {
	Title = "Auto Zou Quest",
	Desc = "Tự động lên sea 3 (yêu cầu level 1500)",
	Default = false,
	Callback = function(state, arg225)
		if state then
			SaveConfig("auto_zou_quest", false)
		else
			SaveConfig()
		end
	end
})
local LeftGroupbox20 = Tab32:AddLeftGroupbox("Multi Farm")
local Label10 = LeftGroupbox20:AddLabel("Elites Process\nĐang tải tiến độ...")
task.spawn(function(...)
	while task.wait(1) do
		local response11 = ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
		Label10:SetText("Elites Process" .. "\n" .. "Tiến độ Elite: " .. tostring(response11))
	end
end)
LeftGroupbox20:AddToggle("Auto Elite Quest", {
	Title = "Auto Elite Quest",
	Desc = "Auto Farm Elite Hunter",
	Default = false,
	-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
	Callback = function(state, arg227)
		if state then
			SaveConfig("AutoEliteQuest", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox20:AddToggle("Auto Dough King", {
	Title = "Auto Dough King",
	Desc = "Farm Vua Bột",
	Default = false,
	Callback = function(state, arg229)
		if state then
			SaveConfig("AutoMirror", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox20:AddToggle("Auto Darkbeard", {
	Title = "Auto Darkbeard",
	Desc = "Tự động đánh Darkbeard",
	Default = false,
	Callback = function(state, arg231)
		if state then
			SaveConfig("AutoStackDarkbeard", false)
		else
			SaveConfig()
		end
		--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
	end
})
LeftGroupbox20:AddToggle("Auto Farm Rip_indra", {
	Title = "Auto Farm Rip_indra",
	Desc = "Tự động đánh Rip_indra",
	Default = false,
	Callback = function(state, arg233)
		if state then
			SaveConfig("AutoValkyrie", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox20:AddToggle("Auto Craft Item Shark Anchor", {
	Title = "Auto Craft Item Shark Anchor",
	Desc = "Tự động tạo item Shark Anchor",
	Default = false,
	Callback = function(state, arg235)
	end
})
task.spawn(function(...)
end)
LeftGroupbox20:AddToggle("Auto Factory Raid", {
	Title = "Auto Factory Raid",
	Desc = "Đánh Nhà Máy tự động",
	Default = false,
	Callback = function(state, arg237)
		if state then
			SaveConfig("auto_factory_raid", false)
			--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
		else
			SaveConfig()
		end
	end
})
local Tab33 = Window:AddTab("PVP")
local LeftGroupbox21 = Tab33:AddLeftGroupbox("Combat / Aimbot")
local Label11 = LeftGroupbox21:AddLabel("All Players On Server :\n")
task.spawn(function(...)
	task.wait(0.3)
	local players = Players:GetPlayers()
	for k4, v10 in pairs(players) do
		Label11:SetText("All Players On Server :" .. "\n" .. "All Players  :" .. " " .. k4 .. " / 12")
	end
	task.wait(0.3)
	local players2 = Players:GetPlayers()
	for k5, v11 in pairs(players2) do
		Label11:SetText("All Players On Server :" .. "\n" .. "All Players  :" .. " " .. k5 .. " / 12")
	end
	task.wait(0.3)
end)
local Label12 = LeftGroupbox21:AddLabel("Aimbot Status :\n")
task.spawn(function(...)
	while task.wait(0.2) do
		Label12:SetText("Aimbot Status :\nAimbot - Skills : False")
	end
end)
local children5 = Players:GetChildren()
for k7, v13 in pairs(children5) do
end
-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
_G.PlayersList = false
local Dropdown = LeftGroupbox21:AddDropdown("Choose Players", {
	Title = "Choose Players",
	Multi = false,
	Values = { v13.Name }, --[[ Leaked By SL | https://discord.gg/zNyHGU6eUK ]]
	Callback = function(state, arg239)
		if state then
			SaveConfig("SelectPlayer", state)
			_G.PlayersList = state
		else
			SaveConfig("SelectPlayer", false)
		end
	end
})
LeftGroupbox21:AddButton({
	Title = "Refresh Players",
	Desc = "Làm mới danh sách người chơi",
	Callback = function(state, arg241)
		if state then
			local players3 = Players:GetPlayers()
			for k8, v14 in pairs(players3) do
			end
			Dropdown:GetNewList({ v14.Name })
		else
			local players4 = Players:GetPlayers()
			for k9, v15 in pairs(players4) do
			end
			Dropdown:GetNewList({ v15.Name })
		end
	end
	-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
})
LeftGroupbox21:AddToggle("Teleport to choose players", {
	Title = "Teleport to choose players",
	Desc = "Bay đến người chơi đã chọn",
	Default = false,
	Callback = function(state, arg243)
		if state then
			SaveConfig("TeleportToPlayer", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox21:AddToggle("Spectate Choose Players", {
	Title = "Spectate Choose Players",
	Desc = "Rình tắm người chơi đã chọn",
	Default = false,
	Callback = function(state, arg245)
		if state then
			SaveConfig("SpectatePlayer", false)
		else
			SaveConfig()
		end
	end
})
local ScreenGui3 = Instance.new("ScreenGui")
ScreenGui3.Name = "RealKidPvPAimCircle"
ScreenGui3.IgnoreGuiInset = true
ScreenGui3.ResetOnSpawn = false
ScreenGui3.DisplayOrder = 100
-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui3.Parent = PlayerGui
local Frame5 = Instance.new("Frame")
Frame5.Name = "AimCircle"
Frame5.AnchorPoint = Vector2.new(0.5, 0.5)
Frame5.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame5.BackgroundTransparency = 1
Frame5.BorderSizePixel = 0
Frame5.Visible = false
Frame5.Parent = ScreenGui3
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.5, 0)
UICorner.Parent = Frame5
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.new(0, 0.66666668653488159, 1)
UIStroke.Thickness = 2
UIStroke.Parent = Frame5
Frame5.Size = UDim2.fromOffset(300, 300)
LeftGroupbox21:AddSlider({
	Title = "Bán kính vòng aim PvP (px)",
	Default = 150,
	Max = 500,
	Min = 50,
	Callback = function(state, arg247)
		if state then
			SaveConfig("PvPAimRadius", math.clamp(tonumber(state), 50, 500))
			Frame5.Size = UDim2.fromOffset((math.clamp(tonumber(state), 50, 500) * 2), (math.clamp(tonumber(state), 50, 500) * 2))
		else
			SaveConfig("PvPAimRadius", 150)
			Frame5.Size = UDim2.fromOffset(300, 300)
			-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
		end
	end
})
task.spawn(function(...)
	SaveConfig()
	Frame5.Size = UDim2.fromOffset(300, 300)
end)
LeftGroupbox21:AddToggle("Aimbot Skills", {
	Title = "Aimbot Skills",
	Desc = "Bật Aim Bot Skills",
	Default = false,
	Callback = function(state, arg249)
	end
})
task.spawn(function(...)
end)
require(ReplicatedStorage.Mouse)
RunService.RenderStepped:Connect(function(deltaTime3)
	Frame5.Visible = false
end) -- Leaked by SL | Join https://discord.gg/zNyHGU6eUK for more leaks
task.spawn(function(...)
	task.wait()
	Frame5.Visible = false
	task.wait()
end)
getgenv().WalkSpeed = 16
getgenv().JumpPower = 50
LeftGroupbox21:AddToggle("Change Speed", {
	Title = "Change Speed",
	Desc = "Thay đổi tốc độ di chuyển",
	-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
	Default = false,
	Callback = function(state, arg251)
		if state then
			SaveConfig("WalkSpeed", false)
		else
			SaveConfig()
		end
	end
})
getgenv().WalkSpeed = 100
LeftGroupbox21:AddSlider({
	Title = "Speed",
	Default = 100,
	Max = 250,
	Min = 100,
	Callback = function(state, arg253)
		if state then
			SaveConfig("WalkSpeedSliderV2", math.clamp(tonumber(state), 100, 250))
		else
			getgenv().WalkSpeed = math.clamp(tonumber(state), 100, 250)
			SaveConfig("WalkSpeedSliderV2", 100)
		end
	end
})
LeftGroupbox21:AddToggle("Change Jump Power", {
	Title = "Change Jump Power",
	Desc = "Bật/tắt nhảy cao",
	Default = false,
	Callback = function(state, arg255)
		if state then
		-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
			do --[[ Leaked By SL | Join https://discord.gg/zNyHGU6eUK ]]
				local _sl = ("SL Source Leak | " .. "https://discord.gg/zNy" .. "HGU6eUK")
			end
			SaveConfig("JumpPower", false)
		else
			SaveConfig()
		end
	end
})
getgenv().JumpPower = 50
LeftGroupbox21:AddSlider({
	Title = "Jump Power",
	Default = 50,
	Max = 250,
	Min = 50,
	Callback = function(state, arg257)
		if state then
			SaveConfig("JumpPowerSliderV2", math.clamp(tonumber(state), 50, 250))
		else
			getgenv().JumpPower = math.clamp(tonumber(state), 50, 250)
			SaveConfig("JumpPowerSliderV2", 50)
		end
	end
})
LeftGroupbox21:AddToggle("Walk On Water", {
	Title = "Walk On Water",
	Desc = "Đi trên nước",
	Default = true,
	Callback = function(state, arg259)
	end
})
task.spawn(function(...)
end) -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
local Tab34 = Window:AddTab("Fishing/Slap Fish")
local Modules2 = ReplicatedStorage:WaitForChild("Modules")
local Net2 = Modules2:WaitForChild("Net")
local FishReplicated = ReplicatedStorage:WaitForChild("FishReplicated")
FishReplicated:FindFirstChild("FishingRequest")
local FishingClient = FishReplicated:WaitForChild("FishingClient")
local Config = FishingClient:WaitForChild("Config")
require(Config)
local Util = ReplicatedStorage:WaitForChild("Util")
local GetWaterHeightAtLocation = Util:WaitForChild("GetWaterHeightAtLocation")
require(GetWaterHeightAtLocation)
Net2:FindFirstChild("RF/JobsRemoteFunction")
Net2:FindFirstChild("RF/Craft")
task.spawn(function(...)
	local module5 = require(Net2)
	local result4 = module5:RemoteEvent("FishingRemote", true)
	result4.OnClientEvent:Connect(function(arg260)
	end)
end)
_G.SelectedRod = "Fishing Rod"
_G.SelectedBait = "Basic Bait"
local LeftGroupbox22 = Tab34:AddLeftGroupbox("Câu Cá/Fishing Không hoạt ảnh")
_G.SelectedRod = "false"
LeftGroupbox22:AddDropdown("Chọn Cần Câu", {
	Title = "Chọn Cần Câu",
	Default = "Fishing Rod",
	Multi = false,
	Values = { "Fishing Rod", "Gold Rod", "Shark Rod", "Shell Rod", "Treasure Rod" },
	Callback = function(state, arg262)
		if state then
		-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
			SaveConfig("RodSelection", state)
		else
			_G.SelectedRod = tostring(state)
			SaveConfig("RodSelection", false)
		end --[=[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] ]=]
	end
})
_G.SelectedRod = "Fishing Rod"
_G.SelectedBait = "false"
LeftGroupbox22:AddDropdown("Chọn Mồi Câu", {
	Title = "Chọn Mồi Câu",
	Default = "Basic Bait",
	Multi = false,
	Values = {
		"Basic Bait",
		"Kelp Bait",
		"Good Bait",
		"Abyssal Bait",
		"Frozen Bait",
		"Epic Bait",
		"Carnivore Bait"
	},
	Callback = function(state, arg264)
		if state then
			SaveConfig("BaitSelection", state)
		else
			_G.SelectedBait = tostring(state)
			SaveConfig("BaitSelection", false)
		end
	end
	-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
})
_G.SelectedBait = "Basic Bait"
LeftGroupbox22:AddToggle("Auto Z Skill", {
	Title = "Auto Z Skill",
	Desc = "Tự động dùng chiêu Z",
	Default = false,
	Callback = function(state, arg266)
	end
})
task.spawn(function(...)
end)
task.spawn(function(...)
	Net2:WaitForChild("RF/JobToolAbilities")
	task.wait(0.1)
	task.wait(0.1)
end)
LeftGroupbox22:AddToggle("Auto Fishing Quest", {
	Title = "Auto Fishing Quest",
	Desc = "Tự nhận quest câu cá",
	Default = false,
	Callback = function(state, arg268)
	end
})
task.spawn(function(...)
end)
LeftGroupbox22:AddToggle("Auto Sell Fish", {
	Title = "Auto Sell Fish",
	Desc = "Tự động bán cá mỗi 5 giây",
	Default = false,
	Callback = function(state, arg270)
	-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
		if state then
			SaveConfig("AutoSellFish", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox22:AddToggle("Auto Tween To Event Fishing Spot", {
	Title = "Auto Tween To Event Fishing Spot",
	Desc = "Tự bay đến Golden Vortex để câu rương event",
	Default = false,
	Callback = function(state, arg272)
		if state then
			SaveConfig("AutoTweenEventFishingSpot", false)
		else -- Source Leak (SL) | Join our Discord: https://discord.gg/zNyHGU6eUK
			SaveConfig()
		end
	end
})
LeftGroupbox22:AddToggle("Tự Động Câu Cá", {
	Title = "Tự Động Câu Cá",
	Desc = "Tự động thực hiện câu cá",
	Default = false,
	Callback = function(state, arg274)
	end
})
task.spawn(function(...)
end)
local LeftGroupbox23 = Tab34:AddLeftGroupbox("Vả Cá/Slap Fish Event")
LeftGroupbox23:AddToggle("Auto Teleport to Sharkman Master", {
-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
	Title = "Auto Teleport to Sharkman Master",
	Desc = "Tự động bay đến vị trí NPC Sharkman Master",
	Default = false,
	Callback = function(state, arg276)
		if state then
			SaveConfig("GoToSharkmanNPC", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox23:AddToggle("Auto Slap Fish", {
	Title = "Auto Slap Fish",
	Desc = "Tự Động Vả Cá",
	Default = false,
	Callback = function(state, arg278)
		if state then
			SaveConfig("AutoSlapDodgeAABB", false)
		else
			SaveConfig()
		end
	end
})
local connection7 = RunService.RenderStepped:Connect(function(deltaTime4)
end)
_G.SlapDodgeConnection = connection7
task.spawn(function(...)
	task.wait(0.15)
	local tagged = CollectionService:GetTagged("BerryBush")
	for i7, v16 in ipairs(tagged) do
	-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
		local attributes = v16:GetAttributes()
		for k10, v17 in pairs(attributes) do
		end
	end
	local players5 = Players:GetPlayers()
	Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	for i8, v18 in ipairs(players5) do
		v18.Character:FindFirstChild("Head")
		v18.Character:FindFirstChildOfClass("Humanoid")
		local Data2 = v18:FindFirstChild("Data")
		Data2:FindFirstChild("Level")
		local tagged2 = CollectionService:GetTagged("_ChestTagged")
		Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		for i9, v19 in ipairs(tagged2) do
			v19:GetAttribute("IsDisabled")
		end
		workspace:GetChildren()
		Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local _WorldOrigin3 = workspace:FindFirstChild("_WorldOrigin")
		local Locations3 = _WorldOrigin3:FindFirstChild("Locations")
		local children6 = Locations3:GetChildren()
		local HumanoidRootPart = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		for i10, v20 in ipairs(children6) do
			local BillboardGui = Instance.new("BillboardGui")
			BillboardGui.Name = "RK_Island"
			BillboardGui.Adornee = v20
			BillboardGui.AlwaysOnTop = true
			BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
			BillboardGui.Size = UDim2.new(0, 200, 0, 34)
			local TextLabel = Instance.new("TextLabel")
			-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
			TextLabel.Name = "Label"
			TextLabel.BackgroundTransparency = 1
			TextLabel.Font = Enum.Font.Code
			TextLabel.Size = UDim2.new(1, 0, 1, 0)
			TextLabel.TextSize = 14
			TextLabel.TextStrokeTransparency = 0.5
			TextLabel.TextWrapped = true
			TextLabel.TextYAlignment = Enum.TextYAlignment.Top
			TextLabel.Parent = BillboardGui
			BillboardGui.Parent = v20
			BillboardGui.Label.Text = string.format("%s\n%d M", v20.Name, math.floor((((HumanoidRootPart.Position - v20.Position).Magnitude / 3) + 0.5)))
			BillboardGui.Label.TextColor3 = Color3.new(0.31372550129890442, 0.96078431606292725, 0.96078431606292725)
		end
		workspace:GetChildren()
		Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local NPCs = ReplicatedStorage:FindFirstChild("NPCs")
		local LegendarySwordDealer = NPCs:FindFirstChild("Legendary Sword Dealer")
		local HumanoidRootPart2 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local HumanoidRootPart3 = LegendarySwordDealer:FindFirstChild("HumanoidRootPart")
		local BillboardGui2 = Instance.new("BillboardGui")
		BillboardGui2.Name = "RK_SwordDealer"
		BillboardGui2.Adornee = HumanoidRootPart3
		BillboardGui2.AlwaysOnTop = true
		BillboardGui2.ExtentsOffset = Vector3.new(0, 1, 0)
		BillboardGui2.Size = UDim2.new(0, 200, 0, 34)
		local TextLabel2 = Instance.new("TextLabel")
		TextLabel2.Name = "Label"
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.Font = Enum.Font.Code
		TextLabel2.Size = UDim2.new(1, 0, 1, 0)
		--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
		TextLabel2.TextSize = 14
		TextLabel2.TextStrokeTransparency = 0.5
		TextLabel2.TextWrapped = true
		TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel2.Parent = BillboardGui2
		BillboardGui2.Parent = HumanoidRootPart3
		BillboardGui2.Label.Text = string.format("%s\n%d M", LegendarySwordDealer.Name, math.floor((((HumanoidRootPart2.Position - HumanoidRootPart3.Position).Magnitude / 3) + 0.5)))
		BillboardGui2.Label.TextColor3 = Color3.new(0.31372550129890442, 0.96078431606292725, 0.96078431606292725)
		local NPCs2 = ReplicatedStorage:FindFirstChild("NPCs")
		local BaristaCousin = NPCs2:FindFirstChild("Barista Cousin")
		local HumanoidRootPart4 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local HumanoidRootPart5 = BaristaCousin:FindFirstChild("HumanoidRootPart")
		local BillboardGui3 = Instance.new("BillboardGui")
		BillboardGui3.Name = "RK_AuraDealer"
		BillboardGui3.Adornee = HumanoidRootPart5
		BillboardGui3.AlwaysOnTop = true
		BillboardGui3.ExtentsOffset = Vector3.new(0, 1, 0)
		BillboardGui3.Size = UDim2.new(0, 200, 0, 34)
		local TextLabel3 = Instance.new("TextLabel")
		TextLabel3.Name = "Label"
		TextLabel3.BackgroundTransparency = 1
		TextLabel3.Font = Enum.Font.Code
		TextLabel3.Size = UDim2.new(1, 0, 1, 0)
		TextLabel3.TextSize = 14
		TextLabel3.TextStrokeTransparency = 0.5
		TextLabel3.TextWrapped = true
		TextLabel3.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel3.Parent = BillboardGui3
		BillboardGui3.Parent = HumanoidRootPart5
		BillboardGui3.Label.Text = string.format("%s\n%d M", BaristaCousin.Name, math.floor((((HumanoidRootPart4.Position - HumanoidRootPart5.Position).Magnitude / 3) + 0.5)))
		--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
		BillboardGui3.Label.TextColor3 = Color3.new(0.31372550129890442, 0.96078431606292725, 0.96078431606292725)
		local Map = workspace:FindFirstChild("Map")
		local MysticIsland = Map:FindFirstChild("MysticIsland")
		local descendants = MysticIsland:GetDescendants()
		Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		for i11, v21 in ipairs(descendants) do
		end
		local _WorldOrigin4 = workspace:FindFirstChild("_WorldOrigin")
		local Locations4 = _WorldOrigin4:FindFirstChild("Locations")
		local children7 = Locations4:GetChildren()
		Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		for i12, v22 in ipairs(children7) do
		end
		local NPCs3 = ReplicatedStorage:FindFirstChild("NPCs")
		local AdvancedFruitDealer = NPCs3:FindFirstChild("Advanced Fruit Dealer")
		local HumanoidRootPart6 = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local HumanoidRootPart7 = AdvancedFruitDealer:FindFirstChild("HumanoidRootPart")
		local BillboardGui4 = Instance.new("BillboardGui")
		BillboardGui4.Name = "RK_AdvancedDealer"
		BillboardGui4.Adornee = HumanoidRootPart7
		BillboardGui4.AlwaysOnTop = true
		BillboardGui4.ExtentsOffset = Vector3.new(0, 1, 0)
		BillboardGui4.Size = UDim2.new(0, 200, 0, 34)
		local TextLabel4 = Instance.new("TextLabel")
		TextLabel4.Name = "Label"
		TextLabel4.BackgroundTransparency = 1
		TextLabel4.Font = Enum.Font.Code
		TextLabel4.Size = UDim2.new(1, 0, 1, 0)
		TextLabel4.TextSize = 14
		TextLabel4.TextStrokeTransparency = 0.5
		-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
		TextLabel4.TextWrapped = true
		TextLabel4.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel4.Parent = BillboardGui4
		BillboardGui4.Parent = HumanoidRootPart7
		BillboardGui4.Label.Text = string.format("%s\n%d M", AdvancedFruitDealer.Name, math.floor((((HumanoidRootPart6.Position - HumanoidRootPart7.Position).Magnitude / 3) + 0.5)))
		BillboardGui4.Label.TextColor3 = Color3.new(0.31372550129890442, 0.96078431606292725, 0.96078431606292725)
		task.wait(0.15)
		task.wait(0.15)
	end
end) -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
local Tab35 = Window:AddTab("Esp")
local LeftGroupbox24 = Tab35:AddLeftGroupbox("ESP/Định Vị")
LeftGroupbox24:AddToggle("Esp Berries", {
	Title = "Esp Berries",
	Desc = "Hiển thị vị trí Berries trên bản đồ",
	Default = false,
	Callback = function(state, arg280)
		if state then
			SaveConfig("EspBerries", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox24:AddToggle("Esp Players", {
	Title = "Esp Players",
	Desc = "Hiển thị vị trí người chơi",
	Default = false,
	Callback = function(state, arg282)
		if state then
		-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
			SaveConfig("EspPlayers", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox24:AddToggle("Esp Chests", {
	Title = "Esp Chests",
	Desc = "Hiển thị vị trí rương",
	Default = false,
	Callback = function(state, arg284)
		if state then
			SaveConfig("EspChests", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox24:AddToggle("Esp Fruits", {
	Title = "Esp Fruits",
	Desc = "Hiển thị vị trí Trái Ác Quỷ trên bản đồ",
	Default = false,
	Callback = function(state, arg286)
		if state then
			SaveConfig("EspFruits", false)
		else
			SaveConfig()
		end
	end
})
-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
LeftGroupbox24:AddToggle("Esp Island Location", {
	Title = "Esp Island Location",
	Desc = "Hiển thị vị trí các hòn đảo",
	Default = false,
	Callback = function(state, arg288)
		if state then
			SaveConfig("EspIslandLocation", false)
		else
			SaveConfig()
		end
	end
})
local Tab36 = Window:AddTab("Quest And Item")
local LeftGroupbox25 = Tab36:AddLeftGroupbox("Skull Guitar and Misc")
local Label13 = LeftGroupbox25:AddLabel("Skull Guitar Quests\n")
task.spawn(function(...)
	while task.wait(0.2) do
		Players.LocalPlayer.Backpack:FindFirstChild("Skull Guitar")
		Label13:SetText("Skull Guitar Quests\nQuest Number: Collect!!")
	end -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
end)
LeftGroupbox25:AddToggle("Auto Skull Guitar", {
	Title = "Auto Skull Guitar",
	Desc = "Tự động lấy đàn",
	Default = false,
	Callback = function(state, arg290)
		if state then
			SaveConfig("AutoSkullGuitar", false)
		else
			SaveConfig()
			-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
		end
	end
})
LeftGroupbox25:AddToggle("Auto Farm Material Skull Guitar", {
	Title = "Auto Farm Material Skull Guitar",
	Desc = "Cày nguyên liệu mua Đàn Cầu Đặc",
	Default = false,
	Callback = function(state, arg292)
		if state then
			SaveConfig("AutoFarmMaterialSkullGuitar", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox25:AddButton({
	Title = "Talk With Stone",
	Desc = "Nói chuyện với cục đá từ xa",
	Callback = function(state, arg294)
		if state then
			local Remotes3 = ReplicatedStorage:WaitForChild("Remotes")
			local CommF_2 = Remotes3:WaitForChild("CommF_")
			CommF_2:InvokeServer("RaceV4Progress", "Begin")
			local Remotes4 = ReplicatedStorage:WaitForChild("Remotes")
			local CommF_3 = Remotes4:WaitForChild("CommF_")
			CommF_3:InvokeServer("RaceV4Progress", "Check")
			local Remotes5 = ReplicatedStorage:WaitForChild("Remotes")
			local CommF_4 = Remotes5:WaitForChild("CommF_")
			CommF_4:InvokeServer("RaceV4Progress", "Teleport")
			local Remotes6 = ReplicatedStorage:WaitForChild("Remotes")
			-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
			local CommF_5 = Remotes6:WaitForChild("CommF_")
			CommF_5:InvokeServer("RaceV4Progress", "Continue")
		else
			local Remotes7 = ReplicatedStorage:WaitForChild("Remotes")
			local CommF_6 = Remotes7:WaitForChild("CommF_")
			CommF_6:InvokeServer("RaceV4Progress", "Begin")
			local Remotes8 = ReplicatedStorage:WaitForChild("Remotes")
			local CommF_7 = Remotes8:WaitForChild("CommF_")
			CommF_7:InvokeServer("RaceV4Progress", "Check")
			local Remotes9 = ReplicatedStorage:WaitForChild("Remotes")
			local CommF_8 = Remotes9:WaitForChild("CommF_")
			CommF_8:InvokeServer("RaceV4Progress", "Teleport")
			local Remotes10 = ReplicatedStorage:WaitForChild("Remotes")
			local CommF_9 = Remotes10:WaitForChild("CommF_")
			CommF_9:InvokeServer("RaceV4Progress", "Continue")
		end
	end
})
local Tab37 = Window:AddTab("Fruits / Raid")
local LeftGroupbox26 = Tab37:AddLeftGroupbox("Fruits / Raiding")
local Label14 = LeftGroupbox26:AddLabel("Check Fruit\nĐang kiểm tra...")
task.spawn(function(...)
	task.wait(1)
	local children8 = game.Workspace:GetChildren()
	for i13, v23 in ipairs(children8) do
		v23:FindFirstChild("Handle")
		Label14:SetText("Check Fruit" .. "\n" .. " Find " .. v23.Name)
	end
	task.wait(1)
end) -- Join SL Discord: https://discord.gg/zNyHGU6eUK
-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
local LeftGroupbox27 = Tab37:AddLeftGroupbox("Stock Fruits")
local Label15 = LeftGroupbox27:AddLabel("Normal Stock\n")
local Label16 = LeftGroupbox27:AddLabel("Mirage Stock\n")
local Remotes11 = ReplicatedStorage:WaitForChild("Remotes")
local CommF_10 = Remotes11:WaitForChild("CommF_")
CommF_10:InvokeServer("GetFruits", false)
Label15:SetText("Normal Stock\nĐang cập nhật / Không có trái nào bán")
local Remotes12 = ReplicatedStorage:WaitForChild("Remotes")
local CommF_11 = Remotes12:WaitForChild("CommF_")
CommF_11:InvokeServer("GetFruits", true)
Label16:SetText("Mirage Stock\nĐang cập nhật / Không có trái nào bán")
task.spawn(function(...)
	task.wait(30)
	local Remotes13 = ReplicatedStorage:WaitForChild("Remotes")
	local CommF_12 = Remotes13:WaitForChild("CommF_")
	CommF_12:InvokeServer("GetFruits", false)
	Label15:SetText("Normal Stock\nĐang cập nhật / Không có trái nào bán")
	local Remotes14 = ReplicatedStorage:WaitForChild("Remotes")
	local CommF_13 = Remotes14:WaitForChild("CommF_")
	CommF_13:InvokeServer("GetFruits", true)
	Label16:SetText("Mirage Stock\nĐang cập nhật / Không có trái nào bán")
	task.wait(30)
end)
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local UI = Controllers:WaitForChild("UI")
local FruitShop = UI:WaitForChild("FruitShop")
local module6 = require(FruitShop)
LeftGroupbox27:AddButton({
	Title = "Open Fruit Shop",
	Desc = "Mở cửa hàng bán Trái Ác Quỷ",
	-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
	Callback = function(state, arg296)
		if state then
			local Remotes15 = ReplicatedStorage:WaitForChild("Remotes")
			local CommF_14 = Remotes15:WaitForChild("CommF_")
			CommF_14:InvokeServer("GetFruits", false)
		else
			local Remotes16 = ReplicatedStorage:WaitForChild("Remotes")
			local CommF_15 = Remotes16:WaitForChild("CommF_")
			CommF_15:InvokeServer("GetFruits", false)
		end
		module6:Open()
	end
})
LeftGroupbox27:AddButton({
	Title = "Random Fruits",
	Desc = "Mua ngẫu nhiên trái ác quỷ",
	Callback = function(state, arg298)
		RFGachaNetworkRF:InvokeServer({ BoxName = "ZiolesGacha", Context = "Purchase" })
	end
})
LeftGroupbox27:AddToggle("Auto Buy Random Fruits", {
	Title = "Auto Buy Random Fruits",
	Desc = "Tự động mua trái ác quỷ ngẫu nhiên",
	Default = false,
	Callback = function(state, arg300)
		if state then
			SaveConfig("AutoBuyFruitsFlag", false)
		else
			SaveConfig()
		end
		-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
	end
})
LeftGroupbox27:AddToggle("Store Fruits", {
	Title = "Store Fruits",
	Desc = "Cất trái ác quỷ",
	Default = false,
	Callback = function(state, arg302)
		if state then
			SaveConfig("AutoStoreFruitFlag", false)
		else --[[ Leaked By SL | https://discord.gg/zNyHGU6eUK ]]
			SaveConfig()
		end
	end
})
LeftGroupbox27:AddToggle("Auto Tween Fruits", {
	Title = "Auto Tween Fruits",
	Desc = "Tự động di chuyển đến trái ác quỷ",
	Default = false,
	Callback = function(state, arg304)
		if state then
			SaveConfig("autotwfruits", false)
		else
			SaveConfig()
		end
	end
})
local LeftGroupbox28 = Tab37:AddLeftGroupbox("Raiding")
local Label17 = LeftGroupbox28:AddLabel("Raiding Status\n")
task.spawn(function(...)
	while task.wait(0.2) do
	-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
		Label17:SetText("Raiding Status\nRaiding Statud : False")
	end
end)
_G.SelectChip = false
LeftGroupbox28:AddDropdown("Select Chip", {
	Title = "Select Chip",
	Multi = false,
	Values = {
		"Flame",
		"Ice",
		"Quake",
		"Light",
		"Dark",
		"String",
		"Rumble",
		"Magma",
		"Buddha",
		"Sand",
		"Bird: Phoenix",
		"Dough"
	},
	Callback = function(state, arg306)
		if state then
			SaveConfig("SelectChip", state)
			_G.SelectChip = state
		else
			SaveConfig("SelectChip", false)
		end
	end
})
-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
LeftGroupbox28:AddToggle("Auto Select Dungeon Chip From Using Fruits", {
	Title = "Auto Select Dungeon Chip From Using Fruits",
	Desc = "Chọn loại raid từ trái đang dùng",
	Default = false,
	Callback = function(state, arg308)
		if state then
			SaveConfig("AutoSelectDungeon", false)
		else
			SaveConfig()
		end
	end
-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
-- Join SL Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
})
LeftGroupbox28:AddButton({
	Title = "Buy Dungeon Chips [Beli]",
	Desc = "Mua chip bằng beli",
	Callback = function(state, arg310)
		Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip")
	end
})
LeftGroupbox28:AddToggle("Auto Buy Dungeon Chips [Devil Fruit]", {
	Title = "Auto Buy Dungeon Chips [Devil Fruit]",
	Desc = "Tự động mua chip bằng trái trong kho (Dưới 1M)",
	Default = false,
	Callback = function(state, arg312)
		if state then
			SaveConfig("AutoBuyChipFruit", false)
		else
			SaveConfig()
		end
	end
	-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
})
local players6 = Players:GetPlayers()
for i15, v25 in ipairs(players6) do
end
local Dropdown2 = LeftGroupbox28:AddDropdown("Select Player Multi Raid", {
	Title = "Select Player Multi Raid",
	Default = {},
	Multi = true,
	Values = { v25.Name },
	Callback = function(state, arg314)
	end
})
LeftGroupbox28:AddButton({
	Title = "Refresh Multi Raid Players",
	Callback = function(state, arg316)
		if state then
			local players7 = Players:GetPlayers()
			for i16, v26 in ipairs(players7) do
			end
			Dropdown2:GetNewList({ v26.Name })
		else
			local players8 = Players:GetPlayers()
			for i17, v27 in ipairs(players8) do
			end
			Dropdown2:GetNewList({ v27.Name })
		end
	end
})
LeftGroupbox28:AddToggle("Account Pick Slot Raid", {
	Title = "Account Pick Slot Raid",
	-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
	Desc = "Tự đứng vào pad trống",
	Default = false,
	Callback = function(state, arg318)
		if state then
			SaveConfig("account_pick_slot_raid", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox28:AddToggle("Auto Multi Raid", {
	Title = "Auto Multi Raid",
	Desc = "Chờ acc đã chọn ở Raid Summon, sau đó tự raid cùng nhau",
	Default = false,
	Callback = function(state, arg320)
		if state then
			SaveConfig("auto_multi_raid", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox28:AddToggle("Auto Start Raid And Raid Full", {
	Title = "Auto Start Raid And Raid Full",
	Desc = "Bắt đầu Raid Và Dùng Kill Aura",
	Default = false,
	Callback = function(state, arg322)
		if state then
			SaveConfig("AutoStartRaid", false)
		else -- Leaked by SL | Join https://discord.gg/zNyHGU6eUK for more leaks
		-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
			SaveConfig()
		end
	end
})
LeftGroupbox28:AddToggle("Auto Awakening", {
	Title = "Auto Awakening",
	Desc = "Tự động thức tỉnh ( sau khi raid)",
	Default = false,
	Callback = function(state, arg324)
		if state then
			SaveConfig("AutoAwakening", false)
		else
			SaveConfig()
		end
	end
})
local LeftGroupbox29 = Tab37:AddLeftGroupbox("Dungeon Map")
LeftGroupbox29:AddButton({
	Title = "Teleport To Dungeons",
	Desc = "Vào Dungeons Map",
	Callback = function(state, arg326)
		if state then
			local Modules3 = ReplicatedStorage:WaitForChild("Modules")
			local Net3 = Modules3:WaitForChild("Net")
			local RFDungeonNPCNetworkFunction = Net3:WaitForChild("RF/DungeonNPCNetworkFunction")
			RFDungeonNPCNetworkFunction:InvokeServer("TeleportToDungeonHub", false)
		else
			local Modules4 = ReplicatedStorage:WaitForChild("Modules")
			local Net4 = Modules4:WaitForChild("Net")
			local RFDungeonNPCNetworkFunction2 = Net4:WaitForChild("RF/DungeonNPCNetworkFunction")
			--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
			RFDungeonNPCNetworkFunction2:InvokeServer("TeleportToDungeonHub", false)
		end
	end
})
local players9 = Players:GetPlayers()
for i18, v28 in ipairs(players9) do
end
_G.DungeonJoinAccount = false
local Dropdown3 = LeftGroupbox29:AddDropdown("Select Account Join", {
	Title = "Select Account Join",
	Multi = false,
	Values = { v28.Name },
	Callback = function(state, arg328)
		if state then
			SaveConfig("DungeonJoinAccount", state)
			_G.DungeonJoinAccount = state
		else
			SaveConfig("DungeonJoinAccount", false)
		end
	end
})
LeftGroupbox29:AddButton({
	Title = "Refresh Dungeon Players",
	Callback = function(state, arg330)
		if state then
			local players10 = Players:GetPlayers()
			for i19, v29 in ipairs(players10) do
			end
			Dropdown3:GetNewList({ v29.Name })
		else
		--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
			local players11 = Players:GetPlayers()
			for i20, v30 in ipairs(players11) do
			end
			Dropdown3:GetNewList({ v30.Name })
		end
	end
})
_G.DungeonDifficulty = false
LeftGroupbox29:AddDropdown("Select Dungeon Difficulty", {
	Title = "Select Dungeon Difficulty",
	Default = "Normal",
	Multi = false,
	Values = { "Normal", "Hard", "Hell" },
	Callback = function(state, arg332)
		if state then
			SaveConfig("DungeonDifficulty", state)
			_G.DungeonDifficulty = state
		else
			SaveConfig("DungeonDifficulty", false)
		end
	end
})
_G.DungeonDifficulty = "Normal"
_G.DungeonMinPlayers = 2
LeftGroupbox29:AddSlider({
	Title = "Min Player Start Dungeon",
	Default = 2,
	Max = 4,
	Min = 1,
	Callback = function(state, arg334)
	-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
		if state then
			SaveConfig("DungeonMinPlayers", math.clamp(tonumber(state), 1, 4))
			_G.DungeonMinPlayers = math.clamp(tonumber(state), 1, 4)
		else
			SaveConfig("DungeonMinPlayers", 2)
		end
	end
})
LeftGroupbox29:AddToggle("Account Start Dungeon", {
	Title = "Account Start Dungeon",
	Desc = "Tự vào pad trống, chọn độ khó và mở Dungeon",
	Default = false,
	Callback = function(state, arg336)
		if state then
			SaveConfig("DungeonAccountStart", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox29:AddToggle("Auto Join Dungeon", {
	Title = "Auto Join Dungeon",
	Desc = "Tự vào pad của tài khoản đã chọn",
	Default = false,
	Callback = function(state, arg338)
		if state then
			SaveConfig("DungeonAutoJoin", false)
		else
			SaveConfig()
		end
		-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
	end
})
_G.SelectedCards = {}
LeftGroupbox29:AddDropdown("Chọn thẻ", {
	Title = "Chọn thẻ",
	Default = {},
	Multi = true,
	Values = {
		"Lifesteal",
		"All Cooldowns",
		"HYPER!",
		"Fruit M1 Speed",
		"Armor",
		"Sniper",
		"Sword",
		"Overflow",
		"Gun",
		"Melee",
		"Fruit",
		"Defense",
		"Fortress"
	},
	Callback = function(state, arg340)
	end
})
_G.SelectedCards = {}
LeftGroupbox29:AddToggle("Tự động nhặt thẻ", {
	Title = "Tự động nhặt thẻ",
	Desc = "Tự động nhặt thẻ đã chọn hoặc tất cả thẻ",
	Default = false,
	-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
	Callback = function(state, arg342)
		if state then
			SaveConfig("AutoPickDungeonCards", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox29:AddToggle("Auto Raid Dungeon", {
	Title = "Auto Raid Dungeon",
	Desc = "Tự Động Farm + Qua Cửa",
	Default = false,
	Callback = function(state, arg344)
		if state then
			SaveConfig("raidnew", false)
		else
			SaveConfig()
		end
	end
})
local Tab38 = Window:AddTab("Teleport Island")
local LeftGroupbox30 = Tab38:AddLeftGroupbox("Travel - Worlds")
LeftGroupbox30:AddButton({
	Title = "Travel East Blue (World 1)",
	Desc = "Về Sea 1",
	Callback = function(state, arg346)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelMain")
	end
})
LeftGroupbox30:AddButton({
-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
	Title = "Travel Dressrosa (World 2)",
	Desc = "Về Sea 2",
	Callback = function(state, arg348)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
	end
})
LeftGroupbox30:AddButton({
	Title = "Travel Zou (World 3)",
	Desc = "Về Sea 3",
	Callback = function(state, arg350)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
	end
})
local LeftGroupbox31 = Tab38:AddLeftGroupbox("Travel - Island")
local children9 = workspace._WorldOrigin.Locations:GetChildren()
for k11, v31 in pairs(children9) do
end
_G.Island = false
LeftGroupbox31:AddDropdown("Select Travelling", {
	Title = "Select Travelling",
	Multi = false,
	Values = { v31.Name },
	Callback = function(state, arg352)
		if state then
			SaveConfig("SelectTravel", state)
			_G.Island = state
		else
			SaveConfig("SelectTravel", false)
		end
	end -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
	-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
})
LeftGroupbox31:AddToggle("Auto Travel", {
	Title = "Auto Travel",
	Desc = "Tự động di chuyển đến đảo đã chọn",
	Default = false,
	Callback = function(state, arg354)
		if state then
			SaveConfig("AutoTravel", false)
		else
			SaveConfig()
		end
	end
})
local Tab39 = Window:AddTab("Stats")
local LeftGroupbox32 = Tab39:AddLeftGroupbox("Stats Configuration")
LeftGroupbox32:AddSlider({
	Title = "Stats Value",
	Default = 1,
	Max = 1000,
	Min = 0,
	Callback = function(state, arg356)
	end
})
task.spawn(function(...)
end)
LeftGroupbox32:AddToggle("Auto Melee", {
	Title = "Auto Melee",
	Desc = "",
	Default = false,
	Callback = function(state, arg358)
	-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
		if state then
			SaveConfig("AutoMelee", false)
		else
			SaveConfig()
		end --[=[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] ]=]
	end
})
LeftGroupbox32:AddToggle("Auto Swords", {
	Title = "Auto Swords",
	Desc = "",
	Default = false,
	Callback = function(state, arg360)
		if state then
			SaveConfig("AutoSwords", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox32:AddToggle("Auto Gun", {
	Title = "Auto Gun",
	Desc = "",
	Default = false,
	Callback = function(state, arg362)
		if state then
			SaveConfig("AutoGun", false)
		else
			SaveConfig()
		end
	end
	-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
})
LeftGroupbox32:AddToggle("Auto Blox Fruit", {
	Title = "Auto Blox Fruit",
	Desc = "",
	Default = false,
	Callback = function(state, arg364)
		if state then
			SaveConfig("AutoBloxFruit", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox32:AddToggle("Auto Defense", {
	Title = "Auto Defense",
	Desc = "",
	Default = false,
	Callback = function(state, arg366)
		if state then
			SaveConfig("AutoDefense", false)
		else
			SaveConfig()
		end
	end
})
local Tab40 = Window:AddTab("Sea Event")
local LeftGroupbox33 = Tab40:AddLeftGroupbox("Sea Event / Setting Sail")
_G.SelectedBoat = false
LeftGroupbox33:AddDropdown("Choose Boats", {
	Title = "Choose Boats",
	-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
	Default = "MarineGrandBrigade",
	Multi = false,
	Values = {
		"Guardian",
		"PirateGrandBrigade",
		"MarineGrandBrigade",
		"PirateBrigade",
		"MarineBrigade",
		"PirateSloop",
		"MarineSloop",
		"Beast Hunter"
	},
	Callback = function(state, arg368)
		if state then
			SaveConfig("ChooseBoats", state)
			_G.SelectedBoat = state
		else
			SaveConfig("ChooseBoats", false)
		end
	end
})
_G.SelectedBoat = "MarineGrandBrigade"
_G.TargetBoatOwner = false
LeftGroupbox33:AddDropdown("Target Boat Owner", {
	Title = "Target Boat Owner",
	Default = "My Boat",
	Multi = false,
	Values = { "My Boat", "Nearest Boat" },
	Callback = function(state, arg370)
		if state then
		-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
			SaveConfig("SelectBoatTarget", state)
			_G.TargetBoatOwner = state
		else
			SaveConfig("SelectBoatTarget", false)
		end
	end
})
_G.TargetBoatOwner = "My Boat"
LeftGroupbox33:AddButton({
	Title = "Buy Boats",
	Desc = "Mua thuyền đã chọn",
	Callback = function(state, arg372)
		ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", "MarineGrandBrigade")
	end
})
_G.DangerSc = false
LeftGroupbox33:AddDropdown("Choose Sea Level", {
	Title = "Choose Sea Level",
	Default = "Lv 1",
	Multi = false,
	Values = {},
	Callback = function(state, arg374)
		if state then
			SaveConfig("ChooseSeaLevel", state)
			_G.DangerSc = state
		else
			SaveConfig("ChooseSeaLevel", false)
		end
	end
})
-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
_G.DangerSc = "Lv 1"
getgenv().BoatSpeed = 140
LeftGroupbox33:AddDropdown("Boat Speed", {
	Title = "Boat Speed",
	Default = "220",
	Multi = false,
	Values = { "140", "180", "200", "220", "300", "350" },
	Callback = function(state, arg376)
		if state then
			SaveConfig("BoatSpeedV7", state)
		else
			getgenv().BoatSpeed = math.clamp(tonumber(state), 140, 350)
			SaveConfig("BoatSpeedV7", false)
		end
	end
})
getgenv().BoatSpeed = 220
LeftGroupbox33:AddToggle("Auto Sail Boat", {
	Title = "Auto Sail Boat",
	Desc = "Tự đi ra biển bằng thuyền",
	Default = false,
	Callback = function(state, arg378)
		if state then
			SaveConfig("AutoSailBoat", false)
		else -- Source Leak (SL) | Join our Discord: https://discord.gg/zNyHGU6eUK
			SaveConfig()
		end
	end
})
LeftGroupbox33:AddToggle("Auto Reset When Boat Is Lost", {
-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
	Title = "Auto Reset When Boat Is Lost",
	Desc = "Reset về Tiki mua thuyền khi mất thuyền",
	Default = false,
	Callback = function(state, arg380)
		if state then
			SaveConfig("AutoResetLostBoat", false)
		else
			SaveConfig()
		end
	end
})
task.spawn(function(...)
	while task.wait(0.3) do
		local children10 = workspace.Boats:GetChildren()
		for k12, v32 in pairs(children10) do
			local descendants2 = v32:GetDescendants()
			for k13, v33 in pairs(descendants2) do
				v33.CanCollide = true
			end
		end
	end
end)
LeftGroupbox33:AddButton({
	Title = "Turn on increase Boats",
	Desc = "Tăng tốc độ và hiệu suất thuyền",
	Callback = function(state, arg382)
		if state then
			local descendants4 = workspace.Boats:GetDescendants()
			for k18, v38 in pairs(descendants4) do
			end -- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
			-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
		else
			local descendants5 = workspace.Boats:GetDescendants()
			for k19, v39 in pairs(descendants5) do
			end
		end
	end
})
_G.SelectedSeaEvents = {}
_G.IsAutoFarmingSeaEvent = false
LeftGroupbox33:AddDropdown("Choose Sea Event", {
	Title = "Choose Sea Event",
	Default = {},
	Multi = true,
	Values = {
		"Shark",
		"Piranha",
		"Terror Shark",
		"Fish Crew Member",
		"Haunted Crew Member",
		"Pirate Grand Brigade",
		"Fish Boat",
		"Sea Beast"
	},
	Callback = function(state, arg384)
	end
})
_G.SelectedSeaEvents = {}
LeftGroupbox33:AddToggle("Auto Escape Rough Sea", {
	Title = "Auto Escape Rough Sea",
	Desc = "Tự động thoát khỏi Rough Sea",
	-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
	Default = false,
	Callback = function(state, arg386)
		if state then
			SaveConfig("AutoEscapeRoughSea", false)
		else -- SL | Source Leak [https://discord.gg/zNyHGU6eUK]
			SaveConfig()
		end
	end
})
LeftGroupbox33:AddToggle("Farm M1 Fruit Only", {
	Title = "Farm M1 Fruit Only",
	Desc = "Chuyển Sang Trái Và Dùng M1 (chỉ áp dụng cho: Sea Beast, Leviathan, Fish Boat, Pirate Grand Brigade)",
	Default = false,
	Callback = function(state, arg388)
		if state then
			SaveConfig("farm_m1_fruit_sea", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox33:AddToggle("Farm Use Gun Only", {
	Title = "Farm Use Gun Only",
	Desc = "Chuyển Sang Súng Dùng M1 Và Chiêu",
	Default = false,
	Callback = function(state, arg390)
		if state then
			SaveConfig("farm_m1_gun_sea", false)
		else
			SaveConfig()
			--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
		end
	end
})
local players12 = Players:GetPlayers()
for i21, v40 in ipairs(players12) do
end
_G.SeaEventFriend = false
local Dropdown4 = LeftGroupbox33:AddDropdown("Select Friend Sea Event", {
	Title = "Select Friend Sea Event",
	Multi = false,
	Values = { v40.Name },
	Callback = function(state, arg392)
		if state then
			SaveConfig("sea_event_friend", state)
			_G.SeaEventFriend = state
		else
			SaveConfig("sea_event_friend", false)
		end
	end
})
LeftGroupbox33:AddButton({
	Title = "Refresh Sea Event Friends",
	Callback = function(state, arg394)
		if state then
			local players13 = Players:GetPlayers()
			for i22, v41 in ipairs(players13) do
			end
			Dropdown4:GetNewList({ v41.Name })
		else
			local players14 = Players:GetPlayers()
			--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
			for i23, v42 in ipairs(players14) do
			end
			Dropdown4:GetNewList({ v42.Name })
		end
	end
})
LeftGroupbox33:AddToggle("Sea Event With Friend", {
	Title = "Sea Event With Friend",
	Desc = "Săn Sea Event Multi",
	Default = false,
	Callback = function(state, arg396)
		if state then
			SaveConfig("auto_sea_event_friend", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox33:AddToggle("Auto Farm Sea Event", {
	Title = "Auto Farm Sea Event",
	Desc = "Tự động farm các mục tiêu đã chọn",
	Default = false,
	Callback = function(state, arg398)
		if state then
			SaveConfig("auto_farm_sea_event", false)
		else
			SaveConfig()
		end
	end
})
-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
task.spawn(function(...)
	while task.wait(0.5) do
		local v = Players:FindFirstChild("")
		v.Character:FindFirstChild("HumanoidRootPart")
		Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	end
end)
task.spawn(function(...)
	task.wait(0.3)
	Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	task.wait(0.3)
end)
local Tab41 = Window:AddTab("Settings")
local LeftGroupbox34 = Tab41:AddLeftGroupbox("Config")
LeftGroupbox34:AddButton({
	Title = "Copy Config",
	Desc = "Copy config. Dán vào executor trước khi chạy RealKid.",
	Callback = function(arg399, arg400)
		HttpService:JSONEncode({
	AutoAwakening = false,
	AutoBloxFruit = false,
	AutoBossToggle = false,
	AutoBuyChipFruit = false,
	AutoBuyFruitsFlag = false,
	AutoBuyHakiRecipes = false,
	AutoDefense = false,
	AutoEliteQuest = false,
	AutoEscapeRoughSea = false,
	AutoFarmMaterialSkullGuitar = false,
	AutoFarmObservation = false,
	-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
	AutoFarmObservationHop = false,
	AutoGun = false,
	AutoHiddenQuest = false,
	AutoHopChest = false,
	AutoHopSecretHint = false,
	AutoMelee = false,
	AutoMirror = false,
	AutoObservationV2 = false,
	AutoOpenMenuHopFarm = false,
	AutoPickDungeonCards = false,
	AutoQuestBoss = false,
	AutoResetLostBoat = false,
	AutoSailBoat = false,
	AutoSelectDungeon = false,
	AutoSellFish = false,
	AutoSkullGuitar = false,
	AutoSlapDodgeAABB = false,
	AutoStackDarkbeard = false,
	AutoStartRaid = false,
	AutoStoreFruitFlag = false,
	AutoSwords = false,
	AutoTeleportBarista = false,
	AutoTravel = false,
	AutoTweenEventFishingSpot = false,
	AutoValkyrie = false,
	BaitSelection = "Basic Bait",
	Berry = false,
	BoatSpeedV7 = "220",
	Chest = false,
	ChooseBoats = "MarineGrandBrigade",
	-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
	ChooseSeaLevel = "Lv 1",
	DungeonAccountStart = false,
	DungeonAutoJoin = false,
	DungeonDifficulty = "Normal",
	DungeonJoinAccount = false,
	DungeonMinPlayers = 2,
	EspBerries = false,
	EspChests = false,
	EspFruits = false,
	EspIslandLocation = false,
	EspPlayers = false,
	FarmMastery_G = false,
	GoToSharkmanNPC = false,
	HopBerry = false,
	JumpPower = false,
	JumpPowerSliderV2 = 50,
	MasterySword = false,
	MaxChestHop = 45,
	PvPAimRadius = 150,
	RodSelection = "Fishing Rod",
	SelectBoatTarget = "My Boat",
	SelectChip = false,
	SelectPlayer = false,
	SelectTravel = false,
	Select_Boss_Farm = "",
	SpectatePlayer = false,
	SwapDragoRace = false,
	TeleportToPlayer = false,
	WalkSpeed = false,
	WalkSpeedSliderV2 = 100,
	-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
	accept_quests = false,
	account_pick_slot_raid = false,
	auto_buy_style = false,
	auto_factory_raid = false,
	auto_farm_general = false,
	auto_farm_materials = false,
	auto_farm_nearest = false,
	auto_farm_nearest_range = 500,
	auto_farm_sea_event = false,
	auto_mastery_fruits = false,
	auto_multi_raid = false,
	auto_sea_event_friend = false,
	auto_training_dummy = false,
	auto_travel_dressrosa = false,
	auto_zou_quest = false,
	autotwfruits = false,
	card_selection = {},
	farm_height_2 = 30,
	farm_m1_fruit_sea = false,
	farm_m1_gun_sea = false,
	global_skill_delay = 100,
	global_skill_hold_c = 10,
	global_skill_hold_f = 10,
	global_skill_hold_v = 10,
	global_skill_hold_x = 10,
	global_skill_hold_z = 10,
	global_skill_keys = { "Z", "X", "C" },
	global_skill_weapons = { "Melee", "Sword", "Blox Fruit", "Gun" },
	hopantirs = false,
	ignore_cake_prince = false,
	-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
	mastery_health_percent = 30,
	material_choice = false,
	multi_raid_players = {},
	raidnew = false,
	sea_event_friend = false,
	selected_farm_target = "Auto Level",
	selected_fighting_style = "Black Leg",
	selected_sea_events = {},
	weapon_choice = "Melee"
})
	end
})
LeftGroupbox34:AddButton({
	Title = "Reset Config",
	Desc = "Xóa toàn bộ cài đặt đã lưu trước đó",
	Callback = function(state, arg402)
		getgenv().Flags = {}
		result2:Notify({
	Title = "Thành Công",
	Desc = "Đã xóa config! Hãy chạy lại script để áp dụng.",
	Duration = 5
})
	end
})
local LeftGroupbox35 = Tab41:AddLeftGroupbox("Teleports & Misc")
getgenv().TweenSpeed = 190
LeftGroupbox35:AddSlider({
	Title = "Tween Speed",
	Default = 190,
	Max = 350,
	-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
	Min = 150,
	Callback = function(state, arg404)
		if state then
			SaveConfig()
		else
			getgenv().TweenSpeed = math.clamp(tonumber(math.clamp(tonumber(state), 150, 350)), 150, 350)
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Auto Destroy Lava", {
	Title = "Auto Destroy Lava",
	Desc = "Tự động xóa lava",
	Default = true,
	Callback = function(state, arg406)
		if state then
			SaveConfig()
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Use Portal Teleport", {
	Title = "Use Portal Teleport",
	Desc = "Dùng Cổng Dịch Chuyển",
	Default = true,
	Callback = function(state, arg408)
		if state then
			SaveConfig()
		else
		-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Auto Load Script", {
	Title = "Auto Load Script",
	Desc = "Tự chạy lại sau khi teleport",
	Default = true,
	Callback = function(state, arg410)
		if state then
			SaveConfig()
		else
			SaveConfig()
		end
	end -- Join SL Discord: https://discord.gg/zNyHGU6eUK
})
LeftGroupbox35:AddButton({
	Title = "Auto Redeem All Codes",
	Desc = "Tự động nhập toàn bộ Code",
	Callback = function(state, arg412)
		result2:Notify({
	Title = "Bắt Đầu Nhập Code",
	Desc = "Vui lòng không tắt Hub. Đang cày code...",
	Duration = 3
})
		task.spawn(function(...)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("EASTEREXP")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("LIGHTNINGABUSE")
			task.wait(1.5)
			-- Leaked by SL | Join our Discord for more leaked sources: https://discord.gg/zNyHGU6eUK
			ReplicatedStorage.Remotes.Redeem:InvokeServer("NEW")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("1LOSTADMIN")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("ZIOLES")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("1BILLION")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("3BVISITS")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("BANEXPLOIT")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("Sub2Fer999")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("Enyu_is_Pro")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("JCWK")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("StarcodeHEO")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("MagicBUS")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("KittGaming")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("SUB2CAPTAINMAUI")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("Sub2OfficialNoobie")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("TheGreatAce")
			task.wait(1.5)
			-- SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL for more script leaks
			ReplicatedStorage.Remotes.Redeem:InvokeServer("Sub2NoobMaster123")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("Sub2Daigrock")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("Axiore")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("StrawHatMaine")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("TantaiGaming")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("Bluxxy")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("SUB2GAMERROBOT_EXP1")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("KITT_RESET")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("SUB2GAMERROBOT_RESET1")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("Sub2UncleKizaru")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("CHANDLER")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("Fudd10")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("fudd10_v2")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("Bignews")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("2DIEMAUAKSID")
			task.wait(1.5)
			-- Source leaked by SL | Get more free hub sources at https://discord.gg/zNyHGU6eUK
			ReplicatedStorage.Remotes.Redeem:InvokeServer("BINZINCHAUBU49")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("HOMELESS")
			task.wait(1.5)
			ReplicatedStorage.Remotes.Redeem:InvokeServer("EDAZIMEFIN34")
			task.wait(1.5)
			result2:Notify({
	Title = "Redeem Hoàn Tất!",
	Desc = "Đã thử nhập toàn bộ code trong danh sách.",
	Duration = 5
})
		end)
	end
})
_G.MobM = nil
LeftGroupbox35:AddDropdown("Bring Mob Max", {
	Title = "Bring Mob Max",
	Default = "6",
	Multi = false,
	Values = { "2", "3", "4", "5", "6", "10" },
	Callback = function(state, arg414)
		if state then
			SaveConfig()
			_G.MobM = tonumber(state)
		else
			SaveConfig("BringMobMax", false)
		end
	end
})
task.spawn(function(...)
-- [SL] Leaked By SL | Source Leak - Join https://discord.gg/zNyHGU6eUK
	SaveConfig("BringMobMax", "6")
	_G.MobM = 6
end)
_G.BringRange = nil
LeftGroupbox35:AddDropdown("Bring Mob Mode", {
	Title = "Bring Mob Mode",
	Default = "400",
	Multi = false,
	Values = { "250", "300", "350", "400", "450", "500" },
	Callback = function(state, arg416)
		if state then
			SaveConfig("BringMode", state)
			_G.BringRange = tonumber(state)
		else
			SaveConfig("BringMode", false)
		end
	end
})
task.spawn(function(...)
	SaveConfig("BringMode", "400")
	_G.BringRange = 400
end)
getgenv().Team = false
LeftGroupbox35:AddDropdown("Choose Team", {
	Title = "Choose Team",
	Default = "Marines",
	Multi = false,
	Values = { "Marines", "Pirates" },
	Callback = function(state, arg418)
		if state then
		-- Join SL Discord for more open-source & leaked scripts: https://discord.gg/zNyHGU6eUK
			SaveConfig("selected_team", state)
		else
			getgenv().Team = state
			SaveConfig("selected_team", false)
		end --[[ Leaked By SL | https://discord.gg/zNyHGU6eUK ]]
	end
})
getgenv().Team = "Marines"
LeftGroupbox35:AddButton({
	Title = "Join Selected Team",
	Desc = "Đổi sang team đang chọn",
	Callback = function(state, arg420)
		CommF_:InvokeServer("SetTeam", "Marines")
	end
})
LeftGroupbox35:AddButton({
	Title = "Turn on Low CPU",
	Desc = "Giảm tải CPU, tăng FPS",
	Callback = function(state, arg422)
		workspace.Terrain.WaterWaveSize = 0
		workspace.Terrain.WaterWaveSpeed = 0
		workspace.Terrain.WaterReflectance = 0
		workspace.Terrain.WaterTransparency = 0
		Lighting.GlobalShadows = false
		Lighting.Brightness = 0
		if state then
			local result5 = settings()
			result5.Rendering.QualityLevel = "Level01"
			local descendants6 = game:GetDescendants()
			for i24, v43 in ipairs(descendants6) do
			-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
				v43.Transparency = 1
			end
			local children12 = Lighting:GetChildren()
			for i25, v44 in ipairs(children12) do
				v44.Enabled = false
			end
		else
			local result6 = settings()
			result6.Rendering.QualityLevel = "Level01"
			local descendants7 = game:GetDescendants()
			for i26, v45 in ipairs(descendants7) do
				v45.Transparency = 1
			end
			local children13 = Lighting:GetChildren()
			for i27, v46 in ipairs(children13) do
				v46.Enabled = false
			end
		end
	end
})
LeftGroupbox35:AddToggle("Auto Turn on Low CPU", {
	Title = "Auto Turn on Low CPU",
	Desc = "Tự bật Low CPU khi tải script",
	Default = false,
	Callback = function(state, arg424)
		if state then
			SaveConfig("auto_low_cpu_once", false)
		else
			SaveConfig()
		end
		--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
	end
})
LeftGroupbox35:AddButton({
	Title = "Remove Sky Fog",
	Desc = "Xóa sương mù, hiệu ứng trời để tăng FPS",
	Callback = function(state, arg426)
		Lighting:FindFirstChild("LightingLayers")
		Lighting.LightingLayers:Destroy()
		Lighting:FindFirstChild("SeaTerrorCC")
		Lighting.SeaTerrorCC:Destroy()
		Lighting:FindFirstChild("FantasySky")
		Lighting.FantasySky:Destroy()
	end
})
LeftGroupbox35:AddToggle("Auto Remove Sky Fog", {
	Title = "Auto Remove Sky Fog",
	Desc = "Tự động xóa sương mù, hiệu ứng trời để tăng FPS",
	Default = false,
	Callback = function(state, arg428)
		if state then
			SaveConfig("AutoRemoveSkyFog", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Stop when got God's Chalice/Fist of Darknest", {
	Title = "Stop when got God's Chalice/Fist of Darknest",
	Desc = "Dừng mọi thứ khi có chén thánh/key râu đen",
	Default = true,
	--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
	Callback = function(state, arg430)
		if state then
			SaveConfig("StopWhenChalice", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Bring Mobs", {
	Title = "Bring Mobs",
	Desc = "Gom quái",
	Default = true,
	Callback = function(state, arg432)
		if state then
			SaveConfig("Bringmob", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Fast Attack", {
	Title = "Fast Attack",
	Desc = "Đánh Nhanh",
	Default = true,
	Callback = function(state, arg434)
		if state then
			SaveConfig("Initialize", false)
		else
			SaveConfig()
		end
		-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
	end
})
_G.Seriality = true
LeftGroupbox35:AddToggle("Fast Attack Players", {
	Title = "Fast Attack Players",
	Desc = "Bật/tắt fastattack lên người chơi",
	Default = true,
	Callback = function(state, arg436)
		if state then
			SaveConfig("FastAttackPlayers", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Magic Fast Fruit", {
	Title = "Magic Fast Fruit",
	Desc = "Đánh trái ác quỷ không cần cầm",
	Default = false,
	Callback = function(state, arg438)
		if state then
			SaveConfig("MagicFruits", false)
		else
			SaveConfig()
		end -- Leaked by SL | Join https://discord.gg/zNyHGU6eUK for more leaks
	end
})
LeftGroupbox35:AddToggle("Auto Shoot Gun (Risk)", {
	Title = "Auto Shoot Gun (Risk)",
	Desc = "Tự Động Bắn Súng",
	-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
	Default = true,
	Callback = function(state, arg440)
		if state then
			SaveConfig("autoshootgun", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Auto Turn on Buso", {
	Title = "Auto Turn on Buso",
	Desc = "Bật Haki Tay",
	Default = true,
	Callback = function(state, arg442)
		if state then
			SaveConfig("BusuAura", false)
		else
			SaveConfig()
		end
	end
})
task.spawn(function(...)
	task.wait(0.3)
	Players.LocalPlayer.Character:GetAttribute("BusoEnabled")
	task.wait(0.3)
end)
LeftGroupbox35:AddToggle("Auto Turn on Ken", {
	Title = "Auto Turn on Ken",
	Desc = "Bật Haki Quan Sát",
	Default = false,
	-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
	Callback = function(state, arg444)
		if state then
			SaveConfig("KenAura2", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Auto Turn on Race V3", {
	Title = "Auto Turn on Race V3",
	Desc = "Bật tộc V3",
	Default = false,
	Callback = function(state, arg446)
		if state then
			SaveConfig("RaceV3Aura", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Auto Turn on Race V4", {
	Title = "Auto Turn on Race V4",
	Desc = "Bật tộc V36",
	Default = false,
	Callback = function(state, arg448)
		if state then
			SaveConfig("RaceV4Aura", false)
		else
			SaveConfig()
		end
		-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
	end
})
LeftGroupbox35:AddToggle("Auto Turn on Spin Position", {
	Title = "Auto Turn on Spin Position",
	Desc = "Khá bảnh quay tròn",
	Default = false,
	Callback = function(state, arg450)
		if state then
			SaveConfig("RandomAround", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Panic Mode", {
	Title = "Panic Mode",
	Desc = "Chế độ an toàn",
	Default = false,
	Callback = function(state, arg452)
		if state then
			SaveConfig("SafeMode", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Anti AFK", {
	Title = "Anti AFK",
	Desc = "Chống AFK",
	Default = true,
	-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
	Callback = function(state, arg454)
		if state then
			SaveConfig("AntiAFK", false)
		else
			SaveConfig()
		end
	end
})
Players.LocalPlayer.Idled:Connect(function(idleTime)
	VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
LeftGroupbox35:AddToggle("Remove Hit VFX", {
	Title = "Remove Hit VFX",
	Desc = "Xóa hiệu ứng đánh",
	Default = false,
	Callback = function(state, arg456)
		if state then
			SaveConfig("RemoveHitVFX", false)
		else
			SaveConfig()
		end
	end
})
LeftGroupbox35:AddToggle("Remove Death & Respawn VFX", {
	Title = "Remove Death & Respawn VFX",
	Desc = "Xóa hiệu ứng ngỏm và hồi sinh",
	Default = false,
	Callback = function(state, arg458)
	-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
		if state then
			SaveConfig("RemoveDeathRespawnVFX", false)
		else
			SaveConfig()
		end
	end
})
task.spawn(function(...)
	while task.wait(0.3) do
		ReplicatedStorage.Effect.Container:FindFirstChild("Death")
		ReplicatedStorage.Effect.Container.Death:Destroy()
		ReplicatedStorage.Effect.Container:FindFirstChild("Respawn")
		ReplicatedStorage.Effect.Container.Respawn:Destroy()
	end
end) -- [SL Source Leak] https://discord.gg/zNyHGU6eUK
LeftGroupbox35:AddToggle("Disable Notify", {
	Title = "Disable Notify",
	Desc = "Tắt thông báo hạ quái",
	Default = false,
	Callback = function(state, arg460)
		if state then
			SaveConfig("DisableNotify", false)
		else
			SaveConfig()
		end
	end
})
task.spawn(function(...)
	while task.wait(0.3) do
		ReplicatedStorage.Assets.GUI.DamageCounter.Enabled = false
		-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
		Players.LocalPlayer.PlayerGui.Notifications.Enabled = false
	end
end)
-- Discord Webhook tab and related controls removed by request.
local Modules5 = ReplicatedStorage:WaitForChild("Modules")
local Remotes17 = ReplicatedStorage:WaitForChild("Remotes")
local Net5 = Modules5:WaitForChild("Net")
local Net6 = Modules5:WaitForChild("Net")
Net6:WaitForChild("RE/ShootGunEvent")
Remotes17:WaitForChild("Validator2")
require(Net5)
-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] | More leaks in our Discord
task.spawn(function(...)
	require(Modules5.Flags)
	task.defer(function(...)
		local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts")
		local children14 = PlayerScripts:GetChildren()
		for i28, v47 in ipairs(children14) do
		end
		PlayerScripts.ChildAdded:Connect(function(child7)
			task.wait(0.2)
		end)
		task.wait(1)
		local children15 = PlayerScripts:GetChildren()
		for i29, v48 in ipairs(children15) do
		end
		task.wait(1)
	end)
end)
workspace:WaitForChild("Enemies")
workspace:WaitForChild("Characters")
require(ReplicatedStorage.Modules.CombatUtil)
RunService.Heartbeat:Connect(function(deltaTime5)
	Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
	workspace._WorldOrigin.Locations:FindFirstChild("Trial of Carnage")
end)
local module7 = require(ReplicatedStorage.Controllers.CombatController)
getupvalue(module7.Attack, 9)
local module8 = require(ReplicatedStorage.Global)
module8[""] = function(arg483, arg484)
	module8[""](arg483, arg484)
	--[[ Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join SL Discord ]]
end
RunService.Heartbeat:Connect(function(deltaTime6)
	Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
end)
task.wait()
getgenv().IsScriptLoading = false
result2:Notify({ Title = "Script Đã Tải Xong", Desc = "Thank For Used RealKid Hub", Duration = 5 })
getgenv().PendingConfigCallbacks = nil
task.spawn(function(...)
	SaveConfig("DungeonAutoJoin", false)
	_G.DungeonAutoJoin = false
	SaveConfig("AutoEscapeRoughSea", false)
	_G.AutoEscapeRoughSea = false
	SaveConfig()
	SaveConfig("GoToSharkmanNPC", false)
	_G.Auto_GoTo_NPC = false
	SaveConfig()
	SaveConfig("EspBerries", false)
	task.spawn(function(...)
	end)
	SaveConfig("auto_farm_general", false)
	_G.AutoFarmGeneral = false
	_G.Level = false
	_G.Auto_Cake_Prince = false
	_G.AutoFarm_Bone = false
	SaveConfig("auto_mastery_fruits", false)
	_G.FarmMastery_Dev = false
	SaveConfig("WalkSpeed", false)
	local Humanoid = Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	--[=[ SL | Source Leak [https://discord.gg/zNyHGU6eUK] - Join our Discord for more leaks ]=]
	Humanoid.WalkSpeed = 16
	SaveConfig("AutoDefense", false)
	_G.Auto_Defense = false
	SaveConfig("HopBerry", false)
	_G.AutoHopBerry = false
	SaveConfig("AutoHiddenQuest", false)
	_G.AutoHiddenQuest = false
	SaveConfig("AutoMelee", false)
	_G.Auto_Melee = false
	SaveConfig("FarmMastery_G", false)
	_G.FarmMastery_G = false
	SaveConfig("farm_m1_gun_sea", false)
	_G.FarmM1Gun = false
	SaveConfig()
	SaveConfig("DungeonAccountStart", false)
	_G.DungeonAccountStart = false
	SaveConfig("accept_quests", false)
	_G.AcceptQuestC = false
	SaveConfig("Chest", false)
	_G.AutoFarmChest = false
	SaveConfig("AutoTravel", false)
	_G.Teleport = false
	SaveConfig("AutoBuyHakiRecipes", false)
	_G.AutoBuyHakiRecipes = false
	SaveConfig()
	SaveConfig()
	getgenv().UsePortalTP = true
	SaveConfig("auto_farm_nearest", false)
	_G.AutoFarmNear = false
	getgenv().WalkWater = true
	-- Want more leaked hubs? Join SL | Source Leak: https://discord.gg/zNyHGU6eUK
	workspace.Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
	SaveConfig("AutoSwords", false)
	_G.Auto_Sword = false
	SaveConfig()
	_G.StopWhenChalice = true
	SaveConfig("AutoSellFish", false)
	getgenv().AutoSellFish = false
	SaveConfig("TeleportToPlayer", false)
	_G.TpPly = false
	SaveConfig("auto_factory_raid", false)
	_G.AutoFactory = false
	SaveConfig("AutoEliteQuest", false)
	_G.FarmEliteHunt = false
	SaveConfig("AutoBuyChipFruit", false)
	_G.Auto_BuyChipFruit = false
	SaveConfig("AutoStackDarkbeard", false)
	_G.AutoStackDarkbeard = false
	SaveConfig("AutoSkullGuitar", false)
	_G.Auto_Soul_Guitar = false
	SaveConfig()
	SaveConfig("auto_training_dummy", false)
	_G.DummyMan = false
	getgenv().AutoRageZ = false
	SaveConfig("EspFruits", false)
	task.spawn(function(...)
	end)
	SaveConfig("AutoSelectDungeon", false)
	_G.AutoSelectDungeon = false
	SaveConfig("AutoSlapDodgeAABB", false)
	-- Free leaked sources daily in SL Discord: https://discord.gg/zNyHGU6eUK
	_G.Auto_Slap_Dodge = false
	_G.AimMethod = false
	getgenv().AimPos = nil
	_G.AimTarget = nil
	local module9 = require(ReplicatedStorage.Global)
	module9.updateMouseWrapper()
	SaveConfig()
	SaveConfig()
	SaveConfig()
	SaveConfig()
	SaveConfig()
	SaveConfig()
	_G.DistroyHit = false
	SaveConfig("farm_m1_fruit_sea", false)
	_G.FarmM1FruitSea = false
	SaveConfig("AutoHopSecretHint", false)
	_G.AutoHopSecretHint = false
	SaveConfig("Berry", false)
	_G.AutoBerry = false
	SaveConfig("AutoHopChest", false)
	getgenv().AutoHopChest = false
	SaveConfig()
	_G.AntiAFK = true
	SaveConfig()
	_G.Safemode = false
	SaveConfig("AutoBuyFruitsFlag", false)
	_G.AutoBuyFruits = false
	-- SL Source Leak | https://discord.gg/zNyHGU6eUK | Join the server for more leaks
	SaveConfig("AutoStoreFruitFlag", false)
	_G.AutoStoreFruit = false
	SaveConfig("account_pick_slot_raid", false)
	_G.AccountPickSlotRaid = false
	SaveConfig("autotwfruits", false)
	_G.TweenFruit = false
	SaveConfig()
	SaveConfig("AutoBloxFruit", false)
	_G.Auto_DevilFruit = false
	SaveConfig()
	_G.RaceClickAutov3 = false
	SaveConfig()
	_G.AutoKen = false
	SaveConfig("AutoSailBoat", false)
	_G.SailBoats = false
	SaveConfig()
	_G.Shoot = true
	SaveConfig("raidnew", false)
	_G.AutoFarmraidnew = false
	SaveConfig()
	_G.FastAttackPlayers = true
	SaveConfig()
	SaveConfig("auto_zou_quest", false)
	_G.AutoZou = false
	SaveConfig("AutoFarmObservationHop", false)
	_G.hopfarmken = false
	SaveConfig()
	SaveConfig()
	_G.AutoRemoveSkyFog = false
	-- Leaked by SL Community | Source Leak [https://discord.gg/zNyHGU6eUK]
	task.spawn(function(...)
	end)
	SaveConfig("MasterySword", false)
	_G.FarmMastery_S = false
	SaveConfig("AutoFarmMaterialSkullGuitar", false)
	_G.AutoMatSoul = false
	SaveConfig()
	-- Auto-reload of the original legacy UI disabled so the Fluent build stays active after teleport.
	SaveConfig()
	_G.AutoDestroyLava = true
	_G.AutoFishing = false
	SaveConfig("AutoOpenMenuHopFarm", false)
	SaveConfig("auto_farm_sea_event", false)
	_G.Shark = false
	_G.Piranha = false
	_G.TerrorShark = false
	_G.MobCrew = false
	_G.HCM = false
	_G.PGB = false
	_G.FishBoat = false
	_G.SeaBeast1 = false
	SaveConfig("AutoTeleportBarista", false)
	_G.Tp_MasterA = false
	SaveConfig("AutoPickDungeonCards", false)
	SaveConfig("auto_sea_event_friend", false)
	_G.AutoSeaEventWithFriend = false
	_G.AutoCraftAnchor = false
	SaveConfig()
	_G.RaceClickAutov4 = false
	SaveConfig("AutoObservationV2", false)
	-- [Source Leak] Leaked By SL | Join Discord: https://discord.gg/zNyHGU6eUK
	_G.AutoKenVTWO = false
	SaveConfig("ignore_cake_prince", false)
	_G.IgnoreCakePrince = false
	SaveConfig("AutoGun", false)
	_G.Auto_Gun = false
	SaveConfig("AutoMirror", false)
	_G.AutoMiror = false
	SaveConfig()
	_G.MagicFastFruit = false
	SaveConfig("AutoBossToggle", false)
	_G.AutoBoss = false
	SaveConfig("EspIslandLocation", false)
	task.spawn(function(...)
	end)
	SaveConfig("AutoFarmObservation", false)
	_G.obsFarm = false
	SaveConfig("AutoAwakening", false)
	_G.Auto_Awakener = false
	SaveConfig("AutoStartRaid", false)
	_G.Auto_StartRaid = false
	SaveConfig("auto_multi_raid", false)
	_G.AutoMultiRaid = false
	SaveConfig("SpectatePlayer", false)
	task.wait(0.1)
	local child3 = Players:FindFirstChild(false)
	workspace.Camera.CameraSubject = child3.Character.Humanoid
	workspace.Camera.CameraSubject = Players.LocalPlayer.Character.Humanoid
	SaveConfig("hopantirs", false)
	_G.HopAntiBan = false
	SaveConfig("EspPlayers", false)
	-- More paid scripts leaked for free in SL Discord: https://discord.gg/zNyHGU6eUK
	task.spawn(function(...)
	end)
	getgenv().AutoQuestFishing = false
	SaveConfig("AutoValkyrie", false)
	_G.AutoRipIngay = false
	SaveConfig("EspChests", false)
	task.spawn(function(...)
	end)
	SaveConfig("auto_buy_style", false)
	_G.AutoBuyStyle = false
	SaveConfig("auto_farm_materials", false)
	_G.AutoMaterial = false
	SaveConfig("JumpPower", false)
	local Humanoid2 = Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	Humanoid2.JumpPower = 50
	SaveConfig("SwapDragoRace", false)
	_G.BuyDrago = false
	SaveConfig("AutoTweenEventFishingSpot", false)
	_G.AutoTweenEventFishingSpot = false
	SaveConfig("AutoResetLostBoat", false)
	_G.AutoResetLostBoat = false
	SaveConfig("auto_travel_dressrosa", false)
	_G.TravelDres = false
	SaveConfig("AutoQuestBoss", false)
	_G.AutoQuestBoss = false
end)
do pcall(function() getgenv().SL_Discord = "https://discord.gg/zNyHGU6eUK" end) end
-- Join SL Discord for more free leaked sources: https://discord.gg/zNyHGU6eUK
-- Leaked By SL | Source Leak [https://discord.gg/zNyHGU6eUK]
