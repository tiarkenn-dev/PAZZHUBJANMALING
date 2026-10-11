-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB v3.2 — Violence District
--  Theme: Biru Neon · Compact Layout
--  Tabs: Survivor · Visuals · Killer · Misc · Config
--  Auto Parry V2 (Wisnu) + Silent Spear Veil V2 (W424)
-- ═══════════════════════════════════════════════════════════════════

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

-- ═══════════════ SERVICES ═══════════════
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local CoreGui           = game:GetService("CoreGui")
local CollectionService = game:GetService("CollectionService")
local TweenService      = game:GetService("TweenService")
local GuiService        = game:GetService("GuiService")
local HttpService       = game:GetService("HttpService")
local Lighting          = game:GetService("Lighting")
local Stats             = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local VirtualInputManager = nil
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

-- ═══════════════ THEME BIRU NEON ═══════════════
Library.Scheme.AccentColor     = Color3.fromRGB(0, 170, 255)
Library.Scheme.BackgroundColor = Color3.fromRGB(8, 14, 26)
Library.Scheme.MainColor       = Color3.fromRGB(16, 24, 42)
Library.Scheme.OutlineColor    = Color3.fromRGB(0, 120, 200)
Library.Scheme.FontColor       = Color3.fromRGB(200, 230, 255)

local TOGGLE_ICON = 72845574620852
local ACCENT = Color3.fromRGB(0, 170, 255)

-- ═══════════════ STATE GLOBAL ═══════════════
getgenv().PZ = getgenv().PZ or {}
local PZ = getgenv().PZ

-- ═══════════════ FLOATING TOGGLE ═══════════════
local function CreatePazzToggle(IconId)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PazzToggle"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    local MainButton = Instance.new("TextButton")
    MainButton.Name = "ToggleButton"
    MainButton.Text = ""
    MainButton.AutoButtonColor = false
    MainButton.Size = UDim2.fromOffset(42, 42)
    MainButton.Position = UDim2.fromOffset(15, 120)
    MainButton.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
    MainButton.BackgroundTransparency = 0.05
    MainButton.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = MainButton

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = ACCENT
    Stroke.Thickness = 1.5
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Transparency = 0.1
    Stroke.Parent = MainButton

    local Glow = Instance.new("UIStroke")
    Glow.Color = ACCENT
    Glow.Thickness = 4
    Glow.Transparency = 0.6
    Glow.Parent = MainButton

    local IconFrame = Instance.new("Frame")
    IconFrame.Size = UDim2.fromScale(0.78, 0.78)
    IconFrame.Position = UDim2.fromScale(0.11, 0.11)
    IconFrame.BackgroundTransparency = 1
    IconFrame.Parent = MainButton

    local Image = Instance.new("ImageLabel")
    Image.BackgroundTransparency = 1
    Image.Image = "rbxassetid://" .. IconId
    Image.Size = UDim2.fromScale(1, 1)
    Image.Parent = IconFrame

    MainButton.MouseEnter:Connect(function()
        TweenService:Create(MainButton, TweenInfo.new(.15), {
            BackgroundColor3 = Color3.fromRGB(16, 24, 42)
        }):Play()
        TweenService:Create(Glow, TweenInfo.new(.15), { Transparency = 0.3 }):Play()
    end)

    MainButton.MouseLeave:Connect(function()
        TweenService:Create(MainButton, TweenInfo.new(.15), {
            BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        }):Play()
        TweenService:Create(Glow, TweenInfo.new(.15), { Transparency = 0.6 }):Play()
    end)

    MainButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainButton, TweenInfo.new(.08), {
            Size = UDim2.fromOffset(36, 36)
        }):Play()
        task.wait(.08)
        TweenService:Create(MainButton, TweenInfo.new(.08), {
            Size = UDim2.fromOffset(42, 42)
        }):Play()
        Library:Toggle()
    end)

    Library:MakeDraggable(MainButton, MainButton, true)
end

CreatePazzToggle(TOGGLE_ICON)

-- ═══════════════ WINDOW ═══════════════
local Window = Library:CreateWindow({
    Title = "PAZZHUB",
    Footer = "PazzHub",
    Icon = TOGGLE_ICON,
    IconSize = UDim2.fromOffset(34, 34),
    CornerRadius = 14,
    NotifySide = "Right",
    ShowCustomCursor = true,
    ShowMobileButtons = false,
    ToggleKeybind = Enum.KeyCode.LeftControl,
    Size = UDim2.fromOffset(420, 260),
    EnableSidebarResize = false,
    EnableCompacting = true,
    SidebarCompacted = true,
})

-- ═══════════════ WATERMARK ═══════════════
local Watermark = Library:AddDraggableLabel("PAZZHUB")

local FPS, Frames, LastTick = 0, 0, tick()
RunService.RenderStepped:Connect(function()
    Frames += 1
    if tick() - LastTick >= 1 then
        FPS = Frames; Frames = 0; LastTick = tick()
        local Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        Watermark:SetText(string.format("PAZZHUB | FPS: %d | PING: %d ms", FPS, Ping))
    end
end)

-- ═══════════════ TABS ═══════════════
local Tabs = {
    Survivor = Window:AddTab("Survivor", "user"),
    Visuals  = Window:AddTab("Visuals", "eye"),
    Killer   = Window:AddTab("Killer", "swords"),
    Misc     = Window:AddTab("Misc", "wrench"),
    Config   = Window:AddTab("Config", "settings"),
}

-- ═══════════════ NOTIFY HELPER ═══════════════
local function Notify(title, content, duration)
    Library:Notify({
        Title = title or "PAZZHUB",
        Content = content or "",
        Duration = duration or 3,
    })
end-- ═══════════════ TEAM HELPER ═══════════════
local function TeamIs(plr, role)
    if not plr or not plr.Team or not plr.Team.Name then return false end
    local tn = string.lower(plr.Team.Name)
    if role == "Killer" then return string.find(tn, "killer", 1, true) ~= nil end
    if role == "Survivor" then return string.find(tn, "survivor", 1, true) ~= nil end
    return false
end
PZ.TeamIs = TeamIs

local function GetRole()
    if TeamIs(LocalPlayer, "Killer") then return "Killer" end
    if TeamIs(LocalPlayer, "Survivor") then return "Survivor" end
    return nil
end
PZ.GetRole = GetRole

-- ═══════════════ CROUCH TRIGGER ═══════════════
local function IsDowned(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local state = char:GetAttribute("State")
    return state == "Downed" or state == "Dead"
end

local function TriggerCrouch()
    local startT = tick()
    task.spawn(function()
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        pcall(function() char:SetAttribute("Crouching", true) end)
        pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
        pcall(function() ReplicatedStorage.Remotes.Chase.Runevent:FireServer(char, false) end)
        if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end) end
        pcall(function()
            local survMob = LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
            if survMob then
                local controls = survMob:FindFirstChild("Controls")
                if controls then
                    local crouchBtn = controls:FindFirstChild("crouch")
                    if crouchBtn then firesignal(crouchBtn.MouseButton1Click) end
                end
            end
        end)
        while tick() - startT < 1.2 do
            pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
            task.wait(0.1)
        end
        pcall(function() char:SetAttribute("Crouching", false) end)
        pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", false) end)
        if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end) end
        pcall(function()
            local survMob = LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
            if survMob then
                local controls = survMob:FindFirstChild("Controls")
                if controls then
                    local crouchBtn = controls:FindFirstChild("crouch")
                    if crouchBtn then firesignal(crouchBtn.MouseButton1Click) end
                end
            end
        end)
    end)
end

-- ═══════════════ DAGGER CHECK ═══════════════
local DaggerCache = { Value = false, LastCheck = 0, Interval = 0.15 }
local function ParryIsDaggerModel(inst)
    if not inst then return false end
    return inst:IsA("Model") or inst:IsA("Tool") or inst:IsA("Accessory")
end
local function ParryIsEquippedDagger()
    local now = os.clock()
    if now - DaggerCache.LastCheck < DaggerCache.Interval then return DaggerCache.Value end
    DaggerCache.LastCheck = now
    local hasDagger = false
    local char = LocalPlayer.Character
    if char then
        local d = char:FindFirstChild("Parrying Dagger")
        if ParryIsDaggerModel(d) then hasDagger = true end
    end
    if not hasDagger then
        local wsChar = Workspace:FindFirstChild(LocalPlayer.Name)
        if wsChar then
            local d = wsChar:FindFirstChild("Parrying Dagger")
            if ParryIsDaggerModel(d) then hasDagger = true end
        end
    end
    DaggerCache.Value = hasDagger
    return hasDagger
end
LocalPlayer.CharacterAdded:Connect(function() DaggerCache.Value = false; DaggerCache.LastCheck = 0 end)

-- ═══════════════ BUSY CHECK ═══════════════
local ParryCheckAttrs = {"isVaulting","isSliding","isDroppingPallet","isRepairing","isHealing","isUnhooking","isExiting"}
local function ParryIsBusy()
    local char = LocalPlayer.Character
    if not char then return true end
    if LocalPlayer:GetAttribute("IsDead") then return true end
    if char:GetAttribute("IsCarried") then return true end
    if char:GetAttribute("IsHooked") then return true end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root and CollectionService:HasTag(root, "doing action") then return true end
    local ci = char:FindFirstChild("CheckInterractable")
    if ci then
        for i = 1, #ParryCheckAttrs do
            if ci:GetAttribute(ParryCheckAttrs[i]) then return true end
        end
    end
    return false
    end-- ═══════════════════════════════════════════════════════════════════
