-- Protection + Mimic GUI for Xeno

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = char:WaitForChild("Humanoid")
	HRP = char:WaitForChild("HumanoidRootPart")
end)

-- Status
local antiSlap = false
local antiFreeze = false
local invisible = false
local mimic = false
local softMimic = false
local targetPlayer = nil

-- Functions
local function getTarget(name)
	if not name or name == "" then return nil end
	name = name:lower()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Name:lower():find(name) then
			return plr
		end
	end
	return nil
end

local function setInvisible(state)
	if not Character then return end
	for _, v in ipairs(Character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = state and 1 or 0
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v.Transparency = state and 1 or 0
		end
	end
	for _, acc in ipairs(Character:GetChildren()) do
		if acc:IsA("Accessory") then
			for _, p in ipairs(acc:GetDescendants()) do
				if p:IsA("BasePart") or p:IsA("Decal") then
					p.Transparency = state and 1 or 0
				end
			end
		end
	end
end

-- GUI
local sg = Instance.new("ScreenGui")
sg.Name = "ProtectMimicGui"
sg.ResetOnSpawn = false
sg.Parent = PlayerGui

local f = Instance.new("Frame")
f.Size = UDim2.new(0, 210, 0, 380)
f.Position = UDim2.new(0, 15, 0.5, -190)
f.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
f.BorderSizePixel = 0
f.Active = true
f.Parent = sg

Instance.new("UICorner", f).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "✨ Protection + Mimic"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = f

-- Target Box
local targetBox = Instance.new("TextBox")
targetBox.Size = UDim2.new(0, 180, 0, 28)
targetBox.Position = UDim2.new(0.5, -90, 0, 35)
targetBox.BackgroundColor3 = Color3.fromRGB(255, 220, 230)
targetBox.PlaceholderText = "Target Name..."
targetBox.Text = ""
targetBox.TextColor3 = Color3.fromRGB(50, 50, 50)
targetBox.Font = Enum.Font.Gotham
targetBox.TextSize = 13
targetBox.ClearTextOnFocus = false
targetBox.Parent = f
Instance.new("UICorner", targetBox).CornerRadius = UDim.new(0, 8)

-- Buttons
local function makeBtn(text, y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, 180, 0, 32)
	b.Position = UDim2.new(0.5, -90, 0, y)
	b.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
	b.Text = text
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.Parent = f
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
	return b
end

local bAntiSlap = makeBtn("Anti Slap: OFF", 75)
local bAntiFreeze = makeBtn("Anti Freeze: OFF", 115)
local bInvisible = makeBtn("Invisible: OFF", 155)
local bCopy = makeBtn("Copy Avatar", 195)
local bMimic = makeBtn("Mimic: OFF", 235)
local bSoft = makeBtn("Soft Mimic: OFF", 275)
local bStop = makeBtn("Stop Mimic", 315)

-- Toggle helpers
local function toggleBtn(btn, state, onText, offText)
	if state then
		btn.Text = onText
		btn.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
	else
		btn.Text = offText
		btn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
	end
end

-- Button Events
bAntiSlap.MouseButton1Click:Connect(function()
	antiSlap = not antiSlap
	toggleBtn(bAntiSlap, antiSlap, "Anti Slap: ON ✨", "Anti Slap: OFF")
end)

bAntiFreeze.MouseButton1Click:Connect(function()
	antiFreeze = not antiFreeze
	toggleBtn(bAntiFreeze, antiFreeze, "Anti Freeze: ON ✨", "Anti Freeze: OFF")
end)

bInvisible.MouseButton1Click:Connect(function()
	invisible = not invisible
	toggleBtn(bInvisible, invisible, "Invisible: ON ✨", "Invisible: OFF")
	setInvisible(invisible)
end)

bCopy.MouseButton1Click:Connect(function()
	local target = getTarget(targetBox.Text)
	if target then
		local success, desc = pcall(function()
			return Players:GetHumanoidDescriptionFromUserId(target.UserId)
		end)
		if success and desc and Humanoid then
			pcall(function()
				Humanoid:ApplyDescription(desc)
			end)
		end
	end
end)

bMimic.MouseButton1Click:Connect(function()
	mimic = not mimic
	if mimic then
		softMimic = false
		toggleBtn(bSoft, false, "Soft Mimic: ON ✨", "Soft Mimic: OFF")
		targetPlayer = getTarget(targetBox.Text)
	end
	toggleBtn(bMimic, mimic, "Mimic: ON ✨", "Mimic: OFF")
end)

bSoft.MouseButton
