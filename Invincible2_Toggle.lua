local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- RemoteEvent for toggling godmode
local toggle = Instance.new("RemoteEvent")
toggle.Name = "ToggleGodMode"
toggle.Parent = ReplicatedStorage

local godMode = {}

Players.PlayerAdded:Connect(function(player)
    godMode[player] = false
    
    player.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid")

        -- If godmode is enabled, repair health instantly
        hum.HealthChanged:Connect(function(current)
            if godMode[player] then
                hum.Health = hum.MaxHealth
            end
        end)

        -- Constant lock
        task.spawn(function()
            while hum.Parent do
                if godMode[player] then
                    hum.MaxHealth = math.huge
                    hum.Health = hum.MaxHealth
                end
                task.wait(0.05)
            end
        end)
    end)
end)

-- Toggle from client
toggle.OnServerEvent:Connect(function(player, state)
    godMode[player] = state
end)
