-- Predpokladáme, že vozidlo je vo Workspace a má určité časti ako "BodyVelocity" pre pohyb

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
