-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB — UI Shell v4
--  Tabs: Survivor · Visuals · Killer · Misc · Troll · Config
--  Survivor Tab: Ported from ALFzxzzz v0.3.7
-- ═══════════════════════════════════════════════════════════════════

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

-- SERVICES
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
local LocalPlayer       = Players.LocalPlayer

local VirtualInputManager
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

-- TEMA
Library.Scheme.AccentColor     = Color3.fromRGB(0, 170, 255)
Library.Scheme.BackgroundColor = Color3.fromRGB(8, 14, 26)
Library.Scheme.MainColor       = Color3.fromRGB(16, 24, 42)
Library.Scheme.OutlineColor    = Color3.fromRGB(0, 120, 200)
Library.Scheme.FontColor       = Color3.fromRGB(200, 230, 255)

local TOGGLE_ICON = 72845574620852
local ACCENT = Color3.fromRGB(0, 170, 255)

-- STATE
local VD = getgenv().VD or {}
getgenv().VD = VD

VD.AutoCrouch            = VD.AutoCrouch or false
VD.PARRY_Enabled         = VD.PARRY_Enabled or false
VD.PARRY_Aggressive      = VD.PARRY_Aggressive or false
VD.PARRY_Distance        = VD.PARRY_Distance or 10
VD.PARRY_ShowCircle      = VD.PARRY_ShowCircle or false
VD.PARRY_SilentParry     = VD.PARRY_SilentParry or false
VD.Wisnu_AutoParry       = VD.Wisnu_AutoParry or false
VD.Wisnu_ParryAggressive = VD.Wisnu_ParryAggressive or false
VD.Wisnu_ParrySafety     = VD.Wisnu_ParrySafety or false
VD.Wisnu_ParryDistance   = VD.Wisnu_ParryDistance or 6
VD.Wisnu_ParryFace       = VD.Wisnu_ParryFace or 0.7
VD.Wisnu_ParryCircle     = VD.Wisnu_ParryCircle or true
VD.Wisnu_IgnoredSkills   = VD.Wisnu_IgnoredSkills or {}

VD.SURV_AutoFlee         = VD.SURV_AutoFlee or false
VD.SURV_AutoFleeDist     = VD.SURV_AutoFleeDist or 40
VD.SURV_AutoFleeCooldown = VD.SURV_AutoFleeCooldown or 1.5

VD.SURV_AutoVault        = VD.SURV_AutoVault or false
VD.SURV_FastVault        = VD.SURV_FastVault or false
VD.SURF_VaultSpeed       = VD.SURF_VaultSpeed or 13
VD.SURV_AutoPallet       = VD.SURV_AutoPallet or false
VD.SURV_AutoPalletDist   = VD.SURV_AutoPalletDist or 20

VD.SURV_FakeParry        = VD.SURV_FakeParry or false
VD.SURV_FakeParryAnim    = VD.SURV_FakeParryAnim or "Enten"
VD.SURV_FakeParryCooldown= VD.SURV_FakeParryCooldown or 0.4
VD.SURV_FakeParryKey     = VD.SURV_FakeParryKey or "V"
VD.SURV_FakeParryShowBtn = VD.SURV_FakeParryShowBtn or false
VD.SURV_FakeParryLocked  = VD.SURV_FakeParryLocked or false

VD.NoFallDamage          = VD.NoFallDamage or false
VD.NextMapPredict        = VD.NextMapPredict or false
VD.ManualGen             = VD.ManualGen or false
VD.AutoGen               = VD.AutoGen or false
VD.KillerEscapeDist      = VD.KillerEscapeDist or 30

VD.TOF_SilentAim         = VD.TOF_SilentAim or false
VD.TOF_TargetMode        = VD.TOF_TargetMode or "Killer"
VD.TOF_Key               = VD.TOF_Key or "Q"
VD.TOF_Laser             = VD.TOF_Laser ~= false
VD.TOF_WallCheck         = VD.TOF_WallCheck ~= false
VD.TOF_BlockKnocked      = VD.TOF_BlockKnocked ~= false

VD.FLASH_SilentAim       = VD.FLASH_SilentAim or false
VD.FLASH_Laser           = VD.FLASH_Laser ~= false
VD.FLASH_TargetPart      = VD.FLASH_TargetPart or "Head"
VD.FLASH_Range           = VD.FLASH_Range or 120
VD.FLASH_Smooth          = VD.FLASH_Smooth or 0.35

VD.DashLockEnabled       = VD.DashLockEnabled or false
VD.DashLockDuration      = VD.DashLockDuration or 1.5
VD.DashLockSmoothness    = VD.DashLockSmoothness or 0.3
VD.FreezeDuringDashLock  = VD.FreezeDuringDashLock or false
VD._DashLockActive       = false
VD._DashLockTarget       = nil
VD._DashLockConnection   = nil-- HELPERS
local function TeamIs(plr, role)
    if not plr or not plr.Team or not plr.Team.Name then return false end
    local tn = string.lower(plr.Team.Name)
    if role == "Killer" then return string.find(tn, "killer", 1, true) ~= nil end
    if role == "Survivor" then return string.find(tn, "survivor", 1, true) ~= nil end
    return false
