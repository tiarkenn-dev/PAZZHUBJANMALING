--========================================================--
-- PAZZHUB v2.0 — Obsidian Edition
-- Logic: ALFzxzzz HUB v0.3.7
-- Menu GUI: Obsidian UI (Biru Neon)
-- Powered by Vanzxzz
-- Free Script - Jangan Dijual!
--========================================================--

print("[PAZZHUB v2.0] Loading...")
print("[PAZZHUB v2.0] ▸ Loading Obsidian UI...")
print("[PAZZHUB v2.0] ▸ Loading Core...")
print("[PAZZHUB v2.0] ▸ Loading Survivor Features...")
print("[PAZZHUB v2.0] ▸ Loading Killer Features...")
print("[PAZZHUB v2.0] ▸ Loading Visuals...")
print("[PAZZHUB v2.0] ▸ Loading Misc...")
print("[PAZZHUB v2.0] ▸ Building UI...")
print("[PAZZHUB v2.0] ✅ Loaded Successfully!")

--═══════════════════════════════════════════════════════════--
-- PART 1: HEADER + OBSIDIAN LOAD + TEMA BIRU NEON + WINDOW + 5 TAB
--═══════════════════════════════════════════════════════════--

getgenv().PAZZHUB = getgenv().PAZZHUB or {}
local W = getgenv()

--=== OBSIDIAN LOAD ===
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

--=== TEMA BIRU NEON ===
Library.Scheme.AccentColor     = Color3.fromRGB(0, 170, 255)
Library.Scheme.BackgroundColor = Color3.fromRGB(8, 14, 26)
Library.Scheme.MainColor       = Color3.fromRGB(16, 24, 42)
Library.Scheme.OutlineColor    = Color3.fromRGB(0, 120, 200)
Library.Scheme.FontColor       = Color3.fromRGB(200, 230, 255)

local TOGGLE_ICON = 72845574620852
local ACCENT = Color3.fromRGB(0, 170, 255)

--=== FLOATING TOGGLE ===
local function CreatePazzToggle(IconId)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PazzToggle"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:GetService("CoreGui")

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
        game:GetService("TweenService"):Create(MainButton, TweenInfo.new(.15), {
            BackgroundColor3 = Color3.fromRGB(16, 24, 42)
        }):Play()
        game:GetService("TweenService"):Create(Glow, TweenInfo.new(.15), {
            Transparency = 0.3
        }):Play()
    end)

    MainButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(MainButton, TweenInfo.new(.15), {
            BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        }):Play()
        game:GetService("TweenService"):Create(Glow, TweenInfo.new(.15), {
            Transparency = 0.6
        }):Play()
    end)

    MainButton.MouseButton1Click:Connect(function()
        game:GetService("TweenService"):Create(MainButton, TweenInfo.new(.08), {
            Size = UDim2.fromOffset(36, 36)
        }):Play()
        task.wait(.08)
        game:GetService("TweenService"):Create(MainButton, TweenInfo.new(.08), {
            Size = UDim2.fromOffset(42, 42)
        }):Play()
        Library:Toggle()
    end)

    Library:MakeDraggable(MainButton, MainButton, true)
end

CreatePazzToggle(TOGGLE_ICON)

--=== WINDOW ===
local Window = Library:CreateWindow({
    Title = "PAZZHUB",
    Footer = "PazzHub v2.0",
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

--=== WATERMARK ===
local Watermark = Library:AddDraggableLabel("PAZZHUB v2.0")

local Stats = game:GetService("Stats")
local RunService = game:GetService("RunService")
local FPS, Frames, LastTick = 0, 0, tick()

RunService.RenderStepped:Connect(function()
    Frames += 1
    if tick() - LastTick >= 1 then
        FPS = Frames; Frames = 0; LastTick = tick()
        local Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        Watermark:SetText(string.format("PAZZHUB | FPS: %d | PING: %d ms", FPS, Ping))
    end
end)

--=== TABS (5 tab sama kaya ALFzxzzz asli) ===
local Tabs = {
    Survivor = Window:AddTab("Survivor", "user"),
    Visuals  = Window:AddTab("Visuals",  "eye"),
    Killer   = Window:AddTab("Killer",   "crosshair"),
    Misc     = Window:AddTab("Misc",     "settings"),
    Config   = Window:AddTab("Config",   "save"),
}

W.Tabs = Tabs

--=== NOTIFY WRAPPER ===
local function PAZZHUB_Notify(title, content, duration)
    Library:Notify({
        Title = title or "PAZZHUB",
        Content = content or "",
        Duration = duration or 3,
    })
end
local function ShowNotify(title, content, duration) PAZZHUB_Notify(title, content, duration) end
local function ForceNotify(title, content, duration) PAZZHUB_Notify(title, content, duration) end

W.Notify = ShowNotify
W.PAZZHUB_Notify = PAZZHUB_Notify
W.ForceNotify = ForceNotify

--═══════════════════════════════════════════════════════════--
-- CORE BASE
--═══════════════════════════════════════════════════════════--

local Players           = game:GetService("Players")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local CoreGui           = game:GetService("CoreGui")
local CollectionService = game:GetService("CollectionService")
local TweenService      = game:GetService("TweenService")
local GuiService        = game:GetService("GuiService")
local HttpService       = game:GetService("HttpService")
local Lighting          = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local VirtualInputManager = nil
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

W.Players = Players
W.RunService = RunService
W.UserInputService = UserInputService
W.ReplicatedStorage = ReplicatedStorage
W.Workspace = Workspace
W.CoreGui = CoreGui
W.CollectionService = CollectionService
W.TweenService = TweenService
W.GuiService = GuiService
W.HttpService = HttpService
W.Lighting = Lighting
W.LocalPlayer = LocalPlayer
W.isMobile = isMobile
W.VirtualInputManager = VirtualInputManager
W.NotifyEnabled = true

--=== VARIABLE DEFAULTS ===
PAZZHUB.PARRY_Enabled        = PAZZHUB.PARRY_Enabled or false
PAZZHUB.PARRY_Aggressive     = PAZZHUB.PARRY_Aggressive or false
PAZZHUB.PARRY_Distance       = PAZZHUB.PARRY_Distance or 10
PAZZHUB.PARRY_ShowCircle     = PAZZHUB.PARRY_ShowCircle or false
PAZZHUB.PARRY_SilentParry    = PAZZHUB.PARRY_SilentParry or false
PAZZHUB.PARRY_ShowFloatBtn   = PAZZHUB.PARRY_ShowFloatBtn or false
PAZZHUB.AutoCrouch           = PAZZHUB.AutoCrouch or false
PAZZHUB.KILLER_AutoAttack         = PAZZHUB.KILLER_AutoAttack or false
PAZZHUB.KILLER_AutoAttackRange    = PAZZHUB.KILLER_AutoAttackRange or 12
PAZZHUB.KILLER_AutoAttackCooldown = PAZZHUB.KILLER_AutoAttackCooldown or 0.15
PAZZHUB.SURV_AutoFlee        = PAZZHUB.SURV_AutoFlee or false
PAZZHUB.SURV_AutoFleeDist    = PAZZHUB.SURV_AutoFleeDist or 40
PAZZHUB.SURV_AutoFleeCooldown= PAZZHUB.SURV_AutoFleeCooldown or 1.5

PAZZHUB.VeilEnabled          = PAZZHUB.VeilEnabled or false
PAZZHUB.VeilShowFOV          = PAZZHUB.VeilShowFOV ~= false
PAZZHUB.VeilShowTracker      = PAZZHUB.VeilShowTracker or false
PAZZHUB.VeilAutoPredict      = PAZZHUB.VeilAutoPredict ~= false
PAZZHUB.VeilFOV              = PAZZHUB.VeilFOV or 150
PAZZHUB.VeilMaxDist          = PAZZHUB.VeilMaxDist or 280
PAZZHUB.VeilSpearSpeed       = PAZZHUB.VeilSpearSpeed or 165
PAZZHUB.VeilGravity          = PAZZHUB.VeilGravity or 103
PAZZHUB.VeilAuraSpearSpeed   = PAZZHUB.VeilAuraSpearSpeed or 165
PAZZHUB.VeilAuraSpearGravity = PAZZHUB.VeilAuraSpearGravity or 96
PAZZHUB.VeilLeadMultiplier   = PAZZHUB.VeilLeadMultiplier or 1.4

PAZZHUB.TOF_SilentAim    = PAZZHUB.TOF_SilentAim or false
PAZZHUB.TOF_TargetMode   = PAZZHUB.TOF_TargetMode or "Killer"
PAZZHUB.TOF_Key          = PAZZHUB.TOF_Key or "Q"
PAZZHUB.TOF_Laser        = PAZZHUB.TOF_Laser ~= false
PAZZHUB.TOF_WallCheck    = PAZZHUB.TOF_WallCheck ~= false
PAZZHUB.TOF_BlockKnocked = PAZZHUB.TOF_BlockKnocked ~= false

PAZZHUB.Invis_Enabled       = PAZZHUB.Invis_Enabled or false
PAZZHUB.Invis_ShowFloatBtn  = PAZZHUB.Invis_ShowFloatBtn or false
PAZZHUB.Invis_Hotkey        = PAZZHUB.Invis_Hotkey or "G"

PAZZHUB.KILLER_BypassLeap     = PAZZHUB.KILLER_BypassLeap or false
PAZZHUB.KILLER_InfGrab        = PAZZHUB.KILLER_InfGrab or false
PAZZHUB.KILLER_InfLakeMist    = PAZZHUB.KILLER_InfLakeMist or false
PAZZHUB.KILLER_InfPursuit     = PAZZHUB.KILLER_InfPursuit or false
PAZZHUB.KILLER_BypassCooldown = PAZZHUB.KILLER_BypassCooldown or false
PAZZHUB.KILLER_InfFrenzy      = PAZZHUB.KILLER_InfFrenzy or false
PAZZHUB.KILLER_AntiBlind      = PAZZHUB.KILLER_AntiBlind or false
PAZZHUB.KILLER_DestroyPallets = PAZZHUB.KILLER_DestroyPallets or false
PAZZHUB.KILLER_InfLunge       = PAZZHUB.KILLER_InfLunge or false
PAZZHUB.KILLER_AutoHook       = PAZZHUB.KILLER_AutoHook or false

PAZZHUB.KA_AutoStalk       = PAZZHUB.KA_AutoStalk or false
PAZZHUB.KA_AutoStalkRange  = PAZZHUB.KA_AutoStalkRange or 150
PAZZHUB.KA_AutoKillAll     = PAZZHUB.KA_AutoKillAll or false
PAZZHUB.KA_DropAllPallet   = PAZZHUB.KA_DropAllPallet or false
PAZZHUB.KA_BlockAllVault   = PAZZHUB.KA_BlockAllVault or false

PAZZHUB.SURV_FakeParry           = PAZZHUB.SURV_FakeParry or false
PAZZHUB.SURV_FakeParryAnim       = PAZZHUB.SURV_FakeParryAnim or "Enten"
PAZZHUB.SURV_FakeParryCooldown   = PAZZHUB.SURV_FakeParryCooldown or 0.4
PAZZHUB.SURV_FakeParryKey        = PAZZHUB.SURV_FakeParryKey or "V"
PAZZHUB.SURV_FakeParryShowBtn    = PAZZHUB.SURV_FakeParryShowBtn or false
PAZZHUB.SURV_FakeParryLocked     = PAZZHUB.SURV_FakeParryLocked or false

PAZZHUB.NoFallDamage         = PAZZHUB.NoFallDamage or false
PAZZHUB.NextMapPredict       = PAZZHUB.NextMapPredict or false
PAZZHUB.ManualGen            = PAZZHUB.ManualGen or false
PAZZHUB.AutoGen              = PAZZHUB.AutoGen or false
PAZZHUB.KillerEscapeDist     = PAZZHUB.KillerEscapeDist or 30

PAZZHUB.Wisnu_AutoParry       = PAZZHUB.Wisnu_AutoParry or false
PAZZHUB.Wisnu_ParryAggressive = PAZZHUB.Wisnu_ParryAggressive or false
PAZZHUB.Wisnu_ParrySafety     = PAZZHUB.Wisnu_ParrySafety or false
PAZZHUB.Wisnu_ParryDistance   = PAZZHUB.Wisnu_ParryDistance or 6
PAZZHUB.Wisnu_ParryFace       = PAZZHUB.Wisnu_ParryFace or 0.7
PAZZHUB.Wisnu_ParryCircle     = PAZZHUB.Wisnu_ParryCircle or true
PAZZHUB.Wisnu_IgnoredSkills   = PAZZHUB.Wisnu_IgnoredSkills or {}

PAZZHUB.KillerPerksDisplay   = PAZZHUB.KillerPerksDisplay or false
PAZZHUB.SpeedBoostEnabled    = PAZZHUB.SpeedBoostEnabled or false
PAZZHUB.SpeedBoostValue      = PAZZHUB.SpeedBoostValue or 30
PAZZHUB.CursorEnabled        = PAZZHUB.CursorEnabled or false

W.InstantHealSelf = W.InstantHealSelf or false
W.AutoHealAll     = W.AutoHealAll or false

_G.PAZZHUB_ACCENT     = Color3.fromRGB(0, 170, 255)
_G.PAZZHUB_ACCENT_BG  = Color3.fromRGB(0, 0, 0)
_G.PAZZHUB_NEUTRAL    = Color3.fromRGB(90, 90, 90)
_G.PAZZHUB_STROKE_OFF = Color3.fromRGB(25, 25, 25)
_G.PAZZHUB_BG_OFF     = Color3.fromRGB(0, 0, 0)

--=== TEAM HELPER ===
local function TeamIs(plr, role)
    if not plr or not plr.Team or not plr.Team.Name then return false end
    local tn = string.lower(plr.Team.Name)
    if role == "Killer" then return string.find(tn, "killer", 1, true) ~= nil end
    if role == "Survivor" then return string.find(tn, "survivor", 1, true) ~= nil end
    return false
end
W.TeamIs = TeamIs

local function GetRole()
    if TeamIs(LocalPlayer, "Killer") then return "Killer" end
    if TeamIs(LocalPlayer, "Survivor") then return "Survivor" end
    return nil
end
W.GetRole = GetRole

--=== GENERATOR HELPERS ===
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
end

-- [PART 3: AUTO CROUCH + AUTO ATTACK + AUTO FLEE DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 3: AUTO CROUCH + AUTO ATTACK + AUTO FLEE
--═══════════════════════════════════════════════════════════--

--=== AUTO CROUCH DODGE ===
function IsDowned(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local state = char:GetAttribute("State")
    return state == "Downed" or state == "Dead"
end

function TriggerCrouch()
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

local DodgeAttached = {}
function IsKiller(p) return p.Team and p.Team.Name == "Killer" end

function AttachParrySensor(kChar)
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
        if id == "80411309607666" and PAZZHUB.AutoCrouch then
            local myChar = LocalPlayer.Character
            if IsDowned(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if myHRP and kHRP then
                local dist = (myHRP.Position - kHRP.Position).Magnitude
                if dist <= 40 then TriggerCrouch() end
            end
            return
        end
    end)
end

function TryAttach(p)
    if p ~= LocalPlayer and IsKiller(p) and p.Character then AttachParrySensor(p.Character) end
end

function SetupPlayer(p)
    if p == LocalPlayer then return end
    p.CharacterAdded:Connect(function() TryAttach(p) end)
    p:GetPropertyChangedSignal("Team"):Connect(function() TryAttach(p) end)
    if p.Character then TryAttach(p) end
end

for _, p in pairs(Players:GetPlayers()) do SetupPlayer(p) end
Players.PlayerAdded:Connect(SetupPlayer)
task.spawn(function()
    while true do
        task.wait(5)
        for _, p in pairs(Players:GetPlayers()) do TryAttach(p) end
    end
end)

--=== AUTO ATTACK (KILLER) ===
local lastAutoAttack = 0
function W.KA_AutoAttack()
    if not PAZZHUB.KILLER_AutoAttack then return end
    if GetRole() ~= "Killer" then return end
    local now = tick()
    if now - lastAutoAttack < (PAZZHUB.KILLER_AutoAttackCooldown or 0.15) then return end
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local closest, shortest = nil, PAZZHUB.KILLER_AutoAttackRange or 12
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

--=== AUTO FLEE KILLER (SURVIVOR) ===
local lastAutoFlee = 0
function W.SURV_AutoFlee()
    if not PAZZHUB.SURV_AutoFlee then return end
    if GetRole() ~= "Survivor" then return end
    local now = tick()
    if now - lastAutoFlee < (PAZZHUB.SURV_AutoFleeCooldown or 1.5) then return end
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not myRoot or not hum or hum.Health <= 0 then return end
    local killerRoot = nil
    local nearest = math.huge
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
    if nearest > (PAZZHUB.SURV_AutoFleeDist or 40) then return end
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
        PAZZHUB_Notify("Auto Flee", "Teleported away from killer!", 2)
    end
end

task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(W.KA_AutoAttack)
        pcall(W.SURV_AutoFlee)
    end
end)

-- [PART 4a: SURVIVOR — Self Heal + Swift Vault + Pallet Reflex DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 4a: SURVIVOR — Self Heal + Swift Vault + Pallet Reflex
--═══════════════════════════════════════════════════════════--

--=== SELF HEAL ===
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

W.SelfHeal_BlockedAnimId = "95836365038528"
W.SelfHeal_AnimMonitor = W.SelfHeal_AnimMonitor or { Conn = nil, CharHook = nil }

function W.SelfHeal_StartAnimBlock()
    if W.SelfHeal_AnimMonitor.Conn then return end
    W.SelfHeal_AnimMonitor.Conn = RunService.Heartbeat:Connect(function()
        if not W.InstantHealSelf then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local anim = hum:FindFirstChildOfClass("Animator")
        if not anim then return end
        local ok2, tracks = pcall(function() return anim:GetPlayingAnimationTracks() end)
        if not ok2 then return end
        for _, track in ipairs(tracks) do
            local aid = track.Animation and track.Animation.AnimationId or ""
            local numId = aid:match("%d+")
            if numId == W.SelfHeal_BlockedAnimId then
                pcall(function() track:Stop(0) end)
            end
        end
    end)
    local function hookChar(char)
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3)
        if not anim then return end
        anim.AnimationPlayed:Connect(function(track)
            if not W.InstantHealSelf then return end
            local aid = track.Animation and track.Animation.AnimationId or ""
            local numId = aid:match("%d+")
            if numId == W.SelfHeal_BlockedAnimId then
                pcall(function() track:Stop(0) end)
            end
        end)
    end
    hookChar(LocalPlayer.Character)
    W.SelfHeal_AnimMonitor.CharHook = LocalPlayer.CharacterAdded:Connect(function(c)
        task.wait(0.3); hookChar(c)
    end)
end

function W.SelfHeal_StopAnimBlock()
    if W.SelfHeal_AnimMonitor.Conn then
        pcall(function() W.SelfHeal_AnimMonitor.Conn:Disconnect() end)
        W.SelfHeal_AnimMonitor.Conn = nil
    end
    if W.SelfHeal_AnimMonitor.CharHook then
        pcall(function() W.SelfHeal_AnimMonitor.CharHook:Disconnect() end)
        W.SelfHeal_AnimMonitor.CharHook = nil
    end
end

function W.setInstantHealSelf(v)
    W.InstantHealSelf = v
    if v then
        if W.SelfHeal_StartAnimBlock then W.SelfHeal_StartAnimBlock() end
    else
        if W.SelfHeal_StopAnimBlock then W.SelfHeal_StopAnimBlock() end
    end
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
        if W.InstantHealConnection then W.InstantHealConnection:Disconnect(); W.InstantHealConnection = nil end
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
        if W.AutoHealAllConnection then W.AutoHealAllConnection:Disconnect(); W.AutoHealAllConnection = nil end
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if W.InstantHealSelf then W.setInstantHealSelf(true) end
    if W.AutoHealAll then W.setAutoHealAll(true) end
end)

--=== SWIFT VAULT ===
do
    PAZZHUB.SURV_AutoVault  = PAZZHUB.SURV_AutoVault  or false
    PAZZHUB.SURV_FastVault  = PAZZHUB.SURV_FastVault  or false
    PAZZHUB.SURF_VaultSpeed = PAZZHUB.SURF_VaultSpeed or 13
    local _vaultedWindows = {}
    local _lastVaultScan  = 0
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
    RunService.Heartbeat:Connect(function()
        if PAZZHUB.SURV_FastVault then
            pcall(function()
                local char = LocalPlayer.Character
                if char then char:SetAttribute("vaultspeed", (PAZZHUB.SURF_VaultSpeed or 13) / 10) end
            end)
        end
    end)
    RunService.Heartbeat:Connect(function()
        if not PAZZHUB.SURV_AutoVault then return end
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
                        if d < nearestVTDist then nearestVTDist = d; nearestVT = vt end
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
        task.wait(0.5); _vaultedWindows = {}
    end)
    W.SwiftVault_SetEnabled = function(v)
        PAZZHUB.SURV_AutoVault = v and true or false; _vaultedWindows = {}
    end
    W.SwiftVaultV2_SetEnabled = function(v)
        PAZZHUB.SURV_FastVault = v and true or false
        if not v then
            local char = LocalPlayer.Character
            if char then pcall(function() char:SetAttribute("vaultspeed", 1) end) end
        end
    end
    W.SwiftVault_SetSpeed = function(v) PAZZHUB.SURF_VaultSpeed = tonumber(v) or 13 end
end

--=== PALLET REFLEX ===
do
    PAZZHUB.SURV_AutoPallet     = PAZZHUB.SURV_AutoPallet     or false
    PAZZHUB.SURV_AutoPalletDist = PAZZHUB.SURV_AutoPalletDist or 20
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
        if not PAZZHUB.SURV_AutoPallet then return end
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
            if (myRoot.Position - killerRoot.Position).Magnitude > (PAZZHUB.SURV_AutoPalletDist or 20) then return end
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
                        if d < bestDist then bestDist = d; bestPallet = pal end
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
        task.wait(0.5); _usedPallets = {}
    end)
    W.PalletReflex_SetEnabled = function(v)
        PAZZHUB.SURV_AutoPallet = v and true or false; _usedPallets = {}
    end
    W.PalletReflex_SetDistance = function(v) PAZZHUB.SURV_AutoPalletDist = tonumber(v) or 20 end
end

-- [PART 4b: SURVIVOR — Fake Parry + Fake Perks DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 4b: SURVIVOR — Fake Parry + Fake Perks
--═══════════════════════════════════════════════════════════--

--=== FAKE PARRY ===
do
    local FakeParryTrack = nil
    local FakeParryLast  = 0
    local FakeParryButtonGui = nil
    local FakeParryButton = nil

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
        if not PAZZHUB.SURV_FakeParry then return end
        if GetRole() ~= "Survivor" then return end
        local now = tick()
        if now - FakeParryLast < (tonumber(PAZZHUB.SURV_FakeParryCooldown) or 0.4) then return end
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

        local animId = FakeParryAnims[PAZZHUB.SURV_FakeParryAnim] or FakeParryAnims["Enten"]
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

    local function FakeParry_CreateButton()
        if FakeParryButtonGui then return end
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if not pg then return end

        local sg = Instance.new("ScreenGui")
        sg.Name = "PAZZHUBFakeParryBtn"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        sg.DisplayOrder = 100
        sg.Parent = pg

        local btn = Instance.new("TextButton")
        btn.Name = "FakeParryBtn"
        btn.Size = UDim2.fromOffset(64, 64)
        btn.Position = UDim2.new(0.82, 0, 0.62, 0)
        btn.AnchorPoint = Vector2.new(0.5, 0.5)
        btn.BackgroundColor3 = Color3.fromRGB(20, 10, 30)
        btn.BackgroundTransparency = 0.15
        btn.Text = "FAKE\nPARRY"
        btn.TextColor3 = Color3.fromRGB(220, 180, 255)
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamBold
        btn.AutoButtonColor = true
        btn.ZIndex = 10
        btn.Parent = sg
        Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(200, 120, 255)
        stroke.Thickness = 2
        stroke.Transparency = 0.2

        local lockBtn = Instance.new("TextButton")
        lockBtn.Name = "LockDrag"
        lockBtn.Size = UDim2.new(0, 22, 0, 22)
        lockBtn.Position = UDim2.new(1, -5, 0, -5)
        lockBtn.AnchorPoint = Vector2.new(1, 0)
        lockBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        lockBtn.BackgroundTransparency = 0.3
        lockBtn.Text = PAZZHUB.SURV_FakeParryLocked and "X" or "L"
        lockBtn.TextSize = 10
        lockBtn.Font = Enum.Font.GothamBold
        lockBtn.TextColor3 = Color3.new(1, 1, 1)
        lockBtn.ZIndex = 11
        lockBtn.Parent = btn
        Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(1, 0)

        lockBtn.MouseButton1Click:Connect(function()
            PAZZHUB.SURV_FakeParryLocked = not PAZZHUB.SURV_FakeParryLocked
            lockBtn.Text = PAZZHUB.SURV_FakeParryLocked and "X" or "L"
            lockBtn.BackgroundColor3 = PAZZHUB.SURV_FakeParryLocked and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(60, 60, 60)
        end)

        local dragging, dragStart, startPos = false, nil, nil
        local moved = false
        btn.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                if PAZZHUB.SURV_FakeParryLocked then return end
                dragging = true
                moved = false
                dragStart = inp.Position
                startPos = btn.Position
            end
        end)
        btn.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                if dragging and moved then
                elseif not moved then
                    FakeParry_Play()
                end
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if not dragging or PAZZHUB.SURV_FakeParryLocked then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                local d = inp.Position - dragStart
                if math.abs(d.X) + math.abs(d.Y) > 6 then moved = true end
                btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)

        FakeParryButtonGui = sg
        FakeParryButton = btn
    end

    local function FakeParry_RemoveButton()
        if FakeParryButtonGui then
            pcall(function() FakeParryButtonGui:Destroy() end)
            FakeParryButtonGui = nil
            FakeParryButton = nil
        end
    end

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        local keyName = PAZZHUB.SURV_FakeParryKey or "V"
        local kc = Enum.KeyCode[keyName]
        if kc and input.KeyCode == kc then
            FakeParry_Play()
        end
    end)

    task.spawn(function()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if not pg then return end
        task.wait(2)
        pcall(function()
            local mob = pg:FindFirstChild("Survivor-mob")
            local controls = mob and mob:FindFirstChild("Controls")
            if not controls then return end
            for _, name in ipairs({"Parry", "parry", "action", "Gui-mob"}) do
                local btn = controls:FindFirstChild(name)
                if btn and btn:IsA("GuiButton") then
                    btn.MouseButton1Click:Connect(function() FakeParry_Play() end)
                end
            end
        end)
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        if PAZZHUB.SURV_FakeParryShowBtn and PAZZHUB.SURV_FakeParry then
            FakeParry_RemoveButton()
            FakeParry_CreateButton()
        end
    end)

    function W.FakeParry_SetEnabled(v)
        PAZZHUB.SURV_FakeParry = v and true or false
        if not v then FakeParry_Stop() end
        if v and UserInputService.TouchEnabled and PAZZHUB.SURV_FakeParryShowBtn then
            FakeParry_CreateButton()
        end
    end
    function W.FakeParry_SetAnim(name)
        if name and FakeParryAnims[name] then
            PAZZHUB.SURV_FakeParryAnim = name
        else
            PAZZHUB.SURV_FakeParryAnim = "Enten"
        end
    end
    function W.FakeParry_Trigger() FakeParry_Play() end
    function W.FakeParry_SetShowButton(v)
        PAZZHUB.SURV_FakeParryShowBtn = v and true or false
        if v then FakeParry_CreateButton() else FakeParry_RemoveButton() end
    end
    function W.FakeParry_SetKeybind(keyName)
        local ok, kc = pcall(function() return Enum.KeyCode[tostring(keyName):upper()] end)
        if ok and kc then
            PAZZHUB.SURV_FakeParryKey = kc.Name
            return true
        end
        return false
    end
end

--=== FAKE PERKS ===
W.FP = W.FP or {
    ActiveBuffs = {}, Conns = {}, LastBuffEnd = 0, CooldownTime = 5, HB = nil,
    FlowstateOn = false, QuickRecOn = false, PerfLandOn = false, AdrenalineOn = false,
}
local FP = W.FP
local function FP_Char() return LocalPlayer.Character end
local function FP_Hum() local c = FP_Char(); return c and c:FindFirstChildOfClass("Humanoid") end
local function FP_GetTotal()
    local t = 0
    for _,b in pairs(FP.ActiveBuffs) do if tick() < b.endTime then t = t + b.amt end end
    return t
end
local function FP_Apply()
    local c = FP_Char()
    local tb = FP_GetTotal()
    local h = FP_Hum()
    if c then if tb > 0 then c:SetAttribute("speedboost", 1+(tb/14)) else c:SetAttribute("speedboost", 1) end end
    if h and tb > 0 then h.WalkSpeed = 16 + tb end
end
local function FP_EnsureHB()
    if FP.HB then return end
    FP.HB = RunService.Heartbeat:Connect(function()
        local exp = {}
        for n,b in pairs(FP.ActiveBuffs) do if tick() >= b.endTime then table.insert(exp,n) end end
        for _,n in ipairs(exp) do FP.ActiveBuffs[n]=nil end
        if #exp > 0 and FP_GetTotal()<=0 then FP.LastBuffEnd = tick() end
        FP_Apply()
        if FP_GetTotal()<=0 and next(FP.ActiveBuffs)==nil then
            if FP.HB then FP.HB:Disconnect(); FP.HB=nil end
            local c = FP_Char()
            if c then c:SetAttribute("speedboost",1) end
        end
    end)
end
local function FP_TryBuff(name, amt, dur)
    if FP.ActiveBuffs[name] then return end
    if tick()-FP.LastBuffEnd < FP.CooldownTime and next(FP.ActiveBuffs)==nil then return end
    FP.ActiveBuffs[name] = {amt=amt, endTime=tick()+dur, duration=dur, startTime=tick()}
    FP_Apply(); FP_EnsureHB()
    PAZZHUB_Notify("Fake Perks", "["..name.."] Aktif! +"..amt.." Speed ("..dur.."s)", 3)
end
local function FP_Clean(name)
    if FP.Conns[name] then for _,c in ipairs(FP.Conns[name]) do pcall(function() c:Disconnect() end) end FP.Conns[name] = nil end
end
local function FP_Reg(name, conn) if not FP.Conns[name] then FP.Conns[name] = {} end table.insert(FP.Conns[name], conn) end

function W.FP_SetupFlowstate(val)
    FP.FlowstateOn = val
    local c = FP_Char()
    if c then c:SetAttribute("Flowstate", val) end
    if val then
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local w = r and r:FindFirstChild("Window")
        local p = r and r:FindFirstChild("Pallet")
        local function onV()
            if not FP.FlowstateOn then return end
            task.delay(0.5, function() if FP.FlowstateOn then FP_TryBuff("Flowstate",5,3) end end)
        end
        if w then local vb = w:FindFirstChild("Vaultbindable"); if vb and vb:IsA("BindableEvent") then FP_Reg("Flowstate", vb.Event:Connect(onV)) end end
        if p then local sb = p:FindFirstChild("Slidebindable"); if sb and sb:IsA("BindableEvent") then FP_Reg("Flowstate", sb.Event:Connect(onV)) end end
        local function hookChar(cc)
            if not cc then return end
            local cn = cc:GetAttributeChangedSignal("__VaultFireCount"):Connect(function() if FP.FlowstateOn then onV() end end)
            FP_Reg("Flowstate", cn)
        end
        hookChar(LocalPlayer.Character)
        FP_Reg("Flowstate", LocalPlayer.CharacterAdded:Connect(function(cc) if FP.FlowstateOn then cc:SetAttribute("Flowstate",true); hookChar(cc) end end))
    else
        FP_Clean("Flowstate")
        FP.ActiveBuffs["Flowstate"] = nil
        local c2 = FP_Char()
        if c2 then c2:SetAttribute("Flowstate", false) end
    end
end

function W.FP_SetupQuickRecovery(val)
    FP.QuickRecOn = val
    if val then
        local function onH() if not FP.QuickRecOn then return end FP_TryBuff("QuickRecovery", 6, 3) end
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local hf = r and r:FindFirstChild("Healing")
        if hf then local hd = hf:FindFirstChild("Healdone"); if hd and hd:IsA("BindableEvent") then FP_Reg("QuickRecovery", hd.Event:Connect(onH)) end end
        local function hookH(cc)
            if not cc then return end
            local h = cc:FindFirstChildOfClass("Humanoid")
            if h then
                local lh = h.Health
                local cn = h.HealthChanged:Connect(function(nh)
                    if not FP.QuickRecOn then return end
                    if nh > lh and (nh>=h.MaxHealth or (nh-lh)>=15) then onH() end
                    lh = nh
                end)
                FP_Reg("QuickRecovery", cn)
            end
        end
        hookH(LocalPlayer.Character)
        FP_Reg("QuickRecovery", LocalPlayer.CharacterAdded:Connect(hookH))
    else
        FP_Clean("QuickRecovery")
        FP.ActiveBuffs["QuickRecovery"] = nil
    end
end

function W.FP_SetupPerfectLanding(val)
    FP.PerfLandOn = val
    if val then
        local function hookF(cc)
            if not cc then return end
            local h = cc:FindFirstChildOfClass("Humanoid")
            if not h then return end
            local wf, fs = false, 0
            local cn = h.StateChanged:Connect(function(_,n)
                if not FP.PerfLandOn then return end
                if n == Enum.HumanoidStateType.Freefall then wf=true; fs=tick() end
                if wf and (n == Enum.HumanoidStateType.Landed or n == Enum.HumanoidStateType.Running) then
                    local ft = tick() - fs
                    wf = false
                    if ft >= 0.25 then FP_TryBuff("PerfectLanding", 8, 3) end
                end
            end)
            FP_Reg("PerfectLanding", cn)
        end
        hookF(LocalPlayer.Character)
        FP_Reg("PerfectLanding", LocalPlayer.CharacterAdded:Connect(hookF))
    else
        FP_Clean("PerfectLanding")
        FP.ActiveBuffs["PerfectLanding"] = nil
    end
end

function W.FP_SetupAdrenalineRush(val)
    FP.AdrenalineOn = val
    if val then
        local function hookD(cc)
            if not cc then return end
            local h = cc:FindFirstChildOfClass("Humanoid")
            if not h then return end
            local lh = h.Health
            local cn = h.HealthChanged:Connect(function(nh)
                if not FP.AdrenalineOn then return end
                if nh < lh and nh <= 50 and nh > 0 then FP_TryBuff("AdrenalineRush", 4, 5) end
                lh = nh
            end)
            FP_Reg("AdrenalineRush", cn)
        end
        hookD(LocalPlayer.Character)
        FP_Reg("AdrenalineRush", LocalPlayer.CharacterAdded:Connect(hookD))
    else
        FP_Clean("AdrenalineRush")
        FP.ActiveBuffs["AdrenalineRush"] = nil
    end
end

-- [PART 4c: SURVIVOR — Auto Parry V1 (Cooldown + Fire) DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 4c: SURVIVOR — Auto Parry V1 (Cooldown + Fire)
--═══════════════════════════════════════════════════════════--

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
W.KillerAttackAnims = KillerAttackAnims

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

local function ParryHookSilenced(char)
    if not char then return end
    ParryCooldown.IsSilenced = CollectionService:HasTag(char, "Silenced")
end
CollectionService:GetInstanceAddedSignal("Silenced"):Connect(function(i)
    if i == LocalPlayer.Character then ParryCooldown.IsSilenced = true end
end)
CollectionService:GetInstanceRemovedSignal("Silenced"):Connect(function(i)
    if i == LocalPlayer.Character then ParryCooldown.IsSilenced = false end
end)
LocalPlayer.CharacterAdded:Connect(function(c) task.wait(0.5); ParryHookSilenced(c) end)
if LocalPlayer.Character then ParryHookSilenced(LocalPlayer.Character) end

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

local ParryCheckAttrs = {"isVaulting","isSliding","isDroppingPallet","isRepairing","isHealing","isUnhooking","isExiting"}
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
                    didFire = true; break
                end
            end
        end
    end
    if not didFire then
        local remote = ReplicatedStorage:FindFirstChild("Remotes")
        local items = remote and remote:FindFirstChild("Items")
        local dagger = items and items:FindFirstChild("Parrying Dagger")
        local parry = dagger and dagger:FindFirstChild("parry")
        if parry then pcall(function() parry:FireServer() end) end
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
    if PAZZHUB.PARRY_SilentParry then ParryExecuteSilent(); return end
    if isMobile then ParryExecuteMobile() else ParryExecutePC() end
end

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
end)