--  AUTO PARRY V2 (Wisnu) — Full System
-- ═══════════════════════════════════════════════════════════════════
do
    PZ.Wisnu_AutoParry       = false
    PZ.Wisnu_ParryAggressive = false
    PZ.Wisnu_ParrySafety     = false
    PZ.Wisnu_ParryDistance   = 6
    PZ.Wisnu_ParryFace       = 0.7
    PZ.Wisnu_ParryCircle     = true
    PZ.Wisnu_IgnoredSkills   = {}

    local W_VALID_PARRY_IDS = {
        ["122812055447896"] = "Veil lunge",
        ["133963973694098"] = "Mayers Basic",
        ["117042998468241"] = "Mayers lunge",
        ["135002183282873"] = "cure lunge",
        ["121216847022485"] = "cure Basic",
        ["132817836308238"] = "Jeff Basic",
        ["129784271201071"] = "Jeff lunge",
        ["82666958311998"]  = "Jeff Frenzy",
        ["78432063483146"]  = "Abyssal Basic",
        ["118907603246885"] = "Abyssal lunge",
        ["139369275981139"] = "Jason Basic",
        ["110355011987939"] = "Jason lunge",
        ["111920872708571"] = "Masked Basic",
        ["105374834496520"] = "Masked lunge",
        ["138720291317243"] = "Masked Tony",
        ["106871536134254"] = "Masked Alex",
        ["130593238885843"] = "Masked Cobra",
        ["115244153053858"] = "Masked Cobra lunge",
        ["74968262036854"]  = "Hidden Basic",
        ["113255068724446"] = "Hidden lunge",
        ["98163597193511"]  = "Hidden S1",
        ["80411309607666"]  = "Abyssal S1"
    }

    local W_State = { Cooldown = false, CooldownThread = nil, lastParry = 0, Adornment = nil }
    local W_Attached = {}

    local function W_IsKiller(p) return p and p.Team and p.Team.Name == "Killer" end
    local function W_IsDowned(char)
        return char and (char:GetAttribute("Knocked") == true or char:GetAttribute("IsHooked") == true)
    end

    local function W_IsSafeToParry(char)
        if not PZ.Wisnu_ParrySafety then return true end
        if not char then return false end
        local interactObj = char:FindFirstChild("CheckInterractable")
        if interactObj then
            if interactObj:GetAttribute("isVaulting") == true then return false end
            if interactObj:GetAttribute("isRepairing") == true then return false end
            if interactObj:GetAttribute("isUnhooking") == true then return false end
            if interactObj:GetAttribute("isHealing") == true then return false end
            if interactObj:GetAttribute("isSliding") == true then return false end
        end
        return true
    end

    local function W_PressRightClick()
        if not VirtualInputManager then return end
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
            task.wait()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
        end)
    end

    local function W_TapMobileParryButton()
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if not playerGui then return end
        local survivorMob = playerGui:FindFirstChild("Survivor-mob")
        local parryBtn = survivorMob and survivorMob:FindFirstChild("Controls") and survivorMob.Controls:FindFirstChild("Gui-mob")
        if parryBtn and parryBtn.Visible then
            if firesignal then
                pcall(function()
                    firesignal(parryBtn.MouseButton1Down)
                    task.wait(0.01)
                    firesignal(parryBtn.MouseButton1Up)
                end)
            end
        else
            W_PressRightClick()
        end
    end

    local function W_ExecuteParry()
        if W_State.Cooldown then return end
        W_State.lastParry = tick()
        pcall(function()
            local parryRemote = ReplicatedStorage:FindFirstChild("Remotes")
                :FindFirstChild("Items")
                :FindFirstChild("Parrying Dagger")
                :FindFirstChild("parry")
            if parryRemote then
                for i = 1, 10 do parryRemote:FireServer() end
            end
            task.spawn(W_TapMobileParryButton)
        end)
    end

    -- Cooldown listener
    task.spawn(function()
        local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
        local dagger = remotes and remotes:WaitForChild("Items", 5):WaitForChild("Parrying Dagger", 5)
        local parryResultRemote = dagger and dagger:WaitForChild("parryResult", 5)
        if parryResultRemote then
            parryResultRemote.OnClientEvent:Connect(function(arg1, arg2)
                local cdDur = tonumber(arg2) or ((arg1 == true) and 90 or 60)
                W_State.Cooldown = true
                if W_State.CooldownThread then task.cancel(W_State.CooldownThread) end
                W_State.CooldownThread = task.delay(cdDur, function()
                    W_State.Cooldown = false
                end)
            end)
        end
    end)

    -- Sensor attach
    local function W_AttachParrySensor(kChar)
        if not kChar or W_Attached[kChar] then return end
        W_Attached[kChar] = true
        local humanoid = kChar:FindFirstChild("Humanoid")
        if not humanoid then humanoid = kChar:WaitForChild("Humanoid", 5); if not humanoid then return end end
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then animator = humanoid:WaitForChild("Animator", 5); if not animator then return end end

        humanoid.ChildAdded:Connect(function(child)
            if child:IsA("Animator") then W_Attached[kChar] = nil; W_AttachParrySensor(kChar) end
        end)
        kChar.AncestryChanged:Connect(function(_, parent)
            if not parent then W_Attached[kChar] = nil end
        end)

        animator.AnimationPlayed:Connect(function(track)
            local animId = track.Animation and track.Animation.AnimationId or ""
            local id = animId:match("%d+")
            local attackName = W_VALID_PARRY_IDS[id]
            if not attackName then return end

            if id == "80411309607666" and PZ.AutoCrouch then
                local myChar = LocalPlayer.Character
                if W_IsDowned(myChar) then return end
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local kHRP = kChar:FindFirstChild("HumanoidRootPart")
                if myHRP and kHRP then
                    if (myHRP.Position - kHRP.Position).Magnitude <= 40 then TriggerCrouch() end
                end
                return
            end

            if not PZ.Wisnu_AutoParry then return end
            if W_State.Cooldown then return end
            if PZ.Wisnu_IgnoredSkills and PZ.Wisnu_IgnoredSkills[attackName] then return end

            local myChar = LocalPlayer.Character
            if W_IsDowned(myChar) or not W_IsSafeToParry(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if not myHRP or not kHRP then return end

            local startDistance = (myHRP.Position - kHRP.Position).Magnitude

            if PZ.Wisnu_ParryAggressive then
                local aggressiveRadius = 12
                local detectionRadius = PZ.Wisnu_ParryDistance + 5
                if startDistance > detectionRadius then return end
                if startDistance <= aggressiveRadius then
                    W_ExecuteParry()
                else
                    local tracker
                    local startTime = os.clock()
                    tracker = RunService.Heartbeat:Connect(function()
                        if os.clock() - startTime >= 1.5 or W_State.Cooldown or not myHRP or not kHRP or W_IsDowned(myChar) then
                            if tracker then tracker:Disconnect() end
                            return
                        end
                        if (myHRP.Position - kHRP.Position).Magnitude <= aggressiveRadius then
                            W_ExecuteParry()
                            if tracker then tracker:Disconnect() end
                        end
                    end)
                end
            else
                if startDistance > PZ.Wisnu_ParryDistance then return end
                local myPosFlat = Vector3.new(myHRP.Position.X, 0, myHRP.Position.Z)
                local kPosFlat = Vector3.new(kHRP.Position.X, 0, kHRP.Position.Z)
                local flatDelta = myPosFlat - kPosFlat
                if flatDelta.Magnitude > 0 then
                    local flatDirection = flatDelta.Unit
                    local kLookFlat = Vector3.new(kHRP.CFrame.LookVector.X, 0, kHRP.CFrame.LookVector.Z).Unit
                    if kLookFlat:Dot(flatDirection) < PZ.Wisnu_ParryFace then return end
                end
                W_ExecuteParry()
            end
        end)
    end

    local function W_TryAttach(p)
        if p ~= LocalPlayer and W_IsKiller(p) and p.Character then W_AttachParrySensor(p.Character) end
    end

    local function W_SetupPlayer(p)
        if p == LocalPlayer then return end
        p.CharacterAdded:Connect(function() W_TryAttach(p) end)
        p:GetPropertyChangedSignal("Team"):Connect(function() W_TryAttach(p) end)
        if p.Character then W_TryAttach(p) end
    end

    for _, p in pairs(Players:GetPlayers()) do W_SetupPlayer(p) end
    Players.PlayerAdded:Connect(W_SetupPlayer)
    task.spawn(function()
        while true do
            task.wait(5)
            for _, p in pairs(Players:GetPlayers()) do W_TryAttach(p) end
        end
    end)

    -- Range circle
    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if PZ.Wisnu_ParryCircle and PZ.Wisnu_AutoParry and hrp then
            if not W_State.Adornment or W_State.Adornment.Parent ~= hrp then
                if W_State.Adornment then W_State.Adornment:Destroy() end
                W_State.Adornment = Instance.new("CylinderHandleAdornment")
                W_State.Adornment.Name = "WisnuAutoParryCircleESP"
                W_State.Adornment.Height = 0.05
                W_State.Adornment.Transparency = 0.3
                W_State.Adornment.Adornee = hrp
                W_State.Adornment.Parent = hrp
                W_State.Adornment.ZIndex = 0
                W_State.Adornment.AlwaysOnTop = false
            end
            local cR = PZ.Wisnu_ParryDistance
            W_State.Adornment.Radius = cR
            W_State.Adornment.InnerRadius = math.max(0.1, cR - 0.15)
            W_State.Adornment.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(90), 0, 0)
            W_State.Adornment.Color3 = W_State.Cooldown and Color3.fromRGB(128,128,128) or Color3.fromRGB(255,255,255)
        elseif W_State.Adornment then
            W_State.Adornment:Destroy()
            W_State.Adornment = nil
        end
    end)
        end-- ═══════════════════════════════════════════════════════════════════