end
local function GetRole()
    if TeamIs(LocalPlayer, "Killer") then return "Killer" end
    if TeamIs(LocalPlayer, "Survivor") then return "Survivor" end
    return nil
end

-- FLOATING TOGGLE
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
    Instance.new("UICorner", MainButton).CornerRadius = UDim.new(1, 0)

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

    MainButton.MouseButton1Click:Connect(function()
        Library:Toggle()
    end)
    Library:MakeDraggable(MainButton, MainButton, true)
end
CreatePazzToggle(TOGGLE_ICON)

-- WINDOW
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

-- WATERMARK
local Watermark = Library:AddDraggableLabel("PAZZHUB")
local Stats = game:GetService("Stats")
local FPS, Frames, LastTick = 0, 0, tick()
RunService.RenderStepped:Connect(function()
    Frames += 1
    if tick() - LastTick >= 1 then
        FPS = Frames; Frames = 0; LastTick = tick()
        local Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        Watermark:SetText(string.format("PAZZHUB | FPS: %d | PING: %d ms", FPS, Ping))
    end
end)

-- TABS
local Tabs = {
    Survivor = Window:AddTab("Survivor", "user"),
    Visuals  = Window:AddTab("Visuals", "eye"),
    Killer   = Window:AddTab("Killer", "swords"),
    Misc     = Window:AddTab("Misc", "wrench"),
    Troll    = Window:AddTab("Troll", "ghost"),
    Config   = Window:AddTab("Config", "settings"),
}-- SURVIVOR TAB GROUPBOXES
local SurvL  = Tabs.Survivor:AddLeftGroupbox("Survivor", "user")
local SurvR  = Tabs.Survivor:AddRightGroupbox("Abilities", "zap")
local SurvL2 = Tabs.Survivor:AddLeftGroupbox("Auto Gen", "cog")
local SurvR2 = Tabs.Survivor:AddRightGroupbox("Extras", "star")

-- AUTO CROUCH DODGE
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
        while tick() - startT < 1.2 do
            pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
            task.wait(0.1)
        end
        pcall(function() char:SetAttribute("Crouching", false) end)
        pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", false) end)
        if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end) end
    end)
end

SurvL:AddToggle("AutoCrouchDodge", {
    Text = "Auto Crouch Dodge",
    Default = false,
    Callback = function(v) VD.AutoCrouch = v end,
})

local DodgeAttached = {}
local function AttachCrouchSensor(kChar)
    if not kChar or DodgeAttached[kChar] then return end
    DodgeAttached[kChar] = true
    local humanoid = kChar:FindFirstChild("Humanoid")
    if not humanoid then humanoid = kChar:WaitForChild("Humanoid", 5); if not humanoid then return end end
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then animator = humanoid:WaitForChild("Animator", 5); if not animator then return end end
    animator.AnimationPlayed:Connect(function(track)
        local animId = track.Animation and track.Animation.AnimationId or ""
        local id = animId:match("%d+")
        if id == "80411309607666" and VD.AutoCrouch then
            TriggerCrouch()
        end
    end)
end
local function TryAttachCrouch(p)
    if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
        AttachCrouchSensor(p.Character)
    end
end
for _, p in ipairs(Players:GetPlayers()) do
    p.CharacterAdded:Connect(function() TryAttachCrouch(p) end)
    TryAttachCrouch(p)
end
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function() TryAttachCrouch(p) end)
end)

