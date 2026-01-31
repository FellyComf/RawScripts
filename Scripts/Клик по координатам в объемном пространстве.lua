local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera

-- 🔹 координаты в мире
local worldPosition = Vector3.new(-7.9355573654174805, 0.1355276107788086,  -79.4869155883789) -- ← сюда свои координаты

task.wait(1)

-- перевод из мира в экран
local screenPoint, onScreen = Camera:WorldToViewportPoint(worldPosition)

if not onScreen then
    warn("Точка вне экрана")
    return
end

local x = screenPoint.X
local y = screenPoint.Y

print("клик по: ", x, y)
-- клик ЛКМ
VirtualInputManager:SendMouseButtonEvent(
    x, y,
    0,
    true,
    game,
    0
)

task.wait(0.05)

VirtualInputManager:SendMouseButtonEvent(
    x, y,
    0,
    false,
    game,
    0
)
