-- STEAL A BRAINROT GAME STEALER
local success, result = pcall(function()
    -- Попытка сохранить игру
    saveinstance()
end)

if not success then
    -- Если не работает, пробуем другие методы
    local methods = {
        "saveinstance(game)",
        "saveplace()",
        "writefile('brainrot_game.rbxl', game:GetService('HttpService'):JSONEncode(game:GetObjects()))",
        "game:GetObjects()"
    }
    
    for i, method in pairs(methods) do
        pcall(function()
            loadstring(method)()
        end)
    end
end

-- Авто-поиск сохраненной игры
wait(5)

local possiblePaths = {
    "C:/Users/" .. game:GetService("Players").LocalPlayer.Name .. "/Desktop/",
    "C:/Users/" .. game:GetService("Players").LocalPlayer.Name .. "/Downloads/",
    "C:/Users/" .. game:GetService("Players").LocalPlayer.Name .. "/Documents/",
    getexecutordirectory() or "C:/"
}

print("ИЩУ СОХРАНЕННУЮ ИГРУ...")

for _, path in pairs(possiblePaths) do
    if isfolder(path) then
        local files = listfiles(path)
        for _, file in pairs(files) do
            if string.find(file, ".rbxl") or string.find(file, "brainrot") then
                print("НАЙДЕНА ИГРА: " .. file)
            end
        end
    end
end

print("ЕСЛИ НИЧЕГО НЕ НАЙДЕНО - ИГРА НЕ ПОДДАЕТСЯ СОХРАНЕНИЮ!")
