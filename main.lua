-- [[PART 1/20]] PAZZHUB v2
-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB — Survivor + Killer Edition v2
--  Floating button bulat + icon PAZZHUB
--  Auto Parry V1 & V2 dipisah
--  DPI 100 default
-- ═══════════════════════════════════════════════════════════════════

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

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
local SoundService      = game:GetService("SoundService")
local LocalPlayer       = Players.LocalPlayer

local VirtualInputManager
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

local W = getgenv()
W.VD = W.VD or {}
local VD = W.VD
W.NotifyEnabled = true

-- PAZZHUB CONSTANT
local PAZZ_LOGO = 72845574620852
local ACCENT = Color3.fromRGB(0, 170, 255)
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ═══════════════ SURVIVOR DEFAULTS ═══════════════
VD.AutoCrouch = VD.AutoCrouch or false
VD.SURV_AutoFlee         = VD.SURV_AutoFlee or false
VD.SURV_AutoFleeDist     = VD.SURV_AutoFleeDist or 40
VD.SURV_AutoFleeCooldown = VD.SURV_AutoFleeCooldown or 1.5
VD.PARRY_Enabled     = VD.PARRY_Enabled or false
VD.PARRY_Aggressive  = VD.PARRY_Aggressive or false
VD.PARRY_Distance    = VD.PARRY_Distance or 10
VD.PARRY_ShowCircle  = VD.PARRY_ShowCircle or false
VD.PARRY_SilentParry = VD.PARRY_SilentParry or false
VD.PARRY_ShowFloatBtn= VD.PARRY_ShowFloatBtn or false
VD.Wisnu_AutoParry       = VD.Wisnu_AutoParry or false
VD.Wisnu_ParryAggressive = VD.Wisnu_ParryAggressive or false
VD.Wisnu_ParrySafety     = VD.Wisnu_ParrySafety or false
VD.Wisnu_ParryDistance   = VD.Wisnu_ParryDistance or 6
VD.Wisnu_ParryFace       = VD.Wisnu_ParryFace or 0.7
VD.Wisnu_ParryCircle     = VD.Wisnu_ParryCircle or true
VD.Wisnu_IgnoredSkills   = VD.Wisnu_IgnoredSkills or {}
VD.SURV_AutoVault  = VD.SURV_AutoVault or false
VD.SURV_FastVault  = VD.SURV_FastVault or false
VD.SURF_VaultSpeed = VD.SURF_VaultSpeed or 13
VD.SURV_AutoPallet     = VD.SURV_AutoPallet or false
VD.SURV_AutoPalletDist = VD.SURV_AutoPalletDist or 20
VD.SURV_FakeParry         = VD.SURV_FakeParry or false
VD.SURV_FakeParryAnim     = VD.SURV_FakeParryAnim or "Enten"
VD.SURV_FakeParryCooldown = VD.SURV_FakeParryCooldown or 0.4
VD.SURV_FakeParryKey      = VD.SURV_FakeParryKey or "V"
VD.SURV_FakeParryShowBtn  = VD.SURV_FakeParryShowBtn or false
VD.NoFallDamage   = VD.NoFallDamage or false
VD.NextMapPredict = VD.NextMapPredict or false
VD.ManualGen        = VD.ManualGen or false
VD.AutoGen          = VD.AutoGen or false
VD.KillerEscapeDist = VD.KillerEscapeDist or 30
VD.TOF_SilentAim    = VD.TOF_SilentAim or false
VD.TOF_TargetMode   = VD.TOF_TargetMode or "Killer"
VD.TOF_Key          = VD.TOF_Key or "Q"
VD.TOF_Laser        = VD.TOF_Laser ~= false
VD.TOF_WallCheck    = VD.TOF_WallCheck ~= false
VD.TOF_BlockKnocked = VD.TOF_BlockKnocked ~= false
VD.FLASH_SilentAim  = VD.FLASH_SilentAim or false
VD.FLASH_Laser      = VD.FLASH_Laser ~= false
VD.FLASH_TargetPart = VD.FLASH_TargetPart or "Head"
VD.FLASH_Range      = VD.FLASH_Range or 120
VD.FLASH_Smooth     = VD.FLASH_Smooth or 0.35
VD.DashLockEnabled      = VD.DashLockEnabled or false
VD.DashLockDuration     = VD.DashLockDuration or 1.5
VD.DashLockSmoothness   = VD.DashLockSmoothness or 0.3
VD.FreezeDuringDashLock = VD.FreezeDuringDashLock or false
VD._DashLockActive      = false
VD._DashLockTarget      = nil
VD._DashLockConnection  = nil

-- ═══════════════ KILLER DEFAULTS ═══════════════
VD.KILLER_AutoAttack         = VD.KILLER_AutoAttack or false
VD.KILLER_AutoAttackRange    = VD.KILLER_AutoAttackRange or 12
VD.KILLER_AutoAttackCooldown = VD.KILLER_AutoAttackCooldown or 0.15
VD.KILLER_BypassLeap     = VD.KILLER_BypassLeap or false
VD.KILLER_InfGrab        = VD.KILLER_InfGrab or false
VD.KILLER_InfLakeMist    = VD.KILLER_InfLakeMist or false
VD.KILLER_InfPursuit     = VD.KILLER_InfPursuit or false
VD.KILLER_BypassCooldown = VD.KILLER_BypassCooldown or false
VD.KILLER_InfFrenzy      = VD.KILLER_InfFrenzy or false
VD.KILLER_AntiBlind      = VD.KILLER_AntiBlind or false
VD.KILLER_DestroyPallets = VD.KILLER_DestroyPallets or false
VD.KILLER_InfLunge       = VD.KILLER_InfLunge or false
VD.KILLER_AutoHook       = VD.KILLER_AutoHook or false
VD.KA_AutoStalk     = VD.KA_AutoStalk or false
VD.KA_AutoStalkRange= VD.KA_AutoStalkRange or 150
VD.KA_AutoKillAll   = VD.KA_AutoKillAll or false
VD.KA_DropAllPallet = VD.KA_DropAllPallet or false
VD.KA_BlockAllVault = VD.KA_BlockAllVault or false
VD.VeilEnabled        = VD.VeilEnabled or false
VD.VeilShowFOV        = VD.VeilShowFOV ~= false
VD.VeilShowTracker    = VD.VeilShowTracker or false
VD.VeilAutoPredict    = VD.VeilAutoPredict ~= false
VD.VeilFOV            = VD.VeilFOV or 150
VD.VeilMaxDist        = VD.VeilMaxDist or 280
VD.VeilSpearSpeed     = VD.VeilSpearSpeed or 165
VD.VeilGravity        = VD.VeilGravity or 103
VD.VeilAuraSpearSpeed = VD.VeilAuraSpearSpeed or 165
VD.VeilAuraSpearGravity = VD.VeilAuraSpearGravity or 96
VD.VeilLeadMultiplier = VD.VeilLeadMultiplier or 1.4
VD.SPEAR_Aimbot  = VD.SPEAR_Aimbot or false
VD.SPEAR_Gravity = VD.SPEAR_Gravity or 50
VD.SPEAR_Speed   = VD.SPEAR_Speed or 100
VD.FLASK_SilentAim   = VD.FLASK_SilentAim or false
VD.FLASK_ShowBeam    = VD.FLASK_ShowBeam ~= false
VD.FLASK_ShowLanding = VD.FLASK_ShowLanding ~= false
VD.FLASK_Predict     = VD.FLASK_Predict ~= false
VD.FLASK_Speed       = VD.FLASK_Speed or 90
VD.FLASK_Gravity     = VD.FLASK_Gravity or 196
VD.FLASK_LeadMult    = VD.FLASK_LeadMult or 1.0
VD.FLASK_Range       = VD.FLASK_Range or 200
VD.FLASK_BeamColor   = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255)
VD.FLASK_AccentColor = VD.FLASK_AccentColor or Color3.fromRGB(25, 25, 25)
VD.Invis_Enabled      = VD.Invis_Enabled or false
VD.Invis_ShowFloatBtn = VD.Invis_ShowFloatBtn or false
VD.Invis_Hotkey       = VD.Invis_Hotkey or "G"
VD.CursorEnabled      = VD.CursorEnabled or false
VD.KillerPerksDisplay = VD.KillerPerksDisplay or false
VD.SpeedBoostEnabled  = VD.SpeedBoostEnabled or false
VD.SpeedBoostValue    = VD.SpeedBoostValue or 30

-- ═══════════════ MISC STATE ═══════════════
W.TrollTeleport = W.TrollTeleport or {
    Enabled = false, IsProcessing = false, TriggerCount = 0,
    BlockedAnimList = { ["123812278891591"] = 1, ["74099023522626"] = 2 },
    CharHook = nil,
}
W.Escape = W.Escape or { Enabled = false, FinishLineName = "fininshline", TeleportCount = 0 }
W.Masked = W.Masked or { CurrentPower = "Cobra", Powers = {"Cobra", "Richter", "Brandon", "Rabbit", "Alex", "Tony"} }
W.MyersGrabData = W.MyersGrabData or { Enabled = false, HotkeyCode = Enum.KeyCode.H }
W.SelfUnhook = W.SelfUnhook or {
    Enabled=false, Following=false, FollowDuration=30, FollowDistance=20,
    MonitorConn=nil, TriggerCount=0, _lastTrigger=0, _cooldown=3,
    _hookPos=nil, _hookCFrame=nil, _activeThread=nil, _wasHooked=false
}
getgenv().GlutoInvis = getgenv().GlutoInvis or {
    Enabled = false, Loading = false, Ready = false, API = nil,
    _lastToggle = 0, _retries = 0, _retryMax = 3,
    _retryDelay = 2, _queueState = nil,
}-- [[PART 2/20]]

-- ═══════════════ TEAM HELPER ═══════════════
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
W.TeamIs = TeamIs
W.GetRole = GetRole

-- ═══════════════ NOTIFY ═══════════════
W.PazzNotify = function(title, content, duration)
    pcall(function()
        Library:Notify({
            Title = title or "PAZZHUB",
            Content = content or "",
            Duration = duration or 3
        })
    end)
end

-- ═══════════════ DOWNED CHECK ═══════════════
function W.IsDowned(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local state = char:GetAttribute("State")
    return state == "Downed" or state == "Dead"
end

-- ═══════════════ SELF HEAL API ═══════════════
function W.doSelfHealTrue()
    local c = LocalPlayer.Character
    if not c then return end
    local hr = ReplicatedStorage.Remotes.Healing.HealEvent
    local hp = c:FindFirstChild("HumanoidRootPart")
    if not hp then return end
    pcall(function() hr:FireServer(hp, true) end)
end
function W.doSelfHealFalse()
    local c = LocalPlayer.Character
    if not c then return end
    local hr = ReplicatedStorage.Remotes.Healing.HealEvent
    local hp = c:FindFirstChild("HumanoidRootPart")
    if not hp then return end
    pcall(function() hr:FireServer(hp, false) end)
end
function W.doOthersHealTrue(tp)
    if not tp or not tp.Character then return end
    local hrp = tp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local hr = ReplicatedStorage.Remotes.Healing.HealEvent
    pcall(function() hr:FireServer(hrp, true) end)
end
function W.doOthersHealFalse(tp)
    if not tp or not tp.Character then return end
    local hrp = tp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local hr = ReplicatedStorage.Remotes.Healing.HealEvent
    pcall(function() hr:FireServer(hrp, false) end)
end

-- ═══════════════ GENERATOR HELPER ═══════════════
W.GB_GetAllGenerators = function()
    local gens = {}
    local mf = Workspace:FindFirstChild("Map")
    if mf then
        for _, obj in ipairs(mf:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Generator" then
                local real = obj:GetAttribute("RepairProgress") ~= nil
                          or obj:GetAttribute("kickcount") ~= nil
                          or obj:GetAttribute("ProgressRepair") ~= nil
                if real then table.insert(gens, obj) end
            end
        end
    end
    return gens
end

W.GB_GetPoints = function(m)
    local pts = {}
    if m then
        for _, o in ipairs(m:GetChildren()) do
            if o:IsA("BasePart") and string.find(o.Name, "GeneratorPoint") then
                table.insert(pts, o)
            end
        end
    end
    return pts
end-- [[PART 3/20]]

-- ═══════════════ TEMA PAZZHUB ═══════════════
Library.Scheme.AccentColor     = Color3.fromRGB(0, 170, 255)
Library.Scheme.BackgroundColor = Color3.fromRGB(8, 14, 26)
Library.Scheme.MainColor       = Color3.fromRGB(16, 24, 42)
Library.Scheme.OutlineColor    = Color3.fromRGB(0, 120, 200)
Library.Scheme.FontColor       = Color3.fromRGB(200, 230, 255)

-- ═══════════════ FLOATING TOGGLE PAZZHUB (logo) ═══════════════
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
    MainButton.Size = UDim2.fromOffset(46, 46)
    MainButton.Position = UDim2.fromOffset(15, 120)
    MainButton.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
    MainButton.BackgroundTransparency = 0.05
    MainButton.Parent = ScreenGui
    Instance.new("UICorner", MainButton).CornerRadius = UDim.new(1, 0)

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = ACCENT
    Stroke.Thickness = 1.6
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Transparency = 0.1
    Stroke.Parent = MainButton

    local Glow = Instance.new("UIStroke")
    Glow.Color = ACCENT
    Glow.Thickness = 5
    Glow.Transparency = 0.6
    Glow.Parent = MainButton

    local IconFrame = Instance.new("Frame")
    IconFrame.Size = UDim2.fromScale(0.72, 0.72)
    IconFrame.Position = UDim2.fromScale(0.14, 0.14)
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
            Size = UDim2.fromOffset(40, 40)
        }):Play()
        task.wait(.08)
        TweenService:Create(MainButton, TweenInfo.new(.08), {
            Size = UDim2.fromOffset(46, 46)
        }):Play()
        Library:Toggle()
    end)
    Library:MakeDraggable(MainButton, MainButton, true)
end
CreatePazzToggle(PAZZ_LOGO)

-- ═══════════════ WINDOW (BESAR + DPI 100) ═══════════════
local Window = Library:CreateWindow({
    Title = "PAZZHUB",
    Footer = "PazzHub",
    Icon = PAZZ_LOGO,
    IconSize = UDim2.fromOffset(38, 38),
    CornerRadius = 14,
    NotifySide = "Right",
    ShowCustomCursor = true,
    ShowMobileButtons = false,
    ToggleKeybind = Enum.KeyCode.LeftControl,
    Size = UDim2.fromOffset(560, 360),   -- ✅ Lebih gede
    EnableSidebarResize = false,
    EnableCompacting = true,
    SidebarCompacted = true,
})

-- ✅ DPI Default 100
Library:SetDPIScale(100)

-- ═══════════════ WATERMARK ═══════════════
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
end)-- [[PART 4/20]]

-- ═══════════════ TABS ═══════════════
local Tabs = {
    Survivor = Window:AddTab("Survivor", "user"),
    Killer   = Window:AddTab("Killer", "swords"),
    Misc     = Window:AddTab("Misc", "wrench"),
    Troll    = Window:AddTab("Troll", "ghost"),
    Config   = Window:AddTab("Config", "settings"),
}

print("[PAZZHUB] Tabs created.")

-- ═══════════════ SURVIVOR GROUPBOXES ═══════════════
local SurvMainL   = Tabs.Survivor:AddLeftGroupbox("Main", "user")
local SurvMainR   = Tabs.Survivor:AddRightGroupbox("Auto Flee", "footprints")
local SurvParryV1 = Tabs.Survivor:AddLeftGroupbox("Auto Parry V1", "shield")
local SurvParryV2 = Tabs.Survivor:AddRightGroupbox("Auto Parry V2", "shield-check")
local SurvExtra   = Tabs.Survivor:AddLeftGroupbox("Extras", "star")
local SurvExtra2  = Tabs.Survivor:AddRightGroupbox("More", "zap")

-- ═══════════════ KILLER GROUPBOXES ═══════════════
local KilCombat   = Tabs.Killer:AddLeftGroupbox("Combat", "crosshair")
local KilBypass   = Tabs.Killer:AddRightGroupbox("Bypass", "zap")
local KilAimbot   = Tabs.Killer:AddLeftGroupbox("Silent Aimbot", "target")
local KilAbil     = Tabs.Killer:AddRightGroupbox("Abilities", "star")

-- ═══════════════ MISC GROUPBOXES ═══════════════
local MiscUtil   = Tabs.Misc:AddLeftGroupbox("Utility", "wrench")
local MiscFloats = Tabs.Misc:AddRightGroupbox("Floating Buttons", "layout")

-- ═══════════════ TROLL GROUPBOXES ═══════════════
local TrollFun    = Tabs.Troll:AddLeftGroupbox("Funny", "ghost")
local TrollBombax = Tabs.Troll:AddRightGroupbox("Bombax", "music")

-- ═══════════════ CONFIG GROUPBOXES ═══════════════
local CfgMain  = Tabs.Config:AddLeftGroupbox("Settings", "wrench")
local CfgTheme = Tabs.Config:AddRightGroupbox("Theme", "palette")-- [[PART 5/20]]

-- ═══════════════ AUTO CROUCH DODGE (ID 80411309607666) ═══════════════
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
            local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local mob = pg and pg:FindFirstChild("Survivor-mob")
            local ct = mob and mob:FindFirstChild("Controls")
            local btn = ct and ct:FindFirstChild("crouch")
            if btn then firesignal(btn.MouseButton1Click) end
        end)
        while tick() - startT < 1.2 do
            pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
            task.wait(0.1)
        end
        pcall(function() char:SetAttribute("Crouching", false) end)
        pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", false) end)
        if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end) end
        pcall(function()
            local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local mob = pg and pg:FindFirstChild("Survivor-mob")
            local ct = mob and mob:FindFirstChild("Controls")
            local btn = ct and ct:FindFirstChild("crouch")
            if btn then firesignal(btn.MouseButton1Click) end
        end)
    end)
end
W.TriggerCrouch = TriggerCrouch

local DodgeAttached = {}
local function AttachParrySensor(kChar)
    if not kChar or DodgeAttached[kChar] then return end
    DodgeAttached[kChar] = true
    local humanoid = kChar:FindFirstChild("Humanoid")
    if not humanoid then humanoid = kChar:WaitForChild("Humanoid", 5); if not humanoid then return end end
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then animator = humanoid:WaitForChild("Animator", 5); if not animator then return end end
    humanoid.ChildAdded:Connect(function(child)
        if child:IsA("Animator") then DodgeAttached[kChar] = nil; AttachParrySensor(kChar) end
    end)
    kChar.AncestryChanged:Connect(function(_, parent)
        if not parent then DodgeAttached[kChar] = nil end
    end)
    animator.AnimationPlayed:Connect(function(track)
        local animId = track.Animation and track.Animation.AnimationId or ""
        local id = animId:match("%d+")
        if id == "80411309607666" and VD.AutoCrouch then
            local myChar = LocalPlayer.Character
            if W.IsDowned(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if myHRP and kHRP then
                if (myHRP.Position - kHRP.Position).Magnitude <= 40 then TriggerCrouch() end
            end
        end
    end)
end
local function TryAttachCrouch(p)
    if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then AttachParrySensor(p.Character) end
end
local function SetupPlayerCrouch(p)
    if p == LocalPlayer then return end
    p.CharacterAdded:Connect(function() TryAttachCrouch(p) end)
    p:GetPropertyChangedSignal("Team"):Connect(function() TryAttachCrouch(p) end)
    if p.Character then TryAttachCrouch(p) end
end
for _, p in pairs(Players:GetPlayers()) do SetupPlayerCrouch(p) end
Players.PlayerAdded:Connect(SetupPlayerCrouch)

-- ═══════════════ AUTO FLEE LOGIC ═══════════════
local lastAutoFlee = 0
function W.SURV_AutoFlee_Do()
    if not VD.SURV_AutoFlee then return end
    if GetRole() ~= "Survivor" then return end
    local now = tick()
    if now - lastAutoFlee < (VD.SURV_AutoFleeCooldown or 1.5) then return end
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not myRoot or not hum or hum.Health <= 0 then return end
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
    if not killerRoot then return end
    if nearest > (VD.SURV_AutoFleeDist or 40) then return end
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
        W.PazzNotify("Auto Flee", "Teleported away!", 2)
    end
end
task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(W.SURV_AutoFlee_Do)
    end
end)

-- ═══════════════ FLOATING BUTTON TOGGLE: SELF HEAL ═══════════════
SurvMainL:AddToggle("AutoCrouchDodge", {
    Text = "Auto Crouch Dodge",
    Default = false,
    Callback = function(v) VD.AutoCrouch = v end,
})
SurvMainL:AddDivider()
SurvMainL:AddToggle("ShowSelfHealBtn", {
    Text = "Show Self Heal Button",
    Default = false,
    Callback = function(v)
        if W.Gluto_SHB_SetEnabled then W.Gluto_SHB_SetEnabled(v) end
    end,
})

-- ═══════════════ AUTO FLEE UI + TOGGLE BUTTON ═══════════════
SurvMainR:AddToggle("SurvAutoFlee", {
    Text = "Auto Flee Killer",
    Default = false,
    Callback = function(v) VD.SURV_AutoFlee = v end,
})
SurvMainR:AddSlider("SurvFleeDist", {
    Text = "Flee Distance",
    Default = 40, Min = 15, Max = 150, Rounding = 5,
    Suffix = " studs",
    Callback = function(v) VD.SURV_AutoFleeDist = v end,
})
SurvMainR:AddSlider("SurvFleeCd", {
    Text = "Flee Cooldown",
    Default = 1.5, Min = 0.5, Max = 10, Rounding = 1,
    Suffix = "s",
    Callback = function(v) VD.SURV_AutoFleeCooldown = v end,
})
SurvMainR:AddDivider()
SurvMainR:AddToggle("ShowSelfUnhookBtn", {
    Text = "Show Self Unhook Button",
    Default = false,
    Callback = function(v)
        if W.Gluto_SUB_SetEnabled then W.Gluto_SUB_SetEnabled(v) end
    end,
})-- [[PART 6/20]]

-- ═══════════════ AUTO PARRY V1 STATE ═══════════════
local ParryState = {
    LastParry = 0, ActiveAttackers = {},
    CircleFolder = nil, CircleDashes = {}, CircleRotCFs = {}, CircleOffsets = {},
    CircleRadius = 0, CircleBuiltForDagger = false,
    CircleLastX = math.huge, CircleLastY = math.huge, CircleLastZ = math.huge,
    CircleSpawnTime = 0, CircleSpawnDuration = 0.55,
}
W.ParryState = ParryState

local ParryCooldown = {
    OnCooldown = false, CooldownEnd = 0,
    WaitingForResult = false, WaitingStart = 0, WaitTimeout = 2.0,
    FallbackCooldown = 60, MaxCooldown = 90, LastFiredAt = 0,
    IsSilenced = false, JustFired = false, ManualDetect = false, ManualIgnoreWindow = 0.35
}

-- ═══════════════ PARRY REMOTES ═══════════════
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
W.parryFireRemote = parryFireRemote

-- ═══════════════ KILLER ANIM IDS (ASLI) ═══════════════
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
W.KillerAttackAnims = KillerAttackAnims

-- ═══════════════ PARRY COOLDOWN SYSTEM ═══════════════
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
W.ParryIsEquippedDagger = ParryIsEquippedDagger

-- ═══════════════ BUSY CHECK ═══════════════
local ParryCheckAttrs = {"isVaulting","isSliding","isDroppingPallet","isRepairing","isHealing","isUnhooking","isExiting"}
local ParryCharCache = { Char=nil, Root=nil, Hum=nil, UpperTorso=nil, CheckInt=nil }
local function ParryGetCharCache()
    local char = LocalPlayer.Character
    if char ~= ParryCharCache.Char then
        ParryCharCache.Char = char
        ParryCharCache.Root = nil; ParryCharCache.Hum = nil
        ParryCharCache.UpperTorso = nil; ParryCharCache.CheckInt = nil
    end
    if not char then return ParryCharCache end
    if not ParryCharCache.Root then ParryCharCache.Root = char:FindFirstChild("HumanoidRootPart") end
    if not ParryCharCache.Hum then ParryCharCache.Hum = char:FindFirstChildOfClass("Humanoid") end
    if not ParryCharCache.UpperTorso then
        ParryCharCache.UpperTorso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    end
    if not ParryCharCache.CheckInt then ParryCharCache.CheckInt = char:FindFirstChild("CheckInterractable") end
    return ParryCharCache
end

local function ParryIsBusy()
    local cc = ParryGetCharCache()
    if not cc.Char then return true end
    if LocalPlayer:GetAttribute("IsDead") then return true end
    if cc.Char:GetAttribute("IsCarried") then return true end
    if cc.Char:GetAttribute("IsHooked") then return true end
    if cc.Root and CollectionService:HasTag(cc.Root, "doing action") then return true end
    if cc.CheckInt then
        for i = 1, #ParryCheckAttrs do
            if cc.CheckInt:GetAttribute(ParryCheckAttrs[i]) then return true end
        end
    end
    return false
end

local function ParryIsLowHealth()
    local hum = ParryGetCharCache().Hum
    if not hum then return false end
    return hum.Health < hum.MaxHealth * 0.5
end

local function ParryCanFire()
    if not ParryIsEquippedDagger() then return false end
    if ParryCooldown.IsSilenced then return false end
    if ParryIsOnCooldown() then return false end
    if ParryCooldown.WaitingForResult then return false end
    if ParryIsBusy() then return false end
    if ParryIsLowHealth() then return false end
    return true
end

-- ═══════════════ PARRY EXECUTE ═══════════════
local function ParryExecuteMobile()
    local didFire = false
    local pGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if pGui and type(firesignal) == "function" then
        local mobRoot = pGui:FindFirstChild("Survivor-mob")
        local controls = mobRoot and mobRoot:FindFirstChild("Controls")
        if controls then
            for _, n in ipairs({"Gui-mob","action","Gui-mobile","Gui_mob","Parry","parry"}) do
                local btn = controls:FindFirstChild(n)
                if btn and btn:IsA("GuiButton") then
                    pcall(function()
                        firesignal(btn.MouseButton1Down)
                        task.delay(0.05, function()
                            if btn and btn.Parent then
                                firesignal(btn.MouseButton1Up)
                                firesignal(btn.MouseButton1Click)
                            end
                        end)
                    end)
                    didFire = true
                    break
                end
            end
        end
    end
    if not didFire then
        if parryFireRemote then pcall(function() parryFireRemote:FireServer() end) end
    end
