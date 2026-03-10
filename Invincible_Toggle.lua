--[[
    MOBILE FRIENDLY GOD MODE (INVINCIBILITY)
    - Works on mobile + PC
    - Big tap-friendly button
    - God Mode ON/OFF toggle
    - Health always max (never die)
    - R6 + R15 support
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local GODMODE = false

-------------------------------------------------
-- GUI (Mobile Friendly)
-------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true -- Prevents cutoff on mobile notch phones
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "GodModeButton"
button.Size = UDim2.new(0, 260, 0, 90)        -- Bigger tap area for mobile
button.Position = UDim2.new(0.5, -130, 0, 30) -- Center top
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.BorderSizePixel = 3
button.BorderColor3 = Color3.fromRGB(255,255,255)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.SourceSansBold
button.Text = "God Mode: OFF"
button.AutoButtonColor = true
button.Parent = gui


-------------------------------------------------
-- GOD MODE LOGIC
-------------------------------------------------
local function applyGodMode(character)
    local humanoid = character:WaitForChild("Humanoid")

    -- Instantly restore health if damaged
    humanoid.HealthChanged:Connect(function(health)
        if GODMODE and health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)

    -- Constant loop: keep health max
    task.spawn(function()
        while character.Parent do
            if GODMODE then
                humanoid.Health = humanoid.MaxHealth
            end
            task.wait(0.05)
        end
    end)
end

-- Apply when character spawns
player.CharacterAdded:Connect(applyGodMode)

-- If character already exists, apply now
if player.Character then
    applyGodMode(player.Character)
end


-------------------------------------------------
-- BUTTON TOGGLE
-------------------------------------------------
button.MouseButton1Click:Connect(function()
    GODMODE = not GODMODE
    button.Text = "God Mode: " .. (GODMODE and "ON" or "OFF")
end)
