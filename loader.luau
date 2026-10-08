--========================================================
-- FANSWARE - SISTEMA COMPLETO RIVALS / KICIAHOOK
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Notificación inicial inferior
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

	Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 8)
	local stroke = Instance.new("UIStroke", notifFrame)
	stroke.Color = Color3.fromRGB(85, 170, 255)
	stroke.Thickness = 1.5

	local label = Instance.new("TextLabel", notifFrame)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "Enjoy fansware script"
	label.TextColor3 = Color3.fromRGB(240, 240, 245)
	label.TextSize = 13
	label.Font = Enum.Font.GothamBold

	TweenService:Create(notifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -130, 1, -30)}):Play()
	task.wait(3.5)
	local out = TweenService:Create(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -130, 1, 60)})
	out:Play()
	out.Completed:Wait()
	notifyGui:Destroy()
end)

-- Limpiar interfaz anterior si existe
if CoreGui:FindFirstChild("FanswareRivalsUI") then CoreGui.FanswareRivalsUI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FanswareRivalsUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Ventana Principal
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(780, 520)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(35, 40, 60)
MainStroke.Thickness = 1.5

-- Barra Superior
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundTransparency = 1

local LogoIcon = Instance.new("TextLabel", TopBar)
LogoIcon.Size = UDim2.fromOffset(40, 40)
LogoIcon.Position = UDim2.fromOffset(15, 5)
LogoIcon.BackgroundColor3 = Color3.fromRGB(45, 90, 255)
LogoIcon.Text = "F"
LogoIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoIcon.TextSize = 20
LogoIcon.Font = Enum.Font.GothamBold
Instance.new("UICorner", LogoIcon).CornerRadius = UDim.new(0, 8)

local TitleLabel = Instance.new("TextLabel", TopBar)
TitleLabel.Size = UDim2.fromOffset(300, 25)
TitleLabel.Position = UDim2.fromOffset(65, 5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "RIVALS"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local SubTitleLabel = Instance.new("TextLabel", TopBar)
SubTitleLabel.Size = UDim2.fromOffset(300, 15)
SubTitleLabel.Position = UDim2.fromOffset(65, 25)
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Text = "BETTER AIM  •  BETTER PLAYS"
SubTitleLabel.TextColor3 = Color3.fromRGB(100, 120, 160)
SubTitleLabel.TextSize = 10
SubTitleLabel.Font = Enum.Font.GothamMedium
SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.fromOffset(30, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 10)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(150, 160, 180)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold

CloseBtn.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

-- Barra de Pestañas Superiores
local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(1, -30, 0, 45)
TabBar.Position = UDim2.fromOffset(15, 60)
TabBar.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 8)

local TabListLayout = Instance.new("UIListLayout", TabBar)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabListLayout.Padding = UDim.new(0, 10)

local PagesContainer = Instance.new("Frame", Main)
PagesContainer.Size = UDim2.new(1, -30, 1, -125)
PagesContainer.Position = UDim2.fromOffset(15, 115)
PagesContainer.BackgroundTransparency = 1

local Tabs = {}
local CurrentPage = nil

local function CreatePage()
	local page = Instance.new("ScrollingFrame", PagesContainer)
	page.Size = UDim2.fromScale(1, 1)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	page.Visible = false
	return page
end

local function AddTabButton(name, pageObj)
	local btn = Instance.new("TextButton", TabBar)
	btn.Size = UDim2.fromOffset(165, 32)
	btn.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
	btn.BorderSizePixel = 0
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(130, 145, 175)
	btn.TextSize = 12
	btn.Font = Enum.Font.GothamMedium
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	btn.MouseButton1Click:Connect(function()
		for _, t in pairs(Tabs) do
			t.Page.Visible = false
			t.Button.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
			t.Button.TextColor3 = Color3.fromRGB(130, 145, 175)
		end
		pageObj.Visible = true
		btn.BackgroundColor3 = Color3.fromRGB(45, 90, 255)
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)

	if not CurrentPage then
		CurrentPage = pageObj
		pageObj.Visible = true
		btn.BackgroundColor3 = Color3.fromRGB(45, 90, 255)
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end

	table.insert(Tabs, {Button = btn, Page = pageObj})
end