-- [PART 4d: SURVIVOR — Auto Parry V1 (Circle + Hook + Poll) DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 4d: SURVIVOR — Auto Parry V1 (Circle + Hook + Poll)
--═══════════════════════════════════════════════════════════--

local function ParryDestroyCircle()
    if ParryState.CircleFolder then
        pcall(function() if ParryState.CircleFolder.Parent then ParryState.CircleFolder:Destroy() end end)
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
getgenv()._PAZZHUB_DestroyParryCircle = ParryDestroyCircle

local function ParryBuildCircle(radius)
    ParryDestroyCircle()
    local folder = Instance.new("Folder")
    folder.Name = "PAZZHUBParryCircleDashes"
    local dashCount = math.clamp(math.floor(radius * 6), 24, 120)
    local slotLength = (2 * math.pi * radius) / dashCount
    local dashLength = slotLength * 0.55
    local dashThickness = 0.03
    local dashes, rotCFs, offsets = table.create(dashCount), table.create(dashCount), table.create(dashCount)
    for i = 1, dashCount do
        local part = Instance.new("Part")
        part.Name = "Dash" .. i
        part.Anchored = true; part.CanCollide = false
        part.CanTouch = false; part.CanQuery = false; part.CastShadow = false
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromRGB(255, 255, 255)
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
    local eased = 1 - (1 - spawnT)^3
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
    else tc = Color3.fromRGB(255, 255, 255) end
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

local function ParryHookAnimatorOnChar(plr, char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3)
    if not anim then return end
    anim.AnimationPlayed:Connect(function(track)
        if not PAZZHUB.PARRY_Enabled then return end
        if not ParryIsEquippedDagger() then return end
        local at = ParryGetAnimType(track)
        if at then
            ParryState.ActiveAttackers[plr] = { char = char, track = track, type = at, registeredAt = os.clock() }
        end
    end)
end

local function ParryHookKillerPlayer(plr)
    if plr == LocalPlayer then return end
    if plr.Character then ParryHookAnimatorOnChar(plr, plr.Character) end
    plr.CharacterAdded:Connect(function(char) task.wait(0.5); ParryHookAnimatorOnChar(plr, char) end)
end
for _, p in ipairs(Players:GetPlayers()) do ParryHookKillerPlayer(p) end
Players.PlayerAdded:Connect(ParryHookKillerPlayer)

local parryLastPoll = 0
local function ParryPollAttacks()
    if not PAZZHUB.PARRY_Enabled or not ParryIsEquippedDagger() then return end
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
                                ParryState.ActiveAttackers[plr] = { char = char, track = track, type = at, registeredAt = now }
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

local function ParryCheckAndParry(killerChar)
    if ParryIsOnCooldown() or ParryCooldown.WaitingForResult
        or ParryCooldown.IsSilenced or not ParryIsEquippedDagger() then return end
    local cc = ParryGetCharCache()
    local myRoot = cc.UpperTorso or cc.Root
    local killerPart = killerChar and (killerChar:FindFirstChild("UpperTorso") or killerChar:FindFirstChild("Torso") or killerChar:FindFirstChild("HumanoidRootPart"))
    if not myRoot or not killerPart then return end
    local dist = (myRoot.Position - killerPart.Position).Magnitude
    if PAZZHUB.PARRY_Aggressive then
        local ping = math.clamp(LocalPlayer:GetNetworkPing(), 0, 0.3)
        local killerRoot = killerChar:FindFirstChild("HumanoidRootPart") or killerPart
        local killerVel = killerRoot.AssemblyLinearVelocity
        local flatVel = Vector3.new(killerVel.X, 0, killerVel.Z)
        local predictedPos = killerPart.Position + flatVel * ping
        local predDist = (myRoot.Position - predictedPos).Magnitude
        if predDist <= ((PAZZHUB.PARRY_Distance or 10) + 2.5) then
            if flatVel.Magnitude > 6 then
                local dir = myRoot.Position - killerPart.Position
                if dir.Magnitude > 0 and flatVel.Unit:Dot(dir.Unit) > 0.4 then ParryExecute(); return end
            end
        end
    end
    if dist <= (PAZZHUB.PARRY_Distance or 10) then ParryExecute() end
end

local function ParryUpdateLogic()
    if not PAZZHUB.PARRY_Enabled then return end
    if not ParryIsEquippedDagger() then ParryState.ActiveAttackers = {}; return end
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

local function ParryUpdateCircleLogic()
    local char = LocalPlayer.Character
    local myRoot = char and char:FindFirstChild("HumanoidRootPart")
    if PAZZHUB.PARRY_ShowCircle and PAZZHUB.PARRY_Enabled and ParryIsEquippedDagger() and myRoot then
        if not ParryState.CircleFolder or ParryState.CircleRadius ~= (PAZZHUB.PARRY_Distance or 10) or not ParryState.CircleFolder.Parent then
            ParryBuildCircle(PAZZHUB.PARRY_Distance or 10)
        end
        ParryUpdateCircle(myRoot)
    else
        if ParryState.CircleFolder then ParryDestroyCircle() end
    end
end

local parryLastLogic, parryLastCircle = 0, 0
RunService.Heartbeat:Connect(function()
    local now = os.clock()
    if now - parryLastCircle >= 0.033 then parryLastCircle = now; pcall(ParryUpdateCircleLogic) end
    if now - parryLastLogic >= 0.05 then parryLastLogic = now; pcall(ParryUpdateLogic) end
end)

-- [PART 4e: SURVIVOR — Auto Parry V2 (Wisnu) DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 4e: SURVIVOR — Auto Parry V2 (Wisnu)
--═══════════════════════════════════════════════════════════--

do
    local ValidParryIDs = {
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

    local W2State = { Cooldown = false, CooldownThread = nil, lastParry = 0, Adornment = nil }
    local W2Attached = {}

    local function W2_IsKiller(p) return p and p.Team and p.Team.Name == "Killer" end
    local function W2_IsDowned(char) return char and (char:GetAttribute("Knocked") == true or char:GetAttribute("IsHooked") == true) end

    local function W2_IsSafeToParry(char)
        if not PAZZHUB.Wisnu_ParrySafety then return true end
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

    local function W2_PressRightClick()
        if not VirtualInputManager then return end
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
            task.wait()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
        end)
    end

    local function W2_TapMobileParryButton()
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
            W2_PressRightClick()
        end
    end

    local function W2_ExecuteParry()
        if W2State.Cooldown then return end
        W2State.lastParry = tick()
        pcall(function()
            local parryRemote = ReplicatedStorage:FindFirstChild("Remotes")
                :FindFirstChild("Items")
                :FindFirstChild("Parrying Dagger")
                :FindFirstChild("parry")
            if parryRemote then
                for i = 1, 10 do parryRemote:FireServer() end
            end
            task.spawn(W2_TapMobileParryButton)
        end)
    end

    task.spawn(function()
        local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
        local dagger = remotes and remotes:WaitForChild("Items", 5):WaitForChild("Parrying Dagger", 5)
        local parryResultRemote = dagger and dagger:WaitForChild("parryResult", 5)
        if parryResultRemote then
            parryResultRemote.OnClientEvent:Connect(function(arg1, arg2)
                local cdDur = tonumber(arg2) or ((arg1 == true) and 90 or 60)
                W2State.Cooldown = true
                if W2State.CooldownThread then task.cancel(W2State.CooldownThread) end
                W2State.CooldownThread = task.delay(cdDur, function()
                    W2State.Cooldown = false
                end)
            end)
        end
    end)

    local function W2_TriggerCrouch()
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

    local function W2_AttachParrySensor(kChar)
        if not kChar or W2Attached[kChar] then return end
        W2Attached[kChar] = true
        local humanoid = kChar:FindFirstChild("Humanoid")
        if not humanoid then humanoid = kChar:WaitForChild("Humanoid", 5); if not humanoid then return end end
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then animator = humanoid:WaitForChild("Animator", 5); if not animator then return end end

        humanoid.ChildAdded:Connect(function(child)
            if child:IsA("Animator") then W2Attached[kChar] = nil; W2_AttachParrySensor(kChar) end
        end)
        kChar.AncestryChanged:Connect(function(_, parent)
            if not parent then W2Attached[kChar] = nil end
        end)

        animator.AnimationPlayed:Connect(function(track)
            local animId = track.Animation and track.Animation.AnimationId or ""
            local id = animId:match("%d+")
            local attackName = ValidParryIDs[id]
            if not attackName then return end

            if id == "80411309607666" and PAZZHUB.AutoCrouch then
                local myChar = LocalPlayer.Character
                if W2_IsDowned(myChar) then return end
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local kHRP = kChar:FindFirstChild("HumanoidRootPart")
                if myHRP and kHRP then
                    if (myHRP.Position - kHRP.Position).Magnitude <= 40 then W2_TriggerCrouch() end
                end
                return
            end

            if not PAZZHUB.Wisnu_AutoParry then return end
            if W2State.Cooldown then return end
            if PAZZHUB.Wisnu_IgnoredSkills and PAZZHUB.Wisnu_IgnoredSkills[attackName] then return end

            local myChar = LocalPlayer.Character
            if W2_IsDowned(myChar) or not W2_IsSafeToParry(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if not myHRP or not kHRP then return end

            local startDistance = (myHRP.Position - kHRP.Position).Magnitude

            if PAZZHUB.Wisnu_ParryAggressive then
                local aggressiveRadius = 12
                local detectionRadius = PAZZHUB.Wisnu_ParryDistance + 5
                if startDistance > detectionRadius then return end
                if startDistance <= aggressiveRadius then
                    W2_ExecuteParry()
                else
                    local tracker
                    local startTime = os.clock()
                    tracker = RunService.Heartbeat:Connect(function()
                        if os.clock() - startTime >= 1.5 or W2State.Cooldown or not myHRP or not kHRP or W2_IsDowned(myChar) then
                            if tracker then tracker:Disconnect() end
                            return
                        end
                        if (myHRP.Position - kHRP.Position).Magnitude <= aggressiveRadius then
                            W2_ExecuteParry()
                            if tracker then tracker:Disconnect() end
                        end
                    end)
                end
            else
                if startDistance > PAZZHUB.Wisnu_ParryDistance then return end
                local myPosFlat = Vector3.new(myHRP.Position.X, 0, myHRP.Position.Z)
                local kPosFlat = Vector3.new(kHRP.Position.X, 0, kHRP.Position.Z)
                local flatDelta = myPosFlat - kPosFlat
                if flatDelta.Magnitude > 0 then
                    local flatDirection = flatDelta.Unit
                    local kLookFlat = Vector3.new(kHRP.CFrame.LookVector.X, 0, kHRP.CFrame.LookVector.Z).Unit
                    if kLookFlat:Dot(flatDirection) < PAZZHUB.Wisnu_ParryFace then return end
                end
                W2_ExecuteParry()
            end
        end)
    end

    local function W2_TryAttach(p)
        if p ~= LocalPlayer and W2_IsKiller(p) and p.Character then W2_AttachParrySensor(p.Character) end
    end

    local function W2_SetupPlayer(p)
        if p == LocalPlayer then return end
        p.CharacterAdded:Connect(function() W2_TryAttach(p) end)
        p:GetPropertyChangedSignal("Team"):Connect(function() W2_TryAttach(p) end)
        if p.Character then W2_TryAttach(p) end
    end

    for _, p in pairs(Players:GetPlayers()) do W2_SetupPlayer(p) end
    Players.PlayerAdded:Connect(W2_SetupPlayer)
    task.spawn(function()
        while true do
            task.wait(5)
            for _, p in pairs(Players:GetPlayers()) do W2_TryAttach(p) end
        end
    end)

    -- Circle ESP
    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if PAZZHUB.Wisnu_ParryCircle and PAZZHUB.Wisnu_AutoParry and hrp then
            if not W2State.Adornment or W2State.Adornment.Parent ~= hrp then
                if W2State.Adornment then W2State.Adornment:Destroy() end
                W2State.Adornment = Instance.new("CylinderHandleAdornment")
                W2State.Adornment.Name = "PAZZHUBAutoParryCircleESP"
                W2State.Adornment.Height = 0.05
                W2State.Adornment.Transparency = 0.3
                W2State.Adornment.Adornee = hrp
                W2State.Adornment.Parent = hrp
                W2State.Adornment.ZIndex = 0
                W2State.Adornment.AlwaysOnTop = false
            end
            local cR = PAZZHUB.Wisnu_ParryDistance
            W2State.Adornment.Radius = cR
            W2State.Adornment.InnerRadius = math.max(0.1, cR - 0.15)
            W2State.Adornment.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(90), 0, 0)
            if W2State.Cooldown then
                W2State.Adornment.Color3 = Color3.fromRGB(128, 128, 128)
            else
                W2State.Adornment.Color3 = Color3.fromRGB(255, 255, 255)
            end
        elseif W2State.Adornment then
            W2State.Adornment:Destroy()
            W2State.Adornment = nil
        end
    end)
end

-- [PART 4f: SURVIVOR — Auto Skill Check + Gen Bypass + Vault + God Mode DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 4f: SURVIVOR — Skill Check + Gen Bypass + Vault + God Mode
--═══════════════════════════════════════════════════════════--

--=== AUTO SKILL CHECK ===
W.SC = W.SC or { Enabled = false, Mode = "Legit", Busy = false, Conn = nil }
local SC = W.SC

local function SC_FindPrompt()
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not pg then return nil end
    for _, name in ipairs({
        "SkillCheckPromptGui", "SkillCheck", "SkillcheckGui",
        "SkillCheckGui", "SkillcheckPrompt", "CheckPrompt"
    }) do
        local g = pg:FindFirstChild(name)
        if g then return g end
    end
    for _, g in ipairs(pg:GetChildren()) do
        local ln = g.Name:lower()
        if ln:find("skill") or ln:find("check") then return g end
    end
    return nil
end

local function SC_FindCheck(prompt)
    local c = prompt:FindFirstChild("Check")
    if c then return c end
    for _, d in ipairs(prompt:GetDescendants()) do
        if (d:IsA("Frame") or d:IsA("ImageLabel")) and d.Visible and d.AbsoluteSize.X > 30 then
            return d
        end
    end
    return nil
end

local function SC_FindPointerTarget(check)
    local pointer, target
    for _, d in ipairs(check:GetDescendants()) do
        if d:IsA("GuiObject") then
            local n = d.Name:lower()
            if n:find("pointer") or n:find("line") or n:find("spinner")
               or n:find("needle") or n:find("cursor") then
                pointer = d
            elseif n:find("target") or n:find("goal") or n:find("zone")
                or n:find("success") or n:find("hit") then
                target = d
            end
        end
    end
    return pointer, target
end

local function SC_Press()
    if VirtualInputManager then
        local ok = pcall(function()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.02)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end)
        if ok then return true end
    end
    if keypress and keyrelease then
        local ok = pcall(function()
            keypress(Enum.KeyCode.Space)
            task.wait(0.02)
            keyrelease(Enum.KeyCode.Space)
        end)
        if ok then return true end
    end
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local mob = pg and pg:FindFirstChild("Survivor-mob")
    local ctrl = mob and mob:FindFirstChild("Controls")
    if ctrl then
        for _, n in ipairs({"action", "Gui-mob", "Parry", "attack"}) do
            local btn = ctrl:FindFirstChild(n)
            if btn and btn:IsA("GuiButton") and firesignal then
                pcall(function() firesignal(btn.MouseButton1Click) end)
                return true
            end
        end
    end
    return false
end

function W.SC_Set(v)
    SC.Enabled = v
    PAZZHUB.SkillCheck_Enabled = v
    if SC.Conn then SC.Conn:Disconnect(); SC.Conn = nil end
    if not v then return end
    SC.Conn = RunService.RenderStepped:Connect(function()
        if not SC.Enabled or SC.Busy then return end
        local prompt = SC_FindPrompt()
        if not prompt then return end
        local check = SC_FindCheck(prompt)
        if not check or not check.Visible then return end
        local pointer, target = SC_FindPointerTarget(check)

        if SC.Mode == "Instant" then
            SC.Busy = true
            task.spawn(function()
                SC_Press()
                task.wait(0.25)
                SC.Busy = false
            end)
            return
        end

        if pointer and target then
            local pr = pointer.Rotation % 360
            local tr = target.Rotation % 360
            local diff = math.abs((pr - tr + 180) % 360 - 180)
            if diff <= 12 then
                SC.Busy = true
                task.spawn(function()
                    SC_Press()
                    task.wait(0.05)
                    SC.Busy = false
                end)
            end
        elseif pointer then
            local r = pointer.Rotation % 360
            if r > 100 and r < 130 then
                SC.Busy = true
                task.spawn(function()
                    SC_Press()
                    task.wait(0.05)
                    SC.Busy = false
                end)
            end
        end
    end)
end

--=== BYPASS GENERATOR ===
W.GB = W.GB or { Enabled = false, Cache = {}, Timer = 0, Processed = {}, Hotkey = Enum.KeyCode.B, Range = 8 }
local GB = W.GB
PAZZHUB.GenBypass_Enabled = PAZZHUB.GenBypass_Enabled or false
PAZZHUB.GenBypass_Range   = PAZZHUB.GenBypass_Range   or 8

function W.GB_Cached()
    local now = tick()
    if now - GB.Timer < 5 then return GB.Cache end
    GB.Cache = {}; GB.Timer = now
    local map = Workspace:FindFirstChild("Map")
    if not map then return GB.Cache end
    pcall(function()
        for _, v in pairs(map:GetDescendants()) do
            if v:IsA("Model") and v.Name == "Generator" then
                if v:GetAttribute("RepairProgress") or v:GetAttribute("kickcount") or v:GetAttribute("ProgressRepair") then
                    table.insert(GB.Cache, v)
                end
            end
        end
    end)
    return GB.Cache
end

function W.GB_Nearest()
    local c = LocalPlayer.Character
    local root = c and c:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local best, bd = nil, math.huge
    for _, g in pairs(W.GB_Cached()) do
        for _, p in pairs(W.GB_GetPoints(g)) do
            local d = (root.Position - p.Position).Magnitude
            if d < bd then bd = d; best = p end
        end
    end
    return best, bd
end

function W.GB_Repair(tp)
    local gm = tp.Parent
    if GB.Processed[gm] then return end
    GB.Processed[gm] = true
    local c = LocalPlayer.Character
    local root = c and c:FindFirstChild("HumanoidRootPart")
    if not root then GB.Processed[gm] = nil; return end
    local re = ReplicatedStorage.Remotes.Generator.RepairEvent
    local og = root.CFrame
    pcall(function()
        for _, p in pairs(W.GB_GetPoints(gm)) do
            if p ~= tp and p.Parent then
                root.Anchored = true
                root.CFrame = p.CFrame
                task.wait(0.15)
                pcall(function() re:FireServer(p, true) end)
                task.wait(0.3)
                pcall(function() re:FireServer(p, false) end)
                task.wait(0.1)
                pcall(function() re:FireServer(p, true) end)
                task.wait(0.3)
                root.Anchored = false
            end
        end
    end)
    pcall(function() if root and root.Parent then root.Anchored = false; root.CFrame = og end end)
    task.wait(0.1)
    pcall(function() re:FireServer(tp, false) end)
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp or isMobile then return end
    if input.KeyCode == GB.Hotkey and GB.Enabled then
        local bp, bd = W.GB_Nearest()
        if not bp or bd > GB.Range then return end
        if GB.Processed[bp.Parent] then return end
        W.GB_Repair(bp)
    end
end)

task.spawn(function()
    while true do
        task.wait(2)
        local c = LocalPlayer.Character
        local root = c and c:FindFirstChild("HumanoidRootPart")
        if root then
            for gm in pairs(GB.Processed) do
                if not gm or not gm.Parent then GB.Processed[gm] = nil; continue end
                local near = false
                for _, p in pairs(W.GB_GetPoints(gm)) do
                    if p.Parent and (root.Position - p.Position).Magnitude <= 10 then near = true; break end
                end
                if not near then GB.Processed[gm] = nil end
            end
        end
    end
end)

--=== UNLIMITED VAULT ===
local UVOn, UVConn = false, nil
function W.UV_Set(v)
    PAZZHUB.UnlimitedVault = v
    if v then
        if UVOn then return end
        UVOn = true
        for _, inst in ipairs(CollectionService:GetTagged("Blocked")) do
            CollectionService:RemoveTag(inst, "Blocked")
        end
        UVConn = CollectionService:GetInstanceAddedSignal("Blocked"):Connect(function(i)
            CollectionService:RemoveTag(i, "Blocked")
        end)
    else
        UVOn = false
        if UVConn then UVConn:Disconnect(); UVConn = nil end
    end
end

--=== ANTI SLOW VAULT ===
local ASVOn, ASVConn = false, nil
function W.ASV_Set(v)
    PAZZHUB.AntiSlowVault = v
    if v then
        if ASVOn then return end
        ASVOn = true
        for _, inst in ipairs(CollectionService:GetTagged("SlowVault")) do
            CollectionService:RemoveTag(inst, "SlowVault")
        end
        ASVConn = CollectionService:GetInstanceAddedSignal("SlowVault"):Connect(function(i)
            CollectionService:RemoveTag(i, "SlowVault")
        end)
    else
        ASVOn = false
        if ASVConn then ASVConn:Disconnect(); ASVConn = nil end
    end
end

--=== GOD MODE ===
local GodThread = nil
function W.God_Set(v)
    PAZZHUB.GodMode = v
    if GodThread then task.cancel(GodThread); GodThread = nil end
    if v then
        GodThread = task.spawn(function()
            while PAZZHUB.GodMode do
                local c = LocalPlayer.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if h and h.Health > 0 and h.Health < h.MaxHealth then
                    pcall(function() h.Health = h.MaxHealth end)
                end
                task.wait(0.1)
            end
        end)
    end
end

-- [PART 4g: SURVIVOR — Auto Run + Troll TP + Bypass Unhook DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 4g: SURVIVOR — Auto Run + Troll TP + Bypass Unhook
--═══════════════════════════════════════════════════════════--

--=== AUTO RUN ===
do
    PAZZHUB.AutoRun_PC     = PAZZHUB.AutoRun_PC     or false
    PAZZHUB.AutoRun_Mobile = PAZZHUB.AutoRun_Mobile or false
    local tPC, tMob = nil, nil
    local function startPC()
        if tPC then task.cancel(tPC) end
        tPC = task.spawn(function()
            while PAZZHUB.AutoRun_PC do
                pcall(function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse()) end)
                task.wait(0.1)
            end
            pcall(function() VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse()) end)
            tPC = nil
        end)
    end
    local function stopPC()
        PAZZHUB.AutoRun_PC = false
        if tPC then task.cancel(tPC); tPC = nil end
        pcall(function() VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse()) end)
    end
    local function getSprint()
        local pg = LocalPlayer:FindFirstChild("PlayerGui"); if not pg then return nil end
        local mob = pg:FindFirstChild("Survivor-mob"); if not mob then return nil end
        local ctrl = mob:FindFirstChild("Controls"); if not ctrl then return nil end
        return ctrl:FindFirstChild("sprint")
    end
    local function pressSprint()
        local b = getSprint()
        if not b then return end
        pcall(function()
            if firesignal then
                firesignal(b.MouseButton1Click)
                firesignal(b.MouseButton1Down)
                task.wait(0.04)
                firesignal(b.MouseButton1Up)
            end
        end)
    end
    local function startMob()
        if tMob then return end
        tMob = task.spawn(function()
            while PAZZHUB.AutoRun_Mobile do
                local c = LocalPlayer.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if h and h.MoveDirection.Magnitude > 0.12 then pressSprint() end
                task.wait(0.12)
            end
            tMob = nil
        end)
    end
    function W.AutoRunPC(v) PAZZHUB.AutoRun_PC = v; if v then startPC() else stopPC() end end
    function W.AutoRunMobile(v) PAZZHUB.AutoRun_Mobile = v; if v then startMob() else PAZZHUB.AutoRun_Mobile = false end end
end

--=== TROLL TELEPORT ===
W.TrollTeleport = W.TrollTeleport or {
    Enabled = false, IsProcessing = false, TriggerCount = 0,
    AnimatorHook = nil, CharHook = nil,
    BlockedAnimList = { ["123812278891591"] = 1, ["74099023522626"] = 2 },
}
local TT = W.TrollTeleport
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
        PAZZHUB_Notify("Troll Teleport", "Trigger #" .. TT.TriggerCount .. " | Delay " .. delay .. "s", 2)
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
function W.TrollTeleport_Start()
    if TT.AnimatorHook then return end
    TT.IsProcessing = false
    TT_HookCharacter(LocalPlayer.Character)
    TT.CharHook = LocalPlayer.CharacterAdded:Connect(function(c) task.wait(0.4); TT_HookCharacter(c) end)
end
function W.TrollTeleport_Stop()
    if TT.CharHook then pcall(function() TT.CharHook:Disconnect() end); TT.CharHook = nil end
    TT.AnimatorHook = nil
    TT.IsProcessing = false
end
function W.TrollTeleport_SetEnabled(v)
    TT.Enabled = v and true or false
    if TT.Enabled then W.TrollTeleport_Start() else W.TrollTeleport_Stop() end
end

--=== BYPASS SELF UNHOOK ===
W.SU = W.SU or {
    Enabled = false, Following = false, FollowDuration = 30, FollowDistance = 20,
    MonitorConn = nil, _lastTrigger = 0, _cooldown = 3,
    _hookPos = nil, _hookCFrame = nil, _activeThread = nil, _wasHooked = false
}
local SU = W.SU

function W.SU_IsHooked()
    local c = LocalPlayer.Character
    if not c then return false end
    return c:GetAttribute("IsHooked") == true or c:GetAttribute("isHooked") == true
        or c:GetAttribute("Hooked") == true or c:GetAttribute("HookedState") == true
end

function W.SU_GetGenPoint()
    local gens = W.GB_GetAllGenerators()
    if not gens or #gens == 0 then return nil end
    local v = {}
    for _, g in ipairs(gens) do
        if g and g.Parent then
            for _, p in ipairs(W.GB_GetPoints(g)) do
                if p and p.Parent then table.insert(v, p) end
            end
        end
    end
    if #v == 0 then return nil end
    return v[math.random(1, #v)]
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

function W.SU_Abort()
    SU.Following = false
    if SU._activeThread and coroutine.status(SU._activeThread) ~= "dead" then
        pcall(function() task.cancel(SU._activeThread) end)
    end
    SU._activeThread = nil
end

function W.SU_Trigger()
    if SU.Following then return end
    local now = tick()
    if now - SU._lastTrigger < SU._cooldown then return end
    if not W.SU_IsHooked() then return end
    SU._lastTrigger = now; SU.Following = true
    local c = LocalPlayer.Character
    if c then
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if hrp then SU._hookPos = hrp.Position; SU._hookCFrame = hrp.CFrame end
    end
    SU._activeThread = task.spawn(function()
        local cc = LocalPlayer.Character
        if not cc then SU.Following = false; SU._activeThread = nil; return end
        local hrp = cc:FindFirstChild("HumanoidRootPart")
        if not hrp then SU.Following = false; SU._activeThread = nil; return end
        local re = ReplicatedStorage:FindFirstChild("Remotes")
            and ReplicatedStorage.Remotes:FindFirstChild("Generator")
            and ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
        if not W.SU_IsHooked() then SU.Following = false; SU._activeThread = nil; return end
        local tp = W.SU_GetGenPoint()
        if tp then
            pcall(function() hrp.Velocity = Vector3.zero; hrp.CFrame = tp.CFrame + Vector3.new(0, 3, 0) end)
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
                PAZZHUB_Notify("Self Unhook", "Released - STOP", 2)
                return
            end
            local c2 = LocalPlayer.Character
            if not c2 then break end
            local r = c2:FindFirstChild("HumanoidRootPart")
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
            local c3 = LocalPlayer.Character
            if c3 then
                local r2 = c3:FindFirstChild("HumanoidRootPart")
                if r2 then
                    if SU._hookCFrame then pcall(function() r2.Velocity = Vector3.zero; r2.CFrame = SU._hookCFrame end)
                    elseif SU._hookPos then pcall(function() r2.Velocity = Vector3.zero; r2.CFrame = CFrame.new(SU._hookPos + Vector3.new(0, 3, 0)) end) end
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
        local c = LocalPlayer.Character
        if not c then return end
        local isH = W.SU_IsHooked()
        if not isH then SU._wasHooked = false; return end
        if not SU._wasHooked and not SU.Following then SU._wasHooked = true; W.SU_Trigger() end
    end)
end

function W.SU_Stop()
    if SU.MonitorConn then SU.MonitorConn:Disconnect(); SU.MonitorConn = nil end
    W.SU_Abort(); SU._wasHooked = false
end

function W.SU_Set(v)
    PAZZHUB.SelfUnhook_Enabled = v
    SU.Enabled = v
    if v then W.SU_Start() else W.SU_Stop() end
end

-- [PART 4h: SURVIVOR — Map Predict + Manual/Auto Gen + Moonwalk DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════-- -- PART 4h: SURVIVOR — Map Predict + Manual/Auto Gen + Moonwalk --═══════════════════════════════════════════════════════════-- --=== NEXT MAP PREDICTION === do local MapPredictState = { Gui = nil, Thread = nil, Enabled = false, LastMap = "Unknown" } local function DetectMapName(map) if not map then return nil end if map:FindFirstChild("random shakes") or map:FindFirstChild("SCP-173 Room") or map:FindFirstChild("SCP-205 Room") then return "Site 68" elseif map:FindFirstChild("HooksMeat") then return "BLOODBATH! Club" elseif map:FindFirstChild("Gate") and map.Gate:FindFirstChild("vfx") then return "Firelink Shrine" elseif map:FindFirstChild("Bldg_Addon_RooftopUnit_A") or map:FindFirstChild("Rooftop") then return "Mercy Hospital Rooftop" elseif map:FindFirstChild("White Armored Car") then return "Mount Massive Asylum" elseif map:FindFirstChild("Dumbster") then return "The Bay Harbor" elseif map:FindFirstChild("water pump") then return "Valdelobos Village" elseif map:FindFirstChild("LargeBoulder01") then return "Woodview Cabin" end return nil end local function BuildMapGui() if MapPredictState.Gui then pcall(function() MapPredictState.Gui:Destroy() end) end local pg = LocalPlayer:FindFirstChild("PlayerGui") if gethui then local ok, hui = pcall(gethui) if ok and hui then pg = hui end end if not pg then return end local gui = Instance.new("ScreenGui") gui.Name = "PAZZHUBMapPredict" gui.ResetOnSpawn = false gui.IgnoreGuiInset = true gui.DisplayOrder = 50 gui.Parent = pg local frame = Instance.new("Frame") frame.Name = "MainFrame" frame.Size = UDim2.new(0, 210, 0, 54) frame.Position = UDim2.new(0.5, -105, 0, 110) frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18) frame.BackgroundTransparency = 0.15 frame.BorderSizePixel = 0 frame.Active = true frame.Parent = gui Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10) local stroke = Instance.new("UIStroke", frame) stroke.Color = Color3.fromRGB(0, 170, 255) stroke.Thickness = 1.5 stroke.Transparency = 0.2 stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border local title = Instance.new("TextLabel") title.Size = UDim2.new(1, 0, 0, 15) title.Position = UDim2.new(0, 0, 0, 5) title.BackgroundTransparency = 1 title.Text = "NEXT MAP PREDICTION" title.TextColor3 = Color3.fromRGB(150, 180, 255) title.Font = Enum.Font.GothamBold title.TextSize = 10 title.Parent = frame local mapName = Instance.new("TextLabel") mapName.Name = "MapName" mapName.Size = UDim2.new(1, -12, 0, 18) mapName.Position = UDim2.new(0, 6, 0, 21) mapName.BackgroundTransparency = 1 mapName.Text = "Scanning..." mapName.TextColor3 = Color3.fromRGB(255, 255, 255) mapName.Font = Enum.Font.GothamBold mapName.TextSize = 13 mapName.TextXAlignment = Enum.TextXAlignment.Center mapName.Parent = frame local status = Instance.new("TextLabel") status.Name = "StatusLabel" status.Size = UDim2.new(1, -12, 0, 12) status.Position = UDim2.new(0, 6, 0, 38) status.BackgroundTransparency = 1 status.Text = "Status: Waiting" status.TextColor3 = Color3.fromRGB(150, 150, 150) status.Font = Enum.Font.GothamMedium status.TextSize = 9 status.TextXAlignment = Enum.TextXAlignment.Center status.Parent = frame local dragging, dragStart, startPos = false, nil, nil frame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; dragStart = input.Position; startPos = frame.Position end end) UserInputService.InputChanged:Connect(function(input) if not dragging then return end if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then local d = input.Position - dragStart frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y) end end) UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end) MapPredictState.Gui = gui end local function Stop() MapPredictState.Enabled = false if MapPredictState.Thread then pcall(function() task.cancel(MapPredictState.Thread) end); MapPredictState.Thread = nil end if MapPredictState.Gui then pcall(function() MapPredictState.Gui:Destroy() end); MapPredictState.Gui = nil end end local function Start() if MapPredictState.Enabled then return end MapPredictState.Enabled = true BuildMapGui() MapPredictState.Thread = task.spawn(function() local lastDetected, lastExisted = nil, false while MapPredictState.Enabled do local map = Workspace:FindFirstChild("Map") local mapExists = map ~= nil local detected = mapExists and DetectMapName(map) or nil local gui = MapPredictState.Gui local frame = gui and gui:FindFirstChild("MainFrame") local nameLabel = frame and frame:FindFirstChild("MapName") local statusLabel = frame and frame:FindFirstChild("StatusLabel") if nameLabel and statusLabel then if lastExisted and not mapExists then nameLabel.Text = lastDetected or "Unknown" statusLabel.Text = "Status: Loading next map..." statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50) elseif mapExists then lastDetected = detected or "Unknown" nameLabel.Text = detected or "Unknown" statusLabel.Text = "Status: In-Game" statusLabel.TextColor3 = Color3.fromRGB(120, 255, 120) else nameLabel.Text = "Waiting..." statusLabel.Text = "Status: Lobby" statusLabel.TextColor3 = Color3.fromRGB(150, 150, 160) end end lastExisted = mapExists task.wait(0.5) end end) end W.NextMapPredict_Start = Start W.NextMapPredict_Stop = Stop W.NextMapPredict_SetEnabled = function(v) PAZZHUB.NextMapPredict = v and true or false if PAZZHUB.NextMapPredict then Start() else Stop() end end end --=== MANUAL & AUTO GENERATOR === do local RepairEvent = nil pcall(function() RepairEvent = ReplicatedStorage.Remotes.Generator.RepairEvent end) local REPAIR_ANIM_ID = "rbxassetid://92960319113695" local ManualThread, AutoThread = nil, nil local ManualPoint, AutoPoint = nil, nil local LastFire = 0 local RepairAnimTrack = nil local function IsKillerNearPos(pos, radius) for _, pl in ipairs(Players:GetPlayers()) do if pl ~= LocalPlayer and TeamIs(pl, "Killer") and pl.Character then local hrp = pl.Character:FindFirstChild("HumanoidRootPart") if hrp and (hrp.Position - pos).Magnitude = 100 end local function GetNearestGenPointInReach() local myChar = LocalPlayer.Character local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart") if not myRoot then return nil end local bestPt, bestDist = nil, 5.5 for _, gen in ipairs(W.GB_GetAllGenerators()) do for _, pt in ipairs(W.GB_GetPoints(gen)) do if pt and pt.Parent then local d = (myRoot.Position - pt.Position).Magnitude if d < bestDist then bestDist = d; bestPt = pt end end end end return bestPt end local function GetSafeNearestGenPoint() local myChar = LocalPlayer.Character local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart") if not myRoot then return nil end local bestPt, bestDist = nil, math.huge for _, gen in ipairs(W.GB_GetAllGenerators()) do if IsGenDone(gen) then continue end local genPivot pcall(function() genPivot = gen:GetPivot().Position end) if genPivot and IsKillerNearPos(genPivot, PAZZHUB.KillerEscapeDist) then continue end for _, pt in ipairs(W.GB_GetPoints(gen)) do if pt and pt.Parent then local d = (pt.Position - myRoot.Position).Magnitude if d < bestDist then bestDist = d; bestPt = pt end end end end return bestPt end local function StartManualThread() if ManualThread then pcall(function() task.cancel(ManualThread) end); ManualThread = nil end ManualThread = task.spawn(function() while PAZZHUB.ManualGen do local myChar = LocalPlayer.Character local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart") local hum = myChar and myChar:FindFirstChildOfClass("Humanoid") if not myRoot or not hum or hum.Health = 0.5 then pcall(function() if RepairEvent then RepairEvent:FireServer(pt, true) end end) PlayRepairAnim() LastFire = now end else if ManualPoint then StopRepair(ManualPoint); ManualPoint = nil end end task.wait(0.1) end if ManualPoint then StopRepair(ManualPoint) end ManualPoint = nil end) end local function StopManualThread() if ManualThread then pcall(function() task.cancel(ManualThread) end); ManualThread = nil end if ManualPoint then StopRepair(ManualPoint) end ManualPoint = nil end local function StartAutoThread() if AutoThread then pcall(function() task.cancel(AutoThread) end); AutoThread = nil end AutoThread = task.spawn(function() while PAZZHUB.AutoGen do local myChar = LocalPlayer.Character local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart") local hum = myChar and myChar:FindFirstChildOfClass("Humanoid") if not myRoot or not hum or hum.Health = 0.5 then pcall(function() if RepairEvent then RepairEvent:FireServer(AutoPoint, true) end end) PlayRepairAnim() LastFire = now end else local pt = GetNearestGenPointInReach() if pt then AutoPoint = pt else local safePt = GetSafeNearestGenPoint() if safePt then AutoPoint = safePt pcall(function() myRoot.CFrame = CFrame.new(safePt.Position + Vector3.new(0, 3, 0)) end) task.wait(0.2) end end end task.wait(0.1) end if AutoPoint then StopRepair(AutoPoint) end AutoPoint = nil end) end local function StopAutoThread() if AutoThread then pcall(function() task.cancel(AutoThread) end); AutoThread = nil end if AutoPoint then StopRepair(AutoPoint) end AutoPoint = nil end W.ManualGen_SetEnabled = function(v) PAZZHUB.ManualGen = v and true or false if PAZZHUB.ManualGen then StartManualThread() else StopManualThread() end end W.AutoGen_SetEnabled = function(v) PAZZHUB.AutoGen = v and true or false if PAZZHUB.AutoGen then StartAutoThread() else StopAutoThread() end end W.GenAuto_SetDistance = function(v) PAZZHUB.KillerEscapeDist = tonumber(v) or 30 end LocalPlayer.CharacterAdded:Connect(function() task.wait(1) if PAZZHUB.ManualGen then StartManualThread() end if PAZZHUB.AutoGen then StartAutoThread() end end) end --=== MOONWALK === do PAZZHUB.Moonwalk_Enabled = PAZZHUB.Moonwalk_Enabled or false local sideSpd = 0.9 local backSpd = 1.2 local interval = 0.07 local enabled = false local conn = nil local function stop() if conn then conn:Disconnect(); conn = nil end end local function start() stop() local c = LocalPlayer.Character if not c then return end local hrp = c:FindFirstChild("HumanoidRootPart") local h = c:FindFirstChildOfClass("Humanoid") if not hrp or not h then return end local lastSwitch = 0 local dir = 1 conn = RunService.RenderStepped:Connect(function() if not enabled then return end local cc = LocalPlayer.Character if not cc then return end local chrp = cc:FindFirstChild("HumanoidRootPart") local chum = cc:FindFirstChildOfClass("Humanoid") if not chrp or not chum or chum.Health = interval then dir = dir * -1 lastSwitch = now end local back = chrp.CFrame.LookVector * -backSpd local side = chrp.CFrame.RightVector * (dir * sideSpd) chum:Move(back + side, false) end) end function W.Moonwalk_Set(state) PAZZHUB.Moonwalk_Enabled = state enabled = state if state then start() else stop() end end function W.Moonwalk_SetSide(v) sideSpd = v; PAZZHUB.Moonwalk_SideSpeed = v end function W.Moonwalk_SetBack(v) backSpd = v; PAZZHUB.Moonwalk_BackSpeed = v end function W.Moonwalk_SetInterval(v) interval = v; PAZZHUB.Moonwalk_Interval = v end UserInputService.InputBegan:Connect(function(inp, gp) if gp then return end if inp.KeyCode == Enum.KeyCode.F8 then W.Moonwalk_Set(not enabled) end end) LocalPlayer.CharacterAdded:Connect(function() task.wait(2) if enabled then start() end end) end -- [PART 4i: SURVIVOR — Silent Aim TOF DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 4i: SURVIVOR — Silent Aim TOF (Twist of Fate)
--═══════════════════════════════════════════════════════════--

local ToFState = {
    Connection = nil, LaserBeam = nil, TargetGui = nil,
    InputBegan = nil, InputEnded = nil, TouchInput = nil,
    IsAiming = false, SavedUIPos = UDim2.new(0.5, -100, 0, 110),
    SCPCache = {}, SCPCacheTimer = 0
}
local ToFKeyCodes = { None=nil, Q=Enum.KeyCode.Q, E=Enum.KeyCode.E, R=Enum.KeyCode.R, T=Enum.KeyCode.T, F=Enum.KeyCode.F, G=Enum.KeyCode.G, H=Enum.KeyCode.H, J=Enum.KeyCode.J, K=Enum.KeyCode.K, L=Enum.KeyCode.L, X=Enum.KeyCode.X, Z=Enum.KeyCode.Z }

local function ToF_IsDowned(c)
    if not c then return true end
    local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return true end
    local h = c:FindFirstChildOfClass("Humanoid"); if h and h.Health<=0 then return true end
    if c:GetAttribute("Knocked")==true then return true end
    if c:GetAttribute("IsHooked")==true then return true end
    if c:GetAttribute("IsCarried")==true then return true end
    return false
end
local function ToF_IsBlocked()
    if PAZZHUB.TOF_BlockKnocked == false then return false end
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
    if ra then local g = ra:FindFirstChild("gun"); if g then return g end
        local e = ra:FindFirstChild("EmperorGun"); if e then return e end end
    return b
end
local function ToF_IsVisible(op, tp, tc)
    local d = tp - op; local dist = d.Magnitude
    if dist < 0.1 then return true end
    local rp = RaycastParams.new(); rp.FilterType = Enum.RaycastFilterType.Exclude
    local ex = {}
    local lc = LocalPlayer.Character
    if lc then table.insert(ex, lc) end
    if tc and tc ~= lc then table.insert(ex, tc) end
    if ToFState.LaserBeam then table.insert(ex, ToFState.LaserBeam) end
    rp.FilterDescendantsInstances = ex
    return workspace:Raycast(op, d.Unit * dist, rp) == nil
end
local function ToF_GetSCPs()
    if tick() - ToFState.SCPCacheTimer < 0.5 then return ToFState.SCPCache end
    local nt = {}
    local mf = workspace:FindFirstChild("Map")
    if mf then
        for _, c in pairs(mf:GetDescendants()) do
            if c:IsA("Model") then
                local a = c:GetAttributes()
                if c:GetAttribute("CorpseCreated0492") or next(a) ~= nil then
                    local r = c:FindFirstChild("HumanoidRootPart"); if r then table.insert(nt, r) end
                end
            end
        end
    end
    ToFState.SCPCache = nt; ToFState.SCPCacheTimer = tick()
    return nt
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
        pcall(function() op = g:IsA("BasePart") and g.Position or (g:FindFirstChildOfClass("BasePart") and g:FindFirstChildOfClass("BasePart").Position) end)
        op = op or Vector3.new(mp.X, mp.Y + 1.5, mp.Z)
    end
    local function predict(t, tc)
        local tp = t.Position
        if PAZZHUB.TOF_WallCheck and not ToF_IsVisible(op, tp, tc) then return nil,nil,nil,nil end
        local tv = Vector3.new(0,0,0)
        local rp = tc and (tc:FindFirstChild("HumanoidRootPart") or t)
        if rp then tv = rp.Velocity end
        local dr = tp - op; local d = dr.Magnitude
        if d < 0.1 then return nil,nil,nil,nil end
        if d < 5 then return dr.Unit, g, op, tp end
        local tt = d/400
        local pp = tp + (tv*tt)
        for _=1,2 do local nd = (pp-op).Magnitude; tt = nd/400; pp = tp + (tv*tt) end
        local fd = pp - op
        if fd.Magnitude < 0.1 then return nil,nil,nil,nil end
        return fd.Unit, g, op, pp
    end
    local mode = PAZZHUB.TOF_TargetMode or "Killer"
    if mode=="Killer" then
        local bt, bc, bs = nil, nil, math.huge
        for _,p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                local t = p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("HumanoidRootPart")
                if t then local d = (mp-t.Position).Magnitude; if d < bs then bs=d; bt=t; bc=p.Character end end
            end
        end
        if not bt then return nil,nil,nil,nil end
        return predict(bt, bc)
    elseif mode=="Survivors" then
        local bt, bc, bd = nil, nil, -math.huge
        local cam = workspace.CurrentCamera
        local cl = cam.CFrame.LookVector
        for _,p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TeamIs(p, "Survivor") and p.Character then
                local t = p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("HumanoidRootPart")
                if t then local dt = t.Position - cam.CFrame.Position
                    if dt.Magnitude>0.1 then local dot = cl:Dot(dt.Unit); if dot>0.5 and dot>bd then bd=dot; bt=t; bc=p.Character end end end
            end
        end
        if not bt then return nil,nil,nil,nil end
        return predict(bt, bc)
    elseif mode=="Zombie" then
        local bp, bd = nil, -math.huge
        local cam = workspace.CurrentCamera
        local cl = cam.CFrame.LookVector
        for _,r in ipairs(ToF_GetSCPs()) do
            if r and r.Parent then local dt = r.Position - cam.CFrame.Position
                if dt.Magnitude>0.1 then local dot = cl:Dot(dt.Unit); if dot>0.5 and dot>bd then bd=dot; bp=r end end end
        end
        if not bp then return nil,nil,nil,nil end
        return predict(bp, bp.Parent)
    end
    return nil,nil,nil,nil
end
local function ToF_UpdateLaser(op, tp)
    if not ToFState.LaserBeam then
        local l = Instance.new("Part"); l.Name="PAZZHUBToFLaser"; l.Anchored=true; l.CanCollide=false; l.CanTouch=false; l.CastShadow=false
        l.Material=Enum.Material.Neon; l.Color=Color3.fromRGB(0, 170, 255); l.Parent=workspace
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
local function ToF_GetMobileBtn()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    local sm = pg and pg:FindFirstChild("Survivor-mob")
    local ct = sm and sm:FindFirstChild("Controls")
    local gm = ct and ct:FindFirstChild("Gui-mob")
    if not gm then return nil end
    for _,n in ipairs({"attack","Attack","shoot","Shoot","fire","Fire"}) do local b = gm:FindFirstChild(n,true); if b and b:IsA("GuiObject") then return b end end
    for _,o in ipairs(gm:GetDescendants()) do if o:IsA("GuiButton") and o.Visible then return o end end
    return gm:IsA("GuiObject") and gm or nil
end
local function ToF_IsTouchShoot(input)
    local sb = ToF_GetMobileBtn()
    if not (sb and sb.Visible) then return false end
    local p = input.Position; local ap = sb.AbsolutePosition; local az = sb.AbsoluteSize
    return p.X>=ap.X and p.X<=ap.X+az.X and p.Y>=ap.Y and p.Y<=ap.Y+az.Y
end
local function ToF_Shoot()
    if not PAZZHUB.TOF_SilentAim then return end
    if ToF_IsBlocked() then return end
    local td, g, op, tp = ToF_GetTarget()
    if not (td and g and tp and op) then return end
    local e = ToF_GetEvent()
    if not e then return end
    local fd = tp - op
    if fd.Magnitude < 0.1 then return end
    pcall(function() e:FireServer(g, fd.Unit) end)
end
local ToF_ModeButtons = {}
local ToF_BgColor = Color3.fromRGB(8, 14, 26)
local ToF_HoverColor = Color3.fromRGB(16, 24, 42)
local ToF_ModeConfig = {
    Killer={Color=Color3.fromRGB(255,90,90),Label="KILLER",Hint="K"},
    Survivors={Color=Color3.fromRGB(120,200,255),Label="SURVIVOR",Hint="J"},
    Zombie={Color=Color3.fromRGB(120,255,150),Label="ZOMBIE",Hint="L"}
}
local function ToF_RefreshButtons()
    for n, b in pairs(ToF_ModeButtons) do
        if b and b.Parent then
            local isActive = n == (PAZZHUB.TOF_TargetMode or "Killer")
            local cfg = ToF_ModeConfig[n]
            local ind = b:FindFirstChild("Indicator"); local lb = b:FindFirstChild("ModeLabel"); local hn = b:FindFirstChild("HintLabel"); local st = b:FindFirstChildOfClass("UIStroke")
            if isActive then
                TweenService:Create(b, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(16, 24, 42) }):Play()
                if ind then TweenService:Create(ind, TweenInfo.new(0.25), { Size = UDim2.new(0, 3, 0.6, 0), BackgroundColor3 = cfg.Color, BackgroundTransparency = 0 }):Play() end
                if lb then TweenService:Create(lb, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play() end
                if hn then TweenService:Create(hn, TweenInfo.new(0.25), { TextColor3 = cfg.Color, TextTransparency = 0 }):Play() end
                if st then TweenService:Create(st, TweenInfo.new(0.25), { Color = Color3.fromRGB(80, 80, 92), Transparency = 0.2 }):Play() end
            else
                TweenService:Create(b, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(16, 24, 42) }):Play()
                if ind then TweenService:Create(ind, TweenInfo.new(0.25), { Size = UDim2.new(0, 3, 0, 0), BackgroundTransparency = 1 }):Play() end
                if lb then TweenService:Create(lb, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(140, 140, 152) }):Play() end
                if hn then TweenService:Create(hn, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(90, 90, 100), TextTransparency = 0.3 }):Play() end
                if st then TweenService:Create(st, TweenInfo.new(0.25), { Color = Color3.fromRGB(45, 45, 55), Transparency = 0.5 }):Play() end
            end
        end
    end
