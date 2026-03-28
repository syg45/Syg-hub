-- ✨ syg Hub ✨ | Steal a Brainrot - Video Style UI + Dynamic Progress Bar
-- Universal version (Madium, Fluxus, Wave, Delta, etc.)

print("🚀 syg Hub loaded - Dynamic Progress Bar")

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 8)

-- Optimizations
task.spawn(function()
    RunService:Set3dRenderingEnabled(false)
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

    pcall(function() ReplicatedFirst:RemoveDefaultLoadingScreen() end)

    game.Loaded:Connect(function()
        task.wait(0.6)
        RunService:Set3dRenderingEnabled(true)
        Lighting.Brightness = 1
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    end)
end)

-- Main GUI
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

-- ==================== DYNAMIC STEALING PROGRESS BAR ====================
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

-- Progress Bar Control Function
local progressTween = nil
local pulseTween = nil

local function UpdateStealingProgress(targetName, progressValue, isActive)
    if progressTween then progressTween:Cancel() end
    if pulseTween then pulseTween:Cancel() end

    if isActive then
        -- Smooth progress fill
        local goalSize = UDim2.new(progressValue / 100, 0, 1, 0)
        progressTween = TweenService:Create(ProgressBar, TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = goalSize})
        progressTween:Play()

        -- Dynamic text with target name
        if targetName and targetName ~= "" then
            ProgressLabel.Text = "Stealing " .. targetName
        else
            ProgressLabel.Text = "Stealing Target..."
        end

        -- Gentle pulse glow
        pulseTween = TweenService:Create(ProgressGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            BackgroundTransparency = 0.35
        })
        pulseTween:Play()

    else
        -- Reset animation
        progressTween = TweenService:Create(ProgressBar, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 0, 1, 0)})
        progressTween:Play()

        ProgressLabel.Text = "Stealing Progress: 0%"
        ProgressGlow.BackgroundTransparency = 0.65
    end
end

-- ==================== TOGGLE CREATOR ====================
local yOffset = 160
local function AddToggle(name, defaultState, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0.92, 0, 0, 42)
    ToggleFrame.Position = UDim2.new(0.04, 0, 0, yOffset)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    ToggleFrame.Parent = MainFrame

    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.68, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.Parent = ToggleFrame

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 78, 0, 30)
    Btn.Position = UDim2.new(0.78, 0, 0.5, -15)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
    Btn.Text = defaultState and "ON" or "OFF"
    Btn.TextColor3 = defaultState and Color3.fromRGB(100, 255, 120) or Color3.fromRGB(255, 100, 100)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamBold
    Btn.Parent = ToggleFrame

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

    local active = defaultState
    Btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            Btn.Text = "ON"
            Btn.TextColor3 = Color3.fromRGB(100, 255, 120)
            Btn.BackgroundColor3 = Color3.fromRGB(35, 75, 40)
        else
            Btn.Text = "OFF"
            Btn.TextColor3 = Color3.fromRGB(255, 100, 100)
            Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
        end
        if callback then callback(active) end
    end)

    yOffset = yOffset + 52
end

-- ==================== FEATURES ====================
AddToggle("Auto Steal", false, function(v)
    -- Example: You can change target name dynamically here
    local currentTarget = "Diamond Chicleteirina"  -- Change this to actual target from game
    UpdateStealingProgress(currentTarget, v and 92 or 0, v)
    print("Auto Steal:", v)
end)

AddToggle("Invis Steal", false, function(v) print("Invis Steal:", v) end)
AddToggle("Steal Speed Boost", false, function(v) print("Steal Speed Boost:", v) end)
AddToggle("Auto TP to Best", false, function(v) print("Auto TP to Best:", v) end)
AddToggle("Auto TP Inside Base + Body Swap", false, function(v) print("Auto TP Inside:", v) end)
AddToggle("Instant Clone", false, function(v) print("Instant Clone:", v) end)
AddToggle("Beam to Best Brainrot", false, function(v) print("Beam to Best:", v) end)

AddToggle("Admin Panel Spammer", false, function(v) print("Admin Spammer:", v) end)
AddToggle("Highest Value Brainrot ESP", false, function(v) print("ESP:", v) end)
AddToggle("Infinite Jump", false, function(v)
    if v then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            pcall(function() player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
        end)
    end
end)

AddToggle("Desync (No Anim)", false, function(v) print("Desync:", v) end)
AddToggle("Auto Kick", false, function(v) print("Auto Kick:", v) end)

print("✅ syg Hub UI loaded with dynamic 'Stealing [Target Name]' progress bar!")
print("Tip: Change 'currentTarget' variable inside Auto Steal toggle to show real target name.")