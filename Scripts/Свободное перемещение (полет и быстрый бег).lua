--// Services
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character.Humanoid
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--// Variables
local flyMode = false
local bodyVelocity
local moveUp = false
local moveDown = false
local flySpeed = 1000
local valueChangeSpeed = 100

--// Functions
local function enableFly()
    if bodyVelocity then return end

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)  -- движение только по Y
    bodyVelocity.Parent = humanoidRootPart

    flyMode = true
end

local function disableFly()
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    flyMode = false
end

local function ChangeWalkSpeed(valueChangeSpeed)
    local newWalkSpeed = humanoid.WalkSpeed + valueChangeSpeed
    humanoid.WalkSpeed = newWalkSpeed
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.Q then
        if flyMode then
            disableFly()
        else
            enableFly()
        end
    elseif input.KeyCode == Enum.KeyCode.R then
        moveUp = true
    elseif input.KeyCode == Enum.KeyCode.F then
        moveDown = true
    elseif input.KeyCode == Enum.KeyCode.T then
        ChangeWalkSpeed(valueChangeSpeed)
        print("T:", "walkSpeed -", humanoid.WalkSpeed)
    elseif input.KeyCode == Enum.KeyCode.G then
        ChangeWalkSpeed(-valueChangeSpeed)
        print("G:", "walkSpeed -", humanoid.WalkSpeed)
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.R then
        moveUp = false
    elseif input.KeyCode == Enum.KeyCode.F then
        moveDown = false
    end
end)

--// Main loop
RunService.RenderStepped:Connect(function(deltaTime)
    if flyMode and bodyVelocity then
        local yVelocity = 0
        if moveUp then
            yVelocity = flySpeed
        elseif moveDown then
            yVelocity = -flySpeed
        end
        bodyVelocity.Velocity = Vector3.new(0, yVelocity, 0)
    end
end)
