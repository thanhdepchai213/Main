-- Check Executor

local executor = getexecutorname() or identifyexecutor()

if executor then

    if

            string.find(executor, "Bunni") or 

            string.find(executor, "FluxusZ") or 

            string.find(executor, "Delta") or 

            string.find(executor, "Arceus") or

            string.find(executor, "Xeno") or

            string.find(executor, "Swift") or

            string.find(executor, "Awp") or

            string.find(executor, "Volcano") or

            string.find(executor, "Argon") or

            string.find(executor, "Macsploit") or

            string.find(executor, "Potassium") or

            string.find(executor, "CodeX") or

            string.find(executor, "Velocity") or

            string.find(executor, "Romix")

     then

        print("ok")

    else

        game.Players.LocalPlayer:Kick("Please use Delta Exploit or PC use volcano or Exploit paid!")

    end

end

if not game:IsLoaded() then 

    game.Loaded:Wait() 

end



game:GetService("StarterGui"):SetCore("SendNotification", {

        Title = "Redz Hub ",

        Text = "Loading...",

        Duration = 5

})



wait(3)



-- Services

local Players = game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TeleportService = game:GetService("TeleportService")

local TweenService = game:GetService("TweenService")

local Lighting = game:GetService("Lighting")

local VirtualInputManager = game:GetService("VirtualInputManager")

local RunService = game:GetService("RunService")

local Stats = game:GetService("Stats")

local UserInputService = game:GetService("UserInputService")



local ply = Players

local plr = ply.LocalPlayer

local Root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

local replicated = ReplicatedStorage

local Lv = (plr.Data and plr.Data.Level and plr.Data.Level.Value) or 0

local TeleportService = TeleportService

local TW = TweenService

local Lighting = Lighting

local Enemies = workspace:FindFirstChild("Enemies")

local vim1 = VirtualInputManager

local vim2 = game:GetService("VirtualUser")

local TeamSelf = plr.Team

local RunSer = RunService

local Stats = Stats

local Energy = (plr.Character and plr.Character:FindFirstChild("Energy") and plr.Character.Energy.Value) or 0



-- BIẾN CẤU HÌNH

local Boss = {}

local BringConnections = {}

local MaterialList = {}

local NPCList = {}

local shouldTween = false

local SoulGuitar = false

local KenTest = true

local debug = false

local Brazier1 = false

local Brazier2 = false

local Brazier3 = false

local Sec = 0.1

local ClickState = 0

local Num_self = 25



-- BIẾN TOÀN CỤC

_G = _G or {}

_G.SelectWeapon = _G.SelectWeapon or "Melee"

_G.FastAttack = _G.FastAttack or true



local World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715

local World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657

local World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

-- Team mặc định

getgenv().Team = getgenv().Team or "Pirates"



repeat 

    local start = plr.PlayerGui:WaitForChild("Main"):WaitForChild("Loading") 

    wait() 

until start and game:IsLoaded()



-- Thiết lập team

if getgenv().Team == "Pirates" then

    replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")

elseif getgenv().Team == "Marines" then

    replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines")

else

    replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")

end

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

			"Greybeard"

		}

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

			"Order"

		}

	elseif World3 then

		Boss = {

			"Tyrant of the Skies",

			"Stone",

			"Hydra Leader",

			"Kilo Admiral",

			"Captain Elephant",

			"Beautiful Pirate",

			"Cake Queen",

			"Longma",

			"Soul Reaper"

		}

	end

	if World1 then

		MaterialList = {

			"Leather + Scrap Metal",

			"Angel Wings",

			"Magma Ore",

			"Fish Tail"

		}

	elseif World2 then

		MaterialList = {

			"Leather + Scrap Metal",

			"Radioactive Material",

			"Ectoplasm",

			"Mystic Droplet",

			"Magma Ore",

			"Vampire Fang"

		}

	elseif World3 then

		MaterialList = {

			"Scrap Metal",

			"Demonic Wisp",

			"Conjured Cocoa",

			"Dragon Scale",

			"Gunpowder",

			"Fish Tail",

			"Mini Tusk"

		}

	end

	local DungeonTables = {

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

		"Dough"

	}

	local RenMon = {

		"Snow Lurker",

		"Arctic Warrior",

		"Hidden Key",

		"Awakened Ice Admiral"

	}

	local CursedTables = {

		["Mob"] = "Mythological Pirate",

		["Mob2"] = "Cursed Skeleton",

		"Hell's Messenger",

		["Mob3"] = "Cursed Skeleton",

		"Heaven's Guardian"

	}

	local Past = {

		"Part",

		"SpawnLocation",

		"Terrain",

		"WedgePart",

		"MeshPart"

	}

	local BartMon = {

		"Swan Pirate",

		"Jeremy"

	}

	local CitizenTable = {

		"Forest Pirate",

		"Captain Elephant"

	}

	local Human_v3_Mob = {

		"Fajita",

		"Jeremy",

		"Diamond"

	}

	local AllBoats = {

		"Beast Hunter",

		"Lantern",

		"Guardian",

		"Grand Brigade",

		"Dinghy",

		"Sloop",

		"The Sentinel"

	}

	local mastery1 = {

		"Cookie Crafter"

	}

	local mastery2 = {

		"Reborn Skeleton"

	}

	local PosMsList = {

		["Pirate Millionaire"] = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625),

		["Pistol Billionaire"] = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625),

		["Dragon Crew Warrior"] = CFrame.new(7021.50439453125, 55.76270294189453, -730.1290893554688),

		["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),

		["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),

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

		["Ghost"] = CFrame.new(5251, 5, 1111)

	}

	EquipWeapon = function(text)

		if not text then

			return

		end

		if plr.Backpack:FindFirstChild(text) then

			plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(text))

		end

	end

	weaponSc = function(weapon)

		for __in, v in pairs(plr.Backpack:GetChildren()) do

			if v:IsA("Tool") then

				if v.ToolTip == weapon then

					EquipWeapon(v.Name)

				end

			end

		end

	end



	local Rock = workspace:FindFirstChild("Rocks")

	if Rock then

		Rock:Destroy()

	end

	

	local Attack = {}

	Attack.__index = Attack

	Attack.Alive = function(model)

		if not model then

			return

		end

		local Humanoid = model:FindFirstChild("Humanoid")

		return Humanoid and Humanoid.Health > 0

	end

	Attack.Pos = function(model, dist)

		return (Root.Position - model.Position).Magnitude <= dist

	end

	Attack.Dist = function(model, dist)

		return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist

	end

	Attack.DistH = function(model, dist)

		return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude > dist

	end

	Attack.Kill = function(model, Succes)

		if model and Succes then

			if not model:GetAttribute("Locked") then

				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)

			end

			PosMon = model:GetAttribute("Locked").Position

			BringEnemy()

			EquipWeapon(_G.SelectWeapon)

			local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

			local ToolTip = Equipped.ToolTip

			if ToolTip == "Blox Fruit" then

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(90), 0))

			else

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(180), 0))

			end

			if RandomCFrame then

				wait(.5)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))

				wait(.5)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))

				wait(.5)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 , 0))

				wait(.5)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))

				wait(.5)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))

			end

		end

	end

	Attack.Kill2 = function(model, Succes)

		if model and Succes then

			if not model:GetAttribute("Locked") then

				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)

			end

			PosMon = model:GetAttribute("Locked").Position

			BringEnemy()

			EquipWeapon(_G.SelectWeapon)

			local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

			local ToolTip = Equipped.ToolTip

			if ToolTip == "Blox Fruit" then

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(90), 0))

			else

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 8) * CFrame.Angles(0, math.rad(180), 0))

			end

			if RandomCFrame then

				wait(0.1)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))

				wait(0.1)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))

				wait(0.1)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 , 0))

				wait(0.1)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))

				wait(0.1)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))

			end

		end

	end

	Attack.KillSea = function(model, Succes)

		if model and Succes then

			if not model:GetAttribute("Locked") then

				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)

			end

			PosMon = model:GetAttribute("Locked").Position

			BringEnemy()

			EquipWeapon(_G.SelectWeapon)

			local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

			local ToolTip = Equipped.ToolTip

			if ToolTip == "Blox Fruit" then

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(90), 0))

			else

				notween(model.HumanoidRootPart.CFrame * CFrame.new(0, 50, 8))

				wait(.85)

				notween(model.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0))

				wait(1)

			end

		end

	end

	Attack.Sword = function(model, Succes)

		if model and Succes then

			if not model:GetAttribute("Locked") then

				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)

			end

			PosMon = model:GetAttribute("Locked").Position

			BringEnemy()

			weaponSc("Sword")

			_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

			if RandomCFrame then

				wait(0.1)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))

				wait(0.1)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))

				wait(0.1)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 , 0))

				wait(0.1)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))

				wait(0.1)

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))

			end

		end

	end

	Attack.Mas = function(model, Succes)

		if model and Succes then

			if not model:GetAttribute("Locked") then

				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)

			end

			PosMon = model:GetAttribute("Locked").Position

			BringEnemy()

			if model.Humanoid.Health <= HealthM then

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))

				Useskills("Blox Fruit", "Z")

				Useskills("Blox Fruit", "X")

				Useskills("Blox Fruit", "C")

				Useskills("Blox Fruit", "V")

				Useskills("Blox Fruit", "F")

			else

				weaponSc("Melee")

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

			end

		end

	end

	Attack.Masgun = function(model, Succes)

		if model and Succes then

			if not model:GetAttribute("Locked") then

				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)

			end

			PosMon = model:GetAttribute("Locked").Position

			BringEnemy()

			if model.Humanoid.Health <= HealthM then

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 35, 8))

				Useskills("Gun", "Z")

				Useskills("Gun", "X")

			else

				weaponSc("Melee")

				_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

			end

		end

	end

	statsSetings = function(Num, value)

		if Num == "Melee" then

			if plr.Data.Points.Value ~= 0 then

				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Melee", value)

			end

		elseif Num == "Defense" then

			if plr.Data.Points.Value ~= 0 then

				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Defense", value)

			end

		elseif Num == "Sword" then

			if plr.Data.Points.Value ~= 0 then

				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Sword", value)

			end

		elseif Num == "Gun" then

			if plr.Data.Points.Value ~= 0 then

				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Gun", value)

			end

		elseif Num == "Devil" then

			if plr.Data.Points.Value ~= 0 then

				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", value)

			end

		end

	end

	--// Optimized BringEnemy Function (Compatible with Aurora Script)

local plr = game.Players.LocalPlayer

local TweenService = game:GetService("TweenService")



-- Tween movement for mobs

local function TweenObject(Object, Pos, Speed)

    Speed = Speed or 350

    if not Object or not Pos then return end

    local Distance = (Pos.Position - Object.Position).Magnitude

    local info = TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear)

    local tween = TweenService:Create(Object, info, {CFrame = Pos})

    tween:Play()

end



-- Get average position of mobs with the same name

local function GetMobPosition(EnemiesName)

    local pos = Vector3.zero

    local count = 0

    for _, v in pairs(workspace.Enemies:GetChildren()) do

        if v.Name == EnemiesName and v:FindFirstChild("HumanoidRootPart") then

            pos += v.HumanoidRootPart.Position

            count += 1

        end

    end

    if count == 0 then

        return nil

    end

    return pos / count

end



-- Bring mobs closer together

BringEnemy = function()

    if not _B then return end

    local enemies = workspace.Enemies:GetChildren()

    if #enemies == 200 then return end



    local totalpos = {}



    -- Get average position for each enemy type

    for _, v in pairs(enemies) do

        if not totalpos[v.Name] then

            totalpos[v.Name] = GetMobPosition(v.Name)

        end

    end



    -- Group mobs around their average position

    for _, v in pairs(workspace.Enemies:GetChildren()) do

        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then

            local hrp = v.HumanoidRootPart

            local humanoid = v.Humanoid

            if humanoid.Health > 0 and (hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 250 then

                local mobPos = totalpos[v.Name]

                if mobPos then

                    local TargetCFrame = CFrame.new(mobPos.X, mobPos.Y, mobPos.Z)

                    local Distance = (hrp.Position - TargetCFrame.Position).Magnitude



                    if Distance > 3 and Distance <= 300 then

                        TweenObject(hrp, TargetCFrame, 350)

                        hrp.CanCollide = false

                        humanoid.WalkSpeed = 200

                        humanoid.JumpPower = 100

                        if humanoid:FindFirstChild("Animator") then

                            humanoid.Animator:Destroy()

                        end

                        pcall(function()

                            sethiddenproperty(plr, "SimulationRadius", math.huge)

                        end)

                    end

                end

            end

        end

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

	local gg = getrawmetatable(game)

	local old = gg.__namecall

	setreadonly(gg, false)

	gg.__namecall = newcclosure(function(...)

		local method = getnamecallmethod()

		local args = {

			...

		}

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

		for i, v in pairs(replicated:GetChildren()) do

			if v:IsA("Model") and  ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then

				return v

			end

		end

		for i, v in next, game.Workspace.Enemies:GetChildren() do

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

		if GetBP("Dragon-Dragon") or GetBP("Gas-Gas") or GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune") or GetBP("T-Rex-T-Rex") then

			return true

		end

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

		for _, v in pairs(workspace.Enemies:GetChildren()) do

			if (v.Name == "FishBoat") and v:FindFirstChild("Health").Value > 0 then

				return true

			end;

		end;

		return false

	end;

	CheckPirateGrandBrigade = function()

		for _, v in pairs(workspace.Enemies:GetChildren()) do

			if (v.Name == "PirateGrandBrigade" or v.Name == "PirateBrigade") and v:FindFirstChild("Health").Value > 0 then

				return true

			end

		end

		return false

	end

	CheckShark = function()

		for _, v in pairs(workspace.Enemies:GetChildren()) do

			if v.Name == "Shark" and Attack.Alive(v) then

				return true

			end;

		end;

		return false

	end;

	CheckTerrorShark = function()

		for _, v in pairs(workspace.Enemies:GetChildren()) do

			if v.Name == "Terrorshark" and Attack.Alive(v) then

				return true

			end;

		end;

		return false

	end;

	CheckPiranha = function()

		for _, v in pairs(workspace.Enemies:GetChildren()) do

			if v.Name == "Piranha" and Attack.Alive(v) then

				return true

			end;

		end;

		return false

	end;

	CheckFishCrew = function()

		for _, v in pairs(workspace.Enemies:GetChildren()) do

			if (v.Name == "Fish Crew Member" or v.Name == "Haunted Crew Member") and Attack.Alive(v) then

				return true

			end;

		end;

		return false

	end;

	CheckHauntedCrew = function()

		for _, v in pairs(workspace.Enemies:GetChildren()) do

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

		for z, x in next, plr.Backpack:GetChildren() do

			StoreFruit = x:FindFirstChild("EatRemote", true)

			if StoreFruit then

				replicated.Remotes.CommF_:InvokeServer("StoreFruit", StoreFruit.Parent:GetAttribute("OriginalName"),

		plr.Backpack:FindFirstChild(x.Name))

			end

		end

	end

	collectFruits = function(Succes)

		if Succes then

			local Character = plr.Character

			for _, v1 in pairs(workspace:GetChildren()) do

				if string.find(v1.Name, "Fruit") then

					v1.Handle.CFrame = Character.HumanoidRootPart.CFrame

				end

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

		for _, v3 in next, plr.Backpack:GetChildren() do

			if string.find(v3.Name, "Fruit") then

				EquipWeapon(v3.Name)

				wait(.1)

				if plr.PlayerGui.Main.Dialogue.Visible == true then

					plr.PlayerGui.Main.Dialogue.Visible = false

				end

				EquipWeapon(v3.Name)

				plr.Character:FindFirstChild(v3.Name).EatRemote:InvokeServer("Drop")

			end

		end

		for a, b2 in pairs(plr.Character:GetChildren()) do

			if string.find(b2.Name, "Fruit") then

				EquipWeapon(b2.Name)

				wait(.1)

				if plr.PlayerGui.Main.Dialogue.Visible == true then

					plr.PlayerGui.Main.Dialogue.Visible = false

				end

				EquipWeapon(b2.Name)

				plr.Character:FindFirstChild(b2.Name).EatRemote:InvokeServer("Drop")

			end

		end

	end

	GetBP = function(v)

		return plr.Backpack:FindFirstChild(v) or plr.Character:FindFirstChild(v)

	end

	GetIn = function(Name)

		for _ , v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do

			if type(v1) == "table" then

				if v1.Name == Name or plr.Character:FindFirstChild(Name) or plr.Backpack:FindFirstChild(Name) then

					return true

				end

			end

		end

		return false

	end

	GetM = function(Name)

		for _, tab in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do

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

		for _, v4 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do

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

		if not Root then

			return

		end

		if Method == "Soru" and Var then

			for _, gc in next, getgc() do

				if plr.Character.Soru then

					if ((typeof(gc) == "function") and (getfenv(gc).script == plr.Character.Soru)) then

						for _, v in next, getupvalues(gc) do

							if (typeof(v) == "table") then

								repeat

									wait(Sec)

									v.LastUse = 0

								until not Var or (plr.Character.Humanoid.Health <= 0)

							end

						end

					end

				end

			end

		elseif Method == "Energy" and Var then

			plr.Character.Energy.Changed:connect(function()

				if Var then

					plr.Character.Energy.Value = Energy

				end

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

					if tonumber(v['Count']) < 12 then

						TeleportService:TeleportToPlaceInstance(game.PlaceId, _)

					end

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

	if blockfind and blockfind ~= block then

		blockfind:Destroy()

	end

	task.spawn(function()

		while task.wait() do

			if block and block.Parent == workspace then

				if shouldTween then

					getgenv().OnFarm = true

				else

					getgenv().OnFarm = false

				end

			else

				getgenv().OnFarm = false

			end

		end

	end)

	task.spawn(function()

		local a = game.Players.LocalPlayer;

		repeat

			task.wait()

		until a.Character and a.Character.PrimaryPart;

		block.CFrame = a.Character.PrimaryPart.CFrame;

		while task.wait() do

			pcall(function()

				if getgenv().OnFarm then

					if block and block.Parent == workspace then

						local b = a.Character and a.Character.PrimaryPart;

						if b and (b.Position - block.Position).Magnitude <= 200 then

							b.CFrame = block.CFrame

						else

							block.CFrame = b.CFrame

						end

					end;

					local c = a.Character;

					if c then

						for d, e in pairs(c:GetChildren()) do

							if e:IsA("BasePart") then

								e.CanCollide = false

							end

						end

					end

				else

					local c = a.Character;

					if c then

						for d, e in pairs(c:GetChildren()) do

							if e:IsA("BasePart") then

								e.CanCollide = true

							end

						end

					end

				end

			end)

		end

	end)

	_tp = function(target)

		local character = plr.Character

		if not character or not character:FindFirstChild("HumanoidRootPart") then

			return

		end

		local rootPart = character.HumanoidRootPart

		local distance = (target.Position - rootPart.Position).Magnitude

		local tweenInfo = TweenInfo.new(distance / 199, Enum.EasingStyle.Linear)

		local tween = game:GetService("TweenService"):Create(block, tweenInfo, {

			CFrame = target

		})

		if plr.Character.Humanoid.Sit == true then

			block.CFrame = CFrame.new(block.Position.X, target.Y, block.Position.Z)

		end

		tween:Play()

		task.spawn(function()

			while tween.PlaybackState == Enum.PlaybackState.Playing do

				if not shouldTween then

					tween:Cancel()

					break

				end

				task.wait(0.1)

			end

		end)

	end

	TeleportToTarget = function(targetCFrame)

		if (targetCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude > 1000 then

			_tp(targetCFrame)

		else

			_tp(targetCFrame)

		end

	end

	notween = function(p)

		plr.Character.HumanoidRootPart.CFrame = p

	end

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

				if _G.SailBoat_Hydra or _G.WardenBoss or _G.FarmBoss or _G.tpSubmarineWorker or _G.AutoFactory or _G.HighestMirage or _G.HCM or _G.PGB or _G.Leviathan1 or _G.UPGDrago or _G.Complete_Trials or _G.TpDrago_Prehis or _G.BuyDrago or _G.AutoFireFlowers or _G.DT_Uzoth or _G.AutoBerry or _G.Prehis_Find or _G.Prehis_Skills or _G.Prehis_DB or _G.Prehis_DE or _G.FarmBlazeEM or _G.Dojoo or _G.CollectPresent or _G.AutoLawKak or _G.TpLab or _G.AutoPhoenixF or _G.AutoFarmChest or _G.AutoHytHallow or _G.LongsWord or _G.BlackSpikey or _G.AutoHolyTorch or _G.TrainDrago  or _G.AutoSaber or _G.FarmMastery_Dev or _G.CitizenQuest or _G.AutoEctoplasm or _G.KeysRen or _G.Auto_Rainbow_Haki or _G.obsFarm or _G.AutoBigmom or _G.Doughv2 or _G.AuraBoss or _G.Raiding or _G.Auto_Cavender or _G.TpPly or _G.Bartilo_Quest or _G.Level or _G.FarmEliteHunt or _G.AutoZou or _G.AutoFarm_Bone or getgenv().AutoMaterial or _G.CraftVM or _G.FrozenTP or _G.TPDoor or _G.AcientOne or _G.AutoFarmNear or _G.AutoRaidCastle or _G.DarkBladev3 or _G.AutoFarmRaid or _G.Auto_Cake_Prince or _G.Addealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.FarmChestM or _G.Shark or _G.TerrorShark or _G.Piranha or _G.MobCrew or _G.SeaBeast1 or _G.FishBoat or _G.AutoPole or _G.AutoPoleV2 or _G.Auto_SuperHuman or _G.AutoDeathStep or _G.Auto_SharkMan_Karate or _G.Auto_Electric_Claw or _G.AutoDragonTalon or _G.Auto_Def_DarkCoat or _G.Auto_God_Human or _G.Auto_Tushita or _G.AutoMatSoul or _G.AutoKenVTWO or _G.AutoSerpentBow or _G.AutoFMon or _G.Auto_Soul_Guitar or _G.TPGEAR or _G.AutoSaw or _G.AutoTridentW2 or _G.Auto_StartRaid or _G.AutoEvoRace or _G.AutoGetQuestBounty or _G.MarinesCoat or _G.TravelDres or _G.Defeating or _G.DummyMan or _G.Auto_Yama or _G.Auto_SwanGG or _G.SwanCoat or _G.AutoEcBoss or _G.Auto_Mink or _G.Auto_Human or _G.Auto_Skypiea or _G.Auto_Fish or _G.CDK_TS or _G.CDK_YM or _G.CDK or _G.AutoFarmGodChalice or _G.AutoFistDarkness or _G.AutoMiror or _G.Teleport or _G.AutoKilo or _G.AutoGetUsoap or _G.Praying or _G.TryLucky or _G.AutoColShad or _G.AutoUnHaki or _G.Auto_DonAcces or _G.AutoRipIngay or _G.DragoV3 or _G.DragoV1 or _G.SailBoats or NextIs or _G.FarmGodChalice or _G.IceBossRen or senth or senth2 or _G.Lvthan or _G.beasthunter or _G.DangerLV or _G.Relic123 or _G.tweenKitsune or _G.Collect_Ember or _G.AutofindKitIs or _G.snaguine or _G.TwFruits or _G.tweenKitShrine or _G.Tp_LgS or _G.Tp_MasterA or _G.tweenShrine or _G.FarmMastery_G or _G.FarmMastery_S or _G.FarmPhaBinh or _G.FarmTyrant or _G.QuestType or _G.AutoQuest or _G.FarmTyrantHop or _G.Rip_Indra_Hop or _G.DarkbeardHop or _G.EliteHop or _G.DoughKingHop or _G.SoulReaperHop or _G.StartQuest then

					shouldTween = true

					if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then

						local Noclip = Instance.new("BodyVelocity")

						Noclip.Name = "BodyClip"

						Noclip.Parent = plr.Character.HumanoidRootPart

						Noclip.MaxForce = Vector3.new(100000, 100000, 100000)

						Noclip.Velocity = Vector3.new(0, 0, 0)

					end

					if not plr.Character:FindFirstChild('highlight') then

						local Test = Instance.new('Highlight')

						Test.Name = "highlight"

						Test.Enabled = true

						Test.FillColor = Color3.fromRGB(0, 0, 0)

						Test.OutlineColor = Color3.fromRGB(255, 255, 255)

						Test.FillTransparency = 1

						Test.OutlineTransparency = 1

						Test.Parent = plr.Character

					end

					for _, no in pairs(plr.Character:GetDescendants()) do

						if no:IsA("BasePart") then

							no.CanCollide = false

						end

					end

				else

					shouldTween = false

					if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then

						plr.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()

					end

					if plr.Character:FindFirstChild('highlight') then

						plr.Character:FindFirstChild('highlight'):Destroy()

					end

				end

			end)

		end

	end)

	QuestB = function()

		if World1 then

			if _G.FindBoss == "The Gorilla King" then

				bMon = "The Gorilla King"

				Qname = "JungleQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)

				PosB = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)

			elseif _G.FindBoss == "Bobby" then

				bMon = "Bobby"

				Qname = "BuggyQuest1"

				Qdata = 3;

				PosQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)

				PosB = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)

			elseif _G.FindBoss == "The Saw" then

				bMon = "The Saw"

				PosB = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)

			elseif _G.FindBoss == "Yeti" then

				bMon = "Yeti"

				Qname = "SnowQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)

				PosB = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)

			elseif _G.FindBoss == "Mob Leader" then

				bMon = "Mob Leader"

				PosB = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)

			elseif _G.FindBoss == "Vice Admiral" then

				bMon = "Vice Admiral"

				Qname = "MarineQuest2"

				Qdata = 2;

				PosQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)

				PosB = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)

			elseif _G.FindBoss == "Saber Expert" then

				bMon = "Saber Expert"

				PosB = CFrame.new(-1458.89502, 29.8870335, -50.633564)

			elseif _G.FindBoss == "Warden" then

				bMon = "Warden"

				Qname = "ImpelQuest"

				Qdata = 1;

				PosB = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)

				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)

			elseif _G.FindBoss == "Chief Warden" then

				bMon = "Chief Warden"

				Qname = "ImpelQuest"

				Qdata = 2;

				PosB = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)

				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)

			elseif _G.FindBoss == "Swan" then

				bMon = "Swan"

				Qname = "ImpelQuest"

				Qdata = 3;

				PosB = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)

				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)

			elseif _G.FindBoss == "Magma Admiral" then

				bMon = "Magma Admiral"

				Qname = "MagmaQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)

				PosB = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)

			elseif _G.FindBoss == "Fishman Lord" then

				bMon = "Fishman Lord"

				Qname = "FishmanQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)

				PosB = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)

			elseif _G.FindBoss == "Wysper" then

				bMon = "Wysper"

				Qname = "SkyExp1Quest"

				Qdata = 3;

				PosQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)

				PosB = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)

			elseif _G.FindBoss == "Thunder God" then

				bMon = "Thunder God"

				Qname = "SkyExp2Quest"

				Qdata = 3;

				PosQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)

				PosB = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)

			elseif _G.FindBoss == "Cyborg" then

				bMon = "Cyborg"

				Qname = "FountainQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)

				PosB = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)

			elseif _G.FindBoss == "Ice Admiral" then

				bMon = "Ice Admiral"

				Qdata = nil;

				PosQBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)

				PosB = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)

			elseif _G.FindBoss == "Greybeard" then

				bMon = "Greybeard"

				Qdata = nil;

				PosQBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)

				PosB = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)

			end

		end;

		if World2 then

			if _G.FindBoss == "Diamond" then

				bMon = "Diamond"

				Qname = "Area1Quest"

				Qdata = 3;

				PosQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)

				PosB = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)

			elseif _G.FindBoss == "Jeremy" then

				bMon = "Jeremy"

				Qname = "Area2Quest"

				Qdata = 3;

				PosQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)

				PosB = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)

			elseif _G.FindBoss == "Fajita" then

				bMon = "Fajita"

				Qname = "MarineQuest3"

				Qdata = 3;

				PosQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)

				PosB = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)

			elseif _G.FindBoss == "Don Swan" then

				bMon = "Don Swan"

				PosB = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)

			elseif _G.FindBoss == "Smoke Admiral" then

				bMon = "Smoke Admiral"

				Qname = "IceSideQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)

				PosB = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)

			elseif _G.FindBoss == "Awakened Ice Admiral" then

				bMon = "Awakened Ice Admiral"

				Qname = "FrostQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)

				PosB = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)

			elseif _G.FindBoss == "Tide Keeper" then

				bMon = "Tide Keeper"

				Qname = "ForgottenQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)

				PosB = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)

			elseif _G.FindBoss == "Darkbeard" then

				bMon = "Darkbeard"

				Qdata = nil;

				PosQBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)

				PosB = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)

			elseif _G.FindBoss == "Cursed Captaim" then

				bMon = "Cursed Captain"

				Qdata = nil;

				PosQBoss = CFrame.new(916.928589, 181.092773, 33422)

				PosB = CFrame.new(916.928589, 181.092773, 33422)

			elseif _G.FindBoss == "Order" then

				bMon = "Order"

				Qdata = nil;

				PosQBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)

				PosB = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)

			end

		end;

		if World3 then

			if _G.FindBoss == "Stone" then

				bMon = "Stone"

				Qname = "PiratePortQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)

				PosB = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)

			elseif _G.FindBoss == "Hydra Leader" then

				bMon = "Hydra Leader"

				Qname = "VenomCrewQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(5211.021484375, 1004.35778859375, 758.1847534179688)

				PosB = CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547)

			elseif _G.FindBoss == "Kilo Admiral" then

				bMon = "Kilo Admiral"

				Qname = "MarineTreeIsland"

				Qdata = 3;

				PosQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)

				PosB = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)

			elseif _G.FindBoss == "Captain Elephant" then

				bMon = "Captain Elephant"

				Qname = "DeepForestIsland"

				Qdata = 3;

				PosQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)

				PosB = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)

			elseif _G.FindBoss == "Beautiful Pirate" then

				bMon = "Beautiful Pirate"

				Qname = "DeepForestIsland2"

				Qdata = 3;

				PosQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)

				PosB = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)

			elseif _G.FindBoss == "Cake Queen" then

				bMon = "Cake Queen"

				Qname = "IceCreamIslandQuest"

				Qdata = 3;

				PosQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)

				PosB = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)

			elseif _G.FindBoss == "Longma" then

				bMon = "Longma"

				Qdata = nil;

				PosQBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)

				PosB = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)

			elseif _G.FindBoss == "Soul Reaper" then

				bMon = "Soul Reaper"

				Qdata = nil;

				PosQBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)

				PosB = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)

			end

		end

	end

	QuestBeta = function()

		local Neta = QuestB()

		return {

			[0] = _G.FindBoss,

			[1] = bMon,

			[2] = Qdata,

			[3] = Qname,

			[4] = PosB,

			[5] = PosQBoss,

		}  

	end

	QuestCheck = function()

		local a = game.Players.LocalPlayer.Data.Level.Value;

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

			elseif a >= 2575 and a <= 2599 then -- CHá» Tá»I 2599, Äá» 2600 chuyá»n qua Submarine

				Mon = "Skull Slayer"

				Qdata = 2;

				Qname = "TikiQuest3";

				NameMon = "Skull Slayer"

				PosQ = CFrame.new(-16759.5898, 71.2837, 1595.3399)

				PosM = CFrame.new(-16759.5898, 71.2837, 1595.3399)



	-- SUBMARINE AREA (ÄÃºng má»c 2600 / 2625 / 2650 / 2675)

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

	MaterialMon = function()

		local a = game.Players.LocalPlayer;

		local b = a.Character and a.Character:FindFirstChild("HumanoidRootPart")

		if not b then

			return

		end;

		shouldRequestEntrance = function(c, d)

			local e = (b.Position - c).Magnitude;

			if e >= d then

				replicated.Remotes.CommF_:InvokeServer("requestEntrance", c)

			end

		end;

		if World1 then

			if SelectMaterial == "Angel Wings" then

				MMon = {

					"Shanda",

					"Royal Squad",

					"Royal Soldier",

					"Wysper",

					"Thunder God"

				}

				MPos = CFrame.new(-4698, 845, -1912)

				SP = "Default"

				local c = Vector3.new(-4607.82275, 872.54248, -1667.55688)

				shouldRequestEntrance(c, 10000)

			elseif SelectMaterial == "Leather + Scrap Metal" then

				MMon = {

					"Brute",

					"Pirate"

				}

				MPos = CFrame.new(-1145, 15, 4350)

				SP = "Default"

			elseif SelectMaterial == "Magma Ore" then

				MMon = {

					"Military Soldier",

					"Military Spy",

					"Magma Admiral"

				}

				MPos = CFrame.new(-5815, 84, 8820)

				SP = "Default"

			elseif SelectMaterial == "Fish Tail" then

				MMon = {

					"Fishman Warrior",

					"Fishman Commando",

					"Fishman Lord"

				}

				MPos = CFrame.new(61123, 19, 1569)

				SP = "Default"

				local c = Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)

				shouldRequestEntrance(c, 17000)

			end

		elseif World2 then

			if SelectMaterial == "Leather + Scrap Metal" then

				MMon = {

					"Marine Captain"

				}

				MPos = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375)

				SP = "Default"

			elseif SelectMaterial == "Magma Ore" then

				MMon = {

					"Magma Ninja",

					"Lava Pirate"

				}

				MPos = CFrame.new(-5428, 78, -5959)

				SP = "Default"

			elseif SelectMaterial == "Ectoplasm" then

				MMon = {

					"Ship Deckhand",

					"Ship Engineer",

					"Ship Steward",

					"Ship Officer"

				}

				MPos = CFrame.new(911.35827636719, 125.95812988281, 33159.5390625)

				SP = "Default"

				local c = Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)

				shouldRequestEntrance(c, 18000)

			elseif SelectMaterial == "Mystic Droplet" then

				MMon = {

					"Water Fighter"

				}

				MPos = CFrame.new(-3385, 239, -10542)

				SP = "Default"

			elseif SelectMaterial == "Radioactive Material" then

				MMon = {

					"Factory Staff"

				}

				MPos = CFrame.new(295, 73, -56)

				SP = "Default"

			elseif SelectMaterial == "Vampire Fang" then

				MMon = {

					"Vampire"

				}

				MPos = CFrame.new(-6033, 7, -1317)

				SP = "Default"

			end

		elseif World3 then

			if SelectMaterial == "Scrap Metal" then

				MMon = {

					"Jungle Pirate",

					"Forest Pirate"

				}

				MPos = CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375)

				SP = "Default"

			elseif SelectMaterial == "Fish Tail" then

				MMon = {

					"Fishman Raider",

					"Fishman Captain"

				}

				MPos = CFrame.new(-10993, 332, -8940)

				SP = "Default"

			elseif SelectMaterial == "Conjured Cocoa" then

				MMon = {

					"Chocolate Bar Battler",

					"Cocoa Warrior"

				}

				MPos = CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625)

				SP = "Default"

			elseif SelectMaterial == "Dragon Scale" then

				MMon = {

					"Dragon Crew Archer",

					"Dragon Crew Warrior"

				}

				MPos = CFrame.new(6594, 383, 139)

				SP = "Default"

			elseif SelectMaterial == "Gunpowder" then

				MMon = {

					"Pistol Billionaire"

				}

				MPos = CFrame.new(-84.8556900024414, 85.62061309814453, 6132.0087890625)

				SP = "Default"

			elseif SelectMaterial == "Mini Tusk" then

				MMon = {

					"Mythological Pirate"

				}

				MPos = CFrame.new(-13545, 470, -6917)

				SP = "Default"

			elseif SelectMaterial == "Demonic Wisp" then

				MMon = {

					"Demonic Soul"

				}

				MPos = CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)

				SP = "Default"

			end

		end

	end

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

function Hop()

    local PlaceID = game.PlaceId

    local AllIDs = {}

    local foundAnything = ""

    local actualHour = os.date("!*t").hour

    function TPReturner()

        local Site

        if foundAnything == "" then

            Site = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"))

        else

            Site = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything))

        end

        if Site.nextPageCursor and Site.nextPageCursor ~= "null" then

            foundAnything = Site.nextPageCursor

        end

        local num = 0

        for _, v in pairs(Site.data) do

            local Possible = true

            local ID = tostring(v.id)

            if tonumber(v.maxPlayers) > tonumber(v.playing) then

                for _, Existing in pairs(AllIDs) do

                    if num ~= 0 then

                        if ID == tostring(Existing) then

                            Possible = false

                        end

                    else

                        if tonumber(actualHour) ~= tonumber(Existing) then

                            local _ = pcall(function()

                                AllIDs = {}

                                table.insert(AllIDs, actualHour)

                            end)

                        end

                    end

                    num = num + 1

                end

                if Possible then

                    table.insert(AllIDs, ID)

                    wait(0.1)

                    pcall(function()

                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)

                    end)

                    wait(1)

                    break

                end

            end

        end

    end

    function Teleport()

        while wait() do

            pcall(function()

                TPReturner()

                if foundAnything ~= "" then

                    TPReturner()

                end

            end)

            wait(HopDelay)

        end

    end

    Teleport()

end

-- Fast Attack

local FastAttackModule = {}

local HitRegistrationModule = {}

local MainController = {}



-- Services

local GameService = game

local Players = GameService:GetService("Players")

local RunService = GameService:GetService("RunService")

local ReplicatedStorage = GameService:GetService("ReplicatedStorage")

local Workspace = GameService:GetService("Workspace")



-- Player

local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()



-- Helper function

local function SafeWaitForChild(parent, childName)

    local success, result = pcall(function()

        return parent:WaitForChild(childName)

    end)

    return result

end



-- Game objects

local Enemies = SafeWaitForChild(Workspace, "Enemies")

local Characters = SafeWaitForChild(Workspace, "Characters")

local Modules = SafeWaitForChild(ReplicatedStorage, "Modules")

local Net = SafeWaitForChild(Modules, "Net")



-- Configuration

FastAttackModule.Rate = 0.000000002

FastAttackModule.Enabled = true



-- Core functions

function FastAttackModule.IsAlive(target)

    local humanoid = target:FindFirstChild("Humanoid")

    if humanoid and humanoid.Health > 0 then

        return true

    end

    return false

end



function FastAttackModule.GetNearbyTargets(character, folder)

    local characterPosition = character:GetPivot().Position

    local nearbyTargets = {}

    local children = folder:GetChildren()

    

    for i = 1, #children do

        local target = children[i]

        local humanoid = target:FindFirstChild("Humanoid")

        local rootPart = target:FindFirstChild("HumanoidRootPart")

        

        if humanoid and rootPart and humanoid.Health > 0 then

            local distance = (rootPart.Position - characterPosition).Magnitude

            if distance <= 60 then

                table.insert(nearbyTargets, target)

            end

        end

    end

    return nearbyTargets

end