--========================================================
-- CONFIGURACIÓN GLOBAL DE FUNCIONES
--========================================================
local Config = {
	MenuKey = Enum.KeyCode.RightShift,
	AimKey = Enum.KeyCode.Q,
	Aimbot = { Enabled = false, Smoothness = 0.15, Shaking = 0.0, TargetPart = "Head", TeamCheck = true },
	SilentAim = { Enabled = false, TargetPart = "Head" },
	TriggerBot = { Enabled = false, TargetPart = "Head", TeamCheck = true },
	ESP = { Enabled = false, Box = false, Health = false, Skeleton = false, Tracer = false, TeamCheck = true }
}

--========================================================
-- PÁGINA 1: FIGHT
--========================================================
local FightPage = CreatePage()
AddTabButton("🎯  FIGHT", FightPage)

local function CreateColumn(parent, posX)
	local col = Instance.new("ScrollingFrame", parent)
	col.Size = UDim2.new(0, 360, 1, -10)
	col.Position = UDim2.fromOffset(posX, 5)
	col.BackgroundTransparency = 1
	col.BorderSizePixel = 0
	col.ScrollBarThickness = 2
	local layout = Instance.new("UIListLayout", col)
	layout.Padding = UDim.new(0, 10)
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		col.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 15)
	end)
	return col
end

local Col1 = CreateColumn(FightPage, 0)
local Col2 = CreateColumn(FightPage, 375)

local function CreateCard(parent, titleText, height)
	local card = Instance.new("Frame", parent)
	card.Size = UDim2.new(1, 0, 0, height or 160)
	card.BackgroundColor3 = Color3.fromRGB(16, 20, 28)
	card.BorderSizePixel = 0
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
	local stroke = Instance.new("UIStroke", card)
	stroke.Color = Color3.fromRGB(30, 38, 55)

	local title = Instance.new("TextLabel", card)
	title.Size = UDim2.new(1, -20, 0, 30)
	title.Position = UDim2.fromOffset(12, 8)
	title.BackgroundTransparency = 1
	title.Text = "🎯  " .. titleText
	title.TextColor3 = Color3.fromRGB(240, 245, 255)
	title.TextSize = 13
	title.Font = Enum.Font.GothamBold
	title.TextXAlignment = Enum.TextXAlignment.Left

	return card
end

