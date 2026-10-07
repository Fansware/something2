--========================================================
-- FANSWARE EXECUTOR - TODO EN UNO (KEY SYSTEM + SCRIPT)
-- COMPATIBLE CON XENO
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--========================================================
-- 1. SISTEMA DE LLAVES (KEY SYSTEM)
--========================================================
local MasterKeys = {
    -- Tus llaves principales
    "yeahfreeformelol",
    "withlovekeyfriends",
    "withlovekeyfriends2",
    
    -- Llaves adicionales de Discord
    "fans_7f8a9b2c", "fans_3x4k9p1m", "fans_8q2w5z7y", "fans_1m6n4b8v", "fans_9p5l2k3j",
    "fans_4h7g1f6d", "fans_2c8x3z9w", "fans_6v1b5n7m", "fans_5j9k2l4p", "fans_3d8f6g1h",
    "fans_7w2q9e4r", "fans_1t5y8u3i", "fans_9o4p2l6k", "fans_8j3h5g7f", "fans_2d1s6a9z",
    "fans_4x7c3v2b", "fans_6n8m1k5j", "fans_9h2g4f7d", "fans_5s3a8z1x", "fans_7p6o5i4u"
}

local DiscordKeyLink = "https://discord.gg/FMnPMdCj2Z"

-- Limpiar interfaz anterior si existe
if CoreGui:FindFirstChild("ShooterKeySystem") then CoreGui.ShooterKeySystem:Destroy() end
if CoreGui:FindFirstChild("FanswareKiciaHook") then CoreGui.FanswareKiciaHook:Destroy() end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "ShooterKeySystem"
KeyGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(400, 220)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = KeyGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "AUTENTICACIÓN - FANSWARE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -40, 0, 45)
TextBox.Position = UDim2.fromOffset(20, 60)
TextBox.PlaceholderText = "Ingresa tu Key aquí..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TextBox.TextSize = 14
TextBox.Font = Enum.Font.Gotham
TextBox.Parent = MainFrame

local TextBoxCorner = Instance.new("UICorner")
TextBoxCorner.CornerRadius = UDim.new(0, 6)
TextBoxCorner.Parent = TextBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0, 170, 0, 35)
SubmitBtn.Position = UDim2.fromOffset(20, 120)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
SubmitBtn.Text = "Comprobar Key"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 13
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = SubmitBtn

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0, 170, 0, 35)
GetKeyBtn.Position = UDim2.fromOffset(210, 120)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
GetKeyBtn.Text = "Copiar Discord"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 13
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = MainFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 6)
GetKeyCorner.Parent = GetKeyBtn

GetKeyBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(DiscordKeyLink) end)
    GetKeyBtn.Text = "¡Link copiado!"
    task.wait(2)
    GetKeyBtn.Text = "Copiar Discord"
end)

-- Función que se ejecuta al pasar el Key System
SubmitBtn.MouseButton1Click:Connect(function()
    local userKey = TextBox.Text
    local granted = false

    for _, k in ipairs(MasterKeys) do
        if userKey == k then
            granted = true
            break
        end
    end

    if granted then
        KeyGui:Destroy()
        StartMainScript() -- Inicia todo el menú principal
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "Key inválida. Pídela en Discord."
    end
end)


