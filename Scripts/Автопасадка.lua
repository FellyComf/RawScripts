--// Сервисы (Services)
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

local replicatedStorage = game:GetService("ReplicatedStorage")
local gameEvents = replicatedStorage.GameEvents

local proximityPromptService = game:GetService("ProximityPromptService")
local userInputService = game:GetService("UserInputService")

--// Variables
local canHarvest = false

--// Функции (Functions)
local function GetFarmOwner(farm): string
    local important = farm.Important
    local data = important.Data
    local owner = data.Owner

    return owner.Value
end

local function GetFarm(playerName, farms): Folder?
    local farms = farms:GetChildren()
    for _, farm in next, farms do
        local owner = GetFarmOwner(farm)

        --// Проверка, является ли игрок владельцем данной фермы
        if owner == playerName then
            return farm
        end
    end
    return
end

local function GetArea(base)
    local center = base:GetPivot()
    local size = base.Size

    --// Нижняя левая точка
    local x1 = math.ceil(center.X - size.X/2)
    local z1 = math.ceil(center.Z - size.Z/2)

    --// Верхняя правая точка
    local x2 = math.ceil(center.X + size.X/2)
    local z2 = math.ceil(center.Z + size.Z/2)

    return x1, z1, x2, z2
end

local function Plant(position, seed)
    gameEvents.Plant_RE:FireServer(position, seed)
    wait(.3)
end

--// Автопосадка (Auto-Plant)
-- local function AutoPlant()
--     local farms = workspace.Farm
--     local myFarm = GetFarm(localPlayer.Name, farms)
--     local myImportant = myFarm.Important
--     local myPlantLocations = myImportant.Plant_Locations

--     local dirt = myPlantLocations:FindFirstChildOfClass("Part")
--     local x1, z1, x2, z2 = GetArea(dirt)

--     --// В процессе...
-- end

local function GetDistance(model1, model2)
    local model1Position = model1:GetPivot().Position
    local model2Position = model2:GetPivot().Position

    local distance = (model1Position - model2Position).Magnitude

    return distance
end

local function IsHarvest(plant): boolean?
    local prompt = plant:FindFirstChild("ProximityPrompt", true)
    if not prompt then return end
    if not prompt.Enabled then return end
    
    print("prompt.Neabled:", prompt.Enabled)

    return true
end

local function CollectHarvestPlants(parent): table?
    local plants = {}

    for _, plant in next, parent:GetChildren() do
        local character = localPlayer.Character
        local fruits = plant:FindFirstChild("Fruits")
        local radiusToPlant = 15

        if fruits then
            for _, fruit in next, fruits:GetChildren() do
                local distance = GetDistance(character, fruit)

                if distance > radiusToPlant then continue end
                if not IsHarvest(fruit) then continue end 

                table.insert(plants, fruit)
            end
        else
            local distance = GetDistance(character, plant)

            if distance > radiusToPlant then continue end
            if not IsHarvest(plant) then continue end

            table.insert(plants, plant)
        end
    end

    return plants
end

local function HarvestPlant(plant)
    local prompt = plant:FindFirstChild("ProximityPrompt", true)
    if not prompt then return end
    print("* Сбор растения:", plant.Name)
	fireproximityprompt(prompt)
end

-- --// Сбор урожая
-- local function HarvestPlants(parent)
--     local plants = CollectHarvestPlants(parent)

--     print("##### Готовые объекты к сбору #####")
--     for i = #plants, 1, -1 do
--         print(i, "-", plants[i].Name)

--         if not IsHarvest(plants[i]) then continue end

--         print("X Удаление...")
--         HarvestPlant(plants[i])
--         wait(1)
--         -- table.remove(plants, i)
--         -- wait(0.5)
--     end

--     print("@@@@@ Оставшиеся объекты @@@@@")
--     for i, plant in next, plants do
--         print(i, "-", plant.Name)
--     end
-- end

local function IsPlant(obj)
    if not obj then return end

    print(obj.Name)
    if obj.Name ~= "Fruits" and obj.Name ~= "Plants_Physical" then
        obj = IsPlant(obj.Parent)
    end

    return obj
end

--// Подписи на события (Events)
proximityPromptService.PromptShown:Connect(function(prompt, inputType)
    local obj = prompt.Parent.Parent
    print("Можно взаимодействовать с:", obj)

    if canHarvest then
        if IsPlant(obj) then HarvestPlant(obj) end
    end
end)

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    --// Автосбор урожая, с которым можно взаимодействовать
    if input.KeyCode == Enum.KeyCode.Q then canHarvest = not canHarvest  print(canHarvest) end
end)

--// Запуск (Main)
local farms = workspace.Farm
local myFarm = GetFarm(localPlayer.Name, farms)
local myImportant = myFarm.Important
local myPlantLocations = myImportant.Plant_Locations
local myPlantsPhysical = myImportant.Plants_Physical

-- HarvestPlants(myPlantsPhysical)
-- local plant = myPlantsPhysical:findFirstChild("Carrot")
-- HarvestPlant(plant)