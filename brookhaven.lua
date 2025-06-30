local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local NameColorRemote = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1RPNam1eColo1r")
local TextRemote = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1RPNam1eTex1t")
local ToolRemote = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Too1l")
local GunRemote = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Gu1n")
local BodyColorRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ChangeBodyColor")

local Speed = 1
local Saturation = 1
local Value = 1
local WaitTime = 0.0001
local BodyColorDelay = 1
local GunDelay = 0.5

local BodyColors = {
    "Institutional white",
    "Royal purple",
    "Really blue",
    "Toothpaste",
    "Parsley green",
    "Lime green",
    "New Yeller",
    "Deep orange",
    "Brick yellow",
    "Pastel brown",
    "CGA brown",
    "Really red"
}

local function HSVToRGB(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    if i % 6 == 0 then
        r, g, b = v, t, p
    elseif i % 6 == 1 then
        r, g, b = q, v, p
    elseif i % 6 == 2 then
        r, g, b = p, v, t
    elseif i % 6 == 3 then
        r, g, b = p, q, v
    elseif i % 6 == 4 then
        r, g, b = t, p, v
    elseif i % 6 == 5 then
        r, g, b = v, p, q
    end

    return Color3.new(r, g, b)
end

local function setNameAndBio()
    local nameArgs = {
        "RolePlayName",
        "► ⸻⸻ C00L |YOU MOTHER | KID ⸻⸻⸻ "
    }
    local bioArgs = {
        "RolePlayBio",
        " ⸻⸻ C00L | ▼ADMIN▼ | KID ⸻⸻⸻ "
    }

    pcall(function()
        TextRemote:FireServer(unpack(nameArgs))
    end)
    pcall(function()
        TextRemote:FireServer(unpack(bioArgs))
    end)
end

local function activateTool()
    local toolArgs = {
        "PickingTools",
        "Assault"
    }
    pcall(function()
        ToolRemote:InvokeServer(unpack(toolArgs))
    end)
end

if not NameColorRemote or not TextRemote or not ToolRemote or not GunRemote or not BodyColorRemote then
    return
end

setNameAndBio()
activateTool()

local hue = 0
local colorIndex = 1
local lastBodyColorChange = tick()
local lastGunEffect = tick()

while true do
    local character = Players.LocalPlayer.Character
    if not character then
        wait(1)
        continue
    end

    if NameColorRemote then
        hue = (hue + Speed / 360) % 1
        local color = HSVToRGB(hue, Saturation, Value)

        local nameArgs = {
            "PickingRPNameColor",
            color
        }
        local bioArgs = {
            "PickingRPBioColor",
            color
        }

        pcall(function()
            NameColorRemote:FireServer(unpack(nameArgs))
        end)
        pcall(function()
            NameColorRemote:FireServer(unpack(bioArgs))
        end)
    end

    if BodyColorRemote and tick() - lastBodyColorChange >= BodyColorDelay then
        local bodyArgs = {
            BodyColors[colorIndex]
        }
        pcall(function()
            BodyColorRemote:FireServer(unpack(bodyArgs))
        end)
        colorIndex = colorIndex + 1
        if colorIndex > #BodyColors then
            colorIndex = 1
        end
        lastBodyColorChange = tick()
    end

    if GunRemote and tick() - lastGunEffect >= GunDelay then
        local cameraPart = workspace:WaitForChild("Camera"):WaitForChild("Part")
        local assaultHandle = character:WaitForChild("Assault"):WaitForChild("Handle")
        local muzzleEffect = character:WaitForChild("Assault"):WaitForChild("GunScript_Local"):WaitForChild("MuzzleEffect")
        local hitEffect = character:WaitForChild("Assault"):WaitForChild("GunScript_Local"):WaitForChild("HitEffect")

        if cameraPart and assaultHandle and muzzleEffect and hitEffect then
            local gunArgs = {
                cameraPart,
                assaultHandle,
                Vector3.new(0.20000000298023224, 0.30000001192092896, -2.5),
                Vector3.new(169.57476806640625, 30.625097274780273, 509.9585876464844),
                muzzleEffect,
                hitEffect,
                103595219378299,
                140181997495870,
                { false },
                {
                    25,
                    Vector3.new(0.25, 0.25, 100),
                    BrickColor.new(24),
                    0.25,
                    Enum.Material.SmoothPlastic,
                    0.25
                },
                true,
                false
            }
            pcall(function()
                GunRemote:FireServer(unpack(gunArgs))
            end)
        end
        lastGunEffect = tick()
    end

    wait(WaitTime)
end