end
local function ToF_SetTargetMode(mode, notify)
    if mode ~= "Killer" and mode ~= "Survivors" and mode ~= "Zombie" then return end
    PAZZHUB.TOF_TargetMode = mode
    ToF_RefreshButtons()
    if notify then PAZZHUB_Notify("ToF Target", mode, 1) end
end
local function ToF_DestroyUI()
    if ToFState.TargetGui then pcall(function() ToFState.TargetGui:Destroy() end); ToFState.TargetGui = nil end
    ToF_ModeButtons = {}
end
local function ToF_CreateUI()
    local parent = LocalPlayer:FindFirstChild("PlayerGui")
    if gethui then local ok2, hui = pcall(gethui); if ok2 and hui then parent = hui end end
    if not parent then return end
    if ToFState.TargetGui and ToFState.TargetGui.Parent then return end
    local old = parent:FindFirstChild("PAZZHUBToFTargetSelector")
    if old then pcall(function() old:Destroy() end) end
    local gui = Instance.new("ScreenGui")
    gui.Name = "PAZZHUBToFTargetSelector"; gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = parent
    local frame = Instance.new("Frame"); frame.Name = "Main"
    frame.Size = UDim2.new(0, 200, 0, 152); frame.Position = ToFState.SavedUIPos
    frame.BackgroundColor3 = ToF_BgColor; frame.BorderSizePixel = 0; frame.Active = true
    frame.ClipsDescendants = true; frame.ZIndex = 1; frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
    frame.BackgroundTransparency = 0.85; frame.Size = UDim2.new(0, 160, 0, 122); frame.Rotation = 5
    local outerStroke = Instance.new("UIStroke", frame); outerStroke.Color = Color3.fromRGB(0, 120, 200); outerStroke.Thickness = 1; outerStroke.Transparency = 0.3; outerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local accentBar = Instance.new("Frame"); accentBar.Size = UDim2.new(1, -20, 0, 2); accentBar.Position = UDim2.new(0, 10, 0, 0); accentBar.BorderSizePixel = 0; accentBar.ZIndex = 2; accentBar.Parent = frame
    local acGrad = Instance.new("UIGradient", accentBar); acGrad.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255)) })
    Instance.new("UICorner", accentBar).CornerRadius = UDim.new(1, 0)
    local header = Instance.new("Frame"); header.Name = "Header"; header.Size = UDim2.new(1, 0, 0, 38); header.BackgroundTransparency = 1; header.ZIndex = 2; header.Parent = frame
    local ic = Instance.new("Frame"); ic.Size = UDim2.fromOffset(22, 22); ic.Position = UDim2.new(0, 12, 0.5, -11); ic.BackgroundColor3 = Color3.fromRGB(0, 170, 255); ic.BackgroundTransparency = 0.85; ic.BorderSizePixel = 0; ic.ZIndex = 3; ic.Parent = header
    Instance.new("UICorner", ic).CornerRadius = UDim.new(1, 0)
    local ics = Instance.new("UIStroke", ic); ics.Color = Color3.fromRGB(0, 170, 255); ics.Thickness = 1.4; ics.Transparency = 0.2
    local title = Instance.new("TextLabel"); title.Size = UDim2.new(1, -140, 0, 14); title.Position = UDim2.new(0, 42, 0, 8); title.BackgroundTransparency = 1; title.Font = Enum.Font.GothamBold; title.Text = "SILENT AIM"; title.TextColor3 = Color3.fromRGB(200, 230, 255); title.TextSize = 12; title.TextXAlignment = Enum.TextXAlignment.Left; title.ZIndex = 3; title.Parent = header
    local sub = Instance.new("TextLabel"); sub.Size = UDim2.new(1, -140, 0, 10); sub.Position = UDim2.new(0, 42, 0, 22); sub.BackgroundTransparency = 1; sub.Font = Enum.Font.Gotham; sub.Text = "Twist of Fate"; sub.TextColor3 = Color3.fromRGB(140, 140, 155); sub.TextSize = 9; sub.TextXAlignment = Enum.TextXAlignment.Left; sub.ZIndex = 3; sub.Parent = header
    local minBtn = Instance.new("TextButton"); minBtn.Name = "MinBtn"; minBtn.AnchorPoint = Vector2.new(1, 0.5); minBtn.Size = UDim2.fromOffset(22, 22); minBtn.Position = UDim2.new(1, -8, 0.5, 0); minBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 36); minBtn.BorderSizePixel = 0; minBtn.Text = "×"; minBtn.TextColor3 = Color3.fromRGB(200, 200, 220); minBtn.Font = Enum.Font.GothamBold; minBtn.TextSize = 14; minBtn.AutoButtonColor = false; minBtn.ZIndex = 4; minBtn.Parent = header
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)
    minBtn.MouseButton1Click:Connect(function() ToF_DestroyUI() end)
    local sep = Instance.new("Frame"); sep.Name = "Separator"; sep.Size = UDim2.new(1, -24, 0, 1); sep.Position = UDim2.new(0, 12, 0, 38); sep.BackgroundColor3 = Color3.fromRGB(45, 45, 55); sep.BorderSizePixel = 0; sep.ZIndex = 2; sep.Parent = frame
    local body = Instance.new("Frame"); body.Name = "Body"; body.Size = UDim2.new(1, -16, 1, -56); body.Position = UDim2.new(0, 8, 0, 44); body.BackgroundTransparency = 1; body.ZIndex = 2; body.Parent = frame
    local bl = Instance.new("UIListLayout", body); bl.FillDirection = Enum.FillDirection.Vertical; bl.SortOrder = Enum.SortOrder.LayoutOrder; bl.Padding = UDim.new(0, 4)
    ToF_ModeButtons = {}
    for i, m in ipairs({ {Internal="Killer",Order=1}, {Internal="Survivors",Order=2}, {Internal="Zombie",Order=3} }) do
        local cfg = ToF_ModeConfig[m.Internal]
        local btn = Instance.new("TextButton"); btn.Name = "ModeBtn_" .. m.Internal; btn.Size = UDim2.new(1, 0, 0, 26); btn.BackgroundColor3 = Color3.fromRGB(16, 24, 42); btn.BorderSizePixel = 0; btn.Text = ""; btn.AutoButtonColor = false; btn.LayoutOrder = m.Order; btn.ZIndex = 3; btn.Parent = body
        btn.Position = UDim2.new(-0.6, 0, 0, 0); btn.BackgroundTransparency = 0.6
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        local bs = Instance.new("UIStroke", btn); bs.Color = Color3.fromRGB(45, 45, 55); bs.Thickness = 1; bs.Transparency = 0.5
        local ind = Instance.new("Frame"); ind.Name = "Indicator"; ind.AnchorPoint = Vector2.new(0, 0.5); ind.Size = UDim2.new(0, 3, 0, 0); ind.Position = UDim2.new(0, 6, 0.5, 0); ind.BackgroundColor3 = cfg.Color; ind.BackgroundTransparency = 1; ind.BorderSizePixel = 0; ind.ZIndex = 4; ind.Parent = btn
        Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
        local cd = Instance.new("Frame"); cd.Size = UDim2.fromOffset(6, 6); cd.Position = UDim2.new(0, 14, 0.5, -3); cd.BackgroundColor3 = cfg.Color; cd.BorderSizePixel = 0; cd.ZIndex = 4; cd.Parent = btn
        Instance.new("UICorner", cd).CornerRadius = UDim.new(1, 0)
        local lb = Instance.new("TextLabel"); lb.Name = "ModeLabel"; lb.Size = UDim2.new(1, -60, 1, 0); lb.Position = UDim2.new(0, 26, 0, 0); lb.BackgroundTransparency = 1; lb.Font = Enum.Font.GothamBold; lb.Text = cfg.Label; lb.TextColor3 = Color3.fromRGB(140, 140, 152); lb.TextSize = 11; lb.TextXAlignment = Enum.TextXAlignment.Left; lb.ZIndex = 4; lb.Parent = btn
        local hn = Instance.new("TextLabel"); hn.Name = "HintLabel"; hn.AnchorPoint = Vector2.new(1, 0.5); hn.Size = UDim2.fromOffset(20, 18); hn.Position = UDim2.new(1, -8, 0.5, 0); hn.BackgroundColor3 = Color3.fromRGB(32, 32, 40); hn.BorderSizePixel = 0; hn.Font = Enum.Font.GothamBold; hn.Text = cfg.Hint; hn.TextColor3 = Color3.fromRGB(90, 90, 100); hn.TextSize = 9; hn.TextTransparency = 0.3; hn.ZIndex = 4; hn.Parent = btn
        Instance.new("UICorner", hn).CornerRadius = UDim.new(0, 4)
        btn.MouseEnter:Connect(function() if PAZZHUB.TOF_TargetMode ~= m.Internal then TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = ToF_HoverColor }):Play() end end)
        btn.MouseLeave:Connect(function() if PAZZHUB.TOF_TargetMode ~= m.Internal then TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(16, 24, 42) }):Play() end end)
        btn.MouseButton1Click:Connect(function() ToF_SetTargetMode(m.Internal, false) end)
        btn.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.Touch then ToF_SetTargetMode(m.Internal, false) end end)
        ToF_ModeButtons[m.Internal] = btn
    end
    ToF_RefreshButtons()
    task.spawn(function()
        task.wait(0.05)
        local eO = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        TweenService:Create(frame, eO, { Size = UDim2.new(0, 200, 0, 152), BackgroundTransparency = 0, Rotation = 0 }):Play()
        task.wait(0.08)
        for i, btn in ipairs(body:GetChildren()) do
            if btn:IsA("TextButton") then
                task.delay(i * 0.06, function()
                    TweenService:Create(btn, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0 }):Play()
                end)
            end
        end
    end)
    local drg = false; local ds, sps2
    header.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then ds = inp.Position; sps2 = frame.Position; drg = true end end)
    header.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then drg = false end end)
    UserInputService.InputChanged:Connect(function(inp)
        if not drg then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local d = inp.Position - ds
            local np = UDim2.new(sps2.X.Scale, sps2.X.Offset + d.X, sps2.Y.Scale, sps2.Y.Offset + d.Y)
            frame.Position = np; ToFState.SavedUIPos = np
        end
    end)
    ToFState.TargetGui = gui
end
local function ToF_StartConn()
    if ToFState.Connection then return end
    ToFState.Connection = RunService.Heartbeat:Connect(function()
        if ToF_IsBlocked() then ToFState.IsAiming = false; if ToFState.TouchInput then ToFState.TouchInput = nil end; if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end; return end
        if not PAZZHUB.TOF_SilentAim or not ToFState.IsAiming then if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end; return end
        local _, _, op, tp = ToF_GetTarget()
        if op and tp then
            pcall(function()
                local c = LocalPlayer.Character
                local hrp = c and c:FindFirstChild("HumanoidRootPart")
                if hrp and not c:GetAttribute("IsCarried") then hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(tp.X, hrp.Position.Y, tp.Z)) end
            end)
            if PAZZHUB.TOF_Laser then ToF_UpdateLaser(op, tp)
            elseif ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
        elseif ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
    end)
end
local function ToF_StopConn()
    if ToFState.Connection then pcall(function() ToFState.Connection:Disconnect() end); ToFState.Connection = nil end
    ToFState.IsAiming = false; ToF_ClearLaser()
end
local SetToFSilentAim
local function ToF_EnsureInputs()
    if not ToFState.InputBegan then
        ToFState.InputBegan = UserInputService.InputBegan:Connect(function(inp, gp)
            if gp then return end
            local k = ToFKeyCodes[PAZZHUB.TOF_Key or "None"]
            if k and inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == k then SetToFSilentAim(not PAZZHUB.TOF_SilentAim); return end
            if not PAZZHUB.TOF_SilentAim then return end
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or (inp.UserInputType == Enum.UserInputType.Touch and ToF_IsTouchShoot(inp)) then
                if ToF_IsBlocked() then ToFState.IsAiming = false; return end
                ToFState.IsAiming = true
                if inp.UserInputType == Enum.UserInputType.Touch then ToFState.TouchInput = inp end
                return
            end
            if inp.UserInputType == Enum.UserInputType.Keyboard then
                if inp.KeyCode == Enum.KeyCode.K then ToF_SetTargetMode("Killer", true)
                elseif inp.KeyCode == Enum.KeyCode.J then ToF_SetTargetMode("Survivors", true)
                elseif inp.KeyCode == Enum.KeyCode.L then ToF_SetTargetMode("Zombie", true) end
            end
        end)
    end
    if not ToFState.InputEnded then
        ToFState.InputEnded = UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or (inp.UserInputType == Enum.UserInputType.Touch and inp == ToFState.TouchInput) then
                local wa = ToFState.IsAiming
                ToFState.IsAiming = false
                if inp == ToFState.TouchInput then ToFState.TouchInput = nil end
                if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
                if wa then if ToF_IsBlocked() then return end; ToF_Shoot() end
            end
        end)
    end
end
SetToFSilentAim = function(en)
    PAZZHUB.TOF_SilentAim = en and true or false
    ToF_EnsureInputs()
    if PAZZHUB.TOF_SilentAim then ToF_CreateUI(); ToF_StartConn()
    else ToF_DestroyUI(); ToF_StopConn() end
end
W.SetToFSilentAim = SetToFSilentAim
W.ToF_ClearLaser = ToF_ClearLaser
W.ToF_SetTargetMode = ToF_SetTargetMode
ToF_EnsureInputs()

-- [PART 4j: SURVIVOR — Silent Flashlight + Aim Lock Gun DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 4j: SURVIVOR — Silent Flashlight + Aim Lock Gun
--═══════════════════════════════════════════════════════════--

--=== SILENT FLASHLIGHT ===
do
    PAZZHUB.FLASH_SilentAim  = PAZZHUB.FLASH_SilentAim  or false
    PAZZHUB.FLASH_Laser      = PAZZHUB.FLASH_Laser      ~= false
    PAZZHUB.FLASH_TargetPart = PAZZHUB.FLASH_TargetPart or "Head"
    PAZZHUB.FLASH_Range      = PAZZHUB.FLASH_Range      or 120
    PAZZHUB.FLASH_Smooth     = PAZZHUB.FLASH_Smooth     or 0.35
    local FlashState = { Active = false, LaserBeam = nil, FlashlightPart = nil, Connection = nil, Hooked = false }
    local function Flash_GetActivateRemote()
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local i = r and r:FindFirstChild("Items")
        local f = i and i:FindFirstChild("Flashlight")
        local a = f and f:FindFirstChild("Activate")
        if a and a:IsA("RemoteEvent") then return a end
        return nil
    end
    local function Flash_GetTargetPart(char)
        if not char then return nil end
        local p = char:FindFirstChild(PAZZHUB.FLASH_TargetPart or "Head")
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
        local maxR = tonumber(PAZZHUB.FLASH_Range) or 120
        local best, bd = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and Flash_IsAliveChar(p.Character) and TeamIs(p, "Killer") then
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
    local function Flash_GetOrigin(cam)
        local src = FlashState.FlashlightPart
        if typeof and typeof(src) == "Instance" then
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
            l.Name = "PAZZHUBFlashlightLaser"
            l.Anchored = true
            l.CanCollide = false
            l.CanTouch = false
            l.CanQuery = false
            l.CastShadow = false
            l.Material = Enum.Material.Neon
            l.Color = Color3.fromRGB(0, 170, 255)
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
        if not (PAZZHUB.FLASH_SilentAim and FlashState.Active) then
            if FlashState.LaserBeam then FlashState.LaserBeam.Transparency = 1 end
            return
        end
        local cam = Workspace.CurrentCamera
        local tp = Flash_GetTarget()
        if not (cam and tp) then
            if FlashState.LaserBeam then FlashState.LaserBeam.Transparency = 1 end
            return
        end
        local smooth = math.clamp(tonumber(PAZZHUB.FLASH_Smooth) or 0.35, 0.05, 1)
        local op = Flash_GetOrigin(cam)
        if PAZZHUB.FLASH_Laser and op then
            pcall(Flash_UpdateLaser, op, tp.Position)
        elseif FlashState.LaserBeam then
            FlashState.LaserBeam.Transparency = 1
        end
        pcall(function() cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, tp.Position), smooth) end)
        pcall(function()
            local c = LocalPlayer.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(tp.Position.X, hrp.Position.Y, tp.Position.Z)) end
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
        PAZZHUB.FLASH_SilentAim = v and true or false
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
    W.Flash_ClearLaser = Flash_ClearLaser
    task.spawn(function()
        pcall(function()
            local remote = Flash_GetActivateRemote()
            if not remote then return end
            if typeof(hookmetamethod) ~= "function" then return end
            if FlashState.Hooked then return end
            FlashState.Hooked = true
            local oldNC
            oldNC = hookmetamethod(game, "__namecall", function(self, ...)
                if getnamecallmethod() == "FireServer" and self == remote then
                    local args = {...}
                    pcall(function() W.Flash_SetActive(args[2] == true, args[1]) end)
                end
                return oldNC(self, ...)
            end)
        end)
    end)
end

--=== AIM LOCK GUN ===
do
    local GunAim = {
        Enabled = false, Holding = false, TargetMode = "Killer",
        Strength = 1, Predict = true, PredictStrength = 0.12,
        FOV = 250, VisibilityCheck = true,
        AimPart = "HumanoidRootPart", Target = nil,
    }
    local GunAimConnection = nil
    local CurrentGunButton = nil

    local function GA_IsVisible(part)
        local cam = Workspace.CurrentCamera
        if not cam then return true end
        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = { LocalPlayer.Character }
        local origin = cam.CFrame.Position
        local dir = part.Position - origin
        local result = Workspace:Raycast(origin, dir, rp)
        if not result then return true end
        return result.Instance:IsDescendantOf(part.Parent)
    end

    local function GA_GetButton()
        local current = LocalPlayer:FindFirstChild("PlayerGui")
        for seg in string.gmatch("Survivor-mob.Controls.Gui-mob", "[^%.]+") do
            current = current and current:FindFirstChild(seg)
        end
        return current
    end

    local function GA_GetClosestTarget()
        local cam = Workspace.CurrentCamera
        if not cam then return nil end
        local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
        local closest, shortest = nil, GunAim.FOV
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Team then
                local valid = false
                if GunAim.TargetMode == "Killer" and string.find(string.lower(p.Team.Name), "killer", 1, true) then valid = true
                elseif GunAim.TargetMode == "Survivor" and string.find(string.lower(p.Team.Name), "survivor", 1, true) then valid = true end
                if valid then
                    local hrp = p.Character:FindFirstChild(GunAim.AimPart)
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health > 0 then
                        local pos, visible = cam:WorldToViewportPoint(hrp.Position)
                        if visible then
                            local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                            if dist < shortest then
                                if GunAim.VisibilityCheck and not GA_IsVisible(hrp) then continue end
                                shortest = dist; closest = hrp
                            end
                        end
                    end
                end
            end
        end
        return closest
    end

    local function GA_Start()
        if GunAimConnection then return end
        GunAimConnection = RunService.RenderStepped:Connect(function()
            if not GunAim.Enabled or not GunAim.Holding then
                GunAim.Target = nil; return
            end
            local target = GA_GetClosestTarget()
            if not target then return end
            GunAim.Target = target
            local pos = target.Position
            if GunAim.Predict then
                pos = pos + (target.AssemblyLinearVelocity * GunAim.PredictStrength)
            end
            local cam = Workspace.CurrentCamera
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, pos), GunAim.Strength)
        end)
    end

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType == Enum.UserInputType.MouseButton2 and GunAim.Enabled then
            GunAim.Holding = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            GunAim.Holding = false
        end
    end)

    task.spawn(function()
        while true do
            task.wait(1)
            local btn = GA_GetButton()
            if btn and btn ~= CurrentGunButton then
                CurrentGunButton = btn
                btn.InputBegan:Connect(function(input)
                    if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton2) and GunAim.Enabled then
                        GunAim.Holding = true
                    end
                end)
                btn.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton2 then
                        GunAim.Holding = false
                    end
                end)
            end
        end
    end)

    W.GunAim_Start = GA_Start
    W.GunAim_Cfg = GunAim
end

-- [PART 5a: VISUALS — Full ESP (Cache + Status) DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════-- -- PART 5a: VISUALS — Full ESP (Cache + Status) --═══════════════════════════════════════════════════════════-- W.FullESP = W.FullESP or { Survivor = false, Killer = false, Generator = false, Pallet = false, Window = false, SCP = false, Distance = 500, } W.FullESPStatus = W.FullESPStatus or { Enabled = false, ShowName = true, ShowDistance = true, ShowHealth = false, ShowAvatar = true, ShowAction = true, Radius = 500, } W.FullESPColors = W.FullESPColors or { Survivor = Color3.fromRGB(0, 170, 255), Killer = Color3.fromRGB(255, 60, 60), Generator = Color3.fromRGB(255, 255, 0), Window = Color3.fromRGB(255, 255, 255), Pallet = Color3.fromRGB(255, 165, 0), SCP = Color3.fromRGB(0, 255, 0), } local FESP = W.FullESP local FESPS = W.FullESPStatus local FESPC = W.FullESPColors do local ESPObjects = {} local StatusESP = {} local CachedSCP = {} local CachedGen = {} local CachedPallet = {} local WindowObjects = {} local function CacheObject(obj) if not obj then return end local ln = string.lower(obj.Name) if string.find(ln, "scp", 1, true) then CachedSCP[obj] = true end if obj.Name == "Generator" then CachedGen[obj] = true elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then CachedPallet[obj] = true end end for _, obj in ipairs(Workspace:GetDescendants()) do CacheObject(obj) end Workspace.DescendantAdded:Connect(CacheObject) Workspace.DescendantRemoving:Connect(function(obj) CachedSCP[obj] = nil; CachedGen[obj] = nil CachedPallet[obj] = nil if ESPObjects[obj] then pcall(function() ESPObjects[obj]:Destroy() end); ESPObjects[obj] = nil end if StatusESP[obj] then pcall(function() StatusESP[obj]:Destroy() end); StatusESP[obj] = nil end end) local function RemoveESP(obj) if not obj then return end if ESPObjects[obj] then pcall(function() ESPObjects[obj]:Destroy() end) ESPObjects[obj] = nil end end local function CreateESP(obj, color) if not obj or not obj.Parent then return end if ESPObjects[obj] then ESPObjects[obj].FillColor = color ESPObjects[obj].OutlineColor = color return end local h = Instance.new("Highlight") h.FillColor = color h.OutlineColor = color h.FillTransparency = 0.9 h.OutlineTransparency = 0.3 h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop h.Parent = obj ESPObjects[obj] = h obj.AncestryChanged:Connect(function(_, parent) if not parent then RemoveESP(obj) end end) end local function RemoveStatusESP(char) if StatusESP[char] then pcall(function() StatusESP[char]:Destroy() end) StatusESP[char] = nil end end local function StatusESP_GetAction(char, hum) if not char or not hum then return "IDLE", Color3.fromRGB(150, 150, 150) end if hum.Health 20 then return "SPRINT", Color3.fromRGB(120, 255, 200) end if speed > 2 then return "MOVE", Color3.fromRGB(200, 200, 220) end end return "IDLE", Color3.fromRGB(150, 150, 150) end local function CreateStatusESP(plr, char, root) if not FESPS.Enabled then RemoveStatusESP(char); return end if not root then return end local head = char:FindFirstChild("Head") local hum = char:FindFirstChildOfClass("Humanoid") if not head or not hum then return end local isDown = hum.Health FESPS.Radius then RemoveStatusESP(char); return end local accentColor = Color3.fromRGB(255, 255, 255) if TeamIs(plr, "Killer") then accentColor = FESPC.Killer elseif TeamIs(plr, "Survivor") then accentColor = FESPC.Survivor end if isDown then accentColor = Color3.fromRGB(255, 60, 60) end local hpPct = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1) local hpColor if hpPct > 0.6 then hpColor = Color3.fromRGB(80, 220, 120) elseif hpPct > 0.3 then hpColor = Color3.fromRGB(255, 200, 60) else hpColor = Color3.fromRGB(255, 80, 80) end local actionText, actionColor = StatusESP_GetAction(char, hum) local bb = StatusESP[char] if not bb or not bb.Parent then bb = Instance.new("BillboardGui") bb.Name = "PAZZHUBStatusESP" bb.AlwaysOnTop = true bb.LightInfluence = 0 bb.Adornee = head bb.StudsOffset = Vector3.new(0, 2.5, 0) bb.Size = UDim2.fromOffset(260, 40) bb.Parent = char local scaleObj = Instance.new("UIScale") scaleObj.Name = "DistScale" scaleObj.Scale = 1 scaleObj.Parent = bb local nameLbl = Instance.new("TextLabel") nameLbl.Name = "NameLbl" nameLbl.BackgroundTransparency = 1 nameLbl.Size = UDim2.new(1, 0, 0, 16) nameLbl.Position = UDim2.new(0, 0, 0, 0) nameLbl.Font = Enum.Font.GothamBold nameLbl.TextSize = 13 nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255) nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) nameLbl.TextStrokeTransparency = 0.2 nameLbl.TextXAlignment = Enum.TextXAlignment.Center nameLbl.TextYAlignment = Enum.TextYAlignment.Center nameLbl.TextTruncate = Enum.TextTruncate.AtEnd nameLbl.Parent = bb local pill = Instance.new("Frame") pill.Name = "Pill" pill.AnchorPoint = Vector2.new(0.5, 0) pill.Position = UDim2.new(0.5, 0, 0, 18) pill.Size = UDim2.fromOffset(120, 22) pill.BackgroundColor3 = Color3.fromRGB(8, 14, 26) pill.BackgroundTransparency = 0.15 pill.BorderSizePixel = 0 pill.Parent = bb Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0) local pillStroke = Instance.new("UIStroke", pill) pillStroke.Name = "PillStroke" pillStroke.Color = accentColor pillStroke.Thickness = 1 pillStroke.Transparency = 0.5 pillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border local layout = Instance.new("UIListLayout", pill) layout.FillDirection = Enum.FillDirection.Horizontal layout.Padding = UDim.new(0, 5) layout.SortOrder = Enum.SortOrder.LayoutOrder layout.VerticalAlignment = Enum.VerticalAlignment.Center layout.HorizontalAlignment = Enum.HorizontalAlignment.Center local pad = Instance.new("UIPadding", pill) pad.PaddingLeft = UDim.new(0, 6) pad.PaddingRight = UDim.new(0, 8) local avatarHolder = Instance.new("Frame") avatarHolder.Name = "AvatarHolder" avatarHolder.Size = UDim2.fromOffset(18, 18) avatarHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 36) avatarHolder.BorderSizePixel = 0 avatarHolder.LayoutOrder = 1 avatarHolder.ClipsDescendants = true avatarHolder.Parent = pill Instance.new("UICorner", avatarHolder).CornerRadius = UDim.new(1, 0) local avatarStroke = Instance.new("UIStroke", avatarHolder) avatarStroke.Name = "AvatarStroke" avatarStroke.Color = accentColor avatarStroke.Thickness = 1.2 avatarStroke.Transparency = 0.3 avatarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border local avatarImg = Instance.new("ImageLabel") avatarImg.Name = "AvatarImg" avatarImg.Size = UDim2.fromScale(1, 1) avatarImg.BackgroundTransparency = 1 avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=150&h=150" avatarImg.Parent = avatarHolder local dot = Instance.new("Frame") dot.Name = "Dot" dot.Size = UDim2.fromOffset(7, 7) dot.BackgroundColor3 = accentColor dot.BorderSizePixel = 0 dot.LayoutOrder = 1 dot.Visible = false dot.Parent = pill Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0) local distLbl = Instance.new("TextLabel") distLbl.Name = "DistLbl" distLbl.BackgroundTransparency = 1 distLbl.Size = UDim2.fromOffset(32, 14) distLbl.Font = Enum.Font.GothamBold distLbl.TextSize = 11 distLbl.TextColor3 = Color3.fromRGB(220, 220, 230) distLbl.Text = "0m" distLbl.LayoutOrder = 2 distLbl.Parent = pill local actionLbl = Instance.new("TextLabel") actionLbl.Name = "ActionLbl" actionLbl.BackgroundTransparency = 1 actionLbl.Size = UDim2.fromOffset(50, 14) actionLbl.Font = Enum.Font.GothamBold actionLbl.TextSize = 10 actionLbl.TextColor3 = actionColor actionLbl.Text = "IDLE" actionLbl.LayoutOrder = 3 actionLbl.Parent = pill local hpBarBg = Instance.new("Frame") hpBarBg.Name = "HPBarBg" hpBarBg.Size = UDim2.fromOffset(38, 4) hpBarBg.BackgroundColor3 = Color3.fromRGB(45, 45, 55) hpBarBg.BorderSizePixel = 0 hpBarBg.LayoutOrder = 4 hpBarBg.Parent = pill Instance.new("UICorner", hpBarBg).CornerRadius = UDim.new(1, 0) local hpBarFill = Instance.new("Frame") hpBarFill.Name = "HPBarFill" hpBarFill.Size = UDim2.new(1, 0, 1, 0) hpBarFill.BackgroundColor3 = hpColor hpBarFill.BorderSizePixel = 0 hpBarFill.Parent = hpBarBg Instance.new("UICorner", hpBarFill).CornerRadius = UDim.new(1, 0) local downPill = Instance.new("Frame") downPill.Name = "DownPill" downPill.Size = UDim2.fromOffset(36, 14) downPill.BackgroundColor3 = Color3.fromRGB(255, 60, 60) downPill.BackgroundTransparency = 0.1 downPill.BorderSizePixel = 0 downPill.Visible = false downPill.LayoutOrder = 5 downPill.Parent = pill Instance.new("UICorner", downPill).CornerRadius = UDim.new(1, 0) local downLbl = Instance.new("TextLabel") downLbl.Name = "DownLbl" downLbl.Size = UDim2.new(1, 0, 1, 0) downLbl.BackgroundTransparency = 1 downLbl.Font = Enum.Font.GothamBold downLbl.TextSize = 9 downLbl.TextColor3 = Color3.fromRGB(255, 255, 255) downLbl.Text = "DOWN" downLbl.Parent = downPill StatusESP[char] = bb end local nameLbl = bb:FindFirstChild("NameLbl") local pill = bb:FindFirstChild("Pill") if not pill then return end local pillStroke = pill:FindFirstChild("PillStroke") local avatarHolder = pill:FindFirstChild("AvatarHolder") local avatarImg = avatarHolder and avatarHolder:FindFirstChild("AvatarImg") local avatarStroke = avatarHolder and avatarHolder:FindFirstChild("AvatarStroke") local dot = pill:FindFirstChild("Dot") local distLbl = pill:FindFirstChild("DistLbl") local actionLbl = pill:FindFirstChild("ActionLbl") local hpBarBg = pill:FindFirstChild("HPBarBg") local hpBarFill = hpBarBg and hpBarBg:FindFirstChild("HPBarFill") local downPill = pill:FindFirstChild("DownPill") local distScale = bb:FindFirstChild("DistScale") if pillStroke then pillStroke.Color = accentColor pillStroke.Transparency = isDown and 0.2 or 0.5 end if avatarHolder then avatarHolder.Visible = FESPS.ShowAvatar == true if avatarStroke then avatarStroke.Color = accentColor end if avatarImg and avatarImg.Image == "" then avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=150&h=150" end end if dot then dot.Visible = (FESPS.ShowAvatar ~= true) dot.BackgroundColor3 = accentColor end if nameLbl then nameLbl.Text = plr.Name nameLbl.Visible = FESPS.ShowName nameLbl.TextColor3 = isDown and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(255, 255, 255) end if distLbl then distLbl.Text = string.format("%.0fm", dist) distLbl.Visible = FESPS.ShowDistance end if actionLbl then actionLbl.Text = actionText actionLbl.TextColor3 = actionColor actionLbl.Visible = FESPS.ShowAction == true if actionText == "IDLE" then actionLbl.TextColor3 = Color3.fromRGB(150, 150, 150) end end if hpBarBg and hpBarFill then hpBarFill.Size = UDim2.new(hpPct, 0, 1, 0) hpBarFill.BackgroundColor3 = hpColor hpBarBg.Visible = FESPS.ShowHealth end if downPill then downPill.Visible = isDown end local totalW = 14 local count = 0 if FESPS.ShowAvatar then totalW = totalW + 18; count = count + 1 else totalW = totalW + 7; count = count + 1 end if FESPS.ShowDistance then totalW = totalW + 32; count = count + 1 end if FESPS.ShowAction then totalW = totalW + 50; count = count + 1 end if FESPS.ShowHealth then totalW = totalW + 38; count = count + 1 end if isDown then totalW = totalW + 36; count = count + 1 end totalW = totalW + math.max(count - 1, 0) * 5 if totalW < 50 then totalW = 50 end if totalW > 240 then totalW = 240 end pill.Size = UDim2.fromOffset(totalW, 22) local showPill = FESPS.ShowDistance or FESPS.ShowHealth or isDown or FESPS.ShowAction or FESPS.ShowAvatar pill.Visible = showPill local h = 16 + (showPill and 24 or 0) bb.Size = UDim2.fromOffset(260, h) if distScale then local scaleVal = 1 - (dist - 50) / 500 scaleVal = math.clamp(scaleVal, 0.5, 1.05) distScale.Scale = scaleVal end end --=== Simpan ke W buat PART 5b === W._ESP_Cache = { ESPObjects = ESPObjects, StatusESP = StatusESP, CachedSCP = CachedSCP, CachedGen = CachedGen, CachedPallet = CachedPallet, WindowObjects = WindowObjects, CacheObject = CacheObject, RemoveESP = RemoveESP, CreateESP = CreateESP, RemoveStatusESP = RemoveStatusESP, CreateStatusESP = CreateStatusESP, StatusESP_GetAction = StatusESP_GetAction, } --=== Generator ESP + Map ESP (helper) === local function GetGameValue(obj, name) if not obj then return nil end local attr = obj:GetAttribute(name) if attr ~= nil then return attr end local child = obj:FindFirstChild(name) if child then local ok, v = pcall(function() return child.Value end) if ok then return v end end return nil end local function UpdateGenerator(gen) if not gen or not gen.Parent then return end if not FESP.Generator then local o = gen:FindFirstChild("GenESP"); if o then o:Destroy() end local h = gen:FindFirstChild("GenHighlight"); if h then h:Destroy() end return end local percent = GetGameValue(gen, "RepairProgress") or GetGameValue(gen, "Progress") or GetGameValue(gen, "ProgressRepair") or 0 local bb = gen:FindFirstChild("GenESP") if percent >= 100 then if bb then bb:Destroy() end; return end local cp = math.clamp(percent, 0, 100) local color = FESPC.Generator:Lerp(Color3.fromRGB(0, 255, 120), cp / 100) local text = string.format("[%.0f%%]", percent) if not bb then bb = Instance.new("BillboardGui") bb.Name = "GenESP" bb.Size = UDim2.new(0, 100, 0, 30) bb.AlwaysOnTop = true local lbl = Instance.new("TextLabel") lbl.Size = UDim2.new(1, 0, 1, 0) lbl.BackgroundTransparency = 1 lbl.Text = text lbl.TextColor3 = color lbl.TextStrokeTransparency = 0 lbl.Font = Enum.Font.GothamBold lbl.TextSize = 12 lbl.Parent = bb bb.Adornee = gen bb.Parent = gen else local lbl = bb:FindFirstChildOfClass("TextLabel") if lbl then lbl.Text = text; lbl.TextColor3 = color end end local h = gen:FindFirstChild("GenHighlight") or Instance.new("Highlight") h.Name = "GenHighlight" h.Adornee = gen h.FillColor = color h.OutlineColor = color h.FillTransparency = 0.9 h.OutlineTransparency = 0.3 h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop h.Parent = gen end local function UpdateMapESP(obj, root) if not obj or not root or not obj.Parent then return end local pos if obj:IsA("Model") then if obj.PrimaryPart then pos = obj.PrimaryPart.Position else local ok, pivot = pcall(function() return obj:GetPivot().Position end) pos = ok and pivot or nil if not pos then local bp = obj:FindFirstChildWhichIsA("BasePart", true) if bp then pos = bp.Position end end end elseif obj:IsA("BasePart") then pos = obj.Position end if not pos then return end local dist = (pos - root.Position).Magnitude if obj.Name == "Pallet" or obj.Name == "Palletwrong" then if FESP.Pallet and dist --═══════════════════════════════════════════════════════════--
-- PART 5b: VISUALS — Full ESP (Window + RenderStepped Loop)
--═══════════════════════════════════════════════════════════--