end

local function ParryExecutePC()
    if not VirtualInputManager then return end
    pcall(function()
        VirtualInputManager:SendMouseMoveEvent(0, 0, game)
        task.wait(0.005)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 2, true, game, 0)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 2, false, game, 0)
    end)
end

local function ParryExecuteSilent()
    if parryFireRemote then return pcall(function() parryFireRemote:FireServer() end) end
    return false
end

local function ParryExecute()
    if not ParryCanFire() then return end
    ParryState.LastParry = os.clock()
    ParryCooldown.LastFiredAt = os.clock()
    ParryCooldown.WaitingForResult = true
    ParryCooldown.WaitingStart = os.clock()
    ParryCooldown.JustFired = true
    ParryCooldown.ManualDetect = false
    if VD.PARRY_SilentParry then
        ParryExecuteSilent()
        return
    end
    if isMobile then ParryExecuteMobile() else ParryExecutePC() end
end
W.ParryExecute = ParryExecute

-- ═══════════════ MANUAL PARRY ═══════════════
local function ParryMarkManual()
    if not ParryIsEquippedDagger() then return end
    if ParryCooldown.IsSilenced then return end
    if os.clock() - ParryCooldown.LastFiredAt < ParryCooldown.ManualIgnoreWindow then return end
    if ParryCooldown.OnCooldown or ParryCooldown.WaitingForResult then return end
    ParryCooldown.WaitingForResult = true
    ParryCooldown.WaitingStart = os.clock()
    ParryCooldown.JustFired = true
    ParryCooldown.ManualDetect = true
    ParryCooldown.LastFiredAt = os.clock()
end
UserInputService.InputBegan:Connect(function(input, gp)
    if input.UserInputType ~= Enum.UserInputType.MouseButton2 then return end
    if gp then return end
    ParryMarkManual()
end)-- [[PART 7/20]]

-- ═══════════════ HOOK MOBILE PARRY BUTTON ═══════════════
local parryHookedButtons = setmetatable({}, {__mode = "k"})
local function ParryTryHookMobileButton(inst)
    if not inst or not inst:IsA("GuiButton") then return end
    if parryHookedButtons[inst] then return end
    local nm = inst.Name
    if nm ~= "Gui-mob" and nm ~= "action" and nm ~= "Gui-mobile"
        and nm ~= "Gui_mob" and nm ~= "Parry" and nm ~= "parry" then return end
    parryHookedButtons[inst] = true
    inst.MouseButton1Down:Connect(ParryMarkManual)
end
local function ParryScanForMobileButtons(root)
    if not root then return end
    for _, d in ipairs(root:GetDescendants()) do ParryTryHookMobileButton(d) end
end
local function ParryAttachPlayerGui(pGui)
    if not pGui then return end
    ParryScanForMobileButtons(pGui)
    pGui.DescendantAdded:Connect(ParryTryHookMobileButton)
end
local existingPGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
if existingPGui then ParryAttachPlayerGui(existingPGui) end
LocalPlayer.ChildAdded:Connect(function(c)
    if c:IsA("PlayerGui") then ParryAttachPlayerGui(c) end
end)

-- ═══════════════ ANIM TYPE DETECTOR ═══════════════
local function ParryGetAnimType(track)
    if not track or not track.Animation then return nil end
    local animId = track.Animation.AnimationId or ""
    local numId = animId:match("%d+") or ""
    local name = string.lower(track.Animation.Name or "")
    local v = KillerAttackAnims[animId]
    if v then return v end
    if numId ~= "" then v = KillerAttackAnims[numId]; if v then return v end end
    if string.find(name, "lunge", 1, true) or string.find(name, "charge", 1, true) then return "lungehold" end
    if string.find(name, "attack", 1, true) or string.find(name, "slash", 1, true)
        or string.find(name, "swing", 1, true) or string.find(name, "stab", 1, true)
        or string.find(name, "melee", 1, true) then return "attack" end
    return nil
end

-- ═══════════════ HOOK KILLER ANIMATOR ═══════════════
local function ParryHookAnimatorOnChar(plr, char)
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
            ParryState.ActiveAttackers[plr] = {
                char = char, track = track, type = at, registeredAt = os.clock()
            }
        end
    end)
end

local function ParryHookKillerPlayer(plr)
    if plr == LocalPlayer then return end
    if plr.Character then ParryHookAnimatorOnChar(plr, plr.Character) end
    plr.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        ParryHookAnimatorOnChar(plr, char)
    end)
end
for _, p in ipairs(Players:GetPlayers()) do ParryHookKillerPlayer(p) end
Players.PlayerAdded:Connect(ParryHookKillerPlayer)

-- ═══════════════ POLL ATTACKS ═══════════════
local parryLastPoll = 0
local function ParryPollAttacks()
    if not VD.PARRY_Enabled or not ParryIsEquippedDagger() then return end
    local now = os.clock()
    if now - parryLastPoll < 0.15 then return end
    parryLastPoll = now
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local char = plr.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                        local at = ParryGetAnimType(track)
                        if at then
                            local ex = ParryState.ActiveAttackers[plr]
                            if not ex or ex.track ~= track then
                                ParryState.ActiveAttackers[plr] = {
                                    char = char, track = track, type = at, registeredAt = now
                                }
                            end
                        end
                    end
                end
            end
        end
    end
end

local parryLastCleanup = 0
local function ParryCleanupAttackers()
    local now = os.clock()
    if now - parryLastCleanup < 1.0 then return end
    parryLastCleanup = now
    for plr, data in pairs(ParryState.ActiveAttackers) do
        if not plr or not plr.Parent or not data.track or not data.track.IsPlaying then
            ParryState.ActiveAttackers[plr] = nil
        end
    end
end

-- ═══════════════ CHECK AND PARRY ═══════════════
local function ParryCheckAndParry(killerChar)
    if ParryIsOnCooldown() or ParryCooldown.WaitingForResult
        or ParryCooldown.IsSilenced or not ParryIsEquippedDagger() then return end
    local cc = ParryGetCharCache()
    local myRoot = cc.UpperTorso or cc.Root
    local killerPart = killerChar:FindFirstChild("UpperTorso")
                    or killerChar:FindFirstChild("Torso")
                    or killerChar:FindFirstChild("HumanoidRootPart")
    if not myRoot or not killerPart then return end
    local dist = (myRoot.Position - killerPart.Position).Magnitude
    if VD.PARRY_Aggressive then
        local ping = math.clamp(LocalPlayer:GetNetworkPing(), 0, 0.3)
        local killerRoot = killerChar:FindFirstChild("HumanoidRootPart") or killerPart
        local killerVel = killerRoot.AssemblyLinearVelocity
        local flatVel = Vector3.new(killerVel.X, 0, killerVel.Z)
        local predictedPos = killerPart.Position + flatVel * ping
        local predDist = (myRoot.Position - predictedPos).Magnitude
        if predDist <= ((VD.PARRY_Distance or 10) + 2.5) then
            if flatVel.Magnitude > 6 then
                local dir = myRoot.Position - killerPart.Position
                if dir.Magnitude > 0 and flatVel.Unit:Dot(dir.Unit) > 0.4 then
                    ParryExecute()
                    return
                end
            end
        end
    end
    if dist <= (VD.PARRY_Distance or 10) then ParryExecute() end
end

-- ═══════════════ PARRY RANGE CIRCLE (VISUAL) ═══════════════
local function ParryDestroyCircle()
    if ParryState.CircleFolder then
        pcall(function()
            if ParryState.CircleFolder.Parent then
                ParryState.CircleFolder:Destroy()
            end
        end)
    end
    ParryState.CircleFolder = nil
    ParryState.CircleDashes = {}
    ParryState.CircleRotCFs = {}
    ParryState.CircleOffsets = {}
    ParryState.CircleRadius = 0
    ParryState.CircleBuiltForDagger = false
    ParryState.CircleLastX = math.huge
    ParryState.CircleLastY = math.huge
    ParryState.CircleLastZ = math.huge
    ParryState.CircleSpawnTime = 0
end
getgenv()._Gluto_DestroyParryCircle = ParryDestroyCircle

local function ParryBuildCircle(radius)
    ParryDestroyCircle()
    local folder = Instance.new("Folder")
    folder.Name = "PazzParryCircle"
    local dashCount = math.clamp(math.floor(radius * 6), 24, 120)
    local slotLength = (2 * math.pi * radius) / dashCount
    local dashLength = slotLength * 0.55
    local dashThickness = 0.03
    local dashes, rotCFs, offsets = table.create(dashCount), table.create(dashCount), table.create(dashCount)
    for i = 1, dashCount do
        local part = Instance.new("Part")
        part.Name = "Dash" .. i
        part.Anchored = true
        part.CanCollide = false
        part.CanTouch = false
        part.CanQuery = false
        part.CastShadow = false
        part.Material = Enum.Material.Neon
        part.Color = ACCENT
        part.Transparency = 1
        part.Size = Vector3.new(dashThickness, dashThickness, dashLength)
        part.Parent = folder
        local angle = ((i - 1) / dashCount) * math.pi * 2
        local cosA, sinA = math.cos(angle), math.sin(angle)
        rotCFs[i] = CFrame.lookAt(Vector3.zero, Vector3.new(-sinA, 0, cosA))
        offsets[i] = Vector3.new(cosA * radius, 0, sinA * radius)
        dashes[i] = part
    end
    folder.Parent = Workspace
    ParryState.CircleFolder = folder
    ParryState.CircleDashes = dashes
    ParryState.CircleRotCFs = rotCFs
    ParryState.CircleOffsets = offsets
    ParryState.CircleRadius = radius
    ParryState.CircleBuiltForDagger = true
    ParryState.CircleSpawnTime = tick()
end

local function ParryUpdateCircle(myRoot)
    if not ParryState.CircleFolder or not ParryState.CircleFolder.Parent then return end
    local dashes = ParryState.CircleDashes
    local dashCount = #dashes
    if dashCount == 0 then return end
    local center = myRoot.Position - Vector3.new(0, (myRoot.Size.Y * 0.5) + 1.0, 0)
    local elapsed = tick() - (ParryState.CircleSpawnTime or 0)
    local spawnT = math.clamp(elapsed / (ParryState.CircleSpawnDuration or 0.55), 0, 1)
    local eased = 1 - (1 - spawnT) ^ 3
    local scaleMult = eased
    if spawnT < 0.7 and spawnT > 0 then
        local bt = spawnT / 0.7
        scaleMult = eased + math.sin(bt * math.pi) * 0.1
    end
    local spinRot = (1 - eased) * math.pi * 2
    local spawnAlpha = 1 - eased
    local busy = ParryIsBusy()
    local onCD = ParryCooldown.OnCooldown
    local tc
    if busy then tc = Color3.fromRGB(255, 20, 20)
    elseif onCD then tc = Color3.fromRGB(255, 140, 0)
    else tc = ACCENT end
    local targetT = 0
    if onCD then
        local period = 0.55
        local phase = (os.clock() % period) / period
        local pulse = (math.cos(phase * math.pi * 2) + 1) * 0.5
        targetT = (1 - pulse) * 0.85
    end
    local finalT = math.max(targetT, spawnAlpha)
    local dx = math.abs(center.X - ParryState.CircleLastX)
    local dy = math.abs(center.Y - ParryState.CircleLastY)
    local dz = math.abs(center.Z - ParryState.CircleLastZ)
    if dx < 0.01 and dy < 0.01 and dz < 0.01 and spawnT >= 1 then return end
    ParryState.CircleLastX = center.X
    ParryState.CircleLastY = center.Y
    ParryState.CircleLastZ = center.Z
    local rotCFs = ParryState.CircleRotCFs
    local offsets = ParryState.CircleOffsets
    local rotCF = CFrame.Angles(0, spinRot, 0)
    for i = 1, dashCount do
        local dash = dashes[i]
        if dash and dash.Parent then
            local scaledOff = offsets[i] * scaleMult
            local rotatedOff = rotCF:VectorToWorldSpace(scaledOff)
            local worldPos = Vector3.new(center.X + rotatedOff.X, center.Y, center.Z + rotatedOff.Z)
            dash.CFrame = (rotCF * rotCFs[i]) + worldPos
            dash.Color = tc
            dash.Transparency = finalT
        end
    end
end

local function ParryUpdateCircleLogic()
    local char = LocalPlayer.Character
    local myRoot = char and char:FindFirstChild("HumanoidRootPart")
    if VD.PARRY_ShowCircle and VD.PARRY_Enabled and ParryIsEquippedDagger() and myRoot then
        if not ParryState.CircleFolder or ParryState.CircleRadius ~= (VD.PARRY_Distance or 10)
            or not ParryState.CircleFolder.Parent then
            ParryBuildCircle(VD.PARRY_Distance or 10)
        end
        ParryUpdateCircle(myRoot)
    else
        if ParryState.CircleFolder then ParryDestroyCircle() end
    end
end

-- ═══════════════ MAIN UPDATE LOOP V1 ═══════════════
local function ParryUpdateLogic()
    if not VD.PARRY_Enabled then return end
    if not ParryIsEquippedDagger() then
        ParryState.ActiveAttackers = {}
        return
    end
    if ParryCooldown.WaitingForResult then
        if os.clock() - ParryCooldown.WaitingStart > ParryCooldown.WaitTimeout then
            if ParryCooldown.ManualDetect then
                ParryCooldown.WaitingForResult = false
                ParryCooldown.JustFired = false
                ParryCooldown.ManualDetect = false
            else
                ParryStartCooldown(ParryCooldown.FallbackCooldown)
            end
        end
    end
    if ParryIsOnCooldown() or ParryCooldown.WaitingForResult then return end
    ParryPollAttacks()
    ParryCleanupAttackers()
    for plr, data in pairs(ParryState.ActiveAttackers) do
        if plr and plr.Parent and data.track and data.track.IsPlaying then
            local shouldCheck = false
            if data.type == "attack" then
                if data.track.TimePosition < 0.35 then shouldCheck = true end
            elseif data.type == "lungehold" then
                shouldCheck = true
            end
            if shouldCheck then
                ParryCheckAndParry(data.char)
                if ParryCooldown.WaitingForResult then break end
            end
        else
            ParryState.ActiveAttackers[plr] = nil
        end
    end
end

local parryLastLogic, parryLastCircle = 0, 0
RunService.Heartbeat:Connect(function()
    local now = os.clock()
    if now - parryLastCircle >= 0.033 then
        parryLastCircle = now
        pcall(ParryUpdateCircleLogic)
    end
    if now - parryLastLogic >= 0.05 then
        parryLastLogic = now
        pcall(ParryUpdateLogic)
    end
end)-- [[PART 8/20]]

-- ═══════════════ AUTO PARRY V2 (WISNU) ═══════════════
do
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

    local function W_IsKiller(p)
        return p and p.Team and p.Team.Name == "Killer"
    end
    local function W_IsDowned(char)
        return char and (char:GetAttribute("Knocked") == true or char:GetAttribute("IsHooked") == true)
    end
    local function W_IsSafeToParry(char)
        if not VD.Wisnu_ParrySafety then return true end
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

    local function W_ExecuteParry()
        if W_State.Cooldown then return end
        W_State.lastParry = tick()
        pcall(function()
            if parryFireRemote then
                for i = 1, 10 do parryFireRemote:FireServer() end
            end
        end)
    end

    -- Listen parry result
    task.spawn(function()
        local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
        if not remotes then return end
        local items = remotes:WaitForChild("Items", 5)
        if not items then return end
        local dagger = items:WaitForChild("Parrying Dagger", 5)
        if not dagger then return end
        local pr = dagger:WaitForChild("parryResult", 5)
        if pr then
            pr.OnClientEvent:Connect(function(arg1, arg2)
                local cdDur = tonumber(arg2) or ((arg1 == true) and 90 or 60)
                W_State.Cooldown = true
                if W_State.CooldownThread then task.cancel(W_State.CooldownThread) end
                W_State.CooldownThread = task.delay(cdDur, function()
                    W_State.Cooldown = false
                end)
            end)
        end
    end)

    -- Attach sensor
    local function W_AttachParrySensor(kChar)
        if not kChar or W_Attached[kChar] then return end
        W_Attached[kChar] = true
        local humanoid = kChar:FindFirstChild("Humanoid")
        if not humanoid then
            humanoid = kChar:WaitForChild("Humanoid", 5)
            if not humanoid then return end
        end
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then
            animator = humanoid:WaitForChild("Animator", 5)
            if not animator then return end
        end

        humanoid.ChildAdded:Connect(function(child)
            if child:IsA("Animator") then
                W_Attached[kChar] = nil
                W_AttachParrySensor(kChar)
            end
        end)
        kChar.AncestryChanged:Connect(function(_, parent)
            if not parent then W_Attached[kChar] = nil end
        end)

        animator.AnimationPlayed:Connect(function(track)
            local animId = track.Animation and track.Animation.AnimationId or ""
            local id = animId:match("%d+")
            local attackName = W_VALID_PARRY_IDS[id]
            if not attackName then return end

            -- Auto Crouch trigger (Abyssal S1)
            if id == "80411309607666" and VD.AutoCrouch then
                local myChar = LocalPlayer.Character
                if W_IsDowned(myChar) then return end
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local kHRP = kChar:FindFirstChild("HumanoidRootPart")
                if myHRP and kHRP then
                    if (myHRP.Position - kHRP.Position).Magnitude <= 40 then
                        TriggerCrouch()
                    end
                end
                return
            end

            if not VD.Wisnu_AutoParry then return end
            if W_State.Cooldown then return end
            if VD.Wisnu_IgnoredSkills and VD.Wisnu_IgnoredSkills[attackName] then return end

            local myChar = LocalPlayer.Character
            if W_IsDowned(myChar) or not W_IsSafeToParry(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if not myHRP or not kHRP then return end

            local startDistance = (myHRP.Position - kHRP.Position).Magnitude

            if VD.Wisnu_ParryAggressive then
                local aggressiveRadius = 12
                local detectionRadius = VD.Wisnu_ParryDistance + 5
                if startDistance > detectionRadius then return end
                if startDistance <= aggressiveRadius then
                    W_ExecuteParry()
                else
                    local tracker
                    local startTime = os.clock()
                    tracker = RunService.Heartbeat:Connect(function()
                        if os.clock() - startTime >= 1.5 or W_State.Cooldown
                            or not myHRP or not kHRP or W_IsDowned(myChar) then
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
                if startDistance > VD.Wisnu_ParryDistance then return end
                local myPosFlat = Vector3.new(myHRP.Position.X, 0, myHRP.Position.Z)
                local kPosFlat = Vector3.new(kHRP.Position.X, 0, kHRP.Position.Z)
                local flatDelta = myPosFlat - kPosFlat
                if flatDelta.Magnitude > 0 then
                    local flatDirection = flatDelta.Unit
                    local kLookFlat = Vector3.new(kHRP.CFrame.LookVector.X, 0, kHRP.CFrame.LookVector.Z).Unit
                    if kLookFlat:Dot(flatDirection) < VD.Wisnu_ParryFace then return end
                end
                W_ExecuteParry()
            end
        end)
    end

    local function W_TryAttach(p)
        if p ~= LocalPlayer and W_IsKiller(p) and p.Character then
            W_AttachParrySensor(p.Character)
        end
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

    -- Circle Adornment V2
    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if VD.Wisnu_ParryCircle and VD.Wisnu_AutoParry and hrp then
            if not W_State.Adornment or W_State.Adornment.Parent ~= hrp then
                if W_State.Adornment then W_State.Adornment:Destroy() end
                W_State.Adornment = Instance.new("CylinderHandleAdornment")
                W_State.Adornment.Name = "PazzParryV2Circle"
                W_State.Adornment.Height = 0.05
                W_State.Adornment.Transparency = 0.3
                W_State.Adornment.Adornee = hrp
                W_State.Adornment.Parent = hrp
                W_State.Adornment.ZIndex = 0
                W_State.Adornment.AlwaysOnTop = false
            end
            local cR = VD.Wisnu_ParryDistance
            W_State.Adornment.Radius = cR
            W_State.Adornment.InnerRadius = math.max(0.1, cR - 0.15)
            W_State.Adornment.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(90), 0, 0)
            if W_State.Cooldown then
                W_State.Adornment.Color3 = Color3.fromRGB(128, 128, 128)
            elseif VD.Wisnu_ParryAggressive then
                W_State.Adornment.Color3 = Color3.fromRGB(255, 255, 255)
            else
                W_State.Adornment.Color3 = ACCENT
            end
        elseif W_State.Adornment then
            W_State.Adornment:Destroy()
            W_State.Adornment = nil
        end
    end)
end

-- ═══════════════ PARRY V1 UI (GROUPBOX ATAS) ═══════════════
SurvParryV1:AddToggle("ParryV1Enable", {
    Text = "Enable Auto Parry V1",
    Default = false,
    Callback = function(v) VD.PARRY_Enabled = v end,
})
SurvParryV1:AddToggle("ParryV1Aggr", {
    Text = "Aggressive Mode",
    Default = false,
    Callback = function(v) VD.PARRY_Aggressive = v end,
})
SurvParryV1:AddSlider("ParryV1Dist", {
    Text = "Parry Distance",
    Default = 10, Min = 4, Max = 30, Rounding = 1,
    Callback = function(v) VD.PARRY_Distance = v end,
})
SurvParryV1:AddToggle("ParryV1Silent", {
    Text = "Silent Parry",
    Default = false,
    Callback = function(v) VD.PARRY_SilentParry = v end,
})
SurvParryV1:AddToggle("ParryV1Circle", {
    Text = "Show Range Circle",
    Default = false,
    Callback = function(v)
        VD.PARRY_ShowCircle = v
        if not v and getgenv()._Gluto_DestroyParryCircle then
            pcall(getgenv()._Gluto_DestroyParryCircle)
        end
    end,
})

-- ═══════════════ PARRY V2 UI (GROUPBOX BAWAH) ═══════════════
SurvParryV2:AddToggle("ParryV2Enable", {
    Text = "Enable Auto Parry V2",
    Default = false,
    Callback = function(v) VD.Wisnu_AutoParry = v end,
})
SurvParryV2:AddToggle("ParryV2Aggr", {
    Text = "Aggressive Mode",
    Default = false,
    Callback = function(v) VD.Wisnu_ParryAggressive = v end,
})
SurvParryV2:AddToggle("ParryV2Safe", {
    Text = "Safety Check",
    Default = false,
    Callback = function(v) VD.Wisnu_ParrySafety = v end,
})
SurvParryV2:AddSlider("ParryV2Dist", {
    Text = "Parry Distance",
    Default = 6, Min = 4, Max = 25, Rounding = 1,
    Callback = function(v) VD.Wisnu_ParryDistance = v end,
})
SurvParryV2:AddSlider("ParryV2Face", {
    Text = "Face Sensitivity",
    Default = 0.7, Min = -1, Max = 1, Rounding = 0.05,
    Callback = function(v) VD.Wisnu_ParryFace = v end,
})
SurvParryV2:AddToggle("ParryV2Circle", {
    Text = "Show Range Circle",
    Default = true,
    Callback = function(v) VD.Wisnu_ParryCircle = v end,
})

-- ═══════════════ PARRY BUTTON DI BAWAH V1 ═══════════════
SurvParryV1:AddDivider()
SurvParryV1:AddToggle("ShowParryBtn", {
    Text = "Show Parry Button",
    Default = false,
    Callback = function(v)
        if W.Gluto_ParryBtn_SetEnabled then W.Gluto_ParryBtn_SetEnabled(v) end
    end,
})-- [[PART 9/20]]

-- ═══════════════ SWIFT VAULT ═══════════════
do
    local _vaultedWindows = {}
    local _lastVaultScan = 0

    local function SwiftVault_BuildWindowGroups()
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
                local exists = false
                for _, p in ipairs(groups[rootWindow]) do
                    if p == part then exists = true; break end
                end
                if not exists then table.insert(groups[rootWindow], part) end
            end
        end
        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name == "VaultTrigger" or obj.Name == "VaultPoint") then
                addPart(obj)
            end
        end
        return groups
    end

    local function SwiftVault_GetVTPosition(vt)
        if not vt then return nil end
        if vt:IsA("BasePart") then return vt.Position end
        if vt:IsA("Model") then
            if vt.PrimaryPart then return vt.PrimaryPart.Position end
            local bp = vt:FindFirstChildWhichIsA("BasePart", true)
            if bp then return bp.Position end
        end
        return nil
    end

    -- Custom vault speed
    RunService.Heartbeat:Connect(function()
        if VD.SURV_FastVault then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    char:SetAttribute("vaultspeed", (VD.SURF_VaultSpeed or 13) / 10)
                end
            end)
        end
    end)

    -- Auto Vault
    RunService.Heartbeat:Connect(function()
        if not VD.SURV_AutoVault then return end
        if GetRole() ~= "Survivor" then return end
        if tick() - _lastVaultScan < 0.15 then return end
        _lastVaultScan = tick()

        pcall(function()
            local char   = LocalPlayer.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            local hum    = char and char:FindFirstChildOfClass("Humanoid")
            if not myRoot or not hum or hum.Health <= 0 then return end

            local vel = myRoot.AssemblyLinearVelocity
            if vel.Magnitude < 1 then return end

            local remotes   = ReplicatedStorage:FindFirstChild("Remotes")
            local winFolder = remotes and remotes:FindFirstChild("Window")
            local vaultEv   = winFolder and winFolder:FindFirstChild("VaultCommit")
            if not vaultEv then return end

            local windowGroups = SwiftVault_BuildWindowGroups()

            for rootWindow, parts in pairs(windowGroups) do
                local allVTs = {}
                for _, child in ipairs(rootWindow:GetChildren()) do
                    if child.Name == "VaultTrigger" then table.insert(allVTs, child) end
                end
                if #allVTs == 0 then continue end

                local nearestVT, nearestVTDist = nil, math.huge
                for _, vt in ipairs(allVTs) do
                    local pos = SwiftVault_GetVTPosition(vt)
                    if pos then
                        local d = (myRoot.Position - pos).Magnitude
                        if d < nearestVTDist then
                            nearestVTDist = d
                            nearestVT = vt
                        end
                    end
                end
                if not nearestVT or nearestVTDist > 6.0 then continue end

                local lastUsed = _vaultedWindows[rootWindow] or 0
                if tick() - lastUsed < 3.0 then continue end

                local finalTarget = nearestVT
                local remotes2 = ReplicatedStorage:FindFirstChild("Remotes")
                local winFold  = remotes2 and remotes2:FindFirstChild("Window")
                if winFold and finalTarget then
                    local vaultEvent     = winFold:FindFirstChild("VaultEvent")
                    local vaultBindable  = winFold:FindFirstChild("Vaultbindable")
                    local fastvault      = winFold:FindFirstChild("fastvault")
                    local vaultComplete1 = winFold:FindFirstChild("VaultCompleteEventpart1")
                    local vaultComplete  = winFold:FindFirstChild("VaultCompleteEvent")
                    if vaultEvent    then pcall(function() vaultEvent:FireServer(finalTarget, true) end) end
                    if vaultBindable then pcall(function() vaultBindable:Fire(finalTarget, true) end) end
                    if fastvault     then pcall(function() fastvault:FireServer(LocalPlayer) end) end
                    if vaultComplete1 then pcall(function() vaultComplete1:FireServer() end) end
                    if vaultComplete  then pcall(function() vaultComplete:FireServer(finalTarget, false) end) end
                end
                _vaultedWindows[rootWindow] = tick()
                break
            end
        end)
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        _vaultedWindows = {}
    end)