-- AUTO FLEE
local lastAutoFlee = 0
task.spawn(function()
    while true do
        task.wait(0.1)
        if VD.SURV_AutoFlee and GetRole() == "Survivor" then
            local now = tick()
            if now - lastAutoFlee >= VD.SURV_AutoFleeCooldown then
                local myChar = LocalPlayer.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if myRoot and hum and hum.Health > 0 then
                    local killerRoot, nearest = nil, math.huge
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr ~= LocalPlayer and TeamIs(plr, "Killer") and plr.Character then
                            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local d = (hrp.Position - myRoot.Position).Magnitude
                                if d < nearest then nearest = d; killerRoot = hrp end
                            end
                        end
                    end
                    if killerRoot and nearest <= VD.SURV_AutoFleeDist then
                        lastAutoFlee = now
                        local bestPt, bestDist = nil, 0
                        local mf = Workspace:FindFirstChild("Map")
                        if mf then
                            for _, obj in ipairs(mf:GetDescendants()) do
                                if obj:IsA("BasePart") and string.find(obj.Name, "^GeneratorPoint%d+$") then
                                    local d = (obj.Position - killerRoot.Position).Magnitude
                                    if d > bestDist then bestDist = d; bestPt = obj end
                                end
                            end
                        end
                        if bestPt then
                            pcall(function() myRoot.CFrame = bestPt.CFrame + Vector3.new(0, 5, 0) end)
                        end
                    end
                end
            end
        end
    end
end)-- ═══ AUTO PARRY V1 (SIMPLE) ═══
local ParryState = {
    LastParry = 0, ActiveAttackers = {},
    CircleFolder = nil, CircleDashes = {}, CircleRotCFs = {}, CircleOffsets = {},
    CircleRadius = 0, CircleBuiltForDagger = false,
    CircleLastX = math.huge, CircleLastY = math.huge, CircleLastZ = math.huge,
    CircleSpawnTime = 0, CircleSpawnDuration = 0.55,
}
local ParryCooldown = {
    OnCooldown = false, CooldownEnd = 0,
    WaitingForResult = false, WaitingStart = 0, WaitTimeout = 2.0,
    FallbackCooldown = 60, MaxCooldown = 90, LastFiredAt = 0,
    IsSilenced = false, JustFired = false, ManualDetect = false, ManualIgnoreWindow = 0.35
}
local parryResultRemote, parryFireRemote
pcall(function()
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local items = remotes and remotes:FindFirstChild("Items")
    local dagger = items and items:FindFirstChild("Parrying Dagger")
    if dagger then
        parryResultRemote = dagger:FindFirstChild("parryResult")
        parryFireRemote = dagger:FindFirstChild("parry")
    end
end)
local KillerAttackAnims = {
    ["78432063483146"]="attack",["121216847022485"]="attack",["74968262036854"]="attack",
    ["132817836308238"]="attack",["82666958311998"]="attack",["111920872708571"]="attack",
    ["106871536134254"]="attack",["109402730355822"]="attack",["130593238885843"]="attack",
    ["138720291317243"]="attack",["139369275981139"]="attack",["133963973694098"]="attack",
    ["78935059863801"]="attack",
    ["118907603246885"]="lungehold",["135002183282873"]="lungehold",["113255068724446"]="lungehold",
    ["129784271201071"]="lungehold",["105374834496520"]="lungehold",["117070354890871"]="lungehold",
    ["115244153053858"]="lungehold",["110355011987939"]="lungehold",["117042998468241"]="lungehold",
    ["122812055447896"]="lungehold"
}
local function ParryStartCooldown(d)
    d = math.clamp(tonumber(d) or 0, 0, ParryCooldown.MaxCooldown)
    if d <= 0 then d = ParryCooldown.FallbackCooldown end
    ParryCooldown.OnCooldown = true
    ParryCooldown.CooldownEnd = os.clock() + d
    ParryCooldown.WaitingForResult = false
    ParryCooldown.JustFired = false
    ParryCooldown.ManualDetect = false
end
local function ParryClearCooldown()
    ParryCooldown.OnCooldown = false
    ParryCooldown.CooldownEnd = 0
    ParryCooldown.WaitingForResult = false
    ParryCooldown.JustFired = false
    ParryCooldown.ManualDetect = false
end
local function ParryIsOnCooldown()
    if not ParryCooldown.OnCooldown then return false end
    if os.clock() >= ParryCooldown.CooldownEnd then ParryClearCooldown(); return false end
    return true
end
if parryResultRemote then
    parryResultRemote.OnClientEvent:Connect(function(success, cd)
        if not ParryCooldown.WaitingForResult and not ParryCooldown.JustFired then return end
        local c = tonumber(cd) or 0
        if success and c > 0 then ParryStartCooldown(math.min(c, ParryCooldown.MaxCooldown))
        else ParryStartCooldown(ParryCooldown.FallbackCooldown) end
    end)
end

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

local function ParryExecute()
    if not ParryIsEquippedDagger() then return end
    if ParryCooldown.IsSilenced or ParryIsOnCooldown() or ParryCooldown.WaitingForResult then return end
    ParryCooldown.LastFiredAt = os.clock()
    ParryCooldown.WaitingForResult = true
    ParryCooldown.WaitingStart = os.clock()
    ParryCooldown.JustFired = true
    if VD.PARRY_SilentParry and parryFireRemote then
        pcall(function() parryFireRemote:FireServer() end)
    elseif VirtualInputManager then
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 2, true, game, 0)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 2, false, game, 0)
        end)
    end
end

local function ParryGetAnimType(track)
    if not track or not track.Animation then return nil end
    local animId = track.Animation.AnimationId or ""
    local numId = animId:match("%d+") or ""
    local name = string.lower(track.Animation.Name or "")
    local v = KillerAttackAnims[animId] or (numId ~= "" and KillerAttackAnims[numId])
    if v then return v end
    if string.find(name, "lunge", 1, true) or string.find(name, "charge", 1, true) then return "lungehold" end
    if string.find(name, "attack", 1, true) or string.find(name, "slash", 1, true) then return "attack" end
    return nil
end

local function ParryHookKiller(p)
    if p == LocalPlayer then return end
    local function hook(char)
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3)
        if not anim then return end
        anim.AnimationPlayed:Connect(function(track)
            if not VD.PARRY_Enabled then return end
            if not ParryIsEquippedDagger() then return end
            local at = ParryGetAnimType(track)
            if at then
                ParryState.ActiveAttackers[p] = { char = char, track = track, type = at }
                local myChar = LocalPlayer.Character
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local kHRP = char:FindFirstChild("HumanoidRootPart")
                if myHRP and kHRP then
                    local dist = (myHRP.Position - kHRP.Position).Magnitude
                    if dist <= VD.PARRY_Distance then
                        ParryExecute()
                    end
                end
            end
        end)
    end
    if p.Character then hook(p.Character) end
    p.CharacterAdded:Connect(function(char) task.wait(0.5); hook(char) end)