--  SILENT SPEAR VEIL V2 (W424 Original) — Full System
-- ═══════════════════════════════════════════════════════════════════
do
    local Config = {}
    local Camera = Workspace.CurrentCamera

    local AimConfig = AimConfig or {}
    AimConfig.Aim_SilentVeil = false
    AimConfig.Aim_SilentVeilV2 = false
    AimConfig.Veil_ShowFOV = true
    AimConfig.SpearSmart_enable = false
    AimConfig.Veil_FOV = 150
    AimConfig.SPEAR_Speed = 165
    AimConfig.SPEAR_Gravity = workspace.Gravity * 0.5
    AimConfig.SPEAR_MaxDist = 200
    AimConfig.Veil_LeadMultiplier = 1.4
    AimConfig.AIM_Auto = false
    AimConfig.AIM_TargetPart = "Torso"

    local isChargingSpear = false
    local isAttackCooldown = false
    local isFiringSpear = false
    local currentTouchInput = nil

    local function IsVeilSilentOn()
        return AimConfig.Aim_SilentVeil or AimConfig.Aim_SilentVeilV2
    end

    local function getTargetPartObject(char)
        if AimConfig.AIM_TargetPart == "Head" then 
            return char:FindFirstChild("Head")
        elseif AimConfig.AIM_TargetPart == "Root" or AimConfig.AIM_TargetPart == "HumanoidRootPart" then 
            return char:FindFirstChild("HumanoidRootPart")
        else 
            return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart") 
        end
    end

    local function getClosestSurvivor()
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local closestFovDist = AimConfig.Veil_FOV
        local closestTarget = nil
        local cam = workspace.CurrentCamera
        local centerScreen = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Team and p.Team.Name == "Survivors" and p.Character then
                local char = p.Character
                local hum = char:FindFirstChildOfClass("Humanoid")
                local targetPart = getTargetPartObject(char)
                if hum and hum.Health > 0 and targetPart then
                    local dist3D = (targetPart.Position - myRoot.Position).Magnitude
                    if dist3D <= AimConfig.SPEAR_MaxDist then
                        local screenPos, onScreen = cam:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local targetPos2D = Vector2.new(screenPos.X, screenPos.Y)
                            local dist2D = (targetPos2D - centerScreen).Magnitude
                            if dist2D <= closestFovDist then
                                closestFovDist = dist2D
                                closestTarget = targetPart
                            end
                        end
                    end
                end
            end
        end
        return closestTarget
    end

    local veilTargetHighlight = Instance.new("Highlight")
    veilTargetHighlight.Name = "VD_VeilTarget"
    veilTargetHighlight.FillColor = Color3.fromRGB(150, 150, 150)
    veilTargetHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    veilTargetHighlight.FillTransparency = 0.5
    veilTargetHighlight.OutlineTransparency = 0

    local VeilTrackerEnabled = false
    local VeilTrackerLine = nil
    local currentVeilBillboard = nil

    local function setupVeilTrackerGui()
        if CoreGui:FindFirstChild("VeilTrackerGui") then return end
        local sg = Instance.new("ScreenGui")
        sg.Name = "VeilTrackerGui"
        sg.IgnoreGuiInset = true
        sg.ResetOnSpawn = false
        sg.Parent = CoreGui

        VeilTrackerLine = Instance.new("Frame")
        VeilTrackerLine.Name = "Line"
        VeilTrackerLine.AnchorPoint = Vector2.new(0.5, 0.5)
        VeilTrackerLine.BackgroundColor3 = Color3.fromRGB(138, 138, 138)
        VeilTrackerLine.BackgroundTransparency = 0.2
        VeilTrackerLine.BorderSizePixel = 0
        VeilTrackerLine.Visible = false
        VeilTrackerLine.Parent = sg

        currentVeilBillboard = nil
    end
    setupVeilTrackerGui()

    local VeilFOVFrame = nil
    if not CoreGui:FindFirstChild("FOVCircleGui_Standalone") then
        local FOVGui = Instance.new("ScreenGui")
        FOVGui.Name = "FOVCircleGui_Standalone"
        FOVGui.Parent = CoreGui
        FOVGui.ResetOnSpawn = false
        FOVGui.IgnoreGuiInset = true

        VeilFOVFrame = Instance.new("Frame")
        VeilFOVFrame.BackgroundTransparency = 1
        VeilFOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        VeilFOVFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        VeilFOVFrame.Visible = false
        VeilFOVFrame.Parent = FOVGui
        Instance.new("UICorner", VeilFOVFrame).CornerRadius = UDim.new(1, 0)
        local VeilFOVStroke = Instance.new("UIStroke", VeilFOVFrame)
        VeilFOVStroke.Color = Color3.fromRGB(222, 222, 222)
        VeilFOVStroke.Thickness = 1.5
    end

    local SpearInterceptorHooked = false
    local function setupSpearInterceptor()
        if SpearInterceptorHooked then return end
        if not getrawmetatable or not setreadonly then
            warn("[SpearInterceptor]: Executor tidak support.")
            return
        end

        local Spearthrow = nil
        pcall(function()
            Spearthrow = ReplicatedStorage.Remotes.Killers.Veil.Spearthrow
        end)

        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldNamecall = mt.__namecall

        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" and not checkcaller() and typeof(self) == "Instance" and self.ClassName == "RemoteEvent" and self.Name == "Spearthrow" then
                if AimConfig.Aim_SilentVeil and not AimConfig.Aim_SilentVeilV2 then
                    return nil
                end
                if AimConfig.Aim_SilentVeilV2 and not isFiringSpear then
                    local lookVec, speed, originPos = ...
                    speed = speed or AimConfig.SPEAR_Speed or 165
                    local myChar = LocalPlayer.Character
                    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local startPart = myChar and (myChar:FindFirstChild("Head") or myHRP)
                    local isSpecial = myChar and myChar:GetAttribute("special") == true
                    if Config.SpearSmart_enable then
                        speed = isSpecial and 165 or 142.5
                    else
                        speed = AimConfig.SPEAR_Speed or 165
                    end
                    originPos = originPos or (Config.SpearSmart_enable and myHRP and myHRP.Position) or (startPart and startPart.Position)

                    local bestDir = lookVec
                    local targetPart = getClosestSurvivor()
                    if targetPart and originPos then
                        local targetHRP = targetPart:IsA("Model") and targetPart:FindFirstChild("HumanoidRootPart") or targetPart
                        local targetPos = targetHRP.Position
                        local targetVel = Vector3.new(0,0,0)
                        local targetHum = targetPart.Parent and targetPart.Parent:FindFirstChildOfClass("Humanoid")
                        if targetHum and targetHum.MoveDirection.Magnitude > 0 then
                            targetVel = targetHum.MoveDirection * targetHum.WalkSpeed
                        elseif targetHRP:IsA("BasePart") then
                            targetVel = targetHRP.AssemblyLinearVelocity
                        end
                        targetVel = Vector3.new(targetVel.X, 0, targetVel.Z)
                        local distance = (targetPos - originPos).Magnitude
                        local timeToHit = distance / math.max(speed, 1)
                        if Config.SpearSmart_enable then
                            local leadMultiplier = AimConfig.Veil_LeadMultiplier or 1.4
                            local predictedPos = targetPos + (targetVel * (timeToHit * leadMultiplier))
                            local spearGravity = workspace.Gravity * 0.5
                            local drop = 0.5 * spearGravity * (timeToHit * timeToHit)
                            local finalAimPos = predictedPos + Vector3.new(0, drop - 1.5, 0)
                            bestDir = (finalAimPos - originPos).Unit
                        else
                            local dynamicPrediction = math.clamp(distance / 50, 0.1, 4.0)
                            local predictedPos = targetPos + (targetVel * (timeToHit * dynamicPrediction))
                            local distanceMultiplier = math.clamp(distance / 100, 1, 2.5)
                            local autoGravity = math.max(0, distance - 8)
                            local gravity = AimConfig.AIM_Auto and autoGravity or (AimConfig.SPEAR_Gravity or workspace.Gravity * 0.5)
                            local drop = 0.5 * gravity * (timeToHit * timeToHit) * distanceMultiplier
                            local finalAimPos = predictedPos + Vector3.new(0, drop, 0)
                            bestDir = (finalAimPos - originPos).Unit
                        end
                    end
                    isFiringSpear = true
                    pcall(function()
                        if Spearthrow then Spearthrow:FireServer(bestDir, speed, originPos)
                        else self:FireServer(bestDir, speed, originPos) end
                    end)
                    isFiringSpear = false
                    return
                end
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
        SpearInterceptorHooked = true
    end
    setupSpearInterceptor()

    -- Input handlers
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        local isTouch = (input.UserInputType == Enum.UserInputType.Touch)
        if gameProcessed and not isTouch then return end
        local char = LocalPlayer.Character
        local isSpearMode = char and char:GetAttribute("spearmode") == true
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if IsVeilSilentOn() and isSpearMode then
                isChargingSpear = true
            end
        end
        if isTouch then
            if IsVeilSilentOn() and isSpearMode then
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    local slasherMob = playerGui:FindFirstChild("Slasher-mob")
                    if slasherMob then
                        local controls = slasherMob:FindFirstChild("Controls")
                        if controls then
                            local attackBtn = controls:FindFirstChild("attack")
                            if attackBtn and attackBtn.Visible then
                                local pos = input.Position
                                local absPos = attackBtn.AbsolutePosition
                                local absSize = attackBtn.AbsoluteSize
                                if pos.X >= absPos.X and pos.X <= (absPos.X + absSize.X) and pos.Y >= absPos.Y and pos.Y <= (absPos.Y + absSize.Y) then
                                    isChargingSpear = true
                                    currentTouchInput = input
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if isChargingSpear and (input == currentTouchInput or input.UserInputType == Enum.UserInputType.MouseButton1) then
            isChargingSpear = false
            if isAttackCooldown then return end
            isAttackCooldown = true
            task.delay(2, function() isAttackCooldown = false end)

            local myChar = LocalPlayer.Character
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local startPart = myChar and (myChar:FindFirstChild("Head") or myHRP)
            if startPart and myHRP then
                local isSpecial = myChar:GetAttribute("special") == true
                local startPos = Config.SpearSmart_enable and myHRP.Position or startPart.Position
                local currentSpearSpeed = Config.SpearSmart_enable and (isSpecial and 165 or 142.5) or AimConfig.SPEAR_Speed
                local targetPart = getClosestSurvivor()
                local aimDirection
                if targetPart then
                    local targetHRP = targetPart:IsA("Model") and targetPart:FindFirstChild("HumanoidRootPart") or targetPart
                    local targetPos = targetHRP.Position
                    local targetVel = Vector3.new(0,0,0)
                    local targetHum = targetPart.Parent and targetPart.Parent:FindFirstChildOfClass("Humanoid")
                    if targetHum and targetHum.MoveDirection.Magnitude > 0 then
                        targetVel = targetHum.MoveDirection * targetHum.WalkSpeed
                    elseif targetHRP:IsA("BasePart") then
                        targetVel = targetHRP.AssemblyLinearVelocity
                    end
                    targetVel = Vector3.new(targetVel.X, 0, targetVel.Z)
                    local distance = (targetPos - startPos).Magnitude
                    local timeToHit = distance / currentSpearSpeed
                    if Config.SpearSmart_enable then
                        local leadMultiplier = AimConfig.Veil_LeadMultiplier or 1.4
                        local predictedPos = targetPos + (targetVel * (timeToHit * leadMultiplier))
                        local spearGravity = workspace.Gravity * 0.5
                        local dropCompensation = 0.5 * spearGravity * (timeToHit ^ 2)
                        local finalAimPos = predictedPos + Vector3.new(0, dropCompensation - 1.5, 0)
                        aimDirection = (finalAimPos - startPos).Unit
                    else
                        local dynamicPrediction = math.clamp(distance / 50, 0.1, 4.0)
                        local predictedPos = targetPos + (targetVel * (timeToHit * dynamicPrediction))
                        local distanceMultiplier = math.clamp(distance / 100, 1, 2.5)
                        local autoGravity = math.max(0, distance - 8)
                        local gravity = AimConfig.AIM_Auto and autoGravity or AimConfig.SPEAR_Gravity
                        local dropCompensation = 0.5 * gravity * (timeToHit ^ 2) * distanceMultiplier
                        local finalAimPos = predictedPos + Vector3.new(0, dropCompensation, 0)
                        aimDirection = (finalAimPos - startPos).Unit
                    end
                else
                    aimDirection = Camera.CFrame.LookVector
                end
                if AimConfig.Aim_SilentVeil then
                    pcall(function()
                        ReplicatedStorage.Remotes.Killers.Veil.Spearthrow:FireServer(aimDirection, currentSpearSpeed, startPos)
                    end)
                end
            end
        end
    end)

    -- RenderStepped visual
    RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        local isSpearMode = char and char:GetAttribute("spearmode") == true
        local cam = workspace.CurrentCamera

        if VeilFOVFrame then
            if IsVeilSilentOn() and AimConfig.Veil_ShowFOV and isSpearMode then
                VeilFOVFrame.Visible = true
                VeilFOVFrame.Size = UDim2.new(0, AimConfig.Veil_FOV * 2, 0, AimConfig.Veil_FOV * 2)
            else
                VeilFOVFrame.Visible = false
            end
        end

        if IsVeilSilentOn() and isSpearMode and cam then
            local targetPart = getClosestSurvivor()
            if targetPart and targetPart.Parent then
                veilTargetHighlight.Parent = targetPart.Parent

                if VeilTrackerEnabled then
                    if not currentVeilBillboard or currentVeilBillboard.Parent ~= targetPart then
                        if currentVeilBillboard then currentVeilBillboard:Destroy() end
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "VeilTrackerBillboard"
                        bb.Size = UDim2.fromOffset(14, 14)
                        bb.AlwaysOnTop = true
                        bb.LightInfluence = 0
                        bb.MaxDistance = 500
                        local ring = Instance.new("Frame")
                        ring.AnchorPoint = Vector2.new(0.5, 0.5)
                        ring.Position = UDim2.fromScale(0.5, 0.5)
                        ring.Size = UDim2.fromScale(1, 1)
                        ring.BackgroundTransparency = 1
                        ring.Parent = bb
                        Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)
                        local stroke = Instance.new("UIStroke")
                        stroke.Color = Color3.fromRGB(255, 255, 255)
                        stroke.Thickness = 1
                        stroke.Transparency = 0.1
                        stroke.Parent = ring
                        bb.Adornee = targetPart
                        bb.Parent = targetPart
                        currentVeilBillboard = bb
                    end

                    local sp, onScreen = cam:WorldToViewportPoint(targetPart.Position)
                    if onScreen and sp.Z > 0 and VeilTrackerLine then
                        local vp = cam.ViewportSize
                        local fromX = vp.X * 0.5
                        local fromY = vp.Y
                        local toX, toY = sp.X, sp.Y
                        local dx, dy = toX - fromX, toY - fromY
                        local length = math.sqrt(dx * dx + dy * dy)
                        VeilTrackerLine.Size = UDim2.fromOffset(math.max(length, 1), 1)
                        VeilTrackerLine.Position = UDim2.fromOffset((fromX + toX) * 0.5, (fromY + toY) * 0.5)
                        VeilTrackerLine.Rotation = math.deg(math.atan2(dy, dx))
                        VeilTrackerLine.Visible = true
                    else
                        if VeilTrackerLine then VeilTrackerLine.Visible = false end
                    end
                else
                    if currentVeilBillboard then
                        currentVeilBillboard:Destroy()
                        currentVeilBillboard = nil
                    end
                    if VeilTrackerLine then VeilTrackerLine.Visible = false end
                end
            else
                veilTargetHighlight.Parent = nil
                if currentVeilBillboard then
                    currentVeilBillboard:Destroy()
                    currentVeilBillboard = nil
                end
                if VeilTrackerLine then VeilTrackerLine.Visible = false end
            end
        else
            veilTargetHighlight.Parent = nil
            if currentVeilBillboard then
                currentVeilBillboard:Destroy()
                currentVeilBillboard = nil
            end
            if VeilTrackerLine then VeilTrackerLine.Visible = false end
        end
    end)

    -- API
    PZ.W424Veil_API = {
        AimConfig = AimConfig,
        Config = Config,
        getClosestSurvivor = getClosestSurvivor,
        IsVeilSilentOn = IsVeilSilentOn,
        setTracker = function(v) VeilTrackerEnabled = v end,
    }
            end-- ═══════════════════════════════════════════════════════════════════
