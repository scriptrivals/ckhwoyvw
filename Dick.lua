-- Plus Crosshair - Full Smooth Version
-- Yokai.win

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local plr = Players.LocalPlayer
local pg = plr:WaitForChild("PlayerGui")

-- Anti duplicate
if pg:FindFirstChild("PlusCrosshair") then
    pg.PlusCrosshair:Destroy()
end

-- ================= CONFIG =================
local THICK = 2
local BASE = 30
local AMP = 15
local ROT_SPEED = 290
local RAINBOW_SPEED = 0.25
local GAP = 13
local BREATH_SPEED = 4.1
-- =========================================

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PlusCrosshair"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = pg

local center = Instance.new("Frame")
center.Size = UDim2.fromOffset(0, 0)
center.Position = UDim2.fromScale(0.5, 0.5)
center.BackgroundTransparency = 1
center.Parent = gui

local rotator = Instance.new("Frame")
rotator.AnchorPoint = Vector2.new(0.5, 0.5)
rotator.Size = UDim2.fromOffset(0, 0)
rotator.BackgroundTransparency = 1
rotator.Parent = center

-- Create line
local function newLine(size, pos)
    local f = Instance.new("Frame")
    f.AnchorPoint = Vector2.new(0.5, 0.5)
    f.Size = size
    f.Position = pos
    f.BorderSizePixel = 0
    f.Parent = rotator

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Thickness = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = f

    return f
end

-- Lines
local lines = {}
lines[1] = newLine(UDim2.fromOffset(THICK, BASE), UDim2.fromOffset(0, -(BASE/2 + GAP)))
lines[2] = newLine(UDim2.fromOffset(THICK, BASE), UDim2.fromOffset(0,  (BASE/2 + GAP)))
lines[3] = newLine(UDim2.fromOffset(BASE, THICK), UDim2.fromOffset(-(BASE/2 + GAP), 0))
lines[4] = newLine(UDim2.fromOffset(BASE, THICK), UDim2.fromOffset( (BASE/2 + GAP), 0))

-- ================= TEXT =================
local label = Instance.new("TextLabel")
label.Text = "Yokai.win"
label.AnchorPoint = Vector2.new(0.5, 0)
label.Position = UDim2.fromOffset(0, 60)
label.Size = UDim2.fromOffset(150, 18)
label.BackgroundTransparency = 1
label.TextScaled = false
label.TextSize = 12
label.Font = Enum.Font.Arcade
label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
label.TextStrokeTransparency = 0
label.Parent = center
-- ========================================

-- ================= ANIMATION =================
local time = 0

RunService.RenderStepped:Connect(function(dt)
    time = time + dt

    -- Rainbow color
    local hue = (tick() * RAINBOW_SPEED) % 1
    local color = Color3.fromHSV(hue, 1, 1)

    -- Rotation
    rotator.Rotation = rotator.Rotation + ROT_SPEED * dt

    -- Smooth breathing (đều – không rung)
    local breath = math.sin(time * BREATH_SPEED)
    local len = BASE + breath * AMP

    -- UP
    lines[1].Size = UDim2.fromOffset(THICK, len)
    lines[1].Position = UDim2.fromOffset(0, -(len / 2 + GAP))

    -- DOWN
    lines[2].Size = UDim2.fromOffset(THICK, len)
    lines[2].Position = UDim2.fromOffset(0, (len / 2 + GAP))

    -- LEFT
    lines[3].Size = UDim2.fromOffset(len, THICK)
    lines[3].Position = UDim2.fromOffset(-(len / 2 + GAP), 0)

    -- RIGHT
    lines[4].Size = UDim2.fromOffset(len, THICK)
    lines[4].Position = UDim2.fromOffset((len / 2 + GAP), 0)

    -- Apply color
    for i = 1, #lines do
        lines[i].BackgroundColor3 = color
    end

    label.TextColor3 = color
end)
-- =============================================