end
for _, p in ipairs(Players:GetPlayers()) do ParryHookKiller(p) end
Players.PlayerAdded:Connect(ParryHookKiller)

-- ═══ AUTO PARRY V2 (WISNU) ═══
do
    local W_VALID_PARRY_IDS = {
        ["122812055447896"]="Veil lunge",["133963973694098"]="Mayers Basic",
        ["117042998468241"]="Mayers lunge",["135002183282873"]="cure lunge",
        ["121216847022485"]="cure Basic",["132817836308238"]="Jeff Basic",
        ["129784271201071"]="Jeff lunge",["82666958311998"]="Jeff Frenzy",
        ["78432063483146"]="Abyssal Basic",["118907603246885"]="Abyssal lunge",
        ["139369275981139"]="Jason Basic",["110355011987939"]="Jason lunge",
        ["111920872708571"]="Masked Basic",["105374834496520"]="Masked lunge",
        ["138720291317243"]="Masked Tony",["106871536134254"]="Masked Alex",
        ["130593238885843"]="Masked Cobra",["115244153053858"]="Masked Cobra lunge",
        ["74968262036854"]="Hidden Basic",["113255068724446"]="Hidden lunge",
        ["98163597193511"]="Hidden S1",["80411309607666"]="Abyssal S1"
    }
    local W_State = { Cooldown = false, CooldownThread = nil }
    local W_Attached = {}

    local function W_IsDowned(char)
        return char and (char:GetAttribute("Knocked") == true or char:GetAttribute("IsHooked") == true)
    end
    local function W_IsSafeToParry(char)
        if not VD.Wisnu_ParrySafety then return true end
        if not char then return false end
        local ci = char:FindFirstChild("CheckInterractable")
        if ci then
            if ci:GetAttribute("isVaulting") or ci:GetAttribute("isRepairing") or ci:GetAttribute("isUnhooking")
                or ci:GetAttribute("isHealing") or ci:GetAttribute("isSliding") then return false end
        end
        return true
    end
    local function W_ExecuteParry()
        if W_State.Cooldown then return end
        if parryFireRemote then
            pcall(function() for i = 1, 10 do parryFireRemote:FireServer() end end)
        end
    end
    if parryResultRemote then
        parryResultRemote.OnClientEvent:Connect(function(arg1, arg2)
            local cdDur = tonumber(arg2) or ((arg1 == true) and 90 or 60)
            W_State.Cooldown = true
            if W_State.CooldownThread then task.cancel(W_State.CooldownThread) end
            W_State.CooldownThread = task.delay(cdDur, function() W_State.Cooldown = false end)
        end)
    end

    local function W_AttachSensor(kChar)
        if not kChar or W_Attached[kChar] then return end
        W_Attached[kChar] = true
        local hum = kChar:FindFirstChild("Humanoid")
        if not hum then hum = kChar:WaitForChild("Humanoid", 5); if not hum then return end end
        local anim = hum:FindFirstChildOfClass("Animator")
        if not anim then anim = hum:WaitForChild("Animator", 5); if not anim then return end end
        anim.AnimationPlayed:Connect(function(track)
            local animId = track.Animation and track.Animation.AnimationId or ""
            local id = animId:match("%d+")
            local attackName = W_VALID_PARRY_IDS[id]
            if not attackName then return end
            if id == "80411309607666" and VD.AutoCrouch then
                TriggerCrouch(); return
            end
            if not VD.Wisnu_AutoParry then return end
            if W_State.Cooldown then return end
            if VD.Wisnu_IgnoredSkills and VD.Wisnu_IgnoredSkills[attackName] then return end
            local myChar = LocalPlayer.Character
            if W_IsDowned(myChar) or not W_IsSafeToParry(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if not myHRP or not kHRP then return end
            local dist = (myHRP.Position - kHRP.Position).Magnitude
            if VD.Wisnu_ParryAggressive then
                if dist <= 12 then W_ExecuteParry() end
            else
                if dist > VD.Wisnu_ParryDistance then return end
                W_ExecuteParry()
            end
        end)
    end
    local function W_TryAttach(p)
        if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then W_AttachSensor(p.Character) end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        p.CharacterAdded:Connect(function() W_TryAttach(p) end)
        W_TryAttach(p)
    end
    Players.PlayerAdded:Connect(function(p)
        p.CharacterAdded:Connect(function() W_TryAttach(p) end)
    end)
end-- ═══ SWIFT VAULT ═══
do
    local _vaultedWindows = {}
    local _lastVaultScan = 0
    local function BuildWindowGroups()
        local groups = {}
        local map = Workspace:FindFirstChild("Map")
        if not map then return groups end
        local seen = {}
        local function addPart(part)
            if not part or seen[part] then return end
            seen[part] = true
            local rootWindow = part.Parent
            if part.Name == "VaultPoint" and part.Parent and part.Parent.Name == "VaultTrigger" then
                rootWindow = part.Parent.Parent
            elseif part.Name == "VaultTrigger" then
                rootWindow = part.Parent
            end
            if rootWindow then
                groups[rootWindow] = groups[rootWindow] or {}
                table.insert(groups[rootWindow], part)
            end
        end
        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name == "VaultTrigger" or obj.Name == "VaultPoint") then
                addPart(obj)
            end
        end
        return groups
    end
    local function GetVTPosition(vt)
        if not vt then return nil end
        if vt:IsA("BasePart") then return vt.Position end
        if vt:IsA("Model") then
            if vt.PrimaryPart then return vt.PrimaryPart.Position end
            local bp = vt:FindFirstChildWhichIsA("BasePart", true)
            if bp then return bp.Position end
        end
        return nil
    end
    RunService.Heartbeat:Connect(function()
        if VD.SURV_FastVault then
            pcall(function()
                local char = LocalPlayer.Character
                if char then char:SetAttribute("vaultspeed", (VD.SURF_VaultSpeed or 13) / 10) end
            end)
        end
    end)
    RunService.Heartbeat:Connect(function()
        if not VD.SURV_AutoVault then return end
        if GetRole() ~= "Survivor" then return end
        if tick() - _lastVaultScan < 0.15 then return end
        _lastVaultScan = tick()
        pcall(function()
            local char = LocalPlayer.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not myRoot or not hum or hum.Health <= 0 then return end
            local vel = myRoot.AssemblyLinearVelocity
            if vel.Magnitude < 1 then return end
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            local winFolder = remotes and remotes:FindFirstChild("Window")
            local vaultEv = winFolder and winFolder:FindFirstChild("VaultCommit")
            if not vaultEv then return end
            local windowGroups = BuildWindowGroups()
            for rootWindow, parts in pairs(windowGroups) do
                local allVTs = {}
                for _, child in ipairs(rootWindow:GetChildren()) do
                    if child.Name == "VaultTrigger" then table.insert(allVTs, child) end
                end
                if #allVTs == 0 then continue end
                local nearestVT, nearestVTDist = nil, math.huge
                for _, vt in ipairs(allVTs) do
                    local pos = GetVTPosition(vt)
                    if pos then
                        local d = (myRoot.Position - pos).Magnitude
                        if d < nearestVTDist then nearestVTDist = d; nearestVT = vt end
                    end
                end
                if not nearestVT or nearestVTDist > 6.0 then continue end
                local lastUsed = _vaultedWindows[rootWindow] or 0
                if tick() - lastUsed < 3.0 then continue end
                local winFold = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Window")
                if winFold then
                    local vaultEvent = winFold:FindFirstChild("VaultEvent")
                    local fastvault = winFold:FindFirstChild("fastvault")
                    local vaultComplete = winFold:FindFirstChild("VaultCompleteEvent")
                    if vaultEvent then pcall(function() vaultEvent:FireServer(nearestVT, true) end) end
                    if fastvault then pcall(function() fastvault:FireServer(LocalPlayer) end) end
                    if vaultComplete then pcall(function() vaultComplete:FireServer(nearestVT, false) end) end
                end
                _vaultedWindows[rootWindow] = tick()
                break
            end
        end)
    end)
    LocalPlayer.CharacterAdded:Connect(function() task.wait(0.5); _vaultedWindows = {} end)