function FastAttackModule.GetTargetParts(targetList)

    local result = {}

    local count = #targetList

    

    for i = 1, count do

        local target = targetList[i]

        local head = target:FindFirstChild("Head") or target.PrimaryPart

        if head then

            table.insert(result, {target, head})

        end

    end

    return result

end



function FastAttackModule.GetAllTargets(character)

    local enemies = FastAttackModule.GetNearbyTargets(character, Enemies)

    local otherCharacters = FastAttackModule.GetNearbyTargets(character, Characters)

    

    local allTargets = {}

    for i = 1, #enemies do

        table.insert(allTargets, enemies[i])

    end

    for i = 1, #otherCharacters do

        table.insert(allTargets, otherCharacters[i])

    end

    return allTargets

end



function FastAttackModule.ExecuteFastAttack()

    local character = LocalPlayer.Character

    if not character then return end

    

    local tool = character:FindFirstChildOfClass("Tool")

    if not tool then return end

    

    local targets = FastAttackModule.GetAllTargets(character)

    if #targets < 1 then return end

    

    local targetParts = FastAttackModule.GetTargetParts(targets)

    if #targetParts < 1 then return end

    

    local attackRemote = Net["RE/RegisterAttack"]

    local hitRemote = Net["RE/RegisterHit"]

    

    attackRemote:FireServer(FastAttackModule.Rate)

    local targetHead = targetParts[1][2]

    hitRemote:FireServer(targetHead, targetParts)

end



-- Hit Registration System

local AttackRemoteTarget

local AttackRemoteId



local function InitializeHitRegistration()

    local foldersToCheck = {

        ReplicatedStorage.Util,

        ReplicatedStorage.Common,

        ReplicatedStorage.Remotes,

        ReplicatedStorage.Assets,

        ReplicatedStorage.FX

    }



    for _, folder in ipairs(foldersToCheck) do

        local children = folder:GetChildren()

        

        for _, child in ipairs(children) do

            if child:IsA("RemoteEvent") and child:GetAttribute("Id") then

                AttackRemoteTarget = child

                AttackRemoteId = child:GetAttribute("Id")

            end

        end



        folder.ChildAdded:Connect(function(child)

            if child:IsA("RemoteEvent") and child:GetAttribute("Id") then

                AttackRemoteTarget = child

                AttackRemoteId = child:GetAttribute("Id")

            end

        end)

    end

end



InitializeHitRegistration()



function HitRegistrationModule.Execute()

    local character = LocalPlayer.Character

    if not character then return end

    

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart then return end

    

    local hitTargets = {}



    local function ScanFolder(folder)

        local children = folder:GetChildren()

        for i = 1, #children do

            local target = children[i]

            local humanoid = target:FindFirstChild("Humanoid")

            local rootPart = target:FindFirstChild("HumanoidRootPart")

            

            if humanoid and rootPart and humanoid.Health > 0 and target ~= character then

                local distance = (rootPart.Position - humanoidRootPart.Position).Magnitude

                if distance <= 60 then

                    local targetChildren = target:GetChildren()

                    for _, child in ipairs(targetChildren) do

                        if child:IsA("BasePart") then

                            table.insert(hitTargets, {target, child})

                        end

                    end

                end

            end

        end

    end



    ScanFolder(Enemies)

    ScanFolder(Characters)



    local tool = character:FindFirstChildOfClass("Tool")

    

    if #hitTargets > 0 and tool and (tool:GetAttribute("WeaponType") == "Melee" or tool:GetAttribute("WeaponType") == "Sword") then

        local seed = Modules.Net.seed:InvokeServer()

        

        local attackRemote = Net["RE/RegisterAttack"]

        local hitRemote = Net["RE/RegisterHit"]

        

        attackRemote:FireServer()

        

        local targetHead = hitTargets[1][1]:FindFirstChild("Head")

        if not targetHead then return end



        hitRemote:FireServer(targetHead, hitTargets, {})

        

        if AttackRemoteTarget then

            local remoteCode = "RE/RegisterHit"

            local encryptionKey = math.floor(Workspace:GetServerTimeNow() / 10 % 10) + 1

            

            local encodedString = string.gsub(remoteCode, ".", function(char)

                return string.char(bit32.bxor(string.byte(char), encryptionKey))

            end)



            local finalId = bit32.bxor(AttackRemoteId + 909090, seed * 2)

            

            cloneref(AttackRemoteTarget):FireServer(

                encodedString,

                finalId,

                targetHead,

                hitTargets

            )

        end

    end

end



-- Camera Control

local function DisableCameraShake()

    local cameraModule = require(ReplicatedStorage.Util.CameraShaker)

    cameraModule:Stop()

end



-- Main Loop Initialization

local function StartMainLoops()

    task.spawn(function()

        while task.wait(FastAttackModule.Rate) do

            FastAttackModule.ExecuteFastAttack()

        end

    end)



    RunService.Heartbeat:Connect(function()

        pcall(HitRegistrationModule.Execute)

    end)

end



-- Main Controller

function MainController.Start()

    DisableCameraShake()

    StartMainLoops()

end



-- Start the system

MainController.Start()



-- Unused variables (cleanup)

local unusedData1 = {}

local unusedData2 = {}

local unusedData3 = {}

local unusedData4 = {}

local unusedData5 = {}



local function GeneratePadding(text)

    return text .. text .. text

end



unusedData1.a = GeneratePadding("d")

unusedData2.b = GeneratePadding("x")

unusedData3.c = GeneratePadding("o")

unusedData4.d = GeneratePadding("k")

unusedData5.e = GeneratePadding("p")



-- Clean up unused calculations

local totalSum = 0

for i = 1, 1000 do

    totalSum = totalSum + i

end



local temporaryData = {}

for i = 1, 250 do

    temporaryData[i] = i * 3

end



local function GenerateString(length)

    local result = ""

    for i = 1, length do

        result = result .. string.char((i % 26) + 97)

    end

    return result

end



-- Clean up unused strings

local unusedString1 = GenerateString(5000)

local unusedString2 = GenerateString(3000)

local unusedString3 = GenerateString(2000)  



-- Minimize UI

local ScreenGui = Instance.new('ScreenGui')

local MainButton = Instance.new('ImageButton')

local ImageLabel = Instance.new("ImageLabel")

local ButtonCorner = Instance.new('UICorner')

local ButtonStroke = Instance.new("UIStroke")

local ButtonAspectRatio = Instance.new("UIAspectRatioConstraint")



-- Cấu hình ScreenGui

ScreenGui.Name = 'DraggableButtonGui'

ScreenGui.Parent = game:GetService('CoreGui')

ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ScreenGui.ResetOnSpawn = false

ScreenGui.IgnoreGuiInset = true



-- Cấu hình ImageButton

MainButton.Name = 'MainButton'

MainButton.Parent = ScreenGui

MainButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

MainButton.BackgroundTransparency = 0.32

MainButton.BorderSizePixel = 0

MainButton.ClipsDescendants = true

MainButton.Size = UDim2.new(0, 55, 0, 55)

MainButton.Position = UDim2.new(0, 10, 1, -58)

MainButton.Image = "rbxassetid://81213277023664"

MainButton.AutoButtonColor = false

MainButton.Active = true

MainButton.Selectable = true



ImageLabel.Parent = MainButton

ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)

ImageLabel.Position = UDim2.new(0, 16, 0, 254)

ImageLabel.Size = UDim2.new(0, 40, 0, 40)

ImageLabel.BackgroundTransparency = 1

ImageLabel.BorderSizePixel = 0

ImageLabel.ImageColor3 = Color3.fromRGB(36, 36, 36)



-- Cấu hình UICorner

ButtonCorner.CornerRadius = UDim.new(1, 0)

ButtonCorner.Parent = MainButton



-- Cấu hình UIStroke

ButtonStroke.Parent = MainButton

ButtonStroke.Thickness = 3.3

ButtonStroke.Color = Color3.fromRGB(0, 0, 0)

ButtonStroke.Transparency = 0.5



-- Cấu hình UIAspectRatioConstraint

ButtonAspectRatio.Parent = MainButton

ButtonAspectRatio.AspectRatio = 1



-- === HIỆU ỨNG KHI VIỀN DÀY/XUỐNG ===

local TweenService = game:GetService("TweenService")



-- Tween settings

local tweenInfo = TweenInfo.new(

    0.15,

    Enum.EasingStyle.Quad,

    Enum.EasingDirection.Out

)



-- === TRẠNG THÁI VIỀN ===

local isBorderThick = false



-- === BIẾN DRAG ===

local dragStartPos = nil

local dragStartButtonPos = nil

local dragInput = nil

local isDragging = false



-- === HIỆU ỨNG VIỀN DÀY ===

local function ThickBorderEffect()

    local thickTween = TweenService:Create(ButtonStroke, tweenInfo, {

        Thickness = 1.9,

        Transparency = 0

    })

    thickTween:Play()

    ButtonStroke.Color = Color3.fromRGB(0, 0, 0)

    isBorderThick = true

end



-- === HIỆU ỨNG VIỀN MỎNG ===

local function ThinBorderEffect()

    local thinTween = TweenService:Create(ButtonStroke, tweenInfo, {

        Thickness = 1.7,

        Transparency = 0.5

    })

    thinTween:Play()

    isBorderThick = false

end



-- === HÀM XỬ LÝ KÉO THẢ ===

local function updateDragPosition(input)

    local delta = input.Position - dragStartPos

    local newPosition = UDim2.new(

        dragStartButtonPos.X.Scale, 

        dragStartButtonPos.X.Offset + delta.X,

        dragStartButtonPos.Y.Scale, 

        dragStartButtonPos.Y.Offset + delta.Y

    )

    

    TweenService:Create(MainButton, TweenInfo.new(0.2), {Position = newPosition}):Play()

end



-- === SỰ KIỆN BẮT ĐẦU KÉO ===

MainButton.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then

        isDragging = true

        dragStartPos = input.Position

        dragStartButtonPos = MainButton.Position

        

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then

                isDragging = false

            end

        end)

    end

end)



-- === SỰ KIỆN THAY ĐỔI INPUT ===

MainButton.InputChanged:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then

        dragInput = input

    end

end)



-- === SỰ KIỆN INPUT CHUNG ===

game:GetService('UserInputService').InputChanged:Connect(function(input)

    if input == dragInput and isDragging then

        updateDragPosition(input)

    end

end)



-- === CLICK ĐỂ BẬT/TẮT VIỀN DÀY VÀ GỬI PHÍM ===

MainButton.MouseButton1Click:Connect(function()

    if isBorderThick then

        ThinBorderEffect()

    else

        ThickBorderEffect()

    end

    

    -- Gửi phím LeftControl

    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)

    task.wait(0.05)

    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)

end)



local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/redz-V5-remake/main.luau"))()



local Window = Library:MakeWindow({

    Title = "Redz Hub [ BETA ACCESS ] : Blox Fruits ",

    SubTitle = "",

    ScriptFolder = "SkitringX Hub"

})



Minimizer = Window:NewMinimizer({

    KeyCode = Enum.KeyCode.LeftControl

})



Discord = Window:MakeTab({

    Title = "Discord",

    Icon = "info"

})



Main = Window:MakeTab({

    Title = "Main Farm",

    Icon = "rbxassetid://7733960981"

})



Sea = Window:MakeTab({

    Title = "Sea Event",

    Icon = "waves"

})



Fish = Window:MakeTab({

    Title = "Fishing",

    Icon = "rbxassetid://127664059821666"

})



Kitsune = Window:MakeTab({

    Title = "Islands",

    Icon = "palmtree"

})



Stack = Window:MakeTab({

    Title = "Quest/Items",

    Icon = "swords"

})



Race = Window:MakeTab({

    Title = "Race-V4",

    Icon = "locatefixed"

})



Fruits = Window:MakeTab({

    Title = "Fruits/Raids",

    Icon = "cherry"

})



Items = Window:MakeTab({

    Title = "Upgrade Item",

    Icon = "rbxassetid://10709819149"

})



Server = Window:MakeTab({

    Title = "Hop",

    Icon = "gem"

})



Status = Window:MakeTab({

    Title = "Status",

    Icon = "scroll"

})



Travel = Window:MakeTab({

    Title = "Teleport",

    Icon = "compass"

})



Shop = Window:MakeTab({

    Title = "Shop",

    Icon = "shoppingcart"

})



ESP = Window:MakeTab({

    Title = "Viusal",

    Icon = "users"

})



Player = Window:MakeTab({

    Title = "Misc",

    Icon = "settings"

})



Discord:AddDiscordInvite({

	Title = "SkiringX Hub",

	Description = "A Best New Script",

  Banner = Color3.fromRGB(36, 36, 36),

	Logo = "rbxassetid://72550888769297",

	Invite = "https://discord.gg/zCchBkZxZx",

})



Discord:AddDropdown({

    Name = "Rating",

    Options = {"⭐️", "⭐️⭐️", "⭐️⭐️⭐️", "⭐️⭐️⭐️⭐️", "⭐️⭐️⭐️⭐️⭐️", "⭐️⭐️⭐️⭐️"},

    Callback = function(Value)

        getgenv().SelectStateHaki = Value

    end

})



Discord:AddTextBox({
   
    Name = "Review",

    Placeholder = "Write your review here….",

    ClearOnFocus = true,
 
    Callback = function(Value)
    
        getgenv().Job = Value
  
    end

})



-- Electric

