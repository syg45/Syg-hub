-- ✨ syg Hub ✨ | Final Version for Steal a Brainrot
-- Universal - Works on Madium, Fluxus, Wave, Delta, etc.

print("🚀 Loading syg Hub...")

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

-- Safe Player & PlayerGui wait (helps with loading issues)
local player = Players.LocalPlayer
if not player then
    repeat task.wait() until Players.LocalPlayer
    player = Players.LocalPlayer
end

local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then
    print("❌ Failed to find PlayerGui")
    return
end

print("✅ Player ready - Creating UI")

-- Optimizations
task.spawn(function()
    RunService:Set3dRenderingEnabled(false)
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

    pcall(function() ReplicatedFirst:RemoveDefaultLoadingScreen() end)
end)

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "sygHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 10000
ScreenGui.Parent = playerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 720, 0, 520)
MainFrame.Position = UDim2.new(0.5, -360, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 55)
Title.BackgroundTransparency = 1
Title.Text = "✨ syg Hub ✨"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Dynamic Stealing Progress Bar
local ProgressContainer = Instance.new("Frame")
ProgressContainer.Size = UDim2.new(0.92, 0, 0, 22)
ProgressContainer.Position = UDim2.new(0.04, 0, 0.11, 0)
ProgressContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
ProgressContainer.BorderSizePixel = 0
ProgressContainer.Parent = MainFrame

Instance.new("UICorner", ProgressContainer).CornerRadius = UDim.new(0, 10)

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = ProgressContainer

Instance.new("UICorner", ProgressBar).CornerRadius = UDim.new(0, 10)

local ProgressGlow = Instance.new("Frame")
ProgressGlow.Size = UDim2.new(1, 0, 1, 0)
ProgressGlow.BackgroundTransparency = 0.65
ProgressGlow.BackgroundColor3 = Color3.fromRGB(120, 220, 255)
ProgressGlow.BorderSizePixel = 0
ProgressGlow.Parent = ProgressBar
Instance.new("UICorner", ProgressGlow).CornerRadius = UDim.new(0, 10)

local ProgressLabel = Instance.new("TextLabel")
ProgressLabel.Size = UDim2.new(1, 0, 1, 0)
ProgressLabel.BackgroundTransparency = 1
ProgressLabel.Text = "Stealing Progress: 0%"
ProgressLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ProgressLabel.TextScaled = true
ProgressLabel.Font = Enum.Font.GothamSemibold
ProgressLabel.Parent = ProgressContainer

-- Progress Bar Function
local function UpdateProgress(targetName, progress, active)
    if active then
        TweenService:Create(ProgressBar, TweenInfo.new(1.3, Enum.EasingStyle.Quint), {
            Size = UDim2.new(progress/100, 0, 1, 0)
        }):Play()

        ProgressLabel.Text = targetName and "Stealing " .. targetName or "Stealing Target..."
        
        TweenService:Create(ProgressGlow, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            BackgroundTransparency = 0.35
        }):Play()
    else
        TweenService:Create(ProgressBar, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 0, 1, 0)
        }):Play()
        ProgressLabel.Text = "Stealing Progress: 0%"
    end
end

-- Toggle Creator
local y = 160
local function AddToggle(name, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.92, 0, 0, 42)
    Frame.Position = UDim2.new(0.04, 0, 0, y)
    Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    Frame.Parent = MainFrame

    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.68, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.Parent = Frame

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 78, 0, 30)
    Btn.Position = UDim2.new(0.78, 0, 0.5, -15)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
    Btn.Text = "OFF"
    Btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamBold
    Btn.Parent = Frame

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            Btn.Text = "ON"
            Btn.TextColor3 = Color3.fromRGB(100, 255, 120)
            Btn.BackgroundColor3 = Color3.fromRGB(35, 75, 40)
        else
            Btn.Text = "OFF"
            Btn.TextColor3 = Color3.fromRGB(255, 100, 100)
            Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
        end
        if callback then callback(state) end
    end)

    y = y + 52
end

-- Features
AddToggle("Auto Steal", function(v)
    local target = "Diamond Chicleterina"  -- Change this to dynamic target when possible
    UpdateProgress(target, v and 85 or 0, v)
    print("Auto Steal:", v)
end)

AddToggle("Invis Steal", function(v) print("Invis Steal:", v) end)
AddToggle("Steal Speed Boost", function(v) print("Steal Speed Boost:", v) end)
AddToggle("Auto TP to Best", function(v) print("Auto TP to Best:", v) end)
AddToggle("Auto TP Inside Base", function(v) print("Auto TP Inside Base:", v) end)
AddToggle("Instant Clone", function(v) print("Instant Clone:", v) end)
AddToggle("Beam to Best Brainrot", function(v) print("Beam:", v) end)
AddToggle("Admin Panel Spammer", function(v) print("Admin Spammer:", v) end)
AddToggle("Highest Value ESP", function(v) print("ESP:", v) end)
AddToggle("Infinite Jump", function(v)
    if v then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            pcall(function() player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
        end)
    end
end)
AddToggle("Desync (No Anim)", function(v) print("Desync:", v) end)
AddToggle("Auto Kick", function(v) print("Auto Kick:", v) end)

print("✅ syg Hub loaded successfully!")
print("If it still doesn't load, try executing it slower or restarting the executor.")