end

-- ═══ PALLET REFLEX ═══
do
    local _lastPalletDrop = 0
    local _usedPallets = {}
    local function GetKillerRoot()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and TeamIs(plr, "Killer") and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then return hrp end
            end
        end
        return nil
    end
    local function GetAllPallets()
        local list = {}
        local map = Workspace:FindFirstChild("Map")
        if not map then return list end
        for _, obj in ipairs(map:GetDescendants()) do
            if obj.Name == "Palletwrong" and (obj:IsA("Model") or obj:IsA("Folder")) then
                table.insert(list, obj)
            end
        end
        return list
    end
    RunService.Heartbeat:Connect(function()
        if not VD.SURV_AutoPallet then return end
        if GetRole() ~= "Survivor" then return end
        local now = tick()
        if now - _lastPalletDrop < 2.5 then return end
        pcall(function()
            local char = LocalPlayer.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not myRoot or not hum or hum.Health <= 0 then return end
            local killerRoot = GetKillerRoot()
            if not killerRoot then return end
            if (myRoot.Position - killerRoot.Position).Magnitude > VD.SURV_AutoPalletDist then return end
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            local palletFold = remotes and remotes:FindFirstChild("Pallet")
            local dropEvent = palletFold and palletFold:FindFirstChild("PalletDropEvent")
            if not dropEvent then return end
            local bestPallet, bestDist = nil, 8
            for _, pal in ipairs(GetAllPallets()) do
                if not _usedPallets[pal] then
                    local refPart = pal:FindFirstChild("PalletPoint") or pal:FindFirstChild("PalletPointSlide") or pal:FindFirstChildWhichIsA("BasePart", true)
                    if refPart then
                        local d = (myRoot.Position - refPart.Position).Magnitude
                        if d < bestDist then bestDist = d; bestPallet = pal end
                    end
                end
            end
            if bestPallet then
                local fireTarget = bestPallet:FindFirstChild("PalletPointSlide") or bestPallet:FindFirstChild("PalletPoint")
                if fireTarget then
                    pcall(function() dropEvent:FireServer(fireTarget) end)
                    _usedPallets[bestPallet] = true
                    _lastPalletDrop = tick()
                end
            end
        end)
    end)
    end-- ═══ FAKE PARRY V2 ═══
