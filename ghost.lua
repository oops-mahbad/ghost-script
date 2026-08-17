local p,r,l,g=game:GetService("Players"),game:GetService("RunService"),game.Players.LocalPlayer,false
local pg=l:WaitForChild("PlayerGui")
local function set(s)for _,pl in pairs(p:GetPlayers())do if pl~=l and pl.Character then for _,v in pairs(pl.Character:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=not s end end end end end
local sg=Instance.new("ScreenGui",pg)sg.Name="Ghost"sg.ResetOnSpawn=false
local f=Instance.new("Frame",sg)f.Size=UDim2.new(0,200,0,110)f.Position=UDim2.new(.5,-100,.12,0)f.BackgroundColor3=Color3.fromRGB(255,182,193)Instance.new("UICorner",f).CornerRadius=UDim.new(0,16)
local t=Instance.new("TextLabel",f)t.Size=UDim2.new(1,0,0,28)t.BackgroundTransparency=1 t.Text="👻 Ghost Players"t.TextColor3=Color3.new(1,1,1)t.Font=Enum.Font.GothamBold t.TextSize=17
local st=Instance.new("TextLabel",f)st.Size=UDim2.new(1,0,0,18)st.Position=UDim2.new(0,0,0,30)st.BackgroundTransparency=1 st.Text="OFF"st.TextColor3=Color3.new(1,1,1)st.Font=Enum.Font.Gotham st.TextSize=13
local b=Instance.new("TextButton",f)b.Size=UDim2.new(0,150,0,36)b.Position=UDim2.new(.5,-75,0,58)b.BackgroundColor3=Color3.fromRGB(255,105,180)b.Text="Turn ON ✨"b.TextColor3=Color3.new(1,1,1)b.Font=Enum.Font.GothamBold b.TextSize=15 Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
b.MouseButton1Click:Connect(function()g=not g if g then b.Text="Turn OFF 💤"b.BackgroundColor3=Color3.fromRGB(144,238,144)st.Text="ON ✨"set(true)else b.Text="Turn ON ✨"b.BackgroundColor3=Color3.fromRGB(255,105,180)st.Text="OFF"set(false)end end)
r.Heartbeat:Connect(function()if g then set(true)end end)
print("Ghost short loaded")
