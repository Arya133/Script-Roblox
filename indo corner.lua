-- AUTO FISHING - CAST DELAY 0.01 + REEL CLICK
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FishingEvent = ReplicatedStorage:WaitForChild("FishingSystem"):WaitForChild("FishingEvent")

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--// STATE
local isAuto = false
local castDelay = 0.01
local reelDelay = 0.0001

--// FUNGSI CAST
local function cast()
    pcall(function()
        FishingEvent:FireServer("Cast")
        print("[✓] Cast")
    end)
end

--// FUNGSI REEL CLICK
local function reelClick()
    pcall(function()
        FishingEvent:FireServer("ReelClick")
    end)
end

--// AUTO LOOP
local function startAuto()
    while isAuto do
        cast()
        task.wait(castDelay)
        
        -- Spam reel click (kurang lebih 50x)
        for i = 1, 50 do
            if not isAuto then break end
            reelClick()
            task.wait(reelDelay)
        end
        
        task.wait(0.5)
    end
end

--// ANTI AFK
local function startAntiAFK()
    task.spawn(function()
        while true do
            task.wait(math.random(45, 75))
            pcall(function()
                local mouse = LocalPlayer:GetMouse()
                mouse.X = math.random(0, 1920)
                mouse.Y = math.random(0, 1080)
                task.wait(0.05)
            end)
        end
    end)
end

--// GUI SETUP
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFishing"
screenGui.Parent = gethui and gethui() or CoreGui

local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 180, 0, 140)
main.Position = UDim2.new(0.08, 0, 0.35, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
main.Active = true
main.Draggable = true

local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 8)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(55, 55, 65)
mainStroke.Thickness = 1

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 28)
title.Text = "🎣 AUTO FISHING"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 12

-- Info delay
local infoLabel = Instance.new("TextLabel", main)
infoLabel.Size = UDim2.new(0.9, 0, 0, 16)
infoLabel.Position = UDim2.new(0.05, 0, 0.32, 0)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Cast Delay: 0.01 | Reel: 0.0001"
infoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 8
infoLabel.TextXAlignment = Enum.TextXAlignment.Center

-- TOGGLE BUTTON
local toggleBtn = Instance.new("TextButton", main)
toggleBtn.Size = UDim2.new(0.8, 0, 0, 35)
toggleBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
toggleBtn.Text = "AUTO [OFF]"
toggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 11
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 5)
local toggleStroke = Instance.new("UIStroke", toggleBtn)
toggleStroke.Color = Color3.fromRGB(255, 50, 50)
toggleStroke.Thickness = 1

-- STATUS
local statusLabel = Instance.new("TextLabel", main)
statusLabel.Size = UDim2.new(1, 0, 0, 14)
statusLabel.Position = UDim2.new(0, 0, 0.85, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● STOP"
statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 8
statusLabel.TextXAlignment = Enum.TextXAlignment.Center

-- HIDE BUTTON
local hideBtn = Instance.new("TextButton", screenGui)
hideBtn.Size = UDim2.new(0, 50, 0, 20)
hideBtn.Position = UDim2.new(0.08, 0, 0.32, 0)
hideBtn.Text = "HIDE"
hideBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
hideBtn.TextColor3 = Color3.new(1, 1, 1)
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextSize = 9
hideBtn.Active = true
hideBtn.Draggable = true
Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0, 5)
local hideStroke = Instance.new("UIStroke", hideBtn)
hideStroke.Color = Color3.fromRGB(100, 100, 100)
hideStroke.Thickness = 1

-- TOGGLE FUNCTION
toggleBtn.MouseButton1Click:Connect(function()
    isAuto = not isAuto
    toggleBtn.Text = "AUTO [" .. (isAuto and "ON" or "OFF") .. "]"
    toggleStroke.Color = isAuto and Color3.fromRGB(50, 255, 150) or Color3.fromRGB(255, 50, 50)
    toggleBtn.TextColor3 = isAuto and Color3.fromRGB(50, 255, 150) or Color3.new(1, 1, 1)
    statusLabel.Text = isAuto and "● RUN" or "● STOP"
    statusLabel.TextColor3 = isAuto and Color3.fromRGB(50, 255, 150) or Color3.fromRGB(255, 50, 50)
    
    if isAuto then
        print("[✓] AUTO FISHING ON")
        print("    Cast delay: 0.01 detik")
        print("    Reel delay: 0.0001 detik")
        task.spawn(startAuto)
    else
        print("[✓] AUTO FISHING OFF")
    end
end)

-- HIDE FUNCTION
local hidden = false
hideBtn.MouseButton1Click:Connect(function()
    hidden = not hidden
    main.Visible = not hidden
    hideBtn.Text = hidden and "SHOW" or "HIDE"
    hideStroke.Color = hidden and Color3.fromRGB(50, 255, 150) or Color3.fromRGB(100, 100, 100)
end)

-- START ANTI AFK
startAntiAFK()

print("========================================")
print("[✓] AUTO FISHING LOADED!")
print("[✓] Cast delay: 0.01 detik")
print("[✓] Reel delay: 0.0001 detik (EXTREME)")
print("[✓] Klik AUTO ON buat mulai")
print("========================================")