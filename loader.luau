--========================================================
-- FANSWARE - SISTEMA COMPLETO (KEY SYSTEM + RIVALS UI + SKIN CHANGER UNBLOCK ALL)
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
    "yeahfreeformelol",
    "withlovekeyfriends",
    "withlovekeyfriends2",
    "fans_7f8a9b2c", "fans_3x4k9p1m", "fans_8q2w5z7y", "fans_1m6n4b8v", "fans_9p5l2k3j",
    "fans_4h7g1f6d", "fans_2c8x3z9w", "fans_6v1b5n7m", "fans_5j9k2l4p", "fans_3d8f6g1h",
    "fans_7w2q9e4r", "fans_1t5y8u3i", "fans_9o4p2l6k", "fans_8j3h5g7f", "fans_2d1s6a9z",
    "fans_4x7c3v2b", "fans_6n8m1k5j", "fans_9h2g4f7d", "fans_5s3a8z1x", "fans_7p6o5i4u"
}
local DiscordKeyLink = "https://discord.gg/tucodigo"

if CoreGui:FindFirstChild("ShooterKeySystem") then CoreGui.ShooterKeySystem:Destroy() end
if CoreGui:FindFirstChild("FanswareRivalsUI") then CoreGui.FanswareRivalsUI:Destroy() end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "ShooterKeySystem"
KeyGui.Parent = CoreGui

local MainFrame = Instance.new("Frame", KeyGui)
MainFrame.Size = UDim2.fromOffset(400, 220)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "AUTENTICACIÓN - FANSWARE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold

local TextBox = Instance.new("TextBox", MainFrame)
TextBox.Size = UDim2.new(1, -40, 0, 45)
TextBox.Position = UDim2.fromOffset(20, 60)
TextBox.PlaceholderText = "Ingresa tu Key aquí..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TextBox.TextSize = 14
TextBox.Font = Enum.Font.Gotham
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

local SubmitBtn = Instance.new("TextButton", MainFrame)
SubmitBtn.Size = UDim2.new(0, 170, 0, 35)
SubmitBtn.Position = UDim2.fromOffset(20, 120)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(45, 90, 255)
SubmitBtn.Text = "Comprobar Key"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 13
SubmitBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 6)

local GetKeyBtn = Instance.new("TextButton", MainFrame)
GetKeyBtn.Size = UDim2.new(0, 170, 0, 35)
GetKeyBtn.Position = UDim2.fromOffset(210, 120)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
GetKeyBtn.Text = "Copiar Discord"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 13
GetKeyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 6)

GetKeyBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(DiscordKeyLink) end)
    GetKeyBtn.Text = "¡Link copiado!"
    task.wait(2)
    GetKeyBtn.Text = "Copiar Discord"
end)

SubmitBtn.MouseButton1Click:Connect(function()
    local userKey = TextBox.Text
    local granted = false
    for _, k in ipairs(MasterKeys) do
        if userKey == k then granted = true break end
    end
    if granted then
        KeyGui:Destroy()
        StartMainScript()
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "Key inválida. Pídela en Discord."
    end
end)