end

-- ═══════════════ PALLET REFLEX ═══════════════
do
    local _lastPalletDrop = 0
    local _usedPallets    = {}

    local function Pallet_GetKillerRoot()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and TeamIs(plr, "Killer") and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then return hrp end
            end
        end
        return nil
    end

    local function Pallet_GetAllPallets()
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

    local function Pallet_IsDropped(palletModel)
        if not palletModel or not palletModel.Parent then return true end
        if _usedPallets[palletModel] then return true end
        local ok, destroyed = pcall(function() return palletModel:GetAttribute("Destroyed") end)
        if ok and destroyed == true then return true end
        local ok2, broken = pcall(function() return palletModel:GetAttribute("Broken") end)
        if ok2 and broken == true then return true end
        if not palletModel:FindFirstChildWhichIsA("BasePart", true) then return true end
        return false
    end

    local function Pallet_GetPointSlide(model)
        local slide = model:FindFirstChild("PalletPointSlide")
        if slide then return slide end
        for _, child in ipairs(model:GetDescendants()) do
            if child.Name == "PalletPointSlide" then return child end
        end
        return model:FindFirstChild("PalletPoint")
    end

    local _lastPalletScan = 0
    RunService.Heartbeat:Connect(function()
        if not VD.SURV_AutoPallet then return end
        if GetRole() ~= "Survivor" then return end
        local now = tick()
        if now - _lastPalletScan < 0.2 then return end
        _lastPalletScan = now
        if now - _lastPalletDrop < 2.5 then return end

        pcall(function()
            local char   = LocalPlayer.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            local hum    = char and char:FindFirstChildOfClass("Humanoid")
            if not myRoot or not hum or hum.Health <= 0 then return end

            local killerRoot = Pallet_GetKillerRoot()
            if not killerRoot then return end
            if (myRoot.Position - killerRoot.Position).Magnitude > (VD.SURV_AutoPalletDist or 20) then return end

            local remotes    = ReplicatedStorage:FindFirstChild("Remotes")
            local palletFold = remotes and remotes:FindFirstChild("Pallet")
            local dropEvent  = palletFold and palletFold:FindFirstChild("PalletDropEvent")
            if not dropEvent then return end

            local bestPallet, bestDist = nil, 8
            for _, pal in ipairs(Pallet_GetAllPallets()) do
                if not Pallet_IsDropped(pal) then
                    local refPart = pal:FindFirstChild("PalletPoint")
                        or pal:FindFirstChild("PalletPointSlide")
                        or pal:FindFirstChildWhichIsA("BasePart", true)
                    if refPart then
                        local d = (myRoot.Position - refPart.Position).Magnitude
                        if d < bestDist then
                            bestDist = d
                            bestPallet = pal
                        end
                    end
                end
            end

            if bestPallet then
                local fireTarget = Pallet_GetPointSlide(bestPallet)
                if fireTarget then
                    pcall(function() dropEvent:FireServer(fireTarget) end)
                    _usedPallets[bestPallet] = true
                    _lastPalletDrop = tick()
                end
            end
        end)
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        _usedPallets = {}
    end)
end

-- ═══════════════ FAKE PARRY ═══════════════
do
    local FakeParryTrack = nil
    local FakeParryLast  = 0

    local FakeParryAnims = {
        ["Enten"]       = "rbxassetid://127096285501517",
        ["Stopwatch"]   = "rbxassetid://81793464499285",
        ["Fih"]         = "rbxassetid://123307242865945",
        ["BloodShield"] = "rbxassetid://75939529748815",
    }

    local function FakeParry_Stop()
        if FakeParryTrack then
            pcall(function() FakeParryTrack:Stop(0.05) end)
            FakeParryTrack = nil
        end
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
        if not animator then
            animator = Instance.new("Animator")
            animator.Parent = hum
        end

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
            task.delay(2, function()
                if FakeParryTrack == track then FakeParry_Stop() end
            end)
        end)
    end
    W.FakeParry_Play = FakeParry_Play

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        local kc = Enum.KeyCode[VD.SURV_FakeParryKey or "V"]
        if kc and input.KeyCode == kc then FakeParry_Play() end
    end)
end

-- ═══════════════ UI + TOGGLE BUTTON DI BAWAH ═══════════════
SurvExtra:AddToggle("SwiftVault", {
    Text = "Swift Vault (Auto)",
    Default = false,
    Callback = function(v) VD.SURV_AutoVault = v end,
})
SurvExtra:AddToggle("SwiftVaultV2", {
    Text = "Swift Vault V2",
    Default = false,
    Callback = function(v) VD.SURV_FastVault = v end,
})
SurvExtra:AddSlider("VaultSpeed", {
    Text = "Vault Speed",
    Default = 13, Min = 10, Max = 20, Rounding = 1,
    Callback = function(v) VD.SURF_VaultSpeed = v end,
})

SurvExtra:AddDivider()
SurvExtra:AddToggle("PalletReflex", {
    Text = "Pallet Reflex",
    Default = false,
    Callback = function(v) VD.SURV_AutoPallet = v end,
})
SurvExtra:AddSlider("PalletDist", {
    Text = "Pallet Trigger Distance",
    Default = 20, Min = 5, Max = 50, Rounding = 1, Suffix = " studs",
    Callback = function(v) VD.SURV_AutoPalletDist = v end,
})

-- Toggle button di bawah fitur
SurvExtra:AddDivider()
SurvExtra:AddToggle("ShowTrollTPBtn", {
    Text = "Show Troll TP Button",
    Default = false,
    Callback = function(v)
        if W.Gluto_TTB_SetEnabled then W.Gluto_TTB_SetEnabled(v) end
    end,
})
SurvExtra:AddToggle("ShowEscapeBtn", {
    Text = "Show Escape Button",
    Default = false,
    Callback = function(v)
        if W.Gluto_Escape_SetEnabled then W.Gluto_Escape_SetEnabled(v) end
    end,
})

-- Fake Parry + tombol di bawah
SurvExtra2:AddToggle("FakeParry", {
    Text = "Fake Parry",
    Default = false,
    Callback = function(v) VD.SURV_FakeParry = v end,
})
SurvExtra2:AddDropdown("FakeParryAnim", {
    Values = { "Enten", "Stopwatch", "Fih", "BloodShield" },
    Default = "Enten",
    Text = "Animation",
    Callback = function(v) VD.SURV_FakeParryAnim = v end,
})
SurvExtra2:AddSlider("FakeParryCd", {
    Text = "Cooldown", Default = 0.4, Min = 0, Max = 3, Rounding = 0.1,
    Suffix = "s",
    Callback = function(v) VD.SURV_FakeParryCooldown = v end,
})
SurvExtra2:AddButton({
    Text = "Test Fake Parry",
    Func = function() if W.FakeParry_Play then W.FakeParry_Play() end end,
})
SurvExtra2:AddDivider()
SurvExtra2:AddToggle("ShowFakeParryBtn", {
    Text = "Show Fake Parry Button",
    Default = false,
    Callback = function(v)
        VD.SURV_FakeParryShowBtn = v
        if v and W.FakeParry_CreateButton then W.FakeParry_CreateButton()
        elseif W.FakeParry_RemoveButton then W.FakeParry_RemoveButton() end
    end,
})-- [[PART 10/20]]

-- ═══════════════ NO FALL DAMAGE ═══════════════
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
                            if par and par.Name == "Mechanics" then
                                return nil
                            end
                        end
                    end
                end
                return oldNamecall(self, ...)
            end)
            if setreadonly then setreadonly(mt, true) end
        end)
    end)
end

-- ═══════════════ MANUAL & AUTO GENERATOR ═══════════════
do
    local RepairEvent = nil
    pcall(function()
        RepairEvent = ReplicatedStorage.Remotes.Generator.RepairEvent
    end)

    local ManualThread, AutoThread = nil, nil
    local ManualPoint, AutoPoint = nil, nil
    local LastFire = 0

    local function IsKillerNearPos(pos, radius)
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= LocalPlayer and TeamIs(pl, "Killer") and pl.Character then
                local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - pos).Magnitude <= radius then
                    return true
                end
            end
        end
        return false
    end

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
        for _, gen in ipairs(W.GB_GetAllGenerators()) do
            for _, pt in ipairs(W.GB_GetPoints(gen)) do
                if pt and pt.Parent then
                    local d = (myRoot.Position - pt.Position).Magnitude
                    if d < bestDist then
                        bestDist = d
                        bestPt = pt
                    end
                end
            end
        end
        return bestPt
    end

    local function StartManualThread()
        if ManualThread then pcall(function() task.cancel(ManualThread) end); ManualThread = nil end
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
                    task.wait(0.3)
                    continue
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
                    if ManualPoint then
                        pcall(function() RepairEvent:FireServer(ManualPoint, false) end)
                        ManualPoint = nil
                    end
                end
                task.wait(0.1)
            end
            if ManualPoint then pcall(function() RepairEvent:FireServer(ManualPoint, false) end) end
            ManualPoint = nil
        end)
    end

    local function StopManualThread()
        if ManualThread then pcall(function() task.cancel(ManualThread) end); ManualThread = nil end
        if ManualPoint then pcall(function() RepairEvent:FireServer(ManualPoint, false) end) end
        ManualPoint = nil
    end

    local function GetSafeNearestGenPoint()
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local bestPt, bestDist = nil, math.huge
        for _, gen in ipairs(W.GB_GetAllGenerators()) do
            local genPivot
            pcall(function() genPivot = gen:GetPivot().Position end)
            if genPivot and IsKillerNearPos(genPivot, VD.KillerEscapeDist) then continue end
            for _, pt in ipairs(W.GB_GetPoints(gen)) do
                if pt and pt.Parent then
                    local d = (pt.Position - myRoot.Position).Magnitude
                    if d < bestDist then
                        bestDist = d
                        bestPt = pt
                    end
                end
            end
        end
        return bestPt
    end

    local function StartAutoThread()
        if AutoThread then pcall(function() task.cancel(AutoThread) end); AutoThread = nil end
        AutoThread = task.spawn(function()
            while VD.AutoGen do
                local myChar = LocalPlayer.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then task.wait(0.3); continue end

                local _, kd = GetNearestKillerDist()
                if kd <= VD.KillerEscapeDist then
                    if AutoPoint then
                        pcall(function() RepairEvent:FireServer(AutoPoint, false) end)
                        AutoPoint = nil
                    end
                    local safePt = GetSafeNearestGenPoint()
                    if safePt then
                        AutoPoint = safePt
                        pcall(function()
                            myRoot.CFrame = CFrame.new(safePt.Position + Vector3.new(0, 3, 0))
                        end)
                        task.wait(0.2)
                    end
                    task.wait(0.2)
                    continue
                end

                if AutoPoint and AutoPoint.Parent then
                    local now = tick()
                    if now - LastFire >= 0.5 then
                        pcall(function() RepairEvent:FireServer(AutoPoint, true) end)
                        LastFire = now
                    end
                else
                    local pt = GetNearestGenPointInReach()
                    if pt then
                        AutoPoint = pt
                    else
                        local safePt = GetSafeNearestGenPoint()
                        if safePt then
                            AutoPoint = safePt
                            pcall(function()
                                myRoot.CFrame = CFrame.new(safePt.Position + Vector3.new(0, 3, 0))
                            end)
                            task.wait(0.2)
                        end
                    end
                end
                task.wait(0.1)
            end
            if AutoPoint then pcall(function() RepairEvent:FireServer(AutoPoint, false) end) end
            AutoPoint = nil
        end)
    end

    local function StopAutoThread()
        if AutoThread then pcall(function() task.cancel(AutoThread) end); AutoThread = nil end
        if AutoPoint then pcall(function() RepairEvent:FireServer(AutoPoint, false) end) end
        AutoPoint = nil
    end

    W.ManualGen_SetEnabled = function(v)
        VD.ManualGen = v and true or false
        if VD.ManualGen then StartManualThread() else StopManualThread() end
    end
    W.AutoGen_SetEnabled = function(v)
        VD.AutoGen = v and true or false
        if VD.AutoGen then StartAutoThread() else StopAutoThread() end
    end

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if VD.ManualGen then StartManualThread() end
        if VD.AutoGen then StartAutoThread() end
    end)
end

-- ═══════════════ DASH LOCK ═══════════════
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
            local smooth = VD.DashLockSmoothness or 0.3
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Position), smooth)
        end
        if VD.FreezeDuringDashLock then
            local hum = myChar:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= 0 then hum.WalkSpeed = 0 end
        end
    end

    local function DashLock_SetActive(active)
        active = active and true or false
        if active == VD._DashLockActive then return end
        VD._DashLockActive = active
        if active then
            if not VD._DashLockConnection then
                VD._DashLockConnection = RunService.RenderStepped:Connect(function()
                    pcall(DashLock_Update)
                end)
            end
        else
            if VD._DashLockConnection then
                pcall(function() VD._DashLockConnection:Disconnect() end)
                VD._DashLockConnection = nil
            end
            VD._DashLockTarget = nil
            if VD.FreezeDuringDashLock then
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed == 0 then hum.WalkSpeed = 16 end
            end
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
                task.delay(VD.DashLockDuration or 1.5, function()
                    DashLock_SetActive(false)
                end)
            end
        end)
    end

    if LocalPlayer.Character then DashLock_HookCharacter(LocalPlayer.Character) end
    LocalPlayer.CharacterAdded:Connect(function(c)
        task.wait(0.5)
        DashLock_HookCharacter(c)
    end)
end

-- ═══════════════ TOF SILENT AIM ═══════════════
do
    local ToFState = {
        Connection = nil, LaserBeam = nil, TargetGui = nil,
        InputBegan = nil, InputEnded = nil, TouchInput = nil,
        IsAiming = false, SCPCache = {}, SCPCacheTimer = 0
    }
    local ToFKeyCodes = {
        None=nil, Q=Enum.KeyCode.Q, E=Enum.KeyCode.E, R=Enum.KeyCode.R, T=Enum.KeyCode.T,
        F=Enum.KeyCode.F, G=Enum.KeyCode.G, H=Enum.KeyCode.H, J=Enum.KeyCode.J,
        K=Enum.KeyCode.K, L=Enum.KeyCode.L, X=Enum.KeyCode.X, Z=Enum.KeyCode.Z
    }

    local function ToF_IsDowned(c)
        if not c then return true end
        local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return true end
        local h = c:FindFirstChildOfClass("Humanoid"); if h and h.Health <= 0 then return true end
        if c:GetAttribute("Knocked") == true then return true end
        if c:GetAttribute("IsHooked") == true then return true end
        if c:GetAttribute("IsCarried") == true then return true end
        return false
    end

    local function ToF_IsBlocked()
        if VD.TOF_BlockKnocked == false then return false end
        local c = LocalPlayer.Character
        if not c then return true end
        return ToF_IsDowned(c)
    end

    local function ToF_GetEvent()
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local i = r and r:FindFirstChild("Items")
        local t = i and i:FindFirstChild("Twist of Fate")
        local f = t and t:FindFirstChild("Fire")
        if f and f:IsA("RemoteEvent") then return f end
        return nil
    end

    local function ToF_GetGun()
        local c = LocalPlayer.Character
        if not c then return nil end
        local b = c:FindFirstChild("Twist of Fate", true)
        if not b then return nil end
        local ra = b:FindFirstChild("Right Arm")
        if ra then
            local g = ra:FindFirstChild("gun"); if g then return g end
            local e = ra:FindFirstChild("EmperorGun"); if e then return e end
        end
        return b
    end

    local function ToF_GetTarget()
        local g = ToF_GetGun(); local c = LocalPlayer.Character
        if not (g and c) then return nil,nil,nil,nil end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil,nil,nil,nil end
        local mp = hrp.Position
        local op
        if c:GetAttribute("IsCarried") then
            op = hrp.Position + (hrp.CFrame.LookVector * 2)
        else
            pcall(function()
                op = g:IsA("BasePart") and g.Position or
                    (g:FindFirstChildOfClass("BasePart") and g:FindFirstChildOfClass("BasePart").Position)
            end)
            op = op or Vector3.new(mp.X, mp.Y + 1.5, mp.Z)
        end

        local function predict(t, tc)
            local tp = t.Position
            local tv = Vector3.new(0,0,0)
            local rp = tc and (tc:FindFirstChild("HumanoidRootPart") or t)
            if rp then tv = rp.Velocity end
            local dr = tp - op; local d = dr.Magnitude
            if d < 0.1 then return nil,nil,nil,nil end
            if d < 5 then return dr.Unit, g, op, tp end
            local tt = d / 400
            local pp = tp + (tv * tt)
            for _=1,2 do
                local nd = (pp-op).Magnitude; tt = nd/400; pp = tp + (tv*tt)
            end
            local fd = pp - op
            if fd.Magnitude < 0.1 then return nil,nil,nil,nil end
            return fd.Unit, g, op, pp
        end

        local mode = VD.TOF_TargetMode or "Killer"
        if mode == "Killer" then
            local bt, bc, bs = nil, nil, math.huge
            for _,p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                    local t = p.Character:FindFirstChild("Torso")
                        or p.Character:FindFirstChild("UpperTorso")
                        or p.Character:FindFirstChild("HumanoidRootPart")
                    if t then
                        local d = (mp-t.Position).Magnitude
                        if d < bs then bs=d; bt=t; bc=p.Character end
                    end
                end
            end
            if not bt then return nil,nil,nil,nil end
            return predict(bt, bc)
        elseif mode == "Survivors" then
            local bt, bc, bd = nil, nil, -math.huge
            local cam = workspace.CurrentCamera
            local cl = cam.CFrame.LookVector
            for _,p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and TeamIs(p, "Survivor") and p.Character then
                    local t = p.Character:FindFirstChild("Torso")
                        or p.Character:FindFirstChild("UpperTorso")
                        or p.Character:FindFirstChild("HumanoidRootPart")
                    if t then
                        local dt = t.Position - cam.CFrame.Position
                        if dt.Magnitude > 0.1 then
                            local dot = cl:Dot(dt.Unit)
                            if dot > 0.5 and dot > bd then bd=dot; bt=t; bc=p.Character end
                        end
                    end
                end
            end
            if not bt then return nil,nil,nil,nil end
            return predict(bt, bc)
        end
        return nil,nil,nil,nil
    end

    local function ToF_UpdateLaser(op, tp)
        if not ToFState.LaserBeam then
            local l = Instance.new("Part")
            l.Name="PazzToFLaser"; l.Anchored=true; l.CanCollide=false
            l.CanTouch=false; l.CastShadow=false
            l.Material=Enum.Material.Neon
            l.Color=ACCENT
            l.Parent=workspace
            ToFState.LaserBeam = l
        end
        local d = (tp-op).Magnitude
        ToFState.LaserBeam.Size = Vector3.new(0.05,0.05,d)
        ToFState.LaserBeam.CFrame = CFrame.new((op+tp)/2, tp)
        ToFState.LaserBeam.Transparency = 0
    end

    local function ToF_ClearLaser()
        if ToFState.LaserBeam then pcall(function() ToFState.LaserBeam:Destroy() end); ToFState.LaserBeam=nil end
    end
    W.ToF_ClearLaser = ToF_ClearLaser

    local function ToF_Shoot()
        if not VD.TOF_SilentAim then return end
        if ToF_IsBlocked() then return end
        local td, g, op, tp = ToF_GetTarget()
        if not (td and g and tp and op) then return end
        local e = ToF_GetEvent()
        if not e then return end
        local fd = tp - op
        if fd.Magnitude < 0.1 then return end
        pcall(function() e:FireServer(g, fd.Unit) end)
    end

    local SetToFSilentAim

    local function ToF_StartConn()
        if ToFState.Connection then return end
        ToFState.Connection = RunService.Heartbeat:Connect(function()
            if ToF_IsBlocked() then
                ToFState.IsAiming = false
                if ToFState.TouchInput then ToFState.TouchInput = nil end
                if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
                return
            end
            if not VD.TOF_SilentAim or not ToFState.IsAiming then
                if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
                return
            end
            local _, _, op, tp = ToF_GetTarget()
            if op and tp then
                pcall(function()
                    local c = LocalPlayer.Character
                    local hrp = c and c:FindFirstChild("HumanoidRootPart")
                    if hrp and not c:GetAttribute("IsCarried") then
                        hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(tp.X, hrp.Position.Y, tp.Z))
                    end
                end)
                if VD.TOF_Laser then ToF_UpdateLaser(op, tp)
                elseif ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
            elseif ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
        end)
    end

    local function ToF_StopConn()
        if ToFState.Connection then pcall(function() ToFState.Connection:Disconnect() end); ToFState.Connection = nil end
        ToFState.IsAiming = false
        ToF_ClearLaser()
    end

    local function ToF_EnsureInputs()
        if not ToFState.InputBegan then
            ToFState.InputBegan = UserInputService.InputBegan:Connect(function(inp, gp)
                if gp then return end
                local k = ToFKeyCodes[VD.TOF_Key or "None"]
                if k and inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == k then
                    SetToFSilentAim(not VD.TOF_SilentAim); return
                end
                if not VD.TOF_SilentAim then return end
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    if ToF_IsBlocked() then ToFState.IsAiming = false; return end
                    ToFState.IsAiming = true
                    return
                end
                if inp.UserInputType == Enum.UserInputType.Keyboard then
                    if inp.KeyCode == Enum.KeyCode.K then VD.TOF_TargetMode = "Killer"
                    elseif inp.KeyCode == Enum.KeyCode.J then VD.TOF_TargetMode = "Survivors" end
                end
            end)
        end
        if not ToFState.InputEnded then
            ToFState.InputEnded = UserInputService.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    local wa = ToFState.IsAiming
                    ToFState.IsAiming = false
                    if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
                    if wa then
                        if ToF_IsBlocked() then return end
                        ToF_Shoot()
                    end
                end
            end)
        end
    end

    SetToFSilentAim = function(en)
        VD.TOF_SilentAim = en and true or false
        ToF_EnsureInputs()
        if VD.TOF_SilentAim then ToF_StartConn()
        else ToF_StopConn() end
    end
    W.SetToFSilentAim = SetToFSilentAim
    ToF_EnsureInputs()
end

-- ═══════════════ SILENT FLASHLIGHT ═══════════════
do
    local FlashState = { Active = false, LaserBeam = nil, FlashlightPart = nil, Connection = nil }

    local function Flash_GetTargetPart(char)
        if not char then return nil end
        local p = char:FindFirstChild(VD.FLASH_TargetPart or "Head")
        if p and p:IsA("BasePart") then return p end
        return char:FindFirstChild("Head") or char:FindFirstChild("UpperTorso")
            or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    end

    local function Flash_IsAliveChar(char)
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return false end
        return char:GetAttribute("State") ~= "Dead"
    end

    local function Flash_GetTarget()
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local maxR = tonumber(VD.FLASH_Range) or 120
        local best, bd = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and Flash_IsAliveChar(p.Character)
                and TeamIs(p, "Killer") then
                local part = Flash_GetTargetPart(p.Character)
                if part then
                    local d = (myRoot.Position - part.Position).Magnitude
                    if d <= maxR and d < bd then bd = d; best = part end
                end
            end
        end
        return best
    end

    local function Flash_ClearLaser()
        if FlashState.LaserBeam then
            pcall(function() FlashState.LaserBeam:Destroy() end)
            FlashState.LaserBeam = nil
        end
    end
    W.Flash_ClearLaser = Flash_ClearLaser

    local function Flash_GetOrigin(cam)
        local src = FlashState.FlashlightPart
        if src and typeof(src) == "Instance" then
            if src:IsA("BasePart") then return src.Position end
            local p = src:FindFirstChildWhichIsA("BasePart", true)
            if p then return p.Position end
        end
        local c = LocalPlayer.Character
        local hand = c and (c:FindFirstChild("RightHand") or c:FindFirstChild("Right Arm") or c:FindFirstChild("HumanoidRootPart"))
        if hand and hand:IsA("BasePart") then return hand.Position end
        return cam and cam.CFrame.Position or nil
    end

    local function Flash_UpdateLaser(op, tp)
        if not FlashState.LaserBeam then
            local l = Instance.new("Part")
            l.Name = "PazzFlashLaser"
            l.Anchored = true
            l.CanCollide = false
            l.CanTouch = false
            l.CanQuery = false
            l.CastShadow = false
            l.Material = Enum.Material.Neon
            l.Color = ACCENT
            l.Transparency = 0
            l.Parent = Workspace
            FlashState.LaserBeam = l
        end
        local d = (tp - op).Magnitude
        if d < 0.1 then return end
        local l = FlashState.LaserBeam
        l.Size = Vector3.new(0.16, 0.16, d)
        l.CFrame = CFrame.new((op + tp) / 2, tp)
        l.Transparency = 0.35
    end

    local function Flash_Step()
        if not (VD.FLASH_SilentAim and FlashState.Active) then
            if FlashState.LaserBeam then FlashState.LaserBeam.Transparency = 1 end
            return
        end
        local cam = Workspace.CurrentCamera
        local tp = Flash_GetTarget()
        if not (cam and tp) then
            if FlashState.LaserBeam then FlashState.LaserBeam.Transparency = 1 end
            return
        end
        local smooth = math.clamp(tonumber(VD.FLASH_Smooth) or 0.35, 0.05, 1)
        local op = Flash_GetOrigin(cam)
        if VD.FLASH_Laser and op then
            pcall(Flash_UpdateLaser, op, tp.Position)
        elseif FlashState.LaserBeam then
            FlashState.LaserBeam.Transparency = 1
        end
        pcall(function()
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, tp.Position), smooth)
        end)
    end

    local function Flash_Start()
        if FlashState.Connection then return end
        FlashState.Connection = RunService.RenderStepped:Connect(function() pcall(Flash_Step) end)
    end

    local function Flash_Stop()
        FlashState.Active = false
        FlashState.FlashlightPart = nil
        Flash_ClearLaser()
        if FlashState.Connection then
            pcall(function() FlashState.Connection:Disconnect() end)
            FlashState.Connection = nil
        end
    end

    W.Flash_SetEnabled = function(v)
        VD.FLASH_SilentAim = v and true or false
        if v then Flash_Start() else Flash_Stop() end
    end
    W.Flash_SetActive = function(active, part)
        FlashState.Active = active and true or false
        if FlashState.Active and part then
            FlashState.FlashlightPart = part
        elseif not FlashState.Active then
            FlashState.FlashlightPart = nil
        end
        if not FlashState.Active and FlashState.LaserBeam then
            FlashState.LaserBeam.Transparency = 1
        end
    end
