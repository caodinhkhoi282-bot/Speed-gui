--// Khôi Script - Speed GUI - By Khôi - lấy script làm tuất 

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
ScreenGui.Name = "KhoiScript"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 180, 0, 130)
Frame.Position = UDim2.new(0.5, -90, 0.7, 0)
Frame.BackgroundColor3 = Color3.fromRGB(10, 20, 50) -- Xanh đậm
Frame.BackgroundTransparency = 0.1
Instance.new("UICorner", Frame)

-- Viền xanh
local Stroke = Instance.new("UIStroke", Frame)
Stroke.Color = Color3.fromRGB(0, 200, 255)
Stroke.Thickness = 2
Stroke.Transparency = 0.5

-- Tiêu đề "Khôi Script" (giống hình)
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Khôi Script"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Dòng phụ "Speed"
local SubTitle = Instance.new("TextLabel", Frame)
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 28)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "⚡ Speed Control"
SubTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 12

-- Ô nhập speed
local Box = Instance.new("TextBox", Frame)
Box.Size = UDim2.new(0.8, 0, 0, 28)
Box.Position = UDim2.new(0.1, 0, 0.45, 0)
Box.PlaceholderText = "Nhập speed..."
Box.BackgroundColor3 = Color3.fromRGB(20, 30, 60)
Box.TextColor3 = Color3.fromRGB(0, 200, 255)
Box.Font = Enum.Font.Gotham
Box.TextSize = 14
Instance.new("UICorner", Box)

-- Trạng thái
local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.68, 0)
Status.BackgroundTransparency = 1
Status.Text = "Speed: 16 | OFF"
Status.TextColor3 = Color3.fromRGB(0, 200, 255)
Status.Font = Enum.Font.Gotham
Status.TextSize = 13

-- Nút Toggle
local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0.6, 0, 0, 25)
Button.Position = UDim2.new(0.2, 0, 0.85, 0)
Button.Text = "BẬT"
Button.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 14
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
        
        Status.Text = "Speed: " .. speed .. " | ON"
        Button.Text = "TẮT"
        Button.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    else
        if humanoid then
            humanoid.WalkSpeed = 16
        end
        
        Status.Text = "Speed: 16 | OFF"
        Button.Text = "BẬT"
        Button.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
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

print("✅ Khôi Script đã tải! Bấm nút BẬT để kích hoạt speed.")