do
    local cache = W._ESP_Cache
    local FESP = W.FullESP
    local FESPS = W.FullESPStatus
    local FESPC = W.FullESPColors

    local ESPObjects = cache.ESPObjects
    local StatusESP = cache.StatusESP
    local CachedSCP = cache.CachedSCP
    local CachedGen = cache.CachedGen
    local CachedPallet = cache.CachedPallet
    local WindowObjects = cache.WindowObjects
    local RemoveESP = cache.RemoveESP
    local CreateESP = cache.CreateESP
    local RemoveStatusESP = cache.RemoveStatusESP
    local CreateStatusESP = cache.CreateStatusESP
    local UpdateGenerator = W._ESP_UpdateGenerator
    local UpdateMapESP = W._ESP_UpdateMapESP
    local UpdateSCPEsp = W._ESP_UpdateSCP

    --=== WINDOW ESP (VaultTrigger → Box + Highlight) ===
    local function RemoveWindowESP(model)
        if not model then return end
        local wData = WindowObjects[model]
        if wData then
            if wData.highlight then pcall(function() wData.highlight:Destroy() end) end
            if wData.box then pcall(function() wData.box:Destroy() end) end
            if wData.bottomPart and wData.bottomPart.Parent then
                pcall(function()
                    local orig = wData.bottomPart:GetAttribute("ESP_OrigTrans")
                    if orig ~= nil then
                        wData.bottomPart.Transparency = orig
                        wData.bottomPart:SetAttribute("ESP_OrigTrans", nil)
                    end
                end)
            end
            WindowObjects[model] = nil
        end
    end

    local function HandleWindowObject(child)
        if not FESP.Window then return end
        if not child or child.Name ~= "VaultTrigger" then return end
        local winModel = child.Parent
        if not winModel or not winModel:IsA("Model") then return end
        if WindowObjects[winModel] then return end

        local bottomPart = winModel:FindFirstChild("Bottom")
        if not bottomPart or not bottomPart:IsA("BasePart") then
            local bestSize = 0
            for _, p in ipairs(winModel:GetChildren()) do
                if p:IsA("BasePart")
                   and p.Name ~= "VaultTrigger"
                   and p.Name ~= "inviswall"
                   and p.Size.Magnitude > bestSize then
                    bestSize = p.Size.Magnitude
                    bottomPart = p
                end
            end
        end
        if not bottomPart then return end

        if bottomPart:GetAttribute("ESP_OrigTrans") == nil then
            bottomPart:SetAttribute("ESP_OrigTrans", bottomPart.Transparency)
        end
        if bottomPart.Transparency > 0.5 then
            bottomPart.Transparency = 0.5
        end

        local box = Instance.new("BoxHandleAdornment")
        box.Name = "PAZZHUBWindowBox"
        box.Adornee = bottomPart
        box.Size = bottomPart.Size
        box.Color3 = FESPC.Window
        box.Transparency = 0.3
        box.AlwaysOnTop = true
        box.ZIndex = 5
        box.Parent = bottomPart

        local hl = Instance.new("Highlight")
        hl.Name = "PAZZHUBWindowHighlight"
        hl.Adornee = winModel
        hl.FillColor = FESPC.Window
        hl.FillTransparency = 0.9
        hl.OutlineColor = FESPC.Window
        hl.OutlineTransparency = 0.1
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = winModel

        WindowObjects[winModel] = {
            highlight = hl,
            box = box,
            bottomPart = bottomPart,
        }
    end

    local function ScanAllWindows()
        if not FESP.Window then return end
        local map = Workspace:FindFirstChild("Map")
        if not map then return end
        for _, obj in ipairs(map:GetDescendants()) do
            if obj.Name == "VaultTrigger" then
                HandleWindowObject(obj)
            end
        end
    end

    Workspace.DescendantAdded:Connect(function(obj)
        if obj.Name == "VaultTrigger" and FESP.Window then
            task.defer(function() HandleWindowObject(obj) end)
        end
    end)

    --=== LOOP UTAMA ESP (RenderStepped) ===
    local espLastUpdate = 0
    RunService.RenderStepped:Connect(function()
        local now = tick()
        if now - espLastUpdate < 0.05 then return end
        espLastUpdate = now

        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        -- Player ESP (Survivor + Killer + Status)
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

        -- Generator ESP
        if FESP.Generator then
            for gen in pairs(CachedGen) do UpdateGenerator(gen) end
        end

        -- Pallet ESP
        for obj in pairs(CachedPallet) do UpdateMapESP(obj, root) end

        -- SCP ESP
        UpdateSCPEsp(root)

        -- Window ESP
        if FESP.Window then
            if not _G.PAZZHUBWindowScanned then
                _G.PAZZHUBWindowScanned = true
                pcall(ScanAllWindows)
            end
        else
            _G.PAZZHUBWindowScanned = false
            for model in pairs(WindowObjects) do
                RemoveWindowESP(model)
            end
        end
    end)
end

-- [PART 5c: VISUALS — Graphics + Clock + Zoom + POV + Camera DBD DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 5c: VISUALS — Graphics + Clock + Zoom + POV + Camera DBD
--═══════════════════════════════════════════════════════════--

--=== GRAPHICS SYSTEM ===
W.Graphics = W.Graphics or {
    Fullbright = false, NoShadow = false, LowGraphics = false,
    NoScreenEffects = false, CleanSky = false,
    ClockTimeEnabled = false, ClockTime = 14, Brightness = 2,
    UnlimitedZoom = false, MaxZoomDistance = 1000,
    FOVEnabled = false, FOV = 70, PotatoEnabled = false,
}
local G = W.Graphics
local orig = {
    Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
    Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
    GlobalShadows = Lighting.GlobalShadows,
    FOV = Workspace.CurrentCamera and Workspace.CurrentCamera.FieldOfView or 70,
}
local lastState = { FB = nil, NS = nil, Amb = nil, Bright = nil, Clock = nil }
local lastOpt = { LG = nil, CS = nil }
local disabledEffects = {}
local effectTypes = { "ColorCorrectionEffect", "DepthOfFieldEffect", "BlurEffect", "SunRaysEffect", "BloomEffect" }

local function applyGraphics(force)
    if force or lastState.FB ~= G.Fullbright then
        lastState.FB = G.Fullbright
        if G.Fullbright then
            Lighting.Brightness = 2; Lighting.ClockTime = 14
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        else
            Lighting.Brightness = orig.Brightness
            Lighting.ClockTime = orig.ClockTime
            Lighting.Ambient = orig.Ambient
            Lighting.OutdoorAmbient = orig.OutdoorAmbient
        end
    end
    if force or lastState.NS ~= G.NoShadow then
        lastState.NS = G.NoShadow
        Lighting.GlobalShadows = not G.NoShadow
    end
    local ambChanged = lastState.Amb ~= G.ClockTimeEnabled or lastState.Bright ~= G.Brightness or lastState.Clock ~= G.ClockTime
    if force or ambChanged then
        lastState.Amb = G.ClockTimeEnabled
        lastState.Bright = G.Brightness
        lastState.Clock = G.ClockTime
        if G.ClockTimeEnabled then
            Lighting.ClockTime = G.ClockTime
            Lighting.Brightness = G.Brightness
        elseif not G.Fullbright then
            Lighting.Brightness = orig.Brightness
            Lighting.ClockTime = orig.ClockTime
        end
    end
end

local function applyOpt(force)
    if force or lastOpt.LG ~= G.LowGraphics then
        lastOpt.LG = G.LowGraphics
        pcall(function()
            if G.LowGraphics then
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            else
                settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
            end
        end)
    end
    if force or lastOpt.CS ~= G.CleanSky then
        lastOpt.CS = G.CleanSky
        if G.CleanSky then
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("Sky") then v:Destroy() end
            end
        end
    end
end

local function applyNoFx()
    if G.NoScreenEffects then
        for _, v in pairs(Lighting:GetChildren()) do
            for _, t in ipairs(effectTypes) do
                if v:IsA(t) then
                    if disabledEffects[v] == nil then disabledEffects[v] = v.Enabled end
                    v.Enabled = false
                end
            end
        end
    else
        for obj, state in pairs(disabledEffects) do
            if obj and obj.Parent then obj.Enabled = state end
        end
        disabledEffects = {}
    end
end

Lighting.ChildAdded:Connect(function(v)
    if not G.NoScreenEffects then return end
    task.wait()
    for _, t in ipairs(effectTypes) do
        if v:IsA(t) then
            if disabledEffects[v] == nil then disabledEffects[v] = v.Enabled end
            v.Enabled = false
        end
    end
end)

local function applyZoom()
    if G.UnlimitedZoom then
        LocalPlayer.CameraMaxZoomDistance = G.MaxZoomDistance
        LocalPlayer.CameraMinZoomDistance = 0
    else
        LocalPlayer.CameraMaxZoomDistance = 128
        LocalPlayer.CameraMinZoomDistance = 0.5
    end
end

local function applyFOV()
    local cam = Workspace.CurrentCamera
    if not cam then return end
    if G.FOVEnabled then cam.FieldOfView = G.FOV
    else cam.FieldOfView = orig.FOV end
end

--=== POTATO MODE ===
local potatoOn = false
local potatoBusy = false
local potatoChanged = {}
local potatoConns = {}
local POTATO_BATCH = 40

local function potatoSave(obj, prop)
    if not potatoChanged[obj] then potatoChanged[obj] = {} end
    if potatoChanged[obj][prop] == nil then
        local ok, val = pcall(function() return obj[prop] end)
        if ok then potatoChanged[obj][prop] = val end
    end
end
local function potatoSet(obj, prop, value)
    if not obj or not obj.Parent then return end
    potatoSave(obj, prop)
    pcall(function() obj[prop] = value end)
end
local function potatoOpt(obj)
    if not potatoOn or not obj then return end
    if obj:IsA("BasePart") then
        potatoSet(obj, "CastShadow", false)
        potatoSet(obj, "Reflectance", 0)
        pcall(function() potatoSet(obj, "Material", Enum.Material.Plastic) end)
    end
    if obj:IsA("MeshPart") then
        pcall(function() potatoSet(obj, "RenderFidelity", Enum.RenderFidelity.Performance) end)
    end
    if obj:IsA("Texture") or obj:IsA("Decal") then potatoSet(obj, "Transparency", 1) end
    if obj:IsA("SurfaceAppearance") then
        pcall(function()
            potatoSet(obj, "ColorMap", "")
            potatoSet(obj, "MetalnessMap", "")
            potatoSet(obj, "NormalMap", "")
            potatoSet(obj, "RoughnessMap", "")
        end)
    end
    if obj:IsA("ParticleEmitter") then potatoSet(obj, "Enabled", false) end
    if obj:IsA("Trail") then potatoSet(obj, "Enabled", false) end
    if obj:IsA("Beam") then potatoSet(obj, "Enabled", false) end
    if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then potatoSet(obj, "Enabled", false) end
    if obj:IsA("Clouds") then
        potatoSet(obj, "Cover", 0); potatoSet(obj, "Density", 0)
    end
end

local function potatoEnable()
    if potatoOn then return end
    potatoOn = true
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    potatoSet(Lighting, "GlobalShadows", false)
    potatoSet(Lighting, "Brightness", 1)
    pcall(function()
        potatoSet(Lighting, "EnvironmentDiffuseScale", 0)
        potatoSet(Lighting, "EnvironmentSpecularScale", 0)
    end)
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        potatoSet(terrain, "Decoration", false)
        potatoSet(terrain, "WaterWaveSize", 0)
        potatoSet(terrain, "WaterWaveSpeed", 0)
        potatoSet(terrain, "WaterReflectance", 0)
    end
    if not potatoConns.new then
        potatoConns.new = Workspace.DescendantAdded:Connect(function(obj)
            if not potatoOn then return end
            task.defer(function() if potatoOn then potatoOpt(obj) end end)
        end)
    end
    task.spawn(function()
        if potatoBusy then return end
        potatoBusy = true
        local objs = Workspace:GetDescendants()
        local total = #objs
        local idx = 1
        while potatoOn and idx <= total do
            local fin = math.min(idx + POTATO_BATCH - 1, total)
            for i = idx, fin do
                if not potatoOn then break end
                potatoOpt(objs[i])
            end
            RunService.Heartbeat:Wait()
            idx = fin + 1
        end
        potatoBusy = false
    end)
end

local function potatoDisable()
    if not potatoOn then return end
    potatoOn = false
    for _, c in pairs(potatoConns) do pcall(function() c:Disconnect() end) end
    potatoConns = {}
    task.spawn(function()
        local cnt = 0
        for obj, props in pairs(potatoChanged) do
            if obj and obj.Parent then
                for prop, val in pairs(props) do
                    pcall(function() obj[prop] = val end)
                    cnt = cnt + 1
                    if cnt >= POTATO_BATCH then task.wait(); cnt = 0 end
                end
            end
        end
        potatoChanged = {}
    end)
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
end

RunService.RenderStepped:Connect(function()
    if G.FOVEnabled then
        local cam = Workspace.CurrentCamera
        if cam and cam.FieldOfView ~= G.FOV then cam.FieldOfView = G.FOV end
    end
end)

RunService.RenderStepped:Connect(function()
    if not G.UnlimitedZoom then return end
    if LocalPlayer.CameraMaxZoomDistance ~= G.MaxZoomDistance then
        LocalPlayer.CameraMaxZoomDistance = G.MaxZoomDistance
    end
    if LocalPlayer.CameraMinZoomDistance ~= 0 then LocalPlayer.CameraMinZoomDistance = 0 end
end)

W.Graphics_Apply           = applyGraphics
W.Graphics_ApplyOpt        = applyOpt
W.Graphics_ApplyNoFx       = applyNoFx
W.Graphics_ApplyZoom       = applyZoom
W.Graphics_ApplyFOV        = applyFOV
W.Potato_Set = function(v)
    G.PotatoEnabled = v and true or false
    if G.PotatoEnabled then potatoEnable() else potatoDisable() end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applyGraphics(true); applyOpt(true)
    applyNoFx(); applyZoom(); applyFOV()
end)

--=== LOCK POV ===
do
    local LockPOV = { Enabled = false, LockedFOV = 80, OriginalFOV = nil, Connection = nil }
    local function LockPOV_Update()
        if not LockPOV.Enabled then return end
        local cam = Workspace.CurrentCamera
        if not cam then return end
        if math.abs(cam.FieldOfView - LockPOV.LockedFOV) > 0.1 then cam.FieldOfView = LockPOV.LockedFOV end
    end
    local function LockPOV_SetEnabled(en)
        LockPOV.Enabled = en and true or false
        if LockPOV.Enabled then
            local cam = Workspace.CurrentCamera
            if cam then
                LockPOV.OriginalFOV = cam.FieldOfView
                if LockPOV.Connection then LockPOV.Connection:Disconnect(); LockPOV.Connection = nil end
                cam.FieldOfView = LockPOV.LockedFOV
                LockPOV.Connection = RunService.RenderStepped:Connect(LockPOV_Update)
            end
        else
            if LockPOV.Connection then LockPOV.Connection:Disconnect(); LockPOV.Connection = nil end
            local cam = Workspace.CurrentCamera
            if cam and LockPOV.OriginalFOV then cam.FieldOfView = LockPOV.OriginalFOV end
        end
    end
    W.LockPOV = LockPOV
    W.LockPOV_SetEnabled = LockPOV_SetEnabled
end

--=== CAMERA DBD SYSTEM ===
do
    PAZZHUB.CamDBD_SmoothEnabled = PAZZHUB.CamDBD_SmoothEnabled or false
    PAZZHUB.CamDBD_SmoothSpeed   = PAZZHUB.CamDBD_SmoothSpeed   or 5
    PAZZHUB.CamDBD_POVEnabled    = PAZZHUB.CamDBD_POVEnabled    or false
    PAZZHUB.CamDBD_TargetPOV     = PAZZHUB.CamDBD_TargetPOV     or 85
    PAZZHUB.CamDBD_POVSmooth     = PAZZHUB.CamDBD_POVSmooth     or 9
    local CameraBindName = "PAZZHUB_CameraDBD_Smooth"
    local PreviousPosition = nil
    local PreviousRotation = nil
    local OriginalPOV      = 70
    pcall(function() RunService:UnbindFromRenderStep(CameraBindName) end)
    RunService:BindToRenderStep(
        CameraBindName,
        Enum.RenderPriority.Camera.Value + 1,
        function(DeltaTime)
            local Camera = Workspace.CurrentCamera
            if not Camera then return end
            if Camera.CameraType ~= Enum.CameraType.Custom
               and Camera.CameraType ~= Enum.CameraType.Follow then
                PreviousPosition = nil; PreviousRotation = nil; return
            end
            if PAZZHUB.CamDBD_SmoothEnabled then
                local CurrentCFrame   = Camera.CFrame
                local CurrentPosition = CurrentCFrame.Position
                local CurrentRotation = CurrentCFrame.Rotation
                if not PreviousPosition or not PreviousRotation then
                    PreviousPosition = CurrentPosition
                    PreviousRotation = CurrentRotation
                else
                    local smoothSpeed = tonumber(PAZZHUB.CamDBD_SmoothSpeed) or 5
                    local posAlpha = 1 - math.exp(-smoothSpeed * DeltaTime)
                    PreviousPosition = PreviousPosition:Lerp(CurrentPosition, posAlpha)
                    local rotAlpha = 1 - math.exp(-(smoothSpeed * 1.90) * DeltaTime)
                    PreviousRotation = PreviousRotation:Lerp(CurrentRotation, rotAlpha)
                    Camera.CFrame = CFrame.new(PreviousPosition) * PreviousRotation
                end
            else
                PreviousPosition = nil; PreviousRotation = nil
            end
            if PAZZHUB.CamDBD_POVEnabled then
                local povSpeed = tonumber(PAZZHUB.CamDBD_POVSmooth) or 9
                local alpha = 1 - math.exp(-povSpeed * DeltaTime)
                local target = tonumber(PAZZHUB.CamDBD_TargetPOV) or 85
                Camera.FieldOfView = Camera.FieldOfView + (target - Camera.FieldOfView) * alpha
            end
        end
    )
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5); PreviousPosition = nil; PreviousRotation = nil
    end)
    W.CamDBD_SetSmooth = function(v)
        PAZZHUB.CamDBD_SmoothEnabled = v and true or false
        if not v then PreviousPosition = nil; PreviousRotation = nil
        else
            local cam = Workspace.CurrentCamera
            if cam then
                PreviousPosition = cam.CFrame.Position
                PreviousRotation = cam.CFrame.Rotation
            end
        end
    end
    W.CamDBD_SetSmoothSpeed = function(v) PAZZHUB.CamDBD_SmoothSpeed = tonumber(v) or 5 end
    W.CamDBD_SetPOVLock = function(v)
        PAZZHUB.CamDBD_POVEnabled = v and true or false
        if not v then
            local cam = Workspace.CurrentCamera
            if cam then cam.FieldOfView = OriginalPOV end
        else
            local cam = Workspace.CurrentCamera
            if cam then OriginalPOV = cam.FieldOfView end
        end
    end
    W.CamDBD_SetTargetPOV = function(v) PAZZHUB.CamDBD_TargetPOV = tonumber(v) or 85 end
    W.CamDBD_SetPOVSmooth = function(v) PAZZHUB.CamDBD_POVSmooth = tonumber(v) or 9 end
end

-- [PART 6a: KILLER — Auto Attack + Inf Lunge + Counter Parry DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 6a: KILLER — Auto Attack + Inf Lunge + Counter Parry
--═══════════════════════════════════════════════════════════--

--=== INFINITE LUNGE ===
local PAZZHUB_OriginalLungeBoost = nil
function W.PAZZHUB_UpdateInfiniteLunge()
    local char = LocalPlayer.Character
    if not char then return end

    if PAZZHUB.KILLER_InfLunge then
        if char:GetAttribute("lungeboost") ~= 999999 then
            PAZZHUB_OriginalLungeBoost = char:GetAttribute("lungeboost") or 1
            char:SetAttribute("lungeboost", 999999)
        end
    else
        if PAZZHUB_OriginalLungeBoost then
            char:SetAttribute("lungeboost", PAZZHUB_OriginalLungeBoost)
            PAZZHUB_OriginalLungeBoost = nil
        end
    end
end
W.VD_UpdateInfiniteLunge = W.PAZZHUB_UpdateInfiniteLunge

LocalPlayer.CharacterRemoving:Connect(function()
    PAZZHUB_OriginalLungeBoost = nil
end)

--=== COUNTER AUTO PARRY ===
do
    local animList = {}
    for id, _ in pairs(KillerAttackAnims) do table.insert(animList, id) end

    task.spawn(function()
        while true do
            task.wait(0.5)
            if not PAZZHUB.CounterParry_Enabled then continue end
            local c = LocalPlayer.Character
            if not c then continue end
            local r = c:FindFirstChild("HumanoidRootPart")
            if not r then continue end
            local near = false
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Team and string.find(string.lower(p.Team.Name), "survivor", 1, true) then
                    local rr = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                    if rr and (r.Position - rr.Position).Magnitude <= 15 then near = true; break end
                end
            end
            if near then
                local rid = animList[math.random(1, #animList)]
                local a = Instance.new("Animation")
                a.AnimationId = "rbxassetid://" .. rid
                local h = c:FindFirstChildOfClass("Humanoid")
                local anim = h and h:FindFirstChildOfClass("Animator")
                if anim then
                    local t = anim:LoadAnimation(a)
                    t:Play()
                    t:AdjustWeight(0)
                    task.wait(0.05)
                    t:Stop()
                    a:Destroy()
                end
            end
        end
    end)
end

--=== AUTO ATTACK (KILLER) — (sudah ada di PART 3, ini tambahan dari ALFzxzzz) ===
-- Fungsi W.KA_AutoAttack udah ada di PART 3 (loop 0.1s)

-- [PART 6b: KILLER — Aim Lock Hidden + Attack + Anti Blind + Destroy Pallet + Masked DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 6b: KILLER — Aim Lock Hidden + Attack + Anti Blind + Pallet + Masked
--═══════════════════════════════════════════════════════════--

--=== AIM LOCK HIDDEN ===
do
    local AimLockEnabled = false
    local AimLockThread = nil
    local AimLockAiming = false
    local AimLockHoldKey = Enum.KeyCode.E
    local AimLockMobileHooks = {}
    local function AimLock_GetClosestTarget()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil end
        local myTeam = LocalPlayer.Team and LocalPlayer.Team.Name or ""
        local myIsKiller = string.find(string.lower(myTeam), "killer", 1, true) ~= nil
        local closestTarget, shortestDist = nil, math.huge
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local targetHrp = player.Character:FindFirstChild("HumanoidRootPart")
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                local playerTeam = player.Team and player.Team.Name or ""
                local theirIsKiller = string.find(string.lower(playerTeam), "killer", 1, true) ~= nil
                if targetHrp and hum and hum.Health > 0 then
                    local isEnemy = (myIsKiller and not theirIsKiller) or ((not myIsKiller) and theirIsKiller)
                    if isEnemy then
                        local dist = (targetHrp.Position - hrp.Position).Magnitude
                        if dist < shortestDist then
                            shortestDist, closestTarget = dist, targetHrp
                        end
                    end
                end
            end
        end
        return closestTarget
    end
    local function AimLock_Start()
        if AimLockThread then task.cancel(AimLockThread) end
        AimLockThread = task.spawn(function()
            while AimLockEnabled do
                if AimLockAiming then
                    local target = AimLock_GetClosestTarget()
                    if target then
                        pcall(function()
                            Workspace.CurrentCamera.CFrame = CFrame.new(
                                Workspace.CurrentCamera.CFrame.Position,
                                target.Position + Vector3.new(0, 2.5, 0)
                            )
                        end)
                    end
                end
                task.wait()
            end
        end)
    end
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp or not AimLockEnabled then return end
        if input.UserInputType == Enum.UserInputType.MouseButton2 then AimLockAiming = true end
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == AimLockHoldKey then AimLockAiming = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if not AimLockEnabled then return end
        if input.UserInputType == Enum.UserInputType.MouseButton2 then AimLockAiming = false end
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == AimLockHoldKey then AimLockAiming = false end
    end)
    local function AimLock_DisconnectMobile()
        for _, c in pairs(AimLockMobileHooks) do pcall(function() c:Disconnect() end) end
        AimLockMobileHooks = {}
    end
    local function AimLock_SetupMobile()
        if not UserInputService.TouchEnabled then return end
        AimLock_DisconnectMobile()
        task.spawn(function()
            local pGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
            if not pGui then return end
            local NAMES = {"attack","shoot","fire","basicattack","tembak","hidden","skill","ability","power","skill1","ability1","gui-mob"}
            local function isBtn(obj)
                if not obj then return false end
                if not (obj:IsA("GuiButton") or obj:IsA("ImageButton") or obj:IsA("TextButton")) then return false end
                local l = obj.Name:lower()
                for _, n in ipairs(NAMES) do
                    if l == n or l:find(n, 1, true) then return true end
                end
                return false
            end
            local function hook(btn)
                if not btn or btn:GetAttribute("AimLockHooked") then return end
                btn:SetAttribute("AimLockHooked", true)
                table.insert(AimLockMobileHooks, btn.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
                        if AimLockEnabled then AimLockAiming = true end
                    end
                end))
                table.insert(AimLockMobileHooks, btn.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
                        AimLockAiming = false
                    end
                end))
                table.insert(AimLockMobileHooks, btn:GetPropertyChangedSignal("Visible"):Connect(function()
                    if not btn.Visible then AimLockAiming = false end
                end))
            end
            local function scan()
                for _, ch in ipairs(pGui:GetChildren()) do
                    local ctrl = ch:FindFirstChild("Controls")
                    if ctrl then
                        for _, obj in ipairs(ctrl:GetDescendants()) do
                            if isBtn(obj) then hook(obj) end
                        end
                    end
                end
            end
            scan()
            table.insert(AimLockMobileHooks, pGui.ChildAdded:Connect(function() task.wait(0.3); scan() end))
        end)
    end
    if UserInputService.TouchEnabled then AimLock_SetupMobile() end
    LocalPlayer.CharacterAdded:Connect(function()
        AimLockAiming = false
        if UserInputService.TouchEnabled then task.wait(2); AimLock_SetupMobile() end
    end)
    function W.AimLockHidden_Set(state)
        AimLockEnabled = state
        if state then
            AimLock_Start()
            PAZZHUB_Notify("Aim Lock Hidden", "Enabled — Hold M2/E", 2)
        else
            AimLockAiming = false
            if AimLockThread then task.cancel(AimLockThread); AimLockThread = nil end
            PAZZHUB_Notify("Aim Lock Hidden", "Disabled", 2)
        end
    end
    function W.AimLockHidden_SetKey(name)
        local map = {
            ["leftshift"]=Enum.KeyCode.LeftShift,["rightshift"]=Enum.KeyCode.RightShift,
            ["leftalt"]=Enum.KeyCode.LeftAlt,["rightalt"]=Enum.KeyCode.RightAlt,
            ["leftctrl"]=Enum.KeyCode.LeftControl,["rightctrl"]=Enum.KeyCode.RightControl,
            ["leftcontrol"]=Enum.KeyCode.LeftControl,["rightcontrol"]=Enum.KeyCode.RightControl,
            ["space"]=Enum.KeyCode.Space,["tab"]=Enum.KeyCode.Tab,
        }
        local newKey = map[tostring(name):lower()]
        if not newKey then
            local ok, kc = pcall(function() return Enum.KeyCode[tostring(name):upper():sub(1,1) .. tostring(name):lower():sub(2)] end)
            if ok and kc then newKey = kc end
        end
        if newKey then
            AimLockHoldKey = newKey
            PAZZHUB_Notify("Aim Lock", "Hold key: " .. newKey.Name, 2)
        end
    end
end

--=== AIM LOCK ATTACK ===
do
    local AttackAim = {
        Enabled = false, Holding = false, Strength = 1,
        Predict = true, PredictStrength = 0.12, FOV = 250,
        VisibilityCheck = true, AimPart = "HumanoidRootPart",
    }
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
            if p ~= LocalPlayer and p.Team and string.find(string.lower(p.Team.Name), "survivor", 1, true) and p.Character then
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
    W.AttackAim_Start = AL_StartAttackAim
    W.AttackAim_Cfg = AttackAim
end

--=== ANTI BLIND FLASHLIGHT ===
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
                    if not checkcaller() and getgenv().PAZZHUB and getgenv().PAZZHUB.KILLER_AntiBlind and self == gb then
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

--=== DESTROY PALLET ===
getgenv().PAZZHUB_IsBreakingPallet = false
function W.MAWWW_DestroyAllPallets()
    if not PAZZHUB.KILLER_DestroyPallets then return end
    if W.GetRole() ~= "Killer" then return end
    if getgenv().PAZZHUB_IsBreakingPallet then return end

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

    getgenv().PAZZHUB_IsBreakingPallet = true
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
        getgenv().PAZZHUB_IsBreakingPallet = false
    end)
end

--=== SELECT MASKED ===
W.Masked = W.Masked or { CurrentPower = "Cobra", Powers = {"Cobra", "Richter", "Brandon", "Rabbit", "Alex", "Tony"} }
local Masked = W.Masked
function W.Masked_Activate()
    local ev = ReplicatedStorage:FindFirstChild("Remotes", true)
        and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
        and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
        and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Activatepower")
    if ev then
        pcall(function() ev:FireServer(Masked.CurrentPower) end)
        PAZZHUB_Notify("Select Masked", "Activated: " .. Masked.CurrentPower, 2)
    else PAZZHUB_Notify("Select Masked", "Activatepower remote not found", 2) end
end
function W.Masked_Deactivate()
    local ev = ReplicatedStorage:FindFirstChild("RemoteEvents", true)
        and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
        and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
        and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Deactivatepower")
    if ev then
        pcall(function() ev:FireServer() end)
        PAZZHUB_Notify("Select Masked", "Deactivated", 2)
    else PAZZHUB_Notify("Select Masked", "Deactivatepower remote not found", 2) end
end