end

-- ═══════════════ UI BINDING ═══════════════
SurvExtra2:AddToggle("NoFallDmg", {
    Text = "No Fall Damage",
    Default = false,
    Callback = function(v) VD.NoFallDamage = v end,
})
SurvExtra2:AddToggle("ManualGen", {
    Text = "Manual Generator",
    Default = false,
    Callback = function(v) W.ManualGen_SetEnabled(v) end,
})
SurvExtra2:AddToggle("AutoGen", {
    Text = "Auto Generator",
    Default = false,
    Callback = function(v) W.AutoGen_SetEnabled(v) end,
})
SurvExtra2:AddSlider("KillerEscapeDist", {
    Text = "Killer Escape Distance",
    Default = 30, Min = 10, Max = 80, Rounding = 5, Suffix = " studs",
    Callback = function(v) VD.KillerEscapeDist = v end,
})

SurvExtra2:AddDivider()
SurvExtra2:AddToggle("ToFSilent", {
    Text = "Silent Aim TOF",
    Default = false,
    Callback = function(v) W.SetToFSilentAim(v) end,
})
SurvExtra2:AddDropdown("ToFMode", {
    Values = { "Killer", "Survivors" },
    Default = "Killer",
    Text = "ToF Target Mode",
    Callback = function(v) VD.TOF_TargetMode = v end,
})
SurvExtra2:AddToggle("ToFLaser", {
    Text = "ToF Show Laser",
    Default = true,
    Callback = function(v)
        VD.TOF_Laser = v
        if not v and W.ToF_ClearLaser then W.ToF_ClearLaser() end
    end,
})
SurvExtra2:AddToggle("ToFWall", {
    Text = "ToF Wall Check",
    Default = true,
    Callback = function(v) VD.TOF_WallCheck = v end,
})

SurvExtra2:AddDivider()
SurvExtra2:AddToggle("FlashSilent", {
    Text = "Silent Flashlight",
    Default = false,
    Callback = function(v) W.Flash_SetEnabled(v) end,
})
SurvExtra2:AddDropdown("FlashPart", {
    Values = { "Head", "UpperTorso", "Torso", "HumanoidRootPart" },
    Default = "Head",
    Text = "Flash Target Part",
    Callback = function(v) VD.FLASH_TargetPart = v end,
})
SurvExtra2:AddSlider("FlashRange", {
    Text = "Flash Range", Default = 120, Min = 20, Max = 250, Rounding = 5,
    Suffix = " studs",
    Callback = function(v) VD.FLASH_Range = v end,
})
SurvExtra2:AddToggle("FlashLaser", {
    Text = "Flash Show Laser",
    Default = true,
    Callback = function(v)
        VD.FLASH_Laser = v
        if not v and W.Flash_ClearLaser then W.Flash_ClearLaser() end
    end,
})

SurvExtra2:AddDivider()
SurvExtra2:AddToggle("DashLock", {
    Text = "Dash Lock",
    Default = false,
    Callback = function(v) VD.DashLockEnabled = v end,
})
SurvExtra2:AddSlider("DashLockDur", {
    Text = "Dash Lock Duration", Default = 1.5, Min = 0.5, Max = 5, Rounding = 0.1,
    Suffix = "s",
    Callback = function(v) VD.DashLockDuration = v end,
})
SurvExtra2:AddSlider("DashLockSmooth", {
    Text = "Dash Smoothness", Default = 0.3, Min = 0.05, Max = 1, Rounding = 0.05,
    Callback = function(v) VD.DashLockSmoothness = v end,
})-- [[PART 11/20]]

-- ═══════════════ FLOATING BUTTON FACTORY — BULAT + ICON ═══════════════
local function CreateFloatingButton(cfg)
    local state = cfg.state
    state.Connections = state.Connections or {}

    local function ClearConns()
        for _, c in ipairs(state.Connections) do
            pcall(function() c:Disconnect() end)
        end
        state.Connections = {}
    end

    local function DestroyBtn()
        ClearConns()
        if state.Gui then
            pcall(function() state.Gui:Destroy() end)
            state.Gui = nil
        end
    end

    local function UpdateVisual()
        if not state.Gui then return end
        local main = state.Gui:FindFirstChild("MainBtn", true)
        if not main then return end
        local iconImg = main:FindFirstChild("IconImage")
        local sd = main:FindFirstChild("StatusDot")
        local str = main:FindFirstChild("MainStroke")
        local glow = main:FindFirstChild("GlowStroke")
        local isOn = cfg.isOn()

        if isOn then
            TweenService:Create(main, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(16, 24, 42),
                BackgroundTransparency = 0.05
            }):Play()
            if str then
                TweenService:Create(str, TweenInfo.new(0.2), {
                    Color = ACCENT, Transparency = 0, Thickness = 1.8
                }):Play()
            end
            if glow then
                TweenService:Create(glow, TweenInfo.new(0.2), {
                    Transparency = 0.4
                }):Play()
            end
            if sd then
                TweenService:Create(sd, TweenInfo.new(0.2), {
                    BackgroundColor3 = ACCENT
                }):Play()
            end
            if iconImg then
                TweenService:Create(iconImg, TweenInfo.new(0.2), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
            end
        else
            TweenService:Create(main, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(8, 14, 26),
                BackgroundTransparency = 0.1
            }):Play()
            if str then
                TweenService:Create(str, TweenInfo.new(0.2), {
                    Color = Color3.fromRGB(60, 60, 70), Transparency = 0.4, Thickness = 1.2
                }):Play()
            end
            if glow then
                TweenService:Create(glow, TweenInfo.new(0.2), {
                    Transparency = 0.9
                }):Play()
            end
            if sd then
                TweenService:Create(sd, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(120, 120, 120)
                }):Play()
            end
            if iconImg then
                TweenService:Create(iconImg, TweenInfo.new(0.2), {
                    ImageColor3 = Color3.fromRGB(150, 150, 160)
                }):Play()
            end
        end
    end

    local function CreateBtn()
        DestroyBtn()
        local parent = LocalPlayer:FindFirstChild("PlayerGui")
        if gethui then
            local ok2, hui = pcall(gethui)
            if ok2 and hui then parent = hui end
        end
        if not parent then return end

        local gui = Instance.new("ScreenGui")
        gui.Name = "Pazz" .. cfg.id .. "Btn"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.DisplayOrder = 100
        gui.Parent = parent
        state.Gui = gui

        -- CONTAINER
        local container = Instance.new("Frame")
        container.Name = "Container"
        container.Size = UDim2.fromOffset(60, 60)
        container.Position = state.SavedPos
        container.BackgroundTransparency = 1
        container.Parent = gui

        -- MAIN BUTTON — BULAT
        local main = Instance.new("Frame")
        main.Name = "MainBtn"
        main.Size = UDim2.fromOffset(60, 60)
        main.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        main.BackgroundTransparency = 0.1
        main.BorderSizePixel = 0
        main.ZIndex = 1
        main.Parent = container
        Instance.new("UICorner", main).CornerRadius = UDim.new(1, 0)   -- ✅ BULAT

        local mainStroke = Instance.new("UIStroke", main)
        mainStroke.Name = "MainStroke"
        mainStroke.Color = Color3.fromRGB(60, 60, 70)
        mainStroke.Thickness = 1.2
        mainStroke.Transparency = 0.4

        local glow = Instance.new("UIStroke", main)
        glow.Name = "GlowStroke"
        glow.Color = ACCENT
        glow.Thickness = 5
        glow.Transparency = 0.9

        -- ICON IMAGE
        local iconImg = Instance.new("ImageLabel")
        iconImg.Name = "IconImage"
        iconImg.Size = UDim2.fromScale(0.55, 0.55)
        iconImg.Position = UDim2.fromScale(0.225, 0.225)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = "rbxassetid://" .. tostring(cfg.iconAsset or PAZZ_LOGO)
        iconImg.ImageColor3 = Color3.fromRGB(150, 150, 160)
        iconImg.ZIndex = 3
        iconImg.Parent = main

        -- STATUS DOT
        local sd = Instance.new("Frame")
        sd.Name = "StatusDot"
        sd.Size = UDim2.fromOffset(12, 12)
        sd.Position = UDim2.new(1, -14, 0, 2)
        sd.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        sd.BorderSizePixel = 0
        sd.ZIndex = 4
        sd.Parent = main
        Instance.new("UICorner", sd).CornerRadius = UDim.new(1, 0)

        local sdStroke = Instance.new("UIStroke", sd)
        sdStroke.Color = Color3.fromRGB(8, 14, 26)
        sdStroke.Thickness = 2
        sdStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        -- CLICK DETECT
        local cd = Instance.new("TextButton")
        cd.Name = "ClickDetect"
        cd.Size = UDim2.fromScale(1, 1)
        cd.BackgroundTransparency = 1
        cd.Text = ""
        cd.AutoButtonColor = false
        cd.ZIndex = 5
        cd.Parent = main

        local drag = false
        local dStart, sPos
        local dDist = 0

        table.insert(state.Connections, cd.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or inp.UserInputType == Enum.UserInputType.Touch then
                dStart = inp.Position
                sPos = container.Position
                dDist = 0
                drag = true
            end
        end))

        table.insert(state.Connections, cd.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or inp.UserInputType == Enum.UserInputType.Touch then
                if drag then
                    drag = false
                    state.SavedPos = container.Position
                end
                if dDist < 8 then
                    cfg.onToggle(not cfg.isOn())
                    UpdateVisual()
                    if not cfg.isOn() then
                        W.PazzNotify(cfg.notifyTitle, "Disabled", 2)
                    else
                        W.PazzNotify(cfg.notifyTitle, "Enabled", 2)
                    end
                end
            end
        end))

        table.insert(state.Connections, UserInputService.InputChanged:Connect(function(inp)
            if not drag then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement
                or inp.UserInputType == Enum.UserInputType.Touch then
                local d = inp.Position - dStart
                dDist = math.abs(d.X) + math.abs(d.Y)
                container.Position = UDim2.new(
                    sPos.X.Scale, sPos.X.Offset + d.X,
                    sPos.Y.Scale, sPos.Y.Offset + d.Y
                )
            end
        end))

        UpdateVisual()
    end

    state.Create = CreateBtn
    state.Destroy = DestroyBtn
    state.UpdateVisual = UpdateVisual
    state.SetEnabled = function(en)
        state.Enabled = en and true or false
        if state.Enabled then CreateBtn() else DestroyBtn() end
    end
    return state
end
W.CreateFloatingButton = CreateFloatingButton-- [[PART 12/20]]

-- ═══════════════ SELF HEAL LOGIC ═══════════════
function W.setInstantHealSelf(v)
    W.InstantHealSelf = v
    if v then
        local ha = false
        if W.InstantHealConnection then W.InstantHealConnection:Disconnect() end
        W.InstantHealConnection = RunService.Heartbeat:Connect(function()
            if not W.InstantHealSelf then return end
            local c = LocalPlayer.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not h then return end
            if h.Health >= h.MaxHealth * 0.9 then
                if ha then ha = false; W.doSelfHealFalse() end
                return
            end
            if ha then
                local ci = c:FindFirstChild("CheckInterractable")
                if ci and not ci:GetAttribute("isHealing") then ha = false end
            end
            if not ha then ha = true; W.doSelfHealTrue() end
        end)
    else
        if W.InstantHealConnection then
            W.InstantHealConnection:Disconnect()
            W.InstantHealConnection = nil
        end
        pcall(W.doSelfHealFalse)
    end
end

function W.setAutoHealAll(v)
    W.AutoHealAll = v
    if v then
        local ah = {}
        if W.AutoHealAllConnection then W.AutoHealAllConnection:Disconnect() end
        W.AutoHealAllConnection = RunService.Heartbeat:Connect(function()
            if not W.AutoHealAll then return end
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local hu = p.Character:FindFirstChildOfClass("Humanoid")
                    if hu and hu.Health > 0 and hu.Health < hu.MaxHealth * 0.9 and hrp then
                        if ah[p] then
                            local c = LocalPlayer.Character
                            local ci = c and c:FindFirstChild("CheckInterractable")
                            if ci and not ci:GetAttribute("isHealing") then ah[p] = nil end
                        end
                        if not ah[p] then ah[p] = true; W.doOthersHealTrue(p) end
                    else
                        if ah[p] then ah[p] = nil; W.doOthersHealFalse(p) end
                    end
                else
                    if ah[p] then ah[p] = nil; pcall(function() W.doOthersHealFalse(p) end) end
                end
            end
        end)
    else
        if W.AutoHealAllConnection then
            W.AutoHealAllConnection:Disconnect()
            W.AutoHealAllConnection = nil
        end
    end
end

-- ═══════════════ SELF UNHOOK LOGIC ═══════════════
local SU = W.SelfUnhook

function W.SU_IsHooked()
    local char = LocalPlayer.Character
    if not char then return false end
    return char:GetAttribute("IsHooked") == true or char:GetAttribute("isHooked") == true
        or char:GetAttribute("Hooked") == true or char:GetAttribute("HookedState") == true
end

function W.SU_GetRandomGeneratorPoint()
    local gens = W.GB_GetAllGenerators()
    if not gens or #gens == 0 then return nil end
    local valid = {}
    for _, g in ipairs(gens) do
        if g and g.Parent then
            for _, p in ipairs(W.GB_GetPoints(g)) do
                if p and p.Parent then table.insert(valid, p) end
            end
        end
    end
    if #valid == 0 then return nil end
    return valid[math.random(1, #valid)]
end

function W.SU_GetKillerHRP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then return hrp end
        end
    end
    return nil
end

function W.SU_Trigger()
    if SU.Following then return end
    local now = tick()
    if now - SU._lastTrigger < SU._cooldown then return end
    if not W.SU_IsHooked() then return end
    SU._lastTrigger = now
    SU.Following = true
    SU.TriggerCount = SU.TriggerCount + 1
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then SU._hookPos = hrp.Position; SU._hookCFrame = hrp.CFrame end
    end
    SU._activeThread = task.spawn(function()
        local c = LocalPlayer.Character
        if not c then SU.Following = false; SU._activeThread = nil; return end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if not hrp then SU.Following = false; SU._activeThread = nil; return end
        local re = ReplicatedStorage:FindFirstChild("Remotes")
            and ReplicatedStorage.Remotes:FindFirstChild("Generator")
            and ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
        if not W.SU_IsHooked() then
            SU.Following = false; SU._activeThread = nil; return
        end
        local tp = W.SU_GetRandomGeneratorPoint()
        if tp then
            pcall(function()
                hrp.Velocity = Vector3.zero
                hrp.CFrame = tp.CFrame + Vector3.new(0, 3, 0)
            end)
            task.wait(0.15)
            if re then
                pcall(function() re:FireServer(tp, true) end); task.wait(0.35)
                pcall(function() re:FireServer(tp, false) end); task.wait(0.15)
                pcall(function() re:FireServer(tp, true) end); task.wait(0.35)
                pcall(function() re:FireServer(tp, false) end)
            end
        end
        local fUntil = tick() + (SU.FollowDuration or 30)
        local bOff = SU.FollowDistance or 20
        while tick() < fUntil and SU.Enabled do
            if not W.SU_IsHooked() then
                SU.Following = false; SU._activeThread = nil
                W.PazzNotify("Self Unhook", "Udah lepas hook - STOP", 2)
                return
            end
            local cc = LocalPlayer.Character
            if not cc then break end
            local r = cc:FindFirstChild("HumanoidRootPart")
            if not r then break end
            local khrp = W.SU_GetKillerHRP()
            if khrp then
                pcall(function()
                    r.Velocity = Vector3.zero
                    local tPos = Vector3.new(khrp.Position.X, khrp.Position.Y - bOff, khrp.Position.Z)
                    r.CFrame = CFrame.new(tPos, tPos + Vector3.new(0, 0, -1))
                end)
            end
            task.wait(0.03)
        end
        if W.SU_IsHooked() then
            local c2 = LocalPlayer.Character
            if c2 then
                local r2 = c2:FindFirstChild("HumanoidRootPart")
                if r2 then
                    if SU._hookCFrame then
                        pcall(function()
                            r2.Velocity = Vector3.zero
                            r2.CFrame = SU._hookCFrame
                        end)
                    elseif SU._hookPos then
                        pcall(function()
                            r2.Velocity = Vector3.zero
                            r2.CFrame = CFrame.new(SU._hookPos + Vector3.new(0, 3, 0))
                        end)
                    end
                end
            end
        end
        SU.Following = false; SU._activeThread = nil
    end)
end

function W.SU_Start()
    if SU.MonitorConn then return end
    SU._wasHooked = false
    SU.MonitorConn = RunService.Heartbeat:Connect(function()
        if not SU.Enabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local isH = W.SU_IsHooked()
        if not isH then SU._wasHooked = false; return end
        if not SU._wasHooked and not SU.Following then
            SU._wasHooked = true
            W.SU_Trigger()
        end
    end)
end

function W.SU_Stop()
    if SU.MonitorConn then SU.MonitorConn:Disconnect(); SU.MonitorConn = nil end
    if SU._activeThread then pcall(function() task.cancel(SU._activeThread) end); SU._activeThread = nil end
    SU.Following = false
    SU._wasHooked = false
end

function W.SU_SetEnabled(v)
    SU.Enabled = v and true or false
    if v then W.SU_Start() else W.SU_Stop() end
end

-- ═══════════════ TROLL TELEPORT LOGIC ═══════════════
function W.TrollTeleport_SetEnabled(v)
    local TT = W.TrollTeleport
    TT.Enabled = v and true or false
    if not v then
        if TT.CharHook then pcall(function() TT.CharHook:Disconnect() end); TT.CharHook = nil end
        TT.IsProcessing = false
        return
    end
    local function TT_HookCharacter(char)
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3)
        if not anim then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        anim.AnimationPlayed:Connect(function(track)
            if not TT.Enabled then return end
            if TT.IsProcessing then return end
            local aid = track.Animation and track.Animation.AnimationId or ""
            local numId = aid:match("%d+")
            local delay = numId and TT.BlockedAnimList[numId]
            if not delay then return end
            TT.IsProcessing = true
            TT.TriggerCount = TT.TriggerCount + 1
            local startCF = root.CFrame
            W.PazzNotify("Troll TP", "Trigger #" .. TT.TriggerCount .. " | Delay " .. delay .. "s", 2)
            task.spawn(function()
                if track.IsPlaying then pcall(function() track.Stopped:Wait() end) end
                task.wait(delay)
                local c = LocalPlayer.Character
                local rp = c and c:FindFirstChild("HumanoidRootPart")
                if rp and rp.Parent then pcall(function() rp.CFrame = startCF end) end
                TT.IsProcessing = false
            end)
        end)
    end
    TT_HookCharacter(LocalPlayer.Character)
    TT.CharHook = LocalPlayer.CharacterAdded:Connect(function(c)
        task.wait(0.4)
        TT_HookCharacter(c)
    end)
end

-- ═══════════════ ESCAPE LOGIC ═══════════════
function W.Escape_Teleport()
    local Esc = W.Escape
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    local found = nil
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if string.lower(obj.Name) == string.lower(Esc.FinishLineName) and obj:IsA("BasePart") then
            found = obj; break
        end
    end
    if not found then return false end
    pcall(function() root.CFrame = found.CFrame + Vector3.new(0, 5, 0) end)
    Esc.TeleportCount = Esc.TeleportCount + 1
    W.PazzNotify("Instant Escape", "Teleported! (#" .. Esc.TeleportCount .. ")", 2)
    return true
end

-- ═══════════════ MYERS GRAB LOGIC ═══════════════
function W.getMyersTarget()
    local char = LocalPlayer.Character
    if not char then return nil end
    local myHRP = char:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end
    local candidates = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                table.insert(candidates, {
                    player = player,
                    dist = (hrp.Position - myHRP.Position).Magnitude
                })
            end
        end
    end
    table.sort(candidates, function(a, b) return a.dist < b.dist end)
    for _, c in ipairs(candidates) do return c.player end
    return nil
end

function W.doMyersGrab()
    if not W.MyersGrabData.Enabled then return end
    local target = W.getMyersTarget()
    if not target or not target.Character then return end
    pcall(function()
        ReplicatedStorage.Remotes.Killers.Stalker.grab:FireServer(target.Character)
    end)
end

function W.setMyersGrab(v)
    W.MyersGrabData.Enabled = v and true or false
    VD.KILLER_InfGrab = W.MyersGrabData.Enabled
    if W.Gluto_MGrabBtn_UpdateVisual then pcall(W.Gluto_MGrabBtn_UpdateVisual) end
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == W.MyersGrabData.HotkeyCode and W.MyersGrabData.Enabled then
        W.doMyersGrab()
    end
end)

-- ═══════════════ MOONWALK LOGIC ═══════════════
do
    local moonwalkEnabled = false
    local moonwalkConn = nil
    local MOONWALK_SIDE_SPEED = 0.9
    local MOONWALK_BACK_SPEED = 1.2
    local MOONWALK_INTERVAL = 0.07

    local function stopMoonwalk()
        if moonwalkConn then moonwalkConn:Disconnect(); moonwalkConn = nil end
    end
    local function startMoonwalk()
        stopMoonwalk()
        local lastSwitch = 0
        local direction = 1
        moonwalkConn = RunService.RenderStepped:Connect(function()
            if not moonwalkEnabled then return end
            local c = LocalPlayer.Character
            if not c then return end
            local cHrp = c:FindFirstChild("HumanoidRootPart")
            local cHum = c:FindFirstChildOfClass("Humanoid")
            if not cHrp or not cHum or cHum.Health <= 0 then return end
            local now = tick()
            if now - lastSwitch >= MOONWALK_INTERVAL then
                direction = direction * -1
                lastSwitch = now
            end
            local back = cHrp.CFrame.LookVector * -MOONWALK_BACK_SPEED
            local side = cHrp.CFrame.RightVector * (direction * MOONWALK_SIDE_SPEED)
            cHum:Move(back + side, false)
        end)
    end
    local function setMoonwalk(state)
        moonwalkEnabled = state
        if state then startMoonwalk() else stopMoonwalk() end
        if W.Gluto_MoonwalkBtn_UpdateVisual then pcall(W.Gluto_MoonwalkBtn_UpdateVisual) end
    end
    W.setMoonwalk = setMoonwalk
    W.getMoonwalk = function() return moonwalkEnabled end

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.F8 then setMoonwalk(not moonwalkEnabled) end
    end)
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(2)
        if moonwalkEnabled then startMoonwalk() end
    end)
end

