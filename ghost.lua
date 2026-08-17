print("STEP 1 - Script start")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
print("STEP 2 - LocalPlayer ok")

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
print("STEP 3 - PlayerGui ok")

local sg = Instance.new("ScreenGui")
sg.Name = "TestDebug"
sg.ResetOnSpawn = false
sg.Parent = PlayerGui
print("STEP 4 - ScreenGui parented")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 100)
frame.Position = UDim2.new(0.5, -125, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.Parent = sg
print("STEP 5 - Frame created")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.Text = "KALAU NAMPAK NI = GUI WORK"
label.TextColor3 = Color3.new(1,1,1)
label.TextSize = 18
label.Font = Enum.Font.GothamBold
label.Parent =