do
    local FakeParryTrack = nil
    local FakeParryLast = 0
    local FakeParryAnims = {
        ["Enten"]       = "rbxassetid://127096285501517",
        ["Stopwatch"]   = "rbxassetid://81793464499285",
        ["Fih"]         = "rbxassetid://123307242865945",
        ["BloodShield"] = "rbxassetid://75939529748815",
    }
    local function FakeParry_Stop()
        if FakeParryTrack then pcall(function() FakeParryTrack:Stop(0.05) end); FakeParryTrack = nil end
    end
    local function FakeParry_Play()
        if not VD.SURV_FakeParry then return end
        if GetRole() ~= "Survivor" then return end
        local now = tick()
        if now - FakeParryLast < (tonumber(VD.SURV_FakeParryCooldown) or 0.4) then return end
        FakeParryLast = now
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local animator = hum:FindFirstChildOfClass("Animator")
        if not animator then animator = Instance.new("Animator"); animator.Parent = hum end
        FakeParry_Stop()
        local animId = FakeParryAnims[VD.SURV_FakeParryAnim] or FakeParryAnims["Enten"]
        pcall(function()
            local anim = Instance.new("Animation")
            anim.AnimationId = animId
            local track = animator:LoadAnimation(anim)
            track.Priority = Enum.AnimationPriority.Action4
            track.Looped = false
            track:Play(0.1)
            FakeParryTrack = track
        end)
    end
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        local kc = Enum.KeyCode[VD.SURV_FakeParryKey or "V"]
        if kc and input.KeyCode == kc then FakeParry_Play() end
    end)
    getgenv().FakeParry_Play = FakeParry_Play
end

-- ═══ DASH LOCK ═══
do
    local DashAnimationId = "rbxassetid://98163597193511"
    local function DashLock_Update()
        if not VD.DashLockEnabled or not VD._DashLockActive then return end
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then VD._DashLockTarget = nil; return end
        local target, targetDist = nil, math.huge
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and TeamIs(player, "Survivor") then
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if root and hum and hum.Health > 0 then
                        local dist = (myRoot.Position - root.Position).Magnitude
                        if dist < targetDist then targetDist = dist; target = root end
                    end
                end
            end
        end
        if not target then VD._DashLockTarget = nil; return end
        VD._DashLockTarget = target
        local cam = Workspace.CurrentCamera
        if cam then
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Position), VD.DashLockSmoothness or 0.3)
        end
    end
    local function DashLock_SetActive(active)
        active = active and true or false
        if active == VD._DashLockActive then return end
        VD._DashLockActive = active
        if active then
            if not VD._DashLockConnection then
                VD._DashLockConnection = RunService.RenderStepped:Connect(function() pcall(DashLock_Update) end)
            end
        else
            if VD._DashLockConnection then
                pcall(function() VD._DashLockConnection:Disconnect() end)
                VD._DashLockConnection = nil
            end
            VD._DashLockTarget = nil
        end
    end
    local function DashLock_HookCharacter(char)
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 5)
        if not anim then return end
        anim.AnimationPlayed:Connect(function(track)
            if not VD.DashLockEnabled then return end
            local aid = track.Animation and track.Animation.AnimationId or ""
            if aid == DashAnimationId then
                DashLock_SetActive(true)
                task.delay(VD.DashLockDuration or 1.5, function() DashLock_SetActive(false) end)
            end
        end)
    end
    if LocalPlayer.Character then DashLock_HookCharacter(LocalPlayer.Character) end
    LocalPlayer.CharacterAdded:Connect(function(c) task.wait(0.5); DashLock_HookCharacter(c) end)
        end-- ═══ NO FALL DAMAGE ═══
do
    local FallHookInstalled = false
    task.spawn(function()
        pcall(function()
            local mt = getrawmetatable and getrawmetatable(game)
            if not mt then return end
            local oldNamecall = mt.__namecall
            if setreadonly then setreadonly(mt, false) end
            mt.__namecall = newcclosure(function(self, ...)
                if not checkcaller() and VD.NoFallDamage then
                    local method = getnamecallmethod()
                    if method == "FireServer" then
                        local ok, name = pcall(function() return self.Name end)
                        if ok and name == "Fall" then
                            local par = self.Parent
                            if par and par.Name == "Mechanics" then return nil end
                        end
                    end
                end
                return oldNamecall(self, ...)
            end)
            if setreadonly then setreadonly(mt, true) end
        end)
    end)