--  ESP SYSTEM
-- ═══════════════════════════════════════════════════════════════════
do
    local ESPObjects = {}
    local StatusESP  = {}
    local CachedSCP     = {}
    local CachedGen     = {}
    local CachedPallet  = {}
    local CachedWindow  = {}
    local WindowObjects = {}

    local function CacheObject(obj)
        if not obj then return end
        local ln = string.lower(obj.Name)
        if string.find(ln, "scp", 1, true) then CachedSCP[obj] = true end
        if obj.Name == "Generator" then
            CachedGen[obj] = true
        elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then
            CachedPallet[obj] = true
        end
    end

    for _, obj in ipairs(Workspace:GetDescendants()) do CacheObject(obj) end
    Workspace.DescendantAdded:Connect(CacheObject)
    Workspace.DescendantRemoving:Connect(function(obj)
        CachedSCP[obj] = nil; CachedGen[obj] = nil
        CachedPallet[obj] = nil; CachedWindow[obj] = nil
        if ESPObjects[obj] then pcall(function() ESPObjects[obj]:Destroy() end); ESPObjects[obj] = nil end
        if StatusESP[obj] then pcall(function() StatusESP[obj]:Destroy() end); StatusESP[obj] = nil end
    end)

    local function RemoveESP(obj)
        if not obj then return end
        if ESPObjects[obj] then
            pcall(function() ESPObjects[obj]:Destroy() end)
            ESPObjects[obj] = nil
        end
    end

    local function CreateESP(obj, color)
        if not obj or not obj.Parent then return end
        if ESPObjects[obj] then
            ESPObjects[obj].FillColor = color
            ESPObjects[obj].OutlineColor = color
            return
        end
        local h = Instance.new("Highlight")
        h.FillColor = color
        h.OutlineColor = color
        h.FillTransparency = 0.9
        h.OutlineTransparency = 0.3
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = obj
        ESPObjects[obj] = h
        obj.AncestryChanged:Connect(function(_, parent)
            if not parent then RemoveESP(obj) end
        end)
    end

    -- Simple Status ESP (name + distance)
    local function RemoveStatusESP(char)
        if StatusESP[char] then
            pcall(function() StatusESP[char]:Destroy() end)
            StatusESP[char] = nil
        end
    end

    local function CreateStatusESP(plr, char, root)
        if not FESPS.Enabled then RemoveStatusESP(char); return end
        local head = char:FindFirstChild("Head")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not head or not hum then return end
        local dist = (head.Position - root.Position).Magnitude
        if dist > FESPS.Radius then RemoveStatusESP(char); return end

        local accentColor = Color3.fromRGB(255, 255, 255)
        if TeamIs(plr, "Killer") then accentColor = FESPC.Killer
        elseif TeamIs(plr, "Survivor") then accentColor = FESPC.Survivor end

        local bb = StatusESP[char]
        if not bb or not bb.Parent then
            bb = Instance.new("BillboardGui")
            bb.Name = "PazzStatusESP"
            bb.AlwaysOnTop = true
            bb.LightInfluence = 0
            bb.Adornee = head
            bb.StudsOffset = Vector3.new(0, 2.5, 0)
            bb.Size = UDim2.fromOffset(180, 30)
            bb.Parent = char
            local nameLbl = Instance.new("TextLabel")
            nameLbl.Name = "NameLbl"
            nameLbl.BackgroundTransparency = 1
            nameLbl.Size = UDim2.new(1, 0, 0, 16)
            nameLbl.Font = Enum.Font.GothamBold
            nameLbl.TextSize = 13
            nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLbl.TextStrokeTransparency = 0.2
            nameLbl.Parent = bb
            local distLbl = Instance.new("TextLabel")
            distLbl.Name = "DistLbl"
            distLbl.BackgroundTransparency = 1
            distLbl.Size = UDim2.new(1, 0, 0, 12)
            distLbl.Position = UDim2.new(0, 0, 0, 16)
            distLbl.Font = Enum.Font.GothamBold
            distLbl.TextSize = 11
            distLbl.TextColor3 = accentColor
            distLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            distLbl.TextStrokeTransparency = 0.3
            distLbl.Parent = bb
            StatusESP[char] = bb
        end
        local nameLbl = bb:FindFirstChild("NameLbl")
        local distLbl = bb:FindFirstChild("DistLbl")
        if nameLbl then nameLbl.Text = plr.Name; nameLbl.Visible = FESPS.ShowName end
        if distLbl then distLbl.Text = string.format("%.0fm", dist); distLbl.Visible = FESPS.ShowDistance end
    end

    -- Generator ESP
    local function UpdateGenerator(gen)
        if not gen or not gen.Parent then return end
        if not FESP.Generator then
            local o = gen:FindFirstChild("PazzGenESP"); if o then o:Destroy() end
            local h = gen:FindFirstChild("PazzGenHighlight"); if h then h:Destroy() end
            return
        end
        local percent = gen:GetAttribute("RepairProgress") or gen:GetAttribute("Progress") or gen:GetAttribute("ProgressRepair") or 0
        local bb = gen:FindFirstChild("PazzGenESP")
        if percent >= 100 then if bb then bb:Destroy() end; return end
        local cp = math.clamp(percent, 0, 100)
        local color = FESPC.Generator:Lerp(Color3.fromRGB(0, 255, 120), cp / 100)
        local text = string.format("[%.0f%%]", percent)
        if not bb then
            bb = Instance.new("BillboardGui")
            bb.Name = "PazzGenESP"
            bb.Size = UDim2.new(0, 100, 0, 30)
            bb.AlwaysOnTop = true
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.TextColor3 = color
            lbl.TextStrokeTransparency = 0
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 12
            lbl.Parent = bb
            bb.Adornee = gen
            bb.Parent = gen
        else
            local lbl = bb:FindFirstChildOfClass("TextLabel")
            if lbl then lbl.Text = text; lbl.TextColor3 = color end
        end
        local h = gen:FindFirstChild("PazzGenHighlight") or Instance.new("Highlight")
        h.Name = "PazzGenHighlight"
        h.Adornee = gen
        h.FillColor = color
        h.OutlineColor = color
        h.FillTransparency = 0.9
        h.OutlineTransparency = 0.3
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = gen
    end

    -- Update loop
    local espLastUpdate = 0
    RunService.RenderStepped:Connect(function()
        local now = tick()
        if now - espLastUpdate < 0.05 then return end
        espLastUpdate = now
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local char = p.Character
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local dist = (hrp.Position - root.Position).Magnitude
                        if dist <= FESP.Distance then
                            if FESP.Survivor and TeamIs(p, "Survivor") then
                                CreateESP(char, FESPC.Survivor)
                            elseif FESP.Killer and TeamIs(p, "Killer") then
                                CreateESP(char, FESPC.Killer)
                            else
                                RemoveESP(char)
                            end
                        else
                            RemoveESP(char)
                        end
                    end
                    CreateStatusESP(p, char, root)
                else
                    RemoveESP(char)
                    RemoveStatusESP(char)
                end
            end
        end

        if FESP.Generator then
            for gen in pairs(CachedGen) do UpdateGenerator(gen) end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════
--  STUN INDICATOR (Simple)
-- ═══════════════════════════════════════════════════════════════════
do
    local function SInd_IsStunned(char)
        if not char then return false end
        if char:GetAttribute("IsStunned") == true then return true end
        local ci = char:FindFirstChild("CheckInterractable")
        if ci and ci:GetAttribute("isStunned") == true then return true end
        return false
    end

    local function SInd_GetSoundId()
        return StunSounds[SInd.SelectedSound] or SInd.SoundId
    end

    local SIndCache = {}

    local function SInd_Create(char)
        if SIndCache[char] then return end
        local head = char:FindFirstChild("Head")
        if not head then return end
        local bb = Instance.new("BillboardGui")
        bb.Name = "PazzStunIndicator"
        bb.Size = UDim2.fromOffset(120, 30)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true
        bb.LightInfluence = 0
        bb.Adornee = head
        bb.Parent = char
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.fromScale(1, 1)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamBlack
        lbl.Text = "STUNNED"
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.TextStrokeColor3 = Color3.fromRGB(255, 60, 60)
        lbl.TextStrokeTransparency = 0
        lbl.TextScaled = true
        lbl.Parent = bb
        SIndCache[char] = bb
    end

    local function SInd_Remove(char)
        if SIndCache[char] then
            pcall(function() SIndCache[char]:Destroy() end)
            SIndCache[char] = nil
        end
    end

    local function SInd_PlaySound(char)
        if not SInd.SoundEnabled then return end
        pcall(function()
            local head = char and (char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart"))
            if not head then return end
            local snd = Instance.new("Sound")
            snd.SoundId = "rbxassetid://" .. tostring(SInd_GetSoundId())
            snd.Volume = SInd.SoundVolume or 1.5
            snd.Parent = head
            snd:Play()
            snd.Ended:Connect(function() pcall(function() snd:Destroy() end) end)
            task.delay(5, function() pcall(function() if snd and snd.Parent then snd:Destroy() end end) end)
        end)
    end

    PZ.SInd_SetEnabled = function(v)
        SInd.Enabled = v and true or false
        if SInd.Enabled then
            if SInd.HeartbeatConn then return end
            SInd.HeartbeatConn = RunService.Heartbeat:Connect(function()
                if not SInd.Enabled then return end
                local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not myRoot then return end
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                        local char = p.Character
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local dist = (hrp.Position - myRoot.Position).Magnitude
                            local stunned = SInd_IsStunned(char)
                            local wasStunned = SIndCache[char] ~= nil
                            if stunned and dist <= SInd.Range then
                                if not wasStunned then SInd_PlaySound(char); SInd_Create(char) end
                            else
                                if wasStunned then SInd_Remove(char) end
                            end
                        end
                    end
                end
            end)
        else
            if SInd.HeartbeatConn then SInd.HeartbeatConn:Disconnect(); SInd.HeartbeatConn = nil end
            for _, gui in pairs(SIndCache) do pcall(function() gui:Destroy() end) end
            SIndCache = {}
        end
    end
    PZ.SInd = SInd
    PZ.StunSounds = StunSounds
                end-- ═══════════════════════════════════════════════════════════════════
--  KILLER: AUTO ATTACK
-- ═══════════════════════════════════════════════════════════════════
local lastAutoAttack = 0
local function KA_AutoAttack()
    if not PZ.KILLER_AutoAttack then return end
    if GetRole() ~= "Killer" then return end
    local now = tick()
    if now - lastAutoAttack < (PZ.KILLER_AutoAttackCooldown or 0.15) then return end
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local closest, shortest = nil, PZ.KILLER_AutoAttackRange or 12
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and TeamIs(plr, "Survivor") and plr.Character then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 35 then
                local d = (hrp.Position - root.Position).Magnitude
                if d <= shortest then shortest = d; closest = plr end
            end
        end
    end
    if closest then
        lastAutoAttack = now
        pcall(function()
            local attacks = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Attacks")
            local basic = attacks and attacks:FindFirstChild("BasicAttack")
            if basic then basic:FireServer(false) end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════
--  KILLER: INFINITE LUNGE
-- ═══════════════════════════════════════════════════════════════════
local VD_OriginalLungeBoost = nil
local function VD_UpdateInfiniteLunge()
    local char = LocalPlayer.Character
    if not char then return end
    if PZ.KILLER_InfLunge then
        if char:GetAttribute("lungeboost") ~= 999999 then
            VD_OriginalLungeBoost = char:GetAttribute("lungeboost") or 1
            char:SetAttribute("lungeboost", 999999)
        end
    else
        if VD_OriginalLungeBoost then
            char:SetAttribute("lungeboost", VD_OriginalLungeBoost)
            VD_OriginalLungeBoost = nil
        end
    end
end
PZ.UpdateInfiniteLunge = VD_UpdateInfiniteLunge

-- ═══════════════════════════════════════════════════════════════════
--  KILLER: DESTROY PALLET
-- ═══════════════════════════════════════════════════════════════════
local IsBreakingPallet = false
local function DestroyAllPallets()
    if not PZ.KILLER_DestroyPallets then return end
    if GetRole() ~= "Killer" then return end
    if IsBreakingPallet then return end
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not root then return end
    local ci = char:FindFirstChild("CheckInterractable")
    local action = ci and (ci:GetAttribute("action") or ci:GetAttribute("Action"))
    if action then return end
    local pts = CollectionService:GetTagged("PalletPointSlide")
    local nearest, minDist = nil, 6
    for _, p in ipairs(pts) do
        if p:IsA("BasePart") and not CollectionService:HasTag(p, "doing action") then
            local d = (p.Position - root.Position).Magnitude
            if d < minDist then minDist = d; nearest = p end
        end
    end
    if not nearest then return end
    IsBreakingPallet = true
    task.spawn(function()
        pcall(function()
            local r = ReplicatedStorage:FindFirstChild("Remotes")
            local pFold = r and r:FindFirstChild("Pallet")
            local j = pFold and pFold:FindFirstChild("Jason")
            if j then
                local dg = j:FindFirstChild("Destroy-Global")
                local commit = j:FindFirstChild("PalletBreakCommit")
                if dg and dg:IsA("RemoteEvent") then dg:FireServer(nearest) end
                if commit and commit:IsA("RemoteEvent") then commit:FireServer(nearest) end
            end
        end)
        task.wait(0.3)
        IsBreakingPallet = false
    end)
end

-- ═══════════════════════════════════════════════════════════════════
--  KILLER: ANTI BLIND
-- ═══════════════════════════════════════════════════════════════════
local function SetupAntiBlind()
    pcall(function()
        local r  = ReplicatedStorage:FindFirstChild("Remotes")
        local i  = r and r:FindFirstChild("Items")
        local fl = i and i:FindFirstChild("Flashlight")
        local gb = fl and fl:FindFirstChild("GotBlinded")
        if not (gb and gb:IsA("RemoteEvent")) then return end
        local ok, mt = pcall(function() return getrawmetatable(game) end)
        if ok and mt and setreadonly then
            pcall(function()
                setreadonly(mt, false)
                local old = mt.__namecall
                mt.__namecall = newcclosure(function(self, ...)
                    if not checkcaller() and PZ.KILLER_AntiBlind and self == gb then
                        local method = getnamecallmethod()
                        if method == "FireServer" and GetRole() == "Killer" then
                            return nil
                        end
                    end
                    return old(self, ...)
                end)
                setreadonly(mt, true)
            end)
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════
--  KILLER: AUTO HOOK
-- ═══════════════════════════════════════════════════════════════════
do
    local IsAutoHooking = false

    local function GetMapCacheHooks()
        local hooks = {}
        local map = Workspace:FindFirstChild("Map")
        if not map then return hooks end
        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Hook" then
                local hp = obj:FindFirstChild("HookPoint") or obj:FindFirstChild("HookHitbox") or obj:FindFirstChildWhichIsA("BasePart", true)
                if hp then table.insert(hooks, { model = obj, part = hp }) end
            end
        end
        return hooks
    end

    local function IsPlayerOnHook(character, hooks)
        local tr = character:FindFirstChild("HumanoidRootPart")
        if not tr then return false end
        for _, h in ipairs(hooks) do
            if (h.part.Position - tr.Position).Magnitude < 6 then return true end
        end
        return false
    end

    local function FindDownedSurvivor(hooks)
        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil, nil end
        local closest, closestDist, closestChar = nil, math.huge, nil
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl == LocalPlayer or not pl.Character then continue end
            if not TeamIs(pl, "Survivor") then continue end
            local tr = pl.Character:FindFirstChild("HumanoidRootPart")
            local h = pl.Character:FindFirstChildOfClass("Humanoid")
            if not tr or not h then continue end
            local pct = h.MaxHealth > 0 and (h.Health / h.MaxHealth) or 0
            if pct > 0.25 or pct <= 0 then continue end
            if IsPlayerOnHook(pl.Character, hooks) then continue end
            if pl.Character:GetAttribute("IsCarried") == true then continue end
            local d = (tr.Position - myRoot.Position).Magnitude
            if d < closestDist then
                closestDist = d
                closest = tr
                closestChar = pl.Character
            end
        end
        return closest, closestChar
    end

    local function FindNearestHook(targetPos, hooks)
        local closest, closestDist = nil, math.huge
        for _, h in ipairs(hooks) do
            local d = (h.part.Position - targetPos).Magnitude
            if d < closestDist then closestDist = d; closest = h end
        end
        return closest
    end

    local function DoAutoHook()
        if not PZ.KILLER_AutoHook then return end
        if IsAutoHooking then return end
        if GetRole() ~= "Killer" then return end
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local hooks = GetMapCacheHooks()
        if #hooks == 0 then return end
        local targetRoot, targetChar = FindDownedSurvivor(hooks)
        if not targetRoot then return end
        local nearestHook = FindNearestHook(targetRoot.Position, hooks)
        if not nearestHook then return end
        IsAutoHooking = true
        task.spawn(function()
            local CarryEvent, HookEvent, HookCommit
            pcall(function()
                local carryFolder = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Carry")
                CarryEvent = carryFolder:FindFirstChild("CarrySurvivorEvent")
                HookEvent  = carryFolder:FindFirstChild("HookEvent")
                HookCommit = carryFolder:FindFirstChild("HookCommit")
            end)
            pcall(function()
                root.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 3, 0), targetRoot.Position)
            end)
            task.wait(0.2)
            pcall(function() if CarryEvent then CarryEvent:FireServer(targetChar) end end)
            task.wait(0.5)
            local r2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not r2 then IsAutoHooking = false; return end
            pcall(function()
                r2.CFrame = CFrame.new(nearestHook.part.Position + Vector3.new(0, 3, 0))
            end)
            task.wait(0.3)
            pcall(function()
                local hookPoint = nearestHook.model:FindFirstChild("HookPoint") or nearestHook.model:FindFirstChild("HookHitbox") or nearestHook.part
                if HookEvent then HookEvent:FireServer(hookPoint) end
                if HookCommit then HookCommit:FireServer(hookPoint) end
            end)
            task.wait(1)
            IsAutoHooking = false
        end)
    end

    PZ.KA_StartAutoHook = function()
        if PZ._AutoHookThread then return end
        PZ._AutoHookThread = task.spawn(function()
            while PZ.KILLER_AutoHook do
                if GetRole() == "Killer" then pcall(DoAutoHook) end
                task.wait(1)
            end
            PZ._AutoHookThread = nil
        end)
    end
    PZ.KA_StopAutoHook = function()
        if PZ._AutoHookThread then
            pcall(function() task.cancel(PZ._AutoHookThread) end)
            PZ._AutoHookThread = nil
        end
    end
end

-- Main killer loop
task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(KA_AutoAttack)
        pcall(VD_UpdateInfiniteLunge)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.12)
        if PZ.KILLER_DestroyPallets then pcall(DestroyAllPallets) end
    end
end)

