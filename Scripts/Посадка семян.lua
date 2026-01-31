local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage.GameEvents

local function Plant(Position, Seed)
    GameEvents.Plant_RE:FireServer(Position, Seed)
    wait(.3)
end

local Position = Vector3.new(-7.9355573654174805, 0.1355276107788086, -79.4869155883789)
local Seed = "Carrot"

Plant(Position, Seed)
