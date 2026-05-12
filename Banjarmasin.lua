--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")

--// REMOTE
local remote = rs:WaitForChild("FishingSystem")
    :WaitForChild("FishGiver")

--// CONFIG
local FishName = "Sea Dragon"
local FishRarity = "Mythical"
local FishWeight = 10000
local SpawnDelay = 0.001

local HookPos = Vector3.new(
    -60.89377975463867,
    22.43121910095215,
    -203.24331665039062
)

local AutoSpawn = false

--========================--
-- 🎣 GIVE FISH FUNCTION
--========================--
local function giveFish()

    local args = {
        {
            hookPosition = HookPos,
            name = FishName,
            rarity = FishRarity,
            weight = FishWeight
        }
    }

    remote:FireServer(unpack(args))
end

--========================--
-- 🖥️ GUI
--========================--
pcall(function()
    (gethui and gethui() or game.CoreGui)
        :FindFirstChild("FishSpawnerGUI")
        :Destroy()
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FishSpawnerGUI"
ScreenGui.Parent = gethui and gethui() or LocalPlayer.PlayerGui

--========================--
-- 🔔 CUSTOM NOTIFICATION
--========================--
local function SendCustomNotif(title, text)

    local NotifFrame = Instance.new("Frame")
    NotifFrame.Parent = ScreenGui
    NotifFrame.Size = UDim2.new(0,250,0,65)
    NotifFrame.Position = UDim2.new(1,10,0.8,0)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(15,15,25)

    Instance.new("UICorner", NotifFrame)

    local Stroke = Instance.new("UIStroke")
    Stroke.Parent = NotifFrame
    Stroke.Color = Color3.fromRGB(0,255,170)
    Stroke.Thickness = 1.5

    local NTitle = Instance.new("TextLabel")
    NTitle.Parent = NotifFrame
    NTitle.Size = UDim2.new(1,-10,0,25)
    NTitle.Position = UDim2.new(0,10,0,5)
    NTitle.BackgroundTransparency = 1
    NTitle.Text = title
    NTitle.TextColor3 = Color3.fromRGB(0,255,170)
    NTitle.Font = Enum.Font.GothamBold
    NTitle.TextSize = 12
    NTitle.TextXAlignment = Enum.TextXAlignment.Left

    local NText = Instance.new("TextLabel")
    NText.Parent = NotifFrame
    NText.Size = UDim2.new(1,-15,0,30)
    NText.Position = UDim2.new(0,10,0,28)
    NText.BackgroundTransparency = 1
    NText.Text = text
    NText.TextColor3 = Color3.fromRGB(255,255,255)
    NText.Font = Enum.Font.Gotham
    NText.TextSize = 10
    NText.TextWrapped = true
    NText.TextXAlignment = Enum.TextXAlignment.Left

    NotifFrame:TweenPosition(
        UDim2.new(1,-260,0.8,0),
        "Out",
        "Quart",
        0.5,
        true
    )

    task.delay(4,function()

        NotifFrame:TweenPosition(
            UDim2.new(1,10,0.8,0),
            "In",
            "Quart",
            0.5,
            true
        )

        task.wait(0.5)
        NotifFrame:Destroy()
    end)
end

SendCustomNotif(
    "🎣 FISH SPAWNER",
    "Loaded Successfully\nMade @Zoyyaaaaa404"
)

--========================--
-- MAIN FRAME
--========================--
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,220,0,280)
Frame.Position = UDim2.new(0.05,0,0.4,0)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,35)
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame)

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = Frame
MainStroke.Color = Color3.fromRGB(55,55,65)

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1,0,0,20)
Title.Text = "🎣 Fish Spawner"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0,255,170)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11

-- CREATOR
local Creator = Instance.new("TextLabel")
Creator.Parent = Frame
Creator.Size = UDim2.new(1,0,0,16)
Creator.Position = UDim2.new(0,0,0,18)
Creator.Text = "Made @Zoyyaaaaa404 | Ihsan hadi Almari"
Creator.BackgroundTransparency = 1
Creator.TextColor3 = Color3.fromRGB(170,170,170)
Creator.Font = Enum.Font.Gotham
Creator.TextSize = 9

-- NAME BOX
local NameBox = Instance.new("TextBox")
NameBox.Parent = Frame
NameBox.Size = UDim2.new(0.9,0,0,25)
NameBox.Position = UDim2.new(0.05,0,0.20,0)
NameBox.PlaceholderText = "Fish Name"
NameBox.Text = FishName
NameBox.BackgroundColor3 = Color3.fromRGB(35,35,45)
NameBox.TextColor3 = Color3.new(1,1,1)
NameBox.Font = Enum.Font.Gotham
NameBox.TextSize = 10
Instance.new("UICorner", NameBox)