--========================================================
-- 2. SCRIPT PRINCIPAL (MENÚ KICIAHOOK + FUNCIONES)
--========================================================
function StartMainScript()

	-- Notificación de carga inferior
	task.spawn(function()
		local notifyGui = Instance.new("ScreenGui")
		notifyGui.Name = "FanswareNotification"
		notifyGui.Parent = CoreGui

		local notifFrame = Instance.new("Frame")
		notifFrame.Size = UDim2.fromOffset(260, 40)
		notifFrame.Position = UDim2.new(0.5, -130, 1, 60)
		notifFrame.AnchorPoint = Vector2.new(0.5, 1)
		notifFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
		notifFrame.BorderSizePixel = 0
		notifFrame.Parent = notifyGui

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 8)
		corner.Parent = notifFrame

		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(85, 170, 255)
		stroke.Thickness = 1.5
		stroke.Parent = notifFrame

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.Text = "Enjoy fansware script"
		label.TextColor3 = Color3.fromRGB(240, 240, 245)
		label.TextSize = 13
		label.Font = Enum.Font.GothamBold
		label.Parent = notifFrame

		TweenService:Create(notifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -130, 1, -30)}):Play()
		task.wait(3.5)
		local out = TweenService:Create(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -130, 1, 60)})
		out:Play()
		out.Completed:Wait()
		notifyGui:Destroy()
	end)

	local Config = {
		MenuKey = Enum.KeyCode.K,
		AimKey = Enum.KeyCode.Q,
		Aimbot = { Enabled = false, Smoothness = 0.15, FOV = 120, TargetPart = "Head", TeamCheck = true, VisibleCheck = true },
		TriggerBot = { Enabled = false, TeamCheck = true },
		ESP = { Enabled = false, Box = false, Skeleton = false, Tracer = false, Name = false, Distance = false, TeamCheck = true, BoxColor = Color3.fromRGB(255, 70, 70), MaxDistance = 1500 }
	}

	local MenuOpen = true
	local AimHeld = false
	local ESPInstances = {}

	local RemoteFolder = ReplicatedStorage:FindFirstChild("ShooterRemotes")
	if not RemoteFolder then
		RemoteFolder = Instance.new("Folder") RemoteFolder.Name = "ShooterRemotes" RemoteFolder.Parent = ReplicatedStorage
	end
	local FireRemote = RemoteFolder:FindFirstChild("Fire")
	if not FireRemote then
		FireRemote = Instance.new("RemoteEvent") FireRemote.Name = "Fire" FireRemote.Parent = RemoteFolder
	end

	local function GetCharacter(player) return player and player.Character end
	local function GetHumanoid(character) return character and character:FindFirstChildOfClass("Humanoid") end
	local function IsAlive(character) local hum = GetHumanoid(character) return hum ~= nil and hum.Health > 0 end
	local function GetRoot(character) return character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart end
	local function GetHead(character) return character:FindFirstChild("Head") end
	local function IsEnemy(player, teamCheck)
		if player == LocalPlayer then return false end
		if not teamCheck then return true end
		if LocalPlayer.Team and player.Team then return player.Team ~= LocalPlayer.Team end
		return true
	end

	local function GetTargetPart(character)
		local mode = Config.Aimbot.TargetPart
		if mode == "Head" then return GetHead(character) or GetRoot(character)
		elseif mode == "Body" then return GetRoot(character) or GetHead(character)
		elseif mode == "Random" then
			local parts = {GetHead(character), GetRoot(character), character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")}
			local valid = {} for _, p in ipairs(parts) do if p then table.insert(valid, p) end end
			if #valid > 0 then return valid[math.random(1, #valid)] end
		end
		return GetHead(character)
	end

	local function IsVisible(part, character)
		if not part or not Config.Aimbot.VisibleCheck then return true end
		local origin = Camera.CFrame.Position
		local params = RaycastParams.new() params.FilterType = Enum.RaycastFilterType.Exclude params.FilterDescendantsInstances = {LocalPlayer.Character}
		local result = workspace:Raycast(origin, part.Position - origin, params)
		return not result or result.Instance:IsDescendantOf(character)
	end

	local function GetClosestTarget()
		local mousePos = UserInputService:GetMouseLocation()
		local closestPlayer, closestPart = nil, nil
		local smallestDistance = Config.Aimbot.FOV

		for _, player in ipairs(Players:GetPlayers()) do
			if IsEnemy(player, Config.Aimbot.TeamCheck) then
				local char = GetCharacter(player)
				if char and IsAlive(char) then
					local targetPart = GetTargetPart(char)
					if targetPart then
						local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
						if onScreen and screenPos.Z > 0 then
							local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
							if screenDist < smallestDistance and IsVisible(targetPart, char) then
								smallestDistance = screenDist closestPlayer = player closestPart = targetPart
							end
						end
					end
				end
			end
		end
		return closestPlayer, closestPart
	end

	-- ESP Manager
	local function CreateESP(player)
		if player == LocalPlayer or ESPInstances[player] then return end
		local data = { Box = nil, NameGui = nil, NameLabel = nil, Beams = {}, TracerPart = nil, TracerBeam = nil }

		local box = Instance.new("SelectionBox") box.LineThickness = 0.035 box.Color3 = Config.ESP.BoxColor box.SurfaceTransparency = 1 box.Visible = false box.Parent = workspace data.Box = box

		local billboard = Instance.new("BillboardGui") billboard.Size = UDim2.fromOffset(150, 40) billboard.StudsOffset = Vector3.new(0, 3, 0) billboard.AlwaysOnTop = true billboard.Enabled = false
		local label = Instance.new("TextLabel") label.Size = UDim2.fromScale(1, 1) label.BackgroundTransparency = 1 label.TextColor3 = Color3.fromRGB(255, 255, 255) label.TextStrokeTransparency = 0.4 label.TextSize = 12 label.Font = Enum.Font.GothamBold label.Parent = billboard
		billboard.Parent = workspace data.NameLabel = label data.NameGui = billboard

		local tPart = Instance.new("Part") tPart.Anchored = true tPart.CanCollide = false tPart.Transparency = 1 tPart.Size = Vector3.new(0.05, 0.05, 0.05) tPart.Parent = workspace
		local att0 = Instance.new("Attachment") att0.Parent = tPart
		local beam = Instance.new("Beam") beam.Attachment0 = att0 beam.Width0 = 0.02 beam.Width1 = 0.02 beam.FaceCamera = true beam.Color = ColorSequence.new(Config.ESP.BoxColor) beam.Enabled = false beam.Parent = tPart
		data.TracerPart = tPart data.TracerBeam = beam

		ESPInstances[player] = data
	end

	local function RemoveESP(player)
		local data = ESPInstances[player] if not data then return end
		if data.Box then data.Box:Destroy() end if data.NameGui then data.NameGui:Destroy() end if data.TracerPart then data.TracerPart:Destroy() end
		ESPInstances[player] = nil
	end

	for _, p in ipairs(Players:GetPlayers()) do CreateESP(p) p.CharacterAdded:Connect(function() task.wait(1) CreateESP(p) end) end
	Players.PlayerAdded:Connect(function(p) CreateESP(p) p.CharacterAdded:Connect(function() task.wait(1) CreateESP(p) end) end)
	Players.PlayerRemoving:Connect(function(p) RemoveESP(p) end)

	-- Interfaz KiciaHook
	local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "FanswareKiciaHook" ScreenGui.ResetOnSpawn = false ScreenGui.Parent = CoreGui

	local Main = Instance.new("Frame") Main.Size = UDim2.fromOffset(560, 380) Main.Position = UDim2.fromScale(0.5, 0.5) Main.AnchorPoint = Vector2.new(0.5, 0.5) Main.BackgroundColor3 = Color3.fromRGB(16, 16, 20) Main.BorderSizePixel = 0 Main.Parent = ScreenGui
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

	local TopBar = Instance.new("Frame") TopBar.Size = UDim2.new(1, 0, 0, 36) TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 28) TopBar.BorderSizePixel = 0 TopBar.Parent = Main
	Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)
	
	local TopFix = Instance.new("Frame") TopFix.Size = UDim2.new(1, 0, 0, 6) TopFix.Position = UDim2.new(0, 0, 1, -6) TopFix.BackgroundColor3 = Color3.fromRGB(22, 22, 28) TopFix.BorderSizePixel = 0 TopFix.Parent = TopBar

	local Title2 = Instance.new("TextLabel") Title2.Size = UDim2.new(1, -20, 1, 0) Title2.Position = UDim2.fromOffset(14, 0) Title2.BackgroundTransparency = 1 Title2.Text = "KICIAHOOK <font color=\"#55aaff\">// FANSWARE</font>" Title2.RichText = true Title2.TextColor3 = Color3.fromRGB(240, 240, 245) Title2.TextSize = 13 Title2.Font = Enum.Font.GothamBold Title2.TextXAlignment = Enum.TextXAlignment.Left Title2.Parent = TopBar

	local Sidebar = Instance.new("ScrollingFrame") Sidebar.Size = UDim2.fromOffset(130, 320) Sidebar.Position = UDim2.fromOffset(12, 48) Sidebar.BackgroundTransparency = 1 Sidebar.BorderSizePixel = 0 Sidebar.ScrollBarThickness = 2 Sidebar.Parent = Main
	local SidebarLayout = Instance.new("UIListLayout", Sidebar) SidebarLayout.Padding = UDim.new(0, 6)

	local ContainerHolder = Instance.new("Frame") ContainerHolder.Size = UDim2.fromOffset(390, 320) ContainerHolder.Position = UDim2.fromOffset(155, 48) ContainerHolder.BackgroundColor3 = Color3.fromRGB(12, 12, 16) ContainerHolder.BorderSizePixel = 0 ContainerHolder.Parent = Main
	Instance.new("UICorner", ContainerHolder).CornerRadius = UDim.new(0, 8)

	local Tabs = {} local CurrentTabContent = nil

	local function CreateTab(name)
		local tabContent = Instance.new("ScrollingFrame") tabContent.Size = UDim2.new(1, -16, 1, -16) tabContent.Position = UDim2.fromOffset(8, 8) tabContent.BackgroundTransparency = 1 tabContent.BorderSizePixel = 0 tabContent.ScrollBarThickness = 3 tabContent.Visible = false tabContent.Parent = ContainerHolder
		local layout = Instance.new("UIListLayout", tabContent) layout.Padding = UDim.new(0, 8)
		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() tabContent.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 10) end)

		local tabButton = Instance.new("TextButton") tabButton.Size = UDim2.new(1, 0, 0, 34) tabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 26) tabButton.BorderSizePixel = 0 tabButton.Text = name tabButton.TextColor3 = Color3.fromRGB(170, 170, 180) tabButton.TextSize = 12 tabButton.Font = Enum.Font.GothamMedium tabButton.Parent = Sidebar
		Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 6)

		tabButton.MouseButton1Click:Connect(function()
			for _, t in pairs(Tabs) do t.Content.Visible = false t.Button.BackgroundColor3 = Color3.fromRGB(20, 20, 26) t.Button.TextColor3 = Color3.fromRGB(170, 170, 180) end
			tabContent.Visible = true tabButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255) tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		end)

		if not CurrentTabContent then CurrentTabContent = tabContent tabContent.Visible = true tabButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255) tabButton.TextColor3 = Color3.fromRGB(255, 255, 255) end
		table.insert(Tabs, {Button = tabButton, Content = tabContent})

		local lib = {}
		function lib:AddToggle(title, default, cb)
			local holder = Instance.new("Frame", tabContent) holder.Size = UDim2.new(1, 0, 0, 36) holder.BackgroundColor3 = Color3.fromRGB(18, 18, 24) holder.BorderSizePixel = 0
			Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 6)
			local label = Instance.new("TextLabel", holder) label.Size = UDim2.new(1, -50, 1, 0) label.Position = UDim2.fromOffset(10, 0) label.BackgroundTransparency = 1 label.Text = title label.TextColor3 = Color3.fromRGB(210, 210, 220) label.TextSize = 12 label.Font = Enum.Font.GothamMedium label.TextXAlignment = Enum.TextXAlignment.Left
			local btn = Instance.new("TextButton", holder) btn.Size = UDim2.fromOffset(36, 18) btn.Position = UDim2.new(1, -44, 0.5, -9) btn.Text = "" btn.BorderSizePixel = 0
			Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
			local state = default or false
			local function upd() btn.BackgroundColor3 = state and Color3.fromRGB(85, 170, 255) or Color3.fromRGB(45, 45, 55) end upd()
			btn.MouseButton1Click:Connect(function() state = not state upd() cb(state) end)
		end

		function lib:AddDropdown(title, options, default, cb)
			local holder = Instance.new("Frame", tabContent) holder.Size = UDim2.new(1, 0, 0, 52) holder.BackgroundColor3 = Color3.fromRGB(18, 18, 24) holder.BorderSizePixel = 0
			Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 6)
			local label = Instance.new("TextLabel", holder) label.Size = UDim2.new(1, -20, 0, 24) label.Position = UDim2.fromOffset(10, 4) label.BackgroundTransparency = 1 label.Text = title label.TextColor3 = Color3.fromRGB(210, 210, 220) label.TextSize = 12 label.Font = Enum.Font.GothamMedium label.TextXAlignment = Enum.TextXAlignment.Left
			local dropBtn = Instance.new("TextButton", holder) dropBtn.Size = UDim2.new(1, -20, 0, 22) dropBtn.Position = UDim2.fromOffset(10, 26) dropBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32) dropBtn.BorderSizePixel = 0 dropBtn.Text = "  " .. tostring(default) dropBtn.TextColor3 = Color3.fromRGB(255, 255, 255) dropBtn.TextSize = 11 dropBtn.Font = Enum.Font.Gotham dropBtn.TextXAlignment = Enum.TextXAlignment.Left
			Instance.new("UICorner", dropBtn).CornerRadius = UDim.new(0, 4)
			local idx = 1 for i, o in ipairs(options) do if o == default then idx = i break end end
			dropBtn.MouseButton1Click:Connect(function()
				idx = idx + 1 if idx > #options then idx = 1 end
				local chosen = options[idx] dropBtn.Text = "  " .. tostring(chosen) cb(chosen)
			end)
		end
		return lib
	end

	-- Menú Tabs
	local t1 = CreateTab("Aimbot")
	t1:AddToggle("Enable Aimbot", false, function(v) Config.Aimbot.Enabled = v end)
	t1:AddToggle("Team Check", true, function(v) Config.Aimbot.TeamCheck = v end)
	t1:AddToggle("Visible Check", true, function(v) Config.Aimbot.VisibleCheck = v end)
	t1:AddDropdown("Target Part", {"Head", "Body", "Random"}, "Head", function(v) Config.Aimbot.TargetPart = v end)

	local t2 = CreateTab("Combat")
	t2:AddToggle("Enable TriggerBot", false, function(v) Config.TriggerBot.Enabled = v end)
	t2:AddToggle("Trigger Team Check", true, function(v) Config.TriggerBot.TeamCheck = v end)

	local t3 = CreateTab("ESP")
	t3:AddToggle("Enable ESP", false, function(v) Config.ESP.Enabled = v end)
	t3:AddToggle("Team Check", true, function(v) Config.ESP.TeamCheck = v end)
	t3:AddToggle("ESP Box", false, function(v) Config.ESP.Box = v end)
	t3:AddToggle("ESP Skeleton", false, function(v) Config.ESP.Skeleton = v end)
	t3:AddToggle("ESP Tracer", false, function(v) Config.ESP.Tracer = v end)
	t3:AddToggle("ESP Name", false, function(v) Config.ESP.Name = v end)
	t3:AddToggle("ESP Distance", false, function(v) Config.ESP.Distance = v end)
	t3:AddDropdown("Box Color", {"Red", "Green", "Blue", "White"}, "Red", function(v)
		if v == "Red" then Config.ESP.BoxColor = Color3.fromRGB(255, 70, 70)
		elseif v == "Green" then Config.ESP.BoxColor = Color3.fromRGB(70, 255, 70)
		elseif v == "Blue" then Config.ESP.BoxColor = Color3.fromRGB(70, 150, 255)
		elseif v == "White" then Config.ESP.BoxColor = Color3.fromRGB(255, 255, 255) end
	end)

	UserInputService.InputBegan:Connect(function(input, gp)
		if input.KeyCode == Config.MenuKey then MenuOpen = not MenuOpen Main.Visible = MenuOpen end
		if input.KeyCode == Config.AimKey then AimHeld = true end
	end)
	UserInputService.InputEnded:Connect(function(input) if input.KeyCode == Config.AimKey then AimHeld = false end end)

	lo
