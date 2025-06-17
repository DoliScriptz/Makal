local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Services = {
    UserInputService = game:GetService("UserInputService"),
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    RunService = game:GetService("RunService"),
    Workspace = game:GetService("Workspace"),
    TweenService = game:GetService("TweenService"),
    TextChatService = game:GetService("TextChatService"),
    SoundService = game:GetService("SoundService")
}

local LocalPlayer = Services.Players.LocalPlayer
local localChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = localChar:WaitForChild("HumanoidRootPart")
local function createNotification(text)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1, 0, 0, 4)
	Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Frame.BackgroundTransparency = 0.5
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0, 0, 0, 0)
	Frame.Parent = Container
	Frame.LayoutOrder = tick()

	local UICorner = Instance.new("UICorner", Frame)
	UICorner.CornerRadius = UDim.new(0, 6)

	local UIStroke = Instance.new("UIStroke", Frame)
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 2

	local TitleLabel = Instance.new("TextLabel", Frame)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Position = UDim2.new(0, 10, 0, 4)
	TitleLabel.Size = UDim2.new(1, -20, 0, 18)
	TitleLabel.Font = Enum.Font.Gotham
	TitleLabel.RichText = true
TitleLabel.Text = "<font color='rgb(0,125,255)'>Makal Hub</font> says:"
	TitleLabel.TextColor3 = Color3.new(1, 1, 1)
	TitleLabel.TextSize = 12
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.TextTransparency = 1

	local MessageLabel = Instance.new("TextLabel", Frame)
	MessageLabel.BackgroundTransparency = 1
	MessageLabel.Position = UDim2.new(0, 10, 0, 26)
	MessageLabel.Size = UDim2.new(1, -20, 0, 28)
	MessageLabel.Font = Enum.Font.Gotham
	MessageLabel.Text = text or "Notification"
	MessageLabel.TextColor3 = Color3.new(1, 1, 1)
	MessageLabel.TextSize = 12
	MessageLabel.TextWrapped = true
	MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
	MessageLabel.TextTransparency = 1
	MessageLabel.RichText = true

	Services.TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(1, 0, 0, 60)
	}):Play()

	task.delay(0.2, function()
		Services.TweenService:Create(TitleLabel, TweenInfo.new(0.4), { TextTransparency = 0 }):Play()
		Services.TweenService:Create(MessageLabel, TweenInfo.new(0.4), { TextTransparency = 0 }):Play()
	end)

    task.delay(5.5, function()
        Services.TweenService:Create(TitleLabel, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
        Services.TweenService:Create(MessageLabel, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
        task.wait(0.3)
        local tweenOut = Services.TweenService:Create(
            Frame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            { Size = UDim2.new(1, 0, 0, 4) }
        )
        tweenOut:Play()
        tweenOut.Completed:Wait()
        Frame:Destroy()
    end)
end
local Utility = {}
pcall(function()
    getgenv().XproD_TrainSpeed   = getgenv().XproD_TrainSpeed   or false
    getgenv().XproD_TrainAgility = getgenv().XproD_TrainAgility or false
end)

pcall(function()
    Utility.speedFarm = function()
        if Utility._speedRunning then return end
        Utility._speedRunning = true
        while getgenv().XproD_TrainSpeed and task.wait() do
            pcall(function()
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                if hum then hum:Move(Vector3.new(0,0,1), true) end
                Services.ReplicatedStorage.RemoteEvents.SpeedTrainingEvent:FireServer(true)
            end)
        end
        Utility._speedRunning = false
    end
end)

pcall(function()
    Utility.agilityFarm = function()
        if Utility._agilityRunning then return end
        Utility._agilityRunning = true
        while getgenv().XproD_TrainAgility and task.wait() do
            pcall(function()
                Services.ReplicatedStorage.RemoteEvents.AgilityTrainingEvent:FireServer(true)
            end)
        end
        Utility._agilityRunning = false
    end
end)

pcall(function()
    if game.GameId ~= 18354308669 then return end
createNotification("<font color='rgb(102,255,0)'>Loading Anime Fighting SR Script.</font>")
    local Window = Rayfield:CreateWindow({
    Name = "Makal Hub | ASFR",
    Icon = 0,
    LoadingTitle = "Please Wait.",
    LoadingSubtitle = "by Xynnn Him Self! :3",
    Theme = "DarkBlue",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Big Hub"
    },
    Discord = {
        Enabled = true,
        Invite = "getfrost",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Hello"}
    }
})

    local TrainTab  = Window:CreateTab("Training", 14594347870)
    local CreditTab = Window:CreateTab("Credits", 14594347870)

    TrainTab:CreateToggle({
        Name = "Train Speed",
        CurrentValue = getgenv().XproD_TrainSpeed,
        Callback = function(state)
            pcall(function()
                getgenv().XproD_TrainSpeed = state
                if state then task.spawn(Utility.speedFarm) end
            end)
        end
    })

    TrainTab:CreateToggle({
        Name = "Train Agility",
        CurrentValue = getgenv().XproD_TrainAgility,
        Callback = function(state)
            pcall(function()
                getgenv().XproD_TrainAgility = state
                if state then task.spawn(Utility.agilityFarm) end
            end)
        end
      })
    createNotification("Script has Loaded <font color='rgb(78,255,0)'>successfully!</font>")
	end)