Discord:AddButton({

    Name = "Send Review",

    Description = "67",

    Callback = function()

        Window:Dialog({

            Title = "Thank You",

            Content = "To Rate Or Not Rate",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- ===== SECTION 1: BOSS STATUS =====

Status:AddSection("Status Boss")



-- Elite Hunter

local EliteHunter = Status:AddParagraph("Elite Hunter", "Status: Loading...")



spawn(function()

    while task.wait(1) do

        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or 

                              game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or 

                              game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or 

                              game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or 

                              game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or 

                              game:GetService("Workspace").Enemies:FindFirstChild("Urban")) and '🟢' or '🔴'

        EliteHunter:SetDescription("Status: " .. currentStatus)

    end

end)



-- Cake Prince

local MobCakePrince = Status:AddParagraph("Cake Prince", "Status: Loading...")



spawn(function()

    while task.wait(1) do

        pcall(function()

            local cakePrince = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")

            if string.len(cakePrince) >= 86 then

                local killCount = string.sub(cakePrince, 39, 41)

                MobCakePrince:SetDescription("Status: 🔴 Need Kill " .. killCount .. " Mobs")

            else

                MobCakePrince:SetDescription("Status: 🔴")

            end

        end)

    end

end)



-- Tyrant of the Skies

local TyrantStatus = Status:AddParagraph("Tyrant of the Skies", "Status: Loading...")



spawn(function()

    pcall(function()

        while task.wait(1) do

            if workspace["Enemies"]:FindFirstChild("Tyrant of the Skies") then

                TyrantStatus:SetDescription("Status: ✅")

            else

                TyrantStatus:SetDescription("Status: ❌")

            end

        end

    end)

end)



-- Dough King

local CheckDoughKing = Status:AddParagraph("Dough King", "Status: Loading...")



spawn(function()

    while task.wait(1) do

        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") or 

                              game:GetService("Workspace").Enemies:FindFirstChild("Dough King")) and '🟢' or '🔴'

        CheckDoughKing:SetDescription("Status: " .. currentStatus)

    end

end)



-- rip_indra True Form

local CheckRip = Status:AddParagraph("rip_indra True Form", "Status: Loading...")



spawn(function()

    while task.wait(1) do

        local currentStatus = (game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") or 

                              game:GetService("Workspace").Enemies:FindFirstChild("rip_indra")) and '🟢' or '🔴'

        CheckRip:SetDescription("Status: " .. currentStatus)

    end

end)



-- Spy Leviathan

local SPYING = Status:AddParagraph("Spy Leviathan", "Status: Loading...")



spawn(function()

    while task.wait(0.2) do

        pcall(function()

            local spycheck = string.match(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan","1"),"%d+")

            if spycheck then 

                if tostring(spycheck) == "5" then

                    SPYING:SetDescription("Status: 🟢 (Full)")

                else

                    SPYING:SetDescription("Spy Leviathan: "..tostring(spycheck).."/5")

                end

            end

        end)

    end

end)



-- ===== SECTION 2: EVENT STATUS =====

Status:AddSection("Event Status")



-- Full Moon

local FM = Status:AddParagraph("Full Moon", "Status: Loading...")



task.spawn(function()

    while task.wait(1) do

        pcall(function()

            local moonTextureId = game:GetService("Lighting").Sky.MoonTextureId

            local moonStatus = "Bad Moon | 0"

            

            if moonTextureId == "http://www.roblox.com/asset/?id=9709149431" then

                moonStatus = "Full Moon | 5"

            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149052" then

                moonStatus = "Near Full Moon | 4"

            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709143733" then

                moonStatus = "Bad Moon | 3"

            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709150401" then

                moonStatus = "Bad Moon | 2"

            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149680" then

                moonStatus = "Bad Moon | 1"

            end

            

            FM:SetDescription("Status: " .. moonStatus)

        end)

    end

end)



-- Legendary Sword Dealer

local LegendarySword = Status:AddParagraph("Legendary Sword", "Status: Loading...")



spawn(function()

    while task.wait(1) do

        pcall(function()

            local swordStatus = "🔴"

            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") or

               game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2") or

               game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3") then

                swordStatus = "🟢"

            end

            LegendarySword:SetDescription("Status: " .. swordStatus)

        end)

    end

end)



-- ===== SECTION 4: SEA STATUS =====

Status:AddSection("Sea Status")



-- Current Sea

local SeaStatus = Status:AddParagraph("Current Sea", "Loading...")



spawn(function()

    while task.wait(1) do

        pcall(function()

            local sea = "Sea 1"

            if game:GetService("Workspace").Map:FindFirstChild("SecondSea") then

                sea = "Sea 2"

            elseif game:GetService("Workspace").Map:FindFirstChild("ThirdSea") then

                sea = "Sea 3"

            end

            SeaStatus:SetDescription("You are in: " .. sea)

        end)

    end

end)



-- Game Time

local GameTime = Status:AddParagraph("Game Time", "Loading...")



spawn(function()

    while task.wait(1) do

        pcall(function()

            local time = game:GetService("Lighting").ClockTime

            local hour = math.floor(time)

            local minute = math.floor((time - hour) * 60)

            GameTime:SetDescription(string.format("Time: %02d:%02d", hour, minute))

        end)

    end

end)



Shop:AddSection("Sword Shop")



-- Katana

Shop:AddButton({

    Name = "Katana Sword",

    Description = "1.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = " buy ",

            Content = "Do You Want Buy Katana Sword?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Katana")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Cutlass

Shop:AddButton({

    Name = "Cutlass Sword",

    Description = "1.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "buy",

            Content = "Do You Want Buy Cutlass Sword?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Dual Katana

Shop:AddButton({

    Name = "Dual Katana",

    Description = "25.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Dual Katana?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Iron Mace

Shop:AddButton({

    Name = "Iron Mace",

    Description = "25.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Iron Mace?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Triple Katana

Shop:AddButton({

    Name = "Triple Katana",

    Description = "60.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Triple Katana?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Pipe

Shop:AddButton({

    Name = "Pipe",

    Description = "100.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Pipe?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Pipe")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Dual-Headed Blade

Shop:AddButton({

    Name = "Dual-Headed Blade",

    Description = "400.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Dual-Headed Blade?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Soul Cane

Shop:AddButton({

    Name = "Soul Cane",

    Description = "700.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Soul Cane?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Bisento

Shop:AddButton({

    Name = "Bisento",

    Description = "1.000.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Bisento?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Bisento")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Pole V2

Shop:AddButton({

    Name = "Pole V2",

    Description = "2.000.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Get Pole V2?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ThunderGodTalk")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Legendary Sword

Shop:AddButton({

    Name = "Legendary Sword",

    Description = "2.000.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Legendary Sword?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1")

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- True Triple Katana

Shop:AddButton({

    Name = "True Triple Katana",

    Description = "2.000.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy True Triple Katana?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("MysteriousMan", "2")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



Shop:AddSection("Fighting Styles Shop")



-- Dark Step

Shop:AddButton({

    Name = "Dark Step",

    Description = "150.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Dark Step?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Electric

Shop:AddButton({

    Name = "Electric",

    Description = "500.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Electric?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Fishman Karate

Shop:AddButton({

    Name = "Fishman Karate",

    Description = "500.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Fishman Karate?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Dragon Breath

Shop:AddButton({

    Name = "Dragon Breath",

    Description = "1.500 Fragments",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Dragon Breath?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        pcall(function()

                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")

                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")

                        end)

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Superhuman

Shop:AddButton({

    Name = "Superhuman",

    Description = "3.000.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Superhuman?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Death Step

Shop:AddButton({

    Name = "Death Step",

    Description = "2.500.000 Beli | 5.000 Fragments",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Death Step?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Sharkman Karate

Shop:AddButton({

    Name = "Sharkman Karate",

    Description = "2.500.000 Beli | 5.000 Fragments",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Sharkman Karate?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)

                        wait(0.2)

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Electric Claw

Shop:AddButton({

    Name = "Electric Claw",

    Description = "3.000.000 Beli | 5.000 Fragments",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Electric Claw?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Dragon Talon

Shop:AddButton({

    Name = "Dragon Talon",

    Description = "3.000.000 Beli | 5.000 Fragments",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Dragon Talon?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Godhuman

Shop:AddButton({

    Name = "Godhuman",

    Description = "5.000.000 Beli | 5.000 Fragments",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Godhuman?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Sanguine Art

Shop:AddButton({

    Name = "Sanguine Art",

    Description = "5.000.000 Beli | 5.000 Fragments",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Sanguine Art?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt", true)

                        wait(0.2)

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



Shop:AddSection("Gun Shop")



-- Slingshot

Shop:AddButton({

    Name = "Slingshot",

    Description = "5.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Slingshot?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Slingshot")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Musket

Shop:AddButton({

    Name = "Musket",

    Description = "8.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Musket?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Musket")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Flintlock

Shop:AddButton({

    Name = "Flintlock",

    Description = "10.500 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Flintlock?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Flintlock")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Refined Flintlock

Shop:AddButton({

    Name = "Refined Flintlock",

    Description = "30.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Refined Flintlock?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Dual Flintlock

Shop:AddButton({

    Name = "Dual Flintlock",

    Description = "65.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Dual Flintlock?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Cannon

Shop:AddButton({

    Name = "Cannon",

    Description = "100.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Cannon?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cannon")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Kabucha

Shop:AddButton({

    Name = "Kabucha",

    Description = "2.500 Fragments",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buy Kabucha?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "1")

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



Shop:AddSection("Race Shop")



-- Ghoul Race

Shop:AddButton({

    Name = "Ghoul Race",

    Description = "Ectoplasm",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Change to Ghoul Race?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4)

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Cyborg Race

Shop:AddButton({

    Name = "Cyborg Race",

    Description = "",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Change to Cyborg Race?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Draco Race

Shop:AddButton({

    Name = "Draco Race",

    Description = "",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Change to Draco Race?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        -- Teleport to Dragon Wizard

                        local player = game.Players.LocalPlayer

                        local character = player.Character or player.CharacterAdded:Wait()

                        character.HumanoidRootPart.CFrame = CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938)

                        

                        -- Wait until arrived

                        repeat task.wait() until (character.HumanoidRootPart.Position - Vector3.new(5814.42724609375, 1208.3267822265625, 884.5785522460938)).Magnitude < 10

                        

                        -- Invoke

                        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer({

                            ["NPC"] = "Dragon Wizard",

                            ["Command"] = "DragonRace"

                        })

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Random Race

Shop:AddButton({

    Name = "Random Race",

    Description = "3.000 Fragments",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Random Race?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyRandomRace")

                    end

                },

                {
 
                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



Shop:AddSection("Reset Stats")



-- Reset Stats

Shop:AddButton({

    Name = "Reset Stats",

    Description = "2.500 Fragments",

    Callback = function()

        Window:Dialog({

            Title = "buy",

            Content = "Do You Want Reset Stats?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



Shop:AddSection("Haki Shop")



-- Buso

Shop:AddButton({

    Name = "Buso Haki",

    Description = "25.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Buso Haki?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Geppo Haki

Shop:AddButton({

    Name = "Geppo Haki",

    Description = "10.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Geppo Haki?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        replicated.Remotes.CommF_:InvokeServer("BuyHaki","Geppo")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Ken Haki

Shop:AddButton({

    Name = "Ken Haki",

    Description = "750.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Ken Haki?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        replicated.Remotes.CommF_:InvokeServer("KenTalk","Buy")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Soru Haki

Shop:AddButton({

    Name = "Soru Haki",

    Description = "100.000 Beli",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Ken Haki?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        replicated.Remotes.CommF_:InvokeServer("BuyHaki","Soru")

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



Main:AddDropdown({

    Name = "Select Weapon",

    Options = {"Melee","Sword","Blox Fruit","Gun"},

    Default = "Melee",

    Callback = function(Value)

        _G.ChooseWP = Value

    end

})



spawn(function()

  while wait(Sec) do

    pcall(function()

      if _G.ChooseWP == "Melee" then

        for _,v in pairs(plr.Backpack:GetChildren()) do

	      if v.ToolTip == "Melee" then

		    if plr.Backpack:FindFirstChild(tostring(v.Name)) then

	          _G.SelectWeapon = v.Name              

            end

          end

        end

   	  elseif _G.ChooseWP == "Sword" then     

	    for _,v in pairs(plr.Backpack:GetChildren()) do

	      if v.ToolTip == "Sword" then

		    if plr.Backpack:FindFirstChild(tostring(v.Name)) then

		      _G.SelectWeapon = v.Name              

            end

          end

        end

      elseif _G.ChooseWP == "Gun" then     

	     for _,v in pairs(plr.Backpack:GetChildren()) do

	       if v.ToolTip == "Gun" then

		    if plr.Backpack:FindFirstChild(tostring(v.Name)) then

		      _G.SelectWeapon = v.Name              

            end

          end

        end

      elseif _G.ChooseWP == "Blox Fruit" then     

	    for _,v in pairs(plr.Backpack:GetChildren()) do

	      if v.ToolTip == "Blox Fruit" then

		    if plr.Backpack:FindFirstChild(tostring(v.Name)) then

		      _G.SelectWeapon = v.Name		                    

            end

          end

        end        

      end

    end)

  end

end)


Main:AddSlider({

    Name = "Ui scale",

    Description = "meomaybeo",

    Min = 0,

    Max = 2,

    Default = 1,

    Callback = function(value)

        pSats = value

    end

})






Main:AddSection("Mode Main Farming")



Main:AddToggle({
    Name = "Auto Farm Level Quests",
    Default = false,
    Callback = function(Value)
        _G.Level = Value
    end
})

local circleAngle = 0
local savedSpawnPos = nil

Spawn(function()
  while true do
    task.wait(0.3)
	if _G.Level then
	  pcall(function()
	    local plr = game.Players.LocalPlayer
	    local char = plr.Character
	    if not char then return end
	    local Root = char:FindFirstChild("HumanoidRootPart")
	    if not Root then return end
	    
	    if type(QuestNeta) ~= "function" then return end

	    local questGui = plr:FindFirstChild("PlayerGui") and plr.PlayerGui:FindFirstChild("Main") and plr.PlayerGui.Main:FindFirstChild("Quest")
	    if not questGui then return end
	    
	    local questTitleElem = questGui:FindFirstChild("Container") and questGui.Container:FindFirstChild("QuestTitle") and questGui.Container.QuestTitle:FindFirstChild("Title")
	    local QuestTitle = questTitleElem and questTitleElem.Text or ""
	    local targetName = QuestNeta()[1]

	    if replicated and replicated:FindFirstChild("Remotes") and replicated.Remotes:FindFirstChild("CommF_") then
    	    
    	    -- 1. ƯU TIÊN SỐ 1: Phải luôn nhận nhiệm vụ trước tiên
    	    if questGui.Visible == false or not string.find(QuestTitle, QuestNeta()[5]) then 
    	        if questGui.Visible == true then
    	            replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
    	        end
    	        
    	        if type(_tp) == "function" and QuestNeta()[6] then
    	            _tp(QuestNeta()[6])
    	            if (Root.Position - QuestNeta()[6].Position).Magnitude <= 6 then 
    	                replicated.Remotes.CommF_:InvokeServer("StartQuest", QuestNeta()[3], QuestNeta()[2]) 
    	            end
    	        end
    	        return
    	    end

    	    -- 2. TÌM VÀ ĐÁNH QUÁI
    	    if questGui.Visible == true then
    	      local activeMob = nil
    	      
    	      if workspace:FindFirstChild("Enemies") then
    		    for _, v in pairs(workspace.Enemies:GetChildren()) do
    		      if v:FindFirstChild("HumanoidRootPart") and v.Name == targetName then
    		          savedSpawnPos = v.HumanoidRootPart.CFrame
    		          if type(Attack) == "table" and Attack.Alive and Attack.Alive(v) then
    		              activeMob = v
    		          end
    		      end
    		    end
    	      end
    	      
    	      if activeMob then
    		      if string.find(QuestTitle, QuestNeta()[5]) then
    				repeat 
    				    task.wait() 
    				    if type(Attack) == "table" and Attack.Kill then
    				        Attack.Kill(activeMob, _G.Level)
    				    end
    				until not _G.Level or activeMob.Humanoid.Health <= 0 or not activeMob.Parent or questGui.Visible == false
    		      else
    				replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
    		      end
    		  else
    		      -- 3. KHI HẾT SẠCH QUÁI: Bay lượn vòng tròn với phạm vi RẤT TO trên vùng spawn của mobs
    		      if type(_tp) == "function" then
    		          local basePos = savedSpawnPos or QuestNeta()[4]
    		          if basePos then
    		              circleAngle = circleAngle + 0.25
    		              local radius = 90  -- Đã tăng bán kính vòng tròn lên rất to
    		              local height = 35  -- Độ cao bay lượn
    		              
    		              local offsetX = math.cos(circleAngle) * radius
    		              local offsetZ = math.sin(circleAngle) * radius
    		              
    		              local targetCFrame
    		              if typeof(basePos) == "CFrame" then
    		                  targetCFrame = basePos + Vector3.new(offsetX, height, offsetZ)
    		              else
    		                  targetCFrame = CFrame.new(basePos) + Vector3.new(offsetX, height, offsetZ)
    		              end
    		              
    		              _tp(targetCFrame)
    		          end
    		      end
    		  end
    		end
    	end
	  end)
	end
  end
end)



Main:AddToggle({

    Name = "Auto Farm Nearest Mobs",

    Default = false,

    Callback = function(Value)

        _G.AutoFarmNear = Value

    end

})



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



Main:AddSection(" Mode Farm bone")



Main:AddToggle({

    Name = "Auto Farm Bones Quests",

    Default = false,

    Callback = function(Value)

        _G.AutoFarm_Bone = Value

    end

})



spawn(function()

  while wait(Sec) do 

    if _G.AutoFarm_Bone then

      pcall(function()        

        local player = game.Players.LocalPlayer

        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        local questUI = player.PlayerGui.Main.Quest

        local BonesTable = {"Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy"}

        if not root then return end

        local bone = GetConnectionEnemies(BonesTable)

          if bone then

	        if _G.AcceptQuestC and not questUI.Visible then

              local questPos = CFrame.new(-9516.99316,172.017181,6078.46533,0,0,-1,0,1,0,1,0,0)

              _tp(questPos)

              while (questPos.Position - root.Position).Magnitude > 50 do

                wait(0.2)

              end

              local randomQuest = math.random(1, 4)

              local questData = {

                [1] = {"StartQuest", "HauntedQuest2", 2},

                [2] = {"StartQuest", "HauntedQuest2", 1},

                [3] = {"StartQuest", "HauntedQuest1", 1},

                [4] = {"StartQuest", "HauntedQuest1", 2}

              }                    

              local success, response = pcall(function()

                return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(questData[randomQuest]))

              end)

            end

		    repeat task.wait() Attack.Kill(bone, _G.AutoFarm_Bone) until not _G.AutoFarm_Bone or bone.Humanoid.Health <= 0 or not bone.Parent or (_G.AcceptQuestC and not questUI.Visible)

          else

            _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 	      

        end

      end)

    end

  end

end)


Main:AddToggle({

    Name = "Auto Hallow Reaper",

    Default = false,

    Callback = function(Value)

        _G.AutoHytHallow = Value

    end

})



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


Main:AddToggle({

    Name = "Auto Trade Bone",

    Default = false,

    Callback = function(Value)

        _G.AutoHytHallow = Value

    end

})



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



Main:AddSection("Chest + Epctoplasm")


Main:AddToggle({

    Name = "Auto Farm Chest < Tween >",

    Default = false,

    Callback = function(Value)

        _G.AutoFarmChest = Value

    end

})



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



Main:AddToggle({

    Name = "Auto Hop Server Chest",

    Default = false,

    Callback = function(Value)

        _G.ChestFarmingHOP = Value

    end

})



spawn(function()

    while wait() do

        pcall(function()

            if _G.ChestFarmingHOP then

                local CollectionService = game:GetService("CollectionService")

                local chests = CollectionService:GetTagged("_ChestTagged")

                local chestFound = false



                for _, chest in ipairs(chests) do

                    if chest and not chest:GetAttribute("IsDisabled") then

                        chestFound = true

                        local chestPos



                        local success, result = pcall(function() return chest:GetPivot().Position end)

                        if success then

                            chestPos = result

                        elseif chest:IsA("BasePart") then

                            chestPos = chest.Position

                        else

                            chestPos = chest:FindFirstChild("RootPart") and chest.RootPart.Position

                        end



                        if chestPos then

                            repeat

                                task.wait()

                                _tp(CFrame.new(chestPos))

                                if (plr.Character.HumanoidRootPart.Position - chestPos).Magnitude <= 20 then

                                end

                            until not chest.Parent or chest:GetAttribute("IsDisabled") or not _G.ChestFarmingHOP

                        end

                        break 

                    end

                end



                if not chestFound and _G.ChestFarmingHOP then

                    wait(1)

                    Hop()

                end

            end

        end)

    end

end)



Main:AddToggle({

    Name = "Auto Farm Ectoplasm",

    Default = false,

    Callback = function(Value)

        _G.AutoEctoplasm = Value

    end

})



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

Main:AddSection("Events [ NEW ]")



Main:AddParagraph("Update New Blox Fruits[ BETA ]", "gay <font color=\"#fc0303\">MANY ERROR</font>")



local Players = game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

local commF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")



-- Hàm kiểm tra quest hiện tại

function CheckGetQuest()

    local QGui = playerGui:FindFirstChild("Main") and playerGui.Main:FindFirstChild("Quest")

    if QGui and QGui.Visible then

        local QTitle = QGui.Container.QuestTitle.Title.Text

        return QTitle

    end

    return nil

end



-- Hàm bắt đầu quest theo world

function StartValentineQuest()

    -- Tắt các chế độ farm khác

    _G.AutoFarmNear = false

    _G.AutoEctoplasm = false

    _G.AutoFarmChest = false

    _G.SeaBeast1 = false

    _G.AutoCollectFruit = false

    _G.AutoFarmChest = false

    

    -- Xác định tham số world

    local worldArg = "Sea1"

    if World2 then

        worldArg = "Sea2"

    elseif World3 then

        worldArg = "Sea3"

    end

    

    -- Teleport đến NPC Valentine

    local npcPosition

    if World1 then

        npcPosition = CFrame.new(1000, 27, 1500)

    elseif World2 then

        npcPosition = CFrame.new(-400, 73, 1800)

    elseif World3 then

        npcPosition = CFrame.new(-712, 98, 5711)

    end

    

    if npcPosition then

        _tp(npcPosition)

        wait(1.5)

        

        -- Gọi remote nhận quest

        pcall(function()

            commF:InvokeServer("StartNextValentineQuest", worldArg)

        end)

    end

end



-- Hàm kiểm tra và nộp vật phẩm

function SubmitQuestItem(itemType, amount)

    pcall(function()

        commF:InvokeServer("SubmitValentineQuest", itemType, amount)

    end)

end



Main:AddToggle({

    Name = "Auto Farm Mobs Rip son [ nên bật khi vào nhà chó ]",

    Default = false,

    Callback = function(Value)

        _G.AutoFarmNear = Value

    end

})



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



Main:AddSection("Meterial Mode Farm")



Main:AddDropdown({

    Name = "Select Meterial Farm",

    Options = MaterialList,

    Default = nil,

    Callback = function(Value)

        getgenv().SelectMaterial = Value

    end

})



Main:AddToggle({

    Name = "Start Farm Meterial",

    Default = false,

    Callback = function(Value)

        getgenv().AutoMaterial = Value

    end

})



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



Main:AddSection("Mastery Mode Farm [ BETA ]")



Main:AddDropdown({

    Name = "Select Islands Farm",

    Options = {"Cake","Bone"},

    Default = nil,

    Callback = function(Value)

        SelectIsland = Value

    end

})



Main:AddToggle({

    Name = "Start Farm Mastery With Fruits",

    Default = false,

    Callback = function(Value)

        _G.FarmMastery_Dev = Value

    end

})



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



Main:AddToggle({

    Name = "Start Farm Mastery With Gun",

    Default = false,

    Callback = function(Value)

        _G.FarmMastery_G = Value

    end

})



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



Fish:AddDropdown({

    Name = "Select Fishing Rod",

    Description = "",

    Options = {

        "Fishing Rod",

        "Gold Rod",

        "Shark Rod",

        "Shell Rod",

        "Treasure Rod"

    },

    Default = "Fishing Rod",

    Callback = function(value)

        _G.SelectedRod = value

    end

})



Fish:AddDropdown({

    Name = "Select Bait",

    Description = "",

    Options = {

        "Basic Bait",

        "Kelp Bait",

        "Good Bait",

        "Abyssal Bait",

        "Frozen Bait",

        "Epic Bait",

        "Carnivore Bait"

    },

    Default = "Basic Bait",

    Callback = function(value)

        _G.SelectedBait = value

        

        -- Auto craft bait nếu bật Auto Buy Bait

        if _G.AutoBuyBait then

            pcall(function()

                L_1_[64].RFCraft:InvokeServer("Craft", _G.SelectedBait, {})

            end)

        end

    end

})



Fish:AddSection("Fishing")



Fish:AddToggle({

    Name = "Auto Buy Bait",

    Description = "Automatically Crafts The Secleted Bait",

    Default = false,

    Callback = function(value)

        _G.AutoBuyBait = value

        

        -- Craft bait ngay khi bật

        if value and _G.SelectedBait then

            pcall(function()

                L_1_[64].RFCraft:InvokeServer("Craft", _G.SelectedBait, {})

            end)

        end

    end

})



-- Loop Auto Buy Bait

task.spawn(function()

    while task.wait(2) do

        if _G.AutoBuyBait and _G.SelectedBait then

            pcall(function()

                L_1_[64].RFCraft:InvokeServer("Craft", _G.SelectedBait, {})

            end)

        end

    end

end)



Fish:AddToggle({

    Name = "Auto Fishing",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoFishing = value

    end

})



-- ========================================

-- FISHING VARIABLES

-- ========================================

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Workspace = game:GetService("Workspace")

local ReplicatedStorage = game:GetService("ReplicatedStorage")



-- Fishing Replicated

local FishReplicated = ReplicatedStorage:WaitForChild("FishReplicated")

local FishingRequest = FishReplicated:WaitForChild("FishingRequest")

local FishingClient = FishReplicated:WaitForChild("FishingClient")

local Config = require(FishingClient.Config)



-- Utilities

local GetWaterHeight = require(ReplicatedStorage.Util:WaitForChild("GetWaterHeightAtLocation"))

local MaxLaunchDistance = Config.Rod.MaxLaunchDistance



-- ========================================

-- AUTO FISHING LOOP

-- ========================================

task.spawn(function()

    while task.wait(0.5) do

        if _G.AutoFishing then

            pcall(function()

                -- Get character

                local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

                

                if not HumanoidRootPart then return end

                

                -- Get current tool

                local CurrentTool = Character:FindFirstChildOfClass("Tool")

                

                -- Equip selected rod if not equipped

                if _G.SelectedRod and (not CurrentTool or CurrentTool.Name ~= _G.SelectedRod) then

                    local BackpackRod = LocalPlayer.Backpack:FindFirstChild(_G.SelectedRod)

                    if BackpackRod then

                        Character.Humanoid:EquipTool(BackpackRod)

                        CurrentTool = BackpackRod

                    end

                end

                

                if CurrentTool then

                    -- Get water height

                    local waterY = GetWaterHeight(HumanoidRootPart.Position)

                    

                    -- Cast ray to find casting position

                    local _, hitPos = Workspace:FindPartOnRayWithIgnoreList(

                        Ray.new(Character.Head.Position, HumanoidRootPart.CFrame.LookVector * MaxLaunchDistance),

                        {Character, Workspace.Characters, Workspace.Enemies}

                    )

                    

                    -- Calculate final cast position

                    local castPos = hitPos and Vector3.new(

                        hitPos.X,

                        math.max(hitPos.Y, waterY),

                        hitPos.Z

                    )

                    

                    -- Get rod state

                    local state = CurrentTool:GetAttribute("State")

                    local serverState = CurrentTool:GetAttribute("ServerState")

                    

                    -- Cast line if reeled in

                    if castPos and (state == "ReeledIn" or serverState == "ReeledIn") then

                        FishingRequest:InvokeServer("StartCasting")

                        task.wait()

                        FishingRequest:InvokeServer("CastLineAtLocation", castPos, 100, true)

                    

                    -- Catch fish if biting

                    elseif serverState == "Biting" then

                        FishingRequest:InvokeServer("Catching", true)

                        task.wait(0.1)

                        FishingRequest:InvokeServer("Catch", 1)

                    end

                end

            end)

        end

    end

end)



Fish:AddToggle({

    Name = "Auto Spam Skill Z",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoSkillZ = value

    end

})



-- Remote for skill

local JobToolAbilities = ReplicatedStorage.Modules.Net:WaitForChild("RF/JobToolAbilities")



-- Auto Spam Skill Z Loop

task.spawn(function()

    while task.wait(0.5) do

        if _G.AutoSkillZ then

            pcall(function()

                JobToolAbilities:InvokeServer("Z", true)

            end)

        end

    end

end)



Fish:AddSection(" Quest Fishing")



Fish:AddToggle({

    Name = "Auto Quest Fishing",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoFishingQuest = value

    end

})



-- Remote for quest

local JobsRemote = ReplicatedStorage.Modules.Net:WaitForChild("RF/JobsRemoteFunction")



-- Check if quest is active

local function HasQuest()

    local PlayerGui = LocalPlayer.PlayerGui

    local Quest = PlayerGui:FindFirstChild("Quest") or PlayerGui:FindFirstChild("QuestGui")

    

    if Quest and Quest:FindFirstChild("Container") and Quest.Container:FindFirstChild("QuestTitle") then

        return true

    end

    return false

end



-- Auto Quest Loop

task.spawn(function()

    while task.wait(1) do

        if _G.AutoFishingQuest then

            pcall(function()

                if not HasQuest() then

                    JobsRemote:InvokeServer("FishingNPC", "Angler", "AskQuest")

                end

            end)

        end

    end

end)



Fish:AddToggle({

    Name = "Auto Complete Quest",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoQuestComplete = value

        

        -- Complete quest ngay khi bật

        if value then

            pcall(function()

                L_1_[64].RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")

            end)

        end

    end

})



-- Auto Complete Quest Loop

task.spawn(function()

    while task.wait(5) do

        if _G.AutoQuestComplete then

            pcall(function()

                L_1_[64].RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")

            end)

        end

    end

end)



Fish:AddSection("Sell Fish")



Fish:AddToggle({

    Name = "Auto Sell Fish",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoSellFish = value

        

        -- Sell fish ngay khi bật

        if value then

            pcall(function()

                L_1_[64].RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")

            end)

        end

    end

})



-- Auto Sell Fish Loop

task.spawn(function()

    while task.wait(5) do

        if _G.AutoSellFish then

            pcall(function()

                L_1_[64].RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")

            end)

        end

    end

end)



Stack:AddSection("Auto Dragon Quests [ Updates ]")



-- Teleport To Dragon Dojo

Stack:AddButton({

    Name = "Teleport To Dragon Dojo House",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773, -334.96499633789))

        topos(CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609))

    end

})



-- Auto Dojo Trainer

Stack:AddToggle({

    Name = "Auto Dojo Trainer Quests",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Dojoo = value

    end

})



-- Hàm lấy tên Belt

local function printBeltName(data)

    if type(data) == "table" and data.Quest and data.Quest.BeltName then

        return data.Quest.BeltName

    end

end



-- Auto Dojo Trainer Loop

spawn(function()

    while wait(Sec) do

        if _G.Dojoo then

            pcall(function()

                local interactRemote = L_1_[18].Modules.Net:FindFirstChild("RF/InteractDragonQuest")

                

                -- Request quest

                local questData = interactRemote:InvokeServer({

                    NPC = "Dojo Trainer",

                    Command = "RequestQuest"

                })

                

                local beltName = printBeltName(questData)

                

                if debug == false and (not questData and not beltName) then

                    _tp(CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875))

                    debug = true

                    

                elseif debug == true and (CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875).Position - L_1_[45].Character.HumanoidRootPart.Position).Magnitude <= 50 then

                    

                    -- Xử lý theo màu belt

                    if beltName == "White" then

                        local enemy = GetConnectionEnemies("Skull Slayer")

                        if enemy then

                            repeat

                                task.wait()

                                L_1_[4].Kill(enemy, _G.Dojoo)

                            until not questData or not _G.Dojoo or not L_1_[4].Alive(enemy)

                        else

                            _tp(CFrame.new(-16759.58984375, 71.283767700195, 1595.3399658203))

                        end

                        

                    elseif beltName == "Yellow" then

                        repeat

                            task.wait()

                            _G.SeaBeast1 = true

                            _G.TerrorShark = true

                            _G.Shark = true

                            _G.Piranha = true

                            _G.MobCrew = true

                            _G.FishBoat = true

                            _G.SailBoats = true

                        until not _G.Dojoo or not questData

                        

                        _G.SeaBeast1 = false

                        _G.TerrorShark = false

                        _G.Shark = false

                        _G.Piranha = false

                        _G.MobCrew = false

                        _G.FishBoat = false

                        _G.SailBoats = false

                        

                    elseif beltName == "Green" then

                        repeat

                            task.wait()

                            _G.SailBoats = true

                        until not _G.Dojoo or not questData

                        _G.SailBoats = false

                        

                    elseif beltName == "Purple" then

                        repeat

                            task.wait()

                            _G.FarmEliteHunt = true

                        until not _G.Dojoo or not questData

                        _G.FarmEliteHunt = false

                        

                    elseif beltName == "Red" then

                        repeat

                            task.wait()

                            _G.SailBoats = true

                            _G.FishBoat = true

                        until not _G.Dojoo or not questData

                        _G.SailBoats = false

                        _G.FishBoat = false

                        

                    elseif beltName == "Black" then

                        repeat

                            task.wait()

                            if workspace.Map:FindFirstChild("PrehistoricIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then

                                _G.Prehis_Find = true

                                if workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt", true) then

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

                        until not _G.Dojoo or not questData

                        _G.Prehis_Find = false

                        _G.Prehis_Skills = false

                        

                    elseif beltName == "Orange" or beltName == "Blue" then

                        -- Do nothing

                    end

                end

                

                -- Claim quest nếu không có quest

                if not questData then

                    debug = false

                    interactRemote:InvokeServer({

                        NPC = "Dojo Trainer",

                        Command = "ClaimQuest"

                    })

                end

            end)

        end

    end

end)



Stack:AddToggle({

    Name = "Auto Dragon Hunter Quests",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.FarmBlazeEM = value

    end

})



-- Hàm kiểm tra quest

local function checkQuesta()

    local result = {found = false, target = nil, count = nil, type = nil}

    

    pcall(function()

        local hunterRemote = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter")

        local questData = hunterRemote:InvokeServer({Context = "Check"})

        

        if questData and questData.Text then

            result.found = true

            local text = tostring(questData.Text)

            

            if string.find(text, "Defeat") then

                result.type = 1

                result.count = tonumber(string.sub(text, 8, 9))

                

                local targets = {"Hydra Enforcer", "Venomous Assailant"}

                for _, target in pairs(targets) do

                    if string.find(text, target) then

                        result.target = target

                        break

                    end

                end

                

            elseif string.find(text, "Destroy") then

                result.type = 2

                result.count = 10

            end

        end

    end)

    

    return result.found, result.target, result.count, result.type

end



-- Hàm kiểm tra quay lại Dojo

local function BackTODoJo()

    for _, notification in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetChildren()) do

        if notification.Name == "NotificationTemplate" then

            if string.find(notification.Text, "Head back to the Dojo to complete more tasks") then

                return true

            end

        end

    end

    return false

end



-- Hàm kill mob Dragon

local function DragonMobClear(isKill, mobName, tpPos)

    if workspace.Enemies:FindFirstChild(mobName) then

        for _, enemy in pairs(workspace.Enemies:GetChildren()) do

            if enemy.Name == mobName and L_1_[4].Alive(enemy) then

                if isKill then

                    L_1_[4].Kill(enemy, _G.FarmBlazeEM)

                end

            end

        end

    else

        _tp(tpPos)

    end

end



-- Auto Dragon Hunter Loop

spawn(function()

    while wait() do

        if _G.FarmBlazeEM then

            pcall(function()

                local found, target, count, questType = checkQuesta()

                

                if found == true and not BackTODoJo() then

                    if questType == 1 then

                        if target == "Hydra Enforcer" or target == "Venomous Assailant" then

                            repeat

                                wait()

                                DragonMobClear(true, target, CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492))

                            until not _G.FarmBlazeEM or not found or BackTODoJo()

                        end

                        

                    elseif questType == 2 then

                        local bamboo = workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true)

                        if bamboo then

                            repeat

                                wait()

                                spawn(function()

                                    _tp(bamboo.CFrame * CFrame.new(4, 0, 0))

                                end)

                                

                                if (bamboo.Position - Root.Position).Magnitude <= 200 then

                                    MousePos = bamboo.Position

                                    Useskills("Melee", "Z")

                                    Useskills("Melee", "X")

                                    Useskills("Melee", "C")

                                    wait(.5)

                                    Useskills("Sword", "Z")

                                    Useskills("Sword", "X")

                                    wait(.5)

                                    Useskills("Blox Fruit", "Z")

                                    Useskills("Blox Fruit", "X")

                                    Useskills("Blox Fruit", "C")

                                    wait(.5)

                                    Useskills("Gun", "Z")

                                    Useskills("Gun", "X")

                                end

                            until not _G.FarmBlazeEM or not found or BackTODoJo()

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



-- Auto collect Ember

spawn(function()

    while wait(.1) do

        if _G.FarmBlazeEM then

            pcall(function()

                if workspace.EmberTemplate and workspace.EmberTemplate:FindFirstChild("Part") then

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.EmberTemplate.Part.CFrame

                end

            end)

        end

    end

end)



-- Tween to Drago Trials

Stack:AddToggle({

    Name = "Teleport to Drago Trials",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.TpDrago_Prehis = value

    end

})



-- Tween to Drago Trials Loop

spawn(function()

    while wait(Sec) do

        if _G.TpDrago_Prehis then

            local trialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

            if trialTeleport and trialTeleport:IsA("Part") then

                _tp(CFrame.new(trialTeleport.Position))

            end

        end

    end

end)



Stack:AddSection("Game Raid Event")



Stack:AddToggle({

    Name = "Auto Farm Factory Raid",

    Default = false,

    Callback = function(Value)

        _G.AutoFactory = Value

    end

})



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



Stack:AddToggle({

    Name = "Auto Farm Pirate Raid",

    Default = false,

    Callback = function(Value)

        _G.AutoRaidCastle = Value

    end

})



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

Stack:AddSection("World Quests")



Stack:AddToggle({

    Name = "Auto Dressrosa Quests",

    Default = false,

    Callback = function(Value)

        _G.TravelDres = Value

    end

})



spawn(function()

  while wait(Sec) do

    pcall(function()

      if _G.TravelDres then

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



Stack:AddToggle({

    Name = "Auto Zou Quests",

    Default = false,

    Callback = function(Value)

        _G.AutoZou = Value

    end

})



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



Stack:AddSection("Uqgrade Dark Blade Quests v1-2-3 + Upgrade evo 2-3")



Stack:AddToggle({

    Name = "Auto Upgrade Dark Blade V2 to V3",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.DarkBladev3 = value

    end

})



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



RaceOptions = {

    "Mink",

    "Human", 

    "Angel",

    "FishMan"
}


Stack:AddToggle({

    Name = "Auto Upgrade Race 2 -> 3",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoUpgradeRace = value

    end

})



-- Auto Upgrade Race Loop

spawn(function()

    while wait(Sec or 1) do

        pcall(function()

            if not _G.AutoUpgradeRace or not _G.SelectedRace then return end

            

            -- Xử lý theo race được chọn

            if _G.SelectedRace == "Mink" then

                -- Auto Upgrade Mink

                if L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") ~= 2 then

                    if L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then

                        L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "2")

                    elseif L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then

                        if not L_1_[45].Backpack:FindFirstChild("Flower 1") and not L_1_[45].Character:FindFirstChild("Flower 1") then

                            _tp(workspace.Flower1.CFrame)

                        elseif not L_1_[45].Backpack:FindFirstChild("Flower 2") and not L_1_[45].Character:FindFirstChild("Flower 2") then

                            _tp(workspace.Flower2.CFrame)

                        elseif not L_1_[45].Backpack:FindFirstChild("Flower 3") and not L_1_[45].Character:FindFirstChild("Flower 3") then

                            local enemy = GetConnectionEnemies("Swan Pirate")

                            if enemy then

                                repeat

                                    wait()

                                    L_1_[4].Kill(enemy, _G.AutoUpgradeRace)

                                until GetBP("Flower 3") or not enemy.Parent or enemy.Humanoid.Health <= 0

                            else

                                _tp(CFrame.new(980.09851074219, 121.33129882812, 1287.2093505859))

                            end

                        end

                    elseif L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then

                        L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "3")

                    end

                elseif L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then

                    L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "2")

                elseif L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then

                    _G.AutoFarmChest = true

                else

                    _G.AutoFarmChest = false

                end

                

            elseif _G.SelectedRace == "Human" then

                -- Auto Upgrade Human

                if L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then

                    if L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then

                        L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "2")

                    elseif L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then

                        if not L_1_[45].Backpack:FindFirstChild("Flower 1") and not L_1_[45].Character:FindFirstChild("Flower 1") then

                            _tp(workspace.Flower1.CFrame)

                        elseif not L_1_[45].Backpack:FindFirstChild("Flower 2") and not L_1_[45].Character:FindFirstChild("Flower 2") then

                            _tp(workspace.Flower2.CFrame)

                        elseif not L_1_[45].Backpack:FindFirstChild("Flower 3") and not L_1_[45].Character:FindFirstChild("Flower 3") then

                            local enemy = GetConnectionEnemies("Swan Pirate")

                            if enemy then

                                repeat

                                    wait()

                                    L_1_[4].Kill(enemy, _G.AutoUpgradeRace)

                                until L_1_[45].Backpack:FindFirstChild("Flower 3") or not enemy.Parent or enemy.Humanoid.Health <= 0

                            else

                                _tp(CFrame.new(980.09851074219, 121.33129882812, 1287.2093505859))

                            end

                        end

                    elseif L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then

                        L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "3")

                    end

                elseif L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then

                    L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "2")

                elseif L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then

                    local enemies = {"Jeremy", "Andrew", "Arbel"}

                    for _, enemyName in pairs(enemies) do

                        local enemy = GetConnectionEnemies(enemyName)

                        if enemy then

                            repeat

                                wait()

                                L_1_[4].Kill(enemy, _G.AutoUpgradeRace)

                            until enemy.Humanoid.Health <= 0 or not enemy.Parent

                        else

                            if enemyName == "Jeremy" then

                                _tp(CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625))

                            elseif enemyName == "Andrew" then

                                _tp(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109))

                            elseif enemyName == "Arbel" then

                                _tp(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407))

                            end

                        end

                    end

                end

                

            elseif _G.SelectedRace == "Angel" then

                -- Auto Upgrade Angel

                if L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then

                    if L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then

                        L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "2")

                    elseif L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then

                        if not L_1_[45].Backpack:FindFirstChild("Flower 1") and not L_1_[45].Character:FindFirstChild("Flower 1") then

                            _tp(workspace.Flower1.CFrame)

                        elseif not L_1_[45].Backpack:FindFirstChild("Flower 2") and not L_1_[45].Character:FindFirstChild("Flower 2") then

                            _tp(workspace.Flower2.CFrame)

                        elseif not L_1_[45].Backpack:FindFirstChild("Flower 3") and not L_1_[45].Character:FindFirstChild("Flower 3") then

                            local enemy = GetConnectionEnemies("Swan Pirate")

                            if enemy then

                                repeat

                                    wait()

                                    L_1_[4].Kill(enemy, _G.AutoUpgradeRace)

                                until L_1_[45].Backpack:FindFirstChild("Flower 3") or not enemy.Parent or enemy.Humanoid.Health <= 0

                            else

                                _tp(CFrame.new(980.09851074219, 121.33129882812, 1287.2093505859))

                            end

                        end

                    elseif L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then

                        L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "3")

                    end

                elseif L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then

                    L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "2")

                elseif L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then

                    for _, player in pairs(game.Players:GetChildren()) do

                        if player.Name ~= L_1_[45].Name and tostring(player.Data.Race.Value) == "Skypiea" then

                            repeat

                                task.wait()

                                _tp((player.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)) * CFrame.Angles(math.rad(-45), 0, 0))

                            until player.Humanoid.Health <= 0 or _G.AutoUpgradeRace == false

                        end

                    end

                end

                

            elseif _G.SelectedRace == "FishMan" then

                -- Auto Upgrade FishMan

                if L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then

                    if L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then

                        L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "2")

                    elseif L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then

                        if not L_1_[45].Backpack:FindFirstChild("Flower 1") and not L_1_[45].Character:FindFirstChild("Flower 1") then

                            _tp(workspace.Flower1.CFrame)

                        elseif not L_1_[45].Backpack:FindFirstChild("Flower 2") and not L_1_[45].Character:FindFirstChild("Flower 2") then

                            _tp(workspace.Flower2.CFrame)

                        elseif not L_1_[45].Backpack:FindFirstChild("Flower 3") and not L_1_[45].Character:FindFirstChild("Flower 3") then

                            local enemy = GetConnectionEnemies("Swan Pirate")

                            if enemy then

                                repeat

                                    wait()

                                    L_1_[4].Kill(enemy, _G.AutoUpgradeRace)

                                until L_1_[45].Backpack:FindFirstChild("Flower 3") or not enemy.Parent or enemy.Humanoid.Health <= 0

                            else

                                _tp(CFrame.new(980.09851074219, 121.33129882812, 1287.2093505859))

                            end

                        end

                    elseif L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then

                        L_1_[18].Remotes.CommF_:InvokeServer("Alchemist", "3")

                    end

                elseif L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then

                    L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "2")

                elseif L_1_[18].Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then

                    -- Xử lý Sea Beast cho FishMan

                    warn("Sea Beast Soon")

                end

            end

        end)

    end

end)



Stack:AddSection("Farming")



Stack:AddToggle({

    Name = "Auto Attack Tyrant or the skies[ Fully ]",

    Default = false,

    Callback = function(Value)

        _G.FarmTyrant = Value

    end

})



spawn(function()

		while wait(Sec) do

			if _G.FarmTyrant then

				pcall(function()

					local player = plr or game.Players.LocalPlayer

					if not (player and player.Character) then

						return

					end

					local hrp = player.Character:FindFirstChild("HumanoidRootPart")

					if not hrp then

						return

					end

					local enemiesFolder = workspace:FindFirstChild("Enemies")

					local bossPos = Vector3.new(-16268.287, 152.616, 1390.773)

					if (hrp.Position - bossPos).Magnitude > 5 then

						if _tp then

							pcall(_tp, CFrame.new(bossPos))

						elseif Tween then

							pcall(Tween, CFrame.new(bossPos))

						elseif notween then

							pcall(notween, CFrame.new(bossPos))

						else

							pcall(function()

								player.Character.HumanoidRootPart.CFrame = CFrame.new(bossPos)

							end)

						end

						repeat

							wait()

						until not _G.FarmTyrant or (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and (player.Character.HumanoidRootPart.Position - bossPos).Magnitude <= 5)

					end

					local boss = enemiesFolder and enemiesFolder:FindFirstChild("Tyrant of the Skies")

					if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then

						repeat

							if not _G.FarmTyrant then

								break

							end

							if AutoHaki then

								pcall(AutoHaki)

							end

							if SelectWeapon and EquipTool then

								pcall(EquipTool, SelectWeapon)

							end

							if Attack and Attack.Kill then

								pcall(function()

									Attack.Kill(boss, _G.FarmTyrant)

								end)

							elseif AttackNoCoolDown then

								pcall(AttackNoCoolDown)

							end

							wait()

						until not _G.FarmTyrant or not boss.Parent or not boss:FindFirstChild("Humanoid") or boss.Humanoid.Health <= 0

						return

					end

					local mobList = {

						"Serpent Hunter",

						"Skull Slayer",

						"Isle Champion",

						"Sun-kissed Warrior"

					}

					if enemiesFolder then

						for _, mobName in ipairs(mobList) do

							if not _G.FarmTyrant then

								break

							end

							for _, mob in ipairs(enemiesFolder:GetChildren()) do

								if not _G.FarmTyrant then

									break

								end

								if mob and mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then

									hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

									if not hrp then

										break

									end

									if (hrp.Position - mob.HumanoidRootPart.Position).Magnitude > 5000 then

										if _tp then

											pcall(_tp, mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

										elseif Tween then

											pcall(Tween, mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

										elseif notween then

											pcall(notween, mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

										else

											pcall(function()

												player.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)

											end)

										end

										local t0 = tick()

										repeat

											wait()

											hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

										until not _G.FarmTyrant or not hrp or (hrp.Position - mob.HumanoidRootPart.Position).Magnitude <= 6 or tick() - t0 > 8

									end

									repeat

										if not _G.FarmTyrant then

											break

										end

										if AutoHaki then

											pcall(AutoHaki)

										end

										if SelectWeapon and EquipTool then

											pcall(EquipTool, SelectWeapon)

										end

										if Attack and Attack.Kill then

											pcall(function()

												Attack.Kill(mob, _G.FarmTyrant)

											end)

										elseif AttackNoCoolDown then

											pcall(AttackNoCoolDown)

										end

										wait()

									until not _G.FarmTyrant or not mob.Parent or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0

								end

							end

						end

					else

						for _, mobName in ipairs(mobList) do

							if not _G.FarmTyrant then

								break

							end

							for _, mob in ipairs(workspace:GetChildren()) do

								if not _G.FarmTyrant then

									break

								end

								if mob and mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then

									if _tp then

										pcall(_tp, mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

									else

										pcall(function()

											player.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)

										end)

									end

									repeat

										wait()

									until not _G.FarmTyrant or (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and (player.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude <= 6)

									repeat

										if not _G.FarmTyrant then

											break

										end

										if Attack and Attack.Kill then

											pcall(function()

												Attack.Kill(mob, _G.FarmTyrant)

											end)

										elseif AttackNoCoolDown then

											pcall(AttackNoCoolDown)

										end

										wait()

									until not _G.FarmTyrant or not mob.Parent or mob.Humanoid.Health <= 0

								end

							end

						end

					end

				end)

			end

		end

	end)



Stack:AddToggle({

    Name = "Auto Attack Rip Indra [ Fully ]",

    Default = false,

    Callback = function(Value)

        _G.AutoRipIngay = Value

    end

})



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



Stack:AddToggle({

    Name = "Auto Attack Darkbread [ Fully ]",

    Default = false,

    Callback = function(Value)

        _G.Auto_Def_DarkCoat = Value

    end

})



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



Stack:AddToggle({

    Name = "Auto Attack Elite Quests",

    Default = false,

    Callback = function(Value)

        _G.FarmEliteHunt = Value

    end

})



spawn(function()

  while wait(Sec) do

    pcall(function()

	  if _G.FarmEliteHunt then

	    if plr.PlayerGui.Main.Quest.Visible == true then

	      if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then

		    for i,v in pairs(replicated:GetChildren()) do

		      if string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre") then

		        _tp(v.HumanoidRootPart.CFrame)				

		      end	

		    end

	 	    for i,v in pairs(Enemies:GetChildren()) do

		      if (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) and Attack.Alive(v) then

	            repeat wait() Attack.Kill(v, _G.FarmEliteHunt) until not _G.FarmEliteHunt or plr.PlayerGui.Main.Quest.Visible == false or not v.Parent or v.Humanoid.Health <=0

	          end

	        end           

	      end        

	    else

	      replicated.Remotes.CommF_:InvokeServer("EliteHunter")

	    end

      end

    end)

  end

end)



Stack:AddToggle({

    Name = "Auto Attack Dough King",

    Default = false,

    Callback = function(Value)

        _G.AutoMiror = Value

    end

})



spawn(function()

  while wait(Sec) do

    if _G.AutoMiror then

      pcall(function()

        local v = GetConnectionEnemies("Dough King")

        if v then

          repeat wait() Attack.Kill(v,_G.AutoMiror) until not _G.AutoMiror or not v.Parent or v.Humanoid.Health <= 0

        else

          _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) 

        end

      end)

    end

  end

end)



Stack:AddToggle({

    Name = "Auto Farm Cake Prince Quests",

    Default = false,

    Callback = function(Value)

        _G.Auto_Cake_Prince = Value

    end

})



spawn(function()

  while wait() do

    if _G.Auto_Cake_Prince then

      pcall(function()

        local player = game.Players.LocalPlayer

        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        local questUI = player.PlayerGui.Main.Quest

        local enemies = workspace.Enemies

        local bigMirror = workspace.Map.CakeLoaf.BigMirror

        if not root then return end

        if not bigMirror:FindFirstChild("Other") then

          _tp(CFrame.new(-2077, 252, -12373))

        end        

        if bigMirror.Other.Transparency == 0 or enemies:FindFirstChild("Cake Prince") then

          local v = GetConnectionEnemies("Cake Prince")

          if v then

            repeat wait() Attack.Kill2(v, _G.Auto_Cake_Prince)until not _G.Auto_Cake_Prince or not v.Parent or v.Humanoid.Health <= 0

          else

            if bigMirror.Other.Transparency == 0 and (CFrame.new(-1990.67, 4533, -14973.67).Position - root.Position).Magnitude >= 2000 then

              _tp(CFrame.new(-2151.82, 149.32, -12404.91))

            end

          end

        else

          local CakePrince = {"Cookie Crafter","Cake Guard","Baking Staff","Head Baker"}

          local v = GetConnectionEnemies(CakePrince)

          if v then

            if _G.AcceptQuestC and not questUI.Visible then

              local questPos = CFrame.new(-1927.92, 37.8, -12842.54)

              _tp(questPos)

              while (questPos.Position - root.Position).Magnitude > 50 do

                wait(0.2)

              end

              local randomQuest = math.random(1, 4)

              local questData = {

                [1] = {"StartQuest", "CakeQuest2", 2},

                [2] = {"StartQuest", "CakeQuest2", 1},

                [3] = {"StartQuest", "CakeQuest1", 1},

                [4] = {"StartQuest", "CakeQuest1", 2}

              }                    

              local success, response = pcall(function()

                return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(questData[randomQuest]))

              end)

            end

            repeat wait() Attack.Kill(v, _G.Auto_Cake_Prince) until not _G.Auto_Cake_Prince or v.Humanoid.Health <= 0 or bigMirror.Other.Transparency == 0 or (_G.AcceptQuestC and not questUI.Visible)                

          else

            _tp(CFrame.new(-2077, 252, -12373))

          end

        end

      end)

    end

  end

end)



Stack:AddSection("Observation Event + berry Farm")



Stack:AddToggle({

    Name = "Auto Farm Berry",

    Default = false,

    Callback = function(Value)

        _G.AutoBerry = Value

    end

})



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



Stack:AddToggle({

    Name = "Auto Farm Observation",

    Default = false,

    Callback = function(Value)

        _G.obsFarm = Value

    end

})



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



local Sec = 0.1

local HopDelay = 3



Server:AddSection("Boss Tyrant Hop ")



Server:AddToggle({

    Name = "Auto Attack or Hop Server Tyrant",

    Default = false,

    Callback = function(Value)

        _G.FarmTyrantHop = Value 

    end

})



spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.FarmTyrantHop then

                local player = plr or game.Players.LocalPlayer

                if not (player and player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then

                    return

                end

                local hrp = player.Character.HumanoidRootPart

                

                local enemiesFolder = workspace:FindFirstChild("Enemies") or workspace

                

                -- Ưu tiên check boss Tyrant

                local boss = enemiesFolder:FindFirstChild("Tyrant of the Skies")

                if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then

                    -- TP đến boss nếu xa

                    local bossPos = boss.HumanoidRootPart.Position  -- hoặc dùng vị trí cố định nếu cần

                    if (hrp.Position - bossPos).Magnitude > 50 then

                        if _tp then

                            pcall(_tp, CFrame.new(bossPos + Vector3.new(0, 30, 0)))

                        elseif Tween then

                            pcall(Tween, CFrame.new(bossPos + Vector3.new(0, 30, 0)))

                        else

                            hrp.CFrame = CFrame.new(bossPos + Vector3.new(0, 30, 0))

                        end

                        wait(1)  -- Chờ TP xong

                    end

                    

                    -- Farm boss

                    repeat

                        if not _G.FarmTyrantHop then break end

                        if AutoHaki then pcall(AutoHaki) end

                        if SelectWeapon and EquipTool then pcall(EquipTool, SelectWeapon) end

                        if Attack and Attack.Kill then

                            pcall(Attack.Kill, boss, _G.FarmTyrantHop)

                        elseif AttackNoCoolDown then

                            pcall(AttackNoCoolDown)

                        end

                        wait()

                    until not _G.FarmTyrantHop or not boss.Parent or boss.Humanoid.Health <= 0

                    

                    -- Boss chết → hop ngay

                    Hop()

                    return

                end

                

                -- Không có boss → check và farm mob (nếu có)

                local mobList = {

                    "Serpent Hunter",

                    "Skull Slayer",

                    "Isle Champion",

                    "Sun-kissed Warrior"

                }

                local foundMob = false

                

                for _, mobName in ipairs(mobList) do

                    if not _G.FarmTyrantHop then break end

                    for _, mob in ipairs(enemiesFolder:GetChildren()) do

                        if not _G.FarmTyrantHop then break end

                        if mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then

                            foundMob = true

                            -- TP đến mob nếu xa

                            local mobPos = mob.HumanoidRootPart.Position

                            if (hrp.Position - mobPos).Magnitude > 5000 then

                                if _tp then

                                    pcall(_tp, mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

                                elseif Tween then

                                    pcall(Tween, mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

                                else

                                    hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)

                                end

                                local t0 = tick()

                                repeat wait() until not _G.FarmTyrantHop or (hrp.Position - mobPos).Magnitude <= 6 or tick() - t0 > 8

                            end

                            

                            -- Farm mob

                            repeat

                                if not _G.FarmTyrantHop then break end

                                if AutoHaki then pcall(AutoHaki) end

                                if SelectWeapon and EquipTool then pcall(EquipTool, SelectWeapon) end

                                if Attack and Attack.Kill then

                                    pcall(Attack.Kill, mob, _G.FarmTyrantHop)

                                elseif AttackNoCoolDown then

                                    pcall(AttackNoCoolDown)

                                end

                                wait()

                            until not _G.FarmTyrantHop or not mob.Parent or mob.Humanoid.Health <= 0

                        end

                    end

                end

                

                -- Không có boss lẫn mob → hop server

                if not foundMob then

                    Hop()

                end

            end

        end)

    end

end)



Server:AddSection("Boss Rip Indra Chan Hop ")



-- 1. Rip Indra

Server:AddToggle({

    Name = "Auto Attack or Hop Server Rip Indra",

    Default = false,

    Callback = function(Value)

        _G.Rip_Indra_Hop = Value

    end

})

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.Rip_Indra_Hop then

                local v = GetConnectionEnemies("rip_indra")

                if v then

                    repeat wait() Attack.Kill(v, _G.Rip_Indra_Hop) until not _G.Rip_Indra_Hop or not v.Parent or v.Humanoid.Health <= 0

                else

                    Hop()

                end

            end

        end)

    end

end)



Server:AddSection("Boss Darkbeard Hop ")


-- 2. Darkbeard

Server:AddToggle({

    Name = "Auto Attack or Hop Server Darkbeard",

    Default = false,

    Callback = function(Value)

        _G.DarkbeardHop = Value

    end

})

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.DarkbeardHop then

                local v = GetConnectionEnemies("Darkbeard")

                if v then

                    repeat wait() Attack.Kill(v, _G.DarkbeardHop) until not _G.DarkbeardHop or not v.Parent or v.Humanoid.Health <= 0

                else

                    Hop()

                end

            end

        end)

    end

end)



Server:AddSection("Boss elite hunter Hop")



-- 3. Elites (chỉ farm nếu đã có Elite Quest active, không lấy quest mới)

Server:AddToggle({

    Name = "Auto Attack or Hop Server Elites",

    Default = false,

    Callback = function(Value)

        _G.EliteHop = Value

    end

})

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.EliteHop then

                if plr.PlayerGui.Main.Quest.Visible then

                    local title = plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

                    if string.find(title, "Diablo") or string.find(title, "Urban") or string.find(title, "Deandre") then

                        -- TP đến Remotes (nếu có)

                        for i, v in pairs(replicated:GetChildren()) do

                            if string.find(v.Name, "Diablo") or string.find(v.Name, "Urban") or string.find(v.Name, "Deandre") then

                                _tp(v.HumanoidRootPart.CFrame)

                            end

                        end

                        -- Farm Enemies

                        for i, v in pairs(Enemies:GetChildren()) do

                            if (string.find(v.Name, "Diablo") or string.find(v.Name, "Urban") or string.find(v.Name, "Deandre")) and Attack.Alive(v) then

                                repeat wait() Attack.Kill(v, _G.EliteHop) until not _G.EliteHop or plr.PlayerGui.Main.Quest.Visible == false or not v.Parent or v.Humanoid.Health <= 0

                            end

                        end

                    else

                        Hop()

                    end

                else

                    Hop()

                end

            end

        end)

    end

end)



Server:AddSection("Boss Dough King V2 Hop ")



-- 4. Dough King

Server:AddToggle({

    Name = "Auto Attack or Hop Server Dough King",

    Default = false,

    Callback = function(Value)

        _G.DoughKingHop = Value

    end

})

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.DoughKingHop then

                local v = GetConnectionEnemies("Dough King")

                if v then

                    repeat wait() Attack.Kill(v, _G.DoughKingHop) until not _G.DoughKingHop or not v.Parent or v.Humanoid.Health <= 0

                else

                    Hop()

                end

            end

        end)

    end

end)



Server:AddSection("Boss Hallow Reaper Hop")



-- 5. Soul Reaper

Server:AddToggle({

    Name = "Auto Attack or Hop Server Hallow Reaper",

    Default = false,

    Callback = function(Value)

        _G.SoulReaperHop = Value

    end

})

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.SoulReaperHop then

                local v = GetConnectionEnemies("Soul Reaper")

                if v then

                    repeat wait() Attack.Kill(v, _G.SoulReaperHop) until not _G.SoulReaperHop or not v.Parent or v.Humanoid.Health <= 0

                else

                    Hop()

                end

            end

        end)

    end

end)



Server:AddSection("Observation Hop Server")



Server:AddToggle({

    Name = "Auto Farming or Hop Server Observation [BETA]",

    Default = false,

    Callback = function(Value)

        _G.FruitsFarmingHOP = Value

    end

})



spawn(function()      

    while wait(.2) do

        pcall(function()

            if _G.obsFarm then

                if World1 then

                    local enemy = workspace.Enemies:FindFirstChild("Galley Captain")

                    if enemy then

                        if KenTest then

                            repeat wait()

                                plr.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)

                            until _G.obsFarm == false or KenTest == false

                        else

                            repeat wait()

                                plr.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)

                            until _G.obsFarm == false or KenTest

                        end

                    else

                        if getgenv().AutoObservationHop then

                            Hop()  -- Sử dụng hàm Hop() đã có trong file

                            wait(5)

                        else

                            _tp(CFrame.new(5533.29785, 88.1079102, 4852.3916))  -- Đổi topos -> _tp

                        end

                    end

                elseif World2 then

                    local enemy = workspace.Enemies:FindFirstChild("Lava Pirate")

                    if enemy then

                        if KenTest then

                            repeat wait()

                                plr.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)

                            until _G.obsFarm == false or KenTest == false

                        else

                            repeat wait()

                                plr.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)

                            until _G.obsFarm == false or KenTest

                        end

                    else

                        if getgenv().AutoObservationHop then

                            Hop()  -- Sử dụng hàm Hop() đã có trong file

                            wait(5)

                        else

                            _tp(CFrame.new(-5478.39209, 15.9775667, -5246.9126))  -- Đổi topos -> _tp

                        end

                    end

                elseif World3 then

                    local enemy = workspace.Enemies:FindFirstChild("Venomous Assailant")

                    if enemy then

                        if KenTest then

                            repeat wait()

                                _tp(enemy.HumanoidRootPart.CFrame * CFrame.new(3, 0, 0))  -- Đổi topos -> _tp

                            until _G.obsFarm == false or KenTest == false

                        else

                            repeat wait()

                                _tp(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))  -- Đổi topos -> _tp

                            until _G.obsFarm == false or KenTest

                        end

                    else

                        if getgenv().AutoObservationHop then

                            Hop()  -- Sử dụng hàm Hop() đã có trong file

                            wait(5)

                        else

                            _tp(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))  -- Đổi topos -> _tp

                        end

                    end

                end        

            end

        end)

    end

end)



Server:AddSection("Fruits Hop Server")



Server:AddToggle({

    Name = "Auto Farming or Hop Server Fruits",

    Default = false,

    Callback = function(Value)

        _G.FruitsFarmingHOP = Value

    end

})



spawn(function()

    while wait() do

        if _G.FruitsFarmingHOP then

            pcall(function()

                local fruitFound = false

                for i, v in pairs(game.Workspace:GetChildren()) do

                    if string.find(v.Name, "Fruit") then

                        fruitFound = true

                        _tp(v.Handle.CFrame)

                        break

                    end

                end



                if not fruitFound and _G.FruitsFarmingHOP then

                    wait(1) 

                    Hop()

                end

            end)

        end

    end

end)



HasChestInServer = function()

    local CollectionService = game:GetService("CollectionService")

    local chests = CollectionService:GetTagged("_ChestTagged")

    for _, chest in ipairs(chests) do

        if chest and not chest:GetAttribute("IsDisabled") then

            return true

        end

    end

    return false

end



Sea:AddSection("Sea Event Settings")



-- Ship Speed Modifier

Sea:AddToggle({

    Name = "Ship Speed Modifier",

    Default = false,

    Callback = function(value)

        getgenv().SpeedBoat = value

    end

})



-- RenderStepped cho Speed Boat

game:GetService("RunService").RenderStepped:Connect(function()

    if getgenv().SpeedBoat then

        local player = game:GetService("Players").LocalPlayer

        if player.Character and player.Character:FindFirstChild("Humanoid") then

            if player.Character.Humanoid.Sit then

                for _, boat in pairs(game:GetService("Workspace").Boats:GetChildren()) do

                    local seat = boat:FindFirstChildWhichIsA("VehicleSeat")

                    if seat then

                        seat.MaxSpeed = SetSpeedBoat or 300

                    end

                end

            end

        end

    end

end)



-- Ship Speed Slider

Sea:AddSlider({

    Name = "Ship Speed",

    Min = 0,

    Max = 1000,

    Increment = 1,

    Default = 300,

    Callback = function(value)

        SetSpeedBoat = value

    end

})



-- Auto Press W

Sea:AddToggle({

    Name = "Auto Press W",

    Default = false,

    Callback = function(value)

        getgenv().AutoPressW = value

    end

})



-- Auto Press W Loop

spawn(function()

    while wait() do

        pcall(function()

            if getgenv().AutoPressW then

                local player = game.Players.LocalPlayer

                local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")

                if humanoid and humanoid.Sit == true then

                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)

                end

            end

        end)

    end

end)



-- No Clip Ship

Sea:AddToggle({

    Name = "No Clip Ship",

    Default = false,

    Callback = function(value)

        getgenv().NoClipShip = value

    end

})



-- No Clip Ship Loop

spawn(function()

    while wait() do

        pcall(function()

            for _, boat in pairs(game:GetService("Workspace").Boats:GetChildren()) do

                for _, descendant in pairs(boat:GetDescendants()) do

                    if descendant:IsA("BasePart") then

                        if getgenv().NoClipShip or getgenv().FindPrehistoric then

                            descendant.CanCollide = false

                        else

                            descendant.CanCollide = true

                        end

                    end

                end

            end

        end)

    end

end)



local BoatOptions = {

    "Guardian",

    "PirateGrandBrigade",

    "MarineGrandBrigade",

    "PirateBrigade",

    "MarineBrigade",

    "PirateSloop",

    "MarineSloop",

    "Beast Hunter"

}



local SeaLevelOptions = {

    "Lv 1",

    "Lv 2",

    "Lv 3",

    "Lv 4",

    "Lv 5",

    "Lv 6",

    "Lv Infinite"

}



-- Select Boats Dropdown

Sea:AddDropdown({

    Name = "Select Boats",

    Options = BoatOptions,

    Default = "",

    Callback = function(value)

        _G.SelectedBoat = value

    end

})



-- Buy Boats Button

Sea:AddButton({

    Name = "Auto Buy Boats",

    Description = "",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)

    end

})



-- Select Sea Level Dropdown

Sea:AddDropdown({

    Name = "Select Sea Level",

    Options = SeaLevelOptions,

    Default = "",

    Callback = function(value)

        _G.DangerSc = value

    end

})



Sea:AddSection("Crafting Items in Sea Event")



-- SharkTooth

Sea:AddButton({

    Name = "Craft SharkTooth",

    Description = "",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkTooth")

    end

})



-- TerrorJaw

Sea:AddButton({

    Name = "Craft TerrorJaw",

    Description = "",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "TerrorJaw")

    end

})



-- SharkAnchor

Sea:AddButton({

    Name = "Craft SharkAnchor",

    Description = "",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkAnchor")

    end

})



-- LeviathanCrown

Sea:AddButton({

    Name = "Craft LeviathanCrown",

    Description = "",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanCrown")

    end

})



-- LeviathanShield

Sea:AddButton({

    Name = "Craft LeviathanShield",

    Description = "",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanShield")

    end

})



-- LeviathanBoat

Sea:AddButton({

    Name = "Craft LeviathanBoat",

    Description = "",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanBoat")

    end

})



-- LegendaryScroll

Sea:AddButton({

    Name = "Craft LegendaryScroll",

    Description = "",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LegendaryScroll")

    end

})



-- MythicalScroll

Sea:AddButton({

    Name = "Craft MythicalScroll",

    Description = "",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "MythicalScroll")

    end

})



Sea:AddSection("Auto Sea Event")



-- Auto Sail Boat Toggle

Sea:AddToggle({

    Name = "Auto Sea Event",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.SailBoats = value

    end

})



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



Sea:AddSection("Mobs Sea Event")



-- Auto Shark

Sea:AddToggle({

    Name = "Auto Shark",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Shark = value

    end

})



-- Auto Piranha

Sea:AddToggle({

    Name = "Auto Piranha",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Piranha = value

    end

})



-- Auto Terror Shark

Sea:AddToggle({

    Name = "Auto Terror Shark",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.TerrorShark = value

    end

})



-- Auto Fish Crew Member

Sea:AddToggle({

    Name = "Auto Fish Crew Member",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.MobCrew = value

    end

})



-- Auto Haunted Crew Member

Sea:AddToggle({

    Name = "Auto Haunted Crew Member",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.HCM = value

    end

})



-- Auto Attack PirateGrandBrigade

Sea:AddToggle({

    Name = "Auto Attack PirateGrandBrigade",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.PGB = value

    end

})



-- Auto Attack Fish Boat

Sea:AddToggle({

    Name = "Auto Attack Fish Boat",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.FishBoat = value

    end

})



-- Auto Attack Sea Beast

Sea:AddToggle({

    Name = "Auto Attack Sea Beast",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.SeaBeast1 = value

    end

})



-- Auto Kill Loop

spawn(function()

    while wait() do

        pcall(function()

            -- Shark

            if _G.Shark then

                local sharkNames = {"Shark"}

                if CheckShark and CheckShark() then

                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do

                        if table.find(sharkNames, enemy.Name) then

                            if Alive and Alive(enemy) then

                                repeat

                                    task.wait()

                                    Kill(enemy, _G.Shark)

                                until _G.Shark == false or not enemy.Parent or enemy.Humanoid.Health <= 0

                            end

                        end

                    end

                end

            end

            

            -- Terror Shark

            if _G.TerrorShark then

                local terrorNames = {"Terrorshark"}

                if CheckTerrorShark and CheckTerrorShark() then

                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do

                        if table.find(terrorNames, enemy.Name) then

                            if Alive and Alive(enemy) then

                                repeat

                                    task.wait()

                                    KillSea(enemy, _G.TerrorShark)

                                until _G.TerrorShark == false or not enemy.Parent or enemy.Humanoid.Health <= 0

                            end

                        end

                    end

                end

            end

            

            -- Piranha

            if _G.Piranha then

                local piranhaNames = {"Piranha"}

                if CheckPiranha and CheckPiranha() then

                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do

                        if table.find(piranhaNames, enemy.Name) then

                            if Alive and Alive(enemy) then

                                repeat

                                    task.wait()

                                    Kill(enemy, _G.Piranha)

                                until _G.Piranha == false or not enemy.Parent or enemy.Humanoid.Health <= 0

                            end

                        end

                    end

                end

            end

            

            -- Fish Crew Member

            if _G.MobCrew then

                local crewNames = {"Fish Crew Member"}

                if CheckFishCrew and CheckFishCrew() then

                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do

                        if table.find(crewNames, enemy.Name) then

                            if Alive and Alive(enemy) then

                                repeat

                                    task.wait()

                                    Kill(enemy, _G.MobCrew)

                                until _G.MobCrew == false or not enemy.Parent or enemy.Humanoid.Health <= 0

                            end

                        end

                    end

                end

            end

            

            -- Haunted Crew Member

            if _G.HCM then

                local hauntedNames = {"Haunted Crew Member"}

                if CheckHauntedCrew and CheckHauntedCrew() then

                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do

                        if table.find(hauntedNames, enemy.Name) then

                            if Alive and Alive(enemy) then

                                repeat

                                    task.wait()

                                    Kill(enemy, _G.HCM)

                                until _G.HCM == false or not enemy.Parent or enemy.Humanoid.Health <= 0

                            end

                        end

                    end

                end

            end

            

            -- Sea Beast

            if _G.SeaBeast1 then

                if workspace.SeaBeasts and workspace.SeaBeasts:FindFirstChild("SeaBeast1") then

                    for _, beast in pairs(workspace.SeaBeasts:GetChildren()) do

                        if beast:FindFirstChild("HumanoidRootPart") and beast:FindFirstChild("Health") and beast.Health.Value > 0 then

                            repeat

                                task.wait()

                                spawn(function()

                                    _tp(CFrame.new(beast.HumanoidRootPart.Position.X, workspace.Map.WaterBase-Plane.Position.Y + 200, beast.HumanoidRootPart.Position.Z))

                                end)

                                

                                if game.Players.LocalPlayer:DistanceFromCharacter(beast.HumanoidRootPart.CFrame.Position) <= 500 then

                                    AitSeaSkill_Custom = beast.HumanoidRootPart.CFrame

                                    MousePos = AitSeaSkill_Custom.Position

                                    

                                    if CheckF and CheckF() then

                                        weaponSc("Blox Fruit")

                                        Useskills("Blox Fruit", "Z")

                                        Useskills("Blox Fruit", "X")

                                        Useskills("Blox Fruit", "C")

                                    else

                                        Useskills("Melee", "Z")

                                        Useskills("Melee", "X")

                                        Useskills("Melee", "C")

                                        wait(.1)

                                        Useskills("Sword", "Z")

                                        Useskills("Sword", "X")

                                        wait(.1)

                                        Useskills("Blox Fruit", "Z")

                                        Useskills("Blox Fruit", "X")

                                        Useskills("Blox Fruit", "C")

                                        wait(.1)

                                        Useskills("Gun", "Z")

                                        Useskills("Gun", "X")

                                    end

                                end

                            until _G.SeaBeast1 == false or not beast:FindFirstChild("HumanoidRootPart") or not beast.Parent or beast.Health.Value <= 0

                        end

                    end

                end

            end

            

            -- Leviathan

            if _G.Leviathan1 then

                if workspace.SeaBeasts and workspace.SeaBeasts:FindFirstChild("Leviathan") then

                    for _, levi in pairs(workspace.SeaBeasts:GetChildren()) do

                        if levi:FindFirstChild("HumanoidRootPart") and levi:FindFirstChild("Leviathan Segment") and levi:FindFirstChild("Health") and levi.Health.Value > 0 then

                            repeat

                                task.wait()

                                spawn(function()

                                    _tp(CFrame.new(levi.HumanoidRootPart.Position.X, workspace.Map.WaterBase-Plane.Position.Y + 200, levi.HumanoidRootPart.Position.Z))

                                end)

                                

                                if game.Players.LocalPlayer:DistanceFromCharacter(levi.HumanoidRootPart.CFrame.Position) <= 500 then

                                    MousePos = levi:FindFirstChild("Leviathan Segment").Position

                                    

                                    if CheckF and CheckF() then

                                        weaponSc("Blox Fruit")

                                        Useskills("Blox Fruit", "Z")

                                        Useskills("Blox Fruit", "X")

                                        Useskills("Blox Fruit", "C")

                                    else

                                        Useskills("Melee", "Z")

                                        Useskills("Melee", "X")

                                        Useskills("Melee", "C")

                                        wait(.1)

                                        Useskills("Sword", "Z")

                                        Useskills("Sword", "X")

                                        wait(.1)

                                        Useskills("Blox Fruit", "Z")

                                        Useskills("Blox Fruit", "X")

                                        Useskills("Blox Fruit", "C")

                                        wait(.1)

                                        Useskills("Gun", "Z")

                                        Useskills("Gun", "X")

                                    end

                                end

                            until _G.Leviathan1 == false or not levi:FindFirstChild("HumanoidRootPart") or not levi.Parent or levi.Health.Value <= 0

                        end

                    end

                end

            end

            

            -- Fish Boat

            if _G.FishBoat then

                if CheckEnemiesBoat and CheckEnemiesBoat() then

                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do

                        if enemy:FindFirstChild("Health") and enemy.Health.Value > 0 and enemy:FindFirstChild("VehicleSeat") then

                            repeat

                                task.wait()

                                spawn(function()

                                    if enemy.Name == "FishBoat" then

                                        _tp(enemy.Engine.CFrame * CFrame.new(0, -50, -25))

                                    end

                                end)

                                

                                if game.Players.LocalPlayer:DistanceFromCharacter(enemy.Engine.CFrame.Position) <= 150 then

                                    AitSeaSkill_Custom = enemy.Engine.CFrame

                                    MousePos = AitSeaSkill_Custom.Position

                                    

                                    if CheckF and CheckF() then

                                        weaponSc("Blox Fruit")

                                        Useskills("Blox Fruit", "Z")

                                        Useskills("Blox Fruit", "X")

                                        Useskills("Blox Fruit", "C")

                                    else

                                        Useskills("Melee", "Z")

                                        Useskills("Melee", "X")

                                        Useskills("Melee", "C")

                                        wait(.1)

                                        Useskills("Sword", "Z")

                                        Useskills("Sword", "X")

                                        wait(.1)

                                        Useskills("Blox Fruit", "Z")

                                        Useskills("Blox Fruit", "X")

                                        Useskills("Blox Fruit", "C")

                                        wait(.1)

                                        Useskills("Gun", "Z")

                                        Useskills("Gun", "X")

                                    end

                                end

                            until _G.FishBoat == false or not enemy:FindFirstChild("VehicleSeat") or enemy.Health.Value <= 0

                        end

                    end

                end

            end

            

            -- Pirate Grand Brigade

            if _G.PGB then

                if CheckPirateGrandBrigade and CheckPirateGrandBrigade() then

                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do

                        if enemy:FindFirstChild("Health") and enemy.Health.Value > 0 and enemy:FindFirstChild("VehicleSeat") then

                            repeat

                                task.wait()

                                spawn(function()

                                    if enemy.Name == "PirateBrigade" then

                                        _tp(enemy.Engine.CFrame * CFrame.new(0, -30, -10))

                                    elseif enemy.Name == "PirateGrandBrigade" then

                                        _tp(enemy.Engine.CFrame * CFrame.new(0, -50, -50))

                                    end

                                end)

                                

                                if game.Players.LocalPlayer:DistanceFromCharacter(enemy.Engine.CFrame.Position) <= 150 then

                                    AitSeaSkill_Custom = enemy.Engine.CFrame

                                    MousePos = AitSeaSkill_Custom.Position

                                    

                                    if CheckF and CheckF() then

                                        weaponSc("Blox Fruit")

                                        Useskills("Blox Fruit", "Z")

                                        Useskills("Blox Fruit", "X")

                                        Useskills("Blox Fruit", "C")

                                    else

                                        Useskills("Melee", "Z")

                                        Useskills("Melee", "X")

                                        Useskills("Melee", "C")

                                        wait(.1)

                                        Useskills("Sword", "Z")

                                        Useskills("Sword", "X")

                                        wait(.1)

                                        Useskills("Blox Fruit", "Z")

                                        Useskills("Blox Fruit", "X")

                                        Useskills("Blox Fruit", "C")

                                        wait(.1)

                                        Useskills("Gun", "Z")

                                        Useskills("Gun", "X")

                                    end

                                end

                            until _G.PGB == false or not enemy:FindFirstChild("VehicleSeat") or enemy.Health.Value <= 0

                        end

                    end

                end

            end

        end)

    end

end)



-- ===== SECTION 3: ISLAND STATUS =====

Kitsune:AddSection("Island Status")



-- Frozen Dimension

local FrozenIsland = Kitsune:AddParagraph(" ❄️ Frozen Dimension", "Status: Loading...")



spawn(function()

    while task.wait(1) do

        pcall(function()

            local currentStatus = game.Workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') and '🟢' or '🔴'

            FrozenIsland:SetDescription("Status: " .. currentStatus)

        end)

    end

end)



-- Volcano Island (Prehistoric Island)

local CPrehistoriccheck = Kitsune:AddParagraph("🌋 Prehistoric Island", "Status: Loading...")



task.spawn(function()

    while task.wait(1) do

        pcall(function()

            local currentStatus = game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and '🟢' or '🔴'

            CPrehistoriccheck:SetDescription("Status: " .. currentStatus)

        end)

    end

end)



-- Mirage Island

local Miragecheck = Kitsune:AddParagraph("🌴 Mirage Island", "Status: Loading...")



spawn(function()

    while task.wait(1) do

        pcall(function()

            local mirageIslandExists = game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') ~= nil

            local currentStatus = mirageIslandExists and '🟢' or '🔴'

            Miragecheck:SetDescription("Status: " .. currentStatus)

        end)

    end

end)



Kitsune:AddSection("Auto Leviathan Event [ BETA ]")



-- Buy Spy Button

Kitsune:AddButton({

    Name = "Auto Buy Spy",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2")

    end

})



-- Auto Teleport Frozen Dimension

Kitsune:AddToggle({

    Name = "Auto Teleport Frozen Dimension",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.FrozenTP = value

    end

})



-- Auto Teleport Frozen Dimension Loop

spawn(function()

    while wait(.1) do

        if _G.FrozenTP then

            pcall(function()

                if workspace.Map:FindFirstChild("LeviathanGate") then

                    _tp(workspace.Map.LeviathanGate.CFrame)

                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("OpenLeviathanGate")

                end

            end)

        end

    end

end)



-- Auto Drive To Hydra Island

Kitsune:AddToggle({

    Name = "Auto Drive To Hydra Island",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.SailBoat_Hydra = value

    end

})



-- Auto Drive To Hydra Loop

spawn(function()

    while wait() do

        if _G.SailBoat_Hydra then

            pcall(function()

                local currentBoat = CheckBoat and CheckBoat()

                

                if not currentBoat then

                    local buyPos = CFrame.new(-16927.451, 9.086, 433.864)

                    TeleportToTarget(buyPos)

                    

                    if (buyPos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)

                    end

                elseif currentBoat then

                    local player = game.Players.LocalPlayer

                    if player.Character.Humanoid.Sit == false then

                        local seatPos = currentBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)

                        _tp(seatPos)

                    else

                        repeat

                            wait()

                            if (CheckEnemiesBoat and CheckEnemiesBoat()) or (CheckPirateGrandBrigade and CheckPirateGrandBrigade()) or (CheckTerrorShark and CheckTerrorShark()) then

                                _tp(CFrame.new(5433, 150, 290))

                            else

                                _tp(CFrame.new(5433, 35, 290))

                            end

                        until _G.SailBoat_Hydra == false or player.Character:FindFirstChild("Humanoid").Sit == false

                        

                        player.Character.Humanoid.Sit = false

                    end

                end

            end)

        end

    end

end)



-- Auto Attack Leviathan

Kitsune:AddToggle({

    Name = "Auto Attack Leviathan",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Leviathan1 = value

    end

})



Kitsune:AddSection("Auto Island Kitsune")



-- Auto Find Kitsune Island


Kitsune:AddToggle({

    Name = "Auto Find Kitsune Island",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutofindKitIs = value

    end

})



-- Auto Find Kitsune Loop

spawn(function()

    while wait() do

        if _G.AutofindKitIs then

            pcall(function()

                if not workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island", true) then

                    local currentBoat = CheckBoat and CheckBoat()

                    

                    if not currentBoat then

                        local buyPos = CFrame.new(-16927.451, 9.086, 433.864)

                    TeleportToTarget(buyPos)

                        

                        if (buyPos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then

                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)

                        end

                    else

                        local player = game.Players.LocalPlayer

                        if player.Character.Humanoid.Sit == false then

                            local seatPos = currentBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)

                            _tp(seatPos)

                        else

                            local targetPos = CFrame.new(-10000000, 31, 37016.25)

                            repeat

                                wait()

                                if (CheckEnemiesBoat and CheckEnemiesBoat()) or (CheckTerrorShark and CheckTerrorShark()) or (CheckPirateGrandBrigade and CheckPirateGrandBrigade()) then

                                    _tp(CFrame.new(-10000000, 150, 37016.25))

                                else

                                    _tp(CFrame.new(-10000000, 31, 37016.25))

                                end

                            until not _G.AutofindKitIs or (targetPos.Position - player.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") or player.Character.Humanoid.Sit == false

                            

                            player.Character.Humanoid.Sit = false

                        end

                    end

                else

                    _tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))

                end

            end)

        end

    end

end)



-- Auto Teleport to Shrine Actived

Kitsune:AddToggle({

    Name = "Auto Teleport to Shrine Actived",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.tweenShrine = value

    end

})



-- Auto Teleport to Shrine Loop

spawn(function()

    while wait(.1) do

        if _G.tweenShrine then

            pcall(function()

                local island = workspace.Map:FindFirstChild("KitsuneIsland") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")

                local shrineActive = island and island:FindFirstChild("ShrineActive")

                

                if shrineActive then

                    for _, part in next, shrineActive:GetDescendants() do

                        if part:IsA("BasePart") and part.Name:find("NeonShrinePart") then

                            local remote = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RE/TouchKitsuneStatue")

                            if remote then remote:FireServer() end

                            

                            repeat

                                wait()

                                _tp(part.CFrame * CFrame.new(0, 2, 0))

                            until _G.tweenShrine == false or not island

                        end

                    end

                else

                    _tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))

                end

            end)

        end

    end

end)



-- Auto Collect Azure Ember

Kitsune:AddToggle({

    Name = "Auto Collect Azure Ember",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Collect_Ember = value

    end

})



-- Auto Collect Azure Ember Loop

spawn(function()

    while wait(.1) do

        if _G.Collect_Ember then

            pcall(function()

                if workspace:FindFirstChild("AttachedAzureEmber") or workspace:FindFirstChild("EmberTemplate") then

                    local ember = workspace:FindFirstChild("EmberTemplate")

                    if ember then

                        local part = ember:FindFirstChild("Part")

                        if part then

                            notween(part.CFrame)

                        end

                    end

                else

                    _tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))

                    

                    local prayRemote = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/KitsuneStatuePray")

                    if prayRemote then prayRemote:InvokeServer() end

                end

            end)

        end

    end

end)



-- Auto Trade Azure Ember

Kitsune:AddToggle({

    Name = "Auto Trade Azure Ember",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Trade_Ember = value

    end

})



-- Auto Trade Azure Ember Loop

spawn(function()

    while wait(.1) do

        if _G.Trade_Ember then

            pcall(function()

                if workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island", true) then

                    local prayRemote = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/KitsuneStatuePray")

                    if prayRemote then prayRemote:InvokeServer() end

                end

            end)

        end

    end

end)



-- Trade Items Azure Button

Kitsune:AddButton({

    Name = "Trade Items Azure",

    Description = "",

    Callback = function()

        local prayRemote = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/KitsuneStatuePray")

        if prayRemote then prayRemote:InvokeServer() end

    end

})



-- Talk with kitsune statue Button

Kitsune:AddButton({

    Name = "Talk with kitsune statue",

    Description = "",

    Callback = function()

        local touchRemote = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RE/TouchKitsuneStatue")

        if touchRemote then touchRemote:FireServer() end

    end

})



Kitsune:AddSection("Auto Pull Lever + Find Mirage islands")



Kitsune:AddToggle({

    Name = "Auto Find Mirage Island",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.FindMirage = value

    end

})



spawn(function()

    while wait() do

        if _G.FindMirage then

            pcall(function()

                if not workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island", true) then

                    local currentBoat = CheckBoat()

                    if not currentBoat then

                        local buyPos = CFrame.new(-16927.451, 9.086, 433.864)

                        TeleportToTarget(buyPos)

                        if (buyPos.Position - L_1_[45].Character.HumanoidRootPart.Position).Magnitude <= 10 then

                            L_1_[18].Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)

                        end

                    else

                        if L_1_[45].Character.Humanoid.Sit == false then

                            local seatPos = currentBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)

                            _tp(seatPos)

                        else

                            repeat

                                wait()

                                local targetPos = CFrame.new(-10000000, 31, 37016.25)

                                if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then

                                    _tp(CFrame.new(-10000000, 150, 37016.25))

                                else

                                    _tp(CFrame.new(-10000000, 31, 37016.25))

                                end

                            until not _G.FindMirage or (targetPos.Position - L_1_[45].Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") or L_1_[45].Character.Humanoid.Sit == false

                            L_1_[45].Character.Humanoid.Sit = false

                        end

                    end

                else

                    _tp(workspace.Map.MysticIsland.Center.CFrame * CFrame.new(0, 300, 0))

                end

            end)

        end

    end

end)



-- Auto Tween To Mirage Island

Kitsune:AddToggle({

    Name = "Auto Teleport To Mirage Island",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoMysticIsland = value

    end

})



spawn(function()

    while task.wait(0.1) do

        pcall(function()

            if _G.AutoMysticIsland then

                for _, location in pairs(workspace._WorldOrigin.Locations:GetChildren()) do

                    if location.Name == "Mirage Island" then

                        topos(location.CFrame * CFrame.new(0, 333, 0))

                    end

                end

            end

        end)

    end

end)



-- Auto Tween To Highest Point

Kitsune:AddToggle({

    Name = "Auto Teleport To Highest Point",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.HighestMirage = value

    end

})



spawn(function()

    while wait(Sec or 1) do

        if _G.HighestMirage then

            pcall(function()

                if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island", true) then

                    _tp(workspace.Map.MysticIsland.Center.CFrame * CFrame.new(0, 400, 0))

                end

            end)

        end

    end

end)



-- Auto Collect Gear

Kitsune:AddToggle({

    Name = "Auto Teleport to Blue Gear",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.TPGEAR = value

    end

})



spawn(function()

    pcall(function()

        while wait(0.1) do

            if _G.TPGEAR then

                local mysticIsland = workspace.Map:FindFirstChild("MysticIsland")

                if mysticIsland then

                    for _, part in pairs(mysticIsland:GetChildren()) do

                        if part.Name == "Part" and part.ClassName == "MeshPart" then

                            _tp(part.CFrame)

                        end

                    end

                end

            end

        end

    end)

end)



-- Change Transparency can see

Kitsune:AddToggle({

    Name = "Auto Transparency if Can't see",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.can = value

    end

})



spawn(function()

    pcall(function()

        while wait(Sec or 1) do

            if _G.can then

                local mysticIsland = workspace.Map:FindFirstChild("MysticIsland")

                if mysticIsland then

                    for _, part in pairs(mysticIsland:GetChildren()) do

                        if part.Name == "Part" then

                            if part.ClassName == "MeshPart" then

                                part.Transparency = 0

                            else

                                part.Transparency = 1

                            end

                        end

                    end

                end

            end

        end

    end)

end)



-- Auto Tween Advanced Fruit Dealer
Kitsune:AddToggle({

    Name = "Auto Teleoort Advanced Fruits Dealer",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Addealer = value

    end

})



spawn(function()

    while wait() do

        if _G.Addealer then

            pcall(function()

                for _, npc in pairs(L_1_[18].NPCs:GetChildren()) do

                    if npc.Name == "Advanced Fruit Dealer" then

                        _tp(npc.HumanoidRootPart.CFrame)

                    end

                end

            end)

        end

    end

end)



-- Auto Collect Mirage Chest
Kitsune:AddToggle({

    Name = "Auto Farm Chest in Mirage Island",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.FarmChestM = value

    end

})



spawn(function()

    while wait(0.2) do

        if _G.FarmChestM then

            pcall(function()

                local mysticIsland = workspace.Map:FindFirstChild("MysticIsland")

                if mysticIsland and mysticIsland:FindFirstChild("Chests") then

                    local chests = mysticIsland.Chests

                    local chest = chests:FindFirstChild("DiamondChest") or chests:FindFirstChild("FragChest")

                    

                    if chest then

                        _tp(chest:GetPivot())

                    end

                end

            end)

        end

    end

end)



-- Look Moon + Auto V3

Kitsune:AddToggle({

    Name = "Auto Look Moon and Auto Use Race V3",

    Description = "",

    Default = false,

    Callback = function(value)

        LookMV3 = value

    end

})



function MoveCamtoMoonV3()

    local moonDir = game:GetService("Lighting"):GetMoonDirection()

    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + moonDir)

    L_1_[45].Character.HumanoidRootPart.CFrame = CFrame.new(L_1_[45].Character.HumanoidRootPart.Position, L_1_[45].Character.HumanoidRootPart.Position + moonDir)

end



task.spawn(function()

    while task.wait(0.1) do

        if LookMV3 then

            MoveCamtoMoonV3()

            L_1_[18].Remotes.CommE:FireServer("ActivateAbility")

            game:GetService("UserInputService"):SendKeyEvent(true, "T", false, game)

            wait(0.5)

            game:GetService("UserInputService"):SendKeyEvent(false, "T", false, game)

        end

    end

end)



Kitsune:AddSection("Auto Prehistoric Island")



Kitsune:AddButton({

    Name = "Auto Craft Volcanic Magnet",

    Callback = function()

        local craftRemote = game:GetService("ReplicatedStorage").Modules.Net.RF.Craft

        craftRemote:InvokeServer("PossibleHardcode", "Volcanic Magnet")

    end

})



-- Auto Craft Volcanic Magnet (Toggle)

Kitsune:AddToggle({

    Name = "Auto Craft Volcanic Magnet [full]",

    Default = false,

    Callback = function(value)

        getgenv().AutoCraftVolcanic = value

    end

})



-- Auto Craft Volcanic Magnet Loop

task.spawn(function()

    local craftRemote = game:GetService("ReplicatedStorage").Modules.Net.RF.Craft

    while task.wait(.3) do

        if getgenv().AutoCraftVolcanic then

            pcall(function()

                craftRemote:InvokeServer("PossibleHardcode", "Volcanic Magnet")

            end)

            getgenv().AutoCraftVolcanic = false

        end

    end

end)



-- Auto Find Prehistoric Island

Kitsune:AddToggle({

    Name = "Auto Find or Teleport in Prehistoric Island",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Prehis_Find = value

    end

})



-- Auto Find Prehistoric Island Loop

targetCF = nil

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.Prehis_Find then

                local character = L_1_[45].Character

                if not character then return end

                

                local hrp = character:FindFirstChild("HumanoidRootPart")

                local humanoid = character:FindFirstChild("Humanoid")

                

                if not hrp or not humanoid or humanoid.Health <= 0 then return end

                

                local locations = workspace._WorldOrigin.Locations

                local island = locations:FindFirstChild("Prehistoric Island", true)

                

                if not island then

                    local currentBoat = CheckBoat()

                    

                    if not currentBoat then

                        local buyPos = CFrame.new(-16927.451, 9.086, 433.864)

                        TeleportToTarget(buyPos)

                        

                        if (buyPos.Position - hrp.Position).Magnitude <= 10 then

                            L_1_[18].Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat or "Guardian")

                        end

                        return

                    end

                    

                    if humanoid.Sit == false then

                        local seatPos = currentBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)

                        _tp(seatPos)

                        return

                    end

                    

                    targetCF = CFrame.new(-10000000, 31, 37016.25)

                    

                    if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then

                        _tp(CFrame.new(-10000000, 150, 37016.25))

                    else

                        _tp(targetCF)

                    end

                    

                else

                    local teleportPart = island:FindFirstChild("HeadTeleport", true) or 

                                        island:FindFirstChild("Teleport_Head", true) or 

                                        island:FindFirstChild("Head", true)

                    

                    if teleportPart then

                        local targetPos = (teleportPart.CFrame.Position - teleportPart.CFrame.LookVector * 40) + Vector3.new(0, 20, 0)

                        if (targetPos - hrp.Position).Magnitude > 30 then

                            _tp(CFrame.new(targetPos))

                        end

                    else

                        local islandPos = island.CFrame.Position

                        local dir = (islandPos - hrp.Position).Unit

                        local target = (islandPos - dir * 250) + Vector3.new(0, 60, 0)

                        _tp(CFrame.new(target))

                    end

                end

            end

        end)

    end

end)



-- Auto Start Prehistoric Event

Kitsune:AddToggle({

    Name = "Auto Start Event in Prehistoric Island",

    Default = false,

    Callback = function(value)

        _G.AutoStartPrehistoric = value

    end

})



-- Auto Start Prehistoric Event Loop

spawn(function()

    while wait() do

        if _G.AutoStartPrehistoric then

            pcall(function()

                local island = workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true)

                if island then

                    if workspace.Map:FindFirstChild("PrehistoricIsland", true) then

                        local activation = workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt", true)

                        if activation and activation:FindFirstChild("ProximityPrompt") then

                            if L_1_[45]:DistanceFromCharacter(activation.CFrame.Position) <= 150 then

                                fireproximityprompt(activation.ProximityPrompt, math.huge)

                                game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)

                                wait(1.5)

                                game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)

                            end

                            _tp(activation.CFrame)

                        end

                    end

                end

            end)

        end

    end

end)



-- Auto Patch Prehistoric Event

Kitsune:AddToggle({

    Name = "Auto Farm Event in Prehistoric Island",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Prehis_Skills = value

    end

})



-- Auto Patch Prehistoric Event Loop - Remove lava

spawn(function()

    while wait(.3) do

        if _G.Prehis_Skills then

            pcall(function()

                local island = workspace.Map:FindFirstChild("PrehistoricIsland")

                if not island then return end

                

                -- Remove lava parts

                for _, part in pairs(island:GetDescendants()) do

                    if (part:IsA("BasePart") or part:IsA("MeshPart")) and (part.Name:lower()):find("lava") then

                        part:Destroy()

                    end

                end

                

                -- Remove interior lava

                local core = island:FindFirstChild("Core")

                if core then

                    local interiorLava = core:FindFirstChild("InteriorLava")

                    if interiorLava then

                        interiorLava:Destroy()

                    end

                end

                

                -- Remove touch interests

                local trialTeleport = island:FindFirstChild("TrialTeleport")

                for _, obj in pairs(island:GetDescendants()) do

                    if obj.Name == "TouchInterest" and not(trialTeleport and obj:IsDescendantOf(trialTeleport)) then

                        obj.Parent:Destroy()

                    end

                end

            end)

        end

    end

end)



-- Kill Lava Golem

spawn(function()

    while wait(Sec) do

        if _G.Prehis_Skills then

            pcall(function()

                local golem = GetConnectionEnemies("Lava Golem")

                if golem and golem:FindFirstChild("Humanoid") then

                    repeat

                        wait(.1)

                        L_1_[4].Kill(golem, true)

                        golem.Humanoid:ChangeState(15)

                    until not _G.Prehis_Skills or not golem.Parent or golem.Humanoid.Health <= 0

                end

            end)

        end

    end

end)



-- Kill Volcano rocks

spawn(function()

    while wait(Sec) do

        if _G.Prehis_Skills then

            pcall(function()

                local island = workspace.Map:FindFirstChild("PrehistoricIsland")

                if not island then return end

                

                local core = island:FindFirstChild("Core")

                if not core then return end

                

                local volcanoRocks = core:FindFirstChild("VolcanoRocks")

                if not volcanoRocks then return end

                

                for _, rock in pairs(volcanoRocks:GetChildren()) do

                    local vfxLayer = rock:FindFirstChild("VFXLayer")

                    local at0 = vfxLayer and vfxLayer:FindFirstChild("At0")

                    local glow = at0 and at0:FindFirstChild("Glow")

                    

                    if glow and glow.Enabled then

                        repeat

                            wait(.1)

                            _tp(vfxLayer.CFrame)

                            

                            if L_1_[45]:DistanceFromCharacter(vfxLayer.CFrame.Position) <= 150 then

                                MousePos = vfxLayer.CFrame.Position

                                Useskills("Melee", "Z")

                                wait(.4)

                                Useskills("Melee", "X")

                                wait(.4)

                                Useskills("Melee", "C")

                                wait(.4)

                                Useskills("Blox Fruit", "Z")

                                wait(.4)

                                Useskills("Blox Fruit", "X")

                                wait(.4)

                                Useskills("Blox Fruit", "C")

                            end

                        until not _G.Prehis_Skills or not glow.Enabled

                    end

                end

            end)

        end

    end

end)



-- Kill Aura

Kitsune:AddToggle({

    Name = "Auto Kill Aura In Prehistoric Island",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.KillAuraFull = value

    end

})



local AURA_RADIUS = 500

local AURA_INTERVAL = 2



spawn(function()

    while task.wait(AURA_INTERVAL) do

        if _G.KillAuraFull then

            pcall(function()

                local player = game.Players.LocalPlayer

                local character = player.Character

                local hrp = character and character:FindFirstChild("HumanoidRootPart")

                

                if not hrp then return end

                

                -- Increase simulation radius

                sethiddenproperty(player, "SimulationRadius", math.huge)

                

                -- Kill all enemies in range

                for _, enemy in pairs(workspace.Enemies:GetChildren()) do

                    if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then

                        local dist = (enemy.HumanoidRootPart.Position - hrp.Position).Magnitude

                        

                        if dist <= AURA_RADIUS and enemy.Humanoid.Health > 0 then

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



-- Auto Collect Dino Bones

Kitsune:AddToggle({

    Name = "Auto Farm Dragon Bones",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Prehis_DB = value

    end

})



-- Auto Collect Dino Bones Loop

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.Prehis_DB then

                if workspace:FindFirstChild("DinoBone") then

                    for _, bone in pairs(workspace:GetChildren()) do

                        if bone.Name == "DinoBone" then

                            _tp(bone.CFrame)

                        end

                    end

                end

            end

        end)

    end

end)



-- Auto Collect Dragon Eggs

Kitsune:AddToggle({

    Name = "Auto Farm Dragon Eggs",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Prehis_DE = value

    end

})



-- Auto Collect Dragon Eggs Loop

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.Prehis_DE then

                local eggsFolder = workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs

                local egg = eggsFolder:FindFirstChild("DragonEgg")

                

                if egg then

                    _tp(egg.Molten.CFrame)

                    fireproximityprompt(egg.Molten.ProximityPrompt, 30)

                end

            end

        end)

    end

end)



-- Auto Reset When Complete Volcano

Kitsune:AddToggle({

    Name = "Auto Reset if Complete Volcano",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.ResetPH = value

    end

})



-- Auto Reset When Complete Volcano Loop

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.ResetPH then

                local trialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

                

                if trialTeleport and trialTeleport:FindFirstChild("TouchInterest") then

                    -- Reset character

                    L_1_[45].Character.Humanoid.Health = 0

                else

                    -- Collect bones

                    if workspace:FindFirstChild("DinoBone") then

                        for _, bone in pairs(workspace:GetChildren()) do

                            if bone.Name == "DinoBone" then

                                _tp(bone.CFrame)

                            end

                        end

                    end

                end

            end

        end)

    end

end)



Fruits:AddSection("Select Raids Plates")



Fruits:AddParagraph("Color", "🔴 , 🟣, 🟢,🟣")


Fruits:AddSection("Auto Raids")



RaidChips = {

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

    "Dough"

}



Fruits:AddDropdown({

    Name = "Select Chip",

    Description = "",

    Options = RaidChips,

    Default = "",

    Callback = function(value)

        _G.SelectChip = value

    end

})



Fruits:AddToggle({

    Name = "Get Fruit In Inventory Below 1M Beli",

    Default = false,

    Callback = function(value)

        getgenv().AutoGetFruit = value

    end

})



-- Auto Get Fruit Loop

spawn(function()

    while wait() do

        pcall(function()

            if getgenv().AutoGetFruit then

                local cheapFruits = {

                    "Rocket-Rocket",

                    "Spin-Spin",

                    "Chop-Chop",

                    "Spring-Spring",

                    "Bomb-Bomb",

                    "Smoke-Smoke",

                    "Spike-Spike",

                    "Flame-Flame",

                    "Falcon-Falcon",

                    "Ice-Ice",

                    "Sand-Sand",

                    "Dark-Dark",

                    "Ghost-Ghost",

                    "Diamond-Diamond",

                    "Light-Light",

                    "Rubber-Rubber",

                    "Barrier-Barrier"

                }

                

                for _, fruit in ipairs(cheapFruits) do

                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", fruit)

                end

            end

        end)

    end

end)



Fruits:AddButton({

    Name = "Buy Dungeon Chips With Fruits",

    Description = "",

    Callback = function()

        if GetBP("Special Microchip") then return end

        

        local cheapFruits = {}

        local fruits = L_1_[55].Remotes.CommF_:InvokeServer("GetFruits")

        

        -- Lọc trái cây giá rẻ

        for _, fruitData in next, fruits do

            if fruitData.Price <= 490000 then

                table.insert(cheapFruits, fruitData.Name)

            end

        end

        

        -- Dùng trái cây giá rẻ để mua chip

        for _, fruitName in pairs(cheapFruits) do

            if not GetBP("Special Microchip") then

                L_1_[55].Remotes.CommF_:InvokeServer("LoadFruit", tostring(fruitName))

                L_1_[55].Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)

            end

        end

    end

})



Fruits:AddToggle({

    Name = "Auto Buy Chip With Beli",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoChipBeli = value

    end

})



-- Auto Buy Chip [Beli] Loop

task.spawn(function()

    while task.wait(1) do

        if _G.AutoChipBeli then

            pcall(function()

                if not GetBP("Special Microchip") then

                    L_1_[55].Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)

                end

            end)

        end

    end

end)



Fruits:AddToggle({

    Name = "Auto Start Raids",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Auto_StartRaid = value

    end

})



-- Auto Start Raid Loop

task.spawn(function()

    while task.wait(Sec or 1) do

        if not _G.Auto_StartRaid then

            continue

        end

        

        pcall(function()

            local player = game.Players.LocalPlayer

            local playerGui = player:FindFirstChild("PlayerGui")

            local mainGui = playerGui and playerGui:FindFirstChild("Main")

            local topHUD = mainGui and mainGui:FindFirstChild("TopHUDList")

            

            -- Kiểm tra nếu đang trong raid

            if not topHUD or topHUD.RaidTimer.Visible then

                return

            end

            

            -- Kiểm tra có chip không

            if not GetBP("Special Microchip") then

                return

            end

            

            -- Kích hoạt raid theo world

            if World2 then

                local button = workspace.Map.CircleIsland.RaidSummon2.Button.Main

                if button then

                    if button:FindFirstChild("ProximityPrompt") then

                        fireproximityprompt(button.ProximityPrompt)

                    elseif button:FindFirstChild("ClickDetector") then

                        fireclickdetector(button.ClickDetector)

                    end

                end

            end

            

            if World3 then

                local button = workspace.Map["Boat Castle"].RaidSummon2.Button.Main

                if button then

                    if button:FindFirstChild("ProximityPrompt") then

                        fireproximityprompt(button.ProximityPrompt)

                    elseif button:FindFirstChild("ClickDetector") then

                        fireclickdetector(button.ClickDetector)

                    end

                end

            end

        end)

    end

end)



Fruits:AddToggle({
    Name = "Auto Raids [Fully]",
    Description = " 4-5 kill aura",
    Default = false,
    Callback = function(value)
        _G.Raiding = value      
        if not value then
            _G.KillAuraFull = false
        end
    end
})

-- Luồng chạy Kill Aura riêng biệt (dựa trên đoạn code của bạn)
spawn(function()
    local Range = 500
    while task.wait(0.5) do
        if _G.KillAuraFull then
            pcall(function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                sethiddenproperty(plr, "SimulationRadius", math.huge)

                if workspace:FindFirstChild("Enemies") then
                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                        local eh = enemy:FindFirstChild("Humanoid")
                        local ehrp = enemy:FindFirstChild("HumanoidRootPart")
                        if eh and ehrp then
                            local dist = (ehrp.Position - hrp.Position).Magnitude
                            if dist <= Range and eh.Health > 0 then
                                eh.Health = 0
                                ehrp.CanCollide = false
                                enemy:BreakJoints()
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Luồng điều hướng Đảo và Auto Raid
spawn(function()
    local locations = workspace:WaitForChild("_WorldOrigin"):WaitForChild("Locations")
    local islands = {"Island 1", "Island 2", "Island 3", "Island 4", "Island 5"}
    local currentIsland = nil

    while task.wait(0.3) do
        if not _G.Raiding then 
            _G.KillAuraFull = false
            continue 
        end

        local char = plr.Character
        if not char then continue end

        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum or hum.Health <= 0 then continue end
        if hum.Sit or hum.PlatformStand or root.Anchored then continue end

        -- Tìm đảo gần nhất
        local closestDist = 999999
        for _, name in ipairs(islands) do
            local loc = locations:FindFirstChild(name)
            if loc then
                local dist = (root.Position - loc.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    currentIsland = name
                end
            end
        end

        if not currentIsland then continue end
        local islandPos = locations:FindFirstChild(currentIsland)
        if not islandPos then continue end

        -- Kiểm tra nếu tới Đảo 4 hoặc Đảo 5 thì bật Kill Aura toàn cục và đứng cố định
        local isHighIsland = (currentIsland == "Island 4" or currentIsland == "Island 5")

        if isHighIsland then
            _G.KillAuraFull = true
            pcall(function()
                root.CFrame = islandPos.CFrame * CFrame.new(0, 40, 0) -- Đứng lơ lửng trên cao giữa đảo
                root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end)
        else
            _G.KillAuraFull = false
        end

        -- Xử lý dọn quái
        local foundEnemies = false
        if workspace:FindFirstChild("Enemies") then
            for _, mob in ipairs(workspace.Enemies:GetChildren()) do
                local eh = mob:FindFirstChild("Humanoid")
                local ehrp = mob:FindFirstChild("HumanoidRootPart")
                if eh and ehrp and eh.Health > 0 then
                    local checkRange = isHighIsland and 600 or 450
                    if (ehrp.Position - islandPos.Position).Magnitude < checkRange then
                        foundEnemies = true
                        
                        -- Nếu ở đảo thấp (1, 2, 3) thì dùng hàm đấm thường
                        if not isHighIsland then
                            repeat
                                task.wait()
                                Attack.Kill(mob, _G.Raiding)
                            until not _G.Raiding or not mob.Parent or eh.Health <= 0
                        end
                    end
                end
            end
        end

        -- Nếu sạch quái ở đảo hiện tại, tự động bay sang đảo tiếp theo
        if not foundEnemies then
            local idx = table.find(islands, currentIsland)
            if idx and islands[idx + 1] then
                local nxt = locations:FindFirstChild(islands[idx + 1])
                if nxt then
                    local safePos = nxt.CFrame * CFrame.new(0, 45, 120)
                    _tp(safePos)
                end
                currentIsland = islands[idx + 1]
                task.wait(1)
            end
        end
    end
end)



Fruits:AddToggle({

    Name = "Auto Awakening Fruits",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Auto_Awakener = value

    end

})



-- Auto Awakening Loop

spawn(function()

    while wait(Sec or 1) do

        pcall(function()

            if _G.Auto_Awakener then

                L_1_[55].Remotes.CommF_:InvokeServer("Awakener", "Check")

                L_1_[55].Remotes.CommF_:InvokeServer("Awakener", "Awaken")

            end

        end)

    end

end)



Fruits:AddToggle({

    Name = "Auto Teleport To Lab",

    Default = false,

    Callback = function(value)

        _G.TpLab = value

        

        while _G.TpLab do

            wait()

            if _G.TpLab then

                if World2 and _G.TpLab then

                    topos(CFrame.new(-6438.73535, 250.645355, -4501.50684))

                elseif World3 and _G.TpLab then

                    topos(CFrame.new(-5017.40869, 314.844055, -2823.0127, -0.925743818, 4.48217499e-08, -0.378151238, 4.55503146e-09, 1, 1.07377559e-07, 0.378151238, 9.7681621e-08, -0.925743818))

                end

            end

        end

    end

})



Fruits:AddSection("Law Raids")



Fruits:AddButton({

    Name = "Buy Microchip Law",

    Description = "",

    Callback = function()

        L_1_[55].Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")

    end

})



Fruits:AddButton({

    Name = "Start Law Raids",

    Description = "",

    Callback = function()

        local button = workspace.Map.CircleIsland.RaidSummon.Button.Main

        if button and button:FindFirstChild("ClickDetector") then

            fireclickdetector(button.ClickDetector)

        end

    end

})



Fruits:AddToggle({

    Name = "Auto Buy Microchip Law",

    Description = "",

    Default = false,

    Callback = function(value)

        getgenv().AutoBuyMicrochipLaw = value

    end

})



-- Auto Buy Microchip Law Loop

spawn(function()

    while task.wait(1) do

        if getgenv().AutoBuyMicrochipLaw then

            pcall(function()

                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")

            end)

        end

    end

end)



Fruits:AddToggle({

    Name = "Auto Start Law Raids",

    Description = "",

    Default = false,

    Callback = function(value)

        getgenv().AutoStartLawRaids = value

    end

})



-- Auto Start Law Raids Loop

spawn(function()

    while task.wait(1) do

        if getgenv().AutoStartLawRaids then

            pcall(function()

                local button = workspace.Map.CircleIsland.RaidSummon.Button.Main

                if button and button:FindFirstChild("ClickDetector") then

                    fireclickdetector(button.ClickDetector)

                end

            end)

        end

    end

end)



Fruits:AddToggle({

    Name = "Auto Kill Law",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoLawKak = value

    end

})



-- Auto Kill Law Loop

spawn(function()

    while wait(Sec or 1) do

        if _G.AutoLawKak then

            pcall(function()

                local enemy = GetConnectionEnemies("Order")

                if enemy then

                    repeat

                        task.wait()

                        L_1_[4].Kill(enemy, _G.AutoLawKak)

                    until _G.AutoLawKak == false or not enemy.Parent or enemy.Humanoid.Health <= 0

                else

                    _tp(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875))

                end

            end)

        end

    end

end)

Fruits:AddSection("Auto Fruits")



Fruits:AddButton({

    Name = "Random Fruits",

    Description = "",

    Callback = function()

        Window:Dialog({

            Title = "Buy",

            Content = "Do You Want Random Fruits?",

            Options = {

                {

                    Title = "Confirm",

                    Callback = function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer('Cousin', 'Buy')

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



-- Store Fruits Toggle

Fruits:AddToggle({

    Name = "Store Fruits",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.StoreF = value

    end

})



-- Store Fruits Loop

spawn(function()

  while wait(Sec) do

    if _G.StoreF then

      pcall(function() UpdStFruit() end)

    end

  end

end)



-- Tween Fruits Toggle

Fruits:AddToggle({

    Name = "Tween Fruits",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.InstanceF = value

    end

})



-- Tween Fruits Loop

spawn(function()

    while wait(Sec or 1) do

        if _G.InstanceF then

            pcall(function() 

                if collectFruits then

                    collectFruits(_G.InstanceF) 

                end

            end)

        end

    end

end)



Fruits:AddSection("Stork Fruits")



fruitsOnSale = {}

function addCommas(number)

    local formatted = tostring(number)

    while true do  

        formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')

        if k == 0 then break end

    end

    return formatted

end

for _, fruitData in pairs(replicated.Remotes.CommF_:InvokeServer("GetFruits",true)) do

    if fruitData["OnSale"] == true then

        priceWithCommas = addCommas(fruitData["Price"])

        fruitInfo = fruitData["Name"]

        table.insert(fruitsOnSale, fruitInfo)

    end

end

Nms = {}

for _, fruitData in pairs(replicated.Remotes.CommF_:InvokeServer("GetFruits",false)) do

    if fruitData["OnSale"] == true then

        price = addCommas(fruitData["Price"])

        NormalInFO = fruitData["Name"]

        table.insert(Nms, NormalInFO)

    end

end



-- Select Normal Fruits Dropdown

Fruits:AddDropdown({

    Name = "Select Normal Fruits",

    Options = Nms,

    Default = nil,

    Callback = function(value)

        _G.SelectFruit = value

Nms = {}

for _, fruitData in pairs(replicated.Remotes.CommF_:InvokeServer("GetFruits",false)) do

    if fruitData["OnSale"] == true then

        price = addCommas(fruitData["Price"])

        NormalInFO = fruitData["Name"]

        table.insert(Nms, NormalInFO)

    end

end

    end

})



-- Select Mirage Fruits Dropdown

Fruits:AddDropdown({

    Name = "Select Mirage Fruits",

    Options = fruitsOnSale,

    Default = nil,

    Callback = function(value)

        SelectF_Adv = value

        fruitsOnSale = {}

function addCommas(number)

    local formatted = tostring(number)

    while true do  

        formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')

        if k == 0 then break end

    end

    return formatted

end

for _, fruitData in pairs(replicated.Remotes.CommF_:InvokeServer("GetFruits",true)) do

    if fruitData["OnSale"] == true then

        priceWithCommas = addCommas(fruitData["Price"])

        fruitInfo = fruitData["Name"]

        table.insert(fruitsOnSale, fruitInfo)

    end

end

    end

})



-- Buy Fruits Stork Button

Fruits:AddButton({

    Name = "Buy Fruits Stork",

    Description = "",

    Callback = function()

        Window:Dialog({

            Title = "Select Type",

            Content = "What Type you want buy?",

            Options = {

                {

                    Title = "Normal Fruits",

                    Callback = function()

                        if _G.SelectFruit then

                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", _G.SelectFruit)

                        end

                    end

                },

                {

                    Title = "Mirage Fruits",

                    Callback = function()

                        if SelectF_Adv then

                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", SelectF_Adv)

                        end

                    end

                },

                {

                    Title = "Cancel",

                    Callback = function() end

                }

            }

        })

    end

})



Fruits:AddSection("Auto Dungeon")



-- Auto Farm Dungeon Toggle

AutoFarmDungeon = Fruits:AddToggle({

    Name = "Auto Farm Dungeon",

    Description = "Auto kill mobs in dungeon",

    Default = false,

    Callback = function(value)

        _G.AutoFarmDungeon = value

    end

})



-- Auto Farm Dungeon Logic

spawn(function()

    while wait(0.15) do

        pcall(function()

            if _G.AutoFarmDungeon then

                for _, v in pairs(workspace.Enemies:GetChildren()) do

                    if Attack and Attack.Alive and Attack.Alive(v) then

                        distance = (Root.Position - v.HumanoidRootPart.Position).Magnitude

                        if distance <= 5000 then

                            repeat

                                task.wait()

                                if Attack and Attack.Kill then

                                    Attack.Kill(v, _G.AutoFarmDungeon)

                                end

                            until not _G.AutoFarmDungeon or not v.Parent or v.Humanoid.Health <= 0

                        end

                    end

                end

            end

        end)

    end

end)



-- Helper function to find the current floor's exit teleporter

function getCurrentFloorExit()

    rootPart = Root

    if not rootPart then return nil end

    

    if not workspace.Map or not workspace.Map.Dungeon then return nil end

    

    for _, floor in pairs(workspace.Map.Dungeon:GetChildren()) do

        exitTeleporter = floor:FindFirstChild("ExitTeleporter")

        if exitTeleporter and exitTeleporter:FindFirstChild("Root") then

            if (rootPart.Position - exitTeleporter.Root.Position).Magnitude < 200 then

                return exitTeleporter.Root

            end

        end

    end

    return nil

end



-- TP to Exit (1)

TPFloor1_Flag = false

TPFloor1 = Fruits:AddToggle({

    Name = "TP Exit (Current Floor)",

    Description = "Teleports you to the exit of the floor you are currently on",

    Default = false,

    Callback = function(value)

        _G.TPFloor1 = value

        if not value then TPFloor1_Flag = false end

    end

})



spawn(function()

    while wait(0.3) do

        if _G.TPFloor1 and not TPFloor1_Flag then

            exitRoot = getCurrentFloorExit()

            if exitRoot then

                Root.CFrame = exitRoot.CFrame * CFrame.new(0, 3, 0)

                TPFloor1_Flag = true

            end

        end

    end

end)



-- TP to Exit (2)

TPFloor2_Flag = false

TPFloor2 = Fruits:AddToggle({

    Name = "TP Exit (From Entrance)",

    Description = "If you're at an entrance, teleports you to that floor's exit",

    Default = false,

    Callback = function(value)

        _G.TPFloor2 = value

        if not value then TPFloor2_Flag = false end

    end

})



spawn(function()

    while wait(0.3) do

        if _G.TPFloor2 and not TPFloor2_Flag then

            rootPart = Root

            if not rootPart then return end

            

            if not workspace.Map or not workspace.Map.Dungeon then return end

            

            for _, floor in pairs(workspace.Map.Dungeon:GetChildren()) do

                entrance = floor:FindFirstChild("EntranceTeleporter")

                exit = floor:FindFirstChild("ExitTeleporter")

                if entrance and entrance:FindFirstChild("Root") and exit and exit:FindFirstChild("Root") then

                    if (rootPart.Position - entrance.Root.Position).Magnitude < 100 then

                        Root.CFrame = exit.Root.CFrame * CFrame.new(0, 3, 0)

                        TPFloor2_Flag = true

                        break

                    end

                end

            end

        end

    end

end)



-- Helper to get the highest floor number

function getHighestFloor()

    if not workspace.Map or not workspace.Map.Dungeon then return nil end

    

    highestFloor = nil

    for _, floor in pairs(workspace.Map.Dungeon:GetChildren()) do

        floorNum = tonumber(floor.Name)

        if floorNum and (not highestFloor or floorNum > tonumber(highestFloor.Name)) then

            highestFloor = floor

        end

    end

    return highestFloor

end



-- TP to Exit (3)

TPFloor3_Flag = false

TPFloor3 = Fruits:AddToggle({

    Name = "TP Exit (Highest Floor)",

    Description = "Teleports you to the exit of the highest floor",

    Default = false,

    Callback = function(value)

        _G.TPFloor3 = value

        if not value then TPFloor3_Flag = false end

    end

})



spawn(function()

    while wait(0.3) do

        if _G.TPFloor3 and not TPFloor3_Flag then

            highestFloor = getHighestFloor()

            if highestFloor and highestFloor:FindFirstChild("ExitTeleporter") and highestFloor.ExitTeleporter:FindFirstChild("Root") then

                Root.CFrame = highestFloor.ExitTeleporter.Root.CFrame * CFrame.new(0, 3, 0)

                TPFloor3_Flag = true

            end

        end

    end

end)



-- Helper to get the closest exit teleporter

function getClosestExit()

    rootPart = Root

    if not rootPart then return nil end

    

    if not workspace.Map or not workspace.Map.Dungeon then return nil end

    

    closestDist = math.huge

    closestExitRoot = nil

    

    for _, floor in pairs(workspace.Map.Dungeon:GetChildren()) do

        exitTeleporter = floor:FindFirstChild("ExitTeleporter")

        if exitTeleporter and exitTeleporter:FindFirstChild("Root") then

            dist = (rootPart.Position - exitTeleporter.Root.Position).Magnitude

            if dist < closestDist then

                closestDist = dist

                closestExitRoot = exitTeleporter.Root

            end

        end

    end

    return closestExitRoot

end



-- TP to Exit (4)

TPFloor4_Flag = false

TPFloor4 = Fruits:AddToggle({

    Name = "TP Exit (Closest)",

    Description = "Teleports you to the closest exit overall",

    Default = false,

    Callback = function(value)

        _G.TPFloor4 = value

        if not value then TPFloor4_Flag = false end

    end

})



spawn(function()

    while wait(0.3) do

        if _G.TPFloor4 and not TPFloor4_Flag then

            closestExitRoot = getClosestExit()

            if closestExitRoot then

                Root.CFrame = closestExitRoot.CFrame * CFrame.new(0, 3, 0)

                TPFloor4_Flag = true

            end

        end

    end

end)



Race:AddSection("Draco Trial")



-- Hàm lấy level Draco

local function GetQuestDracoLevel()

    local remote = L_1_[18].Modules.Net:FindFirstChild("RF/InteractDragonQuest")

    return remote:InvokeServer({

        NPC = "Dragon Wizard",

        Command = "Upgrade"

    })

end



-- Tween To Upgrade Draco Trial

Race:AddToggle({

    Name = "Telport To Upgrade Draco Trial V4",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.UPGDrago = value

    end

})



-- Upgrade Draco Trial Loop

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.UPGDrago then

                local canUpgrade = GetQuestDracoLevel()

                

                if canUpgrade == false then

                    -- Không thể upgrade

                    return

                elseif canUpgrade == true then

                    local dragonWizPos = CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609)

                    

                    if (dragonWizPos.Position - Root.Position).Magnitude >= 300 then

                        _tp(dragonWizPos)

                    else

                        _tp(dragonWizPos)

                        

                        local remote = L_1_[18].Modules.Net:FindFirstChild("RF/InteractDragonQuest")

                        remote:InvokeServer({

                            NPC = "Dragon Wizard",

                            Command = "Upgrade"

                        })

                    end

                end

            end

        end)

    end

end)



-- Auto Draco (V1)

Race:AddToggle({

    Name = "Auto Get Draco V1",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.DragoV1 = value

    end

})



-- Auto Draco V1 Loop

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.DragoV1 then

                if GetM("Dragon Egg") <= 0 then

                    repeat

                        wait()

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



-- Auto Draco (V2)

Race:AddToggle({

    Name = "Auto Upgrade Draco V1 to V2",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoFireFlowers = value

    end

})



-- Auto Draco V2 Loop

spawn(function()

    while wait(Sec) do

        if _G.AutoFireFlowers then

            local fireFlowers = workspace:FindFirstChild("FireFlowers")

            local enemy = GetConnectionEnemies("Forest Pirate")

            

            if enemy then

                repeat

                    wait()

                    L_1_[4].Kill(enemy, _G.AutoFireFlowers)

                until not _G.AutoFireFlowers or not enemy.Parent or enemy.Humanoid.Health <= 0 or fireFlowers

            else

                _tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))

            end

            

            if fireFlowers then

                for _, flower in pairs(fireFlowers:GetChildren()) do

                    if flower:IsA("Model") and flower.PrimaryPart then

                        local dist = (flower.PrimaryPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

                        

                        if dist <= 100 then

                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)

                            wait(1.5)

                            game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)

                        else

                            _tp(CFrame.new(flower.PrimaryPart.Position))

                        end

                    end

                end

            end

        end

    end

end)



-- Auto Draco (V3)

Race:AddToggle({

    Name = "Auto Upgrade Draco V2 to V3",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.DragoV3 = value

    end

})



-- Auto Drago V3 Loop

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.DragoV3 then

                repeat

                    wait()

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



-- Auto Relic Drago Trial [Beta]

Race:AddToggle({

    Name = "Auto Relic Drago Trial [Beta]",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Relic123 = value

    end

})



-- Auto Relic Loop

spawn(function()

    while wait(Sec) do

        if _G.Relic123 then

            pcall(function()

                if workspace.Map:FindFirstChild("DracoTrial") then

                    L_1_[18].Remotes.DracoTrial:InvokeServer()

                    wait(.5)

                    

                    repeat

                        wait()

                        _tp(CFrame.new(-39934.9765625, 10685.359375, 22999.34375))

                    until not _G.Relic123 or Root.Position == CFrame.new(-39934.9765625, 10685.359375, 22999.34375).Position

                    

                    repeat

                        wait()

                        _tp(CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625))

                    until not _G.Relic123 or Root.Position == CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625).Position

                    

                    wait(2.5)

                    

                    repeat

                        wait()

                        _tp(CFrame.new(-39914.65625, 10685.384765625, 23000.177734375))

                    until not _G.Relic123 or Root.Position == CFrame.new(-39914.65625, 10685.384765625, 23000.177734375).Position

                    

                    repeat

                        wait()

                        _tp(CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375))

                    until not _G.Relic123 or Root.Position == CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375).Position

                    

                    wait(2.5)

                    

                    repeat

                        wait()

                        _tp(CFrame.new(-39908.5, 10685.405273438, 22990.04296875))

                    until not _G.Relic123 or Root.Position == CFrame.new(-39908.5, 10685.405273438, 22990.04296875).Position

                    

                    repeat

                        wait()

                        _tp(CFrame.new(-39609.5, 9376.400390625, 23472.94335975))

                    until not _G.Relic123 or Root.Position == CFrame.new(-39609.5, 9376.400390625, 23472.94335975).Position

                    

                else

                    local trialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

                    if trialTeleport and trialTeleport:IsA("Part") then

                        _tp(CFrame.new(trialTeleport.Position))

                    end

                end

            end)

        end

    end

end)



-- Auto Train Drago v4

Race:AddToggle({

    Name = "Auto Training Drago V4",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.TrainDrago = value

    end

})



-- Auto Train Drago v4 Loop

spawn(function()

    while wait(Sec) do

        pcall(function()

            if _G.TrainDrago then

                local targets = {"Venomous Assailant", "Hydra Enforcer"}

                

                if L_1_[45].Character:FindFirstChild("RaceEnergy").Value == 1 then

                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Y", false, game)

                    L_1_[18].Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)

                    _tp(CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492))

                    

                elseif L_1_[45].Character:FindFirstChild("RaceTransformed").Value == false then

                    local enemy = GetConnectionEnemies(targets)

                    if enemy then

                        repeat

                            wait()

                            L_1_[4].Kill(enemy, _G.TrainDrago)

                        until _G.TrainDrago == false or enemy.Humanoid.Health <= 0 or not enemy.Parent

                    else

                        _tp(CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492))

                    end

                end

            end

        end)

    end

end)



-- Swap Drago Race

Race:AddToggle({

    Name = "Buy Drago Race",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.BuyDrago = value

    end

})



-- Swap Drago Race Loop

spawn(function()

    while wait(Sec) do

        if _G.BuyDrago then

            pcall(function()

                local dragonWizPos = CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609)

                

                if (dragonWizPos.Position - Root.Position).Magnitude >= 300 then

                    _tp(dragonWizPos)

                else

                    _tp(dragonWizPos)

                    

                    local remote = L_1_[18].Modules.Net:FindFirstChild("RF/InteractDragonQuest")

                    remote:InvokeServer({

                        NPC = "Dragon Wizard",

                        Command = "DragonRace"

                    })

                end

            end)

        end

    end

end)



-- Upgrade Dragon Talon With Uzoth

Race:AddToggle({

    Name = "Upgrade Dragon Talon With Admin Uzoth",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.DT_Uzoth = value

    end

})



-- Upgrade Dragon Talon Loop

spawn(function()

    while wait(Sec) do

        if _G.DT_Uzoth then

            local uzothPos = CFrame.new(5661.89014, 1211.31909, 864.836731, 0.811413169, -1.36805838e-08, -0.584473014, 4.75227395e-08, 1, 4.25682458e-08, 0.584473014, -6.23161966e-08, 0.811413169)

            _tp(uzothPos)

            

            if (uzothPos.Position - L_1_[45].Character.HumanoidRootPart.Position).Magnitude <= 25 then

                local remote = L_1_[18].Modules.Net:FindFirstChild("RF/InteractDragonQuest")

                remote:InvokeServer({

                    NPC = "Uzoth",

                    Command = "Upgrade"

                })

            end

        end

    end

end)



Race:AddSection("Trials Race V4")



-- Auto Train V4

Race:AddToggle({

    Name = "Auto Training Race V4",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AcientOne = value

    end

})



spawn(function()

    while wait(Sec or 1) do

        pcall(function()

            if _G.AcientOne then

                local enemies = {

                    "Reborn Skeleton",

                    "Living Zombie",

                    "Demonic Soul",

                    "Posessed Mummy"

                }

                

                if L_1_[45].Character:FindFirstChild("RaceEnergy") and L_1_[45].Character.RaceEnergy.Value == 1 then

                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Y", false, game)

                    L_1_[18].Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")

                    _tp(CFrame.new(-8987.041015625, 215.86206054688, 5886.7104492188))

                    

                elseif L_1_[45].Character:FindFirstChild("RaceTransformed") and L_1_[45].Character.RaceTransformed.Value == false then

                    local enemy = GetConnectionEnemies(enemies)

                    if enemy then

                        repeat

                            wait()

                            L_1_[4].Kill(enemy, _G.AcientOne)

                        until _G.AcientOne == false or enemy.Humanoid.Health <= 0 or not enemy.Parent

                    else

                        _tp(CFrame.new(-9495.6806640625, 453.58624267578, 5977.3486328125))

                    end

                end

            end

        end)

    end

end)



-- Teleport to Ancient One

Race:AddButton({

    Name = "Auto Teleport to Ancient One Trials",

    Description = "",

    Callback = function()

        local player = game.Players.LocalPlayer

        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then

            hrp.CFrame = CFrame.new(28286.35546875, 14895.301757812, 102.62469482422)

        end

        

        if not workspace.Map:FindFirstChild("Temple of Time") and World3 then

            local mapStash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")

            if mapStash and mapStash:FindFirstChild("Temple of Time") then

                mapStash["Temple of Time"].Parent = workspace.Map

            end

        end

        

        task.wait(2)

        tween(CFrame.new(28981.552734375, 14888.426757812, -120.24584960938))

    end

})



-- Teleport to Ancient Clock

Race:AddButton({

    Name = "Auto Teleport to Ancient Clock Trials",

    Description = "",

    Callback = function()

        local player = game.Players.LocalPlayer

        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        local templePos = CFrame.new(28286.35546875, 14895.301757812, 102.62469482422)

        local clockPos = CFrame.new(29549, 15069, -88)

        

        if hrp then

            hrp.CFrame = templePos

        end

        

        task.delay(2, function()

            _tp(clockPos)

        end)

        

        if not workspace.Map:FindFirstChild("Temple of Time") and World3 then

            local mapStash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")

            if mapStash and mapStash:FindFirstChild("Temple of Time") then

                mapStash["Temple of Time"].Parent = workspace.Map

            end

        end

    end

})



-- Auto Teleport to Race Doors

Race:AddToggle({

    Name = "Auto Teleport to Race Doors",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.TPDoor = value

    end

})



spawn(function()

    while wait(Sec or 1) do

        pcall(function()

            if _G.TPDoor and L_1_[45].Data and L_1_[45].Data.Race then

                local race = tostring(L_1_[45].Data.Race.Value)

                

                if race == "Mink" then

                    _tp(CFrame.new(29020.66015625, 14889.426757812, -379.2682800293))

                elseif race == "Fishman" then

                    _tp(CFrame.new(28224.056640625, 14889.426757812, -210.58720397949))

                elseif race == "Cyborg" then

                    _tp(CFrame.new(28492.4140625, 14894.426757812, -422.11001586914))

                elseif race == "Skypiea" then

                    _tp(CFrame.new(28967.408203125, 14918.075195312, 234.31198120117))

                elseif race == "Ghoul" then

                    _tp(CFrame.new(28672.720703125, 14889.127929688, 454.59616088867))

                elseif race == "Human" then

                    _tp(CFrame.new(29237.294921875, 14889.426757812, -206.94955444336))

                end

            end

        end)

    end

end)



-- Auto Complete Trial Race

Race:AddToggle({

    Name = "Auto Done the Trials Race",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Complete_Trials = value

    end

})



-- Helper function cho Fishman Trial

local function GetSeaBeastTrial()

    if not workspace.Map:FindFirstChild("FishmanTrial") then return nil end

    

    local fishmanTrial = workspace._WorldOrigin.Locations:FindFirstChild("Trial of Water")

    if not fishmanTrial then fishmanTrial = workspace.Map.FishmanTrial end

    

    if fishmanTrial then

        for _, seaBeast in next, workspace.SeaBeasts:GetChildren() do

            if seaBeast:FindFirstChild("HumanoidRootPart") and seaBeast:FindFirstChild("Health") then

                local dist = (seaBeast.HumanoidRootPart.Position - fishmanTrial.Position).Magnitude

                if dist <= 1500 and seaBeast.Health.Value > 0 then

                    return seaBeast

                end

            end

        end

    end

    return nil

end



-- Auto Complete Trial theo từng race

spawn(function()

    while wait(Sec or 1) do

        pcall(function()

            if not _G.Complete_Trials or not L_1_[45].Data or not L_1_[45].Data.Race then return end

            

            local race = tostring(L_1_[45].Data.Race.Value)

            

            if race == "Mink" then

                -- Mink Trial

                local minkTrial = workspace.Map:FindFirstChild("MinkTrial")

                if minkTrial and minkTrial:FindFirstChild("Ceiling") then

                    notween(minkTrial.Ceiling.CFrame * CFrame.new(0, -20, 0))

                end

                

            elseif race == "Fishman" then

                -- Fishman Trial

                local seaBeast = GetSeaBeastTrial()

                if seaBeast then

                    repeat

                        task.wait()

                        spawn(function()

                            local waterY = workspace.Map:FindFirstChild("WaterBase-Plane").Position.Y

                            _tp(CFrame.new(seaBeast.HumanoidRootPart.Position.X, waterY + 300, seaBeast.HumanoidRootPart.Position.Z))

                        end)

                        

                        MousePos = seaBeast.HumanoidRootPart.Position

                        Useskills("Melee", "Z")

                        Useskills("Melee", "X")

                        Useskills("Melee", "C")

                        wait(0.1)

                        Useskills("Sword", "Z")

                        Useskills("Sword", "X")

                        wait(0.1)

                        Useskills("Blox Fruit", "Z")

                        Useskills("Blox Fruit", "X")

                        Useskills("Blox Fruit", "C")

                        wait(0.1)

                        Useskills("Gun", "Z")

                        Useskills("Gun", "X")

                    until _G.Complete_Trials == false or not GetSeaBeastTrial()

                end

                

            elseif race == "Cyborg" then

                -- Cyborg Trial

                local cyborgTrial = workspace.Map:FindFirstChild("CyborgTrial")

                if cyborgTrial and cyborgTrial:FindFirstChild("Floor") then

                    _tp(cyborgTrial.Floor.CFrame * CFrame.new(0, 500, 0))

                end

                

            elseif race == "Skypiea" then

                -- Skypiea Trial

                local skyTrial = workspace.Map:FindFirstChild("SkyTrial")

                if skyTrial and skyTrial:FindFirstChild("Model") and skyTrial.Model:FindFirstChild("FinishPart") then

                    notween(skyTrial.Model.FinishPart.CFrame)

                end

                

            elseif race == "Human" or race == "Ghoul" then

                -- Human/Ghoul Trial

                local enemies = {"Ancient Vampire", "Ancient Zombie"}

                local enemy = GetConnectionEnemies(enemies)

                if enemy then

                    repeat

                        wait()

                        L_1_[4].Kill(enemy, _G.Complete_Trials)

                    until _G.Complete_Trials == false or not enemy.Parent or enemy.Humanoid.Health <= 0

                end

            end

        end)

    end

end)



-- Auto Kill Player After Trial

Race:AddToggle({

    Name = "Auto Kill Player After Trials Race",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Defeating = value

    end

})



spawn(function()

    while task.wait(Sec or 1) do

        pcall(function()

            if _G.Defeating then

                for _, character in pairs(workspace.Characters:GetChildren()) do

                    if character.Name ~= L_1_[45].Name then

                        local humanoid = character:FindFirstChild("Humanoid")

                        local hrp = character:FindFirstChild("HumanoidRootPart")

                        

                        if humanoid and hrp and humanoid.Health > 0 and character.Parent then

                            local dist = (Root.Position - hrp.Position).Magnitude

                            if dist <= 250 then

                                repeat

                                    task.wait()

                                    if _G.SelectWeapon then

                                        EquipWeapon(_G.SelectWeapon)

                                    end

                                    _tp(hrp.CFrame * CFrame.new(0, 0, 15))

                                    sethiddenproperty(L_1_[45], "SimulationRadius", math.huge)

                                until _G.Defeating == false or humanoid.Health <= 0 or not character.Parent or not hrp or not humanoid

                            end

                        end

                    end

                end

            end

        end)

    end

end)



Items:AddSection("Get Sword in Sea 1")



Items:AddToggle({

    Name = "Auto Get Saber Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoSaber = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Warden Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.WardenBoss = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Saw Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoSaw = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Pole Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoPole = value

    end

})



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



Items:AddSection("Get Accessory in Sea 1")



Items:AddToggle({

    Name = "Auto Get Swan Coat",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.SwanCoat = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Marines Coat",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.MarinesCoat = value

    end

})



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



Items:AddSection("Upgrade Items in Sea 1")



Items:AddToggle({

    Name = "Auto Upgrade Bisento Sword V1 to V2",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Greybeard = value

    end

})



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



Items:AddSection("Get Sword in Sea 2")



Items:AddToggle({

    Name = "Auto Get Long Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.LongsWord = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Rengoku Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.IceBossRen = value

    end

})



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



Items:AddToggle({

    Name = "Auto Open Key Rengoku Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.KeysRen = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Midnight Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoEcBoss = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Dragon Trident Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoTridentW2 = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get KOKO Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoLawKak = value

    end

})



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



Items:AddSection("Get Accessory in Sea 2")



Items:AddToggle({

    Name = "Auto Get Black Spikey Coat",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.BlackSpikey = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Dark Coat",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Auto_Def_DarkCoat = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Swan Glasses",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Auto_SwanGG = value

    end

})



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



Items:AddSection("Upgrade Items in Sea 2")



Items:AddToggle({

    Name = "Auto Upgrade Pole V2 Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoPoleV2 = value

    end

})



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



Items:AddToggle({

    Name = "Auto Upgrade Dark Blade V2 to V3",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.DarkBladev3 = value

    end

})



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



Items:AddSection("Get Sword in Sea 3")



Items:AddToggle({

    Name = "Auto Get Cavender Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Auto_Cavender = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Buddy Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoBigmom = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Twin Hooks Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.TwinHook = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get CDK Sword",

    Description = "",

    Default = false,

    Callback = function(Value)

        _G.CDK = Value

    end

})



-- Hàm kiểm tra tiến độ hiện tại

local function GetCDKProgress()

    local progress = replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress")

    return progress

end



spawn(function()

    while wait(Sec) do

        pcall(function()

            if not _G.CDK then return end

            

            -- Luôn cập nhật progress

            replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Good")

            replicated.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Evil")

            

            local progress = GetCDKProgress()

            local doorStatus = tostring(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor"))

            

            -- Nếu chưa mở cửa

            if doorStatus ~= "opened" then

                replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")

                replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)

                wait(0.5)

                return

            end

            

            -- Nếu chưa bắt đầu trial

            if progress["Finished"] == nil then

                -- Kiểm tra xem nên bắt đầu trial nào

                if GetWP("Yama") and not GetWP("Tushita") then

                    replicated.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Good") -- Tushita

                elseif GetWP("Tushita") and not GetWP("Yama") then

                    replicated.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil") -- Yama

                elseif not GetWP("Yama") and not GetWP("Tushita") then

                    -- Ưu tiên Yama trước (thường dễ hơn)

                    replicated.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil")

                else

                    -- Đã có cả 2, chuyển sang boss cuối

                    replicated.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Boss")

                end

                wait(0.5)

                return

            end

            

            -- Nếu đang làm Yama Trial (Evil)

            if progress["Finished"] == false and tonumber(progress["Evil"]) then

                local evilProgress = tonumber(progress["Evil"])

                

                -- Bước 1: Diệt Forest Pirate

                if evilProgress == -3 then

                    local v = GetConnectionEnemies("Forest Pirate")

                    if v then

                        Attack.Kill(v, _G.CDK)

                    else

                        _tp(CFrame.new(-13223.521484375, 428.1938171386719, -7766.06787109375))

                    end

                    

                -- Bước 2: Diệt Elite Haze

                elseif evilProgress == -4 then

                    for _, HitMon in pairs(plr.QuestHaze:GetChildren()) do

                        for NameMonHaze, CFramePos in pairs(PosMsList) do

                            if string.find(NameMonHaze, HitMon.Name) and HitMon.Value > 0 then

                                if (CFramePos.Position - Root.Position).Magnitude <= 1000 then

                                    local v = GetConnectionEnemies(NameMonHaze)

                                    if v then

                                        Attack.Kill(v, _G.CDK)

                                    end

                                else

                                    _tp(CFramePos)

                                end

                            end

                        end

                    end

                    

                -- Bước 3: Hell Dimension

                elseif evilProgress == -5 then

                    if workspace.Map:FindFirstChild("HellDimension") then

                        if (Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000 then

                            -- Đốt đuốc

                            for i = 1, 3 do

                                local torch = workspace.Map.HellDimension["Torch"..i]

                                if torch and torch.Particles then

                                    _tp(torch.Particles.CFrame)

                                    for _, v in pairs(workspace.Map.HellDimension:GetDescendants()) do

                                        if v:IsA("ProximityPrompt") then

                                            fireproximityprompt(v)

                                        end

                                    end

                                    wait(2)

                                end

                            end

                            

                            -- Diệt quái trong Hell Dimension

                            for _, v in pairs(workspace.Enemies:GetChildren()) do

                                if (v:FindFirstChild("HumanoidRootPart").Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 300 then

                                    Attack.Kill(v, _G.CDK)

                                end

                            end

                        end

                    else

                        -- Cần mở HellDimension bằng Soul Reaper

                        local soulReaper = GetConnectionEnemies("Soul Reaper")

                        if soulReaper then

                            _tp(soulReaper.HumanoidRootPart.CFrame)

                        elseif GetBP("Hallow Essence") then

                            _tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))

                            EquipWeapon("Hallow Essence")

                        else

                            -- Farm bone để mua Hallow Essence

                            if replicated.Remotes.CommF_:InvokeServer("Bones","Check") < 50 then

                                local boneMobs = {"Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy"}

                                local v = GetConnectionEnemies(boneMobs)

                                if v then

                                    Attack.Kill(v, _G.CDK)

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

            

            -- Nếu đang làm Tushita Trial (Good)

            if progress["Finished"] == false and tonumber(progress["Good"]) then

                local goodProgress = tonumber(progress["Good"])

                

                -- Bước 1: Đi thuyền đến 3 địa điểm

                if goodProgress == -3 then

                    local locations = {

                        CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875),

                        CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125),

                        CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625)

                    }

                    

                    for _, loc in ipairs(locations) do

                        _tp(loc)

                        wait(1)

                        if (loc.Position - Root.Position).Magnitude <= 10 then

                            replicated.Remotes.CommF_:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"),"Check")

                            replicated.Remotes.CommF_:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))

                        end

                        wait(1)

                    end

                    

                -- Bước 2: Auto Raid Castle

                elseif goodProgress == -4 then

                    _G.AutoRaidCastle = true

                    

                -- Bước 3: Heavenly Dimension

                elseif goodProgress == -5 then

                    if workspace.Map:FindFirstChild("HeavenlyDimension") then

                        if (Root.Position - workspace.Map.HeavenlyDimension.Spawn.Position).Magnitude <= 1000 then

                            -- Kích hoạt các prompt

                            for i = 1, 3 do

                                local targetCF = i == 1 and CFrame.new(-22529.6171875, 5275.77392578125, 3873.5712890625)

                                    or i == 2 and CFrame.new(-22637.291015625, 5281.365234375, 3749.28857421875)

                                    or CFrame.new(-22791.14453125, 5277.16552734375, 3764.570068359375)

                                

                                _tp(targetCF)

                                for _, v in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do

                                    if v:IsA("ProximityPrompt") then

                                        fireproximityprompt(v)

                                    end

                                end

                                wait(2)

                            end

                            

                            -- Diệt quái

                            for _, v in pairs(workspace.Enemies:GetChildren()) do

                                if (v:FindFirstChild("HumanoidRootPart").Position - CFrame.new(-22695.7012, 5270.93652, 3814.42847).Position).Magnitude <= 300 then

                                    Attack.Kill(v, _G.CDK)

                                end

                            end

                        end

                    else

                        -- Diệt Cake Queen để vào HeavenlyDimension

                        local cakeQueen = GetConnectionEnemies("Cake Queen")

                        if cakeQueen then

                            Attack.Kill(cakeQueen, _G.CDK)

                        else

                            _tp(CFrame.new(-709.3132934570312, 381.6005859375, -11011.396484375))

                        end

                    end

                end

            end

            

            -- Boss cuối cùng

            local boss = GetConnectionEnemies("Cursed Skeleton Boss")

            if boss then

                if plr.Backpack:FindFirstChild("Yama") or plr.Character:FindFirstChild("Yama") then

                    EquipWeapon("Yama")

                elseif plr.Backpack:FindFirstChild("Tushita") or plr.Character:FindFirstChild("Tushita") then

                    EquipWeapon("Tushita")

                end

                _tp(boss.HumanoidRootPart.CFrame * CFrame.new(0,20,0))

                Attack.Kill(boss, _G.CDK)

            else

                _tp(CFrame.new(-12318.193359375, 601.9518432617188, -6538.662109375))

                wait(0.5)

                _tp(workspace.Map.Turtle.Cursed.BossDoor.CFrame)

            end

        end)

    end