local function AddToggleToCard(card, text, default, callback)
	local holder = Instance.new("Frame", card)
	holder.Size = UDim2.new(1, -24, 0, 30)
	holder.Position = UDim2.fromOffset(12, card.AbsoluteSize.Y > 0 and card.AbsoluteSize.Y - 35 or 40)
	holder.BackgroundTransparency = 1

	local label = Instance.new("TextLabel", holder)
	label.Size = UDim2.new(1, -50, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(200, 210, 230)
	label.TextSize = 12
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left

	local btn = Instance.new("TextButton", holder)
	btn.Size = UDim2.fromOffset(36, 18)
	btn.Position = UDim2.new(1, -36, 0.5, -9)
	btn.Text = ""
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

	local state = default
	local function update()
		btn.BackgroundColor3 = state and Color3.fromRGB(45, 90, 255) or Color3.fromRGB(40, 45, 60)
	end
	update()

	btn.MouseButton1Click:Connect(function()
		state = not state
		update()
		callback(state)
	end)
end

-- Tarjeta Aimbot
local AimCard = CreateCard(Col1, "AIMBOT", 210)
-- Ajustar posición de elementos internos
local function AddUIElementsToAimCard()
	local y = 38
	local function addToggle(text, default, cb)
		local f = Instance.new("Frame", AimCard) f.Size = UDim2.new(1, -24, 0, 26) f.Position = UDim2.fromOffset(12, y) f.BackgroundTransparency = 1
		local l = Instance.new("TextLabel", f) l.Size = UDim2.new(1, -50, 1, 0) l.BackgroundTransparency = 1 l.Text = text l.TextColor3 = Color3.fromRGB(200, 210, 230) l.TextSize = 11 l.Font = Enum.Font.GothamMedium l.TextXAlignment = Enum.TextXAlignment.Left
		local b = Instance.new("TextButton", f) b.Size = UDim2.fromOffset(36, 18) b.Position = UDim2.new(1, -36, 0.5, -9) b.Text = "" b.BorderSizePixel = 0 Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
		local st = default local function up() b.BackgroundColor3 = st and Color3.fromRGB(45, 90, 255) or Color3.fromRGB(40, 45, 60) end up()
		b.MouseButton1Click:Connect(function() st = not st up() cb(st) end) y = y + 30
	end
	addToggle("Aimbot Active", false, function(v) Config.Aimbot.Enabled = v end)
	addToggle("Team Check", true, function(v) Config.Aimbot.TeamCheck = v end)
end
AddUIElementsToAimCard()

-- Tarjeta Silent Aim
local SilentCard = CreateCard(Col1, "SILENT AIM", 120)
local function AddUIElementsToSilentCard()
	local y = 38
	local f = Instance.new("Frame", SilentCard) f.Size = UDim2.new(1, -24, 0, 26) f.Position = UDim2.fromOffset(12, y) f.BackgroundTransparency = 1
	local l = Instance.new("TextLabel", f) l.Size = UDim2.new(1, -50, 1, 0) l.BackgroundTransparency = 1 l.Text = "Silent Aim Active" l.TextColor3 = Color3.fromRGB(200, 210, 230) l.TextSize = 11 l.Font = Enum.Font.GothamMedium l.TextXAlignment = Enum.TextXAlignment.Left
	local b = Instance.new("TextButton", f) b.Size = UDim2.fromOffset(36, 18) b.Position = UDim2.new(1, -36, 0.5, -9) b.Text = "" b.BorderSizePixel = 0 Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
	local st = false local function up() b.BackgroundColor3 = st and Color3.fromRGB(45, 90, 255) or Color3.fromRGB(40, 45, 60) end up()
	b.MouseButton1Click:Connect(function() st = not st up() Config.SilentAim.Enabled = st end)
end
AddUIElementsToSilentCard()

-- Tarjeta Triggerbot
local TriggerCard = CreateCard(Col2, "TRIGGERBOT", 130)
local function AddUIElementsToTriggerCard()
	local y = 38
	local f = Instance.new("Frame", TriggerCard) f.Size = UDim2.new(1, -24, 0, 26) f.Position = UDim2.fromOffset(12, y) f.BackgroundTransparency = 1
	local l = Instance.new("TextLabel", f) l.Size = UDim2.new(1, -50, 1, 0) l.BackgroundTransparency = 1 l.Text = "Triggerbot Active" l.TextColor3 = Color3.fromRGB(200, 210, 230) l.TextSize = 11 l.Font = Enum.Font.GothamMedium l.TextXAlignment = Enum.TextXAlignment.Left
	local b = Instance.new("TextButton", f) b.Size = UDim2.fromOffset(36, 18) b.Position = UDim2.new(1, -36, 0.5, -9) b.Text = "" b.BorderSizePixel = 0 Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
	local st = false local function up() b.BackgroundColor3 = st and Color3.fromRGB(45, 90, 255) or Color3.fromRGB(40, 45, 60) end up()
	b.MouseButton1Click:Connect(function() st = not st up() Config.TriggerBot.Enabled = st end)
end
AddUIElementsToTriggerCard()


--========================================================
-- PÁGINA 2: ESP
--========================================================
local EspPage = CreatePage()
AddTabButton("👁️  ESP", EspPage)

local EspCol1 = CreateColumn(EspPage, 0)
local EspCard = CreateCard(EspCol1, "ESP OPTIONS", 220)

local function AddEspToggles()
	local y = 38
	local function addToggle(text, default, cb)
		local f = Instance.new("Frame", EspCard) f.Size = UDim2.new(1, -24, 0, 26) f.Position = UDim2.fromOffset(12, y) f.BackgroundTransparency = 1
		local l = Instance.new("TextLabel", f) l.Size = UDim2.new(1, -50, 1, 0) l.BackgroundTransparency = 1 l.Text = text l.TextColor3 = Color3.fromRGB(200, 210, 230) l.TextSize = 11 l.Font = Enum.Font.GothamMedium l.TextXAlignment = Enum.TextXAlignment.Left
		local b = Instance.new("TextButton", f) b.Size = UDim2.fromOffset(36, 18) b.Position = UDim2.new(1, -36, 0.5, -9) b.Text = "" b.BorderSizePixel = 0 Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
		local st = default local function up() b.BackgroundColor3 = st and Color3.fromRGB(45, 90, 255) or Color3.fromRGB(40, 45, 60) end up()
		b.MouseButton1Click:Connect(function() st = not st up() cb(st) end) y = y + 30
	end
	addToggle("Enable ESP", false, function(v) Config.ESP.Enabled = v end)
	addToggle("Show Boxes", false, function(v) Config.ESP.Box = v end)
	addToggle("Show Health", false, function(v) Config.ESP.Health = v end)
	addToggle("Tracers", false, function(v) Config.ESP.Tracer = v end)
end
AddEspToggles()


--========================================================
-- PÁGINA 3: SETTINGS
--========================================================
local SettingsPage = CreatePage()
AddTabButton("⚙️  SETTINGS", SettingsPage)

local SetCol = CreateColumn(SettingsPage, 0)
local SetCard = CreateCard(SetCol, "MENU SETTINGS", 120)
local SetLabel = Instance.new("TextLabel", SetCard)
SetLabel.Size = UDim2.new(1, -24, 0, 30)
SetLabel.Position = UDim2.fromOffset(12, 40)
SetLabel.BackgroundTransparency = 1
SetLabel.Text = "Open/Close Menu Key: RightShift"
SetLabel.TextColor3 = Color3.fromRGB(200, 210, 230)
SetLabel.TextSize = 12
SetLabel.Font = Enum.Font.GothamMedium
SetLabel.TextXAlignment = Enum.TextXAlignment.Left


--========================================================
-- LÓGICA DE FUNCIONAMIENTO (AIMBOT, ESP, TRIGGERBOT)
--========================================================
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

local function GetClosestTarget()
	local mousePos = UserInputService:GetMouseLocation()
	local closestPlayer, closestPart = nil, nil
	local smallestDistance = 300

	for _, player in ipairs(Players:GetPlayers()) do
		if IsEnemy(player, Config.Aimbot.TeamCheck) then
			local char = GetCharacter(player)
			if char and IsAlive(char) then
				local targetPart = GetHead(char) or GetRoot(char)
				if targetPart then
					local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
					if onScreen and screenPos.Z > 0 then
						local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
						if screenDist < smallestDistance then
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
	local box = Instance.new("SelectionBox") box.LineThickness = 0.035 box.Color3 = Color3.fromRGB(255, 70, 70) box.SurfaceTransparency = 1 box.Visible = false box.Parent = workspace
	ESPInstances[player] = {Box = box}
end

local function RemoveESP(player)
	if ESPInstances[player] and ESPInstances[player].Box then ESPInstances[player].Box:Destroy() end
	ESPInstances[player] = nil
end

for _, p in ipairs(Players:GetPlayers()) do CreateESP(p) p.CharacterAdded:Connect(function() task.wait(1) CreateESP(p) end) end
Players.PlayerAdded:Connect(function(p) CreateESP(p) p.CharacterAdded:Connect(function() task.wait(1) CreateESP(p) end) end)
Players.PlayerRemoving:Connect(function(p) RemoveESP(p) end)

local AimHeld = false
UserInputService.InputBegan:Connect(function(input, gp)
	if input.KeyCode == Config.MenuKey then Main.Visible = not Main.Visible end
	if input.KeyCode == Config.AimKey then AimHeld = true end
end)
UserInputService.InputEnded:Connect(function(input) if input.KeyCode == Config.AimKey then AimHeld = false end end)

local TriggerCooldown = false
RunService.RenderStepped:Connect(function()
	-- Aimbot
	if Config.Aimbot.Enabled and AimHeld then
		local _, targetPart = GetClosestTarget()
		if targetPart then
			local targetCFrame = CFrame.lookAt(Camera.CFrame.Position, targetPart.Position)
			Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, math.clamp(Config.Aimbot.Smoothness, 0.01, 1))
		end
	end

	-- TriggerBot
	if Config.TriggerBot.Enabled and not TriggerCooldown then
		local viewport = Camera.ViewportSize
		local ray = Camera:ViewportPointToRay(viewport.X / 2, viewport.Y / 2)
		local params = RaycastParams.new() params.FilterType = Enum.RaycastFilterType.Exclude params.FilterDescendantsInstances = {LocalPlayer.Character}
		local result = workspace:Raycast(ray.Origin, ray.Direction * 1500, params)
		if result then
			local char = result.Instance:FindFirstAncestorOfClass("Model")
			local player = char and Players:GetPlayerFromCharacter(char)
			if player and IsEnemy(player, Config.TriggerBot.TeamCheck) and IsAlive(char) then
				TriggerCooldown = true FireRemote:FireServer(result.Position, result.Instance)
				task.delay(0.08, function() TriggerCooldown = false end)
			end
		end
	end

	-- ESP Update
	for player, data in pairs(ESPInstances) do
		local char = GetCharacter(player)
		local valid = Config.ESP.Enabled and char and IsAlive(char) and IsEnemy(player, Config.ESP.TeamCheck)
		if not valid then
			data.Box.Visible = false
		else
			data.Box.Adornee = char
			data.Box.Visible = Config.ESP.Box
		end
	end
end)