-- ═══════════════ INVISIBLE API (MengHub) ═══════════════
do
    local MV = getgenv().GlutoInvis
    if not MV then
        MV = {
            Enabled = false, Loading = false, Ready = false, API = nil,
            _lastToggle = 0, _retries = 0, _retryMax = 3,
            _retryDelay = 2, _queueState = nil,
        }
        getgenv().GlutoInvis = MV
    end
    local INVIS_URL = "https://leekguy.vercel.app/roblox/menghub/crack_obf_invisible_93978595733734.lua"
    local function Invis_ValidateAPI(api)
        if type(api) ~= "table" then return false end
        if type(api.enable) ~= "function" then return false end
        if type(api.disable) ~= "function" then return false end
        return true
    end
    local function Invis_Cleanup()
        pcall(function()
            local chair = Workspace:FindFirstChild("invischair")
            if chair then chair:Destroy() end
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        if part.Name ~= "Hurtbox"
                            and part.Name ~= "HumanoidRootPart"
                            and part.Name ~= "HRP_Clone" then
                            part.Transparency = 0
                            if part:IsA("BasePart") then
                                part.LocalTransparencyModifier = 0
                            end
                        end
                    end
                end
            end
        end)
    end
    local function Invis_RefreshButton()
        if W.Gluto_InvisBtn_UpdateVisual then pcall(W.Gluto_InvisBtn_UpdateVisual) end
    end
    local function Invis_LoadAPI()
        if _G.MengHub and _G.MengHub.Invisible and Invis_ValidateAPI(_G.MengHub.Invisible) then
            MV.API = _G.MengHub.Invisible
            MV.Ready = true
            return true
        end
        MV.Loading = true; MV.Ready = false
        for attempt = 1, MV._retryMax do
            MV._retries = attempt
            local ok = pcall(function() loadstring(game:HttpGet(INVIS_URL))() end)
            task.wait(0.5)
            if ok and _G.MengHub and _G.MengHub.Invisible and Invis_ValidateAPI(_G.MengHub.Invisible) then
                MV.API = _G.MengHub.Invisible
                MV.Ready = true; MV.Loading = false
                Invis_RefreshButton()
                if MV._queueState ~= nil then
                    local queued = MV._queueState
                    MV._queueState = nil
                    task.defer(function() W.Invisible_SetState(queued, false) end)
                end
                return true
            else
                if attempt < MV._retryMax then task.wait(MV._retryDelay) end
            end
        end
        MV.Loading = false; MV.Ready = false
        Invis_RefreshButton()
        return false
    end
    task.spawn(function() Invis_LoadAPI() end)
    function W.Invisible_SetState(state, fromButton)
        state = state and true or false
        local now = tick()
        if now - MV._lastToggle < 0.25 then return end
        if not MV.API then
            if MV.Loading then
                MV._queueState = state
            else
                MV._queueState = state
                task.spawn(function()
                    if Invis_LoadAPI() then
                        local q = MV._queueState
                        MV._queueState = nil
                        if q ~= nil then task.defer(function() W.Invisible_SetState(q, fromButton) end) end
                    end
                end)
            end
            return
        end
        if MV.Enabled == state then
            if not state then Invis_Cleanup() end
            Invis_RefreshButton()
            return
        end
        MV._lastToggle = now
        MV.Enabled = state
        VD.Invis_Enabled = state
        if state then
            local ok = pcall(function() MV.API.enable() end)
            if not ok then
                MV.Enabled = false; VD.Invis_Enabled = false
                Invis_Cleanup()
            end
        else
            pcall(function() MV.API.disable() end)
            Invis_Cleanup()
        end
        Invis_RefreshButton()
    end
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        local hk = Enum.KeyCode[VD.Invis_Hotkey or "G"]
        if hk and input.KeyCode == hk then
            W.Invisible_SetState(not MV.Enabled, false)
        end
    end)
end

-- ═══════════════ FLOATING BUTTON INSTANCES (BULAT + ICON) ═══════════════

-- Self Heal
local SelfHealBtnState = { Enabled=false, Gui=nil, SavedPos=UDim2.new(0.02,0,0.28,0), Connections={} }
local SelfHealState = W.CreateFloatingButton({
    id="SelfHeal", title="Heal", notifyTitle="Self Heal",
    state=SelfHealBtnState,
    isOn=function() return W.InstantHealSelf end,
    onToggle=function(v) W.setInstantHealSelf(v) end,
    iconAsset="6031090004",   -- Heart icon
})
W.Gluto_SHB_SetEnabled = function(en) SelfHealState.SetEnabled(en) end
W.Gluto_SHB_UpdateVisual = function() SelfHealState.UpdateVisual() end

-- Self Unhook
local SelfUnhookBtnState = { Enabled=false, Gui=nil, SavedPos=UDim2.new(0.02,0,0.36,0), Connections={} }
local SelfUnhookState = W.CreateFloatingButton({
    id="SelfUnhook", title="Hook", notifyTitle="Self Unhook",
    state=SelfUnhookBtnState,
    isOn=function() return W.SelfUnhook.Enabled end,
    onToggle=function(v) W.SU_SetEnabled(v) end,
    iconAsset="6023564252",   -- Link icon
})
W.Gluto_SUB_SetEnabled = function(en) SelfUnhookState.SetEnabled(en) end
W.Gluto_SUB_UpdateVisual = function() SelfUnhookState.UpdateVisual() end

-- Troll Teleport
local TrollTPBtnState = { Enabled=false, Gui=nil, SavedPos=UDim2.new(0.02,0,0.44,0), Connections={} }
local TrollTPState = W.CreateFloatingButton({
    id="TrollTP", title="T_TP", notifyTitle="Troll TP",
    state=TrollTPBtnState,
    isOn=function() return W.TrollTeleport.Enabled end,
    onToggle=function(v) W.TrollTeleport_SetEnabled(v) end,
    iconAsset="6035047381",   -- Location icon
})
W.Gluto_TTB_SetEnabled = function(en) TrollTPState.SetEnabled(en) end
W.Gluto_TTB_UpdateVisual = function() TrollTPState.UpdateVisual() end

-- Escape
local EscapeBtnState = { Enabled=false, Gui=nil, SavedPos=UDim2.new(0.02,0,0.52,0), Connections={} }
local EscapeState = W.CreateFloatingButton({
    id="Escape", title="Escape", notifyTitle="Escape",
    state=EscapeBtnState,
    isOn=function() return W.Escape.Enabled end,
    onToggle=function(v)
        W.Escape.Enabled = v
        if v then W.Escape_Teleport() end
    end,
    iconAsset="6034684933",   -- Door icon
})
W.Gluto_Escape_SetEnabled = function(en) EscapeState.SetEnabled(en) end
W.Gluto_Escape_UpdateVisual = function() EscapeState.UpdateVisual() end

-- Parry
local ParryBtnState = { Enabled=false, Gui=nil, SavedPos=UDim2.new(0.02,0,0.60,0), Connections={} }
local ParryBtnInst = W.CreateFloatingButton({
    id="Parry", title="Parry", notifyTitle="Parry",
    state=ParryBtnState,
    isOn=function() return VD.PARRY_Enabled end,
    onToggle=function(v)
        VD.PARRY_Enabled = v
        if not v and W.ParryState then W.ParryState.ActiveAttackers = {} end
    end,
    iconAsset="6031075868",   -- Shield icon
})
W.Gluto_ParryBtn_SetEnabled = function(en) ParryBtnInst.SetEnabled(en) end
W.Gluto_ParryBtn_UpdateVisual = function() ParryBtnInst.UpdateVisual() end

-- Invisible
local InvisBtnState = { Enabled=false, Gui=nil, SavedPos=UDim2.new(0.02,0,0.68,0), Connections={} }
local InvisBtnInst = W.CreateFloatingButton({
    id="Invisible", title="Invis", notifyTitle="Invisible",
    state=InvisBtnState,
    isOn=function()
        local MV = getgenv().GlutoInvis
        return MV and MV.Enabled or false
    end,
    onToggle=function(v) W.Invisible_SetState(v, true) end,
    iconAsset="6031094674",   -- Eye-off icon
})
W.Gluto_InvisBtn_SetEnabled = function(en) InvisBtnInst.SetEnabled(en) end
W.Gluto_InvisBtn_UpdateVisual = function() InvisBtnInst.UpdateVisual() end

-- Myers Grab
local MyersGrabBtnState = { Enabled=false, Gui=nil, SavedPos=UDim2.new(0.02,0,0.76,0), Connections={} }
local MyersGrabInst = W.CreateFloatingButton({
    id="MyersGrab", title="Grab", notifyTitle="Myers Grab",
    state=MyersGrabBtnState,
    isOn=function() return W.MyersGrabData.Enabled end,
    onToggle=function(v) W.setMyersGrab(v) end,
    iconAsset="6031236563",   -- Hand icon
})
W.Gluto_MGrabBtn_SetEnabled = function(en) MyersGrabInst.SetEnabled(en) end
W.Gluto_MGrabBtn_UpdateVisual = function() MyersGrabInst.UpdateVisual() end

-- Moonwalk
local MoonwalkBtnState = { Enabled=false, Gui=nil, SavedPos=UDim2.new(0.02,0,0.84,0), Connections={} }
local MoonwalkInst = W.CreateFloatingButton({
    id="Moonwalk", title="Moonwalk", notifyTitle="Moonwalk",
    state=MoonwalkBtnState,
    isOn=function() return W.getMoonwalk and W.getMoonwalk() or false end,
    onToggle=function(v) if W.setMoonwalk then W.setMoonwalk(v) end end,
    iconAsset="6031261240",   -- Moon icon
})
W.Gluto_MoonwalkBtn_SetEnabled = function(en) MoonwalkInst.SetEnabled(en) end
W.Gluto_MoonwalkBtn_UpdateVisual = function() MoonwalkInst.UpdateVisual() end-- [[PART 13/20]]

-- ═══════════════ AUTO ATTACK (KILLER) ═══════════════
local lastAutoAttack = 0
function W.KA_AutoAttack()
    if not VD.KILLER_AutoAttack then return end
    if GetRole() ~= "Killer" then return end
    local now = tick()
    if now - lastAutoAttack < (VD.KILLER_AutoAttackCooldown or 0.15) then return end
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local closest, shortest = nil, VD.KILLER_AutoAttackRange or 12
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
            local attacks = ReplicatedStorage:FindFirstChild("Remotes")
                and ReplicatedStorage.Remotes:FindFirstChild("Attacks")
            local basic = attacks and attacks:FindFirstChild("BasicAttack")
            if basic then basic:FireServer(false) end
        end)
    end
end

task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(W.KA_AutoAttack)
    end
end)

-- ═══════════════ INFINITE LUNGE ═══════════════
local VD_OriginalLungeBoost = nil
function W.VD_UpdateInfiniteLunge()
    local char = LocalPlayer.Character
    if not char then return end
    if VD.KILLER_InfLunge then
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
LocalPlayer.CharacterRemoving:Connect(function()
    VD_OriginalLungeBoost = nil
end)
task.spawn(function()
    while true do
        task.wait(0.2)
        pcall(W.VD_UpdateInfiniteLunge)
    end
end)

-- ═══════════════ COUNTER AUTO PARRY ═══════════════
do
    local AntiAutoParryEnabled = false
    local CounterParryAnimList = {}
    for id, _ in pairs(W.KillerAttackAnims) do
        table.insert(CounterParryAnimList, id)
    end

    task.spawn(function()
        while true do
            task.wait(0.5)
            if not AntiAutoParryEnabled then continue end
            local char = LocalPlayer.Character
            if not char then continue end
            local myRoot = char:FindFirstChild("HumanoidRootPart")
            if not myRoot then continue end
            local near = false
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and TeamIs(p, "Survivor") then
                    local r = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                    if r and (myRoot.Position - r.Position).Magnitude <= 15 then
                        near = true; break
                    end
                end
            end
            if near then
                local randomId = CounterParryAnimList[math.random(1, #CounterParryAnimList)]
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://" .. randomId
                local hum = char:FindFirstChildOfClass("Humanoid")
                local animator = hum and hum:FindFirstChildOfClass("Animator")
                if animator then
                    local track = animator:LoadAnimation(anim)
                    track:Play()
                    track:AdjustWeight(0)
                    task.wait(0.05)
                    track:Stop()
                    anim:Destroy()
                end
            end
        end
    end)

    W.CounterParry_SetEnabled = function(v)
        AntiAutoParryEnabled = v and true or false
    end
end

-- ═══════════════ AIM LOCK ATTACK (KILLER) ═══════════════
do
    local AttackAim = {
        Enabled = false, Holding = false, Strength = 1,
        Predict = true, PredictStrength = 0.12, FOV = 250,
        VisibilityCheck = true, AimPart = "HumanoidRootPart",
    }
    W.AttackAim_Cfg = AttackAim

    local AttackAimConnection = nil
    local CurrentAttackButton = nil
    local AttackPaths = {
        "Slasher-mob.Controls.attack",
        "Masked-mob.Controls.attack",
        "Killer-mob.Controls.attack",
    }

    local RayParams = RaycastParams.new()
    RayParams.FilterType = Enum.RaycastFilterType.Exclude

    local function AL_IsVisible(part)
        local cam = Workspace.CurrentCamera
        if not cam then return true end
        RayParams.FilterDescendantsInstances = { LocalPlayer.Character }
        local origin = cam.CFrame.Position
        local dir = part.Position - origin
        local result = Workspace:Raycast(origin, dir, RayParams)
        if not result then return true end
        return result.Instance:IsDescendantOf(part.Parent)
    end

    local function AL_GetAttackButton()
        for _, path in ipairs(AttackPaths) do
            local current = LocalPlayer:FindFirstChild("PlayerGui")
            for seg in string.gmatch(path, "[^%.]+") do
                current = current and current:FindFirstChild(seg)
            end
            if current and current:IsA("GuiObject") then return current end
        end
        return nil
    end

    local function AL_GetClosestAttackTarget()
        local cam = Workspace.CurrentCamera
        if not cam then return nil end
        local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
        local closest, shortest = nil, AttackAim.FOV
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TeamIs(p, "Survivor") and p.Character then
                local hrp = p.Character:FindFirstChild(AttackAim.AimPart)
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    local pos, visible = cam:WorldToViewportPoint(hrp.Position)
                    if visible then
                        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        if dist < shortest then
                            if AttackAim.VisibilityCheck then
                                if not AL_IsVisible(hrp) then continue end
                            end
                            shortest = dist
                            closest = hrp
                        end
                    end
                end
            end
        end
        return closest
    end

    local function AL_StartAttackAim()
        if AttackAimConnection then return end
        AttackAimConnection = RunService.RenderStepped:Connect(function()
            if not AttackAim.Enabled then return end
            if not AttackAim.Holding then return end
            local target = AL_GetClosestAttackTarget()
            if not target then return end
            local cam = Workspace.CurrentCamera
            local pos = target.Position
            if AttackAim.Predict then
                pos = pos + (target.AssemblyLinearVelocity * AttackAim.PredictStrength)
            end
            cam.CFrame = CFrame.new(cam.CFrame.Position, pos)
        end)
    end
    W.AttackAim_Start = AL_StartAttackAim

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType == Enum.UserInputType.MouseButton2 and AttackAim.Enabled then
            AttackAim.Holding = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            AttackAim.Holding = false
        end
    end)

    task.spawn(function()
        while true do
            task.wait(1)
            local btn = AL_GetAttackButton()
            if btn and btn ~= CurrentAttackButton then
                CurrentAttackButton = btn
                btn.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch and AttackAim.Enabled then
                        AttackAim.Holding = true
                    end
                end)
                btn.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch then
                        AttackAim.Holding = false
                    end
                end)
            end
        end
    end)
end

-- ═══════════════ BYPASS SYSTEMS ═══════════════

-- Hidden Leap Bypass
getgenv().Bypass_HiddenLeapBypassThread = nil
function W.BYPASS_StartHiddenCooldownBypass()
    if getgenv().Bypass_HiddenLeapBypassThread then return end
    getgenv().Bypass_HiddenLeapBypassThread = task.spawn(function()
        local leapFunction, m2Function
        local function scanGC()
            pcall(function()
                for _, v in pairs(getgc(true)) do
                    if type(v) == "function" and islclosure(v) then
                        local info
                        pcall(function() info = debug.getinfo(v) end)
                        if info then
                            if info.name == "tryActivate" then leapFunction = v
                            elseif info.name == "playM2Animation" then m2Function = v end
                        end
                    end
                    if leapFunction and m2Function then break end
                end
            end)
        end
        scanGC()
        local lastScan = os.clock()
        while task.wait(0.1) do
            if not VD.KILLER_BypassLeap then break end
            if not (leapFunction and m2Function) then
                if os.clock() - lastScan >= 2 then lastScan = os.clock(); scanGC() end
            end
            if leapFunction then
                pcall(function()
                    for i, val in pairs(debug.getupvalues(leapFunction)) do
                        if type(val) == "boolean" and val == true then
                            debug.setupvalue(leapFunction, i, false)
                        end
                    end
                end)
            end
            if m2Function then
                pcall(function()
                    for i, val in pairs(debug.getupvalues(m2Function)) do
                        if type(val) == "boolean" and val == true then
                            debug.setupvalue(m2Function, i, false)
                        end
                    end
                end)
            end
        end
        getgenv().Bypass_HiddenLeapBypassThread = nil
    end)
end
function W.BYPASS_SetHiddenLeap(v)
    VD.KILLER_BypassLeap = v and true or false
    if VD.KILLER_BypassLeap then W.BYPASS_StartHiddenCooldownBypass() end
end

-- Slasher Bypass
getgenv().MAWWW_SlasherCooldownBypassThread = nil
function W.MAWWW_StartSlasherCooldownBypass()
    if getgenv().MAWWW_SlasherCooldownBypassThread then return end
    pcall(function()
        local b = true
        local mt = debug.getmetatable(b)
        if not mt then mt = {}; debug.setmetatable(b, mt) end
        if setreadonly then setreadonly(mt, false) end
        mt.__div = function() return 0 end
        mt.__mul = function() return 0 end
        mt.__add = function() return 0 end
        mt.__sub = function() return 0 end
        if setreadonly then setreadonly(mt, true) end
    end)
    getgenv().MAWWW_SlasherCooldownBypassThread = task.spawn(function()
        local toggleFunc = nil
        local pursuitHandler = nil
        local function scanGCForSlasher()
            pcall(function()
                for _, v in pairs(getgc(true)) do
                    if type(v) == "function" and islclosure(v) then
                        local consts = debug.getconstants(v)
                        local hasOffset, hasLinear, hasAction, hasTweenInfo = false, false, false, false
                        local hasPursuit, hasWalkSpeed = false, false
                        for _, c in pairs(consts) do
                            if c == "Offset" then hasOffset = true end
                            if c == "Linear" then hasLinear = true end
                            if c == "action" then hasAction = true end
                            if c == "TweenInfo" then hasTweenInfo = true end
                            if c == "Pursuit" then hasPursuit = true end
                            if c == "WalkSpeed" then hasWalkSpeed = true end
                        end
                        if hasOffset and hasLinear and hasAction and hasTweenInfo and not hasPursuit then toggleFunc = v end
                        if hasPursuit and hasTweenInfo and hasAction and hasWalkSpeed then pursuitHandler = v end
                    end
                    if toggleFunc and pursuitHandler then break end
                end
            end)
        end
        scanGCForSlasher()
        local lastScan = os.clock()
        while task.wait(0.1) do
            if not VD.KILLER_InfLakeMist and not VD.KILLER_InfPursuit then break end
            if not (toggleFunc and pursuitHandler) then
                if os.clock() - lastScan >= 2 then scanGCForSlasher(); lastScan = os.clock() end
            end
            if toggleFunc and VD.KILLER_InfLakeMist then
                pcall(function()
                    debug.setupvalue(toggleFunc, 6, false)
                    debug.setupvalue(toggleFunc, 10, false)
                end)
            end
            if pursuitHandler and VD.KILLER_InfPursuit then
                pcall(function()
                    debug.setupvalue(pursuitHandler, 5, false)
                    debug.setupvalue(pursuitHandler, 6, false)
                end)
            end
        end
        getgenv().MAWWW_SlasherCooldownBypassThread = nil
    end)
end
function W.MAWWW_SetLakeMist(v)
    VD.KILLER_InfLakeMist = v and true or false
    if VD.KILLER_InfLakeMist or VD.KILLER_InfPursuit then W.MAWWW_StartSlasherCooldownBypass() end
end
function W.MAWWW_SetPursuit(v)
    VD.KILLER_InfPursuit = v and true or false
    if VD.KILLER_InfLakeMist or VD.KILLER_InfPursuit then W.MAWWW_StartSlasherCooldownBypass() end
end

-- Abyss Bypass
getgenv().MAWWW_AbyssCooldownBypassConnection = nil
getgenv().MAWWW_CorruptHandlerFunc = nil
function W.MAWWW_StartAbyssCooldownBypass()
    if not getgenv().MAWWW_CorruptHandlerFunc then
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if type(v) == "function" and islclosure(v) then
                    local constants = debug.getconstants(v)
                    if table.find(constants, "corrupt") and table.find(constants, "Immobile") then
                        getgenv().MAWWW_CorruptHandlerFunc = v
                        break
                    end
                end
            end
        end)
    end
    if not getgenv().MAWWW_CorruptHandlerFunc then return end
    if getgenv().MAWWW_AbyssCooldownBypassConnection then
        getgenv().MAWWW_AbyssCooldownBypassConnection:Disconnect()
    end
    getgenv().MAWWW_AbyssCooldownBypassConnection = RunService.Heartbeat:Connect(function()
        if not VD.KILLER_BypassCooldown then return end
        if getgenv().MAWWW_CorruptHandlerFunc then
            local upvalues = debug.getupvalues(getgenv().MAWWW_CorruptHandlerFunc)
            for idx, val in pairs(upvalues) do
                if type(val) == "boolean" and val == false then
                    debug.setupvalue(getgenv().MAWWW_CorruptHandlerFunc, idx, true)
                end
            end
        end
    end)
end
function W.MAWWW_StopAbyssCooldownBypass()
    if getgenv().MAWWW_AbyssCooldownBypassConnection then
        getgenv().MAWWW_AbyssCooldownBypassConnection:Disconnect()
        getgenv().MAWWW_AbyssCooldownBypassConnection = nil
    end
end
function W.MAWWW_SetAbyssBypass(v)
    VD.KILLER_BypassCooldown = v and true or false
    if VD.KILLER_BypassCooldown then W.MAWWW_StartAbyssCooldownBypass()
    else W.MAWWW_StopAbyssCooldownBypass() end
end

-- Jeff Frenzy
getgenv().MAWWW_JeffCooldownBypassThread = nil
function W.MAWWW_StartJeffCooldownBypass()
    if getgenv().MAWWW_JeffCooldownBypassThread then return end
    getgenv().MAWWW_JeffCooldownBypassThread = task.spawn(function()
        while task.wait() do
            if not VD.KILLER_InfFrenzy then break end
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:GetAttribute("Frenzy") ~= true then
                    char:SetAttribute("Frenzy", true)
                end
            end)
        end
        getgenv().MAWWW_JeffCooldownBypassThread = nil
    end)
end
function W.MAWWW_StopJeffCooldownBypass()
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:GetAttribute("Frenzy") == true then
            char:SetAttribute("Frenzy", false)
            local killer = ReplicatedStorage:FindFirstChild("Remotes")
                and ReplicatedStorage.Remotes:FindFirstChild("Killers")
                and ReplicatedStorage.Remotes.Killers:FindFirstChild("Killer")
            if killer then
                local deact = killer:FindFirstChild("Deactivatefromclient")
                if deact then deact:FireServer() end
            end
        end
    end)
end
function W.MAWWW_SetJeffFrenzy(v)
    VD.KILLER_InfFrenzy = v and true or false
    if VD.KILLER_InfFrenzy then W.MAWWW_StartJeffCooldownBypass()
    else W.MAWWW_StopJeffCooldownBypass() end
end

-- Anti Blind
function W.SetupAntiBlind()
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
                    if not checkcaller() and VD.KILLER_AntiBlind and self == gb then
                        local method = getnamecallmethod()
                        if method == "FireServer" and W.GetRole() == "Killer" then
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
pcall(W.SetupAntiBlind)

-- ═══════════════ KILLER UI BINDING ═══════════════
KilCombat:AddToggle("AutoAttack", {
    Text = "Auto Attack",
    Default = false,
    Callback = function(v) VD.KILLER_AutoAttack = v end,
})
KilCombat:AddSlider("AutoAttackRange", {
    Text = "Attack Range", Default = 12, Min = 5, Max = 30, Rounding = 1,
    Suffix = " studs",
    Callback = function(v) VD.KILLER_AutoAttackRange = v end,
})
KilCombat:AddSlider("AutoAttackCd", {
    Text = "Attack Cooldown", Default = 0.15, Min = 0.05, Max = 1, Rounding = 0.05,
    Suffix = "s",
    Callback = function(v) VD.KILLER_AutoAttackCooldown = v end,
})
KilCombat:AddDivider()
KilCombat:AddToggle("InfLunge", {
    Text = "Infinite Lunge",
    Default = false,
    Callback = function(v) VD.KILLER_InfLunge = v end,
})
KilCombat:AddToggle("CounterParry", {
    Text = "Counter Auto Parry",
    Default = false,
    Callback = function(v) if W.CounterParry_SetEnabled then W.CounterParry_SetEnabled(v) end end,
})
KilCombat:AddToggle("AimLockAttack", {
    Text = "Aim Lock Attack",
    Default = false,
    Callback = function(v)
        if W.AttackAim_Cfg then W.AttackAim_Cfg.Enabled = v end
        if v and W.AttackAim_Start then W.AttackAim_Start() end
    end,
})
KilCombat:AddSlider("AimAttackFOV", {
    Text = "Aim Attack FOV", Default = 250, Min = 50, Max = 1000, Rounding = 10,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.FOV = v end end,
})
KilCombat:AddDivider()
KilCombat:AddToggle("AntiBlind", {
    Text = "Anti Blind",
    Default = false,
    Callback = function(v) VD.KILLER_AntiBlind = v end,
})
KilCombat:AddToggle("DestroyPallet", {
    Text = "Auto Destroy Pallet",
    Default = false,
    Callback = function(v) VD.KILLER_DestroyPallets = v end,
})
KilCombat:AddDivider()
KilCombat:AddToggle("ShowMyersBtn", {
    Text = "Show Myers Grab Button",
    Default = false,
    Callback = function(v)
        if W.Gluto_MGrabBtn_SetEnabled then W.Gluto_MGrabBtn_SetEnabled(v) end
    end,
})

-- Bypass UI
KilBypass:AddToggle("BypassHidden", {
    Text = "Hidden Leap Bypass",
    Default = false,
    Callback = function(v) W.BYPASS_SetHiddenLeap(v) end,
})
KilBypass:AddToggle("MyersInfGrab", {
    Text = "Myers Infinite Grab",
    Default = false,
    Callback = function(v) W.setMyersGrab(v) end,
})
KilBypass:AddToggle("SlasherLakeMist", {
    Text = "Slasher Inf LakeMist",
    Default = false,
    Callback = function(v) W.MAWWW_SetLakeMist(v) end,
})
KilBypass:AddToggle("SlasherPursuit", {
    Text = "Slasher Inf Pursuit",
    Default = false,
    Callback = function(v) W.MAWWW_SetPursuit(v) end,
})
KilBypass:AddToggle("AbyssBypass", {
    Text = "Abyss Bypass Cooldown",
    Default = false,
    Callback = function(v) W.MAWWW_SetAbyssBypass(v) end,
})
KilBypass:AddToggle("JeffFrenzy", {
    Text = "Jeff Infinite Frenzy",
    Default = false,
    Callback = function(v) W.MAWWW_SetJeffFrenzy(v) end,
})-- [[PART 14/20]]