end)



-- Tắt AutoRaidCastle khi tắt CDK

spawn(function()

    while wait(Sec) do

        if not _G.CDK then

            _G.AutoRaidCastle = false

        end

    end

end)



Items:AddToggle({

    Name = "Auto Get Tushita Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Auto_Tushita = value

    end

})



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



Items:AddToggle({

    Name = "Auto Get Yama Sword",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Auto_Yama = value

    end

})



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



Items:AddSection("Get Gun in Sea 3")



Items:AddToggle({

    Name = "Auto Get Serpent Bow",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoSerpentBow = value

    end

})



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



Items:AddSection("Get Accessory in Sea 3")



Items:AddToggle({

    Name = "Auto Get Lei",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoKilo = value

    end

})



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



Items:AddSection("Get Accessory in Sea 3")



Items:AddToggle({

    Name = "Auto Get Lei",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoKilo = value

    end

})



Travel:AddSection("Teleport World")



Travel:AddButton({

    Name = "Teleport To World1",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")

    end

})



Travel:AddButton({

    Name = "Teleport To World2",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")

    end

})



Travel:AddButton({

    Name = "Teleport To World3",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")

    end

})



Travel:AddButton({

    Name = "Teleport To Dungeon",

    Callback = function()

        local Players = game:GetService("Players")

        local LocalPlayer = Players.LocalPlayer

        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

        local DungeonPlaceId = 73902483975735

        local AutoJoinDungeonServer = true -- Thêm khai báo biến



        local function IsDungeonGame()

            return game.PlaceId == DungeonPlaceId

        end



        local function ClickButtonOnce(Button, AttributeName)

            if not Button or not Button.Parent then

                return false

            end



            AttributeName = AttributeName or "ClickedOnce"



            if Button:GetAttribute(AttributeName) then

                return false

            end



            Button:SetAttribute(AttributeName, true)



            local Success = pcall(function()

                Button:Activate()

            end)



            if not Success then

                pcall(function()

                    if firesignal and Button.Activated then

                        firesignal(Button.Activated)

                    end

                end)

            end



            return true

        end



        local function ClickButton(Button)

            if not Button or not Button.Parent then

                return false

            end



            pcall(function()

                Button:Activate()

            end)



            pcall(function()

                if firesignal and Button.Activated then

                    firesignal(Button.Activated)

                end

            end)



            return true

        end



        while task.wait(0.5) do

            if IsDungeonGame() then

                if AutoJoinDungeonServer then

                    AutoJoinDungeonServer = false

                end

                continue

            end



            if not AutoJoinDungeonServer then

                local Success, ServerBrowserButton = pcall(function()

                    return PlayerGui:FindFirstChild("Topbar") and PlayerGui.Topbar:FindFirstChild("Frame") and PlayerGui.Topbar.Frame:FindFirstChild("ServerBrowserButton")

                end)



                if Success and ServerBrowserButton then

                    pcall(function()

                        ServerBrowserButton:SetAttribute("Clicked_ServerBrowserButton", nil)

                    end)

                end

                continue

            end



            local ServerBrowserButton = ((PlayerGui:WaitForChild("Topbar")):WaitForChild("Frame")):WaitForChild("ServerBrowserButton")

            ClickButtonOnce(ServerBrowserButton, "Clicked_ServerBrowserButton")



            local ServerBrowserGui = PlayerGui:WaitForChild("ServerBrowser")

            local StartTime = os.clock()



            while AutoJoinDungeonServer and os.clock() - StartTime < 5 do

                if ServerBrowserGui.Enabled ~= false and ServerBrowserGui.Parent then

                    break

                end

                task.wait(0.05)

            end



            if not AutoJoinDungeonServer then

                continue

            end



            local DungeonButton = ((ServerBrowserGui:WaitForChild("Frame")):WaitForChild("TeleportButtons")):WaitForChild("Dungeon")

            StartTime = os.clock()



            while AutoJoinDungeonServer and os.clock() - StartTime < 5 do

                if DungeonButton.Visible and DungeonButton.Active then

                    break

                end

                task.wait(0.05)

            end



            if not AutoJoinDungeonServer then

                continue

            end



            for i = 1, 3 do

                if not AutoJoinDungeonServer then

                    break

                end

                ClickButton(DungeonButton)

                task.wait(0.25)

            end



            AutoJoinDungeonServer = false

        end

    end

})



