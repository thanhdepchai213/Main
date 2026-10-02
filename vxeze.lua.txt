PrintLastAt = {}

PrintOnce = function(arg)
	local str = tostring(arg)
	if tick() - (PrintLastAt[str] or 0) < 10 then
		return
	end
	PrintLastAt[str] = tick()
	warn(str)
end

__VxezeHubMain = function()
	if getgenv().__VXEZE_LOADED then
		local flag = false

		pcall(function()
			local vxezeUI = getgenv().VxezeUI
			local root = vxezeUI and vxezeUI.Library and vxezeUI.Library._Root
			flag = root ~= nil and root.Parent ~= nil and vxezeUI.Window ~= nil
		end)

		if flag then
			return getgenv().__VXEZE_RESULT
		end

		if getgenv().__NullUI_Unload then
			pcall(getgenv().__NullUI_Unload)
		end

		getgenv().__VXEZE_LOADED = nil
		getgenv().__VXEZE_RESULT = nil
	end

	Settings = {}
	HttpService = game:GetService("HttpService")
	FolderName = "Vxeze Hub"
	SaveFileNameGame = "-BloxFruitVxeze.json"
	SaveFileName = game.Players.LocalPlayer.Name .. SaveFileNameGame

	SaveSettings = function(arg, arg2, arg3)
		if arg3 ~= nil then
			Settings[arg] = Settings[arg] or {}
			Settings[arg][arg2] = arg3
		elseif arg ~= nil then
			Settings[arg] = arg2
		end

		if not isfolder(FolderName) then
			makefolder(FolderName)
		end

		writefile(FolderName .. "/" .. SaveFileName, HttpService:JSONEncode(Settings))
	end

	if getgenv().Config then
		Settings = getgenv().Config
		SaveSettings()
	end

	ReadSetting = function()
		local ok, result = pcall(function()
			if not isfolder(FolderName) then
				makefolder(FolderName)
			end

			return HttpService:JSONDecode(readfile(FolderName .. "/" .. SaveFileName))
		end)

		if ok then
			return result
		end
		SaveSettings()
		return ReadSetting()
	end

	Settings = ReadSetting()
	local v = Settings
	getgenv().Settings = v

	PrepareMultiSelectList = function(arg, arg2, arg3)
		local tbl = {}

		for k in pairs(arg) do
			local v2 = arg2 and arg2[k]

			if v2 == nil then
				tbl[k] = arg3 and true or false
			else
				tbl[k] = v2
			end
		end

		return tbl
	end

	EnsureAllTrueDefaults = function(arg, arg2)
		if type(Settings[arg]) ~= "table" then
			Settings[arg] = {}
		end

		local flag = false

		for _, v2 in ipairs(arg2) do
			if Settings[arg][v2] == nil then
				Settings[arg][v2] = true
				flag = true
			end
		end

		if flag then
			for k, v2 in pairs(Settings[arg]) do
				SaveSettings(arg, k, v2)
			end
		end
	end

	repeat
		task.wait()
	until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen")

	while true do
		task.wait()
		if not (game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded")) then
			continue
		end
		break
	end

	FireButton = function(selectedObject)
		selectedObject.Selectable = true
		game:GetService("GuiService").SelectedObject = selectedObject

		pcall(function()
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "Return", false, selectedObject)
		end)

		pcall(function()
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "Return", false, selectedObject)
		end)

		selectedObject.Activated:Connect(function()
			game:GetService("GuiService").SelectedObject = nil
		end)
	end

	while true do
		task.wait()
		if not (game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main")) then
			continue
		end
		break
	end

	local mainMinimal
	mainMinimal = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main")

	repeat
		task.wait()
	until mainMinimal:FindFirstChild("ChooseTeam")

	IsTeamChosen = function()
		local chooseTeam = mainMinimal:FindFirstChild("ChooseTeam")
		local flag = game.Players.LocalPlayer.Team ~= nil
		local flag2

		if flag then
			flag2 = not (chooseTeam and chooseTeam.Visible)
		else
			flag2 = flag
		end

		return flag2
	end

	while not IsTeamChosen() do
		pcall(function()
			FireButton(mainMinimal.ChooseTeam.Container[Settings["Select Team"] == "Pirate" and "Pirates" or "Marines"].Frame.TextButton)
		end)

		task.wait(0.5)
	end

	game:GetService("GuiService").SelectedObject = nil

	while true do
		task.wait()
		if not (game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
			continue
		end
		break
	end

	getgenv().ExploitReq = request or http_request or syn and syn.request or http and http.request or requests
	Place_Id = {}

	Place_Id.sea1 = function()
		return workspace:GetAttribute("MAP") == "Sea1"
	end

	Place_Id.sea2 = function()
		return workspace:GetAttribute("MAP") == "Sea2"
	end

	Place_Id.sea3 = function()
		return workspace:GetAttribute("MAP") == "Sea3"
	end

	local localPlayer
	localPlayer = game.Players.LocalPlayer
	local getupvalue = debug.getupvalue
	getgenv().getupvalue = getupvalue
	local getupvalues_ = debug.getupvalues
	getgenv().getupvalues = getupvalues_
	wOrigin = game.workspace._WorldOrigin
	CommF = game.ReplicatedStorage.Remotes.CommF_
	vu = game:GetService("VirtualUser")

	game:GetService("Players").LocalPlayer.Idled:connect(function()
		vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		wait(1)
		vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	end)

	do
		local tbl = {
			Library = nil,
			Window = nil,
			SettingTab = nil,
			ElementCount = 0,
			RecentNotify = {},
			Errors = {},
		}

		local function fn(arg, arg2, arg3, arg4, arg5)
			local tbl2 = {}
			local tbl3 = {}
			local n = arg
			local n2 = arg2
			local v2 = arg3
			local v3 = arg4
			local v4 = arg5
			local n3 = 1
			local tbl4 = nil
			local v5 = nil
			local char = nil
			local byte = nil
			local n4 = nil
			local n5 = nil
			local n6 = nil
			local n7 = nil
			local n8 = nil
			local n9 = nil
			local n10 = nil
			local n11 = nil

			while true do
				if n3 <= 31 then
					if n3 <= 15 then
						if n3 <= 7 then
							if n3 <= 3 then
								if n3 <= 1 then
									if n3 <= 0 then
										tbl4 = tbl4[5]
										n3 = 38
									else
										char = string.char
										byte = string.byte

										if n2 == 2 then
											n3 = 36
											n4 = n
										else
											n3 = 57
										end
									end
								elseif n3 <= 2 then
									tbl4 = tbl4[1]
									n3 = 32
								else
									n3 = 24
									n2 = 4225628066614523
									n5 = 1640726024911297
									n6 = 4503599627370496
									n7 = 67108864
									n8 = 17592186044416
									n9 = 66262169
									n10 = 66419657
									tbl4 = { tbl4, 4, 1, 0, nil }
								end
							elseif n3 <= 5 then
								if n3 <= 4 then
									n4 = (n4 - n7) / 2
									n5 = (n5 - n9) / 2
									n7 = n4 % 2
									n9 = n5 % 2

									if n7 ~= n9 then
										n3 = 11
										n6 = 4
									else
										n3 = 7
									end
								else
									tbl4 = tbl4[1]
									n3 = 27
								end
							elseif n3 <= 6 then
								n4 = (n4 - n7) / 2
								n5 = (n5 - n9) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 12
									n6 = 128
								else
									n3 = 35
								end
							else
								n4 = (n4 - n7) / 2
								n5 = (n5 - n9) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 18
									n6 = 8
								else
									n3 = 55
								end
							end
						elseif n3 <= 11 then
							if n3 <= 9 then
								if n3 <= 8 then
									local n12 = n4 * 2 + 1
									local v6 = n5[n12]
									local v7 = n5[n12 + 1]

									if not v6 then
										n3 = 40
									else
										n3 = 37
										n6 = v6
										n7 = v7
									end
								else
									local v6 = tbl4[3]
									local v7 = tbl4[5]
									local n12 = tbl4[2] + v6
									local flag = v6 <= 0
									local flag2 = not flag
									local flag3 = n12 >= v7
									local flag4 = n12 <= v7
									flag = flag and flag3
									flag2 = flag2 and flag4
									flag2 = flag or flag2
									tbl4[2] = n12

									if flag2 then
										n3 = 56
										n6 = n12
									else
										n3 = 54
									end
								end
							elseif n3 <= 10 then
								n8 += n6
								n3 = 6
							else
								n8 += n6
								n3 = 7
							end
						elseif n3 <= 13 then
							if n3 <= 12 then
								n8 += n6
								n3 = 35
							else
								local v6 = tbl4[5]
								local v7 = tbl4[4]
								local n12 = tbl4[2] + v6
								local flag = v6 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v7
								local flag4 = n12 <= v7
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[2] = n12

								if flag3 then
									n3 = 16
								else
									n3 = 2
								end
							end
						elseif n3 <= 14 then
							tbl4 = tbl4[2]
							n3 = 36
						else
							n8 += n6
							n3 = 63
						end

						continue
					end

					if n3 <= 23 then
						if n3 <= 19 then
							if n3 <= 17 then
								if n3 <= 16 then
									n4 = (n6 * n4 + n7) % 4294967296
									n11 ..= n8[1 + (n4 - n4 % 268435456) / 268435456 % 16]
									n3 = 13
									continue
								end

								return nil
							end

							if n3 <= 18 then
								n8 += n6
								n3 = 55
							else
								n = (n + tbl3[n2] + n4[n2 % 32 + 1]) % 256
								local v6 = tbl3[n2]
								tbl3[n2] = tbl3[n]
								tbl3[n] = v6
								n3 = 25
							end

							continue
						end

						if n3 <= 21 then
							if n3 <= 20 then
								local v6 = tbl4[1]
								local v7 = tbl4[5]
								local n12 = tbl4[4] + v6
								local flag = v6 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v7
								local flag4 = n12 <= v7
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[4] = n12

								if flag3 then
									n3 = 8
									n4 = n12
								else
									n3 = 59
								end
							else
								n3 = 25
								n = 0
								tbl4 = { 1, 255, nil, -1, tbl4 }
							end
						elseif n3 <= 22 then
							n[n4] = n6
							n[52] = 4
							n[99] = 12
							n[51] = 3
							n[65] = 10
							n[48] = 0
							n[101] = 14
							n[54] = 6
							n3 = 28
							n4 = 49
							n6 = 1
						else
							n = (n - n11) / 65536
							local n12 = (n2 + n11) % n6
							local n13 = n12 % n7
							n2 = ((((n12 - n13) / n7 * n9 + n13 * n10) % n7 * n7 + n13 * n9) % n6 + n5) % n6
							n3 = 24
						end

						continue
					end

					if n3 <= 27 then
						if n3 <= 25 then
							if n3 <= 24 then
								local v6 = tbl4[3]
								local v7 = tbl4[2]
								local n12 = tbl4[4] + v6
								local flag = v6 <= 0
								local flag2 = flag and n12 >= v7 or not flag and n12 <= v7
								tbl4[4] = n12

								if flag2 then
									n3 = 31
									n11 = n12
								else
									n3 = 5
								end
							else
								local v6 = tbl4[1]
								local v7 = tbl4[2]
								local n12 = tbl4[4] + v6
								local flag = v6 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v7
								local flag4 = n12 <= v7
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[4] = n12

								if flag3 then
									n3 = 19
									n2 = n12
								else
									n3 = 51
								end
							end
						elseif n3 <= 26 then
							n5 = {}
							n8 = { "6", "4", "e", "a", "5", "8", "d", "2", "1", "9", "3", "7", "c", "f", "b", "0" }
							n3 = 58
							n4 = 870728320
							n6 = 493413649
							n7 = -405362667
							n9 = 1
							tbl4 = { 0, 1, nil, 128, tbl4 }
						else
							n3 = 49
							tbl4 = { nil, tbl4, 1, 32, 0 }
						end
					elseif n3 <= 29 then
						if n3 <= 28 then
							n[n4] = n6
							n[100] = 13
							n[56] = 8
							n[97] = 10
							n[69] = 14
							n[66] = 11
							n[57] = 9
							n3 = 20
							tbl4 = { 1, tbl4, nil, -1, 31 }
						else
							n8 += n6
							n3 = 4
						end
					elseif n3 <= 30 then
						n2[n4 + 1] = n[n6] * 16 + n[n7]
						n3 = 20
					else
						n11 = n % 65536
						n3 = n11 < 0 and 53 or 45
					end
				else
					if n3 <= 47 then
						if n3 <= 39 then
							if n3 <= 35 then
								if n3 <= 33 then
									if n3 <= 32 then
										byte(n11, 1, 64)
										n3 = n10 == n9 and 34 or 58
									else
										local n12 = n2 % n7
										n2 = ((((n2 - n12) / n7 * n9 + n12 * n10) % n7 * n7 + n12 * n9) % n6 + n5) % n6
										n4[n] = (n2 - n2 % n8) / n8
										n3 = 49
									end
								elseif n3 <= 34 then
									n5 = { byte(n, 1, 64) }
									n3 = 58
								else
									char ..= tbl2[n8]
									n3 = 62
								end
							elseif n3 <= 37 then
								if n3 <= 36 then
									n = n4[3]
									n2 = 4 * n4[1] % 64 + 1
									n5 = 2 * n4[2] % 128 - 1
									n3 = 9
									tbl4 = { nil, -1, 1, tbl4, 255 }
								else
									n3 = not n7 and 17 or 30
								end
							elseif n3 <= 38 then
								n = { [53] = 5, [70] = 15, [68] = 13, [55] = 7, [67] = 12, [50] = 2, [102] = 15 }
								n3 = 22
								n4 = 98
								n6 = 11
							else
								n3 = 13
								n11 = ""
								tbl4 = { tbl4, 0, nil, 64, 1 }
							end

							continue
						end

						if n3 <= 43 then
							if n3 <= 41 then
								if n3 <= 40 then
									return nil
								end
								v3[v4] = char
								n3 = 44
								continue
							end

							if n3 <= 42 then
								n11 -= 65536
								n3 = 23
							else
								n4 = (n4 - n6) / 2
								n5 = (n5 - n7) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 29
									n6 = 2
								else
									n3 = 4
								end
							end

							continue
						end

						if n3 <= 45 then
							if n3 <= 44 then
								break
							end
							n3 = n11 >= 65536 and 42 or 23
							continue
						end

						if n3 <= 46 then
							n = (n + 1) % 256
							n2 = (n2 + tbl3[n]) % 256
							local v6 = tbl3[n]
							tbl3[n] = tbl3[n2]
							tbl3[n2] = v6
							local v7 = byte(v2, n4)
							n5 = tbl3[(tbl3[n] + tbl3[n2]) % 256]
							n6 = v7 % 2
							n7 = n5 % 2

							if n6 ~= n7 then
								n3 = 48
								n4 = v7
							else
								n3 = 43
								n8 = 0
								n4 = v7
							end
						else
							n4 = (n4 - n7) / 2
							n5 = (n5 - n9) / 2
							n7 = n4 % 2
							n9 = n5 % 2

							if n7 ~= n9 then
								n3 = 15
								n6 = 32
							else
								n3 = 63
							end
						end

						continue
					end

					if n3 <= 55 then
						if n3 <= 51 then
							if n3 <= 49 then
								if n3 <= 48 then
									n3 = 43
									n8 = 1
								else
									local v6 = tbl4[3]
									local v7 = tbl4[4]
									local n12 = tbl4[5] + v6
									local flag = v6 <= 0
									local flag2 = not flag
									local flag3 = n12 >= v7
									local flag4 = n12 <= v7
									flag3 = flag and flag3
									flag3 = flag3 or flag2 and flag4
									tbl4[5] = n12

									if flag3 then
										n3 = 33
										n = n12
									else
										n3 = 14
									end
								end
							elseif n3 <= 50 then
								tbl4 = tbl4[3]
								n3 = 41
							else
								tbl4 = tbl4[5]
								n3 = 61
							end
						elseif n3 <= 53 then
							if n3 <= 52 then
								n8 += n6
								n3 = 47
							else
								n11 += 65536
								n3 = 45
							end
						elseif n3 <= 54 then
							tbl4 = tbl4[4]
							n3 = 21
						else
							n4 = (n4 - n7) / 2
							n5 = (n5 - n9) / 2
							n7 = n4 % 2
							n9 = n5 % 2

							if n7 ~= n9 then
								n3 = 52
								n6 = 16
							else
								n3 = 47
							end
						end
					elseif n3 <= 59 then
						if n3 <= 57 then
							if n3 <= 56 then
								tbl2[n] = char(n)
								tbl3[n] = n
								n = (n2 * n + n5) % 256
								n3 = 9
							else
								local tbl5 = {}

								if n2 == 1 then
									n3 = 26
									n2 = tbl5
								else
									n3 = 60
									n4 = tbl5
								end
							end
						elseif n3 <= 58 then
							local v6 = tbl4[2]
							local v7 = tbl4[4]
							local n12 = tbl4[1] + v6
							local flag = v6 <= 0
							local flag2 = not flag
							local flag3 = n12 >= v7
							local flag4 = n12 <= v7
							flag3 = flag and flag3
							flag2 = flag2 and flag4
							flag2 = flag3 or flag2
							tbl4[1] = n12

							if flag2 then
								n3 = 39
								n10 = n12
							else
								n3 = 0
							end
						else
							tbl4 = tbl4[2]
							n3 = 36
							n4 = n2
						end
					elseif n3 <= 61 then
						if n3 <= 60 then
							n3 = n2 == 0 and 3 or 36
						else
							n3 = 62
							n = 0
							n2 = 0
							char = ""
							tbl4 = { #v2 + 0, 0, tbl4, 1, nil }
						end
					elseif n3 <= 62 then
						local v6 = tbl4[4]
						local v7 = tbl4[1]
						local n12 = tbl4[2] + v6
						local flag = v6 <= 0
						local flag2 = not flag
						local flag3 = n12 >= v7
						local flag4 = n12 <= v7
						flag3 = flag and flag3
						flag3 = flag3 or flag2 and flag4
						tbl4[2] = n12

						if flag3 then
							n3 = 46
							n4 = n12
						else
							n3 = 50
						end
					else
						n4 = (n4 - n7) / 2
						n5 = (n5 - n9) / 2
						n7 = n4 % 2
						n9 = n5 % 2

						if n7 ~= n9 then
							n3 = 10
							n6 = 64
						else
							n3 = 6
						end
					end
				end
			end
		end

		fn(-3037147829324948, 0, "\255L\189\193\155L\223O\236\166}\30d\12\186.\222$A\212H'-\1810o~\140Kc\16K\244\219|!\205\24\191|\163$\240\n+tձ\244\27\192\29\249\225C\237\243I\150\175\137L\169\166\15\172\206e!\232\234\167\195\18\134[\224ؿ\4%j#", nil --[[ the caller's registers ]], 55)
		tbl.SourceUrl = "\255L\189\193\155L\223O\236\166}\30d\12\186.\222$A\212H'-\1810o~\140Kc\16K\244\219|!\205\24\191|\163$\240\n+tձ\244\27\192\29\249\225C\237\243I\150\175\137L\169\166\15\172\206e!\232\234\167\195\18\134[\224ؿ\4%j#"

		local function fn2(arg, arg2, arg3, arg4, arg5)
			local tbl2 = {}
			local tbl3 = {}
			local n = arg
			local n2 = arg2
			local v2 = arg3
			local v3 = arg4
			local v4 = arg5
			local n3 = 1
			local tbl4 = nil
			local v5 = nil
			local char = nil
			local byte = nil
			local n4 = nil
			local n5 = nil
			local n6 = nil
			local n7 = nil
			local n8 = nil
			local n9 = nil
			local n10 = nil
			local n11 = nil

			while true do
				if n3 <= 31 then
					if n3 <= 15 then
						if n3 <= 7 then
							if n3 <= 3 then
								if n3 <= 1 then
									if n3 <= 0 then
										tbl4 = tbl4[5]
										n3 = 38
									else
										char = string.char
										byte = string.byte

										if n2 == 2 then
											n3 = 36
											n4 = n
										else
											n3 = 57
										end
									end
								elseif n3 <= 2 then
									tbl4 = tbl4[1]
									n3 = 32
								else
									n3 = 24
									n2 = 4225628066614523
									n5 = 1640726024911297
									n6 = 4503599627370496
									n7 = 67108864
									n8 = 17592186044416
									n9 = 66262169
									n10 = 66419657
									tbl4 = { tbl4, 4, 1, 0, nil }
								end
							elseif n3 <= 5 then
								if n3 <= 4 then
									n4 = (n4 - n7) / 2
									n5 = (n5 - n9) / 2
									n7 = n4 % 2
									n9 = n5 % 2

									if n7 ~= n9 then
										n3 = 11
										n6 = 4
									else
										n3 = 7
									end
								else
									tbl4 = tbl4[1]
									n3 = 27
								end
							elseif n3 <= 6 then
								n4 = (n4 - n7) / 2
								n5 = (n5 - n9) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 12
									n6 = 128
								else
									n3 = 35
								end
							else
								n4 = (n4 - n7) / 2
								n5 = (n5 - n9) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 18
									n6 = 8
								else
									n3 = 55
								end
							end
						elseif n3 <= 11 then
							if n3 <= 9 then
								if n3 <= 8 then
									local n12 = n4 * 2 + 1
									local v6 = n5[n12]
									local v7 = n5[n12 + 1]

									if not v6 then
										n3 = 40
									else
										n3 = 37
										n6 = v6
										n7 = v7
									end
								else
									local v6 = tbl4[3]
									local v7 = tbl4[5]
									local n12 = tbl4[2] + v6
									local flag = v6 <= 0
									local flag2 = not flag
									local flag3 = n12 >= v7
									local flag4 = n12 <= v7
									flag = flag and flag3
									flag2 = flag2 and flag4
									flag2 = flag or flag2
									tbl4[2] = n12

									if flag2 then
										n3 = 56
										n6 = n12
									else
										n3 = 54
									end
								end
							elseif n3 <= 10 then
								n8 += n6
								n3 = 6
							else
								n8 += n6
								n3 = 7
							end
						elseif n3 <= 13 then
							if n3 <= 12 then
								n8 += n6
								n3 = 35
							else
								local v6 = tbl4[5]
								local v7 = tbl4[4]
								local n12 = tbl4[2] + v6
								local flag = v6 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v7
								local flag4 = n12 <= v7
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[2] = n12

								if flag3 then
									n3 = 16
								else
									n3 = 2
								end
							end
						elseif n3 <= 14 then
							tbl4 = tbl4[2]
							n3 = 36
						else
							n8 += n6
							n3 = 63
						end

						continue
					end

					if n3 <= 23 then
						if n3 <= 19 then
							if n3 <= 17 then
								if n3 <= 16 then
									n4 = (n6 * n4 + n7) % 4294967296
									n11 ..= n8[1 + (n4 - n4 % 268435456) / 268435456 % 16]
									n3 = 13
									continue
								end

								return nil
							end

							if n3 <= 18 then
								n8 += n6
								n3 = 55
							else
								n = (n + tbl3[n2] + n4[n2 % 32 + 1]) % 256
								local v6 = tbl3[n2]
								tbl3[n2] = tbl3[n]
								tbl3[n] = v6
								n3 = 25
							end

							continue
						end

						if n3 <= 21 then
							if n3 <= 20 then
								local v6 = tbl4[1]
								local v7 = tbl4[5]
								local n12 = tbl4[4] + v6
								local flag = v6 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v7
								local flag4 = n12 <= v7
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[4] = n12

								if flag3 then
									n3 = 8
									n4 = n12
								else
									n3 = 59
								end
							else
								n3 = 25
								n = 0
								tbl4 = { 1, 255, nil, -1, tbl4 }
							end
						elseif n3 <= 22 then
							n[n4] = n6
							n[52] = 4
							n[99] = 12
							n[51] = 3
							n[65] = 10
							n[48] = 0
							n[101] = 14
							n[54] = 6
							n3 = 28
							n4 = 49
							n6 = 1
						else
							n = (n - n11) / 65536
							local n12 = (n2 + n11) % n6
							local n13 = n12 % n7
							n2 = ((((n12 - n13) / n7 * n9 + n13 * n10) % n7 * n7 + n13 * n9) % n6 + n5) % n6
							n3 = 24
						end

						continue
					end

					if n3 <= 27 then
						if n3 <= 25 then
							if n3 <= 24 then
								local v6 = tbl4[3]
								local v7 = tbl4[2]
								local n12 = tbl4[4] + v6
								local flag = v6 <= 0
								local flag2 = flag and n12 >= v7 or not flag and n12 <= v7
								tbl4[4] = n12

								if flag2 then
									n3 = 31
									n11 = n12
								else
									n3 = 5
								end
							else
								local v6 = tbl4[1]
								local v7 = tbl4[2]
								local n12 = tbl4[4] + v6
								local flag = v6 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v7
								local flag4 = n12 <= v7
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[4] = n12

								if flag3 then
									n3 = 19
									n2 = n12
								else
									n3 = 51
								end
							end
						elseif n3 <= 26 then
							n5 = {}
							n8 = { "6", "4", "e", "a", "5", "8", "d", "2", "1", "9", "3", "7", "c", "f", "b", "0" }
							n3 = 58
							n4 = 870728320
							n6 = 493413649
							n7 = -405362667
							n9 = 1
							tbl4 = { 0, 1, nil, 128, tbl4 }
						else
							n3 = 49
							tbl4 = { nil, tbl4, 1, 32, 0 }
						end
					elseif n3 <= 29 then
						if n3 <= 28 then
							n[n4] = n6
							n[100] = 13
							n[56] = 8
							n[97] = 10
							n[69] = 14
							n[66] = 11
							n[57] = 9
							n3 = 20
							tbl4 = { 1, tbl4, nil, -1, 31 }
						else
							n8 += n6
							n3 = 4
						end
					elseif n3 <= 30 then
						n2[n4 + 1] = n[n6] * 16 + n[n7]
						n3 = 20
					else
						n11 = n % 65536
						n3 = n11 < 0 and 53 or 45
					end
				else
					if n3 <= 47 then
						if n3 <= 39 then
							if n3 <= 35 then
								if n3 <= 33 then
									if n3 <= 32 then
										byte(n11, 1, 64)
										n3 = n10 == n9 and 34 or 58
									else
										local n12 = n2 % n7
										n2 = ((((n2 - n12) / n7 * n9 + n12 * n10) % n7 * n7 + n12 * n9) % n6 + n5) % n6
										n4[n] = (n2 - n2 % n8) / n8
										n3 = 49
									end
								elseif n3 <= 34 then
									n5 = { byte(n, 1, 64) }
									n3 = 58
								else
									char ..= tbl2[n8]
									n3 = 62
								end
							elseif n3 <= 37 then
								if n3 <= 36 then
									n = n4[3]
									n2 = 4 * n4[1] % 64 + 1
									n5 = 2 * n4[2] % 128 - 1
									n3 = 9
									tbl4 = { nil, -1, 1, tbl4, 255 }
								else
									n3 = not n7 and 17 or 30
								end
							elseif n3 <= 38 then
								n = { [53] = 5, [70] = 15, [68] = 13, [55] = 7, [67] = 12, [50] = 2, [102] = 15 }
								n3 = 22
								n4 = 98
								n6 = 11
							else
								n3 = 13
								n11 = ""
								tbl4 = { tbl4, 0, nil, 64, 1 }
							end

							continue
						end

						if n3 <= 43 then
							if n3 <= 41 then
								if n3 <= 40 then
									return nil
								end
								v3[v4] = char
								n3 = 44
								continue
							end

							if n3 <= 42 then
								n11 -= 65536
								n3 = 23
							else
								n4 = (n4 - n6) / 2
								n5 = (n5 - n7) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 29
									n6 = 2
								else
									n3 = 4
								end
							end

							continue
						end

						if n3 <= 45 then
							if n3 <= 44 then
								break
							end
							n3 = n11 >= 65536 and 42 or 23
							continue
						end

						if n3 <= 46 then
							n = (n + 1) % 256
							n2 = (n2 + tbl3[n]) % 256
							local v6 = tbl3[n]
							tbl3[n] = tbl3[n2]
							tbl3[n2] = v6
							local v7 = byte(v2, n4)
							n5 = tbl3[(tbl3[n] + tbl3[n2]) % 256]
							n6 = v7 % 2
							n7 = n5 % 2

							if n6 ~= n7 then
								n3 = 48
								n4 = v7
							else
								n3 = 43
								n8 = 0
								n4 = v7
							end
						else
							n4 = (n4 - n7) / 2
							n5 = (n5 - n9) / 2
							n7 = n4 % 2
							n9 = n5 % 2

							if n7 ~= n9 then
								n3 = 15
								n6 = 32
							else
								n3 = 63
							end
						end

						continue
					end

					if n3 <= 55 then
						if n3 <= 51 then
							if n3 <= 49 then
								if n3 <= 48 then
									n3 = 43
									n8 = 1
								else
									local v6 = tbl4[3]
									local v7 = tbl4[4]
									local n12 = tbl4[5] + v6
									local flag = v6 <= 0
									local flag2 = not flag
									local flag3 = n12 >= v7
									local flag4 = n12 <= v7
									flag3 = flag and flag3
									flag3 = flag3 or flag2 and flag4
									tbl4[5] = n12

									if flag3 then
										n3 = 33
										n = n12
									else
										n3 = 14
									end
								end
							elseif n3 <= 50 then
								tbl4 = tbl4[3]
								n3 = 41
							else
								tbl4 = tbl4[5]
								n3 = 61
							end
						elseif n3 <= 53 then
							if n3 <= 52 then
								n8 += n6
								n3 = 47
							else
								n11 += 65536
								n3 = 45
							end
						elseif n3 <= 54 then
							tbl4 = tbl4[4]
							n3 = 21
						else
							n4 = (n4 - n7) / 2
							n5 = (n5 - n9) / 2
							n7 = n4 % 2
							n9 = n5 % 2

							if n7 ~= n9 then
								n3 = 52
								n6 = 16
							else
								n3 = 47
							end
						end
					elseif n3 <= 59 then
						if n3 <= 57 then
							if n3 <= 56 then
								tbl2[n] = char(n)
								tbl3[n] = n
								n = (n2 * n + n5) % 256
								n3 = 9
							else
								local tbl5 = {}

								if n2 == 1 then
									n3 = 26
									n2 = tbl5
								else
									n3 = 60
									n4 = tbl5
								end
							end
						elseif n3 <= 58 then
							local v6 = tbl4[2]
							local v7 = tbl4[4]
							local n12 = tbl4[1] + v6
							local flag = v6 <= 0
							local flag2 = not flag
							local flag3 = n12 >= v7
							local flag4 = n12 <= v7
							flag3 = flag and flag3
							flag2 = flag2 and flag4
							flag2 = flag3 or flag2
							tbl4[1] = n12

							if flag2 then
								n3 = 39
								n10 = n12
							else
								n3 = 0
							end
						else
							tbl4 = tbl4[2]
							n3 = 36
							n4 = n2
						end
					elseif n3 <= 61 then
						if n3 <= 60 then
							n3 = n2 == 0 and 3 or 36
						else
							n3 = 62
							n = 0
							n2 = 0
							char = ""
							tbl4 = { #v2 + 0, 0, tbl4, 1, nil }
						end
					elseif n3 <= 62 then
						local v6 = tbl4[4]
						local v7 = tbl4[1]
						local n12 = tbl4[2] + v6
						local flag = v6 <= 0
						local flag2 = not flag
						local flag3 = n12 >= v7
						local flag4 = n12 <= v7
						flag3 = flag and flag3
						flag3 = flag3 or flag2 and flag4
						tbl4[2] = n12

						if flag3 then
							n3 = 46
							n4 = n12
						else
							n3 = 50
						end
					else
						n4 = (n4 - n7) / 2
						n5 = (n5 - n9) / 2
						n7 = n4 % 2
						n9 = n5 % 2

						if n7 ~= n9 then
							n3 = 10
							n6 = 64
						else
							n3 = 6
						end
					end
				end
			end
		end

		fn2(-4566195987090404, 0, "\182\189\"r\131\2\193\154\169:F]\196<\30\20\31\28t\255\216\28\158\13333\215}\183\185\153\21\222؎\143@8\177\27\222W>\242z\251[\219܊\30\227XJ\252\7݂f\229bݯB\22N", nil --[[ the caller's registers ]], 55)
		tbl.SourceMirror = "\182\189\"r\131\2\193\154\169:F]\196<\30\20\31\28t\255\216\28\158\13333\215}\183\185\153\21\222؎\143@8\177\27\222W>\242z\251[\219܊\30\227XJ\252\7݂f\229bݯB\22N"
		tbl.ButtonImage = "rbxassetid://87167480222237"

		tbl.Groups = {
			{ Name = "Main", Icon = "gauge" },
			{ Name = "Farm", Icon = "target" },
			{ Name = "World", Icon = "globe" },
			{ Name = "Shop", Icon = "shopping-cart" },
			{ Name = "Visual", Icon = "monitor" },
			{ Line = true },
			{ Name = "Webhook", Icon = "webhook" },
			{ Name = "Setting", Icon = "settings" },
		}

		tbl.PageGroups = {
			["Status And Server"] = { "Main", "Status", "activity" },
			LocalPlayer = { "Main", "Local Player", "user-round" },
			["Setting Farm"] = { "Farm", "Setting", "sliders-horizontal" },
			["Hold and Select Skill"] = { "Farm", "Skills", "keyboard" },
			Farming = { "Farm", "Farming", "swords" },
			["Stack Farming"] = { "Farm", "Stack", "layers" },
			["Farming Other"] = { "Farm", "Other", "sparkles" },
			["Sea Event"] = { "World", "Sea", "waves" },
			["Fruit and Raid, Dungeon"] = { "World", "Raid", "shield" },
			["Volcano Event"] = { "World", "Volcano", "flame" },
			["Upgrade Race"] = { "World", "Race", "dna" },
			["Get and Upgrade Items"] = { "World", "Items", "package" },
			Shop = { "Shop", "Shop", "shopping-bag" },
			ESP = { "Visual", "ESP", "eye" },
			PVP = { "Visual", "PVP", "crosshair" },
			Webhook = { "Webhook", "Webhook", "send" },
			Setting = { "Setting", "Setting", "wrench" },
		}

		tbl.SectionRoutes = {
			["Status And Server/Server"] = { "Main", "Server", "server" },
			["Farming Other/Secret Quest"] = { "Farm", "Stack", "star" },
			["Farming Other/Mob Farm"] = { "Farm", "Farming", "swords" },
			["Farming Other/Boss Farm"] = { "Farm", "Boss", "skull" },
			["Stack Farming/Elite Hunter"] = { "Farm", "Boss", "skull" },
			["Stack Farming/Rip Indra"] = { "Farm", "Boss", "skull" },
			["Stack Farming/Soul Reaper"] = { "Farm", "Boss", "skull" },
			["Stack Farming/Dough King"] = { "Farm", "Boss", "skull" },
			["Stack Farming/Darkbeard"] = { "Farm", "Boss", "skull" },
			["Fruit and Raid, Dungeon/Join Dungeon"] = { "World", "Dungeon", "door-open" },
			["Fruit and Raid, Dungeon/Dungeon"] = { "World", "Dungeon", "door-open" },
			["Farming Other/Raid Law"] = { "World", "Raid", "shield" },
			["Sea Event/Boat Setting"] = { "World", "Boat", "sailboat" },
		}

		tbl.SubTabOrder = {
			Main = { "Status", "Server", "Local Player" },
			Farm = { "Setting", "Skills", "Farming", "Stack", "Boss", "Other" },
			World = { "Sea", "Boat", "Raid", "Dungeon", "Volcano", "Race", "Items" },
			Shop = { "Shop" },
			Visual = { "ESP", "PVP" },
			Webhook = { "Webhook" },
			Setting = { "Setting" },
		}

		tbl.ConfirmButtons = {
			["Reset Stats"] = "Reset all your stat points?",
			["Reroll Race"] = "Reroll your race? This costs Fragments.",
			["Buy Race Cyborg"] = "Buy Cyborg race?",
			["Buy Race Ghoul"] = "Buy Ghoul race?",
			["Buy Race Draco"] = "Change to Draco race? The Dragon Wizard needs a Dragon Egg.",
			["Teleport To Dungeon Sea [ Dungeon Hub ]"] = "Travel to the Dungeon Hub?",
			["Teleport To First Sea [ Sea 1 ]"] = "Travel to the First Sea?",
			["Teleport To Second Sea [ Sea 2 ]"] = "Travel to the Second Sea?",
			["Teleport To Third Sea [ Sea 3 ]"] = "Travel to the Third Sea?",
			["Reset Config"] = "Turn off every feature and reset all settings to default?",
		}

		VxezeUI = tbl
	end

	VxezeReportError = function(arg, arg2)
		local str = tostring(arg) .. ": " .. tostring(arg2)
		if VxezeUI.Errors[str] then
			return
		end
		VxezeUI.Errors[str] = true
		print("[Vxeze Hub] " .. str)
	end

	VxezeSafe = function(arg, arg2)
		if type(arg2) ~= "function" then
			return nil
		end

		return function(...)
			local ok, result = pcall(arg2, ...)

			if not ok then
				VxezeReportError(arg, result)
			end
		end
	end

	VxezeFetchText = function(arg, arg2)
		local flag = nil
		local v2 = nil

		task.spawn(function()
			local ok, result = pcall(game.HttpGetAsync, game, arg)
			v2 = ok and result or nil
			flag = true
		end)

		local now = tick()

		while true do
			task.wait(0.2)
			local flag2

			if flag then
				flag2 = flag
			else
				flag2 = tick() - now > (arg2 or 15)
			end

			if not flag2 then
				continue
			end
			break
		end

		if type(v2) ~= "string" then
			error("request timed out")
		end

		return v2
	end

	FetchSource = function(arg, arg2)
		local flag = nil
		local v2 = nil

		task.spawn(function()
			local ok, result = pcall(game.HttpGetAsync, game, arg)
			v2 = ok and result or nil
			flag = true
		end)

		local now = tick()

		while true do
			task.wait(0.2)
			local flag2

			if flag then
				flag2 = flag
			else
				flag2 = tick() - now > (arg2 or 20)
			end

			if not flag2 then
				continue
			end
			break
		end

		if type(v2) == "string" and #v2 > 100000 then
			return v2
		end
	end

	VxezeCachePath = "Vxeze Hub/VindUI.luau"

	VxezeReadCache = function()
		if type(isfile) ~= "function" or type(readfile) ~= "function" then
			return nil
		end

		local ok, result = pcall(function()
			if isfile(VxezeCachePath) then
				return readfile(VxezeCachePath)
			end
		end)

		if ok and type(result) == "string" and #result > 100000 then
			return result
		end
	end

	VxezeWriteCache = function(arg)
		if type(writefile) ~= "function" or type(arg) ~= "string" or #arg < 100000 then
			return
		end

		pcall(function()
			if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder("Vxeze Hub") then
				makefolder("Vxeze Hub")
			end

			writefile(VxezeCachePath, arg)
		end)
	end

	VxezeRefreshCacheLater = function()
		task.delay(5, function()
			for _, v2 in ipairs({ VxezeUI.SourceUrl, VxezeUI.SourceMirror }) do
				local v3 = FetchSource(v2, 20)
				if v3 then
					VxezeWriteCache(v3)
					return
				end
			end
		end)
	end

	VxezeLoadUI = function()
		local v2 = VxezeReadCache()

		if v2 then
			local ok, result = pcall(loadstring(v2))
			if ok and result then
				VxezeRefreshCacheLater()
				return result
			end
		end

		local v3 = nil

		for _, v4 in ipairs({ VxezeUI.SourceUrl, VxezeUI.SourceMirror }) do
			v3 = FetchSource(v4, 20)
			if v3 then
				VxezeWriteCache(v3)
				break
			end
		end

		if not v3 then
			require(game:GetService("ReplicatedStorage").Notification).new("<Color=Red>Vxeze Hub : cannot download the interface, check your connection<Color=/>"):Display()
			error("Vxeze Hub could not download its interface")
		end

		return loadstring(v3)()
	end

	VxezeNextId = function(arg)
		local v2 = VxezeUI
		v2.ElementCount = v2.ElementCount + 1
		local str = tostring(arg or "Element")
		local str2 = "_" .. VxezeUI.ElementCount
		return str:gsub("[^%w]", "") .. str2
	end

	VxezeLogLines = {}

	VxezeLog = function(arg, arg2)
		local str = tostring(arg) .. ": " .. tostring(arg2)
		table.insert(VxezeLogLines, os.date("[%H:%M:%S] ") .. str)

		if #VxezeLogLines > 200 then
			table.remove(VxezeLogLines, 1)
		end

		if VxezeUI.Console then
			pcall(function()
				VxezeUI.Console:Log(str)
			end)
		end
	end

	VxezeNotifyIcons = {
		info = "info",
		success = "circle-check",
		warning = "clock",
		error = "circle-x",
		start = "play",
		stop = "square",
		found = "search",
		reward = "gift",
		travel = "map-pin",
	}

	VxezeNotify = function(arg, arg2, arg3, arg4)
		arg3 = arg3 or "info"
		local str

		if arg3 == "start" or arg3 == "found" or arg3 == "travel" then
			str = "info"
		elseif arg3 == "reward" or arg3 == "success" then
			str = "success"
		elseif arg3 ~= "stop" then
			str = arg3
		else
			str = "warning"
		end

		arg4 = arg4 or {}
		VxezeLog(arg, arg2)
		if not VxezeUI.Interface then
			return
		end

		VxezeUI.Interface.CreateNoti({
			Title = "BF - Notification!",
			Desc = tostring(arg) .. ": " .. tostring(arg2),
			SubContent = arg4.SubContent,
			ShowTime = arg4.Duration or 5,
			Repeat = arg4.Repeat,
			Key = arg4.Key or arg .. "|" .. arg2,
			Type = str,
			Icon = arg4.Icon or VxezeNotifyIcons[arg3],
			Color = arg4.Color,
			Actions = arg4.Actions,
		})
	end

	VxezeReadList = function(arg, arg2)
		local tbl = {}
		local tbl2 = {}
		if type(arg) ~= "table" then
			return tbl, tbl2
		end

		if #arg > 0 then
			for _, v2 in ipairs(arg) do
				table.insert(tbl, v2)
			end

			return tbl, tbl2
		end

		for k, v2 in pairs(arg) do
			table.insert(tbl, k)

			if arg2 and v2 == true then
				table.insert(tbl2, k)
			end
		end

		table.sort(tbl, function(arg3, arg4)
			return tostring(arg3) < tostring(arg4)
		end)

		return tbl, tbl2
	end

	VxezeSplitStatus = function(arg)
		local str = tostring(arg or "")
		local match, v2 = str:match("^(.-)%s+:%s+(.*)$")

		if not match then
			match, v2 = str:match("^([^:]-):%s+(.*)$")
		end

		if match and match ~= "" then
			return match, v2
		end
		return str, ""
	end

	VxezeConfirm = function(arg, arg2, arg3)
		VxezeUI.Library:Confirm({
			Title = arg,
			Text = arg2,
			ConfirmText = "Confirm",
			CancelText = "Cancel",
			Window = VxezeUI.Window,
			Callback = function(arg4)
				if arg4 and arg3 then
					arg3()
				end
			end,
		})
	end

	ReleaseTweenPhysics = function()pcall(function()if ComputeNoclip and(ComputeNoclip())then return;end;if TweenRecentlyRequested and(TweenRecentlyRequested())then return;end;if SetNoClip then SetNoClip(false);end;local c=game.Players.LocalPlayer.Character;local n=c and(c:FindFirstChild("HumanoidRootPart"));if n then n.Anchored=false;c=n:FindFirstChild("FloatForce");if c then c:Destroy();end;end;end);end
	VxezeHardStopTween = function()pcall(function()if TweenManager then TweenManager.PauseUntil=math.max(TweenManager.PauseUntil or 0,tick()+0.35);end;if StopTweenNow then StopTweenNow();end;if TweenManager and TweenManager.CancelCurrent then TweenManager.CancelCurrent();end;local c=game.Players.LocalPlayer.Character and(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"));if c then c.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0);c.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0);end;end);end

	VxezeQueue = function(arg, arg2)
		if arg.Built and not arg.Building then
			local ok, result = pcall(arg2)

			if not ok then
				VxezeReportError(arg.Name, result)
			end
		else
			table.insert(arg.Queue, arg2)
		end
	end

	VxezeBuildPage = function(arg, arg2)
		if arg.Built or arg.Building then
			return
		end
		arg.Building = true
		local n = 1
		local n2 = 0

		while n <= #arg.Queue do
			local v2 = arg.Queue[n]
			n += 1
			local ok, result = pcall(v2)

			if not ok then
				VxezeReportError(arg.Name, result)
			end

			n2 += 1

			if arg2 and n2 % arg2 == 0 then
				task.wait()
			end
		end

		arg.Built = true
		arg.Building = false
		table.clear(arg.Queue)
	end

	VxezeBuildAllPages = function()
		for _, page in ipairs(VxezeUI.Pages) do
			if not page.Built then
				VxezeBuildPage(page, 24)
				task.wait()
			end
		end
	end

	VxezePane = function(arg, arg2, lucide)
		local str = arg .. "/" .. arg2
		local v2 = VxezeUI.Panes[str]
		if v2 then
			return v2
		end

		local tbl = {
			Name = str,
			Queue = {},
			Built = false,
			Group = arg,
			Tab = (VxezeUI.Tabs[arg] or VxezeUI.Tabs.Main):AddSubTab({ Name = arg2, Icon = "Lucide:" .. lucide }),
		}

		pcall(function()
			tbl.Tab.Button.MouseButton1Click:Connect(function()
				VxezeBuildPage(tbl)
			end)
		end)

		VxezeUI.Panes[str] = tbl
		table.insert(VxezeUI.Pages, tbl)
		return tbl
	end

	VxezeSectionIcons = {
		["Teleport World"] = "navigation",
		["Misc Shop"] = "shopping-bag",
		["Gun Shop"] = "circle-dot",
		["Sword Shop"] = "slash",
		["Fighting Shop"] = "sword",
		["Abilities Shop"] = "sparkles",
		["Script Check"] = "cpu",
		Status = "activity",
		Server = "server",
		["Local Player"] = "user",
		["Setting Farm"] = "sliders-horizontal",
		["Select Skills"] = "mouse-pointer-click",
		["Hold Skills"] = "hand",
		["Method Farm"] = "route",
		["Mastery Farm"] = "graduation-cap",
		["Material Farm"] = "package",
		["World Unlock"] = "lock-open",
		["Collect Fruits / Chests / Berries"] = "apple",
		["Event Time"] = "timer",
		["Elite Hunter"] = "crosshair",
		["Rip Indra"] = "crown",
		["Soul Reaper"] = "ghost",
		["Dough King"] = "cookie",
		Darkbeard = "skull",
		["Secret Quest"] = "scroll",
		["Magnet Event"] = "magnet",
		Fishing = "fish",
		["Quest Dojo Trainer / Dragon Hunter"] = "flame",
		["Raid Law"] = "scale",
		["Quest Observation"] = "eye",
		["Mob Farm"] = "bug",
		["Boss Farm"] = "shield-alert",
		["Devil Fruit"] = "cherry",
		Raids = "door-open",
		["Multi Raid"] = "layers",
		["Join Dungeon"] = "log-in",
		Dungeon = "castle",
		Setting = "settings-2",
		Farming = "sprout",
		["Kitsune Event"] = "moon",
		["Leviathan Event"] = "waves",
		["Boat Setting"] = "sailboat",
		["Race Draco"] = "feather",
		["Race Normal"] = "users",
		["Race V4"] = "zap",
		["Kill Trial"] = "target",
		["Get Items"] = "gift",
		["Mastery Weapon"] = "medal",
		["Upgrade Weapon"] = "hammer",
		["Settings Volcano"] = "mountain",
		["Farming Volcano"] = "mountain-snow",
		["Fully Volcano"] = "flame-kindling",
		ESP = "scan-eye",
		PVP = "swords",
		["MISC PVP"] = "shield",
		Webhook = "link-2",
		Settings = "cog",
	}

	VxezeBuildSection = function(arg, arg2)
		local v2 = VxezeUI.SectionRoutes[arg.Name .. "/" .. arg2]
		local pane = v2 and VxezePane(v2[1], v2[2], v2[3]) or arg.Pane
		local tbl = {}

		VxezeQueue(pane, function()
			local lucide = VxezeSectionIcons[arg2]
			pane.Tab:AddSection(arg2, lucide and "Lucide:" .. lucide or nil)
			tbl.Section = pane.Tab
		end)

		local tbl2

		tbl2 = {
			CreateToggle = function(arg3, arg4)
				local v3 = VxezeSafe(arg3.Title, arg4)
				local flag = arg3.Default and true or false

				local function fn(arg5, ...)
					local flag2 = flag and not arg5 and ComputeNoclip
					local flag3 = false

					if flag2 then
						local result
						flag3, result = pcall(ComputeNoclip)
						flag3 = flag3 and result == true
					end

					if v3 then
						v3(arg5, ...)
					end

					local flag4 = flag and not arg5
					flag = arg5 and true or false

					if flag4 and flag3 then
						local ok, result = pcall(ComputeNoclip)

						if not (ok and result) then
							VxezeHardStopTween()
							task.delay(0.5, ReleaseTweenPhysics)
						end
					end
				end

				local tbl3 = { value = arg3.Default and true or false }

				local tbl4 = {
					State = tbl3,
					SetStage = function(arg5, arg6)
						local value = arg6 and true or false

						if tbl3.toggle then
							tbl3.toggle:Set(value)
						else
							tbl3.value = value

							if fn then
								task.spawn(fn, value)
							end
						end
					end,
				}

				table.insert(VxezeUI.Toggles, tbl4)

				if fn then
					task.spawn(fn, tbl3.value)
				end

				VxezeQueue(pane, function()
					local flag2 = false

					tbl3.toggle = tbl.Section:AddToggle({
						Flag = VxezeNextId(arg3.Title),
						Text = arg3.Title,
						Description = arg3.Desc,
						Default = tbl3.value,
						Callback = function(value)
							if flag2 then
								tbl3.value = value

								if fn then
									fn(value)
								end
							end
						end,
					})

					flag2 = true
				end)

				return tbl4
			end,
			CreateButton = function(arg3, arg4)
				local v3 = VxezeSafe(arg3.Title, arg4)
				local v4 = VxezeUI.ConfirmButtons[arg3.Title]

				VxezeQueue(pane, function()
					tbl.Section:AddButton({
						Text = arg3.Title,
						Description = arg3.Desc,
						Callback = function()
							if not v3 then
								return
							end

							if v4 then
								VxezeConfirm(arg3.Title, v4, v3)
							else
								v3()
							end
						end,
					})
				end)
			end,
			CreateLabel = function(arg3)
				local tbl3 = {}
				tbl3.text = tostring(arg3.Title or "")

				VxezeQueue(pane, function()
					local v3, v4 = VxezeSplitStatus(tbl3.text)
					local v5 = tbl3
					tbl3.title = v3
					v5.content = v4
					tbl3.paragraph = tbl.Section:AddParagraph({ Title = v3, Text = v4 })
				end)

				return { SetText = function(arg4)
					local text = tostring(arg4)
					if text == tbl3.text then
						return
					end
					tbl3.text = text
					local paragraph = tbl3.paragraph
					if not paragraph then
						return
					end
					local v3, v4 = VxezeSplitStatus(text)

					if v3 ~= tbl3.title then
						tbl3.title = v3
						paragraph:SetTitle(v3)
					end

					if v4 ~= tbl3.content then
						tbl3.content = v4
						paragraph:Set(v4)
					end
				end }
			end,
			CreateBox = function(arg3, arg4)
				local v3 = VxezeSafe(arg3.Title, arg4)
				local tbl3 = {}
				tbl3.value = arg3.Default ~= nil and tostring(arg3.Default) or ""

				VxezeQueue(pane, function()
					tbl.Section:AddTextbox({
						Flag = VxezeNextId(arg3.Title),
						Text = arg3.Title,
						Description = arg3.Desc,
						Default = tbl3.value,
						Placeholder = arg3.Placeholder,
						Numeric = arg3.Number == true,
						Callback = function(value)
							tbl3.value = value

							if v3 then
								v3(value)
							end
						end,
					})
				end)
			end,
			CreateSlider = function(arg3, arg4)
				local v3 = VxezeSafe(arg3.Title, arg4)
				local min = arg3.Min or 0
				local max = arg3.Max or 100
				local n = 10 ^ (arg3.Precise and max - min <= 10 and 1 or 0)
				local tbl3 = {}
				tbl3.value = math.floor(math.clamp(tonumber(arg3.Default) or min, min, max) * n + 0.5) / n

				local tbl4 = {
					State = tbl3,
					SetValue = function(arg5, arg6)
						local value = math.floor(math.clamp(tonumber(arg6) or min, min, max) * n + 0.5) / n

						if tbl3.slider then
							tbl3.slider:Set(value)
						else
							tbl3.value = value

							if v3 then
								task.spawn(v3, value)
							end
						end
					end,
					Get = function()
						return tbl3.value
					end,
				}

				if v3 then
					task.spawn(v3, tbl3.value)
				end

				VxezeQueue(pane, function()
					tbl3.slider = tbl.Section:AddSlider({
						Flag = VxezeNextId(arg3.Title),
						Text = arg3.Title,
						Description = arg3.Desc,
						Min = min,
						Max = max,
						Default = tbl3.value,
						Increment = 1 / n,
						Callback = function(value)
							if value ~= tbl3.value then
								tbl3.value = value

								if v3 then
									v3(value)
								end
							end
						end,
					})
				end)

				return tbl4
			end,
			CreateDropdown = function(arg3, arg4)
				local v3 = VxezeSafe(arg3.Title, arg4)

				if arg3.Slider then
					local v4 = ipairs
					local v5 = VxezeReadList(arg3.List)

					for _, v6 in v4(v5) do
						local v7 = arg3.List[v6]

						tbl2.CreateSlider({
							Title = arg3.Title .. " - " .. tostring(v7.Title),
							Min = v7.Min,
							Max = v7.Max,
							Default = v7.Default,
							Precise = v7.Precise,
						}, function(default)
							v7.Default = default

							if v3 then
								v3(nil, v7)
							end
						end)
					end

					return {}
				end

				local flag = arg3.Selected == true
				local v4, v5 = VxezeReadList(arg3.List, flag)
				local tbl3 = { values = v4, selected = {}, value = arg3.Default }

				for _, v6 in ipairs(v5) do
					tbl3.selected[v6] = true
				end

				VxezeQueue(pane, function()
					local tbl4

					if flag then
						tbl4 = {}

						for _, value in ipairs(tbl3.values) do
							if tbl3.selected[value] then
								table.insert(tbl4, value)
							end
						end
					else
						tbl4 = tbl3.value
					end

					tbl3.dropdown = tbl.Section:AddDropdown({
						Flag = VxezeNextId(arg3.Title),
						Text = arg3.Title,
						Description = arg3.Desc,
						Options = tbl3.values,
						MultiSelect = flag,
						Searchable = arg3.Search == true or #tbl3.values > 12,
						Default = tbl4,
						Callback = function(value)
							if not flag then
								tbl3.value = value

								if v3 then
									v3(value)
								end

								return
							end

							local tbl5 = {}

							if type(value) == "table" then
								for k, v6 in pairs(value) do
									if v6 == true then
										tbl5[k] = true
									elseif type(v6) == "string" then
										tbl5[v6] = true
									end
								end
							end

							for _, value2 in ipairs(tbl3.values) do
								local flag2 = tbl5[value2] == true

								if tbl3.selected[value2] == true ~= flag2 then
									tbl3.selected[value2] = flag2 or nil

									if v3 then
										v3(value2, flag2)
									end
								end
							end
						end,
					})
				end)

				return {
					State = tbl3,
					SetValue = function(arg5, value)
						tbl3.value = value

						if tbl3.dropdown then
							tbl3.dropdown:Set(value)
						elseif v3 then
							task.spawn(v3, value)
						end
					end,
					GetNewList = function(arg5, arg6)
						local v6 = tbl3
						local v7, v8 = VxezeReadList(arg6, flag)
						v6.values = v7

						for _, v9 in ipairs(v8) do
							tbl3.selected[v9] = true
						end

						local dropdown = tbl3.dropdown
						if not dropdown then
							return
						end
						dropdown:SetOptions(tbl3.values)

						if flag then
							local tbl4 = {}

							for _, value in ipairs(tbl3.values) do
								if tbl3.selected[value] then
									table.insert(tbl4, value)
								end
							end

							dropdown:Set(tbl4, true)
						end
					end,
				}
			end,
		}

		return tbl2
	end

	VxezeResetConfig = function()
		for _, toggle in ipairs(VxezeUI.Toggles) do
			if toggle.State.value then
				toggle:SetStage(false)
			end
		end

		task.wait(0.5)
		table.clear(Settings)

		pcall(function()
			if not isfolder(FolderName) then
				makefolder(FolderName)
			end

			writefile(FolderName .. "/" .. SaveFileName, "{}")
		end)
	end

	VxezeCreateFloatingButton = function()
		local CoreGui = game:GetService("CoreGui")

		pcall(function()
			CoreGui = gethui() or CoreGui
		end)

		local vxezeHubButton = CoreGui:FindFirstChild("Vxeze Hub Button")

		if vxezeHubButton then
			vxezeHubButton:Destroy()
		end

		local accent = VxezeUI.Library.Theme.Accent
		local TweenService = game:GetService("TweenService")
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "Vxeze Hub Button"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.DisplayOrder = 999
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		local frame = Instance.new("Frame")
		frame.Name = "Ring"
		frame.Size = UDim2.fromOffset(46, 46)
		frame.Position = UDim2.fromOffset(tonumber(Settings["Interface Button X"]) or 40, tonumber(Settings["Interface Button Y"]) or 160)
		frame.BackgroundColor3 = accent
		frame.BorderSizePixel = 0
		frame.Parent = screenGui
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(1, 0)
		uiCorner.Parent = frame
		local imageButton = Instance.new("ImageButton")
		imageButton.Name = "Button"
		imageButton.Size = UDim2.new(1, -2, 1, -2)
		imageButton.Position = UDim2.fromScale(0.5, 0.5)
		imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
		imageButton.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
		imageButton.BackgroundTransparency = 0.1
		imageButton.Image = VxezeUI.ButtonImage
		imageButton.AutoButtonColor = false
		imageButton.Parent = frame
		local uiCorner2 = Instance.new("UICorner")
		uiCorner2.CornerRadius = UDim.new(1, 0)
		uiCorner2.Parent = imageButton
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Thickness = 1
		uiStroke.Color = accent
		uiStroke.Transparency = 0.35
		uiStroke.Parent = frame
		screenGui.Parent = CoreGui
		VxezeUI.FloatingButton = { Gui = screenGui, Frame = frame, Icon = imageButton, Stroke = uiStroke }

		VxezeUI.Library.ThemeChanged.Connect(function(arg)
			local tbl = { BackgroundColor3 = arg.Accent }
			TweenService:Create(frame, TweenInfo.new(0.18), tbl):Play()
			local tbl2 = { Color = arg.Accent }
			TweenService:Create(uiStroke, TweenInfo.new(0.18), tbl2):Play()
		end)

		local UserInputService = game:GetService("UserInputService")
		local v2 = nil
		local position = nil
		local position2 = nil
		local flag = false

		imageButton.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			v2 = input
			position = input.Position
			position2 = frame.Position
			flag = false
		end)

		UserInputService.InputChanged:Connect(function(...) end)

		UserInputService.InputEnded:Connect(function(input)
			if not v2 or input.UserInputType ~= v2.UserInputType then
				return
			end
			v2 = nil

			if flag then
				SaveSettings("Interface Button X", frame.Position.X.Offset)
				SaveSettings("Interface Button Y", frame.Position.Y.Offset)
				return
			end

			VxezeUI.Window:ToggleVisibility()
		end)

		imageButton.MouseEnter:Connect(function()
			TweenService:Create(frame, TweenInfo.new(0.12), { Size = UDim2.fromOffset(50, 50) }):Play()
			TweenService:Create(uiStroke, TweenInfo.new(0.12), { Transparency = 0.1 }):Play()
		end)

		imageButton.MouseLeave:Connect(function()
			TweenService:Create(frame, TweenInfo.new(0.18), { Size = UDim2.fromOffset(46, 46) }):Play()
			TweenService:Create(uiStroke, TweenInfo.new(0.18), { Transparency = 0.35 }):Play()
		end)
	end

	VxezeBindToggleKey = function(toggleKey)
		VxezeUI.ToggleKey = toggleKey or Enum.KeyCode.LeftControl
		if VxezeUI.ToggleConnection then
			return
		end
		local UserInputService = game:GetService("UserInputService")
		VxezeUI.ToggleConnection = UserInputService.InputBegan:Connect(function(n)if n.UserInputType~=Enum.UserInputType.Keyboard then return;end;if n.KeyCode~=VxezeUI.ToggleKey or( UserInputService :GetFocusedTextBox())then return;end;if tick()-(VxezeUI.ToggleAt or 0)<0.35 then return;end;VxezeUI.ToggleAt=tick();if VxezeUI.Window then VxezeUI.Window:ToggleVisibility();end;end)
	end

	VxezeShowWindow = function()
		local window = VxezeUI.Window

		if window and not VxezeUI.Shown then
			VxezeUI.Shown = true
			window:Open()
		end
	end

	VxezeBuildInterfaceSection = function()
		local library = VxezeUI.Library
		local tab = VxezeUI.SettingPage.Tab
		tab:AddSection("Interface", "Lucide:palette")

		tab:AddDropdown({
			Flag = "InterfaceTheme",
			Text = "Theme",
			Description = "Change the interface theme",
			Options = library:GetThemeNames(),
			Default = Settings["Interface Theme"] or library.ThemeName,
			Callback = function(arg)
				if arg then
					library:SetTheme(arg)
					SaveSettings("Interface Theme", arg)
				end
			end,
		})

		tab:AddToggle({
			Flag = "InterfaceAcrylic",
			Text = "Acrylic",
			Description = "Blur background, needs graphics quality 8+",
			Default = Settings["Interface Acrylic"] ~= false,
			Callback = function(arg)
				library:SetBlurEnabled(arg)
				SaveSettings("Interface Acrylic", arg)
			end,
		})

		tab:AddToggle({
			Flag = "InterfaceTransparency",
			Text = "Liquid Glass",
			Description = "Frosted surfaces instead of flat ones",
			Default = Settings["Interface Transparency"] ~= false,
			Callback = function(arg)
				library:SetLiquidGlass(arg)
				SaveSettings("Interface Transparency", arg)
			end,
		})

		if library.SetAutoScale then
			tab:AddToggle({
				Flag = "InterfaceAutoScale",
				Text = "Interface Scale [ Scan ]",
				Description = "Measures your screen: fits the menu to a small or maximised game window, grows it in full tab and suits phones. Turn off to use the slider",
				Default = Settings["Interface Auto Scale"] ~= false,
				Callback = function(arg)
					library:SetAutoScale(arg)
					SaveSettings("Interface Auto Scale", arg)
				end,
			})
		end

		tab:AddSlider({
			Flag = "InterfaceScale",
			Text = "Interface Scale",
			Description = "Size of the whole menu (used when Auto Interface Scale is off)",
			Min = 70,
			Max = 140,
			Increment = 5,
			Suffix = " %",
			Default = tonumber(Settings["Interface Scale"]) or 100,
			Callback = function(arg)
				library:SetUIScale(arg / 100)
				SaveSettings("Interface Scale", arg)
			end,
		})

		tab:AddToggle({
			Flag = "InterfaceFloatingButton",
			Text = "Floating Button",
			Description = "Show the round button to open / close the menu",
			Default = Settings["Interface Floating Button"] ~= false,
			Callback = function(enabled)
				SaveSettings("Interface Floating Button", enabled)
				local floatingButton = VxezeUI.FloatingButton

				if floatingButton and floatingButton.Gui.Parent then
					floatingButton.Gui.Enabled = enabled
				end
			end,
		})

		tab:AddKeybind({
			Flag = "InterfaceMinimize",
			Text = "Minimize Bind",
			Description = "Key to open / close the menu",
			Default = Enum.KeyCode[Settings["Interface Minimize Key"] or "LeftControl"] or Enum.KeyCode.LeftControl,
			Callback = function(arg, arg2)
				if arg and arg2 ~= "press" then
					VxezeBindToggleKey(arg)
					SaveSettings("Interface Minimize Key", arg.Name)
				end
			end,
		})

		tab:AddDivider()
		tab:AddSection("Config Files", "Lucide:folder")
		local str = ""
		local v2 = nil

		local function fn()
			local v3 = library:ListConfigs()

			if v2 then
				v2:SetOptions(v3)
			end

			return v3
		end

		tab:AddTextbox({
			Flag = "ConfigName",
			Text = "Config name",
			Description = "Name used when saving",
			Placeholder = "my-setup",
			Callback = function(arg)
				str = arg
			end,
		})

		v2 = tab:AddDropdown({
			Flag = "ConfigPick",
			Text = "Saved configs",
			Description = "Pick one to load or delete",
			Options = library:ListConfigs(),
		})

		tab:AddButton({
			Text = "Save config",
			Description = "Writes every control's value under that name",
			Icon = "Lucide:save",
			Callback = function()
				local str2 = str ~= "" and str or "config-" .. os.date("%d%m-%H%M")
				local v3, v4 = library:SaveConfig(str2)
				VxezeLog("Config", v3 and "saved " .. str2 or "save failed: " .. tostring(v4))
				fn()
			end,
		})

		tab:AddButton({
			Text = "Load config",
			Description = "Applies the selected file",
			Icon = "Lucide:folder-open",
			Callback = function()
				local v3 = v2:Get()
				if not v3 or v3 == "" then
					return
				end
				local v4, v5 = library:LoadConfig(v3)
				VxezeLog("Config", v4 and "loaded " .. v3 or "load failed: " .. tostring(v5))
			end,
		})

		tab:AddButton({
			Text = "Delete config",
			Description = "Removes the selected file",
			Icon = "Lucide:trash-2",
			Callback = function()
				local v3 = v2:Get()
				if not v3 or v3 == "" then
					return
				end
				library:DeleteConfig(v3)
				VxezeLog("Config", "deleted " .. v3)
				fn()
			end,
		})

		tab:AddDivider()
		tab:AddSection("Activity Log", "Lucide:terminal")
		VxezeUI.Console = tab:AddConsole({ Height = 190, MaxLogs = 200, AutoCapture = false, Title = "Hub Log" })

		for _, v3 in ipairs(VxezeLogLines) do
			pcall(function()
				local console = VxezeUI.Console
				local log = console.Log
				local v4 = console
				local str2 = v3:gsub("^%[%d+:%d+:%d+%] ", "")
				log(v4, str2)
			end)
		end

		tab:AddButton({
			Text = "Clear log",
			Icon = "Lucide:eraser",
			Callback = function()
				table.clear(VxezeLogLines)
				VxezeUI.Console:Clear()
			end,
		})

		tab:AddButton({
			Text = "Copy log",
			Description = "Puts the whole log on the clipboard",
			Icon = "Lucide:clipboard",
			Callback = function()
				if setclipboard then
					setclipboard(table.concat(VxezeLogLines, "\n"))
					VxezeLog("Config", "log copied")
				end
			end,
		})
	end

	CreateVxezeInterface = function()
		local v2 = VxezeLoadUI()
		VxezeUI.Library = v2
		VxezeUI.Pages = {}
		VxezeUI.Toggles = {}
		v2:PreloadIcons({ "Lucide" })

		if Settings["Interface Theme"] then
			pcall(function()
				v2:SetTheme(Settings["Interface Theme"], true)
			end)
		end

		local interface = { Library = v2, Options = v2.Flags }
		VxezeUI.Interface = interface

		interface.CreateNoti = function(arg)
			local str = tostring(arg.Desc or "")
			local n = tonumber(arg.ShowTime) or 5
			local now = os.clock()
			local key = arg.Key or str
			local flag = VxezeUI.RecentNotify[key]

			if flag then
				flag = now - VxezeUI.RecentNotify[key] < (arg.Repeat or n)
			end

			if flag then
				return
			end
			VxezeUI.RecentNotify[key] = now

			v2:Notify({
				Title = "BF - Notification!",
				Text = arg.SubContent and str .. "\n" .. tostring(arg.SubContent) or str,
				Duration = n,
				Type = arg.Type,
				Icon = arg.Icon,
				Color = arg.Color,
				Actions = arg.Actions,
			})
		end

		interface.CreateMain = function()
			local v3 = VxezeUI
			local v4 = v2
			local createWindow = v4.CreateWindow

			local tbl = {
				Title = "Vxeze Hub" .. (getgenv().Premium and " [ Premium ]" or " [ Free ]"),
				Subtitle = "True v2",
				Size = UDim2.fromOffset(640, 470),
			}

			tbl.MinSize = Vector2.new(480, 360)
			tbl.TabWidth = 118
			tbl.Resizable = true
			tbl.Draggable = true
			tbl.UseBlur = Settings["Interface Acrylic"] ~= false
			tbl.ToggleKeybind = false
			v3.Window = createWindow(v4, tbl)
			VxezeBindToggleKey(Enum.KeyCode[Settings["Interface Minimize Key"] or "LeftControl"])
			VxezeUI.Window:Close()
			task.delay(20, VxezeShowWindow)
			VxezeUI.Tabs = {}
			VxezeUI.Panes = {}

			for _, group in ipairs(VxezeUI.Groups) do
				if group.Line then
					VxezeUI.Window:AddTabLine()
				else
					VxezeUI.Tabs[group.Name] = VxezeUI.Window:AddTab({ Name = group.Name, Icon = "Lucide:" .. group.Icon })
				end
			end

			VxezeUI.SubTabIcons = {}

			for _, pageGroup in pairs(VxezeUI.PageGroups) do
				VxezeUI.SubTabIcons[pageGroup[1] .. "/" .. pageGroup[2]] = pageGroup[3]
			end

			for _, sectionRoute in pairs(VxezeUI.SectionRoutes) do
				VxezeUI.SubTabIcons[sectionRoute[1] .. "/" .. sectionRoute[2]] = sectionRoute[3]
			end

			for k, v5 in pairs(VxezeUI.SubTabOrder) do
				for _, v6 in ipairs(v5) do
					VxezePane(k, v6, VxezeUI.SubTabIcons[k .. "/" .. v6] or "circle")
				end
			end

			return { CreatePage = function(arg)
				local pageName = arg.Page_Name
				local tbl2 = VxezeUI.PageGroups[pageName] or { "Main", pageName, "circle" }
				local v5 = VxezePane(tbl2[1], tbl2[2], tbl2[3])

				if pageName == "Setting" then
					VxezeUI.SettingPage = v5
				end

				return { CreateSection = function(arg2)
					return VxezeBuildSection({ Name = pageName, Pane = v5 }, arg2)
				end }
			end }
		end

		interface.Finish = function()
			if VxezeUI.SettingPage and not VxezeUI.SettingSectionQueued then
				VxezeUI.SettingSectionQueued = true
				VxezeQueue(VxezeUI.SettingPage, VxezeBuildInterfaceSection)
			end

			if VxezeUI.Finished then
				return
			end
			VxezeUI.Finished = true
			local v3 = VxezeUI.Pages[1]

			if v3 then
				VxezeBuildPage(v3)
			end

			VxezeUI.Window:AddDefaultCreditsPanel({
				Title = "Credits",
				Credits = { { Name = "_ngtinhcuae", Text = "Fouder Vxeze Hub", Image = "rbxassetid://134389506275073" } },
			})

			VxezeUI.Window:SelectTab(1)
			VxezeShowWindow()
			VxezeCreateFloatingButton()
			VxezeUI.FloatingButton.Gui.Enabled = Settings["Interface Floating Button"] ~= false

			v2:Notify({
				Title = "BF - Notification!",
				Text = "Vxeze Hub loaded, press the button or LeftControl to hide",
				Type = "success",
				Duration = 5,
			})

			task.spawn(VxezeBuildAllPages)
		end

		return interface
	end

	local v2
	v2 = CreateVxezeInterface()
	Main = v2.CreateMain()
	v2.Finish()
	PageShop = Main.CreatePage({ Page_Name = "Shop", Page_Title = "Shop" })
	local options = v2.Options
	getgenv().Options = options
	ElementCollection = {}

	SpecDefault = function(arg)
		if arg.Default ~= nil then
			return arg.Default
		end

		if arg.Key then
			local v3 = Settings[arg.Key]
			if v3 ~= nil then
				return v3
			end
		end

		return arg.Fallback
	end

	CancelTweenIfIdle = function()if ToggleNoclip()then return;end;StopTweenNow();TweenManager.CancelCurrent();SetNoClip(false);end

	ApplySpec = function(arg, arg2, arg3)
		if arg.Key then
			SaveSettings(arg.Key, arg2, arg3)
		end

		if arg.OnChange then
			arg.OnChange(arg2, arg3)
		end
	end

	BuildElement = function(c,n,L)local U=if L.Mode=="Toggle"then(c.CreateToggle({Title=L.Title,Desc=L.Desc,Default=SpecDefault(L)},function(w)if w and L.Require then local y,S=L.Require();if not y then if L.Key then SaveSettings(L.Key,false);end;local y=ElementCollection[n]and ElementCollection[n][L.Title];if y and y.SetStage then y:SetStage(false);end;VxezeNotify(L.Title,S or"Cannot turn this on right now","warning",{Key="require"..L.Title});return;end;end;if w and L.SoftRequire then local y,S=L.SoftRequire();if not y then VxezeNotify(L.Title,S or"This might not work right now","warning",{Key="softrequire"..L.Title});end;end;ApplySpec(L,w);end))else if L.Mode=="Slider"then(c.CreateSlider({Title=L.Title,Desc=L.Desc,Min=L.Min,Max=L.Max,Default=SpecDefault(L),Precise=L.Precise~=false},function(w)ApplySpec(L,w);end))else if L.Mode=="Dropdown"then(c.CreateDropdown({Title=L.Title,Desc=L.Desc,List=if type(L.List)=="function"then(L.List())else L.List,Search=L.Search or false,Selected=L.Multi or false,Default=SpecDefault(L)},function(w,y)ApplySpec(L,w,y);end))else if L.Mode=="Button"then(c.CreateButton({Title=L.Title,Desc=L.Desc},function()if L.OnChange then L.OnChange();end;end))else if L.Mode=="Label"then(c.CreateLabel({Title=L.Title}))else nil;ElementCollection[n]=ElementCollection[n]or{};ElementCollection[n][L.Title]=U;return U;end
	BuildPanel = function(c,n,L)getgenv().PanelFailures=getgenv().PanelFailures or{};for U,U in ipairs(L)do local L,w=pcall(BuildElement,c,n,U);if not L then table.insert(getgenv().PanelFailures,tostring(U.Title).." -> "..tostring(w));VxezeReportError(U.Title or n,w);end;end;return ElementCollection[n];end

	Remote = function(arg, arg2, arg3)
		if not arg and arg3 then
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer(arg2, true)
		else
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer(arg, arg2, arg3)
		end
	end

	GoToSea = function(arg)
		if Place_Id["sea" .. arg]() then
			return true
		end
		local str

		if arg == 3 then
			str = "TravelZou"
		elseif arg == 2 then
			str = "TravelDressrosa"
		else
			str = "TravelMain"
		end

		game.ReplicatedStorage.Remotes.CommF_:InvokeServer(str)
		task.wait(5)
		return false
	end

	FruitStockCache = { data = nil, time = 0, loading = false }

	GetFruitsData = function(arg)
		if FruitStockCache.loading then
			repeat
				task.wait(0.1)
			until not FruitStockCache.loading
		end

		local flag = not FruitStockCache.data
		local flag2

		if flag then
			flag2 = flag
		else
			local time_ = FruitStockCache.time
			flag2 = tick() - time_ > (arg or 10)
		end

		if flag2 then
			FruitStockCache.loading = true

			local ok, data = pcall(function()
				return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false)
			end)

			FruitStockCache.loading = false

			if ok and type(data) == "table" then
				local v3 = FruitStockCache
				local v4 = FruitStockCache
				local now = tick()
				v3.data = data
				v4.time = now
			end
		end

		return FruitStockCache.data or {}
	end

	getgenv().tablefruitausea3 = {}
	whitelistedfruit = {}
	TableDevilFruit = {}

	LoadFruitTables = function()
		local v3 = next
		local v4, v5 = GetFruitsData(60)

		for _, v6 in v3, v4, v5 do
			if v6.Price >= 1000000 then
				table.insert(whitelistedfruit, string.split(v6.Name, "-")[1] .. " Fruit")
				local name_ = v6.Name
				local price = v6.Price
				getgenv().tablefruitausea3[name_] = price
			end

			TableDevilFruit[v6.Name] = false
		end

		getgenv().tablefruitausea3["Dragon (East)-Dragon (East)"] = 15000000
		getgenv().tablefruitausea3["Dragon (West)-Dragon (West)"] = 15000000

		if SniperShopDropdown then
			SniperShopDropdown:GetNewList(PrepareMultiSelectList(TableDevilFruit, Settings["Blox Fruit Sniper Shop"]))
		end
	end

	task.spawn(LoadFruitTables)
	ItemId = require(game.ReplicatedStorage.Economy.ItemId)

	CheckFruitReal = function(arg)
		local v3 = next
		local v4, v5 = GetFruitsData(60)

		for _, v6 in v3, v4, v5 do
			if v6.Name == arg then
				return v6
			end
		end
	end

	SkinFruit = {}

	spawn(function()
		local ok, result = pcall(function()
			return require(game:GetService("ReplicatedStorage").Modules.SkinUtil.FruitSkins)
		end)

		if not ok then
			return
		end

		for _, v3 in next, result.Grouped, nil do
			for _, v4 in next, v3, nil do
				local storageName = v3.StorageName
				getgenv().tablefruitausea3[storageName] = CheckFruitReal(v4.Item).Price
				table.insert(whitelistedfruit, v4.StorageName .. " Fruit")
				SkinFruit[v4.StorageName .. " Fruit"] = true
			end
		end
	end)

	SeaTravelRemote = { "TravelMain", "TravelDressrosa", "TravelZou" }

	MaterialMobs = {
		["Angel Wings"] = { { "God's Guard", "Shanda", "Royal Squad", "Royal Soldier", "Wysper", "Thunder God" } },
		Leather = {
			{ "Pirate", "Brute" },
			{ "Marine Captain" },
			{ "Jungle Pirate", "Forest Pirate", "Musketeer Pirate" },
		},
		["Scrap Metal"] = { { "Pirate", "Brute" }, { "Marine Captain" }, { "Jungle Pirate", "Forest Pirate" } },
		["Magma Ore"] = { { "Military Soldier", "Military Spy", "Magma Admiral" }, { "Magma Ninja", "Lava Pirate" } },
		["Fish Tail"] = {
			{ "Fishman Warrior", "Fishman Commando", "Fishman Lord" },
			[3] = { "Fishman Raider", "Fishman Captain" },
		},
		Ectoplasm = { [2] = { "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer", "Cursed Captain" } },
		["Mystic Droplet"] = { [2] = { "Water Fighter", "Sea Soldier" } },
		["Radioactive Material"] = { [2] = { "Factory Staff" } },
		["Vampire Fang"] = { [2] = { "Vampire" } },
		["Conjured Cocoa"] = { [3] = { "Chocolate Bar Battler", "Cocoa Warrior" } },
		["Dragon Scale"] = { [3] = { "Dragon Crew Archer", "Dragon Crew Warrior" } },
		Gunpowder = { [3] = { "Pistol Billionaire" } },
		["Mini Tusk"] = { [3] = { "Mythological Pirate" } },
		Bones = { [3] = { "Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy" } },
		["Demonic Wisp"] = { [3] = { "Demonic Soul", "Reborn Skeleton", "Living Zombie", "Posessed Mummy" } },
		["Nightmare Catcher"] = { [3] = { "Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy" } },
	}

	GetMaterialMobs = function(arg)
		local v3 = MaterialMobs[arg]
		if not v3 then
			return nil, nil
		end
		local v4 = GetCurrentSea()
		if v3[v4] then
			return v3[v4], nil
		end

		for _, v5 in ipairs({ 3, 2, 1 }) do
			if v3[v5] then
				return nil, v5
			end
		end
	end

	TableMaterials = {}

	for k in next, MaterialMobs, nil do
		table.insert(TableMaterials, k)
	end

	table.sort(TableMaterials)
	RedeemCodeBusy = false
	RedeemSaveFile = "Vxeze Hub/RedeemedCodes.json"

	RedeemLoadDone = function()
		local ok, result = pcall(function()
			return game:GetService("HttpService"):JSONDecode(readfile(RedeemSaveFile))
		end)

		return ok and type(result) == "table" and result or {}
	end

	RedeemSaveDone = function(arg)
		pcall(function()
			if type(isfolder) == "function" and not isfolder("Vxeze Hub") then
				makefolder("Vxeze Hub")
			end

			writefile(RedeemSaveFile, game:GetService("HttpService"):JSONEncode(arg))
		end)
	end

	RedeemFetchWiki = function()
		local tbl = {}

		local ok, result = pcall(function()
			local HttpService_ = game:GetService("HttpService")
			local jsonDecode = HttpService_.JSONDecode

			local v3 = VxezeFetchText
			;(nil --[[ constant not decoded ]])(-1643122249081406, 0, "Rs\130\143\149\220Y{Y-\248\31<\250\248\21#\147R\146\251UgH\137\133\3\21814H\158щ7\172\255\133\169\0279\\\146\203\205UY\255\170\214\207\222\202de\t\147\185'/\220\12\139Q\158d\228\131\237} \140\6\129[$\150^\213J$&q\187\246y\187\220", nil --[[ the caller's registers ]], 10)
			return jsonDecode(HttpService_, v3("Rs\130\143\149\220Y{Y-\248\31<\250\248\21#\147R\146\251UgH\137\133\3\21814H\158щ7\172\255\133\169\0279\\\146\203\205UY\255\170\214\207\222\202de\t\147\185'/\220\12\139Q\158d\228\131\237} \140\6\129[$\150^\213J$&q\187\246y\187\220"))
		end)

		if ok and result and result.parse then
			for match in result.parse.wikitext["*"]:gmatch("<code>([A-Za-z0-9_]+)</code>") do
				table.insert(tbl, match)
			end
		end

		return tbl
	end

	RedeemFetchGuide = function()
		local tbl = {}

		local ok, result = pcall(function()
			local v3 = VxezeFetchText
			;(nil --[[ constant not decoded ]])(2900941407174474, 0, "\223?\233ǉ\143\225}\138ث\148\248}\180mՃc\228Y2y\15\215\248\238\20\145~\235L\227li|\183r\151K[\149-O\143\0318\139\221>\202\21U\25\3\157\147_\16\206)\240\249\251'\235\221C&\218e\181\173\207\223@\2405,\20\236z\255\22\190\1d\5.A\25\175\0\172\214\3", nil --[[ the caller's registers ]], 5)
			return v3("\223?\233ǉ\143\225}\138ث\148\248}\180mՃc\228Y2y\15\215\248\238\20\145~\235L\227li|\183r\151K[\149-O\143\0318\139\221>\202\21U\25\3\157\147_\16\206)\240\249\251'\235\221C&\218e\181\173\207\223@\2405,\20\236z\255\22\190\1d\5.A\25\175\0\172\214\3")
		end)

		if ok and type(result) == "string" then
			for match in result:gmatch("<td[^>]*>%s*([A-Za-z][A-Za-z0-9_]-)%s*</td>") do
				if #match >= 2 and #match <= 40 then
					table.insert(tbl, match)
				end
			end
		end

		return tbl
	end

	do
		local tbl = {}

		local function fn(arg, arg2, arg3, arg4, arg5)
			local tbl2 = {}
			local tbl3 = {}
			local n = arg
			local n2 = arg2
			local v3 = arg3
			local v4 = arg4
			local v5 = arg5
			local n3 = 1
			local tbl4 = nil
			local v6 = nil
			local char = nil
			local byte = nil
			local n4 = nil
			local n5 = nil
			local n6 = nil
			local n7 = nil
			local n8 = nil
			local n9 = nil
			local n10 = nil
			local n11 = nil

			while true do
				if n3 <= 31 then
					if n3 <= 15 then
						if n3 <= 7 then
							if n3 <= 3 then
								if n3 <= 1 then
									if n3 <= 0 then
										tbl4 = tbl4[5]
										n3 = 38
									else
										char = string.char
										byte = string.byte

										if n2 == 2 then
											n3 = 36
											n4 = n
										else
											n3 = 57
										end
									end
								elseif n3 <= 2 then
									tbl4 = tbl4[1]
									n3 = 32
								else
									n3 = 24
									n2 = 4225628066614523
									n5 = 1640726024911297
									n6 = 4503599627370496
									n7 = 67108864
									n8 = 17592186044416
									n9 = 66262169
									n10 = 66419657
									tbl4 = { tbl4, 4, 1, 0, nil }
								end
							elseif n3 <= 5 then
								if n3 <= 4 then
									n4 = (n4 - n7) / 2
									n5 = (n5 - n9) / 2
									n7 = n4 % 2
									n9 = n5 % 2

									if n7 ~= n9 then
										n3 = 11
										n6 = 4
									else
										n3 = 7
									end
								else
									tbl4 = tbl4[1]
									n3 = 27
								end
							elseif n3 <= 6 then
								n4 = (n4 - n7) / 2
								n5 = (n5 - n9) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 12
									n6 = 128
								else
									n3 = 35
								end
							else
								n4 = (n4 - n7) / 2
								n5 = (n5 - n9) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 18
									n6 = 8
								else
									n3 = 55
								end
							end
						elseif n3 <= 11 then
							if n3 <= 9 then
								if n3 <= 8 then
									local n12 = n4 * 2 + 1
									local v7 = n5[n12]
									local v8 = n5[n12 + 1]

									if not v7 then
										n3 = 40
									else
										n3 = 37
										n6 = v7
										n7 = v8
									end
								else
									local v7 = tbl4[3]
									local v8 = tbl4[5]
									local n12 = tbl4[2] + v7
									local flag = v7 <= 0
									local flag2 = not flag
									local flag3 = n12 >= v8
									local flag4 = n12 <= v8
									flag = flag and flag3
									flag2 = flag2 and flag4
									flag2 = flag or flag2
									tbl4[2] = n12

									if flag2 then
										n3 = 56
										n6 = n12
									else
										n3 = 54
									end
								end
							elseif n3 <= 10 then
								n8 += n6
								n3 = 6
							else
								n8 += n6
								n3 = 7
							end
						elseif n3 <= 13 then
							if n3 <= 12 then
								n8 += n6
								n3 = 35
							else
								local v7 = tbl4[5]
								local v8 = tbl4[4]
								local n12 = tbl4[2] + v7
								local flag = v7 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v8
								local flag4 = n12 <= v8
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[2] = n12

								if flag3 then
									n3 = 16
								else
									n3 = 2
								end
							end
						elseif n3 <= 14 then
							tbl4 = tbl4[2]
							n3 = 36
						else
							n8 += n6
							n3 = 63
						end

						continue
					end

					if n3 <= 23 then
						if n3 <= 19 then
							if n3 <= 17 then
								if n3 <= 16 then
									n4 = (n6 * n4 + n7) % 4294967296
									n11 ..= n8[1 + (n4 - n4 % 268435456) / 268435456 % 16]
									n3 = 13
									continue
								end

								return nil
							end

							if n3 <= 18 then
								n8 += n6
								n3 = 55
							else
								n = (n + tbl3[n2] + n4[n2 % 32 + 1]) % 256
								local v7 = tbl3[n2]
								tbl3[n2] = tbl3[n]
								tbl3[n] = v7
								n3 = 25
							end

							continue
						end

						if n3 <= 21 then
							if n3 <= 20 then
								local v7 = tbl4[1]
								local v8 = tbl4[5]
								local n12 = tbl4[4] + v7
								local flag = v7 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v8
								local flag4 = n12 <= v8
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[4] = n12

								if flag3 then
									n3 = 8
									n4 = n12
								else
									n3 = 59
								end
							else
								n3 = 25
								n = 0
								tbl4 = { 1, 255, nil, -1, tbl4 }
							end
						elseif n3 <= 22 then
							n[n4] = n6
							n[52] = 4
							n[99] = 12
							n[51] = 3
							n[65] = 10
							n[48] = 0
							n[101] = 14
							n[54] = 6
							n3 = 28
							n4 = 49
							n6 = 1
						else
							n = (n - n11) / 65536
							local n12 = (n2 + n11) % n6
							local n13 = n12 % n7
							n2 = ((((n12 - n13) / n7 * n9 + n13 * n10) % n7 * n7 + n13 * n9) % n6 + n5) % n6
							n3 = 24
						end

						continue
					end

					if n3 <= 27 then
						if n3 <= 25 then
							if n3 <= 24 then
								local v7 = tbl4[3]
								local v8 = tbl4[2]
								local n12 = tbl4[4] + v7
								local flag = v7 <= 0
								local flag2 = flag and n12 >= v8 or not flag and n12 <= v8
								tbl4[4] = n12

								if flag2 then
									n3 = 31
									n11 = n12
								else
									n3 = 5
								end
							else
								local v7 = tbl4[1]
								local v8 = tbl4[2]
								local n12 = tbl4[4] + v7
								local flag = v7 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v8
								local flag4 = n12 <= v8
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[4] = n12

								if flag3 then
									n3 = 19
									n2 = n12
								else
									n3 = 51
								end
							end
						elseif n3 <= 26 then
							n5 = {}
							n8 = { "6", "4", "e", "a", "5", "8", "d", "2", "1", "9", "3", "7", "c", "f", "b", "0" }
							n3 = 58
							n4 = 870728320
							n6 = 493413649
							n7 = -405362667
							n9 = 1
							tbl4 = { 0, 1, nil, 128, tbl4 }
						else
							n3 = 49
							tbl4 = { nil, tbl4, 1, 32, 0 }
						end
					elseif n3 <= 29 then
						if n3 <= 28 then
							n[n4] = n6
							n[100] = 13
							n[56] = 8
							n[97] = 10
							n[69] = 14
							n[66] = 11
							n[57] = 9
							n3 = 20
							tbl4 = { 1, tbl4, nil, -1, 31 }
						else
							n8 += n6
							n3 = 4
						end
					elseif n3 <= 30 then
						n2[n4 + 1] = n[n6] * 16 + n[n7]
						n3 = 20
					else
						n11 = n % 65536
						n3 = n11 < 0 and 53 or 45
					end
				else
					if n3 <= 47 then
						if n3 <= 39 then
							if n3 <= 35 then
								if n3 <= 33 then
									if n3 <= 32 then
										byte(n11, 1, 64)
										n3 = n10 == n9 and 34 or 58
									else
										local n12 = n2 % n7
										n2 = ((((n2 - n12) / n7 * n9 + n12 * n10) % n7 * n7 + n12 * n9) % n6 + n5) % n6
										n4[n] = (n2 - n2 % n8) / n8
										n3 = 49
									end
								elseif n3 <= 34 then
									n5 = { byte(n, 1, 64) }
									n3 = 58
								else
									char ..= tbl2[n8]
									n3 = 62
								end
							elseif n3 <= 37 then
								if n3 <= 36 then
									n = n4[3]
									n2 = 4 * n4[1] % 64 + 1
									n5 = 2 * n4[2] % 128 - 1
									n3 = 9
									tbl4 = { nil, -1, 1, tbl4, 255 }
								else
									n3 = not n7 and 17 or 30
								end
							elseif n3 <= 38 then
								n = { [53] = 5, [70] = 15, [68] = 13, [55] = 7, [67] = 12, [50] = 2, [102] = 15 }
								n3 = 22
								n4 = 98
								n6 = 11
							else
								n3 = 13
								n11 = ""
								tbl4 = { tbl4, 0, nil, 64, 1 }
							end

							continue
						end

						if n3 <= 43 then
							if n3 <= 41 then
								if n3 <= 40 then
									return nil
								end
								v4[v5] = char
								n3 = 44
								continue
							end

							if n3 <= 42 then
								n11 -= 65536
								n3 = 23
							else
								n4 = (n4 - n6) / 2
								n5 = (n5 - n7) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 29
									n6 = 2
								else
									n3 = 4
								end
							end

							continue
						end

						if n3 <= 45 then
							if n3 <= 44 then
								break
							end
							n3 = n11 >= 65536 and 42 or 23
							continue
						end

						if n3 <= 46 then
							n = (n + 1) % 256
							n2 = (n2 + tbl3[n]) % 256
							local v7 = tbl3[n]
							tbl3[n] = tbl3[n2]
							tbl3[n2] = v7
							local v8 = byte(v3, n4)
							n5 = tbl3[(tbl3[n] + tbl3[n2]) % 256]
							n6 = v8 % 2
							n7 = n5 % 2

							if n6 ~= n7 then
								n3 = 48
								n4 = v8
							else
								n3 = 43
								n8 = 0
								n4 = v8
							end
						else
							n4 = (n4 - n7) / 2
							n5 = (n5 - n9) / 2
							n7 = n4 % 2
							n9 = n5 % 2

							if n7 ~= n9 then
								n3 = 15
								n6 = 32
							else
								n3 = 63
							end
						end

						continue
					end

					if n3 <= 55 then
						if n3 <= 51 then
							if n3 <= 49 then
								if n3 <= 48 then
									n3 = 43
									n8 = 1
								else
									local v7 = tbl4[3]
									local v8 = tbl4[4]
									local n12 = tbl4[5] + v7
									local flag = v7 <= 0
									local flag2 = not flag
									local flag3 = n12 >= v8
									local flag4 = n12 <= v8
									flag3 = flag and flag3
									flag3 = flag3 or flag2 and flag4
									tbl4[5] = n12

									if flag3 then
										n3 = 33
										n = n12
									else
										n3 = 14
									end
								end
							elseif n3 <= 50 then
								tbl4 = tbl4[3]
								n3 = 41
							else
								tbl4 = tbl4[5]
								n3 = 61
							end
						elseif n3 <= 53 then
							if n3 <= 52 then
								n8 += n6
								n3 = 47
							else
								n11 += 65536
								n3 = 45
							end
						elseif n3 <= 54 then
							tbl4 = tbl4[4]
							n3 = 21
						else
							n4 = (n4 - n7) / 2
							n5 = (n5 - n9) / 2
							n7 = n4 % 2
							n9 = n5 % 2

							if n7 ~= n9 then
								n3 = 52
								n6 = 16
							else
								n3 = 47
							end
						end
					elseif n3 <= 59 then
						if n3 <= 57 then
							if n3 <= 56 then
								tbl2[n] = char(n)
								tbl3[n] = n
								n = (n2 * n + n5) % 256
								n3 = 9
							else
								local tbl5 = {}

								if n2 == 1 then
									n3 = 26
									n2 = tbl5
								else
									n3 = 60
									n4 = tbl5
								end
							end
						elseif n3 <= 58 then
							local v7 = tbl4[2]
							local v8 = tbl4[4]
							local n12 = tbl4[1] + v7
							local flag = v7 <= 0
							local flag2 = not flag
							local flag3 = n12 >= v8
							local flag4 = n12 <= v8
							flag3 = flag and flag3
							flag2 = flag2 and flag4
							flag2 = flag3 or flag2
							tbl4[1] = n12

							if flag2 then
								n3 = 39
								n10 = n12
							else
								n3 = 0
							end
						else
							tbl4 = tbl4[2]
							n3 = 36
							n4 = n2
						end
					elseif n3 <= 61 then
						if n3 <= 60 then
							n3 = n2 == 0 and 3 or 36
						else
							n3 = 62
							n = 0
							n2 = 0
							char = ""
							tbl4 = { #v3 + 0, 0, tbl4, 1, nil }
						end
					elseif n3 <= 62 then
						local v7 = tbl4[4]
						local v8 = tbl4[1]
						local n12 = tbl4[2] + v7
						local flag = v7 <= 0
						local flag2 = not flag
						local flag3 = n12 >= v8
						local flag4 = n12 <= v8
						flag3 = flag and flag3
						flag3 = flag3 or flag2 and flag4
						tbl4[2] = n12

						if flag3 then
							n3 = 46
							n4 = n12
						else
							n3 = 50
						end
					else
						n4 = (n4 - n7) / 2
						n5 = (n5 - n9) / 2
						n7 = n4 % 2
						n9 = n5 % 2

						if n7 ~= n9 then
							n3 = 10
							n6 = 64
						else
							n3 = 6
						end
					end
				end
			end
		end

		fn(5014044077993952, 0, "\243\241\185\198\r}\21\29\222\20E$2ѩ\198\"8\131\22\1702z\228\163C\26<\183\30~q\189\139i\162q\177~@Nm\19\168", nil --[[ the caller's registers ]], 1)

		local function fn2(arg, arg2, arg3, arg4, arg5)
			local tbl2 = {}
			local tbl3 = {}
			local n = arg
			local n2 = arg2
			local v3 = arg3
			local v4 = arg4
			local v5 = arg5
			local n3 = 1
			local tbl4 = nil
			local v6 = nil
			local char = nil
			local byte = nil
			local n4 = nil
			local n5 = nil
			local n6 = nil
			local n7 = nil
			local n8 = nil
			local n9 = nil
			local n10 = nil
			local n11 = nil

			while true do
				if n3 <= 31 then
					if n3 <= 15 then
						if n3 <= 7 then
							if n3 <= 3 then
								if n3 <= 1 then
									if n3 <= 0 then
										tbl4 = tbl4[5]
										n3 = 38
									else
										char = string.char
										byte = string.byte

										if n2 == 2 then
											n3 = 36
											n4 = n
										else
											n3 = 57
										end
									end
								elseif n3 <= 2 then
									tbl4 = tbl4[1]
									n3 = 32
								else
									n3 = 24
									n2 = 4225628066614523
									n5 = 1640726024911297
									n6 = 4503599627370496
									n7 = 67108864
									n8 = 17592186044416
									n9 = 66262169
									n10 = 66419657
									tbl4 = { tbl4, 4, 1, 0, nil }
								end
							elseif n3 <= 5 then
								if n3 <= 4 then
									n4 = (n4 - n7) / 2
									n5 = (n5 - n9) / 2
									n7 = n4 % 2
									n9 = n5 % 2

									if n7 ~= n9 then
										n3 = 11
										n6 = 4
									else
										n3 = 7
									end
								else
									tbl4 = tbl4[1]
									n3 = 27
								end
							elseif n3 <= 6 then
								n4 = (n4 - n7) / 2
								n5 = (n5 - n9) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 12
									n6 = 128
								else
									n3 = 35
								end
							else
								n4 = (n4 - n7) / 2
								n5 = (n5 - n9) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 18
									n6 = 8
								else
									n3 = 55
								end
							end
						elseif n3 <= 11 then
							if n3 <= 9 then
								if n3 <= 8 then
									local n12 = n4 * 2 + 1
									local v7 = n5[n12]
									local v8 = n5[n12 + 1]

									if not v7 then
										n3 = 40
									else
										n3 = 37
										n6 = v7
										n7 = v8
									end
								else
									local v7 = tbl4[3]
									local v8 = tbl4[5]
									local n12 = tbl4[2] + v7
									local flag = v7 <= 0
									local flag2 = not flag
									local flag3 = n12 >= v8
									local flag4 = n12 <= v8
									flag = flag and flag3
									flag2 = flag2 and flag4
									flag2 = flag or flag2
									tbl4[2] = n12

									if flag2 then
										n3 = 56
										n6 = n12
									else
										n3 = 54
									end
								end
							elseif n3 <= 10 then
								n8 += n6
								n3 = 6
							else
								n8 += n6
								n3 = 7
							end
						elseif n3 <= 13 then
							if n3 <= 12 then
								n8 += n6
								n3 = 35
							else
								local v7 = tbl4[5]
								local v8 = tbl4[4]
								local n12 = tbl4[2] + v7
								local flag = v7 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v8
								local flag4 = n12 <= v8
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[2] = n12

								if flag3 then
									n3 = 16
								else
									n3 = 2
								end
							end
						elseif n3 <= 14 then
							tbl4 = tbl4[2]
							n3 = 36
						else
							n8 += n6
							n3 = 63
						end

						continue
					end

					if n3 <= 23 then
						if n3 <= 19 then
							if n3 <= 17 then
								if n3 <= 16 then
									n4 = (n6 * n4 + n7) % 4294967296
									n11 ..= n8[1 + (n4 - n4 % 268435456) / 268435456 % 16]
									n3 = 13
									continue
								end

								return nil
							end

							if n3 <= 18 then
								n8 += n6
								n3 = 55
							else
								n = (n + tbl3[n2] + n4[n2 % 32 + 1]) % 256
								local v7 = tbl3[n2]
								tbl3[n2] = tbl3[n]
								tbl3[n] = v7
								n3 = 25
							end

							continue
						end

						if n3 <= 21 then
							if n3 <= 20 then
								local v7 = tbl4[1]
								local v8 = tbl4[5]
								local n12 = tbl4[4] + v7
								local flag = v7 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v8
								local flag4 = n12 <= v8
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[4] = n12

								if flag3 then
									n3 = 8
									n4 = n12
								else
									n3 = 59
								end
							else
								n3 = 25
								n = 0
								tbl4 = { 1, 255, nil, -1, tbl4 }
							end
						elseif n3 <= 22 then
							n[n4] = n6
							n[52] = 4
							n[99] = 12
							n[51] = 3
							n[65] = 10
							n[48] = 0
							n[101] = 14
							n[54] = 6
							n3 = 28
							n4 = 49
							n6 = 1
						else
							n = (n - n11) / 65536
							local n12 = (n2 + n11) % n6
							local n13 = n12 % n7
							n2 = ((((n12 - n13) / n7 * n9 + n13 * n10) % n7 * n7 + n13 * n9) % n6 + n5) % n6
							n3 = 24
						end

						continue
					end

					if n3 <= 27 then
						if n3 <= 25 then
							if n3 <= 24 then
								local v7 = tbl4[3]
								local v8 = tbl4[2]
								local n12 = tbl4[4] + v7
								local flag = v7 <= 0
								local flag2 = flag and n12 >= v8 or not flag and n12 <= v8
								tbl4[4] = n12

								if flag2 then
									n3 = 31
									n11 = n12
								else
									n3 = 5
								end
							else
								local v7 = tbl4[1]
								local v8 = tbl4[2]
								local n12 = tbl4[4] + v7
								local flag = v7 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v8
								local flag4 = n12 <= v8
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[4] = n12

								if flag3 then
									n3 = 19
									n2 = n12
								else
									n3 = 51
								end
							end
						elseif n3 <= 26 then
							n5 = {}
							n8 = { "6", "4", "e", "a", "5", "8", "d", "2", "1", "9", "3", "7", "c", "f", "b", "0" }
							n3 = 58
							n4 = 870728320
							n6 = 493413649
							n7 = -405362667
							n9 = 1
							tbl4 = { 0, 1, nil, 128, tbl4 }
						else
							n3 = 49
							tbl4 = { nil, tbl4, 1, 32, 0 }
						end
					elseif n3 <= 29 then
						if n3 <= 28 then
							n[n4] = n6
							n[100] = 13
							n[56] = 8
							n[97] = 10
							n[69] = 14
							n[66] = 11
							n[57] = 9
							n3 = 20
							tbl4 = { 1, tbl4, nil, -1, 31 }
						else
							n8 += n6
							n3 = 4
						end
					elseif n3 <= 30 then
						n2[n4 + 1] = n[n6] * 16 + n[n7]
						n3 = 20
					else
						n11 = n % 65536
						n3 = n11 < 0 and 53 or 45
					end
				else
					if n3 <= 47 then
						if n3 <= 39 then
							if n3 <= 35 then
								if n3 <= 33 then
									if n3 <= 32 then
										byte(n11, 1, 64)
										n3 = n10 == n9 and 34 or 58
									else
										local n12 = n2 % n7
										n2 = ((((n2 - n12) / n7 * n9 + n12 * n10) % n7 * n7 + n12 * n9) % n6 + n5) % n6
										n4[n] = (n2 - n2 % n8) / n8
										n3 = 49
									end
								elseif n3 <= 34 then
									n5 = { byte(n, 1, 64) }
									n3 = 58
								else
									char ..= tbl2[n8]
									n3 = 62
								end
							elseif n3 <= 37 then
								if n3 <= 36 then
									n = n4[3]
									n2 = 4 * n4[1] % 64 + 1
									n5 = 2 * n4[2] % 128 - 1
									n3 = 9
									tbl4 = { nil, -1, 1, tbl4, 255 }
								else
									n3 = not n7 and 17 or 30
								end
							elseif n3 <= 38 then
								n = { [53] = 5, [70] = 15, [68] = 13, [55] = 7, [67] = 12, [50] = 2, [102] = 15 }
								n3 = 22
								n4 = 98
								n6 = 11
							else
								n3 = 13
								n11 = ""
								tbl4 = { tbl4, 0, nil, 64, 1 }
							end

							continue
						end

						if n3 <= 43 then
							if n3 <= 41 then
								if n3 <= 40 then
									return nil
								end
								v4[v5] = char
								n3 = 44
								continue
							end

							if n3 <= 42 then
								n11 -= 65536
								n3 = 23
							else
								n4 = (n4 - n6) / 2
								n5 = (n5 - n7) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 29
									n6 = 2
								else
									n3 = 4
								end
							end

							continue
						end

						if n3 <= 45 then
							if n3 <= 44 then
								break
							end
							n3 = n11 >= 65536 and 42 or 23
							continue
						end

						if n3 <= 46 then
							n = (n + 1) % 256
							n2 = (n2 + tbl3[n]) % 256
							local v7 = tbl3[n]
							tbl3[n] = tbl3[n2]
							tbl3[n2] = v7
							local v8 = byte(v3, n4)
							n5 = tbl3[(tbl3[n] + tbl3[n2]) % 256]
							n6 = v8 % 2
							n7 = n5 % 2

							if n6 ~= n7 then
								n3 = 48
								n4 = v8
							else
								n3 = 43
								n8 = 0
								n4 = v8
							end
						else
							n4 = (n4 - n7) / 2
							n5 = (n5 - n9) / 2
							n7 = n4 % 2
							n9 = n5 % 2

							if n7 ~= n9 then
								n3 = 15
								n6 = 32
							else
								n3 = 63
							end
						end

						continue
					end

					if n3 <= 55 then
						if n3 <= 51 then
							if n3 <= 49 then
								if n3 <= 48 then
									n3 = 43
									n8 = 1
								else
									local v7 = tbl4[3]
									local v8 = tbl4[4]
									local n12 = tbl4[5] + v7
									local flag = v7 <= 0
									local flag2 = not flag
									local flag3 = n12 >= v8
									local flag4 = n12 <= v8
									flag3 = flag and flag3
									flag3 = flag3 or flag2 and flag4
									tbl4[5] = n12

									if flag3 then
										n3 = 33
										n = n12
									else
										n3 = 14
									end
								end
							elseif n3 <= 50 then
								tbl4 = tbl4[3]
								n3 = 41
							else
								tbl4 = tbl4[5]
								n3 = 61
							end
						elseif n3 <= 53 then
							if n3 <= 52 then
								n8 += n6
								n3 = 47
							else
								n11 += 65536
								n3 = 45
							end
						elseif n3 <= 54 then
							tbl4 = tbl4[4]
							n3 = 21
						else
							n4 = (n4 - n7) / 2
							n5 = (n5 - n9) / 2
							n7 = n4 % 2
							n9 = n5 % 2

							if n7 ~= n9 then
								n3 = 52
								n6 = 16
							else
								n3 = 47
							end
						end
					elseif n3 <= 59 then
						if n3 <= 57 then
							if n3 <= 56 then
								tbl2[n] = char(n)
								tbl3[n] = n
								n = (n2 * n + n5) % 256
								n3 = 9
							else
								local tbl5 = {}

								if n2 == 1 then
									n3 = 26
									n2 = tbl5
								else
									n3 = 60
									n4 = tbl5
								end
							end
						elseif n3 <= 58 then
							local v7 = tbl4[2]
							local v8 = tbl4[4]
							local n12 = tbl4[1] + v7
							local flag = v7 <= 0
							local flag2 = not flag
							local flag3 = n12 >= v8
							local flag4 = n12 <= v8
							flag3 = flag and flag3
							flag2 = flag2 and flag4
							flag2 = flag3 or flag2
							tbl4[1] = n12

							if flag2 then
								n3 = 39
								n10 = n12
							else
								n3 = 0
							end
						else
							tbl4 = tbl4[2]
							n3 = 36
							n4 = n2
						end
					elseif n3 <= 61 then
						if n3 <= 60 then
							n3 = n2 == 0 and 3 or 36
						else
							n3 = 62
							n = 0
							n2 = 0
							char = ""
							tbl4 = { #v3 + 0, 0, tbl4, 1, nil }
						end
					elseif n3 <= 62 then
						local v7 = tbl4[4]
						local v8 = tbl4[1]
						local n12 = tbl4[2] + v7
						local flag = v7 <= 0
						local flag2 = not flag
						local flag3 = n12 >= v8
						local flag4 = n12 <= v8
						flag3 = flag and flag3
						flag3 = flag3 or flag2 and flag4
						tbl4[2] = n12

						if flag3 then
							n3 = 46
							n4 = n12
						else
							n3 = 50
						end
					else
						n4 = (n4 - n7) / 2
						n5 = (n5 - n9) / 2
						n7 = n4 % 2
						n9 = n5 % 2

						if n7 ~= n9 then
							n3 = 10
							n6 = 64
						else
							n3 = 6
						end
					end
				end
			end
		end

		fn2(-3630267196881753, 0, "%R➐\253¯\3\243^\209%t\128\20a\176KU\205\219o_Aq_\167\223_\241 '\236*\155z\12\192\202 \181\168\176\23}\243\213\26\150\24\133\16\173\184M\139\213", nil --[[ the caller's registers ]], 2)

		local function fn3(arg, arg2, arg3, arg4, arg5)
			local tbl2 = {}
			local tbl3 = {}
			local n = arg
			local n2 = arg2
			local v3 = arg3
			local v4 = arg4
			local v5 = arg5
			local n3 = 1
			local tbl4 = nil
			local v6 = nil
			local char = nil
			local byte = nil
			local n4 = nil
			local n5 = nil
			local n6 = nil
			local n7 = nil
			local n8 = nil
			local n9 = nil
			local n10 = nil
			local n11 = nil

			while true do
				if n3 <= 31 then
					if n3 <= 15 then
						if n3 <= 7 then
							if n3 <= 3 then
								if n3 <= 1 then
									if n3 <= 0 then
										tbl4 = tbl4[5]
										n3 = 38
									else
										char = string.char
										byte = string.byte

										if n2 == 2 then
											n3 = 36
											n4 = n
										else
											n3 = 57
										end
									end
								elseif n3 <= 2 then
									tbl4 = tbl4[1]
									n3 = 32
								else
									n3 = 24
									n2 = 4225628066614523
									n5 = 1640726024911297
									n6 = 4503599627370496
									n7 = 67108864
									n8 = 17592186044416
									n9 = 66262169
									n10 = 66419657
									tbl4 = { tbl4, 4, 1, 0, nil }
								end
							elseif n3 <= 5 then
								if n3 <= 4 then
									n4 = (n4 - n7) / 2
									n5 = (n5 - n9) / 2
									n7 = n4 % 2
									n9 = n5 % 2

									if n7 ~= n9 then
										n3 = 11
										n6 = 4
									else
										n3 = 7
									end
								else
									tbl4 = tbl4[1]
									n3 = 27
								end
							elseif n3 <= 6 then
								n4 = (n4 - n7) / 2
								n5 = (n5 - n9) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 12
									n6 = 128
								else
									n3 = 35
								end
							else
								n4 = (n4 - n7) / 2
								n5 = (n5 - n9) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 18
									n6 = 8
								else
									n3 = 55
								end
							end
						elseif n3 <= 11 then
							if n3 <= 9 then
								if n3 <= 8 then
									local n12 = n4 * 2 + 1
									local v7 = n5[n12]
									local v8 = n5[n12 + 1]

									if not v7 then
										n3 = 40
									else
										n3 = 37
										n6 = v7
										n7 = v8
									end
								else
									local v7 = tbl4[3]
									local v8 = tbl4[5]
									local n12 = tbl4[2] + v7
									local flag = v7 <= 0
									local flag2 = not flag
									local flag3 = n12 >= v8
									local flag4 = n12 <= v8
									flag = flag and flag3
									flag2 = flag2 and flag4
									flag2 = flag or flag2
									tbl4[2] = n12

									if flag2 then
										n3 = 56
										n6 = n12
									else
										n3 = 54
									end
								end
							elseif n3 <= 10 then
								n8 += n6
								n3 = 6
							else
								n8 += n6
								n3 = 7
							end
						elseif n3 <= 13 then
							if n3 <= 12 then
								n8 += n6
								n3 = 35
							else
								local v7 = tbl4[5]
								local v8 = tbl4[4]
								local n12 = tbl4[2] + v7
								local flag = v7 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v8
								local flag4 = n12 <= v8
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[2] = n12

								if flag3 then
									n3 = 16
								else
									n3 = 2
								end
							end
						elseif n3 <= 14 then
							tbl4 = tbl4[2]
							n3 = 36
						else
							n8 += n6
							n3 = 63
						end

						continue
					end

					if n3 <= 23 then
						if n3 <= 19 then
							if n3 <= 17 then
								if n3 <= 16 then
									n4 = (n6 * n4 + n7) % 4294967296
									n11 ..= n8[1 + (n4 - n4 % 268435456) / 268435456 % 16]
									n3 = 13
									continue
								end

								return nil
							end

							if n3 <= 18 then
								n8 += n6
								n3 = 55
							else
								n = (n + tbl3[n2] + n4[n2 % 32 + 1]) % 256
								local v7 = tbl3[n2]
								tbl3[n2] = tbl3[n]
								tbl3[n] = v7
								n3 = 25
							end

							continue
						end

						if n3 <= 21 then
							if n3 <= 20 then
								local v7 = tbl4[1]
								local v8 = tbl4[5]
								local n12 = tbl4[4] + v7
								local flag = v7 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v8
								local flag4 = n12 <= v8
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[4] = n12

								if flag3 then
									n3 = 8
									n4 = n12
								else
									n3 = 59
								end
							else
								n3 = 25
								n = 0
								tbl4 = { 1, 255, nil, -1, tbl4 }
							end
						elseif n3 <= 22 then
							n[n4] = n6
							n[52] = 4
							n[99] = 12
							n[51] = 3
							n[65] = 10
							n[48] = 0
							n[101] = 14
							n[54] = 6
							n3 = 28
							n4 = 49
							n6 = 1
						else
							n = (n - n11) / 65536
							local n12 = (n2 + n11) % n6
							local n13 = n12 % n7
							n2 = ((((n12 - n13) / n7 * n9 + n13 * n10) % n7 * n7 + n13 * n9) % n6 + n5) % n6
							n3 = 24
						end

						continue
					end

					if n3 <= 27 then
						if n3 <= 25 then
							if n3 <= 24 then
								local v7 = tbl4[3]
								local v8 = tbl4[2]
								local n12 = tbl4[4] + v7
								local flag = v7 <= 0
								local flag2 = flag and n12 >= v8 or not flag and n12 <= v8
								tbl4[4] = n12

								if flag2 then
									n3 = 31
									n11 = n12
								else
									n3 = 5
								end
							else
								local v7 = tbl4[1]
								local v8 = tbl4[2]
								local n12 = tbl4[4] + v7
								local flag = v7 <= 0
								local flag2 = not flag
								local flag3 = n12 >= v8
								local flag4 = n12 <= v8
								flag3 = flag and flag3
								flag3 = flag3 or flag2 and flag4
								tbl4[4] = n12

								if flag3 then
									n3 = 19
									n2 = n12
								else
									n3 = 51
								end
							end
						elseif n3 <= 26 then
							n5 = {}
							n8 = { "6", "4", "e", "a", "5", "8", "d", "2", "1", "9", "3", "7", "c", "f", "b", "0" }
							n3 = 58
							n4 = 870728320
							n6 = 493413649
							n7 = -405362667
							n9 = 1
							tbl4 = { 0, 1, nil, 128, tbl4 }
						else
							n3 = 49
							tbl4 = { nil, tbl4, 1, 32, 0 }
						end
					elseif n3 <= 29 then
						if n3 <= 28 then
							n[n4] = n6
							n[100] = 13
							n[56] = 8
							n[97] = 10
							n[69] = 14
							n[66] = 11
							n[57] = 9
							n3 = 20
							tbl4 = { 1, tbl4, nil, -1, 31 }
						else
							n8 += n6
							n3 = 4
						end
					elseif n3 <= 30 then
						n2[n4 + 1] = n[n6] * 16 + n[n7]
						n3 = 20
					else
						n11 = n % 65536
						n3 = n11 < 0 and 53 or 45
					end
				else
					if n3 <= 47 then
						if n3 <= 39 then
							if n3 <= 35 then
								if n3 <= 33 then
									if n3 <= 32 then
										byte(n11, 1, 64)
										n3 = n10 == n9 and 34 or 58
									else
										local n12 = n2 % n7
										n2 = ((((n2 - n12) / n7 * n9 + n12 * n10) % n7 * n7 + n12 * n9) % n6 + n5) % n6
										n4[n] = (n2 - n2 % n8) / n8
										n3 = 49
									end
								elseif n3 <= 34 then
									n5 = { byte(n, 1, 64) }
									n3 = 58
								else
									char ..= tbl2[n8]
									n3 = 62
								end
							elseif n3 <= 37 then
								if n3 <= 36 then
									n = n4[3]
									n2 = 4 * n4[1] % 64 + 1
									n5 = 2 * n4[2] % 128 - 1
									n3 = 9
									tbl4 = { nil, -1, 1, tbl4, 255 }
								else
									n3 = not n7 and 17 or 30
								end
							elseif n3 <= 38 then
								n = { [53] = 5, [70] = 15, [68] = 13, [55] = 7, [67] = 12, [50] = 2, [102] = 15 }
								n3 = 22
								n4 = 98
								n6 = 11
							else
								n3 = 13
								n11 = ""
								tbl4 = { tbl4, 0, nil, 64, 1 }
							end

							continue
						end

						if n3 <= 43 then
							if n3 <= 41 then
								if n3 <= 40 then
									return nil
								end
								v4[v5] = char
								n3 = 44
								continue
							end

							if n3 <= 42 then
								n11 -= 65536
								n3 = 23
							else
								n4 = (n4 - n6) / 2
								n5 = (n5 - n7) / 2
								n7 = n4 % 2
								n9 = n5 % 2

								if n7 ~= n9 then
									n3 = 29
									n6 = 2
								else
									n3 = 4
								end
							end

							continue
						end

						if n3 <= 45 then
							if n3 <= 44 then
								break
							end
							n3 = n11 >= 65536 and 42 or 23
							continue
						end

						if n3 <= 46 then
							n = (n + 1) % 256
							n2 = (n2 + tbl3[n]) % 256
							local v7 = tbl3[n]
							tbl3[n] = tbl3[n2]
							tbl3[n2] = v7
							local v8 = byte(v3, n4)
							n5 = tbl3[(tbl3[n] + tbl3[n2]) % 256]
							n6 = v8 % 2
							n7 = n5 % 2

							if n6 ~= n7 then
								n3 = 48
								n4 = v8
							else
								n3 = 43
								n8 = 0
								n4 = v8
							end
						else
							n4 = (n4 - n7) / 2
							n5 = (n5 - n9) / 2
							n7 = n4 % 2
							n9 = n5 % 2

							if n7 ~= n9 then
								n3 = 15
								n6 = 32
							else
								n3 = 63
							end
						end

						continue
					end

					if n3 <= 55 then
						if n3 <= 51 then
							if n3 <= 49 then
								if n3 <= 48 then
									n3 = 43
									n8 = 1
								else
									local v7 = tbl4[3]
									local v8 = tbl4[4]
									local n12 = tbl4[5] + v7
									local flag = v7 <= 0
									local flag2 = not flag
									local flag3 = n12 >= v8
									local flag4 = n12 <= v8
									flag3 = flag and flag3
									flag3 = flag3 or flag2 and flag4
									tbl4[5] = n12

									if flag3 then
										n3 = 33
										n = n12
									else
										n3 = 14
									end
								end
							elseif n3 <= 50 then
								tbl4 = tbl4[3]
								n3 = 41
							else
								tbl4 = tbl4[5]
								n3 = 61
							end
						elseif n3 <= 53 then
							if n3 <= 52 then
								n8 += n6
								n3 = 47
							else
								n11 += 65536
								n3 = 45
							end
						elseif n3 <= 54 then
							tbl4 = tbl4[4]
							n3 = 21
						else
							n4 = (n4 - n7) / 2
							n5 = (n5 - n9) / 2
							n7 = n4 % 2
							n9 = n5 % 2

							if n7 ~= n9 then
								n3 = 52
								n6 = 16
							else
								n3 = 47
							end
						end
					elseif n3 <= 59 then
						if n3 <= 57 then
							if n3 <= 56 then
								tbl2[n] = char(n)
								tbl3[n] = n
								n = (n2 * n + n5) % 256
								n3 = 9
							else
								local tbl5 = {}

								if n2 == 1 then
									n3 = 26
									n2 = tbl5
								else
									n3 = 60
									n4 = tbl5
								end
							end
						elseif n3 <= 58 then
							local v7 = tbl4[2]
							local v8 = tbl4[4]
							local n12 = tbl4[1] + v7
							local flag = v7 <= 0
							local flag2 = not flag
							local flag3 = n12 >= v8
							local flag4 = n12 <= v8
							flag3 = flag and flag3
							flag2 = flag2 and flag4
							flag2 = flag3 or flag2
							tbl4[1] = n12

							if flag2 then
								n3 = 39
								n10 = n12
							else
								n3 = 0
							end
						else
							tbl4 = tbl4[2]
							n3 = 36
							n4 = n2
						end
					elseif n3 <= 61 then
						if n3 <= 60 then
							n3 = n2 == 0 and 3 or 36
						else
							n3 = 62
							n = 0
							n2 = 0
							char = ""
							tbl4 = { #v3 + 0, 0, tbl4, 1, nil }
						end
					elseif n3 <= 62 then
						local v7 = tbl4[4]
						local v8 = tbl4[1]
						local n12 = tbl4[2] + v7
						local flag = v7 <= 0
						local flag2 = not flag
						local flag3 = n12 >= v8
						local flag4 = n12 <= v8
						flag3 = flag and flag3
						flag3 = flag3 or flag2 and flag4
						tbl4[2] = n12

						if flag3 then
							n3 = 46
							n4 = n12
						else
							n3 = 50
						end
					else
						n4 = (n4 - n7) / 2
						n5 = (n5 - n9) / 2
						n7 = n4 % 2
						n9 = n5 % 2

						if n7 ~= n9 then
							n3 = 10
							n6 = 64
						else
							n3 = 6
						end
					end
				end
			end
		end

		fn3(8206222311654340, 0, "F{c.Y\254\18E\177\225\186Aq\230\25~\11\140\192\19a\169\222`\220\4\136s\1360\134\225\30\228\236\214\31j\5̕pFש>\234", nil --[[ the caller's registers ]], 27)
		tbl[1] = "\243\241\185\198\r}\21\29\222\20E$2ѩ\198\"8\131\22\1702z\228\163C\26<\183\30~q\189\139i\162q\177~@Nm\19\168"
		tbl[2] = "%R➐\253¯\3\243^\209%t\128\20a\176KU\205\219o_Aq_\167\223_\241 '\236*\155z\12\192\202 \181\168\176\23}\243\213\26\150\24\133\16\173\184M\139\213"
		tbl[3] = "F{c.Y\254\18E\177\225\186Aq\230\25~\11\140\192\19a\169\222`\220\4\136s\1360\134\225\30\228\236\214\31j\5̕pFש>\234"
		RedeemPageUrls = tbl
	end

	RedeemFetchPages = function()
		local tbl = {}

		for _, v3 in ipairs(RedeemPageUrls) do
			local ok, result = pcall(function()
				return VxezeFetchText(v3)
			end)

			if ok and type(result) == "string" then
				for match, match2 in result:gmatch("<(%a+)[^>]*>%s*([A-Za-z0-9_]+)%s*</%1>") do
					if (match == "strong" or match == "code" or match == "b" or match == "li") and #match2 >= 6 and #match2 <= 24 then
						if match2:find("[%d_]") or match2:upper() == match2 then
							table.insert(tbl, match2)
						end
					end
				end
			end
		end

		return tbl
	end

	RedeemAllCodes = function()
		if RedeemCodeBusy then
			VxezeNotify("Redeem Code", "Already redeeming, please wait", "warning", { Key = "redeembusy", Icon = "loader" })
			return
		end
		RedeemCodeBusy = true

		task.spawn(function()
			local ok, result = pcall(function()
				VxezeNotify("Redeem Code", "Fetching the latest codes", "start", { Key = "redeemstart", Icon = "download" })
				local tbl = {}
				local tbl2 = {}
				local v3 = ipairs
				local tbl3 = {}
				local v4 = RedeemFetchWiki()
				local v5 = RedeemFetchGuide()
				local v6 = RedeemFetchPages
				tbl3[1] = v4
				tbl3[2] = v5

				do
					local values = table.pack(v6())
					table.move(values, 1, values.n, 3, tbl3)
				end

				for _, v7 in v3(tbl3) do
					for _, v8 in ipairs(v7) do
						if not tbl[v8:lower()] then
							tbl[v8:lower()] = true
							table.insert(tbl2, v8)
						end
					end
				end

				if #tbl2 == 0 then
					VxezeNotify("Redeem Code", "Could not reach any code source, try again later", "error", { Key = "redeemnone", Icon = "wifi-off" })
					return
				end
				local v7 = RedeemLoadDone()
				local redeem = game:GetService("ReplicatedStorage").Remotes.Redeem
				local num = nil
				local n = 0
				local n2 = 0

				for _, v8 in ipairs(tbl2) do
					if num and #v8 ~= num then
						v7[v8] = true
					elseif not v7[v8] then
						n += 1

						local ok, result = pcall(function()
							return redeem:InvokeServer(v8)
						end)

						if ok then
							local str = tostring(result):lower()
							local match = str:match("exactly (%d+)")

							if match then
								num = tonumber(match)
								n -= 1
								v7[v8] = true
							else
								v7[v8] = true

								if str:find("success") or str:find("redeemed") or str:find("reward") then
									n2 += 1
								end
							end
						end

						task.wait()
					end
				end

				RedeemSaveDone(v7)

				if n2 > 0 then
					VxezeNotify("Redeem Code", "Redeemed " .. n2 .. " new codes", "reward", { Key = "redeemdone", Icon = "gift" })
				elseif n == 0 then
					VxezeNotify("Redeem Code", "No new codes to redeem", "info", { Key = "redeemdone", Icon = "ticket-check" })
				else
					VxezeNotify("Redeem Code", "Checked " .. n .. " codes, none were valid", "info", { Key = "redeemdone", Icon = "ticket-x" })
				end
			end)

			RedeemCodeBusy = false

			if not ok then
				VxezeNotify("Redeem Code", "Failed: " .. tostring(result), "error", { Key = "redeemfail" })
			end
		end)
	end

	BuyDracoBusy = false

	BuyRaceDraco = function()
		if BuyDracoBusy then
			return
		end

		if not Place_Id.sea3() then
			VxezeNotify("Buy Race Draco", "Only works in Sea 3", "warning", { Key = "dracosea" })
			return
		end
		BuyDracoBusy = true

		task.spawn(function()
			local ok, result = pcall(function()
				local now = tick()
				local v3

				while true do
					v3 = DetectNpc("Dragon Wizard")

					if not v3 then
						task.wait(0.5)
					end

					if not (v3 or tick() - now > 8) then
						continue
					end
					break
				end

				if not v3 then
					VxezeNotify("Buy Race Draco", "Dragon Wizard not found", "warning", { Key = "dracomissing" })
					return
				end
				local humanoidRootPart = v3:FindFirstChild("HumanoidRootPart") or v3.PrimaryPart

				while true do
					ToTarget(humanoidRootPart.CFrame * CFrame.new(0, 0, 4))
					task.wait(0.3)
					if not (localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 12 or tick() - now > 60) then
						continue
					end
					break
				end

				if localPlayer:DistanceFromCharacter(humanoidRootPart.Position) >= 12 then
					VxezeNotify("Buy Race Draco", "Could not reach the Dragon Wizard", "warning", { Key = "dracofar" })
					return
				end
				local DialogueController = require(game.ReplicatedStorage.DialogueController)
				pcall(DialogueController.close)
				task.wait(0.3)
				task.spawn(pcall, DialogueController.start, require(game.ReplicatedStorage.NPCManager.NPCList).List["Dragon Wizard"].DialogueCallback())
				local tbl = { "yes", "trade", "change", "transform", "draco", "accept" }
				local tbl2 = { "no", "leave", "bye", "cancel", "never" }
				local now2 = tick()
				local n = 0

				while true do
					if tick() - now2 < 25 and n < 3 then
						task.wait(0.4)
						local ok, result = pcall(DialogueController.getActiveDialogue)
						local pageStack = ok and result and result._pageStack and result._pageStack[#result._pageStack]

						if pageStack then
							local options2 = pageStack._options or {}

							if #options2 == 0 then
								pcall(DialogueController.advance)
								continue
							else
								local v4 = nil

								for _, v5 in ipairs(tbl) do
									for _, v6 in ipairs(options2) do
										local v7 = string.lower(type(v6._text) == "table" and table.concat(v6._text, " ") or tostring(v6._text))
										local flag = false

										for _, v8 in ipairs(tbl2) do
											if v7 == v8 or v7:find("^" .. v8 .. "[%s%p]") then
												flag = true
											end
										end

										if not v4 and not flag and v7:find(v5, 1, true) then
											v4 = v6
										end
									end
								end

								if v4 then
									pcall(DialogueController.select, v4)
									n += 1
									now2 = tick()
									task.wait(1)
									continue
								end
							end
						else
							continue
						end
					end

					break
				end

				task.wait(1)
				pcall(DialogueController.close)
				VxezeNotify("Buy Race Draco", n > 0 and "Talked to the Dragon Wizard, check your race" or "Dragon Wizard has no race change for you right now", n > 0 and "success" or "info", { Key = "dracodone" })
			end)

			BuyDracoBusy = false

			if not ok then
				VxezeReportError("Buy Race Draco", result)
			end
		end)
	end

	SectionShopTeleport = PageShop.CreateSection("Teleport World")

	SectionShopTeleport.CreateButton({ Title = "Teleport To Dungeon Sea [ Dungeon Hub ]" }, function()
		game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DungeonNPCNetworkFunction"):InvokeServer("TeleportToDungeonHub")
	end)

	SectionShopTeleport.CreateButton({ Title = "Teleport To First Sea [ Sea 1 ]" }, function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
	end)

	SectionShopTeleport.CreateButton({ Title = "Teleport To Second Sea [ Sea 2 ]" }, function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
	end)

	SectionShopTeleport.CreateButton({ Title = "Teleport To Third Sea [ Sea 3 ]" }, function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
	end)

	SectionShopMisc = PageShop.CreateSection("Misc Shop")

	SectionShopMisc.CreateButton({ Title = "Redeem Code" }, function()
		RedeemAllCodes()
	end)

	SectionShopMisc.CreateButton({ Title = "Buy Race Ghoul" }, function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "BuyCheck", 4)
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4)
	end)

	SectionShopMisc.CreateButton({ Title = "Buy Race Cyborg" }, function()
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
	end)

	SectionShopMisc.CreateButton({ Title = "Buy Race Draco" }, function()
		BuyRaceDraco()
	end)

	SectionShopMisc.CreateButton({ Title = "Reroll Race" }, function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
	end)

	SectionShopMisc.CreateButton({ Title = "Reset Stats" }, function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
	end)

	SectionShopFighting = PageShop.CreateSection("Fighting Shop")
	local notsave
	notsave = {}
	getgenv().notsave = notsave

	local tbl = {
		BuyBlackLeg = "Dark Step Teacher",
		BuySuperhuman = "Martial Arts Master",
		BuySharkmanKarate = "Sharkman Teacher",
		DragonClaw = "Sabi",
		BuyDragonTalon = "Uzoth",
		BuyElectro = "Mad Scientist",
		BuyFishmanKarate = "Water Kung-fu Teacher",
		BuyDeathStep = "Phoeyu, the Reformed",
		BuyGodhuman = "Ancient Monk",
		BuyElectricClaw = "Previous Hero",
		BuySanguineArt = "Shafi",
	}

	NPCManager = require(game:GetService("ReplicatedStorage").NPCManager)
	DetectNpc = function(n)local L= localPlayer .Character and( localPlayer .Character:FindFirstChild("HumanoidRootPart"));if not L then return;end;local c,U,w,y=next,{workspace.NPCs,game:GetService("ReplicatedStorage").NPCs},1/0;for S,S in c,U,nil do local c,U,K=next,S:GetChildren();for S,R in c,U,K do if R:GetAttribute("NPCLoaded")and(R:GetAttribute("NPCReady"))and R.Name==n and(R:FindFirstChild("HumanoidRootPart"))then S=(L.Position-R.HumanoidRootPart.Position).Magnitude;if S<w then w,y=S,R;end;end;end;end;if not y then L=NPCManager.getNPCsByName(n)[1];return L and L._modelState and L._modelState._instance;end;return y,w;end

	TalkToNpc = function(arg, ...)
		local v3 = DetectNpc(arg)
		if not v3 then
			return false
		end
		local position = v3:GetPivot().Position
		if localPlayer:DistanceFromCharacter(position) > 8 then
			ToTarget(CFrame.new(position) * CFrame.new(0, 0, 3))
			return false
		end
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(...)
		return true
	end

	SectionShopFighting.CreateToggle({ Title = "Black Leg", Desc = nil, Default = false }, function(arg)
		if arg then
			spawn(function()
				while notsave["Black Leg"] and task.wait() do
					local ok, result = pcall(function()
						local v3 = DetectNpc(tbl.BuyBlackLeg)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBlackLeg")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		notsave["Black Leg"] = arg
	end)

	SectionShopFighting.CreateToggle({ Title = "Fishman Karate", Desc = nil, Default = false }, function(arg)
		if arg then
			spawn(function()
				while notsave["Fishman Karate"] and task.wait() do
					local ok, result = pcall(function()
						local v3 = DetectNpc(tbl.BuyFishmanKarate)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		notsave["Fishman Karate"] = arg
	end)

	SectionShopFighting.CreateToggle({ Title = "Electro", Desc = nil, Default = false }, function(electro)
		if electro then
			spawn(function()
				while notsave.Electro and task.wait(0.1) do
					pcall(function()
						local v3 = DetectNpc(tbl.BuyElectro)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectro")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)
				end
			end)
		end

		notsave.Electro = electro
	end)

	SectionShopFighting.CreateToggle({ Title = "Dragon Breath", Desc = nil, Default = false }, function(dragonClaw)
		if dragonClaw then
			spawn(function()
				while notsave.DragonClaw and task.wait(0.1) do
					pcall(function()
						local v3 = DetectNpc(tbl.DragonClaw)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)
				end
			end)
		end

		notsave.DragonClaw = dragonClaw
	end)

	SectionShopFighting.CreateToggle({ Title = "SuperHuman", Desc = nil, Default = false }, function(superHuman)
		if superHuman then
			spawn(function()
				while notsave.SuperHuman and task.wait(0.1) do
					pcall(function()
						local v3 = DetectNpc(tbl.BuySuperhuman)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							Remote("BuySuperhuman")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)
				end
			end)
		end

		notsave.SuperHuman = superHuman
	end)

	SectionShopFighting.CreateToggle({ Title = "Death Step", Desc = nil, Default = false }, function(arg)
		if arg then
			spawn(function()
				while notsave["Death Step"] and task.wait() do
					pcall(function()
						local v3 = DetectNpc(tbl.BuyDeathStep)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							Remote("BuyDeathStep")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)
				end
			end)
		end

		notsave["Death Step"] = arg
	end)

	SectionShopFighting.CreateToggle({ Title = "Sharkman Karate", Desc = nil, Default = false }, function(arg)
		if arg then
			spawn(function()
				while notsave["Sharkman Karate"] and task.wait() do
					pcall(function()
						local v3 = DetectNpc(tbl.BuySharkmanKarate)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							Remote("BuySharkmanKarate")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)
				end
			end)
		end

		notsave["Sharkman Karate"] = arg
	end)

	SectionShopFighting.CreateToggle({ Title = "Electric Claw", Desc = nil, Default = false }, function(arg)
		if arg then
			spawn(function()
				while notsave["Electric Claw"] and task.wait() do
					pcall(function()
						local v3 = DetectNpc(tbl.BuyElectricClaw)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							Remote("BuyElectricClaw")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)
				end
			end)
		end

		notsave["Electric Claw"] = arg
	end)

	SectionShopFighting.CreateToggle({ Title = "Dragon Talon", Desc = nil, Default = false }, function(arg)
		if arg then
			spawn(function()
				while notsave["Dragon Talon"] and task.wait() do
					pcall(function()
						local v3 = DetectNpc(tbl.BuyDragonTalon)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							Remote("BuyDragonTalon")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)
				end
			end)
		end

		notsave["Dragon Talon"] = arg
	end)

	SectionShopFighting.CreateToggle({ Title = "God Human", Desc = nil, Default = false }, function(arg)
		if arg then
			spawn(function()
				while notsave["God Human"] and task.wait() do
					pcall(function()
						local v3 = DetectNpc(tbl.BuyGodhuman)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							Remote("BuyGodhuman")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)
				end
			end)
		end

		notsave["God Human"] = arg
	end)

	SectionShopFighting.CreateToggle({ Title = "Sanguine Art", Desc = nil, Default = false }, function(arg)
		if arg then
			spawn(function()
				while notsave["Sanguine Art"] and task.wait() do
					pcall(function()
						local v3 = DetectNpc(tbl.BuySanguineArt)
						if not v3 or not v3:FindFirstChild("HumanoidRootPart") then
							return
						end

						if localPlayer:DistanceFromCharacter(v3.HumanoidRootPart.Position) < 8 then
							Remote("BuySanguineArt")
						end

						local cFrame = v3.HumanoidRootPart.CFrame
						getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
					end)
				end
			end)
		end

		notsave["Sanguine Art"] = arg
	end)

	SectionShopAbilities = PageShop.CreateSection("Abilities Shop")

	SectionShopAbilities.CreateButton({ Title = "Skyjump [ $10,000 Beli ]" }, function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
	end)

	SectionShopAbilities.CreateButton({ Title = "Buso Haki [ $25,000 Beli ]" }, function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
	end)

	SectionShopAbilities.CreateButton({ Title = "Observation haki [ $750,000 Beli ]" }, function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
	end)

	SectionShopAbilities.CreateButton({ Title = "Soru [ $100,000 Beli ]" }, function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
	end)

	FormatBeli = function(arg)
		local str = tostring(arg)
		local v3

		repeat
			str, v3 = str:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
		until v3 == 0

		return str
	end

	BuildWeaponShop = function(arg, arg2)
		for _, v3 in ipairs(arg2) do
			arg.CreateButton({ Title = v3[1] .. " [ $" .. FormatBeli(v3[2]) .. " Beli ]" }, function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", v3[1])
			end)
		end
	end

	SectionShopGun = PageShop.CreateSection("Gun Shop")

	BuildWeaponShop(SectionShopGun, {
		{ "Slingshot", 5000 },
		{ "Musket", 8000 },
		{ "Flintlock", 10500 },
		{ "Refined Slingshot", 30000 },
		{ "Dual Flintlock", 65000 },
		{ "Cannon", 100000 },
	})

	SectionShopSword = PageShop.CreateSection("Sword Shop")

	BuildWeaponShop(SectionShopSword, {
		{ "Cutlass", 1000 },
		{ "Katana", 1000 },
		{ "Dual Katana", 12000 },
		{ "Iron Mace", 25000 },
		{ "Triple Katana", 60000 },
		{ "Pipe", 100000 },
		{ "Dual-Headed Blade", 400000 },
		{ "Soul Cane", 750000 },
		{ "Bisento", 1000000 },
	})

	PageStatusAndServer = Main.CreatePage({ Page_Name = "Status And Server", Page_Title = "Status And Server" })
	ExecutorName = "Unknown"

	pcall(function()
		local v3, v4 = identifyexecutor()
		ExecutorName = tostring(v3) .. (v4 and v4 ~= "" and " " .. tostring(v4) or "")
	end)

	SectionScriptCheck = PageStatusAndServer.CreateSection("Script Check")
	StatusScriptLabel = SectionScriptCheck.CreateLabel({ Title = "Status Script : ..." })

	SectionScriptCheck.CreateButton({ Title = "Copy Link Discord" }, function()
		local str = "\230\191y \225\244\29X]\166\161F\11JU\181c\231\191\207\220\30\161"
		;(nil --[[ constant not decoded ]])(5612255310238804, 0, str, nil --[[ the caller's registers ]], 9)
		local set = setclipboard or toclipboard or Clipboard and Clipboard.set

		if set then
			pcall(set, str)
			VxezeNotify("Discord", "Copied " .. str, "success", { Key = "copydiscord", Icon = "clipboard-check" })
		else
			VxezeNotify("Discord", "Your executor cannot copy, link: " .. str, "info", { Key = "copydiscord" })
		end
	end)

	task.spawn(function()
		local n = 0
		local RunService = game:GetService("RunService")
		local Stats = game:GetService("Stats")
		RunService.RenderStepped:Connect(function(...) end)
		local now = os.clock()

		while task.wait(1) do
			local now2 = os.clock()
			local n2 = math.floor(n / math.max(now2 - now, 0.001) + 0.5)
			local value = nil

			pcall(function()
				value = Stats.PerformanceStats.Ping:GetValue()
			end)

			if not value then
				pcall(function()
					value = localPlayer:GetNetworkPing() * 1000
				end)
			end

			value = math.floor((value or 0) + 0.5)
			StatusScriptLabel.SetText("Status Script : Fps " .. n2 .. " | Ping " .. value .. " ms | " .. ExecutorName)
			now = now2
		end
	end)

	SectionStatus = PageStatusAndServer.CreateSection("Status")
	StatusSea = SectionStatus.CreateLabel({ Title = "Sea : Checking..." })
	TimerLabel = SectionStatus.CreateLabel({ Title = "Timer : ..." })
	TimerServerLabel = SectionStatus.CreateLabel({ Title = "Server Timer : ..." })
	NextTimerServerLabel = SectionStatus.CreateLabel({ Title = "Legendary Item : ..." })
	StatusMoon = SectionStatus.CreateLabel({ Title = "Moon : ..." })
	StatusEliteHunter = SectionStatus.CreateLabel({ Title = "Elite Hunter : ..." })
	StatusTyrant = SectionStatus.CreateLabel({ Title = "Tyrant Eyes : ..." })
	StatusKatakuri = SectionStatus.CreateLabel({ Title = "Cake Prince : ..." })
	Statusspy = SectionStatus.CreateLabel({ Title = "Leviathan : ..." })
	StatusMirage = SectionStatus.CreateLabel({ Title = "Mirage Island : ..." })
	StatusPrehistoricIsland = SectionStatus.CreateLabel({ Title = "Prehistoric Island : ..." })
	StatusFrozenDimension = SectionStatus.CreateLabel({ Title = "Frozen Dimension : ..." })
	StatusGear = SectionStatus.CreateLabel({ Title = "Ancient One : ..." })
	SectionServer = PageStatusAndServer.CreateSection("Server")
	ServerBrowser = { list = {}, time = 0, busy = false, visited = {}, lastHop = 0, file = "Vxeze Hub/Visited.json" }

	ServerRemote = function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")

		local waitForChild = ReplicatedStorage.WaitForChild
		;(nil --[[ constant not decoded ]])(-1951954522400961, 0, "\168X\8\183\146\211\207\2541\240\1415\240\158\228", nil --[[ the caller's registers ]], 11)
		return waitForChild(ReplicatedStorage, "\168X\8\183\146\211\207\2541\240\1415\240\158\228")
	end

	LoadVisitedServers = function()
		local ok, result = pcall(function()
			return game:GetService("HttpService"):JSONDecode(readfile(ServerBrowser.file))
		end)

		if ok and type(result) == "table" then
			local now = os.time()

			for k, v3 in pairs(result) do
				if type(v3) == "number" and now - v3 < 3600 then
					ServerBrowser.visited[k] = v3
				end
			end
		end
	end

	SaveVisitedServers = function()
		pcall(function()
			if not isfolder("Vxeze Hub") then
				makefolder("Vxeze Hub")
			end

			writefile(ServerBrowser.file, game:GetService("HttpService"):JSONEncode(ServerBrowser.visited))
		end)
	end

	FetchServers = function(arg)
		if ServerBrowser.busy then
			repeat
				task.wait(0.1)
			until not ServerBrowser.busy

			return ServerBrowser.list
		end

		local flag = #ServerBrowser.list > 0
		local flag2

		if flag then
			local time_ = ServerBrowser.time
			flag2 = tick() - time_ < (arg or 30)
		else
			flag2 = flag
		end

		if flag2 then
			return ServerBrowser.list
		end
		ServerBrowser.busy = true
		local v3 = ServerRemote()
		local tbl2 = {}
		local n = 0

		for i_ = 1, 100 do
			task.delay(i_ / 50, function()
				local ok, result = pcall(v3.InvokeServer, v3, i_)

				if ok and type(result) == "table" then
					for k, v4 in pairs(result) do
						if type(k) == "string" and type(v4) == "table" then
							tbl2[k] = v4
						end
					end
				end

				n += 1
			end)
		end

		local now = tick()

		while true do
			task.wait(0.1)
			if not (n >= 100 or tick() - now > 8) then
				continue
			end
			break
		end

		local list = {}

		for k, v4 in pairs(tbl2) do
			table.insert(list, {
				Job = k,
				Count = tonumber(v4.Count) or 0,
				Region = tostring(v4.Region or "Unknown"),
				Bounty = tonumber(v4.Bounty) or 0,
			})
		end

		local v4 = ServerBrowser
		local v5 = ServerBrowser
		local v6 = ServerBrowser
		local now2 = tick()
		v4.list = list
		v5.time = now2
		v6.busy = false
		return list
	end

	GetMyRegion = function()
		for _, v3 in ipairs(ServerBrowser.list) do
			if v3.Job == game.JobId then
				return v3.Region
			end
		end
	end

	JoinServer = function(arg, arg2)
		if type(arg) ~= "string" or arg == "" or arg == game.JobId then
			return false
		end
		ServerBrowser.visited[arg] = os.time()
		SaveVisitedServers()
		VxezeNotify("Server", arg2 or "Joining " .. arg:sub(1, 8), "travel")

		return (pcall(function()
			ServerRemote():InvokeServer("teleport", arg)
		end))
	end

	PickServer = function(arg)
		local v3 = FetchServers(30)
		local maxPlayers = game.Players.MaxPlayers
		local tbl2 = {}

		for _, v4 in ipairs(v3) do
			if v4.Job ~= game.JobId and not ServerBrowser.visited[v4.Job] and v4.Count > 0 and v4.Count < maxPlayers then
				table.insert(tbl2, v4)
			end
		end

		if #tbl2 == 0 then
			return nil
		end

		if arg == "less" then
			table.sort(tbl2, function(arg2, arg3)
				return arg2.Count < arg3.Count
			end)

			return tbl2[math.random(1, math.min(5, #tbl2))].Job
		end

		return tbl2[math.random(1, #tbl2)].Job
	end

	HopTo = function(c,n,L)if tick()-ServerBrowser.lastHop<12 then return false;end;ServerBrowser.lastHop=tick();n=tonumber(n)or(tonumber(Settings["Time Hop Server"]))or 0;if n>0 then VxezeNotify("Server",L.." in "..n.."s","warning",{Key="hopwait"});task.wait(n);end;for n=1,3,1 do n=PickServer(c);if not n then VxezeNotify("Server","No server to hop to right now","warning",{Key="hopempty"});return false;end;JoinServer(n,L);n=tick();repeat task.wait(1);until tick()-n>15;end;return false;end

	HopServer = function(arg)
		return HopTo("random", arg, "Hopping to a new server")
	end

	HopLessAll = function(arg)
		return HopTo("less", arg, "Hopping to a server with few players")
	end

	HopServerLess = function()
		return HopLessAll()
	end

	OpenServerBrowser = function()
		if ServerBrowser.panel then
			ServerBrowser.panel.Open()
			return
		end
		local v3 = VxezeUI.Window:AddPanelTab({ Name = "Server Browser", Icon = "Lucide:globe", UseElements = true })
		ServerBrowser.panel = v3
		local tab = v3.Tab
		tab:AddSection("Server Browser", "Lucide:globe")
		local v4 = tab:AddParagraph({ Title = "Servers", Text = "Loading the server list..." })

		local v5 = tab:AddCardGrid({
			Title = "Servers",
			Height = 330,
			CardHeight = 84,
			PageSize = 24,
			SearchPlaceholder = "Search a region or job id...",
			EmptyText = "No server matches that search.",
			Sorts = { "Fewest players", "Most players", "Highest bounty", "Lowest bounty" },
			Fetch = function(arg)
				local v5 = FetchServers(30)
				local v6 = string.lower(arg.Query or "")
				local maxPlayers = game.Players.MaxPlayers
				local tbl2 = {}

				for _, v7 in ipairs(v5) do
					if v6 == "" or string.find(string.lower(v7.Region), v6, 1, true) or string.find(string.lower(v7.Job), v6, 1, true) then
						table.insert(tbl2, v7)
					end
				end

				local sort = arg.Sort

				table.sort(tbl2, function(arg2, arg3)
					if sort == "Most players" then
						return arg2.Count > arg3.Count
					end

					if sort == "Highest bounty" then
						return arg2.Bounty > arg3.Bounty
					end

					if sort == "Lowest bounty" then
						return arg2.Bounty < arg3.Bounty
					end
					return arg2.Count < arg3.Count
				end)

				v4:Set(#v5 .. " servers | Your region: " .. tostring(GetMyRegion() or "Unknown") .. " | Updated " .. os.date("%H:%M:%S"))
				local tbl3 = {}

				for i_ = 1, math.min(60, #tbl2) do
					local v7 = tbl2[i_]
					local flag = v7.Job == game.JobId

					table.insert(tbl3, {
						Title = v7.Region,
						Description = "Players " .. v7.Count .. "/" .. maxPlayers .. (flag and " | Your server" or ""),
						Byline = "Bounty " .. v7.Bounty .. " | " .. v7.Job:sub(1, 8),
						Icon = flag and "Lucide:house" or "Lucide:server",
						ActionIcon = "log-in",
						Callback = function()
							if flag then
								VxezeNotify("Server", "You are already in this server", "info")
								return
							end
							JoinServer(v7.Job, "Joining " .. v7.Region .. " (" .. v7.Count .. " players)")
						end,
					})
				end

				return tbl3
			end,
		})

		tab:AddButton({
			Text = "Refresh list",
			Icon = "Lucide:refresh-cw",
			Callback = function()
				ServerBrowser.time = 0
				v5:Refresh()
			end,
		})

		tab:AddButton({
			Text = "Close",
			Icon = "Lucide:x",
			Callback = function()
				v3.Close()
			end,
		})

		v3.Open()
	end

	LoadVisitedServers()

	SectionServer.CreateButton({ Title = "Open Server Browser", Desc = "Every public server, sorted and searchable" }, function()
		OpenServerBrowser()
	end)

	StatusJobId = SectionServer.CreateLabel({ Title = "Job Id : " .. game.JobId })
	StatusPlaceId = SectionServer.CreateLabel({ Title = "Place Id : " .. game.PlaceId })
	local str = ""

	SectionServer.CreateBox({ Title = "Input JobId", Placeholder = "Paste a job id", Number = false, Default = nil }, function(arg)
		str = tostring(arg or ""):gsub("%s", "")
	end)

	SectionServer.CreateToggle({
		Title = "Spam Join",
		Desc = "Keep trying the job id until it lets you in",
		Default = Settings["Spam Join"] or false,
	}, function(arg)
		SaveSettings("Spam Join", arg)
	end)

	if not (bit32 or bit) then
		local tbl2 = { bxor = function(arg, arg2)
			local n = 0
			local n2 = 1

			while arg > 0 or arg2 > 0 do
				local n3 = arg % 2
				local n4 = arg2 % 2
				arg = (arg - n3) / 2
				arg2 = (arg2 - n4) / 2

				if n3 ~= n4 then
					n += n2
				end

				n2 *= 2
			end

			return n
		end }
	end

	Realm = require(game:GetService("ReplicatedStorage").Util.Realm)

	SectionServer.CreateButton({ Title = "Join JobId" }, function()
		if str == "" then
			VxezeNotify("Server", "Paste a job id first", "warning")
			return
		end

		if not Settings["Spam Join"] then
			JoinServer(str, "Joining " .. str:sub(1, 8))
			return
		end

		task.spawn(function()
			for i_ = 1, 60 do
				if not Settings["Spam Join"] then
					return
				end
				JoinServer(str, "Trying to join " .. str:sub(1, 8) .. " (" .. i_ .. "/60)")
				task.wait(2)
			end

			VxezeNotify("Server", "Gave up joining that server after 60 tries", "warning")
		end)
	end)

	SectionServer.CreateButton({ Title = "Copy JobId" }, function()
		if setclipboard then
			setclipboard(tostring(game.JobId))
			VxezeNotify("Server", "Job id copied", "success")
		end
	end)

	SectionServer.CreateButton({ Title = "Rejoin Server" }, function()
		VxezeNotify("Server", "Rejoining this server", "travel")

		pcall(function()
			ServerRemote():InvokeServer("teleport", game.JobId)
		end)
	end)

	SectionServer.CreateSlider({
		Title = "Time Hop Server",
		Min = 0,
		Max = 60,
		Default = Settings["Time Hop Server"] or 5,
		Precise = true,
	}, function(arg)
		SaveSettings("Time Hop Server", arg)
	end)

	SectionServer.CreateButton({ Title = "Hop Server", Desc = "Any other server you have not visited this hour" }, function()
		task.spawn(HopServer)
	end)

	SectionServer.CreateButton({ Title = "Hop Server Less People", Desc = "One of the emptiest servers that still has players" }, function()
		task.spawn(HopLessAll)
	end)

	CheckMoon = function()local c=game:GetService("Lighting");local n=c:GetAttribute("MoonPhase");if n then return if n==5 then"Full Moon"else if n==4 then"Next Night"else"Bad Moon";end;n=c:FindFirstChildOfClass("Sky");c=n and(n.MoonTextureId:match("%d+$"));return if c=="9709149431"then"Full Moon"else if c=="9709149052"then"Next Night"else"Bad Moon";end

	GetClockHour = function()
		return math.floor(game.Lighting.ClockTime)
	end

	GetMoonTimeText = function()
		local clockTime = game.Lighting.ClockTime
		if CheckMoon() == "Full Moon" and clockTime <= 5 then
			return ("Clock " .. GetClockHour() .. "h") .. " ( Will End Moon In " .. math.floor(5 - clockTime) .. " Minutes )"
		end

		if CheckMoon() == "Full Moon" and clockTime > 5 and clockTime < 12 then
			return ("Clock " .. GetClockHour() .. "h") .. " ( Fake Moon )"
		end

		if CheckMoon() == "Full Moon" and clockTime > 12 and clockTime < 18 then
			return ("Clock " .. GetClockHour() .. "h") .. " ( Will Full Moon In " .. math.floor(18 - clockTime) .. " Minutes )"
		end

		if CheckMoon() == "Full Moon" and clockTime > 18 and clockTime <= 24 then
			return ("Clock " .. GetClockHour() .. "h") .. " ( Will End Moon In " .. math.floor(30 - clockTime) .. " Minutes )"
		end

		if CheckMoon() == "Next Night" and clockTime < 12 then
			return ("Clock " .. GetClockHour() .. "h") .. " ( Will Full Moon In " .. math.floor(18 - clockTime) .. " Minutes )"
		end

		if CheckMoon() == "Next Night" and clockTime > 12 then
			return ("Clock " .. GetClockHour() .. "h") .. " ( Will Full Moon In " .. math.floor(30 - clockTime) .. " Minutes )"
		end
		return "Clock " .. GetClockHour() .. "h"
	end

	CheckAcientOneDracoStatus = function()
		if not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
			if Place_Id.sea3() then
				local response = game.workspace.HydraIslandClient.RemoteFunction:InvokeServer("Interacted")
				if response == 1 or response == 2 or response == 3 or response == 4 then
					return "Ready For Trial"
				end
			end

			return "You have yet to achieve greatness"
		end

		local response, v3, v4 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check", 2)
		if response == 1 then
			return "Required Train More"
		end

		if response == 2 or response == 4 or response == 7 then
			return "Can Buy Gear With " .. v4 .. " Fragments"
		end

		if response == 3 then
			return "Required Train More"
		end

		if response == 5 then
			return "You Are Done Your Race."
		end

		if response == 6 then
			return "Upgrades completed: " .. v3 - 2 .. "/3, Need Trains More"
		end

		if response ~= 8 then
			if response == 0 then
				return "Ready For Trial"
			end
			return "You have yet to achieve greatness"
		end

		return "Remaining " .. 10 - v3 .. " training sessions."
	end

	do
		local function fn()
			if not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
				return "You have yet to achieve greatness"
			end
			local response, v3, v4 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check")
			if response == 1 then
				return "Required Train More"
			end

			if response == 2 or response == 4 or response == 7 then
				return "Can Buy Gear With " .. v4 .. " Fragments"
			end

			if response == 3 then
				return "Required Train More"
			end

			if response == 5 then
				return "You Are Done Your Race."
			end

			if response == 6 then
				return "Upgrades completed: " .. v3 - 2 .. "/3, Need Trains More"
			end

			if response ~= 8 then
				if response == 0 then
					return "Ready For Trial"
				end
				return "You have yet to achieve greatness"
			end

			return "Remaining " .. 10 - v3 .. " training sessions."
		end

		local v3 = nil
		local n = 0

		CheckAcientOneStatus = function()
			if v3 and tick() - n < 1 then
				return v3
			end
			v3 = fn()
			n = tick()
			return v3
		end

		ResetRaceStatus = function()
			v3 = nil
		end
	end

	CheckGoTrain = function()
		local v3 = CheckAcientOneStatus()
		if string.find(v3, "Upgrades completed") or v3 == "Required Train More" or string.find(v3, "training sessions.") or string.find(v3, "Can Buy Gear") then
			return true
		end
	end

	CheckClockTime = function()
		local clockTime = game.Lighting.ClockTime
		local str2

		if clockTime >= 18 or clockTime < 5 then
			str2 = "Night"
		else
			str2 = "Day"
		end

		return str2
	end

	StatusCheckLeviathan = function()
		if Place_Id.sea3() then
			if game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("InfoLeviathan", "1") ~= -1 then
				if game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("InfoLeviathan", "1") == 5 then
					return "You can find leviathan now"
				end
				return "Buy Find leviathan"
			end

			return "I DONT KNOW"
		end

		return "..."
	end

	IsMobAlive = function(c)if c and c.Parent and(c:FindFirstChild("HumanoidRootPart"))and(c:FindFirstChildWhichIsA("Humanoid"))and c.Humanoid.Health>0 then return true;end;end
	local tbl2 = { "Deandre", "Urban", "Diablo" }

	DetectEliteHunter = function()
		local v3 = next
		local children, v4 = game:GetService("ReplicatedStorage"):GetChildren()

		for _, v5 in v3, children, v4 do
			if v5:IsA("Model") and table.find(tbl2, v5.Name) and IsMobAlive(v5) then
				return v5
			end
		end

		local v5 = next
		local children2, v6 = game:GetService("Workspace").Enemies:GetChildren()

		for _, v7 in v5, children2, v6 do
			if v7:IsA("Model") and table.find(tbl2, v7.Name) and IsMobAlive(v7) then
				return v7
			end
		end
	end

	GetOldestLocation = function()
		local huge = math.huge
		local v3 = nil

		for _, child in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
			local attribute = child:GetAttribute("TimeIn")

			if attribute and attribute < huge then
				huge = attribute
				v3 = child
			end
		end

		return v3
	end

	SeaInfo = { number = nil, name = "Unknown", tags = {} }

	GetCurrentSea = function()
		if SeaInfo.number then
			return SeaInfo.number
		end
		local ok, result = pcall(require, game.ReplicatedStorage.Util.Realm)
		ok = ok and result
		local result2 = nil

		if ok then
			local ok2
			ok2, result2 = pcall(result.getCurrentSeaAsync)
			result2 = ok2 and result2 or nil

			for _, v3 in ipairs({ "HasEliteHunters", "HasMirageIsland", "HasSeaEvents" }) do
				local ok3, result3 = pcall(result.getIfCurrentRealmHasTagAsync, v3)
				SeaInfo.tags[v3] = ok3 and result3 == true
			end
		end

		result2 = result2 or game.Lighting:GetAttribute("MAP")
		SeaInfo.number = result2 == "Sea1" and 1 or result2 == "Sea2" and 2 or result2 == "Sea3" and 3 or nil

		if not SeaInfo.number then
			SeaInfo.number = Place_Id.sea1() and 1 or Place_Id.sea2() and 2 or Place_Id.sea3() and 3 or 0
		end

		SeaInfo.name = SeaInfo.number > 0 and "Sea " .. SeaInfo.number or "Unknown"
		return SeaInfo.number
	end

	SeaOnly = function(arg, arg2, arg3)
		local v3 = GetCurrentSea()

		for _, v4 in ipairs(arg3) do
			if v4 == v3 then
				return true
			end
		end

		local tbl3 = {}

		for _, v4 in ipairs(arg3) do
			table.insert(tbl3, "Sea " .. v4)
		end

		arg.SetText(arg2 .. " : Not in " .. SeaInfo.name .. ", go to " .. table.concat(tbl3, " or "))
		return false
	end

	SeaOnlyNone = function(arg, arg2, arg3)
		local v3 = GetCurrentSea()

		for _, v4 in ipairs(arg3) do
			if v4 == v3 then
				return true
			end
		end

		arg.SetText(arg2 .. " : None")
		return false
	end

	FormatClock = function(arg)
		local n = math.max(0, math.floor(arg))
		return string.format("%dh %dm %ds", n // 3600, n % 3600 // 60, n % 60)
	end

	GetTyrantEyes = function()
		local tikiOutpost = workspace.Map:FindFirstChild("TikiOutpost")
		tikiOutpost = tikiOutpost and tikiOutpost:FindFirstChild("IslandModel")
		if not tikiOutpost then
			return 0
		end

		if not TyrantEyes or not TyrantEyes[1] or not TyrantEyes[1]:IsDescendantOf(tikiOutpost) then
			TyrantEyes = {}

			for i_ = 1, 4 do
				local v3 = tikiOutpost:FindFirstChild("Eye" .. i_, true)

				if v3 then
					table.insert(TyrantEyes, v3)
				end
			end
		end

		local n = 0

		for _, v3 in ipairs(TyrantEyes) do
			if v3.Transparency == 0 then
				n += 1
			end
		end

		return math.min(n, 4)
	end

	StatusRemote = { busy = {}, last = {}, value = {} }

	PollStatus = function(arg, arg2, arg3)
		local flag = StatusRemote.busy[arg]

		if not flag then
			flag = tick() - (StatusRemote.last[arg] or 0) < arg2
		end

		if flag then
			return StatusRemote.value[arg]
		end
		StatusRemote.busy[arg] = true

		task.spawn(function()
			local ok, result = pcall(arg3)

			if ok then
				StatusRemote.value[arg] = result
			else
				VxezeReportError("Status " .. arg, result)
			end

			StatusRemote.last[arg] = tick()
			StatusRemote.busy[arg] = nil
		end)

		return StatusRemote.value[arg]
	end

	ReadCakePrince = function()
		local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
		local str2 = type(response) == "string" and response or ""

		if str2:find("open the portal", 1, true) then
			local selectMethodFarm = Settings["Select Method Farm"]

			if Settings["Start Farm"] and (selectMethodFarm == "Cake" or selectMethodFarm == "Farm Katakuri") then
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
			end

			return "Portal ready"
		end

		local match = str2:gsub("<[^>]+>", ""):match("(%d+)")
		return match and match .. " enemies left" or "Unknown"
	end

	ReadLeviathan = function()
		local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("InfoLeviathan", "1")
		if response == 5 then
			return "Ready to hunt"
		end

		if response == -1 or response == nil then
			return "Unknown"
		end
		return "Buy the hint from the Spy"
	end

	LocationLabel = function(arg)
		if typeof(arg) == "Instance" then
			local v3 = nil
			local parent = arg
			arg = v3

			while parent and parent ~= workspace and not arg do
				if parent:IsA("BasePart") then
					arg = parent.Position
				elseif parent:IsA("Model") then
					arg = parent:GetPivot().Position
				end

				parent = parent.Parent
			end
		end

		if typeof(arg) ~= "Vector3" then
			return "Sea " .. GetCurrentSea()
		end
		local name_ = AreaAt(arg)

		if name_ == "" then
			local v3 = nil

			for _, child in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
				if child:IsA("BasePart") and child.Name ~= "Sea" then
					local magnitude = (child.Position - arg).Magnitude

					if not v3 or magnitude < v3 then
						name_ = child.Name
						v3 = magnitude
					end
				end
			end
		end

		return name_ ~= "" and name_ or "Sea " .. GetCurrentSea()
	end

	ReadEliteProgress = function()
		local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
		return tonumber(response)
	end

	UpdateStatus = function(...) end

	task.spawn(function()
		while task.wait(2) do
			local ok, result = pcall(UpdateStatus)

			if not ok then
				VxezeReportError("Status", result)
			end
		end
	end)

	LocalPlayerMain = Main.CreatePage({ Page_Name = "LocalPlayer", Page_Title = "LocalPlayer" })
	SectionLocalPlayerMain = LocalPlayerMain.CreateSection("Local Player")

	StopAllTween = function(arg)
		TweenManager.PauseUntil = tick() + (arg or 3)
		getgenv().noclip = false
		TweenManager.CancelCurrent()
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character:FindFirstChildOfClass("Humanoid")

		if humanoidRootPart then
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.AssemblyAngularVelocity = Vector3.zero

			for _, child in ipairs(humanoidRootPart:GetChildren()) do
				if child.Name == "FloatForce" or child:IsA("BodyVelocity") or child:IsA("BodyPosition") then
					child:Destroy()
				end
			end
		end

		if character then
			character.PlatformStand = false
			character:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end

	SectionLocalPlayerMain.CreateButton({ Title = "Stop Tween", Desc = "Stops moving now, features resume after 3s" }, function()
		StopAllTween(3)
		VxezeNotify("Tween", "Movement stopped", "stop")
	end)

	ShowcaseGroups = {
		Weapons = { Sword = 3, Gun = 3, Accessory = 3, Ring = 2 },
		Powers = { ["Blox Fruit"] = 3, ["Fighting Style"] = 0 },
	}

	CreateShowcaseColumn = function(name_, position)
		local frame = Instance.new("Frame")
		frame.Name = name_
		frame.BackgroundTransparency = 1
		frame.Position = position
		frame.Size = UDim2.new(0.5, -12, 0.84, 0)
		local uiPadding = Instance.new("UIPadding")
		uiPadding.PaddingLeft = UDim.new(0, 12)
		uiPadding.PaddingTop = UDim.new(0, 12)
		uiPadding.Parent = frame
		local uiGridLayout = Instance.new("UIGridLayout")
		uiGridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
		uiGridLayout.CellSize = UDim2.new(0, 70, 0, 70)
		uiGridLayout.FillDirectionMaxCells = 8
		uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiGridLayout.Parent = frame
		return frame
	end

	AddShowcaseIcon = function(parent, arg, layoutOrder)
		local sprite = arg.Sprite
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.BackgroundTransparency = 1
		imageLabel.Image = sprite.Image
		imageLabel.ImageRectOffset = sprite.ImageRectOffset or Vector2.zero
		imageLabel.ImageRectSize = sprite.ImageRectSize or Vector2.zero
		imageLabel.LayoutOrder = layoutOrder
		local textLabel = Instance.new("TextLabel")
		textLabel.BackgroundTransparency = 1
		textLabel.Size = UDim2.fromScale(1, 1)
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextColor3 = Color3.new(1, 1, 1)
		textLabel.TextStrokeTransparency = 0.4
		textLabel.TextSize = 11
		textLabel.TextXAlignment = Enum.TextXAlignment.Right
		textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
		local item = arg.Item
		local text = (item.Mastery or 0) > 0 and tostring(item.Mastery)

		if not text then
			text = (item.Count or 1) > 1 and "x" .. item.Count
		end

		textLabel.Text = text or ""
		textLabel.Parent = imageLabel
		imageLabel.Parent = parent
	end

	SetHudVisible = function(visible)
		local main = localPlayer.PlayerGui:FindFirstChild("Main")
		if not main then
			return
		end

		for _, v3 in ipairs({ "MenuButton", "HP", "Energy", "Compass" }) do
			local v4 = main:FindFirstChild(v3)

			if v4 then
				v4.Visible = visible
			end
		end

		for _, child in ipairs(main:GetChildren()) do
			if child:IsA("ImageButton") then
				child.Visible = visible
			end
		end
	end

	CollectShowcase = function()
		local ItemConfig = require(game:GetService("ReplicatedStorage").ItemConfig)
		local tbl3 = {}
		local tbl4 = {}

		for _, v3 in ipairs(GetInventoryItems()) do
			local v4 = ShowcaseGroups.Weapons[v3.Type] and tbl3 or ShowcaseGroups.Powers[v3.Type] and tbl4
			local v5 = ShowcaseGroups.Weapons[v3.Type] or ShowcaseGroups.Powers[v3.Type]

			if v4 then
				local ok, result = pcall(function()
					return ItemConfig.match(v3.ItemId):unwrap()
				end)

				local sprite = ok and result.Display and result.Display.Sprite
				ok = ok and result.Quality and result.Quality.RarityValue or 0

				if sprite and ok >= v5 then
					table.insert(v4, { Item = v3, Sprite = sprite, Rarity = ok })
				end
			end
		end

		local function fn(arg, arg2)
			if arg.Rarity ~= arg2.Rarity then
				return arg.Rarity > arg2.Rarity
			end
			return (arg.Item.Mastery or 0) > (arg2.Item.Mastery or 0)
		end

		table.sort(tbl3, fn)
		table.sort(tbl4, fn)
		return tbl3, tbl4
	end

	FormatNumber = function(arg)
		return (tostring(math.floor(tonumber(arg) or 0)):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))
	end

	SectionLocalPlayerMain.CreateButton({ Title = "Show Items", Desc = "Press again to hide" }, function()
		local playerGui = localPlayer.PlayerGui
		local vxezeShowcase = playerGui:FindFirstChild("VxezeShowcase")

		if vxezeShowcase then
			vxezeShowcase:Destroy()
			SetHudVisible(true)
			return
		end

		local v3, v4 = CollectShowcase()
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "VxezeShowcase"
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false
		screenGui.DisplayOrder = 50
		local Weapons = CreateShowcaseColumn("Weapons", UDim2.new(0, 0, 0, 0))
		local Powers = CreateShowcaseColumn("Powers", UDim2.new(0.5, 0, 0, 0))

		for i_, v5 in ipairs(v3) do
			AddShowcaseIcon(Weapons, v5, i_)
		end

		for i_, v5 in ipairs(v4) do
			AddShowcaseIcon(Powers, v5, i_)
		end

		Weapons.Parent = screenGui
		Powers.Parent = screenGui
		local data = localPlayer:FindFirstChild("Data")
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = "Money"
		textLabel.BackgroundTransparency = 1
		textLabel.Position = UDim2.new(0, 12, 0.86, 0)
		textLabel.Size = UDim2.new(0, 420, 0, 76)
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 26
		textLabel.RichText = true
		textLabel.TextColor3 = Color3.new(1, 1, 1)
		textLabel.TextStrokeTransparency = 0
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.TextYAlignment = Enum.TextYAlignment.Top
		textLabel.Text = "<font color=\"rgb(90,220,110)\">$" .. FormatNumber(data and data.Beli.Value) .. "</font>\n<font color=\"rgb(180,120,255)\">ƒ" .. FormatNumber(data and data.Fragments.Value) .. "</font>"
		textLabel.Parent = screenGui
		screenGui.Parent = playerGui
		SetHudVisible(false)
		VxezeNotify("Show Items", #v3 .. " weapons and " .. #v4 .. " powers on screen", "info")
	end)

	SectionLocalPlayerMain.CreateButton({ Title = "Open Devil Fruit Shop" }, function()
		local FruitShop = require(game.ReplicatedStorage.Controllers.UI.FruitShop)
		FruitShop.init()
		FruitShop:Open()
	end)

	SectionLocalPlayerMain.CreateButton({ Title = "Open Devil Fruit Shop Mirage" }, function()
		local FruitShop = require(game.ReplicatedStorage.Controllers.UI.FruitShop)
		FruitShop.init()
		FruitShop:Open("AdvancedFruitDealer")
	end)

	SectionLocalPlayerMain.CreateButton({ Title = "Title and Color", Desc = "Opens the title list and the Haki colors" }, function()
		local titlesMenu = localPlayer.PlayerGui:FindFirstChild("TitlesMenu")

		if titlesMenu and titlesMenu:FindFirstChild("Open") then
			titlesMenu.Open:Fire()
		end
	end)

	StatCap = workspace:GetAttribute("LEVEL_CAP") or 3000

	SpendStatPoints = function()
		local data = localPlayer:FindFirstChild("Data")
		if not data or data.Points.Value <= 0 then
			return
		end
		local v3 = StatCap
		local tbl3 = {}
		local v4 = pairs
		local selectStats = Settings["Select Stats"] or {}

		for k, selectStat in v4(selectStats) do
			selectStat = selectStat and data.Stats:FindFirstChild(k)

			if selectStat and selectStat.Level.Value < v3 then
				table.insert(tbl3, selectStat)
			end
		end

		if #tbl3 == 0 then
			return
		end
		local n = math.max(1, math.floor(data.Points.Value / #tbl3))

		for _, v5 in ipairs(tbl3) do
			local n2 = math.min(n, v3 - v5.Level.Value, data.Points.Value)

			if n2 > 0 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", v5.Name, n2)
			end
		end
	end

	SectionLocalPlayerMain.CreateDropdown({
		Title = "Select Stats",
		List = PrepareMultiSelectList({ Melee = false, Defense = false, Sword = false, Gun = false, ["Demon Fruit"] = false }, Settings["Select Stats"]),
		Search = false,
		Selected = true,
		Default = Settings["Select Stats"] or nil,
	}, function(arg, arg2)
		SaveSettings("Select Stats", arg, arg2)
	end)

	SectionLocalPlayerMain.CreateToggle({
		Title = "Auto Stats",
		Desc = "Adds free points whenever you have them, split evenly, max 3000 per stat",
		Default = Settings["Auto Stats"] or false,
	}, function(arg)
		SaveSettings("Auto Stats", arg)
		if not arg or StatLoopRunning then
			return
		end
		StatLoopRunning = true

		task.spawn(function()
			while Settings["Auto Stats"] do
				local ok, result = pcall(SpendStatPoints)

				if not ok then
					VxezeReportError("Auto Stats", result)
				end

				task.wait(1)
			end

			StatLoopRunning = false
		end)
	end)

	SectionLocalPlayerMain.CreateDropdown({
		Title = "Select Team",
		Desc = "Picked for you when the side screen shows up",
		List = { "Pirate", "Marine" },
		Search = false,
		Selected = false,
		Default = Settings["Select Team"] or "Pirate",
	}, function(arg)
		SaveSettings("Select Team", arg)
	end)

	SectionLocalPlayerMain.CreateDropdown({
		Title = "Change Team",
		List = { "Pirates", "Marines" },
		Search = false,
		Selected = false,
		Default = nil,
	}, function(arg)
		if not arg then
			return
		end

		if localPlayer.Team and localPlayer.Team.Name == arg then
			VxezeNotify("Team", "You are already a " .. arg:sub(1, -2), "info")
			return
		end

		task.spawn(function()
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", arg)
			end)

			task.wait(1.5)

			if localPlayer.Team and localPlayer.Team.Name == arg then
				VxezeNotify("Team", "Switched to " .. arg, "success")
			else
				VxezeNotify("Team", "The game did not let you switch to " .. arg .. " right now", "warning")
			end
		end)
	end)

	SetRobloxGUI = function(enabled)
		game.CoreGui.RobloxGui.Enabled = enabled
	end

	spawn(function()
		while true do
			task.wait(1)
			if not (game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")) then
				continue
			end
			break
		end

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "VxezeBlackScreen"
		screenGui.IgnoreGuiInset = true
		screenGui.DisplayOrder = 999
		screenGui.ResetOnSpawn = false
		screenGui.Parent = game.Players.LocalPlayer.PlayerGui
		getgenv().SCGUI = screenGui
		BlackScreenImage = Instance.new("ImageLabel", SCGUI)
		BlackScreenImage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		BlackScreenImage.BorderSizePixel = 0
		BlackScreenImage.Position = UDim2.new(0, 0, 0, 0)
		BlackScreenImage.Size = UDim2.new(1, 0, 1, 0)
		BlackScreenImage.Visible = Settings["Black Screen"] == true
		BlackScreenImage.Name = "Black Screen"
		getgenv().BS_Text = Instance.new("TextLabel", BlackScreenImage)
		BS_Text.TextSize = 30
		BS_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
		BS_Text.AnchorPoint = Vector2.new(0.5, 0)
		BS_Text.Position = UDim2.new(0.5, 0, 0.6, 0)
		BS_Text.Font = Enum.Font.SourceSansBold
		BS_Text.RichText = true
		BS_Default = "\n<font color=\"rgb(45, 45, 45)\"><font size=\"20\">Black Screen</font></font>"

		getgenv().UpdateBlackScreenText = function(arg)
			BS_Text.Text = arg .. BS_Default
		end

		UpdateBlackScreenText("")
		getgenv().DisableBlackScreen = false
	end)

	IslandSpots = {
		{
			["Start Island"] = CFrame.new(1071.2832, 16.3085976, 1426.86792),
			["Marine Start"] = CFrame.new(-2573.3374, 6.88881969, 2046.99817),
			["Middle Town"] = CFrame.new(-655.824158, 7.88708115, 1436.67908),
			Jungle = CFrame.new(-1249.77222, 11.8870859, 341.356476),
			["Pirate Village"] = CFrame.new(-1122.34998, 4.78708982, 3855.91992),
			Desert = CFrame.new(1094.14587, 6.47350502, 4192.88721),
			["Frozen Village"] = CFrame.new(1198.00928, 27.0074959, -1211.73376),
			["Marine Fortress"] = CFrame.new(-4505.375, 20.687294, 4260.55908),
			Colosseum = CFrame.new(-1428.35474, 7.38933945, -3014.37305),
			["Sky Island 1"] = CFrame.new(-4970.21875, 717.707275, -2622.35449),
			["Sky Island 2"] = CFrame.new(-4813.0249, 903.708557, -1912.69055),
			["Sky Island 3"] = CFrame.new(-7952.31006, 5545.52832, -320.704956),
			Prison = CFrame.new(4854.16455, 5.68742752, 740.194641),
			["Magma Village"] = CFrame.new(-5231.75879, 8.61593437, 8467.87695),
			["Underwater City"] = CFrame.new(61163.8516, 11.7796879, 1819.78418),
			["Fountain City"] = CFrame.new(5132.7124, 4.53632832, 4037.8562),
			["Cyborg House"] = CFrame.new(6262.72559, 71.3003616, 3998.23047),
			["Shanks Room"] = CFrame.new(-1442.16553, 29.8788261, -28.3547478),
			["Mob Island"] = CFrame.new(-2850.20068, 7.39224768, 5354.99268),
		},
		{
			["First Spot"] = CFrame.new(82.9490662, 18.0710983, 2834.98779),
			["Flamingo Mansion"] = CFrame.new(-390.096313, 331.886475, 673.464966),
			["Flamingo Room"] = CFrame.new(2302.19019, 15.1778421, 663.811035),
			["Green Zone"] = CFrame.new(-2372.14697, 72.9919434, -3166.51416),
			Cafe = CFrame.new(-385.250916, 73.0458984, 297.388397),
			Factory = CFrame.new(430.42569, 210.019623, -432.504791),
			Colosseum = CFrame.new(-1836.58191, 44.5890656, 1360.30652),
			["Graveyard Island"] = CFrame.new(-5571.84424, 195.182297, -795.432922),
			["Graveyard Shore"] = CFrame.new(-5931.77979, 5.19706631, -1189.6908),
			["Snow Mountain"] = CFrame.new(1384.68298, 453.569031, -4990.09766),
			["Hot and Cold"] = CFrame.new(-6026.96484, 14.7461271, -5071.96338),
			["Magma Side"] = CFrame.new(-5478.39209, 15.9775667, -5246.9126),
			["Cursed Ship"] = CFrame.new(902.059143, 124.752518, 33071.8125),
			["Ice Castle"] = CFrame.new(5400.40381, 28.21698, -6236.99219),
			["Forgotten Island"] = CFrame.new(-3043.31543, 238.881271, -10191.5791),
			["Usoapp Island"] = CFrame.new(4748.78857, 8.35370827, 2849.57959),
			["Raid Lab"] = CFrame.new(-5554.95313, 329.075623, -5930.31396),
			["Mini Sky"] = CFrame.new(-260.358917, 49325.7031, -35259.3008),
		},
		{
			["Port Town"] = CFrame.new(-287, 30, 5388),
			["Hydra Island"] = CFrame.new(3399.32227, 72.4142914, 1572.99963),
			["Secret Temple"] = CFrame.new(5247, 7, 1097),
			["Hydra House"] = CFrame.new(5245, 602, 251),
			["Great Tree"] = CFrame.new(2443, 36, -6573),
			["Castle on the Sea"] = CFrame.new(-5500, 314, -2855),
			Mansion = CFrame.new(-12548, 337, -7481),
			["Floating Turtle"] = CFrame.new(-10016, 332, -8326),
			["Haunted Castle"] = CFrame.new(-9509.34961, 142.130661, 5535.16309),
			["Peanut Island"] = CFrame.new(-2131, 38, -10106),
			["Ice Cream Island"] = CFrame.new(-950, 59, -10907),
			["Cake Island"] = CFrame.new(-1762, 38, -11878),
			["Tiki Outpost"] = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375),
			["Submerged Island"] = CFrame.new(11427, -2155, 9730),
			["Sealed Cavern"] = CFrame.new(10437.38671875, -2227.3862304688, 9670.982421875),
		},
	}

	GetIslandSpots = function()
		local v3 = GetCurrentSea()
		if TeleportCache and TeleportCache.sea == v3 then
			return TeleportCache.spots, TeleportCache.names
		end
		local tbl3 = {}
		local v4 = pairs
		local tbl4 = IslandSpots[v3] or {}

		for k, v5 in v4(tbl4) do
			tbl3[k] = v5
		end

		for _, child in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
			local name_ = child.Name

			if not tbl3[name_] and name_ ~= "Sea" and not name_:find("Dimension") and not name_:find("Trial") and not name_:find("Arena") then
				local hit = workspace:Raycast(child.Position + Vector3.new(0, 60, 0), Vector3.new(0, -120, 0))

				if hit and math.abs(hit.Position.Y - child.Position.Y) < 8 then
					tbl3[name_] = CFrame.new(hit.Position + Vector3.new(0, 5, 0))
				end
			end
		end

		local tbl5 = {}

		for k in pairs(tbl3) do
			table.insert(tbl5, k)
		end

		table.sort(tbl5)
		TeleportCache = { sea = v3, spots = tbl3, names = tbl5 }
		return tbl3, tbl5
	end

	GetNpcNames = function()
		local tbl3 = {}
		local tbl4 = {}
		local v3 = ipairs
		local tbl5 = {}
		local npCs = workspace:FindFirstChild("NPCs")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local findFirstChild = ReplicatedStorage.FindFirstChild
		tbl5[1] = npCs

		do
			local values = table.pack(findFirstChild(ReplicatedStorage, "NPCs"))
			table.move(values, 1, values.n, 2, tbl5)
		end

		for _, v4 in v3(tbl5) do
			local v5 = ipairs
			v4 = v4 and v4:GetChildren()
			local tbl6 = v4 or {}

			for _, v6 in v5(tbl6) do
				local name_ = v6.Name

				if not tbl3[name_] and not name_:find("Boat") and not name_:find("Set Home") then
					tbl3[name_] = true
					table.insert(tbl4, name_)
				end
			end
		end

		table.sort(tbl4)
		return tbl4
	end

	FindNpcSpot = function(arg)
		local v3 = ipairs
		local tbl3 = {}
		local npCs = workspace:FindFirstChild("NPCs")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local findFirstChild = ReplicatedStorage.FindFirstChild
		tbl3[1] = npCs

		do
			local values = table.pack(findFirstChild(ReplicatedStorage, "NPCs"))
			table.move(values, 1, values.n, 2, tbl3)
		end

		for _, v4 in v3(tbl3) do
			v4 = v4 and v4:FindFirstChild(arg)

			if v4 then
				v4 = v4:FindFirstChild("HumanoidRootPart") or v4.PrimaryPart
			end

			if v4 then
				return v4.CFrame
			end
		end
	end

	TeleportToggles = {}

	FinishTeleport = function(arg, arg2)
		notsave[arg] = false

		if TeleportToggles[arg] then
			TeleportToggles[arg]:SetStage(false)
		end

		VxezeNotify("Teleport", arg2, "success")
	end

	local v3
	v3, v3 = GetIslandSpots()

	SectionLocalPlayerMain.CreateDropdown({ Title = "Select Npc", List = GetNpcNames(), Search = true, Selected = false, Default = nil }, function(arg)
		notsave["Select Npc"] = arg
	end)

	TeleportToggles["Teleport To Npc"] = SectionLocalPlayerMain.CreateToggle({ Title = "Teleport To Npc", Desc = "Turns itself off when you arrive", Default = false }, function(arg)
		notsave["Teleport To Npc"] = arg
	end)

	SectionLocalPlayerMain.CreateDropdown({ Title = "Select Island", List = v3, Search = true, Selected = false, Default = nil }, function(arg)
		notsave["Select Island"] = arg
	end)

	TeleportToggles["Teleport To Island"] = SectionLocalPlayerMain.CreateToggle({ Title = "Teleport To Island", Desc = "Turns itself off when you arrive", Default = false }, function(arg)
		notsave["Teleport To Island"] = arg
	end)

	TeleportToggles["Teleport Mirage"] = SectionLocalPlayerMain.CreateToggle({
		Title = "Teleport Mirage",
		Desc = "Goes to the Advanced Fruit Dealer when Mirage is up",
		Default = false,
	}, function(arg)
		notsave["Teleport Mirage"] = arg
	end)

	TeleportToggles["Teleport Prehistoric Island"] = SectionLocalPlayerMain.CreateToggle({
		Title = "Teleport Prehistoric Island",
		Desc = "Goes to the Fossil Expert when the island is up",
		Default = false,
	}, function(arg)
		notsave["Teleport Prehistoric Island"] = arg
	end)

	NoclipParts = {}
	NoclipPartsFor = nil
	NoclipRefreshAt = 0
	RefreshNoclipParts = function(n)local L= localPlayer .Character;if not L then table.clear(NoclipParts);NoclipPartsFor=nil;return NoclipParts;end;if not n and NoclipPartsFor==L and tick()-NoclipRefreshAt<2 then return NoclipParts;end;table.clear(NoclipParts);for c,c in ipairs(L:GetDescendants())do if c:IsA("BasePart")then table.insert(NoclipParts,c);end;end;NoclipPartsFor=L;NoclipRefreshAt=tick();return NoclipParts;end
	NoclipChanged = setmetatable({}, { __mode = "k" })
	SetNoClip = function(n)getgenv().noclip=n;local L= localPlayer .Character;if not L then return;end;local c,U=L:FindFirstChild("HumanoidRootPart"),L:FindFirstChildOfClass("Humanoid");if not n then for n in pairs(NoclipChanged)do if n.Parent then n.CanCollide=true;end;end;table.clear(NoclipChanged);if U then U.PlatformStand=false;end;if c and(c:FindFirstChild("FloatForce"))and not ToggleNoclip()then c.FloatForce:Destroy();end;end;end
	NoclipCache = { value = false, checked = 0 }
	ToggleNoclip = function()if TweenManager and tick()<(TweenManager.PauseUntil or 0)then return false;end;if os.clock()-NoclipCache.checked>0.1 then NoclipCache.checked=os.clock();NoclipCache.value=ComputeNoclip()==true;end;return NoclipCache.value;end
	ComputeNoclip = function()if Settings["Start Farm"]or Settings["Auto Present Event"]or Settings["Auto Celestial Soldier"]or Settings["Auto Rip Commander"]or Settings["Auto Event Halloween"]or Settings["Auto Attack Dungeon"]or Settings["Auto Fishing"]or Settings["Auto Collect Fruits"]or Settings["Auto Factory"]or Settings["Auto Pirate Raid"]or Settings["Auto Elite Hunter"]or Settings["Auto Touch Pad Haki"]or Settings["Auto Summon Rip Indra"]or Settings["Attack Rip Indra"]or Settings["Attack Soul Reaper"]or Settings["Attack Dough King"]or Settings["Attack Darkbeard"]or Settings["Auto Raid"]or Settings["Auto Sea Event"]or Settings["Auto Shipwright"]or Settings["Teleport Acient Clock"]or TempleTeleporting or Settings["Auto Magnet Event"]or Settings["Auto Secret Quest"]or Settings["Auto Upgrade Race V2-V3"]or Settings["Auto Trial"]or Settings["Auto Get Ghoul"]or Settings["Auto Get Cyborg"]or Settings["Auto Pull Lever"]or  notsave ["Teleport Mirage"]or  notsave ["Teleport To Island"]or  notsave ["Teleport To Npc"]or  notsave ["Teleport Prehistoric Island"]or  notsave ["Sanguine Art"]or  notsave ["God Human"]or  notsave ["Dragon Talon"]or  notsave ["Electric Claw"]or  notsave ["Sharkman Karate"]or  notsave ["Death Step"]or  notsave .SuperHuman or  notsave .DragonClaw or  notsave .Electro or  notsave ["Fishman Karate"]or  notsave ["Black Leg"]or Settings["Teleport To Kitsune Island"]or Settings["Auto Spawn Kitsune Island"]or Settings["Auto Collect Soul Ember"]or Settings["Auto Summon Soul Ember"]or Settings["Auto Attack Leviathan"]or Settings["Auto Soul Guitar"]or Settings["Auto CDK"]or Settings["Auto Yama"]or Settings["Auto Tushita"]or Settings["Auto Upgrade Sword Inventory"]or Settings["Teleport Player"]or Settings["Auto Collect Chests"]or Settings["Auto Farm Observation"]or Settings["Auto Upgrade Gun Inventory"]or Settings["Kill Boss"]or Settings["Farm Mob"]or Settings["Auto Observation v2"]or Settings["Auto New World"]or Settings["Auto Saber"]or Settings["Auto Third World"]or Settings["Tween Safe if have Items"]or Settings["Teleport Frozen Dimension"]or Settings["Auto Yoru Mini"]or Settings["Auto Dojo Trainer"]or Settings["Auto Dragon Hunter"]or Settings["Auto Crafting Volcanic Magnet"]or Settings["Auto Find Prehistoric Island"]or Settings["Auto Find Mirage"]or Settings["Auto Event Prehistoric Island"]or Settings["Auto Collect Bone"]or Settings["Auto Collect Berries"]or Settings["Auto Upgrade Race V2-V3 Draco"]or Settings["Auto Trial Draco"]or Settings["Auto Get Rainbow Haki"]or Settings["Follow Player Select"]or Settings["Auto Tween To Prehistoric Island"]or Settings["Auto Kill Golem"]or Settings["Auto Fix Volcano"]or Settings["Multi Find Leviathan"]or Settings["Fully Event Prehistoric Island"]or Settings["Auto Multi Raid"]or Settings["Auto Fire Shoot Heart Leviathan"]or Settings["Auto Buy Chip and Attack Law"]or Settings["Fully Trial Draco"]or Settings["Auto Finish Train Quest"]or Settings["Auto Destroy IDK"]or Settings["Auto Finish Train Draco Quest"]or Settings["Auto TTK"]or Settings["Auto Collect Egg"]or Settings["Collect Chest When Server Spawn Legend Items"]then return true;end;end
	local TweenService = game:GetService("TweenService")

	getgenv().TweenManager = {
		currentTween = nil,
		currentPart = nil,
		currentGoal = nil,
		TweenRunning = false,
		CancelTweenOnly = function()
			local currentTween = TweenManager.currentTween
			local tween = getgenv().Tween

			if currentTween then
				pcall(function()
					currentTween:Cancel()
					currentTween:Destroy()
				end)
			end

			if tween and tween ~= currentTween then
				pcall(function()
					tween:Cancel()
					tween:Destroy()
				end)
			end

			TweenManager.currentTween = nil
			TweenManager.currentPart = nil
			TweenManager.currentGoal = nil
			TweenManager.TweenRunning = false
			getgenv().Tween = nil
		end,
		PlayTween = function(currentPart, arg, arg2, arg3)
			if not currentPart or not arg or not arg2 or not arg2.CFrame then
				return
			end

			if TweenManager.currentTween and TweenManager.currentPart == currentPart and TweenManager.currentGoal and ((arg3 or {}).TargetEpsilon or 12) >= (TweenManager.currentGoal.Position - arg2.CFrame.Position).Magnitude then
				return TweenManager.currentTween
			end
			TweenManager.CancelTweenOnly()
			local tween = TweenService:Create(currentPart, arg, arg2)
			TweenManager.currentTween = tween
			TweenManager.currentPart = currentPart
			TweenManager.currentGoal = arg2.CFrame
			TweenManager.TweenRunning = true
			getgenv().Tween = tween

			tween.Completed:Connect(function()
				if TweenManager.currentTween == tween then
					TweenManager.currentTween = nil
					TweenManager.currentPart = nil
					TweenManager.currentGoal = nil
					TweenManager.TweenRunning = false
					getgenv().Tween = nil

					pcall(function()
						tween:Destroy()
					end)
				end
			end)

			tween:Play()
			return tween
		end,
		CancelCurrent = function()
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

			if TweenManager.currentTween or getgenv().Tween or humanoidRootPart and humanoidRootPart:FindFirstChild("FloatForce") then
				TweenManager.CancelTweenOnly()

				pcall(function()
					if not character then
						return
					end

					for k in pairs(NoclipChanged) do
						if k.Parent then
							k.CanCollide = true
						end
					end

					table.clear(NoclipChanged)
					local humanoid = character:FindFirstChildOfClass("Humanoid")

					if humanoid then
						humanoid.PlatformStand = false
					end

					if humanoidRootPart and humanoidRootPart:FindFirstChild("FloatForce") then
						humanoidRootPart.FloatForce:Destroy()
					end
				end)
			end
		end,
	}

	TweenManager = getgenv().TweenManager
	local Players, VirtualInputManager, ReplicatedStorage, RunService, tbl3

	do
		local tbl4 = {
			Sea1 = {
				Colosseum = Vector3.new(-2143.4133, 152.07433, -3025.5461),
				Desert = Vector3.new(1330.683, 103.55368, 4489.306),
				Fountain = Vector3.new(5420.3364, 431.04068, 4396.387),
				Jungle = Vector3.new(-1340.2195, 136.02054, -101.374214),
				["Marine Fortress"] = Vector3.new(-5180.2383, 281.34344, 4383.0317),
				["Middle Town"] = Vector3.new(-703.1675, 9.5518875, 1575.1864),
				["Pirate Village"] = Vector3.new(-807.6621, 27.802052, 4119.3013),
				Prison = Vector3.new(5270.5693, 163.50847, 844.7282),
				Sky = Vector3.new(-4808.769, 721.32635, -2668.8179),
				Snow = Vector3.new(1394.464, 39.044888, -1321.639),
				["Starter Island"] = Vector3.new(1038.2997, 112.136505, 1287.8345),
				["Starter Marine"] = Vector3.new(-3096.5193, 231.44356, 2087.5193),
				Underwater = Vector3.new(61147.977, 20.57084, 1366.0984),
				["Upper Sky"] = Vector3.new(-7950.0366, 5815.6846, -1968.3374),
				Volcano = Vector3.new(-5513.9785, 64.494316, 8577.4),
			},
			Sea2 = {
				Cafe = Vector3.new(-382, 74, 356),
				Colosseum = Vector3.new(-1836, 46, 1642),
				["Dark Arena"] = Vector3.new(3948, 13, -3479),
				["Docks 1"] = Vector3.new(-923, 8, 1810),
				["Docks 2"] = Vector3.new(-13, 39, 2708),
				["Docks 3"] = Vector3.new(-1944, 9, -2594),
				["Docks 4"] = Vector3.new(-5798, 1, -5021),
				Doghouse = Vector3.new(-1984, 125, -82),
				Graveyard = Vector3.new(-5710, 126, -775),
				["Haunted Ship"] = Vector3.new(937, 125, 32879),
				Lab = Vector3.new(-5542, 335, -5924),
				Lava = Vector3.new(-5280, 7, -5618),
				Mansion = Vector3.new(-494, 339, 593),
				Raid = Vector3.new(-6503, 251, -4495),
				Remote = Vector3.new(4766, 8, 2911),
				Skull = Vector3.new(-2956.2434, 123.39932, -9981.069),
				Snow = Vector3.new(1210, 429, -4663),
				["Winter Castle"] = Vector3.new(5544.718, 60.139385, -6359.089),
			},
			Sea3 = {
				["Cake Land"] = Vector3.new(-2098.9705, 76.39494, -12128.359),
				["Chocolate Land"] = Vector3.new(379.13962, 130.206, -12720.84),
				["Great Tree"] = Vector3.new(4345.0938, 575.0524, -6159.0044),
				["Haunted Castle"] = Vector3.new(-9515.001, 149.18877, 5534.0503),
				["Hydra Arena"] = Vector3.new(5020.946, 174.08646, -2011.185),
				["Hydra Town"] = Vector3.new(5288.6216, 1011.6528, 392.4297),
				["Ice Cream Land"] = Vector3.new(-917.5485, 63.364143, -10858.696),
				["Peanut Land"] = Vector3.new(-2037.8002, 13.651118, -9948.202),
				Port = Vector3.new(-342.43436, 23.831549, 5547.3457),
				["Sea Castle"] = Vector3.new(-5502.1787, 323.6709, -2863.4617),
				["Tiki Outpost"] = Vector3.new(-16456.463, 530.25195, 436.2318),
				["Turtle Center"] = Vector3.new(-12007.9795, 339.1555, -9178.58),
				["Turtle Entrance"] = Vector3.new(-10163.965, 340.29028, -8320.768),
				["Turtle Mansion"] = Vector3.new(-12538.422, 339.3936, -7817.071),
				["Turtle Mountain"] = Vector3.new(-12856.613, 852.7536, -10715.23),
			},
		}

		local tbl5 = {}
		local CollectionService = game:GetService("CollectionService")
		local n2 = 0
		local flag = false
		MarkTeleporting = function(...) end

		task.spawn(function()
			while task.wait(0.1) do
				if flag and tick() >= n2 then
					CollectionService:RemoveTag(localPlayer, "Teleporting")
					flag = false
				end
			end
		end)

		spawn(function()
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetUnlockables")
			local response

			repeat
				task.wait()
				response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetUnlockables")
			until response

			if response.DefeatedIndraTrueForm and Place_Id.sea3() then
				tbl5["Caslte On The Sea"] = Vector3.new(-4967.6826, 314.8824, -3157.0984)
				tbl5.Hydra = Vector3.new(5661.5303, 1013.4113, -334.9619)
				tbl5.Mansion = Vector3.new(-12463.874, 374.91446, -7523.774)
			end
		end)

		Players = game:GetService("Players")
		game:GetService("ReplicatedStorage")
		VirtualInputManager = game:GetService("VirtualInputManager")

		IsPortalFruitReady = function()
			local devilFruit = localPlayer.Data:FindFirstChild("DevilFruit")
			if not devilFruit or devilFruit.Value ~= "Portal-Portal" then
				return false
			end
			local c = localPlayer.PlayerGui.Main.Skills:FindFirstChild(devilFruit.Value)
			c = c and c:FindFirstChild("C")

			if not c or not c:IsA("Frame") then
				local portalPortal = localPlayer.Character:FindFirstChild("Portal-Portal") or localPlayer.Backpack:FindFirstChild("Portal-Portal")
				if not portalPortal then
					return false
				end
				localPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(portalPortal)
				return false
			end

			local cooldown = c:FindFirstChild("Cooldown")
			return c.Title.TextColor3 == Color3.new(1, 1, 1) and (cooldown.Size == UDim2.new(0, 0, 1, -1) or cooldown.Size == UDim2.new(1, 0, 1, -1))
		end

		ActivatePortalGateway = function(arg)
			local portalPortal = localPlayer.Character:FindFirstChild("Portal-Portal") or localPlayer.Backpack:FindFirstChild("Portal-Portal")
			if not portalPortal then
				return false
			end
			localPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(portalPortal)
			local gateway = localPlayer.PlayerGui.Main:FindFirstChild("Gateway")
			if not gateway then
				return false
			end

			pcall(function()
				VirtualInputManager:SendKeyEvent(true, "C", false, game)
			end)

			pcall(function()
				VirtualInputManager:SendKeyEvent(false, "C", false, game)
			end)

			local n = tick() + 3

			while true do
				task.wait(0.1)
				if not (gateway.Visible or tick() > n) then
					continue
				end
				break
			end

			if not gateway.Visible then
				return false
			end
			local mainContent = gateway:FindFirstChild("MainContent")
			if not mainContent then
				return false
			end
			local v4 = mainContent.ScrollingFrame:FindFirstChild(tostring(arg))

			if v4 and v4.MouseButton1Click then
				for _, v5 in pairs(getconnections(v4.MouseButton1Click)) do
					pcall(function()
						v5.Function()
					end)
				end

				return true
			end

			return false
		end

		local vector = Vector3.new(28282.57, 14896.851, 105.10427)

		local function fn()
			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			return humanoidRootPart ~= nil and (humanoidRootPart.Position - vector).Magnitude < 1000
		end

		BorrowTempleOfTime = function()
			local templeOfTime = game.ReplicatedStorage.MapStash:FindFirstChild("Temple of Time")
			if not templeOfTime then
				return
			end
			templeOfTime:SetAttribute("ClientBorrowed", true)
			templeOfTime.Parent = workspace.Map

			task.spawn(function()
				local n = tick() + 30

				while true do
					task.wait(0.25)
					if not (templeOfTime.Parent ~= workspace.Map or fn() or tick() > n) then
						continue
					end
					break
				end

				templeOfTime:SetAttribute("ClientBorrowed", nil)

				if not fn() and templeOfTime.Parent == workspace.Map then
					templeOfTime.Parent = game.ReplicatedStorage.MapStash
				end
			end)
		end

		GetTempleOfTime = function()
			local templeOfTime = workspace.Map:FindFirstChild("Temple of Time")
			if templeOfTime and not templeOfTime:GetAttribute("ClientBorrowed") then
				return templeOfTime
			end
		end

		TempleCenter = Vector3.new(28609.39, 14896.53, 106.42)
		TempleProgress = { value = nil, checked = 0 }

		IsInTempleOfTime = function()
			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			return Place_Id.sea3() and humanoidRootPart ~= nil and (humanoidRootPart.Position - TempleCenter).Magnitude <= 3000
		end

		GetTempleProgress = function()
			local checked = TempleProgress.checked

			if tick() - checked > 5 then
				local commF = game.ReplicatedStorage.Remotes.CommF_
				TempleProgress.checked = tick()
				TempleProgress.value = commF:InvokeServer("RaceV4Progress", "Check")

				if TempleProgress.value == 0 and commF:InvokeServer("CheckTempleDoor") then
					TempleProgress.value = 2
				end
			end

			return TempleProgress.value
		end

		TeleportTempleOfTime = function()
			if IsInTempleOfTime() then
				return "arrived"
			end

			if not GoToSea(3) then
				return "moving"
			end
			local commF = game.ReplicatedStorage.Remotes.CommF_
			local v4 = GetTempleProgress()

			if v4 == 1 then
				TempleProgress.checked = 0
				commF:InvokeServer("RaceV4Progress", "Begin")
				return "moving"
			end

			if not v4 or v4 == 0 then
				return "locked"
			end
			local v5 = DetectNpc("Mysterious Force")
			if not v5 then
				return "moving"
			end

			if localPlayer:DistanceFromCharacter(v5:GetPivot().Position) > 10 then
				ToTarget(v5:GetPivot() * CFrame.new(0, 0, 4))
				return "moving"
			end
			BorrowTempleOfTime()
			commF:InvokeServer("RaceV4Progress", "Teleport")
			task.wait(1)
			local str2

			if IsInTempleOfTime() then
				str2 = "arrived"
			else
				str2 = "moving"
			end

			return str2
		end

		getgenv().IsPlayerDead = function()
			if not localPlayer.Character or not localPlayer.Character:FindFirstChild("Humanoid") or localPlayer.Character.Humanoid.Health == 0 then
				return true
			end
		end

		CS = game:GetService("CollectionService")
		cam = workspace.CurrentCamera

		LoadIslandByFakePoint = function(arg)
			local part = Instance.new("Part")
			part.Transparency = 1
			part.CanCollide = false
			part.Anchored = true
			part.Size = Vector3.zero
			part.CFrame = CFrame.new(arg:GetPivot().Position)
			CS:AddTag(part, "LoDPosition")
			part.Parent = cam
			return part
		end

		spawn(function()
			pcall(function()
				for _, child in ipairs(workspace:GetChildren()) do
					if child:IsA("Model") and child:GetAttribute("LevelOfDetailDiameter") then
						LoadIslandByFakePoint(child)
					end
				end

				for _, child in ipairs(workspace.Map:GetChildren()) do
					if child:IsA("Model") then
						LoadIslandByFakePoint(child)
					end
				end

				for _, child in ipairs(game:GetService("ReplicatedStorage").FakeIslands:GetChildren()) do
					if child:IsA("Model") then
						LoadIslandByFakePoint(child)
					end
				end
			end)
		end)

		getgenv().TweenGuidePart = nil
		getgenv().TweenConnection = nil
		getgenv().TweenInProgress = false
		getgenv().lastTarget = nil
		LocationCache = { parts = nil, lookups = {} }

		GetTrackedLocations = function()
			if not LocationCache.parts then
				local locations = workspace._WorldOrigin.Locations
				LocationCache.parts = {}

				for _, child in ipairs(locations:GetChildren()) do
					if child:IsA("BasePart") and not child:GetAttribute("IgnoreInTracking") then
						table.insert(LocationCache.parts, child)
					end
				end

				if not LocationCache.connected then
					LocationCache.connected = true

					locations.ChildAdded:Connect(function()
						LocationCache.parts = nil
					end)

					locations.ChildRemoved:Connect(function()
						LocationCache.parts = nil
					end)
				end
			end

			return LocationCache.parts
		end

		FindNearestLocationPart = function(c)local n=math.floor(c.X/8)..","..math.floor(c.Y/8)..","..math.floor(c.Z/8);local L=LocationCache.lookups[n];if L and os.clock()-L.time<1 and(not L.part or L.part.Parent)then return L.part;end;local U,w;for y,y in ipairs(GetTrackedLocations())do L=(y.Position-c).Magnitude;if not U or L<U then U,w=L,y;end;end;if os.clock()-(LocationCache.cleared or 0)>5 then LocationCache.cleared=os.clock();table.clear(LocationCache.lookups);end;LocationCache.lookups[n]={part=w,time=os.clock()};return w;end
		GetLocationPartAt = function(c)local n=FindNearestLocationPart(c);if not n then return nil;end;local L=n:FindFirstChild("Mesh");if L then if L.Scale.X/2>=(n.Position-c).Magnitude then return n;else return nil;end;end;return n;end

		DetectNpcOni = function()
			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then
				return
			end
			local v4 = next
			local tbl6 = {}
			local npCs = workspace.NPCs
			local npCs2 = game:GetService("ReplicatedStorage").NPCs
			tbl6[1] = npCs
			tbl6[2] = npCs2
			local huge = math.huge
			local v5 = nil

			for _, v6 in v4, tbl6, nil do
				local v7 = next
				local children, v8 = v6:GetChildren()

				for _, v9 in v7, children, v8 do
					if v9:GetAttribute("NPCLoaded") and v9:GetAttribute("NPCReady") and v9:GetAttribute("DisplayName") == "Celestial Member" and v9:FindFirstChild("HumanoidRootPart") then
						local magnitude = (humanoidRootPart.Position - v9.HumanoidRootPart.Position).Magnitude

						if magnitude < huge then
							huge = magnitude
							v5 = v9
						end
					end
				end
			end

			return v5, huge
		end

		CelestialDomainController = require(game:GetService("ReplicatedStorage").Controllers.MapServices.CelestialDomainController)
		LocalPlayer = localPlayer
		ReplicatedStorage = game:GetService("ReplicatedStorage")
		WorldOrigin = workspace:WaitForChild("_WorldOrigin", 10)
		travelFunctions = {}
		PlrData = game:GetService("Players").LocalPlayer.Data
		localPlayerFunctions = {}

		localPlayerFunctions.IsAlive = function()
			local character = LocalPlayer.Character
			if not character then
				return false
			end
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				return false
			end
			return humanoid.Health > 0
		end

		GetRootPart = function()local c=LocalPlayer.Character;if not c then return nil;end;return c:FindFirstChild("HumanoidRootPart")or(c:FindFirstChild("UpperTorso"))or(c:FindFirstChild("Torso"));end

		travelFunctions.GetSpawnPosition = function(arg)
			local playerSpawns = WorldOrigin:FindFirstChild("PlayerSpawns")
			local team = playerSpawns and LocalPlayer.Team and playerSpawns:FindFirstChild(LocalPlayer.Team.Name)
			team = team and team:FindFirstChild(arg)
			return team and team:GetPivot().Position
		end

		travelFunctions.GetDistance = function(arg, arg2)
			if not localPlayerFunctions.IsAlive() then
				return math.huge
			end

			if not arg2 then
				local v4 = GetRootPart()
				if not v4 then
					return math.huge
				end
				arg2 = v4.Position
			end

			return (arg - arg2).Magnitude
		end

		AddFloatForce = function(c)if c:FindFirstChild("FloatForce")then return;end;local n=Instance.new("BodyVelocity");n.Name="FloatForce";n.Velocity=Vector3.new(0,0,0);n.MaxForce=Vector3.new(100000,100000,100000);n.P=10000;n.Parent=c;end
		RunService = game:GetService("RunService")
		tbl3 = { LastTP = 0, LastCF = nil, ActiveConnection = nil, LastCall = 0 }
		TweenSpeedLimit = 220
		TweenHoldUntil = 0
		getgenv().TweenState = getgenv().TweenState or {}
		TweenState = getgenv().TweenState
		TweenState.CurrentTween = nil
		TweenState.IsMoving = false
		TweenState.MoveStarted = 0
		TweenState.Goal = nil
		TweenState.Part = nil
		TweenState.Speed = nil
		TweenState.Epsilon = nil
		TweenState.Resets = 0
		TweenState.LastPos = nil
		SecurityKick = { NeedPause = 3, PauseTime = 0.4, MaxResets = 3, JumpGuard = 500, Retry = 0.3 }
		TweenSpeedWanted = function()return math.clamp(tonumber(Settings["Speed Tween"])or TweenSpeedLimit,1,TweenSpeedLimit);end
		StopTweenNow = function()TweenState.IsMoving=false;TweenState.CurrentTween=nil;TweenState.Goal=nil;TweenState.Resets=0;TweenState.LastPos=nil;TweenManager.CancelTweenOnly();local n= localPlayer .Character and( localPlayer .Character:FindFirstChild("HumanoidRootPart"));if n then n.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0);n.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0);end;if not ToggleNoclip()and not TweenRecentlyRequested()then SetNoClip(false);end;end
		TweenRecentlyRequested = function()return tick()-( tbl3 .LastCall or 0)<1.5;end
		getgenv().CharSpeedState = getgenv().CharSpeedState or { cap = 1000, nextRaise = 0 }
		CharSpeedState = getgenv().CharSpeedState
		TweenFrameStepCap = 18
		TweenStuckSpeedFloor = 120
		TweenJumpGuard = 40
		TweenPartTowardCFrame = function(...) end
		RetweenAfterKickGuard = function()local n,L,U=TweenState.Goal,TweenState.Speed,TweenState.Epsilon;StopTweenNow();task.wait(SecurityKick.Retry);local w= localPlayer .Character and( localPlayer .Character:FindFirstChild("HumanoidRootPart"));if w and n then TweenPartTowardCFrame(w,n,L,U);end;end
		TweenState.Pin = RunService.Heartbeat:Connect(function()if not TweenState.IsMoving or not TweenManager.TweenRunning then return;end;local n=TweenState.Part;local L= localPlayer .Character;if not n or not n.Parent or not L or n.Parent~=L then StopTweenNow();return;end;n.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0);n.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0);if not n:FindFirstChild("FloatForce")then AddFloatForce(n);end;getgenv().noclip=true;end)

		task.spawn(function()
			while task.wait(0.1) do
				local currentTween = TweenState.CurrentTween

				if not currentTween or not TweenManager.TweenRunning then
					TweenState.IsMoving = false
					TweenState.Resets = 0
				else
					local play = Settings["Prevent Security Kick"] and typeof(currentTween) == "table" and currentTween.Play
					local flag2

					if play then
						local moveStarted = TweenState.MoveStarted
						flag2 = tick() - moveStarted >= SecurityKick.NeedPause
					else
						flag2 = play
					end

					if flag2 then
						local part = TweenState.Part
						part = part and part.Position

						pcall(function()
							currentTween:Pause()
						end)

						task.wait(SecurityKick.PauseTime)
						TweenState.MoveStarted = tick()
						local v4 = TweenState
						v4.Resets = v4.Resets + 1

						if TweenState.Resets >= SecurityKick.MaxResets or part and TweenState.LastPos and (part - TweenState.LastPos).Magnitude > SecurityKick.JumpGuard then
							RetweenAfterKickGuard()
						elseif TweenState.CurrentTween == currentTween and TweenManager.TweenRunning then
							pcall(function()
								currentTween:Play()
							end)
						end

						TweenState.LastPos = part
					end
				end
			end
		end)

		FailedEntrances = {}
		LowHealth = false
		UpdateRetreat = function(c)if not Settings["Teleport Y"]or not c or c.MaxHealth<=0 then LowHealth=false;return;end;local n=c.Health/c.MaxHealth;if n<(tonumber(Settings["% Health Player"])or 40)/100 then LowHealth=true;elseif n>0.8 then LowHealth=false;end;end
		FlatDistance = function(c,n)if not c or not n then return 1/0;end;return(Vector3.new(c.X,0,c.Z)-Vector3.new(n.X,0,n.Z)).Magnitude;end
		AreaAt = function(c)local n=GetLocationPartAt(c);return n and n.Name or"";end
		TempleOfTimeSpot = CFrame.new(28609.392578125, 14896.533203125, 106.42165374755859)
		CakeLoafMirrorSpot = Vector3.new(-1990.67, 4532.97, -14973.67)

		TravelRules = {
			{
				Name = "Temple Of Time",
				Check = function(arg)
					return Place_Id.sea3() and (arg.Position - TempleOfTimeSpot.Position).Magnitude <= 3000 and not IsInTempleOfTime()
				end,
				Run = function()
					TeleportTempleOfTime()
				end,
			},
			{
				Name = "Race V4 Teleport Back",
				Check = function(arg, arg2)
					return Place_Id.sea3() and (arg.Position - TempleOfTimeSpot.Position).Magnitude > 3000 and (TempleOfTimeSpot.Position - arg2.Position).Magnitude <= 3000
				end,
				Run = function(arg, arg2)
					TweenPartTowardCFrame(arg2, TempleOfTimeSpot, 400, 8)

					if (TempleOfTimeSpot.Position - arg2.Position).Magnitude < 8 then
						local commF = game:GetService("ReplicatedStorage").Remotes.CommF_
						commF:InvokeServer("RaceV4Progress", "Check")
						commF:InvokeServer("RaceV4Progress", "TeleportBack")
						StopTweenNow()
						VxezeNotify("Travel", "Left the Temple of Time", "travel", { Key = "racev4back" })
					end
				end,
			},
			{
				Name = "Cake Loaf Big Mirror",
				Check = function(arg, arg2)
					local cakeLoaf = workspace.Map:FindFirstChild("CakeLoaf")
					cakeLoaf = cakeLoaf and cakeLoaf:FindFirstChild("BigMirror")
					return Place_Id.sea3() and cakeLoaf ~= nil and cakeLoaf:FindFirstChild("Main") ~= nil and (CakeLoafMirrorSpot - arg.Position).Magnitude <= 1000 and (CakeLoafMirrorSpot - arg2.Position).Magnitude > 1000
				end,
				Run = function(arg, arg2)
					TweenPartTowardCFrame(arg2, workspace.Map.CakeLoaf.BigMirror.Main.CFrame, 400, 8)
				end,
			},
		}

		RunTravelRules = function(arg, arg2)
			for _, v4 in ipairs(TravelRules) do
				local ok, result = pcall(v4.Check, arg, arg2)

				if ok and result then
					local ok2, result2 = pcall(v4.Run, arg, arg2)

					if not ok2 then
						VxezeReportError(v4.Name, result2)
					end

					return true
				end
			end

			return false
		end

		GatewayPads = {
			Sea1 = {
				{
					Name = "Enter Underwater City",
					Stand = Vector3.new(4050, 6, -1815),
					Dest = Vector3.new(61163.85, 11.6796875, 1819.7842),
				},
				{
					Name = "Leave Underwater City",
					Stand = Vector3.new(61170, 1, 1952),
					Dest = Vector3.new(3864.6885, 6.74402, -1926.2141),
				},
			},
			Sea2 = {
				{
					Name = "Enter Ghost Ship",
					Stand = Vector3.new(-6499, 91, -127),
					Dest = Vector3.new(923, 126, 32852),
				},
				{
					Name = "Leave Ghost Ship",
					Stand = Vector3.new(920, 155, 32838),
					Dest = Vector3.new(-6509, 89, -133),
				},
			},
			Sea3 = {
				{
					Name = "Castle to Mansion",
					Stand = Vector3.new(-5060.4116, 318.502, -3193.2249),
					Dest = Vector3.new(-12463.603, 378.32706, -7566.083),
					Requires = "Valkyrie Helm",
				},
				{
					Name = "Mansion to Castle",
					Stand = Vector3.new(-12463.603, 378.32706, -7566.083),
					Dest = Vector3.new(-5060.4116, 318.502, -3193.2249),
					Requires = "Valkyrie Helm",
				},
				{
					Name = "Castle to Hydra",
					Stand = Vector3.new(-5027.0303, 318.502, -3206.7036),
					Dest = Vector3.new(5650.9478, 1017.2748, -350.37918),
					Requires = "Valkyrie Helm",
				},
				{
					Name = "Hydra to Castle",
					Stand = Vector3.new(5650.9478, 1017.2748, -350.37918),
					Dest = Vector3.new(-5027.0303, 318.502, -3206.7036),
					Requires = "Valkyrie Helm",
				},
				{
					Name = "Castle to Tiki",
					Stand = Vector3.new(-5097.132, 318.502, -3178.3984),
					Dest = Vector3.new(-16814, 58, 304),
					Map = "Boat Castle",
					Touch = "MapTeleportC",
					Requires = "Feathered Visage",
				},
				{
					Name = "Tiki to Castle",
					Stand = Vector3.new(-16799.092, 84.3228, 291.07285),
					Dest = Vector3.new(-5084.727, 318.502, -3155.858),
					Map = "TikiOutpost",
					Touch = "MapTeleportC",
					Requires = "Feathered Visage",
				},
				{
					Name = "Enter Beautiful Pirate Domain",
					Part = "WaterfallBossHitbox",
					Arg = "WaterfallBossHitbox",
				},
				{
					Name = "Leave Beautiful Pirate Domain",
					Part = "TurtleEntranceBoss",
					Arg = "TurtleEntranceBoss",
				},
			},
		}

		TravelDistanceGate = 1500
		GatewayRouteGain = 1500
		GatewayState = { fired = 0, pad = nil, failed = {} }
		PartCache = {}
		FindNamedPart = function(c)local n=PartCache[c];if n and n.Parent then return n;end;n=workspace:FindFirstChild(c,true);PartCache[c]=n;return n;end
		GatewayStandSpot = function(c)if c.Stand then return c.Stand;end;if c.Part then local n=FindNamedPart(c.Part);if n then return n:IsA("BasePart")and n.Position or n:GetPivot().Position;end;end;end
		GatewayUnlocked = function(c)if tick()<(GatewayState.failed[c.Name]or 0)then return false;end;if c.Requires then local n,L=pcall(CheckItemInventory,c.Requires);if not(n and L)then return false;end;end;if not c.Touch then return true;end;local n=workspace:FindFirstChild("Map");local L=n and(n:FindFirstChild(c.Map or"Boat Castle"));n=L and(L:FindFirstChild(c.Touch));if not n then return true;end;return game:GetService("CollectionService"):HasTag(n,"BoatCastleTeleporter");end

		GatewayPadsHere = function()
			return GatewayPads[workspace:GetAttribute("MAP")] or {}
		end

		GatewayRouteCost = function(c,n,L)local U=(n-c).Magnitude;if L<=0 then return U,nil;end;local w;for y,S in ipairs(GatewayPadsHere())do if S.Dest and(GatewayUnlocked(S))then y=GatewayStandSpot(S);if y then local K=GatewayRouteCost(S.Dest,n,L-1);local n=(y-c).Magnitude+K;if n<U then U,w=n,S;end;end;end;end;return U,w;end
		GatewayRemote = function(n)if n.Touch then local L=workspace:FindFirstChild("Map");local U=L and(L:FindFirstChild(n.Map or"Boat Castle"));L=U and(U:FindFirstChild(n.Touch));local U=L and(L:FindFirstChild("Hitbox"));L= localPlayer .Character and( localPlayer .Character:FindFirstChild("HumanoidRootPart"));if U and L then firetouchinterest(L,U,0);task.wait(0.15);firetouchinterest(L,U,1);end;return;end;game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",n.Arg or n.Dest);end

		ActivateGateway = function(arg, arg2)
			local n = tick() + (arg.Touch and 3 or 8)
			local n3 = 0

			while true do
				local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart then
					return false
				end

				if (humanoidRootPart.Position - arg2).Magnitude > 200 then
					task.wait(1.5)
					return true
				end

				if not arg.Touch and (humanoidRootPart.Position - arg2).Magnitude > 3 then
					humanoidRootPart.CFrame = CFrame.new(arg2)
				end

				humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
				humanoidRootPart.AssemblyAngularVelocity = Vector3.zero

				if tick() - n3 > 0.3 then
					n3 = tick()
					pcall(GatewayRemote, arg)
				end

				RunService.Heartbeat:Wait()
				if not (n < tick()) then
					continue
				end
				break
			end

			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			local flag2 = humanoidRootPart ~= nil and (humanoidRootPart.Position - arg2).Magnitude > 200

			if flag2 then
				task.wait(1.5)
			end

			return flag2
		end

		GatewayTravel = function(arg, arg2)
			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart or arg2 < TravelDistanceGate then
				GatewayState.pad = nil
				return false
			end
			local v4, v5 = GatewayRouteCost(humanoidRootPart.Position, arg, 4)
			if not v5 or arg2 - v4 < GatewayRouteGain then
				GatewayState.pad = nil
				return false
			end
			local v6 = GatewayStandSpot(v5)
			if not v6 then
				GatewayState.pad = nil
				return false
			end
			GatewayState.hist = GatewayState.hist or {}
			local n = 0

			for i_ = #GatewayState.hist, 1, -1 do
				local v7 = GatewayState.hist[i_]
				local at = v7.at

				if tick() - at > 90 then
					table.remove(GatewayState.hist, i_)
				elseif v7.name == v5.Name then
					n += 1
				end
			end

			if n >= 2 then
				GatewayState.failed[v5.Name] = tick() + 90
				GatewayState.pad = nil
				VxezeNotify("Travel", v5.Name .. " keeps repeating, tweening instead", "warning", { Key = "gatewayloop", Repeat = 30 })
				return false
			end

			local magnitude = (humanoidRootPart.Position - v6).Magnitude

			if GatewayState.pad ~= v5 then
				GatewayState.pad = v5
				GatewayState.since = tick()
				GatewayState.bestReach = magnitude
				GatewayState.progressAt = tick()
				VxezeNotify("Travel", "Heading to " .. v5.Name, "travel", { Key = "gateway", Repeat = 10 })
			end

			if magnitude > 2 then
				TweenPartTowardCFrame(humanoidRootPart, CFrame.new(v6), TweenSpeedWanted(), 1.5)

				if magnitude < GatewayState.bestReach - 20 then
					GatewayState.bestReach = magnitude
					GatewayState.progressAt = tick()
				else
					local progressAt = GatewayState.progressAt

					if tick() - progressAt > 10 then
						GatewayState.failed[v5.Name] = tick() + 120
						GatewayState.pad = nil
						VxezeNotify("Travel", "Could not reach " .. v5.Name .. ", tweening the rest of the way", "warning", { Key = "gatewaystuck" })
					end
				end

				return true
			end

			StopTweenNow()

			if ActivateGateway(v5, v6) then
				GatewayState.pad = nil
				table.insert(GatewayState.hist, { name = v5.Name, at = tick() })
				return true
			end

			local since = GatewayState.since

			if tick() - since > 12 then
				GatewayState.failed[v5.Name] = tick() + 120
				GatewayState.pad = nil
				VxezeNotify("Travel", v5.Name .. " did not open, tweening instead", "warning", { Key = "gatewayfail" })
			end

			return true
		end

		PortalFruitTravel = function(arg, arg2)
			if not Settings["Use Portal Fruit Teleport"] or arg2 < 3000 then
				return false
			end
			local portalPortal = localPlayer.Character and localPlayer.Character:FindFirstChild("Portal-Portal") or localPlayer.Backpack:FindFirstChild("Portal-Portal")
			if not portalPortal or portalPortal.Level.Value <= 200 or not IsPortalFruitReady() then
				return false
			end
			local v4 = pairs
			local tbl6 = tbl4[workspace:GetAttribute("MAP")] or {}

			for k, v5 in v4(tbl6) do
				if not ((arg.Position - v5).Magnitude <= 3000) then
					continue
				end
				getgenv().noclip = true

				if ActivatePortalGateway(k) then
					VxezeNotify("Portal Fruit", "Opened a gateway to " .. k, "travel", { Key = "portaltp" })
					local n = tick() + 5

					while true do
						task.wait(0.2)
						if not (localPlayer.Character and (localPlayer.Character.HumanoidRootPart.Position - v5).Magnitude < 500 or tick() > n) then
							continue
						end
						break
					end

					return true
				end
			end

			return false
		end
	end

	SubmergedExit = CFrame.new(11427, -2155, 9730)
	SubmergedEntrance = CFrame.new(-16270, 25, 1379)
	SubmergedFloor = -1000
	IsSubmergedSpot = function(c)return c~=nil and c.Y<SubmergedFloor;end
	ToTarget = function(n,L)if typeof(n)~="CFrame"or tick()<(TweenManager.PauseUntil or 0)then return;end;local U= localPlayer .Character;local w,y=U and(U:FindFirstChild("HumanoidRootPart")),U and(U:FindFirstChildOfClass("Humanoid"));if not w or not y or y.Health<=0 then return;end; tbl3 .LastCall=tick();if y.Sit then StopTweenNow();task.wait(0.1);getgenv().noclip=false;pcall(function() VirtualInputManager :SendKeyEvent(true,"Space",false,game);end);task.wait();pcall(function() VirtualInputManager :SendKeyEvent(false,"Space",false,game);end);task.wait(0.1);if w:FindFirstChild("EffectsSY")then w.EffectsSY:Destroy();end;y.Jump=true;task.wait(0.1);w.CFrame=w.CFrame*CFrame.new(0,10,0);return;end;if not w:FindFirstChild("FloatForce")then AddFloatForce(w);end;getgenv().noclip=true;UpdateRetreat(y);U=CFrame.new();y=n*(if ReadyToDodge then(CFrame.new(0,200,0))else if LowHealth then(CFrame.new(0,tonumber(Settings["Distance Teleport Y"])or 800,0))else U);U=FlatDistance(y.Position,w.Position);if U<=100 and not LowHealth and not ReadyToDodge then StopTweenNow();MarkTeleporting();w.CFrame=y;return true;end;if RunTravelRules(n,w)then return;end;if PortalFruitTravel(n,U)then return;end;local c,S=IsSubmergedSpot(w.Position),IsSubmergedSpot(y.Position);if U>=3000 and c and not S then if FlatDistance(SubmergedExit.Position,w.Position)<=15 then task.wait(1);game:GetService("ReplicatedStorage").Modules.Net["RF/SubmarineTransportation"]:InvokeServer("InitiateTeleport","Tiki Outpost");task.wait(1.5);else TweenPartTowardCFrame(w,SubmergedExit,350,8);end;return true;end;if S and not c then n=FlatDistance(SubmergedEntrance.Position,w.Position);if n<=30 then task.wait(1);game:GetService("ReplicatedStorage").Modules.Net["RF/SubmarineWorkerSpeak"]:InvokeServer("TravelToSubmergedIsland");task.wait(1.5);elseif GatewayTravel(SubmergedEntrance.Position,n)then return true;else TweenPartTowardCFrame(w,SubmergedEntrance,TweenSpeedWanted(),8);end;return true;end;if GatewayTravel(y.Position,U)then return true;end;if w.Position.Y<-60 and w.Position.Y>-100 then w.CFrame=w.CFrame*CFrame.new(0,20,0);end;if(y.Position-w.Position).Magnitude<3 and not ReadyToDodge and not LowHealth then StopTweenNow();w.CFrame=y;return;end;TweenPartTowardCFrame(w,y,L or(TweenSpeedWanted()));return true;end
	local v4 = ToTarget
	getgenv().BackupTween = v4

	DistanceTo = function(arg)
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		return humanoidRootPart and (humanoidRootPart.Position - arg.Position).Magnitude or math.huge
	end

	TravelStep = function(arg, arg2, arg3)
		if not arg2 then
			return
		end

		if DistanceTo(arg2) < 15 then
			FinishTeleport(arg, "Arrived at " .. arg3)
			return
		end
		ToTarget(arg2)
	end

	RunTeleports = function()if  notsave ["Teleport To Island"]then local n,L= notsave ["Select Island"],GetIslandSpots();if not n or not L[n]then FinishTeleport("Teleport To Island","Pick an island first");else TravelStep("Teleport To Island",L[n],n);end;end;if  notsave ["Teleport To Npc"]then local n= notsave ["Select Npc"];local L=n and(FindNpcSpot(n));if not n then FinishTeleport("Teleport To Npc","Pick an npc first");elseif not L then VxezeNotify("Teleport",n.." is not loaded in this sea","warning",{Key="npcmissing",Repeat=20});else TravelStep("Teleport To Npc",L*CFrame.new(0,0,-4),n);end;end;if  notsave ["Teleport Mirage"]then local n=workspace.Map:FindFirstChild("MysticIsland")and(DetectNpc("Advanced Fruit Dealer"));if n and(n:FindFirstChild("HumanoidRootPart"))then TravelStep("Teleport Mirage",n.HumanoidRootPart.CFrame*CFrame.new(0,0,-4),"the Advanced Fruit Dealer");else VxezeNotify("Teleport","Mirage Island is not up yet","warning",{Key="miragewait",Repeat=30});end;end;if  notsave ["Teleport Prehistoric Island"]then local c=workspace.Map:FindFirstChild("PrehistoricIsland")and(DetectNpc("Fossil Expert"));if c and(c:FindFirstChild("HumanoidRootPart"))then TravelStep("Teleport Prehistoric Island",c.HumanoidRootPart.CFrame*CFrame.new(0,0,-4),"the Fossil Expert");else VxezeNotify("Teleport","Prehistoric Island is not up yet","warning",{Key="prewait",Repeat=30});end;end;end

	CheckDisconnect = function()
		local flag = not Settings["Auto rejoin Disconnect"]
		local flag2

		if flag then
			flag2 = flag
		else
			flag2 = tick() - (RejoinAt or 0) < 15
		end

		if flag2 then
			return
		end
		local robloxPromptGui = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
		local promptOverlay = robloxPromptGui and robloxPromptGui:FindFirstChild("promptOverlay")
		promptOverlay = promptOverlay and promptOverlay:FindFirstChild("ErrorPrompt")
		if not promptOverlay or not promptOverlay.Visible then
			return
		end
		local errorMessage = promptOverlay:FindFirstChild("ErrorMessage", true)
		if (errorMessage and errorMessage.Text or ""):find("Teleport") then
			return
		end
		RejoinAt = tick() + 30
		VxezeLog("Server", "Disconnected, rejoining")
		local TeleportService = game:GetService("TeleportService")

		task.spawn(function()
			pcall(function()
				TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
			end)

			task.wait(12)

			pcall(function()
				TeleportService:Teleport(game.PlaceId, localPlayer)
			end)
		end)
	end

	task.spawn(function()
		while task.wait(0.25) do
			local ok, result = pcall(RunTeleports)

			if not ok then
				VxezeReportError("Teleport", result)
			end

			local ok2, result2 = pcall(CheckDisconnect)

			if not ok2 then
				VxezeReportError("Auto Rejoin", result2)
			end
		end
	end)

	EquipTool = function(n)if n and( localPlayer :FindFirstChild("Backpack"))and( localPlayer .Backpack:FindFirstChild(n))and not  localPlayer .Character.Humanoid.Sit then  localPlayer .Character.Humanoid:EquipTool( localPlayer .Backpack:FindFirstChild(n));end;end
	WeaponCache = {}
	NameWeapon = function(n,L)local U=WeaponCache[n or""];if U and os.clock()-U.time<1 and U.tool.ToolTip==n and(U.tool.Parent== localPlayer .Backpack or U.tool.Parent== localPlayer .Character)then return L and U.tool or U.tool.Name;end;local function w(y)for S,S in ipairs(y:GetChildren())do if S:IsA("Tool")and S.ToolTip==n then return S;end;end;end;U=w( localPlayer .Backpack)or  localPlayer .Character and(w( localPlayer .Character));if U then WeaponCache[n or""]={tool=U,time=os.clock()};return L and U or U.Name;end;end

	do
		local Mouse = require(game:GetService("ReplicatedStorage").Mouse)
		local CombatUtil = require(game:GetService("ReplicatedStorage").Modules.CombatUtil)
		local Net = require(game:GetService("ReplicatedStorage").Modules.Net)
		local reRegisterAttack = game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterAttack")
		local RegisterHit = Net:RemoteEvent("RegisterHit", true)
		GetPartsWithinRadius = function(c,n,L)local U={};for w,w in pairs(c:GetChildren())do if w:IsA("BasePart")and(w.Position-n).Magnitude<=L then table.insert(U,w);end;end;return U;end
		GetHittableTargets = function(c)local n={};for L,L in pairs(game:GetService("Workspace"):WaitForChild("Enemies"):GetChildren())do table.insert(n,L);end;if c then for c,c in pairs(game:GetService("Workspace"):WaitForChild("Characters"):GetChildren())do table.insert(n,c);end;end;return n;end
		getgenv().getBladeHits = function(n,L,U,w)local y={};for S,K in pairs(GetHittableTargets(w))do if K:IsDescendantOf(Workspace)and K~=n and(K:FindFirstChild("HumanoidRootPart"))then local n=K.HumanoidRootPart;local w= Players :GetPlayerFromCharacter(K)and U/1.5 or U;S={n.Position};if n.Size.Y>5 then table.insert(S,(n.CFrame*CFrame.new(0,-n.Size.Y*1.5+3,0)).Position);end;for c,c in pairs(S)do if(c-L[1].Position).Magnitude<10+w+n.Size.X/2 then for c,c in pairs(GetPartsWithinRadius(K,L[1].Position,w+n.Size.X/2))do table.insert(y,c);end;break;end;end;end;end;return y;end

		local tbl4 = {
			RightUpperArm = true,
			RightLowerArm = true,
			RightHand = true,
			RightUpperLeg = true,
			RightLowerLeg = true,
			RightFoot = true,
			LeftUpperArm = true,
			LeftLowerArm = true,
			LeftHand = true,
			LeftUpperLeg = true,
			LeftLowerLeg = true,
			LeftFoot = true,
			UpperTorso = true,
			LowerTorso = true,
			Head = true,
		}

		AttackAOE = function(n,L)local U={};local w={};local y=getgenv().getBladeHits;local S,K= localPlayer .Character,{ localPlayer .Character.HumanoidRootPart};for R,T in y(S,K,n or 80,L)do R= CombatUtil :GetRigOfHitPart(T);if R and not w[R]and  tbl4 [T.Name]and( CombatUtil :IsVulnerable(R))then local n,L=R:FindFirstChild("Summoner"), localPlayer .Character:FindFirstChild("Summoner");if R~= localPlayer .Character and(not L or R~=L.Value.Character)and(not  Players :GetPlayerFromCharacter( localPlayer .Character)or not n or n.Value~= Players :GetPlayerFromCharacter( localPlayer .Character))then table.insert(U,{R,T});w[R]=true;end;end;end;return#U>0 and U or nil;end
		v_u_27 = 0
		v_u_28 = false
		v_u_33 = false
		v_u_31 = nil
		v_u_32 = 0
		v_u_21 = 0
		v_u_16 = 1
		CameraShakerMain = require(game:GetService("ReplicatedStorage").Util.CameraShaker.Main)
		CameraShaker = require(game:GetService("ReplicatedStorage").Util.CameraShaker)
		SendHits = function(n,L) RegisterHit :FireServer(n,L);end
		AttackMelee = function(n)local L=game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool");if not L then return;end;local U=AttackAOE(n,false);if not U then return;end;n=game.Players.LocalPlayer.Character.Humanoid;local w=n and n.RootPart;w=w and w.Parent;local y= CombatUtil :GetMovesetAnimCache(n);if y then n= CombatUtil :GetWeaponName(L);local L= CombatUtil :GetWeaponData(n);local S,K=L.WeaponType,L.Moveset;if  CombatUtil :CanAttack(w,S)then v_u_33=true;v_u_32=5;v_u_21=os.clock();v_u_27+=1;if v_u_27>#K.Basic then v_u_27=1;end;L=y[ CombatUtil :GetPureWeaponName(n).."-basic"..v_u_27]; reRegisterAttack :FireServer(L.Length/(L:GetAttribute("SpeedMult")or 1));SendHits(table.remove(U,1)[2],U);L:Play(0.100000001,1,1*(L:GetAttribute("SpeedMult")or 1));v_u_28=true;task.delay(L.Length/(L:GetAttribute("SpeedMult")or 1)*v_u_16,function()v_u_28=false;end);v_u_31=L;table.clear(U);return true;end;return true;end;end
		v_u_27 = 0
		v_u_28 = false
		v_u_33 = false
		v_u_31 = nil
		v_u_32 = 0
		v_u_21 = 0
		v_u_16 = 1
		AttackFunction = function(n)if  localPlayer .Character.Stun.Value~=0 then return;end;if not Settings["Attack No Animation "]then AttackMelee(n);else local L=AttackAOE(n,false);if not L then return;end; reRegisterAttack :FireServer(0); RegisterHit :FireServer(table.remove(L,1)[2],L);table.clear(L);end;end
		getgenv().AttackFunctionnhungSuperTrial = function()if  localPlayer .Character.Stun.Value~=0 then return;end;local n=AttackAOE(80,true);if not n then return;end; reRegisterAttack :FireServer(0); RegisterHit :FireServer(table.remove(n,1)[2],n);table.clear(n);end
		getgenv().AttackFunctionnhungSuper = getgenv().AttackFunctionnhungSuperTrial
		v_u_50 = nil
		v_u_51 = 1
		v_u_52 = time
		v_u_53 = v_u_52()
		FireFruitM1 = function(n,L,U)local w= localPlayer .Character;local y=w and(w.PrimaryPart or(w:FindFirstChild("HumanoidRootPart")));if not y or not n then return false;end;local S=U and n.Position or n.PrimaryPart and n.PrimaryPart.Position;if not S then return false;end;local K=(S-y.Position).Unit;U,n=(( Mouse .Hit.Position-y.Position)*Vector3.new(1,0,1)).Unit,NameWeapon("Blox Fruit");y=n and(w:FindFirstChild(n));if not y then return false;end;local c,w,R=y:FindFirstChild("LeftClickRemote"),y:FindFirstChild("RemoteFunction"),y:FindFirstChild("RemoteEvent");if not c and w then if R then R:FireServer(S);end;w:InvokeServer("TAP");return true;end;if c and n=="Mammoth-Mammoth"then c:FireServer(S);return true;end;if c then v_u_51+=1;if v_u_51>5 then v_u_51=1;end;c:FireServer(K,v_u_51);if L then c:FireServer(U,v_u_51);end;return true;end;return false;end
	end

	getgenv().UseFruitM1 = function(arg, arg2)
		return FireFruitM1(arg, arg2, false)
	end

	getgenv().UseFruitM1Boat = function(arg, arg2)
		return FireFruitM1(arg, arg2, true)
	end

	getgenv().PathClickM1 = {}

	HookToolClickRemotes = function(arg)
		arg.ChildAdded:Connect(function(child)
			if child:IsA("Tool") then
				task.wait(0.5)
				local remoteFunction = child:FindFirstChild("RemoteFunction")

				if remoteFunction then
					local name_ = child.Name
					getgenv().PathClickM1[name_] = remoteFunction
				end
			end
		end)
	end

	if localPlayer.Character then
		HookToolClickRemotes(localPlayer.Character)
	end

	localPlayer.CharacterAdded:Connect(HookToolClickRemotes)
	IsTargetInMeleeRange = function(n)return  localPlayer .Character and( localPlayer .Character:FindFirstChild("HumanoidRootPart"))and n and(n:FindFirstChild("HumanoidRootPart"))and n.Humanoid.Health>0 and  localPlayer :DistanceFromCharacter(n.HumanoidRootPart.Position)<70;end
	getgenv().ClickM1 = function(c,n)if Settings["Kill Aura With DragonStorm"]and WeaponLocked()=="Dragonstorm"then if c and c.Parent then getgenv().SpamGunDragonStorm(c.PrimaryPart or(c:FindFirstChild("HumanoidRootPart")));end;return;end;if not IsTargetInMeleeRange(c)then return;end;if Settings["Select Weapon"]=="Blox Fruit"then if getgenv().UseFruitM1(c)then return;end;end;AttackFunction(n and 80 or 30);end

	getgenv().ClickM1Dungeon = function(arg, arg2)
		if not IsTargetInMeleeRange(arg) then
			return
		end

		if Settings["Select Weapon Dungeon"] == "Blox Fruit" then
			if getgenv().UseFruitM1(arg) then
				return
			end
		end

		AttackFunction(arg2 and 80 or 30)
	end

	getgenv().ClickM1Volcano = function(arg, arg2)
		if not IsTargetInMeleeRange(arg) then
			return
		end

		if Settings["Select Weapon Kill Golem"] and Settings["Select Weapon Kill Golem"] == "Blox Fruit" then
			if getgenv().UseFruitM1(arg) then
				return
			end
		end

		AttackFunction(arg2 and 80 or 30)
	end

	do
		local modules = ReplicatedStorage:WaitForChild("Modules")

		FastGun = {
			fn = nil,
			assist = nil,
			looked = 0,
			heat = {},
			last = {},
			data = {},
			Distance = 400,
			ShootsPerTarget = { ["Dual Flintlock"] = 2 },
			SpecialShoots = {
				["Skull Guitar"] = "Custom",
				Bazooka = "Position",
				Cannon = "Position",
				Dragonstorm = "Overheat",
			},
			input = {
				UserInputType = game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").MouseEnabled and Enum.UserInputType.Touch or Enum.UserInputType.MouseButton1,
				Position = Vector3.zero,
			},
		}

		ResolveShootGun = function()if FastGun.fn then return FastGun.fn;end;if tick()-FastGun.looked<3 then return nil;end;FastGun.looked=tick();for c,n in ipairs(getgc(false))do if type(n)=="function"and(islclosure(n))then c=debug.getinfo(n);if c and c.numparams==2 then local c,L=pcall(debug.getconstants,n);if c and(table.find(L,"LocalShotsLeft"))and(table.find(L,"LocalTotalShots"))then FastGun.fn=n;break;end;end;end;end;if FastGun.fn then for c,c in ipairs(getupvalues(FastGun.fn))do if type(c)=="table"and type(rawget(c,"getTargetInfo"))=="function"then FastGun.assist=c;break;end;end;end;return FastGun.fn;end
		GunData = function(n)local L=FastGun.data[n];if L then return L;end;local U,w=pcall(function()return require( modules .CombatUtil):GetWeaponData(n);end);L=U and type(w)=="table"and w or{};FastGun.data[n]=L;return L;end
		AimPartOf = function(c)if typeof(c)=="Vector3"then return{CFrame=CFrame.new(c),Position=c};end;if typeof(c)=="CFrame"then return{CFrame=c,Position=c.Position};end;if typeof(c)~="Instance"then return nil;end;if c:IsA("BasePart")then return c;end;local n=c:FindFirstChild("HumanoidRootPart")or(c:FindFirstChild("Hitbox"))or c.PrimaryPart;if n then return n;end;local n,L=pcall(function()return c:GetPivot();end);return n and{CFrame=L,Position=L.Position}or nil;end
		GunReady = function(n,L)local U,w=tick(),tonumber(L.Cooldown)or 0.2;if L.ShootStyle=="Gatling"then local y,S=(tonumber(L.OverheatLimit)or 3)-0.1,FastGun.heat[n.Name];if not S then S={heat=0,cooling=false,prev=U};FastGun.heat[n.Name]=S;end;local L=U-S.prev;S.prev=U;if S.cooling or L>0.4 then S.heat=math.max(S.heat-L,0);if S.heat<=0 then S.cooling=false;end;else S.heat=S.heat+L;if S.heat>=y then S.cooling=true;end;end;if S.cooling then return false;end;else if not n.Enabled or(tonumber(n:GetAttribute("LocalShotsLeft"))or 1)<1 then return false;end;if require( modules .CombatUtil):IsGunReloading(n)then return false;end;end;return U-(FastGun.last[n.Name]or 0)>=w;end
		GunCooling = function(c)local n=FastGun.heat[c];if not n or not n.cooling then return false;end;c=tick()-n.prev;if n.heat-c<=0 then n.heat,n.cooling,n.prev=0,false,tick();return false;end;return true;end
		ShootGunAt = function(n)local L= localPlayer .Character;local c=L and(L:FindFirstChildOfClass("Tool"));if not c or c.ToolTip~="Gun"then return false;end;local U,w=ResolveShootGun(),AimPartOf(n);if not U or not w then return false;end;L=GunData(c.Name);if not GunReady(c,L)then return false;end;local y,S,K=tick(),tonumber(L.Cooldown)or 0.2,FastGun.ShootsPerTarget[c.Name]or 1;if L.ShootStyle=="Gatling"then n=math.floor((y-(FastGun.last[c.Name]or 0))/S);K=(math.clamp(n,1,3));end;FastGun.last[c.Name]=y;local y=FastGun.assist;n=y and y.getTargetInfo;if y then y.getTargetInfo=function()return{Part=w};end;end;L=0;for w=1,K,1 do L=if pcall(U,c,FastGun.input)then L+1 else L;end;if y then y.getTargetInfo=n;end;return L>0;end
		WeaponLock = { name = nil, expires = 0 }
		HoldWeapon = function(c,n)WeaponLock.name=c;WeaponLock.expires=tick()+(tonumber(n)or 2);end
		SpamGunNamed = function(n,L)local U= localPlayer .Character;if not U or not L then return false;end;if GunCooling(n)then if WeaponLock.name==n then HoldWeapon(n,0.6);end;return false;end;HoldWeapon(n,1.5);if not U:FindFirstChild(n)then if  localPlayer .Backpack:FindFirstChild(n)then EquipTool(n);end;return false;end;return ShootGunAt(L);end
		WeaponLocked = function()if WeaponLock.name and tick()<WeaponLock.expires then return WeaponLock.name;end;WeaponLock.name=nil;return nil;end

		local ok, result = pcall(function()
			return debug.getupvalue(require(ReplicatedStorage.Controllers.CombatController).Attack, 9)
		end)

		getgenv().DumpDragonstormUpvalues = function()
			if not ok or not result then
				print("[Vxeze Hub] shootAttackFn not resolved, cannot dump upvalues")
				return
			end

			for i_ = 1, 24 do
				local ok2, result2 = pcall(debug.getupvalue, result, i_)

				if not (not ok2 or result2 == nil) then
					local v5 = typeof
					print(string.format("[Vxeze Hub] upvalue %d = %s (%s)", i_, tostring(result2), v5(result2)))
					continue
				end

				break
			end
		end

		local function fn()
			local v5 = debug.getupvalue(result, 15)
			local v6 = debug.getupvalue(result, 13)
			local v7 = debug.getupvalue(result, 16)
			local v8 = debug.getupvalue(result, 17)
			local v9 = debug.getupvalue(result, 14)
			local v10 = debug.getupvalue(result, 12)
			local v11 = debug.getupvalue(result, 18)
			if type(v5) ~= "number" or type(v6) ~= "number" or type(v7) ~= "number" or type(v8) ~= "number" or type(v9) ~= "number" or type(v10) ~= "number" or type(v11) ~= "number" then
				return nil
			end
			local n = ((v9 * v6 + v10 * v5) % v7 * v7 + v10 * v6) % v8
			local n2 = math.floor(n / v7)
			local n3 = v11 + 1
			debug.setupvalue(result, 15, v5)
			debug.setupvalue(result, 13, v6)
			debug.setupvalue(result, 16, v7)
			debug.setupvalue(result, 17, v8)
			debug.setupvalue(result, 14, n2)
			debug.setupvalue(result, 12, n - n2 * v7)
			debug.setupvalue(result, 18, n3)
			return math.floor(n / v8 * 16777215), n3
		end

		getgenv().SpamGunDragonStorm = function(...) end
		getgenv().SpamGunSkullGuitar = function(n)local L=require( modules .CombatUtil);local U= localPlayer .Character;local c=U and(U:FindFirstChild("Skull Guitar"));if not c or(L:IsGunReloading(c))then return;end;c.RemoteEvent:FireServer("TAP",n.Position);end
	end

	ShootM1 = function(n)local L,U= localPlayer .Character,NameWeapon("Gun");if not U or not L or not n then return;end;if not L:FindFirstChild(U)then EquipTool(U);return;end;ShootGunAt(n);end
	KillAuraSweep = function(n,L)local U= localPlayer .Character and( localPlayer .Character:FindFirstChild("HumanoidRootPart"));if not U then return 0;end;pcall(sethiddenproperty, localPlayer ,"SimulationRadius",1/0);local c=0;for w,w in ipairs(workspace.Enemies:GetChildren())do local y,S=w:FindFirstChild("HumanoidRootPart"),w:FindFirstChild("Humanoid");if y and S and S.Health>0 and(not L or w.Name==L)and(y.Position-U.Position).Magnitude<(n or 150)and(not isnetworkowner or(isnetworkowner(y)))then y.CanCollide=false;S:ChangeState(Enum.HumanoidStateType.Dead);S.Health=0;c+=1;end;end;return c;end
	KillAuraTick = function()if getgenv().KillMobRaid or not Settings["Kill Aura Only Raid And Volcano"]then return;end;getgenv().KillMobRaid=true;KillAuraSweep(150);task.delay(Settings["Time Delay Kill"]or 5,function()getgenv().KillMobRaid=false;end);end
	FindNearestVulnerableTarget = function(c,n)local L,U,w,y,S,K,R=require(game:GetService("ReplicatedStorage").Modules.CombatUtil),getgenv().getBladeHits,c.Character,{c.Character.HumanoidRootPart},1/0;for T,u in U(w,y,n,true)do T=L:GetRigOfHitPart(u);if T and(L:IsVulnerable(T))then local n=(c.Character.HumanoidRootPart.Position-u.Position).Magnitude;if n<S then S,K,R=n,T,u;end;end;end;if K and R then return{K,R};end;return nil;end
	DetectItemPlr = function(n)if  localPlayer .Character:FindFirstChild(n)or( localPlayer .Backpack:FindFirstChild(n))then return true;end;end
	SizedParts = setmetatable({}, { __mode = "k" })
	SizePart = function(n)AttackingMob=n;if not n or not n.Parent or not n:FindFirstChild("HumanoidRootPart")then return;end;if os.clock()-(SizedParts[n]or 0)<2 then return;end;if  localPlayer :DistanceFromCharacter(n.HumanoidRootPart.Position)<=50 then SizedParts[n]=os.clock();for c,c in ipairs(n:GetDescendants())do if c:IsA("BasePart")and c.CanCollide then c.CanCollide=false;end;end;end;end

	DeleteIgnoredMob = function()
		for _, child in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
			if child:IsA("Model") and child:FindFirstChild("Ignored") then
				child.Ignored:Destroy()
			end
		end
	end

	MatchMobName = function(arg, arg2)
		return typeof(arg2) == "table" and table.find(arg2, arg.Name) ~= nil or arg.Name == arg2
	end

	HeldBringTarget = function(arg)
		local v5 = BringTarget
		if not v5 or not v5.Parent or not v5:FindFirstChild("HumanoidRootPart") then
			return nil
		end

		if not MatchMobName(v5, arg) or not IsMobAlive(v5) or v5:FindFirstChild("Ignored") then
			return nil
		end

		if localPlayer:DistanceFromCharacter(v5.HumanoidRootPart.Position) > 90 then
			return nil
		end
		return v5
	end

	DetectMob = function(c)local n=Settings["Bring Mob"]and(HeldBringTarget(c));if n then return n;end;local n,L=1/0;for U,w in pairs(game.Workspace.Enemies:GetChildren())do if(typeof(c)=="table"and(table.find(c,w.Name))or w.Name==c)and(IsMobAlive(w))then U=(w.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude;if U<n then n,L=U,w;end;end;end;return L;end
	CheckNameBoss = function(c)local n,L,U=next,game.ReplicatedStorage:GetChildren();for w,w in n,L,U do if(typeof(c)=="table"and(table.find(c,w.Name))or w.Name==c)and(IsMobAlive(w))then return w;end;end;n,U,L=next,game.Workspace.Enemies:GetChildren();for w,w in n,U,L do if(typeof(c)=="table"and(table.find(c,w.Name))or w.Name==c)and(IsMobAlive(w))then return w;end;end;end
	getgenv().TableMobSpawn = {}

	spawn(function()
		for _, v5 in pairs(getnilinstances()) do
			local str2

			if v5:GetAttribute("DisplayName") and string.find(v5:GetAttribute("DisplayName"), "Lv.") then
				str2 = v5:GetAttribute("DisplayName"):gsub(" %pLv. %d+%p", "")
			else
				str2 = nil
			end

			if str2 then
				table.insert(TableMobSpawn, v5)
			end
		end

		for _, child in pairs(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()) do
			local str2

			if child:GetAttribute("DisplayName") and string.find(child:GetAttribute("DisplayName"), "Lv.") then
				str2 = child:GetAttribute("DisplayName"):gsub(" %pLv. %d+%p", "")
			else
				str2 = nil
			end

			if str2 then
				if not table.find(TableMobSpawn, child) then
					table.insert(TableMobSpawn, child)
				end
			end
		end
	end)

	GetCenter = function(arg)
		local str2

		if string.find(arg, "Lv.") then
			str2 = arg:gsub(" %pLv. %d+%p", "")
		else
			str2 = nil
		end

		local vector = nil
		local n = 0

		for _, v5 in pairs(TableMobSpawn) do
			local str3

			if string.find(v5.Name, "Lv.") then
				str3 = v5.Name:gsub(" %pLv. %d+%p", "")
			else
				str3 = nil
			end

			local isPart = v5:IsA("Part")

			if isPart then
				str3 = str3 and str3 == arg
				isPart = str3 or arg == v5.Name or str2 and v5.Name == str2
			end

			if isPart then
				vector = vector or Vector3.zero
				vector += v5.Position
				n += 1
			end
		end

		if n == 0 then
			return nil
		end
		return CFrame.new(vector / n)
	end

	DetectPartMobBring = function(arg, arg2, arg3, arg4)
		local tbl4 = {}
		local str2

		if string.find(arg, "Lv.") then
			str2 = arg:gsub(" %pLv. %d+%p", "")
		else
			str2 = nil
		end

		for _, v5 in pairs(TableMobSpawn) do
			local str3

			if string.find(v5.Name, "Lv.") then
				str3 = v5.Name:gsub(" %pLv. %d+%p", "")
			else
				str3 = nil
			end

			local isPart = v5:IsA("Part")

			if isPart then
				str3 = str3 and str3 == arg
				isPart = str3 or arg == v5.Name or str2 and v5.Name == str2
			end

			if isPart then
				table.insert(tbl4, v5)
			end
		end

		if arg3 then
			local huge = math.huge
			local v5 = nil

			for _, v6 in next, tbl4, nil do
				local magnitude = (arg2.HumanoidRootPart.Position - v6.Position).Magnitude

				if magnitude < huge then
					huge = magnitude
					v5 = v6
				end
			end

			return v5
		end

		local tbl5 = {}

		for _, v5 in next, tbl4, nil do
			if (arg4.Position - v5.Position).Magnitude <= 200 then
				table.insert(tbl5, v5)
			end
		end

		if #tbl5 < #tbl4 then
			return true
		end
	end

	IsNetworkOwnerPart = function(n)local L,U,w=next,game.Workspace.Characters:GetChildren();for y,y in L,U,w do if y.Name~= localPlayer .Name and(y:FindFirstChild("HumanoidRootPart"))and(y.HumanoidRootPart.Position-n.Position).Magnitude<=300 then return false;end;end;return true;end
	FarmLoops = {}
	FarmLoopWait = function(c,n)local L=n or 0;while L>0 do if not Settings[c]then return false;end;n=L>0.1 and 0.1 or L;task.wait(n);L-=n;end;return Settings[c]==true or Settings[c]~=nil and Settings[c]~=false;end
	RunFarmLoop = function(c,n,L)if FarmLoops[c]then return;end;FarmLoops[c]=true;task.spawn(function()while Settings[c]do local U,w=pcall(L);if not U then VxezeReportError(c,w);end;if not Settings[c]then break;end;if not FarmLoopWait(c,n)then break;end;end;FarmLoops[c]=nil;end);end
	BringTarget = nil
	BringSpot = nil
	BringGhostWatch = {}
	DropGhostMob = function(c)if not c or not c:FindFirstChild("HumanoidRootPart")then return;end;c.HumanoidRootPart.CFrame=c.WorldPivot;if not c:FindFirstChild("Ignored")then Instance.new("IntValue",c).Name="Ignored";end;BringGhostWatch[c]=nil;if c==BringTarget then BringTarget=nil;BringSpot=nil;end;task.wait(0.3);end
	WatchGhostMob = function(c)if BringGhostWatch[c]then return;end;BringGhostWatch[c]=true;task.spawn(function()local n=c:FindFirstChildWhichIsA("Humanoid");local L,U=n and n.Health,c:FindFirstChild("HumanoidRootPart");local w=U and U.Position;task.wait(2.2);BringGhostWatch[c]=nil;if not n or not U or not U.Parent or not IsMobAlive(c)then return;end;if c:FindFirstChild("Ignored")or not Settings["Bring Mob"]then return;end;if n.Health<L then return;end;if w and(U.Position-w).Magnitude<=30 and(IsNetworkOwnerPart(U))then return;end;DropGhostMob(c);end);end
	BringMob = function(n)if not Settings["Bring Mob"]then return;end;if not n or not n:FindFirstChild("HumanoidRootPart")then return;end;if BringTarget~=n then BringTarget=n;local L=DetectPartMobBring(n.Name,n,true);BringSpot=L and L.CFrame or n.HumanoidRootPart.CFrame;if game:GetService("Players").LocalPlayer.Data.Race.Value=="Cyborg"and( localPlayer .Character:FindFirstChild("RaceTransformed"))and  localPlayer .Character.RaceTransformed.Value then BringSpot=GetCenter(n.Name)or BringSpot;end;DeleteIgnoredMob();end;if DaBringMob then delay(0.1,function()getgenv().DaBringMob=false;end);return;end;local L={};if not n:FindFirstChild("Ignored")then table.insert(L,n);end;local U=Settings["Bring Mob Count"]or 2;local w,y=if U>2 then 350 else 200;if game:GetService("Players").LocalPlayer.Data.Race.Value=="Cyborg"and( localPlayer .Character:FindFirstChild("RaceTransformed"))and  localPlayer .Character.RaceTransformed.Value then y,w=6,300;else y=U;end;for U,U in pairs(workspace.Enemies:GetChildren())do if U~=n and U.Name==n.Name and not U:FindFirstChild("Ignored")and(IsMobAlive(U))and(IsNetworkOwnerPart(U.HumanoidRootPart))then if(U.HumanoidRootPart.Position-BringSpot.Position).Magnitude<=w and#L<y then table.insert(L,U);end;end;end;if BringSpot and  localPlayer :DistanceFromCharacter(n.HumanoidRootPart.Position)<=50 and(IsNetworkOwnerPart( localPlayer .Character.HumanoidRootPart))and#L>=2 then for c,c in pairs(L)do SizePart(c);if not IsNetworkOwnerPart(c.HumanoidRootPart)then DropGhostMob(c);else c.HumanoidRootPart.CFrame=BringSpot*CFrame.new(0,math.random(0,2),math.random(0,2));WatchGhostMob(c);end;getgenv().DaBringMob=true;end;end;end
	SettingFarmMain = Main.CreatePage({ Page_Name = "Setting Farm", Page_Title = "Setting Farm" })
	SettingFarmMainSection = SettingFarmMain.CreateSection("Setting Farm")

	if not Settings["Select Weapon"] or Settings["Select Weapon"] == "Gun" then
		Settings["Select Weapon"] = "Melee"
	end

	FFCMatch = function(arg, arg2)
		for _, child in ipairs(arg:GetChildren()) do
			if string.match(child.Name, arg2) then
				return child
			end
		end
	end

	ActionHandlers = setmetatable({}, { __mode = "k" })

	FindActionHandler = function(arg, arg2)
		local character = localPlayer.Character
		character = character and character:FindFirstChild(arg)
		if not character then
			return
		end

		if ActionHandlers[character] then
			return ActionHandlers[character]
		end
		ActionHandlerMiss = ActionHandlerMiss or {}
		local str2 = arg .. "/" .. tostring(arg2)
		if tick() - (ActionHandlerMiss[str2] or 0) < 10 then
			return nil
		end
		ActionHandlerMiss[str2] = tick()

		for _, v5 in ipairs(getgc(false)) do
			if type(v5) == "function" and islclosure(v5) then
				local ok, result = pcall(getfenv, v5)

				if ok and type(result) == "table" and rawget(result, "script") == character then
					local ok2, result2 = pcall(debug.getconstants, v5)

					if ok2 then
						for _, v6 in ipairs(result2) do
							if v6 == arg2 then
								ActionHandlers[character] = v5
								return v5
							end
						end

						continue
					end
				end
			end
		end
	end

	PressGameAction = function(arg, arg2, arg3)
		local v5 = FindActionHandler(arg2, arg3)
		if not v5 then
			return false
		end

		return pcall(v5, arg, Enum.UserInputState.Begin, {
			UserInputState = Enum.UserInputState.Begin,
			UserInputType = Enum.UserInputType.Keyboard,
			KeyCode = Enum.KeyCode.Unknown,
		})
	end

	HasBusoOn = function()
		local character = localPlayer.Character
		local flag = character ~= nil
		local flag2

		if flag then
			flag2 = FFCMatch(character, "_BusoLayer1") ~= nil or character:FindFirstChild("HasBuso") ~= nil
		else
			flag2 = flag
		end

		return flag2
	end

	ObservationOn = function()
		local blur = game:GetService("Lighting"):FindFirstChild("Blur")
		return blur ~= nil and blur.Enabled
	end

	TurnOnV4 = function()
		local character = localPlayer.Character
		local raceEnergy = character and character:FindFirstChild("RaceEnergy")
		local raceTransformed = character and character:FindFirstChild("RaceTransformed")
		if not raceEnergy or raceEnergy.Value < 1 or not raceTransformed or raceTransformed.Value then
			return
		end
		local awakening = localPlayer.Backpack:FindFirstChild("Awakening") or character:FindFirstChild("Awakening")

		if awakening then
			awakening.RemoteFunction:InvokeServer(true)
		end
	end

	game:GetService("Workspace").Enemies.DescendantAdded:Connect(function(descendant)
		local flag = Settings["Auto Dodge Skill Mobs"] and AttackingMob and AttackingMob.Parent and not Doding

		if flag then
			flag = descendant.Name == "BodyGyro" or descendant.Name == "BodyPosition" or descendant.Name == "KiBlastFireShort"
		end

		if flag and descendant.Parent.Parent == AttackingMob then
			Doding = true
			ReadyToDodge = true
			local now = tick()

			while true do
				wait()
				if not (not descendant or not descendant.Parent or tick() - now > 14) then
					continue
				end
				break
			end

			if tick() - now < 2 then
				wait(0.5)
			end

			Doding = false
			ReadyToDodge = false
		end
	end)

	DragonstormState = function()local n= localPlayer .Character;if n and(n:FindFirstChild("Dragonstorm"))then return"ready";end;if  localPlayer .Backpack:FindFirstChild("Dragonstorm")then return"backpack";end;local c,n=pcall(CheckItemInventory,"Dragonstorm");if c and n then return"inventory";end;return"missing";end
	StartDragonStormAura = function(...) end
	local tbl4 = { target = nil, scannedAt = 0 }
	RunDragonStormAura = function()local n= localPlayer .Character;if not n then return;end;if DragonstormState()=="missing"then return;end;HoldWeapon("Dragonstorm",1.5);if not n:FindFirstChild("Dragonstorm")then EquipTool("Dragonstorm");end;n= tbl4 .target;if not n or not n.Parent or tick()- tbl4 .scannedAt>0.3 then local L=FindNearestVulnerableTarget( localPlayer ,FastGun.Distance);n=L and L[2]; tbl4 .target=n; tbl4 .scannedAt=tick();end;if n and n.Parent then SpamGunNamed("Dragonstorm",n);end;end
	RunTweenSafeItems = function()if CheckNameBoss("Darkbeard")and Settings["Attack Darkbeard"]then return;end;if DetectItemPlr("Fist of Darkness")and Settings["Summon Darkbeard"]then return;end;if not DetectItemPlr("Fist of Darkness")and not DetectItemPlr("God's Chalice")then return;end;if Place_Id.sea2()then ToTarget(CFrame.new(-385.250916,73.0458984,297.388397));else ToTarget(CFrame.new(-12463.8740234375,374.9144592285156,-7523.77392578125));end;end
	RunTurnOnV3 = function()local n= localPlayer .Character;local c=n and(n:FindFirstChild("RaceTransformed"));if c and c.Value then return;end;game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility");end

	do
		local tbl5 = {
			Mode = "Toggle",
			Title = "Kill Aura With DragonStorm",
			Key = "Kill Aura With DragonStorm",
			Fallback = false,
			Require = function()
				if DragonstormState() == "missing" then
					return false, "You do not own a Dragonstorm"
				end
				return true
			end,
			OnChange = StartDragonStormAura,
		}

		local tbl6 = {
			Mode = "Slider",
			Title = "Speed Tween ",
			Key = "Speed Tween ",
			Min = 50,
			Max = TweenSpeedLimit,
			Default = 200,
		}

		local tbl7 = {
			Mode = "Label",
			Title = "Max " .. TweenSpeedLimit .. ": faster tweens get pulled back by the server",
		}

		FarmSettingPanel = {
			{
				Mode = "Dropdown",
				Title = "Select Weapon",
				Key = "Select Weapon",
				List = { "Melee", "Sword", "Blox Fruit" },
				Fallback = "Melee",
				OnChange = function(arg)
					SaveSettings("Select Weapon", arg or "Melee")
				end,
			},
			{
				Mode = "Toggle",
				Title = "Noclip",
				Desc = "Walk through walls while features move you",
				Key = "Noclip",
				Fallback = false,
			},
			{
				Mode = "Toggle",
				Title = "Attack No Animation ",
				Key = "Attack No Animation ",
				Fallback = true,
			},
			{
				Mode = "Toggle",
				Title = "Kill Aura Only Raid And Volcano",
				Key = "Kill Aura Only Raid And Volcano",
				Fallback = false,
			},
			{
				Mode = "Slider",
				Title = "Time Delay Kill",
				Key = "Time Delay Kill",
				Min = 0,
				Max = 5,
				Fallback = 5,
			},
			tbl5,
			{
				Mode = "Toggle",
				Title = "Auto Turn On Buso",
				Desc = "Keeps Buso up, works on PC and mobile",
				Key = "Auto Turn On Buso",
				Fallback = true,
				OnChange = function()
					RunFarmLoop("Auto Turn On Buso", 2, function()
						if not HasBusoOn() then
							CommF:InvokeServer("Buso")
						end
					end)
				end,
			},
			{
				Mode = "Toggle",
				Title = "Auto Turn On Observation",
				Desc = "Uses the game's own Ken button, no key press",
				Key = "Auto Turn On Observation",
				Fallback = false,
				OnChange = function()
					RunFarmLoop("Auto Turn On Observation", 2, function()
						if not ObservationOn() then
							PressGameAction("BoundActionKen", "Observation", "KenDisabled")
						end
					end)
				end,
			},
			{
				Mode = "Toggle",
				Title = "Auto Turn On V4",
				Key = "Auto Turn On V4",
				Fallback = false,
				OnChange = function()
					RunFarmLoop("Auto Turn On V4", 1, TurnOnV4)
				end,
			},
			{
				Mode = "Toggle",
				Title = "Auto Turn On V3",
				Key = "Auto Turn On V3",
				Fallback = false,
				OnChange = function()
					RunFarmLoop("Auto Turn On V3", 2, RunTurnOnV3)
				end,
			},
			{
				Mode = "Toggle",
				Title = "Auto Dodge Skill Mobs",
				Key = "Auto Dodge Skill Mobs",
				Fallback = false,
			},
			{
				Mode = "Toggle",
				Title = "Teleport Y if low health",
				Key = "Teleport Y",
				Fallback = false,
			},
			{
				Mode = "Slider",
				Title = "% Health Player",
				Key = "% Health Player",
				Min = 0,
				Max = 100,
				Fallback = 40,
			},
			{
				Mode = "Slider",
				Title = "Distance Teleport Y",
				Key = "Distance Teleport Y",
				Min = 0,
				Max = 10000,
				Fallback = 800,
			},
			{
				Mode = "Toggle",
				Title = "Tween Safe if have Items",
				Key = "Tween Safe if have Items",
				Fallback = false,
				OnChange = function()
					RunFarmLoop("Tween Safe if have Items", 0.25, RunTweenSafeItems)
				end,
			},
			{
				Mode = "Toggle",
				Title = "Use Portal Fruit Teleport",
				Desc = "Travels with the Portal fruit when the target island is far",
				Key = "Use Portal Fruit Teleport",
				Fallback = false,
				Require = function()
					local character = localPlayer.Character
					character = character and character:FindFirstChild("Portal-Portal")
					local portalPortal = localPlayer.Backpack:FindFirstChild("Portal-Portal")
					local value = select(2, pcall(CheckItemInventory, "Portal-Portal"))
					if not character and not portalPortal and not value then
						return false, "You do not have the Portal fruit"
					end
					return true
				end,
			},
			{
				Mode = "Slider",
				Title = "Bring Mob Count",
				Key = "Bring Mob Count",
				Min = 2,
				Max = 6,
				Fallback = 2,
				Precise = false,
			},
			{ Mode = "Toggle", Title = "Bring Mob", Key = "Bring Mob", Fallback = true },
			tbl6,
			{
				Mode = "Toggle",
				Title = "Tween Pause",
				Desc = "Prevent Security Kick",
				Key = "Prevent Security Kick",
				Fallback = false,
				OnChange = function(arg)
					VxezeNotify("Tween Pause", arg and "Tween rests " .. SecurityKick.PauseTime .. "s every " .. SecurityKick.NeedPause .. "s now" or "Tween runs without resting now", "info")
				end,
			},
			tbl7,
		}
	end

	BuildPanel(SettingFarmMainSection, "Farm Setting", FarmSettingPanel)
	callback2 = ElementCollection["Farm Setting"]["Select Weapon"]
	callback3 = ElementCollection["Farm Setting"]["Auto Turn On V4"]
	enabled2 = false
	SettingSkillMain = Main.CreatePage({ Page_Name = "Hold and Select Skill", Page_Title = "Setting Hold and Select Skill" })
	SelectSkillsSection = SettingSkillMain.CreateSection("Select Skills")

	CreateSelectSkillsDropdown = function(arg, arg2)
		local str2 = "Select Skills " .. arg
		local tbl5 = {}

		for _, v5 in ipairs(arg2) do
			tbl5[v5] = false
		end

		EnsureAllTrueDefaults(str2, arg2)

		SelectSkillsSection.CreateDropdown({
			Title = str2,
			List = PrepareMultiSelectList(tbl5, Settings[str2], true),
			Search = true,
			Selected = true,
			Default = Settings[str2] or nil,
		}, function(arg3, arg4)
			SaveSettings(str2, arg3, arg4)
		end)
	end

	SkillKeyOrder = {
		Melee = { "Z", "X", "C" },
		Sword = { "Z", "X" },
		Gun = { "Z", "X" },
		["Blox Fruit"] = { "Z", "X", "C", "V", "F" },
	}

	SkillCategories = { "Melee", "Sword", "Gun", "Blox Fruit" }

	for _, v5 in ipairs(SkillCategories) do
		CreateSelectSkillsDropdown(v5, SkillKeyOrder[v5])
	end

	HoldSkillsSection = SettingSkillMain.CreateSection("Hold Skills")

	CreateHoldSkillDelayDropdown = function(arg, arg2)
		local tbl5 = {}
		local v5 = arg2

		for _, v6 in ipairs(v5) do
			tbl5[v6] = {
				Title = v6,
				KeyName = v6,
				Min = 0,
				Max = 5,
				Default = Settings["Skill " .. v6 .. " " .. arg] or 0.5,
				Precise = true,
			}
		end

		HoldSkillsSection.CreateDropdown({ Title = "Set Delay " .. arg, List = tbl5, Slider = true }, function(arg3, arg4)
			if arg4 and arg4.KeyName then
				SaveSettings("Skill " .. arg4.KeyName .. " " .. arg, arg4.Default)
			end
		end)
	end

	BuildPanel(HoldSkillsSection, "Hold Skills", {
		{
			Mode = "Toggle",
			Title = "Use skill fast dont hold",
			Key = "Use skill fast dont hold",
			Fallback = false,
		},
	})

	for _, v5 in ipairs(SkillCategories) do
		CreateHoldSkillDelayDropdown(v5, SkillKeyOrder[v5])
	end

	FarmMain = Main.CreatePage({ Page_Name = "Farming", Page_Title = "Farming" })
	MethodFarm = { "Level", "Bone", "Cake", "Tiki", "Nearest" }

	FarmingPanel = {
		{
			Mode = "Dropdown",
			Title = "Select Method Farm",
			Key = "Select Method Farm",
			List = MethodFarm,
		},
		{
			Mode = "Slider",
			Title = "Distance Farm Aura",
			Key = "Distance Farm Aura",
			Min = 0,
			Max = 5000,
			Fallback = 300,
		},
		{
			Mode = "Toggle",
			Title = "Ignore Boss",
			Desc = "Skips Cake Prince and Tyrant of the Skies, farms their mobs only",
			Key = "Ignore Boss",
			Fallback = false,
			Require = function()
				local selectMethodFarm = Settings["Select Method Farm"]
				if selectMethodFarm ~= "Cake" and selectMethodFarm ~= "Tiki" then
					return false, "Only the Cake and Tiki methods have a boss to skip"
				end
				return true
			end,
		},
		{
			Mode = "Toggle",
			Title = "Accept Quest [ Cake / Bone / Tiki ]",
			Desc = "Takes the quest that matches the farm method when you meet the level",
			Key = "Accept Quest [ Cake / Bone / Tiki ]",
			Fallback = false,
			Require = function()
				local selectMethodFarm = Settings["Select Method Farm"]
				if selectMethodFarm ~= "Cake" and selectMethodFarm ~= "Bone" and selectMethodFarm ~= "Tiki" then
					return false, "Only works with the Cake, Bone or Tiki method"
				end
				return true
			end,
		},
		{
			Mode = "Toggle",
			Title = "Start Farm",
			Key = "Start Farm",
			Fallback = false,
			SoftRequire = function()
				if not Settings["Select Method Farm"] then
					return false, "Pick a farm method first"
				end
				return true
			end,
		},
	}

	MasteryPanel = {
		{
			Mode = "Dropdown",
			Title = "Select Method Farm Mastery",
			Key = "Select Method Farm Mastery",
			List = { "Blox Fruit", "Gun" },
			Search = true,
		},
		{ Mode = "Slider", Title = "Health %", Key = "Health %", Min = 0, Max = 100, Fallback = 40 },
		{
			Mode = "Toggle",
			Title = "Farm Mastery",
			Key = "Farm Mastery",
			Fallback = false,
			SoftRequire = function()
				if not Settings["Start Farm"] then
					return false, "Turn on Start Farm first"
				end

				if not Settings["Select Method Farm Mastery"] then
					return false, "Pick a mastery method first"
				end
				return true
			end,
		},
	}

	MaterialPanel = {
		{
			Mode = "Dropdown",
			Title = "Select Material",
			Key = "Select Material",
			List = function()
				return TableMaterials
			end,
			Search = true,
		},
		{
			Mode = "Toggle",
			Title = "Farm Material",
			Key = "Farm Material",
			Fallback = false,
			SoftRequire = function()
				if not Settings["Start Farm"] then
					return false, "Turn on Start Farm first"
				end

				if not Settings["Select Material"] then
					return false, "Pick a material first"
				end
				return true
			end,
		},
	}

	SettingAutoFarmSection = FarmMain.CreateSection("Method Farm")
	BuildPanel(SettingAutoFarmSection, "Farming", FarmingPanel)
	MasteryFarmSection = FarmMain.CreateSection("Mastery Farm")
	BuildPanel(MasteryFarmSection, "Mastery Farm", MasteryPanel)
	FarmingMaterialSection = FarmMain.CreateSection("Material Farm")
	BuildPanel(FarmingMaterialSection, "Farming Material", MaterialPanel)
	local startFarm
	startFarm = ElementCollection.Farming["Start Farm"]
	local tbl5, tbl6, tbl7, tbl8, GuideModule

	do
		local tbl9 = { "BartiloQuest", "Trainees", "MarineQuest", "CitizenQuest" }
		tbl5 = {}
		tbl6 = { "Baking Staff", "Head Baker", "Cake Guard", "Cookie Crafter" }
		tbl7 = { "Cocoa Warrior", "Chocolate Bar Battler", "Candy Rebel", "Sweet Thief" }
		tbl8 = { "Reborn Skeleton", "Demonic Soul", "Living Zombie", "Posessed Mummy" }
		local tbl10 = { "Isle Champion", "Serpent Hunter", "Skull Slayer", "Sun-kissed Warrior" }
		getgenv().NameMobQuest = ""
		getgenv().NameQuest = ""
		getgenv().IDQuest = 0
		getgenv().questpoint = {}
		local Quests = require(game.ReplicatedStorage.Quests)
		GuideModule = require(game.ReplicatedStorage:WaitForChild("GuideModule"))

		GetQuestFrame = function()
			local trackedQuestFrame = localPlayer.PlayerGui:FindFirstChild("TrackedQuestFrame")
			trackedQuestFrame = trackedQuestFrame and trackedQuestFrame:FindFirstChild("Frame")
			if trackedQuestFrame and trackedQuestFrame:FindFirstChild("header") and trackedQuestFrame:FindFirstChild("progress") and trackedQuestFrame:FindFirstChild("description") then
				return trackedQuestFrame
			end
		end

		HasQuest = function()return GetQuestFrame()~=nil;end

		GetQuestTitle = function()
			local v5 = GetQuestFrame()
			return v5 and v5.header.textLabel.Text .. " " .. v5.progress.Text or ""
		end

		GetQuestMob = function()local c=GetQuestFrame();return c and c.description.Text;end

		CFrameQuest = function()
			local tbl11 = {}

			for k, v5 in next, Quests, nil do
				if k ~= "MarineQuest" then
					for _, v6 in next, v5, nil do
						tbl11[v6.LevelReq] = k
					end
				end
			end

			getgenv().questpoint = {}

			for k, v5 in next, GuideModule.Data.NPCList, nil do
				for _, v6 in next, v5.Levels, nil do
					local v7 = tbl11[v6]

					if k.Parent.Name ~= "Marine Leader" and v7 and not getgenv().questpoint[v7] then
						getgenv().questpoint[v7] = CFrame.new(v5.Position)
					end
				end
			end

			getgenv().questpoint.SkyExp1Quest = CFrame.new(-7857.28516, 5544.34033, -382.321503)
		end

		FindQuestForLevel = function(arg)
			local v5 = GetQuestMob()
			local tbl11 = {}
			local n = 0

			for _, v6 in pairs(GuideModule.Data.NPCList) do
				if not table.find(tbl9, v6.InternalQuestName) then
					for k, level in pairs(v6.Levels) do
						local v7 = Quests[v6.InternalQuestName][k]

						if v7 then
							local key, v8 = next(v7.Task)

							if v8 and v8 > 1 and level <= arg and level >= n then
								tbl11 = {
									Level = level,
									Name = v6.NPCName,
									QuestName = v6.InternalQuestName,
									Pos = v6.Position,
									Id = k,
									Mob = key,
								}

								if v5 == key and k > 1 then
									local v9 = Quests[v6.InternalQuestName][k - 1]

									if v9 and v9.Task then
										for k2, v10 in pairs(v9.Task) do
											if k2 ~= v5 and v10 > 1 then
												tbl11.Mob = k2
												tbl11.Id = k - 1
												break
											end
										end

										n = level
									else
										n = level
									end
								else
									n = level
								end
							end
						end
					end
				end
			end

			return tbl11
		end

		TakeQuestLevel = function()
			local v5 = FindQuestForLevel(localPlayer.Data.Level.Value)
			if not v5 or not v5.Pos then
				return
			end
			local position = typeof(v5.Pos) == "CFrame" and v5.Pos.Position or v5.Pos
			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")
			if not humanoidRootPart or not humanoid then
				return
			end

			if (position - humanoidRootPart.Position).Magnitude <= 8 and humanoid.Health > 0 then
				wait(2)
				local id = v5.Id
				CommF:InvokeServer("StartQuest", tostring(v5.QuestName), id)
			else
				ToTarget(CFrame.new(position) * CFrame.new(0, 4, 2), true)
			end
		end

		DetectPartSpawnMob = function(arg, arg2)
			local function fn(arg3)
				return arg3:gsub(" %p?Lv%.? %d+%p?", "")
			end

			local v5 = string.find(arg, "Lv.") and fn(arg) or arg

			for _, v6 in pairs(TableMobSpawn) do
				if v6:IsA("Part") then
					local name_ = string.find(v6.Name, "Lv.") and fn(v6.Name) or v6.Name
					local flag = name_ == arg or name_ == v5
					local flag2

					if flag then
						flag2 = not arg2 or not v6:FindFirstChild("Ignored")
					else
						flag2 = flag
					end

					if flag2 then
						return v6
					end
				end
			end

			for _, child in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
				if child:IsA("Part") then
					local name_ = string.find(child.Name, "Lv.") and fn(child.Name) or child.Name

					if (name_ == arg or name_ == v5) and (not arg2 or not child:FindFirstChild("Ignored")) then
						if not table.find(TableMobSpawn, child) then
							table.insert(TableMobSpawn, child)
						end

						return child
					end
				end
			end

			local flag = not NilSpawnCache

			if not flag then
				local v6 = NilSpawnCacheAt
				flag = tick() - v6 > 30
			end

			if flag then
				NilSpawnCache = {}
				NilSpawnCacheAt = tick()

				for _, v6 in pairs(getnilinstances()) do
					if v6:IsA("Part") then
						table.insert(NilSpawnCache, v6)
					end
				end
			end

			for _, v6 in pairs(NilSpawnCache) do
				if v6:IsA("Part") then
					local name_ = string.find(v6.Name, "Lv.") and fn(v6.Name) or v6.Name

					if (name_ == arg or name_ == v5) and (not arg2 or not v6:FindFirstChild("Ignored")) then
						if not table.find(TableMobSpawn, v6) then
							table.insert(TableMobSpawn, v6)
						end

						return v6
					end
				end
			end

			return nil
		end

		DeleteIgnoredMobSpawn = function()
			for _, v5 in pairs(TableMobSpawn) do
				if v5:FindFirstChild("Ignored") then
					v5.Ignored:Destroy()
				end
			end
		end

		DetectNameTablePart = function(arg)
			for _, v5 in next, arg, nil do
				if not table.find(tbl5, v5) then
					return v5
				end
			end
		end

		QuestAbandonAt = 0
		QuestMatchesMethod = function(c)if typeof(c)~="table"then return true;end;local n=GetQuestMob();if not n or n==""then return false;end;for L,L in ipairs(c)do if string.find(n,L,1,true)then return true;end;end;return false;end

		QuestBoneAndkatakuri = function(arg, arg2)
			local v5 = getgenv().questpoint[arg]

			if not v5 then
				CFrameQuest()
				task.wait(1.5)
				v5 = getgenv().questpoint[arg]
				if not v5 then
					return
				end
			end

			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
			if not humanoidRootPart or not humanoid then
				return
			end

			if (v5.Position - humanoidRootPart.Position).Magnitude <= 8 then
				if humanoid.Health > 0 then
					CommF:InvokeServer("StartQuest", arg, arg2)
					task.wait(0.5)
				end
			else
				ToTarget(v5 * CFrame.new(0, 4, 2), true)
			end
		end

		local tbl11 = { "Control-Control", "Buddha-Buddha", "Diamond-Diamond", "Falcon-Falcon" }

		SkillBoard = function(arg)
			local playerGui = localPlayer:FindFirstChild("PlayerGui")
			playerGui = playerGui and playerGui:FindFirstChild("Main")
			playerGui = playerGui and playerGui:FindFirstChild("Skills")
			return arg and playerGui and playerGui:FindFirstChild(arg.Name)
		end

		SkillReady = function(c)if not c or not c:IsA("Frame")or c.Name=="Template"or not c.Visible then return false;end;local n,L=c:FindFirstChild("Title"),c:FindFirstChild("Cooldown");if not n or not L then return false;end;if string.find(n.Text,"Transformation")or n.Text==""or n.Text=="???"then return false;end;if n.TextColor3~=Color3.new(1,1,1)then return false;end;return L.Size.X.Scale<=0.005;end
		IsSkillOffCooldown = function(n,L)local U= localPlayer :FindFirstChild("PlayerGui");local c=U and(U:FindFirstChild("Main"));U=c and(c:FindFirstChild("Skills"));U=U and(U:FindFirstChild(n));return SkillReady(U and(U:FindFirstChild(L)));end

		PressZSkillIfReady = function(arg)
			if IsSkillOffCooldown(arg, "Z") then
				PressSkillKey("Z", 0.05)
			end
		end

		FindAvailableSkillKey = function(n)local L=SkillBoard(n);if not L then return nil;end;local U=Settings["Select Skills "..n.ToolTip];for w,w in ipairs(SkillKeyOrder[n.ToolTip]or{"Z","X","C","V","F"})do if w~="Z"or not table.find( tbl11 ,n.Name)then if U and U[w]and(SkillReady(L:FindFirstChild(w)))then return w;end;end;end;end

		GetHoldSkillDelay = function(arg, arg2)
			local character = localPlayer.Character
			character = character and character:FindFirstChild(arg2) or localPlayer.Backpack:FindFirstChild(arg2)
			local toolTip = character and character:IsA("Tool") and character.ToolTip
			return tonumber(toolTip and Settings["Skill " .. arg .. " " .. toolTip]) or 0.5
		end

		UsedualFlock = function()local c=WeaponLocked();if c then EquipTool(c);return;end;if Settings["Kill Aura With DragonStorm"]and Settings["Start Farm"]and DragonstormState()~="missing"then HoldWeapon("Dragonstorm",1.5);EquipTool("Dragonstorm");return;end;EquipTool(NameWeapon(Settings["Select Weapon"]or"Melee"));end

		FarmMastery = function(arg)
			if not arg or not arg:FindFirstChild("Humanoid") or not arg:FindFirstChild("HumanoidRootPart") then
				return
			end
			local cFrame = arg.HumanoidRootPart.CFrame
			getgenv().AimPos = cFrame
			if not Settings["Farm Mastery"] then
				UsedualFlock()
				return
			end

			if arg.Humanoid.Health / arg.Humanoid.MaxHealth > (Settings["Health %"] or 100) / 100 then
				UsedualFlock()
				return
			end
			local selectMethodFarmMastery = Settings["Select Method Farm Mastery"]
			local v5 = NameWeapon(selectMethodFarmMastery)
			local v6 = NameWeapon(selectMethodFarmMastery, true)
			if not v5 or not v6 then
				return
			end
			HoldWeapon(v5, 1.5)
			EquipTool(v5)
			if not localPlayer.Character:FindFirstChild(v5) then
				return
			end

			if selectMethodFarmMastery == "Gun" then
				ShootM1(arg)
			end

			if v5 == "Control-Control" then
				local globe = workspace._WorldOrigin:FindFirstChild("Globe")
				local flag = not globe

				if not flag then
					local n = globe.AB.CurveSize0 / 1.75
					flag = localPlayer:DistanceFromCharacter(globe.Position) > n
				end

				if flag then
					PressZSkillIfReady(v5)
					return
				end
			elseif v5 == "Buddha-Buddha" then
				if not localPlayer.Character.HumanoidRootPart:FindFirstChild("Buddha") then
					PressZSkillIfReady(v5)
					return
				end
			elseif v5 == "Diamond-Diamond" then
				if not localPlayer.Character:FindFirstChild("DiamondBody") then
					PressZSkillIfReady(v5)
					return
				end
			elseif v5 == "Falcon-Falcon" then
				if not localPlayer.Character:FindFirstChild("FalconWings") then
					PressZSkillIfReady(v5)
					return
				end
			end

			local v7 = FindAvailableSkillKey(v6)

			if v7 then
				local n

				if Settings["Use skill fast dont hold"] then
					n = 0.05
				else
					n = tonumber(Settings["Skill " .. v7 .. " " .. v6.ToolTip]) or 0.5
				end

				PressSkillKey(v7, n)
			end
		end

		getgenv().StackFarm = true
		getgenv().StackFarmOther = true
		StackFarm = getgenv().StackFarm
		StackFarmOther = getgenv().StackFarmOther
		DetectMobAura = function()local n=Settings["Bring Mob"]and BringTarget;if n and n.Parent and(n:FindFirstChild("HumanoidRootPart"))and(IsMobAlive(n))and  localPlayer :DistanceFromCharacter(n.HumanoidRootPart.Position)<=90 then return n.Name;end;local c,n=typeof(Settings["Distance Farm Aura"])~="number"and(tonumber(Settings["Distance Farm Aura"]))or Settings["Distance Farm Aura"]or 300;for L,U in pairs(game.Workspace.Enemies:GetChildren())do if IsMobAlive(U)then L=(U.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude;if L<c then c,n=L,U.Name;end;end;end;return n;end
		getgenv().StackFarm = true
		getgenv().YPosFruit = 20
		CheckCDSkillTransformation = function(c,n)local L=SkillBoard(c);if not L then return nil;end;for U,w in ipairs(SkillKeyOrder[c.ToolTip]or{"Z","X","C","V","F"})do if not n or n[w]then U=L:FindFirstChild(w);if SkillReady(U)then return U,Settings["Skill "..w.." "..c.ToolTip];end;end;end;end
		PressSkillKey = function(n,L)local U= localPlayer .Character and( localPlayer .Character:FindFirstChildOfClass("Tool"));U=U and(SkillBoard(U));local c=U and(U:FindFirstChild(n));U=c and(c:FindFirstChild("Mobile"));c=U and getconnections and(getconnections(U.MouseButton1Down));if c and#c>0 then for w,w in ipairs(c)do pcall(function()w:Fire();end);end;task.wait(L);for c,c in ipairs(getconnections(U.MouseButton1Up))do pcall(function()c:Fire();end);end;return;end;local c=game:GetService("VirtualInputManager");pcall(function()c:SendKeyEvent(true,n,false,game);end);task.wait(L);pcall(function()c:SendKeyEvent(false,n,false,game);end);end
		SkillOrder = { "Melee", "Sword", "Gun", "Blox Fruit" }
		AutoAllSkill = function(n)local n= localPlayer .Character;local L=n and(n:FindFirstChild("Stun"));if not n or not L or L.Value~=0 then return;end;for U,w in ipairs(SkillOrder)do L,U=Settings["Select Skills "..w],NameWeapon(w,true);U=if L and not next(L)then nil else U;if U and not SkillBoard(U)then EquipTool(U.Name);return;end;if U then w=CheckCDSkillTransformation(U,L);if w then if not n:FindFirstChild(U.Name)then EquipTool(U.Name);task.wait(0.05);end;if  localPlayer .Character and( localPlayer .Character:FindFirstChild(U.Name))then local c=if Settings["Use skill fast dont hold"]then 0.05 else(GetHoldSkillDelay(w.Name,U.Name));PressSkillKey(w.Name,c);end;return;end;end;end;end
		local ItemReplicationService = require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService"))
		local ItemConfig = require(game:GetService("ReplicatedStorage"):WaitForChild("ItemConfig"))
		GetInventoryItems = function()local n={};local L=require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService")).KEYS;for U,U in  ItemReplicationService :GetItems(L.QUANTITY)do if U.Value and U.Value>0 then local w,y=pcall(function()return  ItemConfig .match(U.ItemId):unwrap();end);if w and y and y.Display then local w,S=y.Display.Category,y.Index and y.Index.StorageKey;local K,R=if w=="Blox Fruit"then S or y.Display.Name or"ItemId_"..U.ItemId else y.Display.Name or S or"ItemId_"..U.ItemId, ItemReplicationService :ReadItem(L.MASTERY,U.ItemId,U.NetworkedUID)or 0;table.insert(n,{Name=K,Type=w,Count=U.Value,Mastery=R,ItemId=U.ItemId,UID=U.NetworkedUID});end;end;end;return n;end
		CheckItemInventory = function(...) end

		DetectModelDestroyTyrant = function()
			local v5 = next
			local children, v6 = (workspace.Map:FindFirstChild("TikiOutpost") and workspace.Map.TikiOutpost.IslandModel:FindFirstChild("EagleBossArena", true)):GetChildren()

			for _, v7 in v5, children, v6 do
				if v7.Name == "Tree" and not v7:GetAttribute("AlreadyDestroyedClient") then
					return v7
				end
			end
		end

		local function fn()
			local str2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

			return {
				encode = function(arg)
					return (arg:gsub(".", function(arg2)
						local v5 = arg2:byte()
						local str3 = ""

						for i_ = 8, 1, -1 do
							str3 ..= v5 % 2 ^ i_ - v5 % 2 ^ (i_ - 1) > 0 and "1" or "0"
						end

						return str3
					end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(arg2)
						if #arg2 < 6 then
							return ""
						end
						local n = 0

						for i_ = 1, 6 do
							n += arg2:sub(i_, i_) == "1" and 2 ^ (6 - i_) or 0
						end

						return ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):sub(n + 1, n + 1)
					end) .. ({ "", "==", "=" })[#arg % 3 + 1]
				end,
				decode = function(arg)
					return string.gsub(arg, "[^" .. str2 .. "=]", ""):gsub(".", function(arg2)
						if arg2 == "=" then
							return ""
						end
						local n = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):find(arg2) - 1
						local str3 = ""

						for i_ = 6, 1, -1 do
							str3 ..= n % 2 ^ i_ - n % 2 ^ (i_ - 1) > 0 and "1" or "0"
						end

						return str3
					end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(arg2)
						if #arg2 ~= 8 then
							return ""
						end
						local n = 0

						for i_ = 1, 8 do
							n += arg2:sub(i_, i_) == "1" and 2 ^ (8 - i_) or 0
						end

						return string.char(n)
					end)
				end,
			}
		end

		fn()
		HopFindNotice = {}
		SpecialHop = function(c)local n=tostring(c);if tick()-(HopFindNotice[n]or 0)<30 then return;end;HopFindNotice[n]=tick();VxezeNotify("Hop Find",n.." not found here, hopping to a new server","info",{Key="hopfind"..n,Repeat=30});HopServer();end
		TreeBreaker = { tree = nil, told = 0 }
		BreakTyrantTree = function(n)getgenv().AimPos=n.WorldPivot;if TreeBreaker.tree~=n then TreeBreaker.tree=n;VxezeNotify("Farm Tiki","Breaking the tree to spawn Tyrant of the Skies","info",{Key="tyranttree"});end;local L= localPlayer .Character;if not(L and(L:FindFirstChild("Skull Guitar"))or( localPlayer .Backpack:FindFirstChild("Skull Guitar"))or(CheckItemInventory("Skull Guitar")))then local U=n.WorldPivot.Position;local w=CFrame.lookAt(U+Vector3.new(0,3,7),U);if  localPlayer :DistanceFromCharacter(w.Position)>6 then ToTarget(w);return;end;if tick()-TreeBreaker.told>30 then TreeBreaker.told=tick();VxezeNotify("Farm Tiki","No Skull Guitar, breaking the tree with weapon skills","info",{Key="noguitar"});end;getgenv().AimPos=CFrame.new(U);AimForceUntil=tick()+1;AutoAllSkill();return;end;HoldWeapon("Skull Guitar",3);if not(L and(L:FindFirstChild("Skull Guitar")))and not  localPlayer .Backpack:FindFirstChild("Skull Guitar")then if tick()-(TreeBreaker.loaded or 0)>3 then TreeBreaker.loaded=tick();game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem","Skull Guitar");end;return;end;if not SpamGunNamed("Skull Guitar",n)and  localPlayer .Character and( localPlayer .Character:FindFirstChild("Skull Guitar"))then pcall(getgenv().SpamGunSkullGuitar,n.WorldPivot);end;end

		FarmMethod = function()
			local selectMethodFarm = Settings["Select Method Farm"]
			local n, str2, tbl12

			if selectMethodFarm == "Cake" then
				n = 2275
				str2 = "CakeQuest2"
				tbl12 = tbl6
			elseif selectMethodFarm == "Bone" then
				n = 2050
				str2 = "HauntedQuest2"
				tbl12 = tbl8
			elseif selectMethodFarm == "Tiki" then
				n = 2575
				str2 = "TikiQuest3"
				tbl12 = tbl10
			else
				local flag = selectMethodFarm == "Nearest" and DetectMobAura()
				n = 9999
				str2 = nil
				tbl12 = nil

				if flag then
					tbl12 = { DetectMobAura() }
					str2 = nil
				end
			end

			local str3

			if Settings["Farm Material"] then
				local selectMaterial = Settings["Select Material"]
				local v5
				str3, v5 = GetMaterialMobs(selectMaterial)

				if v5 then
					VxezeNotify("Farm Material", selectMaterial .. " only drops in Sea " .. v5 .. ", heading there now", "info", { Key = "materialsea", Repeat = 30 })
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(SeaTravelRemote[v5])
					return
				end

				if not str3 then
					VxezeNotify("Farm Material", "Pick a material first, nothing is set to farm", "warning", { Key = "materialpick", Repeat = 30 })
					return
				end
			else
				str3 = tbl12
			end

			str3 = str3 or GetQuestMob() or ""

			if not HasQuest() and typeof(str3) == "string" then
				TakeQuestLevel()
			else
				if Settings["Accept Quest [ Cake / Bone / Tiki ]"] and localPlayer.Data.Level.Value >= n then
					if HasQuest() and not QuestMatchesMethod(tbl12) then
						local v5 = QuestAbandonAt

						if tick() - v5 > 3 then
							QuestAbandonAt = tick()
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
							VxezeNotify("Accept Quest", "Abandoning the wrong quest so it can take " .. tostring(Settings["Select Method Farm"]), "info", { Key = "questabandon" })
						end

						return
					end

					if not HasQuest() then
						QuestBoneAndkatakuri(str2, 2)
						return
					end
				end

				if not Settings["Farm Material"] and Settings["Select Method Farm"] == "Tiki" and not Settings["Ignore Boss"] then
					if CheckNameBoss("Tyrant of the Skies") then
						local v5 = CheckNameBoss("Tyrant of the Skies")

						while true do
							task.wait()
							SizePart(v5)

							if game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"]) then
								ToTarget(v5.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							elseif Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v5.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(v5.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							UsedualFlock()
							ClickM1(v5)
							if not (not IsMobAlive(v5) or not Settings["Start Farm"] or not StackFarm) then
								continue
							end
							break
						end

						return
					end

					local islandModel = workspace:FindFirstChild("Map", true) and workspace.Map:FindFirstChild("TikiOutpost", true) and workspace.Map.TikiOutpost:FindFirstChild("IslandModel", true)

					if islandModel then
						local eye1 = islandModel:FindFirstChild("Eye1", true)
						local eye2 = islandModel:FindFirstChild("Eye2", true)
						local eye3 = islandModel:FindFirstChild("Eye3", true)
						local eye4 = islandModel:FindFirstChild("Eye4", true)

						if eye1 and eye2 and eye3 and eye4 and eye1.Transparency == 0 and eye2.Transparency == 0 and eye3.Transparency == 0 and eye4.Transparency == 0 then
							local v5 = DetectModelDestroyTyrant()

							if v5 then
								if localPlayer:DistanceFromCharacter(v5.WorldPivot.Position) > 10 then
									ToTarget(v5.WorldPivot)
								else
									BreakTyrantTree(v5)
								end
							end

							return
						end
					end
				end

				if not Settings["Farm Material"] and Settings["Select Method Farm"] == "Cake" and not Settings["Ignore Boss"] then
					if CheckNameBoss("Cake Prince") then
						local v5 = CheckNameBoss("Cake Prince")

						while true do
							task.wait()
							SizePart(v5)

							if game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"]) then
								ToTarget(v5.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							elseif Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v5.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(v5.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							UsedualFlock()
							ClickM1(v5)
							if not (not IsMobAlive(v5) or not Settings["Start Farm"] or not StackFarm) then
								continue
							end
							break
						end

						return
					end
				end

				local v5 = DetectMob(str3)

				if not v5 then
					if typeof(str3) == "table" then
						if #str3 <= #tbl5 then
							tbl5 = {}
							return
						end
						local v6 = DetectNameTablePart(str3)
						local v7 = DetectPartSpawnMob(v6)

						if v7 then
							table.insert(tbl5, v6)

							while true do
								task.wait()
								ToTarget(v7.CFrame * CFrame.new(0, 60, 0))
								if not (localPlayer:DistanceFromCharacter(v7.Position) <= 100 or DetectMob(str3) or not Settings["Start Farm"] or not StackFarm) then
									continue
								end
								break
							end

							wait(1)
						end
					else
						local v6 = DetectPartSpawnMob(str3, true)

						if v6 then
							Instance.new("IntValue", v6).Name = "Ignored"

							while true do
								task.wait()
								ToTarget(v6.CFrame * CFrame.new(0, 60, 0))
								if not (localPlayer:DistanceFromCharacter(v6.Position) <= 100 or DetectMob(str3) or not Settings["Start Farm"] or not StackFarm) then
									continue
								end
								break
							end

							wait(1)
						else
							DeleteIgnoredMobSpawn()
						end
					end
				else
					while true do
						task.wait()
						SizePart(v5)
						BringMob(v5)
						FarmMastery(v5)
						ClickM1(v5)

						if game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"]) then
							ToTarget(v5.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						elseif Settings["Select Weapon"] == "Blox Fruit" then
							ToTarget(v5.HumanoidRootPart.CFrame * CFrame.new(-7, getgenv().YPosFruit, 0))
						else
							ToTarget(v5.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end

						if not (not IsMobAlive(v5) or not Settings["Start Farm"] or not StackFarm) then
							continue
						end
						break
					end

					if getgenv().QuestTrainer and getgenv().QuestTrainer.CountKillMob then
						getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
					end
				end
			end
		end
	end

	spawn(function()
		while task.wait(Settings["Start Farm"] and StackFarm and 0.03 or 0.3) do
			local ok, result = pcall(function()
				if Settings["Start Farm"] and StackFarm then
					FarmMethod()
				end
			end)

			if result then
				PrintOnce(result)
			end
		end
	end)

	stackFarmMain = Main.CreatePage({ Page_Name = "Stack Farming", Page_Title = "Stack Farming" })
	BossHealthPercent = function(c)local n=c and(c:FindFirstChildOfClass("Humanoid"));if not n or n.MaxHealth<=0 then return nil;end;return math.clamp(n.Health/n.MaxHealth*100,0,100);end

	StartBossStatusPoll = function(arg, arg2, arg3)
		task.spawn(function()
			while task.wait(1.5) do
				if not (arg3 and not SeaOnlyNone(arg, "Status", arg3)) then
					local ok, result = pcall(arg2)

					if ok and result then
						local v5 = BossHealthPercent(result)
						arg.SetText("Status : 🟢 Spawned | " .. (v5 and string.format("%.0f%% HP", v5) or "Unknown HP"))
					else
						arg.SetText("Status : 🔴 Not Spawned")
					end
				end
			end
		end)
	end

	AutoWorldSection = stackFarmMain.CreateSection("World Unlock")
	local v5
	v5 = nil

	do
		local createToggle = AutoWorldSection.CreateToggle
		local tbl9 = { Title = "Auto New World", Desc = nil, Default = Settings["Auto New World"] or false }

		local function fn(arg)
			if arg and not EnforceGate(v5, "Auto New World", Place_Id.sea1(), "Only works in Sea 1") then
				return
			end
			SaveSettings("Auto New World", arg)
		end

		v5 = createToggle
		v5 = v5(tbl9, fn)
	end

	local n2

	do
		local v6 = nil
		local createToggle = AutoWorldSection.CreateToggle
		local tbl9 = { Title = "Auto Third World", Desc = nil, Default = Settings["Auto Third World"] or false }

		local function fn(arg)
			if arg and not EnforceGate(v6, "Auto Third World", Place_Id.sea2(), "Only works in Sea 2") then
				return
			end
			SaveSettings("Auto Third World", arg)
		end

		v6 = createToggle
		v6 = v6(tbl9, fn)
		getgenv().GetTime = nil
		NotiGetTime = true
		CollectFruitsChestsBerriesSection = stackFarmMain.CreateSection("Collect Fruits / Chests / Berries")

		CollectFruitsChestsBerriesSection.CreateSlider({
			Title = "Value Collect Chest to Hop",
			Min = 0,
			Max = 100,
			Default = Settings["Value Collect Chest to Hop"] or 20,
			Precise = true,
		}, function(arg)
			SaveSettings("Value Collect Chest to Hop", arg)
		end)

		StatusSpawnFruit = CollectFruitsChestsBerriesSection.CreateLabel({ Title = "Status Fruits : ..." })
		StatusSpawnChest = CollectFruitsChestsBerriesSection.CreateLabel({ Title = "Status Chests : ..." })
		StatusSpawnBerries = CollectFruitsChestsBerriesSection.CreateLabel({ Title = "Status Berries : ..." })
		SpotCache = setmetatable({}, { __mode = "k" })

		CachedLocation = function(arg)
			local v7 = SpotCache[arg]

			if not v7 then
				v7 = LocationLabel(arg)
				SpotCache[arg] = v7
			end

			return v7
		end

		task.spawn(function()
			while task.wait(2) do
				local ok, result = pcall(GetPathFruit)

				if ok and result then
					StatusSpawnFruit.SetText("Status Fruits : 🟢 Found | " .. result.Name .. " | " .. CachedLocation(result))
				else
					StatusSpawnFruit.SetText("Status Fruits : 🔴 Not Spawned")
				end

				local chestsCollectedSinceHop = getgenv().ChestsCollectedSinceHop or 0
				local valueCollectChestToHop = Settings["Value Collect Chest to Hop"] or 20
				local str2 = GetCurrentSea() == 2 and "Fist of Darkness" or "God's Chalice"

				if GetCurrentSea() == 1 then
					StatusSpawnChest.SetText("Status Chests : " .. chestsCollectedSinceHop .. "/" .. valueCollectChestToHop)
				elseif getgenv().GoCollectChest then
					StatusSpawnChest.SetText("Status Chests : " .. chestsCollectedSinceHop .. "/" .. valueCollectChestToHop .. " | 🟢 " .. str2 .. " Spawned")
				else
					StatusSpawnChest.SetText("Status Chests : " .. chestsCollectedSinceHop .. "/" .. valueCollectChestToHop .. " | 🔴 Not Spawned")
				end

				local ok2, result2, result3 = pcall(DetectBerry)

				if ok2 and result2 then
					StatusSpawnBerries.SetText("Status Berries : 🟢 Found | " .. (result3 or result2.Name) .. " | " .. CachedLocation(result2))
				else
					StatusSpawnBerries.SetText("Status Berries : 🔴 Not Spawned")
				end
			end
		end)

		CollectFruitsChestsBerriesSection.CreateToggle({
			Title = "Auto Collect Fruits",
			Desc = nil,
			Default = Settings["Auto Collect Fruits"] or false,
		}, function(arg)
			SaveSettings("Auto Collect Fruits", arg)
		end)

		CollectFruitsChestsBerriesSection.CreateToggle({
			Title = "Auto Collect Berries",
			Desc = nil,
			Default = Settings["Auto Collect Berries"] or false,
		}, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Collect Berries"] and task.wait(0.1) do
						pcall(function()
							local v7 = DetectBerry()

							if v7 then
								local v8 = DetectModelBerry(v7)

								if not v8 then
									ToTarget(v7.Parent.WorldPivot)
								else
									ToTarget(v8.WorldPivot)
									local proximityPrompt = v8:FindFirstChild("ProximityPrompt")

									if proximityPrompt then
										fireproximityprompt(proximityPrompt)
									end
								end
							else
								VxezeNotify("Berry", "Waiting Berry spawn", "warning")

								if Settings["Hop Find Fruits / Berries / Chests"] then
									HopServer()
								end

								wait(5)
							end
						end)
					end
				end)
			end

			SaveSettings("Auto Collect Berries", arg)
		end)

		CollectFruitsChestsBerriesSection.CreateToggle({
			Title = "Collect Chest When Server Spawn Legend Items",
			Desc = nil,
			Default = Settings["Collect Chest When Server Spawn Legend Items"] or false,
		}, function(arg)
			SaveSettings("Collect Chest When Server Spawn Legend Items", arg)
		end)

		CollectFruitsChestsBerriesSection.CreateToggle({
			Title = "Auto Collect Chests",
			Desc = nil,
			Default = Settings["Auto Collect Chests"] or false,
		}, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Collect Chests"] and task.wait(0.1) do
						local ok, result = pcall(function()
							AutoChest()
						end)

						if result then
							PrintOnce(result)
						end
					end
				end)
			end

			SaveSettings("Auto Collect Chests", arg)
		end)

		CollectFruitsChestsBerriesSection.CreateToggle({
			Title = "Hop Find Fruits / Berries / Chests",
			Desc = nil,
			Default = Settings["Hop Find Fruits / Berries / Chests"] or false,
		}, function(arg)
			SaveSettings("Hop Find Fruits / Berries / Chests", arg)
		end)

		EventGameSection = stackFarmMain.CreateSection("Event Time")
		local v7 = nil
		local createToggle2 = EventGameSection.CreateToggle
		local tbl10 = { Title = "Auto Factory", Desc = nil, Default = Settings["Auto Factory"] or false }

		local function fn2(arg)
			if arg and not EnforceGate(v7, "Auto Factory", Place_Id.sea2(), "Only works in Sea 2 (Factory)") then
				return
			end
			SaveSettings("Auto Factory", arg)
		end

		v7 = createToggle2
		v7 = v7(tbl10, fn2)
		local v8 = nil
		local createToggle3 = EventGameSection.CreateToggle
		local tbl11 = { Title = "Auto Pirate Raid", Desc = nil, Default = Settings["Auto Pirate Raid"] or false }

		local function fn3(arg)
			if arg and not EnforceGate(v8, "Auto Pirate Raid", Place_Id.sea3(), "Only works in Sea 3") then
				return
			end
			SaveSettings("Auto Pirate Raid", arg)
		end

		v8 = createToggle3
		v8 = v8(tbl11, fn3)
		EliteHunterSection = stackFarmMain.CreateSection("Elite Hunter")
		EliteHunterStatus = EliteHunterSection.CreateLabel({ Title = "Status Elite Hunter : ..." })

		EliteHunterSection.CreateToggle({ Title = "Auto Elite Hunter", Desc = nil, Default = Settings["Auto Elite Hunter"] or false }, function(arg)
			SaveSettings("Auto Elite Hunter", arg)
		end)

		EliteHunterSection.CreateToggle({
			Title = "Hop Find Elite Hunter",
			Desc = "Hop if u have God chalice and teleport in safezone",
			Default = Settings["Hop Server Elite Hunter"] or false,
		}, function(arg)
			SaveSettings("Hop Server Elite Hunter", arg)
		end)

		task.spawn(function()
			while task.wait(1.5) do
				if SeaOnlyNone(EliteHunterStatus, "Status Elite Hunter", { 3 }) then
					local ok, result = pcall(DetectEliteHunter)

					if ok and result then
						local position = result.PrimaryPart and result.PrimaryPart.Position or result:GetPivot().Position
						local name_ = AreaAt(position)

						if name_ == "" then
							local v9 = nil

							for _, child in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
								if child:IsA("BasePart") and child.Name ~= "Sea" then
									local magnitude = (child.Position - position).Magnitude

									if not v9 or magnitude < v9 then
										name_ = child.Name
										v9 = magnitude
									end
								end
							end
						end

						EliteHunterStatus.SetText("Status Elite Hunter : 🟢 Spawned | " .. result.Name .. " | " .. (name_ ~= "" and name_ or "Sea 3"))
					else
						EliteHunterStatus.SetText("Status Elite Hunter : 🔴 Not Spawned")
					end
				end
			end
		end)

		RipIndraSection = stackFarmMain.CreateSection("Rip Indra")
		RipIndraStatus = RipIndraSection.CreateLabel({ Title = "Status : ..." })

		StartBossStatusPoll(RipIndraStatus, function()
			return CheckNameBoss("rip_indra True Form")
		end, { 3 })

		local v9 = nil
		local createToggle4 = RipIndraSection.CreateToggle

		local tbl12 = {
			Title = "Auto Touch Pad Haki",
			Desc = "Needs all 3 legendary Haki colors owned first",
			Default = Settings["Auto Touch Pad Haki"] or false,
		}

		local function fn4(arg)
			if arg and not EnforceGate(v9, "Auto Touch Pad Haki", Place_Id.sea3(), "Only works in Sea 3") then
				return
			end

			if arg then
				local ok, result = pcall(IsMisisngLegHaki)
				if not EnforceGate(v9, "Auto Touch Pad Haki", ok and not result, "You need all 3 legendary Haki colors first") then
					return
				end
			end

			SaveSettings("Auto Touch Pad Haki", arg)
		end

		v9 = createToggle4
		v9 = v9(tbl12, fn4)
		local v10 = nil
		local createToggle5 = RipIndraSection.CreateToggle

		local tbl13 = {
			Title = "Auto Summon Rip Indra",
			Desc = nil,
			Default = Settings["Auto Summon Rip Indra"] or false,
		}

		local function fn5(arg)
			if arg and not EnforceGate(v10, "Auto Summon Rip Indra", DetectItemPlr("God's Chalice") ~= nil, "You need a God's Chalice to summon it") then
				return
			end
			SaveSettings("Auto Summon Rip Indra", arg)
		end

		v10 = createToggle5
		v10 = v10(tbl13, fn5)
		local v11 = nil
		local createToggle6 = RipIndraSection.CreateToggle
		local tbl14 = { Title = "Attack Rip Indra", Desc = nil, Default = Settings["Attack Rip Indra"] or false }

		local function fn6(arg)
			if arg and not EnforceGate(v11, "Attack Rip Indra", Place_Id.sea3(), "Only works in Sea 3") then
				return
			end
			SaveSettings("Attack Rip Indra", arg)
		end

		v11 = createToggle6
		v11 = v11(tbl14, fn6)
		EnforceGate = function(c,n,L,U)if L then return true;end;SaveSettings(n,false);if c and c.SetStage then c:SetStage(false);end;VxezeNotify(n,U,"warning",{Key="gate"..n});return false;end
		SoftGate = function(c,n,L)if not n then VxezeNotify(c,L,"warning",{Key="softgate"..c});end;end
		SoulReaperSection = stackFarmMain.CreateSection("Soul Reaper")
		SoulReaperStatus = SoulReaperSection.CreateLabel({ Title = "Status : ..." })

		StartBossStatusPoll(SoulReaperStatus, function()
			return CheckNameBoss("Soul Reaper")
		end, { 3 })

		local v12 = nil
		local createToggle7 = SoulReaperSection.CreateToggle
		local tbl15 = { Title = "Attack Soul Reaper", Desc = nil, Default = Settings["Attack Soul Reaper"] or false }

		local function fn7(arg)
			if arg and not EnforceGate(v12, "Attack Soul Reaper", Place_Id.sea3(), "Only works in Sea 3") then
				return
			end
			SaveSettings("Attack Soul Reaper", arg)
		end

		v12 = createToggle7
		v12 = v12(tbl15, fn7)
		local v13 = nil
		local createToggle8 = SoulReaperSection.CreateToggle
		local tbl16 = { Title = "Summon Soul Reaper", Desc = nil, Default = Settings["Summon Soul Reaper"] or false }

		local function fn8(arg)
			if arg and not EnforceGate(v13, "Summon Soul Reaper", Settings["Attack Soul Reaper"] == true, "Turn on Attack Soul Reaper first") then
				return
			end

			if arg and not EnforceGate(v13, "Summon Soul Reaper", DetectItemPlr("Hallow Essence") ~= nil, "You need a Hallow Essence to summon it") then
				return
			end
			SaveSettings("Summon Soul Reaper", arg)
		end

		v13 = createToggle8
		v13 = v13(tbl16, fn8)
		DoughKingSection = stackFarmMain.CreateSection("Dough King")
		DoughKingStatus = DoughKingSection.CreateLabel({ Title = "Status : ..." })

		StartBossStatusPoll(DoughKingStatus, function()
			return CheckNameBoss("Dough King")
		end, { 3 })

		local v14 = nil
		local createToggle9 = DoughKingSection.CreateToggle
		local tbl17 = { Title = "Attack Dough King", Desc = nil, Default = Settings["Attack Dough King"] or false }

		local function fn9(arg)
			if arg and not EnforceGate(v14, "Attack Dough King", Place_Id.sea3(), "Only works in Sea 3") then
				return
			end
			SaveSettings("Attack Dough King", arg)
		end

		v14 = createToggle9
		v14 = v14(tbl17, fn9)
		local v15 = nil
		local createToggle10 = DoughKingSection.CreateToggle
		local tbl18 = { Title = "Summon Dough King", Desc = nil, Default = Settings["Summon Dough King"] or false }

		local function fn10(arg)
			if arg and not EnforceGate(v15, "Summon Dough King", Settings["Attack Dough King"] == true, "Turn on Attack Dough King first") then
				return
			end

			if arg and not EnforceGate(v15, "Summon Dough King", DetectItemPlr("Sweet Chalice") ~= nil, "You need a Sweet Chalice to summon it") then
				return
			end

			if arg then
				RunFarmLoop("Summon Dough King", 1, function()
					if DetectItemPlr("Sweet Chalice") then
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
					end
				end)
			end

			SaveSettings("Summon Dough King", arg)
		end

		v15 = createToggle10
		v15 = v15(tbl18, fn10)

		DoughKingSection.CreateToggle({
			Title = "Hop Find Dough King",
			Desc = nil,
			Default = Settings["Hop Find Dough King"] or false,
		}, function(arg)
			SaveSettings("Hop Find Dough King", arg)
		end)

		DarkbeardSection = stackFarmMain.CreateSection("Darkbeard")
		DarkbeardStatus = DarkbeardSection.CreateLabel({ Title = "Status : ..." })

		StartBossStatusPoll(DarkbeardStatus, function()
			return CheckNameBoss("Darkbeard")
		end, { 2 })

		local v16 = nil
		local createToggle11 = DarkbeardSection.CreateToggle
		local tbl19 = { Title = "Attack Darkbeard", Desc = nil, Default = Settings["Attack Darkbeard"] or false }

		local function fn11(arg)
			if arg and not EnforceGate(v16, "Attack Darkbeard", Place_Id.sea3(), "Only works in Sea 3") then
				return
			end
			SaveSettings("Attack Darkbeard", arg)
		end

		v16 = createToggle11
		v16 = v16(tbl19, fn11)
		local v17 = nil
		local createToggle12 = DarkbeardSection.CreateToggle
		local tbl20 = { Title = "Summon Darkbeard", Desc = nil, Default = Settings["Summon Darkbeard"] or false }

		local function fn12(arg)
			if arg and not EnforceGate(v17, "Summon Darkbeard", Settings["Attack Darkbeard"] == true, "Turn on Attack Darkbeard first") then
				return
			end

			if arg and not EnforceGate(v17, "Summon Darkbeard", DetectItemPlr("Fist of Darkness") ~= nil, "You need a Fist of Darkness to summon it") then
				return
			end
			SaveSettings("Summon Darkbeard", arg)
		end

		v17 = createToggle12
		v17 = v17(tbl20, fn12)

		DarkbeardSection.CreateToggle({ Title = "Hop Find Darkbeard", Desc = nil, Default = Settings["Hop Find Darkbeard"] or false }, function(arg)
			SaveSettings("Hop Find Darkbeard", arg)
		end)

		GetPathFruit = function()local c,n,L=next,game.Workspace:GetChildren();for U,U in c,n,L do if(U:IsA("Tool")or(U:IsA("Model")))and(string.find(U.Name,"Fruit"))and(U:FindFirstChild("Handle"))and(U:GetAttribute("DroppedAt")~=nil or U:GetAttribute("OriginalName")~=nil)then return U;end;end;end

		GetPirateRaid = function(arg)
			local v18 = ipairs
			local replicatedStorage

			if arg then
				replicatedStorage = game.ReplicatedStorage
			else
				replicatedStorage = game.workspace.Enemies
			end

			for _, child in v18(replicatedStorage:GetChildren()) do
				if child:IsA("Model") and child.Name ~= "Oni2" and not string.find(child.Name, "Boss") and not string.find(child.Name, "Friend") and not string.find(child.Name, "Wraith") and child.Name ~= "rip_indra True Form" and IsMobAlive(child) and (child.HumanoidRootPart.Position - Vector3.new(-5543, 313, -2964)).magnitude < 1000 then
					return child
				end
			end
		end

		DetectButtons = function()local c=game:GetService("Workspace").Map:FindFirstChild("Boat Castle",true);c=c and(c:FindFirstChild("Summoner"));c=c and(c:FindFirstChild("Circle"));if not c then return nil;end;for n,n in ipairs(c:GetChildren())do if n:IsA("Part")and n.BrickColor.Name~="Lime green"then return n;end;end;end
		local tbl21 = { "Winter Sky", "Pure Red", "Snow White" }

		IsMisisngLegHaki = function(arg)
			local tbl22 = arg and {}
			local hiddenName = nil

			for _, v18 in pairs(CommF:InvokeServer("getColors")) do
				if table.find(tbl21, v18.HiddenName) and not v18.Unlocked then
					if tbl22 then
						table.insert(tbl22, v18.HiddenName)
					elseif not hiddenName then
						hiddenName = v18.HiddenName
					else
						hiddenName ..= ", " .. v18.HiddenName
					end
				end
			end

			if tbl22 then
				return tbl22
			end
			return hiddenName
		end

		HakiColorMap = { ["Hot pink"] = "Winter Sky", ["Really red"] = "Pure Red", Oyster = "Snow White" }

		TouchPadHaki = function()
			local v18 = DetectButtons()
			if not v18 then
				return
			end
			local v19 = HakiColorMap[v18.BrickColor.Name]
			if not v19 then
				return
			end
			local rfFruitCustomizerRF = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/FruitCustomizerRF")

			if rfFruitCustomizerRF then
				rfFruitCustomizerRF:InvokeServer({ StorageName = v19, Type = "AuraSkin", Context = "Equip" })
			end

			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", v19)
			ToTarget(v18.CFrame)
			wait(2)
			return true
		end

		getgenv().CheckCountItem = function(arg, arg2)
			local v18 = next
			local v19, v20 = GetInventoryItems()

			for _, v21 in v18, v19, v20 do
				if v21.Name == arg and v21.Count and v21.Count >= arg2 then
					return true
				end
			end

			return false
		end

		GetBackpackFruits = function()
			mybackpack = {}
			local v18 = next
			local children, v19 = game.Players.LocalPlayer.Backpack:GetChildren()

			for _, v20 in v18, children, v19 do
				if v20:IsA("Tool") and table.find(whitelistedfruit, v20.Name) then
					table.insert(mybackpack, v20.Name)
				end
			end

			local v20 = next
			local children2, v21 = game.Players.LocalPlayer.Character:GetChildren()

			for _, v22 in v20, children2, v21 do
				if v22:IsA("Tool") and table.find(whitelistedfruit, v22.Name) then
					table.insert(mybackpack, v22.Name)
				end
			end

			return mybackpack
		end

		CheckFruitplr = function()
			local name_ = nil

			for _, child in pairs(localPlayer.Backpack:GetChildren()) do
				if string.find(child.Name, "Fruit") then
					name_ = child.Name
				end
			end

			for _, child in pairs(localPlayer.Character:GetChildren()) do
				if string.find(child.Name, "Fruit") then
					name_ = child.Name
				end
			end

			return name_
		end

		TakeFruitInventory = function(arg)
			local v18 = next
			local v19, v20 = GetInventoryItems()
			local huge = math.huge
			local v21 = nil

			for _, v22 in v18, v19, v20 do
				if v22.Type == "Blox Fruit" then
					if not arg then
						for k, v23 in pairs(getgenv().tablefruitausea3) do
							if v22.Name == k then
								if tonumber(v23) < tonumber(huge) then
									huge = v23
									v21 = k
								end
							end
						end

						continue
					end

					local name_ = v22.Name
					if not getgenv().tablefruitausea3[name_] then
						return v22.Name
					end
				end
			end

			return v21
		end

		cframethangdaubuoiredhead = CFrame.new(-1926.78772, 12.1678171, 1739.80884, 0.956294656, 0, -0.292404652, 0, 1, 0, 0.292404652, 0, 0.956294656)

		StopThirdSea = function()
			if Place_Id.sea2() and localPlayer.Data.Level.Value >= 1500 then
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") ~= 3 then
					return true
				end

				if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") ~= 0 then
					if #GetBackpackFruits() >= 1 then
						return true
					end

					if not CheckFruitplr() and TakeFruitInventory() then
						StopStoreFruit = true
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", TakeFruitInventory())
					end
				elseif not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") then
					if CheckNameBoss("Don Swan") then
						return true
					end
				elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
					return true
				end
			end
		end

		GetBartiloPlate = function()
			local str2

			if game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate1.BrickColor == BrickColor.new("Sand yellow") then
				str2 = "Plate1"
			elseif game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate2.BrickColor == BrickColor.new("Sand yellow") then
				str2 = "Plate2"
			elseif game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate3.BrickColor == BrickColor.new("Sand yellow") then
				str2 = "Plate3"
			elseif game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate4.BrickColor == BrickColor.new("Sand yellow") then
				str2 = "Plate4"
			elseif game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate5.BrickColor == BrickColor.new("Sand yellow") then
				str2 = "Plate5"
			elseif game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate6.BrickColor == BrickColor.new("Sand yellow") then
				str2 = "Plate6"
			elseif game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate7.BrickColor == BrickColor.new("Sand yellow") then
				str2 = "Plate7"
			elseif game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate8.BrickColor == BrickColor.new("Sand yellow") then
				str2 = "Plate8"
			else
				str2 = nil
			end

			return str2
		end

		AutoQuestBarito = function()
			if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
				if string.find(GetQuestTitle(), "Swan Pirates") and string.find(GetQuestTitle(), "50") and HasQuest() then
					local v18 = DetectMob("Swan Pirate")

					if not v18 then
						if typeof("Swan Pirate") == "table" then
							if #tbl5 >= 11 then
								tbl5 = {}
								return
							end
							local v19 = DetectPartSpawnMob(DetectNameTablePart("Swan Pirate"))

							if v19 then
								table.insert(tbl5, DetectNameTablePart("Swan Pirate"))

								while true do
									wait()
									ToTarget(v19.CFrame * CFrame.new(0, 60, 0))
									if not (localPlayer:DistanceFromCharacter(v19.Position) <= 100 or DetectMob("Swan Pirate")) then
										continue
									end
									break
								end

								wait(1)
							end
						else
							local v19 = DetectPartSpawnMob("Swan Pirate", true)

							if v19 then
								Instance.new("IntValue", v19).Name = "Ignored"

								while true do
									wait()
									ToTarget(v19.CFrame * CFrame.new(0, 60, 0))
									if not (localPlayer:DistanceFromCharacter(v19.Position) <= 100 or DetectMob("Swan Pirate")) then
										continue
									end
									break
								end

								wait(1)
							else
								DeleteIgnoredMobSpawn()
							end
						end
					else
						while true do
							task.wait()
							SizePart(v18)
							BringMob(v18)
							UsedualFlock()
							ClickM1(v18)

							if Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							if IsMobAlive(v18) then
								continue
							end
							break
						end
					end
				elseif (localPlayer.Character.HumanoidRootPart.Position - CFrame.new(-456.28952, 73.0200958, 299.895966).Position).Magnitude > 8 then
					ToTarget(CFrame.new(-456.28952, 73.0200958, 299.895966))
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "StartQuest", "BartiloQuest", 1 }))
				end
			elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
				local Jeremy = CheckNameBoss("Jeremy")

				if Jeremy then
					while true do
						task.wait()
						SizePart(Jeremy)
						UsedualFlock()
						ClickM1(Jeremy)

						if Settings["Select Weapon"] == "Blox Fruit" then
							ToTarget(Jeremy.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							ToTarget(Jeremy.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end

						if IsMobAlive(Jeremy) then
							continue
						end
						break
					end
				end
			elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
				while true do
					task.wait()

					if (localPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1835.65, 10.4325, 1679.75)).Magnitude > 100 then
						ToTarget(CFrame.new(-1835.65, 10.4325, 1679.75))
					else
						localPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates[GetBartiloPlate()].CFrame
						task.wait()
						firetouchinterest(game:GetService("Workspace").Map.Dressrosa.BartiloPlates[GetBartiloPlate()], game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
						firetouchinterest(game:GetService("Workspace").Map.Dressrosa.BartiloPlates[GetBartiloPlate()], game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
					end

					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") ~= 3 then
						continue
					end
					break
				end
			end
		end

		SeaThird = function()
			if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") == 0 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 1 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Zou") == 0 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
			end

			if Place_Id.sea2() and localPlayer.Data.Level.Value >= 1500 then
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
					if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") ~= 0 then
						if #GetBackpackFruits() >= 1 then
							ToTarget(CFrame.new(-339.79840087891, 331.86065673828, 643.83178710938))

							if (Vector3.new(-339.7984, 331.86066, 643.8318) - localPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
								if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") ~= 1 then
									local v18 = next
									local v19, v20 = GetBackpackFruits()

									for _, v21 in v18, v19, v20 do
										localPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(v21))
									end

									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "1")
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "2")
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "3")
								end
							end
						elseif not CheckFruitplr() and TakeFruitInventory() then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", TakeFruitInventory())
						end
					elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") == 0 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 1 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Zou") == 0 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
					elseif not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") then
						if CheckNameBoss("Don Swan") then
							local v18 = CheckNameBoss("Don Swan")

							while true do
								task.wait()
								SizePart(v18)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								UsedualFlock()
								ClickM1(v18)
								if not (not v18 or not v18.Parent or v18.Humanoid.Health == 0) then
									continue
								end
								break
							end
						end
					elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
						if (localPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map.IndraIsland.Part.Position).Magnitude > 1000 then
							ToTarget(cframethangdaubuoiredhead)

							if (cframethangdaubuoiredhead.p - localPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
							end
						else
							local v18 = next
							local children, v19 = workspace.Enemies:GetChildren()

							for _, v20 in v18, children, v19 do
								if v20.Name == "rip_indra" and v20:FindFirstChild("HumanoidRootPart") and v20:FindFirstChild("Humanoid") and v20.Humanoid.Health > 0 then
									if localPlayer:DistanceFromCharacter(v20.HumanoidRootPart.Position) > 300 then
										ToTarget(v20.HumanoidRootPart.CFrame)
									else
										while true do
											task.wait()
											SizePart(v20)

											if Settings["Select Weapon"] == "Blox Fruit" then
												ToTarget(v20.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
											else
												ToTarget(v20.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
											end

											ClickM1(v20)
											UsedualFlock()
											if workspace.Enemies:FindFirstChild("rip_indra") then
												continue
											end
											break
										end
									end
								end
							end
						end
					end
				else
					AutoQuestBarito()
				end
			end
		end

		n2 = 0

		PathFindChest = function()
			local v18 = next
			local children, v19 = game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()

			for _, v20 in v18, children, v19 do
				if v20:IsA("Model") and v20:FindFirstChild("Part") and not v20:FindFirstChild("Ignored") then
					return v20
				end
			end
		end

		GetNearestChest = function()local n,L,U=next,game:GetService("CollectionService"):GetTagged("_ChestTagged");local w,y,S=1/0;for K,R in n,L,U do if not R:GetAttribute("IsDisabled")and not R:FindFirstChild("Ignored")then K= localPlayer :DistanceFromCharacter(R.Position);if K<w then w,y,S=K,i,R;end;end;end;return S;end
		getgenv().DetectRaidCastle = false
		getgenv().ValueCollectChestSpawnGod = 0

		task.spawn(function()
			while task.wait(0.15) do
				local ok, result = pcall(function()
					if Settings["Auto New World"] and not Place_Id.sea1() then
						SaveSettings("Auto New World", false)

						if v5 and v5.SetStage then
							v5:SetStage(false)
						end

						VxezeNotify("Auto New World", "Done, you are in Second Sea", "success", { Key = "newworlddone" })
					end

					if Settings["Auto Third World"] and not Place_Id.sea2() then
						SaveSettings("Auto Third World", false)

						if v6 and v6.SetStage then
							v6:SetStage(false)
						end

						VxezeNotify("Auto Third World", "Done, you are in Third Sea", "success", { Key = "thirdworlddone" })
					end

					if Settings["Auto New World"] then
						if Place_Id.sea1() and localPlayer.Data.Level.Value >= 700 then
							StackFarm = false
							StackFarmOther = false

							if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then
								if game.Workspace.Map.Ice.Door.CanCollide then
									if not localPlayer.Character:FindFirstChild("Key") and not localPlayer.Backpack:FindFirstChild("Key") then
										if TalkToNpc("Military Detective", "DressrosaQuestProgress", "Detective") then
											EquipTool("Key")
										end
									else
										EquipTool("Key")

										if localPlayer.Character:FindFirstChild("Key") then
											ToTarget(game.Workspace.Map.Ice.Door.CFrame)
										end
									end
								elseif CheckNameBoss("Ice Admiral") then
									local v18 = CheckNameBoss("Ice Admiral")

									while true do
										task.wait()
										SizePart(v18)

										if Settings["Select Weapon"] == "Blox Fruit" then
											ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
										else
											ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
										end

										ClickM1(v18)
										UsedualFlock()
										if not (not v18 or not v18.Parent or v18.Humanoid.Health == 0 or not Settings["Auto New World"]) then
											continue
										end
										break
									end
								end
							else
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
							end

							return
						end
					end

					if Settings["Collect Chest When Server Spawn Legend Items"] and getgenv().GoCollectChest then
						StackFarm = false
						StackFarmOther = false

						if getgenv().ValueCollectChestSpawnGod >= 10 then
							getgenv().GoCollectChest = false
							getgenv().ValueCollectChestSpawnGod = 0
						end

						local v18 = GetNearestChest()

						if v18 then
							getgenv().ValueCollectChestSpawnGod = getgenv().ValueCollectChestSpawnGod + 1
							local now = nil

							while true do
								task.wait()

								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v18.Position).Magnitude <= 5 then
									if not now then
										now = tick()
									elseif tick() - now >= 5 then
										Instance.new("IntValue", v18).Name = "Ignored"
										wait(0.1)
									end

									pcall(function()
										game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
									end)

									wait()

									pcall(function()
										game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
									end)

									TweenManager.CancelCurrent()
								end

								ToTarget(v18.CFrame, true)
								if not (not v18 or not v18.Parent or not Settings["Collect Chest When Server Spawn Legend Items"] or v18:GetAttribute("IsDisabled") or v18:FindFirstChild("Ignored") or not v18:FindFirstChild("TouchInterest")) then
									continue
								end
								break
							end

							return
						end

						local v19 = PathFindChest()

						if v19 then
							ToTarget(v19.Part.CFrame)

							if localPlayer:DistanceFromCharacter(v19.Part.Position) <= 100 or GetNearestChest() then
								Instance.new("IntValue", v19).Name = "Ignored"
							end
						else
							for _, child in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
								if child:FindFirstChild("Ignored") then
									child:FindFirstChild("Ignored"):Destroy()
								end
							end
						end
					end

					if Place_Id.sea2() and Settings["Auto Third World"] then
						if StopThirdSea() then
							StackFarm = false
							StackFarmOther = false
							SeaThird()
							return
						end
					end

					if Settings["Attack Darkbeard"] then
						local Darkbeard = CheckNameBoss("Darkbeard")

						if Darkbeard then
							StackFarm = false
							StackFarmOther = false

							while true do
								task.wait()
								SizePart(Darkbeard)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(Darkbeard.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(Darkbeard.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								ClickM1(Darkbeard)
								UsedualFlock()
								if not (not IsMobAlive(Darkbeard) or not Settings["Attack Darkbeard"]) then
									continue
								end
								break
							end

							return
						end

						if Settings["Summon Darkbeard"] and DetectItemPlr("Fist of Darkness") then
							StackFarm = false
							StackFarmOther = false
							local v18 = game
							local position = localPlayer.Character.HumanoidRootPart.Position

							if (v18:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.Position - position).Magnitude <= 5 then
								EquipTool("Fist of Darkness")
								firetouchinterest(game.Players.LocalPlayer.Character["Fist of Darkness"].Handle, game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection, 0)
								firetouchinterest(game.Players.LocalPlayer.Character["Fist of Darkness"].Handle, game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection, 1)
								firetouchinterest(localPlayer.Character.HumanoidRootPart, game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection, 0)
								firetouchinterest(localPlayer.Character.HumanoidRootPart, game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection, 1)
							else
								ToTarget(game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.CFrame)
							end

							return
						end

						spawn(function()
							if Settings["Hop Find Darkbeard"] then
								SpecialHop("Darkbeard")
							end
						end)
					end

					if Settings["Attack Rip Indra"] then
						local v18 = CheckNameBoss("rip_indra True Form")

						if v18 then
							StackFarm = false
							StackFarmOther = false

							while true do
								task.wait()
								SizePart(v18)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								ClickM1(v18)
								UsedualFlock()
								if not (not IsMobAlive(v18) or not Settings["Attack Rip Indra"]) then
									continue
								end
								break
							end

							return
						end
					end

					if Settings["Auto Touch Pad Haki"] and Settings["Auto Summon Rip Indra"] then
						if DetectItemPlr("God's Chalice") then
							StackFarm = false
							StackFarmOther = false
							if not game:GetService("Workspace").Map:FindFirstChild("Boat Castle") or not game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:FindFirstChildOfClass("Part") then
								ToTarget(CFrame.new(-5500, 314, -2855))
								return
							end

							if DetectButtons() then
								if TouchPadHaki() then
									SaveSettings("Auto Touch Pad Haki", false)

									if v9 and v9.SetStage then
										v9:SetStage(false)
									end

									VxezeNotify("Touch Pad Haki", "Done", "success", { Key = "hakidonerun" })
								end

								return
							end

							if not DetectButtons() then
								EquipTool("God's Chalice")
								ToTarget(game:GetService("Workspace").Map["Boat Castle"].Summoner.Detection.CFrame)
								return
							end
						end
					else
						if Settings["Auto Touch Pad Haki"] then
							StackFarm = false
							StackFarmOther = false
							if not game:GetService("Workspace").Map:FindFirstChild("Boat Castle") or not game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:FindFirstChildOfClass("Part") then
								ToTarget(CFrame.new(-5500, 314, -2855))
								return
							end

							if DetectButtons() then
								if TouchPadHaki() then
									SaveSettings("Auto Touch Pad Haki", false)

									if v9 and v9.SetStage then
										v9:SetStage(false)
									end

									VxezeNotify("Touch Pad Haki", "Done", "success", { Key = "hakidonerun" })
								end
							end

							return
						end

						if Settings["Auto Summon Rip Indra"] and DetectItemPlr("God's Chalice") then
							StackFarm = false
							StackFarmOther = false
							if not game:GetService("Workspace").Map:FindFirstChild("Boat Castle") or not game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:FindFirstChildOfClass("Part") then
								ToTarget(CFrame.new(-5500, 314, -2855))
								return
							end
							EquipTool("God's Chalice")
							ToTarget(game:GetService("Workspace").Map["Boat Castle"].Summoner.Detection.CFrame)
							return
						end
					end

					if Settings["Attack Soul Reaper"] then
						local v18 = CheckNameBoss("Soul Reaper")

						if v18 then
							StackFarm = false
							StackFarmOther = false

							while true do
								task.wait()
								SizePart(v18)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								ClickM1(v18)
								UsedualFlock()
								if not (not IsMobAlive(v18) or not Settings["Attack Soul Reaper"]) then
									continue
								end
								break
							end

							return
						end

						StackFarm = false
						StackFarmOther = false

						if Settings["Summon Soul Reaper"] and DetectItemPlr("Hallow Essence") then
							if not game:GetService("Workspace").Map:FindFirstChild("Haunted Castle") or not game:GetService("Workspace").Map["Haunted Castle"].Summoner:FindFirstChild("Detection") then
								local v19 = ToTarget
								local cframe = CFrame.new(-9513.466796875, 142.09776306152344, 5528.83740234375)
								v19(cframe)
								return
							end

							if (localPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position).Magnitude > 8 then
								ToTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
							else
								EquipTool("Hallow Essence", true)
							end

							return
						end
					end

					if Settings["Attack Dough King"] then
						local v18 = CheckNameBoss("Dough King")

						if v18 then
							StackFarm = false
							StackFarmOther = false

							while true do
								task.wait()
								SizePart(v18)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								ClickM1(v18)
								UsedualFlock()
								if not (not IsMobAlive(v18) or not Settings["Attack Dough King"]) then
									continue
								end
								break
							end

							return
						end

						spawn(function()
							if Settings["Hop Find Dough King"] then
								SpecialHop("Dough King")
							end
						end)

						if Settings["Summon Dough King"] then
							if not DetectItemPlr("Sweet Chalice") then
								if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc") == "Where are the items?" then
									if not CheckCountItem("Conjured Cocoa", 10) then
										StackFarm = false
										StackFarmOther = false

										if not DetectMob(tbl7) then
											if typeof(tbl7) == "table" then
												if #tbl7 <= #tbl5 then
													tbl5 = {}
													return
												end
												local v19 = DetectPartSpawnMob(DetectNameTablePart(tbl7))

												if v19 then
													table.insert(tbl5, DetectNameTablePart(tbl7))

													while true do
														wait()
														ToTarget(v19.CFrame * CFrame.new(0, 60, 0))
														if not ((v19.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 or DetectMob(tbl7) or not Settings["Attack Dough King"]) then
															continue
														end
														break
													end

													wait(1)
												end
											else
												local v19 = DetectPartSpawnMob(tbl7, true)

												if v19 then
													Instance.new("IntValue", v19).Name = "Ignored"

													while true do
														wait()
														ToTarget(v19.CFrame * CFrame.new(0, 60, 0))
														if not ((v19.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 or DetectMob(tbl7) or not Settings["Attack Dough King"]) then
															continue
														end
														break
													end

													wait(1)
												else
													DeleteIgnoredMobSpawn()
												end
											end
										else
											local v19 = DetectMob(tbl7)

											while true do
												task.wait()
												SizePart(v19)
												BringMob(v19)
												UsedualFlock()
												ClickM1(v19)

												if Settings["Select Weapon"] == "Blox Fruit" then
													ToTarget(v19.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
												else
													ToTarget(v19.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
												end

												if not (not v19 or not v19.Parent or v19.Humanoid.Health == 0 or not Settings["Attack Dough King"]) then
													continue
												end
												break
											end
										end
									elseif not DetectItemPlr("God's Chalice") then
										local v19 = DetectEliteHunter()

										if v19 then
											StackFarm = false
											StackFarmOther = false
											local name_ = v19.Name

											if not string.find(GetQuestTitle(), name_) or not HasQuest() then
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
											else
												while true do
													task.wait()
													SizePart(v19)

													if Settings["Select Weapon"] == "Blox Fruit" then
														ToTarget(v19.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
													else
														ToTarget(v19.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
													end

													ClickM1(v19)
													UsedualFlock()
													if not (not v19 or not v19.Parent or v19.Humanoid.Health == 0 or not Settings["Attack Dough King"]) then
														continue
													end
													break
												end
											end

											return
										end

										VxezeNotify("Elite Hunter", "Waiting Elite Hunter", "warning")
										wait(5)
									end
								end
							elseif not DetectMob(tbl6) then
								if typeof(tbl6) == "table" then
									if #tbl5 >= #tbl6 then
										tbl5 = {}
										return
									end
									local v19 = DetectPartSpawnMob(DetectNameTablePart(tbl6))

									if v19 then
										table.insert(tbl5, DetectNameTablePart(tbl6))

										while true do
											wait()
											ToTarget(v19.CFrame * CFrame.new(0, 60, 0))
											if not (localPlayer:DistanceFromCharacter(v19.Position) <= 100 or DetectMob(tbl6) or not Settings["Attack Dough King"]) then
												continue
											end
											break
										end

										wait(1)
									end
								else
									local v19 = DetectPartSpawnMob(tbl6, true)

									if v19 then
										Instance.new("IntValue", v19).Name = "Ignored"

										while true do
											wait()
											ToTarget(v19.CFrame * CFrame.new(0, 60, 0))
											if not (localPlayer:DistanceFromCharacter(v19.Position) <= 100 or DetectMob(tbl6) or not Settings["Attack Dough King"]) then
												continue
											end
											break
										end

										wait(1)
									else
										DeleteIgnoredMobSpawn()
									end
								end
							else
								local v19 = DetectMob(tbl6)

								while true do
									task.wait()
									SizePart(v19)
									BringMob(v19)
									UsedualFlock()
									ClickM1(v19)

									if Settings["Select Weapon"] == "Blox Fruit" then
										ToTarget(v19.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										ToTarget(v19.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end

									if not (not v19 or not v19.Parent or v19.Humanoid.Health == 0 or not Settings["Attack Dough King"]) then
										continue
									end
									break
								end
							end
						end
					end

					if Settings["Auto Elite Hunter"] then
						local v18 = DetectEliteHunter()

						if v18 then
							StackFarm = false
							StackFarmOther = false
							local name_ = v18.Name

							if not string.find(GetQuestTitle(), name_) or not HasQuest() then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
							else
								while true do
									task.wait()
									SizePart(v18)

									if Settings["Select Weapon"] == "Blox Fruit" then
										ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										ToTarget(v18.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end

									ClickM1(v18)
									UsedualFlock()
									if not (not IsMobAlive(v18) or not Settings["Auto Elite Hunter"]) then
										continue
									end
									break
								end

								if getgenv().QuestTrainer and getgenv().QuestTrainer.CountKillMob then
									getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
								end
							end

							return
						end

						if Settings["Hop Server Elite Hunter"] then
							if not DetectItemPlr("God's Chalice") then
								HopServer()
							else
								ToTarget(CFrame.new(-12463.8740234375, 374.91445922851562, -7523.77392578125))
							end
						end
					end

					if Settings["Auto Factory"] and not Place_Id.sea2() then
						SaveSettings("Auto Factory", false)

						if v7 and v7.SetStage then
							v7:SetStage(false)
						end

						VxezeNotify("Auto Factory", "Factory only exists in Sea 2, turning off", "warning", { Key = "factorysea" })
					end

					if Settings["Auto Factory"] then
						CoreBoss = CheckNameBoss("Core")

						if CoreBoss then
							StackFarm = false
							StackFarmOther = false

							while true do
								task.wait()
								ToTarget(CoreBoss.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
								ClickM1(CoreBoss)
								UsedualFlock()
								if not (not IsMobAlive(CoreBoss) or not Settings["Auto Factory"]) then
									continue
								end
								break
							end

							return
						end
					end

					if Settings["Auto Pirate Raid"] then
						local v18 = GetPirateRaid() or GetPirateRaid(true)

						if v18 then
							getgenv().DetectRaidCastle = true
							StackFarm = false
							StackFarmOther = false
							local cframe = Settings["Select Weapon"] == "Blox Fruit" and CFrame.new(-7, 20, 0) or CFrame.new(7, 20, 0)

							while true do
								task.wait()
								UsedualFlock()
								SizePart(v18)
								ClickM1(v18)
								ToTarget(v18.HumanoidRootPart.CFrame * cframe)
								if not (not IsMobAlive(v18) or not Settings["Auto Pirate Raid"]) then
									continue
								end
								break
							end
						elseif getgenv().DetectRaidCastle then
							StackFarm = false
							StackFarmOther = false
							local now = os.clock()
							local flag = false

							while true do
								task.wait()

								if GetPirateRaid() or GetPirateRaid(true) then
									flag = true
								end

								if not (os.clock() - now >= 10 or flag) then
									continue
								end
								break
							end

							if not flag then
								getgenv().DetectRaidCastle = false
							end
						end
					end

					if Settings["Auto Collect Fruits"] then
						local v18 = GetPathFruit()

						if v18 then
							StackFarm = false
							StackFarmOther = false

							if (v18.Handle.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
								getgenv().noclip = false

								pcall(function()
									game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
								end)

								wait()

								pcall(function()
									game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
								end)
							else
								ToTarget(v18.Handle.CFrame, true)
							end

							return
						end

						if Settings["Hop Find Fruits / Berries / Chests"] then
							HopServer()
							wait(5)
						end
					end

					if not StackFarm then
						StackFarm = true
					end

					if not StackFarmOther then
						StackFarmOther = true
					end
				end)

				if result then
					PrintOnce(result)
				end
			end
		end)
	end

	FarmotherMain = Main.CreatePage({ Page_Name = "Farming Other", Page_Title = "Farming Other" })
	HiddenEventSection = FarmotherMain.CreateSection("Secret Quest")
	StatusHiddenProgress = HiddenEventSection.CreateLabel({ Title = "Secret Quest : 0/39 Quests" })
	StatusHiddenQuest = HiddenEventSection.CreateLabel({ Title = "Title Quest : ..." })
	StatusHiddenStep = HiddenEventSection.CreateLabel({ Title = "Doing Quest : None" })
	StatusHiddenBoss = HiddenEventSection.CreateLabel({ Title = "Title Awakened Boss : None" })

	HiddenEvent = {
		progress = {},
		checked = 0,
		current = nil,
		step = "Idle",
		handlers = {},
		skipped = {},
		lastNotify = {},
	}

	GetHiddenProgress = function(arg)
		local flag

		if arg then
			flag = arg
		else
			local checked = HiddenEvent.checked
			flag = os.clock() - checked > 15
		end

		if flag then
			HiddenEvent.checked = os.clock()

			local ok, result = pcall(function()
				return ReplicatedStorage.Modules.Net["RF/RequestBonusMomentReplication"]:InvokeServer({ Type = "GetMomentProgress" })
			end)

			if ok and type(result) == "table" and type(result.Data) == "table" then
				ReportHiddenDone(HiddenEvent.progress, result.Data)
				HiddenEvent.progress = result.Data
			end
		end

		return HiddenEvent.progress
	end

	ReportHiddenDone = function(arg, arg2)
		local done = 0

		for k, v6 in pairs(arg2) do
			if type(v6) == "table" and v6.Completed then
				done += 1
				local flag = type(arg) == "table" and arg[k]

				if type(flag) == "table" and not flag.Completed then
					HiddenNotify((tostring(k):match("([^/]+)$") or tostring(k)) .. " completed", "done" .. tostring(k), "reward", { SubContent = done .. "/39 secret quests", Duration = 8 })
				end
			end
		end

		HiddenEvent.done = done
	end

	HiddenNotify = function(arg, key, arg2, arg3)
		key = key or arg
		if os.clock() - (HiddenEvent.lastNotify[key] or 0) < 20 then
			return
		end
		HiddenEvent.lastNotify[key] = os.clock()
		local tbl9 = arg3 or {}
		tbl9.Key = key
		VxezeNotify("Hidden Event", arg, arg2 or "info", tbl9)
	end

	SetHiddenStep = function(step)
		if step ~= HiddenEvent.step then
			local stepShape = tostring(step):gsub("%d+", "#")

			if stepShape ~= HiddenEvent.stepShape then
				HiddenEvent.stepShape = stepShape
				VxezeLog("Hidden", step)
			end
		end

		HiddenEvent.step = step
	end

	HiddenModules = setmetatable({}, { __index = function(arg, arg2)
		local handlers = {
			Controller = function()
				return require(ReplicatedStorage.Controllers.BonusMomentsController)
			end,
			Guide = function()
				return require(ReplicatedStorage.BonusMomentsGuide)
			end,
			Map = function()
				return require(ReplicatedStorage.Definitions.Map)
			end,
			NpcList = function()
				return require(ReplicatedStorage.NPCManager.NPCList)
			end,
			Dialogues = function()
				return require(ReplicatedStorage.DialoguesList)
			end,
			RegisterAttack = function()
				return ReplicatedStorage.Modules.Net:WaitForChild("RE/RegisterAttack")
			end,
			RegisterHit = function()
				return require(ReplicatedStorage.Modules.Net):RemoteEvent("RegisterHit", true)
			end,
		}

		local v6 = handlers[arg2] and handlers[arg2]()
		rawset(arg, arg2, v6)
		return v6
	end })

	GetHiddenIsland = function(arg)
		HiddenEvent.islands = HiddenEvent.islands or {}

		if HiddenEvent.islands[arg] == nil then
			local v6 = HiddenModules.Map.findCurrentMap()
			local v7 = pairs
			local islands = v6 and v6.Islands or {}

			for _, island in v7(islands) do
				if island.Index.Key == arg then
					HiddenEvent.islands[arg] = island
				end
			end
		end

		return HiddenEvent.islands[arg]
	end

	GetHiddenMoment = function(arg)
		return HiddenModules.Controller:GetLoadedMoments()[arg]
	end

	HiddenRelease = function()
		local anchored = HiddenEvent.anchored

		if anchored and anchored.Parent then
			anchored.Anchored = false
		end

		HiddenEvent.anchored = nil
	end

	HiddenMove = function(arg)
		HiddenRelease()

		if Settings["Auto Secret Quest"] then
			ToTarget(arg)
		end
	end

	HiddenGoTo = function(arg, arg2)
		if localPlayer:DistanceFromCharacter(arg) <= (arg2 or 8) then
			return true
		end
		HiddenMove(CFrame.new(arg))
		return false
	end

	HiddenGoToIsland = function(arg)
		local v6 = GetHiddenIsland(arg)
		if not v6 then
			return
		end
		SetHiddenStep("Travel to " .. arg)
		local position = v6.TeleportPoints[1].Position
		local v7 = nil

		for _, child in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
			if child.Name == v6.Reference.Location then
				local magnitude = (child.Position - v6.World.Position).Magnitude

				if not v7 or magnitude < v7 then
					position = child.Position
					v7 = magnitude
				end
			end
		end

		return HiddenGoTo(position + Vector3.new(0, 30, 0), 150)
	end

	HiddenHold = function(arg)
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end

		if (humanoidRootPart.Position - arg.Position).Magnitude > 3 then
			HiddenMove(arg)
			return
		end

		if HiddenEvent.anchored ~= humanoidRootPart then
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.Anchored = true
			HiddenEvent.anchored = humanoidRootPart
		end

		HiddenEvent.holdTime = tick()
		TweenHoldUntil = tick() + 1
	end

	SweepHiddenTrigger = function(arg, arg2, arg3)
		HiddenRelease()
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoidRootPart or not character then
			return
		end
		HiddenEvent.walking = true
		local floatForce = humanoidRootPart:FindFirstChild("FloatForce")
		local maxForce = floatForce and floatForce.MaxForce

		if floatForce then
			floatForce.MaxForce = Vector3.zero
		end

		for k in pairs(NoclipChanged) do
			if k.Parent then
				k.CanCollide = true
			end
		end

		table.clear(NoclipChanged)
		humanoidRootPart.CFrame = CFrame.new(arg2)
		humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		task.wait(0.4)
		character:MoveTo(arg3)
		local now = tick()

		while true do
			task.wait(0.1)
			tbl3.LastCall = tick()
			TweenHoldUntil = tick() + 1
			if not ((humanoidRootPart.Position - arg3).Magnitude < 6 or tick() - now > 6 or not humanoidRootPart.Parent) then
				continue
			end
			break
		end

		if floatForce and floatForce.Parent then
			floatForce.MaxForce = maxForce
		end

		HiddenEvent.walking = false
	end

	HiddenDialoguePriority = {
		"not this time",
		"help hasan",
		"return the hat",
		"you're welcome",
		"hand over",
		"claim",
		"reward",
		"i'll get it",
		"accept",
		"let's go",
		"start",
		"yes",
		"sure",
		"okay",
		"go on",
		"continue",
		"so go get it back",
	}

	HiddenDialogueAvoid = {
		"walk away",
		"leave",
		"nevermind",
		"never mind",
		"not now",
		"maybe later",
		"no thanks",
		"no, ",
		"cancel",
		"skip",
		"bye",
		"goodbye",
		"forget it",
		"i'll pass",
		"decline",
		"quit",
		"exit",
		"stop",
	}

	PickHiddenDialogue = function(arg)
		local DialogueController = require(ReplicatedStorage.DialogueController)
		if not DialogueController.Active then
			return false
		end
		local ok, result = pcall(DialogueController.getActiveDialogue)
		ok = ok and result and result._pageStack and result._pageStack[#result._pageStack]
		if not ok then
			return false
		end
		local options2 = ok._options or {}
		if #options2 == 0 then
			pcall(DialogueController.advance)
			return false
		end
		local v6 = ipairs
		arg = arg or {}

		for _, v7 in v6(arg) do
			for _, v8 in ipairs(options2) do
				if string.find(string.lower(type(v8._text) == "table" and table.concat(v8._text, " ") or tostring(v8._text)), string.lower(v7), 1, true) then
					pcall(DialogueController.select, v8)
					return true
				end
			end
		end

		return false
	end

	AutoHiddenDialogue = function()
		if tick() < (HiddenEvent.talking or 0) then
			HiddenEvent.strayDialogue = nil
			return
		end

		if PickHiddenDialogue(HiddenDialoguePriority) then
			HiddenEvent.strayDialogue = nil
			return
		end
		local DialogueController = require(ReplicatedStorage.DialogueController)
		local ok, result = pcall(DialogueController.getActiveDialogue)
		local pageStack = DialogueController.Active and ok and result and result._pageStack and result._pageStack[#result._pageStack]

		if pageStack then
			pageStack = #(pageStack._options or {}) > 0
		end

		if pageStack then
			pageStack = tick() > (HiddenEvent.dialogueBusy or 0)
		end

		if pageStack then
			HiddenEvent.strayDialogue = HiddenEvent.strayDialogue or tick()
			local strayDialogue = HiddenEvent.strayDialogue

			if tick() - strayDialogue > 1.5 then
				HiddenEvent.strayDialogue = nil
				pcall(DialogueController.close)
			end
		else
			HiddenEvent.strayDialogue = nil
		end
	end

	HiddenDialogueLoop = function()
		while Settings["Auto Secret Quest"] do
			pcall(AutoHiddenDialogue)
			task.wait(0.4)
		end
	end

	HiddenMaterialMobs = {
		["Yeti Fur"] = { mobs = { "Snow Bandit", "Snowman" }, center = Vector3.new(1350, 60, -1300) },
		Leather = { mobs = { "Brute", "Pirate" }, center = Vector3.new(-1436, 28, 4357) },
		["Scrap Metal"] = { mobs = { "Brute", "Pirate" }, center = Vector3.new(-1436, 28, 4357) },
		["Magma Ore"] = { mobs = { "Military Soldier", "Military Spy" }, center = Vector3.new(-5300, 20, 8500) },
		["Angel Wings"] = { mobs = { "Royal Soldier", "Royal Squad" }, center = Vector3.new(-7030, 5545, 1120) },
		["Fish Tail"] = { mobs = { "Fishman Warrior", "Fishman Commando" }, center = Vector3.new(61000, 23, 1300) },
	}

	CountHiddenMaterial = function(arg)
		local v6, v7, v8 = ipairs(GetInventoryItems() or {})
		local n = 0

		for _, v9 in v6, v7, v8 do
			if tostring(v9.Name) == arg then
				n = tonumber(v9.Count) or tonumber(v9.Amount) or 1
			end
		end

		return n
	end

	FarmHiddenMaterial = function(arg, arg2)
		local v6 = HiddenMaterialMobs[arg]
		if not v6 then
			return
		end
		arg2 = arg2 or 1
		local now = tick()
		local now2 = tick()
		local str2

		while true do
			local v7 = FindHiddenEnemy(v6.mobs, v6.center, 1500)

			if not v7 then
				HiddenGoTo(v6.center, 120)
				str2 = "Look for " .. v6.mobs[1] .. " to farm " .. arg
				task.wait(0.2)
			else
				str2 = "Farm " .. arg .. " from " .. v7.Name
				HiddenEvent.stallGrace = tick() + 20
				SizePart(v7)
				BringMob(v7)
				UsedualFlock()
				HiddenMove(GetHiddenFarmCFrame(v7))
				getgenv().ClickM1(v7, true)
				task.wait()
			end

			local flag

			if tick() - now2 > 4 then
				local now3 = tick()

				if not (arg2 <= CountHiddenMaterial(arg)) then
					now2 = now3
					flag = tick() - now > 45 or not Settings["Auto Secret Quest"]

					if flag then
						break
					else
						continue
					end
				end
			else
				flag = tick() - now > 45 or not Settings["Auto Secret Quest"]

				if flag then
					break
				else
					continue
				end
			end

			break
		end

		return str2
	end

	FindHiddenWaterSpot = function()
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local GetWaterHeightAtLocation = require(ReplicatedStorage.Util.GetWaterHeightAtLocation)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { localPlayer.Character, workspace.Characters, workspace.Enemies }

		local function fn(arg)
			local ok, result = pcall(GetWaterHeightAtLocation, arg)
			return ok and tonumber(result)
		end

		local function fn2(arg, arg2)
			local hit = workspace:Raycast(Vector3.new(arg.X, arg2 + 200, arg.Z), Vector3.new(0, -500, 0), raycastParams)
			return hit and hit.Position or nil
		end

		for i_ = 15, 400, 15 do
			for i_2 = 0, 11 do
				local v6 = math.rad(i_2 * 30)
				local sin = math.sin
				local vector = Vector3.new(math.cos(v6), 0, sin(v6))
				local n = humanoidRootPart.Position + vector * i_
				local v7 = fn(n)

				if v7 then
					local v8 = fn2(n, v7)

					if v8 and v8.Y >= v7 - 1 then
						local n3 = n + vector * 14
						local v9 = fn(n3)
						local v10 = v9 and fn2(n3, v9)
						if v9 and (not v10 or v10.Y < v9 - 2) then
							return Vector3.new(v8.X, v8.Y + 3, v8.Z), Vector3.new(n3.X, v9, n3.Z)
						end
					end
				end
			end
		end
	end

	TalkFishermanDialogue = function(arg, arg2, arg3)
		local DialogueController = require(ReplicatedStorage.DialogueController)
		HiddenEvent.dialogueBusy = tick() + (arg3 or 20) + 4
		pcall(DialogueController.close)
		task.wait(0.4)
		local fisherman = HiddenModules.NpcList.List.Fisherman
		if not fisherman then
			return false
		end
		local ok, result = pcall(fisherman.DialogueCallback)
		if not ok or not result then
			return false
		end
		task.spawn(pcall, DialogueController.start, result)
		local now = tick()
		local n = 1

		while true do
			task.wait(0.4)
			local ok2, result2 = pcall(DialogueController.getActiveDialogue)
			local pageStack = ok2 and result2 and result2._pageStack and result2._pageStack[#result2._pageStack]

			if pageStack then
				local options2 = pageStack._options or {}

				if #options2 == 0 then
					pcall(DialogueController.advance)
				else
					local v6 = nil

					for _, v7 in ipairs(options2) do
						local v8 = string.lower(type(v7._text) == "table" and table.concat(v7._text, " ") or tostring(v7._text))
						local v9 = ipairs
						local tbl9 = arg or {}

						for _, v10 in v9(tbl9) do
							if not v6 and string.find(v8, string.lower(v10), 1, true) then
								v6 = v7
							end
						end
					end

					pcall(DialogueController.select, v6 or options2[1])
					n += 1
				end
			end

			local flag = arg2 and arg2() or n > 6

			if not flag then
				flag = tick() - now > (arg3 or 15)
			end

			if not flag then
				continue
			end
			break
		end

		task.wait(0.5)
		pcall(DialogueController.close)
		return arg2 and arg2() or true
	end

	GoToFisherman = function()
		local fisherman = workspace.NPCs:FindFirstChild("Fisherman")
		fisherman = fisherman and fisherman:GetPivot().Position or Vector3.new(1065, 6, -1083)
		if localPlayer:DistanceFromCharacter(fisherman) <= 12 then
			return true
		end

		if Settings["Auto Secret Quest"] then
			return HiddenSettle(fisherman + Vector3.new(0, 1.5, 4), 10)
		end
		ToTarget(CFrame.new(fisherman + Vector3.new(0, 1.5, 4)))
		return false
	end

	CountFishingBait = function(arg)
		local v6 = ipairs
		local tbl9 = GetInventoryItems() or {}

		for _, v7 in v6(tbl9) do
			if tostring(v7.Name) == arg then
				return tonumber(v7.Count) or tonumber(v7.Amount) or 1
			end
		end

		return 0
	end

	BuyHiddenFishingGear = function(arg)
		local selectBait = arg or Settings["Select Bait"] or "Basic Bait"
		if DetectRod() and CountFishingBait(selectBait) > 0 then
			return true
		end

		if not GoToFisherman() then
			return false
		end

		if tick() - (HiddenEvent.rodAsked or 0) < 20 then
			return DetectRod() ~= nil
		end
		HiddenEvent.rodAsked = tick()

		if not DetectRod() then
			TalkFishermanDialogue({ "Thanks" }, function()
				return DetectRod() ~= nil
			end, 15)
		end

		if DetectRod() and CountFishingBait(selectBait) <= 0 then
			local v6 = CountFishingBait(selectBait)

			TalkFishermanDialogue({ "Bait", selectBait, "Craft", "Buy", "Confirm", "Yes" }, function()
				return CountFishingBait(selectBait) > v6
			end, 20)
		end

		return DetectRod() ~= nil
	end

	RunHiddenFishing = function()
		if not DetectRod() then
			if not BuyHiddenFishingGear() then
				HiddenNotify("Getting a Fishing Rod from the Fisherman for Chef's Kiss", "chefrod", "start")
				return "Get a Fishing Rod from the Fisherman"
			end
			DetectRod()
		end

		local selectBait = Settings["Select Bait"] or "Basic Bait"
		local fishingData = localPlayer.Data:FindFirstChild("FishingData")
		fishingData = fishingData and fishingData:GetAttribute("SelectedBait")

		if not fishingData or fishingData == "None" then
			if CountFishingBait(selectBait) > 0 then
				CommF:InvokeServer("LoadItem", selectBait, { "Usables" })
				task.wait(0.5)
			elseif not BuyHiddenFishingGear(selectBait) then
				return "Buy fishing bait from the Fisherman"
			end
		end

		local fishSpot = HiddenEvent.fishSpot

		if fishSpot then
			fishSpot = tick() - (HiddenEvent.fishSpotAt or 0) > 120
		end

		if fishSpot then
			HiddenEvent.fishSpot = nil
		end

		if not HiddenEvent.fishSpot then
			local v6 = HiddenEvent
			local v7 = HiddenEvent
			local v8, v9 = FindHiddenWaterSpot()
			v6.fishSpot = v8
			v7.fishWater = v9
			HiddenEvent.fishSpotAt = tick()
		end

		local fishSpot2 = HiddenEvent.fishSpot
		if not fishSpot2 then
			return "Looking for a shore to fish from"
		end

		if localPlayer:DistanceFromCharacter(fishSpot2) > 10 then
			HiddenMove(CFrame.new(fishSpot2, HiddenEvent.fishWater or fishSpot2 + Vector3.new(0, 0, 5)))
			return "Go to the shore to fish"
		end
		HiddenHold(CFrame.new(fishSpot2, HiddenEvent.fishWater or fishSpot2 + Vector3.new(0, 0, 5)))
		pcall(RunFishingCycle)
		task.wait(0.4)
		return "Fishing at the shore for Chef's Kiss"
	end

	GetHiddenFishCount = function()
		local tbl9 = {}

		for _, child in ipairs(ReplicatedStorage.FishReplicated.FishData:GetChildren()) do
			tbl9[child.Name] = true
		end

		local v6, v7, v8 = ipairs(GetInventoryItems() or {})
		local n = 0

		for _, v9 in v6, v7, v8 do
			if tbl9[tostring(v9.Name)] then
				n += tonumber(v9.Count) or 1
			end
		end

		return n
	end

	PrepareHiddenChef = function(arg)
		if arg["Sea1/Pirate Village/Chef's Kiss"] == true then
			return
		end

		if CountHiddenMaterial("Yeti Fur") < 1 then
			HiddenEvent.current = "Chef's Kiss"
			HiddenEvent.prepUntil = tick() + 60
			SetHiddenStep(FarmHiddenMaterial("Yeti Fur", 1) or "Farm Yeti Fur for Chef's Kiss")
			return true
		end

		if GetHiddenFishCount() < 1 then
			HiddenEvent.current = "Chef's Kiss"
			HiddenEvent.prepUntil = tick() + 60
			SetHiddenStep(RunHiddenFishing() or "Fishing for Chef's Kiss")
			return true
		end

		HiddenEvent.prepUntil = nil
	end

	GatherChefIngredients = function()
		local text = HiddenEvent.chefMissing and HiddenEvent.chefMissing.text or ""
		local v6 = string.lower(text)

		for k in pairs(HiddenMaterialMobs) do
			if string.find(text, k, 1, true) and CountHiddenMaterial(k) < 1 then
				local v7 = FarmHiddenMaterial(k)
				if v7 then
					return v7
				end
			end
		end

		local flag = string.find(v6, "fish", 1, true) ~= nil

		if not flag then
			for _, child in ipairs(ReplicatedStorage.FishReplicated.FishData:GetChildren()) do
				if string.find(text, child.Name, 1, true) then
					flag = true
					break
				end
			end
		end

		if flag then
			local v7 = RunHiddenFishing()
			if v7 then
				return v7
			end
		end

		if string.find(v6, "material", 1, true) or string.find(v6, "ingredient", 1, true) then
			for k in pairs(HiddenMaterialMobs) do
				if CountHiddenMaterial(k) > 0 then
					return
				end
			end

			local v7 = FarmHiddenMaterial("Yeti Fur", 1)
			if v7 then
				return v7
			end
		end
	end

	ResetHiddenMomentFlag = function(arg, arg2, arg3)
		for _, v6 in pairs(getgc()) do
			if type(v6) == "function" and islclosure(v6) and debug.info(v6, "n") == arg2 and string.find(tostring(debug.info(v6, "s")), arg, 1, true) then
				local ok, result = pcall(debug.getupvalues, v6)

				if ok and type(result[arg3]) == "boolean" then
					pcall(debug.setupvalue, v6, arg3, false)
				end
			end
		end
	end

	TalkHiddenQuestNpc = function(arg, arg2)
		pcall(function()
			local v6 = HiddenModules.NpcList.List[arg].DialogueCallback()

			if type(v6) == "table" and type(v6.Get) == "function" then
				v6:Get()
			end
		end)

		task.wait(0.6)
		local v6 = GetHiddenDialogueKey(arg)

		if v6 then
			pcall(HiddenModules.Guide.interactQuestGiver, v6)
		end

		return RunHiddenDialogue(arg2, 10)
	end

	RunHiddenDialogue = function(arg, arg2)
		local DialogueController = require(ReplicatedStorage.DialogueController)
		local now = tick()
		HiddenEvent.dialogueBusy = tick() + (arg2 or 12) + 2
		local flag = false

		while true do
			task.wait(0.3)
			HiddenEvent.stallGrace = tick() + 20

			if PickHiddenDialogue(arg) then
				flag = true
			end

			local flag2 = flag and not DialogueController.Active

			if not flag2 then
				flag2 = tick() - now > (arg2 or 12)
			end

			if not flag2 then
				continue
			end
			break
		end

		if flag and DialogueController.Active then
			task.wait(1)
			pcall(DialogueController.close)
		end

		return flag
	end

	HiddenSettle = function(arg, arg2)
		if not HiddenGoTo(arg, arg2) then
			HiddenEvent.arrived = nil
			return false
		end
		HiddenHold(CFrame.new(arg))
		HiddenEvent.arrived = HiddenEvent.arrived or tick()

		if not game:GetService("CollectionService"):HasTag(localPlayer, "Teleporting") then
			HiddenEvent.teleportTag = nil
		else
			HiddenEvent.teleportTag = HiddenEvent.teleportTag or tick()
		end

		local arrived = HiddenEvent.arrived
		local flag = tick() - arrived > 1.5

		if flag then
			flag = not HiddenEvent.teleportTag

			if not flag then
				local teleportTag = HiddenEvent.teleportTag
				flag = tick() - teleportTag > 6
			end
		end

		return flag
	end

	ListenHiddenMoment = function(arg, arg2)
		return ReplicatedStorage.Remotes.BonusMomentsRemoteEvent.OnClientEvent:Connect(function(arg3, arg4, ...)
			if arg3 == arg then
				arg2(arg4, ...)
			end
		end)
	end

	HitHiddenPart = function(arg)
		if localPlayer:DistanceFromCharacter(arg.Position) > 12 then
			HiddenMove(arg.CFrame * CFrame.new(0, 0, 6))
			return
		end
		HiddenHold(localPlayer.Character.HumanoidRootPart.CFrame)
		EquipHiddenWeapon("Melee")

		if os.clock() - (HiddenEvent.lastHit or 0) >= 0.4 then
			HiddenEvent.lastHit = os.clock()
			HiddenModules.RegisterAttack:FireServer(0.3)
			HiddenModules.RegisterHit:FireServer(arg)
		end
	end

	IsHiddenEnemyMine = function(arg)
		local attribute = arg:GetAttribute("LocalEnemy")
		if attribute and attribute ~= localPlayer.Name then
			return false
		end
		local num = tonumber(arg:GetAttribute("BossEngagedWith"))
		if num and num ~= localPlayer.UserId and not arg:GetAttribute("BossIndicatorAwakened") then
			return false
		end
		return true
	end

	IsHiddenTarget = function(arg)
		local humanoid = arg and arg.Parent and arg:FindFirstChildWhichIsA("Humanoid")
		return humanoid ~= nil and humanoid.Health > 0 and arg:FindFirstChild("HumanoidRootPart") ~= nil and IsHiddenEnemyMine(arg)
	end

	FindHiddenEnemyNear = function(arg, arg2)
		local huge = math.huge
		local v6 = nil

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if IsHiddenTarget(child) and (child:GetPivot().Position - arg).Magnitude <= arg2 then
				local v7 = localPlayer:DistanceFromCharacter(child:GetPivot().Position)

				if v7 < huge then
					huge = v7
					v6 = child
				end
			end
		end

		return v6
	end

	FindHiddenEnemy = function(arg, arg2, arg3)
		local huge = math.huge
		local v6 = nil

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if table.find(arg, child.Name) and IsHiddenTarget(child) and (child:GetPivot().Position - arg2).Magnitude <= arg3 then
				local v7 = localPlayer:DistanceFromCharacter(child:GetPivot().Position)

				if v7 < huge then
					huge = v7
					v6 = child
				end
			end
		end

		return v6
	end

	HiddenDodge = { untilTime = 0, target = nil, animations = {}, connection = nil, watching = false }
	IsHiddenDodging = function()return HiddenDodge.target~=nil and tick()<HiddenDodge.untilTime;end
	TriggerHiddenDodge = function(c)if HiddenDodge.target then HiddenDodge.untilTime=math.max(HiddenDodge.untilTime,tick()+math.clamp(c,0.3,8));end;end

	IsHiddenBoss = function(arg)
		if arg:GetAttribute("BossIndicatorAwakened") then
			return true
		end
		local v6 = ipairs
		local tbl9 = HiddenQuests or {}

		for _, v7 in v6(tbl9) do
			if v7.BossNames and table.find(v7.BossNames, arg.Name) then
				return true
			end
		end

		return false
	end

	OnHiddenEnemyAnimation = function(c)if c.Looped then return;end;local n,L=c.Animation and c.Animation.AnimationId or"",tick();local U=HiddenDodge.animations[n];if not U or L-U.since>20 then U={count=0,since=L};HiddenDodge.animations[n]=U;end;U.count=U.count+1;if U.count>4 then return;end;task.wait(0.05);if c.IsPlaying and c.Length>=0.9 then TriggerHiddenDodge(c.Length/math.max(c.Speed,0.1)+0.3);end;end
	OnHiddenEnemySkill = function(n)if not HiddenDodge.target then return;end;if not n:IsA("BodyGyro")and not n:IsA("BodyPosition")and not string.find(n.Name,"KiBlast",1,true)then return;end;local L=n.Parent;while L and L.Parent~=workspace.Enemies do L=L.Parent;end;local U=L and(L:FindFirstChild("HumanoidRootPart"));if not U or L~=HiddenDodge.target and  localPlayer :DistanceFromCharacter(U.Position)>70 then return;end;L=tick();TriggerHiddenDodge(1);while n.Parent and HiddenDodge.target and tick()-L<8 do TriggerHiddenDodge(0.5);task.wait(0.2);end;end

	WatchHiddenEnemy = function(target)
		if HiddenDodge.target == target then
			return
		end
		StopHiddenDodge()
		HiddenDodge.target = target
		local humanoid = target:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid = humanoid:FindFirstChildOfClass("Animator") or humanoid
		end

		if humanoid then
			HiddenDodge.connection = humanoid.AnimationPlayed:Connect(OnHiddenEnemyAnimation)
		end

		if not HiddenDodge.watching then
			HiddenDodge.watching = true
			workspace.Enemies.DescendantAdded:Connect(OnHiddenEnemySkill)
		end
	end

	StopHiddenDodge = function()
		if HiddenDodge.connection then
			HiddenDodge.connection:Disconnect()
			HiddenDodge.connection = nil
		end

		table.clear(HiddenDodge.animations)
		HiddenDodge.target = nil
		HiddenDodge.untilTime = 0
	end

	GetHiddenFarmCFrame = function(c)local n,L=c.HumanoidRootPart,Settings["Select Weapon"]=="Blox Fruit";local U=HiddenEvent.farmHeight or L and(getgenv().YPosFruit or 20)or 20;return n.CFrame*CFrame.new(L and-7 or 7,if IsHiddenDodging()then U+(IsHiddenBoss(c)and 40 or 25)else U,0);end

	KillHiddenEnemy = function(fighting)
		local now = tick()
		local v6 = IsHiddenBoss(fighting)
		local n = v6 and 180 or 45
		HiddenEvent.fighting = fighting
		WatchHiddenEnemy(fighting)

		while true do
			task.wait()

			if not fighting:FindFirstChild("HumanoidRootPart") then
				break
			else
				SizePart(fighting)

				if not v6 then
					BringMob(fighting)
				end

				UsedualFlock()
				local humanoidRootPart = fighting:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					local cFrame = humanoidRootPart.CFrame
					getgenv().AimPos = cFrame
				end

				HiddenMove(GetHiddenFarmCFrame(fighting))
				getgenv().ClickM1(fighting, true)
				if not (not IsHiddenTarget(fighting) or not Settings["Auto Secret Quest"] or tick() - now > n) then
					continue
				end
				break
			end
		end

		HiddenEvent.fighting = nil
		StopHiddenDodge()
	end

	GetHiddenDialogueKey = function(arg)
		local v6 = HiddenModules.NpcList.List[arg]
		local tbl9 = {}
		local fn = nil

		fn = function(arg2, arg3)
			if type(arg2) ~= "function" or tbl9[arg2] or arg3 > 3 then
				return nil
			end
			tbl9[arg2] = true
			local ok, result = pcall(debug.getconstants, arg2)
			local v7 = ipairs
			local tbl10 = ok and result or {}

			for _, v8 in v7(tbl10) do
				if type(v8) == "string" and rawget(HiddenModules.Dialogues, v8) ~= nil then
					return v8
				end
			end

			local ok2, result2 = pcall(debug.getupvalues, arg2)
			local v8 = pairs
			result2 = ok2 and result2 or {}

			for _, v9 in v8(result2) do
				local flag = fn(v9, arg3 + 1) or type(v9) == "table" and fn(rawget(v9, "original"), arg3 + 1)
				if flag then
					return flag
				end
			end
		end

		return fn(v6 and v6.DialogueCallback, 0)
	end

	FindHiddenNpc = function(arg, arg2)
		for _, v6 in ipairs({ workspace.NPCs, ReplicatedStorage.NPCs }) do
			for _, child in ipairs(v6:GetChildren()) do
				if child:IsA("Model") and (child:GetPivot().Position - arg).Magnitude <= arg2 then
					return child
				end
			end
		end
	end

	ClaimHiddenReward = function()
		local v6 = HiddenModules.Guide.getRewardTracker()
		local target = v6 and v6.Options and v6.Options.Target
		HiddenEvent.rewardSeen = HiddenEvent.rewardSeen or {}

		if typeof(target) == "Vector3" then
			HiddenEvent.rewardSeen[tostring(target)] = { position = target, time = tick() }
		end

		local rewardLock = HiddenEvent.rewardLock
		local v7 = rewardLock and HiddenEvent.rewardSeen[tostring(rewardLock)]
		local flag = not v7
		local flag2

		if flag then
			flag2 = flag
		else
			local time_ = v7.time
			flag2 = tick() - time_ > 8
		end

		if not flag2 then
			flag2 = tick() < (HiddenEvent.skipped["Reward:" .. tostring(rewardLock)] or 0)
		end

		if flag2 then
			local v8 = nil
			rewardLock = nil

			for k, v9 in pairs(HiddenEvent.rewardSeen) do
				local v10 = localPlayer:DistanceFromCharacter(v9.position)
				local time_ = v9.time
				local flag3 = tick() - time_ <= 8

				if flag3 then
					flag3 = tick() >= (HiddenEvent.skipped["Reward:" .. k] or 0)
				end

				if flag3 and (not v8 or v10 < v8) then
					rewardLock = v9.position
					v8 = v10
				end
			end

			HiddenEvent.rewardLock = rewardLock
		end

		if typeof(rewardLock) ~= "Vector3" then
			return false
		end
		local reward = tostring(rewardLock)
		local v8 = FindHiddenNpc(rewardLock, 15)
		HiddenEvent.current = "Claim Reward"
		SetHiddenStep("Talk to " .. (v8 and v8.Name or "the quest giver") .. " for reward")
		if not v8 then
			HiddenGoTo(rewardLock + Vector3.new(0, 5, 0), 20)
			return true
		end

		if HiddenSettle(rewardLock + Vector3.new(0, 1.5, 4), 10) then
			HiddenEvent.dialogueBusy = tick() + 12

			pcall(function()
				local v9 = HiddenModules.NpcList.List[v8.Name].DialogueCallback()

				if type(v9) == "table" and type(v9.Get) == "function" then
					v9:Get()
				end
			end)

			task.wait(1)
			local v9 = HiddenModules.Guide.getRewardTracker()
			local v10 = GetHiddenDialogueKey(v8.Name)

			if v10 and v9 and v9.Options and v9.Options.Target == rewardLock then
				HiddenModules.Guide.interactQuestGiver(v10)
			end

			HiddenEvent.checked = 0
			HiddenEvent.rewardSeen[tostring(rewardLock)] = nil
			HiddenEvent.rewardLock = nil
			local flag3 = false

			for i_ = 1, 8 do
				task.wait(0.5)
				local v11 = HiddenModules.Guide.getRewardTracker()
				flag3 = flag3 or v11 and v11.Options and v11.Options.Target == rewardLock
			end

			if flag3 then
				HiddenEvent.skipped["Reward:" .. reward] = tick() + 300
				HiddenNotify("Could not claim the reward from " .. v8.Name .. ", retry later", nil, "warning")
			else
				HiddenNotify("Claimed reward from " .. v8.Name, nil, "reward")
			end
		end

		return true
	end

	EquipHiddenWeapon = function(arg)
		local character = localPlayer.Character
		local v6 = NameWeapon(arg, true)
		local flag = not v6

		if flag then
			flag = os.clock() - (HiddenEvent.loadedWeapon or 0) > 5
		end

		if flag then
			HiddenEvent.loadedWeapon = os.clock()

			for _, v7 in ipairs(GetInventoryItems()) do
				if v7.Type == arg then
					CommF:InvokeServer("LoadItem", v7.Name)
					task.wait(0.5)
					v6 = NameWeapon(arg, true)
					break
				end
			end
		end

		local flag2 = not v6 and arg == "Gun"

		if flag2 then
			flag2 = os.clock() - (HiddenEvent.boughtGun or 0) > 30
		end

		if flag2 then
			HiddenEvent.boughtGun = os.clock()
			VxezeNotify("Hidden Event", "No gun in backpack or inventory, buying a Slingshot for the quest", "info", { Key = "hiddenbuygun" })

			pcall(function()
				CommF:InvokeServer("BuyItem", "Slingshot")
			end)

			task.wait(1)

			for _, v7 in ipairs(GetInventoryItems()) do
				if v7.Type == "Gun" then
					CommF:InvokeServer("LoadItem", v7.Name)
					task.wait(0.5)
					break
				end
			end

			v6 = NameWeapon(arg, true)
		end

		if v6 and v6.Parent ~= character then
			character.Humanoid:EquipTool(v6)
		end

		return v6
	end

	GetHiddenState = function(arg, arg2)
		HiddenEvent.states = HiddenEvent.states or {}
		local tbl9 = HiddenEvent.states[arg]

		if not tbl9 then
			tbl9 = {}
			HiddenEvent.states[arg] = tbl9

			ListenHiddenMoment(arg, function(arg3, ...)
				local v6 = tbl9
				local v7 = table.pack(...)
				local v8 = arg2
				v7.n = 3 + v7.n - 1
				table.move(v7, 1, v7.n, 3, v7)
				v7[1] = v6
				v7[2] = arg3
				v8(table.unpack(v7, 1, v7.n))
			end)
		end

		return tbl9
	end

	FindTaggedPartNear = function(arg, arg2)
		for _, v6 in ipairs(game:GetService("CollectionService"):GetTagged("M1HitRegistry")) do
			if (v6.Position - arg).Magnitude <= arg2 then
				return v6
			end
		end
	end

	GetPrisonLocation = function(arg)
		local bonusMomentLocations = workspace.Map.Prison:FindFirstChild("BonusMoment_Locations", true)
		bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChild(arg, true)
		return bonusMomentLocations and bonusMomentLocations:GetPivot().Position
	end

	FindHiddenEnemyMatch = function(arg, arg2, arg3)
		local huge = math.huge
		local v6 = nil

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if IsHiddenTarget(child) and (child:GetPivot().Position - arg2).Magnitude <= arg3 then
				for _, v7 in ipairs(arg) do
					if string.find(child.Name, v7, 1, true) then
						local v8 = localPlayer:DistanceFromCharacter(child:GetPivot().Position)

						if v8 < huge then
							huge = v8
							v6 = child
						end

						break
					end
				end
			end
		end

		return v6
	end

	FindHiddenPromptNear = function(arg, arg2, arg3)
		local v6, v7, v8 = ipairs(arg)
		local v9 = nil
		local v10 = nil

		for _, v11 in v6, v7, v8 do
			for _, descendant in ipairs(v11:GetDescendants()) do
				if descendant:IsA("ProximityPrompt") and descendant.Enabled then
					local parent = descendant.Parent
					local worldPosition = parent:IsA("Attachment") and parent.WorldPosition or parent:IsA("BasePart") and parent.Position or parent:IsA("Model") and parent:GetPivot().Position
					local magnitude = worldPosition and (worldPosition - arg2).Magnitude

					if magnitude and magnitude <= arg3 and (not v9 or magnitude < v9) then
						v9 = magnitude
						v10 = descendant
					end
				end
			end
		end

		return v10
	end

	HoldHiddenPrompt = function(arg)
		if not pcall(function()
			arg:InputHoldBegin()
			task.wait(arg.HoldDuration + 0.35)
			arg:InputHoldEnd()
		end) and fireproximityprompt then
			pcall(fireproximityprompt, arg, arg.HoldDuration + 0.35)
		end
	end

	FindTaggedPartIn = function(arg)
		if not arg then
			return nil
		end
		local v6 = nil
		local v7 = nil

		for _, v8 in ipairs(game:GetService("CollectionService"):GetTagged("M1HitRegistry")) do
			if v8:IsDescendantOf(arg) then
				local v9 = localPlayer:DistanceFromCharacter(v8.Position)

				if not v6 or v9 < v6 then
					v6 = v9
					v7 = v8
				end
			end
		end

		return v7
	end

	GetNpcPosition = function(arg)
		local v6 = workspace.NPCs:FindFirstChild(arg) or ReplicatedStorage.NPCs:FindFirstChild(arg)
		if v6 then
			return v6:GetPivot().Position
		end
		local v7 = require(ReplicatedStorage.NPCManager).getNPCsByName(arg)[1]
		local instance = v7 and v7._modelState and v7._modelState._instance
		return instance and instance:GetPivot().Position
	end

	HoistHiddenFlag = function(arg, arg2)
		local humanoidRootPart = localPlayer.Character.HumanoidRootPart
		local tbl9 = {}
		local flag = false

		local v6 = ListenHiddenMoment("Fortress Flagpole", function(arg3, arg4, arg5, arg6)
			if arg3 == "Shell" and typeof(arg4) == "Vector3" then
				table.insert(tbl9, { position = arg4, time = tick() + (arg5 or 1.4), radius = arg6 or 9 })
			elseif arg3 == "Completed" then
				flag = true
			end
		end)

		arg:FireServer("Hoist")
		local now = tick()
		local v7 = arg2

		while Settings["Auto Secret Quest"] and not flag and tick() - now < 100 and humanoidRootPart.Parent do
			task.wait(0.05)
			local flag2 = false

			for _, v8 in ipairs(tbl9) do
				local vector = Vector3.new(v7.X - v8.position.X, 0, v7.Z - v8.position.Z)

				if not flag2 then
					local n = v8.time + 0.5
					flag2 = tick() < n and vector.Magnitude < v8.radius + 4
				end
			end

			if flag2 then
				local v8 = nil

				for i_ = 0, 330, 30 do
					for _, v9 in ipairs({ 2, 7, 12, 15 }) do
						local n = arg2 + Vector3.new(math.cos(math.rad(i_)) * v9, 0, math.sin(math.rad(i_)) * v9)
						local v10, v11, v12 = ipairs(tbl9)
						local huge = math.huge

						for _, v13 in v10, v11, v12 do
							local n3 = v13.time + 0.5

							if tick() < n3 then
								local radius = v13.radius
								huge = math.min(huge, Vector3.new(n.X - v13.position.X, 0, n.Z - v13.position.Z).Magnitude - radius)
							end
						end

						if not v8 or huge > v8 then
							v8 = huge
							v7 = n
						end
					end
				end
			end

			if (humanoidRootPart.Position - v7).Magnitude > 1.5 then
				humanoidRootPart.CFrame = CFrame.new(v7)
			end

			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero

			for i_ = #tbl9, 1, -1 do
				if tbl9[i_].time + 1.5 < tick() then
					table.remove(tbl9, i_)
				end
			end
		end

		v6:Disconnect()
		HiddenEvent.checked = 0
	end

	TalkHiddenNpc = function(arg, arg2)
		local DialogueController = require(ReplicatedStorage.DialogueController)
		HiddenEvent.talking = tick() + 25

		local function fn()
			local v6 = DialogueController.getActiveDialogue()
			return v6 and v6._pageStack[#v6._pageStack]
		end

		pcall(DialogueController.close)
		task.wait(0.3)
		task.spawn(pcall, DialogueController.start, HiddenModules.NpcList.List[arg].DialogueCallback())
		local now = tick()
		local n = 0

		while true do
			if tick() - now < 20 and n < #arg2 then
				task.wait(0.4)
				local v6 = fn()

				if v6 then
					local options2 = v6._options or {}

					if #options2 == 0 then
						pcall(DialogueController.advance)
						continue
					else
						local v7 = nil

						for _, v8 in ipairs(options2) do
							if table.concat(v8._text or {}, " ") == arg2[n + 1] then
								v7 = v8
							end
						end

						if v7 then
							n += 1
							DialogueController.select(v7)
							task.wait(1)
							continue
						end
					end
				else
					continue
				end
			end

			break
		end

		task.wait(1)
		pcall(DialogueController.close)
		return n == #arg2
	end

	RunHiddenTempleIntel = function(arg)
		local v6 = GetHiddenState("Temple Intel", function(arg2, arg3, arg4, arg5)
			if arg3 == "Reveal" then
				arg2.revealed = tick()
				arg2.solved = arg5 == true
			elseif arg3 == "Storm" then
				arg2.storm = arg4 == true
			elseif arg3 == "Clear" or arg3 == "Dropped" then
				arg2.storm = false
				arg2.solved = false
				arg2.carrying = false
			end
		end)

		if not rawget(arg, "HiddenGuard") then
			local fireServer = arg.FireServer
			arg.HiddenGuard = true

			arg.FireServer = function(arg2, arg3, ...)
				if arg3 == "Struck" then
					return
				end
				local v7 = table.pack(...)
				local v8 = fireServer
				v7.n = 3 + v7.n - 1
				table.move(v7, 1, v7.n, 3, v7)
				v7[1] = arg2
				v7[2] = arg3
				return v8(table.unpack(v7, 1, v7.n))
			end
		end

		if v6.carrying or v6.storm then
			local v7 = GetNpcPosition("Sky Quest Giver 2")

			if v7 and HiddenSettle(v7 + Vector3.new(0, 1.5, 4), 10) then
				TalkHiddenNpc("Sky Quest Giver 2", { "The old temple", "Hand over the Intel" })
				HiddenEvent.checked = 0
				v6.carrying = false
			end

			return "Bring the Intel back to Sky Quest Giver 2"
		end

		local flag = not v6.revealed

		if not flag then
			local revealed = v6.revealed
			flag = tick() - revealed > 6
		end

		if flag then
			if HiddenSettle(Vector3.new(-7389.5, 5599, 339) + Vector3.new(0, 6, 0), 10) then
				local arrived = HiddenEvent.arrived

				if tick() - arrived > 9 then
					HiddenEvent.arrived = nil
					local v7 = GetNpcPosition("Sky Quest Giver 2")
					local now = tick()

					while Settings["Auto Secret Quest"] and tick() - now < 60 do
						task.wait(0.3)
						if v7 and HiddenSettle(v7 + Vector3.new(0, 1.5, 4), 10) then
							TalkHiddenNpc("Sky Quest Giver 2", { "The old temple", "I'll get it" })
							return "Accept The old temple quest"
						end
					end

					return "Accept The old temple quest"
				end
			end

			return "Enter the old temple"
		end

		if not HiddenSettle(Vector3.new(-7389.5, 5599, 339) + Vector3.new(0, 6, 0), 10) then
			HiddenEvent.stallGrace = tick() + 5
			return "Go back into the old temple"
		end

		if not v6.solved then
			arg:FireServer("Solved")
			task.wait(2)
			return "Turn the coils"
		end

		if arg:InvokeServer("TakeIntel") == true then
			v6.carrying = true
			HiddenNotify("Took the Intel, running back", nil, "found")
		end

		return "Take the Intel"
	end

	RunHiddenLookout = function(arg)
		local response = arg:InvokeServer("StartAttempt")
		if type(response) ~= "table" or type(response.Token) ~= "string" or type(response.Manifest) ~= "table" then
			return "Captain is not ready for lookout duty", true
		end
		local response2

		while Settings["Auto Secret Quest"] do
			local str2 = "/4: watching " .. #response.Manifest .. " ships"
			SetHiddenStep("Lookout round " .. tostring(response.Round) .. str2)
			local now = tick()

			while true do
				response2 = arg:InvokeServer("ObservationFinished", response.Token)
				local v6 = nil

				if type(response2) ~= "table" then
					response2 = v6
					break
				else
					if response2.Ready == false then
						task.wait(math.clamp(tonumber(response2.RetryAfter) or 1, 0.2, 5))
						response2 = nil
						if not (tick() - now > 120) then
							continue
						end
					end

					break
				end
			end

			if not response2 then
				arg:InvokeServer("AbortAttempt", response.Token)
				return "Lookout observation failed, retrying", true
			end
			local n = 0

			for _, v6 in ipairs(response.Manifest) do
				if v6.Boat == response2.TargetBoat and v6.FlagColor == response2.TargetFlagColor then
					n += 1
				end
			end

			local response3 = arg:InvokeServer("SubmitAnswer", response.Token, n)
			if type(response3) ~= "table" then
				return "Lookout answer was rejected", true
			end

			if response3.Correct ~= true then
				if type(response3.FinaleToken) == "string" then
					arg:InvokeServer("FinishFinale", response3.FinaleToken)
				end

				HiddenNotify("Lookout miscounted (" .. n .. " " .. tostring(response2.TargetFlagColor) .. " " .. tostring(response2.TargetBoat) .. "), retrying", nil, "warning")
				return "Lookout miscount, retrying"
			end

			if type(response3.NextRound) == "table" and type(response3.NextRound.Token) == "string" then
				response = response3.NextRound
				task.wait(1.25)
				continue
			end

			if type(response3.FinaleToken) == "string" then
				arg:InvokeServer("FinishFinale", response3.FinaleToken)
			end

			HiddenModules.Guide.interactQuestGiver("TravelDressrosa")
			HiddenEvent.checked = 0
			HiddenNotify("Lookout duty complete", nil, "success")
			return "Lookout duty complete"
		end

		return "Lookout stopped"
	end

	BuildHiddenSnowman = function(arg)
		if not HiddenSettle(Vector3.new(1300, 60, -1450), 40) then
			return "Go to the Frozen Village square"
		end
		local tbl9 = {}
		local flag = false

		local Snowman = ListenHiddenMoment("Snowman", function(arg2, arg3)
			if arg2 == "Setup" and type(arg3) == "table" then
				for k, v6 in pairs(arg3) do
					tbl9[k] = v6
				end
			elseif arg2 == "Alive" then
				flag = true
			end
		end)

		arg:FireServer("Init")
		task.wait(3)
		if not next(tbl9) then
			Snowman:Disconnect()
			return "Waiting for snow piles on Frozen Village", true
		end
		local humanoidRootPart = localPlayer.Character.HumanoidRootPart
		local snowmanBallRemote = ReplicatedStorage.Remotes.SnowmanBallRemote
		local snowmanStackRemote = ReplicatedStorage.Remotes.SnowmanStackRemote
		local tbl10 = {}
		local tbl11 = {}
		HiddenEvent.snowSequence = (HiddenEvent.snowSequence or 0) + 1000

		local function fn()
			local v6 = HiddenEvent
			v6.snowSequence = v6.snowSequence + 1
			local tbl12 = {}

			for _, v7 in ipairs(tbl10) do
				table.insert(tbl12, { i = v7.i, c = v7.c, d = v7.d })
			end

			snowmanBallRemote:FireServer(HiddenEvent.snowSequence, tbl12)
		end

		local function fn2(arg2)
			local now = tick()
			HiddenEvent.arrived = nil

			while Settings["Auto Secret Quest"] and tick() - now < 60 do
				task.wait(0.1)
				fn()
				if HiddenSettle(arg2, 8) then
					return true
				end
			end
		end

		local n = 0
		local cframe = nil

		for k, v6 in pairs(tbl9) do
			if not (not Settings["Auto Secret Quest"] or not fn2(v6.Position + Vector3.new(0, 3, 0))) then
				SetHiddenStep("Roll snowball " .. n + 1 .. "/3")
				arg:FireServer("GrabSnowball", k)
				n += 1
				local tbl12 = { i = n, c = humanoidRootPart.CFrame, d = 5 }
				table.insert(tbl10, tbl12)
				local n3 = humanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
				local vector = n3.Magnitude < 0.1 and Vector3.new(0, 0, -1) or n3.Unit

				for i_ = 3.5, 315, 3.5 do
					task.wait(0.066666666666666666)
					tbl12.d = math.clamp(i_ / 300, 0, 1) * 10 + 5
					tbl12.c = CFrame.new(humanoidRootPart.Position + vector * (tbl12.d / 2 + 2.5))
					fn()
				end

				if not cframe then
					cframe = CFrame.new(tbl12.c.Position - Vector3.new(0, tbl12.d / 2, 0))
				else
					SetHiddenStep("Stack snowball " .. n .. "/3")
					fn2(cframe.Position + Vector3.new(0, 3, 12))
					tbl12.c = CFrame.new(cframe.Position + Vector3.new(0, 7.5, 0))
					fn()
					task.wait(0.2)
					table.insert(tbl11, 15)

					if #tbl11 == 1 then
						table.insert(tbl11, 15)
					end

					tbl10 = {}
					fn()
					snowmanStackRemote:FireServer(tbl11, cframe)
				end

				task.wait(1)
				continue
			end

			break
		end

		local now = tick()

		while true do
			task.wait(0.5)
			if not (flag or tick() - now > 8) then
				continue
			end
			break
		end

		Snowman:Disconnect()

		if flag then
			task.wait(2)
			arg:FireServer("Finished")
			HiddenEvent.checked = 0
			HiddenNotify("Snowman is alive again", nil, "found")
			return "Snowman built"
		end

		tbl10 = {}
		fn()
		return "Snowman failed, retrying", true
	end

	FaceHiddenTarget = function(arg)
		local humanoidRootPart = localPlayer.Character.HumanoidRootPart
		humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, Vector3.new(arg.X, humanoidRootPart.Position.Y, arg.Z))
		workspace.CurrentCamera.CFrame = CFrame.lookAt(humanoidRootPart.Position + Vector3.new(0, 2, 0), arg)
	end

	GetHiddenFruitM1 = function()
		local v6 = NameWeapon("Blox Fruit")
		local character = localPlayer.Character

		if v6 then
			v6 = character and character:FindFirstChild(v6) or localPlayer.Backpack:FindFirstChild(v6)
		end

		return v6
	end

	NotifyHiddenFruitM1 = function(arg)
		if os.clock() - (HiddenEvent.fruitNotified or -300) < 300 then
			return
		end
		HiddenEvent.fruitNotified = os.clock()
		local value = localPlayer.Data.DevilFruit.Value
		VxezeNotify("Hidden Event", (value == "" and "You have no Blox Fruit" or value .. " has no M1 attack") .. ", please eat a Blox Fruit that has M1 (left click) for " .. arg, "warning", { Duration = 10 })
	end

	FindHiddenFruitTool = function()
		for _, v6 in ipairs({ localPlayer.Backpack, localPlayer.Character }) do
			for _, child in ipairs(v6:GetChildren()) do
				if child:IsA("Tool") and child:FindFirstChild("EatRemote") then
					return child
				end
			end
		end
	end

	EnsureHiddenFruit = function(arg)
		if GetHiddenFruitM1() then
			return true
		end

		if localPlayer.Data.DevilFruit.Value ~= "" then
			return false, "your eaten fruit has no M1 attack"
		end
		local v6 = FindHiddenFruitTool()

		if not v6 then
			local v7 = TakeFruitInventory()
			if not v7 then
				return false, "no Blox Fruit in backpack or inventory, skipping this quest"
			end
			VxezeNotify("Hidden Event", "Loading " .. v7 .. " from inventory to eat for " .. tostring(arg), "info", { Key = "hiddenloadfruit" })
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", v7)
			local now = tick()

			while true do
				task.wait(0.3)
				v6 = FindHiddenFruitTool()
				if not (v6 or tick() - now > 4) then
					continue
				end
				break
			end

			if not v6 then
				return false, "could not load a Blox Fruit from inventory, skipping this quest"
			end
		end

		pcall(function()
			localPlayer.Character.Humanoid:EquipTool(v6)
		end)

		task.wait(0.4)
		local eatRemote = v6:FindFirstChild("EatRemote")

		if eatRemote then
			pcall(function()
				eatRemote:InvokeServer("Eat")
			end)
		end

		local now = tick()

		while true do
			task.wait(0.3)
			if not (localPlayer.Data.DevilFruit.Value ~= "" or tick() - now > 4) then
				continue
			end
			break
		end

		if localPlayer.Data.DevilFruit.Value == "" then
			return false, "could not eat the Blox Fruit, skipping this quest"
		end
		VxezeNotify("Hidden Event", "Ate " .. tostring(localPlayer.Data.DevilFruit.Value) .. " for " .. tostring(arg), "success", { Key = "hiddenatefruit" })
		task.wait(1.5)
		if not GetHiddenFruitM1() then
			return false, "the eaten fruit has no M1 attack"
		end
		return true
	end

	UseHiddenSkillAt = function(arg)
		if not EquipHiddenWeapon("Blox Fruit") then
			return false
		end
		local skills = localPlayer.PlayerGui.Main:FindFirstChild("Skills")
		skills = skills and skills:FindFirstChild(localPlayer.Data.DevilFruit.Value)
		local v6 = nil

		for _, v7 in ipairs({ "Z", "X", "C", "V", "F" }) do
			local v8 = skills and skills:FindFirstChild(v7)
			local title = v8 and v8:FindFirstChild("Title")
			local cooldown = v8 and v8:FindFirstChild("Cooldown")
			if v8 and (not title or not title:IsA("TextLabel") or title.TextColor3.R > 0.9) and (not cooldown or cooldown.Size.X.Scale <= 0) then
				v6 = v7
				break
			end
		end

		if not skills then
			HiddenEvent.skillIndex = (HiddenEvent.skillIndex or 0) % 4 + 1
			v6 = ({ "Z", "X", "C", "V" })[HiddenEvent.skillIndex]
		end

		if not v6 then
			task.wait(0.5)
			return true
		end
		FaceHiddenTarget(arg.Position)

		pcall(function()
			VirtualInputManager:SendKeyEvent(true, v6, false, game)
		end)

		task.wait(0.1)

		pcall(function()
			VirtualInputManager:SendKeyEvent(false, v6, false, game)
		end)

		task.wait(1.5)
		return true
	end

	ShootHiddenGunAt = function(arg)
		local Gun = EquipHiddenWeapon("Gun")
		local flag = not Gun
		local flag2

		if flag then
			flag2 = os.clock() - (HiddenEvent.boughtGun or 0) > 30
		else
			flag2 = flag
		end

		if flag2 then
			HiddenEvent.boughtGun = os.clock()
			CommF:InvokeServer("BuyItem", "Slingshot")
			return false
		end

		if flag then
			return false
		end
		FaceHiddenTarget(arg.Position)
		task.wait(0.1)
		local v6 = workspace.CurrentCamera:WorldToViewportPoint(arg.Position)
		local v7 = getupvalues(require(ReplicatedStorage.Controllers.CombatController).Attack)[9]

		if type(v7) == "function" and debug.info(v7, "n") == "shootGun" and Gun.Parent == localPlayer.Character then
			local guiInset = game:GetService("GuiService"):GetGuiInset()

			pcall(v7, Gun, {
				UserInputType = Enum.UserInputType.Touch,
				Position = Vector3.new(v6.X - guiInset.X, v6.Y - guiInset.Y, 0),
			})
		else
			pcall(function()
				VirtualInputManager:SendMouseButtonEvent(v6.X, v6.Y, 0, true, game, 0)
			end)

			task.wait(0.05)

			pcall(function()
				VirtualInputManager:SendMouseButtonEvent(v6.X, v6.Y, 0, false, game, 0)
			end)
		end

		task.wait(1.2)
		return true
	end

	GetHiddenRaidHint = function()
		local flag = not HiddenEvent.hint

		if not flag then
			local time_ = HiddenEvent.hint.time
			flag = tick() - time_ > 20
		end

		if flag then
			local ok, result = pcall(function()
				return ReplicatedStorage.Modules.Net["RF/RequestNextRaidHint"]:InvokeServer()
			end)

			HiddenEvent.hint = { time = tick(), data = ok and type(result) == "table" and result or {} }

			if HiddenEvent.hint.data.Island and tonumber(HiddenEvent.hint.data.Seconds) then
				HiddenEvent.expectedBoss = {
					key = os.date("!%Y%m%d%H", os.time() + tonumber(HiddenEvent.hint.data.Seconds) + 5),
					hint = HiddenEvent.hint.data,
				}
			end
		end

		local expectedBoss = HiddenEvent.expectedBoss
		if not HiddenEvent.hint.data.Island and expectedBoss and expectedBoss.key == os.date("!%Y%m%d%H") and os.date("!*t").min < 8 then
			return { Island = expectedBoss.hint.Island, Boss = expectedBoss.hint.Boss, State = "Triggered", Seconds = 0 }
		end
		return HiddenEvent.hint.data
	end

	FindHiddenBoss = function(arg, arg2)
		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			local position = child:GetPivot().Position

			if IsHiddenTarget(child) and ((position - arg2).Magnitude < 1500 or localPlayer:DistanceFromCharacter(position) < 1500) then
				for _, v6 in ipairs(arg) do
					if string.find(child.Name, v6, 1, true) then
						return child
					end
				end
			end
		end
	end

	GetChargedClouds = function()
		return GetHiddenState("Electric Fighting Teacher", function(arg, arg2, arg3, arg4)
			if arg2 == "Charge" and typeof(arg3) == "Instance" then
				arg[arg3] = arg[arg3] or {}

				if typeof(arg4) == "Instance" and not table.find(arg[arg3], arg4) then
					table.insert(arg[arg3], arg4)
				end
			elseif arg2 == "Split" and typeof(arg3) == "Instance" and type(arg4) == "table" then
				arg[arg3] = arg[arg3] or {}

				for _, v6 in ipairs(arg4) do
					table.insert(arg[arg3], v6)
				end
			elseif arg2 == "Break" and typeof(arg3) == "Instance" then
				arg[arg3] = nil
			end
		end)
	end

	HitChargedCloud = function()
		for k, v6 in pairs(GetChargedClouds()) do
			local M1HitRegistry = nil

			for _, v7 in ipairs(v6) do
				if v7.Parent and v7:HasTag("M1HitRegistry") then
					M1HitRegistry = v7
					break
				else
					M1HitRegistry = nil
				end
			end

			M1HitRegistry = M1HitRegistry or k.Parent and k:HasTag("M1HitRegistry") and k
			if M1HitRegistry then
				HitHiddenPart(M1HitRegistry)
				return true
			end
			GetChargedClouds()[k] = nil
		end
	end

	PlayHiddenBellTune = function(arg, arg2)
		for i_, note in ipairs(arg.notes) do
			local str2 = tostring(note)
			local n = arg.start + (i_ - 1) * arg.beat
			local v6 = workspace
			local n3 = n + arg.good

			if v6:GetServerTimeNow() <= n3 then
				if str2 == "Fruit" and not GetHiddenFruitM1() then
					pcall(EnsureHiddenFruit, "Echoes Through the Clouds")
				end

				local v7 = EquipHiddenWeapon(str2 == "Fruit" and "Blox Fruit" or str2)

				while true do
					task.wait()

					if v7 and v7.Parent ~= localPlayer.Character then
						pcall(localPlayer.Character.Humanoid.EquipTool, localPlayer.Character.Humanoid, v7)
					end

					if not (workspace:GetServerTimeNow() >= n - 0.08 or not Settings["Auto Secret Quest"]) then
						continue
					end
					break
				end

				FaceHiddenTarget(arg2.Position)

				if str2 == "Gun" and v7 then
					local v8 = workspace.CurrentCamera:WorldToViewportPoint(arg2.Position)
					local v9 = getupvalues(require(ReplicatedStorage.Controllers.CombatController).Attack)[9]

					if type(v9) == "function" and v7.Parent == localPlayer.Character then
						local guiInset = game:GetService("GuiService"):GetGuiInset()

						pcall(v9, v7, {
							UserInputType = Enum.UserInputType.Touch,
							Position = Vector3.new(v8.X - guiInset.X, v8.Y - guiInset.Y, 0),
						})
					else
						pcall(function()
							VirtualInputManager:SendMouseButtonEvent(v8.X, v8.Y, 0, true, game, 0)
						end)

						pcall(function()
							VirtualInputManager:SendMouseButtonEvent(v8.X, v8.Y, 0, false, game, 0)
						end)
					end
				elseif str2 == "Fruit" and v7 then
					pcall(function()
						VirtualInputManager:SendKeyEvent(true, "Z", false, game)
					end)

					pcall(function()
						VirtualInputManager:SendKeyEvent(false, "Z", false, game)
					end)
				elseif str2 == "Fruit" then
					NotifyHiddenFruitM1("Echoes Through the Clouds")
				end

				if str2 ~= "Gun" then
					HiddenModules.RegisterAttack:FireServer(0.3)
					HiddenModules.RegisterHit:FireServer(arg2)
				end
			end
		end

		HiddenEvent.bellQuiet = tick() + 6
		task.wait(1)
	end

	FindHiddenRaidShip = function(arg)
		local v6 = nil
		local v7

		local function fn(arg2)
			for _, child in ipairs(arg2:GetChildren()) do
				if child:IsA("Model") and child ~= workspace.Map then
					local v8 = string.lower(child.Name)

					if string.find(v8, "ship", 1, true) or string.find(v8, "brigade", 1, true) or string.find(v8, "galleon", 1, true) or string.find(v8, "boat", 1, true) then
						local ok, result = pcall(function()
							return child:GetPivot().Position
						end)

						if ok then
							local magnitude = (result - arg).Magnitude

							if magnitude < 2500 and (not v7 or magnitude < v7) then
								v6 = child
								v7 = magnitude
							end
						end
					end
				end
			end
		end

		fn(workspace)
		fn(workspace.Map)
		fn(workspace.Enemies)
		return v6
	end

	ListHiddenRaidShips = function(arg)
		local tbl9 = {}

		local function fn(arg2)
			for _, child in ipairs(arg2:GetChildren()) do
				if child:IsA("Model") and child ~= workspace.Map then
					local v6 = string.lower(child.Name)

					if string.find(v6, "brigade", 1, true) or string.find(v6, "ship", 1, true) or string.find(v6, "galleon", 1, true) then
						local ok, result = pcall(function()
							return child:GetPivot().Position
						end)

						if ok and (result - arg).Magnitude < 3000 then
							table.insert(tbl9, { model = child, pos = result, dist = (result - arg).Magnitude })
						end
					end
				end
			end
		end

		fn(workspace.Enemies)
		fn(workspace)
		fn(workspace.Map)

		table.sort(tbl9, function(arg2, arg3)
			return arg2.dist < arg3.dist
		end)

		return tbl9
	end

	ListenHiddenRaidChat = function()
		if HiddenEvent.raidChat then
			return
		end
		local tbl9 = {}

		for _, descendant in ipairs(ReplicatedStorage:GetDescendants()) do
			if (descendant:IsA("RemoteEvent") or descendant:IsA("UnreliableRemoteEvent")) and string.find(descendant.Name, "Chat", 1, true) then
				table.insert(tbl9, descendant)
			end
		end

		if #tbl9 == 0 then
			return
		end
		HiddenEvent.raidChat = true

		local function fn(...)
			local str2 = ""

			local function fn2(arg)
				if type(arg) == "string" then
					str2 ..= " " .. arg
				elseif type(arg) == "table" then
					for _, v6 in pairs(arg) do
						if type(v6) == "string" then
							str2 ..= " " .. v6
						end
					end
				end
			end

			for _, v6 in ipairs({ ... }) do
				fn2(v6)
			end

			str2 = string.lower(str2)

			if string.find(str2, "pirate sails", 1, true) or string.find(str2, "fleet will be", 1, true) or string.find(str2, "lookouts have spotted", 1, true) then
				HiddenEvent.raidWarn = tick()
				HiddenNotify("Pirate fleet spotted, manning the fortress cannons", "raidwarn" .. math.floor(tick() / 60), "found")
			end
		end

		for _, v6 in ipairs(tbl9) do
			v6.OnClientEvent:Connect(fn)
		end
	end

	GetCannonAimState = function(arg)
		if HiddenEvent.cannonState and HiddenEvent.cannonState.seat == arg then
			return HiddenEvent.cannonState
		end

		if tick() - (HiddenEvent.cannonScanAt or 0) < 3 then
			return nil
		end
		HiddenEvent.cannonScanAt = tick()

		for _, v6 in pairs(getgc(true)) do
			if type(v6) == "table" and rawget(v6, "targetYaw") ~= nil and rawget(v6, "seat") == arg then
				HiddenEvent.cannonState = v6
				return v6
			end
		end
	end

	SetCannonAim = function(arg, arg2)
		local center = arg.center
		local position = arg.seat.Position
		local vector = Vector3.new(arg2.X - center.X, 0, arg2.Z - center.Z)
		if vector.Magnitude < 40 then
			return
		end
		local vector2 = Vector3.new(arg2.X - position.X, 0, arg2.Z - position.Z)
		local restForward = vector2.Magnitude <= 0.01 and arg.restForward or vector2.Unit
		local n = math.clamp(arg2.Y - position.Y, -300, 60)
		local n3 = position + restForward * math.clamp(vector2.Magnitude, 8, 700) + Vector3.new(0, n, 0)
		local restForward2 = arg.restForward
		local targetYaw = (math.atan2(vector.Unit.X, vector.Unit.Z) - math.atan2(restForward2.X, restForward2.Z) + 3.1415926535897931) % 6.2831853071795862 - 3.1415926535897931
		local n4 = math.max(Vector3.new(n3.X - position.X, 0, n3.Z - position.Z).Magnitude, 8) / 180
		local targetPitch = math.clamp(math.atan2((n3.Y - position.Y + 2.25 + 0.5 * workspace.Gravity * n4 * n4) / n4, 180), 0, 1.1344640137963142)
		arg.targetYaw = targetYaw
		arg.targetPitch = targetPitch
		arg.yaw = targetYaw
		arg.pitch = targetPitch
		arg.yawVel = 0
		local model = arg.model
		local parent

		if model then
			parent = model
		else
			parent = arg.seat and arg.seat.Parent
		end

		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		remotes = remotes and remotes:FindFirstChild("MarineBusterAim")
		local flag = parent and remotes

		if flag then
			flag = tick() - (HiddenEvent.cannonRelay or 0) > 0.05
		end

		if flag then
			HiddenEvent.cannonRelay = tick()

			pcall(function()
				remotes:FireServer(parent, targetYaw, targetPitch)
			end)
		end
	end

	AimHiddenCannon = function(cannonTarget)
		local bonusMomentLocations = workspace.Map.MarineBase:FindFirstChild("BonusMoment_Locations")
		local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
		local seatPart = humanoid and humanoid.SeatPart

		if not seatPart or seatPart.Parent.Name ~= "MarineBusterCannon" then
			local v6 = ipairs
			bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:GetChildren() or {}
			local v7 = nil
			seatPart = nil

			for _, bonusMomentLocation in v6(bonusMomentLocations) do
				local seat = bonusMomentLocation.Name == "MarineBusterCannon" and bonusMomentLocation:FindFirstChild("Seat")
				local flag

				if seat then
					flag = not seat.Occupant or seat.Occupant.Parent == localPlayer.Character
				else
					flag = seat
				end

				if flag then
					local magnitude = (seat.Position - cannonTarget).Magnitude

					if not v7 or magnitude < v7 then
						v7 = magnitude
						seatPart = seat
					end
				end
			end

			if not seatPart then
				return false
			end

			if localPlayer:DistanceFromCharacter(seatPart.Position) > 10 then
				HiddenMove(seatPart.CFrame * CFrame.new(0, 4, 0))
				return true
			end
			HiddenRelease()
			TweenManager.CancelTweenOnly()
			localPlayer.Character.HumanoidRootPart.CFrame = seatPart.CFrame * CFrame.new(0, 2, 0)
			task.wait(0.2)
			seatPart:Sit(humanoid)
			task.wait(0.6)
			HiddenEvent.cannonState = nil
		end

		local v6 = GetCannonAimState(seatPart)
		if not v6 then
			return false
		end
		HiddenEvent.cannonTarget = cannonTarget

		if not HiddenEvent.cannonLoop then
			HiddenEvent.cannonLoop = game:GetService("RunService").RenderStepped:Connect(function(...) end)
		end

		pcall(SetCannonAim, v6, cannonTarget)
		task.wait(0.2)
		return true
	end

	FireHiddenCannon = function(arg)
		local bonusMomentLocations = workspace.Map.MarineBase:FindFirstChild("BonusMoment_Locations")
		local v6 = ipairs
		bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:GetChildren() or {}
		local v7 = nil
		local v8 = nil

		for _, bonusMomentLocation in v6(bonusMomentLocations) do
			local seat = bonusMomentLocation.Name == "MarineBusterCannon" and bonusMomentLocation:FindFirstChild("Seat")

			if seat and (not seat.Occupant or seat.Occupant.Parent == localPlayer.Character) then
				local magnitude = (seat.Position - arg).Magnitude

				if not v7 or magnitude < v7 then
					v7 = magnitude
					v8 = seat
				end
			end
		end

		if not v8 then
			return false
		end
		local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid.SeatPart ~= v8 then
			if localPlayer:DistanceFromCharacter(v8.Position) > 8 then
				HiddenMove(v8.CFrame * CFrame.new(0, 3, 0))
				return true
			end
			HiddenRelease()
			TweenManager.CancelTweenOnly()
			localPlayer.Character.HumanoidRootPart.CFrame = v8.CFrame * CFrame.new(0, 2, 0)
			task.wait(0.2)
			v8:Sit(humanoid)
			task.wait(0.5)
		end

		local currentCamera = workspace.CurrentCamera
		currentCamera.CFrame = CFrame.lookAt(v8.Position + Vector3.new(0, 12, 0) + (v8.Position - arg).Unit * 10, arg)
		task.wait(0.1)
		local v9, v10 = currentCamera:WorldToViewportPoint(arg)

		if v10 then
			pcall(function()
				VirtualInputManager:SendMouseButtonEvent(v9.X, v9.Y, 0, true, game, 0)
			end)

			task.wait(0.05)

			pcall(function()
				VirtualInputManager:SendMouseButtonEvent(v9.X, v9.Y, 0, false, game, 0)
			end)
		end

		task.wait(0.6)
		return true
	end

	ShootHiddenCannon = function(arg)
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
		humanoid = humanoid and humanoid.SeatPart
		if not humanoid or humanoid.Parent.Name ~= "MarineBusterCannon" then
			return false
		end

		if tick() - (HiddenEvent.cannonShot or 0) < 1.2 then
			return true
		end
		local currentCamera = workspace.CurrentCamera
		local v6, v7 = currentCamera:WorldToViewportPoint(arg)

		if not v7 then
			currentCamera.CFrame = CFrame.lookAt(humanoid.Position + Vector3.new(0, 10, 0) + (humanoid.Position - arg).Unit * 8, arg)
			task.wait(0.12)
			v6, v7 = currentCamera:WorldToViewportPoint(arg)
		end

		if not v7 then
			return false
		end
		HiddenEvent.cannonShot = tick()

		pcall(function()
			VirtualInputManager:SendMouseButtonEvent(v6.X, v6.Y, 0, true, game, 0)
		end)

		task.wait(0.06)

		pcall(function()
			VirtualInputManager:SendMouseButtonEvent(v6.X, v6.Y, 0, false, game, 0)
		end)

		return true
	end

	LeaveHiddenCannon = function()
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid and humanoid.SeatPart and humanoid.SeatPart.Parent.Name == "MarineBusterCannon" then
			humanoid.Sit = false
			humanoid.Jump = true
		end
	end

	AttackHiddenSpot = function(arg)
		if localPlayer:DistanceFromCharacter(arg.Position) > 10 then
			HiddenMove(arg.CFrame * CFrame.new(0, 4, 4))
			return
		end
		HiddenHold(arg.CFrame * CFrame.new(0, 4, 4))
		EquipHiddenWeapon("Melee")

		if os.clock() - (HiddenEvent.lastHit or 0) >= 0.4 then
			HiddenEvent.lastHit = os.clock()
			HiddenModules.RegisterAttack:FireServer(0.3)
			HiddenModules.RegisterHit:FireServer(arg)
		end
	end

	RunMagmaOreCave = function()
		local magmaCave = workspace.Map:FindFirstChild("MagmaCave")
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not magmaCave or not humanoidRootPart then
			return
		end
		local bonusMomentLocations = magmaCave:FindFirstChild("BonusMoment_Locations")
		bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChildWhichIsA("BasePart")
		if not bonusMomentLocations or (humanoidRootPart.Position - bonusMomentLocations.Position).Magnitude > 1500 then
			return
		end

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if child.Name == "Magma Drill" and IsHiddenTarget(child) then
				KillHiddenEnemy(child)
				HiddenEvent.checked = 0
				return "Destroy the Magma Drill"
			end
		end
	end

	FindAwakenedBoss = function(arg, arg2)
		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if child:GetAttribute("BossIndicatorAwakened") and IsHiddenTarget(child) then
				local flag = true

				if arg2 then
					flag = false

					for _, v6 in ipairs(arg2) do
						if string.find(child.Name, v6, 1, true) then
							flag = true
						end
					end
				end

				if flag and (not arg or (child:GetPivot().Position - arg).Magnitude < 3000) then
					return child
				end
			end
		end
	end

	HitHiddenTriggers = function(arg, arg2)
		local v6 = nil
		local v7 = nil

		for _, v8 in ipairs(arg) do
			local descendants = v8 and v8:GetDescendants() or {}
			table.insert(descendants, v8)

			for _, descendant in ipairs(descendants) do
				if descendant:IsA("BasePart") and descendant:HasTag("M1HitRegistry") and (arg2 or descendant.Transparency < 1) then
					local v9 = localPlayer:DistanceFromCharacter(descendant.Position)

					if not v6 or v9 < v6 then
						v6 = v9
						v7 = descendant
					end
				end
			end
		end

		if v7 then
			HitHiddenPart(v7)
			return true
		end
	end

	GetHiddenBossHour = function()
		local v6 = os.date("!%Y%m%d%H")

		if not HiddenEvent.bossHour or HiddenEvent.bossHour.key ~= v6 then
			HiddenEvent.bossHour = { key = v6, checked = {}, active = nil }
			local expectedBoss = HiddenEvent.expectedBoss

			if expectedBoss and expectedBoss.key == v6 then
				for _, v7 in ipairs(HiddenQuests) do
					if v7.BossNames and not IsHiddenBossHinted(expectedBoss.hint, v7.HintIsland, v7.BossNames) then
						HiddenEvent.bossHour.checked[v7.Name] = true
					end
				end
			end
		end

		return HiddenEvent.bossHour
	end

	IsHiddenBossHinted = function(arg, arg2, arg3)
		if not arg.Island then
			return false
		end

		if table.find(arg3, arg.Boss) then
			return true
		end

		for _, v6 in ipairs(HiddenQuests) do
			if v6.BossNames and table.find(v6.BossNames, arg.Boss) then
				return false
			end
		end

		return arg.Island == arg2
	end

	IsHiddenHourUseful = function(arg)
		local v6 = GetHiddenRaidHint()
		if not v6 or not v6.Island or not v6.Boss then
			return true
		end

		for _, v7 in ipairs(HiddenQuests) do
			if arg["Sea1/" .. v7.Island .. "/" .. v7.Name] ~= true then
				if v7.BossNames then
					if IsHiddenBossHinted(v6, v7.HintIsland or v7.Island, v7.BossNames) then
						return true
					end
					continue
				end

				if v6.Island == (v7.HintIsland or v7.Island) then
					return true
				end
			end
		end

		return false
	end

	ListHiddenServers = function()
		local tbl9 = {}

		local ok, result = pcall(function()
			return ReplicatedStorage.__ServerBrowser:InvokeServer(1)
		end)

		if ok and type(result) == "table" then
			for k in pairs(result) do
				if type(k) == "string" then
					tbl9[k] = true
				end
			end
		end

		return tbl9
	end

	QueueHiddenReload = function()
		local queueOnTeleport = rawget(getgenv(), "queue_on_teleport") or syn and syn.queue_on_teleport or fluxus and fluxus.queue_on_teleport
		if not queueOnTeleport then
			return false
		end

		pcall(function()
			queueOnTeleport([[task.spawn(function()
	repeat
		task.wait(1)
	until game:IsLoaded()
	local players = game:GetService("Players")
	repeat
		task.wait(0.5)
	until players.LocalPlayer
	local player = players.LocalPlayer
	repeat
		task.wait(0.5)
	until player:FindFirstChild("PlayerGui")
	local waited = 0
	while not player.Character and waited < 240 do
		task.wait(2)
		waited = waited + 2
		if waited > 14 and player.PlayerGui:FindFirstChild("TeamSelection") then
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
			end)
		end
	end
	local character = player.Character or player.CharacterAdded:Wait()
	character:WaitForChild("HumanoidRootPart", 60)
	task.wait(5)
	pcall(function()
		loadstring(readfile("BF-VxezeHub.lua"))()
	end)
end)]])
		end)

		return true
	end

	HopHiddenServer = function()
		HiddenEvent.hopped = HiddenEvent.hopped or {}
		QueueHiddenReload()
		local v6 = ListHiddenServers()

		for i_ = 1, 2 do
			for k in pairs(v6) do
				if k ~= game.JobId and not HiddenEvent.hopped[k] then
					HiddenEvent.hopped[k] = true
					HiddenNotify("Dead boss hour, switching server", "hop" .. k, "travel")

					local function fn()
						ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", k)
					end

					pcall(fn)
					return true
				end
			end

			HiddenEvent.hopped = {}
		end

		return false
	end

	RunChefsKiss = function(arg)
		local chefMissing = HiddenEvent.chefMissing
		local flag

		if chefMissing then
			local time_ = HiddenEvent.chefMissing.time
			flag = tick() - time_ < 300
		else
			flag = chefMissing
		end

		if flag then
			local v6 = GatherChefIngredients(arg)
			if v6 then
				return v6
			end
			HiddenEvent.chefMissing = nil
			HiddenEvent.cooked = 0
		end

		local cauldronMoment = workspace.Map.Pirate:FindFirstChild("Cauldron_Moment")

		if cauldronMoment then
			cauldronMoment = cauldronMoment:FindFirstChild("Cauldron") or cauldronMoment:FindFirstChildWhichIsA("BasePart", true)
		end

		local flag2 = not cauldronMoment

		if not flag2 then
			flag2 = tick() - (HiddenEvent.cooked or 0) <= 15
		end

		if flag2 then
			return
		end

		if not HiddenSettle(cauldronMoment:GetPivot().Position + Vector3.new(0, 3, 6), 10) then
			return "Go to the tavern cauldron"
		end
		HiddenEvent.cooked = tick()
		local response = arg:InvokeServer("OpenCauldron")
		if type(response) ~= "table" then
			return "Waiting for the cauldron to open"
		end
		local tbl9 = {}
		local v6 = ipairs
		local slots = response.Slots or {}

		for _, slot in v6(slots) do
			if not response.Placed[slot] then
				local v7 = pairs
				local owned = response.Owned and response.Owned[slot] or {}
				local flag3 = nil

				for k, v8 in v7(owned) do
					if not (v8 > 0) then
						flag3 = nil
					else
						local response2 = arg:InvokeServer("Insert", k)

						if type(response2) == "table" then
							flag3 = true
							response = response2
							break
						else
							flag3 = nil
						end
					end
				end

				if not flag3 then
					table.insert(tbl9, tostring(response.Examples and response.Examples[slot] and response.Examples[slot][1] or slot))
				end
			end
		end

		if #tbl9 > 0 then
			arg:FireServer("CloseCauldron")
			HiddenNotify("Chef's Kiss needs: " .. table.concat(tbl9, ", "), "chefmissing", "warning")
			HiddenEvent.chefMissing = { time = tick(), text = "Chef's Kiss needs " .. table.concat(tbl9, ", "), needs = response.Slots }
			return HiddenEvent.chefMissing.text, true
		end

		local response2 = arg:InvokeServer("Cook")
		arg:FireServer("CloseCauldron")
		HiddenEvent.awakened = HiddenEvent.awakened or {}

		if response2 == "Cooked" then
			HiddenEvent.awakened["Chef's Kiss"] = tick()
			HiddenNotify("Chef's Kiss: recipe cooked, the Chef is awakening", "chefcooked", "success")
		end

		return "Cook the Chef's recipe"
	end

	CreateBossQuest = function(arg, active, arg2, arg3, arg4, arg5)
		return {
			Island = arg,
			Name = active,
			HintIsland = arg2,
			BossNames = arg3,
			RetryDelay = 300,
			Precheck = function(arg6)
				local v6 = GetHiddenBossHour()
				local flag = IsHiddenBossHinted(arg6, arg2, arg3) or v6.active == active
				local flag2

				if flag then
					flag2 = flag
				else
					flag2 = tick() - ((HiddenEvent.announced or {})[active] or 0) < 400
				end

				if flag2 then
					return true
				end

				if v6.active then
					return false, "awakened boss is on " .. tostring(v6.active) .. " this hour"
				end
				return false, "waiting for the XX:50 boss hint"
			end,
			Run = function(arg6)
				local v6 = GetHiddenIsland(arg)
				local position = v6 and v6.World.Position or localPlayer.Character:GetPivot().Position
				FindHiddenBoss(arg3, position)
				HiddenEvent.awakened = HiddenEvent.awakened or {}
				local v7 = FindAwakenedBoss(position, arg3)

				if v7 then
					GetHiddenBossHour().active = active
					HiddenEvent.bossFight = { quest = active, time = tick() }
					KillHiddenEnemy(v7)
					HiddenEvent.checked = 0
					return "Defeat the awakened " .. v7.Name
				end

				local v8 = GetHiddenBossHour()
				local v9 = GetHiddenRaidHint()
				local v10 = IsHiddenBossHinted(v9, arg2, arg3)

				if arg6.Active and not v10 and os.date("!*t").min >= 12 then
					v8.checked[active] = true
					v8.active = nil
					return arg3[1] .. " window passed this hour, wait for XX:50 hint", true
				end

				if arg6.Active then
					v8.active = active

					if arg4 then
						local v11, v12 = arg4(arg6)
						if v11 then
							return v11, v12
						end
					end

					return "Waiting for " .. arg3[1] .. " to awaken"
				end

				if v8.active == active then
					v8.active = nil
				end

				if v10 then
					local num = tonumber(v9.Seconds)
					local flag = arg5

					if arg5 then
						flag = v9.State == "Triggered"

						if not flag then
							flag = (num or math.huge) <= 0
						end
					end

					if flag then
						local v11, v12 = arg5(arg6)
						if v11 then
							return v11, v12
						end
					end

					return arg3[1] .. " stirs on " .. arg .. (num and " in ~" .. FormatMagnetTime(num) or " soon"), (num or 0) > 180
				end

				v8.checked[active] = true
				return "No awakened " .. arg3[1] .. " this hour", true
			end,
		}
	end

	do
		local tbl9 = {}

		local Jungle = CreateBossQuest("Jungle", "Banana Tree", "Jungle", { "Gorilla King" }, function()
			local v6 = GetHiddenState("Banana Tree", function(arg, arg2, arg3)
				if arg2 == "Availability" then
					arg.tree = typeof(arg3) == "Instance" and arg3 or nil
				elseif arg2 == "Reset" or arg2 == "Finale" then
					arg.tree = nil
				end
			end)

			if HitHiddenTriggers({ v6.tree and v6.tree.Parent and v6.tree or workspace.Map.Jungle:FindFirstChild("BananaTrees") }) then
				return "Shake the banana tree"
			end
		end)

		local v6 = CreateBossQuest("Frozen Village", "Frozen Defense", "Frozen Village", { "Yeti" }, function()
			local bonusMomentLocations = workspace.Map.Ice:FindFirstChild("BonusMoment_Locations")
			local v6 = ipairs
			local descendants = bonusMomentLocations and bonusMomentLocations:GetDescendants() or {}
			local v7 = nil
			local v8 = nil

			for _, descendant in v6(descendants) do
				local attribute = descendant:GetAttribute("FrozenDefenseRockPresent")
				local isBasePart = descendant:IsA("BasePart") and descendant or descendant:IsA("Model") and (descendant.PrimaryPart or descendant:FindFirstChildWhichIsA("BasePart", true))

				if attribute ~= nil and attribute ~= false and isBasePart then
					local v9 = localPlayer:DistanceFromCharacter(isBasePart.Position)

					if not v7 or v9 < v7 then
						v7 = v9
						v8 = isBasePart
					end
				end
			end

			if v8 then
				AttackHiddenSpot(v8)
				return "Break the cursed ice rocks"
			end

			if HitHiddenTriggers({ bonusMomentLocations }) then
				return "Break the cursed ice rocks"
			end
			local bossFight = HiddenEvent.bossFight
			local flag = bossFight and bossFight.quest == "Frozen Defense"

			if flag then
				local time_ = bossFight.time
				flag = tick() - time_ < 240
			end

			if flag then
				local position = GetHiddenIsland("Frozen Village")
				position = position and position.World.Position

				for _, child in ipairs(workspace.NPCs:GetChildren()) do
					if string.find(string.lower(child.Name), "villager", 1, true) and position and (child:GetPivot().Position - position).Magnitude < 900 then
						if not HiddenSettle(child:GetPivot().Position + Vector3.new(0, 2, 4), 8) then
							return "Go to " .. child.Name
						end
						TalkHiddenQuestNpc(child.Name, { "Yeti", "thank", "reward", "done" })
						HiddenEvent.bossFight = nil
						return "Report the Yeti to " .. child.Name
					end
				end
			end
		end)

		local v7 = CreateBossQuest("Magma Village", "One Last Eruption", "Magma Village", { "Magma Admiral", "Magma General" }, function(arg)
			local v7 = GetHiddenState("One Last Eruption", function(arg2, arg3, spots)
				if arg3 == "Setup" and type(spots) == "table" then
					arg2.spots = spots
					arg2.destroyed = {}
				elseif arg3 == "Destroyed" and arg2.destroyed then
					arg2.destroyed[spots] = true
				end
			end)

			if not v7.spots then
				if tick() - (v7.asked or 0) > 5 then
					v7.asked = tick()
					arg:FireServer("Init")
				end

				return "Waiting for the lava fissures"
			end

			local bonusMomentLocations = workspace.Map.Magma:FindFirstChild("BonusMoment_Locations")
			local v8 = nil
			local v9 = nil

			for k, spot in pairs(v7.spots) do
				if not v7.destroyed[k] then
					local v10 = localPlayer:DistanceFromCharacter(spot.Position)

					if not v8 or v10 < v8 then
						v8 = v10
						v9 = spot
					end
				end
			end

			if not v9 then
				return
			end

			if v8 > 10 then
				HiddenMove(v9 * CFrame.new(0, 4, 3))
				return "Go to the next lava fissure"
			end
			local v10 = ipairs
			bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:GetChildren() or {}
			local v11 = nil
			local v12 = nil

			for _, bonusMomentLocation in v10(bonusMomentLocations) do
				if bonusMomentLocation.Name == "Volcano Fissure" and bonusMomentLocation:IsA("BasePart") then
					local magnitude = (bonusMomentLocation.Position - v9.Position).Magnitude

					if not v11 or magnitude < v11 then
						v11 = magnitude
						v12 = bonusMomentLocation
					end
				end
			end

			HiddenHold(v9 * CFrame.new(0, 4, 3))
			EquipHiddenWeapon("Melee")
			HiddenModules.RegisterAttack:FireServer(0.3)
			local v13 = nil
			local v14 = nil

			for _, child in ipairs(workspace:GetChildren()) do
				if child.Name == "MagmaFissure" and child:IsA("Model") then
					local ok, result = pcall(child.GetPivot, child)
					ok = ok and (result.Position - v9.Position).Magnitude

					if ok and (not v13 or ok < v13) then
						v13 = ok
						v14 = child
					end
				end
			end

			if v14 and v13 < 25 then
				local flag = false

				for _, descendant in ipairs(v14:GetDescendants()) do
					if descendant:IsA("BasePart") then
						HiddenModules.RegisterHit:FireServer(descendant)
						flag = true
					end
				end

				if not flag then
					HiddenModules.RegisterHit:FireServer(v14)
				end
			elseif v12 then
				HiddenModules.RegisterHit:FireServer(v12)
			end

			pcall(getgenv().ClickM1)
			task.wait(0.35)
			return "Break the lava fissures"
		end)

		local Fountain = CreateBossQuest("Fountain", "Fountain Wire Repair", "Fountain City", { "Cyborg" }, function()
			if HitHiddenTriggers({ workspace._WorldOrigin:FindFirstChild("FountainWireNodes") }, true) then
				return "Repair the sparking wires"
			end
		end)

		local v8 = CreateBossQuest("Marine Fortress", "Fortress Under Fire", "Marine Fortress", { "Vice Admiral" }, function()
			local bonusMomentLocations = workspace.Map.MarineBase:FindFirstChild("BonusMoment_Locations")
			bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChild("MainBase")
			if not bonusMomentLocations then
				return
			end
			local y = nil
			local v8 = nil

			for _, descendant in ipairs(bonusMomentLocations:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant.Transparency < 1 and (descendant:HasTag("M1HitRegistry") or descendant.Name:find("Target")) then
					if not y or descendant.Position.Y > y then
						y = descendant.Position.Y
						v8 = descendant
					end
				end
			end

			local boundingBox, v9 = bonusMomentLocations:GetBoundingBox()
			if FireHiddenCannon(v8 and v8.Position or boundingBox.Position + Vector3.new(0, v9.Y / 4, 0)) then
				return "Shell the fortress building with the cannon"
			end
		end)

		local SkyArea2 = CreateBossQuest("SkyArea2", "The Tyrant Awakens", "Upper Skylands", { "Wysper", "Sky Warlord", "Tyrant" }, function()
			local skyArea2 = workspace.Map:FindFirstChild("SkyArea2")
			local v9 = HitHiddenTriggers
			local tbl10 = {}
			local tyrantClouds = skyArea2 and skyArea2:FindFirstChild("TyrantClouds")
			skyArea2 = skyArea2 and skyArea2:FindFirstChild("BonusMoment_Locations")
			tbl10[1] = tyrantClouds
			tbl10[2] = skyArea2
			if v9(tbl10) then
				return "Break the dark clouds"
			end
		end)

		local SkyArea22 = CreateBossQuest("SkyArea2", "Echoes Through the Clouds", "Upper Skylands", { "Thunder God", "Lightning God" }, function()
			local v9 = GetHiddenState("Echoes Through the Clouds", function(arg, arg2, arg3, arg4, arg5, arg6, arg7)
				if arg2 == "Listen" and type(arg3) == "table" and type(arg4) == "number" and type(arg5) == "number" then
					arg.round = { notes = arg3, start = arg4, beat = arg5, good = tonumber(arg7) or 0.7 }
					arg.listen = tick()
				elseif arg2 == "Finale" or arg2 == "Witness" or arg2 == "SetActive" then
					arg.round = nil
				end
			end)

			local goldenBell = workspace.Map:FindFirstChild("SkyArea2") and workspace.Map.SkyArea2:FindFirstChild("Golden Bell")

			if goldenBell then
				goldenBell = goldenBell:FindFirstChild("Bell", true) or goldenBell:FindFirstChildWhichIsA("BasePart", true)
			end

			if not goldenBell then
				return
			end

			if not HiddenSettle(goldenBell.Position + Vector3.new(0, 2, 7), 10) then
				return "Go to the Golden Bell"
			end
			local round = v9.round
			local flag

			if round then
				local n = round.start + #round.notes * round.beat
				flag = workspace:GetServerTimeNow() < n
			else
				flag = round
			end

			if flag then
				v9.round = nil
				PlayHiddenBellTune(round, goldenBell)
				return "Play the bell tune (" .. #round.notes .. " notes)"
			end

			local flag2 = tick() < (HiddenEvent.bellQuiet or 0)

			if not flag2 then
				flag2 = tick() - (v9.listen or 0) < 12
			end

			if flag2 then
				return "Listen to the bell"
			end
			EquipHiddenWeapon("Melee")
			HiddenModules.RegisterAttack:FireServer(0.3)
			HiddenModules.RegisterHit:FireServer(goldenBell)
			task.wait(1)
			return "Ring the Golden Bell"
		end)

		local v9 = CreateBossQuest("Underwater City", "Pearl of the Deep", "Underwater City", { "Fishman Lord" }, function(arg)
			if not HiddenEvent.clamListener then
				HiddenEvent.clamListener = ListenHiddenMoment("Pearl of the Deep", function(arg2, arg3)
					if arg2 == "ClamRespawned" and HiddenEvent.openedClams then
						HiddenEvent.openedClams[arg3] = nil
					elseif arg2 == "SetActive" or arg2 == "Loaded" then
						HiddenEvent.openedClams = {}
					end
				end)
			end

			HiddenEvent.openedClams = HiddenEvent.openedClams or {}
			if os.date("!*t").min >= 45 then
				return "Saving the clams for the XX:00 Fishman Lord window", true
			end
			local position = localPlayer.Character:GetPivot().Position

			for _, child in ipairs(workspace.Enemies:GetChildren()) do
				if IsHiddenTarget(child) and string.find(child.Name, "Mimic") and (child:GetPivot().Position - position).Magnitude < 300 then
					KillHiddenEnemy(child)
					return "Defeat the mimic clam"
				end
			end

			local v9 = nil
			local v10 = nil

			for _, v11 in ipairs(game:GetService("CollectionService"):GetTagged("PearlClam")) do
				local isBasePart = v11:IsA("BasePart") and v11 or v11:FindFirstChildWhichIsA("BasePart", true)

				if isBasePart and v11:IsDescendantOf(workspace) and not HiddenEvent.openedClams[v11] then
					local v12 = localPlayer:DistanceFromCharacter(isBasePart.Position)

					if not v9 or v12 < v9 then
						v9 = v12
						v10 = v11
					end
				end
			end

			if not v10 then
				local v11 = FindHiddenBoss({ "Fishman Lord" }, position)
				if v11 then
					KillHiddenEnemy(v11)
					return "Defeat Fishman Lord while the clams refill"
				end
				return "Waiting for the clams to reappear", true
			end

			if HiddenSettle((v10:IsA("BasePart") and v10 or v10:FindFirstChildWhichIsA("BasePart", true)).CFrame * Vector3.new(0, 0, -3.5) + Vector3.new(0, 2, 0), 9) then
				local response = arg:InvokeServer("OpenClam", v10)
				HiddenEvent.openedClams[v10] = tick()
				HiddenEvent.arrived = nil

				if response == "Black" then
					task.wait(1.5)

					for i_ = 1, 5 do
						if arg:InvokeServer("ClaimPearl") == true then
							HiddenEvent.awakened["Pearl of the Deep"] = tick()
							HiddenNotify("Found the black pearl, the Fishman Lord awakens", nil, "found")
							break
						else
							task.wait(1)
						end
					end
				end
			end

			return "Search the clams for the black pearl"
		end)

		local v10 = CreateBossQuest("Pirate Village", "Chef's Kiss", "Pirate Village", { "Chef" }, RunChefsKiss, RunChefsKiss)

		local Prison = CreateBossQuest("Prison", "Lever Jailbreak", "Prison", { "Warden" }, function(arg)
			local bonusMomentLocations = workspace.Map.Prison:FindFirstChild("BonusMoment_Locations", true)
			bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChild("Levers")
			if not bonusMomentLocations then
				return
			end
			local tbl10 = {}

			for _, child in ipairs(bonusMomentLocations:GetChildren()) do
				local lever = child:FindFirstChild("Lever")

				if lever then
					table.insert(tbl10, lever)
				end
			end

			table.sort(tbl10, function(arg2, arg3)
				if math.abs(arg2.Position.X - arg3.Position.X) <= 0.001 then
					return arg2.Position.Z < arg3.Position.Z
				end
				return arg2.Position.X < arg3.Position.X
			end)

			local leverPuzzle = HiddenEvent.leverPuzzle or { known = {}, pulled = 0, wrong = {} }
			HiddenEvent.leverPuzzle = leverPuzzle
			local v11

			if leverPuzzle.pulled < #leverPuzzle.known then
				v11 = leverPuzzle.known[leverPuzzle.pulled + 1]
			else
				local tbl11 = { 2, 3, 4, 1 }

				for i_ = 1, #tbl10 do
					if not table.find(tbl11, i_) then
						table.insert(tbl11, i_)
					end
				end

				v11 = tbl11[#leverPuzzle.known + 1]
				local flag = v11 and v11 <= #tbl10 and not table.find(leverPuzzle.known, v11) and not leverPuzzle.wrong[#leverPuzzle.known + 1 .. ":" .. v11]
				local v12 = nil

				if not flag then
					v11 = v12
				end

				for _, v13 in ipairs(tbl11) do
					if not v11 then
						if v13 <= #tbl10 and not table.find(leverPuzzle.known, v13) and not leverPuzzle.wrong[#leverPuzzle.known + 1 .. ":" .. v13] then
							v11 = v13
						end

						continue
					end

					break
				end
			end

			if not v11 then
				HiddenEvent.leverPuzzle = nil
				return
			end
			local vector = Vector3.zero

			for _, v12 in ipairs(tbl10) do
				vector += v12.Position / #tbl10
			end

			HiddenEvent.stallGrace = tick() + 5

			if HiddenSettle(vector + Vector3.new(0, 3, 8), 12) then
				local response = arg:InvokeServer("Pull", v11)
				local result = type(response) == "table" and response.Result or response

				if result == "Accepted" then
					if leverPuzzle.pulled == #leverPuzzle.known then
						table.insert(leverPuzzle.known, v11)
					end

					leverPuzzle.pulled = leverPuzzle.pulled + 1
				elseif result == "Solved" then
					HiddenEvent.leverPuzzle = nil
				elseif result == "Reset" then
					if leverPuzzle.pulled == #leverPuzzle.known then
						leverPuzzle.wrong[#leverPuzzle.known + 1 .. ":" .. v11] = true
					end

					leverPuzzle.pulled = 0
				end

				task.wait(0.4)
			end

			return "Solve the lever puzzle (" .. #leverPuzzle.known .. "/" .. #tbl10 .. ")"
		end)

		tbl9[1] = Jungle
		tbl9[2] = v6
		tbl9[3] = v7
		tbl9[4] = Fountain
		tbl9[5] = v8
		tbl9[6] = SkyArea2
		tbl9[7] = SkyArea22
		tbl9[8] = v9
		tbl9[9] = v10
		tbl9[10] = Prison

		tbl9[11] = {
			Island = "Prison",
			Name = "Escape from Alcatraz",
			Run = function(arg)
				local prisoners = arg.MiscData and arg.MiscData.Prisoners
				prisoners = type(prisoners) == "table" and prisoners or {}
				local prisonerKey = HiddenEvent.prisonerKey
				local v11 = prisonerKey and prisoners[prisonerKey]

				if not v11 or typeof(v11.Model) ~= "Instance" or not v11.Model.Parent then
					local v12 = nil
					prisonerKey = nil
					v11 = nil

					for k, prisoner in pairs(prisoners) do
						local model = prisoner.Model

						if typeof(model) == "Instance" and model.Parent then
							local v13 = localPlayer:DistanceFromCharacter(model:GetPivot().Position)

							if not v12 or v13 < v12 then
								v12 = v13
								prisonerKey = k
								v11 = prisoner
							end
						end
					end

					HiddenEvent.prisonerKey = prisonerKey
				end

				if not v11 then
					return "Waiting for prisoners to escape", true
				end
				local model = v11.Model
				local flag = HiddenEvent.provoked == model

				if flag then
					flag = tick() - (HiddenEvent.provokedAt or 0) > 25
				end

				if flag then
					HiddenEvent.provoked = nil
				end

				if HiddenEvent.provoked ~= model then
					local n = model:GetPivot() * CFrame.new(0, 1.5, 6)

					if localPlayer:DistanceFromCharacter(model:GetPivot().Position) > 12 then
						HiddenMove(n)
					else
						HiddenHold(n)
						HiddenEvent.provokeTry = HiddenEvent.provokeTry or {}

						if tick() - (HiddenEvent.provokeTry[prisonerKey] or 0) > 1.5 then
							HiddenEvent.provokeTry[prisonerKey] = tick()
							arg:InvokeServer("Provoke", prisonerKey)
							local v12 = HiddenEvent
							local v13 = HiddenEvent
							local now = tick()
							v12.provoked = model
							v13.provokedAt = now
						end
					end

					return "Confront the escaping prisoner (" .. tostring(prisonerKey) .. ")"
				end

				HiddenEvent.stallGrace = tick() + 5
				local humanoidRootPart = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart

				if humanoidRootPart then
					HitHiddenPart(humanoidRootPart)

					if model:FindFirstChildOfClass("Humanoid") then
						SizePart(model)
						pcall(BringMob, model)
						UsedualFlock()
						local cFrame = humanoidRootPart.CFrame
						getgenv().AimPos = cFrame
						HiddenMove(GetHiddenFarmCFrame(model))
						getgenv().ClickM1(model, true)
					end
				end

				return "Catch the prisoner (" .. tostring(prisonerKey) .. ")"
			end,
		}

		tbl9[12] = {
			Island = "Prison",
			Name = "Don Megalo",
			Run = function(arg)
				local v11 = GetHiddenState("Don Megalo", function(arg2, arg3, stage)
					if arg3 == "Stage" then
						arg2.stage = stage
					elseif arg3 == "GateUnlocked" then
						arg2.gateOpen = true
					end
				end)

				if tick() - (v11.initialized or 0) > 30 then
					v11.initialized = tick()
					arg:FireServer("Init")
					task.wait(1)
				end

				local v12 = FindHiddenEnemyMatch({ "Megalo Guard", "Bouncer" }, Vector3.new(5277, 5, 743), 900)
				if v12 then
					KillHiddenEnemy(v12)
					return "Defeat " .. v12.Name
				end
				local SharkCape = GetPrisonLocation("SharkCape")

				if SharkCape and v11.gateOpen then
					if HiddenSettle(SharkCape + Vector3.new(0, 1.5, 3), 8) then
						arg:FireServer("BouncerReady")
						local v13 = FindHiddenPromptNear({ workspace.Map.Prison, workspace._WorldOrigin }, SharkCape, 25)

						if v13 then
							HoldHiddenPrompt(v13)
						end

						if arg:InvokeServer("TakeCape") == true then
							arg:InvokeServer("ClaimCape")
							HiddenEvent.checked = 0
						end

						task.wait(1)
					end

					return "Hold to steal Don Megalo's coat"
				end

				local MegaloGate = GetPrisonLocation("MegaloGate")

				if MegaloGate and not v11.gateOpen then
					local Key = GetPrisonLocation("Key")

					if Key and not v11.hasKey then
						if HiddenSettle(Key + Vector3.new(0, 3, 3), 8) then
							v11.hasKey = arg:InvokeServer("TakeKey") == true
							task.wait(1)
						end

						return "Find the cell key"
					end

					if HiddenSettle(MegaloGate + Vector3.new(0, 3, 4), 8) then
						v11.gateOpen = arg:InvokeServer("Unlock") == true
						task.wait(1)
					end

					return "Unlock the tower gate"
				end

				return "Waiting for Don Megalo's tower", true
			end,
		}

		tbl9[13] = {
			Island = "Magma Village",
			Name = "Magma Ore Extraction",
			RetryDelay = 600,
			NoMoment = function()
				return RunMagmaOreCave()
			end,
			Run = function(arg)
				local v11 = RunMagmaOreCave()
				if v11 then
					return v11
				end
				local magmaOreExtraction = HiddenEvent.announced and HiddenEvent.announced["Magma Ore Extraction"]
				local flag = not arg.Active

				if flag then
					flag = not (magmaOreExtraction and tick() - magmaOreExtraction < 900)
				end

				if flag then
					return "Waiting for the drilling at Magma Village", true
				end
				local backArea = workspace.Map.Magma:FindFirstChild("BackArea")
				backArea = backArea and backArea:FindFirstChild("Elevator")
				backArea = backArea and backArea:FindFirstChild("Part")
				if not backArea then
					return "Waiting for the drilling at Magma Village", true
				end
				local humanoidRootPart = localPlayer.Character.HumanoidRootPart

				if HiddenGoTo(backArea.Position + Vector3.new(0, 4, 0), 6) then
					HiddenHold(CFrame.new(backArea.Position + Vector3.new(0, 4, 0)))
					pcall(firetouchinterest, humanoidRootPart, backArea, 0)
					task.wait(0.2)
					pcall(firetouchinterest, humanoidRootPart, backArea, 1)
					task.wait(3)
				end

				return "Take the mine elevator"
			end,
		}

		tbl9[14] = {
			Island = "Frozen Village",
			Name = "Snowman",
			Run = function(arg)
				return BuildHiddenSnowman(arg)
			end,
		}

		tbl9[15] = {
			Island = "Marine Fortress",
			Name = "Battle Plans",
			RetryDelay = 300,
			Run = function(arg)
				ListenHiddenRaidChat()

				local v11 = GetHiddenState("Battle Plans", function(arg2, arg3)
					if arg3 == "RaidStart" then
						arg2.raid = tick()
						arg2.failed = nil
					elseif arg3 == "Failed" then
						arg2.raid = nil
						arg2.failed = tick()
					end
				end)

				local position = workspace.Map.MarineBase:GetPivot().Position
				local bonusMomentLocations = workspace.Map.MarineBase:FindFirstChild("BonusMoment_Locations")
				bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChild("PirateShip_Spawn")
				bonusMomentLocations = bonusMomentLocations and bonusMomentLocations.Position or position
				local v12 = ListHiddenRaidShips(bonusMomentLocations)
				local battlePlans = (HiddenEvent.announced or {})["Battle Plans"]
				local raidWarn = HiddenEvent.raidWarn

				if raidWarn then
					local raidWarn2 = HiddenEvent.raidWarn
					raidWarn = tick() - raidWarn2 < 900
				end

				raidWarn = raidWarn or battlePlans and tick() - battlePlans < 900
				local raid = v11.raid

				if raid then
					local raid2 = v11.raid
					raid = tick() - raid2 < 900
				end

				if not arg.Active and not raid and not raidWarn and #v12 == 0 then
					LeaveHiddenCannon()
					return "Waiting for pirates to raid the Marine Fortress", true
				end
				HiddenEvent.stallGrace = tick() + 60
				local v13 = v12[1]

				if v13 and v13.model.Parent then
					local model = v13.model
					if not AimHiddenCannon(v13.pos) then
						return "Boarding the fortress cannon"
					end

					if ShootHiddenCannon(v13.pos) then
						return "Shelling " .. model.Name .. " (" .. #v12 .. " ships left)"
					end
					return "Aiming the cannon at " .. model.Name
				end

				if AimHiddenCannon(bonusMomentLocations + Vector3.new(0, 20, 0)) then
					return "Manning the cannon, waiting for the pirate fleet"
				end
				return "Go to the fortress cannon"
			end,
		}

		tbl9[16] = {
			Island = "Colosseum",
			Name = "Crowd Favorite",
			RetryDelay = 600,
			Run = function()
				local v11 = GetHiddenState("Crowd Favorite", function(arg, arg2, target, fill)
					if arg2 == "ShowTarget" then
						arg.target = target
					elseif arg2 == "Hit" then
						arg.fill = fill
					elseif arg2 == "SetActive" then
						arg.active = target == true
					end
				end)

				local target = v11.target or workspace:FindFirstChild("Ring")
				local v12 = ipairs
				local descendants = target and target.Parent and target:GetDescendants() or {}
				local v13 = nil

				for _, descendant in v12(descendants) do
					if descendant:IsA("BasePart") and descendant:HasTag("M1HitRegistry") then
						v13 = descendant
						break
					else
						v13 = nil
					end
				end

				if not v13 then
					return "Waiting for a Colosseum target", true
				end
				HitHiddenPart(v13)
				if v11.active then
					return "Crowd show: " .. math.floor((tonumber(v11.fill) or 0) * 100) .. "%"
				end
				return "Hit the ring to start the show"
			end,
		}

		tbl9[17] = {
			Island = "SkyArea2",
			Name = "Temple Intel",
			Run = function(arg)
				return RunHiddenTempleIntel(arg)
			end,
		}

		tbl9[18] = {
			Island = "Pirate Village",
			Name = "Tavern Brawl",
			RetryDelay = 600,
			Run = function(arg)
				local v11 = GetHiddenState("Tavern Brawl", function(arg2, arg3, arg4)
					if arg3 == "SetAvailable" then
						arg2.available = arg4 == true
					elseif arg3 == "BreachStart" then
						arg2.stage = "breach"
					elseif arg3 == "DoorsBurst" then
						arg2.stage = "inside"
					elseif arg3 == "FightStart" then
						arg2.stage = "fight"
					elseif arg3 == "GangUpStart" then
						arg2.stage = "gang"
					elseif arg3 == "BrawlersDefeated" then
						arg2.stage = "defeated"
					elseif arg3 == "ResetProgress" then
						arg2.stage = nil
						arg2.sent = {}
					end
				end)

				local tavernNEW = workspace.Map.Pirate:FindFirstChild("TavernNEW", true)
				tavernNEW = tavernNEW and tavernNEW:FindFirstChild("TavernDoor", true)
				local position = tavernNEW and tavernNEW:GetPivot().Position or Vector3.new(-1121, 14, 4121)

				if v11.stage == "defeated" then
					local tavernOwner = workspace.Terrain:FindFirstChild("Tavern Owner")

					if HiddenSettle(tavernOwner and (tavernOwner:GetPivot() * CFrame.new(0, 0, -4)).Position or position, 6) then
						arg:FireServer("ClaimReward")
						arg:FireServer("ExitTavern")
						HiddenEvent.checked = 0
						task.wait(1.5)
					end

					return "Take the brew from the Bartender"
				end

				v11.sent = v11.sent or {}

				if v11.stage and not v11.sent[v11.stage] then
					v11.sent[v11.stage] = true

					if v11.stage == "gang" then
						arg:FireServer("BeginGangUp")
					elseif v11.stage == "fight" or v11.stage == "inside" then
						arg:FireServer("BeginFight")
					elseif v11.stage == "breach" then
						arg:FireServer("TakeBreachSpot")
						task.wait(0.6)
						arg:FireServer("DoorsKicked")
					end

					task.wait(1)
					return "Start the tavern brawl (" .. v11.stage .. ")"
				end

				for _, child in ipairs(workspace.Enemies:GetChildren()) do
					if IsHiddenTarget(child) and (child:GetPivot().Position - position).Magnitude < 120 and string.find(child.Name, "Tavern") then
						KillHiddenEnemy(child)
						return "Beat up the tavern punks"
					end
				end

				if v11.stage == "gang" or v11.stage == "fight" or v11.stage == "inside" or v11.stage == "breach" then
					if tick() - (v11.resent or 0) > 15 then
						v11.resent = tick()
						v11.sent[v11.stage] = nil
					end

					return "Waiting for the brawlers"
				end

				if not v11.available and not arg.Active then
					return "Waiting for the tavern brawl (strange winds)", true
				end

				if HiddenSettle(position + Vector3.new(0, 3, 6), 10) then
					arg:FireServer("Breach")
					task.wait(2)
				end

				return "Breach the shaking tavern door"
			end,
		}

		tbl9[19] = {
			Island = "Fountain",
			Name = "Sewer Gangs",
			RetryDelay = 600,
			Precheck = function()
				local clockTime = game:GetService("Lighting").ClockTime
				if clockTime >= 18 or clockTime < 6 then
					return true
				end
				return false, "waiting for night time"
			end,
			Run = function(arg)
				local v11 = GetHiddenState("Sewer Gangs", function(arg2, arg3, arg4)
					if arg3 == "TreasureReady" and typeof(arg4) == "CFrame" then
						arg2.chest = arg4.Position
					end
				end)

				if v11.chest then
					if HiddenSettle(v11.chest + Vector3.new(0, 3, 0), 5) then
						if arg:InvokeServer("ClaimTreasure") == true then
							v11.chest = nil
							HiddenEvent.checked = 0
						end

						task.wait(1)
					end

					return "Claim the gang's treasure"
				end

				local sewerSystem = workspace.Map:FindFirstChild("SewerSystem")

				if sewerSystem and (localPlayer:GetAttribute("CurrentLocation") == "Sewers" or localPlayer.Character:GetPivot().Position.Y < -300) then
					local position = localPlayer.Character:GetPivot().Position

					for _, child in ipairs(workspace.Enemies:GetChildren()) do
						if IsHiddenTarget(child) and (child:GetPivot().Position - position).Magnitude < 700 then
							KillHiddenEnemy(child)
							return "Fight Megalo's sewer gang"
						end
					end

					if HitHiddenTriggers({ sewerSystem:FindFirstChild("BreakableWalls", true) }) then
						return "Break through the sewer walls"
					end
					local sewerEnemyRooms = sewerSystem:FindFirstChild("SewerEnemyRooms", true)
					HiddenEvent.sewerRoom = (HiddenEvent.sewerRoom or 0) % math.max(#(sewerEnemyRooms and sewerEnemyRooms:GetChildren() or {}), 1) + 1
					local v12

					if sewerEnemyRooms then
						local sewerRoom = HiddenEvent.sewerRoom
						v12 = sewerEnemyRooms:GetChildren()[sewerRoom]
					else
						v12 = sewerEnemyRooms
					end

					if v12 then
						HiddenGoTo(v12:GetPivot().Position + Vector3.new(0, 5, 0), 20)
						task.wait(2)
					end

					return "Search the sewers"
				end

				local cranes = workspace.Map.Fountain:FindFirstChild("Cranes")
				local sewerEntrancePrompt = cranes and cranes:FindFirstChild("SewerEntrancePrompt", true)
				cranes = cranes and cranes:FindFirstChild("CraneBonus")
				local sewerEntrance = workspace.Map.Fountain:FindFirstChild("SewerEntrance")

				if cranes and sewerEntrance and cranes:GetAttribute("SewerEntranceLifted") then
					HiddenMove(CFrame.new(sewerEntrance.Position + Vector3.new(0, 1, 0)))
					local humanoidRootPart = localPlayer.Character.HumanoidRootPart

					pcall(function()
						firetouchinterest(humanoidRootPart, sewerEntrance, 0)
						firetouchinterest(humanoidRootPart, sewerEntrance, 1)
					end)

					task.wait(8)
					return "Drop into the sewer entrance"
				end

				if sewerEntrancePrompt and sewerEntrancePrompt.Enabled then
					if HiddenSettle(sewerEntrancePrompt.Parent.WorldPosition + Vector3.new(0, 3, 0), 6) then
						HoldHiddenPrompt(sewerEntrancePrompt)
						local now = tick()

						while true do
							task.wait(0.3)
							if not (cranes and cranes:GetAttribute("SewerEntranceLifted") or tick() - now > 5) then
								continue
							end
							break
						end

						task.wait(2.6)
					end

					return "Lift the crane over the sewer"
				end

				return "The sewers only open at night", true
			end,
		}

		tbl9[20] = {
			Island = "Jungle",
			Name = "The Thieving Monkey",
			RetryDelay = 600,
			Run = function(arg)
				local v11 = GetHiddenState("The Thieving Monkey", function(arg2, arg3, footprints, arg4)
					if arg3 == "Footprints" then
						footprints = type(footprints) == "table" and footprints or nil
						arg2.footprints = footprints
					elseif arg3 == "HatState" then
						arg2.ownsHat = footprints == true

						if arg2.ownsHat then
							arg2.pickup = nil
						end
					elseif arg3 == "HatDropped" then
						local position = typeof(footprints) == "CFrame" and footprints.Position
						local flag

						if position then
							flag = position
						else
							flag = typeof(footprints) == "Vector3" and footprints
						end

						arg2.pickup = flag or typeof(arg4) == "CFrame" and arg4.Position or typeof(arg4) == "Vector3" and arg4 or nil
						arg2.dropped = tick()
					elseif arg3 == "ClearHatPickup" then
						arg2.pickup = nil
					elseif arg3 == "MonkeyFalling" then
						arg2.monkey = typeof(footprints) == "Instance" and footprints or arg2.monkey
						arg2.landed = tick()
					elseif arg3 == "MonkeyLanded" then
						arg2.landed = tick()
					elseif arg3 == "MonkeyRetreat" or arg3 == "MonkeyDefeated" then
						arg2.landed = nil
					end
				end)

				local flag = not v11.landed and not v11.pickup

				if flag then
					flag = tick() - (v11.initialized or 0) > 30
				end

				if flag then
					v11.initialized = tick()
					arg:FireServer("Initialize")
					task.wait(1)
				end

				if v11.ownsHat or localPlayer.Backpack:FindFirstChild("Adventurer's Hat") or localPlayer.Character:FindFirstChild("Adventurer's Hat") then
					v11.pickup = nil

					if HiddenSettle((GetNpcPosition("Adventurer") or Vector3.new(-1680, 48, 175)) + Vector3.new(0, 1.5, 4), 8) then
						arg:FireServer("ReturnHat")
						task.wait(1)

						if not arg.Completed then
							pcall(TalkHiddenNpc, "Adventurer", { "Return the hat", "You're welcome." })
						end

						HiddenEvent.checked = 0
						task.wait(1.5)
					end

					return "Return the hat to the Adventurer"
				end

				local adventurerSHat = workspace._WorldOrigin:FindFirstChild("Adventurer's Hat")
				local handle = adventurerSHat and adventurerSHat:FindFirstChild("Handle")

				if handle then
					v11.pickup = v11.pickup or handle.Position
				end

				if v11.pickup then
					local position = handle and handle.Position or v11.pickup

					if HiddenGoTo(position + Vector3.new(0, 2, 0), 8) then
						HiddenHold(CFrame.new(position + Vector3.new(0, 2, 0)))
						handle = handle and handle:FindFirstChildOfClass("ProximityPrompt")

						if handle and handle.Enabled then
							pcall(fireproximityprompt, handle)
						else
							arg:FireServer("ClaimHat")
						end

						task.wait(1)
					end

					local flag2 = not adventurerSHat

					if flag2 then
						flag2 = tick() - (v11.dropped or 0) > 20
					end

					if flag2 then
						v11.pickup = nil
					end

					return "Pick up the Adventurer's Hat"
				end

				local v12 = nil

				for _, child in ipairs(workspace.Enemies:GetChildren()) do
					local flag2 = child.Name == "Monkey"

					if flag2 then
						local name_ = localPlayer.Name
						flag2 = child:GetAttribute("LocalEnemy") == name_
					end

					if flag2 then
						v12 = child
						break
					else
						v12 = nil
					end
				end

				local humanoidRootPart = v12 and v12:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart and v11.landed then
					HiddenEvent.stallGrace = tick() + 5

					if HiddenGoTo(humanoidRootPart.Position + Vector3.new(0, 2, 4), 12) then
						HiddenHold(humanoidRootPart.CFrame * CFrame.new(0, 2, 4))
						EquipHiddenWeapon("Melee")

						if os.clock() - (HiddenEvent.lastHit or 0) >= 0.4 then
							HiddenEvent.lastHit = os.clock()
							HiddenModules.RegisterAttack:FireServer(0.3)
							HiddenModules.RegisterHit:FireServer(humanoidRootPart, { { v12, humanoidRootPart } })
						end
					end

					return "Catch the thieving monkey"
				end

				if not v11.footprints then
					return "Waiting for the monkey to steal the hat", true
				end
				local vector = Vector3.zero
				local n = 0

				for _, footprint in pairs(v11.footprints) do
					if typeof(footprint) == "CFrame" then
						vector += footprint.Position
						n += 1
					end
				end

				local position = n > 0 and vector / n or localPlayer.Character:GetPivot().Position
				local v13 = nil
				local v14 = nil

				for _, v15 in ipairs(game:GetService("CollectionService"):GetTagged("ValidMonkeyTree")) do
					local magnitude = (v15:GetPivot().Position - position).Magnitude

					if not v13 or magnitude < v13 then
						v13 = magnitude
						v14 = v15
					end
				end

				local v15 = ipairs
				local descendants = v14 and v14:GetDescendants() or {}
				local v16 = nil

				for _, descendant in v15(descendants) do
					if descendant.Name == "Leaves" and descendant:IsA("BasePart") and descendant:HasTag("M1HitRegistry") then
						if not v16 or (descendant.Position - position).Magnitude < (v16.Position - position).Magnitude then
							v16 = descendant
						end
					end
				end

				if v16 then
					if HiddenGoTo(v16.Position + Vector3.new(0, 0, 6), 10) then
						HiddenHold(CFrame.new(v16.Position + Vector3.new(0, 0, 6)))
						HitHiddenPart(v16)
					end

					return "Follow the footprints and shake the tree"
				end

				if v14 and HitHiddenTriggers({ v14 }) then
					return "Follow the footprints and shake the tree"
				end
				return "Follow the monkey footprints", true
			end,
		}

		tbl9[21] = {
			Island = "Underwater City",
			Name = "Fishman Karate",
			Run = function(arg)
				if arg:InvokeServer("Initialize") == true then
					arg:InvokeServer("Complete")
					HiddenEvent.checked = 0
					task.wait(2)
					return "Bend the light for the Water Kung Fu Teacher"
				end

				return "Waiting for the sealed door", true
			end,
		}

		tbl9[22] = {
			Island = "Underwater City",
			Name = "Beyond the Bubble",
			Run = function(arg)
				local v11 = FindHiddenEnemy({ "Evil Wraith" }, Vector3.new(61696, 532, -1420), 400)
				if v11 then
					KillHiddenEnemy(v11)
					return "Clear the evil from the cavern"
				end
				local v12 = game:GetService("CollectionService"):GetTagged("CursedChest")[1]

				if v12 then
					local isBasePart = v12:IsA("BasePart") and v12 or v12:FindFirstChildWhichIsA("BasePart", true)

					if isBasePart and HiddenSettle(isBasePart.Position + Vector3.new(0, 3, 0), 9) then
						arg:InvokeServer("OpenChest")
						HiddenEvent.checked = 0
						task.wait(2)
					end

					return "Open the cursed chest"
				end

				HiddenGoTo(Vector3.new(61696, 532, -1420), 30)
				return "Ride the bubble to the cavern", localPlayer:DistanceFromCharacter(Vector3.new(61696, 532, -1420)) < 40
			end,
		}

		tbl9[23] = {
			Island = "Magma Village",
			Name = "Evil Slimes",
			Run = function()
				local bonusMomentLocations = workspace.Map.Magma:FindFirstChild("BonusMoment_Locations")
				bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChild("SlimeGeyser")
				if not bonusMomentLocations then
					return "Waiting for the slime geyser", true
				end
				local position = bonusMomentLocations:GetPivot().Position
				local v11 = nil

				for _, child in ipairs(workspace.Enemies:GetChildren()) do
					if string.find(child.Name, "Slime") and IsHiddenTarget(child) and (child:GetPivot().Position - position).Magnitude < 400 then
						v11 = child
						break
					else
						v11 = nil
					end
				end

				if v11 then
					KillHiddenEnemy(v11)
					return "Defeat the Evil Slimes"
				end
				local tbl10 = {}

				for _, descendant in ipairs(bonusMomentLocations:GetDescendants()) do
					if descendant:IsA("BasePart") and descendant:HasTag("M1HitRegistry") then
						table.insert(tbl10, descendant)
					end
				end

				if #tbl10 == 0 then
					return "Waiting for the slime geyser", true
				end

				table.sort(tbl10, function(arg, arg2)
					return localPlayer:DistanceFromCharacter(arg.Position) < localPlayer:DistanceFromCharacter(arg2.Position)
				end)

				HitHiddenPart(tbl10[1])
				return "Smash the strange geyser"
			end,
		}

		tbl9[24] = {
			Island = "Sky",
			Name = "Unexpected Guest",
			RetryDelay = 600,
			Run = function(arg)
				local v11 = GetHiddenState("Unexpected Guest", function(arg2, arg3)
					if arg3 == "Cleared" then
						arg2.cleared = true
					elseif arg3 == "VaultGuards" or arg3 == "ArchOpen" then
						arg2.guards = true
					elseif arg3 == "AmbushCleared" then
						arg2.ambushCleared = true
					elseif arg3 == "VaultOpened" then
						arg2.vaultOpened = true
					elseif arg3 == "DoorSealed" or arg3 == "Occupants" then
						arg2.cleared = nil
						arg2.guards = nil
						arg2.ambushCleared = nil
						arg2.vaultOpened = nil
					end
				end)

				local skyCastle = workspace.Map.Sky:FindFirstChild("SkyCastle")
				if not skyCastle or not arg.Active then
					return "Waiting for strangers at the castle", true
				end
				local skyInterior = skyCastle:FindFirstChild("SkyInterior")
				local vault = skyInterior and skyInterior:FindFirstChild("Vault")

				if v11.vaultOpened then
					local angelicVaultChest = workspace:FindFirstChild("AngelicVaultChest")
					angelicVaultChest = angelicVaultChest and angelicVaultChest:GetPivot().Position or vault and vault:GetPivot().Position

					if angelicVaultChest and HiddenSettle(angelicVaultChest + Vector3.new(0, 3, 5), 10) then
						arg:InvokeServer("TakeChest")
						HiddenEvent.checked = 0
						task.wait(1.5)
					end

					return "Take the vault treasure"
				end

				local position = skyCastle:GetPivot().Position

				for _, child in ipairs(workspace.Enemies:GetChildren()) do
					if IsHiddenTarget(child) and (child:GetPivot().Position - position).Magnitude < 350 then
						KillHiddenEnemy(child)
						return "Clear out the castle intruders"
					end
				end

				if v11.code and v11.ambushCleared and vault then
					if HiddenSettle(vault:GetPivot().Position + Vector3.new(0, 3, 6), 12) then
						arg:InvokeServer("VaultCodes")
						arg:InvokeServer("TryCode", v11.code)
						task.wait(1.5)
					end

					return "Open the Angelic Vault (" .. v11.code .. ")"
				end

				skyInterior = skyInterior and skyInterior:FindFirstChild("Letter")

				if skyInterior and not v11.code then
					if HiddenSettle(skyInterior.Position + Vector3.new(0, 3, 3), 8) then
						local response = arg:InvokeServer("ReadLetter")
						v11.code = type(response) == "string" and response or nil
						task.wait(1)
					end

					return "Read the crumpled letter"
				end

				if v11.code and not v11.guards then
					arg:FireServer("CutsceneDone")
					arg:FireServer("GuardsOut")
					task.wait(2)
					return "Wait for the vault guards"
				end

				local secretDoor = skyCastle:FindFirstChild("SecretDoor")

				if secretDoor and v11.cleared then
					local n = 0
					local v12 = nil

					for _, descendant in ipairs(secretDoor:GetDescendants()) do
						if descendant:IsA("BasePart") and descendant.Size.X * descendant.Size.Y * descendant.Size.Z > n then
							n = descendant.Size.X * descendant.Size.Y * descendant.Size.Z
							v12 = descendant
						end
					end

					if v12 and HiddenSettle(v12.Position + Vector3.new(0, 0, 4), 10) then
						arg:FireServer("BreakDoor")
						task.wait(1.5)
					end

					return "Break the secret door"
				end

				HiddenGoTo(position + Vector3.new(0, 20, 0), 60)
				return "Search the castle", true
			end,
		}

		tbl9[25] = {
			Island = "Sky",
			Name = "The Clown's Jewels",
			RetryDelay = 600,
			Run = function(arg)
				local v11 = GetHiddenState("The Clown's Jewels", function(arg2, arg3, arg4, arg5)
					if arg3 == "CloudStruck" then
						arg2.chest = typeof(arg5) == "CFrame" and arg5.Position or nil
						arg2.provoked = nil
						arg2.ready = nil
					elseif arg3 == "Restore" then
						arg2.chest = typeof(arg4) == "CFrame" and arg4.Position or arg2.chest
					elseif arg3 == "ChestReady" then
						arg2.ready = typeof(arg4) == "CFrame" and arg4.Position or nil
					elseif arg3 == "Reset" or arg3 == "Setup" then
						arg2.chest = nil
						arg2.ready = nil
						arg2.provoked = nil
					end
				end)

				if v11.ready then
					if HiddenGoTo(v11.ready + Vector3.new(0, 3, 0), 4) then
						arg:FireServer("Collect")
						v11.ready = nil
						HiddenEvent.checked = 0
						task.wait(1)
					end

					return "Collect the Skylands treasure"
				end

				for _, v12 in ipairs(game:GetService("CollectionService"):GetTagged("ClownJewelsGuard")) do
					local name_ = localPlayer.Name
					if v12:GetAttribute("LocalEnemy") == name_ and IsHiddenTarget(v12) then
						KillHiddenEnemy(v12)
						return "Defeat the Sky Bandits"
					end
				end

				if v11.chest and localPlayer:DistanceFromCharacter(v11.chest) <= 25 then
					if workspace:FindFirstChild("ClownJewelsLockedChest") or workspace:FindFirstChild("ClownJewelsChest") then
						v11.missing = nil
					else
						v11.missing = v11.missing or tick()
						local missing = v11.missing

						if tick() - missing > 8 then
							v11.chest = nil
							v11.missing = nil
							v11.provoked = nil
						end
					end
				end

				if v11.chest then
					local flag = HiddenSettle(v11.chest + Vector3.new(0, 3, 6), 12)

					if flag then
						flag = tick() - (v11.provoked or 0) > 15
					end

					if flag then
						v11.provoked = tick()
						arg:FireServer("Provoke")
						task.wait(1)
						arg:FireServer("BeginFight")
					end

					return "Claim the chained chest"
				end

				if not arg.Active then
					return "The treasure clouds are quiet", true
				end
				local persistentParts = workspace._WorldOrigin:FindFirstChild("PersistentParts")
				local v12 = FindTaggedPartIn(persistentParts and persistentParts:FindFirstChild("ClownJewelsClouds"))
				if v12 then
					HitHiddenPart(v12)
					return "Break the treasure cloud"
				end
				return "Waiting for the treasure cloud", true
			end,
		}

		tbl9[26] = {
			Island = "Sky",
			Name = "Electric Fighting Teacher",
			Run = function()
				local v11 = GetChargedClouds()
				local electro = HiddenEvent.electro
				local flag = not electro
				local flag2

				if flag then
					flag2 = flag
				else
					local time_ = electro.time
					flag2 = tick() - time_ > 5
				end

				if flag2 then
					electro = { time = tick(), state = CommF:InvokeServer("ElectroQuestState") }
					HiddenEvent.electro = electro
				end

				local vector = GetNpcPosition("Mad Scientist") or Vector3.new(-4628.9, 12, -355.7)

				if electro.state == 4 then
					if HiddenSettle(vector + Vector3.new(0, 1.5, 4), 8) then
						if CommF:InvokeServer("DeliverLightningBolt") ~= 1 then
							CommF:InvokeServer("BuyElectro")
						end

						HiddenEvent.electro = nil
						HiddenEvent.checked = 0
						task.wait(1.5)
					end

					return "Bring the Lightning Bolt to the Mad Scientist"
				end

				if electro.state ~= 1 and electro.state ~= 2 then
					if HiddenSettle(vector + Vector3.new(0, 1.5, 4), 8) then
						CommF:InvokeServer("AcceptElectroQuest")
						HiddenEvent.electro = nil
						task.wait(1)
					end

					return "Ask the Mad Scientist about Electric"
				end

				for k, v12 in pairs(v11) do
					local M1HitRegistry = nil

					for _, v13 in ipairs(v12) do
						if v13.Parent and v13:HasTag("M1HitRegistry") then
							M1HitRegistry = v13
							break
						else
							M1HitRegistry = nil
						end
					end

					M1HitRegistry = M1HitRegistry or k.Parent and k:HasTag("M1HitRegistry") and k

					if M1HitRegistry then
						HitHiddenPart(M1HitRegistry)
						HiddenEvent.electro.time = tick() - 4
						return "Strike the charged storm cloud"
					end

					v11[k] = nil
				end

				HiddenGoTo(Vector3.new(-5025, 820, -640), 200)
				return "Look for a charged storm cloud", true
			end,
		}

		tbl9[27] = {
			Island = "Fountain",
			Name = "Fountain Pipe Repair",
			Run = function(arg)
				local fountainPipeRepairState = arg.MiscData._fountainPipeRepairState
				local fountainPipeNodes = workspace._WorldOrigin:FindFirstChild("FountainPipeNodes")
				if not fountainPipeRepairState or not fountainPipeNodes or not fountainPipeRepairState.pipes then
					return "Waiting for the fountain pipes", true
				end

				if not fountainPipeRepairState.fullyRepaired then
					for _, child in ipairs(fountainPipeNodes:GetChildren()) do
						local attribute = child:GetAttribute("FountainPipeRepairId")
						local v11 = attribute and fountainPipeRepairState.pipes[attribute]
						if v11 and v11.currentSteps ~= 0 then
							HitHiddenPart(child)
							return "Rotate " .. attribute .. " (" .. fountainPipeRepairState.repairedCount .. "/" .. fountainPipeRepairState.totalPipes .. ")"
						end
					end

					return "Waiting for the water to flow", true
				end

				local boat = fountainPipeRepairState.boat
				boat = boat and boat:FindFirstChild("FakeVehicleSeat")

				if boat and HiddenSettle(boat.Position + Vector3.new(0, 3, 0), 5) then
					arg:InvokeServer("TurnIn")
					HiddenEvent.checked = 0
					task.wait(3)
				end

				return "Launch the stuck ship"
			end,
		}

		tbl9[28] = {
			Island = "Colosseum",
			Name = "King's Apprentice",
			Run = function(arg)
				local vector = GetNpcPosition("Colosseum Emperor") or Vector3.new(-1846.5, 90, -3333.6)
				local kingSApprentice = workspace:FindFirstChild("King's Apprentice")

				if arg.Progress == 1 then
					if HiddenSettle(vector + Vector3.new(0, 1.5, 4), 8) then
						arg:FireServer("Report")
						task.wait(1.5)
						HiddenEvent.checked = 0
					end

					return "Report to the Emperor"
				end

				local v11 = kingSApprentice and FindHiddenEnemy({ "Gladiator", "Upgraded Gladiator", "Supreme Gladiator" }, kingSApprentice.StartMatchHitbox.Position, 250)
				if v11 then
					KillHiddenEnemy(v11)
					return "Defeat the gladiator waves"
				end

				if not arg.Active then
					if HiddenSettle(vector + Vector3.new(0, 1.5, 4), 8) then
						arg:FireServer("Interact")
						task.wait(1.5)
					end

					return "Accept the Emperor's challenge"
				end

				if kingSApprentice and HiddenSettle(kingSApprentice.StartMatchHitbox.Position + Vector3.new(0, 3, 0), 6) then
					if tick() - (HiddenEvent.matchStarted or 0) > 20 then
						HiddenEvent.matchStarted = tick()
						arg:FireServer("StartMatch")
					end
				end

				return "Step into the arena"
			end,
		}

		tbl9[29] = {
			Island = "Colosseum",
			Name = "Legendary Creator Statues",
			RetryDelay = 1800,
			Precheck = function()
				if not GetHiddenFruitM1() then
					local v11, v12 = EnsureHiddenFruit("Legendary Creator Statues")
					if not v11 then
						NotifyHiddenFruitM1("Legendary Creator Statues")
						return false, v12 or "needs an eaten Blox Fruit with M1 for the Fruit statue"
					end
				end

				return true
			end,
			Run = function()
				local podiumModels = workspace.Map.Colosseum:FindFirstChild("PodiumModels")
				if not podiumModels then
					return "Waiting for the statues", true
				end

				local v11 = GetHiddenState("Legendary Creator Statues", function(arg, arg2, arg3)
					if typeof(arg3) == "Instance" then
						arg3 = arg3.Name
					end

					if arg2 == "PodiumLit" then
						arg[arg3] = true
					elseif arg2 == "PodiumHit" then
						arg.seen = arg.seen or {}
						arg.seen[arg3] = (arg.seen[arg3] or 0) + 1
					elseif arg2 == "PodiumWrong" or arg2 == "Loaded" or arg2 == "Completed" then
						for _, v11 in ipairs({ "Melee", "Sword", "Fruit", "Gun" }) do
							arg[v11] = nil
						end

						arg.seen = nil
						arg.tries = nil
					end
				end)

				for _, v12 in ipairs({ "Sword", "Fruit", "Melee", "Gun" }) do
					local podiumTouchBox = podiumModels:FindFirstChild(v12)
					podiumTouchBox = podiumTouchBox and podiumTouchBox:FindFirstChild("PodiumTouchBox")

					if podiumTouchBox and not v11[v12] then
						if localPlayer:DistanceFromCharacter(podiumTouchBox.Position) > 12 then
							HiddenMove(podiumTouchBox.CFrame * CFrame.new(0, 3, 9))
						else
							if not HiddenSettle((podiumTouchBox.CFrame * CFrame.new(0, 3, 6)).Position, 10) then
								return "Go to the " .. v12 .. " statue"
							end

							if v12 == "Fruit" then
								if not GetHiddenFruitM1() then
									EnsureHiddenFruit("the Fruit statue")
								end

								if not GetHiddenFruitM1() or not EquipHiddenWeapon("Blox Fruit") then
									NotifyHiddenFruitM1("the Fruit statue")
									HiddenEvent.skipped["Legendary Creator Statues"] = tick() + 1800
									return "Need a Blox Fruit with M1 for the Fruit statue", true
								end

								UseHiddenSkillAt(podiumTouchBox)
							elseif v12 == "Gun" then
								if not ShootHiddenGunAt(podiumTouchBox) then
									return "Getting a gun for the Gun statue"
								end
							else
								if not EquipHiddenWeapon(v12) then
									return "Need a " .. v12 .. " weapon", true
								end

								if os.clock() - (HiddenEvent.lastHit or 0) >= 0.6 then
									HiddenEvent.lastHit = os.clock()
									HiddenModules.RegisterAttack:FireServer(0.3)
									HiddenModules.RegisterHit:FireServer(podiumTouchBox)
									v11.tries = v11.tries or {}
									v11.tries[v12] = (v11.tries[v12] or 0) + 1
									local flag = v11.tries[v12] >= 10

									if flag then
										flag = not (v11.seen and v11.seen[v12])
									end

									if flag then
										v11[v12] = true
									end
								end
							end
						end

						return "Power the " .. v12 .. " statue"
					end
				end

				HiddenEvent.checked = 0
				return "Waiting for the statues to answer", true
			end,
		}

		tbl9[30] = {
			Island = "Marine Fortress",
			Name = "Fortress Flagpole",
			Run = function(arg)
				local v11 = GetHiddenState("Fortress Flagpole", function(arg2, arg3, arg4, arg5, arg6, arg7)
					if arg3 == "Setup" then
						arg2.flag = typeof(arg4) == "CFrame" and arg4.Position or arg2.flag
						arg2.rope = typeof(arg5) == "CFrame" and arg5.Position or arg2.rope
						arg2.hasRope = arg7 == true
						arg2.time = tick()
					elseif arg3 == "Started" then
						arg2.rope = typeof(arg4) == "CFrame" and arg4.Position or arg2.rope
					elseif arg3 == "RopeTaken" then
						arg2.hasRope = true
					end
				end)

				local flag = not v11.time

				if not flag then
					local time_ = v11.time
					flag = tick() - time_ > 20
				end

				if flag then
					v11.time = tick()
					arg:FireServer("Init")
					task.wait(1.5)
					return "Check the flagpole"
				end

				if v11.hasRope and v11.flag then
					if HiddenSettle(v11.flag + Vector3.new(0, 3, 0), 3) then
						SetHiddenStep("Raise the flag and dodge the cannons")
						HoistHiddenFlag(arg, v11.flag + Vector3.new(0, 3, 0))
						v11.time = nil
					end

					return "Raise the flag and dodge the cannons"
				end

				if not arg.Active or not v11.rope then
					local Parlus = GetNpcPosition("Parlus")

					if Parlus and HiddenSettle(Parlus + Vector3.new(0, 1.5, 3), 8) then
						arg:FireServer("Start")
						task.wait(1.5)
					end

					return "Talk to Parlus"
				end

				if HiddenSettle(v11.rope + Vector3.new(0, 3, 0), 6) then
					arg:FireServer("TakeRope")
					task.wait(1.5)
					v11.time = nil
				end

				return "Take the hidden rope"
			end,
		}

		tbl9[31] = {
			Island = "Frozen Village",
			Name = "Breaking the Ice",
			Run = function()
				local iceberg = workspace:FindFirstChild("Iceberg")
				iceberg = iceberg and iceberg:FindFirstChild("IceRock")
				if not iceberg then
					return "Waiting for the frozen teacher", true
				end
				HitHiddenPart(iceberg)
				return "Break the ice around the Ability Teacher"
			end,
		}

		tbl9[32] = {
			Island = "Middle Town",
			Name = "Early Access",
			RetryDelay = 600,
			Run = function(arg)
				local earlyAccess = HiddenEvent.earlyAccess
				local flag = not earlyAccess

				if not flag then
					local time_ = earlyAccess.time
					flag = tick() - time_ > 8
				end

				if flag then
					earlyAccess = {
						time = tick(),
						available = arg:InvokeServer("IsAvailable") == true,
						stage = arg:InvokeServer("GetState"),
					}

					HiddenEvent.earlyAccess = earlyAccess
				end

				local n = tonumber(earlyAccess.stage) or 0

				local function fn(arg2, ...)
					if not HiddenSettle(arg2, 8) then
						return
					end

					for _, v11 in ipairs({ ... }) do
						local response, v12 = arg:InvokeServer(v11)

						if type(v12) == "number" then
							earlyAccess.stage = v12
						end

						task.wait(0.5)
					end

					earlyAccess.time = 0
				end

				local robotmegaSuperfan = workspace.NPCs:FindFirstChild("robotmega superfan")
				robotmegaSuperfan = robotmegaSuperfan and robotmegaSuperfan:GetPivot().Position + Vector3.new(0, 1.5, 3) or Vector3.new(-1044.5, 26, 1683)

				if n == 0 then
					if not earlyAccess.available then
						return "DevBros are not visiting Middle Town now", true
					end
					fn(robotmegaSuperfan, "InteractQuestGiver", "AcceptQuest")
					return "Talk to robotmega superfan"
				end

				if n == 1 then
					local earlyAccessBonusMomentAssets = workspace._WorldOrigin:FindFirstChild("EarlyAccessBonusMomentAssets")
					earlyAccessBonusMomentAssets = earlyAccessBonusMomentAssets and earlyAccessBonusMomentAssets:FindFirstChild("KeySpot")
					fn(earlyAccessBonusMomentAssets and earlyAccessBonusMomentAssets.Position + Vector3.new(0, 3, 0) or Vector3.new(-1052, 13, 1781), "CollectKey")
					return "Find the Rear Door Key"
				end

				if n == 2 then
					fn(Vector3.new(-1091.8, 14, 1806), "InteractMansionDoor")
					return "Open the rear door"
				end

				if n == 3 then
					HiddenEvent.infiltration = HiddenEvent.infiltration or tick()
					local infiltration = HiddenEvent.infiltration

					if tick() - infiltration > 9 then
						HiddenEvent.infiltration = nil
						fn(localPlayer.Character:GetPivot().Position, "FinishInfiltration")
					end

					return "Sneak into the dev room"
				end

				if n == 4 then
					fn(robotmegaSuperfan, "InteractQuestGiver", "ClaimReward")
					return "Report to robotmega superfan"
				end
				return "Waiting for Early Access", true
			end,
		}

		tbl9[33] = {
			Island = "Middle Town",
			Name = "Lookout",
			RetryDelay = 1200,
			Run = function(arg)
				local lookout = HiddenEvent.lookout
				local flag = not lookout

				if not flag then
					local time_ = lookout.time
					flag = tick() - time_ > 10
				end

				if flag then
					local response = arg:InvokeServer("GetProgress")
					lookout = { time = tick(), progress = type(response) == "table" and response or nil }
					HiddenEvent.lookout = lookout
				end

				local progress = lookout.progress
				if not progress then
					return "Waiting for Experienced Captain", true
				end

				if progress.Unlocked then
					local experiencedCaptain = workspace.NPCs:FindFirstChild("Experienced Captain")
					if experiencedCaptain and HiddenSettle(experiencedCaptain:GetPivot().Position + Vector3.new(0, 1.5, 4), 10) then
						HiddenEvent.lookout = nil
						return RunHiddenLookout(arg)
					end
					return "Go to the Experienced Captain for lookout duty"
				end

				if (progress.SecondsRemaining or 0) > 0 then
					local time_ = lookout.time
					local n = progress.SecondsRemaining - tick() - time_

					if n > 300 then
						HiddenEvent.retryOverride = HiddenEvent.retryOverride or {}
						HiddenEvent.retryOverride.Lookout = n - 60
					end

					return "Captain needs time (" .. FormatMagnetTime(math.max(0, n)) .. ")", n > 300
				end

				local experiencedCaptain = workspace.NPCs:FindFirstChild("Experienced Captain")

				if experiencedCaptain and HiddenSettle(experiencedCaptain:GetPivot().Position + Vector3.new(0, 1.5, 4), 10) then
					arg:InvokeServer("AdvanceIntroduction")
					HiddenEvent.lookout = nil
					task.wait(1)
				end

				return "Talk to Experienced Captain (" .. (progress.IntroVisits or 0) .. "/3)"
			end,
		}

		tbl9[34] = {
			Island = "Middle Town",
			Name = "X Marks The Spot",
			Run = function(arg)
				local v11 = GetHiddenState("X Marks The Spot", function(arg2, arg3, stage, arg4, arg5, arg6, arg7)
					if arg3 == "State" then
						arg2.stage = stage
						arg2.target = typeof(arg4) == "CFrame" and arg4.Position or nil
						arg2.piece = typeof(arg7) == "CFrame" and arg7.Position or nil
					elseif arg3 == "Setup" or arg3 == "MapDropped" then
						stage = arg3 == "Setup" and stage or arg4
						arg2.pickup = typeof(stage) == "CFrame" and stage.Position or arg2.pickup
					end
				end)

				local flag = not v11.stage

				if not flag then
					flag = tick() - (v11.initialized or 0) > 60
				end

				if flag then
					v11.initialized = tick()
					arg:FireServer("Initialize")
					task.wait(1.5)
					return "Read treasure map state"
				end

				if v11.stage == "Tree" then
					local v12 = FindTaggedPartIn(workspace.Map:FindFirstChild("Town"))

					if v12 then
						HitHiddenPart(v12)
					end

					return "Shake the tree for the map"
				end

				if v11.stage == "Pickup" and v11.pickup then
					if HiddenSettle(v11.pickup + Vector3.new(0, 2, 0), 6) then
						arg:FireServer("PickupMap")
						task.wait(1.5)
					end

					return "Pick up Treasure Map"
				end

				if v11.stage == "Map" and v11.piece then
					if HiddenSettle(v11.piece + Vector3.new(0, 2, 0), 6) then
						arg:FireServer("CollectCheckpoint")
						task.wait(1.5)
					end

					return "Collect broken map piece"
				end

				if v11.stage == "Dig" and v11.target then
					local v12 = FindTaggedPartNear(v11.target, 4)

					if v12 then
						HitHiddenPart(v12)
					else
						HiddenGoTo(v11.target + Vector3.new(0, 3, 5), 6)
					end

					return "Dig at the X"
				end

				if v11.stage == "Chest" then
					local persistentParts = workspace._WorldOrigin:FindFirstChild("PersistentParts")
					persistentParts = persistentParts and persistentParts:FindFirstChild("Buried Treasure")
					local openPrompt = persistentParts and persistentParts:FindFirstChild("OpenPrompt", true)

					if openPrompt and HiddenSettle(openPrompt.Parent.Position + Vector3.new(0, 2, 3), 6) then
						fireproximityprompt(openPrompt)
						task.wait(1.5)
					end

					return "Open Buried Treasure"
				end

				if v11.stage == "Enemies" then
					local v12 = FindHiddenEnemy({ "Desert Skeleton" }, v11.target or localPlayer.Character:GetPivot().Position, 300)

					if v12 then
						KillHiddenEnemy(v12)
					end

					return "Defeat treasure guards"
				end

				return "Waiting for treasure", true
			end,
		}

		tbl9[35] = {
			Island = "Pirate Village",
			Name = "Windmill Maintenance",
			Run = function()
				local windmillRig = workspace.Map.Pirate:FindFirstChild("WindmillRig")
				windmillRig = windmillRig and windmillRig:FindFirstChild("Windmill_rig")
				if not windmillRig then
					return "Waiting for windmill", true
				end

				if not EquipHiddenWeapon("Sword") then
					return "Need a sword to cut the ropes", true
				end

				if not HiddenEvent.windmill then
					HiddenEvent.windmill = { cut = {} }

					HiddenEvent.windmill.connection = ListenHiddenMoment("Windmill Maintenance", function(arg, arg2)
						if arg == "RopeCut" then
							HiddenEvent.windmill.cut[arg2] = true
						end
					end)
				end

				for i_ = 1, 5 do
					local v11 = windmillRig:FindFirstChild("Rope" .. i_ .. "A")

					if v11 and not HiddenEvent.windmill.cut["Rope" .. i_] and v11.Transparency < 1 then
						if localPlayer:DistanceFromCharacter(v11.Position) > 12 then
							HiddenMove(v11.CFrame * CFrame.new(0, 0, 5))
						elseif os.clock() - (HiddenEvent.lastHit or 0) >= 0.6 then
							HiddenEvent.lastHit = os.clock()
							HiddenModules.RegisterAttack:FireServer(0.3)
							HiddenModules.RegisterHit:FireServer(v11)
						end

						return "Cut windmill rope " .. i_ .. "/5"
					end
				end

				return "Waiting for windmill to spin", true
			end,
		}

		tbl9[36] = {
			Island = "Jungle",
			Name = "Zipline Repair",
			Run = function(arg)
				local zipline = HiddenEvent.zipline
				local flag = not zipline

				if not flag then
					local time_ = zipline.time
					flag = tick() - time_ > 30
				end

				if flag then
					local v11 = nil

					v11 = ListenHiddenMoment("Zipline Repair", function(arg2, arg3, arg4, arg5, arg6, arg7, arg8)
						if arg2 == "Setup" and typeof(arg3) == "CFrame" then
							HiddenEvent.zipline = { time = tick(), pickup = arg3.Position, target = arg7, source = arg8 }
							v11:Disconnect()
						end
					end)

					arg:FireServer("Initialize")
					task.wait(2)

					if v11.Connected then
						v11:Disconnect()
					end

					return "Locate grappling hook"
				end

				local character = localPlayer.Character
				local grapplingHook = character:FindFirstChild("Grappling Hook") or localPlayer.Backpack:FindFirstChild("Grappling Hook")

				if not grapplingHook then
					if HiddenSettle(zipline.pickup + Vector3.new(0, 2, 0), 6) then
						arg:FireServer("PickupTool")
						task.wait(1.5)
					end

					return "Pick up grappling hook"
				end

				if HiddenSettle(zipline.source + Vector3.new(0, 4, 0), 6) then
					if grapplingHook.Parent ~= character then
						character.Humanoid:EquipTool(grapplingHook)
						task.wait(0.5)
					end

					local position = character.HumanoidRootPart.Position
					local target = zipline.target
					local v11 = require(ReplicatedStorage.Util.Trajectory).getArcAim(position, target)
					arg:InvokeServer("Throw", "Grappling Hook", v11)
					HiddenEvent.checked = 0
					task.wait(2)
				end

				return "Throw hook to the zipline"
			end,
		}

		tbl9[37] = {
			Island = "Desert",
			Name = "Archaeologist's Tablet",
			Run = function()
				local archaeologistSTablet = workspace:FindFirstChild("Archaeologist's Tablet")
				if not archaeologistSTablet then
					return "Waiting for tablet", true
				end

				for _, child in ipairs(archaeologistSTablet.Pillars:GetChildren()) do
					local attribute = child:GetAttribute("NumHits") or 0
					if attribute < 3 then
						HitHiddenPart(child:FindFirstChild("SandLayer" .. attribute + 1) or child.SandLayer3)
						return "Clear sand " .. child.Name .. " (" .. attribute .. "/3)"
					end
				end

				return "Waiting for completion", true
			end,
		}

		tbl9[38] = {
			Island = "Desert",
			Name = "Rescue Hasan",
			RetryDelay = 600,
			Run = function(arg)
				local hasan = workspace.NPCs:FindFirstChild("Hasan")
				local position = hasan and hasan:GetPivot().Position or Vector3.new(1308, 23, 4492)

				if (arg.Progress or 0) >= 1 then
					hasan = hasan and HiddenSettle(position + Vector3.new(0, 1.5, 4), 10)

					if hasan then
						arg:FireServer("Interact")
						HiddenEvent.checked = 0
						task.wait(1.5)
					end

					return "Talk to Hasan"
				end

				local v11 = FindHiddenEnemy({ "Desert Skeleton" }, Vector3.new(1300, 15, 4460), 250)

				if v11 then
					HiddenEvent.farmHeight = 25
					KillHiddenEnemy(v11)
					HiddenEvent.farmHeight = nil
					HiddenEvent.hasanTries = 0
					HiddenEvent.waveStarted = tick()
					return "Kill Desert Skeleton"
				end

				local rescueHasan = workspace:FindFirstChild("Rescue Hasan")
				rescueHasan = rescueHasan and rescueHasan:FindFirstChild("CutsceneTrigger")
				if not rescueHasan then
					return "Waiting for the pyramid scene", true
				end

				if tick() - (HiddenEvent.hasanHelped or 0) < 90 then
					HiddenEvent.stallGrace = tick() + 20
					return "Waiting for Hasan's skeletons to come out of the coffins"
				end
				local flag = (HiddenEvent.hasanTries or 0) >= 2
				local flag2

				if flag then
					flag2 = (HiddenEvent.hasanTries or 0) < 4
				else
					flag2 = flag
				end

				if flag2 and hasan then
					if HiddenSettle(position + Vector3.new(0, 1.5, 4), 10) then
						arg:FireServer("Interact")
						HiddenEvent.checked = 0
						HiddenEvent.hasanTries = (HiddenEvent.hasanTries or 0) + 1
						task.wait(1.5)
					end

					return "Talk to Hasan to claim the reward"
				end

				if (HiddenEvent.hasanTries or 0) >= 4 then
					HiddenEvent.hasanTries = 0
					HiddenEvent.skipped["Rescue Hasan"] = tick() + 600
					HiddenEvent.waiting["Rescue Hasan"] = "Hasan's intro did not start"
					HiddenEvent.current = nil
					return "Hasan's intro did not start, trying again later", true
				end

				if not HiddenEvent.hasanEntering then
					if not HiddenSettle(rescueHasan.Position + Vector3.new(0, 5, 38), 8) then
						return "Go to the pyramid entrance"
					end
					HiddenRelease()
					StopTweenNow()
					task.wait(1.5)
					HiddenEvent.hasanEntering = tick()
					localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(rescueHasan.Position + Vector3.new(0, 4, 0))
				end

				HiddenEvent.stallGrace = tick() + 30
				local v12 = RunHiddenDialogue({ "Help Hasan" }, 14)
				HiddenEvent.hasanEntering = nil

				if v12 then
					HiddenEvent.hasanHelped = tick()
					HiddenEvent.hasanTries = 0
					return "Help Hasan"
				end

				HiddenEvent.hasanTries = (HiddenEvent.hasanTries or 0) + 1
				return "Walk into the pyramid again"
			end,
		}

		tbl9[39] = {
			Island = "Desert",
			Name = "Prickly Harvest",
			Requires = "Sea1/Desert/Rescue Hasan",
			RetryDelay = 900,
			Run = function(arg)
				local desertMerchant = workspace.NPCs:FindFirstChild("Desert Merchant")
				local flag = arg:InvokeServer("TurnInReady") == true

				if flag or not HiddenEvent.cactusStarted then
					if desertMerchant and HiddenSettle(desertMerchant:GetPivot().Position + Vector3.new(0, 1.5, 4), 10) then
						local response = arg:InvokeServer("Interact")
						HiddenEvent.cactusStarted = response == "StartQuest" or response == "InProgress"
						if response == "Unavailable" then
							return "Cacti not blooming yet", true
						end
					end

					return flag and "Turn in Cactus Petals" or "Talk to Desert Merchant"
				end

				local huge = math.huge
				local v11 = nil

				for _, child in ipairs(workspace.Map.Desert.Cacti:GetChildren()) do
					local trunk = child:FindFirstChild("Trunk")

					if trunk and trunk:HasTag("M1HitRegistry") then
						local v12 = localPlayer:DistanceFromCharacter(trunk.Position)

						if v12 < huge then
							huge = v12
							v11 = trunk
						end
					end
				end

				if v11 then
					HitHiddenPart(v11)
					return "Harvest cactus"
				end
				return "Waiting for cacti", true
			end,
		}

		HiddenQuests = tbl9
	end

	HiddenAnnouncements = {
		{ "pirate sails", "Battle Plans" },
		{ "drilling", "Magma Ore Extraction" },
		{ "bananas", "Banana Tree" },
		{ "curious smell", "Chef's Kiss" },
		{ "rumbling echoes", "One Last Eruption" },
		{ "dark energy", "Frozen Defense" },
		{ "alarm has sounded", "Fortress Under Fire" },
		{ "bell shimmers", "Echoes Through the Clouds" },
		{ "skyland castle", "Unexpected Guest" },
		{ "sewer", "Sewer Gangs" },
		{ "clouds", "The Clown's Jewels" },
		{ "cell", "Lever Jailbreak" },
		{ "tavern", "Tavern Brawl" },
		{ "snow heavily", "Snowman" },
		{ "stands are filling", "Crowd Favorite" },
		{ "crowd wants a show", "Crowd Favorite" },
		{ "storm brews", "The Tyrant Awakens" },
		{ "invaded skylands", "Unexpected Guest" },
		{ "water is stirring", "Pearl of the Deep" },
		{ "fishman lord has risen", "Pearl of the Deep" },
		{ "junkyard", "Fountain Wire Repair" },
		{ "magnetized", "Fountain Wire Repair" },
		{ "military weaponry", "Fortress Under Fire" },
		{ "loud drilling", "Magma Ore Extraction" },
		{ "overflowing with bananas", "Banana Tree" },
		{ "pirate sails", "Battle Plans" },
		{ "fleet will be", "Battle Plans" },
		{ "lookouts have spotted", "Battle Plans" },
		{ "roar of excitement", "Crowd Favorite" },
		{ "light of a full moon", "Sewer Gangs" },
		{ "secret cloud", "The Clown's Jewels" },
		{ "skylands castle", "Unexpected Guest" },
	}

	HiddenAnnounceDriven = {}

	for _, v6 in ipairs(HiddenAnnouncements) do
		HiddenAnnounceDriven[v6[2]] = true
	end

	HiddenRemoteChecks = {
		["Crowd Favorite"] = function()
			return workspace:FindFirstChild("Ring") ~= nil
		end,
		["Archaeologist's Tablet"] = function()
			return workspace:FindFirstChild("Archaeologist's Tablet") ~= nil
		end,
		["Breaking the Ice"] = function()
			local iceberg = workspace:FindFirstChild("Iceberg")
			return iceberg ~= nil and iceberg:FindFirstChild("IceRock") ~= nil
		end,
		["Rescue Hasan"] = function()
			local rescueHasan = workspace:FindFirstChild("Rescue Hasan")
			return rescueHasan ~= nil and rescueHasan:FindFirstChild("CutsceneTrigger") ~= nil
		end,
		["Battle Plans"] = function()
			local v6 = GetHiddenIsland("Marine Fortress")
			return v6 ~= nil and #ListHiddenRaidShips(v6.World.Position) > 0
		end,
	}

	for _, v6 in ipairs(HiddenQuests) do
		if v6.BossNames and not HiddenRemoteChecks[v6.Name] then
			local bossNames = v6.BossNames

			HiddenRemoteChecks[v6.Name] = function()
				return FindAwakenedBoss(nil, bossNames) ~= nil
			end
		end
	end

	SweepHiddenRemote = function(arg)
		if tick() - (HiddenEvent.remoteSweep or 0) < 5 then
			return
		end
		HiddenEvent.remoteSweep = tick()
		HiddenEvent.remoteSeen = HiddenEvent.remoteSeen or {}

		for _, v6 in ipairs(HiddenQuests) do
			local v7 = HiddenRemoteChecks[v6.Name]

			if v7 and arg["Sea1/" .. v6.Island .. "/" .. v6.Name] ~= true then
				local ok, result = pcall(v7)

				if ok and result then
					if not HiddenEvent.remoteSeen[v6.Name] then
						HiddenEvent.remoteSeen[v6.Name] = true
						HiddenEvent.skipped[v6.Name] = nil
						HiddenEvent.announced = HiddenEvent.announced or {}
						HiddenEvent.announced[v6.Name] = tick()
						HiddenNotify(v6.Name .. " is up (seen from afar), heading there", v6.Name .. "remote", "found")
					end
				else
					HiddenEvent.remoteSeen[v6.Name] = nil
				end
			end
		end
	end

	HiddenPresenceQuests = {
		["Battle Plans"] = "Marine Fortress",
		["Magma Ore Extraction"] = "Magma Village",
		["Crowd Favorite"] = "Colosseum",
		["Unexpected Guest"] = "Sky",
		["The Clown's Jewels"] = "Sky",
		Snowman = "Frozen Village",
		["Prickly Harvest"] = "Desert",
		["The Thieving Monkey"] = "Jungle",
		["Tavern Brawl"] = "Pirate Village",
		["Sewer Gangs"] = "Fountain",
	}

	NearestHiddenSpawn = function(arg)
		local playerSpawns = workspace._WorldOrigin:FindFirstChild("PlayerSpawns")
		local v6, v7, v8 = ipairs(playerSpawns and playerSpawns:GetDescendants() or {})
		local v9 = nil
		local v10 = nil

		for _, v11 in v6, v7, v8 do
			if v11:IsA("BasePart") then
				local magnitude = (v11.Position - arg).Magnitude

				if not v9 or magnitude < v9 then
					v9 = magnitude
					v10 = v11
				end
			end
		end

		return v10 and v10.Position + Vector3.new(0, 4, 0), v9
	end

	PickHiddenParkSpot = function(arg)
		local tbl9 = {}

		for _, v6 in ipairs(HiddenQuests) do
			local island = HiddenPresenceQuests[v6.Name] and v6.Island

			if island and arg["Sea1/" .. v6.Island .. "/" .. v6.Name] ~= true and (not v6.Requires or arg[v6.Requires] == true) and not table.find(tbl9, island) then
				table.insert(tbl9, island)
			end
		end

		local park = HiddenEvent.park
		local flag

		if park then
			flag = not table.find(tbl9, park.island)

			if not flag then
				local since = park.since
				flag = tick() - since > 900
			end
		else
			flag = park
		end

		if flag then
			local n = (table.find(tbl9, park.island) or 0) % math.max(#tbl9, 1) + 1
			park = tbl9[n] and { island = tbl9[n], since = tick() } or nil
		elseif not park and #tbl9 > 0 then
			park = { island = tbl9[1], since = tick() }
		end

		HiddenEvent.park = park

		if park then
			local v6 = GetHiddenIsland(park.island)

			if v6 then
				local v7, v8 = NearestHiddenSpawn(v6.World.Position)
				if v7 and v8 < 2500 then
					return v7
				end
				return v6.TeleportPoints[1].Position + Vector3.new(0, 4, 0)
			end
		end

		return NearestHiddenSpawn(localPlayer.Character:GetPivot().Position) or Vector3.new(-826, 30, 1613)
	end

	HiddenSkipFile = "Vxeze Hub/hidden_skip.json"

	SaveHiddenSkip = function()
		if type(writefile) ~= "function" then
			return
		end
		local tbl9 = { user = localPlayer.UserId, skips = {} }

		for k, v6 in pairs(HiddenEvent.skipped) do
			if type(k) == "string" and not k:find("^Reward:") and v6 > tick() then
				local floor = math.floor
				tbl9.skips[k] = os.time() + floor(v6 - tick())
			end
		end

		pcall(function()
			writefile(HiddenSkipFile, game:GetService("HttpService"):JSONEncode(tbl9))
		end)
	end

	LoadHiddenSkip = function()
		if HiddenEvent.skipLoaded then
			return
		end
		HiddenEvent.skipLoaded = true

		pcall(function()
			if type(isfile) == "function" and isfile(HiddenSkipFile) then
				local data = game:GetService("HttpService"):JSONDecode(readfile(HiddenSkipFile))

				if data.user == localPlayer.UserId then
					local v6 = pairs
					local skips = data.skips or {}

					for k, skip in v6(skips) do
						local n = skip - os.time()

						if n > 0 and not HiddenEvent.skipped[k] then
							HiddenEvent.skipped[k] = tick() + n
						end
					end
				end
			end
		end)
	end

	HiddenRetryDelay = function(arg)
		local retryOverride = HiddenEvent.retryOverride and HiddenEvent.retryOverride[arg.Name]
		if retryOverride then
			HiddenEvent.retryOverride[arg.Name] = nil
			return math.max(retryOverride, 120)
		end
		local retryDelay = arg.RetryDelay or 420
		if HiddenAnnounceDriven[arg.Name] then
			return math.max(retryDelay, 3600)
		end
		return retryDelay
	end

	OnHiddenAnnouncement = function(arg)
		local v6 = string.lower(tostring(arg))

		for _, v7 in ipairs(HiddenAnnouncements) do
			if string.find(v6, v7[1], 1, true) then
				HiddenEvent.announced = HiddenEvent.announced or {}
				HiddenEvent.announced[v7[2]] = tick()
				HiddenEvent.skipped[v7[2]] = nil
			end
		end
	end

	WatchHiddenAnnouncements = function()
		if HiddenEvent.watching then
			return
		end
		HiddenEvent.watching = true
		HiddenEvent.momentEvent = {}

		ReplicatedStorage.Remotes.BonusMomentsRemoteEvent.OnClientEvent:Connect(function(arg)
			HiddenEvent.momentEvent[tostring(arg)] = tick()
		end)

		local notifications = localPlayer.PlayerGui:WaitForChild("Notifications", 10)

		if notifications then
			notifications.DescendantAdded:Connect(function(descendant)
				if descendant:IsA("TextLabel") then
					task.wait(0.1)
					OnHiddenAnnouncement(descendant.Text)
				end
			end)
		end

		pcall(function()
			game:GetService("TextChatService").MessageReceived:Connect(function(arg)
				if not arg.TextSource then
					OnHiddenAnnouncement(arg.Text)
				end
			end)
		end)
	end

	CheckHiddenStall = function()
		local current = HiddenEvent.current
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not current or not humanoidRootPart then
			HiddenEvent.stall = nil
			return
		end
		local stall = HiddenEvent.stall
		local position = humanoidRootPart.Position
		local parent = not stall or stall.quest ~= current or stall.step ~= HiddenEvent.step or (position - stall.position).Magnitude > 25 or HiddenEvent.fighting and HiddenEvent.fighting.Parent

		if not parent then
			parent = tick() < (HiddenEvent.stallGrace or 0)
		end

		local flag

		if parent then
			flag = parent
		else
			flag = tick() - (HiddenEvent.momentEvent and HiddenEvent.momentEvent[current] or 0) < 20
		end

		local flag2

		if flag then
			flag2 = flag
		else
			flag2 = tick() - (HiddenEvent.announced and HiddenEvent.announced[current] or 0) < 420
		end

		if flag2 then
			HiddenEvent.stall = { quest = current, step = HiddenEvent.step, position = position, time = tick() }
			return
		end

		if os.date("!*t").min < 8 and string.find(tostring(HiddenEvent.step), "awaken", 1, true) then
			return
		end
		local time_ = stall.time
		if tick() - time_ < 60 then
			return
		end
		HiddenEvent.stall = nil
		HiddenEvent.skipped[current] = tick() + 120
		HiddenEvent.current = nil
		HiddenEvent.arrived = nil
		HiddenEvent.islandArrived = nil
		HiddenEvent.waitingSince = nil
		LeaveHiddenCannon()
		pcall(require(ReplicatedStorage.DialogueController).close)
		HiddenNotify(current .. " got stuck on \"" .. tostring(stall.step) .. "\", trying another quest", current .. "stall", "warning")
	end

	AutoHiddenEvent = function()
		WatchHiddenAnnouncements()
		LoadHiddenSkip()
		local v6 = GetHiddenProgress()
		SweepHiddenRemote(v6)
		if ClaimHiddenReward() then
			return
		end
		local v7 = GetHiddenRaidHint()
		local flag = v7.State == "Arming" or v7.State == "Armed" or v7.State == "Triggered"

		if not flag then
			flag = (tonumber(v7.Seconds) or math.huge) < 300
		end

		local flag2 = v7.State ~= "Triggered"

		if flag2 then
			flag2 = (tonumber(v7.Seconds) or 0) > 180
		end

		local tbl9 = {}
		local tbl10 = {}
		local tbl11 = {}

		for k, v8 in pairs(v6) do
			local flag3 = v8 == true and string.match(k, "^Sea1/([^/]+)/")

			if flag3 then
				tbl11[flag3] = (tbl11[flag3] or 0) + 1
			end
		end

		for _, v8 in ipairs(HiddenQuests) do
			local active = GetHiddenMoment(v8.Name)
			local flag3 = v8.Name == "Rescue Hasan" and active

			if flag3 then
				flag3 = tick() - (HiddenEvent.hasanHelped or 0) < 150
			end

			if flag3 then
				tbl10[v8] = -2
				HiddenEvent.skipped[v8.Name] = nil
			else
				local hintIsland = v8.HintIsland

				if hintIsland then
					active = active and active.Active

					if active then
						local name_ = v8.Name
						hintIsland = not GetHiddenBossHour().checked[name_]
					else
						hintIsland = active
					end

					hintIsland = hintIsland or flag and not flag2 and IsHiddenBossHinted(v7, v8.HintIsland, v8.BossNames)
				end

				if hintIsland then
					tbl10[v8] = -1
					HiddenEvent.skipped[v8.Name] = nil
				elseif tick() - ((HiddenEvent.announced or {})[v8.Name] or 0) < 600 then
					tbl10[v8] = -0.5
				elseif v8.Name == HiddenEvent.current then
					tbl10[v8] = 0
				else
					local n = GetHiddenIsland(v8.Island)
					n = n and localPlayer:DistanceFromCharacter(n.World.Position) or 1000000

					if v8.Island == HiddenEvent.currentIsland then
						n *= 0.0001
					end

					tbl10[v8] = 1 + math.max(n - (tbl11[v8.Island] or 0) * 4000, 0)
				end
			end

			table.insert(tbl9, v8)
		end

		table.sort(tbl9, function(arg, arg2)
			return tbl10[arg] < tbl10[arg2]
		end)

		HiddenEvent.waiting = HiddenEvent.waiting or {}
		local n = 0

		for _, v8 in ipairs(tbl9) do
			local str2 = "Sea1/" .. v8.Island .. "/" .. v8.Name

			if v6[str2] ~= true then
				n += 1
			end

			local flag3 = v6[str2] ~= true and (not v8.Requires or v6[v8.Requires] == true)

			if flag3 then
				flag3 = tick() >= (HiddenEvent.skipped[v8.Name] or 0)
			end

			if flag3 then
				flag3 = not (tick() < (HiddenEvent.prepUntil or 0) and tbl10[v8] >= 1)
			end

			if flag3 then
				local v9 = GetHiddenMoment(v8.Name)
				local v10 = HiddenRemoteChecks[v8.Name]
				local flag4 = v10 and HiddenPresenceQuests[v8.Name] and not v8.HintIsland and not v9

				if flag4 then
					flag4 = tick() - ((HiddenEvent.announced or {})[v8.Name] or 0) > 900
				end

				if flag4 then
					local flag5 = v8.Name == "Rescue Hasan"

					if flag5 then
						flag5 = tick() - (HiddenEvent.hasanHelped or 0) < 150
					end

					flag4 = not flag5
				end

				local flag5 = true
				local awakenedBossQuests = nil

				if flag4 then
					local ok, result = pcall(v10)
					ok = ok and not result
					awakenedBossQuests = nil

					if ok then
						flag5 = false
						awakenedBossQuests = "not up yet (checked from afar)"
					end
				end

				if flag5 and v8.Precheck and (not v9 or v8.HintIsland and not v9.Active) then
					flag5, awakenedBossQuests = v8.Precheck(v7)
				end

				if not flag5 then
					if HiddenEvent.waiting[v8.Name] ~= awakenedBossQuests then
						if v8.HintIsland then
							HiddenNotify("Awakened boss quests: " .. awakenedBossQuests, "bosshint", "found")
						else
							HiddenNotify(v8.Name .. ": " .. awakenedBossQuests, v8.Name .. awakenedBossQuests)
						end
					end

					HiddenEvent.waiting[v8.Name] = awakenedBossQuests
					HiddenEvent.skipped[v8.Name] = tick() + 30
					continue
				end

				if HiddenEvent.current ~= v8.Name then
					HiddenEvent.current = v8.Name
					HiddenEvent.currentIsland = v8.Island
					HiddenEvent.waitingSince = nil
					HiddenEvent.arrived = nil
					HiddenEvent.islandArrived = nil
					HiddenNotify("Start " .. v8.Name .. " (" .. v8.Island .. ")", v8.Name, "start")
				end

				HiddenEvent.idleSince = nil
				local flag6 = not v9

				if flag6 and v8.BossNames then
					for _, child in ipairs(workspace.Enemies:GetChildren()) do
						if child:GetAttribute("BossIndicatorAwakened") and IsHiddenTarget(child) then
							for _, bossName in ipairs(v8.BossNames) do
								if string.find(child.Name, bossName, 1, true) and localPlayer:DistanceFromCharacter(child:GetPivot().Position) < 2500 then
									SetHiddenStep("Defeat the awakened " .. child.Name)
									KillHiddenEnemy(child)
									HiddenEvent.checked = 0
									return
								end
							end
						end
					end
				end

				if flag6 and v8.NoMoment then
					local v11 = v8.NoMoment()
					if v11 then
						SetHiddenStep(v11)
						return
					end
				end

				if flag6 then
					if HiddenGoToIsland(v8.Island) then
						HiddenEvent.islandArrived = HiddenEvent.islandArrived or tick()
						local islandArrived = HiddenEvent.islandArrived

						if tick() - islandArrived > 8 then
							HiddenEvent.islandArrived = nil

							if v8.HintIsland then
								local name_ = v8.Name
								GetHiddenBossHour().checked[name_] = true
							end

							HiddenEvent.skipped[v8.Name] = math.max(HiddenEvent.skipped[v8.Name] or 0, tick() + HiddenRetryDelay(v8))
							SaveHiddenSkip()
							HiddenEvent.waiting[v8.Name] = v8.Name .. " is not happening on " .. v8.Island
							HiddenEvent.current = nil
							HiddenNotify(HiddenEvent.waiting[v8.Name] .. " yet, checking again later", v8.Name .. "notloaded", "warning")
						end
					else
						HiddenEvent.islandArrived = nil
					end

					return
				end

				HiddenEvent.islandArrived = nil
				local v11, v12 = v8.Run(v9)
				SetHiddenStep(v11 or "Working")

				if v12 then
					HiddenEvent.waitingSince = HiddenEvent.waitingSince or tick()
					local announced = HiddenEvent.announced and HiddenEvent.announced[v8.Name]
					local waitingSince = HiddenEvent.waitingSince
					local n3 = tick() - waitingSince
					announced = announced and tick() - announced < 420

					if announced then
						announced = v9 and v9.Active and 420 or 60
					end

					if (announced or 6) < n3 then
						HiddenEvent.waiting[v8.Name] = v11
						HiddenEvent.skipped[v8.Name] = math.max(HiddenEvent.skipped[v8.Name] or 0, tick() + HiddenRetryDelay(v8))
						SaveHiddenSkip()
						HiddenEvent.current = nil
						local name_ = v8.Name
						HiddenNotify(v8.Name .. ": " .. tostring(v11) .. ", switching to another quest", name_ .. tostring(v11), "warning")
					end
				else
					HiddenEvent.waiting[v8.Name] = nil
					HiddenEvent.waitingSince = nil
				end

				return
			end
		end

		HiddenEvent.current = nil

		if n == 0 then
			SetHiddenStep("All 39 secrets are complete")
			SaveSettings("Auto Secret Quest", false)

			if getgenv().ToggleSecretQuest and getgenv().ToggleSecretQuest.SetStage then
				getgenv().ToggleSecretQuest:SetStage(false)
			end

			HiddenNotify("All 39 secret quests are done, turning off", "secretalldone", "success")
			return
		end

		HiddenEvent.idleSince = HiddenEvent.idleSince or tick()

		if tick() - (HiddenEvent.idleNotified or 0) > 300 then
			HiddenEvent.idleNotified = tick()
			HiddenNotify("No secret quest is available right now (" .. n .. " left), checking again soon", "idle", "warning")
		end

		local tbl12 = {}

		for k in pairs(HiddenEvent.waiting) do
			local str2 = nil

			for _, v8 in ipairs(HiddenQuests) do
				if v8.Name == k then
					str2 = "Sea1/" .. v8.Island .. "/" .. v8.Name
				end
			end

			if str2 and v6[str2] ~= true then
				table.insert(tbl12, k)
			end
		end

		local v8 = nil

		for _, v9 in pairs(HiddenEvent.skipped) do
			if v9 > tick() and (not v8 or v9 < v8) then
				v8 = v9
			end
		end

		if PrepareHiddenChef(v6) then
			return
		end
		local min = os.date("!*t").min
		local flag3 = Settings["Hidden Hop Dead Hour"] ~= false and min >= 50 and min <= 58

		if flag3 then
			flag3 = tick() - (HiddenEvent.hopAt or 0) > 100
		end

		if flag3 and not IsHiddenHourUseful(v6) then
			HiddenEvent.hopAt = tick()
			if HopHiddenServer() then
				SetHiddenStep("Next awakened boss is not needed here, switching server")
				return
			end
		end

		local park = HiddenEvent.park
		local flag4 = Settings["Hidden Hop Dead Hour"] ~= false and park
		local flag5

		if flag4 then
			flag5 = tick() - (HiddenEvent.idleSince or tick()) > 1200
		else
			flag5 = flag4
		end

		flag5 = flag5 and min >= 5 and min < 45

		if flag5 then
			flag5 = tick() - (HiddenEvent.hopAt or 0) > 1200
		end

		if flag5 then
			HiddenEvent.hopAt = tick()
			if HopHiddenServer() then
				SetHiddenStep("Nothing triggered on " .. park.island .. " for 20 min, switching server")
				return
			end
		end

		if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local v9 = PickHiddenParkSpot(v6)
			HiddenEvent.idlePark = v9

			if HiddenGoTo(v9, 60) then
				HiddenHold(CFrame.new(v9))
			end
		end

		SetHiddenStep("Waiting " .. n .. " quests" .. (v8 and " (next check in " .. math.ceil(v8 - tick()) .. "s)" or "") .. ": " .. table.concat(tbl12, ", "))
	end

	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				if not SeaOnly(StatusHiddenQuest, "Title Quest", { 1 }) then
					SeaOnly(StatusHiddenStep, "Doing Quest", { 1 })
					SeaOnly(StatusHiddenBoss, "Title Awakened Boss", { 1 })
					return
				end

				local v6 = GetHiddenProgress()
				local n = 0
				local doneCount = 0

				for _, v7 in pairs(v6) do
					n += 1
					doneCount += v7 == true and 1 or 0
				end

				if HiddenEvent.doneCount ~= doneCount then
					HiddenEvent.doneCount = doneCount
					HiddenEvent.doneAt = tick()
				end

				StatusHiddenProgress.SetText(string.format("Secret Quest : %d/39 Quests", doneCount))
				StatusHiddenQuest.SetText("Title Quest : " .. (HiddenEvent.current or "None"))
				StatusHiddenStep.SetText("Doing Quest : " .. (Settings["Auto Secret Quest"] and HiddenEvent.step or "None"))

				if Place_Id.sea1() then
					local v7 = GetHiddenRaidHint()
					local setText = StatusHiddenBoss.SetText
					local boss = v7.Boss

					if boss then
						boss = v7.Boss .. " on " .. tostring(v7.Island) .. " in " .. FormatMagnetTime(tonumber(v7.Seconds) or 0)
					end

					setText("Title Awakened Boss : " .. (boss or "None"))
				end
			end)
		end
	end)

	HiddenEventSection.CreateToggle({
		Title = "Hop Server For Secret Quest",
		Desc = "Switch server when the next awakened boss is already done, or when nothing triggers on the island for 20 min",
		Default = Settings["Hidden Hop Dead Hour"] ~= false,
	}, function(arg)
		SaveSettings("Hidden Hop Dead Hour", arg)
	end)

	do
		local v6 = nil

		task.defer(function()
			getgenv().ToggleSecretQuest = v6
		end)

		local createToggle = HiddenEventSection.CreateToggle

		local tbl9 = {
			Title = "Auto Secret Quest",
			Desc = "Auto complete Sea 1 secret quests",
			Default = Settings["Auto Secret Quest"] or false,
		}

		local function fn(arg)
			if arg and not EnforceGate(v6, "Auto Secret Quest", Place_Id.sea1(), "Only works in Sea 1") then
				return
			end
			SaveSettings("Auto Secret Quest", arg)

			if not arg then
				HiddenEvent.current = nil
				HiddenEvent.fighting = nil
				HiddenEvent.walking = false
				HiddenEvent.farmHeight = nil
				getgenv().AimPos = nil
				SetHiddenStep("Idle")
				pcall(LeaveHiddenCannon)
				pcall(HiddenRelease)
				pcall(StopHiddenDodge)
				pcall(require(ReplicatedStorage.DialogueController).close)
				pcall(TweenManager.CancelCurrent)

				task.spawn(function()
					task.wait(0.2)
					local character = localPlayer.Character
					local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
					if not humanoidRootPart then
						return
					end
					humanoidRootPart.Anchored = false
					humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
					local raycastParams = RaycastParams.new()
					raycastParams.FilterType = Enum.RaycastFilterType.Exclude
					raycastParams.FilterDescendantsInstances = { character, workspace.Characters, workspace.Enemies }
					local hit = workspace:Raycast(humanoidRootPart.Position, Vector3.new(0, -900, 0), raycastParams)

					if hit and humanoidRootPart.Position.Y - hit.Position.Y > 25 then
						humanoidRootPart.CFrame = CFrame.new(hit.Position + Vector3.new(0, 4, 0))
						task.wait(0.2)
						humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
					elseif not hit then
						local v7 = travelFunctions.GetSpawnPosition(localPlayer.Data.LastSpawnPoint.Value)

						if v7 then
							humanoidRootPart.CFrame = CFrame.new(v7 + Vector3.new(0, 4, 0))
						end
					end

					local n = 0

					while HiddenEvent.running and n < 5 do
						task.wait(0.1)
						n += 0.1
					end

					ReleaseTweenPhysics()
				end)

				return
			end

			if not Place_Id.sea1() then
				HiddenNotify("Hidden Event only works in First Sea", nil, "warning")
				return
			end

			if HiddenEvent.running then
				return
			end
			HiddenEvent.running = true

			task.spawn(function()
				pcall(function()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
				end)
			end)

			task.spawn(HiddenDialogueLoop)

			task.spawn(function()
				while Settings["Auto Secret Quest"] and task.wait(0.15) do
					local ok, result

					if StackFarmOther then
						ok, result = pcall(AutoHiddenEvent)
					else
						SetHiddenStep("Paused while another feature is running")
						ok = true
						result = nil
					end

					if not ok then
						print(result)
						HiddenEvent.lastError = tostring(result)
						HiddenEvent.errors = (HiddenEvent.errors or 0) + 1

						if HiddenEvent.errors % 20 == 1 then
							HiddenNotify("Error: " .. tostring(result):sub(1, 120), "error", "error")
						end
					end

					pcall(CheckHiddenStall)
					local anchored = HiddenEvent.anchored

					if anchored then
						anchored = tick() - (HiddenEvent.holdTime or 0) > 0.6
					end

					if anchored then
						HiddenRelease()
					end

					local str2 = tostring(HiddenEvent.step or "")

					if str2:find("^Waiting") or str2:find(" stirs on ") or str2 == "Idle" then
						task.wait(0.6)
					end
				end

				HiddenRelease()
				HiddenEvent.running = false
			end)
		end

		v6 = createToggle
		v6 = v6(tbl9, fn)
	end

	EventMagnetSection = FarmotherMain.CreateSection("Magnet Event")
	StatusMagnetToken = EventMagnetSection.CreateLabel({ Title = "Magnet Token : ..." })
	StatusMagnetEvent = EventMagnetSection.CreateLabel({ Title = "Magnet Event : ..." })

	MagnetEvent = {
		spawns = nil,
		visited = {},
		target = nil,
		arrived = nil,
		notified = 0,
		tokens = 0,
		duration = 600,
		firstSeen = nil,
		lastSeen = 0,
		hour = -1,
	}

	GetMagnetTokens = function()
		if not GachaClient then
			return MagnetEvent.tokens
		end
		local ok, result = pcall(GachaClient.CheckGachaAsync, "MagnetEventGacha26", "Blox Fruit Gacha")

		if ok and type(result) == "table" and result.Price then
			MagnetEvent.tokens = tonumber(result.Price.Current) or MagnetEvent.tokens
		end

		return MagnetEvent.tokens
	end

	IsMagnetizedEnemy = function(arg)
		return arg:GetAttribute("MagnetEnemy") == true
	end

	DetectMagnetizedEnemy = function()
		local huge = math.huge
		local v6 = nil

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if IsMagnetizedEnemy(child) and IsMobAlive(child) then
				local v7 = localPlayer:DistanceFromCharacter(child.HumanoidRootPart.Position)

				if v7 < huge then
					huge = v7
					v6 = child
				end
			end
		end

		return v6
	end

	UpdateMagnetObservation = function()
		local serverTimeNow = workspace:GetServerTimeNow()
		local hour = math.floor(serverTimeNow / 3600)

		if hour ~= MagnetEvent.hour then
			local v6 = MagnetEvent
			MagnetEvent.hour = hour
			v6.firstSeen = nil
			table.clear(MagnetEvent.visited)
		end

		if DetectMagnetizedEnemy() then
			MagnetEvent.firstSeen = MagnetEvent.firstSeen or serverTimeNow
			MagnetEvent.lastSeen = serverTimeNow
			MagnetEvent.duration = math.clamp(serverTimeNow % 3600 + 30, MagnetEvent.duration, 1200)
		end
	end

	GetMagnetEventTime = function()
		local serverTimeNow = workspace:GetServerTimeNow()
		local n = serverTimeNow % 3600
		if n < MagnetEvent.duration or serverTimeNow - MagnetEvent.lastSeen < 30 then
			return true, math.max(MagnetEvent.duration - n, 0)
		end
		return false, 3600 - n
	end

	FormatMagnetTime = function(arg)
		local n = math.floor(arg)
		return string.format("%02d:%02d", n // 60, n % 60)
	end

	task.spawn(function()
		local n = 0

		while task.wait(1) do
			pcall(function()
				UpdateMagnetObservation()

				if tick() - n > 10 then
					n = tick()
					task.spawn(GetMagnetTokens)
				end

				local tokens = MagnetEvent.tokens
				StatusMagnetToken.SetText(string.format("Magnet Token : %d/500 | Rolls : %d | Need : %d", tokens, tokens // 500, 500 - tokens % 500))
				local v6, v7 = GetMagnetEventTime()

				if v6 then
					StatusMagnetEvent.SetText("Magnet Event : 🟢 Active | Ends in ~" .. FormatMagnetTime(v7))
				else
					StatusMagnetEvent.SetText("Magnet Event : 🔴 Waiting | Starts in ~" .. FormatMagnetTime(v7) .. " | Lasts ~" .. FormatMagnetTime(MagnetEvent.duration))
				end
			end)
		end
	end)

	GetMagnetSpawns = function()
		if MagnetEvent.spawns then
			return MagnetEvent.spawns
		end
		local tbl9 = {}

		for _, child in ipairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
			local attribute = child:GetAttribute("DisplayName")
			local num = attribute and not string.find(attribute, "Boss") and tonumber(string.match(attribute, "Lv%. (%d+)"))
			local flag = num and child.Position.Magnitude < 20000 and (GetLocationPartAt(child.Position) or FindNearestLocationPart(child.Position))
			local flag2

			if flag then
				flag2 = not tbl9[flag.Name] or num < tbl9[flag.Name].level
			else
				flag2 = flag
			end

			if flag2 then
				tbl9[flag.Name] = { level = num, parts = { child } }
			elseif flag and num == tbl9[flag.Name].level then
				local flag3 = false

				for _, part in ipairs(tbl9[flag.Name].parts) do
					flag3 = flag3 or part:GetAttribute("DisplayName") == attribute
				end

				if not flag3 then
					table.insert(tbl9[flag.Name].parts, child)
				end
			end
		end

		MagnetEvent.spawns = {}

		for _, v6 in pairs(tbl9) do
			for _, part in ipairs(v6.parts) do
				table.insert(MagnetEvent.spawns, { level = v6.level, part = part })
			end
		end

		table.sort(MagnetEvent.spawns, function(arg, arg2)
			return arg.level < arg2.level
		end)

		return MagnetEvent.spawns
	end

	GetNextMagnetSpawn = function()
		local v6 = GetMagnetSpawns()
		local huge = math.huge
		local part = nil

		for _, v7 in ipairs(v6) do
			local v8 = localPlayer:DistanceFromCharacter(v7.part.Position)

			if not MagnetEvent.visited[v7.part] and v8 < huge then
				part = v7.part
				huge = v8
			end
		end

		if not part and #v6 > 0 then
			table.clear(MagnetEvent.visited)
			return GetNextMagnetSpawn()
		end
		return part
	end

	KillMagnetizedEnemy = function(arg)
		local now = tick()

		while true do
			task.wait()
			SizePart(arg)
			BringMob(arg)
			EquipTool(NameWeapon(Settings["Select Weapon"]))
			ToTarget(arg.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
			UsedualFlock()
			ClickM1(arg)
			if not (not IsMobAlive(arg) or not Settings["Auto Magnet Event"] or tick() - now > 60) then
				continue
			end
			break
		end

		local v6 = MagnetEvent
		MagnetEvent.target = nil
		v6.arrived = nil
		task.spawn(GetMagnetTokens)
	end

	AutoMagnetToken = function()
		local v6 = DetectMagnetizedEnemy()
		if v6 then
			KillMagnetizedEnemy(v6)
			return
		end
		local v7, v8 = GetMagnetEventTime()

		if not v7 and v8 > 45 then
			MagnetEvent.target = nil
			local notified = MagnetEvent.notified

			if tick() - notified > 120 then
				MagnetEvent.notified = tick()
				VxezeNotify("Magnet Event", "Waiting Magnet Event, starts in ~" .. FormatMagnetTime(v8), "warning")
			end

			return
		end

		local target = MagnetEvent.target or GetNextMagnetSpawn()
		if not target then
			return
		end
		local flag

		if v7 then
			flag = localPlayer:DistanceFromCharacter(target.Position) / (Settings["Speed Tween"] or 220) > v8
		else
			flag = v7
		end

		if flag then
			MagnetEvent.visited[target] = true
			MagnetEvent.target = nil
			return
		end

		MagnetEvent.target = target

		if localPlayer:DistanceFromCharacter(target.Position) > 150 then
			MagnetEvent.arrived = nil
			ToTarget(target.CFrame * CFrame.new(0, 40, 0))
		elseif not v7 then
			ToTarget(target.CFrame * CFrame.new(0, 40, 0))
		elseif not MagnetEvent.arrived then
			MagnetEvent.arrived = tick()
			ToTarget(target.CFrame * CFrame.new(0, 40, 0))
		else
			local arrived = MagnetEvent.arrived

			if tick() - arrived > 5 then
				MagnetEvent.visited[target] = true
				local v9 = MagnetEvent
				MagnetEvent.target = nil
				v9.arrived = nil
			end
		end
	end

	EventMagnetSection.CreateToggle({
		Title = "Auto Magnet Event",
		Desc = "Farm Magnetized enemies when the event is active",
		Default = Settings["Auto Magnet Event"] or false,
	}, function(arg)
		SaveSettings("Auto Magnet Event", arg)

		if arg then
			task.spawn(function()
				while Settings["Auto Magnet Event"] and task.wait(0.1) do
					local ok, result = pcall(function()
						if StackFarmOther then
							AutoMagnetToken()
						end
					end)

					if not ok then
						print(result)
					end
				end
			end)
		end
	end)

	FishingSection = FarmotherMain.CreateSection("Fishing")

	FishingSection.CreateToggle({ Title = "Change Size Reel", Desc = nil, Default = Settings["Change Size Reel"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Change Size Reel"] and task.wait(0.1) do
					pcall(function()
						if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Fishing_Reeling") then
							game:GetService("Players").LocalPlayer.PlayerGui.Fishing_Reeling.Minigame.Container.ReelZone.Size = UDim2.new(0.98, 0, 0.13, 0)
						end
					end)
				end
			end)
		end

		SaveSettings("Change Size Reel", arg)
	end)

	SlapBattleConnected = false

	FishingSection.CreateToggle({
		Title = "Auto Slap Battle",
		Desc = "There’s still a chance of a misclick",
		Default = Settings["Auto Slap Battle"] or false,
	}, function(arg)
		if arg and not SlapBattleConnected then
			SlapBattleConnected = true

			task.spawn(function()
				local remoteEvent = game:GetService("Players").LocalPlayer:FindFirstChild("RemoteEvent") or game:GetService("Players").LocalPlayer:WaitForChild("RemoteEvent", 10)
				if not remoteEvent then
					SlapBattleConnected = false
					return
				end
				local connection = nil

				remoteEvent.OnClientEvent:Connect(function(arg2, arg3, arg4, arg5)
					if arg2 == "startBar" and arg5 == game.Players.LocalPlayer then
						if not Settings["Auto Slap Battle"] then
							return
						end

						if connection then
							connection:Disconnect()
						end

						connection = game:GetService("RunService").Heartbeat:Connect(function(...) end)
					elseif arg2 == "killBar" then
						if connection then
							connection:Disconnect()
							connection = nil
						end
					end
				end)
			end)
		end

		SaveSettings("Auto Slap Battle", arg)
	end)

	callback5 = Settings["Save Position Fishing"]
	npcNames = "Position : "

	if callback5 then
		callback4 = Vector3.new(callback5.posX, callback5.posY, callback5.posZ)
		local deg = math.deg
		local rz = callback5.rz
		npcNames = string.format("Position : %.2f, %.2f, %.2f | Angle(deg) : %.1f, %.1f, %.1f", callback4.X, callback4.Y, callback4.Z, math.deg(callback5.rx), math.deg(callback5.ry), deg(rz))
	end

	LocalPositionPlantSeed = FishingSection.CreateLabel({ Title = npcNames })

	FishingSection.CreateButton({ Title = "Save Position Fishing" }, function()
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local cFrame = humanoidRootPart.CFrame
		local position = cFrame.Position
		local v6, v7, v8 = cFrame:ToOrientation()
		local deg = math.deg
		LocalPositionPlantSeed.SetText(string.format("Position : %.2f, %.2f, %.2f | Angle(deg) : %.1f, %.1f, %.1f", position.X, position.Y, position.Z, math.deg(v6), math.deg(v7), deg(v8)))
		SaveSettings("Save Position Fishing", { posX = position.X, posY = position.Y, posZ = position.Z, rx = v6, ry = v7, rz = v8 })
	end)

	iterator = {}

	for k in next, require(game:GetService("ReplicatedStorage").FishReplicated.BaitData).Types, nil do
		table.insert(iterator, k)
	end

	FishingSection.CreateDropdown({
		Title = "Select Bait",
		List = iterator,
		Search = true,
		Selected = false,
		Default = Settings["Select Bait"] or nil,
	}, function(arg)
		SaveSettings("Select Bait", arg)
	end)

	do
		local fishingRequest = game.ReplicatedStorage.FishReplicated.FishingRequest
		local FishingRemote = require(game.ReplicatedStorage.Modules.Net):RemoteEvent("FishingRemote", true)
		local GetWaterHeightAtLocation = require(game.ReplicatedStorage.Util.GetWaterHeightAtLocation)
		local CollectionService = game:GetService("CollectionService")
		local waterBodyTag = require(game.ReplicatedStorage.FishReplicated.FishingClient.Config).WATER_BODY_TAG
		local rod = require(game.ReplicatedStorage.FishReplicated.FishingClient.Config).Rod
		require(game:GetService("ReplicatedStorage").FishReplicated.FishingClient.Components)

		CalculateFishingCastTarget = function(arg, arg2, arg3)
			local v6 = GetWaterHeightAtLocation(arg.Position)
			local v7, v8 = workspace:FindPartOnRayWithIgnoreList(Ray.new(arg.Parent.Head.Position, arg.CFrame.LookVector * (arg2:GetAttribute("MaxLaunchDistance") or rod.MaxLaunchDistance) * (0.5 + arg3 / 201)), { arg.Parent, workspace.Characters, workspace.Enemies })
			local tbl9 = { arg.Parent, workspace.Characters, workspace.Enemies }
			local v9, v10 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v8 + Vector3.new(0, 3, 0), Vector3.new(0, -500, 0)), tbl9)
			if not v10 then
				return
			end
			local z = v8.Z
			local vector = Vector3.new(v8.X, math.max(v10.Y, v6), z)
			return vector, v9 and CollectionService:HasTag(v9, waterBodyTag) or vector.Y <= v6
		end

		DetectRod = function()
			if not localPlayer then
				return nil
			end
			local fishingRodData = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):FindFirstChild("FishingRodData", true)
			if fishingRodData then
				return fishingRodData.Parent
			end

			for _, child in ipairs(localPlayer.Backpack:GetChildren()) do
				if child:FindFirstChild("FishingRodData") then
					return child
				end
			end

			return nil
		end

		require(game:GetService("ReplicatedStorage").FishReplicated.FishingClient.Components.CatchingMinigame)

		RunFishingCycle = function()
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")
			local v6 = DetectRod()
			if not character or not v6 then
				return
			end

			if v6.Parent == localPlayer.Backpack then
				EquipTool(v6.Name)
				task.wait(0.5)
				return
			end

			local attribute = v6:GetAttribute("ServerState")

			if attribute then
				StatusFishingLabel.SetText("Status Fishing : " .. attribute)
			end

			if v6:GetAttribute("SkillChargeAlpha") >= 1 then
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/JobToolAbilities"):InvokeServer(unpack({ "Z", true }))
			end

			if not attribute or attribute == "ReeledIn" then
				getgenv().delaytimeBiting = nil
				fishingRequest:InvokeServer("StartCasting")
				task.wait(0.7)
				local v7, v8 = CalculateFishingCastTarget(character, v6, 98)
				if not v7 then
					return
				end

				if not fishingRequest:InvokeServer("CastLineAtLocation", v7, 98, v8) then
					EquipTool(NameWeapon("Melee"))
					return
				end

				if not getgenv().LoadFishingRemote then
					FishingRemote.OnClientEvent:Connect(function(arg, arg2)
						if Settings["Auto Fishing"] then
							if arg ~= localPlayer then
								return
							end

							if arg2 == "SpawnFishOnBob" then
								task.wait(0.2)
								fishingRequest:InvokeServer("Catching", true, { fastBite = true })
								task.wait(2)
								game.ReplicatedStorage.FishReplicated.FishingRequest:InvokeServer("Catch", 1, 1, 1)
								game.ReplicatedStorage.FishReplicated.FishingRequest:InvokeServer("Catch", 1, 0, 1)
							end
						end
					end)

					getgenv().LoadFishingRemote = true
				end
			elseif attribute == "Biting" then
				if not getgenv().delaytimeBiting then
					getgenv().delaytimeBiting = tick()
				end

				if tick() - (getgenv().delaytimeBiting or 0) >= 5 then
					EquipTool(NameWeapon("Melee"))
					task.wait(1)
				end
			else
				getgenv().delaytimeBiting = nil
			end
		end
	end

	GroundPointCache = {}

	FindNearestGroundPoint = function(arg, arg2)
		local str2 = math.floor(arg.X / 20) .. "," .. math.floor(arg.Y / 20) .. "," .. math.floor(arg.Z / 20)
		local v6 = GroundPointCache[str2]
		if v6 and v6[2] and v6[2].Parent then
			return v6[1], v6[2]
		end
		local v7, v8, v9 = ipairs((arg2 or workspace:WaitForChild("Map")):GetDescendants())
		local huge = math.huge
		local v10 = nil

		for _, v11 in v7, v8, v9 do
			if v11:IsA("BasePart") and v11.CanCollide then
				if arg.Y < v11.Position.Y + v11.Size.Y / 2 then
					local magnitude = (v11.Position - arg).Magnitude

					if magnitude < huge then
						huge = magnitude
						v10 = v11
					end
				end
			end
		end

		if v10 then
			local vector = Vector3.new(v10.Position.X, v10.Position.Y + v10.Size.Y / 2, v10.Position.Z)
			GroundPointCache[str2] = { vector, v10 }
			return vector, v10
		end

		return nil
	end

	FaceTowardsHorizontal = function(arg, arg2)
		local position = arg.Position
		arg.CFrame = CFrame.new(arg.Position, arg.Position + (Vector3.new(arg2.X, arg.Position.Y, arg2.Z) - position).Unit)
	end

	GetGoldenVortex = function()
		local v6 = next
		local children, v7 = workspace.ActiveFishingSpots:GetChildren()
		local huge = math.huge
		local v8 = nil

		for _, v9 in v6, children, v7 do
			if v9.Name == "GoldenVortex" then
				local magnitude = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v9.Position).Magnitude

				if magnitude < huge then
					huge = magnitude
					v8 = v9
				end
			end
		end

		return v8
	end

	do
		local ok, result = pcall(function()
			return identifyexecutor and identifyexecutor()
		end)

		okz = ok
		execc = result
	end

	if okz and typeof(execc) == "string" then
		if execc:find("Seliware") then
			task.wait(2)
		elseif execc:find("Velocity") or execc:find("Delta") or execc:find("Real") then
			task.wait(5)
		end
	end

	StatusFishingLabel = FishingSection.CreateLabel({ Title = "Status Fishing : None" })

	task.spawn(function()
		while task.wait(1.5) do
			if not Settings["Auto Fishing"] then
				StatusFishingLabel.SetText("Status Fishing : None")
			end
		end
	end)

	FishingSection.CreateToggle({
		Title = "Auto Tween To Event Fishing Spot",
		Desc = nil,
		Default = Settings["Auto Tween To Event Fishing Spot"] or false,
	}, function(arg)
		SaveSettings("Auto Tween To Event Fishing Spot", arg)
	end)

	CheckChestplr = function()
		local v6 = nil

		for _, child in pairs(localPlayer.Backpack:GetChildren()) do
			if string.find(child.Name, "Chest") then
				v6 = child
			end
		end

		for _, child in pairs(localPlayer.Character:GetChildren()) do
			if string.find(child.Name, "Chest") then
				v6 = child
			end
		end

		return v6
	end

	FishingSection.CreateToggle({ Title = "Auto Fishing", Desc = nil, Default = Settings["Auto Fishing"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Fishing"] and task.wait(0.1) do
					local ok, result = pcall(function()
						if not StackFarmOther then
							return
						end

						if Settings["Auto Celestial Soldier"] and getgenv().AttackOniSoldier then
							return
						end

						if Settings["Auto Rip Commander"] and getgenv().AttackBossRedCommander then
							return
						end

						if game:GetService("Players").LocalPlayer.Data.FishingData:GetAttribute("SelectedBait") and game:GetService("Players").LocalPlayer.Data.FishingData:GetAttribute("SelectedBait") ~= "None" then
							local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

							if Settings["Auto Tween To Event Fishing Spot"] and GetGoldenVortex() then
								if not getgenv().Vortex or not getgenv().Vortex.Parent then
									getgenv().Vortex = GetGoldenVortex()
									task.wait(1)
									local genv = getgenv()
									local genv2 = getgenv()
									local v6 = workspace
									local waitForChild = v6.WaitForChild
									local v7, v8 = FindNearestGroundPoint(getgenv().Vortex.Position, waitForChild(v6, "Map"))
									genv.higherPos = v7
									genv2.partHigher = v8
									return
								end

								if getgenv().Vortex then
									local position = GetGoldenVortex().Position

									if not ((humanoidRootPart.CFrame.Position - getgenv().higherPos).Magnitude <= 5) then
										ToTarget(CFrame.new(getgenv().higherPos))
									else
										if localPlayer:DistanceFromCharacter(position) > 100 then
											getgenv().Vortex = nil
											return
										end
										FaceTowardsHorizontal(humanoidRootPart, position)
										RunFishingCycle()
									end

									return
								end
							end

							local savePositionFishing = Settings["Save Position Fishing"]

							if not savePositionFishing then
								if humanoidRootPart then
									RunFishingCycle()
								end

								return
							end

							local flag = not DetectRod()

							if not flag then
								flag = CountFishingBait(Settings["Select Bait"] or "Basic Bait") <= 0
							end

							if flag then
								StatusFishingLabel.SetText("Status Fishing : Getting rod and bait")
								BuyHiddenFishingGear(Settings["Select Bait"] or "Basic Bait")
								return
							end

							local vector = Vector3.new(savePositionFishing.posX, savePositionFishing.posY, savePositionFishing.posZ)
							local n = CFrame.new(vector) * CFrame.fromOrientation(savePositionFishing.rx, savePositionFishing.ry, savePositionFishing.rz)

							if humanoidRootPart then
								local cFrame = humanoidRootPart.CFrame

								if not ((cFrame.Position - vector).Magnitude <= 10 and cFrame.LookVector:Dot(n.LookVector) > 0.99) then
									ToTarget(n)
								else
									RunFishingCycle()
								end
							end
						else
							local selectBait = Settings["Select Bait"] or "Basic Bait"

							if CheckItemInventory(selectBait) then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "LoadItem", selectBait, { "Usables" } }))
							else
								game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({ "Craft", selectBait, 1, {} }))
							end
						end
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Fishing", arg)
	end)

	do
		local JobsReplicated = require(game.ReplicatedStorage.JobsReplicated)

		FishingSection.CreateToggle({ Title = "Auto Sell Fishing", Desc = nil, Default = Settings["Auto Sell Fishing"] or false }, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Sell Fishing"] and task.wait(0.2) do
						local ok, result = pcall(function()
							JobsReplicated.InvokeServer("FishingNPC", "SellFish")
						end)

						if result then
							PrintOnce(result)
						end
					end
				end)
			end

			SaveSettings("Auto Sell Fishing", arg)
		end)

		FishingSection.CreateToggle({ Title = "Auto Open Chest", Desc = nil, Default = Settings["Auto Open Chest"] or false }, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Open Chest"] and task.wait(0.2) do
						local ok, result = pcall(function()
							local v6 = CheckChestplr()

							if v6 then
								v6.RemoteEvent:FireServer(unpack({ "Visual" }))
								task.wait(0.1)
								v6.RemoteEvent:FireServer(unpack({ "Open" }))
							end
						end)

						if result then
							PrintOnce(result)
						end
					end
				end)
			end

			SaveSettings("Auto Open Chest", arg)
		end)

		local tbl9 = {}

		for _, v6 in next, require(game:GetService("ReplicatedStorage").Modules.Asset.RarityUtil.RarityData), nil do
			tbl9[v6.Name] = false
		end

		DetectQuestFishing = function()
			local v6 = GetQuestMob()
			if not v6 then
				return false
			end
			local v7 = nil

			for k in pairs(tbl9) do
				if string.find(v6, k) then
					v7 = k
					break
				else
					v7 = nil
				end
			end

			if v7 and Settings["Select Quest Fishing"] then
				for k in next, Settings["Select Quest Fishing"], nil do
					if string.find(v6, k) then
						return true
					end
				end

				return false
			end

			return true
		end

		FishingSection.CreateDropdown({
			Title = "Select Quest Fishing",
			List = PrepareMultiSelectList(tbl9, Settings["Select Quest Fishing"]),
			Search = true,
			Selected = true,
			Default = Settings["Select Quest Fishing"] or nil,
		}, function(arg, arg2)
			SaveSettings("Select Quest Fishing", arg, arg2)
		end)

		FishingSection.CreateToggle({
			Title = "Auto Accept Quest Fishing",
			Desc = nil,
			Default = Settings["Auto Accept Quest Fishing"] or false,
		}, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Accept Quest Fishing"] and task.wait(0.1) do
						local ok, result = pcall(function()
							if Settings["Auto Event Pain"] and getgenv().AttackEventLightning then
								return
							end

							if Settings["Auto Celestial Soldier"] and getgenv().AttackOniSoldier then
								return
							end

							if Settings["Auto Rip Commander"] and getgenv().AttackBossRedCommander then
								return
							end

							if not StackFarmOther then
								return
							end
							JobsReplicated.InvokeServer("FishingNPC", "Angler", "CheckQuest")
							local FishingNPC = JobsReplicated.InvokeServer("FishingNPC", "Angler", "Speak")

							if FishingNPC.canAccept then
								JobsReplicated.InvokeServer("FishingNPC", "Angler", "AskQuest")
							elseif FishingNPC.FailedAnglerQuest or not DetectQuestFishing() then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
							end

							task.wait(2)
						end)

						if result then
							PrintOnce(result)
						end
					end
				end)
			end

			SaveSettings("Auto Accept Quest Fishing", arg)
		end)
	end

	QuestDragonSection = FarmotherMain.CreateSection("Quest Dojo Trainer / Dragon Hunter")

	QuestDojoTrainer = function()
		return game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack({ { NPC = "Dojo Trainer", Command = "RequestQuest" } }))
	end

	local tbl9
	tbl9 = { "PirateBrigade", "PirateGrandBrigade" }
	local tbl10
	tbl10 = { "Fish Crew Member", "Shark" }

	DetectQuestSeaDragon = function()
		local v6 = next
		local children, v7 = game:GetService("Workspace").Enemies:GetChildren()

		for _, v8 in v6, children, v7 do
			if v8:FindFirstChild("Engine") and v8:FindFirstChild("Health") and v8.Health.Value > 0 and localPlayer:DistanceFromCharacter(v8.Engine.Position) < 500 then
				return v8
			end
		end

		local v8 = DetectMob(tbl10)
		if v8 and localPlayer:DistanceFromCharacter(v8.HumanoidRootPart.Position) < 500 then
			return v8
		end
		local Piranha = DetectMob("Piranha")
		if Piranha and localPlayer:DistanceFromCharacter(Piranha.HumanoidRootPart.Position) < 500 then
			return Piranha
		end
	end

	CheckBoat = function()
		local name_ = localPlayer.Name

		if Settings["Auto Sea Event With Friend"] and Settings["Auto Sea Event"] then
			name_ = Settings["Select Friend"]
		end

		local v6 = next
		local children, v7 = game:GetService("Workspace").Boats:GetChildren()

		for _, v8 in v6, children, v7 do
			if v8:IsA("Model") then
				if v8:FindFirstChild("Owner") and tostring(v8.Owner.Value) == name_ and v8.Humanoid.Value > 0 then
					return v8
				end
			end
		end

		return false
	end

	getgenv().PosSEaY = -50

	TeleportSeaEvents = function(arg)
		if not arg then
			return
		end

		if arg:FindFirstChild("Engine") and arg:FindFirstChild("Health") and arg.Health.Value > 0 then
			ToTarget(arg.Engine.CFrame * CFrame.new(0, Settings["Use Click M1 Fruit For Sea Event"] and -25 or -15, 0))
			return
		end

		if arg.Name == "SeaBeast1" and arg:FindFirstChild("HumanoidRootPart") then
			if (Vector3.new(0, arg:FindFirstChild("HumanoidRootPart").Position.Y, 0) - Vector3.new(0, -60, 0)).Magnitude <= 175 then
				if Settings["Use Click M1 Fruit For Sea Event"] then
					ToTarget(arg.HumanoidRootPart.CFrame * CFrame.new(0, 200 + PosDodgeskill, 0), true)
				else
					ToTarget(arg.HumanoidRootPart.CFrame * CFrame.new(0, 200 + PosDodgeskill, 50), true)
				end
			else
				ToTarget(CFrame.new(arg.HumanoidRootPart.Position.X, 140, arg.HumanoidRootPart.Position.Z), true)
			end
		else
			local name_ = arg.Name
			local n

			if Settings["Use Click M1 Fruit For Sea Event"] then
				n = 20
			elseif name_ == "Terrorshark" then
				n = 60
			else
				n = 20
			end

			if arg:FindFirstChildWhichIsA("Humanoid") and arg.Humanoid.Health > 0 then
				ToTarget(arg.HumanoidRootPart.CFrame * CFrame.new(0, n, 0))
			end
		end
	end

	local roughSea
	roughSea = 0

	DecectPartRoughSea = function()
		local v6 = next
		local children, v7 = game.workspace._WorldOrigin.Locations:GetChildren()

		for _, v8 in v6, children, v7 do
			if v8.Name == "Rough Sea" and localPlayer:DistanceFromCharacter(v8.Position) <= 3000 and Vector3.new(0.001, 0.001, 0.001) ~= workspace._WorldOrigin.RainEmitterPart.Size and not v8:FindFirstChild("Ignored") then
				return v8
			end
		end
	end

	do
		local v6 = nil

		AutoQuestDojo = function()
			local v7 = QuestDojoTrainer()
			local n = CFrame.new(5868.453125, 1207.7784423828125, 870.819580078125) * CFrame.new(0, 4, -2)

			if not getgenv().QuestTrainer then
				if v7 == false or type(v7) == "table" and type(v7.Quest) ~= "table" then
					SaveSettings("Auto Dojo Trainer", false)

					if v6 and v6.SetStage then
						v6:SetStage(false)
					end

					VxezeNotify("Dojo Belt", "No active Dojo Trainer quest, all belts are done for now", "success", { Key = "dojobeltdone" })
					return
				end

				if type(v7) == "table" then
					if v7.Quest.Goal <= v7.Quest.Progress then
						if localPlayer:DistanceFromCharacter(n.Position) > 8 then
							ToTarget(n)
							return
						end
						game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack({ { NPC = "Dojo Trainer", Command = "ClaimQuest" } }))
						wait(1)
						return
					end

					if v7.Quest.BeltName == "White" then
						getgenv().QuestTrainer = { BeltName = "White", CountKillMob = 0 }
					elseif v7.Quest.BeltName == "Yellow" then
						getgenv().QuestTrainer = { BeltName = "Yellow", CountKillMob = 0 }
					elseif v7.Quest.BeltName == "Green" then
						local questTrainer = { BeltName = "Green", CountKillMob = 300, Progress = v7.Quest.Progress }
						getgenv().QuestTrainer = questTrainer
					elseif v7.Quest.BeltName == "Purple" then
						getgenv().QuestTrainer = { BeltName = "Purple", CountKillMob = 0 }
					else
						if v7.Quest.BeltName ~= "Red" then
							SaveSettings("Auto Dojo Trainer", false)

							if v6 and v6.SetStage then
								v6:SetStage(false)
							end

							VxezeNotify("Dojo Belt", "That's enough training for today... Come back tomorrow and we can continue.", "success", { Key = "dojobeltdone" })
							return
						end

						getgenv().QuestTrainer = { BeltName = "Red", CountKillMob = 0 }
					end
				end
			elseif getgenv().QuestTrainer.BeltName == "White" and getgenv().QuestTrainer.CountKillMob < 20 then
				SaveSettings("QuestDojo", true)
				local str2 = GetQuestMob() or ""

				if not HasQuest() and typeof(str2) == "string" then
					TakeQuestLevel()
				else
					local v8 = DetectMob(str2)

					if not v8 then
						local v9 = DetectPartSpawnMob(str2, true)

						if v9 then
							Instance.new("IntValue", v9).Name = "Ignored"

							while true do
								task.wait()
								ToTarget(v9.CFrame * CFrame.new(0, 60, 0))
								if not (localPlayer:DistanceFromCharacter(v9.Position) <= 100 or DetectMob(str2) or not Settings["Auto Dojo Trainer"]) then
									continue
								end
								break
							end

							wait(1)
						else
							DeleteIgnoredMobSpawn()
						end
					else
						while true do
							task.wait()
							SizePart(v8)
							BringMob(v8)
							UsedualFlock()
							ClickM1(v8)

							if game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"]) then
								ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							elseif Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(-7, getgenv().YPosFruit, 0))
							else
								ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							if not (not IsMobAlive(v8) or not Settings["Auto Dojo Trainer"]) then
								continue
							end
							break
						end

						if getgenv().QuestTrainer and getgenv().QuestTrainer.CountKillMob then
							getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
						end
					end
				end
			elseif getgenv().QuestTrainer.BeltName == "White" and getgenv().QuestTrainer.CountKillMob >= 20 then
				SaveSettings("QuestDojo", false)
				getgenv().QuestTrainer = nil
			elseif getgenv().QuestTrainer.BeltName == "Yellow" and getgenv().QuestTrainer.CountKillMob < 5 then
				SaveSettings("QuestDojo", true)
				local v8 = DetectQuestSeaDragon()
				local v9 = CheckBoat()

				if not v8 then
					if not v9 then
						local cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

						if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
							ToTarget(cframe)
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
						end
					else
						task.spawn(function()
							NoclipBoat(v9)
						end)

						local v10 = DecectPartRoughSea()

						if v10 then
							wait(1)
							local n3

							if roughSea == 0 then
								n3 = 7000
							else
								n3 = 0
							end

							roughSea = n3
							Instance.new("IntValue", v10).Name = "Ignored"
							wait(0.5)
						end

						getgenv().RoughSea = roughSea
						local n3 = CFrame.new(-32975.9921875, v9.WorldPivot.Y, 25963.7109375) * CFrame.new(0, v9.WorldPivot.Y, 0 + RoughSea)

						if not localPlayer.Character.Humanoid.Sit then
							ToTarget(v9.VehicleSeat.CFrame)
						else
							ManageTween(v9.VehicleSeat, n3, 350, "TweenBoat")
						end
					end
				else
					while true do
						task.wait()
						TeleportSeaEvents(v8)
						local humanoidRootPart = v8:FindFirstChild("HumanoidRootPart") or v8:FindFirstChild("Engine")
						getgenv().AimPos = CFrame.new(humanoidRootPart.Position.X, 40, humanoidRootPart.Position.Z)

						if v8:FindFirstChildWhichIsA("Humanoid") then
							UsedualFlock()
							ClickM1(v8, true)
						elseif localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
							AutoAllSkill()
						end

						if not (not v8 or not v8.Parent or v8:FindFirstChildWhichIsA("Humanoid") and v8.Humanoid.Health <= 0 or v8:FindFirstChild("Health") and v8.Health.Value <= 0 or not Settings["Auto Dojo Trainer"]) then
							continue
						end
						break
					end

					if getgenv().QuestTrainer and getgenv().QuestTrainer.CountKillMob then
						getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
					end
				end
			elseif getgenv().QuestTrainer.BeltName == "Yellow" and getgenv().QuestTrainer.CountKillMob >= 5 then
				SaveSettings("QuestDojo", false)
				getgenv().QuestTrainer = nil
			elseif getgenv().QuestTrainer.BeltName == "Purple" and getgenv().QuestTrainer.CountKillMob < 3 then
				SaveSettings("QuestDojo", true)
				local v8 = DetectEliteHunter()

				if v8 then
					StackFarm = false
					local name_ = v8.Name

					if not string.find(GetQuestTitle(), name_) or not HasQuest() then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
					else
						while true do
							task.wait()
							SizePart(v8)

							if Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							ClickM1(v8)
							UsedualFlock()
							if not (not IsMobAlive(v8) or not Settings["Auto Dojo Trainer"]) then
								continue
							end
							break
						end

						if getgenv().QuestTrainer and getgenv().QuestTrainer.CountKillMob then
							getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
						end
					end

					return
				end
			elseif getgenv().QuestTrainer.BeltName == "Purple" and getgenv().QuestTrainer.CountKillMob >= 3 then
				SaveSettings("QuestDojo", false)
				getgenv().QuestTrainer = nil
			elseif getgenv().QuestTrainer.BeltName == "Green" and getgenv().QuestTrainer.CountKillMob == 300 then
				SaveSettings("QuestDojo", true)

				if game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.Visible and tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.TextLabel.Text) == 6 then
					local now = tick()

					while true do
						wait()
						if not (tick() - now >= getgenv().QuestTrainer.Progress or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.Visible or not Settings["Auto Dojo Trainer"]) then
							continue
						end
						break
					end

					getgenv().QuestTrainer = nil
					SaveSettings("QuestDojo", false)
				else
					local v8 = CheckBoat()

					if not v8 then
						local cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

						if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
							ToTarget(cframe)
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
						end
					else
						task.spawn(function()
							NoclipBoat(v8)
						end)

						local v9 = DecectPartRoughSea()

						if v9 then
							wait(1)
							local n3

							if roughSea == 0 then
								n3 = 7000
							else
								n3 = 0
							end

							roughSea = n3
							Instance.new("IntValue", v9).Name = "Ignored"
							wait(0.5)
						end

						getgenv().RoughSea = roughSea
						local n3 = CFrame.new(-32975.9921875, v8.WorldPivot.Y, 25963.7109375) * CFrame.new(0, v8.WorldPivot.Y, 0 + RoughSea)

						if not localPlayer.Character.Humanoid.Sit then
							ToTarget(v8.VehicleSeat.CFrame)
						else
							ManageTween(v8.VehicleSeat, n3, 350, "TweenBoat")
						end
					end
				end
			elseif getgenv().QuestTrainer.BeltName == "Red" and getgenv().QuestTrainer.CountKillMob == 0 then
				SaveSettings("QuestDojo", true)
				local Terrorshark = CheckNameBoss("Terrorshark")
				local v8 = CheckBoat()

				if not Terrorshark then
					if not v8 then
						local cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

						if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
							ToTarget(cframe)
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
						end
					else
						local v9 = DecectPartRoughSea()

						if v9 then
							wait(1)
							local n3

							if roughSea == 0 then
								n3 = 7000
							else
								n3 = 0
							end

							roughSea = n3
							Instance.new("IntValue", v9).Name = "Ignored"
							wait(0.5)
						end

						getgenv().RoughSea = roughSea
						local n3 = CFrame.new(-32975.9921875, v8.WorldPivot.Y, 25963.7109375) * CFrame.new(0, v8.WorldPivot.Y, 0 + RoughSea)

						if not localPlayer.Character.Humanoid.Sit then
							ToTarget(v8.VehicleSeat.CFrame)
						else
							ManageTween(v8.VehicleSeat, n3, 350, "TweenBoat")
						end
					end
				else
					while true do
						task.wait()
						TeleportSeaEvents(Terrorshark)
						local humanoidRootPart = Terrorshark:FindFirstChild("HumanoidRootPart")
						getgenv().AimPos = CFrame.new(humanoidRootPart.Position.X, 40, humanoidRootPart.Position.Z)

						if Terrorshark:FindFirstChildWhichIsA("Humanoid") then
							UsedualFlock()
							ClickM1(Terrorshark, true)
						elseif localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
							AutoAllSkill()
						end

						if not (not Terrorshark or not Terrorshark.Parent or Terrorshark.Humanoid.Health <= 0 or not Settings["Auto Dojo Trainer"]) then
							continue
						end
						break
					end

					getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
				end
			elseif getgenv().QuestTrainer.BeltName == "Red" and getgenv().QuestTrainer.CountKillMob > 0 then
				SaveSettings("QuestDojo", false)
				getgenv().QuestTrainer = nil
			end
		end

		local createToggle = QuestDragonSection.CreateToggle
		local tbl11 = { Title = "Auto Dojo Trainer", Desc = nil, Default = Settings["Auto Dojo Trainer"] or false }

		local function fn(arg)
			if arg and not EnforceGate(v6, "Auto Dojo Trainer", Place_Id.sea3(), "Only works in Sea 3") then
				return
			end

			if arg then
				local ok, result = pcall(QuestDojoTrainer)

				if ok and (result == false or type(result) == "table" and type(result.Quest) ~= "table") then
					SaveSettings("Auto Dojo Trainer", false)

					if v6 and v6.SetStage then
						v6:SetStage(false)
					end

					VxezeNotify("Dojo Belt", "All Dojo Trainer belts are already done", "success", { Key = "dojobeltdone" })
					return
				end

				SaveSettings("Auto Dojo Trainer", true)

				spawn(function()
					while Settings["Auto Dojo Trainer"] and task.wait(0.1) do
						local ok2, result2 = pcall(function()
							AutoQuestDojo()
						end)

						if result2 then
							PrintOnce(result2)
						end
					end
				end)
			end

			SaveSettings("Auto Dojo Trainer", arg)
		end

		v6 = createToggle
		v6 = v6(tbl11, fn)
	end

	game:GetService("Players").LocalPlayer.PlayerGui.Notifications.ChildAdded:Connect(function(child)
		if child.Name == "NotificationTemplate" then
			repeat
				wait()
			until child:FindFirstChild("TranslateMe")

			if child.TranslateMe.Text == "Head back to the Dojo to complete more tasks." then
				getgenv().QuestHunterDragon = nil
			end
		end

		if child.Name == "NotificationTemplate" then
			repeat
				wait()
			until child:FindFirstChild("TranslateMe")

			if child.TranslateMe.Text == "{color1_Red}[ERROR]{color1_/} Can't perform actions while preparing to teleport!" then
				child:Destroy()
			end
		end
	end)

	DetectTree = function()
		local islandModel = workspace.Map:FindFirstChild("Waterfall") and workspace.Map.Waterfall:FindFirstChild("IslandModel")

		if not islandModel then
			local v6 = ToTarget
			local cframe = CFrame.new(5251.900390625, 17.18115234375, 453.6025390625)
			v6(cframe)
			return nil
		end

		local fn = nil

		fn = function(arg)
			for _, child in ipairs(arg:GetChildren()) do
				local group = child:IsA("Model") and not child:FindFirstChild("Ignored") and child.Name == "Tree" and not child:GetAttribute("AlreadyDestroyedClient") and child:FindFirstChild("Group")
				local meshesBambootree

				if group then
					meshesBambootree = child.Group:FindFirstChild("Meshes/bambootree") or child.Group:FindFirstChild("Meshes/plant1_Icosphere")
				else
					meshesBambootree = group
				end

				if meshesBambootree and not workspace:FindFirstChild("EmberTemplate") then
					return child
				end
				local v6 = fn(child)
				if v6 then
					return v6
				end
			end

			return nil
		end

		local v6 = fn(islandModel)

		if not v6 then
			local fn2 = nil

			fn2 = function(arg)
				for _, child in ipairs(arg:GetChildren()) do
					if child:FindFirstChild("Ignored") then
						child.Ignored:Destroy()
					end

					fn2(child)
				end
			end

			fn2(islandModel)
		end

		return v6
	end

	DetectEmberTemplate = function()
		for _, v6 in game.workspace:GetChildren() do
			if v6.Name == "EmberTemplate" and not v6:FindFirstChild("Ignored") and v6:FindFirstChild("Part") and v6.Part.Position.Y > -100 then
				return v6
			end
		end
	end

	AutoDragonHunter = function()
		if not GoToSea(3) then
			return
		end
		local v6 = DetectNpc("Dragon Hunter")
		if not v6 then
			return
		end

		if not getgenv().QuestHunterDragon then
			if localPlayer:DistanceFromCharacter(v6.HumanoidRootPart.Position) > 8 then
				ToTarget(v6.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4))
			else
				local response = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({ { Context = "Check" } }))

				if not response or response and not response.Text then
					getgenv().QuestHunterDragon = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({ { Context = "RequestQuest" } })).Text
				else
					local text = response.Text
					getgenv().QuestHunterDragon = text
				end
			end
		else
			local v7 = DetectEmberTemplate()

			if v7 then
				Instance.new("IntValue", v7).Name = "Ignored"

				while true do
					wait()
					ToTarget(v7.Part.CFrame)
					if not (not v7 or not v7.Parent) then
						continue
					end
					break
				end

				return
			end

			if string.find(getgenv().QuestHunterDragon, "Hydra Enforcers") then
				local v8 = DetectMob("Hydra Enforcer")

				if not v8 then
					local v9 = DetectPartSpawnMob("Hydra Enforcer", true)

					if v9 then
						Instance.new("IntValue", v9).Name = "Ignored"

						while true do
							wait()
							ToTarget(v9.CFrame * CFrame.new(0, 60, 0))
							if not (localPlayer:DistanceFromCharacter(v9.Position) <= 100 or DetectMob("Hydra Enforcer") or not Settings["Auto Dragon Hunter"] or v7) then
								continue
							end
							break
						end

						wait(1)
					else
						DeleteIgnoredMobSpawn()
					end
				else
					while true do
						task.wait()
						SizePart(v8)
						BringMob(v8)
						UsedualFlock()
						ClickM1(v8)

						if Settings["Select Weapon"] == "Blox Fruit" then
							ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end

						if not (not IsMobAlive(v8) or not Settings["Auto Dragon Hunter"] or v7) then
							continue
						end
						break
					end
				end
			elseif string.find(getgenv().QuestHunterDragon, "Venomous Assailants") then
				local v8 = DetectMob("Venomous Assailant")

				if not v8 then
					local v9 = DetectPartSpawnMob("Venomous Assailant", true)

					if v9 then
						Instance.new("IntValue", v9).Name = "Ignored"

						while true do
							wait()
							ToTarget(v9.CFrame * CFrame.new(0, 60, 0))
							if not (localPlayer:DistanceFromCharacter(v9.Position) <= 100 or DetectMob("Venomous Assailant") or not Settings["Auto Dragon Hunter"] or v7) then
								continue
							end
							break
						end

						wait(1)
					else
						DeleteIgnoredMobSpawn()
					end
				else
					while true do
						task.wait()
						SizePart(v8)
						BringMob(v8)
						UsedualFlock()
						ClickM1(v8)

						if Settings["Select Weapon"] == "Blox Fruit" then
							ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end

						if not (not IsMobAlive(v8) or not Settings["Auto Dragon Hunter"] or v7) then
							continue
						end
						break
					end
				end
			elseif string.find(getgenv().QuestHunterDragon, "trees") then
				local currentCamera = workspace.CurrentCamera
				local v8 = DetectTree()

				if v8 then
					Instance.new("IntValue", v8).Name = "Ignored"
					local now = tick()

					while true do
						task.wait()
						local position = v8.WorldPivot.Position

						if localPlayer:DistanceFromCharacter(position) < 50 then
							AutoAllSkill()
						end

						if v8:FindFirstChild("Meshes/plant1_Icosphere", true) then
							ToTarget(v8.WorldPivot)
							local worldPivot = v8.WorldPivot
							getgenv().AimPos = worldPivot
							replicatedStorage6.Hit = CFrame.new(currentCamera.CFrame.Position, position)
							replicatedStorage6.Target = v8
						else
							local position2 = (v8.WorldPivot * CFrame.new(5, -20, 0)).Position
							local position3 = (v8.WorldPivot * CFrame.new(0, -20, 0)).Position
							ToTarget(CFrame.new(position2))
							getgenv().AimPos = CFrame.new(position3)
							replicatedStorage6.Hit = CFrame.new(currentCamera.CFrame.Position, position3)
							replicatedStorage6.Target = v8
						end

						if not (not v8 or not v8.Parent or not Settings["Auto Dragon Hunter"] or v7 or v8:GetAttribute("AlreadyDestroyedClient") or tick() - now >= 15) then
							continue
						end
						break
					end
				end
			end
		end
	end

	QuestDragonSection.CreateToggle({ Title = "Auto Dragon Hunter", Desc = nil, Default = Settings["Auto Dragon Hunter"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Dragon Hunter"] and task.wait(0.1) do
					local ok, result = pcall(function()
						AutoDragonHunter()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Dragon Hunter", arg)
	end)

	DetectBerryCFrame = function(arg)
		for _, v6 in next, arg, nil do
			if v6 then
				return v6
			end
		end
	end

	DetectBerry = function()local c,n,L=next,game:GetService("CollectionService"):GetTagged("BerryBush");for U,w in c,n,L do U=DetectBerryCFrame(w:GetAttributes());if U then return w,U;end;end;end

	DetectBerryESP = function()
		local v6 = next
		local tagged, v7 = game:GetService("CollectionService"):GetTagged("BerryBush")

		for _, v8 in v6, tagged, v7 do
			if not v8.Parent:FindFirstChild("Ignored") then
				local v9 = DetectBerryCFrame(v8:GetAttributes())
				if v9 then
					return v8, v9
				end
			end
		end
	end

	DetectModelBerry = function(arg)
		for _, child in pairs(arg:GetChildren()) do
			if child then
				return child
			end
		end
	end

	AutoChest = function(...) end
	RaidLawSection = FarmotherMain.CreateSection("Raid Law")

	do
		local v6 = nil
		local createToggle = RaidLawSection.CreateToggle

		local tbl11 = {
			Title = "Auto Buy Chip and Attack Law",
			Desc = nil,
			Default = Settings["Auto Buy Chip and Attack Law"] or false,
		}

		local function fn(arg)
			if arg and not EnforceGate(v6, "Auto Buy Chip and Attack Law", Place_Id.sea2(), "Only works in Sea 2") then
				return
			end

			if arg then
				spawn(function()
					while Settings["Auto Buy Chip and Attack Law"] and task.wait(0.1) do
						pcall(function()
							if DetectItemPlr("Core Brain") then
								fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
								return
							end
							local Order = CheckNameBoss("Order")

							if Order then
								while true do
									task.wait()
									SizePart(Order)
									UsedualFlock()
									ClickM1(Order)

									if Settings["Select Weapon"] == "Blox Fruit" then
										ToTarget(Order.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										ToTarget(Order.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end

									if not (not IsMobAlive(Order) or not Settings["Auto Buy Chip and Attack Law"]) then
										continue
									end
									break
								end
							elseif not DetectItemPlr("Microchip") and game.Players.LocalPlayer.Data.Fragments.Value >= 1000 then
								BuyChipLaw()
								wait(2)
							elseif DetectItemPlr("Microchip") then
								fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
							end
						end)
					end
				end)
			end

			SaveSettings("Auto Buy Chip and Attack Law", arg)
		end

		v6 = createToggle
		v6 = v6(tbl11, fn)
	end

	FarmObservationSection = FarmotherMain.CreateSection("Quest Observation")

	do
		local v6 = nil
		FarmObservationV2CheckAt = 0
		FarmObservation = function(...) end
		local v7 = nil

		ObservationV2 = function()
			if HasObservationV2() then
				SaveSettings("Auto Observation v2", false)

				if v7 and v7.SetStage then
					v7:SetStage(false)
				end

				VxezeNotify("Observation v2", "Done", "success", { Key = "observationv2done" })
				return
			end

			if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 0 then
				if string.find(GetQuestTitle(), "Forest Pirate") and string.find(GetQuestTitle(), "50") and HasQuest() then
					local v8 = DetectMob("Forest Pirate")

					if not v8 then
						if typeof("Forest Pirate") == "table" then
							if #tbl5 >= 13 then
								tbl5 = {}
								return
							end
							local v9 = DetectPartSpawnMob(DetectNameTablePart("Forest Pirate"))

							if v9 then
								table.insert(tbl5, DetectNameTablePart("Forest Pirate"))

								while true do
									wait()
									ToTarget(v9.CFrame * CFrame.new(0, 60, 0))
									if not (localPlayer:DistanceFromCharacter(v9.Position) <= 100 or DetectMob("Forest Pirate") or not Settings["Auto Observation v2"]) then
										continue
									end
									break
								end

								wait(1)
							end
						else
							local v9 = DetectPartSpawnMob("Forest Pirate", true)

							if v9 then
								Instance.new("IntValue", v9).Name = "Ignored"

								while true do
									wait()
									ToTarget(v9.CFrame * CFrame.new(0, 60, 0))
									if not (localPlayer:DistanceFromCharacter(v9.Position) <= 100 or DetectMob("Forest Pirate") or not Settings["Auto Observation v2"]) then
										continue
									end
									break
								end

								wait(1)
							else
								DeleteIgnoredMobSpawn()
							end
						end
					else
						while true do
							task.wait()
							SizePart(v8)
							BringMob(v8)
							UsedualFlock()
							ClickM1(v8)

							if Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							if not (not IsMobAlive(v8) or not Settings["Auto Observation v2"]) then
								continue
							end
							break
						end
					end
				elseif localPlayer:DistanceFromCharacter(Vector3.new(-12441.591, 331.4885, -7676.1973)) < 10 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "StartQuest", "CitizenQuest", 1 }))
				else
					ToTarget(CFrame.new(-12441.5908203125, 331.48849487304688, -7676.197265625))
				end
			elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 1 then
				if string.find(GetQuestTitle(), "Captain Elephant") and string.find(GetQuestTitle(), "1") and HasQuest() then
					local v8 = CheckNameBoss("Captain Elephant")

					if v8 then
						while true do
							wait()
							SizePart(v8)

							if Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(v8.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							ClickM1(v8)
							EquipTool(NameWeapon(Settings["Select Weapon"]))
							if not (not IsMobAlive(v8) or not Settings["Auto Observation v2"]) then
								continue
							end
							break
						end
					else
						VxezeNotify("Captain Elephant", "Waiting Boss Captain Elephant", "warning")
						wait(5)
					end
				elseif localPlayer:DistanceFromCharacter(Vector3.new(-12441.591, 331.4885, -7676.1973)) < 10 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "StartQuest", "CitizenQuest", 1 }))
				else
					ToTarget(CFrame.new(-12441.5908203125, 331.48849487304688, -7676.197265625))
				end
			elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
				ToTarget(CFrame.new(-12513.8, 336.167, -9872.91))
			elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 3 then
				local v8 = tonumber
				local v9 = string.gsub(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk", "Status"), "%D", "")

				if v8(v9) >= 5000 then
					game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2", "Start")

					if localPlayer.Data.Beli.Value >= 5000000 and DetectItemPlr("Pineapple") and DetectItemPlr("Apple") and DetectItemPlr("Banana") or DetectItemPlr("Fruit Bowl") then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
					else
						for _, v10 in pairs({ "PineappleSpawner", "BananaSpawner", "AppleSpawner" }) do
							if game:GetService("Workspace"):FindFirstChild(v10) then
								if game:GetService("Workspace"):FindFirstChild(v10):FindFirstChildOfClass("Tool") then
									firetouchinterest(localPlayer.Character.HumanoidRootPart, game:GetService("Workspace"):FindFirstChild(v10):FindFirstChildOfClass("Tool").Handle, 0)
								else
									VxezeNotify("Fruit Spawn", "Wating Fruit", "warning")
									wait(3)
								end
							end
						end
					end
				else
					local v10 = next
					local children, v11 = game.workspace.Enemies:GetChildren()
					local v12 = nil

					for _, v13 in v10, children, v11 do
						if v13:IsA("Model") and v13.Name == "Marine Commodore" and v13:FindFirstChild("HumanoidRootPart") and v13.Humanoid.Health > 0 then
							v12 = v13
						end
					end

					if not game:GetService("Lighting").Blur.Enabled then
						if v12 then
							ToTarget(v12.HumanoidRootPart.CFrame * CFrame.new(0, 0, 50))
						end

						pcall(function()
							game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
						end)

						pcall(function()
							game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
						end)

						wait(2)
					elseif not v12 then
						GetPart = DetectPartSpawnMob("Marine Commodore")
						ToTarget(GetPart.CFrame * CFrame.new(0, 60, 0))
					else
						while true do
							task.wait()
							ToTarget(v12.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
							if not (not Settings["Auto Observation v2"] or not game:GetService("Lighting").Blur.Enabled) then
								continue
							end
							break
						end
					end
				end
			else
				SaveSettings("Auto Observation v2", false)

				if v7 and v7.SetStage then
					v7:SetStage(false)
				end

				VxezeNotify("Observation v2", "Done", "success", { Key = "observationv2done" })
			end
		end

		local createToggle = FarmObservationSection.CreateToggle

		local tbl11 = {
			Title = "Auto Observation v2",
			Desc = nil,
			Default = Settings["Auto Observation v2"] or false,
		}

		local function fn(arg)
			if arg and not EnforceGate(v7, "Auto Observation v2", Place_Id.sea3(), "Only works in Sea 3") then
				return
			end

			if arg then
				if HasObservationV2() then
					SaveSettings("Auto Observation v2", false)

					if v7 and v7.SetStage then
						v7:SetStage(false)
					end

					VxezeNotify("Observation v2", "You already have Observation v2", "success", { Key = "observationv2done" })
					return
				end

				SaveSettings("Auto Observation v2", true)

				spawn(function()
					while Settings["Auto Observation v2"] and wait(0.1) do
						pcall(function()
							ObservationV2()
						end)
					end
				end)
			end

			SaveSettings("Auto Observation v2", arg)
		end

		v7 = createToggle
		v7 = v7(tbl11, fn)

		HasObservationV2 = function()
			local commF = game:GetService("ReplicatedStorage").Remotes.CommF_

			local ok, result = pcall(function()
				return commF:InvokeServer("CitizenQuestProgress", "Citizen")
			end)

			if ok and result ~= 0 and result ~= 1 and result ~= 2 and result ~= 3 then
				return true
			end

			local ok2, result2 = pcall(function()
				return commF:InvokeServer("KenTalk", "Status")
			end)

			return ok2 and type(result2) == "string" and result2:find("completely mastered", 1, true) ~= nil
		end

		v6 = FarmObservationSection.CreateToggle({
			Title = "Auto Farm Observation",
			Desc = nil,
			Default = Settings["Auto Farm Observation"] or false,
		}, function(arg)
			local flag

			if arg then
				local function fn2()
					local ok, result = pcall(HasObservationV2)
					return not (ok and result)
				end

				flag = not EnforceGate(v6, "Auto Farm Observation", fn2(), "You already have Observation v2, no need for Farm Observation")
			else
				flag = arg
			end

			if flag then
				return
			end

			if arg then
				SaveSettings("Auto Farm Observation", true)

				spawn(function()
					while Settings["Auto Farm Observation"] and wait(0.1) do
						pcall(function()
							FarmObservation()
						end)
					end
				end)
			end

			SaveSettings("Auto Farm Observation", arg)
		end)
	end

	do
		local v6 = nil
		local createToggle = FarmObservationSection.CreateToggle

		local tbl11 = {
			Title = "Hop Find Server When Farm Observation",
			Desc = nil,
			Default = Settings["Hop Find Server When Farm Observation"] or false,
		}

		local function fn(arg)
			if arg and not EnforceGate(v6, "Hop Find Server When Farm Observation", Settings["Auto Farm Observation"] == true, "Turn on Farm Observation first") then
				return
			end
			SaveSettings("Hop Find Server When Farm Observation", arg)
		end

		v6 = createToggle
		v6 = v6(tbl11, fn)
	end

	AutoKillMobSection = FarmotherMain.CreateSection("Mob Farm")

	TableMob = function()
		local v6 = getnilinstances()
		local tbl11 = {}
		local tbl12 = {}
		local v7 = next
		local Quests, v8 = require(game:GetService("ReplicatedStorage").Quests)

		for _, v9 in v7, Quests, v8 do
			for _, v10 in next, v9, nil do
				for k, v11 in next, v10.Task, nil do
					if v11 > 1 then
						table.insert(tbl12, k)
					end
				end
			end
		end

		if game:GetService("Workspace")._WorldOrigin.EnemySpawns:FindFirstChildWhichIsA("Part") then
			for _, child in pairs(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()) do
				if not string.find(child.Name, "Boss") and tbl11[child.Name] == nil then
					tbl11[child.Name] = false
				end
			end

			if string.find(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()[1].Name, "Lv.") then
				for _, v9 in pairs(v6) do
					if table.find(tbl12, tostring(v9.Name:gsub(" %pLv. %d+%p", ""))) and tbl11[v9.Name] == nil then
						tbl11[v9.Name] = false
					end
				end
			else
				for _, v9 in pairs(v6) do
					if table.find(tbl12, v9.Name) and tbl11[v9.Name] == nil then
						tbl11[v9.Name] = false
					end
				end
			end
		end

		return tbl11
	end

	do
		local createDropdown = AutoKillMobSection.CreateDropdown
		local selectMob = Settings["Select Mob"]

		createDropdown({
			Title = "Select Mob",
			List = PrepareMultiSelectList(TableMob(), selectMob),
			Search = true,
			Selected = true,
			Default = Settings["Select Mob"] or nil,
		}, function(arg, arg2)
			SaveSettings("Select Mob", arg, arg2)
		end)
	end

	FarmSelectMob = function()
		if not StackFarmOther then
			return
		end
		local tbl11 = {}
		local v6 = pairs
		local selectMob = Settings["Select Mob"] or {}

		for k, v7 in v6(selectMob) do
			if v7 then
				local insert = table.insert
				local str2 = k:gsub(" %pLv. %d+%p", "")
				insert(tbl11, str2)
			end
		end

		if #tbl11 == 0 then
			VxezeNotify("Farm Mob", "Select Mob First", "warning")
			task.wait(5)
			return
		end

		local v7 = DetectMob(tbl11)

		if not v7 then
			if typeof(tbl11) == "table" then
				if #tbl11 <= #tbl5 then
					tbl5 = {}
					return
				end
				local v8 = DetectPartSpawnMob(DetectNameTablePart(tbl11))

				if v8 then
					table.insert(tbl5, DetectNameTablePart(tbl11))

					while true do
						wait()
						ToTarget(v8.CFrame * CFrame.new(0, 60, 0))
						if not (localPlayer:DistanceFromCharacter(v8.Position) <= 100 or DetectMob(tbl11) or not Settings["Farm Mob"]) then
							continue
						end
						break
					end

					wait(1)
				end
			else
				local v8 = DetectPartSpawnMob(tbl11, true)

				if v8 then
					Instance.new("IntValue", v8).Name = "Ignored"

					while true do
						wait()
						ToTarget(v8.CFrame * CFrame.new(0, 60, 0))
						if not (localPlayer:DistanceFromCharacter(v8.Position) <= 100 or DetectMob(tbl11) or not Settings["Farm Mob"]) then
							continue
						end
						break
					end

					wait(1)
				else
					DeleteIgnoredMobSpawn()
				end
			end
		else
			while true do
				task.wait()
				SizePart(v7)
				BringMob(v7)
				UsedualFlock()
				ClickM1(v7)

				if Settings["Select Weapon"] == "Blox Fruit" then
					ToTarget(v7.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					ToTarget(v7.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end

				if not (not IsMobAlive(v7) or not Settings["Farm Mob"] or not StackFarmOther) then
					continue
				end
				break
			end
		end
	end

	AutoKillMobSection.CreateToggle({ Title = "Farm Mob", Desc = nil, Default = Settings["Farm Mob"] or false }, function(arg)
		if arg then
			SoftGate("Farm Mob", Settings["Start Farm"] == true, "Turn on Start Farm first")
			local v6 = pairs
			local selectMob = Settings["Select Mob"] or {}
			local flag = false

			for _, v7 in v6(selectMob) do
				if v7 then
					flag = true
					break
				end
			end

			SoftGate("Farm Mob", flag, "Pick a mob first")
		end

		if arg then
			spawn(function()
				while Settings["Farm Mob"] and task.wait(0.1) do
					local ok, result = pcall(function()
						FarmSelectMob()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Farm Mob", arg)
	end)

	AutoKillBossSection = FarmotherMain.CreateSection("Boss Farm")

	local tbl11 = {
		"Gorilla King",
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
		"Diamond",
		"Jeremy",
		"Orbitus",
		"Don Swan",
		"Smoke Admiral",
		"Awakened Ice Admiral",
		"Tide Keeper",
		"Stone",
		"Island Empress",
		"Kilo Admiral",
		"Captain Elephant",
		"Beautiful Pirate",
		"Longma",
		"Cake Queen",
		"GreyBeard",
		"Order",
		"Cursed Captain",
		"Darkbeard",
		"Soul Reaper",
		"rip_indra True Form",
		"Mihawk",
		"Cake Prince",
		"Dough King",
	}

	TableBoss = function()
		local tbl12 = {}

		for _, child in pairs(game.Workspace.Enemies:GetChildren()) do
			if table.find(tbl11, child.Name) then
				table.insert(tbl12, child.Name)
			end
		end

		for _, child in pairs(game.ReplicatedStorage:GetChildren()) do
			if table.find(tbl11, child.Name) then
				table.insert(tbl12, child.Name)
			end
		end

		return tbl12
	end

	local v6 = AutoKillBossSection.CreateDropdown({
		Title = "Select Boss",
		List = TableBoss(),
		Search = true,
		Selected = false,
		Default = Settings["Select Boss"] or nil,
	}, function(arg)
		SaveSettings("Select Boss", arg)
	end)

	AutoKillBossSection.CreateButton({ Title = "Refresh Boss" }, function()
		v6:GetNewList(TableBoss())
	end)

	AutoKillBoss = function()
		local v7

		if Settings["Kill All Boss"] then
			v7 = CheckNameBoss(TableBoss())
		else
			v7 = CheckNameBoss(Settings["Select Boss"])
		end

		if v7 then
			while true do
				wait()
				SizePart(v7)

				if Settings["Select Weapon"] == "Blox Fruit" then
					ToTarget(v7.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					ToTarget(v7.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end

				ClickM1(v7)
				UsedualFlock()
				if not (not IsMobAlive(v7) or not Settings["Kill Boss"]) then
					continue
				end
				break
			end
		elseif Settings["Hop Server Find Boss"] then
			HopServer()
			wait(5)
		end
	end

	do
		local v7 = nil
		local createToggle = AutoKillBossSection.CreateToggle
		local tbl12 = { Title = "Kill Boss", Desc = nil, Default = Settings["Kill Boss"] or false }

		local function fn(arg)
			local flag

			if arg then
				flag = not EnforceGate(v7, "Kill Boss", Settings["Select Boss"] ~= nil or Settings["Kill All Boss"] == true, "Pick a boss first, or turn on Kill All Boss")
			else
				flag = arg
			end

			if flag then
				return
			end

			spawn(function()
				while Settings["Kill Boss"] and wait(0.1) do
					pcall(function()
						AutoKillBoss()
					end)
				end
			end)

			SaveSettings("Kill Boss", arg)
		end

		v7 = createToggle
		v7 = v7(tbl12, fn)
	end

	do
		local v7 = nil
		local createToggle = AutoKillBossSection.CreateToggle
		local tbl12 = { Title = "Kill All Boss", Desc = nil, Default = Settings["Kill All Boss"] or false }

		local function fn(arg)
			if arg and not EnforceGate(v7, "Kill All Boss", Settings["Kill Boss"] == true, "Turn on Kill Boss first") then
				return
			end
			SaveSettings("Kill All Boss", arg)
		end

		v7 = createToggle
		v7 = v7(tbl12, fn)
	end

	AutoKillBossSection.CreateToggle({ Title = "Hop Server Find Boss", Desc = nil, Default = Settings["Hop Server Find Boss"] or false }, function(arg)
		SaveSettings("Hop Server Find Boss", arg)
	end)

	GachaClient = require(game:GetService("ReplicatedStorage").Controllers.GachaClient)
	GachaWindow = require(game:GetService("ReplicatedStorage").Controllers.UI.GachaWindow)
	GachaTimers = {}

	GetGachaMissing = function(arg)
		if arg.PaidRandomItemsRestricted and arg.PaidRandomItemsRestricted.Value then
			return arg.PaidRandomItemsRestricted
		end

		for _, v7 in ipairs({ "Level", "Price", "Cooldown" }) do
			if arg[v7] and arg[v7].RequirementMet == false then
				return arg[v7]
			end
		end
	end

	RollGacha = function(arg, arg2)
		local serverTimeNow = workspace:GetServerTimeNow()
		if serverTimeNow < (GachaTimers[arg] or 0) then
			return
		end
		GachaTimers[arg] = serverTimeNow + 60
		local ok, result = pcall(GachaClient.CheckGachaAsync, arg, "Blox Fruit Gacha")
		if not ok or type(result) ~= "table" then
			VxezeNotify("Gacha", "Gacha is not available right now", "warning")
			return
		end
		local v7 = GetGachaMissing(result)

		if v7 then
			if v7.TimeEnds then
				GachaTimers[arg] = v7.TimeEnds + 1
			end

			VxezeNotify(arg2, v7.ErrorMessage, "warning")
			return
		end

		if pcall(GachaClient.PurchaseGachaAsync, arg) then
			GachaTimers[arg] = serverTimeNow + 5
			VxezeNotify("Gacha", "Rolled successfully", "success")
		end
	end

	DFRaidMain = Main.CreatePage({ Page_Name = "Fruit and Raid, Dungeon", Page_Title = "Fruit and Raid and Dungeon Tab" })
	DevilFruitSection = DFRaidMain.CreateSection("Devil Fruit")

	DevilFruitSection.CreateToggle({ Title = "Random Devil Fruit", Desc = nil, Default = Settings["Random Devil Fruit"] or false }, function(arg)
		GachaTimers.ZiolesGacha = nil
		SaveSettings("Random Devil Fruit", arg)
	end)

	DevilFruitSection.CreateToggle({ Title = "Random Magnet Event", Desc = nil, Default = Settings["Random Magnet Event"] or false }, function(arg)
		GachaTimers.MagnetEventGacha26 = nil
		SaveSettings("Random Magnet Event", arg)
	end)

	DevilFruitSection.CreateToggle({ Title = "Auto Store Fruit", Desc = nil, Default = Settings["Auto Store Fruit"] or false }, function(arg)
		SaveSettings("Auto Store Fruit", arg)
	end)

	SniperShopDropdown = DevilFruitSection.CreateDropdown({
		Title = "Blox Fruit Sniper Shop",
		List = PrepareMultiSelectList(TableDevilFruit, Settings["Blox Fruit Sniper Shop"]),
		Search = true,
		Selected = true,
		Default = Settings["Blox Fruit Sniper Shop"] or nil,
	}, function(arg, arg2)
		SaveSettings("Blox Fruit Sniper Shop", arg, arg2)
	end)

	DevilFruitSection.CreateToggle({
		Title = "Buy Blox Fruit Sniper Shop",
		Desc = nil,
		Default = Settings["Buy Blox Fruit Sniper Shop"] or false,
	}, function(arg)
		SaveSettings("Buy Blox Fruit Sniper Shop", arg)
	end)

	RaidsSection = DFRaidMain.CreateSection("Raids")
	mainMinimal = next

	do
		local Raids, v7 = require(game.ReplicatedStorage.Raids)
		name = {}
		state = Raids
		npcNames = v7
	end

	for _, v7 in mainMinimal, state, npcNames do
		for _, v8 in next, v7, nil do
			table.insert(name, v8)
		end
	end

	RaidsSection.CreateDropdown({
		Title = "Select Raid",
		List = name,
		Search = true,
		Selected = false,
		Default = Settings["Select Raid"] or nil,
	}, function(arg)
		SaveSettings("Select Raid", arg)
	end)

	RaidsSection.CreateToggle({
		Title = "Get Fruit In Inventory Low Beli",
		Desc = nil,
		Default = Settings["Get Fruit In Inventory Low Beli"] or false,
	}, function(arg)
		SaveSettings("Get Fruit In Inventory Low Beli", arg)
	end)

	getgenv().KillRaidEnemy = function()
		KillAuraSweep(100000)
	end

	getgenv().KillRaidEnemyLowhealth = function()
		for _, child in ipairs(game.workspace.Enemies:GetChildren()) do
			if IsMobAlive(child) and child.Humanoid.Health / child.Humanoid.MaxHealth < 0.2 then
				child.Humanoid.Health = 0
			end
		end
	end

	DetectMobRaid = function()
		for _, child in ipairs(game.workspace.Enemies:GetChildren()) do
			if IsMobAlive(child) and localPlayer:DistanceFromCharacter(child.HumanoidRootPart.Position) <= 400 then
				return child
			end
		end
	end

	RaidBringState = { mob = nil, spot = nil, last = 0 }
	BringMobRaid = function(n)if not Settings["Bring Mob"]or not n or not n:FindFirstChild("HumanoidRootPart")then return;end;if RaidBringState.mob~=n then RaidBringState.mob=n;RaidBringState.spot=n.HumanoidRootPart.CFrame;DeleteIgnoredMob();end;if tick()-RaidBringState.last<0.1 then return;end;RaidBringState.last=tick();local L=RaidBringState.spot;local U= localPlayer .Character and( localPlayer .Character:FindFirstChild("HumanoidRootPart"));if not L or not U or not IsNetworkOwnerPart(U)then return;end;if(U.Position-n.HumanoidRootPart.Position).Magnitude>50 then return;end;U={};if not n:FindFirstChild("Ignored")then table.insert(U,n);end;for c,c in ipairs(workspace.Enemies:GetChildren())do if#U>=2 then break;end;if c~=n and c.Name==n.Name and not c:FindFirstChild("Ignored")and(IsMobAlive(c))and(IsNetworkOwnerPart(c.HumanoidRootPart))and(c.HumanoidRootPart.Position-L.Position).Magnitude<=200 then table.insert(U,c);end;end;for c,c in ipairs(U)do SizePart(c);if IsNetworkOwnerPart(c.HumanoidRootPart)then c.HumanoidRootPart.CFrame=L*CFrame.new(math.random(-2,2),math.random(0,2),math.random(-2,2));end;end;end

	GetLastRaidIsland = function()
		local n = 0
		local v7 = nil

		for _, child in ipairs(wOrigin.Locations:GetChildren()) do
			if string.find(child.Name, "Island ") and localPlayer:DistanceFromCharacter(child.Position) < 3000 then
				local v8 = tonumber
				local str2 = child.Name:gsub("Island ", "")
				local v9 = v8(str2)

				if n < v9 then
					n = v9
					v7 = child
				end
			end
		end

		return v7
	end

	CheckInRaid = function()
		for _, child in ipairs(wOrigin.Locations:GetChildren()) do
			if string.find(child.Name, "Island ") and localPlayer:DistanceFromCharacter(child.Position) < 3000 then
				return true
			end
		end
	end

	getgenv().CheckIsplayingRaid = function()
		local flag = DetectItemPlr("Special Microchip") or not getgenv().buychip
		local visible

		if flag then
			visible = flag
		else
			visible = game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and CheckInRaid()
		end

		if visible then
			return true
		end
	end

	getgenv().buychip = true

	autoRaidHandleX = RaidsSection.CreateToggle({ Title = "Auto Raid", Desc = nil, Default = Settings["Auto Raid"] or false }, function(arg)
		local flag

		if arg then
			flag = not (Place_Id.sea2() or Place_Id.sea3())
		else
			flag = arg
		end

		if flag then
			SaveSettings("Auto Raid", false)

			if autoRaidHandleX and autoRaidHandleX.SetStage then
				autoRaidHandleX:SetStage(false)
			end

			VxezeNotify("Auto Raid", "Only works in Sea 2 or Sea 3", "warning", { Key = "gateAuto Raid" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Raid"] and task.wait(0.1) do
					local ok, result = pcall(function()
						local main = Place_Id.sea2() and game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button:FindFirstChild("Main")

						if Place_Id.sea3() then
							main = game:GetService("Workspace").Map:FindFirstChild("Boat Castle") and game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button:FindFirstChild("Main")
						end

						if not localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and not CheckInRaid() then
							if getgenv().TickTeleCastle and tick() - getgenv().TickTeleCastle < 5 then
								return
							end

							if not main then
								if not DetectItemPlr("Special Microchip") then
									ToTarget(CFrame.new(-5500, 314, -2855))
								else
									ToTarget(CFrame.new(-5500, 314, -2855), false, true)
								end

								return
							end
						end

						if DetectItemPlr("Special Microchip") then
							if getgenv().waitgoraid then
								wait(5)
								getgenv().waitgoraid = false
							end

							getgenv().buychip = false
							fireclickdetector(main.ClickDetector)
							getgenv().TickTeleCastle = tick()

							if getgenv().Tween then
								getgenv().Tween:Pause()
								getgenv().Tween:Cancel()
							end

							return
						end

						if localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and CheckInRaid() then
							getgenv().waitgoraid = true
							getgenv().buychip = true
							local v7 = DetectMobRaid()

							if v7 then
								while true do
									task.wait()
									KillAuraTick()
									UsedualFlock()
									ClickM1(v7)
									SizePart(v7)
									BringMobRaid(v7)

									if Settings["Select Weapon"] == "Blox Fruit" then
										ToTarget(v7.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										ToTarget(v7.HumanoidRootPart.CFrame * CFrame.new(10, 20, 0))
									end

									if IsMobAlive(v7) then
										continue
									end
									break
								end
							else
								local v8 = GetLastRaidIsland()

								if v8 then
									if v8.Name == "Island 2" and Settings["Select Raid"] == "Phoenix" then
										ToTarget(v8.CFrame * CFrame.new(300, 60, 0))
									else
										ToTarget(v8.CFrame * CFrame.new(0, 60, 0))
									end
								end
							end

							return
						end

						if getgenv().buychip and localPlayer.Data.Level.Value >= 1100 and not localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and not DetectItemPlr("Special Microchip") and not CheckInRaid() then
							if Settings["Hop Sever Raid"] then
								local v7 = GetPathFruit()

								if v7 then
									if not ((v7.Handle.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5) then
										ToTarget(v7.Handle.CFrame, true)
									end

									return
								end

								if not CheckFruitplr() then
									HopServer()
									wait(5)
									return
								end
							end

							if not CheckFruitplr() and TakeFruitInventory(true) and Settings["Get Fruit In Inventory Low Beli"] then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", TakeFruitInventory(true))
							end

							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Check")
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", Settings["Select Raid"] or "Flame")
							wait(1)
						end
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Raid", arg)
	end)

	RaidsSection.CreateToggle({ Title = "Hop Sever Raid", Desc = nil, Default = Settings["Hop Sever Raid"] or false }, function(arg)
		if arg and not Settings["Auto Raid"] then
			VxezeNotify("Auto Raid", "Turn On Auto Raid Plz", "warning")
		end

		SaveSettings("Hop Sever Raid", arg)
	end)

	RaidsSection.CreateToggle({ Title = "Auto Awake Fruit", Desc = nil, Default = Settings["Auto Awake Fruit"] or false }, function(arg)
		SaveSettings("Auto Awake Fruit", arg)
	end)

	MultiRaidsSection = DFRaidMain.CreateSection("Multi Raid")

	DetectNamePlayerMulti = function()
		local tbl12 = {}
		local v7 = pairs
		local Players2 = game:GetService("Players")

		for _, child in v7(Players2:GetChildren()) do
			if child.Name ~= localPlayer.Name then
				tbl12[child.Name] = false
			end
		end

		return tbl12
	end

	do
		local createDropdown = MultiRaidsSection.CreateDropdown
		local selectPlayerMultiRaid = Settings["Select Player Multi Raid"]

		DropdownSelectPlayerMultiRaid = createDropdown({
			Title = "Select Player Multi Raid",
			List = PrepareMultiSelectList(DetectNamePlayerMulti(), selectPlayerMultiRaid),
			Search = true,
			Selected = true,
			Default = Settings["Select Player Multi Raid"] or nil,
		}, function(arg, arg2)
			SaveSettings("Select Player Multi Raid", arg, arg2)
		end)
	end

	MultiRaidsSection.CreateButton({ Title = "Refresh Player" }, function()
		DropdownSelectPlayerMultiRaid:GetNewList(DetectNamePlayerMulti())
	end)

	MultiRaidsSection.CreateToggle({ Title = "Account Buy Chip", Desc = nil, Default = Settings["Account Buy Chip"] or false }, function(arg)
		SaveSettings("Account Buy Chip", arg)
	end)

	MultiRaidsSection.CreateToggle({
		Title = "Account Pick Slot Raid",
		Desc = nil,
		Default = Settings["Account Pick Slot Raid"] or false,
	}, function(arg)
		SaveSettings("Account Pick Slot Raid", arg)
	end)

	DetectSlotRaid = function(arg)
		local v7 = next
		local children, v8 = arg:GetChildren()

		for _, v9 in v7, children, v8 do
			if v9:FindFirstChild("Hitbox") and v9.Color.BrickColor.Name ~= "Lime green" then
				return v9
			end
		end
	end

	NearSlotRaid = function(arg)
		local v7 = next
		local children, v8 = arg:GetChildren()

		for _, v9 in v7, children, v8 do
			if v9:FindFirstChild("Hitbox") then
				if localPlayer:DistanceFromCharacter(v9.Hitbox.Position) < 10 then
					return true
				end
			end
		end
	end

	DetectMultiStartRaid = function(arg)
		local tbl12 = {}

		if Settings["Select Player Multi Raid"] then
			local v7 = next
			local children, v8 = arg:GetChildren()

			for _, v9 in v7, children, v8 do
				if v9:FindFirstChild("Hitbox") then
					for k in next, Settings["Select Player Multi Raid"], nil do
						local v10 = game.Players:FindFirstChild(k)

						if v10 and v10:DistanceFromCharacter(v9.Hitbox.Position) > 10 then
							table.insert(tbl12, k)
						end
					end
				end
			end
		end

		if #tbl12 == 0 then
			return true
		end
	end

	Multiraid = function(arg)
		local main = Place_Id.sea2() and game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button:FindFirstChild("Main")

		if Place_Id.sea3() then
			main = game:GetService("Workspace").Map:FindFirstChild("Boat Castle") and game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button:FindFirstChild("Main")
		end

		if not localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and not CheckInRaid() then
			if not main then
				if not DetectItemPlr("Special Microchip") then
					ToTarget(CFrame.new(-5500, 314, -2855))
				else
					ToTarget(CFrame.new(-5500, 314, -2855), false, true)
				end

				return
			end
		end

		if Settings["Account Pick Slot Raid"] then
			if not localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and not CheckInRaid() and not NearSlotRaid(main.Parent.Parent) then
				local v7 = Random.new():NextNumber(0, 2)
				task.wait(v7)
				ToTarget(DetectSlotRaid(main.Parent.Parent).Hitbox.CFrame * CFrame.new(0, -2, 0))
			end
		end

		if DetectItemPlr("Special Microchip") then
			if getgenv().waitgoraid then
				wait(5)
				getgenv().waitgoraid = false
			end

			getgenv().buychip = false

			if DetectMultiStartRaid(main.Parent.Parent) and Settings["Account Buy Chip"] then
				fireclickdetector(main.ClickDetector)
			end

			if getgenv().Tween then
				getgenv().Tween:Pause()
				getgenv().Tween:Cancel()
			end

			return
		end

		if localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and CheckInRaid() then
			getgenv().waitgoraid = true
			getgenv().buychip = true
			local v7 = DetectMobRaid()

			if v7 then
				while true do
					task.wait()
					UsedualFlock()
					ClickM1(v7)

					if Settings["Select Weapon"] == "Blox Fruit" then
						ToTarget(v7.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						ToTarget(v7.HumanoidRootPart.CFrame * CFrame.new(10, 20, 0))
					end

					if IsMobAlive(v7) then
						continue
					end
					break
				end
			else
				local v8 = GetLastRaidIsland()

				if v8 then
					if v8.Name == "Island 2" and Settings["Select Raid"] == "Phoenix" then
						ToTarget(v8.CFrame * CFrame.new(300, 60, 0))
					else
						ToTarget(v8.CFrame * CFrame.new(0, 60, 0))
					end
				end
			end

			return
		end

		if Settings["Account Buy Chip"] and getgenv().buychip and localPlayer.Data.Level.Value >= 1100 and not localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and not DetectItemPlr("Special Microchip") and not CheckInRaid() then
			if not CheckFruitplr() and TakeFruitInventory(true) and Settings["Get Fruit In Inventory Low Beli"] then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", TakeFruitInventory(true))
			end

			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Check")
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", arg or "Flame")
			wait(1)
		end
	end

	autoMultiRaidHandleX = MultiRaidsSection.CreateToggle({ Title = "Auto Multi Raid", Desc = nil, Default = Settings["Auto Multi Raid"] or false }, function(arg)
		local flag

		if arg then
			flag = not (Place_Id.sea2() or Place_Id.sea3())
		else
			flag = arg
		end

		if flag then
			SaveSettings("Auto Multi Raid", false)

			if autoMultiRaidHandleX and autoMultiRaidHandleX.SetStage then
				autoMultiRaidHandleX:SetStage(false)
			end

			VxezeNotify("Auto Multi Raid", "Only works in Sea 2 or Sea 3", "warning", { Key = "gateAuto Multi Raid" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Multi Raid"] and task.wait(0.1) do
					local ok, result = pcall(function()
						Multiraid(Settings["Select Raid"])
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Multi Raid", arg)
	end)

	local FruitInfo = require(game:GetService("ReplicatedStorage").FruitInfo)

	StoreFruit = function(arg)
		for _, child in pairs(arg:GetChildren()) do
			if child:IsA("Tool") and string.find(child.Name, "Fruit") and not child:FindFirstChild("Ignored") then
				local v7 = string.gsub(child.Name, " Fruit", "")
				local attribute = child:GetAttribute("OriginalName") or v7 .. "-" .. v7

				pcall(function()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", attribute, child)
				end)

				local intValue = Instance.new("IntValue")
				intValue.Name = "Ignored"
				intValue.Parent = child

				if Settings["Webhook Store Fruit"] and Settings["Select Rarity Fruit"] and (FruitInfo.List[attribute] and Settings["Select Rarity Fruit"][FruitInfo.List[attribute].Rarity.Name] or SkinFruit[child.Name]) then
					local name_ = child.Name
					getgenv().WebhookStoreFruit(name_)
				end

				task.wait(2)
			end
		end
	end

	DetectFruitShop = function()
		local bloxFruitSniperShop = Settings["Blox Fruit Sniper Shop"]
		if type(bloxFruitSniperShop) ~= "table" then
			return
		end
		local v7 = next
		local v8, v9 = GetFruitsData(5)

		for _, v10 in v7, v8, v9 do
			if bloxFruitSniperShop[v10.Name] and v10.OnSale then
				return v10.Name
			end
		end
	end

	BuyFruitShop = function()
		local v7 = DetectFruitShop()

		if v7 and not Settings["Blox Fruit Sniper Shop"][localPlayer.Data.DevilFruit.Value] then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", v7)
		end
	end

	DungeonJoinSection = DFRaidMain.CreateSection("Join Dungeon")

	DetectNamePlayer = function()
		local tbl12 = {}
		local v7 = pairs
		local Players2 = game:GetService("Players")

		for _, child in v7(Players2:GetChildren()) do
			if child.Name ~= localPlayer.Name and not table.find(tbl12, child.Name) then
				table.insert(tbl12, child.Name)
			end
		end

		return tbl12
	end

	DropdownDropdownSelectAccountJoin = DungeonJoinSection.CreateDropdown({
		Title = "Select Account Join",
		List = DetectNamePlayer(),
		Search = true,
		Selected = false,
		Default = Settings["Select Account Join"] or nil,
	}, function(arg)
		SaveSettings("Select Account Join", arg)
	end)

	DungeonJoinSection.CreateButton({ Title = "Refresh Player" }, function()
		DropdownDropdownSelectAccountJoin:GetNewList(DetectNamePlayer())
	end)

	DetectPadJoinDungeon = function(arg)
		local v7 = next
		local children, v8 = workspace.Map["Simulation Hub"].Pads:GetChildren()

		for _, v9 in v7, children, v8 do
			local flag

			if arg then
				local userId = game.Players.LocalPlayer.UserId
				flag = v9:GetAttribute("Initiator") == userId
			else
				flag = arg
			end

			if flag or v9:GetAttribute("NumPlayersOnPad") == 0 then
				return v9
			end
		end
	end

	DungeonJoinSection.CreateSlider({
		Title = "Min Player Join Dungeon",
		Min = 0,
		Max = 4,
		Default = Settings["Min Player Join Dungeon"] or 2,
		Precise = false,
	}, function(arg)
		SaveSettings("Min Player Join Dungeon", arg)
	end)

	DungeonJoinSection.CreateDropdown({
		Title = "Select Difficulty",
		List = { "Normal", "Hard", "Challenge" },
		Search = true,
		Selected = false,
		Default = Settings["Select Difficulty"] or nil,
	}, function(arg)
		SaveSettings("Select Difficulty", arg)
	end)

	DungeonJoinSection.CreateToggle({
		Title = "Account Start Dungeon",
		Desc = "Account Start Dungeon",
		Default = Settings["Account Start Dungeon"] or false,
	}, function(arg)
		SaveSettings("Account Start Dungeon", arg)
	end)

	DungeonJoinSection.CreateToggle({
		Title = "Auto Join Dungeon",
		Desc = "Auto Join Dungeon",
		Default = Settings["Auto Join Dungeon"] or false,
	}, function(arg)
		if not arg then
			SaveSettings("Auto Join Dungeon", false)
			return
		end

		spawn(function()
			while Settings["Auto Join Dungeon"] and task.wait(0.1) do
				local ok, result = pcall(function()
					if game:GetService("ReplicatedStorage").DungeonReplicationObjects:FindFirstChildWhichIsA("Folder") then
						return
					end

					if Settings["Account Start Dungeon"] then
						if not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("DungeonQueueSettingsMenu") or not game:GetService("Players").LocalPlayer.PlayerGui.DungeonQueueSettingsMenu.Enabled then
							local v7 = DetectPadJoinDungeon()

							if v7 then
								ToTarget(v7.PrimaryPart.CFrame * CFrame.new(0, 5, 0))
							end
						else
							local v7 = DetectPadJoinDungeon(true)
							if not v7 then
								return
							end
							local attribute = v7 and v7:GetAttribute("NumPlayersOnPad") or 0
							local selectDifficulty = Settings["Select Difficulty"] or "Normal"

							if v7:GetAttribute("Difficulty") ~= selectDifficulty then
								v7.DungeonSettingsChanged:FireServer(unpack({ "Difficulty", selectDifficulty }))
							end

							if Settings["Min Player Join Dungeon"] <= attribute then
								v7:FindFirstChild("DungeonSettingsChanged"):FireServer("Start")
								wait(2)
							end
						end
					elseif not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("DungeonQueueSettingsMenu") or not game:GetService("Players").LocalPlayer.PlayerGui.DungeonQueueSettingsMenu.Enabled then
						local v7 = game:GetService("Players"):FindFirstChild(Settings["Select Account Join"] or "")

						if v7 then
							ToTarget(v7.Character.HumanoidRootPart.CFrame)
						end
					end
				end)

				if result then
					PrintOnce(result)
				end
			end
		end)

		SaveSettings("Auto Join Dungeon", arg)
	end)

	DungeonSection = DFRaidMain.CreateSection("Dungeon")

	DungeonSection.CreateDropdown({
		Title = "Select Weapon Dungeon",
		List = { "Melee", "Sword", "Blox Fruit", "Gun" },
		Search = true,
		Selected = false,
		Default = Settings["Select Weapon Dungeon"] or nil,
	}, function(arg)
		SaveSettings("Select Weapon Dungeon", arg)
	end)

	GetInfoDungeon = function(arg)
		local v7 = game.ReplicatedStorage:WaitForChild("DungeonReplicationObjects"):FindFirstChild(arg, true)
		if v7 then
			return v7
		end
	end

	GetCurrentFloor = function()
		local attribute = localPlayer:GetAttribute("ExplorerGUID")
		local v7 = attribute and GetInfoDungeon(attribute)
		if v7 then
			return v7:GetAttribute("FloorId")
		end
	end

	GetHightFloor = function()
		local attribute = localPlayer:GetAttribute("ExplorerGUID")
		attribute = attribute and GetInfoDungeon(attribute)
		if attribute then
			return attribute.Parent.Parent:GetAttribute("CurrentExploredLevel")
		end
	end

	IsPointInsideModel = function(arg, arg2)
		if not arg or not arg:IsA("Model") then
			return false
		end
		local boundingBox, v7 = arg:GetBoundingBox()
		local v8 = boundingBox:PointToObjectSpace(arg2)
		local n = v7 * 0.5
		local x = n.X
		local flag = math.abs(v8.X) <= x

		if flag then
			local y = n.Y
			flag = math.abs(v8.Y) <= y
		end

		if flag then
			local z = n.Z
			flag = math.abs(v8.Z) <= z
		end

		return flag
	end

	DetectMobDungeon = function()
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not character then
			return nil
		end
		local v7 = GetHightFloor()
		if not v7 then
			return nil
		end
		local v8 = workspace.Map.Dungeon:FindFirstChild(tostring(v7))
		if not v8 then
			return nil
		end
		local huge = math.huge
		local v9 = nil

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if IsMobAlive(child) and child.Name ~= "Blank Buddy" then
				local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")
				child:FindFirstChildOfClass("Humanoid")

				if humanoidRootPart and IsPointInsideModel(v8, humanoidRootPart.Position) then
					local magnitude = (humanoidRootPart.Position - character.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						v9 = child
					end
				end
			end
		end

		return v9
	end

	DetectPropHitboxPlaceholder = function()
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not character then
			return nil
		end
		local v7 = GetHightFloor()
		if not v7 then
			return nil
		end
		local v8 = workspace.Map.Dungeon:FindFirstChild(tostring(v7))
		if not v8 then
			return nil
		end
		local huge = math.huge
		local v9 = nil

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if IsMobAlive(child) and child.Name == "PropHitboxPlaceholder" then
				local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")
				child:FindFirstChildOfClass("Humanoid")

				if humanoidRootPart and IsPointInsideModel(v8, humanoidRootPart.Position) then
					local magnitude = (humanoidRootPart.Position - character.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						v9 = child
					end
				end
			end
		end

		return v9
	end

	ExplorerBuffs = require(game:GetService("ReplicatedStorage").DungeonShared.ExplorerBuffs)

	StripFont = function(arg)
		return (arg:gsub("<.->", ""))
	end

	DisplayNameToKey = {}

	for k, explorerBuff in pairs(ExplorerBuffs.ExplorerBuffs) do
		if explorerBuff.DisplayName then
			DisplayNameToKey[StripFont(explorerBuff.DisplayName)] = k
		end
	end

	CORE_BUFF_KEYS = {
		"Lifesteal",
		"AllCooldown",
		"AttackSpeedMultiplier",
		"FruitTAPCooldown",
		"Armor",
		"Sniper",
		"Overflow",
		"Gun",
		"Sword",
		"Melee",
		"Fruit",
		"Defense",
	}

	TableCardpriority = {}

	for _, v7 in ipairs(CORE_BUFF_KEYS) do
		local v8 = ExplorerBuffs.ExplorerBuffs[v7]

		if v8 and v8.DisplayName then
			table.insert(TableCardpriority, StripFont(v8.DisplayName))
		end
	end

	IsSkillCooldown = function(arg)
		if not arg then
			return false
		end

		if arg:find("Cooldown") then
			if arg:find("ZCooldown") or arg:find("XCooldown") or arg:find("CCooldown") or arg:find("VCooldown") then
				return true
			end
		end

		return false
	end

	DungeonSection.CreateDropdown({
		Title = "Select Card Priority",
		List = TableCardpriority,
		Search = true,
		Priority = true,
		Default = Settings["Select Card Priority"] or {},
	}, function(arg)
		if typeof(arg) ~= "table" then
			return
		end
		SaveSettings("Select Card Priority", table.clone(arg))
	end)

	AutoPickDungeonCard = function()
		local selectCardPriority = Settings["Select Card Priority"] or {}
		local tbl12 = {}
		local huge = math.huge
		local v7 = nil

		for _, child in pairs(localPlayer.PlayerGui:GetChildren()) do
			local displayName = child:FindFirstChild("DisplayName", true)
			local buffDescription = child:FindFirstChild("BuffDescription", true)
			local textButton = child:FindFirstChildWhichIsA("TextButton", true)

			if displayName and buffDescription and textButton and displayName:IsA("TextLabel") then
				local v8 = DisplayNameToKey[StripFont(displayName.Text)]

				if v8 then
					if not IsSkillCooldown(v8) then
						for i_, v9 in ipairs(selectCardPriority) do
							if DisplayNameToKey[v9] == v8 then
								if i_ < huge then
									huge = i_
									v7 = textButton
								end

								break
							end
						end

						table.insert(tbl12, textButton)
					end
				end
			end
		end

		if v7 then
			print("AUTO PICK (PRIORITY INDEX):", huge)

			for _, v8 in pairs(getconnections(v7.Activated)) do
				v8.Function()
			end

			return true
		end

		if #tbl12 > 0 then
			local v8 = tbl12[math.random(1, #tbl12)]
			print("AUTO PICK (RANDOM)")

			for _, v9 in pairs(getconnections(v8.Activated)) do
				v9.Function()
			end

			return true
		end

		return false
	end

	DungeonSection.CreateToggle({
		Title = "Auto Attack Dungeon",
		Desc = "Auto Attack Mob and go next Floor",
		Default = Settings["Auto Attack Dungeon"] or false,
	}, function(arg)
		SaveSettings("Auto Attack Dungeon", arg)
		if not arg then
			return
		end

		task.spawn(function()
			while Settings["Auto Attack Dungeon"] do
				task.wait()

				local ok, result = pcall(function()
					if localPlayer.Character.Humanoid.Health <= 0 then
						return
					end
					local v7 = GetCurrentFloor()
					local v8 = GetHightFloor()
					if not v7 or not v8 then
						return
					end

					if v7 ~= v8 then
						getgenv().AutoDungeonNextFloor = true
						local v9 = workspace.Map.Dungeon:FindFirstChild(tostring(v8 - 1))

						if v9 and v9:FindFirstChild("ExitTeleporter") and v9.ExitTeleporter:FindFirstChild("Root") and v9.ExitTeleporter.Root:FindFirstChild("TouchInterest") then
							if localPlayer:DistanceFromCharacter(v9.ExitTeleporter.Root.Position) > 15 then
								task.wait(1)
								ToTarget(v9.ExitTeleporter.Root.CFrame * CFrame.new(0, 5, 0))
							else
								task.wait(3)
							end
						end

						return
					end

					if getgenv().AutoDungeonNextFloor then
						TweenManager.CancelCurrent()
						getgenv().AutoDungeonNextFloor = false
					end

					local v9 = DetectMobDungeon()
					local v10 = DetectPropHitboxPlaceholder()
					if not v9 or not IsMobAlive(v9) then
						return
					end

					if v10 then
						while true do
							task.wait()

							if not Settings["Auto Attack Dungeon"] then
								break
							else
								if IsMobAlive(v10) then
									if not (not GetCurrentFloor() or GetCurrentFloor() ~= GetHightFloor()) then
										local selectWeaponDungeon = Settings["Select Weapon Dungeon"] or "Melee"
										EquipTool(NameWeapon(selectWeaponDungeon))

										if selectWeaponDungeon == "Gun" then
											if NameWeapon(selectWeaponDungeon) == "Dragonstorm" then
												SpamGunDragonStorm(v10.HumanoidRootPart)
											else
												ShootM1(v10)
											end
										else
											ClickM1Dungeon(v10)
										end

										SizePart(v10)

										if selectWeaponDungeon == "Blox Fruit" then
											ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 12, 0))
										else
											ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(10, 20, 0))
										end

										if not (localPlayer.Character.Humanoid.Health <= 0) then
											continue
										end
									end
								end

								break
							end
						end
					else
						while true do
							task.wait()

							if not Settings["Auto Attack Dungeon"] then
								break
							else
								if IsMobAlive(v9) then
									if not (not GetCurrentFloor() or GetCurrentFloor() ~= GetHightFloor()) then
										local selectWeaponDungeon = Settings["Select Weapon Dungeon"] or "Melee"
										EquipTool(NameWeapon(selectWeaponDungeon))

										if selectWeaponDungeon == "Gun" then
											if NameWeapon(selectWeaponDungeon) == "Dragonstorm" then
												SpamGunDragonStorm(v9.HumanoidRootPart)
											else
												ShootM1(v9)
											end
										else
											ClickM1Dungeon(v9)
										end

										SizePart(v9)

										if selectWeaponDungeon == "Blox Fruit" then
											ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 12, 0))
										else
											ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(10, 20, 0))
										end

										if not (localPlayer.Character.Humanoid.Health <= 0 or DetectPropHitboxPlaceholder()) then
											continue
										end
									end
								end

								break
							end
						end
					end
				end)

				if result then
					warn("[Auto Dungeon Error]:", result)
				end
			end
		end)
	end)

	DungeonSection.CreateToggle({
		Title = "Auto Pick Card Dungeon",
		Desc = nil,
		Default = Settings["Auto Pick Card Dungeon"] or false,
	}, function(arg)
		SaveSettings("Auto Pick Card Dungeon", arg)
		if not arg then
			return
		end

		task.spawn(function()
			while Settings["Auto Pick Card Dungeon"] do
				task.wait()

				local ok, result = pcall(function()
					AutoPickDungeonCard()
				end)

				if result then
					warn("[Auto Pick Card Dungeon Error]:", result)
				end
			end
		end)
	end)

	local tbl12

	do
		local tbl13 = {
			["Zone 1"] = CFrame.new(-21767.4765625, 0, 5815.41259765625),
			["Zone 2"] = CFrame.new(-26017.931640625, 0, 5657.8837890625),
			["Zone 3"] = CFrame.new(-29545.703125, 0, 6377.98974609375),
			["Zone 4"] = CFrame.new(-33609.7578125, 0, 7422.890625),
			["Zone 5"] = CFrame.new(-38480.42578125, 0, 10350.943359375),
			["Zone 6"] = CFrame.new(-32975.9921875, 0, 25963.7109375),
		}

		tbl12 = { Melee = false, Sword = false, Gun = false, ["Blox Fruit"] = false }
		SeaEventTab = Main.CreatePage({ Page_Name = "Sea Event", Page_Title = "Sea Event Tab" })
		SettingSeaEventSection = SeaEventTab.CreateSection("Setting")

		SettingSeaEventSection.CreateDropdown({
			Title = "Select Zone",
			List = { "Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Zone 6" },
			Search = true,
			Selected = false,
			Default = Settings["Select Zone"] or nil,
		}, function(arg)
			SaveSettings("Select Zone", arg)
		end)

		SettingSeaEventSection.CreateDropdown({
			Title = "Select Sea Events",
			List = PrepareMultiSelectList({
				SeaBeast = false,
				Ship = false,
				Shark = false,
				Terrorshark = false,
				Piranha = false,
				["Only Farm Ship Brigade"] = false,
			}, Settings["Select Sea Events"]),
			Search = true,
			Selected = true,
			Default = Settings["Select Sea Events"] or nil,
		}, function(arg, arg2)
			SaveSettings("Select Sea Events", arg, arg2)
		end)

		SettingSeaEventSection.CreateDropdown({
			Title = "Select Boat",
			List = { "Beast Hunter", "Guardian", "Lantern", "Seleigh", "Brigade", "GrandBrigade" },
			Search = true,
			Selected = false,
			Default = Settings["Select Boat"] or nil,
		}, function(arg)
			SaveSettings("Select Boat", arg)
		end)

		SettingSeaEventSection.CreateDropdown({
			Title = "Select Weapons Use Skill",
			List = PrepareMultiSelectList(tbl12, Settings["Select Weapons Use Skill"]),
			Search = true,
			Selected = true,
			Default = Settings["Select Weapons Use Skill"] or nil,
		}, function(arg, arg2)
			SaveSettings("Select Weapons Use Skill", arg, arg2)
		end)

		SettingSeaEventSection.CreateToggle({
			Title = "Use Dragonstorm For Sea Event",
			Desc = "Only Farm Boat and Fish and TerrorShark",
			Default = Settings["Use Dragonstorm For Sea Event"] or false,
		}, function(arg)
			SaveSettings("Use Dragonstorm For Sea Event", arg)
		end)

		SettingSeaEventSection.CreateToggle({
			Title = "Use Click M1 Skull Guitar For Sea Event",
			Desc = "Only Farm Boat and Seabeast",
			Default = Settings["Use Click M1 Skull Guitar For Sea Event"] or false,
		}, function(arg)
			SaveSettings("Use Click M1 Skull Guitar For Sea Event", arg)
		end)

		SettingSeaEventSection.CreateToggle({
			Title = "Auto Change Dragonstorm With Skull Guitar",
			Desc = "When Kill Boat and Fish and TerrorShark use Dragonstorm\nKill Seabeast use Seabeast",
			Default = Settings["Auto Change Dragonstorm With Skull Guitar"] or false,
		}, function(arg)
			SaveSettings("Auto Change Dragonstorm With Skull Guitar", arg)
		end)

		SettingSeaEventSection.CreateToggle({
			Title = "Auto Change Dragonstorm When Kill Boat",
			Desc = nil,
			Default = Settings["Auto Change Dragonstorm When Kill Boat"] or false,
		}, function(arg)
			SaveSettings("Auto Change Dragonstorm When Kill Boat", arg)
		end)

		SettingSeaEventSection.CreateToggle({
			Title = "Use Click M1 Fruit For Sea Event",
			Desc = nil,
			Default = Settings["Use Click M1 Fruit For Sea Event"] or false,
		}, function(arg)
			SaveSettings("Use Click M1 Fruit For Sea Event", arg)
		end)

		SettingSeaEventSection.CreateToggle({
			Title = "Reset Character Buy Boat",
			Desc = "if u spawn in tiki it will reset for buy boat",
			Default = Settings["Reset Character Buy Boat"] or false,
		}, function(arg)
			SaveSettings("Reset Character Buy Boat", arg)
		end)

		SettingSeaEventSection.CreateToggle({
			Title = "Auto Dodge Skill Terrorshark",
			Desc = nil,
			Default = Settings["Auto Dodge Skill Terrorshark"] or false,
		}, function(arg)
			SaveSettings("Auto Dodge Skill Terrorshark", arg)
		end)

		local tbl14 = { "rbxassetid://8708221792", "rbxassetid://8708222556" }

		game.workspace._WorldOrigin.ChildAdded:Connect(function(child)
			if (Settings["Auto Sea Event"] or Settings["Auto Shipwright"]) and Settings["Auto Dodge Skill Terrorshark"] and getgenv().PathTerrorshark then
				local flag = child:IsA("Part") and (child.Name == "SharkSplash" or child.Name == "ChargeUp")

				if flag then
					local position = child.Position
					flag = (getgenv().PathTerrorshark.HumanoidRootPart.Position - position).Magnitude < 20
				end

				if flag then
					Doding = true
					ReadyToDodge = true
					local now = tick()

					while true do
						wait(0.2)
						if not (not child or not child.Parent or tick() - now > 14) then
							continue
						end
						break
					end

					if tick() - now < 1 then
						wait(2.5)
					end

					Doding = false
					ReadyToDodge = false
				end
			end
		end)

		getgenv().PosDodgeskill = 0

		AddAnimationSeabeastPlayed = function(arg)
			local animationPlayed = arg.Humanoid.AnimationPlayed

			getgenv().PathAnimationSeabit = animationPlayed:Connect(function(arg2)
				if table.find(tbl14, tostring(arg2.Animation.AnimationId)) then
					getgenv().PosDodgeskill = 0

					if tostring(arg2.Animation.AnimationId) == "rbxassetid://8708222556" then
						task.wait(0.7)
					else
						task.wait(1.9)
					end

					local now = tick()
					getgenv().PosDodgeskill = 600

					while true do
						task.wait()
						if not (not arg2.IsPlaying or tick() - now >= 10) then
							continue
						end
						break
					end

					getgenv().PosDodgeskill = 0
				end
			end)
		end

		SettingSeaEventSection.CreateToggle({
			Title = "Auto Dodge Skill Seabeast",
			Desc = "Dodge Only Skill Kameha and waterbeam",
			Default = Settings["Auto Dodge Skill Seabeast"] or false,
		}, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Dodge Skill Seabeast"] and task.wait(0.15) do
						pcall(function()
							if getgenv().PathSeaBeast then
								local pathSeaBeast = getgenv().PathSeaBeast

								spawn(function()
									AddAnimationSeabeastPlayed(pathSeaBeast)
								end)

								while true do
									wait(0.1)
									if not (not pathSeaBeast or not pathSeaBeast.Parent or getgenv().PathSeaBeast ~= pathSeaBeast or not Settings["Auto Dodge Skill Seabeast"]) then
										continue
									end
									break
								end

								if getgenv().PathAnimationSeabit then
									getgenv().PathAnimationSeabit:Disconnect()
								end
							end
						end)
					end
				end)
			end

			SaveSettings("Auto Dodge Skill Seabeast", arg)
		end)

		SettingSeaEventSection.CreateToggle({
			Title = "Teleport Boat Other CFrame if Rough Sea",
			Desc = nil,
			Default = Settings["Teleport Boat Other CFrame if Rough Sea"] or false,
		}, function(arg)
			SaveSettings("Teleport Boat Other CFrame if Rough Sea", arg)
		end)

		SettingSeaEventSection.CreateToggle({
			Title = "Tween Until Have Sea Event",
			Desc = "When there's a sea event, it will stop to fight, and after finishing the fight, it will continue tweening",
			Default = Settings["Tween Until Have Sea Event"] or false,
		}, function(arg)
			SaveSettings("Tween Until Have Sea Event", arg)
		end)

		SettingSeaEventSection.CreateToggle({
			Title = "Will Back When over 10km",
			Desc = nil,
			Default = Settings["Will Back When over 10km"] or false,
		}, function(arg)
			SaveSettings("Will Back When over 10km", arg)
		end)

		SetCharacterCollidable = function(arg)
			local character = localPlayer and localPlayer.Character
			if not character then
				return
			end

			for _, descendant in ipairs(character:GetDescendants()) do
				if descendant:IsA("BasePart") then
					descendant.CanCollide = not arg
				end
			end
		end

		local obj = setmetatable({}, { __mode = "k" })
		local n = 0
		local boatSpeed = getgenv().BoatSpeed

		if type(boatSpeed) ~= "table" then
			boatSpeed = { cap = 100, ceiling = math.huge, nextRaise = 0 }
			getgenv().BoatSpeed = boatSpeed
		end

		local n3 = 5

		GetPingSeconds = function()
			local ok, result = pcall(function()
				return game:GetService("Stats").PerformanceStats.Ping:GetValue()
			end)

			return ok and result / 1000 or 0.1
		end

		ManageTween = function(arg, target, arg2, arg3)
			if not arg or not arg:IsA("BasePart") or typeof(target) ~= "CFrame" then
				return
			end
			local speed = math.max(tonumber(Settings["Value Speed Tween Boat"]) or tonumber(arg2) or 350, 1)
			arg3 = arg3 or "TweenBoat"
			if not obj[arg] and (arg.Position - target.Position).Magnitude <= n3 then
				return
			end
			local v7 = obj[arg]

			if v7 and v7.TweenKey == arg3 and v7.PlaybackState == Enum.PlaybackState.Playing then
				v7.Target = target
				v7.Speed = speed
				getgenv()[arg3] = v7
				return v7
			end

			if v7 then
				v7:Cancel()
			end

			local v8 = getgenv()[arg3]

			if v8 then
				pcall(function()
					v8:Cancel()
				end)
			end

			local tbl15 = { PlaybackState = Enum.PlaybackState.Playing, Speed = speed, Target = target, TweenKey = arg3 }
			local flag = false
			local flag2 = false
			local flag3 = false
			local cFrame = arg.CFrame

			local function fn(playbackState)
				if flag3 then
					return
				end
				flag3 = true
				tbl15.PlaybackState = playbackState
				n = math.max(n - 1, 0)

				if obj[arg] == tbl15 then
					obj[arg] = nil
				end

				if getgenv()[arg3] == tbl15 then
					getgenv()[arg3] = nil
				end

				local flag4 = n == 0

				if flag4 then
					flag4 = not (type(ToggleNoclip) == "function" and ToggleNoclip() == true)
				end

				if flag4 then
					SetCharacterCollidable(false)
					getgenv().noclip = false
				end
			end

			tbl15.Play = function(arg4)
				if flag3 then
					return
				end
				flag2 = false
				arg4.PlaybackState = Enum.PlaybackState.Playing
			end

			tbl15.Pause = function(arg4)
				if flag3 then
					return
				end
				flag2 = true
				arg4.PlaybackState = Enum.PlaybackState.Paused
			end

			tbl15.Cancel = function()
				if flag3 then
					return
				end
				flag = true
				fn(Enum.PlaybackState.Cancelled)
			end

			tbl15.Destroy = function(arg4)
				arg4:Cancel()
			end

			obj[arg] = tbl15
			getgenv()[arg3] = tbl15
			n += 1
			SetCharacterCollidable(true)
			getgenv().noclip = true

			task.spawn(function()
				while true do
					if not flag and not flag3 and arg.Parent then
						local result = RunService.Heartbeat:Wait()

						if not flag2 then
							local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

							if not humanoid or humanoid.SeatPart ~= arg then
								WarnOnce("BoatNotSeated", "Chua ngoi tren ghe thuyen nen server khong nhan vi tri tween. Da dung tween.")
								fn(Enum.PlaybackState.Cancelled)
								break
							else
								local n4 = math.min(tbl15.Speed, boatSpeed.cap)
								local target2 = tbl15.Target
								local magnitude = (target2.Position - cFrame.Position).Magnitude
								local n5 = n4 * result
								local magnitude2 = (arg.Position - cFrame.Position).Magnitude

								if math.max(20, n5 * 3) < magnitude2 then
									boatSpeed.ceiling = n4 * 0.9
									boatSpeed.cap = math.max(n4 * 0.7, 40)
									local max = math.max
									boatSpeed.nextRaise = tick() + max(GetPingSeconds() * 4, 1)
									cFrame = arg.CFrame
									n5 = boatSpeed.cap * result
									magnitude = (target2.Position - cFrame.Position).Magnitude
								else
									local flag4 = magnitude > n5 and boatSpeed.cap <= tbl15.Speed and boatSpeed.cap < boatSpeed.ceiling

									if flag4 then
										local nextRaise = boatSpeed.nextRaise
										flag4 = tick() >= nextRaise
									end

									if flag4 then
										boatSpeed.cap = math.min(boatSpeed.cap * 1.08, boatSpeed.ceiling)
										local max = math.max
										boatSpeed.nextRaise = tick() + max(GetPingSeconds() * 4, 1)
									end
								end

								if magnitude <= n5 or magnitude <= n3 then
									cFrame = target2
									arg.CFrame = target2
									arg.AssemblyLinearVelocity = Vector3.zero
									arg.AssemblyAngularVelocity = Vector3.zero
									fn(Enum.PlaybackState.Completed)
									break
								else
									cFrame = cFrame:Lerp(target2, n5 / magnitude)
									arg.CFrame = cFrame
									arg.AssemblyLinearVelocity = Vector3.zero
									arg.AssemblyAngularVelocity = Vector3.zero
									continue
								end
							end
						else
							continue
						end
					end

					break
				end

				if not flag3 then
					fn(Enum.PlaybackState.Cancelled)
				end
			end)

			return tbl15
		end

		TweenBoatToTarget = function(arg, arg2, arg3)
			if not (arg and arg:FindFirstChild("VehicleSeat")) then
				return
			end
			return ManageTween(arg.VehicleSeat, arg2, arg3 or 350, "TweenBoat")
		end

		CancelBoatTween = function()
			local tweenBoat = getgenv().TweenBoat

			if tweenBoat then
				pcall(function()
					tweenBoat:Cancel()
				end)
			end

			getgenv().TweenBoat = nil
		end

		NoclipBoat = function(arg)
			for _, descendant in ipairs(arg:GetDescendants()) do
				if (descendant:IsA("BasePart") or descendant:IsA("Part") or descendant:IsA("MeshPart")) and descendant.CanCollide then
					descendant.CanCollide = false
				end
			end
		end

		TurnOffNoclipBoat = function(arg)
			for _, descendant in ipairs(arg:GetDescendants()) do
				if (descendant:IsA("BasePart") or descendant:IsA("Part") or descendant:IsA("MeshPart")) and not descendant.CanCollide then
					descendant.CanCollide = true
				end
			end
		end

		BuyBoatAndTeleBoat = function(arg)
			local v7 = CheckBoat()

			if Settings["Auto Sea Event With Friend"] and Settings["Auto Sea Event"] then
				local selectFriend = Settings["Select Friend"]
				ToTarget(game:GetService("Players")[selectFriend].Character.HumanoidRootPart.CFrame)
				return
			end

			if not Settings["Auto Sea Event"] and not arg then
				return
			end

			if not v7 or v7 and localPlayer:DistanceFromCharacter(v7.VehicleSeat.Position) >= 4000 then
				local cframe = CFrame.new(-13.488054275512695, 10.311711311340332, 2927.692)

				if Place_Id.sea3() then
					cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
				end

				if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
					if localPlayer:DistanceFromCharacter(cframe.Position) > 1000 and Place_Id.sea3() then
						if Settings["Reset Character Buy Boat"] then
							if not localPlayer:GetAttribute("CurrentLocation") or localPlayer:GetAttribute("CurrentLocation") ~= "Tiki Outpost" then
								if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki" or game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki2" then
									localPlayer.Character.Humanoid.Health = 0
									return
								end
							end
						end
					end

					ToTarget(cframe)
				else
					local selectBoat = Settings["Select Boat"]
					if not selectBoat then
						WarnOnce("SelectBoat", "Chon thuyen o Sea Event > Select Boat truoc da.")
						return
					end
					local flag = selectBoat == "Brigade"
					local commF = game:GetService("ReplicatedStorage").Remotes.CommF_
					local invokeServer = commF.InvokeServer
					local str2

					if flag or selectBoat == "GrandBrigade" then
						str2 = "Pirate" .. selectBoat
					else
						str2 = selectBoat
					end

					invokeServer(commF, "BuyBoat", str2)
					task.wait(3)
				end
			else
				task.spawn(function()
					NoclipBoat(v7)
				end)

				if Settings["Tween Until Have Sea Event"] then
					local cframe = CFrame.new(-118834.515625, v7.WorldPivot.Y, 999920.04941558838)

					if not localPlayer.Character.Humanoid.Sit then
						ToTarget(v7.VehicleSeat.CFrame)
					else
						TweenBoatToTarget(v7, cframe, 350)
					end
				else
					local cframe = CFrame.new(654.3875732421875, v7.WorldPivot.Y, 6321.95947265625)
					local v8 = DecectPartRoughSea()

					if v8 then
						task.wait(1)
						local n4

						if roughSea == 0 then
							n4 = 7000
						else
							n4 = 0
						end

						roughSea = n4
						Instance.new("IntValue", v8).Name = "Ignored"
						task.wait(0.5)
					end

					getgenv().RoughSea = Settings["Teleport Boat Other CFrame if Rough Sea"] and roughSea or 0

					if Place_Id.sea3() then
						cframe = SelectedZoneCFrame() * CFrame.new(0, v7.WorldPivot.Y, 0 + RoughSea)
					end

					if (v7.VehicleSeat.Position - cframe.Position).Magnitude > 200 then
						local cframe2 = CFrame.new(cframe.Position.X, v7.WorldPivot.Y, cframe.Position.Z)

						if not localPlayer.Character.Humanoid.Sit then
							ToTarget(v7.VehicleSeat.CFrame)
						else
							TweenBoatToTarget(v7, cframe2, 350)
						end
					else
						if Settings["Auto Repair Ur Ship"] then
							if localPlayer.PlayerGui.Main.BottomHUDList.ShipHealthBar.Visible then
								local v9 = string.split(string.gsub(game:GetService("Players").LocalPlayer.PlayerGui.Main.BottomHUDList.ShipHealthBar.TextLabel.Text, "Ship ", ""), "/")

								if tonumber(v9[1]) < tonumber(v9[2]) then
									if localPlayer:DistanceFromCharacter(v7.PrimaryPart.Position) < 20 then
										if not localPlayer.Character.Humanoid.Sit then
											if localPlayer.Character:FindFirstChild("_RepairHammer") then
												if localPlayer.Character._RepairHammer:FindFirstChild("M1UP") then
													localPlayer.Character._RepairHammer.M1UP:Destroy()
												elseif not localPlayer.Character._RepairHammer:GetAttribute("Repairing") then
													localPlayer.Character._RepairHammer.M1Down:FireServer("Default")
													task.wait(0.5)
												end
											else
												game:GetService("ReplicatedStorage").Remotes.SubclassNetwork.UseSubclass:InvokeServer(unpack({ { Action = "RequestHammer" } }))
												task.wait(3)
											end
										else
											ToTarget(v7.PrimaryPart.CFrame * CFrame.new(0, 15, 0))
										end
									else
										ToTarget(v7.PrimaryPart.CFrame * CFrame.new(0, 15, 0))
									end

									return
								end
							end
						end

						if not arg then
							if not localPlayer.Character.Humanoid.Sit then
								ToTarget(v7.VehicleSeat.CFrame)
							end

							local cframe2 = CFrame.new(cframe.Position.X, v7.WorldPivot.Y, cframe.Position.Z)

							if DetectSeaEvents(true) then
								local now = tick()

								repeat
									task.wait()
									ToTarget(cframe2 * CFrame.new(0, 2500, 0))
								until tick() - now >= 12
							elseif localPlayer.Character.Humanoid.Sit then
								TweenBoatToTarget(v7, cframe2, 350)
							end
						end
					end
				end
			end
		end

		SafeMultiSelect = function(arg)
			local v7 = Settings[arg]

			if type(v7) ~= "table" then
				local tbl15 = {}
				Settings[arg] = tbl15
				v7 = tbl15
			end

			return v7
		end

		SelectedZoneCFrame = function()
			local selectZone = Settings["Select Zone"]
			return selectZone and tbl13[selectZone] or tbl13["Zone 1"]
		end
	end

	WarnOnce = function(arg, arg2)
		getgenv().__BFWarned = getgenv().__BFWarned or {}
		local v7 = getgenv().__BFWarned[arg]
		if v7 and tick() - v7 < 15 then
			return
		end
		getgenv().__BFWarned[arg] = tick()

		pcall(function()
			VxezeNotify("Sea Event", arg2, "warning", { Key = arg })
		end)
	end

	DetectSeaEvents = function(arg)
		local v7 = SafeMultiSelect("Select Sea Events")

		if arg or v7.SeaBeast then
			local v8 = next
			local children, v9 = game:GetService("Workspace").SeaBeasts:GetChildren()

			for _, v10 in v8, children, v9 do
				if v10.Name == "SeaBeast1" and v10:FindFirstChild("HumanoidRootPart") and v10:FindFirstChild("HealthBBG") then
					local text = v10.HealthBBG.Frame.TextLabel.Text
					local text2 = v10.HealthBBG.Frame.TextLabel.Text
					local v11 = tonumber
					local str2

					if string.find(text:gsub("/%d+,%d+", ""), ",") then
						str2 = text2:gsub("%d+,%d+/", "")
					else
						str2 = text2:gsub("%d+/", "")
					end

					local str3 = str2:gsub(",", "")
					if v11(str3) >= 90000 and localPlayer:DistanceFromCharacter(v10.HumanoidRootPart.Position) < 2000 then
						return v10
					end
				end
			end
		end

		if arg or v7.Terrorshark then
			local Terrorshark = CheckNameBoss("Terrorshark")
			if Terrorshark and localPlayer:DistanceFromCharacter(Terrorshark.HumanoidRootPart.Position) < 2000 then
				return Terrorshark
			end
		end

		if arg or v7.Ship then
			local v8 = next
			local children, v9 = game:GetService("Workspace").Enemies:GetChildren()

			for _, v10 in v8, children, v9 do
				if v10:FindFirstChild("Engine") and v10:FindFirstChild("Health") and v10.Health.Value > 0 and localPlayer:DistanceFromCharacter(v10.Engine.Position) < 2000 then
					if v7["Only Farm Ship Brigade"] then
						if table.find(tbl9, v10.Name) then
							return v10
						end
						continue
					end

					return v10
				end
			end
		end

		if arg or v7.Shark then
			local v8 = DetectMob(tbl10)
			if v8 and localPlayer:DistanceFromCharacter(v8.HumanoidRootPart.Position) < 2000 then
				return v8
			end
		end

		if arg or v7.Piranha then
			local Piranha = DetectMob("Piranha")
			if Piranha and localPlayer:DistanceFromCharacter(Piranha.HumanoidRootPart.Position) < 2000 then
				return Piranha
			end
		end

		return false
	end

	UseSkillGun = function()
		local Gun = NameWeapon("Gun", true) or false
		if Gun and not game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills:FindFirstChild(Gun.Name) then
			EquipTool(Gun.Name)
			return
		end
		local v7

		if Gun and CheckCDSkillTransformation(Gun, Settings["Select Skills " .. Gun.ToolTip]) then
			v7 = CheckCDSkillTransformation(Gun, Settings["Select Skills " .. Gun.ToolTip])
		else
			v7 = nil
		end

		local v8 = v7

		if v8 then
			local name_ = v8.Parent.Name
			EquipTool(name_)

			if localPlayer.Character:FindFirstChild(name_) then
				task.wait(0.2)

				pcall(function()
					game:GetService("VirtualInputManager"):SendKeyEvent(true, v8.Name, false, game)
				end)

				if Settings["Use skill fast dont hold"] then
					task.wait(0.05)
				else
					task.wait(GetHoldSkillDelay(v8.Name, name_))
				end

				pcall(function()
					game:GetService("VirtualInputManager"):SendKeyEvent(false, v8.Name, false, game)
				end)
			end
		end
	end

	AutoUseSkillSeabeast = function()
		local v7 = SafeMultiSelect("Select Weapons Use Skill")
		local Melee = v7.Melee and NameWeapon("Melee", true) or false
		local Sword = v7.Sword and NameWeapon("Sword", true) or false
		local bloxFruit = v7["Blox Fruit"] and NameWeapon("Blox Fruit", true) or false
		local Gun = v7.Gun and NameWeapon("Gun", true) or false
		local skills = game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills
		if Melee and not skills:FindFirstChild(Melee.Name) then
			EquipTool(Melee.Name)
			return
		end

		if Sword and not skills:FindFirstChild(Sword.Name) then
			EquipTool(Sword.Name)
			return
		end

		if bloxFruit and not skills:FindFirstChild(bloxFruit.Name) then
			EquipTool(bloxFruit.Name)
			return
		end

		if Gun and not skills:FindFirstChild(Gun.Name) then
			EquipTool(Gun.Name)
			return
		end
		local v8

		if Melee and CheckCDSkillTransformation(Melee, Settings["Select Skills " .. Melee.ToolTip]) then
			v8 = CheckCDSkillTransformation(Melee, Settings["Select Skills " .. Melee.ToolTip])
		elseif Sword and CheckCDSkillTransformation(Sword, Settings["Select Skills " .. Sword.ToolTip]) then
			v8 = CheckCDSkillTransformation(Sword, Settings["Select Skills " .. Sword.ToolTip])
		elseif Gun and CheckCDSkillTransformation(Gun, Settings["Select Skills " .. Gun.ToolTip]) then
			v8 = CheckCDSkillTransformation(Gun, Settings["Select Skills " .. Gun.ToolTip])
		elseif bloxFruit and CheckCDSkillTransformation(bloxFruit, Settings["Select Skills " .. bloxFruit.ToolTip]) then
			v8 = CheckCDSkillTransformation(bloxFruit, Settings["Select Skills " .. bloxFruit.ToolTip])
		else
			v8 = nil
		end

		local v9 = v8

		if v9 then
			local name_ = v9.Parent.Name
			EquipTool(name_)

			if localPlayer.Character:FindFirstChild(name_) then
				pcall(function()
					game:GetService("VirtualInputManager"):SendKeyEvent(true, v9.Name, false, game)
				end)

				if Settings["Use skill fast dont hold"] then
					task.wait(0.05)
				else
					task.wait(GetHoldSkillDelay(v9.Name, name_))
				end

				pcall(function()
					game:GetService("VirtualInputManager"):SendKeyEvent(false, v9.Name, false, game)
				end)
			end
		end
	end

	AutoSeabeast = function()
		if not StackFarmOther then
			return
		end
		local flag = false

		for k, v7 in next, SafeMultiSelect("Select Sea Events"), nil do
			v7 = v7 and k ~= "Only Farm Ship Brigade"
			if v7 then
				flag = true
				break
			end
		end

		if not flag then
			WarnOnce("NoSeaEvent", "Chua chon su kien nao o Sea Event > Select Sea Events.")
			return
		end
		local v7 = DetectSeaEvents()

		if not v7 then
			getgenv().PathSeaBeast = false
			getgenv().PathTerrorshark = false
			BuyBoatAndTeleBoat()
		else
			CancelBoatTween()

			if v7.Name == "Terrorshark" then
				getgenv().PathTerrorshark = v7
			end

			while true do
				task.wait()
				TeleportSeaEvents(v7)

				if v7:FindFirstChildWhichIsA("Humanoid") then
					if Settings["Use Dragonstorm For Sea Event"] then
						if Settings["Auto Change Dragonstorm With Skull Guitar"] then
							if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "LoadItem", "Dragonstorm" }))
							end
						end

						EquipTool(NameWeapon("Gun"))
						SpamGunDragonStorm(v7.HumanoidRootPart)

						if localPlayer:DistanceFromCharacter(v7.HumanoidRootPart.Position) < 400 then
							UseSkillGun()
						end
					elseif Settings["Use Click M1 Fruit For Sea Event"] then
						EquipTool(NameWeapon("Blox Fruit"))
						local v8 = NameWeapon("Blox Fruit")

						if localPlayer.Character:FindFirstChild(v8) and localPlayer.Character[v8]:FindFirstChild("LeftClickRemote") then
							getgenv().UseFruitM1(v7)
						end
					else
						UsedualFlock()
						ClickM1(v7, true)
					end
				else
					local humanoidRootPart = v7:FindFirstChild("HumanoidRootPart") or v7:FindFirstChild("Engine")

					if humanoidRootPart then
						if v7.Name == "SeaBeast1" then
							getgenv().PathSeaBeast = v7
							getgenv().AimPos = CFrame.new(humanoidRootPart.Position.X, 40, humanoidRootPart.Position.Z)
						else
							getgenv().AimPos = CFrame.new(localPlayer.Character.HumanoidRootPart.Position.X, -58, localPlayer.Character.HumanoidRootPart.Position.Z)
						end

						if Settings["Use Dragonstorm For Sea Event"] and v7.Name ~= "SeaBeast1" then
							if Settings["Auto Change Dragonstorm With Skull Guitar"] then
								if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "LoadItem", "Dragonstorm" }))
								end
							end

							EquipTool(NameWeapon("Gun"))
							SpamGunDragonStorm(humanoidRootPart)

							if localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
								UseSkillGun()
							end
						elseif Settings["Use Click M1 Skull Guitar For Sea Event"] then
							if Settings["Auto Change Dragonstorm With Skull Guitar"] then
								if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Skull Guitar" then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "LoadItem", "Skull Guitar" }))
								end
							end

							EquipTool(NameWeapon("Gun"))
							SpamGunSkullGuitar(humanoidRootPart)

							if localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
								UseSkillGun()
							end
						elseif Settings["Auto Change Dragonstorm When Kill Boat"] and v7:FindFirstChild("Health") and v7.Health.Value > 0 and v7:FindFirstChild("Engine") then
							if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "LoadItem", "Dragonstorm" }))
							end

							EquipTool(NameWeapon("Gun"))
							SpamGunDragonStorm(humanoidRootPart)

							if localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
								UseSkillGun()
							end
						elseif Settings["Use Click M1 Fruit For Sea Event"] then
							EquipTool(NameWeapon("Blox Fruit"))
							local v8 = NameWeapon("Blox Fruit")

							if localPlayer.Character:FindFirstChild(v8) and localPlayer.Character[v8]:FindFirstChild("LeftClickRemote") then
								if v7.Name == "SeaBeast1" then
									getgenv().UseFruitM1(v7)
								else
									local cFrame = humanoidRootPart.CFrame
									getgenv().UseFruitM1Boat(cFrame * CFrame.new(0, -35, 0))
								end
							end
						elseif localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
							AutoUseSkillSeabeast()
						end
					end
				end

				if not (not v7 or not v7.Parent or not Settings["Auto Sea Event"] or v7:FindFirstChild("Health") and v7.Health.Value == 0 or v7:FindFirstChildWhichIsA("Humanoid") and v7.Humanoid.Health == 0 or not StackFarmOther) then
					continue
				end
				break
			end
		end
	end

	FarmingSeaEventSection = SeaEventTab.CreateSection("Farming")

	local v7 = FarmingSeaEventSection.CreateDropdown({
		Title = "Select Friend",
		List = DetectNamePlayer(),
		Search = true,
		Selected = false,
		Default = Settings["Select Friend"] or nil,
	}, function(arg)
		SaveSettings("Select Friend", arg)
	end)

	FarmingSeaEventSection.CreateButton({ Title = "Refresh Player" }, function()
		v7:GetNewList(DetectNamePlayer())
	end)

	FarmingSeaEventSection.CreateToggle({
		Title = "Auto Sea Event With Friend",
		Desc = nil,
		Default = Settings["Auto Sea Event With Friend"] or false,
	}, function(arg)
		SaveSettings("Auto Sea Event With Friend", arg)
	end)

	do
		local n = 0
		local n3 = 0
		local flag = false

		spawn(function()
			while true do
				wait()
				if not (game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main"):FindFirstChild("DmgCounter")) then
					continue
				end
				break
			end

			game:GetService("Players").LocalPlayer.PlayerGui.Main.DmgCounter.Text:GetPropertyChangedSignal("Text"):Connect(function()
				if tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.DmgCounter.Text.Text) == 0 then
					n = 0
					n3 = 0
					flag = false
				else
					flag = true
					n = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.DmgCounter.Text.Text) - n3
				end
			end)
		end)

		FarmingSeaEventSection.CreateToggle({
			Title = "Auto Repair Ur Ship",
			Desc = nil,
			Default = Settings["Auto Repair Ur Ship"] or false,
		}, function(arg)
			SaveSettings("Auto Repair Ur Ship", arg)
		end)

		FarmingSeaEventSection.CreateToggle({ Title = "Auto Sea Event", Desc = nil, Default = Settings["Auto Sea Event"] or false }, function(arg)
			if arg then
				getgenv().StopBoatSeaEvent = true

				spawn(function()
					while Settings["Auto Sea Event"] and task.wait(0.1) do
						local ok, result = pcall(function()
							AutoSeabeast()
						end)

						if not ok and result then
							PrintOnce(result)
						end
					end
				end)
			elseif getgenv().StopBoatSeaEvent then
				CancelBoatTween()
				getgenv().StopBoatSeaEvent = false
			end

			SaveSettings("Auto Sea Event", arg)
		end)

		local DangerDistance = nil

		if Place_Id.sea3() then
			DangerDistance = require(game:GetService("ReplicatedStorage").DangerDistance)
		end

		DistanceFindLeviathan = function()
			local position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
			return (math.floor((GuideModule:GetDistance(GuideModule:GetNearestNPC(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, 2600)[1]) - position).magnitude / 10))
		end

		ToggleFindMirage = FarmingSeaEventSection.CreateToggle({ Title = "Auto Find Mirage", Desc = nil, Default = Settings["Auto Find Mirage"] or false }, function(arg)
			spawn(function()
				while Settings["Auto Find Mirage"] and wait(0.1) do
					pcall(function()
						if not game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
							getgenv().RespawnMirage = true
							local v8 = CheckBoat()

							if not v8 or v8 and localPlayer:DistanceFromCharacter(v8.VehicleSeat.Position) >= 4000 then
								local cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

								if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
									if localPlayer:DistanceFromCharacter(cframe.Position) > 1000 then
										if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki" then
											localPlayer.Character.Humanoid.Health = 0
											return
										end
									end

									ToTarget(cframe)
								else
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
									wait(3)
								end
							elseif localPlayer.Character.Humanoid.Sit then
								local n4 = CFrame.new(-118834.515625, 160, -78.950584411621094) * CFrame.new(0, 0, 99999999)
								local cframe = CFrame.new(-32975.9921875, 160, 25963.7109375)
								local flag2

								if Settings["Will Back When over 10km"] then
									if DistanceFindLeviathan() >= 12000 then
										flag2 = true
									elseif DistanceFindLeviathan() <= 4800 then
										flag2 = false
									else
										flag2 = false
									end
								else
									flag2 = false
								end

								while true do
									task.wait(0.5)
									NoclipBoat(v8)

									if Settings["Will Back When over 10km"] then
										if DistanceFindLeviathan() >= 10000 then
											flag2 = true
										elseif DistanceFindLeviathan() <= 4800 then
											flag2 = false
										end

										if flag2 then
											ManageTween(v8.VehicleSeat, cframe, 350, "TweenBoatBack")
										end
									end

									if not flag2 or not Settings["Will Back When over 10km"] then
										ManageTween(v8.VehicleSeat, n4, 350, "TweenBoat")
									end

									if not (not Settings["Auto Find Mirage"] or not localPlayer.Character.Humanoid.Sit or game:GetService("Workspace").Map:FindFirstChild("MysticIsland")) then
										continue
									end
									break
								end

								if getgenv().TweenBoat then
									getgenv().TweenBoat:Pause()
									getgenv().TweenBoat:Cancel()
								end

								if getgenv().TweenBoatBack then
									getgenv().TweenBoatBack:Pause()
									getgenv().TweenBoatBack:Cancel()
								end
							else
								if getgenv().TweenBoat then
									getgenv().TweenBoat:Pause()
									getgenv().TweenBoat:Cancel()
								end

								if getgenv().TweenBoatBack then
									getgenv().TweenBoatBack:Pause()
									getgenv().TweenBoatBack:Cancel()
								end

								ToTarget(v8.VehicleSeat.CFrame)
							end
						else
							if getgenv().RespawnMirage and Settings["Webhook Find Mirage"] then
								getgenv().RespawnMirage = false
								WebhookFindMirage()
							end

							if getgenv().TweenBoat then
								getgenv().TweenBoat:Pause()
								getgenv().TweenBoat:Cancel()
							end

							VxezeNotify("Mirage Island", "Mirage Island Spawned", "found")
							ToggleFindMirage:SetStage(false)
							wait(5)
						end
					end)
				end
			end)

			SaveSettings("Auto Find Mirage", arg)
		end)

		KitsuneEventSection = SeaEventTab.CreateSection("Kitsune Event")

		KitsuneEventSection.CreateToggle({
			Title = "Teleport To Kitsune Island",
			Desc = nil,
			Default = Settings["Teleport To Kitsune Island"] or false,
		}, function(arg)
			SaveSettings("Teleport To Kitsune Island", arg)
		end)

		KitsuneEventSection.CreateToggle({
			Title = "Hop Server [ Next Night or Near Full Moon > 2m ]",
			Desc = nil,
			Default = Settings["Hop Server Kitsune Island"] or false,
		}, function(arg)
			SaveSettings("Hop Server Kitsune Island", arg)
		end)

		KitsuneEventSection.CreateToggle({
			Title = "Auto Spawn Kitsune Island",
			Desc = nil,
			Default = Settings["Auto Spawn Kitsune Island"] or false,
		}, function(arg)
			if arg then
				VxezeNotify("Kitsune Island", "Turn this on after the Full Moon status shows up", "warning")
			end

			SaveSettings("Auto Spawn Kitsune Island", arg)
		end)

		KitsuneEventSection.CreateToggle({
			Title = "Auto Summon Soul Ember",
			Desc = nil,
			Default = Settings["Auto Summon Soul Ember"] or false,
		}, function(arg)
			SaveSettings("Auto Summon Soul Ember", arg)
		end)

		KitsuneEventSection.CreateToggle({
			Title = "Auto Collect Soul Ember",
			Desc = nil,
			Default = Settings["Auto Collect Soul Ember"] or false,
		}, function(arg)
			SaveSettings("Auto Collect Soul Ember", arg)
		end)

		KitsuneEventSection.CreateSlider({
			Title = "Values Azure Ember",
			Min = 0,
			Max = 25,
			Default = Settings["Values Azure Ember"] or 10,
			Precise = true,
		}, function(arg)
			SaveSettings("Values Azure Ember", arg)
		end)

		KitsuneEventSection.CreateToggle({
			Title = "Auto Trade Azure Ember",
			Desc = nil,
			Default = Settings["Auto Trade Azure Ember"] or false,
		}, function(arg)
			SaveSettings("Auto Trade Azure Ember", arg)
		end)

		DetectIslandKitsune = function()
			if game.workspace.Map:FindFirstChild("KitsuneIsland") and workspace.Map.KitsuneIsland.ShrineDialogPart.ProximityPrompt.Enabled then
				return true
			end
		end

		AutoSpawnKitsune = function()
			local clockTime = game.Lighting.ClockTime
			local v8 = CheckBoat()

			if Settings["Hop Server Kitsune Island"] then
				local v9 = CheckMoon()
				local flag2 = v9 == "Full Moon" and math.floor(18 - clockTime) <= 5 and math.floor(18 - clockTime) >= 0 or v9 == "Next Night"

				if not flag2 then
					flag2 = v9 == "Full Moon" and clockTime <= 5 and math.floor(5 - clockTime) >= 11
				end

				if not flag2 then
					HopServer()
					return
				end
			end

			if not v8 then
				local cframe = CFrame.new(-13.488054275512695, 10.311711311340332, 2927.692)

				if Place_Id.sea3() then
					cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
				end

				if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
					ToTarget(cframe)
				else
					local selectBoat = Settings["Select Boat"]
					if not selectBoat then
						WarnOnce("SelectBoat", "Chon thuyen o Sea Event > Select Boat truoc da.")
						return
					end
					local flag2 = selectBoat == "Brigade"
					local commF = game:GetService("ReplicatedStorage").Remotes.CommF_
					local invokeServer = commF.InvokeServer
					local str2

					if flag2 or selectBoat == "GrandBrigade" then
						str2 = "Pirate" .. selectBoat
					else
						str2 = selectBoat
					end

					invokeServer(commF, "BuyBoat", str2)
					task.wait(3)
				end

				return
			end

			NoclipBoat(v8)
			local n4 = CFrame.new(-32975.9921875, v8.WorldPivot.Y, 25963.7109375) * CFrame.new(0, 0, 1000)

			if CheckMoon() == "Full Moon" and math.floor(18 - clockTime) <= 0 then
				if (v8.VehicleSeat.Position - n4.Position).Magnitude > 200 then
					if not localPlayer.Character.Humanoid.Sit then
						ToTarget(v8.VehicleSeat.CFrame)
					else
						ManageTween(v8.VehicleSeat, n4, 350, "TweenBoat")
					end
				elseif not localPlayer.Character.Humanoid.Sit then
					ToTarget(v8.VehicleSeat.CFrame)
				end
			else
				if (v8.VehicleSeat.Position - n4.Position).Magnitude > 200 then
					ManageTween(v8.VehicleSeat, n4, 350, "TweenBoat")
				end

				ToTarget(n4 * CFrame.new(0, 2000, 0))
			end
		end

		DetectSoulEmber = function()
			local v8 = next
			local children, v9 = game.Workspace:GetChildren()

			for _, v10 in v8, children, v9 do
				if v10.Name == "EmberTemplate" and v10:FindFirstChild("Part") then
					return v10
				end
			end
		end

		CollectSoulEmber = function()
			local v8 = DetectSoulEmber()

			if v8 then
				if localPlayer:DistanceFromCharacter(v8.Part.Position) > 100 then
					ToTarget(v8.Part.CFrame)
				else
					localPlayer.Character.HumanoidRootPart.CFrame = v8.Part.CFrame
				end
			else
				ToTarget(game.workspace._WorldOrigin.Locations["Kitsune Island"].CFrame)
			end
		end

		AutoSummonAzureEmber = function()
			if not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and DetectIslandKitsune() then
				if localPlayer:DistanceFromCharacter(game.Workspace.Map.KitsuneIsland.ShrineInactive.WorldPivot.Position) >= 10 then
					ToTarget(game.Workspace.Map.KitsuneIsland.ShrineInactive.WorldPivot)
				else
					game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
					wait(5)
				end
			end
		end

		TradeAzureEmber = function()
			if CheckCountItem("Azure Ember", tonumber(Settings["Values Azure Ember"])) and game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
				wait(5)
			end
		end

		spawn(function()
			while true do
				wait(0.15)
				if not (Settings["Teleport To Kitsune Island"] or Settings["Auto Spawn Kitsune Island"] or Settings["Auto Collect Soul Ember"] or Settings["Auto Trade Azure Ember"]) then
					continue
				end
				break
			end

			while task.wait(0.1) do
				pcall(function()
					if Settings["Teleport To Kitsune Island"] then
						if game.workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
							ToTarget(game.workspace._WorldOrigin.Locations["Kitsune Island"].CFrame)
						end
					end

					if Settings["Auto Spawn Kitsune Island"] then
						pcall(function()
							if not DetectIslandKitsune() then
								AutoSpawnKitsune()
							end
						end)
					end

					if Settings["Auto Collect Soul Ember"] then
						if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
							CollectSoulEmber()
						end
					end

					if Settings["Auto Summon Soul Ember"] then
						AutoSummonAzureEmber()
					end

					if Settings["Auto Trade Azure Ember"] then
						TradeAzureEmber()
					end
				end)
			end
		end)

		LeviathanEventSection = SeaEventTab.CreateSection("Leviathan Event")

		LeviathanEventSection.CreateButton({ Title = "Buy Spy" }, function()
			local spy = require(game.ReplicatedStorage.DialoguesList).Spy
			require(game.ReplicatedStorage.DialogueController):Start(spy)
		end)

		LeviathanEventSection.CreateButton({ Title = "Teleport your boat to current Position" }, function()
			local v8 = CheckBoat()
			if not v8 then
				VxezeNotify("Boat", "You don't have a boat", "warning")
				return
			end
			v8.VehicleSeat.CFrame = localPlayer.Character.HumanoidRootPart.CFrame
		end)

		LeviathanEventSection.CreateToggle({ Title = "Auto Buy Spy", Desc = nil, Default = Settings["Auto Buy Spy"] or false }, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Buy Spy"] and task.wait(5) do
						pcall(function()
							if StatusCheckLeviathan() == "Buy Find leviathan" then
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer("InfoLeviathan", "1")
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
							end
						end)
					end
				end)
			end

			SaveSettings("Auto Buy Spy", arg)
		end)

		LeviathanEventSection.CreateToggle({
			Title = "Auto Buy Boat Beast Hunter",
			Desc = nil,
			Default = Settings["Auto Buy Boat Beast Hunter"] or false,
		}, function(arg)
			SaveSettings("Auto Buy Boat Beast Hunter", arg)
		end)

		CheckBoatFind = function()
			local v8 = next
			local children, v9 = game:GetService("Workspace").Boats:GetChildren()

			for _, v10 in v8, children, v9 do
				if v10:IsA("Model") then
					if v10:FindFirstChild("Owner") and localPlayer:DistanceFromCharacter(v10.VehicleSeat.Position) < 10 and localPlayer.Character.Humanoid.SeatPart and localPlayer.Character.Humanoid.SeatPart.Name == "VehicleSeat" and v10.Humanoid.Value > 0 then
						return v10
					end
				end
			end
		end

		local v8 = next
		local children, v9 = game:GetService("ReplicatedStorage").RockGenerator.Rocks:GetChildren()
		name = {}
		state = v8
		iterator = children
		callback4 = v9

		for _, v10 in state, iterator, callback4 do
			table.insert(name, v10.Name)
		end

		SubtractValues = function(arg, arg2)
			return arg2 - arg
		end

		DetectSeaEventDodge = function(arg)
			if arg then
				local v10 = next
				local children2, v11 = game:GetService("Workspace").SeaBeasts:GetChildren()

				for _, v12 in v10, children2, v11 do
					if v12.Name == "SeaBeast1" and v12:FindFirstChild("HumanoidRootPart") and v12:FindFirstChild("HealthBBG") then
						local text = v12.HealthBBG.Frame.TextLabel.Text
						local text2 = v12.HealthBBG.Frame.TextLabel.Text
						local v13 = tonumber
						local str2

						if string.find(text:gsub("/%d+,%d+", ""), ",") then
							str2 = text2:gsub("%d+,%d+/", "")
						else
							str2 = text2:gsub("%d+/", "")
						end

						local str3 = str2:gsub(",", "")
						if v13(str3) >= 90000 and localPlayer:DistanceFromCharacter(v12.HumanoidRootPart.Position) < 2000 then
							return v12
						end
					end
				end
			end

			if arg then
				local Terrorshark = CheckNameBoss("Terrorshark")
				if Terrorshark and localPlayer:DistanceFromCharacter(Terrorshark.HumanoidRootPart.Position) < 2000 then
					return Terrorshark
				end
			end

			if arg then
				local v10 = next
				local children2, v11 = game:GetService("Workspace").Enemies:GetChildren()

				for _, v12 in v10, children2, v11 do
					if v12:FindFirstChild("Engine") and v12:FindFirstChild("Health") and v12.Health.Value > 0 and localPlayer:DistanceFromCharacter(v12.Engine.Position) < 2000 then
						return v12
					end
				end
			end

			return false
		end

		AutoFindLeviathan = function()
			if Settings["Auto Destroy IDK"] and getgenv().DesIdk then
				getgenv().DesIdk2 = true
				return
			end

			if Settings["Auto Destroy IDK"] and getgenv().DesIdk2 then
				ToTarget(getgenv().OldBoat.VehicleSeat.CFrame)

				if localPlayer.Character.Humanoid.Sit then
					getgenv().DesIdk2 = false
				end

				return
			end

			local v10 = CheckBoatFind()

			if not game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				getgenv().RespawnLeviathan = true
				local v11 = CheckBoat()

				if not v11 and Settings["Auto Buy Boat Beast Hunter"] then
					local cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

					if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
						if localPlayer:DistanceFromCharacter(cframe.Position) > 1000 then
							if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki" then
								localPlayer.Character.Humanoid.Health = 0
								return
							end
						end

						ToTarget(cframe)
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "Beast Hunter")
						wait(3)
					end
				elseif v10 then
					getgenv().noclip = false
					local n4 = CFrame.new(-118834.515625, 160, -78.950584411621094) * CFrame.new(0, 0, 99999999)
					local cframe = CFrame.new(-32975.9921875, 160, 25963.7109375)
					local flag2

					if Settings["Will Back When over 10km"] then
						if DistanceFindLeviathan() >= 12000 then
							flag2 = true
						elseif DistanceFindLeviathan() <= 4800 then
							flag2 = false
						else
							flag2 = false
						end
					else
						flag2 = false
					end

					local y = v10.VehicleSeat.Position.Y
					local maxForce = v10.VehicleSeat.BodyVelocity.MaxForce
					wait(0.5)
					v10.VehicleSeat.BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					local v12 = SubtractValues(v10.VehicleSeat.Position.Y, 1000)
					local flag3

					if not localPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.Visible then
						wait(0.2)
						v10.VehicleSeat.CFrame = v10.VehicleSeat.CFrame * CFrame.new(0, v12, 0)
						wait(1)
						flag3 = true
					else
						wait(0.2)
						v10.VehicleSeat.CFrame = v10.VehicleSeat.CFrame * CFrame.new(0, SubtractValues(v10.VehicleSeat.Position.Y, 160), 0)
						wait(1)
						flag3 = false
					end

					local flag4 = false

					while true do
						task.wait(0.5)
						NoclipBoat(v10)

						if localPlayer.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character:FindFirstChild("Humanoid") then
							local v13 = next
							local descendants, v14 = localPlayer.Character:GetDescendants()

							for _, v15 in v13, descendants, v14 do
								if (v15:IsA("MeshPart") or v15:IsA("Part")) and v15.CanCollide then
									v15.CanCollide = false
								end
							end
						end

						if flag3 and (localPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.Visible and localPlayer.PlayerGui.Main.Compass.Frame.DangerText.Visible and tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.TextLabel.Text) >= 1 or DangerDistance(localPlayer.Character.HumanoidRootPart.CFrame) >= 4000) then
							getgenv().TweenBoat:Pause()
							getgenv().TweenBoat:Cancel()
							wait(0.5)
							v10.VehicleSeat.CFrame = v10.VehicleSeat.CFrame * CFrame.new(0, SubtractValues(v10.VehicleSeat.Position.Y, 160), 0)
							wait(0.5)
							flag3 = false
						end

						if not flag3 and v10.VehicleSeat.Position.Y < 150 then
							if getgenv().TweenBoat then
								getgenv().TweenBoat:Pause()
								getgenv().TweenBoat:Cancel()
							end

							if getgenv().TweenBoatBack then
								getgenv().TweenBoatBack:Pause()
								getgenv().TweenBoatBack:Cancel()
							end

							wait(0.5)
							v10.VehicleSeat.CFrame = v10.VehicleSeat.CFrame * CFrame.new(0, SubtractValues(v10.VehicleSeat.Position.Y, 160), 0)
						end

						if not flag4 and DetectSeaEventDodge(true) and v10.VehicleSeat.Position.Y < 500 then
							n4 = CFrame.new(-118834.515625, 500, -78.950584411621094) * CFrame.new(0, 0, 99999999)
							cframe = CFrame.new(-32975.9921875, 500, 25963.7109375)

							if getgenv().TweenBoat then
								getgenv().TweenBoat:Pause()
								getgenv().TweenBoat:Cancel()
							end

							if getgenv().TweenBoatBack then
								getgenv().TweenBoatBack:Pause()
								getgenv().TweenBoatBack:Cancel()
							end

							wait(0.5)
							v10.VehicleSeat.CFrame = v10.VehicleSeat.CFrame * CFrame.new(0, SubtractValues(v10.VehicleSeat.Position.Y, 500), 0)
							wait(0.5)
							flag4 = true
						elseif flag4 and not DetectSeaEventDodge(true) then
							n4 = CFrame.new(-118834.515625, 160, -78.950584411621094) * CFrame.new(0, 0, 99999999)
							cframe = CFrame.new(-32975.9921875, 160, 25963.7109375)

							if getgenv().TweenBoat then
								getgenv().TweenBoat:Pause()
								getgenv().TweenBoat:Cancel()
							end

							if getgenv().TweenBoatBack then
								getgenv().TweenBoatBack:Pause()
								getgenv().TweenBoatBack:Cancel()
							end

							wait(0.5)
							v10.VehicleSeat.CFrame = v10.VehicleSeat.CFrame * CFrame.new(0, SubtractValues(v10.VehicleSeat.Position.Y, 160), 0)
							wait(0.5)
							flag4 = false
						end

						local v13

						if Settings["Will Back When over 10km"] then
							if DistanceFindLeviathan() >= 10000 then
								flag2 = true
							elseif DistanceFindLeviathan() <= 4800 then
								flag2 = false
							end

							if flag2 then
								ManageTween(v10.VehicleSeat, cframe, 350, "TweenBoatBack")
								v13 = flag2
							else
								v13 = flag2
							end
						else
							v13 = flag2
						end

						if not v13 or not Settings["Will Back When over 10km"] then
							ManageTween(v10.VehicleSeat, n4, 350, "TweenBoat")
						end

						if not (not Settings["Auto Find Leviathan"] or not localPlayer.Character.Humanoid.Sit or game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") or Settings["Auto Destroy IDK"] and getgenv().DesIdk) then
							flag2 = v13
							continue
						end
						break
					end

					v10.VehicleSeat.BodyVelocity.MaxForce = maxForce
					getgenv().OldBoat = v10

					if getgenv().TweenBoat then
						getgenv().TweenBoat:Pause()
						getgenv().TweenBoat:Cancel()
					end

					if getgenv().TweenBoatBack then
						getgenv().TweenBoatBack:Pause()
						getgenv().TweenBoatBack:Cancel()
					end

					v10.VehicleSeat.CFrame = CFrame.new(v10.VehicleSeat.Position.X, y, v10.VehicleSeat.Position.Z)
				elseif v11 and Settings["Auto Buy Boat Beast Hunter"] then
					if not localPlayer.Character.Humanoid.Sit then
						ToTarget(v11.VehicleSeat.CFrame)
					end
				end
			else
				if getgenv().TweenBoat then
					getgenv().TweenBoat:Pause()
					getgenv().TweenBoat:Cancel()
				end

				if getgenv().TweenBoatBack then
					getgenv().TweenBoatBack:Pause()
					getgenv().TweenBoatBack:Cancel()
				end

				VxezeNotify("Frozen Dimension", "Frozen Dimension Spawned", "found")

				if getgenv().RespawnLeviathan and Settings["Webhook Find Leviathan"] then
					getgenv().RespawnLeviathan = false
					WebhookFindLeviathan()
				end

				wait(5)
			end
		end

		DestroyIDK = function()
			if StatusCheckLeviathan() == "I DONT KNOW" then
				getgenv().WebhookIDK = true
				local v10 = DetectSeaEvents(true)

				if not v10 then
					getgenv().PathSeaBeast = false
					getgenv().PathTerrorshark = false
				else
					getgenv().DesIdk = true

					if getgenv().TweenBoat then
						getgenv().TweenBoat:Pause()
						getgenv().TweenBoat:Cancel()
					end

					if v10.Name == "Terrorshark" then
						getgenv().PathTerrorshark = v10
					end

					while true do
						task.wait()

						spawn(function()
							TeleportSeaEvents(v10)
						end)

						if v10:FindFirstChildWhichIsA("Humanoid") then
							if Settings["Use Dragonstorm For Sea Event"] then
								if Settings["Auto Change Dragonstorm With Skull Guitar"] then
									if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "LoadItem", "Dragonstorm" }))
									end
								end

								EquipTool(NameWeapon("Gun"))
								SpamGunDragonStorm(v10.HumanoidRootPart)

								if localPlayer:DistanceFromCharacter(v10.HumanoidRootPart.Position) < 400 then
									UseSkillGun()
								end
							elseif Settings["Use Click M1 Fruit For Sea Event"] then
								EquipTool(NameWeapon("Blox Fruit"))
								local v11 = NameWeapon("Blox Fruit")

								if localPlayer.Character:FindFirstChild(v11) and localPlayer.Character[v11]:FindFirstChild("LeftClickRemote") then
									getgenv().UseFruitM1(v10)
								end
							else
								UsedualFlock()
								ClickM1(v10, true)
							end
						else
							local humanoidRootPart = v10:FindFirstChild("HumanoidRootPart") or v10:FindFirstChild("Engine")

							if v10.Name == "SeaBeast1" then
								getgenv().PathSeaBeast = v10
								getgenv().AimPos = CFrame.new(humanoidRootPart.Position.X, 40, humanoidRootPart.Position.Z)
							else
								getgenv().AimPos = CFrame.new(localPlayer.Character.HumanoidRootPart.Position.X, -58, localPlayer.Character.HumanoidRootPart.Position.Z)
							end

							if Settings["Use Dragonstorm For Sea Event"] and v10.Name ~= "SeaBeast1" then
								if Settings["Auto Change Dragonstorm With Skull Guitar"] then
									if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "LoadItem", "Dragonstorm" }))
									end
								end

								EquipTool(NameWeapon("Gun"))
								SpamGunDragonStorm(humanoidRootPart)

								if localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
									UseSkillGun()
								end
							elseif Settings["Use Click M1 Skull Guitar For Sea Event"] then
								if Settings["Auto Change Dragonstorm With Skull Guitar"] then
									if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Skull Guitar" then
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "LoadItem", "Skull Guitar" }))
									end
								end

								EquipTool(NameWeapon("Gun"))
								SpamGunSkullGuitar(humanoidRootPart)

								if localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
									UseSkillGun()
								end
							elseif Settings["Use Click M1 Fruit For Sea Event"] then
								EquipTool(NameWeapon("Blox Fruit"))
								local v11 = NameWeapon("Blox Fruit")

								if localPlayer.Character:FindFirstChild(v11) and localPlayer.Character[v11]:FindFirstChild("LeftClickRemote") then
									if v10.Name == "SeaBeast1" then
										getgenv().UseFruitM1(v10)
									else
										local cFrame = humanoidRootPart.CFrame
										getgenv().UseFruitM1Boat(cFrame * CFrame.new(0, -35, 0))
									end
								end
							elseif localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
								AutoUseSkillSeabeast()
							end
						end

						if not (not v10 or not v10.Parent or not Settings["Auto Destroy IDK"] or v10:FindFirstChild("Health") and v10.Health.Value == 0 or v10:FindFirstChildWhichIsA("Humanoid") and v10.Humanoid.Health == 0) then
							continue
						end
						break
					end

					getgenv().DesIdk = false
				end
			elseif getgenv().WebhookIDK and Settings["Webhook Destroy IDK"] then
				getgenv().WebhookDestroyIdk()
				getgenv().WebhookIDK = false
			end

			getgenv().DesIdk = false
		end

		getgenv().SpeedTeleportTiki = 70

		local v10 = LeviathanEventSection.CreateDropdown({
			Title = "Select Owner Boat Find Leviathan",
			List = DetectNamePlayer(),
			Search = true,
			Selected = false,
			Default = Settings["Select Owner Boat Find Leviathan"] or nil,
		}, function(arg)
			SaveSettings("Select Owner Boat Find Leviathan", arg)
		end)

		LeviathanEventSection.CreateButton({ Title = "Refresh Player" }, function()
			v10:GetNewList(DetectNamePlayer())
		end)

		CheckBoatMulti = function()
			local selectOwnerBoatFindLeviathan = Settings["Select Owner Boat Find Leviathan"]
			local v11 = next
			local children2, v12 = game:GetService("Workspace").Boats:GetChildren()
			local v13 = nil

			for _, v14 in v11, children2, v12 do
				if v14:IsA("Model") then
					if v14:FindFirstChild("Owner") and tostring(v14.Owner.Value) == selectOwnerBoatFindLeviathan and v14.Humanoid.Value > 0 then
						v13 = v14
					end
				end
			end

			if v13 then
				local v14 = next
				local children3, v15 = v13:GetChildren()

				for _, v16 in v14, children3, v15 do
					if v16.Name == "Cannon" and not v16.Seat:FindFirstChild("SeatWeld") then
						return v16
					end
				end
			end

			return false
		end

		LeviathanEventSection.CreateToggle({
			Title = "Multi Find Leviathan",
			Desc = nil,
			Default = Settings["Multi Find Leviathan"] or false,
		}, function(arg)
			if arg then
				spawn(function()
					while Settings["Multi Find Leviathan"] and task.wait(0.1) do
						pcall(function()
							if Settings["Auto Destroy IDK"] and getgenv().DesIdk then
								return
							end
							local v11 = CheckBoatMulti()

							if v11 and not localPlayer.Character.Humanoid.Sit then
								ToTarget(v11.Seat.CFrame)
							elseif localPlayer.Character.Humanoid.Sit and localPlayer.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("FloatForce") then
								TweenManager.CancelCurrent()
							end
						end)
					end
				end)
			end

			SaveSettings("Multi Find Leviathan", arg)
		end)

		LeviathanEventSection.CreateToggle({
			Title = "Auto Find Leviathan",
			Desc = nil,
			Default = Settings["Auto Find Leviathan"] or false,
		}, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Find Leviathan"] and task.wait(0.1) do
						local ok, result = pcall(function()
							AutoFindLeviathan()
						end)

						if result then
							PrintOnce(result)
						end
					end
				end)
			end

			SaveSettings("Auto Find Leviathan", arg)
		end)

		LeviathanEventSection.CreateToggle({
			Title = "Auto Start Leviathan",
			Desc = nil,
			Default = Settings["Auto Start Leviathan"] or false,
		}, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Start Leviathan"] and task.wait(2.5) do
						local ok, result = pcall(function()
							if game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
								local v11 = nil

								for _, child in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
									if child.Name == "Frozen Watcher" then
										v11 = child
									end
								end

								for _, child in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
									if child.Name == "Frozen Watcher" then
										v11 = child
									end
								end

								if v11 and localPlayer:DistanceFromCharacter(v11.HumanoidRootPart.Position) < 8 then
									game.ReplicatedStorage.Remotes.CommF_:InvokeServer("OpenLeviathanGate")
								else
									ToTarget(v11.HumanoidRootPart.CFrame)
								end
							end
						end)

						if result then
							PrintOnce(result)
						end
					end
				end)
			end

			SaveSettings("Auto Start Leviathan", arg)
		end)

		LeviathanEventSection.CreateToggle({ Title = "Auto Destroy IDK", Desc = nil, Default = Settings["Auto Destroy IDK"] or false }, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Destroy IDK"] and task.wait(0.1) do
						local ok, result = pcall(function()
							DestroyIDK()
						end)

						if result then
							PrintOnce(result)
						end
					end
				end)
			end

			SaveSettings("Auto Destroy IDK", arg)
		end)

		LeviathanEventSection.CreateToggle({
			Title = "Attack Multi Segments Leviathan",
			Desc = "Please enable the damage counter so I can calculate the damage dealt to that segment.\nplz Turn on multi Segments first.",
			Default = Settings["Attack Multi Segments Leviathan"] or false,
		}, function(arg)
			if arg and not Settings["Auto Attack Leviathan"] then
				VxezeNotify("Leviathan", "Turn On Auto Attack Leviathan, plz", "warning")
			end

			SaveSettings("Attack Multi Segments Leviathan", arg)
		end)

		LeviathanEventSection.CreateSlider({
			Title = "Value Damage Multi Segments",
			Min = 0,
			Max = 1000000,
			Default = Settings["Value Damage Multi Segments"] or 30000,
			Precise = true,
		}, function(arg)
			SaveSettings("Value Damage Multi Segments", arg)
		end)

		DetectLeviathan = function(arg, arg2)
			local v11 = next
			local children2, v12 = arg:GetChildren()

			for _, v13 in v11, children2, v12 do
				if v13.Name == "Leviathan Tail" and v13:GetAttribute("HealthEnabled") and v13.Health.Value > 0 then
					return v13
				end
			end

			local v13 = next
			local children3, v14 = arg:GetChildren()

			for _, v15 in v13, children3, v14 do
				if v15.Name == "Leviathan" and not v15:GetAttribute("Armored") and v15.Health.Value > 0 then
					return v15
				end
			end

			if arg2 then
				local v15 = next
				local children4, v16 = arg:GetChildren()

				for _, v17 in v15, children4, v16 do
					if v17.Name == "Leviathan Segment" and v17:GetAttribute("SegmentId") == arg2 and v17.Health.Value > 0 then
						return v17
					end
				end
			end
		end

		MultiSegmentLeviathan = function(arg, arg2)
			if arg2 then
				local valueDamageMultiSegments = Settings["Value Damage Multi Segments"] or 30000
				local v11 = next
				local children2, v12 = arg:GetChildren()

				for _, v13 in v11, children2, v12 do
					if v13.Name == "Leviathan Segment" and v13:GetAttribute("SegmentId") == arg2 and v13.Health.Value > 0 and (not v13:FindFirstChild("Tinhdamage") or v13:FindFirstChild("Tinhdamage") and v13.Tinhdamage.Value < valueDamageMultiSegments) then
						return v13
					end
				end
			end
		end

		getgenv().CFrameLeviathan = CFrame.new(0, 142, 0)

		AutoAttackLeviathan = function()
			local v11 = MultiSegmentLeviathan(game.workspace.SeaBeasts, 2) or MultiSegmentLeviathan(game.workspace.SeaBeasts, 3) or MultiSegmentLeviathan(game.workspace.SeaBeasts, 4)

			if Settings["Attack Multi Segments Leviathan"] then
				local valueDamageMultiSegments = Settings["Value Damage Multi Segments"] or 30000

				if v11 then
					while true do
						task.wait()

						if not v11:FindFirstChild("Tinhdamage") then
							Instance.new("IntValue", v11).Name = "Tinhdamage"
						end

						if v11:FindFirstChild("Tinhdamage") and v11.Tinhdamage.Value < valueDamageMultiSegments then
							if game:GetService("Players").LocalPlayer.PlayerGui.Main.DmgCounter.Visible and flag then
								v11.Tinhdamage.Value = v11.Tinhdamage.Value + n
								n3 = n
								flag = false
								task.wait(0.1)
							end
						end

						if v11.Name == "Leviathan" then
							local cFrame = v11.Hitbox11.CFrame
							getgenv().AimPos = cFrame

							spawn(function()
								local v12 = ToTarget
								local cframe = CFrame.new(v11.HumanoidRootPart.Position.X, 140, v11.HumanoidRootPart.Position.Z)
								v12(cframe)
							end)
						else
							local cFrame = v11.Hitbox11.CFrame
							getgenv().AimPos = cFrame

							spawn(function()
								local v12 = ToTarget
								local cframe = CFrame.new(v11.HumanoidRootPart.Position.X, 142, v11.HumanoidRootPart.Position.Z)
								v12(cframe)
							end)
						end

						if Settings["Use Click M1 Fruit Leviathan"] then
							EquipTool(NameWeapon("Blox Fruit"))
							local v12 = NameWeapon("Blox Fruit")

							if localPlayer.Character:FindFirstChild(v12) and localPlayer.Character[v12]:FindFirstChild("LeftClickRemote") then
								getgenv().UseFruitM1(v11, true)
							end
						elseif Settings["Auto Change Dragonstorm With Kill Leviathan"] then
							if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "LoadItem", "Dragonstorm" }))
							end

							EquipTool(NameWeapon("Gun"))
							SpamGunDragonStorm(v11.Hitbox11)

							if localPlayer:DistanceFromCharacter(v11.Hitbox11.Position) < 400 then
								UseSkillGun()
							end
						elseif Settings["Use Click M1 Skull Guitar Leviathan"] then
							EquipTool(NameWeapon("Gun"))
							SpamGunSkullGuitar(v11.Hitbox11)

							if localPlayer:DistanceFromCharacter(v11.Hitbox11.Position) < 400 then
								UseSkillGun()
							end
						elseif localPlayer:DistanceFromCharacter(v11.RootPart.Position) < 400 then
							AutoUseSkillSeabeast()
						end

						if not (not v11 or not v11.Parent or v11.Health.Value == 0 or not Settings["Auto Attack Leviathan"] or v11:FindFirstChild("Tinhdamage") and v11.Tinhdamage.Value >= valueDamageMultiSegments) then
							continue
						end
						break
					end

					return
				end
			end

			local v12 = DetectLeviathan(game.workspace.SeaBeasts, 2) or DetectLeviathan(game.workspace.SeaBeasts, 3) or DetectLeviathan(game.workspace.SeaBeasts, 4) or DetectLeviathan(game.workspace.SeaBeasts)

			if v12 then
				while true do
					task.wait()

					if v12.Name == "Leviathan" then
						local cFrame = v12.Hitbox11.CFrame
						getgenv().AimPos = cFrame

						spawn(function()
							local v13 = ToTarget
							local cframe = CFrame.new(v12.HumanoidRootPart.Position.X, 140, v12.HumanoidRootPart.Position.Z)
							v13(cframe)
						end)
					else
						local cFrame = v12.Hitbox11.CFrame
						getgenv().AimPos = cFrame

						spawn(function()
							local v13 = ToTarget
							local cframe = CFrame.new(v12.HumanoidRootPart.Position.X, 142, v12.HumanoidRootPart.Position.Z)
							v13(cframe)
						end)
					end

					if Settings["Use Click M1 Fruit Leviathan"] then
						EquipTool(NameWeapon("Blox Fruit"))
						local v13 = NameWeapon("Blox Fruit")

						if localPlayer.Character:FindFirstChild(v13) and localPlayer.Character[v13]:FindFirstChild("LeftClickRemote") then
							getgenv().UseFruitM1(v12, true)
						end
					elseif Settings["Auto Change Dragonstorm With Kill Leviathan"] then
						if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "LoadItem", "Dragonstorm" }))
						end

						EquipTool(NameWeapon("Gun"))
						SpamGunDragonStorm(v12.Hitbox11)

						if localPlayer:DistanceFromCharacter(v12.Hitbox11.Position) < 400 then
							UseSkillGun()
						end
					elseif Settings["Use Click M1 Skull Guitar Leviathan"] then
						EquipTool(NameWeapon("Gun"))
						SpamGunSkullGuitar(v12.Hitbox11)

						if localPlayer:DistanceFromCharacter(v12.Hitbox11.Position) < 400 then
							UseSkillGun()
						end
					elseif localPlayer:DistanceFromCharacter(v12.Hitbox11.Position) < 400 then
						AutoUseSkillSeabeast()
					end

					if not (not v12 or not v12.Parent or v12.Health.Value == 0 or not Settings["Auto Attack Leviathan"] or Settings["Attack Multi Segments Leviathan"] and v11) then
						continue
					end
					break
				end
			end
		end
	end

	GetSteeringAngleTo = function(arg, arg2)
		local cFrame = arg.PrimaryPart.CFrame
		local unit = (cFrame.LookVector * Vector3.new(1, 0, 1)).Unit
		local unit2 = ((arg2 - cFrame.Position) * Vector3.new(1, 0, 1)).Unit
		local v8 = math.acos(math.clamp(unit:Dot(unit2), -1, 1))
		local v9 = unit:Cross(unit2)
		local v10 = math.deg(v8)
		local n

		if v9.Y < 0 then
			n = -v10
		else
			n = v10
		end

		return n
	end

	FaceModelTowards = function(arg, arg2)
		local position = arg.PrimaryPart.Position
		local vector = Vector3.new(arg2.X, position.Y, arg2.Z)
		local setPrimaryPartCFrame = arg.SetPrimaryPartCFrame
		local v8 = arg
		local cframe = CFrame.lookAt(position, vector)
		setPrimaryPartCFrame(v8, cframe)
	end

	game:GetService("VirtualInputManager")

	do
		local tbl13 = {
			Vector3.new(7415.8325, 24.000849, -6664.6826),
			Vector3.new(-4703.16, 24.00002, -7.8222027),
			Vector3.new(-8762.331, 23.999748, -452.25867),
			Vector3.new(-15018.063, 23.999054, 199.03154),
			Vector3.new(-16065.729, 23.999151, 421.89822),
		}

		local tbl14 = {
			Vector3.new(7415.8325, 24.000849, -6664.6826),
			Vector3.new(1162.8353, 24.000189, -1825.8121),
			Vector3.new(2517.8875, 24.000118, 5109.431),
			Vector3.new(5172.726, 23.999813, 3893.6245),
			Vector3.new(5203.809, 24.00104, 2013.0905),
		}

		playerModule = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))

		DriveBoatToTiki = function()
			for _, v8 in ipairs(tbl13) do
				while _G.autoDrive and task.wait() do
					local v9 = CheckBoatFind()
					if not v9 then
						return
					end
					local v10 = GetSteeringAngleTo(v9, v8)

					if (v9.PrimaryPart.Position - v8).Magnitude < 10 then
						v9.PrimaryPart.ThrottleFloat = 0
						v9.PrimaryPart.Throttle = 0
						break
					end

					spawn(function()
						v9.VehicleSeat.MaxSpeed = Settings["Speed Boat Auto Drive"] or 300
						NoclipBoat(v9)
					end)

					if math.abs(v10) > 5 then
						FaceModelTowards(v9, v8)
						v9.PrimaryPart.ThrottleFloat = 0
						v9.PrimaryPart.Throttle = 0
					else
						v9.PrimaryPart.ThrottleFloat = 1
						v9.PrimaryPart.Throttle = 1
					end
				end
			end
		end

		DriveBoatToHydra = function()
			for _, v8 in ipairs(tbl14) do
				while _G.autoDrive and task.wait(0.1) do
					local v9 = CheckBoatFind()
					if not v9 then
						return
					end
					local v10 = GetSteeringAngleTo(v9, v8)

					if (v9.PrimaryPart.Position - v8).Magnitude < 10 then
						v9.PrimaryPart.ThrottleFloat = 0
						v9.PrimaryPart.Throttle = 0
						break
					end

					spawn(function()
						v9.VehicleSeat.MaxSpeed = Settings["Speed Boat Auto Drive"] or 300
						NoclipBoat(v9)
					end)

					if math.abs(v10) > 5 then
						FaceModelTowards(v9, v8)
						v9.PrimaryPart.ThrottleFloat = 0
						v9.PrimaryPart.Throttle = 0
					else
						v9.PrimaryPart.ThrottleFloat = 1
						v9.PrimaryPart.Throttle = 1
					end
				end
			end
		end
	end

	LeviathanEventSection.CreateToggle({
		Title = "Auto Attack Leviathan",
		Desc = nil,
		Default = Settings["Auto Attack Leviathan"] or false,
	}, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Attack Leviathan"] and wait(0.1) do
					local ok, result = pcall(function()
						AutoAttackLeviathan()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Attack Leviathan", arg)
	end)

	LeviathanEventSection.CreateToggle({
		Title = "Use Click M1 Fruit Leviathan",
		Desc = nil,
		Default = Settings["Use Click M1 Fruit Leviathan"] or false,
	}, function(arg)
		SaveSettings("Use Click M1 Fruit Leviathan", arg)
	end)

	LeviathanEventSection.CreateToggle({
		Title = "Use Click M1 Skull Guitar Leviathan",
		Desc = nil,
		Default = Settings["Use Click M1 Skull Guitar Leviathan"] or false,
	}, function(arg)
		SaveSettings("Use Click M1 Skull Guitar Leviathan", arg)
	end)

	LeviathanEventSection.CreateToggle({
		Title = "Auto Change Dragonstorm With Kill Leviathan",
		Desc = nil,
		Default = Settings["Auto Change Dragonstorm With Kill Leviathan"] or false,
	}, function(arg)
		SaveSettings("Auto Change Dragonstorm With Kill Leviathan", arg)
	end)

	local v8 = LeviathanEventSection.CreateDropdown({
		Title = "Select Owner Boat Beast Hunter Shoot Heart",
		List = DetectNamePlayer(),
		Search = true,
		Selected = false,
		Default = Settings["Select Owner Boat Beast Hunter"] or nil,
	}, function(arg)
		SaveSettings("Select Owner Boat Beast Hunter", arg)
	end)

	LeviathanEventSection.CreateButton({ Title = "Refresh Player" }, function()
		v8:GetNewList(DetectNamePlayer())
	end)

	LeviathanEventSection.CreateToggle({
		Title = "Use Your Boat Beast Hunter",
		Desc = nil,
		Default = Settings["Use Your Boat Beast Hunter"] or false,
	}, function(arg)
		SaveSettings("Use Your Boat Beast Hunter", arg)
	end)

	CheckBoatBeastHunter = function()
		local selectOwnerBoatBeastHunter = Settings["Select Owner Boat Beast Hunter"]

		if Settings["Use Your Boat Beast Hunter"] then
			selectOwnerBoatBeastHunter = localPlayer.Name
		end

		local v9 = next
		local children, v10 = game:GetService("Workspace").Boats:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11:IsA("Model") then
				if v11:FindFirstChild("Owner") and tostring(v11.Owner.Value) == selectOwnerBoatBeastHunter and v11.Humanoid.Value > 0 then
					return v11
				end
			end
		end

		return false
	end

	ShootHeartLeviathan = function()
		if workspace.Map:FindFirstChild("FrozenHeart") then
			if not workspace.Map.FrozenHeart.Inside:GetAttribute("Harpooned") then
				local v9 = CheckBoatBeastHunter()
				NoclipBoat(v9)
				local TweenService2 = game:service("TweenService")
				local y = v9.WorldPivot.Y
				local map = workspace.Map
				local n = CFrame.new(workspace.Map:FindFirstChild("FrozenHeart").Cube.Position.X, y, map:FindFirstChild("FrozenHeart").Cube.Position.Z) * CFrame.new(0, 0, 300) * CFrame.Angles(0, 6.2831853071795862, 0)

				if (n.Position - v9.VehicleSeat.Position).Magnitude > 5 then
					if localPlayer.Character.Humanoid.SeatPart and localPlayer.Character.Humanoid.SeatPart.Name == "VehicleSeat" then
						local tween = TweenService2:Create(v9.VehicleSeat, TweenInfo.new((n.Position - v9.VehicleSeat.Position).Magnitude / 150, Enum.EasingStyle.Quad), { CFrame = n })
						tween:Play()
						tween.Completed:wait()
						wait(1)
						FaceModelTowards(v9, workspace.Map:FindFirstChild("FrozenHeart").Inside.Position)
					else
						ToTarget(v9.VehicleSeat.CFrame)
					end
				elseif localPlayer.Character.Humanoid.SeatPart and localPlayer.Character.Humanoid.SeatPart.Parent.Name == "Harpoon" then
					local tbl13 = {
						"FireHarpoon",
						0.78539816339744828,
						0.00044342573293783646,
						v9.Harpoon,
						(workspace:GetServerTimeNow()),
					}

					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(tbl13))
				else
					ToTarget(v9.Harpoon.Seat.CFrame)
				end
			else
				VxezeNotify("Leviathan", "Fired at the Leviathan heart", "success")
				wait(5)
			end
		end
	end

	LeviathanEventSection.CreateToggle({
		Title = "Auto Fire Shoot Heart Leviathan",
		Desc = nil,
		Default = Settings["Auto Fire Shoot Heart Leviathan"] or false,
	}, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Fire Shoot Heart Leviathan"] and task.wait(0.1) do
					local ok, result = pcall(function()
						ShootHeartLeviathan()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Fire Shoot Heart Leviathan", arg)
	end)

	LeviathanEventSection.CreateToggle({
		Title = "Teleport Frozen Dimension",
		Desc = nil,
		Default = Settings["Teleport Frozen Dimension"] or false,
	}, function(arg)
		if arg then
			spawn(function()
				while Settings["Teleport Frozen Dimension"] and wait(0.1) do
					pcall(function()
						if game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
							local v9 = DetectNpc("Frozen Watcher")
							if v9 then
								ToTarget(v9.HumanoidRootPart.CFrame)
								return
							end
						end
					end)
				end
			end)
		end

		SaveSettings("Teleport Frozen Dimension", arg)
	end)

	LeviathanEventSection.CreateToggle({
		Title = "Tween Boat To Frozen Dimension",
		Desc = nil,
		Default = Settings["Tween Boat To Frozen Dimension"] or false,
	}, function(arg)
		if arg then
			spawn(function()
				while Settings["Tween Boat To Frozen Dimension"] and wait(0.1) do
					pcall(function()
						if game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
							AllNPCS = {}

							for _, child in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
								table.insert(AllNPCS, child)
							end

							for _, child in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
								table.insert(AllNPCS, child)
							end

							for _, v9 in pairs(AllNPCS) do
								if v9.Name == "Frozen Watcher" then
									local v10 = CheckBoatFind()

									while true do
										task.wait()
										ManageTween(v10.VehicleSeat, CFrame.new(v9.HumanoidRootPart.Position.X, v10.VehicleSeat.Position.Y, v9.HumanoidRootPart.Position.Z), 350, "TweenBoatToFrozen")
										NoclipBoat(v10)
										if not (game:GetService("Workspace").NPCs:FindFirstChild("Frozen Watcher") or not Settings["Tween Boat To Frozen Dimension"]) then
											continue
										end
										break
									end

									if getgenv().TweenBoatToFrozen then
										getgenv().TweenBoatToFrozen:Pause()
										getgenv().TweenBoatToFrozen:Cancel()
									end
								end
							end
						end
					end)
				end
			end)
		end

		SaveSettings("Tween Boat To Frozen Dimension", arg)
	end)

	LeviathanEventSection.CreateSlider({
		Title = "Speed Boat Auto Drive",
		Min = 0,
		Max = 500,
		Default = Settings["Speed Boat Auto Drive"] or 300,
		Precise = true,
	}, function(arg)
		SaveSettings("Speed Boat Auto Drive", arg)
	end)

	LeviathanEventSection.CreateToggle({ Title = "Drive Boat To Tiki", Desc = nil, Default = Settings["Drive Boat To Tiki"] or false }, function(autoDrive)
		_G.autoDrive = autoDrive

		if autoDrive then
			spawn(function()
				local ok, result = pcall(DriveBoatToTiki)

				if not ok then
					warn("Lỗi khi chạy DriveBoatToTiki:", result)
				end
			end)
		end

		SaveSettings("Drive Boat To Tiki", autoDrive)
	end)

	LeviathanEventSection.CreateToggle({ Title = "Drive Boat To Hydra", Desc = nil, Default = Settings["Drive Boat To Hydra"] or false }, function(autoDrive)
		_G.autoDrive = autoDrive

		if autoDrive then
			spawn(function()
				local ok, result = pcall(DriveBoatToHydra)

				if not ok then
					warn("Lỗi khi chạy DriveBoatToHydra:", result)
				end
			end)
		end

		SaveSettings("Drive Boat To Hydra", autoDrive)
	end)

	BoatSettingSection = SeaEventTab.CreateSection("Boat Setting")

	do
		local v9 = table.find({ Enum.Platform.IOS, Enum.Platform.Android }, game:GetService("UserInputService"):GetPlatform())
		FLYING = false
		QEfly = true
		iyflyspeed = 1
		vehicleflyspeed = 1
		IYMouse = localPlayer:GetMouse()

		GetRoot = function(arg)
			return arg:FindFirstChild("HumanoidRootPart") or arg:FindFirstChild("Torso") or arg:FindFirstChild("UpperTorso")
		end

		EnableFly = function(arg)
			while true do
				wait()
				if not (localPlayer and localPlayer.Character and GetRoot(localPlayer.Character) and localPlayer.Character:FindFirstChildOfClass("Humanoid")) then
					continue
				end
				break
			end

			repeat
				wait()
			until IYMouse

			if flyKeyDown or flyKeyUp then
				flyKeyDown:Disconnect()
				flyKeyUp:Disconnect()
			end

			local v10 = GetRoot(localPlayer.Character)
			local tbl13 = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
			local tbl14 = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
			local n = 0

			local function fn()
				FLYING = true
				local bodyVelocity = Instance.new("BodyVelocity")
				bodyVelocity.Parent = v10
				bodyVelocity.velocity = Vector3.zero
				bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

				task.spawn(function()
					while true do
						wait()

						if not arg and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
							Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
						end

						if tbl13.L + tbl13.R ~= 0 or tbl13.F + tbl13.B ~= 0 or tbl13.Q + tbl13.E ~= 0 then
							n = 50
						elseif not (tbl13.L + tbl13.R ~= 0 or tbl13.F + tbl13.B ~= 0 or tbl13.Q + tbl13.E ~= 0) and n ~= 0 then
							n = 0
						end

						if tbl13.L + tbl13.R ~= 0 or tbl13.F + tbl13.B ~= 0 or tbl13.Q + tbl13.E ~= 0 then
							local p = workspace.CurrentCamera.CoordinateFrame.p
							bodyVelocity.velocity = (workspace.CurrentCamera.CoordinateFrame.lookVector * (tbl13.F + tbl13.B) + workspace.CurrentCamera.CoordinateFrame * CFrame.new(tbl13.L + tbl13.R, (tbl13.F + tbl13.B + tbl13.Q + tbl13.E) * 0.2, 0).p - p) * n
							tbl14 = { F = tbl13.F, B = tbl13.B, L = tbl13.L, R = tbl13.R }
						elseif tbl13.L + tbl13.R == 0 and tbl13.F + tbl13.B == 0 and tbl13.Q + tbl13.E == 0 and n ~= 0 then
							local p = workspace.CurrentCamera.CoordinateFrame.p
							bodyVelocity.velocity = (workspace.CurrentCamera.CoordinateFrame.lookVector * (tbl14.F + tbl14.B) + workspace.CurrentCamera.CoordinateFrame * CFrame.new(tbl14.L + tbl14.R, (tbl14.F + tbl14.B + tbl13.Q + tbl13.E) * 0.2, 0).p - p) * n
						else
							bodyVelocity.velocity = Vector3.zero
						end

						if FLYING then
							continue
						end
						break
					end

					tbl13 = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
					tbl14 = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
					n = 0
					bodyVelocity:Destroy()

					if Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
						Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
					end
				end)
			end

			flyKeyDown = IYMouse.KeyDown:Connect(function(arg2)
				if arg2:lower() == "w" then
					tbl13.F = arg and vehicleflyspeed or iyflyspeed
				elseif arg2:lower() == "s" then
					tbl13.B = -(arg and vehicleflyspeed or iyflyspeed)
				elseif arg2:lower() == "a" then
					tbl13.L = -(arg and vehicleflyspeed or iyflyspeed)
				elseif arg2:lower() == "d" then
					tbl13.R = arg and vehicleflyspeed or iyflyspeed
				elseif QEfly and arg2:lower() == "e" then
					tbl13.Q = (arg and vehicleflyspeed or iyflyspeed) * 2
				elseif QEfly and arg2:lower() == "q" then
					tbl13.E = -(arg and vehicleflyspeed or iyflyspeed) * 2
				end

				pcall(function()
					workspace.CurrentCamera.CameraType = Enum.CameraType.Track
				end)
			end)

			flyKeyUp = IYMouse.KeyUp:Connect(function(arg2)
				if arg2:lower() == "w" then
					tbl13.F = 0
				elseif arg2:lower() == "s" then
					tbl13.B = 0
				elseif arg2:lower() == "a" then
					tbl13.L = 0
				elseif arg2:lower() == "d" then
					tbl13.R = 0
				elseif arg2:lower() == "e" then
					tbl13.Q = 0
				elseif arg2:lower() == "q" then
					tbl13.E = 0
				end
			end)

			fn()
		end

		RandomFlyName = function()
			local tbl13 = {}

			for i_ = 1, math.random(10, 20) do
				tbl13[i_] = string.char(math.random(32, 126))
			end

			return table.concat(tbl13)
		end

		DisableFly = function()
			FLYING = false

			if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGuiFly") then
				game.Players.LocalPlayer.PlayerGui.ScreenGuiFly:Destroy()
			end

			if flyKeyDown or flyKeyUp then
				flyKeyDown:Disconnect()
				flyKeyUp:Disconnect()
			end

			if Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
			end

			pcall(function()
				workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			end)
		end

		local v10 = RandomFlyName()
		local v11 = RandomFlyName()
		local connection = nil
		local connection2 = nil

		StopFlying = function(arg)
			pcall(function()
				FLYING = false
				game.Players.LocalPlayer.PlayerGui.ScreenGuiFly:Destroy()
				GetRoot(arg.Character):FindFirstChild(v10):Destroy()
				local v12
				v12:FindFirstChild(v11):Destroy()
				arg.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
				connection:Disconnect()
				connection2:Disconnect()
			end)
		end

		StartFlying = function(arg)
			StopFlying(arg)
			FLYING = true
			local v12 = nil
			local v13 = GetRoot(arg.Character)
			Vector3.new()
			local vector = Vector3.zero
			require(arg.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
			local bodyVelocity = Instance.new("BodyVelocity")
			bodyVelocity.Name = v10
			bodyVelocity.Parent = v13
			bodyVelocity.MaxForce = vector
			bodyVelocity.Velocity = vector

			connection = arg.CharacterAdded:Connect(function()
				local bodyVelocity2 = Instance.new("BodyVelocity")
				bodyVelocity2.Name = v10
				bodyVelocity2.Parent = v13
				bodyVelocity2.MaxForce = vector
				bodyVelocity2.Velocity = vector
			end)

			local screenGui = Instance.new("ScreenGui")
			local textButton = Instance.new("TextButton")
			local textButton2 = Instance.new("TextButton")
			screenGui.Name = "ScreenGuiFly"
			screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
			screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			screenGui.ResetOnSpawn = false
			textButton.Name = "FlyUp"
			textButton.Parent = screenGui
			textButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			textButton.BackgroundTransparency = 1
			textButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			textButton.BorderSizePixel = 0
			textButton.Position = UDim2.new(0.158661261, 0, 0.82663101, 0)
			textButton.Size = UDim2.new(0.0538219661, 0, 0.0765434727, 0)
			textButton.Font = Enum.Font.SourceSans
			textButton.Text = "↑"
			textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			textButton.TextScaled = true
			textButton.TextSize = 14
			textButton.TextWrapped = true
			textButton2.Name = "FlyDown"
			textButton2.Parent = screenGui
			textButton2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			textButton2.BackgroundTransparency = 1
			textButton2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			textButton2.BorderSizePixel = 0
			textButton2.Position = UDim2.new(0.158661261, 0, 0.922887683, 0)
			textButton2.Size = UDim2.new(0.0538219661, 0, 0.0765434727, 0)
			textButton2.Font = Enum.Font.SourceSans
			textButton2.Text = "↓"
			textButton2.TextColor3 = Color3.fromRGB(0, 0, 0)
			textButton2.TextScaled = true
			textButton2.TextSize = 14
			textButton2.TextWrapped = true
			connection2 = game:GetService("RunService").RenderStepped:Connect(function(...) end)

			textButton2.MouseButton1Click:Connect(function()
				if v12 then
					v12.Velocity = Vector3.new(0, -20, 0)
				end
			end)

			textButton.MouseButton1Click:Connect(function()
				if v12 then
					v12.Velocity = Vector3.new(0, 20, 0)
				end
			end)
		end

		BoatSettingSection.CreateToggle({ Title = "Fly Boat", Desc = nil, Default = Settings["Fly Boat"] or false }, function(arg)
			if arg then
				spawn(function()
					while Settings["Fly Boat"] and wait(0.1) do
						pcall(function()
							if localPlayer.Character.Humanoid.Sit then
								if not v9 then
									DisableFly()
									wait()
									EnableFly(true)
								else
									StartFlying(localPlayer, true)
								end

								while true do
									wait()
									if not (not Settings["Fly Boat"] or not localPlayer.Character.Humanoid.Sit) then
										continue
									end
									break
								end

								if not v9 then
									DisableFly()
								else
									StopFlying(localPlayer)
								end
							end
						end)
					end
				end)
			end

			SaveSettings("Fly Boat", arg)
		end)
	end

	vehicleflyspeed = tonumber(Settings["Value Speed Fly Boat"]) or 3

	BoatSettingSection.CreateSlider({
		Title = "Value Speed Boat",
		Min = 0,
		Max = 500,
		Default = Settings["Value Speed Boat"] or 200,
		Precise = true,
	}, function(arg)
		SaveSettings("Value Speed Boat", arg)
	end)

	BoatSettingSection.CreateSlider({
		Title = "Value Speed Tween Boat",
		Min = 50,
		Max = 2000,
		Default = tonumber(Settings["Value Speed Tween Boat"]) or 350,
		Precise = true,
	}, function(arg)
		SaveSettings("Value Speed Tween Boat", arg)
		local tweenBoat = getgenv().TweenBoat

		if tweenBoat and tweenBoat.Speed then
			tweenBoat.Speed = math.max(tonumber(arg) or 350, 1)
		end
	end)

	BoatSettingSection.CreateSlider({
		Title = "Value Speed Fly Boat",
		Min = 0,
		Max = 10,
		Default = Settings["Value Speed Fly Boat"] or 3,
		Precise = true,
	}, function(arg)
		vehicleflyspeed = tonumber(arg) or 3
		SaveSettings("Value Speed Fly Boat", arg)
	end)

	CheckSpeedBoat = function()
		local n = tonumber(Settings["Value Speed Boat"]) or 200
		local v9 = CheckBoat()

		if v9 then
			local vehicleSeat = v9:FindFirstChild("VehicleSeat")
			if vehicleSeat and vehicleSeat.MaxSpeed + 1 < n then
				return v9
			end
		end

		return false
	end

	ChangeSpeedBoat = function()
		local maxSpeed = tonumber(Settings["Value Speed Boat"]) or 200
		local v9 = CheckSpeedBoat()

		if v9 then
			v9.VehicleSeat.MaxSpeed = maxSpeed
		end
	end

	BoatSettingSection.CreateToggle({ Title = "Change Speed Boat", Desc = nil, Default = Settings["Change Speed Boat"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Change Speed Boat"] and task.wait(0.3) do
					local ok, result = pcall(ChangeSpeedBoat)

					if not ok then
						WarnOnce("ChangeSpeedBoat", "Change Speed Boat loi: " .. tostring(result))
					end
				end
			end)
		end

		SaveSettings("Change Speed Boat", arg)
	end)

	RaceMain = Main.CreatePage({ Page_Name = "Upgrade Race", Page_Title = "Upgrade Race Tab" })
	RaceDracoSection = RaceMain.CreateSection("Race Draco")

	DetectGearUp = function(arg)
		local Buttons = require(game:GetService("Players").LocalPlayer.PlayerGui.TempleGui.LocalScriptTemple.Buttons)
		arg = arg or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TempleClock", "Check")
		if type(arg) ~= "table" then
			return
		end
		local flag = arg.HadPoint == true
		local canSelect = arg.RaceLevel >= 2
		Buttons.Gear1.GearType = "Default"
		Buttons.Gear4.GearType = "Default"
		Buttons.Gear5.GearType = "Default"
		Buttons.Gear2.GearType = "Alpha"
		Buttons.Gear2.CanSelect = false
		Buttons.Gear3.CanSelect = false
		Buttons.Gear2.GearType = arg.RaceDetails.Gears[1] == "A" and "Alpha" or arg.RaceDetails.Gears[1] == "B" and "Omega" or "Blank"
		Buttons.Gear3.GearType = arg.RaceDetails.Gears[2] == "A" and "Alpha" or arg.RaceDetails.Gears[2] == "B" and "Omega" or "Blank"
		Buttons.Gear4.GearType = arg.RaceDetails.Gears[3] == "A" and "Alpha" or arg.RaceDetails.Gears[3] == "B" and "Omega" or "Blank"
		local gear2 = Buttons.Gear2
		local unlocked

		if arg.RaceDetails.A + arg.RaceDetails.B >= 0 then
			unlocked = canSelect
		else
			unlocked = false
		end

		gear2.Unlocked = unlocked
		local gear3 = Buttons.Gear3
		local unlocked2

		if arg.RaceDetails.A + arg.RaceDetails.B >= 1 then
			unlocked2 = canSelect
		else
			unlocked2 = false
		end

		gear3.Unlocked = unlocked2
		local gear4 = Buttons.Gear4
		local unlocked3

		if arg.RaceDetails.A + arg.RaceDetails.B >= 2 then
			unlocked3 = canSelect
		else
			unlocked3 = false
		end

		gear4.Unlocked = unlocked3
		Buttons.Gear5.CanSelect = false
		Buttons.Gear5.Unlocked = false

		if arg.RaceDetails.C >= 1 then
			Buttons.Gear5.Unlocked = true
		end

		Buttons.Gear1.Unlocked = true

		if not canSelect then
			Buttons.Gear1.CanSelect = true
			Buttons.Gear1.GearType = "Blank"
			flag = true
		else
			Buttons.Gear1.CanSelect = false
			Buttons.Gear1.GearType = "Default"
		end

		if not flag then
			Buttons.Gear2.CanSelect = false
			Buttons.Gear3.CanSelect = false
			Buttons.Gear4.CanSelect = false
		else
			local gear22 = Buttons.Gear2
			local canSelect2

			if arg.RaceDetails.A + arg.RaceDetails.B == 0 then
				canSelect2 = canSelect
			else
				canSelect2 = false
			end

			gear22.CanSelect = canSelect2
			local gear32 = Buttons.Gear3
			local canSelect3

			if arg.RaceDetails.A + arg.RaceDetails.B == 1 then
				canSelect3 = canSelect
			else
				canSelect3 = false
			end

			gear32.CanSelect = canSelect3
			local gear42 = Buttons.Gear4

			if not (arg.RaceDetails.A + arg.RaceDetails.B >= 2) then
				canSelect = false
			end

			gear42.CanSelect = canSelect

			if arg.RaceDetails.A + arg.RaceDetails.B >= 3 then
				Buttons.Gear2.CanSelect = true
				Buttons.Gear3.CanSelect = true
				Buttons.Gear4.CanSelect = true

				if Buttons.Gear2.GearType == "Alpha" and Buttons.Gear3.GearType == "Alpha" and Buttons.Gear4.GearType == "Omega" then
					Buttons.Gear4.CanSelect = false
				elseif Buttons.Gear2.GearType == "Omega" and Buttons.Gear3.GearType == "Omega" and Buttons.Gear4.GearType == "Alpha" then
					Buttons.Gear4.CanSelect = false
				elseif Buttons.Gear2.GearType == "Alpha" and Buttons.Gear3.GearType == "Omega" and Buttons.Gear4.GearType == "Omega" then
					Buttons.Gear4.CanSelect = false
					Buttons.Gear2.CanSelect = false
				elseif Buttons.Gear2.GearType == "Omega" and Buttons.Gear3.GearType == "Alpha" and Buttons.Gear4.GearType == "Omega" then
					Buttons.Gear4.CanSelect = false
					Buttons.Gear3.CanSelect = false
				elseif Buttons.Gear2.GearType == "Omega" and Buttons.Gear3.GearType == "Alpha" and Buttons.Gear4.GearType == "Alpha" then
					Buttons.Gear4.CanSelect = false
					Buttons.Gear2.CanSelect = false
				elseif Buttons.Gear2.GearType == "Alpha" and Buttons.Gear3.GearType == "Omega" and Buttons.Gear4.GearType == "Alpha" then
					Buttons.Gear4.CanSelect = false
					Buttons.Gear3.CanSelect = false
				end
			end
		end

		for i_ = 1, 5 do
			local v9 = Buttons["Gear" .. i_]
			if v9 and v9.CanSelect then
				return "Gear" .. i_
			end
		end
	end

	ChooseGearV4 = function()
		local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TempleClock", "Check")
		if not response or not response.HadPoint then
			return
		end
		local v9 = DetectGearUp(response)
		if not v9 then
			return
		end
		local str2 = Settings["Select Gear V4"] == "Alpha" and "Alpha" or "Omega"
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TempleClock", "SpendPoint", v9, str2)
		local response2 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TempleClock", "Check")

		if response2 and response2.HadPoint and DetectGearUp(response2) == v9 then
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TempleClock", "SpendPoint", v9, str2 == "Alpha" and "Omega" or "Alpha")
		end
	end

	DetectFireFlower = function()
		local v9 = next
		local children, v10 = workspace.FireFlowers:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11:IsA("Model") then
				return v11
			end
		end
	end

	local tbl13 = { "V2InProgress", "V3InProgress", "V2TurnInReady", "V3TurnInReady" }

	AutoUpgradeRaceDraco = function()
		if game.Players.LocalPlayer.Data.Race.Value ~= "Draco" then
			VxezeNotify("Race Draco", "Change Race Draco plz", "warning")
			wait(5)
			return
		end

		if DetectItemPlr("Primordial Reign") then
			VxezeNotify("Race Draco", "Done V3 Draco", "success")
			wait(5)
			return
		end

		local dragonWizard = workspace.NPCs:FindFirstChild("Dragon Wizard") or game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Wizard") or NPCManager.getNPCsByName("Dragon Wizard")[1]._modelState._instance
		local flag = not getgenv().QuestDraco
		local flag2

		if flag then
			flag2 = flag
		else
			flag2 = getgenv().QuestDraco and not table.find(tbl13, getgenv().QuestDraco.AvailableVQuest)
		end

		if flag2 then
			if localPlayer:DistanceFromCharacter(dragonWizard.HumanoidRootPart.Position) > 8 then
				ToTarget(dragonWizard.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
			else
				getgenv().QuestDraco = game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dragon Wizard", Command = "Speak" })
				wait(1)

				if getgenv().QuestDraco and getgenv().QuestDraco.AvailableVQuest == "V2" or getgenv().QuestDraco.AvailableVQuest == "V3" then
					game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dragon Wizard", Command = "Ascension", Action = "Begin" })
					getgenv().QuestDraco = game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dragon Wizard", Command = "Speak" })
				end
			end
		elseif getgenv().QuestDraco.AvailableVQuest == "V2TurnInReady" then
			game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dragon Wizard", Command = "Ascension", Action = "Complete" })
			getgenv().QuestDraco = nil
		elseif getgenv().QuestDraco.AvailableVQuest == "V3TurnInReady" then
			game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dragon Wizard", Command = "Ascension", Action = "Complete" })
			getgenv().QuestDraco = nil
		elseif getgenv().QuestDraco.AvailableVQuest == "V2InProgress" then
			if not CheckCountItem("Fire Flower", 5) then
				local v9 = DetectFireFlower()

				if v9 then
					ToTarget(v9.PrimaryPart.CFrame)

					if localPlayer:DistanceFromCharacter(v9.PrimaryPart.Position) < 8 then
						fireproximityprompt(v9.ProximityPrompt, 1)
					end
				else
					local v10 = DetectMob("Forest Pirate")

					if not v10 then
						local v11 = DetectPartSpawnMob("Forest Pirate", true)

						if v11 then
							Instance.new("IntValue", v11).Name = "Ignored"

							while true do
								wait()
								ToTarget(v11.CFrame * CFrame.new(0, 60, 0))
								if not (localPlayer:DistanceFromCharacter(v11.Position) <= 100 or DetectMob("Forest Pirate") or not Settings["Auto Upgrade Race V2-V3 Draco"] or wait(1)) then
									continue
								end
								break
							end
						else
							DeleteIgnoredMobSpawn()
						end
					else
						while true do
							task.wait()
							SizePart(v10)
							BringMob(v10)
							UsedualFlock()
							ClickM1(v10)

							if Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							if not (not IsMobAlive(v10) or not Settings["Auto Upgrade Race V2-V3 Draco"]) then
								continue
							end
							break
						end
					end
				end
			elseif localPlayer:DistanceFromCharacter(dragonWizard.HumanoidRootPart.Position) > 8 then
				ToTarget(dragonWizard.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
			else
				game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dragon Wizard", Command = "Ascension", Action = "Complete" })
				getgenv().QuestDraco = nil
			end
		elseif getgenv().QuestDraco.AvailableVQuest == "V3InProgress" then
			SaveSettings("V3InProgress", true)

			if not getgenv().KilledTerroshark then
				local Terrorshark = CheckNameBoss("Terrorshark")
				local v9 = CheckBoat()

				if not Terrorshark then
					if not v9 then
						local cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

						if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
							ToTarget(cframe)
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
						end
					else
						local v10 = DecectPartRoughSea()

						if v10 then
							wait(1)
							local n

							if roughSea == 0 then
								n = 7000
							else
								n = 0
							end

							roughSea = n
							Instance.new("IntValue", v10).Name = "Ignored"
							wait(0.5)
						end

						getgenv().RoughSea = roughSea
						local n = CFrame.new(-32975.9921875, v9.WorldPivot.Y, 25963.7109375) * CFrame.new(0, v9.WorldPivot.Y, 0 + RoughSea)

						if not localPlayer.Character.Humanoid.Sit then
							ToTarget(v9.VehicleSeat.CFrame)
						else
							ManageTween(v9.VehicleSeat, n, 350, "TweenBoat")
						end
					end
				else
					while true do
						task.wait()
						TeleportSeaEvents(Terrorshark)
						local humanoidRootPart = Terrorshark:FindFirstChild("HumanoidRootPart")
						getgenv().AimPos = CFrame.new(humanoidRootPart.Position.X, 40, humanoidRootPart.Position.Z)
						UsedualFlock()
						ClickM1(Terrorshark, true)
						if not (not IsMobAlive(Terrorshark) or not Settings["Auto Upgrade Race V2-V3 Draco"]) then
							continue
						end
						break
					end

					getgenv().KilledTerroshark = true
				end
			elseif localPlayer:DistanceFromCharacter(dragonWizard.HumanoidRootPart.Position) > 8 then
				ToTarget(dragonWizard.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
			else
				game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dragon Wizard", Command = "Ascension", Action = "Complete" })
				getgenv().QuestDraco = nil
				getgenv().KilledTerroshark = false
			end
		end
	end

	RaceDracoSection.CreateToggle({
		Title = "Auto Upgrade Race V2-V3 Draco",
		Desc = nil,
		Default = Settings["Auto Upgrade Race V2-V3 Draco"] or false,
	}, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Upgrade Race V2-V3 Draco"] and task.wait(0.1) do
					local ok, result = pcall(function()
						AutoUpgradeRaceDraco()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Upgrade Race V2-V3 Draco", arg)
	end)

	CheckRelicChuaDat = function(arg)
		for _, descendant in pairs(arg:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") and descendant.Enabled then
				return true
			end
		end
	end

	GetRelicChuaDat = function(arg)
		for k, v9 in next, arg, nil do
			if string.find(k, "RelicModel") and CheckRelicChuaDat(v9) then
				return v9, k
			end
		end
	end

	GetRelicChuanbiDat = function(arg)
		for k, v9 in next, arg, nil do
			if string.find(k, "RelicModel") and v9.PrimaryPart:FindFirstChild("AlignPosition") and CheckRelicChuaDat(v9) then
				return v9, k
			end
		end
	end

	CheckModelTrialDraco = function()
		local tbl14 = {}
		v28 = workspace:WaitForChild("Map"):WaitForChild("DracoTrial", 5)
		if not v28 then
			return tbl14
		end

		for _, v9 in pairs({
			"Relic1",
			"Relic2",
			"Relic3",
			"EndRelic1",
			"EndRelic2",
			"EndRelic3",
			"Door1",
			"Door2",
			"Door3",
			"Brazier1",
			"Brazier2",
			"Brazier3",
			"Center",
			"EndPlatform",
			"TeleportOut",
		}) do
			tbl14[v9] = v28:FindFirstChild(v9, true)
		end

		local v9 = next
		local children, v10 = workspace._WorldOrigin:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11:IsA("Model") and v11.Name == "Relic" then
				local meshPart = v11:FindFirstChildWhichIsA("MeshPart")

				if meshPart.Color == Color3.fromRGB(132, 203, 0) then
					tbl14.RelicModel1 = v11
				end

				if meshPart.Color == Color3.fromRGB(232, 106, 110) then
					tbl14.RelicModel2 = v11
				end

				if meshPart.Color == Color3.fromRGB(191, 153, 0) then
					tbl14.RelicModel3 = v11
				end
			end
		end

		return tbl14
	end

	local createLabel = RaceDracoSection.CreateLabel
	getgenv().StatusGearDraco = createLabel({ Title = "Acient One Draco Status" })

	ToggleAutoTrialDraco = RaceDracoSection.CreateToggle({ Title = "Auto Trial Draco", Desc = nil, Default = Settings["Auto Trial Draco"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Trial Draco"] and task.wait(0.1) do
					local ok, result = pcall(function()
						if not GoToSea(3) then
							return
						end

						if localPlayer:DistanceFromCharacter(workspace._WorldOrigin.Locations["Trial of Flames"].Position) <= 3000 then
							if workspace.Map.DracoTrial.TrialDoor.DoorTouch:FindFirstChild("TouchInterest") then
								getgenv().DoneTrialDraco = true
								ToTarget(workspace.Map.DracoTrial.TrialDoor.DoorTouch.CFrame)
								wait(2)
								return
							end

							if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
								local v9 = CheckModelTrialDraco()
								local v10, v11 = GetRelicChuaDat(v9)
								local v12, v13 = GetRelicChuanbiDat(v9)

								if v12 then
									local v14 = v9["EndRelic" .. v13:split("RelicModel")[2]]
									local proximityPrompt = v14:FindFirstChildWhichIsA("ProximityPrompt", true)

									if localPlayer:DistanceFromCharacter(v14.WorldPivot.Position) > 8 then
										ToTarget(v14.WorldPivot)
									else
										wait(2)
										fireproximityprompt(proximityPrompt)
										wait(2)
									end
								elseif v10 then
									local v14 = v9["Relic" .. v11:split("RelicModel")[2]]
									local proximityPrompt = v14:FindFirstChildWhichIsA("ProximityPrompt", true)

									if localPlayer:DistanceFromCharacter(v14.WorldPivot.Position) > 8 then
										ToTarget(v14.WorldPivot)
									else
										wait(2)
										fireproximityprompt(proximityPrompt)
										wait(2)
									end
								end
							else
								game.ReplicatedStorage.Remotes.DracoTrial:InvokeServer()
								wait(3)
							end
						else
							if getgenv().DoneTrialDraco then
								VxezeNotify("Kill Trial", "Done Trial", "success")
								getgenv().DoneTrialDraco = false
								ToggleAutoTrialDraco:SetStage(false)
								return
							end

							if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
								if workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport") then
									ToTarget(workspace.Map.PrehistoricIsland.TrialTeleport.CFrame)
								else
									local v9 = DetectNpc("Fossil Expert")
									if v9 then
										ToTarget(v9.HumanoidRootPart.CFrame)
										return
									end
								end
							else
								VxezeNotify("Prehistoric Island", "Not have Prehistoric Island", "warning")
								wait(5)
							end
						end
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Trial Draco", arg)
	end)

	DetectRockVolcano = function()
		local v9 = next
		local children, v10 = workspace.Map.PrehistoricIsland.Core.VolcanoRocks:GetChildren()
		local huge = math.huge
		local v11 = nil

		for _, v12 in v9, children, v10 do
			if v12.Name == "Rock" and v12:FindFirstChild("VFXLayer") and v12.VFXLayer:FindFirstChild("Specs") and v12.VFXLayer.Specs.Enabled then
				local v13 = localPlayer:DistanceFromCharacter(v12.WorldPivot.Position)

				if v13 < huge then
					huge = v13
					v11 = v12
				end
			end
		end

		return v11
	end

	AutoUseSkillFixLava = function()
		local selectWeaponsFixLava = Settings["Select Weapons Fix Lava"] or {}
		local Melee = selectWeaponsFixLava.Melee and NameWeapon("Melee", true) or false
		local Sword = selectWeaponsFixLava.Sword and NameWeapon("Sword", true) or false
		local bloxFruit = selectWeaponsFixLava["Blox Fruit"] and NameWeapon("Blox Fruit", true) or false
		local Gun = selectWeaponsFixLava.Gun and NameWeapon("Gun", true) or false
		local skills = game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills
		if Melee and not skills:FindFirstChild(Melee.Name) then
			EquipTool(Melee.Name)
			return
		end

		if Sword and not skills:FindFirstChild(Sword.Name) then
			EquipTool(Sword.Name)
			return
		end

		if bloxFruit and not skills:FindFirstChild(bloxFruit.Name) then
			EquipTool(bloxFruit.Name)
			return
		end

		if Gun and not skills:FindFirstChild(Gun.Name) then
			EquipTool(Gun.Name)
			return
		end
		local v9

		if Melee and CheckCDSkillTransformation(Melee, Settings["Select Skills " .. Melee.ToolTip]) then
			v9 = CheckCDSkillTransformation(Melee, Settings["Select Skills " .. Melee.ToolTip])
		elseif Sword and CheckCDSkillTransformation(Sword, Settings["Select Skills " .. Sword.ToolTip]) then
			v9 = CheckCDSkillTransformation(Sword, Settings["Select Skills " .. Sword.ToolTip])
		elseif Gun and CheckCDSkillTransformation(Gun, Settings["Select Skills " .. Gun.ToolTip]) then
			v9 = CheckCDSkillTransformation(Gun, Settings["Select Skills " .. Gun.ToolTip])
		elseif bloxFruit and CheckCDSkillTransformation(bloxFruit, Settings["Select Skills " .. bloxFruit.ToolTip]) then
			v9 = CheckCDSkillTransformation(bloxFruit, Settings["Select Skills " .. bloxFruit.ToolTip])
		else
			v9 = nil
		end

		local v10 = v9

		if v10 then
			local name_ = v10.Parent.Name
			EquipTool(name_)

			if localPlayer.Character:FindFirstChild(name_) then
				pcall(function()
					game:GetService("VirtualInputManager"):SendKeyEvent(true, v10.Name, false, game)
				end)

				if Settings["Use skill fast dont hold"] then
					task.wait(0.05)
				else
					task.wait(GetHoldSkillDelay(v10.Name, name_))
				end

				pcall(function()
					game:GetService("VirtualInputManager"):SendKeyEvent(false, v10.Name, false, game)
				end)
			end
		end
	end

	DetectLava = function()
		local v9 = next
		local descendants, v10 = workspace.Map.PrehistoricIsland:GetDescendants()

		for _, v11 in v9, descendants, v10 do
			if v11.Name == "TouchInterest" and v11.Parent.Name ~= "TrialTeleport" then
				return true
			end
		end
	end

	DetectGolem = function()
		for _, child in ipairs(game.workspace.Enemies:GetChildren()) do
			if child.Name == "Lava Golem" and IsMobAlive(child) and localPlayer:DistanceFromCharacter(child.HumanoidRootPart.Position) <= 1500 then
				return child
			end
		end
	end

	DeleteLava = function()
		local v9 = next
		local children, v10 = workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren()

		for _, v11 in v9, children, v10 do
			v11:Destroy()
		end
	end

	DetectPositionVolcano = function()
		local tbl14 = { workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull.Position }
		local v9 = next
		local descendants, v10 = workspace.Map.PrehistoricIsland:GetDescendants()

		for _, v11 in v9, descendants, v10 do
			if v11:IsA("MeshPart") and v11.MeshId == "rbxassetid://87519803677536" and math.floor(v11.Position.Y) == 293 then
				tbl14[2] = v11.Position
			end

			if v11:IsA("MeshPart") and v11.MeshId == "rbxassetid://9664674474" and math.floor(v11.Position.Y) == 234 then
				tbl14[3] = v11.Position
			end

			if v11:IsA("MeshPart") and v11.MeshId == "rbxassetid://14130842310" and math.floor(v11.Position.Y) == 266 then
				tbl14[4] = v11.Position
			end

			if v11:IsA("MeshPart") and v11.MeshId == "rbxassetid://15672470777" and math.floor(v11.Position.Y) == 86 then
				tbl14[5] = v11.Position
			end

			if v11:IsA("MeshPart") and v11.MeshId == "rbxassetid://5159878936" and math.floor(v11.Position.Y) == 261 then
				tbl14[6] = v11.Position
			end

			if v11:IsA("MeshPart") and v11.MeshId == "rbxassetid://138849514693209" and math.floor(v11.Position.Y) == 242 then
				tbl14[7] = v11.Position
			end

			if v11:IsA("MeshPart") and v11.MeshId == "rbxassetid://87519803677536" and math.floor(v11.Position.Y) == 279 then
				tbl14[8] = v11.Position
			end
		end

		return tbl14
	end

	CheckPosnearRock = function(arg, arg2)
		local huge = math.huge
		local v9 = nil
		local n = 0

		for k, v10 in next, arg, nil do
			local vector = Vector3.new(v10.X, 0, v10.Z)
			local magnitude = (Vector3.new(arg2.Position.X, 0, arg2.Position.Z) - vector).Magnitude

			if huge > magnitude then
				huge = magnitude
				v9 = v10
				n = k
			end
		end

		return v9, n
	end

	local flag
	flag = false
	local n3
	n3 = 1
	local tbl14

	tbl14 = {
		[273] = CFrame.new(40, 0, 0),
		[286] = CFrame.new(40, 0, 0),
		[246] = CFrame.new(0, -40, 0),
		[486] = CFrame.new(40, 0, 0),
		[364] = CFrame.new(40, 0, 0),
		[682] = CFrame.new(0, 0, -40),
		[490] = CFrame.new(0, 40, 0),
		[691] = CFrame.new(40, 0, 0),
		[502] = CFrame.new(-40, 0, 0),
		[256] = CFrame.new(-40, 0, 0),
		[290] = CFrame.new(0, 40, 0),
		[427] = CFrame.new(0, 40, 0),
		[692] = CFrame.new(0, 0, 40),
		[316] = CFrame.new(0, 40, 0),
		[481] = CFrame.new(0, 40, 0),
		[594] = CFrame.new(0, 40, 0),
		[649] = CFrame.new(40, 0, 0),
		[285] = CFrame.new(0, -40, 0),
		[250] = CFrame.new(0, 40, 0),
		[454] = CFrame.new(-40, 0, 0),
	}

	BuyGearDracoV4 = function()
		if string.find(CheckAcientOneDracoStatus(), "Can Buy Gear") then
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
		end
	end

	FullyDraco = function()
		if not Settings["Auto Turn On V4"] then
			callback3:SetStage(true)
		end

		if not Settings["Auto Choose Gears"] and getgenv().ToggleAutoChooseGears then
			getgenv().ToggleAutoChooseGears:SetStage(true)
		end

		if CheckAcientOneDracoStatus() == "Ready For Trial" then
			if getgenv().WaitingjoinTrial then
				wait(5)
				getgenv().WaitingjoinTrial = false
			end

			if localPlayer:DistanceFromCharacter(workspace._WorldOrigin.Locations["Trial of Flames"].Position) <= 3000 then
				if workspace.Map.DracoTrial.TrialDoor.DoorTouch:FindFirstChild("TouchInterest") then
					getgenv().DoneTrialDraco = true
					ToTarget(workspace.Map.DracoTrial.TrialDoor.DoorTouch.CFrame)
					wait(2)
					return
				end

				if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
					local v9 = CheckModelTrialDraco()
					local v10, v11 = GetRelicChuaDat(v9)
					local v12, v13 = GetRelicChuanbiDat(v9)

					if v12 then
						local v14 = v9["EndRelic" .. v13:split("RelicModel")[2]]
						local proximityPrompt = v14:FindFirstChildWhichIsA("ProximityPrompt", true)

						if localPlayer:DistanceFromCharacter(v14.WorldPivot.Position) > 8 then
							ToTarget(v14.WorldPivot)
						else
							wait(2)
							fireproximityprompt(proximityPrompt)
							wait(2)
						end
					elseif v10 then
						local v14 = v9["Relic" .. v11:split("RelicModel")[2]]
						local proximityPrompt = v14:FindFirstChildWhichIsA("ProximityPrompt", true)

						if localPlayer:DistanceFromCharacter(v14.WorldPivot.Position) > 8 then
							ToTarget(v14.WorldPivot)
						else
							wait(2)
							fireproximityprompt(proximityPrompt)
							wait(2)
						end
					end
				else
					game.ReplicatedStorage.Remotes.DracoTrial:InvokeServer()
					wait(3)
				end
			else
				if getgenv().DoneTrialDraco then
					wait(5)
					getgenv().DoneTrialDraco = false
					return
				end

				if not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
					getgenv().RespawnVolcano = true
					getgenv().turnoffnoclipBoatt = true

					if not CheckItemInventory("Volcanic Magnet") and not Settings["Ignore Craft Volcanic Magnet Draco"] then
						if getgenv().dacoMagnet then
							local now = tick()

							while true do
								wait()
								if not (tick() - now >= 5 or game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")) then
									continue
								end
								break
							end

							getgenv().dacoMagnet = false
							return
						end

						if not CheckCountItem("Scrap Metal", 10) then
							local tbl15 = { "Jungle Pirate", "Musketeer Pirate" }
							local v9 = DetectMob(tbl15)

							if not v9 then
								if typeof(tbl15) == "table" then
									if #tbl15 <= #tbl5 then
										tbl5 = {}
										return
									end
									local v10 = DetectPartSpawnMob(DetectNameTablePart(tbl15))

									if v10 then
										table.insert(tbl5, DetectNameTablePart(tbl15))

										while true do
											wait()
											ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
											if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl15) or not Settings["Fully Trial Draco"]) then
												continue
											end
											break
										end

										wait(1)
									end
								end
							else
								while true do
									task.wait()
									SizePart(v9)
									BringMob(v9)
									UsedualFlock()
									ClickM1(v9)

									if Settings["Select Weapon"] == "Blox Fruit" then
										ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end

									if not (not IsMobAlive(v9) or not Settings["Fully Trial Draco"]) then
										continue
									end
									break
								end
							end

							return
						end

						if not CheckCountItem("Blaze Ember", 15) then
							local dragonHunter = workspace.NPCs:FindFirstChild("Dragon Hunter") or game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Hunter") or NPCManager.getNPCsByName("Dragon Hunter")[1]._modelState._instance

							if not getgenv().QuestHunterDragon then
								if localPlayer:DistanceFromCharacter(dragonHunter.HumanoidRootPart.Position) > 8 then
									ToTarget(dragonHunter.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
								else
									local response = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({ { Context = "Check" } }))

									if not response or response and not response.Text then
										getgenv().QuestHunterDragon = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({ { Context = "RequestQuest" } })).Text
									else
										local text = response.Text
										getgenv().QuestHunterDragon = text
									end
								end
							else
								local v9 = DetectEmberTemplate()

								if v9 then
									Instance.new("IntValue", v9).Name = "Ignored"

									while true do
										wait()
										ToTarget(v9.Part.CFrame)
										if not (not v9 or not v9.Parent) then
											continue
										end
										break
									end

									return
								end

								if string.find(getgenv().QuestHunterDragon, "Hydra Enforcers") then
									local v10 = DetectMob("Hydra Enforcer")

									if not v10 then
										local v11 = DetectPartSpawnMob("Hydra Enforcer", true)

										if v11 then
											Instance.new("IntValue", v11).Name = "Ignored"

											while true do
												wait()
												ToTarget(v11.CFrame * CFrame.new(0, 60, 0))
												if not (localPlayer:DistanceFromCharacter(v11.Position) <= 100 or DetectMob("Hydra Enforcer") or not Settings["Fully Trial Draco"] or v9) then
													continue
												end
												break
											end

											wait(1)
										else
											DeleteIgnoredMobSpawn()
										end
									else
										while true do
											task.wait()
											SizePart(v10)
											BringMob(v10)
											UsedualFlock()
											ClickM1(v10)

											if Settings["Select Weapon"] == "Blox Fruit" then
												ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
											else
												ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
											end

											if not (not IsMobAlive(v10) or not Settings["Fully Trial Draco"] or v9) then
												continue
											end
											break
										end
									end
								elseif string.find(getgenv().QuestHunterDragon, "Venomous Assailants") then
									local v10 = DetectMob("Venomous Assailant")

									if not v10 then
										local v11 = DetectPartSpawnMob("Venomous Assailant", true)

										if v11 then
											Instance.new("IntValue", v11).Name = "Ignored"

											while true do
												wait()
												ToTarget(v11.CFrame * CFrame.new(0, 60, 0))
												if not (localPlayer:DistanceFromCharacter(v11.Position) <= 100 or DetectMob("Venomous Assailant") or not Settings["Fully Trial Draco"] or v9) then
													continue
												end
												break
											end

											wait(1)
										else
											DeleteIgnoredMobSpawn()
										end
									else
										while true do
											task.wait()
											SizePart(v10)
											BringMob(v10)
											UsedualFlock()
											ClickM1(v10)

											if Settings["Select Weapon"] == "Blox Fruit" then
												ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
											else
												ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
											end

											if not (not IsMobAlive(v10) or not Settings["Fully Trial Draco"] or v9) then
												continue
											end
											break
										end
									end
								elseif string.find(getgenv().QuestHunterDragon, "trees") then
									local currentCamera = workspace.CurrentCamera
									local v10 = DetectTree()

									if v10 then
										Instance.new("IntValue", v10).Name = "Ignored"
										local now = tick()

										while true do
											wait()
											local position = v10.WorldPivot.Position

											if localPlayer:DistanceFromCharacter(position) < 50 then
												AutoAllSkill()
											end

											if v10:FindFirstChild("Meshes/plant1_Icosphere", true) then
												ToTarget(v10.WorldPivot)
												local worldPivot = v10.WorldPivot
												getgenv().AimPos = worldPivot
												replicatedStorage6.Hit = CFrame.new(currentCamera.CFrame.Position, position)
												replicatedStorage6.Target = v10
											else
												local position2 = (v10.WorldPivot * CFrame.new(5, -20, 0)).Position
												local position3 = (v10.WorldPivot * CFrame.new(0, -20, 0)).Position
												ToTarget(CFrame.new(position2))
												getgenv().AimPos = CFrame.new(position3)
												replicatedStorage6.Hit = CFrame.new(currentCamera.CFrame.Position, position3)
												replicatedStorage6.Target = v10
											end

											if not (not v10 or not v10.Parent or not Settings["Fully Trial Draco"] or v9 or v10:GetAttribute("AlreadyDestroyedClient") or tick() - now >= 15) then
												continue
											end
											break
										end
									end
								end
							end

							return
						end

						if CheckCountItem("Scrap Metal", 10) and CheckCountItem("Blaze Ember", 15) then
							game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({ "Craft", "Volcanic Magnet", 1, {} }))
							wait(2)
						end
					else
						getgenv().dacoMagnet = true

						if not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
							local v9 = CheckBoat()

							if not v9 or v9 and localPlayer:DistanceFromCharacter(v9.VehicleSeat.Position) >= 4000 then
								local cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

								if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
									if localPlayer:DistanceFromCharacter(cframe.Position) > 1000 then
										if not localPlayer:GetAttribute("CurrentLocation") or localPlayer:GetAttribute("CurrentLocation") ~= "Tiki Outpost" then
											if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki" or game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki2" then
												localPlayer.Character.Humanoid.Health = 0
												return
											end
										end
									end

									ToTarget(cframe)
								else
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
									wait(3)
								end
							elseif localPlayer.Character.Humanoid.Sit then
								task.spawn(function()
									NoclipBoat(v9)
								end)

								ManageTween(v9.VehicleSeat, CFrame.new(-118834.515625, v9.WorldPivot.Y, -78.950584411621094) * CFrame.new(0, 0, 99999999), 350, "TweenBoat")
							else
								if getgenv().TweenBoat then
									getgenv().TweenBoat:Pause()
									getgenv().TweenBoat:Cancel()
								end

								ToTarget(v9.VehicleSeat.CFrame)
							end
						end
					end
				else
					if getgenv().turnoffnoclipBoatt then
						getgenv().turnoffnoclipBoatt = false
						local v9 = CheckBoat()

						if v9 then
							TurnOffNoclipBoat(v9)
						end
					end

					if getgenv().RespawnVolcano and Settings["Webhook Find Prehistoric Island"] then
						getgenv().RespawnVolcano = false
						WebhookFindVolcano()
					end

					if getgenv().TweenBoat then
						getgenv().TweenBoat:Pause()
						getgenv().TweenBoat:Cancel()
					end

					if not localPlayer:GetAttribute("CurrentLocation") or localPlayer:GetAttribute("CurrentLocation") ~= "Prehistoric Island" then
						local v9 = DetectNpc("Fossil Expert")
						if v9 then
							ToTarget(v9.HumanoidRootPart.CFrame)
							return
						end
					end

					if workspace.Map.PrehistoricIsland:FindFirstChild("TrialRock", true).Transparency == 1 then
						getgenv().WaitingjoinTrial = true
						ToTarget(workspace.Map.PrehistoricIsland.TrialTeleport.CFrame)
						return
					end

					if DetectLava() then
						local v9 = next
						local descendants, v10 = workspace.Map.PrehistoricIsland:GetDescendants()

						for _, v11 in v9, descendants, v10 do
							if v11.Name == "TouchInterest" and v11.Parent.Name ~= "TrialTeleport" then
								v11:Destroy()
							end
						end
					end

					if #workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren() > 0 then
						DeleteLava()
					end

					if not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
						if workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt") and workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt") then
							ToTarget(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)

							if localPlayer:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.Position) < 8 then
								fireproximityprompt(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt, 1)
								wait(3)
							end

							return
						end

						if not workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt") and not workspace.Map.PrehistoricIsland.Core:FindFirstChild("FossilExpertSpawn") then
							local v9 = DetectNpc("Fossil Expert")
							if v9 then
								ToTarget(v9.HumanoidRootPart.CFrame)
								return
							end
						end
					else
						if flag then
							local skull = workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull

							while true do
								task.wait()
								ToTarget(skull.Position, skull.CFrame)
								if not (localPlayer:DistanceFromCharacter(skull.Position) <= 200 or DetectGolem() or DetectRockVolcano()) then
									continue
								end
								break
							end

							flag = false
							return
						end

						local v9 = DetectGolem()

						if v9 then
							while true do
								task.wait()
								ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(0, 20, 7))

								if Settings["Select Method Kill Golem"] == "Instant Kill [ Risk and can bug no die mob ]" then
									if localPlayer:DistanceFromCharacter(v9.HumanoidRootPart.Position) < 50 then
										KillRaidEnemy()
									end
								else
									EquipTool(NameWeapon(Settings["Select Weapon Kill Golem"] or "Melee"))
									getgenv().ClickM1Volcano(v9)
								end

								KillAuraTick()
								if not (not IsMobAlive(v9) or not Settings["Fully Trial Draco"] or not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible) then
									continue
								end
								break
							end
						end

						local v10 = DetectRockVolcano()

						if v10 then
							if Settings["Fix Volcano Safe"] then
								local v11 = DetectPositionVolcano()
								local v12, v13 = CheckPosnearRock(v11, localPlayer.Character.HumanoidRootPart)
								local distanceFromCharacter = localPlayer.DistanceFromCharacter
								local v14 = CheckPosnearRock(v11, v10.WorldPivot)

								if distanceFromCharacter(localPlayer, v14) >= 400 then
									n3 = v13 + 1

									if v13 >= 7 then
										n3 = 1
									end

									ToTarget(CFrame.new(v11[n3]))
								else
									local v15 = tbl14[math.floor(v10.WorldPivot.Position.Y)]

									while true do
										task.wait()

										if localPlayer:DistanceFromCharacter((v10.WorldPivot * v15).Position) > 8 then
											ToTarget(v10.WorldPivot * v15)
										end

										if localPlayer:DistanceFromCharacter(v10.WorldPivot.Position) < 100 then
											AutoUseSkillFixLava()
										end

										local worldPivot = v10.WorldPivot
										getgenv().AimPos = worldPivot
										replicatedStorage6.Hit = v10.WorldPivot
										replicatedStorage6.Target = v10
										if not (not v10 or not v10.Parent or not Settings["Fully Trial Draco"] or not v10.VFXLayer.Specs.Enabled or DetectGolem() or not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible) then
											continue
										end
										break
									end

									if not DetectGolem() then
										flag = true
									end

									wait(1)
								end
							else
								local v11 = tbl14[math.floor(v10.WorldPivot.Position.Y)]

								while true do
									task.wait()

									if localPlayer:DistanceFromCharacter((v10.WorldPivot * v11).Position) > 8 then
										ToTarget(v10.WorldPivot * v11)
									end

									if localPlayer:DistanceFromCharacter(v10.WorldPivot.Position) < 100 then
										AutoUseSkillFixLava()
									end

									local worldPivot = v10.WorldPivot
									getgenv().AimPos = worldPivot
									replicatedStorage6.Hit = v10.WorldPivot
									replicatedStorage6.Target = v10
									local flag2 = not v10 or not v10.Parent or not Settings["Fully Trial Draco"] or not v10.VFXLayer.Specs.Enabled or DetectGolem() or not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
									local flag3

									if flag2 then
										flag3 = flag2
									else
										flag3 = not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
									end

									if not flag3 then
										continue
									end
									break
								end

								if not DetectGolem() then
									flag = true
								end
							end
						end
					end
				end
			end
		elseif string.find(CheckAcientOneDracoStatus(), "Can Buy Gear") then
			BuyGearDracoV4()
		else
			local v9 = DetectMob(tbl8)

			if v9 then
				while true do
					task.wait()
					SizePart(v9)
					BringMob(v9)
					UsedualFlock()
					ClickM1(v9)

					if Settings["Select Weapon"] == "Blox Fruit" then
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end

					if not (not IsMobAlive(v9) or not Settings["Fully Trial Draco"]) then
						continue
					end
					break
				end
			elseif typeof(tbl8) == "table" then
				if #tbl8 <= #tbl5 then
					tbl5 = {}
					return
				end
				local v10 = DetectPartSpawnMob(DetectNameTablePart(tbl8))

				if v10 then
					table.insert(tbl5, DetectNameTablePart(tbl8))

					while true do
						wait()
						ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
						if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl8) or not Settings["Fully Trial Draco"]) then
							continue
						end
						break
					end

					wait(1)
				end
			else
				local v10 = DetectPartSpawnMob(tbl8, true)

				if v10 then
					Instance.new("IntValue", v10).Name = "Ignored"

					while true do
						wait()
						ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
						if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl8) or not Settings["Fully Trial Draco"]) then
							continue
						end
						break
					end

					wait(1)
				else
					DeleteIgnoredMobSpawn()
				end
			end
		end
	end

	RaceDracoSection.CreateToggle({
		Title = "Fully Trial Draco",
		Desc = "Auto Craft and Auto Find and Auto Attack and Fix\n Auto Trial and auto Train Race and Buy Gear and Choose Gear",
		Default = Settings["Fully Trial Draco"] or false,
	}, function(arg)
		if arg then
			spawn(function()
				while Settings["Fully Trial Draco"] and task.wait(0.1) do
					local ok, result = pcall(function()
						FullyDraco()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Fully Trial Draco", arg)
	end)

	RaceDracoSection.CreateToggle({
		Title = "Ignore Craft Volcanic Magnet [ Fully Draco ]",
		Desc = nil,
		Default = Settings["Ignore Craft Volcanic Magnet Draco"] or false,
	}, function(arg)
		SaveSettings("Ignore Craft Volcanic Magnet Draco", arg)
	end)

	RaceDracoSection.CreateToggle({ Title = "Auto Buy Gear Draco", Desc = nil, Default = Settings["Auto Buy Gear Draco"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Buy Gear Draco"] and wait(0.3) do
					pcall(function()
						BuyGearDracoV4()
					end)
				end
			end)
		end

		SaveSettings("Auto Buy Gear Draco", arg)
	end)

	RaceDracoSection.CreateToggle({
		Title = "Auto Finish Train Draco Quest",
		Desc = nil,
		Default = Settings["Auto Finish Train Draco Quest"] or false,
	}, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Finish Train Draco Quest"] and wait(0.1) do
					pcall(function()
						if string.find(CheckAcientOneDracoStatus(), "Can Buy Gear") then
							BuyGearDracoV4()
						else
							local v9 = DetectMob(tbl8)

							if v9 then
								while true do
									task.wait()
									SizePart(v9)
									BringMob(v9)
									UsedualFlock()
									ClickM1(v9)

									if Settings["Select Weapon"] == "Blox Fruit" then
										ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end

									if not (not IsMobAlive(v9) or not Settings["Auto Finish Train Draco Quest"]) then
										continue
									end
									break
								end
							elseif typeof(tbl8) == "table" then
								if #tbl5 >= #tbl8 then
									tbl5 = {}
									return
								end
								local v10 = DetectPartSpawnMob(DetectNameTablePart(tbl8))

								if v10 then
									table.insert(tbl5, DetectNameTablePart(tbl8))

									while true do
										wait()
										ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
										if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl8) or not Settings["Auto Finish Train Draco Quest"]) then
											continue
										end
										break
									end

									wait(1)
								end
							else
								local v10 = DetectPartSpawnMob(tbl8, true)

								if v10 then
									Instance.new("IntValue", v10).Name = "Ignored"

									while true do
										wait()
										ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
										if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl8) or not Settings["Auto Finish Train Draco Quest"]) then
											continue
										end
										break
									end

									wait(1)
								else
									DeleteIgnoredMobSpawn()
								end
							end
						end
					end)
				end
			end)
		end

		SaveSettings("Auto Finish Train Draco Quest", arg)
	end)

	RaceNormalSection = RaceMain.CreateSection("Race Normal")

	AutoMinkV2 = function()
		local v9 = GetNearestChest()

		if v9 then
			local now = nil

			while true do
				task.wait()

				if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v9.Position).Magnitude <= 5 then
					if not now then
						now = tick()
					elseif tick() - now >= 5 then
						Instance.new("IntValue", v9).Name = "Ignored"
						wait(0.5)
					end

					pcall(function()
						game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
					end)

					wait()

					pcall(function()
						game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
					end)

					TweenManager.CancelCurrent()
				end

				ToTarget(v9.CFrame, true)
				if not (not v9 or not v9.Parent or not Settings["Auto Upgrade Race V2-V3"] or v9:GetAttribute("IsDisabled") or v9:FindFirstChild("Ignored") or not v9:FindFirstChild("TouchInterest")) then
					continue
				end
				break
			end
		else
			local v10 = PathFindChest()

			if v10 then
				ToTarget(v10.Part.CFrame)

				if localPlayer:DistanceFromCharacter(v10.Part.Position) <= 100 or GetNearestChest() then
					Instance.new("IntValue", v10).Name = "Ignored"
				end
			else
				for _, child in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
					if child:FindFirstChild("Ignored") then
						child:FindFirstChild("Ignored"):Destroy()
					end
				end
			end
		end
	end

	DetectSeabeast = function()
		local v9 = next
		local children, v10 = game:GetService("Workspace").SeaBeasts:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11.Name ~= "SeaBeast1" then
				continue
			end
			local text = v11.HealthBBG.Frame.TextLabel.Text
			local text2 = v11.HealthBBG.Frame.TextLabel.Text
			local v12 = tonumber
			local str2

			if string.find(text:gsub("/%d+,%d+", ""), ",") then
				str2 = text2:gsub("%d+,%d+/", "")
			else
				str2 = text2:gsub("%d+/", "")
			end

			local str3 = str2:gsub(",", "")
			if v12(str3) >= 90000 then
				return v11
			end
		end

		return false
	end

	AutoFishV2 = function()
		local v9 = DetectSeabeast()
		local v10 = CheckBoat()

		if not v9 then
			if not v10 then
				local cframe = CFrame.new(-11.948337554931641, 10.293913841247559, 2957.010498046875)

				if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
					ToTarget(cframe)
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
				end
			else
				local cframe = CFrame.new(753.06536865234375, v10.WorldPivot.Y, 6994.5146484375)

				if (v10.VehicleSeat.Position - cframe.Position).Magnitude > 50 then
					v10.VehicleSeat.CFrame = cframe
				elseif not localPlayer.Character.Humanoid.Sit then
					ToTarget(v10.VehicleSeat.CFrame)
				end
			end
		else
			while true do
				task.wait()
				TeleportSeaEvents(v9)
				local humanoidRootPart = v9:FindFirstChild("HumanoidRootPart")
				getgenv().AimPos = CFrame.new(humanoidRootPart.Position.X, 40, humanoidRootPart.Position.Z)

				if localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
					AutoAllSkill()
				end

				if not (not v9 or not v9.Parent or v9.Health.Value <= 0 or not Settings["Auto Upgrade Race V2-V3"]) then
					continue
				end
				break
			end
		end
	end

	CheckRace = function()
		local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
		local response2 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
		if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
			return " V4"
		end

		if response == -2 then
			return " V3"
		end

		if response2 == -2 then
			return " V2"
		end
		return " V1"
	end

	getgenv().Chests = {}
	getgenv().BlBossHuman = {}

	do
		local tbl15 = {}
		local tbl16 = {}

		DetectPlayerAngel = function()
			local v9 = pairs
			local Players2 = game:GetService("Players")

			for _, child in v9(Players2:GetChildren()) do
				if child.Name ~= localPlayer.Name and game:GetService("Workspace").Characters:FindFirstChild(child.Name) and child.Data.Race.Value == "Skypiea" and not table.find(tbl15, child.Name) and child.Character:FindFirstChild("Humanoid") and child.Character.Humanoid.Health > 0 then
					return child
				end
			end
		end

		DetectPlayerGhoul = function()
			local v9 = pairs
			local Players2 = game:GetService("Players")

			for _, child in v9(Players2:GetChildren()) do
				if child.Name ~= localPlayer.Name and game:GetService("Workspace").Characters:FindFirstChild(child.Name) and not table.find(tbl16, child.Name) and child.Character:FindFirstChild("Humanoid") and child.Character.Humanoid.Health > 0 then
					return child
				end
			end
		end

		CheckSafezone = function(arg)
			for _, child in pairs(game:GetService("Workspace")._WorldOrigin.SafeZones:GetChildren()) do
				if child:IsA("Part") then
					if (child.Position - arg.HumanoidRootPart.Position).magnitude <= 400 and arg.Humanoid.Health / arg.Humanoid.MaxHealth >= 0.9 then
						return true
					end
				end
			end

			return false
		end

		CheckPlayercantAttack = function(arg)
			for _, descendant in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetDescendants()) do
				if descendant:IsA("TextLabel") then
					if string.find(descendant.Text, "attack") and not descendant:FindFirstChild(arg.Name) then
						local textBox = Instance.new("TextBox")
						textBox.Parent = descendant.Parent
						textBox.Name = arg.Name
						descendant:Destroy()
						return true
					end
				end
			end
		end

		UpgradeRaceV2AndV3 = function()
			local v9 = CheckRace()

			if v9 == " V3" then
				VxezeNotify("Race V3", "Done V3", "success")
				wait(5)
				return
			end

			if not GoToSea(2) then
				return
			end

			if v9 == " V1" then
				if localPlayer.Data.Beli.Value < 500000 then
					VxezeNotify("Race V3", "Beli >= 500k", "warning")
					wait(5)
					return
				end

				local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")

				if response == 0 then
					game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "2")
				elseif response == 1 then
					if not DetectItemPlr("Flower 1") then
						ToTarget(game:GetService("Workspace").Flower1.CFrame)
					elseif not DetectItemPlr("Flower 2") then
						ToTarget(game:GetService("Workspace").Flower2.CFrame)
					elseif not DetectItemPlr("Flower 3") then
						local v10 = DetectMob("Swan Pirate")

						if not v10 then
							if typeof("Swan Pirate") == "table" then
								if #tbl5 >= 11 then
									tbl5 = {}
									return
								end
								local v11 = DetectPartSpawnMob(DetectNameTablePart("Swan Pirate"))

								if v11 then
									table.insert(tbl5, DetectNameTablePart("Swan Pirate"))

									while true do
										wait()
										ToTarget(v11.CFrame * CFrame.new(0, 60, 0))
										if not (localPlayer:DistanceFromCharacter(v11.Position) <= 100 or DetectMob("Swan Pirate") or not Settings["Auto Upgrade Race V2-V3"]) then
											continue
										end
										break
									end

									wait(1)
								end
							else
								local v11 = DetectPartSpawnMob("Swan Pirate", true)

								if v11 then
									Instance.new("IntValue", v11).Name = "Ignored"

									while true do
										wait()
										ToTarget(v11.CFrame * CFrame.new(0, 60, 0))
										if not (localPlayer:DistanceFromCharacter(v11.Position) <= 100 or DetectMob("Swan Pirate") or not Settings["Auto Upgrade Race V2-V3"]) then
											continue
										end
										break
									end

									wait(1)
								else
									DeleteIgnoredMobSpawn()
								end
							end
						else
							while true do
								task.wait()
								SizePart(v10)
								BringMob(v10)
								UsedualFlock()
								ClickM1(v10)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								if not (not IsMobAlive(v10) or not Settings["Auto Upgrade Race V2-V3"]) then
									continue
								end
								break
							end
						end
					end
				elseif response == 2 then
					if localPlayer:DistanceFromCharacter(Vector3.new(-2777.6, 72.96614, -3571.4229)) > 8 then
						ToTarget(CFrame.new(-2777.6001, 72.9661407, -3571.42285))
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3")
					end
				else
					AutoQuestBarito()
				end
			else
				local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
				if response == 0 then
					game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
					return
				end

				if response == 2 then
					game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3")
					return
				end

				if response == -1 then
					VxezeNotify("Race V4", "Beli >= 2m", "warning")
					wait(5)
					return
				end

				local str2 = game:GetService("Players").LocalPlayer.Data.Race.Value .. v9

				if str2 == "Human V2" then
					local Jeremy = not table.find(BlBossHuman, "Jeremy") and CheckNameBoss("Jeremy") or not table.find(BlBossHuman, "Orbitus") and CheckNameBoss("Orbitus") or not table.find(BlBossHuman, "Diamond") and CheckNameBoss("Diamond")

					if Jeremy then
						local v10 = CheckNameBoss(Jeremy.Name)

						if v10 then
							while true do
								task.wait()
								SizePart(v10)
								UsedualFlock()
								ClickM1(v10)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								if IsMobAlive(v10) then
									continue
								end
								break
							end

							if not table.find(BlBossHuman, Jeremy.Name) then
								table.insert(BlBossHuman, Jeremy.Name)
							end
						end
					else
						VxezeNotify("Boss Spawn", "Waiting Boss Spawn", "warning")
						wait(5)
					end
				elseif str2 == "Mink V2" then
					AutoMinkV2()
				elseif str2 == "Cyborg V2" then
					if not CheckFruitplr() then
						if TakeFruitInventory(true) then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", TakeFruitInventory(true))
						end
					end
				elseif str2 == "Fishman V2" then
					AutoFishV2()
				elseif str2 == "Skypiea V2" then
					local v10 = DetectPlayerAngel()

					if v10 then
						table.insert(tbl15, v10.Name)
						local now = tick()

						while true do
							wait()

							spawn(function()
								if game:GetService("Players").LocalPlayer.PlayerGui.Main.BottomHUDList.PvpDisabled.Visible then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
								end
							end)

							spawn(function()
								getgenv().AimPos = CFrame.new(v10.Character.HumanoidRootPart.CFrame.p, v10.Character.HumanoidRootPart.Position + v10.Character.HumanoidRootPart.Velocity / 1.2)

								if localPlayer:DistanceFromCharacter(v10.Character.HumanoidRootPart.Position) < 50 then
									localPlayer.Character.HumanoidRootPart.CFrame = v10.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
								else
									ToTarget(v10.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
								end
							end)

							spawn(function()
								if localPlayer:DistanceFromCharacter(v10.Character.HumanoidRootPart.Position) < 50 then
									AutoAllSkill(true)
								end
							end)

							if not (tick() - now >= 70 or not v10.Character or not v10.Character.Parent or v10.Character.Humanoid.Health == 0 or CheckSafezone(v10.Character) or CheckPlayercantAttack(v10.Character) or not Settings["Auto Upgrade Race V2-V3"]) then
								continue
							end
							break
						end
					else
						HopServer()
						wait(5)
					end
				elseif str2 == "Ghoul V2" then
					local v10 = DetectPlayerGhoul()

					if v10 then
						table.insert(tbl16, v10.Name)
						local now = tick()

						while true do
							wait()

							spawn(function()
								if game:GetService("Players").LocalPlayer.PlayerGui.Main.BottomHUDList.PvpDisabled.Visible then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
								end
							end)

							spawn(function()
								getgenv().AimPos = CFrame.new(v10.Character.HumanoidRootPart.CFrame.p, v10.Character.HumanoidRootPart.Position + v10.Character.HumanoidRootPart.Velocity / 1.2)

								if localPlayer:DistanceFromCharacter(v10.Character.HumanoidRootPart.Position) < 50 then
									localPlayer.Character.HumanoidRootPart.CFrame = v10.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
								else
									ToTarget(v10.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
								end
							end)

							spawn(function()
								if localPlayer:DistanceFromCharacter(v10.Character.HumanoidRootPart.Position) < 50 then
									AutoAllSkill(true)
								end
							end)

							if not (tick() - now >= 70 or not v10.Character or not v10.Character.Parent or v10.Character.Humanoid.Health == 0 or CheckSafezone(v10.Character) or CheckPlayercantAttack(v10.Character) or not Settings["Auto Upgrade Race V2-V3"]) then
								continue
							end
							break
						end
					else
						HopServer()
						wait(5)
					end
				end
			end
		end
	end

	RaceNormalSection.CreateToggle({
		Title = "Auto Upgrade Race V2-V3",
		Desc = nil,
		Default = Settings["Auto Upgrade Race V2-V3"] or false,
	}, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Upgrade Race V2-V3"] and wait(0.1) do
					local ok, result = pcall(function()
						UpgradeRaceV2AndV3()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Upgrade Race V2-V3", arg)
	end)

	BuyChipLaw = function()
		local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
		return response == 1 or response == 2
	end

	do
		local n = 0
		local flag2 = false
		local flag3 = false

		DetectkeyCyborg = function(arg)
			local v9 = next
			local children, v10 = game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren()

			for _, v11 in v9, children, v10 do
				if v11.Name == "NotificationTemplate" and v11.TranslateMe.Text == arg then
					return true
				end
			end
		end

		ToggleAutoGetFullyCyborg = RaceNormalSection.CreateToggle({
			Title = "Auto Get Fully Cyborg",
			Desc = nil,
			Default = Settings["Auto Get Fully Cyborg"] or false,
		}, function(arg)
			SaveSettings("Auto Get Fully Cyborg", arg)

			if arg and not Settings["Auto Get Cyborg"] then
				VxezeNotify("Race Cyborg", "Turn On Auto Get Cyborg plz", "warning")
			end
		end)

		RaceNormalSection.CreateToggle({
			Title = "Auto Get Cyborg Hop Collect Chest",
			Desc = nil,
			Default = Settings["Auto Get Cyborg Hop Collect Chest"] or false,
		}, function(arg)
			SaveSettings("Auto Get Cyborg Hop Collect Chest", arg)
		end)

		GetCyborg = function()
			if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Check") == 2 then
				VxezeNotify("Race Upgrade", "Plz Turn Off", "warning")
				wait(5)
				return
			end

			if not GoToSea(2) then
				return
			end

			if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Check") then
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
				return
			end

			if not flag3 and not DetectItemPlr("Core Brain") then
				while true do
					wait(1)
					fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
					if not (DetectkeyCyborg("{color1_Green}Please supply a {item1} to continue.{color1_/}") or DetectkeyCyborg("{color1_Red}Microchip not found.{color1_/}")) then
						continue
					end
					break
				end

				if DetectkeyCyborg("{color1_Red}Microchip not found.{color1_/}") then
					flag2 = false
				elseif DetectkeyCyborg("{color1_Green}Please supply a {item1} to continue.{color1_/}") then
					flag2 = true
				end

				flag3 = true
			end

			if Settings["Auto Get Fully Cyborg"] and not CheckNameBoss("Order") and not flag2 then
				if not DetectItemPlr("Fist of Darkness") then
					if n >= 20 and Settings["Auto Get Cyborg Hop Collect Chest"] then
						if not getgenv().DelayHop then
							task.delay(5, function()
								getgenv().DelayHop = true

								spawn(function()
									HopLessAll()
								end)

								spawn(function()
									HopServer()
								end)

								getgenv().DelayHop = false
							end)
						end

						return
					end

					local v9 = GetNearestChest()

					if v9 then
						n += 1
						local now = nil

						while true do
							task.wait()

							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v9.Position).Magnitude <= 5 then
								if not now then
									now = tick()
								elseif tick() - now >= 5 then
									Instance.new("IntValue", v9).Name = "Ignored"
									wait(0.5)
								end

								pcall(function()
									game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
								end)

								wait()

								pcall(function()
									game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
								end)

								TweenManager.CancelCurrent()
							end

							ToTarget(v9.CFrame, true)
							if not (not v9 or not v9.Parent or not Settings["Auto Get Cyborg"] or v9:GetAttribute("IsDisabled") or v9:FindFirstChild("Ignored") or not v9:FindFirstChild("TouchInterest")) then
								continue
							end
							break
						end
					else
						local v10 = PathFindChest()

						if v10 then
							ToTarget(v10.Part.CFrame)

							if localPlayer:DistanceFromCharacter(v10.Part.Position) <= 100 or GetNearestChest() then
								Instance.new("IntValue", v10).Name = "Ignored"
							end
						else
							for _, child in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
								if child:FindFirstChild("Ignored") then
									child:FindFirstChild("Ignored"):Destroy()
								end
							end
						end
					end
				else
					wait(1)

					repeat
						wait()
						fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
					until not DetectItemPlr("Fist of Darkness")

					wait(0.5)
					ToggleAutoGetFullyCyborg:SetStage(false)
					flag2 = true
				end

				return
			end

			if flag2 then
				if DetectItemPlr("Core Brain") then
					fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
					return
				end
				local Order = CheckNameBoss("Order")

				if Order then
					while true do
						task.wait()
						SizePart(Order)
						UsedualFlock()
						ClickM1(Order)

						if Settings["Select Weapon"] == "Blox Fruit" then
							ToTarget(Order.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							ToTarget(Order.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end

						if not (not IsMobAlive(Order) or not Settings["Auto Get Cyborg"]) then
							continue
						end
						break
					end
				elseif not DetectItemPlr("Microchip") and game.Players.LocalPlayer.Data.Fragments.Value >= 1000 then
					BuyChipLaw()
					wait(2)
				elseif DetectItemPlr("Microchip") then
					fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
				end
			end
		end
	end

	RaceNormalSection.CreateToggle({ Title = "Auto Get Cyborg", Desc = nil, Default = Settings["Auto Get Cyborg"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Get Cyborg"] and wait(0.1) do
					local ok, result = pcall(function()
						GetCyborg()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Get Cyborg", arg)
	end)

	GetRaceGhoul = function()
		if not GoToSea(2) then
			return
		end

		if game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "BuyCheck", 4, true) == 2 or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4, true) == 1 then
			VxezeNotify("Race Upgrade", "Plz Turn Off", "warning")
			wait(5)
			return
		end

		if not CheckCountItem("Ectoplasm", 100) then
			local tbl15 = { "Ship Deckhand", "Ship Steward", "Ship Officer", "Ship Engineer" }
			local v9 = DetectMob(tbl15)

			if v9 then
				while true do
					task.wait()
					SizePart(v9)
					BringMob(v9)
					UsedualFlock()
					ClickM1(v9)

					if Settings["Select Weapon"] == "Blox Fruit" then
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end

					if not (not IsMobAlive(v9) or not Settings["Auto Get Ghoul"]) then
						continue
					end
					break
				end
			elseif typeof(tbl15) == "table" then
				if #tbl5 >= #tbl15 then
					tbl5 = {}
					return
				end
				local v10 = DetectPartSpawnMob(DetectNameTablePart(tbl15))

				if v10 then
					table.insert(tbl5, DetectNameTablePart(tbl15))

					while true do
						wait()
						ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
						if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl15) or not Settings["Auto Get Ghoul"]) then
							continue
						end
						break
					end

					wait(1)
				end
			else
				local v10 = DetectPartSpawnMob(tbl15, true)

				if v10 then
					Instance.new("IntValue", v10).Name = "Ignored"

					while true do
						wait()
						ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
						if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl15) or not Settings["Auto Get Ghoul"]) then
							continue
						end
						break
					end

					wait(1)
				else
					DeleteIgnoredMobSpawn()
				end
			end

			return
		end

		if DetectItemPlr("Hellfire Torch") then
			local position = localPlayer.Character.HumanoidRootPart.Position

			if (CFrame.new(918.615234, 122.202454, 33454.3789, -0.999998808, 0, 0.00172644004, 0, 1, 0, -0.00172644004, 0, -0.999998808).Position - position).Magnitude <= 8 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "Ectoplasm", "BuyCheck", 4 }))
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 4)
			else
				ToTarget(CFrame.new(918.615234, 122.202454, 33454.3789, -0.999998808, 0, 0.00172644004, 0, 1, 0, -0.00172644004, 0, -0.999998808))
			end
		else
			local v9 = CheckNameBoss("Cursed Captain")

			if v9 then
				while true do
					task.wait()
					SizePart(v9)
					UsedualFlock()
					ClickM1(v9)

					if Settings["Select Weapon"] == "Blox Fruit" then
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end

					if not (not IsMobAlive(v9) or not Settings["Auto Get Ghoul"]) then
						continue
					end
					break
				end

				wait(5)
			else
				if Settings["Hop Server Get Ghoul"] then
					SpecialHop("Cursed Captain")
				end

				VxezeNotify("Boss Spawn", "Wating Boss Spawn", "warning")
				wait(5)
			end
		end
	end

	RaceNormalSection.CreateToggle({
		Title = "Hop Server Find Boss Cursed Captain",
		Desc = nil,
		Default = Settings["Hop Server Get Ghoul"] or false,
	}, function(arg)
		SaveSettings("Hop Server Get Ghoul", arg)
	end)

	RaceNormalSection.CreateToggle({ Title = "Auto Get Ghoul", Desc = nil, Default = Settings["Auto Get Ghoul"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Get Ghoul"] and wait(0.1) do
					local ok, result = pcall(function()
						GetRaceGhoul()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Get Ghoul", arg)
	end)

	RaceV4Section = RaceMain.CreateSection("Race V4")

	RaceV4Section.CreateToggle({ Title = "No Frog", Desc = nil, Default = Settings["No Frog"] or false }, function(arg)
		if arg then
			local lighting = game.Lighting
			lighting.FogEnd = 100000

			for _, descendant in pairs(lighting:GetDescendants()) do
				if descendant:IsA("Atmosphere") then
					descendant:Destroy()
				end
			end
		end

		SaveSettings("No Frog", arg)
	end)

	RaceV4Section.CreateToggle({
		Title = "Teleport Acient Clock",
		Desc = nil,
		Default = Settings["Teleport Acient Clock"] or false,
	}, function(arg)
		SaveSettings("Teleport Acient Clock", arg)

		if arg then
			task.spawn(function()
				while Settings["Teleport Acient Clock"] and task.wait(0.2) do
					local ok, result = pcall(function()
						local v9 = TeleportTempleOfTime()

						if v9 == "locked" then
							VxezeNotify("Temple of Time", "Temple of Time is locked", "warning")
							task.wait(5)
						elseif v9 == "arrived" then
							local templeOfTime = workspace.Map:FindFirstChild("Temple of Time")
							templeOfTime = templeOfTime and templeOfTime:FindFirstChild("Prompt")

							if templeOfTime then
								ToTarget(templeOfTime.CFrame)
							end
						end
					end)

					if not ok then
						PrintOnce(result)
					end
				end
			end)
		end
	end)

	RaceV4Section.CreateButton({ Title = "Teleport Temple of Time" }, function()
		if TempleTeleporting then
			TempleTeleporting = false
			return
		end
		TempleTeleporting = true

		task.spawn(function()
			local now = tick()

			while true do
				if TempleTeleporting and tick() - now < 120 then
					local ok, result = pcall(TeleportTempleOfTime)

					if ok and result == "locked" then
						VxezeNotify("Temple of Time", "Temple of Time is locked", "warning")
						break
					elseif not (ok and result == "arrived") then
						task.wait(0.2)
						continue
					end
				end

				break
			end

			TempleTeleporting = false
			TweenManager.CancelCurrent()
		end)
	end)

	BuyGearV4 = function()
		if string.find(CheckAcientOneStatus(), "Can Buy Gear") then
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
			ResetRaceStatus()
		end
	end

	do
		local cframe = CFrame.new(28576.4688, 14935.9512, 75.469101, -1, -4.22219593e-08, 1.13133396e-08, 0, -0.258819044, -0.965925813, 4.37113883e-08, -0.965925813, 0.258819044)
		local n = 0.2

		GetBlueGear = function()
			if game.workspace.Map:FindFirstChild("MysticIsland") then
				for _, child in pairs(game.workspace.Map.MysticIsland:GetChildren()) do
					if child:IsA("MeshPart") and child.MeshId == "rbxassetid://10153114969" then
						return child
					end
				end
			end
		end

		GetHighestPoint = function()
			if not game.workspace.Map:FindFirstChild("MysticIsland") then
				return nil
			end

			for _, descendant in pairs(game:GetService("Workspace").Map.MysticIsland:GetDescendants()) do
				if descendant:IsA("MeshPart") then
					if descendant.MeshId == "rbxassetid://6745037796" then
						return descendant
					end
				end
			end
		end

		local tbl15 = { "Last Resort", "Agility", "Water Body", "Heavenly Blood", "Energy Core", "Heightened Senses" }

		CheckAbility = function()
			local v9 = next
			local children, v10 = game.Players.LocalPlayer.Backpack:GetChildren()

			for _, v11 in v9, children, v10 do
				if table.find(tbl15, v11.Name) then
					return true
				end
			end

			local v11 = next
			local children2, v12 = game.Players.LocalPlayer.Character:GetChildren()

			for _, v13 in v11, children2, v12 do
				if table.find(tbl15, v13.Name) then
					return true
				end
			end
		end

		CollectBlueGear = function()
			if not GetHighestPoint() then
				local v9 = DetectNpc("Advanced Fruit Dealer")
				if v9 then
					ToTarget(v9.HumanoidRootPart.CFrame)
					return
				end
			end

			local v9 = GetBlueGear()

			if v9 and not v9.CanCollide and v9.Transparency ~= 1 then
				if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
					game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
				end

				ToTarget(GetBlueGear().CFrame)
			elseif v9 and v9.Transparency == 1 then
				local flag2 = GetHighestPoint()

				if flag2 then
					local position = localPlayer.Character.HumanoidRootPart.Position
					flag2 = (GetHighestPoint().CFrame * CFrame.new(0, 211.88, 0).Position - position).Magnitude > 10
				end

				if flag2 then
					ToTarget(GetHighestPoint().CFrame * CFrame.new(0, 211.88, 0))
				else
					game.Players.LocalPlayer.CameraMode = "LockFirstPerson"
					game.Players.LocalPlayer.CameraMode = "Classic"
					local now = tick()

					repeat
						wait()
						local currentCamera = game:GetService("Workspace").CurrentCamera
						local cframe2 = CFrame.new
						local position = game:GetService("Workspace").CurrentCamera.CFrame.Position
						local Lighting = game:GetService("Lighting")
						local v10 = game
						currentCamera.CFrame = cframe2(position, Lighting:GetMoonDirection() + v10:GetService("Workspace").CurrentCamera.CFrame.Position)
					until tick() - now >= 3

					pcall(function()
						game:GetService("VirtualInputManager"):SendKeyEvent(true, "T", false, game)
					end)

					task.wait(0.5)

					pcall(function()
						game:GetService("VirtualInputManager"):SendKeyEvent(false, "T", false, game)
					end)

					if not CheckAbility() and not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
						local clone = game:GetService("ReplicatedStorage").FX.Agility:Clone()
						clone.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
						clone.Enabled = false
					end

					task.wait(1.5)
				end
			end
		end

		PullLeverV4 = function()
			if not CheckItemInventory("Valkyrie Helm") or not CheckItemInventory("Mirror Fractal") then
				VxezeNotify("Race V4", "Not Valkyrie Helm or not Mirror Fractal", "warning")
				wait(5)
				return
			end

			if not game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("CheckTempleDoor") then
				local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Check")
				if response == 1 then
					game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Begin")
					return
				end

				if response == 2 then
					local v9 = TempleProgress
					local v10 = TempleProgress
					local now = tick()
					v9.value = 2
					v10.checked = now
					TeleportTempleOfTime()
					return
				end

				if response == 3 then
					game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Continue")
					return
				end

				if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") and CheckClockTime() == "Night" then
					CollectBlueGear()
				elseif game:GetService("Workspace").Map:FindFirstChild("MysticIsland") and CheckClockTime() ~= "Night" then
					if not GetHighestPoint() then
						local v9 = DetectNpc("Advanced Fruit Dealer")
						if v9 then
							ToTarget(v9.HumanoidRootPart.CFrame)
							return
						end
					end

					local v9 = GetHighestPoint()
					local flag2

					if v9 then
						local position = localPlayer.Character.HumanoidRootPart.Position
						flag2 = (GetHighestPoint().CFrame * CFrame.new(0, 211.88, 0).Position - position).Magnitude > 10
					else
						flag2 = v9
					end

					if flag2 then
						ToTarget(GetHighestPoint().CFrame * CFrame.new(0, 211.88, 0))
					end
				elseif not game:GetService("Workspace").Map:FindFirstChild("MysticIsland") and Settings["Hop Server [Trial Or Pull Lever]"] then
					SpecialHop("Mirage")
				end
			else
				if not IsInTempleOfTime() then
					TeleportTempleOfTime()
					return
				end
				BorrowTempleOfTime()
				local v9 = GetTempleOfTime()
				if not v9 then
					return
				end

				if v9.Lever.Lever.CFrame.Z > cframe.Z + n or v9.Lever.Lever.CFrame.Z < cframe.Z - n then
					if localPlayer:DistanceFromCharacter(v9.Lever.Part.Position) > 10 then
						ToTarget(v9.Lever.Part.CFrame)
					else
						fireproximityprompt(v9.Lever.Prompt.ProximityPrompt, 1)
					end
				else
					VxezeNotify("Temple of Time", "Done Pull Lever", "success")
					wait(5)
				end
			end
		end

		RaceV4Section.CreateToggle({ Title = "Auto Buy Gear", Desc = nil, Default = Settings["Auto Buy Gear"] or false }, function(arg)
			if arg and not Place_Id.sea3() then
				SaveSettings("Auto Buy Gear", false)
				VxezeNotify("Auto Buy Gear", "Only works in Sea 3", "warning", { Key = "gateAuto Buy Gear" })

				if getgenv().ToggleAutoChooseGears then
				end

				return
			end

			if arg then
				spawn(function()
					while Settings["Auto Buy Gear"] and wait(0.2) do
						pcall(function()
							BuyGearV4()
						end)
					end
				end)
			end

			SaveSettings("Auto Buy Gear", arg)
		end)

		RaceV4Section.CreateDropdown({
			Title = "Select Gear V4",
			List = { "Alpha", "Omega" },
			Search = false,
			Selected = false,
			Default = Settings["Select Gear V4"] or "Omega",
		}, function(arg)
			SaveSettings("Select Gear V4", arg)
		end)

		getgenv().ToggleAutoChooseGears = RaceV4Section.CreateToggle({ Title = "Auto Choose Gears", Desc = nil, Default = Settings["Auto Choose Gears"] or false }, function(arg)
			if arg and not Place_Id.sea3() then
				SaveSettings("Auto Choose Gears", false)
				VxezeNotify("Auto Choose Gears", "Only works in Sea 3", "warning", { Key = "gateAuto Choose Gears" })

				if getgenv().ToggleAutoChooseGears then
					getgenv().ToggleAutoChooseGears:SetStage(false)
				end

				return
			end

			if arg then
				spawn(function()
					while Settings["Auto Choose Gears"] and wait(0.3) do
						local ok, result = pcall(function()
							ChooseGearV4()
						end)

						if result then
							PrintOnce(result)
						end
					end
				end)
			end

			SaveSettings("Auto Choose Gears", arg)
		end)

		RaceV4Section.CreateToggle({
			Title = "Auto Finish Train Quest",
			Desc = nil,
			Default = Settings["Auto Finish Train Quest"] or false,
		}, function(arg)
			if arg and not Place_Id.sea3() then
				SaveSettings("Auto Finish Train Quest", false)
				VxezeNotify("Auto Finish Train Quest", "Only works in Sea 3", "warning", { Key = "gateAuto Finish Train Quest" })

				if getgenv().ToggleAutoChooseGears then
				end

				return
			end

			if arg then
				spawn(function()
					while Settings["Auto Finish Train Quest"] and task.wait(0.1) do
						local ok, result = pcall(function()
							if Settings["Stack Train With Trial Race"] and not CheckGoTrain() then
								return
							end
							TurnOnV4()
							BuyGearV4()
							local v9 = DetectMob(tbl8)

							if v9 then
								while true do
									task.wait()
									SizePart(v9)
									BringMob(v9)
									UsedualFlock()
									ClickM1(v9)

									if Settings["Select Weapon"] == "Blox Fruit" then
										ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end

									if not (not IsMobAlive(v9) or not Settings["Auto Finish Train Quest"] or not CheckGoTrain()) then
										continue
									end
									break
								end
							elseif typeof(tbl8) == "table" then
								if #tbl5 >= #tbl8 then
									tbl5 = {}
									return
								end
								local v10 = DetectPartSpawnMob(DetectNameTablePart(tbl8))

								if v10 then
									table.insert(tbl5, DetectNameTablePart(tbl8))

									while true do
										wait()
										ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
										if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl8) or not Settings["Auto Finish Train Quest"] or not CheckGoTrain()) then
											continue
										end
										break
									end

									wait(1)
								end
							else
								local v10 = DetectPartSpawnMob(tbl8, true)

								if v10 then
									Instance.new("IntValue", v10).Name = "Ignored"

									while true do
										wait()
										ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
										if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl8) or not Settings["Auto Finish Train Quest"] or not CheckGoTrain()) then
											continue
										end
										break
									end

									wait(1)
								else
									DeleteIgnoredMobSpawn()
								end
							end
						end)

						if result then
							PrintOnce(result)
						end
					end
				end)
			end

			SaveSettings("Auto Finish Train Quest", arg)
		end)

		RaceV4Section.CreateToggle({
			Title = "Stack Train With Trial Race",
			Desc = nil,
			Default = Settings["Stack Train With Trial Race"] or false,
		}, function(arg)
			SaveSettings("Stack Train With Trial Race", arg)
		end)

		getgenv().TurnOffHOPSVPullAndTrial = RaceV4Section.CreateToggle({
			Title = "Hop Server [Trial Or Pull Lever]",
			Desc = nil,
			Default = Settings["Hop Server [Trial Or Pull Lever]"] or false,
		}, function(arg)
			SaveSettings("Hop Server [Trial Or Pull Lever]", arg)
		end)

		RaceV4Section.CreateToggle({ Title = "Auto Pull Lever", Desc = nil, Default = Settings["Auto Pull Lever"] or false }, function(arg)
			if arg then
				spawn(function()
					while Settings["Auto Pull Lever"] and wait(0.1) do
						pcall(function()
							PullLeverV4()
						end)
					end
				end)
			end

			SaveSettings("Auto Pull Lever", arg)
		end)

		DetectNameMulti = function(arg)
			local tbl16 = {}

			if Settings["Select Players Multi"] and not arg then
				for k, v9 in next, Settings["Select Players Multi"], nil do
					if v9 then
						tbl16[k] = true
					end
				end
			end

			local v9 = pairs
			local Players2 = game:GetService("Players")

			for _, child in v9(Players2:GetChildren()) do
				if child.Name ~= localPlayer.Name and not table.find(tbl16, child.Name) then
					tbl16[child.Name] = false
				end
			end

			return tbl16
		end

		local createDropdown = RaceV4Section.CreateDropdown
		local selectPlayersMulti = Settings["Select Players Multi"]

		DropdownSelectPlayerMulti = createDropdown({
			Title = "Select Players Multi",
			List = PrepareMultiSelectList(DetectNameMulti(), selectPlayersMulti),
			Search = true,
			Selected = true,
			Default = Settings["Select Players Multi"] or nil,
		}, function(arg, arg2)
			SaveSettings("Select Players Multi", arg, arg2)
		end)

		RaceV4Section.CreateButton({ Title = "Refresh Player" }, function()
			DropdownSelectPlayerMulti:GetNewList(DetectNameMulti(true))
		end)

		RaceV4Section.CreateToggle({ Title = "Multi Trial", Desc = nil, Default = Settings["Multi Trial"] or false }, function(arg)
			SaveSettings("Multi Trial", arg)
		end)

		RaceV4Section.CreateToggle({
			Title = "Auto Reset Character",
			Desc = nil,
			Default = Settings["Auto Reset Character"] or false,
		}, function(arg)
			SaveSettings("Auto Reset Character", arg)
		end)

		ToggleAutoTrial = RaceV4Section.CreateToggle({ Title = "Auto Trial", Desc = nil, Default = Settings["Auto Trial"] or false }, function(arg)
			SaveSettings("Auto Trial", arg)
		end)

		RaceV4Section.CreateToggle({
			Title = "Auto Turn On V3 Near Door",
			Desc = "will auto turn on race \nif have players near door",
			Default = Settings["Auto Turn On V3 Near Door"] or false,
		}, function(arg)
			SaveSettings("Auto Turn On V3 Near Door", arg)
		end)

		KillTrialSection = RaceMain.CreateSection("Kill Trial")

		KillTrialSection.CreateDropdown({
			Title = "Select Weapon Attack Trial",
			List = { "Melee", "Sword", "Gun", "Blox Fruit" },
			Search = true,
			Selected = false,
			Default = Settings["Select Weapon Attack Trial"] or nil,
		}, function(arg)
			SaveSettings("Select Weapon Attack Trial", arg)
		end)

		KillTrialSection.CreateToggle({
			Title = "Kill players When complete Trial",
			Desc = "Turn on before Start Attack and Turn on Auto Trial",
			Default = Settings["Kill players When complete Trial"] or false,
		}, function(arg)
			SaveSettings("Kill players When complete Trial", arg)
		end)

		KillTrialSection.CreateToggle({
			Title = "Use Skill when Kill Player",
			Desc = nil,
			Default = Settings["Use Skill when Kill Player"] or false,
		}, function(arg)
			SaveSettings("Use Skill when Kill Player", arg)
		end)

		KillTrialSection.CreateToggle({
			Title = "Just Use Skill when Player Active Ken",
			Desc = nil,
			Default = Settings["Just Use Skill when Player Active Ken"] or false,
		}, function(arg)
			SaveSettings("Just Use Skill when Player Active Ken", arg)
		end)

		DetectNameAbility = function(arg)
			local v9 = next
			local children, v10 = arg:GetChildren()

			for _, v11 in v9, children, v10 do
				if table.find(tbl15, v11.Name) then
					return true
				end
			end
		end
	end

	GetOtherPlayerRaces = function()
		local tbl15 = {}
		local v9 = pairs
		local Players2 = game:GetService("Players")

		for _, child in v9(Players2:GetChildren()) do
			if child.Name ~= localPlayer.Name then
				tbl15[child.Name] = child.Data.Race.Value
			end
		end

		return tbl15
	end

	CheckMultiPlayerNearDoor = function()
		local v9 = next
		local children, v10 = game.Workspace.Characters:GetChildren()
		local n = 0

		for _, v11 in v9, children, v10 do
			local name_ = v11.Name
			local v12 = GetOtherPlayerRaces()[name_]

			if v12 and DetectNameAbility(v11.HumanoidRootPart) and (v11.HumanoidRootPart.Position - game:GetService("Workspace").Map["Temple of Time"][v12 .. "Corridor"].Door.Door.RightDoor.Union.Position).Magnitude < 100 then
				n += 1
			end
		end

		if n >= 2 then
			return true
		end
	end

	CheckMultiAccount = function()
		local tbl15 = {}
		local v9 = pairs
		local Players2 = game:GetService("Players")

		for _, child in v9(Players2:GetChildren()) do
			if Settings["Select Players Multi"] and Settings["Select Players Multi"][child.Name] then
				tbl15[child.Name] = child.Data.Race.Value
			end
		end

		return tbl15
	end

	CheckMultiTeleDoor = function()
		local v9 = next
		local children, v10 = game.Workspace.Characters:GetChildren()
		local n = 0

		for _, v11 in v9, children, v10 do
			local name_ = v11.Name
			local v12 = CheckMultiAccount()[name_]

			if v12 and (v11.HumanoidRootPart.Position - game:GetService("Workspace").Map["Temple of Time"][v12 .. "Corridor"].Door.Door.RightDoor.Union.Position).Magnitude < 100 then
				n += 1
			end
		end

		if n >= 2 then
			return true
		end
	end

	TrialHuman = function()
		if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Strength") then
			StrengthPart = game:GetService("Workspace")._WorldOrigin.Locations["Trial of Strength"]

			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - StrengthPart.Position).Magnitude <= 1000 then
				for _, child in pairs(game.Workspace.Enemies:GetChildren()) do
					if IsMobAlive(child) and (child.HumanoidRootPart.Position - StrengthPart.Position).Magnitude <= 1000 then
						return child
					end
				end
			end
		end
	end

	TrialGhoul = function()
		if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Carnage") then
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")._WorldOrigin.Locations["Trial of Carnage"].Position).Magnitude <= 1000 then
				for _, child in pairs(game.Workspace.Enemies:GetChildren()) do
					if IsMobAlive(child) and (child.HumanoidRootPart.Position - game:GetService("Workspace")._WorldOrigin.Locations["Trial of Carnage"].Position).Magnitude <= 1000 then
						return child
					end
				end
			end
		end
	end

	GetSeaBeastTrial = function()
		if not game.Workspace.Map:FindFirstChild("FishmanTrial") then
			return
		end
		local trialOfWater

		if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water") then
			trialOfWater = game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water")
		else
			trialOfWater = nil
		end

		if trialOfWater then
			local v9 = next
			local children, v10 = game:GetService("Workspace").SeaBeasts:GetChildren()

			for _, v11 in v9, children, v10 do
				if string.find(v11.Name, "SeaBeast") and v11:FindFirstChild("HumanoidRootPart") and (v11.HumanoidRootPart.Position - trialOfWater.Position).Magnitude <= 1500 then
					if v11.Health.Value > 0 then
						return v11
					end
				end
			end
		end
	end

	getgenv().TrialDone = false
	getgenv().KillAuraDone = false

	TeleportSeabeast2 = function(arg)
		if (Vector3.new(0, arg:FindFirstChild("HumanoidRootPart").Position.Y, 0) - Vector3.new(0, -60, 0)).Magnitude <= 175 then
			ToTarget(arg.HumanoidRootPart.CFrame * CFrame.new(0, 200, 50))
		else
			ToTarget(CFrame.new(arg.HumanoidRootPart.Position.X, 140, arg.HumanoidRootPart.Position.Z))
		end
	end

	getgenv().PlayerKillTrial = {}
	getgenv().BlackListPlayerTrial = {}

	CheckCDSkill = function(arg)
		if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills:FindFirstChild(arg) then
			EquipTool(arg)
			return
		end
		local v9 = next
		local children, v10 = game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills[arg]:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11:IsA("Frame") then
				if v11.Name ~= "Template" and v11.Title.TextColor3 == Color3.new(1, 1, 1) and v11.Cooldown.Size == UDim2.new(0, 0, 1, -1) or v11.Cooldown.Size == UDim2.new(1, 0, 1, -1) then
					return v11
				end
			end
		end
	end

	VerifyNearbyTrial = function()
		local tbl15 = {
			"Trial of the Machine",
			"Trial of Speed",
			"Trial of Strength",
			"Trial of Water",
			"Trial of the King",
			"Trial of Carnage",
			"Trial of Flames",
		}

		local v9 = next
		local children, v10 = workspace._WorldOrigin.Locations:GetChildren()

		for _, v11 in v9, children, v10 do
			if table.find(tbl15, v11.Name) and localPlayer:DistanceFromCharacter(v11.Position) < 1500 then
				return true
			end
		end
	end

	AutoTrialV4 = function()
		if Settings["Auto Finish Train Quest"] and Settings["Stack Train With Trial Race"] and CheckGoTrain() then
			return
		end
		local clockTime = game.Lighting.ClockTime
		local flag2 = CheckMoon() == "Full Moon"

		if flag2 then
			flag2 = not (clockTime > 5 and clockTime < 12)
		end

		if (flag2 or CheckMoon() == "Next Night") and Settings["Hop Server [Trial Or Pull Lever]"] then
			if getgenv().TurnOffHOPSVPullAndTrial then
				getgenv().TurnOffHOPSVPullAndTrial:SetStage(false)
			end

			task.wait(3)
		elseif Settings["Hop Server [Trial Or Pull Lever]"] then
			HopServer()
			return
		end

		if not IsInTempleOfTime() and not VerifyNearbyTrial() then
			if TeleportTempleOfTime() == "locked" then
				VxezeNotify("Temple of Time", "Temple of Time is locked", "warning")
				task.wait(5)
			end

			return
		end

		local v9 = GetTempleOfTime()

		if v9 and v9.FFABorder:FindFirstChild("Forcefield") and v9.FFABorder.Forcefield.Transparency == 1 or VerifyNearbyTrial() then
			if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
				if VerifyNearbyTrial() and not getgenv().VerifyTrial then
					getgenv().VerifyTrial = true
				end

				while true do
					wait()
					if not (VerifyNearbyTrial() or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible) then
						continue
					end
					break
				end

				local value = game.Players.LocalPlayer.Data.Race.Value

				if value == "Human" then
					while true do
						task.wait()
						local v10 = TrialHuman()

						if v10 then
							while true do
								task.wait()
								SizePart(v10)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								ClickM1(v10)
								UsedualFlock()
								if not (not IsMobAlive(v10) or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")._WorldOrigin.Locations["Trial of Strength"].Position).Magnitude > 1000) then
									continue
								end
								break
							end
						end

						if not (not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")._WorldOrigin.Locations["Trial of Strength"].Position).Magnitude > 1000) then
							continue
						end
						break
					end
				elseif value == "Skypiea" then
					while true do
						task.wait()

						if game:GetService("Workspace")._WorldOrigin.Locations["Trial of the King"] and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")._WorldOrigin.Locations["Trial of the King"].CFrame.Position).Magnitude <= 1000 then
							ToTarget(game:GetService("Workspace").Map.SkyTrial.Model.FinishPart.CFrame)
							task.wait(3)
						end

						if not (not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible or workspace.Map:FindFirstChild("Temple of Time") and workspace.Map["Temple of Time"].FFABorder.Forcefield.Transparency == 0 or localPlayer:DistanceFromCharacter(game:GetService("Workspace").Map.SkyTrial.Model.FinishPart.Position) > 1000) then
							continue
						end
						break
					end
				elseif value == "Fishman" then
					local trialOfWater

					if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water") then
						trialOfWater = game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water")
					else
						trialOfWater = nil
					end

					if trialOfWater and localPlayer:DistanceFromCharacter(trialOfWater.Position) < 1500 then
						local v10 = GetSeaBeastTrial()

						while true do
							task.wait()

							if v10 then
								local humanoidRootPart = v10:FindFirstChild("HumanoidRootPart")
								getgenv().AimPos = CFrame.new(humanoidRootPart.Position.X, 40, humanoidRootPart.Position.Z)
								TeleportSeabeast2(v10)

								if localPlayer:DistanceFromCharacter(humanoidRootPart.Position) < 400 then
									AutoAllSkill()
								end
							end

							if not (not v10 or not v10.Parent or v10.Health.Value == 0 or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible or workspace.Map:FindFirstChild("Temple of Time") and workspace.Map["Temple of Time"].FFABorder.Forcefield.Transparency == 0 or localPlayer:DistanceFromCharacter(game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water").Position) > 1000) then
								continue
							end
							break
						end
					end
				elseif value == "Mink" then
					while true do
						task.wait()

						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")._WorldOrigin.Locations["Trial of Speed"].Position).Magnitude <= 1000 then
							ToTarget(game:GetService("Workspace").StartPoint.CFrame * CFrame.new(0, 2, 0))
						end

						if not (not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible or localPlayer:DistanceFromCharacter(game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Speed").Position) > 1000) then
							continue
						end
						break
					end
				elseif value == "Ghoul" then
					while true do
						task.wait()
						local v10 = TrialGhoul()

						if v10 then
							while true do
								task.wait()
								SizePart(v10)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								UsedualFlock()
								ClickM1(v10)
								if not (not IsMobAlive(v10) or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible or localPlayer:DistanceFromCharacter(game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Carnage").Position) > 1000) then
									continue
								end
								break
							end
						end

						if not (not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible or localPlayer:DistanceFromCharacter(game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Carnage").Position) > 1000) then
							continue
						end
						break
					end
				elseif value == "Cyborg" then
					repeat
						task.wait()
						ToTarget(CFrame.new(28282.5703125, 14896.8505859375, 105.10427093505859))
					until not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
				end
			else
				if not v9 then
					return
				end
				local union = v9[localPlayer.Data.Race.Value .. "Corridor"].Door.Door.RightDoor.Union

				if localPlayer:DistanceFromCharacter(union.Position) > 8 then
					ToTarget(union.CFrame)
				end

				if Settings["Multi Trial"] and CheckMultiTeleDoor() and localPlayer:DistanceFromCharacter(union.Position) <= 8 then
					pcall(function()
						game:service("VirtualInputManager"):SendKeyEvent(true, "T", false, game)
					end)

					task.wait()

					pcall(function()
						game:service("VirtualInputManager"):SendKeyEvent(false, "T", false, game)
					end)

					return
				end

				if Settings["Auto Turn On V3 Near Door"] and CheckMultiPlayerNearDoor() then
					pcall(function()
						game:service("VirtualInputManager"):SendKeyEvent(true, "T", false, game)
					end)

					task.wait()

					pcall(function()
						game:service("VirtualInputManager"):SendKeyEvent(false, "T", false, game)
					end)
				end
			end
		elseif getgenv().VerifyTrial then
			if not Settings["Multi Trial"] and not Settings["Auto Reset Character"] then
				Settings["Auto Trial"] = false
				ToggleAutoTrial:SetStage(false)
			end

			getgenv().VerifyTrial = false
		end
	end

	PlayerTrial = function()
		local forcefield = workspace.Map["Temple of Time"].FFABorder.Forcefield
		local position = forcefield.Position
		local size = forcefield.Size
		local v9 = pairs
		local v10 = workspace:FindPartsInRegion3(Region3.new(position - size / 2, position + size / 2), nil, math.huge)

		for _, v11 in v9(v10) do
			local parent = v11.Parent

			if parent and parent:FindFirstChild("Humanoid") then
				local playerFromCharacter = game.Players:GetPlayerFromCharacter(parent)
				if playerFromCharacter and playerFromCharacter.Name ~= localPlayer.Name and playerFromCharacter.Character.Humanoid.Health > 0 then
					return playerFromCharacter.Character
				end
			end
		end
	end

	local attributes = nil

	HasCooldownChanged = function(arg)
		local attributes2 = arg:GetAttributes()

		if not attributes then
			attributes = arg:GetAttributes()
		end

		for k, v9 in next, attributes2, nil do
			if (string.find(k, "GunCooldown") or string.find(k, "MeleeCooldown") or string.find(k, "SwordCooldown") or string.find(k, "BloxFruitCooldown")) and v9 > 0 then
				if attributes[k] ~= v9 then
					attributes = attributes2
					return true
				end
			end
		end

		return false
	end

	spawn(function()
		while task.wait(0.1) do
			pcall(function()
				if Settings["Kill players When complete Trial"] then
					local v9 = GetTempleOfTime()

					if v9 and v9.FFABorder.Forcefield.Transparency ~= 1 then
						if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
							local v10 = PlayerTrial()

							if v10 then
								while true do
									task.wait()

									task.spawn(function()
										if not game:GetService("Lighting").Blur.Enabled then
											pcall(function()
												game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
											end)

											task.wait()

											pcall(function()
												game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
											end)

											task.wait(3)
										end

										local cFrame = v10.HumanoidRootPart.CFrame
										getgenv().AimPos = cFrame
									end)

									if HasCooldownChanged(v10) then
										local now = tick()

										repeat
											task.wait()
											task.spawn(getgenv().AttackFunctionnhungSuperTrial)
											localPlayer.Character.HumanoidRootPart.CFrame = v10.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
										until tick() - now >= 0.75
									else
										localPlayer.Character.HumanoidRootPart.CFrame = v10.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
									end

									task.spawn(getgenv().AttackFunctionnhungSuperTrial)
									EquipTool(NameWeapon(Settings["Select Weapon Attack Trial"]))

									if Settings["Use Skill when Kill Player"] or Settings["Just Use Skill when Player Active Ken"] then
										if Settings["Just Use Skill when Player Active Ken"] and game.Players[v10.Name]:GetAttribute("KenActive") or not Settings["Just Use Skill when Player Active Ken"] then
											task.spawn(function()
												local v11 = CheckCDSkill(NameWeapon(Settings["Select Weapon Attack Trial"]))

												if v11 then
													pcall(function()
														game:GetService("VirtualInputManager"):SendKeyEvent(true, v11.Name, false, game)
													end)

													task.wait(0.05)

													pcall(function()
														game:GetService("VirtualInputManager"):SendKeyEvent(false, v11.Name, false, game)
													end)
												end
											end)
										end
									end

									if not (not v10 or not v10.Parent or v10.Humanoid.Health <= 0 or not Settings["Kill players When complete Trial"] or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible or localPlayer.Character.Humanoid.Health <= 0) then
										continue
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

	spawn(function()
		while task.wait(0.1) do
			if Settings["Auto Trial"] then
				local ok, result = pcall(function()
					AutoTrialV4()
				end)

				if result then
					print(ok, result)
				end
			end

			if Settings["Auto Reset Character"] then
				pcall(function()
					local v9 = GetTempleOfTime()

					if v9 and v9.FFABorder.Forcefield.Transparency ~= 1 then
						localPlayer.Character.Humanoid.Health = 0
					end
				end)
			end
		end
	end)

	GetItemsMain = Main.CreatePage({ Page_Name = "Get and Upgrade Items", Page_Title = "Get and Upgrade Items Tab" })
	GetItemsSection = GetItemsMain.CreateSection("Get Items")
	StatusBoneLabel = GetItemsSection.CreateLabel({ Title = "Status Bone : ..." })
	StatusLegendarySwordLabel = GetItemsSection.CreateLabel({ Title = "Status Legendary Sword : ..." })
	StatusHakiColorLabel = GetItemsSection.CreateLabel({ Title = "Status Haki Color : ..." })

	DealerReply = function(arg)
		if arg == nil or arg == false or arg == 0 then
			return false
		end
		local str2 = tostring(arg)
		local str3 = str2:gsub("%d+", ""):gsub("^[%p%s]+", ""):gsub("[%p%s]+$", "")
		return { name = str3 ~= "" and str3 or str2, number = str2:match("%d+") }
	end

	ReadLegendarySword = function()
		return DealerReply(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1"))
	end

	ReadHakiColor = function()
		return DealerReply(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", "1"))
	end

	DealerStatusText = function(arg, arg2)
		if arg2 == nil then
			return arg .. " : Checking..."
		end

		if arg2 then
			return arg .. " : 🟢 Spawned | " .. arg2.name .. (arg2.number and " | " .. arg2.number .. "s left" or "")
		end
		return arg .. " : 🔴 Not Spawned | Waiting for the next spawn"
	end

	BoneCount = function()
		for _, v9 in GetInventoryItems() do
			if v9.Name == "Bones" then
				return v9.Count or 0
			end
		end

		return 0
	end

	task.spawn(function()
		while task.wait(3) do
			local ok, result = pcall(function()
				if SeaOnlyNone(StatusBoneLabel, "Status Bone", { 3 }) then
					local v9 = BoneCount()
					StatusBoneLabel.SetText("Status Bone : " .. v9 .. " | " .. (v9 >= 50 and "🟢 Can Trade" or "🔴 Need " .. 50 - v9 .. " more Bones"))
				end

				if SeaOnly(StatusLegendarySwordLabel, "Status Legendary Sword", { 2 }) then
					StatusLegendarySwordLabel.SetText(DealerStatusText("Status Legendary Sword", PollStatus("LegendarySword", 20, ReadLegendarySword)))
				end

				if SeaOnly(StatusHakiColorLabel, "Status Haki Color", { 2, 3 }) then
					StatusHakiColorLabel.SetText(DealerStatusText("Status Haki Color", PollStatus("HakiColor", 20, ReadHakiColor)))
				end
			end)

			if not ok then
				VxezeReportError("Get Items status", result)
			end
		end
	end)

	GetItemsSection.CreateToggle({ Title = "Auto Trade Bone", Desc = nil, Default = Settings["Auto Trade Bone"] or false }, function(arg)
		SaveSettings("Auto Trade Bone", arg)
	end)

	getgenv().ToggleAutoBuyLegSword = GetItemsSection.CreateToggle({
		Title = "Auto Buy Legendary Sword",
		Desc = nil,
		Default = Settings["Auto Buy Legendary Sword"] or false,
	}, function(arg)
		SaveSettings("Auto Buy Legendary Sword", arg)
	end)

	GetItemsSection.CreateToggle({ Title = "Auto Buy Haki Color", Desc = nil, Default = Settings["Auto Buy Haki Color"] or false }, function(arg)
		SaveSettings("Auto Buy Haki Color", arg)
	end)

	GetItemsSection.CreateToggle({
		Title = "Hop Server [ Haki color or Legendary Sword]",
		Desc = nil,
		Default = Settings["Hop Server [ Haki color or Legendary Sword]"] or false,
	}, function(arg)
		SaveSettings("Hop Server [ Haki color or Legendary Sword]", arg)
	end)

	CheckSwordLegendary = function()
		for _, v9 in ipairs({ "Shisui", "Saddi", "Wando" }) do
			if not CheckItemInventory(v9) then
				return v9
			end
		end
	end

	local tbl15 = { "Stone", "Hydra Leader", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate" }

	DetectQuestRainBowHaki = function(arg)
		if not arg then
			for _, v9 in next, tbl15, nil do
				if HasQuest() and string.find(GetQuestTitle(), v9) then
					return false
				end
			end

			for _, v9 in next, tbl15, nil do
				if not string.find(GetQuestTitle(), v9) or not HasQuest() then
					return true
				end
			end
		else
			for _, v9 in next, tbl15, nil do
				if string.find(GetQuestTitle(), v9) then
					return v9
				end
			end
		end
	end

	GetRainBowHaki = function()
		if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("HornedMan") == 1 then
			SaveSettings("Auto Get Rainbow Haki", false)

			if getgenv().ToggleAutoRainbowHaki then
				getgenv().ToggleAutoRainbowHaki:SetStage(false)
			end

			VxezeNotify("Rainbow Haki", "Done Get Rainbow Haki", "success", { Key = "rainbowdone" })
			return
		end

		local hornedMan = workspace.NPCs:FindFirstChild("Horned Man") or game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Horned Man") or NPCManager.getNPCsByName("Horned Man")[1]._modelState._instance

		if DetectQuestRainBowHaki() then
			if not hornedMan or not hornedMan:FindFirstChild("HumanoidRootPart") then
				wait(1)
				return
			end

			if localPlayer:DistanceFromCharacter(hornedMan.HumanoidRootPart.Position) > 8 then
				ToTarget(hornedMan.HumanoidRootPart.CFrame)
			else
				wait(2)
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("HornedMan", "Bet")
			end
		else
			local v9 = CheckNameBoss(DetectQuestRainBowHaki(true))

			if v9 then
				while true do
					task.wait()
					SizePart(v9)

					if Settings["Select Weapon"] == "Blox Fruit" then
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end

					ClickM1(v9)
					UsedualFlock()
					if not (not IsMobAlive(v9) or not Settings["Auto Get Rainbow Haki"]) then
						continue
					end
					break
				end
			else
				VxezeNotify("Boss Spawn", "Waiting Boss Spawn", "warning")
				wait(5)
			end
		end
	end

	getgenv().ToggleAutoRainbowHaki = GetItemsSection.CreateToggle({
		Title = "Auto Get Rainbow Haki",
		Desc = nil,
		Default = Settings["Auto Get Rainbow Haki"] or false,
	}, function(arg)
		if arg and not Place_Id.sea3() then
			SaveSettings("Auto Get Rainbow Haki", false)
			VxezeNotify("Auto Get Rainbow Haki", "Only works in Sea 3", "warning", { Key = "gateAuto Get Rainbow Haki" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Get Rainbow Haki"] and task.wait(0.1) do
					local ok, result = pcall(function()
						GetRainBowHaki()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Get Rainbow Haki", arg)
	end)

	CountZombie = function(arg)
		local n = 0

		for _, child in pairs(game.workspace.Enemies:GetChildren()) do
			if child.Name == "Living Zombie" and child.Humanoid.Health > 0 then
				if not arg then
					n += 1
				end
			end
		end

		return n
	end

	BlankTablets = { "Segment6", "Segment2", "Segment8", "Segment9", "Segment5" }

	Trophy = {
		Segment1 = "Trophy1",
		Segment3 = "Trophy2",
		Segment4 = "Trophy3",
		Segment7 = "Trophy4",
		Segment10 = "Trophy5",
	}

	Pipes = {
		Part1 = "Really black",
		Part2 = "Really black",
		Part3 = "Dusty Rose",
		Part4 = "Storm blue",
		Part5 = "Really black",
		Part6 = "Parsley green",
		Part7 = "Really black",
		Part8 = "Dusty Rose",
		Part9 = "Really black",
		Part10 = "Storm blue",
	}

	DetectHighHealthMob = function(arg)
		local n = 0
		local v9 = nil

		for _, child in pairs(game.Workspace.Enemies:GetChildren()) do
			if (typeof(arg) == "table" and table.find(arg, child.Name) or child.Name == arg) and IsMobAlive(child) then
				local health = child.Humanoid.Health

				if n < health then
					n = health
					v9 = child
				end
			end
		end

		return v9
	end

	GuitarPuzzleProgress = function()
		if not CommF:InvokeServer("GuitarPuzzleProgress", "Check") then
			local flag2 = CheckMoon() == "Full Moon"
			local flag3

			if flag2 then
				flag3 = game.Lighting.ClockTime > 16 or game.Lighting.ClockTime < 5
			else
				flag3 = flag2
			end

			if flag3 then
				if localPlayer:DistanceFromCharacter(Vector3.new(-8654.314, 140.9499, 6167.5283)) > 50 then
					ToTarget(CFrame.new(-8654.314453125, 140.94990539550781, 6167.5283203125))
				end

				CommF:InvokeServer("gravestoneEvent", 2)
				CommF:InvokeServer("gravestoneEvent", 2, true)
				task.wait(1)
			else
				VxezeNotify("Full Moon", "Hop Full Moon", "travel")
				SpecialHop("FullMoon")
			end
		else
			if localPlayer.PlayerGui.Main.Dialogue.Visible then
				game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
				game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
			end

			if not CommF:InvokeServer("GuitarPuzzleProgress", "Check").Swamp then
				local position = localPlayer.Character.HumanoidRootPart.Position

				if (CFrame.new(-10171.7607421875, 138.62667846679688, 6008.0654296875).Position - position).Magnitude > 100 then
					ToTarget(CFrame.new(-10171.7607421875, 158.62667846679688, 6008.0654296875))
				elseif CountZombie() == 6 then
					while true do
						task.wait()
						DetectHighHealthMob("Living Zombie")

						while true do
							task.wait()
							local v9 = DetectHighHealthMob("Living Zombie")
							SizePart(v9)
							UsedualFlock()
							ClickM1(v9)

							if Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							if IsMobAlive(v9) then
								continue
							end
							break
						end

						if CountZombie() ~= 0 then
							continue
						end
						break
					end
				end

				return
			end

			if not CommF:InvokeServer("GuitarPuzzleProgress", "Check").Gravestones then
				if localPlayer:DistanceFromCharacter(Vector3.new(-8761.477, 142.10487, 6086.0786)) > 50 then
					ToTarget(CFrame.new(-8761.4765625, 142.10487365722656, 6086.07861328125))
				else
					for _, v9 in pairs({
						game.workspace.Map["Haunted Castle"].Placard1.Right.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard2.Right.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard3.Left.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard4.Right.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard5.Left.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard6.Left.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard7.Left.ClickDetector,
					}) do
						fireclickdetector(v9)
					end
				end
			elseif not CommF:InvokeServer("GuitarPuzzleProgress", "Check").Ghost then
				if localPlayer:DistanceFromCharacter(Vector3.new(-9755.659, 271.06613, 6290.6147)) > 50 then
					ToTarget(CFrame.new(-9755.6591796875, 271.06613159179688, 6290.61474609375))
				end

				CommF:InvokeServer("GuitarPuzzleProgress", "Ghost")
				task.wait(3)
			elseif not CommF:InvokeServer("GuitarPuzzleProgress", "Check").Trophies then
				if localPlayer:DistanceFromCharacter(Vector3.new(-9530.013, 6.1048536, 6054.8335)) > 50 then
					ToTarget(CFrame.new(-9530.0126953125, 6.104853630065918, 6054.83349609375))
				end

				local tablet = game.workspace.Map["Haunted Castle"].Tablet

				for _, v9 in pairs(BlankTablets) do
					local v10 = tablet[v9]

					if v10.Line.Position.X ~= -9707.86328125 then
						repeat
							task.wait()
							fireclickdetector(v10.ClickDetector)
						until v10.Line.Position.X == -9707.86328125
					end
				end

				for k, v9 in pairs(Trophy) do
					local v10 = tostring(game.workspace.Map["Haunted Castle"].Trophies.Quest[v9].Handle.CFrame):split(", ")[4]
					local str2

					if v10 == "1" or v10 == "-1" then
						str2 = "90"
					else
						str2 = "180"
					end

					if not string.find(tostring(tablet[k].Line.Rotation.Z), str2) then
						repeat
							task.wait()
							fireclickdetector(tablet[k].ClickDetector)
						until string.find(tostring(tablet[k].Line.Rotation.Z), str2)

						print(k, str2)
					end
				end
			elseif not CommF:InvokeServer("GuitarPuzzleProgress", "Check").Pipes then
				for k, v9 in pairs(Pipes) do
					local v10 = game.workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model[k]

					if v10.BrickColor.Name ~= v9 then
						repeat
							task.wait()
							fireclickdetector(v10.ClickDetector)
						until v10.BrickColor.Name == v9
					end
				end
			end
		end
	end

	DetectRequestSoulGuitar = function()
		local tbl16 = {}
		local str2, n

		if not CheckCountItem("Ectoplasm", 250) then
			tbl16 = { "Ship Deckhand", "Ship Steward", "Ship Officer", "Ship Engineer" }
			str2 = "TravelDressrosa"
			n = 2
		else
			str2 = nil
			n = nil

			if not CheckCountItem("Bones", 500) then
				tbl16 = { "Reborn Skeleton", "Demonic Soul", "Living Zombie", "Posessed Mummy" }
				str2 = "TravelZou"
				n = 3
			end
		end

		return tbl16, n, str2
	end

	AutoSoulGuitar = function()
		if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy", true) == "[You already own this item.]" then
			SaveSettings("Auto Soul Guitar", false)

			if getgenv().ToggleSoulGuitar then
				getgenv().ToggleSoulGuitar:SetStage(false)
			end

			VxezeNotify("Soul Guitar", "You already own Soul Guitar", "success", { Key = "soulguitardone" })
			return
		end

		if localPlayer.Data.Fragments.Value < 5000 then
			VxezeNotify("Shop", "Frag >= 5k", "warning")
			wait(5)
			return
		end

		if CheckCountItem("Dark Fragment", 1) and CheckCountItem("Ectoplasm", 250) and CheckCountItem("Bones", 500) then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy", true)
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy")

			if Place_Id.sea3() then
				GuitarPuzzleProgress()
			else
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
			end

			return
		end

		if not CheckCountItem("Dark Fragment", 1) then
			if Place_Id.sea2() then
				if CheckNameBoss("Darkbeard") then
					local Darkbeard = CheckNameBoss("Darkbeard")

					if Darkbeard then
						while true do
							task.wait()
							SizePart(Darkbeard)

							if Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(Darkbeard.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(Darkbeard.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							UsedualFlock()
							ClickM1(Darkbeard)
							if not (not IsMobAlive(Darkbeard) or not Settings["Auto Soul Guitar"]) then
								continue
							end
							break
						end
					end
				elseif localPlayer.Character:FindFirstChild("Fist of Darkness") or localPlayer.Backpack:FindFirstChild("Fist of Darkness") then
					local v9 = game
					local position = localPlayer.Character.HumanoidRootPart.Position

					if (v9:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.Position - position).Magnitude <= 5 then
						EquipTool("Fist of Darkness")
						firetouchinterest(game.Players.LocalPlayer.Character["Fist of Darkness"].Handle, game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection, 0)
						firetouchinterest(game.Players.LocalPlayer.Character["Fist of Darkness"].Handle, game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection, 1)
						firetouchinterest(localPlayer.Character.HumanoidRootPart, game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection, 0)
						firetouchinterest(localPlayer.Character.HumanoidRootPart, game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection, 1)
					else
						ToTarget(game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.CFrame)
					end
				else
					local v9 = GetNearestChest()

					if v9 then
						local now = nil

						while true do
							task.wait()

							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v9.Position).Magnitude <= 5 then
								if not now then
									now = tick()
								elseif tick() - now >= 5 then
									Instance.new("IntValue", v9).Name = "Ignored"
									wait(0.5)
								end

								pcall(function()
									game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
								end)

								wait()

								pcall(function()
									game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
								end)

								TweenManager.CancelCurrent()
							end

							ToTarget(v9.CFrame, true)
							if not (not v9 or not v9.Parent or not Settings["Auto Soul Guitar"] or localPlayer.Character:FindFirstChild("Fist of Darkness") or localPlayer.Backpack:FindFirstChild("Fist of Darkness") or v9:GetAttribute("IsDisabled") or v9:FindFirstChild("Ignored") or not v9:FindFirstChild("TouchInterest")) then
								continue
							end
							break
						end
					else
						local v10 = PathFindChest()

						if v10 then
							ToTarget(v10.Part.CFrame)

							if localPlayer:DistanceFromCharacter(v10.Part.Position) <= 100 or GetNearestChest() then
								Instance.new("IntValue", v10).Name = "Ignored"
							end
						else
							for _, child in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
								if child:FindFirstChild("Ignored") then
									child:FindFirstChild("Ignored"):Destroy()
								end
							end
						end
					end
				end
			else
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
			end
		else
			local v9, v10, v11 = DetectRequestSoulGuitar()

			if v10 and Place_Id["sea" .. v10]() then
				local v12 = DetectMob(v9)

				if v12 then
					while true do
						task.wait()
						SizePart(v12)
						BringMob(v12)
						UsedualFlock()
						ClickM1(v12)

						if Settings["Select Weapon"] == "Blox Fruit" then
							ToTarget(v12.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							ToTarget(v12.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end

						if not (not IsMobAlive(v12) or not Settings["Auto Soul Guitar"]) then
							continue
						end
						break
					end
				elseif typeof(v9) == "table" then
					if #tbl5 >= #v9 then
						tbl5 = {}
						return
					end
					local v13 = DetectPartSpawnMob(DetectNameTablePart(v9))

					if v13 then
						table.insert(tbl5, DetectNameTablePart(v9))

						while true do
							wait()
							ToTarget(v13.CFrame * CFrame.new(0, 60, 0))
							if not (localPlayer:DistanceFromCharacter(v13.Position) <= 100 or DetectMob(v9) or not Settings["Auto Soul Guitar"]) then
								continue
							end
							break
						end

						wait(1)
					end
				else
					local v13 = DetectPartSpawnMob(v9, true)

					if v13 then
						Instance.new("IntValue", v13).Name = "Ignored"

						while true do
							wait()
							ToTarget(v13.CFrame * CFrame.new(0, 60, 0))
							if not (localPlayer:DistanceFromCharacter(v13.Position) <= 100 or DetectMob(v9) or not Settings["Auto Soul Guitar"]) then
								continue
							end
							break
						end

						wait(1)
					else
						DeleteIgnoredMobSpawn()
					end
				end
			else
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(v11)
			end
		end
	end

	getgenv().ToggleSoulGuitar = GetItemsSection.CreateToggle({ Title = "Auto Soul Guitar", Desc = nil, Default = Settings["Auto Soul Guitar"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Soul Guitar"] and task.wait(0.1) do
					local ok, result = pcall(function()
						AutoSoulGuitar()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Soul Guitar", arg)
	end)

	StartGood = true

	QuestGood3 = function()
		AllNPCS = {}

		for _, child in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
			table.insert(AllNPCS, child)
		end

		for _, child in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
			table.insert(AllNPCS, child)
		end

		for _, v9 in pairs(AllNPCS) do
			if v9.Name:match("Luxury Boat Dealer") then
				localPlayer.Character.HumanoidRootPart.CFrame = v9.HumanoidRootPart.CFrame
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CDKQuest", "BoatQuest", v9 }))
			end
		end
	end

	QuestGood4 = function()
		if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-5543.5327, 313.80063, -2964.2585)).magnitude > 1000 then
			ToTarget(CFrame.new(-5543.5327148438, 313.80062866211, -2964.2585449219))
		else
			local v9 = GetPirateRaid() or GetPirateRaid(true)

			if v9 then
				while true do
					task.wait()
					EquipTool(NameWeapon("Sword"))
					SizePart(v9)
					ClickM1(v9)

					if Settings["Select Weapon"] == "Blox Fruit" then
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end

					if IsMobAlive(v9) then
						continue
					end
					break
				end
			else
				if (Settings["Select Method Hop CDK1"] or {})["Hop Raid Castle [ Delay 20s Hop Because check Raids Castle ]"] then
					VxezeNotify("Castle Raid", "Waiting 20s for check raid castle if dont have will Server", "warning")
					local now = tick()

					while true do
						wait()
						if not (GetPirateRaid() or GetPirateRaid(true) or tick() - now >= 20) then
							continue
						end
						break
					end

					if not (GetPirateRaid() or GetPirateRaid(true)) then
						SpecialHop("Raid Castle")
					end
				else
					VxezeNotify("Castle Raid", "Waint Raid Castle", "warning")
				end

				wait(5)
			end
		end
	end

	TourchGood5 = function()
		local str2

		if game:GetService("Workspace").Map.HeavenlyDimension.Torch1.ProximityPrompt.Enabled then
			str2 = "1"
		elseif game:GetService("Workspace").Map.HeavenlyDimension.Torch2.ProximityPrompt.Enabled then
			str2 = "2"
		elseif game:GetService("Workspace").Map.HeavenlyDimension.Torch3.ProximityPrompt.Enabled then
			str2 = "3"
		else
			str2 = nil
		end

		return str2
	end

	DetectMobCDK = function()
		for _, child in pairs(game.Workspace.Enemies:GetChildren()) do
			if child:IsA("Model") and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 and localPlayer:DistanceFromCharacter(child.HumanoidRootPart.Position) < 300 then
				return child
			end
		end
	end

	DetectMobHell = function()
		local v9 = next
		local children, v10 = game.Workspace.Enemies:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11:IsA("Model") and v11:FindFirstChild("Humanoid") and v11.Humanoid.Health > 0 and localPlayer:DistanceFromCharacter(v11.HumanoidRootPart.Position) < 300 then
				return v11
			end
		end
	end

	Questgood5 = function()
		if (game:GetService("Workspace")._WorldOrigin.Locations["Heavenly Dimension"].Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude < 1000 then
			if game:GetService("Workspace").Map.HeavenlyDimension.Exit.BrickColor == BrickColor.new("Cloudy grey") then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame
				ToTarget(game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame)
				return
			end

			if DetectMobCDK() then
				repeat
					task.wait()
					local v9 = DetectMobHell()
					SizePart(v9)
					EquipTool(NameWeapon("Sword"))
					ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					getgenv().ClickM1(v9)
				until not DetectMobCDK()
			else
				local v9 = TourchGood5()

				if v9 then
					while true do
						task.wait()

						if (localPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map.HeavenlyDimension["Torch" .. v9].Position).Magnitude > 5 then
							ToTarget(game:GetService("Workspace").Map.HeavenlyDimension["Torch" .. v9].CFrame)
						else
							fireproximityprompt(game:GetService("Workspace").Map.HeavenlyDimension["Torch" .. v9].ProximityPrompt, 0)
							fireproximityprompt(game:GetService("Workspace").Map.HeavenlyDimension["Torch" .. v9].ProximityPrompt, 1)
						end

						if not DetectMobCDK() then
							continue
						end
						break
					end

					localPlayer.Character.HumanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
				end
			end
		elseif CheckNameBoss("Cake Queen") then
			local v9 = CheckNameBoss("Cake Queen")

			while true do
				task.wait()
				SizePart(v9)
				EquipTool(NameWeapon("Sword"))
				ClickM1(v9)

				if Settings["Select Weapon"] == "Blox Fruit" then
					ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end

				if not (not IsMobAlive(v9) or not Settings["Auto CDK"]) then
					continue
				end
				break
			end

			TweenManager.CancelCurrent()
		else
			if Settings["Select Method Hop CDK1"] and Settings["Select Method Hop CDK1"]["Find Cake Queen"] then
				VxezeNotify("Cake Queen", "Hop Server Find Cake Queen", "travel")
				HopServer()
			else
				VxezeNotify("Cake Queen", "Waiting Cake Queen", "warning")
			end

			wait(5)
		end
	end

	QuestEvil3 = function()
		local v9 = next
		local children, v10 = game.workspace.Enemies:GetChildren()
		local v11 = nil

		for _, v12 in v9, children, v10 do
			if v12:IsA("Model") and v12.Name == "Marine Commodore" and v12:FindFirstChild("HumanoidRootPart") and v12.Humanoid.Health > 0 then
				v11 = v12
			end
		end

		if not v11 then
			GetPart = DetectPartSpawnMob("Marine Commodore")
			ToTarget(GetPart.CFrame * CFrame.new(0, 60, 0))
		else
			repeat
				task.wait()
				ToTarget(v11.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
			until localPlayer.Character.Humanoid.Health <= 0
		end
	end

	CheckNearestMobSpawn = function()
		local v9 = next
		local children, v10 = game:GetService("Players").LocalPlayer.QuestHaze:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11.Value > 0 then
				return v11.Name
			end
		end
	end

	QuestEvil4 = function()
		if DetectMob(CheckNearestMobSpawn()) then
			local v9 = DetectMob(CheckNearestMobSpawn())

			while true do
				task.wait()
				SizePart(v9)
				BringMob(v9)
				EquipTool(NameWeapon("Sword"))
				ClickM1(v9)

				if Settings["Select Weapon"] == "Blox Fruit" then
					ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end

				if not (not v9 or not v9.Parent or v9.Humanoid.Health == 0) then
					continue
				end
				break
			end
		else
			GetPart = DetectPartSpawnMob(CheckNearestMobSpawn())
			ToTarget(GetPart.CFrame * CFrame.new(0, 15, 0))
		end
	end

	TourchEvil5 = function()
		local str2

		if game:GetService("Workspace").Map.HellDimension.Torch1.ProximityPrompt.Enabled then
			str2 = "1"
		elseif game:GetService("Workspace").Map.HellDimension.Torch2.ProximityPrompt.Enabled then
			str2 = "2"
		elseif game:GetService("Workspace").Map.HellDimension.Torch3.ProximityPrompt.Enabled then
			str2 = "3"
		else
			str2 = nil
		end

		return str2
	end

	QuestEvil5 = function()
		if (game:GetService("Workspace")._WorldOrigin.Locations["Hell Dimension"].Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
			if not CheckNameBoss("Soul Reaper") then
				if not localPlayer.Character:FindFirstChild("Hallow Essence") and not localPlayer.Backpack:FindFirstChild("Hallow Essence") then
					local v9 = DetectMob(tbl8)

					if v9 then
						while true do
							task.wait()
							SizePart(v9)
							BringMob(v9)
							EquipTool(NameWeapon("Sword"))
							ClickM1(v9)

							if Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							if not (not IsMobAlive(v9) or not Settings["Auto CDK"]) then
								continue
							end
							break
						end
					elseif typeof(tbl8) == "table" then
						if #tbl8 <= #tbl5 then
							tbl5 = {}
							return
						end
						local v10 = DetectPartSpawnMob(DetectNameTablePart(tbl8))

						if v10 then
							table.insert(tbl5, DetectNameTablePart(tbl8))

							while true do
								wait()
								ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
								if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl8) or not Settings["Auto CDK"]) then
									continue
								end
								break
							end

							wait(1)
						end
					else
						local v10 = DetectPartSpawnMob(tbl8, true)

						if v10 then
							Instance.new("IntValue", v10).Name = "Ignored"

							while true do
								wait()
								ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
								if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl8) or not Settings["Auto CDK"]) then
									continue
								end
								break
							end

							wait(1)
						else
							DeleteIgnoredMobSpawn()
						end
					end
				elseif (localPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position).Magnitude > 8 then
					ToTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
				else
					EquipTool("Hallow Essence", true)
				end
			else
				local v9 = CheckNameBoss("Soul Reaper")

				while true do
					task.wait()
					ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
					local flag2 = localPlayer.Character.Humanoid.Health <= 0

					if not flag2 then
						local position = localPlayer.Character.HumanoidRootPart.Position
						flag2 = (game:GetService("Workspace")._WorldOrigin.Locations["Hell Dimension"].Position - position).Magnitude < 1000
					end

					if not flag2 then
						continue
					end
					break
				end

				TweenManager.CancelCurrent()
				local now = tick()

				while true do
					task.wait()
					local flag2 = tick() - now >= 5

					if not flag2 then
						local position = localPlayer.Character.HumanoidRootPart.Position
						flag2 = (game:GetService("Workspace")._WorldOrigin.Locations["Hell Dimension"].Position - position).Magnitude < 1000
					end

					if not flag2 then
						continue
					end
					break
				end
			end
		else
			if game:GetService("Workspace").Map.HellDimension.Exit.BrickColor == BrickColor.new("Olivine") then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HellDimension.Exit.CFrame
				ToTarget(game:GetService("Workspace").Map.HellDimension.Exit.CFrame)
				return
			end

			if DetectMobCDK() then
				repeat
					task.wait()
					local v9 = DetectMobHell()
					SizePart(v9)
					ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					EquipTool(NameWeapon("Sword"))
					getgenv().ClickM1(v9)
				until not DetectMobCDK()
			else
				local v9 = TourchEvil5()

				if v9 then
					while true do
						task.wait()

						if (localPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map.HellDimension["Torch" .. v9].Position).Magnitude > 5 then
							ToTarget(game:GetService("Workspace").Map.HellDimension["Torch" .. v9].CFrame)
						else
							fireproximityprompt(game:GetService("Workspace").Map.HellDimension["Torch" .. v9].ProximityPrompt, 0)
							fireproximityprompt(game:GetService("Workspace").Map.HellDimension["Torch" .. v9].ProximityPrompt, 1)
						end

						if not DetectMobCDK() then
							continue
						end
						break
					end

					localPlayer.Character.HumanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
				end
			end
		end
	end

	CheckMasterSword = function(arg, arg2)
		local v9 = next
		local v10, v11 = GetInventoryItems()

		for _, v12 in v9, v10, v11 do
			if v12.Type == "Sword" and v12.Name == arg and v12.Mastery >= arg2 then
				return true
			end
		end

		return false
	end

	GetCDK = function()
		if CheckItemInventory("Cursed Dual Katana") then
			SaveSettings("Auto CDK", false)

			if getgenv().ToggleAutoCDK then
				getgenv().ToggleAutoCDK:SetStage(false)
			end

			VxezeNotify("Auto CDK", "You already own Cursed Dual Katana", "success", { Key = "cdkdone" })
			return
		end

		if not CheckItemInventory("Tushita") or not CheckItemInventory("Yama") then
			VxezeNotify("Tushita", "Get Tushita and Yama", "success")
			wait(5)
			return
		end

		if CheckItemInventory("Tushita") and CheckItemInventory("Yama") then
			if not CheckMasterSword("Yama", 350) or not CheckMasterSword("Tushita", 350) then
				VxezeNotify("Tushita", "Mastery >= 350", "warning")
				wait(5)
				return
			end

			if not localPlayer.Character:FindFirstChild("Tushita") and not localPlayer.Backpack:FindFirstChild("Tushita") and not localPlayer.Character:FindFirstChild("Yama") and not localPlayer.Backpack:FindFirstChild("Yama") then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Tushita")
				return
			end
			local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
			if type(response) ~= "table" then
				wait(1)
				return
			end
			local good = response.Good
			getgenv().Good = good
			local evil = response.Evil
			getgenv().Evil = evil
			local str2

			if getgenv().Good == 4 and getgenv().Evil == 3 then
				str2 = "Pedestal2"
			elseif getgenv().Good == 3 and getgenv().Evil == 4 then
				str2 = "Pedestal1"
			else
				str2 = nil
			end

			if str2 then
				local v9 = game
				local position = localPlayer.Character.HumanoidRootPart.Position

				if (v9:GetService("Workspace").Map.Turtle.Cursed[str2].Position - position).Magnitude < 10 then
					fireproximityprompt(game:GetService("Workspace").Map.Turtle.Cursed[str2].ProximityPrompt)
				else
					ToTarget(game:GetService("Workspace").Map.Turtle.Cursed[str2].CFrame)
				end
			end

			if localPlayer.PlayerGui.Main.Dialogue.Visible then
				game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
				game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
			end

			if getgenv().Good == 4 and getgenv().Evil == 4 then
				local v9 = game
				local position = localPlayer.Character.HumanoidRootPart.Position

				if (v9:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.Position - position).Magnitude > 10 then
					ToTarget(game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.CFrame)
				elseif game:GetService("Workspace").Map.Turtle.Cursed.PlacedGem.Transparency == 0 then
					if not game.Workspace.Enemies:FindFirstChild("Cursed Skeleton Boss") then
						ToTarget(CFrame.new(-12341.66796875, 603.3455810546875, -6550.6064453125))
					else
						local v10 = next
						local children, v11 = game.Workspace.Enemies:GetChildren()

						for _, v12 in v10, children, v11 do
							if v12:IsA("Model") and v12.Name == "Cursed Skeleton Boss" and v12.Humanoid.Health > 0 then
								while true do
									task.wait()
									SizePart(v12)
									EquipTool(NameWeapon("Sword"))
									ClickM1(v12)

									if Settings["Select Weapon"] == "Blox Fruit" then
										ToTarget(v12.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										ToTarget(v12.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end

									if not (not v12 or not v12.Parent or v12.Humanoid.Health <= 0) then
										continue
									end
									break
								end
							end
						end
					end
				else
					fireproximityprompt(game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.ProximityPrompt)
				end
			end

			if getgenv().Good ~= 4 and getgenv().Good ~= -2 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")

				if getgenv().Good == -3 then
					QuestGood3()
				elseif getgenv().Good == -4 then
					QuestGood4()
				elseif getgenv().Good == -5 then
					Questgood5()
				end
			else
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")

				if getgenv().Evil == -3 then
					QuestEvil3()
				elseif getgenv().Evil == -4 then
					QuestEvil4()
				elseif getgenv().Evil == -5 then
					spawn(function()
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
					end)

					QuestEvil5()
				end
			end
		end
	end

	MethodHopCDk = {
		["Find Cake Queen"] = false,
		["Hop Raid Castle [ Delay 20s Hop Because check Raids Castle ]"] = false,
	}

	GetItemsSection.CreateDropdown({
		Title = "Select Method Hop CDK",
		List = PrepareMultiSelectList(MethodHopCDk, Settings["Select Method Hop CDK1"]),
		Search = true,
		Selected = true,
		Default = Settings["Select Method Hop CDK1"] or nil,
	}, function(arg, arg2)
		SaveSettings("Select Method Hop CDK1", arg, arg2)
	end)

	getgenv().ToggleAutoCDK = GetItemsSection.CreateToggle({ Title = "Auto CDK", Desc = nil, Default = Settings["Auto CDK"] or false }, function(arg)
		if arg and not Place_Id.sea3() then
			SaveSettings("Auto CDK", false)
			VxezeNotify("Auto CDK", "Only works in Sea 3", "warning", { Key = "gateAuto CDK" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto CDK"] and task.wait(0.1) do
					local ok, result = pcall(function()
						GetCDK()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto CDK", arg)
	end)

	GetYama = function()
		if CheckItemInventory("Yama") then
			SaveSettings("Auto Yama", false)

			if getgenv().ToggleAutoYama then
				getgenv().ToggleAutoYama:SetStage(false)
			end

			VxezeNotify("Auto Yama", "You already own Yama", "success", { Key = "yamadone" })
			return
		end

		if not GoToSea(3) then
			return
		end

		if (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") or 0) < 30 then
			local v9 = DetectEliteHunter()
			if not v9 then
				return
			end
			local name_ = v9.Name

			if not string.find(GetQuestTitle(), name_) or not HasQuest() then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
			else
				while true do
					task.wait()
					SizePart(v9)

					if Settings["Select Weapon"] == "Blox Fruit" then
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end

					UsedualFlock()
					ClickM1(v9)
					if not (not IsMobAlive(v9) or not Settings["Auto Yama"]) then
						continue
					end
					break
				end
			end
		else
			if not game.Workspace.Map:FindFirstChild("Waterfall") or not game.Workspace.Map.Waterfall:FindFirstChild("SealedKatana") then
				local v9 = ToTarget
				local cframe = CFrame.new(5251.900390625, 17.18115234375, 453.6025390625)
				v9(cframe)
				return
			end

			if (game.Workspace.Map.Waterfall.SealedKatana.WorldPivot.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude > 50 then
				ToTarget(game.Workspace.Map.Waterfall.SealedKatana.WorldPivot)
			elseif game.Workspace.Enemies:FindFirstChild("Ghost") then
				local Ghost = DetectMob("Ghost")

				if Ghost then
					while true do
						task.wait()
						SizePart(Ghost)
						BringMob(Ghost)
						UsedualFlock()
						ClickM1(Ghost)

						if Settings["Select Weapon"] == "Blox Fruit" then
							ToTarget(Ghost.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							ToTarget(Ghost.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end

						if not (not IsMobAlive(Ghost) or not Settings["Auto Yama"]) then
							continue
						end
						break
					end
				end
			else
				fireclickdetector(workspace.Map.Waterfall.SealedKatana.Hitbox.ClickDetector)
			end
		end
	end

	getgenv().ToggleAutoYama = GetItemsSection.CreateToggle({ Title = "Auto Yama", Desc = nil, Default = Settings["Auto Yama"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Yama"] and task.wait(0.1) do
					local ok, result = pcall(function()
						GetYama()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Yama", arg)
	end)

	CheckTorch = function()
		local str2

		if not game:GetService("Workspace").Map.Turtle.QuestTorches.Torch1.Particles.Main.Enabled then
			str2 = "1"
		elseif not game:GetService("Workspace").Map.Turtle.QuestTorches.Torch2.Particles.Main.Enabled then
			str2 = "2"
		elseif not game:GetService("Workspace").Map.Turtle.QuestTorches.Torch3.Particles.Main.Enabled then
			str2 = "3"
		elseif not game:GetService("Workspace").Map.Turtle.QuestTorches.Torch4.Particles.Main.Enabled then
			str2 = "4"
		elseif not game:GetService("Workspace").Map.Turtle.QuestTorches.Torch5.Particles.Main.Enabled then
			str2 = "5"
		else
			str2 = nil
		end

		local v9 = next
		local children, v10 = game:GetService("Workspace").Map.Turtle.QuestTorches:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11:IsA("MeshPart") and string.find(v11.Name, str2) and not v11.Particles.Main.Enabled then
				return v11
			end
		end
	end

	GetHitBoxTouch = function()
		local hitbox = workspace.Map:FindFirstChild("Waterfall") and game.Workspace.Map.Waterfall:FindFirstChild("IslandModel") and workspace.Map.Waterfall.IslandModel:FindFirstChild("Hitbox", true)
		if hitbox then
			return hitbox
		end
		local v9 = next
		local v10, v11 = getnilinstances()

		for _, v12 in v9, v10, v11 do
			if v12.Name ~= "Hitbox" then
				continue
			end

			if (v12.Position - Vector3.new(5713.5376, 38.383118, 255.2017)).Magnitude == 0 then
				return v12
			end
		end
	end

	GetTushita = function()
		local commF = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
		local response = commF:InvokeServer("TushitaProgress")

		if response and response.OpenedDoor then
			if CheckNameBoss("Longma") then
				local Longma = CheckNameBoss("Longma")

				if Longma then
					while true do
						task.wait()
						SizePart(Longma)

						if Settings["Select Weapon"] == "Blox Fruit" then
							ToTarget(Longma.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							ToTarget(Longma.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end

						UsedualFlock()
						ClickM1(Longma)
						if not (not IsMobAlive(Longma) or not Settings["Auto Tushita"]) then
							continue
						end
						break
					end
				end
			end
		else
			local v9 = GetHitBoxTouch()

			if not v9 then
				local v10 = ToTarget
				local cframe = CFrame.new(5677.541015625, 28.533447265625, 357.9483642578125)
				v10(cframe)
				return
			end

			if v9:FindFirstChild("TouchInterest") then
				if not localPlayer.Character:FindFirstChild("Holy Torch") and not localPlayer.Backpack:FindFirstChild("Holy Torch") then
					ToTarget(v9.CFrame)
				else
					EquipTool("Holy Torch")

					if CheckTorch() then
						for i_ = 1, 5 do
							commF:InvokeServer("TushitaProgress", "Torch", i_)
						end

						wait(2)
					end
				end
			else
				VxezeNotify("Rip Indra", "Rip Indra Dont Spawn", "warning")
				wait(5)
			end
		end
	end

	GetItemsSection.CreateToggle({ Title = "Auto Tushita", Desc = nil, Default = Settings["Auto Tushita"] or false }, function(arg)
		if arg and not Place_Id.sea3() then
			SaveSettings("Auto Tushita", false)
			VxezeNotify("Auto Tushita", "Only works in Sea 3", "warning", { Key = "gateAuto Tushita" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Tushita"] and task.wait(0.3) do
					local ok, result = pcall(function()
						GetTushita()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Tushita", arg)
	end)

	GetItemsSection.CreateToggle({ Title = "Auto TTK", Desc = nil, Default = Settings["Auto TTK"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto TTK"] and task.wait(0.1) do
					pcall(function()
						if not CheckMasterSword("Oroshi", 300) then
							if not DetectItemPlr("Oroshi") then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Oroshi")
							end
						elseif not CheckMasterSword("Saishi", 300) then
							if not DetectItemPlr("Saishi") then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Saishi")
							end
						elseif not CheckMasterSword("Shizu", 300) then
							if not DetectItemPlr("Shizu") then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Shizu")
							end
						elseif not DetectItemPlr("True Triple Katana") then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("MysteriousMan", "2")
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "True Triple Katana")
						end

						local v9 = DetectMob(tbl8)

						if v9 then
							while true do
								task.wait()
								SizePart(v9)
								BringMob(v9)
								EquipTool(NameWeapon("Sword"))
								ClickM1(v9)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								if not (not IsMobAlive(v9) or not Settings["Auto TTK"]) then
									continue
								end
								break
							end
						elseif typeof(tbl8) == "table" then
							if #tbl8 <= #tbl5 then
								tbl5 = {}
								return
							end
							local v10 = DetectPartSpawnMob(DetectNameTablePart(tbl8))

							if v10 then
								table.insert(tbl5, DetectNameTablePart(tbl8))

								while true do
									wait()
									ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
									if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl8) or not Settings["Auto TTK"]) then
										continue
									end
									break
								end

								wait(1)
							end
						else
							local v10 = DetectPartSpawnMob(tbl8, true)

							if v10 then
								Instance.new("IntValue", v10).Name = "Ignored"

								while true do
									wait()
									ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
									if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl8) or not Settings["Auto TTK"]) then
										continue
									end
									break
								end

								wait(1)
							else
								DeleteIgnoredMobSpawn()
							end
						end
					end)
				end
			end)
		end

		SaveSettings("Auto TTK", arg)
	end)

	IsCupDoorOpen = function()
		local v9 = next
		local children, v10 = game:GetService("Workspace").Map.Desert.Burn:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11:IsA("Part") and not v11.CanCollide then
				return true
			end
		end

		return false
	end

	IsSaberDoorOpen = function()
		local v9 = next
		local children, v10 = game:GetService("Workspace").Map.Jungle.Final:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11:IsA("Part") and not v11.CanCollide then
				return true
			end
		end

		return false
	end

	GetTorchPlate = function()
		local v9 = next
		local children, v10 = game:GetService("Workspace").Map.Jungle.QuestPlates:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11:IsA("Model") then
				if v11.Button:FindFirstChild("TouchInterest") then
					return v11
				end
			end
		end
	end

	SaberSword = function()
		if localPlayer.Data.Level.Value >= 200 then
			if not IsSaberDoorOpen() then
				if game:GetService("Workspace").Map.Jungle.QuestPlates.Door.CanCollide then
					ToTarget(GetTorchPlate().Button.CFrame)
				elseif IsCupDoorOpen() then
					if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= 0 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= 1 then
						if not localPlayer.Character:FindFirstChild("Cup") and not localPlayer.Backpack:FindFirstChild("Cup") then
							if (localPlayer.Character.HumanoidRootPart.Position - CFrame.new(1112.46521, 4.92147732, 4364.55469, -0.743286014, -4.82822775e-11, -0.668973804, 4.62103383e-10, 1, -5.85609283e-10, 0.668973804, -7.444102e-10, -0.743286014).Position).Magnitude < 5 then
								ToTarget(CFrame.new(1113.66992, 7.5484705, 4365.27832, -0.78613919, -2.19578524e-08, -0.618049502, 1.02977182e-09, 1, -3.68374984e-08, 0.618049502, -2.95958493e-08, -0.78613919))
								local humanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
								firetouchinterest(game:GetService("Workspace").Map.Desert.Cup, humanoidRootPart, 0)
								local humanoidRootPart2 = game.Players.LocalPlayer.Character.HumanoidRootPart
								firetouchinterest(game:GetService("Workspace").Map.Desert.Cup, humanoidRootPart2, 1)
								return
							end

							ToTarget(CFrame.new(1112.46521, 4.92147732, 4364.55469, -0.743286014, -4.82822775e-11, -0.668973804, 4.62103383e-10, 1, -5.85609283e-10, 0.668973804, -7.444102e-10, -0.743286014))
						else
							EquipTool("Cup")

							if localPlayer.Backpack:FindFirstChild("Cup") and localPlayer.Backpack.Cup.Handle:FindFirstChild("TouchInterest") or localPlayer.Character:FindFirstChild("Cup") and localPlayer.Character.Cup.Handle:FindFirstChild("TouchInterest") then
								ToTarget(CFrame.new(1395.77307, 37.4733238, -1324.34631, -0.999978602, -6.53588605e-09, 0.00654155109, -6.57083277e-09, 1, -5.32077493e-09, -0.00654155109, -5.3636442e-09, -0.999978602))
							else
								local flag2 = localPlayer.Backpack:FindFirstChild("Cup") and not localPlayer.Backpack.Cup.Handle:FindFirstChild("TouchInterest")
								local flag3

								if flag2 then
									flag3 = flag2
								else
									flag3 = localPlayer.Character:FindFirstChild("Cup") and not localPlayer.Character.Cup.Handle:FindFirstChild("TouchInterest")
								end

								if flag3 then
									TalkToNpc("Sick Man", "ProQuestProgress", "SickMan")
								end
							end
						end
					elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0 then
						local v9 = CheckNameBoss("Mob Leader")

						if v9 then
							while true do
								task.wait()
								SizePart(v9)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								UsedualFlock()
								ClickM1(v9)
								if not (not IsMobAlive(v9) or not Settings["Auto Saber"]) then
									continue
								end
								break
							end
						end
					elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
						if not localPlayer.Character:FindFirstChild("Relic") and not localPlayer.Backpack:FindFirstChild("Relic") then
							TalkToNpc("Rich Man", "ProQuestProgress", "RichSon")
						else
							EquipTool("Relic")
							ToTarget(CFrame.new(-1405.3677978516, 29.977333068848, 4.5685839653015))
						end
					end
				elseif not localPlayer.Character:FindFirstChild("Torch") and not localPlayer.Backpack:FindFirstChild("Torch") then
					ToTarget(game:GetService("Workspace").Map.Jungle.Torch.CFrame)
				else
					EquipTool("Torch")

					if (localPlayer.Character.HumanoidRootPart.Position - CFrame.new(1115.23499, 4.92147732, 4349.36963, -0.670654476, -2.18307523e-08, 0.74176991, -9.06980624e-09, 1, 2.1230365e-08, -0.74176991, 7.51052998e-09, -0.670654476).Position).Magnitude < 5 then
						ToTarget(CFrame.new(1114.59863, 4.92147732, 4350.64258, -0.508235395, 1.00975717e-09, 0.861218214, 7.77848985e-09, 1, 3.41788708e-09, -0.861218214, 8.43606784e-09, -0.508235395))
						firetouchinterest(game.Players.LocalPlayer.Character.Torch.Handle, game:GetService("Workspace").Map.Desert.Burn.Fire, 0)
						firetouchinterest(game.Players.LocalPlayer.Character.Torch.Handle, game:GetService("Workspace").Map.Desert.Burn.Fire, 1)
						return
					end

					ToTarget(CFrame.new(1115.23499, 4.92147732, 4349.36963, -0.670654476, -2.18307523e-08, 0.74176991, -9.06980624e-09, 1, 2.1230365e-08, -0.74176991, 7.51052998e-09, -0.670654476))
				end
			else
				local v9 = CheckNameBoss("Saber Expert")

				if v9 then
					while true do
						task.wait()
						SizePart(v9)

						if Settings["Select Weapon"] == "Blox Fruit" then
							ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end

						UsedualFlock()
						ClickM1(v9)
						if not (not IsMobAlive(v9) or not Settings["Auto Saber"]) then
							continue
						end
						break
					end
				end
			end
		end
	end

	GetItemsSection.CreateToggle({ Title = "Auto Saber", Desc = nil, Default = Settings["Auto Saber"] or false }, function(arg)
		if arg and not Place_Id.sea1() then
			SaveSettings("Auto Saber", false)
			VxezeNotify("Auto Saber", "Only works in Sea 1", "warning", { Key = "gateAuto Saber" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Saber"] and task.wait(0.1) do
					pcall(function()
						SaberSword()
					end)
				end
			end)
		end

		SaveSettings("Auto Saber", arg)
	end)

	AutoCraftSharkAnchor = function()
		if CheckItemInventory("Shark Anchor") then
			SaveSettings("Auto Craft Item Shark Anchor", false)

			if getgenv().ToggleSharkAnchor then
				getgenv().ToggleSharkAnchor:SetStage(false)
			end

			VxezeNotify("Shark Anchor", "Done Shark Anchor", "success", { Key = "sharkdone" })
			return
		end

		if not CheckItemInventory("Monster Magnet") then
			if not CheckItemInventory("Shark Tooth Necklace") and CheckCountItem("Mutant Tooth", 1) and CheckCountItem("Shark Tooth", 5) then
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({ "Craft", "ToothNecklace", 1, {} }))
			elseif not CheckItemInventory("Terror Jaw") and CheckCountItem("Mutant Tooth", 2) and CheckCountItem("Shark Tooth", 5) and CheckCountItem("Terror Eyes", 1) and CheckCountItem("Fool's Gold", 10) then
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({ "Craft", "TerrorJaw", 1, {} }))
			elseif CheckItemInventory("Shark Tooth Necklace") and CheckItemInventory("Terror Jaw") and CheckCountItem("Terror Eyes", 2) and CheckCountItem("Shark Tooth", 10) and CheckCountItem("Electric Wing", 10) and CheckCountItem("Fool's Gold", 20) then
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({ "Craft", "SharkAnchor", 1, {} }))
			end
		end
	end

	getgenv().ToggleSharkAnchor = GetItemsSection.CreateToggle({
		Title = "Auto Craft Item Shark Anchor",
		Desc = nil,
		Default = Settings["Auto Craft Item Shark Anchor"] or false,
	}, function(arg)
		if arg then
			spawn(function()
				while Settings["Auto Craft Item Shark Anchor"] and wait(0.1) do
					pcall(function()
						AutoCraftSharkAnchor()
					end)
				end
			end)
		end

		SaveSettings("Auto Craft Item Shark Anchor", arg)
	end)

	AutoYorumini = function()
		if CheckItemInventory("Dark Dagger") then
			SaveSettings("Auto Yoru Mini", false)

			if getgenv().ToggleAutoYoruMini then
				getgenv().ToggleAutoYoruMini:SetStage(false)
			end

			VxezeNotify("Yoru Mini", "You already have Yoru Mini", "success", { Key = "yorudone" })
			return
		end

		local v9 = CheckNameBoss("rip_indra True Form")

		if v9 then
			while true do
				task.wait()
				SizePart(v9)

				if Settings["Select Weapon"] == "Blox Fruit" then
					ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end

				UsedualFlock()
				ClickM1(v9)
				if not (not IsMobAlive(v9) or not Settings["Auto Yoru Mini"]) then
					continue
				end
				break
			end
		elseif not DetectItemPlr("God's Chalice") then
			elitehunter = DetectEliteHunter()

			if elitehunter then
				local v10 = elitehunter

				if v10 then
					local name_ = v10.Name

					if not string.find(GetQuestTitle(), name_) or not HasQuest() then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
					else
						while true do
							task.wait()
							SizePart(v10)

							if Settings["Select Weapon"] == "Blox Fruit" then
								ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end

							UsedualFlock()
							ClickM1(v10)
							if not (not IsMobAlive(v10) or not Settings["Auto Yoru Mini"]) then
								continue
							end
							break
						end
					end
				end
			else
				if n2 and n2 >= (Settings["Value Collect Chest to Hop"] or 20) and Settings["Auto Yoru Mini (Hop Server)"] then
					HopServer()
					return
				end
				local v10 = GetNearestChest()

				if v10 then
					n2 += 1
					local now = nil

					while true do
						task.wait()

						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v10.Position).Magnitude <= 5 then
							if not now then
								now = tick()
							elseif tick() - now >= 5 then
								Instance.new("IntValue", v10).Name = "Ignored"
								wait(0.5)
							end

							pcall(function()
								game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
							end)

							wait()

							pcall(function()
								game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
							end)

							TweenManager.CancelCurrent()
						end

						ToTarget(v10.CFrame, true)
						if not (not v10 or not v10.Parent or not Settings["Auto Yoru Mini"] or v10:GetAttribute("IsDisabled") or v10:FindFirstChild("Ignored") or not v10:FindFirstChild("TouchInterest")) then
							continue
						end
						break
					end
				else
					local v11 = PathFindChest()

					if v11 then
						ToTarget(v11.Part.CFrame)

						if localPlayer:DistanceFromCharacter(v11.Part.Position) <= 100 or GetNearestChest() then
							Instance.new("IntValue", v11).Name = "Ignored"
						end
					else
						for _, child in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
							if child:FindFirstChild("Ignored") then
								child:FindFirstChild("Ignored"):Destroy()
							end
						end
					end
				end
			end
		else
			n2 = Settings["Value Collect Chest to Hop"] or 20

			if not IsMisisngLegHaki() and DetectButtons() then
				TouchPadHaki()
			elseif not DetectButtons() then
				EquipTool("God's Chalice")
				ToTarget(game:GetService("Workspace").Map["Boat Castle"].Summoner.Detection.CFrame)
			end
		end
	end

	getgenv().ToggleAutoYoruMini = GetItemsSection.CreateToggle({
		Title = "Auto Yoru Mini",
		Desc = [[u need have 3 haki legendary,
it will auto chest, kill Elite Hunter Find Chalice,
Summon And Kill Rip Indra]],
		Default = Settings["Auto Yoru Mini"] or false,
	}, function(arg)
		if arg and not Place_Id.sea3() then
			SaveSettings("Auto Yoru Mini", false)
			VxezeNotify("Auto Yoru Mini", "Only works in Sea 3", "warning", { Key = "gateAuto Yoru Mini" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Yoru Mini"] and wait(0.1) do
					pcall(function()
						AutoYorumini()
					end)
				end
			end)
		end

		SaveSettings("Auto Yoru Mini", arg)
	end)

	GetItemsSection.CreateToggle({
		Title = "Auto Yoru Mini (Hop Server)",
		Desc = "u can change value hop chest in Tab Farming Other",
		Default = Settings["Auto Yoru Mini (Hop Server)"] or false,
	}, function(arg)
		SaveSettings("Auto Yoru Mini (Hop Server)", arg)
	end)

	MasteryWeaponSection = GetItemsMain.CreateSection("Mastery Weapon")
	BlMeleeFarmMastery = {}

	TableMelees = {
		Superhuman = 1,
		["Death Step"] = 2,
		["Sharkman Karate"] = 3,
		["Electric Claw"] = 4,
		["Dragon Talon"] = 5,
		["Black Leg"] = 6,
		["Fishman Karate"] = 7,
		Electro = 8,
		["Dragon Claw"] = 9,
	}

	MasteryFinish = function(arg, arg2, arg3)
		SaveSettings(arg, false)

		if arg2 and arg2.SetStage then
			arg2:SetStage(false)
		end

		if enabled2 then
			enabled2 = false
			startFarm:SetStage(false)
		end

		VxezeNotify("Mastery Weapon", arg3, "success", { Key = "masteryfinish" .. arg })
	end

	MasteryToggleKeys = {
		Melee = "Auto Farm Mastery 600 Melees",
		Sword = "Auto Farm Mastery 600 Sword In Inventory",
		Gun = "Auto Farm Mastery 600 Gun In Inventory",
	}

	MasteryToggleHandles = { Melee = "ToggleMasteryMelee", Sword = "ToggleMasterySword", Gun = "ToggleMasteryGun" }

	MasteryTurnOffOthers = function(arg)
		for k, v9 in pairs(MasteryToggleKeys) do
			if k ~= arg and Settings[v9] then
				SaveSettings(v9, false)
				local v10 = MasteryToggleHandles[k]
				local v11 = getgenv()[v10]

				if v11 and v11.SetStage then
					v11:SetStage(false)
				end
			end
		end
	end

	DetectMeleeFarmMastery = function()
		local v9 = nil
		local huge = math.huge
		local v10 = nil

		for k, v11 in next, TableMelees, v9 do
			if not table.find(BlMeleeFarmMastery, k) then
				if v11 < huge then
					huge = v11
					v10 = k
				end
			end
		end

		return v10
	end

	CheckMasteryMelee = function(arg)
		for _, child in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if child:IsA("Tool") and (arg and child.Name == arg or not arg and child.ToolTip == "Melee") then
				return child.Level.Value
			end
		end

		for _, child in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if child:IsA("Tool") and (arg and child.Name == arg or not arg and child.ToolTip == "Melee") then
				return child.Level.Value
			end
		end
	end

	SetMasteryStatus = function(arg, arg2)
		local statusSwordMastery = arg == "Sword" and getgenv().StatusSwordMastery or arg == "Melee" and getgenv().StatusMeleeMastery or getgenv().StatusGunMastery

		if statusSwordMastery then
			statusSwordMastery.SetText("Status " .. arg .. " Mastery : " .. arg2)
		end
	end

	local createLabel2 = MasteryWeaponSection.CreateLabel
	getgenv().StatusSwordMastery = createLabel2({ Title = "Status Sword Mastery : None" })
	local createLabel3 = MasteryWeaponSection.CreateLabel
	getgenv().StatusGunMastery = createLabel3({ Title = "Status Gun Mastery : None" })
	local createLabel4 = MasteryWeaponSection.CreateLabel
	getgenv().StatusMeleeMastery = createLabel4({ Title = "Status Melee Mastery : None" })

	MeleeInfo = {
		Superhuman = { inv = "Superhuman", buy = "BuySuperhuman", npc = "Martial Arts Master" },
		["Death Step"] = { inv = "Death Step", buy = "BuyDeathStep", npc = "Phoeyu, the Reformed" },
		["Sharkman Karate"] = { inv = "Sharkman Karate", buy = "BuySharkmanKarate", npc = "Sharkman Teacher" },
		["Electric Claw"] = { inv = "Electric Claw", buy = "BuyElectricClaw", npc = "Previous Hero" },
		["Dragon Talon"] = { inv = "Dragon Talon", buy = "BuyDragonTalon", npc = "Uzoth" },
		["Black Leg"] = { inv = "Dark Step", buy = "BuyBlackLeg", npc = "Dark Step Teacher" },
		["Fishman Karate"] = { inv = "Water Kung Fu", buy = "BuyFishmanKarate", npc = "Water Kung-fu Teacher" },
		Electro = { inv = "Electric", buy = "BuyElectro", npc = "Mad Scientist" },
		["Dragon Claw"] = { inv = "Dragon Breath", npc = "Sabi" },
	}

	GetMeleeInventoryMastery = function()
		local tbl16 = {}

		for _, v9 in ipairs(GetInventoryItems()) do
			if v9.Type == "Fighting Style" then
				tbl16[v9.Name] = v9.Mastery
			end
		end

		return tbl16
	end

	DetectMeleeTarget = function()
		local v9 = GetMeleeInventoryMastery()
		local v10 = nil
		local v11 = nil
		local v12 = nil

		for k, v13 in pairs(TableMelees) do
			local v14 = MeleeInfo[k]

			if v14 and not table.find(BlMeleeFarmMastery, k) then
				local v15 = v9[v14.inv]

				if v15 and v15 >= 600 then
					table.insert(BlMeleeFarmMastery, k)
				else
					local flag2 = v15 ~= nil
					local n = (flag2 and 0 or 100) + v13

					if not v10 or n < v11 then
						v10 = k
						v11 = n
						v12 = flag2
					end
				end
			end
		end

		if v10 then
			return v10, v9[MeleeInfo[v10].inv] or 0, v12
		end
	end

	IsMeleeLoaded = function(arg)
		local v9 = MeleeInfo[arg]

		for _, v10 in ipairs({ localPlayer.Character, localPlayer.Backpack }) do
			for _, child in ipairs(v10:GetChildren()) do
				if child:IsA("Tool") and child.ToolTip == "Melee" and (child.Name == arg or child.Name == v9.inv) then
					return true
				end
			end
		end

		return false
	end

	MasteryMeleeStep = function()
		local v9, v10, flag2 = DetectMeleeTarget()

		if not v9 then
			SetMasteryStatus("Melee", "None")
			MasteryFinish("Auto Farm Mastery 600 Melees", getgenv().ToggleMasteryMelee, "All melees reached 600 mastery")
			return false
		end

		local v11 = MeleeInfo[v9]
		SetMasteryStatus("Melee", v10 .. "/600 | " .. v9)

		if IsMeleeLoaded(v9) then
			MeleeNotified = nil

			if not enabled2 then
				enabled2 = true
				startFarm:SetStage(true)
				callback2:SetValue("Melee")
			end

			return false
		end

		if enabled2 then
			enabled2 = false
			startFarm:SetStage(false)
			VxezeHardStopTween()
		end

		if flag2 then
			flag2 = os.clock() - (MeleeLoadAt or 0) > 6
		end

		if flag2 then
			MeleeLoadAt = os.clock()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", v11.inv)
			task.wait(1)
			if IsMeleeLoaded(v9) then
				return false
			end
		end

		if v9 == "Dragon Claw" then
			if os.clock() - (MeleeBuyAt or 0) > 5 then
				MeleeBuyAt = os.clock()
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
			end

			return false
		end

		if MeleeNotified ~= v9 then
			MeleeNotified = v9
			VxezeNotify("Mastery Weapon", "Going to " .. v11.npc .. " to get " .. v9, "travel", { Key = "meleenpc" .. v9 })
		end

		if TalkToNpc(v11.npc, v11.buy) then
			task.wait(1)
		end

		return true
	end

	getgenv().ToggleMasteryMelee = MasteryWeaponSection.CreateToggle({
		Title = "Auto Farm Mastery 600 Melees",
		Desc = nil,
		Default = Settings["Auto Farm Mastery 600 Melees"] or false,
	}, function(arg)
		SaveSettings("Auto Farm Mastery 600 Melees", arg)

		if arg then
			MasteryTurnOffOthers("Melee")

			task.spawn(function()
				while Settings["Auto Farm Mastery 600 Melees"] do
					local ok, result = pcall(MasteryMeleeStep)

					if not ok then
						PrintOnce(result)
						result = false
					end

					task.wait(result and 0.25 or 1.5)
				end
			end)
		else
			if enabled2 then
				enabled2 = false
				startFarm:SetStage(false)
			end

			SetMasteryStatus("Melee", "None")
		end
	end)

	WeaponRarityCache = { at = 0, map = {} }

	GetWeaponRarity = function(arg)
		local at = WeaponRarityCache.at

		if os.clock() - at > 60 then
			WeaponRarityCache.at = os.clock()

			local ok, result = pcall(function()
				return game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventoryWeapons")
			end)

			if ok and type(result) == "table" then
				local map = {}

				for _, v9 in ipairs(result) do
					if type(v9) == "table" and v9.Name then
						map[v9.Name] = v9.Rarity or 0
					end
				end

				WeaponRarityCache.map = map
			end
		end

		return WeaponRarityCache.map[arg] or 0
	end

	DetectMasteryTarget = function(arg)
		local name_ = nil
		local v9 = nil
		local mastery = nil

		for _, v10 in ipairs(GetInventoryItems()) do
			if v10.Type == arg and v10.Mastery < 600 then
				local v11 = GetWeaponRarity(v10.Name)

				if not name_ or v11 > v9 or v11 == v9 and v10.Mastery > mastery then
					name_ = v10.Name
					mastery = v10.Mastery
					v9 = v11
				end
			end
		end

		return name_, mastery
	end

	DetectSwordUnlock = function()
		return (DetectMasteryTarget("Sword"))
	end

	RunMasteryInventory = function(arg, arg2, arg3)
		while Settings[arg2] and task.wait(1.5) do
			local ok, result = pcall(function()
				local v9, v10 = DetectMasteryTarget(arg)

				if not v9 then
					SetMasteryStatus(arg, "None")
					MasteryFinish(arg2, getgenv()[arg3], "All " .. arg:lower() .. "s in inventory reached 600 mastery")

					if arg == "Gun" then
						MasteryLinkFarming(false)
					end

					return
				end

				SetMasteryStatus(arg, v10 .. "/600 | " .. v9)

				if not localPlayer.Backpack:FindFirstChild(v9) and not localPlayer.Character:FindFirstChild(v9) then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", v9)
				end
			end)

			if not ok then
				PrintOnce(result)
			end
		end

		SetMasteryStatus(arg, "None")
	end

	MasteryLinkFarming = function(arg)
		local masteryFarm = ElementCollection["Mastery Farm"]
		if not masteryFarm then
			return
		end

		if arg then
			if masteryFarm["Select Method Farm Mastery"] then
				masteryFarm["Select Method Farm Mastery"]:SetValue("Gun")
			end

			if masteryFarm["Farm Mastery"] and not Settings["Farm Mastery"] then
				masteryFarm["Farm Mastery"]:SetStage(true)
				VxezeNotify("Mastery Weapon", "Also turned on Farm Mastery (Gun) in Farming so the gun gets mastery", "info", { Key = "gunlink" })
			end
		elseif masteryFarm["Farm Mastery"] and Settings["Farm Mastery"] then
			masteryFarm["Farm Mastery"]:SetStage(false)
			VxezeNotify("Mastery Weapon", "Turned off Farm Mastery (Gun) in Farming", "info", { Key = "gunlink" })
		end
	end

	MasteryToggleCallback = function(arg, arg2, arg3)
		return function(arg4)
			if arg4 then
				MasteryTurnOffOthers(arg)
				enabled2 = true
				startFarm:SetStage(true)
				callback2:SetValue(arg)

				if arg == "Gun" then
					MasteryLinkFarming(true)
				end
			elseif enabled2 then
				startFarm:SetStage(false)
				enabled2 = false

				if arg == "Gun" then
					MasteryLinkFarming(false)
				end
			end

			SaveSettings(arg2, arg4)

			if arg4 then
				task.spawn(RunMasteryInventory, arg, arg2, arg3)
			else
				SetMasteryStatus(arg, "None")
			end
		end
	end

	getgenv().ToggleMasterySword = MasteryWeaponSection.CreateToggle({
		Title = "Auto Farm Mastery 600 Sword In Inventory",
		Desc = nil,
		Default = Settings["Auto Farm Mastery 600 Sword In Inventory"] or false,
	}, MasteryToggleCallback("Sword", "Auto Farm Mastery 600 Sword In Inventory", "ToggleMasterySword"))

	getgenv().ToggleMasteryGun = MasteryWeaponSection.CreateToggle({
		Title = "Auto Farm Mastery 600 Gun In Inventory",
		Desc = nil,
		Default = Settings["Auto Farm Mastery 600 Gun In Inventory"] or false,
	}, MasteryToggleCallback("Gun", "Auto Farm Mastery 600 Gun In Inventory", "ToggleMasteryGun"))

	UpgradeWeaponSection = GetItemsMain.CreateSection("Upgrade Weapon")
	local createLabel5 = UpgradeWeaponSection.CreateLabel
	getgenv().StatusUpgradeSword = createLabel5({ Title = "Status Upgrade Sword : None" })
	local createLabel6 = UpgradeWeaponSection.CreateLabel
	getgenv().StatusUpgradeGun = createLabel6({ Title = "Status Upgrade Gun : None" })
	UpgradeCtx = { Sword = { done = {} }, Gun = { done = {} } }

	SetUpgradeStatus = function(arg, arg2)
		local statusUpgradeSword = arg == "Sword" and getgenv().StatusUpgradeSword or getgenv().StatusUpgradeGun

		if statusUpgradeSword then
			statusUpgradeSword.SetText("Status Upgrade " .. arg .. " : " .. arg2)
		end
	end

	UpgradeRemoteCheck = function(arg)
		if require(game.ReplicatedStorage.Modules.Flags).ENCHANT_USES_NEW_SERVICE then
			return require(game.ReplicatedStorage.Modules.Net):RemoteFunction("EnchantInvoke"):InvokeServer("CheckUpgrades", arg)
		end
		return game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeItem", "Check", arg)
	end

	UpgradeRemoteDo = function(arg, arg2)
		if require(game.ReplicatedStorage.Modules.Flags).ENCHANT_USES_NEW_SERVICE then
			return require(game.ReplicatedStorage.Modules.Net):RemoteFunction("EnchantInvoke"):InvokeServer("Upgrade", arg)
		end
		return game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeItem", "Upgrade", arg2.Result.Physical)
	end

	UpgradeIsMaxed = function(arg)
		local old = arg.ResultStats and arg.ResultStats.Old
		local v9 = pairs
		old = old or {}

		for _, v10 in v9(old) do
			if type(v10) == "table" and type(v10[1]) == "string" and v10[1]:find("Max Upgrades") then
				return true
			end
		end

		return false
	end

	DetectUpgradeTarget = function(arg)
		local name_ = nil
		local v9 = nil

		for _, v10 in ipairs(GetInventoryItems()) do
			local flag2 = v10.Type == arg and not UpgradeCtx[arg].done[v10.Name]

			if flag2 then
				flag2 = os.clock() >= ((UpgradeCtx[arg].retry or {})[v10.Name] or 0)
			end

			if flag2 then
				local v11 = GetWeaponRarity(v10.Name)

				if not name_ or v11 > v9 then
					name_ = v10.Name
					v9 = v11
				end
			end
		end

		return name_
	end

	FarmUpgradeMaterial = function(materialNotSupported)
		if not Settings["Select Weapon"] then
			VxezeNotify("Upgrade Weapon", "Pick a weapon in Select Weapon so the material farm can attack", "warning", { Key = "upgradeselectweapon" })
			task.wait(2)
			return
		end

		local v9 = NameWeapon(Settings["Select Weapon"])

		if v9 and not localPlayer.Character:FindFirstChild(v9) then
			EquipTool(v9)
		end

		if materialNotSupported then
			local v10, v11 = GetMaterialMobs(materialNotSupported)

			if v11 then
				VxezeNotify("Material", materialNotSupported .. " only drops in Sea " .. v11 .. ", heading there now", "info", { Key = "upgradesea", Repeat = 30 })
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(SeaTravelRemote[v11])
				return
			end

			if not v10 then
				VxezeNotify("Material", "Material not supported: " .. materialNotSupported, "warning")
				wait(5)
				return
			end

			if getgenv().StatusUpgradeWP then
				StatusUpgradeWP.SetText("Farm Material " .. materialNotSupported)
			end

			local v12 = DetectMob(v10)

			if not v12 then
				if typeof(v10) == "table" then
					if #tbl5 >= #v10 then
						tbl5 = {}
						return
					end
					local v13 = DetectPartSpawnMob(DetectNameTablePart(v10))

					if v13 then
						table.insert(tbl5, DetectNameTablePart(v10))

						while true do
							wait()
							ToTarget(v13.CFrame * CFrame.new(0, 60, 0))
							local flag2 = localPlayer:DistanceFromCharacter(v13.Position) <= 100 or DetectMob(v10)
							local flag3

							if flag2 then
								flag3 = flag2
							else
								flag3 = not Settings["Auto Upgrade Sword Inventory"] and not Settings["Auto Upgrade Gun Inventory"]
							end

							if not flag3 then
								continue
							end
							break
						end

						wait(1)
					end
				else
					local v13 = DetectPartSpawnMob(v10, true)

					if v13 then
						Instance.new("IntValue", v13).Name = "Ignored"

						while true do
							wait()
							ToTarget(v13.CFrame * CFrame.new(0, 60, 0))
							if not (localPlayer:DistanceFromCharacter(v13.Position) <= 100 or DetectMob(v10) or not Settings["Auto Upgrade Sword Inventory"] and not Settings["Auto Upgrade Gun Inventory"]) then
								continue
							end
							break
						end

						wait(1)
					else
						DeleteIgnoredMobSpawn()
					end
				end
			else
				while true do
					task.wait()
					SizePart(v12)
					BringMob(v12)
					UsedualFlock()
					ClickM1(v12)

					if Settings["Select Weapon"] == "Blox Fruit" then
						ToTarget(v12.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						ToTarget(v12.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end

					local flag2 = not IsMobAlive(v12)
					local flag3

					if flag2 then
						flag3 = flag2
					else
						flag3 = not Settings["Auto Upgrade Sword Inventory"] and not Settings["Auto Upgrade Gun Inventory"]
					end

					if not flag3 then
						continue
					end
					break
				end
			end
		end
	end

	AutoUpgradeWeapon = function(arg, arg2, arg3)
		local v9 = UpgradeCtx[arg]
		v9.retry = v9.retry or {}
		local v10 = DetectUpgradeTarget(arg)

		if not v10 then
			SetUpgradeStatus(arg, "None")
			SaveSettings(arg2, false)

			if getgenv()[arg3] and getgenv()[arg3].SetStage then
				getgenv()[arg3]:SetStage(false)
			end

			VxezeNotify("Upgrade Weapon", "Every " .. arg:lower() .. " is upgraded or cannot be upgraded", "success", { Key = "upgradedone" .. arg })
			return
		end

		local v11 = localPlayer.Backpack:FindFirstChild(v10) or localPlayer.Character:FindFirstChild(v10)

		if not v11 then
			SetUpgradeStatus(arg, "🔴 Not Done | " .. v10)
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", v10)
			task.wait(1.2)
			return
		end

		local ok, result = pcall(UpgradeRemoteCheck, v11)
		if not ok or type(result) ~= "table" or type(result.Result) ~= "table" then
			v9.done[v10] = true
			return
		end

		if UpgradeIsMaxed(result) then
			v9.done[v10] = true
			SetUpgradeStatus(arg, "🟢 Done | " .. v10)
			task.wait(0.8)
			return
		end

		SetUpgradeStatus(arg, "🔴 Not Done | " .. v10)

		if result.Result.Could then
			local Blacksmith = DetectNpc("Blacksmith")
			if not Blacksmith then
				task.wait(1)
				return
			end
			local pivot = Blacksmith:GetPivot()
			if localPlayer:DistanceFromCharacter(pivot.Position) > 8 then
				ToTarget(pivot * CFrame.new(0, 0, 4))
				return
			end
			VxezeHardStopTween()
			local ok2 = pcall(UpgradeRemoteDo, v11, result)
			task.wait(1.5)

			if ok2 then
				VxezeNotify("Upgrade Weapon", "Upgraded " .. v10, "reward", { Key = "upgraded" .. v10 })
			else
				v9.retry[v10] = os.clock() + 60
			end

			return
		end

		local v12, v13, v14 = ipairs(result.Required or {})
		local name_ = nil

		for _, v15 in v12, v13, v14 do
			if v15.Name and not CheckCountItem(v15.Name, v15.Required) then
				name_ = name_ or v15.Name
				if GetMaterialMobs(v15.Name) ~= nil then
					name_ = v15.Name
					break
				end
			end
		end

		if not name_ then
			v9.retry[v10] = os.clock() + 60
			return
		end
		FarmUpgradeMaterial(name_)
	end

	UpgradeToggleCallback = function(arg, arg2, arg3)
		return function(arg4)
			SaveSettings(arg2, arg4)

			if arg4 then
				local str2 = arg == "Sword" and "Auto Upgrade Gun Inventory" or "Auto Upgrade Sword Inventory"

				if Settings[str2] then
					SaveSettings(str2, false)
					local v9 = getgenv()[arg == "Sword" and "ToggleUpgradeGun" or "ToggleUpgradeSword"]

					if v9 and v9.SetStage then
						v9:SetStage(false)
					end
				end

				UpgradeCtx[arg].done = {}
				UpgradeCtx[arg].retry = {}

				task.spawn(function()
					while Settings[arg2] and task.wait(0.5) do
						local ok, result = pcall(AutoUpgradeWeapon, arg, arg2, arg3)

						if not ok then
							PrintOnce(result)
							task.wait(1)
						end
					end

					SetUpgradeStatus(arg, "None")
				end)
			else
				SetUpgradeStatus(arg, "None")
			end
		end
	end

	getgenv().ToggleUpgradeSword = UpgradeWeaponSection.CreateToggle({
		Title = "Auto Upgrade Sword Inventory",
		Desc = nil,
		Default = Settings["Auto Upgrade Sword Inventory"] or false,
	}, UpgradeToggleCallback("Sword", "Auto Upgrade Sword Inventory", "ToggleUpgradeSword"))

	getgenv().ToggleUpgradeGun = UpgradeWeaponSection.CreateToggle({
		Title = "Auto Upgrade Gun Inventory",
		Desc = nil,
		Default = Settings["Auto Upgrade Gun Inventory"] or false,
	}, UpgradeToggleCallback("Gun", "Auto Upgrade Gun Inventory", "ToggleUpgradeGun"))

	VolcanoTab = Main.CreatePage({ Page_Name = "Volcano Event", Page_Title = "Volcano Event Tab" })
	SettingsVolcanoSection = VolcanoTab.CreateSection("Settings Volcano")

	SettingsVolcanoSection.CreateDropdown({
		Title = "Select Weapon Kill Golem",
		List = { "Melee", "Sword", "Gun", "Blox Fruit" },
		Search = true,
		Selected = false,
		Default = Settings["Select Weapon Kill Golem"] or nil,
	}, function(arg)
		SaveSettings("Select Weapon Kill Golem", arg)
	end)

	SettingsVolcanoSection.CreateDropdown({
		Title = "Select Weapons Fix Lava",
		List = PrepareMultiSelectList(tbl12, Settings["Select Weapons Fix Lava"]),
		Search = true,
		Selected = true,
		Default = Settings["Select Weapons Fix Lava"] or nil,
	}, function(arg, arg2)
		SaveSettings("Select Weapons Fix Lava", arg, arg2)
	end)

	SettingsVolcanoSection.CreateDropdown({
		Title = "Select Method Kill Golem",
		List = { "Click M1", "Instant Kill [ Risk and can bug no die mob ]" },
		Search = true,
		Selected = false,
		Default = Settings["Select Method Kill Golem"] or nil,
	}, function(arg)
		SaveSettings("Select Method Kill Golem", arg)
	end)

	FarmingVolcanoSection = VolcanoTab.CreateSection("Farming Volcano")

	AutoCraftinMagnetVol = function()
		if not CheckItemInventory("Volcanic Magnet") then
			if not CheckCountItem("Scrap Metal", 10) then
				local tbl16 = { "Jungle Pirate" }
				local v9 = DetectMob(tbl16)

				if not v9 then
					if typeof(tbl16) == "table" then
						if #tbl16 <= #tbl5 then
							tbl5 = {}
							return
						end
						local v10 = DetectPartSpawnMob(DetectNameTablePart(tbl16))

						if v10 then
							table.insert(tbl5, DetectNameTablePart(tbl16))

							while true do
								wait()
								ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
								if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl16) or not Settings["Auto Crafting Volcanic Magnet"]) then
									continue
								end
								break
							end

							wait(1)
						end
					end
				else
					while true do
						task.wait()
						SizePart(v9)
						BringMob(v9)
						UsedualFlock()
						ClickM1(v9)

						if Settings["Select Weapon"] == "Blox Fruit" then
							ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end

						if not (not IsMobAlive(v9) or not Settings["Auto Crafting Volcanic Magnet"]) then
							continue
						end
						break
					end
				end

				return
			end

			if not CheckCountItem("Blaze Ember", 15) then
				local dragonHunter = workspace.NPCs:FindFirstChild("Dragon Hunter") or game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Hunter") or NPCManager.getNPCsByName("Dragon Hunter")[1]._modelState._instance

				if not getgenv().QuestHunterDragon then
					if localPlayer:DistanceFromCharacter(dragonHunter.HumanoidRootPart.Position) > 8 then
						ToTarget(dragonHunter.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
					else
						local response = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({ { Context = "Check" } }))

						if not response or response and not response.Text then
							getgenv().QuestHunterDragon = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({ { Context = "RequestQuest" } })).Text
						else
							local text = response.Text
							getgenv().QuestHunterDragon = text
						end
					end
				else
					local v9 = DetectEmberTemplate()

					if v9 then
						Instance.new("IntValue", v9).Name = "Ignored"

						while true do
							wait()
							ToTarget(v9.Part.CFrame)
							if not (not v9 or not v9.Parent) then
								continue
							end
							break
						end

						return
					end

					if string.find(getgenv().QuestHunterDragon, "Hydra Enforcers") then
						local v10 = DetectMob("Hydra Enforcer")

						if not v10 then
							local v11 = DetectPartSpawnMob("Hydra Enforcer", true)

							if v11 then
								Instance.new("IntValue", v11).Name = "Ignored"

								while true do
									wait()
									ToTarget(v11.CFrame * CFrame.new(0, 60, 0))
									if not (localPlayer:DistanceFromCharacter(v11.Position) <= 100 or DetectMob("Hydra Enforcer") or not Settings["Auto Crafting Volcanic Magnet"] or v9) then
										continue
									end
									break
								end

								wait(1)
							else
								DeleteIgnoredMobSpawn()
							end
						else
							while true do
								task.wait()
								SizePart(v10)
								BringMob(v10)
								UsedualFlock()
								ClickM1(v10)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								if not (not IsMobAlive(v10) or not Settings["Auto Crafting Volcanic Magnet"] or v9) then
									continue
								end
								break
							end
						end
					elseif string.find(getgenv().QuestHunterDragon, "Venomous Assailants") then
						local v10 = DetectMob("Venomous Assailant")

						if not v10 then
							local v11 = DetectPartSpawnMob("Venomous Assailant", true)

							if v11 then
								Instance.new("IntValue", v11).Name = "Ignored"

								while true do
									wait()
									ToTarget(v11.CFrame * CFrame.new(0, 60, 0))
									if not (localPlayer:DistanceFromCharacter(v11.Position) <= 100 or DetectMob("Venomous Assailant") or not Settings["Auto Crafting Volcanic Magnet"] or v9) then
										continue
									end
									break
								end

								wait(1)
							else
								DeleteIgnoredMobSpawn()
							end
						else
							while true do
								task.wait()
								SizePart(v10)
								BringMob(v10)
								UsedualFlock()
								ClickM1(v10)

								if Settings["Select Weapon"] == "Blox Fruit" then
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end

								if not (not IsMobAlive(v10) or not Settings["Auto Crafting Volcanic Magnet"] or v9) then
									continue
								end
								break
							end
						end
					elseif string.find(getgenv().QuestHunterDragon, "trees") then
						local v10 = DetectTree()
						local currentCamera = workspace.CurrentCamera

						if v10 then
							Instance.new("IntValue", v10).Name = "Ignored"
							local now = tick()

							while true do
								wait()
								local position = v10.WorldPivot.Position

								if localPlayer:DistanceFromCharacter(position) < 50 then
									AutoAllSkill()
								end

								if v10:FindFirstChild("Meshes/plant1_Icosphere", true) then
									ToTarget(v10.WorldPivot)
									local worldPivot = v10.WorldPivot
									getgenv().AimPos = worldPivot
									replicatedStorage6.Hit = CFrame.new(currentCamera.CFrame.Position, position)
									replicatedStorage6.Target = v10
								else
									local position2 = (v10.WorldPivot * CFrame.new(5, -20, 0)).Position
									local position3 = (v10.WorldPivot * CFrame.new(0, -20, 0)).Position
									ToTarget(CFrame.new(position2))
									getgenv().AimPos = CFrame.new(position3)
									replicatedStorage6.Hit = CFrame.new(currentCamera.CFrame.Position, position3)
									replicatedStorage6.Target = v10
								end

								if not (not v10 or not v10.Parent or not Settings["Auto Crafting Volcanic Magnet"] or v9 or v10:GetAttribute("AlreadyDestroyedClient") or tick() - now >= 15) then
									continue
								end
								break
							end
						end
					end
				end

				return
			end

			if CheckCountItem("Scrap Metal", 10) and CheckCountItem("Blaze Ember", 15) then
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({ "Craft", "Volcanic Magnet", 1, {} }))
				wait(2)
			end
		else
			VxezeNotify("Volcanic Magnet", "Done Craft Volcanic Magnet", "success")
			ToggleAutoCraftingVolcanicMagnet:SetStage(false)
		end
	end

	ToggleAutoCraftingVolcanicMagnet = FarmingVolcanoSection.CreateToggle({
		Title = "Auto Crafting Volcanic Magnet",
		Desc = nil,
		Default = Settings["Auto Crafting Volcanic Magnet"] or false,
	}, function(arg)
		if arg and not Place_Id.sea3() then
			SaveSettings("Auto Crafting Volcanic Magnet", false)
			VxezeNotify("Auto Crafting Volcanic Magnet", "Only works in Sea 3", "warning", { Key = "gateAuto Crafting Volcanic Magnet" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Crafting Volcanic Magnet"] and wait(0.1) do
					pcall(function()
						AutoCraftinMagnetVol()
					end)
				end
			end)
		end

		SaveSettings("Auto Crafting Volcanic Magnet", arg)
	end)

	AutoFindPrehistoric = function()
		if not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
			getgenv().RespawnVolcano = true
			local v9 = CheckBoat()

			if not v9 or v9 and localPlayer:DistanceFromCharacter(v9.VehicleSeat.Position) >= 4000 then
				local cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

				if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
					if localPlayer:DistanceFromCharacter(cframe.Position) > 1000 then
						if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki" then
							localPlayer.Character.Humanoid.Health = 0
							return
						end
					end

					ToTarget(cframe)
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
					wait(3)
				end
			elseif localPlayer.Character.Humanoid.Sit then
				local n = CFrame.new(-118834.515625, 160, -78.950584411621094) * CFrame.new(0, 0, 99999999)
				local cframe = CFrame.new(-32975.9921875, 160, 25963.7109375)
				local flag2

				if Settings["Will Back When over 10km"] then
					if DistanceFindLeviathan() >= 12000 then
						flag2 = true
					elseif DistanceFindLeviathan() <= 4800 then
						flag2 = false
					else
						flag2 = false
					end
				else
					flag2 = false
				end

				while true do
					task.wait(0.5)
					NoclipBoat(v9)

					if Settings["Will Back When over 10km"] then
						if DistanceFindLeviathan() >= 10000 then
							flag2 = true
						elseif DistanceFindLeviathan() <= 4800 then
							flag2 = false
						end

						if flag2 then
							ManageTween(v9.VehicleSeat, cframe, 350, "TweenBoatBack")
						end
					end

					if not flag2 or not Settings["Will Back When over 10km"] then
						ManageTween(v9.VehicleSeat, n, 350, "TweenBoat")
					end

					if not (not Settings["Auto Find Prehistoric Island"] or not localPlayer.Character.Humanoid.Sit or game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")) then
						continue
					end
					break
				end

				if getgenv().TweenBoat then
					getgenv().TweenBoat:Pause()
					getgenv().TweenBoat:Cancel()
				end

				if getgenv().TweenBoatBack then
					getgenv().TweenBoatBack:Pause()
					getgenv().TweenBoatBack:Cancel()
				end
			else
				if getgenv().TweenBoat then
					getgenv().TweenBoat:Pause()
					getgenv().TweenBoat:Cancel()
				end

				if getgenv().TweenBoatBack then
					getgenv().TweenBoatBack:Pause()
					getgenv().TweenBoatBack:Cancel()
				end

				ToTarget(v9.VehicleSeat.CFrame)
			end
		else
			if getgenv().RespawnVolcano and Settings["Webhook Find Prehistoric Island"] then
				getgenv().RespawnVolcano = false
				WebhookFindVolcano()
			end

			if getgenv().TweenBoat then
				getgenv().TweenBoat:Pause()
				getgenv().TweenBoat:Cancel()
			end

			VxezeNotify("Prehistoric Island", "Prehistoric Island Spawned", "found")
			ToggleAutoFindPrehistoricIsland:SetStage(false)
			wait(5)
		end
	end

	ToggleAutoFindPrehistoricIsland = FarmingVolcanoSection.CreateToggle({
		Title = "Auto Find Prehistoric Island",
		Desc = nil,
		Default = Settings["Auto Find Prehistoric Island"] or false,
	}, function(arg)
		if arg and not Place_Id.sea3() then
			SaveSettings("Auto Find Prehistoric Island", false)
			VxezeNotify("Auto Find Prehistoric Island", "Only works in Sea 3", "warning", { Key = "gateAuto Find Prehistoric Island" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Find Prehistoric Island"] and wait(0.1) do
					pcall(function()
						AutoFindPrehistoric()
					end)
				end
			end)
		end

		SaveSettings("Auto Find Prehistoric Island", arg)
	end)

	AutoAttackVolcano = function()
		if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
			if not localPlayer:GetAttribute("CurrentLocation") or localPlayer:GetAttribute("CurrentLocation") ~= "Prehistoric Island" then
				local v9 = DetectNpc("Fossil Expert")
				if v9 then
					ToTarget(v9.HumanoidRootPart.CFrame)
					return
				end
			end

			if DetectLava() then
				local v9 = next
				local descendants, v10 = workspace.Map.PrehistoricIsland:GetDescendants()

				for _, v11 in v9, descendants, v10 do
					if v11.Name == "TouchInterest" and v11.Parent.Name ~= "TrialTeleport" then
						v11:Destroy()
					end
				end
			end

			if #workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren() > 0 then
				DeleteLava()
			end

			if not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
				if workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt") and workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt") then
					ToTarget(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)

					if localPlayer:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.Position) < 8 then
						fireproximityprompt(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt, 1)
						wait(3)
					end

					return
				end

				if not workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt") and not workspace.Map.PrehistoricIsland.Core:FindFirstChild("FossilExpertSpawn") then
					local v9 = DetectNpc("Fossil Expert")
					if v9 then
						ToTarget(v9.HumanoidRootPart.CFrame)
						return
					end
				end
			else
				if flag then
					local skull = workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull

					while true do
						task.wait()
						ToTarget(skull.CFrame)
						if not (localPlayer:DistanceFromCharacter(skull.Position) <= 200 or DetectGolem() or DetectRockVolcano()) then
							continue
						end
						break
					end

					flag = false
					return
				end

				local v9 = DetectGolem()

				if v9 then
					while true do
						task.wait()
						ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(0, 20, 7))

						if Settings["Select Method Kill Golem"] == "Instant Kill [ Risk and can bug no die mob ]" then
							if localPlayer:DistanceFromCharacter(v9.HumanoidRootPart.Position) < 50 then
								KillRaidEnemy()
							end
						else
							EquipTool(NameWeapon(Settings["Select Weapon Kill Golem"] or "Melee"))
							getgenv().ClickM1Volcano(v9)
						end

						KillAuraTick()
						if not (not IsMobAlive(v9) or not Settings["Auto Event Prehistoric Island"]) then
							continue
						end
						break
					end
				end

				local v10 = DetectRockVolcano()

				if v10 then
					if Settings["Fix Volcano Safe"] then
						local v11 = DetectPositionVolcano()
						local v12, v13 = CheckPosnearRock(v11, localPlayer.Character.HumanoidRootPart)
						local distanceFromCharacter = localPlayer.DistanceFromCharacter
						local v14 = CheckPosnearRock(v11, v10.WorldPivot)

						if distanceFromCharacter(localPlayer, v14) >= 400 then
							n3 = v13 + 1

							if v13 >= 7 then
								n3 = 1
							end

							ToTarget(CFrame.new(v11[n3]))
						else
							local v15 = tbl14[math.floor(v10.WorldPivot.Position.Y)]

							while true do
								task.wait()

								if localPlayer:DistanceFromCharacter((v10.WorldPivot * v15).Position) > 8 then
									ToTarget(v10.WorldPivot * v15)
								end

								if localPlayer:DistanceFromCharacter(v10.WorldPivot.Position) < 100 then
									AutoUseSkillFixLava()
								end

								local worldPivot = v10.WorldPivot
								getgenv().AimPos = worldPivot
								replicatedStorage6.Hit = v10.WorldPivot
								replicatedStorage6.Target = v10
								if not (not v10 or not v10.Parent or not Settings["Auto Event Prehistoric Island"] or not v10.VFXLayer.Specs.Enabled or DetectGolem()) then
									continue
								end
								break
							end

							if not DetectGolem() then
								flag = true
							end

							wait(1)
						end
					else
						local v11 = tbl14[math.floor(v10.WorldPivot.Position.Y)]

						while true do
							task.wait()

							if localPlayer:DistanceFromCharacter((v10.WorldPivot * v11).Position) > 8 then
								ToTarget(v10.WorldPivot * v11)
							end

							if localPlayer:DistanceFromCharacter(v10.WorldPivot.Position) < 100 then
								AutoUseSkillFixLava()
							end

							local worldPivot = v10.WorldPivot
							getgenv().AimPos = worldPivot
							replicatedStorage6.Hit = v10.WorldPivot
							replicatedStorage6.Target = v10
							if not (not v10 or not v10.Parent or not Settings["Auto Event Prehistoric Island"] or not v10.VFXLayer.Specs.Enabled or DetectGolem()) then
								continue
							end
							break
						end

						if not DetectGolem() then
							flag = true
						end
					end
				end
			end
		end
	end

	FarmingVolcanoSection.CreateToggle({
		Title = "Auto Event Prehistoric Island",
		Desc = "auto Start Event and Auto kill golem, Auto Fix Volcano",
		Default = Settings["Auto Event Prehistoric Island"] or false,
	}, function(arg)
		if arg and not Place_Id.sea3() then
			SaveSettings("Auto Event Prehistoric Island", false)
			VxezeNotify("Auto Event Prehistoric Island", "Only works in Sea 3", "warning", { Key = "gateAuto Event Prehistoric Island" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Event Prehistoric Island"] and wait(0.1) do
					local ok, result = pcall(function()
						AutoAttackVolcano()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Auto Event Prehistoric Island", arg)
	end)

	DetectBone = function()
		for _, v9 in game.workspace:GetChildren() do
			if v9.Name == "DinoBone" then
				return v9
			end
		end
	end

	FarmingVolcanoSection.CreateToggle({ Title = "Auto Collect Bone", Desc = nil, Default = Settings["Auto Collect Bone"] or false }, function(arg)
		if arg and not Place_Id.sea3() then
			SaveSettings("Auto Collect Bone", false)
			VxezeNotify("Auto Collect Bone", "Only works in Sea 3", "warning", { Key = "gateAuto Collect Bone" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Collect Bone"] and wait(0.1) do
					pcall(function()
						local v9 = DetectBone()

						if v9 and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
							ToTarget(v9.CFrame)
						end
					end)
				end
			end)
		end

		SaveSettings("Auto Collect Bone", arg)
	end)

	DetectDragonEggs = function()
		if #workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetChildren() > 0 then
			for _, v9 in workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetChildren() do
				if v9.Name == "DragonEgg" and v9:FindFirstChild("Molten") and v9.Molten:FindFirstChild("ProximityPrompt") then
					return v9
				end
			end
		end
	end

	FarmingVolcanoSection.CreateToggle({ Title = "Auto Collect Egg", Desc = nil, Default = Settings["Auto Collect Egg"] or false }, function(arg)
		if arg and not Place_Id.sea3() then
			SaveSettings("Auto Collect Egg", false)
			VxezeNotify("Auto Collect Egg", "Only works in Sea 3", "warning", { Key = "gateAuto Collect Egg" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Auto Collect Egg"] and wait(0.1) do
					pcall(function()
						local v9 = DetectDragonEggs()

						if v9 then
							if DetectBone() and Settings["Auto Collect Bone"] then
								return
							end
							ToTarget(v9.Molten.CFrame)

							if localPlayer:DistanceFromCharacter(v9.Molten.Position) < 8 then
								fireproximityprompt(v9.Molten.ProximityPrompt)
							end
						end
					end)
				end
			end)
		end

		SaveSettings("Auto Collect Egg", arg)
	end)

	FullyEventVolcano = function()
		if not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
			getgenv().RespawnVolcano = true
			getgenv().turnoffnoclipBoatt = true

			if not CheckItemInventory("Volcanic Magnet") and not Settings["Ignore Craft Volcanic Magnet"] then
				if getgenv().dacoMagnet then
					local now = tick()

					while true do
						wait()
						if not (tick() - now >= 5 or game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")) then
							continue
						end
						break
					end

					getgenv().dacoMagnet = false
					return
				end

				if not CheckCountItem("Scrap Metal", 10) then
					local tbl16 = { "Jungle Pirate", "Musketeer Pirate" }
					local v9 = DetectMob(tbl16)

					if not v9 then
						if typeof(tbl16) == "table" then
							if #tbl16 <= #tbl5 then
								tbl5 = {}
								return
							end
							local v10 = DetectPartSpawnMob(DetectNameTablePart(tbl16))

							if v10 then
								table.insert(tbl5, DetectNameTablePart(tbl16))

								while true do
									wait()
									ToTarget(v10.CFrame * CFrame.new(0, 60, 0))
									if not (localPlayer:DistanceFromCharacter(v10.Position) <= 100 or DetectMob(tbl16) or not Settings["Fully Event Prehistoric Island"]) then
										continue
									end
									break
								end

								wait(1)
							end
						end
					else
						while true do
							task.wait()
							SizePart(v9)
							BringMob(v9)
							UsedualFlock()
							ClickM1(v9)
							ToTarget(v9.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							if not (not IsMobAlive(v9) or not Settings["Fully Event Prehistoric Island"]) then
								continue
							end
							break
						end
					end

					return
				end

				if not CheckCountItem("Blaze Ember", 15) then
					local dragonHunter = workspace.NPCs:FindFirstChild("Dragon Hunter") or game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Hunter") or NPCManager.getNPCsByName("Dragon Hunter")[1]._modelState._instance

					if not getgenv().QuestHunterDragon then
						if localPlayer:DistanceFromCharacter(dragonHunter.HumanoidRootPart.Position) > 8 then
							ToTarget(dragonHunter.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
						else
							local response = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({ { Context = "Check" } }))

							if not response or response and not response.Text then
								getgenv().QuestHunterDragon = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({ { Context = "RequestQuest" } })).Text
							else
								local text = response.Text
								getgenv().QuestHunterDragon = text
							end
						end
					else
						local v9 = DetectEmberTemplate()

						if v9 then
							Instance.new("IntValue", v9).Name = "Ignored"

							while true do
								wait()
								ToTarget(v9.Part.CFrame)
								if not (not v9 or not v9.Parent) then
									continue
								end
								break
							end

							return
						end

						if string.find(getgenv().QuestHunterDragon, "Hydra Enforcers") then
							local v10 = DetectMob("Hydra Enforcer")

							if not v10 then
								local v11 = DetectPartSpawnMob("Hydra Enforcer", true)

								if v11 then
									Instance.new("IntValue", v11).Name = "Ignored"

									while true do
										wait()
										ToTarget(v11.CFrame * CFrame.new(0, 60, 0))
										if not (localPlayer:DistanceFromCharacter(v11.Position) <= 100 or DetectMob("Hydra Enforcer") or not Settings["Fully Event Prehistoric Island"] or v9) then
											continue
										end
										break
									end

									wait(1)
								else
									DeleteIgnoredMobSpawn()
								end
							else
								while true do
									task.wait()
									SizePart(v10)
									BringMob(v10)
									UsedualFlock()
									ClickM1(v10)

									if Settings["Select Weapon"] == "Blox Fruit" then
										ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end

									if not (not IsMobAlive(v10) or not Settings["Fully Event Prehistoric Island"] or v9) then
										continue
									end
									break
								end
							end
						elseif string.find(getgenv().QuestHunterDragon, "Venomous Assailants") then
							local v10 = DetectMob("Venomous Assailant")

							if not v10 then
								local v11 = DetectPartSpawnMob("Venomous Assailant", true)

								if v11 then
									Instance.new("IntValue", v11).Name = "Ignored"

									while true do
										wait()
										ToTarget(v11.CFrame * CFrame.new(0, 60, 0))
										if not (localPlayer:DistanceFromCharacter(v11.Position) <= 100 or DetectMob("Venomous Assailant") or not Settings["Fully Event Prehistoric Island"] or v9) then
											continue
										end
										break
									end

									wait(1)
								else
									DeleteIgnoredMobSpawn()
								end
							else
								while true do
									task.wait()
									SizePart(v10)
									BringMob(v10)
									UsedualFlock()
									ClickM1(v10)
									ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									if not (not IsMobAlive(v10) or not Settings["Fully Event Prehistoric Island"] or v9) then
										continue
									end
									break
								end
							end
						elseif string.find(getgenv().QuestHunterDragon, "trees") then
							local currentCamera = workspace.CurrentCamera
							local v10 = DetectTree()

							if v10 then
								Instance.new("IntValue", v10).Name = "Ignored"
								local now = tick()

								while true do
									wait()
									local position = v10.WorldPivot.Position

									if localPlayer:DistanceFromCharacter(position) < 50 then
										AutoAllSkill()
									end

									if v10:FindFirstChild("Meshes/plant1_Icosphere", true) then
										ToTarget(v10.WorldPivot)
										local worldPivot = v10.WorldPivot
										getgenv().AimPos = worldPivot
										replicatedStorage6.Hit = CFrame.new(currentCamera.CFrame.Position, position)
										replicatedStorage6.Target = v10
									else
										local position2 = (v10.WorldPivot * CFrame.new(5, -20, 0)).Position
										local position3 = (v10.WorldPivot * CFrame.new(0, -20, 0)).Position
										ToTarget(CFrame.new(position2))
										getgenv().AimPos = CFrame.new(position3)
										replicatedStorage6.Hit = CFrame.new(currentCamera.CFrame.Position, position3)
										replicatedStorage6.Target = v10
									end

									if not (not v10 or not v10.Parent or not Settings["Fully Event Prehistoric Island"] or v9 or v10:GetAttribute("AlreadyDestroyedClient") or tick() - now >= 15) then
										continue
									end
									break
								end
							end
						end
					end

					return
				end

				if CheckCountItem("Scrap Metal", 10) and CheckCountItem("Blaze Ember", 15) then
					game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({ "Craft", "Volcanic Magnet", 1, {} }))
					wait(2)
				end
			else
				getgenv().dacoMagnet = true

				if not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
					local v9 = CheckBoat()

					if not v9 or v9 and localPlayer:DistanceFromCharacter(v9.VehicleSeat.Position) >= 4000 then
						local cframe = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

						if localPlayer:DistanceFromCharacter(cframe.Position) > 8 then
							if localPlayer:DistanceFromCharacter(cframe.Position) > 1000 then
								if not localPlayer:GetAttribute("CurrentLocation") or localPlayer:GetAttribute("CurrentLocation") ~= "Tiki Outpost" then
									if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki" or game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki2" then
										localPlayer.Character.Humanoid.Health = 0
										return
									end
								end
							end

							ToTarget(cframe)
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
							wait(3)
						end
					elseif localPlayer.Character.Humanoid.Sit then
						task.spawn(function()
							NoclipBoat(v9)
						end)

						ManageTween(v9.VehicleSeat, CFrame.new(-118834.515625, v9.WorldPivot.Y, -78.950584411621094) * CFrame.new(0, 0, 99999999), 350, "TweenBoat")
					else
						if getgenv().TweenBoat then
							getgenv().TweenBoat:Pause()
							getgenv().TweenBoat:Cancel()
						end

						ToTarget(v9.VehicleSeat.CFrame)
					end
				end
			end
		else
			if getgenv().turnoffnoclipBoatt then
				getgenv().turnoffnoclipBoatt = false
				local v9 = CheckBoat()

				if v9 then
					TurnOffNoclipBoat(v9)
				end
			end

			if getgenv().RespawnVolcano and Settings["Webhook Find Prehistoric Island"] then
				getgenv().RespawnVolcano = false
				WebhookFindVolcano()
			end

			if getgenv().TweenBoat then
				getgenv().TweenBoat:Pause()
				getgenv().TweenBoat:Cancel()
			end

			if not localPlayer:GetAttribute("CurrentLocation") or localPlayer:GetAttribute("CurrentLocation") ~= "Prehistoric Island" then
				local v9 = DetectNpc("Fossil Expert")
				if v9 then
					ToTarget(v9.HumanoidRootPart.CFrame)
					return
				end
			end

			local v9 = DetectDragonEggs()

			if v9 then
				ToTarget(v9.Molten.CFrame)

				if localPlayer:DistanceFromCharacter(v9.Molten.Position) < 8 then
					fireproximityprompt(v9.Molten.ProximityPrompt)
				end

				return
			end

			if not Settings["Ignore Collect Bone"] then
				local v10 = DetectBone()
				if v10 and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
					ToTarget(v10.CFrame)
					return
				end
			end

			if localPlayer:GetAttribute("CurrentLocation") == "Prehistoric Island" and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and getgenv().CanReset then
				local now = tick()

				while true do
					wait()
					if not (tick() - now >= 10 or not Settings["Fully Event Prehistoric Island"] or DetectBone() and not Settings["Ignore Collect Bone"] or DetectDragonEggs()) then
						continue
					end
					break
				end

				local flag2 = Settings["Fully Event Prehistoric Island"] and not DetectDragonEggs()

				if flag2 then
					flag2 = not DetectBone() and not Settings["Ignore Collect Bone"] or Settings["Ignore Collect Bone"]
				end

				if flag2 then
					localPlayer.Character.Humanoid.Health = 0
					getgenv().CanReset = false
				end
			end

			if DetectLava() then
				local v10 = next
				local descendants, v11 = workspace.Map.PrehistoricIsland:GetDescendants()

				for _, v12 in v10, descendants, v11 do
					if v12.Name == "TouchInterest" and v12.Parent.Name ~= "TrialTeleport" then
						v12:Destroy()
					end
				end
			end

			if #workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren() > 0 then
				DeleteLava()
			end

			if not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
				if workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt") and workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt") then
					ToTarget(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)

					if localPlayer:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.Position) < 8 then
						fireproximityprompt(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt, 1)
						wait(3)
					end

					return
				end

				if not workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt") and not workspace.Map.PrehistoricIsland.Core:FindFirstChild("FossilExpertSpawn") then
					local v10 = DetectNpc("Fossil Expert")
					if v10 then
						ToTarget(v10.HumanoidRootPart.CFrame)
						return
					end
				end
			else
				getgenv().CanReset = true

				if flag then
					local skull = workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull

					while true do
						task.wait()
						ToTarget(skull.CFrame)
						if not (localPlayer:DistanceFromCharacter(skull.Position) <= 200 or DetectGolem() or DetectRockVolcano()) then
							continue
						end
						break
					end

					flag = false
					return
				end

				local v10 = DetectGolem()

				if v10 then
					while true do
						task.wait()
						ToTarget(v10.HumanoidRootPart.CFrame * CFrame.new(0, 20, 7))

						if Settings["Select Method Kill Golem"] == "Instant Kill [ Risk and can bug no die mob ]" then
							if localPlayer:DistanceFromCharacter(v10.HumanoidRootPart.Position) < 50 then
								KillRaidEnemy()
							end
						else
							EquipTool(NameWeapon(Settings["Select Weapon Kill Golem"] or "Melee"))
							getgenv().ClickM1Volcano(v10)
						end

						KillAuraTick()
						if not (not IsMobAlive(v10) or not Settings["Fully Event Prehistoric Island"]) then
							continue
						end
						break
					end
				end

				local v11 = DetectRockVolcano()

				if v11 then
					if Settings["Fix Volcano Safe"] then
						local v12 = DetectPositionVolcano()
						local v13, v14 = CheckPosnearRock(v12, localPlayer.Character.HumanoidRootPart)
						local distanceFromCharacter = localPlayer.DistanceFromCharacter
						local v15 = CheckPosnearRock(v12, v11.WorldPivot)

						if distanceFromCharacter(localPlayer, v15) >= 400 then
							n3 = v14 + 1

							if v14 >= 7 then
								n3 = 1
							end

							ToTarget(CFrame.new(v12[n3]))
						else
							local v16 = tbl14[math.floor(v11.WorldPivot.Position.Y)]

							while true do
								task.wait()

								if localPlayer:DistanceFromCharacter((v11.WorldPivot * v16).Position) > 8 then
									ToTarget(v11.WorldPivot * v16)
								end

								if localPlayer:DistanceFromCharacter(v11.WorldPivot.Position) < 100 then
									AutoUseSkillFixLava()
								end

								local worldPivot = v11.WorldPivot
								getgenv().AimPos = worldPivot
								replicatedStorage6.Hit = v11.WorldPivot
								replicatedStorage6.Target = v11
								if not (not v11 or not v11.Parent or not Settings["Fully Event Prehistoric Island"] or not v11.VFXLayer.Specs.Enabled or DetectGolem()) then
									continue
								end
								break
							end

							if not DetectGolem() then
								flag = true
							end

							wait(1)
						end
					else
						local v12 = tbl14[math.floor(v11.WorldPivot.Position.Y)]

						while true do
							task.wait()

							if localPlayer:DistanceFromCharacter((v11.WorldPivot * v12).Position) > 8 then
								ToTarget(v11.WorldPivot * v12)
							end

							if localPlayer:DistanceFromCharacter(v11.WorldPivot.Position) < 100 then
								AutoUseSkillFixLava()
							end

							local worldPivot = v11.WorldPivot
							getgenv().AimPos = worldPivot
							replicatedStorage6.Hit = v11.WorldPivot
							replicatedStorage6.Target = v11
							if not (not v11 or not v11.Parent or not Settings["Fully Event Prehistoric Island"] or not v11.VFXLayer.Specs.Enabled or DetectGolem()) then
								continue
							end
							break
						end

						if not DetectGolem() then
							flag = true
						end
					end
				end
			end
		end
	end

	FullyVolcanoSection = VolcanoTab.CreateSection("Fully Volcano")

	FullyVolcanoSection.CreateToggle({
		Title = "Ignore Craft Volcanic Magnet [ Fully ]",
		Desc = nil,
		Default = Settings["Ignore Craft Volcanic Magnet"] or false,
	}, function(arg)
		SaveSettings("Ignore Craft Volcanic Magnet", arg)
	end)

	FullyVolcanoSection.CreateToggle({
		Title = "Ignore Collect Bone [ Fully ]",
		Desc = nil,
		Default = Settings["Ignore Collect Bone"] or false,
	}, function(arg)
		SaveSettings("Ignore Collect Bone", arg)
	end)

	FullyVolcanoSection.CreateToggle({
		Title = "Fully Event Prehistoric Island",
		Desc = nil,
		Default = Settings["Fully Event Prehistoric Island"] or false,
	}, function(arg)
		if arg and not Place_Id.sea3() then
			SaveSettings("Fully Event Prehistoric Island", false)
			VxezeNotify("Fully Event Prehistoric Island", "Only works in Sea 3", "warning", { Key = "gateFully Event Prehistoric Island" })
			return
		end

		if arg then
			spawn(function()
				while Settings["Fully Event Prehistoric Island"] and task.wait(0.1) do
					local ok, result = pcall(function()
						FullyEventVolcano()
					end)

					if result then
						PrintOnce(result)
					end
				end
			end)
		end

		SaveSettings("Fully Event Prehistoric Island", arg)
	end)

	ESPTab = Main.CreatePage({ Page_Name = "ESP", Page_Title = "ESP Tab" })
	ESPSection = ESPTab.CreateSection("ESP")

	EspSpawnBerry = function()
		local v9, v10 = DetectBerryESP()

		if v9 then
			local intValue = Instance.new("IntValue", v9.Parent)
			intValue.Name = "Ignored"
			local text = Drawing.new("Text")
			text.Visible = false
			text.Transparency = 1
			text.Text = v9.Name
			text.Color = Color3.fromRGB(255, 255, 255)
			text.Size = 20
			text.Outline = true
			text.OutlineColor = Color3.fromRGB(0, 0, 0)
			text.Center = true
			text.Font = 1

			spawn(function()
				while true do
					task.wait()
					local v11, v12 = game.workspace.CurrentCamera:WorldToViewportPoint(v9.Parent.WorldPivot.Position)

					if v12 then
						text.Text = v10 .. " (" .. math.round(localPlayer:DistanceFromCharacter(v9.Parent.WorldPivot.Position)) .. ")"
						text.Position = Vector2.new(v11.X, v11.Y - 20)
						text.Visible = true
					else
						text.Visible = false
					end

					if not (not v9 or not v9.Parent or not Settings["ESP Berry"] or not DetectBerryCFrame(v9:GetAttributes())) then
						continue
					end
					break
				end

				text:Remove()

				if v9.Parent then
					intValue:Destroy()
				end
			end)
		end
	end

	DetectIsland = function()
		local v9 = next
		local children, v10 = workspace._WorldOrigin.Locations:GetChildren()

		for _, v11 in v9, children, v10 do
			if v11 and v11:GetAttribute("CFrame") and not v11:FindFirstChild("Ignored") then
				return v11
			end
		end
	end

	EspIsland = function()
		local v9 = DetectIsland()

		if v9 then
			local intValue = Instance.new("IntValue", v9)
			intValue.Name = "Ignored"
			local text = Drawing.new("Text")
			text.Visible = false
			text.Transparency = 1
			text.Text = v9.Name
			text.Color = Color3.fromRGB(255, 255, 255)
			text.Size = 20
			text.Outline = true
			text.OutlineColor = Color3.fromRGB(0, 0, 0)
			text.Center = true
			text.Font = 1

			spawn(function()
				while true do
					task.wait()
					local v10, v11 = game.workspace.CurrentCamera:WorldToViewportPoint(v9:GetAttribute("CFrame").Position)

					if v11 then
						text.Text = v9.Name .. " (" .. math.round(localPlayer:DistanceFromCharacter(v9:GetAttribute("CFrame").Position)) .. ")"
						text.Position = Vector2.new(v10.X, v10.Y - 20)
						text.Visible = true
					else
						text.Visible = false
					end

					if not (not v9 or not v9.Parent or not Settings["ESP Island"]) then
						continue
					end
					break
				end

				text:Remove()

				if v9.Parent then
					intValue:Destroy()
				end
			end)
		end
	end

	GetEspFruit = function()
		local v9 = next
		local children, v10 = game.Workspace:GetChildren()

		for _, v11 in v9, children, v10 do
			if (v11:IsA("Tool") or v11:IsA("Model")) and string.find(v11.Name, "Fruit") and v11:FindFirstChild("Handle") and not v11.Handle:FindFirstChild("Ignored") then
				return v11
			end
		end
	end

	local tbl16 = {
		["rbxassetid://15100283484"] = "Light Fruit",
		["rbxassetid://15116730102"] = "Love Fruit",
		["rbxassetid://15100273645"] = "Dough Fruit",
		["rbxassetid://15116967784"] = "Spider Fruit",
		["rbxassetid://15112263502"] = "Shadow Fruit",
		["rbxassetid://15104782377"] = "Blade Fruit",
		["rbxassetid://15060012861"] = "Rocket Fruit",
		["rbxassetid://15106768588"] = "Leopard Fruit",
		["rbxassetid://15112469964"] = "Falcon Fruit",
		["rbxassetid://15708895165"] = "T-Rex Fruit",
		["rbxassetid://19001642259"] = "Dragon (East) Fruit",
		["rbxassetid://86024571204851"] = "Gas Fruit",
		["rbxassetid://15100246632"] = "Phoenix Fruit",
		["rbxassetid://14661873358"] = "Sound Fruit",
		["rbxassetid://15111584216"] = "Flame Fruit",
		["rbxassetid://15105281957"] = "Spring Fruit",
		["rbxassetid://15116740364"] = "Bomb Fruit",
		["rbxassetid://15104817760"] = "Rubber Fruit",
		["rbxassetid://15057683975"] = "Spin Fruit",
		["rbxassetid://15105350415"] = "Magma Fruit",
		["rbxassetid://15482881956"] = "Kitsune Fruit",
		["rbxassetid://15100485671"] = "Barrier Fruit",
		["rbxassetid://18955022385"] = "Dragon (West) Fruit",
		["rbxassetid://101378450824208"] = "Yeti Fruit",
		["rbxassetid://15116721173"] = "Pain Fruit",
		["https://assetdelivery.roblox.com/v1/asset/?id=10395893751"] = "Venom Fruit",
		["rbxassetid://11908375285"] = "Spirit Fruit",
		["rbxassetid://15100433167"] = "Ice Fruit",
		["rbxassetid://15100299740"] = "Gravity Fruit",
		["rbxassetid://15107005807"] = "Spike Fruit",
		["rbxassetid://15116696973"] = "Smoke Fruit",
		["rbxassetid://15112600534"] = "Diamond Fruit",
		["rbxassetid://15112333093"] = "Ghost Fruit",
		["rbxassetid://15057718441"] = "Quake Fruit",
		["rbxassetid://15111517529"] = "Sand Fruit",
		["rbxassetid://15100313696"] = "Buddha Fruit",
		["rbxassetid://15116747420"] = "Rumble Fruit",
		["rbxassetid://15100384816"] = "Blizzard Fruit",
		["rbxassetid://15111553409"] = "Dark Fruit",
		["rbxassetid://14661837634"] = "Mammoth Fruit",
		["rbxassetid://15100184583"] = "Control Fruit",
	}

	GetFruitName = function(arg, arg2)
		if arg.ClassName == "Tool" then
			return arg.Name
		end
		local tbl17 = {}

		for _, descendant in pairs(arg:GetDescendants()) do
			if descendant:IsA("MeshPart") then
				table.insert(tbl17, descendant.MeshId)
			end
		end

		local str2 = "Fruit"

		for k, v9 in pairs(tbl16) do
			if table.find(tbl17, k) then
				str2 = v9
			end
		end

		local str3 = str2

		if str3 == "Fruit " then
			local fruit = arg:FindFirstChild("Fruit")

			if fruit then
				if fruit:FindFirstChild("Retopo_Cube.001") then
					str3 = "Spirit Fruit"
				elseif fruit:FindFirstChild("Gravity cube.026") then
					if fruit:FindFirstChild("Gravity cube.001") then
						str3 = "Blizzard Fruit"
					else
						str3 = "Portal Fruit"
					end
				elseif fruit:FindFirstChild("Cube.011") then
					str3 = "Rubber Fruit"
				end
			end
		end

		if arg2 then
			str3 = "[Natural Spawn]\n" .. str3
		end

		return str3
	end

	EspFruit = function()
		local v9 = GetEspFruit()
		if not v9 then
			return
		end
		local v10 = GetFruitName(v9)
		local handle = v9:FindFirstChild("Handle")
		if not handle then
			return
		end
		local intValue = Instance.new("IntValue")
		intValue.Name = "Ignored"
		intValue.Parent = handle

		local color = ({
			["Leopard Fruit"] = Color3.fromRGB(255, 170, 0),
			["Dragon (East) Fruit"] = Color3.fromRGB(255, 0, 0),
			["Dragon (West) Fruit"] = Color3.fromRGB(255, 80, 80),
			["Kitsune Fruit"] = Color3.fromRGB(200, 100, 255),
			["Spirit Fruit"] = Color3.fromRGB(120, 200, 255),
			["Venom Fruit"] = Color3.fromRGB(180, 60, 200),
			["Dough Fruit"] = Color3.fromRGB(255, 220, 180),
			["Light Fruit"] = Color3.fromRGB(255, 255, 150),
		})[v10] or Color3.fromRGB(255, 255, 255)

		local text = Drawing.new("Text")
		text.Visible = false
		text.Transparency = 1
		text.Text = v10
		text.Color = color
		text.Size = 20
		text.Outline = true
		text.OutlineColor = Color3.fromRGB(0, 0, 0)
		text.Center = true
		text.Font = 2
		local square = Drawing.new("Square")
		square.Visible = false
		square.Filled = true
		square.Color = Color3.fromRGB(0, 0, 0)
		square.Transparency = 0.4

		spawn(function()
			while true do
				task.wait()

				if handle then
					local v11, v12 = workspace.CurrentCamera:WorldToViewportPoint(handle.Position)

					if v12 then
						text.Text = v10 .. " [" .. math.round(localPlayer:DistanceFromCharacter(handle.Position)) .. "m]"
						text.Position = Vector2.new(v11.X, v11.Y - 20)
						text.Color = color
						text.Visible = true
						local textBounds = text.TextBounds
						square.Position = Vector2.new(text.Position.X - textBounds.X / 2 - 4, text.Position.Y - 2)
						square.Size = Vector2.new(textBounds.X + 8, textBounds.Y + 4)
						square.Visible = true
					else
						text.Visible = false
						square.Visible = false
					end
				end

				if not (not v9 or not v9.Parent or not handle.Parent or not Settings["ESP Fruit"]) then
					continue
				end
				break
			end

			text:Remove()
			square:Remove()

			if handle:FindFirstChild("Ignored") then
				handle.Ignored:Destroy()
			end
		end)
	end

	DetectPlayerESP = function()
		for _, child in pairs(game.Workspace.Characters:GetChildren()) do
			if child.Name ~= localPlayer.Name and not child:FindFirstChild("Ignored") then
				return child
			end
		end
	end

	ESPPlayer = function()
		local v9 = DetectPlayerESP()

		if v9 then
			local intValue = Instance.new("IntValue", v9)
			intValue.Name = "Ignored"
			local text = Drawing.new("Text")
			text.Visible = false
			text.Transparency = 1
			text.Text = v9.Name
			text.Color = Color3.fromRGB(255, 255, 255)
			text.Size = 20
			text.Outline = true
			text.OutlineColor = Color3.fromRGB(0, 0, 0)
			text.Center = true
			text.Font = 1

			spawn(function()
				while true do
					task.wait()
					local humanoidRootPart = v9:FindFirstChild("HumanoidRootPart")
					local humanoid = v9:FindFirstChildOfClass("Humanoid")

					if not humanoidRootPart or not humanoid then
						break
					else
						local v10, v11 = game.workspace.CurrentCamera:WorldToViewportPoint(humanoidRootPart.Position)

						if v11 then
							local str2 = ")" .. "\n" .. v9.Humanoid.Health .. " / " .. v9.Humanoid.MaxHealth
							text.Text = v9.Name .. " (" .. math.round(localPlayer:DistanceFromCharacter(v9.HumanoidRootPart.Position)) .. str2
							text.Position = Vector2.new(v10.X, v10.Y - 20)
							text.Visible = true
						else
							text.Visible = false
						end

						if not (not v9 or not v9.Parent or not Settings["ESP Player"]) then
							continue
						end
					end

					break
				end

				text:Remove()

				if v9.Parent then
					intValue:Destroy()
				end
			end)
		end
	end

	EspPanel = {
		{
			Mode = "Toggle",
			Title = "ESP Berry",
			Key = "ESP Berry",
			Fallback = false,
			OnChange = function()
				RunFarmLoop("ESP Berry", 0.2, EspSpawnBerry)
			end,
		},
		{
			Mode = "Toggle",
			Title = "ESP Island",
			Key = "ESP Island",
			Fallback = false,
			OnChange = function()
				RunFarmLoop("ESP Island", 0.2, EspIsland)
			end,
		},
		{
			Mode = "Toggle",
			Title = "ESP Fruit",
			Key = "ESP Fruit",
			Fallback = false,
			OnChange = function()
				RunFarmLoop("ESP Fruit", 0.2, EspFruit)
			end,
		},
		{
			Mode = "Toggle",
			Title = "ESP Player",
			Key = "ESP Player",
			Fallback = false,
			OnChange = function()
				RunFarmLoop("ESP Player", 0.2, ESPPlayer)
			end,
		},
	}

	BuildPanel(ESPSection, "ESP", EspPanel)
	PvpTab = Main.CreatePage({ Page_Name = "PVP", Page_Title = "PVP Tab" })

	TeleportPlayer = function()
		local v9 = pairs
		local Players2 = game:GetService("Players")

		for _, child in v9(Players2:GetChildren()) do
			if child.Name == Settings["Select Player PVP"] then
				return child
			end
		end
	end

	ClosestPartaimbot = function()local n= localPlayer .Character and( localPlayer .Character:FindFirstChild("HumanoidRootPart"));if not n then return nil;end;local L,U=1/0;for w,y in ipairs(game.Workspace.Characters:GetChildren())do w=y:IsA("Model")and(y:FindFirstChild("HumanoidRootPart"));local S=w and(game.Players:FindFirstChild(y.Name));if w and S and y.Name~= localPlayer .Name then if  localPlayer .Team~=game.Teams.Marines or S.Team~=game.Teams.Marines then local c=(n.Position-w.Position).Magnitude;if c<L then L,U=c,y;end;end;end;end;return U;end
	AimbotTarget = function()if Settings["Select Method Aimbot"]=="Select Player"then return game.Workspace.Characters:FindFirstChild(Settings["Select Player PVP"]or"");end;return ClosestPartaimbot();end
	RunAimbot = function()local c=AimbotTarget();local n=c and(c:FindFirstChild("HumanoidRootPart"));if not n then return;end;replicatedStorage6.Hit=n.CFrame;replicatedStorage6.Target=c;getgenv().AimPos=CFrame.new(n.CFrame.p,n.Position+n.Velocity/0.5);end
	RunTeleportPlayer = function()local c=TeleportPlayer();local n=c and c.Character and(c.Character:FindFirstChild("HumanoidRootPart"));if n then ToTarget(n.CFrame);end;end
	EnsureWaterPlatform = function()local c=workspace:FindFirstChild("WaterWalk");if not c then c=Instance.new("Part");c.Name="WaterWalk";c.Size=Vector3.new(80,1,80);c.Transparency=1;c.Anchored=true;c.Parent=workspace;end;return c;end
	RunWalkOnWater = function()local n= localPlayer .Character;local c,L=n and(n:FindFirstChild("HumanoidRootPart")),n and(n:FindFirstChildOfClass("Humanoid"));if not c or not L then return;end;local U,w=EnsureWaterPlatform(),not L.Sit and math.abs(c.Position.Y+60)<=60;if U.CanCollide~=w then U.CanCollide=w;end;n=Vector3.new(c.Position.X,-5,c.Position.Z);if w and(U.Position-n).Magnitude>15 then U.Position=n;end;end

	PvpPanel = {
		{
			Mode = "Dropdown",
			Title = "Select Player PVP",
			Key = "Select Player PVP",
			List = function()
				return DetectNamePlayer()
			end,
			Search = true,
		},
		{
			Mode = "Dropdown",
			Title = "Select Method Aimbot",
			Key = "Select Method Aimbot",
			List = { "Select Player", "Target nearest Player" },
			Search = true,
		},
		{
			Mode = "Button",
			Title = "Refresh Player",
			OnChange = function()
				local selectPlayerPvp = ElementCollection.PVP and ElementCollection.PVP["Select Player PVP"]

				if selectPlayerPvp and selectPlayerPvp.GetNewList then
					selectPlayerPvp:GetNewList(DetectNamePlayer())
				end
			end,
		},
		{
			Mode = "Toggle",
			Title = "Teleport Player",
			Key = "Teleport Player",
			Fallback = false,
			OnChange = function()
				RunFarmLoop("Teleport Player", 0.05, RunTeleportPlayer)
			end,
		},
		{ Mode = "Toggle", Title = "Auto Aimbot", Key = "Auto Aimbot", Fallback = false },
		{ Mode = "Toggle", Title = "Auto Aimbot Gun", Key = "Auto Aimbot Gun", Fallback = false },
	}

	MiscPvpPanel = {
		{
			Mode = "Slider",
			Title = "Input WalkSpeed",
			Key = "Input WalkSpeed",
			Min = 0,
			Max = 500,
			Fallback = 200,
		},
		{
			Mode = "Slider",
			Title = "Input JumpPower",
			Key = "Input JumpPower",
			Min = 0,
			Max = 500,
			Fallback = 200,
		},
		{ Mode = "Toggle", Title = "Change JumpPower", Key = "Change JumpPower", Fallback = false },
		{ Mode = "Toggle", Title = "Change WalkSpeed", Key = "Change WalkSpeed", Fallback = false },
		{
			Mode = "Toggle",
			Title = "Walk On Water",
			Key = "Walk On Water ",
			Fallback = true,
			OnChange = function()
				RunFarmLoop("Walk On Water ", 0.1, RunWalkOnWater)
			end,
		},
	}

	SettingsAimbotSection = PvpTab.CreateSection("PVP")
	BuildPanel(SettingsAimbotSection, "PVP", PvpPanel)
	MISCPVPSection = PvpTab.CreateSection("MISC PVP")
	BuildPanel(MISCPVPSection, "MISC PVP", MiscPvpPanel)
	local getTargetPosition = require(game:GetService("ReplicatedStorage").Modules.CombatUtil).GetTargetPosition

	require(game:GetService("ReplicatedStorage").Modules.CombatUtil).GetTargetPosition = function(arg, arg2, arg3, arg4, arg5)
		if Settings["Auto Aimbot Gun"] then
			local humanoidRootPart = AimbotTarget()
			humanoidRootPart = humanoidRootPart and humanoidRootPart:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				return humanoidRootPart.Position
			end
		end

		return getTargetPosition(arg, arg2, arg3, arg4, arg5)
	end

	TabWebhook = Main.CreatePage({ Page_Name = "Webhook", Page_Title = "Webhook" })
	SectionWebhook = TabWebhook.CreateSection("Webhook")

	SectionWebhook.CreateBox({
		Title = "Input Url Webhook",
		Placeholder = "Type here",
		Number = false,
		Default = Settings["Input Url Webhook"] or nil,
	}, function(arg)
		SaveSettings("Input Url Webhook", arg)
	end)

	SectionWebhook.CreateBox({
		Title = "Input Discord Ping (Everyone/ID)",
		Placeholder = "Type here",
		Number = false,
		Default = Settings["Input Discord Ping"] or nil,
	}, function(arg)
		SaveSettings("Input Discord Ping", arg)
	end)

	SectionWebhook.CreateToggle({ Title = "Ping Everyone/Id Discord", Desc = nil, Default = Settings["Ping Discord"] or false }, function(arg)
		SaveSettings("Ping Discord", arg)
	end)

	local function fn(arg, arg2, arg3, arg4, arg5)
		local tbl17 = {}
		local tbl18 = {}
		local n = arg
		local n4 = arg2
		local v9 = arg3
		local v10 = arg4
		local v11 = arg5
		local n5 = 1
		local tbl19 = nil
		local v12 = nil
		local char = nil
		local byte = nil
		local n6 = nil
		local n7 = nil
		local n8 = nil
		local n9 = nil
		local n10 = nil
		local n11 = nil
		local n12 = nil
		local n13 = nil

		while true do
			if n5 <= 31 then
				if n5 <= 15 then
					if n5 <= 7 then
						if n5 <= 3 then
							if n5 <= 1 then
								if n5 <= 0 then
									tbl19 = tbl19[5]
									n5 = 38
								else
									char = string.char
									byte = string.byte

									if n4 == 2 then
										n5 = 36
										n6 = n
									else
										n5 = 57
									end
								end
							elseif n5 <= 2 then
								tbl19 = tbl19[1]
								n5 = 32
							else
								n5 = 24
								n4 = 4225628066614523
								n7 = 1640726024911297
								n8 = 4503599627370496
								n9 = 67108864
								n10 = 17592186044416
								n11 = 66262169
								n12 = 66419657
								tbl19 = { tbl19, 4, 1, 0, nil }
							end
						elseif n5 <= 5 then
							if n5 <= 4 then
								n6 = (n6 - n9) / 2
								n7 = (n7 - n11) / 2
								n9 = n6 % 2
								n11 = n7 % 2

								if n9 ~= n11 then
									n5 = 11
									n8 = 4
								else
									n5 = 7
								end
							else
								tbl19 = tbl19[1]
								n5 = 27
							end
						elseif n5 <= 6 then
							n6 = (n6 - n9) / 2
							n7 = (n7 - n11) / 2
							n9 = n6 % 2
							n11 = n7 % 2

							if n9 ~= n11 then
								n5 = 12
								n8 = 128
							else
								n5 = 35
							end
						else
							n6 = (n6 - n9) / 2
							n7 = (n7 - n11) / 2
							n9 = n6 % 2
							n11 = n7 % 2

							if n9 ~= n11 then
								n5 = 18
								n8 = 8
							else
								n5 = 55
							end
						end
					elseif n5 <= 11 then
						if n5 <= 9 then
							if n5 <= 8 then
								local n14 = n6 * 2 + 1
								local v13 = n7[n14]
								local v14 = n7[n14 + 1]

								if not v13 then
									n5 = 40
								else
									n5 = 37
									n8 = v13
									n9 = v14
								end
							else
								local v13 = tbl19[3]
								local v14 = tbl19[5]
								local n14 = tbl19[2] + v13
								local flag2 = v13 <= 0
								local flag3 = not flag2
								local flag4 = n14 >= v14
								local flag5 = n14 <= v14
								flag2 = flag2 and flag4
								flag3 = flag3 and flag5
								flag3 = flag2 or flag3
								tbl19[2] = n14

								if flag3 then
									n5 = 56
									n8 = n14
								else
									n5 = 54
								end
							end
						elseif n5 <= 10 then
							n10 += n8
							n5 = 6
						else
							n10 += n8
							n5 = 7
						end
					elseif n5 <= 13 then
						if n5 <= 12 then
							n10 += n8
							n5 = 35
						else
							local v13 = tbl19[5]
							local v14 = tbl19[4]
							local n14 = tbl19[2] + v13
							local flag2 = v13 <= 0
							local flag3 = not flag2
							local flag4 = n14 >= v14
							local flag5 = n14 <= v14
							flag4 = flag2 and flag4
							flag4 = flag4 or flag3 and flag5
							tbl19[2] = n14

							if flag4 then
								n5 = 16
							else
								n5 = 2
							end
						end
					elseif n5 <= 14 then
						tbl19 = tbl19[2]
						n5 = 36
					else
						n10 += n8
						n5 = 63
					end

					continue
				end

				if n5 <= 23 then
					if n5 <= 19 then
						if n5 <= 17 then
							if n5 <= 16 then
								n6 = (n8 * n6 + n9) % 4294967296
								n13 ..= n10[1 + (n6 - n6 % 268435456) / 268435456 % 16]
								n5 = 13
								continue
							end

							return nil
						end

						if n5 <= 18 then
							n10 += n8
							n5 = 55
						else
							n = (n + tbl18[n4] + n6[n4 % 32 + 1]) % 256
							local v13 = tbl18[n4]
							tbl18[n4] = tbl18[n]
							tbl18[n] = v13
							n5 = 25
						end

						continue
					end

					if n5 <= 21 then
						if n5 <= 20 then
							local v13 = tbl19[1]
							local v14 = tbl19[5]
							local n14 = tbl19[4] + v13
							local flag2 = v13 <= 0
							local flag3 = not flag2
							local flag4 = n14 >= v14
							local flag5 = n14 <= v14
							flag4 = flag2 and flag4
							flag4 = flag4 or flag3 and flag5
							tbl19[4] = n14

							if flag4 then
								n5 = 8
								n6 = n14
							else
								n5 = 59
							end
						else
							n5 = 25
							n = 0
							tbl19 = { 1, 255, nil, -1, tbl19 }
						end
					elseif n5 <= 22 then
						n[n6] = n8
						n[52] = 4
						n[99] = 12
						n[51] = 3
						n[65] = 10
						n[48] = 0
						n[101] = 14
						n[54] = 6
						n5 = 28
						n6 = 49
						n8 = 1
					else
						n = (n - n13) / 65536
						local n14 = (n4 + n13) % n8
						local n15 = n14 % n9
						n4 = ((((n14 - n15) / n9 * n11 + n15 * n12) % n9 * n9 + n15 * n11) % n8 + n7) % n8
						n5 = 24
					end

					continue
				end

				if n5 <= 27 then
					if n5 <= 25 then
						if n5 <= 24 then
							local v13 = tbl19[3]
							local v14 = tbl19[2]
							local n14 = tbl19[4] + v13
							local flag2 = v13 <= 0
							local flag3 = flag2 and n14 >= v14 or not flag2 and n14 <= v14
							tbl19[4] = n14

							if flag3 then
								n5 = 31
								n13 = n14
							else
								n5 = 5
							end
						else
							local v13 = tbl19[1]
							local v14 = tbl19[2]
							local n14 = tbl19[4] + v13
							local flag2 = v13 <= 0
							local flag3 = not flag2
							local flag4 = n14 >= v14
							local flag5 = n14 <= v14
							flag4 = flag2 and flag4
							flag4 = flag4 or flag3 and flag5
							tbl19[4] = n14

							if flag4 then
								n5 = 19
								n4 = n14
							else
								n5 = 51
							end
						end
					elseif n5 <= 26 then
						n7 = {}
						n10 = { "6", "4", "e", "a", "5", "8", "d", "2", "1", "9", "3", "7", "c", "f", "b", "0" }
						n5 = 58
						n6 = 870728320
						n8 = 493413649
						n9 = -405362667
						n11 = 1
						tbl19 = { 0, 1, nil, 128, tbl19 }
					else
						n5 = 49
						tbl19 = { nil, tbl19, 1, 32, 0 }
					end
				elseif n5 <= 29 then
					if n5 <= 28 then
						n[n6] = n8
						n[100] = 13
						n[56] = 8
						n[97] = 10
						n[69] = 14
						n[66] = 11
						n[57] = 9
						n5 = 20
						tbl19 = { 1, tbl19, nil, -1, 31 }
					else
						n10 += n8
						n5 = 4
					end
				elseif n5 <= 30 then
					n4[n6 + 1] = n[n8] * 16 + n[n9]
					n5 = 20
				else
					n13 = n % 65536
					n5 = n13 < 0 and 53 or 45
				end
			else
				if n5 <= 47 then
					if n5 <= 39 then
						if n5 <= 35 then
							if n5 <= 33 then
								if n5 <= 32 then
									byte(n13, 1, 64)
									n5 = n12 == n11 and 34 or 58
								else
									local n14 = n4 % n9
									n4 = ((((n4 - n14) / n9 * n11 + n14 * n12) % n9 * n9 + n14 * n11) % n8 + n7) % n8
									n6[n] = (n4 - n4 % n10) / n10
									n5 = 49
								end
							elseif n5 <= 34 then
								n7 = { byte(n, 1, 64) }
								n5 = 58
							else
								char ..= tbl17[n10]
								n5 = 62
							end
						elseif n5 <= 37 then
							if n5 <= 36 then
								n = n6[3]
								n4 = 4 * n6[1] % 64 + 1
								n7 = 2 * n6[2] % 128 - 1
								n5 = 9
								tbl19 = { nil, -1, 1, tbl19, 255 }
							else
								n5 = not n9 and 17 or 30
							end
						elseif n5 <= 38 then
							n = { [53] = 5, [70] = 15, [68] = 13, [55] = 7, [67] = 12, [50] = 2, [102] = 15 }
							n5 = 22
							n6 = 98
							n8 = 11
						else
							n5 = 13
							n13 = ""
							tbl19 = { tbl19, 0, nil, 64, 1 }
						end

						continue
					end

					if n5 <= 43 then
						if n5 <= 41 then
							if n5 <= 40 then
								return nil
							end
							v10[v11] = char
							n5 = 44
							continue
						end

						if n5 <= 42 then
							n13 -= 65536
							n5 = 23
						else
							n6 = (n6 - n8) / 2
							n7 = (n7 - n9) / 2
							n9 = n6 % 2
							n11 = n7 % 2

							if n9 ~= n11 then
								n5 = 29
								n8 = 2
							else
								n5 = 4
							end
						end

						continue
					end

					if n5 <= 45 then
						if n5 <= 44 then
							break
						end
						n5 = n13 >= 65536 and 42 or 23
						continue
					end

					if n5 <= 46 then
						n = (n + 1) % 256
						n4 = (n4 + tbl18[n]) % 256
						local v13 = tbl18[n]
						tbl18[n] = tbl18[n4]
						tbl18[n4] = v13
						local v14 = byte(v9, n6)
						n7 = tbl18[(tbl18[n] + tbl18[n4]) % 256]
						n8 = v14 % 2
						n9 = n7 % 2

						if n8 ~= n9 then
							n5 = 48
							n6 = v14
						else
							n5 = 43
							n10 = 0
							n6 = v14
						end
					else
						n6 = (n6 - n9) / 2
						n7 = (n7 - n11) / 2
						n9 = n6 % 2
						n11 = n7 % 2

						if n9 ~= n11 then
							n5 = 15
							n8 = 32
						else
							n5 = 63
						end
					end

					continue
				end

				if n5 <= 55 then
					if n5 <= 51 then
						if n5 <= 49 then
							if n5 <= 48 then
								n5 = 43
								n10 = 1
							else
								local v13 = tbl19[3]
								local v14 = tbl19[4]
								local n14 = tbl19[5] + v13
								local flag2 = v13 <= 0
								local flag3 = not flag2
								local flag4 = n14 >= v14
								local flag5 = n14 <= v14
								flag4 = flag2 and flag4
								flag4 = flag4 or flag3 and flag5
								tbl19[5] = n14

								if flag4 then
									n5 = 33
									n = n14
								else
									n5 = 14
								end
							end
						elseif n5 <= 50 then
							tbl19 = tbl19[3]
							n5 = 41
						else
							tbl19 = tbl19[5]
							n5 = 61
						end
					elseif n5 <= 53 then
						if n5 <= 52 then
							n10 += n8
							n5 = 47
						else
							n13 += 65536
							n5 = 45
						end
					elseif n5 <= 54 then
						tbl19 = tbl19[4]
						n5 = 21
					else
						n6 = (n6 - n9) / 2
						n7 = (n7 - n11) / 2
						n9 = n6 % 2
						n11 = n7 % 2

						if n9 ~= n11 then
							n5 = 52
							n8 = 16
						else
							n5 = 47
						end
					end
				elseif n5 <= 59 then
					if n5 <= 57 then
						if n5 <= 56 then
							tbl17[n] = char(n)
							tbl18[n] = n
							n = (n4 * n + n7) % 256
							n5 = 9
						else
							local tbl20 = {}

							if n4 == 1 then
								n5 = 26
								n4 = tbl20
							else
								n5 = 60
								n6 = tbl20
							end
						end
					elseif n5 <= 58 then
						local v13 = tbl19[2]
						local v14 = tbl19[4]
						local n14 = tbl19[1] + v13
						local flag2 = v13 <= 0
						local flag3 = not flag2
						local flag4 = n14 >= v14
						local flag5 = n14 <= v14
						flag4 = flag2 and flag4
						flag3 = flag3 and flag5
						flag3 = flag4 or flag3
						tbl19[1] = n14

						if flag3 then
							n5 = 39
							n12 = n14
						else
							n5 = 0
						end
					else
						tbl19 = tbl19[2]
						n5 = 36
						n6 = n4
					end
				elseif n5 <= 61 then
					if n5 <= 60 then
						n5 = n4 == 0 and 3 or 36
					else
						n5 = 62
						n = 0
						n4 = 0
						char = ""
						tbl19 = { #v9 + 0, 0, tbl19, 1, nil }
					end
				elseif n5 <= 62 then
					local v13 = tbl19[4]
					local v14 = tbl19[1]
					local n14 = tbl19[2] + v13
					local flag2 = v13 <= 0
					local flag3 = not flag2
					local flag4 = n14 >= v14
					local flag5 = n14 <= v14
					flag4 = flag2 and flag4
					flag4 = flag4 or flag3 and flag5
					tbl19[2] = n14

					if flag4 then
						n5 = 46
						n6 = n14
					else
						n5 = 50
					end
				else
					n6 = (n6 - n9) / 2
					n7 = (n7 - n11) / 2
					n9 = n6 % 2
					n11 = n7 % 2

					if n9 ~= n11 then
						n5 = 10
						n8 = 64
					else
						n5 = 6
					end
				end
			end
		end
	end

	fn(502333065526021, 0, "\141'[\159\20\16V\185\248b\2173D\248\248\230/\131Y٧\135x V\232\253ڻ[\153a\186w\t\230\153a\192\138\151;,\4\143\195\238qT\232!9<\212mt\247QII\16\146[\186wSI\179\248\202H\146\"5\170\211\252^^\128u\8^\128\213\209\192!\3\200&,\168B|\131\160\142\29\19?\20\165\23߭\130w\231M\230'\17\250U\247|ô6\2457\144\253ӆ\247\19\139Z\27\177x\198-}\29>\15\28S\219\3\194\25\139\245vm\133\241$\209\27k\167\182\146\206\2\187v93!\199\241\247\19#Z\186\166\170\128#\205K\145N\188\196e\149W\143\27\193\231f\21\143\n\180\174\149C\6\249\182\204\206|\199}\149M\"\143I\132S", nil --[[ the caller's registers ]], 23)
	VxezeWebhookLogo = "\141'[\159\20\16V\185\248b\2173D\248\248\230/\131Y٧\135x V\232\253ڻ[\153a\186w\t\230\153a\192\138\151;,\4\143\195\238qT\232!9<\212mt\247QII\16\146[\186wSI\179\248\202H\146\"5\170\211\252^^\128u\8^\128\213\209\192!\3\200&,\168B|\131\160\142\29\19?\20\165\23߭\130w\231M\230'\17\250U\247|ô6\2457\144\253ӆ\247\19\139Z\27\177x\198-}\29>\15\28S\219\3\194\25\139\245vm\133\241$\209\27k\167\182\146\206\2\187v93!\199\241\247\19#Z\186\166\170\128#\205K\145N\188\196e\149W\143\27\193\231f\21\143\n\180\174\149C\6\249\182\204\206|\199}\149M\"\143I\132S"
	VxezeWebhookInvite = "**dsc.gg/vxezehub**"

	local tbl17 = {
		Username = "W SCRIPT HUB",
		AvatarURL = VxezeWebhookLogo,
		BannerURL = VxezeWebhookLogo,
		Title = "BF - Notification!",
		FooterText = "- Vxeze Hub",
		Content = VxezeWebhookInvite,
		Color = 11400703,
	}

	SafeString = function(arg)
		local ok, result = pcall(function()
			return tostring(arg)
		end)

		return ok and result or "nil"
	end

	GetPingTag = function()
		local ok, result = pcall(function()
			return Settings["Ping Discord"]
		end)

		result = ok and result
		local str2 = ""

		if result then
			local ok2, result2 = pcall(function()
				return Settings["Input Discord Ping"]
			end)

			if ok2 and tonumber(result2) then
				str2 = "<@" .. result2 .. ">"
			else
				str2 = "@everyone"
			end
		end

		return str2
	end

	GetWebhookUrl = function()
		local ok, result = pcall(function()
			return Settings["Input Url Webhook"]
		end)

		return ok and result or nil
	end

	GetWebhookContent = function()
		local v9 = GetPingTag()
		if v9 and v9 ~= "" then
			return v9 .. " " .. VxezeWebhookInvite
		end
		return VxezeWebhookInvite
	end

	GetUtcTimestamp = function()
		return os.date("!%Y-%m-%dT%H:%M:%SZ")
	end

	BuildBaseFields = function(arg, arg2)
		local tbl18 = {}
		local tbl19 = { name = "Event", value = "`" .. SafeString(arg) .. "`", inline = true }
		local tbl20 = { name = "Detail", value = "`" .. SafeString(arg2) .. "`", inline = true }

		local tbl21 = {
			name = "Username",
			value = "||" .. SafeString(localPlayer and localPlayer.Name or "Unknown") .. "||",
			inline = true,
		}

		local tbl22 = { name = "PlaceId", value = "`" .. SafeString(game.PlaceId) .. "`", inline = true }
		local tbl23 = { name = "JobId", value = "`" .. SafeString(game.JobId) .. "`", inline = true }
		tbl18[1] = tbl19
		tbl18[2] = tbl20
		tbl18[3] = tbl21
		tbl18[4] = tbl22
		tbl18[5] = tbl23
		return tbl18
	end

	SendWebhookNotification = function(arg, arg2, arg3, arg4)
		local v9 = GetWebhookUrl()
		if not v9 or v9 == "" then
			return
		end
		local tbl18

		if arg3 then
			tbl18 = {}
			local tbl19 = { name = "Stored Fruit", value = "```" .. SafeString(arg2) .. "```", inline = false }

			local tbl20 = {
				name = "Username",
				value = "||" .. SafeString(localPlayer and localPlayer.Name or "Unknown") .. "||",
				inline = true,
			}

			local tbl21 = { name = "Time", value = os.date("%Y-%m-%d %H:%M:%S"), inline = true }
			local tbl22 = { name = "PlaceId", value = "`" .. SafeString(game.PlaceId) .. "`", inline = true }
			tbl18[1] = tbl19
			tbl18[2] = tbl20
			tbl18[3] = tbl21
			tbl18[4] = tbl22
		else
			tbl18 = BuildBaseFields(arg, arg2)
		end

		local tbl19 = { content = GetWebhookContent(), username = tbl17.Username, avatar_url = tbl17.AvatarURL }

		tbl19.embeds = {
			{
				title = tbl17.Title,
				description = "**Main Status**\nUsername : ||" .. SafeString(localPlayer and localPlayer.Name or "Unknown") .. "||",
				color = tbl17.Color,
				fields = tbl18,
				thumbnail = { url = tbl17.BannerURL },
				footer = { text = tbl17.FooterText .. " : " .. SafeString(arg4 or arg), icon_url = tbl17.AvatarURL },
				timestamp = GetUtcTimestamp(),
			},
		}

		pcall(function()
			ExploitReq({
				Url = v9,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = HttpService:JSONEncode(tbl19),
			})
		end)
	end

	getgenv().WebhookStoreFruit = function(arg)
		SendWebhookNotification("Store Fruit", arg, true, "Webhook Store Fruit")
	end

	WebhookEvents = {
		sent = {},
		list = {
			{
				Name = "Mirage",
				Setting = "Webhook Find Mirage",
				Map = "MysticIsland",
				Location = "Mirage Island",
			},
			{
				Name = "Prehistoric Island",
				Setting = "Webhook Find Prehistoric Island",
				Map = "PrehistoricIsland",
				Location = "Prehistoric Island",
			},
			{
				Name = "Frozen Dimension",
				Setting = "Webhook Find Leviathan",
				Location = "Frozen Dimension",
			},
		},
	}

	IsWorldEventSpawned = function(arg)
		local map = workspace:FindFirstChild("Map")
		local worldOrigin = workspace:FindFirstChild("_WorldOrigin")
		worldOrigin = worldOrigin and worldOrigin:FindFirstChild("Locations")
		return arg.Map and map and map:FindFirstChild(arg.Map) ~= nil or worldOrigin and worldOrigin:FindFirstChild(arg.Location) ~= nil or false
	end

	SendEventWebhook = function(arg)
		if WebhookEvents.sent[arg] then
			return
		end
		WebhookEvents.sent[arg] = true
		local setting = arg

		for _, v9 in ipairs(WebhookEvents.list) do
			if v9.Name == arg then
				setting = v9.Setting
			end
		end

		SendWebhookNotification(arg, "Spawned", false, setting)
	end

	WatchEventWebhooks = function()
		while task.wait(5) do
			pcall(function()
				local v9 = GetWebhookUrl()

				for _, v10 in ipairs(WebhookEvents.list) do
					if not IsWorldEventSpawned(v10) then
						WebhookEvents.sent[v10.Name] = nil
					elseif Settings[v10.Setting] and v9 and v9 ~= "" then
						SendEventWebhook(v10.Name)
					end
				end
			end)
		end
	end

	task.spawn(WatchEventWebhooks)

	getgenv().WebhookFindVolcano = function()
		SendEventWebhook("Prehistoric Island")
	end

	getgenv().WebhookFindLeviathan = function()
		SendEventWebhook("Frozen Dimension")
	end

	getgenv().WebhookFindMirage = function()
		SendEventWebhook("Mirage")
	end

	GetWebhookMelees = function()
		local tbl18 = {}
		local v9 = ipairs
		local tbl19 = GetInventoryItems() or {}

		for _, v10 in v9(tbl19) do
			if v10.Type == "Fighting Style" and v10.Name ~= "Combat" then
				table.insert(tbl18, { Name = v10.Name, Mastery = tonumber(v10.Mastery) or 0 })
			end
		end

		table.sort(tbl18, function(arg, arg2)
			return arg.Mastery > arg2.Mastery
		end)

		for i_, v10 in ipairs(tbl18) do
			tbl18[i_] = v10.Name .. " [" .. v10.Mastery .. "]"
		end

		return tbl18
	end

	GetWebhookInventory = function(arg, arg2)
		local tbl18 = {}
		local tbl19 = {}
		local ok, result = pcall(require, game:GetService("ReplicatedStorage"):WaitForChild("ItemConfig"))
		local v9 = ipairs
		local tbl20 = GetInventoryItems() or {}

		for _, v10 in v9(tbl20) do
			local v11 = tostring(v10.Name or ""):split("-")[1]
			local n = 0

			if ok then
				local ok2, result2 = pcall(function()
					return result.match(v10.ItemId):unwrap()
				end)

				n = ok2 and result2 and result2.Quality and result2.Quality.RarityValue or 0
			end

			local n4 = tonumber(v10.Count) or 1
			local str2 = n4 > 1 and v11 .. " x" .. n4 or v11

			if v10.Type == "Blox Fruit" then
				local v12 = CheckFruitReal(v10.Name)
				local n5 = v12 and tonumber(v12.Price) or 0

				if n5 >= arg or not v12 and n >= arg2 then
					table.insert(tbl18, { Name = str2, Value = n5, Rarity = n })
				end
			elseif (v10.Type == "Sword" or v10.Type == "Gun" or v10.Type == "Accessory") and n >= arg2 then
				table.insert(tbl19, { Name = str2, Rarity = n })
			end
		end

		table.sort(tbl18, function(arg3, arg4)
			if arg3.Value ~= arg4.Value then
				return arg3.Value > arg4.Value
			end
			return arg3.Rarity > arg4.Rarity
		end)

		table.sort(tbl19, function(arg3, arg4)
			if arg3.Rarity ~= arg4.Rarity then
				return arg3.Rarity > arg4.Rarity
			end
			return arg3.Name < arg4.Name
		end)

		return tbl18, tbl19
	end

	getgenv().WebhookDestroyIdk = function()
		SendWebhookNotification("Status", "Can Find Leviathan", false, "Webhook Destroy IDK")
	end

	Webhookprofile = function()
		local tbl18 = {
			Color = 11400703,
			BannerURL = VxezeWebhookLogo,
			AvatarURL = VxezeWebhookLogo,
			Username = "W SCRIPT HUB",
			Title = "BF - Notification!",
			FooterText = "- Vxeze Hub : Noti Profile",
			Content = "**dsc.gg/vxezehub**",
			FruitMinValue = 1000000,
			ItemMinRarity = 3,
			MaxFieldLen = 1024,
			MaxDescLen = 3800,
		}

		local Players2 = game:GetService("Players")
		local HttpService_ = game:GetService("HttpService")
		local commF = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
		local localPlayer2 = Players2.LocalPlayer

		local function fn2(arg)
			local ok, result = pcall(function()
				return tostring(arg)
			end)

			return ok and result or "nil"
		end

		local function fn3(arg, arg2)
			local v9 = fn2(arg or "")
			if #v9 > arg2 then
				return v9:sub(1, arg2 - 3) .. "..."
			end
			return v9
		end

		local function fn4(arg, arg2)
			return "```\n" .. fn3(arg or "", arg2 - 8) .. "\n```"
		end

		local function fn5(arg)
			local tbl19 = {}
			local v9 = ipairs
			local tbl20 = arg or {}

			for _, v10 in v9(tbl20) do
				tbl19[#tbl19 + 1] = fn2(v10.Name or v10)
			end

			return table.concat(tbl19, ",\n")
		end

		local function fn6(arg)
			local tbl19 = {}
			local v9 = ipairs
			local tbl20 = arg or {}

			for _, v10 in v9(tbl20) do
				tbl19[#tbl19 + 1] = fn2(v10)
			end

			return table.concat(tbl19, ",\n")
		end

		local function fn7(...)
			local tbl19 = { ... }

			local ok, result = pcall(function()
				return commF:InvokeServer(unpack(tbl19))
			end)

			if ok then
				return result
			end
			return nil
		end

		local function fn8()
			return os.date("!%Y-%m-%dT%H:%M:%SZ")
		end

		local function fn9()
			local str2 = localPlayer2.Data and localPlayer2.Data.DevilFruit and localPlayer2.Data.DevilFruit.Value or ""
			str2 = str2 ~= "" and str2 or "None"
			local n = 0

			if str2 ~= "None" then
				local character = localPlayer2.Backpack:FindFirstChild(str2) or localPlayer2.Character and localPlayer2.Character:FindFirstChild(str2)

				if character and character:FindFirstChild("Level") then
					n = tonumber(character.Level.Value) or 0
				end
			end

			return str2, n
		end

		local function fn10()
			if not fn7("AwakeningChanger", "Check") then
				return {}
			end
			local getAwakenedAbilities = fn7("getAwakenedAbilities")
			local tbl19 = {}

			if type(getAwakenedAbilities) == "table" then
				for k, getAwakenedAbility in pairs(getAwakenedAbilities) do
					if type(getAwakenedAbility) == "table" and getAwakenedAbility.Awakened then
						table.insert(tbl19, fn2(k))
					end
				end
			end

			table.sort(tbl19)
			return tbl19
		end

		local tbl19 = {
			Name = fn2(localPlayer2 and localPlayer2.Name or "Unknown"),
			Level = localPlayer2.Data and localPlayer2.Data.Level and tonumber(localPlayer2.Data.Level.Value) or 0,
			Race = localPlayer2.Data and localPlayer2.Data.Race and fn2(localPlayer2.Data.Race.Value) or "Unknown",
		}

		local function fn11()
			if localPlayer2.Character and localPlayer2.Character:FindFirstChild("RaceTransformed") then
				return "V4"
			end

			if fn7("Wenlocktoad", "1") == -2 then
				return "V3"
			end

			if fn7("Alchemist", "1") == -2 then
				return "V2"
			end
			return "V1"
		end

		tbl19.RaceVer = "[" .. fn11() .. "]"
		local v9, v10 = fn9()
		tbl19.Fruit = v9
		tbl19.FruitShort = v9 ~= "None" and v9:split("-")[1] or "None"
		tbl19.FruitMastery = v10
		local v11 = fn10()
		local str2 = #v11 > 0 and " " .. table.concat(v11, " ") or ""
		tbl19.FruitText = v9 == "None" and "None" or tbl19.FruitShort .. " [" .. tostring(v10) .. str2 .. "]"
		tbl19.Melees = GetWebhookMelees()
		local v12, v13 = GetWebhookInventory(tbl18.FruitMinValue, tbl18.ItemMinRarity)
		tbl19.InventoryFruit = v12
		tbl19.Inventory = v13
		local n = tbl18.MaxFieldLen - 10
		local v14 = fn3(fn6(tbl19.Melees), n)
		local n4 = tbl18.MaxFieldLen - 10
		local v15 = fn3(fn5(tbl19.InventoryFruit), n4)
		local n5 = tbl18.MaxFieldLen - 10
		local v16 = fn3(fn5(tbl19.Inventory), n5)
		local str3 = ",\n Race : " .. tbl19.Race .. " " .. tbl19.RaceVer .. ",\n Fruits : " .. tbl19.FruitText .. " "
		local v17 = fn4(fn3(" Username : " .. tbl19.Name .. ",\n Level : " .. tostring(tbl19.Level) .. str3, tbl18.MaxDescLen), tbl18.MaxDescLen)
		local tbl20 = { content = GetWebhookContent(), username = tbl18.Username, avatar_url = tbl18.AvatarURL }
		local embeds = {}

		local tbl21 = {
			title = tbl18.Title,
			description = v17,
			color = tonumber(tbl18.Color),
			footer = { text = tbl18.FooterText, icon_url = tbl18.AvatarURL },
		}

		local fields = {}
		local tbl22 = { name = "**Melee**", value = fn4(v14, tbl18.MaxFieldLen), inline = true }
		local tbl23 = { name = "**Inventory Fruit**", value = fn4(v15, tbl18.MaxFieldLen), inline = true }
		local tbl24 = { name = "**Inventory**", value = fn4(v16, tbl18.MaxFieldLen), inline = false }
		fields[1] = tbl22
		fields[2] = tbl23
		fields[3] = tbl24
		tbl21.fields = fields
		tbl21.thumbnail = { url = tbl18.BannerURL }
		tbl21.timestamp = fn8()
		embeds[1] = tbl21
		tbl20.embeds = embeds

		local ok, result = pcall(function()
			return Settings["Input Url Webhook"]
		end)

		if not ok or not result or result == "" then
			return
		end

		pcall(function()
			ExploitReq({
				Url = result,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = HttpService_:JSONEncode(tbl20),
			})
		end)
	end

	SectionWebhook.CreateToggle({ Title = "Noti Profile", Desc = nil, Default = Settings["Noti Profile"] or false }, function(arg)
		if arg then
			spawn(function()
				while Settings["Noti Profile"] and wait(0.1) do
					pcall(function()
						Webhookprofile()
						wait(300)
					end)
				end
			end)
		end

		SaveSettings("Noti Profile", arg)
	end)

	TableRarityFruit = { Mythical = false, Legendary = false, Rare = false, Uncommon = false, Common = false }

	SectionWebhook.CreateDropdown({
		Title = "Select Rarity Fruit",
		List = PrepareMultiSelectList(TableRarityFruit, Settings["Select Rarity Fruit"]),
		Search = true,
		Selected = true,
		Default = Settings["Select Rarity Fruit"] or nil,
	}, function(arg, arg2)
		SaveSettings("Select Rarity Fruit", arg, arg2)
	end)

	SectionWebhook.CreateToggle({ Title = "Webhook Store Fruit", Desc = nil, Default = Settings["Webhook Store Fruit"] or false }, function(arg)
		SaveSettings("Webhook Store Fruit", arg)
	end)

	SectionWebhook.CreateToggle({
		Title = "Webhook Find Prehistoric Island",
		Desc = nil,
		Default = Settings["Webhook Find Prehistoric Island"] or false,
	}, function(arg)
		SaveSettings("Webhook Find Prehistoric Island", arg)
	end)

	SectionWebhook.CreateToggle({
		Title = "Webhook Find Leviathan",
		Desc = nil,
		Default = Settings["Webhook Find Leviathan"] or false,
	}, function(arg)
		SaveSettings("Webhook Find Leviathan", arg)
	end)

	SectionWebhook.CreateToggle({ Title = "Webhook Destroy IDK", Desc = nil, Default = Settings["Webhook Destroy IDK"] or false }, function(arg)
		SaveSettings("Webhook Destroy IDK", arg)
	end)

	SectionWebhook.CreateToggle({ Title = "Webhook Find Mirage", Desc = nil, Default = Settings["Webhook Find Mirage"] or false }, function(arg)
		SaveSettings("Webhook Find Mirage", arg)
	end)

	SettingPage = Main.CreatePage({ Page_Name = "Setting", Page_Title = "Setting Tab" })
	iterator = SettingPage.CreateSection("Settings")

	iterator.CreateToggle({ Title = "White Screen", Desc = nil, Default = Settings["White Screen"] or false }, function(arg)
		game:GetService("RunService"):Set3dRenderingEnabled(not (arg or Settings["Black Screen"]))
		SaveSettings("White Screen", arg)
	end)

	iterator.CreateToggle({ Title = "Black Screen", Desc = nil, Default = Settings["Black Screen"] or false }, function(arg)
		SaveSettings("Black Screen", arg)

		task.spawn(function()
			local n = 0

			while not BlackScreenImage and n < 30 do
				task.wait(0.5)
				n += 0.5
			end

			if BlackScreenImage then
				BlackScreenImage.Visible = arg == true
			end

			game:GetService("RunService"):Set3dRenderingEnabled(not (arg or Settings["White Screen"]))
		end)
	end)

	SerializeConfigFields = function(arg, arg2)
		local tbl18 = {}

		for k, v9 in pairs(arg) do
			local str2

			if type(k) == "number" or type(k) == "boolean" then
				str2 = "[" .. tostring(k) .. "]"
			else
				str2 = "[\"" .. tostring(k) .. "\"]"
			end

			local str3

			if type(v9) == "table" then
				str3 = "{\n" .. SerializeConfigFields(v9, arg2 + 1) .. string.rep("\t", arg2) .. "}"
			elseif type(v9) == "string" then
				str3 = string.format("%q", v9)
			else
				str3 = tostring(v9)
			end

			table.insert(tbl18, string.rep("\t", arg2 + 1) .. str2 .. " = " .. str3)
		end

		return table.concat(tbl18, ",\n") .. "\n"
	end

	SerializeConfig = function(arg)
		if type(arg) ~= "table" then
			return tostring(arg)
		end
		return "getgenv().Config = {\n" .. SerializeConfigFields(arg, 0) .. "}"
	end

	ApplyRemoveNotifications = function(arg)
		pcall(function()
			local Notification = require(game:GetService("ReplicatedStorage").Notification)

			if not getgenv().VxezeNotificationOriginal then
				local vxezeNotificationOriginal = { Display = Notification.Display, Dead = Notification.Dead }
				getgenv().VxezeNotificationOriginal = vxezeNotificationOriginal
			end

			local vxezeNotificationOriginal = getgenv().VxezeNotificationOriginal

			if arg then
				Notification.Display = function(arg2)
					if arg2 and arg2.Label then
						arg2.Label.Visible = false
					end

					return true
				end

				Notification.Dead = function()
					return true
				end
			else
				Notification.Display = vxezeNotificationOriginal.Display
				Notification.Dead = vxezeNotificationOriginal.Dead
			end
		end)
	end

	iterator.CreateToggle({ Title = "Remove Notifications", Desc = nil, Default = Settings["Remove Notifications"] or false }, function(arg)
		SaveSettings("Remove Notifications", arg)
		ApplyRemoveNotifications(arg)
	end)

	iterator.CreateToggle({
		Title = "Auto rejoin Disconnect",
		Desc = nil,
		Default = Settings["Auto rejoin Disconnect"] or false,
	}, function(arg)
		SaveSettings("Auto rejoin Disconnect", arg)
	end)

	BoostFps = { original = nil, running = false, connection = nil, saved = setmetatable({}, { __mode = "k" }) }

	BoostFpsApplyTo = function(arg)
		if arg:IsA("ParticleEmitter") or arg:IsA("Trail") or arg:IsA("Beam") then
			if arg.Enabled then
				BoostFps.saved[arg] = true
				arg.Enabled = false
			end
		elseif arg:IsA("Fire") or arg:IsA("Smoke") or arg:IsA("Sparkles") then
			if arg.Enabled then
				BoostFps.saved[arg] = true
				arg.Enabled = false
			end
		elseif arg:IsA("BasePart") then
			if arg.Material ~= Enum.Material.SmoothPlastic and arg.Material ~= Enum.Material.Neon then
				arg.Material = Enum.Material.SmoothPlastic
			end

			if arg.Reflectance ~= 0 then
				arg.Reflectance = 0
			end

			if arg.CastShadow then
				arg.CastShadow = false
			end
		end
	end

	BoostFpsSweep = function(arg)
		local descendants = arg:GetDescendants()
		local now = os.clock()

		for i_ = 1, #descendants do
			if not Settings["Boost Fps"] then
				return
			end
			local v9 = descendants[i_]

			if v9.Parent then
				pcall(BoostFpsApplyTo, v9)
			end

			if os.clock() - now > 0.004 then
				task.wait()
				now = os.clock()
			end
		end
	end

	SetBoostFps = function(arg)
		local Lighting = game:GetService("Lighting")
		local terrain = workspace.Terrain

		if arg then
			if not BoostFps.original then
				local tbl18 = {}

				for _, child in ipairs(Lighting:GetChildren()) do
					if child:IsA("PostEffect") or child:IsA("Atmosphere") or child:IsA("Clouds") then
						tbl18[child] = child:IsA("Atmosphere") and child.Density or child.Enabled
					end
				end

				BoostFps.original = {
					GlobalShadows = Lighting.GlobalShadows,
					FogEnd = Lighting.FogEnd,
					Quality = settings().Rendering.QualityLevel,
					WaterWaveSize = terrain.WaterWaveSize,
					WaterWaveSpeed = terrain.WaterWaveSpeed,
					WaterReflectance = terrain.WaterReflectance,
					Effects = tbl18,
				}
			end

			pcall(function()
				Lighting.GlobalShadows = false
				Lighting.FogEnd = 1e9
				local level01 = Enum.QualityLevel.Level01
				settings().Rendering.QualityLevel = level01
				terrain.WaterWaveSize = 0
				terrain.WaterWaveSpeed = 0
				terrain.WaterReflectance = 0

				for k in pairs(BoostFps.original.Effects) do
					if k:IsA("Atmosphere") then
						k.Density = 0
					else
						k.Enabled = false
					end
				end
			end)

			if not BoostFps.connection then
				BoostFps.connection = workspace.DescendantAdded:Connect(function(descendant)
					if Settings["Boost Fps"] then
						pcall(BoostFpsApplyTo, descendant)
					end
				end)
			end

			if not BoostFps.running then
				BoostFps.running = true

				task.spawn(function()
					BoostFpsSweep(workspace)
					BoostFps.running = false
				end)
			end
		else
			if BoostFps.connection then
				BoostFps.connection:Disconnect()
				BoostFps.connection = nil
			end

			local original = BoostFps.original
			BoostFps.original = nil

			if original then
				pcall(function()
					Lighting.GlobalShadows = original.GlobalShadows
					Lighting.FogEnd = original.FogEnd
					local quality = original.Quality
					settings().Rendering.QualityLevel = quality
					terrain.WaterWaveSize = original.WaterWaveSize
					terrain.WaterWaveSpeed = original.WaterWaveSpeed
					terrain.WaterReflectance = original.WaterReflectance

					for k, effect in pairs(original.Effects) do
						if k.Parent then
							if k:IsA("Atmosphere") then
								k.Density = effect
							else
								k.Enabled = effect
							end
						end
					end
				end)
			end

			for k in pairs(BoostFps.saved) do
				if k.Parent then
					pcall(function()
						k.Enabled = true
					end)
				end
			end

			table.clear(BoostFps.saved)
			VxezeNotify("Boost Fps", "Lighting, effects and quality restored, rejoin to restore materials", "info", { Key = "boostfpsoff" })
		end
	end

	FpsCapReady = false

	iterator.CreateSlider({
		Title = "Fps Cap",
		Min = 15,
		Max = 240,
		Default = tonumber(Settings["Fps Cap"]) or 60,
		Precise = false,
	}, function(arg)
		local flag2 = not FpsCapReady
		FpsCapReady = true
		if flag2 and Settings["Fps Cap"] == nil then
			return
		end
		SaveSettings("Fps Cap", arg)

		if type(setfpscap) == "function" then
			pcall(setfpscap, arg)
		else
			VxezeNotify("Fps Cap", "Your executor does not support changing the FPS cap", "warning", { Key = "fpscapmissing" })
		end
	end)

	iterator.CreateToggle({ Title = "Boost Fps", Desc = nil, Default = Settings["Boost Fps"] or false }, function(arg)
		SaveSettings("Boost Fps", arg)
		SetBoostFps(arg)
	end)

	iterator.CreateButton({ Title = "Copy Config" }, function()
		local v9 = setclipboard
		local v10 = SerializeConfig
		local data = HttpService:JSONDecode(readfile(FolderName .. "/" .. SaveFileName))
		v9(v10(data))
		VxezeNotify("Config", "Successfully Copy Config", "success")
	end)

	iterator.CreateButton({ Title = "Reset Config" }, function()
		VxezeResetConfig()
		VxezeNotify("Config", "Config reset, rejoin to load default settings", "success")
	end)

	v2.Finish()

	AimSettings = {
		"Auto Event Prehistoric Island",
		"Kill players When complete Trial",
		"Auto Dragon Hunter",
		"Auto Dojo Trainer",
		"Farm Mastery",
		"Auto Attack Leviathan",
		"Auto Sea Event",
		"Auto Upgrade Race V2-V3",
		"Auto Trial",
		"Auto Aimbot",
		"Auto Shipwright",
		"Auto Secret Quest",
	}

	AimActive = false

	task.spawn(function()
		local v9 = nil
		local now = nil

		while task.wait(0.25) do
			local flag2 = tick() < (AimForceUntil or 0)
			local flag3

			if not flag2 then
				local exitTo = nil

				for _, v10 in ipairs(AimSettings) do
					if Settings[v10] then
						exitTo = 1
						break
					end
				end

				if exitTo == 1 then
					flag3 = true
				else
					flag3 = flag2
				end
			else
				flag3 = flag2
			end

			local aimPos = getgenv().AimPos

			if aimPos ~= v9 then
				now = os.clock()
				v9 = aimPos
			end

			if not flag3 then
				getgenv().AimPos = nil
			end

			flag3 = flag3 and aimPos ~= nil and (typeof(aimPos) == "CFrame" or typeof(aimPos) == "Vector3")
			local flag4

			if flag3 then
				if flag2 then
					flag4 = flag2
				else
					flag4 = os.clock() - (now or 0) < 3
				end
			else
				flag4 = flag3
			end

			AimActive = flag4
		end
	end)

	if not getgenv().VxezeAimHook then
		getgenv().VxezeAimHook = true
		hookmetamethod(game, "__namecall", newcclosure(function(...) end))
	end

	RunService = game:GetService("RunService")
	runAsync = require(game.ReplicatedStorage.Util.runAsync)
	TextUtil = require(game.ReplicatedStorage.Modules.Util.TextUtil)

	if not getgenv().VxezeHubMainLoop then
		getgenv().VxezeHubMainLoop = true
		RunService.Stepped:Connect(function()if not  localPlayer .Character or HiddenEvent and HiddenEvent.walking then return;end;if not(ToggleNoclip()or Settings.Noclip or TweenState.IsMoving or getgenv().noclip and TweenManager.TweenRunning or(TweenRecentlyRequested()))then if NoclipActive then NoclipActive=false;TweenManager.CancelCurrent();SetNoClip(false);end;return;end;NoclipActive=true;for c,c in ipairs(RefreshNoclipParts())do if c.Parent and c.CanCollide then NoclipChanged[c]=true;c.CanCollide=false;end;end;end)
		RenderTick = function()if Settings["Auto Aimbot"]then RunAimbot();end;local n= localPlayer .Character and( localPlayer .Character:FindFirstChild("HumanoidRootPart"));if n and(n:FindFirstChild("FloatForce"))and not TweenManager.currentTween then if not ToggleNoclip()and not TweenRecentlyRequested()and tick()>TweenHoldUntil then TweenManager.CancelCurrent();end;end;end
		RunService.RenderStepped:Connect(function()pcall(RenderTick);local n= localPlayer .Character and( localPlayer .Character:FindFirstChild("Humanoid"));if n then if Settings["Change WalkSpeed"]then n.WalkSpeed=Settings["Input WalkSpeed"]or 16;end;if Settings["Change JumpPower"]then n.JumpPower=Settings["Input JumpPower"]or 50;end;end;end)

		task.spawn(function()
			local n = 0

			while task.wait(0.5) do
				local ok, result = pcall(function()
					sethiddenproperty(localPlayer, "SimulationRadius", 5000)

					if GachaWindow.IsOpen() then
						GachaWindow.Close()
					end

					if Settings["Random Devil Fruit"] then
						RollGacha("ZiolesGacha", "Random Devil Fruit")
					end

					if Settings["Random Magnet Event"] then
						RollGacha("MagnetEventGacha26", "Random Magnet Event")
					end

					if Settings["Auto Store Fruit"] then
						StoreFruit(localPlayer.Backpack)
						StoreFruit(localPlayer.Character)
					end

					if tick() - n < 5 then
						return
					end
					n = tick()
					local commF = ReplicatedStorage.Remotes.CommF_

					if Settings["Buy Blox Fruit Sniper Shop"] then
						BuyFruitShop()
					end

					if Settings["Auto Trade Bone"] then
						commF:InvokeServer("Bones", "Buy", 1, 1)
					end

					if Settings["Auto Awake Fruit"] then
						commF:InvokeServer("Awakener", "Check")
						commF:InvokeServer("Awakener", "Awaken")
					end

					if Settings["Auto Buy Legendary Sword"] then
						commF:InvokeServer("LegendarySwordDealer", "2")

						if Settings["Hop Server [ Haki color or Legendary Sword]"] then
							local v9 = CheckSwordLegendary()

							if v9 then
								SpecialHop(v9)
							else
								SaveSettings("Auto Buy Legendary Sword", false)

								if getgenv().ToggleAutoBuyLegSword then
									getgenv().ToggleAutoBuyLegSword:SetStage(false)
								end

								VxezeNotify("Sword", "Full Sword Legendary", "success", { Key = "legswordfull" })
							end
						end
					end

					if Settings["Auto Buy Haki Color"] then
						commF:InvokeServer("ColorsDealer", "2")

						if Settings["Hop Server [ Haki color or Legendary Sword]"] and not HakiHopStarted then
							HakiHopStarted = true
							task.spawn(HopServer)
						end
					end
				end)

				if result then
					PrintOnce(result)
				end
			end
		end)
	end

	getgenv().__VXEZE_LOADED = true
end

__VxezeHubMain()