-- RARITY BOX
local RarityBox = Instance.new("TextBox")
RarityBox.Parent = Frame
RarityBox.Size = UDim2.new(0.9,0,0,25)
RarityBox.Position = UDim2.new(0.05,0,0.36,0)
RarityBox.PlaceholderText = "Rarity"
RarityBox.Text = FishRarity
RarityBox.BackgroundColor3 = Color3.fromRGB(35,35,45)
RarityBox.TextColor3 = Color3.new(1,1,1)
RarityBox.Font = Enum.Font.Gotham
RarityBox.TextSize = 10
Instance.new("UICorner", RarityBox)

-- WEIGHT BOX
local WeightBox = Instance.new("TextBox")
WeightBox.Parent = Frame
WeightBox.Size = UDim2.new(0.9,0,0,25)
WeightBox.Position = UDim2.new(0.05,0,0.52,0)
WeightBox.PlaceholderText = "Weight"
WeightBox.Text = tostring(FishWeight)
WeightBox.BackgroundColor3 = Color3.fromRGB(35,35,45)
WeightBox.TextColor3 = Color3.new(1,1,1)
WeightBox.Font = Enum.Font.Gotham
WeightBox.TextSize = 10
Instance.new("UICorner", WeightBox)

-- DELAY BOX
local DelayBox = Instance.new("TextBox")
DelayBox.Parent = Frame
DelayBox.Size = UDim2.new(0.9,0,0,25)
DelayBox.Position = UDim2.new(0.05,0,0.68,0)
DelayBox.PlaceholderText = "Spawn Delay"
DelayBox.Text = tostring(SpawnDelay)
DelayBox.BackgroundColor3 = Color3.fromRGB(35,35,45)
DelayBox.TextColor3 = Color3.new(1,1,1)
DelayBox.Font = Enum.Font.Gotham
DelayBox.TextSize = 10
Instance.new("UICorner", DelayBox)

-- TOGGLE BUTTON
local SpawnBtn = Instance.new("TextButton")
SpawnBtn.Parent = Frame
SpawnBtn.Size = UDim2.new(0.9,0,0,35)
SpawnBtn.Position = UDim2.new(0.05,0,0.84,0)
SpawnBtn.Text = "AUTO : OFF 🔴"
SpawnBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
SpawnBtn.TextColor3 = Color3.new(1,1,1)
SpawnBtn.Font = Enum.Font.GothamBold
SpawnBtn.TextSize = 11
Instance.new("UICorner", SpawnBtn)

--========================--
-- 🔘 TOGGLE ACTION
--========================--
SpawnBtn.MouseButton1Click:Connect(function()

    AutoSpawn = not AutoSpawn

    FishName = NameBox.Text
    FishRarity = RarityBox.Text
    FishWeight = tonumber(WeightBox.Text) or 10000
    SpawnDelay = tonumber(DelayBox.Text) or 0.1

    if AutoSpawn then

        SpawnBtn.Text = "AUTO : ON 🟢"
        SpawnBtn.BackgroundColor3 = Color3.fromRGB(0,170,100)

        SendCustomNotif(
            "🟢 AUTO ENABLED",
            "Fish Auto Spawn Activated"
        )

        task.spawn(function()
            while AutoSpawn do
                giveFish()
                task.wait(SpawnDelay)
            end
        end)

    else

        SpawnBtn.Text = "AUTO : OFF 🔴"
        SpawnBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)

        SendCustomNotif(
            "🔴 AUTO DISABLED",
            "Fish Auto Spawn Stopped"
        )

    end
end)

--========================--
-- 🔘 HIDE BUTTON
--========================--
local HideBtn = Instance.new("TextButton")
HideBtn.Parent = ScreenGui
HideBtn.Size = UDim2.new(0,50,0,16)
HideBtn.Position = UDim2.new(0.05,0,0.35,0)
HideBtn.Text = "Hide"
HideBtn.Font = Enum.Font.GothamBold
HideBtn.TextSize = 9
HideBtn.TextColor3 = Color3.new(1,1,1)
HideBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
HideBtn.Active = true
HideBtn.Draggable = true
Instance.new("UICorner", HideBtn)

local hidden = false

HideBtn.MouseButton1Click:Connect(function()

    hidden = not hidden
    Frame.Visible = not hidden

    if hidden then
        HideBtn.Text = "Show"
    else
        HideBtn.Text = "Hide"
    end
end)