end

-- ═══ MANUAL / AUTO GENERATOR ═══
do
    local RepairEvent = nil
    pcall(function() RepairEvent = ReplicatedStorage.Remotes.Generator.RepairEvent end)
    local ManualThread, AutoThread = nil, nil
    local ManualPoint, AutoPoint = nil, nil
    local LastFire = 0

    local function GetNearestKillerDist()
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil, math.huge end
        local best, dist = nil, math.huge
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= LocalPlayer and TeamIs(pl, "Killer") and pl.Character then
                local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local d = (hrp.Position - myRoot.Position).Magnitude
                    if d < dist then dist = d; best = hrp end
                end
            end
        end
        return best, dist
    end
    local function GetNearestGenPointInReach()
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local bestPt, bestDist = nil, 5.5
        local mf = Workspace:FindFirstChild("Map")
        if not mf then return nil end
        for _, obj in ipairs(mf:GetDescendants()) do
            if obj:IsA("BasePart") and string.find(obj.Name, "GeneratorPoint") then
                local d = (obj.Position - myRoot.Position).Magnitude
                if d < bestDist then bestDist = d; bestPt = obj end
            end
        end
        return bestPt
    end

    local function StartManual()
        if ManualThread then task.cancel(ManualThread) end
        ManualThread = task.spawn(function()
            while VD.ManualGen do
                local myChar = LocalPlayer.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then task.wait(0.2); continue end
                local _, kd = GetNearestKillerDist()
                if kd <= VD.KillerEscapeDist then
                    if ManualPoint then
                        pcall(function() RepairEvent:FireServer(ManualPoint, false) end)
                        ManualPoint = nil
                    end
                    task.wait(0.3); continue
                end
                local pt = GetNearestGenPointInReach()
                if pt then
                    ManualPoint = pt
                    local now = tick()
                    if now - LastFire >= 0.5 then
                        pcall(function() RepairEvent:FireServer(pt, true) end)
                        LastFire = now
                    end
                else
                    if ManualPoint then pcall(function() RepairEvent:FireServer(ManualPoint, false) end); ManualPoint = nil end
                end
                task.wait(0.1)
            end
        end)
    end
    local function StartAuto()
        if AutoThread then task.cancel(AutoThread) end
        AutoThread = task.spawn(function()
            while VD.AutoGen do
                local myChar = LocalPlayer.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then task.wait(0.3); continue end
                local _, kd = GetNearestKillerDist()
                if kd <= VD.KillerEscapeDist then
                    task.wait(0.3); continue
                end
                if not AutoPoint or not AutoPoint.Parent then
                    AutoPoint = GetNearestGenPointInReach()
                end
                if AutoPoint then
                    local now = tick()
                    if now - LastFire >= 0.5 then
                        pcall(function() RepairEvent:FireServer(AutoPoint, true) end)
                        LastFire = now
                    end
                end
                task.wait(0.1)
            end
        end)
    end
    getgenv().ManualGen_SetEnabled = function(v)
        VD.ManualGen = v
        if v then StartManual() else if ManualThread then task.cancel(ManualThread); ManualThread = nil end end
    end
    getgenv().AutoGen_SetEnabled = function(v)
        VD.AutoGen = v
        if v then StartAuto() else if AutoThread then task.cancel(AutoThread); AutoThread = nil end end
    end
            end-- ═══════════════ SURVIVOR UI BINDING ═══════════════

-- AUTO CROUCH + FLEE
SurvL:AddToggle("SurvAutoFlee", {
    Text = "Auto Flee Killer",
    Default = false,
    Callback = function(v) VD.SURV_AutoFlee = v end,
})
SurvL:AddSlider("SurvAutoFleeDist", {
    Text = "Flee Detect Distance",
    Default = 40, Min = 15, Max = 150, Rounding = 5,
    Suffix = " studs",
    Callback = function(v) VD.SURV_AutoFleeDist = v end,
})
SurvL:AddSlider("SurvAutoFleeCd", {
    Text = "Flee Cooldown",
    Default = 1.5, Min = 0.5, Max = 10, Rounding = 1,
    Suffix = "s",
    Callback = function(v) VD.SURV_AutoFleeCooldown = v end,
})

-- AUTO PARRY V1
SurvR:AddToggle("ParryV1", {
    Text = "Auto Parry V1",
    Default = false,
    Callback = function(v) VD.PARRY_Enabled = v end,
})
SurvR:AddToggle("ParryV1Aggr", {
    Text = "Aggressive Mode",
    Default = false,
    Callback = function(v) VD.PARRY_Aggressive = v end,
})
SurvR:AddSlider("ParryV1Dist", {
    Text = "Parry Distance",
    Default = 10, Min = 4, Max = 30, Rounding = 1,
    Callback = function(v) VD.PARRY_Distance = v end,
})
SurvR:AddToggle("ParryV1Silent", {
    Text = "Silent Parry",
    Default = false,
    Callback = function(v) VD.PARRY_SilentParry = v end,
})

