--==============================================================
-- Fanware | Best script (fixed v3.0 — wallbang multi-remote)
-- Discord: https://discord.gg/g9UAV8xC2p
--==============================================================
-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

--==============================================================
-- CLEANUP OLD INSTANCES
--==============================================================
pcall(function()
    if CoreGui:FindFirstChild("FanwareUI") then
        CoreGui.FanwareUI:Destroy()
    end
    if CoreGui:FindFirstChild("FanwareNotify") then
        CoreGui.FanwareNotify:Destroy()
    end
    if CoreGui:FindFirstChild("FanwareLoading") then
        CoreGui.FanwareLoading:Destroy()
    end
end)

--==============================================================
-- MAIN GUI
--==============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FanwareUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

--==============================================================
-- UTILITIES
--==============================================================
local function new(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    return obj
end

local function corner(parent, radius)
    return new("UICorner", {
        CornerRadius = UDim.new(0, radius or 8),
        Parent = parent
    })
end

local function stroke(parent, color, thickness)
    return new("UIStroke", {
        Color = color or Color3.fromRGB(60, 60, 70),
        Thickness = thickness or 1,
        Parent = parent
    })
end

--==============================================================
-- 1. WELCOME NOTIFICATION
--==============================================================
local NotifyGui = new("ScreenGui", {
    Name = "FanwareNotify",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    Parent = CoreGui
})

local notify = new("Frame", {
    Parent = NotifyGui,
    Size = UDim2.new(0, 300, 0, 70),
    Position = UDim2.new(1, 320, 1, -100),
    BackgroundColor3 = Color3.fromRGB(20, 20, 26),
    BorderSizePixel = 0,
})
corner(notify, 10)
stroke(notify, Color3.fromRGB(90, 90, 110), 1)

new("TextLabel", {
    Parent = notify,
    Size = UDim2.new(1, -20, 1, -20),
    Position = UDim2.new(0, 10, 0, 10),
    BackgroundTransparency = 1,
    Text = "Welcome " .. LocalPlayer.Name .. " to ware scripts",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamMedium,
    TextSize = 15,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
})

TweenService:Create(notify, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
    Position = UDim2.new(1, -320, 1, -100)
}):Play()

task.wait(3)
TweenService:Create(notify, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
    Position = UDim2.new(1, 320, 1, -100)
}):Play()
task.wait(0.5)
NotifyGui:Destroy()

--==============================================================
-- 2. LOADING SCREEN
--==============================================================
local LoadGui = new("ScreenGui", {
    Name = "FanwareLoading",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    Parent = CoreGui
})

local loadFrame = new("Frame", {
    Parent = LoadGui,
    Size = UDim2.new(0, 260, 0, 120),
    Position = UDim2.new(0.5, -130, 0.5, -60),
    BackgroundColor3 = Color3.fromRGB(18, 18, 24),
    BorderSizePixel = 0,
})
corner(loadFrame, 12)
stroke(loadFrame, Color3.fromRGB(90, 90, 110), 1)

local spinner = new("Frame", {
    Parent = loadFrame,
    Size = UDim2.new(0, 34, 0, 34),
    Position = UDim2.new(0.5, -17, 0, 18),
    BackgroundColor3 = Color3.fromRGB(60, 130, 255),
    BorderSizePixel = 0,
})
corner(spinner, 17)

new("TextLabel", {
    Parent = loadFrame,
    Size = UDim2.new(1, 0, 0, 20),
    Position = UDim2.new(0, 0, 0, 68),
    BackgroundTransparency = 1,
    Text = "Loading script, please wait...",
    TextColor3 = Color3.fromRGB(230, 230, 235),
    Font = Enum.Font.Gotham,
    TextSize = 14,
})

local spinning = true
task.spawn(function()
    while spinning do
        spinner.Rotation = spinner.Rotation + 6
        task.wait(0.02)
    end
end)

task.wait(2)
spinning = false
LoadGui:Destroy()

--==============================================================
-- 3. MAIN MENU
--==============================================================
local main = new("Frame", {
    Parent = ScreenGui,
    Size = UDim2.new(0, 520, 0, 360),
    Position = UDim2.new(0.5, -260, 0.5, -180),
    BackgroundColor3 = Color3.fromRGB(18, 18, 24),
    BorderSizePixel = 0,
    Active = true,
    Visible = true,
    ZIndex = 1,
})
corner(main, 12)
stroke(main, Color3.fromRGB(90, 90, 110), 1)

local topBar = new("Frame", {
    Parent = main,
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = Color3.fromRGB(24, 24, 32),
    BorderSizePixel = 0,
    ZIndex = 2,
})
corner(topBar, 12)

new("Frame", {
    Parent = topBar,
    Size = UDim2.new(1, 0, 0, 12),
    Position = UDim2.new(0, 0, 1, -12),
    BackgroundColor3 = Color3.fromRGB(24, 24, 32),
    BorderSizePixel = 0,
    ZIndex = 2,
})

new("TextLabel", {
    Parent = topBar,
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 14, 0, 0),
    BackgroundTransparency = 1,
    Text = "Fanware  •  ware scripts",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 3,
})

new("TextLabel", {
    Parent = topBar,
    Size = UDim2.new(0, 120, 1, 0),
    Position = UDim2.new(1, -130, 0, 0),
    BackgroundTransparency = 1,
    Text = "RShift menu | P aim | Q ultra",
    TextColor3 = Color3.fromRGB(140, 140, 155),
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Right,
    ZIndex = 3,
})

local tabBar = new("Frame", {
    Parent = main,
    Size = UDim2.new(0, 130, 1, -60),
    Position = UDim2.new(0, 10, 0, 50),
    BackgroundTransparency = 1,
    ZIndex = 2,
})

local content = new("Frame", {
    Parent = main,
    Size = UDim2.new(1, -160, 1, -60),
    Position = UDim2.new(0, 150, 0, 50),
    BackgroundColor3 = Color3.fromRGB(22, 22, 30),
    BorderSizePixel = 0,
    ZIndex = 2,
})
corner(content, 8)
stroke(content, Color3.fromRGB(45, 45, 55), 1)

--==============================================================
-- TAB SYSTEM
--==============================================================
local tabs = {}
local activeTab = nil
local tabNames = {"Combat", "Players", "Misc.", "Coils", "Settings"}

