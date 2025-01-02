-- Predpokladáme, že vozidlo je vo Workspace a má určité časti ako "BodyVelocity" pre pohyb-- Vytvorenie ScreenGui objektu
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

-- Vytvorenie TextLabel pre zobrazenie správy
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 400, 0, 100)  -- Nastavenie veľkosti
textLabel.Position = UDim2.new(0.5, -200, 0.5, -50)  -- Nastavenie pozície na obrazovke
textLabel.Text = "Drift Mode Activated!"  -- Text ktorý sa zobrazí
textLabel.TextSize = 30
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Biela farba textu
textLabel.BackgroundTransparency = 1  -- Skrytie pozadia
textLabel.Visible = false  -- Skryté na začiatku
textLabel.Parent = screenGui

-- Vytvorenie TextButton pre aktiváciu drift módu
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)  -- Veľkosť tlačidla
button.Position = UDim2.new(0.5, -100, 0.5, 50)  -- Pozícia tlačidla
button.Text = "Activate Drift Mode"  -- Text na tlačidle
button.TextSize = 24
button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Farba textu tlačidla
button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Farba pozadia tlačidla
button.Parent = screenGui

-- Funkcia na aktiváciu drift módu
local function activateDriftMode()
    -- Zobraziť TextLabel
    textLabel.Visible = true
    -- Môžeš pridať kód na aktiváciu driftovania tu
    -- Ak máš vozidlo, môžeš upravit jeho správanie podľa potreby

    -- Skrytí tlačidla po aktivácii
    button.Visible = false
end

-- Pri kliknutí na tlačidlo sa aktivuje drift mód
button.MouseButton1Click:Connect(activateDriftMode)


local player = game.Players.LocalPlayer
local car = player.Character:WaitForChild("Vehicle") -- Predpokladáme, že vozidlo sa nachádza v postave hráča
local vehicleBody = car:WaitForChild("BodyVelocity") -- Predpokladáme, že vozidlo má komponentu BodyVelocity

local driftFactor = 1.5 -- Určuje, ako rýchlo sa vozidlo bude "driftovať"
local maxSpeed = 100 -- Maximálna rýchlosť

-- Funkcia na ovládanie driftovania
local function driftControl()
    local velocity = vehicleBody.Velocity
    local speed = velocity.Magnitude

    if speed > maxSpeed then
        -- Ak je rýchlosť väčšia než maxSpeed, spomalíme vozidlo a umožníme driftovanie
        vehicleBody.Velocity = velocity * 0.95 -- Spomalíme vozidlo
    end
    
    -- Nastavenie rýchlosti driftovania podľa klávesov
    local direction = game:GetService("UserInputService"):GetInputState(Enum.UserInputType.MouseButton1) -- Pravé tlačidlo myši na driftovanie
    if direction == Enum.UserInputState.Begin then
        -- Ak držíš pravé tlačidlo myši, začne driftovanie
        vehicleBody.Velocity = velocity + Vector3.new(driftFactor, 0, driftFactor) -- Zmena rýchlosti pre driftovanie
    end
end

-- Opakujeme funkciu na každú sekundu
while true do
    driftControl()
    wait(0.1) -- Kontroluj drift každých 0.1 sekundy
end