-- [PART 6c: KILLER — Silent Veil V1 + W424 Silent Veil V2 DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 6c: KILLER — Silent Veil V1 + W424 Silent Veil V2
--═══════════════════════════════════════════════════════════--

--=== SILENT VEIL V1 (Alfzxzzz Original) ===
local VeilState = { target = nil, lookVector = nil, velHistory = {} }
local VeilVisuals = {}
pcall(function()
    if typeof(Drawing) ~= "table" or not Drawing.new then return end
    local V = VeilVisuals
    local ACCENT = _G.PAZZHUB_ACCENT or Color3.fromRGB(0, 170, 255)
    local BLACK  = Color3.fromRGB(0, 0, 0)
    local WHITE  = Color3.fromRGB(255, 255, 255)
    V.FOVOuterRing = Drawing.new("Circle"); V.FOVOuterRing.Color = BLACK; V.FOVOuterRing.Thickness = 3; V.FOVOuterRing.Filled = false; V.FOVOuterRing.Transparency = 0.4; V.FOVOuterRing.Visible = false; V.FOVOuterRing.NumSides = 90
    V.FOVMainRing = Drawing.new("Circle"); V.FOVMainRing.Color = ACCENT; V.FOVMainRing.Thickness = 1.6; V.FOVMainRing.Filled = false; V.FOVMainRing.Transparency = 0.85; V.FOVMainRing.Visible = false; V.FOVMainRing.NumSides = 90
    V.FOVInnerRing = Drawing.new("Circle"); V.FOVInnerRing.Color = ACCENT; V.FOVInnerRing.Thickness = 1; V.FOVInnerRing.Filled = false; V.FOVInnerRing.Transparency = 0.35; V.FOVInnerRing.Visible = false; V.FOVInnerRing.NumSides = 90
    V.FOVCrossLines = {}
    for i = 1, 4 do
        local line = Drawing.new("Line")
        line.Color = WHITE; line.Thickness = 1.5; line.Transparency = 0.9; line.Visible = false
        V.FOVCrossLines[i] = line
    end
    V.FOVTicks = {}
    for i = 1, 4 do
        local line = Drawing.new("Line")
        line.Color = ACCENT; line.Thickness = 2.2; line.Transparency = 0.95; line.Visible = false
        V.FOVTicks[i] = line
    end
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

local function Veil_HideFOV()
    local V = VeilVisuals
    local OFF = Vector2.new(-9999, -9999)
    if V.FOVOuterRing then V.FOVOuterRing.Visible = false; V.FOVOuterRing.Position = OFF; V.FOVOuterRing.Radius = 0; V.FOVOuterRing.Transparency = 1 end
    if V.FOVMainRing then V.FOVMainRing.Visible = false; V.FOVMainRing.Position = OFF; V.FOVMainRing.Radius = 0; V.FOVMainRing.Transparency = 1 end
    if V.FOVInnerRing then V.FOVInnerRing.Visible = false; V.FOVInnerRing.Position = OFF; V.FOVInnerRing.Radius = 0; V.FOVInnerRing.Transparency = 1 end
    if V.FOVCrossLines then for _, s in ipairs(V.FOVCrossLines) do s.Visible = false; s.From = OFF; s.To = OFF end end
    if V.FOVTicks then for _, s in ipairs(V.FOVTicks) do s.Visible = false; s.From = OFF; s.To = OFF end end
end

local function Veil_HideTracker()
    local V = VeilVisuals
    local OFF = Vector2.new(-9999, -9999)
    if V.TrackerOuterRing then V.TrackerOuterRing.Visible = false; V.TrackerOuterRing.Position = OFF; V.TrackerOuterRing.Radius = 0; V.TrackerOuterRing.Transparency = 1 end
    if V.TrackerMainRing then V.TrackerMainRing.Visible = false; V.TrackerMainRing.Position = OFF; V.TrackerMainRing.Radius = 0; V.TrackerMainRing.Transparency = 1 end
    if V.TrackerDotFill then V.TrackerDotFill.Visible = false; V.TrackerDotFill.Position = OFF; V.TrackerDotFill.Radius = 0 end
    if V.TrackerDotOutline then V.TrackerDotOutline.Visible = false; V.TrackerDotOutline.Position = OFF; V.TrackerDotOutline.Radius = 0 end
    if V.TrackerLine then V.TrackerLine.Visible = false; V.TrackerLine.From = OFF; V.TrackerLine.To = OFF end
end

local function Veil_HideAllVisuals() Veil_HideFOV(); Veil_HideTracker() end

local function Veil_UpdateFOVVisuals(center)
    local V = VeilVisuals
    if not V.FOVOuterRing then return end
    local radius = PAZZHUB.VeilFOV or 150
    local t = tick()
    local pulse = (math.sin(t * 3) + 1) * 0.5
    local slowPulse = (math.sin(t * 1.2) + 1) * 0.5
    V.FOVOuterRing.Position = center; V.FOVOuterRing.Radius = radius + 2; V.FOVOuterRing.Transparency = 0.3 + pulse * 0.15; V.FOVOuterRing.Visible = true
    V.FOVMainRing.Position = center; V.FOVMainRing.Radius = radius; V.FOVMainRing.Transparency = 0.7 + pulse * 0.25; V.FOVMainRing.Visible = true
    V.FOVInnerRing.Position = center; V.FOVInnerRing.Radius = radius - 10; V.FOVInnerRing.Transparency = 0.25 + slowPulse * 0.2; V.FOVInnerRing.Visible = true
    local gap, armLen = 4, 12
    V.FOVCrossLines[1].From = Vector2.new(center.X, center.Y - gap); V.FOVCrossLines[1].To = Vector2.new(center.X, center.Y - gap - armLen); V.FOVCrossLines[1].Visible = true
    V.FOVCrossLines[2].From = Vector2.new(center.X, center.Y + gap); V.FOVCrossLines[2].To = Vector2.new(center.X, center.Y + gap + armLen); V.FOVCrossLines[2].Visible = true
    V.FOVCrossLines[3].From = Vector2.new(center.X - gap, center.Y); V.FOVCrossLines[3].To = Vector2.new(center.X - gap - armLen, center.Y); V.FOVCrossLines[3].Visible = true
    V.FOVCrossLines[4].From = Vector2.new(center.X + gap, center.Y); V.FOVCrossLines[4].To = Vector2.new(center.X + gap + armLen, center.Y); V.FOVCrossLines[4].Visible = true
    local tickLen = 9
    for i = 1, 4 do
        local angle = (i - 1) * math.pi / 2
        local dirX, dirY = math.cos(angle), math.sin(angle)
        V.FOVTicks[i].From = Vector2.new(center.X + dirX * radius, center.Y + dirY * radius)
        V.FOVTicks[i].To = Vector2.new(center.X + dirX * (radius - tickLen), center.Y + dirY * (radius - tickLen))
        V.FOVTicks[i].Visible = true
    end
end

local function Veil_UpdateTrackerVisuals(targetScreenPos, dist)
    local V = VeilVisuals
    if not V.TrackerOuterRing then return end
    local t = tick()
    local pulse = (math.sin(t * 4) + 1) * 0.5
    local baseRadius = math.clamp(1000 / math.max(dist, 1), 20, 48)
    V.TrackerOuterRing.Position = targetScreenPos; V.TrackerOuterRing.Radius = baseRadius + 3; V.TrackerOuterRing.Transparency = 0.25 + pulse * 0.15; V.TrackerOuterRing.Visible = true
    V.TrackerMainRing.Position = targetScreenPos; V.TrackerMainRing.Radius = baseRadius; V.TrackerMainRing.Transparency = 0.75 + pulse * 0.2; V.TrackerMainRing.Visible = true
    V.TrackerDotFill.Position = targetScreenPos; V.TrackerDotFill.Radius = 2.5 + pulse * 1.2; V.TrackerDotFill.Transparency = 0.85 + pulse * 0.15; V.TrackerDotFill.Visible = true
    V.TrackerDotOutline.Position = targetScreenPos; V.TrackerDotOutline.Radius = 5 + pulse * 1.5; V.TrackerDotOutline.Transparency = 0.35; V.TrackerDotOutline.Visible = true
end

local function Veil_UpdateAimbot()
    if GetRole() ~= "Killer" then
        VeilState.target = nil; VeilState.lookVector = nil
        Veil_HideAllVisuals(); return
    end
    local cam = Workspace.CurrentCamera
    if not cam then return end
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    if PAZZHUB.VeilShowFOV and PAZZHUB.VeilEnabled then Veil_UpdateFOVVisuals(center)
    else Veil_HideFOV() end
    if not PAZZHUB.VeilEnabled then VeilState.target = nil; VeilState.lookVector = nil; Veil_HideTracker(); return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local nearest, nearestPart = nil, nil
    local bestDist = PAZZHUB.VeilFOV or 150
    local bestStudDist = PAZZHUB.VeilMaxDist or 500
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
                            if studDist <= bestStudDist then bestDist = sd; nearest = p; nearestPart = targetPart end
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
        if dist > 0.1 and dist <= (PAZZHUB.VeilMaxDist or 500) then
            local isAuraActive = char:GetAttribute("special") == true
            local prof
            if isAuraActive then
                prof = { v0 = PAZZHUB.VeilAuraSpearSpeed or 165, g = PAZZHUB.VeilAuraSpearGravity or 96.5, windup = 0.10, latency = 0.04, maxlead = 25, scale = PAZZHUB.VeilLeadMultiplier or 1.4 }
            else
                prof = { v0 = PAZZHUB.VeilSpearSpeed or 165, g = PAZZHUB.VeilGravity or 103, windup = 0.10, latency = 0.04, maxlead = 45, scale = PAZZHUB.VeilLeadMultiplier or 1.4 }
            end
            local aimPoint = tp
            if PAZZHUB.VeilAutoPredict then
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
            if ahDist > 0.001 then VeilState.lookVector = ah.Unit * math.cos(pitch) + Vector3.new(0, math.sin(pitch), 0)
            else VeilState.lookVector = adir.Unit end
            VeilState.target = nearest
            if PAZZHUB.VeilShowTracker then
                local sp, vis = cam:WorldToViewportPoint(tp)
                if vis and sp.Z > 0 then
                    local screenDist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if screenDist <= (PAZZHUB.VeilFOV or 150) + 100 then
                        Veil_UpdateTrackerVisuals(Vector2.new(sp.X, sp.Y), dist)
                        local bottomCenter = Vector2.new(center.X, cam.ViewportSize.Y)
                        local V = VeilVisuals
                        if V.TrackerLine then V.TrackerLine.From = bottomCenter; V.TrackerLine.To = Vector2.new(sp.X, sp.Y); V.TrackerLine.Visible = true end
                    else Veil_HideTracker() end
                end
            else Veil_HideTracker() end
        end
    else VeilState.target = nil; VeilState.lookVector = nil; Veil_HideTracker() end
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
                    if self.Name == "Spearthrow" and PAZZHUB.VeilEnabled and typeof(VeilState.lookVector) == "Vector3" and GetRole() == "Killer" then
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

W._VeilV1_State = VeilState
RunService.RenderStepped:Connect(function() pcall(Veil_UpdateAimbot) end)

--═══════════════════════════════════════════════════════════--
-- W424 SILENT VEIL V2 (SpearSmart)
--═══════════════════════════════════════════════════════════--
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
        if AimConfig.AIM_TargetPart == "Head" then return char:FindFirstChild("Head")
        elseif AimConfig.AIM_TargetPart == "Root" or AimConfig.AIM_TargetPart == "HumanoidRootPart" then return char:FindFirstChild("HumanoidRootPart")
        else return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart") end
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
    veilTargetHighlight.Name = "PAZZHUB_VeilTarget"
    veilTargetHighlight.FillColor = Color3.fromRGB(150, 150, 150)
    veilTargetHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    veilTargetHighlight.FillTransparency = 0.5
    veilTargetHighlight.OutlineTransparency = 0

    local VeilTrackerEnabled = false
    local VeilTrackerLine = nil
    local currentVeilBillboard = nil

    local function setupVeilTrackerGui()
        if CoreGui:FindFirstChild("PAZZHUBVeilTrackerGui") then return end
        local sg = Instance.new("ScreenGui")
        sg.Name = "PAZZHUBVeilTrackerGui"
        sg.IgnoreGuiInset = true
        sg.ResetOnSpawn = false
        sg.Parent = CoreGui
        VeilTrackerLine = Instance.new("Frame")
        VeilTrackerLine.Name = "Line"
        VeilTrackerLine.AnchorPoint = Vector2.new(0.5, 0.5)
        VeilTrackerLine.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        VeilTrackerLine.BackgroundTransparency = 0.2
        VeilTrackerLine.BorderSizePixel = 0
        VeilTrackerLine.Visible = false
        VeilTrackerLine.Parent = sg
    end
    setupVeilTrackerGui()

    local VeilFOVFrame = nil
    if not CoreGui:FindFirstChild("PAZZHUBFOVCircleGui_Standalone") then
        local FOVGui = Instance.new("ScreenGui")
        FOVGui.Name = "PAZZHUBFOVCircleGui_Standalone"
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
        VeilFOVStroke.Color = Color3.fromRGB(0, 170, 255)
        VeilFOVStroke.Thickness = 1.5
    end

    local SpearInterceptorHooked = false
    local function setupSpearInterceptor()
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
                        stroke.Color = Color3.fromRGB(0, 170, 255)
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
                    if currentVeilBillboard then currentVeilBillboard:Destroy(); currentVeilBillboard = nil end
                    if VeilTrackerLine then VeilTrackerLine.Visible = false end
                end
            else
                veilTargetHighlight.Parent = nil
                if currentVeilBillboard then currentVeilBillboard:Destroy(); currentVeilBillboard = nil end
                if VeilTrackerLine then VeilTrackerLine.Visible = false end
            end
        else
            veilTargetHighlight.Parent = nil
            if currentVeilBillboard then currentVeilBillboard:Destroy(); currentVeilBillboard = nil end
            if VeilTrackerLine then VeilTrackerLine.Visible = false end
        end
    end)

    W.W424Veil_API = {
        AimConfig = AimConfig,
        Config = Config,
        getClosestSurvivor = getClosestSurvivor,
        IsVeilSilentOn = IsVeilSilentOn,
        setTracker = function(v) VeilTrackerEnabled = v end,
    }
end

-- [PART 6d: KILLER — Bypass (Hidden, Myers, Slasher, Abyss, Jeff) DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 6d: KILLER — Bypass (Hidden, Myers, Slasher, Abyss, Jeff)
--═══════════════════════════════════════════════════════════--

--=== BYPASS HIDDEN LEAP ===
getgenv().PAZZHUB_HiddenLeapBypassThread = nil
function W.BYPASS_StartHiddenCooldownBypass()
    if getgenv().PAZZHUB_HiddenLeapBypassThread then return end
    getgenv().PAZZHUB_HiddenLeapBypassThread = task.spawn(function()
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
            if not PAZZHUB.KILLER_BypassLeap then break end
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
        getgenv().PAZZHUB_HiddenLeapBypassThread = nil
    end)
end
function W.BYPASS_StopHiddenCooldownBypass() end
function W.BYPASS_SetHiddenLeap(v)
    PAZZHUB.KILLER_BypassLeap = v and true or false
    if PAZZHUB.KILLER_BypassLeap then W.BYPASS_StartHiddenCooldownBypass()
    else W.BYPASS_StopHiddenCooldownBypass() end
end

--=== BYPASS MYERS INF GRAB ===
W.MyersGrabData = W.MyersGrabData or { Enabled = false, HotkeyCode = Enum.KeyCode.H }
local MyersGrabData = W.MyersGrabData
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
                    player = player, dist = (hrp.Position - myHRP.Position).Magnitude, health = hum.Health
                })
            end
        end
    end
    table.sort(candidates, function(a, b) return a.dist < b.dist end)
    for _, c in ipairs(candidates) do return c.player end
    return nil
end
function W.doMyersGrab()
    if not MyersGrabData.Enabled then return end
    local target = W.getMyersTarget()
    if not target or not target.Character then return end
    pcall(function() ReplicatedStorage.Remotes.Killers.Stalker.grab:FireServer(target.Character) end)
end
function W.setMyersGrab(v)
    MyersGrabData.Enabled = v and true or false
    PAZZHUB.KILLER_InfGrab = MyersGrabData.Enabled
    if getgenv().PAZZHUB_MGrabBtn_UpdateVisual then pcall(getgenv().PAZZHUB_MGrabBtn_UpdateVisual) end
end
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == MyersGrabData.HotkeyCode and MyersGrabData.Enabled then
        W.doMyersGrab()
    end
end)

--=== BYPASS SLASHER (LakeMist + Pursuit) ===
getgenv().PAZZHUB_SlasherCooldownBypassThread = nil
function W.MAWWW_StartSlasherCooldownBypass()
    if getgenv().PAZZHUB_SlasherCooldownBypassThread then return end
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
    getgenv().PAZZHUB_SlasherCooldownBypassThread = task.spawn(function()
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
            if not PAZZHUB.KILLER_InfLakeMist and not PAZZHUB.KILLER_InfPursuit then break end
            if not (toggleFunc and pursuitHandler) then
                if os.clock() - lastScan >= 2 then scanGCForSlasher(); lastScan = os.clock() end
            end
            if toggleFunc and PAZZHUB.KILLER_InfLakeMist then
                pcall(function()
                    debug.setupvalue(toggleFunc, 6, false)
                    debug.setupvalue(toggleFunc, 10, false)
                end)
            end
            if pursuitHandler and PAZZHUB.KILLER_InfPursuit then
                pcall(function()
                    debug.setupvalue(pursuitHandler, 5, false)
                    debug.setupvalue(pursuitHandler, 6, false)
                end)
            end
        end
        getgenv().PAZZHUB_SlasherCooldownBypassThread = nil
    end)
end
function W.MAWWW_StopSlasherCooldownBypass()
    pcall(function()
        local jason = ReplicatedStorage:FindFirstChild("Remotes")
            and ReplicatedStorage.Remotes:FindFirstChild("Killers")
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Jason")
        if jason then
            if not PAZZHUB.KILLER_InfLakeMist then
                local lm = jason:FindFirstChild("LakeMist")
                if lm then lm:FireServer(false) end
            end
            if not PAZZHUB.KILLER_InfPursuit then
                local ps = jason:FindFirstChild("Pursuit")
                if ps then ps:FireServer(false) end
            end
        end
    end)
end
function W.MAWWW_SetLakeMist(v)
    PAZZHUB.KILLER_InfLakeMist = v and true or false
    if PAZZHUB.KILLER_InfLakeMist or PAZZHUB.KILLER_InfPursuit then W.MAWWW_StartSlasherCooldownBypass()
    else W.MAWWW_StopSlasherCooldownBypass() end
end
function W.MAWWW_SetPursuit(v)
    PAZZHUB.KILLER_InfPursuit = v and true or false
    if PAZZHUB.KILLER_InfLakeMist or PAZZHUB.KILLER_InfPursuit then W.MAWWW_StartSlasherCooldownBypass()
    else W.MAWWW_StopSlasherCooldownBypass() end
end

--=== BYPASS ABYSS ===
getgenv().PAZZHUB_AbyssCooldownBypassConnection = nil
getgenv().PAZZHUB_CorruptHandlerFunc = nil
function W.MAWWW_StartAbyssCooldownBypass()
    if not getgenv().PAZZHUB_CorruptHandlerFunc then
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if type(v) == "function" and islclosure(v) then
                    local constants = debug.getconstants(v)
                    if table.find(constants, "corrupt") and table.find(constants, "Immobile") then
                        getgenv().PAZZHUB_CorruptHandlerFunc = v
                        break
                    end
                end
            end
        end)
    end
    if not getgenv().PAZZHUB_CorruptHandlerFunc then return end
    if getgenv().PAZZHUB_AbyssCooldownBypassConnection then
        getgenv().PAZZHUB_AbyssCooldownBypassConnection:Disconnect()
    end
    getgenv().PAZZHUB_AbyssCooldownBypassConnection = RunService.Heartbeat:Connect(function()
        if not PAZZHUB.KILLER_BypassCooldown then return end
        if getgenv().PAZZHUB_CorruptHandlerFunc then
            local upvalues = debug.getupvalues(getgenv().PAZZHUB_CorruptHandlerFunc)
            for idx, val in pairs(upvalues) do
                if type(val) == "boolean" and val == false then
                    debug.setupvalue(getgenv().PAZZHUB_CorruptHandlerFunc, idx, true)
                end
            end
        end
    end)
end
function W.MAWWW_StopAbyssCooldownBypass()
    if getgenv().PAZZHUB_AbyssCooldownBypassConnection then
        getgenv().PAZZHUB_AbyssCooldownBypassConnection:Disconnect()
        getgenv().PAZZHUB_AbyssCooldownBypassConnection = nil
    end
end
function W.MAWWW_SetAbyssBypass(v)
    PAZZHUB.KILLER_BypassCooldown = v and true or false
    if PAZZHUB.KILLER_BypassCooldown then W.MAWWW_StartAbyssCooldownBypass()
    else W.MAWWW_StopAbyssCooldownBypass() end
end

--=== BYPASS JEFF INF FRENZY ===
getgenv().PAZZHUB_JeffCooldownBypassThread = nil
function W.MAWWW_StartJeffCooldownBypass()
    if getgenv().PAZZHUB_JeffCooldownBypassThread then return end
    getgenv().PAZZHUB_JeffCooldownBypassThread = task.spawn(function()
        while task.wait() do
            if not PAZZHUB.KILLER_InfFrenzy then break end
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:GetAttribute("Frenzy") ~= true then
                    char:SetAttribute("Frenzy", true)
                end
            end)
        end
        getgenv().PAZZHUB_JeffCooldownBypassThread = nil
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
    PAZZHUB.KILLER_InfFrenzy = v and true or false
    if PAZZHUB.KILLER_InfFrenzy then W.MAWWW_StartJeffCooldownBypass()
    else W.MAWWW_StopJeffCooldownBypass() end
end

-- [PART 6e: KILLER — Spear Aimbot + Killer Abilities + Auto Hook DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 6e: KILLER — Spear Aimbot + Killer Abilities + Auto Hook
--═══════════════════════════════════════════════════════════--

--=== SPEAR AIMBOT ===
do
    PAZZHUB.SPEAR_Aimbot = PAZZHUB.SPEAR_Aimbot or false
    PAZZHUB.SPEAR_Gravity = PAZZHUB.SPEAR_Gravity or 50
    PAZZHUB.SPEAR_Speed = PAZZHUB.SPEAR_Speed or 100
    local SpearBtnData = {
        UI = nil, Button = nil, Active = true, DragLocked = false,
        Dragging = false, DragStart = nil, DragStartPos = nil,
        ManualTarget = nil, TargetIndex = 0,
        TargetLabel = nil, LeftArrow = nil, RightArrow = nil,
    }
    local function SpearAimbotCalc(targetPos)
        if not PAZZHUB.SPEAR_Aimbot or GetRole() ~= "Killer" then return nil end
        local char = LocalPlayer.Character
        if not char then return nil end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local startPos = root.Position + Vector3.new(0, 2, 0)
        local distance = (targetPos - startPos).Magnitude
        local gravity  = PAZZHUB.SPEAR_Gravity or 50
        local speed    = PAZZHUB.SPEAR_Speed or 100
        local time     = distance / speed
        local drop     = 0.5 * gravity * time * time
        return targetPos + Vector3.new(0, drop, 0)
    end
    local function Spear_GetTargetList()
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local list = {}
        if not root then return list end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and TeamIs(player, "Survivor") and player.Character then
                local tr = player.Character:FindFirstChild("HumanoidRootPart")
                local th = player.Character:FindFirstChildOfClass("Humanoid")
                if tr and th and th.MaxHealth > 0 and (th.Health / th.MaxHealth) > 0.25 then
                    local dist = (tr.Position - root.Position).Magnitude
                    table.insert(list, { Player = player, Dist = dist })
                end
            end
        end
        table.sort(list, function(a, b) return a.Dist < b.Dist end)
        local players = {}
        for _, v in ipairs(list) do table.insert(players, v.Player) end
        return players
    end
    local function Spear_UpdateTargetLabel()
        if not (SpearBtnData and SpearBtnData.TargetLabel) then return end
        if SpearBtnData.ManualTarget and SpearBtnData.ManualTarget.Parent then
            SpearBtnData.TargetLabel.Text = SpearBtnData.ManualTarget.Name
        else
            SpearBtnData.TargetLabel.Text = "AUTO"
        end
        SpearBtnData.TargetLabel.Visible = true
    end
    local function Spear_CycleTarget(direction)
        local list = Spear_GetTargetList()
        if #list == 0 then
            SpearBtnData.ManualTarget = nil; SpearBtnData.TargetIndex = 0
            PAZZHUB_Notify("Spear Aimbot", "Tidak ada target survivor.", 2)
            return
        end
        local curIdx = nil
        if SpearBtnData.ManualTarget then
            for i, p in ipairs(list) do
                if p == SpearBtnData.ManualTarget then curIdx = i; break end
            end
        end
        local nextIdx
        if curIdx then
            nextIdx = curIdx + direction
            if nextIdx > #list then nextIdx = 1 end
            if nextIdx < 1 then nextIdx = #list end
        else nextIdx = 1 end
        SpearBtnData.TargetIndex  = nextIdx
        SpearBtnData.ManualTarget = list[nextIdx]
        PAZZHUB_Notify("Spear Aimbot", "Target: " .. SpearBtnData.ManualTarget.Name, 2)
        Spear_UpdateTargetLabel()
    end
    local function Spear_UpdateAim()
        if not PAZZHUB.SPEAR_Aimbot then return end
        if SpearBtnData and not SpearBtnData.Active then return end
        if GetRole() ~= "Killer" then return end
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local target = nil
        if SpearBtnData.ManualTarget then
            local p = SpearBtnData.ManualTarget
            local valid = p.Parent and TeamIs(p, "Survivor") and p.Character
            if valid then
                local tr = p.Character:FindFirstChild("HumanoidRootPart")
                local th = p.Character:FindFirstChildOfClass("Humanoid")
                valid = tr and th and th.MaxHealth > 0 and (th.Health / th.MaxHealth) > 0.25
            end
            if valid then target = p
            else SpearBtnData.ManualTarget = nil; Spear_UpdateTargetLabel() end
        end
        if not target then
            local closest, closestDist = nil, math.huge
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and TeamIs(player, "Survivor") and player.Character then
                    local tr = player.Character:FindFirstChild("HumanoidRootPart")
                    local th = player.Character:FindFirstChildOfClass("Humanoid")
                    if tr and th and th.MaxHealth > 0 and (th.Health / th.MaxHealth) > 0.25 then
                        local dist = (tr.Position - root.Position).Magnitude
                        if dist < closestDist then closestDist = dist; closest = player end
                    end
                end
            end
            target = closest
        end
        if target and target.Character then
            local tr = target.Character:FindFirstChild("HumanoidRootPart")
            if tr then
                local aimPos = SpearAimbotCalc(tr.Position)
                if aimPos then
                    local cam = Workspace.CurrentCamera
                    if cam then cam.CFrame = CFrame.new(cam.CFrame.Position, aimPos) end
                end
            end
        end
    end
    local function Spear_SetupButton()
        if SpearBtnData.UI then pcall(function() SpearBtnData.UI:Destroy() end) end
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if not pg then return end
        SpearBtnData.UI = Instance.new("ScreenGui")
        SpearBtnData.UI.Name = "PAZZHUBSpearAimbotUI"
        SpearBtnData.UI.ResetOnSpawn = false
        SpearBtnData.UI.IgnoreGuiInset = true
        SpearBtnData.UI.Parent = pg
        SpearBtnData.Button = Instance.new("TextButton")
        SpearBtnData.Button.Name = "SpearAimbotButton"
        SpearBtnData.Button.Size = UDim2.new(0, 65, 0, 65)
        SpearBtnData.Button.Position = UDim2.new(0.15, 0, 0.75, 0)
        SpearBtnData.Button.AnchorPoint = Vector2.new(0.5, 0.5)
        SpearBtnData.Button.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
        SpearBtnData.Button.BackgroundTransparency = 0.15
        SpearBtnData.Button.AutoButtonColor = true
        SpearBtnData.Button.Text = "SPEAR\nAIM"
        SpearBtnData.Button.TextColor3 = Color3.fromRGB(0, 170, 255)
        SpearBtnData.Button.TextSize = 11
        SpearBtnData.Button.Font = Enum.Font.GothamBold
        SpearBtnData.Button.Visible = false
        SpearBtnData.Button.ZIndex = 10
        SpearBtnData.Button.Parent = SpearBtnData.UI
        Instance.new("UICorner", SpearBtnData.Button).CornerRadius = UDim.new(1, 0)
        local spearStk = Instance.new("UIStroke", SpearBtnData.Button)
        spearStk.Color = Color3.fromRGB(0, 170, 255)
        spearStk.Thickness = 2
        spearStk.Transparency = 0.2
        local lockBtn = Instance.new("TextButton")
        lockBtn.Name = "LockDrag"
        lockBtn.Size = UDim2.new(0, 22, 0, 22)
        lockBtn.Position = UDim2.new(1, -5, 0, -5)
        lockBtn.AnchorPoint = Vector2.new(1, 0)
        lockBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        lockBtn.BackgroundTransparency = 0.3
        lockBtn.Text = "L"
        lockBtn.TextSize = 10
        lockBtn.Font = Enum.Font.GothamBold
        lockBtn.TextColor3 = Color3.new(1, 1, 1)
        lockBtn.ZIndex = 11
        lockBtn.Parent = SpearBtnData.Button
        Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(1, 0)
        lockBtn.MouseButton1Click:Connect(function()
            SpearBtnData.DragLocked = not SpearBtnData.DragLocked
            lockBtn.Text = SpearBtnData.DragLocked and "X" or "L"
            lockBtn.BackgroundColor3 = SpearBtnData.DragLocked and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(60, 60, 60)
        end)
        local targetLabel = Instance.new("TextLabel")
        targetLabel.Name = "SpearTargetLabel"
        targetLabel.Size = UDim2.new(0, 90, 0, 18)
        targetLabel.Position = UDim2.new(0.5, 0, 0, -22)
        targetLabel.AnchorPoint = Vector2.new(0.5, 0)
        targetLabel.BackgroundTransparency = 1
        targetLabel.Text = "AUTO"
        targetLabel.TextColor3 = Color3.fromRGB(200, 230, 255)
        targetLabel.TextSize = 12
        targetLabel.Font = Enum.Font.GothamBold
        targetLabel.TextTruncate = Enum.TextTruncate.AtEnd
        targetLabel.ZIndex = 11
        targetLabel.Visible = false
        targetLabel.Parent = SpearBtnData.Button
        SpearBtnData.TargetLabel = targetLabel
        local leftArrow = Instance.new("TextButton")
        leftArrow.Name = "SpearTargetLeft"
        leftArrow.Size = UDim2.new(0, 28, 0, 28)
        leftArrow.Position = UDim2.new(0, -34, 0.5, 0)
        leftArrow.AnchorPoint = Vector2.new(0.5, 0.5)
        leftArrow.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
        leftArrow.BackgroundTransparency = 0.15
        leftArrow.Text = "<"
        leftArrow.TextColor3 = Color3.fromRGB(158, 158, 158)
        leftArrow.TextSize = 16
        leftArrow.Font = Enum.Font.GothamBold
        leftArrow.ZIndex = 10
        leftArrow.Parent = SpearBtnData.Button
        Instance.new("UICorner", leftArrow).CornerRadius = UDim.new(1, 0)
        local leftStk = Instance.new("UIStroke", leftArrow)
        leftStk.Color = Color3.fromRGB(0, 170, 255)
        leftStk.Thickness = 1.5
        leftStk.Transparency = 0.3
        SpearBtnData.LeftArrow = leftArrow
        leftArrow.MouseButton1Click:Connect(function() Spear_CycleTarget(-1) end)
        local rightArrow = Instance.new("TextButton")
        rightArrow.Name = "SpearTargetRight"
        rightArrow.Size = UDim2.new(0, 28, 0, 28)
        rightArrow.Position = UDim2.new(1, 34, 0.5, 0)
        rightArrow.AnchorPoint = Vector2.new(0.5, 0.5)
        rightArrow.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
        rightArrow.BackgroundTransparency = 0.15
        rightArrow.Text = ">"
        rightArrow.TextColor3 = Color3.fromRGB(150, 220, 255)
        rightArrow.TextSize = 16
        rightArrow.Font = Enum.Font.GothamBold
        rightArrow.ZIndex = 10
        rightArrow.Parent = SpearBtnData.Button
        Instance.new("UICorner", rightArrow).CornerRadius = UDim.new(1, 0)
        local rightStk = Instance.new("UIStroke", rightArrow)
        rightStk.Color = Color3.fromRGB(0, 170, 255)
        rightStk.Thickness = 1.5
        rightStk.Transparency = 0.3
        SpearBtnData.RightArrow = rightArrow
        rightArrow.MouseButton1Click:Connect(function() Spear_CycleTarget(1) end)
        SpearBtnData.Button.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if SpearBtnData.DragLocked then return end
                SpearBtnData.Dragging = true
                SpearBtnData.DragStart = input.Position
                SpearBtnData.DragStartPos = SpearBtnData.Button.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if SpearBtnData.Dragging and not SpearBtnData.DragLocked and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - SpearBtnData.DragStart
                SpearBtnData.Button.Position = UDim2.new(
                    SpearBtnData.DragStartPos.X.Scale, SpearBtnData.DragStartPos.X.Offset + delta.X,
                    SpearBtnData.DragStartPos.Y.Scale, SpearBtnData.DragStartPos.Y.Offset + delta.Y
                )
            end
        end)
        SpearBtnData.Button.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                SpearBtnData.Dragging = false
            end
        end)
        SpearBtnData.Button.MouseButton1Click:Connect(function()
            SpearBtnData.Active = not SpearBtnData.Active
            if SpearBtnData.Active then
                SpearBtnData.Button.BackgroundColor3 = Color3.fromRGB(10, 40, 10)
                SpearBtnData.Button.TextColor3 = Color3.fromRGB(80, 255, 120)
                spearStk.Color = Color3.fromRGB(80, 255, 120)
                PAZZHUB_Notify("Spear Aimbot", "Spear Aimbot AKTIF!", 3)
            else
                SpearBtnData.Button.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                SpearBtnData.Button.TextColor3 = Color3.fromRGB(0, 170, 255)
                spearStk.Color = Color3.fromRGB(0, 170, 255)
                PAZZHUB_Notify("Spear Aimbot", "Spear Aimbot NONAKTIF", 3)
            end
        end)
    end
    RunService.RenderStepped:Connect(function() pcall(Spear_UpdateAim) end)
    RunService.Heartbeat:Connect(function()
        if SpearBtnData and SpearBtnData.Button then
            local shouldShow = PAZZHUB.SPEAR_Aimbot and GetRole() == "Killer"
            SpearBtnData.Button.Visible = shouldShow
            if shouldShow then pcall(Spear_UpdateTargetLabel) end
        end
    end)
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        if PAZZHUB.SPEAR_Aimbot then pcall(Spear_SetupButton) end
    end)
    W.SpearAimbot_SetEnabled = function(v)
        PAZZHUB.SPEAR_Aimbot = v and true or false
        if v then SpearBtnData.Active = true; Spear_SetupButton()
        else
            if SpearBtnData.UI then pcall(function() SpearBtnData.UI:Destroy() end); SpearBtnData.UI = nil end
            SpearBtnData.Button = nil
        end
    end
    W.SpearAimbot_SetGravity = function(v) PAZZHUB.SPEAR_Gravity = tonumber(v) or 50 end
    W.SpearAimbot_SetSpeed   = function(v) PAZZHUB.SPEAR_Speed   = tonumber(v) or 100 end
    W.SpearAimbot_CycleTarget = Spear_CycleTarget
end

--=== KILLER ABILITIES SYSTEM ===
W.KillerAbilities = W.KillerAbilities or {
    AutoStalk = PAZZHUB.KA_AutoStalk, AutoStalkRange = PAZZHUB.KA_AutoStalkRange,
    AutoKillAll = PAZZHUB.KA_AutoKillAll, DropAllPallet = PAZZHUB.KA_DropAllPallet,
    BlockAllVault = PAZZHUB.KA_BlockAllVault,
}
local KA = W.KillerAbilities

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
    PAZZHUB.KA_AutoStalk = KA.AutoStalk
    if KA.AutoStalk then W.KA_StartAutoStalk() else W.KA_StopAutoStalk() end
end

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
    PAZZHUB.KA_AutoKillAll = KA.AutoKillAll
    if not KA.AutoKillAll then KillAllTarget = nil end
end

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
    PAZZHUB.KA_DropAllPallet = KA.DropAllPallet
end

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
    PAZZHUB.KA_BlockAllVault = KA.BlockAllVault
end

task.spawn(function()
    while true do
        task.wait(0.12)
        if KA.AutoKillAll then pcall(W.KA_UpdateKillAll) end
        if KA.DropAllPallet then pcall(W.KA_DropAllPallets) end
        if KA.BlockAllVault then pcall(W.KA_BlockAllVaults) end
        if PAZZHUB.KILLER_DestroyPallets then pcall(W.MAWWW_DestroyAllPallets) end
        pcall(W.PAZZHUB_UpdateInfiniteLunge)
    end
end)
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if KA.AutoStalk then pcall(W.KA_StartAutoStalk) end
end)

--=== AUTO HOOK ===
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
        if not PAZZHUB.KILLER_AutoHook then return end
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
            while PAZZHUB.KILLER_AutoHook do
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
        PAZZHUB.KILLER_AutoHook = v and true or false
        if PAZZHUB.KILLER_AutoHook then W.KA_StartAutoHook() else W.KA_StopAutoHook() end
    end
end

-- [PART 6f: KILLER — Killer Perks Display DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 6f: KILLER — Killer Perks Display (White Theme GUI)
--═══════════════════════════════════════════════════════════--

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
        return clean ~= "" and clean or "Unknown Perk"
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
        gui.Name = "PAZZHUBKillerPerksDisplay"
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
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local topBar = Instance.new("Frame", frame)
        topBar.Name = "TopBar"
        topBar.Size = UDim2.new(1, 0, 0, 3)
        topBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        topBar.BorderSizePixel = 0
        Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 8)

        local header = Instance.new("Frame", frame)
        header.Name = "Header"
        header.Size = UDim2.new(1, 0, 0, 22)
        header.Position = UDim2.new(0, 0, 0, 3)
        header.BackgroundTransparency = 1
        header.Active = true

        local title = Instance.new("TextLabel", header)
        title.Name = "Title"
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
        killerName.TextColor3 = Color3.fromRGB(0, 170, 255)
        killerName.TextSize = 9
        killerName.TextXAlignment = Enum.TextXAlignment.Right
        killerName.TextTruncate = Enum.TextTruncate.AtEnd
        killerName.Parent = header

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
        minBtn.Parent = header

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
        if killer and killer.Character then
            perks = ReadPerksFromChar(killer.Character)
        end

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

    W.KillerPerksDisplay_Start = Start
    W.KillerPerksDisplay_Stop = Stop
    W.KillerPerksDisplay_SetEnabled = function(v)
        PAZZHUB.KillerPerksDisplay = v and true or false
        if PAZZHUB.KillerPerksDisplay then Start() else Stop() end
    end
end