local function createPage(name)
    local page = new("ScrollingFrame", {
        Parent = content,
        Size = UDim2.new(1, -16, 1, -16),
        Position = UDim2.new(0, 8, 0, 8),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Color3.fromRGB(90, 90, 110),
        Visible = false,
        ZIndex = 3,
    })
    new("UIListLayout", {
        Parent = page,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    return page
end

local function selectTab(name)
    for n, data in pairs(tabs) do
        data.button.BackgroundColor3 = (n == name)
            and Color3.fromRGB(50, 90, 200)
            or Color3.fromRGB(28, 28, 36)
        data.page.Visible = (n == name)
    end
    activeTab = name
end

new("UIListLayout", {
    Parent = tabBar,
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
})

for i, name in ipairs(tabNames) do
    local btn = new("TextButton", {
        Parent = tabBar,
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Color3.fromRGB(28, 28, 36),
        BorderSizePixel = 0,
        Text = name,
        TextColor3 = Color3.fromRGB(230, 230, 235),
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        AutoButtonColor = false,
        LayoutOrder = i,
        ZIndex = 3,
    })
    corner(btn, 8)
    local page = createPage(name)
    tabs[name] = {button = btn, page = page}
    btn.MouseButton1Click:Connect(function()
        selectTab(name)
    end)
end
selectTab("Combat")

--==============================================================
-- UI ELEMENT HELPERS
--==============================================================
local yOffset = {}

local function addRow(page, height)
    yOffset[page] = (yOffset[page] or 0) + (height or 30) + 6
    page.CanvasSize = UDim2.new(0, 0, 0, yOffset[page])
end

local function makeToggle(page, label, default, callback)
    local holder = new("Frame", {
        Parent = page,
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(28, 28, 36),
        BorderSizePixel = 0,
        ZIndex = 3,
    })
    corner(holder, 6)
    addRow(page, 30)

    new("TextLabel", {
        Parent = holder,
        Size = UDim2.new(1, -70, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = Color3.fromRGB(230, 230, 235),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
    })

    local state = default or false
    local track = new("Frame", {
        Parent = holder,
        Size = UDim2.new(0, 40, 0, 20),
        Position = UDim2.new(1, -50, 0.5, -10),
        BackgroundColor3 = state and Color3.fromRGB(50, 90, 200) or Color3.fromRGB(60, 60, 70),
        BorderSizePixel = 0,
        ZIndex = 4,
    })
    corner(track, 10)

    local knob = new("Frame", {
        Parent = track,
        Size = UDim2.new(0, 16, 0, 16),
        Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 5,
    })
    corner(knob, 8)

    local click = new("TextButton", {
        Parent = holder,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 6,
    })

    click.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(track, TweenInfo.new(0.15), {
            BackgroundColor3 = state and Color3.fromRGB(50, 90, 200) or Color3.fromRGB(60, 60, 70)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        }):Play()
        if callback then callback(state) end
    end)

    return {
        Set = function(v)
            state = v
            track.BackgroundColor3 = v and Color3.fromRGB(50, 90, 200) or Color3.fromRGB(60, 60, 70)
            knob.Position = v and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        end,
        Get = function() return state end
    }
end

local activeDropdownList = nil

local function makeDropdown(page, label, options, default, callback)
    local holder = new("Frame", {
        Parent = page,
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(28, 28, 36),
        BorderSizePixel = 0,
        ZIndex = 3,
    })
    corner(holder, 6)
    addRow(page, 30)

    new("TextLabel", {
        Parent = holder,
        Size = UDim2.new(0.5, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = Color3.fromRGB(230, 230, 235),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
    })

    local selected = default or options[1]
    local btn = new("TextButton", {
        Parent = holder,
        Size = UDim2.new(0, 120, 0, 22),
        Position = UDim2.new(1, -130, 0.5, -11),
        BackgroundColor3 = Color3.fromRGB(40, 40, 50),
        BorderSizePixel = 0,
        Text = selected,
        TextColor3 = Color3.fromRGB(230, 230, 235),
        Font = Enum.Font.Gotham,
        TextSize = 12,
        ZIndex = 4,
    })
    corner(btn, 6)

    local open = false
    local function closeMenu()
        if activeDropdownList then
            activeDropdownList:Destroy()
            activeDropdownList = nil
        end
        open = false
    end

    btn.MouseButton1Click:Connect(function()
        if open then
            closeMenu()
        else
            if activeDropdownList then activeDropdownList:Destroy() end
            open = true
            local absPos = btn.AbsolutePosition
            local absSize = btn.AbsoluteSize
            local list = new("Frame", {
                Parent = ScreenGui,
                Size = UDim2.new(0, absSize.X, 0, #options * 24),
                Position = UDim2.fromOffset(absPos.X, absPos.Y + absSize.Y + 2),
                BackgroundColor3 = Color3.fromRGB(30, 30, 38),
                BorderSizePixel = 0,
                ZIndex = 100,
            })
            corner(list, 6)
            stroke(list, Color3.fromRGB(70, 70, 85), 1)
            new("UIListLayout", {
                Parent = list,
                SortOrder = Enum.SortOrder.LayoutOrder,
            })
            for _, opt in ipairs(options) do
                local ob = new("TextButton", {
                    Parent = list,
                    Size = UDim2.new(1, 0, 0, 24),
                    BackgroundColor3 = Color3.fromRGB(30, 30, 38),
                    BorderSizePixel = 0,
                    Text = opt,
                    TextColor3 = Color3.fromRGB(220, 220, 225),
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    ZIndex = 101,
                })
                ob.MouseButton1Click:Connect(function()
                    selected = opt
                    btn.Text = opt
                    if callback then callback(opt) end
                    closeMenu()
                end)
            end
            activeDropdownList = list
        end
    end)

    return {
        Get = function() return selected end,
        Set = function(v) selected = v btn.Text = v if callback then callback(v) end end
    }
end

local function makeSlider(page, label, min, max, default, callback)
    local holder = new("Frame", {
        Parent = page,
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Color3.fromRGB(28, 28, 36),
        BorderSizePixel = 0,
        ZIndex = 3,
    })
    corner(holder, 6)
    addRow(page, 44)

    new("TextLabel", {
        Parent = holder,
        Size = UDim2.new(0.6, 0, 0, 18),
        Position = UDim2.new(0, 10, 0, 4),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = Color3.fromRGB(230, 230, 235),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
    })

    local val = default or min
    local valLabel = new("TextLabel", {
        Parent = holder,
        Size = UDim2.new(0.4, -10, 0, 18),
        Position = UDim2.new(0.6, 0, 0, 4),
        BackgroundTransparency = 1,
        Text = tostring(val),
        TextColor3 = Color3.fromRGB(140, 180, 255),
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 4,
    })

    local bar = new("Frame", {
        Parent = holder,
        Size = UDim2.new(1, -20, 0, 6),
        Position = UDim2.new(0, 10, 1, -14),
        BackgroundColor3 = Color3.fromRGB(45, 45, 55),
        BorderSizePixel = 0,
        ZIndex = 4,
    })
    corner(bar, 3)

    local fill = new("Frame", {
        Parent = bar,
        Size = UDim2.new((val - min) / math.max(max - min, 1), 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(50, 90, 200),
        BorderSizePixel = 0,
        ZIndex = 5,
    })
    corner(fill, 3)

    local dragging = false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            val = math.floor(min + (max - min) * rel + 0.5)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            valLabel.Text = tostring(val)
            if callback then callback(val) end
        end
    end)

    return {
        Get = function() return val end,
        Set = function(v)
            val = v
            fill.Size = UDim2.new((v - min) / math.max(max - min, 1), 0, 1, 0)
            valLabel.Text = tostring(v)
            if callback then callback(v) end
        end
    }
end

local function makeKeybind(page, label, default, callback)
    local holder = new("Frame", {
        Parent = page,
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(28, 28, 36),
        BorderSizePixel = 0,
        ZIndex = 3,
    })
    corner(holder, 6)
    addRow(page, 30)

    new("TextLabel", {
        Parent = holder,
        Size = UDim2.new(0.5, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = Color3.fromRGB(230, 230, 235),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
    })

    local key = default
    local waiting = false
    local btn = new("TextButton", {
        Parent = holder,
        Size = UDim2.new(0, 90, 0, 22),
        Position = UDim2.new(1, -100, 0.5, -11),
        BackgroundColor3 = Color3.fromRGB(40, 40, 50),
        BorderSizePixel = 0,
        Text = key or "[None]",
        TextColor3 = Color3.fromRGB(230, 230, 235),
        Font = Enum.Font.Gotham,
        TextSize = 12,
        ZIndex = 4,
    })
    corner(btn, 6)

    btn.MouseButton1Click:Connect(function()
        waiting = true
        btn.Text = "..."
    end)

    UserInputService.InputBegan:Connect(function(input, gp)
        if waiting and not gp then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                key = input.KeyCode.Name
                btn.Text = key
                waiting = false
                if callback then callback(key) end
            end
        end
    end)

    return {
        Get = function() return key end
    }
end

local function makeButton(page, label, callback)
    local btn = new("TextButton", {
        Parent = page,
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = Color3.fromRGB(40, 40, 52),
        BorderSizePixel = 0,
        Text = label,
        TextColor3 = Color3.fromRGB(230, 230, 235),
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        AutoButtonColor = true,
        ZIndex = 3,
    })
    corner(btn, 6)
    addRow(page, 32)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

--==============================================================
-- FEATURES
--==============================================================
local Features = {
    Aimbot = false,
    AimbotTarget = "Head",
    AimbotSmoothness = 5,
    AimbotFOV = 350,
    AimbotMaxDist = 800,
    AimbotWallCheck = true,
    AimbotTeamCheck = true,

    TriggerBot = false,
    TriggerBotDelay = 0.05,
    TriggerBotAcquire = 0.12,
    TriggerBotWallCheck = true,
    TriggerBotTeamCheck = true,

    DeathLock = false,
    DeathLockTarget = "Head",
    DeathLockWallCheck = true,
    DeathLockTeamCheck = true,
    DeathLockUltra = false,
    DeathLockUltraTarget = "Mixed",
    DeathLockUltraWallCheck = true,
    DeathLockUltraTeamCheck = true,
    AimbotStickiness = 5,

    AutoShoot = false,
    AutoShootDelay = 0.07,
    AutoShootAcquire = 0.15,
    AutoShootTeamCheck = true,

    ESP = false,
    Boxes = false,
    Skeleton = false,
    Tracers = false,
    ShowLife = false,
    ShowNames = false,
    TracerColor = Color3.fromRGB(255, 255, 255),
    BoxColor = Color3.fromRGB(255, 255, 255),

    -- Rage (new)
    TPBehind = false,
    TPUp = false,
    ShootThroughWalls = false,
    InstaBackstab = false,

    SpeedHack = false,
    SpeedPower = 60,

    Noclip = false,

    Fly = false,
    FlySpeed = 50,
    SpinBot = false,
    SpinSpeed = 15,
    NotifyRivals = true,
    AutoSaveConfig = false,
    AutoExecute = false,

    NoMeleeCooldown = false,
    NoScopeCooldown = false,
}

local aimbotAllowedTime = tick() + 5
LocalPlayer.CharacterAdded:Connect(function()
    aimbotAllowedTime = tick() + 5
end)

local function InLobbyOrSafe()
    local char = LocalPlayer.Character
    if not char then return true end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or hum.Health <= 0 or not root then return true end
    if tick() < aimbotAllowedTime then return true end
    return false
end

-- Remote discovery
-- Multi-remote discovery (Rivals uses several shot pipelines)
local FireRemotes = {}
local function RegisterRemote(rem)
    if not rem then return end
    if not (rem:IsA("RemoteEvent") or rem:IsA("RemoteFunction")) then return end
    for _, r in ipairs(FireRemotes) do
        if r == rem then return end
    end
    table.insert(FireRemotes, rem)
    print("[Fanware] Fire remote:", rem:GetFullName())
end

local function FindFireRemotes()
    local nameHints = {
        "fire","shoot","shot","bullet","projectile","gun","weapon",
        "hit","damage","replicate","cast","ammo","ray","checkfire","fireserver"
    }
    local function nameLooksGood(n)
        n = string.lower(n)
        for _, h in ipairs(nameHints) do
            if n:find(h, 1, true) then return true end
        end
        return false
    end
    -- common folders first
    for _, folderName in ipairs({"ShooterRemotes","Remotes","WeaponRemotes","Events","GunRemotes","Combat","Weapons","Network"}) do
        local folder = ReplicatedStorage:FindFirstChild(folderName)
        if folder then
            for _, child in ipairs(folder:GetDescendants()) do
                if (child:IsA("RemoteEvent") or child:IsA("RemoteFunction")) and nameLooksGood(child.Name) then
                    RegisterRemote(child)
                end
            end
        end
    end
    -- full RS scan
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) and nameLooksGood(obj.Name) then
            RegisterRemote(obj)
        end
    end
    -- also watch for late-created remotes
    ReplicatedStorage.DescendantAdded:Connect(function(obj)
        if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) and nameLooksGood(obj.Name) then
            RegisterRemote(obj)
        end
    end)
end
FindFireRemotes()
if #FireRemotes == 0 then
    warn("[Fanware] No Fire remotes found yet — will keep watching")
end
local FireRemote = FireRemotes[1] -- legacy single ref for older calls

local function GetCharacter(player)
    return player and player.Character
end

local function GetHumanoid(character)
    return character and character:FindFirstChildOfClass("Humanoid")
end

local function IsAlive(character)
    local hum = GetHumanoid(character)
    return hum ~= nil and hum.Health > 0
end

local function GetRoot(character)
    if not character then return nil end
    return character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
end

local function GetPart(character, targetType)
    if not character then return nil end
    if targetType == "Head" then
        return character:FindFirstChild("Head") or GetRoot(character)
    elseif targetType == "Torso" then
        return character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso") or GetRoot(character)
    else
        return GetRoot(character)
    end
end

-- Rivals-friendly team check
-- Uses Team instance, TeamColor, and Neutral. If either side has no team, treat as enemy (FFA / unassigned).
local function IsEnemy(player)
    if not player or player == LocalPlayer then return false end
    local myTeam = LocalPlayer.Team
    local theirTeam = player.Team
    -- both have teams → compare instances
    if myTeam and theirTeam then
        if myTeam == theirTeam then return false end
        return true
    end
    -- TeamColor fallback (Rivals often keys on color)
    local myColor = LocalPlayer.TeamColor
    local theirColor = player.TeamColor
    if myColor and theirColor and myTeam and theirTeam then
        if myColor == theirColor then return false end
    end
    -- Neutral / no team → targetable in FFA style modes
    if LocalPlayer.Neutral or player.Neutral then
        return true
    end
    if not myTeam or not theirTeam then
        return true
    end
    return true
end

local function IsAnyPlayer(player)
    return player ~= nil and player ~= LocalPlayer
end

-- Wallcheck with larger tolerance (more studs / ignore tiny hits)
local function HasWallBetween(fromPos, toPos, ignoreList)
    local direction = toPos - fromPos
    local distance = direction.Magnitude
    if distance < 1 then return false end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = ignoreList or {LocalPlayer.Character}
    params.IgnoreWater = true
    -- cast slightly short so we don't count the target surface itself
    local result = Workspace:Raycast(fromPos, direction.Unit * (distance - 1.5), params)
    if not result then return false end
    local hitModel = result.Instance:FindFirstAncestorOfClass("Model")
    if hitModel and Players:GetPlayerFromCharacter(hitModel) then
        return false
    end
    -- ignore thin / non-collidable junk
    if result.Instance.CanCollide == false or result.Instance.Transparency >= 0.9 then
        return false
    end
    return true
end

local function IsVisible(part, fromCamera)
    if not part then return false end
    local origin
    if fromCamera then
        origin = Camera.CFrame.Position
    else
        local r = GetRoot(LocalPlayer.Character)
        origin = r and r.Position
    end
    if not origin then return false end
    local ignore = {LocalPlayer.Character}
    local targetChar = part:FindFirstAncestorOfClass("Model")
    if targetChar then table.insert(ignore, targetChar) end
    return not HasWallBetween(origin, part.Position, ignore)
end

-- Closest target — teamCheck=true => enemies only; false => all others
local function GetClosestTarget(targetType, maxFOV, maxDist, wallCheck, useCameraOrigin, teamCheck)
    local mousePos = UserInputService:GetMouseLocation()
    local closestPlayer, closestPart = nil, nil
    local shortestDist = maxFOV or math.huge
    local myRoot = GetRoot(LocalPlayer.Character)
    local origin = (useCameraOrigin and Camera.CFrame.Position) or (myRoot and myRoot.Position)

    for _, player in ipairs(Players:GetPlayers()) do
        local valid
        if teamCheck then
            valid = IsEnemy(player)
        else
            valid = IsAnyPlayer(player)
        end
        if valid then
            local char = GetCharacter(player)
            if char and IsAlive(char) then
                local part = GetPart(char, targetType)
                if part then
                    local dist3d = origin and (part.Position - origin).Magnitude or 0
                    if not maxDist or dist3d <= maxDist then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                        if onScreen and screenPos.Z > 0 then
                            local dist2d = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                            if dist2d < shortestDist then
                                if not wallCheck or IsVisible(part, useCameraOrigin) then
                                    shortestDist = dist2d
                                    closestPlayer = player
                                    closestPart = part
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPlayer, closestPart
end

-- pure 3D closest (for TP / shoot through walls)
local function GetClosestPlayer3D(ignoreTeam, maxDist)
    local myRoot = GetRoot(LocalPlayer.Character)
    if not myRoot then return nil, nil end
    local closest, closestRoot, best = nil, nil, maxDist or 9999
    for _, player in ipairs(Players:GetPlayers()) do
        local valid = ignoreTeam and IsAnyPlayer(player) or IsEnemy(player)
        if valid then
            local char = GetCharacter(player)
            if char and IsAlive(char) then
                local root = GetRoot(char)
                if root then
                    local d = (root.Position - myRoot.Position).Magnitude
                    if d < best then
                        best = d
                        closest = player
                        closestRoot = root
                    end
                end
            end
        end
    end
    return closest, closestRoot
end

-- Drawing ESP
local DrawingESP = {}
local function CreateDrawingESP(player)
    if player == LocalPlayer or DrawingESP[player] then return end
    local box = Drawing.new("Square")
    box.Visible = false
    box.Thickness = 1.5
    box.Filled = false
    box.Color = Features.BoxColor

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Thickness = 1.5
    tracer.Color = Features.TracerColor

    local infoText = Drawing.new("Text")
    infoText.Visible = false
    infoText.Center = true
    infoText.Outline = true
    infoText.OutlineColor = Color3.fromRGB(0, 0, 0)
    infoText.Size = 13
    infoText.Color = Color3.fromRGB(255, 255, 255)

    local skeletonLines = {
        HeadToTorso = Drawing.new("Line"),
        TorsoToLeftArm = Drawing.new("Line"),
        TorsoToRightArm = Drawing.new("Line"),
        TorsoToLeftLeg = Drawing.new("Line"),
        TorsoToRightLeg = Drawing.new("Line")
    }
    for _, line in pairs(skeletonLines) do
        line.Visible = false
        line.Thickness = 1.5
        line.Color = Features.BoxColor
    end
    DrawingESP[player] = {Box = box, Tracer = tracer, Text = infoText, Skeleton = skeletonLines}
end

local function RemoveDrawingESP(player)
    local data = DrawingESP[player]
    if data then
        if data.Box then data.Box:Remove() end
        if data.Tracer then data.Tracer:Remove() end
        if data.Text then data.Text:Remove() end
        for _, line in pairs(data.Skeleton) do line:Remove() end
        DrawingESP[player] = nil
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    CreateDrawingESP(p)
    p.CharacterAdded:Connect(function() task.wait(1) CreateDrawingESP(p) end)
end
Players.PlayerAdded:Connect(function(p)
    CreateDrawingESP(p)
    p.CharacterAdded:Connect(function() task.wait(1) CreateDrawingESP(p) end)
end)
Players.PlayerRemoving:Connect(RemoveDrawingESP)

local function FireAt(part, originOverride)
    if not part then return end
    local pos = part.Position
    local cf = part.CFrame
    local origin = originOverride
    if not origin then
        local r = GetRoot(LocalPlayer.Character)
        origin = r and r.Position or Camera.CFrame.Position
    end
    local dir = (pos - origin)
    if dir.Magnitude < 0.01 then dir = Camera.CFrame.LookVector else dir = dir.Unit end

    local function tryFire(rem)
        if not rem then return end
        -- common Rivals / FPS arg patterns
        pcall(function() rem:FireServer(pos) end)
        pcall(function() rem:FireServer(pos, part) end)
        pcall(function() rem:FireServer(part) end)
        pcall(function() rem:FireServer(cf) end)
        pcall(function() rem:FireServer(origin, pos) end)
        pcall(function() rem:FireServer(origin, dir) end)
        pcall(function() rem:FireServer(origin, dir * 500) end)
        pcall(function() rem:FireServer({Position = pos, Part = part, Origin = origin, Direction = dir}) end)
        pcall(function() rem:FireServer({pos, part, origin, dir}) end)
        pcall(function() rem:FireServer(pos.X, pos.Y, pos.Z) end)
    end

    if #FireRemotes > 0 then
        for _, rem in ipairs(FireRemotes) do
            tryFire(rem)
        end
    elseif FireRemote then
        tryFire(FireRemote)
    end
end

local function DoClick()
    pcall(function() if mouse1click then mouse1click() end end)
    pcall(function()
        if mouse1press then
            mouse1press()
            task.wait(0.02)
            mouse1release()
        end
    end)
    -- also try mouse2 for scoped weapons
    pcall(function()
        if mouse2press then
            -- don't force scope spam
        end
    end)
end

-- Main Loop
local triggerCooldown = false
local autoShootCooldown = false
local shootWallsCooldown = false
local flyBodyVelocity, flyBodyGyro
local lastTPBehind, lastTPUp = 0, 0
local triggerAcquirePlayer, triggerAcquireAt = nil, 0
local autoAcquirePlayer, autoAcquireAt = nil, 0

RunService.RenderStepped:Connect(function()
    local menuOpen = main.Visible
    local safe = InLobbyOrSafe()
    local myChar = LocalPlayer.Character
    local myRoot = myChar and GetRoot(myChar)

    -- 1. Aimbot (stickiness 1-10 = how hard it sticks to the part)
    if Features.Aimbot and not menuOpen and not safe then
        local _, targetPart = GetClosestTarget(
            Features.AimbotTarget,
            Features.AimbotFOV,
            Features.AimbotMaxDist,
            Features.AimbotWallCheck,
            true,
            Features.AimbotTeamCheck ~= false
        )
        if targetPart and mousemoverel then
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local delta = Vector2.new(screenPos.X, screenPos.Y) - mousePos
                local smooth = math.clamp(Features.AimbotSmoothness, 1, 20)
                -- stickiness: 1 = soft, 10 = almost snap (divides smooth)
                local stick = math.clamp(Features.AimbotStickiness or 5, 1, 10)
                local factor = smooth / (stick * 0.85)
                if factor < 0.35 then factor = 0.35 end
                mousemoverel(delta.X / factor, delta.Y / factor)
            end
        end
    end

    -- 2. Death Lock
    if Features.DeathLock and not menuOpen and not safe then
        local _, targetPart = GetClosestTarget(
            Features.DeathLockTarget,
            500,
            900,
            Features.DeathLockWallCheck,
            true,
            Features.DeathLockTeamCheck ~= false
        )
        if targetPart and mousemoverel then
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local delta = Vector2.new(screenPos.X, screenPos.Y) - mousePos
                mousemoverel(delta.X, delta.Y)
            end
        end
    end

    -- 2b. Death Lock ULTRA — cursor only (no camera force)
    if Features.DeathLockUltra and not menuOpen and not safe then
        local tgtMode = Features.DeathLockUltraTarget or "Mixed"
        local partType = tgtMode
        if tgtMode == "Mixed" then
            partType = (math.floor(tick() * 4) % 2 == 0) and "Head" or "Torso"
        end
        local _, targetPart = GetClosestTarget(
            partType,
            900,
            1500,
            Features.DeathLockUltraWallCheck,
            true,
            Features.DeathLockUltraTeamCheck ~= false
        )
        if targetPart and mousemoverel then
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
            if onScreen and screenPos.Z > 0 then
                local mousePos = UserInputService:GetMouseLocation()
                local dx = screenPos.X - mousePos.X
                local dy = screenPos.Y - mousePos.Y
                -- sticky cursor lock
                if math.abs(dx) > 0.35 or math.abs(dy) > 0.35 then
                    mousemoverel(dx, dy)
                end
            end
        end
    end

    -- 4. TriggerBot (acquire delay before first shot on a target)
    if Features.TriggerBot and not menuOpen and not safe and not triggerCooldown then
        local viewport = Camera.ViewportSize
        local ray = Camera:ViewportPointToRay(viewport.X / 2, viewport.Y / 2)
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {LocalPlayer.Character}
        local result = Workspace:Raycast(ray.Origin, ray.Direction * 2500, params)
        local shot = false
        if result then
            local char = result.Instance:FindFirstAncestorOfClass("Model")
            local player = char and Players:GetPlayerFromCharacter(char)
            local teamOk = true
            if Features.TriggerBotTeamCheck ~= false then
                teamOk = player and IsEnemy(player)
            else
                teamOk = player and player ~= LocalPlayer
            end
            if teamOk and char and IsAlive(char) then
                if not Features.TriggerBotWallCheck or IsVisible(result.Instance, true) then
                    if triggerAcquirePlayer ~= player then
                        triggerAcquirePlayer = player
                        triggerAcquireAt = tick()
                    end
                    local waitT = Features.TriggerBotAcquire or 0.12
                    if (tick() - triggerAcquireAt) >= waitT then
                        triggerCooldown = true
                        shot = true
                        DoClick()
                        FireAt(result.Instance)
                        task.delay(Features.TriggerBotDelay, function()
                            triggerCooldown = false
                        end)
                    end
                end
            end
        end
        if not shot and not result then
            triggerAcquirePlayer = nil
        end
    end

    -- 5. AutoShoot (acquire delay so you can actually aim first)
    if Features.AutoShoot and not menuOpen and not safe and not autoShootCooldown then
        local plr, part = GetClosestTarget(
            Features.AimbotTarget or "Head",
            Features.AimbotFOV or 350,
            900,
            Features.AimbotWallCheck,
            true,
            Features.AutoShootTeamCheck ~= false
        )
        if part and plr then
            if autoAcquirePlayer ~= plr then
                autoAcquirePlayer = plr
                autoAcquireAt = tick()
            end
            local waitT = Features.AutoShootAcquire or 0.15
            if (tick() - autoAcquireAt) >= waitT then
                autoShootCooldown = true
                DoClick()
                FireAt(part)
                task.delay(Features.AutoShootDelay, function()
                    autoShootCooldown = false
                end)
            end
        else
            autoAcquirePlayer = nil
        end
    end

    -- 6. ESP
    for player, data in pairs(DrawingESP) do
        local char = GetCharacter(player)
        local valid = Features.ESP and char and IsAlive(char) and IsEnemy(player)

        if not valid then
            data.Box.Visible = false
            data.Tracer.Visible = false
            data.Text.Visible = false
            for _, line in pairs(data.Skeleton) do line.Visible = false end
        else
            local root = GetRoot(char)
            local head = GetPart(char, "Head")
            if root and head then
                local rootPos, rootOnScreen = Camera:WorldToViewportPoint(root.Position)
                local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                local legPos = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                if rootOnScreen then
                    local height = math.abs(headPos.Y - legPos.Y)
                    local width = height / 2

                    if Features.Boxes then
                        data.Box.Size = Vector2.new(width, height)
                        data.Box.Position = Vector2.new(rootPos.X - width / 2, headPos.Y)
                        data.Box.Color = Features.BoxColor
                        data.Box.Visible = true
                    else
                        data.Box.Visible = false
                    end

                    if Features.ShowNames or Features.ShowLife then
                        local displayText = ""
                        if Features.ShowNames then displayText = player.Name end
                        if Features.ShowLife then
                            local hum = GetHumanoid(char)
                            if hum then
                                if displayText ~= "" then displayText = displayText .. " | " end
                                displayText = displayText .. math.floor(hum.Health) .. " HP"
                            end
                        end
                        data.Text.Text = displayText
                        data.Text.Position = Vector2.new(rootPos.X, headPos.Y - 16)
                        data.Text.Visible = true
                    else
                        data.Text.Visible = false
                    end

                    if Features.Tracers then
                        data.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        data.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                        data.Tracer.Color = Features.TracerColor
                        data.Tracer.Visible = true
                    else
                        data.Tracer.Visible = false
                    end

                    if Features.Skeleton then
                        local leftArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")
                        local rightArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
                        local leftLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")
                        local rightLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
                        local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
                        if torso and leftArm and rightArm and leftLeg and rightLeg then
                            local tPos = Camera:WorldToViewportPoint(torso.Position)
                            local hPos = Camera:WorldToViewportPoint(head.Position)
                            local laPos = Camera:WorldToViewportPoint(leftArm.Position)
                            local raPos = Camera:WorldToViewportPoint(rightArm.Position)
                            local llPos = Camera:WorldToViewportPoint(leftLeg.Position)
                            local rlPos = Camera:WorldToViewportPoint(rightLeg.Position)
                            data.Skeleton.HeadToTorso.From = Vector2.new(hPos.X, hPos.Y)
                            data.Skeleton.HeadToTorso.To = Vector2.new(tPos.X, tPos.Y)
                            data.Skeleton.HeadToTorso.Visible = true
                            data.Skeleton.TorsoToLeftArm.From = Vector2.new(tPos.X, tPos.Y)
                            data.Skeleton.TorsoToLeftArm.To = Vector2.new(laPos.X, laPos.Y)
                            data.Skeleton.TorsoToLeftArm.Visible = true
                            data.Skeleton.TorsoToRightArm.From = Vector2.new(tPos.X, tPos.Y)
                            data.Skeleton.TorsoToRightArm.To = Vector2.new(raPos.X, raPos.Y)
                            data.Skeleton.TorsoToRightArm.Visible = true
                            data.Skeleton.TorsoToLeftLeg.From = Vector2.new(tPos.X, tPos.Y)
                            data.Skeleton.TorsoToLeftLeg.To = Vector2.new(llPos.X, llPos.Y)
                            data.Skeleton.TorsoToLeftLeg.Visible = true
                            data.Skeleton.TorsoToRightLeg.From = Vector2.new(tPos.X, tPos.Y)
                            data.Skeleton.TorsoToRightLeg.To = Vector2.new(rlPos.X, rlPos.Y)
                            data.Skeleton.TorsoToRightLeg.Visible = true
                        else
                            for _, line in pairs(data.Skeleton) do line.Visible = false end
                        end
                    else
                        for _, line in pairs(data.Skeleton) do line.Visible = false end
                    end
                else
                    data.Box.Visible = false
                    data.Tracer.Visible = false
                    data.Text.Visible = false
                    for _, line in pairs(data.Skeleton) do line.Visible = false end
                end
            end
        end
    end

    -- 7. TP Behind (closest, ignore team)
    if Features.TPBehind and myRoot and not safe then
        if tick() - lastTPBehind > 0.15 then
            local _, targetRoot = GetClosestPlayer3D(true, 2000)
            if targetRoot then
                local behind = targetRoot.CFrame * CFrame.new(0, 0, 3.5)
                myRoot.CFrame = behind
                lastTPBehind = tick()
            end
        end
    end

    -- 8. TP Up (closest, ignore team) — snap once then settle, not continuous fly
    if Features.TPUp and myRoot and not safe then
        if tick() - lastTPUp > 0.45 then
            local _, targetRoot = GetClosestPlayer3D(true, 2000)
            if targetRoot then
                myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 5, 0)
                pcall(function()
                    myRoot.AssemblyLinearVelocity = Vector3.zero
                    myRoot.AssemblyAngularVelocity = Vector3.zero
                end)
                lastTPUp = tick()
            end
        end
    end

    -- 9. Shoot through walls / wallbang (closest enemy, no LOS required)
    if Features.ShootThroughWalls and not menuOpen and not safe and not shootWallsCooldown then
        local plr, targetRoot = GetClosestPlayer3D(false, 2000)
        if not targetRoot then
            -- team-aware fallback
            plr, targetRoot = GetClosestPlayer3D(true, 2000)
        end
        if targetRoot then
            local char = targetRoot.Parent
            local head = char and char:FindFirstChild("Head")
            local part = head or targetRoot
            shootWallsCooldown = true
            -- client click + multi-remote fire with spoofed origin near target (wallbang style)
            DoClick()
            -- origin slightly in front of target so server LOS from "shot origin" is clear
            local bangOrigin = part.Position - (Camera.CFrame.LookVector * 2)
            FireAt(part, bangOrigin)
            FireAt(part, part.Position + Vector3.new(0, 0.5, 0))
            task.delay(0.05, function()
                shootWallsCooldown = false
            end)
        end
    end

    -- 10. Insta Backstab
    if Features.InstaBackstab and myRoot and not menuOpen and not safe then
        for _, player in ipairs(Players:GetPlayers()) do
            if IsEnemy(player) then
                local char = GetCharacter(player)
                if char and IsAlive(char) then
                    local root = GetRoot(char)
                    if root and (root.Position - myRoot.Position).Magnitude < 14 then
                        FireAt(root)
                    end
                end
            end
        end
    end

    -- 11. Speed Hack (power 40-100)
    if Features.SpeedHack and myRoot and myChar then
        local hum = myChar:FindFirstChildOfClass("Humanoid")
        if hum and hum.MoveDirection.Magnitude > 0.05 then
            local power = math.clamp(Features.SpeedPower or 60, 40, 100)
            local boost = hum.MoveDirection * power
            local ok = pcall(function()
                local cur = myRoot.AssemblyLinearVelocity
                myRoot.AssemblyLinearVelocity = Vector3.new(boost.X, cur.Y, boost.Z)
            end)
            if not ok then
                pcall(function()
                    local cur = myRoot.Velocity
                    myRoot.Velocity = Vector3.new(boost.X, cur.Y, boost.Z)
                end)
            end
        end
    end

    -- 11b. Noclip
    if Features.Noclip and myChar then
        for _, part in ipairs(myChar:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- 12. Fly
    if Features.Fly and myRoot then
        if not flyBodyVelocity then
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            flyBodyVelocity.Parent = myRoot
        end
        if not flyBodyGyro then
            flyBodyGyro = Instance.new("BodyGyro")
            flyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            flyBodyGyro.Parent = myRoot
        end
        flyBodyGyro.CFrame = Camera.CFrame
        local moveDir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end
        if moveDir.Magnitude > 0.1 then
            flyBodyVelocity.Velocity = moveDir.Unit * Features.FlySpeed
        else
            flyBodyVelocity.Velocity = Vector3.zero
        end
    else
        if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
        if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
    end

    -- 13. SpinBot — character yaw (visible to others). First-person camera stays independent.
    if Features.SpinBot and myRoot then
        local spin = myRoot:FindFirstChild("FanwareSpin")
        if not spin then
            spin = Instance.new("BodyAngularVelocity")
            spin.Name = "FanwareSpin"
            spin.MaxTorque = Vector3.new(0, math.huge, 0)
            spin.P = 99999
            spin.Parent = myRoot
        end
        local spd = (Features.SpinSpeed or 15) * 3
        spin.AngularVelocity = Vector3.new(0, spd, 0)
        -- also force CFrame yaw so it registers even if physics fights it
        myRoot.CFrame = myRoot.CFrame * CFrame.Angles(0, math.rad(Features.SpinSpeed or 15), 0)
    else
        if myRoot then
            local spin = myRoot:FindFirstChild("FanwareSpin")
            if spin then spin:Destroy() end
        end
    end

    -- 14. Coils — no melee / scope cooldown (client-side attribute + remote spam safe)
    if Features.NoMeleeCooldown or Features.NoScopeCooldown then
        local char = LocalPlayer.Character
        if char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                if Features.NoMeleeCooldown then
                    pcall(function()
                        tool:SetAttribute("Cooldown", 0)
                        tool:SetAttribute("MeleeCooldown", 0)
                        tool:SetAttribute("SwingCooldown", 0)
                    end)
                    for _, v in ipairs(tool:GetDescendants()) do
                        if v:IsA("NumberValue") or v:IsA("IntValue") then
                            local n = string.lower(v.Name)
                            if n:find("cooldown") or n:find("cd") or n:find("delay") then
                                v.Value = 0
                            end
                        end
                    end
                end
                if Features.NoScopeCooldown then
                    pcall(function()
                        tool:SetAttribute("ScopeCooldown", 0)
                        tool:SetAttribute("AdsCooldown", 0)
                        tool:SetAttribute("AimCooldown", 0)
                    end)
                    for _, v in ipairs(tool:GetDescendants()) do
                        if v:IsA("NumberValue") or v:IsA("IntValue") then
                            local n = string.lower(v.Name)
                            if n:find("scope") or n:find("ads") or n:find("aimcd") then
                                v.Value = 0
                            end
                        end
                    end
                end
            end
        end
    end
end)

--==============================================================
-- COMBAT TAB
--==============================================================
local combat = tabs["Combat"].page

makeToggle(combat, "Aimbot", false, function(v) Features.Aimbot = v end)
makeDropdown(combat, "Aimbot Target", {"Head", "Torso", "Nearest"}, "Head", function(v) Features.AimbotTarget = v end)
makeSlider(combat, "Aimbot Smoothness", 1, 20, 5, function(v) Features.AimbotSmoothness = v end)
makeSlider(combat, "Aimbot Stickiness", 1, 10, 5, function(v) Features.AimbotStickiness = v end)
makeSlider(combat, "Aimbot FOV", 50, 700, 350, function(v) Features.AimbotFOV = v end)
makeSlider(combat, "Aimbot Max Dist", 100, 1500, 800, function(v) Features.AimbotMaxDist = v end)
makeToggle(combat, "Aimbot WallCheck", true, function(v) Features.AimbotWallCheck = v end)
makeToggle(combat, "Aimbot TeamCheck", true, function(v) Features.AimbotTeamCheck = v end)

makeToggle(combat, "TriggerBot", false, function(v) Features.TriggerBot = v end)
makeSlider(combat, "Trigger Delay (ms)", 20, 200, 50, function(v) Features.TriggerBotDelay = v / 1000 end)
makeSlider(combat, "Trigger Acquire (ms)", 0, 400, 120, function(v) Features.TriggerBotAcquire = v / 1000 end)
makeToggle(combat, "Trigger WallCheck", true, function(v) Features.TriggerBotWallCheck = v end)
makeToggle(combat, "Trigger TeamCheck", true, function(v) Features.TriggerBotTeamCheck = v end)

makeToggle(combat, "Death Lock", false, function(v) Features.DeathLock = v end)
makeDropdown(combat, "Death Lock Target", {"Head", "Torso", "Nearest"}, "Head", function(v) Features.DeathLockTarget = v end)
makeToggle(combat, "DeathLock WallCheck", true, function(v) Features.DeathLockWallCheck = v end)
makeToggle(combat, "DeathLock TeamCheck", true, function(v) Features.DeathLockTeamCheck = v end)

makeToggle(combat, "Death Lock ULTRA", false, function(v) Features.DeathLockUltra = v end)
makeDropdown(combat, "ULTRA Target", {"Head", "Torso", "Mixed"}, "Mixed", function(v) Features.DeathLockUltraTarget = v end)
makeToggle(combat, "ULTRA WallCheck", true, function(v) Features.DeathLockUltraWallCheck = v end)
makeToggle(combat, "ULTRA TeamCheck", true, function(v) Features.DeathLockUltraTeamCheck = v end)

makeToggle(combat, "Auto Shoot", false, function(v) Features.AutoShoot = v end)
makeSlider(combat, "AutoShoot Delay (ms)", 30, 200, 70, function(v) Features.AutoShootDelay = v / 1000 end)
makeSlider(combat, "AutoShoot Acquire (ms)", 0, 500, 150, function(v) Features.AutoShootAcquire = v / 1000 end)
makeToggle(combat, "AutoShoot TeamCheck", true, function(v) Features.AutoShootTeamCheck = v end)

--==============================================================
-- PLAYERS TAB
--==============================================================
local playersTab = tabs["Players"].page

local function parseColor(name)
    if name == "Red" then return Color3.fromRGB(255, 70, 70)
    elseif name == "Green" then return Color3.fromRGB(70, 255, 70)
    elseif name == "Blue" then return Color3.fromRGB(70, 130, 255)
    elseif name == "Purple" then return Color3.fromRGB(180, 70, 255)
    elseif name == "Yellow" then return Color3.fromRGB(255, 230, 70)
    else return Color3.fromRGB(255, 255, 255) end
end

makeToggle(playersTab, "ESP", false, function(v) Features.ESP = v end)
makeToggle(playersTab, "  └ Boxes", false, function(v) Features.Boxes = v end)
makeToggle(playersTab, "  └ Skeleton", false, function(v) Features.Skeleton = v end)
makeToggle(playersTab, "  └ Tracers", false, function(v) Features.Tracers = v end)
makeToggle(playersTab, "Show Life", false, function(v) Features.ShowLife = v end)
makeToggle(playersTab, "Show Names", false, function(v) Features.ShowNames = v end)
makeDropdown(playersTab, "Tracer Color", {"White", "Red", "Green", "Blue", "Purple", "Yellow"}, "White", function(v)
    Features.TracerColor = parseColor(v)
end)
makeDropdown(playersTab, "Box Color", {"White", "Red", "Green", "Blue", "Purple", "Yellow"}, "White", function(v)
    Features.BoxColor = parseColor(v)
end)

--==============================================================
-- MISC TAB (rage)
--==============================================================
local misc = tabs["Misc."].page

makeToggle(misc, "TP Behind", false, function(v) Features.TPBehind = v end)
makeToggle(misc, "TP Up", false, function(v) Features.TPUp = v end)
makeToggle(misc, "Shoot Through Walls", false, function(v) Features.ShootThroughWalls = v end)
makeToggle(misc, "Insta Backstab", false, function(v) Features.InstaBackstab = v end)

makeToggle(misc, "Speed Hack", false, function(v) Features.SpeedHack = v end)
makeSlider(misc, "  └ Speed Power", 40, 100, 60, function(v) Features.SpeedPower = v end)

makeToggle(misc, "Noclip", false, function(v) Features.Noclip = v end)

makeToggle(misc, "Fly", false, function(v) Features.Fly = v end)
makeSlider(misc, "  └ Fly Speed", 1, 150, 50, function(v) Features.FlySpeed = v end)

makeToggle(misc, "SpinBot", false, function(v) Features.SpinBot = v end)
makeSlider(misc, "  └ Spin Speed", 5, 40, 15, function(v) Features.SpinSpeed = v end)

--==============================================================
-- COILS TAB
--==============================================================
local coils = tabs["Coils"].page
makeToggle(coils, "No Melee Cooldown", false, function(v) Features.NoMeleeCooldown = v end)
makeToggle(coils, "No Scope Cooldown", false, function(v) Features.NoScopeCooldown = v end)
new("TextLabel", {
    Parent = coils,
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundTransparency = 1,
    Text = "Client-side cooldown strip.\nWorks when tools expose cooldown values/attributes.",
    TextColor3 = Color3.fromRGB(150, 150, 165),
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 3,
})
addRow(coils, 50)

--==============================================================
-- SETTINGS TAB
--==============================================================
local settings = tabs["Settings"].page

makeToggle(settings, "Notify when someone is cheating", true, function(v) Features.NotifyRivals = v end)
makeToggle(settings, "Auto save config", false, function(v) Features.AutoSaveConfig = v end)
makeToggle(settings, "Auto execute on rejoin", false, function(v) Features.AutoExecute = v end)

local CONFIG_KEYS = {
    "Aimbot","AimbotTarget","AimbotSmoothness","AimbotFOV","AimbotMaxDist","AimbotWallCheck","AimbotTeamCheck","AimbotStickiness",
    "TriggerBot","TriggerBotDelay","TriggerBotAcquire","TriggerBotWallCheck","TriggerBotTeamCheck",
    "DeathLock","DeathLockTarget","DeathLockWallCheck","DeathLockTeamCheck",
    "DeathLockUltra","DeathLockUltraTarget","DeathLockUltraWallCheck","DeathLockUltraTeamCheck",
    "AutoShoot","AutoShootDelay","AutoShootAcquire","AutoShootTeamCheck",
    "ESP","Boxes","Skeleton","Tracers","ShowLife","ShowNames",
    "TPBehind","TPUp","ShootThroughWalls","InstaBackstab",
    "SpeedHack","SpeedPower","Noclip","Fly","FlySpeed","SpinBot","SpinSpeed",
    "NoMeleeCooldown","NoScopeCooldown","NotifyRivals","AutoSaveConfig","AutoExecute",
}

local function BuildConfigTable()
    local t = {}
    for _, k in ipairs(CONFIG_KEYS) do
        local v = Features[k]
        if typeof(v) == "Color3" then
            t[k] = {v.R, v.G, v.B}
        else
            t[k] = v
        end
    end
    return t
end

local function ApplyConfigTable(t)
    if type(t) ~= "table" then return false end
    for _, k in ipairs(CONFIG_KEYS) do
        if t[k] ~= nil then
            Features[k] = t[k]
        end
    end
    return true
end

local function SerializeConfig(t)
    local parts = {"{"}
    for k, v in pairs(t) do
        local key = string.format("[%q]", k)
        local val
        if type(v) == "string" then
            val = string.format("%q", v)
        elseif type(v) == "boolean" or type(v) == "number" then
            val = tostring(v)
        elseif type(v) == "table" then
            val = string.format("{%s,%s,%s}", tostring(v[1]), tostring(v[2]), tostring(v[3]))
        else
            val = "nil"
        end
        table.insert(parts, key .. "=" .. val .. ",")
    end
    table.insert(parts, "}")
    return table.concat(parts)
end

makeButton(settings, "Export Setting", function()
    local code = "--FANWARE_CFG--" .. SerializeConfig(BuildConfigTable()) .. "--END--"
    if setclipboard then
        pcall(function() setclipboard(code) end)
        print("[Fanware] Config copied to clipboard")
    else
        print("[Fanware] Export (copy this):")
        print(code)
    end
    -- also show in a small notify
    pcall(function()
        local g = Instance.new("ScreenGui")
        g.Name = "FanwareExport"
        g.Parent = CoreGui
        local f = Instance.new("TextLabel")
        f.Size = UDim2.new(0, 320, 0, 40)
        f.Position = UDim2.new(0.5, -160, 0.1, 0)
        f.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
        f.TextColor3 = Color3.fromRGB(200, 230, 255)
        f.Font = Enum.Font.Gotham
        f.TextSize = 13
        f.Text = setclipboard and "Config copied to clipboard" or "Config printed to console"
        f.Parent = g
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
        task.delay(2.5, function() g:Destroy() end)
    end)
end)

makeButton(settings, "Import Setting", function()
    local box = Instance.new("ScreenGui")
    box.Name = "FanwareImport"
    box.Parent = CoreGui
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 420, 0, 160)
    frame.Position = UDim2.new(0.5, -210, 0.5, -80)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    frame.Parent = box
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 24)
    title.Position = UDim2.new(0, 10, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = "Paste Fanware config code"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame
    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -20, 0, 70)
    input.Position = UDim2.new(0, 10, 0, 36)
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    input.TextColor3 = Color3.fromRGB(220, 220, 230)
    input.Font = Enum.Font.Code
    input.TextSize = 11
    input.Text = ""
    input.ClearTextOnFocus = false
    input.TextWrapped = true
    input.MultiLine = true
    input.Parent = frame
    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
    local apply = Instance.new("TextButton")
    apply.Size = UDim2.new(0.5, -14, 0, 32)
    apply.Position = UDim2.new(0, 10, 1, -42)
    apply.BackgroundColor3 = Color3.fromRGB(50, 90, 200)
    apply.Text = "Apply"
    apply.TextColor3 = Color3.fromRGB(255, 255, 255)
    apply.Font = Enum.Font.GothamMedium
    apply.TextSize = 13
    apply.Parent = frame
    Instance.new("UICorner", apply).CornerRadius = UDim.new(0, 6)
    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0.5, -14, 0, 32)
    cancel.Position = UDim2.new(0.5, 4, 1, -42)
    cancel.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    cancel.Text = "Cancel"
    cancel.TextColor3 = Color3.fromRGB(230, 230, 235)
    cancel.Font = Enum.Font.GothamMedium
    cancel.TextSize = 13
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)
    cancel.MouseButton1Click:Connect(function() box:Destroy() end)
    apply.MouseButton1Click:Connect(function()
        local raw = input.Text or ""
        local body = raw:match("%-%-FANWARE_CFG%-%-(.-)%-%-END%-%-") or raw
        local ok, tbl = pcall(function()
            return loadstring("return " .. body)()
        end)
        if ok and ApplyConfigTable(tbl) then
            print("[Fanware] Config imported")
        else
            warn("[Fanware] Import failed — bad code")
        end
        box:Destroy()
    end)
