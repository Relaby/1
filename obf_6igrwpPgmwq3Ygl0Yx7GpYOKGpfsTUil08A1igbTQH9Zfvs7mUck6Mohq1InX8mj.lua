local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))();
local Window = Rayfield:CreateWindow({
    Name = "blimp game",
    Icon = 0,
    LoadingTitle = "ts loading",
    LoadingSubtitle = "by relaby",
    ShowText = "Rayfield",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "Big Hub"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
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
});
local VirtualUser = game:GetService("VirtualUser");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local player = Players.LocalPlayer;
local character = player.Character or player.CharacterAdded:Wait();
local HRP = character:WaitForChild("HumanoidRootPart");
local backPallet = character:WaitForChild("BackPallet");
local LocalPlayer = Players.LocalPlayer;
local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent6_BOX");
local bellPrompt = workspace.NewGoldegon.DeliverStation.BellRing:WaitForChild("ProximityPrompt");
local DeliverPrompt = workspace.Ties.Deliver.ProximityPrompt;
local bellCFrame = CFrame.new(-4892.76514, 801.97998, 3876.62891, 0.999832451, -2.0522954e-9, 0.0183035694,
    2.2028324e-9, 1, -8.2042915e-9, -0.0183035694, 8.243237e-9, 0.999832451);
local dropCFrame = Vector3.new(4232.90576171875, 671.3194580078125, -3103.075927734375);
local backpallet = Vector3.new(-2541.093994140625, 1247.199951171875, -4232.5);

local running = false;
local function firePromptTimes(prompt, times)
    for i = 1, times do
        fireproximityprompt(prompt, 1);
        task.wait(prompt.HoldDuration + 0.1);
    end
end
local function getPlayerNames()
    local names = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(names, plr.Name)
        end
    end
    return names