-- [PART 6g: KILLER — Silent Flask + Dash Lock DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 6g: KILLER — Silent Flask + Dash Lock
--═══════════════════════════════════════════════════════════--

--=== SILENT FLASK (THE CURE) ===
do
    PAZZHUB.FLASK_SilentAim    = PAZZHUB.FLASK_SilentAim    or false
    PAZZHUB.FLASK_ShowBeam     = PAZZHUB.FLASK_ShowBeam     ~= false
    PAZZHUB.FLASK_ShowLanding  = PAZZHUB.FLASK_ShowLanding  ~= false
    PAZZHUB.FLASK_Predict      = PAZZHUB.FLASK_Predict      ~= false
    PAZZHUB.FLASK_Speed        = PAZZHUB.FLASK_Speed        or 90
    PAZZHUB.FLASK_Gravity      = PAZZHUB.FLASK_Gravity      or 196
    PAZZHUB.FLASK_LeadMult     = PAZZHUB.FLASK_LeadMult     or 1.0
    PAZZHUB.FLASK_Range        = PAZZHUB.FLASK_Range        or 200
    PAZZHUB.FLASK_BeamColor    = PAZZHUB.FLASK_BeamColor    or Color3.fromRGB(0, 170, 255)
    PAZZHUB.FLASK_AccentColor  = PAZZHUB.FLASK_AccentColor  or Color3.fromRGB(25, 25, 25)
    local FlaskState = { Target = nil, PredictedPos = nil, BeamPart = nil, AccentPart = nil, LandingRing = nil }

    local function Flask_GetTarget()
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local maxR = tonumber(PAZZHUB.FLASK_Range) or 200
        local best, bd = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TeamIs(p, "Survivor") and p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and root then
                    local d = (root.Position - myRoot.Position).Magnitude
                    if d <= maxR and d < bd then
                        bd = d; best = { Player = p, Root = root, Char = p.Character }
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
        local speed   = tonumber(PAZZHUB.FLASK_Speed)   or 90
        local gravity = tonumber(PAZZHUB.FLASK_Gravity) or 196
        local lead    = tonumber(PAZZHUB.FLASK_LeadMult) or 1.0
        if not PAZZHUB.FLASK_Predict then return targetPos end
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
    local function Flask_ClearVisuals()
        if FlaskState.BeamPart then pcall(function() FlaskState.BeamPart:Destroy() end); FlaskState.BeamPart = nil end
        if FlaskState.AccentPart then pcall(function() FlaskState.AccentPart:Destroy() end); FlaskState.AccentPart = nil end
        if FlaskState.LandingRing then pcall(function() FlaskState.LandingRing:Destroy() end); FlaskState.LandingRing = nil end
    end
    local function Flask_HideVisuals()
        if FlaskState.BeamPart then FlaskState.BeamPart.Transparency = 1 end
        if FlaskState.AccentPart then FlaskState.AccentPart.Transparency = 1 end
        if FlaskState.LandingRing then FlaskState.LandingRing.Transparency = 1 end
    end
    local function Flask_EnsureBeamParts()
        if not FlaskState.BeamPart or not FlaskState.BeamPart.Parent then
            local beam = Instance.new("Part")
            beam.Name = "PAZZHUBFlaskBeam"
            beam.Anchored = true
            beam.CanCollide = false
            beam.CanTouch = false
            beam.CanQuery = false
            beam.CastShadow = false
            beam.Material = Enum.Material.Neon
            beam.Color = PAZZHUB.FLASK_BeamColor or Color3.fromRGB(0, 170, 255)
            beam.Transparency = 0.2
            beam.Parent = Workspace
            FlaskState.BeamPart = beam
        end
        if not FlaskState.AccentPart or not FlaskState.AccentPart.Parent then
            local accent = Instance.new("Part")
            accent.Name = "PAZZHUBFlaskBeamAccent"
            accent.Anchored = true
            accent.CanCollide = false
            accent.CanTouch = false
            accent.CanQuery = false
            accent.CastShadow = false
            accent.Material = Enum.Material.SmoothPlastic
            accent.Color = PAZZHUB.FLASK_AccentColor or Color3.fromRGB(25, 25, 25)
            accent.Transparency = 0.35
            accent.Parent = Workspace
            FlaskState.AccentPart = accent
        end
        if FlaskState.BeamPart then FlaskState.BeamPart.Color = PAZZHUB.FLASK_BeamColor or Color3.fromRGB(0, 170, 255) end
        if FlaskState.AccentPart then FlaskState.AccentPart.Color = PAZZHUB.FLASK_AccentColor or Color3.fromRGB(25, 25, 25) end
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
        if not PAZZHUB.FLASK_ShowLanding then
            if FlaskState.LandingRing then FlaskState.LandingRing.Transparency = 1 end
            return
        end
        if not FlaskState.LandingRing or not FlaskState.LandingRing.Parent then
            local ring = Instance.new("Part")
            ring.Name = "PAZZHUBFlaskLanding"
            ring.Shape = Enum.PartType.Cylinder
            ring.Anchored = true
            ring.CanCollide = false
            ring.CanTouch = false
            ring.CanQuery = false
            ring.CastShadow = false
            ring.Material = Enum.Material.Neon
            ring.Color = PAZZHUB.FLASK_BeamColor or Color3.fromRGB(0, 170, 255)
            ring.Size = Vector3.new(0.2, 5, 5)
            ring.Parent = Workspace
            FlaskState.LandingRing = ring
        end
        FlaskState.LandingRing.Color = PAZZHUB.FLASK_BeamColor or Color3.fromRGB(0, 170, 255)
        FlaskState.LandingRing.CFrame = CFrame.new(pos) * CFrame.Angles(0, 0, math.rad(90))
        FlaskState.LandingRing.Transparency = 0.35
    end
    RunService.RenderStepped:Connect(function()
        if not PAZZHUB.FLASK_SilentAim then
            Flask_HideVisuals()
            FlaskState.Target = nil
            FlaskState.PredictedPos = nil
            return
        end
        if GetRole() ~= "Killer" then Flask_HideVisuals(); return end
        local target = Flask_GetTarget()
        if not target or not target.Root then
            Flask_HideVisuals(); FlaskState.Target = nil; FlaskState.PredictedPos = nil; return
        end
        local hand = Flask_GetHandOrigin()
        if not hand then return end
        local landing = Flask_PredictLanding(hand.Position, target.Root)
        FlaskState.Target = target
        FlaskState.PredictedPos = landing
        if PAZZHUB.FLASK_ShowBeam then pcall(Flask_UpdateBeam, hand.Position, landing)
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
                   and PAZZHUB.FLASK_SilentAim
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
    W.Flask_SetEnabled = function(v) PAZZHUB.FLASK_SilentAim = v and true or false; if not v then Flask_ClearVisuals() end end
    W.Flask_SetBeamColor   = function(c) PAZZHUB.FLASK_BeamColor = c end
    W.Flask_SetAccentColor = function(c) PAZZHUB.FLASK_AccentColor = c end
    W.Flask_SetSpeed       = function(v) PAZZHUB.FLASK_Speed = tonumber(v) or 90 end
    W.Flask_SetGravity     = function(v) PAZZHUB.FLASK_Gravity = tonumber(v) or 196 end
    W.Flask_SetLead        = function(v) PAZZHUB.FLASK_LeadMult = tonumber(v) or 1.0 end
    W.Flask_SetRange       = function(v) PAZZHUB.FLASK_Range = tonumber(v) or 200 end
end

--=== DASH LOCK ===
do
    PAZZHUB.DashLockEnabled       = PAZZHUB.DashLockEnabled      or false
    PAZZHUB.DashLockDuration      = PAZZHUB.DashLockDuration     or 1.5
    PAZZHUB.DashLockSmoothness    = PAZZHUB.DashLockSmoothness   or 0.3
    PAZZHUB.FreezeDuringDashLock  = PAZZHUB.FreezeDuringDashLock or false
    PAZZHUB._DashLockActive       = false
    PAZZHUB._DashLockTarget       = nil
    PAZZHUB._DashLockConnection   = nil
    local DashAnimationId = "rbxassetid://98163597193511"
    local function DashLock_Update()
        if not PAZZHUB.DashLockEnabled or not PAZZHUB._DashLockActive then return end
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then PAZZHUB._DashLockTarget = nil; return end
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
        if not target then PAZZHUB._DashLockTarget = nil; return end
        PAZZHUB._DashLockTarget = target
        local cam = Workspace.CurrentCamera
        if cam then
            local smooth = PAZZHUB.DashLockSmoothness or 0.3
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Position), smooth)
        end
        if PAZZHUB.FreezeDuringDashLock then
            local hum = myChar:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= 0 then hum.WalkSpeed = 0 end
        end
    end
    local function DashLock_SetActive(active)
        active = active and true or false
        if active == PAZZHUB._DashLockActive then return end
        PAZZHUB._DashLockActive = active
        if active then
            if not PAZZHUB._DashLockConnection then
                PAZZHUB._DashLockConnection = RunService.RenderStepped:Connect(function() pcall(DashLock_Update) end)
            end
        else
            if PAZZHUB._DashLockConnection then
                pcall(function() PAZZHUB._DashLockConnection:Disconnect() end)
                PAZZHUB._DashLockConnection = nil
            end
            PAZZHUB._DashLockTarget = nil
            if PAZZHUB.FreezeDuringDashLock then
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
            if not PAZZHUB.DashLockEnabled then return end
            local aid = track.Animation and track.Animation.AnimationId or ""
            if aid == DashAnimationId then
                DashLock_SetActive(true)
                task.delay(PAZZHUB.DashLockDuration or 1.5, function() DashLock_SetActive(false) end)
            end
        end)
    end
    if LocalPlayer.Character then DashLock_HookCharacter(LocalPlayer.Character) end
    LocalPlayer.CharacterAdded:Connect(function(c)
        task.wait(0.5); DashLock_HookCharacter(c)
    end)
    W.DashLock_SetActive = DashLock_SetActive
    W.DashLock_SetEnabled = function(v)
        PAZZHUB.DashLockEnabled = v and true or false
        if not v then DashLock_SetActive(false) end
    end
end

-- [PART 7a: MISC — Stun Indicator + Invisibility DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 7a: MISC — Stun Indicator + Invisibility
--═══════════════════════════════════════════════════════════--

--=== STUN INDICATOR ===
W.StunSounds = W.StunSounds or {
    ["Default"]="18843924331",["Clash Royale"]="114072050006157",["Blash"]="89068385567682",
    ["Coin"]="75510526696824",["Kururin Kuru"]="119896940405402",["Spongebob"]="6835794541",
    ["Fahhhh"]="123562480982353",["Cave"]="3173566193",["Aughhh"]="9095205664",
    ["Samsung"]="6879335951",["iPhone"]="4203251375",["Siren"]="130677853589923",
}
W.StunIndicator = W.StunIndicator or {
    Enabled = false, Cache = {}, HeartbeatConn = nil, Range = 500,
    SoundEnabled = true, SoundId = "18843924331",
    SoundVolume = 1.5, SoundRange = 500, SelectedSound = "Default",
}
local SInd = W.StunIndicator
SInd.SelectedSound = SInd.SelectedSound or "Default"

local function SInd_GetActiveSoundId()
    local id = W.StunSounds[SInd.SelectedSound]
    if id then return id end
    return SInd.SoundId
end
local function SInd_IsStunned(char)
    if not char then return false end
    if char:GetAttribute("IsStunned") == true then return true end
    if char:GetAttribute("isStunned") == true then return true end
    if char:GetAttribute("Stunned") == true then return true end
    if char:GetAttribute("stunned") == true then return true end
    if char:GetAttribute("IsStun") == true then return true end
    if char:GetAttribute("Stun") == true then return true end
    local ci = char:FindFirstChild("CheckInterractable")
    if ci then
        if ci:GetAttribute("isStunned") == true then return true end
        if ci:GetAttribute("Stunned") == true then return true end
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local sv = hum:FindFirstChild("StunValue")
        if sv and sv.Value > 0 then return true end
    end
    return false
end
local function SInd_Remove(char)
    local data = SInd.Cache[char]
    if data then
        pcall(function()
            if data.StopAnim then data.StopAnim() end
            if data.Gui then data.Gui:Destroy() end
        end)
        SInd.Cache[char] = nil
    end
end
local function SInd_PlaySound(char)
    if not SInd.SoundEnabled then return end
    pcall(function()
        local head = char and char:FindFirstChild("Head")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local attachTo = head or hrp
        if not attachTo then return end
        local snd = Instance.new("Sound")
        snd.Name = "PAZZHUBStunSound"
        snd.SoundId = "rbxassetid://" .. tostring(SInd_GetActiveSoundId())
        snd.Volume = SInd.SoundVolume or 1.5
        snd.PlaybackSpeed = 1
        snd.RollOffMaxDistance = SInd.SoundRange or 500
        snd.RollOffMinDistance = 10
        snd.RollOffMode = Enum.RollOffMode.InverseTapered
        snd.Parent = attachTo
        snd:Play()
        snd.Ended:Connect(function() pcall(function() snd:Destroy() end) end)
        task.delay(5, function() pcall(function() if snd and snd.Parent then snd:Destroy() end end) end)
    end)
end
local function SInd_Create(char)
    if SInd.Cache[char] then return SInd.Cache[char] end
    local head = char:FindFirstChild("Head")
    if not head then return nil end
    local bbg = Instance.new("BillboardGui")
    bbg.Name = "PAZZHUBStunIndicator"
    bbg.Size = UDim2.fromOffset(140, 42)
    bbg.StudsOffset = Vector3.new(0, 3.0, 0)
    bbg.AlwaysOnTop = true
    bbg.LightInfluence = 0
    bbg.MaxDistance = 500
    bbg.Adornee = head
    bbg.Parent = char

    local pulse1 = Instance.new("Frame")
    pulse1.Name = "Pulse1"
    pulse1.AnchorPoint = Vector2.new(0.5, 0.5)
    pulse1.Position = UDim2.new(0.5, 0, 0.5, 0)
    pulse1.Size = UDim2.fromOffset(34, 34)
    pulse1.BackgroundTransparency = 1
    pulse1.BorderSizePixel = 0
    pulse1.ZIndex = 0
    pulse1.Parent = bbg
    Instance.new("UICorner", pulse1).CornerRadius = UDim.new(1, 0)
    local p1s = Instance.new("UIStroke", pulse1)
    p1s.Color = Color3.fromRGB(0, 170, 255)
    p1s.Thickness = 1.8
    p1s.Transparency = 0.3
    p1s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local pulse2 = Instance.new("Frame")
    pulse2.Name = "Pulse2"
    pulse2.AnchorPoint = Vector2.new(0.5, 0.5)
    pulse2.Position = UDim2.new(0.5, 0, 0.5, 0)
    pulse2.Size = UDim2.fromOffset(34, 34)
    pulse2.BackgroundTransparency = 1
    pulse2.BorderSizePixel = 0
    pulse2.ZIndex = 0
    pulse2.Parent = bbg
    Instance.new("UICorner", pulse2).CornerRadius = UDim.new(1, 0)
    local p2s = Instance.new("UIStroke", pulse2)
    p2s.Color = Color3.fromRGB(100, 200, 255)
    p2s.Thickness = 1.8
    p2s.Transparency = 0.4
    p2s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 140, 0, 34)
    main.Position = UDim2.new(0, 0, 0, 4)
    main.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
    main.BackgroundTransparency = 0.05
    main.BorderSizePixel = 0
    main.ZIndex = 1
    main.Parent = bbg
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 9)
    local bodyGrad = Instance.new("UIGradient")
    bodyGrad.Rotation = 135
    bodyGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(16, 24, 42)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 14, 26)),
    })
    bodyGrad.Parent = main
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Name = "MainStroke"
    mainStroke.Color = Color3.fromRGB(0, 170, 255)
    mainStroke.Thickness = 1.3
    mainStroke.Transparency = 0.15
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local iconHolder = Instance.new("Frame")
    iconHolder.Name = "IconHolder"
    iconHolder.Size = UDim2.fromOffset(24, 24)
    iconHolder.Position = UDim2.new(0, 5, 0.5, -12)
    iconHolder.BackgroundColor3 = Color3.fromRGB(16, 24, 42)
    iconHolder.BorderSizePixel = 0
    iconHolder.ZIndex = 3
    iconHolder.Parent = main
    Instance.new("UICorner", iconHolder).CornerRadius = UDim.new(1, 0)
    local iconGrad = Instance.new("UIGradient", iconHolder)
    iconGrad.Rotation = 135
    iconGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 45, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 20, 35)),
    })
    local iconStroke = Instance.new("UIStroke", iconHolder)
    iconStroke.Color = Color3.fromRGB(0, 170, 255)
    iconStroke.Thickness = 1
    iconStroke.Transparency = 0.25

    local starIcon = Instance.new("TextLabel")
    starIcon.Name = "StarIcon"
    starIcon.Size = UDim2.fromScale(1, 1)
    starIcon.BackgroundTransparency = 1
    starIcon.Font = Enum.Font.GothamBlack
    starIcon.Text = "★"
    starIcon.TextColor3 = Color3.fromRGB(0, 170, 255)
    starIcon.TextScaled = true
    starIcon.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    starIcon.TextStrokeTransparency = 0.5
    starIcon.ZIndex = 4
    starIcon.Parent = iconHolder

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -42, 0, 12)
    title.Position = UDim2.new(0, 34, 0, 4)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBlack
    title.Text = "STUNNED"
    title.TextColor3 = Color3.fromRGB(200, 230, 255)
    title.TextSize = 11
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    title.TextStrokeTransparency = 0.5
    title.ZIndex = 3
    title.Parent = main

    local sub = Instance.new("TextLabel")
    sub.Name = "Sub"
    sub.Size = UDim2.new(1, -42, 0, 8)
    sub.Position = UDim2.new(0, 34, 0, 18)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.GothamBold
    sub.Text = "SILENT"
    sub.TextColor3 = Color3.fromRGB(100, 180, 240)
    sub.TextSize = 7
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    sub.TextStrokeTransparency = 0.6
    sub.ZIndex = 3
    sub.Parent = main

    local accent = Instance.new("Frame")
    accent.Name = "Accent"
    accent.AnchorPoint = Vector2.new(1, 0.5)
    accent.Size = UDim2.fromOffset(2.5, 14)
    accent.Position = UDim2.new(1, -5, 0.5, 0)
    accent.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    accent.BorderSizePixel = 0
    accent.ZIndex = 3
    accent.Parent = main
    Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)

    main.Size = UDim2.new(0, 0, 0, 0)
    main.BackgroundTransparency = 1
    task.spawn(function()
        task.wait(0.02)
        TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 140, 0, 34),
            BackgroundTransparency = 0.05,
        }):Play()
    end)

    local animActive = true
    local function StopAnim() animActive = false end
    task.spawn(function()
        local t = 0
        while animActive and bbg.Parent and main.Parent do
            t = t + 0.05
            local pulse = (math.sin(t * 3) + 1) * 0.5
            mainStroke.Transparency = 0.35 - pulse * 0.2
            mainStroke.Thickness = 1.2 + pulse * 0.3
            starIcon.Rotation = math.sin(t * 2) * 10
            local p1 = (t * 0.55) % 1
            pulse1.Size = UDim2.fromOffset(34 + p1 * 40, 34 + p1 * 40)
            p1s.Transparency = 0.15 + p1 * 0.75
            local p2 = ((t * 0.55) + 0.5) % 1
            pulse2.Size = UDim2.fromOffset(34 + p2 * 40, 34 + p2 * 40)
            p2s.Transparency = 0.15 + p2 * 0.75
            task.wait(0.03)
        end
    end)

    local function ExitAndDestroy()
        animActive = false
        TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
        }):Play()
        task.delay(0.28, function() pcall(function() bbg:Destroy() end) end)
    end

    SInd.Cache[char] = { Gui = bbg, Main = main, StopAnim = StopAnim, Exit = ExitAndDestroy }
    return SInd.Cache[char]
end

function W.SInd_SetEnabled(v)
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
                        local data = SInd.Cache[char]
                        local wasStunned = data ~= nil
                        if stunned and dist <= SInd.Range then
                            if not wasStunned then SInd_PlaySound(char); SInd_Create(char) end
                        else
                            if wasStunned then
                                if data.Exit then data.Exit() else SInd_Remove(char) end
                                SInd.Cache[char] = nil
                            end
                        end
                    end
                end
            end
        end)
    else
        if SInd.HeartbeatConn then SInd.HeartbeatConn:Disconnect(); SInd.HeartbeatConn = nil end
        for _, data in pairs(SInd.Cache) do
            pcall(function()
                if data.StopAnim then data.StopAnim() end
                if data.Gui then data.Gui:Destroy() end
            end)
        end
        SInd.Cache = {}
    end
end
W.SInd_GetSoundId = SInd_GetActiveSoundId

--=== INVISIBILITY (MengHub API) ===
do
    local MV = getgenv().PAZZHUBInvis
    if not MV then
        MV = {
            Enabled = false, Loading = false, Ready = false, API = nil,
            _lastToggle = 0, _retries = 0, _retryMax = 3,
            _retryDelay = 2, _queueState = nil,
        }
        getgenv().PAZZHUBInvis = MV
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
        if getgenv().PAZZHUB_InvisBtn_UpdateVisual then
            pcall(getgenv().PAZZHUB_InvisBtn_UpdateVisual)
        end
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
            local ok, err = pcall(function()
                loadstring(game:HttpGet(INVIS_URL))()
            end)
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
                PAZZHUB_Notify("Invisible", "Loading API...", 2)
                MV._queueState = state
            else
                PAZZHUB_Notify("Invisible", "API gagal, retry...", 2)
                MV._queueState = state
                task.spawn(function()
                    if Invis_LoadAPI() then
                        local q = MV._queueState
                        MV._queueState = nil
                        if q ~= nil then
                            task.defer(function() W.Invisible_SetState(q, fromButton) end)
                        end
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
        PAZZHUB.Invis_Enabled = state
        if state then
            local ok, err = pcall(function() MV.API.enable() end)
            if not ok then
                MV.Enabled = false
                PAZZHUB.Invis_Enabled = false
                Invis_Cleanup()
                if not fromButton then PAZZHUB_Notify("Invisible", "Gagal enable", 2) end
            else
                if not fromButton then PAZZHUB_Notify("Invisible", "Invisible AKTIF", 2) end
            end
        else
            pcall(function() MV.API.disable() end)
            Invis_Cleanup()
            if not fromButton then PAZZHUB_Notify("Invisible", "Invisible Nonaktif", 2) end
        end
        Invis_RefreshButton()
    end
    function W.Invisible_SetEnabled(v)  W.Invisible_SetState(v and true or false, false) end
    function W.Invisible_Start()        W.Invisible_SetState(true, false)  end
    function W.Invisible_Stop()         W.Invisible_SetState(false, false) end
    function W.Invisible_Toggle()       W.Invisible_SetState(not MV.Enabled, false) end
    function W.Invisible_SetHotkey(kc)
        if kc and typeof(kc) == "EnumItem" then
            PAZZHUB.Invis_Hotkey = kc.Name
        elseif type(kc) == "string" then
            PAZZHUB.Invis_Hotkey = kc
        end
    end
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        local hkName = PAZZHUB.Invis_Hotkey or "G"
        local hk = Enum.KeyCode[hkName]
        if hk and input.KeyCode == hk then
            W.Invisible_SetState(not MV.Enabled, false)
        end
    end)
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1.2)
        if MV.Enabled and MV.API then
            pcall(function() MV.API.enable() end)
            Invis_RefreshButton()
        end
    end)
    W.Invisible_IsOn = function() return MV.Enabled end
end

-- [PART 7b: MISC — Player Utility + Speed Boost + Cursor DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 7b: MISC — Player Utility + Speed Boost + Cursor
--═══════════════════════════════════════════════════════════--

--=== PLAYER UTILITY ===
local PU = {
    SpeedEnabled = false, SpeedValue = 16,
    SkipEndScreen = false, ShiftLock = false, NoCutscene = false,
    HideSurvivorIcon = false, ShowPingFPS = false, HideName = false,
    UnlimitedZoom = false, Noclip = false,
    _Connections = {}, _FPS = { frames = 0, last = tick(), value = 0, ping = 0 },
    _origIcons = {}, _pingGui = nil, _shiftLockWasActive = false,
    _noCutsceneHooked = false, _hideNameConn = nil, _origCanCollide = {},
}
W.PU = PU

table.insert(PU._Connections, RunService.Heartbeat:Connect(function()
    if not PU.SpeedEnabled then return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and hum.WalkSpeed ~= PU.SpeedValue then hum.WalkSpeed = PU.SpeedValue end
end))

local function PU_ShowInstantResults()
    if not PU.SkipEndScreen then return end
    pcall(function()
        local cam = workspace.CurrentCamera
        if cam then cam.CameraType = Enum.CameraType.Custom; cam.FieldOfView = 70 end
        UserInputService.MouseIconEnabled = true
        LocalPlayer:SetAttribute("isspectating", true)
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if pg then
            local Results  = pg:FindFirstChild("Results")
            local EndScreen= pg:FindFirstChild("EndScreen")
            local Darkness = pg:FindFirstChild("Darkness")
            if Results then Results.Enabled = true end
            if EndScreen then
                EndScreen.Enabled = true
                local bo = EndScreen:FindFirstChild("blackout")
                if bo then bo.BackgroundTransparency = 1 end
            end
            if Darkness then
                Darkness.Enabled = true
                local f2 = Darkness:FindFirstChild("Frame2")
                if f2 then f2.BackgroundTransparency = 1 end
            end
        end
    end)
end
task.spawn(function()
    local gf = ReplicatedStorage:WaitForChild("Remotes", 10)
    gf = gf and gf:WaitForChild("Game", 10)
    if not gf then return end
    for _, n in ipairs({"endscreencutscene","cutsceneEnd","cutsceneEnd2","cutsceneEndwithownchar"}) do
        local ev = gf:FindFirstChild(n)
        if ev and ev:IsA("RemoteEvent") then
            table.insert(PU._Connections, ev.OnClientEvent:Connect(PU_ShowInstantResults))
        end
    end
end)

table.insert(PU._Connections, RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum  = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local cam  = workspace.CurrentCamera
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
end))

local function PU_SetupNoCutsceneHook()
    if PU._noCutsceneHooked then return end
    PU._noCutsceneHooked = true
    pcall(function()
        local mt = getrawmetatable(game)
        if not mt then return end
        if setreadonly then setreadonly(mt, false) end
        local oldIndex = mt.__index
        local fakeBindable = Instance.new("BindableEvent")
        local fakeRemote   = Instance.new("RemoteEvent")
        mt.__index = newcclosure(function(t, k)
            if PU.NoCutscene and not checkcaller() and typeof(t) == "Instance" then
                local nm = t.Name
                if nm == "cutscene" and k == "Event" then
                    local p = t.Parent
                    if p and p.Name == "Game" then return fakeBindable.Event end
                elseif nm == "cutsceneEnd" or nm == "cutsceneEnd2"
                    or nm == "cutsceneEndwithownchar" or nm == "endscreencutscene" then
                    local p = t.Parent
                    if p and p.Name == "Game" then return fakeRemote.OnClientEvent end
                end
            end
            return oldIndex(t, k)
        end)
        if setreadonly then setreadonly(mt, true) end
    end)
end
task.spawn(PU_SetupNoCutsceneHook)

local function PU_ApplyHideSurvivorIcon()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return end
    for _, gui in ipairs(pg:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name:match("%-mob$") then
            local frame = gui:FindFirstChild("Frame")
            if frame then
                for i = 1, 5 do
                    local sf = frame:FindFirstChild("Survivor" .. i)
                    if sf then
                        local il = sf:FindFirstChild("ImageLabel")
                        local tl = sf:FindFirstChild("TextLabel")
                        if il and il:IsA("ImageLabel") then
                            if not PU._origIcons[il] then
                                PU._origIcons[il] = { Image = il.Image, ImageTransparency = il.ImageTransparency }
                            end
                            il.Image = "rbxassetid://72845574620852"
                            il.ImageTransparency = 0
                        end
                        if tl and tl:IsA("TextLabel") then
                            if not PU._origIcons[tl] then
                                PU._origIcons[tl] = { Text = tl.Text, TextTransparency = tl.TextTransparency }
                            end
                            tl.Text = "PAZZHUB"
                            tl.TextTransparency = 0
                        end
                    end
                end
            end
        end
    end
end
local function PU_RestoreSurvivorIcon()
    for obj, data in pairs(PU._origIcons) do
        if obj and obj.Parent then
            pcall(function()
                if data.Image ~= nil and obj:IsA("ImageLabel") then
                    obj.Image = data.Image
                    obj.ImageTransparency = data.ImageTransparency
                end
                if data.Text ~= nil and obj:IsA("TextLabel") then
                    obj.Text = data.Text
                    obj.TextTransparency = data.TextTransparency
                end
            end)
        end
    end
    PU._origIcons = {}
end
table.insert(PU._Connections, RunService.Heartbeat:Connect(function()
    if PU.HideSurvivorIcon then PU_ApplyHideSurvivorIcon() end
end))

local function PU_CreatePingFPS()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return end
    if PU._pingGui and PU._pingGui.Parent then return end
    local old = pg:FindFirstChild("PAZZHUBPU_PingFPS")
    if old then old:Destroy() end
    local sg = Instance.new("ScreenGui")
    sg.Name = "PAZZHUBPU_PingFPS"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.Parent = pg
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(120, 44)
    frame.Position = UDim2.new(0, 12, 0, 120)
    frame.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Parent = sg
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(0, 170, 255)
    stroke.Thickness = 1
    local lbl = Instance.new("TextLabel")
    lbl.Name = "Label"
    lbl.Size = UDim2.new(1, -12, 1, -8)
    lbl.Position = UDim2.new(0, 6, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextColor3 = Color3.fromRGB(200, 230, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextYAlignment = Enum.TextYAlignment.Center
    lbl.Text = "PING: --ms\nFPS: --"
    lbl.Parent = frame
    PU._pingGui = sg
end
local function PU_GetPing()
    local ok, val = pcall(function()
        local stats = game:GetService("Stats")
        local net = stats and stats:FindFirstChild("Network")
        local sv = net and net:FindFirstChild("ServerStatsItem")
        local dp = sv and sv:FindFirstChild("Data Ping")
        if dp and dp.GetValue then return math.floor(dp:GetValue() + 0.5) end
    end)
    if ok and val then return val end
    return nil
end
table.insert(PU._Connections, RunService.RenderStepped:Connect(function()
    if not PU.ShowPingFPS then return end
    PU._FPS.frames = PU._FPS.frames + 1
    local now = tick()
    if now - PU._FPS.last < 0.5 then return end
    PU._FPS.value = math.floor(PU._FPS.frames / (now - PU._FPS.last) + 0.5)
    PU._FPS.ping = PU_GetPing() or 0
    PU._FPS.frames = 0
    PU._FPS.last = now
    if not (PU._pingGui and PU._pingGui.Parent) then PU_CreatePingFPS() end
    local lbl = PU._pingGui and PU._pingGui:FindFirstChild("Label", true)
    if lbl then
        lbl.Text = ("PING: %sms\nFPS: %d"):format(
            PU._FPS.ping > 0 and tostring(PU._FPS.ping) or "--",
            PU._FPS.value
        )
    end
end))

local function PU_ProcessHideName(obj)
    if not obj then return end
    local ok, isText = pcall(function()
        return obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")
    end)
    if not ok or not isText then return end
    local txt = ""
    pcall(function() txt = tostring(obj.Text or "") end)
    if txt == "" then return end
    if txt == LocalPlayer.Name or txt == LocalPlayer.DisplayName
        or txt:find(LocalPlayer.Name, 1, true) ~= nil then
        pcall(function() obj.Visible = not PU.HideName end)
    end
end
local function PU_SetHideName(enabled)
    PU.HideName = enabled and true or false
    if PU._hideNameConn then
        pcall(function() PU._hideNameConn:Disconnect() end)
        PU._hideNameConn = nil
    end
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not pg then return end
    for _, d in ipairs(pg:GetDescendants()) do PU_ProcessHideName(d) end
    if PU.HideName then
        PU._hideNameConn = pg.DescendantAdded:Connect(function(obj)
            task.defer(PU_ProcessHideName, obj)
        end)
    end
end
W.PU_SetHideName = PU_SetHideName

table.insert(PU._Connections, RunService.RenderStepped:Connect(function()
    if not PU.UnlimitedZoom then return end
    if LocalPlayer.CameraMaxZoomDistance ~= math.huge then LocalPlayer.CameraMaxZoomDistance = math.huge end
    if LocalPlayer.CameraMinZoomDistance ~= 0 then LocalPlayer.CameraMinZoomDistance = 0 end
end))

table.insert(PU._Connections, RunService.Stepped:Connect(function()
    if not PU.Noclip then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            if PU._origCanCollide[d] == nil then PU._origCanCollide[d] = d.CanCollide end
            d.CanCollide = false
        end
    end
end))
local function PU_RestoreNoclip()
    for part, cc in pairs(PU._origCanCollide) do
        if part and part.Parent then pcall(function() part.CanCollide = cc end) end
    end
    PU._origCanCollide = {}
end
W.PU_RestoreNoclip = PU_RestoreNoclip
LocalPlayer.CharacterRemoving:Connect(function(char)
    if char == LocalPlayer.Character then PU._origCanCollide = {} end
end)

--=== SPEED BOOST ===
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
                        if id and W.KillerAttackAnims and W.KillerAttackAnims[id] then return true end
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
    function W.SpeedBoost_SetEnabled(v)
        PAZZHUB.SpeedBoostEnabled = v and true or false
        if SpeedBoostConnection then SpeedBoostConnection:Disconnect(); SpeedBoostConnection = nil end
        if not PAZZHUB.SpeedBoostEnabled then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then pcall(function() hum.WalkSpeed = 16 end) end
            return
        end
        SpeedBoostConnection = RunService.Heartbeat:Connect(function()
            if not PAZZHUB.SpeedBoostEnabled then return end
            if ShouldDisableSpeedBoost() then return end
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= PAZZHUB.SpeedBoostValue then
                pcall(function() hum.WalkSpeed = PAZZHUB.SpeedBoostValue end)
            end
        end)
    end
    function W.SpeedBoost_SetValue(v)
        PAZZHUB.SpeedBoostValue = tonumber(v) or 30
    end
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.8)
        if PAZZHUB.SpeedBoostEnabled then W.SpeedBoost_SetEnabled(true) end
    end)
end

--=== CURSOR FEATURE ===
do
    local CursorThread = nil
    local savedOriginal = { MouseIconEnabled = nil, MouseBehavior = nil, AutoRotate = nil }

    function W.Cursor_SetEnabled(v)
        PAZZHUB.CursorEnabled = v and true or false
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
                while PAZZHUB.CursorEnabled do
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
            PAZZHUB.CursorEnabled = false
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
            W.Cursor_SetEnabled(not PAZZHUB.CursorEnabled)
        end
    end)
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if PAZZHUB.CursorEnabled then W.Cursor_SetEnabled(true) end
    end)
end

-- [PART 7c: MISC — Emote + Fake Avatar + Korless + Header + Spectator + Jerk Off DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 7c: MISC — Emote + Fake Avatar + Korless + Header + Spectator + Jerk Off
--═══════════════════════════════════════════════════════════--

--=== EMOTE SYSTEM ===
W.EmoteSystem = W.EmoteSystem or {
    Enabled = false, CurrentTrack = nil, CurrentSound = nil,
    SelectedEmote = "Friday Night",
    Options = {
        "Friday Night", "WarCry", "24 Hour Cinderella", "Applause",
        "Arm Swing", "Backflip", "California Girls", "Christmas Spirit",
        "Floating Rest", "Ghoul", "Griddy", "Kyoufuu", "OnePlays", "Vulnerable",
    },
    Data = {
        ["Friday Night"]        = { Anim = "rbxassetid://83229063951016",  Sound = "rbxassetid://85355610204255" },
        ["WarCry"]              = { Anim = "rbxassetid://82600868380136",  Sound = "rbxassetid://120101930689931" },
        ["24 Hour Cinderella"]  = { Anim = "rbxassetid://137195203725366", Sound = "rbxassetid://121099446613414" },
        ["Applause"]            = { Anim = "rbxassetid://96328361165090",  Sound = "rbxassetid://115490787020749" },
        ["Arm Swing"]           = { Anim = "rbxassetid://80552139463944",  Sound = "rbxassetid://74216458932348" },
        ["Backflip"]            = { Anim = "rbxassetid://74705617908505",  Sound = nil },
        ["California Girls"]    = { Anim = "rbxassetid://123552803041504", Sound = "rbxassetid://87899327891544" },
        ["Christmas Spirit"]    = { Anim = "rbxassetid://137859761110514", Sound = nil },
        ["Floating Rest"]       = { Anim = "rbxassetid://114593021219597", Sound = nil },
        ["Ghoul"]               = { Anim = "rbxassetid://130415594909401", Sound = "rbxassetid://123004139176580" },
        ["Griddy"]              = { Anim = "rbxassetid://75586690784894",  Sound = nil },
        ["Kyoufuu"]             = { Anim = "rbxassetid://137322894494527", Sound = "rbxassetid://129064643026442" },
        ["OnePlays"]            = { Anim = "rbxassetid://140625405103474", Sound = "rbxassetid://94749073728335" },
        ["Vulnerable"]          = { Anim = "rbxassetid://121773684313913", Sound = "rbxassetid://135265751184744" },
    },
}
local ES = W.EmoteSystem
function W.EmoteSystem_Stop()
    if ES.CurrentTrack then pcall(function() ES.CurrentTrack:Stop() end); ES.CurrentTrack = nil end
    if ES.CurrentSound then pcall(function() ES.CurrentSound:Destroy() end); ES.CurrentSound = nil end
end
function W.EmoteSystem_Play()
    W.EmoteSystem_Stop()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end
    local data = ES.Data[ES.SelectedEmote]
    if not data then return end
    if data.Anim then
        local anim = Instance.new("Animation")
        anim.AnimationId = data.Anim
        local track = hum:LoadAnimation(anim)
        track.Looped = true
        track.Priority = Enum.AnimationPriority.Action
        track:Play()
        ES.CurrentTrack = track
    end
    if data.Sound then
        local snd = Instance.new("Sound")
        snd.SoundId = data.Sound
        snd.Looped = true
        snd.Volume = 2
        snd.Parent = hrp
        snd:Play()
        ES.CurrentSound = snd
    end
end
function W.EmoteSystem_SetEnabled(v)
    ES.Enabled = v and true or false
    if ES.Enabled then W.EmoteSystem_Play() else W.EmoteSystem_Stop() end
end
function W.EmoteSystem_SelectEmote(name)
    if ES.Data[name] then
        ES.SelectedEmote = name
        if ES.Enabled then W.EmoteSystem_Play() end
    end
end
LocalPlayer.CharacterRemoving:Connect(function() W.EmoteSystem_Stop() end)
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if ES.Enabled then W.EmoteSystem_Play() end
end)

--=== FAKE AVATAR ===
do
    local FakeAvatarState = { Enabled = false, UserId = LocalPlayer.UserId }
    local function LoadAppearanceIntoChar(appearance, character, head)
        local items = appearance:GetChildren()
        local function applyMesh(obj)
            if obj:IsA("CharacterMesh") or obj:IsA("BodyColors") or obj:IsA("Shirt") or obj:IsA("Pants") then
                local existing = character:FindFirstChild(obj.Name)
                if existing and existing.ClassName == obj.ClassName then existing:Destroy() end
                obj:Clone().Parent = character
            end
        end
        for _, item in pairs(items) do
            if item:IsA("Folder") or item:IsA("Model") then
                for _, subItem in pairs(item:GetChildren()) do applyMesh(subItem) end
            else applyMesh(item) end
        end
        for _, item in pairs(items) do
            if item:IsA("SpecialMesh") and head then
                local targetMesh = head:FindFirstChildOfClass("SpecialMesh") or Instance.new("SpecialMesh", head)
                targetMesh.MeshType = Enum.MeshType.FileMesh
                targetMesh.MeshId = item.MeshId
                targetMesh.TextureId = item.TextureId
            elseif item:IsA("Decal") and item.Name == "face" and head then
                if head:FindFirstChild("face") then head.face:Destroy() end
                item:Clone().Parent = head
            end
        end
        for _, item in pairs(items) do
            if item:IsA("Accessory") then
                local clone = item:Clone()
                local handle = clone:FindFirstChild("Handle")
                if handle then
                    local att = handle:FindFirstChildOfClass("Attachment")
                    if att then
                        local targetAtt = character:FindFirstChild(att.Name, true)
                        if targetAtt then
                            local weld = Instance.new("Weld")
                            weld.Part0 = handle; weld.Part1 = targetAtt.Parent
                            weld.C0 = att.CFrame; weld.C1 = targetAtt.CFrame
                            weld.Parent = handle
                        end
                    end
                    handle.CanCollide = false; handle.Massless = true; clone.Parent = character
                end
            end
        end
    end
    local function ApplyFakeAvatar()
        local character = LocalPlayer.Character
        if not character or not FakeAvatarState.UserId then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        task.spawn(function()
            local success, appearance = pcall(function()
                return game:GetService("Players"):GetCharacterAppearanceAsync(FakeAvatarState.UserId)
            end)
            if not success or not appearance then warn("[PAZZHUB] FakeAvatar: Gagal load!"); return end
            for _, obj in pairs(character:GetChildren()) do
                if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants")
                or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") or obj:IsA("ShirtGraphic") then
                    obj:Destroy()
                end
            end
            local head = character:FindFirstChild("Head")
            if head then
                for _, hObj in pairs(head:GetChildren()) do
                    if hObj:IsA("SpecialMesh") or hObj:IsA("Decal") then hObj:Destroy() end
                end
                local m = Instance.new("SpecialMesh", head)
                m.MeshType = Enum.MeshType.Head; m.Scale = Vector3.new(1, 1, 1)
            end
            local scaleDefaults = { BodyDepthScale = 1, BodyHeightScale = 1, BodyWidthScale = 1, HeadScale = 1, BodyTypeScale = 0, BodyProportionScale = 0 }
            for scaleName, val in pairs(scaleDefaults) do
                local s = humanoid:FindFirstChild(scaleName); if s then s.Value = val end
            end
            task.wait(0.1)
            LoadAppearanceIntoChar(appearance, character, head)
            pcall(function()
                local info = game:GetService("Players"):GetCharacterAppearanceInfoAsync(FakeAvatarState.UserId)
                if head and info.assets then
                    for _, asset in pairs(info.assets) do
                        if asset.assetType.name == "Face" then
                            if head:FindFirstChild("face") then head.face:Destroy() end
                            local f = Instance.new("Decal", head)
                            f.Name = "face"; f.Texture = "rbxassetid://" .. asset.id
                            break
                        end
                    end
                end
            end)
        end)
    end
    function W.FakeAvatar_Set(v)
        FakeAvatarState.Enabled = v and true or false
        if v then ApplyFakeAvatar() end
    end
    function W.FakeAvatar_SetId(id)
        FakeAvatarState.UserId = tonumber(id) or LocalPlayer.UserId
        if FakeAvatarState.Enabled then ApplyFakeAvatar() end
    end
    function W.FakeAvatar_FromUsername(username)
        if not username or username == "" then return end
        local ok, userId = pcall(function() return game:GetService("Players"):GetUserIdFromNameAsync(username) end)
        if ok and userId then
            FakeAvatarState.UserId = userId
            ApplyFakeAvatar()
            PAZZHUB_Notify("Fake Avatar", "Applied: @" .. username, 2)
        else
            PAZZHUB_Notify("Fake Avatar", "Username tidak ditemukan", 2)
        end
    end
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if FakeAvatarState.Enabled then ApplyFakeAvatar() end
    end)