end)

-- cheat notify UI (bottom left)
local function NotifyCheater(name)
    if not Features.NotifyRivals then return end
    pcall(function()
        local g = Instance.new("ScreenGui")
        g.Name = "FanwareCheatNotify"
        g.ResetOnSpawn = false
        g.Parent = CoreGui
        local f = Instance.new("TextLabel")
        f.Size = UDim2.new(0, 340, 0, 44)
        f.Position = UDim2.new(0, 16, 1, -70)
        f.BackgroundColor3 = Color3.fromRGB(22, 18, 18)
        f.TextColor3 = Color3.fromRGB(255, 200, 120)
        f.Font = Enum.Font.GothamMedium
        f.TextSize = 14
        f.TextXAlignment = Enum.TextXAlignment.Left
        f.Text = "  " .. tostring(name) .. " is cheating in legos LOL"
        f.Parent = g
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
        local s = Instance.new("UIStroke")
        s.Color = Color3.fromRGB(180, 80, 60)
        s.Thickness = 1
        s.Parent = f
        task.delay(4, function() g:Destroy() end)
    end)
end

-- simple heuristic: spin velocity / insane move speed flags (best-effort)
local flagged = {}
task.spawn(function()
    while task.wait(2.5) do
        if not Features.NotifyRivals then continue end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and not flagged[p] then
                local char = p.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if root and hum then
                    local spd = root.AssemblyLinearVelocity.Magnitude
                    if spd > 120 or hum.WalkSpeed > 40 then
                        flagged[p] = true
                        NotifyCheater(p.Name)
                    end
                end
            end
        end
    end
end)
Players.PlayerRemoving:Connect(function(p) flagged[p] = nil end)