Travel:AddSection("Teleport Islands")



Location = {}

for i,v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do  

  table.insert(Location ,v.Name)

end



Travel:AddDropdown({

    Name = "Select Islands",

    Options = Location,

    Default = nil,

    Callback = function(Value)

        _G.Island = Value

    end

})



Travel:AddToggle({

    Name = "Auto Teleport Islands",

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



Travel:AddSection("Teleport NPC")



NPCList = {}

for _, v in pairs(replicated.NPCs:GetChildren()) do table.insert(NPCList, v.Name)

end



Travel:AddDropdown({

    Name = "Select NPC",

    Options = NPCList,

    Default = nil,

    Callback = function(Value)

        NPClist = Value

    end

})



Travel:AddToggle({

    Name = "Auto Teleport Islands",

    Default = false,

    Callback = function(Value)

        _G.TPNpc = Value

    end

})

    

spawn(function()

  while wait(Sec) do

    if _G.TPNpc then

	 pcall(function()

       for __, v in pairs(replicated.NPCs:GetChildren()) do

       if v.Name == NPClist then _tp(v.HumanoidRootPart.CFrame) end

       end                	   	   

	 end)

    end

  end

end)



local Number = math.random(1, 1000000)



-- Hàm làm tròn

local function round(n)

    return math.floor(tonumber(n) + 0.5)

end



-- Hàm kiểm tra nil

local function isnil(thing)

    return (thing == nil)

end



Travel:AddSection("Teleport To Temple Of Time")



-- Teleport to Temple of Time

Travel:AddButton({

    Name = "Auto Teleport to Temple of Time Trials",

    Description = "",

    Callback = function()

        local player = game.Players.LocalPlayer

        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then

            hrp.CFrame = CFrame.new(28286.35546875, 14895.301757812, 102.62469482422)

        end

        

        if not workspace.Map:FindFirstChild("Temple of Time") and World3 then

            local mapStash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")

            if mapStash and mapStash:FindFirstChild("Temple of Time") then

                mapStash["Temple of Time"].Parent = workspace.Map

            end

        end

    end

})



ESP:AddSection("Aimbot Skilll Nearest")



ESP:AddToggle({

    Name = "Auto Aimbot Skills Gun ",

    Default = false,

    Callback = function(Value)

        _G.AntiAFK = Value

    end

})



ESP:AddToggle({

    Name = "Auto Aimbot Tap ",

    Default = false,

    Callback = function(Value)

        _G.AntiAFK = Value

    end

})



-- Aimbot Skills Toggle

ESP:AddToggle({

    Name = "Auto Aimbot Skills",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AimMethod = value

    end

})



-- Aimbot Skills Loop - Specific Player

spawn(function()

    while wait() do

        pcall(function()

            if _G.AimMethod and ABmethod == "Specific Player" then

                local target = game.Players:FindFirstChild(_G.PlayersList)

                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then

                    if target.Team ~= game.Players.LocalPlayer.Team then

                        MousePos = target.Character.HumanoidRootPart.Position

                    end

                end

            end

        end)

    end

end)



-- Aimbot Skills Loop - Nearest Player

spawn(function()

    while wait() do

        pcall(function()

            if _G.AimMethod and ABmethod == "Nearest Player" then

                local closestDist = math.huge

                for _, player in pairs(game.Players:GetPlayers()) do

                    if player ~= game.Players.LocalPlayer and player.Team ~= game.Players.LocalPlayer.Team then

                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then

                            local dist = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

                            if dist < closestDist then

                                closestDist = dist

                                MousePos = player.Character.HumanoidRootPart.Position

                            end

                        end

                    end

                end

            end

        end)

    end

end)



ESP:AddToggle({

    Name = "Auto Ignore Mobs",

    Default = false,

    Callback = function(Value)

        _G.AntiAFK = Value

    end

})



ESP:AddSection("Aimlock Camera")



-- Aimbot Camera

ESP:AddToggle({

    Name = "Auto Aimbot With Camera",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AimCam = value

    end

})



task.spawn(function()

    while task.wait() do

        pcall(function()

            if _G.AimCam then

                local camera = workspace.CurrentCamera

                local closestPlayer = nil

                local closestDist = math.huge

                

                for _, player in pairs(game.Players:GetPlayers()) do

                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character.Humanoid.Health > 0 then

                        local dist = (player.Character.Head.Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude

                        if dist < closestDist then

                            closestDist = dist

                            closestPlayer = player

                        end

                    end

                end

                

                if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then

                    camera.CFrame = CFrame.new(camera.CFrame.Position, closestPlayer.Character.HumanoidRootPart.Position)

                end

            end

        end)

    end

end)



-- Aim Method Dropdown

ESP:AddDropdown({

    Name = "Select AIM",

    Description = "",

    Options = {

        "Specific Player",

        "Nearest Player"

    },

    Default = "Nearest Player",

    Callback = function(value)

        ABmethod = value

    end

})



ESP:AddSection("Aimbot Settings")



-- Dropdown chọn người chơi

PlayerList = {}

for _, player in pairs(game:GetService("Players"):GetChildren()) do

    table.insert(PlayerList, player.Name)

end



ESP:AddDropdown({

    Name = "Select Player",

    Description = "",

    Options = PlayerList,

    Default = "",

    Callback = function(value)

        _G.PlayersList = value

    end

})



-- Teleport to Player

ESP:AddToggle({

    Name = "Auto Teleport to Player",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.TpPly = value

        spawn(function()

            pcall(function()

                while _G.TpPly do

                    wait()

                    if game.Players[_G.PlayersList] and game.Players[_G.PlayersList].Character and game.Players[_G.PlayersList].Character:FindFirstChild("HumanoidRootPart") then

                        _tp(game.Players[_G.PlayersList].Character.HumanoidRootPart.CFrame)

                    end

                end

            end)

        end)

    end

})



-- Spectate Player

ESP:AddToggle({

    Name = "Spectate Player",

    Description = "",

    Default = false,

    Callback = function(value)

        SpectatePlys = value

        spawn(function()

            repeat

                task.wait(0.1)

                if game.Players:FindFirstChild(_G.PlayersList) then

                    workspace.Camera.CameraSubject = game.Players[_G.PlayersList].Character.Humanoid

                end

            until not SpectatePlys

            workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid

        end)

    end

})



ESP:AddSection("Player Quests")



-- Get Player Quest Button

ESP:AddButton({

    Name = "Auto Get Player Quests",

    Description = "",

    Callback = function()

        pcall(function()

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")

        end)

    end

})



-- Auto Get Player Quest

ESP:AddToggle({

    Name = "Auto Get Player Quests",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoReceivePlayerQuest = value

    end

})



spawn(function()

    while task.wait(1) do

        if _G.AutoReceivePlayerQuest then

            pcall(function()

                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")

            end)

        end

    end

end)



-- Auto Kill Player Quest

ESP:AddToggle({

    Name = "Auto Kill Player Quests",

    Default = false,

    Callback = function(value)

        _G.AutoPlayerHunter = value

    end

})



spawn(function()

    while task.wait() do

        if _G.AutoPlayerHunter then

            local questGui = game.Players.LocalPlayer.PlayerGui.Main.Quest

            if questGui.Visible == false then

                task.wait(0.5)

                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")

            else

                for _, character in pairs(workspace.Characters:GetChildren()) do

                    local questText = questGui.Container.QuestTitle.Title.Text

                    if string.find(questText, character.Name) then

                        repeat

                            task.wait()

                            if AutoHaki then AutoHaki() end

                            if EquipWeapon then EquipWeapon(_G.SelectWeapon) end

                            _G.Useskill = true

                            _tp(character.HumanoidRootPart.CFrame * CFrame.new(1, 7, 3))

                            character.HumanoidRootPart.Size = Vector3.new(60, 60, 60)

                            game:GetService("VirtualUser"):CaptureController()

                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))

                        until _G.AutoPlayerHunter == false or character.Humanoid.Health <= 0

                        _G.Useskill = false

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")

                    end

                end

            end

        end

    end

end)



ESP:AddSection("PVP Settings")



-- Auto Enable PvP

ESP:AddToggle({

    Name = "Auto Enable PVP",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.AutoPvP = value

    end

})



spawn(function()

    while task.wait(0.5) do

        if _G.AutoPvP then

            local playerGui = game.Players.LocalPlayer.PlayerGui

            if playerGui and playerGui.Main and playerGui.Main:FindFirstChild("PvpDisabled") then

                if playerGui.Main.PvpDisabled.Visible then

                    pcall(function()

                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")

                    end)

                end

            end

        end

    end

end)



-- Auto Safe Mode

ESP:AddToggle({

    Name = "Auto Teleport to Safe Mode",

    Default = false,

    Callback = function(value)

        _G.SafeMode = value

    end

})



spawn(function()

    while task.wait(0.1) do

        if _G.SafeMode then

            local character = game.Players.LocalPlayer.Character

            local hrp = character and character:FindFirstChild("HumanoidRootPart")

            if hrp then

                _tp(hrp.CFrame * CFrame.new(0, 200, 0))

            end

        end

    end

end)



ESP:AddSection("Move Settings")



-- Fly System Variables (global)

FlyEnabled = false

FlySpeed = 50

FlyDir = {f = 0, b = 0, l = 0, r = 0}

FlyConnection = nil

BodyGyro = nil

BodyVelocity = nil

HeartbeatConn = nil



-- Fly Function

function ToggleFly(state)

    FlyEnabled = state

    local player = game.Players.LocalPlayer

    local character = player.Character

    if not character then return end

    

    local humanoid = character:FindFirstChildOfClass("Humanoid")

    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")

    

    if not humanoid or not torso then return end

    

    if FlyEnabled then

        -- Disable collisions

        for _, part in ipairs(character:GetDescendants()) do

            if part:IsA("BasePart") then

                part.CanCollide = false

                part.Massless = true

            end

        end

        

        -- Handle new parts

        character.DescendantAdded:Connect(function(part)

            if FlyEnabled and part:IsA("BasePart") then

                part.CanCollide = false

                part.Massless = true

            end

        end)

        

        -- BodyGyro

        BodyGyro = Instance.new("BodyGyro", torso)

        BodyGyro.P = 90000

        BodyGyro.maxTorque = Vector3.new(9000000000, 9000000000, 9000000000)

        BodyGyro.cframe = torso.CFrame

        

        -- BodyVelocity

        BodyVelocity = Instance.new("BodyVelocity", torso)

        BodyVelocity.Velocity = Vector3.new(0, 0, 0)

        BodyVelocity.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)

        

        humanoid.PlatformStand = true

        

        -- Update movement

        HeartbeatConn = game:GetService("RunService").Heartbeat:Connect(function()

            if not FlyEnabled or not player.Character then return end

            

            for _, part in ipairs(player.Character:GetDescendants()) do

                if part:IsA("BasePart") and part.CanCollide then

                    part.CanCollide = false

                end

            end

            

            local moveDir = humanoid.MoveDirection

            FlyDir.f = moveDir.Z < -0.1 and 1 or 0

            FlyDir.b = moveDir.Z > 0.1 and 1 or 0

            FlyDir.l = moveDir.X < -0.1 and 1 or 0

            FlyDir.r = moveDir.X > 0.1 and 1 or 0

            

            if FlyDir.l + FlyDir.r ~= 0 or FlyDir.f + FlyDir.b ~= 0 then

                local cam = workspace.CurrentCamera

                BodyVelocity.Velocity = (cam.CFrame.LookVector * (FlyDir.f - FlyDir.b) + 

                    (cam.CFrame * CFrame.new(FlyDir.r - FlyDir.l, (FlyDir.f - FlyDir.b) * 0.2, 0).p - cam.CFrame.p)) * FlySpeed

            else

                BodyVelocity.Velocity = Vector3.new(0, 0, 0)

            end

            

            BodyGyro.cframe = workspace.CurrentCamera.CoordinateFrame

        end)

    else

        if HeartbeatConn then

            HeartbeatConn:Disconnect()

            HeartbeatConn = nil

        end

        

        if character then

            humanoid.PlatformStand = false

            

            for _, part in ipairs(character:GetDescendants()) do

                if part:IsA("BasePart") then

                    part.CanCollide = true

                    part.Massless = false

                end

            end

            

            if BodyGyro then BodyGyro:Destroy() end

            if BodyVelocity then BodyVelocity:Destroy() end

        end

        

        FlyDir = {f = 0, b = 0, l = 0, r = 0}

    end

