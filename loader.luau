--==============================================================
-- Fanware | Best script
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
-- 1. WELCOME NOTIFICATION (bottom right)
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

task.wait(4)

TweenService:Create(notify, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
    Position = UDim2.new(1, 320, 1, -100)
}):Play()

task.wait(0.6)
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

task.wait(5)
spinning = false
LoadGui:Destroy()

--==============================================================
-- 3. MAIN MENU
--==============================================================
local main = new("Frame", {
    Parent = ScreenGui,
    Size = UDim2.new(0, 520, 0, 340),
    Position = UDim2.new(0.5, -260, 0.5, -170),
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
    Text = "RightShift = toggle",
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
local tabNames = {"Combat", "Players", "Misc.", "Settings"}

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

            local layout = new("UIListLayout", {
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
        Size = UDim2.new((val - min) / (max - min), 0, 1, 0),
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
            fill.Size = UDim2.new((v - min) / (max - min), 0, 1, 0)
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

--==============================================================
-- SCRIPT FUNCTIONALITY IMPLEMENTATION
--==============================================================
local Features = {
    Aimbot = false,
    AimbotTarget = "Head",
    AimbotSmoothness = 5,
    TriggerBot = false,
    SilentAim = false,
    SilentAimTarget = "Head",
    DeathLock = false,
    DeathLockTarget = "Head",
    AutoShoot = false,
    ESP = false,
    Boxes = false,
    Skeleton = false,
    Tracers = false,
    ShowLife = false,
    ShowNames = false,
    TracerColor = Color3.fromRGB(255, 255, 255),
    BoxColor = Color3.fromRGB(255, 255, 255),
    AutoKill = false,
    RageBot = false,
    InstaBackstab = false,
    MatrixSlide = false,
    SlidePower = false,
    PowerVal = 1,
    Fly = false,
    FlySpeed = 50,
    NotifyRivals = true
}

-- Control de 5 segundos de espera al reaparecer/cambiar de arma
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

local RemoteFolder = ReplicatedStorage:FindFirstChild("ShooterRemotes")
local FireRemote = RemoteFolder and RemoteFolder:FindFirstChild("Fire")

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
    return character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
end

local function GetPart(character, targetType)
    if targetType == "Head" then
        return character:FindFirstChild("Head") or GetRoot(character)
    elseif targetType == "Torso" then
        return character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso") or GetRoot(character)
    else
        return GetRoot(character)
    end
end

local function IsEnemy(player)
    if player == LocalPlayer then return false end
    if LocalPlayer.Team and player.Team then
        return player.Team ~= LocalPlayer.Team
    end
    return true
end

local function GetClosestTarget(targetType)
    local mousePos = UserInputService:GetMouseLocation()
    local closestPlayer, closestPart = nil, nil
    local shortestDist = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if IsEnemy(player) then
            local char = GetCharacter(player)
            if char and IsAlive(char) then
                local part = GetPart(char, targetType)
                if part then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen and screenPos.Z > 0 then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if dist < shortestDist then
                            shortestDist = dist
                            closestPlayer = player
                            closestPart = part
                        end
                    end
                end
            end
        end
    end
    return closestPlayer, closestPart
end

-- Drawing ESP Objects Management
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
        for _, line in pairs(data.Skeleton) do
            line:Remove()
        end
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

-- Main Loop
local triggerCooldown = false
local flyBodyVelocity, flyBodyGyro

RunService.RenderStepped:Connect(function()
    -- 1. Mouse-based Aimbot Logic (Con restricciones de Menú, Lobby y 5s de espera)
    if Features.Aimbot and main.Visible == false and not InLobbyOrSafe() then
        local _, targetPart = GetClosestTarget(Features.AimbotTarget)
        if targetPart then
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local targetScreen = Vector2.new(screenPos.X, screenPos.Y)
                local delta = targetScreen - mousePos
                local smooth = math.clamp(Features.AimbotSmoothness, 1, 20)
                if mousemoverel then
                    mousemoverel(delta.X / smooth, delta.Y / smooth)
                end
            end
        end
    end

    -- 2. Death Lock Logic
    if Features.DeathLock and main.Visible == false and not InLobbyOrSafe() then
        local _, targetPart = GetClosestTarget(Features.DeathLockTarget)
        if targetPart then
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
            if onScreen and mousemoverel then
                local mousePos = UserInputService:GetMouseLocation()
                local delta = Vector2.new(screenPos.X, screenPos.Y) - mousePos
                mousemoverel(delta.X, delta.Y)
            end
        end
    end

    -- 3. TriggerBot & Auto Shoot
    if (Features.TriggerBot or Features.AutoShoot) and main.Visible == false and not InLobbyOrSafe() and not triggerCooldown then
        local viewport = Camera.ViewportSize
        local ray = Camera:ViewportPointToRay(viewport.X / 2, viewport.Y / 2)
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {LocalPlayer.Character}
        local result = Workspace:Raycast(ray.Origin, ray.Direction * 1500, params)
        if result then
            local char = result.Instance:FindFirstAncestorOfClass("Model")
            local player = char and Players:GetPlayerFromCharacter(char)
            if player and IsEnemy(player) and IsAlive(char) then
                triggerCooldown = true
                if FireRemote then
                    pcall(function() FireRemote:FireServer(result.Position, result.Instance) end)
                end
                task.delay(0.08, function() triggerCooldown = false end)
            end
        end
    end

    -- 4. Drawing ESP Updates
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
                local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                local legPos, legOnScreen = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))

                if rootOnScreen then
                    local height = math.abs(headPos.Y - legPos.Y)
                    local width = height / 2

                    -- Boxes
                    if Features.Boxes then
                        data.Box.Size = Vector2.new(width, height)
                        data.Box.Position = Vector2.new(rootPos.X - width / 2, headPos.Y)
                        data.Box.Color = Features.BoxColor
                        data.Box.Visible = true
                    else
                        data.Box.Visible = false
                    end

                    -- Text (Show Life & Show Names)
                    if Features.ShowNames or Features.ShowLife then
                        local displayText = ""
                        if Features.ShowNames then
                            displayText = player.Name
                        end
                        if Features.ShowLife then
                            local hum = GetHumanoid(char)
                            if hum then
                                if displayText ~= "" then
                                    displayText = displayText .. " | "
                                end
                                displayText = displayText .. math.floor(hum.Health) .. " HP"
                            end
                        end
                        data.Text.Text = displayText
                        data.Text.Position = Vector2.new(rootPos.X, headPos.Y - 16)
                        data.Text.Visible = true
                    else
                        data.Text.Visible = false
                    end

                    -- Tracers
                    if Features.Tracers then
                        data.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        data.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                        data.Tracer.Color = Features.TracerColor
                        data.Tracer.Visible = true
                    else
                        data.Tracer.Visible = false
                    end

                    -- Skeleton
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

    -- 5. Auto Kill / Rage Bot
    if (Features.AutoKill or Features.RageBot) and main.Visible == false and not InLobbyOrSafe() then
        for _, player in ipairs(Players:GetPlayers()) do
            if IsEnemy(player) then
                local char = GetCharacter(player)
                if char and IsAlive(char) then
                    local root = GetRoot(char)
                    if root and FireRemote then
                        pcall(function() FireRemote:FireServer(root.Position, root) end)
                    end
                end
            end
        end
    end

    -- 6. Insta Backstab
    if Features.InstaBackstab and main.Visible == false and not InLobbyOrSafe() then
        for _, player in ipairs(Players:GetPlayers()) do
            if IsEnemy(player) then
                local char = GetCharacter(player)
                if char and IsAlive(char) then
                    local root = GetRoot(char)
                    local myRoot = GetRoot(LocalPlayer.Character)
                    if root and myRoot and (root.Position - myRoot.Position).Magnitude < 10 then
                        pcall(function()
                            if FireRemote then FireRemote:FireServer(root.Position, root) end
                        end)
                    end
                end
            end
        end
    end

    -- 7. Matrix Slide
    if Features.MatrixSlide then
        pcall(function()
            local char = LocalPlayer.Character
            local root = GetRoot(char)
            if root and char:FindFirstChildOfClass("Humanoid") then
                if char:FindFirstChildOfClass("Humanoid").MoveDirection.Magnitude > 0 then
                    root.Velocity = root.Velocity + (char:FindFirstChildOfClass("Humanoid").MoveDirection * (Features.SlidePower and Features.PowerVal or 3) * 2)
                end
            end
        end)
    end

    -- 8. Fly
    local char = LocalPlayer.Character
    local root = char and GetRoot(char)
    if Features.Fly and root then
        if not flyBodyVelocity then
            flyBodyVelocity = Instance.new("BodyVelocity", root)
            flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        end
        if not flyBodyGyro then
            flyBodyGyro = Instance.new("BodyGyro", root)
            flyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        end
        flyBodyGyro.CFrame = Camera.CFrame
        local moveDir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        flyBodyVelocity.Velocity = moveDir * Features.FlySpeed
    else
        if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
        if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
    end
end)

--==============================================================
-- COMBAT TAB
--==============================================================
local combat = tabs["Combat"].page

makeToggle(combat, "Aimbot", false, function(v) Features.Aimbot = v end)
makeDropdown(combat, "Aimbot Target", {"Head", "Torso", "Nearest"}, "Head", function(v) Features.AimbotTarget = v end)
makeSlider(combat, "Aimbot Smoothness", 1, 20, 5, function(v) Features.AimbotSmoothness = v end)

makeToggle(combat, "TriggerBot", false, function(v) Features.TriggerBot = v end)
makeToggle(combat, "Silent Aim", false, function(v) Features.SilentAim = v end)
makeDropdown(combat, "Silent Aim Target", {"Head", "Torso", "Nearest"}, "Head", function(v) Features.SilentAimTarget = v end)
makeToggle(combat, "Death Lock", false, function(v) Features.DeathLock = v end)
makeDropdown(combat, "Death Lock Target", {"Head", "Torso", "Nearest"}, "Head", function(v) Features.DeathLockTarget = v end)
makeToggle(combat, "Auto Shoot", false, function(v) Features.AutoShoot = v end)

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
-- MISC TAB
--==============================================================
local misc = tabs["Misc."].page

makeToggle(misc, "Auto Kill", false, function(v) Features.AutoKill = v end)
makeKeybind(misc, "  └ Keybind", nil)
makeToggle(misc, "Rage Bot", false, function(v) Features.RageBot = v end)
makeKeybind(misc, "  └ Keybind", nil)
makeToggle(misc, "Insta Backstab", false, function(v) Features.InstaBackstab = v end)
makeKeybind(misc, "  └ Keybind", nil)
makeToggle(misc, "Matrix Slide", false, function(v) Features.MatrixSlide = v end)
makeToggle(misc, "Slide Power", false, function(v) Features.SlidePower = v end)
makeSlider(misc, "  └ Power", 1, 10, 1, function(v) Features.PowerVal = v end)
makeToggle(misc, "Fly", false, function(v) Features.Fly = v end)
makeSlider(misc, "  └ Fly Speed", 1, 100, 50, function(v) Features.FlySpeed = v end)

--==============================================================
-- SETTINGS TAB
--==============================================================
local settings = tabs["Settings"].page

makeToggle(settings, "Notify when someone is using cheats (rival)", true, function(v) Features.NotifyRivals = v end)
makeToggle(settings, "Auto save and auto execute after", false)
makeKeybind(settings, "  └ Auto Save Keybind", nil)

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

makeButton(settings, "Import Setting", function()
    print("[Fanware] Import Setting pressed")
end)

makeButton(settings, "Export Setting", function()
    print("[Fanware] Export Setting pressed")
end)

new("TextLabel", {
    Parent = settings,
    Size = UDim2.new(1, 0, 0, 60),
    BackgroundTransparency = 1,
    Text = "Supported executors: All\nJoin Discord: discord.gg/g9UAV8xC2p",
    TextColor3 = Color3.fromRGB(150, 150, 165),
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    LayoutOrder = 999,
    ZIndex = 3,
})
addRow(settings, 60)

--==============================================================
-- RIGHT SHIFT TOGGLE & MENU CLOSING ON CLICK
--==============================================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
        if activeDropdownList then
            activeDropdownList:Destroy()
            activeDropdownList = nil
        end
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
            or input.UserInputType == Enum.UserInputType.Touch souvenir then
            dragging = false
        end
    end)
end

print("[Fanware] Clean script loaded without Skin Changer.")