end
local function getNearestPrompt(position)
    local closestPrompt, minDist = nil, math.huge
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and obj.Enabled then
            local parent = obj.Parent
            if parent and parent:IsA("BasePart") then
                local dist = (parent.Position - position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closestPrompt = obj
                end
            end
        end
    end
    return closestPrompt
end
local function fireNearestPrompt()
    local prompt = getNearestPrompt(HRP.Position)
    if prompt then
        print("Firing nearest prompt:", prompt:GetFullName())

        -- If the prompt has a hold duration, simulate holding it
        if prompt.HoldDuration > 0 then
            fireproximityprompt(prompt, 0) -- start hold
            task.wait(prompt.HoldDuration)
            fireproximityprompt(prompt, 1) -- release
        else
            fireproximityprompt(prompt)
        end
    else
        warn("No nearby ProximityPrompt found!")
    end
end

local function getClosestBoxes(n)
    local boxes = {};
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") and (obj.Name == "Box")) then
            local info = obj:FindFirstChild("Info");
            local owner = info and info:FindFirstChild("Owner");
            if (owner and (owner.Text == player.Name)) then
                local prompt = obj:FindFirstChildOfClass("ProximityPrompt");
                if prompt then
                    local dist = (obj.Position - HRP.Position).Magnitude;
                    table.insert(boxes, {
                        part = obj,
                        prompt = prompt,
                        dist = dist
                    });
                end
            end
        end
    end
    table.sort(boxes, function(a, b)
        return a.dist < b.dist;
    end);
    return {unpack(boxes, 1, math.min(n, #boxes))};
end
local function teleportAbove(part)
    HRP.CFrame = CFrame.new(part.Position + Vector3.new(0, 4, 0));
end
local function buyalltools()
    -- Store original position
    local originalCFrame = HRP.CFrame

    -- Teleport sequence
    HRP.CFrame = CFrame.new(-128, 905.7, 33.5)
    fireNearestPrompt()
    HRP.CFrame = CFrame.new(-131.99998, 906.5, 33.4495)
    fireNearestPrompt()
    HRP.CFrame = CFrame.new(-62.0267, 909.216, 49.0485)
    fireNearestPrompt()
    HRP.CFrame = CFrame.new(-131.99998, 906.5, 33.4495)
    fireNearestPrompt()
    HRP.CFrame = CFrame.new(3656.5, 911.4, 2225.746)
    fireNearestPrompt()
    HRP.CFrame = CFrame.new(-2541.094, 1247.2, -4232.5)
    fireNearestPrompt()
    HRP.CFrame = CFrame.new(-2539.568, 1247.0946, -4219.846)
    fireNearestPrompt()
    HRP.CFrame = CFrame.new(-2546.094, 1246.7, -4219.5)
    fireNearestPrompt()
    HRP.CFrame = CFrame.new(4341.5, 672, -3129)
    fireNearestPrompt()
    HRP.CFrame = CFrame.new(-977.5, 767.6, 4651)
    fireNearestPrompt()
    HRP.CFrame = CFrame.new(-974.5, 767.95, 4651.5)
    fireNearestPrompt()

    -- Return to original position
    HRP.CFrame = originalCFrame
end
local homeTab = Window:CreateTab("", "home");
local playerTab = Window:CreateTab("", "user");
local settingsTab = Window:CreateTab("", "settings");

local function getNearestPrompt(position)
    local closestPrompt, minDist = nil, math.huge
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and obj.Enabled then
            local parent = obj.Parent
            if parent and parent:IsA("BasePart") then
                local dist = (parent.Position - position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closestPrompt = obj
                end
            end
        end
    end
    return closestPrompt
end
local function facePosition(position)
    HRP.CFrame = CFrame.new(HRP.Position, position);
end
local function dropBox(boxPart)
    RemoteEvent:FireServer(boxPart, backPallet);
    task.wait(0.2);
end
local function runSequence()
    while running do
        HRP.CFrame = bellCFrame;
        task.wait(0.5);
        firePromptTimes(bellPrompt, 3);
        local closestBoxes = getClosestBoxes(3);
        for i, boxInfo in ipairs(closestBoxes) do
            teleportAbove(boxInfo.part);
            fireproximityprompt(boxInfo.prompt, 1);
            task.wait(boxInfo.prompt.HoldDuration + 0.2);
        end
        HRP.CFrame = CFrame.new(dropCFrame + Vector3.new(0, 4, 0));
        task.wait(0.3);
        local nearestPrompt = getNearestPrompt(dropCFrame);
        if nearestPrompt then
            facePosition(nearestPrompt.Parent.Position);
            task.wait(0.3);
            firePromptTimes(DeliverPrompt, 3);
        end
        print("✅ Sequence completed! Looping again...");
        task.wait(0.1);
    end
end
local function startLoop()
    if not running then
        running = true;
        task.spawn(runSequence);
        print("started");
    end
end
local function stopLoop()
    if running then
        running = false;
        print("stopped");
    end
end
local Toggle = homeTab:CreateToggle({
    Name = "Auto Farm Boxes",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        if Value then
            startLoop();
        else
            stopLoop();
        end
    end
});
local Divider = homeTab:CreateDivider()
local testButton = homeTab:CreateButton({
    Name = "Buy All Gears",
    Callback = function()
        buyalltools();
    end
});
local Divider = homeTab:CreateDivider()
local Dropdown = homeTab:CreateDropdown({
    Name = "Teleports",
    Options = {"Bloomsville", "Farmers Rock", "Greensburg", "Horn Swamp", "Kinkade", "Lavafork Fort", "Lichanton",
               "Luisville", "Mount Tyranny", "Mushroom Mountain", "New Goldegon", "Spruceville", "Vinsburg"},
    CurrentOption = {"Bloomsville"},
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(Options)
        local choice = Options[1]
        local targetCFrame

        if choice == "Luisville" then
            targetCFrame = CFrame.new(-44, 950.25, 9.5367431640625e-07)
        elseif choice == "Farmers Rock" then
            targetCFrame = CFrame.new(-1536, 642, 174)
        elseif choice == "Bloomsville" then
            targetCFrame = CFrame.new(-3494, 1802.000244140625, -1835)
        elseif choice == "Greensburg" then
            targetCFrame = CFrame.new(4236, 666, -3112)
        elseif choice == "Horn Swamp" then
            targetCFrame = CFrame.new(-1201, 862, 4599)
        elseif choice == "Kinkade" then
            targetCFrame = CFrame.new(-2512, 1242.5, -4268)
        elseif choice == "Lavafork Fort" then
            targetCFrame = CFrame.new(1330, 1512, -3242)
        elseif choice == "Lichanton" then
            targetCFrame = CFrame.new(3396, 886.05, 2048)
        elseif choice == "Mount Tyranny" then
            targetCFrame = CFrame.new(268, 3322.25, -5230)
        elseif choice == "Mushroom Mountain" then
            targetCFrame = CFrame.new(3534, 1846, 5054)
        elseif choice == "New Goldegon" then
            targetCFrame = CFrame.new(-4900, 802.5, 3853)
        elseif choice == "Spruceville" then
            targetCFrame = CFrame.new(1642.5, 1402, -932)
        elseif choice == "Vinsburg" then
            targetCFrame = CFrame.new(-490.48, 803.5, -2637.98)
        end

        if targetCFrame then
            -- Add 5 studs above the position
            HRP.CFrame = targetCFrame + Vector3.new(0, 5, 0)
        end
    end

})

-- Teleport Dropdown (kept empty callback, you can remove if not needed)
teleportDropdown = playerTab:CreateDropdown({
    Name = "Select user",
    Options = getPlayerNames(),
    CurrentOption = {},
    MultipleOptions = false,
    Flag = "TeleportPlayerDropdown",
    Callback = function(selected)
        -- nothing here; teleport handled by button
    end
})
Players.PlayerAdded:Connect(function()
    teleportDropdown:Refresh(getPlayerNames())
end)
Players.PlayerRemoving:Connect(function()
    teleportDropdown:Refresh(getPlayerNames())
end)
local TeleportButton = playerTab:CreateButton({
    Name = "Teleport to Player",
    Callback = function()
        local selected = teleportDropdown.CurrentOption[1] -- make sure you use teleportDropdown
        if not selected then
            warn("No player selected!")
            return
        end

        local targetPlayer = Players:FindFirstChild(selected)
        if not targetPlayer or not targetPlayer.Character then
            warn("Selected player is not available or has no character.")
            return
        end

        local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not targetHRP then
            warn("Target player's HumanoidRootPart not found!")
            return
        end

        -- Properly teleport 5 studs above the player
        HRP.CFrame = CFrame.new(targetHRP.Position + Vector3.new(0, 5, 0))

        print("✅ Teleported to " .. targetPlayer.Name)
    end
})

local Divider = playerTab:CreateDivider()
local trackedHighlight = nil
local trackingPlayer = nil
local trackingLoop = nil
local waypointGui = nil

-- Fix playerDropdown reference
-- Replace all playerDropdown with teleportDropdown in tracking/spectate toggles

-- Track Toggle
local TrackToggle = playerTab:CreateToggle({
    Name = "Track Player",
    CurrentValue = false,
    Flag = "TrackPlayerToggle",
    Callback = function(value)
        if value then
            local selected = teleportDropdown.CurrentOption[1]
            if not selected then
                warn("No player selected!")
                TrackToggle:Set(false)
                return
            end

            local targetPlayer = Players:FindFirstChild(selected)
            if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                warn("Selected player is not available or has no character.")
                TrackToggle:Set(false)
                return
            end

            trackingPlayer = targetPlayer

            -- Remove previous highlight/gui
            if trackedHighlight then trackedHighlight:Destroy() end
            if waypointGui then waypointGui:Destroy() end

            -- Create highlight
            trackedHighlight = Instance.new("Highlight")
            trackedHighlight.Adornee = trackingPlayer.Character
            trackedHighlight.FillColor = Color3.fromRGB(255, 0, 0)
            trackedHighlight.FillTransparency = 0.5
            trackedHighlight.OutlineTransparency = 0
            trackedHighlight.Parent = workspace

            -- Create waypoint GUI above player
            waypointGui = Instance.new("BillboardGui")
            waypointGui.Name = "Waypoint"
            waypointGui.Size = UDim2.new(0, 50, 0, 50)
            waypointGui.StudsOffset = Vector3.new(0, 5, 0)
            waypointGui.AlwaysOnTop = true
            waypointGui.Adornee = trackingPlayer.Character:FindFirstChild("HumanoidRootPart")
            waypointGui.Parent = player:WaitForChild("PlayerGui") -- fix parent

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            frame.BackgroundTransparency = 0.5
            frame.BorderSizePixel = 0
            frame.Parent = waypointGui

            -- Update loop
            trackingLoop = task.spawn(function()
                while trackingPlayer and trackedHighlight and waypointGui and TrackToggle.CurrentValue do
                    if trackingPlayer.Character and trackingPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        trackedHighlight.Adornee = trackingPlayer.Character
                        waypointGui.Adornee = trackingPlayer.Character.HumanoidRootPart
                    end
                    task.wait(0.1)
                end
            end)

            -- Update on respawn
            targetPlayer.CharacterAdded:Connect(function(char)
                task.wait(0.1)
                if trackedHighlight then trackedHighlight.Adornee = char end
                if waypointGui then waypointGui.Adornee = char:WaitForChild("HumanoidRootPart") end
            end)

            print("✅ Started tracking " .. trackingPlayer.Name)
        else
            if trackedHighlight then trackedHighlight:Destroy() end
            if waypointGui then waypointGui:Destroy() end
            trackedHighlight = nil
            waypointGui = nil
            trackingPlayer = nil
            if trackingLoop then task.cancel(trackingLoop) end -- properly stop loop
            trackingLoop = nil
            print("❌ Tracking stopped")
        end
    end
})

-- Spectate Toggle
local SpectateToggle = playerTab:CreateToggle({
    Name = "Spectate Player",
    CurrentValue = false,
    Flag = "SpectatePlayerToggle",
    Callback = function(value)
        if value then
            local selected = teleportDropdown.CurrentOption[1] -- fixed
            if not selected then
                warn("No player selected!")
                SpectateToggle:Set(false)
                return
            end

            local targetPlayer = Players:FindFirstChild(selected)
            if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("Humanoid") then
                warn("Selected player is not available or has no character.")
                SpectateToggle:Set(false)
                return
            end

            spectating = true
            workspace.CurrentCamera.CameraSubject = targetPlayer.Character:FindFirstChild("Humanoid")

            targetPlayer.CharacterAdded:Connect(function(char)
                task.wait(0.1)
                if spectating then
                    workspace.CurrentCamera.CameraSubject = char:WaitForChild("Humanoid")
                end
            end)

            print("🎥 Now spectating " .. targetPlayer.Name)
        else
            spectating = false
            workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChild("Humanoid") or player.Character
            print("❌ Stopped spectating")
        end
    end
})





local function enableFPSBooster()
    _G.Ignore = {};
    _G.Settings = {
        Players = {
            ["Ignore Me"] = true,
            ["Ignore Others"] = true,
            ["Ignore Tools"] = true
        },
        Meshes = {
            NoMesh = false,
            NoTexture = false,
            Destroy = false
        },
        Images = {
            Invisible = true,
            Destroy = false
        },
        Explosions = {
            Smaller = true,
            Invisible = false,
            Destroy = false
        },
        Particles = {
            Invisible = true,
            Destroy = false
        },
        TextLabels = {
            LowerQuality = true,
            Invisible = false,
            Destroy = false
        },
        MeshParts = {
            LowerQuality = true,
            Invisible = false,
            NoTexture = false,
            NoMesh = false,
            Destroy = false
        },
        Other = {
            ["FPS Cap"] = 240,
            ["No Camera Effects"] = true,
            ["No Clothes"] = true,
            ["Low Water Graphics"] = true,
            ["No Shadows"] = true,
            ["Low Rendering"] = true,
            ["Low Quality Parts"] = true,
            ["Low Quality Models"] = true,
            ["Reset Materials"] = true
        }
    };
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))();
    print("✅ FPS Booster Enabled!");
end
local function enableAntiAFK()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ZEXT512/AntiAfkXs/refs/heads/main/Anti"))()
end

local AntiAFKButton = settingsTab:CreateButton({
    Name = "Anti-AFK",
    Callback = function()
        enableAntiAFK();
    end
});
local fpsboosterButton = settingsTab:CreateButton({
    Name = "FPS Booster",
    Callback = function()
        enableFPSBooster();
    end
});
local Toggle = settingsTab:CreateToggle({
    Name = "Disable 3d render",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)

        if Value then
            game.RunService:Set3dRenderingEnabled(false);
        else
            game.RunService:Set3dRenderingEnabled(true);
        end
    end
});
local Divider = settingsTab:CreateDivider()