end

--=== FAKE KORLESS MORPH ===
do
    local KorlessMorph = { Enabled = false, Connection = nil }
    local function ApplyKorless()
        local plr = LocalPlayer
        local function Morph()
            repeat task.wait() until plr.Character
                and plr.Character:FindFirstChild("HumanoidRootPart")
                and plr.Character:FindFirstChild("Right Leg")
            task.wait(0.1)
            local char = plr.Character
            pcall(function()
                char.Head.Transparency = 1
                local face = char.Head:FindFirstChild("face")
                if face then face:Destroy() end
                char["Right Leg"].Transparency = 1
                local old = char:FindFirstChild("KorlessHead")
                if old then old:Destroy() end
                local mesh = Instance.new("MeshPart")
                mesh.Name = "KorlessHead"
                mesh.Size = Vector3.new(1.5, 1.5, 1.5)
                mesh.CanCollide = false
                mesh.MeshId = "rbxassetid://902942096"
                mesh.TextureID = "rbxassetid://902843398"
                mesh.CFrame = char["Right Leg"].CFrame * CFrame.new(0, 0.5, 0)
                mesh.Parent = char
                local weld = Instance.new("WeldConstraint")
                weld.Part0 = char["Right Leg"]
                weld.Part1 = mesh
                weld.Parent = mesh
            end)
        end
        Morph()
        if KorlessMorph.Connection then KorlessMorph.Connection:Disconnect() end
        KorlessMorph.Connection = plr.CharacterAdded:Connect(function()
            task.wait(1)
            Morph()
        end)
    end
    local function RemoveKorless()
        local char = LocalPlayer.Character
        if char then
            local mesh = char:FindFirstChild("KorlessHead")
            if mesh then mesh:Destroy() end
            if char:FindFirstChild("Head") then char.Head.Transparency = 0 end
            if char:FindFirstChild("Right Leg") then char["Right Leg"].Transparency = 0 end
        end
        if KorlessMorph.Connection then
            KorlessMorph.Connection:Disconnect()
            KorlessMorph.Connection = nil
        end
    end
    function W.Korless_Set(v)
        KorlessMorph.Enabled = v
        if v then ApplyKorless() else RemoveKorless() end
    end
end

--=== HEADER TITLE ===
do
    local HeaderState = {
        Enabled = false, Text = "PAZZHUB",
        Billboard = nil, TextLabel = nil, ShineLabel = nil, ShineGradient = nil, SizeConnection = nil,
    }
    local BASE_WIDTH = isMobile and 90 or 140
    local BASE_HEIGHT = isMobile and 20 or 32
    local BASE_DISTANCE = 12
    local MIN_SCALE = 0.6
    local MAX_SCALE = isMobile and 1.1 or 1.4
    local function Header_Create()
        if HeaderState.Billboard then HeaderState.Billboard:Destroy() end
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        if not character:FindFirstChild("Head") then return end
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "PAZZHUBHeaderBillboard"
        billboard.Adornee = character.Head
        billboard.Size = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT)
        billboard.StudsOffset = Vector3.new(0, 1.5, 0)
        billboard.AlwaysOnTop = true; billboard.LightInfluence = 0
        billboard.Parent = character
        HeaderState.Billboard = billboard
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "BaseText"; textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1; textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamBold; textLabel.TextStrokeTransparency = 0.5
        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.Text = HeaderState.Text; textLabel.ZIndex = 1; textLabel.Parent = billboard
        HeaderState.TextLabel = textLabel
        local shineLabel = Instance.new("TextLabel")
        shineLabel.Name = "ShineText"; shineLabel.Size = UDim2.new(1, 0, 1, 0)
        shineLabel.BackgroundTransparency = 1; shineLabel.TextScaled = true
        shineLabel.Font = Enum.Font.GothamBold; shineLabel.TextStrokeTransparency = 1
        shineLabel.Text = HeaderState.Text; shineLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
        shineLabel.ZIndex = 2; shineLabel.Parent = billboard
        HeaderState.ShineLabel = shineLabel
        local shineGradient = Instance.new("UIGradient")
        shineGradient.Name = "ShineGradient"; shineGradient.Rotation = 20
        shineGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.30, 1),
            NumberSequenceKeypoint.new(0.42, 0), NumberSequenceKeypoint.new(0.58, 0),
            NumberSequenceKeypoint.new(0.70, 1), NumberSequenceKeypoint.new(1.00, 1),
        })
        shineGradient.Offset = Vector2.new(-1, 0); shineGradient.Parent = shineLabel
        HeaderState.ShineGradient = shineGradient
        if HeaderState.SizeConnection then HeaderState.SizeConnection:Disconnect() end
        HeaderState.SizeConnection = RunService.RenderStepped:Connect(function()
            if not billboard or not billboard.Parent then HeaderState.SizeConnection:Disconnect(); return end
            local head = character:FindFirstChild("Head"); if not head then return end
            local dist = (Workspace.CurrentCamera.CFrame.Position - head.Position).Magnitude
            local scaleFactor = math.clamp(BASE_DISTANCE / dist, MIN_SCALE, MAX_SCALE)
            billboard.Size = UDim2.new(0, BASE_WIDTH * scaleFactor, 0, BASE_HEIGHT * scaleFactor)
        end)
        task.spawn(function()
            while shineLabel and shineLabel.Parent and shineGradient and shineGradient.Parent do
                shineGradient.Offset = Vector2.new(-1, 0)
                local tween = TweenService:Create(shineGradient, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Offset = Vector2.new(1, 0) })
                tween:Play(); tween.Completed:Wait(); task.wait(2)
            end
        end)
    end
    function W.Header_SetText(text)
        HeaderState.Text = text or "PAZZHUB"
        if HeaderState.TextLabel then HeaderState.TextLabel.Text = HeaderState.Text end
        if HeaderState.ShineLabel then HeaderState.ShineLabel.Text = HeaderState.Text end
    end
    function W.Header_Set(enabled)
        HeaderState.Enabled = enabled and true or false
        if enabled then Header_Create()
        else
            if HeaderState.SizeConnection then HeaderState.SizeConnection:Disconnect(); HeaderState.SizeConnection = nil end
            if HeaderState.Billboard then HeaderState.Billboard:Destroy() end
            HeaderState.Billboard = nil; HeaderState.TextLabel = nil
            HeaderState.ShineLabel = nil; HeaderState.ShineGradient = nil
        end
    end
    function W.Header_SetColor(c)
        if HeaderState.TextLabel then HeaderState.TextLabel.TextColor3 = c end
    end
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if HeaderState.Enabled then W.Header_Set(true) end
    end)
end

--=== SPECTATOR COUNTER ===
do
    local SpecState = { Enabled = false, Gui = nil, Label = nil, Thread = nil, Expanded = true }
    local function Spec_CreateUI()
        if SpecState.Gui then SpecState.Gui:Destroy(); SpecState.Gui = nil end
        SpecState.Gui = Instance.new("ScreenGui")
        SpecState.Gui.Name = "PAZZHUBSpectatorCounter"
        SpecState.Gui.ResetOnSpawn = false; SpecState.Gui.IgnoreGuiInset = true
        SpecState.Gui.Parent = CoreGui
        local mainFrame = Instance.new("Frame", SpecState.Gui)
        mainFrame.Name = "MainBox"
        mainFrame.AnchorPoint = Vector2.new(0.5, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.42, 0)
        mainFrame.Size = UDim2.new(0, 145, 0, 52)
        mainFrame.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        mainFrame.BackgroundTransparency = 0.1
        mainFrame.BorderSizePixel = 0; mainFrame.Active = true
        Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)
        local topBar = Instance.new("Frame", mainFrame)
        topBar.Name = "TopBar"; topBar.Size = UDim2.new(1, 0, 0, 4)
        topBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255); topBar.BorderSizePixel = 0
        Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 6)
        local header = Instance.new("Frame", mainFrame)
        header.Name = "Header"; header.Size = UDim2.new(1, 0, 0, 18)
        header.Position = UDim2.new(0, 0, 0, 4)
        header.BackgroundTransparency = 1; header.Active = true
        local title = Instance.new("TextLabel", header)
        title.Name = "Title"; title.Size = UDim2.new(1, -20, 1, 0)
        title.BackgroundTransparency = 1; title.Font = Enum.Font.GothamBold
        title.Text = "Spectators"; title.TextColor3 = Color3.fromRGB(200, 230, 255)
        title.TextSize = 10; title.TextXAlignment = Enum.TextXAlignment.Center
        local minBtn = Instance.new("TextButton", header)
        minBtn.Name = "MinBtn"; minBtn.Size = UDim2.new(0, 18, 0, 18)
        minBtn.Position = UDim2.new(1, -19, 0, 0)
        minBtn.BackgroundTransparency = 1; minBtn.Text = "−"
        minBtn.TextColor3 = Color3.fromRGB(200, 230, 255); minBtn.Font = Enum.Font.GothamBold
        minBtn.TextSize = 13; minBtn.AutoButtonColor = false
        local divider = Instance.new("Frame", mainFrame)
        divider.Name = "Divider"; divider.Size = UDim2.new(1, -12, 0, 1)
        divider.Position = UDim2.new(0, 6, 0, 23)
        divider.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        divider.BackgroundTransparency = 0.7; divider.BorderSizePixel = 0
        local body = Instance.new("Frame", mainFrame)
        body.Name = "Body"; body.Size = UDim2.new(1, 0, 1, -25)
        body.Position = UDim2.new(0, 0, 0, 25); body.BackgroundTransparency = 1
        body.ClipsDescendants = true
        local bodyLayout = Instance.new("UIListLayout", body)
        bodyLayout.FillDirection = Enum.FillDirection.Horizontal
        bodyLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        bodyLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        bodyLayout.Padding = UDim.new(0, 5)
        local eye = Instance.new("ImageLabel", body)
        eye.Name = "EyeIcon"; eye.Size = UDim2.new(0, 13, 0, 13)
        eye.BackgroundTransparency = 1; eye.Image = "rbxassetid://13321848320"
        eye.ImageColor3 = Color3.fromRGB(0, 170, 255); eye.LayoutOrder = 1
        SpecState.Label = Instance.new("TextLabel", body)
        SpecState.Label.Name = "CountLabel"; SpecState.Label.BackgroundTransparency = 1
        SpecState.Label.Font = Enum.Font.GothamMedium; SpecState.Label.Text = "No spectators"
        SpecState.Label.TextColor3 = Color3.fromRGB(200, 230, 255); SpecState.Label.TextSize = 10
        SpecState.Label.AutomaticSize = Enum.AutomaticSize.X; SpecState.Label.LayoutOrder = 2
        local function setExpanded(state)
            SpecState.Expanded = state
            if state then
                mainFrame.Size = UDim2.new(0, 145, 0, 52)
                divider.Visible = true; body.Visible = true; minBtn.Text = "−"
            else
                mainFrame.Size = UDim2.new(0, 145, 0, 22)
                divider.Visible = false; body.Visible = false; minBtn.Text = "+"
            end
        end
        minBtn.MouseButton1Click:Connect(function() setExpanded(not SpecState.Expanded) end)
        setExpanded(true)
        local dragging, dragStart, startPos = false, nil, nil
        mainFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true; dragStart = input.Position; startPos = mainFrame.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if not dragging then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local delta = input.Position - dragStart
                mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end)
    end
    local function Spec_Update()
        if not SpecState.Enabled or not SpecState.Label then return end
        local count = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Team and p.Team.Name == "Spectator" then count = count + 1 end
        end
        if count == 0 then
            SpecState.Label.Text = "No spectators"; SpecState.Label.TextColor3 = Color3.fromRGB(150, 180, 220)
        else
            SpecState.Label.Text = count .. " spectators"; SpecState.Label.TextColor3 = Color3.fromRGB(0, 170, 255)
        end
    end
    function W.Spectator_Set(state)
        SpecState.Enabled = state
        if SpecState.Thread then task.cancel(SpecState.Thread); SpecState.Thread = nil end
        if state then
            Spec_CreateUI(); Spec_Update()
            SpecState.Thread = task.spawn(function()
                while SpecState.Enabled do Spec_Update(); task.wait(1.2) end
            end)
        else
            if SpecState.Gui then SpecState.Gui:Destroy(); SpecState.Gui = nil; SpecState.Label = nil end
        end
    end
end

--=== JERK OFF TOOL ===
W.JerkTool = W.JerkTool or { Enabled = false, ToolName = "Jerk Off" }
do
    local JerkTool = W.JerkTool
    local currentJerkTool = nil
    local jerkRunning = false

    function W.JerkOff_Destroy()
        if currentJerkTool then pcall(function() currentJerkTool:Destroy() end); currentJerkTool = nil end
    end

    function W.JerkOff_Create()
        W.JerkOff_Destroy()
        local character = LocalPlayer.Character
        if not character then return end
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        local backpack = LocalPlayer:FindFirstChildWhichIsA("Backpack")
        if not humanoid or not backpack then return end

        local tool = Instance.new("Tool")
        tool.Name = JerkTool.ToolName
        tool.ToolTip = 'in the stripped club. straight up "jorking it" . and by "it" , haha, well. let\'s just say. My peanits.'
        tool.RequiresHandle = false
        tool.Parent = backpack
        currentJerkTool = tool

        local jorkin = false
        local track = nil

        local function stopTomfoolery()
            jorkin = false
            if track then pcall(function() track:Stop() end); track = nil end
        end

        tool.Equipped:Connect(function() jorkin = true end)
        tool.Unequipped:Connect(stopTomfoolery)
        if humanoid.Died then humanoid.Died:Connect(stopTomfoolery) end

        task.spawn(function()
            while jerkRunning do
                task.wait()
                if not JerkTool.Enabled or not jorkin then
                    if track then pcall(function() track:Stop() end) end
                    continue
                end
                local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
                if not track then
                    local anim = Instance.new("Animation")
                    anim.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
                    track = humanoid:LoadAnimation(anim)
                end
                track:Play()
                track:AdjustSpeed(isR15 and 0.7 or 0.65)
                track.TimePosition = 0.6
                task.wait(0.1)
                while track and track.TimePosition < (not isR15 and 0.65 or 0.7) do
                    task.wait(0.1)
                end
                if track then pcall(function() track:Stop() end) end
            end
        end)
    end

    function W.JerkOff_SetEnabled(v)
        JerkTool.Enabled = v and true or false
        jerkRunning = JerkTool.Enabled
        if v then W.JerkOff_Create() else W.JerkOff_Destroy() end
    end

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if JerkTool.Enabled then jerkRunning = true; W.JerkOff_Create() end
    end)
end

