-- Protection + Mimic (Xeno Version)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

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

-- Get parent for Xeno
local function getParent()
	local success, ui = pcall(function()
		if gethui then return gethui() end
		if Xeno and Xeno.gethui then return Xeno.gethui() end
		return game:GetService("CoreGui")
	end)
	if success and ui then return ui end
	return LocalPlayer:WaitForChild("PlayerGui")
end

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
end

-- GUI
local sg = Instance.new("ScreenGui")
sg.Name = "XenoProtectGui"
sg.ResetOnSpawn = false
sg.Parent = getParent()

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
title.BackgroundTransparency =
