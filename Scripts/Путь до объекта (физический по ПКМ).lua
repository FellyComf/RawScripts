local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- функция получения полного пути объекта
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

-- ПКМ
mouse.Button2Down:Connect(function()
	local target = mouse.Target

	if target then
		print("ПКМ по объекту:")
		print(getFullPath(target))
	else
		print("ПКМ — ни по чему (пустота)")
	end
end)