-- Auto save config to executor writefile if available
local function SaveConfigDisk()
    if not Features.AutoSaveConfig then return end
    pcall(function()
        if writefile then
            local code = "--FANWARE_CFG--" .. SerializeConfig(BuildConfigTable()) .. "--END--"
            writefile("Fanware_Config.txt", code)
        end
    end)
end

task.spawn(function()
    while task.wait(8) do
        SaveConfigDisk()
    end
end)

-- Auto execute: store loadstring path note (executor dependent)
if Features.AutoExecute then
    pcall(function()
        if writefile and readfile then
            -- keep a marker so user can queue on rejoin manually / via autoexec folder
            writefile("Fanware_AutoExec.txt", "Fansware_Fixed.luau v2.9")
        end
    end)
end


new("TextLabel", {
    Parent = settings,
    Size = UDim2.new(1, 0, 0, 70),
    BackgroundTransparency = 1,
    Text = "Supported executors: All\nJoin Discord: discord.gg/g9UAV8xC2p\nv2: silent hooks + TP rage + wallcheck + slide 40-100",
    TextColor3 = Color3.fromRGB(150, 150, 165),
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    LayoutOrder = 999,
    ZIndex = 3,
})
addRow(settings, 70)

--==============================================================
-- RIGHT SHIFT TOGGLE
--==============================================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
        if activeDropdownList then
            activeDropdownList:Destroy()
            activeDropdownList = nil
        end
    elseif input.KeyCode == Enum.KeyCode.P then
        Features.Aimbot = not Features.Aimbot
        print("[Fanware] Aimbot:", Features.Aimbot and "ON" or "OFF")
    elseif input.KeyCode == Enum.KeyCode.Q then
        Features.DeathLockUltra = not Features.DeathLockUltra
        print("[Fanware] Death Lock ULTRA:", Features.DeathLockUltra and "ON" or "OFF")
    end
end)

--==============================================================
-- DRAG
--==============================================================
do
    local dragging, dragStart, startPos
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
            if activeDropdownList then
                activeDropdownList:Destroy()
                activeDropdownList = nil
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

print("[Fanware] v3.0 loaded — Shoot Through Walls multi-remote wallbang.")