end



-- Speed Setter

function SetFlySpeed(speed)

    FlySpeed = speed

end



-- Auto reconnect fly on respawn

game.Players.LocalPlayer.CharacterAdded:Connect(function()

    wait(1)

    if FlyEnabled then

        ToggleFly(false)

        wait(0.1)

        ToggleFly(true)

    end

end)



-- Fly Toggle

ESP:AddToggle({

    Name = "Auto Fly",

    Default = false,

    Callback = function(value)

        ToggleFly(value)

    end

})



-- Fly Speed Slider

ESP:AddSlider({

    Name = "Fly Speed",

    Min = 10,

    Max = 200,

    Default = 50,

    Callback = function(value)

        SetFlySpeed(value)

    end

})



-- Dash No Cooldown

ESP:AddToggle({

    Name = "Dash No Cooldown",

    Default = false,

    Callback = function(value)

        getgenv().DodgeNoCD = value

        if value then

            pcall(function()

                local dodgeScript = game.Players.LocalPlayer.Character:WaitForChild("Dodge")

                for _, func in next, getgc() do

                    if typeof(func) == "function" then

                        local env = getfenv(func)

                        if env.script == dodgeScript then

                            for i, upval in next, getupvalues(func) do

                                if tostring(upval) == "0.4" then

                                    setupvalue(func, i, 0)

                                end

                            end

                        end

                    end

                end

            end)

        end

    end

})



ESP:AddSection("ESP")



local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ESP_SAVE_FILE = "PlayerESP_Config.txt"
local PlayerEsp = false

local function GetUserThumbnail(userId)
    local content, isReady = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    return content
end

local function CreateESP(player)
    if not player.Character then return end
    
    if player.Character:FindFirstChild("CustomESP_Highlight") then
        player.Character.CustomESP_Highlight:Destroy()
    end
    if player.Character:FindFirstChild("CustomESP_Tag") then
        player.Character.CustomESP_Tag:Destroy()
    end

    local highlight = Instance.new("Highlight")
    highlight.Name = "CustomESP_Highlight"
    highlight.Adornee = player.Character
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = player.Character

    local head = player.Character:FindFirstChild("Head")
    if head then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "CustomESP_Tag"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 280, 0, 70)
        billboard.StudsOffset = Vector3.new(0, 3.2, 0)
        billboard.AlwaysOnTop = true

        -- Avatar
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Size = UDim2.new(0, 40, 0, 40)
        imageLabel.Position = UDim2.new(0, 0, 0, 5)
        imageLabel.BackgroundTransparency = 1
        imageLabel.Image = GetUserThumbnail(player.UserId)
        imageLabel.Parent = billboard

        local imgCorner = Instance.new("UICorner")
        imgCorner.CornerRadius = UDim.new(1, 0)
        imgCorner.Parent = imageLabel

        -- Text hiển thị thông tin
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -45, 1, 0)
        textLabel.Position = UDim2.new(0, 45, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextStrokeTransparency = 0.2
        textLabel.TextSize = 13
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.RichText = true
        textLabel.Parent = billboard

        task.spawn(function()
            while player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Head") and PlayerEsp do
                local humanoid = player.Character.Humanoid
                local dist = math.floor((LocalPlayer.Character.Head.Position - head.Position).Magnitude)
                local health = math.floor(humanoid.Health)
                local maxHealth = math.floor(humanoid.MaxHealth)
                
                -- Lấy giá trị Energy (thường nằm trong nhân vật hoặc giá trị giả lập nếu game không dùng chỉ số Energy chuẩn)
                local energy = math.floor(humanoid.Health) -- Mặc định tạm tính, hoặc thay bằng giá trị Energy thực tế của game nếu có
                local maxEnergy = math.floor(humanoid.MaxHealth)
                
                -- Kiểm tra nếu có giá trị Energy riêng trong nhân vật (ví dụ thuộc tính tùy chỉnh)
                if player.Character:FindFirstChild("Energy") then
                    energy = math.floor(player.Character.Energy.Value)
                elseif player.Character:FindFirstChild("Data") and player.Character.Data:FindFirstChild("Energy") then
                    energy = math.floor(player.Character.Data.Energy.Value)
                end

                local leaderstats = player:FindFirstChild("leaderstats")
                local lvl = 0
                if leaderstats and leaderstats:FindFirstChild("Level") then
                    lvl = leaderstats.Level.Value
                end
                
                -- Dòng 1: Tên [Lv.X] [Khoảng cách]
                local line1 = string.format("%s [Lv.%d] [%dm]", player.Name, lvl, dist)
                
                -- Dòng 2: Máu màu xanh lá đi kèm Năng lượng màu xanh biển bên cạnh
                local line2 = string.format('<font color="rgb(0, 255, 0)">[%d/%d]</font> <font color="rgb(0, 150, 255)">[%d/%d]</font>', health, maxHealth, energy, maxEnergy)

                textLabel.Text = line1 .. "\n" .. line2
                
                task.wait(0.3)
            end
        end)

        billboard.Parent = player.Character
    end
end

local function RemoveESP(player)
    if player.Character then
        if player.Character:FindFirstChild("CustomESP_Highlight") then
            player.Character.CustomESP_Highlight:Destroy()
        end
        if player.Character:FindFirstChild("CustomESP_Tag") then
            player.Character.CustomESP_Tag:Destroy()
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function(char)
            task.wait(1)
            if PlayerEsp then CreateESP(player) end
        end)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        task.wait(1)
        if PlayerEsp then CreateESP(player) end
    end)
end)

ESP:AddToggle({
    Name = "Player ESP",
    Description = "Show player info with health and energy",
    Default = false,
    Callback = function(value)
        PlayerEsp = value
        pcall(function() writefile(ESP_SAVE_FILE, tostring(value)) end)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if value then CreateESP(player) else RemoveESP(player) end
            end
        end
    end
})



ESP:AddToggle({
    Name = "Chest ESP",
    Description = "Hiển thị chuẩn xác từng loại rương, không bị lặp ESP",
    Default = false,
    Callback = function(Value)
        getgenv().ChestEsp = Value
        
        if getgenv().ChestEsp then
            coroutine.wrap(function()
                local Players = game:GetService("Players")
                local Workspace = game:GetService("Workspace")
                local RunService = game:GetService("RunService")
                local LocalPlayer = Players.LocalPlayer
                local ActiveChestESP = {}

                local function AddChestESP(chestModel)
                    -- Chỉ nhận diện Model hoặc Part chính của rương và chống trùng lặp
                    if not chestModel or not chestModel:IsA("Model") then return end
                    if ActiveChestESP[chestModel] then return end
                    if chestModel:FindFirstChild("ChestESP_UI") then return end

                    local targetPart = chestModel.PrimaryPart or chestModel:FindFirstChild("HumanoidRootPart") or chestModel:FindFirstChildWhichIsA("BasePart")
                    if not targetPart then return end

                    local chestName = chestModel.Name
                    local chestNameLower = chestName:lower()

                    -- Phân loại rương chuẩn xác
                    local displayName = "Chest 1"
                    local nameColor = Color3.fromRGB(255, 255, 255) -- Trắng (Chest 1)

                    if string.find(chestNameLower, "gold") or string.find(chestNameLower, "golden") or chestName == "Chest2" then
                        displayName = "Chest 2"
                        nameColor = Color3.fromRGB(255, 220, 0) -- Vàng (Chest 2)
                    elseif string.find(chestNameLower, "diamond") or chestName == "Chest3" then
                        displayName = "Chest 3"
                        nameColor = Color3.fromRGB(0, 190, 255) -- Xanh biển (Chest 3)
                    elseif string.find(chestNameLower, "mythical") or string.find(chestNameLower, "f") or chestName == "Chest4" then
                        displayName = "Chest 4"
                        nameColor = Color3.fromRGB(255, 100, 100) -- Đỏ hồng (Chest 4)
                    end

                    -- Kiểm tra vật phẩm đặc biệt (Key / Chén thánh)
                    local hasSpecialItem = false
                    if string.find(chestNameLower, "fist") or string.find(chestNameLower, "chalice") or string.find(chestNameLower, "god") then
                        hasSpecialItem = true
                    end

                    -- Tạo BillboardGui
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ChestESP_UI"
                    billboard.AlwaysOnTop = true
                    billboard.Size = UDim2.new(0, 220, 0, 80)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)

                    -- 1. Tên Rương
                    local nameLabel = Instance.new("TextLabel", billboard)
                    nameLabel.Size = UDim2.new(0, 220, 0, 20)
                    nameLabel.Position = UDim2.new(0, 0, 0, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextColor3 = nameColor
                    nameLabel.TextStrokeTransparency = 0.2
                    nameLabel.TextSize = 14
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
                    nameLabel.Text = "👑 " .. displayName

                    -- 2. Khoảng cách - Màu đỏ
                    local distLabel = Instance.new("TextLabel", billboard)
                    distLabel.Size = UDim2.new(0, 220, 0, 20)
                    distLabel.Position = UDim2.new(0, 0, 0, 20)
                    distLabel.BackgroundTransparency = 1
                    distLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    distLabel.TextStrokeTransparency = 0.2
                    distLabel.TextSize = 13
                    distLabel.Font = Enum.Font.GothamBold
                    distLabel.TextXAlignment = Enum.TextXAlignment.Center

                    -- 3. Vật phẩm đặc biệt (Cầu vồng ở dưới cùng)
                    local specialLabel = nil
                    if hasSpecialItem then
                        specialLabel = Instance.new("TextLabel", billboard)
                        specialLabel.Size = UDim2.new(0, 220, 0, 20)
                        specialLabel.Position = UDim2.new(0, 0, 0, 40)
                        specialLabel.BackgroundTransparency = 1
                        specialLabel.TextStrokeTransparency = 0.2
                        specialLabel.TextSize = 12
                        specialLabel.Font = Enum.Font.GothamBold
                        specialLabel.TextXAlignment = Enum.TextXAlignment.Center
                        specialLabel.Text = "⚡ Rare Item Drop"
                    end

                    billboard.Adornee = targetPart
                    billboard.Parent = targetPart

                    -- Cập nhật realtime khoảng cách và hiệu ứng cầu vồng
                    local connection
                    local hue = 0
                    connection = RunService.RenderStepped:Connect(function(dt)
                        if not chestModel or not chestModel.Parent or not targetPart then
                            if billboard then billboard:Destroy() end
                            if connection then connection:Disconnect() end
                            ActiveChestESP[chestModel] = nil
                            return
                        end
                        
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude
                            distLabel.Text = math.floor(dist) .. " studs"
                        end

                        if hasSpecialItem and specialLabel then
                            hue = (hue + dt * 0.5) % 1
                            specialLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
                        end
                    end)

                    ActiveChestESP[chestModel] = {
                        Billboard = billboard,
                        Connection = connection
                    }
                end

                -- Chỉ quét các Model rương trong Workspace để tránh bị trùng lặp linh kiện bên trong
                local function ScanChests(parent)
                    for _, obj in ipairs(parent:GetChildren()) do
                        if obj:IsA("Model") and string.find(obj.Name:lower(), "chest") then
                            AddChestESP(obj)
                        end
                        -- Quét sâu hơn nếu rương nằm trong các folder con
                        if #obj:GetChildren() > 0 and obj ~= Workspace then
                            pcall(function()
                                for _, subObj in ipairs(obj:GetChildren()) do
                                    if subObj:IsA("Model") and string.find(subObj.Name:lower(), "chest") then
                                        AddChestESP(subObj)
                                    end
                                end
                            end)
                        end
                    end
                end

                ScanChests(Workspace)

                -- Lắng nghe rương mới xuất hiện
                local descConn = Workspace.ChildAdded:Connect(function(child)
                    if child:IsA("Model") and string.find(child.Name:lower(), "chest") then
                        task.wait(0.5)
                        AddChestESP(child)
                    end
                end)

                while getgenv().ChestEsp do
                    task.wait(1)
                end

                descConn:Disconnect()

                -- Dọn dẹp khi tắt
                for _, data in pairs(ActiveChestESP) do
                    if data.Billboard then data.Billboard:Destroy() end
                    if data.Connection then data.Connection:Disconnect() end
                end
                ActiveChestESP = {}
            end)()
        end
    end
})



