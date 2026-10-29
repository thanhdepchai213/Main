if getgenv().__BF_LOADED == game.JobId then
	return getgenv().__BF_RESULT
end

repeat
	wait()
until game:IsLoaded() and game.Players.LocalPlayer
-- Luraph macro stubs (LPH_ATTRIBUTES(VM(NONE)) duoc goi o 4 cho, truoc do khong duoc dinh nghia)
LPH_ATTRIBUTES = LPH_ATTRIBUTES or function(...)
	return ...
end
VM = VM or function(...)
	return ...
end

-- Nang identity thread (loi "lacking capability Plugin") + guard UI de 1 element loi khong lam dung ca script
function ElevateIdentity()
	pcall(function()
		local f = setthreadidentity or setidentity or set_thread_identity or (syn and syn.set_thread_identity) or setthreadcontext
		if f then
			f(8)
		end
	end)
end
ElevateIdentity()

-- Mo rong ban kinh Streaming: neu khong, cac Part spawn quai (EnemySpawns) va
-- chinh con quai trong Workspace.Enemies se KHONG ton tai phia client cho toi
-- khi nhan vat thuc su di toi gan (Roblox StreamingEnabled). Luc do DetectMob
-- va DetectPartSpawnMob deu tra ve nil -> farm dung im cho den khi minh tu chay
-- lai gan. Tat/no rong Streaming ngay tu dau de mob spawn xa cung duoc client
-- nhan biet va script tu di toi duoc.
-- FIX HOP CRASH: truoc day set StreamingMinRadius/TargetRadius = 1e8 ngay luc load -> sau hop/travel
-- client bi ep load CA map moi trong khi map cu chua giai phong -> het RAM -> Roblox tu thoat.
-- Gio: chi mo rong sau khi server moi on dinh (nhan vat load + 15s), muc vua phai, va tra ve
-- gia tri goc ngay khi bat dau teleport de engine con xa duoc map cu.
getgenv().__BF_TELEPORTING = false
local __streamOrig = {}
pcall(function()
	__streamOrig.min = workspace.StreamingMinRadius
	__streamOrig.target = workspace.StreamingTargetRadius
end)
task.spawn(function()
	local lp = game.Players.LocalPlayer
	repeat
		task.wait(1)
	until lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
	task.wait(15)
	if getgenv().__BF_TELEPORTING then
		return
	end
	pcall(function()
		workspace.StreamingMinRadius = 4000
		workspace.StreamingTargetRadius = 6000
	end)
end)
pcall(function()
	game.Players.LocalPlayer.OnTeleport:Connect(function()
		getgenv().__BF_TELEPORTING = true
		pcall(function()
			if __streamOrig.min then
				workspace.StreamingMinRadius = __streamOrig.min
			end
			if __streamOrig.target then
				workspace.StreamingTargetRadius = __streamOrig.target
			end
		end)
	end)
end)

task.spawn(function()
	local env = getgenv()
	local need = {
		"getconnections", "fireclickdetector", "fireproximityprompt", "firetouchinterest", "newcclosure",
		"getrawmetatable", "getnamecallmethod", "setclipboard", "isfolder", "makefolder", "writefile",
		"readfile", "delfile", "sethiddenproperty", "getupvalues", "getupvalue", "setupvalue",
		"queue_on_teleport", "getnilinstances", "Drawing", "hookmetamethod", "request",
	}
	local miss = {}
	for _, n in ipairs(need) do
		if env[n] == nil then
			table.insert(miss, n)
		end
	end
	if not (env.setthreadidentity or env.setidentity or env.set_thread_identity) then
		table.insert(miss, "setthreadidentity")
	end
	local ok, name = pcall(function()
		return identifyexecutor and identifyexecutor() or "unknown"
	end)
	print("[NoijoFix] executor:", ok and name or "unknown", "| thieu ham:", #miss > 0 and table.concat(miss, ", ") or "khong")
end)
local function uiStub()
	return setmetatable({}, {
		__index = function()
			return function() end
		end,
		__call = function() end,
	})
end
local function guardUI(obj, label)
	if type(obj) ~= "table" then
		return obj
	end
	return setmetatable({}, {
		__index = function(_, k)
			local v = obj[k]
			if type(v) ~= "function" then
				return v
			end
			return function(...)
				local res = table.pack(pcall(v, ...))
				if not res[1] then
					ElevateIdentity()
					res = table.pack(pcall(v, ...))
				end
				if not res[1] then
					warn(("[NoijoFix] %s.%s failed: %s"):format(label, tostring(k), tostring(res[2])))
					return uiStub()
				end
				return guardUI(res[2], label .. "." .. tostring(k)), unpack(res, 3, res.n)
			end
		end,
		__newindex = function(_, k, v)
			obj[k] = v
		end,
	})
end

-- Quest UI check: V1 (PlayerGui.Main.Quest) + V2 (PlayerGui.TrackedQuestFrame)
-- V3 (StarterGui.Main.Quest) khong dung: day la ban mau, khong phan anh quest dang co.
local function readText(inst)
	if not inst then
		return nil
	end
	if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
		return inst.Text ~= "" and inst.Text or nil
	end
	for _, d in ipairs(inst:GetDescendants()) do
		if d:IsA("TextLabel") and d.Text ~= "" then
			return d.Text
		end
	end
	return nil
end
function GetQuestTitle()
	local lp = game:GetService("Players").LocalPlayer
	local pg = lp and lp:FindFirstChild("PlayerGui")
	if not pg then
		return nil
	end
	-- V1
	local main = pg:FindFirstChild("Main") or pg:FindFirstChild("Main (minimal)")
	local q = main and main:FindFirstChild("Quest")
	if q and q.Visible then
		local c = q:FindFirstChild("Container")
		local qt = c and c:FindFirstChild("QuestTitle")
		local txt = readText(qt and qt:FindFirstChild("Title"))
		if txt then
			return txt
		end
	end
	-- V2
	local tr = pg:FindFirstChild("TrackedQuestFrame")
	if tr then
		local on = (tr:IsA("ScreenGui") and tr.Enabled) or (tr:IsA("GuiObject") and tr.Visible)
		local fr = tr:FindFirstChild("Frame")
		if on and fr and fr.Visible then
			return readText(fr:FindFirstChild("header"))
		end
	end
	return nil
end
local _rawHasQuest = function()
	return GetQuestTitle() ~= nil
end
local _questSeenUntil = 0
function HasQuest()
	-- Giu trang thai "co quest" trong 1s sau lan cuoi thay UI hien quest,
	-- de tranh doc UI ngay luc dang animation/lag -> tuong nham la mat quest
	-- roi goi lai TakeQuestLevel giua chung, gay farm level chap chon.
	if _rawHasQuest() then
		_questSeenUntil = tick() + 1
		return true
	end
	return tick() < _questSeenUntil
end

-- Lay TOAN BO text cua UI quest (V1 + V2), khong chi moi title.
-- Dung cho cac che do can so ten boss/mob (Elite Hunter, Rainbow Haki, CDK...)
local function collectText(root)
	local out = {}
	if not root then
		return out
	end
	local function add(i)
		if (i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox")) and i.Text ~= "" then
			out[#out + 1] = i.Text
		end
	end
	add(root)
	for _, d in ipairs(root:GetDescendants()) do
		add(d)
	end
	return out
end
function GetQuestText()
	local lp = game:GetService("Players").LocalPlayer
	local pg = lp and lp:FindFirstChild("PlayerGui")
	if not pg then
		return ""
	end
	local parts = {}
	local main = pg:FindFirstChild("Main") or pg:FindFirstChild("Main (minimal)")
	local q = main and main:FindFirstChild("Quest")
	if q and q.Visible then
		for _, t in ipairs(collectText(q)) do
			parts[#parts + 1] = t
		end
	end
	local tr = pg:FindFirstChild("TrackedQuestFrame")
	if tr then
		local on = (tr:IsA("ScreenGui") and tr.Enabled) or (tr:IsA("GuiObject") and tr.Visible)
		if on then
			for _, t in ipairs(collectText(tr)) do
				parts[#parts + 1] = t
			end
		end
	end
	return table.concat(parts, " | ")
end
-- Quest hien tai co nhac toi `name` khong (khong phan biet hoa thuong, plain find)
function QuestHas(name)
	if not name then
		return false
	end
	name = tostring(name):lower()
	if GetQuestText():lower():find(name, 1, true) then
		return true
	end
	if GetQuestTitle() and GetQuestTitle():lower():find(name, 1, true) then
		return true
	end
	return false
end
-- Dung cho Elite Hunter: dam bao dang giu quest cua boss `name`.
-- Tra ve true = co the danh boss ngay. Co cooldown de khong abandon/nhan lien tuc khi UI cap nhat cham.
local _lastEliteTake = 0
function EnsureEliteQuest(name)
	if QuestHas(name) then
		return true
	end
	if tick() - _lastEliteTake < 6 then
		return true
	end
	_lastEliteTake = tick()
	local CF = game:GetService("ReplicatedStorage").Remotes.CommF_
	pcall(function()
		if HasQuest() then
			CF:InvokeServer("AbandonQuest")
		end
		CF:InvokeServer("EliteHunter")
	end)
	task.wait(1)
	return QuestHas(name)
end

Settings = {}
HttpService = game:GetService("HttpService")
FolderName = "Noijo Hub"
SaveFileNameGame = "-BloxFruitBNNC.json"
SaveFileName = game.Players.LocalPlayer.Name .. SaveFileNameGame
function SaveSettings(b, t, A)
	if A ~= nil then
		Settings[b] = Settings[b] or {}
		Settings[b][t] = A
	elseif b ~= nil then
		Settings[b] = t
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
function ReadSetting(tries)
	tries = tries or 0
	local b, t = pcall(function()
		if not isfolder(FolderName) then
			makefolder(FolderName)
		end
		return HttpService:JSONDecode(readfile(FolderName .. "/" .. SaveFileName))
	end)
	if b and type(t) == "table" then
		return t
	else
		if tries >= 3 then
			return {}
		end
		SaveSettings()
		return ReadSetting(tries + 1)
	end
end
Settings = ReadSetting()
getgenv().Settings = Settings
function PrepareMultiSelectList(b, t, A)
	local a = {}
	for s in pairs(b) do
		local b = t and t[s]
		if b == nil then
			a[s] = A and true or false
		else
			a[s] = b
		end
	end
	return a
end
function EnsureAllTrueDefaults(b, t)
	if type(Settings[b]) ~= "table" then
		Settings[b] = {}
	end
	local A = false
	for a, a in ipairs(t) do
		if Settings[b][a] == nil then
			Settings[b][a] = true
			A = true
		end
	end
	if A then
		for t, A in pairs(Settings[b]) do
			SaveSettings(b, t, A)
		end
	end
end
repeat
	wait()
until game:FindFirstChild("CoreGui")
repeat
	wait()
until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen")
repeat
	wait()
until game:IsLoaded() and (game.Players.LocalPlayer:FindFirstChild("DataLoaded"))
function FireButton(b)
	b.Selectable = true
	game:GetService("GuiService").SelectedObject = b
	game:GetService("VirtualInputManager"):SendKeyEvent(true, "Return", false, b)
	game:GetService("VirtualInputManager"):SendKeyEvent(false, "Return", false, b)
	b.Activated:Connect(function()
		game:GetService("GuiService").SelectedObject = nil
	end)
end
-- Check phe: da o Pirates/Marines thi bo qua buoc join phe, chua co phe thi moi chay logic join
local function HasTeam()
	local t = game:GetService("Players").LocalPlayer.Team
	return t ~= nil and (t.Name == "Pirates" or t.Name == "Marines")
end
do
	-- Team co the chua replicate ngay sau DataLoaded -> cho toi da 3s truoc khi ket luan la chua co phe
	local t0 = tick()
	repeat
		wait(0.25)
	until HasTeam() or tick() - t0 > 3
end
if not HasTeam() then
	repeat
		wait()
	until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
		or (game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main"))
	local b = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
		or (game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main"))
	local waitUI = tick()
	repeat
		wait()
	until b:FindFirstChild("ChooseTeam") or HasTeam() or tick() - waitUI > 15
	repeat
		task.wait()
		pcall(function()
			local choose = b:FindFirstChild("ChooseTeam")
			if choose and not HasTeam() then
				local isPirate = Settings["Select Team"] == "Pirate"
				FireButton(choose.Container[isPirate and "Pirates" or "Marines"].Frame.TextButton)
				wait(1)
			end
		end)
	until HasTeam() or not b.Parent or not b:FindFirstChild("ChooseTeam") or not b.ChooseTeam.Visible
	-- fallback: GUI khong click duoc thi goi thang remote SetTeam
	if not HasTeam() then
		pcall(function()
			local isPirate = Settings["Select Team"] == "Pirate"
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", isPirate and "Pirates" or "Marines")
		end)
		local t1 = tick()
		repeat
			wait(0.25)
		until HasTeam() or tick() - t1 > 5
	end
	game:GetService("GuiService").SelectedObject = nil
end
repeat
	wait()
until game:IsLoaded() and game.Players.LocalPlayer
repeat
	wait()
until game:FindFirstChild("CoreGui")
getgenv().ExploitReq = (syn and syn.request)
	or (identifyexecutor and identifyexecutor() == "Fluxus" and request)
	or http_request
	or (http and http.request)
	or request
	or requests
getgenv().request = getgenv().request or getgenv().ExploitReq
if getgenv().LoadScript then
	return print("Double UI")
end
getgenv().CheckPlaceId = game.PlaceId == 100117331123089 and 100117331123089 or 7449423635
getgenv().CheckPlaceId2 = game.PlaceId == 4442272183 and 4442272183 or 79091703265657
getgenv().CheckPlaceId3 = game.PlaceId == 2753915549 and 2753915549 or 85211729168715
getgenv().LoadScript = true
local t = game.Players.LocalPlayer
getgenv().getupvalue = debug.getupvalue
getgenv().getupvalues = debug.getupvalues
wOrigin = game:GetService("Workspace"):WaitForChild("_WorldOrigin")
CommF = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")
vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait(1)
	vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
-- Noijo Hub Fluent adapter for the original gameplay logic.
-- Original gameplay callbacks are retained; only the UI API is bridged to Fluent.
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Noijo Hub",
    SubTitle = "Premium [Beta]",
    TabWidth = 145,
    Size = UDim2.fromOffset(520, 390),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl,
})
local UserInputService = game:GetService("UserInputService")
local __uiCounter = 0
local __currentPageName, __currentSectionName = "Main", "Main"
local __tabs = {}
local __fluentOptions = Fluent.Options
local __optionMeta = {}
local function __newId(title)
    __uiCounter = __uiCounter + 1
    local s = tostring(title or "Control"):gsub("[^%w_]", "")
    if s == "" then s = "Control" end
    return "BC_" .. s .. "_" .. tostring(__uiCounter)
end
local function __safe(fn, ...)
    if type(fn) == "function" then
        local ok, err = pcall(fn, ...)
        if not ok then warn("[LightHub UI] " .. tostring(err)) end
    end
end
local function __register(title, id, typ, default, config)
    local meta = {
        name = title, type = typ, value = default,
        Page_Name = __currentPageName, Section_Name = __currentSectionName,
        min = config and config.Min, max = config and config.Max,
        step = config and config.Step, text = title,
    }
    meta.FunctionCreate = {
        SetValue = function(a, b)
            local v = b ~= nil and b or a
            meta.value = v
            local opt = __fluentOptions[id]
            if opt and opt.SetValue then __safe(function() opt:SetValue(v) end) end
        end,
        SetStage = function(a, b) meta.value = b ~= nil and b or a end,
        SetSubValue = function(k, v)
            if type(meta.value) ~= "table" then meta.value = {} end
            meta.value[k] = v
        end,
        GetText = function() return tostring(meta.text or title) end,
    }
    __optionMeta[id] = meta
    __optionMeta[title] = meta
    return meta
end
local function __makePage(title)
    __currentPageName = title
    local tab = Window:AddTab({ Title = title, Icon = "" })
    __tabs[title] = tab
    local page = {}
    function page.CreateSection(sectionTitle)
        __currentSectionName = tostring(sectionTitle or "Section")
        local section = { _tab = tab, _name = __currentSectionName }
        function section.CreateToggle(cfg, callback)
            cfg = cfg or {}
            local title = tostring(cfg.Title or "Toggle")
            local id = __newId(title)
            local default = cfg.Default == true
            tab:AddToggle(id, { Title = title, Description = cfg.Desc or cfg.Description or "", Default = default })
            local meta = __register(title, id, "toggle", default, cfg)
            if __fluentOptions[id] then
                __fluentOptions[id]:OnChanged(function(v)
                    meta.value = v
                    __safe(callback, v)
                end)
            end
            return meta.FunctionCreate
        end
        function section.CreateButton(cfg, callback)
            cfg = cfg or {}
            local title = tostring(cfg.Title or "Button")
            local id = __newId(title)
            tab:AddButton({ Title = title, Description = cfg.Desc or cfg.Description or "", Callback = function()
                __safe(callback)
            end })
            local meta = __register(title, id, "button", title, cfg)
            return meta.FunctionCreate
        end
        function section.CreateDropdown(cfg, callback)
            cfg = cfg or {}
            local title = tostring(cfg.Title or "Dropdown")
            local id = __newId(title)
            local list = cfg.List or cfg.Values or {}
            if cfg.Slider and type(list) == "table" then
                for key, item in pairs(list) do
                    if type(item) == "table" then
                        local sliderTitle = tostring(item.Title or key)
                        local sliderId = __newId(title .. sliderTitle)
                        local default = tonumber(item.Default) or 0.5
                        tab:AddSlider(sliderId, { Title = title .. " - " .. sliderTitle, Min = tonumber(item.Min) or 0, Max = tonumber(item.Max) or 5, Default = default, Rounding = 2 })
                        local meta = __register(title .. " - " .. sliderTitle, sliderId, "slider_dropdown", default, item)
                        if __fluentOptions[sliderId] then
                            __fluentOptions[sliderId]:OnChanged(function(v)
                                meta.value = v
                                __safe(callback, { KeyName = item.KeyName or key, Default = v }, v)
                            end)
                        end
                    end
                end
                return __register(title, id, "slider_dropdown", {}, cfg).FunctionCreate
            end
            local values, defaults = {}, cfg.Default
            if type(list) == "table" then
                for k, v in pairs(list) do
                    if type(k) == "number" then
                        table.insert(values, tostring(v))
                    elseif type(v) == "table" then
                        table.insert(values, tostring(v.Title or k))
                    else
                        table.insert(values, tostring(k))
                    end
                end
            end
            table.sort(values)
            local multi = cfg.Selected == true or (type(defaults) == "table")
            local fluentDefault = defaults
            if multi then
                fluentDefault = {}
                if type(defaults) == "table" then
                    for k, v in pairs(defaults) do
                        if type(k) == "number" then
                            table.insert(fluentDefault, tostring(v))
                        elseif v == true then
                            table.insert(fluentDefault, tostring(k))
                        end
                    end
                end
            elseif defaults ~= nil and type(defaults) ~= "table" then
                fluentDefault = tostring(defaults)
            elseif #values > 0 then
                fluentDefault = values[1]
            end
            tab:AddDropdown(id, { Title = title, Description = cfg.Desc or cfg.Description or "", Values = values, Multi = multi, Default = fluentDefault })
            local meta = __register(title, id, "dropdown", fluentDefault, cfg)
            local previous = type(fluentDefault) == "table" and table.clone(fluentDefault) or fluentDefault
            if __fluentOptions[id] then
                __fluentOptions[id]:OnChanged(function(v)
                    meta.value = v
                    if multi then
                        if type(v) == "table" then
                            local current = {}
                            for k, value in pairs(v) do
                                if type(k) == "number" then current[tostring(value)] = true
                                elseif value == true then current[tostring(k)] = true end
                            end
                            local old = {}
                            if type(previous) == "table" then
                                for k, value in pairs(previous) do
                                    if type(k) == "number" then old[tostring(value)] = true
                                    elseif value == true then old[tostring(k)] = true end
                                end
                            end
                            for _, name in ipairs(values) do
                                local was, now = old[name] == true, current[name] == true
                                if was ~= now then __safe(callback, name, now) end
                            end
                            previous = current
                        end
                    else
                        __safe(callback, v)
                    end
                end)
            end
            return meta.FunctionCreate
        end
        function section.CreateSlider(cfg, callback)
            cfg = cfg or {}
            local title = tostring(cfg.Title or "Slider")
            local id = __newId(title)
            local default = tonumber(cfg.Default) or tonumber(cfg.Min) or 0
            tab:AddSlider(id, { Title = title, Description = cfg.Desc or cfg.Description or "", Min = tonumber(cfg.Min) or 0, Max = tonumber(cfg.Max) or 100, Default = default, Rounding = cfg.Precise and 2 or 0 })
            local meta = __register(title, id, "slider", default, cfg)
            if __fluentOptions[id] then
                __fluentOptions[id]:OnChanged(function(v)
                    meta.value = v
                    __safe(callback, v)
                end)
            end
            return meta.FunctionCreate
        end
        function section.CreateBox(cfg, callback)
            cfg = cfg or {}
            local title = tostring(cfg.Title or "Input")
            local id = __newId(title)
            local default = cfg.Default == nil and "" or tostring(cfg.Default)
            tab:AddInput(id, { Title = title, Description = cfg.Desc or "", Default = default, Placeholder = cfg.Placeholder or "", Numeric = cfg.Number == true })
            local meta = __register(title, id, "box", default, cfg)
            if __fluentOptions[id] then
                __fluentOptions[id]:OnChanged(function(v)
                    meta.value = v
                    __safe(callback, v)
                end)
            end
            return meta.FunctionCreate
        end
        function section.CreateLabel(cfg)
            cfg = cfg or {}
            local title = tostring(cfg.Title or "Info")
            local id = __newId(title)
            local paragraph = tab:AddParagraph({ Title = title, Content = "" })
            local meta = __register(title, id, "textlabel", title, cfg)
            local handle = {}
            function handle.SetText(value)
                meta.text = tostring(value or "")
                __safe(function()
                    if paragraph.SetDesc then paragraph:SetDesc(meta.text)
                    elseif paragraph.SetContent then paragraph:SetContent(meta.text) end
                end)
            end
            return handle
        end
        function section.CreateNoti(cfg)
            cfg = cfg or {}
            Fluent:Notify({ Title = cfg.Title or "Noijo Hub", Content = cfg.Desc or cfg.Content or "", Duration = tonumber(cfg.ShowTime) or 5 })
        end
        function section.CreateBind(bindCfg, callback)
            UserInputService.InputBegan:Connect(function(input, processed)
                if not processed and input.KeyCode == bindCfg.Key then __safe(callback) end
            end)
        end
        return section
    end
    return page
end
local A = { Options = __optionMeta }
function A.CreateMain(cfg)
    return {
        CreatePage = function(pageCfg) return __makePage(pageCfg.Page_Name or pageCfg.Page_Title or "Page") end,
        CreateNoti = function(notice) Fluent:Notify({ Title = notice.Title or "Noijo Hub", Content = notice.Desc or notice.Content or "", Duration = tonumber(notice.ShowTime) or 5 }) end,
        CreateButton = function(cfg, callback)
            local tab = __tabs[__currentPageName] or Window:AddTab({ Title = "Main", Icon = "" })
            tab:AddButton({ Title = cfg.Title or "Button", Callback = function() __safe(callback) end })
        end,
        CreateBind = function(bindCfg, callback)
            UserInputService.InputBegan:Connect(function(input, processed)
                if not processed and input.KeyCode == bindCfg.Key then __safe(callback) end
            end)
        end,
    }
end
Main = guardUI(A.CreateMain({ Title = "Blox Fruit", Desc = " - Blox Fruit" }), "Main")
PageShop = Main.CreatePage({ Page_Name = "Shop", Page_Title = "Shop" })
getgenv().Options = A.Options
SectionShopMisc = PageShop.CreateSection("Misc Shop")
function Remote(a, s, X)
	if not a and X then
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer(s, true)
	else
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer(a, s, X)
	end
end
getgenv().tablefruitausea3 = {}
whitelistedfruit = {}
TableDevilFruit = {}
local a, s, X = next, game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false)
for g, g in a, s, X do
	if g.Price >= 1000000 then
		table.insert(whitelistedfruit, string.split(g.Name, "-")[1] .. " Fruit")
		getgenv().tablefruitausea3[g.Name] = g.Price
	end
	TableDevilFruit[g.Name] = false
end
getgenv().tablefruitausea3["Dragon (East)-Dragon (East)"] = 15000000
getgenv().tablefruitausea3["Dragon (West)-Dragon (West)"] = 15000000
ItemId = require(game.ReplicatedStorage.Economy.ItemId)
function CheckFruitReal(g)
	local G, f, K = next, game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false)
	for R, R in G, f, K do
		if R.Name == g then
			return R
		end
	end
end
SkinFruit = {}
-- spawn(function()
--     for g, g in next, require(game:GetService("ReplicatedStorage").Modules.SkinUtil.FruitSkins).Grouped do
--         for G, G in next, g do
--             getgenv().tablefruitausea3[g.StorageName] = CheckFruitReal(G.Item).Price
--             table.insert(whitelistedfruit, G.StorageName .. " Fruit")
--             SkinFruit[G.StorageName .. " Fruit"] = true
--         end
--     end
-- end)
NameWorldMaterials = {
	Ectoplasm = { [getgenv().CheckPlaceId2] = "TravelDressrosa" },
	["Magma Ore"] = { [getgenv().CheckPlaceId2] = "TravelDressrosa" },
	Leather = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Scrap Metal"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Angel Wings"] = { [getgenv().CheckPlaceId3] = "TravelMain" },
	["Fish Tail"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Radioactive Material"] = { [getgenv().CheckPlaceId2] = "TravelDressrosa" },
	["Vampire Fang"] = { [getgenv().CheckPlaceId2] = "TravelDressrosa" },
	["Mystic Droplet"] = { [getgenv().CheckPlaceId2] = "TravelDressrosa" },
	["Mini Tusk"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	Gunpowder = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Demonic Wisp"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Dragon Scale"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Conjured Cocoa"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	Bones = { [getgenv().CheckPlaceId] = "TravelZou" },
}
NameMaterials = {
	Ectoplasm = { "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer", "Cursed Captain" },
	["Magma Ore"] = { "Lava Pirate", "Magma Ninja" },
	Leather = { "Jungle Pirate", "Musketeer Pirate" },
	["Scrap Metal"] = { "Jungle Pirate" },
	["Angel Wings"] = { "God's Guard", "Shanda", "Royal Squad", "Royal Soldier" },
	["Fish Tail"] = { "Fishman Raider", "Fishman Captain" },
	["Radioactive Material"] = { "Factory Staff" },
	["Vampire Fang"] = { "Vampire" },
	["Mystic Droplet"] = { "Sea Soldier", "Water Fighter" },
	["Mini Tusk"] = { "Mythological Pirate" },
	Gunpowder = { "Pistol Billionaire" },
	["Demonic Wisp"] = { "Demonic Soul" },
	["Dragon Scale"] = { "Dragon Crew Archer", "Dragon Crew Warrior" },
	["Conjured Cocoa"] = { "Cocoa Warrior", "Chocolate Bar Battler" },
	Bones = { "Reborn Skeleton", "Demonic Soul", "Living Zombie", "Posessed Mummy" },
}
TableMaterials = {}
for g, G in next, NameMaterials, nil do
	table.insert(TableMaterials, g)
end
REDEEM_CODES = {
	"EASTEREXP",
	"BANEXPLOIT",
	"NOMOREHACKS",
	"WildDares",
	"BossBuild",
	"GetPranked",
	"EARN_FRUITS",
	"Sub2UncleKizaru",
	"FIGHT4FRUIT",
	"kittgaming",
	"TRIPLEABUSE",
	"Sub2CaptainMaui",
	"Sub2Fer999",
	"Enyu_is_Pro",
	"Magicbus",
	"JCWK",
	"Starcodeheo",
	"Bluxxy",
	"SUB2GAMERROBOT_EXP1",
	"Sub2NoobMaster123",
	"Sub2Daigrock",
	"Axiore",
	"TantaiGaming",
	"StrawHatMaine",
	"Sub2OfficialNoobie",
	"TheGreatAce",
	"SEATROLLIN",
	"24NOADMIN",
	"ADMIN_TROLL",
	"NEWTROLL",
	"SECRET_ADMIN",
	"staffbattle",
	"NOEXPLOIT",
	"NOOB2ADMIN",
	"CODESLIDE",
	"fruitconcepts",
}
SectionShopMisc.CreateButton({ Title = "Redeem Code" }, function()
	LPH_ATTRIBUTES(VM(NONE))
	for _, v in REDEEM_CODES do
		game.ReplicatedStorage.Remotes.Redeem:InvokeServer(v)
	end
end)

SectionShopMisc.CreateButton({ Title = "Teleport Old World" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "TravelMain" }))
end)

SectionShopMisc.CreateButton({ Title = "Teleport New World" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "TravelDressrosa" }))
end)

SectionShopMisc.CreateButton({ Title = "Teleport Thid Sea" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "TravelZou" }))
end)

SectionShopMisc.CreateButton({ Title = "Buy Dual Flintlock" }, function()
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")
end)

SectionShopMisc.CreateButton({ Title = "Reroll Race" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
end)

SectionShopMisc.CreateButton({ Title = "Reset Stats" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
end)

SectionShopMisc.CreateButton({ Title = "Buy Race Cyborg" }, function()
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
end)

SectionShopMisc.CreateButton({ Title = "Buy Race Ghoul" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "BuyCheck", 4)
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4)
end)

SectionShopFighting = PageShop.CreateSection("Fighting Shop")
local g = {}
getgenv().notsave = g
local G = {
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
function DetectNpc(f)
	local K = t.Character and (t.Character:FindFirstChild("HumanoidRootPart"))
	if not K then
		return
	end
	local R, m, E, l = next, { workspace.NPCs, game:GetService("ReplicatedStorage").NPCs }, 1 / 0
	for Q, Q in R, m, nil do
		local R, m, S = next, Q:GetChildren()
		for Q, L in R, m, S do
			if
				L:GetAttribute("NPCLoaded")
				and (L:GetAttribute("NPCReady"))
				and L.Name == f
				and (L:FindFirstChild("HumanoidRootPart"))
			then
				Q = (K.Position - L.HumanoidRootPart.Position).Magnitude
				if Q < E then
					E, l = Q, L
				end
			end
		end
	end
	if not l then
		return NPCManager.getNPCsByName(f)[1]._modelState._instance
	end
	return l, E
end

SectionShopFighting.CreateToggle({ Title = "Black Leg", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g["Black Leg"] and (task.wait()) do
				local K, K = pcall(function()
					local R = DetectNpc(G.BuyBlackLeg)
					if t:DistanceFromCharacter(R.HumanoidRootPart.Position) < 8 then
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBlackLeg")
					end
					getgenv().BackupTween(R.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
				if K then
					print(K)
				end
			end
		end)
	end
	g["Black Leg"] = f
end)

SectionShopFighting.CreateToggle({ Title = "Fishman Karate", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g["Fishman Karate"] and (task.wait()) do
				local K, K = pcall(function()
					local R = DetectNpc(G.BuyFishmanKarate)
					if t:DistanceFromCharacter(R.HumanoidRootPart.Position) < 8 then
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
					end
					getgenv().BackupTween(R.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
				if K then
					print(K)
				end
			end
		end)
	end
	g["Fishman Karate"] = f
end)

SectionShopFighting.CreateToggle({ Title = "Electro", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g.Electro and (task.wait()) do
				pcall(function()
					local K = DetectNpc(G.BuyElectro)
					if t:DistanceFromCharacter(K.HumanoidRootPart.Position) < 8 then
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectro")
					end
					getgenv().BackupTween(K.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
			end
		end)
	end
	g.Electro = f
end)

SectionShopFighting.CreateToggle({ Title = "Dragon Breath", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g.DragonClaw and (task.wait()) do
				pcall(function()
					local K = DetectNpc(G.DragonClaw)
					if t:DistanceFromCharacter(K.HumanoidRootPart.Position) < 8 then
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
					end
					getgenv().BackupTween(K.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
			end
		end)
	end
	g.DragonClaw = f
end)

SectionShopFighting.CreateToggle({ Title = "SuperHuman", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g.SuperHuman and (task.wait()) do
				pcall(function()
					local K = DetectNpc(G.BuySuperhuman)
					if t:DistanceFromCharacter(K.HumanoidRootPart.Position) < 8 then
						Remote("BuySuperhuman")
					end
					getgenv().BackupTween(K.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
			end
		end)
	end
	g.SuperHuman = f
end)

SectionShopFighting.CreateToggle({ Title = "Death Step", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g["Death Step"] and (task.wait()) do
				pcall(function()
					local K = DetectNpc(G.BuyDeathStep)
					if t:DistanceFromCharacter(K.HumanoidRootPart.Position) < 8 then
						Remote("BuyDeathStep")
					end
					getgenv().BackupTween(K.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
			end
		end)
	end
	g["Death Step"] = f
end)

SectionShopFighting.CreateToggle({ Title = "Sharkman Karate", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g["Sharkman Karate"] and (task.wait()) do
				pcall(function()
					local K = DetectNpc(G.BuySharkmanKarate)
					if t:DistanceFromCharacter(K.HumanoidRootPart.Position) < 8 then
						Remote("BuySharkmanKarate")
					end
					getgenv().BackupTween(K.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
			end
		end)
	end
	g["Sharkman Karate"] = f
end)

SectionShopFighting.CreateToggle({ Title = "Electric Claw", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g["Electric Claw"] and (task.wait()) do
				pcall(function()
					local K = DetectNpc(G.BuyElectricClaw)
					if t:DistanceFromCharacter(K.HumanoidRootPart.Position) < 8 then
						Remote("BuyElectricClaw")
					end
					getgenv().BackupTween(K.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
			end
		end)
	end
	g["Electric Claw"] = f
end)

SectionShopFighting.CreateToggle({ Title = "Dragon Talon", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g["Dragon Talon"] and (task.wait()) do
				pcall(function()
					local K = DetectNpc(G.BuyDragonTalon)
					if t:DistanceFromCharacter(K.HumanoidRootPart.Position) < 8 then
						Remote("BuyDragonTalon")
					end
					getgenv().BackupTween(K.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
			end
		end)
	end
	g["Dragon Talon"] = f
end)
SectionShopFighting.CreateToggle({ Title = "God Human", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g["God Human"] and (task.wait()) do
				pcall(function()
					local K = DetectNpc(G.BuyGodhuman)
					if t:DistanceFromCharacter(K.HumanoidRootPart.Position) < 8 then
						Remote("BuyGodhuman")
					end
					getgenv().BackupTween(K.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
			end
		end)
	end
	g["God Human"] = f
end)
SectionShopFighting.CreateToggle({ Title = "Sanguine Art", Desc = nil, Default = false }, function(f)
	if f then
		spawn(function()
			while g["Sanguine Art"] and (task.wait()) do
				pcall(function()
					local K = DetectNpc(G.BuySanguineArt)
					if t:DistanceFromCharacter(K.HumanoidRootPart.Position) < 8 then
						Remote("BuySanguineArt")
					end
					getgenv().BackupTween(K.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				end)
			end
		end)
	end
	g["Sanguine Art"] = f
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
PageStatusAndServer = Main.CreatePage({ Page_Name = "Status And Server", Page_Title = "Status And Server" })
-- ===================== Noijo Hub Status UI (v4) =====================
do
	local Players = game:GetService("Players")
	local lp = Players.LocalPlayer
	local env = getgenv()

	local UI_KEY = "Show Noijo Hub Status UI"
	local BLUE = Color3.fromRGB(70, 140, 255)
	local BG = Color3.fromRGB(10, 14, 26)

	-- 1) Chuỗi ưu tiên (mỗi lúc chỉ 1 cái chạy, chiếm StackFarm = false)
	local CHAIN = {
		"Auto New World",
		"Collect Chest When Server Spawn God's Chalice or Fist of Darkness",
		"Auto Third World", "Attack Darkbeard", "Summon Darkbeard",
		"Attack Rip Indra", "Auto Touch Pad Haki", "Auto Summon Rip Indra",
		"Attack Soul Reaper", "Summon Soul Reaper", "Attack Dough King", "Summon Dough King",
		"Auto Elite Hunter", "Auto Factory", "Auto Pirate Raid", "Teleport To Fruit",
		"Auto Quest Dojo Trainer",
	}
	-- 2) Nhóm bị chặn bởi StackFarmOther (bị tạm dừng khi chuỗi ưu tiên đang chạy)
	local GATED_OTHER = {
		"Auto Secret Quest", "Auto Fishing", "Auto Accept Quest Fishing",
		"Auto Attack All Mob and Boss", "Auto Chest", "Kill Mob",
	}
	-- 3) Nhóm farm chạy vòng lặp riêng (bật = đang chạy)
	local INDEPENDENT = {
		"Auto Quest Dragon Hunter", "Auto Collect Berry", "Auto Chest Hop",
		"Auto Buy Chip and Attack Law", "Auto UP Observation V2", "Farm Observation",
		"Farm Observation [ Hop Server ]", "Kill Boss", "Kill All Boss",
		"Auto Raid", "Auto Multi Raid", "Auto Awake Fruit", "Auto Join Dungeon", "Auto Attack Dungeon",
		"Auto Sea Event", "Auto Sea Event With Friend", "Auto Find Mirage", "Auto Spawn Kitsune Island",
		"Auto Summon Soul Ember", "Auto Collect Soul Ember", "Auto Trade Azure Ember",
		"Auto Find Leviathan", "Multi Find Leviathan", "Auto Start Leviathan", "Auto Attack Leviathan",
		"Auto Destroy IDK", "Auto Upgrade Race V2-V3", "Auto Upgrade Race V2-V3 Draco",
		"Auto Trial", "Auto Trial Draco", "Multi Trial", "Auto Pull Lever",
		"Auto Get Fully Cyborg", "Auto Get Cyborg", "Auto Get Ghoul",
		"Auto Finish Train Quest", "Auto Finish Train Draco Quest",
		"Auto Trade Bone", "Auto Get Rainbow Haki", "Auto Soul Guitar", "Auto CDK", "Auto Yama",
		"Auto Tushita", "Auto TTK", "Auto Saber", "Auto Craft Item Shark Anchor", "Auto Yoru Mini",
		"Auto Farm Mastery 600 Melees", "Auto Farm Mastery 600 Sword In Inventory",
		"Auto Upgrade Sword Inventory", "Auto Upgrade Gun Inventory",
		"Auto Crafting Volcanic Magnet", "Auto Find Prehistoric Island", "Auto Event Prehistoric Island",
		"Auto Collect Bone", "Auto Collect Egg",
	}

	-- ---------- Owner của chuỗi ưu tiên ----------
	-- Gọi ngay sau dòng `StackFarm = false` của từng nhánh: NoijoOwner("Tên toggle")
	local owner
	function env.NoijoOwner(name)
		owner = name
	end
	NoijoOwner = env.NoijoOwner

	local override, overrideUntil = nil, 0
	function env.SetNoijoStatus(text, ttl)
		override = text and tostring(text) or nil
		overrideUntil = tick() + (ttl or 4)
	end

	local hopDepth, teleportUntil = 0, 0
	pcall(function()
		lp.OnTeleport:Connect(function()
			teleportUntil = tick() + 8
		end)
	end)
	local wrapped = {}
	local function hookHop()
		for _, name in ipairs({ "HopServer", "HopLessAll" }) do
			local cur = env[name]
			if type(cur) == "function" and wrapped[name] ~= cur then
				local orig = cur
				local new = function(...)
					hopDepth = hopDepth + 1
					local r = table.pack(pcall(orig, ...))
					hopDepth = math.max(0, hopDepth - 1)
					if not r[1] then
						error(r[2], 0)
					end
					return table.unpack(r, 2, r.n)
				end
				wrapped[name] = new
				env[name] = new
			end
		end
	end

	-- ---------- Theo dõi di chuyển (fly) / đánh mob ----------
	local lastMoveCF, lastMoveT = nil, 0
	local lastBoatCF, lastBoatT = nil, 0
	local lastMob, lastMobT = nil, 0
	local lastFind, lastFindT = nil, 0

	local function mobName(E)
		if typeof(E) ~= "Instance" then
			return nil
		end
		if E:IsA("Model") then
			return E.Name
		end
		local p = E.Parent
		if p and p:IsA("Model") then
			return p.Name
		end
		return E.Name
	end
	local function onAttack(E)
		local n = mobName(E)
		if n then
			lastMob, lastMobT = n, tick()
		end
	end
	local function onMove(P)
		if typeof(P) == "CFrame" then
			lastMoveCF, lastMoveT = P, tick()
		end
	end
	local function onBoat(_, F)
		if typeof(F) == "CFrame" then
			lastBoatCF, lastBoatT = F, tick()
		end
	end
	local function onFind(Q)
		local txt
		if type(Q) == "string" then
			txt = Q
		elseif type(Q) == "table" then
			local names = {}
			for i = 1, math.min(#Q, 2) do
				if type(Q[i]) == "string" then
					names[#names + 1] = Q[i]
				end
			end
			if #names > 0 then
				txt = table.concat(names, "/")
			end
		end
		if txt then
			lastFind, lastFindT = txt, tick()
		end
	end

	local function wrap(orig, pre)
		return function(...)
			pcall(pre, ...)
			return orig(...)
		end
	end

	-- Các hàm được định nghĩa muộn nên bọc dần trong vòng lặp (chỉ bọc 1 lần cho mỗi hàm)
	local wTo, wBackup, wSize, wClick, wShoot, wDetect, wBoat
	local function hookMovement()
		if type(toTarget) == "function" and toTarget ~= wTo then
			wTo = wrap(toTarget, onMove)
			toTarget = wTo
		end
		if type(env.BackupTween) == "function" and env.BackupTween ~= wBackup then
			wBackup = wrap(env.BackupTween, onMove)
			env.BackupTween = wBackup
		end
		if type(sizepart) == "function" and sizepart ~= wSize then
			wSize = wrap(sizepart, onAttack)
			sizepart = wSize
		end
		if type(env.ClickM1) == "function" and env.ClickM1 ~= wClick then
			wClick = wrap(env.ClickM1, onAttack)
			env.ClickM1 = wClick
		end
		if type(ShootM1) == "function" and ShootM1 ~= wShoot then
			wShoot = wrap(ShootM1, onAttack)
			ShootM1 = wShoot
		end
		if type(DetectMob) == "function" and DetectMob ~= wDetect then
			wDetect = wrap(DetectMob, onFind)
			DetectMob = wDetect
		end
		if type(manageTween) == "function" and manageTween ~= wBoat then
			wBoat = wrap(manageTween, onBoat)
			manageTween = wBoat
		end
	end

	-- Tên đảo gần điểm đến nhất
	local locCache, locT = {}, 0
	local function placeName(cf)
		if typeof(cf) ~= "CFrame" then
			return "?"
		end
		if tick() - locT > 5 then
			locT = tick()
			locCache = {}
			pcall(function()
				for _, p in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
					if p:IsA("BasePart") then
						locCache[#locCache + 1] = { p.Name, p.Position }
					end
				end
			end)
		end
		local pos = cf.Position
		local best, bd = nil, math.huge
		for _, e in ipairs(locCache) do
			local dx, dz = e[2].X - pos.X, e[2].Z - pos.Z
			local d = math.sqrt(dx * dx + dz * dz)
			if d < bd then
				best, bd = e[1], d
			end
		end
		if best and bd < 1500 then
			return best
		end
		return string.format("%d, %d, %d", math.floor(pos.X), math.floor(pos.Y), math.floor(pos.Z))
	end

	-- ---------- Tính toggle farm đang HOẠT ĐỘNG ----------
	local function on(k)
		return Settings[k] == true
	end

	local function computeActive()
		local out = {}
		local stackFarm = StackFarm ~= false
		local stackOther = StackFarmOther ~= false

		-- Chuỗi ưu tiên đang chiếm quyền: chỉ hiện đúng nhánh đang chạy
		if not stackFarm or not stackOther then
			local name = owner
			if not (name and on(name)) then
				name = nil
				for _, k in ipairs(CHAIN) do
					if on(k) then
						name = k
						break
					end
				end
			end
			if name then
				out[#out + 1] = name
			end
		end

		-- Level farm: chỉ chạy khi StackFarm đang mở
		if stackFarm and on("Start Farm") then
			if on("Farm Material") then
				out[#out + 1] = "Farm Material : " .. tostring(Settings["Select Material"] or "?")
			else
				out[#out + 1] = "Start Farm : " .. tostring(Settings["Select Method Farm"] or "Level Farm")
			end
			if on("Farm Mastery") then
				out[#out + 1] = "Farm Mastery"
			end
		end

		-- Nhóm bị tạm dừng khi chuỗi ưu tiên chạy
		if stackOther then
			for _, k in ipairs(GATED_OTHER) do
				if on(k) then
					out[#out + 1] = k
				end
			end
		end

		-- Nhóm chạy vòng lặp riêng
		for _, k in ipairs(INDEPENDENT) do
			if on(k) then
				out[#out + 1] = k
			end
		end
		return out
	end

	local function autoStatus(active)
		if hopDepth > 0 then
			return "Hopping server..."
		end
		if tick() < teleportUntil then
			return "Teleporting..."
		end
		local char = lp.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if not hum or hum.Health <= 0 then
			return "Waiting for respawn..."
		end

		local now = tick()
		local act = active[1]
		local suffix = act and (" | " .. act) or ""

		-- Đang đánh mob / boss (mọi chế độ farm): ghi rõ tên
		if lastMob and now - lastMobT < 1.5 then
			return "Fighting " .. lastMob .. suffix
		end
		-- Đang lái thuyền
		if lastBoatCF and now - lastBoatT < 1.5 then
			return "Sailing boat to " .. placeName(lastBoatCF) .. suffix
		end
		-- Đang bay/tween tới điểm đến
		if lastMoveCF and now - lastMoveT < 1.0 then
			local find = (lastFind and now - lastFindT < 2) and (" (find " .. lastFind .. ")") or ""
			return "Traveling to " .. placeName(lastMoveCF) .. find .. suffix
		end

		-- Không di chuyển / không đánh: mô tả việc đang làm
		if not act then
			return "Idle"
		end
		if string.sub(act, 1, 10) == "Start Farm" then
			local okQ, quest = pcall(GetQuestTitle)
			if okQ and quest then
				return act .. " | waiting mob : " .. string.sub(tostring(quest), 1, 50)
			end
			return act .. " | taking quest..."
		end
		return "Running : " .. act
	end

	-- ---------- UI ----------
	local function getParent()
		if gethui then
			local ok, ui = pcall(gethui)
			if ok and ui then
				return ui
			end
		end
		local ok, core = pcall(function()
			return game:GetService("CoreGui")
		end)
		if ok and core then
			return core
		end
		return lp:WaitForChild("PlayerGui")
	end

	local parent = getParent()
	local old = parent:FindFirstChild("NoijoHubStatusUI")
	if old then
		old:Destroy()
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "NoijoHubStatusUI"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 999
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.Enabled = Settings[UI_KEY] ~= false
	gui.Parent = parent

	local frame = Instance.new("Frame")
	frame.Name = "Main"
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.Position = UDim2.new(0.5, 0, 0, 12)
	frame.Size = UDim2.new(0.9, 0, 0, 0)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.BackgroundColor3 = BG
	frame.BackgroundTransparency = 0.05
	frame.BorderSizePixel = 0
	frame.Parent = gui

	local sizeLimit = Instance.new("UISizeConstraint")
	sizeLimit.MaxSize = Vector2.new(480, math.huge)
	sizeLimit.Parent = frame
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 16)
	corner.Parent = frame
	local stroke = Instance.new("UIStroke")
	stroke.Color = BLUE
	stroke.Thickness = 2
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = frame
	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 22)
	padding.PaddingRight = UDim.new(0, 22)
	padding.PaddingTop = UDim.new(0, 14)
	padding.PaddingBottom = UDim.new(0, 14)
	padding.Parent = frame
	local list = Instance.new("UIListLayout")
	list.SortOrder = Enum.SortOrder.LayoutOrder
	list.Padding = UDim.new(0, 6)
	list.Parent = frame

	local function makeLabel(text, color, size, order)
		local l = Instance.new("TextLabel")
		l.BackgroundTransparency = 1
		l.Size = UDim2.new(1, 0, 0, 0)
		l.AutomaticSize = Enum.AutomaticSize.Y
		l.Font = Enum.Font.GothamBold
		l.Text = text
		l.TextColor3 = color
		l.TextSize = size
		l.TextWrapped = true
		l.TextXAlignment = Enum.TextXAlignment.Left
		l.LayoutOrder = order
		l.Parent = frame
		return l
	end

	makeLabel("BananaCat Status", BLUE, 20, 1)
	local statusLabel = makeLabel("Status : ...", Color3.fromRGB(255, 255, 255), 18, 2)

	local lastStatus
	local function refresh()
		local active = computeActive()
		local text = (override and tick() < overrideUntil) and override or autoStatus(active)
		local st = "Status : " .. text
		if st ~= lastStatus then
			lastStatus = st
			statusLabel.Text = st
		end
	end

	task.spawn(function()
		while gui.Parent do
			pcall(hookHop)
			pcall(hookMovement)
			pcall(refresh)
			task.wait(0.3)
		end
	end)

	-- ---------- Toggle ở đầu tab Status And Server ----------
	local SectionStatusUI = PageStatusAndServer.CreateSection("Noijo Hub Status UI")
	SectionStatusUI.CreateToggle({
		Title = "Show Noijo Hub Status UI",
		Desc = "Show what the script is doing at the top of the screen",
		Default = Settings[UI_KEY] ~= false,
	}, function(v)
		SaveSettings(UI_KEY, v)
		gui.Enabled = v
	end)
end
-- ===================== end Noijo Hub Status UI =====================
SectionStatus = PageStatusAndServer.CreateSection("Status")
TimerLabel = SectionStatus.CreateLabel({ Title = "Timer" })
TimerServerLabel = SectionStatus.CreateLabel({ Title = "Timer Server" })
NextTimerServerLabel = SectionStatus.CreateLabel({ Title = "Next Time Spawn Fist of Darkness or God's Chalice" })
StatusEliteHunter = SectionStatus.CreateLabel({ Title = "Elite" })
StatusTyrant = SectionStatus.CreateLabel({ Title = "Eyes Summon Tyrant" })
StatusKatakuri = SectionStatus.CreateLabel({ Title = "Summon Katakuri" })
Statusspy = SectionStatus.CreateLabel({ Title = "Status SPY" })
StatusMirage = SectionStatus.CreateLabel({ Title = "Mirage" })
StatusPrehistoricIsland = SectionStatus.CreateLabel({ Title = "Prehistoric Island" })
StatusFrozenDimension = SectionStatus.CreateLabel({ Title = "Frozen Dimension" })
StatusMoon = SectionStatus.CreateLabel({ Title = "Moon" })
StatusGear = SectionStatus.CreateLabel({ Title = "Acient One Status" })
SectionServer = PageStatusAndServer.CreateSection("Server")
SectionServer.CreateButton({ Title = "Open Gui Server Browser (Low Player and Ping)" }, function()
	local G = game:GetService("HttpService")
	game:GetService("TeleportService")
	local f, K = game:GetService("Players"), game:GetService("TweenService")
	local R, R, m = f.LocalPlayer, game.PlaceId, syn and syn.request or http_request or request
	if not m then
		warn("[ServerBrowser] Executor does not support http_request")
		return
	end
	if game.CoreGui:FindFirstChild("SB_UI") then
		game.CoreGui.SB_UI:Destroy()
	end
	local E, l, Q =
		{ servers = {}, cursor = nil, finished = false, lastUpdate = 0, pages = 0 },
		{
			CACHE_TIME = 60,
			MAX_SHOW = 50,
			PAGE_DELAY = 5,
			RETRY_MAX = 4,
			RETRY_BASE = 2,
			RETRY_JITTER = 5,
			RATE_COOLDOWN = 30,
		},
		{
			BG = Color3.fromRGB(10, 11, 16),
			SURFACE = Color3.fromRGB(13, 14, 20),
			ROW = Color3.fromRGB(16, 17, 26),
			ROW_HOVER = Color3.fromRGB(20, 22, 35),
			ROW_TOP = Color3.fromRGB(10, 22, 34),
			BORDER = Color3.fromRGB(28, 31, 48),
			BORDER_HOV = Color3.fromRGB(0, 80, 120),
			CYAN = Color3.fromRGB(0, 212, 255),
			CYAN_DIM = Color3.fromRGB(0, 80, 120),
			GREEN = Color3.fromRGB(0, 204, 102),
			GREEN_GLOW = Color3.fromRGB(0, 255, 136),
			AMBER = Color3.fromRGB(255, 170, 0),
			RED = Color3.fromRGB(255, 68, 85),
			TEXT_PRI = Color3.fromRGB(232, 234, 240),
			TEXT_SEC = Color3.fromRGB(80, 90, 120),
			TEXT_DIM = Color3.fromRGB(45, 52, 82),
		}
	local function S(L, d, I)
		local _ = Instance.new(L)
		for L, o in pairs(d or {}) do
			_[L] = o
		end
		if I then
			_.Parent = I
		end
		return _
	end
	local function L(d, I)
		return S("UICorner", { CornerRadius = UDim.new(0, d) }, I)
	end
	local function d(I, _, o, V)
		return S("UIStroke", { Thickness = I, Color = _, Transparency = o or 0 }, V)
	end
	local function I(_, o, V, N, y)
		K:Create(_, TweenInfo.new(V or 0.15, N or Enum.EasingStyle.Quad, y or Enum.EasingDirection.Out), o):Play()
	end
	local function K(_, o, V)
		_.MouseEnter:Connect(function()
			I(_, { BackgroundColor3 = V })
		end)
		_.MouseLeave:Connect(function()
			I(_, { BackgroundColor3 = o })
		end)
	end
	local function _()
		return math.random() * l.RETRY_JITTER
	end
	local o = S(
		"ScreenGui",
		{ Name = "SB_UI", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true },
		game.CoreGui
	)
	local V = S(
		"Frame",
		{
			Name = "Window",
			Size = UDim2.new(0, 580, 0, 500),
			Position = UDim2.new(0.5, -290, 0.5, -250),
			BackgroundColor3 = Q.SURFACE,
			BorderSizePixel = 0,
			ClipsDescendants = true,
		},
		o
	)
	L(4, V)
	d(1, Q.BORDER, 0, V)
	do
		local N, y, x
		V.InputBegan:Connect(function(k)
			if k.UserInputType == Enum.UserInputType.MouseButton1 then
				N = true
				y = k.Position
				x = V.Position
			end
		end)
		V.InputEnded:Connect(function(k)
			local P, e = k.UserInputType, Enum.UserInputType.MouseButton1
			if P == e then
				N = false
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(k)
			if N and k.UserInputType == Enum.UserInputType.MouseMovement then
				local N = k.Position - y
				V.Position = UDim2.new(x.X.Scale, x.X.Offset + N.X, x.Y.Scale, x.Y.Offset + N.Y)
			end
		end)
	end
	f = S("Frame", { Size = UDim2.new(1, 0, 0, 52), BackgroundColor3 = Q.BG, BorderSizePixel = 0 }, V)
	S(
		"TextLabel",
		{
			Size = UDim2.new(0, 300, 0, 18),
			Position = UDim2.new(0, 18, 0, 9),
			BackgroundTransparency = 1,
			Text = "SERVER BROWSER",
			TextColor3 = Q.TEXT_PRI,
			Font = Enum.Font.GothamBold,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
		},
		f
	)
	S(
		"TextLabel",
		{
			Size = UDim2.new(0, 360, 0, 14),
			Position = UDim2.new(0, 18, 0, 30),
			BackgroundTransparency = 1,
			Text = "CACHE PAGE \194\183 LOAD MORE \194\183 LOWEST PLAYER / PING",
			TextColor3 = Q.TEXT_DIM,
			Font = Enum.Font.Gotham,
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Left,
		},
		f
	)
	local N = S(
		"TextButton",
		{
			Size = UDim2.new(0, 28, 0, 28),
			Position = UDim2.new(1, -42, 0, 12),
			BackgroundColor3 = Color3.fromRGB(26, 13, 13),
			BorderSizePixel = 0,
			Text = "X",
			TextColor3 = Q.RED,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
		},
		f
	)
	L(3, N)
	K(N, Color3.fromRGB(26, 13, 13), Color3.fromRGB(60, 20, 20))
	N.MouseButton1Click:Connect(function()
		o:Destroy()
	end)
	f = S(
		"Frame",
		{
			Size = UDim2.new(1, 0, 0, 42),
			Position = UDim2.new(0, 0, 0, 52),
			BackgroundColor3 = Color3.fromRGB(11, 12, 17),
			BorderSizePixel = 0,
		},
		V
	)
	local o = S(
		"Frame",
		{
			Size = UDim2.new(0, 6, 0, 6),
			Position = UDim2.new(0, 14, 0.5, -3),
			BackgroundColor3 = Q.TEXT_DIM,
			BorderSizePixel = 0,
		},
		f
	)
	L(99, o)
	local N, y =
		S(
			"TextLabel",
			{
				Size = UDim2.new(1, -300, 1, 0),
				Position = UDim2.new(0, 26, 0, 0),
				BackgroundTransparency = 1,
				Text = "READY",
				TextColor3 = Q.TEXT_SEC,
				Font = Enum.Font.Gotham,
				TextSize = 11,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			f
		),
		S(
			"TextButton",
			{
				Size = UDim2.new(0, 82, 0, 26),
				Position = UDim2.new(1, -270, 0.5, -13),
				BackgroundColor3 = Color3.fromRGB(14, 22, 40),
				BorderSizePixel = 0,
				Text = "REFRESH",
				TextColor3 = Color3.fromRGB(100, 140, 200),
				Font = Enum.Font.GothamBold,
				TextSize = 10,
			},
			f
		)
	L(3, y)
	K(y, Color3.fromRGB(14, 22, 40), Color3.fromRGB(10, 30, 55))
	local x = S(
		"TextButton",
		{
			Size = UDim2.new(0, 82, 0, 26),
			Position = UDim2.new(1, -182, 0.5, -13),
			BackgroundColor3 = Color3.fromRGB(16, 32, 24),
			BorderSizePixel = 0,
			Text = "LOAD MORE",
			TextColor3 = Q.GREEN,
			Font = Enum.Font.GothamBold,
			TextSize = 10,
		},
		f
	)
	L(3, x)
	K(x, Color3.fromRGB(16, 32, 24), Color3.fromRGB(10, 48, 28))
	local k = S(
		"TextButton",
		{
			Size = UDim2.new(0, 82, 0, 26),
			Position = UDim2.new(1, -94, 0.5, -13),
			BackgroundColor3 = Color3.fromRGB(38, 18, 18),
			BorderSizePixel = 0,
			Text = "RESET",
			TextColor3 = Q.RED,
			Font = Enum.Font.GothamBold,
			TextSize = 10,
		},
		f
	)
	L(3, k)
	K(k, Color3.fromRGB(38, 18, 18), Color3.fromRGB(60, 20, 20))
	local P = S(
		"Frame",
		{
			Size = UDim2.new(1, 0, 0, 24),
			Position = UDim2.new(0, 0, 0, 94),
			BackgroundColor3 = Color3.fromRGB(11, 12, 17),
			BorderSizePixel = 0,
		},
		V
	)
	local function e(Y, H, B)
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, B, 1, 0),
				Position = UDim2.new(0, H, 0, 0),
				BackgroundTransparency = 1,
				Text = Y,
				TextColor3 = Q.TEXT_DIM,
				Font = Enum.Font.GothamBold,
				TextSize = 9,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			P
		)
	end
	e("#", 14, 28)
	e("JOB ID", 42, 170)
	e("PLAYERS", 220, 80)
	e("PING", 310, 60)
	local P = S(
		"ScrollingFrame",
		{
			Size = UDim2.new(1, -8, 1, -172),
			Position = UDim2.new(0, 4, 0, 118),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = Q.CYAN_DIM,
			CanvasSize = UDim2.new(0, 0, 0, 0),
		},
		V
	)
	local e = S("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder }, P)
	S(
		"UIPadding",
		{
			PaddingTop = UDim.new(0, 6),
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
			PaddingBottom = UDim.new(0, 6),
		},
		P
	)
	f = S(
		"Frame",
		{
			Size = UDim2.new(1, 0, 0, 30),
			Position = UDim2.new(0, 0, 1, -30),
			BackgroundColor3 = Color3.fromRGB(10, 11, 15),
			BorderSizePixel = 0,
		},
		V
	)
	local Y, H, B =
		S(
			"TextLabel",
			{
				Size = UDim2.new(0.5, 0, 1, 0),
				Position = UDim2.new(0, 14, 0, 0),
				BackgroundTransparency = 1,
				Text = "PLACE \194\183 " .. tostring(R),
				TextColor3 = Q.TEXT_DIM,
				Font = Enum.Font.Gotham,
				TextSize = 9,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			f
		),
		S(
			"TextLabel",
			{
				Size = UDim2.new(0.5, -14, 1, 0),
				Position = UDim2.new(0.5, 0, 0, 0),
				BackgroundTransparency = 1,
				Text = "SHOWING 0 / 0",
				TextColor3 = Q.TEXT_DIM,
				Font = Enum.Font.Gotham,
				TextSize = 9,
				TextXAlignment = Enum.TextXAlignment.Right,
			},
			f
		),
		S(
			"Frame",
			{
				Size = UDim2.new(1, 0, 1, -52),
				Position = UDim2.new(0, 0, 0, 52),
				BackgroundColor3 = Q.SURFACE,
				BackgroundTransparency = 0.05,
				ZIndex = 20,
				Visible = false,
			},
			V
		)
	local f, Z =
		S(
			"TextLabel",
			{
				Size = UDim2.new(1, -20, 0, 36),
				Position = UDim2.new(0, 10, 0.5, 10),
				BackgroundTransparency = 1,
				Text = "SCANNING SERVERS...",
				TextColor3 = Q.CYAN,
				Font = Enum.Font.GothamBold,
				TextSize = 10,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextWrapped = true,
				ZIndex = 21,
			},
			B
		),
		S(
			"Frame",
			{
				Size = UDim2.new(1, -8, 0, 28),
				Position = UDim2.new(0, 4, 0, 118),
				BackgroundColor3 = Color3.fromRGB(38, 24, 6),
				BorderSizePixel = 0,
				ZIndex = 15,
				Visible = false,
			},
			V
		)
	L(3, Z)
	d(1, Q.AMBER, 0.4, Z)
	local C = S(
		"TextLabel",
		{
			Size = UDim2.new(1, -12, 1, 0),
			Position = UDim2.new(0, 6, 0, 0),
			BackgroundTransparency = 1,
			Text = "\226\143\179 429 RATE LIMITED \226\128\148 WAITING...",
			TextColor3 = Q.AMBER,
			Font = Enum.Font.GothamBold,
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Center,
			ZIndex = 16,
		},
		Z
	)
	local function J(F)
		C.Text = F
		Z.Visible = true
		P.Position = UDim2.new(0, 4, 0, 150)
		P.Size = UDim2.new(1, -8, 1, -204)
	end
	local function F()
		Z.Visible = false
		P.Position = UDim2.new(0, 4, 0, 118)
		P.Size = UDim2.new(1, -8, 1, -172)
	end
	local q = S(
		"Frame",
		{
			Size = UDim2.new(0, 360, 0, 36),
			Position = UDim2.new(0.5, -180, 1, -50),
			BackgroundColor3 = Color3.fromRGB(10, 26, 40),
			BorderSizePixel = 0,
			ZIndex = 30,
			Visible = false,
		},
		V
	)
	L(3, q)
	local V = S(
		"TextLabel",
		{
			Size = UDim2.new(1, -12, 1, 0),
			Position = UDim2.new(0, 6, 0, 0),
			BackgroundTransparency = 1,
			Text = "READY",
			TextColor3 = Q.CYAN,
			Font = Enum.Font.GothamBold,
			TextSize = 10,
			TextWrapped = true,
			ZIndex = 31,
		},
		q
	)
	local c
	local function D(r, n)
		if c then
			task.cancel(c)
		end
		V.Text = r
		V.TextColor3 = n or Q.CYAN
		q.Visible = true
		c = task.delay(3.5, function()
			q.Visible = false
		end)
	end
	local function V(q, c)
		N.Text = q
		o.BackgroundColor3 = c or Q.TEXT_DIM
	end
	local function o(N)
		return ({
			RATE_LIMIT = "429 RATE LIMITED \226\128\148 TOO MANY REQUESTS",
			FORBIDDEN = "403 FORBIDDEN \226\128\148 ACCESS BLOCKED",
			UNAUTHORIZED = "401 UNAUTHORIZED",
			SERVER_ERROR = "5xx ROBLOX SERVER ERROR",
			NETWORK_ERROR = "NETWORK / EXECUTOR ERROR",
			INVALID_JSON = "INVALID JSON RESPONSE",
			EMPTY_BODY = "EMPTY RESPONSE BODY",
		})[N] or "REQUEST FAILED: " .. tostring(N)
	end
	local function N(q, c)
		local r = 0
		for n = 0, l.RETRY_MAX, 1 do repeat 
			local u, W = pcall(function()
				return m({
					Url = q,
					Method = "GET",
					Headers = { ["User-Agent"] = "Mozilla/5.0", Accept = "application/json" },
				})
			end)
			if not u or not W then
				return nil, "NETWORK_ERROR"
			end
			u = W.StatusCode or W.Status or 0
			if u == 429 then
				r = r + (1)
				if n >= l.RETRY_MAX then
					return nil, "RATE_LIMIT"
				end
				local m = (function() if r >= 2 then return l.RATE_COOLDOWN + _() else return math.pow(l.RETRY_BASE, n + 1) + _() end end)()
				local _ = string.format(
					"\226\143\179 429 RATE LIMITED \226\128\148 WAITING %.0fs THEN RETRYING (%d/%d)",
					m,
					n + 1,
					l.RETRY_MAX
				)
				if c then
					J(_)
					B.Visible = false
				else
					B.Visible = true
					f.Text = _
				end
				V("RATE LIMITED \226\128\148 WAITING " .. math.floor(m) .. "s", Q.AMBER)
				D(string.format("\226\143\179 429 \226\128\148 RETRYING IN %.0fs", m), Q.AMBER)
				warn(
					string.format(
						"[ServerBrowser] 429 \226\128\148 waiting %.1fs (attempt %d/%d)",
						m,
						n + 1,
						l.RETRY_MAX
					)
				)
				local _ = math.floor(m)
				task.spawn(function()
					while _ > 0 do
						task.wait(1)
						_ = _ - (1)
						local q = string.format(
							"\226\143\179 429 RATE LIMITED \226\128\148 %.0fs REMAINING (%d/%d)",
							_,
							n + 1,
							l.RETRY_MAX
						)
						if c then
							if Z.Visible then
								C.Text = q
							end
						elseif B.Visible then
							f.Text = q
						end
					end
				end)
				task.wait(m)
				if c then
					F()
				end
				break
			end
			if u == 403 then
				return nil, "FORBIDDEN"
			end
			if u == 401 then
				return nil, "UNAUTHORIZED"
			end
			if u >= 500 then
				return nil, "SERVER_ERROR"
			end
			if u ~= 200 and u ~= 0 then
				return nil, "HTTP_" .. tostring(u)
			end
			if not W.Body or W.Body == "" then
				return nil, "EMPTY_BODY"
			end
			local m, _ = pcall(G.JSONDecode, G, W.Body)
			if not m or not _ then
				return nil, "INVALID_JSON"
			end
			return _, nil
		until true end
		return nil, "RATE_LIMIT"
	end
	local function m()
		for _, _ in ipairs(P:GetChildren()) do
			if _:IsA("Frame") then
				_:Destroy()
			end
		end
	end
	local function _()
		table.sort(E.servers, function(Z, C)
			local q, c = Z.playing or 999, C.playing or 999
			if q ~= c then
				return q < c
			end
			return (Z.ping or 999) < (C.ping or 999)
		end)
	end
	local function Z(C)
		if C < 100 then
			return Q.GREEN_GLOW
		elseif C < 200 then
			return Q.AMBER
		else
			return Q.RED
		end
	end
	local function C(q)
		if q > 0.8 then
			return Q.RED
		elseif q > 0.5 then
			return Q.AMBER
		else
			return Q.CYAN
		end
	end
	local function q(c, r)
		local n = r == 1
		local u = n and Q.ROW_TOP or Q.ROW
		local W =
			S("Frame", { Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = u, BorderSizePixel = 0, LayoutOrder = r }, P)
		L(3, W)
		local O = d(1, n and Q.CYAN_DIM or Q.BORDER, 0, W)
		W.MouseEnter:Connect(function()
			I(W, { BackgroundColor3 = Q.ROW_HOVER })
			I(O, { Color = Q.BORDER_HOV })
		end)
		W.MouseLeave:Connect(function()
			I(W, { BackgroundColor3 = u })
			I(O, { Color = n and Q.CYAN_DIM or Q.BORDER })
		end)
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, 28, 1, 0),
				Position = UDim2.new(0, 10, 0, 0),
				BackgroundTransparency = 1,
				Text = string.format("%02d", r),
				TextColor3 = n and Q.CYAN or Q.TEXT_DIM,
				Font = Enum.Font.GothamBold,
				TextSize = 11,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			W
		)
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, 160, 0, 14),
				Position = UDim2.new(0, 44, 0, 8),
				BackgroundTransparency = 1,
				Text = tostring(c.id):sub(1, 18) .. "...",
				TextColor3 = Color3.fromRGB(60, 75, 110),
				Font = Enum.Font.Code,
				TextSize = 10,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			W
		)
		local d, I = c.playing or 0, c.maxPlayers or 20
		r = d / math.max(I, 1)
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, 80, 0, 14),
				Position = UDim2.new(0, 44, 0, 26),
				BackgroundTransparency = 1,
				Text = d .. "/" .. I .. " players",
				TextColor3 = Q.TEXT_DIM,
				Font = Enum.Font.Gotham,
				TextSize = 9,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			W
		)
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, 50, 0, 20),
				Position = UDim2.new(0, 210, 0, 4),
				BackgroundTransparency = 1,
				Text = tostring(d),
				TextColor3 = Q.TEXT_PRI,
				Font = Enum.Font.GothamBold,
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			W
		)
		d = S(
			"Frame",
			{
				Size = UDim2.new(0, 50, 0, 2),
				Position = UDim2.new(0, 210, 0, 28),
				BackgroundColor3 = Color3.fromRGB(22, 24, 36),
				BorderSizePixel = 0,
			},
			W
		)
		L(1, d)
		L(
			1,
			S(
				"Frame",
				{ Size = UDim2.new(math.clamp(r, 0, 1), 0, 1, 0), BackgroundColor3 = C(r), BorderSizePixel = 0 },
				d
			)
		)
		d = c.ping or 999
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, 55, 1, 0),
				Position = UDim2.new(0, 278, 0, 0),
				BackgroundTransparency = 1,
				Text = d .. "ms",
				TextColor3 = Z(d),
				Font = Enum.Font.GothamBold,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			W
		)
		d = S(
			"TextButton",
			{
				Size = UDim2.new(0, 72, 0, 28),
				Position = UDim2.new(1, -82, 0.5, -14),
				BackgroundColor3 = Color3.fromRGB(10, 30, 18),
				BorderSizePixel = 0,
				Text = "JOIN",
				TextColor3 = Q.GREEN,
				Font = Enum.Font.GothamBold,
				TextSize = 10,
			},
			W
		)
		L(3, d)
		K(d, Color3.fromRGB(10, 30, 18), Color3.fromRGB(8, 44, 24))
		d.MouseButton1Click:Connect(function()
			D("TELEPORTING TO " .. tostring(c.id):sub(1, 16) .. "...", Q.CYAN)
			local K, S = pcall(function()
				game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", c.id)
			end)
			if not K then
				D("TELEPORT FAILED: " .. tostring(S), Q.RED)
				V("TELEPORT FAILED", Q.RED)
			end
		end)
	end
	local function K()
		m()
		_()
		local S = #E.servers
		local L = math.min(S, l.MAX_SHOW)
		for d = 1, L, 1 do
			q(E.servers[d], d)
		end
		P.CanvasSize = UDim2.new(0, 0, 0, e.AbsoluteContentSize.Y + 16)
		H.Text = "SHOWING " .. L .. " / " .. S
		Y.Text = "PLACE \194\183 " .. tostring(R) .. " \194\183 PAGE " .. tostring(E.pages)
		if E.finished then
			V("CACHE DONE \226\128\148 " .. S .. " SERVERS", Q.GREEN_GLOW)
		else
			V("CACHE SAVED \226\128\148 " .. S .. " SERVERS \226\128\148 PAGE " .. E.pages, Q.CYAN)
		end
	end
	local function S()
		E.servers = {}
		E.cursor = nil
		E.finished = false
		E.lastUpdate = 0
		E.pages = 0
		F()
		m()
		H.Text = "SHOWING 0 / 0"
		Y.Text = "PLACE \194\183 " .. tostring(R)
		V("CACHE RESET", Q.RED)
		D("CACHE RESET", Q.RED)
	end
	local m = false
	local function L(d, I)
		if m then
			return
		end
		m = true
		if I then
			S()
		end
		y.Active = false
		x.Active = false
		k.Active = false
		y.Text = "LOADING"
		x.Text = "WAIT"
		local _, P = 0
		repeat
			if E.finished then
				break
			end
			_ = _ + (1)
			E.pages = E.pages + 1
			I = #E.servers > 0
			if I then
				B.Visible = false
			else
				B.Visible = true
				f.Text = "SCANNING PAGE " .. E.pages .. "\226\128\166"
			end
			V("PAGE " .. E.pages .. " \226\128\148 " .. #E.servers .. " FOUND", Q.AMBER)
			local e = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(R)
			local R, Y = N((function() if E.cursor then return e .. "&cursor=" .. G:UrlEncode(E.cursor) else return e end end)(), I)
			if not R then
				e = o(Y)
				if not I then
					f.Text = e
				end
				V(e, Q.RED)
				D(e, Q.RED)
				warn("[ServerBrowser] " .. e .. " | Page: " .. E.pages)
				P = Y
				break
			end
			for G, G in ipairs(R.data or {}) do
				if G.id and G.id ~= game.JobId then
					e, Y = G.playing or 0, G.maxPlayers or 0
					if Y == 0 or e < Y then
						table.insert(E.servers, G)
					end
				end
			end
			E.cursor = R.nextPageCursor
			E.lastUpdate = tick()
			if not E.cursor or E.cursor == "" then
				E.finished = true
				E.cursor = nil
			end
			if not E.finished and _ < d then
				R = string.format("PAGE %d DONE \226\128\148 WAITING %.1fs\226\128\166", E.pages, l.PAGE_DELAY)
				if #E.servers > 0 then
					K()
					J(R)
				else
					f.Text = R
				end
				V(R, Q.CYAN)
				task.wait(l.PAGE_DELAY)
				F()
			end
		until _ >= d
		B.Visible = false
		F()
		K()
		if P then
			if #E.servers > 0 then
				D(o(P) .. " \226\128\148 SHOWING " .. #E.servers .. " CACHED", Q.AMBER)
				V(o(P) .. " | PARTIAL " .. #E.servers, Q.AMBER)
			else
				V(o(P), Q.RED)
			end
		elseif E.finished then
			V("FULL SCAN DONE \226\128\148 " .. #E.servers .. " SERVERS", Q.GREEN_GLOW)
			D("SCAN COMPLETE \226\128\148 " .. #E.servers .. " SERVERS", Q.GREEN_GLOW)
		else
			V("PAGE SAVED \226\128\148 CLICK LOAD MORE TO CONTINUE", Q.CYAN)
		end
		y.Active = true
		x.Active = true
		k.Active = true
		y.Text = "REFRESH"
		x.Text = "LOAD MORE"
		m = false
	end
	y.MouseButton1Click:Connect(function()
		task.spawn(function()
			local G = tick() - E.lastUpdate
			if #E.servers > 0 and G <= l.CACHE_TIME then
				K()
				D("CACHE STILL FRESH (" .. math.floor(l.CACHE_TIME - G) .. "s) \226\128\148 RESET TO RELOAD", Q.CYAN)
				return
			end
			L(2, true)
		end)
	end)
	x.MouseButton1Click:Connect(function()
		task.spawn(function()
			if E.finished then
				D("ALL PAGES LOADED \226\128\148 NO MORE SERVERS", Q.AMBER)
				V("NO MORE PAGES", Q.AMBER)
				return
			end
			L(2, false)
		end)
	end)
	k.MouseButton1Click:Connect(function()
		if not m then
			S()
		end
	end)
	task.spawn(function()
		L(2, true)
	end)
end)
StatusPlaceId = SectionServer.CreateLabel({ Title = "PlaceId: " .. game.PlaceId })
local G = ""
SectionServer.CreateBox(
	{ Title = "Input JobId Normal And JobId BananaCat", Placeholder = "Type here", Number = false, Default = nil },
	function(f)
		G = f
	end
)
SectionServer.CreateToggle({ Title = "Spam Join", Desc = nil, Default = Settings["Spam Join"] or false }, function(f)
	SaveSettings("Spam Join", f)
end)
if not (bit32 or bit) then
	({}).bxor = function(f, K)
		local R, m = 0, 1
		while f > 0 or K > 0 do
			local E, l = f % 2, K % 2
			f, K, R, m = (f - E) / 2, (K - l) / 2, (function() if E ~= l then return R + m else return R end end)(), m * 2
		end
		return R
	end
end
local f = loadstring(
	'local function EQ(a, r)\10 local b, c = nil, nil\10 local success = pcall(function()\10 b, c = a, r\10 end)\10\10 if not success or b == nil or c == nil then\10 return false\10 end\10\10 if type(b) ~= type(c) then\10 return false\10 end\10\10 local d = { c, b, c, b }\10 if d[1] ~= d[1] then\10 return false\10 end\10 if d[1] ~= d[2] then\10 return false\10 end\10 if d[2] ~= d[1] then\10 return false\10 end\10\10 local e, f, g = 1 and 2, 2 and nil, true == not not true\10\10 if type(b) == "number" and type(c) == "number" then\10 if e and g and not f then\10 return b == c\10 end\10 elseif type(b) == "string" and type(c) == "string" then\10 if e and g then\10 return b == c\10 end\10 else\10 return b == c\10 end\10\10 return false\10end\10\10local function _vrf()\10 local x = os.time and os.time() or 12345\10 if tostring(print):find("function") == nil then\10 while true do\10 end\10 end\10 if tostring(type):find("function") == nil then\10 while true do\10 end\10 end\10 if (x * x + x) % 2 ~= 0 then\10 while true do\10 end\10 end\10 if not EQ(x, x) then\10 while true do\10 end\10 end\10end\10\10local function _gct()\10 _vrf()\10 local s, p1, p2, p3 = 17, {}, {}, {}\10 local _m = { [17] = 23, [23] = 41, [41] = 999 }\10\10 while true do\10 if s == 17 then\10 for i = 0, 255 do\10 local c = ("%c"):format(i)\10 p1[i] = c\10 p2[c] = i\10 end\10 s = _m[17]\10 elseif s == 23 then\10 for i = 0, 255 do\10 p3[i] = p1[i]\10 end\10 s = _m[23]\10 elseif s == 41 then\10 if EQ(s, 41) then\10 return p3, p2\10 else\10 while true do\10 end\10 end\10 else\10 while true do\10 end\10 end\10 end\10end\10\10local _CT, _BT = _gct()\10\10local _sp = (function()\10 local _xk = { 0x61, 0x9A, 0x43, 0xF1, 0x27, 0xBC, 0x58, 0x0D, 0xE7, 0x33 }\10\10 local _enc = {\10 { 0x9A, 0x71, 0x24, 0xEF, 0x38, 0x4C },\10 { 0x7D, 0xA1, 0x55, 0x92, 0xB7, 0x44, 0x18 },\10 { 0x2F, 0xC3, 0x89, 0x11, 0xD4, 0x67 },\10 { 0xA8, 0x3E, 0xD1, 0x5B },\10 { 0x44, 0xE2, 0x71, 0x9C, 0x0A, 0xD8, 0x61, 0xF4 },\10 { 0x1E, 0x7B, 0xC0, 0x35, 0x92, 0xAF, 0x4D, 0x28 },\10 { 0xF3, 0x60, 0x1A, 0x87, 0xCE, 0x39, 0x54 },\10 { 0x88, 0x2D, 0xB6, 0x41, 0xFA, 0x73, 0x19, 0xCC, 0x05 },\10 }\10\10 local function _dec(data, seed)\10 local result = ""\10 local state = seed or 0x53\10\10 for i = 1, #data do\10 local byte = data[i]\10 local keyIdx = ((i - 1) % #_xk) + 1\10 local key = _xk[keyIdx]\10\10 byte = bit32.bxor(byte, key)\10 byte = (byte - state + 256) % 256\10 byte = bit32.bxor(byte, (i * 23) % 256)\10 state = (state + i + key + 17) % 256\10\10 result = result .. _CT[byte]\10 end\10\10 return result\10 end\10\10 local _d = {}\10 for i = 1, #_enc do\10 _d[i] = _dec(_enc[i], (i * 0x29) % 256)\10 end\10\10 return _d\10end)()\10\10local function _gb(str, pos)\10 _vrf()\10 local c, s = 0, 5\10 local _states = { [5] = 7, [7] = 11, [11] = 999 }\10\10 while true do\10 if s == 5 then\10 for ch in str:gmatch(".") do\10 c = c + 1\10 if c == pos then\10 s = _states[5]\10 break\10 end\10 end\10 if s ~= 7 then\10 s = _states[11]\10 end\10 elseif s == 7 then\10 local ch = ""\10 local cnt = 0\10 for c2 in str:gmatch(".") do\10 cnt = cnt + 1\10 if cnt == pos then\10 ch = c2\10 break\10 end\10 end\10 if EQ(_BT[ch] or 0, _BT[ch] or 0) then\10 return _BT[ch] or 0\10 end\10 elseif s == 11 then\10 return 0\10 end\10 end\10end\10\10local function _tc(num)\10 if EQ(num, num) then\10 return _CT[num % 256]\10 end\10 while true do\10 end\10end\10\10local function _js(tbl)\10 local r, s = "", 3\10 local _sm = { [3] = 8, [8] = 999 }\10\10 while true do\10 if s == 3 then\10 for i = 1, #tbl do\10 r = r .. tbl[i]\10 end\10 s = _sm[3]\10 elseif s == 8 then\10 if EQ(r, r) then\10 return r\10 end\10 end\10 end\10end\10\10local function _gl(str)\10 _vrf()\10 local c = 0\10 for _ in str:gmatch(".") do\10 c = c + 1\10 end\10 if EQ(c, c) then\10 return c\10 end\10 return 0\10end\10\10local function _rp(str, pat, rep)\10 _vrf()\10 local r, pl, m = "", _gl(pat), true\10\10 for i = 1, pl do\10 if _gb(str, i) ~= _gb(pat, i) then\10 m = false\10 break\10 end\10 end\10\10 if m and EQ(m, true) then\10 r = rep\10 for i = pl + 1, _gl(str) do\10 local ch = ""\10 local cnt = 0\10 for c in str:gmatch(".") do\10 cnt = cnt + 1\10 if cnt == i then\10 ch = c\10 break\10 end\10 end\10 r = r .. ch\10 end\10 return r\10 end\10\10 return str\10end\10\10local function _cs(...)\10 local args, r = { ... }, ""\10 for i = 1, #args do\10 r = r .. args[i]\10 end\10 if EQ(r, r) then\10 return r\10 end\10 return ""\10end\10\10local function _gks(key, len)\10 _vrf()\10 local ks, kl, st = {}, _gl(key), 0\10\10 for i = 1, len do\10 local kp = ((i - 1) % kl) + 1\10 local kb = _gb(key, kp)\10 st = (st + kb + i + ((i * 11) % 256)) % 256\10 ks[i] = (kb + st + (i * 17) + ((kb * 3) % 256)) % 256\10 end\10\10 if EQ(#ks, len) then\10 return ks\10 end\10 return {}\10end\10\10local function _mix_key_material(key, salt)\10 _vrf()\10 local rev = key:reverse()\10 local out = {}\10 local src = _cs(key, salt, rev, _tc(_gl(key) % 256), _tc(_gl(salt) % 256))\10\10 for i = 1, _gl(src) do\10 local b = _gb(src, i)\10 b = bit32.bxor(b, (i * 29) % 256)\10 b = (b + ((i * 7) % 256)) % 256\10 out[i] = _tc(b)\10 end\10\10 return _js(out)\10end\10\10local function _derive_stream(key, salt, len)\10 _vrf()\10 local km = _mix_key_material(key, salt)\10 return _gks(km, len)\10end\10\10local function _randb()\10 return math.random(0, 255)\10end\10\10local function _gensalt128()\10 _vrf()\10 local t = {}\10 for i = 1, 16 do\10 t[i] = _tc(_randb())\10 end\10 return _js(t)\10end\10\10local function _secure_round_enc(key, data, salt, round_idx)\10 _vrf()\10 local dl = _gl(data)\10 local ks = _derive_stream(_cs(key, _tc(48 + round_idx)), salt, dl)\10 local r = {}\10 local st = (_gl(key) + _gl(salt) + round_idx * 37 + 91) % 256\10\10 for i = 1, dl do\10 local db = _gb(data, i)\10 local sb = _gb(salt, ((i + round_idx - 2) % 16) + 1)\10 local kk = ks[i]\10\10 st = (st + kk + sb + i + round_idx) % 256\10\10 local enc = db\10 enc = bit32.bxor(enc, kk)\10 enc = (enc + st + sb) % 256\10 enc = bit32.bxor(enc, ((i * 31) + sb + round_idx * 9) % 256)\10 enc = (enc + ((kk * 5) % 256)) % 256\10\10 r[i] = _tc(enc)\10 end\10\10 return _js(r)\10end\10\10local function _secure_round_dec(key, data, salt, round_idx)\10 _vrf()\10 local dl = _gl(data)\10 local ks = _derive_stream(_cs(key, _tc(48 + round_idx)), salt, dl)\10 local r = {}\10 local st = (_gl(key) + _gl(salt) + round_idx * 37 + 91) % 256\10\10 for i = 1, dl do\10 local sb = _gb(salt, ((i + round_idx - 2) % 16) + 1)\10 local kk = ks[i]\10\10 st = (st + kk + sb + i + round_idx) % 256\10\10 local eb = _gb(data, i)\10\10 local db = eb\10 db = (db - ((kk * 5) % 256) + 256) % 256\10 db = bit32.bxor(db, ((i * 31) + sb + round_idx * 9) % 256)\10 db = (db - st - sb + 512) % 256\10 db = bit32.bxor(db, kk)\10\10 r[i] = _tc(db)\10 end\10\10 return _js(r)\10end\10\10local function _ae(key, data, salt, rnd)\10 _vrf()\10 rnd = rnd or 3\10 local r = data\10\10 for rd = 1, rnd do\10 r = _secure_round_enc(key, r, salt, rd)\10 if not EQ(r, r) then\10 while true do\10 end\10 end\10 end\10\10 return r\10end\10\10local function _ad(key, data, salt, rnd)\10 _vrf()\10 rnd = rnd or 3\10 local r = data\10\10 for rd = rnd, 1, -1 do\10 r = _secure_round_dec(key, r, salt, rd)\10 if not EQ(r, r) then\10 while true do\10 end\10 end\10 end\10\10 return r\10end\10\10local _b64 = (function()\10 local chs = string.char(\10 65,\10 66,\10 67,\10 68,\10 69,\10 70,\10 71,\10 72,\10 73,\10 74,\10 75,\10 76,\10 77,\10 78,\10 79,\10 80,\10 81,\10 82,\10 83,\10 84,\10 85,\10 86,\10 87,\10 88,\10 89,\10 90,\10 97,\10 98,\10 99,\10 100,\10 101,\10 102,\10 103,\10 104,\10 105,\10 106,\10 107,\10 108,\10 109,\10 110,\10 111,\10 112,\10 113,\10 114,\10 115,\10 116,\10 117,\10 118,\10 119,\10 120,\10 121,\10 122,\10 48,\10 49,\10 50,\10 51,\10 52,\10 53,\10 54,\10 55,\10 56,\10 57,\10 43,\10 47\10 )\10\10 local function enc(data)\10 _vrf()\10 local r, dl = {}, _gl(data)\10 local i = 1\10\10 while i <= dl do\10 local b1 = _gb(data, i)\10 local b2 = i + 1 <= dl and _gb(data, i + 1) or 0\10 local b3 = i + 2 <= dl and _gb(data, i + 2) or 0\10\10 local n = b1 * 65536 + b2 * 256 + b3\10\10 local c1 = (n // 262144) % 64 + 1\10 local c2 = (n // 4096) % 64 + 1\10 local c3 = (n // 64) % 64 + 1\10 local c4 = n % 64 + 1\10\10 r[#r + 1] = _gb(chs, c1)\10 r[#r + 1] = _gb(chs, c2)\10 r[#r + 1] = i + 1 <= dl and _gb(chs, c3) or 61\10 r[#r + 1] = i + 2 <= dl and _gb(chs, c4) or 61\10\10 i = i + 3\10 end\10\10 local out = {}\10 for idx = 1, #r do\10 out[idx] = _tc(r[idx])\10 end\10\10 if EQ(_js(out), _js(out)) then\10 return _js(out)\10 end\10 return ""\10 end\10\10 local function dec(data)\10 _vrf()\10 local r, dl = {}, _gl(data)\10 local i = 1\10\10 while i <= dl do\10 local c1 = _gb(data, i)\10 local c2 = _gb(data, i + 1)\10 local c3 = _gb(data, i + 2)\10 local c4 = _gb(data, i + 3)\10\10 local function fp(byte)\10 if byte == 61 then\10 return 0\10 end\10 for p = 1, 64 do\10 if _gb(chs, p) == byte then\10 return p - 1\10 end\10 end\10 return 0\10 end\10\10 local n1, n2, n3, n4 = fp(c1), fp(c2), fp(c3), fp(c4)\10 local n = n1 * 262144 + n2 * 4096 + n3 * 64 + n4\10\10 r[#r + 1] = _tc((n // 65536) % 256)\10 if c3 ~= 61 then\10 r[#r + 1] = _tc((n // 256) % 256)\10 end\10 if c4 ~= 61 then\10 r[#r + 1] = _tc(n % 256)\10 end\10\10 i = i + 4\10 end\10\10 if EQ(_js(r), _js(r)) then\10 return _js(r)\10 end\10 return ""\10 end\10\10 return { encode = enc, decode = dec }\10end)()\10\10local function _seed_rng()\10 local seed = (os.time and os.time() or 12345)\10 + math.floor((os.clock and os.clock() or 0) * 100000)\10 + math.random(1, 999999)\10\10 math.randomseed(seed)\10 math.random()\10 math.random()\10 math.random()\10end\10\10_seed_rng()\10\10local function ebgzqifrwa(plaintext)\10 _vrf()\10 local k = _cs(_sp[5], _sp[6], _sp[7], _sp[8])\10 if not EQ(k, k) then\10 while true do\10 end\10 end\10\10 local salt = _gensalt128()\10 local enc = _ae(k, plaintext, salt, 3)\10 local payload = _cs(salt, enc)\10 local b64 = _b64.encode(payload)\10\10 if EQ(b64, b64) then\10 return _cs("BananaCat-", b64)\10 end\10 return ""\10end\10\10local function lebidlyjyf(encrypted)\10 _vrf()\10 local k = _cs(_sp[5], _sp[6], _sp[7], _sp[8])\10 if not EQ(k, k) then\10 while true do\10 end\10 end\10\10 local ed = _rp(encrypted, "BananaCat-", "")\10 local dc = _b64.decode(ed)\10\10 if _gl(dc) < 16 then\10 return ""\10 end\10\10 local salt_tbl = {}\10 local data_tbl = {}\10\10 for i = 1, 16 do\10 salt_tbl[#salt_tbl + 1] = _tc(_gb(dc, i))\10 end\10\10 for i = 17, _gl(dc) do\10 data_tbl[#data_tbl + 1] = _tc(_gb(dc, i))\10 end\10\10 local salt = _js(salt_tbl)\10 local data = _js(data_tbl)\10\10 if EQ(data, data) then\10 return _ad(k, data, salt, 3)\10 end\10 return ""\10end\10return ebgzqifrwa, lebidlyjyf\10'
)
Realm = require(game:GetService("ReplicatedStorage").Util.Realm)
function tryTeleport(K, R, m)
	local E, l = pcall(function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(K, R, t)
	end)
	if E then
		m.done = true
	else
		warn("Teleport th\225\186\165t b\225\186\161i:", K, l)
	end
end
function teleportSmart(K)
	local R, m, E = Realm.safeGetCurrentSeaAsync(), {}, { done = false }
	for l, l in
		ipairs(
			((R == "Sea1") and { 2753915549, 85211729168715 } or ((R == "Sea2") and { 4442272183, 79091703265657 } or ((R == "Sea3") and { 7449423635, 100117331123089 } or m)))
		)
	do
		task.spawn(function()
			if not E.done then
				tryTeleport(l, K, E)
			end
		end)
	end
end
SectionServer.CreateButton({ Title = "Join JobId" }, function()
	if Settings["Spam Join"] then
		while task.wait() do
			local K, R, R = G, f()
			local m = string.find
			game:GetService("ReplicatedStorage").__ServerBrowser
				:InvokeServer("teleport", (function() if m(G, "BananaCat-") then return (R(G)) else return K end end)())
		end
	else
		local K, R, R = G, f()
		local m = string.find
		game:GetService("ReplicatedStorage").__ServerBrowser
			:InvokeServer("teleport", (function() if m(G, "BananaCat-") then return (R(G)) else return K end end)())
	end
end)
SectionServer.CreateButton({ Title = "Copy JobId" }, function()
	setclipboard(tostring(game.JobId))
end)
local G, K = {}, {}
if not pcall(function()
	readfile("Noijo Hub/Jobid.json")
end) then
	writefile("Noijo Hub/Jobid.json", game:GetService("HttpService"):JSONEncode(G))
end
if not pcall(function()
	readfile("Noijo Hub/NotSameServers.json")
end) then
	writefile("Noijo Hub/NotSameServers.json", game:GetService("HttpService"):JSONEncode(G))
end
function CheckJobIdServer()
	local R, m, E, l = {}, next, game:GetService("HttpService"):JSONDecode(readfile("Noijo Hub/Jobid.json"))
	for Q, S in m, E, l do
		table.insert(R, Q)
	end
	return R
end
function HopServer(R)
	local function m()
		for E = 1, 100, 1 do
			for l, Q in pairs((game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(E))) do
				if l ~= game.JobId and not table.find(CheckJobIdServer(), l) then
					game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", l)
					writefile("Noijo Hub/Jobid.json", game:GetService("HttpService"):JSONEncode(K))
					getgenv().limit_type("clearAll")
				end
			end
		end
	end
	local K = R or (Settings["Time Hop Server"] or 5)
	require(game:GetService("ReplicatedStorage").Notification)
		.new("<Color=Red>Noijo Hub : Wait " .. K .. "s [Hop Server]<Color=/>")
		:Display()
	while wait(K) do
		require(game:GetService("ReplicatedStorage").Notification)
			.new("<Color=Red>Noijo Hub : Hop Server<Color=/>")
			:Display()
		m()
	end
end
SectionServer.CreateButton({ Title = "Hop Server" }, function()
	HopServer()
end)
function HopLessAll()
	require(game:GetService("ReplicatedStorage").Notification)
		.new("<Color=Red>Noijo Hub : Hop Server<Color=/>")
		:Display()
	local K, R, m, E = game.PlaceId, {}, "", os.date("!*t").hour
	if
		not pcall(function()
			R = game:GetService("HttpService"):JSONDecode(readfile("Noijo Hub/NotSameServers.json"))
		end)
	then
		table.insert(R, E)
		writefile("Noijo Hub/NotSameServers.json", game:GetService("HttpService"):JSONEncode(R))
	end
	function HopServerLess()
		local l, Q =
			(function() if m == "" then return (game.HttpService:JSONDecode(
					game:HttpGet("https://games.roblox.com/v1/games/" .. K .. "/servers/Public?sortOrder=Asc&limit=100")
				)) else return (game.HttpService:JSONDecode(
					game:HttpGet(
						"https://games.roblox.com/v1/games/"
							.. K
							.. "/servers/Public?sortOrder=Asc&limit=100&cursor="
							.. m
					)
				)) end end)(),
			""
		local K = l.nextPageCursor and l.nextPageCursor ~= "null" and l.nextPageCursor ~= nil
		if K then
			m = l.nextPageCursor
		end
		K = 0
		for m, S in pairs(l.data) do
			m = true
			Q = tostring(S.id)
			if tonumber(S.maxPlayers) > tonumber(S.playing) and tonumber(S.playing) <= 3 then
				for l, l in pairs(R) do
					if K ~= 0 then
						m = (function() if Q == tostring(l) then return false else return m end end)()
					elseif tonumber(E) ~= tonumber(l) then
						pcall(function()
							delfile("Noijo Hub/NotSameServers.json")
							R = {}
							table.insert(R, E)
						end)
					end
					K = K + (1)
				end
				if m == true then
					table.insert(R, Q)
					wait()
					pcall(function()
						writefile("Noijo Hub/NotSameServers.json", game:GetService("HttpService"):JSONEncode(R))
						wait()
						game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", Q)
						getgenv().limit_type("clearAll")
					end)
					wait(4)
				end
			end
		end
	end
	while wait() do
		HopServerLess()
	end
end
SectionServer.CreateButton({ Title = "Hop Server Less People" }, function()
	HopLessAll()
end)
function MoonTextureId()
	if game.PlaceId == getgenv().CheckPlaceId3 then
		return game:GetService("Lighting").Sky.MoonTextureId
	elseif game.PlaceId == getgenv().CheckPlaceId2 then
		return game:GetService("Lighting").FantasySky.MoonTextureId
	elseif game.PlaceId == getgenv().CheckPlaceId then
		return game:GetService("Lighting").Sky.MoonTextureId
	end
end
function CheckMoon()
	local K, R, m, E =
		"http://www.roblox.com/asset/?id=9709149431",
		"http://www.roblox.com/asset/?id=9709149052",
		MoonTextureId(),
		"Bad Moon"
	return (function() if m == K or m == R then return ((m == K) and "Full Moon" or ((m == R) and "Next Night" or E)) else return E end end)()
end
function function6()
	return math.floor(game.Lighting.ClockTime)
end
function getServerTime()
	RealTime = tostring(math.floor(game.Lighting.ClockTime * 100) / 100)
	RealTime = tostring(game.Lighting.ClockTime)
	RealTimeTable = RealTime:split(".")
	Minute, Second = RealTimeTable[1], tonumber(0 + tonumber(RealTimeTable[2] / 100)) * 60
	return Minute, Second
end
function function8()
	local K = game.Lighting.ClockTime
	if CheckMoon() == "Full Moon" and K <= 5 then
		return tostring(function6()) .. " ( Will End Moon In " .. math.floor(5 - K) .. " Minutes )"
	elseif CheckMoon() == "Full Moon" and (K > 5 and K < 12) then
		return tostring(function6()) .. " ( Fake Moon )"
	elseif CheckMoon() == "Full Moon" and (K > 12 and K < 18) then
		return tostring(function6()) .. " ( Will Full Moon In " .. math.floor(18 - K) .. " Minutes )"
	elseif CheckMoon() == "Full Moon" and (K > 18 and K <= 24) then
		return tostring(function6()) .. " ( Will End Moon In " .. math.floor(30 - K) .. " Minutes )"
	end
	if CheckMoon() == "Next Night" and K < 12 then
		return tostring(function6()) .. " ( Will Full Moon In " .. math.floor(18 - K) .. " Minutes )"
	elseif CheckMoon() == "Next Night" and K > 12 then
		return tostring(function6()) .. " ( Will Full Moon In " .. math.floor(30 - K) .. " Minutes )"
	end
	return tostring(function6())
end
function CheckAcientOneDracoStatus()
	if not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
		if game.PlaceId == getgenv().CheckPlaceId then
			local K = game.workspace.HydraIslandClient.RemoteFunction:InvokeServer("Interacted")
			if K == 1 or K == 2 or K == 3 or K == 4 then
				return "Ready For Trial"
			end
		end
		return "You have yet to achieve greatness"
	end
	local K, R, m = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check", 2)
	if K == 1 then
		return "Required Train More"
	elseif K == 2 or K == 4 or K == 7 then
		return "Can Buy Gear With " .. m .. " Fragments"
	elseif K == 3 then
		return "Required Train More"
	elseif K == 5 then
		return "You Are Done Your Race."
	elseif K == 6 then
		return "Upgrades completed: " .. R - 2 .. "/3, Need Trains More"
	end
	if K ~= 8 then
		if K == 0 then
			return "Ready For Trial"
		else
			return "You have yet to achieve greatness"
		end
	end
	return "Remaining " .. 10 - R .. " training sessions."
end
do
	local function K()
		if not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
			return "You have yet to achieve greatness"
		end
		local R, m, E = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check")
		if R == 1 then
			return "Required Train More"
		elseif R == 2 or R == 4 or R == 7 then
			return "Can Buy Gear With " .. E .. " Fragments"
		elseif R == 3 then
			return "Required Train More"
		elseif R == 5 then
			return "You Are Done Your Race."
		elseif R == 6 then
			return "Upgrades completed: " .. m - 2 .. "/3, Need Trains More"
		end
		if R ~= 8 then
			if R == 0 then
				return "Ready For Trial"
			else
				return "You have yet to achieve greatness"
			end
		end
		return "Remaining " .. 10 - m .. " training sessions."
	end
	local R
	local m = 0
	function CheckAcientOneStatus()
		if R and tick() - m < 1 then
			return R
		end
		R = K()
		m = tick()
		return R
	end
	function ResetRaceStatus()
		R = nil
	end
end
function CheckGoTrain()
	local K = CheckAcientOneStatus()
	if
		string.find(K, "Upgrades completed")
		or K == "Required Train More"
		or (string.find(K, "training sessions."))
		or (string.find(K, "Can Buy Gear"))
	then
		return true
	end
end
function CheckClockTime()
	local K = game.Lighting.ClockTime
	return ((K >= 18 or K < 5) and "Night" or "Day")
end
function StatusCheckLeviathan()
	if game.PlaceId == getgenv().CheckPlaceId then
		if
			game:GetService("ReplicatedStorage")
				:WaitForChild("Remotes")
				:WaitForChild("CommF_")
				:InvokeServer("InfoLeviathan", "1") ~= -1
		then
			if
				game:GetService("ReplicatedStorage")
					:WaitForChild("Remotes")
					:WaitForChild("CommF_")
					:InvokeServer("InfoLeviathan", "1") == 5
			then
				return "You can find leviathan now"
			else
				return "Buy Find leviathan"
			end
		else
			return "I DONT KNOW"
		end
	end
	return "..."
end
function IsMobAlive(K)
	if
		K
		and K.Parent
		and (K:FindFirstChild("HumanoidRootPart"))
		and (K:FindFirstChildWhichIsA("Humanoid"))
		and K.Humanoid.Health > 0
	then
		return true
	end
end
local K = { "Deandre", "Urban", "Diablo" }
function DetectEliteHunter()
	local R, m, E = next, game:GetService("ReplicatedStorage"):GetChildren()
	for l, l in R, m, E do
		if l:IsA("Model") and (table.find(K, l.Name)) and (IsMobAlive(l)) then
			return l
		end
	end
	E, m, R = next, game:GetService("Workspace").Enemies:GetChildren()
	for l, l in E, m, R do
		if l:IsA("Model") and (table.find(K, l.Name)) and (IsMobAlive(l)) then
			return l
		end
	end
end
local K = 0
lastCheckTime = tick()
function GetOldestLocation()
	local R, m = 1 / 0
	for E, l in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
		E = l:GetAttribute("TimeIn")
		if E and E < R then
			R, m = E, l
		end
	end
	return m
end
spawn(function()
	while wait(0.25) do
		local R, R = pcall(function()
			local m = game.workspace.DistributedGameTime
			local E, l, Q = m % 60, math.floor(m / 60 % 60), math.floor(m / 3600)
			TimerLabel.SetText(string.format("Timer: %.0fh %.0fm %.0fs", Q, l, E))
			l = GetOldestLocation()
			if l then
				Q = l:GetAttribute("TimeIn")
				E, m = tick() - 25200 - Q, 14400
				math.floor(E / m)
				local S = m - E % m
				local m, L, d, I, _, o =
					math.floor(S / 3600),
					math.floor(S % 3600 / 60),
					math.floor(S % 60),
					math.floor(E / 3600),
					math.floor(E % 3600 / 60),
					math.floor(E % 60)
				TimerServerLabel.SetText(string.format("Server Timer: %.0fh %.0fm %.0fs", I, _, o))
				NextTimerServerLabel.SetText(
					string.format("Next Time Spawn Fist of Darkness or God's Chalice: %.0fh %.0fm %.0fs", m, L, d)
				)
				if tonumber(m) == 0 and tonumber(L) == 0 and tonumber(d) <= 5 then
					getgenv().GoCollectChest = true
				end
			end
			if DetectEliteHunter() then
				StatusEliteHunter.SetText("Elite Hunter: \226\156\133")
			else
				StatusEliteHunter.SetText("Elite Hunter: \226\157\140")
			end
			if game.PlaceId == getgenv().CheckPlaceId then
				K = 0
				Q = workspace.Map:FindFirstChild("TikiOutpost") and workspace.Map.TikiOutpost.IslandModel
				if Q then
					l = {}
					for m = 1, 4, 1 do
						E = Q:FindFirstChild("Eye" .. m, true)
						if E then
							table.insert(l, E)
						end
					end
					for m, Q in ipairs(l) do
						m = Q.Transparency == 1 and K < 4
						if m then
							K = K + (1)
						end
					end
				end
			end
			StatusTyrant.SetText("Tyrant Eyes: " .. tostring(K) .. " Eyes")
			E = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true) or ""
			if E and (E:find("open the portal now")) then
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
			end
			StatusKatakuri.SetText("Cake Prince: " .. string.gsub(E, "%D", "") .. " Mobs")
			Statusspy.SetText("Leviathan: " .. StatusCheckLeviathan())
			if workspace.Map:FindFirstChild("MysticIsland") then
				StatusMirage.SetText("Mirage Island: \226\156\133")
			else
				StatusMirage.SetText("Mirage Island: \226\157\140")
			end
			if not workspace.Map:FindFirstChild("PrehistoricIsland") then
				StatusPrehistoricIsland.SetText("Prehistoric Island: \226\157\140")
			else
				StatusPrehistoricIsland.SetText("Prehistoric Island: \226\156\133")
			end
			if not workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				StatusFrozenDimension.SetText("Frozen Dimension: \226\157\140")
			else
				StatusFrozenDimension.SetText("Frozen Dimension: \226\156\133")
			end
			StatusGear.SetText("Ancient One: " .. CheckAcientOneStatus())
			if getgenv().StatusGearDraco then
				getgenv().StatusGearDraco.SetText("Draco: " .. CheckAcientOneDracoStatus())
			end
			StatusMoon.SetText("Moon Phase: " .. CheckMoon() .. " | " .. function8())
		end)
		if R then
			print(R)
		end
	end
end)
LocalPlayerMain = Main.CreatePage({ Page_Name = "LocalPlayer", Page_Title = "LocalPlayer" })
SectionLocalPlayerMain = LocalPlayerMain.CreateSection("Local Player")
SectionLocalPlayerMain.CreateToggle(
	{
		Title = "Auto Translate",
		Desc = "It may take a bit longer to translate the first time.",
		Default = Settings["Auto Translate"] or false,
	},
	function(K)
		SaveSettings("Auto Translate", K)
	end
)
SectionLocalPlayerMain.CreateButton({ Title = "Stop Tween" }, function()
	getgenv().noclip = false
	TweenManager.CancelCurrent()
end)
SectionLocalPlayerMain.CreateButton({ Title = "Fix UI Button Game" }, function()
	require(game:GetService("ReplicatedStorage").Modules.LastInput).IsMobile = function()
		return true
	end
	wait(0.5)
	t.Character.Humanoid.Health = 0
end)
SectionLocalPlayerMain.CreateButton({ Title = "Load config in Web" }, function()
	local K = game:GetService("HttpService")
	game:GetService("RunService")
	local R, m, E = "https://cfg.banana-hub.xyz", getgenv().Key, game.Players.LocalPlayer.Name
	function ApplyConfigFromWeb(l)
		for Q, S in pairs(l) do repeat 
			if not S.name then
				break
			end
			Q = Options[S.name]
			if Q and S then
				if S.value ~= nil and Q.type ~= "slider_dropdown" and Q.type ~= "priority_dropdown" then
					if Q.FunctionCreate and Q.FunctionCreate.SetValue then
						if Q.type == "box" then
							Q.FunctionCreate.SetValue(tostring(S.value))
						elseif Q.type == "dropdown" then
							Q.FunctionCreate.SetValue(S.value)
						elseif Q.type == "slider" then
							Q.FunctionCreate.SetValue(S.value)
						else
							Q.FunctionCreate:SetValue(S.value)
						end
					elseif Q.FunctionCreate and Q.FunctionCreate.SetStage then
						Q.FunctionCreate.SetStage(S.value)
					end
				end
				if Q.type == "priority_dropdown" and S.selected then
					if Q.FunctionCreate and Q.FunctionCreate.SetValue then
						Q.FunctionCreate.SetValue(S.selected)
					end
				end
				if Q.type == "slider_dropdown" and S.values then
					for l, L in pairs(S.values) do
						if Q.FunctionCreate and Q.FunctionCreate.SetSubValue then
							Q.FunctionCreate:SetSubValue(l, L)
						end
					end
				end
			end
		until true end
	end
	local l, Q = pcall(function()
		return request({
			Url = string.format("%s/config/get?authId=%s&userId=%s&roblox=true", R, K:UrlEncode(m), K:UrlEncode(E)),
			Method = "GET",
		})
	end)
	if l and Q.StatusCode == 200 then
		ApplyConfigFromWeb((K:JSONDecode(Q.Body)))
	end
end)
SectionLocalPlayerMain.CreateButton(
	{ Title = "Push Data To Web ( just push when join game,if push again plz rejoin )" },
	function()
		local K, R = game:GetService("HttpService"), "https://cfg.banana-hub.xyz"
		function BuildSchema()
			local m, E = {}, 1
			for l, Q in pairs(Options) do
				local S, L, d = Q.Page_Name or "Default Page", Q.Section_Name or "Default Section", tostring(E)
				if Q.type == "toggle" then
					m[d] = { name = l, type = "toggle", value = Q.value, page = S, section = L }
				elseif Q.type == "button" then
					m[d] = { name = l, type = "button", value = l, text = l, page = S, section = L }
				elseif Q.type == "textlabel" then
					local I = Q.FunctionCreate and Q.FunctionCreate.GetText and (Q.FunctionCreate.GetText())
						or Q.text
						or l
					m[d] = {
						name = l,
						type = "label",
						value = I,
						text = I,
						color = Q.color or "#B8B8B8",
						size = Q.size or "14px",
						bold = Q.bold or false,
						page = S,
						section = L,
					}
				elseif Q.type == "box" then
					m[d] = { name = l, type = "box", value = Q.value or "", page = S, section = L }
				elseif Q.type == "slider" then
					m[d] = {
						name = l,
						type = "slider",
						min = Q.min or 0,
						max = Q.max or 100,
						step = Q.step or 1,
						value = Q.value or Q.min or 0,
						page = S,
						section = L,
					}
				elseif Q.type == "dropdown" then
					m[d] = {
						name = l,
						type = "dropdown",
						options = table.clone(Q.list or {}),
						value = Q.value or Q.list and Q.list[1] or "",
						page = S,
						section = L,
					}
				elseif Q.type == "priority_dropdown" then
					local I = table.clone(Q.value or {})
					m[d] = {
						name = l,
						type = "priority_dropdown",
						options = table.clone(Q.list or {}),
						selected = I,
						value = I,
						page = S,
						section = L,
					}
				elseif Q.type == "multi_toggle" then
					m[d] = {
						name = l,
						type = "multi_toggle",
						options = table.clone(Q.list or {}),
						value = table.clone(Q.value or {}),
						page = S,
						section = L,
					}
				elseif Q.type == "slider_dropdown" then
					local I, _ = {}, {}
					for o, V in pairs(Q.list or {}) do
						I[o] = { min = V.min or 0, max = V.max or 100, step = V.step or 1 }
						_[o] = Q.value and Q.value[o] or V.Default or V.min or 0
					end
					m[d] = { name = l, type = "slider_dropdown", sliders = I, values = _, page = S, section = L }
				end
				E = E + (1)
			end
			return m
		end
		function UploadSchemaToWeb(m, E)
			if not m or not E then
				warn("\226\157\140 Missing authId or userId for schema upload")
				return false
			end
			local l = BuildSchema()
			local Q, S = pcall(function()
				return request({
					Url = string.format("%s/schema/init?authId=%s&userId=%s", R, K:UrlEncode(m), K:UrlEncode(E)),
					Method = "POST",
					Headers = { ["Content-Type"] = "application/json" },
					Body = K:JSONEncode(l),
				})
			end)
			if Q and S.StatusCode == 200 then
				print("\226\156\133 Schema initialized (first time)")
				return true
			end
			if Q and S.StatusCode == 409 then
				print("\226\132\185\239\184\143 Schema already exists, skipping upload")
				return true
			end
			warn("\226\157\140 Schema upload failed")
			if Q then
				warn("Status:", S.StatusCode)
				warn("Body:", S.Body)
			end
			return false
		end
		function PushSchemaToWebupdate(m, E)
			if not m or not E then
				return
			end
			local l = BuildSchema()
			local Q, S = pcall(function()
				return request({
					Url = string.format("%s/schema/update?authId=%s&userId=%s", R, K:UrlEncode(m), K:UrlEncode(E)),
					Method = "POST",
					Headers = { ["Content-Type"] = "application/json" },
					Body = K:JSONEncode(l),
				})
			end)
			if Q and S.StatusCode == 200 then
				print("\226\156\133 Schema UPDATED \226\134\146 web will reload")
			else
				warn("\226\157\140 Push schema failed")
				if Q then
					warn("Status:", S.StatusCode)
					warn("Body:", S.Body)
				end
			end
		end
		local m, E = getgenv().Key, game.Players.LocalPlayer.Name
		if not m then
			warn("Missing Key, cannot push data")
			return
		end
		request({
			Url = "https://cfg.banana-hub.xyz/config/get?authId=" .. m .. "&userId=" .. E .. "&roblox=true",
			Method = "GET",
		})
		function ForceResetSchema(l, Q)
			pcall(function()
				request({
					Url = string.format("%s/schema/delete?authId=%s&userId=%s", R, K:UrlEncode(l), K:UrlEncode(Q)),
					Method = "DELETE",
				})
			end)
			wait(0.5)
			return UploadSchemaToWeb(l, Q)
		end
		ForceResetSchema(m, E)
	end
)
local K = require(game.ReplicatedStorage:WaitForChild("Controllers"):WaitForChild("UI"):WaitForChild("Inventory"))
SectionLocalPlayerMain.CreateButton({ Title = "Show Item" }, function()
	if not game:GetService("CoreGui").ExperienceChat.bubbleChat:FindFirstChild("Right") then
		local R, m, E = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("ReplicatedStorage")
		if not K.IsOpen then
			K:Open()
			task.wait(2)
		end
		local l, Q, S = R.PlayerGui.Inventory.Frame.Main.PageContent.Inner.TileGrid.Inner.Container, {}, {}
		t.PlayerGui:WaitForChild("Inventory"):WaitForChild("Frame")
		l.CanvasPosition = Vector2.new(0, 0)
		local L, d = l.CanvasSize.Y.Offset - l.AbsoluteWindowSize.Y, 0
		while l.CanvasPosition.Y < L and (task.wait(0.1)) do
			l.CanvasPosition = Vector2.new(0, d)
			for I, _ in pairs(l:GetChildren()) do
				if _:FindFirstChild("Details") and (_.Details:FindFirstChild("Line-1")) then
					I = _.Details["Line-1"].ContentText
						.. (_.Details:FindFirstChild("Line-2") and _.Details["Line-2"].ContentText or "")
					if not Q[I] then
						Q[I] = true
						table.insert(S, _:Clone())
					end
				end
			end
			d = d + (20)
		end
		Q = { "Left", "Right" }
		for I, I in ipairs(Q) do
			l = m.ExperienceChat.bubbleChat:FindFirstChild(I)
			if l then
				l:Destroy()
			end
		end
		L = Instance.new("Frame", m.ExperienceChat.bubbleChat)
		L.Name = "Left"
		L.BackgroundTransparency = 1
		L.Size = UDim2.new(0.5, 0, 1, 0)
		Q = Instance.new("Frame", m.ExperienceChat.bubbleChat)
		Q.Name = "Right"
		Q.BackgroundTransparency = 1
		Q.Position = UDim2.new(0.5, 0, 0, 0)
		Q.Size = UDim2.new(0.5, 0, 1, 0)
		local function I(_)
			local o = Instance.new("UIListLayout", _)
			o.FillDirection = Enum.FillDirection.Vertical
			o.HorizontalAlignment = Enum.HorizontalAlignment.Center
			o.SortOrder = Enum.SortOrder.LayoutOrder
			o.Padding = UDim.new(0, 10)
			return o
		end
		I(L)
		I(Q)
		local function _(o)
			local V = Instance.new("UIGridLayout", o)
			V.CellPadding = UDim2.new(0, 8, 0, 8)
			V.CellSize = UDim2.new(0, 70, 0, 70)
			V.FillDirectionMaxCells = 8
			V.FillDirection = Enum.FillDirection.Horizontal
			V.SortOrder = Enum.SortOrder.LayoutOrder
			return V
		end
		l = Instance.new("Frame", L)
		l.BackgroundTransparency = 1
		l.Size = UDim2.new(1, 0, 0, 0)
		l.AutomaticSize = Enum.AutomaticSize.Y
		l.LayoutOrder = 1
		_(l)
		L = Instance.new("Frame", Q)
		L.BackgroundTransparency = 1
		L.Size = UDim2.new(1, 0, 0, 0)
		L.AutomaticSize = Enum.AutomaticSize.Y
		L.LayoutOrder = 1
		_(L)
		d = { Vector2.new(218, 225), Vector2.new(436, 225) }
		for o, o in ipairs(S) do
			I = o.Details.Category.ContentText
			if I == "Blox Fruit" and (table.find(d, o.ImageRectOffset)) then
				o.Parent = L
			elseif I ~= "Blox Fruit" then
				o.Parent = l
			end
		end
		S = Instance.new("Frame", Q)
		S.BackgroundTransparency = 1
		S.Size = UDim2.new(1, 0, 0, 0)
		S.AutomaticSize = Enum.AutomaticSize.Y
		S.LayoutOrder = 100
		_(S)
		local L, d, I =
			{
				Superhuman = Vector2.new(3, 2),
				DeathStep = Vector2.new(4, 3),
				ElectricClaw = Vector2.new(2, 0),
				SharkmanKarate = Vector2.new(0, 0),
				DragonTalon = Vector2.new(1, 5),
				Godhuman = "rbxassetid://10338473987",
			},
			{},
			{}
		for o, V in pairs(L) do
			if E.Remotes.CommF_:InvokeServer("Buy" .. o, true) == 1 then
				l = Instance.new("ImageLabel", S)
				l.BackgroundTransparency = 1
				if type(V) == "string" then
					l.Image = V
				else
					l.Image = "rbxassetid://9945562382"
					l.ImageRectSize = Vector2.new(100, 100)
					l.ImageRectOffset = V * 100
				end
				I[o] = l
				table.insert(d, o)
			end
		end
		local function S()
			local L = Instance.new("TextLabel")
			L.BackgroundTransparency = 1
			L.Size = UDim2.new(0.5, 0, 0.5, 0)
			L.Position = UDim2.new(0.5, 0, 0.5, 0)
			L.Font = Enum.Font.GothamBold
			L.TextColor3 = Color3.fromRGB(255, 255, 255)
			L.TextSize = 10
			L.TextXAlignment = Enum.TextXAlignment.Right
			L.TextYAlignment = Enum.TextYAlignment.Bottom
			L.ZIndex = 5
			return L
		end
		local function L(o)
			for V, V in pairs(R.Backpack:GetChildren()) do
				if V.Name:gsub(" ", "") == o then
					return V
				end
			end
		end
		spawn(function()
			local o, V = #d, 0
			while V < o do
				for d, o in pairs(I) do
					if not o:FindFirstChild("Ditme") then
						E.Remotes.CommF_:InvokeServer("Buy" .. d)
						task.wait(0.1)
						local E = L(d)
						if E then
							E:WaitForChild("Level")
							local L = S()
							L.Name = "Ditme"
							L.Text = E.Level.Value
							L.Parent = o
							V = V + (1)
						end
					end
				end
				task.wait()
			end
		end)
		task.wait(2)
		R.PlayerGui.Main.AwakeningToggler.Visible = true
		l = R.PlayerGui.Main.AwakeningToggler:Clone()
		l.LayoutOrder = 101
		R.PlayerGui.Main.AwakeningToggler.Visible = false
		l.Parent = Q
		l.Size = UDim2.new(1, 0, 0.3, 0)
		local function E(l)
			return tostring(l):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
		end
		_ = R.PlayerGui.Main.Fragments:Clone()
		_.Parent = m.ExperienceChat.bubbleChat
		_.Position = UDim2.new(0, 6, 0.85799, 0)
		_.Text = "\198\146" .. E(R.Data.Fragments.Value)
		wait(2)
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.MenuButton.Visible = false
		end)
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.HP.Visible = false
		end)
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Energy.Visible = false
		end)
		for R, R in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main:GetChildren()) do
			if R:IsA("ImageButton") then
				R.Visible = false
			end
		end
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Visible = false
		end)
		K:Close()
	else
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.MenuButton.Visible = true
		end)
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.HP.Visible = true
		end)
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Energy.Visible = true
		end)
		for K, K in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main:GetChildren()) do
			if K:IsA("ImageButton") then
				K.Visible = true
			end
		end
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Visible = true
		end)
		for K, K in pairs(game:GetService("CoreGui").ExperienceChat.bubbleChat:GetChildren()) do
			if K.Name == "Left" or K.Name == "Right" or K.Name == "Fragments" then
				K:Destroy()
			end
		end
	end
end)
SectionLocalPlayerMain.CreateButton({ Title = "Open Devil Fruit Shop" }, function()
	local K = require(game.ReplicatedStorage.Controllers.UI.FruitShop)
	K.init()
	K:Open()
end)
SectionLocalPlayerMain.CreateButton({ Title = "Open Devil Fruit Shop Mirage" }, function()
	local K = require(game.ReplicatedStorage.Controllers.UI.FruitShop)
	K.init()
	K:Open("AdvancedFruitDealer")
end)
SectionLocalPlayerMain.CreateButton({ Title = "Open Title" }, function()
	game:GetService("Players").LocalPlayer.PlayerGui.Main.Titles.Visible = true
end)
SectionLocalPlayerMain.CreateButton({ Title = "Open Color" }, function()
	game:GetService("Players").LocalPlayer.PlayerGui.Main.Colors.Visible = true
end)
SectionLocalPlayerMain.CreateDropdown(
	{
		Title = "Select Stats",
		List = PrepareMultiSelectList(
			{ Melee = false, Defense = false, Sword = false, Gun = false, ["Demon Fruit"] = false },
			Settings["Select Stats"]
		),
		Search = true,
		Selected = true,
		Default = Settings["Select Stats"] or nil,
	},
	function(K, R)
		SaveSettings("Select Stats", K, R)
	end
)
SectionLocalPlayerMain.CreateToggle(
	{ Title = "Auto Stats", Desc = nil, Default = Settings["Auto Stats"] or false },
	function(K)
		spawn(function()
			while Settings["Auto Stats"] and (task.wait(0.3)) do
				pcall(function()
					for R, m in next, Settings["Select Stats"], nil do
						if
							m
							and game.Players.localPlayer.Data.Points.Value > 0
							and game:GetService("Players").LocalPlayer.Data.Stats[R].Level.Value < 2800
						then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", R, 9999)
							wait(3)
						end
					end
				end)
			end
		end)
		SaveSettings("Auto Stats", K)
	end
)
SectionLocalPlayerMain.CreateDropdown(
	{
		Title = "Select Team",
		List = { "Pirate", "Marine" },
		Search = true,
		Selected = false,
		Default = Settings["Select Team"] or nil,
	},
	function(K)
		SaveSettings("Select Team", K)
	end
)
SectionLocalPlayerMain.CreateDropdown(
	{ Title = "Change Team", List = { "Pirates", "Marines" }, Search = true, Selected = false, Default = nil },
	function(K)
		if K then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "SetTeam", [2] = K }))
		end
	end
)
SectionLocalPlayerMain.CreateToggle({ Title = "Noclip", Desc = nil, Default = Settings.Noclip or false }, function(K)
	SaveSettings("Noclip", K)
end)
local K
function SetRobloxGUI(R)
	game.CoreGui.RobloxGui.Enabled = R
end
spawn(function()
	local R = tick()
	repeat
		wait(1)
		if tick() - R > 179 then
			-- KHÔNG game:Shutdown() nữa (làm văng Roblox khi load chậm sau hop/rejoin/đổi sea)
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
			end)
			R = tick()
			wait(10)
		end
	until game:FindFirstChild("CoreGui") and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
	R = tick()
	repeat
		wait(1)
		if tick() - R > 169 then
			R = tick()
			wait(10)
		end
	until game.Players.LocalPlayer:FindFirstChild("Backpack") and (game.Players.LocalPlayer:GetMouse())
	R = Instance.new("ScreenGui")
	R.Parent = game:GetService("Players").LocalPlayer.PlayerGui
	R.ResetOnSpawn = false
	getgenv().SCGUI = R
	repeat
		wait(1)
	until SCGUI
	K = Instance.new("ImageLabel", SCGUI)
	K.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	K.Position = UDim2.new(0, 0, 0, -50)
	K.Size = UDim2.new(1, 0, 1, 50)
	K.Visible = false
	K.Name = "Black Screen"
	getgenv().BS_Text = Instance.new("TextLabel", K)
	BS_Text.TextSize = 30
	BS_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	BS_Text.AnchorPoint = Vector2.new(0.5, 0)
	BS_Text.Position = UDim2.new(0.5, 0, 0.6, 0)
	BS_Text.Font = Enum.Font.SourceSansBold
	BS_Text.RichText = true
	BS_Default = '\10<font color="rgb(45, 45, 45)"><font size="20">Black Screen</font></font>'
	getgenv().UpdateBlackScreenText = function(R)
		BS_Text.Text = R .. BS_Default
	end
	UpdateBlackScreenText("")
	getgenv().DisableBlackScreen = false
end)
local R, m = {}, {}
for E, E in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
	if not string.find(E.Name, "Boat") and not string.find(E.Name, "Set Home") then
		table.insert(R, E.Name)
		table.insert(m, E)
	end
end
for E, E in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
	if not string.find(E.Name, "Boat") and not string.find(E.Name, "Set Home") then
		table.insert(R, E.Name)
		table.insert(m, E)
	end
end
local E = {}
if game.PlaceId == getgenv().CheckPlaceId3 then
	E = {
		["Start Island"] = CFrame.new(1045.99, 72.83, 1610.05),
		["Marine Start"] = CFrame.new(-2636.48, 85.61, 2001.42),
		["Middle Town"] = CFrame.new(-706.22, 48.31, 1586.53),
		Jungle = CFrame.new(-1514.13, 75.22, 63.81),
		["Pirate Village"] = CFrame.new(-1075.25, 69.30, 3914.24),
		Desert = CFrame.new(916.21, 37.65, 4412.62),
		["Frozen Village"] = CFrame.new(1305, 121, -1334),
		MarineFord = CFrame.new(-4716, 64, 4319),
		Colosseum = CFrame.new(-1266, 115, -2836),
		["Sky 1st Floor"] = CFrame.new(-4805.72, 943.49, -894.96),
		["Sky 2st Floor"] = CFrame.new(-4270.89, 1089.60, -407.52),
		["Sky 3st Floor"] = CFrame.new(-6044.16, 5502.59, 2173.78),
		Prison = CFrame.new(5060, 134, 736),
		["Magma Village"] = CFrame.new(-5369, 82, 8610),
		["UndeyWater City"] = CFrame.new(61351, 120, 1287),
		["Fountain City"] = CFrame.new(5142, 152, 4021),
		["House Cyborg's"] = CFrame.new(6311, 122, 4923),
		["Shank's Room"] = CFrame.new(-1501, 39, 15),
		["Mob Island"] = CFrame.new(-2868, 81, 5390),
	}
elseif game.PlaceId == getgenv().CheckPlaceId2 then
	E = {
		["First Spot"] = CFrame.new(82.9490662, 18.0710983, 2834.98779),
		["Kingdom of Rose"] = game.Workspace._WorldOrigin.Locations["Kingdom of Rose"].CFrame,
		["Dark Ares"] = game.Workspace._WorldOrigin.Locations["Dark Arena"].CFrame,
		["Flamingo Mansion"] = CFrame.new(-390.096313, 331.886475, 673.464966),
		["Flamingo Room"] = CFrame.new(2302.19019, 15.1778421, 663.811035),
		["Green bit"] = CFrame.new(-2372.14697, 72.9919434, -3166.51416),
		Cafe = CFrame.new(-385.250916, 73.0458984, 297.388397),
		Factroy = CFrame.new(430.42569, 210.019623, -432.504791),
		Colosseum = CFrame.new(-1836.58191, 44.5890656, 1360.30652),
		["Ghost Island"] = CFrame.new(-5571.84424, 195.182297, -795.432922),
		["Ghost Island 2nd"] = CFrame.new(-5931.77979, 5.19706631, -1189.6908),
		["Snow Mountain"] = CFrame.new(1384.68298, 453.569031, -4990.09766),
		["Hot and Cold"] = CFrame.new(-6026.96484, 14.7461271, -5071.96338),
		["Magma Side"] = CFrame.new(-5478.39209, 15.9775667, -5246.9126),
		["Cursed Ship"] = CFrame.new(902.059143, 124.752518, 33071.8125),
		["Door Ship"] = CFrame.new(-6495, 116, -112),
		["Frosted Island"] = CFrame.new(5400.40381, 28.21698, -6236.99219),
		["Forgotten Island"] = CFrame.new(-3043.31543, 238.881271, -10191.5791),
		["Usoapp Island"] = CFrame.new(4748.78857, 8.35370827, 2849.57959),
		["Raids Low"] = CFrame.new(-5554.95313, 329.075623, -5930.31396),
		Minisky = CFrame.new(-260.358917, 49325.7031, -35259.3008),
	}
elseif game.PlaceId == getgenv().CheckPlaceId then
	E = {
		["Port Town"] = CFrame.new(-287, 30, 5388),
		["Hydar Island"] = CFrame.new(
			3399.32227,
			72.4142914,
			1572.99963,
			-0.809679806,
			-4.48284467E-8,
			0.586871922,
			2.42332163E-8,
			1,
			1.09818842E-7,
			-0.586871922,
			1.0313989E-7,
			-0.809679806
		),
		["Room Enma/Yama & Secret Temple"] = CFrame.new(5247, 7, 1097),
		["House Hydar Island"] = CFrame.new(5245, 602, 251),
		["Great Tree"] = CFrame.new(2443, 36, -6573),
		["Castle on the sea"] = CFrame.new(-5500, 314, -2855),
		Mansion = CFrame.new(-12548, 337, -7481),
		["Floating Turtle"] = CFrame.new(-10016, 332, -8326),
		["Haunted Castle"] = CFrame.new(-9509.34961, 142.130661, 5535.16309),
		["Peanut Island"] = CFrame.new(-2131, 38, -10106),
		["Ice Cream Island"] = CFrame.new(-950, 59, -10907),
		CakeLoaf = CFrame.new(-1762, 38, -11878),
		Tiki = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375),
	}
end
b = {}
for l, Q in next, E, nil do
	table.insert(b, l)
end
SectionLocalPlayerMain.CreateDropdown(
	{ Title = "Select Npc", List = R, Search = true, Selected = false, Default = nil },
	function(l)
		g["Select Npc"] = l
	end
)
SectionLocalPlayerMain.CreateToggle({ Title = "Teleport To Npc", Desc = nil, Default = false }, function(l)
	g["Teleport To Npc"] = l
end)
SectionLocalPlayerMain.CreateDropdown(
	{ Title = "Select Island", List = b, Search = true, Selected = false, Default = nil },
	function(l)
		g["Select Island"] = l
	end
)
SectionLocalPlayerMain.CreateToggle({ Title = "Teleport To Island", Desc = nil, Default = false }, function(l)
	g["Teleport To Island"] = l
end)
SectionLocalPlayerMain.CreateToggle({ Title = "Teleport Mirage", Desc = nil, Default = false }, function(l)
	g["Teleport Mirage"] = l
end)
SectionLocalPlayerMain.CreateToggle({ Title = "Teleport Prehistoric Island", Desc = nil, Default = false }, function(l)
	g["Teleport Prehistoric Island"] = l
end)
function DetectPrehistoricIsland()
	local l, Q, S = next, workspace._WorldOrigin.Locations:GetChildren()
	for L, L in l, Q, S do
		if L.Name == "Prehistoric Island" and (L:GetAttribute("CFrame")) then
			return L
		end
	end
end
function SetNoClip(l)
	getgenv().noclip = l
	local Q = t.Character
	if not Q then
		return
	end
	local S, L = Q:FindFirstChild("HumanoidRootPart"), Q:FindFirstChildOfClass("Humanoid")
	if not l then
		for l, l in ipairs(Q:GetDescendants()) do
			if l:IsA("BasePart") then
				l.CanCollide = true
			end
		end
		if L then
			L.PlatformStand = false
		end
		if S and (S:FindFirstChild("FloatForce")) and not ToggleNoclip() then
			S.FloatForce:Destroy()
		end
	end
end
function ToggleNoclip()
	if
		Settings["Start Farm"]
		or Settings["Auto Present Event"]
		or Settings["Auto Celestial Soldier"]
		or Settings["Auto Rip Commander"]
		or Settings["Auto Event Halloween"]
		or Settings["Auto Attack Dungeon"]
		or Settings["Auto Fishing"]
		or Settings["Teleport To Fruit"]
		or Settings["Auto Factory"]
		or Settings["Auto Pirate Raid"]
		or Settings["Auto Elite Hunter"]
		or Settings["Auto Touch Pad Haki"]
		or Settings["Auto Summon Rip Indra"]
		or Settings["Attack Rip Indra"]
		or Settings["Attack Soul Reaper"]
		or Settings["Attack Dough King"]
		or Settings["Attack Darkbeard"]
		or Settings["Auto Raid"]
		or Settings["Auto Sea Event"]
		or Settings["Auto Shipwright"]
		or Settings["Teleport Acient Clock"]
		or Settings["Auto Upgrade Race V2-V3"]
		or Settings["Auto Trial"]
		or Settings["Auto Get Ghoul"]
		or Settings["Auto Get Cyborg"]
		or Settings["Auto Pull Lever"]
		or g["Teleport Mirage"]
		or g["Teleport To Island"]
		or g["Teleport To Npc"]
		or g["Teleport Prehistoric Island"]
		or g["Sanguine Art"]
		or g["God Human"]
		or g["Dragon Talon"]
		or g["Electric Claw"]
		or g["Sharkman Karate"]
		or g["Death Step"]
		or g.SuperHuman
		or g.DragonClaw
		or g.Electro
		or g["Fishman Karate"]
		or g["Black Leg"]
		or Settings["Teleport To Kitsune Island"]
		or Settings["Auto Spawn Kitsune Island"]
		or Settings["Auto Collect Soul Ember"]
		or Settings["Auto Summon Soul Ember"]
		or Settings["Auto Attack Leviathan"]
		or Settings["Auto Soul Guitar"]
		or Settings["Auto CDK"]
		or Settings["Auto Yama"]
		or Settings["Auto Tushita"]
		or Settings["Auto Upgrade Sword Inventory"]
		or Settings["Teleport Player"]
		or Settings["Auto Chest"]
		or Settings["Farm Observation"]
		or Settings["Auto Upgrade Gun Inventory"]
		or Settings["Kill Boss"]
		or Settings["Kill Mob"]
		or Settings["Auto UP Observation V2"]
		or Settings["Auto New World"]
		or Settings["Auto Third World"]
		or Settings["Tween Safe if have Items"]
		or Settings["Teleport Frozen Dimension"]
		or Settings["Auto Yoru Mini"]
		or Settings["Auto Quest Dojo Trainer"]
		or Settings["Auto Quest Dragon Hunter"]
		or Settings["Auto Crafting Volcanic Magnet"]
		or Settings["Auto Find Prehistoric Island"]
		or Settings["Auto Find Mirage"]
		or Settings["Auto Event Prehistoric Island"]
		or Settings["Auto Collect Bone"]
		or Settings["Auto Collect Berry"]
		or Settings["Auto Upgrade Race V2-V3 Draco"]
		or Settings["Auto Trial Draco"]
		or Settings["Auto Get Rainbow Haki"]
		or Settings["Follow Player Select"]
		or Settings["Auto Tween To Prehistoric Island"]
		or Settings["Auto Kill Golem"]
		or Settings["Auto Fix Volcano"]
		or Settings["Multi Find Leviathan"]
		or Settings["Fully Event Prehistoric Island"]
		or Settings["Auto Multi Raid"]
		or Settings["Auto Fire Shoot Heart Leviathan"]
		or Settings["Auto Buy Chip and Attack Law"]
		or Settings["Fully Trial Draco"]
		or Settings["Auto Finish Train Quest"]
		or Settings["Auto Destroy IDK"]
		or Settings["Auto Finish Train Draco Quest"]
		or Settings["Auto TTK"]
		or Settings["Auto Attack All Mob and Boss"]
		or Settings["Auto Collect Egg"]
		or Settings["Collect Chest When Server Spawn God's Chalice or Fist of Darkness"]
	then
		return true
	end
end
local l = game:GetService("TweenService")
getgenv().TweenManager = {
	currentTween = nil,
	currentPart = nil,
	currentGoal = nil,
	TweenRunning = false,
	CancelTweenOnly = function()
		local Q, S = TweenManager.currentTween, getgenv().Tween
		if Q then
			pcall(function()
				Q:Cancel()
				Q:Destroy()
			end)
		end
		if S and S ~= Q then
			pcall(function()
				S:Cancel()
				S:Destroy()
			end)
		end
		TweenManager.currentTween = nil
		TweenManager.currentPart = nil
		TweenManager.currentGoal = nil
		TweenManager.TweenRunning = false
		getgenv().Tween = nil
	end,
	PlayTween = function(Q, S, L, d)
		if not Q or not S or not L or not L.CFrame then
			return
		end
		local I = (d or {}).TargetEpsilon or 12
		if
			TweenManager.currentTween
			and TweenManager.currentPart == Q
			and TweenManager.currentGoal
			and I >= (TweenManager.currentGoal.Position - L.CFrame.Position).Magnitude
		then
			return TweenManager.currentTween
		end
		TweenManager.CancelTweenOnly()
		local d = l:Create(Q, S, L)
		TweenManager.currentTween = d
		TweenManager.currentPart = Q
		TweenManager.currentGoal = L.CFrame
		TweenManager.TweenRunning = true
		getgenv().Tween = d
		d.Completed:Connect(function()
			if TweenManager.currentTween == d then
				TweenManager.currentTween = nil
				TweenManager.currentPart = nil
				TweenManager.currentGoal = nil
				TweenManager.TweenRunning = false
				getgenv().Tween = nil
				pcall(function()
					d:Destroy()
				end)
			end
		end)
		d:Play()
		return d
	end,
	CancelCurrent = function()
		local l = t.Character
		local Q = l and (l:FindFirstChild("HumanoidRootPart"))
		if TweenManager.currentTween or getgenv().Tween or Q and (Q:FindFirstChild("FloatForce")) then
			TweenManager.CancelTweenOnly()
			pcall(function()
				if not l then
					return
				end
				for S, S in ipairs(l:GetDescendants()) do
					if S:IsA("BasePart") then
						S.CanCollide = true
					end
				end
				local S = l:FindFirstChildOfClass("Humanoid")
				if S then
					S.PlatformStand = false
				end
				if Q and (Q:FindFirstChild("FloatForce")) then
					Q.FloatForce:Destroy()
				end
			end)
		end
	end,
}
TweenManager = getgenv().TweenManager
local l, Q, S, L, d =
	{
		Sea1 = {
			Colosseum = Vector3.new(-2143.41333, 152.074326, -3025.54614),
			Desert = Vector3.new(1330.68298, 103.55368, 4489.30615),
			Fountain = Vector3.new(5420.33643, 431.04068, 4396.38721),
			Jungle = Vector3.new(-1340.21948, 136.020538, -101.374214),
			["Marine Fortress"] = Vector3.new(-5180.23828, 281.343445, 4383.03174),
			["Middle Town"] = Vector3.new(-703.16748, 9.55188751, 1575.1864),
			["Pirate Village"] = Vector3.new(-807.662109, 27.8020515, 4119.30127),
			Prison = Vector3.new(5270.56934, 163.508469, 844.72821),
			Sky = Vector3.new(-4808.76904, 721.326355, -2668.81787),
			Snow = Vector3.new(1394.46399, 39.0448875, -1321.63904),
			["Starter Island"] = Vector3.new(1038.29968, 112.1365051, 1287.83447),
			["Starter Marine"] = Vector3.new(-3096.51929, 231.443558, 2087.51929),
			Underwater = Vector3.new(61147.9766, 20.5708408, 1366.09839),
			["Upper Sky"] = Vector3.new(-7950.03662, 5815.68457, -1968.3374),
			Volcano = Vector3.new(-5513.97852, 64.4943161, 8577.40039),
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
			Skull = Vector3.new(-2956.24341, 123.399323, -9981.06934),
			Snow = Vector3.new(1210, 429, -4663),
			["Winter Castle"] = Vector3.new(5544.71777, 60.1393852, -6359.08887),
		},
		Sea3 = {
			["Cake Land"] = Vector3.new(-2098.970458984375, 76.39494323730469, -12128.359375),
			["Chocolate Land"] = Vector3.new(379.1396179199219, 130.20599365234375, -12720.83984375),
			["Great Tree"] = Vector3.new(4345.09375, 575.0524291992188, -6159.00439453125),
			["Haunted Castle"] = Vector3.new(-9515.0009765625, 149.18876647949, 5534.0502929688),
			["Hydra Arena"] = Vector3.new(5020.94580078125, 174.08645629882812, -2011.18505859375),
			["Hydra Town"] = Vector3.new(5288.62158203125, 1011.6527709960938, 392.4296875),
			["Ice Cream Land"] = Vector3.new(-917.54852294922, 63.364143371582, -10858.696289062),
			["Peanut Land"] = Vector3.new(-2037.8001708984, 13.651118278503, -9948.2021484375),
			Port = Vector3.new(-342.4343566894531, 23.8315486907959, 5547.345703125),
			["Sea Castle"] = Vector3.new(-5502.1787109375, 323.6708984375, -2863.4616699219),
			["Tiki Outpost"] = Vector3.new(-16456.4629, 530.251953, 436.231812),
			["Turtle Center"] = Vector3.new(-12007.979492188, 339.15548706055, -9178.580078125),
			["Turtle Entrance"] = Vector3.new(-10163.96484375, 340.29028320313, -8320.767578125),
			["Turtle Mansion"] = Vector3.new(-12538.421875, 339.39358520508, -7817.0708007813),
			["Turtle Mountain"] = Vector3.new(-12856.61328125, 852.75360107422, -10715.23046875),
		},
	},
	{},
	game:GetService("CollectionService"),
	0,
	false
local function I()
	L = tick() + 1.5
	if not S:HasTag(t, "Teleporting") then
		S:AddTag(t, "Teleporting")
		d = true
	end
end
task.spawn(function()
	while task.wait(0.1) do
		if d and tick() >= L then
			S:RemoveTag(t, "Teleporting")
			d = false
		end
	end
end)
spawn(function()
	local S = (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetUnlockables"))
	repeat
		task.wait()
		S = (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetUnlockables"))
	until S
	if S.DefeatedIndraTrueForm and game.PlaceId == getgenv().CheckPlaceId then
		Q["Caslte On The Sea"] = Vector3.new(-4967.6826171875, 314.88238525390625, -3157.098388671875)
		Q.Hydra = Vector3.new(5661.5302734375, 1013.4113159179688, -334.9619140625)
		Q.Mansion = Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125)
	end
	if game.PlaceId == getgenv().CheckPlaceId then
		Q["Temple Clock"] = Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586)
	end
	if game.PlaceId == getgenv().CheckPlaceId2 then
		Q["122"] = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)
		Q["3032"] = Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
	end
	if S.FlamingoAccess and game.PlaceId == getgenv().CheckPlaceId2 then
		Q.Mansion = Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312)
		Q.Flamingo = Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625)
	end
	local S, L = game.PlaceId, getgenv().CheckPlaceId3
	if S == L then
		Q = {
			["1"] = Vector3.new(-7894.6201171875, 5545.49169921875, -380.2467346191406),
			["2"] = Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
			["3"] = Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
			["4"] = Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875),
		}
	end
end)
local S, L, d = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("VirtualInputManager")
local function _()
	local o = t.Data:FindFirstChild("DevilFruit")
	if not o or o.Value ~= "Portal-Portal" then
		return false
	end
	local V = t.PlayerGui.Main.Skills:FindFirstChild(o.Value)
	o = V and (V:FindFirstChild("C"))
	if not o or not o:IsA("Frame") then
		V = t.Character:FindFirstChild("Portal-Portal") or (t.Backpack:FindFirstChild("Portal-Portal"))
		if not V then
			return false
		end
		t.Character:FindFirstChildOfClass("Humanoid"):EquipTool(V)
		return false
	end
	V = o:FindFirstChild("Cooldown")
	return o.Title.TextColor3 == Color3.new(1, 1, 1)
		and (V.Size == UDim2.new(0, 0, 1, -1) or V.Size == UDim2.new(1, 0, 1, -1))
end
local function o(V)
	local N = t.Character:FindFirstChild("Portal-Portal") or (t.Backpack:FindFirstChild("Portal-Portal"))
	if not N then
		return false
	end
	t.Character:FindFirstChildOfClass("Humanoid"):EquipTool(N)
	N = t.PlayerGui.Main:FindFirstChild("Gateway")
	if not N then
		return false
	end
	d:SendKeyEvent(true, "C", false, game)
	d:SendKeyEvent(false, "C", false, game)
	local y = tick() + 3
	repeat
		task.wait(0.1)
	until N.Visible or tick() > y
	if not N.Visible then
		return false
	end
	y = N:FindFirstChild("MainContent")
	if not y then
		return false
	end
	N = y.ScrollingFrame:FindFirstChild(tostring(V))
	if N and N.MouseButton1Click then
		for V, V in pairs(getconnections(N.MouseButton1Click)) do
			pcall(function()
				V.Function()
			end)
		end
		return true
	end
	return false
end
G = {
	[Vector3.new(-16455.29, 527.75, 436.11)] = Vector3.new(-4967.68, 314.88, -3157.1),
	[Vector3.new(-9513.47, 142.1, 5528.84)] = Vector3.new(-4967.68, 314.88, -3157.1),
	[Vector3.new(-340.89, 20.6, 5549.8)] = Vector3.new(5661.53, 1013.41, -334.96),
	[Vector3.new(-2100.75, 69.98, -12128.27)] = Vector3.new(28282.57, 14896.85, 105.1),
	[Vector3.new(380.74, 126.58, -12726.16)] = Vector3.new(28282.57, 14896.85, 105.1),
	[Vector3.new(-916.08, 56.24, -10858.4)] = Vector3.new(28282.57, 14896.85, 105.1),
	[Vector3.new(-2039.6, 9.67, -9947.76)] = Vector3.new(28282.57, 14896.85, 105.1),
}
do
	local G = Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586)
	local function V()
		local N = t.Character and (t.Character:FindFirstChild("HumanoidRootPart"))
		return N ~= nil and (N.Position - G).Magnitude < 1000
	end
	function BorrowTempleOfTime()
		local G = game.ReplicatedStorage.MapStash:FindFirstChild("Temple of Time")
		if not G then
			return
		end
		G:SetAttribute("ClientBorrowed", true)
		G.Parent = workspace.Map
		task.spawn(function()
			local N = tick() + 30
			repeat
				task.wait(0.25)
			until G.Parent ~= workspace.Map or (V()) or tick() > N
			G:SetAttribute("ClientBorrowed", nil)
			if not V() and G.Parent == workspace.Map then
				G.Parent = game.ReplicatedStorage.MapStash
			end
		end)
	end
	function GetTempleOfTime()
		local G = workspace.Map:FindFirstChild("Temple of Time")
		if G and not G:GetAttribute("ClientBorrowed") then
			return G
		end
	end
end
local G = false
getgenv().IsPlayerDead = function()
	if not t.Character or not t.Character:FindFirstChild("Humanoid") or t.Character.Humanoid.Health == 0 then
		return true
	end
end
CS = game:GetService("CollectionService")
cam = workspace.CurrentCamera
function LoadIslandByFakePoint(V)
	local N = Instance.new("Part")
	N.Transparency = 1
	N.CanCollide = false
	N.Anchored = true
	N.Size = Vector3.new(0, 0, 0)
	N.CFrame = CFrame.new(V:GetPivot().Position)
	CS:AddTag(N, "LoDPosition")
	N.Parent = cam
	return N
end
spawn(function()
	pcall(function()
		for V, V in ipairs(workspace:GetChildren()) do
			if V:IsA("Model") and (V:GetAttribute("LevelOfDetailDiameter")) then
				LoadIslandByFakePoint(V)
			end
		end
		for V, V in ipairs(workspace.Map:GetChildren()) do
			if V:IsA("Model") then
				LoadIslandByFakePoint(V)
			end
		end
		for V, V in ipairs(game:GetService("ReplicatedStorage").FakeIslands:GetChildren()) do
			if V:IsA("Model") then
				LoadIslandByFakePoint(V)
			end
		end
	end)
end)
getgenv().TweenGuidePart = nil
getgenv().TweenConnection = nil
getgenv().TweenInProgress = false
getgenv().lastTarget = nil
local function V(N)
	local y, x
	for k, P in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
		if P:IsA("BasePart") and not P:GetAttribute("IgnoreInTracking") then
			k = (P.Position - N).Magnitude
			if not y or k < y then
				y, x = k, P
			end
		end
	end
	return x
end
local function N(y)
	local x = V(y)
	if not x then
		return nil
	end
	local k = x:FindFirstChild("Mesh")
	if k then
		if k.Scale.X / 2 >= (x.Position - y).Magnitude then
			return x
		else
			return nil
		end
	end
	return x
end
function DetectNpcOni()
	local y = t.Character and (t.Character:FindFirstChild("HumanoidRootPart"))
	if not y then
		return
	end
	local x, k, P, e = next, { workspace.NPCs, game:GetService("ReplicatedStorage").NPCs }, 1 / 0
	for Y, H in x, k, nil do
		local x, k, B = next, H:GetChildren()
		for H, H in x, k, B do
			if
				H:GetAttribute("NPCLoaded")
				and (H:GetAttribute("NPCReady"))
				and H:GetAttribute("DisplayName") == "Celestial Member"
				and (H:FindFirstChild("HumanoidRootPart"))
			then
				Y = (y.Position - H.HumanoidRootPart.Position).Magnitude
				if Y < P then
					P, e = Y, H
				end
			end
		end
	end
	return e, P
end
CelestialDomainController =
	require(game:GetService("ReplicatedStorage").Controllers.MapServices.CelestialDomainController)
LocalPlayer = t
L = game:GetService("ReplicatedStorage")
WorldOrigin = workspace:WaitForChild("_WorldOrigin", 10)
travelFunctions = {}
PlayerSpawnsLot = {}
BypassTpLocation = {}
PlrData = game:GetService("Players").LocalPlayer.Data
localPlayerFunctions = {}
function localPlayerFunctions.IsAlive()
	local y = LocalPlayer.Character
	if not y then
		return false
	end
	local x = y:FindFirstChildOfClass("Humanoid")
	if not x then
		return false
	end
	return x.Health > 0
end
function getHRP()
	local y = LocalPlayer.Character
	if not y then
		return nil
	end
	return y:FindFirstChild("HumanoidRootPart") or (y:FindFirstChild("UpperTorso")) or (y:FindFirstChild("Torso"))
end
function travelFunctions.GetDistance(y, x)
	if not localPlayerFunctions.IsAlive() then
		return 1 / 0
	end
	if not x then
		local k = getHRP()
		if not k then
			return 1 / 0
		end
		x = k.Position
	end
	return (y - x).Magnitude
end
function travelFunctions.LoadBypassTPLocation()
	table.clear(PlayerSpawnsLot)
	table.clear(BypassTpLocation)
	local y, x = WorldOrigin:FindFirstChild("PlayerSpawns"), WorldOrigin:FindFirstChild("Locations")
	if not y or not x then
		return
	end
	for k, k in ipairs(y:GetChildren()) do
		for y, y in ipairs(k:GetChildren()) do
			if y:IsA("Model") then
				table.insert(PlayerSpawnsLot, { y.Name, y:GetModelCFrame() })
			end
		end
		k.ChildAdded:Connect(function(y)
			task.wait()
			if y:IsA("Model") then
				table.insert(PlayerSpawnsLot, { y.Name, y:GetModelCFrame() })
			end
		end)
	end
	local function y(k)
		if not k:IsA("BasePart") then
			return
		end
		BypassTpLocation[k.Name] = {}
		local P = k:FindFirstChildWhichIsA("SpecialMesh")
		local e = P and P.Scale.X or 1
		P = k.Size.X * e / 2
		for e, e in ipairs(PlayerSpawnsLot) do
			if (e[2].Position - k.Position).Magnitude <= P then
				table.insert(BypassTpLocation[k.Name], e)
			end
		end
	end
	for k, k in ipairs(x:GetChildren()) do
		y(k)
	end
	x.ChildAdded:Connect(function(x)
		task.wait(3)
		y(x)
	end)
end
function travelFunctions.GetTPLocation(y)
	local x = WorldOrigin:FindFirstChild("Locations")
	if not x then
		return nil
	end
	local k, P = 1 / 0
	for e, Y in ipairs(x:GetChildren()) do
		e = BypassTpLocation[Y.Name]
		if e then
			local x = Y:FindFirstChildWhichIsA("SpecialMesh")
			local H = x and x.Scale.X or 1
			if Y.Size.X * H / 2 >= travelFunctions.GetDistance(y, Y.Position) then
				for x, Y in ipairs(e) do
					x = travelFunctions.GetDistance(y, Y[2].Position)
					if x < k then
						k, P = x, Y[1]
					end
				end
			end
		end
	end
	return P
end
function travelFunctions.TweenBypass(y, x)
	x = x or 0
	if x >= 5 then
		return
	end
	local k, P = pcall(function()
		if not y then
			return
		end
		if not next(BypassTpLocation) then
			travelFunctions.LoadBypassTPLocation()
		end
		local e = LocalPlayer.Character
		if not e then
			return
		end
		if not getHRP() then
			return
		end
		local Y = {}
		for H, H in pairs(BypassTpLocation) do
			for B, B in ipairs(H) do
				if not table.find(Y, B[2]) then
					table.insert(Y, B[2])
				end
			end
		end
		if #Y == 0 then
			return
		end
		table.sort(Y, function(H, B)
			return travelFunctions.GetDistance(H.Position, y.Position)
				< travelFunctions.GetDistance(B.Position, y.Position)
		end)
		local H = e:FindFirstChild("LastSpawnPoint")
		if H then
			H.Disabled = true
		end
		task.wait()
		for B, Z in ipairs(Y) do
			B = travelFunctions.GetTPLocation(Z.Position)
			if B then
				local Y = travelFunctions.GetDistance(Z.Position, y.Position)
				if
					travelFunctions.GetDistance(y.Position) > Y + 500
					and travelFunctions.GetDistance(Z.Position) >= 1000
				then
					CommF:InvokeServer("SetLastSpawnPoint", B)
					if PlrData.LastSpawnPoint.Value == B then
						e.Humanoid.Health = 0
						repeat
							task.wait()
						until localPlayerFunctions.IsAlive()
						if H then
							H.Disabled = false
						end
						travelFunctions.TweenBypass(y, x + 1)
						return true
					end
				end
			end
		end
		if H then
			H.Disabled = false
		end
	end)
	if not k then
		warn("[TweenBypass ERROR]:", P)
	end
	return false
end
function ShouldResetTeleportSmart(y)
	if not Settings["Reset Teleport"] then
		return false
	end
	if G or ReadyToDodge then
		return false
	end
	local x = getHRP()
	if not x then
		return false
	end
	local k, P = N(y.Position), N(x.Position)
	if not k then
		return true
	end
	if P and k and P.Name == k.Name then
		return false
	end
	return true
end
task.spawn(function()
	travelFunctions.LoadBypassTPLocation()
end)
BypassTp = travelFunctions
local function y(x)
	if x:FindFirstChild("FloatForce") then
		return
	end
	local k = Instance.new("BodyVelocity")
	k.Name = "FloatForce"
	k.Velocity = Vector3.new(0.0, 0.0, 0.0)
	k.MaxForce = Vector3.new(100000, 100000, 100000)
	k.P = 10000
	k.Parent = x
end
local x, k, P, e, Y =
	game:GetService("RunService"), { LastTP = 0, LastCF = nil, ActiveConnection = nil, LastCall = 0 }, 18, 120, 40
local function H()
	local B = getgenv().CharSpeed
	if not B then
		B = { cap = 1000, nextRaise = 0 }
		getgenv().CharSpeed = B
	end
	return B
end
local function B(Z, C, J, F)
	if not Z or typeof(C) ~= "CFrame" then
		return
	end
	local q = t.Character
	local c = q and (q:FindFirstChildOfClass("Humanoid"))
	if not q or Z.Parent ~= q or not c or c.Health <= 0 then
		return
	end
	if tick() - k.LastTP < 1 and C == k.LastCF then
		return
	end
	TweenManager.CancelTweenOnly()
	if k.ActiveConnection and coroutine.status(k.ActiveConnection) == "suspended" then
		pcall(coroutine.close, k.ActiveConnection)
	end
	J = math.max(tonumber(J) or 350, 1)
	F = tonumber(F) or 2.5
	k.LastTP = tick()
	k.LastCF = C
	local c, D = false
	local r = {}
	local function n()
		if k.ActiveConnection == D then
			k.ActiveConnection = nil
		end
		if TweenManager.currentTween == r then
			TweenManager.currentTween = nil
			TweenManager.currentPart = nil
			TweenManager.currentGoal = nil
			TweenManager.TweenRunning = false
		end
		if getgenv().Tween == r then
			getgenv().Tween = nil
		end
	end
	r.Pause = function(u)
		c = true
		if D and coroutine.status(D) == "suspended" then
			pcall(coroutine.close, D)
		end
	end
	r.Cancel = function(u)
		u:Pause()
		n()
	end
	r.Destroy = function(u)
		u:Cancel()
	end
	D = coroutine.create(function()
		local u, W = Z.Position, C.Position
		local O, z, U, h, p, w = (W - u).Magnitude, 1 / 0, (tick()), true
		while not c do
			local M = t.Character
			local j = M and (M:FindFirstChildOfClass("Humanoid"))
			if M ~= q or Z.Parent ~= M or not j or j.Health <= 0 or Z.Anchored or O <= F then
				break
			end
			local q, v0, T0 = x.Heartbeat:Wait(), H(), Z.Position
			M = (W - T0).Magnitude
			if M < z - 5 then
				z, U = M, (tick())
			else
				h = (function() if tick() - U > 2.5 then return false else return h end end)()
			end
			if h and p and w and M > w + Y then
				v0.cap = math.max(v0.cap * 0.7, e)
				v0.nextRaise = tick() + 3
				u = T0
			else
				u = (function() if h and p and (T0 - p).Magnitude > Y then return T0 else return u end end)()
			end
			j = W - u
			local e, Y = j.Magnitude, math.min(math.min(J, v0.cap) * q, P)
			if e > Y and tick() >= v0.nextRaise then
				v0.cap = math.min(v0.cap * 1.08, J)
				v0.nextRaise = tick() + 1.5
			end
			u = (function() if e <= Y or e <= 0.05 then return W else return u + j / e * Y end end)()
			O = (W - u).Magnitude
			I()
			getgenv().noclip = true
			Z.CFrame = CFrame.new(u)
			Z.AssemblyLinearVelocity = Vector3.new(0.0, 0.0, 0.0)
			Z.AssemblyAngularVelocity = Vector3.new(0.0, 0.0, 0.0)
			p, w = u, M
		end
		if not c and Z.Parent == t.Character and (W - Z.Position).Magnitude <= F then
			Z.CFrame = C
			Z.AssemblyLinearVelocity = Vector3.new(0.0, 0.0, 0.0)
			Z.AssemblyAngularVelocity = Vector3.new(0.0, 0.0, 0.0)
		end
		n()
	end)
	k.ActiveConnection = D
	TweenManager.currentTween = r
	TweenManager.currentPart = Z
	TweenManager.currentGoal = C
	TweenManager.TweenRunning = true
	getgenv().Tween = r
	if not coroutine.resume(D) then
		r:Cancel()
		return
	end
	return r
end

-- ===== SEA1 GATE: Sky2 <-> Sky3 | Xoáy Nước <-> Under City =====
do
	local Sea1Gate = {}
	getgenv().Sea1Gate = Sea1Gate
	local Sea2Gate = {}
	getgenv().Sea2Gate = Sea2Gate
	local CFG = {
		SKY2_POS = Vector3.new(-4210, 1092, -374),
		SKY_START_POS = Vector3.new(-6022, 5485, 2222),
		SKY_ENTRANCE_POS = Vector3.new(-4166.60986328125, 1093.697998046875, -347.16226196289062),
		UNDER_WAIT_POS = Vector3.new(4047, 10, -1816),
		UNDER_ENTRANCE_POS = Vector3.new(61163.8515625, 11.680007934570312, 1819.7840576171875),
		XOAY_WAIT_POS = Vector3.new(61170, 10, 1955),
		XOAY_ENTRANCE_POS = Vector3.new(3864.68798828125, 6.73699951171875, -1926.2139892578125),
		SKY3_Y = 4000,
		UNDER_X = 40000,
		CLICK_INTERVAL = 0.5,
	}
	local st = { lastClick = 0, arrivedAt = nil, lastEntrance = 0 }

	local function zoneOf(pos)
		if pos.X > CFG.UNDER_X then
			return "Under"
		end
		if pos.Y > CFG.SKY3_Y then
			return "Sky3"
		end
		return "Main"
	end

	local function flyTo(H, pos)
		B(H, CFrame.new(pos), tonumber(Settings["Speed Tween "]) or 300, 8)
	end

	local CLICK_UDIM = UDim2.new(0.15, 0, 0.15, 0)
	local function doClick()
		local vim = game:GetService("VirtualInputManager")
		local vp = workspace.CurrentCamera.ViewportSize
		local x = vp.X * CLICK_UDIM.X.Scale + CLICK_UDIM.X.Offset
		local y = vp.Y * CLICK_UDIM.Y.Scale + CLICK_UDIM.Y.Offset
		vim:SendMouseButtonEvent(x, y, 0, true, game, 1)
		vim:SendMouseButtonEvent(x, y, 0, false, game, 1)
	end

	-- bay tới điểm chờ -> delay -> requestEntrance (có throttle, tự lặp lại nếu chưa qua được)
	local function gate(H, waitPos, entrancePos, delay, after)
		if tick() < (st.cool or 0) then
			return false
		end
		if (H.Position - waitPos).Magnitude > 15 then
			st.arrivedAt = nil
			flyTo(H, waitPos)
			return true
		end
		local now = tick()
		if not st.arrivedAt then
			st.arrivedAt = now
			return true
		end
		if now - st.arrivedAt < delay or now - st.lastEntrance < 1.5 then
			return true
		end
		if not st.attemptStart or now - st.attemptStart > 60 then
			st.attemptStart, st.attempts = now, 0
		end
		st.attempts = st.attempts + 1
		if st.attempts > 5 then
			st.cool, st.arrivedAt, st.attemptStart = now + 30, nil, nil
			return false
		end
		st.lastEntrance = now
		I()
		pcall(function()
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", entrancePos)
		end)
		task.wait(0.6)
		if after then
			pcall(after)
		end
		return true
	end

	-- Main -> Sky3: bay tới Sky2, cầm weapon đã chọn ở Setting Farm (Melee/Sword: click tại UDim2(0.15,0.15); Blox Fruit: spam skill) tới khi Y > SKY3_Y
	local function startClickLoop()
		if st.clicking then
			return
		end
		st.clicking = true
		task.spawn(function()
			local lastEquip = 0
			while tick() - (st.climbTick or 0) < 0.6 do
				local hrp = getHRP()
				if not hrp or hrp.Position.Y > CFG.SKY3_Y then
					break
				end
				local weaponType = Settings["Select Weapon"] or "Melee"
				if tick() - lastEquip >= 0.5 then
					lastEquip = tick()
					local name = NameWeapon and NameWeapon(weaponType)
					if name and equiptool then
						equiptool(name)
					end
				end
				if weaponType == "Blox Fruit" and type(UseSkillonlyFruit) == "function" then
					-- Blox Fruit: spam skill thay vì click
					pcall(UseSkillonlyFruit)
				else
					doClick()
				end
				task.wait()
			end
			st.clicking = false
		end)
	end

	local function climbSky3(H)
		local d = (H.Position - CFG.SKY2_POS).Magnitude
		if d > 15 then
			flyTo(H, CFG.SKY2_POS)
		end
		if d < 60 then
			st.climbTick = tick()
			startClickLoop()
		end
		return true
	end

	-- return true = tick này đã bị cổng xử lý, toTarget phải return
	function Sea1Gate.Step(H, targetPos)
		local pz, tz = zoneOf(H.Position), zoneOf(targetPos)
		if pz == tz then
			st.arrivedAt = nil
			return false
		end
		getgenv().noclip = true
		if pz == "Under" then
			-- Cặp 2: Under City -> Xoáy Nước
			return gate(H, CFG.XOAY_WAIT_POS, CFG.XOAY_ENTRANCE_POS, 0.6)
		elseif pz == "Sky3" then
			-- Cặp 1: Sky3 -> Sky2
			return gate(H, CFG.SKY_START_POS, CFG.SKY_ENTRANCE_POS, 0.7, function()
				local hrp = getHRP()
				if hrp and hrp.Position.Y < CFG.SKY3_Y then
					hrp.CFrame = hrp.CFrame + Vector3.new(0, 30, 0)
				end
			end)
		elseif tz == "Sky3" then
			-- Cặp 1: Sky (1/2) -> Sky3
			return climbSky3(H)
		elseif tz == "Under" then
			-- Cặp 2: Xoáy Nước -> Under City
			return gate(H, CFG.UNDER_WAIT_POS, CFG.UNDER_ENTRANCE_POS, 0.6)
		end
		return false
	end

	-- ===== SEA 2: cặp 1 (Flamingo Mansion <-> Flamingo Room), cặp 2 (Cursed Ship <-> Door Ship) =====
	local C2 = {
		MANSION_WAIT = Vector3.new(-287, 328, 591),
		MANSION_ENTRANCE = Vector3.new(-286.9859619140625, 306.13739013671875, 597.8905029296875),
		ROOM_WAIT = Vector3.new(2285, 42, 911),
		ROOM_ENTRANCE = Vector3.new(2284.9091796875, 15.537796020507812, 905.4727783203125),
		MANSION_R = 900,
		MANSION_MIN_Y = 200,
		ROOM_R = 600,
		DOOR_WAIT = Vector3.new(-6498, 106, -119),
		SHIP_ENTRANCE = Vector3.new(923.2130126953125, 126.97599792480469, 32852.83203125),
		SHIP_WAIT = Vector3.new(923, 125, 32853),
		DOOR_ENTRANCE = Vector3.new(-6508.55810546875, 89.035003662109375, -132.83999633789062),
		SHIP_Z = 20000,
	}

	local SHIP_FLAG = nil -- nếu biết tên cờ unlock của Cursed Ship trong GetUnlockables thì điền vào đây

	local function horiz(a, b)
		return Vector3.new(a.X - b.X, 0, a.Z - b.Z).Magnitude
	end

	local function flamZone(pos)
		if pos.Y > C2.MANSION_MIN_Y and horiz(pos, C2.MANSION_WAIT) < C2.MANSION_R then
			return "Mansion"
		end
		if horiz(pos, C2.ROOM_WAIT) < C2.ROOM_R then
			return "Room"
		end
		return nil
	end

	local function lift(cond, dy)
		return function()
			local hrp = getHRP()
			if hrp and cond(hrp.Position) then
				hrp.CFrame = hrp.CFrame + Vector3.new(0, dy, 0)
			end
		end
	end

	-- return true = tick này đã bị cổng xử lý, toTarget phải return
	function Sea2Gate.Step(H, targetPos)
		local pos = H.Position
		local pShip, tShip = pos.Z > C2.SHIP_Z, targetPos.Z > C2.SHIP_Z

		-- Cặp 2: Cursed Ship <-> Door Ship
		if pShip ~= tShip then
			if SHIP_FLAG and not getgenv().IsUnlocked(SHIP_FLAG) then
				return false
			end
			getgenv().noclip = true
			if tShip then
				return gate(H, C2.DOOR_WAIT, C2.SHIP_ENTRANCE, 0.6, lift(function(p)
					return p.Z > C2.SHIP_Z
				end, 60))
			end
			return gate(H, C2.SHIP_WAIT, C2.DOOR_ENTRANCE, 0.6, lift(function(p)
				return p.Z < C2.SHIP_Z
			end, 30))
		end
		if pShip then
			st.arrivedAt = nil
			return false
		end

		-- Cặp 1: Flamingo Mansion <-> Flamingo Room (chỉ khi đã unlock Flamingo, giữ nguyên check cũ)
		if not getgenv().IsUnlocked("FlamingoAccess") then
			return false
		end
		local tz = flamZone(targetPos)
		if tz then
			local dM = (pos - C2.MANSION_WAIT).Magnitude
			local dR = (pos - C2.ROOM_WAIT).Magnitude
			if tz == "Mansion" and dR < dM then
				getgenv().noclip = true
				return gate(H, C2.ROOM_WAIT, C2.MANSION_ENTRANCE, 0.6, lift(function(p)
					return flamZone(p) == "Mansion"
				end, 30))
			elseif tz == "Room" and dM < dR then
				getgenv().noclip = true
				return gate(H, C2.MANSION_WAIT, C2.ROOM_ENTRANCE, 0.6, lift(function(p)
					return flamZone(p) == "Room"
				end, 30))
			end
		end
		st.arrivedAt = nil
		return false
	end
end

-- ===== SEA 3 v2: Hydra / Castle on the Sea / Mansion / Tiki (Castle là trung tâm) =====
do
	local Sea3Gate = {}
	getgenv().Sea3Gate = Sea3Gate
	local V3 = Vector3.new

	-- ===== QUY TAC CHUNG CHO MOI "DUONG TAT" (hub Sea3, tau ngam, portal, requestEntrance) =====
	-- Mac dinh chi so TONG QUANG DUONG BAY: bay thang gan hon thi bay thang, qua duong tat gan hon thi qua duong tat.
	-- direct = player->dich, viaFly = tong cac doan bay that khi dung duong tat. (overheadSec/margin mac dinh 0, chi la tuy chon tinh them)
	getgenv().ShortcutWorth = function(direct, viaFly, overheadSec)
		local speed = tonumber(Settings["Speed Tween "]) or 300
		local margin = tonumber(getgenv().Sea3RouteMargin) or 0
		return viaFly + (overheadSec or 0) * speed + margin < direct
	end

	-- mỗi hop = 1 cặp cổng: bay tới `fly` -> chờ 0.6 -> (requestEntrance | nhảy) -> chờ 0.6 -> Y+100
	local HOP = {
		["Castle>Hydra"] = { to = "Hydra", fly = V3(-5027.0302734375, 330, -3206.70361328125), ent = V3(5662, 1013, -338), need = "indra" },
		["Hydra>Castle"] = { to = "Castle", fly = V3(5659, 1030, -334), ent = V3(-5021, 314, -3194), need = "indra" },
		["Mansion>Castle"] = { to = "Castle", fly = V3(-12463.6025390625, 398, -7566.0830078125), ent = V3(-5055, 314, -3179), need = "indra" },
		["Castle>Mansion"] = { to = "Mansion", fly = V3(-5060.41162109375, 330, -3193.224853515625), ent = V3(-12465, 374, -7554), need = "indra" },
		["Tiki>Castle"] = { to = "Castle", fly = V3(-16800, 59, 291), jump = "Castle", need = "tiki" },
		["Castle>Tiki"] = { to = "Tiki", fly = V3(-5098, 316, -3179), jump = "Tiki", need = "tiki" },
		-- tuyến tàu ngầm: Tiki -> Submerged Island (điểm bay tới lấy từ khối tele cũ của script)
		["Tiki>Submerged"] = { to = "Submerged", fly = V3(-16269.4082, 23.9799957, 1371.66235), sub = true, need = "tiki" },
	}
	local LIFT = 100

	-- điểm đại diện từng đảo (xác định player "gần" đảo nào)
	local REFS = {
		Hydra = { V3(3399, 72, 1572), V3(5245, 602, 251), V3(5288, 1011, 392), V3(5661, 1013, -334), V3(5659, 1030, -334) },
		Castle = { V3(-5500, 314, -2855), V3(-5055, 314, -3179), V3(-5027, 318, -3206), V3(-5060, 330, -3193), V3(-5098, 316, -3179) },
		Mansion = {
			V3(-12463, 375, -7549), V3(-12548, 337, -7481), V3(-12463.6, 398, -7566),
			V3(-12538, 339, -7817), -- Turtle Mansion
			V3(-12008, 339, -9179), -- Turtle Center
			V3(-10164, 340, -8321), -- Turtle Entrance
			V3(-12857, 853, -10715), -- Turtle Mountain
		},
		Tiki = { V3(-16204, 9, 479), V3(-16456, 530, 436), V3(-16800, 59, 291) },
	}
	local function minDist(pos, refs)
		local m = math.huge
		for _, r in ipairs(refs) do
			local d = (pos - r).Magnitude
			if d < m then
				m = d
			end
		end
		return m
	end

	local function nearestHub(pos)
		local best, bd
		for name, refs in pairs(REFS) do
			local d = minDist(pos, refs)
			if not bd or d < bd then
				best, bd = name, d
			end
		end
		return best, bd
	end

	-- đảo `name` có dùng được làm đích trung gian không (Castle luôn dùng được)
	local function hubOpen(name)
		if name == "Castle" then
			return true
		end
		local need = HOP["Castle>" .. name].need
		if need == "indra" then
			return getgenv().IsUnlocked("DefeatedIndraTrueForm")
		end
		if need == "tiki" then
			return getgenv().IsTikiBossKilled()
		end
		return true
	end

	-- đảo gần nhất trong các đảo đang mở (đích gần Tiki mà Tiki đóng -> lấy đảo gần nhất còn lại, thường là Castle)
	local function nearestOpenHub(pos)
		local best, bd
		for name, refs in pairs(REFS) do
			if hubOpen(name) then
				local d = minDist(pos, refs)
				if not bd or d < bd then
					best, bd = name, d
				end
			end
		end
		return best
	end

	-- các đảo đi bằng tàu ngầm (npc ở Submerged Island): tên dùng cho InitiateTeleport + vị trí đại diện
	local SUB_ISLANDS = {
		["Turtle Mountain"] = V3(-9537, 7, -8348),
		["Hydra Town"] = V3(3251, 5, 2431),
		["Chocolate Land"] = V3(-155, 7, -11938),
		["Sea Castle"] = V3(-6071, 16, -2155),
		["Haunted Castle"] = V3(-9517, 20, 4565),
		["Port"] = V3(6, 10, 5397),
		["Peanut Land"] = V3(-2041, 4, -9826),
		["Great Tree"] = V3(2041, 21, -6525),
		["Ice Cream Land"] = V3(-1007, 7, -10745),
		["Cake Land"] = V3(-1989, 9, -11411),
	}

	-- gần nhất trong (các đảo tàu ngầm + các đảo cổng đang mở); trả về tên đảo tàu ngầm nếu nó thắng
	local CAKE_ARENA = Vector3.new(-1990.67, 4532.97, -14973.67)
	local function nearestNode(pos, onlyOpen)
		-- arena Cake Prince nằm trên trời nên "gần nhất" bị lệch sang Chocolate Land -> coi như Cake Land
		if (pos - CAKE_ARENA).Magnitude <= 1000 then
			return "Cake Land"
		end
		local best, bd
		for name, p in pairs(SUB_ISLANDS) do
			local d = (pos - p).Magnitude
			if not bd or d < bd then
				best, bd = name, d
			end
		end
		for name, refs in pairs(REFS) do
			if not onlyOpen or hubOpen(name) then
				local d = minDist(pos, refs)
				if not bd or d < bd then
					best, bd = name, d
				end
			end
		end
		return best
	end

	-- dùng cho cả Sea3Gate.Step và khối Submerged trong toTarget
	getgenv().SubmarineDest = function(pos)
		if not Settings["Use Submarine Teleport"] then
			return nil
		end
		if not getgenv().IsTikiBossKilled() then
			return nil -- cổng Tiki đóng thì không đi tàu ngầm được
		end
		local best = nearestNode(pos, true)
		if SUB_ISLANDS[best] then
			return best
		end
		return nil
	end

	-- Castle làm trung tâm: A -> Castle -> B
	local function route(ph, dh)
		local hops = {}
		if ph ~= "Castle" then
			hops[#hops + 1] = ph .. ">Castle"
		end
		if dh ~= "Castle" then
			hops[#hops + 1] = "Castle>" .. dh
		end
		return hops
	end

	local running, cancelled, cool, fails = false, false, 0, 0

	local function dbg(...)
		if getgenv().DebugSea3 then
			print("[Sea3]", ...)
		end
	end
	local lastWhy = 0
	local function why(msg)
		if getgenv().DebugSea3 and tick() - lastWhy > 3 then
			lastWhy = tick()
			print("[Sea3] bỏ qua cổng:", msg)
		end
	end

	-- watchdog của script sẽ CancelCurrent (xoá FloatForce, bật CanCollide) nếu toTarget
	-- không được gọi trong 2s. Vì Sea3 chạy blocking nên phải tự làm mới LastCall.
	local function alive()
		k.LastCall = tick()
		getgenv().noclip = true
		I()
	end

	local function hold(t)
		local t0 = tick()
		while tick() - t0 < t do
			if cancelled then
				return
			end
			alive()
			task.wait(0.1)
		end
	end

	local function flyTo(pos, radius, timeout)
		radius = radius or 15
		local t0 = tick()
		while tick() - t0 < (timeout or 90) do
			if cancelled then
				return false
			end
			local hrp = getHRP()
			if not hrp then
				return false
			end
			if (hrp.Position - pos).Magnitude < radius then
				return true
			end
			alive()
			B(hrp, CFrame.new(pos), tonumber(Settings["Speed Tween "]) or 300, 8)
			task.wait(0.15)
		end
		dbg("flyTo timeout/huỷ", pos)
		return false
	end

	local function doJump()
		local ch = game:GetService("Players").LocalPlayer.Character
		local hum = ch and ch:FindFirstChildOfClass("Humanoid")
		if not hum then
			return
		end
		alive()
		hum.Jump = true
		pcall(function()
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
		end)
		local vim = game:GetService("VirtualInputManager")
		vim:SendKeyEvent(true, "Space", false, game)
		task.wait(0.1)
		vim:SendKeyEvent(false, "Space", false, game)
	end

	-- đã gần thì thôi, chưa gần thì nhảy lặp lại ("gần" = đảo gần nhất là `name`)
	local function jumpUntilNear(name, timeout)
		local t0 = tick()
		while tick() - t0 < (timeout or 25) do
			if cancelled then
				return false
			end
			local hrp = getHRP()
			if not hrp then
				return false
			end
			if nearestHub(hrp.Position) == name then
				dbg("đã gần", name, "sau", math.floor((tick() - t0) * 10) / 10, "s")
				return true
			end
			dbg("chưa gần", name, "(đang gần", nearestHub(hrp.Position) .. ") -> nhảy")
			doJump()
			hold(0.6)
		end
		dbg("nhảy timeout, vẫn chưa tới", name)
		return false
	end

	local function runHop(h)
		dbg("hop ->", h.to, "bay tới", h.fly)
		if not flyTo(h.fly) then
			return false
		end
		hold(0.6)
		if h.sub then
			local b0 = getHRP()
			b0 = b0 and b0.Position
			pcall(function()
				game:GetService("ReplicatedStorage").Modules.Net
					:FindFirstChild("RF/SubmarineWorkerSpeak")
					:InvokeServer("TravelToSubmergedIsland")
			end)
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetLastSpawnPoint", "SubmergedIsland")
			end)
			hold(0.6)
			local c0 = getHRP()
			local moved = c0 and b0 and (c0.Position - b0).Magnitude > 500
			dbg("TravelToSubmergedIsland dịch chuyển:", moved)
			return moved and true or false
		end
		if h.ent then
			local before = getHRP()
			before = before and before.Position
			local moved = false
			for attempt = 1, 3 do
				I()
				local ok, res = pcall(function()
					return game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", h.ent)
				end)
				dbg("requestEntrance lần", attempt, h.ent, "ok=", ok, "res=", typeof(res), tostring(res))
				hold(0.6)
				local cur = getHRP()
				if cur and before and (cur.Position - before).Magnitude > 500 then
					moved = true
					break
				end
				dbg("chưa bị dịch chuyển, vị trí hiện tại", cur and cur.Position)
			end
			if not moved then
				dbg("requestEntrance KHÔNG dịch chuyển sau 3 lần ->", h.to)
				return false
			end
		else
			if not jumpUntilNear(h.jump) then
				return false
			end
			hold(0.6)
		end
		local hrp = getHRP()
		if not hrp then
			return false
		end
		hrp.CFrame = hrp.CFrame + Vector3.new(0, LIFT, 0)
		local hub = nearestHub(hrp.Position)
		dbg("xong hop, đang ở", hub, "mong đợi", h.to, hrp.Position)
		return hub == h.to
	end

	function Sea3Gate.Cancel()
		cancelled = true
	end

	-- ===== CHECK QUANG DUONG: di qua hub co dang khong? =====
	-- Moi hop = bay toi `fly` -> bi dich chuyen (tele gan nhu tuc thoi) -> ha canh o `ent` (hop `jump` khong co ent
	-- thi lay diem dai dien cua dao dich). Tong doan BAY THAT = player->fly1 + ent1->fly2 + ... + entN->dich.
	-- Chi di hub khi (tong doan bay + thoi gian cho moi hop quy ra stud) ngan hon bay thang player->dich.
	local function landingOf(h)
		if h.ent then
			return h.ent + V3(0, LIFT, 0)
		end
		local r = REFS[h.to]
		return r and r[1] or h.fly
	end
	-- tau ngam: sau hop "Tiki>Submerged" ha canh trong pocket Submerged, bay toi npc roi InitiateTeleport toi dao `island`
	local SUB_POCKET, SUB_NPC = V3(11538.6, -2154.7, 9827.3), V3(11427.9, -2156.4, 9726.2)
	local function routeFlyDist(pos, hops, targetPos, island)
		local cur, dist = pos, 0
		for _, key in ipairs(hops) do
			local h = HOP[key]
			dist = dist + (cur - h.fly).Magnitude
			cur = h.sub and SUB_POCKET or landingOf(h)
		end
		if island and SUB_ISLANDS[island] then
			dist = dist + (cur - SUB_NPC).Magnitude
			cur = SUB_ISLANDS[island]
		end
		return dist + (cur - targetPos).Magnitude
	end

	-- return true = cổng đã xử lý (hoặc đang bận), toTarget phải return
	function Sea3Gate.Step(H, targetPos)
		if running then
			return true
		end
		if tick() < cool then
			return false
		end
		if (targetPos - Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586)).Magnitude <= 3000 then
			return false -- đích là Temple of Time: khối vào đền lo, không dùng cổng/tàu ngầm
		end
		local pos = H.Position
		local hops
		local island = getgenv().SubmarineDest(targetPos)
		if island then
			-- đích gần đảo đi tàu ngầm: tới Submerged bằng logic trung gian, rồi khối Submerged trong toTarget lo phần npc
			if nearestNode(pos, false) == island then
				why("player và đích cùng gần " .. island)
				return false
			end
			local ph = nearestHub(pos)
			hops = {}
			if ph ~= "Tiki" then
				if ph ~= "Castle" then
					hops[#hops + 1] = ph .. ">Castle"
				end
				hops[#hops + 1] = "Castle>Tiki"
			end
			hops[#hops + 1] = "Tiki>Submerged"
			dbg("tàu ngầm ->", island, "route", ph, table.concat(hops, " | "))
		else
			local dh = nearestOpenHub(targetPos) -- đích gần đảo (đang mở) nào
			local ph = nearestHub(pos) -- player gần đảo nào
			if getgenv().DebugSea3 and nearestHub(targetPos) ~= dh then
				dbg("đích gần", nearestHub(targetPos), "nhưng cổng đang đóng -> dùng", dh)
			end
			if ph == dh then
				why("player và đích cùng gần đảo " .. ph)
				return false
			end
			hops = route(ph, dh)
			dbg("route", ph, "->", dh, table.concat(hops, " | "))
		end
		-- check unlock: chỉ cần 1 hop còn đóng là bỏ cả chuỗi và bay thẳng
		for _, key in ipairs(hops) do
			local need = HOP[key].need
			if need == "indra" and not getgenv().IsUnlocked("DefeatedIndraTrueForm") then
				why("Indra chưa mở (" .. key .. ")")
				return false
			end
			if need == "tiki" and not getgenv().IsTikiBossKilled() then
				why("boss Tiki chưa mở (" .. key .. "), raw=" .. tostring(getgenv().TikiBossRaw))
				return false
			end
		end

		-- check quang duong (ap dung ca route hub lan route tau ngam): khong ngan hon bay thang thi bo, bay thang toi dich
		do
			local direct = (pos - targetPos).Magnitude
			local viaFly = routeFlyDist(pos, hops, targetPos, island)
			local steps = #hops + (island and 1 or 0) -- tau ngam them 1 buoc InitiateTeleport
			local overheadSec = steps * (tonumber(getgenv().Sea3HopOverheadSec) or 0)
			if not getgenv().ShortcutWorth(direct, viaFly, overheadSec) then
				why(string.format("route %s dai hon bay thang (qua tele: bay %.0f + cho %.0fs >= thang %.0f) -> bay thang", table.concat(hops, " | "), viaFly, overheadSec, direct))
				return false
			end
			dbg(string.format("di duong tat loi hon: bay %.0f + cho %.0fs < thang %.0f", viaFly, overheadSec, direct))
		end

		running, cancelled = true, false
		getgenv().noclip = true
		local allOk = true
		for _, key in ipairs(hops) do
			local ok, res = pcall(runHop, HOP[key])
			if not (ok and res) then
				allOk = false
				break
			end
		end
		running = false

		dbg("kết quả chuỗi:", allOk)
		if allOk then
			fails = 0
		else
			fails = fails + 1
			if fails >= 2 then
				fails = 0
				cool = tick() + 30 -- fail 2 lần liên tiếp: nghỉ 30s để toTarget bay bình thường
			end
		end
		return true
	end
end

-- ===== CLICK VÀO TOẠ ĐỘ WORLD (phá tree Tyrant bằng Skull Guitar, thay cho SpamGunSkullGuitar bị game fix) =====
do
	local st = { pos = nil, tick = 0, running = false }

	-- đổi toạ độ world của tree -> toạ độ trên màn hình; nếu tree ngoài màn hình thì quay camera về phía tree
	local function screenOf(pos)
		local cam = workspace.CurrentCamera
		local v = cam:WorldToViewportPoint(pos)
		local vp = cam.ViewportSize
		if v.Z <= 0 or v.X < 0 or v.Y < 0 or v.X > vp.X or v.Y > vp.Y then
			cam.CFrame = CFrame.lookAt(cam.CFrame.Position, pos)
			v = cam:WorldToViewportPoint(pos)
		end
		local x = math.clamp(v.X, 1, vp.X - 1)
		local y = math.clamp(v.Y, 1, vp.Y - 1)
		if getgenv().ClickUseInset then
			y = y + game:GetService("GuiService"):GetGuiInset().Y
		end
		return x, y
	end

	-- gọi mỗi tick khi đang đứng gần tree: mỗi 0.7s mới click 1 lần (không click liên tục) vào vị trí tree trên màn hình
	getgenv().ClickWorldPos = function(pos)
		local now = tick()
		if now - (st.last or 0) < (getgenv().TreeClickInterval or 0.7) then
			return
		end
		st.last = now
		local x, y = screenOf(pos)
		if getgenv().DebugTreeClick then
			print("[TreeClick]", math.floor(x), math.floor(y))
		end
		local vim = game:GetService("VirtualInputManager")
		vim:SendMouseButtonEvent(x, y, 0, true, game, 1)
		vim:SendMouseButtonEvent(x, y, 0, false, game, 1)
	end
end

-- ===== VÀO TEMPLE OF TIME (game fix vào từ xa: phải bay tới npc rồi mới chạy code vào đền) =====
do
	local NPC = Vector3.new(3033, 2281, -7324)
	local running = false

	local function alive()
		k.LastCall = tick() -- chống watchdog CancelCurrent khi chạy blocking
		getgenv().noclip = true
		I()
	end

	local function hold(t)
		local t0 = tick()
		while tick() - t0 < t do
			alive()
			task.wait(0.1)
		end
	end

	local function dbg(...)
		if getgenv().DebugTemple then
			print("[Temple]", ...)
		end
	end

	-- entry = toạ độ vào đền (Temple Clock) lấy từ bảng entrance trong toTarget
	getgenv().EnterTempleOfTime = function(entry)
		if running then
			return
		end
		running = true
		pcall(function()
			-- 1) fly tới npc
			local t0, arrived = tick(), false
			while tick() - t0 < 120 do
				local hrp = getHRP()
				if not hrp then
					return
				end
				if (hrp.Position - NPC).Magnitude < 15 then
					arrived = true
					break
				end
				alive()
				B(hrp, CFrame.new(NPC), tonumber(Settings["Speed Tween "]) or 300, 8)
				task.wait(0.15)
			end
			if not arrived then
				dbg("không bay tới được npc")
				return
			end
			-- 2) load map đền (mượn model từ MapStash) -> delay 0.6 -> RaceV4Progress Teleport -> delay 0.6
			BorrowTempleOfTime()
			hold(0.6)
			local inside = false
			for attempt = 1, 3 do
				BorrowTempleOfTime() -- no-op nếu model đã được mượn
				I()
				local ok, res = pcall(function()
					return game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Teleport")
				end)
				dbg("RaceV4Progress Teleport lần", attempt, "ok=", ok, "res=", typeof(res), tostring(res))
				hold(0.6)
				local cur = getHRP()
				if cur and (cur.Position - entry).Magnitude < 3000 then
					inside = true
					break
				end
			end
			if not inside then
				dbg("RaceV4Progress Teleport không đưa được vào đền")
				return
			end
			-- 3) Y + 30 -> đích (toTarget các lượt sau bay tiếp)
			local hrp = getHRP()
			if hrp then
				hrp.CFrame = hrp.CFrame + Vector3.new(0, 30, 0)
			end
			dbg("đã vào đền")
		end)
		running = false
	end
end

-- ===== CHECK UNLOCK LIVE (GetUnlockables) =====
do
	local cache, last = {}, {}
	getgenv().IsUnlocked = function(flag)
		if cache[flag] then
			return true
		end
		if tick() - (last[flag] or 0) < 10 then
			return false
		end
		last[flag] = tick()
		local ok, res = pcall(function()
			return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables")
		end)
		if getgenv().DebugUnlock then
			print("[Unlock]", flag, ok, typeof(res), type(res) == "table" and tostring(res[flag]) or "-")
		end
		if ok and type(res) == "table" and res[flag] then
			cache[flag] = true
		end
		return cache[flag] == true
	end
end

-- ===== CHECK ĐÃ ĐÁNH BOSS TIKI (mở SubmarineWorkerSpeak) =====
do
	local cache, lastAsk = false, 0
	getgenv().IsTikiBossKilled = function()
		if cache then
			return true
		end
		if tick() - lastAsk < 5 then
			return false
		end
		lastAsk = tick()
		local ok, res = pcall(function()
			local ev = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak")
			return ev and ev:InvokeServer("AskKilledTikiBoss")
		end)
		getgenv().TikiBossRaw = res -- giá trị server trả về, dùng để kiểm tra
		if getgenv().DebugTikiBoss then
			print("[TikiBoss]", ok, typeof(res), tostring(res))
		end
		if ok and res == true then
			cache = true
		end
		return cache
	end
end

function toTarget(P, e)
	LPH_ATTRIBUTES(VM(NONE))
	if typeof(P) ~= "CFrame" then
		return
	end
	local Y = t.Character
	if not Y or not Y:FindFirstChild("HumanoidRootPart") then
		return
	end
	local H, Z = Y.HumanoidRootPart, Y:FindFirstChildOfClass("Humanoid")
	if not Z then
		return
	end
	k.LastCall = tick()
	if Z and Z.Sit then
		TweenManager.CancelCurrent()
		task.wait(0.1)
		getgenv().noclip = false
		d:SendKeyEvent(true, "Space", false, game)
		task.wait()
		d:SendKeyEvent(false, "Space", false, game)
		task.wait(0.1)
		if H:FindFirstChild("EffectsSY") then
			H.EffectsSY:Destroy()
		end
		Z.Jump = true
		task.wait(0.1)
		H.CFrame = H.CFrame * CFrame.new(0, 10, 0)
		return
	end
	if not H:FindFirstChild("FloatForce") then
		y(H)
	end
	-- Dodge skill Cake Prince (CHI Cake Prince): khong tween nua, teleport thang toi boss + (0, -50, 0)
	do
		local cpMob = getgenv().DodgeCakePrinceMob
		if ReadyToDodge and cpMob and cpMob.Parent and cpMob:FindFirstChild("HumanoidRootPart") then
			TweenManager.CancelTweenOnly()
			I()
			H.CFrame = cpMob.HumanoidRootPart.CFrame * CFrame.new(0, -30, 0)
			return
		end
	end
	Y = (P.Position - H.Position).Magnitude
	if Settings["Teleport Y"] then
		local d, y = Settings["% Health Player"] or 40, Z.Health / Z.MaxHealth
		local C = d / 100
		if y < C then
			G = true
		else
			d = Z.Health / Z.MaxHealth
			if d > 0.8 then
				G = false
			end
		end
	end
	if Y < (e and 8 or 150) and not G and not ReadyToDodge then
		TweenManager.CancelTweenOnly()
		I()
		H.CFrame = P
		return
	end
	if game.PlaceId ~= 122478697296975 then
		e = CFrame.new(28609.392578125, 14896.533203125, 106.4216537475586)
		if
			game.PlaceId == getgenv().CheckPlaceId
			and (P.Position - e.Position).Magnitude > 3000
			and (e.Position - H.Position).Magnitude <= 3000
		then
			B(H, e, 400, 8)
			if (e.Position - H.Position).Magnitude < 8 then
				game:GetService("ReplicatedStorage")
					:WaitForChild("Remotes")
					:WaitForChild("CommF_")
					:InvokeServer("RaceV4Progress", "Check")
				game:GetService("ReplicatedStorage")
					:WaitForChild("Remotes")
					:WaitForChild("CommF_")
					:InvokeServer("RaceV4Progress", "TeleportBack")
				TweenManager.CancelCurrent()
			end
			return
		end
		Z = Vector3.new(11538.599609375, -2154.7021484375, 9827.3125)
		if
			game.PlaceId == getgenv().CheckPlaceId
			and (P.Position - Z).Magnitude <= 3000
			and (Z - H.Position).Magnitude > 3000
			and getgenv().IsTikiBossKilled()
		then
			local d = CFrame.new(
				-16269.4082,
				23.9799957,
				1371.66235,
				-0.999388933,
				0,
				-0.0349550731,
				0,
				1,
				0,
				0.0349550731,
				0,
				-0.999388933
			)
			B(H, d, 350, 8)
			if (d.Position - H.Position).Magnitude < 8 then
				game:GetService("ReplicatedStorage").Modules.Net
					:FindFirstChild("RF/SubmarineWorkerSpeak")
					:InvokeServer(unpack({ [1] = "TravelToSubmergedIsland" }))
				game:GetService("ReplicatedStorage").Remotes.CommF_
					:InvokeServer(unpack({ [1] = "SetLastSpawnPoint", [2] = "SubmergedIsland" }))
				TweenManager.CancelCurrent()
			end
			return
		end
		if
			game.PlaceId == getgenv().CheckPlaceId
			and (P.Position - Z).Magnitude > 3000
			and (Z - H.Position).Magnitude <= 3000
		then
			local d = CFrame.new(
				11427.9189,
				-2156.36401,
				9726.24023,
				-0.929097056,
				-7.17796156E-34,
				0.369835705,
				-7.17796156E-34,
				1,
				1.37611875E-34,
				-0.369835705,
				-1.37611875E-34,
				-0.929097056
			)
			B(H, d, 350, 8)
			if (d.Position - H.Position).Magnitude < 8 then
				local subIsland = getgenv().SubmarineDest(P.Position)
				if subIsland then
					task.wait(0.6)
				end
				game:GetService("ReplicatedStorage").Modules.Net
					:FindFirstChild("RF/SubmarineTransportation")
					:InvokeServer(unpack({ [1] = "GetAvailableLocations" }))
				game:GetService("ReplicatedStorage").Modules.Net
					:FindFirstChild("RF/SubmarineTransportation")
					:InvokeServer(unpack({ [1] = "InitiateTeleport", [2] = subIsland or "Tiki Outpost" }))
				if subIsland then
					task.wait(0.6)
				end
				TweenManager.CancelCurrent()
			end
			return
		end
		if Settings["Use Portal Teleport"] then
			local d = t.Character:FindFirstChild("Portal-Portal") or (t.Backpack:FindFirstChild("Portal-Portal"))
			if d and d.Level.Value > 200 and (_()) then
				for d, _ in pairs(l[game.Workspace:GetAttribute("MAP")] or {}) do
					if
						(P.Position - _).Magnitude <= 3000
						and Y >= 3000
						and (not getgenv().ShortcutWorth or getgenv().ShortcutWorth(Y, (P.Position - _).Magnitude, tonumber(getgenv().PortalOverheadSec) or 0))
					then
						getgenv().noclip = true
						if o(d) then
							local l = tick() + 5
							repeat
								task.wait(0.2)
							until t.Character and (t.Character.HumanoidRootPart.Position - _).Magnitude < 500
								or tick() > l
							return
						end
					end
				end
			end
		end
		if game.PlaceId == getgenv().CheckPlaceId3 and getgenv().Sea1Gate.Step(H, P.Position) then
			return
		end
		if game.PlaceId == getgenv().CheckPlaceId2 and getgenv().Sea2Gate.Step(H, P.Position) then
			return
		end
		if game.PlaceId == getgenv().CheckPlaceId and getgenv().Sea3Gate.Step(H, P.Position) then
			return
		end
		local l, d, _
		if Y >= 3000 and game.PlaceId ~= getgenv().CheckPlaceId3 and game.PlaceId ~= getgenv().CheckPlaceId2 then
			for o, y in pairs(Q) do
				local Q = (P.Position - y).Magnitude
				if
					Q <= 3000
					and (not _ or Q < _)
					and (o == "Temple Clock" or not getgenv().ShortcutWorth or getgenv().ShortcutWorth(Y, Q, tonumber(getgenv().EntranceOverheadSec) or 0))
					and not (
						game.PlaceId == getgenv().CheckPlaceId
						and (o == "Caslte On The Sea" or o == "Hydra" or o == "Mansion")
					)
				then
					_, l, d = Q, o, y
				end
			end
		end
		if d then
			getgenv().noclip = true
			if l == "Temple Clock" then
				getgenv().EnterTempleOfTime(d)
				return
			end
			I()
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", d)
			task.wait(0.1)
			return
		end
		local Q, I, o, y = N(H.Position), N(P.Position), V(P.Position), V(H.Position)
		if I and I.Name == "Celestial Domain" and (not Q or Q.Name ~= "Celestial Domain") then
			d = DetectNpcOni()
			if not d or not d:FindFirstChild("HumanoidRootPart") then
				return
			end
			_ = d.HumanoidRootPart.CFrame * CFrame.new(0, 0, 20)
			B(H, _, 350, 12)
			if (_.Position - H.Position).Magnitude < 300 then
				game:GetService("ReplicatedStorage").Modules.Net
					:WaitForChild("RF/CelestialDomainTransportation")
					:InvokeServer("InitiateTeleportToTemple")
				CelestialDomainController:LoadMap()
				TweenManager.CancelCurrent()
				task.wait(1)
			end
			return
		end
		if o and (o.Name == "Celestial Domain (Interior)" or o.Name == "Celestial Domain <Interior>") then
			if Q and Q.Name == "Celestial Domain" then
				game:GetService("ReplicatedStorage").Modules.Net
					:WaitForChild("RF/CelestialDomainTransportation")
					:InvokeServer("InitiateTeleportToInterior")
				TweenManager.CancelCurrent()
				task.wait(1)
				return
			end
			l = y and (y.Name == "Celestial Domain (Interior)" or y.Name == "Celestial Domain <Interior>")
			if not Q or Q.Name ~= "Celestial Domain" and not l then
				_ = DetectNpcOni()
				if not _ or not _:FindFirstChild("HumanoidRootPart") then
					return
				end
				d = _.HumanoidRootPart.CFrame * CFrame.new(0, 0, 20)
				B(H, d, 350, 12)
				if (d.Position - H.Position).Magnitude < 300 then
					game:GetService("ReplicatedStorage").Modules.Net
						:WaitForChild("RF/CelestialDomainTransportation")
						:InvokeServer("InitiateTeleportToTemple")
					CelestialDomainController:LoadMap()
					TweenManager.CancelCurrent()
					task.wait(1)
					game:GetService("ReplicatedStorage").Modules.Net
						:WaitForChild("RF/CelestialDomainTransportation")
						:InvokeServer("InitiateTeleportToInterior")
				end
				return
			end
		end
		if
			y
			and (y.Name == "Celestial Domain (Interior)" or y.Name == "Celestial Domain <Interior>")
			and (not o or o.Name ~= "Celestial Domain (Interior)" and o.Name ~= "Celestial Domain <Interior>")
		then
			game:GetService("ReplicatedStorage").Modules.Net
				:WaitForChild("RF/CelestialDomainTransportation")
				:InvokeServer("Leave")
			TweenManager.CancelCurrent()
			task.wait(1)
			return
		end
		if Q and Q.Name == "Celestial Domain" and (not I or I.Name ~= "Celestial Domain") then
			game:GetService("ReplicatedStorage").Modules.Net
				:WaitForChild("RF/CelestialDomainTransportation")
				:InvokeServer("Leave")
			TweenManager.CancelCurrent()
			return
		end
		if
			game.PlaceId == getgenv().CheckPlaceId
			and (workspace.Map:FindFirstChild("CakeLoaf"))
			and (workspace.Map.CakeLoaf:FindFirstChild("BigMirror"))
			and (workspace.Map.CakeLoaf.BigMirror:FindFirstChild("Main"))
			and (Vector3.new(-1990.67, 4532.97, -14973.67) - P.Position).Magnitude <= 1000
			and (Vector3.new(-1990.67, 4532.97, -14973.67) - H.Position).Magnitude > 1000
		then
			B(H, workspace.Map.CakeLoaf.BigMirror.Main.CFrame, 400, 8)
			return
		end
	end
	if ShouldResetTeleportSmart(P) then
		if BypassTp.TweenBypass(P) then
			return
		end
	end
	if H.Position.Y < -60 and H.Position.Y > -100 then
		H.CFrame = H.CFrame * CFrame.new(0, 20, 0)
	end
	Z = CFrame.new()
	Z = (function() if ReadyToDodge then return (CFrame.new(0, 200, 0)) else return (function() if G then return (CFrame.new(0, Settings["Distance Teleport Y"] or 800, 0)) else return Z end end)() end end)()
	Y, e = Settings["Speed Tween "] or 300, P * Z
	if (e.Position - H.Position).Magnitude < 3 and not ReadyToDodge and not G then
		TweenManager.CancelTweenOnly()
		H.CFrame = e
		return
	end
	B(H, e, Y)
end
getgenv().BackupTween = toTarget
spawn(function()
	while wait(0.25) do
		local G, G = pcall(function()
			if g["Teleport To Island"] then
				for l, Q in next, E, nil do
					if l == g["Select Island"] then
						toTarget(Q)
					end
				end
			end
			if g["Teleport To Npc"] then
				for E, E in next, m, nil do
					if E.Name == g["Select Npc"] then
						toTarget(E.HumanoidRootPart.CFrame)
					end
				end
			end
			if g["Teleport Mirage"] then
				if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
					local m = DetectNpc("Advanced Fruit Dealer")
					if m then
						toTarget(m.HumanoidRootPart.CFrame)
						return
					end
				end
			end
			if g["Teleport Prehistoric Island"] then
				if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
					local g = DetectNpc("Fossil Expert")
					if g then
						toTarget(g.HumanoidRootPart.CFrame)
						return
					end
				end
			end
			if Settings["Auto rejoin Disconnect"] then
				-- ErrorPrompt chi ton tai khi bi disconnect -> phai check truoc, khong thi bao loi lien tuc
				local pg = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
				local ov = pg and pg:FindFirstChild("promptOverlay")
				local ep = ov and ov:FindFirstChild("ErrorPrompt")
				if ep then
					local msg = ep:FindFirstChild("MessageArea", true)
					msg = msg and msg:FindFirstChild("ErrorMessage", true)
					local txt = msg and msg.Text or ""
					if not string.find(txt, "Teleport") then
						game:GetService("TeleportService")
							:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
					end
				end
			end
		end)
		if G then
			print(G)
		end
	end
end)
function equiptool(g)
	if g and (t:FindFirstChild("Backpack")) and (t.Backpack:FindFirstChild(g)) and not t.Character.Humanoid.Sit then
		t.Character.Humanoid:EquipTool(t.Backpack:FindFirstChild(g))
	end
end
function HoldDelay(key, toolName)
	local tool = t.Character and t.Character:FindFirstChild(toolName)
	local tip = tool and tool:IsA("Tool") and tool.ToolTip or ""
	return tonumber(Settings["Skill " .. tostring(key) .. " " .. tostring(tip)]) or 0.5
end
function NameWeapon(g, G)
	local function m(E)
		local l, Q, d = next, E:GetChildren()
		for E, E in l, Q, d do
			if E:IsA("Tool") and E.ToolTip == g then
				return G and E or E.Name
			end
		end
	end
	return m(t.Backpack) or (m(t.Character))
end
local g, G, m, E =
	require(game:GetService("ReplicatedStorage").Mouse),
	require(game:GetService("ReplicatedStorage").Modules.CombatUtil),
	require(game:GetService("ReplicatedStorage").Modules.Net),
	game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterAttack")
local l = m:RemoteEvent("RegisterHit", true)
local function m(Q, d, I)
	local _ = {}
	for o, o in pairs(Q:GetChildren()) do
		if o:IsA("BasePart") and (o.Position - d).Magnitude <= I then
			table.insert(_, o)
		end
	end
	return _
end
local function Q(d)
	local I = {}
	for _, _ in pairs(game:GetService("Workspace"):WaitForChild("Enemies"):GetChildren()) do
		table.insert(I, _)
	end
	if d then
		for d, d in pairs(game:GetService("Workspace"):WaitForChild("Characters"):GetChildren()) do
			table.insert(I, d)
		end
	end
	return I
end
getgenv().getBladeHits = function(d, I, _, o)
	local V = {}
	for N, y in pairs(Q(o)) do
		if y:IsDescendantOf(Workspace) and y ~= d and (y:FindFirstChild("HumanoidRootPart")) then
			local Q, d = y.HumanoidRootPart, S:GetPlayerFromCharacter(y) and _ / 1.5 or _
			N = { Q.Position }
			if Q.Size.Y > 5 then
				table.insert(N, (Q.CFrame * CFrame.new(0, -Q.Size.Y * 1.5 + 3, 0)).Position)
			end
			for _, _ in pairs(N) do
				if (_ - I[1].Position).Magnitude < 10 + d + Q.Size.X / 2 then
					for _, _ in pairs(m(y, I[1].Position, d + Q.Size.X / 2)) do
						table.insert(V, _)
					end
					break
				end
			end
		end
	end
	return V
end
local m = {
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
function AttackAOE(Q, d)
	local I, _, o, V, N = {}, {}, getgenv().getBladeHits, t.Character, { t.Character.HumanoidRootPart }
	for y, P in o(V, N, Q or 80, d) do
		y = G:GetRigOfHitPart(P)
		if y and not _[y] and m[P.Name] and (G:IsVulnerable(y)) then
			local m, Q = y:FindFirstChild("Summoner"), t.Character:FindFirstChild("Summoner")
			if
				y ~= t.Character
				and (not Q or y ~= Q.Value.Character)
				and (
					not S:GetPlayerFromCharacter(t.Character)
					or not m
					or m.Value ~= S:GetPlayerFromCharacter(t.Character)
				)
			then
				table.insert(I, { y, P })
				_[y] = true
			end
		end
	end
	return #I > 0 and I or nil
end
v_u_27 = 0
v_u_28 = false
v_u_33 = false
v_u_31 = nil
v_u_32 = 0
v_u_21 = 0
v_u_16 = 1
CameraShakerMain = require(game:GetService("ReplicatedStorage").Util.CameraShaker.Main)
CameraShaker = require(game:GetService("ReplicatedStorage").Util.CameraShaker)
function attackMelee(m)
	local Q = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
	if not Q then
		return
	end
	local d = AttackAOE(m, false)
	if not d then
		return
	end
	m = game.Players.LocalPlayer.Character.Humanoid
	local I = m and m.RootPart
	I = I and I.Parent
	local _ = G:GetMovesetAnimCache(m)
	if _ then
		m = G:GetWeaponName(Q)
		local Q = G:GetWeaponData(m)
		local o, V = Q.WeaponType, Q.Moveset
		if G:CanAttack(I, o) then
			v_u_33 = true
			v_u_32 = 5
			v_u_21 = os.clock()
			v_u_27 = v_u_27 + (1)
			if v_u_27 > #V.Basic then
				v_u_27 = 1
			end
			Q = _[G:GetPureWeaponName(m) .. "-basic" .. v_u_27]
			E:FireServer(Q.Length / (Q:GetAttribute("SpeedMult") or 1))
			l:FireServer(table.remove(d, 1)[2], d)
			Q:Play(0.100000001, 1, 1 * (Q:GetAttribute("SpeedMult") or 1))
			v_u_28 = true
			task.delay(Q.Length / (Q:GetAttribute("SpeedMult") or 1) * v_u_16, function()
				v_u_28 = false
			end)
			v_u_31 = Q
			table.clear(d)
		end
	end
end
AttackFunction = function(G)
	LPH_ATTRIBUTES(VM(NONE))
	if t.Character.Stun.Value ~= 0 then
		return
	end
	if not Settings["Attack No Animation "] then
		attackMelee(G)
	else
		local m = AttackAOE(G, false)
		if not m then
			return
		end
		E:FireServer(0)
		l:FireServer(table.remove(m, 1)[2], m)
		table.clear(m)
	end
end
getgenv().AttackFunctionnhungSuperTrial = function()
	LPH_ATTRIBUTES(VM(NONE))
	if t.Character.Stun.Value ~= 0 then
		return
	end
	local G = AttackAOE(80, true)
	if not G then
		return
	end
	E:FireServer(0)
	l:FireServer(table.remove(G, 1)[2], G)
	table.clear(G)
end
getgenv().AttackFunctionnhungSuper = getgenv().AttackFunctionnhungSuperTrial
local G = require(game:GetService("ReplicatedStorage").Mouse)
v_u_50 = nil
v_u_51 = 1
v_u_52 = time
v_u_53 = v_u_52()
local function m(E, l, Q)
	local d = t.Character
	local I = d and (d.PrimaryPart or (d:FindFirstChild("HumanoidRootPart")))
	if not I or not E then
		return false
	end
	local _ = Q and E.Position or E.PrimaryPart and E.PrimaryPart.Position
	if not _ then
		return false
	end
	local o, V, N =
		(_ - I.Position).Unit, ((g.Hit.Position - I.Position) * Vector3.new(1, 0, 1)).Unit, NameWeapon("Blox Fruit")
	I = N and (d:FindFirstChild(N))
	if not I then
		return false
	end
	d, E, Q = I:FindFirstChild("LeftClickRemote"), I:FindFirstChild("RemoteFunction"), I:FindFirstChild("RemoteEvent")
	if not d and E then
		if Q then
			Q:FireServer(_)
		end
		E:InvokeServer("TAP")
		return true
	end
	if d and N == "Mammoth-Mammoth" then
		d:FireServer(_)
		return true
	end
	if d then
		v_u_51 = v_u_51 + (1)
		if v_u_51 > 5 then
			v_u_51 = 1
		end
		d:FireServer(o, v_u_51)
		if l then
			d:FireServer(V, v_u_51)
		end
		return true
	end
	return false
end
getgenv().UseFruitM1 = function(g, E)
	return m(g, E, false)
end
getgenv().UseFruitM1Boat = function(g, E)
	return m(g, E, true)
end
getgenv().PathClickM1 = {}
local function g(m)
	m.ChildAdded:Connect(function(m)
		if m:IsA("Tool") then
			task.wait(0.5)
			local E = m:FindFirstChild("RemoteFunction")
			if E then
				getgenv().PathClickM1[m.Name] = E
			end
		end
	end)
end
if t.Character then
	g(t.Character)
end
t.CharacterAdded:Connect(g)
local function m(E)
	return t.Character
		and (t.Character:FindFirstChild("HumanoidRootPart"))
		and E
		and (E:FindFirstChild("HumanoidRootPart"))
		and E.Humanoid.Health > 0
		and (t.Character.HumanoidRootPart.Position - E.HumanoidRootPart.Position).Magnitude < 70
end
getgenv().ClickM1 = function(E, l)
	if not m(E) then
		return
	end
	if Settings["Select Weapon"] == "Blox Fruit" then
		if getgenv().UseFruitM1(E) then
			return
		end
	end
	AttackFunction(l and 80 or 30)
end
getgenv().ClickM1Dungeon = function(E, l)
	if not m(E) then
		return
	end
	if Settings["Select Weapon Dungeon"] == "Blox Fruit" then
		if getgenv().UseFruitM1(E) then
			return
		end
	end
	AttackFunction(l and 80 or 30)
end
getgenv().ClickM1Volcano = function(E, l)
	if not m(E) then
		return
	end
	if Settings["Select Weapon Kill Golem"] and Settings["Select Weapon Kill Golem"] == "Blox Fruit" then
		if getgenv().UseFruitM1(E) then
			return
		end
	end
	AttackFunction(l and 80 or 30)
end
local m = L:WaitForChild("Modules")
getgenv().SpamGunDragonStorm = function(E)
	-- farm ship với Use Dragonstorm For Sea Event: giả lập click vào model thuyền, 0.4s click 1 lần
	if E and E.Name == "Engine" and Settings["Use Dragonstorm For Sea Event"] and getgenv().ClickModelDS then
		getgenv().ClickModelDS(E.Parent, 0.4)
	end
	local l, Q = require(m.CombatUtil), t.Character
	local d = Q and (Q:FindFirstChild("Dragonstorm"))
	if not d or (l:IsGunReloading(d)) then
		return
	end
	l = getupvalues(require(L.Controllers.CombatController).Attack)[9]
	local I, _, o, V, N, y, P =
		debug.getupvalue(l, 15),
		debug.getupvalue(l, 13),
		debug.getupvalue(l, 16),
		debug.getupvalue(l, 17),
		debug.getupvalue(l, 14),
		debug.getupvalue(l, 12),
		debug.getupvalue(l, 18)
	Q = y * _
	d = ((N * _ + y * I) % o * o + Q) % V
	N = math.floor(d / o)
	y = d - N * o
	P = P + (1)
	debug.setupvalue(l, 15, I)
	debug.setupvalue(l, 13, _)
	debug.setupvalue(l, 16, o)
	debug.setupvalue(l, 17, V)
	debug.setupvalue(l, 14, N)
	debug.setupvalue(l, 12, y)
	debug.setupvalue(l, 18, P)
	L.Remotes.Validator2:FireServer(math.floor(d / V * 16777215), P)
	m.Net:FindFirstChild("RE/ShootGunEvent"):FireServer(E.Position, { E })
end
-- ===== SHOOTGUN AURA (logic bắn gun lấy từ script fast attack, chỉ giữ phần bắn gun) =====
-- Target: mob, ship (Engine), sea beast, leviathan (Leviathan / Tail / Segment). Không bắn người chơi.
do
	local RS = game:GetService("ReplicatedStorage")
	local VIM = game:GetService("VirtualInputManager")
	local GuiService = game:GetService("GuiService")
	local lp = game:GetService("Players").LocalPlayer

	getgenv().ShootGunRange = getgenv().ShootGunRange or 500
	getgenv().ShootGunDelay = getgenv().ShootGunDelay or 0.02

	local function findNetRemote(name)
		local net = RS:FindFirstChild("Modules") and RS.Modules:FindFirstChild("Net")
		if not net then
			return
		end
		local r = net:FindFirstChild(name)
		if r then
			return r
		end
		for _, v in ipairs(net:GetDescendants()) do
			if v:IsA("RemoteEvent") and v.Name == name then
				return v
			end
		end
	end

	-- trả về part để bắn nếu model còn sống, không thì nil
	local function shootPart(m)
		if not m:IsA("Model") then
			return
		end
		local hum = m:FindFirstChildOfClass("Humanoid")
		if hum then -- mob thường, Terrorshark
			if hum.Health <= 0 then
				return
			end
			return m:FindFirstChild("HumanoidRootPart") or m:FindFirstChild("Head")
		end
		local hv = m:FindFirstChild("Health")
		if hv and hv:IsA("ValueBase") and hv.Value <= 0 then
			return
		end
		local n = m.Name
		if n:find("Leviathan", 1, true) then -- Leviathan / Leviathan Tail / Leviathan Segment
			if n == "Leviathan" and m:GetAttribute("Armored") then
				return
			end
			if n == "Leviathan Tail" and not m:GetAttribute("HealthEnabled") then
				return
			end
			return m:FindFirstChild("Hitbox11") or m:FindFirstChild("HumanoidRootPart") or m.PrimaryPart
		end
		if m:FindFirstChild("Engine") and hv then -- ship
			return m.Engine
		end
		if m:FindFirstChild("HealthBBG") then -- sea beast
			return m:FindFirstChild("HumanoidRootPart")
		end
	end

	-- target gần nhất trong phạm vi shootgun (mặc định 500 studs)
	getgenv().GetShootGunTarget = function(range)
		local char = lp.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if not root then
			return
		end
		local best, bd = nil, range or getgenv().ShootGunRange
		for _, folder in ipairs({ workspace:FindFirstChild("Enemies"), workspace:FindFirstChild("SeaBeasts") }) do
			if folder then
				for _, m in ipairs(folder:GetChildren()) do
					local part = shootPart(m)
					if part then
						local d = (root.Position - part.Position).Magnitude
						if d < bd then
							best, bd = part, d
						end
					end
				end
			end
		end
		return best
	end

	-- bắn 1 phát: chỉ khi đang cầm Dragonstorm
	getgenv().ShootGunDS = function(part)
		if not part then
			return
		end
		local char = lp.Character
		if not (char and char:FindFirstChild("Dragonstorm")) then
			return
		end
		local ev = findNetRemote("RE/ShootGunEvent")
		if ev then
			pcall(function()
				ev:FireServer(part.Position, { part })
			end)
		end
		pcall(function()
			VIM:SendMouseButtonEvent(0, 0, 0, true, game, 1)
			VIM:SendMouseButtonEvent(0, 0, 0, false, game, 1)
		end)
	end

	-- giả lập click lên model (thuyền đang farm), mỗi `interval` giây click 1 lần
	local lastModelClick = 0
	getgenv().ClickModelDS = function(model, interval)
		if not model or tick() - lastModelClick < (interval or 0.4) then
			return
		end
		local part = model:FindFirstChild("Engine") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
		if not part then
			return
		end
		lastModelClick = tick()
		local cam = workspace.CurrentCamera
		local v = cam:WorldToViewportPoint(part.Position)
		local vp = cam.ViewportSize
		if v.Z <= 0 or v.X < 0 or v.Y < 0 or v.X > vp.X or v.Y > vp.Y then
			cam.CFrame = CFrame.lookAt(cam.CFrame.Position, part.Position)
			v = cam:WorldToViewportPoint(part.Position)
		end
		local x, y = math.clamp(v.X, 1, vp.X - 1), math.clamp(v.Y, 1, vp.Y - 1)
		if getgenv().ClickUseInset then
			y = y + GuiService:GetGuiInset().Y
		end
		VIM:SendMouseButtonEvent(x, y, 0, true, game, 1)
		VIM:SendMouseButtonEvent(x, y, 0, false, game, 1)
	end
end
function ShootM1(E)
	spawn(function()
		if
			not require(game:GetService("ReplicatedStorage").Modules.CombatUtil):IsGunReloading(
				t.Character[NameWeapon("Gun")]
			)
		then
			if NameWeapon("Gun") ~= "Skull Guitar" then
				local l =
					getupvalues(require(game:GetService("ReplicatedStorage").Controllers.CombatController).Attack)[9]
				local Q, d, I, _, o, V, N =
					debug.getupvalue(l, 15),
					debug.getupvalue(l, 13),
					debug.getupvalue(l, 16),
					debug.getupvalue(l, 17),
					debug.getupvalue(l, 14),
					debug.getupvalue(l, 12),
					debug.getupvalue(l, 18)
				local y = V * d
				local P = ((o * d + V * Q) % I * I + y) % _
				o = math.floor(P / I)
				V = P - o * I
				N = N + (1)
				debug.setupvalue(l, 15, Q)
				debug.setupvalue(l, 13, d)
				debug.setupvalue(l, 16, I)
				debug.setupvalue(l, 17, _)
				debug.setupvalue(l, 14, o)
				debug.setupvalue(l, 12, V)
				debug.setupvalue(l, 18, N)
				game.ReplicatedStorage.Remotes.Validator2:FireServer(math.floor(P / _ * 16777215), N)
				if NameWeapon("Gun") == "Cannon" then
					game:GetService("ReplicatedStorage").Modules.Net
						:FindFirstChild("RE/ShootGunEvent")
						:FireServer(unpack({ [1] = E }))
				else
					_ = { [1] = E.HumanoidRootPart.Position, [2] = { [1] = E.HumanoidRootPart } }
					game:GetService("ReplicatedStorage").Modules.Net
						:FindFirstChild("RE/ShootGunEvent")
						:FireServer(unpack(_))
				end
				task.wait(t.Character[NameWeapon("Gun")].Cooldown.Value)
			else
				local l = { [1] = "TAP", [2] = E.HumanoidRootPart.Position }
				game:GetService("Players").LocalPlayer.Character
					:FindFirstChild("Skull Guitar").RemoteEvent
					:FireServer(unpack(l))
				task.wait(t.Character[NameWeapon("Gun")].Cooldown.Value)
			end
		end
	end)
end
getgenv().SpamGunSkullGuitar = function(E)
	local l, Q = require(m.CombatUtil), t.Character
	local m = Q and (Q:FindFirstChild("Skull Guitar"))
	if not m or (l:IsGunReloading(m)) then
		return
	end
	m.RemoteEvent:FireServer("TAP", E.Position)
end
local function m(E, l)
	local Q, d, I, _, o, V, N =
		require(game:GetService("ReplicatedStorage").Modules.CombatUtil),
		getgenv().getBladeHits,
		E.Character,
		{ E.Character.HumanoidRootPart },
		1 / 0
	for y, P in d(I, _, l, true) do
		y = Q:GetRigOfHitPart(P)
		if y and (Q:IsVulnerable(y)) then
			local l = (E.Character.HumanoidRootPart.Position - P.Position).Magnitude
			if l < o then
				o, V, N = l, y, P
			end
		end
	end
	if V and N then
		return { V, N }
	end
	return nil
end
function DetectItemPlr(E)
	if t.Character:FindFirstChild(E) or (t.Backpack:FindFirstChild(E)) then
		return true
	end
end
function sizepart(E)
	AttackingMob = E
	if not E or not E.Parent or not E:FindFirstChild("HumanoidRootPart") then
		return
	end
	if t:DistanceFromCharacter(E.HumanoidRootPart.Position) <= 50 then
		local l, Q, d = next, E:GetDescendants()
		for E, E in l, Q, d do
			if (E:IsA("Part") or (E:IsA("MeshPart"))) and E.CanCollide then
				E.CanCollide = false
			end
		end
	end
end
local E, l
function DeleteIgnoredMob()
	for Q, Q in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
		if Q:IsA("Model") and (Q:FindFirstChild("Ignored")) then
			Q.Ignored:Destroy()
		end
	end
end
function DetectMob(Q)
	local d, I = 1 / 0
	for _, o in pairs(game.Workspace.Enemies:GetChildren()) do
		if (typeof(Q) == "table" and (table.find(Q, o.Name)) or o.Name == Q) and (IsMobAlive(o)) then
			_ = (
				o.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
			).magnitude
			if _ < d then
				d, I = _, o
			end
		end
	end
	return I
end
function CheckNameBoss(Q)
	local d, I, _ = next, game.ReplicatedStorage:GetChildren()
	for o, o in d, I, _ do
		if (typeof(Q) == "table" and (table.find(Q, o.Name)) or o.Name == Q) and (IsMobAlive(o)) then
			return o
		end
	end
	d, _, I = next, game.Workspace.Enemies:GetChildren()
	for o, o in d, _, I do
		if (typeof(Q) == "table" and (table.find(Q, o.Name)) or o.Name == Q) and (IsMobAlive(o)) then
			return o
		end
	end
end
getgenv().TableMobSpawn = {}
spawn(function()
	for Q, Q in pairs(getnilinstances()) do
		if
			(function() if Q:GetAttribute("DisplayName") and (string.find(Q:GetAttribute("DisplayName"), "Lv.")) then return (Q:GetAttribute("DisplayName"):gsub(" %pLv. %d+%p", "")) else return nil end end)()
		then
			table.insert(TableMobSpawn, Q)
		end
	end
	for Q, Q in pairs(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()) do
		if
			(function() if Q:GetAttribute("DisplayName") and (string.find(Q:GetAttribute("DisplayName"), "Lv.")) then return (Q:GetAttribute("DisplayName"):gsub(" %pLv. %d+%p", "")) else return nil end end)()
		then
			table.insert(TableMobSpawn, Q)
		end
	end
end)
function getcenter(Q)
	if string.find(Q, "Lv.") then
		name1 = Q:gsub(" %pLv. %d+%p", "")
	end
	local d
	local I = 0
	for _, o in pairs(TableMobSpawn) do
		_ = (function() if string.find(o.Name, "Lv.") then return (o.Name:gsub(" %pLv. %d+%p", "")) else return nil end end)()
		if o:IsA("Part") and (_ and _ == Q or Q == o.Name or name1 and o.Name == name1) then
			if d == nil then
				d, I = o.Position, I + 1
			else
				d, I = d + o.Position, I + 1
			end
		end
	end
	d = d / (I)
	return CFrame.new(d)
end
function DetectPartMobBring(Q, d, I, _)
	local o, V = {}, (function() if string.find(Q, "Lv.") then return (Q:gsub(" %pLv. %d+%p", "")) else return nil end end)()
	for N, y in pairs(TableMobSpawn) do
		N = (function() if string.find(y.Name, "Lv.") then return (y.Name:gsub(" %pLv. %d+%p", "")) else return nil end end)()
		if y:IsA("Part") and (N and N == Q or Q == y.Name or V and y.Name == V) then
			table.insert(o, y)
		end
	end
	if I then
		Q, V = 1 / 0
		for I, N in next, o, nil do
			I = (d.HumanoidRootPart.Position - N.Position).Magnitude
			if Q > I then
				Q, V = I, N
			end
		end
		return V
	else
		local Q = {}
		for d, d in next, o, nil do
			if (_.Position - d.Position).Magnitude <= 200 then
				table.insert(Q, d)
			end
		end
		if #Q < #o then
			return true
		end
	end
end
function isnetworkowner2(Q)
	local d, I, _ = next, game.Workspace.Characters:GetChildren()
	for o, o in d, I, _ do
		if
			o.Name ~= t.Name
			and (o:FindFirstChild("HumanoidRootPart"))
			and (o.HumanoidRootPart.Position - Q.Position).Magnitude <= 300
		then
			return false
		end
	end
	return true
end
function BringMob(Q)
	if not Settings["Bring Mob"] then
		return
	end
	if Q and E ~= Q then
		local spawnPart = DetectPartMobBring(Q.Name, Q, true)
		if not spawnPart then
			return
		end
		E = Q
		l = spawnPart.CFrame
		local d = game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg"
			and (t.Character:FindFirstChild("RaceTransformed"))
			and t.Character.RaceTransformed.Value
		if d then
			l = getcenter(Q.Name)
		end
		DeleteIgnoredMob()
	end
	if DaBringMob then
		delay(0.1, function()
			getgenv().DaBringMob = false
		end)
		return
	end
	local d = {}
	if not Q:FindFirstChild("Ignored") then
		table.insert(d, Q)
	end
	local I = Settings["Bring Mob Count"] or 2
	local _, o = ((I > 2) and 350 or 200)
	if
		game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg"
		and (t.Character:FindFirstChild("RaceTransformed"))
		and t.Character.RaceTransformed.Value
	then
		_, o = 300, 6
	else
		o = I
	end
	for I, I in pairs(workspace.Enemies:GetChildren()) do
		if
			I ~= Q
			and I.Name == Q.Name
			and not I:FindFirstChild("Ignored")
			and (IsMobAlive(I))
			and (isnetworkowner2(I.HumanoidRootPart))
		then
			if (I.HumanoidRootPart.Position - l.Position).Magnitude <= _ and #d < o then
				table.insert(d, I)
			end
		end
	end
	if
		l
		and (t.Character.HumanoidRootPart.Position - Q.HumanoidRootPart.Position).Magnitude <= 50
		and (isnetworkowner2(t.Character.HumanoidRootPart))
		and #d >= 2
	then
		for Q, Q in pairs(d) do
			sizepart(Q)
			if not isnetworkowner2(Q.HumanoidRootPart) then
				Q.HumanoidRootPart.CFrame = Q.WorldPivot
				Instance.new("IntValue", Q).Name = "Ignored"
				task.wait(0.3)
			else
				Q.HumanoidRootPart.CFrame = l * CFrame.new(0, math.random(0, 2), math.random(0, 2))
				task.spawn(function()
					local d = Q.Humanoid.Health
					task.wait(2.2)
					if Q.Humanoid.Health == d and not Q:FindFirstChild("Ignored") then
						Q.HumanoidRootPart.CFrame = Q.WorldPivot
						Instance.new("IntValue", Q).Name = "Ignored"
						task.wait(0.3)
					end
				end)
			end
			getgenv().DaBringMob = true
		end
	end
end
task.wait(1)
SettingFarmMain = Main.CreatePage({ Page_Name = "Setting Farm", Page_Title = "Setting Farm" })
SettingFarmMainSection = SettingFarmMain.CreateSection("Setting Farm")
local Q, d =
	false,
	SettingFarmMainSection.CreateDropdown(
		{
			Title = "Select Weapon",
			List = { "Melee", "Sword", "Blox Fruit" },
			Search = true,
			Selected = false,
			Default = Settings["Select Weapon"] or nil,
		},
		function(I)
			SaveSettings("Select Weapon", I)
		end
	)
SettingFarmMainSection.CreateToggle(
	{ Title = "Attack No Animation ", Desc = nil, Default = Settings["Attack No Animation "] or true },
	function(I)
		SaveSettings("Attack No Animation ", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{
		Title = "Kill Aura Only Raid And Volcano",
		Desc = nil,
		Default = Settings["Kill Aura Only Raid And Volcano"] or false,
	},
	function(I)
		SaveSettings("Kill Aura Only Raid And Volcano", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{ Title = "Time Delay Kill", Min = 0, Max = 5, Default = Settings["Time Delay Kill"] or 5, Precise = true },
	function(I)
		SaveSettings("Time Delay Kill", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Click", Desc = nil, Default = Settings["Auto Click"] or false },
	function(I)
		if I then
			spawn(function()
				while Settings["Auto Click"] and (task.wait()) do
					local _, _ = pcall(function()
						local o = NameWeapon("Blox Fruit")
						if o and (t.Character:FindFirstChild(o)) then
							local o = AttackAOE(80, true)
							if not o then
								return
							end
							getgenv().UseFruitM1(o[1][1])
						else
							getgenv().AttackFunctionnhungSuperTrial()
						end
					end)
					if _ then
						print(_)
					end
				end
			end)
		end
		SaveSettings("Auto Click", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Kill Aura With DragonStorm", Desc = nil, Default = Settings["Kill Aura With DragonStorm"] or false },
	function(I)
		if I and not getgenv().__DSAuraRunning then
			getgenv().__DSAuraRunning = true
			spawn(function()
				while Settings["Kill Aura With DragonStorm"] and task.wait(getgenv().ShootGunDelay or 0.02) do
					pcall(function()
						-- chỉ chạy khi đang cầm Dragonstorm và có target trong phạm vi shootgun
						if t.Character and t.Character:FindFirstChild("Dragonstorm") then
							local part = getgenv().GetShootGunTarget()
							if part then
								getgenv().ShootGunDS(part)
							end
						end
					end)
				end
				getgenv().__DSAuraRunning = false
			end)
		end
		SaveSettings("Kill Aura With DragonStorm", I)
	end
)
function FFCMatch(m, I)
	for _, _ in pairs(m:GetChildren()) do
		if string.match(_.Name, I) then
			return _
		end
	end
	return nil
end
SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Turn On Buso", Desc = nil, Default = Settings["Auto Turn On Buso"] or true },
	function(m)
		if m then
			spawn(function()
				while Settings["Auto Turn On Buso"] and (wait(1)) do
					pcall(function()
						if not FFCMatch(t.Character, "_BusoLayer1") and not t.Character:FindFirstChild("HasBuso") then
							CommF:InvokeServer("Buso")
							task.wait(2)
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Turn On Buso", m)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Turn On Observation", Desc = nil, Default = Settings["Auto Turn On Observation"] or false },
	function(m)
		if m then
			spawn(function()
				while Settings["Auto Turn On Observation"] and (wait(1)) do
					pcall(function()
						if not game:GetService("Lighting").Blur.Enabled then
							game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
							wait()
							game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
							wait(3)
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Turn On Observation", m)
	end
)
function TurnOnV4()
	local m = t.Character
	local I, _ = m and (m:FindFirstChild("RaceEnergy")), m and (m:FindFirstChild("RaceTransformed"))
	if not I or I.Value < 1 or not _ or _.Value then
		return
	end
	_ = t.Backpack:FindFirstChild("Awakening") or (m:FindFirstChild("Awakening"))
	if _ then
		_.RemoteFunction:InvokeServer(true)
	end
end
local m = SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Turn On V4", Desc = nil, Default = Settings["Auto Turn On V4"] or false },
	function(I)
		if I then
			spawn(function()
				while Settings["Auto Turn On V4"] and (task.wait(1)) do
					pcall(TurnOnV4)
				end
			end)
		end
		SaveSettings("Auto Turn On V4", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Turn On V3", Desc = nil, Default = Settings["Auto Turn On V3"] or false },
	function(I)
		if I then
			spawn(function()
				while Settings["Auto Turn On V3"] and (task.wait(1)) do
					game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
					wait(2)
				end
			end)
		end
		SaveSettings("Auto Turn On V3", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Dodge Skill Mobs", Desc = nil, Default = Settings["Auto Dodge Skill Mobs"] or false },
	function(I)
		SaveSettings("Auto Dodge Skill Mobs", I)
	end
)
game:GetService("Workspace").Enemies.DescendantAdded:Connect(function(descendant)
	local flag = Settings["Auto Dodge Skill Mobs"] and AttackingMob and AttackingMob.Parent and not Doding

	if flag then
		flag = descendant.Name == "BodyGyro" or descendant.Name == "BodyPosition" or descendant.Name == "KiBlastFireShort"
	end

	if flag and descendant.Parent.Parent == AttackingMob then
		Doding = true
		-- chi Cake Prince: luu boss de toTarget teleport toi boss + (0, -30, 0) trong luc ne; mob khac giu nguyen +200 Y
		getgenv().DodgeCakePrinceMob = (AttackingMob.Name == "Cake Prince") and AttackingMob or nil
		ReadyToDodge = true
		local now = tick()

		while true do local __brk = false repeat 
			wait()
			if not (not descendant or not descendant.Parent or tick() - now > 14) then
				break
			end
			__brk = true break
		until true if __brk then break end end

		if tick() - now < 2 then
			wait(0.5)
		end

		Doding = false
		ReadyToDodge = false
		getgenv().DodgeCakePrinceMob = nil
	end
end)
SettingFarmMainSection.CreateToggle(
	{ Title = "Teleport Y if low health", Desc = nil, Default = Settings["Teleport Y"] or false },
	function(I)
		SaveSettings("Teleport Y", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{ Title = "% Health Player", Min = 0, Max = 100, Default = Settings["% Health Player"] or 40, Precise = true },
	function(I)
		SaveSettings("% Health Player", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{
		Title = "Distance Teleport Y",
		Min = 0,
		Max = 10000,
		Default = Settings["Distance Teleport Y"] or 800,
		Precise = true,
	},
	function(I)
		SaveSettings("Distance Teleport Y", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Tween Safe if have Items", Desc = nil, Default = Settings["Tween Safe if have Items"] or false },
	function(I)
		if I then
			spawn(function()
				while Settings["Tween Safe if have Items"] and (wait(0.25)) do
					pcall(function()
						if CheckNameBoss("Darkbeard") and Settings["Attack Darkbeard"] then
							return
						end
						if DetectItemPlr("Fist of Darkness") and Settings["Summon Darkbeard"] then
							return
						end
						if
							(DetectItemPlr("Fist of Darkness") or (DetectItemPlr("God's Chalice")))
							and Settings["Tween Safe if have Items"]
						then
							if game.PlaceId == getgenv().CheckPlaceId2 then
								toTarget(CFrame.new(-385.250916, 73.0458984, 297.388397))
							else
								toTarget(CFrame.new(-12463, 374, -7523))
							end
						end
					end)
				end
			end)
		end
		SaveSettings("Tween Safe if have Items", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{ Title = "Time Hop Server", Min = 0, Max = 60, Default = Settings["Time Hop Server"] or 10, Precise = true },
	function(I)
		SaveSettings("Time Hop Server", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Use Portal Teleport", Desc = nil, Default = Settings["Use Portal Teleport"] or false },
	function(I)
		SaveSettings("Use Portal Teleport", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{ Title = "Bring Mob Count", Min = 2, Max = 6, Default = Settings["Bring Mob Count"] or 2, Precise = true },
	function(I)
		SaveSettings("Bring Mob Count", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Bring Mob", Desc = nil, Default = Settings["Bring Mob"] or true },
	function(I)
		SaveSettings("Bring Mob", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Reset Teleport [ Beta ]", Desc = nil, Default = Settings["Reset Teleport"] or false },
	function(I)
		SaveSettings("Reset Teleport", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Use Submarine Teleport", Desc = nil, Default = Settings["Use Submarine Teleport"] or false },
	function(I)
		SaveSettings("Use Submarine Teleport", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{ Title = "Speed Tween ", Min = 0, Max = 1000, Default = Settings["Speed Tween "] or 300, Precise = true },
	function(I)
		SaveSettings("Speed Tween ", I)
	end
)
SettingFarmMainSection.CreateLabel({
	Title = "Recommended: 350. If you\226\128\153re farming spots close to each other, use a higher speed",
})
SettingSkillMain =
	Main.CreatePage({ Page_Name = "Hold and Select Skill", Page_Title = "Setting Hold and Select Skill" })
SelectSkillsSection = SettingSkillMain.CreateSection("Select Skills")
local function I(_, o)
	local V, N = "Select Skills " .. _, {}
	for y, y in ipairs(o) do
		N[y] = false
	end
	EnsureAllTrueDefaults(V, o)
	_ = PrepareMultiSelectList(N, Settings[V], true)
	SelectSkillsSection.CreateDropdown(
		{ Title = V, List = _, Search = true, Selected = true, Default = Settings[V] or nil },
		function(_, o)
			SaveSettings(V, _, o)
		end
	)
end
I("Melee", { "Z", "X", "C" })
I("Sword", { "Z", "X" })
I("Gun", { "Z", "X" })
I("Blox Fruit", { "Z", "X", "C", "V", "F" })
HoldSkillsSection = SettingSkillMain.CreateSection("Hold Skills")
local function _(o, V)
	local N = {}
	for y, y in ipairs(V) do
		N[y] = {
			Title = y,
			KeyName = y,
			Min = 0,
			Max = 5,
			Default = Settings["Skill " .. y .. " " .. o] or 0.5,
			Precise = true,
		}
	end
	HoldSkillsSection.CreateDropdown({ Title = "Set Delay " .. o, List = N, Slider = true }, function(V, V)
		if V and V.KeyName then
			SaveSettings("Skill " .. V.KeyName .. " " .. o, V.Default)
		end
	end)
end
HoldSkillsSection.CreateToggle(
	{ Title = "Use skill fast dont hold", Desc = nil, Default = Settings["Use skill fast dont hold"] or false },
	function(o)
		SaveSettings("Use skill fast dont hold", o)
	end
)
_("Melee", { "Z", "X", "C" })
_("Sword", { "Z", "X" })
_("Gun", { "Z", "X" })
_("Blox Fruit", { "Z", "X", "C", "V", "F" })
FarmMain = Main.CreatePage({ Page_Name = "Farming", Page_Title = "Farming" })
SettingAutoFarmSection = FarmMain.CreateSection("Setting Farm")
SettingAutoFarmSection.CreateDropdown(
	{
		Title = "Select Method Farm",
		List = { "Level Farm", "Farm Bones", "Farm Katakuri", "Farm Tyrant of the Skies", "Aura Farm" },
		Search = false,
		Selected = false,
		Default = Settings["Select Method Farm"] or nil,
	},
	function(o)
		SaveSettings("Select Method Farm", o)
	end
)
SettingAutoFarmSection.CreateSlider(
	{
		Title = "Distance Farm Aura",
		Min = 0,
		Max = 1000,
		Default = Settings["Distance Farm Aura"] or 300,
		Precise = true,
	},
	function(o)
		SaveSettings("Distance Farm Aura", o)
	end
)
SettingAutoFarmSection.CreateToggle(
	{ Title = "Ignore Attack Katakuri", Desc = nil, Default = Settings["Ignore Attack Katakuri"] or false },
	function(o)
		SaveSettings("Ignore Attack Katakuri", o)
	end
)
SettingAutoFarmSection.CreateToggle(
	{ Title = "Hop Find Katakuri", Desc = nil, Default = Settings["Hop Find Katakuri"] or false },
	function(o)
		SaveSettings("Hop Find Katakuri", o)
	end
)
SettingAutoFarmSection.CreateToggle(
	{
		Title = "Auto Quest [Katakuri/Bone/Tyrant]",
		Desc = nil,
		Default = Settings["Auto Quest [Katakuri/Bone/Tyrant]"] or false,
	},
	function(o)
		SaveSettings("Auto Quest [Katakuri/Bone/Tyrant]", o)
	end
)
local o = SettingAutoFarmSection.CreateToggle(
	{ Title = "Start Farm", Desc = nil, Default = Settings["Start Farm"] or false },
	function(V)
		SaveSettings("Start Farm", V)
	end
)
MasteryFarmSection = FarmMain.CreateSection("Mastery Farm")
MasteryFarmSection.CreateDropdown(
	{
		Title = "Select Method Farm Mastery",
		List = { "Blox Fruit", "Gun" },
		Search = true,
		Selected = false,
		Default = Settings["Select Method Farm Mastery"] or nil,
	},
	function(V)
		SaveSettings("Select Method Farm Mastery", V)
	end
)
MasteryFarmSection.CreateSlider(
	{ Title = "Health %", Min = 0, Max = 100, Default = Settings["Health %"] or 40, Precise = true },
	function(V)
		SaveSettings("Health %", V)
	end
)
MasteryFarmSection.CreateToggle(
	{ Title = "Farm Mastery", Desc = nil, Default = Settings["Farm Mastery"] or false },
	function(V)
		SaveSettings("Farm Mastery", V)
		if V and not Settings["Start Farm"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Start Farm Plz", ShowTime = 5 })
		end
	end
)
FarmingMaterialSection = FarmMain.CreateSection("Farming Material")
FarmingMaterialSection.CreateDropdown(
	{
		Title = "Select Material",
		List = TableMaterials,
		Search = true,
		Selected = false,
		Default = Settings["Select Material"] or nil,
	},
	function(V)
		SaveSettings("Select Material", V)
	end
)
FarmingMaterialSection.CreateToggle(
	{ Title = "Farm Material", Desc = nil, Default = Settings["Farm Material"] or false },
	function(V)
		SaveSettings("Farm Material", V)
		if V and not Settings["Start Farm"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Start Farm Plz", ShowTime = 5 })
		end
	end
)
local V, N, y, P, e, Y =
	{ "BartiloQuest", "Trainees", "MarineQuest", "CitizenQuest" },
	{},
	{ "Baking Staff", "Head Baker", "Cake Guard", "Cookie Crafter" },
	{ "Cocoa Warrior", "Chocolate Bar Battler", "Candy Rebel", "Sweet Thief" },
	{ "Reborn Skeleton", "Demonic Soul", "Living Zombie", "Posessed Mummy" },
	{ "Isle Champion", "Serpent Hunter", "Skull Slayer", "Sun-kissed Warrior" }
getgenv().NameMobQuest = ""
getgenv().NameQuest = ""
getgenv().IDQuest = 0
getgenv().questpoint = {}
local H = require(game.ReplicatedStorage.Quests)
local function B()
	local Z, C = t.Data.Level.Value, 0
	if Z >= 1450 and game.PlaceId == getgenv().CheckPlaceId2 then
		getgenv().NameMobQuest = "Water Fighter"
		getgenv().NameQuest = "ForgottenQuest"
		getgenv().IDQuest = 2
	elseif Z >= 700 and game.PlaceId == getgenv().CheckPlaceId3 then
		getgenv().NameMobQuest = "Galley Captain"
		getgenv().NameQuest = "FountainQuest"
		getgenv().IDQuest = 2
	else
		for J, F in pairs(H) do
			for q, c in pairs(F) do
				if not table.find(V, J) then
					local F = c.LevelReq
					for D, r in pairs(c.Task) do
						if Z >= F and F >= C and r > 1 then
							getgenv().NameMobQuest = D
							getgenv().NameQuest = J
							getgenv().IDQuest = q
							C = F
						end
					end
				end
			end
		end
	end
end
function CountQuest()
	local Z = {}
	for C, C in pairs(H) do
		for J, J in pairs(C) do
			for F, q in pairs(J.Task) do
				if F == getgenv().mobv then
					for J, J in pairs(C) do
						if J.LevelReq <= t.Data.Level.Value and J.Name ~= "Town Raid" then
							for C, F in pairs(J.Task) do
								if F > 1 then
									table.insert(Z, C)
								end
							end
						end
					end
				end
			end
		end
	end
	return Z
end
local Z = require(game.ReplicatedStorage:WaitForChild("GuideModule"))
function DontQuest()
	return Z.Data and Z.Data.QuestData ~= nil
end
function GetNameDoubleQuest()
	if DontQuest() then
		for C, J in next, Z.Data.QuestData.Task, nil do
			return C
		end
	end
end
function DoubleQuest()
	wait(0.5)
	B()
	local B = {}
	if DontQuest() and GetNameDoubleQuest() == getgenv().NameMobQuest and #CountQuest() >= 2 then
		for C, J in pairs(H) do
			for F, F in pairs(J) do
				for q in pairs(F.Task) do
					if tostring(q) == getgenv().mobv then
						for F, q in pairs(J) do
							for J, c in pairs(q.Task) do
								if J ~= getgenv().mobv and c > 1 then
									B.Name = J
									B.NameQuest = C
									B.ID = F
									return B
								end
							end
						end
					end
				end
			end
		end
	else
		B.Name = getgenv().NameMobQuest
		B.NameQuest = getgenv().NameQuest
		B.ID = getgenv().IDQuest
	end
	return B
end
function CFrameQuest()
	local B = {}
	for C, J in next, H, nil do
		if C ~= "MarineQuest" then
			for F, F in next, J, nil do
				B[F.LevelReq] = C
			end
		end
	end
	getgenv().questpoint = {}
	for C, J in next, Z.Data.NPCList, nil do
		for F, q in next, J.Levels, nil do
			F = B[q]
			if C.Parent.Name ~= "Marine Leader" and F and not getgenv().questpoint[F] then
				getgenv().questpoint[F] = CFrame.new(J.Position)
			end
		end
	end
	getgenv().questpoint.SkyExp1Quest = CFrame.new(-7857.28516, 5544.34033, -382.321503)
end
local function B(C)
	local J = Z.Data.QuestData
	local F, q, c = J and (next(J.Task)), 0, {}
	for D, r in pairs(Z.Data.NPCList) do
		if not table.find(V, r.InternalQuestName) then
			for V, n in pairs(r.Levels) do
				D = H[r.InternalQuestName][V]
				if D then
					local u, W = next(D.Task)
					if W and W > 1 and n <= C and n >= q then
						c = {
							Level = n,
							Name = r.NPCName,
							QuestName = r.InternalQuestName,
							Pos = r.Position,
							Id = V,
							Mob = u,
						}
						if F == u and V > 1 then
							J = H[r.InternalQuestName][V - 1]
							if J and J.Task then
								for H, C in pairs(J.Task) do
									if H ~= F and C > 1 then
										c.Mob = H
										c.Id = V - 1
										break
									end
								end
							end
						end
						q = n
					end
				end
			end
		end
	end
	return c
end

TakeQuestLevel = function()
	local V = B(t.Data.Level.Value)
	if getgenv().DebugFarmLevel then
		print(("[TakeQuestLevel] Level=%s Found=%s Pos=%s Mob=%s QuestName=%s"):format(
			tostring(t.Data.Level.Value),
			tostring(V ~= nil),
			tostring(V and V.Pos),
			tostring(V and V.Mob),
			tostring(V and V.QuestName)
		))
	end
	if not V or not V.Pos then
		return
	end
	local H, B, C =
		typeof(V.Pos) == "CFrame" and V.Pos.Position or V.Pos,
		t.Character and (t.Character:FindFirstChild("HumanoidRootPart")),
		t.Character and (t.Character:FindFirstChild("Humanoid"))
	if not B or not C then
		return
	end
	if (H - B.Position).Magnitude <= 8 and C.Health > 0 then
		wait(2)
		CommF:InvokeServer("StartQuest", tostring(V.QuestName), V.Id)
	else
		toTarget(CFrame.new(H) * CFrame.new(0, 4, 2), true)
	end
end

GetLevelQuestMob = function()
	local ok, info = pcall(B, t.Data.Level.Value)
	if ok and info and info.Mob then
		return info.Mob
	end
end

function DetectPartSpawnMob(V, H)
	local function B(C)
		return C:gsub(" %p?Lv%.? %d+%p?", "")
	end
	local C = string.find(V, "Lv.") and (B(V)) or V
	for J, F in pairs(TableMobSpawn) do
		if F:IsA("Part") then
			J = string.find(F.Name, "Lv.") and (B(F.Name)) or F.Name
			if (J == V or J == C) and (not H or not F:FindFirstChild("Ignored")) then
				return F
			end
		end
	end
	for J, F in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
		if F:IsA("Part") then
			J = string.find(F.Name, "Lv.") and (B(F.Name)) or F.Name
			if (J == V or J == C) and (not H or not F:FindFirstChild("Ignored")) then
				table.insert(TableMobSpawn, F)
				return F
			end
		end
	end
	for J, F in pairs(getnilinstances()) do
		if F:IsA("Part") then
			J = string.find(F.Name, "Lv.") and (B(F.Name)) or F.Name
			if (J == V or J == C) and (not H or not F:FindFirstChild("Ignored")) then
				table.insert(TableMobSpawn, F)
				return F
			end
		end
	end
	return nil
end
function DeleteIgnoredMobSpawn()
	for V, V in pairs(TableMobSpawn) do
		if V:FindFirstChild("Ignored") then
			V.Ignored:Destroy()
		end
	end
end
function DetectNameTablePart(V)
	for H, H in next, V, nil do
		if not table.find(N, H) then
			return H
		end
	end
end
function TeleportSpawnMob(V)
	if typeof(V) == "table" then
		if #N >= #V then
			N = {}
			return
		end
		local H = DetectPartSpawnMob(DetectNameTablePart(V))
		if H then
			toTarget(H.CFrame * CFrame.new(0, 60, 0))
			wait(0.5)
		end
	else
		wait(0.5)
		local H = DetectPartSpawnMob(V, true)
		if H then
			if (H.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100 or (DetectMob(V)) then
				Instance.new("IntValue", H).Name = "Ignored"
			end
			toTarget(H.CFrame * CFrame.new(0, 60, 0))
		else
			DeleteIgnoredMobSpawn()
		end
	end
end
function QuestBoneAndkatakuri(V, H)
	local B = getgenv().questpoint[V]
	if not B then
		CFrameQuest()
		task.wait(1.5)
		B = getgenv().questpoint[V]
		if not B then
			return
		end
	end
	local C, J =
		t.Character and (t.Character:FindFirstChild("HumanoidRootPart")),
		t.Character and (t.Character:FindFirstChildOfClass("Humanoid"))
	if not C or not J then
		return
	end
	if (B.Position - C.Position).Magnitude <= 8 then
		if J.Health > 0 then
			CommF:InvokeServer("StartQuest", V, H)
			task.wait(0.5)
		end
	else
		toTarget(B * CFrame.new(0, 4, 2), true)
	end
end
local V = { "Control-Control", "Buddha-Buddha", "Diamond-Diamond", "Falcon-Falcon" }
local function H(B, C)
	local J = t.PlayerGui.Main.Skills[B]:FindFirstChild(C)
	if not J then
		return false
	end
	return J:IsA("Frame") and J.Title.TextColor3 == Color3.new(1, 1, 1) and J.Cooldown.Size == UDim2.new(0, 0, 1, -1)
		or J.Cooldown.Size == UDim2.new(1, 0, 1, -1)
end
local function B(C)
	if H(C, "Z") then
		local H = game:GetService("VirtualInputManager")
		H:SendKeyEvent(true, "Z", false, game)
		H:SendKeyEvent(false, "Z", false, game)
	end
end
local function H(C)
	local J = t.PlayerGui.Main.Skills[C.Name]
	if not J then
		return nil
	end
	for F, F in ipairs(J:GetChildren()) do
		if
			F:IsA("Frame")
			and F.Name ~= "Template"
			and (F.Name ~= "Z" or F.Name == "Z" and not table.find(V, C.Name))
			and Settings["Select Skills " .. C.ToolTip]
			and Settings["Select Skills " .. C.ToolTip][F.Name]
			and (
				F.Title.TextColor3 == Color3.new(1, 1, 1) and F.Cooldown.Size == UDim2.new(0, 0, 1, -1)
				or F.Cooldown.Size == UDim2.new(1, 0, 1, -1)
			)
		then
			return F.Name
		end
	end
end
function UsedualFlock()
	equiptool(NameWeapon(Settings["Select Weapon"] or "Melee"))
end
function FarmMastery(V)
	if not V or not V:FindFirstChild("Humanoid") or not V:FindFirstChild("HumanoidRootPart") then
		return
	end
	getgenv().AimPos = V.HumanoidRootPart.CFrame
	if not Settings["Farm Mastery"] then
		UsedualFlock()
		return
	end
	if V.Humanoid.Health / V.Humanoid.MaxHealth > (Settings["Health %"] or 100) / 100 then
		UsedualFlock()
		return
	end
	local C = Settings["Select Method Farm Mastery"]
	local J, F = NameWeapon(C), NameWeapon(C, true)
	if not J or not F then
		return
	end
	if C == "Gun" and (t.Character:FindFirstChild(J)) then
		ShootM1(V)
	end
	equiptool(J)
	if J == "Control-Control" then
		C = workspace._WorldOrigin:FindFirstChild("Globe")
		if not C or t:DistanceFromCharacter(C.Position) > C.AB.CurveSize0 / 1.75 then
			B(J)
			return
		end
	elseif J == "Buddha-Buddha" then
		if not t.Character.HumanoidRootPart:FindFirstChild("Buddha") then
			B(J)
			return
		end
	elseif J == "Diamond-Diamond" then
		if not t.Character:FindFirstChild("DiamondBody") then
			B(J)
			return
		end
	elseif J == "Falcon-Falcon" then
		if not t.Character:FindFirstChild("FalconWings") then
			B(J)
			return
		end
	end
	C = H(F)
	if C then
		V, J = Settings["Skill " .. C .. " " .. F.ToolTip] or 0.5, game:GetService("VirtualInputManager")
		J:SendKeyEvent(true, C, false, game)
		if Settings["Use skill fast dont hold"] then
			task.wait(0.05)
		else
			task.wait(V)
		end
		J:SendKeyEvent(false, C, false, game)
	end
end
getgenv().StackFarm = true
getgenv().StackFarmOther = true
StackFarm = getgenv().StackFarm
StackFarmOther = getgenv().StackFarmOther
function DetectMobAura()
	local V, H = typeof(Settings["Distance Farm Aura"]) ~= "number" and (tonumber(Settings["Distance Farm Aura"]))
		or Settings["Distance Farm Aura"]
		or 300
	for B, C in pairs(game.Workspace.Enemies:GetChildren()) do
		if IsMobAlive(C) then
			B = (
				C.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
			).magnitude
			if B < V then
				V, H = B, C.Name
			end
		end
	end
	return H
end
getgenv().StackFarm = true
getgenv().YPosFruit = 20
function CheckCDSkillTransformation(V, H)
	local B, C, J = next, game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills[V.Name]:GetChildren()
	for F, F in B, C, J do
		if F:IsA("Frame") then
			if
				F.Name ~= "Template"
					and not string.find(F.Title.Text, "Transformation")
					and H[F.Name]
					and F.Title.TextColor3 == Color3.new(1, 1, 1)
					and F.Cooldown.Size == UDim2.new(0, 0, 1, -1)
				or F.Cooldown.Size == UDim2.new(1, 0, 1, -1)
			then
				return F, Settings["Skill " .. F.Name .. " " .. V.ToolTip]
			end
		end
	end
end
function AutoAllSkill(V)
	local V, H, B, C, J =
		NameWeapon("Melee", true) or false,
		NameWeapon("Sword", true) or false,
		NameWeapon("Blox Fruit", true) or false,
		NameWeapon("Gun", true) or false,
		game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills
	if V and not J:FindFirstChild(V.Name) then
		equiptool(V.Name)
		return
	end
	if H and not J:FindFirstChild(H.Name) then
		equiptool(H.Name)
		return
	end
	if B and not J:FindFirstChild(B.Name) then
		equiptool(B.Name)
		return
	end
	if C and not J:FindFirstChild(C.Name) then
		equiptool(C.Name)
		return
	end
	J = (function() if V and (CheckCDSkillTransformation(V, Settings["Select Skills " .. V.ToolTip])) then return (CheckCDSkillTransformation(V, Settings["Select Skills " .. V.ToolTip])) else return (function() if H and (CheckCDSkillTransformation(H, Settings["Select Skills " .. H.ToolTip])) then return (CheckCDSkillTransformation(H, Settings["Select Skills " .. H.ToolTip])) else return (function() if C and (CheckCDSkillTransformation(C, Settings["Select Skills " .. C.ToolTip])) then return (CheckCDSkillTransformation(C, Settings["Select Skills " .. C.ToolTip])) else return (function() if B and (CheckCDSkillTransformation(B, Settings["Select Skills " .. B.ToolTip])) then return (CheckCDSkillTransformation(B, Settings["Select Skills " .. B.ToolTip])) else return nil end end)() end end)() end end)() end end)()
	if J then
		B = J.Parent.Name
		equiptool(B)
		if t.Character:FindFirstChild(B) then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, J.Name, false, game)
			if Settings["Use skill fast dont hold"] then
				task.wait(0.05)
			else
				task.wait(HoldDelay(J.Name, B))
			end
			game:GetService("VirtualInputManager"):SendKeyEvent(false, J.Name, false, game)
		end
	end
end
local V, H =
	require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService")),
	require(game:GetService("ReplicatedStorage"):WaitForChild("ItemConfig"))
local function B()
	local C, J = {}, require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService")).KEYS
	for F, F in V:GetItems(J.QUANTITY) do
		if F.Value and F.Value > 0 then
			local q, c = pcall(function()
				return H.match(F.ItemId):unwrap()
			end)
			if q and c and c.Display then
				local H, q = c.Display.Category, c.Index and c.Index.StorageKey
				local D, r =
					(function() if H == "Blox Fruit" then return q or c.Display.Name or "ItemId_" .. F.ItemId else return c.Display.Name or q or "ItemId_" .. F.ItemId end end)(),
					V:ReadItem(J.MASTERY, F.ItemId, F.NetworkedUID) or 0
				table.insert(
					C,
					{ Name = D, Type = H, Count = F.Value, Mastery = r, ItemId = F.ItemId, UID = F.NetworkedUID }
				)
			end
		end
	end
	return C
end
do
	local V
	local H = 0
	function CheckItemInventory(C)
		if not V or tick() - H > 1 then
			V = {}
			for J, J in B() do
				V[J.Name] = true
			end
			H = tick()
		end
		return V[C] == true
	end
end
function DetectModelDestroyTyrant()
	local V, H, C =
		next,
		(workspace.Map:FindFirstChild("TikiOutpost") and (workspace.Map.TikiOutpost.IslandModel:FindFirstChild(
			"EagleBossArena",
			true
		))):GetChildren()
	for J, J in V, H, C do
		if J.Name == "Tree" and not J:GetAttribute("AlreadyDestroyedClient") then
			return J
		end
	end
end
(function()
	local V = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	return {
		encode = function(H)
			return (H:gsub(".", function(C)
				local J, F = C:byte(), ""
				for C = 8, 1, -1 do
					F = F .. (J % 2 ^ C - J % 2 ^ (C - 1) > 0 and "1" or "0")
				end
				return F
			end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(C)
				if #C < 6 then
					return ""
				end
				local J = 0
				for F = 1, 6, 1 do
					J = J + (C:sub(F, F) == "1" and 2 ^ (6 - F) or 0)
				end
				return V:sub(J + 1, J + 1)
			end) .. ({ "", "==", "=" })[#H % 3 + 1]
		end,
		decode = function(H)
			return string
				.gsub(H, "[^" .. V .. "=]", "")
				:gsub(".", function(H)
					if H == "=" then
						return ""
					end
					local C, J = V:find(H) - 1, ""
					for V = 6, 1, -1 do
						J = J .. (C % 2 ^ V - C % 2 ^ (V - 1) > 0 and "1" or "0")
					end
					return J
				end)
				:gsub("%d%d%d?%d?%d?%d?%d?%d?", function(V)
					if #V ~= 8 then
						return ""
					end
					local H = 0
					for C = 1, 8, 1 do
						H = H + (V:sub(C, C) == "1" and 2 ^ (8 - C) or 0)
					end
					return string.char(H)
				end)
		end,
	}
end)()
local V = "https://raw.banana-hub.xyz/api"
local function H(C, J)
	local J
	local F, F = pcall(function()
		J =
			ExploitReq({ Url = ("%s/data/recent?name=%s&limit=%s"):format(V, C, 100):gsub(" ", "%%20"), Method = "GET" })
	end)
	if F then
		return false
	end
	return J.Body
end
local V
function SpecialHop(C)
	if getgenv().Key and #getgenv().Key == 32 then
		return
	end
	if V and tick() - V < 5 then
		return
	end
	local J, F = {}, H(C, 700)
	if not F then
		return
	end
	Servers = game:GetService("HttpService"):JSONDecode(F)
	for H, q in next, Servers.data, nil do
		if q and q.name == C then
			table.insert(J, H)
		end
	end
	V = tick()
	if #J > 0 then
		F = {}
		for V, V in next, Servers.data, nil do
			if V and V.name == C then
				local H, C, J, q, q = V.jobid, V.Players, V.placeid, f()
				H = (function() if string.find(H, "BananaCat") then return (q(H)) else return H end end)()
				if
					H
					and H ~= game.JobId
					and not table.find(F, H)
					and not CheckIsplayingRaid()
					and not Settings[H]
					and (C and C < game.Players.MaxPlayers or not V.Players)
					and (J and game.PlaceId == J or not J)
				then
					table.insert(F, H)
					game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", tostring(H))
					SaveSettings(tostring(H), true)
					getgenv().limit_type("clearAll")
				end
			end
		end
	end
end
function FarmMethod()
	local f, V, H = Settings["Select Method Farm"]
	local C, J = 9999, 2
	if f == "Farm Katakuri" then
		C, V, H = 2275, y, "CakeQuest2"
	elseif f == "Farm Bones" then
		C, V, H = 2050, e, "HauntedQuest2"
	elseif f == "Farm Tyrant of the Skies" then
		C, V, H = 2575, Y, "TikiQuest3"
	else
		V = ((f == "Aura Farm" and (DetectMobAura())) and { DetectMobAura() } or V)
	end
	if Settings["Farm Material"] then
		V = NameMaterials[Settings["Select Material"]]
		if not NameWorldMaterials[Settings["Select Material"]][game.PlaceId] then
			f = NameWorldMaterials[Settings["Select Material"]][getgenv().CheckPlaceId2]
				or NameWorldMaterials[Settings["Select Material"]][getgenv().CheckPlaceId3]
				or NameWorldMaterials[Settings["Select Material"]][getgenv().CheckPlaceId]
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(f)
			return
		end
	end
	f = V or (GetNameDoubleQuest()) or (GetLevelQuestMob and GetLevelQuestMob()) or ""
	if getgenv().DebugFarmLevel then
		print(("[FarmMethod] HasQuest=%s f=%s"):format(tostring(HasQuest()), tostring(f)))
	end
	if not HasQuest() and typeof(f) == "string" then
		TakeQuestLevel()
	else
		if
			Settings["Auto Quest [Katakuri/Bone/Tyrant]"]
			and t.Data.Level.Value >= C
			and not HasQuest()
		then
			QuestBoneAndkatakuri(H, J)
			return
		end
		if not Settings["Farm Material"] and Settings["Select Method Farm"] == "Farm Tyrant of the Skies" then
			if CheckNameBoss("Tyrant of the Skies") then
				V = CheckNameBoss("Tyrant of the Skies")
				repeat
					task.wait()
					sizepart(V)
					if
						game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible
						and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"])
					then
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					elseif Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
					UsedualFlock()
					ClickM1(V)
				until not IsMobAlive(V) or not Settings["Start Farm"] or not StackFarm
				return
			else
				local V = workspace:FindFirstChild("Map", true)
					and (workspace.Map:FindFirstChild("TikiOutpost", true))
					and (workspace.Map.TikiOutpost:FindFirstChild("IslandModel", true))
				if V then
					local Y, H, C, J =
						V:FindFirstChild("Eye1", true),
						V:FindFirstChild("Eye2", true),
						V:FindFirstChild("Eye3", true),
						V:FindFirstChild("Eye4", true)
					if
						Y
						and H
						and C
						and J
						and Y.Transparency == 0
						and H.Transparency == 0
						and C.Transparency == 0
						and J.Transparency == 0
					then
						local V = DetectModelDestroyTyrant()
						if V then
							if t:DistanceFromCharacter(V.WorldPivot.Position) > 10 then
								toTarget(V.WorldPivot)
							elseif CheckItemInventory("Skull Guitar") then
								if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Skull Guitar" then
									game:GetService("ReplicatedStorage").Remotes.CommF_
										:InvokeServer(unpack({ [1] = "LoadItem", [2] = "Skull Guitar" }))
								else
									equiptool(NameWeapon("Gun"))
									getgenv().ClickWorldPos(V.WorldPivot.Position)
								end
							else
								getgenv().AimPos = V.WorldPivot
								AutoAllSkill()
							end
						end
						return
					end
				end
			end
		end
		if
			not Settings["Farm Material"]
			and Settings["Select Method Farm"] == "Farm Katakuri"
			and not Settings["Ignore Attack Katakuri"]
		then
			if CheckNameBoss("Cake Prince") then
				local V = CheckNameBoss("Cake Prince")

				-- ===== THÊM: bay tới cổng -> delay 1.5s -> check Y > 4000 mới farm boss, chưa thì bay lại cổng =====
				local mirror = workspace.Map:FindFirstChild("CakeLoaf")
					and workspace.Map.CakeLoaf:FindFirstChild("BigMirror")
					and workspace.Map.CakeLoaf.BigMirror:FindFirstChild("Main")
				local root = t.Character and t.Character:FindFirstChild("HumanoidRootPart")

				if mirror and root and root.Position.Y <= 4000 then
					repeat
						-- bay tới cổng
						repeat
							task.wait()
							root = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
							if not root then
								break
							end
							toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0)) -- toTarget tự bay tới cổng như cũ
						until (mirror.Position - root.Position).Magnitude <= 20
							or root.Position.Y > 4000
							or not IsMobAlive(V)
							or not Settings["Start Farm"]
							or not StackFarm
						task.wait(1.5) -- delay sau khi tới cổng
						root = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
					-- check sau delay: Y chưa > 4000 thì lặp lại bay vào cổng
					until not root
						or root.Position.Y > 4000
						or not IsMobAlive(V)
						or not Settings["Start Farm"]
						or not StackFarm
				end
				-- ===== HẾT PHẦN THÊM =====

				repeat
					task.wait()
					sizepart(V)
					if
						game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible
						and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"])
					then
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					elseif Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
					UsedualFlock()
					ClickM1(V)
				until not IsMobAlive(V) or not Settings["Start Farm"] or not StackFarm
				return
			else
				spawn(function()
					if Settings["Hop Find Katakuri"] then
						SpecialHop("Cake Prince")
					end
				end)
			end
		end
		local V = DetectMob(f)
		if not V then
			if typeof(f) == "table" then
				if #N >= #f then
					N = {}
					return
				end
				local Y = DetectNameTablePart(f)
				local H = DetectPartSpawnMob(Y)
				if H then
					table.insert(N, Y)
					repeat
						task.wait()
						toTarget(H.CFrame * CFrame.new(0, 60, 0))
					until (H.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob(f))
						or not Settings["Start Farm"]
						or not StackFarm
					wait(1)
				end
			else
				local Y = DetectPartSpawnMob(f, true)
				if Y then
					Instance.new("IntValue", Y).Name = "Ignored"
					repeat
						task.wait()
						toTarget(Y.CFrame * CFrame.new(0, 60, 0))
					until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob(f))
						or not Settings["Start Farm"]
						or not StackFarm
					wait(1)
				else
					DeleteIgnoredMobSpawn()
				end
			end
		else
			repeat
				task.wait()
				sizepart(V)
				BringMob(V)
				FarmMastery(V)
				ClickM1(V)
				if
					game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible
					and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"])
				then
					toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				elseif Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(V.HumanoidRootPart.CFrame * CFrame.new(-7, getgenv().YPosFruit, 0))
				else
					toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
			until not IsMobAlive(V) or not Settings["Start Farm"] or not StackFarm
			if getgenv().QuestTrainer and getgenv().QuestTrainer.CountKillMob then
				getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
			end
		end
	end
end
spawn(function()
	while task.wait() do
		local f, f = pcall(function()
			if Settings["Start Farm"] and StackFarm then
				FarmMethod()
			end
		end)
		if f then
			print(f)
		end
	end
end)
stackFarmMain = Main.CreatePage({ Page_Name = "Stack Farming", Page_Title = "Stack Farming" })
AutoWorldSection = stackFarmMain.CreateSection("Auto World")
AutoWorldSection.CreateToggle(
	{ Title = "Auto New World", Desc = nil, Default = Settings["Auto New World"] or false },
	function(f)
		SaveSettings("Auto New World", f)
	end
)
AutoWorldSection.CreateToggle(
	{ Title = "Auto Third World", Desc = nil, Default = Settings["Auto Third World"] or false },
	function(f)
		SaveSettings("Auto Third World", f)
	end
)
getgenv().GetTime = nil
NotiGetTime = true
function timeToSeconds(f)
	local V, Y, H = f:match("^(%d+):(%d+):(%d+)$")
	if not V then
		Y, H = f:match("^(%d+):(%d+)$")
		V = 0
	end
	return tonumber(V) * 3600 + tonumber(Y) * 60 + tonumber(H)
end
function secondsToTime(f)
	local V, Y, H = math.floor(f / 3600), math.floor(f % 3600 / 60), f % 60
	return string.format("%d:%02d:%02d", V, Y, H)
end
function DetectPresent()
	for f, f in t.Backpack:GetChildren() do
		if string.find(f.Name, "Holiday Gift") then
			return f
		end
	end
	for f, f in t.Character:GetChildren() do
		if string.find(f.Name, "Holiday Gift") then
			return f
		end
	end
end
function DetectPresentStore()
	for f, f in t.Backpack:GetChildren() do
		if string.find(f.Name, "Holiday Gift") and not f:FindFirstChild("Ignored") then
			return f
		end
	end
	for f, f in t.Character:GetChildren() do
		if string.find(f.Name, "Holiday Gift") and not f:FindFirstChild("Ignored") then
			return f
		end
	end
end
function GetCountDownTime()
	if not getgenv().GetTime and not game.workspace:FindFirstChild("Countdown") then
		return "Go Get Time"
	end
	if workspace:FindFirstChild("Countdown") and (workspace.Countdown.SurfaceGui.TextLabel.Text:find("START")) then
		return 0
	end
	local f = workspace:FindFirstChild("Countdown") and workspace.Countdown.SurfaceGui.TextLabel.Text
		or (secondsToTime(getgenv().GetTime))
	if tonumber(f:split(":")[1]) == 0 then
		return tonumber(f:split(":")[2])
	else
		return 55
	end
end
function getGift()
	if not workspace._WorldOrigin:FindFirstChild("Present") then
		return
	end
	for f, f in pairs(workspace._WorldOrigin:GetChildren()) do
		if
			f.Name == "Present"
			and (f:FindFirstChild("Highlight"))
			and (f:FindFirstChild("Box"))
			and (f.Box:FindFirstChild("ProximityPrompt"))
		then
			return f
		end
	end
end
StackDevilFruitSection = stackFarmMain.CreateSection("Devil Fruit")
StackDevilFruitSection.CreateToggle(
	{
		Title = "Collect Chest When Server Spawn\10God's Chalice or Fist of Darkness",
		Desc = nil,
		Default = Settings["Collect Chest When Server Spawn God's Chalice or Fist of Darkness"] or false,
	},
	function(f)
		SaveSettings("Collect Chest When Server Spawn God's Chalice or Fist of Darkness", f)
	end
)
StackDevilFruitSection.CreateToggle(
	{ Title = "Teleport To Fruit", Desc = nil, Default = Settings["Teleport To Fruit"] or false },
	function(f)
		SaveSettings("Teleport To Fruit", f)
	end
)
StackDevilFruitSection.CreateToggle(
	{
		Title = "Teleport To Fruit [ Hop Server ]",
		Desc = nil,
		Default = Settings["Teleport To Fruit [ Hop Server ]"] or false,
	},
	function(f)
		SaveSettings("Teleport To Fruit [ Hop Server ]", f)
	end
)
EventGameSection = stackFarmMain.CreateSection("Event Game")
EventGameSection.CreateToggle(
	{ Title = "Auto Factory", Desc = nil, Default = Settings["Auto Factory"] or false },
	function(f)
		SaveSettings("Auto Factory", f)
	end
)
EventGameSection.CreateToggle(
	{ Title = "Auto Pirate Raid", Desc = nil, Default = Settings["Auto Pirate Raid"] or false },
	function(f)
		SaveSettings("Auto Pirate Raid", f)
	end
)
BossRipIndraSection = stackFarmMain.CreateSection("Boss Rip Indra")
BossRipIndraSection.CreateToggle(
	{ Title = "Auto Elite Hunter", Desc = nil, Default = Settings["Auto Elite Hunter"] or false },
	function(f)
		SaveSettings("Auto Elite Hunter", f)
	end
)
BossRipIndraSection.CreateToggle(
	{
		Title = 'Hop Server Elite Hunter"',
		Desc = "Hop if u have God chalice and teleport in safezone",
		Default = Settings["Hop Server Elite Hunter"] or false,
	},
	function(f)
		SaveSettings("Hop Server Elite Hunter", f)
	end
)
BossRipIndraSection.CreateToggle(
	{ Title = "Auto Touch Pad Haki", Desc = nil, Default = Settings["Auto Touch Pad Haki"] or false },
	function(f)
		SaveSettings("Auto Touch Pad Haki", f)
	end
)
BossRipIndraSection.CreateToggle(
	{ Title = "Auto Summon Rip Indra", Desc = nil, Default = Settings["Auto Summon Rip Indra"] or false },
	function(f)
		SaveSettings("Auto Summon Rip Indra", f)
	end
)
BossRipIndraSection.CreateToggle(
	{ Title = "Attack Rip Indra", Desc = nil, Default = Settings["Attack Rip Indra"] or false },
	function(f)
		SaveSettings("Attack Rip Indra", f)
	end
)
BossSoulReaperSection = stackFarmMain.CreateSection("Boss Soul Reaper")
BossSoulReaperSection.CreateToggle(
	{ Title = "Attack Soul Reaper", Desc = nil, Default = Settings["Attack Soul Reaper"] or false },
	function(f)
		SaveSettings("Attack Soul Reaper", f)
	end
)
BossSoulReaperSection.CreateToggle(
	{ Title = "Summon Soul Reaper", Desc = nil, Default = Settings["Summon Soul Reaper"] or false },
	function(f)
		if f and not Settings["Attack Soul Reaper"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Attack Soul Reaper Plz", ShowTime = 5 })
		end
		SaveSettings("Summon Soul Reaper", f)
	end
)
BossDoughKingSection = stackFarmMain.CreateSection("Boss Dough King")
BossDoughKingSection.CreateToggle(
	{ Title = "Attack Dough King", Desc = nil, Default = Settings["Attack Dough King"] or false },
	function(f)
		SaveSettings("Attack Dough King", f)
	end
)
BossDoughKingSection.CreateToggle(
	{ Title = "Summon Dough King", Desc = nil, Default = Settings["Summon Dough King"] or false },
	function(f)
		if f and not Settings["Attack Dough King"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Attack Dough King Plz", ShowTime = 5 })
		end
		if f then
			spawn(function()
				while Settings["Summon Dough King"] and (task.wait()) do
					if DetectItemPlr("Sweet Chalice") then
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
					end
				end
			end)
		end
		SaveSettings("Summon Dough King", f)
	end
)
BossDoughKingSection.CreateToggle(
	{ Title = "Hop Find Dough King", Desc = nil, Default = Settings["Hop Find Dough King"] or false },
	function(f)
		if f and not Settings["Attack Dough King"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Attack Dough King Plz", ShowTime = 5 })
		end
		SaveSettings("Hop Find Dough King", f)
	end
)
BossDarkbeardSection = stackFarmMain.CreateSection("Boss Darkbeard")
BossDarkbeardSection.CreateToggle(
	{ Title = "Attack Darkbeard", Desc = nil, Default = Settings["Attack Darkbeard"] or false },
	function(f)
		SaveSettings("Attack Darkbeard", f)
	end
)
BossDarkbeardSection.CreateToggle(
	{ Title = "Summon Darkbeard", Desc = nil, Default = Settings["Summon Darkbeard"] or false },
	function(f)
		if f and not Settings["Attack Darkbeard"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Attack Darkbeard Plz", ShowTime = 5 })
		end
		SaveSettings("Summon Darkbeard", f)
	end
)
BossDarkbeardSection.CreateToggle(
	{ Title = "Hop Find Darkbeard", Desc = nil, Default = Settings["Hop Find Darkbeard"] or false },
	function(f)
		if f and not Settings["Attack Darkbeard"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Attack Darkbeard Plz", ShowTime = 5 })
		end
		SaveSettings("Hop Find Darkbeard", f)
	end
)
function GetPathFruit()
	local f, V, Y = next, game.Workspace:GetChildren()
	for H, H in f, V, Y do
		if (H:IsA("Tool") or (H:IsA("Model"))) and (string.find(H.Name, "Fruit")) and (H:FindFirstChild("Handle")) then
			return H
		end
	end
end
function GetPirateRaid(f)
	for V, V in ipairs(((function() if f then return game.ReplicatedStorage else return game.workspace.Enemies end end)()):GetChildren()) do
		if
			V:IsA("Model")
			and V.Name ~= "Oni2"
			and not string.find(V.Name, "Boss")
			and not string.find(V.Name, "Friend")
			and not string.find(V.Name, "Wraith")
			and V.Name ~= "rip_indra True Form"
			and (IsMobAlive(V))
			and (V.HumanoidRootPart.Position - Vector3.new(-5543, 313, -2964)).magnitude < 1000
		then
			return V
		end
	end
end
function DetectButtons()
	local f, V, Y = next, game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:GetChildren()
	for H, H in f, V, Y do
		if H:IsA("Part") and H.Part.BrickColor.Name ~= "Lime green" then
			return H
		end
	end
end
local f = { "Winter Sky", "Pure Red", "Snow White" }
function IsMisisngLegHaki(V)
	V = V and {}
	local Y
	for H, H in pairs(CommF:InvokeServer("getColors")) do
		if table.find(f, H.HiddenName) and not H.Unlocked then
			if V then
				table.insert(V, H.HiddenName)
			else
				Y = (function() if not Y then return H.HiddenName else return Y .. ", " .. H.HiddenName end end)()
			end
		end
	end
	if V then
		return V
	end
	return Y
end
function TouchPadHaki()
	local f = DetectButtons()
	if f then
		if f.BrickColor.Name == "Hot pink" then
			game:GetService("ReplicatedStorage").Modules.Net
				:FindFirstChild("RF/FruitCustomizerRF")
				:InvokeServer(unpack({ [1] = { StorageName = "Winter Sky", Type = "AuraSkin", Context = "Equip" } }))
			toTarget(f.CFrame)
			wait(2)
		elseif f.BrickColor.Name == "Really red" then
			game:GetService("ReplicatedStorage").Modules.Net
				:FindFirstChild("RF/FruitCustomizerRF")
				:InvokeServer(unpack({ [1] = { StorageName = "Pure Red", Type = "AuraSkin", Context = "Equip" } }))
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", "Pure Red")
			toTarget(f.CFrame)
			wait(2)
		elseif f.BrickColor.Name == "Oyster" then
			game:GetService("ReplicatedStorage").Modules.Net
				:FindFirstChild("RF/FruitCustomizerRF")
				:InvokeServer(unpack({ [1] = { StorageName = "Snow White", Type = "AuraSkin", Context = "Equip" } }))
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", "Snow White")
			toTarget(f.CFrame)
			wait(2)
		end
	end
end
getgenv().CheckCountItem = function(f, V)
	local Y, H, C = next, B()
	for J, J in Y, H, C do
		if J.Name == f and J.Count and J.Count >= V then
			return true
		end
	end
	return false
end
function getbackpack()
	mybackpack = {}
	local f, V, Y = next, game.Players.LocalPlayer.Backpack:GetChildren()
	for H, H in f, V, Y do
		if H:IsA("Tool") and (table.find(whitelistedfruit, H.Name)) then
			table.insert(mybackpack, H.Name)
		end
	end
	f, Y, V = next, game.Players.LocalPlayer.Character:GetChildren()
	for H, H in f, Y, V do
		if H:IsA("Tool") and (table.find(whitelistedfruit, H.Name)) then
			table.insert(mybackpack, H.Name)
		end
	end
	return mybackpack
end
function CheckFruitplr()
	local f
	for V, V in pairs(t.Backpack:GetChildren()) do
		f = (function() if string.find(V.Name, "Fruit") then return V.Name else return f end end)()
	end
	for V, V in pairs(t.Character:GetChildren()) do
		f = (function() if string.find(V.Name, "Fruit") then return V.Name else return f end end)()
	end
	return f
end
function TakeFruitInventory(f)
	local V, Y, H = next, B()
	local C, J = 1 / 0
	for F, F in V, Y, H do
		if F.Type == "Blox Fruit" then
			if not f then
				for f, V in pairs(getgenv().tablefruitausea3) do
					if F.Name == f then
						if tonumber(V) < tonumber(C) then
							C, J = V, f
						end
					end
				end
			elseif not getgenv().tablefruitausea3[F.Name] then
				return F.Name
			end
		end
	end
	return J
end
cframethangdaubuoiredhead = CFrame.new(
	-1926.78772,
	12.1678171,
	1739.80884,
	0.956294656,
	-0.0,
	-0.292404652,
	0,
	1,
	-0.0,
	0.292404652,
	0,
	0.956294656
)
function StopThirdSea()
	if game.PlaceId == getgenv().CheckPlaceId2 and t.Data.Level.Value >= 1500 then
		if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
			if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") ~= 0 then
				if #getbackpack() >= 1 then
					return true
				elseif not CheckFruitplr() and (TakeFruitInventory()) then
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
		else
			return true
		end
	end
end
function checkplatebarito()
	return ((game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate1.BrickColor
			== BrickColor.new("Sand yellow")) and "Plate1" or ((game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate2.BrickColor
				== BrickColor.new("Sand yellow")) and "Plate2" or ((game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate3.BrickColor
					== BrickColor.new("Sand yellow")) and "Plate3" or ((game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate4.BrickColor
						== BrickColor.new("Sand yellow")) and "Plate4" or ((game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate5.BrickColor
							== BrickColor.new("Sand yellow")) and "Plate5" or ((game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate6.BrickColor
								== BrickColor.new("Sand yellow")) and "Plate6" or ((game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate7.BrickColor
									== BrickColor.new("Sand yellow")) and "Plate7" or ((game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate8.BrickColor
										== BrickColor.new("Sand yellow")) and "Plate8" or nil))))))))
end
function AutoQuestBarito()
	if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
		if
			QuestHas("Swan Pirates")
			and (QuestHas("50"))
			and HasQuest()
		then
			local f, V = "Swan Pirate", DetectMob("Swan Pirate")
			if not V then
				if typeof(f) == "table" then
					if #N >= 11 then
						N = {}
						return
					end
					local Y = DetectPartSpawnMob(DetectNameTablePart(f))
					if Y then
						table.insert(N, DetectNameTablePart(f))
						repeat
							wait()
							toTarget(Y.CFrame * CFrame.new(0, 60, 0))
						until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100 or (DetectMob(f))
						wait(1)
					end
				else
					local Y = DetectPartSpawnMob(f, true)
					if Y then
						Instance.new("IntValue", Y).Name = "Ignored"
						repeat
							wait()
							toTarget(Y.CFrame * CFrame.new(0, 60, 0))
						until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100 or (DetectMob(f))
						wait(1)
					else
						DeleteIgnoredMobSpawn()
					end
				end
			else
				repeat
					task.wait()
					sizepart(V)
					BringMob(V)
					UsedualFlock()
					ClickM1(V)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
				until not IsMobAlive(V)
			end
		elseif
			(t.Character.HumanoidRootPart.Position - CFrame.new(-456.28952, 73.0200958, 299.895966).Position).Magnitude
			> 8
		then
			toTarget(CFrame.new(-456.28952, 73.0200958, 299.895966))
		else
			game:GetService("ReplicatedStorage").Remotes.CommF_
				:InvokeServer(unpack({ [1] = "StartQuest", [2] = "BartiloQuest", [3] = 1 }))
		end
	elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
		local f = CheckNameBoss("Jeremy")
		if f then
			repeat
				task.wait()
				sizepart(f)
				UsedualFlock()
				ClickM1(f)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(f.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(f.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
			until not IsMobAlive(f)
		end
	elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
		repeat
			task.wait()
			if (t.Character.HumanoidRootPart.Position - Vector3.new(-1835.65, 10.4325, 1679.75)).Magnitude > 100 then
				toTarget(CFrame.new(-1835.65, 10.4325, 1679.75))
			else
				t.Character.HumanoidRootPart.CFrame =
					game:GetService("Workspace").Map.Dressrosa.BartiloPlates[checkplatebarito()].CFrame
				task.wait()
				firetouchinterest(
					game:GetService("Workspace").Map.Dressrosa.BartiloPlates[checkplatebarito()],
					game.Players.LocalPlayer.Character.HumanoidRootPart,
					0
				)
				firetouchinterest(
					game:GetService("Workspace").Map.Dressrosa.BartiloPlates[checkplatebarito()],
					game.Players.LocalPlayer.Character.HumanoidRootPart,
					1
				)
			end
		until game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3
	end
end
function SeaThird()
	if
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") == 0
		and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 1
		and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Zou") == 0
	then
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
	end
	if game.PlaceId == getgenv().CheckPlaceId2 and t.Data.Level.Value >= 1500 then
		if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
			if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") ~= 0 then
				if #getbackpack() >= 1 then
					toTarget(CFrame.new(-339.79840087891, 331.86065673828, 643.83178710938))
					if
						(
							Vector3.new(-339.79840087891, 331.86065673828, 643.83178710938)
							- t.Character.HumanoidRootPart.Position
						).Magnitude <= 5
					then
						if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") ~= 1 then
							local f, V, Y = next, getbackpack()
							for H, H in f, V, Y do
								t.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(H))
							end
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "1")
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "2")
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "3")
						end
					end
				elseif not CheckFruitplr() and (TakeFruitInventory()) then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", TakeFruitInventory())
				end
			elseif
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") == 0
				and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 1
				and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Zou") == 0
			then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
			elseif not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") then
				if CheckNameBoss("Don Swan") then
					local f = CheckNameBoss("Don Swan")
					repeat
						task.wait()
						sizepart(f)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(f.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(f.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						UsedualFlock()
						ClickM1(f)
					until not f or not f.Parent or f.Humanoid.Health == 0
				end
			elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
				if
					(t.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map.IndraIsland.Part.Position).Magnitude
					> 1000
				then
					toTarget(cframethangdaubuoiredhead)
					if (cframethangdaubuoiredhead.p - t.Character.HumanoidRootPart.Position).Magnitude <= 5 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
					end
				else
					local f, V, Y = next, workspace.Enemies:GetChildren()
					for H, H in f, V, Y do
						if
							H.Name == "rip_indra"
							and (H:FindFirstChild("HumanoidRootPart"))
							and (H:FindFirstChild("Humanoid"))
							and H.Humanoid.Health > 0
						then
							if
								(H.HumanoidRootPart.Position - t.Character.HumanoidRootPart.Position).Magnitude > 300
							then
								toTarget(H.HumanoidRootPart.CFrame)
							else
								repeat
									task.wait()
									sizepart(H)
									if Settings["Select Weapon"] == "Blox Fruit" then
										toTarget(H.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										toTarget(H.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end
									ClickM1(H)
									UsedualFlock()
								until not workspace.Enemies:FindFirstChild("rip_indra")
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
local f = 0
function PathFindChest()
	local V, Y, H = next, game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()
	for C, C in V, Y, H do
		if C:IsA("Model") and (C:FindFirstChild("Part")) and not C:FindFirstChild("Ignored") then
			return C
		end
	end
end
function GetNearestChest()
	local V, Y, H = next, game:GetService("CollectionService"):GetTagged("_ChestTagged")
	local C, J, F = 1 / 0
	for q, c in V, Y, H do
		if not c:GetAttribute("IsDisabled") and not c:FindFirstChild("Ignored") then
			q = t:DistanceFromCharacter(c.Position)
			if q < C then
				C, J, F = q, i, c
			end
		end
	end
	return F
end
getgenv().DetectRaidCastle = false
getgenv().ValueCollectChestSpawnGod = 0
task.spawn(function()
	while task.wait() do
		local V, V = pcall(function()
			if Settings["Auto New World"] then
				if game.PlaceId == getgenv().CheckPlaceId3 and t.Data.Level.Value >= 700 then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Auto New World")
					if
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0
					then
						if game.Workspace.Map.Ice.Door.CanCollide then
							if not t.Character:FindFirstChild("Key") and not t.Backpack:FindFirstChild("Key") then
								if
									(
										CFrame.new(4852.2895507813, 5.651451587677, 718.53070068359).Position
										- t.Character.HumanoidRootPart.Position
									).magnitude < 5
								then
									game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
										"DressrosaQuestProgress",
										"Detective"
									)
									equiptool("Key")
								else
									toTarget(CFrame.new(4852.2895507813, 5.651451587677, 718.53070068359))
								end
							else
								equiptool("Key")
								if t.Character:FindFirstChild("Key") then
									toTarget(game.Workspace.Map.Ice.Door.CFrame)
								end
							end
						elseif CheckNameBoss("Ice Admiral") then
							local Y = CheckNameBoss("Ice Admiral")
							repeat
								task.wait()
								sizepart(Y)
								if Settings["Select Weapon"] == "Blox Fruit" then
									toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end
								ClickM1(Y)
								UsedualFlock()
							until not Y or not Y.Parent or Y.Humanoid.Health == 0 or not Settings["Auto New World"]
						end
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
					end
					return
				end
			end
			if
				Settings["Collect Chest When Server Spawn God's Chalice or Fist of Darkness"]
				and getgenv().GoCollectChest
			then
				StackFarm = false
				StackFarmOther = false
				NoijoOwner("Collect Chest When Server Spawn God's Chalice or Fist of Darkness")
				if getgenv().ValueCollectChestSpawnGod >= 10 then
					getgenv().GoCollectChest = false
					getgenv().ValueCollectChestSpawnGod = 0
				end
				local Y = GetNearestChest()
				if Y then
					getgenv().ValueCollectChestSpawnGod = getgenv().ValueCollectChestSpawnGod + 1
					local H
					repeat
						task.wait()
						if
							(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Y.Position).Magnitude <= 5
						then
							if not H then
								H = (tick())
							elseif tick() - H >= 5 then
								Instance.new("IntValue", Y).Name = "Ignored"
								wait(0.1)
							end
							if not Settings["Use Method Teleport"] then
								game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
								wait()
								game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
							end
							TweenManager.CancelCurrent()
						end
						if Settings["Use Method Teleport"] then
							t.Character.HumanoidRootPart.CFrame = Y.CFrame
							TweenManager.CancelCurrent()
						else
							toTarget(Y.CFrame, true)
						end
					until not Y
						or not Y.Parent
						or not Settings["Collect Chest When Server Spawn God's Chalice or Fist of Darkness"]
						or (Y:GetAttribute("IsDisabled"))
						or (Y:FindFirstChild("Ignored"))
						or not Y:FindFirstChild("TouchInterest")
					return
				else
					local Y = PathFindChest()
					if Y then
						toTarget(Y.Part.CFrame)
						if
							(Y.Part.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
							or (GetNearestChest())
						then
							Instance.new("IntValue", Y).Name = "Ignored"
						end
					else
						for Y, Y in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
							if Y:FindFirstChild("Ignored") then
								Y:FindFirstChild("Ignored"):Destroy()
							end
						end
					end
				end
			end
			if game.PlaceId == getgenv().CheckPlaceId2 and Settings["Auto Third World"] then
				if StopThirdSea() then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Auto Third World")
					SeaThird()
					return
				end
			end
			if Settings["Attack Darkbeard"] then
				local Y = CheckNameBoss("Darkbeard")
				if Y then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Attack Darkbeard")
					repeat
						task.wait()
						sizepart(Y)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						ClickM1(Y)
						UsedualFlock()
					until not IsMobAlive(Y) or not Settings["Attack Darkbeard"]
					return
				else
					if Settings["Summon Darkbeard"] and (DetectItemPlr("Fist of Darkness")) then
						StackFarm = false
						StackFarmOther = false
						NoijoOwner("Summon Darkbeard")
						if
							(
								game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.Position
								- t.Character.HumanoidRootPart.Position
							).Magnitude <= 5
						then
							equiptool("Fist of Darkness")
							firetouchinterest(
								game.Players.LocalPlayer.Character["Fist of Darkness"].Handle,
								game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
								0
							)
							firetouchinterest(
								game.Players.LocalPlayer.Character["Fist of Darkness"].Handle,
								game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
								1
							)
							firetouchinterest(
								t.Character.HumanoidRootPart,
								game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
								0
							)
							firetouchinterest(
								t.Character.HumanoidRootPart,
								game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
								1
							)
						else
							toTarget(game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.CFrame)
						end
						return
					end
					spawn(function()
						if Settings["Hop Find Darkbeard"] then
							SpecialHop("Darkbeard")
						end
					end)
				end
			end
			if Settings["Attack Rip Indra"] then
				local Y = CheckNameBoss("rip_indra True Form")
				if Y then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Attack Rip Indra")
					repeat
						task.wait()
						sizepart(Y)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						ClickM1(Y)
						UsedualFlock()
					until not IsMobAlive(Y) or not Settings["Attack Rip Indra"]
					return
				end
			end
			if Settings["Auto Touch Pad Haki"] and Settings["Auto Summon Rip Indra"] then
				if DetectItemPlr("God's Chalice") then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Auto Touch Pad Haki")
					if
						not game:GetService("Workspace").Map:FindFirstChild("Boat Castle")
						or not game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle
							:FindFirstChildOfClass("Part")
					then
						toTarget(CFrame.new(-5500, 314, -2855))
						return
					end
					if DetectButtons() then
						TouchPadHaki()
						return
					elseif not DetectButtons() then
						equiptool("God's Chalice")
						toTarget(game:GetService("Workspace").Map["Boat Castle"].Summoner.Detection.CFrame)
						return
					end
				end
			elseif Settings["Auto Touch Pad Haki"] then
				StackFarm = false
				StackFarmOther = false
				NoijoOwner("Auto Touch Pad Haki")
				if
					not game:GetService("Workspace").Map:FindFirstChild("Boat Castle")
					or not game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:FindFirstChildOfClass("Part")
				then
					toTarget(CFrame.new(-5500, 314, -2855))
					return
				end
				if DetectButtons() then
					TouchPadHaki()
				end
				return
			elseif Settings["Auto Summon Rip Indra"] and (DetectItemPlr("God's Chalice")) then
				StackFarm = false
				StackFarmOther = false
				NoijoOwner("Auto Summon Rip Indra")
				if
					not game:GetService("Workspace").Map:FindFirstChild("Boat Castle")
					or not game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:FindFirstChildOfClass("Part")
				then
					toTarget(CFrame.new(-5500, 314, -2855))
					return
				end
				equiptool("God's Chalice")
				toTarget(game:GetService("Workspace").Map["Boat Castle"].Summoner.Detection.CFrame)
				return
			end
			if Settings["Attack Soul Reaper"] then
				local Y = CheckNameBoss("Soul Reaper")
				if Y then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Attack Soul Reaper")
					repeat
						task.wait()
						sizepart(Y)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						ClickM1(Y)
						UsedualFlock()
					until not IsMobAlive(Y) or not Settings["Attack Soul Reaper"]
					return
				else
					StackFarm = false
					StackFarmOther = false
					NoijoOwner(Settings["Summon Soul Reaper"] and "Summon Soul Reaper" or "Attack Soul Reaper")
					if Settings["Summon Soul Reaper"] and (DetectItemPlr("Hallow Essence")) then
						if
							not game:GetService("Workspace").Map:FindFirstChild("Haunted Castle")
							or not game:GetService("Workspace").Map["Haunted Castle"].Summoner
								:FindFirstChild("Detection")
						then
							toTarget((CFrame.new(-9513.466796875, 142.09776306152344, 5528.83740234375)))
							return
						end
						if
							(
								t.Character.HumanoidRootPart.Position
								- game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position
							).Magnitude > 8
						then
							toTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
						else
							equiptool("Hallow Essence", true)
						end
						return
					end
				end
			end
			if Settings["Attack Dough King"] then
				local Y = CheckNameBoss("Dough King")
				if Y then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Attack Dough King")
					repeat
						task.wait()
						sizepart(Y)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						ClickM1(Y)
						UsedualFlock()
					until not IsMobAlive(Y) or not Settings["Attack Dough King"]
					return
				else
					spawn(function()
						if Settings["Hop Find Dough King"] then
							SpecialHop("Dough King")
						end
					end)
					if Settings["Summon Dough King"] then
						if not DetectItemPlr("Sweet Chalice") then
							if
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
								== "Where are the items?"
							then
								if not CheckCountItem("Conjured Cocoa", 10) then
									StackFarm = false
									StackFarmOther = false
									NoijoOwner("Summon Dough King")
									if not DetectMob(P) then
										if typeof(P) == "table" then
											if #N >= #P then
												N = {}
												return
											end
											local Y = DetectPartSpawnMob(DetectNameTablePart(P))
											if Y then
												table.insert(N, DetectNameTablePart(P))
												repeat
													wait()
													toTarget(Y.CFrame * CFrame.new(0, 60, 0))
												until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude
														<= 100
													or (DetectMob(P))
													or not Settings["Attack Dough King"]
												wait(1)
											end
										else
											local Y = DetectPartSpawnMob(P, true)
											if Y then
												Instance.new("IntValue", Y).Name = "Ignored"
												repeat
													wait()
													toTarget(Y.CFrame * CFrame.new(0, 60, 0))
												until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude
														<= 100
													or (DetectMob(P))
													or not Settings["Attack Dough King"]
												wait(1)
											else
												DeleteIgnoredMobSpawn()
											end
										end
									else
										local Y = DetectMob(P)
										repeat
											task.wait()
											sizepart(Y)
											BringMob(Y)
											UsedualFlock()
											ClickM1(Y)
											if Settings["Select Weapon"] == "Blox Fruit" then
												toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
											else
												toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
											end
										until not Y
											or not Y.Parent
											or Y.Humanoid.Health == 0
											or not Settings["Attack Dough King"]
									end
								elseif not DetectItemPlr("God's Chalice") then
									local P = DetectEliteHunter()
									if P then
										StackFarm = false
										StackFarmOther = false
										NoijoOwner("Summon Dough King")
										if not EnsureEliteQuest(P.Name) then
											task.wait()
										else
											repeat
												task.wait()
												sizepart(P)
												if Settings["Select Weapon"] == "Blox Fruit" then
													toTarget(P.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
												else
													toTarget(P.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
												end
												ClickM1(P)
												UsedualFlock()
											until not P
												or not P.Parent
												or P.Humanoid.Health == 0
												or not Settings["Attack Dough King"]
										end
										return
									else
										A.CreateNoti({
											Title = "Noijo Hub",
											Desc = "Waiting Elite Hunter",
											ShowTime = 5,
										})
										wait(5)
									end
								end
							end
						elseif not DetectMob(y) then
							if typeof(y) == "table" then
								if #N >= #y then
									N = {}
									return
								end
								local P = DetectPartSpawnMob(DetectNameTablePart(y))
								if P then
									table.insert(N, DetectNameTablePart(y))
									repeat
										wait()
										toTarget(P.CFrame * CFrame.new(0, 60, 0))
									until (P.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
										or (DetectMob(y))
										or not Settings["Attack Dough King"]
									wait(1)
								end
							else
								local P = DetectPartSpawnMob(y, true)
								if P then
									Instance.new("IntValue", P).Name = "Ignored"
									repeat
										wait()
										toTarget(P.CFrame * CFrame.new(0, 60, 0))
									until (P.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
										or (DetectMob(y))
										or not Settings["Attack Dough King"]
									wait(1)
								else
									DeleteIgnoredMobSpawn()
								end
							end
						else
							local P = DetectMob(y)
							repeat
								task.wait()
								sizepart(P)
								BringMob(P)
								UsedualFlock()
								ClickM1(P)
								if Settings["Select Weapon"] == "Blox Fruit" then
									toTarget(P.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									toTarget(P.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end
							until not P or not P.Parent or P.Humanoid.Health == 0 or not Settings["Attack Dough King"]
						end
					end
				end
			end
			if Settings["Auto Elite Hunter"] then
				local y = DetectEliteHunter()
				if y then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Auto Elite Hunter")
					if not EnsureEliteQuest(y.Name) then
						task.wait()
					else
						repeat
							task.wait()
							sizepart(y)
							if Settings["Select Weapon"] == "Blox Fruit" then
								toTarget(y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								toTarget(y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end
							ClickM1(y)
							UsedualFlock()
						until not IsMobAlive(y) or not Settings["Auto Elite Hunter"]
						if getgenv().QuestTrainer and getgenv().QuestTrainer.CountKillMob then
							getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
						end
					end
					return
				elseif Settings["Hop Server Elite Hunter"] then
					if not DetectItemPlr("God's Chalice") then
						HopServer()
					else
						toTarget(CFrame.new(-12463.8740234375, 374.9144592285156, -7523.77392578125))
					end
				end
			end
			if Settings["Auto Factory"] then
				CoreBoss = CheckNameBoss("Core")
				if CoreBoss then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Auto Factory")
					repeat
						task.wait()
						toTarget(CoreBoss.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
						ClickM1(CoreBoss)
						UsedualFlock()
					until not IsMobAlive(CoreBoss) or not Settings["Auto Factory"]
					return
				end
			end
			if Settings["Auto Pirate Raid"] then
				local y = GetPirateRaid() or (GetPirateRaid(true))
				if y then
					getgenv().DetectRaidCastle = true
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Auto Pirate Raid")
					local P = Settings["Select Weapon"] == "Blox Fruit" and (CFrame.new(-7, 20, 0))
						or (CFrame.new(7, 20, 0))
					repeat
						task.wait()
						UsedualFlock()
						sizepart(y)
						ClickM1(y)
						toTarget(y.HumanoidRootPart.CFrame * P)
					until not IsMobAlive(y) or not Settings["Auto Pirate Raid"]
				elseif getgenv().DetectRaidCastle then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Auto Pirate Raid")
					local y, P = os.clock(), false
					repeat
						task.wait()
						P = (function() if GetPirateRaid() or (GetPirateRaid(true)) then return true else return P end end)()
					until os.clock() - y >= 10 or P
					if not P then
						getgenv().DetectRaidCastle = false
					end
				end
			end
			if Settings["Teleport To Fruit"] then
				local y = GetPathFruit()
				if y then
					StackFarm = false
					StackFarmOther = false
					NoijoOwner("Teleport To Fruit")
					if (y.Handle.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 5 then
						getgenv().noclip = false
						game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
						wait()
						game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
					else
						toTarget(y.Handle.CFrame, true)
					end
					return
				elseif Settings["Teleport To Fruit [ Hop Server ]"] then
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
		if V then
			print(V)
		end
	end
end)
FarmotherMain = Main.CreatePage({ Page_Name = "Farming Other", Page_Title = "Farming Other" })
-- ===== Secret Quest (39 hidden quests) - thay thế Event Easter =====

-- ========== SHIMS (map Vxeze -> BananaCat) ==========
do
	localPlayer = t or game.Players.LocalPlayer

	-- Movement
	ToTarget = ToTarget or toTarget or getgenv().toTarget or function(cf)
		if type(toTarget) == "function" then
			return toTarget(cf)
		end
		if type(getgenv().BackupTween) == "function" then
			return getgenv().BackupTween(cf)
		end
	end

	-- Combat
	SizePart = SizePart or sizepart
	if type(getgenv().ClickM1) == "function" then
		ClickM1 = getgenv().ClickM1
	end
	EquipTool = EquipTool or equiptool
	if type(UsedualFlock) ~= "function" and type(getgenv().UsedualFlock) == "function" then
		UsedualFlock = getgenv().UsedualFlock
	end

	-- Sea 1 gate (BananaCat: CheckPlaceId3 = Sea1)
	Place_Id = Place_Id or {}
	Place_Id.sea1 = Place_Id.sea1 or function()
		return game.PlaceId == (getgenv().CheckPlaceId3 or 2753915549)
			or game.PlaceId == 2753915549
			or game.PlaceId == 85211729168715
	end
	Place_Id.sea2 = Place_Id.sea2 or function()
		return game.PlaceId == (getgenv().CheckPlaceId2 or 4442272183)
	end
	Place_Id.sea3 = Place_Id.sea3 or function()
		return game.PlaceId == (getgenv().CheckPlaceId or 7449423635)
	end

	-- Notify
	VxezeNotify = VxezeNotify or function(title, desc, kind, extra)
		local text = tostring(title or "")
		if desc and tostring(desc) ~= "" then
			text = text .. ": " .. tostring(desc)
		end
		if A and A.CreateNoti then
			pcall(function()
				A.CreateNoti({ Title = "BananaCat - Secret Quest", Desc = text, ShowTime = (extra and extra.Duration) or 5 })
			end)
		else
			pcall(function()
				require(game:GetService("ReplicatedStorage").Notification)
					.new("<Color=Yellow>" .. text .. "<Color=/>")
					:Display()
			end)
		end
	end

	-- Inventory list (BananaCat uses local B() in some scopes; rebuild if missing)
	if type(GetInventoryItems) ~= "function" then
		GetInventoryItems = function()
			local ok, list = pcall(function()
				local IRS = require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService"))
				local IC = require(game:GetService("ReplicatedStorage"):WaitForChild("ItemConfig"))
				local out = {}
				local keys = IRS.KEYS
				for _, item in IRS:GetItems(keys.QUANTITY) do
					if item.Value and item.Value > 0 then
						local ok2, cfg = pcall(function()
							return IC.match(item.ItemId):unwrap()
						end)
						if ok2 and cfg and cfg.Display then
							local cat = cfg.Display.Category
							local storage = cfg.Index and cfg.Index.StorageKey
							local name = (cat == "Blox Fruit") and (storage or cfg.Display.Name)
								or (cfg.Display.Name or storage or ("ItemId_" .. item.ItemId))
							local mastery = IRS:ReadItem(keys.MASTERY, item.ItemId, item.NetworkedUID) or 0
							table.insert(out, {
								Name = name,
								Type = cat,
								Count = item.Value,
								Mastery = mastery,
								ItemId = item.ItemId,
								UID = item.NetworkedUID,
							})
						end
					end
				end
				return out
			end)
			return ok and list or {}
		end
	end

	-- Tween helpers
	StopTweenNow = StopTweenNow or function()
		pcall(function()
			if TweenManager and TweenManager.CancelCurrent then
				TweenManager.CancelCurrent()
			elseif TweenManager and TweenManager.CancelTweenOnly then
				TweenManager.CancelTweenOnly()
			end
		end)
	end

	ReleaseTweenPhysics = ReleaseTweenPhysics or function()
		pcall(function()
			local c = localPlayer.Character
			local hrp = c and c:FindFirstChild("HumanoidRootPart")
			if hrp then
				hrp.Anchored = false
				local ff = hrp:FindFirstChild("FloatForce")
				if ff then
					ff:Destroy()
				end
			end
		end)
	end

	-- Soft require / gate helper used by original toggle
	EnforceGate = EnforceGate or function(_, name, ok, msg)
		if not ok then
			SaveSettings(name, false)
			VxezeNotify(name, msg or "Cannot enable", "warning")
			return false
		end
		return true
	end

	-- Log helper
	VxezeLog = VxezeLog or function(a, b)
		print("[SecretQuest]", tostring(a), tostring(b))
	end

	-- ReplicatedStorage alias if missing
	ReplicatedStorage = ReplicatedStorage or game:GetService("ReplicatedStorage")

	-- Helper thiếu trong BananaCat (lấy từ Vxeze)
	VirtualInputManager = VirtualInputManager or game:GetService("VirtualInputManager")
	NoclipChanged = NoclipChanged or setmetatable({}, { __mode = "k" })

	FormatMagnetTime = FormatMagnetTime or function(n)
		n = math.floor(tonumber(n) or 0)
		return string.format("%02d:%02d", math.floor(n / 60), n % 60)
	end

	SeaOnly = SeaOnly or function(label, title, seas)
		local cur = Place_Id.sea1() and 1 or Place_Id.sea2() and 2 or Place_Id.sea3() and 3 or 0
		for _, s in ipairs(seas) do
			if s == cur then
				return true
			end
		end
		local names = {}
		for _, s in ipairs(seas) do
			table.insert(names, "Sea " .. s)
		end
		if label and label.SetText then
			label.SetText(title .. " : Not in " .. (cur > 0 and ("Sea " .. cur) or "Unknown") .. ", go to " .. table.concat(names, " or "))
		end
		return false
	end
end

-- ========== UI: đầu tab Farming Other ==========

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
				done = done + (1)
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

		while true do local __brk = false repeat 
			task.wait(0.1)
			tbl3.LastCall = tick()
			TweenHoldUntil = tick() + 1
			if not ((humanoidRootPart.Position - arg3).Magnitude < 6 or tick() - now > 6 or not humanoidRootPart.Parent) then
				break
			end
			__brk = true break
		until true if __brk then break end end

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

		while true do local __brk = false repeat 
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
						__brk = true break
					else
						break
					end
				end
			else
				flag = tick() - now > 45 or not Settings["Auto Secret Quest"]

				if flag then
					__brk = true break
				else
					break
				end
			end

			__brk = true break
		until true if __brk then break end end

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

		while true do local __brk = false repeat 
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
					n = n + (1)
				end
			end

			local flag = arg2 and arg2() or n > 6

			if not flag then
				flag = tick() - now > (arg3 or 15)
			end

			if not flag then
				break
			end
			__brk = true break
		until true if __brk then break end end

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
				n = n + (tonumber(v9.Count) or 1)
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

		while true do local __brk = false repeat 
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
				break
			end
			__brk = true break
		until true if __brk then break end end

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

	GetHiddenFarmCFrame = function(c)local n,L=c.HumanoidRootPart,Settings["Select Weapon"]=="Blox Fruit";local U=HiddenEvent.farmHeight or L and(getgenv().YPosFruit or 20)or 20;return n.CFrame*CFrame.new(L and-7 or 7,(function() if IsHiddenDodging() then return U+(IsHiddenBoss(c)and 40 or 25) else return U end end)(),0);end

	KillHiddenEnemy = function(fighting)
		local now = tick()
		local v6 = IsHiddenBoss(fighting)
		local n = v6 and 180 or 45
		HiddenEvent.fighting = fighting
		WatchHiddenEnemy(fighting)

		while true do local __brk = false repeat 
			task.wait()

			if not fighting:FindFirstChild("HumanoidRootPart") then
				__brk = true break
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
					break
				end
				__brk = true break
			end
		until true if __brk then break end end

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

		while true do local __brk = false repeat 
			if tick() - now < 20 and n < #arg2 then
				task.wait(0.4)
				local v6 = fn()

				if v6 then
					local options2 = v6._options or {}

					if #options2 == 0 then
						pcall(DialogueController.advance)
						break
					else
						local v7 = nil

						for _, v8 in ipairs(options2) do
							if table.concat(v8._text or {}, " ") == arg2[n + 1] then
								v7 = v8
							end
						end

						if v7 then
							n = n + (1)
							DialogueController.select(v7)
							task.wait(1)
							break
						end
					end
				else
					break
				end
			end

			__brk = true break
		until true if __brk then break end end

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

		while Settings["Auto Secret Quest"] do repeat 
			local str2 = "/4: watching " .. #response.Manifest .. " ships"
			SetHiddenStep("Lookout round " .. tostring(response.Round) .. str2)
			local now = tick()

			while true do local __brk = false repeat 
				response2 = arg:InvokeServer("ObservationFinished", response.Token)
				local v6 = nil

				if type(response2) ~= "table" then
					response2 = v6
					__brk = true break
				else
					if response2.Ready == false then
						task.wait(math.clamp(tonumber(response2.RetryAfter) or 1, 0.2, 5))
						response2 = nil
						if not (tick() - now > 120) then
							break
						end
					end

					__brk = true break
				end
			until true if __brk then break end end

			if not response2 then
				arg:InvokeServer("AbortAttempt", response.Token)
				return "Lookout observation failed, retrying", true
			end
			local n = 0

			for _, v6 in ipairs(response.Manifest) do
				if v6.Boat == response2.TargetBoat and v6.FlagColor == response2.TargetFlagColor then
					n = n + (1)
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
				break
			end

			if type(response3.FinaleToken) == "string" then
				arg:InvokeServer("FinishFinale", response3.FinaleToken)
			end

			HiddenModules.Guide.interactQuestGiver("TravelDressrosa")
			HiddenEvent.checked = 0
			HiddenNotify("Lookout duty complete", nil, "success")
			return "Lookout duty complete"
		until true end

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

		for k, v6 in pairs(tbl9) do local __brk = false repeat 
			if not (not Settings["Auto Secret Quest"] or not fn2(v6.Position + Vector3.new(0, 3, 0))) then
				SetHiddenStep("Roll snowball " .. n + 1 .. "/3")
				arg:FireServer("GrabSnowball", k)
				n = n + (1)
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
				break
			end

			__brk = true break
		until true if __brk then break end end

		local now = tick()

		while true do local __brk = false repeat 
			task.wait(0.5)
			if not (flag or tick() - now > 8) then
				break
			end
			__brk = true break
		until true if __brk then break end end

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

			while true do local __brk = false repeat 
				task.wait(0.3)
				v6 = FindHiddenFruitTool()
				if not (v6 or tick() - now > 4) then
					break
				end
				__brk = true break
			until true if __brk then break end end

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

		while true do local __brk = false repeat 
			task.wait(0.3)
			if not (localPlayer.Data.DevilFruit.Value ~= "" or tick() - now > 4) then
				break
			end
			__brk = true break
		until true if __brk then break end end

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

				while true do local __brk = false repeat 
					task.wait()

					if v7 and v7.Parent ~= localPlayer.Character then
						pcall(localPlayer.Character.Humanoid.EquipTool, localPlayer.Character.Humanoid, v7)
					end

					if not (workspace:GetServerTimeNow() >= n - 0.08 or not Settings["Auto Secret Quest"]) then
						break
					end
					__brk = true break
				until true if __brk then break end end

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
					str2 = str2 .. (" " .. arg)
				elseif type(arg) == "table" then
					for _, v6 in pairs(arg) do
						if type(v6) == "string" then
							str2 = str2 .. (" " .. v6)
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

		for _, v7 in ipairs(HiddenQuests) do repeat 
			if arg["Sea1/" .. v7.Island .. "/" .. v7.Name] ~= true then
				if v7.BossNames then
					if IsHiddenBossHinted(v6, v7.HintIsland or v7.Island, v7.BossNames) then
						return true
					end
					break
				end

				if v6.Island == (v7.HintIsland or v7.Island) then
					return true
				end
			end
		until true end

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
		-- Không queue_on_teleport lần 2 (tránh script chạy 2 lần sau teleport / load nhầm BF-VxezeHub.lua).
		-- Việc tự chạy lại sau hop đã do toggle "Auto Load Script" của Banana đảm nhiệm.
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

				for _, v13 in ipairs(tbl11) do local __brk = false repeat 
					if not v11 then
						if v13 <= #tbl10 and not table.find(leverPuzzle.known, v13) and not leverPuzzle.wrong[#leverPuzzle.known + 1 .. ":" .. v13] then
							v11 = v13
						end

						break
					end

					__brk = true break
				until true if __brk then break end end
			end

			if not v11 then
				HiddenEvent.leverPuzzle = nil
				return
			end
			local vector = Vector3.zero

			for _, v12 in ipairs(tbl10) do
				vector = vector + (v12.Position / #tbl10)
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

						while true do local __brk = false repeat 
							task.wait(0.3)
							if not (cranes and cranes:GetAttribute("SewerEntranceLifted") or tick() - now > 5) then
								break
							end
							__brk = true break
						until true if __brk then break end end

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
						vector = vector + (footprint.Position)
						n = n + (1)
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
					-- còn lại = giây server báo - thời gian đã trôi qua kể từ lúc hỏi
					local n = progress.SecondsRemaining - (tick() - time_)

					if n > 0 then
						-- nhớ giờ Captain sẵn sàng để quay lại làm ngay khi tới giờ
						HiddenEvent.readyAt = HiddenEvent.readyAt or {}
						HiddenEvent.readyAt.Lookout = tick() + n
					end

					-- chưa tới giờ => skip để làm quest khác (không đứng chờ)
					return "Captain needs time (" .. FormatMagnetTime(math.max(0, n)) .. ")", n > 0
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
		local readyAt = HiddenEvent.readyAt and HiddenEvent.readyAt[arg.Name]
		if readyAt then
			-- biết chính xác bao giờ làm được -> chỉ skip tới lúc đó
			return math.max(readyAt - tick(), 5)
		end
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

	-- Quest đang bị skip (chờ) mà đã làm được => gỡ skip + đẩy lên đầu hàng đợi
	HiddenWakeBoost = function(name)
		HiddenEvent.readyBoost = HiddenEvent.readyBoost or {}
		return tick() < (HiddenEvent.readyBoost[name] or 0)
	end

	WakeHiddenQuests = function(progress, hint)
		HiddenEvent.waiting = HiddenEvent.waiting or {}
		HiddenEvent.readyBoost = HiddenEvent.readyBoost or {}
		HiddenEvent.readyAt = HiddenEvent.readyAt or {}
		HiddenEvent.wokeMoment = HiddenEvent.wokeMoment or {}
		HiddenEvent.wakeCheck = HiddenEvent.wakeCheck or {}

		local function wake(quest, why)
			if HiddenEvent.current == quest.Name then
				return
			end
			HiddenEvent.skipped[quest.Name] = nil
			HiddenEvent.readyAt[quest.Name] = nil
			HiddenEvent.readyBoost[quest.Name] = tick() + 300
			HiddenEvent.wakeCheck[quest.Name] = tick() + 60
			HiddenNotify(quest.Name .. " is ready (" .. why .. "), going back", quest.Name .. "wake", "found")
		end

		for _, quest in ipairs(HiddenQuests) do
			local name = quest.Name
			local key = "Sea1/" .. quest.Island .. "/" .. name
			local skipped = (HiddenEvent.skipped[name] or 0) > tick()
			local blocked = HiddenEvent.waiting[name] ~= nil or HiddenEvent.readyAt[name] ~= nil

			if progress[key] ~= true and skipped and blocked and tick() >= (HiddenEvent.wakeCheck[name] or 0) then
				-- (a) tới giờ hẹn (vd Lookout: Captain hết cooldown)
				local readyAt = HiddenEvent.readyAt[name]
				if readyAt and tick() >= readyAt then
					wake(quest, "timer done")
				else
					-- (b) moment của quest vừa load
					local moment = GetHiddenMoment(name)
					local up = moment and (not quest.HintIsland or moment.Active)
					if up and HiddenEvent.wokeMoment[name] ~= moment then
						HiddenEvent.wokeMoment[name] = moment
						wake(quest, "quest appeared")
					elseif not up then
						HiddenEvent.wokeMoment[name] = nil
						-- (c) điều kiện Precheck đã thoả (đêm, boss hint, ...)
						if quest.Precheck and not readyAt and tick() >= (HiddenEvent.precheckAt and HiddenEvent.precheckAt[name] or 0) then
							HiddenEvent.precheckAt = HiddenEvent.precheckAt or {}
							HiddenEvent.precheckAt[name] = tick() + 10
							local ok, pass = pcall(quest.Precheck, hint)
							if ok and pass == true then
								wake(quest, "conditions met")
							end
						end
					end
				end
			end
		end
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

		pcall(WakeHiddenQuests, v6, v7)

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
				local readyBoost = HiddenWakeBoost(v8.Name)

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

				if readyBoost then
					-- quest vừa hết chờ: ưu tiên làm trước (sau Rescue Hasan)
					tbl10[v8] = -1.5
				elseif hintIsland then
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
						n = n * (0.0001)
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

		for _, v8 in ipairs(tbl9) do repeat 
			local str2 = "Sea1/" .. v8.Island .. "/" .. v8.Name

			if v6[str2] ~= true then
				n = n + (1)
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
					break
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
					if HiddenEvent.readyAt then
						HiddenEvent.readyAt[v8.Name] = nil
					end
				end

				return
			end
		until true end

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
					n = n + (1)
					doneCount = doneCount + (v7 == true and 1 or 0)
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


-- ========== Noijo Hub UI toggles ==========
HiddenEventSection.CreateToggle({
	Title = "Hop Server For Secret Quest",
	Desc = "Hop khi không có quest / giờ chết",
	Default = Settings["Hop Server For Secret Quest"] or false,
}, function(v)
	SaveSettings("Hop Server For Secret Quest", v)
end)

-- Mirror Vxeze setting key used inside AutoHiddenEvent hop logic
if Settings["Hidden Hop Dead Hour"] == nil then
	Settings["Hidden Hop Dead Hour"] = true
end

HiddenEventSection.CreateToggle({
	Title = "Auto Secret Quest",
	Desc = "Auto complete 39 Sea 1 secret quests (Hidden Event)",
	Default = Settings["Auto Secret Quest"] or false,
}, function(arg)
	if arg and not Place_Id.sea1() then
		SaveSettings("Auto Secret Quest", false)
		VxezeNotify("Auto Secret Quest", "Only works in Sea 1", "warning")
		if getgenv().ToggleSecretQuest and getgenv().ToggleSecretQuest.SetStage then
			pcall(function()
				getgenv().ToggleSecretQuest:SetStage(false)
			end)
		end
		return
	end

	SaveSettings("Auto Secret Quest", arg)
	getgenv().ToggleSecretQuest = {
		SetStage = function(_, on)
			SaveSettings("Auto Secret Quest", on and true or false)
		end,
	}

	if not arg then
		HiddenEvent.running = false
		pcall(HiddenRelease)
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

	if type(HiddenDialogueLoop) == "function" then
		task.spawn(HiddenDialogueLoop)
	end

	task.spawn(function()
		while Settings["Auto Secret Quest"] and task.wait(0.15) do
			local ok, result
			-- Tôn trọng StackFarmOther của BananaCat (ưu tiên chuỗi farm khác)
			local stackOk = (StackFarmOther ~= false) and (getgenv().StackFarmOther ~= false)
			if stackOk then
				ok, result = pcall(AutoHiddenEvent)
			else
				SetHiddenStep("Paused while another feature is running")
				ok = true
				result = nil
			end

			if not ok then
				print("[SecretQuest]", result)
				HiddenEvent.lastError = tostring(result)
				HiddenEvent.errors = (HiddenEvent.errors or 0) + 1
				if HiddenEvent.errors % 20 == 1 then
					HiddenNotify("Error: " .. tostring(result):sub(1, 120), "error", "error")
				end
			end

			pcall(function()
				if CheckHiddenStall then
					CheckHiddenStall()
				end
			end)

			local anchored = HiddenEvent.anchored
			if anchored then
				anchored = tick() - (HiddenEvent.holdTime or 0) > 0.6
			end
			if anchored and HiddenRelease then
				HiddenRelease()
			end

			local str2 = tostring(HiddenEvent.step or "")
			if str2:find("^Waiting") or str2:find(" stirs on ") or str2 == "Idle" then
				task.wait(0.6)
			end
		end

		pcall(function()
			if HiddenRelease then
				HiddenRelease()
			end
		end)
		HiddenEvent.running = false
	end)
end)

print("[BananaCat] Secret Quest (39) module loaded — section ở đầu Farming Other")
FishingSection = FarmotherMain.CreateSection("Fishing")
FishingSection.CreateToggle(
	{ Title = "Change Size Reel", Desc = nil, Default = Settings["Change Size Reel"] or false },
	function(V)
		if V then
			spawn(function()
				while Settings["Change Size Reel"] and (task.wait()) do
					pcall(function()
						if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Fishing_Reeling") then
							game:GetService("Players").LocalPlayer.PlayerGui.Fishing_Reeling.Minigame.Container.ReelZone.Size =
								UDim2.new(0.98, 0, 0.13, 0)
						end
					end)
				end
			end)
		end
		SaveSettings("Change Size Reel", V)
	end
)
FishingSection.CreateToggle(
	{
		Title = "Auto Slap Battle",
		Desc = "There\226\128\153s still a chance of a misclick",
		Default = Settings["Auto Slap Battle"] or false,
	},
	function(V)
		if V then
			spawn(function()
				while Settings["Auto Slap Battle"] and (task.wait()) do
					pcall(function()
						if not game:GetService("Players").LocalPlayer:FindFirstChild("RemoteEvent") then
							repeat
								wait()
							until game:GetService("Players").LocalPlayer:FindFirstChild("RemoteEvent")
							local y, P = game:GetService("Players").LocalPlayer.RemoteEvent
							y.OnClientEvent:Connect(function(Y, H, C, J, F, F, F, q)
								if Y == "startBar" and J == game.Players.LocalPlayer then
									local J, q = 0.96 / (C * 0.5), 0.2 / (C * 1.5)
									if P then
										P:Disconnect()
									end
									P = game:GetService("RunService").Heartbeat:Connect(function()
										local c = workspace:GetServerTimeNow()
										local D = 0.02 + (c - H) % C * J
										D = (function() if D >= 0.98 then return 0.98 - (D - 0.98) else return D end end)()
										local J
										if F then
											J = 0.5
										else
											J = 0.4 + (c - H) % (C * 3) * q
											J = (function() if J >= 0.6 then return 0.6 - (J - 0.6) else return J end end)()
										end
										if math.abs(D - J) < 0.03 then
											y:FireServer("Jump", workspace:GetServerTimeNow())
										end
									end)
								elseif Y == "killBar" then
									if P then
										P:Disconnect()
										P = nil
									end
								end
							end)
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Slap Battle", V)
	end
)
_, R = Settings["Save Position Fishing"], "Position : "
if _ then
	I = Vector3.new(_.posX, _.posY, _.posZ)
	R = (
		string.format(
			"Position : %.2f, %.2f, %.2f | Angle(deg) : %.1f, %.1f, %.1f",
			I.X,
			I.Y,
			I.Z,
			math.deg(_.rx),
			math.deg(_.ry),
			math.deg(_.rz)
		)
	)
end
LocalPositionPlantSeed = FishingSection.CreateLabel({ Title = R })
FishingSection.CreateButton({ Title = "Save Position Fishing" }, function()
	local _ = t.Character and (t.Character:FindFirstChild("HumanoidRootPart"))
	if not _ then
		return
	end
	local V = _.CFrame
	local _, y, P, Y = V.Position, V:ToOrientation()
	LocalPositionPlantSeed.SetText(
		string.format(
			"Position : %.2f, %.2f, %.2f | Angle(deg) : %.1f, %.1f, %.1f",
			_.X,
			_.Y,
			_.Z,
			math.deg(y),
			math.deg(P),
			math.deg(Y)
		)
	)
	SaveSettings("Save Position Fishing", { posX = _.X, posY = _.Y, posZ = _.Z, rx = y, ry = P, rz = Y })
end)
a = {}
for _, V in next, require(game:GetService("ReplicatedStorage").FishReplicated.BaitData).Types, nil do
	table.insert(a, _)
end
FishingSection.CreateDropdown(
	{ Title = "Select Bait", List = a, Search = true, Selected = false, Default = Settings["Select Bait"] or nil },
	function(_)
		SaveSettings("Select Bait", _)
	end
)
local _, V, y, P, Y, H =
	game.ReplicatedStorage.FishReplicated.FishingRequest,
	require(game.ReplicatedStorage.Modules.Net):RemoteEvent("FishingRemote", true),
	require(game.ReplicatedStorage.Util.GetWaterHeightAtLocation),
	game:GetService("CollectionService"),
	require(game.ReplicatedStorage.FishReplicated.FishingClient.Config).WATER_BODY_TAG,
	require(game.ReplicatedStorage.FishReplicated.FishingClient.Config).Rod
require(game:GetService("ReplicatedStorage").FishReplicated.FishingClient.Components)
local function C(J, F, q)
	local c, D, r =
		y(J.Position),
		J.Parent.Head.Position,
		J.CFrame.LookVector * (F:GetAttribute("MaxLaunchDistance") or H.MaxLaunchDistance) * (0.5 + q / 201)
	q, F = workspace:FindPartOnRayWithIgnoreList(Ray.new(D, r), { J.Parent, workspace.Characters, workspace.Enemies })
	D, r = workspace:FindPartOnRayWithIgnoreList(
		Ray.new(F + Vector3.new(0, 3, 0), Vector3.new(0, -500, 0)),
		{ J.Parent, workspace.Characters, workspace.Enemies }
	)
	if not r then
		return
	end
	J = Vector3.new(F.X, math.max(r.Y, c), F.Z)
	return J, D and (P:HasTag(D, Y)) or J.Y <= c
end
function DetectRod()
	if not t then
		return nil
	end
	local y = (t.Character or (t.CharacterAdded:Wait())):FindFirstChild("FishingRodData", true)
	if y then
		return y.Parent
	end
	for y, y in ipairs(t.Backpack:GetChildren()) do
		if y:FindFirstChild("FishingRodData") then
			return y
		end
	end
	return nil
end
require(game:GetService("ReplicatedStorage").FishReplicated.FishingClient.Components.CatchingMinigame)
local function y()
	local P = t.Character
	local Y, H = P and (P:FindFirstChild("HumanoidRootPart")), DetectRod()
	if not Y or not H then
		return
	end
	if H.Parent == t.Backpack then
		equiptool(H.Name)
		task.wait(0.5)
		return
	end
	P = H:GetAttribute("ServerState")
	if P then
		StatusFishingLabel.SetText("Status Fishing : " .. P)
	end
	if H:GetAttribute("SkillChargeAlpha") >= 1 then
		game:GetService("ReplicatedStorage").Modules.Net
			:FindFirstChild("RF/JobToolAbilities")
			:InvokeServer(unpack({ "Z", true }))
	end
	if not P or P == "ReeledIn" then
		getgenv().delaytimeBiting = nil
		_:InvokeServer("StartCasting")
		task.wait(0.7)
		local J, F = C(Y, H, 98)
		if not J then
			return
		end
		if not _:InvokeServer("CastLineAtLocation", J, 98, F) then
			equiptool(NameWeapon("Melee"))
			return
		end
		if not getgenv().LoadFishingRemote then
			V.OnClientEvent:Connect(function(V, Y, ...)
				if Settings["Auto Fishing"] then
					if V ~= t then
						return
					end
					if Y == "SpawnFishOnBob" then
						task.wait(0.2)
						_:InvokeServer("Catching", true, { fastBite = true })
						task.wait(2)
						game.ReplicatedStorage.FishReplicated.FishingRequest:InvokeServer("Catch", 1, 1, 1)
						game.ReplicatedStorage.FishReplicated.FishingRequest:InvokeServer("Catch", 1, 0, 1)
					end
				end
			end)
			getgenv().LoadFishingRemote = true
		end
	elseif P == "Biting" then
		if not getgenv().delaytimeBiting then
			getgenv().delaytimeBiting = tick()
		end
		if tick() - (getgenv().delaytimeBiting or 0) >= 5 then
			equiptool(NameWeapon("Melee"))
			task.wait(1)
		end
	else
		getgenv().delaytimeBiting = nil
	end
end
RunFishingCycle = y
local function _(V, P)
	local Y, H = 1 / 0
	for C, J in ipairs((P or (workspace:WaitForChild("Map"))):GetDescendants()) do
		if J:IsA("BasePart") and J.CanCollide then
			if J.Position.Y + J.Size.Y / 2 > V.Y then
				C = (J.Position - V).Magnitude
				if C < Y then
					Y, H = C, J
				end
			end
		end
	end
	if H then
		return Vector3.new(H.Position.X, H.Position.Y + H.Size.Y / 2, H.Position.Z), H
	end
	return nil
end
local function V(P, Y)
	local H = (Vector3.new(Y.X, P.Position.Y, Y.Z) - P.Position).Unit
	P.CFrame = CFrame.new(P.Position, P.Position + H)
end
X = game.Players.LocalPlayer.Character.HumanoidRootPart
function GetGoldenVortex()
	local X, P, Y = next, workspace.ActiveFishingSpots:GetChildren()
	local H, C = 1 / 0
	for J, F in X, P, Y do
		if F.Name == "GoldenVortex" then
			J = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - F.Position).Magnitude
			if J < H then
				H, C = J, F
			end
		end
	end
	return C
end
okz, execc = pcall(function()
	return identifyexecutor and (identifyexecutor())
end)
if okz and typeof(execc) == "string" then
	if execc:find("Seliware") then
		task.wait(2)
	elseif execc:find("Velocity") or (execc:find("Delta")) or (execc:find("Real")) then
		task.wait(5)
	end
end
ElevateIdentity()
StatusFishingLabel = FishingSection.CreateLabel({ Title = "Status Fishing :" })
FishingSection.CreateToggle(
	{
		Title = "Auto Tween To Event Fishing Spot",
		Desc = nil,
		Default = Settings["Auto Tween To Event Fishing Spot"] or false,
	},
	function(X)
		SaveSettings("Auto Tween To Event Fishing Spot", X)
	end
)
function CheckChestplr()
	local X
	for P, P in pairs(t.Backpack:GetChildren()) do
		X = (function() if string.find(P.Name, "Chest") then return P else return X end end)()
	end
	for P, P in pairs(t.Character:GetChildren()) do
		X = (function() if string.find(P.Name, "Chest") then return P else return X end end)()
	end
	return X
end
FishingSection.CreateToggle(
	{ Title = "Auto Fishing", Desc = nil, Default = Settings["Auto Fishing"] or false },
	function(X)
		if X then
			spawn(function()
				while Settings["Auto Fishing"] and (task.wait()) do
					local P, P = pcall(function()
						if not StackFarmOther then
							return
						end
						if Settings["Auto Celestial Soldier"] and getgenv().AttackOniSoldier then
							return
						end
						if Settings["Auto Rip Commander"] and getgenv().AttackBossRedCommander then
							return
						end
						if
							game:GetService("Players").LocalPlayer.Data.FishingData:GetAttribute("SelectedBait")
							and game:GetService("Players").LocalPlayer.Data.FishingData:GetAttribute("SelectedBait")
								~= "None"
						then
							local Y = t.Character and (t.Character:FindFirstChild("HumanoidRootPart"))
							if Settings["Auto Tween To Event Fishing Spot"] and (GetGoldenVortex()) then
								if not getgenv().Vortex or not getgenv().Vortex.Parent then
									getgenv().Vortex = GetGoldenVortex()
									task.wait(1)
									local H = getgenv()
									H.higherPos, getgenv().partHigher =
										_(getgenv().Vortex.Position, workspace:WaitForChild("Map"))
									return
								end
								if getgenv().Vortex then
									local _ = GetGoldenVortex().Position
									if not ((Y.CFrame.Position - getgenv().higherPos).Magnitude <= 5) then
										toTarget(CFrame.new(getgenv().higherPos))
									else
										if t:DistanceFromCharacter(_) > 100 then
											getgenv().Vortex = nil
											return
										end
										V(Y, _)
										y()
									end
									return
								end
							end
							local _ = Settings["Save Position Fishing"]
							if not _ then
								return
							end
							local V = Vector3.new(_.posX, _.posY, _.posZ)
							local H = CFrame.new(V) * CFrame.fromOrientation(_.rx, _.ry, _.rz)
							if Y then
								_ = Y.CFrame
								if not ((_.Position - V).Magnitude <= 10 and _.LookVector:Dot(H.LookVector) > 0.99) then
									toTarget(H)
								else
									y()
								end
							end
						else
							local _ = Settings["Select Bait"] or "Basic Bait"
							if CheckItemInventory(_) then
								game:GetService("ReplicatedStorage").Remotes.CommF_
									:InvokeServer(unpack({ [1] = "LoadItem", [2] = _, [3] = { [1] = "Usables" } }))
							else
								game:GetService("ReplicatedStorage").Modules.Net
									:FindFirstChild("RF/Craft")
									:InvokeServer(unpack({ [1] = "Craft", [2] = _, [3] = 1, [4] = {} }))
							end
						end
					end)
					if P then
						print(P)
					end
				end
			end)
		end
		SaveSettings("Auto Fishing", X)
	end
)
local X = require(game.ReplicatedStorage.JobsReplicated)
FishingSection.CreateToggle(
	{ Title = "Auto Sell Fishing", Desc = nil, Default = Settings["Auto Sell Fishing"] or false },
	function(_)
		if _ then
			spawn(function()
				while Settings["Auto Sell Fishing"] and (task.wait(0.2)) do
					local V, V = pcall(function()
						X.InvokeServer("FishingNPC", "SellFish")
					end)
					if V then
						print(V)
					end
				end
			end)
		end
		SaveSettings("Auto Sell Fishing", _)
	end
)
FishingSection.CreateToggle(
	{ Title = "Auto Open Chest", Desc = nil, Default = Settings["Auto Open Chest"] or false },
	function(_)
		if _ then
			spawn(function()
				while Settings["Auto Open Chest"] and (task.wait(0.2)) do
					local V, V = pcall(function()
						local y = CheckChestplr()
						if y then
							y.RemoteEvent:FireServer(unpack({ [1] = "Visual" }))
							task.wait(0.1)
							y.RemoteEvent:FireServer(unpack({ [1] = "Open" }))
						end
					end)
					if V then
						print(V)
					end
				end
			end)
		end
		SaveSettings("Auto Open Chest", _)
	end
)
local _ = {}
for V, V in next, require(game:GetService("ReplicatedStorage").Modules.Asset.RarityUtil.RarityData), nil do
	_[V.Name] = false
end
function DetectQuestFishing()
	local V = GetNameDoubleQuest()
	if not V then
		return false
	end
	local y
	for P, Y in pairs(_) do
		if string.find(V, P) then
			y = P
			break
		end
	end
	if y and Settings["Select Quest Fishing"] then
		for y, P in next, Settings["Select Quest Fishing"], nil do
			if string.find(V, y) then
				return true
			end
		end
		return false
	end
	return true
end
FishingSection.CreateDropdown(
	{
		Title = "Select Quest Fishing",
		List = PrepareMultiSelectList(_, Settings["Select Quest Fishing"]),
		Search = true,
		Selected = true,
		Default = Settings["Select Quest Fishing"] or nil,
	},
	function(_, V)
		SaveSettings("Select Quest Fishing", _, V)
	end
)
FishingSection.CreateToggle(
	{ Title = "Auto Accept Quest Fishing", Desc = nil, Default = Settings["Auto Accept Quest Fishing"] or false },
	function(_)
		if _ then
			spawn(function()
				while Settings["Auto Accept Quest Fishing"] and (task.wait()) do
					local V, V = pcall(function()
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
						X.InvokeServer("FishingNPC", "Angler", "CheckQuest")
						local y = X.InvokeServer("FishingNPC", "Angler", "Speak")
						if y.canAccept then
							X.InvokeServer("FishingNPC", "Angler", "AskQuest")
						elseif y.FailedAnglerQuest or not DetectQuestFishing() then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
						end
						task.wait(2)
					end)
					if V then
						print(V)
					end
				end
			end)
		end
		SaveSettings("Auto Accept Quest Fishing", _)
	end
)
QuestDragonSection = FarmotherMain.CreateSection("Quest Dragon")
function QuestDojoTrainer()
	return game:GetService("ReplicatedStorage")
		:WaitForChild("Modules")
		:WaitForChild("Net")
		:WaitForChild("RF/InteractDragonQuest")
		:InvokeServer(unpack({ [1] = { NPC = "Dojo Trainer", Command = "RequestQuest" } }))
end
AttackAllMobSection = FarmotherMain.CreateSection("Attack All Mobs")
function DetectAllMob()
	local X, _, V = next, game:GetService("Workspace").Enemies:GetChildren()
	for y, y in X, _, V do
		if y.Name ~= "Spirit Tree" and (y:GetAttribute("Level")) and (y:GetAttribute("FruitType")) then
			return y
		end
	end
	X, _, V = next, game:GetService("ReplicatedStorage"):GetChildren()
	for y, y in X, _, V do
		if y.Name ~= "Spirit Tree" and (y:GetAttribute("Level")) and (y:GetAttribute("FruitType")) then
			return y
		end
	end
end
AttackAllMobSection.CreateToggle(
	{ Title = "Auto Attack All Mob and Boss", Desc = nil, Default = Settings["Auto Attack All Mob and Boss"] or false },
	function(X)
		spawn(function()
			while Settings["Auto Attack All Mob and Boss"] and (wait()) do
				local _, _ = pcall(function()
					if not StackFarmOther then
						return
					end
					local V = DetectAllMob()
					if V then
						repeat
							task.wait()
							UsedualFlock()
							ClickM1(V)
							if Settings["Select Weapon"] == "Blox Fruit" then
								toTarget(V.HumanoidRootPart.CFrame * CFrame.new(-7, getgenv().YPosFruit, 0))
							else
								toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end
						until not IsMobAlive(V) or not Settings["Auto Attack All Mob and Boss"] or not StackFarmOther
					end
				end)
				if _ then
					print(_)
				end
			end
		end)
		SaveSettings("Auto Attack All Mob and Boss", X)
	end
)
local X, _ = { "PirateBrigade", "PirateGrandBrigade" }, { "Fish Crew Member", "Shark" }
function DetectQuestSeaDragon()
	local V, y, P = next, game:GetService("Workspace").Enemies:GetChildren()
	for Y, Y in V, y, P do
		if
			Y:FindFirstChild("Engine")
			and (Y:FindFirstChild("Health"))
			and Y.Health.Value > 0
			and t:DistanceFromCharacter(Y.Engine.Position) < 500
		then
			return Y
		end
	end
	V = DetectMob(_)
	if V and t:DistanceFromCharacter(V.HumanoidRootPart.Position) < 500 then
		return V
	end
	V = DetectMob("Piranha")
	if V and t:DistanceFromCharacter(V.HumanoidRootPart.Position) < 500 then
		return V
	end
end
function checkboat()
	local V = t.Name
	V = (function() if Settings["Auto Sea Event With Friend"] and Settings["Auto Sea Event"] then return Settings["Select Friend"] else return V end end)()
	local y, P, Y = next, game:GetService("Workspace").Boats:GetChildren()
	for H, H in y, P, Y do
		if H:IsA("Model") then
			if H:FindFirstChild("Owner") and tostring(H.Owner.Value) == V and H.Humanoid.Value > 0 then
				return H
			end
		end
	end
	return false
end
getgenv().PosSEaY = -50
function TeleportSeaEvents(V)
	if not V then
		return
	end
	if V:FindFirstChild("Engine") and (V:FindFirstChild("Health")) and V.Health.Value > 0 then
		local y = Settings["Use Click M1 Fruit For Sea Event"] and -25 or -15
		toTarget(V.Engine.CFrame * CFrame.new(0, y, 0))
		return
	end
	if V.Name == "SeaBeast1" and (V:FindFirstChild("HumanoidRootPart")) then
		if
			(Vector3.new(0, V:FindFirstChild("HumanoidRootPart").Position.Y, 0) - Vector3.new(0, -60, 0)).Magnitude
			<= 175
		then
			if Settings["Use Click M1 Fruit For Sea Event"] then
				toTarget(V.HumanoidRootPart.CFrame * CFrame.new(0, 200 + PosDodgeskill, 0), true)
			else
				toTarget(V.HumanoidRootPart.CFrame * CFrame.new(0, 200 + PosDodgeskill, 50), true)
			end
		else
			toTarget(CFrame.new(V.HumanoidRootPart.Position.X, 140, V.HumanoidRootPart.Position.Z), true)
		end
	else
		local y = V.Name
		local P = ((Settings["Use Click M1 Fruit For Sea Event"]) and 20 or ((y == "Terrorshark") and 60 or 20))
		if V:FindFirstChildWhichIsA("Humanoid") and V.Humanoid.Health > 0 then
			toTarget(V.HumanoidRootPart.CFrame * CFrame.new(0, P, 0))
		end
	end
end
local V = 0
function DecectPartRoughSea()
	local y, P, Y = next, game.workspace._WorldOrigin.Locations:GetChildren()
	for H, H in y, P, Y do
		if
			H.Name == "Rough Sea"
			and t:DistanceFromCharacter(H.Position) <= 3000
			and Vector3.new(0.0010000000474974513, 0.0010000000474974513, 0.0010000000474974513) ~= workspace._WorldOrigin.RainEmitterPart.Size
			and not H:FindFirstChild("Ignored")
		then
			return H
		end
	end
end
function AutoQuestDojo()
	local y, P =
		QuestDojoTrainer(), CFrame.new(5868.453125, 1207.7784423828125, 870.819580078125) * CFrame.new(0, 4, -2)
	if not getgenv().QuestTrainer then
		if t:DistanceFromCharacter(P.Position) > 8 then
			toTarget(P)
		elseif y then
			if y.Quest.Progress >= y.Quest.Goal then
				game:GetService("ReplicatedStorage")
					:WaitForChild("Modules")
					:WaitForChild("Net")
					:WaitForChild("RF/InteractDragonQuest")
					:InvokeServer(unpack({ [1] = { NPC = "Dojo Trainer", Command = "ClaimQuest" } }))
				wait(1)
				return
			end
			if y.Quest.BeltName == "White" then
				getgenv().QuestTrainer = { BeltName = "White", CountKillMob = 0 }
			elseif y.Quest.BeltName == "Yellow" then
				getgenv().QuestTrainer = { BeltName = "Yellow", CountKillMob = 0 }
			elseif y.Quest.BeltName == "Green" then
				getgenv().QuestTrainer = { BeltName = "Green", CountKillMob = 300, Progress = y.Quest.Progress }
			elseif y.Quest.BeltName == "Purple" then
				getgenv().QuestTrainer = { BeltName = "Purple", CountKillMob = 0 }
			elseif y.Quest.BeltName == "Red" then
				getgenv().QuestTrainer = { BeltName = "Red", CountKillMob = 0 }
			else
				A.CreateNoti({
					Title = "Noijo Hub",
					Desc = "That's enough training for today... Come back tomorrow and we can continue.\10 or dont support Belt Currently",
					ShowTime = 5,
				})
				wait(5)
				return
			end
		end
	elseif getgenv().QuestTrainer.BeltName == "White" and getgenv().QuestTrainer.CountKillMob < 20 then
		SaveSettings("QuestDojo", true)
		local y = GetNameDoubleQuest() or ""
		if not HasQuest() and typeof(y) == "string" then
			TakeQuestLevel()
		else
			local P = DetectMob(y)
			if not P then
				local Y = DetectPartSpawnMob(y, true)
				if Y then
					Instance.new("IntValue", Y).Name = "Ignored"
					repeat
						task.wait()
						toTarget(Y.CFrame * CFrame.new(0, 60, 0))
					until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob(y))
						or not Settings["Auto Quest Dojo Trainer"]
					wait(1)
				else
					DeleteIgnoredMobSpawn()
				end
			else
				repeat
					task.wait()
					sizepart(P)
					BringMob(P)
					UsedualFlock()
					ClickM1(P)
					if
						game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible
						and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"])
					then
						toTarget(P.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					elseif Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(P.HumanoidRootPart.CFrame * CFrame.new(-7, getgenv().YPosFruit, 0))
					else
						toTarget(P.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
				until not IsMobAlive(P) or not Settings["Auto Quest Dojo Trainer"]
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
		local y, P = DetectQuestSeaDragon(), checkboat()
		if not y then
			if not P then
				local Y = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
				if (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
					toTarget(Y)
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
				end
			else
				task.spawn(function()
					NoclipBoat(P)
				end)
				local Y = DecectPartRoughSea()
				if Y then
					wait(1)
					V = ((V == 0) and 7000 or 0)
					Instance.new("IntValue", Y).Name = "Ignored"
					wait(0.5)
				end
				getgenv().RoughSea = V
				Y = CFrame.new(-32975.9921875, P.WorldPivot.Y, 25963.7109375)
					* CFrame.new(0, P.WorldPivot.Y, 0 + RoughSea)
				if not t.Character.Humanoid.Sit then
					toTarget(P.VehicleSeat.CFrame)
				else
					manageTween(P.VehicleSeat, Y, 350, "TweenBoat")
				end
			end
		else
			repeat
				task.wait()
				TeleportSeaEvents(y)
				local P = y:FindFirstChild("HumanoidRootPart") or (y:FindFirstChild("Engine"))
				getgenv().AimPos = CFrame.new(P.Position.X, 40, P.Position.Z)
				if y:FindFirstChildWhichIsA("Humanoid") then
					UsedualFlock()
					ClickM1(y, true)
				elseif t:DistanceFromCharacter(P.Position) < 400 then
					AutoAllSkill()
				end
			until not y
				or not y.Parent
				or y:FindFirstChildWhichIsA("Humanoid") and y.Humanoid.Health <= 0
				or y:FindFirstChild("Health") and y.Health.Value <= 0
				or not Settings["Auto Quest Dojo Trainer"]
			if getgenv().QuestTrainer and getgenv().QuestTrainer.CountKillMob then
				getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
			end
		end
	elseif getgenv().QuestTrainer.BeltName == "Yellow" and getgenv().QuestTrainer.CountKillMob >= 5 then
		SaveSettings("QuestDojo", false)
		getgenv().QuestTrainer = nil
	elseif getgenv().QuestTrainer.BeltName == "Purple" and getgenv().QuestTrainer.CountKillMob < 3 then
		SaveSettings("QuestDojo", true)
		local y = DetectEliteHunter()
		if y then
			StackFarm = false
			NoijoOwner("Auto Quest Dojo Trainer")
			if not EnsureEliteQuest(y.Name) then
				task.wait()
			else
				repeat
					task.wait()
					sizepart(y)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
					ClickM1(y)
					UsedualFlock()
				until not IsMobAlive(y) or not Settings["Auto Quest Dojo Trainer"]
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
		if
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.Visible
			and tonumber(
					game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.TextLabel.Text
				)
				== 6
		then
			local y = tick()
			repeat
				wait()
			until tick() - y >= getgenv().QuestTrainer.Progress
				or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.Visible
				or not Settings["Auto Quest Dojo Trainer"]
			getgenv().QuestTrainer = nil
			SaveSettings("QuestDojo", false)
		else
			local y = checkboat()
			if not y then
				local P = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
				if (P.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
					toTarget(P)
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
				end
			else
				task.spawn(function()
					NoclipBoat(y)
				end)
				local P = DecectPartRoughSea()
				if P then
					wait(1)
					V = ((V == 0) and 7000 or 0)
					Instance.new("IntValue", P).Name = "Ignored"
					wait(0.5)
				end
				getgenv().RoughSea = V
				P = CFrame.new(-32975.9921875, y.WorldPivot.Y, 25963.7109375)
					* CFrame.new(0, y.WorldPivot.Y, 0 + RoughSea)
				if not t.Character.Humanoid.Sit then
					toTarget(y.VehicleSeat.CFrame)
				else
					manageTween(y.VehicleSeat, P, 350, "TweenBoat")
				end
			end
		end
	elseif getgenv().QuestTrainer.BeltName == "Red" and getgenv().QuestTrainer.CountKillMob == 0 then
		SaveSettings("QuestDojo", true)
		local y, P = CheckNameBoss("Terrorshark"), checkboat()
		if not y then
			if not P then
				local Y = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
				if (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
					toTarget(Y)
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
				end
			else
				local Y = DecectPartRoughSea()
				if Y then
					wait(1)
					V = ((V == 0) and 7000 or 0)
					Instance.new("IntValue", Y).Name = "Ignored"
					wait(0.5)
				end
				getgenv().RoughSea = V
				Y = CFrame.new(-32975.9921875, P.WorldPivot.Y, 25963.7109375)
					* CFrame.new(0, P.WorldPivot.Y, 0 + RoughSea)
				if not t.Character.Humanoid.Sit then
					toTarget(P.VehicleSeat.CFrame)
				else
					manageTween(P.VehicleSeat, Y, 350, "TweenBoat")
				end
			end
		else
			repeat
				task.wait()
				TeleportSeaEvents(y)
				local P = y:FindFirstChild("HumanoidRootPart")
				getgenv().AimPos = CFrame.new(P.Position.X, 40, P.Position.Z)
				if y:FindFirstChildWhichIsA("Humanoid") then
					UsedualFlock()
					ClickM1(y, true)
				elseif t:DistanceFromCharacter(P.Position) < 400 then
					AutoAllSkill()
				end
			until not y or not y.Parent or y.Humanoid.Health <= 0 or not Settings["Auto Quest Dojo Trainer"]
			getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
		end
	elseif getgenv().QuestTrainer.BeltName == "Red" and getgenv().QuestTrainer.CountKillMob > 0 then
		SaveSettings("QuestDojo", false)
		getgenv().QuestTrainer = nil
	end
end
QuestDragonSection.CreateToggle(
	{ Title = "Auto Quest Dojo Trainer", Desc = nil, Default = Settings["Auto Quest Dojo Trainer"] or false },
	function(y)
		if y then
			spawn(function()
				while Settings["Auto Quest Dojo Trainer"] and (task.wait()) do
					local P, P = pcall(function()
						AutoQuestDojo()
					end)
					if P then
						print(P)
					end
				end
			end)
		end
		SaveSettings("Auto Quest Dojo Trainer", y)
	end
)
game:GetService("Players").LocalPlayer.PlayerGui.Notifications.ChildAdded:Connect(function(y)
	if y.Name == "NotificationTemplate" then
		repeat
			wait()
		until y:FindFirstChild("TranslateMe")
		local label = y.TranslateMe
		-- thông báo hoàn thành là 1 khối nhiều dòng (Obtained.../Task completed!/Head back to the Dojo...), nên phải tìm chuỗi con chứ không so sánh bằng
		local function CheckQuestDone()
			local text = tostring(label.Text):gsub("<[^>]+>", ""):gsub("{[^}]*}", "")
			if string.find(text, "Head back to the Dojo", 1, true) then
				getgenv().QuestHunterDragon = nil
			end
		end
		CheckQuestDone()
		label:GetPropertyChangedSignal("Text"):Connect(CheckQuestDone)
	end
	if y.Name == "NotificationTemplate" then
		repeat
			wait()
		until y:FindFirstChild("TranslateMe")
		if y.TranslateMe.Text == "{color1_Red}[ERROR]{color1_/} Can't perform actions while preparing to teleport!" then
			y:Destroy()
		end
	end
end)
-- thông báo hoàn thành quest đi qua remote CommE: ("Notify", "<Color=Green>Task completed!<Color=/>") rồi ("Notify", "Head back to the Dojo to complete more tasks.")
task.spawn(function()
	local CommE = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommE")
	CommE.OnClientEvent:Connect(function(kind, text)
		if kind ~= "Notify" or type(text) ~= "string" then
			return
		end
		local clean = text:gsub("<[^>]+>", ""):gsub("{[^}]*}", "")
		if string.find(clean, "Task completed", 1, true) or string.find(clean, "Head back to the Dojo", 1, true) then
			getgenv().QuestHunterDragon = nil
		end
	end)
end)
function DetectTree()
	local y = workspace.Map:FindFirstChild("Waterfall") and (workspace.Map.Waterfall:FindFirstChild("IslandModel"))
	if not y then
		toTarget((CFrame.new(5251.900390625, 17.18115234375, 453.6025390625)))
		return nil
	end
	local function P(Y)
		for H, C in ipairs(Y:GetChildren()) do
			if
				C:IsA("Model")
				and not C:FindFirstChild("Ignored")
				and C.Name == "Tree"
				and not C:GetAttribute("AlreadyDestroyedClient")
				and (C:FindFirstChild("Group"))
				and (C.Group:FindFirstChild("Meshes/bambootree") or (C.Group:FindFirstChild("Meshes/plant1_Icosphere")))
				and not workspace:FindFirstChild("EmberTemplate")
			then
				return C
			end
			H = P(C)
			if H then
				return H
			end
		end
		return nil
	end
	local Y = P(y)
	if not Y then
		local function P(H)
			for C, C in ipairs(H:GetChildren()) do
				if C:FindFirstChild("Ignored") then
					C.Ignored:Destroy()
				end
				P(C)
			end
		end
		P(y)
	end
	return Y
end
function DetectEmberTemplate()
	for y, y in game.workspace:GetChildren() do
		if
			y.Name == "EmberTemplate"
			and not y:FindFirstChild("Ignored")
			and (y:FindFirstChild("Part"))
			and y.Part.Position.Y > -100
		then
			return y
		end
	end
end
function AutoDragonHunter()
	local y = DetectNpc("Dragon Hunter")
	-- nhặt ember trước (cả lúc quest vừa xong và chưa nhận quest mới)
	local ember = DetectEmberTemplate()
	if ember then
		Instance.new("IntValue", ember).Name = "Ignored"
		repeat
			wait()
			toTarget(ember.Part.CFrame)
		until not ember or not ember.Parent
		return
	end
	if not getgenv().QuestHunterDragon then
		if t:DistanceFromCharacter(y.HumanoidRootPart.Position) > 8 then
			toTarget(y.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4))
		else
			local y = game:GetService("ReplicatedStorage")
				:WaitForChild("Modules")
				:WaitForChild("Net")
				:WaitForChild("RF/DragonHunter")
				:InvokeServer(unpack({ [1] = { Context = "Check" } }))
			if not y or y and not y.Text then
				getgenv().QuestHunterDragon = game:GetService("ReplicatedStorage")
					:WaitForChild("Modules")
					:WaitForChild("Net")
					:WaitForChild("RF/DragonHunter")
					:InvokeServer(unpack({ [1] = { Context = "RequestQuest" } })).Text
			else
				getgenv().QuestHunterDragon = y.Text
			end
		end
	else
		local questText = getgenv().QuestHunterDragon
		if string.find(questText, "Hydra Enforcers") then
			local P = DetectMob("Hydra Enforcer")
			if not P then
				local Y = DetectPartSpawnMob("Hydra Enforcer", true)
				if Y then
					Instance.new("IntValue", Y).Name = "Ignored"
					repeat
						wait()
						toTarget(Y.CFrame * CFrame.new(0, 60, 0))
					until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob("Hydra Enforcer"))
						or not Settings["Auto Quest Dragon Hunter"]
						or not getgenv().QuestHunterDragon
					wait(1)
				else
					DeleteIgnoredMobSpawn()
				end
			else
				repeat
					task.wait()
					sizepart(P)
					BringMob(P)
					UsedualFlock()
					ClickM1(P)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(P.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(P.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
				until not IsMobAlive(P) or not Settings["Auto Quest Dragon Hunter"] or not getgenv().QuestHunterDragon
			end
		elseif string.find(questText, "Venomous Assailants") then
			local P = DetectMob("Venomous Assailant")
			if not P then
				local Y = DetectPartSpawnMob("Venomous Assailant", true)
				if Y then
					Instance.new("IntValue", Y).Name = "Ignored"
					repeat
						wait()
						toTarget(Y.CFrame * CFrame.new(0, 60, 0))
					until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob("Venomous Assailant"))
						or not Settings["Auto Quest Dragon Hunter"]
						or not getgenv().QuestHunterDragon
					wait(1)
				else
					DeleteIgnoredMobSpawn()
				end
			else
				repeat
					task.wait()
					sizepart(P)
					BringMob(P)
					UsedualFlock()
					ClickM1(P)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(P.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(P.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
				until not IsMobAlive(P) or not Settings["Auto Quest Dragon Hunter"] or not getgenv().QuestHunterDragon
			end
		elseif string.find(questText, "trees") then
			local P, Y = workspace.CurrentCamera, DetectTree()
			if Y then
				Instance.new("IntValue", Y).Name = "Ignored"
				local H = tick()
				-- có Skull Guitar: dùng logic phá tree của farm Tyrant (cầm đàn + click vào tree); không có thì spam skill như cũ
				local hasGuitar = CheckItemInventory("Skull Guitar")
				local timeout = hasGuitar and 30 or 15
				repeat
					task.wait()
					local C = Y.WorldPivot.Position
					if hasGuitar then
						if t:DistanceFromCharacter(C) > 10 then
							toTarget(Y.WorldPivot)
						elseif not NameWeapon("Gun") or NameWeapon("Gun") ~= "Skull Guitar" then
							game:GetService("ReplicatedStorage").Remotes.CommF_
								:InvokeServer(unpack({ [1] = "LoadItem", [2] = "Skull Guitar" }))
						else
							equiptool(NameWeapon("Gun"))
							-- click vào model player (HumanoidRootPart) thay vì click vào model tree
							local hrp = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
							if hrp then
								getgenv().ClickWorldPos(hrp.Position)
							end
						end
					else
						if t:DistanceFromCharacter(C) < 50 then
							AutoAllSkill()
						end
						if Y:FindFirstChild("Meshes/plant1_Icosphere", true) then
							toTarget(Y.WorldPivot)
							getgenv().AimPos = Y.WorldPivot
							G.Hit = CFrame.new(P.CFrame.Position, C)
							G.Target = Y
						else
							local C2, J =
								(Y.WorldPivot * CFrame.new(5, -20, 0)).Position,
								(Y.WorldPivot * CFrame.new(0, -20, 0)).Position
							toTarget(CFrame.new(C2))
							getgenv().AimPos = CFrame.new(J)
							G.Hit = CFrame.new(P.CFrame.Position, J)
							G.Target = Y
						end
					end
				until not Y
					or not Y.Parent
					or not Settings["Auto Quest Dragon Hunter"]
					or not getgenv().QuestHunterDragon
					or (Y:GetAttribute("AlreadyDestroyedClient"))
					or tick() - H >= timeout
			end
		end
	end
end
QuestDragonSection.CreateToggle(
	{ Title = "Auto Quest Dragon Hunter", Desc = nil, Default = Settings["Auto Quest Dragon Hunter"] or false },
	function(y)
		if y then
			spawn(function()
				while Settings["Auto Quest Dragon Hunter"] and (task.wait(0.1)) do
					local P, P = pcall(function()
						AutoDragonHunter()
					end)
					if P then
						print(P)
					end
				end
			end)
		end
		SaveSettings("Auto Quest Dragon Hunter", y)
	end
)
function DetectBerryCFrame(y)
	for P, P in next, y, nil do
		if P then
			return P
		end
	end
end
function DetectBerry()
	local y, P, Y = next, game:GetService("CollectionService"):GetTagged("BerryBush")
	for H, H in y, P, Y do
		if DetectBerryCFrame(H:GetAttributes()) then
			return H
		end
	end
end
function DetectBerryESP()
	local y, P, Y = next, game:GetService("CollectionService"):GetTagged("BerryBush")
	for H, C in y, P, Y do
		if not C.Parent:FindFirstChild("Ignored") then
			H = DetectBerryCFrame(C:GetAttributes())
			if H then
				return C, H
			end
		end
	end
end
function DetectModelBerry(y)
	for P, P in pairs(y:GetChildren()) do
		if P then
			return P
		end
	end
end
function GetCFrameSpawnBerry()
	local y, P, Y = next, game:GetService("CollectionService"):GetTagged("BerryBush")
	local H, C = 1 / 0
	for J, F in y, P, Y do
		if not F.Parent:FindFirstChild("IgnoredBerry") then
			J = t:DistanceFromCharacter(F.Parent:GetAttribute("CFrame").Position)
			if H > J then
				H, C = J, F
			end
		end
	end
	return C
end
BerrySection = FarmotherMain.CreateSection("Berry")
BerrySection.CreateToggle(
	{ Title = "Hop Find Berry", Desc = nil, Default = Settings["Hop Find Berry"] or false },
	function(y)
		SaveSettings("Hop Find Berry", y)
	end
)
BerrySection.CreateToggle(
	{ Title = "Auto Collect Berry", Desc = nil, Default = Settings["Auto Collect Berry"] or false },
	function(y)
		if y then
			spawn(function()
				while Settings["Auto Collect Berry"] and (task.wait(0.1)) do
					pcall(function()
						local P = DetectBerry()
						if P then
							local Y = DetectModelBerry(P)
							if not Y then
								toTarget(P.Parent.WorldPivot)
							else
								toTarget(Y.WorldPivot)
								local P = Y:FindFirstChild("ProximityPrompt")
								if P then
									fireproximityprompt(P)
								end
							end
						else
							A.CreateNoti({ Title = "Noijo Hub", Desc = "Waiting Berry spawn", ShowTime = 5 })
							if Settings["Hop Find Berry"] then
								HopServer()
							end
							wait(5)
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Collect Berry", y)
	end
)
FarmChestSection = FarmotherMain.CreateSection("Farm Chest")
FarmChestSection.CreateSlider(
	{
		Title = "Value Collect Chest to Hop",
		Min = 0,
		Max = 100,
		Default = Settings["Value Collect Chest to Hop"] or 20,
		Precise = true,
	},
	function(y)
		SaveSettings("Value Collect Chest to Hop", y)
	end
)
function AutoChest()
	if not StackFarmOther then
		return
	end
	local y = Settings["Value Collect Chest to Hop"] or 20
	if CheckNameBoss("Darkbeard") and Settings["Attack Darkbeard"] then
		f = y
		return
	end
	if DetectItemPlr("Fist of Darkness") and Settings["Summon Darkbeard"] then
		f = y
		return
	end
	if
		(DetectItemPlr("Fist of Darkness") or (DetectItemPlr("God's Chalice"))) and Settings["Tween Safe if have Items"]
	then
		return
	end
	if f and f >= y and Settings["Auto Chest Hop"] then
		HopServer()
		return
	end
	y = GetNearestChest()
	if y then
		f = f + (1)
		local P
		repeat
			task.wait()
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - y.Position).Magnitude <= 5 then
				if not P then
					P = (tick())
				elseif tick() - P >= 5 then
					Instance.new("IntValue", y).Name = "Ignored"
					wait(0.1)
				end
				if not Settings["Use Method Teleport"] then
					game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
					wait()
					game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
				end
				TweenManager.CancelCurrent()
			end
			if Settings["Use Method Teleport"] then
				t.Character.HumanoidRootPart.CFrame = y.CFrame
				TweenManager.CancelCurrent()
			else
				toTarget(y.CFrame, true)
			end
		until not y
			or not y.Parent
			or not Settings["Auto Chest"]
			or (y:GetAttribute("IsDisabled"))
			or (y:FindFirstChild("Ignored"))
			or not y:FindFirstChild("TouchInterest")
			or not StackFarmOther
	else
		local y = PathFindChest()
		if y then
			toTarget(y.Part.CFrame)
			if (y.Part.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100 or (GetNearestChest()) then
				Instance.new("IntValue", y).Name = "Ignored"
			end
		else
			for y, y in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
				if y:FindFirstChild("Ignored") then
					y:FindFirstChild("Ignored"):Destroy()
				end
			end
		end
	end
end
FarmChestSection.CreateToggle(
	{ Title = "Auto Chest Hop", Desc = nil, Default = Settings["Auto Chest Hop"] or false },
	function(y)
		SaveSettings("Auto Chest Hop", y)
	end
)
FarmChestSection.CreateToggle(
	{ Title = "Use Method Teleport [ Risk ]", Desc = nil, Default = Settings["Use Method Teleport"] or false },
	function(y)
		SaveSettings("Use Method Teleport", y)
	end
)
FarmChestSection.CreateToggle(
	{ Title = "Auto Chest", Desc = nil, Default = Settings["Auto Chest"] or false },
	function(y)
		if y then
			spawn(function()
				while Settings["Auto Chest"] and (task.wait(0.1)) do
					local P, P = pcall(function()
						AutoChest()
					end)
					if P then
						print(P)
					end
				end
			end)
		end
		SaveSettings("Auto Chest", y)
	end
)
RaidLawSection = FarmotherMain.CreateSection("Raid Law")
RaidLawSection.CreateToggle(
	{ Title = "Auto Buy Chip and Attack Law", Desc = nil, Default = Settings["Auto Buy Chip and Attack Law"] or false },
	function(y)
		if y then
			spawn(function()
				while Settings["Auto Buy Chip and Attack Law"] and (task.wait()) do
					pcall(function()
						if DetectItemPlr("Core Brain") then
							fireclickdetector(
								game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector
							)
							return
						end
						local P = CheckNameBoss("Order")
						if P then
							repeat
								task.wait()
								sizepart(P)
								UsedualFlock()
								ClickM1(P)
								if Settings["Select Weapon"] == "Blox Fruit" then
									toTarget(P.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									toTarget(P.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end
							until not IsMobAlive(P) or not Settings["Auto Buy Chip and Attack Law"]
						elseif
							not DetectItemPlr("Microchip") and game.Players.LocalPlayer.Data.Fragments.Value >= 1000
						then
							BuyChipLaw()
							wait(2)
						elseif DetectItemPlr("Microchip") then
							fireclickdetector(
								game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector
							)
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Buy Chip and Attack Law", y)
	end
)
FarmObservationSection = FarmotherMain.CreateSection("Farm Observation")
-- Rejoin lai chinh server hien tai (copy JobId hien tai -> join lai JobId do) thay vi hop sang server moi
local __rejoining = false
function RejoinCurrentServer()
	if __rejoining then
		return
	end
	__rejoining = true
	local jobId = tostring(game.JobId)
	pcall(function()
		if setclipboard then
			setclipboard(jobId)
		end
	end)
	pcall(function()
		require(game:GetService("ReplicatedStorage").Notification)
			.new("<Color=Red>Noijo Hub : Rejoin Server<Color=/>")
			:Display()
	end)
	local ok = pcall(function()
		game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", jobId)
	end)
	if not ok then
		pcall(function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, game.Players.LocalPlayer)
		end)
	end
	-- doi teleport chay; neu 10s van chua roi server (teleport fail) thi cho phep thu lai
	task.delay(10, function()
		__rejoining = false
	end)
end
function FarmObservation()
	local y = game.PlaceId == getgenv().CheckPlaceId2 and "Marine Captain" or "Marine Commodore"
	local P = DetectMob(y)
	if not game:GetService("Lighting").Blur.Enabled then
		game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
		game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
		task.wait()
		local Y, H =
			P and P.HumanoidRootPart or (DetectPartSpawnMob(y)), P and (CFrame.new(0, 0, 50)) or (CFrame.new(0, 60, 0))
		toTarget(Y.CFrame * H)
		task.wait(3)
		if not game:GetService("Lighting").Blur.Enabled and Settings["Farm Observation [ Hop Server ]"] then
			RejoinCurrentServer()
		end
	else
		local Y, H =
			P and P.HumanoidRootPart or (DetectPartSpawnMob(y)), P and (CFrame.new(0, 0, 3)) or (CFrame.new(0, 60, 0))
		if P then
			repeat
				task.wait()
				toTarget(Y.CFrame * H)
			until not Settings["Farm Observation"] or not game:GetService("Lighting").Blur.Enabled
		else
			toTarget(Y.CFrame * H)
		end
	end
end
function ObservationV2()
	if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 0 then
		if
			QuestHas("Forest Pirate")
			and (QuestHas("50"))
			and HasQuest()
		then
			local y = DetectMob("Forest Pirate")
			if not y then
				local P = "Forest Pirate"
				if typeof(P) == "table" then
					if #N >= 13 then
						N = {}
						return
					end
					local Y = DetectPartSpawnMob(DetectNameTablePart(P))
					if Y then
						table.insert(N, DetectNameTablePart(P))
						repeat
							wait()
							toTarget(Y.CFrame * CFrame.new(0, 60, 0))
						until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
							or (DetectMob(P))
							or not Settings["Auto UP Observation V2"]
						wait(1)
					end
				else
					local Y = DetectPartSpawnMob(P, true)
					if Y then
						Instance.new("IntValue", Y).Name = "Ignored"
						repeat
							wait()
							toTarget(Y.CFrame * CFrame.new(0, 60, 0))
						until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
							or (DetectMob(P))
							or not Settings["Auto UP Observation V2"]
						wait(1)
					else
						DeleteIgnoredMobSpawn()
					end
				end
			else
				repeat
					task.wait()
					sizepart(y)
					BringMob(y)
					UsedualFlock()
					ClickM1(y)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
				until not IsMobAlive(y) or not Settings["Auto UP Observation V2"]
			end
		elseif t:DistanceFromCharacter(Vector3.new(-12441.5908203125, 331.4884948730469, -7676.197265625)) < 10 then
			game:GetService("ReplicatedStorage").Remotes.CommF_
				:InvokeServer(unpack({ [1] = "StartQuest", [2] = "CitizenQuest", [3] = 1 }))
		else
			toTarget(CFrame.new(-12441.5908203125, 331.4884948730469, -7676.197265625))
		end
	elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 1 then
		if
			QuestHas("Captain Elephant")
			and (QuestHas("1"))
			and HasQuest()
		then
			local y = CheckNameBoss("Captain Elephant")
			if y then
				repeat
					wait()
					sizepart(y)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
					ClickM1(y)
					equiptool(NameWeapon(Settings["Select Weapon"]))
				until not IsMobAlive(y) or not Settings["Auto UP Observation V2"]
			else
				A.CreateNoti({ Title = "Noijo Hub", Desc = "Waiting Boss Captain Elephant", ShowTime = 5 })
				wait(5)
			end
		elseif t:DistanceFromCharacter(Vector3.new(-12441.5908203125, 331.4884948730469, -7676.197265625)) < 10 then
			game:GetService("ReplicatedStorage").Remotes.CommF_
				:InvokeServer(unpack({ [1] = "StartQuest", [2] = "CitizenQuest", [3] = 1 }))
		else
			toTarget(CFrame.new(-12441.5908203125, 331.4884948730469, -7676.197265625))
		end
	elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
		toTarget(CFrame.new(-12513.8, 336.167, -9872.91))
	elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 3 then
		if
			tonumber((string.gsub(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk", "Status"), "%D", "")))
			>= 5000
		then
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2", "Start")
			if
				t.Data.Beli.Value >= 5000000
					and (DetectItemPlr("Pineapple") and (DetectItemPlr("Apple")) and (DetectItemPlr("Banana")))
				or (DetectItemPlr("Fruit Bowl"))
			then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
			else
				local y = { "PineappleSpawner", "BananaSpawner", "AppleSpawner" }
				for P, P in pairs(y) do
					if game:GetService("Workspace"):FindFirstChild(P) then
						if game:GetService("Workspace"):FindFirstChild(P):FindFirstChildOfClass("Tool") then
							firetouchinterest(
								t.Character.HumanoidRootPart,
								game:GetService("Workspace"):FindFirstChild(P):FindFirstChildOfClass("Tool").Handle,
								0
							)
						else
							A.CreateNoti({ Title = "Noijo Hub", Desc = "Wating Fruit", ShowTime = 5 })
							wait(3)
						end
					end
				end
			end
		else
			local y, P, Y = next, game.workspace.Enemies:GetChildren()
			local H
			for C, C in y, P, Y do
				H = (function() if C:IsA("Model")
						and C.Name == "Marine Commodore"
						and (C:FindFirstChild("HumanoidRootPart"))
						and C.Humanoid.Health > 0 then return C else return H end end)()
			end
			if not game:GetService("Lighting").Blur.Enabled then
				if H then
					toTarget(H.HumanoidRootPart.CFrame * CFrame.new(0, 0, 50))
				end
				game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
				game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
				wait(2)
			elseif not H then
				GetPart = DetectPartSpawnMob("Marine Commodore")
				toTarget(GetPart.CFrame * CFrame.new(0, 60, 0))
			else
				repeat
					task.wait()
					toTarget(H.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
				until not Settings["Auto UP Observation V2"] or not game:GetService("Lighting").Blur.Enabled
			end
		end
	end
end
FarmObservationSection.CreateToggle(
	{ Title = "Auto UP Observation V2", Desc = nil, Default = Settings["Auto UP Observation V2"] or false },
	function(y)
		if y then
			spawn(function()
				while Settings["Auto UP Observation V2"] and (wait(0.1)) do
					pcall(function()
						ObservationV2()
					end)
				end
			end)
		end
		SaveSettings("Auto UP Observation V2", y)
	end
)
FarmObservationSection.CreateToggle(
	{ Title = "Farm Observation", Desc = nil, Default = Settings["Farm Observation"] or false },
	function(y)
		if y then
			spawn(function()
				while Settings["Farm Observation"] and (wait(0.1)) do
					pcall(function()
						FarmObservation()
					end)
				end
			end)
		end
		SaveSettings("Farm Observation", y)
	end
)
FarmObservationSection.CreateToggle(
	{
		Title = "Farm Observation [ Hop Server ]",
		Desc = nil,
		Default = Settings["Farm Observation [ Hop Server ]"] or false,
	},
	function(y)
		if y and not Settings["Farm Observation"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Farm Observation plz", ShowTime = 5 })
		end
		SaveSettings("Farm Observation [ Hop Server ]", y)
	end
)
AutoKillMobSection = FarmotherMain.CreateSection("Auto Kill Mob")
function TableMob()
	local y, P, Y, H, C = {}, {}, next, require(game:GetService("ReplicatedStorage").Quests)
	for J, J in Y, H, C do
		for Y, Y in next, J, nil do
			for H, C in next, Y.Task, nil do
				if C > 1 then
					table.insert(P, H)
				end
			end
		end
	end
	if game:GetService("Workspace")._WorldOrigin.EnemySpawns:FindFirstChildWhichIsA("Part") then
		for Y, Y in pairs(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()) do
			if not string.find(Y.Name, "Boss") and y[Y.Name] == nil then
				y[Y.Name] = false
			end
		end
		if string.find(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()[1].Name, "Lv.") then
			for Y, Y in pairs(getnilinstances()) do
				if table.find(P, tostring(Y.Name:gsub(" %pLv. %d+%p", ""))) and y[Y.Name] == nil then
					y[Y.Name] = false
				end
			end
		else
			for Y, Y in pairs(getnilinstances()) do
				if table.find(P, Y.Name) and y[Y.Name] == nil then
					y[Y.Name] = false
				end
			end
		end
	end
	return y
end
AutoKillMobSection.CreateDropdown(
	{
		Title = "Select Mob",
		List = PrepareMultiSelectList(TableMob(), Settings["Select Mob"]),
		Search = true,
		Selected = true,
		Default = Settings["Select Mob"] or nil,
	},
	function(y, P)
		SaveSettings("Select Mob", y, P)
	end
)
function FarmSelectMob()
	if not StackFarmOther then
		return
	end
	local y = {}
	for P, Y in next, Settings["Select Mob"], nil do
		Y = P:gsub(" %pLv. %d+%p", "")
		table.insert(y, Y)
	end
	local P = DetectMob(y)
	if not P then
		if typeof(y) == "table" then
			if #N >= #y then
				N = {}
				return
			end
			local Y = DetectPartSpawnMob(DetectNameTablePart(y))
			if Y then
				table.insert(N, DetectNameTablePart(y))
				repeat
					wait()
					toTarget(Y.CFrame * CFrame.new(0, 60, 0))
				until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
					or (DetectMob(y))
					or not Settings["Kill Mob"]
				wait(1)
			end
		else
			local Y = DetectPartSpawnMob(y, true)
			if Y then
				Instance.new("IntValue", Y).Name = "Ignored"
				repeat
					wait()
					toTarget(Y.CFrame * CFrame.new(0, 60, 0))
				until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
					or (DetectMob(y))
					or not Settings["Kill Mob"]
				wait(1)
			else
				DeleteIgnoredMobSpawn()
			end
		end
	else
		repeat
			task.wait()
			sizepart(P)
			BringMob(P)
			UsedualFlock()
			ClickM1(P)
			if Settings["Select Weapon"] == "Blox Fruit" then
				toTarget(P.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
			else
				toTarget(P.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
			end
		until not IsMobAlive(P) or not Settings["Kill Mob"] or not StackFarmOther
	end
end
AutoKillMobSection.CreateToggle({ Title = "Kill Mob", Desc = nil, Default = Settings["Kill Mob"] or false }, function(y)
	if y then
		spawn(function()
			while Settings["Kill Mob"] and (task.wait(0.1)) do
				local P, P = pcall(function()
					FarmSelectMob()
				end)
				if P then
					print(P)
				end
			end
		end)
	end
	SaveSettings("Kill Mob", y)
end)
AutoKillBossSection = FarmotherMain.CreateSection("Auto Boss")
local y = {
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
function TableBoss()
	local P = {}
	for Y, Y in pairs(game.Workspace.Enemies:GetChildren()) do
		if table.find(y, Y.Name) then
			table.insert(P, Y.Name)
		end
	end
	for Y, Y in pairs(game.ReplicatedStorage:GetChildren()) do
		if table.find(y, Y.Name) then
			table.insert(P, Y.Name)
		end
	end
	return P
end
local y = AutoKillBossSection.CreateDropdown(
	{
		Title = "Select Boss",
		List = TableBoss(),
		Search = true,
		Selected = false,
		Default = Settings["Select Boss"] or nil,
	},
	function(P)
		SaveSettings("Select Boss", P)
	end
)
AutoKillBossSection.CreateButton({ Title = "Refresh Boss" }, function()
	y:GetNewList(TableBoss())
end)
function AutoKillBoss()
	local y = (function() if Settings["Kill All Boss"] then return (CheckNameBoss(TableBoss())) else return (CheckNameBoss(Settings["Select Boss"])) end end)()
	if y then
		repeat
			wait()
			sizepart(y)
			if Settings["Select Weapon"] == "Blox Fruit" then
				toTarget(y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
			else
				toTarget(y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
			end
			ClickM1(y)
			UsedualFlock()
		until not IsMobAlive(y) or not Settings["Kill Boss"]
	elseif Settings["Hop Server Find Boss"] then
		HopServer()
		wait(5)
	end
end
AutoKillBossSection.CreateToggle(
	{ Title = "Kill Boss", Desc = nil, Default = Settings["Kill Boss"] or false },
	function(y)
		spawn(function()
			while Settings["Kill Boss"] and (wait()) do
				pcall(function()
					AutoKillBoss()
				end)
			end
		end)
		SaveSettings("Kill Boss", y)
	end
)
AutoKillBossSection.CreateToggle(
	{ Title = "Kill All Boss", Desc = nil, Default = Settings["Kill All Boss"] or false },
	function(y)
		if y and not Settings["Kill Boss"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Kill Boss plz", ShowTime = 5 })
		end
		SaveSettings("Kill All Boss", y)
	end
)
AutoKillBossSection.CreateToggle(
	{ Title = "Hop Server Find Boss", Desc = nil, Default = Settings["Hop Server Find Boss"] or false },
	function(y)
		SaveSettings("Hop Server Find Boss", y)
	end
)
DFRaidMain = Main.CreatePage({ Page_Name = "Fruit and Raid, Dungeon", Page_Title = "Fruit and Raid and Dungeon Tab" })
DevilFruitSection = DFRaidMain.CreateSection("Devil Fruit")
DevilFruitSection.CreateToggle(
	{ Title = "Random Devil Fruit", Desc = nil, Default = Settings["Random Devil Fruit"] or false },
	function(y)
		SaveSettings("Random Devil Fruit", y)
	end
)
DevilFruitSection.CreateToggle(
	{ Title = "Auto Store Fruit", Desc = nil, Default = Settings["Auto Store Fruit"] or false },
	function(y)
		SaveSettings("Auto Store Fruit", y)
	end
)
DevilFruitSection.CreateDropdown(
	{
		Title = "Blox Fruit Sniper Shop",
		List = PrepareMultiSelectList(TableDevilFruit, Settings["Blox Fruit Sniper Shop"]),
		Search = true,
		Selected = true,
		Default = Settings["Blox Fruit Sniper Shop"] or nil,
	},
	function(y, P)
		SaveSettings("Blox Fruit Sniper Shop", y, P)
	end
)
DevilFruitSection.CreateToggle(
	{ Title = "Buy Blox Fruit Sniper Shop", Desc = nil, Default = Settings["Buy Blox Fruit Sniper Shop"] or false },
	function(y)
		SaveSettings("Buy Blox Fruit Sniper Shop", y)
	end
)
RaidsSection = DFRaidMain.CreateSection("Raids")
g, b, s, R = {}, next, require(game.ReplicatedStorage.Raids)
for y, y in b, s, R do
	for b, b in next, y, nil do
		table.insert(g, b)
	end
end
RaidsSection.CreateDropdown(
	{ Title = "Select Raid", List = g, Search = true, Selected = false, Default = Settings["Select Raid"] or nil },
	function(b)
		SaveSettings("Select Raid", b)
	end
)
RaidsSection.CreateToggle(
	{
		Title = "Get Fruit In Inventory Low Beli",
		Desc = nil,
		Default = Settings["Get Fruit In Inventory Low Beli"] or false,
	},
	function(b)
		SaveSettings("Get Fruit In Inventory Low Beli", b)
	end
)
getgenv().KillRaidEnemy = function()
	for b, b in ipairs(game.workspace.Enemies:GetChildren()) do
		if IsMobAlive(b) then
			b.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
		end
	end
end
getgenv().KillRaidEnemyLowhealth = function()
	for b, b in ipairs(game.workspace.Enemies:GetChildren()) do
		if IsMobAlive(b) and b.Humanoid.Health / b.Humanoid.MaxHealth < 0.2 then
			b.Humanoid.Health = 0
		end
	end
end
function DetectMobRaid()
	for b, b in ipairs(game.workspace.Enemies:GetChildren()) do
		if IsMobAlive(b) and t:DistanceFromCharacter(b.HumanoidRootPart.Position) <= 400 then
			return b
		end
	end
end
function BringMobNearst(b)
	if DaBringMob then
		delay(0.15, function()
			getgenv().DaBringMob = false
		end)
		return
	end
	if l and (t.Character.HumanoidRootPart.Position - b.HumanoidRootPart.Position).Magnitude <= 50 then
		for y, y in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
			if
				y ~= b
				and not y:FindFirstChild("Ignored")
				and (IsMobAlive(y))
				and (isnetworkowner2(y.HumanoidRootPart))
			then
				if (y.HumanoidRootPart.Position - l.Position).Magnitude <= 350 then
					sizepart(y)
					y.HumanoidRootPart.CFrame = l * CFrame.new(0, math.random(0, 2), math.random(0, 2))
					getgenv().DaBringMob = true
				end
			end
		end
	end
end
function BringMobRaid(b)
	if not Settings["Bring Mob"] then
		return
	end
	if b and E ~= b then
		E = b
		l = b.HumanoidRootPart.CFrame
		DeleteIgnoredMob()
	end
	if DaBringMob then
		delay(0.1, function()
			getgenv().DaBringMob = false
		end)
		return
	end
	local E = {}
	if not b:FindFirstChild("Ignored") then
		table.insert(E, b)
	end
	for y, y in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
		if
			y ~= b
			and y.Name == b.Name
			and not y:FindFirstChild("Ignored")
			and (IsMobAlive(y))
			and (isnetworkowner2(y.HumanoidRootPart))
		then
			if (y.HumanoidRootPart.Position - l.Position).Magnitude <= 200 and #E < 1 then
				table.insert(E, y)
			end
		end
	end
	if
		l
		and (t.Character.HumanoidRootPart.Position - b.HumanoidRootPart.Position).Magnitude <= 50
		and (isnetworkowner2(t.Character.HumanoidRootPart))
	then
		for b, b in pairs(E) do
			sizepart(b)
			b.HumanoidRootPart.CFrame = l * CFrame.new(0, math.random(0, 2), math.random(0, 2))
			task.spawn(function()
				local E = b.Humanoid.Health
				task.wait(3.5)
				if b.Humanoid.Health == E and not b:FindFirstChild("Ignored") then
					b.HumanoidRootPart.CFrame = b.WorldPivot
					Instance.new("IntValue", b).Name = "Ignored"
					task.wait(0.3)
				end
			end)
			getgenv().DaBringMob = true
		end
	end
end
function GetLastRaidIsland()
	local b, E = 0
	for l, y in ipairs(wOrigin.Locations:GetChildren()) do
		if string.find(y.Name, "Island ") and t:DistanceFromCharacter(y.Position) < 3000 then
			l = tonumber((y.Name:gsub("Island ", "")))
			if b < l then
				b, E = l, y
			end
		end
	end
	return E
end
function CheckInRaid()
	for b, b in ipairs(wOrigin.Locations:GetChildren()) do
		if string.find(b.Name, "Island ") and t:DistanceFromCharacter(b.Position) < 3000 then
			return true
		end
	end
end
function CheckAutoRaid()
	if
		not getgenv().buychip
		or game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and (CheckInRaid())
	then
		return true
	end
end
getgenv().CheckIsplayingRaid = function()
	if
		DetectItemPlr("Special Microchip")
		or not getgenv().buychip
		or game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and (CheckInRaid())
	then
		return true
	end
end
getgenv().buychip = true
RaidsSection.CreateToggle({ Title = "Auto Raid", Desc = nil, Default = Settings["Auto Raid"] or false }, function(b)
	if b then
		spawn(function()
			while Settings["Auto Raid"] and (task.wait()) do
				local E, E = pcall(function()
					local l = game.PlaceId == getgenv().CheckPlaceId2
						and (game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button:FindFirstChild("Main"))
					l = (function() if game.PlaceId == getgenv().CheckPlaceId then return game:GetService("Workspace").Map:FindFirstChild("Boat Castle") and (game:GetService(
							"Workspace"
						).Map["Boat Castle"].RaidSummon2.Button
							:FindFirstChild("Main")) else return l end end)()
					print("cc")
					if not t.PlayerGui.Main.TopHUDList.RaidTimer.Visible and not CheckInRaid() then
						if getgenv().TickTeleCastle and tick() - getgenv().TickTeleCastle < 5 then
							return
						end
						if not l then
							if not DetectItemPlr("Special Microchip") then
								toTarget(CFrame.new(-5500, 314, -2855))
							else
								toTarget(CFrame.new(-5500, 314, -2855), false, true)
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
						fireclickdetector(l.ClickDetector)
						getgenv().TickTeleCastle = tick()
						if getgenv().Tween then
							getgenv().Tween:Pause()
							getgenv().Tween:Cancel()
						end
						return
					end
					if t.PlayerGui.Main.TopHUDList.RaidTimer.Visible and (CheckInRaid()) then
						getgenv().waitgoraid = true
						getgenv().buychip = true
						l = DetectMobRaid()
						if l then
							repeat
								task.wait()
								if not getgenv().KillMobRaid and Settings["Kill Aura Only Raid And Volcano"] then
									getgenv().KillMobRaid = true
									local y = Settings["Time Delay Kill"] or 5
									l.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
									delay(y, function()
										getgenv().KillMobRaid = false
									end)
								end
								UsedualFlock()
								ClickM1(l)
								sizepart(l)
								BringMobRaid(l)
								if Settings["Select Weapon"] == "Blox Fruit" then
									toTarget(l.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									toTarget(l.HumanoidRootPart.CFrame * CFrame.new(10, 20, 0))
								end
							until not IsMobAlive(l)
						else
							local y = GetLastRaidIsland()
							if y then
								if y.Name == "Island 2" and Settings["Select Raid"] == "Phoenix" then
									toTarget(y.CFrame * CFrame.new(300, 60, 0))
								else
									toTarget(y.CFrame * CFrame.new(0, 60, 0))
								end
							end
						end
						return
					end
					if
						getgenv().buychip
						and t.Data.Level.Value >= 1100
						and not t.PlayerGui.Main.TopHUDList.RaidTimer.Visible
						and not DetectItemPlr("Special Microchip")
						and not CheckInRaid()
					then
						if Settings["Hop Sever Raid"] then
							l = GetPathFruit()
							if l then
								if not ((l.Handle.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 5) then
									toTarget(l.Handle.CFrame, true)
								end
								return
							elseif not CheckFruitplr() then
								HopServer()
								wait(5)
								return
							end
						end
						if
							not CheckFruitplr()
							and (TakeFruitInventory(true))
							and Settings["Get Fruit In Inventory Low Beli"]
						then
							game:GetService("ReplicatedStorage").Remotes.CommF_
								:InvokeServer("LoadFruit", TakeFruitInventory(true))
						end
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Check")
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
							"RaidsNpc",
							"Select",
							Settings["Select Raid"] or "Flame"
						)
						wait(1)
					end
				end)
				if E then
					print(E)
				end
			end
		end)
	end
	SaveSettings("Auto Raid", b)
end)
RaidsSection.CreateToggle(
	{ Title = "Hop Sever Raid", Desc = nil, Default = Settings["Hop Sever Raid"] or false },
	function(b)
		if b and not Settings["Auto Raid"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Auto Raid Plz", ShowTime = 5 })
		end
		SaveSettings("Hop Sever Raid", b)
	end
)
RaidsSection.CreateToggle(
	{ Title = "Auto Awake Fruit", Desc = nil, Default = Settings["Auto Awake Fruit"] or false },
	function(b)
		SaveSettings("Auto Awake Fruit", b)
	end
)
MultiRaidsSection = DFRaidMain.CreateSection("Multi Raid")
function DetectNamePlayerMulti()
	local b = {}
	for E, E in pairs(game:GetService("Players"):GetChildren()) do
		if E.Name ~= t.Name then
			b[E.Name] = false
		end
	end
	return b
end
DropdownSelectPlayerMultiRaid = MultiRaidsSection.CreateDropdown(
	{
		Title = "Select Player Multi Raid",
		List = PrepareMultiSelectList(DetectNamePlayerMulti(), Settings["Select Player Multi Raid"]),
		Search = true,
		Selected = true,
		Default = Settings["Select Player Multi Raid"] or nil,
	},
	function(b, E)
		SaveSettings("Select Player Multi Raid", b, E)
	end
)
MultiRaidsSection.CreateButton({ Title = "Refresh Player" }, function()
	DropdownSelectPlayerMultiRaid:GetNewList(DetectNamePlayerMulti())
end)
MultiRaidsSection.CreateToggle(
	{ Title = "Account Buy Chip", Desc = nil, Default = Settings["Account Buy Chip"] or false },
	function(b)
		SaveSettings("Account Buy Chip", b)
	end
)
MultiRaidsSection.CreateToggle(
	{ Title = "Account Pick Slot Raid", Desc = nil, Default = Settings["Account Pick Slot Raid"] or false },
	function(b)
		SaveSettings("Account Pick Slot Raid", b)
	end
)
function DetectSlotRaid(b)
	local E, l, y = next, b:GetChildren()
	for b, b in E, l, y do
		if b:FindFirstChild("Hitbox") and b.Color.BrickColor.Name ~= "Lime green" then
			return b
		end
	end
end
function NearSlotRaid(b)
	local E, l, y = next, b:GetChildren()
	for b, b in E, l, y do
		if b:FindFirstChild("Hitbox") then
			if t:DistanceFromCharacter(b.Hitbox.Position) < 10 then
				return true
			end
		end
	end
end
function DetectMultiStartRaid(b)
	local E = {}
	if Settings["Select Player Multi Raid"] then
		local l, y, P = next, b:GetChildren()
		for b, b in l, y, P do
			if b:FindFirstChild("Hitbox") then
				for l, y in next, Settings["Select Player Multi Raid"], nil do
					if game.Players[l]:DistanceFromCharacter(b.Hitbox.Position) > 10 then
						table.insert(E, l)
					end
				end
			end
		end
	end
	if #E == 0 then
		return true
	end
end
function Multiraid(b)
	local E = game.PlaceId == getgenv().CheckPlaceId2
		and (game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button:FindFirstChild("Main"))
	E = (function() if game.PlaceId == getgenv().CheckPlaceId then return game:GetService("Workspace").Map:FindFirstChild("Boat Castle")
			and (game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button:FindFirstChild("Main")) else return E end end)()
	if not t.PlayerGui.Main.TopHUDList.RaidTimer.Visible and not CheckInRaid() then
		if not E then
			if not DetectItemPlr("Special Microchip") then
				toTarget(CFrame.new(-5500, 314, -2855))
			else
				toTarget(CFrame.new(-5500, 314, -2855), false, true)
			end
			return
		end
	end
	if Settings["Account Pick Slot Raid"] then
		if
			not t.PlayerGui.Main.TopHUDList.RaidTimer.Visible
			and not CheckInRaid()
			and not NearSlotRaid(E.Parent.Parent)
		then
			local l = Random.new():NextNumber(0, 2)
			task.wait(l)
			toTarget(DetectSlotRaid(E.Parent.Parent).Hitbox.CFrame * CFrame.new(0, -2, 0))
		end
	end
	if DetectItemPlr("Special Microchip") then
		if getgenv().waitgoraid then
			wait(5)
			getgenv().waitgoraid = false
		end
		getgenv().buychip = false
		if DetectMultiStartRaid(E.Parent.Parent) and Settings["Account Buy Chip"] then
			fireclickdetector(E.ClickDetector)
		end
		if getgenv().Tween then
			getgenv().Tween:Pause()
			getgenv().Tween:Cancel()
		end
		return
	end
	if t.PlayerGui.Main.TopHUDList.RaidTimer.Visible and (CheckInRaid()) then
		getgenv().waitgoraid = true
		getgenv().buychip = true
		E = DetectMobRaid()
		if E then
			repeat
				task.wait()
				UsedualFlock()
				ClickM1(E)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(E.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(E.HumanoidRootPart.CFrame * CFrame.new(10, 20, 0))
				end
			until not IsMobAlive(E)
		else
			local E = GetLastRaidIsland()
			if E then
				if E.Name == "Island 2" and Settings["Select Raid"] == "Phoenix" then
					toTarget(E.CFrame * CFrame.new(300, 60, 0))
				else
					toTarget(E.CFrame * CFrame.new(0, 60, 0))
				end
			end
		end
		return
	end
	if
		Settings["Account Buy Chip"]
		and getgenv().buychip
		and t.Data.Level.Value >= 1100
		and not t.PlayerGui.Main.TopHUDList.RaidTimer.Visible
		and not DetectItemPlr("Special Microchip")
		and not CheckInRaid()
	then
		if not CheckFruitplr() and (TakeFruitInventory(true)) and Settings["Get Fruit In Inventory Low Beli"] then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", TakeFruitInventory(true))
		end
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Check")
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", b or "Flame")
		wait(1)
	end
end
MultiRaidsSection.CreateToggle(
	{ Title = "Auto Multi Raid", Desc = nil, Default = Settings["Auto Multi Raid"] or false },
	function(b)
		if b then
			spawn(function()
				while Settings["Auto Multi Raid"] and (task.wait(0.1)) do
					local E, E = pcall(function()
						Multiraid(Settings["Select Raid"])
					end)
					if E then
						print(E)
					end
				end
			end)
		end
		SaveSettings("Auto Multi Raid", b)
	end
)
local b = require(game:GetService("ReplicatedStorage").Controllers.BannerClient)
local function E()
	local l = b.TryGetBannerItemIfActiveAsync()
	if l and l.BoxName then
		return l.BoxName, l
	end
	return "DLCBoxData", nil
end
local function b()
	-- chạy thẳng lệnh mua gacha từ xa
	local ok, res = pcall(function()
		return game:GetService("ReplicatedStorage").Modules.Net["RF/GachaNetworkRF"]:InvokeServer({
			Context = "Purchase",
			BoxName = "ZiolesGacha",
		})
	end)
	if getgenv().DebugGacha then
		print("[Gacha] Purchase ok=", ok, "res=", typeof(res), tostring(res))
	end
	return ok and res ~= nil and res ~= false
end
function RandomFruit()
	b()
end
function DetectCountDF()
	local b = getbackpack()
	if #b < 1 then
		return
	end
	local E, l = t.Data.FruitCap.Value, B()
	for y, P in b, nil, nil do
		y = P:GetAttribute("OriginalName")
		for b, b in l, nil, nil do
			if b.Type == "Blox Fruit" and (b.Name == y and b.Count < E or b.Name ~= y) then
				return true
			end
		end
	end
end
local b = require(game:GetService("ReplicatedStorage").FruitInfo)
function StoreFruit(E)
	for l, y in pairs(E:GetChildren()) do
		if y:IsA("Tool") and (string.find(y.Name, "Fruit")) and not y:FindFirstChild("Ignored") then
			l = string.gsub(y.Name, " Fruit", "")
			local E
			E = y:GetAttribute("OriginalName") or l .. "-" .. l
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", E, y)
			end)
			local l = Instance.new("IntValue")
			l.Name = "Ignored"
			l.Parent = y
			if
				Settings["Webhook Store Fruit"]
				and Settings["Select Rarity Fruit"]
				and (b.List[E] and Settings["Select Rarity Fruit"][b.List[E].Rarity.Name] or SkinFruit[y.Name])
			then
				getgenv().WebhookStoreFruit(y.Name)
			end
			task.wait(2)
		end
	end
end
function DetectFruitShop()
	local b, E, l = next, game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false)
	for y, y in b, E, l do
		if Settings["Blox Fruit Sniper Shop"][y.Name] then
			if y.OnSale then
				return y.Name
			end
		end
	end
end
function BuyFruitShop()
	local b = DetectFruitShop()
	if not Settings["Blox Fruit Sniper Shop"][game:GetService("Players").LocalPlayer.Data.DevilFruit.Value] and b then
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", b)
	end
end
DungeonJoinSection = DFRaidMain.CreateSection("Join Dungeon")
function DetectNamePlayer()
	local b = {}
	for E, E in pairs(game:GetService("Players"):GetChildren()) do
		if E.Name ~= t.Name and not table.find(b, E.Name) then
			table.insert(b, E.Name)
		end
	end
	return b
end
DropdownDropdownSelectAccountJoin = DungeonJoinSection.CreateDropdown(
	{
		Title = "Select Account Join",
		List = DetectNamePlayer(),
		Search = true,
		Selected = false,
		Default = Settings["Select Account Join"] or nil,
	},
	function(b)
		SaveSettings("Select Account Join", b)
	end
)
DungeonJoinSection.CreateButton({ Title = "Refresh Player" }, function()
	DropdownDropdownSelectAccountJoin:GetNewList(DetectNamePlayer())
end)
function DetectPadJoinDungeon(b)
	local E, l, y = next, workspace.Map["Simulation Hub"].Pads:GetChildren()
	for P, P in E, l, y do
		if
			b and P:GetAttribute("Initiator") == game.Players.LocalPlayer.UserId
			or P:GetAttribute("NumPlayersOnPad") == 0
		then
			return P
		end
	end
end
DungeonJoinSection.CreateSlider(
	{
		Title = "Min Player Join Dungeon",
		Min = 0,
		Max = 4,
		Default = Settings["Min Player Join Dungeon"] or 2,
		Precise = true,
	},
	function(b)
		SaveSettings("Min Player Join Dungeon", b)
	end
)
DungeonJoinSection.CreateDropdown(
	{
		Title = "Select Difficulty",
		List = { "Normal", "Hard", "Challenge" },
		Search = true,
		Selected = false,
		Default = Settings["Select Difficulty"] or nil,
	},
	function(b)
		SaveSettings("Select Difficulty", b)
	end
)
DungeonJoinSection.CreateToggle(
	{
		Title = "Account Start Dungeon",
		Desc = "Account Start Dungeon",
		Default = Settings["Account Start Dungeon"] or false,
	},
	function(b)
		SaveSettings("Account Start Dungeon", b)
	end
)
DungeonJoinSection.CreateToggle(
	{ Title = "Auto Join Dungeon", Desc = "Auto Join Dungeon", Default = Settings["Auto Join Dungeon"] or false },
	function(b)
		spawn(function()
			while Settings["Auto Join Dungeon"] and (task.wait()) do
				local E, E = pcall(function()
					if
						game:GetService("ReplicatedStorage").DungeonReplicationObjects:FindFirstChildWhichIsA("Folder")
					then
						return
					end
					if Settings["Account Start Dungeon"] then
						if
							not game:GetService("Players").LocalPlayer.PlayerGui
								:FindFirstChild("DungeonQueueSettingsMenu")
							or not game:GetService("Players").LocalPlayer.PlayerGui.DungeonQueueSettingsMenu.Enabled
						then
							local l = DetectPadJoinDungeon()
							if l then
								toTarget(l.PrimaryPart.CFrame * CFrame.new(0, 5, 0))
							end
						else
							local l = DetectPadJoinDungeon(true)
							local y, P =
								l and (l:GetAttribute("NumPlayersOnPad")) or 0,
								Settings["Select Difficulty"] or "Normal"
							if l:GetAttribute("Difficulty") ~= P then
								l.DungeonSettingsChanged:FireServer(unpack({ [1] = "Difficulty", [2] = P }))
							end
							if y >= Settings["Min Player Join Dungeon"] then
								l:FindFirstChild("DungeonSettingsChanged"):FireServer("Start")
								wait(2)
							end
						end
					elseif
						not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("DungeonQueueSettingsMenu")
						or not game:GetService("Players").LocalPlayer.PlayerGui.DungeonQueueSettingsMenu.Enabled
					then
						local l = game:GetService("Players"):FindFirstChild(Settings["Select Account Join"] or "")
						if l then
							toTarget(l.Character.HumanoidRootPart.CFrame)
						end
					end
				end)
				if E then
					print(E)
				end
			end
		end)
		SaveSettings("Auto Join Dungeon", b)
	end
)
DungeonSection = DFRaidMain.CreateSection("Dungeon")
DungeonSection.CreateDropdown(
	{
		Title = "Select Weapon Dungeon",
		List = { "Melee", "Sword", "Blox Fruit", "Gun" },
		Search = true,
		Selected = false,
		Default = Settings["Select Weapon Dungeon"] or nil,
	},
	function(b)
		SaveSettings("Select Weapon Dungeon", b)
	end
)
function GetInfoDungeon(b)
	local E = game.ReplicatedStorage:WaitForChild("DungeonReplicationObjects"):FindFirstChild(b, true)
	if E then
		return E
	end
end
function GetCurrentFloor()
	local b = t:GetAttribute("ExplorerGUID")
	local E = b and (GetInfoDungeon(b))
	if E then
		return E:GetAttribute("FloorId")
	end
end
function GetHightFloor()
	local b = t:GetAttribute("ExplorerGUID")
	local E = b and (GetInfoDungeon(b))
	if E then
		return E.Parent.Parent:GetAttribute("CurrentExploredLevel")
	end
end
function IsPointInsideModel(b, E)
	if not b or not b:IsA("Model") then
		return false
	end
	local l, y = b:GetBoundingBox()
	local b, P = l:PointToObjectSpace(E), y * 0.5
	return math.abs(b.X) <= P.X and math.abs(b.Y) <= P.Y and math.abs(b.Z) <= P.Z
end
function DetectMobDungeon()
	local b = t.Character
	local E = b and (b:FindFirstChild("HumanoidRootPart"))
	if not E then
		return nil
	end
	b = GetHightFloor()
	if not b then
		return nil
	end
	local l = workspace.Map.Dungeon:FindFirstChild(tostring(b))
	if not l then
		return nil
	end
	local y, P = 1 / 0
	for Y, H in ipairs(workspace.Enemies:GetChildren()) do
		if IsMobAlive(H) and H.Name ~= "Blank Buddy" then
			Y = H:FindFirstChild("HumanoidRootPart")
			H:FindFirstChildOfClass("Humanoid")
			if IsPointInsideModel(l, Y.Position) then
				b = (Y.Position - E.Position).Magnitude
				if b < y then
					y, P = b, H
				end
			end
		end
	end
	return P
end
function DetectPropHitboxPlaceholder()
	local b = t.Character
	local E = b and (b:FindFirstChild("HumanoidRootPart"))
	if not E then
		return nil
	end
	b = GetHightFloor()
	if not b then
		return nil
	end
	local l = workspace.Map.Dungeon:FindFirstChild(tostring(b))
	if not l then
		return nil
	end
	local y, P = 1 / 0
	for Y, H in ipairs(workspace.Enemies:GetChildren()) do
		if IsMobAlive(H) and H.Name == "PropHitboxPlaceholder" then
			b = H:FindFirstChild("HumanoidRootPart")
			H:FindFirstChildOfClass("Humanoid")
			if IsPointInsideModel(l, b.Position) then
				Y = (b.Position - E.Position).Magnitude
				if Y < y then
					y, P = Y, H
				end
			end
		end
	end
	return P
end
ExplorerBuffs = require(game:GetService("ReplicatedStorage").DungeonShared.ExplorerBuffs)
function stripFont(b)
	return (b:gsub("<.->", ""))
end
DisplayNameToKey = {}
for b, E in pairs(ExplorerBuffs.ExplorerBuffs) do
	if E.DisplayName then
		DisplayNameToKey[stripFont(E.DisplayName)] = b
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
for b, E in ipairs(CORE_BUFF_KEYS) do
	b = ExplorerBuffs.ExplorerBuffs[E]
	if b and b.DisplayName then
		table.insert(TableCardpriority, stripFont(b.DisplayName))
	end
end
function BuildPriorityMap(b)
	local E = {}
	for l, y in ipairs(b) do
		l = DisplayNameToKey[y]
		if l then
			E[l] = true
		end
	end
	return E
end
function IsSkillCooldown(b)
	if not b then
		return false
	end
	if b:find("Cooldown") then
		if b:find("ZCooldown") or (b:find("XCooldown")) or (b:find("CCooldown")) or (b:find("VCooldown")) then
			return true
		end
	end
	return false
end
DungeonSection.CreateDropdown(
	{
		Title = "Select Card Priority",
		List = TableCardpriority,
		Search = true,
		Priority = true,
		Default = Settings["Select Card Priority"] or {},
	},
	function(b)
		if typeof(b) ~= "table" then
			return
		end
		SaveSettings("Select Card Priority", table.clone(b))
	end
)
function AutoPickDungeonCard()
	local b, E, l, y = Settings["Select Card Priority"] or {}, {}, 1 / 0
	for P, Y in pairs(t.PlayerGui:GetChildren()) do repeat 
		local H, C, J =
			Y:FindFirstChild("DisplayName", true),
			Y:FindFirstChild("BuffDescription", true),
			Y:FindFirstChildWhichIsA("TextButton", true)
		if H and C and J and (H:IsA("TextLabel")) then
			P = DisplayNameToKey[stripFont(H.Text)]
			if P then
				if IsSkillCooldown(P) then
					break
				end
				for Y, H in ipairs(b) do
					if DisplayNameToKey[H] == P then
						if Y < l then
							l, y = Y, J
						end
						break
					end
				end
				table.insert(E, J)
			end
		end
	until true end
	if y then
		print("AUTO PICK (PRIORITY INDEX):", l)
		for l, l in pairs(getconnections(y.Activated)) do
			l.Function()
		end
		return true
	end
	if #E > 0 then
		b = E[math.random(1, #E)]
		print("AUTO PICK (RANDOM)")
		for E, E in pairs(getconnections(b.Activated)) do
			E.Function()
		end
		return true
	end
	return false
end
DungeonSection.CreateToggle(
	{
		Title = "Auto Attack Dungeon",
		Desc = "Auto Attack Mob and go next Floor",
		Default = Settings["Auto Attack Dungeon"] or false,
	},
	function(b)
		SaveSettings("Auto Attack Dungeon", b)
		if not b then
			return
		end
		task.spawn(function()
			while Settings["Auto Attack Dungeon"] do
				task.wait()
				local b, b = pcall(function()
					if t.Character.Humanoid.Health <= 0 then
						return
					end
					local E, l = GetCurrentFloor(), GetHightFloor()
					if not E or not l then
						return
					end
					if E ~= l then
						getgenv().AutoDungeonNextFloor = true
						local y = l - 1
						local P = workspace.Map.Dungeon:FindFirstChild(tostring(y))
						if
							P
							and (P:FindFirstChild("ExitTeleporter"))
							and (P.ExitTeleporter:FindFirstChild("Root"))
							and (P.ExitTeleporter.Root:FindFirstChild("TouchInterest"))
						then
							if t:DistanceFromCharacter(P.ExitTeleporter.Root.Position) > 15 then
								task.wait(1)
								toTarget(P.ExitTeleporter.Root.CFrame * CFrame.new(0, 5, 0))
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
					l, E = DetectMobDungeon(), DetectPropHitboxPlaceholder()
					if not l or not IsMobAlive(l) then
						return
					end
					if E then
						repeat
							task.wait()
							if not Settings["Auto Attack Dungeon"] then
								break
							end
							if not IsMobAlive(E) then
								break
							end
							if not GetCurrentFloor() or GetCurrentFloor() ~= GetHightFloor() then
								break
							end
							local y = Settings["Select Weapon Dungeon"] or "Melee"
							equiptool(NameWeapon(y))
							if y == "Gun" then
								if NameWeapon(y) == "Dragonstorm" then
									SpamGunDragonStorm(E.HumanoidRootPart)
								else
									ShootM1(E)
								end
							else
								ClickM1Dungeon(E)
							end
							sizepart(E)
							if y == "Blox Fruit" then
								toTarget(E.HumanoidRootPart.CFrame * CFrame.new(-7, 12, 0))
							else
								toTarget(E.HumanoidRootPart.CFrame * CFrame.new(10, 20, 0))
							end
						until t.Character.Humanoid.Health <= 0
					else
						repeat
							task.wait()
							if not Settings["Auto Attack Dungeon"] then
								break
							end
							if not IsMobAlive(l) then
								break
							end
							if not GetCurrentFloor() or GetCurrentFloor() ~= GetHightFloor() then
								break
							end
							local E = Settings["Select Weapon Dungeon"] or "Melee"
							equiptool(NameWeapon(E))
							if E == "Gun" then
								if NameWeapon(E) == "Dragonstorm" then
									SpamGunDragonStorm(l.HumanoidRootPart)
								else
									ShootM1(l)
								end
							else
								ClickM1Dungeon(l)
							end
							sizepart(l)
							if E == "Blox Fruit" then
								toTarget(l.HumanoidRootPart.CFrame * CFrame.new(-7, 12, 0))
							else
								toTarget(l.HumanoidRootPart.CFrame * CFrame.new(10, 20, 0))
							end
						until t.Character.Humanoid.Health <= 0 or (DetectPropHitboxPlaceholder())
					end
				end)
				if b then
					warn("[Auto Dungeon Error]:", b)
				end
			end
		end)
	end
)
DungeonSection.CreateToggle(
	{ Title = "Auto Pick Card Dungeon", Desc = nil, Default = Settings["Auto Pick Card Dungeon"] or false },
	function(b)
		SaveSettings("Auto Pick Card Dungeon", b)
		if not b then
			return
		end
		task.spawn(function()
			while Settings["Auto Pick Card Dungeon"] do
				task.wait()
				local b, b = pcall(function()
					AutoPickDungeonCard()
				end)
				if b then
					warn("[Auto Pick Card Dungeon Error]:", b)
				end
			end
		end)
	end
)
local b, E =
	{
		["Zone 1"] = CFrame.new(-21767.4765625, 0, 5815.41259765625),
		["Zone 2"] = CFrame.new(-26017.931640625, 0, 5657.8837890625),
		["Zone 3"] = CFrame.new(-29545.703125, 0, 6377.98974609375),
		["Zone 4"] = CFrame.new(-33609.7578125, 0, 7422.890625),
		["Zone 5"] = CFrame.new(-38480.42578125, 0, 10350.943359375),
		["Zone 6"] = CFrame.new(-32975.9921875, 0, 25963.7109375),
	},
	{ Melee = false, Sword = false, Gun = false, ["Blox Fruit"] = false }
SeaEventTab = Main.CreatePage({ Page_Name = "Sea Event", Page_Title = "Sea Event Tab" })
SettingSeaEventSection = SeaEventTab.CreateSection("Setting")
SettingSeaEventSection.CreateDropdown(
	{
		Title = "Select Zone",
		List = { "Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Zone 6" },
		Search = true,
		Selected = false,
		Default = Settings["Select Zone"] or nil,
	},
	function(l)
		SaveSettings("Select Zone", l)
	end
)
SettingSeaEventSection.CreateDropdown(
	{
		Title = "Select Sea Events",
		List = PrepareMultiSelectList(
			{
				SeaBeast = false,
				Ship = false,
				Shark = false,
				Terrorshark = false,
				Piranha = false,
				["Only Farm Ship Brigade"] = false,
			},
			Settings["Select Sea Events"]
		),
		Search = true,
		Selected = true,
		Default = Settings["Select Sea Events"] or nil,
	},
	function(l, y)
		SaveSettings("Select Sea Events", l, y)
	end
)
SettingSeaEventSection.CreateDropdown(
	{
		Title = "Select Boat",
		List = { "Beast Hunter", "Guardian", "Lantern", "Seleigh", "Brigade", "GrandBrigade" },
		Search = true,
		Selected = false,
		Default = Settings["Select Boat"] or nil,
	},
	function(l)
		SaveSettings("Select Boat", l)
	end
)
SettingSeaEventSection.CreateDropdown(
	{
		Title = "Select Weapons Use Skill",
		List = PrepareMultiSelectList(E, Settings["Select Weapons Use Skill"]),
		Search = true,
		Selected = true,
		Default = Settings["Select Weapons Use Skill"] or nil,
	},
	function(l, y)
		SaveSettings("Select Weapons Use Skill", l, y)
	end
)
SettingSeaEventSection.CreateToggle(
	{
		Title = "Use Dragonstorm For Sea Event",
		Desc = "Only Farm Boat and Fish and TerrorShark",
		Default = Settings["Use Dragonstorm For Sea Event"] or false,
	},
	function(l)
		SaveSettings("Use Dragonstorm For Sea Event", l)
	end
)
SettingSeaEventSection.CreateToggle(
	{
		Title = "Use Click M1 Skull Guitar For Sea Event",
		Desc = "Only Farm Boat and Seabeast",
		Default = Settings["Use Click M1 Skull Guitar For Sea Event"] or false,
	},
	function(l)
		SaveSettings("Use Click M1 Skull Guitar For Sea Event", l)
	end
)
SettingSeaEventSection.CreateToggle(
	{
		Title = "Auto Change Dragonstorm With Skull Guitar",
		Desc = "When Kill Boat and Fish and TerrorShark use Dragonstorm\10Kill Seabeast use Seabeast",
		Default = Settings["Auto Change Dragonstorm With Skull Guitar"] or false,
	},
	function(l)
		SaveSettings("Auto Change Dragonstorm With Skull Guitar", l)
	end
)
SettingSeaEventSection.CreateToggle(
	{
		Title = "Auto Change Dragonstorm When Kill Boat",
		Desc = nil,
		Default = Settings["Auto Change Dragonstorm When Kill Boat"] or false,
	},
	function(l)
		SaveSettings("Auto Change Dragonstorm When Kill Boat", l)
	end
)
SettingSeaEventSection.CreateToggle(
	{
		Title = "Use Click M1 Fruit For Sea Event",
		Desc = nil,
		Default = Settings["Use Click M1 Fruit For Sea Event"] or false,
	},
	function(l)
		SaveSettings("Use Click M1 Fruit For Sea Event", l)
	end
)
SettingSeaEventSection.CreateToggle(
	{
		Title = "Reset Character Buy Boat",
		Desc = "if u spawn in tiki it will reset for buy boat",
		Default = Settings["Reset Character Buy Boat"] or false,
	},
	function(l)
		SaveSettings("Reset Character Buy Boat", l)
	end
)
SettingSeaEventSection.CreateToggle(
	{ Title = "Auto Dodge Skill Terrorshark", Desc = nil, Default = Settings["Auto Dodge Skill Terrorshark"] or false },
	function(l)
		SaveSettings("Auto Dodge Skill Terrorshark", l)
	end
)
local l = { "rbxassetid://8708221792", "rbxassetid://8708222556" }
game.workspace._WorldOrigin.ChildAdded:Connect(function(y)
	if
		(Settings["Auto Sea Event"] or Settings["Auto Shipwright"])
		and Settings["Auto Dodge Skill Terrorshark"]
		and getgenv().PathTerrorshark
	then
		if
			y:IsA("Part")
			and (y.Name == "SharkSplash" or y.Name == "ChargeUp")
			and (getgenv().PathTerrorshark.HumanoidRootPart.Position - y.Position).Magnitude < 20
		then
			getgenv().Doding = true
			getgenv().ReadyToDodge = true
			local P = tick()
			repeat
				wait(0.2)
			until not y or not y.Parent or tick() - P > 14
			if tick() - P < 1 then
				wait(2.5)
			end
			getgenv().Doding = false
			getgenv().ReadyToDodge = false
		end
	end
end)
getgenv().PosDodgeskill = 0
function AddAnimationSeabeastPlayed(y)
	getgenv().PathAnimationSeabit = y.Humanoid.AnimationPlayed:Connect(function(y)
		if table.find(l, tostring(y.Animation.AnimationId)) then
			getgenv().PosDodgeskill = 0
			if tostring(y.Animation.AnimationId) == "rbxassetid://8708222556" then
				task.wait(0.7)
			else
				task.wait(1.9)
			end
			local l = tick()
			getgenv().PosDodgeskill = 600
			repeat
				task.wait()
			until not y.IsPlaying or tick() - l >= 10
			getgenv().PosDodgeskill = 0
		end
	end)
end
SettingSeaEventSection.CreateToggle(
	{
		Title = "Auto Dodge Skill Seabeast",
		Desc = "Dodge Only Skill Kameha and waterbeam",
		Default = Settings["Auto Dodge Skill Seabeast"] or false,
	},
	function(l)
		if l then
			spawn(function()
				while Settings["Auto Dodge Skill Seabeast"] and (task.wait(0.15)) do
					pcall(function()
						if getgenv().PathSeaBeast then
							local y = getgenv().PathSeaBeast
							spawn(function()
								AddAnimationSeabeastPlayed(y)
							end)
							repeat
								wait(0.1)
							until not y
								or not y.Parent
								or getgenv().PathSeaBeast ~= y
								or not Settings["Auto Dodge Skill Seabeast"]
							if getgenv().PathAnimationSeabit then
								getgenv().PathAnimationSeabit:Disconnect()
							end
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Dodge Skill Seabeast", l)
	end
)
SettingSeaEventSection.CreateToggle(
	{
		Title = "Teleport Boat Other CFrame if Rough Sea",
		Desc = nil,
		Default = Settings["Teleport Boat Other CFrame if Rough Sea"] or false,
	},
	function(l)
		SaveSettings("Teleport Boat Other CFrame if Rough Sea", l)
	end
)
SettingSeaEventSection.CreateToggle(
	{
		Title = "Tween Until Have Sea Event",
		Desc = "When there's a sea event, it will stop to fight, and after finishing the fight, it will continue tweening",
		Default = Settings["Tween Until Have Sea Event"] or false,
	},
	function(l)
		SaveSettings("Tween Until Have Sea Event", l)
	end
)
SettingSeaEventSection.CreateToggle(
	{ Title = "Will Back When over 10km", Desc = nil, Default = Settings["Will Back When over 10km"] or false },
	function(l)
		SaveSettings("Will Back When over 10km", l)
	end
)
local function l(y)
	local P = t and t.Character
	if not P then
		return
	end
	for Y, Y in ipairs(P:GetDescendants()) do
		if Y:IsA("BasePart") then
			Y.CanCollide = not y
		end
	end
end
local y, P, Y = setmetatable({}, { __mode = "k" }), 0, getgenv().BoatSpeed
if type(Y) ~= "table" then
	Y = { cap = 100, ceiling = 1 / 0, nextRaise = 0 }
	getgenv().BoatSpeed = Y
end
local H = 5
local function C()
	local J, F = pcall(function()
		return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
	end)
	return J and F / 1000 or 0.1
end
function manageTween(J, F, q, c)
	if not J or not J:IsA("BasePart") or typeof(F) ~= "CFrame" then
		return
	end
	q, c = math.max(tonumber(Settings["Value Speed Tween Boat"]) or (tonumber(q)) or 350, 1), c or "TweenBoat"
	if not y[J] and (J.Position - F.Position).Magnitude <= H then
		return
	end
	local D = y[J]
	if D and D.TweenKey == c and D.PlaybackState == Enum.PlaybackState.Playing then
		D.Target = F
		D.Speed = q
		getgenv()[c] = D
		return D
	end
	if D then
		D:Cancel()
	end
	local D = getgenv()[c]
	if D then
		pcall(function()
			D:Cancel()
		end)
	end
	local D, r, n, u, W =
		{ PlaybackState = Enum.PlaybackState.Playing, Speed = q, Target = F, TweenKey = c },
		false,
		false,
		false,
		J.CFrame
	local noclipConn
	local function F(q)
		if u then
			return
		end
		u = true
		if noclipConn then
			noclipConn:Disconnect()
			noclipConn = nil
		end
		D.PlaybackState = q
		P = math.max(P - 1, 0)
		if y[J] == D then
			y[J] = nil
		end
		if getgenv()[c] == D then
			getgenv()[c] = nil
		end
		if P == 0 and not (type(ToggleNoclip) == "function" and ToggleNoclip() == true) then
			l(false)
			getgenv().noclip = false
		end
	end
	D.Play = function(q)
		if u then
			return
		end
		n = false
		q.PlaybackState = Enum.PlaybackState.Playing
	end
	D.Pause = function(q)
		if u then
			return
		end
		n = true
		q.PlaybackState = Enum.PlaybackState.Paused
	end
	D.Cancel = function(q)
		if u then
			return
		end
		r = true
		F(Enum.PlaybackState.Cancelled)
	end
	D.Destroy = function(q)
		q:Cancel()
	end
	y[J] = D
	getgenv()[c] = D
	P = P + (1)
	l(true)
	getgenv().noclip = true
	-- NOCLIP THUYỀN: set CanCollide=false mỗi frame (Stepped, trước bước physics) cho cả thuyền và nhân vật.
	-- Trước đây chỉ set 1 lần nên game/Humanoid bật lại collision -> thuyền va model đảo, bị đẩy lùi và tween bị giật ngược.
	do
		local nc_parts, nc_next = {}, 0
		noclipConn = x.Stepped:Connect(function()
			if u or not J.Parent then
				return
			end
			if tick() >= nc_next then
				nc_next = tick() + 0.5
				nc_parts = {}
				-- model thuyền = model nằm ngay dưới workspace.Boats
				local boat = J.Parent
				while boat and boat.Parent and boat.Parent.Name ~= "Boats" and boat.Parent ~= workspace do
					boat = boat.Parent
				end
				if boat then
					for _, d in ipairs(boat:GetDescendants()) do
						if d:IsA("BasePart") then
							nc_parts[#nc_parts + 1] = d
						end
					end
				end
				local ch = t and t.Character
				if ch then
					for _, d in ipairs(ch:GetDescendants()) do
						if d:IsA("BasePart") then
							nc_parts[#nc_parts + 1] = d
						end
					end
				end
			end
			for i = 1, #nc_parts do
				local part = nc_parts[i]
				if part.CanCollide then
					part.CanCollide = false
				end
			end
		end)
	end
	task.spawn(function()
		while not r and not u and J.Parent do
			local l = x.Heartbeat:Wait()
			if not n then
				local y = t.Character and (t.Character:FindFirstChildOfClass("Humanoid"))
				if not y or y.SeatPart ~= J then
					WarnOnce(
						"BoatNotSeated",
						"Chua ngoi tren ghe thuyen nen server khong nhan vi tri tween. Da dung tween."
					)
					F(Enum.PlaybackState.Cancelled)
					break
				end
				local y, P = math.min(D.Speed, Y.cap), D.Target
				local q, c = (P.Position - W.Position).Magnitude, y * l
				if (J.Position - W.Position).Magnitude > math.max(20, c * 3) then
					Y.ceiling = y * 0.9
					Y.cap = math.max(y * 0.7, 40)
					Y.nextRaise = tick() + math.max(C() * 4, 1)
					W = J.CFrame
					c, q = Y.cap * l, (P.Position - W.Position).Magnitude
				elseif q > c and Y.cap <= D.Speed and Y.cap < Y.ceiling and tick() >= Y.nextRaise then
					Y.cap = math.min(Y.cap * 1.08, Y.ceiling)
					Y.nextRaise = tick() + math.max(C() * 4, 1)
				end
				if q <= c or q <= H then
					W = P
					J.CFrame = P
					J.AssemblyLinearVelocity = Vector3.new(0.0, 0.0, 0.0)
					J.AssemblyAngularVelocity = Vector3.new(0.0, 0.0, 0.0)
					F(Enum.PlaybackState.Completed)
					break
				end
				W = W:Lerp(P, c / q)
				J.CFrame = W
				J.AssemblyLinearVelocity = Vector3.new(0.0, 0.0, 0.0)
				J.AssemblyAngularVelocity = Vector3.new(0.0, 0.0, 0.0)
			end
		end
		if not u then
			F(Enum.PlaybackState.Cancelled)
		end
	end)
	return D
end
local function l(y, P, Y)
	if not (y and (y:FindFirstChild("VehicleSeat"))) then
		return
	end
	return manageTween(y.VehicleSeat, P, Y or 350, "TweenBoat")
end
local function y()
	local P = getgenv().TweenBoat
	if P then
		pcall(function()
			P:Cancel()
		end)
	end
	getgenv().TweenBoat = nil
end
NumberSpinBoat = NumberSpinBoat or 1
if not CFrameSpinBoat then
	-- PLACEHOLDER: ban goc bi mat, dung 6 goc xoay 60 do quanh truc Y
	CFrameSpinBoat = {}
	for i = 0, 5 do
		CFrameSpinBoat[i + 1] = CFrame.Angles(0, math.rad(60 * i), 0)
	end
end
function SpinBoat()
	local P = checkboat()
	if
		getgenv().PathSpinBoat
		and P
		and not Settings["Auto Sea Event With Friend"]
		and game.PlaceId == getgenv().CheckPlaceId
		and not t.Character.Humanoid.Sit
	then
		RoughSeaSpin = Settings["Teleport Boat Other CFrame if Rough Sea"] and V or 0
		local Y, H =
			SelectedZoneCFrame() * CFrame.new(0, P.WorldPivot.Y, 0 + RoughSeaSpin) * CFrameSpinBoat[NumberSpinBoat],
			tick()
		local C = l(P, Y, 300)
		repeat
			task.wait()
		until tick() - H >= 3
			or not getgenv().PathSpinBoat
			or not Settings["Auto Sea Event"]
			or not C
			or C.PlaybackState == Enum.PlaybackState.Completed
		if NumberSpinBoat >= 6 then
			NumberSpinBoat = 1
		else
			NumberSpinBoat = NumberSpinBoat + (1)
		end
	end
end
function NoclipBoat(P)
	for Y, Y in ipairs(P:GetDescendants()) do
		if (Y:IsA("BasePart") or (Y:IsA("Part")) or (Y:IsA("MeshPart"))) and Y.CanCollide then
			Y.CanCollide = false
		end
	end
end
function TurnOffNoclipBoat(P)
	for Y, Y in ipairs(P:GetDescendants()) do
		if (Y:IsA("BasePart") or (Y:IsA("Part")) or (Y:IsA("MeshPart"))) and not Y.CanCollide then
			Y.CanCollide = true
		end
	end
end
function BuyBoatAndTeleBoat(P)
	local Y = checkboat()
	if Settings["Auto Sea Event With Friend"] and Settings["Auto Sea Event"] then
		toTarget(game:GetService("Players")[Settings["Select Friend"]].Character.HumanoidRootPart.CFrame)
		return
	end
	if not Settings["Auto Sea Event"] and not P then
		return
	end
	if not Y or Y and t:DistanceFromCharacter(Y.VehicleSeat.Position) >= 4000 then
		local H = CFrame.new(-13.488054275512695, 10.311711311340332, 2927.692)
		H = (function() if game.PlaceId == getgenv().CheckPlaceId then return (CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)) else return H end end)()
		if (H.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
			if
				(H.Position - t.Character.HumanoidRootPart.Position).Magnitude > 1000
				and game.PlaceId == getgenv().CheckPlaceId
			then
				if Settings["Reset Character Buy Boat"] then
					if not t:GetAttribute("CurrentLocation") or t:GetAttribute("CurrentLocation") ~= "Tiki Outpost" then
						if
							game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki"
							or game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki2"
						then
							t.Character.Humanoid.Health = 0
							return
						end
					end
				end
			end
			toTarget(H)
		else
			local H = Settings["Select Boat"]
			if not H then
				WarnOnce("SelectBoat", "Chon thuyen o Sea Event > Select Boat truoc da.")
				return
			end
			local C = H == "Brigade"
			game:GetService("ReplicatedStorage").Remotes.CommF_
				:InvokeServer("BuyBoat", (function() if C or H == "GrandBrigade" then return "Pirate" .. H else return H end end)())
			task.wait(3)
		end
	else
		task.spawn(function()
			NoclipBoat(Y)
		end)
		if Settings["Tween Until Have Sea Event"] then
			local H = CFrame.new(-118834.515625, Y.WorldPivot.Y, 999920.0494155884)
			if not t.Character.Humanoid.Sit then
				toTarget(Y.VehicleSeat.CFrame)
			else
				l(Y, H, 350)
			end
		else
			local H, C = CFrame.new(654.3875732421875, Y.WorldPivot.Y, 6321.95947265625), DecectPartRoughSea()
			if C then
				task.wait(1)
				V = ((V == 0) and 7000 or 0)
				Instance.new("IntValue", C).Name = "Ignored"
				task.wait(0.5)
			end
			getgenv().RoughSea = Settings["Teleport Boat Other CFrame if Rough Sea"] and V or 0
			H = (function() if game.PlaceId == getgenv().CheckPlaceId then return SelectedZoneCFrame() * CFrame.new(0, Y.WorldPivot.Y, 0 + RoughSea) else return H end end)()
			if (Y.VehicleSeat.Position - H.Position).Magnitude > 200 then
				C = CFrame.new(H.Position.X, Y.WorldPivot.Y, H.Position.Z)
				if not t.Character.Humanoid.Sit then
					toTarget(Y.VehicleSeat.CFrame)
				else
					l(Y, C, 350)
				end
			else
				if Settings["Auto Repair Ur Ship"] then
					if t.PlayerGui.Main.BottomHUDList.ShipHealthBar.Visible then
						local C = string.gsub(
							game:GetService("Players").LocalPlayer.PlayerGui.Main.BottomHUDList.ShipHealthBar.TextLabel.Text,
							"Ship ",
							""
						)
						C = string.split(C, "/")
						if tonumber(C[1]) < tonumber(C[2]) then
							if t:DistanceFromCharacter(Y.PrimaryPart.Position) < 20 then
								if not t.Character.Humanoid.Sit then
									if t.Character:FindFirstChild("_RepairHammer") then
										if t.Character._RepairHammer:FindFirstChild("M1UP") then
											t.Character._RepairHammer.M1UP:Destroy()
										elseif not t.Character._RepairHammer:GetAttribute("Repairing") then
											t.Character._RepairHammer.M1Down:FireServer("Default")
											task.wait(0.5)
										end
									else
										game:GetService("ReplicatedStorage").Remotes.SubclassNetwork.UseSubclass
											:InvokeServer(unpack({ [1] = { Action = "RequestHammer" } }))
										task.wait(3)
									end
								else
									toTarget(Y.PrimaryPart.CFrame * CFrame.new(0, 15, 0))
								end
							else
								toTarget(Y.PrimaryPart.CFrame * CFrame.new(0, 15, 0))
							end
							return
						end
					end
				end
				if not P then
					if not t.Character.Humanoid.Sit then
						toTarget(Y.VehicleSeat.CFrame)
					end
					local P = CFrame.new(H.Position.X, Y.WorldPivot.Y, H.Position.Z)
					if DetectSeaEvents(true) then
						local H = tick()
						repeat
							task.wait()
							toTarget(P * CFrame.new(0, 2500, 0))
						until tick() - H >= 12
					elseif t.Character.Humanoid.Sit then
						l(Y, P, 350)
					end
				end
			end
		end
	end
end
function SafeMultiSelect(l)
	local P = Settings[l]
	if type(P) ~= "table" then
		P = {}
		Settings[l] = P
	end
	return P
end
function SelectedZoneCFrame()
	local l = Settings["Select Zone"]
	return l and b[l] or b["Zone 1"]
end
function WarnOnce(b, l)
	getgenv().__BFWarned = getgenv().__BFWarned or {}
	local P = getgenv().__BFWarned[b]
	if P and tick() - P < 15 then
		return
	end
	getgenv().__BFWarned[b] = tick()
	pcall(function()
		A.CreateNoti({ Title = "Noijo Hub", Desc = l, ShowTime = 5 })
	end)
end
function DetectSeaEvents(b)
	local l = SafeMultiSelect("Select Sea Events")
	if b or l.SeaBeast then
		local P, Y, H = next, game:GetService("Workspace").SeaBeasts:GetChildren()
		for C, C in P, Y, H do
			if C.Name == "SeaBeast1" and (C:FindFirstChild("HumanoidRootPart")) and (C:FindFirstChild("HealthBBG")) then
				local P, Y = C.HealthBBG.Frame.TextLabel.Text:gsub("/%d+,%d+", ""), C.HealthBBG.Frame.TextLabel.Text
				if
					tonumber(
							(
								((function() if string.find(P, ",") then return (Y:gsub("%d+,%d+/", "")) else return (Y:gsub("%d+/", "")) end end)()):gsub(
									",",
									""
								)
							)
						)
						>= 90000
					and t:DistanceFromCharacter(C.HumanoidRootPart.Position) < 2000
				then
					return C
				end
			end
		end
	end
	if b or l.Terrorshark then
		local P = CheckNameBoss("Terrorshark")
		if P and t:DistanceFromCharacter(P.HumanoidRootPart.Position) < 2000 then
			return P
		end
	end
	if b or l.Ship then
		local P, Y, H = next, game:GetService("Workspace").Enemies:GetChildren()
		for C, C in P, Y, H do
			if
				C:FindFirstChild("Engine")
				and (C:FindFirstChild("Health"))
				and C.Health.Value > 0
				and t:DistanceFromCharacter(C.Engine.Position) < 2000
			then
				if l["Only Farm Ship Brigade"] then
					if table.find(X, C.Name) then
						return C
					end
				else
					return C
				end
			end
		end
	end
	if b or l.Shark then
		local X = DetectMob(_)
		if X and t:DistanceFromCharacter(X.HumanoidRootPart.Position) < 2000 then
			return X
		end
	end
	if b or l.Piranha then
		local b = DetectMob("Piranha")
		if b and t:DistanceFromCharacter(b.HumanoidRootPart.Position) < 2000 then
			return b
		end
	end
	return false
end
function UseSkillGun()
	local b = NameWeapon("Gun", true) or false
	if b and not game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills:FindFirstChild(b.Name) then
		equiptool(b.Name)
		return
	end
	local X = (function() if b and (CheckCDSkillTransformation(b, Settings["Select Skills " .. b.ToolTip])) then return (CheckCDSkillTransformation(b, Settings["Select Skills " .. b.ToolTip])) else return nil end end)()
	if X then
		b = X.Parent.Name
		equiptool(b)
		if t.Character:FindFirstChild(b) then
			task.wait(0.2)
			game:GetService("VirtualInputManager"):SendKeyEvent(true, X.Name, false, game)
			if Settings["Use skill fast dont hold"] then
				task.wait(0.05)
			else
				task.wait(HoldDelay(X.Name, b))
			end
			game:GetService("VirtualInputManager"):SendKeyEvent(false, X.Name, false, game)
		end
	end
end
function AutoUseSkillSeabeast(b)
	b = SafeMultiSelect("Select Weapons Use Skill")
	local X, l, _, P, Y =
		b.Melee and (NameWeapon("Melee", true)) or false,
		b.Sword and (NameWeapon("Sword", true)) or false,
		b["Blox Fruit"] and (NameWeapon("Blox Fruit", true)) or false,
		b.Gun and (NameWeapon("Gun", true)) or false,
		game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills
	if X and not Y:FindFirstChild(X.Name) then
		equiptool(X.Name)
		return
	end
	if l and not Y:FindFirstChild(l.Name) then
		equiptool(l.Name)
		return
	end
	if _ and not Y:FindFirstChild(_.Name) then
		equiptool(_.Name)
		return
	end
	if P and not Y:FindFirstChild(P.Name) then
		equiptool(P.Name)
		return
	end
	Y = (function() if X and (CheckCDSkillTransformation(X, Settings["Select Skills " .. X.ToolTip])) then return (CheckCDSkillTransformation(X, Settings["Select Skills " .. X.ToolTip])) else return (function() if l and (CheckCDSkillTransformation(l, Settings["Select Skills " .. l.ToolTip])) then return (CheckCDSkillTransformation(l, Settings["Select Skills " .. l.ToolTip])) else return (function() if P and (CheckCDSkillTransformation(P, Settings["Select Skills " .. P.ToolTip])) then return (CheckCDSkillTransformation(P, Settings["Select Skills " .. P.ToolTip])) else return (function() if _ and (CheckCDSkillTransformation(_, Settings["Select Skills " .. _.ToolTip])) then return (CheckCDSkillTransformation(_, Settings["Select Skills " .. _.ToolTip])) else return nil end end)() end end)() end end)() end end)()
	if Y then
		X = Y.Parent.Name
		equiptool(X)
		if t.Character:FindFirstChild(X) then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, Y.Name, false, game)
			if Settings["Use skill fast dont hold"] then
				task.wait(0.05)
			else
				task.wait(HoldDelay(Y.Name, X))
			end
			game:GetService("VirtualInputManager"):SendKeyEvent(false, Y.Name, false, game)
		end
	end
end
function UseSkillonlyFruit()
	local b = NameWeapon("Blox Fruit", true)
	if b and not game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills:FindFirstChild(b.Name) then
		equiptool(b.Name)
		return
	end
	local X = (function() if b and (CheckCDSkillTransformation(b, Settings["Select Skills " .. b.ToolTip])) then return (CheckCDSkillTransformation(b, Settings["Select Skills " .. b.ToolTip])) else return nil end end)()
	if X then
		b = X.Parent.Name
		equiptool(b)
		if t.Character:FindFirstChild(b) then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, X.Name, false, game)
			if Settings["Use skill fast dont hold"] then
				task.wait(0.05)
			else
				task.wait(HoldDelay(X.Name, b))
			end
			game:GetService("VirtualInputManager"):SendKeyEvent(false, X.Name, false, game)
		end
	end
end
function AutoSeabeast()
	if not StackFarmOther then
		return
	end
	local b = false
	for X, l in next, SafeMultiSelect("Select Sea Events"), nil do
		if l and X ~= "Only Farm Ship Brigade" then
			b = true
			break
		end
	end
	if not b then
		WarnOnce("NoSeaEvent", "Chua chon su kien nao o Sea Event > Select Sea Events.")
		return
	end
	b = DetectSeaEvents()
	if not b then
		getgenv().PathSeaBeast = false
		getgenv().PathTerrorshark = false
		getgenv().PathSpinBoat = false
		BuyBoatAndTeleBoat()
	else
		y()
		if b.Name == "Terrorshark" then
			getgenv().PathTerrorshark = b
		end
		getgenv().PathSpinBoat = b
		repeat
			task.wait()
			TeleportSeaEvents(b)
			if b:FindFirstChildWhichIsA("Humanoid") then
				if Settings["Use Dragonstorm For Sea Event"] then
					if Settings["Auto Change Dragonstorm With Skull Guitar"] then
						if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
							game:GetService("ReplicatedStorage").Remotes.CommF_
								:InvokeServer(unpack({ [1] = "LoadItem", [2] = "Dragonstorm" }))
						end
					end
					equiptool(NameWeapon("Gun"))
					SpamGunDragonStorm(b.HumanoidRootPart)
					if t:DistanceFromCharacter(b.HumanoidRootPart.Position) < 400 then
						UseSkillGun()
					end
				elseif Settings["Use Click M1 Fruit For Sea Event"] then
					equiptool(NameWeapon("Blox Fruit"))
					local X = NameWeapon("Blox Fruit")
					if t.Character:FindFirstChild(X) and (t.Character[X]:FindFirstChild("LeftClickRemote")) then
						getgenv().UseFruitM1(b)
					end
				else
					UsedualFlock()
					ClickM1(b, true)
				end
			else
				local X = b:FindFirstChild("HumanoidRootPart") or (b:FindFirstChild("Engine"))
				if X then
					if b.Name == "SeaBeast1" then
						getgenv().PathSeaBeast = b
						getgenv().AimPos = CFrame.new(X.Position.X, 40, X.Position.Z)
					else
						getgenv().AimPos = CFrame.new(
							t.Character.HumanoidRootPart.Position.X,
							-58,
							t.Character.HumanoidRootPart.Position.Z
						)
					end
					if Settings["Use Dragonstorm For Sea Event"] and b.Name ~= "SeaBeast1" then
						if Settings["Auto Change Dragonstorm With Skull Guitar"] then
							if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
								game:GetService("ReplicatedStorage").Remotes.CommF_
									:InvokeServer(unpack({ [1] = "LoadItem", [2] = "Dragonstorm" }))
							end
						end
						equiptool(NameWeapon("Gun"))
						SpamGunDragonStorm(X)
						if t:DistanceFromCharacter(X.Position) < 400 then
							UseSkillGun()
						end
					elseif Settings["Use Click M1 Skull Guitar For Sea Event"] then
						if Settings["Auto Change Dragonstorm With Skull Guitar"] then
							if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Skull Guitar" then
								game:GetService("ReplicatedStorage").Remotes.CommF_
									:InvokeServer(unpack({ [1] = "LoadItem", [2] = "Skull Guitar" }))
							end
						end
						equiptool(NameWeapon("Gun"))
						SpamGunSkullGuitar(X)
						if t:DistanceFromCharacter(X.Position) < 400 then
							UseSkillGun()
						end
					elseif
						Settings["Auto Change Dragonstorm When Kill Boat"]
						and (b:FindFirstChild("Health"))
						and b.Health.Value > 0
						and (b:FindFirstChild("Engine"))
					then
						if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
							game:GetService("ReplicatedStorage").Remotes.CommF_
								:InvokeServer(unpack({ [1] = "LoadItem", [2] = "Dragonstorm" }))
						end
						equiptool(NameWeapon("Gun"))
						SpamGunDragonStorm(X)
						if t:DistanceFromCharacter(X.Position) < 400 then
							UseSkillGun()
						end
					elseif Settings["Use Click M1 Fruit For Sea Event"] then
						equiptool(NameWeapon("Blox Fruit"))
						local l = NameWeapon("Blox Fruit")
						if t.Character:FindFirstChild(l) and (t.Character[l]:FindFirstChild("LeftClickRemote")) then
							if b.Name == "SeaBeast1" then
								getgenv().UseFruitM1(b)
							else
								getgenv().UseFruitM1Boat(X.CFrame * CFrame.new(0, -35, 0))
							end
						end
					elseif t:DistanceFromCharacter(X.Position) < 400 then
						AutoUseSkillSeabeast()
					end
				end
			end
		until not b
			or not b.Parent
			or not Settings["Auto Sea Event"]
			or b:FindFirstChild("Health") and b.Health.Value == 0
			or b:FindFirstChildWhichIsA("Humanoid") and b.Humanoid.Health == 0
			or not StackFarmOther
	end
end
FarmingSeaEventSection = SeaEventTab.CreateSection("Farming")
local b = FarmingSeaEventSection.CreateDropdown(
	{
		Title = "Select Friend",
		List = DetectNamePlayer(),
		Search = true,
		Selected = false,
		Default = Settings["Select Friend"] or nil,
	},
	function(X)
		SaveSettings("Select Friend", X)
	end
)
FarmingSeaEventSection.CreateButton({ Title = "Refresh Player" }, function()
	b:GetNewList(DetectNamePlayer())
end)
FarmingSeaEventSection.CreateToggle(
	{ Title = "Auto Sea Event With Friend", Desc = nil, Default = Settings["Auto Sea Event With Friend"] or false },
	function(b)
		SaveSettings("Auto Sea Event With Friend", b)
	end
)
local b, X, l = 0, 0, false
spawn(function()
	repeat
		wait()
	until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main")
		and (game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main"):FindFirstChild("DmgCounter"))
	game:GetService("Players").LocalPlayer.PlayerGui.Main.DmgCounter.Text
		:GetPropertyChangedSignal("Text")
		:Connect(function()
			if tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.DmgCounter.Text.Text) == 0 then
				b, X, l = 0, 0, false
			else
				l = true
				b = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.DmgCounter.Text.Text) - X
			end
		end)
end)
FarmingSeaEventSection.CreateToggle(
	{ Title = "Auto Repair Ur Ship", Desc = nil, Default = Settings["Auto Repair Ur Ship"] or false },
	function(_)
		SaveSettings("Auto Repair Ur Ship", _)
	end
)
FarmingSeaEventSection.CreateToggle(
	{ Title = "Auto Sea Event", Desc = nil, Default = Settings["Auto Sea Event"] or false },
	function(_)
		if _ then
			getgenv().StopBoatSeaEvent = true
			spawn(function()
				while Settings["Auto Sea Event"] and (task.wait()) do
					local P, Y = pcall(function()
						AutoSeabeast()
					end)
					if not P and Y then
						print(Y)
					end
				end
			end)
		elseif getgenv().StopBoatSeaEvent then
			y()
			getgenv().StopBoatSeaEvent = false
		end
		SaveSettings("Auto Sea Event", _)
	end
)
local _
if game.PlaceId == getgenv().CheckPlaceId then
	_ = require(game:GetService("ReplicatedStorage").DangerDistance)
end
function DistanceFindLeviathan()
	local y = Z:GetNearestNPC(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, 2600)[1]
	return (
		math.floor((Z:GetDistance(y) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude / 10)
	)
end
ToggleFindMirage = FarmingSeaEventSection.CreateToggle(
	{ Title = "Auto Find Mirage", Desc = nil, Default = Settings["Auto Find Mirage"] or false },
	function(y)
		spawn(function()
			while Settings["Auto Find Mirage"] and (wait(0.1)) do
				pcall(function()
					if not game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
						getgenv().RespawnMirage = true
						local P = checkboat()
						if not P or P and t:DistanceFromCharacter(P.VehicleSeat.Position) >= 4000 then
							local Y = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
							if (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
								if (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude > 1000 then
									if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki" then
										t.Character.Humanoid.Health = 0
										return
									end
								end
								toTarget(Y)
							else
								game:GetService("ReplicatedStorage").Remotes.CommF_
									:InvokeServer("BuyBoat", "PirateBrigade")
								wait(3)
							end
						elseif t.Character.Humanoid.Sit then
							local Y, H, Z =
								CFrame.new(-118834.515625, 160, -78.9505844116211) * CFrame.new(0, 0, 99999999),
								CFrame.new(-32975.9921875, 160, 25963.7109375),
								(function() if Settings["Will Back When over 10km"] then return (function() if DistanceFindLeviathan() >= 12000 then return true else return (function() if DistanceFindLeviathan() <= 4800 then return false else return false end end)() end end)() else return false end end)()
							repeat
								task.wait(0.5)
								NoclipBoat(P)
								if Settings["Will Back When over 10km"] then
									Z = (function() if DistanceFindLeviathan() >= 10000 then return true else return (function() if DistanceFindLeviathan() <= 4800 then return false else return Z end end)() end end)()
									if Z then
										manageTween(P.VehicleSeat, H, 350, "TweenBoatBack")
									end
								end
								if not Z or not Settings["Will Back When over 10km"] then
									manageTween(P.VehicleSeat, Y, 350, "TweenBoat")
								end
							until not Settings["Auto Find Mirage"]
								or not t.Character.Humanoid.Sit
								or (game:GetService("Workspace").Map:FindFirstChild("MysticIsland"))
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
							toTarget(P.VehicleSeat.CFrame)
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
						A.CreateNoti({ Title = "Noijo Hub", Desc = "Mirage Island Spawned", ShowTime = 5 })
						ToggleFindMirage:SetStage(false)
						wait(5)
					end
				end)
			end
		end)
		SaveSettings("Auto Find Mirage", y)
	end
)
KitsuneEventSection = SeaEventTab.CreateSection("Kitsune Event")
KitsuneEventSection.CreateToggle(
	{ Title = "Teleport To Kitsune Island", Desc = nil, Default = Settings["Teleport To Kitsune Island"] or false },
	function(y)
		SaveSettings("Teleport To Kitsune Island", y)
	end
)
KitsuneEventSection.CreateToggle(
	{
		Title = "Hop Server [ Next Night or Near Full Moon > 2m ]",
		Desc = nil,
		Default = Settings["Hop Server Kitsune Island"] or false,
	},
	function(y)
		SaveSettings("Hop Server Kitsune Island", y)
	end
)
KitsuneEventSection.CreateToggle(
	{ Title = "Auto Spawn Kitsune Island", Desc = nil, Default = Settings["Auto Spawn Kitsune Island"] or false },
	function(y)
		if y then
			A.CreateNoti({
				Title = "Noijo Hub",
				Desc = "Turn On after Status Full Moon|( Will Full Moon In >= 0 Minutes )",
				ShowTime = 5,
			})
		end
		SaveSettings("Auto Spawn Kitsune Island", y)
	end
)
KitsuneEventSection.CreateToggle(
	{ Title = "Auto Summon Soul Ember", Desc = nil, Default = Settings["Auto Summon Soul Ember"] or false },
	function(y)
		SaveSettings("Auto Summon Soul Ember", y)
	end
)
KitsuneEventSection.CreateToggle(
	{ Title = "Auto Collect Soul Ember", Desc = nil, Default = Settings["Auto Collect Soul Ember"] or false },
	function(y)
		SaveSettings("Auto Collect Soul Ember", y)
	end
)
KitsuneEventSection.CreateSlider(
	{ Title = "Values Azure Ember", Min = 0, Max = 25, Default = Settings["Values Azure Ember"] or 10, Precise = true },
	function(y)
		SaveSettings("Values Azure Ember", y)
	end
)
KitsuneEventSection.CreateToggle(
	{ Title = "Auto Trade Azure Ember", Desc = nil, Default = Settings["Auto Trade Azure Ember"] or false },
	function(y)
		SaveSettings("Auto Trade Azure Ember", y)
	end
)
function DetectIslandKitsune()
	if
		game.workspace.Map:FindFirstChild("KitsuneIsland")
		and workspace.Map.KitsuneIsland.ShrineDialogPart.ProximityPrompt.Enabled
	then
		return true
	end
end
function AutoSpawnKitsune()
	local y, P = game.Lighting.ClockTime, checkboat()
	if Settings["Hop Server Kitsune Island"] then
		local Y = CheckMoon()
		if
			not (
				Y == "Full Moon" and math.floor(18 - y) <= 5 and math.floor(18 - y) >= 0
				or Y == "Next Night"
				or Y == "Full Moon" and y <= 5 and math.floor(5 - y) >= 11
			)
		then
			HopServer()
			return
		end
	end
	if not P then
		local Y = CFrame.new(-13.488054275512695, 10.311711311340332, 2927.692)
		Y = (function() if game.PlaceId == getgenv().CheckPlaceId then return (CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)) else return Y end end)()
		if (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
			toTarget(Y)
		else
			local Y = Settings["Select Boat"]
			if not Y then
				WarnOnce("SelectBoat", "Chon thuyen o Sea Event > Select Boat truoc da.")
				return
			end
			local H = Y == "Brigade"
			game:GetService("ReplicatedStorage").Remotes.CommF_
				:InvokeServer("BuyBoat", (function() if H or Y == "GrandBrigade" then return "Pirate" .. Y else return Y end end)())
			task.wait(3)
		end
		return
	end
	NoclipBoat(P)
	local Y = P.WorldPivot.Y
	local H = CFrame.new(-32975.9921875, Y, 25963.7109375) * CFrame.new(0, 0, 1000)
	if CheckMoon() == "Full Moon" and math.floor(18 - y) <= 0 then
		if (P.VehicleSeat.Position - H.Position).Magnitude > 200 then
			if not t.Character.Humanoid.Sit then
				toTarget(P.VehicleSeat.CFrame)
			else
				manageTween(P.VehicleSeat, H, 350, "TweenBoat")
			end
		elseif not t.Character.Humanoid.Sit then
			toTarget(P.VehicleSeat.CFrame)
		end
	else
		if (P.VehicleSeat.Position - H.Position).Magnitude > 200 then
			manageTween(P.VehicleSeat, H, 350, "TweenBoat")
		end
		toTarget(H * CFrame.new(0, 2000, 0))
	end
end
function DetectSoulEmber()
	local y, P, Y = next, game.Workspace:GetChildren()
	for H, H in y, P, Y do
		if H.Name == "EmberTemplate" and (H:FindFirstChild("Part")) then
			return H
		end
	end
end
function CollectSoulEmber()
	local y = DetectSoulEmber()
	if y then
		if t:DistanceFromCharacter(y.Part.Position) > 100 then
			toTarget(y.Part.CFrame)
		else
			t.Character.HumanoidRootPart.CFrame = y.Part.CFrame
		end
	else
		toTarget(game.workspace._WorldOrigin.Locations["Kitsune Island"].CFrame)
	end
end
function AutoSummonAzureEmber()
	if
		not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
		and (DetectIslandKitsune())
	then
		if t:DistanceFromCharacter(game.Workspace.Map.KitsuneIsland.ShrineInactive.WorldPivot.Position) >= 10 then
			toTarget(game.Workspace.Map.KitsuneIsland.ShrineInactive.WorldPivot)
		else
			game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
			wait(5)
		end
	end
end
function TradeAzureEmber()
	if
		CheckCountItem("Azure Ember", tonumber(Settings["Values Azure Ember"]))
		and game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
	then
		game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
		wait(5)
	end
end
spawn(function()
	repeat
		wait(0.15)
	until Settings["Teleport To Kitsune Island"]
		or Settings["Auto Spawn Kitsune Island"]
		or Settings["Auto Collect Soul Ember"]
		or Settings["Auto Trade Azure Ember"]
	while task.wait(0.1) do
		pcall(function()
			if Settings["Teleport To Kitsune Island"] then
				if game.workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
					toTarget(game.workspace._WorldOrigin.Locations["Kitsune Island"].CFrame)
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
	local y = require(game.ReplicatedStorage.DialoguesList).Spy
	require(game.ReplicatedStorage.DialogueController):Start(y)
end)
LeviathanEventSection.CreateButton({ Title = "Teleport your boat to current Position" }, function()
	checkboat().VehicleSeat.CFrame = t.Character.HumanoidRootPart.CFrame
end)
LeviathanEventSection.CreateToggle(
	{ Title = "Auto Buy Spy", Desc = nil, Default = Settings["Auto Buy Spy"] or false },
	function(y)
		if y then
			spawn(function()
				while Settings["Auto Buy Spy"] and (task.wait(5)) do
					pcall(function()
						if StatusCheckLeviathan() == "Buy Find leviathan" then
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("InfoLeviathan", "1")
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Buy Spy", y)
	end
)
LeviathanEventSection.CreateToggle(
	{ Title = "Auto Buy Boat Beast Hunter", Desc = nil, Default = Settings["Auto Buy Boat Beast Hunter"] or false },
	function(y)
		SaveSettings("Auto Buy Boat Beast Hunter", y)
	end
)
function checkboatFind()
	local y, P, Y = next, game:GetService("Workspace").Boats:GetChildren()
	for H, H in y, P, Y do
		if H:IsA("Model") then
			if
				H:FindFirstChild("Owner")
				and t:DistanceFromCharacter(H.VehicleSeat.Position) < 10
				and t.Character.Humanoid.SeatPart
				and t.Character.Humanoid.SeatPart.Name == "VehicleSeat"
				and H.Humanoid.Value > 0
			then
				return H
			end
		end
	end
end
g, s, a, I = {}, next, game:GetService("ReplicatedStorage").RockGenerator.Rocks:GetChildren()
for y, y in s, a, I do
	table.insert(g, y.Name)
end
function DetectRockNear(s)
	local g, I = s.VehicleSeat.Position, s:GetAttribute("Size")
	s = workspace:FindPartsInRegion3(Region3.new(g - I / 2, g + I / 2), nil, 1 / 0)
	if #s > 0 then
		for g, g in pairs(s) do
			return true
		end
	end
end
local function s(g, I)
	return I - g
end
function DetectSeaEventDodge(g)
	if g then
		local I, y, P = next, game:GetService("Workspace").SeaBeasts:GetChildren()
		for Y, Y in I, y, P do
			if Y.Name == "SeaBeast1" and (Y:FindFirstChild("HumanoidRootPart")) and (Y:FindFirstChild("HealthBBG")) then
				local I, y = Y.HealthBBG.Frame.TextLabel.Text:gsub("/%d+,%d+", ""), Y.HealthBBG.Frame.TextLabel.Text
				if
					tonumber(
							(
								((function() if string.find(I, ",") then return (y:gsub("%d+,%d+/", "")) else return (y:gsub("%d+/", "")) end end)()):gsub(
									",",
									""
								)
							)
						)
						>= 90000
					and t:DistanceFromCharacter(Y.HumanoidRootPart.Position) < 2000
				then
					return Y
				end
			end
		end
	end
	if g then
		local I = CheckNameBoss("Terrorshark")
		if I and t:DistanceFromCharacter(I.HumanoidRootPart.Position) < 2000 then
			return I
		end
	end
	if g then
		local g, I, y = next, game:GetService("Workspace").Enemies:GetChildren()
		for P, P in g, I, y do
			if
				P:FindFirstChild("Engine")
				and (P:FindFirstChild("Health"))
				and P.Health.Value > 0
				and t:DistanceFromCharacter(P.Engine.Position) < 2000
			then
				return P
			end
		end
	end
	return false
end
function AutoFindLeviathan()
	if Settings["Auto Destroy IDK"] and getgenv().DesIdk then
		getgenv().DesIdk2 = true
		return
	end
	if Settings["Auto Destroy IDK"] and getgenv().DesIdk2 then
		toTarget(getgenv().OldBoat.VehicleSeat.CFrame)
		if t.Character.Humanoid.Sit then
			getgenv().DesIdk2 = false
		end
		return
	end
	local g = checkboatFind()
	if not game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
		getgenv().RespawnLeviathan = true
		local I = checkboat()
		if not I and Settings["Auto Buy Boat Beast Hunter"] then
			local y = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
			if (y.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
				if (y.Position - t.Character.HumanoidRootPart.Position).Magnitude > 1000 then
					if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki" then
						t.Character.Humanoid.Health = 0
						return
					end
				end
				toTarget(y)
			else
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "Beast Hunter")
				wait(3)
			end
		elseif g then
			getgenv().noclip = false
			local y, P, Y, H, Z =
				CFrame.new(-118834.515625, 160, -78.9505844116211) * CFrame.new(0, 0, 99999999),
				CFrame.new(-32975.9921875, 160, 25963.7109375),
				(function() if Settings["Will Back When over 10km"] then return (function() if DistanceFindLeviathan() >= 12000 then return true else return (function() if DistanceFindLeviathan() <= 4800 then return false else return false end end)() end end)() else return false end end)(),
				g.VehicleSeat.Position.Y,
				g.VehicleSeat.BodyVelocity.MaxForce
			wait(0.5)
			local C = false
			g.VehicleSeat.BodyVelocity.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
			local J = s(g.VehicleSeat.Position.Y, 1000)
			if not t.PlayerGui.Main.Compass.Frame.DangerLevel.Visible then
				wait(0.2)
				g.VehicleSeat.CFrame = g.VehicleSeat.CFrame * CFrame.new(0, J, 0)
				wait(1)
				C = true
			else
				wait(0.2)
				g.VehicleSeat.CFrame = g.VehicleSeat.CFrame * CFrame.new(0, s(g.VehicleSeat.Position.Y, 160), 0)
				wait(1)
			end
			J = false
			repeat
				task.wait(0.5)
				NoclipBoat(g)
				if t.Character:FindFirstChild("HumanoidRootPart") and (t.Character:FindFirstChild("Humanoid")) then
					local F, q, c = next, t.Character:GetDescendants()
					for D, D in F, q, c do
						if (D:IsA("MeshPart") or (D:IsA("Part"))) and D.CanCollide then
							D.CanCollide = false
						end
					end
				end
				if
					C
					and (
						t.PlayerGui.Main.Compass.Frame.DangerLevel.Visible
							and t.PlayerGui.Main.Compass.Frame.DangerText.Visible
							and tonumber(
								game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.TextLabel.Text
							) >= 1
						or _(t.Character.HumanoidRootPart.CFrame) >= 4000
					)
				then
					getgenv().TweenBoat:Pause()
					getgenv().TweenBoat:Cancel()
					wait(0.5)
					g.VehicleSeat.CFrame = g.VehicleSeat.CFrame * CFrame.new(0, s(g.VehicleSeat.Position.Y, 160), 0)
					wait(0.5)
					C = false
				end
				if not C and g.VehicleSeat.Position.Y < 150 then
					if getgenv().TweenBoat then
						getgenv().TweenBoat:Pause()
						getgenv().TweenBoat:Cancel()
					end
					if getgenv().TweenBoatBack then
						getgenv().TweenBoatBack:Pause()
						getgenv().TweenBoatBack:Cancel()
					end
					wait(0.5)
					g.VehicleSeat.CFrame = g.VehicleSeat.CFrame * CFrame.new(0, s(g.VehicleSeat.Position.Y, 160), 0)
				end
				if not J and (DetectSeaEventDodge(true)) and g.VehicleSeat.Position.Y < 500 then
					y, P =
						CFrame.new(-118834.515625, 500, -78.9505844116211) * CFrame.new(0, 0, 99999999),
						CFrame.new(-32975.9921875, 500, 25963.7109375)
					if getgenv().TweenBoat then
						getgenv().TweenBoat:Pause()
						getgenv().TweenBoat:Cancel()
					end
					if getgenv().TweenBoatBack then
						getgenv().TweenBoatBack:Pause()
						getgenv().TweenBoatBack:Cancel()
					end
					wait(0.5)
					g.VehicleSeat.CFrame = g.VehicleSeat.CFrame * CFrame.new(0, s(g.VehicleSeat.Position.Y, 500), 0)
					wait(0.5)
					J = true
				elseif J and not DetectSeaEventDodge(true) then
					y, P =
						CFrame.new(-118834.515625, 160, -78.9505844116211) * CFrame.new(0, 0, 99999999),
						CFrame.new(-32975.9921875, 160, 25963.7109375)
					if getgenv().TweenBoat then
						getgenv().TweenBoat:Pause()
						getgenv().TweenBoat:Cancel()
					end
					if getgenv().TweenBoatBack then
						getgenv().TweenBoatBack:Pause()
						getgenv().TweenBoatBack:Cancel()
					end
					wait(0.5)
					g.VehicleSeat.CFrame = g.VehicleSeat.CFrame * CFrame.new(0, s(g.VehicleSeat.Position.Y, 160), 0)
					wait(0.5)
					J = false
				end
				if Settings["Will Back When over 10km"] then
					Y = (function() if DistanceFindLeviathan() >= 10000 then return true else return (function() if DistanceFindLeviathan() <= 4800 then return false else return Y end end)() end end)()
					if Y then
						manageTween(g.VehicleSeat, P, 350, "TweenBoatBack")
					end
				end
				if not Y or not Settings["Will Back When over 10km"] then
					manageTween(g.VehicleSeat, y, 350, "TweenBoat")
				end
			until not Settings["Auto Find Leviathan"]
				or not t.Character.Humanoid.Sit
				or (game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension"))
				or Settings["Auto Destroy IDK"] and getgenv().DesIdk
			g.VehicleSeat.BodyVelocity.MaxForce = Z
			getgenv().OldBoat = g
			if getgenv().TweenBoat then
				getgenv().TweenBoat:Pause()
				getgenv().TweenBoat:Cancel()
			end
			if getgenv().TweenBoatBack then
				getgenv().TweenBoatBack:Pause()
				getgenv().TweenBoatBack:Cancel()
			end
			g.VehicleSeat.CFrame = CFrame.new(g.VehicleSeat.Position.X, H, g.VehicleSeat.Position.Z)
		elseif I and Settings["Auto Buy Boat Beast Hunter"] then
			if not t.Character.Humanoid.Sit then
				toTarget(I.VehicleSeat.CFrame)
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
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Frozen Dimension Spawned", ShowTime = 5 })
		if getgenv().RespawnLeviathan and Settings["Webhook Find Leviathan"] then
			getgenv().RespawnLeviathan = false
			WebhookFindLeviathan()
		end
		wait(5)
	end
end
function DestroyIDK()
	if StatusCheckLeviathan() == "I DONT KNOW" then
		getgenv().WebhookIDK = true
		local s = DetectSeaEvents(true)
		if not s then
			getgenv().PathSeaBeast = false
			getgenv().PathTerrorshark = false
			getgenv().PathSpinBoat = false
		else
			getgenv().DesIdk = true
			if getgenv().TweenBoat then
				getgenv().TweenBoat:Pause()
				getgenv().TweenBoat:Cancel()
			end
			if s.Name == "Terrorshark" then
				getgenv().PathTerrorshark = s
			end
			getgenv().PathSpinBoat = s
			repeat
				task.wait()
				spawn(function()
					TeleportSeaEvents(s)
				end)
				if s:FindFirstChildWhichIsA("Humanoid") then
					if Settings["Use Dragonstorm For Sea Event"] then
						if Settings["Auto Change Dragonstorm With Skull Guitar"] then
							if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
								game:GetService("ReplicatedStorage").Remotes.CommF_
									:InvokeServer(unpack({ [1] = "LoadItem", [2] = "Dragonstorm" }))
							end
						end
						equiptool(NameWeapon("Gun"))
						SpamGunDragonStorm(s.HumanoidRootPart)
						if t:DistanceFromCharacter(s.HumanoidRootPart.Position) < 400 then
							UseSkillGun()
						end
					elseif Settings["Use Click M1 Fruit For Sea Event"] then
						equiptool(NameWeapon("Blox Fruit"))
						local g = NameWeapon("Blox Fruit")
						if t.Character:FindFirstChild(g) and (t.Character[g]:FindFirstChild("LeftClickRemote")) then
							getgenv().UseFruitM1(s)
						end
					else
						UsedualFlock()
						ClickM1(s, true)
					end
				else
					local g = s:FindFirstChild("HumanoidRootPart") or (s:FindFirstChild("Engine"))
					if s.Name == "SeaBeast1" then
						getgenv().PathSeaBeast = s
						getgenv().AimPos = CFrame.new(g.Position.X, 40, g.Position.Z)
					else
						getgenv().AimPos = CFrame.new(
							t.Character.HumanoidRootPart.Position.X,
							-58,
							t.Character.HumanoidRootPart.Position.Z
						)
					end
					if Settings["Use Dragonstorm For Sea Event"] and s.Name ~= "SeaBeast1" then
						if Settings["Auto Change Dragonstorm With Skull Guitar"] then
							if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Dragonstorm" then
								game:GetService("ReplicatedStorage").Remotes.CommF_
									:InvokeServer(unpack({ [1] = "LoadItem", [2] = "Dragonstorm" }))
							end
						end
						equiptool(NameWeapon("Gun"))
						SpamGunDragonStorm(g)
						if t:DistanceFromCharacter(g.Position) < 400 then
							UseSkillGun()
						end
					elseif Settings["Use Click M1 Skull Guitar For Sea Event"] then
						if Settings["Auto Change Dragonstorm With Skull Guitar"] then
							if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Skull Guitar" then
								game:GetService("ReplicatedStorage").Remotes.CommF_
									:InvokeServer(unpack({ [1] = "LoadItem", [2] = "Skull Guitar" }))
							end
						end
						equiptool(NameWeapon("Gun"))
						SpamGunSkullGuitar(g)
						if t:DistanceFromCharacter(g.Position) < 400 then
							UseSkillGun()
						end
					elseif Settings["Use Click M1 Fruit For Sea Event"] then
						equiptool(NameWeapon("Blox Fruit"))
						local I = NameWeapon("Blox Fruit")
						if t.Character:FindFirstChild(I) and (t.Character[I]:FindFirstChild("LeftClickRemote")) then
							if s.Name == "SeaBeast1" then
								getgenv().UseFruitM1(s)
							else
								getgenv().UseFruitM1Boat(g.CFrame * CFrame.new(0, -35, 0))
							end
						end
					elseif t:DistanceFromCharacter(g.Position) < 400 then
						AutoUseSkillSeabeast()
					end
				end
			until not s
				or not s.Parent
				or not Settings["Auto Destroy IDK"]
				or s:FindFirstChild("Health") and s.Health.Value == 0
				or s:FindFirstChildWhichIsA("Humanoid") and s.Humanoid.Health == 0
			getgenv().DesIdk = false
		end
	elseif getgenv().WebhookIDK and Settings["Webhook Destroy IDK"] then
		getgenv().WebhookDestroyIdk()
		getgenv().WebhookIDK = false
	end
	getgenv().DesIdk = false
end
getgenv().SpeedTeleportTiki = 70
local s = LeviathanEventSection.CreateDropdown(
	{
		Title = "Select Owner Boat Find Leviathan",
		List = DetectNamePlayer(),
		Search = true,
		Selected = false,
		Default = Settings["Select Owner Boat Find Leviathan"] or nil,
	},
	function(g)
		SaveSettings("Select Owner Boat Find Leviathan", g)
	end
)
LeviathanEventSection.CreateButton({ Title = "Refresh Player" }, function()
	s:GetNewList(DetectNamePlayer())
end)
function checkboatMulti()
	local s, g, I, _ =
		Settings["Select Owner Boat Find Leviathan"], next, game:GetService("Workspace").Boats:GetChildren()
	local y
	for P, P in g, I, _ do
		y = (function() if P:IsA("Model") then return (function() if P:FindFirstChild("Owner") and tostring(P.Owner.Value) == s and P.Humanoid.Value > 0 then return P else return y end end)() else return y end end)()
	end
	if y then
		I, g, s = next, y:GetChildren()
		for _, _ in I, g, s do
			if _.Name == "Cannon" and not _.Seat:FindFirstChild("SeatWeld") then
				return _
			end
		end
	end
	return false
end
LeviathanEventSection.CreateToggle(
	{ Title = "Multi Find Leviathan", Desc = nil, Default = Settings["Multi Find Leviathan"] or false },
	function(s)
		if s then
			spawn(function()
				while Settings["Multi Find Leviathan"] and (task.wait(0.1)) do
					pcall(function()
						if Settings["Auto Destroy IDK"] and getgenv().DesIdk then
							return
						end
						local g = checkboatMulti()
						if g and not t.Character.Humanoid.Sit then
							toTarget(g.Seat.CFrame)
						elseif
							t.Character.Humanoid.Sit
							and (t.Character:FindFirstChild("HumanoidRootPart"))
							and (t.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("FloatForce"))
						then
							TweenManager.CancelCurrent()
						end
					end)
				end
			end)
		end
		SaveSettings("Multi Find Leviathan", s)
	end
)
LeviathanEventSection.CreateToggle(
	{ Title = "Auto Find Leviathan", Desc = nil, Default = Settings["Auto Find Leviathan"] or false },
	function(s)
		if s then
			spawn(function()
				while Settings["Auto Find Leviathan"] and (task.wait()) do
					local g, g = pcall(function()
						AutoFindLeviathan()
					end)
					if g then
						print(g)
					end
				end
			end)
		end
		SaveSettings("Auto Find Leviathan", s)
	end
)
LeviathanEventSection.CreateToggle(
	{ Title = "Auto Start Leviathan", Desc = nil, Default = Settings["Auto Start Leviathan"] or false },
	function(s)
		if s then
			spawn(function()
				while Settings["Auto Start Leviathan"] and (task.wait(2.5)) do
					local g, g = pcall(function()
						if game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
							local I
							for _, _ in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
								I = (function() if _.Name == "Frozen Watcher" then return _ else return I end end)()
							end
							for _, _ in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
								I = (function() if _.Name == "Frozen Watcher" then return _ else return I end end)()
							end
							if I and t:DistanceFromCharacter(I.HumanoidRootPart.Position) < 8 then
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer("OpenLeviathanGate")
							else
								toTarget(I.HumanoidRootPart.CFrame)
							end
						end
					end)
					if g then
						print(g)
					end
				end
			end)
		end
		SaveSettings("Auto Start Leviathan", s)
	end
)
LeviathanEventSection.CreateToggle(
	{ Title = "Auto Destroy IDK", Desc = nil, Default = Settings["Auto Destroy IDK"] or false },
	function(s)
		if s then
			spawn(function()
				while Settings["Auto Destroy IDK"] and (task.wait(0.1)) do
					local g, g = pcall(function()
						DestroyIDK()
					end)
					if g then
						print(g)
					end
				end
			end)
		end
		SaveSettings("Auto Destroy IDK", s)
	end
)
LeviathanEventSection.CreateToggle(
	{
		Title = "Attack Multi Segments Leviathan",
		Desc = "Please enable the damage counter so I can calculate the damage dealt to that segment.\10plz Turn on multi Segments first.",
		Default = Settings["Attack Multi Segments Leviathan"] or false,
	},
	function(s)
		if s and not Settings["Auto Attack Leviathan"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Auto Attack Leviathan, plz", ShowTime = 5 })
		end
		SaveSettings("Attack Multi Segments Leviathan", s)
	end
)
LeviathanEventSection.CreateSlider(
	{
		Title = "Value Damage Multi Segments",
		Min = 0,
		Max = 1000000,
		Default = Settings["Value Damage Multi Segments"] or 30000,
		Precise = true,
	},
	function(s)
		SaveSettings("Value Damage Multi Segments", s)
	end
)
function DetectLeviathan(s, g)
	local I, _, y = next, s:GetChildren()
	for P, P in I, _, y do
		if P.Name == "Leviathan Tail" and (P:GetAttribute("HealthEnabled")) and P.Health.Value > 0 then
			return P
		end
	end
	y, I, _ = next, s:GetChildren()
	for P, P in y, I, _ do
		if P.Name == "Leviathan" and not P:GetAttribute("Armored") and P.Health.Value > 0 then
			return P
		end
	end
	if g then
		_, I, y = next, s:GetChildren()
		for s, s in _, I, y do
			if s.Name == "Leviathan Segment" and s:GetAttribute("SegmentId") == g and s.Health.Value > 0 then
				return s
			end
		end
	end
end
function MultiSegmentLeviathan(s, g)
	if g then
		local I, _, y, P = Settings["Value Damage Multi Segments"] or 30000, next, s:GetChildren()
		for s, s in _, y, P do
			if
				s.Name == "Leviathan Segment"
				and s:GetAttribute("SegmentId") == g
				and s.Health.Value > 0
				and (not s:FindFirstChild("Tinhdamage") or s:FindFirstChild("Tinhdamage") and s.Tinhdamage.Value < I)
			then
				return s
			end
		end
	end
end
getgenv().CFrameLeviathan = CFrame.new(0, 142, 0)
function AutoAttackLeviathan()
	local s = MultiSegmentLeviathan(game.workspace.SeaBeasts, 2)
		or (MultiSegmentLeviathan(game.workspace.SeaBeasts, 3))
		or (MultiSegmentLeviathan(game.workspace.SeaBeasts, 4))
	if Settings["Attack Multi Segments Leviathan"] then
		local g = Settings["Value Damage Multi Segments"] or 30000
		if s then
			repeat
				task.wait()
				if not s:FindFirstChild("Tinhdamage") then
					Instance.new("IntValue", s).Name = "Tinhdamage"
				end
				if s:FindFirstChild("Tinhdamage") and s.Tinhdamage.Value < g then
					if game:GetService("Players").LocalPlayer.PlayerGui.Main.DmgCounter.Visible and l then
						s.Tinhdamage.Value = s.Tinhdamage.Value + b
						X, l = b, false
						task.wait(0.1)
					end
				end
				if s.Name == "Leviathan" then
					getgenv().AimPos = s.Hitbox11.CFrame
					spawn(function()
						toTarget((CFrame.new(s.HumanoidRootPart.Position.X, 140, s.HumanoidRootPart.Position.Z)))
					end)
				else
					getgenv().AimPos = s.Hitbox11.CFrame
					spawn(function()
						toTarget((CFrame.new(s.HumanoidRootPart.Position.X, 142, s.HumanoidRootPart.Position.Z)))
					end)
				end
				if Settings["Use Click M1 Fruit Leviathan"] then
					equiptool(NameWeapon("Blox Fruit"))
					local b = NameWeapon("Blox Fruit")
					if t.Character:FindFirstChild(b) and (t.Character[b]:FindFirstChild("LeftClickRemote")) then
						getgenv().UseFruitM1(s, true)
					end
				elseif Settings["Use Click M1 Skull Guitar Leviathan"] then
					equiptool(NameWeapon("Gun"))
					SpamGunSkullGuitar(v.Hitbox11)
					if t:DistanceFromCharacter(v.Hitbox11.Position) < 400 then
						UseSkillGun()
					end
				elseif t:DistanceFromCharacter(s.RootPart.Position) < 400 then
					AutoUseSkillSeabeast()
				end
			until not s
				or not s.Parent
				or s.Health.Value == 0
				or not Settings["Auto Attack Leviathan"]
				or s:FindFirstChild("Tinhdamage") and s.Tinhdamage.Value >= g
			return
		end
	end
	local b = DetectLeviathan(game.workspace.SeaBeasts, 2)
		or (DetectLeviathan(game.workspace.SeaBeasts, 3))
		or (DetectLeviathan(game.workspace.SeaBeasts, 4))
		or (DetectLeviathan(game.workspace.SeaBeasts))
	if b then
		repeat
			task.wait()
			if b.Name == "Leviathan" then
				getgenv().AimPos = b.Hitbox11.CFrame
				spawn(function()
					toTarget((CFrame.new(b.HumanoidRootPart.Position.X, 140, b.HumanoidRootPart.Position.Z)))
				end)
			else
				getgenv().AimPos = b.Hitbox11.CFrame
				spawn(function()
					toTarget((CFrame.new(b.HumanoidRootPart.Position.X, 142, b.HumanoidRootPart.Position.Z)))
				end)
			end
			if Settings["Use Click M1 Fruit Leviathan"] then
				equiptool(NameWeapon("Blox Fruit"))
				local X = NameWeapon("Blox Fruit")
				if t.Character:FindFirstChild(X) and (t.Character[X]:FindFirstChild("LeftClickRemote")) then
					getgenv().UseFruitM1(b, true)
				end
			elseif Settings["Use Click M1 Skull Guitar Leviathan"] then
				equiptool(NameWeapon("Gun"))
				SpamGunSkullGuitar(b.Hitbox11)
				if t:DistanceFromCharacter(b.Hitbox11.Position) < 400 then
					UseSkillGun()
				end
			elseif t:DistanceFromCharacter(b.Hitbox11.Position) < 400 then
				AutoUseSkillSeabeast()
			end
		until not b
			or not b.Parent
			or b.Health.Value == 0
			or not Settings["Auto Attack Leviathan"]
			or Settings["Attack Multi Segments Leviathan"] and s
	end
end
local function b(s, X)
	local g = s.PrimaryPart.CFrame
	local l, I = g.Position, (g.LookVector * Vector3.new(1, 0, 1)).Unit
	s = ((X - l) * Vector3.new(1, 0, 1)).Unit
	l = I:Dot(s)
	X, g = math.acos(math.clamp(l, -1, 1)), I:Cross(s)
	I = math.deg(X)
	return (function() if g.Y < 0 then return -I else return I end end)()
end
local function s(X, g)
	local l = X.PrimaryPart.Position
	local I = Vector3.new(g.X, l.Y, g.Z)
	X:SetPrimaryPartCFrame((CFrame.lookAt(l, I)))
end
game:GetService("VirtualInputManager")
local X, g =
	{
		Vector3.new(7415.83251953125, 24.0008487701416, -6664.6826171875),
		Vector3.new(-4703.16015625, 24.000019073486328, -7.822202682495117),
		Vector3.new(-8762.3310546875, 23.99974822998047, -452.2586669921875),
		Vector3.new(-15018.0634765625, 23.999053955078125, 199.0315399169922),
		Vector3.new(-16065.728515625, 23.9991512298584, 421.8982238769531),
	},
	{
		Vector3.new(7415.83251953125, 24.0008487701416, -6664.6826171875),
		Vector3.new(1162.8353271484375, 24.00018882751465, -1825.8121337890625),
		Vector3.new(2517.887451171875, 24.000118255615234, 5109.43115234375),
		Vector3.new(5172.72607421875, 23.999813079833984, 3893.62451171875),
		Vector3.new(5203.80908203125, 24.001039505004883, 2013.0904541015625),
	}
playerModule = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
function AutoMoveTo(l)
	playerModule:GetClickToMoveController():MoveTo(l, false, false)
end
function DriveBoatToTiki()
	for l, I in ipairs(X) do
		while _G.autoDrive and (task.wait()) do
			local X = checkboatFind()
			if not X then
				return
			end
			l = b(X, I)
			if (X.PrimaryPart.Position - I).Magnitude < 10 then
				X.PrimaryPart.ThrottleFloat = 0
				X.PrimaryPart.Throttle = 0
				break
			end
			spawn(function()
				X.VehicleSeat.MaxSpeed = Settings["Speed Boat Auto Drive"] or 300
				NoclipBoat(X)
			end)
			if math.abs(l) > 5 then
				s(X, I)
				X.PrimaryPart.ThrottleFloat = 0
				X.PrimaryPart.Throttle = 0
			else
				X.PrimaryPart.ThrottleFloat = 1
				X.PrimaryPart.Throttle = 1
			end
		end
	end
end
function DriveBoatToHydra()
	for X, l in ipairs(g) do
		while _G.autoDrive and (task.wait(0.1)) do
			local g = checkboatFind()
			if not g then
				return
			end
			X = b(g, l)
			if (g.PrimaryPart.Position - l).Magnitude < 10 then
				g.PrimaryPart.ThrottleFloat = 0
				g.PrimaryPart.Throttle = 0
				break
			end
			spawn(function()
				g.VehicleSeat.MaxSpeed = Settings["Speed Boat Auto Drive"] or 300
				NoclipBoat(g)
			end)
			if math.abs(X) > 5 then
				s(g, l)
				g.PrimaryPart.ThrottleFloat = 0
				g.PrimaryPart.Throttle = 0
			else
				g.PrimaryPart.ThrottleFloat = 1
				g.PrimaryPart.Throttle = 1
			end
		end
	end
end
LeviathanEventSection.CreateToggle(
	{ Title = "Auto Attack Leviathan", Desc = nil, Default = Settings["Auto Attack Leviathan"] or false },
	function(b)
		if b then
			spawn(function()
				while Settings["Auto Attack Leviathan"] and (wait(0.1)) do
					local X, X = pcall(function()
						AutoAttackLeviathan()
					end)
					if X then
						print(X)
					end
				end
			end)
		end
		SaveSettings("Auto Attack Leviathan", b)
	end
)
LeviathanEventSection.CreateToggle(
	{ Title = "Use Click M1 Fruit Leviathan", Desc = nil, Default = Settings["Use Click M1 Fruit Leviathan"] or false },
	function(b)
		SaveSettings("Use Click M1 Fruit Leviathan", b)
	end
)
LeviathanEventSection.CreateToggle(
	{
		Title = "Use Click M1 Skull Guitar Leviathan",
		Desc = nil,
		Default = Settings["Use Click M1 Skull Guitar Leviathan"] or false,
	},
	function(b)
		SaveSettings("Use Click M1 Skull Guitar Leviathan", b)
	end
)
local b = LeviathanEventSection.CreateDropdown(
	{
		Title = "Select Owner Boat Beast Hunter Shoot Heart",
		List = DetectNamePlayer(),
		Search = true,
		Selected = false,
		Default = Settings["Select Owner Boat Beast Hunter"] or nil,
	},
	function(X)
		SaveSettings("Select Owner Boat Beast Hunter", X)
	end
)
LeviathanEventSection.CreateButton({ Title = "Refresh Player" }, function()
	b:GetNewList(DetectNamePlayer())
end)
LeviathanEventSection.CreateToggle(
	{ Title = "Use Your Boat Beast Hunter", Desc = nil, Default = Settings["Use Your Boat Beast Hunter"] or false },
	function(b)
		SaveSettings("Use Your Boat Beast Hunter", b)
	end
)
function checkboatBeastHunter()
	local b = Settings["Select Owner Boat Beast Hunter"]
	b = (function() if Settings["Use Your Boat Beast Hunter"] then return t.Name else return b end end)()
	local X, g, l = next, game:GetService("Workspace").Boats:GetChildren()
	for I, I in X, g, l do
		if I:IsA("Model") then
			if I:FindFirstChild("Owner") and tostring(I.Owner.Value) == b and I.Humanoid.Value > 0 then
				return I
			end
		end
	end
	return false
end
function ShootHeartLeviathan()
	if workspace.Map:FindFirstChild("FrozenHeart") then
		if not workspace.Map.FrozenHeart.Inside:GetAttribute("Harpooned") then
			local b = checkboatBeastHunter()
			NoclipBoat(b)
			local X, g, l, I =
				game:service("TweenService"),
				CFrame.new(
					workspace.Map:FindFirstChild("FrozenHeart").Cube.Position.X,
					b.WorldPivot.Y,
					workspace.Map:FindFirstChild("FrozenHeart").Cube.Position.Z
				) * CFrame.new(0, 0, 300),
				CFrame.Angles,
				math.rad
			local I = g * l(0, 6.283185307179586, 0)
			if (I.Position - b.VehicleSeat.Position).Magnitude > 5 then
				if t.Character.Humanoid.SeatPart and t.Character.Humanoid.SeatPart.Name == "VehicleSeat" then
					l = TweenInfo.new((I.Position - b.VehicleSeat.Position).Magnitude / 150, Enum.EasingStyle.Quad)
					g = X:Create(b.VehicleSeat, l, { CFrame = I })
					g:Play()
					g.Completed:wait()
					wait(1)
					s(b, workspace.Map:FindFirstChild("FrozenHeart").Inside.Position)
				else
					toTarget(b.VehicleSeat.CFrame)
				end
			elseif t.Character.Humanoid.SeatPart and t.Character.Humanoid.SeatPart.Parent.Name == "Harpoon" then
				local s = {
					[1] = "FireHarpoon",
					[2] = 0.7853981633974483,
					[3] = 4.4342573293783646E-4,
					[4] = b.Harpoon,
					[5] = workspace:GetServerTimeNow(),
				}
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(s))
			else
				toTarget(b.Harpoon.Seat.CFrame)
			end
		else
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Successfully Fire Shoot Heart Leviathan", ShowTime = 5 })
			wait(5)
		end
	end
end
LeviathanEventSection.CreateToggle(
	{
		Title = "Auto Fire Shoot Heart Leviathan",
		Desc = nil,
		Default = Settings["Auto Fire Shoot Heart Leviathan"] or false,
	},
	function(b)
		if b then
			spawn(function()
				while Settings["Auto Fire Shoot Heart Leviathan"] and (task.wait(0.1)) do
					local s, s = pcall(function()
						ShootHeartLeviathan()
					end)
					if s then
						print(s)
					end
				end
			end)
		end
		SaveSettings("Auto Fire Shoot Heart Leviathan", b)
	end
)
LeviathanEventSection.CreateToggle(
	{ Title = "Teleport Frozen Dimension", Desc = nil, Default = Settings["Teleport Frozen Dimension"] or false },
	function(b)
		if b then
			spawn(function()
				while Settings["Teleport Frozen Dimension"] and (wait()) do
					pcall(function()
						if game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
							local s = DetectNpc("Frozen Watcher")
							if s then
								toTarget(s.HumanoidRootPart.CFrame)
								return
							end
						end
					end)
				end
			end)
		end
		SaveSettings("Teleport Frozen Dimension", b)
	end
)
LeviathanEventSection.CreateToggle(
	{
		Title = "Tween Boat To Frozen Dimension",
		Desc = nil,
		Default = Settings["Tween Boat To Frozen Dimension"] or false,
	},
	function(b)
		if b then
			spawn(function()
				while Settings["Tween Boat To Frozen Dimension"] and (wait()) do
					pcall(function()
						if game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
							AllNPCS = {}
							for s, s in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
								table.insert(AllNPCS, s)
							end
							for s, s in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
								table.insert(AllNPCS, s)
							end
							for s, X in pairs(AllNPCS) do
								if X.Name == "Frozen Watcher" then
									s = checkboatFind()
									repeat
										task.wait()
										local g = CFrame.new(
											X.HumanoidRootPart.Position.X,
											s.VehicleSeat.Position.Y,
											X.HumanoidRootPart.Position.Z
										)
										manageTween(s.VehicleSeat, g, 350, "TweenBoatToFrozen")
										NoclipBoat(s)
									until game:GetService("Workspace").NPCs:FindFirstChild("Frozen Watcher")
										or not Settings["Tween Boat To Frozen Dimension"]
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
		SaveSettings("Tween Boat To Frozen Dimension", b)
	end
)
LeviathanEventSection.CreateSlider(
	{
		Title = "Speed Boat Auto Drive",
		Min = 0,
		Max = 500,
		Default = Settings["Speed Boat Auto Drive"] or 300,
		Precise = true,
	},
	function(b)
		SaveSettings("Speed Boat Auto Drive", b)
	end
)
LeviathanEventSection.CreateToggle(
	{ Title = "Drive Boat To Tiki", Desc = nil, Default = Settings["Drive Boat To Tiki"] or false },
	function(b)
		_G.autoDrive = b
		if b then
			spawn(function()
				local s, X = pcall(DriveBoatToTiki)
				if not s then
					warn("L\225\187\151i khi ch\225\186\161y DriveBoatToTiki:", X)
				end
			end)
		end
		SaveSettings("Drive Boat To Tiki", b)
	end
)
LeviathanEventSection.CreateToggle(
	{ Title = "Drive Boat To Hydra", Desc = nil, Default = Settings["Drive Boat To Hydra"] or false },
	function(b)
		_G.autoDrive = b
		if b then
			spawn(function()
				local s, X = pcall(DriveBoatToHydra)
				if not s then
					warn("L\225\187\151i khi ch\225\186\161y DriveBoatToHydra:", X)
				end
			end)
		end
		SaveSettings("Drive Boat To Hydra", b)
	end
)
BoatSettingSection = SeaEventTab.CreateSection("Boat Setting")
local b = table.find({ Enum.Platform.IOS, Enum.Platform.Android }, game:GetService("UserInputService"):GetPlatform())
FLYING = false
QEfly = true
iyflyspeed = 1
IYMouse = IYMouse or game:GetService("Players").LocalPlayer:GetMouse()
function getRoot(s)
	return s:FindFirstChild("HumanoidRootPart") or (s:FindFirstChild("Torso")) or (s:FindFirstChild("UpperTorso"))
end
function sFLY(s)
	repeat
		wait()
	until t and t.Character and (getRoot(t.Character)) and (t.Character:FindFirstChildOfClass("Humanoid"))
	repeat
		wait()
	until IYMouse
	if flyKeyDown or flyKeyUp then
		flyKeyDown:Disconnect()
		flyKeyUp:Disconnect()
	end
	local X, g, l, I =
		getRoot(t.Character),
		{ F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 },
		{ F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 },
		0
	local function _()
		FLYING = true
		local y = Instance.new("BodyVelocity")
		y.Parent = X
		y.velocity = Vector3.new(0, 0, 0)
		y.maxForce = Vector3.new(9000000000, 9000000000, 9000000000)
		task.spawn(function()
			repeat
				wait()
				if not s and (S.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")) then
					S.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
				end
				local X = g.L + g.R ~= 0 or g.F + g.B ~= 0 or g.Q + g.E ~= 0
				if X then
					I = 50
				else
					local X = not (g.L + g.R ~= 0 or g.F + g.B ~= 0 or g.Q + g.E ~= 0) and I ~= 0
					if X then
						I = 0
					end
				end
				if g.L + g.R ~= 0 or g.F + g.B ~= 0 or g.Q + g.E ~= 0 then
					y.velocity = (
						workspace.CurrentCamera.CoordinateFrame.lookVector * (g.F + g.B)
						+ (
							workspace.CurrentCamera.CoordinateFrame
								* CFrame.new(g.L + g.R, (g.F + g.B + g.Q + g.E) * 0.2, 0).p
							- workspace.CurrentCamera.CoordinateFrame.p
						)
					) * I
					l = { F = g.F, B = g.B, L = g.L, R = g.R }
				elseif g.L + g.R == 0 and g.F + g.B == 0 and g.Q + g.E == 0 and I ~= 0 then
					y.velocity = (
						workspace.CurrentCamera.CoordinateFrame.lookVector * (l.F + l.B)
						+ (
							workspace.CurrentCamera.CoordinateFrame
								* CFrame.new(l.L + l.R, (l.F + l.B + g.Q + g.E) * 0.2, 0).p
							- workspace.CurrentCamera.CoordinateFrame.p
						)
					) * I
				else
					y.velocity = Vector3.new(0, 0, 0)
				end
			until not FLYING
			g, l, I = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }, { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }, 0
			y:Destroy()
			if S.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				S.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
			end
		end)
	end
	flyKeyDown = IYMouse.KeyDown:Connect(function(X)
		if X:lower() == "w" then
			g.F = s and vehicleflyspeed or iyflyspeed
		elseif X:lower() == "s" then
			g.B = -(s and vehicleflyspeed or iyflyspeed)
		elseif X:lower() == "a" then
			g.L = -(s and vehicleflyspeed or iyflyspeed)
		elseif X:lower() == "d" then
			g.R = s and vehicleflyspeed or iyflyspeed
		elseif QEfly and X:lower() == "e" then
			g.Q = (s and vehicleflyspeed or iyflyspeed) * 2
		elseif QEfly and X:lower() == "q" then
			g.E = -(s and vehicleflyspeed or iyflyspeed) * 2
		end
		pcall(function()
			workspace.CurrentCamera.CameraType = Enum.CameraType.Track
		end)
	end)
	flyKeyUp = IYMouse.KeyUp:Connect(function(s)
		if s:lower() == "w" then
			g.F = 0
		elseif s:lower() == "s" then
			g.B = 0
		elseif s:lower() == "a" then
			g.L = 0
		elseif s:lower() == "d" then
			g.R = 0
		elseif s:lower() == "e" then
			g.Q = 0
		elseif s:lower() == "q" then
			g.E = 0
		end
	end)
	_()
end
function randomStringfly()
	local s = {}
	for X = 1, math.random(10, 20), 1 do
		s[X] = string.char(math.random(32, 126))
	end
	return table.concat(s)
end
function NOFLY()
	FLYING = false
	if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGuiFly") then
		game.Players.LocalPlayer.PlayerGui.ScreenGuiFly:Destroy()
	end
	if flyKeyDown or flyKeyUp then
		flyKeyDown:Disconnect()
		flyKeyUp:Disconnect()
	end
	if S.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		S.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
	end
	pcall(function()
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
end
local s, X = randomStringfly(), randomStringfly()
local g, l
local function S(I)
	pcall(function()
		FLYING = false
		game.Players.LocalPlayer.PlayerGui.ScreenGuiFly:Destroy()
		local _ = getRoot(I.Character)
		_:FindFirstChild(s):Destroy()
		_:FindFirstChild(X):Destroy()
		I.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
		g:Disconnect()
		l:Disconnect()
	end)
end
local function X(I, _)
	S(I)
	FLYING = true
	local y, P, Y, H, Z, C, J =
		getRoot(I.Character),
		workspace.CurrentCamera,
		Vector3.new(),
		Vector3.new(0, 0, 0),
		Vector3.new(9000000000, 9000000000, 9000000000),
		require(I.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")),
		Instance.new("BodyVelocity")
	J.Name = s
	J.Parent = y
	J.MaxForce = H
	J.Velocity = H
	g = I.CharacterAdded:Connect(function()
		local g = Instance.new("BodyVelocity")
		g.Name = s
		g.Parent = y
		g.MaxForce = H
		g.Velocity = H
	end)
	local g, H, J = Instance.new("ScreenGui"), Instance.new("TextButton"), Instance.new("TextButton")
	g.Name = "ScreenGuiFly"
	g.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	g.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	g.ResetOnSpawn = false
	H.Name = "FlyUp"
	H.Parent = g
	H.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	H.BackgroundTransparency = 1
	H.BorderColor3 = Color3.fromRGB(0, 0, 0)
	H.BorderSizePixel = 0
	H.Position = UDim2.new(0.158661261, 0, 0.82663101, 0)
	H.Size = UDim2.new(0.0538219661, 0, 0.0765434727, 0)
	H.Font = Enum.Font.SourceSans
	H.Text = "\226\134\145"
	H.TextColor3 = Color3.fromRGB(0, 0, 0)
	H.TextScaled = true
	H.TextSize = 14
	H.TextWrapped = true
	J.Name = "FlyDown"
	J.Parent = g
	J.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	J.BackgroundTransparency = 1
	J.BorderColor3 = Color3.fromRGB(0, 0, 0)
	J.BorderSizePixel = 0
	J.Position = UDim2.new(0.158661261, 0, 0.922887683, 0)
	J.Size = UDim2.new(0.0538219661, 0, 0.0765434727, 0)
	J.Font = Enum.Font.SourceSans
	J.Text = "\226\134\147"
	J.TextColor3 = Color3.fromRGB(0, 0, 0)
	J.TextScaled = true
	J.TextSize = 14
	J.TextWrapped = true
	l = game:GetService("RunService").RenderStepped:Connect(function()
		y = getRoot(I.Character)
		P = workspace.CurrentCamera
		if I.Character:FindFirstChildWhichIsA("Humanoid") and y and (y:FindFirstChild(s)) then
			local g, l = I.Character:FindFirstChildWhichIsA("Humanoid"), y:FindFirstChild(s)
			l.MaxForce = Z
			if not _ then
				g.PlatformStand = true
			end
			l.Velocity = Y
			g = C:GetMoveVector()
			if g.X > 0 then
				l.Velocity = l.Velocity + P.CFrame.RightVector * (g.X * ((_ and vehicleflyspeed or iyflyspeed) * 50))
			end
			if g.X < 0 then
				l.Velocity = l.Velocity + P.CFrame.RightVector * (g.X * ((_ and vehicleflyspeed or iyflyspeed) * 50))
			end
			if g.Z > 0 then
				l.Velocity = l.Velocity - P.CFrame.LookVector * (g.Z * ((_ and vehicleflyspeed or iyflyspeed) * 50))
			end
			if g.Z < 0 then
				l.Velocity = l.Velocity - P.CFrame.LookVector * (g.Z * ((_ and vehicleflyspeed or iyflyspeed) * 50))
			end
			J.MouseButton1Click:Connect(function()
				l.Velocity = Vector3.new(0, -20, 0)
			end)
			H.MouseButton1Click:Connect(function()
				l.Velocity = Vector3.new(0, 20, 0)
			end)
		end
	end)
end
BoatSettingSection.CreateToggle({ Title = "Fly Boat", Desc = nil, Default = Settings["Fly Boat"] or false }, function(s)
	if s then
		spawn(function()
			while Settings["Fly Boat"] and (wait(0.1)) do
				pcall(function()
					if t.Character.Humanoid.Sit then
						if not b then
							NOFLY()
							wait()
							sFLY(true)
						else
							X(t, true)
						end
						repeat
							wait()
						until not Settings["Fly Boat"] or not t.Character.Humanoid.Sit
						if not b then
							NOFLY()
						else
							S(t)
						end
					end
				end)
			end
		end)
	end
	SaveSettings("Fly Boat", s)
end)
R = Settings["Value Speed Fly Boat"]
BoatSettingSection.CreateSlider(
	{ Title = "Value Speed Boat", Min = 0, Max = 500, Default = Settings["Value Speed Boat"] or 200, Precise = true },
	function(b)
		SaveSettings("Value Speed Boat", b)
	end
)
BoatSettingSection.CreateSlider(
	{
		Title = "Value Speed Tween Boat",
		Min = 50,
		Max = 2000,
		Default = tonumber(Settings["Value Speed Tween Boat"]) or 350,
		Precise = true,
	},
	function(b)
		SaveSettings("Value Speed Tween Boat", b)
		local s = getgenv().TweenBoat
		if s and s.Speed then
			s.Speed = math.max(tonumber(b) or 350, 1)
		end
	end
)
BoatSettingSection.CreateSlider(
	{
		Title = "Value Speed Fly Boat",
		Min = 0,
		Max = 10,
		Default = Settings["Value Speed Fly Boat"] or 3,
		Precise = true,
	},
	function(b)
		SaveSettings("Value Speed Fly Boat", b)
	end
)
function checkSpeedboat()
	local b, s = tonumber(Settings["Value Speed Boat"]) or 200, checkboat()
	if s then
		local X = s:FindFirstChild("VehicleSeat")
		if X and X.MaxSpeed + 1 < b then
			return s
		end
	end
	return false
end
function ChangeSpeedBoat()
	local b, s = tonumber(Settings["Value Speed Boat"]) or 200, checkSpeedboat()
	if s then
		s.VehicleSeat.MaxSpeed = b
	end
end
BoatSettingSection.CreateToggle(
	{ Title = "Change Speed Boat", Desc = nil, Default = Settings["Change Speed Boat"] or false },
	function(b)
		if b then
			spawn(function()
				while Settings["Change Speed Boat"] and (task.wait(0.3)) do
					local s, X = pcall(ChangeSpeedBoat)
					if not s then
						WarnOnce("ChangeSpeedBoat", "Change Speed Boat loi: " .. tostring(X))
					end
				end
			end)
		end
		SaveSettings("Change Speed Boat", b)
	end
)
RaceMain = Main.CreatePage({ Page_Name = "Upgrade Race", Page_Title = "Upgrade Race Tab" })
RaceDracoSection = RaceMain.CreateSection("Race Draco")
function DetectGearUp(b)
	local s = require(game:GetService("Players").LocalPlayer.PlayerGui.TempleGui.LocalScriptTemple.Buttons)
	b = b or (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TempleClock", "Check"))
	if type(b) ~= "table" then
		return
	end
	local X, g = b.HadPoint == true, b.RaceLevel >= 2
	s.Gear1.GearType = "Default"
	s.Gear4.GearType = "Default"
	s.Gear5.GearType = "Default"
	s.Gear2.GearType = "Alpha"
	s.Gear2.CanSelect = false
	s.Gear3.CanSelect = false
	s.Gear2.GearType = b.RaceDetails.Gears[1] == "A" and "Alpha" or b.RaceDetails.Gears[1] == "B" and "Omega" or "Blank"
	s.Gear3.GearType = b.RaceDetails.Gears[2] == "A" and "Alpha" or b.RaceDetails.Gears[2] == "B" and "Omega" or "Blank"
	s.Gear4.GearType = b.RaceDetails.Gears[3] == "A" and "Alpha" or b.RaceDetails.Gears[3] == "B" and "Omega" or "Blank"
	s.Gear2.Unlocked = (function() if b.RaceDetails.A + b.RaceDetails.B >= 0 then return g else return false end end)()
	s.Gear3.Unlocked = (function() if b.RaceDetails.A + b.RaceDetails.B >= 1 then return g else return false end end)()
	s.Gear4.Unlocked = (function() if b.RaceDetails.A + b.RaceDetails.B >= 2 then return g else return false end end)()
	s.Gear5.CanSelect = false
	s.Gear5.Unlocked = false
	if b.RaceDetails.C >= 1 then
		s.Gear5.Unlocked = true
	end
	s.Gear1.Unlocked = true
	if not g then
		s.Gear1.CanSelect = true
		s.Gear1.GearType = "Blank"
		X = true
	else
		s.Gear1.CanSelect = false
		s.Gear1.GearType = "Default"
	end
	if not X then
		s.Gear2.CanSelect = false
		s.Gear3.CanSelect = false
		s.Gear4.CanSelect = false
	else
		s.Gear2.CanSelect = (function() if b.RaceDetails.A + b.RaceDetails.B == 0 then return g else return false end end)()
		s.Gear3.CanSelect = (function() if b.RaceDetails.A + b.RaceDetails.B == 1 then return g else return false end end)()
		s.Gear4.CanSelect = (function() if b.RaceDetails.A + b.RaceDetails.B >= 2 then return g else return false end end)()
		if b.RaceDetails.A + b.RaceDetails.B >= 3 then
			s.Gear2.CanSelect = true
			s.Gear3.CanSelect = true
			s.Gear4.CanSelect = true
			if s.Gear2.GearType == "Alpha" and s.Gear3.GearType == "Alpha" and s.Gear4.GearType == "Omega" then
				s.Gear4.CanSelect = false
			elseif s.Gear2.GearType == "Omega" and s.Gear3.GearType == "Omega" and s.Gear4.GearType == "Alpha" then
				s.Gear4.CanSelect = false
			elseif s.Gear2.GearType == "Alpha" and s.Gear3.GearType == "Omega" and s.Gear4.GearType == "Omega" then
				s.Gear4.CanSelect = false
				s.Gear2.CanSelect = false
			elseif s.Gear2.GearType == "Omega" and s.Gear3.GearType == "Alpha" and s.Gear4.GearType == "Omega" then
				s.Gear4.CanSelect = false
				s.Gear3.CanSelect = false
			elseif s.Gear2.GearType == "Omega" and s.Gear3.GearType == "Alpha" and s.Gear4.GearType == "Alpha" then
				s.Gear4.CanSelect = false
				s.Gear2.CanSelect = false
			elseif s.Gear2.GearType == "Alpha" and s.Gear3.GearType == "Omega" and s.Gear4.GearType == "Alpha" then
				s.Gear4.CanSelect = false
				s.Gear3.CanSelect = false
			end
		end
	end
	for X = 1, 5, 1 do
		b = s["Gear" .. X]
		if b and b.CanSelect then
			return "Gear" .. X
		end
	end
end
function ChooseGearV4()
	local b = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TempleClock", "Check")
	if not b or not b.HadPoint then
		return
	end
	local s = DetectGearUp(b)
	if not s then
		return
	end
	b = Settings["Select Gear V4"] == "Alpha" and "Alpha" or "Omega"
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TempleClock", "SpendPoint", s, b)
	local X = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TempleClock", "Check")
	if X and X.HadPoint and DetectGearUp(X) == s then
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
			"TempleClock",
			"SpendPoint",
			s,
			b == "Alpha" and "Omega" or "Alpha"
		)
	end
end
function DetectFireFlower()
	local b, s, X = next, workspace.FireFlowers:GetChildren()
	for g, g in b, s, X do
		if g:IsA("Model") then
			return g
		end
	end
end
local b = { "V2InProgress", "V3InProgress", "V2TurnInReady", "V3TurnInReady" }
function AutoUpgradeRaceDraco()
	if game.Players.LocalPlayer.Data.Race.Value ~= "Draco" then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Change Race Draco plz", ShowTime = 5 })
		wait(5)
		return
	elseif DetectItemPlr("Primordial Reign") then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Done V3 Draco", ShowTime = 5 })
		wait(5)
		return
	end
	local s = workspace.NPCs:FindFirstChild("Dragon Wizard")
		or (game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Wizard"))
		or NPCManager.getNPCsByName("Dragon Wizard")[1]._modelState._instance
	if not getgenv().QuestDraco or getgenv().QuestDraco and not table.find(b, getgenv().QuestDraco.AvailableVQuest) then
		if t:DistanceFromCharacter(s.HumanoidRootPart.Position) > 8 then
			toTarget(s.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
		else
			getgenv().QuestDraco = game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]
				:InvokeServer({ NPC = "Dragon Wizard", Command = "Speak" })
			wait(1)
			if
				getgenv().QuestDraco and getgenv().QuestDraco.AvailableVQuest == "V2"
				or getgenv().QuestDraco.AvailableVQuest == "V3"
			then
				game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]
					:InvokeServer({ NPC = "Dragon Wizard", Command = "Ascension", Action = "Begin" })
				getgenv().QuestDraco = game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]
					:InvokeServer({ NPC = "Dragon Wizard", Command = "Speak" })
			end
		end
	elseif getgenv().QuestDraco.AvailableVQuest == "V2TurnInReady" then
		game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]
			:InvokeServer({ NPC = "Dragon Wizard", Command = "Ascension", Action = "Complete" })
		getgenv().QuestDraco = nil
	elseif getgenv().QuestDraco.AvailableVQuest == "V3TurnInReady" then
		game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]
			:InvokeServer({ NPC = "Dragon Wizard", Command = "Ascension", Action = "Complete" })
		getgenv().QuestDraco = nil
	elseif getgenv().QuestDraco.AvailableVQuest == "V2InProgress" then
		if not CheckCountItem("Fire Flower", 5) then
			local b = DetectFireFlower()
			if b then
				toTarget(b.PrimaryPart.CFrame)
				if t:DistanceFromCharacter(b.PrimaryPart.Position) < 8 then
					fireproximityprompt(b.ProximityPrompt, 1)
				end
			else
				local b = DetectMob("Forest Pirate")
				if not b then
					local X = DetectPartSpawnMob("Forest Pirate", true)
					if X then
						Instance.new("IntValue", X).Name = "Ignored"
						repeat
							wait()
							toTarget(X.CFrame * CFrame.new(0, 60, 0))
						until (X.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
							or (DetectMob("Forest Pirate"))
							or not Settings["Auto Upgrade Race V2-V3 Draco"]
							or (wait(1))
					else
						DeleteIgnoredMobSpawn()
					end
				else
					repeat
						task.wait()
						sizepart(b)
						BringMob(b)
						UsedualFlock()
						ClickM1(b)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(b.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(b.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
					until not IsMobAlive(b) or not Settings["Auto Upgrade Race V2-V3 Draco"]
				end
			end
		elseif t:DistanceFromCharacter(s.HumanoidRootPart.Position) > 8 then
			toTarget(s.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
		else
			game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]
				:InvokeServer({ NPC = "Dragon Wizard", Command = "Ascension", Action = "Complete" })
			getgenv().QuestDraco = nil
		end
	elseif getgenv().QuestDraco.AvailableVQuest == "V3InProgress" then
		SaveSettings("V3InProgress", true)
		if not getgenv().KilledTerroshark then
			local b, X = CheckNameBoss("Terrorshark"), checkboat()
			if not b then
				if not X then
					local g = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
					if (g.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
						toTarget(g)
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
					end
				else
					local g = DecectPartRoughSea()
					if g then
						wait(1)
						V = ((V == 0) and 7000 or 0)
						Instance.new("IntValue", g).Name = "Ignored"
						wait(0.5)
					end
					getgenv().RoughSea = V
					g = CFrame.new(-32975.9921875, X.WorldPivot.Y, 25963.7109375)
						* CFrame.new(0, X.WorldPivot.Y, 0 + RoughSea)
					if not t.Character.Humanoid.Sit then
						toTarget(X.VehicleSeat.CFrame)
					else
						manageTween(X.VehicleSeat, g, 350, "TweenBoat")
					end
				end
			else
				repeat
					task.wait()
					TeleportSeaEvents(b)
					local X = b:FindFirstChild("HumanoidRootPart")
					getgenv().AimPos = CFrame.new(X.Position.X, 40, X.Position.Z)
					UsedualFlock()
					ClickM1(b, true)
				until not IsMobAlive(b) or not Settings["Auto Upgrade Race V2-V3 Draco"]
				getgenv().KilledTerroshark = true
			end
		elseif t:DistanceFromCharacter(s.HumanoidRootPart.Position) > 8 then
			toTarget(s.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
		else
			game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]
				:InvokeServer({ NPC = "Dragon Wizard", Command = "Ascension", Action = "Complete" })
			getgenv().QuestDraco = nil
			getgenv().KilledTerroshark = false
		end
	end
end
RaceDracoSection.CreateToggle(
	{ Title = "Auto Upgrade Race V2-V3 Draco", Desc = nil, Default = Settings["Auto Upgrade Race V2-V3 Draco"] or false },
	function(b)
		if b then
			spawn(function()
				while Settings["Auto Upgrade Race V2-V3 Draco"] and (task.wait()) do
					local s, s = pcall(function()
						AutoUpgradeRaceDraco()
					end)
					if s then
						print(s)
					end
				end
			end)
		end
		SaveSettings("Auto Upgrade Race V2-V3 Draco", b)
	end
)
function CheckRelicChuaDat(b)
	for s, s in pairs(b:GetDescendants()) do
		if s:IsA("ParticleEmitter") and s.Enabled then
			return true
		end
	end
end
function GetRelicChuaDat(b)
	for s, X in next, b, nil do
		if string.find(s, "RelicModel") and (CheckRelicChuaDat(X)) then
			return X, s
		end
	end
end
function GetRelicChuanbiDat(b)
	for s, X in next, b, nil do
		if
			string.find(s, "RelicModel")
			and (X.PrimaryPart:FindFirstChild("AlignPosition"))
			and (CheckRelicChuaDat(X))
		then
			return X, s
		end
	end
end
function CheckModelTrialDraco()
	local b = {}
	v28 = workspace:WaitForChild("Map"):WaitForChild("DracoTrial")
	local s = {
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
	}
	for X, X in pairs(s) do
		b[X] = v28:FindFirstChild(X, true)
	end
	local X, g, R = next, workspace._WorldOrigin:GetChildren()
	for l, l in X, g, R do
		if l:IsA("Model") and l.Name == "Relic" then
			s = l:FindFirstChildWhichIsA("MeshPart")
			if s.Color == Color3.fromRGB(132, 203, 0) then
				b.RelicModel1 = l
			end
			if s.Color == Color3.fromRGB(232, 106, 110) then
				b.RelicModel2 = l
			end
			if s.Color == Color3.fromRGB(191, 153, 0) then
				b.RelicModel3 = l
			end
		end
	end
	return b
end
getgenv().StatusGearDraco = RaceDracoSection.CreateLabel({ Title = "Acient One Draco Status" })
ToggleAutoTrialDraco = RaceDracoSection.CreateToggle(
	{ Title = "Auto Trial Draco", Desc = nil, Default = Settings["Auto Trial Draco"] or false },
	function(b)
		if b then
			spawn(function()
				while Settings["Auto Trial Draco"] and (task.wait(0.1)) do
					local s, s = pcall(function()
						if
							t:DistanceFromCharacter(workspace._WorldOrigin.Locations["Trial of Flames"].Position)
							<= 3000
						then
							if workspace.Map.DracoTrial.TrialDoor.DoorTouch:FindFirstChild("TouchInterest") then
								getgenv().DoneTrialDraco = true
								toTarget(workspace.Map.DracoTrial.TrialDoor.DoorTouch.CFrame)
								wait(2)
								return
							end
							if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
								local X = CheckModelTrialDraco()
								local g, R = GetRelicChuaDat(X)
								local l, S = GetRelicChuanbiDat(X)
								if l then
									local l = X["EndRelic" .. S:split("RelicModel")[2]]
									local S = l:FindFirstChildWhichIsA("ProximityPrompt", true)
									if t:DistanceFromCharacter(l.WorldPivot.Position) > 8 then
										toTarget(l.WorldPivot)
									else
										wait(2)
										fireproximityprompt(S)
										wait(2)
									end
								elseif g then
									local g = X["Relic" .. R:split("RelicModel")[2]]
									local X = g:FindFirstChildWhichIsA("ProximityPrompt", true)
									if t:DistanceFromCharacter(g.WorldPivot.Position) > 8 then
										toTarget(g.WorldPivot)
									else
										wait(2)
										fireproximityprompt(X)
										wait(2)
									end
								end
							else
								game.ReplicatedStorage.Remotes.DracoTrial:InvokeServer()
								wait(3)
							end
						else
							if getgenv().DoneTrialDraco then
								A.CreateNoti({ Title = "Noijo Hub", Desc = "Done Trial", ShowTime = 5 })
								getgenv().DoneTrialDraco = false
								ToggleAutoTrialDraco:SetStage(false)
								return
							end
							if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
								if workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport") then
									toTarget(workspace.Map.PrehistoricIsland.TrialTeleport.CFrame)
								else
									local X = DetectNpc("Fossil Expert")
									if X then
										toTarget(X.HumanoidRootPart.CFrame)
										return
									end
								end
							else
								A.CreateNoti({
									Title = "Noijo Hub",
									Desc = "Not have Prehistoric Island",
									ShowTime = 5,
								})
								wait(5)
							end
						end
					end)
					if s then
						print(s)
					end
				end
			end)
		end
		SaveSettings("Auto Trial Draco", b)
	end
)
function DetectRockVolcano()
	local b, s, X = next, workspace.Map.PrehistoricIsland.Core.VolcanoRocks:GetChildren()
	local g, R = 1 / 0
	for l, S in b, s, X do
		if
			S.Name == "Rock"
			and (S:FindFirstChild("VFXLayer"))
			and (S.VFXLayer:FindFirstChild("Specs"))
			and S.VFXLayer.Specs.Enabled
		then
			l = t:DistanceFromCharacter(S.WorldPivot.Position)
			if g > l then
				g, R = l, S
			end
		end
	end
	return R
end
function AutoUseSkillFixLava(b)
	b = Settings["Select Weapons Fix Lava"] or {}
	local s, X, g, R, l =
		b.Melee and (NameWeapon("Melee", true)) or false,
		b.Sword and (NameWeapon("Sword", true)) or false,
		b["Blox Fruit"] and (NameWeapon("Blox Fruit", true)) or false,
		b.Gun and (NameWeapon("Gun", true)) or false,
		game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills
	if s and not l:FindFirstChild(s.Name) then
		equiptool(s.Name)
		return
	end
	if X and not l:FindFirstChild(X.Name) then
		equiptool(X.Name)
		return
	end
	if g and not l:FindFirstChild(g.Name) then
		equiptool(g.Name)
		return
	end
	if R and not l:FindFirstChild(R.Name) then
		equiptool(R.Name)
		return
	end
	l = (function() if s and (CheckCDSkillTransformation(s, Settings["Select Skills " .. s.ToolTip])) then return (CheckCDSkillTransformation(s, Settings["Select Skills " .. s.ToolTip])) else return (function() if X and (CheckCDSkillTransformation(X, Settings["Select Skills " .. X.ToolTip])) then return (CheckCDSkillTransformation(X, Settings["Select Skills " .. X.ToolTip])) else return (function() if R and (CheckCDSkillTransformation(R, Settings["Select Skills " .. R.ToolTip])) then return (CheckCDSkillTransformation(R, Settings["Select Skills " .. R.ToolTip])) else return (function() if g and (CheckCDSkillTransformation(g, Settings["Select Skills " .. g.ToolTip])) then return (CheckCDSkillTransformation(g, Settings["Select Skills " .. g.ToolTip])) else return nil end end)() end end)() end end)() end end)()
	if l then
		X = l.Parent.Name
		equiptool(X)
		if t.Character:FindFirstChild(X) then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, l.Name, false, game)
			if Settings["Use skill fast dont hold"] then
				task.wait(0.05)
			else
				task.wait(HoldDelay(l.Name, X))
			end
			game:GetService("VirtualInputManager"):SendKeyEvent(false, l.Name, false, game)
		end
	end
end
function DetectLava()
	local b, s, X = next, workspace.Map.PrehistoricIsland:GetDescendants()
	for g, g in b, s, X do
		if g.Name == "TouchInterest" and g.Parent.Name ~= "TrialTeleport" then
			return true
		end
	end
end
function DetectGolem()
	for b, b in ipairs(game.workspace.Enemies:GetChildren()) do
		if
			b.Name == "Lava Golem"
			and (IsMobAlive(b))
			and t:DistanceFromCharacter(b.HumanoidRootPart.Position) <= 1500
		then
			return b
		end
	end
end
function DeleteLava()
	local b, s, X = next, workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren()
	for g, g in b, s, X do
		g:Destroy()
	end
end
function DetectPositionVolcano()
	local b, s, X, g =
		{ [1] = workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull.Position },
		next,
		workspace.Map.PrehistoricIsland:GetDescendants()
	for R, R in s, X, g do
		if R:IsA("MeshPart") and R.MeshId == "rbxassetid://87519803677536" and math.floor(R.Position.Y) == 293 then
			b[2] = R.Position
		end
		if R:IsA("MeshPart") and R.MeshId == "rbxassetid://9664674474" and math.floor(R.Position.Y) == 234 then
			b[3] = R.Position
		end
		if R:IsA("MeshPart") and R.MeshId == "rbxassetid://14130842310" and math.floor(R.Position.Y) == 266 then
			b[4] = R.Position
		end
		if R:IsA("MeshPart") and R.MeshId == "rbxassetid://15672470777" and math.floor(R.Position.Y) == 86 then
			b[5] = R.Position
		end
		if R:IsA("MeshPart") and R.MeshId == "rbxassetid://5159878936" and math.floor(R.Position.Y) == 261 then
			b[6] = R.Position
		end
		if R:IsA("MeshPart") and R.MeshId == "rbxassetid://138849514693209" and math.floor(R.Position.Y) == 242 then
			b[7] = R.Position
		end
		if R:IsA("MeshPart") and R.MeshId == "rbxassetid://87519803677536" and math.floor(R.Position.Y) == 279 then
			b[8] = R.Position
		end
	end
	return b
end
function CheckPosnearRock(b, s)
	local X, g = 1 / 0
	local R = 0
	for l, S in next, b, nil do
		local b = Vector3.new(S.X, 0, S.Z)
		local I = (Vector3.new(s.Position.X, 0, s.Position.Z) - b).Magnitude
		if X > I then
			X, g, R = I, S, l
		end
	end
	return g, R
end
local b, s, X =
	false,
	1,
	{
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
function BuyGearDracoV4()
	if string.find(CheckAcientOneDracoStatus(), "Can Buy Gear") then
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
	end
end
function FullyDraco()
	if not Settings["Auto Turn On V4"] then
		m:SetStage(true)
	end
	if not Settings["Auto Choose Gears"] and getgenv().ToggleAutoChooseGears then
		getgenv().ToggleAutoChooseGears:SetStage(true)
	end
	if CheckAcientOneDracoStatus() == "Ready For Trial" then
		if getgenv().WaitingjoinTrial then
			wait(5)
			getgenv().WaitingjoinTrial = false
		end
		if t:DistanceFromCharacter(workspace._WorldOrigin.Locations["Trial of Flames"].Position) <= 3000 then
			if workspace.Map.DracoTrial.TrialDoor.DoorTouch:FindFirstChild("TouchInterest") then
				getgenv().DoneTrialDraco = true
				toTarget(workspace.Map.DracoTrial.TrialDoor.DoorTouch.CFrame)
				wait(2)
				return
			end
			if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
				local g = CheckModelTrialDraco()
				local R, m = GetRelicChuaDat(g)
				local l, S = GetRelicChuanbiDat(g)
				if l then
					local l = g["EndRelic" .. S:split("RelicModel")[2]]
					local S = l:FindFirstChildWhichIsA("ProximityPrompt", true)
					if t:DistanceFromCharacter(l.WorldPivot.Position) > 8 then
						toTarget(l.WorldPivot)
					else
						wait(2)
						fireproximityprompt(S)
						wait(2)
					end
				elseif R then
					local R = g["Relic" .. m:split("RelicModel")[2]]
					local g = R:FindFirstChildWhichIsA("ProximityPrompt", true)
					if t:DistanceFromCharacter(R.WorldPivot.Position) > 8 then
						toTarget(R.WorldPivot)
					else
						wait(2)
						fireproximityprompt(g)
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
						local g = tick()
						repeat
							wait()
						until tick() - g >= 5 or (game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland"))
						getgenv().dacoMagnet = false
						return
					end
					if not CheckCountItem("Scrap Metal", 10) then
						local g = { "Jungle Pirate", "Musketeer Pirate" }
						local R = DetectMob(g)
						if not R then
							if typeof(g) == "table" then
								if #N >= #g then
									N = {}
									return
								end
								local m = DetectPartSpawnMob(DetectNameTablePart(g))
								if m then
									table.insert(N, DetectNameTablePart(g))
									repeat
										wait()
										toTarget(m.CFrame * CFrame.new(0, 60, 0))
									until (m.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
										or (DetectMob(g))
										or not Settings["Fully Trial Draco"]
									wait(1)
								end
							end
						else
							repeat
								task.wait()
								sizepart(R)
								BringMob(R)
								UsedualFlock()
								ClickM1(R)
								if Settings["Select Weapon"] == "Blox Fruit" then
									toTarget(R.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									toTarget(R.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end
							until not IsMobAlive(R) or not Settings["Fully Trial Draco"]
						end
						return
					elseif not CheckCountItem("Blaze Ember", 15) then
						local g = workspace.NPCs:FindFirstChild("Dragon Hunter")
							or (game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Hunter"))
							or NPCManager.getNPCsByName("Dragon Hunter")[1]._modelState._instance
						if not getgenv().QuestHunterDragon then
							if t:DistanceFromCharacter(g.HumanoidRootPart.Position) > 8 then
								toTarget(g.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
							else
								local g = game:GetService("ReplicatedStorage")
									:WaitForChild("Modules")
									:WaitForChild("Net")
									:WaitForChild("RF/DragonHunter")
									:InvokeServer(unpack({ [1] = { Context = "Check" } }))
								if not g or g and not g.Text then
									getgenv().QuestHunterDragon = game:GetService("ReplicatedStorage")
										:WaitForChild("Modules")
										:WaitForChild("Net")
										:WaitForChild("RF/DragonHunter")
										:InvokeServer(unpack({ [1] = { Context = "RequestQuest" } })).Text
								else
									getgenv().QuestHunterDragon = g.Text
								end
							end
						else
							local g = DetectEmberTemplate()
							if g then
								Instance.new("IntValue", g).Name = "Ignored"
								repeat
									wait()
									toTarget(g.Part.CFrame)
								until not g or not g.Parent
								return
							end
							if string.find(getgenv().QuestHunterDragon, "Hydra Enforcers") then
								local R = DetectMob("Hydra Enforcer")
								if not R then
									local m = DetectPartSpawnMob("Hydra Enforcer", true)
									if m then
										Instance.new("IntValue", m).Name = "Ignored"
										repeat
											wait()
											toTarget(m.CFrame * CFrame.new(0, 60, 0))
										until (m.Position - t.Character.HumanoidRootPart.Position).Magnitude
												<= 100
											or (DetectMob("Hydra Enforcer"))
											or not Settings["Fully Trial Draco"]
											or g
										wait(1)
									else
										DeleteIgnoredMobSpawn()
									end
								else
									repeat
										task.wait()
										sizepart(R)
										BringMob(R)
										UsedualFlock()
										ClickM1(R)
										if Settings["Select Weapon"] == "Blox Fruit" then
											toTarget(R.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
										else
											toTarget(R.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
										end
									until not IsMobAlive(R) or not Settings["Fully Trial Draco"] or g
								end
							elseif string.find(getgenv().QuestHunterDragon, "Venomous Assailants") then
								local R = DetectMob("Venomous Assailant")
								if not R then
									local m = DetectPartSpawnMob("Venomous Assailant", true)
									if m then
										Instance.new("IntValue", m).Name = "Ignored"
										repeat
											wait()
											toTarget(m.CFrame * CFrame.new(0, 60, 0))
										until (m.Position - t.Character.HumanoidRootPart.Position).Magnitude
												<= 100
											or (DetectMob("Venomous Assailant"))
											or not Settings["Fully Trial Draco"]
											or g
										wait(1)
									else
										DeleteIgnoredMobSpawn()
									end
								else
									repeat
										task.wait()
										sizepart(R)
										BringMob(R)
										UsedualFlock()
										ClickM1(R)
										if Settings["Select Weapon"] == "Blox Fruit" then
											toTarget(R.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
										else
											toTarget(R.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
										end
									until not IsMobAlive(R) or not Settings["Fully Trial Draco"] or g
								end
							elseif string.find(getgenv().QuestHunterDragon, "trees") then
								local R, m = workspace.CurrentCamera, DetectTree()
								if m then
									Instance.new("IntValue", m).Name = "Ignored"
									local l = tick()
									repeat
										wait()
										local S = m.WorldPivot.Position
										if t:DistanceFromCharacter(S) < 50 then
											AutoAllSkill()
										end
										if m:FindFirstChild("Meshes/plant1_Icosphere", true) then
											toTarget(m.WorldPivot)
											getgenv().AimPos = m.WorldPivot
											G.Hit = CFrame.new(R.CFrame.Position, S)
											G.Target = m
										else
											local S, I =
												(m.WorldPivot * CFrame.new(5, -20, 0)).Position,
												(m.WorldPivot * CFrame.new(0, -20, 0)).Position
											toTarget(CFrame.new(S))
											getgenv().AimPos = CFrame.new(I)
											G.Hit = CFrame.new(R.CFrame.Position, I)
											G.Target = m
										end
									until not m
										or not m.Parent
										or not Settings["Fully Trial Draco"]
										or g
										or (m:GetAttribute("AlreadyDestroyedClient"))
										or tick() - l >= 15
								end
							end
						end
						return
					end
					if CheckCountItem("Scrap Metal", 10) and (CheckCountItem("Blaze Ember", 15)) then
						game:GetService("ReplicatedStorage").Modules.Net
							:FindFirstChild("RF/Craft")
							:InvokeServer(unpack({ [1] = "Craft", [2] = "Volcanic Magnet", [3] = 1, [4] = {} }))
						wait(2)
					end
				else
					getgenv().dacoMagnet = true
					if
						not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
						and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
						and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
					then
						local g = checkboat()
						if not g or g and t:DistanceFromCharacter(g.VehicleSeat.Position) >= 4000 then
							local R = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
							if (R.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
								if (R.Position - t.Character.HumanoidRootPart.Position).Magnitude > 1000 then
									if
										not t:GetAttribute("CurrentLocation")
										or t:GetAttribute("CurrentLocation") ~= "Tiki Outpost"
									then
										if
											game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value
												== "Tiki"
											or game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value
												== "Tiki2"
										then
											t.Character.Humanoid.Health = 0
											return
										end
									end
								end
								toTarget(R)
							else
								game:GetService("ReplicatedStorage").Remotes.CommF_
									:InvokeServer("BuyBoat", "PirateBrigade")
								wait(3)
							end
						elseif t.Character.Humanoid.Sit then
							task.spawn(function()
								NoclipBoat(g)
							end)
							local R = CFrame.new(-118834.515625, g.WorldPivot.Y, -78.9505844116211)
								* CFrame.new(0, 0, 99999999)
							manageTween(g.VehicleSeat, R, 350, "TweenBoat")
						else
							if getgenv().TweenBoat then
								getgenv().TweenBoat:Pause()
								getgenv().TweenBoat:Cancel()
							end
							toTarget(g.VehicleSeat.CFrame)
						end
					end
				end
			else
				if getgenv().turnoffnoclipBoatt then
					getgenv().turnoffnoclipBoatt = false
					local g = checkboat()
					if g then
						TurnOffNoclipBoat(g)
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
				if
					not t:GetAttribute("CurrentLocation")
					or t:GetAttribute("CurrentLocation") ~= "Prehistoric Island"
				then
					local g = DetectNpc("Fossil Expert")
					if g then
						toTarget(g.HumanoidRootPart.CFrame)
						return
					end
				end
				if workspace.Map.PrehistoricIsland:FindFirstChild("TrialRock", true).Transparency == 1 then
					getgenv().WaitingjoinTrial = true
					toTarget(workspace.Map.PrehistoricIsland.TrialTeleport.CFrame)
					return
				end
				if DetectLava() then
					local g, R, m = next, workspace.Map.PrehistoricIsland:GetDescendants()
					for l, l in g, R, m do
						if l.Name == "TouchInterest" and l.Parent.Name ~= "TrialTeleport" then
							l:Destroy()
						end
					end
				end
				if #workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren() > 0 then
					DeleteLava()
				end
				if
					not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
					and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
				then
					if
						workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")
						and (workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt"))
					then
						toTarget(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)
						if
							t:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.Position) < 8
						then
							fireproximityprompt(
								workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt,
								1
							)
							wait(3)
						end
						return
					elseif
						not workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")
						and not workspace.Map.PrehistoricIsland.Core:FindFirstChild("FossilExpertSpawn")
					then
						local g = DetectNpc("Fossil Expert")
						if g then
							toTarget(g.HumanoidRootPart.CFrame)
							return
						end
					end
				else
					if b then
						local g = workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull
						repeat
							task.wait()
							toTarget(g.Position, g.CFrame)
						until t:DistanceFromCharacter(g.Position) <= 200 or (DetectGolem()) or (DetectRockVolcano())
						b = false
						return
					end
					local g = DetectGolem()
					if g then
						repeat
							task.wait()
							toTarget(g.HumanoidRootPart.CFrame * CFrame.new(0, 20, 7))
							if
								Settings["Select Method Kill Golem"] == "Instant Kill [ Risk and can bug no die mob ]"
							then
								if t:DistanceFromCharacter(g.HumanoidRootPart.Position) < 50 then
									KillRaidEnemy()
								end
							else
								equiptool(NameWeapon(Settings["Select Weapon Kill Golem"] or "Melee"))
								getgenv().ClickM1Volcano(g)
							end
							if not getgenv().KillMobRaid and Settings["Kill Aura Only Raid And Volcano"] then
								getgenv().KillMobRaid = true
								local R = Settings["Time Delay Kill"] or 5
								g.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
								delay(R, function()
									getgenv().KillMobRaid = false
								end)
							end
						until not IsMobAlive(g)
							or not Settings["Fully Trial Draco"]
							or not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
							or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
								and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
					end
					g = DetectRockVolcano()
					if g then
						if Settings["Fix Volcano Safe"] then
							local R = DetectPositionVolcano()
							local m, m = CheckPosnearRock(R, t.Character.HumanoidRootPart)
							if t:DistanceFromCharacter((CheckPosnearRock(R, g.WorldPivot))) >= 400 then
								s = m + 1
								if m >= 7 then
									s = 1
								end
								local m = R[s]
								toTarget(CFrame.new(m))
							else
								local R = X[math.floor(g.WorldPivot.Position.Y)]
								repeat
									task.wait()
									if t:DistanceFromCharacter((g.WorldPivot * R).Position) > 8 then
										toTarget(g.WorldPivot * R)
									end
									if t:DistanceFromCharacter(g.WorldPivot.Position) < 100 then
										AutoUseSkillFixLava()
									end
									getgenv().AimPos = g.WorldPivot
									local m = workspace.CurrentCamera
									G.Hit = g.WorldPivot
									G.Target = g
								until not g
									or not g.Parent
									or not Settings["Fully Trial Draco"]
									or not g.VFXLayer.Specs.Enabled
									or (DetectGolem())
									or not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
									or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
										and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
								R = DetectGolem()
								if not R then
									b = true
								end
								wait(1)
							end
						else
							local R = X[math.floor(g.WorldPivot.Position.Y)]
							repeat
								task.wait()
								if t:DistanceFromCharacter((g.WorldPivot * R).Position) > 8 then
									toTarget(g.WorldPivot * R)
								end
								if t:DistanceFromCharacter(g.WorldPivot.Position) < 100 then
									AutoUseSkillFixLava()
								end
								getgenv().AimPos = g.WorldPivot
								local m = workspace.CurrentCamera
								G.Hit = g.WorldPivot
								G.Target = g
							until not g
								or not g.Parent
								or not Settings["Fully Trial Draco"]
								or not g.VFXLayer.Specs.Enabled
								or (DetectGolem())
								or not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
								or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
									and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
							R = DetectGolem()
							if not R then
								b = true
							end
						end
					end
				end
			end
		end
	elseif string.find(CheckAcientOneDracoStatus(), "Can Buy Gear") then
		BuyGearDracoV4()
	else
		local g = DetectMob(e)
		if g then
			repeat
				task.wait()
				sizepart(g)
				BringMob(g)
				UsedualFlock()
				ClickM1(g)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
			until not IsMobAlive(g) or not Settings["Fully Trial Draco"]
		elseif typeof(e) == "table" then
			if #N >= #e then
				N = {}
				return
			end
			local g = DetectPartSpawnMob(DetectNameTablePart(e))
			if g then
				table.insert(N, DetectNameTablePart(e))
				repeat
					wait()
					toTarget(g.CFrame * CFrame.new(0, 60, 0))
				until (g.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
					or (DetectMob(e))
					or not Settings["Fully Trial Draco"]
				wait(1)
			end
		else
			local g = DetectPartSpawnMob(e, true)
			if g then
				Instance.new("IntValue", g).Name = "Ignored"
				repeat
					wait()
					toTarget(g.CFrame * CFrame.new(0, 60, 0))
				until (g.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
					or (DetectMob(e))
					or not Settings["Fully Trial Draco"]
				wait(1)
			else
				DeleteIgnoredMobSpawn()
			end
		end
	end
end
RaceDracoSection.CreateToggle(
	{
		Title = "Fully Trial Draco",
		Desc = "Auto Craft and Auto Find and Auto Attack and Fix\10 Auto Trial and auto Train Race and Buy Gear and Choose Gear",
		Default = Settings["Fully Trial Draco"] or false,
	},
	function(g)
		if g then
			spawn(function()
				while Settings["Fully Trial Draco"] and (task.wait(0.1)) do
					local R, R = pcall(function()
						FullyDraco()
					end)
					if R then
						print(R)
					end
				end
			end)
		end
		SaveSettings("Fully Trial Draco", g)
	end
)
RaceDracoSection.CreateToggle(
	{
		Title = "Ignore Craft Volcanic Magnet [ Fully Draco ]",
		Desc = nil,
		Default = Settings["Ignore Craft Volcanic Magnet Draco"] or false,
	},
	function(g)
		SaveSettings("Ignore Craft Volcanic Magnet Draco", g)
	end
)
RaceDracoSection.CreateToggle(
	{ Title = "Auto Buy Gear Draco", Desc = nil, Default = Settings["Auto Buy Gear Draco"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Buy Gear Draco"] and (wait(0.3)) do
					pcall(function()
						BuyGearDracoV4()
					end)
				end
			end)
		end
		SaveSettings("Auto Buy Gear Draco", g)
	end
)
RaceDracoSection.CreateToggle(
	{ Title = "Auto Finish Train Draco Quest", Desc = nil, Default = Settings["Auto Finish Train Draco Quest"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Finish Train Draco Quest"] and (wait(0.1)) do
					pcall(function()
						if string.find(CheckAcientOneDracoStatus(), "Can Buy Gear") then
							BuyGearDracoV4()
						else
							local R = DetectMob(e)
							if R then
								repeat
									task.wait()
									sizepart(R)
									BringMob(R)
									UsedualFlock()
									ClickM1(R)
									if Settings["Select Weapon"] == "Blox Fruit" then
										toTarget(R.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										toTarget(R.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end
								until not IsMobAlive(R) or not Settings["Auto Finish Train Draco Quest"]
							elseif typeof(e) == "table" then
								if #N >= #e then
									N = {}
									return
								end
								local R = DetectPartSpawnMob(DetectNameTablePart(e))
								if R then
									table.insert(N, DetectNameTablePart(e))
									repeat
										wait()
										toTarget(R.CFrame * CFrame.new(0, 60, 0))
									until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
										or (DetectMob(e))
										or not Settings["Auto Finish Train Draco Quest"]
									wait(1)
								end
							else
								local R = DetectPartSpawnMob(e, true)
								if R then
									Instance.new("IntValue", R).Name = "Ignored"
									repeat
										wait()
										toTarget(R.CFrame * CFrame.new(0, 60, 0))
									until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
										or (DetectMob(e))
										or not Settings["Auto Finish Train Draco Quest"]
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
		SaveSettings("Auto Finish Train Draco Quest", g)
	end
)
RaceNormalSection = RaceMain.CreateSection("Race Normal")
function AutoMinkV2()
	local g = GetNearestChest()
	if g then
		local R
		repeat
			task.wait()
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - g.Position).Magnitude <= 5 then
				if not R then
					R = (tick())
				elseif tick() - R >= 5 then
					Instance.new("IntValue", g).Name = "Ignored"
					wait(0.5)
				end
				game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
				wait()
				game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
				TweenManager.CancelCurrent()
			end
			toTarget(g.CFrame, true)
		until not g
			or not g.Parent
			or not Settings["Auto Upgrade Race V2-V3"]
			or (g:GetAttribute("IsDisabled"))
			or (g:FindFirstChild("Ignored"))
			or not g:FindFirstChild("TouchInterest")
	else
		local g = PathFindChest()
		if g then
			toTarget(g.Part.CFrame)
			if (g.Part.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100 or (GetNearestChest()) then
				Instance.new("IntValue", g).Name = "Ignored"
			end
		else
			for g, g in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
				if g:FindFirstChild("Ignored") then
					g:FindFirstChild("Ignored"):Destroy()
				end
			end
		end
	end
end
function DetectSeabeast()
	local g, R, m = next, game:GetService("Workspace").SeaBeasts:GetChildren()
	for l, l in g, R, m do
		if l.Name == "SeaBeast1" then
			local g, R = l.HealthBBG.Frame.TextLabel.Text:gsub("/%d+,%d+", ""), l.HealthBBG.Frame.TextLabel.Text
			if
				tonumber(
					(((function() if string.find(g, ",") then return (R:gsub("%d+,%d+/", "")) else return (R:gsub("%d+/", "")) end end)()):gsub(",", ""))
				) >= 90000
			then
				return l
			end
		end
	end
	return false
end
function AutoFishV2()
	local g, R = DetectSeabeast(), checkboat()
	if not g then
		if not R then
			local m = CFrame.new(-11.94833755493164, 10.293913841247559, 2957.010498046875)
			if (m.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
				toTarget(m)
			else
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
			end
		else
			local m = CFrame.new(753.0653686523438, R.WorldPivot.Y, 6994.5146484375)
			if (R.VehicleSeat.Position - m.Position).Magnitude > 50 then
				R.VehicleSeat.CFrame = m
			elseif not t.Character.Humanoid.Sit then
				toTarget(R.VehicleSeat.CFrame)
			end
		end
	else
		repeat
			task.wait()
			TeleportSeaEvents(g)
			local R = g:FindFirstChild("HumanoidRootPart")
			getgenv().AimPos = CFrame.new(R.Position.X, 40, R.Position.Z)
			if t:DistanceFromCharacter(R.Position) < 400 then
				AutoAllSkill()
			end
		until not g or not g.Parent or g.Health.Value <= 0 or not Settings["Auto Upgrade Race V2-V3"]
	end
end
function CheckRace()
	local g, R =
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1"),
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
	if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
		return " V4"
	end
	if g == -2 then
		return " V3"
	end
	if R == -2 then
		return " V2"
	end
	return " V1"
end
getgenv().Chests = {}
getgenv().BlBossHuman = {}
local g, R = {}, {}
function DetectPlayerAngel()
	for m, m in pairs(game:GetService("Players"):GetChildren()) do
		if
			m.Name ~= t.Name
			and (game:GetService("Workspace").Characters:FindFirstChild(m.Name))
			and m.Data.Race.Value == "Skypiea"
			and not table.find(g, m.Name)
			and (m.Character:FindFirstChild("Humanoid"))
			and m.Character.Humanoid.Health > 0
		then
			return m
		end
	end
end
function DetectPlayerGhoul()
	for m, m in pairs(game:GetService("Players"):GetChildren()) do
		if
			m.Name ~= t.Name
			and (game:GetService("Workspace").Characters:FindFirstChild(m.Name))
			and not table.find(R, m.Name)
			and (m.Character:FindFirstChild("Humanoid"))
			and m.Character.Humanoid.Health > 0
		then
			return m
		end
	end
end
function CheckSafezone(m)
	for l, l in pairs(game:GetService("Workspace")._WorldOrigin.SafeZones:GetChildren()) do
		if l:IsA("Part") then
			if
				(l.Position - m.HumanoidRootPart.Position).magnitude <= 400
				and m.Humanoid.Health / m.Humanoid.MaxHealth >= 0.9
			then
				return true
			end
		end
	end
	return false
end
function CheckPlayercantAttack(m)
	for l, S in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetDescendants()) do
		if S:IsA("TextLabel") then
			if string.find(S.Text, "attack") and not S:FindFirstChild(m.Name) then
				l = Instance.new("TextBox")
				l.Parent = S.Parent
				l.Name = m.Name
				S:Destroy()
				return true
			end
		end
	end
end
function UpgradeRaceV2AndV3()
	local m = CheckRace()
	if m == " V3" then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Done V3", ShowTime = 5 })
		wait(5)
		return
	end
	if game.PlaceId ~= getgenv().CheckPlaceId2 then
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "TravelDressrosa" }))
		return
	end
	if m == " V1" then
		if t.Data.Beli.Value < 500000 then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Beli >= 500k", ShowTime = 5 })
			wait(5)
			return
		end
		if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "2")
		elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
			if not DetectItemPlr("Flower 1") then
				toTarget(game:GetService("Workspace").Flower1.CFrame)
			elseif not DetectItemPlr("Flower 2") then
				toTarget(game:GetService("Workspace").Flower2.CFrame)
			elseif not DetectItemPlr("Flower 3") then
				local l = DetectMob("Swan Pirate")
				if not l then
					local S = "Swan Pirate"
					if typeof(S) == "table" then
						if #N >= 11 then
							N = {}
							return
						end
						local I = DetectPartSpawnMob(DetectNameTablePart(S))
						if I then
							table.insert(N, DetectNameTablePart(S))
							repeat
								wait()
								toTarget(I.CFrame * CFrame.new(0, 60, 0))
							until (I.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
								or (DetectMob(S))
								or not Settings["Auto Upgrade Race V2-V3"]
							wait(1)
						end
					else
						local I = DetectPartSpawnMob(S, true)
						if I then
							Instance.new("IntValue", I).Name = "Ignored"
							repeat
								wait()
								toTarget(I.CFrame * CFrame.new(0, 60, 0))
							until (I.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
								or (DetectMob(S))
								or not Settings["Auto Upgrade Race V2-V3"]
							wait(1)
						else
							DeleteIgnoredMobSpawn()
						end
					end
				else
					repeat
						task.wait()
						sizepart(l)
						BringMob(l)
						UsedualFlock()
						ClickM1(l)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(l.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(l.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
					until not IsMobAlive(l) or not Settings["Auto Upgrade Race V2-V3"]
				end
			end
		elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
			if
				(CFrame.new(-2777.6001, 72.9661407, -3571.42285).Position - t.Character.HumanoidRootPart.Position).Magnitude
				< 8
			then
				toTarget(CFrame.new(-2777.6001, 72.9661407, -3571.42285))
			else
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3")
			end
		else
			AutoQuestBarito()
		end
	else
		local l = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
		if l == 0 then
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
			return
		elseif l == 2 then
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3")
			return
		elseif l == -1 then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Beli >= 2m", ShowTime = 5 })
			wait(5)
			return
		end
		l = game:GetService("Players").LocalPlayer.Data.Race.Value .. m
		if l == "Human V2" then
			local m = not table.find(BlBossHuman, "Jeremy") and (CheckNameBoss("Jeremy"))
				or not table.find(BlBossHuman, "Orbitus") and (CheckNameBoss("Orbitus"))
				or not table.find(BlBossHuman, "Diamond") and (CheckNameBoss("Diamond"))
			if m then
				local S = CheckNameBoss(m.Name)
				if S then
					repeat
						task.wait()
						sizepart(S)
						UsedualFlock()
						ClickM1(S)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(S.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(S.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
					until not IsMobAlive(S)
					if not table.find(BlBossHuman, m.Name) then
						table.insert(BlBossHuman, m.Name)
					end
				end
			else
				A.CreateNoti({ Title = "Noijo Hub", Desc = "Waiting Boss Spawn", ShowTime = 5 })
				wait(5)
			end
		elseif l == "Mink V2" then
			AutoMinkV2()
		elseif l == "Cyborg V2" then
			if not CheckFruitplr() then
				if TakeFruitInventory(true) then
					game:GetService("ReplicatedStorage").Remotes.CommF_
						:InvokeServer("LoadFruit", TakeFruitInventory(true))
				end
			end
		elseif l == "Fishman V2" then
			AutoFishV2()
		elseif l == "Skypiea V2" then
			local m = DetectPlayerAngel()
			if m then
				table.insert(g, m.Name)
				local g = tick()
				repeat
					wait()
					spawn(function()
						if game:GetService("Players").LocalPlayer.PlayerGui.Main.BottomHUDList.PvpDisabled.Visible then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
						end
					end)
					spawn(function()
						getgenv().AimPos = CFrame.new(
							m.Character.HumanoidRootPart.CFrame.p,
							m.Character.HumanoidRootPart.Position + m.Character.HumanoidRootPart.Velocity / 1.2
						)
						if t:DistanceFromCharacter(m.Character.HumanoidRootPart.Position) < 50 then
							t.Character.HumanoidRootPart.CFrame = m.Character.HumanoidRootPart.CFrame
								* CFrame.new(0, 0, 3)
						else
							toTarget(m.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
						end
					end)
					spawn(function()
						if t:DistanceFromCharacter(m.Character.HumanoidRootPart.Position) < 50 then
							AutoAllSkill(true)
						end
					end)
				until tick() - g >= 70
					or not m.Character
					or not m.Character.Parent
					or m.Character.Humanoid.Health == 0
					or (CheckSafezone(m.Character))
					or (CheckPlayercantAttack(m.Character))
					or not Settings["Auto Upgrade Race V2-V3"]
			else
				HopServer()
				wait(5)
			end
		elseif l == "Ghoul V2" then
			local g = DetectPlayerGhoul()
			if g then
				table.insert(R, g.Name)
				local R = tick()
				repeat
					wait()
					spawn(function()
						if game:GetService("Players").LocalPlayer.PlayerGui.Main.BottomHUDList.PvpDisabled.Visible then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
						end
					end)
					spawn(function()
						getgenv().AimPos = CFrame.new(
							g.Character.HumanoidRootPart.CFrame.p,
							g.Character.HumanoidRootPart.Position + g.Character.HumanoidRootPart.Velocity / 1.2
						)
						if t:DistanceFromCharacter(g.Character.HumanoidRootPart.Position) < 50 then
							t.Character.HumanoidRootPart.CFrame = g.Character.HumanoidRootPart.CFrame
								* CFrame.new(0, 0, 3)
						else
							toTarget(g.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
						end
					end)
					spawn(function()
						if t:DistanceFromCharacter(g.Character.HumanoidRootPart.Position) < 50 then
							AutoAllSkill(true)
						end
					end)
				until tick() - R >= 70
					or not g.Character
					or not g.Character.Parent
					or g.Character.Humanoid.Health == 0
					or (CheckSafezone(g.Character))
					or (CheckPlayercantAttack(g.Character))
					or not Settings["Auto Upgrade Race V2-V3"]
			else
				HopServer()
				wait(5)
			end
		end
	end
end
RaceNormalSection.CreateToggle(
	{ Title = "Auto Upgrade Race V2-V3", Desc = nil, Default = Settings["Auto Upgrade Race V2-V3"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Upgrade Race V2-V3"] and (wait(0.1)) do
					local R, R = pcall(function()
						UpgradeRaceV2AndV3()
					end)
					if R then
						print(R)
					end
				end
			end)
		end
		SaveSettings("Auto Upgrade Race V2-V3", g)
	end
)
function BuyChipLaw()
	v354 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
	if v354 == 1 then
		return true
	end
	if v354 == 0 then
		return false
	end
	if v354 == 2 then
		return true
	end
end
local g, R, m = 0, false, false
function DetectkeyCyborg(l)
	local S, I, _ = next, game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren()
	for V, V in S, I, _ do
		if V.Name == "NotificationTemplate" and V.TranslateMe.Text == l then
			return true
		end
	end
end
ToggleAutoGetFullyCyborg = RaceNormalSection.CreateToggle(
	{ Title = "Auto Get Fully Cyborg", Desc = nil, Default = Settings["Auto Get Fully Cyborg"] or false },
	function(l)
		SaveSettings("Auto Get Fully Cyborg", l)
		if l and not Settings["Auto Get Cyborg"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Turn On Auto Get Cyborg plz", ShowTime = 5 })
		end
	end
)
RaceNormalSection.CreateToggle(
	{
		Title = "Auto Get Cyborg Hop Collect Chest",
		Desc = nil,
		Default = Settings["Auto Get Cyborg Hop Collect Chest"] or false,
	},
	function(l)
		SaveSettings("Auto Get Cyborg Hop Collect Chest", l)
	end
)
function GetCyborg()
	if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Check") == 2 then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Plz Turn Off", ShowTime = 5 })
		wait(5)
		return
	end
	if game.PlaceId ~= getgenv().CheckPlaceId2 then
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "TravelDressrosa" }))
		return
	end
	if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Check") then
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
		return
	end
	if not m and not DetectItemPlr("Core Brain") then
		repeat
			wait(1)
			fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
		until DetectkeyCyborg("{color1_Green}Please supply a {item1} to continue.{color1_/}")
			or (DetectkeyCyborg("{color1_Red}Microchip not found.{color1_/}"))
		local l = DetectkeyCyborg
		if l("{color1_Red}Microchip not found.{color1_/}") then
			R = false
		else
			local l = DetectkeyCyborg
			if l("{color1_Green}Please supply a {item1} to continue.{color1_/}") then
				R = true
			end
		end
		m = true
	end
	if Settings["Auto Get Fully Cyborg"] and not CheckNameBoss("Order") and not R then
		if not DetectItemPlr("Fist of Darkness") then
			if g >= 20 and Settings["Auto Get Cyborg Hop Collect Chest"] then
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
			local m = GetNearestChest()
			if m then
				g = g + (1)
				local g
				repeat
					task.wait()
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - m.Position).Magnitude <= 5 then
						if not g then
							g = (tick())
						elseif tick() - g >= 5 then
							Instance.new("IntValue", m).Name = "Ignored"
							wait(0.5)
						end
						game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
						wait()
						game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
						TweenManager.CancelCurrent()
					end
					toTarget(m.CFrame, true)
				until not m
					or not m.Parent
					or not Settings["Auto Get Cyborg"]
					or (m:GetAttribute("IsDisabled"))
					or (m:FindFirstChild("Ignored"))
					or not m:FindFirstChild("TouchInterest")
			else
				local g = PathFindChest()
				if g then
					toTarget(g.Part.CFrame)
					if
						(g.Part.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (GetNearestChest())
					then
						Instance.new("IntValue", g).Name = "Ignored"
					end
				else
					print("delete")
					for g, g in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
						if g:FindFirstChild("Ignored") then
							g:FindFirstChild("Ignored"):Destroy()
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
			R = true
		end
		return
	end
	if R then
		if DetectItemPlr("Core Brain") then
			fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
			return
		end
		local g = CheckNameBoss("Order")
		if g then
			repeat
				task.wait()
				sizepart(g)
				UsedualFlock()
				ClickM1(g)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
			until not IsMobAlive(g) or not Settings["Auto Get Cyborg"]
		elseif not DetectItemPlr("Microchip") and game.Players.LocalPlayer.Data.Fragments.Value >= 1000 then
			BuyChipLaw()
			wait(2)
		elseif DetectItemPlr("Microchip") then
			fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
		end
	end
end
RaceNormalSection.CreateToggle(
	{ Title = "Auto Get Cyborg", Desc = nil, Default = Settings["Auto Get Cyborg"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Get Cyborg"] and (wait(0.1)) do
					local R, R = pcall(function()
						GetCyborg()
					end)
					if R then
						print(R)
					end
				end
			end)
		end
		SaveSettings("Auto Get Cyborg", g)
	end
)
function GetRaceGhoul()
	if game.PlaceId ~= getgenv().CheckPlaceId2 then
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "TravelDressrosa" }))
		return
	end
	if
		game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul"
		or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "BuyCheck", 4, true) == 2
		or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4, true) == 1
	then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Plz Turn Off", ShowTime = 5 })
		wait(5)
		return
	end
	if not CheckCountItem("Ectoplasm", 100) then
		local g = { "Ship Deckhand", "Ship Steward", "Ship Officer", "Ship Engineer" }
		local R = DetectMob(g)
		if R then
			repeat
				task.wait()
				sizepart(R)
				BringMob(R)
				UsedualFlock()
				ClickM1(R)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(R.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(R.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
			until not IsMobAlive(R) or not Settings["Auto Get Ghoul"]
		elseif typeof(g) == "table" then
			if #N >= #g then
				N = {}
				return
			end
			local R = DetectPartSpawnMob(DetectNameTablePart(g))
			if R then
				table.insert(N, DetectNameTablePart(g))
				repeat
					wait()
					toTarget(R.CFrame * CFrame.new(0, 60, 0))
				until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
					or (DetectMob(g))
					or not Settings["Auto Get Ghoul"]
				wait(1)
			end
		else
			local R = DetectPartSpawnMob(g, true)
			if R then
				Instance.new("IntValue", R).Name = "Ignored"
				repeat
					wait()
					toTarget(R.CFrame * CFrame.new(0, 60, 0))
				until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
					or (DetectMob(g))
					or not Settings["Auto Get Ghoul"]
				wait(1)
			else
				DeleteIgnoredMobSpawn()
			end
		end
		return
	end
	if DetectItemPlr("Hellfire Torch") then
		if
			(CFrame.new(
				918.615234,
				122.202454,
				33454.3789,
				-0.999998808,
				0,
				0.00172644004,
				0,
				1,
				0,
				-0.00172644004,
				0,
				-0.999998808
			).Position - t.Character.HumanoidRootPart.Position).Magnitude <= 8
		then
			game:GetService("ReplicatedStorage").Remotes.CommF_
				:InvokeServer(unpack({ [1] = "Ectoplasm", [2] = "BuyCheck", [3] = 4 }))
			v352 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 4)
		else
			toTarget(
				CFrame.new(
					918.615234,
					122.202454,
					33454.3789,
					-0.999998808,
					0,
					0.00172644004,
					0,
					1,
					0,
					-0.00172644004,
					0,
					-0.999998808
				)
			)
		end
	else
		local g = CheckNameBoss("Cursed Captain")
		if g then
			repeat
				task.wait()
				sizepart(g)
				UsedualFlock()
				ClickM1(g)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
			until not IsMobAlive(g) or not Settings["Auto Get Ghoul"]
			wait(5)
		else
			if Settings["Hop Server Get Ghoul"] then
				SpecialHop("Cursed Captain")
			end
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Wating Boss Spawn", ShowTime = 5 })
			wait(5)
		end
	end
end
RaceNormalSection.CreateToggle(
	{ Title = "Hop Server Find Boss Cursed Captain", Desc = nil, Default = Settings["Hop Server Get Ghoul"] or false },
	function(g)
		SaveSettings("Hop Server Get Ghoul", g)
	end
)
RaceNormalSection.CreateToggle(
	{ Title = "Auto Get Ghoul", Desc = nil, Default = Settings["Auto Get Ghoul"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Get Ghoul"] and (wait(0.1)) do
					local R, R = pcall(function()
						GetRaceGhoul()
					end)
					if R then
						print(R)
					end
				end
			end)
		end
		SaveSettings("Auto Get Ghoul", g)
	end
)
RaceV4Section = RaceMain.CreateSection("Race V4")
RaceV4Section.CreateToggle({ Title = "No Frog", Desc = nil, Default = Settings["No Frog"] or false }, function(g)
	if g then
		local R = game.Lighting
		R.FogEnd = 100000
		for m, m in pairs(R:GetDescendants()) do
			if m:IsA("Atmosphere") then
				m:Destroy()
			end
		end
	end
	SaveSettings("No Frog", g)
end)
RaceV4Section.CreateToggle(
	{ Title = "Teleport Acient Clock", Desc = nil, Default = Settings["Teleport Acient Clock"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Teleport Acient Clock"] and (wait()) do
					local R = game:GetService("Workspace").Map["Temple of Time"]:FindFirstChild("Prompt")
					if R then
						toTarget(R.CFrame)
					end
				end
			end)
		end
		SaveSettings("Teleport Acient Clock", g)
	end
)
function BuyGearV4()
	if string.find(CheckAcientOneStatus(), "Can Buy Gear") then
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
		ResetRaceStatus()
	end
end
local g, R =
	CFrame.new(
		28576.4688,
		14935.9512,
		75.469101,
		-1,
		-4.22219593E-8,
		1.13133396E-8,
		0,
		-0.258819044,
		-0.965925813,
		4.37113883E-8,
		-0.965925813,
		0.258819044
	),
	0.2
function getBlueGear()
	if game.workspace.Map:FindFirstChild("MysticIsland") then
		for m, m in pairs(game.workspace.Map.MysticIsland:GetChildren()) do
			if m:IsA("MeshPart") and m.MeshId == "rbxassetid://10153114969" then
				return m
			end
		end
	end
end
function getHighestPoint()
	if not game.workspace.Map:FindFirstChild("MysticIsland") then
		return nil
	end
	for m, m in pairs(game:GetService("Workspace").Map.MysticIsland:GetDescendants()) do
		if m:IsA("MeshPart") then
			if m.MeshId == "rbxassetid://6745037796" then
				return m
			end
		end
	end
end
local m = { "Last Resort", "Agility", "Water Body", "Heavenly Blood", "Energy Core", "Heightened Senses" }
function CheckAbility()
	local l, S, I = next, game.Players.LocalPlayer.Backpack:GetChildren()
	for _, _ in l, S, I do
		if table.find(m, _.Name) then
			return true
		end
	end
	l, S, I = next, game.Players.LocalPlayer.Character:GetChildren()
	for _, _ in l, S, I do
		if table.find(m, _.Name) then
			return true
		end
	end
end
function CollectBlueGear()
	if not getHighestPoint() then
		local l = DetectNpc("Advanced Fruit Dealer")
		if l then
			toTarget(l.HumanoidRootPart.CFrame)
			return
		end
	end
	local l = getBlueGear()
	if l and not l.CanCollide and l.Transparency ~= 1 then
		if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
			game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
		end
		toTarget(getBlueGear().CFrame)
	elseif l and l.Transparency == 1 then
		if
			getHighestPoint()
			and (
					getHighestPoint().CFrame * CFrame.new(0, 211.88, 0).Position - t.Character.HumanoidRootPart.Position
				).Magnitude
				> 10
		then
			toTarget(getHighestPoint().CFrame * CFrame.new(0, 211.88, 0))
		else
			game.Players.LocalPlayer.CameraMode = "LockFirstPerson"
			game.Players.LocalPlayer.CameraMode = "Classic"
			local l = tick()
			repeat
				wait()
				game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(
					game:GetService("Workspace").CurrentCamera.CFrame.Position,
					game:GetService("Lighting"):GetMoonDirection()
						+ game:GetService("Workspace").CurrentCamera.CFrame.Position
				)
			until tick() - l >= 3
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "T", false, game)
			task.wait(0.5)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "T", false, game)
			if
				not CheckAbility() and not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility")
			then
				l = game:GetService("ReplicatedStorage").FX.Agility:Clone()
				l.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
				l.Enabled = false
			end
			task.wait(1.5)
		end
	end
end
function PullLeverV4()
	if not CheckItemInventory("Valkyrie Helm") or not CheckItemInventory("Mirror Fractal") then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Not Valkyrie Helm or not Mirror Fractal", ShowTime = 5 })
		wait(5)
		return
	end
	if
		not game:GetService("ReplicatedStorage")
			:WaitForChild("Remotes")
			:WaitForChild("CommF_")
			:InvokeServer("CheckTempleDoor")
	then
		local l = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Check")
		if l == 1 then
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Begin")
			return
		elseif l == 2 then
			toTarget(CFrame.new(3032.780029296875, 2280.85107421875, -7325.47802734375))
			if
				(
					CFrame.new(3032.780029296875, 2280.85107421875, -7325.47802734375).Position
					- t.Character.HumanoidRootPart.Position
				).Magnitude < 8
			then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaceV4Progress", "Teleport")
			end
			return
		elseif l == 3 then
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Continue")
			return
		end
		if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") and CheckClockTime() == "Night" then
			CollectBlueGear()
		elseif game:GetService("Workspace").Map:FindFirstChild("MysticIsland") and CheckClockTime() ~= "Night" then
			if not getHighestPoint() then
				l = DetectNpc("Advanced Fruit Dealer")
				if l then
					toTarget(l.HumanoidRootPart.CFrame)
					return
				end
			end
			if
				getHighestPoint()
				and (
						getHighestPoint().CFrame * CFrame.new(0, 211.88, 0).Position
						- t.Character.HumanoidRootPart.Position
					).Magnitude
					> 10
			then
				toTarget(getHighestPoint().CFrame * CFrame.new(0, 211.88, 0))
			end
		elseif
			not game:GetService("Workspace").Map:FindFirstChild("MysticIsland")
			and Settings["Hop Server [Trial Or Pull Lever]"]
		then
			SpecialHop("Mirage")
		end
	else
		local l = GetTempleOfTime()
		if not l then
			toTarget(CFrame.new(28282.5703125, 14896.8505859375, 105.1042709350586))
			return
		end
		if l.Lever.Lever.CFrame.Z > g.Z + R or l.Lever.Lever.CFrame.Z < g.Z - R then
			if (t.Character.HumanoidRootPart.Position - l.Lever.Part.Position).Magnitude > 10 then
				toTarget(l.Lever.Part.CFrame)
			else
				fireproximityprompt(l.Lever.Prompt.ProximityPrompt, 1)
			end
		else
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Done Pull Lever", ShowTime = 5 })
			wait(5)
		end
	end
end
RaceV4Section.CreateToggle(
	{ Title = "Auto Buy Gear", Desc = nil, Default = Settings["Auto Buy Gear"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Buy Gear"] and (wait(0.2)) do
					pcall(function()
						BuyGearV4()
					end)
				end
			end)
		end
		SaveSettings("Auto Buy Gear", g)
	end
)
RaceV4Section.CreateDropdown(
	{
		Title = "Select Gear V4",
		List = { "Alpha", "Omega" },
		Search = false,
		Selected = false,
		Default = Settings["Select Gear V4"] or "Omega",
	},
	function(g)
		SaveSettings("Select Gear V4", g)
	end
)
getgenv().ToggleAutoChooseGears = RaceV4Section.CreateToggle(
	{ Title = "Auto Choose Gears", Desc = nil, Default = Settings["Auto Choose Gears"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Choose Gears"] and (wait(0.3)) do
					local R, R = pcall(function()
						ChooseGearV4()
					end)
					if R then
						print(R)
					end
				end
			end)
		end
		SaveSettings("Auto Choose Gears", g)
	end
)
RaceV4Section.CreateToggle(
	{ Title = "Auto Finish Train Quest", Desc = nil, Default = Settings["Auto Finish Train Quest"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Finish Train Quest"] and (task.wait()) do
					local R, R = pcall(function()
						if Settings["Stack Train With Trial Race"] and not CheckGoTrain() then
							return
						end
						TurnOnV4()
						BuyGearV4()
						local l = DetectMob(e)
						if l then
							repeat
								task.wait()
								sizepart(l)
								BringMob(l)
								UsedualFlock()
								ClickM1(l)
								if Settings["Select Weapon"] == "Blox Fruit" then
									toTarget(l.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									toTarget(l.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end
							until not IsMobAlive(l) or not Settings["Auto Finish Train Quest"] or not CheckGoTrain()
						elseif typeof(e) == "table" then
							if #N >= #e then
								N = {}
								return
							end
							local l = DetectPartSpawnMob(DetectNameTablePart(e))
							if l then
								table.insert(N, DetectNameTablePart(e))
								repeat
									wait()
									toTarget(l.CFrame * CFrame.new(0, 60, 0))
								until (l.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
									or (DetectMob(e))
									or not Settings["Auto Finish Train Quest"]
									or not CheckGoTrain()
								wait(1)
							end
						else
							local l = DetectPartSpawnMob(e, true)
							if l then
								Instance.new("IntValue", l).Name = "Ignored"
								repeat
									wait()
									toTarget(l.CFrame * CFrame.new(0, 60, 0))
								until (l.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
									or (DetectMob(e))
									or not Settings["Auto Finish Train Quest"]
									or not CheckGoTrain()
								wait(1)
							else
								DeleteIgnoredMobSpawn()
							end
						end
					end)
					if R then
						print(R)
					end
				end
			end)
		end
		SaveSettings("Auto Finish Train Quest", g)
	end
)
RaceV4Section.CreateToggle(
	{ Title = "Stack Train With Trial Race", Desc = nil, Default = Settings["Stack Train With Trial Race"] or false },
	function(g)
		SaveSettings("Stack Train With Trial Race", g)
	end
)
getgenv().TurnOffHOPSVPullAndTrial = RaceV4Section.CreateToggle(
	{
		Title = "Hop Server [Trial Or Pull Lever]",
		Desc = nil,
		Default = Settings["Hop Server [Trial Or Pull Lever]"] or false,
	},
	function(g)
		SaveSettings("Hop Server [Trial Or Pull Lever]", g)
	end
)
RaceV4Section.CreateToggle(
	{ Title = "Auto Pull Lever", Desc = nil, Default = Settings["Auto Pull Lever"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Pull Lever"] and (wait(0.1)) do
					pcall(function()
						PullLeverV4()
					end)
				end
			end)
		end
		SaveSettings("Auto Pull Lever", g)
	end
)
function DetectNameMulti(g)
	local R = {}
	if Settings["Select Players Multi"] and not g then
		for g, l in next, Settings["Select Players Multi"], nil do
			if l then
				R[g] = true
			end
		end
	end
	for g, g in pairs(game:GetService("Players"):GetChildren()) do
		if g.Name ~= t.Name and not table.find(R, g.Name) then
			R[g.Name] = false
		end
	end
	return R
end
DropdownSelectPlayerMulti = RaceV4Section.CreateDropdown(
	{
		Title = "Select Players Multi",
		List = PrepareMultiSelectList(DetectNameMulti(), Settings["Select Players Multi"]),
		Search = true,
		Selected = true,
		Default = Settings["Select Players Multi"] or nil,
	},
	function(g, R)
		SaveSettings("Select Players Multi", g, R)
	end
)
RaceV4Section.CreateButton({ Title = "Refresh Player" }, function()
	DropdownSelectPlayerMulti:GetNewList(DetectNameMulti(true))
end)
RaceV4Section.CreateToggle(
	{ Title = "Multi Trial", Desc = nil, Default = Settings["Multi Trial"] or false },
	function(g)
		SaveSettings("Multi Trial", g)
	end
)
RaceV4Section.CreateToggle(
	{ Title = "Auto Reset Character", Desc = nil, Default = Settings["Auto Reset Character"] or false },
	function(g)
		SaveSettings("Auto Reset Character", g)
	end
)
ToggleAutoTrial = RaceV4Section.CreateToggle(
	{ Title = "Auto Trial", Desc = nil, Default = Settings["Auto Trial"] or false },
	function(g)
		SaveSettings("Auto Trial", g)
	end
)
RaceV4Section.CreateToggle(
	{
		Title = "Auto Turn On V3 Near Door",
		Desc = "will auto turn on race \10if have players near door",
		Default = Settings["Auto Turn On V3 Near Door"] or false,
	},
	function(g)
		SaveSettings("Auto Turn On V3 Near Door", g)
	end
)
KillTrialSection = RaceMain.CreateSection("Kill Trial")
KillTrialSection.CreateDropdown(
	{
		Title = "Select Weapon Attack Trial",
		List = { "Melee", "Sword", "Blox Fruit" },
		Search = true,
		Selected = false,
		Default = Settings["Select Weapon Attack Trial"] or nil,
	},
	function(g)
		SaveSettings("Select Weapon Attack Trial", g)
	end
)
KillTrialSection.CreateToggle(
	{
		Title = "Kill players When complete Trial",
		Desc = "Turn on before Start Attack and Turn on Auto Trial",
		Default = Settings["Kill players When complete Trial"] or false,
	},
	function(g)
		SaveSettings("Kill players When complete Trial", g)
	end
)
KillTrialSection.CreateToggle(
	{ Title = "Use Skill when Kill Player", Desc = nil, Default = Settings["Use Skill when Kill Player"] or false },
	function(g)
		SaveSettings("Use Skill when Kill Player", g)
	end
)
KillTrialSection.CreateToggle(
	{
		Title = "Just Use Skill when Player Active Ken",
		Desc = nil,
		Default = Settings["Just Use Skill when Player Active Ken"] or false,
	},
	function(g)
		SaveSettings("Just Use Skill when Player Active Ken", g)
	end
)
function DetectNameAbility(g)
	local R, l, S = next, g:GetChildren()
	for g, g in R, l, S do
		if table.find(m, g.Name) then
			return true
		end
	end
end
function GetOtherPlayerRaces()
	local g = {}
	for R, R in pairs(game:GetService("Players"):GetChildren()) do
		if R.Name ~= t.Name then
			g[R.Name] = R.Data.Race.Value
		end
	end
	return g
end
function CheckMultiPlayerNearDoor()
	local g, R, m = next, game.Workspace.Characters:GetChildren()
	local l = 0
	for S, I in g, R, m do
		S = GetOtherPlayerRaces()[I.Name]
		l = (function() if S
				and (DetectNameAbility(I.HumanoidRootPart))
				and (
						I.HumanoidRootPart.Position
						- game:GetService("Workspace").Map["Temple of Time"][S .. "Corridor"].Door.Door.RightDoor.Union.Position
					).Magnitude
					< 100 then return l + 1 else return l end end)()
	end
	if l >= 2 then
		return true
	end
end
function CheckMultiAccount()
	local g = {}
	for R, R in pairs(game:GetService("Players"):GetChildren()) do
		if Settings["Select Players Multi"] and Settings["Select Players Multi"][R.Name] then
			g[R.Name] = R.Data.Race.Value
		end
	end
	return g
end
function CheckMultiTeleDoor()
	local g, R, m = next, game.Workspace.Characters:GetChildren()
	local l = 0
	for S, I in g, R, m do
		S = CheckMultiAccount()[I.Name]
		l = (function() if S
				and (
						I.HumanoidRootPart.Position
						- game:GetService("Workspace").Map["Temple of Time"][S .. "Corridor"].Door.Door.RightDoor.Union.Position
					).Magnitude
					< 100 then return l + 1 else return l end end)()
	end
	if l >= 2 then
		return true
	end
end
function TrialHuman()
	if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Strength") then
		StrengthPart = game:GetService("Workspace")._WorldOrigin.Locations["Trial of Strength"]
		if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - StrengthPart.Position).Magnitude <= 1000 then
			for g, g in pairs(game.Workspace.Enemies:GetChildren()) do
				if IsMobAlive(g) and (g.HumanoidRootPart.Position - StrengthPart.Position).Magnitude <= 1000 then
					return g
				end
			end
		end
	end
end
function TrialGhoul()
	if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Carnage") then
		if
			(
				game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				- game:GetService("Workspace")._WorldOrigin.Locations["Trial of Carnage"].Position
			).Magnitude <= 1000
		then
			for g, g in pairs(game.Workspace.Enemies:GetChildren()) do
				if
					IsMobAlive(g)
					and (
							g.HumanoidRootPart.Position
							- game:GetService("Workspace")._WorldOrigin.Locations["Trial of Carnage"].Position
						).Magnitude
						<= 1000
				then
					return g
				end
			end
		end
	end
end
function GetSeaBeastTrial()
	if not game.Workspace.Map:FindFirstChild("FishmanTrial") then
		return
	end
	local g = (function() if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water") then return (game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water")) else return nil end end)()
	if g then
		local R, m, l = next, game:GetService("Workspace").SeaBeasts:GetChildren()
		for S, S in R, m, l do
			if
				string.find(S.Name, "SeaBeast")
				and (S:FindFirstChild("HumanoidRootPart"))
				and (S.HumanoidRootPart.Position - g.Position).Magnitude <= 1500
			then
				if S.Health.Value > 0 then
					return S
				end
			end
		end
	end
end
getgenv().TrialDone = false
getgenv().KillAuraDone = false
function TeleportSeabeast2(g)
	if
		(Vector3.new(0, g:FindFirstChild("HumanoidRootPart").Position.Y, 0) - Vector3.new(0, -60, 0)).Magnitude <= 175
	then
		toTarget(g.HumanoidRootPart.CFrame * CFrame.new(0, 200, 50))
	else
		toTarget(CFrame.new(g.HumanoidRootPart.Position.X, 140, g.HumanoidRootPart.Position.Z))
	end
end
function DetectPlayerKillName()
	local g, R, m, l = {}, next, game.Workspace.Characters:GetChildren()
	for S, S in R, m, l do
		if
			S:IsA("Model")
			and S.Name ~= game.Players.LocalPlayer.Name
			and (S:FindFirstChild("HumanoidRootPart"))
			and (S:FindFirstChild("Humanoid"))
			and S.Humanoid.Health > 0
			and (S.HumanoidRootPart.Position - Vector3.new(28718.068359375, 14887.5625, -60.5482177734375)).Magnitude
				<= 400
		then
			table.insert(g, S.Name)
		end
	end
	return g
end
getgenv().PlayerKillTrial = {}
getgenv().BlackListPlayerTrial = {}
function NameAttackTrial()
	for g, R in next, getgenv().PlayerKillTrial, nil do
		if not table.find(getgenv().BlackListPlayerTrial, R) then
			return R, g
		end
	end
end
function CheckCDSkill(g)
	if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills:FindFirstChild(g) then
		equiptool(g)
		return
	end
	local R, m, l = next, game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills[g]:GetChildren()
	for g, g in R, m, l do
		if g:IsA("Frame") then
			if
				g.Name ~= "Template"
					and g.Title.TextColor3 == Color3.new(1, 1, 1)
					and g.Cooldown.Size == UDim2.new(0, 0, 1, -1)
				or g.Cooldown.Size == UDim2.new(1, 0, 1, -1)
			then
				return g
			end
		end
	end
end
function VerifyNearbyTrial()
	local g, R, m, l =
		{
			"Trial of the Machine",
			"Trial of Speed",
			"Trial of Strength",
			"Trial of Water",
			"Trial of the King",
			"Trial of Carnage",
			"Trial of Flames",
		},
		next,
		workspace._WorldOrigin.Locations:GetChildren()
	for S, S in R, m, l do
		if table.find(g, S.Name) and t:DistanceFromCharacter(S.Position) < 1500 then
			return true
		end
	end
end
function AutoTrialV4()
	if Settings["Auto Finish Train Quest"] and Settings["Stack Train With Trial Race"] and (CheckGoTrain()) then
		return
	end
	local g = game.Lighting.ClockTime
	if
		(CheckMoon() == "Full Moon" and not (g > 5 and g < 12) or CheckMoon() == "Next Night")
		and Settings["Hop Server [Trial Or Pull Lever]"]
	then
		if getgenv().TurnOffHOPSVPullAndTrial then
			getgenv().TurnOffHOPSVPullAndTrial:SetStage(false)
		end
		task.wait(3)
	elseif Settings["Hop Server [Trial Or Pull Lever]"] then
		HopServer()
		return
	end
	g = GetTempleOfTime()
	if not g and not VerifyNearbyTrial() then
		toTarget(CFrame.new(28282.5703125, 14896.8505859375, 105.1042709350586))
		return
	end
	if
		g and (g.FFABorder:FindFirstChild("Forcefield")) and g.FFABorder.Forcefield.Transparency == 1
		or (VerifyNearbyTrial())
	then
		if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
			if VerifyNearbyTrial() and not getgenv().VerifyTrial then
				getgenv().VerifyTrial = true
			end
			repeat
				wait()
			until VerifyNearbyTrial()
				or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
			local R = game.Players.LocalPlayer.Data.Race.Value
			if R == "Human" then
				repeat
					task.wait()
					local m = TrialHuman()
					if m then
						repeat
							task.wait()
							sizepart(m)
							if Settings["Select Weapon"] == "Blox Fruit" then
								toTarget(m.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								toTarget(m.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end
							ClickM1(m)
							UsedualFlock()
						until not IsMobAlive(m)
							or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
							or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService(
									"Workspace"
								)._WorldOrigin.Locations["Trial of Strength"].Position).Magnitude
								> 1000
					end
				until not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
					or (
							game.Players.LocalPlayer.Character.HumanoidRootPart.Position
							- game:GetService("Workspace")._WorldOrigin.Locations["Trial of Strength"].Position
						).Magnitude
						> 1000
			elseif R == "Skypiea" then
				repeat
					task.wait()
					if
						game:GetService("Workspace")._WorldOrigin.Locations["Trial of the King"]
						and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService(
								"Workspace"
							)._WorldOrigin.Locations["Trial of the King"].CFrame.Position).Magnitude
							<= 1000
					then
						toTarget(game:GetService("Workspace").Map.SkyTrial.Model.FinishPart.CFrame)
						task.wait(3)
					end
				until not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
					or workspace.Map:FindFirstChild("Temple of Time") and workspace.Map["Temple of Time"].FFABorder.Forcefield.Transparency == 0
					or t:DistanceFromCharacter(game:GetService("Workspace").Map.SkyTrial.Model.FinishPart.Position)
						> 1000
			elseif R == "Fishman" then
				local m = (function() if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water") then return (game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water")) else return nil end end)()
				if m and (m.Position - t.Character.HumanoidRootPart.Position).Magnitude < 1500 then
					local m = GetSeaBeastTrial()
					repeat
						task.wait()
						if m then
							local l = m:FindFirstChild("HumanoidRootPart")
							getgenv().AimPos = CFrame.new(l.Position.X, 40, l.Position.Z)
							TeleportSeabeast2(m)
							if t:DistanceFromCharacter(l.Position) < 400 then
								AutoAllSkill()
							end
						end
					until not m
						or not m.Parent
						or m.Health.Value == 0
						or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
						or workspace.Map:FindFirstChild("Temple of Time") and workspace.Map["Temple of Time"].FFABorder.Forcefield.Transparency == 0
						or t:DistanceFromCharacter(
								game:GetService("Workspace")._WorldOrigin.Locations
									:FindFirstChild("Trial of Water").Position
							)
							> 1000
				end
			elseif R == "Mink" then
				repeat
					task.wait()
					if
						(
							game.Players.LocalPlayer.Character.HumanoidRootPart.Position
							- game:GetService("Workspace")._WorldOrigin.Locations["Trial of Speed"].Position
						).Magnitude <= 1000
					then
						toTarget(game:GetService("Workspace").StartPoint.CFrame * CFrame.new(0, 2, 0))
					end
				until not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
					or t:DistanceFromCharacter(
							game:GetService("Workspace")._WorldOrigin.Locations
								:FindFirstChild("Trial of Speed").Position
						)
						> 1000
			elseif R == "Ghoul" then
				repeat
					task.wait()
					local m = TrialGhoul()
					if m then
						repeat
							task.wait()
							sizepart(m)
							if Settings["Select Weapon"] == "Blox Fruit" then
								toTarget(m.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								toTarget(m.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end
							UsedualFlock()
							ClickM1(m)
						until not IsMobAlive(m)
							or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
							or t:DistanceFromCharacter(
									game:GetService("Workspace")._WorldOrigin.Locations
										:FindFirstChild("Trial of Carnage").Position
								)
								> 1000
					end
				until not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
					or t:DistanceFromCharacter(
							game:GetService("Workspace")._WorldOrigin.Locations
								:FindFirstChild("Trial of Carnage").Position
						)
						> 1000
			elseif R == "Cyborg" then
				repeat
					task.wait()
					toTarget(CFrame.new(28282.5703125, 14896.8505859375, 105.1042709350586))
				until not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
			end
		else
			if not g then
				return
			end
			local R = g[t.Data.Race.Value .. "Corridor"].Door.Door.RightDoor.Union
			if t:DistanceFromCharacter(R.Position) > 8 then
				toTarget(R.CFrame)
			end
			if Settings["Multi Trial"] and (CheckMultiTeleDoor()) and t:DistanceFromCharacter(R.Position) <= 8 then
				game:service("VirtualInputManager"):SendKeyEvent(true, "T", false, game)
				task.wait()
				game:service("VirtualInputManager"):SendKeyEvent(false, "T", false, game)
				return
			end
			if Settings["Auto Turn On V3 Near Door"] and (CheckMultiPlayerNearDoor()) then
				game:service("VirtualInputManager"):SendKeyEvent(true, "T", false, game)
				task.wait()
				game:service("VirtualInputManager"):SendKeyEvent(false, "T", false, game)
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
function PlayerTrial()
	local g = workspace.Map["Temple of Time"].FFABorder.Forcefield
	local R, m = g.Position, g.Size
	for l, S in pairs((workspace:FindPartsInRegion3(Region3.new(R - m / 2, R + m / 2), nil, 1 / 0))) do
		l = S.Parent
		if l and (l:FindFirstChild("Humanoid")) then
			g = game.Players:GetPlayerFromCharacter(l)
			if g and g.Name ~= t.Name and g.Character.Humanoid.Health > 0 then
				return g.Character
			end
		end
	end
end
local g
function hasCooldownChanged(R)
	local m, l = R:GetAttributes(), g
	if not l then
		g = R:GetAttributes()
	end
	for R, l in next, m, nil do
		if
			(
				string.find(R, "GunCooldown")
				or (string.find(R, "MeleeCooldown"))
				or (string.find(R, "SwordCooldown"))
				or (string.find(R, "BloxFruitCooldown"))
			) and l > 0
		then
			if g[R] ~= l then
				g = m
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
				if
					workspace.Map:FindFirstChild("Temple of Time")
					and workspace.Map["Temple of Time"].FFABorder.Forcefield.Transparency ~= 1
				then
					if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
						local g, R = PlayerTrial(), false
						if g then
							repeat
								task.wait()
								task.spawn(function()
									if not game:GetService("Lighting").Blur.Enabled then
										game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
										task.wait()
										game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
										task.wait(3)
									end
									getgenv().AimPos = g.HumanoidRootPart.CFrame
								end)
								if hasCooldownChanged(g) then
									local m = tick()
									repeat
										task.wait()
										task.spawn(getgenv().AttackFunctionnhungSuperTrial)
										t.Character.HumanoidRootPart.CFrame = g.HumanoidRootPart.CFrame
											* CFrame.new(0, 50, 0)
									until tick() - m >= 0.75
									R = false
								else
									if R then
										return
									end
									t.Character.HumanoidRootPart.CFrame = g.HumanoidRootPart.CFrame
										* CFrame.new(0, 0, 4)
								end
								task.spawn(getgenv().AttackFunctionnhungSuperTrial)
								equiptool(NameWeapon(Settings["Select Weapon Attack Trial"]))
								if
									Settings["Use Skill when Kill Player"]
									or Settings["Just Use Skill when Player Active Ken"]
								then
									if
										Settings["Just Use Skill when Player Active Ken"]
											and (game.Players[g.Name]:GetAttribute("KenActive"))
										or not Settings["Just Use Skill when Player Active Ken"]
									then
										task.spawn(function()
											local R = CheckCDSkill(NameWeapon(Settings["Select Weapon Attack Trial"]))
											if R then
												game:GetService("VirtualInputManager")
													:SendKeyEvent(true, R.Name, false, game)
												task.wait(0.05)
												game:GetService("VirtualInputManager")
													:SendKeyEvent(false, R.Name, false, game)
											end
										end)
									end
								end
							until not g
								or not g.Parent
								or g.Humanoid.Health <= 0
								or not Settings["Kill players When complete Trial"]
								or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
								or t.Character.Humanoid.Health <= 0
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
			local g, R = pcall(function()
				AutoTrialV4()
			end)
			if R then
				print(g, R)
			end
		end
		pcall(function()
			if
				workspace.Map:FindFirstChild("Temple of Time")
				and workspace.Map["Temple of Time"].FFABorder.Forcefield.Transparency ~= 1
			then
				if Settings["Auto Reset Character"] then
					t.Character.Humanoid.Health = 0
				end
			end
		end)
	end
end)
GetItemsMain = Main.CreatePage({ Page_Name = "Get and Upgrade Items", Page_Title = "Get and Upgrade Items Tab" })
GetItemsSection = GetItemsMain.CreateSection("Get Items")
GetItemsSection.CreateToggle(
	{ Title = "Auto Trade Bone", Desc = nil, Default = Settings["Auto Trade Bone"] or false },
	function(g)
		SaveSettings("Auto Trade Bone", g)
	end
)
GetItemsSection.CreateToggle(
	{ Title = "Auto Buy Legendary Sword", Desc = nil, Default = Settings["Auto Buy Legendary Sword"] or false },
	function(g)
		SaveSettings("Auto Buy Legendary Sword", g)
	end
)
GetItemsSection.CreateToggle(
	{ Title = "Auto Buy Haki Color", Desc = nil, Default = Settings["Auto Buy Haki Color"] or false },
	function(g)
		SaveSettings("Auto Buy Haki Color", g)
	end
)
GetItemsSection.CreateToggle(
	{
		Title = "Hop Server [ Haki color or Legendary Sword]",
		Desc = nil,
		Default = Settings["Hop Server [ Haki color or Legendary Sword]"] or false,
	},
	function(g)
		SaveSettings("Hop Server [ Haki color or Legendary Sword]", g)
	end
)
local g = { "Stone", "Hydra Leader", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate" }
function DetectQuestRainBowHaki(R)
	if not R then
		for R, R in next, g, nil do
			if
				HasQuest()
				and (QuestHas(R))
			then
				return false
			end
		end
		for R, R in next, g, nil do
			if
				not QuestHas(R)
				or not HasQuest()
			then
				return true
			end
		end
	else
		for R, R in next, g, nil do
			if QuestHas(R) then
				return R
			end
		end
	end
end
function GetRainBowHaki()
	if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("HornedMan") == 1 then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Done Get Rainbow Haki", ShowTime = 5 })
		wait(5)
		return
	end
	local g = workspace.NPCs:FindFirstChild("Horned Man")
		or (game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Horned Man"))
		or NPCManager.getNPCsByName("Horned Man")[1]._modelState._instance
	if DetectQuestRainBowHaki() then
		if t:DistanceFromCharacter(g.HumanoidRootPart.Position) > 8 then
			toTarget(g.HumanoidRootPart.CFrame)
		else
			wait(2)
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("HornedMan", "Bet")
		end
	else
		local g = CheckNameBoss(DetectQuestRainBowHaki(true))
		if g then
			repeat
				task.wait()
				sizepart(g)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
				ClickM1(g)
				UsedualFlock()
			until not IsMobAlive(g) or not Settings["Auto Get Rainbow Haki"]
		else
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Waiting Boss Spawn", ShowTime = 5 })
			wait(5)
		end
	end
end
GetItemsSection.CreateToggle(
	{ Title = "Auto Get Rainbow Haki", Desc = nil, Default = Settings["Auto Get Rainbow Haki"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Get Rainbow Haki"] and (task.wait(0.1)) do
					local R, R = pcall(function()
						GetRainBowHaki()
					end)
					if R then
						print(R)
					end
				end
			end)
		end
		SaveSettings("Auto Get Rainbow Haki", g)
	end
)
function CountZombie(g)
	local R = 0
	for m, m in pairs(game.workspace.Enemies:GetChildren()) do
		R = (function() if m.Name == "Living Zombie" and m.Humanoid.Health > 0 then return (function() if not g then return R + 1 else return R end end)() else return R end end)()
	end
	return R
end
BlankTablets = { "Segment6", "Segment2", "Segment8", "Segment9", "Segment5" }
Trophy =
	{ Segment1 = "Trophy1", Segment3 = "Trophy2", Segment4 = "Trophy3", Segment7 = "Trophy4", Segment10 = "Trophy5" }
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
function DetectHighHealthMob(g)
	local R, m = 0
	for l, S in pairs(game.Workspace.Enemies:GetChildren()) do
		if (typeof(g) == "table" and (table.find(g, S.Name)) or S.Name == g) and (IsMobAlive(S)) then
			l = S.Humanoid.Health
			if l > R then
				R, m = l, S
			end
		end
	end
	return m
end
function GuitarPuzzleProgress()
	if not CommF:InvokeServer("GuitarPuzzleProgress", "Check") then
		if
			game.Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431"
			and (game.Lighting.ClockTime > 16 or game.Lighting.ClockTime < 5)
		then
			if t:DistanceFromCharacter(Vector3.new(-8654.314453125, 140.9499053955078, 6167.5283203125)) > 50 then
				toTarget(CFrame.new(-8654.314453125, 140.9499053955078, 6167.5283203125))
			end
			CommF:InvokeServer("gravestoneEvent", 2)
			CommF:InvokeServer("gravestoneEvent", 2, true)
			task.wait(1)
		else
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Hop Full Moon", ShowTime = 5 })
			SpecialHop("FullMoon")
		end
	else
		if t.PlayerGui.Main.Dialogue.Visible then
			game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
			game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
		end
		if not CommF:InvokeServer("GuitarPuzzleProgress", "Check").Swamp then
			if
				(
					CFrame.new(-10171.7607421875, 138.62667846679688, 6008.0654296875).Position
					- t.Character.HumanoidRootPart.Position
				).Magnitude > 100
			then
				toTarget(CFrame.new(-10171.7607421875, 158.62667846679688, 6008.0654296875))
			elseif CountZombie() == 6 then
				repeat
					task.wait()
					local g = (DetectHighHealthMob("Living Zombie"))
					repeat
						task.wait()
						g = DetectHighHealthMob("Living Zombie")
						sizepart(g)
						UsedualFlock()
						ClickM1(g)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
					until not IsMobAlive(g)
				until CountZombie() == 0
			end
			return
		elseif not CommF:InvokeServer("GuitarPuzzleProgress", "Check").Gravestones then
			if t:DistanceFromCharacter(Vector3.new(-8761.4765625, 142.10487365722656, 6086.07861328125)) > 50 then
				toTarget(CFrame.new(-8761.4765625, 142.10487365722656, 6086.07861328125))
			else
				local g = {
					game.workspace.Map["Haunted Castle"].Placard1.Right.ClickDetector,
					game.workspace.Map["Haunted Castle"].Placard2.Right.ClickDetector,
					game.workspace.Map["Haunted Castle"].Placard3.Left.ClickDetector,
					game.workspace.Map["Haunted Castle"].Placard4.Right.ClickDetector,
					game.workspace.Map["Haunted Castle"].Placard5.Left.ClickDetector,
					game.workspace.Map["Haunted Castle"].Placard6.Left.ClickDetector,
					game.workspace.Map["Haunted Castle"].Placard7.Left.ClickDetector,
				}
				for R, R in pairs(g) do
					fireclickdetector(R)
				end
			end
		elseif not CommF:InvokeServer("GuitarPuzzleProgress", "Check").Ghost then
			if t:DistanceFromCharacter(Vector3.new(-9755.6591796875, 271.0661315917969, 6290.61474609375)) > 50 then
				toTarget(CFrame.new(-9755.6591796875, 271.0661315917969, 6290.61474609375))
			end
			CommF:InvokeServer("GuitarPuzzleProgress", "Ghost")
			task.wait(3)
		elseif not CommF:InvokeServer("GuitarPuzzleProgress", "Check").Trophies then
			if t:DistanceFromCharacter(Vector3.new(-9530.0126953125, 6.104853630065918, 6054.83349609375)) > 50 then
				toTarget(CFrame.new(-9530.0126953125, 6.104853630065918, 6054.83349609375))
			end
			local g = game.workspace.Map["Haunted Castle"].Tablet
			for R, m in pairs(BlankTablets) do
				R = g[m]
				if R.Line.Position.X ~= -9707.86328125 then
					repeat
						task.wait()
						fireclickdetector(R.ClickDetector)
					until R.Line.Position.X == -9707.86328125
				end
			end
			for R, m in pairs(Trophy) do
				local l = tostring(game.workspace.Map["Haunted Castle"].Trophies.Quest[m].Handle.CFrame):split(", ")[4]
				m = ((l == "1" or l == "-1") and "90" or "180")
				if not string.find(tostring(g[R].Line.Rotation.Z), m) then
					repeat
						task.wait()
						fireclickdetector(g[R].ClickDetector)
					until string.find(tostring(g[R].Line.Rotation.Z), m)
					print(R, m)
				end
			end
		elseif not CommF:InvokeServer("GuitarPuzzleProgress", "Check").Pipes then
			for g, R in pairs(Pipes) do
				local m = game.workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model[g]
				if m.BrickColor.Name ~= R then
					repeat
						task.wait()
						fireclickdetector(m.ClickDetector)
					until m.BrickColor.Name == R
				end
			end
		end
	end
end
function DetectRequestSoulGuitar()
	local g, R, m = {}
	if not CheckCountItem("Ectoplasm", 250) then
		m, g, R =
			"TravelDressrosa",
			{ "Ship Deckhand", "Ship Steward", "Ship Officer", "Ship Engineer" },
			getgenv().CheckPlaceId2
	elseif not CheckCountItem("Bones", 500) then
		m, g, R =
			"TravelZou",
			{ "Reborn Skeleton", "Demonic Soul", "Living Zombie", "Posessed Mummy" },
			getgenv().CheckPlaceId
	end
	return g, R, m
end
function AutoSoulGuitar()
	if
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy", true)
		== "[You already own this item.]"
	then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "[You already own this item.]", ShowTime = 5 })
		task.wait(5)
		return
	end
	if t.Data.Fragments.Value < 5000 then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Frag >= 5k", ShowTime = 5 })
		wait(5)
		return
	end
	if CheckCountItem("Dark Fragment", 1) and (CheckCountItem("Ectoplasm", 250)) and (CheckCountItem("Bones", 500)) then
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy", true)
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy")
		if game.PlaceId == getgenv().CheckPlaceId then
			GuitarPuzzleProgress()
		else
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
		end
		return
	end
	if not CheckCountItem("Dark Fragment", 1) then
		if game.PlaceId == getgenv().CheckPlaceId2 then
			if CheckNameBoss("Darkbeard") then
				local g = CheckNameBoss("Darkbeard")
				if g then
					repeat
						task.wait()
						sizepart(g)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						UsedualFlock()
						ClickM1(g)
					until not IsMobAlive(g) or not Settings["Auto Soul Guitar"]
				end
			elseif
				t.Character:FindFirstChild("Fist of Darkness") or (t.Backpack:FindFirstChild("Fist of Darkness"))
			then
				if
					(
						game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.Position
						- t.Character.HumanoidRootPart.Position
					).Magnitude <= 5
				then
					equiptool("Fist of Darkness")
					firetouchinterest(
						game.Players.LocalPlayer.Character["Fist of Darkness"].Handle,
						game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
						0
					)
					firetouchinterest(
						game.Players.LocalPlayer.Character["Fist of Darkness"].Handle,
						game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
						1
					)
					firetouchinterest(
						t.Character.HumanoidRootPart,
						game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
						0
					)
					firetouchinterest(
						t.Character.HumanoidRootPart,
						game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
						1
					)
				else
					toTarget(game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.CFrame)
				end
			else
				local g = GetNearestChest()
				if g then
					local R
					repeat
						task.wait()
						if
							(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - g.Position).Magnitude <= 5
						then
							if not R then
								R = (tick())
							elseif tick() - R >= 5 then
								Instance.new("IntValue", g).Name = "Ignored"
								wait(0.5)
							end
							game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
							wait()
							game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
							TweenManager.CancelCurrent()
						end
						toTarget(g.CFrame, true)
					until not g
						or not g.Parent
						or not Settings["Auto Soul Guitar"]
						or (t.Character:FindFirstChild("Fist of Darkness"))
						or (t.Backpack:FindFirstChild("Fist of Darkness"))
						or (g:GetAttribute("IsDisabled"))
						or (g:FindFirstChild("Ignored"))
						or not g:FindFirstChild("TouchInterest")
				else
					local g = PathFindChest()
					if g then
						toTarget(g.Part.CFrame)
						if
							(g.Part.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
							or (GetNearestChest())
						then
							Instance.new("IntValue", g).Name = "Ignored"
						end
					else
						print("delete")
						for g, g in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
							if g:FindFirstChild("Ignored") then
								g:FindFirstChild("Ignored"):Destroy()
							end
						end
					end
				end
			end
		else
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
		end
	else
		local g, R, m = DetectRequestSoulGuitar()
		if game.PlaceId == R then
			local R = DetectMob(g)
			if R then
				repeat
					task.wait()
					sizepart(R)
					BringMob(R)
					UsedualFlock()
					ClickM1(R)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(R.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(R.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
				until not IsMobAlive(R) or not Settings["Auto Soul Guitar"]
			elseif typeof(g) == "table" then
				if #N >= #g then
					N = {}
					return
				end
				local R = DetectPartSpawnMob(DetectNameTablePart(g))
				if R then
					table.insert(N, DetectNameTablePart(g))
					repeat
						wait()
						toTarget(R.CFrame * CFrame.new(0, 60, 0))
					until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob(g))
						or not Settings["Auto Soul Guitar"]
					wait(1)
				end
			else
				local R = DetectPartSpawnMob(g, true)
				if R then
					Instance.new("IntValue", R).Name = "Ignored"
					repeat
						wait()
						toTarget(R.CFrame * CFrame.new(0, 60, 0))
					until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob(g))
						or not Settings["Auto Soul Guitar"]
					wait(1)
				else
					DeleteIgnoredMobSpawn()
				end
			end
		else
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(m)
		end
	end
end
GetItemsSection.CreateToggle(
	{ Title = "Auto Soul Guitar", Desc = nil, Default = Settings["Auto Soul Guitar"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Soul Guitar"] and (task.wait(0.1)) do
					local R, R = pcall(function()
						AutoSoulGuitar()
					end)
					if R then
						print(R)
					end
				end
			end)
		end
		SaveSettings("Auto Soul Guitar", g)
	end
)
StartGood = true
function QuestGood3()
	AllNPCS = {}
	for g, g in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
		table.insert(AllNPCS, g)
	end
	for g, g in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
		table.insert(AllNPCS, g)
	end
	for g, g in pairs(AllNPCS) do
		if g.Name:match("Luxury Boat Dealer") then
			t.Character.HumanoidRootPart.CFrame = g.HumanoidRootPart.CFrame
			game:GetService("ReplicatedStorage").Remotes.CommF_
				:InvokeServer(unpack({ [1] = "CDKQuest", [2] = "BoatQuest", [3] = g }))
		end
	end
end
function QuestGood4()
	if
		(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(
			-5543.5327148438,
			313.80062866211,
			-2964.2585449219
		)).magnitude > 1000
	then
		toTarget(CFrame.new(-5543.5327148438, 313.80062866211, -2964.2585449219))
	else
		local g = GetPirateRaid() or (GetPirateRaid(true))
		if g then
			repeat
				task.wait()
				equiptool(NameWeapon("Sword"))
				sizepart(g)
				ClickM1(g)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
			until not IsMobAlive(g)
		else
			if
				(Settings["Select Method Hop CDK1"] or {})["Hop Raid Castle [ Delay 20s Hop Because check Raids Castle ]"]
			then
				A.CreateNoti({
					Title = "Noijo Hub",
					Desc = "Waiting 20s for check raid castle if dont have will Server",
					ShowTime = 5,
				})
				local g = tick()
				repeat
					wait()
				until GetPirateRaid() or (GetPirateRaid(true)) or tick() - g >= 20
				if not (GetPirateRaid() or (GetPirateRaid(true))) then
					SpecialHop("Raid Castle")
				end
			else
				A.CreateNoti({ Title = "Noijo Hub", Desc = "Waint Raid Castle", ShowTime = 5 })
			end
			wait(5)
		end
	end
end
function TourchGood5()
	return ((game:GetService("Workspace").Map.HeavenlyDimension.Torch1.ProximityPrompt.Enabled) and "1" or ((game:GetService("Workspace").Map.HeavenlyDimension.Torch2.ProximityPrompt.Enabled) and "2" or ((game:GetService("Workspace").Map.HeavenlyDimension.Torch3.ProximityPrompt.Enabled) and "3" or nil)))
end
function DetectMobCDK()
	for g, g in pairs(game.Workspace.Enemies:GetChildren()) do
		if
			g:IsA("Model")
			and (g:FindFirstChild("Humanoid"))
			and g.Humanoid.Health > 0
			and t:DistanceFromCharacter(g.HumanoidRootPart.Position) < 300
		then
			return g
		end
	end
end
function DetectMobHell()
	local g, R, m = next, game.Workspace.Enemies:GetChildren()
	for l, l in g, R, m do
		if
			l:IsA("Model")
			and (l:FindFirstChild("Humanoid"))
			and l.Humanoid.Health > 0
			and t:DistanceFromCharacter(l.HumanoidRootPart.Position) < 300
		then
			return l
		end
	end
end
function Questgood5()
	if
		(
			game:GetService("Workspace")._WorldOrigin.Locations["Heavenly Dimension"].Position
			- t.Character.HumanoidRootPart.Position
		).Magnitude < 1000
	then
		if game:GetService("Workspace").Map.HeavenlyDimension.Exit.BrickColor == BrickColor.new("Cloudy grey") then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
				game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame
			toTarget(game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame)
			return
		end
		if DetectMobCDK() then
			repeat
				task.wait()
				local g = DetectMobHell()
				sizepart(g)
				equiptool(NameWeapon("Sword"))
				toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				getgenv().ClickM1(g)
			until not DetectMobCDK()
		else
			local g = TourchGood5()
			if g then
				repeat
					task.wait()
					if
						(
							t.Character.HumanoidRootPart.Position
							- game:GetService("Workspace").Map.HeavenlyDimension["Torch" .. g].Position
						).Magnitude > 5
					then
						toTarget(game:GetService("Workspace").Map.HeavenlyDimension["Torch" .. g].CFrame)
					else
						fireproximityprompt(
							game:GetService("Workspace").Map.HeavenlyDimension["Torch" .. g].ProximityPrompt,
							0
						)
						fireproximityprompt(
							game:GetService("Workspace").Map.HeavenlyDimension["Torch" .. g].ProximityPrompt,
							1
						)
					end
				until DetectMobCDK()
				t.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
			end
		end
	elseif CheckNameBoss("Cake Queen") then
		local g = CheckNameBoss("Cake Queen")
		repeat
			task.wait()
			sizepart(g)
			equiptool(NameWeapon("Sword"))
			ClickM1(g)
			if Settings["Select Weapon"] == "Blox Fruit" then
				toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
			else
				toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
			end
		until not IsMobAlive(g) or not Settings["Auto CDK"]
		TweenManager.CancelCurrent()
	else
		if Settings["Select Method Hop CDK1"] and Settings["Select Method Hop CDK1"]["Find Cake Queen"] then
			A.CreateNoti({ Title = "Noijo Hub", Desc = 'Hop Server Find Cake Queen"', ShowTime = 5 })
			HopServer()
		else
			A.CreateNoti({ Title = "Noijo Hub", Desc = 'Wating Cake Queen"', ShowTime = 5 })
		end
		wait(5)
	end
end
function QuestEvil3()
	local g, R, m = next, game.workspace.Enemies:GetChildren()
	local l
	for S, S in g, R, m do
		l = (function() if S:IsA("Model")
				and S.Name == "Marine Commodore"
				and (S:FindFirstChild("HumanoidRootPart"))
				and S.Humanoid.Health > 0 then return S else return l end end)()
	end
	if not l then
		GetPart = DetectPartSpawnMob("Marine Commodore")
		toTarget(GetPart.CFrame * CFrame.new(0, 60, 0))
	else
		repeat
			task.wait()
			toTarget(l.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
		until t.Character.Humanoid.Health <= 0
	end
end
function DetectMobPhaze()
	local g, R, m = next, game.workspace.Enemies:GetChildren()
	local l
	for S, S in g, R, m do
		l = (function() if S:IsA("Model")
				and (S:FindFirstChild("HumanoidRootPart"))
				and (S:FindFirstChild("HazeESP"))
				and (S:FindFirstChild("Humanoid"))
				and S.Humanoid.Health > 0 then return S else return l end end)()
	end
	return l
end
function checknearstpartmobspawn()
	local g, R, m = next, game:GetService("Players").LocalPlayer.QuestHaze:GetChildren()
	for l, l in g, R, m do
		if l.Value > 0 then
			return l.Name
		end
	end
end
function QuestEvil4()
	if DetectMob(checknearstpartmobspawn()) then
		local g = DetectMob(checknearstpartmobspawn())
		repeat
			task.wait()
			sizepart(g)
			BringMob(g)
			equiptool(NameWeapon("Sword"))
			ClickM1(g)
			if Settings["Select Weapon"] == "Blox Fruit" then
				toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
			else
				toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
			end
		until not g or not g.Parent or g.Humanoid.Health == 0
	else
		GetPart = DetectPartSpawnMob(checknearstpartmobspawn())
		toTarget(GetPart.CFrame * CFrame.new(0, 15, 0))
	end
end
function TourchEvil5()
	return ((game:GetService("Workspace").Map.HellDimension.Torch1.ProximityPrompt.Enabled) and "1" or ((game:GetService("Workspace").Map.HellDimension.Torch2.ProximityPrompt.Enabled) and "2" or ((game:GetService("Workspace").Map.HellDimension.Torch3.ProximityPrompt.Enabled) and "3" or nil)))
end
function QuestEvil5()
	if
		(
			game:GetService("Workspace")._WorldOrigin.Locations["Hell Dimension"].Position
			- t.Character.HumanoidRootPart.Position
		).Magnitude > 1000
	then
		if not CheckNameBoss("Soul Reaper") then
			if not t.Character:FindFirstChild("Hallow Essence") and not t.Backpack:FindFirstChild("Hallow Essence") then
				local g = DetectMob(e)
				if g then
					repeat
						task.wait()
						sizepart(g)
						BringMob(g)
						equiptool(NameWeapon("Sword"))
						ClickM1(g)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
					until not IsMobAlive(g) or not Settings["Auto CDK"]
				elseif typeof(e) == "table" then
					if #N >= #e then
						N = {}
						return
					end
					local g = DetectPartSpawnMob(DetectNameTablePart(e))
					if g then
						table.insert(N, DetectNameTablePart(e))
						repeat
							wait()
							toTarget(g.CFrame * CFrame.new(0, 60, 0))
						until (g.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
							or (DetectMob(e))
							or not Settings["Auto CDK"]
						wait(1)
					end
				else
					local g = DetectPartSpawnMob(e, true)
					if g then
						Instance.new("IntValue", g).Name = "Ignored"
						repeat
							wait()
							toTarget(g.CFrame * CFrame.new(0, 60, 0))
						until (g.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
							or (DetectMob(e))
							or not Settings["Auto CDK"]
						wait(1)
					else
						DeleteIgnoredMobSpawn()
					end
				end
			elseif
				(
					t.Character.HumanoidRootPart.Position
					- game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position
				).Magnitude > 8
			then
				toTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
			else
				equiptool("Hallow Essence", true)
			end
		else
			local g = CheckNameBoss("Soul Reaper")
			repeat
				task.wait()
				toTarget(g.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
			until t.Character.Humanoid.Health <= 0
				or (
						game:GetService("Workspace")._WorldOrigin.Locations["Hell Dimension"].Position
						- t.Character.HumanoidRootPart.Position
					).Magnitude
					< 1000
			TweenManager.CancelCurrent()
			g = tick()
			repeat
				task.wait()
			until tick() - g >= 5
				or (
						game:GetService("Workspace")._WorldOrigin.Locations["Hell Dimension"].Position
						- t.Character.HumanoidRootPart.Position
					).Magnitude
					< 1000
		end
	else
		if game:GetService("Workspace").Map.HellDimension.Exit.BrickColor == BrickColor.new("Olivine") then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
				game:GetService("Workspace").Map.HellDimension.Exit.CFrame
			toTarget(game:GetService("Workspace").Map.HellDimension.Exit.CFrame)
			return
		end
		if DetectMobCDK() then
			repeat
				task.wait()
				local g = DetectMobHell()
				sizepart(g)
				toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				equiptool(NameWeapon("Sword"))
				getgenv().ClickM1(g)
			until not DetectMobCDK()
		else
			local g = TourchEvil5()
			if g then
				repeat
					task.wait()
					if
						(
							t.Character.HumanoidRootPart.Position
							- game:GetService("Workspace").Map.HellDimension["Torch" .. g].Position
						).Magnitude > 5
					then
						toTarget(game:GetService("Workspace").Map.HellDimension["Torch" .. g].CFrame)
					else
						fireproximityprompt(
							game:GetService("Workspace").Map.HellDimension["Torch" .. g].ProximityPrompt,
							0
						)
						fireproximityprompt(
							game:GetService("Workspace").Map.HellDimension["Torch" .. g].ProximityPrompt,
							1
						)
					end
				until DetectMobCDK()
				t.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
			end
		end
	end
end
function CheckMasterSword(g, R)
	local m, l, S = next, B()
	for I, I in m, l, S do
		if I.Type == "Sword" and I.Name == g and I.Mastery >= R then
			return true
		end
	end
	return false
end
function GetCDK()
	if not CheckItemInventory("Tushita") or not CheckItemInventory("Yama") then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Get Tushita and Yama", ShowTime = 5 })
		wait(5)
		return
	end
	if CheckItemInventory("Tushita") and (CheckItemInventory("Yama")) then
		if not CheckMasterSword("Yama", 350) or not CheckMasterSword("Tushita", 350) then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Mastery >= 350", ShowTime = 5 })
			wait(5)
			return
		end
		if
			not t.Character:FindFirstChild("Tushita")
			and not t.Backpack:FindFirstChild("Tushita")
			and not t.Character:FindFirstChild("Yama")
			and not t.Backpack:FindFirstChild("Yama")
		then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Tushita")
			return
		end
		getgenv().Good = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good").Good
		getgenv().Evil = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good").Evil
		local g = ((getgenv().Good == 4 and getgenv().Evil == 3) and "Pedestal2" or ((getgenv().Good == 3 and getgenv().Evil == 4) and "Pedestal1" or nil))
		if g then
			if
				(game:GetService("Workspace").Map.Turtle.Cursed[g].Position - t.Character.HumanoidRootPart.Position).Magnitude
				< 10
			then
				fireproximityprompt(game:GetService("Workspace").Map.Turtle.Cursed[g].ProximityPrompt)
			else
				toTarget(game:GetService("Workspace").Map.Turtle.Cursed[g].CFrame)
			end
		end
		if t.PlayerGui.Main.Dialogue.Visible then
			game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
			game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
		end
		if getgenv().Good == 4 and getgenv().Evil == 4 then
			if
				(
					game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.Position
					- t.Character.HumanoidRootPart.Position
				).Magnitude > 10
			then
				toTarget(game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.CFrame)
			elseif game:GetService("Workspace").Map.Turtle.Cursed.PlacedGem.Transparency == 0 then
				if not game.Workspace.Enemies:FindFirstChild("Cursed Skeleton Boss") then
					toTarget(CFrame.new(-12341.66796875, 603.3455810546875, -6550.6064453125))
				else
					local g, R, m = next, game.Workspace.Enemies:GetChildren()
					for l, l in g, R, m do
						if l:IsA("Model") and l.Name == "Cursed Skeleton Boss" and l.Humanoid.Health > 0 then
							repeat
								task.wait()
								sizepart(l)
								equiptool(NameWeapon("Sword"))
								ClickM1(l)
								if Settings["Select Weapon"] == "Blox Fruit" then
									toTarget(l.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									toTarget(l.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end
							until not l or not l.Parent or l.Humanoid.Health <= 0
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
MethodHopCDk = { ["Find Cake Queen"] = false, ["Hop Raid Castle [ Delay 20s Hop Because check Raids Castle ]"] = false }
GetItemsSection.CreateDropdown(
	{
		Title = "Select Method Hop CDK",
		List = PrepareMultiSelectList(MethodHopCDk, Settings["Select Method Hop CDK1"]),
		Search = true,
		Selected = true,
		Default = Settings["Select Method Hop CDK1"] or nil,
	},
	function(g, R)
		SaveSettings("Select Method Hop CDK1", g, R)
	end
)
GetItemsSection.CreateToggle({ Title = "Auto CDK", Desc = nil, Default = Settings["Auto CDK"] or false }, function(g)
	if g then
		spawn(function()
			while Settings["Auto CDK"] and (task.wait(0.1)) do
				local R, R = pcall(function()
					GetCDK()
				end)
				if R then
					print(R)
				end
			end
		end)
	end
	SaveSettings("Auto CDK", g)
end)
function GetYama()
	if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") < 30 then
		local g = DetectEliteHunter()
		if not EnsureEliteQuest(g.Name) then
			task.wait()
		else
			repeat
				task.wait()
				sizepart(g)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
				UsedualFlock()
				ClickM1(g)
			until not IsMobAlive(g) or not Settings["Auto Yama"]
		end
	else
		if
			not game.Workspace.Map:FindFirstChild("Waterfall")
			or not game.Workspace.Map.Waterfall:FindFirstChild("SealedKatana")
		then
			toTarget((CFrame.new(5251.900390625, 17.18115234375, 453.6025390625)))
			return
		end
		if
			(game.Workspace.Map.Waterfall.SealedKatana.WorldPivot.Position - t.Character.HumanoidRootPart.Position).Magnitude
			> 50
		then
			toTarget(game.Workspace.Map.Waterfall.SealedKatana.WorldPivot)
		elseif game.Workspace.Enemies:FindFirstChild("Ghost") then
			local g = DetectMob("Ghost")
			if g then
				repeat
					task.wait()
					sizepart(g)
					BringMob(g)
					UsedualFlock()
					ClickM1(g)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
				until not IsMobAlive(g) or not Settings["Auto Yama"]
			end
		else
			fireclickdetector(workspace.Map.Waterfall.SealedKatana.Hitbox.ClickDetector)
		end
	end
end
GetItemsSection.CreateToggle({ Title = "Auto Yama", Desc = nil, Default = Settings["Auto Yama"] or false }, function(g)
	if g then
		spawn(function()
			while Settings["Auto Yama"] and (task.wait(0.1)) do
				local R, R = pcall(function()
					GetYama()
				end)
				if R then
					print(R)
				end
			end
		end)
	end
	SaveSettings("Auto Yama", g)
end)
function checkTorch()
	local g, R, m, l =
		((not game:GetService("Workspace").Map.Turtle.QuestTorches.Torch1.Particles.Main.Enabled) and "1" or ((not game:GetService("Workspace").Map.Turtle.QuestTorches.Torch2.Particles.Main.Enabled) and "2" or ((not game:GetService("Workspace").Map.Turtle.QuestTorches.Torch3.Particles.Main.Enabled) and "3" or ((not game:GetService("Workspace").Map.Turtle.QuestTorches.Torch4.Particles.Main.Enabled) and "4" or ((not game:GetService("Workspace").Map.Turtle.QuestTorches.Torch5.Particles.Main.Enabled) and "5" or nil))))),
		next,
		game:GetService("Workspace").Map.Turtle.QuestTorches:GetChildren()
	for S, S in R, m, l do
		if S:IsA("MeshPart") and (string.find(S.Name, g)) and not S.Particles.Main.Enabled then
			return S
		end
	end
end
function GetHitBoxTouch()
	local g = workspace.Map:FindFirstChild("Waterfall")
		and (game.Workspace.Map.Waterfall:FindFirstChild("IslandModel"))
		and (workspace.Map.Waterfall.IslandModel:FindFirstChild("Hitbox", true))
	if g then
		return g
	end
	local g, R, m = next, getnilinstances()
	for l, l in g, R, m do
		if l.Name == "Hitbox" then
			if (l.Position - Vector3.new(5713.53759765625, 38.38311767578125, 255.2017059326172)).Magnitude == 0 then
				return l
			end
		end
	end
end
function GetTushita()
	local g = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
	if g:InvokeServer("TushitaProgress").OpenedDoor then
		if CheckNameBoss("Longma") then
			local R = CheckNameBoss("Longma")
			if R then
				repeat
					task.wait()
					sizepart(R)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(R.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(R.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
					UsedualFlock()
					ClickM1(R)
				until not IsMobAlive(R) or not Settings["Auto Tushita"]
			end
		end
	else
		local R = GetHitBoxTouch()
		if not R then
			toTarget((CFrame.new(5677.541015625, 28.533447265625, 357.9483642578125)))
			return
		end
		if R:FindFirstChild("TouchInterest") then
			if not t.Character:FindFirstChild("Holy Torch") and not t.Backpack:FindFirstChild("Holy Torch") then
				toTarget(R.CFrame)
			else
				equiptool("Holy Torch")
				if checkTorch() then
					for R = 1, 5, 1 do
						g:InvokeServer("TushitaProgress", "Torch", R)
					end
					wait(2)
				end
			end
		else
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Rip Indra Dont Spawn", ShowTime = 5 })
			wait(5)
		end
	end
end
GetItemsSection.CreateToggle(
	{ Title = "Auto Tushita", Desc = nil, Default = Settings["Auto Tushita"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Tushita"] and (task.wait()) do
					local R, R = pcall(function()
						GetTushita()
					end)
					if R then
						print(R)
					end
				end
			end)
		end
		SaveSettings("Auto Tushita", g)
	end
)
GetItemsSection.CreateToggle({ Title = "Auto TTK", Desc = nil, Default = Settings["Auto TTK"] or false }, function(g)
	if g then
		spawn(function()
			while Settings["Auto TTK"] and (task.wait(0.1)) do
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
						game:GetService("ReplicatedStorage").Remotes.CommF_
							:InvokeServer("LoadItem", "True Triple Katana")
					end
					local R = DetectMob(e)
					if R then
						repeat
							task.wait()
							sizepart(R)
							BringMob(R)
							equiptool(NameWeapon("Sword"))
							ClickM1(R)
							if Settings["Select Weapon"] == "Blox Fruit" then
								toTarget(R.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								toTarget(R.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end
						until not IsMobAlive(R) or not Settings["Auto TTK"]
					elseif typeof(e) == "table" then
						if #N >= #e then
							N = {}
							return
						end
						local R = DetectPartSpawnMob(DetectNameTablePart(e))
						if R then
							table.insert(N, DetectNameTablePart(e))
							repeat
								wait()
								toTarget(R.CFrame * CFrame.new(0, 60, 0))
							until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
								or (DetectMob(e))
								or not Settings["Auto TTK"]
							wait(1)
						end
					else
						local R = DetectPartSpawnMob(e, true)
						if R then
							Instance.new("IntValue", R).Name = "Ignored"
							repeat
								wait()
								toTarget(R.CFrame * CFrame.new(0, 60, 0))
							until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
								or (DetectMob(e))
								or not Settings["Auto TTK"]
							wait(1)
						else
							DeleteIgnoredMobSpawn()
						end
					end
				end)
			end
		end)
	end
	SaveSettings("Auto TTK", g)
end)
function doorcup()
	local g, R, m = next, game:GetService("Workspace").Map.Desert.Burn:GetChildren()
	for l, l in g, R, m do
		if l:IsA("Part") and not l.CanCollide then
			return true
		end
	end
	return false
end
function doorsaber()
	local g, R, m = next, game:GetService("Workspace").Map.Jungle.Final:GetChildren()
	for l, l in g, R, m do
		if l:IsA("Part") and not l.CanCollide then
			return true
		end
	end
	return false
end
function doortourch()
	local g, R, m = next, game:GetService("Workspace").Map.Jungle.QuestPlates:GetChildren()
	for l, l in g, R, m do
		if l:IsA("Model") then
			if l.Button:FindFirstChild("TouchInterest") then
				return l
			end
		end
	end
end
function SaberSword()
	if t.Data.Level.Value >= 200 then
		if not doorsaber() then
			if game:GetService("Workspace").Map.Jungle.QuestPlates.Door.CanCollide then
				toTarget(doortourch().Button.CFrame)
			elseif doorcup() then
				if
					game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= 0
					and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= 1
				then
					if not t.Character:FindFirstChild("Cup") and not t.Backpack:FindFirstChild("Cup") then
						if
							(t.Character.HumanoidRootPart.Position - CFrame.new(
								1112.46521,
								4.92147732,
								4364.55469,
								-0.743286014,
								-4.82822775E-11,
								-0.668973804,
								4.62103383E-10,
								1,
								-5.85609283E-10,
								0.668973804,
								-7.444102E-10,
								-0.743286014
							).Position).Magnitude < 5
						then
							toTarget(
								CFrame.new(
									1113.66992,
									7.5484705,
									4365.27832,
									-0.78613919,
									-2.19578524E-8,
									-0.618049502,
									1.02977182E-9,
									1,
									-3.68374984E-8,
									0.618049502,
									-2.95958493E-8,
									-0.78613919
								)
							)
							firetouchinterest(
								game:GetService("Workspace").Map.Desert.Cup,
								game.Players.LocalPlayer.Character.HumanoidRootPart,
								0
							)
							firetouchinterest(
								game:GetService("Workspace").Map.Desert.Cup,
								game.Players.LocalPlayer.Character.HumanoidRootPart,
								1
							)
							return
						end
						toTarget(
							CFrame.new(
								1112.46521,
								4.92147732,
								4364.55469,
								-0.743286014,
								-4.82822775E-11,
								-0.668973804,
								4.62103383E-10,
								1,
								-5.85609283E-10,
								0.668973804,
								-7.444102E-10,
								-0.743286014
							)
						)
					else
						equiptool("Cup")
						if
							t.Backpack:FindFirstChild("Cup")
								and (t.Backpack.Cup.Handle:FindFirstChild("TouchInterest"))
							or t.Character:FindFirstChild("Cup")
								and (t.Character.Cup.Handle:FindFirstChild("TouchInterest"))
						then
							toTarget(
								CFrame.new(
									1395.77307,
									37.4733238,
									-1324.34631,
									-0.999978602,
									-6.53588605E-9,
									0.00654155109,
									-6.57083277E-9,
									1,
									-5.32077493E-9,
									-0.00654155109,
									-5.3636442E-9,
									-0.999978602
								)
							)
						elseif
							t.Backpack:FindFirstChild("Cup")
								and not t.Backpack.Cup.Handle:FindFirstChild("TouchInterest")
							or t.Character:FindFirstChild("Cup")
								and not t.Character.Cup.Handle:FindFirstChild("TouchInterest")
						then
							if
								(t.Character.HumanoidRootPart.Position - Vector3.new(
									1457.8768310547,
									88.377502441406,
									-1390.6892089844
								)).Magnitude > 8
							then
								toTarget(CFrame.new(1457.8768310547, 88.377502441406, -1390.6892089844))
							else
								game:GetService("ReplicatedStorage").Remotes.CommF_
									:InvokeServer("ProQuestProgress", "SickMan")
							end
						end
					end
				elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0 then
					local g = CheckNameBoss("Mob Leader")
					if g then
						repeat
							task.wait()
							sizepart(g)
							if Settings["Select Weapon"] == "Blox Fruit" then
								toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end
							UsedualFlock()
							ClickM1(g)
						until not IsMobAlive(g) or not Settings["Auto Saber"]
					end
				elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
					if not t.Character:FindFirstChild("Relic") and not t.Backpack:FindFirstChild("Relic") then
						if
							(t.Character.HumanoidRootPart.Position - CFrame.new(
								-1404.07996,
								29.8520069,
								5.26677656,
								0.888123989,
								-4.0340602E-9,
								0.459603906,
								7.5884703E-9,
								1,
								-5.8864642E-9,
								-0.459603906,
								8.71560069E-9,
								0.888123989
							)).Magnitude > 8
						then
							toTarget(
								CFrame.new(
									-1404.07996,
									29.8520069,
									5.26677656,
									0.888123989,
									-4.0340602E-9,
									0.459603906,
									7.5884703E-9,
									1,
									-5.8864642E-9,
									-0.459603906,
									8.71560069E-9,
									0.888123989
								)
							)
						else
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
						end
					else
						equiptool("Relic")
						toTarget(CFrame.new(-1405.3677978516, 29.977333068848, 4.5685839653015))
					end
				end
			elseif not t.Character:FindFirstChild("Torch") and not t.Backpack:FindFirstChild("Torch") then
				toTarget(game:GetService("Workspace").Map.Jungle.Torch.CFrame)
			else
				equiptool("Torch")
				if
					(t.Character.HumanoidRootPart.Position - CFrame.new(
						1115.23499,
						4.92147732,
						4349.36963,
						-0.670654476,
						-2.18307523E-8,
						0.74176991,
						-9.06980624E-9,
						1,
						2.1230365E-8,
						-0.74176991,
						7.51052998E-9,
						-0.670654476
					).Position).Magnitude < 5
				then
					toTarget(
						CFrame.new(
							1114.59863,
							4.92147732,
							4350.64258,
							-0.508235395,
							1.00975717E-9,
							0.861218214,
							7.77848985E-9,
							1,
							3.41788708E-9,
							-0.861218214,
							8.43606784E-9,
							-0.508235395
						)
					)
					firetouchinterest(
						game.Players.LocalPlayer.Character.Torch.Handle,
						game:GetService("Workspace").Map.Desert.Burn.Fire,
						0
					)
					firetouchinterest(
						game.Players.LocalPlayer.Character.Torch.Handle,
						game:GetService("Workspace").Map.Desert.Burn.Fire,
						1
					)
					return
				end
				toTarget(
					CFrame.new(
						1115.23499,
						4.92147732,
						4349.36963,
						-0.670654476,
						-2.18307523E-8,
						0.74176991,
						-9.06980624E-9,
						1,
						2.1230365E-8,
						-0.74176991,
						7.51052998E-9,
						-0.670654476
					)
				)
			end
		else
			local g = CheckNameBoss("Saber Expert")
			if g then
				repeat
					task.wait()
					sizepart(g)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
					UsedualFlock()
					ClickM1(g)
				until not IsMobAlive(g) or not Settings["Auto Saber"]
			end
		end
	end
end
GetItemsSection.CreateToggle(
	{ Title = "Auto Saber", Desc = nil, Default = Settings["Auto Saber"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Saber"] and (task.wait(0.1)) do
					pcall(function()
						SaberSword()
					end)
				end
			end)
		end
		SaveSettings("Auto Saber", g)
	end
)
function autoCraftSharkAnchor()
	if CheckItemInventory("Shark Anchor") then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Done Shark Anchor", ShowTime = 5 })
		wait(5)
		return
	end
	if not CheckItemInventory("Monster Magnet") then
		if
			not CheckItemInventory("Shark Tooth Necklace")
			and (CheckCountItem("Mutant Tooth", 1))
			and (CheckCountItem("Shark Tooth", 5))
		then
			game:GetService("ReplicatedStorage").Modules.Net
				:FindFirstChild("RF/Craft")
				:InvokeServer(unpack({ [1] = "Craft", [2] = "ToothNecklace", [3] = 1, [4] = {} }))
		elseif
			not CheckItemInventory("Terror Jaw")
			and (CheckCountItem("Mutant Tooth", 2))
			and (CheckCountItem("Shark Tooth", 5))
			and (CheckCountItem("Terror Eyes", 1))
			and (CheckCountItem("Fool's Gold", 10))
		then
			game:GetService("ReplicatedStorage").Modules.Net
				:FindFirstChild("RF/Craft")
				:InvokeServer(unpack({ [1] = "Craft", [2] = "TerrorJaw", [3] = 1, [4] = {} }))
		elseif
			CheckItemInventory("Shark Tooth Necklace")
			and (CheckItemInventory("Terror Jaw"))
			and (CheckCountItem("Terror Eyes", 2))
			and (CheckCountItem("Shark Tooth", 10))
			and (CheckCountItem("Electric Wing", 10))
			and (CheckCountItem("Fool's Gold", 20))
		then
			game:GetService("ReplicatedStorage").Modules.Net
				:FindFirstChild("RF/Craft")
				:InvokeServer(unpack({ [1] = "Craft", [2] = "SharkAnchor", [3] = 1, [4] = {} }))
		end
	end
end
GetItemsSection.CreateToggle(
	{ Title = "Auto Craft Item Shark Anchor", Desc = nil, Default = Settings["Auto Craft Item Shark Anchor"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Craft Item Shark Anchor"] and (wait(0.1)) do
					pcall(function()
						autoCraftSharkAnchor()
					end)
				end
			end)
		end
		SaveSettings("Auto Craft Item Shark Anchor", g)
	end
)
function AutoYorumini()
	if CheckItemInventory("Dark Dagger") then
		A.CreateNoti({ Title = "Noijo Hub", Desc = "u haved Yoru Mini", ShowTime = 5 })
		return
	end
	local g = CheckNameBoss("rip_indra True Form")
	if g then
		repeat
			task.wait()
			sizepart(g)
			if Settings["Select Weapon"] == "Blox Fruit" then
				toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
			else
				toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
			end
			UsedualFlock()
			ClickM1(g)
		until not IsMobAlive(g) or not Settings["Auto Yoru Mini"]
	elseif not DetectItemPlr("God's Chalice") then
		elitehunter = DetectEliteHunter()
		if elitehunter then
			local g = elitehunter
			if g then
				if not EnsureEliteQuest(g.Name) then
					task.wait()
				else
					repeat
						task.wait()
						sizepart(g)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						UsedualFlock()
						ClickM1(g)
					until not IsMobAlive(g) or not Settings["Auto Yoru Mini"]
				end
			end
		else
			local g = Settings["Value Collect Chest to Hop"] or 20
			if f and f >= g and Settings["Auto Yoru Mini (Hop Server)"] then
				HopServer()
				return
			end
			g = GetNearestChest()
			if g then
				f = f + (1)
				local R
				repeat
					task.wait()
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - g.Position).Magnitude <= 5 then
						if not R then
							R = (tick())
						elseif tick() - R >= 5 then
							Instance.new("IntValue", g).Name = "Ignored"
							wait(0.5)
						end
						game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
						wait()
						game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
						TweenManager.CancelCurrent()
					end
					toTarget(g.CFrame, true)
				until not g
					or not g.Parent
					or not Settings["Auto Yoru Mini"]
					or (g:GetAttribute("IsDisabled"))
					or (g:FindFirstChild("Ignored"))
					or not g:FindFirstChild("TouchInterest")
			else
				local g = PathFindChest()
				if g then
					toTarget(g.Part.CFrame)
					if
						(g.Part.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (GetNearestChest())
					then
						Instance.new("IntValue", g).Name = "Ignored"
					end
				else
					print("delete")
					for g, g in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
						if g:FindFirstChild("Ignored") then
							g:FindFirstChild("Ignored"):Destroy()
						end
					end
				end
			end
		end
	else
		f = Settings["Value Collect Chest to Hop"] or 20
		if not IsMisisngLegHaki() and (DetectButtons()) then
			TouchPadHaki()
		elseif not DetectButtons() then
			equiptool("God's Chalice")
			toTarget(game:GetService("Workspace").Map["Boat Castle"].Summoner.Detection.CFrame)
		end
	end
end
GetItemsSection.CreateToggle(
	{
		Title = "Auto Yoru Mini",
		Desc = "u need have 3 haki legendary,\10it will auto chest, kill Elite Hunter Find Chalice,\10Summon And Kill Rip Indra",
		Default = Settings["Auto Yoru Mini"] or false,
	},
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Yoru Mini"] and (wait(0.1)) do
					pcall(function()
						AutoYorumini()
					end)
				end
			end)
		end
		SaveSettings("Auto Yoru Mini", g)
	end
)
GetItemsSection.CreateToggle(
	{
		Title = "Auto Yoru Mini (Hop Server)",
		Desc = "u can change value hop chest in Tab Farming Other",
		Default = Settings["Auto Yoru Mini"] or false,
	},
	function(g)
		SaveSettings("Auto Yoru Mini (Hop Server)", g)
	end
)
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
function DetectMeleeFarmMastery()
	local g, f = 1 / 0
	for R, m in next, TableMelees, nil do
		if not table.find(BlMeleeFarmMastery, R) then
			if g > m then
				g, f = m, R
			end
		end
	end
	return f
end
function CheckMasteryMelee(g)
	for f, f in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if f:IsA("Tool") and (g and f.Name == g or not g and f.ToolTip == "Melee") then
			return f.Level.Value
		end
	end
	for f, f in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if f:IsA("Tool") and (g and f.Name == g or not g and f.ToolTip == "Melee") then
			return f.Level.Value
		end
	end
end
MasteryWeaponSection.CreateToggle(
	{ Title = "Auto Farm Mastery 600 Melees", Desc = nil, Default = Settings["Auto Farm Mastery 600 Melees"] or false },
	function(g)
		if g then
			Q = true
			o:SetStage(true)
			d:SetValue("Melee")
		elseif not g and Q then
			o:SetStage(false)
			Q = false
		end
		if g then
			spawn(function()
				while Settings["Auto Farm Mastery 600 Melees"] and (task.wait()) do
					local f, f = pcall(function()
						local R = DetectMeleeFarmMastery()
						if
							not game.Players.LocalPlayer.Character:FindFirstChild(R)
							and not game.Players.LocalPlayer.Backpack:FindFirstChild(R)
						then
							if R == "Dragon Claw" then
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
									"BlackbeardReward",
									"DragonClaw",
									"1"
								)
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
									"BlackbeardReward",
									"DragonClaw",
									"2"
								)
								return
							end
							local m = string.gsub(R, " ", "")
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buy" .. m)
						elseif CheckMasteryMelee(R) >= 600 then
							table.insert(BlMeleeFarmMastery, R)
						end
					end)
					if f then
						print(f)
					end
				end
			end)
		end
		SaveSettings("Auto Farm Mastery 600 Melees", g)
	end
)
function DetectSwordUnlock()
	local g, f, R = next, B()
	local m, l = 0
	for S, S in g, f, R do
		if S.Type == "Sword" and 600 > S.Mastery then
			if m < S.Rarity then
				m, l = S.Rarity, S.Name
			end
		end
	end
	return l
end
MasteryWeaponSection.CreateToggle(
	{
		Title = "Auto Farm Mastery 600 Sword In Inventory",
		Desc = nil,
		Default = Settings["Auto Farm Mastery 600 Sword In Inventory"] or false,
	},
	function(g)
		if g then
			Q = true
			o:SetStage(true)
			d:SetValue("Sword")
		elseif not g and Q then
			o:SetStage(false)
			Q = false
		end
		if g then
			spawn(function()
				while Settings["Auto Farm Mastery 600 Sword In Inventory"] and (task.wait()) do
					pcall(function()
						local f = DetectSwordUnlock()
						if f and not t.Backpack:FindFirstChild(f) and not t.Character:FindFirstChild(f) then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", f)
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Farm Mastery 600 Sword In Inventory", g)
	end
)
UpgradeWeaponSection = GetItemsMain.CreateSection("Upgrade Weapon")
getgenv().StatusUpgradeWP = UpgradeWeaponSection.CreateLabel({ Title = "" })
function DetectGunUnlock()
	local g, f, R = next, B()
	local m, l = 0
	for Q, Q in g, f, R do
		if Q.Type == "Gun" and 600 > Q.Mastery then
			if m < Q.Rarity then
				m, l = Q.Rarity, Q.Name
			end
		end
	end
	return l
end
function DetectItemUpgrade(g)
	local f, R =
		{},
		{
			[1] = "UpgradeItem",
			[2] = "Check",
			[3] = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(NameWeapon(g))
				or (game:GetService("Players").LocalPlayer.Character:FindFirstChild(NameWeapon(g))),
		}
	for g, g in next, game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(R)).Required, nil do
		f[g.Name] = g.Required
	end
	f.NameWp = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(R)).Result.Name
	f.Physical = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(R)).Result.Physical
	return f
end
function DetectNameWpUpgrade(g)
	local f, R, m = next, B()
	local l, Q = 0
	for S, S in f, R, m do
		if S.Type == g and S.Upgrades == 0 then
			if l < S.Rarity then
				l, Q = S.Rarity, S.Name
			else
				Q = (function() if l == S.Rarity then return S.Name else return Q end end)()
			end
		end
	end
	return Q
end
local g, f
function DetectMaterialsUpgrade()
	for R, m in next, f, nil do
		if
			R ~= "NameWp"
			and R ~= "Physical"
			and not CheckCountItem(R, m)
			and R ~= "Dark Fragment"
			and NameWorldMaterials[R][game.PlaceId]
		then
			return R
		end
	end
	for R, m in next, f, nil do
		if R ~= "NameWp" and R ~= "Physical" and not CheckCountItem(R, m) then
			return R
		end
	end
end
function AutoUpgradeWeapon(R)
	if NameWeapon(R) ~= DetectNameWpUpgrade(R) then
		if getgenv().StatusUpgradeWP then
			StatusUpgradeWP.SetText("Change Weapon" .. DetectNameWpUpgrade(R))
		end
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", DetectNameWpUpgrade(R))
		return
	end
	if not f or f.NameWp ~= DetectNameWpUpgrade(R) then
		if not g then
			for m, l in pairs(game.Workspace.NPCs:GetDescendants()) do
				m = l:IsA("Model") and l.Name == "Blacksmith" and (l:FindFirstChild("Head"))
				if m then
					g = l.Head.CFrame * CFrame.new(0, -2, 2)
				end
			end
			for m, l in pairs(game:GetService("ReplicatedStorage").NPCs:GetDescendants()) do
				m = l:IsA("Model") and l.Name == "Blacksmith" and (l:FindFirstChild("Head")) and not g
				if m then
					g = l.Head.CFrame * CFrame.new(0, -2, 2)
				end
			end
		else
			if getgenv().StatusUpgradeWP then
				StatusUpgradeWP.SetText("Get info Upgrade WP")
			end
			if t:DistanceFromCharacter(g.Position) > 10 then
				toTarget(g, true)
			else
				f = DetectItemUpgrade(R)
			end
		end
		return
	end
	local m = (function() if f then return (DetectMaterialsUpgrade()) else return nil end end)()
	if f and not m then
		if getgenv().StatusUpgradeWP then
			StatusUpgradeWP.SetText("Go Upgrade Weapon")
		end
		toTarget(g, true)
		if t:DistanceFromCharacter(g.Position) < 10 then
			if game:GetService("Players").LocalPlayer.PlayerGui.Main.Craft.Visible then
				wait(1)
				for g, g in
					pairs(
						getconnections(
							game:GetService("Players").LocalPlayer.PlayerGui.Main.Craft.Main.Bottom.Confirm.Activated
						)
					)
				do
					g.Function()
				end
				if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Craft.Main.Bottom.Confirm.Visible then
					for g, g in
						pairs(
							getconnections(
								game:GetService("Players").LocalPlayer.PlayerGui.Main.Craft.Main.Bottom.Close.Activated
							)
						)
					do
						g.Function()
					end
				end
			else
				local g = {
					[1] = "UpgradeItem",
					[2] = "Check",
					[3] = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(NameWeapon(R))
						or (game:GetService("Players").LocalPlayer.Character:FindFirstChild(NameWeapon(R))),
				}
				local f = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(g))
				require(game.Players.LocalPlayer.PlayerGui.Main.UIController.Craft)(f.Required, f.Result, f.ResultStats)
				wait(1)
			end
		end
	end
	if m then
		R = NameMaterials[m]
		if not R then
			A.CreateNoti({ Title = "Noijo Hub", Desc = "Not Support Material" .. m .. "Sorry", ShowTime = 5 })
			wait(5)
			return
		end
		if not NameWorldMaterials[m][game.PlaceId] then
			local g = NameWorldMaterials[m][getgenv().CheckPlaceId2]
				or NameWorldMaterials[m][getgenv().CheckPlaceId3]
				or NameWorldMaterials[m][getgenv().CheckPlaceId]
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(g)
			return
		end
		if getgenv().StatusUpgradeWP then
			StatusUpgradeWP.SetText("Farm Material " .. m)
		end
		local g = DetectMob(R)
		if not g then
			if typeof(R) == "table" then
				if #N >= #R then
					N = {}
					return
				end
				local f = DetectPartSpawnMob(DetectNameTablePart(R))
				if f then
					table.insert(N, DetectNameTablePart(R))
					repeat
						wait()
						toTarget(f.CFrame * CFrame.new(0, 60, 0))
					until (f.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob(R))
						or not Settings["Auto Upgrade Sword Inventory"]
							and not Settings["Auto Upgrade Gun Inventory"]
					wait(1)
				end
			else
				local f = DetectPartSpawnMob(R, true)
				if f then
					Instance.new("IntValue", f).Name = "Ignored"
					repeat
						wait()
						toTarget(f.CFrame * CFrame.new(0, 60, 0))
					until (f.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob(R))
						or not Settings["Auto Upgrade Sword Inventory"]
							and not Settings["Auto Upgrade Gun Inventory"]
					wait(1)
				else
					DeleteIgnoredMobSpawn()
				end
			end
		else
			repeat
				task.wait()
				sizepart(g)
				BringMob(g)
				UsedualFlock()
				ClickM1(g)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
			until not IsMobAlive(g)
				or not Settings["Auto Upgrade Sword Inventory"] and not Settings["Auto Upgrade Gun Inventory"]
		end
	end
end
UpgradeWeaponSection.CreateToggle(
	{ Title = "Auto Upgrade Sword Inventory", Desc = nil, Default = Settings["Auto Upgrade Sword Inventory"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Upgrade Sword Inventory"] and (task.wait(0.1)) do
					local f, f = pcall(function()
						AutoUpgradeWeapon("Sword")
					end)
					if f then
						print(f)
					end
				end
			end)
		end
		SaveSettings("Auto Upgrade Sword Inventory", g)
	end
)
UpgradeWeaponSection.CreateToggle(
	{ Title = "Auto Upgrade Gun Inventory", Desc = nil, Default = Settings["Auto Upgrade Gun Inventory"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Upgrade Gun Inventory"] and (task.wait(0.1)) do
					local f, f = pcall(function()
						AutoUpgradeWeapon("Gun")
					end)
					if f then
						print(f)
					end
				end
			end)
		end
		SaveSettings("Auto Upgrade Gun Inventory", g)
	end
)
VolcanoTab = Main.CreatePage({ Page_Name = "Volcano Event", Page_Title = "Volcano Event Tab" })
SettingsVolcanoSection = VolcanoTab.CreateSection("Settings Volcano")
SettingsVolcanoSection.CreateDropdown(
	{
		Title = "Select Weapon Kill Golem",
		List = { "Melee", "Sword", "Blox Fruit" },
		Search = true,
		Selected = false,
		Default = Settings["Select Weapon Kill Golem"] or nil,
	},
	function(g)
		SaveSettings("Select Weapon Kill Golem", g)
	end
)
SettingsVolcanoSection.CreateDropdown(
	{
		Title = "Select Weapons Fix Lava",
		List = PrepareMultiSelectList(E, Settings["Select Weapons Fix Lava"]),
		Search = true,
		Selected = true,
		Default = Settings["Select Weapons Fix Lava"] or nil,
	},
	function(g, f)
		SaveSettings("Select Weapons Fix Lava", g, f)
	end
)
SettingsVolcanoSection.CreateDropdown(
	{
		Title = "Select Method Kill Golem",
		List = { "Click M1", "Instant Kill [ Risk and can bug no die mob ]" },
		Search = true,
		Selected = false,
		Default = Settings["Select Method Kill Golem"] or nil,
	},
	function(g)
		SaveSettings("Select Method Kill Golem", g)
	end
)
FarmingVolcanoSection = VolcanoTab.CreateSection("Farming Volcano")
function AutoCraftinMagnetVol()
	if not CheckItemInventory("Volcanic Magnet") then
		if not CheckCountItem("Scrap Metal", 10) then
			local g = { "Jungle Pirate" }
			local f = DetectMob(g)
			if not f then
				if typeof(g) == "table" then
					if #N >= #g then
						N = {}
						return
					end
					local R = DetectPartSpawnMob(DetectNameTablePart(g))
					if R then
						table.insert(N, DetectNameTablePart(g))
						repeat
							wait()
							toTarget(R.CFrame * CFrame.new(0, 60, 0))
						until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
							or (DetectMob(g))
							or not Settings["Auto Crafting Volcanic Magnet"]
						wait(1)
					end
				end
			else
				repeat
					task.wait()
					sizepart(f)
					BringMob(f)
					UsedualFlock()
					ClickM1(f)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(f.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(f.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
				until not IsMobAlive(f) or not Settings["Auto Crafting Volcanic Magnet"]
			end
			return
		elseif not CheckCountItem("Blaze Ember", 15) then
			local g = workspace.NPCs:FindFirstChild("Dragon Hunter")
				or (game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Hunter"))
				or NPCManager.getNPCsByName("Dragon Hunter")[1]._modelState._instance
			if not getgenv().QuestHunterDragon then
				if t:DistanceFromCharacter(g.HumanoidRootPart.Position) > 8 then
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
				else
					local g = game:GetService("ReplicatedStorage")
						:WaitForChild("Modules")
						:WaitForChild("Net")
						:WaitForChild("RF/DragonHunter")
						:InvokeServer(unpack({ [1] = { Context = "Check" } }))
					if not g or g and not g.Text then
						getgenv().QuestHunterDragon = game:GetService("ReplicatedStorage")
							:WaitForChild("Modules")
							:WaitForChild("Net")
							:WaitForChild("RF/DragonHunter")
							:InvokeServer(unpack({ [1] = { Context = "RequestQuest" } })).Text
					else
						getgenv().QuestHunterDragon = g.Text
					end
				end
			else
				local g = DetectEmberTemplate()
				if g then
					Instance.new("IntValue", g).Name = "Ignored"
					repeat
						wait()
						toTarget(g.Part.CFrame)
					until not g or not g.Parent
					return
				end
				if string.find(getgenv().QuestHunterDragon, "Hydra Enforcers") then
					local f = DetectMob("Hydra Enforcer")
					if not f then
						local R = DetectPartSpawnMob("Hydra Enforcer", true)
						if R then
							Instance.new("IntValue", R).Name = "Ignored"
							repeat
								wait()
								toTarget(R.CFrame * CFrame.new(0, 60, 0))
							until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
								or (DetectMob("Hydra Enforcer"))
								or not Settings["Auto Quest Dragon Hunter"]
								or g
							wait(1)
						else
							DeleteIgnoredMobSpawn()
						end
					else
						repeat
							task.wait()
							sizepart(f)
							BringMob(f)
							UsedualFlock()
							ClickM1(f)
							if Settings["Select Weapon"] == "Blox Fruit" then
								toTarget(f.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								toTarget(f.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end
						until not IsMobAlive(f) or not Settings["Auto Crafting Volcanic Magnet"] or g
					end
				elseif string.find(getgenv().QuestHunterDragon, "Venomous Assailants") then
					local f = DetectMob("Venomous Assailant")
					if not f then
						local R = DetectPartSpawnMob("Venomous Assailant", true)
						if R then
							Instance.new("IntValue", R).Name = "Ignored"
							repeat
								wait()
								toTarget(R.CFrame * CFrame.new(0, 60, 0))
							until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
								or (DetectMob("Venomous Assailant"))
								or not Settings["Auto Crafting Volcanic Magnet"]
								or g
							wait(1)
						else
							DeleteIgnoredMobSpawn()
						end
					else
						repeat
							task.wait()
							sizepart(f)
							BringMob(f)
							UsedualFlock()
							ClickM1(f)
							if Settings["Select Weapon"] == "Blox Fruit" then
								toTarget(f.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
							else
								toTarget(f.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							end
						until not IsMobAlive(f) or not Settings["Auto Crafting Volcanic Magnet"] or g
					end
				elseif string.find(getgenv().QuestHunterDragon, "trees") then
					local f, R = DetectTree(), workspace.CurrentCamera
					if f then
						Instance.new("IntValue", f).Name = "Ignored"
						local m = tick()
						repeat
							wait()
							local E = f.WorldPivot.Position
							if t:DistanceFromCharacter(E) < 50 then
								AutoAllSkill()
							end
							if f:FindFirstChild("Meshes/plant1_Icosphere", true) then
								toTarget(f.WorldPivot)
								getgenv().AimPos = f.WorldPivot
								G.Hit = CFrame.new(R.CFrame.Position, E)
								G.Target = f
							else
								local E, l =
									(f.WorldPivot * CFrame.new(5, -20, 0)).Position,
									(f.WorldPivot * CFrame.new(0, -20, 0)).Position
								toTarget(CFrame.new(E))
								getgenv().AimPos = CFrame.new(l)
								G.Hit = CFrame.new(R.CFrame.Position, l)
								G.Target = f
							end
						until not f
							or not f.Parent
							or not Settings["Auto Crafting Volcanic Magnet"]
							or g
							or (f:GetAttribute("AlreadyDestroyedClient"))
							or tick() - m >= 15
					end
				end
			end
			return
		end
		if CheckCountItem("Scrap Metal", 10) and (CheckCountItem("Blaze Ember", 15)) then
			game:GetService("ReplicatedStorage").Modules.Net
				:FindFirstChild("RF/Craft")
				:InvokeServer(unpack({ [1] = "Craft", [2] = "Volcanic Magnet", [3] = 1, [4] = {} }))
			wait(2)
		end
	else
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Done Craft Volcanic Magnet", ShowTime = 5 })
		ToggleAutoCraftingVolcanicMagnet:SetStage(false)
	end
end
ToggleAutoCraftingVolcanicMagnet = FarmingVolcanoSection.CreateToggle(
	{ Title = "Auto Crafting Volcanic Magnet", Desc = nil, Default = Settings["Auto Crafting Volcanic Magnet"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Crafting Volcanic Magnet"] and (wait(0.1)) do
					pcall(function()
						AutoCraftinMagnetVol()
					end)
				end
			end)
		end
		SaveSettings("Auto Crafting Volcanic Magnet", g)
	end
)
function AutoFindPrehistoric()
	if
		not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
		and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
		and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
	then
		getgenv().RespawnVolcano = true
		local g = checkboat()
		if not g or g and t:DistanceFromCharacter(g.VehicleSeat.Position) >= 4000 then
			local f = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
			if (f.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
				if (f.Position - t.Character.HumanoidRootPart.Position).Magnitude > 1000 then
					if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki" then
						t.Character.Humanoid.Health = 0
						return
					end
				end
				toTarget(f)
			else
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
				wait(3)
			end
		elseif t.Character.Humanoid.Sit then
			local f, R, m =
				CFrame.new(-118834.515625, 160, -78.9505844116211) * CFrame.new(0, 0, 99999999),
				CFrame.new(-32975.9921875, 160, 25963.7109375),
				(function() if Settings["Will Back When over 10km"] then return (function() if DistanceFindLeviathan() >= 12000 then return true else return (function() if DistanceFindLeviathan() <= 4800 then return false else return false end end)() end end)() else return false end end)()
			repeat
				task.wait(0.5)
				NoclipBoat(g)
				if Settings["Will Back When over 10km"] then
					m = (function() if DistanceFindLeviathan() >= 10000 then return true else return (function() if DistanceFindLeviathan() <= 4800 then return false else return m end end)() end end)()
					if m then
						manageTween(g.VehicleSeat, R, 350, "TweenBoatBack")
					end
				end
				if not m or not Settings["Will Back When over 10km"] then
					manageTween(g.VehicleSeat, f, 350, "TweenBoat")
				end
			until not Settings["Auto Find Prehistoric Island"]
				or not t.Character.Humanoid.Sit
				or (game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland"))
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
			toTarget(g.VehicleSeat.CFrame)
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
		A.CreateNoti({ Title = "Noijo Hub", Desc = "Prehistoric Island Spawned", ShowTime = 5 })
		ToggleAutoFindPrehistoricIsland:SetStage(false)
		wait(5)
	end
end
ToggleAutoFindPrehistoricIsland = FarmingVolcanoSection.CreateToggle(
	{ Title = "Auto Find Prehistoric Island", Desc = nil, Default = Settings["Auto Find Prehistoric Island"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Find Prehistoric Island"] and (wait(0.1)) do
					pcall(function()
						AutoFindPrehistoric()
					end)
				end
			end)
		end
		SaveSettings("Auto Find Prehistoric Island", g)
	end
)
function AutoAttackVolcano()
	if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
		if not t:GetAttribute("CurrentLocation") or t:GetAttribute("CurrentLocation") ~= "Prehistoric Island" then
			local g = DetectNpc("Fossil Expert")
			if g then
				toTarget(g.HumanoidRootPart.CFrame)
				return
			end
		end
		if DetectLava() then
			local g, f, R = next, workspace.Map.PrehistoricIsland:GetDescendants()
			for m, m in g, f, R do
				if m.Name == "TouchInterest" and m.Parent.Name ~= "TrialTeleport" then
					m:Destroy()
				end
			end
		end
		if #workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren() > 0 then
			DeleteLava()
		end
		if
			not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
			and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
		then
			if
				workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")
				and (workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt"))
			then
				toTarget(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)
				if t:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.Position) < 8 then
					fireproximityprompt(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt, 1)
					wait(3)
				end
				return
			elseif
				not workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")
				and not workspace.Map.PrehistoricIsland.Core:FindFirstChild("FossilExpertSpawn")
			then
				local g = DetectNpc("Fossil Expert")
				if g then
					toTarget(g.HumanoidRootPart.CFrame)
					return
				end
			end
		else
			if b then
				local g = workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull
				repeat
					task.wait()
					toTarget(g.CFrame)
				until t:DistanceFromCharacter(g.Position) <= 200 or (DetectGolem()) or (DetectRockVolcano())
				b = false
				return
			end
			local g = DetectGolem()
			if g then
				repeat
					task.wait()
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(0, 20, 7))
					if Settings["Select Method Kill Golem"] == "Instant Kill [ Risk and can bug no die mob ]" then
						if t:DistanceFromCharacter(g.HumanoidRootPart.Position) < 50 then
							KillRaidEnemy()
						end
					else
						equiptool(NameWeapon(Settings["Select Weapon Kill Golem"] or "Melee"))
						getgenv().ClickM1Volcano(g)
					end
					if not getgenv().KillMobRaid and Settings["Kill Aura Only Raid And Volcano"] then
						getgenv().KillMobRaid = true
						local f = Settings["Time Delay Kill"] or 5
						g.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
						delay(f, function()
							getgenv().KillMobRaid = false
						end)
					end
				until not IsMobAlive(g) or not Settings["Auto Event Prehistoric Island"]
			end
			g = DetectRockVolcano()
			if g then
				if Settings["Fix Volcano Safe"] then
					local f = DetectPositionVolcano()
					local R, R = CheckPosnearRock(f, t.Character.HumanoidRootPart)
					if t:DistanceFromCharacter((CheckPosnearRock(f, g.WorldPivot))) >= 400 then
						s = R + 1
						if R >= 7 then
							s = 1
						end
						local R = f[s]
						toTarget(CFrame.new(R))
					else
						local f = X[math.floor(g.WorldPivot.Position.Y)]
						repeat
							task.wait()
							if t:DistanceFromCharacter((g.WorldPivot * f).Position) > 8 then
								toTarget(g.WorldPivot * f)
							end
							if t:DistanceFromCharacter(g.WorldPivot.Position) < 100 then
								AutoUseSkillFixLava()
							end
							getgenv().AimPos = g.WorldPivot
							local R = workspace.CurrentCamera
							G.Hit = g.WorldPivot
							G.Target = g
						until not g
							or not g.Parent
							or not Settings["Auto Event Prehistoric Island"]
							or not g.VFXLayer.Specs.Enabled
							or (DetectGolem())
						f = DetectGolem()
						if not f then
							b = true
						end
						wait(1)
					end
				else
					local f = X[math.floor(g.WorldPivot.Position.Y)]
					repeat
						task.wait()
						if t:DistanceFromCharacter((g.WorldPivot * f).Position) > 8 then
							toTarget(g.WorldPivot * f)
						end
						if t:DistanceFromCharacter(g.WorldPivot.Position) < 100 then
							AutoUseSkillFixLava()
						end
						getgenv().AimPos = g.WorldPivot
						local R = workspace.CurrentCamera
						G.Hit = g.WorldPivot
						G.Target = g
					until not g
						or not g.Parent
						or not Settings["Auto Event Prehistoric Island"]
						or not g.VFXLayer.Specs.Enabled
						or (DetectGolem())
					f = DetectGolem()
					if not f then
						b = true
					end
				end
			end
		end
	end
end
FarmingVolcanoSection.CreateToggle(
	{
		Title = "Auto Event Prehistoric Island",
		Desc = "auto Start Event and Auto kill golem, Auto Fix Volcano",
		Default = Settings["Auto Event Prehistoric Island"] or false,
	},
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Event Prehistoric Island"] and (wait(0.1)) do
					local f, f = pcall(function()
						AutoAttackVolcano()
					end)
					if f then
						print(f)
					end
				end
			end)
		end
		SaveSettings("Auto Event Prehistoric Island", g)
	end
)
function DetectBone()
	for g, g in game.workspace:GetChildren() do
		if g.Name == "DinoBone" then
			return g
		end
	end
end
FarmingVolcanoSection.CreateToggle(
	{ Title = "Auto Collect Bone", Desc = nil, Default = Settings["Auto Collect Bone"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Collect Bone"] and (wait()) do
					pcall(function()
						local f = DetectBone()
						if
							f
							and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
							and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
						then
							toTarget(f.CFrame)
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Collect Bone", g)
	end
)
function DetectDragonEggs()
	if #workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetChildren() > 0 then
		for g, g in workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetChildren() do
			if
				g.Name == "DragonEgg"
				and (g:FindFirstChild("Molten"))
				and (g.Molten:FindFirstChild("ProximityPrompt"))
			then
				return g
			end
		end
	end
end
FarmingVolcanoSection.CreateToggle(
	{ Title = "Auto Collect Egg", Desc = nil, Default = Settings["Auto Collect Egg"] or false },
	function(g)
		if g then
			spawn(function()
				while Settings["Auto Collect Egg"] and (wait()) do
					pcall(function()
						local f = DetectDragonEggs()
						if f then
							if DetectBone() and Settings["Auto Collect Bone"] then
								return
							end
							toTarget(f.Molten.CFrame)
							if t:DistanceFromCharacter(f.Molten.Position) < 8 then
								fireproximityprompt(f.Molten.ProximityPrompt)
							end
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Collect Egg", g)
	end
)
function FullyEventVolcano()
	if not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
		getgenv().RespawnVolcano = true
		getgenv().turnoffnoclipBoatt = true
		if not CheckItemInventory("Volcanic Magnet") and not Settings["Ignore Craft Volcanic Magnet"] then
			if getgenv().dacoMagnet then
				local g = tick()
				repeat
					wait()
				until tick() - g >= 5 or (game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland"))
				getgenv().dacoMagnet = false
				return
			end
			if not CheckCountItem("Scrap Metal", 10) then
				local g = { "Jungle Pirate", "Musketeer Pirate" }
				local f = DetectMob(g)
				if not f then
					if typeof(g) == "table" then
						if #N >= #g then
							N = {}
							return
						end
						local R = DetectPartSpawnMob(DetectNameTablePart(g))
						if R then
							table.insert(N, DetectNameTablePart(g))
							repeat
								wait()
								toTarget(R.CFrame * CFrame.new(0, 60, 0))
							until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
								or (DetectMob(g))
								or not Settings["Fully Event Prehistoric Island"]
							wait(1)
						end
					end
				else
					repeat
						task.wait()
						sizepart(f)
						BringMob(f)
						UsedualFlock()
						ClickM1(f)
						toTarget(f.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					until not IsMobAlive(f) or not Settings["Fully Event Prehistoric Island"]
				end
				return
			elseif not CheckCountItem("Blaze Ember", 15) then
				local g = workspace.NPCs:FindFirstChild("Dragon Hunter")
					or (game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Hunter"))
					or NPCManager.getNPCsByName("Dragon Hunter")[1]._modelState._instance
				if not getgenv().QuestHunterDragon then
					if t:DistanceFromCharacter(g.HumanoidRootPart.Position) > 8 then
						toTarget(g.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
					else
						local g = game:GetService("ReplicatedStorage")
							:WaitForChild("Modules")
							:WaitForChild("Net")
							:WaitForChild("RF/DragonHunter")
							:InvokeServer(unpack({ [1] = { Context = "Check" } }))
						if not g or g and not g.Text then
							getgenv().QuestHunterDragon = game:GetService("ReplicatedStorage")
								:WaitForChild("Modules")
								:WaitForChild("Net")
								:WaitForChild("RF/DragonHunter")
								:InvokeServer(unpack({ [1] = { Context = "RequestQuest" } })).Text
						else
							getgenv().QuestHunterDragon = g.Text
						end
					end
				else
					local g = DetectEmberTemplate()
					if g then
						Instance.new("IntValue", g).Name = "Ignored"
						repeat
							wait()
							toTarget(g.Part.CFrame)
						until not g or not g.Parent
						return
					end
					if string.find(getgenv().QuestHunterDragon, "Hydra Enforcers") then
						local f = DetectMob("Hydra Enforcer")
						if not f then
							local R = DetectPartSpawnMob("Hydra Enforcer", true)
							if R then
								Instance.new("IntValue", R).Name = "Ignored"
								repeat
									wait()
									toTarget(R.CFrame * CFrame.new(0, 60, 0))
								until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
									or (DetectMob("Hydra Enforcer"))
									or not Settings["Fully Event Prehistoric Island"]
									or g
								wait(1)
							else
								DeleteIgnoredMobSpawn()
							end
						else
							repeat
								task.wait()
								sizepart(f)
								BringMob(f)
								UsedualFlock()
								ClickM1(f)
								if Settings["Select Weapon"] == "Blox Fruit" then
									toTarget(f.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									toTarget(f.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end
							until not IsMobAlive(f) or not Settings["Fully Event Prehistoric Island"] or g
						end
					elseif string.find(getgenv().QuestHunterDragon, "Venomous Assailants") then
						local f = DetectMob("Venomous Assailant")
						if not f then
							local R = DetectPartSpawnMob("Venomous Assailant", true)
							if R then
								Instance.new("IntValue", R).Name = "Ignored"
								repeat
									wait()
									toTarget(R.CFrame * CFrame.new(0, 60, 0))
								until (R.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
									or (DetectMob("Venomous Assailant"))
									or not Settings["Fully Event Prehistoric Island"]
									or g
								wait(1)
							else
								DeleteIgnoredMobSpawn()
							end
						else
							repeat
								task.wait()
								sizepart(f)
								BringMob(f)
								UsedualFlock()
								ClickM1(f)
								toTarget(f.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
							until not IsMobAlive(f) or not Settings["Fully Event Prehistoric Island"] or g
						end
					elseif string.find(getgenv().QuestHunterDragon, "trees") then
						local f, R = workspace.CurrentCamera, DetectTree()
						if R then
							Instance.new("IntValue", R).Name = "Ignored"
							local m = tick()
							repeat
								wait()
								local E = R.WorldPivot.Position
								if t:DistanceFromCharacter(E) < 50 then
									AutoAllSkill()
								end
								if R:FindFirstChild("Meshes/plant1_Icosphere", true) then
									toTarget(R.WorldPivot)
									getgenv().AimPos = R.WorldPivot
									G.Hit = CFrame.new(f.CFrame.Position, E)
									G.Target = R
								else
									local E, l =
										(R.WorldPivot * CFrame.new(5, -20, 0)).Position,
										(R.WorldPivot * CFrame.new(0, -20, 0)).Position
									toTarget(CFrame.new(E))
									getgenv().AimPos = CFrame.new(l)
									G.Hit = CFrame.new(f.CFrame.Position, l)
									G.Target = R
								end
							until not R
								or not R.Parent
								or not Settings["Fully Event Prehistoric Island"]
								or g
								or (R:GetAttribute("AlreadyDestroyedClient"))
								or tick() - m >= 15
						end
					end
				end
				return
			end
			if CheckCountItem("Scrap Metal", 10) and (CheckCountItem("Blaze Ember", 15)) then
				game:GetService("ReplicatedStorage").Modules.Net
					:FindFirstChild("RF/Craft")
					:InvokeServer(unpack({ [1] = "Craft", [2] = "Volcanic Magnet", [3] = 1, [4] = {} }))
				wait(2)
			end
		else
			getgenv().dacoMagnet = true
			if
				not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
				and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
				and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
			then
				local g = checkboat()
				if not g or g and t:DistanceFromCharacter(g.VehicleSeat.Position) >= 4000 then
					local f = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)
					if (f.Position - t.Character.HumanoidRootPart.Position).Magnitude > 8 then
						if (f.Position - t.Character.HumanoidRootPart.Position).Magnitude > 1000 then
							if
								not t:GetAttribute("CurrentLocation")
								or t:GetAttribute("CurrentLocation") ~= "Tiki Outpost"
							then
								if
									game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki"
									or game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == "Tiki2"
								then
									t.Character.Humanoid.Health = 0
									return
								end
							end
						end
						toTarget(f)
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
						wait(3)
					end
				elseif t.Character.Humanoid.Sit then
					task.spawn(function()
						NoclipBoat(g)
					end)
					local f = CFrame.new(-118834.515625, g.WorldPivot.Y, -78.9505844116211) * CFrame.new(0, 0, 99999999)
					manageTween(g.VehicleSeat, f, 350, "TweenBoat")
				else
					if getgenv().TweenBoat then
						getgenv().TweenBoat:Pause()
						getgenv().TweenBoat:Cancel()
					end
					toTarget(g.VehicleSeat.CFrame)
				end
			end
		end
	else
		if getgenv().turnoffnoclipBoatt then
			getgenv().turnoffnoclipBoatt = false
			local g = checkboat()
			if g then
				TurnOffNoclipBoat(g)
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
		if not t:GetAttribute("CurrentLocation") or t:GetAttribute("CurrentLocation") ~= "Prehistoric Island" then
			local g = DetectNpc("Fossil Expert")
			if g then
				toTarget(g.HumanoidRootPart.CFrame)
				return
			end
		end
		local g = DetectDragonEggs()
		if g then
			toTarget(g.Molten.CFrame)
			if t:DistanceFromCharacter(g.Molten.Position) < 8 then
				fireproximityprompt(g.Molten.ProximityPrompt)
			end
			return
		end
		if not Settings["Ignore Collect Bone"] then
			g = DetectBone()
			if
				g
				and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
				and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
			then
				toTarget(g.CFrame)
				return
			end
		end
		if
			t:GetAttribute("CurrentLocation") == "Prehistoric Island"
			and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
			and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
			and getgenv().CanReset
		then
			g = tick()
			repeat
				wait()
			until tick() - g >= 10
				or not Settings["Fully Event Prehistoric Island"]
				or DetectBone() and not Settings["Ignore Collect Bone"]
				or (DetectDragonEggs())
			if
				Settings["Fully Event Prehistoric Island"]
				and not DetectDragonEggs()
				and (not DetectBone() and not Settings["Ignore Collect Bone"] or Settings["Ignore Collect Bone"])
			then
				t.Character.Humanoid.Health = 0
				getgenv().CanReset = false
			end
		end
		if DetectLava() then
			local f, R, m = next, workspace.Map.PrehistoricIsland:GetDescendants()
			for E, E in f, R, m do
				if E.Name == "TouchInterest" and E.Parent.Name ~= "TrialTeleport" then
					E:Destroy()
				end
			end
		end
		if #workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren() > 0 then
			DeleteLava()
		end
		if
			not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
			and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
		then
			if
				workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")
				and (workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt"))
			then
				toTarget(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)
				if t:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.Position) < 8 then
					fireproximityprompt(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt, 1)
					wait(3)
				end
				return
			elseif
				not workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")
				and not workspace.Map.PrehistoricIsland.Core:FindFirstChild("FossilExpertSpawn")
			then
				g = DetectNpc("Fossil Expert")
				if g then
					toTarget(g.HumanoidRootPart.CFrame)
					return
				end
			end
		else
			getgenv().CanReset = true
			if b then
				local g = workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull
				repeat
					task.wait()
					toTarget(g.CFrame)
				until t:DistanceFromCharacter(g.Position) <= 200 or (DetectGolem()) or (DetectRockVolcano())
				b = false
				return
			end
			local g = DetectGolem()
			if g then
				repeat
					task.wait()
					toTarget(g.HumanoidRootPart.CFrame * CFrame.new(0, 20, 7))
					if Settings["Select Method Kill Golem"] == "Instant Kill [ Risk and can bug no die mob ]" then
						if t:DistanceFromCharacter(g.HumanoidRootPart.Position) < 50 then
							KillRaidEnemy()
						end
					else
						equiptool(NameWeapon(Settings["Select Weapon Kill Golem"] or "Melee"))
						getgenv().ClickM1Volcano(g)
					end
					if not getgenv().KillMobRaid and Settings["Kill Aura Only Raid And Volcano"] then
						getgenv().KillMobRaid = true
						local f = Settings["Time Delay Kill"] or 5
						g.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
						delay(f, function()
							getgenv().KillMobRaid = false
						end)
					end
				until not IsMobAlive(g) or not Settings["Fully Event Prehistoric Island"]
			end
			g = DetectRockVolcano()
			if g then
				if Settings["Fix Volcano Safe"] then
					local f = DetectPositionVolcano()
					local R, R = CheckPosnearRock(f, t.Character.HumanoidRootPart)
					if t:DistanceFromCharacter((CheckPosnearRock(f, g.WorldPivot))) >= 400 then
						s = R + 1
						if R >= 7 then
							s = 1
						end
						local R = f[s]
						toTarget(CFrame.new(R))
					else
						local s = X[math.floor(g.WorldPivot.Position.Y)]
						repeat
							task.wait()
							if t:DistanceFromCharacter((g.WorldPivot * s).Position) > 8 then
								toTarget(g.WorldPivot * s)
							end
							if t:DistanceFromCharacter(g.WorldPivot.Position) < 100 then
								AutoUseSkillFixLava()
							end
							getgenv().AimPos = g.WorldPivot
							local f = workspace.CurrentCamera
							G.Hit = g.WorldPivot
							G.Target = g
						until not g
							or not g.Parent
							or not Settings["Fully Event Prehistoric Island"]
							or not g.VFXLayer.Specs.Enabled
							or (DetectGolem())
						s = DetectGolem()
						if not s then
							b = true
						end
						wait(1)
					end
				else
					local s = X[math.floor(g.WorldPivot.Position.Y)]
					repeat
						task.wait()
						if t:DistanceFromCharacter((g.WorldPivot * s).Position) > 8 then
							toTarget(g.WorldPivot * s)
						end
						if t:DistanceFromCharacter(g.WorldPivot.Position) < 100 then
							AutoUseSkillFixLava()
						end
						getgenv().AimPos = g.WorldPivot
						local X = workspace.CurrentCamera
						G.Hit = g.WorldPivot
						G.Target = g
					until not g
						or not g.Parent
						or not Settings["Fully Event Prehistoric Island"]
						or not g.VFXLayer.Specs.Enabled
						or (DetectGolem())
					s = DetectGolem()
					if not s then
						b = true
					end
				end
			end
		end
	end
end
FullyVolcanoSection = VolcanoTab.CreateSection("Fully Volcano")
FullyVolcanoSection.CreateToggle(
	{
		Title = "Ignore Craft Volcanic Magnet [ Fully ]",
		Desc = nil,
		Default = Settings["Ignore Craft Volcanic Magnet"] or false,
	},
	function(b)
		SaveSettings("Ignore Craft Volcanic Magnet", b)
	end
)
FullyVolcanoSection.CreateToggle(
	{ Title = "Ignore Collect Bone [ Fully ]", Desc = nil, Default = Settings["Ignore Collect Bone"] or false },
	function(b)
		SaveSettings("Ignore Collect Bone", b)
	end
)
FullyVolcanoSection.CreateToggle(
	{
		Title = "Fully Event Prehistoric Island",
		Desc = nil,
		Default = Settings["Fully Event Prehistoric Island"] or false,
	},
	function(b)
		if b then
			spawn(function()
				while Settings["Fully Event Prehistoric Island"] and (task.wait()) do
					local s, s = pcall(function()
						FullyEventVolcano()
					end)
					if s then
						print(s)
					end
				end
			end)
		end
		SaveSettings("Fully Event Prehistoric Island", b)
	end
)
ESPTab = Main.CreatePage({ Page_Name = "ESP", Page_Title = "ESP Tab" })
ESPSection = ESPTab.CreateSection("ESP")
function EspSpawnBerry()
	local b, s = DetectBerryESP()
	if b then
		local X = Instance.new("IntValue", b.Parent)
		X.Name = "Ignored"
		local g = Drawing.new("Text")
		g.Visible = false
		g.Transparency = 1
		g.Text = b.Name
		g.Color = Color3.fromRGB(255, 255, 255)
		g.Size = 20
		g.Outline = true
		g.OutlineColor = Color3.fromRGB(0, 0, 0)
		g.Center = true
		g.Font = 1
		spawn(function()
			repeat
				task.wait()
				local f, R = game.workspace.CurrentCamera:WorldToViewportPoint(b.Parent.WorldPivot.Position)
				if R then
					g.Text = s .. " (" .. math.round(t:DistanceFromCharacter(b.Parent.WorldPivot.Position)) .. ")"
					g.Position = Vector2.new(f.X, f.Y - 20)
					g.Visible = true
				else
					g.Visible = false
				end
			until not b or not b.Parent or not Settings["ESP Berry"] or not DetectBerryCFrame(b:GetAttributes())
			g:Remove()
			if b.Parent then
				X:Destroy()
			end
		end)
	end
end
ESPSection.CreateToggle({ Title = "ESP Berry", Desc = nil, Default = Settings["ESP Berry"] or false }, function(b)
	if b then
		spawn(function()
			while Settings["ESP Berry"] and (wait(0.2)) do
				pcall(function()
					EspSpawnBerry()
				end)
			end
		end)
	end
	SaveSettings("ESP Berry", b)
end)
function DetectIsland()
	local b, s, X = next, workspace._WorldOrigin.Locations:GetChildren()
	for g, g in b, s, X do
		if g and (g:GetAttribute("CFrame")) and not g:FindFirstChild("Ignored") then
			return g
		end
	end
end
function EspIsland()
	local b = DetectIsland()
	if b then
		local s = Instance.new("IntValue", b)
		s.Name = "Ignored"
		local X = Drawing.new("Text")
		X.Visible = false
		X.Transparency = 1
		X.Text = b.Name
		X.Color = Color3.fromRGB(255, 255, 255)
		X.Size = 20
		X.Outline = true
		X.OutlineColor = Color3.fromRGB(0, 0, 0)
		X.Center = true
		X.Font = 1
		spawn(function()
			repeat
				task.wait()
				local g, f = game.workspace.CurrentCamera:WorldToViewportPoint(b:GetAttribute("CFrame").Position)
				if f then
					X.Text = b.Name
						.. " ("
						.. math.round(t:DistanceFromCharacter(b:GetAttribute("CFrame").Position))
						.. ")"
					X.Position = Vector2.new(g.X, g.Y - 20)
					X.Visible = true
				else
					X.Visible = false
				end
			until not b or not b.Parent or not Settings["ESP Island"]
			X:Remove()
			if b.Parent then
				s:Destroy()
			end
		end)
	end
end
ESPSection.CreateToggle({ Title = "ESP Island", Desc = nil, Default = Settings["ESP Island"] or false }, function(b)
	if b then
		spawn(function()
			while Settings["ESP Island"] and (wait(0.2)) do
				pcall(function()
					EspIsland()
				end)
			end
		end)
	end
	SaveSettings("ESP Island", b)
end)
function GetEspFruit()
	local b, s, X = next, game.Workspace:GetChildren()
	for g, g in b, s, X do
		if
			(g:IsA("Tool") or (g:IsA("Model")))
			and (string.find(g.Name, "Fruit"))
			and not g.Handle:FindFirstChild("Ignored")
		then
			return g
		end
	end
end
local b = {
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
function GetFruitName(s, X)
	if s.ClassName == "Tool" then
		return s.Name
	end
	local g, f = "Fruit", {}
	for R, R in pairs(s:GetDescendants()) do
		if R:IsA("MeshPart") then
			table.insert(f, R.MeshId)
		end
	end
	if f then
		for R, m in pairs(b) do
			g = (function() if table.find(f, R) then return m else return g end end)()
		end
	end
	if g == "Fruit " then
		f = s:FindFirstChild("Fruit")
		g = (function() if f then return ((f:FindFirstChild("Retopo_Cube.001")) and "Spirit Fruit" or (function() if f:FindFirstChild("Gravity cube.026") then return ((f:FindFirstChild("Gravity cube.001")) and "Blizzard Fruit" or "Portal Fruit") else return ((f:FindFirstChild("Cube.011")) and "Rubber Fruit" or g) end end)()) else return g end end)()
	end
	return (function() if X then return "[Natural Spawn]\10" .. g else return g end end)()
end
function EspFruit()
	local b = GetEspFruit()
	if not b then
		return
	end
	local s, X = GetFruitName(b), b:FindFirstChild("Handle")
	if not X then
		return
	end
	local g = Instance.new("IntValue")
	g.Name = "Ignored"
	g.Parent = X
	local g, f =
		({
			["Leopard Fruit"] = Color3.fromRGB(255, 170, 0),
			["Dragon (East) Fruit"] = Color3.fromRGB(255, 0, 0),
			["Dragon (West) Fruit"] = Color3.fromRGB(255, 80, 80),
			["Kitsune Fruit"] = Color3.fromRGB(200, 100, 255),
			["Spirit Fruit"] = Color3.fromRGB(120, 200, 255),
			["Venom Fruit"] = Color3.fromRGB(180, 60, 200),
			["Dough Fruit"] = Color3.fromRGB(255, 220, 180),
			["Light Fruit"] = Color3.fromRGB(255, 255, 150),
		})[s] or (Color3.fromRGB(255, 255, 255)),
		Drawing.new("Text")
	f.Visible = false
	f.Transparency = 1
	f.Text = s
	f.Color = g
	f.Size = 20
	f.Outline = true
	f.OutlineColor = Color3.fromRGB(0, 0, 0)
	f.Center = true
	f.Font = 2
	local R = Drawing.new("Square")
	R.Visible = false
	R.Filled = true
	R.Color = Color3.fromRGB(0, 0, 0)
	R.Transparency = 0.4
	spawn(function()
		repeat
			task.wait()
			if X then
				local m, E = workspace.CurrentCamera:WorldToViewportPoint(X.Position)
				if E then
					f.Text = s .. " [" .. math.round(t:DistanceFromCharacter(X.Position)) .. "m]"
					f.Position = Vector2.new(m.X, m.Y - 20)
					f.Color = g
					f.Visible = true
					local s = f.TextBounds
					R.Position = Vector2.new(f.Position.X - s.X / 2 - 4, f.Position.Y - 2)
					R.Size = Vector2.new(s.X + 8, s.Y + 4)
					R.Visible = true
				else
					f.Visible = false
					R.Visible = false
				end
			end
		until not b or not b.Parent or not X.Parent or not Settings["ESP Fruit"]
		f:Remove()
		R:Remove()
		if X:FindFirstChild("Ignored") then
			X.Ignored:Destroy()
		end
	end)
end
ESPSection.CreateToggle({ Title = "ESP Fruit", Desc = nil, Default = Settings["ESP Fruit"] or false }, function(b)
	if b then
		spawn(function()
			while Settings["ESP Fruit"] and (wait()) do
				local s, s = pcall(function()
					EspFruit()
				end)
				if s then
					print(s)
				end
			end
		end)
	end
	SaveSettings("ESP Fruit", b)
end)
function DetectPlayerESP()
	for b, b in pairs(game.Workspace.Characters:GetChildren()) do
		if b.Name ~= t.Name and not b:FindFirstChild("Ignored") then
			return b
		end
	end
end
function ESPPlayer()
	local b = DetectPlayerESP()
	if b then
		local s = Instance.new("IntValue", b)
		s.Name = "Ignored"
		local X = Drawing.new("Text")
		X.Visible = false
		X.Transparency = 1
		X.Text = b.Name
		X.Color = Color3.fromRGB(255, 255, 255)
		X.Size = 20
		X.Outline = true
		X.OutlineColor = Color3.fromRGB(0, 0, 0)
		X.Center = true
		X.Font = 1
		spawn(function()
			repeat
				task.wait()
				local g, f = game.workspace.CurrentCamera:WorldToViewportPoint(b.HumanoidRootPart.Position)
				if f then
					X.Text = b.Name
						.. " ("
						.. math.round(t:DistanceFromCharacter(b.HumanoidRootPart.Position))
						.. ")"
						.. "\10"
						.. b.Humanoid.Health
						.. " / "
						.. b.Humanoid.MaxHealth
					X.Position = Vector2.new(g.X, g.Y - 20)
					X.Visible = true
				else
					X.Visible = false
				end
			until not b or not b.Parent or not Settings["ESP Player"]
			X:Remove()
			if b.Parent then
				s:Destroy()
			end
		end)
	end
end
ESPSection.CreateToggle({ Title = "ESP Player", Desc = nil, Default = Settings["ESP Player"] or false }, function(b)
	if b then
		spawn(function()
			while Settings["ESP Player"] and (wait()) do
				pcall(function()
					ESPPlayer()
				end)
			end
		end)
	end
	SaveSettings("ESP Player", b)
end)
PvpTab = Main.CreatePage({ Page_Name = "PVP", Page_Title = "PVP Tab" })
SettingsAimbotSection = PvpTab.CreateSection("PVP")
local b = SettingsAimbotSection.CreateDropdown(
	{
		Title = "Select Player PVP",
		List = DetectNamePlayer(),
		Search = true,
		Selected = false,
		Default = Settings["Select Player PVP"] or nil,
	},
	function(s)
		SaveSettings("Select Player PVP", s)
	end
)
SettingsAimbotSection.CreateDropdown(
	{
		Title = "Select Method Aimbot",
		List = { "Select Player", "Target nearest Player" },
		Search = true,
		Selected = false,
		Default = Settings["Select Method Aimbot"] or nil,
	},
	function(s)
		SaveSettings("Select Method Aimbot", s)
	end
)
SettingsAimbotSection.CreateButton({ Title = "Refresh Player" }, function()
	b:GetNewList(DetectNamePlayer())
end)
function TeleportPlayer()
	for b, b in pairs(game:GetService("Players"):GetChildren()) do
		if b.Name == Settings["Select Player PVP"] then
			return b
		end
	end
end
SettingsAimbotSection.CreateToggle(
	{ Title = "Teleport Player", Desc = nil, Default = Settings["Teleport Player"] or false },
	function(b)
		if b then
			spawn(function()
				while Settings["Teleport Player"] and (wait()) do
					pcall(function()
						toTarget(TeleportPlayer().Character.HumanoidRootPart.CFrame)
					end)
				end
			end)
		end
		SaveSettings("Teleport Player", b)
	end
)
function ClosestPartaimbot()
	local b, s = 1 / 0
	for X, g in pairs(game.Workspace.Characters:GetChildren()) do
		if g:IsA("Model") then
			if
				g.Name ~= t.Name
				and (
					game.Players.LocalPlayer.Team == game.Teams.Marines
						and game.Players[g.Name].Team ~= game.Teams.Marines
					or game.Players.LocalPlayer.Team ~= game.Teams.Marines
				)
			then
				X = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - g.HumanoidRootPart.Position).Magnitude
				if X < b then
					b, s = X, g
				end
			end
		end
	end
	return s
end
SettingsAimbotSection.CreateToggle(
	{ Title = "Auto Aimbot", Desc = nil, Default = Settings["Auto Aimbot"] or false },
	function(b)
		if b then
			spawn(function()
				while Settings["Auto Aimbot"] and (task.wait()) do
					pcall(function()
						if Settings["Select Method Aimbot"] == "Select Player" then
							local s, s =
								workspace.CurrentCamera, game.Workspace.Characters[Settings["Select Player PVP"]]
							G.Hit = s.HumanoidRootPart.CFrame
							G.Target = s
							getgenv().AimPos = CFrame.new(
								s.HumanoidRootPart.CFrame.p,
								s.HumanoidRootPart.Position + s.HumanoidRootPart.Velocity / 0.5
							)
						else
							local s, s = workspace.CurrentCamera, ClosestPartaimbot()
							G.Hit = s.HumanoidRootPart.CFrame
							G.Target = s
							getgenv().AimPos = CFrame.new(
								s.HumanoidRootPart.CFrame.p,
								s.HumanoidRootPart.Position + s.HumanoidRootPart.Velocity / 0.5
							)
						end
					end)
				end
			end)
		end
		SaveSettings("Auto Aimbot", b)
	end
)
SettingsAimbotSection.CreateToggle(
	{ Title = "Auto Aimbot Gun", Desc = nil, Default = Settings["Auto Aimbot Gun"] or false },
	function(b)
		SaveSettings("Auto Aimbot Gun", b)
	end
)
local b = require(game:GetService("ReplicatedStorage").Modules.CombatUtil).GetTargetPosition
require(game:GetService("ReplicatedStorage").Modules.CombatUtil).GetTargetPosition = function(s, X, g, f, R)
	if Settings["Auto Aimbot Gun"] then
		local m = (function() if Settings["Select Method Aimbot"] == "Select Player" then return game.Workspace.Characters[Settings["Select Player PVP"]] else return (ClosestPartaimbot()) end end)()
		if m and (m:FindFirstChild("HumanoidRootPart")) then
			return m.HumanoidRootPart.Position
		end
	end
	return b(s, X, g, f, R)
end
MISCPVPSection = PvpTab.CreateSection("MISC PVP")
MISCPVPSection.CreateSlider(
	{ Title = "Input WalkSpeed", Min = 0, Max = 500, Default = Settings["Input WalkSpeed"] or 200, Precise = true },
	function(b)
		SaveSettings("Input WalkSpeed", b)
	end
)
MISCPVPSection.CreateSlider(
	{ Title = "Input JumpPower", Min = 0, Max = 500, Default = Settings["Input JumpPower"] or 200, Precise = true },
	function(b)
		SaveSettings("Input JumpPower", b)
	end
)
MISCPVPSection.CreateToggle(
	{ Title = "Change JumpPower", Desc = nil, Default = Settings["Change JumpPower"] or false },
	function(b)
		SaveSettings("Change JumpPower", b)
	end
)
MISCPVPSection.CreateToggle(
	{ Title = "Change WalkSpeed", Desc = nil, Default = Settings["Change WalkSpeed"] or false },
	function(b)
		SaveSettings("Change WalkSpeed", b)
	end
)
MISCPVPSection.CreateToggle(
	{ Title = "Walk On Water", Desc = nil, Default = Settings["Walk On Water "] or true },
	function(b)
		if b then
			if not game.Workspace:FindFirstChild("WaterWalk") then
				platform = Instance.new("Part")
				platform.Name = "WaterWalk"
				platform.Size = Vector3.new(1 / 0, 1, 1 / 0)
				platform.Transparency = 1
				platform.Anchored = true
				platform.Parent = game.workspace
			end
			spawn(function()
				while Settings["Walk On Water "] and (task.wait()) do
					pcall(function()
						if t.Character.Humanoid.Sit then
							platform.CanCollide = false
							return
						end
						if
							(Vector3.new(
								0,
								game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y,
								0
							) - Vector3.new(0, -60, 0)).Magnitude > 60
						then
							platform.CanCollide = false
							return
						end
						platform.CanCollide = true
						platform.Position = Vector3.new(
							game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.X,
							game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Y * 0 - 5,
							game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Z
						)
					end)
				end
			end)
		end
		SaveSettings("Walk On Water ", b)
	end
)
-- Webhook UI and sender functions intentionally removed from this build.
for key in pairs(Settings) do
    if tostring(key):lower():find("webhook", 1, true) or tostring(key):lower():find("discord ping", 1, true) then
        Settings[key] = nil
    end
end
getgenv().WebhookStoreFruit = function() end
getgenv().WebhookFindVolcano = function() end
getgenv().WebhookFindLeviathan = function() end
getgenv().WebhookFindMirage = function() end
getgenv().WebhookDestroyIdk = function() end
function Webhookprofile() end
function get_webhook_url() return nil end
function get_ping_tag() return "" end
SettingPage = Main.CreatePage({ Page_Name = "Setting", Page_Title = "Setting Tab" })
a = SettingPage.CreateSection("Settings")
a.CreateToggle({ Title = "White Screen", Desc = nil, Default = Settings["White Screen"] or false }, function(b)
	if not b then
		game:GetService("RunService"):Set3dRenderingEnabled(true)
	else
		game:GetService("RunService"):Set3dRenderingEnabled(false)
	end
	SaveSettings("White Screen", b)
end)
a.CreateToggle({ Title = "Black Screen", Desc = nil, Default = Settings["Black Screen"] or false }, function(b)
	spawn(function()
		repeat
			wait()
		until K
		if not b then
			K.Visible = false
			game:GetService("RunService"):Set3dRenderingEnabled(true)
			SetRobloxGUI(true)
		else
			K.Visible = true
			game:GetService("RunService"):Set3dRenderingEnabled(false)
			SetRobloxGUI(false)
		end
	end)
	SaveSettings("Black Screen", b)
end)
local function b(s)
	if type(s) ~= "table" then
		return s
	end
	local function key(k)
		if type(k) == "number" or type(k) == "boolean" then
			return "[" .. tostring(k) .. "]"
		end
		return string.format("[%q]", tostring(k))
	end
	local function ser(v, depth)
		local pad = string.rep("\t", depth)
		local out = {}
		for k, val in pairs(v) do
			local rhs
			if type(val) == "table" then
				rhs = ser(val, depth + 1)
			elseif type(val) == "number" or type(val) == "boolean" then
				rhs = tostring(val)
			else
				rhs = string.format("%q", tostring(val))
			end
			table.insert(out, pad .. "\t" .. key(k) .. " = " .. rhs)
		end
		if #out == 0 then
			return "{}"
		end
		return "{\n" .. table.concat(out, ",\n") .. "\n" .. pad .. "}"
	end
	return "getgenv().Config = " .. ser(s, 0)
end
a.CreateToggle(
	{ Title = "Remove Notifications", Desc = nil, Default = Settings["Remove Notifications"] or false },
	function(T)
		SaveSettings("Remove Notifications", T)
	end
)
DisplayNoti = getupvalues(require(game:GetService("ReplicatedStorage").Notification).Display)[1]
spawn(function()
	repeat
		wait(1)
	until Settings["Remove Notifications"]
	require(game:GetService("ReplicatedStorage").Notification).Dead = function(T)
		if Settings["Remove Notifications"] then
			return true
		else
			return tick() - T.CreationTime > T.Duration
		end
	end
	require(game:GetService("ReplicatedStorage").Notification).Display = function(T)
		if Settings["Remove Notifications"] then
			return true
		elseif T.Displayed then
			return false
		else
			T.Displayed = true
			T.CreationTime = tick()
			T.Label.Visible = true
			DisplayNoti:Add(T)
			return true
		end
	end
end)
a.CreateToggle(
	{ Title = "Auto rejoin Disconnect", Desc = nil, Default = Settings["Auto rejoin Disconnect"] or false },
	function(T)
		SaveSettings("Auto rejoin Disconnect", T)
	end
)
a.CreateToggle({ Title = "Auto Load Script", Desc = nil, Default = Settings["Auto Load Script"] or false }, function(T)
	SaveSettings("Auto Load Script", T)
end)
a.CreateToggle({ Title = "Boost Fps", Desc = nil, Default = Settings["Boost Fps"] or false }, function(T)
	if T then
		local s, X = true, game
		local g, f = X.Workspace, X.Lighting
		local K = g.Terrain
		K.WaterWaveSize = 0
		K.WaterWaveSpeed = 0
		K.WaterReflectance = 0
		K.WaterTransparency = 0
		f.GlobalShadows = false
		f.FogEnd = 9000000000
		f.Brightness = 0
		settings().Rendering.QualityLevel = "Level01"
		for R, R in pairs(X:GetDescendants()) do
			if R:IsA("Part") or (R:IsA("Union")) or (R:IsA("CornerWedgePart")) or (R:IsA("TrussPart")) then
				R.Material = "Plastic"
				R.Reflectance = 0
			elseif R:IsA("Decal") or R:IsA("Texture") and s then
				R.Transparency = 1
			elseif R:IsA("ParticleEmitter") or R:IsA("Trail") then
				if R.Parent and R.Parent.Name ~= "RelicFire" then
					R.Lifetime = R:IsA("Trail") and 0 or NumberRange.new(0)
				end
			elseif R:IsA("Explosion") then
				R.BlastPressure = 1
				R.BlastRadius = 1
			elseif R:IsA("Fire") or (R:IsA("SpotLight")) or (R:IsA("Smoke")) or (R:IsA("Sparkles")) then
				R.Enabled = false
			elseif R:IsA("MeshPart") then
				R.Material = "Plastic"
				R.Reflectance = 0
				R.TextureID = "rbxassetid://10385902758728956"
			end
		end
		for R, R in pairs(f:GetChildren()) do
			if
				R:IsA("BlurEffect")
				or (R:IsA("SunRaysEffect"))
				or (R:IsA("ColorCorrectionEffect"))
				or (R:IsA("BloomEffect"))
				or (R:IsA("DepthOfFieldEffect"))
			then
				R.Enabled = false
			end
		end
		wait(1)
		s, g, X =
			workspace:WaitForChild("Map"), game.ReplicatedStorage:WaitForChild("Unloaded"), Enum.Material.SmoothPlastic
		f = s:GetDescendants()
		wait(0.5)
		K = g:GetDescendants()
		wait(0.5)
		local R, m, E = os.clock, task.wait, g.IsA
		local l, Q, S = R(), tick(), 0
		s = l
		for d, d in next, f, nil do
			if E(d, "BasePart") then
				d.Material = X
				S = S + (1)
				if R() - l > 0.008333333333333333 then
					g = "Working.. " .. S
					m()
					m()
					l = (R())
				end
			elseif d:IsA("Texture") and not d:GetAttribute("Offset") then
				d:Destroy()
			end
		end
		for g, f in next, K, nil do
			if E(f, "BasePart") then
				f.Material = X
				S = S + (1)
				if R() - l > 0.008333333333333333 then
					g = "Working.. " .. S
					m()
					m()
					l = (R())
				end
			elseif f:IsA("Texture") and not f:GetAttribute("Offset") then
				f:Destroy()
			end
		end
		pcall(function()
			game.Players.LocalPlayer.PlayerScripts.OptimizerClientActor:SendMessage("Optimize", true)
		end)
		print("Time taken to Fast Mode: ", tick() - Q, R() - s)
	end
	SaveSettings("Boost Fps", T)
end)
spawn(function()
	repeat
		wait()
	until Settings["Boost Fps"] and (game.Workspace:FindFirstChild("_WorldOrigin"))
	workspace._WorldOrigin.DescendantAdded:Connect(function(T)
		if T:IsA("Part") or (T:IsA("Union")) or (T:IsA("CornerWedgePart")) or (T:IsA("TrussPart")) then
			T.Transparency = 1
			T.Material = "Plastic"
			T.Reflectance = 0
		end
		if T:IsA("Decal") or T:IsA("Texture") and decalsyeeted then
			T.Transparency = 1
		end
		if T:IsA("ParticleEmitter") or (T:IsA("Trail")) then
			if T.Parent and T.Parent.Name ~= "RelicFire" then
				T.Enabled = false
				if T:IsA("ParticleEmitter") then
					T.Lifetime = NumberRange.new(0)
				end
			end
		end
		if T:IsA("Explosion") then
			T.Visible = false
			T.BlastPressure = 1
			T.BlastRadius = 1
		end
		if T:IsA("Fire") or (T:IsA("SpotLight")) or (T:IsA("Smoke")) or (T:IsA("Sparkles")) then
			T.Enabled = false
		end
		if T:IsA("MeshPart") then
			T.Transparency = 1
			T.Material = "Plastic"
			T.Reflectance = 0
			T.TextureID = "rbxassetid://10385902758728956"
		end
	end)
end)
a.CreateButton({ Title = "Copy Config" }, function()
	setclipboard(b((HttpService:JSONDecode(readfile(FolderName .. "/" .. SaveFileName)))))
	A.CreateNoti({ Title = "Noijo Hub", Desc = "Successfully Copy Config", ShowTime = 5 })
end)
a.CreateBind({ Title = "Toggle GUI", Key = Enum.KeyCode.LeftControl }, function()
	if getgenv().UIToggled == nil then
		getgenv().UIToggled = true
	end
	getgenv().UIToggled = not getgenv().UIToggled
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for T, T in ipairs(game.CoreGui:GetChildren()) do
			if T.Name == "Nousigi Hub GUI" then
				T.Enabled = getgenv().UIToggled
			end
		end
	end
end)
-- ===== AUTO LOAD SCRIPT: queue_on_teleport để tự chạy lại sau khi hop server / rejoin do disconnect =====
-- Không cần Key, không cần bỏ vào autoexec. Nguồn script (ưu tiên từ trên xuống):
--   1) getgenv().AutoLoadURL = "link raw script" (đặt trước khi chạy, nếu bạn chạy script bằng link)
--   2) bản copy script tự lưu ở "Noijo Hub/AutoLoad.lua" (tự lưu lúc chạy nếu executor cho đọc source)
--   3) loader gốc banana-hub (chỉ khi có Key)
spawn(function()
	pcall(function()
		local queue = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
		if not queue then
			warn("[AutoLoad] executor không hỗ trợ queue_on_teleport")
			return
		end
		local AUTO_FILE = FolderName .. "/AutoLoad.lua"

		-- tự lưu source của chính script này (best-effort, tuỳ executor có trả full source hay không)
		pcall(function()
			local src = debug.getinfo(1, "S").source
			if type(src) == "string" and #src > 100000 and src:find("Auto Load Script", 1, true) then
				if not isfolder(FolderName) then
					makefolder(FolderName)
				end
				writefile(AUTO_FILE, src)
			end
		end)

		local function body()
			local url = getgenv().AutoLoadURL
			if type(url) == "string" and #url > 0 then
				return string.format('loadstring(game:HttpGet(%q))()', url)
			end
			local okFile, hasFile = pcall(isfile, AUTO_FILE)
			if okFile and hasFile then
				return string.format('loadstring(readfile(%q))()', AUTO_FILE)
			end
			if getgenv().Key then
				return 'getgenv().__BANANA_SCRIPT_ROUTE = "bf_main"\nloadstring(game:HttpGet("https://banana-hub.xyz/loader/banana.lua"))()'
			end
			return nil
		end

		local queued = false
		while not queued do
			if Settings["Auto Load Script"] then
				local code = body()
				if code then
					local cfgPath = FolderName .. "/" .. SaveFileName
					local header = 'repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer\n'
						.. string.format(
							'local ok, cfg = pcall(function() return game:GetService("HttpService"):JSONDecode(readfile(%q)) end)\n',
							cfgPath
						)
						.. 'if ok and type(cfg) == "table" and cfg["Auto Load Script"] == false then return end\n' -- đã tắt toggle thì không chạy
					if getgenv().Key then
						header = header .. string.format("getgenv().Key = %q\n", getgenv().Key)
					end
					queue(header .. code)
					queued = true
					print("[AutoLoad] đã queue script cho lần hop / rejoin tiếp theo")
				else
					warn("[AutoLoad] chưa có nguồn script: đặt getgenv().AutoLoadURL = 'link raw' rồi chạy lại")
					task.wait(10)
				end
			end
			task.wait(1)
		end
	end)
end)
loadstring(
	'if getgenv().__BC_NAMECALL == game.JobId then return end\10getgenv().__BC_NAMECALL = game.JobId\10local MT = getrawmetatable(game)\10local OldNameCall = MT.__namecall\10setreadonly(MT, false)\10MT.__namecall = newcclosure(function(self, ...)\10 local Method = getnamecallmethod()\10 local Args = { ... }\10 if\10 Method == "FireServer"\10 and self.Name == "RemoteEvent"\10 and AimPos\10 and tostring(AimPos.X) ~= "nan"\10 and (\10 Settings["Auto Event Prehistoric Island"]\10 or Settings["Kill players When complete Trial"]\10 or Settings["Auto Quest Dragon Hunter"]\10 or Settings["Auto Quest Dojo Trainer"]\10 or Settings["Farm Mastery"]\10 or Settings["Auto Attack Leviathan"]\10 or Settings["Auto Sea Event"]\10 or Settings["Auto Upgrade Race V2-V3"]\10 or Settings["Auto Trial"]\10 or Settings["Auto Aimbot"]\10 or Settings["Auto Shipwright"]\10 )\10 then\10 if #Args == 1 and typeof(Args[1]) == "Vector3" then\10 Args[1] = AimPos.Position\10 end\10 if #Args == 1 and typeof(Args[1]) == "CFrame" then\10 Args[1] = AimPos\10 end\10 end\10 return OldNameCall(self, unpack(Args))\10end)\10setreadonly(MT, true)\10'
)()
x = game:GetService("RunService")

-- NOCLIP chay tren Stepped (truoc physics), doc lap voi phan con lai cua script
if not getgenv().__NOCLIP_STEPPED then
	getgenv().__NOCLIP_STEPPED = x.Stepped:Connect(function()
		local char = t.Character
		if not char then
			return
		end
		local ok, on = pcall(function()
			return Settings.Noclip or TweenManager.currentTween or ToggleNoclip()
		end)
		if ok and on then
			for _, p in ipairs(char:GetDescendants()) do
				if p:IsA("BasePart") and p.CanCollide then
					p.CanCollide = false
				end
			end
		end
	end)
end

-- require an toan: module nao game xoa/doi ten thi bo qua, khong lam chet script
local function safeRequire(getModule)
	local ok, res = pcall(function()
		return require(getModule())
	end)
	return ok and res or nil
end
local RS = game:GetService("ReplicatedStorage")
runAsync = safeRequire(function() return RS.Util.runAsync end)
Spinner = safeRequire(function() return RS.Controllers.UI.Spinner end)
SharedGachaUtil = safeRequire(function() return RS.Modules.Gacha.SharedGachaUtil end)
TextUtil = safeRequire(function() return RS.Modules.Util.TextUtil end)
if not getgenv().BananaCatMainLoop then
	getgenv().BananaCatMainLoop = true
	lastHopTick = tick()
	lastFruitTick = tick()
	x.RenderStepped:Connect(function()
		if getgenv().__BF_TELEPORTING then
			return
		end
		pcall(function()
			sethiddenproperty(t, "SimulationRadius", 5000)
		end)
		if tick() - lastHopTick >= 500 then
			lastHopTick = tick()
			pcall(function()
				writefile("Noijo Hub/Jobid.json", HttpService:JSONEncode({}))
			end)
		end
		pcall(function()
			if Settings["Auto Aimbot"] then
				local T = (function() if Settings["Select Method Aimbot"] == "Select Player" then return workspace.Characters[Settings["Select Player PVP"]] else return (ClosestPartaimbot()) end end)()
				if T and (T:FindFirstChild("HumanoidRootPart")) then
					local b = workspace.CurrentCamera
					G.Hit = T.HumanoidRootPart.CFrame
					G.Target = T
					getgenv().AimPos = CFrame.new(
						T.HumanoidRootPart.Position,
						T.HumanoidRootPart.Position + T.HumanoidRootPart.Velocity / 0.5
					)
				end
			end
			local T = t.Character:FindFirstChild("HumanoidRootPart")
			if T and (T:FindFirstChild("FloatForce")) and not TweenManager.currentTween then
				if not ToggleNoclip() or tick() - k.LastCall > 2 then
					TweenManager.CancelCurrent()
				end
			end
			if ToggleNoclip() or Settings.Noclip then
				local T, b, a = next, t.Character:GetDescendants()
				for s, s in T, b, a do
					if (s:IsA("MeshPart") or (s:IsA("Part"))) and s.CanCollide then
						s.CanCollide = false
					end
				end
			end
		end)
		task.spawn(function()
			if Settings["Change WalkSpeed"] then
				t.Character.Humanoid.WalkSpeed = Settings["Input WalkSpeed"] or 16
			end
			if Settings["Change JumpPower"] then
				t.Character.Humanoid.JumpPower = Settings["Input JumpPower"] or 50
			end
		end)
		if tick() - lastFruitTick >= 0.5 then
			lastFruitTick = tick()
			local T, T = pcall(function()
				if Settings["Random Devil Fruit"] then
					if getgenv().DebugGacha then
						local sw = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpinnerWindow")
						print("[Gacha] vòng lặp: toggle bật, SpinnerWindow =", sw ~= nil, sw and sw.Enabled)
					end
					if
						not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpinnerWindow")
						or not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpinnerWindow").Enabled
					then
						RandomFruit()
					elseif
						game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpinnerWindow").Enabled
						and game:GetService("Players").LocalPlayer.PlayerGui.SpinnerWindow.AboveSpinner.Navigation.CloseButton.Visible
					then
						Spinner:Close()
					end
				end
				if Settings["Auto Trade Bone"] then
					L.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
				end
				if Settings["Buy Blox Fruit Sniper Shop"] then
					BuyFruitShop()
				end
				if Settings["Auto Store Fruit"] then
					StoreFruit(t.Backpack)
					StoreFruit(t.Character)
				end
				if Settings["Auto Awake Fruit"] then
					L.Remotes.CommF_:InvokeServer("Awakener", "Check")
					L.Remotes.CommF_:InvokeServer("Awakener", "Awaken")
				end
				if Settings["Auto Buy Legendary Sword"] then
					L.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")
					if Settings["Hop Server [ Haki color or Legendary Sword]"] and CheckSwordLegendary then
						local b = CheckSwordLegendary()
						if b then
							SpecialHop(b)
						else
							A.CreateNoti({ Title = "Noijo Hub", Desc = "Full Sword Legendary", ShowTime = 5 })
						end
					end
				end
				if Settings["Auto Buy Haki Color"] then
					L.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
					if Settings["Hop Server [ Haki color or Legendary Sword]"] then
						HopServer()
					end
				end
			end)
			if T then
				print(T)
			end
		end
	end)
end
-- (da bo collectgarbage("collect") luc OnTeleport: full GC giua luc engine dang huy map cu gay crash)
getgenv().__BF_LOADED = game.JobId


-- Fluent config/interface integration
pcall(function()
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("LightHub")
    SaveManager:SetFolder("LightHub/BloxFruits")
    local settingTab = __tabs["Setting"] or __tabs["Settings"]
    if settingTab then
        InterfaceManager:BuildInterfaceSection(settingTab)
        SaveManager:BuildConfigSection(settingTab)
    end
    SaveManager:LoadAutoloadConfig()
end)