-- ═══════════════ AUTO HOOK (KILLER) ═══════════════
do
    local IsAutoHooking = false

    local function GetMapCacheHooks()
        local hooks = {}
        local map = Workspace:FindFirstChild("Map")
        if not map then return hooks end
        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Hook" then
                local hp = obj:FindFirstChild("HookPoint")
                    or obj:FindFirstChild("HookHitbox")
                    or obj:FindFirstChildWhichIsA("BasePart", true)
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

    local function IsPlayerCarried(character)
        return character:GetAttribute("IsCarried") == true
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
            if IsPlayerCarried(pl.Character) then continue end
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
        if not VD.KILLER_AutoHook then return end
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
                local hookPoint = nearestHook.model:FindFirstChild("HookPoint")
                    or nearestHook.model:FindFirstChild("HookHitbox")
                    or nearestHook.part
                if HookEvent then HookEvent:FireServer(hookPoint) end
                if HookCommit then HookCommit:FireServer(hookPoint) end
            end)
            task.wait(1)
            IsAutoHooking = false
        end)
    end

    function W.KA_StartAutoHook()
        if W._AutoHookThread then return end
        W._AutoHookThread = task.spawn(function()
            while VD.KILLER_AutoHook do
                if GetRole() == "Killer" then pcall(DoAutoHook) end
                task.wait(1)
            end
            W._AutoHookThread = nil
        end)
    end

    function W.KA_StopAutoHook()
        if W._AutoHookThread then
            pcall(function() task.cancel(W._AutoHookThread) end)
            W._AutoHookThread = nil
        end
    end

    function W.KA_SetAutoHook(v)
        VD.KILLER_AutoHook = v and true or false
        if VD.KILLER_AutoHook then W.KA_StartAutoHook() else W.KA_StopAutoHook() end
    end
end

-- ═══════════════ KILLER ABILITIES ═══════════════
do
    local KA = {
        AutoStalk = VD.KA_AutoStalk, AutoStalkRange = VD.KA_AutoStalkRange,
        AutoKillAll = VD.KA_AutoKillAll, DropAllPallet = VD.KA_DropAllPallet,
        BlockAllVault = VD.KA_BlockAllVault,
    }
    W.KA_Table = KA

    function W.KA_GetClosestSurvivor(range, minHealth)
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local closest, shortest = nil, (range or math.huge)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and TeamIs(plr, "Survivor") then
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > (minHealth or 30) then
                    local d = (hrp.Position - root.Position).Magnitude
                    if d <= shortest then shortest = d; closest = plr end
                end
            end
        end
        return closest
    end

    -- Auto Stalk
    local AutoStalkConnection = nil
    function W.KA_StartAutoStalk()
        if AutoStalkConnection then return end
        AutoStalkConnection = RunService.Heartbeat:Connect(function()
            if not KA.AutoStalk then return end
            if GetRole() ~= "Killer" then return end
            local target = W.KA_GetClosestSurvivor(KA.AutoStalkRange, 30)
            if not target or not target.Character then return end
            local stalkEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
                and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
                and ReplicatedStorage.Remotes.Killers:FindFirstChild("Stalker", true)
                and ReplicatedStorage.Remotes.Killers.Stalker:FindFirstChild("StartStalking")
            if stalkEvent then pcall(function() stalkEvent:FireServer(target) end) end
        end)
    end
    function W.KA_StopAutoStalk()
        if AutoStalkConnection then
            pcall(function() AutoStalkConnection:Disconnect() end)
            AutoStalkConnection = nil
        end
    end
    function W.KA_SetAutoStalk(v)
        KA.AutoStalk = v and true or false
        VD.KA_AutoStalk = KA.AutoStalk
        if KA.AutoStalk then W.KA_StartAutoStalk() else W.KA_StopAutoStalk() end
    end

    -- Auto Kill All
    local KillAllTarget = nil
    function W.KA_UpdateKillAll()
        if not KA.AutoKillAll then KillAllTarget = nil; return end
        if GetRole() ~= "Killer" then KillAllTarget = nil; return end
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local tChar = KillAllTarget and KillAllTarget.Character
        if not KillAllTarget or not tChar or not tChar.Parent
            or not tChar:FindFirstChild("Humanoid") or tChar.Humanoid.Health <= 35 then
            KillAllTarget = W.KA_GetClosestSurvivor(math.huge, 30)
            tChar = KillAllTarget and KillAllTarget.Character
        end
        if KillAllTarget and tChar then
            local targetHRP = tChar:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local velocity  = targetHRP.AssemblyLinearVelocity
                local predict   = velocity * 0.15
                local targetPos = targetHRP.Position + predict
                local behind    = targetHRP.CFrame.LookVector * -3
                root.CFrame = CFrame.new(targetPos + behind, targetPos)
            end
            pcall(function()
                local attacks = ReplicatedStorage:FindFirstChild("Remotes")
                    and ReplicatedStorage.Remotes:FindFirstChild("Attacks")
                local basic = attacks and attacks:FindFirstChild("BasicAttack")
                if basic then basic:FireServer(false) end
            end)
        end
    end
    function W.KA_SetAutoKillAll(v)
        KA.AutoKillAll = v and true or false
        VD.KA_AutoKillAll = KA.AutoKillAll
        if not KA.AutoKillAll then KillAllTarget = nil end
    end

    -- Drop All Pallet
    local lastDropAllPallet = 0
    function W.KA_DropAllPallets()
        if not KA.DropAllPallet then return end
        if GetRole() ~= "Killer" then return end
        local now = tick()
        if now - lastDropAllPallet < 2 then return end
        lastDropAllPallet = now
        pcall(function()
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            local palletFold = remotes and remotes:FindFirstChild("Pallet")
            local dropEvent = palletFold and palletFold:FindFirstChild("PalletDropEvent")
            if not dropEvent then return end
            local map = workspace:FindFirstChild("Map")
            if not map then return end
            for _, obj in ipairs(map:GetDescendants()) do
                if obj.Name == "Palletwrong" and (obj:IsA("Model") or obj:IsA("Folder")) then
                    local target = obj:FindFirstChild("PalletPointSlide") or obj:FindFirstChild("PalletPoint")
                    if target then pcall(function() dropEvent:FireServer(target) end) end
                end
            end
        end)
    end
    function W.KA_SetDropAllPallet(v)
        KA.DropAllPallet = v and true or false
        VD.KA_DropAllPallet = KA.DropAllPallet
    end

    -- Block All Vault
    local lastBlockVault = 0
    function W.KA_BlockAllVaults()
        if not KA.BlockAllVault then return end
        local VaultEvent = ReplicatedStorage:FindFirstChild("Remotes")
            and ReplicatedStorage.Remotes:FindFirstChild("Window")
            and ReplicatedStorage.Remotes.Window:FindFirstChild("VaultEvent")
        if not VaultEvent then return end
        local map = workspace:FindFirstChild("Map")
        if not map then return end
        for _, trigger in ipairs(map:GetDescendants()) do
            if trigger.Name == "VaultTrigger" then
                pcall(function() VaultEvent:FireServer(trigger, true) end)
            end
        end
    end
    function W.KA_SetBlockAllVault(v)
        KA.BlockAllVault = v and true or false
        VD.KA_BlockAllVault = KA.BlockAllVault
    end

    -- Main loop
    task.spawn(function()
        while true do
            task.wait(0.12)
            if KA.AutoKillAll then pcall(W.KA_UpdateKillAll) end
            if KA.DropAllPallet then pcall(W.KA_DropAllPallets) end
            if KA.BlockAllVault then pcall(W.KA_BlockAllVaults) end
        end
    end)
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if KA.AutoStalk then pcall(W.KA_StartAutoStalk) end
    end)
end

-- ═══════════════ DESTROY PALLET (Killer) ═══════════════
getgenv().MAWWW_IsBreakingPallet = false
function W.MAWWW_DestroyAllPallets()
    if not VD.KILLER_DestroyPallets then return end
    if W.GetRole() ~= "Killer" then return end
    if getgenv().MAWWW_IsBreakingPallet then return end

    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not root then return end

    local stunned = char:GetAttribute("IsStunned") or char:GetAttribute("isStunned")
    local immobile = char:GetAttribute("Immobile") or char:GetAttribute("immobile")
    local carrying = char:GetAttribute("IsCarrying") or char:GetAttribute("isCarrying")
    local ci = char:FindFirstChild("CheckInterractable")
    local action = ci and (ci:GetAttribute("action") or ci:GetAttribute("Action"))
    if stunned or immobile or carrying or action then return end

    local pts = CollectionService:GetTagged("PalletPointSlide")
    local nearest, minDist = nil, 6
    for _, p in ipairs(pts) do
        if p:IsA("BasePart") and not CollectionService:HasTag(p, "doing action") then
            local d = (p.Position - root.Position).Magnitude
            if d < minDist then minDist = d; nearest = p end
        end
    end
    if not nearest then return end

    getgenv().MAWWW_IsBreakingPallet = true
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
        task.wait(0.2)
        local start = os.clock()
        while char and char.Parent and (char:GetAttribute("Immobile") or char:GetAttribute("immobile")) do
            if os.clock() - start > 3 then break end
            task.wait(0.1)
        end
        getgenv().MAWWW_IsBreakingPallet = false
    end)
end

task.spawn(function()
    while true do
        task.wait(0.5)
        if VD.KILLER_DestroyPallets then
            pcall(W.MAWWW_DestroyAllPallets)
        end
    end
end)

-- ═══════════════ MASKED POWER ═══════════════
function W.Masked_Activate()
    local Masked = W.Masked
    local ev = ReplicatedStorage:FindFirstChild("Remotes", true)
        and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
        and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
        and ReplicatedStorage.Remotes.Masked:FindFirstChild("Activatepower")
    if ev then
        pcall(function() ev:FireServer(Masked.CurrentPower) end)
        W.PazzNotify("Masked Power", "Activated: " .. Masked.CurrentPower, 2)
    end
end
function W.Masked_Deactivate()
    local ev = ReplicatedStorage:FindFirstChild("Remotes", true)
        and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
        and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
        and ReplicatedStorage.Remotes.Masked:FindFirstChild("Deactivatepower")
    if ev then
        pcall(function() ev:FireServer() end)
        W.PazzNotify("Masked Power", "Deactivated", 2)
    end
end

-- ═══════════════ KILLER PERKS DISPLAY (WHITE) ═══════════════
do
    local PerkDisplayState = { Gui = nil, Thread = nil, Enabled = false, Minimized = false }

    local function GetKillerPlayer()
        for _, p in ipairs(Players:GetPlayers()) do
            if TeamIs(p, "Killer") then return p end
        end
        return nil
    end

    local function FormatPerkName(name)
        name = tostring(name or "")
        local clean = name:gsub("_", " "):gsub("-", " ")
        clean = clean:gsub("(%l)(%u)", "%1 %2")
        clean = clean:gsub("(%a)(%d)", "%1 %2")
        clean = clean:gsub("(%d)(%a)", "%1 %2")
        clean = clean:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
        return clean ~= "" and clean or "Unknown"
    end

    local function ParsePerkName(name)
        name = tostring(name or "")
        local perkName, level = name:match("^(.+)%s+(%d+)$")
        if not perkName then return nil end
        perkName = perkName:gsub("^%s+", ""):gsub("%s+$", "")
        if perkName == "" then return nil end
        local lower = perkName:lower()
        local excluded = {
            head=true,torso=true,humanoid=true,
            ["left arm"]=true,["right arm"]=true,
            ["left leg"]=true,["right leg"]=true,
            ["humanoidrootpart"]=true,
        }
        if excluded[lower] then return nil end
        return perkName, level
    end

    local function ReadPerksFromChar(char)
        if not char then return {} end
        local result, seen = {}, {}
        local function addPerk(rawName, displayName, level)
            if not rawName then return end
            rawName = tostring(rawName)
            if rawName == "" or rawName == "nil" then return end
            if rawName:lower():find("template") then return end
            if seen[rawName] then return end
            seen[rawName] = true
            table.insert(result, {
                Raw = rawName,
                Name = displayName and tostring(displayName) or FormatPerkName(rawName),
                Level = level and tostring(level) or nil,
            })
        end

        local function scanAttrs(inst)
            if not inst.GetAttributes then return end
            local attrs = inst:GetAttributes()
            for k, v in pairs(attrs) do
                local lk = tostring(k):lower()
                if lk:find("perk") then
                    if type(v) == "string" then addPerk(v)
                    elseif v == true then addPerk(k)
                    elseif type(v) == "number" and lk:find("level") then
                        local bn = tostring(k):gsub("[Ll]evel",""):gsub("[Pp]erk","")
                        if bn ~= "" then addPerk(bn, nil, v) end
                    end
                end
            end
        end

        scanAttrs(char)
        for _, child in ipairs(char:GetChildren()) do
            local pn, lv = ParsePerkName(child.Name)
            if pn then addPerk(child.Name, pn, lv) end
        end
        for _, inst in ipairs(char:GetDescendants()) do
            scanAttrs(inst)
            local lower = inst.Name:lower()
            if lower == "perks" or lower == "killerperks"
                or lower:find("perkfolder") or lower:find("perklist") then
                for _, child in ipairs(inst:GetChildren()) do
                    if child:IsA("StringValue") then addPerk(child.Value)
                    elseif child:IsA("IntValue") or child:IsA("NumberValue") then addPerk(child.Name, nil, child.Value)
                    elseif child:IsA("BoolValue") and child.Value then addPerk(child.Name) end
                end
            elseif lower:find("perk") then
                if inst:IsA("StringValue") then addPerk(inst.Value)
                elseif inst:IsA("BoolValue") and inst.Value then addPerk(inst.Name) end
            end
        end
        table.sort(result, function(a, b) return tostring(a.Name) < tostring(b.Name) end)
        return result
    end

    local function BuildGui()
        if PerkDisplayState.Gui then pcall(function() PerkDisplayState.Gui:Destroy() end) end
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if gethui then
            local ok, hui = pcall(gethui)
            if ok and hui then pg = hui end
        end
        if not pg then return end

        local gui = Instance.new("ScreenGui")
        gui.Name = "PazzKillerPerks"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 60
        gui.Parent = pg

        local frame = Instance.new("Frame")
        frame.Name = "MainFrame"
        frame.Size = UDim2.new(0, 200, 0, 28)
        frame.Position = UDim2.new(0.02, 0, 0.42, 0)
        frame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
        frame.BackgroundTransparency = 0.1
        frame.BorderSizePixel = 0
        frame.Active = true
        frame.Parent = gui
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

        local stroke = Instance.new("UIStroke", frame)
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.Thickness = 1.2
        stroke.Transparency = 0.2

        local topBar = Instance.new("Frame", frame)
        topBar.Size = UDim2.new(1, 0, 0, 3)
        topBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        topBar.BorderSizePixel = 0
        Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 8)

        local header = Instance.new("Frame", frame)
        header.Name = "Header"
        header.Size = UDim2.new(1, 0, 0, 22)
        header.Position = UDim2.new(0, 0, 0, 3)
        header.BackgroundTransparency = 1
        header.Active = true

        local title = Instance.new("TextLabel", header)
        title.Size = UDim2.new(1, -26, 1, 0)
        title.Position = UDim2.new(0, 10, 0, 0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.Text = "KILLER PERKS"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 11
        title.TextXAlignment = Enum.TextXAlignment.Left

        local killerName = Instance.new("TextLabel", header)
        killerName.Name = "KillerName"
        killerName.AnchorPoint = Vector2.new(1, 0.5)
        killerName.Size = UDim2.new(0, 80, 1, 0)
        killerName.Position = UDim2.new(1, -26, 0.5, 0)
        killerName.BackgroundTransparency = 1
        killerName.Font = Enum.Font.GothamBold
        killerName.Text = "???"
        killerName.TextColor3 = Color3.fromRGB(220, 220, 220)
        killerName.TextSize = 9
        killerName.TextXAlignment = Enum.TextXAlignment.Right
        killerName.TextTruncate = Enum.TextTruncate.AtEnd

        local minBtn = Instance.new("TextButton", header)
        minBtn.Name = "MinBtn"
        minBtn.AnchorPoint = Vector2.new(1, 0.5)
        minBtn.Size = UDim2.new(0, 20, 0, 20)
        minBtn.Position = UDim2.new(1, -3, 0.5, 0)
        minBtn.BackgroundTransparency = 1
        minBtn.Text = "−"
        minBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        minBtn.Font = Enum.Font.GothamBold
        minBtn.TextSize = 13
        minBtn.AutoButtonColor = false

        local divider = Instance.new("Frame", frame)
        divider.Name = "Divider"
        divider.Size = UDim2.new(1, -12, 0, 1)
        divider.Position = UDim2.new(0, 6, 0, 25)
        divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        divider.BackgroundTransparency = 0.7
        divider.BorderSizePixel = 0

        local body = Instance.new("Frame", frame)
        body.Name = "Body"
        body.Size = UDim2.new(1, -12, 0, 0)
        body.Position = UDim2.new(0, 6, 0, 28)
        body.AutomaticSize = Enum.AutomaticSize.Y
        body.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout", body)
        layout.FillDirection = Enum.FillDirection.Vertical
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 3)

        local function setMinimized(state)
            PerkDisplayState.Minimized = state
            if state then
                frame.Size = UDim2.new(0, 200, 0, 28)
                divider.Visible = false
                body.Visible = false
                minBtn.Text = "+"
            else
                frame.Size = UDim2.new(0, 200, 0, 28)
                divider.Visible = true
                body.Visible = true
                minBtn.Text = "−"
            end
        end
        minBtn.MouseButton1Click:Connect(function() setMinimized(not PerkDisplayState.Minimized) end)
        setMinimized(false)

        local dragging, dragStart, startPos = false, nil, nil
        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true; dragStart = input.Position; startPos = frame.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if not dragging then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local d = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        PerkDisplayState.Gui = gui
    end

    local function UpdateDisplay()
        local gui = PerkDisplayState.Gui
        if not gui then return end
        local frame = gui:FindFirstChild("MainFrame")
        if not frame then return end
        local header = frame:FindFirstChild("Header")
        local body = frame:FindFirstChild("Body")
        local divider = frame:FindFirstChild("Divider")
        if not header or not body then return end

        local killer = GetKillerPlayer()
        local killerName = killer and (killer.DisplayName or killer.Name) or "???"
        local hName = header:FindFirstChild("KillerName")
        if hName then hName.Text = killerName end

        for _, child in ipairs(body:GetChildren()) do
            if child:IsA("TextLabel") then child:Destroy() end
        end

        local perks = {}
        if killer and killer.Character then perks = ReadPerksFromChar(killer.Character) end

        local count = math.min(#perks, 6)
        if count == 0 then
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 0, 14)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamMedium
            lbl.Text = "Waiting for perk data..."
            lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
            lbl.TextSize = 9
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = body
        else
            for i = 1, count do
                local p = perks[i]
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, 0, 0, 14)
                lbl.BackgroundTransparency = 1
                lbl.Font = Enum.Font.GothamMedium
                local lvlText = p.Level and (" (Lv " .. tostring(p.Level) .. ")") or ""
                lbl.Text = "• " .. p.Name .. lvlText
                lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                lbl.TextSize = 10
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Parent = body
            end
        end

        if PerkDisplayState.Minimized then
            if divider then divider.Visible = false end
            body.Visible = false
            frame.Size = UDim2.new(0, 200, 0, 28)
        else
            if divider then divider.Visible = true end
            body.Visible = true
            local bodyH = body.AbsoluteSize.Y
            frame.Size = UDim2.new(0, 200, 0, 28 + bodyH + 6)
        end
    end

    local function Stop()
        PerkDisplayState.Enabled = false
        if PerkDisplayState.Thread then
            pcall(function() task.cancel(PerkDisplayState.Thread) end)
            PerkDisplayState.Thread = nil
        end
        if PerkDisplayState.Gui then
            pcall(function() PerkDisplayState.Gui:Destroy() end)
            PerkDisplayState.Gui = nil
        end
    end

    local function Start()
        if PerkDisplayState.Enabled then return end
        PerkDisplayState.Enabled = true
        BuildGui()
        task.spawn(function()
            task.wait(0.05)
            UpdateDisplay()
        end)
        PerkDisplayState.Thread = task.spawn(function()
            while PerkDisplayState.Enabled do
                pcall(UpdateDisplay)
                task.wait(1)
            end
        end)
    end

    W.KillerPerksDisplay_SetEnabled = function(v)
        VD.KillerPerksDisplay = v and true or false
        if VD.KillerPerksDisplay then Start() else Stop() end
    end
end

-- ═══════════════ KILLER UI BINDING (Abilities) ═══════════════
KilAbil:AddToggle("AutoStalk", {
    Text = "Auto Stalk (Myers)",
    Default = false,
    Callback = function(v) W.KA_SetAutoStalk(v) end,
})
KilAbil:AddSlider("AutoStalkRange", {
    Text = "Auto Stalk Range", Default = 150, Min = 20, Max = 500, Rounding = 10,
    Suffix = " studs",
    Callback = function(v)
        if W.KA_Table then W.KA_Table.AutoStalkRange = v end
        VD.KA_AutoStalkRange = v
    end,
})
KilAbil:AddToggle("AutoKillAll", {
    Text = "Auto Kill All",
    Default = false,
    Callback = function(v) W.KA_SetAutoKillAll(v) end,
})
KilAbil:AddToggle("DropAllPallet", {
    Text = "Drop All Pallet",
    Default = false,
    Callback = function(v) W.KA_SetDropAllPallet(v) end,
})
KilAbil:AddToggle("BlockAllVault", {
    Text = "Block All Vault",
    Default = false,
    Callback = function(v) W.KA_SetBlockAllVault(v) end,
})
KilAbil:AddToggle("AutoHook", {
    Text = "Auto Hook",
    Default = false,
    Callback = function(v) W.KA_SetAutoHook(v) end,
})
KilAbil:AddDivider()
KilAbil:AddDropdown("MaskedPower", {
    Values = { "Cobra", "Richter", "Brandon", "Rabbit", "Alex", "Tony" },
    Default = "Cobra",
    Text = "Masked Power",
    Callback = function(v) if W.Masked then W.Masked.CurrentPower = v end end,
})
KilAbil:AddButton({
    Text = "Activate Masked Power",
    Func = function() if W.Masked_Activate then W.Masked_Activate() end end,
})
KilAbil:AddButton({
    Text = "Deactivate Masked Power",
    Func = function() if W.Masked_Deactivate then W.Masked_Deactivate() end end,
})
KilAbil:AddDivider()
KilAbil:AddToggle("KillerPerks", {
    Text = "Killer Perks Display",
    Default = false,
    Callback = function(v) W.KillerPerksDisplay_SetEnabled(v) end,
})-- [[PART 15/20]]

-- ═══════════════ SILENT VEIL V1 ═══════════════
do
    local VeilState = { target = nil, lookVector = nil, velHistory = {} }

    local function Veil_IsSurvivorVeil(p)
        if not p or not p.Team or not p.Team.Name then return false end
        return string.find(string.lower(p.Team.Name), "survivor", 1, true) ~= nil
    end

    local function Veil_solvePitch(p, d, dy)
        d = math.max(d, 0.1)
        local s2 = p.v0 * p.v0
        local root = s2 * s2 - p.g * (p.g * d * d + 2 * dy * s2)
        if root < 0 then root = 0 end
        local tanTheta = (s2 - math.sqrt(root)) / (p.g * d)
        local theta = math.atan(tanTheta)
        local t = d / (p.v0 * math.cos(theta))
        return theta, t
    end

    local function Veil_getCharacterVelocity(char)
        local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
        if not root or not root:IsA("BasePart") then return Vector3.zero end
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

    Players.PlayerRemoving:Connect(function(p)
        if p.Character then VeilState.velHistory[p.Character] = nil end
    end)

    local function Veil_UpdateAimbot()
        if GetRole() ~= "Killer" then
            VeilState.target = nil
            VeilState.lookVector = nil
            return
        end
        if not VD.VeilEnabled then
            VeilState.target = nil
            VeilState.lookVector = nil
            return
        end
        local cam = Workspace.CurrentCamera
        if not cam then return end
        local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local nearest, nearestPart = nil, nil
        local bestDist = VD.VeilFOV or 150
        local bestStudDist = VD.VeilMaxDist or 500
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and Veil_IsSurvivorVeil(p) and p.Character then
                local pc = p.Character
                local isDown = pc:GetAttribute("Knocked") == true or pc:GetAttribute("HookProgressDepleting") == true
                if not isDown then
                    local hum = pc:FindFirstChildOfClass("Humanoid")
                    local targetPart = pc:FindFirstChild("UpperTorso") or pc:FindFirstChild("Torso") or pc:FindFirstChild("HumanoidRootPart")
                    if hum and hum.Health > 0 and targetPart then
                        local sp, on = cam:WorldToViewportPoint(targetPart.Position)
                        if on and sp.Z > 0 then
                            local sd = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                            if sd < bestDist then
                                local studDist = (targetPart.Position - hrp.Position).Magnitude
                                if studDist <= bestStudDist then
                                    bestDist = sd
                                    nearest = p
                                    nearestPart = targetPart
                                end
                            end
                        end
                    end
                end
            end
        end
        if nearest and nearest.Character and nearestPart then
            local tp = nearestPart.Position
            local hand = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
            local origin = (hand and hand:IsA("BasePart")) and hand.Position or hrp.Position
            local dir = tp - origin
            local dist = dir.Magnitude
            if dist > 0.1 and dist <= (VD.VeilMaxDist or 500) then
                local isAuraActive = char:GetAttribute("special") == true
                local prof
                if isAuraActive then
                    prof = {
                        v0 = VD.VeilAuraSpearSpeed or 165,
                        g = VD.VeilAuraSpearGravity or 96.5,
                        windup = 0.10, latency = 0.04, maxlead = 25,
                        scale = VD.VeilLeadMultiplier or 1.4
                    }
                else
                    prof = {
                        v0 = VD.VeilSpearSpeed or 165,
                        g = VD.VeilGravity or 103,
                        windup = 0.10, latency = 0.04, maxlead = 45,
                        scale = VD.VeilLeadMultiplier or 1.4
                    }
                end
                local aimPoint = tp
                if VD.VeilAutoPredict then
                    local vel = Veil_getCharacterVelocity(nearest.Character)
                    if vel.Magnitude > 0.5 then
                        local h0 = Vector3.new(dir.X, 0, dir.Z)
                        local _, tFlight = Veil_solvePitch(prof, h0.Magnitude, dir.Y)
                        local ping = 0.08
                        pcall(function() ping = math.clamp(LocalPlayer:GetNetworkPing(), 0, 0.35) end)
                        local delay = tFlight + prof.windup + ping + prof.latency
                        for _ = 1, 2 do
                            local lead = vel * delay * prof.scale
                            local maxLead = math.clamp(dist * 0.6, 3, prof.maxlead)
                            if lead.Magnitude > maxLead then lead = lead.Unit * maxLead end
                            aimPoint = tp + lead
                            local ad = aimPoint - origin
                            local ah = Vector3.new(ad.X, 0, ad.Z)
                            local _, t2 = Veil_solvePitch(prof, math.max(ah.Magnitude, 0.1), ad.Y)
                            delay = t2 + prof.windup + ping + prof.latency
                        end
                    end
                end
                local adir = aimPoint - origin
                local ah = Vector3.new(adir.X, 0, adir.Z)
                local ahDist = ah.Magnitude
                local pitch = Veil_solvePitch(prof, ahDist, adir.Y)
                if ahDist > 0.001 then
                    VeilState.lookVector = ah.Unit * math.cos(pitch) + Vector3.new(0, math.sin(pitch), 0)
                else
                    VeilState.lookVector = adir.Unit
                end
                VeilState.target = nearest
            end
        else
            VeilState.target = nil
            VeilState.lookVector = nil
        end
    end

    task.spawn(function()
        pcall(function()
            if typeof(hookmetamethod) ~= "function" then return end
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if not checkcaller() and method == "FireServer" then
                    if self.Name == "Spearthrow" and VD.VeilEnabled
                        and typeof(VeilState.lookVector) == "Vector3"
                        and GetRole() == "Killer" then
                        local args = {...}
                        if typeof(args[1]) == "Vector3" then
                            args[1] = VeilState.lookVector
                        end
                        return oldNamecall(self, unpack(args))
                    end
                end
                return oldNamecall(self, ...)
            end)
        end)
    end)

    RunService.RenderStepped:Connect(function() pcall(Veil_UpdateAimbot) end)
