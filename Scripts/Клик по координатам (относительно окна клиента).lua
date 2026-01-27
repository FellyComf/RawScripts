-- LocalScript

local VirtualInputManager = game:GetService("VirtualInputManager")

-- координаты экрана (в пикселях Roblox-окна)
local x = 900
local y = 100

-- задержка перед кликом
task.wait(1)

-- нажать ЛКМ
VirtualInputManager:SendMouseButtonEvent(
    x, y,
    0,        -- 0 = левая кнопка мыши
    true,     -- нажали
    game,
    0
)

task.wait(0.05)

-- отпустить ЛКМ
VirtualInputManager:SendMouseButtonEvent(
    x, y,
    0,
    false,    -- отпустили
    game,
    0
)
