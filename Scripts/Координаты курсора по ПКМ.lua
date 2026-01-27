local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        local pos = UIS:GetMouseLocation()
        print("X:", pos.X, "Y:", pos.Y)
    end
end)
