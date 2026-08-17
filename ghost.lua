local p = game:GetService("Players")
local r = game:GetService("RunService")
local l = p.LocalPlayer
local g = false

local pg = l:WaitForChild("PlayerGui")
local currentFF = nil

-- Ghost (no collide player)
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

-- Anti Slap
local function antiSlap()
	local char = l.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if root and root.AssemblyLinearVelocity.Magnitude > 40 then
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
	end
end

-- ForceField
local function setForceField(s)
	local char = l.Character
	if not char then return end

	if s then
		if not char:FindFirstChildOfClass("ForceField") then
			local ff = Instance.new("ForceField")
			ff.Parent = char
			currentFF = ff
		end
	else
		local ff = char:FindFirstChildOfClass("ForceField")
		if ff then
			ff:Destroy()
		end
		currentFF = nil
	end
end

-- GUI
local sg = Instance.new("ScreenGui", pg)
sg.Name = "Ghost"
sg.ResetOnSpawn = false

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 220, 0, 115)
f.Position = UDim2.new(0.5, -110, 0.12, 0)
f.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 16)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 28)
t.BackgroundTransparency = 1
t.Text = "👻 Ghost + FF + AntiSlap"
t.TextColor3 = Color3.new(1, 1, 1)
t.Font = Enum.Font.GothamBold
t.TextSize = 15

local st = Instance.new("TextLabel", f)
st.Size = UDim2.new(1, 0, 0, 18)
st.Position = UDim2.new(0, 0, 0, 30)
st.BackgroundTransparency = 1
st.Text = "OFF"
st.TextColor3 = Color3.new(1, 1, 1)
st.Font = Enum.Font.Gotham
st.TextSize = 13

local b = Instance.new("TextButton", f)
b.Size = UDim2.new(0, 170, 0, 38)
b.Position = UDim2.new(0.5, -85, 0, 58)
b.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
b.Text = "Turn ON ✨"
b.TextColor3 = Color3.new(1, 1, 1)
b.Font = Enum.Font.GothamBold
b.TextSize = 15
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

-- Toggle
b.MouseButton1Click:Connect(function()
	g = not g
	if g then
		b.Text = "Turn OFF 💤"
		b.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
		st.Text = "ON ✨"
		setGhost(true)
		setForceField(true)
	else
		b.Text = "Turn ON ✨"
		b.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		st.Text = "OFF"
		setGhost(false)
		setForceField(false)
	end
end)

-- Loop
task.spawn(function()
	while true do
		if g then
			setGhost(true)
			antiSlap()
			setForceField(true)
		end
		task.wait(0.15)
	end
end)

-- Auto bila respawn
l.CharacterAdded:Connect(function()
	task.wait(0.3)
	if g then
		setGhost(true)
		setForceField(true)
	end
end)

print("Ghost + ForceField + AntiSlap loaded")
