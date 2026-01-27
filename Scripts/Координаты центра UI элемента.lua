-- LocalScript в PlayerScripts или в PlayerGui
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Путь к элементу
local element = player:WaitForChild("PlayerGui")
                  :WaitForChild("Teleport_UI")
                  :WaitForChild("Frame")
                  :WaitForChild("Sell")

-- Ждём чуть, чтобы элемент точно загрузился
task.wait(0.1)

-- Получаем координаты и размер на экране
local position = element.AbsolutePosition  -- Vector2
local size = element.AbsoluteSize          -- Vector2

print("Element position on screen: X=" .. position.X .. ", Y=" .. position.Y)
print("Element size: Width=" .. size.X .. ", Height=" .. size.Y)

local yOffset = 60

-- Пример: координаты центра элемента
local centerX = position.X + size.X / 2
local centerY = position.Y + size.Y / 2 + yOffset
print("Center coordinates: X=" .. centerX .. ", Y=" .. centerY)