end

-- ═══════════════ SILENT VEIL V2 (W424 Style) ═══════════════
do
    local Config = {}
    local Camera = Workspace.CurrentCamera
    local AimConfig = AimConfig or {}
    AimConfig.Aim_SilentVeil = false
    AimConfig.Aim_SilentVeilV2 = false
    AimConfig.SpearSmart_enable = false
    AimConfig.Veil_FOV = 150
    AimConfig.SPEAR_Speed = 165
    AimConfig.SPEAR_Gravity = workspace.Gravity * 0.5
    AimConfig.SPEAR_MaxDist = 200
    AimConfig.Veil_LeadMultiplier = 1.4
    AimConfig.AIM_Auto = false
    AimConfig.AIM_TargetPart = "Torso"

    local isFiringSpear = false

    local function IsVeilSilentOn()
        return AimConfig.Aim_SilentVeil or AimConfig.Aim_SilentVeilV2
    end

    function W.GetTargetPartObject(char)
        if AimConfig.AIM_TargetPart == "Head" then
            return char:FindFirstChild("Head")
        elseif AimConfig.AIM_TargetPart == "Root" or AimConfig.AIM_TargetPart == "HumanoidRootPart" then
            return char:FindFirstChild("HumanoidRootPart")
        else
            return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart")
        end
    end

    function W.GetClosestSurvivorVeil()
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
                local targetPart = W.GetTargetPartObject(char)
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

    local SpearInterceptorHooked = false
    function W.SetupSpearInterceptorV2()
        if SpearInterceptorHooked then return end
        if not getrawmetatable or not setreadonly then return end

        local Spearthrow = nil
        pcall(function()
            Spearthrow = ReplicatedStorage.Remotes.Killers.Veil.Spearthrow
        end)

        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldNamecall = mt.__namecall

        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" and not checkcaller() and typeof(self) == "Instance"
                and self.ClassName == "RemoteEvent" and self.Name == "Spearthrow" then
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
                    speed = isSpecial and 165 or 142.5
                    originPos = originPos or (myHRP and myHRP.Position) or (startPart and startPart.Position)

                    local bestDir = lookVec
                    local targetPart = W.GetClosestSurvivorVeil()
                    if targetPart and originPos then
                        local targetHRP = targetPart:IsA("Model") and targetPart:FindFirstChild("HumanoidRootPart") or targetPart
                        local targetPos = targetHRP.Position
                        local targetVel = Vector3.new(0, 0, 0)
                        local targetHum = targetPart.Parent and targetPart.Parent:FindFirstChildOfClass("Humanoid")
                        if targetHum and targetHum.MoveDirection.Magnitude > 0 then
                            targetVel = targetHum.MoveDirection * targetHum.WalkSpeed
                        elseif targetHRP:IsA("BasePart") then
                            targetVel = targetHRP.AssemblyLinearVelocity
                        end
                        targetVel = Vector3.new(targetVel.X, 0, targetVel.Z)
                        local distance = (targetPos - originPos).Magnitude
                        local timeToHit = distance / math.max(speed, 1)
                        local leadMultiplier = AimConfig.Veil_LeadMultiplier or 1.4
                        local predictedPos = targetPos + (targetVel * (timeToHit * leadMultiplier))
                        local spearGravity = workspace.Gravity * 0.5
                        local drop = 0.5 * spearGravity * (timeToHit * timeToHit)
                        local finalAimPos = predictedPos + Vector3.new(0, drop - 1.5, 0)
                        bestDir = (finalAimPos - originPos).Unit
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
    W.SetupSpearInterceptorV2()
    W.AimConfig_V2 = AimConfig
end

-- ═══════════════ SILENT FLASK ═══════════════
do
    local FlaskState = { Target = nil, PredictedPos = nil, BeamPart = nil, AccentPart = nil, LandingRing = nil }

    local function Flask_GetTarget()
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local maxR = tonumber(VD.FLASK_Range) or 200
        local best, bd = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TeamIs(p, "Survivor") and p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and root then
                    local d = (root.Position - myRoot.Position).Magnitude
                    if d <= maxR and d < bd then
                        bd = d
                        best = { Player = p, Root = root, Char = p.Character }
                    end
                end
            end
        end
        return best
    end

    local function Flask_GetHandOrigin()
        local c = LocalPlayer.Character
        if not c then return nil end
        return c:FindFirstChild("LeftHand") or c:FindFirstChild("Left Arm")
            or c:FindFirstChild("RightHand") or c:FindFirstChild("Right Arm")
            or c:FindFirstChild("HumanoidRootPart")
    end

    local function Flask_PredictLanding(origin, targetRoot)
        local targetPos = targetRoot.Position
        local speed   = tonumber(VD.FLASK_Speed)   or 90
        local gravity = tonumber(VD.FLASK_Gravity) or 196
        local lead    = tonumber(VD.FLASK_LeadMult) or 1.0
        if not VD.FLASK_Predict then return targetPos end
        local tv = targetRoot.AssemblyLinearVelocity or Vector3.zero
        local horizVel = Vector3.new(tv.X, 0, tv.Z)
        local dist = (targetPos - origin).Magnitude
        local time = dist / speed
        local predicted = targetPos
        for _ = 1, 3 do
            predicted = targetPos + horizVel * time * lead
            local nd = (predicted - origin).Magnitude
            time = nd / speed
        end
        local drop = 0.5 * gravity * (time * time)
        return predicted + Vector3.new(0, drop, 0)
    end

    local function Flask_HideVisuals()
        if FlaskState.BeamPart then FlaskState.BeamPart.Transparency = 1 end
        if FlaskState.AccentPart then FlaskState.AccentPart.Transparency = 1 end
        if FlaskState.LandingRing then FlaskState.LandingRing.Transparency = 1 end
    end

    local function Flask_EnsureBeamParts()
        if not FlaskState.BeamPart or not FlaskState.BeamPart.Parent then
            local beam = Instance.new("Part")
            beam.Name = "PazzFlaskBeam"
            beam.Anchored = true
            beam.CanCollide = false
            beam.CanTouch = false
            beam.CanQuery = false
            beam.CastShadow = false
            beam.Material = Enum.Material.Neon
            beam.Color = VD.FLASK_BeamColor or ACCENT
            beam.Transparency = 0.2
            beam.Parent = Workspace
            FlaskState.BeamPart = beam
        end
        if not FlaskState.AccentPart or not FlaskState.AccentPart.Parent then
            local accent = Instance.new("Part")
            accent.Name = "PazzFlaskAccent"
            accent.Anchored = true
            accent.CanCollide = false
            accent.CanTouch = false
            accent.CanQuery = false
            accent.CastShadow = false
            accent.Material = Enum.Material.SmoothPlastic
            accent.Color = VD.FLASK_AccentColor or Color3.fromRGB(25, 25, 25)
            accent.Transparency = 0.35
            accent.Parent = Workspace
            FlaskState.AccentPart = accent
        end
        if FlaskState.BeamPart then FlaskState.BeamPart.Color = VD.FLASK_BeamColor or ACCENT end
        if FlaskState.AccentPart then FlaskState.AccentPart.Color = VD.FLASK_AccentColor or Color3.fromRGB(25, 25, 25) end
    end

    local function Flask_UpdateBeam(origin, landing)
        Flask_EnsureBeamParts()
        local dir = landing - origin
        local dist = dir.Magnitude
        if dist < 0.1 then return end
        local mid = (origin + landing) / 2
        local cf = CFrame.lookAt(mid, landing)
        FlaskState.BeamPart.Size = Vector3.new(0.12, 0.12, dist)
        FlaskState.BeamPart.CFrame = cf
        FlaskState.BeamPart.Transparency = 0.2
        FlaskState.AccentPart.Size = Vector3.new(0.22, 0.22, dist)
        FlaskState.AccentPart.CFrame = cf
        FlaskState.AccentPart.Transparency = 0.35
    end

    local function Flask_UpdateLanding(pos)
        if not VD.FLASK_ShowLanding then
            if FlaskState.LandingRing then FlaskState.LandingRing.Transparency = 1 end
            return
        end
        if not FlaskState.LandingRing or not FlaskState.LandingRing.Parent then
            local ring = Instance.new("Part")
            ring.Name = "PazzFlaskLanding"
            ring.Shape = Enum.PartType.Cylinder
            ring.Anchored = true
            ring.CanCollide = false
            ring.CanTouch = false
            ring.CanQuery = false
            ring.CastShadow = false
            ring.Material = Enum.Material.Neon
            ring.Color = VD.FLASK_BeamColor or ACCENT
            ring.Size = Vector3.new(0.2, 5, 5)
            ring.Parent = Workspace
            FlaskState.LandingRing = ring
        end
        FlaskState.LandingRing.Color = VD.FLASK_BeamColor or ACCENT
        FlaskState.LandingRing.CFrame = CFrame.new(pos) * CFrame.Angles(0, 0, math.rad(90))
        FlaskState.LandingRing.Transparency = 0.35
    end

    RunService.RenderStepped:Connect(function()
        if not VD.FLASK_SilentAim then
            Flask_HideVisuals()
            FlaskState.Target = nil
            FlaskState.PredictedPos = nil
            return
        end
        if GetRole() ~= "Killer" then Flask_HideVisuals(); return end
        local target = Flask_GetTarget()
        if not target or not target.Root then
            Flask_HideVisuals()
            FlaskState.Target = nil
            FlaskState.PredictedPos = nil
            return
        end
        local hand = Flask_GetHandOrigin()
        if not hand then return end
        local landing = Flask_PredictLanding(hand.Position, target.Root)
        FlaskState.Target = target
        FlaskState.PredictedPos = landing
        if VD.FLASK_ShowBeam then pcall(Flask_UpdateBeam, hand.Position, landing)
        else
            if FlaskState.BeamPart then FlaskState.BeamPart.Transparency = 1 end
            if FlaskState.AccentPart then FlaskState.AccentPart.Transparency = 1 end
        end
        pcall(Flask_UpdateLanding, landing)
    end)

    task.spawn(function()
        pcall(function()
            local oldNC
            oldNC = hookmetamethod(game, "__namecall", function(self, ...)
                if getnamecallmethod() == "FireServer"
                    and self.Name == "ThrowFlask"
                    and VD.FLASK_SilentAim
                    and GetRole() == "Killer"
                    and FlaskState.PredictedPos then
                    local args = {...}
                    if typeof(args[2]) == "Vector3" then
                        local origin = args[2]
                        local aimDir = (FlaskState.PredictedPos - origin)
                        if aimDir.Magnitude > 0.1 then
                            args[1] = aimDir.Unit
                            return oldNC(self, unpack(args))
                        end
                    elseif typeof(args[1]) == "Vector3" then
                        local hand = Flask_GetHandOrigin()
                        if hand then
                            local aimDir = (FlaskState.PredictedPos - hand.Position)
                            if aimDir.Magnitude > 0.1 then
                                args[1] = aimDir.Unit
                                return oldNC(self, unpack(args))
                            end
                        end
                    end
                end
                return oldNC(self, ...)
            end)
        end)
    end)
end

-- ═══════════════ SPEAR AIMBOT ═══════════════
do
    local function SpearAimbotCalc(targetPos)
        if not VD.SPEAR_Aimbot or GetRole() ~= "Killer" then return nil end
        local char = LocalPlayer.Character
        if not char then return nil end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local startPos = root.Position + Vector3.new(0, 2, 0)
        local distance = (targetPos - startPos).Magnitude
        local gravity  = VD.SPEAR_Gravity or 50
        local speed    = VD.SPEAR_Speed or 100
        local time     = distance / speed
        local drop     = 0.5 * gravity * time * time
        return targetPos + Vector3.new(0, drop, 0)
    end

    local function Spear_UpdateAim()
        if not VD.SPEAR_Aimbot then return end
        if GetRole() ~= "Killer" then return end
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local closest, closestDist = nil, math.huge
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and TeamIs(player, "Survivor") and player.Character then
                local tr = player.Character:FindFirstChild("HumanoidRootPart")
                local th = player.Character:FindFirstChildOfClass("Humanoid")
                if tr and th and th.MaxHealth > 0 and (th.Health / th.MaxHealth) > 0.25 then
                    local dist = (tr.Position - root.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = player
                    end
                end
            end
        end
        if closest and closest.Character then
            local tr = closest.Character:FindFirstChild("HumanoidRootPart")
            if tr then
                local aimPos = SpearAimbotCalc(tr.Position)
                if aimPos then
                    local cam = Workspace.CurrentCamera
                    if cam then cam.CFrame = CFrame.new(cam.CFrame.Position, aimPos) end
                end
            end
        end
    end

    RunService.RenderStepped:Connect(function() pcall(Spear_UpdateAim) end)
end

-- ═══════════════ UI BINDING (Killer Silent Aimbot) ═══════════════
KilAimbot:AddToggle("VeilV1", {
    Text = "Silent Veil V1",
    Default = false,
    Callback = function(v) VD.VeilEnabled = v end,
})
KilAimbot:AddToggle("VeilV2", {
    Text = "Silent Veil V2",
    Default = false,
    Callback = function(v)
        if W.AimConfig_V2 then W.AimConfig_V2.Aim_SilentVeilV2 = v end
    end,
})
KilAimbot:AddToggle("VeilFOV", {
    Text = "Veil Show FOV",
    Default = true,
    Callback = function(v) VD.VeilShowFOV = v end,
})
KilAimbot:AddSlider("VeilFOVR", {
    Text = "Veil FOV Radius", Default = 150, Min = 50, Max = 500, Rounding = 10,
    Callback = function(v)
        VD.VeilFOV = v
        if W.AimConfig_V2 then W.AimConfig_V2.Veil_FOV = v end
    end,
})
KilAimbot:AddToggle("VeilPredict", {
    Text = "Veil Auto Predict",
    Default = true,
    Callback = function(v) VD.VeilAutoPredict = v end,
})
KilAimbot:AddSlider("VeilLead", {
    Text = "Veil Lead Multiplier", Default = 1.4, Min = 0.5, Max = 5, Rounding = 0.1,
    Callback = function(v)
        VD.VeilLeadMultiplier = v
        if W.AimConfig_V2 then W.AimConfig_V2.Veil_LeadMultiplier = v end
    end,
})

KilAimbot:AddDivider()
KilAimbot:AddToggle("SpearAim", {
    Text = "Spear Aimbot",
    Default = false,
    Callback = function(v) VD.SPEAR_Aimbot = v end,
})
KilAimbot:AddSlider("SpearSpeed", {
    Text = "Spear Speed", Default = 165, Min = 50, Max = 300, Rounding = 5,
    Callback = function(v)
        VD.VeilSpearSpeed = v
        VD.SPEAR_Speed = v
        if W.AimConfig_V2 then W.AimConfig_V2.SPEAR_Speed = v end
    end,
})

KilAimbot:AddDivider()
KilAimbot:AddToggle("FlaskSilent", {
    Text = "Silent Flask",
    Default = false,
    Callback = function(v) VD.FLASK_SilentAim = v end,
})
KilAimbot:AddSlider("FlaskSpeed", {
    Text = "Flask Speed", Default = 90, Min = 30, Max = 200, Rounding = 5,
    Callback = function(v) VD.FLASK_Speed = v end,
})
KilAimbot:AddSlider("FlaskGravity", {
    Text = "Flask Gravity", Default = 196, Min = 50, Max = 400, Rounding = 5,
    Callback = function(v) VD.FLASK_Gravity = v end,
})
KilAimbot:AddToggle("FlaskShowBeam", {
    Text = "Flask Show Beam",
    Default = true,
    Callback = function(v) VD.FLASK_ShowBeam = v end,
})-- [[PART 16/20]]

-- ═══════════════ SPEED BOOST ═══════════════
do
    local SpeedBoostConnection = nil

    local function ShouldDisableSpeedBoost()
        local char = LocalPlayer.Character
        if not char then return true end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            local animator = hum:FindFirstChildOfClass("Animator")
            if animator then
                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                    local anim = track.Animation
                    if anim and anim.AnimationId then
                        if anim.AnimationId == "rbxassetid://127096285501517" then return true end
                        if anim.AnimationId == "rbxassetid://112166042383605" then return true end
                        if anim.AnimationId == "http://www.roblox.com/asset/?id=126965695851149" then return true end
                        if anim.AnimationId == "http://www.roblox.com/asset/?id=135084204086504" then return true end
                        if anim.AnimationId == "rbxassetid://123047897844134" then return true end
                        local id = anim.AnimationId:match("%d+")
                        if id and W.KillerAttackAnims and W.KillerAttackAnims["rbxassetid://" .. id] then
                            return true
                        end
                    end
                end
            end
            if hum.Health <= 0 or hum.Health < 2
                or char:GetAttribute("Downed") == true
                or char:GetAttribute("IsDown") == true
                or char:GetAttribute("Knocked") == true then
                return true
            end
        end
        return false
    end

    W.SpeedBoost_SetEnabled = function(v)
        VD.SpeedBoostEnabled = v and true or false
        if SpeedBoostConnection then SpeedBoostConnection:Disconnect(); SpeedBoostConnection = nil end
        if not VD.SpeedBoostEnabled then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then pcall(function() hum.WalkSpeed = 16 end) end
            return
        end
        SpeedBoostConnection = RunService.Heartbeat:Connect(function()
            if not VD.SpeedBoostEnabled then return end
            if ShouldDisableSpeedBoost() then return end
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= VD.SpeedBoostValue then
                pcall(function() hum.WalkSpeed = VD.SpeedBoostValue end)
            end
        end)
    end

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.8)
        if VD.SpeedBoostEnabled then W.SpeedBoost_SetEnabled(true) end
    end)
end

-- ═══════════════ CURSOR FEATURE ═══════════════
do
    local CursorThread = nil
    local savedOriginal = { MouseIconEnabled = nil, MouseBehavior = nil, AutoRotate = nil }

    W.Cursor_SetEnabled = function(v)
        VD.CursorEnabled = v and true or false
        if v then
            savedOriginal.MouseIconEnabled = UserInputService.MouseIconEnabled
            savedOriginal.MouseBehavior = UserInputService.MouseBehavior
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            savedOriginal.AutoRotate = hum and hum.AutoRotate or true

            pcall(function()
                UserInputService.MouseIconEnabled = true
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            end)
            if hum then pcall(function() hum.AutoRotate = false end) end

            if CursorThread then pcall(function() task.cancel(CursorThread) end) end
            CursorThread = task.spawn(function()
                while VD.CursorEnabled do
                    pcall(function()
                        UserInputService.MouseIconEnabled = true
                        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                    end)
                    local c = LocalPlayer.Character
                    local h = c and c:FindFirstChildOfClass("Humanoid")
                    if h and h.AutoRotate then h.AutoRotate = false end
                    task.wait(0.1)
                end
            end)
        else
            VD.CursorEnabled = false
            if CursorThread then
                pcall(function() task.cancel(CursorThread) end)
                CursorThread = nil
            end
            pcall(function()
                UserInputService.MouseIconEnabled = savedOriginal.MouseIconEnabled or false
                UserInputService.MouseBehavior = savedOriginal.MouseBehavior or Enum.MouseBehavior.LockCenter
            end)
            local c = LocalPlayer.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if h then pcall(function() h.AutoRotate = savedOriginal.AutoRotate or true end) end
        end
    end

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
            W.Cursor_SetEnabled(not VD.CursorEnabled)
        end
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if VD.CursorEnabled then W.Cursor_SetEnabled(true) end
    end)
end

-- ═══════════════ MISC UI BINDING ═══════════════
MiscUtil:AddToggle("SpeedBoost", {
    Text = "Speed Boost",
    Default = false,
    Callback = function(v) W.SpeedBoost_SetEnabled(v) end,
})
MiscUtil:AddSlider("SpeedBoostVal", {
    Text = "Speed Value",
    Default = 30, Min = 16, Max = 100, Rounding = 1,
    Callback = function(v) VD.SpeedBoostValue = v end,
})
MiscUtil:AddDivider()
MiscUtil:AddToggle("CursorUnlock", {
    Text = "Cursor Unlock",
    Default = false,
    Callback = function(v) W.Cursor_SetEnabled(v) end,
})
MiscUtil:AddParagraph({
    Title = "Cursor Hotkey",
    Content = "Alt kiri / Alt kanan untuk toggle cursor"
})
MiscUtil:AddDivider()
MiscUtil:AddToggle("InvisibleToggle", {
    Text = "Invisible (MengHub)",
    Default = false,
    Callback = function(v) W.Invisible_SetState(v, false) end,
})
MiscUtil:AddKeybind("InvisHotkey", {
    Text = "Invisible Hotkey",
    Default = Enum.KeyCode.G,
    Callback = function(kc)
        if kc then VD.Invis_Hotkey = kc.Name end
    end,
})
MiscUtil:AddDivider()
MiscUtil:AddToggle("MoonwalkToggle", {
    Text = "Moonwalk",
    Default = false,
    Callback = function(v) if W.setMoonwalk then W.setMoonwalk(v) end end,
})
MiscUtil:AddParagraph({
    Title = "Moonwalk Hotkey",
    Content = "F8 untuk toggle Moonwalk"
})
MiscUtil:AddDivider()
MiscUtil:AddToggle("SelfHealToggle", {
    Text = "Instant Self Heal",
    Default = false,
    Callback = function(v) W.setInstantHealSelf(v) end,
})
MiscUtil:AddToggle("AutoHealAllToggle", {
    Text = "Auto Heal All",
    Default = false,
    Callback = function(v) W.setAutoHealAll(v) end,
})
MiscUtil:AddDivider()
MiscUtil:AddToggle("SelfUnhookToggle", {
    Text = "Self Unhook (Bypass)",
    Default = false,
    Callback = function(v) W.SU_SetEnabled(v) end,
})
MiscUtil:AddSlider("SelfUnhookDur", {
    Text = "Follow Duration", Default = 30, Min = 5, Max = 120, Rounding = 5,
    Suffix = "s",
    Callback = function(v) W.SelfUnhook.FollowDuration = v end,
})
MiscUtil:AddSlider("SelfUnhookDist", {
    Text = "Follow Distance", Default = 20, Min = 5, Max = 60, Rounding = 1,
    Suffix = " studs",
    Callback = function(v) W.SelfUnhook.FollowDistance = v end,
})
MiscUtil:AddDivider()
MiscUtil:AddToggle("EscapeToggle", {
    Text = "Instant Escape",
    Default = false,
    Callback = function(v)
        W.Escape.Enabled = v
        if v and W.Escape_Teleport then W.Escape_Teleport() end
    end,
})
MiscUtil:AddButton({
    Text = "Teleport Now (Escape)",
    Func = function() if W.Escape_Teleport then W.Escape_Teleport() end end,
})
MiscUtil:AddDivider()
MiscUtil:AddToggle("TrollTPToggle", {
    Text = "Troll Teleport",
    Default = false,
    Callback = function(v) W.TrollTeleport_SetEnabled(v) end,
})