-- [PART 8: NO FALL + NEXT MAP + CONFIG GLOBALS DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 8: NO FALL + NEXT MAP + CONFIG GLOBALS
--═══════════════════════════════════════════════════════════--

--=== NO FALL DAMAGE ===
do
    local FallHookInstalled = false
    local function PAZZHUB_InstallNoFallHook()
        if FallHookInstalled then return end
        FallHookInstalled = true
        task.spawn(function()
            pcall(function()
                local mt = getrawmetatable and getrawmetatable(game)
                if not mt then return end
                local oldNamecall = mt.__namecall
                if setreadonly then setreadonly(mt, false) end
                mt.__namecall = newcclosure(function(self, ...)
                    if not checkcaller() and getgenv().PAZZHUB.NoFallDamage then
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
    PAZZHUB_InstallNoFallHook()
end

--=== NEXT MAP PREDICTION ===
do
    local MapPredictState = { Gui = nil, Thread = nil, Enabled = false, LastMap = "Unknown" }
    local function DetectMapName(map)
        if not map then return nil end
        if map:FindFirstChild("random shakes") or map:FindFirstChild("SCP-173 Room") or map:FindFirstChild("SCP-205 Room") then
            return "Site 68"
        elseif map:FindFirstChild("HooksMeat") then
            return "BLOODBATH! Club"
        elseif map:FindFirstChild("Gate") and map.Gate:FindFirstChild("vfx") then
            return "Firelink Shrine"
        elseif map:FindFirstChild("Bldg_Addon_RooftopUnit_A") or map:FindFirstChild("Rooftop") then
            return "Mercy Hospital Rooftop"
        elseif map:FindFirstChild("White Armored Car") then
            return "Mount Massive Asylum"
        elseif map:FindFirstChild("Dumbster") then
            return "The Bay Harbor"
        elseif map:FindFirstChild("water pump") then
            return "Valdelobos Village"
        elseif map:FindFirstChild("LargeBoulder01") then
            return "Woodview Cabin"
        end
        return nil
    end
    local function BuildMapGui()
        if MapPredictState.Gui then pcall(function() MapPredictState.Gui:Destroy() end) end
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if gethui then
            local ok, hui = pcall(gethui)
            if ok and hui then pg = hui end
        end
        if not pg then return end
        local gui = Instance.new("ScreenGui")
        gui.Name = "PAZZHUBMapPredict"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 50
        gui.Parent = pg
        local frame = Instance.new("Frame")
        frame.Name = "MainFrame"
        frame.Size = UDim2.new(0, 210, 0, 54)
        frame.Position = UDim2.new(0.5, -105, 0, 110)
        frame.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        frame.BackgroundTransparency = 0.15
        frame.BorderSizePixel = 0
        frame.Active = true
        frame.Parent = gui
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
        local stroke = Instance.new("UIStroke", frame)
        stroke.Color = Color3.fromRGB(0, 170, 255)
        stroke.Thickness = 1.5
        stroke.Transparency = 0.2
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 15)
        title.Position = UDim2.new(0, 0, 0, 5)
        title.BackgroundTransparency = 1
        title.Text = "NEXT MAP PREDICTION"
        title.TextColor3 = Color3.fromRGB(100, 180, 240)
        title.Font = Enum.Font.GothamBold
        title.TextSize = 10
        title.Parent = frame
        local mapName = Instance.new("TextLabel")
        mapName.Name = "MapName"
        mapName.Size = UDim2.new(1, -12, 0, 18)
        mapName.Position = UDim2.new(0, 6, 0, 21)
        mapName.BackgroundTransparency = 1
        mapName.Text = "Scanning..."
        mapName.TextColor3 = Color3.fromRGB(200, 230, 255)
        mapName.Font = Enum.Font.GothamBold
        mapName.TextSize = 13
        mapName.TextXAlignment = Enum.TextXAlignment.Center
        mapName.Parent = frame
        local status = Instance.new("TextLabel")
        status.Name = "StatusLabel"
        status.Size = UDim2.new(1, -12, 0, 12)
        status.Position = UDim2.new(0, 6, 0, 38)
        status.BackgroundTransparency = 1
        status.Text = "Status: Waiting"
        status.TextColor3 = Color3.fromRGB(150, 150, 150)
        status.Font = Enum.Font.GothamMedium
        status.TextSize = 9
        status.TextXAlignment = Enum.TextXAlignment.Center
        status.Parent = frame
        local dragging, dragStart, startPos = false, nil, nil
        frame.InputBegan:Connect(function(input)
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
        MapPredictState.Gui = gui
    end
    local function Stop()
        MapPredictState.Enabled = false
        if MapPredictState.Thread then pcall(function() task.cancel(MapPredictState.Thread) end); MapPredictState.Thread = nil end
        if MapPredictState.Gui then pcall(function() MapPredictState.Gui:Destroy() end); MapPredictState.Gui = nil end
    end
    local function Start()
        if MapPredictState.Enabled then return end
        MapPredictState.Enabled = true
        BuildMapGui()
        MapPredictState.Thread = task.spawn(function()
            local lastDetected, lastExisted = nil, false
            while MapPredictState.Enabled do
                local map = Workspace:FindFirstChild("Map")
                local mapExists = map ~= nil
                local detected = mapExists and DetectMapName(map) or nil
                local gui = MapPredictState.Gui
                local frame = gui and gui:FindFirstChild("MainFrame")
                local nameLabel = frame and frame:FindFirstChild("MapName")
                local statusLabel = frame and frame:FindFirstChild("StatusLabel")
                if nameLabel and statusLabel then
                    if lastExisted and not mapExists then
                        nameLabel.Text = lastDetected or "Unknown"
                        statusLabel.Text = "Status: Loading next map..."
                        statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
                    elseif mapExists then
                        lastDetected = detected or "Unknown"
                        nameLabel.Text = detected or "Unknown"
                        statusLabel.Text = "Status: In-Game"
                        statusLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
                    else
                        nameLabel.Text = "Waiting..."
                        statusLabel.Text = "Status: Lobby"
                        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
                    end
                end
                lastExisted = mapExists
                task.wait(0.5)
            end
        end)
    end
    W.NextMapPredict_Start = Start
    W.NextMapPredict_Stop = Stop
    W.NextMapPredict_SetEnabled = function(v)
        PAZZHUB.NextMapPredict = v and true or false
        if PAZZHUB.NextMapPredict then Start() else Stop() end
    end
end

--=== CONFIG GLOBALS STUB (Buat SaveManager Obsidian) ===
if type(getgenv().ConfigData) ~= "table" then getgenv().ConfigData = {} end
ConfigData = getgenv().ConfigData
if type(getgenv().Elements) ~= "table" then getgenv().Elements = {} end
Elements = getgenv().Elements
if type(AutoSaveEnabled) ~= "boolean" then AutoSaveEnabled = true end
ActiveConfigName = ActiveConfigName or nil
ActiveConfigPath = ActiveConfigPath or nil
ActiveConfigMode = ActiveConfigMode or nil
if type(SetActiveConfig) ~= "function" then
    function SetActiveConfig(name, path, enabled, mode)
        ActiveConfigName = name
        ActiveConfigPath = path
        AutoSaveEnabled = enabled
        ActiveConfigMode = mode
    end
end
if type(GetConfigSnapshot) ~= "function" then
    function GetConfigSnapshot()
        local snap = {}
        for k, v in pairs(ConfigData or {}) do snap[k] = v end
        return snap
    end
end

-- [PART 9a: UI BUILD Obsidian — Survivor Tab DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 9a: UI BUILD Obsidian — Survivor Tab
--═══════════════════════════════════════════════════════════--

local SurvivorTab = Tabs.Survivor

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KIRI: Self Heal + Vault + Pallet + Fake Parry + Perks
--═══════════════════════════════════════════════════════════--
local SurvivorL = SurvivorTab:AddLeftGroupbox("Survivor Basic", "user")

SurvivorL:AddToggle("SH_Enable", {
    Text = "Self Heal",
    Default = false,
    Tooltip = "Auto heal diri sendiri",
    Callback = function(v)
        W.setInstantHealSelf(v)
        if getgenv().PAZZHUB_SHB_UpdateVisual then pcall(getgenv().PAZZHUB_SHB_UpdateVisual) end
    end
})

SurvivorL:AddToggle("SH_HealAll", {
    Text = "Auto Heal All",
    Default = false,
    Tooltip = "Auto heal semua survivor di sekitar",
    Callback = function(v) W.setAutoHealAll(v) end
})

SurvivorL:AddToggle("SH_ShowBtn", {
    Text = "Show Self Heal Button",
    Default = false,
    Callback = function(v)
        if getgenv().PAZZHUB_SHB_SetEnabled then getgenv().PAZZHUB_SHB_SetEnabled(v) end
    end
})

SurvivorL:AddDivider()

SurvivorL:AddToggle("SV_Enable", {
    Text = "Swift Vault",
    Default = false,
    Tooltip = "Auto vault window saat dekat",
    Callback = function(v) W.SwiftVault_SetEnabled(v) end
})

SurvivorL:AddToggle("SV_V2", {
    Text = "Swift Vault V2",
    Default = false,
    Tooltip = "Custom vault speed",
    Callback = function(v) W.SwiftVaultV2_SetEnabled(v) end
})

SurvivorL:AddSlider("SV_Speed", {
    Text = "Vault Speed",
    Default = 13, Min = 10, Max = 20, Rounding = 0,
    Callback = function(v) W.SwiftVault_SetSpeed(v) end
})

SurvivorL:AddDivider()

SurvivorL:AddToggle("PR_Enable", {
    Text = "Pallet Reflex",
    Default = false,
    Tooltip = "Auto drop pallet saat killer dekat",
    Callback = function(v) W.PalletReflex_SetEnabled(v) end
})

SurvivorL:AddSlider("PR_Dist", {
    Text = "Trigger Distance",
    Default = 20, Min = 5, Max = 50, Rounding = 0, Suffix = " studs",
    Callback = function(v) W.PalletReflex_SetDistance(v) end
})

SurvivorL:AddDivider()

SurvivorL:AddToggle("FP_Enable", {
    Text = "Fake Parry",
    Default = false,
    Tooltip = "Animasi parry palsu",
    Callback = function(v) W.FakeParry_SetEnabled(v) end
})

SurvivorL:AddDropdown("FP_Anim", {
    Text = "Animation",
    Values = {"Enten", "Stopwatch", "Fih", "BloodShield"},
    Default = "Enten",
    Callback = function(v) W.FakeParry_SetAnim(v) end
})

SurvivorL:AddSlider("FP_CD", {
    Text = "Cooldown",
    Default = 0.4, Min = 0, Max = 3, Rounding = 1,
    Suffix = "s",
    Callback = function(v) PAZZHUB.SURV_FakeParryCooldown = v end
})

SurvivorL:AddToggle("FP_ShowBtn", {
    Text = "Show Fake Parry Button",
    Default = false,
    Callback = function(v) W.FakeParry_SetShowButton(v) end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KANAN: Auto Parry V1 + V2 + Flee + Fake Perks
--═══════════════════════════════════════════════════════════--
local SurvivorR = SurvivorTab:AddRightGroupbox("Auto Parry", "shield")

SurvivorR:AddToggle("P1_Enable", {
    Text = "Auto Parry V1",
    Default = false,
    Tooltip = "Auto parry (dengan animasi detector)",
    Callback = function(v)
        PAZZHUB.PARRY_Enabled = v
        if not v then ParryState.ActiveAttackers = {} end
        if getgenv().PAZZHUB_ParryBtn_UpdateVisual then pcall(getgenv().PAZZHUB_ParryBtn_UpdateVisual) end
    end
})

SurvivorR:AddToggle("P1_Aggressive", {
    Text = "V1 Aggressive",
    Default = false,
    Callback = function(v) PAZZHUB.PARRY_Aggressive = v end
})

SurvivorR:AddSlider("P1_Dist", {
    Text = "V1 Parry Distance",
    Default = 10, Min = 4, Max = 30, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PAZZHUB.PARRY_Distance = v end
})

SurvivorR:AddToggle("P1_Circle", {
    Text = "V1 Show Range",
    Default = false,
    Callback = function(v)
        PAZZHUB.PARRY_ShowCircle = v
        if not v and getgenv()._PAZZHUB_DestroyParryCircle then pcall(getgenv()._PAZZHUB_DestroyParryCircle) end
    end
})

SurvivorR:AddToggle("P1_Silent", {
    Text = "V1 Silent Parry",
    Default = false,
    Callback = function(v) PAZZHUB.PARRY_SilentParry = v end
})

SurvivorR:AddDivider()

SurvivorR:AddToggle("P2_Enable", {
    Text = "Auto Parry V2 (Wisnu)",
    Default = false,
    Callback = function(v) PAZZHUB.Wisnu_AutoParry = v end
})

SurvivorR:AddToggle("P2_Aggressive", {
    Text = "V2 Aggressive",
    Default = false,
    Callback = function(v) PAZZHUB.Wisnu_ParryAggressive = v end
})

SurvivorR:AddToggle("P2_Safety", {
    Text = "V2 Safety",
    Default = false,
    Tooltip = "Skip parry kalau lagi vault/repair/heal",
    Callback = function(v) PAZZHUB.Wisnu_ParrySafety = v end
})

SurvivorR:AddSlider("P2_Dist", {
    Text = "V2 Distance",
    Default = 6, Min = 4, Max = 25, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PAZZHUB.Wisnu_ParryDistance = v end
})

SurvivorR:AddSlider("P2_Face", {
    Text = "V2 Face Sensitivity",
    Default = 0.7, Min = -1, Max = 1, Rounding = 2,
    Callback = function(v) PAZZHUB.Wisnu_ParryFace = v end
})

SurvivorR:AddToggle("P2_Circle", {
    Text = "V2 Show Circle",
    Default = true,
    Callback = function(v) PAZZHUB.Wisnu_ParryCircle = v end
})

SurvivorR:AddDivider()

SurvivorR:AddToggle("AF_Enable", {
    Text = "Auto Flee Killer",
    Default = false,
    Tooltip = "Teleport jauh saat killer dekat",
    Callback = function(v) PAZZHUB.SURV_AutoFlee = v end
})

SurvivorR:AddSlider("AF_Dist", {
    Text = "Detect Distance",
    Default = 40, Min = 15, Max = 150, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PAZZHUB.SURV_AutoFleeDist = v end
})

SurvivorR:AddSlider("AF_CD", {
    Text = "Flee Cooldown",
    Default = 1.5, Min = 0.5, Max = 10, Rounding = 1,
    Suffix = "s",
    Callback = function(v) PAZZHUB.SURV_AutoFleeCooldown = v end
})

SurvivorR:AddDivider()

SurvivorR:AddToggle("FPK_Flow", {
    Text = "Fake Perk: Flowstate",
    Default = false,
    Callback = function(v) W.FP_SetupFlowstate(v) end
})

SurvivorR:AddToggle("FPK_Quick", {
    Text = "Fake Perk: Quick Recovery",
    Default = false,
    Callback = function(v) W.FP_SetupQuickRecovery(v) end
})

SurvivorR:AddToggle("FPK_Land", {
    Text = "Fake Perk: Perfect Landing",
    Default = false,
    Callback = function(v) W.FP_SetupPerfectLanding(v) end
})

SurvivorR:AddToggle("FPK_Adren", {
    Text = "Fake Perk: Adrenaline Rush",
    Default = false,
    Callback = function(v) W.FP_SetupAdrenalineRush(v) end
})

--═══════════════════════════════════════════════════════════--
-- SISA SURVIVOR (Taruh di Groupbox "Utility")
--═══════════════════════════════════════════════════════════--
local SurvivorUtil = SurvivorTab:AddLeftGroupbox("Survivor Utility", "settings")

SurvivorUtil:AddToggle("SC_Enable", {
    Text = "Auto Skill Check",
    Default = false,
    Callback = function(v) W.SC_Set(v) end
})

SurvivorUtil:AddDropdown("SC_Mode", {
    Text = "Skill Check Mode",
    Values = {"Legit", "Instant"},
    Default = "Legit",
    Callback = function(v) W.SC.Mode = v end
})

SurvivorUtil:AddDivider()

SurvivorUtil:AddToggle("GB_Enable", {
    Text = "Bypass Generator",
    Default = false,
    Tooltip = "Hotkey B",
    Callback = function(v) W.GB.Enabled = v end
})

SurvivorUtil:AddSlider("GB_Range", {
    Text = "Gen Trigger Range",
    Default = 8, Min = 3, Max = 20, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.GB.Range = v end
})

SurvivorUtil:AddDivider()

SurvivorUtil:AddToggle("UV_Enable", {
    Text = "Unlimited Vault",
    Default = false,
    Callback = function(v) W.UV_Set(v) end
})

SurvivorUtil:AddToggle("ASV_Enable", {
    Text = "Anti Slow Vault",
    Default = false,
    Callback = function(v) W.ASV_Set(v) end
})

SurvivorUtil:AddToggle("God_Enable", {
    Text = "God Mode",
    Default = false,
    Callback = function(v) W.God_Set(v) end
})

SurvivorUtil:AddDivider()

SurvivorUtil:AddToggle("AR_PC", {
    Text = "Auto Run [PC]",
    Default = false,
    Callback = function(v) W.AutoRunPC(v) end
})

SurvivorUtil:AddToggle("AR_Mobile", {
    Text = "Auto Run [Mobile]",
    Default = false,
    Callback = function(v) W.AutoRunMobile(v) end
})

SurvivorUtil:AddDivider()

SurvivorUtil:AddToggle("SU_Enable", {
    Text = "Bypass Self Unhook",
    Default = false,
    Callback = function(v) W.SU_Set(v) end
})

SurvivorUtil:AddSlider("SU_Duration", {
    Text = "Follow Duration",
    Default = 30, Min = 5, Max = 120, Rounding = 0,
    Suffix = "s",
    Callback = function(v) W.SU.FollowDuration = v end
})

SurvivorUtil:AddSlider("SU_Distance", {
    Text = "Follow Distance",
    Default = 20, Min = 5, Max = 60, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.SU.FollowDistance = v end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KANAN BAWAH: TOF + Flashlight + Aim Gun + Gen + Moonwalk
--═══════════════════════════════════════════════════════════--
local SurvivorR2 = SurvivorTab:AddRightGroupbox("Survivor Extras", "target")

SurvivorR2:AddToggle("TOF_Enable", {
    Text = "Silent Aim TOF",
    Default = false,
    Tooltip = "Auto aim pistol Twist of Fate",
    Callback = function(v) W.SetToFSilentAim(v) end
})

SurvivorR2:AddDropdown("TOF_Mode", {
    Text = "ToF Target Mode",
    Values = {"Killer", "Survivors", "Zombie"},
    Default = "Killer",
    Callback = function(v) W.ToF_SetTargetMode(v, true) end
})

SurvivorR2:AddToggle("TOF_Laser", {
    Text = "ToF Show Laser",
    Default = true,
    Callback = function(v) PAZZHUB.TOF_Laser = v end
})

SurvivorR2:AddToggle("TOF_Wall", {
    Text = "ToF Wall Check",
    Default = true,
    Callback = function(v) PAZZHUB.TOF_WallCheck = v end
})

SurvivorR2:AddToggle("TOF_Block", {
    Text = "ToF Block When Knocked",
    Default = true,
    Callback = function(v) PAZZHUB.TOF_BlockKnocked = v end
})

SurvivorR2:AddDivider()

SurvivorR2:AddToggle("FL_Enable", {
    Text = "Silent Flashlight",
    Default = false,
    Callback = function(v) W.Flash_SetEnabled(v) end
})

SurvivorR2:AddDropdown("FL_Part", {
    Text = "Flashlight Target Part",
    Values = {"Head", "UpperTorso", "Torso", "HumanoidRootPart"},
    Default = "Head",
    Callback = function(v) PAZZHUB.FLASH_TargetPart = v end
})

SurvivorR2:AddSlider("FL_Range", {
    Text = "Flashlight Max Range",
    Default = 120, Min = 20, Max = 250, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PAZZHUB.FLASH_Range = v end
})

SurvivorR2:AddSlider("FL_Smooth", {
    Text = "Flashlight Smoothness",
    Default = 0.35, Min = 0.05, Max = 1, Rounding = 2,
    Callback = function(v) PAZZHUB.FLASH_Smooth = v end
})

SurvivorR2:AddDivider()

SurvivorR2:AddToggle("AG_Enable", {
    Text = "Aim Lock Gun",
    Default = false,
    Tooltip = "Hold M2 untuk lock camera",
    Callback = function(v)
        if W.GunAim_Cfg then W.GunAim_Cfg.Enabled = v end
        if v and W.GunAim_Start then W.GunAim_Start() end
    end
})

SurvivorR2:AddDropdown("AG_Mode", {
    Text = "Gun Target Mode",
    Values = {"Killer", "Survivor"},
    Default = "Killer",
    Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.TargetMode = v end end
})

SurvivorR2:AddSlider("AG_FOV", {
    Text = "Gun FOV Radius",
    Default = 250, Min = 50, Max = 1000, Rounding = 0,
    Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.FOV = v end end
})

SurvivorR2:AddSlider("AG_Smooth", {
    Text = "Gun Aim Smoothness",
    Default = 0.5, Min = 0.1, Max = 1, Rounding = 2,
    Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.Strength = v end end
})

SurvivorR2:AddDivider()

SurvivorR2:AddToggle("MG_Enable", {
    Text = "Manual Generator",
    Default = false,
    Callback = function(v) W.ManualGen_SetEnabled(v) end
})

SurvivorR2:AddToggle("AUG_Enable", {
    Text = "Auto Generator",
    Default = false,
    Callback = function(v) W.AutoGen_SetEnabled(v) end
})

SurvivorR2:AddSlider("GEN_Escape", {
    Text = "Killer Escape Distance",
    Default = 30, Min = 10, Max = 80, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.GenAuto_SetDistance(v) end
})

SurvivorR2:AddDivider()

SurvivorR2:AddToggle("MW_Enable", {
    Text = "Moonwalk",
    Default = false,
    Tooltip = "Hotkey F8",
    Callback = function(v) W.Moonwalk_Set(v) end
})

SurvivorR2:AddSlider("MW_Side", {
    Text = "Moonwalk Side Speed",
    Default = 0.9, Min = 0.1, Max = 3, Rounding = 1,
    Callback = function(v) W.Moonwalk_SetSide(v) end
})

SurvivorR2:AddSlider("MW_Back", {
    Text = "Moonwalk Back Speed",
    Default = 1.2, Min = 0.1, Max = 3, Rounding = 1,
    Callback = function(v) W.Moonwalk_SetBack(v) end
})

-- [PART 9b: UI BUILD Obsidian — Visuals Tab DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 9b: UI BUILD Obsidian — Visuals Tab
--═══════════════════════════════════════════════════════════--

local VisualsTab = Tabs.Visuals

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KIRI: Full ESP + Status ESP
--═══════════════════════════════════════════════════════════--
local VisualsL = VisualsTab:AddLeftGroupbox("Full ESP", "eye")

VisualsL:AddToggle("ESP_Surv", {
    Text = "ESP Survivor",
    Default = false,
    Callback = function(v) W.FullESP.Survivor = v end
})

VisualsL:AddColorPicker("ESP_SurvColor", {
    Title = "Survivor Color",
    Default = Color3.fromRGB(0, 170, 255),
    Transparency = 0,
    Callback = function(c) W.FullESPColors.Survivor = c end
})

VisualsL:AddToggle("ESP_Kill", {
    Text = "ESP Killer",
    Default = false,
    Callback = function(v) W.FullESP.Killer = v end
})

VisualsL:AddColorPicker("ESP_KillColor", {
    Title = "Killer Color",
    Default = Color3.fromRGB(255, 60, 60),
    Transparency = 0,
    Callback = function(c) W.FullESPColors.Killer = c end
})

VisualsL:AddToggle("ESP_Gen", {
    Text = "ESP Generator",
    Default = false,
    Callback = function(v) W.FullESP.Generator = v end
})

VisualsL:AddColorPicker("ESP_GenColor", {
    Title = "Generator Color",
    Default = Color3.fromRGB(255, 255, 0),
    Transparency = 0,
    Callback = function(c) W.FullESPColors.Generator = c end
})

VisualsL:AddToggle("ESP_Pallet", {
    Text = "ESP Pallet",
    Default = false,
    Callback = function(v) W.FullESP.Pallet = v end
})

VisualsL:AddColorPicker("ESP_PalletColor", {
    Title = "Pallet Color",
    Default = Color3.fromRGB(255, 165, 0),
    Transparency = 0,
    Callback = function(c) W.FullESPColors.Pallet = c end
})

VisualsL:AddToggle("ESP_Window", {
    Text = "ESP Window",
    Default = false,
    Callback = function(v)
        W.FullESP.Window = v
        _G.PAZZHUBWindowScanned = false
    end
})

VisualsL:AddColorPicker("ESP_WindowColor", {
    Title = "Window Color",
    Default = Color3.fromRGB(255, 255, 255),
    Transparency = 0,
    Callback = function(c) W.FullESPColors.Window = c end
})

VisualsL:AddToggle("ESP_SCP", {
    Text = "ESP SCP",
    Default = false,
    Callback = function(v) W.FullESP.SCP = v end
})

VisualsL:AddColorPicker("ESP_SCPColor", {
    Title = "SCP Color",
    Default = Color3.fromRGB(0, 255, 0),
    Transparency = 0,
    Callback = function(c) W.FullESPColors.SCP = c end
})

VisualsL:AddSlider("ESP_Radius", {
    Text = "ESP Radius",
    Default = 500, Min = 10, Max = 1000, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.FullESP.Distance = v end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KANAN: Status ESP
--═══════════════════════════════════════════════════════════--
local VisualsR = VisualsTab:AddRightGroupbox("Status ESP", "user-check")

VisualsR:AddToggle("SE_Enable", {
    Text = "Enable Status ESP",
    Default = false,
    Callback = function(v) W.FullESPStatus.Enabled = v end
})

VisualsR:AddToggle("SE_Name", {
    Text = "Show Name",
    Default = true,
    Callback = function(v) W.FullESPStatus.ShowName = v end
})

VisualsR:AddToggle("SE_Dist", {
    Text = "Show Distance",
    Default = true,
    Callback = function(v) W.FullESPStatus.ShowDistance = v end
})

VisualsR:AddToggle("SE_Avatar", {
    Text = "Show Avatar",
    Default = true,
    Callback = function(v) W.FullESPStatus.ShowAvatar = v end
})

VisualsR:AddToggle("SE_Action", {
    Text = "Show Action",
    Default = true,
    Tooltip = "Tampilkan status player (REPAIR, HEAL, VAULT, dll)",
    Callback = function(v) W.FullESPStatus.ShowAction = v end
})

VisualsR:AddToggle("SE_Health", {
    Text = "Show Health Bar",
    Default = false,
    Callback = function(v) W.FullESPStatus.ShowHealth = v end
})

VisualsR:AddSlider("SE_Radius", {
    Text = "Status Radius",
    Default = 500, Min = 20, Max = 1000, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.FullESPStatus.Radius = v end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KIRI BAWAH: Graphics + Clock
--═══════════════════════════════════════════════════════════--
local VisualsL2 = VisualsTab:AddLeftGroupbox("Graphics", "sun")

VisualsL2:AddToggle("GF_Fullbright", {
    Text = "Fullbright",
    Default = false,
    Callback = function(v) W.Graphics.Fullbright = v; W.Graphics_Apply() end
})

VisualsL2:AddToggle("GF_NoShadow", {
    Text = "No Shadow",
    Default = false,
    Callback = function(v) W.Graphics.NoShadow = v; W.Graphics_Apply() end
})

VisualsL2:AddToggle("GF_LowGfx", {
    Text = "Low Graphics",
    Default = false,
    Callback = function(v) W.Graphics.LowGraphics = v; W.Graphics_ApplyOpt() end
})

VisualsL2:AddToggle("GF_NoFx", {
    Text = "No Screen Effects",
    Default = false,
    Callback = function(v) W.Graphics.NoScreenEffects = v; W.Graphics_ApplyNoFx() end
})

VisualsL2:AddToggle("GF_CleanSky", {
    Text = "Clean Sky",
    Default = false,
    Callback = function(v) W.Graphics.CleanSky = v; W.Graphics_ApplyOpt() end
})

VisualsL2:AddToggle("GF_Potato", {
    Text = "Potato Mode",
    Tooltip = "Extreme low graphics",
    Default = false,
    Callback = function(v) W.Potato_Set(v) end
})

VisualsL2:AddDivider()

VisualsL2:AddToggle("GF_ClockOn", {
    Text = "Enable Clock Override",
    Default = false,
    Callback = function(v) W.Graphics.ClockTimeEnabled = v; W.Graphics_Apply() end
})

VisualsL2:AddSlider("GF_Clock", {
    Text = "Clock Time",
    Default = 14, Min = 0, Max = 24, Rounding = 0,
    Callback = function(v)
        W.Graphics.ClockTime = v
        W.Graphics.ClockTimeEnabled = true
        W.Graphics_Apply()
    end
})

VisualsL2:AddSlider("GF_Brightness", {
    Text = "Brightness",
    Default = 2, Min = 0, Max = 5, Rounding = 1,
    Callback = function(v)
        W.Graphics.Brightness = v
        W.Graphics.ClockTimeEnabled = true
        W.Graphics_Apply()
    end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KANAN BAWAH: Zoom + POV + Camera DBD
--═══════════════════════════════════════════════════════════--
local VisualsR2 = VisualsTab:AddRightGroupbox("Camera", "camera")

VisualsR2:AddToggle("CM_UnlimitedZoom", {
    Text = "Unlimited Zoom",
    Default = false,
    Callback = function(v) W.Graphics.UnlimitedZoom = v; W.Graphics_ApplyZoom() end
})

VisualsR2:AddSlider("CM_MaxZoom", {
    Text = "Max Zoom Distance",
    Default = 1000, Min = 100, Max = 5000, Rounding = 0,
    Callback = function(v) W.Graphics.MaxZoomDistance = v end
})

VisualsR2:AddToggle("CM_FOVOn", {
    Text = "Custom FOV",
    Default = false,
    Callback = function(v) W.Graphics.FOVEnabled = v; W.Graphics_ApplyFOV() end
})

VisualsR2:AddSlider("CM_FOV", {
    Text = "Camera FOV",
    Default = 70, Min = 40, Max = 120, Rounding = 0,
    Callback = function(v) W.Graphics.FOV = v end
})

VisualsR2:AddDivider()

VisualsR2:AddToggle("CM_LockPOV", {
    Text = "Enable Lock POV",
    Default = false,
    Callback = function(v) if W.LockPOV_SetEnabled then W.LockPOV_SetEnabled(v) end end
})

VisualsR2:AddSlider("CM_LockPOVVal", {
    Text = "Locked FOV Value",
    Default = 80, Min = 40, Max = 120, Rounding = 0,
    Callback = function(v) if W.LockPOV then W.LockPOV.LockedFOV = v end end
})

VisualsR2:AddDivider()

VisualsR2:AddToggle("CM_DBD", {
    Text = "Camera DBD Smooth",
    Default = false,
    Callback = function(v) W.CamDBD_SetSmooth(v) end
})

VisualsR2:AddSlider("CM_DBDSpeed", {
    Text = "DBD Smooth Speed",
    Default = 4, Min = 1, Max = 30, Rounding = 0,
    Callback = function(v) W.CamDBD_SetSmoothSpeed(v) end
})

VisualsR2:AddToggle("CM_DBDPOV", {
    Text = "DBD POV Lock",
    Default = false,
    Callback = function(v) W.CamDBD_SetPOVLock(v) end
})

VisualsR2:AddSlider("CM_DBDPOVVal", {
    Text = "DBD POV Value",
    Default = 85, Min = 60, Max = 120, Rounding = 0,
    Suffix = "°",
    Callback = function(v) W.CamDBD_SetTargetPOV(v) end
})

-- [PART 9c: UI BUILD Obsidian — Killer Tab DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 9c: UI BUILD Obsidian — Killer Tab
--═══════════════════════════════════════════════════════════--

local KillerTab = Tabs.Killer

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KIRI: Auto Attack + Inf Lunge + Counter
--═══════════════════════════════════════════════════════════--
local KillerL = KillerTab:AddLeftGroupbox("Killer Basic", "sword")

KillerL:AddToggle("KA_AutoAttack", {
    Text = "Auto Attack",
    Default = false,
    Tooltip = "Auto fire BasicAttack ke survivor terdekat",
    Callback = function(v) PAZZHUB.KILLER_AutoAttack = v end
})

KillerL:AddSlider("KA_AttackRange", {
    Text = "Attack Range",
    Default = 12, Min = 5, Max = 30, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PAZZHUB.KILLER_AutoAttackRange = v end
})

KillerL:AddSlider("KA_AttackCD", {
    Text = "Attack Cooldown",
    Default = 0.15, Min = 0.05, Max = 1, Rounding = 2,
    Suffix = "s",
    Callback = function(v) PAZZHUB.KILLER_AutoAttackCooldown = v end
})

KillerL:AddDivider()

KillerL:AddToggle("KA_InfLunge", {
    Text = "Infinite Lunge",
    Default = false,
    Tooltip = "Basic attack lunge tanpa cooldown",
    Callback = function(v) PAZZHUB.KILLER_InfLunge = v end
})

KillerL:AddToggle("KA_Counter", {
    Text = "Counter Auto Parry",
    Default = false,
    Tooltip = "Spam anim parry biar survivor trigger sendiri",
    Callback = function(v) PAZZHUB.CounterParry_Enabled = v end
})

KillerL:AddDivider()

KillerL:AddToggle("KA_AntiBlind", {
    Text = "Anti Blind",
    Default = false,
    Tooltip = "Block efek pusing dari flashlight",
    Callback = function(v)
        PAZZHUB.KILLER_AntiBlind = v
        if v and W.SetupAntiBlind then pcall(W.SetupAntiBlind) end
    end
})

KillerL:AddToggle("KA_DestroyPallet", {
    Text = "Destroy Pallet",
    Default = false,
    Tooltip = "Auto hancurkan pallet terdekat (radius 6)",
    Callback = function(v) PAZZHUB.KILLER_DestroyPallets = v end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KANAN: Aim Lock + Masked
--═══════════════════════════════════════════════════════════--
local KillerR = KillerTab:AddRightGroupbox("Aim & Masked", "crosshair")

KillerR:AddToggle("KL_Hidden", {
    Text = "Aim Lock Hidden",
    Default = false,
    Tooltip = "Hold M2 / E untuk lock camera ke target",
    Callback = function(v) W.AimLockHidden_Set(v) end
})

KillerR:AddToggle("KL_Attack", {
    Text = "Aim Lock Attack",
    Default = false,
    Tooltip = "Hold M2 untuk auto-aim ke survivor",
    Callback = function(v)
        if W.AttackAim_Cfg then W.AttackAim_Cfg.Enabled = v end
        if v and W.AttackAim_Start then W.AttackAim_Start() end
    end
})

KillerR:AddSlider("KL_AttackFOV", {
    Text = "Aim Attack FOV",
    Default = 250, Min = 50, Max = 1000, Rounding = 0,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.FOV = v end end
})

KillerR:AddSlider("KL_AttackSmooth", {
    Text = "Aim Attack Smoothness",
    Default = 1, Min = 0.1, Max = 1, Rounding = 2,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.Strength = v end end
})

KillerR:AddDivider()

KillerR:AddDropdown("MK_Power", {
    Text = "Masked Power",
    Values = {"Cobra", "Richter", "Brandon", "Rabbit", "Alex", "Tony"},
    Default = "Cobra",
    Callback = function(v) W.Masked.CurrentPower = v end
})

KillerR:AddButton({
    Text = "Activate Masked",
    Func = function() W.Masked_Activate() end
})

KillerR:AddButton({
    Text = "Deactivate Masked",
    Func = function() W.Masked_Deactivate() end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KIRI BAWAH: Silent Veil V1 + V2
--═══════════════════════════════════════════════════════════--
local KillerL2 = KillerTab:AddLeftGroupbox("Silent Veil", "wind")

KillerL2:AddToggle("VL1_Enable", {
    Text = "Silent Veil V1",
    Default = false,
    Tooltip = "Alfzxzzz Silent Veil",
    Callback = function(v)
        PAZZHUB.VeilEnabled = v
        if not v then
            if W._VeilV1_State then
                W._VeilV1_State.target = nil
                W._VeilV1_State.lookVector = nil
            end
        end
    end
})

KillerL2:AddToggle("VL1_FOV", {
    Text = "V1 Show FOV",
    Default = true,
    Callback = function(v) PAZZHUB.VeilShowFOV = v end
})

KillerL2:AddToggle("VL1_Tracker", {
    Text = "V1 Show Tracker",
    Default = false,
    Callback = function(v) PAZZHUB.VeilShowTracker = v end
})

KillerL2:AddToggle("VL1_Predict", {
    Text = "V1 Auto Predict",
    Default = true,
    Callback = function(v) PAZZHUB.VeilAutoPredict = v end
})

KillerL2:AddSlider("VL1_FOVSize", {
    Text = "V1 FOV Size",
    Default = 150, Min = 50, Max = 500, Rounding = 0,
    Callback = function(v) PAZZHUB.VeilFOV = v end
})

KillerL2:AddSlider("VL1_MaxDist", {
    Text = "V1 Max Distance",
    Default = 280, Min = 50, Max = 280, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) PAZZHUB.VeilMaxDist = v end
})

KillerL2:AddDivider()

KillerL2:AddToggle("VL2_V1", {
    Text = "W424 Veil V1",
    Default = false,
    Callback = function(v)
        if W.W424Veil_API then
            W.W424Veil_API.AimConfig.Aim_SilentVeil = v
        end
    end
})

KillerL2:AddToggle("VL2_V2", {
    Text = "W424 Veil V2",
    Default = false,
    Callback = function(v)
        if W.W424Veil_API then
            W.W424Veil_API.AimConfig.Aim_SilentVeilV2 = v
        end
    end
})

KillerL2:AddToggle("VL2_Predict", {
    Text = "W424 Auto Predict",
    Default = false,
    Callback = function(v)
        if W.W424Veil_API then
            W.W424Veil_API.Config.SpearSmart_enable = v
        end
    end
})

KillerL2:AddSlider("VL2_Lead", {
    Text = "W424 Lead Multiplier",
    Default = 1.4, Min = 0.5, Max = 5, Rounding = 1,
    Callback = function(v)
        if W.W424Veil_API then
            W.W424Veil_API.AimConfig.Veil_LeadMultiplier = v
        end
    end
})

KillerL2:AddSlider("VL2_Speed", {
    Text = "W424 Spear Speed",
    Default = 165, Min = 50, Max = 200, Rounding = 0,
    Callback = function(v)
        if W.W424Veil_API then
            W.W424Veil_API.AimConfig.SPEAR_Speed = v
        end
    end
})

KillerL2:AddSlider("VL2_Gravity", {
    Text = "W424 Spear Gravity",
    Default = 103, Min = 0, Max = 200, Rounding = 0,
    Callback = function(v)
        if W.W424Veil_API then
            W.W424Veil_API.AimConfig.SPEAR_Gravity = v
        end
    end
})

KillerL2:AddToggle("VL2_Tracker", {
    Text = "W424 ESP Tracker",
    Default = false,
    Callback = function(v)
        if W.W424Veil_API then
            W.W424Veil_API.setTracker(v)
        end
    end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KANAN BAWAH: Bypass + Spear + Abilities + Flask
--═══════════════════════════════════════════════════════════--
local KillerR2 = KillerTab:AddRightGroupbox("Killer Advanced", "zap")

KillerR2:AddToggle("BP_Hidden", {
    Text = "Bypass Hidden Leap",
    Default = false,
    Callback = function(v) W.BYPASS_SetHiddenLeap(v) end
})

KillerR2:AddToggle("BP_Myers", {
    Text = "Bypass Myers Grab",
    Default = false,
    Tooltip = "Hotkey H",
    Callback = function(v) W.setMyersGrab(v) end
})

KillerR2:AddToggle("BP_LakeMist", {
    Text = "Bypass Slasher LakeMist",
    Default = false,
    Callback = function(v) W.MAWWW_SetLakeMist(v) end
})

KillerR2:AddToggle("BP_Pursuit", {
    Text = "Bypass Slasher Pursuit",
    Default = false,
    Callback = function(v) W.MAWWW_SetPursuit(v) end
})

KillerR2:AddToggle("BP_Abyss", {
    Text = "Bypass Abyss Cooldown",
    Default = false,
    Callback = function(v) W.MAWWW_SetAbyssBypass(v) end
})

KillerR2:AddToggle("BP_Jeff", {
    Text = "Bypass Jeff Frenzy",
    Default = false,
    Callback = function(v) W.MAWWW_SetJeffFrenzy(v) end
})

KillerR2:AddDivider()

KillerR2:AddToggle("SP_Enable", {
    Text = "Spear Aimbot",
    Default = false,
    Tooltip = "Auto aim spear ke survivor",
    Callback = function(v) W.SpearAimbot_SetEnabled(v) end
})

KillerR2:AddSlider("SP_Gravity", {
    Text = "Spear Gravity",
    Default = 50, Min = 10, Max = 200, Rounding = 0,
    Callback = function(v) W.SpearAimbot_SetGravity(v) end
})

KillerR2:AddSlider("SP_Speed", {
    Text = "Spear Speed",
    Default = 100, Min = 50, Max = 300, Rounding = 0,
    Callback = function(v) W.SpearAimbot_SetSpeed(v) end
})

KillerR2:AddDivider()

KillerR2:AddToggle("KAB_Stalk", {
    Text = "Auto Stalk (Myers)",
    Default = false,
    Callback = function(v) W.KA_SetAutoStalk(v) end
})

KillerR2:AddSlider("KAB_StalkRange", {
    Text = "Auto Stalk Range",
    Default = 150, Min = 20, Max = 500, Rounding = 0,
    Suffix = " studs",
    Callback = function(v)
        W.KillerAbilities.AutoStalkRange = v
        PAZZHUB.KA_AutoStalkRange = v
    end
})

KillerR2:AddToggle("KAB_KillAll", {
    Text = "Auto Kill All",
    Default = false,
    Callback = function(v) W.KA_SetAutoKillAll(v) end
})

KillerR2:AddToggle("KAB_DropPallet", {
    Text = "Drop All Pallet",
    Default = false,
    Callback = function(v) W.KA_SetDropAllPallet(v) end
})

KillerR2:AddToggle("KAB_BlockVault", {
    Text = "Block All Vault",
    Default = false,
    Callback = function(v) W.KA_SetBlockAllVault(v) end
})

KillerR2:AddToggle("KAB_AutoHook", {
    Text = "Auto Hook",
    Default = false,
    Tooltip = "Auto carry & hook downed survivor",
    Callback = function(v) W.KA_SetAutoHook(v) end
})

KillerR2:AddDivider()

KillerR2:AddToggle("FLK_Enable", {
    Text = "Silent Flask",
    Default = false,
    Tooltip = "Auto-aim flask (The Cure)",
    Callback = function(v) W.Flask_SetEnabled(v) end
})

KillerR2:AddToggle("FLK_Beam", {
    Text = "Flask Show Beam",
    Default = true,
    Callback = function(v) PAZZHUB.FLASK_ShowBeam = v end
})

KillerR2:AddToggle("FLK_Landing", {
    Text = "Flask Show Landing",
    Default = true,
    Callback = function(v) PAZZHUB.FLASK_ShowLanding = v end
})

KillerR2:AddToggle("FLK_Predict", {
    Text = "Flask Prediction",
    Default = true,
    Callback = function(v) PAZZHUB.FLASK_Predict = v end
})

KillerR2:AddSlider("FLK_Speed", {
    Text = "Flask Speed",
    Default = 90, Min = 30, Max = 200, Rounding = 0,
    Callback = function(v) W.Flask_SetSpeed(v) end
})

KillerR2:AddSlider("FLK_Gravity", {
    Text = "Flask Gravity",
    Default = 196, Min = 50, Max = 400, Rounding = 0,
    Callback = function(v) W.Flask_SetGravity(v) end
})

KillerR2:AddDivider()

KillerR2:AddToggle("DL_Enable", {
    Text = "Dash Lock",
    Default = false,
    Tooltip = "Auto lock camera saat dash",
    Callback = function(v) W.DashLock_SetEnabled(v) end
})

KillerR2:AddSlider("DL_Duration", {
    Text = "Dash Lock Duration",
    Default = 1.5, Min = 0.5, Max = 5, Rounding = 1,
    Suffix = "s",
    Callback = function(v) PAZZHUB.DashLockDuration = v end
})

KillerR2:AddSlider("DL_Smooth", {
    Text = "Dash Lock Smoothness",
    Default = 0.3, Min = 0.05, Max = 1, Rounding = 2,
    Callback = function(v) PAZZHUB.DashLockSmoothness = v end
})

KillerR2:AddToggle("DL_Freeze", {
    Text = "Dash Lock Freeze",
    Default = false,
    Callback = function(v) PAZZHUB.FreezeDuringDashLock = v end
})

-- [PART 9d: UI BUILD Obsidian — Misc Tab DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 9d: UI BUILD Obsidian — Misc Tab
--═══════════════════════════════════════════════════════════--

local MiscTab = Tabs.Misc

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KIRI: Stun + Invisibility + Player Utility
--═══════════════════════════════════════════════════════════--
local MiscL = MiscTab:AddLeftGroupbox("Indicator & Invis", "eye-off")

MiscL:AddToggle("MI_Stun", {
    Text = "Stun Indicator",
    Default = false,
    Tooltip = "Warning kalau killer lagi stunned",
    Callback = function(v) W.SInd_SetEnabled(v) end
})

MiscL:AddDropdown("MI_StunSound", {
    Text = "Stun Sound",
    Values = {"Default","Clash Royale","Blash","Coin","Kururin Kuru","Spongebob","Fahhhh","Cave","Aughhh","Samsung","iPhone","Siren"},
    Default = "Default",
    Callback = function(v) W.StunIndicator.SelectedSound = v end
})

MiscL:AddToggle("MI_StunSoundOn", {
    Text = "Sound Alert",
    Default = true,
    Callback = function(v) W.StunIndicator.SoundEnabled = v end
})

MiscL:AddSlider("MI_StunRange", {
    Text = "Stun Detect Range",
    Default = 500, Min = 50, Max = 2000, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.StunIndicator.Range = v end
})

MiscL:AddSlider("MI_StunVol", {
    Text = "Sound Volume",
    Default = 1.5, Min = 0, Max = 5, Rounding = 1,
    Callback = function(v) W.StunIndicator.SoundVolume = v end
})

MiscL:AddDivider()

MiscL:AddToggle("MI_Invis", {
    Text = "Invisibility",
    Default = false,
    Tooltip = "Real invisibility (MengHub API)",
    Callback = function(v)
        W.Invisible_SetState(v, false)
        if getgenv().PAZZHUB_InvisBtn_UpdateVisual then getgenv().PAZZHUB_InvisBtn_UpdateVisual() end
    end
})

MiscL:AddKeyPicker("MI_InvisKey", {
    Text = "Invis Hotkey",
    Default = "G",
    Mode = "Toggle",
    Callback = function(v) PAZZHUB.Invis_Hotkey = v end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KANAN: Player Utility
--═══════════════════════════════════════════════════════════--
local MiscR = MiscTab:AddRightGroupbox("Player Utility", "tool")

MiscR:AddToggle("PU_SpeedHack", {
    Text = "Speed Hack",
    Default = false,
    Callback = function(v)
        W.PU.SpeedEnabled = v
        if not v then
            local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = 16 end
        end
    end
})

MiscR:AddSlider("PU_SpeedVal", {
    Text = "Speed Value",
    Default = 16, Min = 16, Max = 200, Rounding = 0,
    Callback = function(v) W.PU.SpeedValue = v end
})

MiscR:AddToggle("PU_ShiftLock", {
    Text = "Shift Lock",
    Default = false,
    Callback = function(v) W.PU.ShiftLock = v end
})

MiscR:AddToggle("PU_SkipEnd", {
    Text = "Skip End Screen",
    Default = false,
    Callback = function(v) W.PU.SkipEndScreen = v end
})

MiscR:AddToggle("PU_HideIcon", {
    Text = "Hide Survivor Icon",
    Default = false,
    Callback = function(v) W.PU.HideSurvivorIcon = v end
})

MiscR:AddToggle("PU_PingFPS", {
    Text = "Show Ping & FPS",
    Default = false,
    Callback = function(v) W.PU.ShowPingFPS = v end
})

MiscR:AddToggle("PU_HideName", {
    Text = "Hide Name",
    Default = false,
    Callback = function(v) W.PU_SetHideName(v) end
})

MiscR:AddToggle("PU_Zoom", {
    Text = "Unlimited Zoom",
    Default = false,
    Callback = function(v) W.PU.UnlimitedZoom = v end
})

MiscR:AddToggle("PU_Noclip", {
    Text = "Noclip",
    Default = false,
    Callback = function(v)
        W.PU.Noclip = v
        if not v then W.PU_RestoreNoclip() end
    end
})

MiscR:AddDivider()

MiscR:AddToggle("PU_SpeedBoost", {
    Text = "Speed Boost",
    Default = false,
    Tooltip = "Auto apply WalkSpeed (disable saat attack/stun/downed)",
    Callback = function(v) W.SpeedBoost_SetEnabled(v) end
})

MiscR:AddSlider("PU_SpeedBoostVal", {
    Text = "Boost Speed Value",
    Default = 30, Min = 16, Max = 100, Rounding = 0,
    Callback = function(v) W.SpeedBoost_SetValue(v) end
})

MiscR:AddDivider()

MiscR:AddToggle("PU_Cursor", {
    Text = "Cursor Unlock",
    Default = false,
    Tooltip = "Hotkey Alt / AltGr",
    Callback = function(v) W.Cursor_SetEnabled(v) end
})

MiscR:AddButton({
    Text = "Toggle Cursor Now",
    Func = function() W.Cursor_SetEnabled(not PAZZHUB.CursorEnabled) end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KIRI BAWAH: Emote + Fake Avatar + Korless + Header
--═══════════════════════════════════════════════════════════--
local MiscL2 = MiscTab:AddLeftGroupbox("Troll & Fun", "sparkles")

MiscL2:AddToggle("TF_Emote", {
    Text = "Emote",
    Default = false,
    Callback = function(v) W.EmoteSystem_SetEnabled(v) end
})

MiscL2:AddDropdown("TF_EmoteSelect", {
    Text = "Select Emote",
    Values = W.EmoteSystem.Options,
    Default = "Friday Night",
    Callback = function(v) W.EmoteSystem_SelectEmote(v) end
})

MiscL2:AddButton({
    Text = "Stop Emote",
    Func = function()
        W.EmoteSystem_Stop()
        W.EmoteSystem.Enabled = false
    end
})

MiscL2:AddDivider()

MiscL2:AddDropdown("TF_AvatarPreset", {
    Text = "Fake Avatar Preset",
    Values = { "Self Avatar","Random 1","Random 2","Random 3","Random 4","Random 5","Random 6","Random 7",
        "WoozyNate","Nicholas","yvlyf","traevp","J0LLY","LucashDev","CEOofIsaac","Stealthy","Wildes","Talon",
        "Relukt","Sammy","Diesel","S4ans03","Aura","iJava","White Guy","Purple King","Kachaaaa Gay","Mpruyyy" },
    Default = "Self Avatar",
    Callback = function(opt)
        local ids = {
            ["Self Avatar"] = LocalPlayer.UserId, ["Random 1"] = 2888298851, ["Random 2"] = 10074747755,
            ["Random 3"] = 5209567453, ["Random 4"] = 8991982843, ["Random 5"] = 5796319029,
            ["Random 6"] = 9744452117, ["Random 7"] = 8476755006, ["WoozyNate"] = 146089324,
            ["Nicholas"] = 909635, ["yvlyf"] = 181751703, ["traevp"] = 471607078, ["J0LLY"] = 1073847038,
            ["LucashDev"] = 2525651744, ["CEOofIsaac"] = 63238912, ["Stealthy"] = 56602747,
            ["Wildes"] = 40397833, ["Talon"] = 75974130, ["Relukt"] = 65042011, ["Sammy"] = 2678001507,
            ["Diesel"] = 9123921576, ["S4ans03"] = 35439794, ["Aura"] = 2275806428, ["iJava"] = 276557820,
            ["White Guy"] = 8843268357, ["Purple King"] = 9070758608,
            ["Kachaaaa Gay"] = 8956318334, ["Mpruyyy"] = 8340163775
        }
        W.FakeAvatar_SetId(ids[opt] or LocalPlayer.UserId)
    end
})

MiscL2:AddToggle("TF_AvatarEnable", {
    Text = "Enable Fake Avatar",
    Default = false,
    Callback = function(v) W.FakeAvatar_Set(v) end
})

local AvatarUsernameInput = ""
MiscL2:AddInput("TF_AvatarUser", {
    Text = "Fake Avatar Username",
    Default = "",
    Placeholder = "username",
    Callback = function(v) AvatarUsernameInput = (v or ""):gsub("^@", "") end
})

MiscL2:AddButton({
    Text = "Apply Avatar From Username",
    Func = function()
        if AvatarUsernameInput ~= "" then W.FakeAvatar_FromUsername(AvatarUsernameInput) end
    end
})

MiscL2:AddDivider()

MiscL2:AddToggle("TF_Korless", {
    Text = "Korless Morph",
    Default = false,
    Callback = function(v) W.Korless_Set(v) end
})

MiscL2:AddDivider()

local HeaderTextInput = "PAZZHUB"
MiscL2:AddInput("TF_HeaderText", {
    Text = "Header Text",
    Default = "PAZZHUB",
    Placeholder = "Nama header...",
    Callback = function(v) HeaderTextInput = v; W.Header_SetText(v) end
})

MiscL2:AddToggle("TF_HeaderEnable", {
    Text = "Enable Header Title",
    Default = false,
    Callback = function(v) W.Header_Set(v) end
})

MiscL2:AddColorPicker("TF_HeaderColor", {
    Title = "Header Color",
    Default = Color3.fromRGB(255, 255, 255),
    Transparency = 0,
    Callback = function(c) W.Header_SetColor(c) end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KANAN BAWAH: Spectator + Jerk Off + No Fall + Map
--═══════════════════════════════════════════════════════════--
local MiscR2 = MiscTab:AddRightGroupbox("Extras", "info")

MiscR2:AddToggle("EX_Spectator", {
    Text = "Spectator Counter",
    Default = false,
    Callback = function(v) W.Spectator_Set(v) end
})

MiscR2:AddToggle("EX_JerkOff", {
    Text = "Jerk Off Tool",
    Default = false,
    Tooltip = "Meme tool 😂",
    Callback = function(v) W.JerkOff_SetEnabled(v) end
})

MiscR2:AddDivider()

MiscR2:AddToggle("EX_NoFall", {
    Text = "No Fall Damage",
    Default = false,
    Callback = function(v) PAZZHUB.NoFallDamage = v end
})

MiscR2:AddToggle("EX_MapPredict", {
    Text = "Next Map Prediction",
    Default = false,
    Callback = function(v) W.NextMapPredict_SetEnabled(v) end
})

MiscR2:AddDivider()

MiscR2:AddToggle("EX_PerksDisplay", {
    Text = "Killer Perks Display",
    Default = false,
    Tooltip = "White theme GUI untuk nampilin perk killer",
    Callback = function(v) W.KillerPerksDisplay_SetEnabled(v) end
})

MiscR2:AddDivider()

MiscR2:AddToggle("EX_Notify", {
    Text = "Enable Notifications",
    Default = true,
    Callback = function(v) W.NotifyEnabled = v end
})

-- [PART 9e: UI BUILD Obsidian — Config Tab + Init DISISIPKAN DI SINI]--═══════════════════════════════════════════════════════════--
-- PART 9e: UI BUILD Obsidian — Config Tab + Init + Closing
--═══════════════════════════════════════════════════════════--

local ConfigTab = Tabs.Config

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KIRI: SaveManager Config
--═══════════════════════════════════════════════════════════--
local ConfigL = ConfigTab:AddLeftGroupbox("Config Manager", "save")

ConfigL:AddInput("CFG_Name", {
    Text = "Config Name",
    Default = "",
    Placeholder = "MyConfig",
    Finished = true,
    Callback = function(v) end
})

ConfigL:AddButton({
    Text = "Save Config",
    Func = function()
        SaveManager:Save(ConfigL:GetValue("CFG_Name"))
        PAZZHUB_Notify("Config", "Saved", 2)
    end
})

ConfigL:AddDropdown("CFG_List", {
    Text = "Saved Configs",
    Values = {},
    Default = "",
    Callback = function(v) end
})

ConfigL:AddButton({
    Text = "Load Config",
    Func = function()
        local name = ConfigL:GetValue("CFG_List")
        if name and name ~= "" then
            SaveManager:Load(name)
            PAZZHUB_Notify("Config", "Loaded: " .. name, 2)
        end
    end
})

ConfigL:AddButton({
    Text = "Refresh List",
    Func = function()
        SaveManager:Refresh()
        PAZZHUB_Notify("Config", "Refreshed", 2)
    end
})

ConfigL:AddButton({
    Text = "Delete Config",
    Func = function()
        local name = ConfigL:GetValue("CFG_List")
        if name and name ~= "" then
            SaveManager:Delete(name)
            PAZZHUB_Notify("Config", "Deleted: " .. name, 2)
        end
    end
})

ConfigL:AddDivider()

ConfigL:AddToggle("CFG_AutoSave", {
    Text = "Auto Save",
    Default = false,
    Callback = function(v) PAZZHUB.Config_AutoSave = v end
})

ConfigL:AddToggle("CFG_AutoLoad", {
    Text = "Auto Load",
    Default = false,
    Callback = function(v) PAZZHUB.Config_AutoLoad = v end
})

--═══════════════════════════════════════════════════════════--
-- GROUPBOX KANAN: UI Settings + Theme
--═══════════════════════════════════════════════════════════--
local ConfigR = ConfigTab:AddRightGroupbox("UI Settings", "palette")

ConfigR:AddDropdown("UI_NotifySide", {
    Text = "Notification Side",
    Values = {"Left", "Right"},
    Default = "Right",
    Callback = function(v) Library:SetNotifySide(v) end
})

ConfigR:AddDropdown("UI_DPI", {
    Text = "DPI Scale",
    Values = {"50%", "75%", "85%", "100%", "125%", "150%"},
    Default = "85%",
    Callback = function(v)
        v = v:gsub("%%", "")
        Library:SetDPIScale(tonumber(v))
    end
})

ConfigR:AddToggle("UI_Cursor", {
    Text = "Custom Cursor",
    Default = true,
    Callback = function(v) Library.ShowCustomCursor = v end
})

ConfigR:AddToggle("UI_Watermark", {
    Text = "Watermark",
    Default = true,
    Callback = function(v)
        if Watermark then Watermark.Visible = v end
    end
})

ConfigR:AddDivider()

ConfigR:AddSlider("UI_CornerRadius", {
    Text = "Window Corner Radius",
    Default = 14, Min = 0, Max = 20, Rounding = 0,
    Callback = function(v)
        if Window.SetCornerRadius then
            Window:SetCornerRadius(v)
        end
    end
})

ConfigR:AddDivider()

ConfigR:AddLabel("PAZZHUB v2.0 — Obsidian Edition")
ConfigR:AddLabel("Logic: ALFzxzzz HUB v0.3.7")
ConfigR:AddLabel("Free Script - Jangan Dijual!")

ConfigR:AddDivider()

ConfigR:AddButton({
    Text = "Unload Script",
    Func = function()
        Library:Unload()
    end
})

--═══════════════════════════════════════════════════════════--
-- THEME MANAGER + SAVE MANAGER SETUP
--═══════════════════════════════════════════════════════════--
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
ThemeManager:SetFolder("PAZZHUB")
SaveManager:SetFolder("PAZZHUB/configs")

-- Auto-refresh config list (update values di dropdown)
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            local configs = {}
            if listfiles and isfolder then
                if not isfolder("PAZZHUB/configs") then
                    if makefolder then
                        if not isfolder("PAZZHUB") then makefolder("PAZZHUB") end
                        makefolder("PAZZHUB/configs")
                    end
                end
                local files = listfiles("PAZZHUB/configs")
                for _, f in ipairs(files) do
                    local name = f:match("([^/\\]+)%.json$") or f:match("([^/\\]+)$")
                    if name then table.insert(configs, name) end
                end
            end
            if #configs > 0 then
                ConfigL:AddDropdown("CFG_List", {
                    Text = "Saved Configs",
                    Values = configs,
                    Default = configs[1] or "",
                    Callback = function() end,
                    DoubleClick = false,
                })
            end
        end)
    end
end)

--═══════════════════════════════════════════════════════════--
-- AUTO-ENABLE DEFAULT FLOATING BUTTONS
--═══════════════════════════════════════════════════════════--
task.spawn(function()
    task.wait(3)
    -- Default button yang langsung keliatan
    for _, fn in ipairs({
        "PAZZHUB_SHB_SetEnabled", "PAZZHUB_SUB_SetEnabled", "PAZZHUB_Escape_SetEnabled",
        "PAZZHUB_InvisBtn_SetEnabled", "PAZZHUB_MoonwalkBtn_SetEnabled", "PAZZHUB_SpearBtn_SetEnabled",
        "PAZZHUB_TTB_SetEnabled", "PAZZHUB_ParryBtn_SetEnabled", "PAZZHUB_MGrabBtn_SetEnabled",
        "PAZZHUB_PistolBtn_SetEnabled"
    }) do
        if getgenv()[fn] then pcall(getgenv()[fn], true) end
    end
end)

--═══════════════════════════════════════════════════════════--
-- LOADING NOTIF + CLOSING
--═══════════════════════════════════════════════════════════--
task.spawn(function()
    task.wait(0.5)
    PAZZHUB_Notify("PAZZHUB v2.0", "✅ Loaded Successfully!", 6)
    task.wait(1.5)
    PAZZHUB_Notify("PAZZHUB", "UI: Obsidian | Tema: Biru Neon", 5)
    task.wait(1.5)
    PAZZHUB_Notify("PAZZHUB", "Logic: ALFzxzzz HUB v0.3.7", 5)
    task.wait(1.5)
    PAZZHUB_Notify("PAZZHUB", "Free Script - Jangan Dijual!", 4)
end)

print("[PAZZHUB v2.0] ✅ Loaded Successfully!")
print("[PAZZHUB v2.0] UI: Obsidian (Biru Neon)")
print("[PAZZHUB v2.0] Logic: ALFzxzzz HUB v0.3.7")
print("[PAZZHUB v2.0] Tab: Survivor / Visuals / Killer / Misc / Config")
print("[PAZZHUB v2.0] Free Script - Jangan Dijual!")

--═══════════════════════════════════════════════════════════--
-- END OF SCRIPT
--═══════════════════════════════════════════════════════════--
