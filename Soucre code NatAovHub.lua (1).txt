--// NatAov Hub Old By Dev-AnhTuanSiTink / https://discord.gg/UefGEBySJ8

(getgenv()).Team = (getgenv()).Team or "Marines";
repeat
	wait();
until game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded");
if (game:GetService("Players")).LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
	repeat
		wait();
		(game.ReplicatedStorage:WaitForChild("Remotes")).CommF_:InvokeServer("SetTeam", (getgenv()).Team);
		task.wait(3);
	until not (game:GetService("Players")).LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)");
end;
repeat
	task.wait();
until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main");
if not game:IsLoaded() then
	game.Loaded:Wait();
end;
task.wait(1);
local RS = game.ReplicatedStorage;
local N = require(RS.Modules.Net);
local C = require(RS.Modules.CombatUtil);
local P = game.Players.LocalPlayer;
local hit = N:RemoteEvent("RegisterHit", true);
local atk = RS.Modules.Net["RE/RegisterAttack"];
task.spawn(function()
	while task.wait() do
		local c = P.Character;
		if not c then
			continue;
		end;
		local r = c:FindFirstChild("HumanoidRootPart");
		local t = c:FindFirstChildOfClass("Tool");
		if not (r and t) then
			continue;
		end;
		local id = (tostring(P.UserId)):sub(2, 4) .. (tostring(coroutine.running())):sub(11, 15);
		local didy = false;
		for _, m in ipairs(workspace.Enemies:GetChildren()) do
			local h, u = m:FindFirstChild("HumanoidRootPart"), m:FindFirstChild("Humanoid");
			if h and (u and (u.Health > 0 and (h.Position - r.Position).Magnitude <= 60)) then
				if not didy then
					atk:FireServer();
					didy = true;
				end;
				hit:FireServer(h, { { m, h } }, nil, nil, id);
			end;
		end;
		for _, plr in ipairs(game.Players:GetPlayers()) do
			if plr ~= P and plr.Character then
				local m = plr.Character;
				local h = m:FindFirstChild("HumanoidRootPart");
				local u = m:FindFirstChild("Humanoid");
				if h and (u and (u.Health > 0 and (h.Position - r.Position).Magnitude <= 60)) then
					if not didy then
						atk:FireServer();
						didy = true;
					end;
					hit:FireServer(h, { { m, h } }, nil, nil, id);
				end;
			end;
		end;
	end;
end);
local Services = setmetatable({}, { __index = function(self, serviceName)
			local service = game:GetService(serviceName);
			rawset(self, serviceName, service);
			return service;
		end });
local function NotificacaoTuanDz(titulo, mensagem)
	local success = pcall(function()
			local TweenService = Services.TweenService;
			local CoreGui = Services.CoreGui;
			local LogoID = "rbxassetid://120488231660846";
			local ScreenGui = Instance.new("ScreenGui");
			ScreenGui.Name = "NM_Notify";
			ScreenGui.ResetOnSpawn = false;
			ScreenGui.Parent = CoreGui;
			local Frame = Instance.new("Frame");
			Frame.Parent = ScreenGui;
			Frame.BackgroundColor3 = Color3.fromRGB(8, 8, 8);
			Frame.Position = UDim2.new(1, 20, .85, 0);
			Frame.Size = UDim2.new(0, 280, 0, 65);
			Frame.BorderSizePixel = 0;
			local UICorner = Instance.new("UICorner");
			UICorner.CornerRadius = UDim.new(0, 10);
			UICorner.Parent = Frame;
			local UIStroke = Instance.new("UIStroke");
			UIStroke.Parent = Frame;
			UIStroke.Color = Color3.fromRGB(45, 45, 45);
			UIStroke.Thickness = 1;
			local Logo = Instance.new("ImageLabel");
			Logo.Parent = Frame;
			Logo.BackgroundTransparency = 1;
			Logo.Position = UDim2.new(0, 10, 0, 10);
			Logo.Size = UDim2.new(0, 45, 0, 45);
			Logo.Image = LogoID;
			Logo.ScaleType = Enum.ScaleType.Fit;
			local Title = Instance.new("TextLabel");
			Title.Parent = Frame;
			Title.BackgroundTransparency = 1;
			Title.Position = UDim2.new(0, 65, 0, 12);
			Title.Size = UDim2.new(1, -70, 0, 20);
			Title.Font = Enum.Font.GothamBold;
			Title.Text = titulo;
			Title.TextColor3 = Color3.fromRGB(255, 255, 255);
			Title.TextSize = 14;
			Title.TextXAlignment = Enum.TextXAlignment.Left;
			Title.TextTruncate = Enum.TextTruncate.AtEnd;
			local Msg = Instance.new("TextLabel");
			Msg.Parent = Frame;
			Msg.BackgroundTransparency = 1;
			Msg.Position = UDim2.new(0, 65, 0, 32);
			Msg.Size = UDim2.new(1, -70, 0, 20);
			Msg.Font = Enum.Font.GothamMedium;
			Msg.Text = mensagem;
			Msg.TextColor3 = Color3.fromRGB(200, 200, 200);
			Msg.TextSize = 12;
			Msg.TextXAlignment = Enum.TextXAlignment.Left;
			Msg.TextTruncate = Enum.TextTruncate.AtEnd;
			local tweenIn = TweenService:Create(Frame, TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(1, -300, .85, 0) });
			tweenIn:Play();
			task.delay(10, function()
				if Frame and Frame.Parent then
					local tweenOut = TweenService:Create(Frame, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = UDim2.new(1, 20, .85, 0) });
					tweenOut:Play();
					tweenOut.Completed:Wait();
					ScreenGui:Destroy();
				end;
			end);
		end);
	if not success then
		warn("[NatAov] l\225\187\151i");
	end;
end;
NotificacaoTuanDz("NatAov Hub", "Script \196\145ang t\225\186\163i vui l\195\178ng ch\225\187\157!!");
local HttpService = Services.HttpService;
local FolderName = "NatAov Hub";
local FileName = "Settings.json";
local FullPath = FolderName .. ("/" .. FileName);
if makefolder and not isfolder(FolderName) then
	makefolder(FolderName);
end;
_G.SaveData = _G.SaveData or {};
function SaveSettings()
	if not writefile then
		return false;
	end;
	local success = pcall(function()
			local json = HttpService:JSONEncode(_G.SaveData);
			writefile(FullPath, json);
		end);
	return success;
end;
function LoadSettings()
	if not (isfile and isfile(FullPath)) then
		return false;
	end;
	local success, result = pcall(function()
			local content = readfile(FullPath);
			return HttpService:JSONDecode(content);
		end);
	if success and result then
		_G.SaveData = result;
		return true;
	end;
	return false;
end;
function GetSetting(name, default)
	return _G.SaveData[name] ~= nil and _G.SaveData[name] or default;
end;
LoadSettings();
local Players = Services.Players;
local CollectionService = Services.CollectionService;
local ReplicatedStorage = Services.ReplicatedStorage;
local player = Players.LocalPlayer;
local commE = (ReplicatedStorage:WaitForChild("Remotes")):WaitForChild("CommE");
_G.AutoKen = true;
local function HasKen()
	local char = player.Character;
	return char and CollectionService:HasTag(char, "Ken");
end;
task.spawn(function()
	while _G.AutoKen do
		task.wait(.2);
		if not HasKen() then
			pcall(function()
				commE:FireServer("Ken", true);
			end);
		end;
	end;
end);
local Lighting = Services.Lighting;
Lighting.Ambient = Color3.new(.695, .695, .695);
Lighting.ColorShift_Bottom = Color3.new(.695, .695, .695);
Lighting.ColorShift_Top = Color3.new(.695, .695, .695);
Lighting.Brightness = 2;
Lighting.FogEnd = 10000000000.0;
do
	ply = Services.Players;
	plr = ply.LocalPlayer;
	Root = plr.Character.HumanoidRootPart;
	replicated = Services.ReplicatedStorage;
	Lv = plr.Data.Level.Value;
	TeleportService = Services.TeleportService;
	TW = Services.TweenService;
	Lighting = Services.Lighting;
	Enemies = workspace.Enemies;
	vim1 = Services.VirtualInputManager;
	vim2 = Services.VirtualUser;
	TeamSelf = plr.Team;
	RunSer = Services.RunService;
	Stats = Services.Stats;
	Energy = plr.Character.Energy.Value;
	Boss = {};
	BringConnections = {};
	MaterialList = {};
	NPCList = {};
	shouldTween = false;
	SoulGuitar = false;
	KenTest = true;
	debug = false;
	Brazier1 = false;
	Brazier2 = false;
	Brazier3 = false;
	Sec = .1;
	ClickState = 0;
	Num_self = 25;
end;
repeat
	local loading = plr.PlayerGui:FindFirstChild("Main");
	loading = loading and loading:FindFirstChild("Loading");
	task.wait();
until game:IsLoaded() and not (loading and loading.Visible);
local placeId = game.PlaceId;
if placeId == 2753915549 or placeId == 85211729168715 then
	World1 = true;
elseif placeId == 4442272183 or placeId == 79091703265657 then
	World2 = true;
elseif placeId == 7449423635 or placeId == 100117331123089 then
	World3 = true;
else
	plr:Kick("\226\157\140 Script ch\225\187\137 h\225\187\151 tr\225\187\163 game blox fruits!");
end;
Marines = function()
		replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines");
	end;
Pirates = function()
		replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates");
	end;
if World1 then
	Boss = {
			"The Gorilla King",
			"Bobby",
			"The Saw",
			"Yeti",
			"Mob Leader",
			"Vice Admiral",
			"Saber Expert",
			"Warden",
			"Chief Warden",
			"Swan",
			"Magma Admiral",
			"Fishman Lord",
			"Wysper",
			"Thunder God",
			"Cyborg",
			"Ice Admiral",
			"Greybeard",
		};
elseif World2 then
	Boss = {
			"Diamond",
			"Jeremy",
			"Fajita",
			"Don Swan",
			"Smoke Admiral",
			"Awakened Ice Admiral",
			"Tide Keeper",
			"Darkbeard",
			"Cursed Captain",
			"Order",
		};
elseif World3 then
	Boss = {
			"Stone",
			"Hydra Leader",
			"Kilo Admiral",
			"Captain Elephant",
			"Beautiful Pirate",
			"Cake Queen",
			"Longma",
			"Soul Reaper",
		};
end;
if World1 then
	MaterialList = {
			"Leather + Scrap Metal",
			"Angel Wings",
			"Magma Ore",
			"Fish Tail",
		};
elseif World2 then
	MaterialList = {
			"Leather + Scrap Metal",
			"Radioactive Material",
			"Ectoplasm",
			"Mystic Droplet",
			"Magma Ore",
			"Vampire Fang",
		};
elseif World3 then
	MaterialList = {
			"Scrap Metal",
			"Demonic Wisp",
			"Conjured Cocoa",
			"Dragon Scale",
			"Gunpowder",
			"Fish Tail",
			"Mini Tusk",
		};
end;
local e = {
		"Flame",
		"Ice",
		"Quake",
		"Light",
		"Dark",
		"String",
		"Rumble",
		"Magma",
		"Human: Buddha",
		"Sand",
		"Bird: Phoenix",
		"Dough",
	};
local K = {
		"Snow Lurker",
		"Arctic Warrior",
		"Hidden Key",
		"Awakened Ice Admiral",
	};
local n = {
		Mob = "Mythological Pirate",
		Mob2 = "Cursed Skeleton",
		"Hell\'s Messenger",
		Mob3 = "Cursed Skeleton",
		"Heaven\'s Guardian",
	};
local d = {
		"Part",
		"SpawnLocation",
		"Terrain",
		"WedgePart",
		"MeshPart",
	};
local z = { "Swan Pirate", "Jeremy" };
local H = { "Forest Pirate", "Captain Elephant" };
local F = { "Fajita", "Jeremy", "Diamond" };
local Q = {
		"Beast Hunter",
		"Lantern",
		"Guardian",
		"Grand Brigade",
		"Dinghy",
		"Sloop",
		"The Sentinel",
	};
local X = {
		"Cookie Crafter",
		"Head Baker",
		"Baking Staff",
		"Cake Guard",
	};
local P = {
		"Reborn Skeleton",
		"Posessed Mummy",
		"Demonic Soul",
		"Living Zombie",
	};
local w = {
		["Pirate Millionaire"] = CFrame.new(-712.82727050781, 98.577049255371, 5711.9541015625),
		["Pistol Billionaire"] = CFrame.new(-723.43316650391, 147.42906188965, 5931.9931640625),
		["Dragon Crew Warrior"] = CFrame.new(7021.5043945312, 55.762702941895, -730.12908935547),
		["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),
		["Female Islander"] = CFrame.new(4692.7939453125, 797.97668457031, 858.84802246094),
		["Venomous Assailant"] = CFrame.new(4902, 670, 39),
		["Marine Commodore"] = CFrame.new(2401, 123, -7589),
		["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),
		["Fishman Raider"] = CFrame.new(-10941, 332, -8760),
		["Fishman Captain"] = CFrame.new(-11035, 332, -9087),
		["Forest Pirate"] = CFrame.new(-13446, 413, -7760),
		["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),
		["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),
		["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),
		["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),
		["Living Zombie"] = CFrame.new(-10227, 421, 6161),
		["Demonic Soul"] = CFrame.new(-9579, 6, 6194),
		["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),
		["Peanut Scout"] = CFrame.new(-1993, 187, -10103),
		["Peanut President"] = CFrame.new(-2215, 159, -10474),
		["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),
		["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),
		["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),
		["Cake Guard"] = CFrame.new(-2024, 38, -12026),
		["Baking Staff"] = CFrame.new(-1932, 38, -12848),
		["Head Baker"] = CFrame.new(-1932, 38, -12848),
		["Cocoa Warrior"] = CFrame.new(95, 73, -12309),
		["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),
		["Sweet Thief"] = CFrame.new(116, 36, -12478),
		["Candy Rebel"] = CFrame.new(47, 61, -12889),
		Ghost = CFrame.new(5251, 5, 1111),
	};
EquipWeapon = function(I)
		if not I then
			return;
		end;
		if plr.Backpack:FindFirstChild(I) then
			plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(I));
		end;
	end;
weaponSc = function(I)
		for e, K in pairs(plr.Backpack:GetChildren()) do
			if K:IsA("Tool") then
				if K.ToolTip == I then
					EquipWeapon(K.Name);
				end;
			end;
		end;
	end;
hookfunction(require((game:GetService("ReplicatedStorage")).Effect.Container.Death), function()
 
end);
hookfunction((require((game:GetService("ReplicatedStorage")):WaitForChild("GuideModule"))).ChangeDisplayedNPC, function()
 
end);
hookfunction(error, function()
 
end);
hookfunction(warn, function()
 
end);
local O = workspace:FindFirstChild("Rocks");
if O then
	O:Destroy();
end;
gay = (function()
		local I = game:GetService("Lighting");
		local e = I:FindFirstChild("LightingLayers");
		local K = workspace._WorldOrigin["Foam;"];
		if K and workspace._WorldOrigin["Foam;"] then
			K:Destroy();
		end;
	end)();
local G = {};
G.__index = G;
G.Alive = function(I)
		if not I then
			return;
		end;
		local e = I:FindFirstChild("Humanoid");
		return e and e.Health > 0;
	end;
G.Pos = function(I, e)
		return (Root.Position - mode.Position).Magnitude <= e;
	end;
G.Dist = function(I, e)
		return (Root.Position - (I:FindFirstChild("HumanoidRootPart")).Position).Magnitude <= e;
	end;
G.DistH = function(I, e)
		return (Root.Position - (I:FindFirstChild("HumanoidRootPart")).Position).Magnitude > e;
	end;
_G.MobHeight = _G.MobHeight or 20;
G.Kill = function(I, e)
		if not (I and e) then
			return;
		end;
		local hrp = I:FindFirstChild("HumanoidRootPart");
		if not hrp then
			return;
		end;
		if not I:GetAttribute("Locked") then
			I:SetAttribute("Locked", hrp.CFrame);
		end;
		PosMon = (I:GetAttribute("Locked")).Position;
		_B = true;
		BringEnemy();
		EquipWeapon(_G.SelectWeapon);
		local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool");
		if not tool then
			return;
		end;
		_tp(hrp.CFrame * CFrame.new(0, _G.MobHeight, 0));
	end;
G.Kill2 = function(I, e)
		if I and e then
			if not I:GetAttribute("Locked") then
				I:SetAttribute("Locked", I.HumanoidRootPart.CFrame);
			end;
			PosMon = (I:GetAttribute("Locked")).Position;
			BringEnemy();
			EquipWeapon(_G.SelectWeapon);
			local e = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool");
			local K = e.ToolTip;
			if K == "Blox Fruit" then
				_tp((I.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)) * CFrame.Angles(0, math.rad(90), 0));
			else
				_tp((I.HumanoidRootPart.CFrame * CFrame.new(0, 20, 8)) * CFrame.Angles(0, math.rad(180), 0));
			end;
			if RandomCFrame then
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0));
			end;
		end;
	end;
G.KillSea = function(I, e)
		if I and e then
			if not I:GetAttribute("Locked") then
				I:SetAttribute("Locked", I.HumanoidRootPart.CFrame);
			end;
			PosMon = (I:GetAttribute("Locked")).Position;
			BringEnemy();
			EquipWeapon(_G.SelectWeapon);
			local e = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool");
			local K = e.ToolTip;
			if K == "Blox Fruit" then
				_tp((I.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)) * CFrame.Angles(0, math.rad(90), 0));
			else
				notween(I.HumanoidRootPart.CFrame * CFrame.new(0, 50, 8));
				wait(.85);
				notween(I.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0));
				wait(1);
			end;
		end;
	end;
G.Sword = function(I, e)
		if I and e then
			if not I:GetAttribute("Locked") then
				I:SetAttribute("Locked", I.HumanoidRootPart.CFrame);
			end;
			PosMon = (I:GetAttribute("Locked")).Position;
			BringEnemy();
			weaponSc("Sword");
			_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
			if RandomCFrame then
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0));
			end;
		end;
	end;
_G.FruitSkills = {
		Z = false,
		X = false,
		C = false,
		V = false,
		F = false,
	};
UseFruitSkills = function()
		weaponSc("Blox Fruit");
		if _G.FruitSkills.Z then
			Useskills("Blox Fruit", "Z");
		end;
		if _G.FruitSkills.X then
			Useskills("Blox Fruit", "X");
		end;
		if _G.FruitSkills.C then
			Useskills("Blox Fruit", "C");
		end;
		if _G.FruitSkills.V then
			Useskills("Blox Fruit", "V");
		end;
		if _G.FruitSkills.F then
			vim1:SendKeyEvent(true, "F", false, game);
			vim1:SendKeyEvent(false, "F", false, game);
		end;
	end;
G.Mas = function(I, e)
		if I and e then
			if not I:GetAttribute("Locked") then
				I:SetAttribute("Locked", I.HumanoidRootPart.CFrame);
			end;
			PosMon = (I:GetAttribute("Locked")).Position;
			BringEnemy();
			if I.Humanoid.Health <= HealthM then
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0));
				UseFruitSkills();
			else
				weaponSc("Melee");
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
			end;
		end;
	end;
G.Masgun = function(I, e)
		if I and e then
			if not I:GetAttribute("Locked") then
				I:SetAttribute("Locked", I.HumanoidRootPart.CFrame);
			end;
			PosMon = (I:GetAttribute("Locked")).Position;
			BringEnemy();
			if I.Humanoid.Health <= HealthM then
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 35, 8));
				Useskills("Gun", "Z");
				Useskills("Gun", "X");
			else
				weaponSc("Melee");
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
			end;
		end;
	end;
statsSetings = function(I, e)
		if I == "Melee" then
			if plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Melee", e);
			end;
		elseif I == "Defense" then
			if plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Defense", e);
			end;
		elseif I == "Sword" then
			if plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Sword", e);
			end;
		elseif I == "Gun" then
			if plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Gun", e);
			end;
		elseif I == "Devil" then
			if plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", e);
			end;
		end;
	end;
_B = _B or false;
_G.BringRange = _G.BringRange or 300;
_G.SpeedB = _G.SpeedB or 300;
_G.MobM = _G.MobM or 6;
local Players = game:GetService("Players");
local TS = game:GetService("TweenService");
local plr = Players.LocalPlayer;
_G.FarmPriorityElf = _G.FarmPriorityElf or false;
_G.FarmMastery_S = _G.FarmMastery_S or false;
local function FarmAtivo()
	if _G.FarmPriorityElf or _G.FarmElfLevelCustom then
		return true;
	end;
	if _G.FarmMastery_S then
		return true;
	end;
	return _G.StartFarm and (_G.Level or _G.AutoFarm_Bone or _G.AutoFarm_Cake or _G.FarmMastery_Dev or _G.FarmMastery_G or (getgenv()).AutoMaterial or _G.AutoTyrant or _G.SailBoat_Hydra or _G.WardenBoss or _G.AutoFactory or _G.HighestMirage or _G.HCM or _G.PGB or _G.Leviathan1 or _G.UPGDrago or _G.Complete_Trials or _G.TpDrago_Prehis or _G.BuyDrago or _G.AutoFireFlowers or _G.DT_Uzoth or _G.AutoBerry or _G.Prehis_Find or _G.Prehis_Skills or _G.Prehis_DB or _G.Prehis_DE or _G.FarmBlazeEM or _G.Dojoo or _G.CollectPresent or _G.AutoLawKak or _G.TpLab or _G.AutoPhoenixF or _G.AutoFarmChest or _G.AutoHytHallow or _G.LongsWord or _G.BlackSpikey or _G.AutoHolyTorch or _G.TrainDrago or _G.AutoSaber or _G.FarmMastery_Dev or _G.CitizenQuest or _G.AutoEctoplasm or _G.KeysRen or _G.Auto_Rainbow_Haki or _G.obsFarm or _G.AutoBigmom or _G.Doughv2 or _G.AuraBoss or _G.Raiding or _G.Auto_Cavender or _G.TpPly or _G.Bartilo_Quest or _G.Level or _G.FarmEliteHunt or _G.AutoZou or _G.AutoFarm_Bone or (getgenv()).AutoMaterial or _G.CraftVM or _G.FrozenTP or _G.TPDoor or _G.AcientOne or _G.AutoFarmNear or _G.AutoRaidCastle or _G.DarkBladev3 or _G.AutoFarmRaid or _G.Auto_Cake_Prince or _G.Addealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.FarmChestM or _G.Shark or _G.TerrorShark or _G.Piranha or _G.MobCrew or _G.SeaBeast1 or _G.FishBoat or _G.Auto or _G.AutoPoleV2 or _G.Auto_SuperHuman or _G.AutoDeathStep or _G.Auto_SharkMan_Karate or _G.Auto_Electric_Claw or _G.AutoDragonTalon or _G.Auto_Def_DarkCoat or _G.Auto_God_Human or _G.Auto_Tushita or _G.AutoMatSoul or _G.AutoKenVTWO or _G.AutoSerpentBow or _G.AutoFMon or _G.Auto_Soul_Guitar or _G.TPGEAR or _G.AutoSaw or _G.AutoTridentW2 or _G.Auto_StartRaid or _G.AutoEvoRace or _G.AutoGetQuestBounty or _G.MarinesCoat or _G.TravelDres or _G.Defeating or _G.DummyMan or _G.Auto_Yama or _G.Auto_SwanGG or _G.SwanCoat or _G.AutoEcBoss or _G.Auto_Mink or _G.Auto_Human or _G.Auto_Skypiea or _G.Auto_Fish or _G.CDK_TS or _G.CDK_YM or _G.CDK or _G.AutoFarmGodChalice or _G.AutoFistDarkness or _G.AutoMiror or _G.Teleport or _G.AutoKilo or _G.AutoGetUsoap or _G.Praying or _G.TryLucky or _G.AutoColShad or _G.AutoUnHaki or _G.Auto_DonAcces or _G.AutoRipIngay or _G.DragoV3 or _G.DragoV1 or _G.SailBoats or NextIs or _G.FarmGodChalice or _G.IceBossRen or senth or senth2 or _G.Lvthan or _G.beasthunter or _G.DangerLV or _G.Relic123 or _G.tweenKitsune or _G.Collect_Ember or _G.AutofindKitIs or _G.snaguine or _G.TwFruits or _G.tweenKitShrine or _G.Tp_LgS or _G.Tp_MasterA or _G.tweenShrine or _G.FarmMastery_G or _G.FarmMastery_S);
end;
local function IsRaidMob(mob)
	local n = mob.Name:lower();
	if n:find("raid") or n:find("microchip") or n:find("island") then
		return true;
	end;
	if mob:GetAttribute("IsRaid") or mob:GetAttribute("RaidMob") or mob:GetAttribute("IsBoss") then
		return true;
	end;
	local hum = mob:FindFirstChild("Humanoid");
	if hum and hum.WalkSpeed == 0 then
		return true;
	end;
	if mob.Parent and ((tostring(mob.Parent)):lower()):find("_worldorigin") then
		return true;
	end;
	return false;
end;
local function isBossMob(mob)
	if not Boss then
		return false;
	end;
	for _, b in ipairs(Boss) do
		if mob.Name == b then
			return true;
		end;
	end;
	return false;
end;
BringEnemy = function()
		if not _B then
			return;
		end;
		if not PosMon then
			return;
		end;
		local char = plr.Character;
		local hrpPlr = char and char:FindFirstChild("HumanoidRootPart");
		if not hrpPlr then
			return;
		end;
		local range = tonumber(_G.BringRange) or 350;
		local speed = tonumber(_G.SpeedB) or 300;
		local maxMob = tonumber(_G.MobM) or 6;
		pcall(function()
			sethiddenproperty(plr, "SimulationRadius", math.huge);
		end);
		local list = {};
		local enemies = workspace:FindFirstChild("Enemies");
		if not enemies then
			return;
		end;
		for _, v in ipairs(enemies:GetChildren()) do
			if #list >= maxMob then
				break;
			end;
			if not v:IsA("Model") then
				continue;
			end;
			if isBossMob(v) then
				continue;
			end;
			local hum = v:FindFirstChildOfClass("Humanoid");
			local pp = v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");
			if hum and (pp and hum.Health > 0) then
				local dist = (pp.Position - PosMon).Magnitude;
				if dist <= range and dist > 5 then
					list[#list + 1] = { mob = v, hum = hum, pp = pp };
				end;
			end;
		end;
		if #list == 0 then
			return;
		end;
		local targetCF = CFrame.new(PosMon);
		for _, it in ipairs(list) do
			local v = it.mob;
			local hum = it.hum;
			local pp = it.pp;
			if not v.Parent then
				continue;
			end;
			hum.WalkSpeed = 0;
			hum.JumpPower = 0;
			pp.CanCollide = false;
			pp.AssemblyLinearVelocity = Vector3.zero;
			pp.AssemblyAngularVelocity = Vector3.zero;
			if speed <= 0 then
				pp.CFrame = targetCF;
			else
				local dist = (pp.Position - PosMon).Magnitude;
				local t = math.clamp(dist / speed, .05, .5);
				local tween = TS:Create(pp, TweenInfo.new(t, Enum.EasingStyle.Linear), { CFrame = targetCF });
				tween:Play();
			end;
		end;
	end;
task.spawn(function()
	while task.wait(1) do
		if FarmAtivo() then
			_B = true;
			BringEnemy();
			task.wait(3);
			_B = false;
			task.wait(5);
		else
			_B = false;
			task.wait(1);
		end;
	end;
end);
Useskills = function(I, e)
		if I == "Melee" then
			weaponSc("Melee");
			if e == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif e == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			elseif e == "C" then
				vim1:SendKeyEvent(true, "C", false, game);
				vim1:SendKeyEvent(false, "C", false, game);
			end;
		elseif I == "Sword" then
			weaponSc("Sword");
			if e == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif e == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			end;
		elseif I == "Blox Fruit" then
			weaponSc("Blox Fruit");
			if e == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif e == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			elseif e == "C" then
				vim1:SendKeyEvent(true, "C", false, game);
				vim1:SendKeyEvent(false, "C", false, game);
			elseif e == "V" then
				vim1:SendKeyEvent(true, "V", false, game);
				vim1:SendKeyEvent(false, "V", false, game);
			end;
		elseif I == "Gun" then
			weaponSc("Gun");
			if e == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif e == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			end;
		end;
		if I == "nil" and e == "Y" then
			vim1:SendKeyEvent(true, "Y", false, game);
			vim1:SendKeyEvent(false, "Y", false, game);
		end;
	end;
local J = getrawmetatable(game);
local i = J.__namecall;
setreadonly(J, false);
J.__namecall = newcclosure(function(...)
		local I = getnamecallmethod();
		local e = { ... };
		if tostring(I) == "FireServer" then
			if tostring(e[1]) == "RemoteEvent" then
				if tostring(e[2]) ~= "true" and tostring(e[2]) ~= "false" then
					if _G.FarmMastery_G and not SoulGuitar or _G.FarmMastery_Dev or _G.FarmBlazeEM or _G.Prehis_Skills or _G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1 or _G.Complete_Trials or _G.AimMethod and ABmethod == "AimBots Skill" or _G.AimMethod and ABmethod == "Auto Aimbots" then
						e[2] = MousePos;
						return i(unpack(e));
					end;
				end;
			end;
		end;
		return i(...);
	end);
GetConnectionEnemies = function(I)
		for e, K in pairs(replicated:GetChildren()) do
			if K:IsA("Model") and ((typeof(I) == "table" and table.find(I, K.Name) or K.Name == I) and (K:FindFirstChild("Humanoid") and K.Humanoid.Health > 0)) then
				return K;
			end;
		end;
		for e, K in next, game.Workspace.Enemies:GetChildren() do
			if K:IsA("Model") and ((typeof(I) == "table" and table.find(I, K.Name) or K.Name == I) and (K:FindFirstChild("Humanoid") and K.Humanoid.Health > 0)) then
				return K;
			end;
		end;
	end;
LowCpu = function()
		local I = true;
		local e = game;
		local K = e.Workspace;
		local n = e.Lighting;
		local d = K.Terrain;
		d.WaterWaveSize = 0;
		d.WaterWaveSpeed = 0;
		d.WaterReflectance = 0;
		d.WaterTransparency = 0;
		n.GlobalShadows = false;
		n.FogEnd = 9000000000.0;
		n.Brightness = 1;
		(settings()).Rendering.QualityLevel = "Level01";
		for e, K in pairs(e:GetDescendants()) do
			if K:IsA("Part") or K:IsA("Union") or K:IsA("CornerWedgePart") or K:IsA("TrussPart") then
				K.Material = "Plastic";
				K.Reflectance = 0;
			elseif K:IsA("Decal") or K:IsA("Texture") and I then
				K.Transparency = 1;
			elseif K:IsA("ParticleEmitter") or K:IsA("Trail") then
				K.Lifetime = NumberRange.new(0);
			elseif K:IsA("Explosion") then
				K.BlastPressure = 1;
				K.BlastRadius = 1;
			elseif K:IsA("Fire") or K:IsA("SpotLight") or K:IsA("Smoke") or K:IsA("Sparkles") then
				K.Enabled = false;
			elseif K:IsA("MeshPart") then
				K.Material = "Plastic";
				K.Reflectance = 0;
				K.TextureID = 10385902758728957;
			end;
		end;
		for I, e in pairs(n:GetChildren()) do
			if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
				e.Enabled = false;
			end;
		end;
	end;
CheckF = function()
		if GetBP("Dragon-Dragon") or GetBP("Gas-Gas") or GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune") or GetBP("T-Rex-T-Rex") then
			return true;
		end;
	end;
CheckBoat = function()
		for I, e in pairs(workspace.Boats:GetChildren()) do
			if tostring(e.Owner.Value) == tostring(plr.Name) then
				return e;
			end;
		end;
		return false;
	end;
CheckEnemiesBoat = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == "FishBoat" and (e:FindFirstChild("Health")).Value > 0 then
				return true;
			end;
		end;
		return false;
	end;
CheckPirateGrandBrigade = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if (e.Name == "PirateGrandBrigade" or e.Name == "PirateBrigade") and (e:FindFirstChild("Health")).Value > 0 then
				return true;
			end;
		end;
		return false;
	end;
CheckShark = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == "Shark" and G.Alive(e) then
				return true;
			end;
		end;
		return false;
	end;
CheckTerrorShark = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == "Terrorshark" and G.Alive(e) then
				return true;
			end;
		end;
		return false;
	end;
CheckPiranha = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == "Piranha" and G.Alive(e) then
				return true;
			end;
		end;
		return false;
	end;
CheckFishCrew = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if (e.Name == "Fish Crew Member" or e.Name == "Haunted Crew Member") and G.Alive(e) then
				return true;
			end;
		end;
		return false;
	end;
CheckHauntedCrew = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == "Haunted Crew Member" and G.Alive(e) then
				return true;
			end;
		end;
		return false;
	end;
CheckSeaBeast = function()
		if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
			return true;
		end;
		return false;
	end;
CheckLeviathan = function()
		if workspace.SeaBeasts:FindFirstChild("Leviathan") then
			return true;
		end;
		return false;
	end;
UpdStFruit = function()
		for I, e in next, plr.Backpack:GetChildren() do
			StoreFruit = e:FindFirstChild("EatRemote", true);
			if StoreFruit then
				replicated.Remotes.CommF_:InvokeServer("StoreFruit", StoreFruit.Parent:GetAttribute("OriginalName"), plr.Backpack:FindFirstChild(e.Name));
			end;
		end;
	end;
collectFruits = function(I)
		if I then
			local I = plr.Character;
			for e, K in pairs(workspace:GetChildren()) do
				if string.find(K.Name, "Fruit") then
					K.Handle.CFrame = I.HumanoidRootPart.CFrame;
				end;
			end;
		end;
	end;
Getmoon = function()
		if World1 then
			return Lighting.FantasySky.MoonTextureId;
		elseif World2 then
			return Lighting.FantasySky.MoonTextureId;
		elseif World3 then
			return Lighting.Sky.MoonTextureId;
		end;
	end;
DropFruits = function()
		for I, e in next, plr.Backpack:GetChildren() do
			if string.find(e.Name, "Fruit") then
				EquipWeapon(e.Name);
				wait(.1);
				if plr.PlayerGui.Main.Dialogue.Visible == true then
					plr.PlayerGui.Main.Dialogue.Visible = false;
				end;
				EquipWeapon(e.Name);
				(plr.Character:FindFirstChild(e.Name)).EatRemote:InvokeServer("Drop");
			end;
		end;
		for I, e in pairs(plr.Character:GetChildren()) do
			if string.find(e.Name, "Fruit") then
				EquipWeapon(e.Name);
				wait(.1);
				if plr.PlayerGui.Main.Dialogue.Visible == true then
					plr.PlayerGui.Main.Dialogue.Visible = false;
				end;
				EquipWeapon(e.Name);
				(plr.Character:FindFirstChild(e.Name)).EatRemote:InvokeServer("Drop");
			end;
		end;
	end;
GetBP = function(I)
		return plr.Backpack:FindFirstChild(I) or plr.Character:FindFirstChild(I);
	end;
GetIn = function(I)
		for e, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(K) == "table" then
				if K.Name == I or plr.Character:FindFirstChild(I) or plr.Backpack:FindFirstChild(I) then
					return true;
				end;
			end;
		end;
		return false;
	end;
GetM = function(I)
		for e, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(K) == "table" then
				if K.Type == "Material" then
					if K.Name == I then
						return K.Count;
					end;
				end;
			end;
		end;
		return 0;
	end;
GetWP = function(I)
		for e, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(K) == "table" then
				if K.Type == "Sword" then
					if K.Name == I or plr.Character:FindFirstChild(I) or plr.Backpack:FindFirstChild(I) then
						return true;
					end;
				end;
			end;
		end;
		return false;
	end;
getInfinity_Ability = function(I, e)
		if not Root then
			return;
		end;
		if I == "Soru" and e then
			for I, K in next, getgc() do
				if plr.Character.Soru then
					if typeof(K) == "function" and (getfenv(K)).script == plr.Character.Soru then
						for I, K in next, getupvalues(K) do
							if typeof(K) == "table" then
								repeat
									wait(Sec);
									K.LastUse = 0;
								until not e or plr.Character.Humanoid.Health <= 0;
							end;
						end;
					end;
				end;
			end;
		elseif I == "Energy" and e then
			plr.Character.Energy.Changed:connect(function()
				if e then
					plr.Character.Energy.Value = Energy;
				end;
			end);
		elseif I == "Observation" and e then
			local I = plr.VisionRadius;
			I.Value = math.huge;
		end;
	end;
Hop = function()
		pcall(function()
			for I = math.random(1, math.random(40, 75)), 100, 1 do
				local e = replicated.__ServerBrowser:InvokeServer(I);
				for I, e in next, e do
					if tonumber(e.Count) < 12 then
						TeleportService:TeleportToPlaceInstance(game.PlaceId, I);
					end;
				end;
			end;
		end);
	end;
local C = Instance.new("Part", workspace);
C.Size = Vector3.new(1, 1, 1);
C.Name = "Rip_Indra";
C.Anchored = true;
C.CanCollide = false;
C.CanTouch = false;
C.Transparency = 1;
local M = workspace:FindFirstChild(C.Name);
if M and M ~= C then
	M:Destroy();
end;
task.spawn(function()
	while task.wait() do
		if C and C.Parent == workspace then
			if shouldTween then
				(getgenv()).OnFarm = true;
			else
				(getgenv()).OnFarm = false;
			end;
		else
			(getgenv()).OnFarm = false;
		end;
	end;
end);
task.spawn(function()
	local I = game.Players.LocalPlayer;
	repeat
		task.wait();
	until I.Character and I.Character.PrimaryPart;
	C.CFrame = I.Character.PrimaryPart.CFrame;
	while task.wait() do
		pcall(function()
			if (getgenv()).OnFarm then
				if C and C.Parent == workspace then
					local e = I.Character and I.Character.PrimaryPart;
					if e and (e.Position - C.Position).Magnitude <= 200 then
						e.CFrame = C.CFrame;
					else
						C.CFrame = e.CFrame;
					end;
				end;
				local e = I.Character;
				if e then
					for _, v in pairs(e:GetChildren()) do
						if v:IsA("BasePart") then
							v.CanCollide = false;
						end;
					end;
				end;
			else
				local e = I.Character;
				if e then
					for _, v in pairs(e:GetChildren()) do
						if v:IsA("BasePart") then
							v.CanCollide = true;
						end;
					end;
				end;
			end;
		end);
	end;
end);
(getgenv()).TweenSpeedFar = 310;
(getgenv()).TweenSpeedNear = 710;
_tp = function(I)
		local e = plr.Character;
		if not e or not e:FindFirstChild("HumanoidRootPart") then
			return;
		end;
		local HRP = e.HumanoidRootPart;
		shouldTween = true;
		(getgenv()).OnFarm = false;
		if HRP.Anchored then
			HRP.Anchored = false;
			task.wait();
		end;
		local dist = (I.Position - HRP.Position).Magnitude;
		local speed = dist <= 15 and ((getgenv()).TweenSpeedNear or 600) or (getgenv()).TweenSpeedFar or 300;
		local info = TweenInfo.new(dist / speed, Enum.EasingStyle.Linear);
		local tween = (game:GetService("TweenService")):Create(C, info, { CFrame = I });
		if e.Humanoid.Sit == true then
			C.CFrame = CFrame.new(C.Position.X, I.Y, C.Position.Z);
		end;
		tween:Play();
		task.spawn(function()
			while tween.PlaybackState == Enum.PlaybackState.Playing do
				if not shouldTween then
					tween:Cancel();
					break;
				end;
				task.wait(.1);
			end;
			(getgenv()).OnFarm = true;
		end);
	end;
TeleportToTarget = function(I)
		_tp(I);
	end;
notween = function(I)
		plr.Character.HumanoidRootPart.CFrame = I;
	end;
function BTP(I)
	local e = game.Players.LocalPlayer;
	local K = e.Character.HumanoidRootPart;
	local n = e.Character.Humanoid;
	local d = e.PlayerGui.Main;
	local z = I.Position;
	local H = K.Position;
	repeat
		n.Health = 0;
		K.CFrame = I;
		d.Quest.Visible = false;
		if (K.Position - H).Magnitude > 1 then
			H = K.Position;
			K.CFrame = I;
		end;
		task.wait(.5);
	until (I.Position - K.Position).Magnitude <= 2000;
end;
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SailBoat_Hydra or _G.WardenBoss or _G.AutoFactory or _G.HighestMirage or _G.HCM or _G.PGB or _G.Leviathan1 or _G.UPGDrago or _G.Complete_Trials or _G.TpDrago_Prehis or _G.BuyDrago or _G.AutoFireFlowers or _G.DT_Uzoth or _G.AutoBerry or _G.Prehis_Find or _G.Prehis_Skills or _G.Prehis_DB or _G.Prehis_DE or _G.FarmBlazeEM or _G.Dojoo or _G.CollectPresent or _G.AutoLawKak or _G.TpLab or _G.AutoPhoenixF or _G.AutoFarmChest or _G.AutoHytHallow or _G.LongsWord or _G.BlackSpikey or _G.AutoHolyTorch or _G.TrainDrago or _G.AutoSaber or _G.FarmMastery_Dev or _G.CitizenQuest or _G.AutoEctoplasm or _G.KeysRen or _G.Auto_Rainbow_Haki or _G.obsFarm or _G.AutoBigmom or _G.Doughv2 or _G.AuraBoss or _G.Raiding or _G.Auto_Cavender or _G.TpPly or _G.Bartilo_Quest or _G.Level or _G.FarmEliteHunt or _G.AutoZou or _G.AutoFarm_Bone or (getgenv()).AutoMaterial or _G.CraftVM or _G.FrozenTP or _G.TPDoor or _G.AcientOne or _G.AutoFarmNear or _G.AutoRaidCastle or _G.DarkBladev3 or _G.AutoFarmRaid or _G.Auto_Cake_Prince or _G.Addealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.FarmChestM or _G.Shark or _G.TerrorShark or _G.Piranha or _G.MobCrew or _G.SeaBeast1 or _G.FishBoat or _G.Auto or _G.AutoPoleV2 or _G.Auto_SuperHuman or _G.AutoDeathStep or _G.Auto_SharkMan_Karate or _G.Auto_Electric_Claw or _G.AutoDragonTalon or _G.Auto_Def_DarkCoat or _G.Auto_God_Human or _G.Auto_Tushita or _G.AutoMatSoul or _G.AutoKenVTWO or _G.AutoSerpentBow or _G.AutoFMon or _G.Auto_Soul_Guitar or _G.TPGEAR or _G.AutoSaw or _G.AutoTridentW2 or _G.Auto_StartRaid or _G.AutoEvoRace or _G.AutoGetQuestBounty or _G.MarinesCoat or _G.TravelDres or _G.Defeating or _G.DummyMan or _G.Auto_Yama or _G.Auto_SwanGG or _G.SwanCoat or _G.AutoEcBoss or _G.Auto_Mink or _G.Auto_Human or _G.Auto_Skypiea or _G.Auto_Fish or _G.CDK_TS or _G.CDK_YM or _G.CDK or _G.AutoFarmGodChalice or _G.AutoFistDarkness or _G.AutoMiror or _G.Teleport or _G.AutoKilo or _G.AutoGetUsoap or _G.Praying or _G.TryLucky or _G.AutoColShad or _G.AutoUnHaki or _G.Auto_DonAcces or _G.AutoRipIngay or _G.DragoV3 or _G.DragoV1 or _G.SailBoats or NextIs or _G.FarmGodChalice or _G.IceBossRen or senth or senth2 or _G.Lvthan or _G.beasthunter or _G.DangerLV or _G.Relic123 or _G.tweenKitsune or _G.Collect_Ember or _G.AutofindKitIs or _G.snaguine or _G.TwFruits or _G.tweenKitShrine or _G.Tp_LgS or _G.Tp_MasterA or _G.tweenShrine or _G.FarmMastery_G or _G.FarmMastery_S then
				shouldTween = true;
				if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					local I = Instance.new("BodyVelocity");
					I.Name = "BodyClip";
					I.Parent = plr.Character.HumanoidRootPart;
					I.MaxForce = Vector3.new(100000, 100000, 100000);
					I.Velocity = Vector3.new(0, 0, 0);
				end;
				for I, e in pairs(plr.Character:GetDescendants()) do
					if e:IsA("BasePart") then
						e.CanCollide = false;
					end;
				end;
			else
				shouldTween = false;
				if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					(plr.Character.HumanoidRootPart:FindFirstChild("BodyClip")):Destroy();
				end;
				if plr.Character:FindFirstChild("highlight") then
					(plr.Character:FindFirstChild("highlight")):Destroy();
				end;
			end;
		end);
	end;
end);
QuestB = function()
		if World1 then
			if _G.FindBoss == "The Gorilla King" then
				bMon = "The Gorilla King";
				Qname = "JungleQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102);
				PosB = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, .707079291, 0, 1, 0, -0.707079291, 0, -0.707134247);
			elseif _G.FindBoss == "Bobby" then
				bMon = "Bobby";
				Qname = "BuggyQuest1";
				Qdata = 3;
				PosQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188);
				PosB = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344);
			elseif _G.FindBoss == "The Saw" then
				bMon = "The Saw";
				PosB = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906);
			elseif _G.FindBoss == "Yeti" then
				bMon = "Yeti";
				Qname = "SnowQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156);
				PosB = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172);
			elseif _G.FindBoss == "Mob Leader" then
				bMon = "Mob Leader";
				PosB = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813);
			elseif _G.FindBoss == "Vice Admiral" then
				bMon = "Vice Admiral";
				Qname = "MarineQuest2";
				Qdata = 2;
				PosQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625);
				PosB = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375);
			elseif _G.FindBoss == "Saber Expert" then
				bMon = "Saber Expert";
				PosB = CFrame.new(-1458.89502, 29.8870335, -50.633564);
			elseif _G.FindBoss == "Warden" then
				bMon = "Warden";
				Qname = "ImpelQuest";
				Qdata = 1;
				PosB = CFrame.new(5278.04932, 2.15167475, 944.101929, .220546961, -4.49946401e-006, .975376427, -1.95412576e-005, 1, 9.03162072e-006, -0.975376427, -2.10519756e-005, .220546961);
				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, .681965172, 0, 1, 0, -0.681965172, 0, -0.731384635);
			elseif _G.FindBoss == "Chief Warden" then
				bMon = "Chief Warden";
				Qname = "ImpelQuest";
				Qdata = 2;
				PosB = CFrame.new(5206.92578, .997753382, 814.976746, .342041343, -0.00062915677, .939684749, .00191645394, .999998152, -2.80422337e-005, -0.939682961, .00181045406, .342041939);
				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, .681965172, 0, 1, 0, -0.681965172, 0, -0.731384635);
			elseif _G.FindBoss == "Swan" then
				bMon = "Swan";
				Qname = "ImpelQuest";
				Qdata = 3;
				PosB = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, .951042235, 0, 1, 0, -0.951042235, 0, -0.309060812);
				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, .681965172, 0, 1, 0, -0.681965172, 0, -0.731384635);
			elseif _G.FindBoss == "Magma Admiral" then
				bMon = "Magma Admiral";
				Qname = "MagmaQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875);
				PosB = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875);
			elseif _G.FindBoss == "Fishman Lord" then
				bMon = "Fishman Lord";
				Qname = "FishmanQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734);
				PosB = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984);
			elseif _G.FindBoss == "Wysper" then
				bMon = "Wysper";
				Qname = "SkyExp1Quest";
				Qdata = 3;
				PosQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094);
				PosB = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531);
			elseif _G.FindBoss == "Thunder God" then
				bMon = "Thunder God";
				Qname = "SkyExp2Quest";
				Qdata = 3;
				PosQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125);
				PosB = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188);
			elseif _G.FindBoss == "Cyborg" then
				bMon = "Cyborg";
				Qname = "FountainQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875);
				PosB = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813);
			elseif _G.FindBoss == "Ice Admiral" then
				bMon = "Ice Admiral";
				Qdata = nil;
				PosQBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, .81913656, 0, -0.573599219);
				PosB = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, .81913656, 0, -0.573599219);
			elseif _G.FindBoss == "Greybeard" then
				bMon = "Greybeard";
				Qdata = nil;
				PosQBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188);
				PosB = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188);
			end;
		end;
		if World2 then
			if _G.FindBoss == "Diamond" then
				bMon = "Diamond";
				Qname = "Area1Quest";
				Qdata = 3;
				PosQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375);
				PosB = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407);
			elseif _G.FindBoss == "Jeremy" then
				bMon = "Jeremy";
				Qname = "Area2Quest";
				Qdata = 3;
				PosQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063);
				PosB = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109);
			elseif _G.FindBoss == "Fajita" then
				bMon = "Fajita";
				Qname = "MarineQuest3";
				Qdata = 3;
				PosQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031);
				PosB = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625);
			elseif _G.FindBoss == "Don Swan" then
				bMon = "Don Swan";
				PosB = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875);
			elseif _G.FindBoss == "Smoke Admiral" then
				bMon = "Smoke Admiral";
				Qname = "IceSideQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813);
				PosB = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875);
			elseif _G.FindBoss == "Awakened Ice Admiral" then
				bMon = "Awakened Ice Admiral";
				Qname = "FrostQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813);
				PosB = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125);
			elseif _G.FindBoss == "Tide Keeper" then
				bMon = "Tide Keeper";
				Qname = "ForgottenQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625);
				PosB = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188);
			elseif _G.FindBoss == "Darkbeard" then
				bMon = "Darkbeard";
				Qdata = nil;
				PosQBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531);
				PosB = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531);
			elseif _G.FindBoss == "Cursed Captaim" then
				bMon = "Cursed Captain";
				Qdata = nil;
				PosQBoss = CFrame.new(916.928589, 181.092773, 33422);
				PosB = CFrame.new(916.928589, 181.092773, 33422);
			elseif _G.FindBoss == "Order" then
				bMon = "Order";
				Qdata = nil;
				PosQBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875);
				PosB = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875);
			end;
		end;
		if World3 then
			if _G.FindBoss == "Stone" then
				bMon = "Stone";
				Qname = "PiratePortQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625);
				PosB = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438);
			elseif _G.FindBoss == "Hydra Leader" then
				bMon = "Hydra Leader";
				Qname = "AmazonQuest2";
				Qdata = 3;
				PosQBoss = CFrame.new(5821.8979492188, 1019.0950927734, -73.719230651855);
				PosB = CFrame.new(5821.8979492188, 1019.0950927734, -73.719230651855);
			elseif _G.FindBoss == "Kilo Admiral" then
				bMon = "Kilo Admiral";
				Qname = "MarineTreeIsland";
				Qdata = 3;
				PosQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938);
				PosB = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125);
			elseif _G.FindBoss == "Captain Elephant" then
				bMon = "Captain Elephant";
				Qname = "DeepForestIsland";
				Qdata = 3;
				PosQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875);
				PosB = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125);
			elseif _G.FindBoss == "Beautiful Pirate" then
				bMon = "Beautiful Pirate";
				Qname = "DeepForestIsland2";
				Qdata = 3;
				PosQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375);
				PosB = CFrame.new(5283.609375, 22.56223487854, -110.78285217285);
			elseif _G.FindBoss == "Cake Queen" then
				bMon = "Cake Queen";
				Qname = "IceCreamIslandQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, .642767608, 0, 1, 0, -0.642767608, 0, -0.766061664);
				PosB = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, .00149294338, .41757378, .00837114919, .999857843, .0146408929, -0.417492568, .0167988986, -0.90852499);
			elseif _G.FindBoss == "Longma" then
				bMon = "Longma";
				Qdata = nil;
				PosQBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125);
				PosB = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125);
			elseif _G.FindBoss == "Soul Reaper" then
				bMon = "Soul Reaper";
				Qdata = nil;
				PosQBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813);
				PosB = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813);
			end;
		end;
	end;
QuestBeta = function()
		local I = QuestB();
		return {
			[0] = _G.FindBoss,
			[1] = bMon,
			[2] = Qdata,
			[3] = Qname,
			[4] = PosB,
		};
	end;
QuestCheck = function()
		local I = game.Players.LocalPlayer.Data.Level.Value;
		if World1 and I > 699 then
			I = 650;
		end;
		if World2 and I > 1499 then
			I = 1450;
		end;
		if World1 then
			if I == 1 or I <= 9 then
				if tostring(TeamSelf) == "Marines" then
					Mon = "Trainee";
					Qname = "MarineQuest";
					Qdata = 1;
					NameMon = "Trainee";
					PosM = CFrame.new(-2709.67944, 24.5206585, 2104.24585);
					PosQ = CFrame.new(-2709.67944, 24.5206585, 2104.24585);
				elseif tostring(TeamSelf) == "Pirates" then
					Mon = "Bandit";
					Qdata = 1;
					Qname = "BanditQuest1";
					NameMon = "Bandit";
					PosM = CFrame.new(1045.9626464844, 27.002508163452, 1560.8203125);
					PosQ = CFrame.new(1045.9626464844, 27.002508163452, 1560.8203125);
				end;
			elseif I >= 10 and I <= 14 then
				Mon = "Monkey";
				Qdata = 1;
				Qname = "JungleQuest";
				NameMon = "Monkey";
				PosQ = CFrame.new(-1598.08911, 35.5501175, 153.377838);
				PosM = CFrame.new(-1448.5180664062, 67.853012084961, 11.465796470642);
			elseif I >= 15 and I <= 29 then
				Mon = "Gorilla";
				Qdata = 2;
				Qname = "JungleQuest";
				NameMon = "Gorilla";
				PosQ = CFrame.new(-1598.08911, 35.5501175, 153.377838);
				PosM = CFrame.new(-1129.8836669922, 40.46354675293, -525.42370605469);
			elseif I >= 30 and I <= 39 then
				Mon = "Pirate";
				Qdata = 1;
				Qname = "BuggyQuest1";
				NameMon = "Pirate";
				PosQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498);
				PosM = CFrame.new(-1103.5134277344, 13.752052307129, 3896.0910644531);
			elseif I >= 40 and I <= 59 then
				Mon = "Brute";
				Qdata = 2;
				Qname = "BuggyQuest1";
				NameMon = "Brute";
				PosQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498);
				PosM = CFrame.new(-1140.0837402344, 14.809885025024, 4322.9213867188);
			elseif I >= 60 and I <= 74 then
				Mon = "Desert Bandit";
				Qdata = 1;
				Qname = "DesertQuest";
				NameMon = "Desert Bandit";
				PosQ = CFrame.new(894.488647, 5.14000702, 4392.43359);
				PosM = CFrame.new(924.7998046875, 6.4486746788025, 4481.5859375);
			elseif I >= 75 and I <= 89 then
				Mon = "Desert Officer";
				Qdata = 2;
				Qname = "DesertQuest";
				NameMon = "Desert Officer";
				PosQ = CFrame.new(894.488647, 5.14000702, 4392.43359);
				PosM = CFrame.new(1608.2822265625, 8.6142244338989, 4371.0073242188);
			elseif I >= 90 and I <= 99 then
				Mon = "Snow Bandit";
				Qdata = 1;
				Qname = "SnowQuest";
				NameMon = "Snow Bandit";
				PosQ = CFrame.new(1389.74451, 88.1519318, -1298.90796);
				PosM = CFrame.new(1354.3479003906, 87.272773742676, -1393.9465332031);
			elseif I >= 100 and I <= 119 then
				Mon = "Snowman";
				Qdata = 2;
				Qname = "SnowQuest";
				NameMon = "Snowman";
				PosQ = CFrame.new(1389.74451, 88.1519318, -1298.90796);
				PosM = CFrame.new(1201.6412353516, 144.57958984375, -1550.0670166016);
			elseif I >= 120 and I <= 149 then
				Mon = "Chief Petty Officer";
				Qdata = 1;
				Qname = "MarineQuest2";
				NameMon = "Chief Petty Officer";
				PosQ = CFrame.new(-5039.58643, 27.3500385, 4324.68018);
				PosM = CFrame.new(-4881.2309570312, 22.652044296265, 4273.7524414062);
			elseif I >= 150 and I <= 174 then
				Mon = "Sky Bandit";
				Qdata = 1;
				Qname = "SkyQuest";
				NameMon = "Sky Bandit";
				PosQ = CFrame.new(-4839.53027, 716.368591, -2619.44165);
				PosM = CFrame.new(-4953.20703125, 295.74420166016, -2899.2290039062);
			elseif I >= 175 and I <= 189 then
				Mon = "Dark Master";
				Qdata = 2;
				Qname = "SkyQuest";
				NameMon = "Dark Master";
				PosQ = CFrame.new(-4839.53027, 716.368591, -2619.44165);
				PosM = CFrame.new(-5259.8447265625, 391.39767456055, -2229.0354003906);
			elseif I >= 190 and I <= 209 then
				Mon = "Prisoner";
				Qdata = 1;
				Qname = "PrisonerQuest";
				NameMon = "Prisoner";
				PosQ = CFrame.new(5308.93115, 1.65517521, 475.120514);
				PosM = CFrame.new(5098.9736328125, -0.3204058110714, 474.23733520508);
			elseif I >= 210 and I <= 249 then
				Mon = "Dangerous Prisoner";
				Qdata = 2;
				Qname = "PrisonerQuest";
				NameMon = "Dangerous Prisoner";
				PosQ = CFrame.new(5308.93115, 1.65517521, 475.120514);
				PosM = CFrame.new(5654.5634765625, 15.633401870728, 866.29919433594);
			elseif I >= 250 and I <= 274 then
				Mon = "Toga Warrior";
				Qdata = 1;
				Qname = "ColosseumQuest";
				NameMon = "Toga Warrior";
				PosQ = CFrame.new(-1580.04663, 6.35000277, -2986.47534);
				PosM = CFrame.new(-1820.21484375, 51.683856964111, -2740.6650390625);
			elseif I >= 275 and I <= 299 then
				Mon = "Gladiator";
				Qdata = 2;
				Qname = "ColosseumQuest";
				NameMon = "Gladiator";
				PosQ = CFrame.new(-1580.04663, 6.35000277, -2986.47534);
				PosM = CFrame.new(-1292.8381347656, 56.380882263184, -3339.0314941406);
			elseif I >= 300 and I <= 324 then
				Mon = "Military Soldier";
				Qdata = 1;
				Qname = "MagmaQuest";
				NameMon = "Military Soldier";
				PosQ = CFrame.new(-5313.37012, 10.9500084, 8515.29395);
				PosM = CFrame.new(-5411.1645507812, 11.081554412842, 8454.29296875);
			elseif I >= 325 and I <= 374 then
				Mon = "Military Spy";
				Qdata = 2;
				Qname = "MagmaQuest";
				NameMon = "Military Spy";
				PosQ = CFrame.new(-5313.37012, 10.9500084, 8515.29395);
				PosM = CFrame.new(-5802.8681640625, 86.262413024902, 8828.859375);
			elseif I >= 375 and I <= 399 then
				Mon = "Fishman Warrior";
				Qdata = 1;
				Qname = "FishmanQuest";
				NameMon = "Fishman Warrior";
				PosQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734);
				PosM = CFrame.new(60878.30078125, 18.482830047607, 1543.7574462891);
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875));
				end;
			elseif I >= 400 and I <= 449 then
				Mon = "Fishman Commando";
				Qdata = 2;
				Qname = "FishmanQuest";
				NameMon = "Fishman Commando";
				PosQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734);
				PosM = CFrame.new(61922.6328125, 18.482830047607, 1493.9343261719);
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875));
				end;
			elseif I >= 450 and I <= 474 then
				Mon = "God\'s Guard";
				Qdata = 1;
				Qname = "SkyExp1Quest";
				NameMon = "God\'s Guard";
				PosQ = CFrame.new(-4721.88867, 843.874695, -1949.96643);
				PosM = CFrame.new(-4710.04296875, 845.27697753906, -1927.3079833984);
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688));
				end;
			elseif I >= 475 and I <= 524 then
				Mon = "Shanda";
				Qdata = 2;
				Qname = "SkyExp1Quest";
				NameMon = "Shanda";
				PosQ = CFrame.new(-7859.09814, 5544.19043, -381.476196);
				PosM = CFrame.new(-7678.4897460938, 5566.4038085938, -497.21560668945);
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047));
				end;
			elseif I >= 525 and I <= 549 then
				Mon = "Royal Squad";
				Qdata = 1;
				Qname = "SkyExp2Quest";
				NameMon = "Royal Squad";
				PosQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194);
				PosM = CFrame.new(-7624.2524414062, 5658.1333007812, -1467.3542480469);
			elseif I >= 550 and I <= 624 then
				Mon = "Royal Soldier";
				Qdata = 2;
				Qname = "SkyExp2Quest";
				NameMon = "Royal Soldier";
				PosQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194);
				PosM = CFrame.new(-7836.7534179688, 5645.6640625, -1790.6236572266);
			elseif I >= 625 and I <= 649 then
				Mon = "Galley Pirate";
				Qdata = 1;
				Qname = "FountainQuest";
				NameMon = "Galley Pirate";
				PosQ = CFrame.new(5259.81982, 37.3500175, 4050.0293);
				PosM = CFrame.new(5551.0219726562, 78.901351928711, 3930.4128417969);
			elseif I >= 650 then
				Mon = "Galley Captain";
				Qdata = 2;
				Qname = "FountainQuest";
				NameMon = "Galley Captain";
				PosQ = CFrame.new(5259.81982, 37.3500175, 4050.0293);
				PosM = CFrame.new(5441.9516601562, 42.502059936523, 4950.09375);
			end;
		elseif World2 then
			if I >= 700 and I <= 724 then
				Mon = "Raider";
				Qdata = 1;
				Qname = "Area1Quest";
				NameMon = "Raider";
				PosQ = CFrame.new(-429.543518, 71.7699966, 1836.18188);
				PosM = CFrame.new(-728.32672119141, 52.779319763184, 2345.7705078125);
			elseif I >= 725 and I <= 774 then
				Mon = "Mercenary";
				Qdata = 2;
				Qname = "Area1Quest";
				NameMon = "Mercenary";
				PosQ = CFrame.new(-429.543518, 71.7699966, 1836.18188);
				PosM = CFrame.new(-1004.3244018555, 80.158866882324, 1424.6193847656);
			elseif I >= 775 and I <= 799 then
				Mon = "Swan Pirate";
				Qdata = 1;
				Qname = "Area2Quest";
				NameMon = "Swan Pirate";
				PosQ = CFrame.new(638.43811, 71.769989, 918.282898);
				PosM = CFrame.new(1068.6643066406, 137.61428833008, 1322.1060791016);
			elseif I >= 800 and I <= 874 then
				Mon = "Factory Staff";
				Qname = "Area2Quest";
				Qdata = 2;
				NameMon = "Factory Staff";
				PosQ = CFrame.new(632.698608, 73.1055908, 918.666321);
				PosM = CFrame.new(73.078674316406, 81.863441467285, -27.470672607422);
			elseif I >= 875 and I <= 899 then
				Mon = "Marine Lieutenant";
				Qdata = 1;
				Qname = "MarineQuest3";
				NameMon = "Marine Lieutenant";
				PosQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812);
				PosM = CFrame.new(-2821.3723144531, 75.897277832031, -3070.0891113281);
			elseif I >= 900 and I <= 949 then
				Mon = "Marine Captain";
				Qdata = 2;
				Qname = "MarineQuest3";
				NameMon = "Marine Captain";
				PosQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812);
				PosM = CFrame.new(-1861.2310791016, 80.176582336426, -3254.6975097656);
			elseif I >= 950 and I <= 974 then
				Mon = "Zombie";
				Qdata = 1;
				Qname = "ZombieQuest";
				NameMon = "Zombie";
				PosQ = CFrame.new(-5497.06152, 47.5923004, -795.237061);
				PosM = CFrame.new(-5657.7768554688, 78.969734191895, -928.68701171875);
			elseif I >= 975 and I <= 999 then
				Mon = "Vampire";
				Qdata = 2;
				Qname = "ZombieQuest";
				NameMon = "Vampire";
				PosQ = CFrame.new(-5497.06152, 47.5923004, -795.237061);
				PosM = CFrame.new(-6037.66796875, 32.184638977051, -1340.6597900391);
			elseif I >= 1000 and I <= 1049 then
				Mon = "Snow Trooper";
				Qdata = 1;
				Qname = "SnowMountainQuest";
				NameMon = "Snow Trooper";
				PosQ = CFrame.new(609.858826, 400.119904, -5372.25928);
				PosM = CFrame.new(549.14733886719, 427.38705444336, -5563.6987304688);
			elseif I >= 1050 and I <= 1099 then
				Mon = "Winter Warrior";
				Qdata = 2;
				Qname = "SnowMountainQuest";
				NameMon = "Winter Warrior";
				PosQ = CFrame.new(609.858826, 400.119904, -5372.25928);
				PosM = CFrame.new(1142.7451171875, 475.63980102539, -5199.4165039062);
			elseif I >= 1100 and I <= 1124 then
				Mon = "Lab Subordinate";
				Qdata = 1;
				Qname = "IceSideQuest";
				NameMon = "Lab Subordinate";
				PosQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852);
				PosM = CFrame.new(-5707.4716796875, 15.951709747314, -4513.3920898438);
			elseif I >= 1125 and I <= 1174 then
				Mon = "Horned Warrior";
				Qdata = 2;
				Qname = "IceSideQuest";
				NameMon = "Horned Warrior";
				PosQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852);
				PosM = CFrame.new(-6341.3666992188, 15.951770782471, -5723.162109375);
			elseif I >= 1175 and I <= 1199 then
				Mon = "Magma Ninja";
				Qdata = 1;
				Qname = "FireSideQuest";
				NameMon = "Magma Ninja";
				PosQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457);
				PosM = CFrame.new(-5449.6728515625, 76.658744812012, -5808.2006835938);
			elseif I >= 1200 and I <= 1249 then
				Mon = "Lava Pirate";
				Qdata = 2;
				Qname = "FireSideQuest";
				NameMon = "Lava Pirate";
				PosQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457);
				PosM = CFrame.new(-5213.3315429688, 49.737880706787, -4701.451171875);
			elseif I >= 1250 and I <= 1274 then
				Mon = "Ship Deckhand";
				Qdata = 1;
				Qname = "ShipQuest1";
				NameMon = "Ship Deckhand";
				PosQ = CFrame.new(1037.80127, 125.092171, 32911.6016);
				PosM = CFrame.new(1212.0111083984, 150.79205322266, 33059.24609375);
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
				end;
			elseif I >= 1275 and I <= 1299 then
				Mon = "Ship Engineer";
				Qdata = 2;
				Qname = "ShipQuest1";
				NameMon = "Ship Engineer";
				PosQ = CFrame.new(1037.80127, 125.092171, 32911.6016);
				PosM = CFrame.new(919.47863769531, 43.544013977051, 32779.96875);
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
				end;
			elseif I >= 1300 and I <= 1324 then
				Mon = "Ship Steward";
				Qdata = 1;
				Qname = "ShipQuest2";
				NameMon = "Ship Steward";
				PosQ = CFrame.new(968.80957, 125.092171, 33244.125);
				PosM = CFrame.new(919.43853759766, 129.55599975586, 33436.03515625);
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
				end;
			elseif I >= 1325 and I <= 1349 then
				Mon = "Ship Officer";
				Qdata = 2;
				Qname = "ShipQuest2";
				NameMon = "Ship Officer";
				PosQ = CFrame.new(968.80957, 125.092171, 33244.125);
				PosM = CFrame.new(1036.0179443359, 181.4390411377, 33315.7265625);
				if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
				end;
			elseif I >= 1350 and I <= 1374 then
				Mon = "Arctic Warrior";
				Qdata = 1;
				Qname = "FrostQuest";
				NameMon = "Arctic Warrior";
				PosQ = CFrame.new(5667.6582, 26.7997818, -6486.08984);
				PosM = CFrame.new(5966.24609375, 62.970020294189, -6179.3828125);
			elseif I >= 1375 and I <= 1424 then
				Mon = "Snow Lurker";
				Qdata = 2;
				Qname = "FrostQuest";
				NameMon = "Snow Lurker";
				PosQ = CFrame.new(5667.6582, 26.7997818, -6486.08984);
				PosM = CFrame.new(5407.0737304688, 69.194374084473, -6880.8803710938);
			elseif I >= 1425 and I <= 1449 then
				Mon = "Sea Soldier";
				Qdata = 1;
				Qname = "ForgottenQuest";
				NameMon = "Sea Soldier";
				PosQ = CFrame.new(-3054.44458, 235.544281, -10142.8193);
				PosM = CFrame.new(-3028.2236328125, 64.674514770508, -9775.4267578125);
			elseif I >= 1450 then
				Mon = "Water Fighter";
				Qdata = 2;
				Qname = "ForgottenQuest";
				NameMon = "Water Fighter";
				PosQ = CFrame.new(-3054.44458, 235.544281, -10142.8193);
				PosM = CFrame.new(-3352.9013671875, 285.01556396484, -10534.841796875);
			end;
		elseif World3 then
			if I == 1500 or I <= 1524 then
				Mon = "Pirate Millionaire";
				Qdata = 1;
				Qname = "PiratePortQuest";
				NameMon = "Pirate Millionaire";
				PosQ = CFrame.new(-290.07, 42.9, 5581.59);
				PosM = CFrame.new(-246.0, 47.31, 5584.1);
			elseif I == 1525 or I <= 1574 then
				Mon = "Pistol Billionaire";
				Qdata = 2;
				Qname = "PiratePortQuest";
				NameMon = "Pistol Billionaire";
				PosQ = CFrame.new(-290.07, 42.9, 5581.59);
				PosM = CFrame.new(-187.33, 86.24, 6013.51);
			elseif I == 1575 or I <= 1599 then
				Mon = "Dragon Crew Warrior";
				Qdata = 1;
				Qname = "DragonCrewQuest";
				NameMon = "Dragon Crew Warrior";
				PosQ = CFrame.new(6737.06055, 127.417763, -712.300659, -0.463954359, -7.19574755e-009, .885859072, 7.69187665e-008, 1, 4.84078626e-008, -0.885859072, 9.05982276e-008, -0.463954359);
				PosM = CFrame.new(6709.76367, 52.3442993, -1139.02966, -0.763515472, 0, .645789504, 0, 1, 0, -0.645789504, 0, -0.763515472);
			elseif I == 1600 or I <= 1624 then
				Mon = "Dragon Crew Archer";
				Qdata = 2;
				Qname = "DragonCrewQuest";
				NameMon = "Dragon Crew Archer";
				PosQ = CFrame.new(6737.06055, 127.417763, -712.300659, -0.463954359, -7.19574755e-009, .885859072, 7.69187665e-008, 1, 4.84078626e-008, -0.885859072, 9.05982276e-008, -0.463954359);
				PosM = CFrame.new(6668.76172, 481.376923, 329.12207, -0.121787429, 0, -0.992556155, 0, 1, 0, .992556155, 0, -0.121787429);
			elseif I == 1625 or I <= 1649 then
				Mon = "Hydra Enforcer";
				Qname = "VenomCrewQuest";
				Qdata = 1;
				NameMon = "Hydra Enforcer";
				PosQ = CFrame.new(5206.4018554688, 1004.1049804688, 748.35046386719);
				PosM = CFrame.new(4547.11523, 1003.10217, 334.194824, .388810456, 0, -0.921317935, 0, 1, 0, .921317935, 0, .388810456);
			elseif I == 1650 or I <= 1699 then
				Mon = "Venomous Assailant";
				Qname = "VenomCrewQuest";
				Qdata = 2;
				NameMon = "Venomous Assailant";
				PosQ = CFrame.new(5206.4018554688, 1004.1049804688, 748.35046386719);
				PosM = CFrame.new(4674.92676, 1134.82654, 996.308838, .731321394, 0, -0.682033002, 0, 1, 0, .682033002, 0, .731321394);
			elseif I == 1700 or I <= 1724 then
				Mon = "Marine Commodore";
				Qdata = 1;
				Qname = "MarineTreeIsland";
				NameMon = "Marine Commodore";
				PosQ = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, .258804798, 0, 1, 0, -0.258804798, 0, -0.965929747);
				PosM = CFrame.new(2286.0078125, 73.133918762207, -7159.8090820312);
			elseif I == 1725 or I <= 1774 then
				Mon = "Marine Rear Admiral";
				NameMon = "Marine Rear Admiral";
				Qname = "MarineTreeIsland";
				Qdata = 2;
				PosQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813);
				PosM = CFrame.new(3656.7736816406, 160.52406311035, -7001.5986328125);
			elseif I == 1775 or I <= 1799 then
				Mon = "Fishman Raider";
				Qdata = 1;
				Qname = "DeepForestIsland3";
				NameMon = "Fishman Raider";
				PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213);
				PosM = CFrame.new(-10407.526367188, 331.76263427734, -8368.5166015625);
			elseif I == 1800 or I <= 1824 then
				Mon = "Fishman Captain";
				Qdata = 2;
				Qname = "DeepForestIsland3";
				NameMon = "Fishman Captain";
				PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213);
				PosM = CFrame.new(-10994.701171875, 352.38140869141, -9002.1103515625);
			elseif I == 1825 or I <= 1849 then
				Mon = "Forest Pirate";
				Qdata = 1;
				Qname = "DeepForestIsland";
				NameMon = "Forest Pirate";
				PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, .707134247, 0, -0.707079291, 0, 1, 0, .707079291, 0, .707134247);
				PosM = CFrame.new(-13274.478515625, 332.37814331055, -7769.5805664062);
			elseif I == 1850 or I <= 1899 then
				Mon = "Mythological Pirate";
				Qdata = 2;
				Qname = "DeepForestIsland";
				NameMon = "Mythological Pirate";
				PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, .707134247, 0, -0.707079291, 0, 1, 0, .707079291, 0, .707134247);
				PosM = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125);
			elseif I == 1900 or I <= 1924 then
				Mon = "Jungle Pirate";
				Qdata = 1;
				Qname = "DeepForestIsland2";
				NameMon = "Jungle Pirate";
				PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, .996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002);
				PosM = CFrame.new(-12256.16015625, 331.73828125, -10485.836914062);
			elseif I == 1925 or I <= 1974 then
				Mon = "Musketeer Pirate";
				Qdata = 2;
				Qname = "DeepForestIsland2";
				NameMon = "Musketeer Pirate";
				PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, .996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002);
				PosM = CFrame.new(-13457.904296875, 391.54565429688, -9859.177734375);
			elseif I == 1975 or I <= 1999 then
				Mon = "Reborn Skeleton";
				Qdata = 1;
				Qname = "HauntedQuest1";
				NameMon = "Reborn Skeleton";
				PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0);
				PosM = CFrame.new(-8763.7236328125, 165.72299194336, 6159.8618164062);
			elseif I == 2000 or I <= 2024 then
				Mon = "Living Zombie";
				Qdata = 2;
				Qname = "HauntedQuest1";
				NameMon = "Living Zombie";
				PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0);
				PosM = CFrame.new(-10144.131835938, 138.6266784668, 5838.0888671875);
			elseif I == 2025 or I <= 2049 then
				Mon = "Demonic Soul";
				Qdata = 1;
				Qname = "HauntedQuest2";
				NameMon = "Demonic Soul";
				PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0);
				PosM = CFrame.new(-9505.8720703125, 172.10482788086, 6158.9931640625);
			elseif I == 2050 or I <= 2074 then
				Mon = "Posessed Mummy";
				Qdata = 2;
				Qname = "HauntedQuest2";
				NameMon = "Posessed Mummy";
				PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0);
				PosM = CFrame.new(-9582.0224609375, 6.2515273094177, 6205.478515625);
			elseif I == 2075 or I <= 2099 then
				Mon = "Peanut Scout";
				Qdata = 1;
				Qname = "NutsIslandQuest";
				NameMon = "Peanut Scout";
				PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0);
				PosM = CFrame.new(-2143.2419433594, 47.721984863281, -10029.995117188);
			elseif I == 2100 or I <= 2124 then
				Mon = "Peanut President";
				Qdata = 2;
				Qname = "NutsIslandQuest";
				NameMon = "Peanut President";
				PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0);
				PosM = CFrame.new(-1859.3540039062, 38.103168487549, -10422.4296875);
			elseif I == 2125 or I <= 2149 then
				Mon = "Ice Cream Chef";
				Qdata = 1;
				Qname = "IceCreamIslandQuest";
				NameMon = "Ice Cream Chef";
				PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0);
				PosM = CFrame.new(-872.24658203125, 65.81957244873, -10919.95703125);
			elseif I == 2150 or I <= 2199 then
				Mon = "Ice Cream Commander";
				Qdata = 2;
				Qname = "IceCreamIslandQuest";
				NameMon = "Ice Cream Commander";
				PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0);
				PosM = CFrame.new(-558.06103515625, 112.04895782471, -11290.774414062);
			elseif I == 2200 or I <= 2224 then
				Mon = "Cookie Crafter";
				Qdata = 1;
				Qname = "CakeQuest1";
				NameMon = "Cookie Crafter";
				PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, .957576931, -8.80302053e-008, .288177818, 6.9301187e-008, 1, 7.51931211e-008, -0.288177818, -5.2032135e-008, .957576931);
				PosM = CFrame.new(-2374.13671875, 37.798263549805, -12125.30859375);
			elseif I == 2225 or I <= 2249 then
				Mon = "Cake Guard";
				Qdata = 2;
				Qname = "CakeQuest1";
				NameMon = "Cake Guard";
				PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, .957576931, -8.80302053e-008, .288177818, 6.9301187e-008, 1, 7.51931211e-008, -0.288177818, -5.2032135e-008, .957576931);
				PosM = CFrame.new(-1598.3070068359, 43.773197174072, -12244.581054688);
			elseif I == 2250 or I <= 2274 then
				Mon = "Baking Staff";
				Qdata = 1;
				Qname = "CakeQuest2";
				NameMon = "Baking Staff";
				PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-008, .250778586, 4.74911062e-008, 1, 1.49904711e-008, -0.250778586, 2.64211941e-008, -0.96804446);
				PosM = CFrame.new(-1887.8099365234, 77.618507385254, -12998.350585938);
			elseif I == 2275 or I <= 2299 then
				Mon = "Head Baker";
				Qdata = 2;
				Qname = "CakeQuest2";
				NameMon = "Head Baker";
				PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-008, .250778586, 4.74911062e-008, 1, 1.49904711e-008, -0.250778586, 2.64211941e-008, -0.96804446);
				PosM = CFrame.new(-2216.1882324219, 82.884521484375, -12869.293945312);
			elseif I == 2300 or I <= 2324 then
				Mon = "Cocoa Warrior";
				Qdata = 1;
				Qname = "ChocQuest1";
				NameMon = "Cocoa Warrior";
				PosQ = CFrame.new(233.22836303711, 29.876001358032, -12201.233398438);
				PosM = CFrame.new(-21.553283691406, 80.574996948242, -12352.387695312);
			elseif I == 2325 or I <= 2349 then
				Mon = "Chocolate Bar Battler";
				Qdata = 2;
				Qname = "ChocQuest1";
				NameMon = "Chocolate Bar Battler";
				PosQ = CFrame.new(233.22836303711, 29.876001358032, -12201.233398438);
				PosM = CFrame.new(582.59057617188, 77.188095092773, -12463.162109375);
			elseif I == 2350 or I <= 2374 then
				Mon = "Sweet Thief";
				Qdata = 1;
				Qname = "ChocQuest2";
				NameMon = "Sweet Thief";
				PosQ = CFrame.new(150.50663757324, 30.693693161011, -12774.502929688);
				PosM = CFrame.new(165.1884765625, 76.058853149414, -12600.836914062);
			elseif I == 2375 or I <= 2399 then
				Mon = "Candy Rebel";
				Qdata = 2;
				Qname = "ChocQuest2";
				NameMon = "Candy Rebel";
				PosQ = CFrame.new(150.50663757324, 30.693693161011, -12774.502929688);
				PosM = CFrame.new(134.86563110352, 77.247680664062, -12876.547851562);
			elseif I == 2400 or I <= 2449 then
				Mon = "Candy Pirate";
				Qdata = 1;
				Qname = "CandyQuest1";
				NameMon = "Candy Pirate";
				PosQ = CFrame.new(-1150.0400390625, 20.378934860229, -14446.334960938);
				PosM = CFrame.new(-1310.5003662109, 26.016523361206, -14562.404296875);
			elseif I == 2450 or I <= 2474 then
				Mon = "Isle Outlaw";
				Qdata = 1;
				Qname = "TikiQuest1";
				NameMon = "Isle Outlaw";
				PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, .213092566, 0, -0.977032006, 0, 1, 0, .977032006, 0, .213092566);
				PosM = CFrame.new(-16479.900390625, 226.6117401123, -300.31143188477);
			elseif I == 2475 or I <= 2499 then
				Mon = "Island Boy";
				Qdata = 2;
				Qname = "TikiQuest1";
				NameMon = "Island Boy";
				PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, .213092566, 0, -0.977032006, 0, 1, 0, .977032006, 0, .213092566);
				PosM = CFrame.new(-16849.396484375, 192.86505126953, -150.78532409668);
			elseif I == 2500 or I <= 2524 then
				Mon = "Sun-kissed Warrior";
				Qdata = 1;
				Qname = "TikiQuest2";
				NameMon = "kissed Warrior";
				PosM = CFrame.new(-16347, 64, 984);
				PosQ = CFrame.new(-16538, 55, 1049);
			elseif I == 2525 or I <= 2550 then
				Mon = "Isle Champion";
				Qdata = 2;
				Qname = "TikiQuest2";
				NameMon = "Isle Champion";
				PosQ = CFrame.new(-16541.0215, 57.3082275, 1051.46118, .0410757065, 0, -0.999156058, 0, 1, 0, .999156058, 0, .0410757065);
				PosM = CFrame.new(-16602.1015625, 130.38734436035, 1087.2456054688);
			elseif I == 2551 or I <= 2574 then
				Mon = "Serpent Hunter";
				Qdata = 1;
				Qname = "TikiQuest3";
				NameMon = "Serpent Hunter";
				PosQ = CFrame.new(-16668.03, 105.32, 1568.6);
				PosM = CFrame.new(-16645.64, 163.09, 1352.87);
			elseif I >= 2575 and I <= 2599 then
				Mon = "Skull Slayer";
				Qdata = 2;
				Qname = "TikiQuest3";
				NameMon = "Skull Slayer";
				PosQ = CFrame.new(-16668.03, 105.32, 1568.6);
				PosM = CFrame.new(-16709.49, 419.68, 1751.09);
			elseif I >= 2600 and I <= 2624 then
				PosQ = CFrame.new(10778.875, -2087.72437, 9265.18359, .934615612, -9.33109447e-008, -0.355659455, 9.17655143e-008, 1, -2.12154276e-008, .355659455, -1.28090019e-008, .934615612);
				if ((getgenv()).AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, .997390985, 1.47309942e-009, -0.0721890926, -4.00651912e-009, .99999994, -2.51183763e-009, .0721890852, 5.75363091e-010, .997390926));
					task.wait(2);
					local args = { "TravelToSubmergedIsland" };
					((game:GetService("ReplicatedStorage")).Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak")):InvokeServer(unpack(args));
					return;
				end;
				Mon = "Reef Bandit";
				Qdata = 1;
				Qname = "SubmergedQuest1";
				NameMon = "Reef Bandit";
				PosM = CFrame.new(11019.1318, -2146.06812, 9342.3916, -0.719955266, -1.74275385e-008, .69402045, 5.76556367e-008, 1, 8.49211546e-008, -0.69402045, 1.01153624e-007, -0.719955266);
			elseif I >= 2625 and I <= 2649 then
				PosQ = CFrame.new(10778.875, -2087.72437, 9265.18359, .934615612, -9.33109447e-008, -0.355659455, 9.17655143e-008, 1, -2.12154276e-008, .355659455, -1.28090019e-008, .934615612);
				if ((getgenv()).AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, .997390985, 1.47309942e-009, -0.0721890926, -4.00651912e-009, .99999994, -2.51183763e-009, .0721890852, 5.75363091e-010, .997390926));
					task.wait(2);
					local args = { "TravelToSubmergedIsland" };
					((game:GetService("ReplicatedStorage")).Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak")):InvokeServer(unpack(args));
					return;
				end;
				Mon = "Coral Pirate";
				Qdata = 2;
				Qname = "SubmergedQuest1";
				NameMon = "Coral Pirate";
				PosM = CFrame.new(10808.6006, -2030.36145, 9364.2334, -0.775185347, -0.0359364748, .6307109, .0615428537, .989336014, .132010356, -0.628728986, .141148239, -0.764707148);
			elseif I >= 2650 and I <= 2674 then
				PosQ = CFrame.new(10880.6855, -2086.20044, 10032.624, -0.321384728, 9.87648434e-008, -0.946948707, 7.13271007e-008, 1, 8.00902953e-008, .946948707, -4.18033075e-008, -0.321384728);
				if ((getgenv()).AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, .997390985, 1.47309942e-009, -0.0721890926, -4.00651912e-009, .99999994, -2.51183763e-009, .0721890852, 5.75363091e-010, .997390926));
					task.wait(2);
					local args = { "TravelToSubmergedIsland" };
					((game:GetService("ReplicatedStorage")).Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak")):InvokeServer(unpack(args));
					return;
				end;
				Mon = "Sea Chanter";
				Qdata = 1;
				Qname = "SubmergedQuest2";
				NameMon = "Sea Chanter";
				PosM = CFrame.new(10671.2715, -2057.59155, 10047.2588, -0.846484065, -3.11045447e-008, .532414079, -5.55383117e-008, 1, -2.98785316e-008, -0.532414079, -5.48610757e-008, -0.846484065);
			elseif I >= 2675 and I <= 2699 then
				PosQ = CFrame.new(10880.6855, -2086.20044, 10032.624, -0.321384728, 9.87648434e-008, -0.946948707, 7.13271007e-008, 1, 8.00902953e-008, .946948707, -4.18033075e-008, -0.321384728);
				if ((getgenv()).AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, .997390985, 1.47309942e-009, -0.0721890926, -4.00651912e-009, .99999994, -2.51183763e-009, .0721890852, 5.75363091e-010, .997390926));
					task.wait(2);
					local args = { "TravelToSubmergedIsland" };
					((game:GetService("ReplicatedStorage")).Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak")):InvokeServer(unpack(args));
					return;
				end;
				Mon = "Ocean Prophet";
				Qdata = 2;
				Qname = "SubmergedQuest2";
				NameMon = "Ocean Prophet";
				PosM = CFrame.new(11008.5195, -2007.72839, 10223.0791, -0.688615739, 2.33523378e-009, -0.725126445, 2.99292546e-009, 1, 3.78221315e-010, .725126445, -1.90980032e-009, -0.688615739);
			elseif I >= 2700 and I <= 2724 then
				PosQ = CFrame.new(9640.08789, -1992.44507, 9613.65234, -0.957327187, 4.11991223e-008, .289006323, 1.5775445e-008, 1, -9.02985846e-008, -0.289006323, -8.18860855e-008, -0.957327187);
				if ((getgenv()).AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, .997390985, 1.47309942e-009, -0.0721890926, -4.00651912e-009, .99999994, -2.51183763e-009, .0721890852, 5.75363091e-010, .997390926));
					task.wait(2);
					local args = { "TravelToSubmergedIsland" };
					((game:GetService("ReplicatedStorage")).Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak")):InvokeServer(unpack(args));
					return;
				end;
				Mon = "High Disciple";
				Qdata = 1;
				Qname = "SubmergedQuest3";
				NameMon = "High Disciple";
				PosM = CFrame.new(9750.41602, -1966.93884, 9753.36035, -0.749824047, 5.57797613e-008, -0.661637306, 2.03500754e-008, 1, 6.1243199e-008, .661637306, 3.24572511e-008, -0.749824047);
			elseif I >= 2725 then
				PosQ = CFrame.new(9640.08789, -1992.44507, 9613.65234, -0.957327187, 4.11991223e-008, .289006323, 1.5775445e-008, 1, -9.02985846e-008, -0.289006323, -8.18860855e-008, -0.957327187);
				if ((getgenv()).AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
					_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, .997390985, 1.47309942e-009, -0.0721890926, -4.00651912e-009, .99999994, -2.51183763e-009, .0721890852, 5.75363091e-010, .997390926));
					task.wait(2);
					local args = { "TravelToSubmergedIsland" };
					((game:GetService("ReplicatedStorage")).Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak")):InvokeServer(unpack(args));
					return;
				end;
				Mon = "Grand Devotee";
				Qdata = 2;
				Qname = "SubmergedQuest3";
				NameMon = "Grand Devotee";
				PosM = CFrame.new(9611.70508, -1993.47119, 9882.68848, -0.591375351, 4.14332426e-008, -0.806396425, 4.73774868e-008, 1, 1.66361875e-008, .806396425, -2.83668058e-008, -0.591375351);
			end;
		end;
	end;
MaterialMon = function()
		local I = game.Players.LocalPlayer;
		local e = I.Character and I.Character:FindFirstChild("HumanoidRootPart");
		if not e then
			return;
		end;
		shouldRequestEntrance = function(I, K)
				local n = (e.Position - I).Magnitude;
				if n >= K then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", I);
				end;
			end;
		if World1 then
			if SelectMaterial == "Angel Wings" then
				MMon = {
						"Shanda",
						"Royal Squad",
						"Royal Soldier",
						"Wysper",
						"Thunder God",
					};
				MPos = CFrame.new(-4698, 845, -1912);
				SP = "Default";
				local I = Vector3.new(-4607.82275, 872.54248, -1667.55688);
				shouldRequestEntrance(I, 10000);
			elseif SelectMaterial == "Leather + Scrap Metal" then
				MMon = { "Brute", "Pirate" };
				MPos = CFrame.new(-1145, 15, 4350);
				SP = "Default";
			elseif SelectMaterial == "Magma Ore" then
				MMon = { "Military Soldier", "Military Spy", "Magma Admiral" };
				MPos = CFrame.new(-5815, 84, 8820);
				SP = "Default";
			elseif SelectMaterial == "Fish Tail" then
				MMon = { "Fishman Warrior", "Fishman Commando", "Fishman Lord" };
				MPos = CFrame.new(61123, 19, 1569);
				SP = "Default";
				local I = Vector3.new(61163.8515625, 5.342342376709, 1819.7841796875);
				shouldRequestEntrance(I, 17000);
			end;
		elseif World2 then
			if SelectMaterial == "Leather + Scrap Metal" then
				MMon = { "Marine Captain" };
				MPos = CFrame.new(-2010.5059814453, 73.001159667969, -3326.6208496094);
				SP = "Default";
			elseif SelectMaterial == "Magma Ore" then
				MMon = { "Magma Ninja", "Lava Pirate" };
				MPos = CFrame.new(-5428, 78, -5959);
				SP = "Default";
			elseif SelectMaterial == "Ectoplasm" then
				MMon = {
						"Ship Deckhand",
						"Ship Engineer",
						"Ship Steward",
						"Ship Officer",
					};
				MPos = CFrame.new(911.35827636719, 125.95812988281, 33159.5390625);
				SP = "Default";
				local I = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125);
				shouldRequestEntrance(I, 1000);
			elseif SelectMaterial == "Mystic Droplet" then
				MMon = { "Water Fighter" };
				MPos = CFrame.new(-3385, 239, -10542);
				SP = "Default";
			elseif SelectMaterial == "Radioactive Material" then
				MMon = { "Factory Staff" };
				MPos = CFrame.new(295, 73, -56);
				SP = "Default";
			elseif SelectMaterial == "Vampire Fang" then
				MMon = { "Vampire" };
				MPos = CFrame.new(-6033, 7, -1317);
				SP = "Default";
			end;
		elseif World3 then
			if SelectMaterial == "Scrap Metal" then
				MMon = { "Jungle Pirate", "Forest Pirate" };
				MPos = CFrame.new(-11975.78515625, 331.77340698242, -10620.030273438);
				SP = "Default";
			elseif SelectMaterial == "Fish Tail" then
				MMon = { "Fishman Raider", "Fishman Captain" };
				MPos = CFrame.new(-10993, 332, -8940);
				SP = "Default";
			elseif SelectMaterial == "Conjured Cocoa" then
				MMon = { "Chocolate Bar Battler", "Cocoa Warrior" };
				MPos = CFrame.new(620.63446044922, 78.936447143555, -12581.369140625);
				SP = "Default";
			elseif SelectMaterial == "Dragon Scale" then
				MMon = { "Dragon Crew Archer", "Dragon Crew Warrior" };
				MPos = CFrame.new(6594, 383, 139);
				SP = "Default";
			elseif SelectMaterial == "Gunpowder" then
				MMon = { "Pistol Billionaire" };
				MPos = CFrame.new(-84.855690002441, 85.620613098145, 6132.0087890625);
				SP = "Default";
			elseif SelectMaterial == "Mini Tusk" then
				MMon = { "Mythological Pirate" };
				MPos = CFrame.new(-13545, 470, -6917);
				SP = "Default";
			elseif SelectMaterial == "Demonic Wisp" then
				MMon = { "Demonic Soul" };
				MPos = CFrame.new(-9495.6806640625, 453.58624267578, 5977.3486328125);
				SP = "Default";
			end;
		end;
	end;
QuestNeta = function()
		local I = QuestCheck();
		return {
			[1] = Mon,
			[2] = Qdata,
			[3] = Qname,
			[4] = PosM,
			[5] = NameMon,
			[6] = PosQ,
		};
	end;
local Library = ((loadstring(game:HttpGet("https://pastefy.app/2ygvEBjS/raw")))()):MakeWindow({ Title = "NatAov Hub OLD", SubTitle = "By Dev-AnhTuansitink", SaveFolder = "NatAov.json" });
local screenGui = Instance.new("ScreenGui");
screenGui.Name = "ControlGUI";
screenGui.Parent = game.CoreGui;
local imageButton = Instance.new("ImageButton");
imageButton.Size = UDim2.new(0, 50, 0, 50);
imageButton.Position = UDim2.new(.15, 0, .15, 0);
imageButton.Image = "rbxassetid://120488231660846";
imageButton.BackgroundTransparency = 1;
imageButton.Parent = screenGui;
local uiCorner = Instance.new("UICorner");
uiCorner.CornerRadius = UDim.new(.5, 0);
uiCorner.Parent = imageButton;
local uiStroke = Instance.new("UIStroke", imageButton);
uiStroke.Thickness = 2;
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
uiStroke.Color = Color3.fromRGB(255, 200, 40);
local dragging = false;
local dragInput;
local dragStart;
local startPos;
local function update(input)
	local delta = input.Position - dragStart;
	imageButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
end;
imageButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true;
		dragStart = input.Position;
		startPos = imageButton.Position;
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false;
			end;
		end);
	end;
end);
imageButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input;
	end;
end);
(game:GetService("UserInputService")).InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		update(input);
	end;
end);
local isOpen = true;
imageButton.MouseButton1Click:Connect(function()
	isOpen = not isOpen;
	if isOpen then
		Library:Minimize(false);
	else
		Library:Minimize(true);
	end;
end);
local Discord = Library:MakeTab({ Title = "Th\195\180ng Tin", Icon = "rbxassetid://73132811772878" });
local Status = Library:MakeTab({ Title = "Tr\225\186\161ng Th\195\161i M\195\161y Ch\225\187\167", Icon = "rbxassetid://7040410130" });
local Shop = Library:MakeTab({ Title = "C\225\187\173a H\195\160ng", Icon = "rbxassetid://6031265976" });
local Farm = Library:MakeTab({ Title = "Farm Ch\195\173nh", Icon = "rbxassetid://127561653320876" });
local Maestry = Library:MakeTab({ Title = "Farm Th\195\180ng Th\225\186\161o", Icon = "rbxassetid://10709782497" });
local Others = Library:MakeTab({ Title = "Farm Kh\195\161c", Icon = "rbxassetid://10723405360" });
local Event = Library:MakeTab({ Title = "S\225\187\177 Ki\225\187\135n Bi\225\187\131n", Icon = "rbxassetid://10709783577" });
local Race = Library:MakeTab({ Title = "N\195\162ng C\225\186\165p T\225\187\153c", Icon = "rbxassetid://115164375298022" });
local Dojo = Library:MakeTab({ Title = "Nhi\225\187\135m V\225\187\165 DoJo & T\225\187\153c Draco", Icon = "rbxassetid://91920478152016" });
local Esp = Library:MakeTab({ Title = "Ch\225\187\137 S\225\187\145 & ESP", Icon = "rbxassetid://11155851001" });
local Player = Library:MakeTab({ Title = "Ng\198\176\225\187\157i Ch\198\161i", Icon = "rbxassetid://13075651575" });
local Teleport = Library:MakeTab({ Title = "D\225\187\139ch Chuy\225\187\131n", Icon = "rbxassetid://10734886004" });
local Get = Library:MakeTab({ Title = "L\225\186\165y V\225\186\173t Ph\225\186\169m & N\195\162ng C\225\186\165p", Icon = "rbxassetid://13075622619" });
local Fruit = Library:MakeTab({ Title = "T\225\186\173p K\195\173ch & Tr\195\161i", Icon = "rbxassetid://11155986081" });
local Setting = Library:MakeTab({ Title = "C\195\160i \196\144\225\186\183t & Kh\195\161c", Icon = "rbxassetid://7734053495" });
Discord:AddDiscordInvite({
	Name = "NatAov Hub Community",
	Description = "V\195\160o sever \196\145\225\187\131 l\225\186\165y client v\195\160 script free!",
	Logo = "rbxassetid://120488231660846",
	Invite = "https://discord.gg/h3jnnm7W",
});
local credits = Discord:AddParagraph({ Title = "Phi\195\170n B\225\186\163n C\197\169", Desc = "" });
credits:SetDesc("NguyenAnhTuan ( Admin c\225\187\167a hub )");
local scripts = Discord:AddParagraph({ Title = "Th\195\180ng tin c\225\186\173p nh\225\186\173t:", Desc = "" });
scripts:SetDesc("Ae V\195\180 Discord Tui \196\144\225\187\131 L\225\186\165y Script B\225\186\163n M\225\187\155i Nh\195\169 !!");
local Players = game:GetService("Players");
local plr = Players.LocalPlayer;
local replicated = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local placeId = game.PlaceId;
local World1, World2, World3 = false, false, false;
if placeId == 2753915549 or placeId == 85211729168715 then
	World1 = true;
elseif placeId == 4442272183 or placeId == 79091703265657 then
	World2 = true;
elseif placeId == 7449423635 or placeId == 100117331123089 then
	World3 = true;
else
	plr:Kick("\226\157\140 ai h\225\187\143i?");
end;
local SEA = World1 and 1 or World2 and 2 or World3 and 3 or 0;
if SEA == 0 then
	return;
end;
local NPCS = {
		BlackLeg = { [1] = Vector3.new(-984, 17, 3990), [2] = Vector3.new(-4753, 37, -4853), [3] = Vector3.new(-5050, 374, -3183) },
		Electro = { [1] = Vector3.new(-5383, 17, -2149), [2] = Vector3.new(-4960, 39, -4663), [3] = Vector3.new(-5000, 317, -3201) },
		FishmanKarate = { [1] = Vector3.new(61586, 23, 987), [2] = Vector3.new(-4870, 37, -4769), [3] = Vector3.new(-5026, 375, -3196) },
		DragonClaw = { [2] = Vector3.new(695, 189, 654), [3] = Vector3.new(-4983, 374, -3213) },
		Superhuman = { [2] = Vector3.new(1380, 250, -5188), [3] = Vector3.new(-5007, 374, -3203) },
		DeathStep = { [2] = Vector3.new(6352, 300, -6762), [3] = Vector3.new(-5002, 318, -3225) },
		SharkmanKarate = { [2] = Vector3.new(-2604, 242, -10318), [3] = Vector3.new(-4969, 317, -3226) },
		ElectricClaw = { [3] = Vector3.new(-10373, 334, -10136) },
		DragonTalon = { [3] = Vector3.new(5659, 1214, 859) },
		Godhuman = { [3] = Vector3.new(-13771, 337, -9881) },
		SanguineArt = { [3] = Vector3.new(-16517, 26, -185) },
	};
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local plr = Players.LocalPlayer;
local function GetHRP()
	return plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
end;
local function setNoclip(state)
	_G.noclipEnabled = state;
	if state then
		if not _G.noclipConnection then
			_G.noclipConnection = RunService.Stepped:Connect(function()
					if not _G.noclipEnabled then
						return;
					end;
					local char = plr.Character;
					if not char then
						return;
					end;
					for _, part in pairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false;
						end;
					end;
				end);
		end;
	else
		if _G.noclipConnection then
			_G.noclipConnection:Disconnect();
			_G.noclipConnection = nil;
		end;
	end;
end;
local function stabilizeCharacter(stabilize)
	local char = plr.Character;
	if not char then
		return;
	end;
	local humanoid = char:FindFirstChildOfClass("Humanoid");
	if humanoid then
		humanoid.PlatformStand = stabilize;
		humanoid.AutoRotate = not stabilize;
	end;
	if stabilize then
		if _G.stabilizeLoop then
			_G.stabilizeLoop:Disconnect();
		end;
		_G.stabilizeLoop = RunService.Heartbeat:Connect(function()
				local hrp = GetHRP();
				if not hrp then
					return;
				end;
				if hrp.Velocity.Y < -10 then
					hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z);
				end;
			end);
	else
		if _G.stabilizeLoop then
			_G.stabilizeLoop:Disconnect();
			_G.stabilizeLoop = nil;
		end;
	end;
end;
local function cancelCurrentTween()
	if _G.currentTween then
		pcall(function()
			_G.currentTween:Cancel();
		end);
		_G.currentTween = nil;
	end;
end;
local function isCharacterLocked()
	local hrp = GetHRP();
	if not hrp then
		return false;
	end;
	for _, v in pairs(hrp:GetChildren()) do
		if v:IsA("BodyVelocity") or v:IsA("BodyPosition") or v:IsA("BodyGyro") or v:IsA("AlignPosition") or v:IsA("VectorForce") then
			return true;
		end;
	end;
	return false;
end;
local function tweenTo(targetPos)
	local hrp = GetHRP();
	if not hrp then
		return;
	end;
	cancelCurrentTween();
	setNoclip(true);
	stabilizeCharacter(true);
	local speed = 265;
	local stepSize = 80;
	local heightOffset = 2;
	task.spawn(function()
		while true do
			local hrp = GetHRP();
			if not hrp then
				break;
			end;
			if isCharacterLocked() then
				cancelCurrentTween();
				break;
			end;
			local currentPos = hrp.Position;
			local distance = (targetPos - currentPos).Magnitude;
			if distance < 6 then
				break;
			end;
			local step = math.min(stepSize, distance);
			local direction = (targetPos - currentPos).Unit;
			local nextPos = currentPos + direction * step;
			nextPos = Vector3.new(nextPos.X, nextPos.Y + heightOffset, nextPos.Z);
			local time = step / speed;
			local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			local goal = { CFrame = CFrame.new(nextPos) };
			_G.currentTween = TweenService:Create(hrp, tweenInfo, goal);
			_G.currentTween:Play();
			_G.currentTween.Completed:Wait();
			task.wait(.02);
		end;
		cancelCurrentTween();
		setNoclip(false);
		stabilizeCharacter(false);
	end);
end;
local function StopBuyMelee()
	cancelCurrentTween();
	setNoclip(false);
	stabilizeCharacter(false);
	_G.BuyMeleeActive = false;
	_G.BuyMeleeTarget = nil;
	_G.BuyMeleeRemote = nil;
	_G.BuyMeleeStyle = nil;
end;
local function BuyMeleeWithTween(styleKey, remoteName, extraArgs)
	local targetPos = NPCS[styleKey] and NPCS[styleKey][SEA];
	if not targetPos then
		NotificacaoTuanDz("\226\157\140 " .. (styleKey .. (" kh\195\180ng c\195\179 \225\187\159 Sea " .. SEA)), 4);
		StopBuyMelee();
		return;
	end;
	StopBuyMelee();
	_G.BuyMeleeActive = true;
	_G.BuyMeleeTarget = targetPos;
	_G.BuyMeleeRemote = remoteName;
	_G.BuyMeleeStyle = styleKey;
	NotificacaoTuanDz("\226\156\136\239\184\143 \196\144ang bay \196\145\225\186\191n " .. (styleKey .. " ..."), 3);
	task.spawn(function()
		while _G.BuyMeleeActive do
			local hrp = GetHRP();
			if hrp then
				local dist = (hrp.Position - targetPos).Magnitude;
				if dist <= 10 then
					cancelCurrentTween();
					setNoclip(false);
					stabilizeCharacter(false);
					local success, err = pcall(function()
							if extraArgs then
								replicated.Remotes.CommF_:InvokeServer(remoteName, unpack(extraArgs));
							else
								replicated.Remotes.CommF_:InvokeServer(remoteName);
							end;
						end);
					if success then
						NotificacaoTuanDz("\240\159\142\137 Mua " .. (styleKey .. " th\195\160nh c\195\180ng!"), 4);
					else
						NotificacaoTuanDz("\226\157\140 L\225\187\151i khi mua: " .. tostring(err), 5);
					end;
					StopBuyMelee();
					break;
				else
					if not _G.currentTween or _G.currentTween.PlaybackState == Enum.PlaybackState.Cancelled or _G.currentTween.PlaybackState == Enum.PlaybackState.Completed then
						tweenTo(targetPos);
					end;
				end;
			end;
			task.wait(1);
		end;
	end);
end;
Shop:AddSection("Mua V\195\181 meele");
Shop:AddToggle({ Title = "Mua Black Leg", Value = false, Callback = function(v)
		StopBuyMelee();
		if v then
			BuyMeleeWithTween("BlackLeg", "BuyBlackLeg");
		end;
	end });
Shop:AddToggle({ Title = "Mua Electro", Value = false, Callback = function(v)
		StopBuyMelee();
		if v then
			BuyMeleeWithTween("Electro", "BuyElectro");
		end;
	end });
Shop:AddToggle({ Title = "Mua Fishman Karate", Value = false, Callback = function(v)
		StopBuyMelee();
		if v then
			BuyMeleeWithTween("FishmanKarate", "BuyFishmanKarate");
		end;
	end });
Shop:AddToggle({ Title = "Mua Dragon Breath", Value = false, Callback = function(v)
		replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1");
		replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2");
	end });
Shop:AddToggle({ Title = "Mua Superhuman", Value = false, Callback = function(v)
		StopBuyMelee();
		if v then
			BuyMeleeWithTween("Superhuman", "BuySuperhuman");
		end;
	end });
Shop:AddToggle({ Title = "Mua Death Step", Value = false, Callback = function(v)
		StopBuyMelee();
		if v then
			BuyMeleeWithTween("DeathStep", "BuyDeathStep");
		end;
	end });
Shop:AddToggle({ Title = "Mua Sharkman Karate", Value = false, Callback = function(v)
		StopBuyMelee();
		if v then
			BuyMeleeWithTween("SharkmanKarate", "BuySharkmanKarate", { true });
		end;
	end });
Shop:AddToggle({ Title = "Mua Electric Claw", Value = false, Callback = function(v)
		StopBuyMelee();
		if v then
			BuyMeleeWithTween("ElectricClaw", "BuyElectricClaw");
		end;
	end });
Shop:AddToggle({ Title = "Mua Dragon Talon", Value = false, Callback = function(v)
		StopBuyMelee();
		if v then
			BuyMeleeWithTween("DragonTalon", "BuyDragonTalon");
		end;
	end });
Shop:AddToggle({ Title = "Mua God Human", Value = false, Callback = function(v)
		StopBuyMelee();
		if v then
			BuyMeleeWithTween("Godhuman", "BuyGodhuman");
		end;
	end });
Shop:AddToggle({ Title = "Mua Sanguine Art", Value = false, Callback = function(v)
		StopBuyMelee();
		if v then
			BuyMeleeWithTween("SanguineArt", "BuySanguineArt", { true });
		end;
	end });
Shop:AddSection("Sword - Ki\225\186\191m");
Shop:AddButton({ Name = "Cutlass [ 1,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Cutlass");
	end });
Shop:AddButton({ Name = "Katana [ 1,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Katana");
	end });
Shop:AddButton({ Name = "Iron Mace [ 25,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace");
	end });
Shop:AddButton({ Name = "Dual Katana [ 12,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana");
	end });
Shop:AddButton({ Name = "Triple Katana [ 60,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana");
	end });
Shop:AddButton({ Name = "Pipe [ 100,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Pipe");
	end });
Shop:AddButton({ Name = "Dual-Headed Blade [ 400,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade");
	end });
Shop:AddButton({ Name = "Bisento [ 1,200,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Bisento");
	end });
Shop:AddButton({ Name = "Soul Cane [ 750,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane");
	end });
Shop:AddButton({ Name = "Pole v2 [ 5,000 Fragments ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ThunderGodTalk");
	end });
Shop:AddSection("Gun - S\195\186ng");
Shop:AddButton({ Name = "Slingshot [ 5,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Slingshot");
	end });
Shop:AddButton({ Name = "Musket [ 8,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Musket");
	end });
Shop:AddButton({ Name = "Flintlock [ 10,500 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Flintlock");
	end });
Shop:AddButton({ Name = "Refined Slingshot [ 30,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock");
	end });
Shop:AddButton({ Name = "Refined Flintlock [ 65,000 Beli ]", Callback = function()
		local args = { [1] = "BuyItem", [2] = "Refined Flintlock" };
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
	end });
Shop:AddButton({ Name = "Cannon [ 100,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Cannon");
	end });
Shop:AddButton({ Name = "Kabucha [ 1,500 Fragments]", Callback = function()
		local Remote = (game:GetService("ReplicatedStorage")).Remotes.CommF_;
		Remote:InvokeServer("BlackbeardReward", "Slingshot", "1");
		Remote:InvokeServer("BlackbeardReward", "Slingshot", "2");
	end });
Shop:AddButton({ Name = "Bizarre Rifle [ 250 Ectoplasm ]", Callback = function()
		local Remote = (game:GetService("ReplicatedStorage")).Remotes.CommF_;
		local args = { "Ectoplasm", "Buy", 1 };
		Remote:InvokeServer(unpack(args));
		Remote:InvokeServer(unpack(args));
	end });
Shop:AddSection("K\196\169 N\196\131ng");
Shop:AddButton({ Name = "Nh\225\186\163y Tr\195\170n Kh\195\180ng [ $10,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Geppo");
	end });
Shop:AddButton({ Name = "Haki V\197\169 Trang [ $25,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Buso");
	end });
Shop:AddButton({ Name = "Haki Quan S\195\161t [ $750,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("KenTalk", "Buy");
	end });
Shop:AddButton({ Name = "T\225\187\145c Bi\225\186\191n [ $100,000 Beli ]", Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Soru");
	end });
Shop:AddSection("Kh\195\161c");
Shop:AddButton({ Name = "\196\144\225\186\183t L\225\186\161i Ch\225\187\137 S\225\187\145 (2500F)", Callback = function()
		local Remote = (game:GetService("ReplicatedStorage")).Remotes.CommF_;
		Remote:InvokeServer("BlackbeardReward", "Refund", "1");
		Remote:InvokeServer("BlackbeardReward", "Refund", "2");
	end });
Shop:AddButton({ Name = "\196\144\225\187\149i T\225\187\153c  (3000F)", Callback = function()
		local Remote = (game:GetService("ReplicatedStorage")).Remotes.CommF_;
		Remote:InvokeServer("BlackbeardReward", "Reroll", "1");
		Remote:InvokeServer("BlackbeardReward", "Reroll", "2");
	end });
Shop:AddButton({ Name = "T\225\187\153c R\225\187\147ng Draco", Callback = function()
		topos(CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609));
		local targetPosition = Vector3.new(5814.4272460938, 1208.3267822266, 884.57855224609);
		local player = game.Players.LocalPlayer;
		local character = player.Character or player.CharacterAdded:Wait();
		repeat
			wait();
		until (character.HumanoidRootPart.Position - targetPosition).Magnitude < 1;
		local args = { [1] = { NPC = "Dragon Wizard", Command = "DragonRace" } };
		((game:GetService("ReplicatedStorage")).Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(args));
	end });
Shop:AddButton({ Name = "T\225\187\153c Qu\225\187\183", Callback = function()
		local args = { [1] = "Ectoplasm", [2] = "Change", [3] = 4 };
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
	end });
Shop:AddButton({ Name = "T\225\187\153c Ng\198\176\225\187\157i M\195\161y (2500F)", Callback = function()
		local args = { [1] = "CyborgTrainer", [2] = "Buy" };
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
	end });
local Time = Status:AddParagraph({ Title = "Th\225\187\157i Gian V\195\185ng", Desc = "" });
function UpdateOS()
	date = os.date("*t");
	hour = date.hour % 24;
	ampm = hour < 12 and "AM" or "PM";
	timezone = string.format("%02i:%02i:%02i %s", (hour - 1) % 12 + 1, date.min, date.sec, ampm);
	datetime = string.format("%02d/%02d/%04d", date.day, date.month, date.year);
	LocalizationService = game:GetService("LocalizationService");
	Players = game:GetService("Players");
	player = Players.LocalPlayer;
	name = player.Name;
	result, code = pcall(function()
			return LocalizationService:GetCountryRegionForPlayerAsync(player);
		end);
	Time:SetDesc(datetime .. (" - " .. (timezone .. (" [ " .. (code .. " ]")))));
end;
spawn(function()
	while wait() do
		UpdateOS();
		(game:GetService("RunService")).RenderStepped:Wait();
	end;
end);
local Timmessss = Status:AddParagraph({ Title = "Th\225\187\157i Gian M\195\161y Ch\225\187\167", Desc = "" });
function UpdateTime()
	GameTime = math.floor(workspace.DistributedGameTime + .5);
	Hour = math.floor(GameTime / 3600.0) % 24;
	Minute = math.floor(GameTime / 60) % 60;
	Second = GameTime % 60;
	Timmessss:SetDesc(Hour .. (" Gi\225\187\157 (h) " .. (Minute .. (" Ph\195\186t (m) " .. (Second .. " Gi\195\162y (s) ")))));
end;
spawn(function()
	while wait() do
		UpdateTime();
		wait();
	end;
end);
local Miragecheck = Status:AddParagraph({ Title = "\196\144\225\186\163o K\195\172 B\195\173", Desc = "Tr\225\186\161ng th\195\161i: " });
spawn(function()
	pcall(function()
		while wait() do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
				Miragecheck:SetDesc("\226\156\133\239\184\143");
			else
				Miragecheck:SetDesc("\226\157\140\239\184\143");
			end;
		end;
	end);
end);
local Kitsunecheck = Status:AddParagraph({ Title = "\196\144\225\186\163o Kitsune", Desc = "Tr\225\186\161ng th\195\161i: " });
spawn(function()
	pcall(function()
		while wait() do
			if (game:GetService("Workspace")).Map:FindFirstChild("KitsuneIsland") then
				Kitsunecheck:SetDesc("\226\156\133\239\184\143");
			else
				Kitsunecheck:SetDesc("\226\157\140\239\184\143");
			end;
		end;
	end);
end);
local CPrehistoriccheck = Status:AddParagraph({ Title = "\196\144\225\186\163o N\195\186i L\225\187\173a", Desc = "Tr\225\186\161ng th\195\161i: " });
spawn(function()
	pcall(function()
		while wait() do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
				CPrehistoriccheck:SetDesc("\226\156\133\239\184\143");
			else
				CPrehistoriccheck:SetDesc("\226\157\140\239\184\143");
			end;
		end;
	end);
end);
local FrozenIsland = Status:AddParagraph({ Title = "\196\144\225\186\163o Leviathan", Desc = "Tr\225\186\161ng th\195\161i: " });
spawn(function()
	pcall(function()
		while wait() do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				FrozenIsland:SetDesc("\226\156\133\239\184\143");
			else
				FrozenIsland:SetDesc("\226\157\140\239\184\143");
			end;
		end;
	end);
end);
local MobCakePrince = Status:AddParagraph({ Title = "Ho\195\160ng T\225\187\173 B\195\161nh", Desc = "" });
spawn(function()
	while wait() do
		pcall(function()
			local response = (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner");
			local len = string.len(response);
			if len == 88 then
				MobCakePrince:SetDesc("C\195\178n : " .. string.sub(response, 39, 41));
			elseif len == 87 then
				MobCakePrince:SetDesc("C\195\178n : " .. string.sub(response, 39, 40));
			elseif len == 86 then
				MobCakePrince:SetDesc("C\195\178n : " .. (string.sub(response, 39, 39) .. " "));
			else
				MobCakePrince:SetDesc("\226\156\133\239\184\143");
			end;
		end);
	end;
end);
local TyrantStatus = Status:AddParagraph({ Title = "Boss Tyrant Of The Skies", Desc = "Tr\225\186\161ng th\195\161i: " });
spawn(function()
	pcall(function()
		while wait() do
			if (game:GetService("Workspace")).Enemies:FindFirstChild("Tyrant of the Skies") then
				TyrantStatus:SetDesc(" \226\156\133\239\184\143");
			else
				TyrantStatus:SetDesc(" \226\157\140\239\184\143");
			end;
		end;
	end);
end);
local CheckRip = Status:AddParagraph({ Title = "Rip_Indra", Desc = "Tr\225\186\161ng th\195\161i:  " });
spawn(function()
	while wait() do
		pcall(function()
			if (game:GetService("ReplicatedStorage")):FindFirstChild("rip_indra True Form") or (game:GetService("Workspace")).Enemies:FindFirstChild("rip_indra") then
				CheckRip:SetDesc("\226\156\133\239\184\143");
			else
				CheckRip:SetDesc("\226\157\140\239\184\143");
			end;
		end);
	end;
end);
local CheckDoughKing = Status:AddParagraph({ Title = "Vua B\225\187\153t", Desc = "Tr\225\186\161ng th\195\161i: " });
spawn(function()
	while wait() do
		pcall(function()
			if (game:GetService("ReplicatedStorage")):FindFirstChild("Dough King") or (game:GetService("Workspace")).Enemies:FindFirstChild("Dough King") then
				CheckDoughKing:SetDesc(" \226\156\133\239\184\143");
			else
				CheckDoughKing:SetDesc("\226\157\140\239\184\143");
			end;
		end);
	end;
end);
local EliteHunter = Status:AddParagraph({ Title = "Elite Hunter", Desc = "Tr\225\186\161ng th\195\161i: " });
spawn(function()
	while wait() do
		pcall(function()
			local rs = game:GetService("ReplicatedStorage");
			local ws = (game:GetService("Workspace")).Enemies;
			local progress = rs.Remotes.CommF_:InvokeServer("EliteHunter", "Progress");
			if rs:FindFirstChild("Diablo") or rs:FindFirstChild("Deandre") or rs:FindFirstChild("Urban") or ws:FindFirstChild("Diablo") or ws:FindFirstChild("Deandre") or ws:FindFirstChild("Urban") then
				EliteHunter:SetDesc(" \226\156\133\239\184\143 | \196\144\195\163 Gi\225\186\191t: " .. progress);
			else
				EliteHunter:SetDesc(" \226\157\140\239\184\143 | \196\144\195\163 Gi\225\186\191t: " .. progress);
			end;
		end);
	end;
end);
local Pullever = Status:AddParagraph({ Title = "G\225\186\161t C\225\186\167n", Desc = "Tr\225\186\161ng th\195\161i: " });
spawn(function()
	while wait() do
		pcall(function()
			if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckTempleDoor") then
				Pullever:SetDesc("\226\156\133");
			else
				Pullever:SetDesc("\226\157\140");
			end;
		end);
	end;
end);
local FM = Status:AddParagraph({ Title = "Tr\196\131ng Tr\195\178n", Desc = "" });
spawn(function()
	while wait() do
		pcall(function()
			local moonId = (game:GetService("Lighting")).Sky.MoonTextureId;
			if moonId == "http://www.roblox.com/asset/?id=9709149431" then
				FM:SetDesc("Moon: 5/5");
			elseif moonId == "http://www.roblox.com/asset/?id=9709149052" then
				FM:SetDesc("Moon: 4/5");
			elseif moonId == "http://www.roblox.com/asset/?id=9709143733" then
				FM:SetDesc("Moon: 3/5");
			elseif moonId == "http://www.roblox.com/asset/?id=9709150401" then
				FM:SetDesc("Moon: 2/5");
			elseif moonId == "http://www.roblox.com/asset/?id=9709149680" then
				FM:SetDesc("Moon: 1/5");
			else
				FM:SetDesc("Moon: 0/5");
			end;
		end);
	end;
end);
local LegendarySword = Status:AddParagraph({ Title = "Ki\225\186\191m Huy\225\187\129n Tho\225\186\161i", Desc = "Tr\225\186\161ng th\195\161i: " });
spawn(function()
	pcall(function()
		while wait() do
			local rs = (game:GetService("ReplicatedStorage")).Remotes.CommF_;
			if rs:InvokeServer("LegendarySwordDealer", "1") then
				LegendarySword:SetDesc("Shisui");
			elseif rs:InvokeServer("LegendarySwordDealer", "2") then
				LegendarySword:SetDesc("Wando");
			elseif rs:InvokeServer("LegendarySwordDealer", "3") then
				LegendarySword:SetDesc("Saddi");
			else
				LegendarySword:SetDesc("kh\195\180ng c\195\179");
			end;
		end;
	end);
end);
local Bone = Status:AddParagraph({ Title = "X\198\176\198\161ng", Desc = "" });
spawn(function()
	pcall(function()
		while wait() do
			local bones = (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Bones", "Check");
			Bone:SetDesc("B\225\186\161n \196\145ang c\195\179 : " .. (tostring(bones) .. " X\198\176\198\161ng"));
		end;
	end);
end);
Status:AddTextBox({
	Name = "Nh\225\186\173p Job Id",
	Placeholder = "Job ID",
	ClearOnFocus = true,
	Callback = function(Value)
		(getgenv()).Job = Value;
	end,
});
Status:AddToggle({ Name = "Spam tham gia", Default = false, Callback = function(Value)
		(getgenv()).Join = Value;
	end });
spawn(function()
	while wait() do
		if (getgenv()).Join then
			(game:GetService("TeleportService")):TeleportToPlaceInstance(game.PlaceId, (getgenv()).Job, game.Players.LocalPlayer);
		end;
	end;
end);
Status:AddButton({ Name = "Tham gia m\195\161y ch\225\187\167", Callback = function()
		(game:GetService("TeleportService")):TeleportToPlaceInstance(game.PlaceId, (getgenv()).Job, game.Players.LocalPlayer);
	end });
Status:AddButton({ Name = "Sao ch\195\169p JobId", Callback = function()
		setclipboard(tostring(game.JobId));
	end });
Status:AddButton({ Name = "Tham gia l\225\186\161i", Callback = function()
		(game:GetService("TeleportService")):Teleport(game.PlaceId, (game:GetService("Players")).LocalPlayer);
	end });
Status:AddButton({ Name = "Chuy\225\187\131n m\195\161y ch\225\187\167 hop", Callback = function()
		Hop();
	end });
Status:AddButton({ Name = "Chuy\225\187\131m m\195\161y ch\225\187\167 \195\173t ng\198\176\225\187\157i", Callback = function()
		local Http = game:GetService("HttpService");
		local TPS = game:GetService("TeleportService");
		local Players = game:GetService("Players");
		local plr = Players.LocalPlayer;
		local Api = "https://games.roblox.com/v1/games/";
		local _place = game.PlaceId;
		local _servers = Api .. (_place .. "/servers/Public?sortOrder=Asc&limit=100");
		local function ListServers(cursor)
			local Raw = game:HttpGet(_servers .. (cursor and "&cursor=" .. cursor or ""));
			return Http:JSONDecode(Raw);
		end;
		local Server, Next;
		repeat
			local Servers = ListServers(Next);
			Server = Servers.data[1];
			Next = Servers.nextPageCursor;
		until Server;
		TPS:TeleportToPlaceInstance(_place, Server.id, plr);
	end });
Farm:AddSection({ "Auto Farm Ch\195\173nh" });
Farm:AddDropdown({
	Name = "Ch\225\187\141n v\197\169 kh\195\173",
	Description = "",
	Options = {
		"Melee",
		"Sword",
		"Blox Fruit",
		"Gun",
	},
	Default = "Melee",
	Multi = false,
	Callback = function(I)
		_G.ChooseWP = I;
	end,
});
spawn(function()
	while wait(Sec) do
		pcall(function()
			for _, e in pairs(plr.Backpack:GetChildren()) do
				if e.ToolTip == _G.ChooseWP then
					if plr.Backpack:FindFirstChild(e.Name) then
						_G.SelectWeapon = e.Name;
					end;
				end;
			end;
		end);
	end;
end);
_G.SelectedFarmMode = "Level";
_G.StartFarm = false;
_G.Level = false;
_G.AutoFarm_Bone = false;
_G.AutoFarm_Cake = false;
_G.AutoTyrant = false;
_G.AcceptQuest = false;
local CurrentMobLevel = nil;
local CurrentMobLevelSystem = nil;
local TELEPORT_DISTANCE_THRESHOLD = 15;
local function TeleportConditional(hrp, targetCFrame, threshold)
	if not hrp or not targetCFrame then
		return;
	end;
	local dist = (targetCFrame.Position - hrp.Position).Magnitude;
	if dist > threshold then
		_tp(targetCFrame);
	end;
end;
Farm:AddDropdown({
	Name = "Ch\225\187\141n ch\225\186\191 \196\145\225\187\153",
	Options = {
		"Level",
		"Bone",
		"Cake Prince",
		"Tyrant Of The Skies",
	},
	Default = GetSetting("SelectedFarmMode_Save", "Level"),
	Callback = function(v)
		_G.SelectedFarmMode = v;
		_G.SaveData.SelectedFarmMode_Save = v;
		SaveSettings();
	end,
});
Farm:AddToggle({ Name = "B\225\186\175t \196\145\225\186\167u farm", Default = GetSetting("StartFarm_Save", false), Callback = function(v)
		_G.StartFarm = v;
		_G.Level = false;
		_G.AutoFarm_Bone = false;
		_G.AutoFarm_Cake = false;
		_G.AutoTyrant = false;
		if v then
			if _G.SelectedFarmMode == "Level" then
				_G.Level = true;
			elseif _G.SelectedFarmMode == "Bone" then
				_G.AutoFarm_Bone = true;
			elseif _G.SelectedFarmMode == "Cake Prince" then
				_G.AutoFarm_Cake = true;
			elseif _G.SelectedFarmMode == "Tyrant Of The Skies" then
				_G.AutoTyrant = true;
			end;
		end;
		_G.SaveData.StartFarm_Save = v;
		SaveSettings();
	end });
Farm:AddToggle({ Title = "Nh\225\186\173n nhi\225\187\135m v\225\187\165", Default = GetSetting("AcceptQuest_Save", false), Callback = function(v)
		_G.AcceptQuest = v;
		_G.SaveData.AcceptQuest_Save = v;
		SaveSettings();
	end });
local FarmHeight = 45;
spawn(function()
	(game:GetService("RunService")).Stepped:Connect(function()
		if _G.AutoTyrant and _G.StartFarm then
			local char = game.Players.LocalPlayer.Character;
			if char then
				for _, part in pairs(char:GetDescendants()) do
					if part:IsA("BasePart") and part.CanCollide then
						part.CanCollide = false;
					end;
				end;
				if char:FindFirstChild("Humanoid") then
					char.Humanoid.AutoRotate = true;
					char.Humanoid:ChangeState(11);
				end;
			end;
		end;
	end);
end);
local function GetTargetByLevel()
	local myLevel = game.Players.LocalPlayer.Data.Level.Value;
	if myLevel >= 2575 then
		return {
			Name = "Skull Slayer",
			QuestArgs = { "StartQuest", "TikiQuest3", 2 },
			QuestPos = CFrame.new(-16665.0879, 105.27478, 1577.61743, -0.999621451, 3.5280582e-008, .0275127869, 3.5990368e-008, 1, 2.53032191e-008, -0.0275127869, 2.62838356e-008, -0.999621451),
			FarmPos = CFrame.new(-16709.49, 419.68, 1751.09),
		};
	elseif myLevel > 2550 then
		return {
			Name = "Serpent Hunter",
			QuestArgs = { "StartQuest", "TikiQuest3", 1 },
			QuestPos = CFrame.new(-16665.0879, 105.27478, 1577.61743, -0.999621451, 3.5280582e-008, .0275127869, 3.5990368e-008, 1, 2.53032191e-008, -0.0275127869, 2.62838356e-008, -0.999621451),
			FarmPos = CFrame.new(-16645.64, 163.09, 1352.87),
		};
	elseif myLevel >= 2525 then
		return {
			Name = "Isle Champion",
			QuestArgs = { "StartQuest", "TikiQuest2", 2 },
			QuestPos = CFrame.new(-16546.748, 55.7216759, -172.865311, -0.0595058464, 2.45485676e-008, .998227954, -5.3272025e-008, 1, -2.77677703e-008, -0.998227954, -5.48299717e-008, -0.0595058464),
			FarmPos = CFrame.new(-16602.1015625, 130.38734436035, 1087.2456054688),
		};
	elseif myLevel >= 2500 then
		return {
			Name = "Sun-kissed Warrior",
			QuestArgs = { "StartQuest", "TikiQuest2", 1 },
			QuestPos = CFrame.new(-16546.748, 55.7216759, -172.865311, -0.0595058464, 2.45485676e-008, .998227954, -5.3272025e-008, 1, -2.77677703e-008, -0.998227954, -5.48299717e-008, -0.0595058464),
			FarmPos = CFrame.new(-16347, 64, 984),
		};
	elseif myLevel >= 2475 then
		return {
			Name = "Island Boy",
			QuestArgs = { "StartQuest", "TikiQuest1", 2 },
			QuestPos = CFrame.new(-16546.748, 55.7216759, -172.865311, -0.0595058464, 2.45485676e-008, .998227954, -5.3272025e-008, 1, -2.77677703e-008, -0.998227954, -5.48299717e-008, -0.0595058464),
			FarmPos = CFrame.new(-16670, 43, -270),
		};
	else
		return {
			Name = "Isle Outlaw",
			QuestArgs = { "StartQuest", "TikiQuest1", 1 },
			QuestPos = CFrame.new(-16546.748, 55.7216759, -172.865311, -0.0595058464, 2.45485676e-008, .998227954, -5.3272025e-008, 1, -2.77677703e-008, -0.998227954, -5.48299717e-008, -0.0595058464),
			FarmPos = CFrame.new(-16350, 45, -180),
		};
	end;
end;
local function GetEyesCount()
	local model = workspace:FindFirstChild("Map") and (workspace.Map:FindFirstChild("TikiOutpost") and workspace.Map.TikiOutpost:FindFirstChild("IslandModel"));
	local count = 0;
	if model then
		local eye1 = model:FindFirstChild("Eye1");
		local eye2 = model:FindFirstChild("Eye2");
		local chunks = model:FindFirstChild("IslandChunks");
		local eye3 = chunks and (chunks:FindFirstChild("E") and chunks.E:FindFirstChild("Eye3"));
		local eye4 = chunks and (chunks:FindFirstChild("E") and chunks.E:FindFirstChild("Eye4"));
		if eye1 and eye1.Transparency == 0 then
			count = count + 1;
		end;
		if eye2 and eye2.Transparency == 0 then
			count = count + 1;
		end;
		if eye3 and eye3.Transparency == 0 then
			count = count + 1;
		end;
		if eye4 and eye4.Transparency == 0 then
			count = count + 1;
		end;
	end;
	return count;
end;
local function UseAllCategorySkills()
	local VirtualInputManager = game:GetService("VirtualInputManager");
	local VirtualUser = game:GetService("VirtualUser");
	local categories = {
			"Melee",
			"Blox Fruit",
			"Sword",
			"Gun",
		};
	local skills = { "Z", "X", "C" };
	pcall(function()
		(game:GetService("VirtualInputManager")):SendKeyEvent(true, "RightControl", false, game);
		workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + Vector3.new(0, -1, 0));
	end);
	for _, toolType in ipairs(categories) do
		local tool = nil;
		for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") and v.ToolTip == toolType then
				tool = v;
				break;
			end;
		end;
		if not tool then
			local charTool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool");
			if charTool and charTool.ToolTip == toolType then
				tool = charTool;
			end;
		end;
		if tool then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool);
			task.wait(.1);
			for i = 1, 3, 1 do
				VirtualUser:CaptureController();
				VirtualUser:ClickButton1(Vector2.new(851, 158));
				local skillKey = skills[i];
				if skillKey then
					VirtualInputManager:SendKeyEvent(true, skillKey, false, game);
					task.wait(.05);
					VirtualInputManager:SendKeyEvent(false, skillKey, false, game);
				end;
				task.wait(.1);
			end;
		end;
	end;
end;
spawn(function()
	local VaseIndex = 1;
	while task.wait() do
		if _G.AutoTyrant and _G.StartFarm then
			pcall(function()
				local plr = game.Players.LocalPlayer;
				local boss = workspace.Enemies:FindFirstChild("Tyrant of the Skies");
				local eyes = GetEyesCount();
				if boss and boss.Humanoid.Health > 0 then
					_tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, FarmHeight, 0));
					repeat
						task.wait();
						if boss and boss:FindFirstChild("HumanoidRootPart") then
							_tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, FarmHeight, 0));
							EquipWeapon(_G.SelectWeapon);
							G.Kill(boss, true);
						else
							break;
						end;
					until not boss.Parent or boss.Humanoid.Health <= 0 or not _G.StartFarm or not _G.AutoTyrant;
				elseif eyes == 4 then
					local targetsty = {
							CFrame.new(-16335.1, 158.1, 1465.6),
							CFrame.new(-16288.6, 158.1, 1470.3),
							CFrame.new(-16258.0, 156.7, 1461.4),
							CFrame.new(-16212.4, 158.1, 1466.3),
							CFrame.new(-16335.0, 159.3, 1324.8),
							CFrame.new(-16286.0, 155.9, 1323.8),
							CFrame.new(-16250.3, 159.3, 1316.3),
						};
					local pos = targetsty[VaseIndex];
					if pos then
						_tp(pos);
						local char = plr.Character;
						if char and char:FindFirstChild("HumanoidRootPart") then
							if (char.HumanoidRootPart.Position - pos.Position).Magnitude < 15 then
								char.HumanoidRootPart.Anchored = true;
								UseAllCategorySkills();
								task.wait(.1);
								char.HumanoidRootPart.Anchored = false;
								VaseIndex = VaseIndex + 1;
								if VaseIndex > #targetsty then
									VaseIndex = 1;
								end;
							end;
						end;
					end;
				else
					local TargetData = GetTargetByLevel();
					local QuestUI = plr.PlayerGui.Main.Quest;
					local hasQuest = QuestUI.Visible;
					if _G.AcceptQuest and not hasQuest then
						local char = plr.Character;
						if char and char:FindFirstChild("HumanoidRootPart") then
							local distToNPC = (char.HumanoidRootPart.Position - TargetData.QuestPos.Position).Magnitude;
							if distToNPC <= 3 then
								char.HumanoidRootPart.CFrame = TargetData.QuestPos;
								task.wait(.1);
								(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(TargetData.QuestArgs));
								task.wait(.5);
							else
								_tp(TargetData.QuestPos);
							end;
						end;
					else
						local char = plr.Character or plr.CharacterAdded:Wait();
						local hrp = char:WaitForChild("HumanoidRootPart", 1);
						if hrp then
							local closestEnemy = nil;
							local shortestDistance = math.huge;
							local AllMobs = {
									"Skull Slayer",
									"Serpent Hunter",
									"Isle Champion",
									"Sun-kissed Warrior",
									"Island Boy",
									"Isle Outlaw",
								};
							for _, v in pairs(workspace.Enemies:GetChildren()) do
								if table.find(AllMobs, v.Name) and (v:FindFirstChild("Humanoid") and (v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart"))) then
									local distance = (hrp.Position - v.HumanoidRootPart.Position).Magnitude;
									if distance < shortestDistance then
										shortestDistance = distance;
										closestEnemy = v;
									end;
								end;
							end;
							if closestEnemy then
								local enemyPos = closestEnemy.HumanoidRootPart.CFrame;
								_tp(enemyPos * CFrame.new(0, FarmHeight, 0));
								EquipWeapon(_G.SelectWeapon);
								G.Kill(closestEnemy, true);
							else
								_tp(TargetData.FarmPos);
							end;
						end;
					end;
				end;
			end);
		end;
	end;
end);
spawn(function()
	while task.wait() do
		if _G.AutoFarm_Bone and _G.StartFarm then
			pcall(function()
				local plr = game.Players.LocalPlayer;
				local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
				if not hrp then
					return;
				end;
				local QuestUI = plr.PlayerGui.Main.Quest;
				local MOBS = {
						"Reborn Skeleton",
						"Living Zombie",
						"Demonic Soul",
						"Posessed Mummy",
					};
				local npcPos = CFrame.new(-9516.99, 172.01, 6078.46);
				if _G.AcceptQuest and not QuestUI.Visible then
					local distToNPC = (npcPos.Position - hrp.Position).Magnitude;
					if distToNPC > 5 then
						_tp(npcPos);
					else
						task.wait(.5);
						local quests = {
								{ "StartQuest", "HauntedQuest1", 1 },
								{ "StartQuest", "HauntedQuest1", 2 },
								{ "StartQuest", "HauntedQuest2", 1 },
								{ "StartQuest", "HauntedQuest2", 2 },
							};
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(quests[math.random(1, #quests)]));
						task.wait(1);
					end;
				else
					local function GetClosestMob()
						local closest, shortest = nil, math.huge;
						for _, mobName in pairs(MOBS) do
							for _, mob in pairs(workspace.Enemies:GetChildren()) do
								if mob.Name == mobName and (mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0) then
									local dist = (mob.PrimaryPart.Position - hrp.Position).Magnitude;
									if dist < shortest then
										shortest = dist;
										closest = mob;
									end;
								end;
							end;
						end;
						return closest;
					end;
					local mob = GetClosestMob();
					if mob then
						_tp(mob.PrimaryPart.CFrame);
						EquipWeapon(_G.SelectWeapon);
						G.Kill(mob, true);
					else
						_tp(CFrame.new(-9495.68, 453.58, 5977.34));
					end;
				end;
			end);
		end;
	end;
end);
local CurrentMob = nil;
local function GetNearestMob(TargetName)
	local plr = game.Players.LocalPlayer;
	local Root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
	if not Root then
		return nil;
	end;
	local Closest, Dist = nil, math.huge;
	for _, Mob in pairs(workspace.Enemies:GetChildren()) do
		if G.Alive(Mob) and (Mob.Name == TargetName and Mob:FindFirstChild("HumanoidRootPart")) then
			local d = (Mob.HumanoidRootPart.Position - Root.Position).Magnitude;
			if d < Dist then
				Dist = d;
				Closest = Mob;
			end;
		end;
	end;
	return Closest;
end;
spawn(function()
	while task.wait() do
		if _G.Level and _G.StartFarm then
			pcall(function()
				local plr = game.Players.LocalPlayer;
				local Root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
				if not Root then
					return;
				end;
				local QuestTitle = plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text;
				local Q = QuestNeta();
				if not string.find(QuestTitle, Q[5]) then
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("AbandonQuest");
				end;
				if not plr.PlayerGui.Main.Quest.Visible then
					TeleportConditional(Root, Q[6], TELEPORT_DISTANCE_THRESHOLD);
					if (Root.Position - Q[6].Position).Magnitude <= 50 then
						task.wait(1.9);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("StartQuest", Q[3], Q[2]);
					end;
					return;
				end;
				local Nearest = GetNearestMob(Q[1]);
				if CurrentMob and (G.Alive(CurrentMob) and CurrentMob.Parent) then
					G.Kill(CurrentMob, true);
					return;
				else
					CurrentMob = nil;
				end;
				if not Nearest then
					TeleportConditional(Root, Q[4], TELEPORT_DISTANCE_THRESHOLD);
					return;
				end;
				CurrentMob = Nearest;
				if CurrentMob and CurrentMob:FindFirstChild("HumanoidRootPart") then
					_tp(CurrentMob.HumanoidRootPart.CFrame);
				end;
				repeat
					task.wait();
					G.Kill(CurrentMob, true);
				until not _G.StartFarm or not _G.Level or not CurrentMob.Parent or CurrentMob.Humanoid.Health <= 0;
				CurrentMob = nil;
			end);
		end;
	end;
end);
spawn(function()
	while task.wait() do
		if _G.AutoFarm_Cake and _G.StartFarm then
			pcall(function()
				local plr = game.Players.LocalPlayer;
				local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
				if not hrp then
					return;
				end;
				local enemies = workspace:FindFirstChild("Enemies");
				if not enemies then
					return;
				end;
				local CakePos = CFrame.new(-2091.91, 70.0, -12142.83);
				local PortalEntrance = CFrame.new(-2151.82, 149.32, -12404.91);
				local mirror = workspace.Map:FindFirstChild("CakeLoaf");
				mirror = mirror and mirror:FindFirstChild("BigMirror");
				local other = mirror and mirror:FindFirstChild("Other");
				local portalOpen = other and other.Transparency == 0;
				local boss = enemies:FindFirstChild("Cake Prince") or enemies:FindFirstChild("Dough King");
				if not boss and (not portalOpen and (hrp.Position - CakePos.Position).Magnitude > 3000) then
					_tp(CakePos);
					return;
				end;
				if boss or portalOpen then
					if boss and (boss:FindFirstChild("Humanoid") and (boss.Humanoid.Health > 0 and boss.PrimaryPart)) then
						local bossTarget = boss.PrimaryPart.CFrame * CFrame.new(0, 5, 0);
						_tp(bossTarget);
						local bossPos = (boss.PrimaryPart.CFrame * CFrame.new(0, 25, 0)) * CFrame.Angles(math.rad(-90), 0, 0);
						_tp(bossPos);
						G.Kill(boss, true);
						return;
					end;
					if (hrp.Position - PortalEntrance.Position).Magnitude < 500 then
						TeleportConditional(hrp, PortalEntrance, TELEPORT_DISTANCE_THRESHOLD);
					end;
					return;
				end;
				local CAKE_MOBS = {
						"Cookie Crafter",
						"Cake Guard",
						"Baking Staff",
						"Head Baker",
					};
				if _G.AcceptQuest and not plr.PlayerGui.Main.Quest.Visible then
					local questPos = CFrame.new(-1927.92, 37.8, -12842.54);
					TeleportConditional(hrp, questPos, TELEPORT_DISTANCE_THRESHOLD);
					if (hrp.Position - questPos.Position).Magnitude <= 40 then
						local q = {
								{ "StartQuest", "CakeQuest2", 2 },
								{ "StartQuest", "CakeQuest2", 1 },
								{ "StartQuest", "CakeQuest1", 1 },
								{ "StartQuest", "CakeQuest1", 2 },
							};
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(q[math.random(1, 4)]));
					end;
					return;
				end;
				local bestMob, bestDist = nil, math.huge;
				for _, mob in ipairs(enemies:GetChildren()) do
					if table.find(CAKE_MOBS, mob.Name) and (mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0) then
						local dist = (mob.HumanoidRootPart.Position - hrp.Position).Magnitude;
						if dist < bestDist then
							bestDist = dist;
							bestMob = mob;
						end;
					end;
				end;
				if bestMob then
					repeat
						task.wait();
						if workspace.Map.CakeLoaf.BigMirror.Other.Transparency == 0 or enemies:FindFirstChild("Cake Prince") then
							break;
						end;
						if bestMob.Parent and bestMob.Humanoid.Health > 0 then
							_tp((bestMob.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)) * CFrame.Angles(math.rad(-90), 0, 0));
							G.Kill(bestMob, true);
						else
							break;
						end;
					until not _G.StartFarm or not _G.AutoFarm_Cake or not bestMob.Parent or bestMob.Humanoid.Health <= 0;
				else
					TeleportConditional(hrp, CFrame.new(-1927.92, 37.8, -12842.54), TELEPORT_DISTANCE_THRESHOLD);
				end;
			end);
		end;
	end;
end);
Farm:AddSection({ "Kh\195\161c" });
_G.MaxFarmDistance = 325;
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
Farm:AddToggle({
	Name = "Gi\225\186\191t qu\195\161i xung quanh",
	Description = "",
	Default = GetSetting("AutoFarmNear_Save", false),
	Callback = function(I)
		_G.AutoFarmNear = I;
		_G.SaveData.AutoFarmNear_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	while task.wait() do
		pcall(function()
			if not _G.AutoFarmNear then
				return;
			end;
			local Plr = Players.LocalPlayer;
			local Char = Plr.Character or Plr.CharacterAdded:Wait();
			local Root = Char:FindFirstChild("HumanoidRootPart");
			if not Root then
				return;
			end;
			local ClosestEnemy = nil;
			local ShortestDistance = math.huge;
			if workspace:FindFirstChild("Enemies") then
				for _, e in pairs(workspace.Enemies:GetChildren()) do
					if e:FindFirstChild("Humanoid") and (e:FindFirstChild("HumanoidRootPart") and e.Humanoid.Health > 0) then
						local dist = (Root.Position - e.HumanoidRootPart.Position).Magnitude;
						if dist < ShortestDistance then
							ShortestDistance = dist;
							ClosestEnemy = e;
						end;
					end;
				end;
			end;
			if ReplicatedStorage:FindFirstChild("Enemies") then
				for _, e in pairs(ReplicatedStorage.Enemies:GetChildren()) do
					if e:IsA("Model") and e:FindFirstChild("Humanoid") then
						if not ClosestEnemy then
							ClosestEnemy = e;
						end;
					end;
				end;
			end;
			if ClosestEnemy and (not _G.MaxFarmDistance or ShortestDistance <= _G.MaxFarmDistance) then
				repeat
					task.wait();
					if G and G.Kill then
						G.Kill(ClosestEnemy, _G.AutoFarmNear);
					end;
				until not _G.AutoFarmNear or not ClosestEnemy.Parent or ClosestEnemy:FindFirstChild("Humanoid") and ClosestEnemy.Humanoid.Health <= 0 or not Root.Parent;
			end;
		end);
	end;
end);
local Sec = .5;
if World2 then
	Farm:AddToggle({
		Name = "Auto \196\145\195\161nh nh\195\160 m\195\161y",
		Description = "",
		Default = GetSetting("AutoFactory_Save", false),
		Callback = function(Value)
			_G.AutoFactory = Value;
			_G.SaveData.AutoFactory_Save = Value;
			SaveSettings();
		end,
	});
	spawn(function()
		local FactoryPos = CFrame.new(448.46756, 199.356781, -441.389252);
		while task.wait(Sec) do
			pcall(function()
				if not _G.AutoFactory then
					return;
				end;
				local Core = GetConnectionEnemies("Core");
				if Core and (Core:FindFirstChild("Humanoid") and Core.Humanoid.Health > 0) then
					repeat
						task.wait();
						if not _G.AutoFactory then
							break;
						end;
						if not Core or not Core.Parent then
							break;
						end;
						if Core.Humanoid.Health <= 0 then
							break;
						end;
						if _G.SelectWeapon then
							EquipWeapon(_G.SelectWeapon);
						end;
						_tp(FactoryPos);
					until Core.Humanoid.Health <= 0 or _G.AutoFactory == false;
				else
					_tp(FactoryPos);
				end;
			end);
		end;
	end);
end;
if World3 then
	Farm:AddToggle({
		Name = "Auto \196\145\195\161nh h\225\186\163i t\225\186\183c",
		Description = "",
		Default = GetSetting("AutoRaidCastle_Save", false),
		Callback = function(I)
			_G.AutoRaidCastle = I;
			_G.SaveData.AutoRaidCastle_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.AutoRaidCastle then
				pcall(function()
					local TargetCFrame = CFrame.new(-5496.17432, 313.768921, -2841.53027, .924894512, 7.37058015e-009, .380223751, 3.5881019e-008, 1, -1.06665446e-007, -0.380223751, 1.12297109e-007, .924894512);
					local CheckCFrame = CFrame.new(-5539.3115234375, 313.80053710938, -2972.3723144531);
					if (CheckCFrame.Position - Root.Position).Magnitude <= 500 then
						for _, e in pairs(workspace.Enemies:GetChildren()) do
							if e:FindFirstChild("HumanoidRootPart") and (e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0) then
								if (e.HumanoidRootPart.Position - Root.Position).Magnitude <= 2000 then
									repeat
										wait();
										G.Kill(e, _G.AutoRaidCastle);
									until not _G.AutoRaidCastle or not e.Parent or e.Humanoid.Health <= 0 or not workspace.Enemies:FindFirstChild(e.Name);
								end;
							end;
						end;
					else
						local EnemyList = {
								"Galley Pirate",
								"Galley Captain",
								"Raider",
								"Mercenary",
								"Vampire",
								"Zombie",
								"Snow Trooper",
								"Winter Warrior",
								"Lab Subordinate",
								"Horned Warrior",
								"Magma Ninja",
								"Lava Pirate",
								"Ship Deckhand",
								"Ship Engineer",
								"Ship Steward",
								"Ship Officer",
								"Arctic Warrior",
								"Snow Lurker",
								"Sea Soldier",
								"Water Fighter",
							};
						for _, enemyName in pairs(EnemyList) do
							if replicated:FindFirstChild(enemyName) then
								for _, n in pairs(replicated:GetChildren()) do
									if table.find(EnemyList, n.Name) then
										_tp(TargetCFrame);
									end;
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
end;
Farm:AddSection({ "Nh\225\186\183t" });
Farm:AddToggle({
	Name = "Nh\225\186\183t r\198\176\198\161ng [ bay ]",
	Description = "",
	Default = GetSetting("AutoFarmChest_Save", false),
	Callback = function(I)
		_G.AutoFarmChest = I;
		_G.SaveData.AutoFarmChest_Save = I;
		SaveSettings();
	end,
});
Farm:AddToggle({
	Name = "Nh\225\186\183t qu\225\186\163 berry",
	Description = "",
	Default = GetSetting("AutoBerry_Save", false),
	Callback = function(I)
		_G.AutoBerry = I;
		_G.SaveData.AutoBerry_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.AutoBerry then
			local I = game:GetService("CollectionService");
			local e = game:GetService("Players");
			local K = e.LocalPlayer;
			local n = I:GetTagged("BerryBush");
			local d, z = math.huge;
			for I = 1, #n, 1 do
				local e = n[I];
				for I, K in pairs(e:GetAttributes()) do
					if not BerryArray or table.find(BerryArray, K) then
						_tp(e.Parent:GetPivot());
						for I = 1, #n, 1 do
							local e = n[I];
							for I, e in pairs(e:GetChildren()) do
								if not BerryArray or table.find(BerryArray, e) then
									_tp(e.WorldPivot);
									fireproximityprompt(e.ProximityPrompt, math.huge);
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end);
spawn(function()
	while wait(Sec) do
		if _G.AutoFarmChest then
			pcall(function()
				local CollectionService = game:GetService("CollectionService");
				local Players = game:GetService("Players");
				local plrChar = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait();
				local d = (plrChar:GetPivot()).Position;
				local Chests = CollectionService:GetTagged("_ChestTagged");
				local minDist, nearestChest = math.huge, nil;
				for _, chest in pairs(Chests) do
					local dist = ((chest:GetPivot()).Position - d).Magnitude;
					if not SelectedIsland or chest:IsDescendantOf(SelectedIsland) then
						if not chest:GetAttribute("IsDisabled") and dist < minDist then
							minDist = dist;
							nearestChest = chest;
						end;
					end;
				end;
				if nearestChest then
					_tp(nearestChest:GetPivot());
				end;
			end);
		end;
	end;
end);
Farm:AddSection({ "Nguy\195\170n li\225\187\135u" });
Farm:AddDropdown({
	Name = "Ch\225\187\141n nguy\195\170n li\225\187\135u",
	Description = "",
	Options = MaterialList,
	Default = GetSetting("SelectMaterial_Save", nil),
	Multi = false,
	Callback = function(I)
		(getgenv()).SelectMaterial = I;
		_G.SaveData.SelectMaterial_Save = I;
		SaveSettings();
	end,
});
Farm:AddToggle({
	Name = "Auto Farm nguy\195\170n li\225\187\135u",
	Description = "",
	Default = GetSetting("AutoMaterial_Save", false),
	Callback = function(I)
		(getgenv()).AutoMaterial = I;
		_G.SaveData.AutoMaterial_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	local function I(I, e)
		if I:FindFirstChild("Humanoid") and (I:FindFirstChild("HumanoidRootPart") and I.Humanoid.Health > 0) then
			if I.Name == e then
				repeat
					wait();
					G.Kill(I, (getgenv()).AutoMaterial);
				until not (getgenv()).AutoMaterial or not I.Parent or I.Humanoid.Health <= 0;
			end;
		end;
	end;
	local function e()
		for I, e in pairs((game:GetService("Workspace"))._WorldOrigin.EnemySpawns:GetChildren()) do
			for I, K in ipairs(MMon) do
				if string.find(e.Name, K) then
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - e.Position).Magnitude >= 10 then
						_tp(e.CFrame * Pos);
					end;
				end;
			end;
		end;
	end;
	while wait() do
		if (getgenv()).AutoMaterial then
			pcall(function()
				if (getgenv()).SelectMaterial then
					MaterialMon((getgenv()).SelectMaterial);
					_tp(MPos);
				end;
				for e, K in ipairs(MMon) do
					for e, n in pairs(workspace.Enemies:GetChildren()) do
						I(n, K);
					end;
				end;
				e();
			end);
		end;
	end;
end);
if World3 then
	Farm:AddSection({ "x\198\176\198\161ng" });
	Farm:AddToggle({ Name = "Auto Random x\198\176\198\161ng", Default = false, Callback = function(v)
			_G.Auto_Random_Bone = v;
		end });
	spawn(function()
		while wait(Sec) do
			if _G.Auto_Random_Bone then
				replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1);
			end;
		end;
	end);
	Farm:AddToggle({ Name = "Auto boss t\225\187\173 th\225\186\167n ( soul reaper )", Default = false, Callback = function(v)
			_G.AutoHytHallow = v;
		end });
	spawn(function()
		while wait(Sec) do
			if _G.AutoHytHallow then
				pcall(function()
					local mob = GetConnectionEnemies("Soul Reaper");
					if mob then
						repeat
							task.wait();
							G.Kill(mob, _G.AutoHytHallow);
						until mob.Humanoid.Health <= 0 or not _G.AutoHytHallow;
					else
						if not GetBP("Hallow Essence") then
							repeat
								task.wait(.1);
								replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1);
							until not _G.AutoHytHallow or GetBP("Hallow Essence");
						else
							local pos = CFrame.new(-8932.32, 146.83, 6062.55);
							repeat
								wait(.1);
								_tp(pos);
							until not _G.AutoHytHallow or plr.Character.HumanoidRootPart.CFrame == pos;
							EquipWeapon("Hallow Essence");
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World3 then
	Farm:AddSection({ "Mini Yoru +  M\197\169 Valkyrie" });
	Farm:AddToggle({
		Name = "T\225\187\177 \196\145\225\187\153ng gi\225\186\191t Rip Indra",
		Description = "",
		Default = GetSetting("AutoRipIndra_Save", false),
		Callback = function(I)
			_G.AutoRipIngay = I;
			_G.SaveData.AutoRipIndra_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.AutoRipIngay then
					local I = GetConnectionEnemies("rip_indra");
					if not GetWP("Dark Dagger") or not GetIn("Valkyrie") and I then
						repeat
							wait();
							G.Kill(I, _G.AutoRipIngay);
						until not _G.AutoRipIngay or not I.Parent or I.Humanoid.Health <= 0;
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-008, .914313197, -1.90943332e-008, 1, 3.8755779e-008, -0.914313197, -1.76180437e-009, -0.405007899));
						wait(.1);
						_tp(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781));
					end;
				end;
			end);
		end;
	end);
	Farm:AddToggle({
		Name = "T\225\187\177 b\225\186\173t haki huy\225\187\129n tho\225\186\161i",
		Description = "",
		Default = GetSetting("AutoActiveCores_Save", false),
		Callback = function(I)
			_G.AutoUnHaki = I;
			_G.SaveData.AutoActiveCores_Save = I;
			SaveSettings();
		end,
	});
	AuraSkin = function(I)
			local e = { [1] = { StorageName = I, Type = "AuraSkin", Context = "Equip" } };
			(((replicated:WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/FruitCustomizerRF")):InvokeServer(unpack(e));
		end;
	VaildColor = function(I)
			if I and I.BrickColor then
				return tostring(I.BrickColor) == "Lime green";
			end;
		end;
	HakiCalculate = function(I)
			local e = { ["Really red"] = "Pure Red", Oyster = "Snow White", ["Hot pink"] = "Winter Sky" };
			if I and I.BrickColor then
				return e[tostring(I.BrickColor)];
			end;
		end;
	spawn(function()
		while wait(Sec) do
			if _G.AutoUnHaki then
				pcall(function()
					local I = workspace.Map["Boat Castle"]:FindFirstChild("Summoner");
					if I and I:FindFirstChild("Circle") then
						for I, e in pairs((I:FindFirstChild("Circle")):GetChildren()) do
							if e.Name == "Part" then
								local I = e:FindFirstChild("Part");
								if VaildColor(I) == false then
									AuraSkin(HakiCalculate(e));
									repeat
										wait();
										_tp(e.CFrame);
									until VaildColor(I) == true or not _G.AutoUnHaki;
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
end;
Setting:AddSection({ "Save Config" });
Setting:AddButton({ Name = "L\198\176u config ", Description = "L\198\176u c\195\160i \196\145\225\186\183t m\195\160 b\225\186\161n \196\145ang d\195\185ng", Callback = function()
		if SaveSettings then
			SaveSettings();
			game.StarterGui:SetCore("SendNotification", { Title = "kid 2007", Text = "L\198\176u th\195\160nh c\195\180ng!", Duration = 5 });
		else
			warn("looic l\198\176u");
		end;
	end });
Setting:AddButton({ Name = "\196\144\225\186\183t l\225\186\161i config", Description = "X\195\179a t\225\186\173p tin l\198\176u v\195\160 kh\195\180i ph\225\187\165c c\195\160i \196\145\225\186\183t m\225\186\183c \196\145\225\187\139nh.", Callback = function()
		if isfile and isfile(FullPath) then
			delfile(FullPath);
			_G.SaveData = {};
			game.StarterGui:SetCore("SendNotification", { Title = "Rauma-nemchua", Text = "xo\195\161 th\195\160nh c\195\180ng", Duration = 5 });
		else
			game.StarterGui:SetCore("SendNotification", { Title = "Th\225\186\167n t\195\160y", Text = "Kh\195\180ng t\195\172m th\225\186\165y t\225\187\135p l\198\176u n\195\160o \196\145\225\187\131 x\195\179a.", Duration = 3 });
		end;
	end });
Setting:AddSection({ "Setting Farm" });
Setting:AddButton({ Name = "D\225\187\171ng bay", Description = "", Callback = function()
		local plr = game.Players.LocalPlayer;
		local char = plr.Character;
		if not char then
			return;
		end;
		local hrp = char:FindFirstChild("HumanoidRootPart");
		local hum = char:FindFirstChild("Humanoid");
		shouldTween = false;
		if hrp then
			hrp.Anchored = false;
			for _, v in pairs(hrp:GetChildren()) do
				if v:IsA("BodyVelocity") or v:IsA("BodyPosition") or v:IsA("BodyGyro") then
					v:Destroy();
				end;
			end;
		end;
		if hum then
			hum.PlatformStand = false;
			hum.Sit = false;
			hum.WalkSpeed = 16;
			hum.JumpPower = 50;
			hum.AutoRotate = true;
			hum:ChangeState(Enum.HumanoidStateType.Running);
		end;
		(getgenv()).OnFarm = true;
		task.wait();
		shouldTween = true;
	end });
Setting:AddToggle({
	Name = "T\225\187\177 t\225\186\165n c\195\180ng",
	Description = "",
	Default = GetSetting("AutoAttack_Save", true),
	Callback = function(I)
		_G.Seriality = I;
		_G.SaveData.AutoAttack_Save = I;
		SaveSettings();
	end,
});
Setting:AddToggle({
	Name = "G\195\180m qu\195\161i",
	Description = "",
	Default = GetSetting("BringMobs_Save", true),
	Callback = function(I)
		_B = I;
		_G.SaveData.BringMobs_Save = I;
		SaveSettings();
	end,
});
Setting:AddToggle({
	Name = "Bay l\195\170n n\225\186\191u m\195\161u y\225\186\191u",
	Description = "b\225\186\173t l\195\170n \196\145\225\187\131 b\225\186\163o v\225\187\135 b\225\186\161n n\225\186\191u m\195\161u \225\187\159 m\225\187\169c th\225\186\165p",
	Default = GetSetting("SafeMode_Save", false),
	Callback = function(I)
		_G.Safemode = I;
		_G.SaveData.SafeMode_Save = I;
		SaveSettings();
	end,
});
Setting:AddToggle({
	Name = "T\225\187\177 b\225\186\173t haki",
	Description = "",
	Default = GetSetting("AutoHaki_Save", true),
	Callback = function(I)
		Boud = I;
		_G.SaveData.AutoHaki_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	while wait(Sec) do
		pcall(function()
			if Boud then
				local I = { "HasBuso", "Buso" };
				if not plr.Character:FindFirstChild(I[1]) then
					replicated.Remotes.CommF_:InvokeServer(I[2]);
				end;
			end;
		end);
	end;
end);
Setting:AddToggle({
	Name = "T\225\187\177 b\225\186\173t t\225\187\153c v3",
	Description = "",
	Default = GetSetting("AutoActiveV3_Save", false),
	Callback = function(I)
		_G.RaceClickAutov3 = I;
		_G.SaveData.AutoActiveV3_Save = I;
		SaveSettings();
	end,
});
Setting:AddToggle({
	Name = "T\225\187\177 b\225\186\173t t\225\187\153c V4",
	Description = "",
	Default = GetSetting("AutoActiveV4_Save", false),
	Callback = function(I)
		_G.RaceClickAutov4 = I;
		_G.SaveData.AutoActiveV4_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	while wait(.2) do
		pcall(function()
			if _G.RaceClickAutov3 then
				repeat
					replicated.Remotes.CommE:FireServer("ActivateAbility");
					wait(30);
				until not _G.RaceClickAutov3;
			end;
		end);
	end;
end);
spawn(function()
	while wait(.2) do
		pcall(function()
			if _G.RaceClickAutov4 then
				if plr.Character:FindFirstChild("RaceEnergy") then
					if (plr.Character:FindFirstChild("RaceEnergy")).Value == 1 then
						Useskills("nil", "Y");
					end;
				end;
			end;
		end);
	end;
end);
Setting:AddToggle({
	Name = "Ch\225\187\145ng Afk",
	Description = "",
	Default = true,
	Callback = function(I)
		_G.AntiAFK = I;
	end,
});
plr.Idled:connect(function()
	vim2:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
	wait(1);
	vim2:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
end);
Setting:AddToggle({
	Name = "T\225\186\175t th\195\180ng b\195\161o",
	Description = "",
	Default = GetSetting("DisableNotify_Save", false),
	Callback = function(I)
		RemoveDamage = I;
		_G.SaveData.DisableNotify_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	while wait(Sec) do
		pcall(function()
			if RemoveDamage then
				replicated.Assets.GUI.DamageCounter.Enabled = false;
				plr.PlayerGui.Notifications.Enabled = false;
			else
				replicated.Assets.GUI.DamageCounter.Enabled = true;
				plr.PlayerGui.Notifications.Enabled = true;
			end;
		end);
	end;
end);
Setting:AddSection({ "T\195\185y Ch\225\187\137nh" });
Setting:AddTextBox({
	Title = "kho\225\186\163ng c\195\161ch g\195\180m qu\195\161i",
	Description = "",
	PlaceHolder = "235",
	Default = tostring(_G.BringRange),
	Callback = function(Value)
		local num = tonumber(Value);
		if num and num > 0 then
			_G.BringRange = num;
		end;
	end,
});
Setting:AddTextBox({
	Title = "Kho\225\186\163ng c\195\161ch khi farm",
	Description = "",
	PlaceHolder = "20",
	Default = tostring(_G.MobHeight),
	Callback = function(Value)
		local num = tonumber(Value);
		if num and num > 0 then
			_G.MobHeight = num;
		end;
	end,
});
Setting:AddTextBox({
	Title = "T\225\187\145c \196\145\225\187\153 bay",
	Description = "",
	PlaceHolder = "300",
	Default = "300",
	Callback = function(I)
		if tonumber(I) then
			(getgenv()).TweenSpeedFar = tonumber(I);
		end;
	end,
});
Others:AddSection({ "C\195\162u c\195\161 v\225\186\161n c\195\162n:))" });
local RS = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local TweenService = game:GetService("TweenService");
local CoreGui = game:GetService("CoreGui");
local FishReplicated = RS:WaitForChild("FishReplicated");
local FishingRequest = FishReplicated:WaitForChild("FishingRequest");
local FishingClientConfig = require((FishReplicated:WaitForChild("FishingClient")):WaitForChild("Config"));
local GetWaterHeight = require((RS:WaitForChild("Util")):WaitForChild("GetWaterHeightAtLocation"));
local Net = (RS:WaitForChild("Modules")):WaitForChild("Net");
local CraftRemote = Net:WaitForChild("RF/Craft");
local JobsRemote = Net:WaitForChild("RF/JobsRemoteFunction");
local ToolAbilities = Net:WaitForChild("RF/JobToolAbilities");
local LogoID = "rbxassetid://120488231660846";
local function NotificacaoTuandz2(texto)
	task.spawn(function()
		local guiName = "NightMysticNotify";
		local existingGui = CoreGui:FindFirstChild(guiName);
		if existingGui then
			existingGui:Destroy();
		end;
		local sg = Instance.new("ScreenGui");
		sg.Name = guiName;
		sg.Parent = CoreGui;
		sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
		local frame = Instance.new("Frame");
		frame.Parent = sg;
		frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
		frame.Size = UDim2.new(0, 260, 0, 60);
		frame.Position = UDim2.new(1, 10, .85, 0);
		frame.BorderSizePixel = 0;
		local stroke = Instance.new("UIStroke");
		stroke.Parent = frame;
		stroke.Color = Color3.fromRGB(50, 50, 50);
		stroke.Thickness = 1;
		local corner = Instance.new("UICorner");
		corner.CornerRadius = UDim.new(0, 6);
		corner.Parent = frame;
		local icon = Instance.new("ImageLabel");
		icon.Parent = frame;
		icon.BackgroundTransparency = 1;
		icon.Position = UDim2.new(0, 10, 0, 10);
		icon.Size = UDim2.new(0, 40, 0, 40);
		icon.Image = LogoID;
		local title = Instance.new("TextLabel");
		title.Parent = frame;
		title.BackgroundTransparency = 1;
		title.Position = UDim2.new(0, 60, 0, 8);
		title.Size = UDim2.new(0, 190, 0, 20);
		title.Font = Enum.Font.GothamBold;
		title.Text = "Auto Fish Notication";
		title.TextColor3 = Color3.fromRGB(255, 255, 255);
		title.TextSize = 14;
		title.TextXAlignment = Enum.TextXAlignment.Left;
		local msg = Instance.new("TextLabel");
		msg.Parent = frame;
		msg.BackgroundTransparency = 1;
		msg.Position = UDim2.new(0, 60, 0, 28);
		msg.Size = UDim2.new(0, 190, 0, 20);
		msg.Font = Enum.Font.Gotham;
		msg.Text = texto;
		msg.TextColor3 = Color3.fromRGB(180, 180, 180);
		msg.TextSize = 12;
		msg.TextXAlignment = Enum.TextXAlignment.Left;
		local targetPos = UDim2.new(1, -270, .85, 0);
		(TweenService:Create(frame, TweenInfo.new(.5, Enum.EasingStyle.Exponential), { Position = targetPos })):Play();
		task.wait(3);
		(TweenService:Create(frame, TweenInfo.new(.5), { BackgroundTransparency = 1, Position = targetPos + UDim2.new(0, 0, -0.1, 0) })):Play();
		(TweenService:Create(stroke, TweenInfo.new(.5), { Transparency = 1 })):Play();
		(TweenService:Create(icon, TweenInfo.new(.5), { ImageTransparency = 1 })):Play();
		(TweenService:Create(title, TweenInfo.new(.5), { TextTransparency = 1 })):Play();
		(TweenService:Create(msg, TweenInfo.new(.5), { TextTransparency = 1 })):Play();
		task.wait(.5);
		sg:Destroy();
	end);
end;
_G.SelectedRod = "Fishing Rod";
_G.SelectedBait = "Basic Bait";
_G.AutoBuyBait = false;
_G.AutoFishing = false;
_G.AutoFishingQuest = false;
_G.AutoQuestComplete = false;
_G.AutoSellFish = false;
_G.AutoSkillZ = false;
Others:AddDropdown({
	Name = "Ch\225\187\141n c\225\186\167n",
	Description = "",
	Options = {
		"Fishing Rod",
		"Gold Rod",
		"Shark Rod",
		"Shell Rod",
		"Treasure Rod",
	},
	Default = GetSetting("Fish_SelectedRod", "Fishing Rod"),
	Callback = function(Value)
		_G.SelectedRod = Value;
		_G.SaveData.Fish_SelectedRod = Value;
		SaveSettings();
	end,
});
Others:AddDropdown({
	Name = "Ch\225\187\141n m\225\187\147i",
	Description = "",
	Options = {
		"Basic Bait",
		"Kelp Bait",
		"Good Bait",
		"Abyssal Bait",
		"Frozen Bait",
		"Epic Bait",
		"Carnivore Bait",
	},
	Default = GetSetting("Fish_SelectedBait", "Basic Bait"),
	Callback = function(Value)
		_G.SelectedBait = Value;
		_G.SaveData.Fish_SelectedBait = Value;
		SaveSettings();
		if _G.AutoBuyBait then
			pcall(function()
				CraftRemote:InvokeServer("Craft", _G.SelectedBait, {});
			end);
		end;
	end,
});
Others:AddToggle({
	Name = "T\225\187\177 \196\145\225\187\153ng mua m\225\187\147i",
	Description = "",
	Default = GetSetting("Fish_AutoBuyBait", false),
	Callback = function(Value)
		_G.AutoBuyBait = Value;
		_G.SaveData.Fish_AutoBuyBait = Value;
		SaveSettings();
		if Value then
			pcall(function()
				CraftRemote:InvokeServer("Craft", _G.SelectedBait, {});
			end);
		end;
	end,
});
task.spawn(function()
	while task.wait(2) do
		if _G.AutoBuyBait and _G.SelectedBait then
			pcall(function()
				CraftRemote:InvokeServer("Craft", _G.SelectedBait, {});
			end);
		end;
	end;
end);
Others:AddToggle({
	Name = "T\225\187\177 \196\145\225\187\153ng c\195\162u c\195\161",
	Description = "",
	Default = GetSetting("Fish_AutoFishing", false),
	Callback = function(Value)
		_G.AutoFishing = Value;
		_G.SaveData.Fish_AutoFishing = Value;
		SaveSettings();
	end,
});
task.spawn(function()
	while task.wait(.5) do
		if _G.AutoFishing then
			pcall(function()
				local plr = Players.LocalPlayer;
				local char = plr.Character or plr.CharacterAdded:Wait();
				local hrp = char:FindFirstChild("HumanoidRootPart");
				if not hrp then
					return;
				end;
				local equippedTool = char:FindFirstChildOfClass("Tool");
				if _G.SelectedRod and (not equippedTool or equippedTool.Name ~= _G.SelectedRod) then
					local rodInBag = plr.Backpack:FindFirstChild(_G.SelectedRod);
					if rodInBag then
						char.Humanoid:EquipTool(rodInBag);
						equippedTool = rodInBag;
					else
						NotificacaoTuandz2("L\195\160m \198\161n trang b\225\187\139:" .. tostring(_G.SelectedRod));
						return;
					end;
				end;
				if equippedTool then
					local maxLaunch = FishingClientConfig.Rod.MaxLaunchDistance;
					local waterHeight = GetWaterHeight(hrp.Position);
					local rayOrigin = char.Head.Position;
					local rayDirection = hrp.CFrame.LookVector * maxLaunch;
					local ignoreList = { char, Workspace.Characters, Workspace.Enemies };
					local _, hitPos = Workspace:FindPartOnRayWithIgnoreList(Ray.new(rayOrigin, rayDirection), ignoreList);
					local targetPos = hitPos and Vector3.new(hitPos.X, math.max(hitPos.Y, waterHeight), hitPos.Z);
					local state = equippedTool:GetAttribute("State");
					local serverState = equippedTool:GetAttribute("ServerState");
					if targetPos and (state == "ReeledIn" or serverState == "ReeledIn") then
						FishingRequest:InvokeServer("StartCasting");
						task.wait();
						FishingRequest:InvokeServer("CastLineAtLocation", targetPos, 100, true);
					elseif serverState == "Biting" then
						FishingRequest:InvokeServer("Catching", true);
						task.wait(.1);
						FishingRequest:InvokeServer("Catch", 1);
						NotificacaoTuandz2("New item caught");
					end;
				end;
			end);
		end;
	end;
end);
Others:AddToggle({
	Name = "T\225\187\177 \196\145\225\187\153ng nh\225\186\173n nhi\225\187\135m v\225\187\165",
	Description = "Nh\225\186\173n nhi\225\187\135m v\225\187\165 t\225\187\171 NPC Angler.",
	Default = GetSetting("Fish_AutoQuest", false),
	Callback = function(Value)
		_G.AutoFishingQuest = Value;
		_G.SaveData.Fish_AutoQuest = Value;
		SaveSettings();
	end,
});
local function HasQuest()
	local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");
	if playerGui then
		local questGui = playerGui:FindFirstChild("Quest") or playerGui:FindFirstChild("QuestGui");
		if questGui and (questGui:FindFirstChild("Container") and questGui.Container:FindFirstChild("QuestTitle")) then
			return true;
		end;
	end;
	return false;
end;
task.spawn(function()
	while task.wait(1) do
		if _G.AutoFishingQuest then
			pcall(function()
				if not HasQuest() then
					JobsRemote:InvokeServer("FishingNPC", "Angler", "AskQuest");
				end;
			end);
		end;
	end;
end);
Others:AddToggle({
	Name = "T\225\187\177 \196\145\225\187\153ng ho\195\160n th\195\160nh nhi\225\187\135m v\225\187\165",
	Description = "",
	Default = GetSetting("Fish_AutoComplete", false),
	Callback = function(Value)
		_G.AutoQuestComplete = Value;
		_G.SaveData.Fish_AutoComplete = Value;
		SaveSettings();
		if Value then
			pcall(function()
				JobsRemote:InvokeServer("FishingNPC", "FinishQuest");
			end);
		end;
	end,
});
task.spawn(function()
	while task.wait(5) do
		if _G.AutoQuestComplete then
			pcall(function()
				JobsRemote:InvokeServer("FishingNPC", "FinishQuest");
			end);
		end;
	end;
end);
Others:AddToggle({
	Name = "T\225\187\177 \196\144\225\187\153ng B\195\161n C\195\161",
	Description = "",
	Default = GetSetting("Fish_AutoSell", false),
	Callback = function(Value)
		_G.AutoSellFish = Value;
		_G.SaveData.Fish_AutoSell = Value;
		SaveSettings();
		if Value then
			pcall(function()
				JobsRemote:InvokeServer("FishingNPC", "SellFish");
			end);
		end;
	end,
});
task.spawn(function()
	while task.wait(5) do
		if _G.AutoSellFish then
			pcall(function()
				JobsRemote:InvokeServer("FishingNPC", "SellFish");
			end);
		end;
	end;
end);
Others:AddToggle({
	Name = "T\225\187\177 \196\145\225\187\153ng s\225\187\173 d\225\187\165ng skill z c\225\187\167a c\225\186\167n c\195\162u",
	Description = "spam skil z c\225\187\167a c\225\186\167n c\195\162u",
	Default = GetSetting("Fish_AutoSkillZ", false),
	Callback = function(Value)
		_G.AutoSkillZ = Value;
		_G.SaveData.Fish_AutoSkillZ = Value;
		SaveSettings();
	end,
});
task.spawn(function()
	while task.wait(.5) do
		if _G.AutoSkillZ then
			pcall(function()
				ToolAbilities:InvokeServer("Z", true);
			end);
		end;
	end;
end);
local plr = game.Players.LocalPlayer;
local RS = game:GetService("ReplicatedStorage");
local WS = game:GetService("Workspace");
_G.AutoBoss = false;
_G.FarmAllBoss = false;
_G.AutoAcceptQuest = false;
_G.CurrentTargetBoss = nil;
_G.FindBoss = _G.FindBoss or Boss and Boss[1];
local function EquipWeapon()
	local char = plr.Character;
	if not char then
		return;
	end;
	local hum = char:FindFirstChildOfClass("Humanoid");
	if not hum then
		return;
	end;
	if _G.SelectWeapon then
		local tool = plr.Backpack:FindFirstChild(_G.SelectWeapon) or char:FindFirstChild(_G.SelectWeapon);
		if tool and tool.Parent ~= char then
			hum:EquipTool(tool);
		end;
	end;
end;
local function GoToBoss(targetBoss)
	local char = plr.Character;
	local hrp = char and char:FindFirstChild("HumanoidRootPart");
	local hum = char and char:FindFirstChildOfClass("Humanoid");
	if not targetBoss or not hrp or not hum then
		return;
	end;
	local bossHRP = targetBoss:FindFirstChild("HumanoidRootPart") or targetBoss:FindFirstChild("Torso");
	if not bossHRP then
		return;
	end;
	local safeHeight = 22;
	local targetPos = bossHRP.Position + Vector3.new(0, safeHeight, 0);
	local targetCFrame = CFrame.new(targetPos);
	local distToSafeSpot = (hrp.Position - targetPos).Magnitude;
	EquipWeapon();
	if distToSafeSpot <= 5 then
		hrp.CFrame = targetCFrame;
		hrp.Velocity = Vector3.zero;
		hrp.AssemblyLinearVelocity = Vector3.zero;
		hum.AutoRotate = false;
		(game:GetService("VirtualUser")):CaptureController();
		(game:GetService("VirtualUser")):Button1Down(Vector2.new(1280, 672));
	else
		if _tp then
			_tp(targetCFrame);
		else
			hrp.CFrame = targetCFrame;
		end;
	end;
end;
Others:AddSection({ "Boss Farm" });
local BossDropdown = Others:AddDropdown({
		Name = "Ch\225\187\141n Boss",
		Options = Boss,
		Default = Boss[1],
		Callback = function(v)
			_G.FindBoss = v;
		end,
	});
Others:AddButton({ Name = "L\195\160m m\225\187\155i danh s\195\161ch boss", Description = "", Callback = function()
		local LiveBosses = {};
		local FoundAny = false;
		for _, obj in pairs(WS:GetDescendants()) do
			if obj:IsA("Model") and obj:GetAttribute("IsBoss") == true then
				if not table.find(LiveBosses, obj.Name) then
					table.insert(LiveBosses, obj.Name);
					FoundAny = true;
				end;
			end;
		end;
		for _, obj in pairs(RS:GetDescendants()) do
			if obj:IsA("Model") and obj:GetAttribute("IsBoss") == true then
				if not table.find(LiveBosses, obj.Name) then
					table.insert(LiveBosses, obj.Name);
					FoundAny = true;
				end;
			end;
		end;
		if FoundAny then
			table.sort(LiveBosses);
			BossDropdown:Refresh(LiveBosses, true);
		else
			BossDropdown:Refresh({ "Kh\195\180ng t\195\172m th\225\186\165y boss" }, true);
		end;
	end });
Others:AddToggle({ Name = "Auto Farm Boss \196\144\195\163 Ch\225\187\141n", Default = false, Callback = function(v)
		_G.AutoBoss = v;
		if v then
			_G.FarmAllBoss = false;
		end;
	end });
Others:AddToggle({ Name = "Auto Nh\225\186\173n nhi\225\187\135m v\225\187\165 boss", Default = false, Callback = function(v)
		_G.AutoAcceptQuest = v;
	end });
Others:AddToggle({
	Name = "Farm T\225\186\165t c\225\186\163 boss",
	Description = "",
	Default = false,
	Callback = function(v)
		_G.FarmAllBoss = v;
		if v then
			_G.AutoBoss = false;
		end;
		_G.CurrentTargetBoss = nil;
	end,
});
spawn(function()
	while task.wait() do
		if not _G.FarmAllBoss then
			task.wait(.5);
			continue;
		end;
		if _G.CurrentTargetBoss and (_G.CurrentTargetBoss.Parent and (_G.CurrentTargetBoss:FindFirstChild("Humanoid") and _G.CurrentTargetBoss.Humanoid.Health > 0)) then
			task.wait(.2);
			continue;
		end;
		local char = plr.Character;
		local myHrp = char and char:FindFirstChild("HumanoidRootPart");
		if not myHrp then
			task.wait(.5);
			continue;
		end;
		local potentialBosses = {};
		local foundInWorkspace = false;
		local function FastScan(container, isRS)
			for _, v in pairs(container:GetDescendants()) do
				if v:IsA("Model") and v:GetAttribute("IsBoss") == true then
					if v.Name ~= "Cursed Skeleton Boss" then
						local h = v:FindFirstChild("Humanoid");
						local hrp = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Torso");
						if h and (h.Health > 0 and hrp) then
							local dist = (myHrp.Position - hrp.Position).Magnitude;
							if isRS then
								table.insert(potentialBosses, { Model = v, Distance = dist + 10000 });
							else
								table.insert(potentialBosses, { Model = v, Distance = dist });
								foundInWorkspace = true;
							end;
						end;
					end;
				end;
			end;
		end;
		FastScan(WS, false);
		if not foundInWorkspace then
			FastScan(RS, true);
		end;
		if #potentialBosses > 0 then
			table.sort(potentialBosses, function(a, b)
				return a.Distance < b.Distance;
			end);
			_G.CurrentTargetBoss = potentialBosses[1].Model;
		else
			_G.CurrentTargetBoss = nil;
		end;
		task.wait(.2);
	end;
end);
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.AutoBoss and _G.FindBoss then
				if QuestB then
					QuestB();
				end;
				local NeedQuest = false;
				local char = plr.Character;
				if not char or not char:FindFirstChild("HumanoidRootPart") then
					return;
				end;
				if _G.AutoAcceptQuest and (Qname and (Qdata and PosQBoss)) then
					local playerGui = plr.PlayerGui:FindFirstChild("Main") and plr.PlayerGui.Main:FindFirstChild("Quest");
					local hasQuest = playerGui and playerGui.Visible;
					if not hasQuest then
						NeedQuest = true;
					end;
				end;
				if NeedQuest then
					if (PosQBoss.Position - char.HumanoidRootPart.Position).Magnitude <= 5 then
						RS.Remotes.CommF_:InvokeServer("StartQuest", Qname, Qdata);
					else
						if _tp then
							_tp(PosQBoss);
						else
							char.HumanoidRootPart.CFrame = PosQBoss;
						end;
					end;
					return;
				end;
				local specificBoss = WS:FindFirstChild("Enemies") and WS.Enemies:FindFirstChild(_G.FindBoss) or WS:FindFirstChild(_G.FindBoss);
				if specificBoss and (specificBoss:FindFirstChild("Humanoid") and specificBoss.Humanoid.Health > 0) then
					GoToBoss(specificBoss);
				elseif PosB then
					if _tp then
						_tp(PosB);
					else
						char.HumanoidRootPart.CFrame = PosB;
					end;
				end;
			elseif _G.FarmAllBoss then
				if _G.CurrentTargetBoss then
					GoToBoss(_G.CurrentTargetBoss);
				end;
			end;
		end);
	end;
end);
spawn(function()
	while task.wait(.5) do
		if plr.Backpack and _G.ChooseWP then
			for _, e in pairs(plr.Backpack:GetChildren()) do
				if e.ToolTip == _G.ChooseWP then
					_G.SelectWeapon = e.Name;
				end;
			end;
		end;
	end;
end);
Others:AddSection({ "Nhi\225\187\135m v\225\187\165" });
Others:AddToggle({
	Name = "Auto Farm \196\144i\225\187\131m Haki quan s\195\161t",
	Description = "",
	Default = GetSetting("AutoObsFarm_Save", false),
	Callback = function(I)
		_G.obsFarm = I;
		_G.SaveData.AutoObsFarm_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	while wait(.2) do
		pcall(function()
			if _G.obsFarm then
				replicated.Remotes.CommE:FireServer("Ken", true);
				if plr:GetAttribute("KenDodgesLeft") == 0 then
					KenTest = false;
				elseif plr:GetAttribute("KenDodgesLeft") > 0 then
					replicated.Remotes.CommE:FireServer("Ken", true);
					KenTest = true;
				end;
			end;
		end);
	end;
end);
spawn(function()
	while wait(.2) do
		pcall(function()
			if _G.obsFarm then
				if World1 then
					if workspace.Enemies:FindFirstChild("Galley Captain") then
						if KenTest then
							repeat
								wait();
								plr.Character.HumanoidRootPart.CFrame = (workspace.Enemies:FindFirstChild("Galley Captain")).HumanoidRootPart.CFrame * CFrame.new(3, 0, 0);
							until _G.obsFarm == false or KenTest == false;
						else
							repeat
								wait();
								plr.Character.HumanoidRootPart.CFrame = (workspace.Enemies:FindFirstChild("Galley Captain")).HumanoidRootPart.CFrame * CFrame.new(0, 50, 0);
							until _G.obsFarm == false or KenTest;
						end;
					else
						_tp(CFrame.new(5533.29785, 88.1079102, 4852.3916));
					end;
				elseif World2 then
					if workspace.Enemies:FindFirstChild("Lava Pirate") then
						if KenTest then
							repeat
								wait();
								plr.Character.HumanoidRootPart.CFrame = (workspace.Enemies:FindFirstChild("Lava Pirate")).HumanoidRootPart.CFrame * CFrame.new(3, 0, 0);
							until _G.obsFarm == false or KenTest == false;
						else
							repeat
								wait();
								plr.Character.HumanoidRootPart.CFrame = (workspace.Enemies:FindFirstChild("Lava Pirate")).HumanoidRootPart.CFrame * CFrame.new(0, 50, 0);
							until _G.obsFarm == false or KenTest;
						end;
					else
						_tp(CFrame.new(-5478.39209, 15.9775667, -5246.9126));
					end;
				elseif World3 then
					if workspace.Enemies:FindFirstChild("Venomous Assailant") then
						if KenTest then
							repeat
								wait();
								_tp((workspace.Enemies:FindFirstChild("Venomous Assailant")).HumanoidRootPart.CFrame * CFrame.new(3, 0, 0));
							until _G.obsFarm == false or KenTest == false;
						else
							repeat
								wait();
								_tp((workspace.Enemies:FindFirstChild("Venomous Assailant")).HumanoidRootPart.CFrame * CFrame.new(0, 50, 0));
							until _G.obsFarm == false or KenTest;
						end;
					else
						_tp(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789));
					end;
				end;
			end;
		end);
	end;
end);
if World3 then
	Others:AddToggle({
		Name = "Auto Haki quan s\195\161t V2",
		Description = "",
		Default = GetSetting("AutoKenV2_Save", false),
		Callback = function(I)
			_G.AutoKenVTWO = I;
			_G.SaveData.AutoKenV2_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.AutoKenVTWO then
				pcall(function()
					local I = CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625);
					local e = "Kuy";
					local K = CFrame.new(-10920.125, 624.20275878906, -10266.995117188);
					local n = CFrame.new(-13277.568359375, 370.34185791016, -7821.1572265625);
					local d = CFrame.new(-13493.12890625, 318.89553833008, -8373.7919921875);
					if plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat 50 Forest Pirates") then
						local I = GetConnectionEnemies("Forest Pirate");
						if I then
							repeat
								wait();
								G.Kill(I, _G.AutoKenVTWO);
							until not _G.AutoKenVTWO or I.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false;
						else
							_tp(n);
						end;
					elseif plr.PlayerGui.Main.Quest.Visible == true then
						local I = GetConnectionEnemies("Captain Elephant");
						if I then
							repeat
								wait();
								G.Kill(I, _G.AutoKenVTWO);
							until not _G.AutoKenVTWO or I.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false;
						else
							_tp(d);
						end;
					elseif plr.PlayerGui.Main.Quest.Visible == false then
						replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
						wait(.1);
						replicated.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1);
					end;
					if replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
						_tp(CFrame.new(-12513.51953125, 340.11373901367, -9873.048828125));
					end;
					if not plr.Backpack:FindFirstChild("Fruit Bowl") or not plr.Character:FindFirstChild("Fruit Bowl") then
						if not GetBP("Fruit Bowl") then
							if not GetBP("Apple") then
								replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375));
								for I, e in pairs(workspace:GetDescendants()) do
									if e.Name == "Apple" then
										e.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10);
										wait();
										firetouchinterest(plr.Character.HumanoidRootPart, e.Handle, 0);
										wait();
									end;
								end;
							elseif not GetBP("Banana") then
								_tp(CFrame.new(2286.0078125, 73.133918762207, -7159.8090820312));
								for I, e in pairs(workspace:GetDescendants()) do
									if e.Name == "Banana" then
										e.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10);
										wait();
										firetouchinterest(plr.Character.HumanoidRootPart, e.Handle, 0);
										wait();
									end;
								end;
							elseif not GetBP("Pineapple") then
								_tp(CFrame.new(-712.82727050781, 98.577049255371, 5711.9541015625));
								for I, e in pairs(workspace:GetDescendants()) do
									if e.Name == "Pineapple" then
										e.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10);
										wait();
										firetouchinterest(plr.Character.HumanoidRootPart, e.Handle, 0);
										wait();
									end;
								end;
							end;
						end;
						if plr.Backpack:FindFirstChild("Banana") and (plr.Backpack:FindFirstChild("Apple") and plr.Backpack:FindFirstChild("Pineapple")) or plr:FindFirstChild("Banana") and (plr:FindFirstChild("Apple") and plr:FindFirstChild("Pineapple")) then
							repeat
								wait();
								_tp(I);
							until _G.AutoKenVTWO or plr.Character.HumanoidRootPart.CFrame == I;
							replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
						end;
						if plr.Backpack:FindFirstChild("Fruit Bowl") or plr.Character:FindFirstChild("Fruit Bowl") then
							if plr.Character.HumanoidRootPart.CFrame ~= K then
								_tp(K);
							elseif plr.Character.HumanoidRootPart.CFrame == K then
								replicated.Remotes.CommF_:InvokeServer("KenTalk2", "Start");
								wait(.1);
								replicated.Remotes.CommF_:InvokeServer("KenTalk2", "Buy");
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	Others:AddToggle({
		Name = "Nhi\225\187\135m v\225\187\165 c\195\180ng d\195\162n t\225\187\177 \196\145\225\187\153ng",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.CitizenQuest = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.CitizenQuest then
					if Lv >= 1800 and (replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress")).KilledBandits == false then
						if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and (string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and plr.PlayerGui.Main.Quest.Visible == true) then
							local I = GetConnectionEnemies("Forest Pirate");
							if I then
								repeat
									task.wait();
									G.Kill(I, _G.CitizenQuest);
								until _G.CitizenQuest == false or not I.Parent or I.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false;
							else
								_tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375));
							end;
						else
							_tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125));
							if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - plr.Character.HumanoidRootPart.Position).Magnitude <= 30 then
								wait(1.5);
								replicated.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1);
							end;
						end;
					elseif Lv >= 1800 and (replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress")).KilledBoss == false then
						local I = GetConnectionEnemies("Captain Elephant");
						if plr.PlayerGui.Main.Quest.Visible and (string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and plr.PlayerGui.Main.Quest.Visible == true) then
							if I then
								repeat
									task.wait();
									G.Kill(I, _G.CitizenQuest);
								until _G.CitizenQuest == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
							else
								_tp(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375));
							end;
						else
							_tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125));
							if ((CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125)).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 4 then
								wait(1.5);
								replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
							end;
						end;
					elseif Lv >= 1800 and replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
						_tp(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125));
					end;
				end;
			end);
		end;
	end);
	Others:AddSection({ "Ki\225\186\191m b\225\187\139 nguy\225\187\129n r\225\187\167a" });
	local r = Others:AddParagraph({ Title = "Elites tr\225\186\161ng th\195\161i: ", Content = "" });
	spawn(function()
		while wait(Sec) do
			pcall(function()
				r:SetDesc("Elite \196\145\195\163 gi\225\186\191t :  " .. replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress"));
			end);
		end;
	end);
	Others:AddToggle({
		Name = "Auto Gi\225\186\191t Elite",
		Description = "",
		Default = GetSetting("AutoEliteQuest_Save", false),
		Callback = function(I)
			_G.FarmEliteHunt = I;
			_G.SaveData.AutoEliteQuest_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.FarmEliteHunt then
					if plr.PlayerGui.Main.Quest.Visible == true then
						if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
							for I, e in pairs(replicated:GetChildren()) do
								if string.find(e.Name, "Diablo") or string.find(e.Name, "Urban") or string.find(e.Name, "Deandre") then
									_tp(e.HumanoidRootPart.CFrame);
								end;
							end;
							for I, e in pairs(Enemies:GetChildren()) do
								if (string.find(e.Name, "Diablo") or string.find(e.Name, "Urban") or string.find(e.Name, "Deandre")) and G.Alive(e) then
									repeat
										wait();
										G.Kill(e, _G.FarmEliteHunt);
									until not _G.FarmEliteHunt or plr.PlayerGui.Main.Quest.Visible == false or not e.Parent or e.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						replicated.Remotes.CommF_:InvokeServer("EliteHunter");
					end;
				end;
			end);
		end;
	end);
	Others:AddToggle({
		Name = "D\225\187\171ng khi c\195\179 v\225\186\173t ph\225\186\169m hi\225\186\191m",
		Description = "",
		Default = GetSetting("StopChalice_Save", true),
		Callback = function(I)
			_G.StopWhenChalice = I;
			_G.SaveData.StopChalice_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(.2) do
			if _G.StopWhenChalice and _G.FarmEliteHunt then
				pcall(function()
					if GetBP("God\'s Chalice") or GetBP("Sweet Chalice") or GetBP("Fist of Darkness") then
						_G.FarmEliteHunt = false;
					end;
				end);
			end;
		end;
	end);
	Others:AddToggle({
		Name = "Auto Ki\225\186\191m Tushita",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Auto_Tushita = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Tushita then
					if workspace.Map.Turtle:FindFirstChild("TushitaGate") then
						if not GetBP("Holy Torch") then
							_tp(CFrame.new(5148.03613, 162.352493, 910.548218));
							wait(.7);
						else
							EquipWeapon("Holy Torch");
							task.wait(1);
							repeat
								task.wait();
								_tp(CFrame.new(-10752, 417, -9366));
							until not _G.Auto_Tushita or ((CFrame.new(-10752, 417, -9366)).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10;
							wait(.7);
							repeat
								task.wait();
								_tp(CFrame.new(-11672, 334, -9474));
							until not _G.Auto_Tushita or ((CFrame.new(-11672, 334, -9474)).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10;
							wait(.7);
							repeat
								task.wait();
								_tp(CFrame.new(-12132, 521, -10655));
							until not _G.Auto_Tushita or ((CFrame.new(-12132, 521, -10655)).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10;
							wait(.7);
							repeat
								task.wait();
								_tp(CFrame.new(-13336, 486, -6985));
							until not _G.Auto_Tushita or ((CFrame.new(-13336, 486, -6985)).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10;
							wait(.7);
							repeat
								task.wait();
								_tp(CFrame.new(-13489, 332, -7925));
							until not _G.Auto_Tushita or ((CFrame.new(-13489, 332, -7925)).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10;
						end;
					else
						local I = GetConnectionEnemies("Longma");
						if I then
							repeat
								task.wait();
								G.Kill(I, _G.Auto_Tushita);
							until I.Humanoid.Health <= 0 or not _G.Auto_Tushita or not I.Parent;
						else
							if replicated:FindFirstChild("Longma") then
								_tp((replicated:FindFirstChild("Longma")).HumanoidRootPart.CFrame * CFrame.new(0, 40, 0));
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	Others:AddToggle({
		Name = "Auto Ki\225\186\191m Yama",
		Description = "",
		Default = GetSetting("AutoYama_Save", false),
		Callback = function(I)
			_G.Auto_Yama = I;
			_G.SaveData.AutoYama_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Yama then
					if replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") < 30 then
						_G.FarmEliteHunt = true;
					elseif replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") > 30 then
						_G.FarmEliteHunt = false;
						if (workspace.Map.Waterfall.SealedKatana.Handle.Position - plr.Character.HumanoidRootPart.Position).Magnitude >= 20 then
							_tp(workspace.Map.Waterfall.SealedKatana.Handle.CFrame);
							local I = GetConnectionEnemies("Ghost");
							if I then
								repeat
									wait();
									G.Kill(I, _G.Auto_Yama);
								until I.Humanoid.Health <= 0 or not I.Parent or not _G.Auto_Yama;
								fireclickdetector(workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector);
							end;
						end;
					end;
				end;
			end);
		end;
	end);
end;
if World2 or World3 then
	Others:AddSection({ "M\195\160u s\225\186\175c haki / Ho\195\160 quang" });
	Others:AddToggle({
		Name = "D\225\187\139ch chuy\225\187\131n t\225\187\155i Barista Haki",
		Description = "",
		Default = GetSetting("TpBarista_Save", false),
		Callback = function(I)
			_G.Tp_MasterA = I;
			_G.SaveData.TpBarista_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait() do
			if _G.Tp_MasterA then
				pcall(function()
					for _, e in pairs(replicated.NPCs:GetChildren()) do
						if e.Name == "Barista Cousin" then
							_tp(e.HumanoidRootPart.CFrame);
						end;
					end;
				end);
			end;
		end;
	end);
	Others:AddButton({ Name = "Mua Haki M\195\160u", Description = "", Callback = function()
			replicated.Remotes.CommF_:InvokeServer("ColorsDealer", "2");
		end });
end;
if World3 then
	Others:AddToggle({
		Name = "T\225\187\177 \196\145\225\187\153ng haki c\225\186\167u v\225\187\147ng",
		Description = "",
		Default = GetSetting("AutoRainbowHaki_Save", false),
		Callback = function(I)
			_G.Auto_Rainbow_Haki = I;
			_G.SaveData.AutoRainbowHaki_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		pcall(function()
			while wait(Sec) do
				if _G.Auto_Rainbow_Haki then
					if plr.PlayerGui.Main.Quest.Visible == false then
						if _G.GetQFast then
							if plr.PlayerGui.Main.Quest.Visible == false then
								replicated.Remotes.CommF_:InvokeServer("HornedMan", "Bet");
							end;
						else
							Rainbow1 = CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875);
							if plr.Character.HumanoidRootPart.CFrame ~= Rainbow1 then
								_tp(Rainbow1);
							elseif plr.Character.HumanoidRootPart.CFrame == Rainbow1 then
								wait(1);
								replicated.Remotes.CommF_:InvokeServer("HornedMan", "Bet");
							end;
						end;
					elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
						local I = GetConnectionEnemies("Stone");
						if I then
							repeat
								wait();
								G.Kill(I, _G.Auto_Rainbow_Haki);
							until _G.Auto_Rainbow_Haki == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
						else
							_tp(CFrame.new(-1086.11621, 38.8425903, 6768.71436, .0231462717, -0.592676699, .805107772, 2.03251839e-005, .805323839, .592835128, -0.999732077, -0.0137055516, .0186523199));
						end;
					elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Hydra Leader") then
						local I = GetConnectionEnemies("Hydra Leader");
						if I then
							repeat
								task.wait();
								G.Kill(I, _G.Auto_Rainbow_Haki);
							until _G.Auto_Rainbow_Haki == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
						else
							replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5643.4526367188, 1013.0858154297, -340.51025390625));
							local I = Vector3.new(5643.4526367188, 1013.0858154297, -340.51025390625);
							local e = CFrame.new(5821.8979492188, 1019.0950927734, -73.719230651855);
							if plr.Character.HumanoidRootPart.CFrame.Position == I then
								_tp(e);
							end;
						end;
					elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
						local I = GetConnectionEnemies("Kilo Admiral");
						if I then
							repeat
								task.wait();
								G.Kill(I, _G.Auto_Rainbow_Haki);
							until _G.Auto_Rainbow_Haki == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
						else
							_tp(CFrame.new(2877.61743, 423.558685, -7207.31006, -0.989591599, 0, -0.143904909, 0, 1.00000012, 0, .143904924, 0, -0.989591479));
						end;
					elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
						local I = GetConnectionEnemies("Captain Elephant");
						if I then
							repeat
								task.wait();
								G.Kill(I, _G.Auto_Rainbow_Haki);
							until _G.Auto_Rainbow_Haki == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
						else
							local I = Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375);
							local e = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125);
							if plr.Character.HumanoidRootPart.CFrame.Position ~= I then
								replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375));
							elseif plr.Character.HumanoidRootPart.CFrame.Position == I then
								_tp(e);
							end;
						end;
					elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
						local I = GetConnectionEnemies("Captain Elephant");
						if I then
							repeat
								task.wait();
								G.Kill(I, _G.Auto_Rainbow_Haki);
							until _G.Auto_Rainbow_Haki == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
						else
							replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5314.5463867188, 22.562219619751, -127.06755065918));
						end;
					end;
				end;
			end;
		end);
	end);
end;
Others:AddToggle({
	Name = "Nh\225\186\173n nhi\225\187\135m v\225\187\165 bypass [Risk]",
	Description = "",
	Default = GetSetting("BypassQuest_Save", false),
	Callback = function(I)
		_G.GetQFast = I;
		_G.SaveData.BypassQuest_Save = I;
		SaveSettings();
	end,
});
Event:AddSection({ "S\225\187\177 ki\225\187\135n bi\225\187\131n" });
local z5 = {
		"Guardian",
		"PirateGrandBrigade",
		"MarineGrandBrigade",
		"PirateBrigade",
		"MarineBrigade",
		"PirateSloop",
		"MarineSloop",
		"Beast Hunter",
	};
Event:AddDropdown({
	Name = "Ch\225\187\141n Thuy\225\187\129n",
	Description = "",
	Options = z5,
	Default = "Guardian",
	Multi = false,
	Callback = function(I)
		_G.SelectedBoat = I;
	end,
});
if World3 then
	local H5 = {
			"Lv 1",
			"Lv 2",
			"Lv 3",
			"Lv 4",
			"Lv 5",
			"Lv 6",
			"Lv Infinite",
		};
	Event:AddDropdown({
		Name = "Ch\225\187\141n level bi\225\187\131n",
		Description = "Ch\225\187\141n m\225\187\169c \196\145\225\187\153 nguy hi\225\187\131m ",
		Options = H5,
		Default = "Lv 1",
		Multi = false,
		Callback = function(I)
			_G.DangerSc = I;
		end,
	});
end;
Event:AddToggle({
	Name = "Auto b\225\186\175t \196\145\225\186\167u sea event",
	Description = "t\225\187\177 mua thuy\225\187\129n v\195\160 \196\145i ra bi\225\187\131n",
	Default = false,
	Callback = function(I)
		_G.SailBoats = I;
	end,
});
spawn(function()
	while wait() do
		if _G.SailBoats then
			pcall(function()
				local I = CheckBoat();
				if not I then
					local BoatDealerPos = CFrame.new(-16927.451, 9.086, 433.864);
					TeleportToTarget(BoatDealerPos);
					if (BoatDealerPos.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
						replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat);
					end;
				elseif I and (not (CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha) and (not (CheckEnemiesBoat() and _G.FishBoat) and (not (CheckSeaBeast() and _G.SeaBeast1) and (not (_G.PGB and CheckPirateGrandBrigade()) and (not (_G.HCM and CheckHauntedCrew()) and not (_G.Leviathan1 and CheckLeviathan())))))) then
					if plr.Character.Humanoid.Sit == false then
						local e = I.VehicleSeat.CFrame * CFrame.new(0, 1, 0);
						_tp(e);
					else
						if _G.DangerSc == "Lv 1" then
							CFrameSelectedZone = CFrame.new(-21998.375, 30.0006084, -682.309143);
						elseif _G.DangerSc == "Lv 2" then
							CFrameSelectedZone = CFrame.new(-26779.5215, 30.0005474, -822.858032);
						elseif _G.DangerSc == "Lv 3" then
							CFrameSelectedZone = CFrame.new(-31171.957, 30.0001011, -2256.93774);
						elseif _G.DangerSc == "Lv 4" then
							CFrameSelectedZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012);
						elseif _G.DangerSc == "Lv 5" then
							CFrameSelectedZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023);
						elseif _G.DangerSc == "Lv 6" then
							CFrameSelectedZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584);
						elseif _G.DangerSc == "Lv Infinite" then
							CFrameSelectedZone = CFrame.new(-10000000, 31, 37016.25);
						end;
						repeat
							wait();
							if not _G.FishBoat and CheckEnemiesBoat() or not _G.PGB and CheckPirateGrandBrigade() or not _G.TerrorShark and CheckTerrorShark() then
								_tp(CFrameSelectedZone * CFrame.new(0, 150, 0));
							else
								_tp(CFrameSelectedZone);
							end;
						until _G.SailBoats == false or CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha or CheckSeaBeast() and _G.SeaBeast1 or CheckEnemiesBoat() and _G.FishBoat or _G.Leviathan1 and CheckLeviathan() or _G.HCM and CheckHauntedCrew() or _G.PGB and CheckPirateGrandBrigade() or (plr.Character:WaitForChild("Humanoid")).Sit == false;
						plr.Character.Humanoid.Sit = false;
					end;
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(Sec) do
		pcall(function()
			for I, e in pairs(workspace.Boats:GetChildren()) do
				for I, e in pairs(workspace.Boats[e.Name]:GetDescendants()) do
					if e:IsA("BasePart") then
						if _G.SailBoats or _G.Prehis_Find or _G.FindMirage or _G.SailBoat_Hydra or _G.AutofindKitIs then
							e.CanCollide = false;
						else
							e.CanCollide = true;
						end;
					end;
				end;
			end;
		end);
	end;
end);
_G.SetSpeedBoat = 300;
Event:AddToggle({
	Name = "K\195\173ch ho\225\186\161t t\225\187\145c \196\145\225\187\153 thuy\225\187\129n",
	Description = "t\195\185y ch\225\187\137nh t\225\187\145c \196\145\225\187\153 thuy\225\187\129n",
	Default = false,
	Callback = function(Value)
		_G.SpeedBoat = Value;
	end,
});
Event:AddTextBox({
	Title = "T\225\187\145c \196\145\225\187\153 thuy\225\187\129n",
	Description = "M\225\186\183c \196\145\225\187\139nh: 300",
	PlaceHolder = "300",
	Default = "300",
	Callback = function(Value)
		local num = tonumber(Value);
		if num and num > 0 then
			_G.SetSpeedBoat = num;
		end;
	end,
});
task.spawn(function()
	(game:GetService("RunService")).RenderStepped:Connect(function()
		if _G.SpeedBoat then
			pcall(function()
				local plr = game.Players.LocalPlayer;
				if plr.Character and (plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Sit) then
					for _, boat in pairs(workspace.Boats:GetChildren()) do
						local seat = boat:FindFirstChildWhichIsA("VehicleSeat");
						if seat then
							seat.MaxSpeed = _G.SetSpeedBoat;
							seat.Torque = .2;
							seat.TurnSpeed = 5;
						end;
					end;
				end;
			end);
		end;
	end);
end);
Event:AddSection({ "Auto \196\145\195\161nh sea event" });
Event:AddToggle({
	Name = "T\225\186\165n c\195\180ng Sea Beast",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.SeaBeast1 = I;
	end,
});
Event:AddToggle({
	Name = "T\225\186\165n c\195\180ng Pirate GrandBrigade",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.PGB = I;
	end,
});
if World2 then
	Event:AddSection({ "Go to Sea 3 pls " });
end;
if World1 then
	Event:AddSection({ "Go to Sea 3 or Sea 2 Bro!" });
end;
if game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
	Event:AddToggle({
		Name = "T\225\186\165n c\195\180ng Shark",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Shark = I;
		end,
	});
	Event:AddToggle({
		Name = "T\225\186\165n c\195\180ng Piranha",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Piranha = I;
		end,
	});
	Event:AddToggle({
		Name = "T\225\186\165n c\195\180ng Terror Shark",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.TerrorShark = I;
		end,
	});
	Event:AddToggle({
		Name = "T\225\186\165n c\195\180ng Fish Crew Member",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.MobCrew = I;
		end,
	});
	Event:AddToggle({
		Name = "T\225\186\165n c\195\180ng Haunted Crew Member",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.HCM = I;
		end,
	});
	Event:AddToggle({
		Name = "T\225\186\165n c\195\180ng Fish Boat",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.FishBoat = I;
		end,
	});
end;
_G.SelectedSkills = {
		Melee = { Z = true, X = true, C = true },
		Sword = { Z = true, X = true },
		["Blox Fruit"] = {
			Z = true,
			X = true,
			C = true,
			V = true,
			F = true,
		},
		Gun = { Z = true, X = true },
	};
local function ExecuteSkills(category)
	if _G.SelectedSkills[category] then
		weaponSc(category);
		task.wait(.2);
		local keys = {
				"Z",
				"X",
				"C",
				"V",
				"F",
			};
		for _, skill in ipairs(keys) do
			if _G.SelectedSkills[category][skill] then
				Useskills(category, skill);
				task.wait(.35);
			end;
		end;
	end;
end;
task.spawn(function()
	while task.wait() do
		pcall(function()
			local seaEnemies = {
					{
						Flag = _G.Shark,
						Name = "Shark",
						Check = CheckShark,
						KillType = "Normal",
					},
					{
						Flag = _G.TerrorShark,
						Name = "Terrorshark",
						Check = CheckTerrorShark,
						KillType = "Sea",
					},
					{
						Flag = _G.Piranha,
						Name = "Piranha",
						Check = CheckPiranha,
						KillType = "Normal",
					},
					{
						Flag = _G.MobCrew,
						Name = "Fish Crew Member",
						Check = CheckFishCrew,
						KillType = "Normal",
					},
					{
						Flag = _G.HCM,
						Name = "Haunted Crew Member",
						Check = CheckHauntedCrew,
						KillType = "Normal",
					},
				};
			for _, enemyData in ipairs(seaEnemies) do
				if enemyData.Flag and enemyData.Check() then
					for _, K in pairs(workspace.Enemies:GetChildren()) do
						if K.Name == enemyData.Name and G.Alive(K) then
							repeat
								task.wait();
								if enemyData.KillType == "Sea" then
									G.KillSea(K, enemyData.Flag);
								else
									G.Kill(K, enemyData.Flag);
								end;
							until not enemyData.Flag or not K.Parent or K.Humanoid.Health <= 0;
						end;
					end;
				end;
			end;
			if _G.SeaBeast1 and workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
				for _, e in pairs(workspace.SeaBeasts:GetChildren()) do
					if e:FindFirstChild("HumanoidRootPart") and (e:FindFirstChild("Health") and e.Health.Value > 0) then
						repeat
							task.wait();
							task.spawn(function()
								_tp(CFrame.new(e.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, e.HumanoidRootPart.Position.Z));
							end);
							if plr:DistanceFromCharacter(e.HumanoidRootPart.CFrame.Position) <= 500 then
								MousePos = e.HumanoidRootPart.Position;
								if CheckF() then
									ExecuteSkills("Blox Fruit");
								else
									ExecuteSkills("Melee");
									ExecuteSkills("Sword");
									ExecuteSkills("Blox Fruit");
									ExecuteSkills("Gun");
								end;
							end;
						until not _G.SeaBeast1 or not e.Parent or e.Health.Value <= 0;
					end;
				end;
			end;
			if _G.Leviathan1 and workspace.SeaBeasts:FindFirstChild("Leviathan") then
				for _, e in pairs(workspace.SeaBeasts:GetChildren()) do
					local segment = e:FindFirstChild("Leviathan Segment");
					if e:FindFirstChild("HumanoidRootPart") and (segment and (e:FindFirstChild("Health") and e.Health.Value > 0)) then
						repeat
							task.wait();
							task.spawn(function()
								_tp(CFrame.new(e.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, e.HumanoidRootPart.Position.Z));
							end);
							if plr:DistanceFromCharacter(e.HumanoidRootPart.CFrame.Position) <= 500 then
								MousePos = segment.Position;
								if CheckF() then
									ExecuteSkills("Blox Fruit");
								else
									ExecuteSkills("Melee");
									ExecuteSkills("Sword");
									ExecuteSkills("Blox Fruit");
									ExecuteSkills("Gun");
								end;
							end;
						until not _G.Leviathan1 or not e.Parent or e.Health.Value <= 0;
					end;
				end;
			end;
			local boatConfigs = { {
						Flag = _G.FishBoat,
						Check = CheckEnemiesBoat,
						Name = "FishBoat",
						Dist = 150,
						Offset = CFrame.new(0, -50, -25),
					}, {
						Flag = _G.PGB,
						Check = CheckPirateGrandBrigade,
						Name = "PirateBrigade",
						Dist = 150,
						Offset = CFrame.new(0, -30, -10),
					}, {
						Flag = _G.PGB,
						Check = CheckPirateGrandBrigade,
						Name = "PirateGrandBrigade",
						Dist = 150,
						Offset = CFrame.new(0, -50, -50),
					} };
			for _, boat in ipairs(boatConfigs) do
				if boat.Flag and boat.Check() then
					for _, e in pairs(workspace.Enemies:GetChildren()) do
						if e.Name == boat.Name and (e:FindFirstChild("VehicleSeat") and e.Health.Value > 0) then
							repeat
								task.wait();
								task.spawn(function()
									_tp(e.Engine.CFrame * boat.Offset);
								end);
								if plr:DistanceFromCharacter(e.Engine.CFrame.Position) <= boat.Dist then
									MousePos = e.Engine.Position;
									if CheckF() then
										ExecuteSkills("Blox Fruit");
									else
										ExecuteSkills("Melee");
										ExecuteSkills("Sword");
										ExecuteSkills("Blox Fruit");
										ExecuteSkills("Gun");
									end;
								end;
							until not boat.Flag or not e:FindFirstChild("VehicleSeat") or e.Health.Value <= 0;
						end;
					end;
				end;
			end;
		end);
	end;
end);
if game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
	Event:AddSection({ "Leviathan" });
	Event:AddButton({ Name = "Mua chu\225\187\153c gi\195\161n \196\145i\225\187\135p", Description = "Mua spy \196\145\225\187\131 t\195\172m levi", Callback = function()
			replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "2");
		end });
	Event:AddToggle({
		Name = "Di chuy\225\187\131n \196\145\225\186\191n Frozen Dimension",
		Description = "",
		Default = GetSetting("FrozenTP_Save", false),
		Callback = function(I)
			_G.FrozenTP = I;
			_G.SaveData.FrozenTP_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(.1) do
			if _G.FrozenTP then
				pcall(function()
					if workspace.Map:FindFirstChild("LeviathanGate") then
						_tp(workspace.Map.LeviathanGate.CFrame);
						replicated.Remotes.CommF_:InvokeServer("OpenLeviathanGate");
					end;
				end);
			end;
		end;
	end);
	Event:AddToggle({
		Name = "T\225\186\165n c\195\180ng Leviathan [ beta ]",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Leviathan1 = I;
		end,
	});
	Event:AddSection({ "\196\144\225\186\163o kitsune" });
	Event:AddToggle({
		Name = "Auto t\195\172m \196\145\225\186\163o c\195\161o",
		Description = "",
		Default = GetSetting("FindKitsune_Save", false),
		Callback = function(I)
			_G.AutofindKitIs = I;
			_G.SaveData.FindKitsune_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait() do
			if _G.AutofindKitIs then
				pcall(function()
					if not workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island", true) then
						local I = CheckBoat();
						if not I then
							local I = CFrame.new(-16927.451, 9.086, 433.864);
							TeleportToTarget(I);
							if (I.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
								replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat);
							end;
						else
							if plr.Character.Humanoid.Sit == false then
								local e = I.VehicleSeat.CFrame * CFrame.new(0, 1, 0);
								_tp(e);
							else
								local I = CFrame.new(-10000000, 31, 37016.25);
								repeat
									wait();
									if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
										_tp(CFrame.new(-10000000, 150, 37016.25));
									else
										_tp(CFrame.new(-10000000, 31, 37016.25));
									end;
								until not _G.AutofindKitIs or (I.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") or plr.Character.Humanoid.Sit == false;
								plr.Character.Humanoid.Sit = false;
							end;
						end;
					else
						_tp((workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")).CFrame * CFrame.new(0, 500, 0));
					end;
				end);
			end;
		end;
	end);
	Event:AddToggle({
		Name = "Di chuy\225\187\131n \196\145\225\186\191n \196\145\225\186\163o c\195\161o",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.tweenShrine = I;
		end,
	});
	spawn(function()
		while wait(.1) do
			if _G.tweenShrine then
				pcall(function()
					local I = workspace.Map:FindFirstChild("KitsuneIsland") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island");
					local e = I:FindFirstChild("ShrineActive");
					if e then
						for e, K in next, e:GetDescendants() do
							if K:IsA("BasePart") and K.Name:find("NeonShrinePart") then
								(replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue")):FireServer();
								repeat
									wait();
									_tp(K.CFrame * CFrame.new(0, 2, 0));
								until _G.tweenShrine == false or not I;
							end;
						end;
					else
						_tp((workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")).CFrame * CFrame.new(0, 500, 0));
					end;
				end);
			end;
		end;
	end);
	Event:AddToggle({
		Name = "T\225\187\177 \196\145\225\187\153ng nh\225\186\183t Azure Ember",
		Description = "",
		Default = GetSetting("CollectAzureEmber_Save", false),
		Callback = function(I)
			_G.Collect_Ember = I;
			_G.SaveData.CollectAzureEmber_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(.1) do
			if _G.Collect_Ember then
				pcall(function()
					if workspace:WaitForChild("AttachedAzureEmber") or workspace:WaitForChild("EmberTemplate") then
						notween(((workspace:WaitForChild("EmberTemplate")):FindFirstChild("Part")).CFrame);
					else
						_tp((workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")).CFrame * CFrame.new(0, 500, 0));
						replicated.Modules.Net["RF/KitsuneStatuePray"]:InvokeServer();
					end;
				end);
			end;
		end;
	end);
	Event:AddToggle({
		Name = "Auto Trao \196\145\225\187\149i Azure Ember",
		Description = "",
		Default = GetSetting("TradeAzureEmber_Save", false),
		Callback = function(I)
			_G.Trade_Ember = I;
			_G.SaveData.TradeAzureEmber_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(.1) do
			if _G.Trade_Ember then
				pcall(function()
					if workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island", true) then
						(replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray")):InvokeServer();
					end;
				end);
			end;
		end;
	end);
	Event:AddButton({ Name = "Trao \196\145\225\187\149i \196\145\225\187\147 \196\145\225\186\163o c\195\161o", Description = "", Callback = function()
			(replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray")):InvokeServer();
		end });
	Event:AddButton({ Name = "Tr\195\178 chuy\225\187\135n v\225\187\155i t\198\176\225\187\163ng c\195\161o", Description = "", Callback = function()
			(replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue")):FireServer();
		end });
	Event:AddSection({ "\196\144\225\186\163o k\195\172 b\195\173 " });
	Event:AddToggle({
		Name = "Auto t\195\172m \196\145\225\186\163o k\195\172 b\195\173",
		Description = "",
		Default = GetSetting("FindMirage_Save", false),
		Callback = function(I)
			_G.FindMirage = I;
			_G.SaveData.FindMirage_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait() do
			if _G.FindMirage then
				pcall(function()
					if not workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island", true) then
						local I = CheckBoat();
						if not I then
							local I = CFrame.new(-16927.451, 9.086, 433.864);
							TeleportToTarget(I);
							if (I.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
								replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat);
							end;
						else
							if plr.Character.Humanoid.Sit == false then
								local e = I.VehicleSeat.CFrame * CFrame.new(0, 1, 0);
								_tp(e);
							else
								repeat
									wait();
									local I = CFrame.new(-10000000, 31, 37016.25);
									if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
										_tp(CFrame.new(-10000000, 150, 37016.25));
									else
										_tp(CFrame.new(-10000000, 31, 37016.25));
									end;
								until not _G.FindMirage or (I.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") or plr.Character.Humanoid.Sit == false;
								plr.Character.Humanoid.Sit = false;
							end;
						end;
					else
						_tp(workspace.Map.MysticIsland.Center.CFrame * CFrame.new(0, 300, 0));
					end;
				end);
			end;
		end;
	end);
	Event:AddToggle({
		Name = "T\225\187\177 \196\145\225\187\153ng bay \196\145\225\186\191n \196\145i\225\187\131m cao nh\225\186\165t",
		Description = "Bay \196\145\225\186\191n \196\145i\225\187\131m cao nh\225\186\165t c\225\187\167a Mirage (L\195\189 t\198\176\225\187\159ng \196\145\225\187\131 ng\225\186\175m tr\196\131ng)",
		Default = GetSetting("HighestMirage_Save", false),
		Callback = function(I)
			_G.HighestMirage = I;
			_G.SaveData.HighestMirage_Save = I;
			SaveSettings();
		end,
	});
	task.spawn(function()
		while task.wait(1) do
			if _G.HighestMirage then
				pcall(function()
					if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island", true) then
						if _tp then
							_tp(workspace.Map.MysticIsland.Center.CFrame * CFrame.new(0, 400, 0));
						end;
					end;
				end);
			end;
		end;
	end);
	Event:AddToggle({
		Name = "Auto Nh\225\186\183t b\195\161nh r\196\131ng",
		Description = "Nh\225\186\183t gear blue",
		Default = GetSetting("AutoCollectGear_Save", false),
		Callback = function(I)
			_G.TPGEAR = I;
			_G.SaveData.AutoCollectGear_Save = I;
			SaveSettings();
		end,
	});
	task.spawn(function()
		while task.wait(.1) do
			if _G.TPGEAR then
				pcall(function()
					local mystic = workspace.Map:FindFirstChild("MysticIsland");
					if mystic then
						for _, e in pairs(mystic:GetChildren()) do
							if e.Name == "Part" and e:IsA("MeshPart") then
								if _tp then
									_tp(e.CFrame);
								end;
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - e.Position).Magnitude < 20 then
									fireproximityprompt(e:FindFirstChildOfClass("ProximityPrompt"), 30);
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	Event:AddToggle({
		Name = "Xo\195\161 s\198\176\198\161ng m\195\185 \196\145\225\186\163o k\195\172 b\195\173",
		Description = "",
		Default = GetSetting("MirageTransparency_Save", false),
		Callback = function(I)
			_G.can = I;
			_G.SaveData.MirageTransparency_Save = I;
			SaveSettings();
			if not I then
				pcall(function()
					local mystic = workspace.Map:FindFirstChild("MysticIsland");
					if mystic then
						for _, e in pairs(mystic:GetChildren()) do
							if e:IsA("BasePart") then
								e.Transparency = 0;
							end;
						end;
					end;
				end);
			end;
		end,
	});
	task.spawn(function()
		while task.wait(1) do
			if _G.can then
				pcall(function()
					local mystic = workspace.Map:FindFirstChild("MysticIsland");
					if mystic then
						for _, e in pairs(mystic:GetChildren()) do
							if e.Name == "Part" then
								if e:IsA("MeshPart") then
									e.Transparency = 0;
								else
									e.Transparency = 1;
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	Event:AddToggle({
		Name = "Bay \196\144\225\186\191n Advanced Fruit Dealer",
		Description = "Bay \196\145\225\186\191n gian h\195\160ng tr\195\161i c\195\162y cao c\225\186\165p tr\195\170n Mirage.",
		Default = GetSetting("AutoTweenAdvancedDealer_Save", false),
		Callback = function(I)
			_G.Addealer = I;
			_G.SaveData.AutoTweenAdvancedDealer_Save = I;
			SaveSettings();
		end,
	});
	task.spawn(function()
		while task.wait(1) do
			if _G.Addealer then
				pcall(function()
					local npcs = (game:GetService("ReplicatedStorage")):FindFirstChild("NPCs");
					if npcs then
						for _, e in pairs(npcs:GetChildren()) do
							if e.Name == "Advanced Fruit Dealer" and e:FindFirstChild("HumanoidRootPart") then
								if _tp then
									_tp(e.HumanoidRootPart.CFrame);
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	Event:AddToggle({
		Name = "Auto nh\225\186\183t r\198\176\198\161ng \225\187\159 \196\145\225\186\163o k\195\172 b\195\173",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.FarmChestM = I;
		end,
	});
	spawn(function()
		while wait(.2) do
			if _G.FarmChestM then
				pcall(function()
					if workspace.Map.MysticIsland.Chests:FindFirstChild("DiamondChest") or workspace.Map.MysticIsland.Chests:FindFirstChild("FragChest") then
						local I = game:GetService("CollectionService");
						local e = game:GetService("Players");
						local K = e.LocalPlayer;
						local n = K.Character or K.CharacterAdded:Wait();
						if not n then
							return;
						end;
						local d = (n:GetPivot()).Position;
						local z = I:GetTagged("_ChestTagged");
						local H, F = math.huge, nil;
						for I = 1, #z, 1 do
							local e = z[I];
							local K = ((e:GetPivot()).Position - d).Magnitude;
							if not SelectedIsland or e:IsDescendantOf(SelectedIsland) then
								if not e:GetAttribute("IsDisabled") and K < H then
									H = K;
									F = e;
								end;
							end;
						end;
						if F then
							_tp(F:GetPivot());
						end;
					end;
				end);
			end;
		end;
	end);
	Event:AddSection({ "Nam ch\195\162m n\195\186i l\225\187\173a" });
	Event:AddToggle({
		Name = "Auto Ch\225\186\191 T\225\186\161o Nam Ch\195\162m N\195\186i L\225\187\173a",
		Description = "B\225\186\173t ch\225\186\191 \196\145\225\187\153 t\225\187\177 \196\145\225\187\153ng thu th\225\186\173p nguy\195\170n li\225\187\135u v\195\160 ch\225\186\191 t\225\186\161o nam ch\195\162m n\195\186i l\225\187\173a, v\195\160 d\225\187\171ng l\225\186\161i khi b\225\186\161n \196\145\195\163 c\195\179 1 nam ch\195\162m n\195\186i l\225\187\173a.",
		Default = false,
		Callback = function(I)
			_G.CraftVM = I;
		end,
	});
	Event:AddButton({ Name = "Ch\225\186\191 T\225\186\161o Nam Ch\195\162m N\195\186i L\225\187\173a", Description = "", Callback = function()
			replicated.Remotes.CommF_:FireServer("Notify", "<Color=Yellow>Crafted <Volcanic Magnet><Color=/>");
		end });
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.CraftVM then
					if GetM("Volcanic Magnet") < 1 then
						if GetM("Scrap Metal") >= 10 and GetM("Blaze Ember") >= 15 then
							replicated.Remotes.CommF_:FireServer("Notify", "<Color=Yellow>Crafted <Volcanic Magnet><Color=/>");
						elseif GetM("Scrap Metal") < 10 then
							local I = GetConnectionEnemies("Forest Pirate");
							if I then
								repeat
									wait();
									G.Kill(I, _G.CraftVM);
								until not _G.CraftVM or not I.Parent or I.Humanoid.Health <= 0 or GetM("Scrap Metal") >= 10;
							else
								_tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375));
							end;
						elseif GetM("Blaze Ember") < 15 then
							local startTime = tick();
							repeat
								replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5643.4526367188, 1013.0858154297, -340.51025390625));
								wait(.1);
							until tick() - startTime >= 1 or not _G.CraftVM;
							repeat
								wait();
								_G.FarmBlazeEM = true;
							until not _G.CraftVM or GetM("Blaze Ember") >= 15;
							_G.FarmBlazeEM = false;
						end;
					end;
				end;
			end);
		end;
	end);
	Event:AddSection({ "\196\144\225\186\163o n\195\186i l\225\187\173a" });
	Event:AddToggle({
		Name = "Auto T\195\172m \196\144\225\186\163o n\195\186i l\225\187\173a",
		Description = "",
		Default = GetSetting("PrehistoricFinder_Save", false),
		Callback = function(I)
			_G.Prehis_Find = I;
			_G.SaveData.PrehistoricFinder_Save = I;
			SaveSettings();
		end,
	});
	task.spawn(function()
		while task.wait() do
			if _G.Prehis_Find then
				pcall(function()
					if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true) then
						local I = CheckBoat();
						if I and (I:FindFirstChild("VehicleSeat") and (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart"))) then
							local dist = (plr.Character.HumanoidRootPart.Position - I.VehicleSeat.Position).Magnitude;
							if dist > 2500 then
								I = nil;
							end;
						end;
						if not I then
							local DealerPos = CFrame.new(-16927.451, 9.086, 433.864);
							TeleportToTarget(DealerPos);
							if (DealerPos.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
								replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat);
							end;
						else
							if plr.Character.Humanoid.Sit == false then
								local seatCF = I.VehicleSeat.CFrame * CFrame.new(0, 1, 0);
								_tp(seatCF);
							else
								local TargetPos = CFrame.new(-10000000, 31, 37016.25);
								if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
									_tp(CFrame.new(-10000000, 150, 37016.25));
								else
									_tp(TargetPos);
								end;
								if workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") or not _G.Prehis_Find then
									plr.Character.Humanoid.Sit = false;
								end;
							end;
						end;
					else
						local Island = workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island");
						if (Island.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 then
							_tp(Island.CFrame);
						end;
						if workspace.Map:FindFirstChild("PrehistoricIsland", true) or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true) then
							local promptPart = workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt");
							if promptPart and promptPart:FindFirstChild("ProximityPrompt") then
								if plr:DistanceFromCharacter(promptPart.Position) <= 150 then
									fireproximityprompt(promptPart.ProximityPrompt, math.huge);
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
									task.wait(1.5);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "E", false, game);
								end;
								_tp(promptPart.CFrame);
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	Event:AddToggle({
		Name = "Auto S\225\187\177 Ki\225\187\135n \196\144\225\186\163o N\195\186i L\225\187\173a",
		Description = "",
		Default = GetSetting("AutoEventPrehistoric_Save", false),
		Callback = function(I)
			_G.PrehistoricEvent = I;
			_G.Prehis_Skills = I;
			_G.SaveData.AutoEventPrehistoric_Save = I;
			SaveSettings();
			if I then
				local RunService = game:GetService("RunService");
				task.spawn(function()
					while _G.Prehis_Skills do
						local char = game.Players.LocalPlayer.Character;
						if char then
							for _, v in pairs(char:GetChildren()) do
								if v:IsA("BasePart") and v.CanCollide then
									v.CanCollide = false;
								end;
							end;
						end;
						RunService.Stepped:Wait();
					end;
				end);
			end;
		end,
	});
	spawn(function()
		while task.wait(1.5) do
			if _G.Prehis_Skills then
				pcall(function()
					local MapIsland = game.Workspace.Map:FindFirstChild("PrehistoricIsland");
					if MapIsland then
						local core = MapIsland:FindFirstChild("Core");
						if core and core:FindFirstChild("InteriorLava") then
							core.InteriorLava:Destroy();
						end;
						for _, obj in pairs(MapIsland:GetDescendants()) do
							if obj:IsA("Part") or obj:IsA("MeshPart") then
								if obj.Name == "Lava" or obj.Name == "LavaPart" or (obj.Name:lower()):find("magma") then
									obj:Destroy();
								end;
							end;
							if obj.Name == "TouchInterest" and obj.Parent then
								if not obj.Parent.Name:find("TrialTeleport") then
									obj.Parent:Destroy();
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	spawn(function()
		while task.wait() do
			if _G.Prehis_Skills then
				pcall(function()
					local plr = game.Players.LocalPlayer;
					if workspace.Enemies:FindFirstChild("Lava Golem") then
						local enemy = nil;
						pcall(function()
							if GetConnectionEnemies then
								enemy = GetConnectionEnemies("Lava Golem");
							else
								enemy = workspace.Enemies["Lava Golem"];
							end;
						end);
						if enemy and (enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0) then
							repeat
								task.wait();
								if enemy:FindFirstChild("HumanoidRootPart") and (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")) then
									_tp(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
									plr.Character.HumanoidRootPart.Velocity = Vector3.zero;
								end;
								if G and G.Kill then
									G.Kill(enemy, _G.Prehis_Skills);
								end;
							until not _G.Prehis_Skills or not enemy.Parent or enemy.Humanoid.Health <= 0;
						end;
					end;
					local core = game.Workspace.Map:FindFirstChild("PrehistoricIsland") and game.Workspace.Map.PrehistoricIsland:FindFirstChild("Core");
					if core and core:FindFirstChild("VolcanoRocks") then
						for _, rock in pairs(core.VolcanoRocks:GetChildren()) do
							if rock:FindFirstChild("VFXLayer") then
								local layer = rock.VFXLayer;
								if layer:FindFirstChild("At0") and (layer.At0:FindFirstChild("Glow") and layer.At0.Glow.Enabled == true) then
									repeat
										task.wait();
										if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
											local safePosition = (layer.CFrame * CFrame.new(0, 30, 0)) * CFrame.Angles(math.rad(-90), 0, 0);
											_tp(safePosition);
											plr.Character.HumanoidRootPart.Velocity = Vector3.zero;
										end;
										if plr:DistanceFromCharacter(layer.CFrame.Position) <= 200 then
											MousePos = layer.CFrame.Position;
											local VIM = game:GetService("VirtualInputManager");
											VIM:SendKeyEvent(true, "Z", false, game);
											VIM:SendKeyEvent(true, "X", false, game);
											VIM:SendKeyEvent(true, "C", false, game);
											if Useskills then
												Useskills("Melee", "Z");
												Useskills("Melee", "X");
												Useskills("Melee", "C");
												Useskills("Blox Fruit", "Z");
												Useskills("Blox Fruit", "X");
												Useskills("Blox Fruit", "C");
											end;
										end;
									until not _G.Prehis_Skills or layer.At0.Glow.Enabled == false or not rock.Parent;
								end;
							end;
						end;
					end;
				end);
			else
				task.wait(1);
			end;
		end;
	end);
	Event:AddButton({ Name = "Xo\195\161 Lava", Description = "", Callback = function()
			for _, v in pairs(game.Workspace:GetDescendants()) do
				if v.Name == "Lava" then
					v:Destroy();
				end;
			end;
			for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
				if v.Name == "Lava" then
					v:Destroy();
				end;
			end;
		end });
	Event:AddToggle({
		Name = "Auto Nh\225\186\183t X\198\176\198\161ng",
		Description = "",
		Default = GetSetting("DinoBones_Save", false),
		Callback = function(I)
			_G.Prehis_DB = I;
			_G.SaveData.DinoBones_Save = I;
			SaveSettings();
		end,
	});
	Event:AddToggle({
		Name = "Auto Nh\225\186\183t Tr\225\187\169ng",
		Description = "",
		Default = GetSetting("DragonEggs_Save", false),
		Callback = function(I)
			_G.Prehis_DE = I;
			_G.SaveData.DragonEggs_Save = I;
			SaveSettings();
		end,
	});
	Event:AddToggle({
		Name = "Auto Reset Khi Ho\195\160n Th\195\160nh",
		Description = "",
		Default = GetSetting("ResetVolcano_Save", false),
		Callback = function(I)
			_G.ResetPH = I;
			_G.SaveData.ResetVolcano_Save = I;
			SaveSettings();
		end,
	});
	task.spawn(function()
		while task.wait() do
			pcall(function()
				local FoundTarget = false;
				if _G.Prehis_DE then
					local MapIsland = workspace.Map:FindFirstChild("PrehistoricIsland");
					if MapIsland and MapIsland.Core:FindFirstChild("SpawnedDragonEggs") then
						local Egg = MapIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg");
						if Egg and Egg:FindFirstChild("Molten") then
							FoundTarget = true;
							_G.Collecting = true;
							_tp(Egg.Molten.CFrame);
							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Egg.Molten.Position).Magnitude <= 15 then
								fireproximityprompt(Egg.Molten.ProximityPrompt, 30);
							end;
						end;
					end;
				end;
				if _G.Prehis_DB and not FoundTarget then
					local Bone = workspace:FindFirstChild("DinoBone");
					if Bone then
						FoundTarget = true;
						_G.Collecting = true;
						_tp(Bone.CFrame);
					end;
				end;
				if not FoundTarget then
					_G.Collecting = false;
				end;
			end);
		end;
	end);
	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				if _G.ResetPH then
					local MapIsland = workspace.Map:FindFirstChild("PrehistoricIsland");
					local EventEnded = MapIsland and (MapIsland:FindFirstChild("TrialTeleport") and MapIsland.TrialTeleport:FindFirstChild("TouchInterest"));
					if EventEnded then
						task.wait(4.5);
						while true do
							local ShouldWait = false;
							if _G.Prehis_DE and MapIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg") then
								ShouldWait = true;
							end;
							if _G.Prehis_DB and workspace:FindFirstChild("DinoBone") then
								ShouldWait = true;
							end;
							if _G.Collecting then
								ShouldWait = true;
							end;
							if ShouldWait then
								task.wait(.5);
							else
								break;
							end;
						end;
						game.Players.LocalPlayer.Character.Humanoid.Health = 0;
						task.wait(8);
					end;
				end;
			end);
		end;
	end);
end;
if World2 or World3 then
	Event:AddSection({ "C\195\160i \196\144\225\186\183t Skill - V\195\181" });
	Event:AddToggle({ Name = "Skill Z", Default = GetSetting("Skill_Melee_Z", true), Callback = function(I)
			_G.SelectedSkills.Melee.Z = I;
			_G.SaveData.Skill_Melee_Z = I;
			SaveSettings();
		end });
	Event:AddToggle({ Name = "Skill X", Default = GetSetting("Skill_Melee_X", true), Callback = function(I)
			_G.SelectedSkills.Melee.X = I;
			_G.SaveData.Skill_Melee_X = I;
			SaveSettings();
		end });
	Event:AddToggle({ Name = "Skill C", Default = GetSetting("Skill_Melee_C", true), Callback = function(I)
			_G.SelectedSkills.Melee.C = I;
			_G.SaveData.Skill_Melee_C = I;
			SaveSettings();
		end });
	Event:AddSection({ "Skill Ki\225\186\191m" });
	Event:AddToggle({ Name = "Skill Z", Default = GetSetting("Skill_Sword_Z", true), Callback = function(I)
			_G.SelectedSkills.Sword.Z = I;
			_G.SaveData.Skill_Sword_Z = I;
			SaveSettings();
		end });
	Event:AddToggle({ Name = "Skill X", Default = GetSetting("Skill_Sword_X", true), Callback = function(I)
			_G.SelectedSkills.Sword.X = I;
			_G.SaveData.Skill_Sword_X = I;
			SaveSettings();
		end });
	Event:AddSection({ "Skill S\195\186ng" });
	Event:AddToggle({ Name = "Skill Z", Default = GetSetting("Skill_Gun_Z", true), Callback = function(I)
			_G.SelectedSkills.Gun.Z = I;
			_G.SaveData.Skill_Gun_Z = I;
			SaveSettings();
		end });
	Event:AddToggle({ Name = "Skill X", Default = GetSetting("Skill_Gun_X", true), Callback = function(I)
			_G.SelectedSkills.Gun.X = I;
			_G.SaveData.Skill_Gun_X = I;
			SaveSettings();
		end });
	Event:AddSection({ "Skill Tr\195\161i Blox" });
	Event:AddToggle({ Name = "Skill Z", Default = GetSetting("Skill_Fruit_Z", true), Callback = function(I)
			_G.SelectedSkills["Blox Fruit"].Z = I;
			_G.SaveData.Skill_Fruit_Z = I;
			SaveSettings();
		end });
	Event:AddToggle({ Name = "Skill X", Default = GetSetting("Skill_Fruit_X", true), Callback = function(I)
			_G.SelectedSkills["Blox Fruit"].X = I;
			_G.SaveData.Skill_Fruit_X = I;
			SaveSettings();
		end });
	Event:AddToggle({ Name = "Skill C", Default = GetSetting("Skill_Fruit_C", true), Callback = function(I)
			_G.SelectedSkills["Blox Fruit"].C = I;
			_G.SaveData.Skill_Fruit_C = I;
			SaveSettings();
		end });
	Event:AddToggle({ Name = "Skill V", Default = GetSetting("Skill_Fruit_V", true), Callback = function(I)
			_G.SelectedSkills["Blox Fruit"].V = I;
			_G.SaveData.Skill_Fruit_V = I;
			SaveSettings();
		end });
	Event:AddToggle({ Name = "Skill F", Default = GetSetting("Skill_Fruit_F", true), Callback = function(I)
			_G.SelectedSkills["Blox Fruit"].F = I;
			_G.SaveData.Skill_Fruit_F = I;
			SaveSettings();
		end });
end;
Maestry:AddSection({ "Th\195\180ng Th\225\186\161o" });
local islands = { "Cake", "Bone" };
Maestry:AddDropdown({
	Title = "Ch\225\187\141n \196\144\225\186\163o",
	Description = "",
	Options = islands,
	Default = "Cake",
	Callback = function(I)
		SelectIsland = I;
	end,
});
local function GetNearestMobFromList(list)
	local plr = game.Players.LocalPlayer;
	local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
	if not root then
		return nil;
	end;
	local nearest, dist = nil, math.huge;
	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		if table.find(list, mob.Name) and (mob:FindFirstChild("HumanoidRootPart") and (mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0)) then
			local d = (mob.HumanoidRootPart.Position - root.Position).Magnitude;
			if d < dist then
				dist = d;
				nearest = mob;
			end;
		end;
	end;
	return nearest;
end;
local function HasAliveMob(list)
	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		if table.find(list, mob.Name) and (mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0) then
			return true;
		end;
	end;
	return false;
end;
Maestry:AddToggle({
	Name = "Auto C\195\160y Th\195\180ng Th\225\186\161o Tr\195\161i Blox",
	Description = "",
	Default = GetSetting("FarmMastery_Dev", false),
	Callback = function(I)
		_G.FarmMastery_Dev = I;
		_G.SaveData.FarmMastery_Dev = I;
		SaveSettings();
	end,
});
spawn(function()
	RunSer.RenderStepped:Connect(function()
		if _G.FarmMastery_Dev then
			pcall(function()
				for _, e in pairs(plr.PlayerGui.Notifications:GetChildren()) do
					if e.Name == "NotificationTemplate" and string.find(e.Text, "Skill locked!") then
						e:Destroy();
					end;
				end;
			end);
		end;
	end);
end);
spawn(function()
	while task.wait(Sec) do
		if _G.FarmMastery_Dev then
			pcall(function()
				local list = SelectIsland == "Cake" and X or P;
				local mob = GetNearestMobFromList(list);
				if mob then
					HealthM = mob.Humanoid.MaxHealth * .7;
					repeat
						task.wait();
						if not mob.Parent or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 or not mob:FindFirstChild("HumanoidRootPart") then
							mob = GetNearestMobFromList(list);
							if not mob then
								break;
							end;
						end;
						MousePos = mob.HumanoidRootPart.Position;
						G.Mas(mob, _G.FarmMastery_Dev);
						if not HasAliveMob(list) then
							break;
						end;
					until not _G.FarmMastery_Dev;
				else
					if SelectIsland == "Cake" then
						_tp(CFrame.new(-1943.6765, 251.5095, -12337.8808));
					else
						_tp(CFrame.new(-9495.6806, 453.5862, 5977.3486));
					end;
				end;
			end);
		end;
	end;
end);
Maestry:AddToggle({
	Name = "Auto C\195\160y Th\195\180ng Th\225\186\161o S\195\186ng",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.FarmMastery_G = I;
	end,
});
spawn(function()
	while task.wait(Sec) do
		if _G.FarmMastery_G then
			pcall(function()
				local list = SelectIsland == "Cake" and X or P;
				local mob = GetNearestMobFromList(list);
				if mob then
					HealthM = mob.Humanoid.MaxHealth * .7;
					repeat
						task.wait();
						if not mob.Parent or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 or not mob:FindFirstChild("HumanoidRootPart") then
							mob = GetNearestMobFromList(list);
							if not mob then
								break;
							end;
						end;
						MousePos = mob.HumanoidRootPart.Position;
						G.Masgun(mob, _G.FarmMastery_G);
						local modules = replicated:FindFirstChild("Modules");
						local K = modules:FindFirstChild("Net");
						local shoot = K:FindFirstChild("RE/ShootGunEvent");
						local tool = plr.Character:FindFirstChildOfClass("Tool");
						if tool and tool.Name == "Skull Guitar" then
							SoulGuitar = true;
							tool.RemoteEvent:FireServer("TAP", MousePos);
						elseif tool then
							SoulGuitar = false;
							shoot:FireServer(MousePos, { mob.HumanoidRootPart });
						end;
						if not HasAliveMob(list) then
							break;
						end;
					until not _G.FarmMastery_G;
					SoulGuitar = false;
				else
					if SelectIsland == "Cake" then
						_tp(CFrame.new(-1943.6765, 251.5095, -12337.8808));
					else
						_tp(CFrame.new(-9495.6806, 453.5862, 5977.3486));
					end;
				end;
			end);
		end;
	end;
end);
Maestry:AddToggle({ Name = "Fruit Skill Z", Default = false, Callback = function(v)
		_G.FruitSkills.Z = v;
	end });
Maestry:AddToggle({ Name = "Fruit Skill X", Default = false, Callback = function(v)
		_G.FruitSkills.X = v;
	end });
Maestry:AddToggle({ Name = "Fruit Skill C", Default = false, Callback = function(v)
		_G.FruitSkills.C = v;
	end });
Maestry:AddToggle({ Name = "Fruit Skill V", Default = false, Callback = function(v)
		_G.FruitSkills.V = v;
	end });
Maestry:AddToggle({ Name = "Fruit Skill F", Default = false, Callback = function(v)
		_G.FruitSkills.F = v;
	end });
if World2 then
	Race:AddSection({ "N\195\162ng C\225\186\165p T\225\187\153c" });
	Race:AddToggle({
		Name = "Auto N\195\162ng T\225\187\153c Th\225\187\143 v2/3",
		Description = "",
		Default = false,
		Callback = function(I)
			G.Auto_Mink = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if G.Auto_Mink then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= 2 then
						if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "2");
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
							if not plr.Backpack:FindFirstChild("Flower 1") and not plr.Character:FindFirstChild("Flower 1") then
								tp(workspace.Flower1.CFrame);
							elseif not plr.Backpack:FindFirstChild("Flower 2") and not plr.Character:FindFirstChild("Flower 2") then
								tp(workspace.Flower2.CFrame);
							elseif not plr.Backpack:FindFirstChild("Flower 3") and not plr.Character:FindFirstChild("Flower 3") then
								local I = GetConnectionEnemies("Swan Pirate");
								if I then
									repeat
										wait();
										G.Kill(I, G.Auto_Mink);
									until GetBP("Flower 3") or not I.Parent or I.Humanoid.Health <= 0 or G.Auto_Mink == false;
								else
									tp(CFrame.new(980, 121, 1287));
								end;
							end;
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "3");
						end;
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2");
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
						G.AutoFarmChest = true;
					else
						G.AutoFarmChest = false;
					end;
				end;
			end);
		end;
	end);
	Race:AddToggle({
		Name = "Auto N\195\162ng T\225\187\153c Ng\198\176\225\187\157i V2/V3",
		Description = "",
		Default = false,
		Callback = function(I)
			G.Auto_Human = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if G.Auto_Human then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then
						if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "2");
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
							if not plr.Backpack:FindFirstChild("Flower 1") and not plr.Character:FindFirstChild("Flower 1") then
								tp(workspace.Flower1.CFrame);
							elseif not plr.Backpack:FindFirstChild("Flower 2") and not plr.Character:FindFirstChild("Flower 2") then
								tp(workspace.Flower2.CFrame);
							elseif not plr.Backpack:FindFirstChild("Flower 3") and not plr.Character:FindFirstChild("Flower 3") then
								local I = GetConnectionEnemies("Swan Pirate");
								if I then
									repeat
										wait();
										G.Kill(I, G.Auto_Human);
									until plr.Backpack:FindFirstChild("Flower 3") or not I.Parent or I.Humanoid.Health <= 0 or G.Auto_Human == false;
								else
									tp(CFrame.new(980, 121, 1287));
								end;
							end;
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "3");
						end;
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2");
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
						local I = GetConnectionEnemies(F[1]);
						if I then
							repeat
								wait();
								G.Kill(I, _G.Auto_Human);
							until I.Humanoid.Health <= 0 or not I.Parent or not _G.Auto_Human;
						else
							_tp(CFrame.new(-2172, 103, -4015));
						end;
						local e = GetConnectionEnemies(F[2]);
						if e then
							repeat
								wait();
								G.Kill(e, _G.Auto_Human);
							until e.Humanoid.Health <= 0 or not e.Parent or not _G.Auto_Human;
						else
							_tp(CFrame.new(2006, 448, 853));
						end;
						local K = GetConnectionEnemies(F[3]);
						if K then
							repeat
								wait();
								G.Kill(K, _G.Auto_Human);
							until K.Humanoid.Health <= 0 or not K.Parent or not G.Auto_Human;
						else
							tp(CFrame.new(-1576, 198, 13));
						end;
					end;
				end;
			end);
		end;
	end);
	Race:AddToggle({
		Name = "Auto N\195\162ng T\225\187\153c Thi\195\170n Th\225\186\167n V2/V3",
		Description = "",
		Default = false,
		Callback = function(I)
			G.Auto_Skypiea = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if G.Auto_Skypiea then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then
						if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "2");
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
							if not plr.Backpack:FindFirstChild("Flower 1") and not plr.Character:FindFirstChild("Flower 1") then
								tp(workspace.Flower1.CFrame);
							elseif not plr.Backpack:FindFirstChild("Flower 2") and not plr.Character:FindFirstChild("Flower 2") then
								tp(workspace.Flower2.CFrame);
							elseif not plr.Backpack:FindFirstChild("Flower 3") and not plr.Character:FindFirstChild("Flower 3") then
								local I = GetConnectionEnemies("Swan Pirate");
								if I then
									repeat
										task.wait();
										G.Kill(I, G.Auto_Skypiea);
									until plr.Backpack:FindFirstChild("Flower 3") or not I.Parent or I.Humanoid.Health <= 0 or G.Auto_Skypiea == false;
								else
									tp(CFrame.new(980, 121, 1287));
								end;
							end;
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "3");
						end;
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2");
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
						for I, e in pairs(game.Players:GetChildren()) do
							if e.Name ~= plr.Name and tostring(e.Data.Race.Value) == "Skypiea" then
								repeat
									task.wait();
									tp((e.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)) * CFrame.Angles(math.rad(-45), 0, 0));
								until e.Humanoid.Health <= 0 or G.Auto_Skypiea == false;
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	Race:AddToggle({
		Name = "Auto N\195\162ng T\225\187\153c C\195\161 V2/V3",
		Description = "",
		Default = false,
		Callback = function(I)
			G.Auto_Fish = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if G.Auto_Fish then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then
						if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "2");
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
							if not plr.Backpack:FindFirstChild("Flower 1") and not plr.Character:FindFirstChild("Flower 1") then
								tp(workspace.Flower1.CFrame);
							elseif not plr.Backpack:FindFirstChild("Flower 2") and not plr.Character:FindFirstChild("Flower 2") then
								tp(workspace.Flower2.CFrame);
							elseif not plr.Backpack:FindFirstChild("Flower 3") and not plr.Character:FindFirstChild("Flower 3") then
								local I = GetConnectionEnemies("Swan Pirate");
								if I then
									repeat
										wait();
										G.Kill(I, G.Auto_Fish);
									until plr.Backpack:FindFirstChild("Flower 3") or not I.Parent or I.Humanoid.Health <= 0 or G.Auto_Fish == false;
								else
									tp(CFrame.new(980, 121, 1287));
								end;
							end;
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "3");
						end;
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2");
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
						warn("Sea Beast Soon");
					end;
				end;
			end);
		end;
	end);
	Race:AddSection({ "N\195\162ng c\225\186\165p T\225\187\153c v4 \225\187\159 sea 3" });
end;
if World1 then
	Race:AddSection({ "Ch\225\187\137 sea 2 ho\225\186\183c sea 3 \196\145\225\187\131 up t\225\187\153c" });
end;
if World3 then
	Race:AddSection({ "Th\225\187\173 Th\195\161ch / T\225\187\153c v4" });
	local K5 = Race:AddParagraph({ Title = " Tr\225\186\161ng th\195\161i v4 ", Content = "" });
	spawn(function()
		pcall(function()
			while wait(.2) do
				K5:SetDesc(" Gears  :" .. (" " .. plr.Data.Race.C.Value));
			end;
		end);
	end);
	Race:AddToggle({
		Name = "Auto Nh\195\172n Tr\196\131ng",
		Description = "",
		Default = false,
		Callback = function(I)
			LookM = I;
		end,
	});
	function MoveCamtoMoon()
		workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, Lighting:GetMoonDirection() + workspace.CurrentCamera.CFrame.Position);
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, Lighting:GetMoonDirection() + plr.Character.HumanoidRootPart.CFrame.Position);
	end;
	task.spawn(function()
		while task.wait() do
			if LookM then
				MoveCamtoMoon();
				wait(.1);
				replicated.Remotes.CommE:FireServer("ActivateAbility");
			end;
		end;
	end);
	Race:AddToggle({
		Name = "Auto G\225\186\161t C\225\186\167n",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Lver = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.Lver then
				pcall(function()
					for I, e in pairs(workspace.Map["Temple of Time"]:GetDescendants()) do
						if e.Name == "ProximityPrompt" then
							fireproximityprompt(e, math.huge);
						end;
					end;
				end);
			end;
		end;
	end);
	Race:AddToggle({
		Name = "Auto train t\225\187\153c v4",
		Description = "b\225\186\173t t\195\173nh n\196\131ng n\195\162ng c\225\186\165p c\225\186\165p \196\145\225\187\153 trang tr\225\186\161i + t\225\187\177 \196\145\225\187\153ng n\195\162ng c\225\186\165p c\225\186\165p \196\145\225\187\153 c\225\187\167a b\225\186\161n",
		Default = false,
		Callback = function(I)
			_G.AcientOne = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.AcientOne then
					local I = {
							"Reborn Skeleton",
							"Living Zombie",
							"Demonic Soul",
							"Posessed Mummy",
						};
					for e = 1, #I, 1 do
						if (plr.Character:FindFirstChild("RaceEnergy")).Value == 1 then
							vim1:SendKeyEvent(true, "Y", false, game);
							replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy");
							_tp(CFrame.new(-8987.041015625, 215.86206054688, 5886.7104492188));
						elseif (plr.Character:FindFirstChild("RaceTransformed")).Value == false then
							local e = GetConnectionEnemies(I);
							if e then
								repeat
									wait();
									G.Kill(e, _G.AcientOne);
								until _G.AcientOne == false or e.Humanoid.Health <= 0 or not e.Parent;
							else
								_tp(CFrame.new(-9495.6806640625, 453.58624267578, 5977.3486328125));
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	Race:AddButton({ Name = "D\225\187\139ch chuy\225\187\131n t\225\187\169c th\225\187\157i \196\145\225\186\191n \196\144\225\187\129n Th\225\187\157i Gian", Description = "", Callback = function()
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.301757812, 102.62469482422));
		end });
	Race:AddButton({ Name = "D\225\187\139ch chuy\225\187\131n t\225\187\169c th\225\187\157i \196\145\225\186\191n Ancient One", Description = "", Callback = function()
			notween(CFrame.new(28981.552734375, 14888.426757812, -120.24584960938));
		end });
	Race:AddButton({ Name = "D\225\187\139ch chuy\225\187\131n t\225\187\169c th\225\187\157i \196\145\225\186\191n \196\144\225\187\147ng h\225\187\147 c\225\187\149", Description = "", Callback = function()
			notween(CFrame.new(29549, 15069, -88));
		end });
	Race:AddToggle({
		Name = "T\225\187\177 \196\145\225\187\153ng d\225\187\139ch chuy\225\187\131n \196\145\225\186\191n c\225\187\173a up v4",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.TPDoor = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.TPDoor then
					if tostring(plr.Data.Race.Value) == "Mink" then
						_tp(CFrame.new(29020.66015625, 14889.426757812, -379.2682800293));
					elseif tostring(plr.Data.Race.Value) == "Fishman" then
						_tp(CFrame.new(28224.056640625, 14889.426757812, -210.58720397949));
					elseif tostring(plr.Data.Race.Value) == "Cyborg" then
						_tp(CFrame.new(28492.4140625, 14894.426757812, -422.11001586914));
					elseif tostring(plr.Data.Race.Value) == "Skypiea" then
						_tp(CFrame.new(28967.408203125, 14918.075195312, 234.31198120117));
					elseif tostring(plr.Data.Race.Value) == "Ghoul" then
						_tp(CFrame.new(28672.720703125, 14889.127929688, 454.59616088867));
					elseif tostring(plr.Data.Race.Value) == "Human" then
						_tp(CFrame.new(29237.294921875, 14889.426757812, -206.94955444336));
					end;
				end;
			end);
		end;
	end);
	Race:AddToggle({
		Name = "Auto ho\195\160n th\195\160nh trial up v4",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Complete_Trials = I;
		end,
	});
	GetSeaBeastTrial = function()
			if not workspace.Map:FindFirstChild("FishmanTrial") then
				return nil;
			end;
			if workspace._WorldOrigin.Locations:FindFirstChild("Trial of Water") then
				FishmanTrial = workspace._WorldOrigin.Locations:FindFirstChild("Trial of Water");
			end;
			if FishmanTrial then
				for I, e in next, workspace.SeaBeasts:GetChildren() do
					if e:FindFirstChild("HumanoidRootPart") and (e.HumanoidRootPart.Position - FishmanTrial.Position).Magnitude <= 1500 then
						if e.Health.Value > 0 then
							return e;
						end;
					end;
				end;
			end;
		end;
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Complete_Trials then
					if tostring(plr.Data.Race.Value) == "Mink" then
						notween(workspace.Map.MinkTrial.Ceiling.CFrame * CFrame.new(0, -20, 0));
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Complete_Trials then
					if tostring(plr.Data.Race.Value) == "Fishman" then
						if GetSeaBeastTrial() then
							repeat
								task.wait();
								spawn(function()
									_tp(CFrame.new((GetSeaBeastTrial()).HumanoidRootPart.Position.X, (game:GetService("Workspace")).Map["WaterBase-Plane"].Position.Y + 300, (GetSeaBeastTrial()).HumanoidRootPart.Position.Z));
								end);
								MousePos = (GetSeaBeastTrial()).HumanoidRootPart.Position;
								Useskills("Melee", "Z");
								Useskills("Melee", "X");
								Useskills("Melee", "C");
								wait(.1);
								Useskills("Sword", "Z");
								Useskills("Sword", "X");
								wait(.1);
								Useskills("Blox Fruit", "Z");
								Useskills("Blox Fruit", "X");
								Useskills("Blox Fruit", "C");
								wait(.1);
								Useskills("Gun", "Z");
								Useskills("Gun", "X");
							until _G.Complete_Trials == false or not GetSeaBeastTrial();
						end;
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Complete_Trials then
					if tostring(plr.Data.Race.Value) == "Cyborg" then
						_tp(workspace.Map.CyborgTrial.Floor.CFrame * CFrame.new(0, 500, 0));
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Complete_Trials then
					if tostring(plr.Data.Race.Value) == "Skypiea" then
						notween(workspace.Map.SkyTrial.Model.FinishPart.CFrame);
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait(.1) do
			pcall(function()
				if _G.Complete_Trials then
					if tostring(plr.Data.Race.Value) == "Human" or tostring(plr.Data.Race.Value) == "Ghoul" then
						local I = { "Ancient Vampire", "Ancient Zombie" };
						local e = GetConnectionEnemies(I);
						if e then
							repeat
								wait();
								G.Kill(e, _G.Complete_Trials);
							until _G.Complete_Trials == false or not e.Parent or e.Humanoid.Health <= 0;
						end;
					end;
				end;
			end);
		end;
	end);
	Race:AddToggle({
		Name = "T\225\187\177 \196\145\225\187\153ng ti\195\170u di\225\187\135t ng\198\176\225\187\157i ch\198\161i sau khi trial",
		Description = "b\225\186\173t ch\225\186\191 \196\145\225\187\153 ti\195\170u di\225\187\135t ng\198\176\225\187\157i ch\198\161i sau cu\225\187\153c \196\145ua th\225\187\173 nghi\225\187\135m",
		Default = false,
		Callback = function(I)
			_G.Defeating = I;
		end,
	});
	spawn(function()
		while task.wait(Sec) do
			pcall(function()
				if _G.Defeating then
					for I, e in pairs(workspace.Characters:GetChildren()) do
						if e.Name ~= plr.Name then
							if e.Humanoid.Health > 0 and (e:FindFirstChild("HumanoidRootPart") and (e.Parent and (Root.Position - e.HumanoidRootPart.Position).Magnitude <= 250)) then
								repeat
									task.wait();
									EquipWeapon(_G.SelectWeapon);
									_tp(e.HumanoidRootPart.CFrame * CFrame.new(0, 0, 15));
									sethiddenproperty(plr, "SimulationRadius", math.huge);
								until _G.Defeating == false or e.Humanoid.Health <= 0 or not e.Parent or not e:FindFirstChild("HumanoidRootPart") or not e:FindFirstChild("Humanoid");
							end;
						end;
					end;
				end;
			end);
		end;
	end);
end;
if World3 then
	Dojo:AddSection({ "Nhi\225\187\135m V\225\187\165 DoJo & T\225\187\153c Draco" });
	Dojo:AddToggle({
		Name = "Auto l\195\160m nhi\225\187\135m v\225\187\165 Dojo Trainer",
		Description = "b\225\186\173t ch\225\186\191 \196\145\225\187\153 l\195\160m \196\145ai t\225\187\171 tr\225\186\175ng \196\145\225\186\191n \196\145ai \196\145en",
		Default = false,
		Callback = function(I)
			_G.Dojoo = I;
		end,
	});
	function printBeltName(I)
		if type(I) == "table" and I.Quest.BeltName then
			return I.Quest.BeltName;
		end;
	end;
	spawn(function()
		while wait(Sec) do
			if _G.Dojoo then
				pcall(function()
					local I = { [1] = { NPC = "Dojo Trainer", Command = "RequestQuest" } };
					local e = (replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(I));
					local K = printBeltName(e);
					if debug == false and (not e and not K) then
						_tp(CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875));
						debug = true;
					elseif debug == true and ((CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875)).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 50 then
						if K == "White" then
							local I = GetConnectionEnemies("Skull Slayer");
							if I then
								repeat
									task.wait();
									G.Kill(I, _G.Dojoo);
								until not e or not _G.Dojoo or not G.Alive(I);
							else
								_tp(CFrame.new(-16759.58984375, 71.283767700195, 1595.3399658203));
							end;
						elseif K == "Yellow" then
							repeat
								task.wait();
								_G.SeaBeast1 = true;
								_G.TerrorShark = true;
								_G.Shark = true;
								_G.Piranha = true;
								_G.MobCrew = true;
								_G.FishBoat = true;
								_G.SailBoats = true;
							until not _G.Dojoo or not e;
							_G.SeaBeast1 = false;
							_G.TerrorShark = false;
							_G.Shark = false;
							_G.Piranha = false;
							_G.MobCrew = false;
							_G.FishBoat = false;
							_G.SailBoats = false;
						elseif K == "Green" then
							repeat
								task.wait();
								_G.SailBoats = true;
							until not _G.Dojoo or not e;
							_G.SailBoats = false;
						elseif K == "Purple" then
							repeat
								task.wait();
								_G.FarmEliteHunt = true;
							until not _G.Dojoo or not e;
							_G.FarmEliteHunt = false;
						elseif K == "Red" then
							repeat
								task.wait();
								_G.SailBoats = true;
								_G.FishBoat = true;
							until not _G.Dojoo or not e;
							_G.SailBoats = false;
							_G.FishBoat = false;
						elseif K == "Black" then
							repeat
								task.wait();
								if workspace.Map:FindFirstChild("PrehistoricIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
									_G.Prehis_Find = true;
									if workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt", true) then
										_G.Prehis_Skills = false;
										_G.Prehis_Find = true;
									else
										_G.Prehis_Skills = true;
										_G.Prehis_Find = false;
									end;
								else
									_G.Prehis_Find = true;
									_G.Prehis_Skills = false;
								end;
							until not _G.Dojoo or not e;
							_G.Prehis_Find = false;
							_G.Prehis_Skills = false;
						elseif K == "Orange" or K == "Blue" then
							return nil;
						end;
					end;
					if not e then
						debug = false;
						local I = { [1] = { NPC = "Dojo Trainer", Command = "ClaimQuest" } };
						(replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(I));
					end;
				end);
			end;
		end;
	end);
	Dojo:AddToggle({
		Name = "Auto l\195\160m nhi\225\187\135m v\225\187\165 Dragon Hunter",
		Description = "B\225\186\173t \196\145\225\187\131 farm blaze ember + auto thu th\225\186\173p blaze ember",
		Default = false,
		Callback = function(I)
			_G.FarmBlazeEM = I;
		end,
	});
	checkQuesta = function()
			local I = { [1] = { Context = "Check" } };
			local e = nil;
			pcall(function()
				local I = { [1] = { Context = "RequestQuest" } };
				((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer(unpack(I));
			end);
			local K, n = pcall(function()
					e = ((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer(unpack(I));
				end);
			local d = false;
			local z;
			local H;
			local F;
			if e then
				if e.Text then
					d = true;
					local I = e.Text;
					if string.find(tostring(I), "Defeat") then
						F = 1;
						z = string.sub(tostring(I), 8, 9);
						z = tonumber(z);
						local e = { "Hydra Enforcer", "Venomous Assailant" };
						for e, K in pairs(e) do
							if string.find(I, K) then
								H = K;
								break;
							end;
						end;
					elseif string.find(tostring(I), "Destroy") then
						z = 10;
						F = 2;
						H = nil;
					end;
				end;
			end;
			return d, H, z, F;
		end;
	BackTODoJo = function()
			for I, e in pairs((game:GetService("Players")).LocalPlayer.PlayerGui.Notifications:GetChildren()) do
				if e.Name == "NotificationTemplate" then
					if string.find(e.Text, "Head back to the Dojo to complete more tasks") then
						return true;
					end;
				end;
			end;
			return false;
		end;
	DragonMobClear = function(I, e, K)
			if workspace.Enemies:FindFirstChild(e) then
				for K, n in pairs(workspace.Enemies:GetChildren()) do
					if n.Name == e and G.Alive(n) then
						if I then
							G.Kill(n, I);
						end;
					end;
				end;
			else
				_tp(K);
			end;
		end;
	spawn(function()
		while wait() do
			if _G.FarmBlazeEM then
				pcall(function()
					local I, e, K, n = checkQuesta();
					if I == true and not BackTODoJo() then
						if n == 1 then
							if e == "Hydra Enforcer" or e == "Venomous Assailant" then
								repeat
									wait();
									DragonMobClear(true, e, CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492));
								until not _G.FarmBlazeEM or not I or BackTODoJo();
							end;
						elseif n == 2 then
							if workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true) then
								repeat
									wait();
									spawn(function()
										_tp((workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true)).CFrame * CFrame.new(4, 0, 0));
									end);
									if ((workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true)).Position - Root.Position).Magnitude <= 200 then
										MousePos = (workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true)).Position;
										Useskills("Melee", "Z");
										Useskills("Melee", "X");
										Useskills("Melee", "C");
										wait(.5);
										Useskills("Sword", "Z");
										Useskills("Sword", "X");
										wait(.5);
										Useskills("Blox Fruit", "Z");
										Useskills("Blox Fruit", "X");
										Useskills("Blox Fruit", "C");
										wait(.5);
										Useskills("Gun", "Z");
										Useskills("Gun", "X");
									end;
								until not _G.FarmBlazeEM or not I or BackTODoJo();
							end;
						end;
					else
						_tp(CFrame.new(5813, 1208, 884));
						DragonMobClear(false, nil, nil);
					end;
				end);
			end;
		end;
	end);
	spawn(function()
		while wait(.1) do
			if _G.FarmBlazeEM then
				pcall(function()
					if workspace.EmberTemplate:FindFirstChild("Part") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.EmberTemplate.Part.CFrame;
					end;
				end);
			end;
		end;
	end);
	Dojo:AddSection({ "Draco Trial" });
	GetQuestDracoLevel = function()
			local I = { [1] = { NPC = "Dragon Wizard", Command = "Upgrade" } };
			return (replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(I));
		end;
	Dojo:AddToggle({
		Name = "Bay \196\145\225\186\191n n\195\162ng c\225\186\165p Draco Trial",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.UPGDrago = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.UPGDrago then
					if GetQuestDracoLevel() == false then
						return nil;
					elseif GetQuestDracoLevel() == true then
						if ((CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609)).Position - Root.Position).Magnitude >= 300 then
							_tp(CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609));
						else
							_tp(CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609));
							local I = { [1] = { NPC = "Dragon Wizard", Command = "Upgrade" } };
							(replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(I));
						end;
					end;
				end;
			end);
		end;
	end);
	Dojo:AddToggle({
		Name = "Auto up t\225\187\153c draco (V1)",
		Description = "b\225\186\173t ch\225\186\191 \196\145\225\187\153 t\225\187\177 \196\145\225\187\153ng nhi\225\187\135m v\225\187\165 1, s\225\187\177 ki\225\187\135n th\225\187\157i ti\225\187\129n s\225\187\173 t\225\187\177 \196\145\225\187\153ng + thu th\225\186\173p tr\225\187\169ng r\225\187\147ng",
		Default = false,
		Callback = function(I)
			_G.DragoV1 = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.DragoV1 then
					if GetM("Dragon Egg") <= 0 then
						repeat
							wait();
							_G.Prehis_Find = true;
							_G.Prehis_Skills = true;
							_G.Prehis_DE = true;
						until not _G.DragoV1 or GetM("Dragon Egg") >= 1;
						_G.Prehis_Find = false;
						_G.Prehis_Skills = false;
						_G.Prehis_DE = false;
					end;
				end;
			end);
		end;
	end);
	Dojo:AddToggle({
		Name = "Auto up t\225\187\153c draco (V2)",
		Description = "B\225\186\173t ch\225\186\191 \196\145\225\187\153 t\225\187\177 \196\145\225\187\153ng ti\195\170u di\225\187\135t C\198\176\225\187\155p r\225\187\171ng v\195\160 Thu th\225\186\173p hoa l\225\187\173a",
		Default = false,
		Callback = function(I)
			_G.AutoFireFlowers = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.AutoFireFlowers then
				local I = workspace:FindFirstChild("FireFlowers");
				local e = GetConnectionEnemies("Forest Pirate");
				if e then
					repeat
						wait();
						G.Kill(e, _G.AutoFireFlowers);
					until not _G.AutoFireFlowers or not e.Parent or e.Humanoid.Health <= 0 or I;
				else
					_tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375));
				end;
				if I then
					for I, e in pairs(I:GetChildren()) do
						if e:IsA("Model") and e.PrimaryPart then
							local I = e.PrimaryPart.Position;
							local K = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
							local n = (I - K).Magnitude;
							if n <= 100 then
								vim1:SendKeyEvent(true, "E", false, game);
								wait(1.5);
								vim1:SendKeyEvent(false, "E", false, game);
							else
								_tp(CFrame.new(I));
							end;
						end;
					end;
				end;
			end;
		end;
	end);
	Dojo:AddToggle({
		Name = "Auto up t\225\187\153c draco (V3)",
		Description = "turn on for sea event kill terror shark",
		Default = false,
		Callback = function(I)
			_G.DragoV3 = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.DragoV3 then
					repeat
						wait();
						_G.DangerSc = "Lv Infinite";
						_G.SailBoats = true;
						_G.TerrorShark = true;
					until not _G.DragoV3;
					_G.DangerSc = "Lv 1";
					_G.SailBoats = false;
					_G.TerrorShark = false;
				end;
			end);
		end;
	end);
	Dojo:AddToggle({
		Name = "T\225\187\177 \196\145\225\187\153ng Relic Draco Trial [ Beta ]",
		Description = "B\225\186\173t ch\225\186\191 \196\145\225\187\153 d\195\185ng th\225\187\173 t\225\187\177 \196\145\225\187\153ng v4, b\225\186\161n ph\225\186\163i t\225\187\177 m\195\172nh l\195\160m",
		Default = false,
		Callback = function(I)
			_G.Relic123 = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.Relic123 then
				pcall(function()
					if workspace.Map:FindFirstChild("DracoTrial") then
						replicated.Remotes.DracoTrial:InvokeServer();
						wait(.5);
						repeat
							wait();
							_tp(CFrame.new(-39934.9765625, 10685.359375, 22999.34375));
						until not _G.Relic123 or Root.Position == (CFrame.new(-39934.9765625, 10685.359375, 22999.34375)).Position;
						repeat
							wait();
							_tp(CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625));
						until not _G.Relic123 or Root.Position == (CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625)).Position;
						wait(2.5);
						repeat
							wait();
							_tp(CFrame.new(-39914.65625, 10685.384765625, 23000.177734375));
						until not _G.Relic123 or Root.Position == (CFrame.new(-39914.65625, 10685.384765625, 23000.177734375)).Position;
						repeat
							wait();
							_tp(CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375));
						until not _G.Relic123 or Root.Position == (CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375)).Position;
						wait(2.5);
						repeat
							wait();
							_tp(CFrame.new(-39908.5, 10685.405273438, 22990.04296875));
						until not _G.Relic123 or Root.Position == (CFrame.new(-39908.5, 10685.405273438, 22990.04296875)).Position;
						repeat
							wait();
							_tp(CFrame.new(-39609.5, 9376.400390625, 23472.94335975));
						until not _G.Relic123 or Root.Position == (CFrame.new(-39609.5, 9376.400390625, 23472.94335975)).Position;
					else
						local I = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport");
						if I and I:IsA("Part") then
							_tp(CFrame.new(I.Position));
						end;
					end;
				end);
			end;
		end;
	end);
	Dojo:AddToggle({
		Name = "T\225\187\177 \196\145\225\187\153ng hu\225\186\165n luy\225\187\135n train Draco",
		Description = "B\225\186\173t ch\225\186\191 \196\145\225\187\153 hu\225\186\165n luy\225\187\135n Drago Race v4 + t\225\187\177 \196\145\225\187\153ng n\195\162ng c\225\186\165p c\225\186\165p \196\145\225\187\153",
		Default = false,
		Callback = function(I)
			_G.TrainDrago = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.TrainDrago then
					local I = { "Venomous Assailant", "Hydra Enforcer" };
					for e = 1, #I, 1 do
						if (plr.Character:FindFirstChild("RaceEnergy")).Value == 1 then
							vim1:SendKeyEvent(true, "Y", false, game);
							replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2);
							_tp(CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492));
						elseif (plr.Character:FindFirstChild("RaceTransformed")).Value == false then
							local e = GetConnectionEnemies(I);
							if e then
								repeat
									wait();
									G.Kill(e, _G.TrainDrago);
								until _G.TrainDrago == false or e.Humanoid.Health <= 0 or not e.Parent;
							else
								_tp(CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492));
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	Dojo:AddToggle({
		Name = "Fly [ bay ]",
		Description = "B\225\186\173t ch\225\186\191 \196\145\225\187\153 bay",
		Default = false,
		Callback = function(v)
			_G.Fly = v;
		end,
	});
	local Players = game:GetService("Players");
	local RunService = game:GetService("RunService");
	local player = Players.LocalPlayer;
	local flying = false;
	local speed = 90;
	local yForce = 50;
	local bodyGyro, bodyVelocity;
	local flyConn;
	local function startFly()
		local char = player.Character or player.CharacterAdded:Wait();
		local hum = char:WaitForChild("Humanoid");
		local root = char:WaitForChild("HumanoidRootPart");
		if bodyGyro then
			bodyGyro:Destroy();
		end;
		if bodyVelocity then
			bodyVelocity:Destroy();
		end;
		bodyGyro = Instance.new("BodyGyro");
		bodyGyro.P = 90000.0;
		bodyGyro.MaxTorque = Vector3.new(9000000000.0, 9000000000.0, 9000000000.0);
		bodyGyro.CFrame = root.CFrame;
		bodyGyro.Parent = root;
		bodyVelocity = Instance.new("BodyVelocity");
		bodyVelocity.MaxForce = Vector3.new(9000000000.0, 9000000000.0, 9000000000.0);
		bodyVelocity.Velocity = Vector3.zero;
		bodyVelocity.Parent = root;
		flying = true;
		flyConn = RunService.Heartbeat:Connect(function()
				if not _G.Fly or not flying then
					return;
				end;
				local moveDir = hum.MoveDirection;
				local velX, velZ = 0, 0;
				if moveDir.Magnitude > 0 then
					velX = moveDir.Unit.X * speed;
					velZ = moveDir.Unit.Z * speed;
					bodyGyro.CFrame = CFrame.new(root.Position, root.Position + Vector3.new(moveDir.X, 0, moveDir.Z));
				end;
				bodyVelocity.Velocity = Vector3.new(velX, yForce, velZ);
			end);
	end;
	local function stopFly()
		flying = false;
		if flyConn then
			flyConn:Disconnect();
			flyConn = nil;
		end;
		if bodyGyro then
			bodyGyro:Destroy();
			bodyGyro = nil;
		end;
		if bodyVelocity then
			bodyVelocity:Destroy();
			bodyVelocity = nil;
		end;
	end;
	task.spawn(function()
		while task.wait() do
			if _G.Fly and not flying then
				startFly();
			elseif not _G.Fly and flying then
				stopFly();
			end;
		end;
	end);
	Dojo:AddToggle({
		Name = "Bay \196\145\225\186\191n Draco Trials",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.TpDrago_Prehis = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.TpDrago_Prehis then
				local I = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport");
				if I and I:IsA("Part") then
					_tp(CFrame.new(I.Position));
				end;
			end;
		end;
	end);
	Dojo:AddToggle({
		Name = "Ho\195\161n \196\145\225\187\149i ch\225\187\167ng t\225\187\153c Draco",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.BuyDrago = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.BuyDrago then
				pcall(function()
					if ((CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609)).Position - Root.Position).Magnitude >= 300 then
						_tp(CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609));
					else
						_tp(CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609));
						local I = { [1] = { NPC = "Dragon Wizard", Command = "DragonRace" } };
						(replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(I));
					end;
				end);
			end;
		end;
	end);
	Dojo:AddToggle({
		Name = "N\195\162ng c\225\186\165p Dragon Talon v\225\187\155i Uzoth",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.DT_Uzoth = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.DT_Uzoth then
				local I = CFrame.new(5661.89014, 1211.31909, 864.836731, .811413169, -1.36805838e-008, -0.584473014, 4.75227395e-008, 1, 4.25682458e-008, .584473014, -6.23161966e-008, .811413169);
				_tp(I);
				if (I.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 25 then
					local I = { NPC = "Uzoth", Command = "Upgrade" };
					replicated.Modules.Net["RF/InteractDragonQuest"]:InvokeServer(I);
				end;
			end;
		end;
	end);
end;
if World1 or World2 then
	Dojo:AddSection({ "Ch\225\187\137 \225\187\159 Sea 3" });
end;
function isnil(I)
	return I == nil;
end;
local function G5(I)
	return math.floor(tonumber(I) + .5);
end;
Number = math.random(1, 1000000);
EspPly = function()
		for I, e in next, game.Players:GetChildren() do
			pcall(function()
				if not isnil(e.Character) then
					if PlayerEsp then
						if not isnil(e.Character.Head) and not e.Character.Head:FindFirstChild("NameEsp" .. Number) then
							local I = Instance.new("BillboardGui", e.Character.Head);
							I.Name = "NameEsp" .. Number;
							I.ExtentsOffset = Vector3.new(0, 1, 0);
							I.Size = UDim2.new(1, 200, 1, 30);
							I.Adornee = e.Character.Head;
							I.AlwaysOnTop = true;
							local K = Instance.new("TextLabel", I);
							K.Font = Enum.Font.Code;
							K.FontSize = "Size14";
							K.TextWrapped = true;
							K.Text = e.Name .. (" | Lv. " .. e.Data.Level.Value);
							K.Size = UDim2.new(1, 0, 1, 0);
							K.TextYAlignment = "Top";
							K.BackgroundTransparency = 1;
							K.TextStrokeTransparency = .5;
							K.TextColor3 = Color3.new(1, 1, 1);
						else
							e.Character.Head["NameEsp" .. Number].TextLabel.Text = e.Name .. (" | Lv. " .. e.Data.Level.Value);
						end;
					else
						if e.Character.Head:FindFirstChild("NameEsp" .. Number) then
							(e.Character.Head:FindFirstChild("NameEsp" .. Number)):Destroy();
						end;
					end;
				end;
			end);
		end;
	end;
DevEsp = function()
		for I, e in next, workspace:GetChildren() do
			pcall(function()
				if DevilFruitESP then
					if string.find(e.Name, "Fruit") then
						if not e.Handle:FindFirstChild("NameEsp" .. Number) then
							local I = Instance.new("BillboardGui", e.Handle);
							I.Name = "NameEsp" .. Number;
							I.ExtentsOffset = Vector3.new(0, 1, 0);
							I.Size = UDim2.new(1, 200, 1, 30);
							I.Adornee = e.Handle;
							I.AlwaysOnTop = true;
							local K = Instance.new("TextLabel", I);
							K.Font = Enum.Font.Code;
							K.FontSize = "Size14";
							K.TextWrapped = true;
							K.Size = UDim2.new(1, 0, 1, 0);
							K.TextYAlignment = "Top";
							K.BackgroundTransparency = 1;
							K.TextStrokeTransparency = .5;
							K.TextColor3 = Color3.fromRGB(255, 255, 255);
							K.Text = e.Name .. (" \n" .. (G5(((game:GetService("Players")).LocalPlayer.Character.Head.Position - e.Handle.Position).Magnitude / 3) .. " M"));
						else
							e.Handle["NameEsp" .. Number].TextLabel.Text = "[" .. (e.Name .. ("]" .. ("   \n" .. (G5(((game:GetService("Players")).LocalPlayer.Character.Head.Position - e.Handle.Position).Magnitude / 3) .. " M"))));
						end;
					end;
				else
					if e.Handle:FindFirstChild("NameEsp" .. Number) then
						(e.Handle:FindFirstChild("NameEsp" .. Number)):Destroy();
					end;
				end;
			end);
		end;
	end;
flowerEsp = function()
		for I, e in pairs(workspace:GetChildren()) do
			pcall(function()
				if e.Name == "Flower2" or e.Name == "Flower1" then
					if FlowerESP then
						if not e:FindFirstChild("NameEsp" .. Number) then
							local I = Instance.new("BillboardGui", e);
							I.Name = "NameEsp" .. Number;
							I.ExtentsOffset = Vector3.new(0, 1, 0);
							I.Size = UDim2.new(1, 200, 1, 30);
							I.Adornee = e;
							I.AlwaysOnTop = true;
							local K = Instance.new("TextLabel", I);
							K.Font = Enum.Font.Code;
							K.FontSize = "Size14";
							K.TextWrapped = true;
							K.Size = UDim2.new(1, 0, 1, 0);
							K.TextYAlignment = "Top";
							K.BackgroundTransparency = 1;
							K.TextStrokeTransparency = .5;
							K.TextColor3 = Color3.fromRGB(255, 255, 255);
							if e.Name == "Flower1" then
								K.Text = "Blue Flower" .. (" \n" .. (G5(((game:GetService("Players")).LocalPlayer.Character.Head.Position - e.Position).Magnitude / 3) .. " M"));
							end;
							if e.Name == "Flower2" then
								K.Text = "Red Flower" .. (" \n" .. (G5(((game:GetService("Players")).LocalPlayer.Character.Head.Position - e.Position).Magnitude / 3) .. " M"));
							end;
						else
							e["NameEsp" .. Number].TextLabel.Text = e.Name .. ("   \n" .. (G5(((game:GetService("Players")).LocalPlayer.Character.Head.Position - e.Position).Magnitude / 3) .. " M"));
						end;
					else
						if e:FindFirstChild("NameEsp" .. Number) then
							(e:FindFirstChild("NameEsp" .. Number)):Destroy();
						end;
					end;
				end;
			end);
		end;
	end;
gearEsp = function()
		for I, e in pairs(workspace.Map.MysticIsland:GetDescendants()) do
			pcall(function()
				if ESPGear then
					if e.Name == "Part" and e.Material == Enum.Material.Neon then
						if not e:FindFirstChild("NameEsp") then
							local I = Instance.new("BillboardGui", e);
							I.Name = "NameEsp";
							I.ExtentsOffset = Vector3.new(0, 1, 0);
							I.Size = UDim2.new(1, 200, 1, 30);
							I.Adornee = e;
							I.AlwaysOnTop = true;
							local K = Instance.new("TextLabel", I);
							K.Font = "Code";
							K.FontSize = "Size14";
							K.TextWrapped = true;
							K.Size = UDim2.new(1, 0, 1, 0);
							K.TextYAlignment = "Top";
							K.BackgroundTransparency = 1;
							K.TextStrokeTransparency = .5;
							K.TextColor3 = Color3.fromRGB(255, 255, 255);
						else
							e.NameEsp.TextLabel.Text = "Gear" .. ("   \n" .. (G5((plr.Character.Head.Position - e.Position).Magnitude / 3) .. " M"));
						end;
					end;
				else
					if e:FindFirstChild("NameEsp") then
						(e:FindFirstChild("NameEsp")):Destroy();
					end;
				end;
			end);
		end;
	end;
AdvanFruitEsp = function()
		if advanEsp == true then
			for I, e in pairs((game:GetService("ReplicatedStorage")).NPCs:GetChildren()) do
				if e.Name == "Advanced Fruit Dealer" then
					local Adv = workspace:FindFirstChild("Adv");
					if not Adv then
						Adv = Instance.new("Part");
						Adv.Name = "Adv";
						Adv.Transparency = 1;
						Adv.Size = Vector3.new(1, 1, 1);
						Adv.Anchored = true;
						Adv.CanCollide = false;
						Adv.Parent = workspace;
						Adv.CFrame = e.HumanoidRootPart.CFrame;
					end;
					if Adv then
						if not Adv:FindFirstChild("NameEsp") then
							local I = Instance.new("BillboardGui", Adv);
							I.Name = "NameEsp";
							I.ExtentsOffset = Vector3.new(0, 1, 0);
							I.Size = UDim2.new(1, 200, 1, 30);
							I.Adornee = Adv;
							I.AlwaysOnTop = true;
							local txt = Instance.new("TextLabel", I);
							txt.Font = "Code";
							txt.FontSize = "Size14";
							txt.TextWrapped = true;
							txt.Size = UDim2.new(1, 0, 1, 0);
							txt.TextYAlignment = "Top";
							txt.BackgroundTransparency = 1;
							txt.TextStrokeTransparency = .5;
							txt.TextColor3 = Color3.fromRGB(255, 255, 255);
						else
							Adv.NameEsp.TextLabel.Text = e.Name .. ("   \n" .. (G5((game.Players.LocalPlayer.Character.Head.Position - e.HumanoidRootPart.Position).Magnitude / 3) .. " M"));
						end;
					end;
				end;
			end;
		else
			if workspace:FindFirstChild("Adv") then
				workspace.Adv:Destroy();
			end;
		end;
	end;
HakiClorEsp = function()
		if ColorEsp == true then
			for I, e in pairs((game:GetService("ReplicatedStorage")).NPCs:GetChildren()) do
				if e.Name == "Barista Cousin" then
					local Gay = workspace:FindFirstChild("Gay");
					if not Gay then
						Gay = Instance.new("Part");
						Gay.Name = "Gay";
						Gay.Transparency = 1;
						Gay.Size = Vector3.new(1, 1, 1);
						Gay.Anchored = true;
						Gay.CanCollide = false;
						Gay.Parent = workspace;
						Gay.CFrame = e.HumanoidRootPart.CFrame;
					end;
					if Gay then
						if not Gay:FindFirstChild("NameEsp") then
							local I = Instance.new("BillboardGui", Gay);
							I.Name = "NameEsp";
							I.ExtentsOffset = Vector3.new(0, 1, 0);
							I.Size = UDim2.new(1, 200, 1, 30);
							I.Adornee = Gay;
							I.AlwaysOnTop = true;
							local txt = Instance.new("TextLabel", I);
							txt.Font = "Code";
							txt.FontSize = "Size14";
							txt.TextWrapped = true;
							txt.Size = UDim2.new(1, 0, 1, 0);
							txt.TextYAlignment = "Top";
							txt.BackgroundTransparency = 1;
							txt.TextStrokeTransparency = .5;
							txt.TextColor3 = Color3.fromRGB(255, 255, 255);
						else
							Gay.NameEsp.TextLabel.Text = e.Name .. ("   \n" .. (G5((game.Players.LocalPlayer.Character.Head.Position - e.HumanoidRootPart.Position).Magnitude / 3) .. " M"));
						end;
					end;
				end;
			end;
		else
			if workspace:FindFirstChild("Gay") then
				workspace.Gay:Destroy();
			end;
		end;
	end;
LegenSword = function()
		if LegenS == true then
			for I, e in pairs((game:GetService("ReplicatedStorage")).NPCs:GetChildren()) do
				if e.Name == "Legendary Sword Dealer " then
					if not workspace:FindFirstChild("Lgd") then
						Lgd = Instance.new("Part");
						Lgd.Name = "Lgd";
						Lgd.Transparency = 1;
						Lgd.Size = Vector3.new(1, 1, 1);
						Lgd.Anchored = true;
						Lgd.CanCollide = false;
						Lgd.Parent = workspace;
						Lgd.CFrame = e.HumanoidRootPart.CFrame;
					elseif workspace:FindFirstChild("Lgd") then
						if not Lgd:FindFirstChild("NameEsp") then
							local I = Instance.new("BillboardGui", Lgd);
							I.Name = "NameEsp";
							I.ExtentsOffset = Vector3.new(0, 1, 0);
							I.Size = UDim2.new(1, 200, 1, 30);
							I.Adornee = Lgd;
							I.AlwaysOnTop = true;
							local txt = Instance.new("TextLabel", I);
							txt.Font = "Code";
							txt.FontSize = "Size14";
							txt.TextWrapped = true;
							txt.Size = UDim2.new(1, 0, 1, 0);
							txt.TextYAlignment = "Top";
							txt.BackgroundTransparency = 1;
							txt.TextStrokeTransparency = .5;
							txt.TextColor3 = Color3.fromRGB(255, 255, 255);
						else
							Lgd.NameEsp.TextLabel.Text = e.Name .. ("   \n" .. (G5((game.Players.LocalPlayer.Character.Head.Position - e.HumanoidRootPart.Position).Magnitude / 3) .. " M"));
						end;
					end;
				end;
			end;
		else
			if workspace:FindFirstChild("Lgd") then
				(workspace:FindFirstChild("Lgd")):Destroy();
			end;
		end;
	end;
ChestEsp = function()
		if ChestESP then
			local I = game:GetService("CollectionService");
			local z = I:GetTagged("_ChestTagged");
			for _, e in ipairs(z) do
				pcall(function()
					local H = ((e:GetPivot()).Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude;
					local Q = e:FindFirstChild("ChestEspAttachment");
					if not Q then
						local att = Instance.new("Attachment", e);
						att.Name = "ChestEspAttachment";
						att.Position = Vector3.new(0, 3, 0);
						local gui = Instance.new("BillboardGui", att);
						gui.Name = "NameEsp";
						gui.Size = UDim2.new(0, 200, 0, 30);
						gui.AlwaysOnTop = true;
						local txt = Instance.new("TextLabel", gui);
						txt.Font = Enum.Font.Code;
						txt.TextSize = 14;
						txt.BackgroundTransparency = 1;
						txt.TextColor3 = Color3.new(1, 1, 1);
						txt.Size = UDim2.new(1, 0, 1, 0);
					end;
					local X = e.ChestEspAttachment:FindFirstChild("NameEsp");
					if X then
						X.TextLabel.Text = string.format("[%s] %d M", e.Name:gsub("Label", ""), math.floor(H / 3));
					end;
				end);
			end;
		else
			for _, e in ipairs((game:GetService("CollectionService")):GetTagged("_ChestTagged")) do
				if e:FindFirstChild("ChestEspAttachment") then
					e.ChestEspAttachment:Destroy();
				end;
			end;
		end;
	end;
berriesEsp = function()
		if BerryEsp then
			local I = game:GetService("CollectionService");
			local n = I:GetTagged("BerryBush");
			for _, e in ipairs(n) do
				local pos = (e.Parent:GetPivot()).Position;
				for _, attr in pairs(e:GetAttributes()) do
					local name = "BerryEspPart_" .. tostring(pos);
					local d = workspace:FindFirstChild(name);
					if not d then
						d = Instance.new("Part", workspace);
						d.Name = name;
						d.Transparency = 1;
						d.Anchored = true;
						d.CanCollide = false;
						d.CFrame = CFrame.new(pos);
					end;
					if not d:FindFirstChild("NameEsp") then
						local gui = Instance.new("BillboardGui", d);
						gui.Name = "NameEsp";
						gui.Size = UDim2.new(0, 200, 0, 30);
						gui.AlwaysOnTop = true;
						local txt = Instance.new("TextLabel", gui);
						txt.Font = Enum.Font.Code;
						txt.TextColor3 = Color3.new(1, 1, 1);
						txt.BackgroundTransparency = 1;
						txt.Size = UDim2.new(1, 0, 1, 0);
					end;
					local dist = (game.Players.LocalPlayer.Character.Head.Position - pos).Magnitude / 3;
					d.NameEsp.TextLabel.Text = "[" .. (attr .. ("] " .. (math.round(dist) .. " M")));
				end;
			end;
		else
			for _, e in ipairs(workspace:GetChildren()) do
				if e.Name:match("BerryEspPart_") then
					e:Destroy();
				end;
			end;
		end;
	end;
_G.ESPColor = Color3.fromRGB(255, 255, 255);
function IslandESP_Func()
	for _, island in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
		pcall(function()
			if island.Name ~= "Sea" then
				if _G.IslandESP then
					if not island:FindFirstChild("IslandESP") then
						local billboard = Instance.new("BillboardGui", island);
						billboard.Name = "IslandESP";
						billboard.Size = UDim2.new(0, 150, 0, 35);
						billboard.StudsOffset = Vector3.new(0, 35, 0);
						billboard.AlwaysOnTop = true;
						local text = Instance.new("TextLabel", billboard);
						text.Size = UDim2.new(1, 0, 1, 0);
						text.BackgroundTransparency = 1;
						text.Text = island.Name;
						text.TextColor3 = _G.ESPColor;
						text.TextStrokeTransparency = 0;
						text.TextScaled = true;
						text.Font = Enum.Font.Cartoon;
					end;
				else
					if island:FindFirstChild("IslandESP") then
						island.IslandESP:Destroy();
					end;
				end;
			end;
		end);
	end;
end;
Esp:AddSection({ "ESP" });
Esp:AddToggle({ Name = "Esp Qu\225\186\163 Berry", Default = false, Callback = function(I)
		BerryEsp = I;
		spawn(function()
			while BerryEsp do
				wait(1);
				berriesEsp();
			end;
		end);
	end });
Esp:AddToggle({ Name = "Esp Ng\198\176\225\187\157i Ch\198\161i", Default = false, Callback = function(I)
		PlayerEsp = I;
		spawn(function()
			while PlayerEsp do
				wait(.1);
				EspPly();
			end;
		end);
	end });
Esp:AddToggle({ Name = "Esp R\198\176\198\161ng", Default = false, Callback = function(I)
		ChestESP = I;
		spawn(function()
			while ChestESP do
				wait(1);
				ChestEsp();
			end;
		end);
	end });
Esp:AddToggle({ Name = "Esp Tr\195\161i", Default = false, Callback = function(I)
		DevilFruitESP = I;
		task.spawn(function()
			while DevilFruitESP do
				task.wait(1);
				pcall(DevEsp);
			end;
		end);
	end });
Esp:AddToggle({ Name = "Esp \196\144\225\186\163o", Default = false, Callback = function(I)
		_G.IslandESP = I;
		task.spawn(function()
			while _G.IslandESP do
				IslandESP_Func();
				task.wait(2);
			end;
			IslandESP_Func();
		end);
	end });
if World2 then
	Esp:AddToggle({ Name = "Esp Hoa", Default = false, Callback = function(I)
			FlowerESP = I;
			task.spawn(function()
				while FlowerESP do
					pcall(flowerEsp);
					task.wait(1);
				end;
			end);
		end });
	Esp:AddToggle({ Name = "Esp Ki\225\186\191m Huy\225\187\129n Tho\225\186\161i", Default = false, Callback = function(I)
			LegenS = I;
			task.spawn(function()
				while LegenS do
					pcall(LegenSword);
					task.wait(1);
				end;
			end);
		end });
end;
if World2 or World3 then
	Esp:AddToggle({ Name = "Esp Ng\198\176\225\187\157i b\195\161n haki m\195\160u", Default = false, Callback = function(I)
			ColorEsp = I;
			task.spawn(function()
				while ColorEsp do
					pcall(HakiClorEsp);
					task.wait(1);
				end;
				pcall(HakiClorEsp);
			end);
		end });
end;
if World3 then
	Esp:AddToggle({ Name = "Esp B\195\161nh R\196\131ng", Default = false, Callback = function(I)
			ESPGear = I;
			task.spawn(function()
				while ESPGear do
					pcall(gearEsp);
					task.wait(1);
				end;
			end);
		end });
	Esp:AddToggle({ Name = "Esp Ng\198\176\225\187\157i b\195\161n tr\195\161i cao c\225\186\165p", Default = false, Callback = function(I)
			advanEsp = I;
			task.spawn(function()
				while advanEsp do
					pcall(AdvanFruitEsp);
					task.wait(1);
				end;
				pcall(AdvanFruitEsp);
			end);
		end });
end;
Esp:AddSection({ "Font ch\225\187\175" });
local currentFont = Enum.Font.Arial;
local function ApplyGlobalFont(fontEnum)
	currentFont = fontEnum;
	for _, obj in ipairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
		if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
			obj.Font = fontEnum;
		end;
	end;
end;
game.Players.LocalPlayer.PlayerGui.DescendantAdded:Connect(function(obj)
	if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
		obj.Font = currentFont;
	end;
end);
Esp:AddButton({ Name = "Fonte: Amatic SC", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.AmaticSC);
	end });
Esp:AddButton({ Name = "Fonte: Antique", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Antique);
	end });
Esp:AddButton({ Name = "Fonte: Arcade", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Arcade);
	end });
Esp:AddButton({ Name = "Fonte: Arial", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Arial);
	end });
Esp:AddButton({ Name = "Fonte: Arial Bold", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.ArialBold);
	end });
Esp:AddButton({ Name = "Fonte: Bangers", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Bangers);
	end });
Esp:AddButton({ Name = "Fonte: Bodoni", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Bodoni);
	end });
Esp:AddButton({ Name = "Fonte: Cartoon", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Cartoon);
	end });
Esp:AddButton({ Name = "Fonte: Code", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Code);
	end });
Esp:AddButton({ Name = "Fonte: Creepster", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Creepster);
	end });
Esp:AddButton({ Name = "Fonte: Denk One", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.DenkOne);
	end });
Esp:AddButton({ Name = "Fonte: Fondamento", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Fondamento);
	end });
Esp:AddButton({ Name = "Fonte: Fredoka One", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.FredokaOne);
	end });
Esp:AddButton({ Name = "Fonte: Garamond", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Garamond);
	end });
Esp:AddButton({ Name = "Fonte: Gotham", Description = "", Callback = function()
		ApplyGlobalFont(Enum.Font.Gotham);
	end });
Esp:AddSection({ "Ch\225\187\137 s\225\187\145" });
Esp:AddToggle({
	Name = "C\225\187\153ng \196\145i\225\187\131m v\195\160o Melee",
	Description = "",
	Default = GetSetting("AutoMelee_Save", false),
	Callback = function(I)
		_G.Auto_Melee = I;
		_G.SaveData.AutoMelee_Save = I;
		SaveSettings();
	end,
});
Esp:AddToggle({
	Name = "C\225\187\153ng \196\145i\225\187\131m v\195\160o Sword",
	Description = "",
	Default = GetSetting("AutoSword_Save", false),
	Callback = function(I)
		_G.Auto_Sword = I;
		_G.SaveData.AutoSword_Save = I;
		SaveSettings();
	end,
});
Esp:AddToggle({
	Name = "C\225\187\153ng \196\145i\225\187\131m v\195\160o Gun",
	Description = "",
	Default = GetSetting("AutoGun_Save", false),
	Callback = function(I)
		_G.Auto_Gun = I;
		_G.SaveData.AutoGun_Save = I;
		SaveSettings();
	end,
});
Esp:AddToggle({
	Name = "C\225\187\153ng \196\145i\225\187\131m v\195\160o Fruit",
	Description = "",
	Default = GetSetting("AutoFruit_Save", false),
	Callback = function(I)
		_G.Auto_Blox = I;
		_G.SaveData.AutoFruit_Save = I;
		SaveSettings();
	end,
});
Esp:AddToggle({
	Name = "C\225\187\153ng \196\145i\225\187\131m v\195\160o Defense",
	Description = "",
	Default = GetSetting("AutoDefense_Save", false),
	Callback = function(I)
		_G.Auto_Defense = I;
		_G.SaveData.AutoDefense_Save = I;
		SaveSettings();
	end,
});
task.spawn(function()
	while task.wait(1) do
		pcall(function()
			local remote = (game:GetService("ReplicatedStorage")).Remotes.CommF_;
			if _G.Auto_Melee then
				remote:InvokeServer("AddPoint", "Melee", 3);
			end;
			if _G.Auto_Sword then
				remote:InvokeServer("AddPoint", "Sword", 3);
			end;
			if _G.Auto_Gun then
				remote:InvokeServer("AddPoint", "Gun", 3);
			end;
			if _G.Auto_Blox then
				remote:InvokeServer("AddPoint", "Demon Fruit", 3);
			end;
			if _G.Auto_Defense then
				remote:InvokeServer("AddPoint", "Defense", 3);
			end;
		end);
	end;
end);
local AllAvailablePoints = 9999999;
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Melee then
				statsSetings("Melee", AllAvailablePoints);
			end;
		end);
	end;
end);
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Sword then
				statsSetings("Sword", AllAvailablePoints);
			end;
		end);
	end;
end);
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Gun then
				statsSetings("Gun", AllAvailablePoints);
			end;
		end);
	end;
end);
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Blox then
				statsSetings("Devil", AllAvailablePoints);
			end;
		end);
	end;
end);
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Defense then
				statsSetings("Defense", AllAvailablePoints);
			end;
		end);
	end;
end);
Player:AddSection({ "Pvp, aimbot" });
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local O5 = {};
for _, p in pairs(Players:GetPlayers()) do
	if p.Name ~= LocalPlayer.Name then
		table.insert(O5, p.Name);
	end;
end;
local PlayerDropdown = Player:AddDropdown({
		Name = "Ch\225\187\141n ng\198\176\225\187\157i ch\198\161i",
		Description = "",
		Options = O5,
		Default = nil,
		Multi = false,
		Callback = function(I)
			_G.PlayersList = I;
		end,
	});
Player:AddButton({ Name = "L\195\160m m\225\187\155i danh s\195\161ch ng\198\176\225\187\157i ch\198\161i", Description = "", Callback = function()
		local NewPlayers = {};
		for _, p in pairs(Players:GetPlayers()) do
			if p.Name ~= LocalPlayer.Name then
				table.insert(NewPlayers, p.Name);
			end;
		end;
		PlayerDropdown:Refresh(NewPlayers, true);
	end });
Player:AddToggle({
	Name = "Bay \196\145\225\186\191n ng\198\176\225\187\157i ch\198\161i",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.TpPly = I;
		spawn(function()
			pcall(function()
				while _G.TpPly do
					wait();
					_tp((game:GetService("Players"))[_G.PlayersList].Character.HumanoidRootPart.CFrame);
				end;
			end);
		end);
	end,
});
Player:AddToggle({
	Name = "Xem ng\198\176\225\187\157i ch\198\161i",
	Description = "",
	Default = false,
	Callback = function(I)
		SpectatePlys = I;
		spawn(function()
			repeat
				task.wait(.1);
				workspace.Camera.CameraSubject = ((game:GetService("Players")):FindFirstChild(_G.PlayersList)).Character.Humanoid;
			until not SpectatePlys;
			workspace.Camera.CameraSubject = plr.Character.Humanoid;
		end);
	end,
});
Player:AddSection({ "Aimbot" });
Player:AddToggle({
	Name = "Aimbot Camera",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.AimCam = I;
	end,
});
task.spawn(function()
	while task.wait(Sec) do
		pcall(function()
			if _G.AimCam then
				local I = workspace.CurrentCamera;
				closestplayer = function()
						local I = math.huge;
						local e = nil;
						for K, n in next, ply:GetPlayers() do
							if n ~= plr then
								if n.Character and (n.Character:FindFirstChild("Head") and (_G.AimCam and n.Character.Humanoid.Health > 0)) then
									local K = (n.Character.Head.Position - plr.Character.Head.Position).Magnitude;
									if K < I then
										I = K;
										e = n;
									end;
								end;
							end;
						end;
						return e;
					end;
				repeat
					task.wait();
					I.CFrame = CFrame.new(I.CFrame.Position, (closestplayer()).Character.HumanoidRootPart.Position);
				until _G.AimCam == false or Mag > dist;
			end;
		end);
	end;
end);
local SilentAim_Enabled = false;
Player:AddToggle({
	Name = "Aimbot K\196\169 n\196\131ng",
	Description = "",
	Default = false,
	Callback = function(state)
		SilentAim_Enabled = state;
	end,
});
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local RS = game:GetService("ReplicatedStorage");
local player = Players.LocalPlayer;
local camera = workspace.CurrentCamera;
local PredictionEnabled = true;
local PredictionAmount = .1;
local maxRange = 1000;
local renderConnection = nil;
local currentTool = nil;
local PlayersPosition = nil;
local Selectedplayer = nil;
local characterConnections = {};
local function getHRP(model)
	return model and model:FindFirstChild("HumanoidRootPart");
end;
local function clearConnections()
	for _, c in ipairs(characterConnections) do
		pcall(function()
			c:Disconnect();
		end);
	end;
	characterConnections = {};
end;
local function isEnemy(plr)
	if not plr or plr == player then
		return false;
	end;
	if not player.Team or not plr.Team then
		return true;
	end;
	return player.Team ~= plr.Team;
end;
local function getPredictedPosition(hrp)
	if not hrp then
		return nil;
	end;
	local hum = hrp.Parent:FindFirstChildWhichIsA("Humanoid");
	if not hum or not PredictionEnabled or hum.WalkSpeed < 5 then
		return hrp.Position;
	end;
	return hrp.Position + hrp.Velocity * PredictionAmount;
end;
local function getClosestPlayer(lpHRP)
	local closest, dist = nil, math.huge;
	for _, plr in ipairs(Players:GetPlayers()) do
		if isEnemy(plr) and plr.Character then
			local hum = plr.Character:FindFirstChildWhichIsA("Humanoid");
			local hrp = getHRP(plr.Character);
			if hum and (hum.Health > 0 and hrp) then
				local d = (hrp.Position - lpHRP.Position).Magnitude;
				if d < dist and d <= maxRange then
					dist = d;
					closest = plr;
				end;
			end;
		end;
	end;
	return closest;
end;
local function isSkillReadyForTool(toolName)
	if not toolName then
		return false;
	end;
	local gui = player:FindFirstChild("PlayerGui");
	if not gui then
		return false;
	end;
	local skills = gui:FindFirstChild("Main") and gui.Main:FindFirstChild("Skills");
	if not skills then
		return false;
	end;
	local tool = skills:FindFirstChild(toolName);
	if not tool then
		return false;
	end;
	for _, key in ipairs({
		"Z",
		"X",
		"C",
		"V",
	}) do
		local skill = tool:FindFirstChild(key);
		if skill and skill:FindFirstChild("Cooldown") then
			if skill.Cooldown.Size.X.Scale == 1 then
				return true;
			end;
		end;
	end;
	return false;
end;
local function startRender()
	if renderConnection then
		return;
	end;
	renderConnection = RunService.RenderStepped:Connect(function()
			if not SilentAim_Enabled then
				return;
			end;
			local char = player.Character;
			local hrp = char and getHRP(char);
			if not hrp then
				return;
			end;
			local target = Selectedplayer or getClosestPlayer(hrp);
			if not (target and target.Character) then
				PlayersPosition = nil;
				return;
			end;
			local thrp = getHRP(target.Character);
			if not thrp then
				return;
			end;
			PlayersPosition = getPredictedPosition(thrp);
			if currentTool and isSkillReadyForTool(currentTool.Name) then
				local look = (Vector3.new(PlayersPosition.X, hrp.Position.Y, PlayersPosition.Z) - hrp.Position).Unit;
				hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + look);
			end;
		end);
end;
local function stopRender()
	if renderConnection then
		renderConnection:Disconnect();
		renderConnection = nil;
	end;
end;
player.CharacterAdded:Connect(function(char)
	clearConnections();
	table.insert(characterConnections, char.ChildAdded:Connect(function(obj)
		if obj:IsA("Tool") then
			currentTool = obj;
		end;
	end));
end);
pcall(function()
	local mt = getrawmetatable(game);
	setreadonly(mt, false);
	local old = mt.__namecall;
	mt.__namecall = newcclosure(function(self, ...)
			local method = getnamecallmethod();
			local args = { ... };
			if (method == "FireServer" or method == "InvokeServer") and (SilentAim_Enabled and (PlayersPosition and typeof(args[1]) == "Vector3")) then
				args[1] = PlayersPosition;
				return old(self, unpack(args));
			end;
			return old(self, ...);
		end);
	setreadonly(mt, true);
end);
RunService.RenderStepped:Connect(function()
	if SilentAim_Enabled then
		startRender();
	else
		stopRender();
	end;
end);
Player:AddSection({ "T\225\187\145c \196\144\225\187\153 / Nh\225\186\163y" });
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local plr = Players.LocalPlayer;
local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") or nil;
plr.CharacterAdded:Connect(function(char)
	humanoid = char:WaitForChild("Humanoid");
end);
local SpeedEnabled = false;
local JumpEnabled = false;
local desiredSpeed = 16;
local desiredJump = 50;
local function protectSpeed()
	if humanoid then
		(humanoid:GetPropertyChangedSignal("WalkSpeed")):Connect(function()
			if SpeedEnabled and humanoid.WalkSpeed ~= desiredSpeed then
				humanoid.WalkSpeed = desiredSpeed;
			end;
		end);
	end;
end;
local function applyStats()
	if humanoid then
		if SpeedEnabled then
			humanoid.WalkSpeed = desiredSpeed;
		end;
		if JumpEnabled then
			humanoid.JumpPower = desiredJump;
		end;
	end;
end;
RunService.Heartbeat:Connect(function()
	if humanoid then
		if SpeedEnabled and humanoid.WalkSpeed ~= desiredSpeed then
			humanoid.WalkSpeed = desiredSpeed;
		end;
		if JumpEnabled and humanoid.JumpPower ~= desiredJump then
			humanoid.JumpPower = desiredJump;
		end;
	end;
end);
plr.CharacterAdded:Connect(function(char)
	humanoid = char:WaitForChild("Humanoid");
	protectSpeed();
end);
protectSpeed();
Player:AddToggle({
	Name = "B\225\186\173t Ch\225\187\137nh t\225\187\145c \196\145\225\187\153",
	Description = "",
	Default = false,
	Callback = function(Value)
		SpeedEnabled = Value;
		applyStats();
	end,
});
Player:AddTextBox({
	Name = "T\225\187\145c \196\145\225\187\153",
	Description = "Nh\225\186\173p t\225\187\145c \196\145\225\187\153 b\225\186\161n mu\225\187\145n",
	PlaceHolder = "16",
	Default = tostring(desiredSpeed),
	Callback = function(Value)
		local num = tonumber(Value);
		if num then
			desiredSpeed = num;
			applyStats();
		end;
	end,
});
Player:AddToggle({
	Name = "B\225\186\173t ch\225\187\137nh nh\225\186\163y",
	Description = "",
	Default = false,
	Callback = function(Value)
		JumpEnabled = Value;
		applyStats();
	end,
});
Player:AddTextBox({
	Name = "\196\144\225\187\153 cao",
	Description = "Nh\225\186\173p \196\145\225\187\153 cao khi nh\225\186\163y",
	PlaceHolder = "50",
	Default = tostring(desiredJump),
	Callback = function(Value)
		local num = tonumber(Value);
		if num then
			desiredJump = num;
			applyStats();
		end;
	end,
});
Player:AddSection({ "C\195\160i \196\145\225\186\183t LocalPlayer / Kh\195\161c" });
Player:AddToggle({
	Name = "T\225\187\153c th\225\187\143 v3 v\195\180 h\225\186\161n",
	Description = "",
	Default = false,
	Callback = function(I)
		InfAblities = I;
	end,
});
spawn(function()
	while wait(.2) do
		pcall(function()
			if InfAblities then
				if not plr.Character.HumanoidRootPart:FindFirstChild("Agility") then
					local I = replicated.FX.Agility:Clone();
					I.Name = "Agility";
					I.Parent = plr.Character.HumanoidRootPart;
				end;
			else
				plr.Character.HumanoidRootPart.Agility:Destroy();
			end;
		end);
	end;
end);
Player:AddToggle({
	Name = "N\196\131ng l\198\176\225\187\163ng v\195\180 h\225\186\161n",
	Description = "",
	Default = false,
	Callback = function(I)
		infEnergy = I;
		if I then
			getInfinity_Ability("Energy", infEnergy);
		end;
	end,
});
Player:AddToggle({
	Name = "T\225\187\145c bi\225\186\191n v\195\180 h\225\186\161n",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.InfSoru = I;
		if I then
			getInfinity_Ability("Soru", _G.InfSoru);
		end;
	end,
});
Player:AddToggle({
	Name = "Haki quan s\195\161t v\195\180 h\225\186\161n",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.InfiniteObRange = I;
		if I then
			getInfinity_Ability("Observation", _G.InfiniteObRange);
		end;
	end,
});
Player:AddSection({ "C\195\160i \196\145\225\186\183t Chi\225\186\191n \196\145\225\186\165u / C\195\160i \196\145\225\186\183t Aimbot" });
Player:AddToggle({
	Name = "B\225\187\143 qua c\195\185ng team",
	Description = "b\225\186\173t ch\225\186\191 \196\145\225\187\153 b\225\187\143 qua kh\195\180ngi aimbot c\195\185ng \196\145\225\187\153i",
	Default = false,
	Callback = function(I)
		_G.NoAimTeam = I;
	end,
});
Player:AddToggle({
	Name = "Ch\225\186\165p nh\225\186\173n \196\145\225\187\147ng minh",
	Description = "b\225\186\173t ch\225\186\191 \196\145\225\187\153 t\225\187\177 \196\145\225\187\153ng ch\225\186\165p nh\225\186\173n \196\145\225\187\147ng minh",
	Default = false,
	Callback = function(I)
		_G.AcceptAlly = I;
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.AcceptAlly then
			pcall(function()
				for I, e in pairs(ply:GetChildren()) do
					if e.Name ~= plr.Name and (e:FindFirstChild("Humanoid") and e:FindFirstChild("HumanoidRootPart")) then
						((replicated:WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("AcceptAlly", e.Name);
					end;
				end;
			end);
		end;
	end;
end);
Teleport:AddSection({ "D\225\187\139ch chuy\225\187\131n - Th\225\186\191 gi\225\187\155i" });
Teleport:AddButton({ Name = "D\225\187\139ch chuy\225\187\131n \196\145\225\186\191n Sea 1", Description = "", Callback = function()
		replicated.Remotes.CommF_:InvokeServer("TravelMain");
	end });
Teleport:AddButton({ Name = "D\225\187\139ch chuy\225\187\131n \196\145\225\186\191n sea 2", Description = "", Callback = function()
		replicated.Remotes.CommF_:InvokeServer("TravelDressrosa");
	end });
Teleport:AddButton({ Name = "D\225\187\139ch chuy\225\187\131n \196\145\225\186\191n Sea 3", Description = "", Callback = function()
		replicated.Remotes.CommF_:InvokeServer("TravelZou");
	end });
Teleport:AddSection({ "D\225\187\139ch chuy\225\187\131n - \196\144\225\186\163o" });
Location = {};
for _, e in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
	table.insert(Location, e.Name);
end;
Teleport:AddDropdown({
	Name = "Ch\225\187\141n \196\145\225\186\163o",
	Description = "",
	Options = Location,
	Default = false,
	Multi = false,
	Callback = function(I)
		_G.Island = I;
	end,
});
Teleport:AddToggle({
	Name = "Auto bay \196\145\225\186\191n \196\145\225\186\163o",
	Description = "",
	Default = false,
	Callback = function(Value)
		_G.Teleport = Value;
		if Value then
			local targetIsland = workspace._WorldOrigin.Locations:FindFirstChild(_G.Island);
			if targetIsland then
				spawn(function()
					Root.CFrame = Root.CFrame * CFrame.new(0, 700, 0);
					wait(.1);
					local destination = targetIsland.CFrame * CFrame.new(0, 700, 0);
					repeat
						wait();
						_tp(destination);
					until not _G.Teleport or (Root.Position - destination.p).Magnitude < 10;
					if _G.Teleport then
						Root.CFrame = targetIsland.CFrame * CFrame.new(0, 5, 0);
					end;
					_G.Teleport = false;
				end);
			else
				print("Selecione uma ilha primeiro!");
				_G.Teleport = false;
			end;
		end;
	end,
});
Teleport:AddSection({ "D\225\187\139ch chuy\225\187\131n - C\225\187\149ng" });
if World1 then
	Location_Portal = { "Sky", "UnderWater" };
elseif World2 then
	Location_Portal = { "SwanRoom", "Cursed Ship" };
elseif World3 then
	Location_Portal = {
			"Castle On The Sea",
			"Mansion Cafe",
			"Hydra Teleport",
			"Canvendish Room",
			"Temple of Time",
		};
end;
Teleport:AddDropdown({
	Title = "Ch\225\187\141n c\225\187\149ng",
	Description = "",
	Options = Location_Portal,
	Default = false,
	Multi = false,
	Callback = function(I)
		_G.Island_PT = I;
	end,
});
Teleport:AddButton({ Name = "D\225\187\139ch Chuy\225\187\131n T\225\187\169c Th\225\187\157i", Description = "", Callback = function()
		if _G.Island_PT == "Sky" then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894, 5547, -380));
		elseif _G.Island_PT == "UnderWater" then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163, 11, 1819));
		elseif _G.Island_PT == "SwanRoom" then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2285, 15, 905));
		elseif _G.Island_PT == "Cursed Ship" then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923, 126, 32852));
		elseif _G.Island_PT == "Castle On The Sea" then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-008, .914313197, -1.90943332e-008, 1, 3.8755779e-008, -0.914313197, -1.76180437e-009, -0.405007899));
		elseif _G.Island_PT == "Mansion Cafe" then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375));
		elseif _G.Island_PT == "Hydra Teleport" then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5643.4526367188, 1013.0858154297, -340.51025390625));
		elseif _G.Island_PT == "Canvendish Room" then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5314.5463867188, 22.562219619751, -127.06755065918));
		elseif _G.Island_PT == "Temple of Time" then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28310.0234, 14895.1123, 109.456741, -0.469690144, -2.85620132e-008, -0.882831335, -3.23509219e-008, 1, -1.51411736e-008, .882831335, 2.14487486e-008, -0.469690144));
		end;
	end });
Teleport:AddSection("D\225\187\139ch chuy\225\187\131n - Npc");
for I, e in pairs(replicated.NPCs:GetChildren()) do
	table.insert(NPCList, e.Name);
end;
Teleport:AddDropdown({
	Name = "Ch\225\187\141n NPCs",
	Description = "",
	Options = NPCList,
	Default = false,
	Multi = false,
	Callback = function(I)
		NPClist = I;
	end,
});
Teleport:AddToggle({
	Name = "Bay \196\145\225\186\191n  NPCs",
	Description = "T\225\187\177 \196\145\225\187\153ng d\225\187\139ch chuy\225\187\131n \196\145\225\186\191n NPC",
	Default = false,
	Callback = function(I)
		_G.TPNpc = I;
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.TPNpc then
			pcall(function()
				for I, e in pairs(replicated.NPCs:GetChildren()) do
					if e.Name == NPClist then
						_tp(e.HumanoidRootPart.CFrame);
					end;
				end;
			end);
		end;
	end;
end);
if World3 then
	Get:AddSection({ "S\195\186ng Skull Guitar" });
	Get:AddToggle({
		Name = "Auto s\195\186ng Skull Guitar",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Auto_Soul_Guitar = I;
		end,
	});
	task.spawn(function()
		while wait() do
			if _G.Auto_Soul_Guitar then
				pcall(function()
					local I = GetConnectionEnemies("Living Zombie");
					if I then
						I.HumanoidRootPart.CFrame = CFrame.new(-10138.397460938, 138.65246582031, 5902.8920898438);
						I.Head.CanCollide = false;
						I.Humanoid.Sit = false;
						I.HumanoidRootPart.CanCollide = false;
						I.Humanoid.JumpPower = 0;
						I.Humanoid.WalkSpeed = 0;
						if I.Humanoid:FindFirstChild("Animator") then
							(I.Humanoid:FindFirstChild("Animator")):Destroy();
						end;
					end;
				end);
			end;
		end;
	end);
	function getT(I)
		local e;
		if I == 1 then
			e = workspace.Map["Haunted Castle"].Tablet.Segment1.Line.Rotation;
		elseif I == 3 then
			e = workspace.Map["Haunted Castle"].Tablet.Segment3.Line.Rotation;
		elseif I == 4 then
			e = workspace.Map["Haunted Castle"].Tablet.Segment4.Line.Rotation;
		elseif I == 7 then
			e = workspace.Map["Haunted Castle"].Tablet.Segment7.Line.Rotation;
		elseif I == 10 then
			e = workspace.Map["Haunted Castle"].Tablet.Segment10.Line.Rotation;
		end;
		if e then
			return e.Z;
		end;
	end;
	function getRT(I)
		local e = workspace.Map["Haunted Castle"].Trophies.Quest;
		local K;
		for e, n in pairs(e:GetChildren()) do
			if I == 1 and (n.Name == "Trophy1" and n:FindFirstChild("Handle")) then
				K = n.Handle.Rotation;
			elseif I == 2 and (n.Name == "Trophy2" and n:FindFirstChild("Handle")) then
				K = n.Handle.Rotation;
			elseif I == 3 and (n.Name == "Trophy3" and n:FindFirstChild("Handle")) then
				K = n.Handle.Rotation;
			elseif I == 4 and (n.Name == "Trophy4" and n:FindFirstChild("Handle")) then
				K = n.Handle.Rotation;
			elseif I == 5 and (n.Name == "Trophy5" and n:FindFirstChild("Handle")) then
				K = n.Handle.Rotation;
			end;
			if K then
				return K.Z;
			end;
		end;
	end;
	GetFirePlacard = function(I, e)
			if tostring(workspace.Map["Haunted Castle"]["Placard" .. I][e].Indicator.BrickColor) ~= "Pearl" then
				fireclickdetector(workspace.Map["Haunted Castle"]["Placard" .. I][e].ClickDetector);
			end;
		end;
	spawn(function()
		repeat
			task.wait();
		until _G.Auto_Soul_Guitar;
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Soul_Guitar then
					if World3 then
						replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2);
						replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true);
						if replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check") == nil then
							_tp(CFrame.new(-8655.0166015625, 141.31669616699, 6160.0224609375));
							replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2);
							replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true);
						elseif (replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check")).Swamp == false then
							Quest1 = true;
							Quest2 = false;
							Quest3 = false;
							Quest4 = false;
							local I = GetConnectionEnemies("Living Zombie");
							if I then
								repeat
									task.wait();
									G.Kill(I, _G.Auto_Soul_Guitar);
								until not _G.Auto_Soul_Guitar or I.Humanoid.Health <= 0 or not I.Parent or workspace.Map["Haunted Castle"].SwampWater.Color ~= Color3.fromRGB(117, 0, 0);
							else
								_tp(CFrame.new(-10170.727539062, 138.65246582031, 5934.2651367188));
							end;
						elseif (replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check")).Gravestones == false then
							Quest1 = false;
							Quest2 = true;
							Quest3 = false;
							Quest4 = false;
							GetFirePlacard("7", "Left");
							GetFirePlacard("6", "Left");
							GetFirePlacard("5", "Left");
							GetFirePlacard("4", "Right");
							GetFirePlacard("3", "Left");
							GetFirePlacard("2", "Right");
							GetFirePlacard("1", "Right");
						elseif (replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check")).Ghost == false then
							replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost");
							replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost", true);
						elseif (replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check")).Trophies == false then
							Quest1 = false;
							Quest2 = false;
							Quest3 = true;
							Quest4 = false;
							_tp(CFrame.new(-9532.8232421875, 6.471667766571, 6078.068359375));
							repeat
								wait();
								local I = getRT(1);
								local e = getT(1);
								if I and e then
									fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector"));
								end;
							until I == e;
							repeat
								wait();
								local I = getRT(2);
								local e = getT(3);
								if I and e then
									fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment3:FindFirstChild("ClickDetector"));
								end;
							until I == e;
							repeat
								wait();
								local I = getRT(3);
								local e = getT(4);
								if I and e then
									fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment4:FindFirstChild("ClickDetector"));
								end;
							until I == e;
							repeat
								wait();
								local I = getRT(4);
								local e = getT(7);
								if I and e then
									fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment7:FindFirstChild("ClickDetector"));
								end;
							until I == e;
							repeat
								wait();
								local I = getRT(5);
								local e = getT(10);
								if I and e then
									fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment10:FindFirstChild("ClickDetector"));
								end;
							until I == e;
							repeat
								wait();
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment2:FindFirstChild("ClickDetector"));
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment5:FindFirstChild("ClickDetector"));
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment6:FindFirstChild("ClickDetector"));
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment8:FindFirstChild("ClickDetector"));
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment9:FindFirstChild("ClickDetector"));
							until workspace.Map["Haunted Castle"].Tablet.Segment2.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment5.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment6.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment8.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment9.Line.Rotation.Z == 0;
						elseif (replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check")).Pipes == false then
							Quest1 = false;
							Quest2 = false;
							Quest3 = false;
							Quest4 = true;
							_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.CFrame);
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.ClickDetector);
							_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.CFrame);
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector);
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector);
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector);
							_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.CFrame);
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector);
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector);
							_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.CFrame);
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.ClickDetector);
							_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.CFrame);
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector);
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector);
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector);
						end;
					end;
				end;
			end);
		end;
	end);
end;
if World2 or World3 then
	Get:AddToggle({
		Name = "Auto c\195\160y nguy\195\170n li\225\187\135u s\195\186ng Skull Guitar",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.AutoMatSoul = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.AutoMatSoul and GetWP("Skull Guitar") == false then
					if GetM("Bones") >= 500 and (GetM("Ectoplasm") >= 250 and GetM("Dark Fragment") >= 1) then
						replicated.Remotes.CommF_:InvokeServer("soulGuitarBuy", true);
					else
						if GetM("Ectoplasm") <= 250 then
							if _G.AutoMatSoul and World2 then
								local I = {
										"Ship Deckhand",
										"Ship Engineer",
										"Ship Steward",
										"Ship Officer",
										"Arctic Warrior",
									};
								local e = GetConnectionEnemies(I);
								if e then
									repeat
										task.wait();
										G.Kill(e, _G.AutoMatSoul);
									until not _G.AutoMatSoul or not e.Parent or e.Humanoid.Health <= 0;
								else
									replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
								end;
							else
								replicated.Remotes.CommF_:InvokeServer("TravelDressrosa");
							end;
						elseif GetM("Dark Fragment") < 1 then
							if _G.AutoMatSoul and World2 then
								local I = GetConnectionEnemies("Darkbeard");
								if I then
									repeat
										task.wait();
										G.Kill(I, _G.AutoMatSoul);
									until _G.AutoMatSoul or I.Humanoid.Health <= 0;
								else
									_tp(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625));
								end;
							else
								replicated.Remotes.CommF_:InvokeServer("TravelDressrosa");
							end;
							if not GetConnectionEnemies("Darkbeard") then
								Hop();
							end;
						elseif GetM("Bones") <= 500 then
							if _G.AutoMatSoul and World3 then
								local I = {
										"Reborn Skeleton",
										"Living Zombie",
										"Demonic Soul",
										"Posessed Mummy",
									};
								local e = GetConnectionEnemies(I);
								if e then
									repeat
										task.wait();
										G.Kill(e, _G.AutoMatSoul);
									until not _G.AutoMatSoul or e.Humanoid.Health <= 0 or not e.Parent or e.Humanoid.Health <= 0;
								else
									_tp(CFrame.new(-9504.8564453125, 172.14292907715, 6057.259765625));
								end;
							else
								replicated.Remotes.CommF_:InvokeServer("TravelZou");
							end;
						end;
					end;
				end;
			end);
		end;
	end);
end;
Get:AddSection({ "Farm th\195\180ng th\225\186\161o" });
local TargetMobs = {
		"Reborn Skeleton",
		"Living Zombie",
		"Demonic Soul",
		"Posessed Mummy",
	};
local FarmPos = CFrame.new(-9513.63867, 164.010269, 5786.66895, -0.0950724334, 9.31791888e-008, .995470345, 7.18874515e-009, 1, -9.29166148e-008, -0.995470345, -1.67762626e-009, -0.0950724334);
local function GetClosestMob()
	local closestDist = math.huge;
	local target = nil;
	local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
	if not hrp then
		return nil;
	end;
	local playerPos = hrp.Position;
	for _, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
		local isTarget = false;
		for _, name in pairs(TargetMobs) do
			if v.Name == name then
				isTarget = true;
				break;
			end;
		end;
		if isTarget and (v:FindFirstChild("Humanoid") and (v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart"))) then
			local dist = (v.HumanoidRootPart.Position - playerPos).Magnitude;
			if dist < closestDist then
				closestDist = dist;
				target = v;
			end;
		end;
	end;
	return target;
end;
Get:AddToggle({
	Name = "Auto c\195\160y 600 th\195\180ng th\225\186\161o \225\187\159 ki\225\186\191m",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.FarmMastery_S = I;
	end,
});
spawn(function()
	while wait(.1) do
		if _G.FarmMastery_S then
			pcall(function()
				local character = game.Players.LocalPlayer.Character;
				if not character or not character:FindFirstChild("HumanoidRootPart") then
					return;
				end;
				local Target = GetClosestMob();
				if not Target then
					local distToArea = (character.HumanoidRootPart.Position - FarmPos.Position).Magnitude;
					if distToArea > 150 then
						_tp(FarmPos);
						wait(.5);
					end;
				end;
				for _, e in next, replicated.Remotes.CommF_:InvokeServer("getInventory") do
					if type(e) == "table" and e.Type == "Sword" then
						local SwordName = e.Name;
						local Mastery = tonumber(e.Mastery) or 0;
						if Mastery < 600 then
							if GetBP(SwordName) then
								if Target then
									repeat
										wait();
										if _G.FarmMastery_S and (Target and (Target:FindFirstChild("HumanoidRootPart") and Target.Humanoid.Health > 0)) then
											G.Sword(Target, _G.FarmMastery_S);
										end;
									until not _G.FarmMastery_S or not Target.Parent or Target.Humanoid.Health <= 0;
								end;
							else
								replicated.Remotes.CommF_:InvokeServer("LoadItem", SwordName);
							end;
							break;
						end;
					end;
				end;
			end);
		end;
	end;
end);
if World3 then
	Get:AddSection({ "Song ki\225\186\191m b\225\187\139 nguy\225\187\129n r\225\187\167a" });
	local I5 = Get:AddParagraph({ Title = " Nhi\225\187\135m v\225\187\165 song ki\225\186\191m b\225\187\139 nguy\225\187\129n r\225\187\167a ", Content = "Nhi\225\187\135m V\225\187\165 :" });
	spawn(function()
		while wait(.2) do
			if QuestYama_1 == true then
				I5:SetDesc(" Nhi\225\187\135m v\225\187\165 : yama quest 1");
			elseif QuestYama_2 == true then
				I5:SetDesc(" Nhi\225\187\135m v\225\187\165 : yama quest 2");
			elseif QuestYama_3 == true then
				I5:SetDesc(" Nhi\225\187\135m v\225\187\165 : yama quest 3");
			elseif QuestTushita_1 == true then
				I5:SetDesc(" Nhi\225\187\135m v\225\187\165 : tushita quest 1");
			elseif QuestTushita_2 == true then
				I5:SetDesc(" Nhi\225\187\135m v\225\187\165 : tushita quest 2");
			elseif QuestTushita_1 == true then
				I5:SetDesc(" Nhi\225\187\135m v\225\187\165 : tushita quest 2");
			elseif GetWP("Cursed Dual Katana") then
				I5:SetDesc(" Quest Numbers: CDK Ho\195\160n Th\195\160nh!!");
			end;
		end;
	end);
	Get:AddToggle({
		Name = "Auto L\225\186\165y CDK [ Nhi\225\187\135m v\225\187\165 cu\225\187\145i c\195\185ng ]",
		Description = "",
		Default = GetSetting("AutoCDK_Save", false),
		Callback = function(I)
			_G.CDK = I;
			_G.SaveData.AutoCDK_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.CDK then
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Boss");
					local I = GetConnectionEnemies("Cursed Skeleton Boss");
					if I then
						repeat
							wait();
							if plr.Character:FindFirstChild("Yama") or plr.Backpack:FindFirstChild("Yama") then
								EquipWeapon("Yama");
							elseif plr.Character:FindFirstChild("Tushita") or plr.Backpack:FindFirstChild("Tushita") then
								EquipWeapon("Tushita");
							end;
							_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0));
						until not _G.CDK or not I.Parent or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(-12318.193359375, 601.95184326172, -6538.662109375));
						wait(.5);
						_tp(workspace.Map.Turtle.Cursed.BossDoor.CFrame);
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto nhi\225\187\135m v\225\187\165 Yama CDK",
		Description = "",
		Default = GetSetting("AutoYamaCDK_Save", false),
		Callback = function(I)
			_G.CDK_YM = I;
			_G.SaveData.AutoYamaCDK_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait() do
			pcall(function()
				if _G.CDK_YM then
					if tostring(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor");
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true);
					else
						if (replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Finished == nil then
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil");
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil");
						elseif (replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Finished == false then
							if tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == -3 then
								QuestYama_1 = true;
								QuestYama_2 = false;
								QuestYama_3 = false;
								repeat
									task.wait();
									if not workspace.Enemies:FindFirstChild("Forest Pirate") then
										_tp(CFrame.new(-13223.521484375, 428.19381713867, -7766.0678710938));
									else
										local I = GetConnectionEnemies("Forest Pirate");
										if I then
											_tp((workspace.Enemies:FindFirstChild("Forest Pirate")).HumanoidRootPart.CFrame);
										end;
									end;
								until tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == 1 or not _G.CDK_YM;
							elseif tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == -4 then
								QuestYama_1 = false;
								QuestYama_2 = true;
								QuestYama_3 = false;
								for I, e in pairs((game:GetService("Players")).LocalPlayer.QuestHaze:GetChildren()) do
									for I, K in pairs(w) do
										if string.find(I, e.Name) and e.Value > 0 then
											if (K.Position - Root.Position).Magnitude <= 1000 and workspace.Enemies:FindFirstChild(I) then
												for I, e in pairs(workspace.Enemies:GetChildren()) do
													if e:FindFirstChild("HumanoidRootPart") and (e:FindFirstChild("Humanoid") and ((e:FindFirstChild("Humanoid")).Health > 0 and e:FindFirstChild("HazeESP"))) then
														repeat
															wait();
															G.Kill(e, _G.CDK_YM);
														until not _G.CDK_YM or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == 2 or not e:FindFirstChild("HazeESP") or e.Humanoid.Health <= 0;
													end;
												end;
											else
												_tp(K);
											end;
										end;
									end;
								end;
							elseif tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == -5 then
								QuestYama_1 = false;
								QuestYama_2 = false;
								QuestYama_3 = true;
								if workspace.Map:FindFirstChild("HellDimension") then
									if (Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000 then
										for I, e in pairs(workspace.Map.HellDimension.Exit:GetChildren()) do
											if tonumber(I) == 2 then
												repeat
													task.wait();
													Root.CFrame = workspace.Map.HellDimension.Exit.CFrame;
												until not _G.CDK_YM or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == 3;
											end;
										end;
										EquipWeapon(_G.SelectWeapon);
										if tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) ~= 3 then
											repeat
												task.wait();
												repeat
													task.wait();
													_tp(workspace.Map.HellDimension.Torch1.Particles.CFrame);
													for I, e in pairs(workspace.Map.HellDimension:GetDescendants()) do
														if e:IsA("ProximityPrompt") then
															fireproximityprompt(e);
														end;
													end;
												until (workspace.Map.HellDimension.Torch1.Particles.Position - Root.Position).Magnitude < 5;
												wait(2);
												_G.T1Yama = true;
											until not _G.CDK_YM or _G.T1Yama or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == 3;
											repeat
												task.wait();
												repeat
													task.wait();
													_tp(workspace.Map.HellDimension.Torch2.Particles.CFrame);
													for I, e in pairs(workspace.Map.HellDimension:GetDescendants()) do
														if e:IsA("ProximityPrompt") then
															fireproximityprompt(e);
														end;
													end;
												until (workspace.Map.HellDimension.Torch2.Particles.Position - Root.Position).Magnitude < 5;
												wait(2);
												_G.T2Yama = true;
											until _G.T2Yama or _G.CDK_YM == false or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == 3;
											repeat
												wait();
												repeat
													task.wait();
													_tp(workspace.Map.HellDimension.Torch3.Particles.CFrame);
													for I, e in pairs(workspace.Map.HellDimension:GetDescendants()) do
														if e:IsA("ProximityPrompt") then
															fireproximityprompt(e);
														end;
													end;
												until (workspace.Map.HellDimension.Torch3.Particles.Position - Root.Position).Magnitude < 5;
												wait(2);
												_G.T3Yama = true;
											until _G.T3Yama or _G.CDK_YM == false or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == 3;
										end;
										for I, e in pairs(workspace.Enemies:GetChildren()) do
											if ((e:FindFirstChild("HumanoidRootPart")).Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 300 then
												if e:FindFirstChild("HumanoidRootPart") and (e:FindFirstChild("Humanoid") and (e:FindFirstChild("Humanoid")).Health > 0) then
													repeat
														task.wait();
														G.Kill(e, _G.CDK_YM);
													until not _G.CDK_YM or e.Humanoid.Health <= 0 or not e.Parent or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == 3;
												end;
											end;
										end;
									end;
								end;
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait() do
			pcall(function()
				if _G.CDK_YM then
					if tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == -5 then
						if not workspace.Map:FindFirstChild("HellDimension") or (Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude > 1000 then
							local I = GetConnectionEnemies("Soul Reaper");
							if I then
								repeat
									task.wait();
									_tp(I.HumanoidRootPart.CFrame);
								until I.Humanoid.Health <= 0 or not _G.CDK_YM or not I.Parent or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Evil) == 3 or workspace.Map:FindFirstChild("HellDimension") and (Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000;
							elseif plr.Backpack:FindFirstChild("Hallow Essence") or plr.Character:FindFirstChild("Hallow Essence") then
								repeat
									_tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125));
									task.wait();
								until ((CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125)).Position - Root.Position).Magnitude <= 8;
								EquipWeapon("Hallow Essence");
							elseif replicated:FindFirstChild("Soul Reaper") and (replicated:FindFirstChild("Soul Reaper")).Humanoid.Health > 0 then
								_tp((replicated:FindFirstChild("Soul Reaper")).HumanoidRootPart.CFrame);
							else
								if replicated.Remotes.CommF_:InvokeServer("Bones", "Check") < 50 and (not workspace.Enemies:FindFirstChild("Soul Reaper") and (not replicated:FindFirstChild("Soul Reaper") and not workspace.Map:FindFirstChild("HellDimension"))) then
									if workspace.Enemies:FindFirstChild("Reborn Skeleton") or workspace.Enemies:FindFirstChild("Living Zombie") or workspace.Enemies:FindFirstChild("Domenic Soul") or workspace.Enemies:FindFirstChild("Posessed Mummy") then
										for I, e in pairs(workspace.Enemies:GetChildren()) do
											if e.Name == "Reborn Skeleton" or e.Name == "Living Zombie" or e.Name == "Demonic Soul" or e.Name == "Posessed Mummy" then
												if e:FindFirstChild("HumanoidRootPart") and (e:FindFirstChild("Humanoid") and (e:FindFirstChild("Humanoid")).Health > 0) then
													repeat
														task.wait();
														G.Kill(e, _G.CDK_YM);
													until not _G.CDK_YM or e.Humanoid.Health <= 0 or not e.Parent;
												end;
											end;
										end;
									else
										_tp(CFrame.new(-9515.2255859375, 164.00622558594, 5785.3833007812));
									end;
								else
									replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1);
								end;
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto nhi\225\187\135m v\225\187\165 Tushita CDK",
		Description = "",
		Default = GetSetting("AutoTushitaCDK_Save", false),
		Callback = function(I)
			_G.CDK_TS = I;
			_G.SaveData.AutoTushitaCDK_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait() do
			pcall(function()
				if _G.CDK_TS then
					if tostring(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
						wait(.7);
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor");
						wait(.3);
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true);
					else
						if (replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Finished == nil then
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good");
						elseif (replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Finished == false then
							if tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Good) == -3 then
								QuestTushita_1 = true;
								QuestTushita_2 = false;
								QuestTushita_3 = false;
								repeat
									wait();
									_tp(CFrame.new(-4602.5107421875, 16.446542739868, -2880.998046875));
								until ((CFrame.new(-4602.5107421875, 16.446542739868, -2880.998046875)).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CDK_TS or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Good) == 1;
								if ((CFrame.new(-4602.5107421875, 16.446542739868, -2880.998046875)).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
									wait(.7);
									replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check");
									wait(.5);
									replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"));
								end;
								wait(1);
								repeat
									wait();
									_tp(CFrame.new(4001.1853027344, 10.089399337769, -2654.86328125));
								until ((CFrame.new(4001.1853027344, 10.089399337769, -2654.86328125)).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CDK_TS or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Good) == 1;
								if ((CFrame.new(4001.1853027344, 10.089399337769, -2654.86328125)).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
									wait(.7);
									replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check");
									wait(.5);
									replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"));
								end;
								wait(1);
								repeat
									wait();
									_tp(CFrame.new(-9530.763671875, 7.2452087402344, -8375.5087890625));
								until ((CFrame.new(-9530.763671875, 7.2452087402344, -8375.5087890625)).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CDK_TS or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Good) == 1;
								if ((CFrame.new(-9530.763671875, 7.2452087402344, -8375.5087890625)).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
									wait(.7);
									replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check");
									wait(.5);
									replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"));
								end;
								wait(1);
							elseif tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Good) == -4 then
								QuestTushita_1 = false;
								QuestTushita_2 = true;
								QuestTushita_3 = false;
								repeat
									wait();
									_G.AutoRaidCastle = true;
								until not _G.CDK_TS or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Good) == 2;
								_G.AutoRaidCastle = false;
							elseif tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Good) == -5 then
								QuestTushita_1 = false;
								QuestTushita_2 = false;
								QuestTushita_3 = true;
								if workspace.Enemies:FindFirstChild("Cake Queen") then
									for I, e in pairs(workspace.Enemies:GetChildren()) do
										if e.Name == "Cake Queen" then
											if e:FindFirstChild("Humanoid") and (e:FindFirstChild("HumanoidRootPart") and e.Humanoid.Health > 0) then
												repeat
													wait();
													G.Kill(e, _G.CDK_TS);
												until not _G.CDK_TS or not e.Parent or e.Humanoid.Health <= 0 or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Good) == 3;
											end;
										end;
									end;
								elseif replicated:FindFirstChild("Cake Queen") and (replicated:FindFirstChild("Cake Queen")).Humanoid.Health > 0 then
									_tp((replicated:FindFirstChild("Cake Queen")).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
								else
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.HeavenlyDimension.Spawn.Position).Magnitude <= 1000 then
										for I, e in pairs(workspace.Map.HeavenlyDimension.Exit:GetChildren()) do
											Ex = I;
										end;
										if Ex == 2 then
											repeat
												wait();
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.HeavenlyDimension.Exit.CFrame;
											until not _G.CDK_TS or tonumber((replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")).Good) == 3;
										end;
										repeat
											wait();
											repeat
												wait();
												_tp(CFrame.new(-22529.6171875, 5275.7739257812, 3873.5712890625));
												for I, e in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
													if e:IsA("ProximityPrompt") then
														fireproximityprompt(e);
													end;
												end;
											until ((CFrame.new(-22529.6171875, 5275.7739257812, 3873.5712890625)).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5;
											wait(2);
											_G.DoneT1 = true;
										until not _G.CDK_TS or _G.DoneT1;
										repeat
											wait();
											repeat
												wait();
												_tp(CFrame.new(-22637.291015625, 5281.365234375, 3749.2885742188));
												for I, e in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
													if e:IsA("ProximityPrompt") then
														fireproximityprompt(e);
													end;
												end;
											until ((CFrame.new(-22637.291015625, 5281.365234375, 3749.2885742188)).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5;
											wait(2);
											_G.DoneT2 = true;
										until _G.DoneT2 or _G.CDK_TS == false;
										repeat
											wait();
											repeat
												task.wait();
												_tp(CFrame.new(-22791.14453125, 5277.1655273438, 3764.5700683594));
												for I, e in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
													if e:IsA("ProximityPrompt") then
														fireproximityprompt(e);
													end;
												end;
											until ((CFrame.new(-22791.14453125, 5277.1655273438, 3764.5700683594)).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5;
											wait(2);
											_G.DoneT3 = true;
										until _G.DoneT3 or _G.CDK_TS == false;
										for I, e in pairs(workspace.Enemies:GetChildren()) do
											if ((e:FindFirstChild("HumanoidRootPart")).Position - (CFrame.new(-22695.7012, 5270.93652, 3814.42847, .11794927, 3.32185834e-008, .99301964, -8.73070718e-008, 1, -2.30819008e-008, -0.99301964, -8.3975138e-008, .11794927)).Position).Magnitude <= 300 then
												if e:FindFirstChild("HumanoidRootPart") and (e:FindFirstChild("Humanoid") and (e:FindFirstChild("Humanoid")).Health > 0) then
													repeat
														wait();
														G.Kill(e, _G.CDK_TS);
													until not _G.CDK_TS or e.Humanoid.Health <= 0 or not e.Parent;
												end;
											end;
										end;
									end;
								end;
							end;
						end;
					end;
				end;
			end);
		end;
	end);
end;
if World2 then
	Get:AddSection({ "Tam B\225\186\163o Ki\225\186\191m" });
	Get:AddToggle({
		Name = "Auto Mua Ki\225\186\191m Huy\225\187\129n Tho\225\186\161i",
		Description = "",
		Default = GetSetting("TpLegendarySword_Save", false),
		Callback = function(I)
			_G.Tp_LgS = I;
			_G.SaveData.TpLegendarySword_Save = I;
			SaveSettings();
			if I then
				spawn(function()
					while _G.Tp_LgS do
						pcall(function()
							replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1");
							replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2");
							replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3");
						end);
						wait(1);
					end;
				end);
			end;
		end,
	});
	Get:AddToggle({
		Name = "Bay \196\145\225\186\191n Ng\198\176\225\187\157i b\195\161n ki\225\186\191m huy\225\187\129n tho\225\186\161i",
		Description = "",
		Default = GetSetting("TpLegendarySword_Save", false),
		Callback = function(I)
			_G.Tp_LgS = I;
			_G.SaveData.TpLegendarySword_Save = I;
			SaveSettings();
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.Tp_LgS then
				pcall(function()
					for I, e in pairs(replicated.NPCs:GetChildren()) do
						if e.Name == "Legendary Sword Dealer " then
							_tp(e.HumanoidRootPart.CFrame);
						end;
					end;
				end);
			end;
		end;
	end);
	Get:AddSection({ "Law boss" });
	Get:AddToggle({
		Name = "Auto \196\145\195\161nh boss law",
		Description = "",
		Default = false,
		Callback = function(state)
			_G.AutoLawKak = state;
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.AutoLawKak then
				pcall(function()
					replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2");
					fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector);
					local enemy = GetConnectionEnemies("Order");
					if enemy then
						repeat
							task.wait();
							G.Kill(enemy, _G.AutoLawKak);
						until not _G.AutoLawKak or not enemy.Parent or enemy.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875));
					end;
				end);
			end;
		end;
	end);
end;
if World1 then
	Get:AddSection({ "V\225\186\173t ph\225\186\169m sea1" });
	Get:AddToggle({
		Name = "Auto ki\225\186\191m Saw",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.AutoSaw = I;
		end,
	});
	spawn(function()
		while wait(.2) do
			pcall(function()
				if _G.AutoSaw then
					local I = GetConnectionEnemies("The Saw");
					if I then
						repeat
							task.wait();
							G.Kill(I, _G.AutoSaw);
						until _G.AutoSaw == false or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906));
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto Ki\225\186\191m Saber",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.AutoSaber = I;
		end,
	});
	spawn(function()
		while wait(.2) do
			pcall(function()
				if _G.AutoSaber and (plr.Data.Level.Value >= 200 and (not plr.Backpack:FindFirstChild("Saber") and not plr.Character:FindFirstChild("Saber"))) then
					if workspace.Map.Jungle.Final.Part.Transparency == 0 then
						if workspace.Map.Jungle.QuestPlates.Door.Transparency == 0 then
							if ((CFrame.new(-1612.55884, 36.9774132, 148.719543, .37091279, 3.0717151e-009, -0.928667724, 3.97099491e-008, 1, 1.91679348e-008, .928667724, -4.39869794e-008, .37091279)).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 100 then
								_tp(plr.Character.HumanoidRootPart.CFrame);
								wait(.5);
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate1.Button.CFrame;
								wait(.5);
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate2.Button.CFrame;
								wait(.5);
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate3.Button.CFrame;
								wait(.5);
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate4.Button.CFrame;
								wait(.5);
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate5.Button.CFrame;
								wait(.5);
							else
								_tp(CFrame.new(-1612.55884, 36.9774132, 148.719543, .37091279, 3.0717151e-009, -0.928667724, 3.97099491e-008, 1, 1.91679348e-008, .928667724, -4.39869794e-008, .37091279));
							end;
						else
							if workspace.Map.Desert.Burn.Part.Transparency == 0 then
								if plr.Backpack:FindFirstChild("Torch") or plr.Character:FindFirstChild("Torch") then
									EquipWeapon("Torch");
									firetouchinterest(plr.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 0);
									firetouchinterest(plr.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 1);
									_tp(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-009, .761243105, -5.70652914e-010, 1, 1.20584542e-009, -0.761243105, 3.47544882e-010, -0.648466587));
								else
									_tp(CFrame.new(-1610.00757, 11.5049858, 164.001587, .984807551, -0.167722285, -0.0449818149, .17364943, .951244235, .254912198, 3.42372805e-005, -0.258850515, .965917408));
								end;
							else
								if replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan") ~= 0 then
									replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup");
									wait(.5);
									EquipWeapon("Cup");
									wait(.5);
									replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", plr.Character.Cup);
									wait(Sec);
									replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan");
								else
									if replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == nil then
										replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon");
									elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0 then
										if workspace.Enemies:FindFirstChild("Mob Leader") or replicated:FindFirstChild("Mob Leader") then
											_tp(CFrame.new(-2967.59521, -4.91089821, 5328.70703, .342208564, -0.0227849055, .939347804, .0251603816, .999569714, .0150796166, -0.939287126, .0184739735, .342634559));
											for I, e in pairs(workspace.Enemies:GetChildren()) do
												if e.Name == "Mob Leader" and G.Alive(e) then
													repeat
														task.wait();
														G.Kill(e, _G.AutoSaber);
													until e.Humanoid.Health <= 0 or _G.AutoSaber == false;
												end;
											end;
										end;
									elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
										replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon");
										EquipWeapon("Relic");
										_tp(CFrame.new(-1404.91504, 29.9773273, 3.80598116, .876514494, 5.66906877e-009, .481375456, 2.53851997e-008, 1, -5.79995607e-008, -0.481375456, 6.30572643e-008, .876514494));
									end;
								end;
							end;
						end;
					else
						if workspace.Enemies:FindFirstChild("Saber Expert") or replicated:FindFirstChild("Saber Expert") then
							for I, e in pairs(workspace.Enemies:GetChildren()) do
								if e.Name == "Saber Expert" and G.Alive(e) then
									repeat
										task.wait();
										G.Kill(e, _G.AutoSaber);
									until e.Humanoid.Health <= 0 or _G.AutoSaber == false;
									if e.Humanoid.Health <= 0 then
										replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic");
									end;
								end;
							end;
						else
							_tp(CFrame.new(-1401.85046, 29.9773273, 8.81916237, .85820812, 8.76083845e-008, .513301849, -8.55007443e-008, 1, -2.77243419e-008, -0.513301849, -2.00944328e-008, .85820812));
						end;
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto m\197\169 Usoap",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.AutoGetUsoap = I;
		end,
	});
	spawn(function()
		while task.wait(Sec) do
			pcall(function()
				if _G.AutoGetUsoap then
					for I, e in pairs(workspace.Characters:GetChildren()) do
						if e.Name ~= plr.Name then
							if e.Humanoid.Health > 0 and (e:FindFirstChild("HumanoidRootPart") and (e.Parent and (Root.Position - e.HumanoidRootPart.Position).Magnitude <= 230)) then
								repeat
									task.wait();
									EquipWeapon(_G.SelectWeapon);
									_tp(e.HumanoidRootPart.CFrame * CFrame.new(1, 1, 2));
								until _G.AutoGetUsoap == false or e.Humanoid.Health <= 0 or not e.Parent or not e:FindFirstChild("HumanoidRootPart") or not e:FindFirstChild("Humanoid");
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto Ki\225\186\191m Bisento V2",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Greybeard = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.Greybeard then
				pcall(function()
					if not GetWP("Bisento") then
						replicated.Remotes.CommF_:InvokeServer("BuyItem", "Bisento");
					elseif GetWP("Bisento") then
						replicated.Remotes.CommF_:InvokeServer("LoadItem", "Bisento");
						local I = GetConnectionEnemies("Greybeard");
						if I then
							repeat
								wait();
								G.Kill(I, _G.Greybeard);
							until _G.Greybeard == false or not I.Parent or I.Humanoid.Health <= 0;
						else
							_tp(CFrame.new(-5023.3833007812, 28.652032852173, 4332.3818359375));
						end;
					end;
				end);
			end;
		end;
	end);
	Get:AddToggle({
		Name = "Auto ki\225\186\191m Warden",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.WardenBoss = I;
		end,
	});
	spawn(function()
		while wait(.1) do
			if _G.WardenBoss then
				pcall(function()
					local I = GetConnectionEnemies("Chief Warden");
					if I then
						repeat
							wait();
							G.Kill(I, _G.WardenBoss);
						until _G.WardenBoss == false or not I.Parent or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(5206.92578, .997753382, 814.976746, .342041343, -0.00062915677, .939684749, .00191645394, .999998152, -2.80422337e-005, -0.939682961, .00181045406, .342041939));
					end;
				end);
			end;
		end;
	end);
	Get:AddToggle({
		Name = "Auto  \195\161o cho\195\160ng Marine ",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.MarinesCoat = I;
		end,
	});
	spawn(function()
		while wait(.1) do
			if _G.MarinesCoat then
				pcall(function()
					local I = GetConnectionEnemies("Vice Admiral");
					if I then
						repeat
							wait();
							G.Kill(I, _G.MarinesCoat);
						until _G.MarinesCoat == false or not I.Parent or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375));
					end;
				end);
			end;
		end;
	end);
	Get:AddToggle({
		Name = "Auto \195\161o cho\195\160ng Swan",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.SwanCoat = I;
		end,
	});
	spawn(function()
		while wait(.1) do
			if _G.SwanCoat then
				pcall(function()
					local I = GetConnectionEnemies("Swan");
					if I then
						repeat
							wait();
							G.Kill(I, _G.SwanCoat);
						until _G.SwanCoat == false or not I.Parent or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, .951042235, 0, 1, 0, -0.951042235, 0, -0.309060812));
					end;
				end);
			end;
		end;
	end);
end;
if World2 then
	Get:AddSection({ "V\225\186\173t ph\225\186\169m sea2" });
	Get:AddToggle({
		Name = "Auto  ki\225\186\191m Rengoku",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.AutoKeyRen = I;
		end,
	});
	spawn(function()
		while wait(.1) do
			pcall(function()
				if _G.AutoKeyRen then
					if plr.Backpack:FindFirstChild(K[3]) or plr.Character:FindFirstChild(K[3]) then
						EquipWeapon(K[3]);
						wait(.1);
						_tp(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875));
					else
						local enemy = GetConnectionEnemies("Awakened Ice Admiral");
						if enemy then
							repeat
								task.wait();
								G.Kill(enemy, _G.AutoKeyRen);
							until plr.Backpack:FindFirstChild(K[3]) or not enemy.Parent or enemy.Humanoid.Health <= 0 or _G.AutoKeyRen == false;
						else
							_tp(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188));
							wait(1);
						end;
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto \196\144inh Ba R\225\187\147ng",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.AutoTridentW2 = I;
		end,
	});
	spawn(function()
		while wait(.1) do
			pcall(function()
				if _G.AutoTridentW2 then
					local I = GetConnectionEnemies("Tide Keeper");
					if I then
						repeat
							task.wait();
							G.Kill(I, _G.AutoTridentW2);
						until _G.AutoTridentW2 == false or not I.Parent or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188));
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto Ki\225\186\191m D\195\160i",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.LongsWord = I;
		end,
	});
	spawn(function()
		while wait(.1) do
			pcall(function()
				if _G.LongsWord then
					local I = GetConnectionEnemies("Diamond");
					if I then
						repeat
							task.wait();
							G.Kill(I, _G.LongsWord);
						until _G.LongsWord == false or not I.Parent or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407));
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto \195\161o cho\195\160ng Gai \196\145en",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.BlackSpikey = I;
		end,
	});
	spawn(function()
		while wait(.1) do
			if _G.BlackSpikey then
				pcall(function()
					local I = GetConnectionEnemies("Jeremy");
					if I then
						repeat
							wait();
							G.Kill(I, _G.BlackSpikey);
						until _G.BlackSpikey == false or not I.Parent or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109));
					end;
				end);
			end;
		end;
	end);
	Get:AddToggle({
		Name = "Auto Ki\225\186\191m Midnight Blade",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.AutoEcBoss = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.AutoEcBoss then
					if GetM("Ectoplasm") >= 99 then
						replicated.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 3);
					elseif GetM("Ectoplasm") <= 99 then
						local I = GetConnectionEnemies("Cursed Captain");
						if I then
							repeat
								wait();
								G.Kill(I, _G.AutoEcBoss);
							until not _G.AutoEcBoss or not I.Parent or I.Humanoid.Health <= 0;
						else
							replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
							wait(.5);
							_tp(CFrame.new(916.928589, 181.092773, 33422));
						end;
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto R\195\162u \196\144en",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Auto_Def_DarkCoat = I;
		end,
	});
	spawn(function()
		while wait(.1) do
			if _G.Auto_Def_DarkCoat then
				pcall(function()
					if GetBP("Fist of Darkness") and not workspace.Enemies:FindFirstChild("Darkbeard") then
						_tp(CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531));
					elseif GetConnectionEnemies("Darkbeard") then
						local I = GetConnectionEnemies("Darkbeard");
						if I then
							repeat
								wait();
								G.Kill(I, _G.Auto_Def_DarkCoat);
							until _G.Auto_Def_DarkCoat == false or not I.Parent or I.Humanoid.Helath <= 0;
						end;
					elseif not GetBP("Fist of Darkness") and not GetConnectionEnemies("Darkbeard") then
						repeat
							wait(.1);
							_G.AutoFarmChest = true;
						until not _G.Auto_Def_DarkCoat or GetBP("Fist of Darkness") or GetConnectionEnemies("Darkbeard");
						_G.AutoFarmChest = false;
					end;
				end);
			end;
		end;
	end);
	Get:AddToggle({
		Name = "Auto M\225\187\159 DonSwan",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Auto_DonAcces = I;
		end,
	});
	spawn(function()
		while wait(.1) do
			if _G.Auto_DonAcces then
				pcall(function()
					if (replicated.Remotes.CommF_:InvokeServer("GetUnlockables")).FlamingoAccess == nil and plr.Data.Level.Value >= 1500 then
						FruitPrice = {};
						FruitStore = {};
						for I, e in next, (replicated:WaitForChild("Remotes")).CommF_:InvokeServer("GetFruits") do
							if e.Price >= 1000000 then
								table.insert(FruitPrice, e.Name);
							end;
						end;
						for I, e in pairs(replicated.Remotes.CommF_:InvokeServer("getInventoryFruits")) do
							for I, e in pairs(e) do
								if I == "Name" then
									table.insert(FruitStore, e);
								end;
							end;
							replicated.Remotes.CommF_:InvokeServer("Cousin", "Buy");
							for I, e in pairs(FruitPrice) do
								for I, K in pairs(FruitStore) do
									if e == K and (replicated.Remotes.CommF_:InvokeServer("GetUnlockables")).FlamingoAccess == nil then
										_G.StoreF = false;
										if not plr.Backpack:FindFirstChild(FruitStore) then
											replicated.Remotes.CommF_:InvokeServer("LoadFruit", tostring(e));
										else
											replicated.Remotes.CommF_:InvokeServer("TalkTrevor", "1");
											replicated.Remotes.CommF_:InvokeServer("TalkTrevor", "2");
											replicated.Remotes.CommF_:InvokeServer("TalkTrevor", "3");
										end;
									end;
								end;
							end;
							if (replicated.Remotes.CommF_:InvokeServer("GetUnlockables")).FlamingoAccess ~= nil then
								_G.StoreF = true;
								_G.Auto_DonAcces = false;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	Get:AddToggle({
		Name = "Auto k\195\173nh swan",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Auto_SwanGG = I;
		end,
	});
	spawn(function()
		while wait(.2) do
			if _G.Auto_SwanGG then
				pcall(function()
					local I = GetConnectionEnemies("Don Swan");
					if I then
						repeat
							wait();
							G.Kill(I, _G.Auto_SwanGG);
						until _G.Auto_SwanGG == false or not I.Parent or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875));
					end;
				end);
			end;
		end;
	end);
end;
if World3 then
	Get:AddSection({ "Sea 3" });
	Get:AddToggle({
		Name = "Auto Ki\225\186\191m Canvender",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.Auto_Cavender = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Cavender then
					local I = GetConnectionEnemies("Beautiful Pirate");
					if I then
						repeat
							wait();
							G.Kill(I, _G.Auto_Cavender);
						until not _G.Auto_Cavender or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(5283.6094, 22.5622, -110.7829));
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto song m\195\179c",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.TwinHook = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.TwinHook then
					local I = GetConnectionEnemies("Captain Elephant");
					if I then
						repeat
							wait();
							G.Kill(I, _G.TwinHook);
						until not _G.TwinHook or I.Humanoid.Health <= 0;
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.1699, 374.9402, -7551.6777));
						wait(.2);
						_tp(CFrame.new(-13376.7578, 433.2869, -8071.3926));
					end;
				end;
			end);
		end;
	end);
	Get:AddToggle({
		Name = "Auto Cung \196\145\225\187\153c",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.AutoSerpentBow = I;
		end,
	});
	spawn(function()
		while wait(Sec) do
			if _G.AutoSerpentBow then
				local I = GetConnectionEnemies("Hydra Leader");
				if I then
					repeat
						wait();
						G.Kill(I, _G.AutoSerpentBow);
					until not _G.AutoSerpentBow or not I.Parent or I.Humanoid.Health <= 0;
				else
					_tp(CFrame.new(5821.898, 1019.0951, -73.7192));
				end;
			end;
		end;
	end);
	Get:AddToggle({
		Name = "Auto v\195\178ng hoa",
		Description = "",
		Default = false,
		Callback = function(I)
			_G.AutoKilo = I;
		end,
	});
	spawn(function()
		while wait(.2) do
			if _G.AutoKilo then
				pcall(function()
					local I = GetConnectionEnemies("Kilo Admiral");
					if I then
						repeat
							task.wait();
							G.Kill(I, _G.AutoKilo);
						until not _G.AutoKilo or not I.Parent or I.Humanoid.Health <= 0;
					else
						_tp(CFrame.new(2764.2234, 432.4615, -7144.458));
					end;
				end);
			end;
		end;
	end);
end;
Fruit:AddSection({ "Raid" });
e = {
		"Flame",
		"Ice",
		"Quake",
		"Light",
		"Dark",
		"String",
		"Rumble",
		"Magma",
		"Human: Buddha",
		"Sand",
		"Bird: Phoenix",
		"Dough",
	};
Fruit:AddDropdown({
	Name = "Ch\225\187\141n Chip",
	Description = "",
	Options = e,
	Default = "Flame",
	Multi = false,
	Callback = function(I)
		_G.SelectChip = I;
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.AutoSelectDungeon then
			pcall(function()
				if GetBP("Flame-Flame") then
					_G.SelectChip = "Flame";
				elseif GetBP("Ice-Ice") then
					_G.SelectChip = "Ice";
				elseif GetBP("Quake-Quake") then
					_G.SelectChip = "Quake";
				elseif GetBP("Light-Light") then
					_G.SelectChip = "Light";
				elseif GetBP("Dark-Dark") then
					_G.SelectChip = "Dark";
				elseif GetBP("String-String") then
					_G.SelectChip = "String";
				elseif GetBP("Rumble-Rumble") then
					_G.SelectChip = "Rumble";
				elseif GetBP("Magma-Magma") then
					_G.SelectChip = "Magma";
				elseif GetBP("Human-Human: Buddha Fruit") then
					_G.SelectChip = "Human: Buddha";
				elseif GetBP("Dough-Dough") then
					_G.SelectChip = "Dough";
				elseif GetBP("Sand-Sand") then
					_G.SelectChip = "Sand";
				elseif GetBP("Bird-Bird: Phoenix") then
					_G.SelectChip = "Bird: Phoenix";
				else
					_G.SelectChip = "Ice";
				end;
			end);
		end;
	end;
end);
Fruit:AddToggle({
	Name = "Mua chip v\225\187\155i tr\195\161i \195\173t beli",
	Description = "",
	Default = false,
	Callback = function(state)
		_G.AutoBuyChip = state;
		task.spawn(function()
			while _G.AutoBuyChip do
				if not GetBP("Special Microchip") then
					local I = {};
					for _, data in next, replicated.Remotes.CommF_:InvokeServer("GetFruits") do
						local rarity = (tostring(data.Rarity or "")):lower();
						if data.Price <= 1150000 or rarity == "common" or rarity == "uncommon" or rarity == "rare" then
							table.insert(I, data.Name);
						end;
					end;
					for _, fruitName in pairs(I) do
						if not GetBP("Special Microchip") then
							replicated.Remotes.CommF_:InvokeServer("LoadFruit", fruitName);
							replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip);
						end;
					end;
				end;
				task.wait(3);
			end;
		end);
	end,
});
Fruit:AddSection({ "Raid Farming" });
Fruit:AddToggle({
	Name = "Auto b\225\186\175t \196\145\225\186\167u Raid",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.Auto_StartRaid = I;
	end,
});
spawn(function()
	while true do
		task.wait(10);
		if _G.Auto_StartRaid then
			pcall(function()
				if plr.PlayerGui.Main.TopHUDList.RaidTimer.Visible == false then
					if GetBP("Special Microchip") then
						if World2 then
							_tp(CFrame.new(-6438.73535, 250.645355, -4501.50684));
							fireclickdetector(workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector);
						elseif World3 then
							replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602));
							task.wait(.5);
							_tp(CFrame.new(-5033.50879, 315.014252, -2947.77539));
							fireclickdetector(workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector);
						end;
					end;
				end;
			end);
		end;
	end;
end);
Fruit:AddToggle({
	Name = "Auto Ho\195\160n Th\195\160nh Raid",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.Raiding = I;
	end,
});
function IsIslandRaid(cu)
	local locs = (game:GetService("Workspace"))._WorldOrigin.Locations;
	if locs:FindFirstChild("Island " .. cu) then
		local min = 4500;
		for _, v in ipairs(locs:GetChildren()) do
			if v.Name == "Island " .. cu then
				local dist = (v.Position - plr.Character.HumanoidRootPart.Position).Magnitude;
				if dist < min then
					min = dist;
				end;
			end;
		end;
		for _, v in ipairs(locs:GetChildren()) do
			if v.Name == "Island " .. cu then
				local dist = (v.Position - plr.Character.HumanoidRootPart.Position).Magnitude;
				if dist <= min then
					return v;
				end;
			end;
		end;
	end;
end;
function getNextIsland()
	local order = {
			5,
			4,
			3,
			2,
			1,
		};
	for _, id in ipairs(order) do
		local island = IsIslandRaid(id);
		if island then
			local dist = (island.Position - plr.Character.HumanoidRootPart.Position).Magnitude;
			if dist <= 4500 then
				return island;
			end;
		end;
	end;
end;
function attackNearbyEnemies()
	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
			if mob.Humanoid.Health > 0 then
				local dist = (mob.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude;
				if dist <= 1000 then
					repeat
						G.Kill(mob, _G.Raiding);
						task.wait();
					until not _G.Raiding or not mob.Parent or mob.Humanoid.Health <= 0;
				end;
			end;
		end;
	end;
end;
spawn(function()
	pcall(function()
		while wait(Sec) do
			if _G.Raiding then
				if plr.PlayerGui.Main.TopHUDList.RaidTimer.Visible == true then
					attackNearbyEnemies();
					local nextIsland = getNextIsland();
					if nextIsland then
						_tp(nextIsland.CFrame * CFrame.new(0, 50, 0));
						NextIs = true;
					else
						NextIs = false;
					end;
				else
					NextIs = false;
				end;
			else
				NextIs = false;
			end;
		end;
	end);
end);
Fruit:AddToggle({
	Name = "Auto Th\225\187\169c T\225\187\137nh",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.Auto_Awakener = I;
	end,
});
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Awakener then
				replicated.Remotes.CommF_:InvokeServer("Awakener", "Check");
				replicated.Remotes.CommF_:InvokeServer("Awakener", "Awaken");
			end;
		end);
	end;
end);
Fruit:AddSection({ "Tr\195\161i Blox Fruits" });
local J5 = {};
local function i5(I)
	local e = tostring(I);
	while true do
		e, k = e:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
		if k == 0 then
			break;
		end;
	end;
	return e;
end;
for I, e in pairs(replicated.Remotes.CommF_:InvokeServer("GetFruits", true)) do
	if e.OnSale == true then
		local I = i5(e.Price);
		local K = e.Name;
		table.insert(J5, K);
	end;
end;
local C5 = {};
for I, e in pairs(replicated.Remotes.CommF_:InvokeServer("GetFruits", false)) do
	if e.OnSale == true then
		local I = i5(e.Price);
		local K = e.Name;
		table.insert(C5, K);
	end;
end;
Fruit:AddDropdown({
	Name = "Ch\225\187\141n tr\195\161i stock",
	Description = "",
	Options = C5,
	Default = false,
	Multi = false,
	Callback = function(I)
		_G.SelectFruit = I;
	end,
});
Fruit:AddButton({ Name = "Mua Tr\195\161i stock th\198\176\225\187\157ng", Description = "", Callback = function()
		replicated.Remotes.CommF_:InvokeServer("PurchaseRawFruit", _G.SelectFruit);
	end });
Fruit:AddDropdown({
	Name = "Ch\225\187\141n tr\195\161i \196\145\225\186\163o k\195\172 b\195\173",
	Description = "",
	Options = J5,
	Default = false,
	Multi = false,
	Callback = function(I)
		SelectF_Adv = I;
	end,
});
local M5 = {};
for I, e in pairs(replicated.Remotes.CommF_:InvokeServer("GetFruits", false)) do
	if e.OnSale == true then
		local I = i5(e.Price);
		local K = e.Name;
		table.insert(M5, K);
	end;
end;
Fruit:AddButton({ Name = "Mua k\195\172 b\195\173 stock", Description = "", Callback = function()
		replicated.Remotes.CommF_:InvokeServer("PurchaseRawFruit", SelectF_Adv);
	end });
Fruit:AddToggle({
	Name = "Auto Random Tr\195\161i",
	Description = "",
	Default = GetSetting("AutoRandomFruit_Save", false),
	Callback = function(I)
		_G.Random_Auto = I;
		_G.SaveData.AutoRandomFruit_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Random_Auto then
				replicated.Remotes.CommF_:InvokeServer("Cousin", "Buy");
			end;
		end);
	end;
end);
Get:AddToggle({
	Name = "Auto Th\225\186\163 tr\195\161i Fruit",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.DropFruit = I;
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.DropFruit then
			pcall(function()
				DropFruits();
			end);
		end;
	end;
end);
Fruit:AddToggle({
	Name = "Auto L\198\176u Tr\225\187\175 Fruit",
	Description = "",
	Default = GetSetting("AutoStoreFruit_Save", false),
	Callback = function(I)
		_G.StoreF = I;
		_G.SaveData.AutoStoreFruit_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.StoreF then
			pcall(function()
				UpdStFruit();
			end);
		end;
	end;
end);
Fruit:AddToggle({
	Name = "Auto Bay \196\144\225\186\191n Fruit",
	Description = "",
	Default = GetSetting("AutoTweenFruit_Save", false),
	Callback = function(I)
		_G.TwFruits = I;
		_G.SaveData.AutoTweenFruit_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.TwFruits then
			pcall(function()
				for I, e in pairs(workspace:GetChildren()) do
					if string.find(e.Name, "Fruit") then
						_tp(e.Handle.CFrame);
					end;
				end;
			end);
		end;
	end;
end);
Fruit:AddToggle({
	Name = "Auto Nh\225\186\183t Fruit",
	Description = "",
	Default = GetSetting("AutoCollectFruit_Save", false),
	Callback = function(I)
		_G.InstanceF = I;
		_G.SaveData.AutoCollectFruit_Save = I;
		SaveSettings();
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.InstanceF then
			pcall(function()
				collectFruits(_G.InstanceF);
			end);
		end;
	end;
end);
Setting:AddSection({ "Codes" });
Setting:AddButton({ Name = "Nh\225\186\173p T\225\186\165t C\225\186\163 Codes", Description = "", Callback = function()
		local Codes = {
				"KITT_RESET",
				"Sub2UncleKizaru",
				"SUB2GAMERROBOT_RESET1",
				"Sub2Fer999",
				"Enyu_is_Pro",
				"JCWK",
				"StarcodeHEO",
				"MagicBus",
				"KittGaming",
				"Sub2CaptainMaui",
				"Sub2OfficalNoobie",
				"TheGreatAce",
				"Sub2NoobMaster123",
				"Sub2Daigrock",
				"Axiore",
				"StrawHatMaine",
				"TantaiGaming",
				"Bluxxy",
				"SUB2GAMERROBOT_EXP1",
				"Chandler",
				"NOMOREHACK",
				"BANEXPLOIT",
				"WildDares",
				"BossBuild",
				"GetPranked",
				"EARN_FRUITS",
				"FIGHT4FRUIT",
				"NOEXPLOITER",
				"NOOB2ADMIN",
				"CODESLIDE",
				"ADMINHACKED",
				"ADMINDARES",
				"fruitconcepts",
				"krazydares",
				"TRIPLEABUSE",
				"SEATROLLING",
				"24NOADMIN",
				"REWARDFUN",
				"NEWTROLL",
				"fudd10_v2",
				"Fudd10",
				"Bignews",
				"SECRET_ADMIN",
			};
		for _, code in ipairs(Codes) do
			pcall(function()
				(game:GetService("ReplicatedStorage")).Remotes.Redeem:InvokeServer(code);
			end);
		end;
	end });
Setting:AddSection({ "Team" });
Setting:AddButton({ Name = "Chuy\225\187\131n sang phe h\225\186\163i t\225\186\183c", Description = "", Callback = function()
		Pirates();
	end });
Setting:AddButton({ Name = "Chuy\225\187\131n sang phe h\225\186\163i qu\195\162n", Description = "", Callback = function()
		Marines();
	end });
Setting:AddSection({ "Kh\195\161c" });
HakiSt = {
		"State 0",
		"State 1",
		"State 2",
		"State 3",
		"State 4",
		"State 5",
	};
Setting:AddDropdown({
	Name = "Haki C\225\186\165p \196\145\225\187\153",
	Description = "",
	Options = HakiSt,
	Default = false,
	Multi = false,
	Callback = function(I)
		_G.SelectStateHaki = I;
	end,
});
Setting:AddButton({ Name = "\196\144\225\187\149i c\225\186\165p \196\145\225\187\153 haki", Description = "", Callback = function()
		if _G.SelectStateHaki == "State 0" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 0);
		elseif _G.SelectStateHaki == "State 1" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 1);
		elseif _G.SelectStateHaki == "State 2" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 2);
		elseif _G.SelectStateHaki == "State 3" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 3);
		elseif _G.SelectStateHaki == "State 4" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 4);
		elseif _G.SelectStateHaki == "State 5" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 5);
		end;
	end });
Setting:AddButton({ Name = "Xo\195\161 s\198\176\198\161ng m\195\185", Description = "", Callback = function()
		if Lighting:FindFirstChild("LightingLayers") then
			Lighting.LightingLayers:Destroy();
		end;
		if Lighting:FindFirstChild("SeaTerrorCC") then
			Lighting.SeaTerrorCC:Destroy();
		end;
		if Lighting:FindFirstChild("FantasySky") then
			Lighting.FantasySky:Destroy();
		end;
	end });
Setting:AddToggle({
	Name = "\196\144i tr\195\170n n\198\176\225\187\155c",
	Description = "",
	Default = true,
	Callback = function(I)
		_G.WalkWater_Part = I;
		local e = (game:GetService("Workspace")).Map["WaterBase-Plane"];
		if _G.WalkWater_Part then
			e.Size = Vector3.new(1000, 112, 1000);
		else
			e.Size = Vector3.new(1000, 80, 1000);
		end;
	end,
});
Setting:AddSection({ "Fps - fix lag" });
Setting:AddButton({ Name = "K\195\169o d\195\160i m\195\160n h\195\172nh", Description = "", Callback = function()
		(getgenv()).Resolution = { [".gg/scripters"] = .65 };
		local Camera = workspace.CurrentCamera;
		if (getgenv()).gg_scripters == nil then
			(game:GetService("RunService")).RenderStepped:Connect(function()
				pcall(function()
					Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, (getgenv()).Resolution[".gg/scripters"], 0, 0, 0, 1);
				end);
			end);
		end;
		(getgenv()).gg_scripters = "Aori0001";
	end });
Setting:AddButton({ Name = "T\196\131ng fps", Description = "", Callback = function()
		LowCpu();
	end });
local V5 = game.Players.LocalPlayer;
local function y5(I)
	if not I then
		return false;
	end;
	local e = I:FindFirstChild("Humanoid");
	return e and e.Health > 0;
end;
local FastAttackModule = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Player = Players.LocalPlayer;
local function SafeWaitForChild(parent, childName)
	local success, result = pcall(function()
			return parent:WaitForChild(childName);
		end);
	if not success or not result then
		warn("SafeWaitForChild falhou: " .. tostring(childName));
	end;
	return result;
end;
local Modules = SafeWaitForChild(ReplicatedStorage, "Modules");
local Net = SafeWaitForChild(Modules, "Net");
local Settings = { AutoClick = true, ClickDelay = 0 };
local FastAttack = {
		Distance = 100,
		attackMobs = true,
		attackPlayers = true,
		Equipped = nil,
	};
local RegisterAttack = SafeWaitForChild(Net, "RE/RegisterAttack");
local RegisterHit = SafeWaitForChild(Net, "RE/RegisterHit");
local function IsAlive(character)
	return character and (character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0);
end;
local function ProcessEnemies(OthersEnemies, Folder)
	local BasePart = nil;
	for _, Enemy in ipairs(Folder:GetChildren()) do
		local Head = Enemy:FindFirstChild("Head");
		if Head and (IsAlive(Enemy) and Player:DistanceFromCharacter(Head.Position) < FastAttack.Distance) then
			if Enemy ~= Player.Character then
				table.insert(OthersEnemies, { Enemy, Head });
				BasePart = Head;
			end;
		end;
	end;
	return BasePart;
end;
function FastAttack.Attack(self, BasePart, OthersEnemies)
	if not BasePart or #OthersEnemies == 0 then
		return;
	end;
	pcall(function()
		RegisterAttack:FireServer(Settings.ClickDelay or 0);
		RegisterHit:FireServer(BasePart, OthersEnemies);
	end);
end;
function FastAttack.AttackNearest(self)
	local OthersEnemies = {};
	local EnemiesFolder = workspace:FindFirstChild("Enemies");
	local CharactersFolder = workspace:FindFirstChild("Characters");
	local Part1 = nil;
	local Part2 = nil;
	if EnemiesFolder then
		Part1 = ProcessEnemies(OthersEnemies, EnemiesFolder);
	end;
	if CharactersFolder then
		Part2 = ProcessEnemies(OthersEnemies, CharactersFolder);
	end;
	local character = Player.Character;
	if not character then
		return;
	end;
	local equippedWeapon = character:FindFirstChildOfClass("Tool");
	if equippedWeapon and equippedWeapon:FindFirstChild("LeftClickRemote") then
		for _, enemyData in ipairs(OthersEnemies) do
			local enemy = enemyData[1];
			if enemy and (enemy:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart")) then
				local direction = (enemy.HumanoidRootPart.Position - (character:GetPivot()).Position).Unit;
				pcall(function()
					equippedWeapon.LeftClickRemote:FireServer(direction, 1);
				end);
			end;
		end;
	elseif #OthersEnemies > 0 then
		self:Attack(Part1 or Part2, OthersEnemies);
	else
		task.wait(0);
	end;
end;
function FastAttack.BladeHits(self)
	local Equipped = IsAlive(Player.Character) and Player.Character:FindFirstChildOfClass("Tool");
	if Equipped and Equipped.ToolTip ~= "Gun" then
		self:AttackNearest();
	else
		task.wait(0);
	end;
end;
task.spawn(function()
	while task.wait(Settings.ClickDelay) do
		if Settings.AutoClick then
			FastAttack:BladeHits();
		end;
	end;
end);
_ENV.rz_FastAttack = FastAttack;
FastAttackModule.FastAttack = FastAttack;
NotificacaoTuanDz("NatAov Hub", "\226\156\133 fast attack loaded!");
return FastAttackModulem;