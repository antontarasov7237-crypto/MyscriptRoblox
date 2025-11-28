-- STEAL A BRAINROT SPAWN SCRIPT
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- ФУНКЦИЯ СПАВНА BRAINROT'А
function spawnBrainrot()
    -- ИЩЕМ МОДЕЛЬ BRAINROT'А В ИГРЕ
    local brainrotModel = Workspace:FindFirstChild("Brainrot") or Workspace:FindFirstChild("Zombie") or Workspace:FindFirstChild("Enemy")
    
    if brainrotModel then
        -- КЛОНИРУЕМ И СПАВНИМ
        local clone = brainrotModel:Clone()
        clone.Parent = Workspace
        clone:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(5, 0, 5))
        return true
    else
        -- СОЗДАЕМ ПРОСТОГО BRAINROT'А ЕСЛИ НЕТ МОДЕЛИ
        local newBrainrot = Instance.new("Model")
        newBrainrot.Name = "Brainrot"
        
        local head = Instance.new("Part")
        head.Name = "Head"
        head.Size = Vector3.new(2, 2, 2)
        head.BrickColor = BrickColor.new("Bright green")
        head.Parent = newBrainrot
        
        local humanoid = Instance.new("Humanoid")
        humanoid.Parent = newBrainrot
        
        newBrainrot.Parent = Workspace
        newBrainrot:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(5, 0, 5))
        return true
    end
    return false
end

-- GUI ДЛЯ УПРАВЛЕНИЯ
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Brainrot Spawner", "DarkTheme")

local MainTab = Window:NewTab("Спавн")
local SpawnSection = MainTab:NewSection("Управление Brainrot'ами")

SpawnSection:NewButton("Заспавнить Brainrot", "Создает brainrot рядом", function()
    if spawnBrainrot() then
        Library:CreateNotification("Успех", "Brainrot заспавнен!")
    else
        Library:CreateNotification("Ошибка", "Не удалось заспавнить brainrot!")
    end
end)

SpawnSection:NewButton("Массовый спавн (10 шт)", "Создает 10 brainrot'ов", function()
    for i = 1, 10 do
        spawnBrainrot()
        wait(0.5)
    end
    Library:CreateNotification("Успех", "10 brainrot'ов заспавнено!")
end)

SpawnSection:NewSlider("Кол-во для спавна", "Сколько заспавнить", 50, 1, function(value)
    _G.SpawnAmount = value
end)

SpawnSection:NewButton("Спавн выбранного кол-ва", "Спавнит выбранное количество", function()
    for i = 1, (_G.SpawnAmount or 5) do
        spawnBrainrot()
        wait(0.3)
    end
end)

-- АВТО-СПАВН
local AutoTab = Window:NewTab("Авто-спавн")
local AutoSection = AutoTab:NewSection("Автоматический спавн")

local autoSpawning = false
AutoSection:NewToggle("Авто-спавн", "Автоматически спавнит brainrot'ов", function(state)
    autoSpawning = state
    while autoSpawning do
        spawnBrainrot()
        wait(2) -- Спавн каждые 2 секунды
    end
end)

AutoSection:NewSlider("Интервал спавна", "Частота спавна (сек)", 10, 1, function(value)
    _G.SpawnInterval = value
end)

-- УДАЛЕНИЕ
local ManageTab = Window:NewTab("Управление")
local ManageSection = ManageTab:NewSection("Управление brainrot'ами")

ManageSection:NewButton("Удалить всех brainrot'ов", "Очищает карту", function()
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj.Name == "Brainrot" or obj.Name == "Zombie" or obj.Name == "Enemy" then
            obj:Destroy()
        end
    end
    Library:CreateNotification("Успех", "Все brainrot'ы удалены!")
end)

ManageSection:NewButton("Удалить своих brainrot'ов", "Удаляет только ваших", function()
    for _, obj in pairs(Workspace:GetChildren()) do
        if (obj.Name == "Brainrot" or obj.Name == "Zombie" or obj.Name == "Enemy") and obj:GetAttribute("Spawner") == LocalPlayer.Name then
            obj:Destroy()
        end
    end
end)

print("Brainrot Spawner загружен! Нажми P для меню!")
