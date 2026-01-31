--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local RADIUS = 15

--// Создаём круг
local circle = Instance.new("Part")
circle.Name = "DistanceCircle"
circle.Shape = Enum.PartType.Cylinder
circle.Anchored = true
circle.CanCollide = false
circle.CanQuery = false
circle.CanTouch = false
circle.Transparency = 0.6
circle.Material = Enum.Material.Neon
circle.Color = Color3.fromRGB(0, 255, 0)

-- Cylinder: X — высота, Y/Z — радиус
circle.Size = Vector3.new(0.2, RADIUS * 2, RADIUS * 2)
circle.Parent = workspace

-- Поворачиваем цилиндр, чтобы он лежал на земле
circle.CFrame = CFrame.Angles(0, 0, math.rad(90))

--// Обновление позиции
RunService.RenderStepped:Connect(function()
    local character = player.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    circle.CFrame =
        CFrame.new(hrp.Position.X, hrp.Position.Y - 2.9, hrp.Position.Z)
        * CFrame.Angles(0, 0, math.rad(90))
end)
