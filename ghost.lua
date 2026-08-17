local p = game:GetService("Players")
local l = p.LocalPlayer
local pg = l:WaitForChild("PlayerGui")

local ghostOn = false
local slapOn = false
local ffOn = false

-- Functions
local function setGhost(s)
	for _, pl in pairs(p:GetPlayers()) do
		if pl ~= l and pl.Character then
			for _, v in pairs(pl.Character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = not s
				end
			end
		end
	end
end

local function antiSlap()
	local char = l.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if root and root.AssemblyLinearVelocity.Magnitude > 40 then
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
	end
end

local function setForceField(s)
	local char = l.Character
	if not char then return end
	local ff = char:FindFirstChildOfClass("ForceField")
	if s then
		if not ff then
			Instance.new("ForceField").Parent = char
		end
	else
		if ff then ff:Destroy() end
	end
end

-- GUI
local sg = Instance.new("ScreenGui", pg)
sg.Name = "MultiGui"
sg.ResetOnSpawn = false

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 200, 0, 195)
f.Position = UDim2.new(0.5, -100, 0.1, 0)
f.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel", f)
title.Size = UDim2.new(1, 0, 0, 28)
title.BackgroundTransparency = 1
title.Text = "✨ Protection"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- Button 1: Ghost
local b1 = Instance.new("TextButton", f)
b1.Size = UDim2.new(0, 170, 0, 36)
b1.Position = UDim2.new(0.5, -85, 0, 40)
b1.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
b1.Text = "Ghost: OFF"
b1.TextColor3 = Color3.new(1,1,1)
b1.Font = Enum.Font.GothamBold
b1.TextSize = 14
Instance.new("UICorner", b1).CornerRadius = UDim.new(0, 10)

-- Button 2: Anti Slap
local b2 = Instance.new("TextButton", f)
b2.Size = UDim2.new(0, 170, 0, 36)
b2.Position = UDim2.new(0.5, -85, 0, 85)
b2.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
b2.Text = "Anti Slap: OFF"
b2.TextColor3 = Color3.new(1,1,1)
b2.Font = Enum.Font.GothamBold
b2.TextSize = 14
Instance.new("UICorner", b2).CornerRadius = UDim.new(0, 10)

-- Button 3: ForceField
local b3 = Instance.new("TextButton", f)
b3.Size = UDim2.new(0, 170, 0, 36)
b3.Position = UDim2.new(0.5, -85, 0, 130)
b3.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
b3.Text = "ForceField: OFF"
b3.TextColor3 = Color3.new(1,1,1)
b3.Font = Enum.Font.GothamBold
b3.TextSize = 14
Instance.new("UICorner", b3).CornerRadius = UDim.new(0, 10)

-- Toggle functions
b1.MouseButton1Click:Connect(function()
	ghostOn = not ghostOn
	if ghostOn then
		b1.Text = "Ghost: ON ✨"
		b1.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
		setGhost(true)
	else
		b1.Text = "Ghost: OFF"
		b1.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		setGhost(false)
	end
end)

b2.MouseButton1Click:Connect(function()
	slapOn = not slapOn
	if slapOn then
		b2.Text = "Anti Slap: ON ✨"
		b2.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
	else
		b2.Text = "Anti Slap: OFF"
		b2.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
	end
end)

b3.MouseButton1Click:Connect(function()
	ffOn = not ffOn
	if ffOn then
		b3.Text = "ForceField: ON ✨"
		b3.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
		setForceField(true)
	else
		b3.Text = "ForceField: OFF"
		b3.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		setForceField(false)
	end
end)

-- Loop
task.spawn(function()
	while true do
		if ghostOn then setGhost(true) end
		if slapOn then antiSlap() end
		if ffOn then setForceField(true) end
		task.wait(0.15)
	end
end)

-- Auto respawn
l.CharacterAdded:Connect(function()
	task.wait(0.3)
	if ghostOn then setGhost(true) end
	if ffOn then setForceField(true) end
end)

print("3 Buttons GUI loaded")