ESP:AddToggle({

    Name = "Fruit ESP",

    Description = "Show devil fruit locations",

    Default = false,

    Callback = function(value)

        DevilFruitESP = value

        while DevilFruitESP do 

            wait()

            pcall(function()

                for i,v in next, workspace:GetChildren() do

                    if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then

                        if not v.Handle:FindFirstChild('NameEsp'..Number) then

                            local bill = Instance.new('BillboardGui', v.Handle)

                            bill.Name = 'NameEsp'..Number

                            bill.ExtentsOffset = Vector3.new(0, 1, 0)

                            bill.Size = UDim2.new(1, 200, 1, 30)

                            bill.Adornee = v.Handle

                            bill.AlwaysOnTop = true

                            

                            local name = Instance.new('TextLabel', bill)

                            name.Font = Enum.Font.Code

                            name.TextSize = 14

                            name.TextWrapped = true

                            name.Size = UDim2.new(1, 0, 1, 0)

                            name.TextYAlignment = 'Top'

                            name.BackgroundTransparency = 1

                            name.TextStrokeTransparency = 0.5

                            name.TextColor3 = Color3.fromRGB(50, 205, 50)  -- Màu XANH LÁ

                            name.Text = (v.Name .. ' \n' .. round((game.Players.LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' M')

                        else

                            v.Handle['NameEsp'..Number].TextLabel.Text = (

                                '[' .. v.Name .. '] \n' .. 

                                round((game.Players.LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. ' M'

                            )

                        end

                    end

                end

            end)

        end

    end

})



ESP:AddToggle({
    Name = "Boss ESP",
    Description = "Show Boss ESP with All Drop Items, Rates, Level, Avatar and HP",
    Default = false,
    Callback = function(Value)
        getgenv().EspBoss = Value
        
        if getgenv().EspBoss then
            coroutine.wrap(function()
                local Players = game:GetService("Players")
                local Workspace = game:GetService("Workspace")
                local LocalPlayer = Players.LocalPlayer
                local EnemiesFolder = Workspace:FindFirstChild("Enemies")
                
                -- Bảng dữ liệu có kèm tỷ lệ riêng cho từng vật phẩm nối đuôi
                local BossData = {
                    ["Awakened Ice Admiral"] = { 
                        Level = 1400, 
                        Drops = "Rengoku (Weapon) [5%] / Library Key (Key) [100%]", 
                        ImageId = 6031238663 
                    },
                    ["Cursed Captain"] = { 
                        Level = 1325, 
                        Drops = "Hellfire Torch (Item) [5%] / Ghoul Outfit (Outfit) [2%]", 
                        ImageId = 6031238663 
                    },
                    ["Darkbeard"] = { 
                        Level = 1000, 
                        Drops = "Dark Coat (Accessory) [2%] / Fist of Darkness (Key) [100%]", 
                        ImageId = 6031238663 
                    },
                    ["rip_indra"] = { 
                        Level = 5000, 
                        Drops = "Dark Blade (Weapon) [100%] / Valkyrie Helm (Accessory) [100%]", 
                        ImageId = 6031238663 
                    },
                    ["Rip_Indra"] = { 
                        Level = 5000, 
                        Drops = "Dark Blade (Weapon) [100%] / Valkyrie Helm (Accessory) [100%]", 
                        ImageId = 6031238663 
                    },
                    ["The Gorilla King"] = { Level = 20, Drops = "Gorilla Crown (Accessory) [5%]", ImageId = 6031238663 },
                    ["Bobby"] = { Level = 55, Drops = "Colorful Spikey Coat (Accessory) [5%]", ImageId = 6031238663 },
                    ["Yeti"] = { Level = 110, Drops = "Ghoul Mask (Accessory) [10%]", ImageId = 6031238663 },
                    ["Mob Leader"] = { Level = 120, Drops = "Iron Mace (Weapon) [5%]", ImageId = 6031238663 },
                    ["Chief Warden"] = { Level = 230, Drops = "Gravity Cane (Weapon) [5%]", ImageId = 6031238663 },
                    ["Swan"] = { Level = 240, Drops = "Swan Glasses (Accessory) [2.5%]", ImageId = 6031238663 },
                    ["Smoke Admiral"] = { Level = 350, Drops = "Jitte (Weapon) [5%]", ImageId = 6031238663 },
                    ["Tide Keeper"] = { Level = 1475, Drops = "Shark Anchor / Trident (Weapon) [5%]", ImageId = 6031238663 },
                    ["Don Swan"] = { Level = 1000, Drops = "Swan Glasses (Accessory) [2.5%]", ImageId = 6031238663 },
                    ["Order"] = { Level = 1250, Drops = "Fist of Darkness (Key) [5%]", ImageId = 6031238663 },
                    ["Diamond"] = { Level = 750, Drops = "Longsword (Weapon) [5%]", ImageId = 6031238663 },
                    ["Jeremy"] = { Level = 850, Drops = "Cannon (Weapon) [5%]", ImageId = 6031238663 },
                    ["Fajita"] = { Level = 925, Drops = "Gravity Cane (Weapon) [5%]", ImageId = 6031238663 },
                    ["Tyrant of the Skies"] = { Level = 2500, Drops = "Feathered Visage (Accessory) [100%]", ImageId = 6031238663 },
                    ["Stone"] = { Level = 1550, Drops = "Dragon Trident (Weapon) [5%]", ImageId = 6031238663 },
                    ["Island Empress"] = { Level = 1675, Drops = "Buddy Sword (Weapon) [5%]", ImageId = 6031238663 },
                    ["Kilo Admiral"] = { Level = 1750, Drops = "Bizarre Rifle (Weapon) [5%]", ImageId = 6031238663 },
                    ["Captain Elephant"] = { Level = 1875, Drops = "Canvas Helmet (Accessory) [5%]", ImageId = 6031238663 },
                    ["Beautiful Pirate"] = { Level = 1950, Drops = "Buddy Sword (Weapon) [5%]", ImageId = 6031238663 },
                    ["Cake Queen"] = { Level = 2175, Drops = "Palace Regalia (Accessory) [5%]", ImageId = 6031238663 },
                    ["Dough King"] = { Level = 2300, Drops = "Mirror Fractal (Key) [100%]", ImageId = 6031238663 },
                    ["Soul Reaper"] = { Level = 2100, Drops = "Hallow Scythe (Weapon) [5%]", ImageId = 6031238663 },
                    ["Cake Prince"] = { Level = 2300, Drops = "Mirror Fractal (Key) [100%]", ImageId = 6031238663 }
                }

                local DefaultAvatar = "rbxassetid://6031238663"
                local ActiveBossESP = {}

                local function AddESPToBoss(enemy)
                    if not enemy or not enemy:FindFirstChild("HumanoidRootPart") or not enemy:FindFirstChild("Humanoid") then return end
                    if ActiveBossESP[enemy] then return end

                    local humanoid = enemy.Humanoid
                    local rootPart = enemy.HumanoidRootPart
                    local bossName = enemy.Name

                    local info = BossData[bossName]
                    local isBoss = info or (humanoid.MaxHealth > 20000)

                    if isBoss then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "BossESP_UI"
                        billboard.AlwaysOnTop = true
                        billboard.Size = UDim2.new(0, 400, 0, 95)
                        billboard.StudsOffset = Vector3.new(0, 4, 0)

                        -- 1. Avatar bên trái
                        local avatarLabel = Instance.new("ImageLabel", billboard)
                        avatarLabel.Name = "BossAvatar"
                        avatarLabel.Size = UDim2.new(0, 36, 0, 36)
                        avatarLabel.Position = UDim2.new(0, 0, 0, 0)
                        avatarLabel.BackgroundTransparency = 1
                        avatarLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        avatarLabel.Image = (info and info.ImageId and info.ImageId ~= 0) and ("rbxassetid://" .. info.ImageId) or DefaultAvatar

                        -- 2. Tên Boss
                        local nameLabel = Instance.new("TextLabel", billboard)
                        nameLabel.Size = UDim2.new(0, 350, 0, 20)
                        nameLabel.Position = UDim2.new(0, 42, 0, 0)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        nameLabel.TextStrokeTransparency = 0.2
                        nameLabel.TextSize = 15
                        nameLabel.Font = Enum.Font.GothamBold
                        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                        nameLabel.Text = bossName

                        -- 3. Máu Boss
                        local hpLabel = Instance.new("TextLabel", billboard)
                        hpLabel.Name = "HPLabel"
                        hpLabel.Size = UDim2.new(0, 350, 0, 18)
                        hpLabel.Position = UDim2.new(0, 42, 0, 20)
                        hpLabel.BackgroundTransparency = 1
                        hpLabel.TextColor3 = Color3.fromRGB(255, 220, 0)
                        hpLabel.TextStrokeTransparency = 0.2
                        hpLabel.TextSize = 13
                        hpLabel.Font = Enum.Font.GothamBold
                        hpLabel.TextXAlignment = Enum.TextXAlignment.Left
                        hpLabel.Text = "HP: " .. math.floor(humanoid.Health) .. " / " .. math.floor(humanoid.MaxHealth)

                        -- 4. Level Boss
                        local levelLabel = Instance.new("TextLabel", billboard)
                        levelLabel.Size = UDim2.new(0, 350, 0, 18)
                        levelLabel.Position = UDim2.new(0, 42, 0, 40)
                        levelLabel.BackgroundTransparency = 1
                        levelLabel.TextColor3 = Color3.fromRGB(0, 190, 255)
                        levelLabel.TextStrokeTransparency = 0.2
                        levelLabel.TextSize = 13
                        levelLabel.Font = Enum.Font.GothamBold
                        levelLabel.TextXAlignment = Enum.TextXAlignment.Left
                        
                        if info and info.Level then
                            levelLabel.Text = "Level: " .. info.Level
                        else
                            levelLabel.Text = "Level: Boss"
                        end

                        -- 5. Drop Items nối đuôi kèm tỷ lệ từng món
                        local dropLabel = Instance.new("TextLabel", billboard)
                        dropLabel.Size = UDim2.new(0, 380, 0, 20)
                        dropLabel.Position = UDim2.new(0, 0, 0, 64)
                        dropLabel.BackgroundTransparency = 1
                        dropLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
                        dropLabel.TextStrokeTransparency = 0.2
                        dropLabel.TextSize = 12
                        dropLabel.Font = Enum.Font.GothamBold
                        dropLabel.TextXAlignment = Enum.TextXAlignment.Left
                        
                        if info and info.Drops then
                            dropLabel.Text = "🎁 Drop: " .. info.Drops
                        else
                            dropLabel.Text = "🎁 Drop: Rare Item [5%]"
                        end

                        billboard.Adornee = rootPart
                        billboard.Parent = Workspace

                        ActiveBossESP[enemy] = {
                            Billboard = billboard,
                            Connection = humanoid.HealthChanged:Connect(function(health)
                                if hpLabel and hpLabel.Parent then
                                    hpLabel.Text = "HP: " .. math.floor(health) .. " / " .. math.floor(humanoid.MaxHealth)
                                end
                            end)
                        }

                        humanoid.Died:Connect(function()
                            if ActiveBossESP[enemy] then
                                if ActiveBossESP[enemy].Billboard then ActiveBossESP[enemy].Billboard:Destroy() end
                                if ActiveBossESP[enemy].Connection then ActiveBossESP[enemy].Connection:Disconnect() end
                                ActiveBossESP[enemy] = nil
                            end
                        end)
                    end
                end

                if EnemiesFolder then
                    for _, enemy in ipairs(EnemiesFolder:GetChildren()) do
                        AddESPToBoss(enemy)
                    end
                    
                    local childAddedConn = EnemiesFolder.ChildAdded:Connect(function(enemy)
                        task.wait(1)
                        AddESPToBoss(enemy)
                    end)

                    while getgenv().EspBoss do
                        task.wait(1)
                    end

                    childAddedConn:Disconnect()
                end

                for _, data in pairs(ActiveBossESP) do
                    if data.Billboard then data.Billboard:Destroy() end
                    if data.Connection then data.Connection:Disconnect() end
                end
                ActiveBossESP = {}
            end)()
        end
    end
})



ESP:AddToggle({
    Name = "Island ESP (Auto Sea)",
    Description = "Automatically show islands based on your current Sea",
    Default = false,
    Callback = function(value)
        IslandESP = value
        
        if IslandESP then
            coroutine.wrap(function()
                local Players = game:GetService("Players")
                local Workspace = game:GetService("Workspace")
                local LocalPlayer = Players.LocalPlayer
                
                -- === TỔNG HỢP DANH SÁCH ĐẢO THEO TỪNG SEA ===
                local Sea1_Islands = {
                    { Name = "Starter Marine", ShortName = "SMARINE", Position = Vector3.new(-2548, 12, 3175), ImageId = 6031238663 },
                    { Name = "Starter Pirate", ShortName = "SPIRATE", Position = Vector3.new(979, 16, 1419), ImageId = 6031238663 },
                    { Name = "Jungle", ShortName = "JUNGLE", Position = Vector3.new(-1249, 11, 345), ImageId = 6031238663 },
                    { Name = "Pirate Village", ShortName = "PIRATE V", Position = Vector3.new(-1143, 4, 3828), ImageId = 6031238663 },
                    { Name = "Desert", ShortName = "DESERT", Position = Vector3.new(895, 6, 4390), ImageId = 6031238663 },
                    { Name = "Snow Island", ShortName = "SNOW", Position = Vector3.new(1205, 87, -1313), ImageId = 6031238663 },
                    { Name = "Marine Ford", ShortName = "MFORD", Position = Vector3.new(-4884, 20, 4323), ImageId = 6031238663 },
                    { Name = "Sky Island 1", ShortName = "SKY 1", Position = Vector3.new(-4848, 717, -2623), ImageId = 6031238663 },
                    { Name = "Prison", ShortName = "PRISON", Position = Vector3.new(4875, 5, 734), ImageId = 6031238663 },
                    { Name = "Colosseum", ShortName = "COLOSSEUM", Position = Vector3.new(-1428, 7, -2901), ImageId = 6031238663 },
                    { Name = "Magma Village", ShortName = "MAGMA", Position = Vector3.new(-5312, 12, 8515), ImageId = 6031238663 },
                    { Name = "Underwater City", ShortName = "UNDERWATER", Position = Vector3.new(6116, 5, -120), ImageId = 6031238663 },
                    { Name = "Fountain City", ShortName = "FOUNTAIN", Position = Vector3.new(5216, 4, 4048), ImageId = 6031238663 },
                }

                local Sea2_Islands = {
                    { Name = "Kingdom of Rose", ShortName = "ROSE", Position = Vector3.new(-417, 72, 1782), ImageId = 6031238663 },
                    { Name = "Café", ShortName = "CAFE", Position = Vector3.new(-382, 77, 176), ImageId = 6031238663 },
                    { Name = "Usoap's Island", ShortName = "USOAP", Position = Vector3.new(465, 21, 2949), ImageId = 6031238663 },
                    { Name = "Graveyard", ShortName = "GRAVEYARD", Position = Vector3.new(-5451, 18, -795), ImageId = 6031238663 },
                    { Name = "Snow Mountain", ShortName = "SNOW MTN", Position = Vector3.new(623, 402, -5429), ImageId = 6031238663 },
                    { Name = "Hot and Cold", ShortName = "HOT&COLD", Position = Vector3.new(-5985, 16, -5077), ImageId = 6031238663 },
                    { Name = "Cursed Ship", ShortName = "SHIP", Position = Vector3.new(923, 125, 32845), ImageId = 6031238663 },
                    { Name = "Ice Castle", ShortName = "ICE CASTLE", Position = Vector3.new(6206, 301, -6685), ImageId = 6031238663 },
                    { Name = "Dark Arena", ShortName = "DARK ARENA", Position = Vector3.new(3780, 14, -3499), ImageId = 6031238663 },
                    { Name = "Forgotten Island", ShortName = "FORGOTTEN", Position = Vector3.new(-3042, 237, -10295), ImageId = 6031238663 },
                }

                local Sea3_Islands = {
                    { Name = "Port Town", ShortName = "PORT", Position = Vector3.new(-290, 43, 5459), ImageId = 6031238663 },
                    { Name = "Hydra Island", ShortName = "HYDRA", Position = Vector3.new(5229, 603, 125), ImageId = 6031238663 },
                    { Name = "Great Tree", ShortName = "TREE", Position = Vector3.new(2330, 47, -6665), ImageId = 6031238663 },
                    { Name = "Floating Turtle", ShortName = "TURTLE", Position = Vector3.new(-12467, 337, -7548), ImageId = 6031238663 },
                    { Name = "Castle on the Sea", ShortName = "CASTLE", Position = Vector3.new(-5043, 315, -3152), ImageId = 6031238663 },
                    { Name = "Haunted Castle", ShortName = "HAUNTED", Position = Vector3.new(-9513, 142, 5529), ImageId = 6031238663 },
                    { Name = "Sea of Treats", ShortName = "TREATS", Position = Vector3.new(-2091, 49, -12124), ImageId = 6031238663 },
                    { Name = "Tiki Outpost", ShortName = "TIKI", Position = Vector3.new(-16239, 9, 442), ImageId = 6031238663 },
                }

                -- Hàm tự nhận diện đang ở Sea nào dựa vào PlaceId của Blox Fruits
                local function GetCurrentSeaIslands()
                    local placeId = game.PlaceId
                    if placeId == 2753915549 then
                        return Sea1_Islands
                    elseif placeId == 4442272183 then
                        return Sea2_Islands
                    elseif placeId == 7449423635 then
                        return Sea3_Islands
                    else
                        -- Dự phòng trường hợp tên PlaceId khác, dựa vào vị trí Café hoặc Port Town để nhận diện
                        return Sea2_Islands -- Mặc định lấy Sea 2 nếu không khớp
                    end
                end

                local Islands = GetCurrentSeaIslands()
                local DefaultImage = "rbxassetid://6031238663"
                local ActiveESP = {}
                
                -- Tạo ESP cho các đảo thuộc Sea hiện tại
                for _, data in ipairs(Islands) do
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "AutoSeaIslandESP"
                    billboard.AlwaysOnTop = true
                    billboard.Size = UDim2.new(0, 320, 0, 60)
                    billboard.StudsOffset = Vector3.new(0, 3.5, 0)

                    -- 1. Icon đảo
                    local imageLabel = Instance.new("ImageLabel", billboard)
                    imageLabel.Name = "IslandIcon"
                    imageLabel.Size = UDim2.new(0, 32, 0, 32)
                    imageLabel.Position = UDim2.new(0, 0, 0, 0)
                    imageLabel.BackgroundTransparency = 1
                    imageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    imageLabel.Image = (data.ImageId and data.ImageId ~= 0) and ("rbxassetid://" .. data.ImageId) or DefaultImage

                    -- 2. Tên đầy đủ (Màu trắng, font GothamBold)
                    local nameLabel = Instance.new("TextLabel", billboard)
                    nameLabel.Name = "FullName"
                    nameLabel.Size = UDim2.new(0, 250, 0, 24)
                    nameLabel.Position = UDim2.new(0, 38, 0, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.TextStrokeTransparency = 0.2
                    nameLabel.TextSize = 16
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                    nameLabel.Text = data.Name

                    -- 3. Tên viết tắt (Màu vàng)
                    local shortLabel = Instance.new("TextLabel", billboard)
                    shortLabel.Name = "ShortName"
                    shortLabel.Size = UDim2.new(0, 100, 0, 20)
                    shortLabel.Position = UDim2.new(0, 38, 0, 26)
                    shortLabel.BackgroundTransparency = 1
                    shortLabel.TextColor3 = Color3.fromRGB(255, 220, 0)
                    shortLabel.TextStrokeTransparency = 0.2
                    shortLabel.TextSize = 13
                    shortLabel.Font = Enum.Font.GothamBold
                    shortLabel.TextXAlignment = Enum.TextXAlignment.Left
                    shortLabel.Text = "[" .. data.ShortName .. "]"

                    -- 4. Khoảng cách (Màu xanh dương)
                    local distLabel = Instance.new("TextLabel", billboard)
                    distLabel.Name = "Distance"
                    distLabel.Size = UDim2.new(0, 100, 0, 20)
                    distLabel.Position = UDim2.new(0, 130, 0, 26)
                    distLabel.BackgroundTransparency = 1
                    distLabel.TextColor3 = Color3.fromRGB(0, 190, 255)
                    distLabel.TextStrokeTransparency = 0.2
                    distLabel.TextSize = 13
                    distLabel.Font = Enum.Font.GothamBold
                    distLabel.TextXAlignment = Enum.TextXAlignment.Left
                    distLabel.Text = "[0m]"

                    -- Part ẩn định vị
                    local part = Instance.new("Part")
                    part.Name = "IslandMarker"
                    part.Size = Vector3.new(1, 1, 1)
                    part.Position = data.Position
                    part.Anchored = true
                    part.Transparency = 1
                    part.CanCollide = false
                    part.Parent = Workspace

                    billboard.Adornee = part
                    billboard.Parent = Workspace
                    
                    table.insert(ActiveESP, { Billboard = billboard, Part = part })
                end
                
                -- Vòng lặp cập nhật khoảng cách
                while IslandESP do
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local hrpPos = LocalPlayer.Character.HumanoidRootPart.Position
                        for i, data in ipairs(Islands) do
                            if ActiveESP[i] and ActiveESP[i].Billboard then
                                local dist = math.floor((data.Position - hrpPos).Magnitude)
                                local bb = ActiveESP[i].Billboard
                                local distLabel = bb:FindFirstChild("Distance")
                                if distLabel then
                                    distLabel.Text = "[" .. dist .. "m]"
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
                
                -- Dọn dẹp khi tắt
                for _, esp in ipairs(ActiveESP) do
                    if esp.Billboard then esp.Billboard:Destroy() end
                    if esp.Part then esp.Part:Destroy() end
                end
            end)()
        end
    end
})



ESP:AddToggle({

    Name = "Flower ESP",

    Description = "Show blue and red flower locations",

    Default = false,

    Callback = function(value)

        FlowerESP = value

        while FlowerESP do 

            wait()

            pcall(function()

                for i,v in pairs(workspace:GetChildren()) do

                    if v.Name == "Flower2" or v.Name == "Flower1" then

                        if not v:FindFirstChild('NameEsp'..Number) then

                            local bill = Instance.new('BillboardGui', v)

                            bill.Name = 'NameEsp'..Number

                            bill.ExtentsOffset = Vector3.new(0, 1, 0)

                            bill.Size = UDim2.new(1, 200, 1, 30)

                            bill.Adornee = v

                            bill.AlwaysOnTop = true

                            

                            local name = Instance.new('TextLabel', bill)

                            name.Font = Enum.Font.Code

                            name.TextSize = 14

                            name.TextWrapped = true

                            name.Size = UDim2.new(1, 0, 1, 0)

                            name.TextYAlignment = 'Top'

                            name.BackgroundTransparency = 1

                            name.TextStrokeTransparency = 0.5

                            name.TextColor3 = Color3.fromRGB(255, 105, 180)  -- Màu HỒNG

                            

                            if v.Name == "Flower1" then

                                name.Text = ("Blue Flower" .. ' \n' .. round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' M')

                            elseif v.Name == "Flower2" then

                                name.Text = ("Red Flower" .. ' \n' .. round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' M')

                            end

                        else

                            v['NameEsp'..Number].TextLabel.Text = (v.Name .. '   \n' .. round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. ' M')

                        end

                    end

                end

            end)

        end

    end

})



ESP:AddToggle({

    Name = "Legendary Sword Dealer ESP",

    Description = "Show legendary sword dealer location",

    Default = false,

    Callback = function(value)

        LegenS = value

        while LegenS do 

            wait()

            pcall(function()

                for _,v in pairs(replicated.NPCs:GetChildren()) do

                    if v.Name == "Legendary Sword Dealer " then

                        if not workspace:FindFirstChild("Lgd") then

                            Lgd = Instance.new("Part")

                            Lgd.Name = "Lgd"

                            Lgd.Transparency = 1

                            Lgd.Size = Vector3.new(1, 1, 1)

                            Lgd.Anchored = true

                            Lgd.CanCollide = false

                            Lgd.Parent = workspace

                            Lgd.CFrame = v.HumanoidRootPart.CFrame

                        elseif workspace:FindFirstChild("Lgd") then

                            if not Lgd:FindFirstChild("NameEsp") then

                                local bill = Instance.new("BillboardGui", Lgd)

                                bill.Name = "NameEsp"

                                bill.ExtentsOffset = Vector3.new(0, 1, 0)

                                bill.Size = UDim2.new(1, 200, 1, 30)

                                bill.Adornee = Lgd

                                bill.AlwaysOnTop = true

                                

                                local name = Instance.new("TextLabel", bill)

                                name.Font = "Code"

                                name.TextSize = 14

                                name.TextWrapped = true

                                name.Size = UDim2.new(1, 0, 1, 0)

                                name.TextYAlignment = "Top"

                                name.BackgroundTransparency = 1

                                name.TextStrokeTransparency = 0.5

                                name.TextColor3 = Color3.fromRGB(255, 105, 180)  -- Màu HỒNG

                                name.Text = (v.Name .. "   \n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude / 3) .. " M")

                            else

                                Lgd["NameEsp"].TextLabel.Text = (v.Name .. "   \n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude / 3) .. " M")

                            end

                        end

                    end

                end

            end)

        end

    end

})



ESP:AddToggle({

    Name = "Aura Color Dealer ESP",

    Description = "Show Barista Cousin location",

    Default = false,

    Callback = function(value)

        ColorEsp = value

        while ColorEsp do 

            wait()

            pcall(function()

                for _,v in pairs(replicated.NPCs:GetChildren()) do

                    if v.Name == "Barista Cousin" then

                        if not workspace:FindFirstChild("Gay") then

                            Gay = Instance.new("Part")

                            Gay.Name = "Gay"

                            Gay.Transparency = 1

                            Gay.Size = Vector3.new(1, 1, 1)

                            Gay.Anchored = true

                            Gay.CanCollide = false

                            Gay.Parent = workspace

                            Gay.CFrame = v.HumanoidRootPart.CFrame

                        elseif workspace:FindFirstChild("Gay") then

                            if not Gay:FindFirstChild("NameEsp") then

                                local bill = Instance.new("BillboardGui", Gay)

                                bill.Name = "NameEsp"

                                bill.ExtentsOffset = Vector3.new(0, 1, 0)

                                bill.Size = UDim2.new(1, 200, 1, 30)

                                bill.Adornee = Gay

                                bill.AlwaysOnTop = true

                                

                                local name = Instance.new("TextLabel", bill)

                                name.Font = "Code"

                                name.TextSize = 14

                                name.TextWrapped = true

                                name.Size = UDim2.new(1, 0, 1, 0)

                                name.TextYAlignment = "Top"

                                name.BackgroundTransparency = 1

                                name.TextStrokeTransparency = 0.5

                                name.TextColor3 = Color3.fromRGB(30, 144, 255)  -- Màu XANH DƯƠNG

                                name.Text = (v.Name .. "   \n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude / 3) .. " M")

                            else

                                Gay["NameEsp"].TextLabel.Text = (v.Name .. "   \n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude / 3) .. " M")

                            end

                        end

                    end

                end

            end)

        end

    end

})



ESP:AddToggle({

    Name = "Gear ESP",

    Description = "Show gear parts on MysticIsland",

    Default = false,

    Callback = function(value)

        ESPGear = value

        while ESPGear do 

            wait()

            pcall(function()

                if workspace.Map:FindFirstChild("MysticIsland") then

                    for _,v in pairs(workspace.Map.MysticIsland:GetDescendants()) do

                        if v.Name == "Part" and v.Material == Enum.Material.Neon then

                            if not v:FindFirstChild("NameEsp") then

                                local bill = Instance.new("BillboardGui", v)

                                bill.Name = "NameEsp"

                                bill.ExtentsOffset = Vector3.new(0, 1, 0)

                                bill.Size = UDim2.new(1, 200, 1, 30)

                                bill.Adornee = v

                                bill.AlwaysOnTop = true

                                

                                local name = Instance.new("TextLabel", bill)

                                name.Font = "Code"

                                name.TextSize = 14

                                name.TextWrapped = true

                                name.Size = UDim2.new(1, 0, 1, 0)

                                name.TextYAlignment = "Top"

                                name.BackgroundTransparency = 1

                                name.TextStrokeTransparency = 0.5

                                name.TextColor3 = Color3.fromRGB(30, 144, 255)  -- Màu XANH DƯƠNG

                                name.Text = ("Gear" .. "   \n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. " M")

                            else

                                v["NameEsp"].TextLabel.Text = ("Gear" .. "   \n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. " M")

                            end

                        end

                    end

                end

            end)

        end

    end

})



ESP:AddToggle({

    Name = "Sea Event Island ESP",

    Description = "Show event islands (Mirage, Prehistoric, Kitsune)",

    Default = false,

    Callback = function(value)

        EspEventIsland = value

        while EspEventIsland do 

            wait()

            pcall(function()

                for i, v in pairs(workspace._WorldOrigin.Locations:GetChildren()) do

                    if (v.Name == "Mirage Island" or v.Name == "Prehistoric Island" or v.Name == "Kitsune Island") then

                        if not v:FindFirstChild("NameEsp") then

                            local bill = Instance.new("BillboardGui", v)

                            bill.Name = "NameEsp"

                            bill.ExtentsOffset = Vector3.new(0, 1, 0)

                            bill.Size = UDim2.new(1, 200, 1, 30)

                            bill.Adornee = v

                            bill.AlwaysOnTop = true

                            

                            local name = Instance.new("TextLabel", bill)

                            name.Font = "Code"

                            name.TextSize = 14

                            name.TextWrapped = true

                            name.Size = UDim2.new(1, 0, 1, 0)

                            name.TextYAlignment = "Top"

                            name.BackgroundTransparency = 1

                            name.TextStrokeTransparency = 0.5

                            name.TextColor3 = Color3.fromRGB(255, 140, 0)  -- Màu CAM

                            name.Text = (v.Name .. "   \n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. " M")

                        else

                            v.NameEsp.TextLabel.Text = (v.Name .. "   \n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. " M")

                        end

                    end

                end

            end)

        end

    end

})



ESP:AddToggle({

    Name = "Advanced Fruit Dealer ESP",

    Description = "Show advanced fruit dealer location",

    Default = false,

    Callback = function(value)

        advanEsp = value

        while advanEsp do 

            wait()

            pcall(function()

                for _,v in pairs(replicated.NPCs:GetChildren()) do

                    if v.Name == "Advanced Fruit Dealer" then

                        if not workspace:FindFirstChild("Adv") then

                            Adv = Instance.new("Part")

                            Adv.Name = "Adv"

                            Adv.Transparency = 1

                            Adv.Size = Vector3.new(1, 1, 1)

                            Adv.Anchored = true

                            Adv.CanCollide = false

                            Adv.Parent = workspace

                            Adv.CFrame = v.HumanoidRootPart.CFrame

                        elseif workspace:FindFirstChild("Adv") then

                            if not Adv:FindFirstChild("NameEsp") then

                                local bill = Instance.new("BillboardGui", Adv)

                                bill.Name = "NameEsp"

                                bill.ExtentsOffset = Vector3.new(0, 1, 0)

                                bill.Size = UDim2.new(1, 200, 1, 30)

                                bill.Adornee = Adv

                                bill.AlwaysOnTop = true

                                

                                local name = Instance.new("TextLabel", bill)

                                name.Font = "Code"

                                name.TextSize = 14

                                name.TextWrapped = true

                                name.Size = UDim2.new(1, 0, 1, 0)

                                name.TextYAlignment = "Top"

                                name.BackgroundTransparency = 1

                                name.TextStrokeTransparency = 0.5

                                name.TextColor3 = Color3.fromRGB(50, 205, 50)  -- Màu XANH LÁ

                                name.Text = (v.Name .. "   \n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude / 3) .. " M")

                            else

                                Adv["NameEsp"].TextLabel.Text = (v.Name .. "   \n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude / 3) .. " M")

                            end

                        end

                    end

                end

            end)

        end

    end

})



ESP:AddToggle({

    Name = "Berry ESP",

    Description = "Show berry bush locations",

    Default = false,

    Callback = function(value)

        BerryEsp = value

        while BerryEsp do 

            wait()

            pcall(function()

                local CollectionService = game:GetService("CollectionService")

                local Player = game.Players.LocalPlayer

                local BerryBushes = CollectionService:GetTagged("BerryBush")

                

                for _, Bush in ipairs(BerryBushes) do

                    local bushPosition = Bush.Parent:GetPivot().Position

                    

                    for _, BerryName in pairs(Bush:GetAttributes()) do

                        if BerryName then

                            local espPartName = "BerryEspPart_" .. BerryName .. "_" .. tostring(bushPosition)

                            local existingEsp = workspace:FindFirstChild(espPartName)

                            

                            if not existingEsp then

                                existingEsp = Instance.new("Part")

                                existingEsp.Name = espPartName

                                existingEsp.Transparency = 1

                                existingEsp.Size = Vector3.new(1, 1, 1)

                                existingEsp.Anchored = true

                                existingEsp.CanCollide = false

                                existingEsp.Parent = workspace

                                existingEsp.CFrame = CFrame.new(bushPosition)

                            end

                            

                            if not existingEsp:FindFirstChild("NameEsp") then

                                local nameEsp = Instance.new("BillboardGui", existingEsp)

                                nameEsp.Name = "NameEsp"

                                nameEsp.ExtentsOffset = Vector3.new(0, 1, 0)

                                nameEsp.Size = UDim2.new(0, 200, 0, 30)

                                nameEsp.Adornee = existingEsp

                                nameEsp.AlwaysOnTop = true

                                

                                local nameLabel = Instance.new("TextLabel", nameEsp)

                                nameLabel.Font = Enum.Font.Code

                                nameLabel.TextSize = 14

                                nameLabel.TextWrapped = true

                                nameLabel.Size = UDim2.new(1, 0, 1, 0)

                                nameLabel.TextYAlignment = Enum.TextYAlignment.Top

                                nameLabel.BackgroundTransparency = 1

                                nameLabel.TextStrokeTransparency = 0.5

                                nameLabel.TextColor3 = Color3.fromRGB(255, 69, 0)  -- Màu ĐỎ CAM

                                nameLabel.Parent = nameEsp

                            end

                            

                            local nameEsp = existingEsp:FindFirstChild("NameEsp")

                            if nameEsp then

                                local distance = (Player.Character.Head.Position - bushPosition).Magnitude / 3

                                nameEsp.TextLabel.Text = ('[' .. BerryName .. ']' .. " " .. math.round(distance) .. " M")

                            end

                        end

                    end

                end

            end)

        end

    end

})


ESP:AddSection("Visual")



ESP:AddToggle({
    Name = "Auta Rain Fruits",
    Default = false,
    Callback = function(Value)
        getgenv().TripleQuest = Value
        
        -- Kiểm tra nếu bật toggle thì mới chạy hiệu ứng mưa trái cây
        if Value then
            pcall(function()
                local assets = game:GetObjects("rbxassetid://14759368201")
                if assets and assets[1] then
                    for _, i in pairs(assets[1]:GetChildren()) do
                        i.Parent = game.Workspace.Map
                        local char = game.Players.LocalPlayer.Character
                        if char and char.PrimaryPart then
                            i:MoveTo(char.PrimaryPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))
                        end
                        
                        local fruit = i:FindFirstChild("Fruit")
                        if fruit then
                            local animController = fruit:FindFirstChild("AnimationController")
                            local idleAnim = fruit:FindFirstChild("Idle")
                            if animController and idleAnim then
                                pcall(function()
                                    animController:LoadAnimation(idleAnim):Play()
                                end)
                            end
                        end
                        
                        local handle = i:FindFirstChild("Handle")
                        if handle then
                            handle.Touched:Connect(function(cR)
                                if cR.Parent == game.Players.LocalPlayer.Character then
                                    i.Parent = game.Players.LocalPlayer.Backpack
                                    local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                    if humanoid then
                                        humanoid:EquipTool(i)
                                    end
                                end
                            end)
                        end
                    end
                end
            end)
        end
    end
})



ESP:AddButton({
    Name = "The Ball That Attracts Everything",
    Description = "",
    Callback = function() 
        local RS   = game:GetService("ReplicatedStorage")
        local plr  = game.Players.LocalPlayer
        local char = plr.Character or plr.CharacterAdded:Wait()
        local hrp  = char:WaitForChild("HumanoidRootPart")

        -- Gọi hiệu ứng chuẩn từ đường dẫn ReplicatedStorage
        pcall(function()
            require(RS.Effect.Container.tensei)({
                char     = char,
                target   = char,
                targetCF = hrp.CFrame * CFrame.new(0, 67, 0),
                max      = math.huge,
            })
        end)
    end
})



ESP:AddButton({
    Name = "Meteorite Fall",
    Description = "",
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

        pcall(function()
            require(game.ReplicatedStorage.Effect.Container.Gravity.V)({
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
        end)

        task.delay(15, function() 
            if h then h:Destroy() end 
        end)
    end
})



ESP:AddButton({
    Name = "View Leviathan Bikini",
    Description = "",
    Callback = function() 
        local Players = game:GetService("Players")
        local plr     = Players.LocalPlayer
        local char    = plr.Character or plr.CharacterAdded:Wait()
        local hrp     = char:WaitForChild("HumanoidRootPart")
        
        pcall(function()
            local folder  = plr.PlayerScripts:WaitForChild("LeviathanCinematicc")
            local cine    = require(folder.Intro)()
            local offset  = hrp.Position + hrp.CFrame.LookVector * 120

            for _, v in ipairs(workspace:GetChildren()) do
                if v.Name:match("Leviathan") then
                    local root = v:FindFirstChild("RootPart")
                    if root then 
                        v:PivotTo(CFrame.new(offset)) 
                    end
                end
            end

            cine:Play()
            task.delay(14, function() 
                if cine then cine:Destroy() end 
            end)
        end)
    end
})



ESP:AddButton({
    Name = "View Mygame43 Kill Rip Indra",
    Description = "",
    Callback = function() 
        local rs = game:GetService("ReplicatedStorage")
        local cp = game:GetService("ContentProvider")

        task.spawn(function()
            pcall(function()
                cp:PreloadAsync({ rs.Effect.Container.IndraCutscene })
            end)
        end)

        pcall(function()
            require(rs.Effect.Container.IndraCutscene)()
        end)
    end
})



ESP:AddSection("Visual Font")



-- 1. Tự động lấy TOÀN BỘ Font chữ có trong Roblox
local allRobloxFonts = {}
for _, fontEnum in pairs(Enum.Font:GetEnumItems()) do
    table.insert(allRobloxFonts, fontEnum.Name)
end
table.sort(allRobloxFonts) -- Sắp xếp danh sách font theo thứ tự bảng chữ cái A-Z

-- 2. Hàm đổi Font cho toàn bộ UI
local function ChangeAllFonts(parentGui, fontName)
    local targetFont = Enum.Font[fontName]
    if not targetFont then return end

    -- Lặp qua tất cả thành phần chứa chữ để cập nhật Font
    for _, element in pairs(parentGui:GetDescendants()) do
        if element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") then
            element.Font = targetFont
        end
    end
end

-- 3. Thêm Dropdown vào Tab/Section của bạn
ESP:AddDropdown({
    Name = "Select UI Font",
    Default = "GothamBold",
    Options = allRobloxFonts,
    Callback = function(selectedFont)
        local coreGui = game:GetService("CoreGui")
        local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
        
        -- Cập nhật Font cho tất cả giao diện trong CoreGui và PlayerGui
        if coreGui then 
            pcall(function() ChangeAllFonts(coreGui, selectedFont) end) 
        end
        if playerGui then 
            pcall(function() ChangeAllFonts(playerGui, selectedFont) end) 
        end
    end
})



ESP:AddSection("Visual Fast Animation")



_G.NoAni = _G.NoAni or false

local player = game.Players.LocalPlayer
local AnimConnection

function EnableNoAni(char)
    local humanoid = char:WaitForChild('Humanoid')

    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end

    AnimConnection = humanoid.AnimationPlayed:Connect(function(track)
        if _G.NoAni then
            track:Stop()
        end
    end)
end

function DisableNoAni()
    if AnimConnection then
        AnimConnection:Disconnect()
        AnimConnection = nil
    end
end

function SetupChar(char)
    if _G.NoAni then
        EnableNoAni(char)
    end
end

if player.Character then
    SetupChar(player.Character)
end

player.CharacterAdded:Connect(function(char)
    SetupChar(char)
end)

ESP:AddToggle({
    Name = "No Animation",
    Default = false,
    Callback = function(Value)
        getgenv().TripleQuest = Value
        _G.NoAni = Value
        
        -- Nếu có hệ thống SaveData thì cập nhật
        if _G.SaveData then
            _G.SaveData.NoAni_Save = Value
            if type(SaveSettings) == "function" then
                SaveSettings()
            end
        end

        if Value then
            if player.Character then
                EnableNoAni(player.Character)
            end
        else
            DisableNoAni()
        end
    end
})



ESP:AddToggle({
    Name = "No Animation [ V2 ]",
    Default = false,
    Callback = function(Value)
        getgenv().TripleQuest = Value
        getgenv().NoAnimationV2 = Value
        
        -- Khởi tạo Fast Attack khi bật Toggle
        if Value and not getgenv()._FastAttackRunning then
            getgenv()._FastAttackRunning = true
            
            task.spawn(function()
                local Players = game:GetService("Players")
                local VIM = game:GetService("VirtualInputManager")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")

                local LP = Players.LocalPlayer
                getgenv()._FastAttackBackup = getgenv()._FastAttackBackup or {}

                -- config
                local HITBOX = 1000
                local LOOP_DELAY = 0.01

                local function safeRequireWeaponData()
                    local ok, mod = pcall(function()
                        return require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WeaponData"))
                    end)
                    return ok and mod or nil
                end

                local WeaponData = safeRequireWeaponData()

                local function findAttackMelee()
                    if getgenv().attackMelee and typeof(getgenv().attackMelee) == "function" then
                        return getgenv().attackMelee
                    end

                    if typeof(getgc) ~= "function" or typeof(debug) ~= "table" or typeof(debug.getinfo) ~= "function" then
                        return nil
                    end

                    for _, v in next, getgc(true) do
                        if typeof(v) == "function" then
                            local ok, info = pcall(debug.getinfo, v)
                            if ok and info and info.name == "attackMelee" then
                                getgenv().attackMelee = v
                                return v
                            end
                        end
                    end
                    return nil
                end

                local function cacheUpvalueTargets(fn)
                    if getgenv()._FastAttackBackup._uv_cached then return end
                    getgenv()._FastAttackBackup._uv_cached = true
                    getgenv()._FastAttackBackup._uv_idx = {}

                    if typeof(getupvalues) ~= "function" then return end

                    local ok, uvs = pcall(getupvalues, fn)
                    if not ok or type(uvs) ~= "table" then return end

                    for i, v in next, uvs do
                        local t = typeof(v)
                        if t == "number" then
                            if v > 0 and v < 5 then
                                table.insert(getgenv()._FastAttackBackup._uv_idx, {i = i, kind = "number"})
                            end
                        elseif t == "boolean" then
                            if v == true then
                                table.insert(getgenv()._FastAttackBackup._uv_idx, {i = i, kind = "boolean"})
                            end
                        end
                    end
                end

                local function applyFastUpvalues(fn)
                    if typeof(setupvalue) ~= "function" then return end
                    local idxs = getgenv()._FastAttackBackup._uv_idx
                    if type(idxs) ~= "table" then return end

                    for _, it in ipairs(idxs) do
                        if it.kind == "number" then
                            pcall(setupvalue, fn, it.i, 0)
                        elseif it.kind == "boolean" then
                            pcall(setupvalue, fn, it.i, false)
                        end
                    end
                end

                while task.wait(0.2) do
                    local fn = findAttackMelee()
                    if fn then
                        cacheUpvalueTargets(fn)
                        break
                    end
                end

                while getgenv().NoAnimationV2 and task.wait(LOOP_DELAY) do
                    local attackFn = getgenv().attackMelee
                    if typeof(attackFn) ~= "function" then
                        attackFn = findAttackMelee()
                        if typeof(attackFn) ~= "function" then
                            continue
                        end
                    end

                    local char = LP.Character
                    if not char then continue end

                    local tool = char:FindFirstChildOfClass("Tool")
                    if not tool then continue end

                    if not WeaponData then
                        WeaponData = safeRequireWeaponData()
                        if not WeaponData then continue end
                    end

                    local weaponName = tool:GetAttribute("WeaponName")
                    if not weaponName then continue end

                    local w = WeaponData[weaponName]
                    if not w then continue end

                    if getgenv()._FastAttackBackup.Hitbox == nil then
                        getgenv()._FastAttackBackup.Hitbox = w.HitboxMagnitude
                    end

                    applyFastUpvalues(attackFn)
                    w.HitboxMagnitude = HITBOX

                    pcall(function()
                        VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    end)
                    pcall(attackFn)
                end
                getgenv()._FastAttackRunning = false
            end)
        end
    end
})



-- =========================
-- NO ANIMATION LOGIC
-- =========================

_G.NoAni = _G.NoAni or false
local player = game.Players.LocalPlayer
local AnimConnection

local function EnableNoAni(char)
	local humanoid = char:WaitForChild("Humanoid")

	-- stop animation đang chạy
	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end

	-- chặn animation mới
	AnimConnection = humanoid.AnimationPlayed:Connect(function(track)
		if _G.NoAni then
			track:Stop()
		end
	end)
end

local function DisableNoAni()
	if AnimConnection then
		AnimConnection:Disconnect()
		AnimConnection = nil
	end
end

-- Theo dõi nhân vật
local function SetupChar(char)
	if _G.NoAni then
		EnableNoAni(char)
	end
end

if player.Character then
	SetupChar(player.Character)
end

player.CharacterAdded:Connect(SetupChar)

-- =========================
-- TOGGLE UI
-- =========================

ESP:AddToggle({
    Name = "No Fast Animation [ V3 ]",
    Default = false,
    Callback = function(Value)
        getgenv().RAC = Value
        _G.NoAni = Value
        
        -- Cập nhật dữ liệu lưu trữ nếu có hệ thống SaveData
        if _G.SaveData and _G.SaveData["NoAni_Save"] ~= nil then
            _G.SaveData["NoAni_Save"] = Value
            if type(SaveSettings) == "function" then
                SaveSettings()
            end
        end

        if Value then
            if player.Character then
                EnableNoAni(player.Character)
            end
        else
            DisableNoAni()
        end
    end
})



Player:AddSection("Join Server Game")



Player:AddButton({

    Name = "Hop Normal Server",

    Description = "",

    Callback = function() 

        Hop()

    end

})



Player:AddButton({

    Name = "Hop Less Player Server",

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

    end

})



Player:AddButton({

    Name = "Hop Less Ping Server",

    Description = "",

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

    end

})



Player:AddSection("Settings")



-- Biến cấu hình góc xoay toàn cục
local angle = 0
local radius = 15 -- Bán kính vòng tròn (khoảng cách từ nhân vật tới quái)
local orbitSpeed = 8 -- Tốc độ xoay vòng tròn

Player:AddToggle({
      
   Name = "Auto Farm Obito Spin",
    
    Default = false,
   
    Callback = function(Value)
   
        _G.AutoObitoSpin = Value
        
        -- Tự động tắt tính năng khóa vị trí mặc định của Hub nếu có để tránh bị giật về 1 chỗ
        if _G.AutoObitoSpin then
            pcall(function()
                if _G.Settings then
                    _G.Settings.AutoSpinPositionIfFarming = false
                end
            end)
        end
        
        -- Vòng lặp xử lý xoay liên tục khi bật Toggle
        task.spawn(function()
            local RunService = game:GetService("RunService")
            local LocalPlayer = game:GetService("Players").LocalPlayer
            
            while _G.AutoObitoSpin do
                local dt = RunService.RenderStepped:Wait()
                pcall(function()
                    local character = LocalPlayer.Character
                    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                    
                    local rootPart = character.HumanoidRootPart
                    local enemies = workspace:FindFirstChild("Enemies")
                    
                    if enemies then
                        for _, enemy in ipairs(enemies:GetChildren()) do
                            if (string.find(enemy.Name, "Obito") or string.find(enemy.Name, "Masked") or string.find(enemy.Name, "Cookie") or string.find(enemy.Name, "Cake")) 
                               and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 
                               and enemy:FindFirstChild("HumanoidRootPart") then
                                
                                -- Tăng góc theo thời gian để tạo chuyển động quay vòng tròn
                                angle = angle + (orbitSpeed * dt)
                                
                                -- Tính toán vị trí mới theo quỹ đạo hình tròn (X và Z) quanh quái
                                local enemyPos = enemy.HumanoidRootPart.Position
                                local offsetX = math.cos(angle) * radius
                                local offsetZ = math.sin(angle) * radius
                                
                                -- Cập nhật vị trí xoay và hướng mặt về phía quái
                                rootPart.CFrame = CFrame.new(Vector3.new(enemyPos.X + offsetX, enemyPos.Y + 10, enemyPos.Z + offsetZ), enemyPos)
                                
                                break
                            end
                        end
                    end
                end)
            end
        end)
    end
})



Player:AddSlider({

    Name = "Farm Distance",

    Min = 10,

    Max = 40,

    Default = 30,

    Callback = function(v)

    end

})



Player:AddSlider({

    Name = "Bring Range Distance",

    Min = 100,

    Max = 450,

    Default = 200,

    Callback = function(v)

    end

})



Player:AddSlider({

    Name = "Tween Speed",

    Min = 10,

    Max = 367,

    Default = 352,

    Callback = function(v)

    end

})



Player:AddToggle({

    Name = "⚠️ Bring Mob [30% error]",

    Default = false,

    Callback = function(Value)

        _B = Value

    end

})



Player:AddToggle({

    Name = "Auto Spin Position if Farming",

    Default = false,

    Callback = function(Value)

        RandomCFrame = Value

    end

})



Player:AddToggle({
    Name = "Auto Tween Ys",
    Default = false,
    Callback = function(Value)
        getgenv().translation = Value
        
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local Workspace = game:GetService("Workspace")
        local LocalPlayer = Players.LocalPlayer
        local EnemiesFolder = Workspace:FindFirstChild("Enemies")
        
        local speed = 370 -- Tốc độ tween chuẩn như trong video
        
        if getgenv().translation then
            coroutine.wrap(function()
                while getgenv().translation do
                    task.wait(0.1)
                    local char = LocalPlayer.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
                    local hrp = char.HumanoidRootPart
                    
                    -- Tìm kiếm mục tiêu quái gần nhất để bay (tween) tới farm
                    local targetEnemy = nil
                    local shortestDistance = math.huge
                    
                    if EnemiesFolder then
                        for _, enemy in ipairs(EnemiesFolder:GetChildren()) do
                            local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
                            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
                            if enemyHRP and humanoid and humanoid.Health > 0 then
                                local dist = (hrp.Position - enemyHRP.Position).Magnitude
                                if dist < shortestDistance then
                                    shortestDistance = dist
                                    targetEnemy = enemyHRP
                                end
                            end
                        end
                    end
                    
                    -- Nếu tìm thấy quái, tiến hành Tween bay đến với tốc độ 370
                    if targetEnemy and getgenv().translation then
                        local distance = (hrp.Position - targetEnemy.Position).Magnitude
                        local timeTaken = distance / speed
                        
                        local tweenInfo = TweenInfo.new(timeTaken, Enum.EasingStyle.Linear)
                        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetEnemy.CFrame + Vector3.new(0, 5, 0)})
                        
                        getgenv().CurrentTween = tween
                        tween:Play()
                        
                        -- Chờ tween hoàn thành hoặc bị ngắt giữa chừng khi tắt toggle
                        local completed = false
                        local conn
                        conn = tween.Completed:Connect(function()
                            completed = true
                            if conn then conn:Disconnect() end
                        end)
                        
                        while not completed and getgenv().translation do
                            task.wait()
                        end
                        
                        if not getgenv().translation then
                            tween:Cancel()
                            if conn then conn:Disconnect() end
                            break
                        end
                    end
                end
            end)()
        else
            -- Khi tắt Toggle: Hủy bỏ ngay lập tức tiến trình Tween đang chạy
            getgenv().translation = false
            if getgenv().CurrentTween then
                getgenv().CurrentTween:Cancel()
            end
        end
    end
})



Player:AddToggle({

    Name = "Auto Bypass Teleport",

    Default = false,

    Callback = function(Value)

        _G.Bypass = Value

    end

})



Player:AddToggle({
    Name = "Auto Triple Quest",
    Default = false,
    Callback = function(Value)
        getgenv().TripleQuest = Value
        
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")
        local Workspace = game:GetService("Workspace")
        local LocalPlayer = Players.LocalPlayer
        
        -- Hàm gọi nhận quest từ server Blox Fruits
        local function AcceptQuest(questName, questIndex)
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questName, questIndex or 1)
            end)
        end

        -- Hàm kiểm tra xem người chơi CÓ đang có nhiệm vụ nào dở dang không (Dựa vào UI màn hình game)
        local function HasActiveQuest()
            local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
            if playerGui then
                local mainGui = playerGui:FindFirstChild("Main")
                if mainGui then
                    local questContainer = mainGui:FindFirstChild("Quest")
                    if questContainer and questContainer.Visible == true then
                        -- Nếu bảng Quest đang hiện nghĩa là đang làm nhiệm vụ, KHÔNG nhận mới
                        return true
                    end
                end
            end
            return false
        end

        -- Hàm kiểm tra xem Boss có đang sống trong Workspace hay không
        local function IsBossAlive(bossName)
            local enemies = Workspace:FindFirstChild("Enemies")
            if enemies then
                for _, enemy in ipairs(enemies:GetChildren()) do
                    if string.find(enemy.Name:lower(), bossName:lower()) then
                        local humanoid = enemy:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.Health > 0 then
                            return true
                        end
                    end
                end
            end
            return false
        end

        -- Hàm tự động xác định nhiệm vụ Boss và Level dựa theo cấp độ hiện tại
        local function GetQuestByLevel()
            local data = LocalPlayer:FindFirstChild("Data")
            local level = data and data:FindFirstChild("Level") and data.Level.Value or 1
            
            -- SEA 3
            if level >= 2300 then
                if IsBossAlive("Cake Prince") or IsBossAlive("Dough King") then
                    return "CakeQuest2", 1
                elseif IsBossAlive("Beautiful Pirate") then
                    return "PiratePortQuest", 2
                else
                    return "CakeQuest1", 1
                end
            elseif level >= 2075 then
                if IsBossAlive("Captain Elephant") then
                    return "HauntedQuest2", 2
                else
                    return "HauntedQuest1", 1
                end
            elseif level >= 1500 then
                if IsBossAlive("Stone") or IsBossAlive("Island Boy") or IsBossAlive("Kilo Admiral") then
                    return "MarineTreeIslandQuest", 2
                else
                    return "MarineTreeIslandQuest", 1
                end
            
            -- SEA 2
            elseif level >= 1000 then
                if IsBossAlive("Don Swan") then
                    return "MansionQuest", 1
                else
                    return "FountainQuest", 1
                end
            elseif level >= 700 then
                if IsBossAlive("Diamond") or IsBossAlive("Fajita") then
                    return "FajitaQuest", 1
                else
                    return "Area1Quest", 1
                end
            
            -- SEA 1
            else
                if IsBossAlive("The Gorilla King") or IsBossAlive("The Warden") or IsBossAlive("Chief Petty Officer") then
                    return "JungleQuest", 2
                else
                    return "JungleQuest", 1
                end
            end
        end

        if getgenv().TripleQuest then
            coroutine.wrap(function()
                while getgenv().TripleQuest do
                    -- Kiểm tra: Nếu chưa hoàn thành nhiệm vụ hiện tại (bảng Quest đang mở) thì BỎ QUA, không nhận nữa
                    if not HasActiveQuest() then
                        local questName, questIndex = GetQuestByLevel()
                        if questName then
                            AcceptQuest(questName, questIndex)
                        end
                    end
                    
                    -- Kiểm tra lại sau mỗi 2 giây
                    task.wait(2)
                end
            end)()
        else
            -- Khi tắt Toggle
            getgenv().TripleQuest = false
        end
    end
})



Player:AddToggle({

    Name = "Auto Quest In Farm Bone - Cake",

    Default = True,

    Callback = function(Value)

        _G.AcceptQuestC = Value

    end

})



Player:AddSection("Mode Fast Attack + Settings Ui Extra")



Player:AddToggle({

    Name = "Auto Slow attack ",

    Default = false,

    Callback = function(Value)

        _G.AntiAFK = Value

    end

})



Player:AddToggle({

    Name = "Auto Fast Attack",

    Default = false,

    Callback = function(Value)

        _G.AntiAFK = Value

    end

})



Player:AddTextBox({
   
    Name = "Input Job Id",

    Placeholder = "Job ID",

    ClearOnFocus = true,
 
    Callback = function(Value)
    
        getgenv().Job = Value
  
    end

})



Player:AddToggle({

    Name = "⚠️ Auto Super Fast Attack",

    Default = true,

    Callback = function(Value)

        _G.AntiAFK = Value

    end

})



ScaleDropdown = Player:AddDropdown({

    Name = "UI Scale",

    Description = "",

    Options = {

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



Player:AddSection("Haki Use")



Player:AddToggle({

    Name = "Auto Turn On Buso",

    Default = true,

    Callback = function(Value)

        getgenv().AutoHakiBuso = Value

    end

})

spawn(function()

    while wait() do

        if getgenv().AutoHakiBuso then

            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then

                local args = {

                    [1] = "Buso"

                }

                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

            end

        end

    end

end)

Player:AddToggle({

    Name = "Auto Haki Observation",

    Default = false,

    Callback = function(Value)

        getgenv().Observation = Value

    end

})

spawn(function()

    while wait() do

        if getgenv().Observation then

            pcall(function()

                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)

            end)

        end

    end

end)



Player:AddSection("Race Use")



Player:AddToggle({

    Name = "Auto Turn On Race V3",

    Default = false,

    Callback = function(Value)

        getgenv().AutoTurnOnV3 = Value

    end

})

spawn(function()

    pcall(function()

        while wait() do

            if getgenv().AutoTurnOnV3 then

                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")

            end

        end

    end)

end)



Player:AddToggle({

    Name = "Auto Turn On Race V4",

    Default = false,

    Callback = function(Value)

        getgenv().AutoTurnOnV4 = Value

    end

})

spawn(function()

    while wait() do

        if getgenv().AutoTurnOnV4 then

            local character = game.Players.LocalPlayer.Character

            if character:FindFirstChild("RaceEnergy")

                and character.RaceEnergy.Value >= 1

                and not character.RaceTransformed.Value

            then

                local be = game:GetService("VirtualInputManager")

                be:SendKeyEvent(true, "Y", false, game)

                task.wait()

                be:SendKeyEvent(false, "Y", false, game)

            end

        end

    end

end)



Player:AddSection("GUI Player")



local function playDlg(id)

local rs = game:GetService("ReplicatedStorage")

local dlgCtrl = require(rs.DialogueController)

local dlgList = require(rs.DialoguesList)



for k, v in pairs(dlgList) do

if tostring(k) == id then

dlgCtrl:Start(v)

end

end

end



Player:AddButton({

    Name = "Open Devil Fruit Shop",

    Description = "",

    Callback = function()

        playDlg("FruitShop")

    end

})



Player:AddButton({

    Name = "Open Devil Fruit Shop In Mirage",

    Description = "",

    Callback = function()

        playDlg("FruitShop2")

    end

})



Player:AddButton({

    Name = "Open Title",

    Callback = function()

        local args = {

            [1] = "getTitles"

        }

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

        game.Players.LocalPlayer.PlayerGui.Main.Titles.Visible = true

    end

})



Player:AddButton({

    Name = "Open Awakening",

    Callback = function()

        game:GetService("Players").LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true

    end

})



Player:AddSection("Sword Kill")



Player:AddToggle({
    Name = "Sword One Hit",
    Default = false,
    Callback = function(Value)
        getgenv().SwordKillEnabled = Value
        if Value then
            HookSwordKill(plr.Character)
        else
            ClearSwordKillConnections()
        end
    end
})



Player:AddSection("Configs")



-- Khởi tạo biến cấu hình
getgenv().SH = false

-- Tạo ScreenGui độc lập để hiển thị ở góc phải màn hình
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FPS_Ping_Time_Display"
screenGui.ResetOnSpawn = false
if pcall(function() screenGui.Parent = CoreGui end) then
else
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Tạo khung chứa (Frame) đặt ở góc phải phía trên
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(0, 220, 0, 30)
container.Position = UDim2.new(1, -230, 0, 10) -- Góc phải màn hình
container.BackgroundColor3 = Color3.fromRGB(30, 35, 40)
container.BorderSizePixel = 0
container.Visible = false
container.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 4)
corner.Parent = container

-- Tạo chữ hiển thị (TextLabel)
local textLabel = Instance.new("TextLabel")
textLabel.Name = "DisplayLabel"
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 13
textLabel.Font = Enum.Font.GothamBold
textLabel.TextXAlignment = Enum.TextXAlignment.Center
textLabel.Parent = container

-- Biến đếm thời gian chơi (tính từ khi vào server)
local startTime = tick()

-- Vòng lặp cập nhật FPS, Ping và Time liên tục
RunService.RenderStepped:Connect(function()
    if getgenv().SH then
        container.Visible = true
        
        -- Tính thời gian (Hours:Minutes:Seconds)
        local elapsed = tick() - startTime
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = math.floor(elapsed % 60)
        local timeStr = string.format("%d:%02d:%02d", hours, minutes, seconds)
        
        -- Lấy FPS (Dựa vào RenderStepped delta time)
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        
        -- Lấy Ping thực tế từ Network
        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        
        -- Định dạng hiển thị giống hệt ảnh: TIME : H:M:S | FPS: XX | PING: XXX
        textLabel.Text = string.format("TIME : %s | FPS: %d | PING: %d", timeStr, fps, ping)
    else
        container.Visible = false
        -- Reset lại thời gian nếu tắt đi bật lại từ đầu nếu muốn (hoặc bỏ dòng này nếu muốn giữ nguyên thời gian cũ)
        -- startTime = tick() 
    end
end)

-- Toggle để gắn vào UI của bạn
Player:AddToggle({
    Name = "Show Ping - Fps - Time",
    Default = false,
    Callback = function(Value)
        getgenv().SH = Value
    end
})



--// ===================== HỆ THỐNG AUTO EXECUTOR & SAVE =====================
getgenv().ASF = getgenv().ASF ~= nil and getgenv().ASF or true

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SaveFileName = "RedzHub_SystemState.json"

local SavedStates = {}

-- Đọc trạng thái đã lưu trước đó
pcall(function()
    if readfile and isfile and isfile(SaveFileName) then
        SavedStates = HttpService:JSONDecode(readfile(SaveFileName))
    end
end)

-- Hàm lưu trạng thái
local function SaveCurrentState()
    if not getgenv().ASF then return end
    pcall(function()
        if writefile then
            writefile(SaveFileName, HttpService:JSONEncode(SavedStates))
        end
    end)
end

-- Tự động chạy lại script khi đổi server (Thay LINK_SCRIPT_CUA_BAN_O_DAY thành link script của bạn)
pcall(function()
    if queue_on_teleport then
        queue_on_teleport("loadstring(game:HttpGet(''))()")
    end
end)

-- Bắt sự kiện đổi server để lưu dữ liệu ngay lập tức
LocalPlayer.OnTeleport:Connect(function(teleportState)
    if teleportState == Enum.TeleportState.Started then
        SaveCurrentState()
    end
end)

-- Hàm xử lý tự động kích hoạt lại tính năng khi vào server mới
getgenv().AutoExecuteCheck = function(featureName, callback)
    if SavedStates[featureName] == true and getgenv().ASF then
        task.spawn(function()
            task.wait(3)
            pcall(function()
                if callback then callback(true) end
            end)
        end)
    end

    return function(Value)
        SavedStates[featureName] = Value
        SaveCurrentState()
    end
end


--// ===================== TOGGLE AUTO EXECUTOR CỦA BẠN =====================
Player:AddToggle({
    Name = "Auto Executor",
    Default = SavedStates["AutoExecutorState"] ~= nil and SavedStates["AutoExecutorState"] or true,
    Callback = getgenv().AutoExecuteCheck("AutoExecutorState", function(Value)
        getgenv().Executor = Value
        if Value then
            -- Code khi bật Auto Executor
        else
            -- Code khi tắt Auto Executor
        end
    end)
})



local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Lấy sẵn Translator theo ngôn ngữ hiện tại của người chơi
local success, translator = pcall(function()
    return LocalizationService:GetTranslatorForPlayerAsync(player)
end)

local originalTexts = {}

Player:AddToggle({
    Name = "Auto Translation",
    Default = false,
    Callback = function(Value)
        getgenv().translation = Value
        
        if getgenv().translation then
            print("[AutoTranslate] Đã bật chế độ dịch tự động chuẩn Roblox.")
            
            task.spawn(function()
                while getgenv().translation do
                    local playerGui = player:FindFirstChild("PlayerGui")
                    if playerGui then
                        for _, gui in ipairs(playerGui:GetDescendants()) do
                            if gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox") then
                                -- Bỏ qua UI của chính script để không bị lỗi chữ menu
                                if not gui:IsDescendantOf(playerGui:FindFirstChild("Linoria") or playerGui:FindFirstChild("ScreenGui")) then
                                    
                                    -- Lưu lại text gốc
                                    if not originalTexts[gui] then
                                        originalTexts[gui] = gui.Text
                                    end
                                    
                                    local sourceText = originalTexts[gui]
                                    if sourceText and sourceText ~= "" then
                                        local translatedText = sourceText
                                        
                                        -- Dùng hệ thống dịch của Roblox để dịch sang ngôn ngữ người chơi
                                        if success and translator then
                                            local translated = translator:Translate(gui, sourceText)
                                            if translated and translated ~= "" then
                                                translatedText = translated
                                            end
                                        end
                                        
                                        gui.Text = translatedText
                                    end
                                end
                            end
                        end
                    end
                    task.wait(3) -- Quét lại định kỳ nhẹ nhàng
                end
            end)
        else
            print("[AutoTranslate] Đã tắt, khôi phục văn bản gốc.")
            for gui, originalText in pairs(originalTexts) do
                if gui and gui.Parent then
                    gui.Text = originalText
                end
            end
            originalTexts = {}
        end
    end
})



-- Khởi tạo biến toàn cục
getgenv().translation = getgenv().translation or false

local FileName = "AutoSaveConfig_Translation.json"

-- Hàm lưu dữ liệu an toàn
local function SaveSettings()
    local data = {
        TranslationState = getgenv().translation
    }
    
    if writefile then
        pcall(function()
            writefile(FileName, game:GetService("HttpService"):JSONEncode(data))
        end)
    end
end

-- Hàm đọc dữ liệu ngay khi khởi chạy script
local function LoadSettings()
    if readfile and isfile and isfile(FileName) then
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile(FileName))
        end)
        if success and result then
            getgenv().translation = result.TranslationState or false
        end
    end
end

-- Chạy load dữ liệu cũ
LoadSettings()

-- Tự động lưu khi người chơi thoát hoặc đổi server (Teleport)
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
    SaveSettings()
end)

if game.Close then
    game.Close:Connect(function()
        SaveSettings()
    end)
end

-- Giao diện Toggle
Player:AddToggle({
    Name = "Auto Save Function",
    Default = getgenv().translation, -- Đồng bộ trạng thái đã lưu vào UI
    Callback = function(Value)
        getgenv().translation = Value
        SaveSettings() -- Lưu ngay lập tức khi trạng thái thay đổi
        
        -- Code thực thi chức năng của bạn ở đây
        if Value then
            print("Chức năng đã được BẬT và đã lưu trạng thái!")
        else
            print("Chức năng đã được TẮT và đã lưu trạng thái!")
        end
    end
})

-- Trường hợp nếu bạn muốn tự động Re-join giữ nguyên trạng thái (Dành cho việc thoát game nhanh)
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)



local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- Hàm lấy mã ngôn ngữ (vd: "vi", "en", "ja")
local function getPlayerLanguage()
    local success, lang = pcall(function()
        return player.LocaleId
    end)
    if success and lang then
        return string.sub(lang, 1, 2)
    end
    return "en"
end

-- Hàm gọi API dịch thuật (Sử dụng API miễn phí công khai hoặc endpoint dịch)
local function translateText(text, targetLang)
    if not text or text == "" or targetLang == "en" then return text end
    
    -- Ví dụ sử dụng endpoint dịch công khai (hoặc bạn có thể thay bằng API của bạn)
    local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=" .. targetLang .. "&dt=t&q=" .. HttpService:UrlEncode(text)
    
    local success, response = pcall(function()
        return syn and syn.request({Url = url, Method = "GET"}) or http_request({Url = url, Method = "GET"})
    end)
    
    if success and response and response.StatusCode == 200 then
        local data = HttpService:JSONDecode(response.Body)
        if data and data[1] and data[1][1] and data[1][1][1] then
            return data[1][1][1] -- Trả về kết quả đã dịch
        end
    end
    return text -- Nếu lỗi thì giữ nguyên chữ cũ
end

-- Lưu lại text gốc để khi tắt tính năng có thể khôi phục lại nếu cần
local originalTexts = {}

Player:AddToggle({
    Name = "Auto Translation",
    Default = false,
    Callback = function(Value)
        getgenv().translation = Value
        local targetLang = getPlayerLanguage()
        
        if getgenv().translation then
            print("Đang bật dịch sang: " .. targetLang)
            
            task.spawn(function()
                while getgenv().translation do
                    -- Quét toàn bộ PlayerGui để tìm các Text cần dịch
                    local playerGui = player:FindFirstChild("PlayerGui")
                    if playerGui then
                        for _, gui in ipairs(playerGui:GetDescendants()) do
                            if gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox") then
                                -- Lưu text gốc lại lần đầu tiên quét thấy
                                if not originalTexts[gui] then
                                    originalTexts[gui] = gui.Text
                                end
                                
                                local currentText = originalTexts[gui]
                                if currentText and currentText ~= "" then
                                    -- Tiến hành dịch và gán lại vào Text
                                    local translated = translateText(currentText, targetLang)
                                    if translated and translated ~= currentText then
                                        gui.Text = translated
                                    end
                                end
                            end
                        end
                    end
                    task.wait(5) -- Quét và dịch lại mỗi 5 giây để tránh quá tải (Rate limit)
                end
            end)
        else
            print("Đã tắt dịch, khôi phục văn bản gốc...")
            -- Khôi phục lại text gốc khi tắt toggle
            for gui, originalText in pairs(originalTexts) do
                if gui and gui.Parent then
                    gui.Text = originalText
                end
            end
            originalTexts = {}
        end
    end
})



Player:AddSection("Haki State")



Player:AddDropdown({

    Name = "Select Haki State",

    Options = {"State 0", "State 1", "State 2", "State 3", "State 4", "State 5"},

    Callback = function(Value)

        getgenv().SelectStateHaki = Value

    end

})



Player:AddButton({

    Name = "Change Buso Haki State",

    Callback = function()

        if getgenv().SelectStateHaki == "State 0" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 0)

        elseif getgenv().SelectStateHaki == "State 1" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 1)

        elseif getgenv().SelectStateHaki == "State 2" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 2)

        elseif getgenv().SelectStateHaki == "State 3" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 3)

        elseif getgenv().SelectStateHaki == "State 4" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 4)

        elseif getgenv().SelectStateHaki == "State 5" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", 5)

        end

    end

})



Player:AddSection("Smooth Standby Mode")



Player:AddToggle({

    Name = "Hide Mob",

    Default = false,

    Callback = function(Value)

        getgenv().HideMob = Value

    end

})

spawn(function()

    while wait() do

        if getgenv().HideMob then

            pcall(function()

                for _, v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do

                    if v.ClassName == "MeshPart" then

                        v.Transparency = 1

                    end

                end

                for _, v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do

                    if v.Name == "Head" then

                        v.Transparency = 1

                    end

                end

                for _, v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do

                    if v.ClassName == "Accessory" then

                        v.Handle.Transparency = 1

                    end

                end

                for _, v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do

                    if v.ClassName == "Decal" then

                        v.Transparency = 1

                    end

                end

            end)

        end

    end

end)



Player:AddToggle({

    Name = "Auto Remove Dame Text",

    Default = true,

    Callback = function(Value)

        getgenv().RemoveText = Value

        game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = not getgenv().RemoveText

    end

})



Player:AddToggle({

    Name = "Auto Anti AFK",

    Default = true,

    Callback = function(Value)

        _G.AntiAFK = Value

    end

})



Player:AddToggle({

    Name = "Auto Safe Mode",

    Default = false,

    Callback = function(Value)

        _G.Safemode = Value

    end

})



-- SafeModes spawn loop

spawn(function()

    while task.wait(Sec) do

        pcall(function()

            if _G.Safemode then

                local Calc_Health = plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth * 100

                if Calc_Health < Num_self then

                    shouldTween = true

                    _tp(Root.CFrame * CFrame.new(0, 500, 0))

                else

                    shouldTween = false

                end

            end

        end)

    end

end)



-- Remove Lighting Effect

Player:AddButton({

    Name = "Remove Lighting Effect",

    Callback = function()

        game:GetService("Lighting").BaseAtmosphere:Destroy()

    end

})



Player:AddButton({

    Name = "FPS Booster [New Version]",

    Callback = function()

    FPSBooster()

    end

})

function FPSBooster()

-- ===== SERVICES =====

local g = game

local w = g:GetService("Workspace")

local l = g:GetService("Lighting")

local t = w.Terrain



-- ===== DISABLE GRAPHICS SETTINGS =====

sethiddenproperty(l, "Technology", 2)

sethiddenproperty(t, "Decoration", false)



t.WaterWaveSize = 0

t.WaterWaveSpeed = 0

t.WaterReflectance = 0

t.WaterTransparency = 1



l.GlobalShadows = false

l.FogEnd = 9e9

l.FogStart = 0

l.Brightness = 1.5

l.Ambient = Color3.new(1, 1, 1)

l.OutdoorAmbient = Color3.new(1, 1, 1)

l.ColorShift_Bottom = Color3.new(1, 1, 1)

l.ColorShift_Top = Color3.new(1, 1, 1)

l.ClockTime = 12

l.GeographicLatitude = 0

l.ExposureCompensation = 0.5



-- ===== GRAPHICS QUALITY =====

settings().Rendering.QualityLevel = "Level01"



-- ===== REMOVE EFFECTS FUNCTION =====

local function removeEffects(obj)

    if not obj or not obj.Parent then return end

    

    local class = obj.ClassName

    

    if class == "Decal" or class == "Texture" then

        obj:Destroy()

        

    elseif class == "Part" or class == "Union" or class == "CornerWedgePart" or class == "TrussPart" or class == "MeshPart" then

        obj.Material = Enum.Material.SmoothPlastic

        obj.Reflectance = 0

        obj.Transparency = 0

        if class == "MeshPart" then

            obj.TextureID = ""

        end

        

    elseif class == "ParticleEmitter" or class == "Trail" or class == "Fire" or class == "Smoke" or class == "Sparkles" then

        obj.Enabled = false

        obj:Destroy()

        

    elseif class == "SpotLight" or class == "PointLight" or class == "SurfaceLight" then

        obj.Enabled = false

        obj:Destroy()

        

    elseif class == "Beam" then

        obj.Enabled = false

        obj:Destroy()

        

    elseif class == "Explosion" then

        obj.BlastPressure = 0

        obj.BlastRadius = 0

        obj.Visible = false

        obj:Destroy()

        

    elseif class == "Sound" then

        obj:Stop()

        obj:Destroy()

    end

end



-- ===== REMOVE POST FX =====

local atmosphere = l:FindFirstChild("Atmosphere")

if atmosphere then

    atmosphere:Destroy()

end



for _, e in ipairs(l:GetChildren()) do

    if e:IsA("PostEffect") or e:IsA("BloomEffect") or e:IsA("BlurEffect") or 

       e:IsA("ColorCorrectionEffect") or e:IsA("DepthOfFieldEffect") or 

       e:IsA("SunRaysEffect") then

        e.Enabled = false

        e:Destroy()

    end

end



-- ===== SCAN WORKSPACE =====

for _, v in ipairs(w:GetDescendants()) do

    removeEffects(v)

end



-- ===== MEMORY CLEANUP =====

wait(1)

collectgarbage()

collectgarbage()

end



Player:AddSection("Upgrade Stats")



Player:AddSlider({

    Name = "Stats Value",

    Description = "Choose your point need to upgrade",

    Min = 0,

    Max = 1000,

    Default = 10,

    Callback = function(value)

        pSats = value

    end

})



-- Dropdown chọn loại stats

Player:AddDropdown({

    Name = "Select Stats Type",

    Options = {"Melee", "Sword", "Gun", "Blox Fruit", "Defense"},

    Default = "Melee",

    Callback = function(value)

        _G.SelectedStat = value

    end

})



-- Auto Upgrade Toggle

Player:AddToggle({

    Name = "Auto Upgrade Stats",

    Description = "",

    Default = false,

    Callback = function(value)

        _G.Auto_Stats = value

    end

})



-- Loop Auto Upgrade

spawn(function()

    while wait(Sec or 1) do

        pcall(function()

            if _G.Auto_Stats and _G.SelectedStat and statsSetings then

                local statMap = {

                    Melee = "Melee",

                    Sword = "Sword", 

                    Gun = "Gun",

                    ["Blox Fruit"] = "Devil",

                    Defense = "Defense"

                }

                statsSetings(statMap[_G.SelectedStat], pSats)

            end

        end)

    end

end)



Player:AddSection("Players & Redeem All Codes")



Player:AddToggle({
    Name = "Walk on Water",
    Default = false,
    Callback = function(Value)
        getgenv().WalkonWater = Value
        _G.WalkWater_Part = Value
        
        pcall(function()
            local waterPlane = game:GetService("Workspace"):FindFirstChild("Map") 
                and game.Workspace.Map:FindFirstChild("WaterBase-Plane")
            
            if waterPlane then
                if _G.WalkWater_Part then
                    waterPlane.Size = Vector3.new(1000, 112, 1000)
                else
                    waterPlane.Size = Vector3.new(1000, 80, 1000)
                end
            end
        end)
    end
})



Player:AddToggle({
    Name = "Reedem All Codes",
    Default = false,
    Callback = function(Value)
        getgenv().RAC = Value
        
        if Value then
            task.spawn(function()
                local Codes = {
                    "KITT_RESET", "Sub2UncleKizaru", "SUB2GAMERROBOT_RESET1", "Sub2Fer999", "Enyu_is_Pro", "JCWK",
                    "StarcodeHEO", "MagicBus", "KittGaming", "Sub2CaptainMaui", "Sub2OfficalNoobie", "TheGreatAce",
                    "Sub2NoobMaster123", "Sub2Daigrock", "Axiore", "StrawHatMaine", "TantaiGaming", "Bluxxy",
                    "SUB2GAMERROBOT_EXP1", "Chandler", "NOMOREHACK", "BANEXPLOIT", "WildDares", "BossBuild",
                    "GetPranked", "EARN_FRUITS", "FIGHT4FRUIT", "NOEXPLOITER", "NOOB2ADMIN", "CODESLIDE", "ADMINHACKED",
                    "ADMINDARES", "fruitconcepts", "krazydares", "TRIPLEABUSE", "SEATROLLING", "24NOADMIN", "REWARDFUN",
                    "NEWTROLL", "fudd10_v2", "Fudd10", "Bignews", "SECRET_ADMIN"
                }

                for _, code in ipairs(Codes) do
                    if not getgenv().RAC then break end
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(code)
                    end)
                    task.wait(0.5) -- Đợi nửa giây giữa mỗi lần nhập để tránh bị spam lag/rate limit
                end
            end)
        end
    end
})



Player:AddSection("Join Team")



Player:AddButton({

    Name = "Auto Set Team Pirate",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")

    end

})



Player:AddButton({

    Name = "Auto Set Team Marines",

    Callback = function()

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")

    end

})