-- AUTO PARRY V2 (WISNU)
SurvR:AddToggle("ParryV2", {
    Text = "Auto Parry V2 (Wisnu)",
    Default = false,
    Callback = function(v) VD.Wisnu_AutoParry = v end,
})
SurvR:AddToggle("ParryV2Aggr", {
    Text = "V2 Aggressive",
    Default = false,
    Callback = function(v) VD.Wisnu_ParryAggressive = v end,
})
SurvR:AddToggle("ParryV2Safe", {
    Text = "V2 Safety Check",
    Default = false,
    Callback = function(v) VD.Wisnu_ParrySafety = v end,
})
SurvR:AddSlider("ParryV2Dist", {
    Text = "V2 Distance",
    Default = 6, Min = 4, Max = 25, Rounding = 1,
    Callback = function(v) VD.Wisnu_ParryDistance = v end,
})

-- SWIFT VAULT
SurvL2:AddToggle("SwiftVault", {
    Text = "Swift Vault (Auto)",
    Default = false,
    Callback = function(v) VD.SURV_AutoVault = v end,
})
SurvL2:AddToggle("SwiftVaultV2", {
    Text = "Swift Vault V2",
    Default = false,
    Callback = function(v) VD.SURV_FastVault = v end,
})
SurvL2:AddSlider("VaultSpeed", {
    Text = "Vault Speed",
    Default = 13, Min = 10, Max = 20, Rounding = 1,
    Callback = function(v) VD.SURF_VaultSpeed = v end,
})

-- PALLET REFLEX
SurvL2:AddToggle("PalletReflex", {
    Text = "Pallet Reflex",
    Default = false,
    Callback = function(v) VD.SURV_AutoPallet = v end,
})
SurvL2:AddSlider("PalletDist", {
    Text = "Pallet Trigger Distance",
    Default = 20, Min = 5, Max = 50, Rounding = 1,
    Suffix = " studs",
    Callback = function(v) VD.SURV_AutoPalletDist = v end,
})

-- MANUAL / AUTO GEN
SurvL2:AddToggle("ManualGen", {
    Text = "Manual Generator",
    Default = false,
    Callback = function(v) getgenv().ManualGen_SetEnabled(v) end,
})
SurvL2:AddToggle("AutoGen", {
    Text = "Auto Generator",
    Default = false,
    Callback = function(v) getgenv().AutoGen_SetEnabled(v) end,
})
SurvL2:AddSlider("KillerEscapeDist", {
    Text = "Killer Escape Distance",
    Default = 30, Min = 10, Max = 80, Rounding = 5,
    Suffix = " studs",
    Callback = function(v) VD.KillerEscapeDist = v end,
})

-- FAKE PARRY
SurvR2:AddToggle("FakeParry", {
    Text = "Fake Parry",
    Default = false,
    Callback = function(v) VD.SURV_FakeParry = v end,
})
SurvR2:AddDropdown("FakeParryAnim", {
    Values = { "Enten", "Stopwatch", "Fih", "BloodShield" },
    Default = "Enten",
    Text = "Animation",
    Callback = function(v) VD.SURV_FakeParryAnim = v end,
})
SurvR2:AddSlider("FakeParryCd", {
    Text = "Cooldown",
    Default = 0.4, Min = 0, Max = 3, Rounding = 0.1,
    Suffix = "s",
    Callback = function(v) VD.SURV_FakeParryCooldown = v end,
})
SurvR2:AddButton({
    Text = "Test Fake Parry",
    Func = function()
        if getgenv().FakeParry_Play then getgenv().FakeParry_Play() end
    end,
})

-- NO FALL DAMAGE
SurvR2:AddToggle("NoFallDmg", {
    Text = "No Fall Damage",
    Default = false,
    Callback = function(v) VD.NoFallDamage = v end,
})

-- DASH LOCK
SurvR2:AddToggle("DashLock", {
    Text = "Dash Lock",
    Default = false,
    Callback = function(v) VD.DashLockEnabled = v end,
})
SurvR2:AddSlider("DashLockDur", {
    Text = "Dash Lock Duration",
    Default = 1.5, Min = 0.5, Max = 5, Rounding = 0.1,
    Suffix = "s",
    Callback = function(v) VD.DashLockDuration = v end,
})
SurvR2:AddSlider("DashLockSmooth", {
    Text = "Dash Smoothness",
    Default = 0.3, Min = 0.05, Max = 1, Rounding = 0.05,
    Callback = function(v) VD.DashLockSmoothness = v end,
})

-- ═══════════════ THEME & SAVE ═══════════════
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
ThemeManager:SetFolder("PazzHub")
SaveManager:SetFolder("PazzHub/configs")
SaveManager:BuildConfigSection(Tabs.Config)
ThemeManager:ApplyToTab(Tabs.Config)

Library:Notify({
    Title = "PAZZHUB Loaded",
    Content = "Survivor tab udah fungsional!",
    Duration = 4
})
print("[PAZZHUB] v4 loaded — Survivor tab aktif.")
