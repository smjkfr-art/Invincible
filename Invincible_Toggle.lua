-- Unified God Mode System

-- RemoteEvent for server communication
local RemoteEvent = game.ReplicatedStorage:WaitForChild("ToggleGodMode")
local player = game.Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 200, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -100, 0.5, -25)
ToggleButton.Text = "Toggle God Mode"
ToggleButton.Parent = ScreenGui
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Client-side toggle
ToggleButton.MouseButton1Click:Connect(function()
    RemoteEvent:FireServer()
end)

-- Server-side handling
RemoteEvent.OnServerEvent:Connect(function(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Health = humanoid.Health == 0 and 100 or 0
        -- Optionally you can include feedback for the client here
    end
end)