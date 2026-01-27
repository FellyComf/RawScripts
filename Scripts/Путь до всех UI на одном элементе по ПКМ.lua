local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

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

-- подключаемся ко всем GuiObject
local function hookGui(guiObject)
	if guiObject:IsA("GuiObject") then
		guiObject.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				print("ПКМ по UI:")
				print(getFullPath(guiObject))
			end
		end)
	end
end

-- рекурсивно подключаем существующие UI
local function hookAllGui(parent)
	for _, child in ipairs(parent:GetChildren()) do
		hookGui(child)
		hookAllGui(child)
	end
end

-- старт
hookAllGui(playerGui)

-- если UI добавится позже
playerGui.DescendantAdded:Connect(hookGui)