pcall(SetupAntiBlind)
PZ.SetupAntiBlind = SetupAntiBlind-- ═══════════════════════════════════════════════════════════════════
--  GRAPHICS SYSTEM
-- ═══════════════════════════════════════════════════════════════════
local original = {
    Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
    Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
    GlobalShadows = Lighting.GlobalShadows,
    FOV = Workspace.CurrentCamera and Workspace.CurrentCamera.FieldOfView or 70,
}

function PZ.Graphics_Apply()
    if G.Fullbright then
        Lighting.Brightness     = 2; Lighting.ClockTime = 14
        Lighting.Ambient        = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Brightness     = original.Brightness
        Lighting.ClockTime      = original.ClockTime
        Lighting.Ambient        = original.Ambient
        Lighting.OutdoorAmbient = original.OutdoorAmbient
    end
    Lighting.GlobalShadows = not G.NoShadow
    if G.ClockTimeEnabled then
        Lighting.ClockTime = G.ClockTime
        Lighting.Brightness = G.Brightness
    end
end

function PZ.Graphics_ApplyOptimization()
    pcall(function()
        if G.LowGraphics then settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end
    end)
    if G.CleanSky then
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end
    end
end

function PZ.Graphics_ApplyNoScreenFx()
    local types = { "ColorCorrectionEffect", "DepthOfFieldEffect", "BlurEffect", "SunRaysEffect", "BloomEffect" }
    if G.NoScreenEffects then
        for _, v in pairs(Lighting:GetChildren()) do
            for _, t in ipairs(types) do
                if v:IsA(t) then v.Enabled = false end
            end
        end
    end
end

function PZ.Graphics_ApplyZoom()
    if G.UnlimitedZoom then
        LocalPlayer.CameraMaxZoomDistance = G.MaxZoomDistance
        LocalPlayer.CameraMinZoomDistance = 0
    else
        LocalPlayer.CameraMaxZoomDistance = 128
        LocalPlayer.CameraMinZoomDistance = 0.5
    end
end

function PZ.Graphics_ApplyFOV()
    local cam = Workspace.CurrentCamera
    if not cam then return end
    if G.FOVEnabled then cam.FieldOfView = G.FOV
    else cam.FieldOfView = original.FOV end
end

PZ.Graphics = G

-- ═══════════════════════════════════════════════════════════════════
--  PLAYER UTILITY
-- ═══════════════════════════════════════════════════════════════════
RunService.Heartbeat:Connect(function()
    if not PU.SpeedEnabled then return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and hum.WalkSpeed ~= PU.SpeedValue then hum.WalkSpeed = PU.SpeedValue end
end)

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum  = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local cam  = Workspace.CurrentCamera
    if not (hum and root and cam) then return end
    if PU.ShiftLock then
        hum.AutoRotate = false
        PU._shiftLockWasActive = true
        local look = cam.CFrame.LookVector
        local flat = Vector3.new(look.X, 0, look.Z)
        if flat.Magnitude > 0.001 then root.CFrame = CFrame.new(root.Position, root.Position + flat.Unit) end
    elseif PU._shiftLockWasActive then
        hum.AutoRotate = true
        PU._shiftLockWasActive = false
    end
