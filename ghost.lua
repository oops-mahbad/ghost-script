local p = game:GetService("Players")
local uis = game:GetService("UserInputService")
local l = p.LocalPlayer
local pg = l:WaitForChild("PlayerGui")

local ghostOn = false
local slapOn = false
local ffOn = false
local minimized = false

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
f.Size = UDim2.new(0, 190, 0, 185)
f.Position = UDim2.new(0.02, 0, 0.35, 0) -- kiri sikit supaya tak cover tengah
f.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
f.Active = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel", f)
title.Size = UDim2.new(1, -30, 0, 26)
title.Position = UDim2.new(0, 8, 0, 4)
title.BackgroundTransparency = 1
title.Text = "✨ Protection"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize button
local minBtn = Instance.new("TextButton", f)
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -28, 0, 4)
minBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 180)
minBtn.Text = "–"
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 16
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- Buttons
local b1 = Instance.new("TextButton", f)
b1.Size = UDim2.new(0, 160, 0, 34)
b1.Position = UDim2.new(0.5, -80, 0, 38)
b1.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
b1.Text = "Ghost: OFF"
b1.TextColor3 = Color3.new(1,1,1)
b1.Font = Enum.Font.GothamBold
b1.TextSize = 13
Instance.new("UICorner", b1).CornerRadius = UDim.new(0, 9)

local b2 = Instance.new("TextButton", f)
b2.Size = UDim2.new(0, 160, 0, 34)
b2.Position = UDim2.new(0.5, -80, 0, 78)
b2.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
b2.Text = "Anti Slap: OFF"
b2.TextColor3 = Color3.new(1,1,1)
b2.Font = Enum.Font.GothamBold
b2.TextSize = 13
Instance.new("UICorner", b2).CornerRadius = UDim.new(0, 9)

local b3 = Instance.new("TextButton", f)
b3.Size = UDim2.new(0, 160, 0, 34)
b3.Position = UDim2.new(0.5, -80, 0, 118)
b3.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
b3.Text = "ForceField: OFF"
b3.TextColor3 = Color3.new(1,1,1)
b3.Font = Enum.Font.GothamBold
b3.TextSize = 13
Instance.new("UICorner", b3).CornerRadius = UDim.new(0, 9)

-- Minimize function
minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		f.Size = UDim2.new(0, 190, 0, 32)
		b1.Visible = false
		b2.Visible = false
		b3.Visible = false
		minBtn.Text = "+"
	else
		f.Size = UDim2.new(0, 190, 0, 185)
		b1.Visible = true
		b2.Visible = true
		b3.Visible = true
		minBtn.Text = "–"
	end
end)

-- Toggle buttons
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

-- Drag GUI
local dragging, dragStart, startPos
f.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = f.Position
	end
end)
f.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
uis.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		f.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
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

-- Keep ON after die
l.CharacterAdded:Connect(function()
	task.wait(0.4)
	if ghostOn then setGhost(true) end
	if ffOn then setForceField(true) end
end)

print("Protection GUI loaded (draggable + minimize)")
