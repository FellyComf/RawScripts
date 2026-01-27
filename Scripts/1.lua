local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- функция получения полного пути
local function getFullPath(instance)
	if not instance then return "nil" end

	local path = instance.Name
	local parent = instance.Parent

	while parent and parent ~= game do
		path = parent.Name .. "." .. path
		parent = parent.Parent
	end

	return path
end

-- ловим только кнопки
local function hookGui(guiObject)
	if guiObject:IsA("TextButton") or guiObject:IsA("ImageButton") then
		guiObject.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				print("ПКМ по кнопке:")
				print(getFullPath(guiObject))
			end
		end)
	end
end

-- рекурсивно подключаем существующие кнопки
local function hookAllGui(parent)
	for _, child in ipairs(parent:GetChildren()) do
		hookGui(child)
		hookAllGui(child)
	end
end

-- старт
hookAllGui(playerGui)

-- ловим кнопки, которые добавятся позже
playerGui.DescendantAdded:Connect(hookGui)