-- ═══════════════ FLOATING BUTTONS PANEL (Misc kanan) ═══════════════
MiscFloats:AddParagraph({
    Title = "Floating Button Panel",
    Content = "Toggle semua tombol floating di sini"
})
MiscFloats:AddDivider()
MiscFloats:AddToggle("ShowSelfHealBtnM", {
    Text = "Show Self Heal Button",
    Default = false,
    Callback = function(v) if W.Gluto_SHB_SetEnabled then W.Gluto_SHB_SetEnabled(v) end end,
})
MiscFloats:AddToggle("ShowSelfUnhookBtnM", {
    Text = "Show Self Unhook Button",
    Default = false,
    Callback = function(v) if W.Gluto_SUB_SetEnabled then W.Gluto_SUB_SetEnabled(v) end end,
})
MiscFloats:AddToggle("ShowTrollTPBtnM", {
    Text = "Show Troll TP Button",
    Default = false,
    Callback = function(v) if W.Gluto_TTB_SetEnabled then W.Gluto_TTB_SetEnabled(v) end end,
})
MiscFloats:AddToggle("ShowEscapeBtnM", {
    Text = "Show Escape Button",
    Default = false,
    Callback = function(v) if W.Gluto_Escape_SetEnabled then W.Gluto_Escape_SetEnabled(v) end end,
})
MiscFloats:AddToggle("ShowParryBtnM", {
    Text = "Show Parry Button",
    Default = false,
    Callback = function(v) if W.Gluto_ParryBtn_SetEnabled then W.Gluto_ParryBtn_SetEnabled(v) end end,
})
MiscFloats:AddToggle("ShowInvisBtnM", {
    Text = "Show Invisible Button",
    Default = false,
    Callback = function(v) if W.Gluto_InvisBtn_SetEnabled then W.Gluto_InvisBtn_SetEnabled(v) end end,
})
MiscFloats:AddToggle("ShowMyersBtnM", {
    Text = "Show Myers Grab Button",
    Default = false,
    Callback = function(v) if W.Gluto_MGrabBtn_SetEnabled then W.Gluto_MGrabBtn_SetEnabled(v) end end,
})
MiscFloats:AddToggle("ShowMoonwalkBtnM", {
    Text = "Show Moonwalk Button",
    Default = false,
    Callback = function(v) if W.Gluto_MoonwalkBtn_SetEnabled then W.Gluto_MoonwalkBtn_SetEnabled(v) end end,
})-- [[PART 17/20]]

-- ═══════════════ BOMBAX SONG LIST (32 LAGU) ═══════════════
W.BombaxSongs = {
    {id = "101985596918228", judul = "One"},
    {id = "78520199502339",  judul = "Two"},
    {id = "78253224480952",  judul = "Three"},
    {id = "136949217768985", judul = "Four"},
    {id = "92143860315842",  judul = "Five"},
    {id = "96568301359656",  judul = "Six"},
    {id = "96053601899287",  judul = "Seven"},
    {id = "116537762304510", judul = "Eight"},
    {id = "111775377151665", judul = "Nine"},
    {id = "131317416582166", judul = "Ten"},
    {id = "107569604895628", judul = "Eleven"},
    {id = "80210594606101",  judul = "Danza Kuduro"},
    {id = "135887188304832", judul = "Ada Yang Tumbang Jos Jis"},
    {id = "105372329671874", judul = "Million Stars Asoy"},
    {id = "79296696808534",  judul = "My Lope Lope (Speed Up)"},
    {id = "70578919220987",  judul = "My Lope Lope (Andri Poter)"},
    {id = "89338419772018",  judul = "Habibi Ishqi"},
    {id = "93652038633690",  judul = "Santai Dulu"},
    {id = "124582101215124", judul = "DJ Akimilaku Im Back"},
    {id = "121304834713825", judul = "Dangdut Week Sebelas"},
    {id = "102944382854479", judul = "Lagu Misterius"},
    {id = "126810420971446", judul = "Anak Kota"},
    {id = "94299109467073",  judul = "Cinderella Jedag Jedug"},
    {id = "83463789936127",  judul = "Lagu Jawa (Kowe Siji)"},
    {id = "771523191444498", judul = "Cintaku Ini Istimewa - AIS x Celawze"},
    {id = "86422417888834",  judul = "Kini Tinggal Kenangan - Celawze"},
    {id = "70868757792328",  judul = "Mashup Dora Dora (Funky RMX)"},
    {id = "128071048140468", judul = "Always Loving You - Natraa"},
    {id = "136239433509180", judul = "Mysterious Girl (Funky RMX)"},
    {id = "101280279977761", judul = "Kini Kita Pe Kisah - DJ Pelik Pungki"},
    {id = "117080961502380", judul = "DJ Music Dubstep x Bangun Tidur Selfie"},
    {id = "110337096446518", judul = "DJ Onia"},
}

-- ═══════════════ BOMBAX SOUND INSTANCE ═══════════════
W.Bombax_Sound = W.Bombax_Sound or nil

local function Bombax_EnsureSound()
    if not W.Bombax_Sound or not W.Bombax_Sound.Parent then
        local snd = Instance.new("Sound")
        snd.Name = "PazzBombax"
        snd.Volume = VD.BombaxVolume or 1
        snd.Looped = VD.BombaxLoop ~= false
        snd.Parent = SoundService
        W.Bombax_Sound = snd
    end
    return W.Bombax_Sound
end

function W.Bombax_Play(songId, judul)
    local snd = Bombax_EnsureSound()
    pcall(function()
        snd:Stop()
        snd.SoundId = "rbxassetid://" .. tostring(songId)
        snd.Volume = VD.BombaxVolume or 1
        snd.Looped = VD.BombaxLoop ~= false
        snd:Play()
    end)
    VD.BombaxCurrentSong = judul or "-"
    W.PazzNotify("Bombax", "Playing: " .. (judul or "-"), 2)
end

function W.Bombax_Stop()
    if W.Bombax_Sound then pcall(function() W.Bombax_Sound:Stop() end) end
    VD.BombaxCurrentSong = "-"
end

function W.Bombax_PauseResume()
    if not W.Bombax_Sound then return end
    if W.Bombax_Sound.IsPlaying then
        pcall(function() W.Bombax_Sound:Pause() end)
        W.PazzNotify("Bombax", "Paused", 1)
    else
        pcall(function() W.Bombax_Sound:Resume() end)
        W.PazzNotify("Bombax", "Resumed", 1)
    end
end

function W.Bombax_SetVolume(v)
    VD.BombaxVolume = v
    if W.Bombax_Sound then W.Bombax_Sound.Volume = v end
end

function W.Bombax_SetLoop(v)
    VD.BombaxLoop = v
    if W.Bombax_Sound then W.Bombax_Sound.Looped = v end
end

-- ═══════════════ BOMBAX SONG DROPDOWN ═══════════════
local songTitles = {}
for _, s in ipairs(W.BombaxSongs) do
    table.insert(songTitles, s.judul)
end
if #songTitles == 0 then songTitles = { "One" } end

TrollBombax:AddDropdown("BombaxSongSelect", {
    Values = songTitles,
    Default = songTitles[1],
    Text = "Pilih Lagu Bombax",
    Callback = function(v)
        VD.BombaxCurrentSong = v
        for _, s in ipairs(W.BombaxSongs) do
            if s.judul == v then
                W.Bombax_Play(s.id, s.judul)
                break
            end
        end
    end,
})
TrollBombax:AddToggle("BombaxEnabled", {
    Text = "Enable Bombax",
    Default = false,
    Callback = function(v)
        VD.BombaxEnabled = v
        if v then
            -- Auto play current song
            for _, s in ipairs(W.BombaxSongs) do
                if s.judul == (VD.BombaxCurrentSong or songTitles[1]) then
                    W.Bombax_Play(s.id, s.judul)
                    break
                end
            end
        else
            W.Bombax_Stop()
        end
    end,
})
TrollBombax:AddSlider("BombaxVol", {
    Text = "Volume",
    Default = 1, Min = 0, Max = 5, Rounding = 0.1,
    Callback = function(v) W.Bombax_SetVolume(v) end,
})
TrollBombax:AddToggle("BombaxLoopT", {
    Text = "Loop Song",
    Default = true,
    Callback = function(v) W.Bombax_SetLoop(v) end,
})
TrollBombax:AddDivider()
TrollBombax:AddButton({
    Text = "Pause / Resume",
    Func = function() W.Bombax_PauseResume() end,
})
TrollBombax:AddButton({
    Text = "Stop Music",
    Func = function() W.Bombax_Stop() end,
})

-- ═══════════════ MINI BOMBAX PANEL (floating kecil di kanan atas) ═══════════════
do
    local MiniGui = nil
    local MiniOpen = false

    function W.BombaxMini_Toggle()
        if MiniGui then
            pcall(function() MiniGui:Destroy() end)
            MiniGui = nil
            MiniOpen = false
            return
        end
        local parent = LocalPlayer:FindFirstChild("PlayerGui")
        if gethui then
            local ok, hui = pcall(gethui)
            if ok and hui then parent = hui end
        end
        if not parent then return end

        local sg = Instance.new("ScreenGui")
        sg.Name = "PazzBombaxMini"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        sg.DisplayOrder = 200
        sg.Parent = parent
        MiniGui = sg
        MiniOpen = true

        -- Container mini (bulat)
        local wrap = Instance.new("Frame")
        wrap.Name = "Wrap"
        wrap.Size = UDim2.fromOffset(60, 60)
        wrap.Position = UDim2.new(1, -80, 0, 20)
        wrap.BackgroundTransparency = 1
        wrap.Parent = sg

        local main = Instance.new("Frame")
        main.Name = "MiniMain"
        main.Size = UDim2.fromOffset(60, 60)
        main.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        main.BackgroundTransparency = 0.05
        main.BorderSizePixel = 0
        main.Parent = wrap
        Instance.new("UICorner", main).CornerRadius = UDim.new(1, 0)

        local stroke = Instance.new("UIStroke", main)
        stroke.Color = ACCENT
        stroke.Thickness = 1.5
        stroke.Transparency = 0.2

        local glow = Instance.new("UIStroke", main)
        glow.Color = ACCENT
        glow.Thickness = 4
        glow.Transparency = 0.7

        -- Icon music
        local iconImg = Instance.new("ImageLabel")
        iconImg.Size = UDim2.fromScale(0.55, 0.55)
        iconImg.Position = UDim2.fromScale(0.225, 0.225)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = "rbxassetid://6035047381"
        iconImg.ImageColor3 = Color3.fromRGB(255, 255, 255)
        iconImg.ZIndex = 3
        iconImg.Parent = main

        -- Expand button (kiri bawah)
        local expandBtn = Instance.new("TextButton")
        expandBtn.Name = "ExpandBtn"
        expandBtn.Size = UDim2.fromOffset(20, 20)
        expandBtn.Position = UDim2.new(0, -25, 0, 0)
        expandBtn.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        expandBtn.BorderSizePixel = 0
        expandBtn.Text = "▶"
        expandBtn.TextColor3 = ACCENT
        expandBtn.TextSize = 12
        expandBtn.Font = Enum.Font.GothamBold
        expandBtn.AutoButtonColor = false
        expandBtn.ZIndex = 5
        expandBtn.Parent = main
        Instance.new("UICorner", expandBtn).CornerRadius = UDim.new(1, 0)

        local expandStroke = Instance.new("UIStroke", expandBtn)
        expandStroke.Color = ACCENT
        expandStroke.Thickness = 1
        expandStroke.Transparency = 0.3

        -- Drag handler
        local dragging, dragStart, startPos = false, nil, nil
        local cd = Instance.new("TextButton")
        cd.Name = "ClickDetect"
        cd.Size = UDim2.fromScale(1, 1)
        cd.BackgroundTransparency = 1
        cd.Text = ""
        cd.AutoButtonColor = false
        cd.ZIndex = 10
        cd.Parent = main

        cd.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or
               input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = wrap.Position
            end
        end)
        cd.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or
               input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if not dragging then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement or
               input.UserInputType == Enum.UserInputType.Touch then
                local d = input.Position - dragStart
                wrap.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + d.X,
                    startPos.Y.Scale, startPos.Y.Offset + d.Y
                )
            end
        end)

        -- Expand → buka menu penuh di tab Troll
        expandBtn.MouseButton1Click:Connect(function()
            W.PazzNotify("Bombax", "Panel kecil aktif. Buka tab Troll untuk kontrol lagu.", 3)
        end)

        -- Klik utama = pause/resume
        cd.MouseButton1Click:Connect(function()
            W.Bombax_PauseResume()
        end)
    end

    W.BombaxMini_IsOpen = function() return MiniOpen end
end

TrollBombax:AddDivider()
TrollBombax:AddButton({
    Text = "Show Mini Bombax Panel",
    Func = function() W.BombaxMini_Toggle() end,
})
TrollBombax:AddButton({
    Text = "Hide Mini Bombax Panel",
    Func = function()
        if W.BombaxMini_IsOpen and W.BombaxMini_IsOpen() then
            W.BombaxMini_Toggle()
        end
    end,
})

-- ═══════════════ TROLL FUNNY SECTION ═══════════════
TrollFun:AddLabel("Coming soon...")
TrollFun:AddButton({
    Text = "Test Notify",
    Func = function() W.PazzNotify("PAZZHUB", "Hello from Troll tab!", 2) end,
})-- [[PART 18/20]]

-- ═══════════════ CONFIG: SETTINGS ═══════════════
CfgMain:AddDropdown("NotifSide", {
    Values = { "Left", "Right" },
    Default = "Right",
    Text = "Notification Side",
    Callback = function(v) Library:SetNotifySide(v) end,
})
CfgMain:AddDropdown("DPIScaleCfg", {
    Values = { "50%", "75%", "85%", "100%", "125%", "150%" },
    Default = "100%",
    Text = "DPI Scale",
    Callback = function(v)
        v = v:gsub("%%", "")
        Library:SetDPIScale(tonumber(v))
    end,
})
CfgMain:AddToggle("ShowCursorCfg", {
    Text = "Custom Cursor",
    Default = true,
    Callback = function(v) Library.ShowCustomCursor = v end,
})
CfgMain:AddToggle("WatermarkToggleCfg", {
    Text = "Watermark",
    Default = true,
    Callback = function(v) Watermark.Visible = v end,
})
CfgMain:AddDivider()
CfgMain:AddButton({
    Text = "Unload Script",
    Func = function() Library:Unload() end,
})

-- ═══════════════ CONFIG: THEME ═══════════════
CfgTheme:AddSlider("CornerRadiusCfg", {
    Text = "Corner Radius",
    Default = 14, Min = 0, Max = 20, Rounding = 0,
    Callback = function(v) Window:SetCornerRadius(v) end,
})
CfgTheme:AddColorPicker("AccentColorCfg", {
    Text = "Accent Color",
    Default = ACCENT,
    Callback = function(c)
        Library.Scheme.AccentColor = c
        Library:UpdateColors()
    end,
})
CfgTheme:AddDivider()
CfgTheme:AddButton({
    Text = "Reset Theme",
    Func = function()
        Library.Scheme.AccentColor     = Color3.fromRGB(0, 170, 255)
        Library.Scheme.BackgroundColor = Color3.fromRGB(8, 14, 26)
        Library.Scheme.MainColor       = Color3.fromRGB(16, 24, 42)
        Library.Scheme.OutlineColor    = Color3.fromRGB(0, 120, 200)
        Library.Scheme.FontColor       = Color3.fromRGB(200, 230, 255)
        Library:UpdateColors()
        W.PazzNotify("Config", "Theme reset!", 2)
    end,
})

-- ═══════════════ THEME MANAGER + SAVE MANAGER ═══════════════
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
ThemeManager:SetFolder("PazzHub")
SaveManager:SetFolder("PazzHub/configs")
SaveManager:BuildConfigSection(Tabs.Config)
ThemeManager:ApplyToTab(Tabs.Config)

-- ═══════════════ NOTIFY LOADED ═══════════════
Library:Notify({
    Title = "PAZZHUB",
    Content = "Loaded successfully! Survivor + Killer ready.",
    Duration = 5
})

print("[PAZZHUB] Loaded — Survivor + Killer + Misc + Troll + Config")
print("  Tabs: Survivor, Killer, Misc, Troll, Config")
print("  Hotkeys: LC=Toggle Menu, G=Invis, H=MyersGrab, V=FakeParry, F8=Moonwalk, Alt=Cursor")-- [[PART 19/20]]

-- ═══════════════ FINAL SETUP + SAFETY ═══════════════

-- Re-apply DPI 100 setelah semua UI dibangun (biar fix)
task.spawn(function()
    task.wait(0.5)
    pcall(function() Library:SetDPIScale(100) end)
end)

-- ═══════════════ AUTO RE-ATTACH ON RESPAWN ═══════════════
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1.5)

    -- Re-apply speed boost
    if VD.SpeedBoostEnabled and W.SpeedBoost_SetEnabled then
        W.SpeedBoost_SetEnabled(true)
    end

    -- Re-apply cursor unlock
    if VD.CursorEnabled and W.Cursor_SetEnabled then
        W.Cursor_SetEnabled(true)
    end

    -- Re-apply invis
    local MV = getgenv().GlutoInvis
    if MV and MV.Enabled and MV.API then
        pcall(function() MV.API.enable() end)
    end

    -- Re-apply infinite lunge
    if VD.KILLER_InfLunge and W.VD_UpdateInfiniteLunge then
        pcall(W.VD_UpdateInfiniteLunge)
    end

    -- Re-apply moonwalk
    if W.getMoonwalk and W.getMoonwalk() then
        if W.setMoonwalk then W.setMoonwalk(true) end
    end

    -- Re-create floating buttons yang aktif
    if W.Gluto_SHB_SetEnabled and W.InstantHealSelf then
        W.Gluto_SHB_UpdateVisual()
    end
    if W.Gluto_SUB_SetEnabled and W.SelfUnhook and W.SelfUnhook.Enabled then
        W.Gluto_SUB_UpdateVisual()
    end
    if W.Gluto_InvisBtn_SetEnabled then
        W.Gluto_InvisBtn_UpdateVisual()
    end
    if W.Gluto_MGrabBtn_SetEnabled and W.MyersGrabData and W.MyersGrabData.Enabled then
        W.Gluto_MGrabBtn_UpdateVisual()
    end
    if W.Gluto_MoonwalkBtn_SetEnabled and W.getMoonwalk and W.getMoonwalk() then
        W.Gluto_MoonwalkBtn_UpdateVisual()
    end
    if W.Gluto_TTB_SetEnabled and W.TrollTeleport and W.TrollTeleport.Enabled then
        W.Gluto_TTB_UpdateVisual()
    end
    if W.Gluto_Escape_SetEnabled and W.Escape and W.Escape.Enabled then
        W.Gluto_Escape_UpdateVisual()
    end
    if W.Gluto_ParryBtn_SetEnabled and VD.PARRY_Enabled then
        W.Gluto_ParryBtn_UpdateVisual()
    end
end)

-- ═══════════════ BIND UNLOAD (cleanup) ═══════════════
local function PazzCleanup()
    -- Stop semua thread yang aktif
    pcall(function()
        if W.SU_Stop then W.SU_Stop() end
        if W.KA_StopAutoHook then W.KA_StopAutoHook() end
        if W.KA_StopAutoStalk then W.KA_StopAutoStalk() end
        if W.ManualGen_SetEnabled then W.ManualGen_SetEnabled(false) end
        if W.AutoGen_SetEnabled then W.AutoGen_SetEnabled(false) end
        if W.SpeedBoost_SetEnabled then W.SpeedBoost_SetEnabled(false) end
        if W.Cursor_SetEnabled then W.Cursor_SetEnabled(false) end
        if W.setMoonwalk then W.setMoonwalk(false) end
        if W.TrollTeleport_SetEnabled then W.TrollTeleport_SetEnabled(false) end
        if W.Bombax_Stop then W.Bombax_Stop() end
        if W.Flash_SetEnabled then W.Flash_SetEnabled(false) end
        if W.SetToFSilentAim then W.SetToFSilentAim(false) end
        if W.Invisible_SetState then
            local MV = getgenv().GlutoInvis
            if MV and MV.Enabled then W.Invisible_SetState(false, true) end
        end
    end)

    -- Hapus semua floating buttons
    pcall(function()
        if W.Gluto_SHB_SetEnabled then W.Gluto_SHB_SetEnabled(false) end
        if W.Gluto_SUB_SetEnabled then W.Gluto_SUB_SetEnabled(false) end
        if W.Gluto_TTB_SetEnabled then W.Gluto_TTB_SetEnabled(false) end
        if W.Gluto_Escape_SetEnabled then W.Gluto_Escape_SetEnabled(false) end
        if W.Gluto_ParryBtn_SetEnabled then W.Gluto_ParryBtn_SetEnabled(false) end
        if W.Gluto_InvisBtn_SetEnabled then W.Gluto_InvisBtn_SetEnabled(false) end
        if W.Gluto_MGrabBtn_SetEnabled then W.Gluto_MGrabBtn_SetEnabled(false) end
        if W.Gluto_MoonwalkBtn_SetEnabled then W.Gluto_MoonwalkBtn_SetEnabled(false) end
    end)

    -- Hapus semua GUI
    pcall(function()
        for _, gui in ipairs(CoreGui:GetChildren()) do
            if gui.Name:match("^Pazz") or gui.Name:match("^Gluto") then
                pcall(function() gui:Destroy() end)
            end
        end
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if pg then
            for _, gui in ipairs(pg:GetChildren()) do
                if gui.Name:match("^Pazz") or gui.Name:match("^Gluto") then
                    pcall(function() gui:Destroy() end)
                end
            end
        end
    end)

    -- Hapus workspace parts
    pcall(function()
        for _, obj in ipairs(Workspace:GetChildren()) do
            if obj.Name == "PazzToFLaser" or obj.Name == "PazzFlashLaser"
                or obj.Name == "PazzFlaskBeam" or obj.Name == "PazzFlaskAccent"
                or obj.Name == "PazzFlaskLanding" or obj.Name == "PazzParryCircle" then
                pcall(function() obj:Destroy() end)
            end
        end
    end)

    W.PazzNotify("PAZZHUB", "Unloaded!", 2)
end
W.PazzCleanup = PazzCleanup

-- ═══════════════ GLOBAL EXPORT (buat akses luar) ═══════════════
getgenv().PAZZHUB = {
    Version = "v1",
    Library = Library,
    Window = Window,
    Tabs = Tabs,
    State = VD,
    Cleanup = PazzCleanup,
    Bombax = {
        Play = W.Bombax_Play,
        Stop = W.Bombax_Stop,
        Songs = W.BombaxSongs,
    },
}

print("[PAZZHUB] All systems initialized.")-- [[PART 20/20]]

-- ═══════════════ BIND UNLOAD BUTTON KE CLEANUP ═══════════════
-- Override unload button supaya panggil cleanup dulu
pcall(function()
    local cfgL = Tabs.Config:AddLeftGroupbox("Advanced", "alert-circle")
    cfgL:AddButton({
        Text = "Clean Unload (Full Stop)",
        Func = function()
            if W.PazzCleanup then
                W.PazzCleanup()
                task.wait(0.5)
            end
            Library:Unload()
        end,
    })
    cfgL:AddButton({
        Text = "Restart Script",
        Func = function()
            if W.PazzCleanup then W.PazzCleanup() end
            task.wait(0.5)
            local url = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/../../../"
            -- Just re-init: unload dulu
            Library:Unload()
            W.PazzNotify("PAZZHUB", "Unloaded. Re-execute script manual.", 3)
        end,
    })
    cfgL:AddParagraph({
        Title = "Hotkeys",
        Content = "LC = Toggle Menu | G = Invis | H = Myers Grab | V = Fake Parry | F8 = Moonwalk | Alt = Cursor"
    })
end)

-- ═══════════════ AUTO-SAVE EVERY 60s ═══════════════
task.spawn(function()
    while true do
        task.wait(60)
        pcall(function()
            if SaveManager.Save then
                SaveManager:Save("autosave")
            end
        end)
    end
end)

-- ═══════════════ ERROR HANDLER ═══════════════
local oldErr = getgenv().__pazzhub_err
getgenv().__pazzhub_err = function(err)
    warn("[PAZZHUB ERROR] " .. tostring(err))
    if oldErr then pcall(oldErr, err) end
end

-- ═══════════════ FINAL NOTIFY ═══════════════
task.spawn(function()
    task.wait(1)
    pcall(function()
        Library:Notify({
            Title = "PAZZHUB",
            Content = "Ready! Tekan LeftControl untuk toggle menu.",
            Duration = 6
        })
    end)
end)

-- ═══════════════ CLOSING LOG ═══════════════
print("═══════════════════════════════════════════════════════════════")
print("[PAZZHUB] ULTIMATE EDITION — Loaded Successfully")
print("───────────────────────────────────────────────────────────────")
print("  Survivor Tab:")
print("    • Auto Crouch Dodge")
print("    • Auto Flee Killer")
print("    • Auto Parry V1 (Pisah Groupbox)")
print("    • Auto Parry V2 (Pisah Groupbox)")
print("    • Swift Vault + V2")
print("    • Pallet Reflex")
print("    • Fake Parry")
print("    • No Fall Damage")
print("    • Manual/Auto Generator")
print("    • Silent Aim TOF")
print("    • Silent Flashlight")
print("    • Dash Lock")
print("  Killer Tab:")
print("    • Auto Attack")
print("    • Infinite Lunge")
print("    • Counter Auto Parry")
print("    • Aim Lock Attack")
print("    • Bypass: Hidden Leap, Myers, Slasher, Abyss, Jeff")
print("    • Auto Hook")
print("    • Auto Stalk, Kill All, Drop Pallet, Block Vault")
print("    • Anti Blind, Destroy Pallet")
print("    • Masked Power")
print("    • Killer Perks Display")
print("    • Silent Veil V1 + V2")
print("    • Silent Flask")
print("    • Spear Aimbot")
print("  Misc Tab:")
print("    • Speed Boost")
print("    • Cursor Unlock")
print("    • Invisible")
print("    • Moonwalk")
print("    • Self Heal, Auto Heal All")
print("    • Self Unhook")
print("    • Escape, Troll TP")
print("    • Floating Button Panel")
print("  Troll Tab:")
print("    • Bombax Music (32 lagu)")
print("    • Mini Bombax Panel (bulat)")
print("  Config Tab:")
print("    • DPI 100, Theme, Save")
print("───────────────────────────────────────────────────────────────")
print("  Floating Buttons (BULAT + ICON PAZZHUB):")
print("    • Self Heal, Self Unhook, Troll TP, Escape")
print("    • Parry, Invisible, Myers Grab, Moonwalk")
print("───────────────────────────────────────────────────────────────")
print("  Hotkeys:")
print("    LC  = Toggle Menu")
print("    G   = Invisible")
print("    H   = Myers Grab")
print("    V   = Fake Parry")
print("    F8  = Moonwalk")
print("    Alt = Cursor Unlock")
print("═══════════════════════════════════════════════════════════════")
