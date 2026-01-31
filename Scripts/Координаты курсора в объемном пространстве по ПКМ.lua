local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		-- позиция мыши на экране
		local mousePos = UserInputService:GetMouseLocation()

		-- луч из камеры
		local ray = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)

		-- параметры рейкаста
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = {player.Character}
		params.FilterType = Enum.RaycastFilterType.Blacklist

		local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)

		if result then
			print("ПКМ клик по миру")
			print("Позиция:", result.Position)
			print("Объект:", result.Instance:GetFullName())
		else
			print("ПКМ — в пустоту")
		end
	end
end)
