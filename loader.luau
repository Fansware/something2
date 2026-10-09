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

local LocalPlayer = Players.LocalPlayer

--==============================================================
-- CLEANUP OLD INSTANCES
--==============================================================
pcall(function()
    if CoreGui:FindFirstChild("FanwareUI") then
        CoreGui.FanwareUI:Destroy()
    end
end)

--==============================================================
-- MAIN GUI
--==============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FanwareUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
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
    Parent = CoreGui
})

local notify = new("Frame", {
    Parent = NotifyGui,
    Size = UDim2.new(0, 300, 0, 70),
    Position = UDim2.new(1, 320, 1, -100), -- off screen right
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

-- Slide in
TweenService:Create(notify, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
    Position = UDim2.new(1, -320, 1, -100)
}):Play()

task.wait(4)

-- Slide out
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

-- Spin animation
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
-- 3. MAIN MENU (draggable, toggle with RightShift)
--==============================================================
local main = new("Frame", {
    Parent = ScreenGui,
    Size = UDim2.new(0, 520, 0, 340),
    Position = UDim2.new(0.5, -260, 0.5, -170),
    BackgroundColor3 = Color3.fromRGB(18, 18, 24),
    BorderSizePixel = 0,
    Active = true,
    Draggable = true,
    Visible = true,
})
corner(main, 12)
stroke(main, Color3.fromRGB(90, 90, 110), 1)

-- Top bar
local topBar = new("Frame", {
    Parent = main,
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = Color3.fromRGB(24, 24, 32),
    BorderSizePixel = 0,
})
corner(topBar, 12)
new("Frame", {
    Parent = topBar,
    Size = UDim2.new(1, 0, 0, 12),
    Position = UDim2.new(0, 0, 1, -12),
    BackgroundColor3 = Color3.fromRGB(24, 24, 32),
    BorderSizePixel = 0,
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
})

-- Tab bar
local tabBar = new("Frame", {
    Parent = main,
    Size = UDim2.new(0, 130, 1, -50),
    Position = UDim2.new(0, 10, 0, 45),
    BackgroundTransparency = 1,
})

-- Content area
local content = new("Frame", {
    Parent = main,
    Size = UDim2.new(1, -160, 1, -60),
    Position = UDim2.new(0, 150, 0, 50),
    BackgroundColor3 = Color3.fromRGB(22, 22, 30),
    BorderSizePixel = 0,
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
    })
    local layout = new("UIListLayout", {
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

for _, name in ipairs(tabNames) do
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
-- UI ELEMENT HELPERS (toggle, dropdown, slider, keybind)
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
    })

    local state = default or false

    local track = new("Frame", {
        Parent = holder,
        Size = UDim2.new(0, 40, 0, 20),
        Position = UDim2.new(1, -50, 0.5, -10),
        BackgroundColor3 = state and Color3.fromRGB(50, 90, 200) or Color3.fromRGB(60, 60, 70),
        BorderSizePixel = 0,
    })
    corner(track, 10)

    local knob = new("Frame", {
        Parent = track,
        Size = UDim2.new(0, 16, 0, 16),
        Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
    })
    corner(knob, 8)

    local click = new("TextButton", {
        Parent = holder,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
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

local function makeDropdown(page, label, options, default, callback)
    local holder = new("Frame", {
        Parent = page,
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(28, 28, 36),
        BorderSizePixel = 0,
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
    })
    corner(btn, 6)

    local open = false
    local list

    btn.MouseButton1Click:Connect(function()
        open = not open
        if open then
            list = new("Frame", {
                Parent = holder,
                Size = UDim2.new(0, 120, 0, #options * 22),
                Position = UDim2.new(1, -130, 1, 2),
                BackgroundColor3 = Color3.fromRGB(30, 30, 38),
                BorderSizePixel = 0,
                ZIndex = 10,
            })
            corner(list, 6)
            stroke(list, Color3.fromRGB(70, 70, 85), 1)

            for _, opt in ipairs(options) do
                local ob = new("TextButton", {
                    Parent = list,
                    Size = UDim2.new(1, 0, 0, 22),
                    BackgroundColor3 = Color3.fromRGB(30, 30, 38),
                    BorderSizePixel = 0,
                    Text = opt,
                    TextColor3 = Color3.fromRGB(220, 220, 225),
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    ZIndex = 11,
                })
                ob.MouseButton1Click:Connect(function()
                    selected = opt
                    btn.Text = opt
                    if callback then callback(opt) end
                    if list then list:Destroy() list = nil end
                    open = false
                end)
            end
        else
            if list then list:Destroy() list = nil end
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
    })

    local bar = new("Frame", {
        Parent = holder,
        Size = UDim2.new(1, -20, 0, 6),
        Position = UDim2.new(0, 10, 1, -14),
        BackgroundColor3 = Color3.fromRGB(45, 45, 55),
        BorderSizePixel = 0,
    })
    corner(bar, 3)

    local fill = new("Frame", {
        Parent = bar,
        Size = UDim2.new((val - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(50, 90, 200),
        BorderSizePixel = 0,
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
-- COMBAT TAB
--==============================================================
local combat = tabs["Combat"].page

makeToggle(combat, "Aimbot", false)
makeDropdown(combat, "Aimbot Target", {"Head", "Torso", "Nearest"}, "Head")
makeSlider(combat, "Aimbot Smoothness", 1, 20, 5)

makeToggle(combat, "TriggerBot", false)
makeToggle(combat, "Silent Aim", false)
makeDropdown(combat, "Silent Aim Target", {"Head", "Torso", "Nearest"}, "Head")
makeToggle(combat, "Death Lock", false)
makeDropdown(combat, "Death Lock Target", {"Head", "Torso", "Nearest"}, "Head")
makeToggle(combat, "Auto Shoot", false)

--==============================================================
-- PLAYERS TAB
--==============================================================
local playersTab = tabs["Players"].page

makeToggle(playersTab, "ESP", false)
makeToggle(playersTab, "  └ Boxes", false)
makeToggle(playersTab, "  └ Skeleton", false)
makeToggle(playersTab, "  └ Tracers", false)
makeToggle(playersTab, "Show Life", false)
makeToggle(playersTab, "Show Names", false)
makeDropdown(playersTab, "Tracer Color", {"White", "Red", "Green", "Blue", "Purple", "Yellow"}, "White")
makeDropdown(playersTab, "Box Color", {"White", "Red", "Green", "Blue", "Purple", "Yellow"}, "White")

--==============================================================
-- MISC TAB
--==============================================================
local misc = tabs["Misc."].page

makeToggle(misc, "Auto Kill", false)
makeKeybind(misc, "  └ Keybind", nil)
makeToggle(misc, "Rage Bot", false)
makeKeybind(misc, "  └ Keybind", nil)
makeToggle(misc, "Insta Backstab", false)
makeKeybind(misc, "  └ Keybind", nil)
makeToggle(misc, "Matrix Slide", false)
makeToggle(misc, "Slide Power", false)
makeSlider(misc, "  └ Power", 1, 10, 1)
makeToggle(misc, "Fly", false)
makeSlider(misc, "  └ Fly Speed", 1, 100, 50)

--==============================================================
-- SETTINGS TAB
--==============================================================
local settings = tabs["Settings"].page


makeToggle(settings, "Notify when someone is using cheats (rival)", true)
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
    })
    corner(btn, 6)
    addRow(page, 32)

    btn.MouseButton1Click:Connect(callback)
    return btn
end

makeButton(settings, "Import Setting", function()
    print("[Fanware] Import Setting pressed")
    -- Add your import logic here
end)

makeButton(settings, "Export Setting", function()
    print("[Fanware] Export Setting pressed")
    -- Add your export logic here
end)

-- Info label
local info = new("TextLabel", {
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
})
addRow(settings, 60)

--==============================================================
-- RIGHT SHIFT TOGGLE
--==============================================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
    end
end)

--==============================================================
-- DRAG (fallback for executors without Draggable support)
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
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

print("[Fanware] Loaded. Press RightShift to toggle the menu.")