end)

RunService.Stepped:Connect(function()
    if not PU.Noclip then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            if PU._origCanCollide[d] == nil then PU._origCanCollide[d] = d.CanCollide end
            d.CanCollide = false
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not PU.UnlimitedZoom then return end
    if LocalPlayer.CameraMaxZoomDistance ~= math.huge then LocalPlayer.CameraMaxZoomDistance = math.huge end
    if LocalPlayer.CameraMinZoomDistance ~= 0 then LocalPlayer.CameraMinZoomDistance = 0 end
end)

function PZ.RestoreNoclip()
    for part, cc in pairs(PU._origCanCollide) do
        if part and part.Parent then pcall(function() part.CanCollide = cc end) end
    end
    PU._origCanCollide = {}
end

PZ.PU = PU

-- ═══════════════════════════════════════════════════════════════════
--  INVISIBLE (MengHub API)
-- ═══════════════════════════════════════════════════════════════════
do
    local MV = getgenv().PazzInvis
    if not MV then
        MV = { Enabled = false, Loading = false, Ready = false, API = nil, _lastToggle = 0 }
        getgenv().PazzInvis = MV
    end
    local INVIS_URL = "https://leekguy.vercel.app/roblox/menghub/crack_obf_invisible_93978595733734.lua"

    local function Invis_Cleanup()
        pcall(function()
            local chair = Workspace:FindFirstChild("invischair")
            if chair then chair:Destroy() end
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if (part:IsA("BasePart") or part:IsA("Decal")) and part.Name ~= "Hurtbox" and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 0
                        if part:IsA("BasePart") then part.LocalTransparencyModifier = 0 end
                    end
                end
            end
        end)
    end

    local function Invis_LoadAPI()
        if _G.MengHub and _G.MengHub.Invisible and type(_G.MengHub.Invisible.enable) == "function" then
            MV.API = _G.MengHub.Invisible
            MV.Ready = true
            return true
        end
        MV.Loading = true; MV.Ready = false
        for attempt = 1, 3 do
            local ok, err = pcall(function() loadstring(game:HttpGet(INVIS_URL))() end)
            task.wait(0.5)
            if ok and _G.MengHub and _G.MengHub.Invisible then
                MV.API = _G.MengHub.Invisible
                MV.Ready = true; MV.Loading = false
                return true
            end
        end
        MV.Loading = false
        return false
    end

    task.spawn(function() Invis_LoadAPI() end)

    PZ.Invisible_SetState = function(state, fromButton)
        state = state and true or false
        local now = tick()
        if now - MV._lastToggle < 0.25 then return end
        if not MV.API then
            task.spawn(function()
                if Invis_LoadAPI() then PZ.Invisible_SetState(state, fromButton) end
            end)
            return
        end
        if MV.Enabled == state then
            if not state then Invis_Cleanup() end
            return
        end
        MV._lastToggle = now
        MV.Enabled = state
        if state then
            local ok = pcall(function() MV.API.enable() end)
            if not ok then MV.Enabled = false; Invis_Cleanup() end
        else
            pcall(function() MV.API.disable() end)
            Invis_Cleanup()
        end
    end

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1.2)
        if MV.Enabled and MV.API then pcall(function() MV.API.enable() end) end
    end)
                    end-- ═══════════════════════════════════════════════════════════════════
--  SILENT VEIL V1 (ALFzxzzz Original) — Optional
-- ═══════════════════════════════════════════════════════════════════
do
    PZ.VeilEnabled = false
    PZ.VeilShowFOV = true
    PZ.VeilShowTracker = false
    PZ.VeilAutoPredict = true
    PZ.VeilFOV = 150
    PZ.VeilMaxDist = 280
    PZ.VeilSpearSpeed = 165
    PZ.VeilGravity = 103
    PZ.VeilAuraSpearSpeed = 165
    PZ.VeilAuraSpearGravity = 96
    PZ.VeilLeadMultiplier = 1.4

    local VeilState = { target = nil, lookVector = nil, velHistory = {} }
    local VeilVisuals = {}

    pcall(function()
        if typeof(Drawing) ~= "table" or not Drawing.new then return end
        local V = VeilVisuals
        local ACCENT = ACCENT or Color3.fromRGB(0, 170, 255)
        local BLACK  = Color3.fromRGB(0, 0, 0)
        local WHITE  = Color3.fromRGB(255, 255, 255)
        V.FOVOuterRing = Drawing.new("Circle"); V.FOVOuterRing.Color = BLACK; V.FOVOuterRing.Thickness = 3; V.FOVOuterRing.Filled = false; V.FOVOuterRing.Transparency = 0.4; V.FOVOuterRing.Visible = false; V.FOVOuterRing.NumSides = 90
        V.FOVMainRing = Drawing.new("Circle"); V.FOVMainRing.Color = ACCENT; V.FOVMainRing.Thickness = 1.6; V.FOVMainRing.Filled = false; V.FOVMainRing.Transparency = 0.85; V.FOVMainRing.Visible = false; V.FOVMainRing.NumSides = 90
        V.FOVInnerRing = Drawing.new("Circle"); V.FOVInnerRing.Color = ACCENT; V.FOVInnerRing.Thickness = 1; V.FOVInnerRing.Filled = false; V.FOVInnerRing.Transparency = 0.35; V.FOVInnerRing.Visible = false; V.FOVInnerRing.NumSides = 90
        V.FOVCrossLines = {}; for i = 1, 4 do local line = Drawing.new("Line"); line.Color = WHITE; line.Thickness = 1.5; line.Transparency = 0.9; line.Visible = false; V.FOVCrossLines[i] = line end
        V.FOVTicks = {}; for i = 1, 4 do local line = Drawing.new("Line"); line.Color = ACCENT; line.Thickness = 2.2; line.Transparency = 0.95; line.Visible = false; V.FOVTicks[i] = line end
        V.TrackerOuterRing = Drawing.new("Circle"); V.TrackerOuterRing.Color = BLACK; V.TrackerOuterRing.Thickness = 3; V.TrackerOuterRing.Filled = false; V.TrackerOuterRing.Transparency = 0.3; V.TrackerOuterRing.NumSides = 40; V.TrackerOuterRing.Visible = false
        V.TrackerMainRing = Drawing.new("Circle"); V.TrackerMainRing.Color = ACCENT; V.TrackerMainRing.Thickness = 1.6; V.TrackerMainRing.Filled = false; V.TrackerMainRing.Transparency = 0.9; V.TrackerMainRing.NumSides = 40; V.TrackerMainRing.Visible = false
        V.TrackerDotFill = Drawing.new("Circle"); V.TrackerDotFill.Color = ACCENT; V.TrackerDotFill.Thickness = 1; V.TrackerDotFill.Filled = true; V.TrackerDotFill.Transparency = 0.9; V.TrackerDotFill.Radius = 3; V.TrackerDotFill.NumSides = 20; V.TrackerDotFill.Visible = false
        V.TrackerDotOutline = Drawing.new("Circle"); V.TrackerDotOutline.Color = BLACK; V.TrackerDotOutline.Thickness = 3; V.TrackerDotOutline.Filled = false; V.TrackerDotOutline.Transparency = 0.3; V.TrackerDotOutline.Radius = 6; V.TrackerDotOutline.NumSides = 20; V.TrackerDotOutline.Visible = false
        V.TrackerLine = Drawing.new("Line"); V.TrackerLine.Color = ACCENT; V.TrackerLine.Thickness = 1.5; V.TrackerLine.Transparency = 0.6; V.TrackerLine.Visible = false
    end)

    local function Veil_IsSurvivorVeil(p)
        if not p or not p.Team or not p.Team.Name then return false end
        return string.find(string.lower(p.Team.Name), "survivor", 1, true) ~= nil
    end

    local function Veil_solvePitch(v0, g, d, dy)
        d = math.max(d, 0.1)
        local s2 = v0 * v0
        local root = s2 * s2 - g * (g * d * d + 2 * dy * s2)
        if root < 0 then root = 0 end
        local tanTheta = (s2 - math.sqrt(root)) / (g * d)
        local theta = math.atan(tanTheta)
        local t = d / (v0 * math.cos(theta))
        return theta, t
    end

    local function Veil_getCharacterVelocity(char)
        local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
        if not root then return Vector3.zero end
        local now = os.clock()
        local last = VeilState.velHistory[char]
        local measured = Vector3.zero
        if last and now - last.t > 0.02 then
            measured = (root.Position - last.pos) / (now - last.t)
            if measured.Magnitude > 150 then measured = last.smooth or Vector3.zero end
        end
        local smooth = last and last.smooth or measured
        smooth = smooth:Lerp(measured, 0.65)
        VeilState.velHistory[char] = { pos = root.Position, t = now, smooth = smooth }
        if smooth.Magnitude < 1 then return Vector3.zero end
        return Vector3.new(smooth.X, 0, smooth.Z)
    end

    local function Veil_HideAll()
        local V = VeilVisuals
        local OFF = Vector2.new(-9999, -9999)
        if V.FOVOuterRing then V.FOVOuterRing.Visible = false end
        if V.FOVMainRing then V.FOVMainRing.Visible = false end
        if V.FOVInnerRing then V.FOVInnerRing.Visible = false end
        if V.FOVCrossLines then for _, s in ipairs(V.FOVCrossLines) do s.Visible = false end end
        if V.FOVTicks then for _, s in ipairs(V.FOVTicks) do s.Visible = false end end
        if V.TrackerOuterRing then V.TrackerOuterRing.Visible = false end
        if V.TrackerMainRing then V.TrackerMainRing.Visible = false end
        if V.TrackerDotFill then V.TrackerDotFill.Visible = false end
        if V.TrackerDotOutline then V.TrackerDotOutline.Visible = false end
        if V.TrackerLine then V.TrackerLine.Visible = false end
    end

    local function Veil_UpdateAimbot()
        if GetRole() ~= "Killer" then
            VeilState.target = nil; VeilState.lookVector = nil
            Veil_HideAll(); return
        end
        local cam = Workspace.CurrentCamera
        if not cam then return end
        local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
        if not PZ.VeilEnabled then
            VeilState.target = nil; VeilState.lookVector = nil
            Veil_HideAll(); return
        end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local nearest, nearestPart = nil, nil
        local bestDist = PZ.VeilFOV
        local bestStudDist = PZ.VeilMaxDist
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and Veil_IsSurvivorVeil(p) and p.Character then
                local pc = p.Character
                local hum = pc:FindFirstChildOfClass("Humanoid")
                local targetPart = pc:FindFirstChild("UpperTorso") or pc:FindFirstChild("Torso") or pc:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and targetPart then
                    local sp, on = cam:WorldToViewportPoint(targetPart.Position)
                    if on and sp.Z > 0 then
                        local sd = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        if sd < bestDist then
                            local studDist = (targetPart.Position - hrp.Position).Magnitude
                            if studDist <= bestStudDist then bestDist = sd; nearest = p; nearestPart = targetPart end
                        end
                    end
                end
            end
        end
        if nearest and nearestPart then
            local tp = nearestPart.Position
            local hand = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
            local origin = (hand and hand:IsA("BasePart")) and hand.Position or hrp.Position
            local dir = tp - origin
            local dist = dir.Magnitude
            if dist > 0.1 and dist <= PZ.VeilMaxDist then
                local isAuraActive = char:GetAttribute("special") == true
                local v0 = isAuraActive and PZ.VeilAuraSpearSpeed or PZ.VeilSpearSpeed
                local g = isAuraActive and PZ.VeilAuraSpearGravity or PZ.VeilGravity
                local aimPoint = tp
                if PZ.VeilAutoPredict then
                    local vel = Veil_getCharacterVelocity(nearest.Character)
                    if vel.Magnitude > 0.5 then
                        local h0 = Vector3.new(dir.X, 0, dir.Z)
                        local _, tFlight = Veil_solvePitch(v0, g, h0.Magnitude, dir.Y)
                        local ping = 0.08
                        pcall(function() ping = math.clamp(LocalPlayer:GetNetworkPing(), 0, 0.35) end)
                        local delay = tFlight + 0.10 + ping + 0.04
                        for _ = 1, 2 do
                            local lead = vel * delay * PZ.VeilLeadMultiplier
                            local maxLead = math.clamp(dist * 0.6, 3, 45)
                            if lead.Magnitude > maxLead then lead = lead.Unit * maxLead end
                            aimPoint = tp + lead
                            local ad = aimPoint - origin
                            local ah = Vector3.new(ad.X, 0, ad.Z)
                            local _, t2 = Veil_solvePitch(v0, g, math.max(ah.Magnitude, 0.1), ad.Y)
                            delay = t2 + 0.10 + ping + 0.04
                        end
                    end
                end
                local adir = aimPoint - origin
                local ah = Vector3.new(adir.X, 0, adir.Z)
                local ahDist = ah.Magnitude
                local pitch = Veil_solvePitch(v0, g, ahDist, adir.Y)
                if ahDist > 0.001 then VeilState.lookVector = ah.Unit * math.cos(pitch) + Vector3.new(0, math.sin(pitch), 0)
                else VeilState.lookVector = adir.Unit end
                VeilState.target = nearest
            end
        else
            VeilState.target = nil; VeilState.lookVector = nil
        end
    end

    local VeilHookState = { remoteHooked = false }
    local function Veil_setupInterceptor()
        if VeilHookState.remoteHooked then return end
        if typeof(hookmetamethod) ~= "function" then return end
        task.spawn(function()
            pcall(function()
                local oldNamecall
                oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                    local method = getnamecallmethod()
                    if not checkcaller() and method == "FireServer" then
                        if self.Name == "Spearthrow" and PZ.VeilEnabled and typeof(VeilState.lookVector) == "Vector3" and GetRole() == "Killer" then
                            local args = {...}
                            if typeof(args[1]) == "Vector3" then args[1] = VeilState.lookVector end
                            return oldNamecall(self, unpack(args))
                        end
                    end
                    return oldNamecall(self, ...)
                end)
                VeilHookState.remoteHooked = true
            end)
        end)
    end
    Veil_setupInterceptor()

    RunService.RenderStepped:Connect(function() pcall(Veil_UpdateAimbot) end)
                        end-- ═══════════════════════════════════════════════════════════════════
