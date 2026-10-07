--========================================================
-- KEY SYSTEM MANUAL (COMPATIBLE CON XENO)
--========================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Tus 3 llaves maestras permanentes (Tú y tus 2 amigos)
local MasterKeys = {
    "yeahfreeformelol",
    "withlovekeyfriend",
    "withlovekeyfriend2"
}

-- Tu invitación de Discord (se copiará al portapapeles)
local DiscordKeyLink = "https://discord.gg/VuZDVQ97Z"

-- Crear UI de la Key
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShooterKeySystem"

local successParent = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not successParent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(400, 220)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

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

-- Funcionalidad de los Botones
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(DiscordKeyLink)
    GetKeyBtn.Text = "¡Link de Discord copiado!"
    task.wait(2)
    GetKeyBtn.Text = "Copiar Discord"
end)

SubmitBtn.MouseButton1Click:Connect(function()
    local userKey = TextBox.Text
    local granted = false

    -- Validar contra las llaves maestras (Tú y tus 2 amigos)
    for _, k in ipairs(MasterKeys) do
        if userKey == k then
            granted = true
            break
        end
    end

    if granted then
        ScreenGui:Destroy()
        -- Carga el script principal del Shooter desde tu GitHub
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Fansware/Script/main/Something1"))()
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "Key inválida. Pídela en Discord."
    end
end)

