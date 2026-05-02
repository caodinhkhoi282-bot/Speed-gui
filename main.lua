--// Infinite Speed GUI Drag - By Giáo Sư

local player = game.Players.LocalPlayer
local humanoid

local function getHumanoid()
	if player.Character then
		return player.Character:FindFirstChildOfClass("Humanoid")
	end
end

player.CharacterAdded:Connect(function()
	task.wait(1)
	humanoid = getHumanoid()
end)

humanoid = getHumanoid()

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "SpeedGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,160,0,110)
Frame.Position = UDim2.new(0.5,-80,0.7,0)
Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
Instance.new("UICorner", Frame)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,25)
Title.BackgroundTransparency = 1
Title.Text = "Speed"
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.TextScaled = true

local Box = Instance.new("TextBox", Frame)
Box.Size = UDim2.new(0.8,0,0,25)
Box.Position = UDim2.new(0.1,0,0.35,0)
Box.PlaceholderText = "Nhập speed..."
Box.BackgroundColor3 = Color3.fromRGB(20,20,20)
Box.TextColor3 = Color3.fromRGB(0,170,255)
Instance.new("UICorner", Box)

local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1,0,0,20)
Status.Position = UDim2.new(0,0,0.65,0)
Status.BackgroundTransparency = 1
Status.Text = "Speed: 16 | OFF"
Status.TextColor3 = Color3.fromRGB(0,170,255)
Status.TextScaled = true

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0.8,0,0,25)
Button.Position = UDim2.new(0.1,0,0.82,0)
Button.Text = "Toggle"
Button.BackgroundColor3 = Color3.fromRGB(0,0,0)
Button.TextColor3 = Color3.fromRGB(0,170,255)
Instance.new("UICorner", Button)

-- Logic
local enabled = false
local speed = 16

Button.MouseButton1Click:Connect(function()
	enabled = not enabled
	
	if enabled then
		local num = tonumber(Box.Text)
		if num then
			speed = num
		end
		
		if humanoid then
			humanoid.WalkSpeed = speed
		end
		
		Status.Text = "Speed: "..speed.." | ON"
	else
		if humanoid then
			humanoid.WalkSpeed = 16
		end
		
		Status.Text = "Speed: 16 | OFF"
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if enabled and humanoid then
		humanoid.WalkSpeed = speed
	end
end)

-- Drag chuẩn
local UIS = game:GetService("UserInputService")
local dragging, dragStart, startPos

Frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then
		
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Frame.InputChanged:Connect(function(input)
	if dragging then
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