--  TAB: SURVIVOR
-- ═══════════════════════════════════════════════════════════════════
local SurvivorL = Tabs.Survivor:AddLeftGroupbox("Survivor", "user")
local SurvivorR = Tabs.Survivor:AddRightGroupbox("Parry & Ability", "zap")

SurvivorL:AddToggle("AutoCrouch", {
    Text = "Auto Crouch Dodge",
    Default = false,
    Tooltip = "Auto crouch saat killer pakai Abyssal S1",
    Callback = function(v)
        PZ.AutoCrouch = v
        Notify("Auto Crouch", v and "Enabled" or "Disabled", 2)
    end
})

SurvivorL:AddToggle("AutoFlee", {
    Text = "Auto Flee Killer",
    Default = false,
    Tooltip = "Teleport menjauh saat killer dekat",
    Callback = function(v)
        PZ.SURV_AutoFlee = v
        Notify("Auto Flee", v and "Enabled" or "Disabled", 2)
    end
})

SurvivorL:AddSlider("AutoFleeDist", {
    Text = "Flee Distance",
    Default = 40, Min = 15, Max = 150, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PZ.SURV_AutoFleeDist = v end
})

SurvivorL:AddSlider("AutoFleeCD", {
    Text = "Flee Cooldown",
    Default = 1.5, Min = 0.5, Max = 10, Rounding = 1,
    Suffix = "s",
    Callback = function(v) PZ.SURV_AutoFleeCooldown = v end
})

SurvivorL:AddDivider()

SurvivorL:AddToggle("AutoPallet", {
    Text = "Pallet Reflex",
    Default = false,
    Tooltip = "Auto drop pallet saat killer dekat",
    Callback = function(v)
        PZ.SURV_AutoPallet = v
        Notify("Pallet Reflex", v and "Enabled" or "Disabled", 2)
    end
})

SurvivorL:AddSlider("PalletDist", {
    Text = "Pallet Trigger Distance",
    Default = 20, Min = 5, Max = 50, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PZ.SURV_AutoPalletDist = v end
})

-- RIGHT BOX: Auto Parry V2
SurvivorR:AddLabel("Auto Parry V2 (Wisnu)")
SurvivorR:AddDivider()

SurvivorR:AddToggle("WisnuParry", {
    Text = "Enable Auto Parry V2",
    Default = false,
    Tooltip = "Parry otomatis (Wisnu method)",
    Callback = function(v)
        PZ.Wisnu_AutoParry = v
        Notify("Auto Parry V2", v and "Enabled" or "Disabled", 2)
    end
})

SurvivorR:AddToggle("WisnuAgg", {
    Text = "Aggressive Mode",
    Default = false,
    Tooltip = "Parry tanpa cek arah hadap killer",
    Callback = function(v) PZ.Wisnu_ParryAggressive = v end
})

SurvivorR:AddToggle("WisnuSafe", {
    Text = "Safety Parry",
    Default = false,
    Tooltip = "Skip parry kalau vault/repair/heal",
    Callback = function(v) PZ.Wisnu_ParrySafety = v end
})

SurvivorR:AddSlider("WisnuDist", {
    Text = "Parry Distance",
    Default = 6, Min = 4, Max = 25, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PZ.Wisnu_ParryDistance = v end
})

SurvivorR:AddSlider("WisnuFace", {
    Text = "Face Sensitivity",
    Default = 0.7, Min = -1, Max = 1, Rounding = 2,
    Callback = function(v) PZ.Wisnu_ParryFace = v end
})

SurvivorR:AddToggle("WisnuCircle", {
    Text = "Show Range Circle",
    Default = true,
    Callback = function(v) PZ.Wisnu_ParryCircle = v end
})

SurvivorR:AddDropdown("WisnuIgnore", {
    Text = "Ignore Skills",
    Values = { "Hidden S1", "Abyssal S1" },
    Multi = true,
    Default = {},
    Callback = function(sel)
        local parsed = {}
        if type(sel) == "table" then
            for k, v in pairs(sel) do
                if type(k) == "string" and v then parsed[k] = true
                elseif type(v) == "string" then parsed[v] = true end
            end
        elseif type(sel) == "string" then
            parsed[sel] = true
        end
        PZ.Wisnu_IgnoredSkills = parsed
    end
})-- ═══════════════════════════════════════════════════════════════════
--  TAB: VISUALS
-- ═══════════════════════════════════════════════════════════════════
local VisualsL = Tabs.Visuals:AddLeftGroupbox("ESP", "eye")
local VisualsR = Tabs.Visuals:AddRightGroupbox("Graphics", "globe")

VisualsL:AddToggle("ESPSurvivor", {
    Text = "ESP Survivor",
    Default = false,
    Callback = function(v) FESP.Survivor = v end
})
VisualsL:AddColorPicker("ESPSurvivorColor", {
    Text = "Survivor Color",
    Default = FESPC.Survivor,
    Callback = function(c) FESPC.Survivor = c end
})

VisualsL:AddToggle("ESPKiller", {
    Text = "ESP Killer",
    Default = false,
    Callback = function(v) FESP.Killer = v end
})
VisualsL:AddColorPicker("ESPKillerColor", {
    Text = "Killer Color",
    Default = FESPC.Killer,
    Callback = function(c) FESPC.Killer = c end
})

VisualsL:AddToggle("ESPGen", {
    Text = "ESP Generator",
    Default = false,
    Callback = function(v) FESP.Generator = v end
})
VisualsL:AddColorPicker("ESPGenColor", {
    Text = "Generator Color",
    Default = FESPC.Generator,
    Callback = function(c) FESPC.Generator = c end
})

VisualsL:AddToggle("ESPPallet", {
    Text = "ESP Pallet",
    Default = false,
    Callback = function(v) FESP.Pallet = v end
})

VisualsL:AddToggle("ESPWindow", {
    Text = "ESP Window",
    Default = false,
    Callback = function(v) FESP.Window = v end
})

VisualsL:AddToggle("ESPSCP", {
    Text = "ESP SCP",
    Default = false,
    Callback = function(v) FESP.SCP = v end
})

VisualsL:AddSlider("ESPDist", {
    Text = "ESP Radius",
    Default = 500, Min = 10, Max = 1000, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) FESP.Distance = v end
})

VisualsL:AddDivider()
VisualsL:AddLabel("ESP Status")
VisualsL:AddDivider()

VisualsL:AddToggle("StatusESP", {
    Text = "Enable Status ESP",
    Default = false,
    Callback = function(v) FESPS.Enabled = v end
})
VisualsL:AddToggle("StatusName", {
    Text = "Show Name",
    Default = true,
    Callback = function(v) FESPS.ShowName = v end
})
VisualsL:AddToggle("StatusDist", {
    Text = "Show Distance",
    Default = true,
    Callback = function(v) FESPS.ShowDistance = v end
})

VisualsR:AddLabel("Graphics")
VisualsR:AddDivider()

VisualsR:AddToggle("Fullbright", {
    Text = "Fullbright",
    Default = false,
    Callback = function(v) G.Fullbright = v; PZ.Graphics_Apply() end
})

VisualsR:AddToggle("NoShadow", {
    Text = "No Shadow",
    Default = false,
    Callback = function(v) G.NoShadow = v; PZ.Graphics_Apply() end
})

VisualsR:AddToggle("LowGFX", {
    Text = "Low Graphics",
    Default = false,
    Callback = function(v) G.LowGraphics = v; PZ.Graphics_ApplyOptimization() end
})

VisualsR:AddToggle("NoScreenFx", {
    Text = "No Screen Effects",
    Default = false,
    Callback = function(v) G.NoScreenEffects = v; PZ.Graphics_ApplyNoScreenFx() end
})

VisualsR:AddToggle("CleanSky", {
    Text = "Clean Sky",
    Default = false,
    Callback = function(v) G.CleanSky = v; PZ.Graphics_ApplyOptimization() end
})

VisualsR:AddDivider()

VisualsR:AddToggle("UnlimZoom", {
    Text = "Unlimited Zoom",
    Default = false,
    Callback = function(v) G.UnlimitedZoom = v; PZ.Graphics_ApplyZoom() end
})

VisualsR:AddToggle("CustomFOV", {
    Text = "Custom FOV",
    Default = false,
    Callback = function(v) G.FOVEnabled = v; PZ.Graphics_ApplyFOV() end
})

VisualsR:AddSlider("FOVVal", {
    Text = "Camera FOV",
    Default = 70, Min = 40, Max = 120, Rounding = 0,
    Callback = function(v) G.FOV = v; if G.FOVEnabled then PZ.Graphics_ApplyFOV() end end
})-- ═══════════════════════════════════════════════════════════════════
--  TAB: KILLER
-- ═══════════════════════════════════════════════════════════════════
local KillerL = Tabs.Killer:AddLeftGroupbox("Killer", "swords")
local KillerR = Tabs.Killer:AddRightGroupbox("Silent Veil V2", "crosshair")