--========================================================
-- 2. SCRIPT PRINCIPAL & INTERFAZ RIVALS
--========================================================
function StartMainScript()

	-- Notificación de Bienvenida
	task.spawn(function()
		local notifyGui = Instance.new("ScreenGui", CoreGui)
		notifyGui.Name = "FanswareNotification"
		local notifFrame = Instance.new("Frame", notifyGui)
		notifFrame.Size = UDim2.fromOffset(260, 40)
		notifFrame.Position = UDim2.new(0.5, -130, 1, 60)
		notifFrame.AnchorPoint = Vector2.new(0.5, 1)
		notifFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
		Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 8)
		local stroke = Instance.new("UIStroke", notifFrame)
		stroke.Color = Color3.fromRGB(45, 90, 255)
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

	local ScreenGui = Instance.new("ScreenGui", CoreGui)
	ScreenGui.Name = "FanswareRivalsUI"
	ScreenGui.ResetOnSpawn = false

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
	SubTitleLabel.Text = "BETTER AIM  •  SKIN CHANGER UNLOCKER"
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
	CloseBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

	-- Pestañas Superiores
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
		btn.Size = UDim2.fromOffset(170, 32)
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

	local Config = {
		MenuKey = Enum.KeyCode.RightShift,
		AimKey = Enum.KeyCode.Q,
		Aimbot = { Enabled = false, Smoothness = 0.15, TeamCheck = true },
		SilentAim = { Enabled = false },
		TriggerBot = { Enabled = false, TeamCheck = true },
		ESP = { Enabled = false, Box = false, Health = false, Tracer = false },
		SkinChanger = { UnblockAll = false }
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

	-- Aimbot Card
	local AimCard = CreateCard(Col1, "AIMBOT", 160)
	local y1 = 38
	local function addToggleTo(card, text, default, cb)
		local f = Instance.new("Frame", card) f.Size = UDim2.new(1, -24, 0, 26) f.Position = UDim2.fromOffset(12, y1) f.BackgroundTransparency = 1
		local l = Instance.new("TextLabel", f) l.Size = UDim2.new(1, -50, 1, 0) l.BackgroundTransparency = 1 l.Text = text l.TextColor3 = Color3.fromRGB(200, 210, 230) l.TextSize = 11 l.Font = Enum.Font.GothamMedium l.TextXAlignment = Enum.TextXAlignment.Left
		local b = Instance.new("TextButton", f) b.Size = UDim2.fromOffset(36, 18) b.Position = UDim2.new(1, -36, 0.5, -9) b.Text = "" b.BorderSizePixel = 0 Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
		local st = default local function up() b.BackgroundColor3 = st and Color3.fromRGB(45, 90, 255) or Color3.fromRGB(40, 45, 60) end up()
		b.MouseButton1Click:Connect(function() st = not st up() cb(st) end) y1 = y1 + 30
	end
	addToggleTo(AimCard, "Aimbot Active", false, function(v) Config.Aimbot.Enabled = v end)
	addToggleTo(AimCard, "Team Check", true, function(v) Config.Aimbot.TeamCheck = v end)

	-- Silent Aim Card
	local SilentCard = CreateCard(Col1, "SILENT AIM", 100)
	y1 = 38
	local function addToggleTo2(card, text, default, cb)
		local f = Instance.new("Frame", card) f.Size = UDim2.new(1, -24, 0, 26) f.Position = UDim2.fromOffset(12, y1) f.BackgroundTransparency = 1
		local l = Instance.new("TextLabel", f) l.Size = UDim2.new(1, -50, 1, 0) l.BackgroundTransparency = 1 l.Text = text l.TextColor3 = Color3.fromRGB(200, 210, 230) l.TextSize = 11 l.Font = Enum.Font.GothamMedium l.TextXAlignment = Enum.TextXAlignment.Left
		local b = Instance.new("TextButton", f) b.Size = UDim2.fromOffset(36, 18) b.Position = UDim2.new(1, -36, 0.5, -9) b.Text = "" b.BorderSizePixel = 0 Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
		local st = default local function up() b.BackgroundColor3 = st and Color3.fromRGB(45, 90, 255) or Color3.fromRGB(40, 45, 60) end up()
		b.MouseButton1Click:Connect(function() st = not st up() cb(st) end) y1 = y1 + 30
	end
	addToggleTo2(SilentCard, "Silent Aim Active", false, function(v) Config.SilentAim.Enabled = v end)

	-- Triggerbot Card
	local TriggerCard = CreateCard(Col2, "TRIGGERBOT", 100)
	y1 = 38
	local function addToggleTo3(card, text, default, cb)
		local f = Instance.new("Frame", card) f.Size = UDim2.new(1, -24, 0, 26) f.Position = UDim2.fromOffset(12, y1) f.BackgroundTransparency = 1
		local l = Instance.new("TextLabel", f) l.Size = UDim2.new(1, -50, 1, 0) l.BackgroundTransparency = 1 l.Text = text l.TextColor3 = Color3.fromRGB(200, 210, 230) l.TextSize = 11 l.Font = Enum.Font.GothamMedium l.TextXAlignment = Enum.TextXAlignment.Left
		local b = Instance.new("TextButton", f) b.Size = UDim2.fromOffset(36, 18) b.Position = UDim2.new(1, -36, 0.5, -9) b.Text = "" b.BorderSizePixel = 0 Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
		local st = default local function up() b.BackgroundColor3 = st and Color3.fromRGB(45, 90, 255) or Color3.fromRGB(40, 45, 60) end up()
		b.MouseButton1Click:Connect(function() st = not st up() cb(st) end) y1 = y1 + 30
	end
	addToggleTo3(TriggerCard, "Triggerbot Active", false, function(v) Config.TriggerBot.Enabled = v end)


	--========================================================
	-- PÁGINA 2: ESP
	--========================================================
	local EspPage = CreatePage()
	AddTabButton("👁️  ESP", EspPage)
	local EspCol = CreateColumn(EspPage, 0)
	local EspCard = CreateCard(EspCol, "ESP OPTIONS", 200)
	y1 = 38
	local function addToggleTo4(card, text, default, cb)
		local f = Instance.new("Frame", card) f.Size = UDim2.new(1, -24, 0, 26) f.Position = UDim2.fromOffset(12, y1) f.BackgroundTransparency = 1
		local l = Instance.new("TextLabel", f) l.Size = UDim2.new(1, -50, 1, 0) l.BackgroundTransparency = 1 l.Text = text l.TextColor3 = Color3.fromRGB(200, 210, 230) l.TextSize = 11 l.Font = Enum.Font.GothamMedium l.TextXAlignment = Enum.TextXAlignment.Left
		local b = Instance.new("TextButton", f) b.Size = UDim2.fromOffset(36, 18) b.Position = UDim2.new(1, -36, 0.5, -9) b.Text = "" b.BorderSizePixel = 0 Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
		local st = default local function up() b.BackgroundColor3 = st and Color3.fromRGB(45, 90, 255) or Color3.fromRGB(40, 45, 60) end up()
		b.MouseButton1Click:Connect(function() st = not st up() cb(st) end) y1 = y1 + 30
	end
	addToggleTo4(EspCard, "Enable ESP", false, function(v) Config.ESP.Enabled = v end)
	addToggleTo4(EspCard, "Show Boxes", false, function(v) Config.ESP.Box = v end)
	addToggleTo4(EspCard, "Show Health", false, function(v) Config.ESP.Health = v end)
	addToggleTo4(EspCard, "Tracers", false, function(v) Config.ESP.Tracer = v end)


	--========================================================
	-- PÁGINA 3: SKIN CHANGER (Unblock All Toggle)
	--========================================================
	local SkinPage = CreatePage()
	AddTabButton("🎨  SKIN CHANGER", SkinPage)
	local SkinCol = CreateColumn(SkinPage, 0)
	local SkinCard = CreateCard(SkinCol, "SKIN CHANGER UNLOCKER", 120)
	
	y1 = 38
	local function addToggleTo5(card, text, default, cb)
		local f = Instance.new("Frame", card) f.Size = UDim2.new(1, -24, 0, 26) f.Position = UDim2.fromOffset(12, y1) f.BackgroundTransparency = 1
		local l = Instance.new("TextLabel", f) l.Size = UDim2.new(1, -50, 1, 0) l.BackgroundTransparency = 1 l.Text = text l.TextColor3 = Color3.fromRGB(200, 210, 230) l.TextSize = 11 l.Font = Enum.Font.GothamMedium l.TextXAlignment = Enum.TextXAlignment.Left
		local b = Instance.new("TextButton", f) b.Size = UDim2.fromOffset(36, 18) b.Position = UDim2.new(1, -36, 0.5, -9) b.Text = "" b.BorderSizePixel = 0 Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
		local st = default local function up() b.BackgroundColor3 = st and Color3.fromRGB(45, 90, 255) or Color3.fromRGB(40, 45, 60) end up()
		b.MouseButton1Click:Connect(function() st = not st up() cb(st) end) y1 = y1 + 30
	end
	
	addToggleTo5(SkinCard, "Unblock All Skins / Cosmetics", false, function(v)
		Config.SkinChanger.UnblockAll = v
		pcall(function()
			local remotes = ReplicatedStorage:FindFirstChild("ShooterRemotes")
			if remotes and remotes:FindFirstChild("UnlockAllSkins") then
				remotes.UnlockAllSkins:FireServer(v)
			end
		end)
	end)


	--========================================================
	-- PÁGINA 4: SETTINGS
	--========================================================
	local SettingsPage = CreatePage()
	AddTabButton("⚙️  SETTINGS", SettingsPage)
	local SetCol = CreateColumn(SettingsPage, 0)
	local SetCard = CreateCard(SetCol, "SETTINGS", 100)
	local setLbl = Instance.new("TextLabel", SetCard)
	setLbl.Size = UDim2.new(1, -24, 0, 30)
	setLbl.Position = UDim2.fromOffset(12, 40)
	setLbl.BackgroundTransparency = 1
	setLbl.Text = "Open/Close Menu Key: RightShift"
	setLbl.TextColor3 = Color3.fromRGB(200, 210, 230)
	setLbl.TextSize = 12
	setLbl.Font = Enum.Font.GothamMedium
	setLbl.TextXAlignment = Enum.TextXAlignment.Left


	--========================================================
	-- LÓGICA DE EJECUCIÓN (AIMBOT, ESP, TRIGGERBOT)
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
	local function GetHead(character) return 
