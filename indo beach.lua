--// ⚙️ Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

--// 📦 Remotes
local GiveFishFunction = ReplicatedStorage:WaitForChild("GiveFishFunction")
local SellAllFishFunction = ReplicatedStorage:WaitForChild("SellAllFishFunction")

--// 💾 Config
getgenv().AutoGive = false
getgenv().AutoSell = false
getgenv().Delay = 1
getgenv().FishCode = "safsafwaetqw3fsa"
getgenv().SellAmount = 10000

--// 🧱 GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = gethui and gethui() or game.CoreGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 160, 0, 230)
Frame.Position = UDim2.new(0.05, 0, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(28,28,38)
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,8)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 20)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(0,255,180)
Title.Text = "🐟 GiveFish + AutoSell Hub"

-------------------------------------
-- 🔘 Toggle Auto Give
-------------------------------------
local GiveBtn = Instance.new("TextButton", Frame)
GiveBtn.Size = UDim2.new(0.9, 0, 0, 25)
GiveBtn.Position = UDim2.new(0.05, 0, 0.18, 0)
GiveBtn.Text = "Auto Give: OFF"
GiveBtn.Font = Enum.Font.GothamBold
GiveBtn.TextSize = 12
GiveBtn.TextColor3 = Color3.fromRGB(255,255,255)
GiveBtn.BackgroundColor3 = Color3.fromRGB(45,45,65)
Instance.new("UICorner", GiveBtn).CornerRadius = UDim.new(0,6)

GiveBtn.MouseButton1Click:Connect(function()
	getgenv().AutoGive = not getgenv().AutoGive
	GiveBtn.Text = "Auto Give: " .. (getgenv().AutoGive and "ON" or "OFF")
end)

-------------------------------------
-- 🎣 Input Fish Code
-------------------------------------
local CodeBox = Instance.new("TextBox", Frame)
CodeBox.Size = UDim2.new(0.9, 0, 0, 22)
CodeBox.Position = UDim2.new(0.05, 0, 0.33, 0)
CodeBox.Text = getgenv().FishCode
CodeBox.PlaceholderText = "Fish Code"
CodeBox.Font = Enum.Font.Gotham
CodeBox.TextSize = 11
CodeBox.TextColor3 = Color3.fromRGB(255,255,255)
CodeBox.BackgroundColor3 = Color3.fromRGB(40,40,60)
Instance.new("UICorner", CodeBox).CornerRadius = UDim.new(0,6)
CodeBox.ClearTextOnFocus = false
CodeBox.FocusLost:Connect(function()
	if CodeBox.Text ~= "" then
		getgenv().FishCode = CodeBox.Text
	end
end)

-------------------------------------
-- 🔘 Toggle Auto Sell
-------------------------------------
local SellBtn = Instance.new("TextButton", Frame)
SellBtn.Size = UDim2.new(0.9, 0, 0, 25)
SellBtn.Position = UDim2.new(0.05, 0, 0.51, 0)
SellBtn.Text = "Auto Sell: OFF"
SellBtn.Font = Enum.Font.GothamBold
SellBtn.TextSize = 12
SellBtn.TextColor3 = Color3.fromRGB(255,255,255)
SellBtn.BackgroundColor3 = Color3.fromRGB(45,45,65)
Instance.new("UICorner", SellBtn).CornerRadius = UDim.new(0,6)

SellBtn.MouseButton1Click:Connect(function()
	getgenv().AutoSell = not getgenv().AutoSell
	SellBtn.Text = "Auto Sell: " .. (getgenv().AutoSell and "ON" or "OFF")
end)

-------------------------------------
-- 💰 Sell Amount Box
-------------------------------------
local SellBox = Instance.new("TextBox", Frame)
SellBox.Size = UDim2.new(0.9, 0, 0, 22)
SellBox.Position = UDim2.new(0.05, 0, 0.67, 0)
SellBox.Text = tostring(getgenv().SellAmount)
SellBox.PlaceholderText = "Sell Amount"
SellBox.Font = Enum.Font.Gotham
SellBox.TextSize = 11
SellBox.TextColor3 = Color3.fromRGB(255,255,255)
SellBox.BackgroundColor3 = Color3.fromRGB(40,40,60)
Instance.new("UICorner", SellBox).CornerRadius = UDim.new(0,6)
SellBox.ClearTextOnFocus = false

SellBox.FocusLost:Connect(function()
	local n = tonumber(SellBox.Text)
	if n then getgenv().SellAmount = n end
	SellBox.Text = tostring(getgenv().SellAmount)
end)

-------------------------------------
-- ⏱️ Delay Box
-------------------------------------
local DelayBox = Instance.new("TextBox", Frame)
DelayBox.Size = UDim2.new(0.9, 0, 0, 22)
DelayBox.Position = UDim2.new(0.05, 0, 0.83, 0)
DelayBox.Text = tostring(getgenv().Delay)
DelayBox.PlaceholderText = "Delay (sec)"
DelayBox.Font = Enum.Font.Gotham
DelayBox.TextSize = 11
DelayBox.TextColor3 = Color3.fromRGB(255,255,255)
DelayBox.BackgroundColor3 = Color3.fromRGB(40,40,60)
Instance.new("UICorner", DelayBox).CornerRadius = UDim.new(0,6)
DelayBox.ClearTextOnFocus = false

DelayBox.FocusLost:Connect(function()
	local n = tonumber(DelayBox.Text)
	if n then getgenv().Delay = n end
	DelayBox.Text = tostring(getgenv().Delay)
end)

-------------------------------------
-- 👁️ Hide GUI Button
-------------------------------------
local HideBtn = Instance.new("TextButton", ScreenGui)
HideBtn.Size = UDim2.new(0, 45, 0, 16)
HideBtn.Position = UDim2.new(0.05, 0, 0.22, 0)
HideBtn.Text = "Hide"
HideBtn.Font = Enum.Font.GothamBold
HideBtn.TextSize = 9
HideBtn.TextColor3 = Color3.fromRGB(255,255,255)
HideBtn.BackgroundColor3 = Color3.fromRGB(70,70,90)
Instance.new("UICorner", HideBtn).CornerRadius = UDim.new(0,4)
HideBtn.Active, HideBtn.Draggable = true, true

local hidden = false
HideBtn.MouseButton1Click:Connect(function()
	hidden = not hidden
	Frame.Visible = not hidden
	HideBtn.Text = hidden and "Show" or "Hide"
end)

-------------------------------------
-- 🔄 AUTO LOOP
-------------------------------------
task.spawn(function()
	while task.wait(getgenv().Delay) do
		pcall(function()

			if getgenv().AutoGive then
				GiveFishFunction:InvokeServer(getgenv().FishCode)
			end

			if getgenv().AutoSell then
				SellAllFishFunction:InvokeServer(getgenv().SellAmount)
			end

		end)
	end
end)