KillerL:AddToggle("AutoAttack", {
    Text = "Auto Attack",
    Default = false,
    Tooltip = "Auto fire BasicAttack",
    Callback = function(v)
        PZ.KILLER_AutoAttack = v
        Notify("Auto Attack", v and "Enabled" or "Disabled", 2)
    end
})

KillerL:AddSlider("AutoAttackRange", {
    Text = "Attack Range",
    Default = 12, Min = 5, Max = 30, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PZ.KILLER_AutoAttackRange = v end
})

KillerL:AddSlider("AutoAttackCD", {
    Text = "Attack Cooldown",
    Default = 0.15, Min = 0.05, Max = 1, Rounding = 2,
    Suffix = "s",
    Callback = function(v) PZ.KILLER_AutoAttackCooldown = v end
})

KillerL:AddDivider()

KillerL:AddToggle("InfLunge", {
    Text = "Infinite Lunge",
    Default = false,
    Tooltip = "Basic attack lunge boost",
    Callback = function(v) PZ.KILLER_InfLunge = v end
})

KillerL:AddToggle("DestroyPallet", {
    Text = "Auto Destroy Pallet",
    Default = false,
    Tooltip = "Auto hancurkan pallet terdekat",
    Callback = function(v)
        PZ.KILLER_DestroyPallets = v
        Notify("Destroy Pallet", v and "Enabled" or "Disabled", 2)
    end
})

KillerL:AddToggle("AntiBlind", {
    Text = "Anti Blind (Flashlight)",
    Default = false,
    Callback = function(v)
        PZ.KILLER_AntiBlind = v
        if v and PZ.SetupAntiBlind then pcall(PZ.SetupAntiBlind) end
        Notify("Anti Blind", v and "Enabled" or "Disabled", 2)
    end
})

KillerL:AddToggle("AutoHook", {
    Text = "Auto Hook",
    Default = false,
    Tooltip = "Auto carry & hook downed survivor",
    Callback = function(v)
        PZ.KILLER_AutoHook = v
        if v then PZ.KA_StartAutoHook() else PZ.KA_StopAutoHook() end
        Notify("Auto Hook", v and "Enabled" or "Disabled", 2)
    end
})

KillerL:AddDivider()
KillerL:AddLabel("Bypass No Cooldown")
KillerL:AddDivider()

KillerL:AddToggle("BypassHidden", {
    Text = "Hidden - Leap Bypass",
    Default = false,
    Callback = function(v) PZ.KILLER_BypassLeap = v end
})

KillerL:AddToggle("BypassMyers", {
    Text = "Myers - Infinite Grab",
    Default = false,
    Callback = function(v) PZ.KILLER_InfGrab = v end
})

KillerL:AddToggle("BypassLake", {
    Text = "Slasher - Infinite LakeMist",
    Default = false,
    Callback = function(v) PZ.KILLER_InfLakeMist = v end
})

KillerL:AddToggle("BypassPursuit", {
    Text = "Slasher - Infinite Pursuit",
    Default = false,
    Callback = function(v) PZ.KILLER_InfPursuit = v end
})

KillerL:AddToggle("BypassAbyss", {
    Text = "Abyss - Bypass Cooldown",
    Default = false,
    Callback = function(v) PZ.KILLER_BypassCooldown = v end
})

KillerL:AddToggle("BypassJeff", {
    Text = "Jeff - Infinite Frenzy",
    Default = false,
    Callback = function(v) PZ.KILLER_InfFrenzy = v end
})

-- RIGHT: Silent Veil V2
KillerR:AddLabel("W424 Silent Veil V2")
KillerR:AddDivider()

KillerR:AddToggle("VeilV1_W424", {
    Text = "Silent Veil V1 (W424)",
    Default = false,
    Callback = function(v)
        PZ.W424Veil_API.AimConfig.Aim_SilentVeil = v
        Notify("Silent Veil V1", v and "Enabled" or "Disabled", 2)
    end
})

KillerR:AddToggle("VeilV2_W424", {
    Text = "Silent Veil V2 (W424)",
    Default = false,
    Callback = function(v)
        PZ.W424Veil_API.AimConfig.Aim_SilentVeilV2 = v
        Notify("Silent Veil V2", v and "Enabled" or "Disabled", 2)
    end
})

KillerR:AddToggle("AutoPredict", {
    Text = "Auto Predict (SpearSmart)",
    Default = false,
    Callback = function(v)
        PZ.W424Veil_API.Config.SpearSmart_enable = v
    end
})

KillerR:AddSlider("LeadMult", {
    Text = "Lead Multiplier",
    Default = 1.4, Min = 0.5, Max = 5, Rounding = 1,
    Callback = function(v) PZ.W424Veil_API.AimConfig.Veil_LeadMultiplier = v end
})

KillerR:AddSlider("SpearSpeed", {
    Text = "Spear Speed",
    Default = 165, Min = 50, Max = 200, Rounding = 0,
    Callback = function(v) PZ.W424Veil_API.AimConfig.SPEAR_Speed = v end
})

KillerR:AddSlider("SpearGravity", {
    Text = "Spear Gravity",
    Default = 103, Min = 0, Max = 200, Rounding = 0,
    Callback = function(v) PZ.W424Veil_API.AimConfig.SPEAR_Gravity = v end
})

KillerR:AddToggle("TrackerTarget", {
    Text = "ESP Tracker Target",
    Default = false,
    Callback = function(v) PZ.W424Veil_API.setTracker(v) end
})

KillerR:AddToggle("ShowVeilFOV", {
    Text = "Show Veil FOV",
    Default = true,
    Callback = function(v) PZ.W424Veil_API.AimConfig.Veil_ShowFOV = v end
})

KillerR:AddSlider("VeilFOV", {
    Text = "Veil FOV Radius",
    Default = 150, Min = 50, Max = 500, Rounding = 0,
    Callback = function(v) PZ.W424Veil_API.AimConfig.Veil_FOV = v end
})-- ═══════════════════════════════════════════════════════════════════
--  TAB: MISC
-- ═══════════════════════════════════════════════════════════════════
local MiscL = Tabs.Misc:AddLeftGroupbox("Misc", "wrench")
local MiscR = Tabs.Misc:AddRightGroupbox("Utility", "settings")

MiscL:AddToggle("NotifToggle", {
    Text = "Enable Notifications",
    Default = true,
    Callback = function(v) NotifyEnabled = v end
})

MiscL:AddDivider()
MiscL:AddLabel("Stun Indicator")
MiscL:AddDivider()

MiscL:AddToggle("StunInd", {
    Text = "Enable Stun Indicator",
    Default = false,
    Callback = function(v)
        PZ.SInd_SetEnabled(v)
        Notify("Stun Indicator", v and "Enabled" or "Disabled", 2)
    end
})

MiscL:AddDropdown("StunSound", {
    Text = "Stun Sound",
    Values = { "Default", "Clash Royale", "Blash", "Coin", "Kururin Kuru", "Spongebob", "Fahhhh", "Cave", "Aughhh", "Samsung", "iPhone", "Siren" },
    Default = "Default",
    Callback = function(v)
        PZ.SInd.SelectedSound = v
        Notify("Stun Indicator", "Sound: " .. v, 2)
    end
})

MiscL:AddSlider("StunRange", {
    Text = "Detect Range",
    Default = 500, Min = 50, Max = 2000, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PZ.SInd.Range = v end
})

MiscL:AddSlider("StunVolume", {
    Text = "Sound Volume",
    Default = 1.5, Min = 0, Max = 5, Rounding = 1,
    Callback = function(v) PZ.SInd.SoundVolume = v end
})

MiscL:AddDivider()
MiscL:AddLabel("Invisibility")
MiscL:AddDivider()

MiscL:AddToggle("Invis", {
    Text = "Enable Invisibility",
    Default = false,
    Tooltip = "Real invisibility (MengHub API)",
    Callback = function(v)
        PZ.Invisible_SetState(v, false)
        Notify("Invisible", v and "Enabled" or "Disabled", 2)
    end
})

MiscR:AddLabel("Player Utility")
MiscR:AddDivider()

MiscR:AddToggle("SpeedHack", {
    Text = "Speed Hack",
    Default = false,
    Callback = function(v)
        PU.SpeedEnabled = v
        if not v then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
        Notify("Speed Hack", v and "Enabled" or "Disabled", 2)
    end
})

MiscR:AddSlider("SpeedVal", {
    Text = "Speed Value",
    Default = 16, Min = 16, Max = 200, Rounding = 0,
    Callback = function(v) PU.SpeedValue = v end
})

MiscR:AddToggle("ShiftLock", {
    Text = "Shift Lock",
    Default = false,
    Callback = function(v) PU.ShiftLock = v end
})

MiscR:AddToggle("HideName", {
    Text = "Hide Name",
    Default = false,
    Callback = function(v) PU.HideName = v end
})

MiscR:AddToggle("PingFPS", {
    Text = "Show Ping & FPS",
    Default = false,
    Callback = function(v) PU.ShowPingFPS = v end
})

MiscR:AddToggle("Noclip", {
    Text = "Noclip",
    Default = false,
    Callback = function(v)
        PU.Noclip = v
        if not v then PZ.RestoreNoclip() end
        Notify("Noclip", v and "Enabled" or "Disabled", 2)
    end
})-- ═══════════════════════════════════════════════════════════════════
--  TAB: CONFIG (JANGAN DIHAPUS)
-- ═══════════════════════════════════════════════════════════════════
local ConfigBoxL = Tabs.Config:AddLeftGroupbox("Settings", "wrench")
local ConfigBoxR = Tabs.Config:AddRightGroupbox("Theme", "palette")

ConfigBoxL:AddDropdown("NotificationSide", {
    Values = {"Left", "Right"}, Default = "Right",
    Text = "Notification Side",
    Callback = function(v) Library:SetNotifySide(v) end,
})

ConfigBoxL:AddDropdown("DPIDropdown", {
    Values = {"50%", "75%", "85%", "100%", "125%", "150%"},
    Default = "100%", Text = "DPI Scale",
    Callback = function(v)
        v = v:gsub("%%", "")
        Library:SetDPIScale(tonumber(v))
    end,
})

ConfigBoxL:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor", Default = true,
    Callback = function(v) Library.ShowCustomCursor = v end,
})

ConfigBoxL:AddToggle("WatermarkToggle", {
    Text = "Watermark", Default = true,
    Callback = function(v) Watermark.Visible = v end,
})

ConfigBoxR:AddLabel("Tema: Biru Neon")
ConfigBoxR:AddDivider()

ConfigBoxR:AddSlider("UICornerSlider", {
    Text = "Corner Radius",
    Default = Library.CornerRadius,
    Min = 0, Max = 20, Rounding = 0,
    Callback = function(v) Window:SetCornerRadius(v) end,
})

ConfigBoxR:AddButton({
    Text = "Unload Script",
    Func = function() Library:Unload() end,
})

-- ═══════════════ THEME & SAVE MANAGER ═══════════════
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
ThemeManager:SetFolder("PazzHub")
SaveManager:SetFolder("PazzHub/configs")

SaveManager:BuildConfigSection(Tabs.Config)
ThemeManager:ApplyToTab(Tabs.Config)

-- ═══════════════ FINAL NOTIFY ═══════════════
Library:Notify({
    Title = "PAZZHUB Loaded",
    Content = "5 tabs ready · Auto Parry V2 + Silent Veil V2",
    Duration = 4
})

print("[PAZZHUB] Full features v3.2 loaded — Auto Parry V2 + Silent Veil V2 active.")
