--========================================================--
-- PAZZHUB x ALFzxzzz HUB v0.3.7
-- Shell: PAZZHUB Obsidian UI
--========================================================--

getgenv().VD = getgenv().VD or {}
local W = getgenv()

--====================================================--
-- VARIABLE DEFAULTS
--====================================================--
VD.PARRY_Enabled        = VD.PARRY_Enabled or false
VD.PARRY_Aggressive     = VD.PARRY_Aggressive or false
VD.PARRY_Distance       = VD.PARRY_Distance or 10
VD.PARRY_ShowCircle     = VD.PARRY_ShowCircle or false
VD.PARRY_SilentParry    = VD.PARRY_SilentParry or false
VD.PARRY_ShowFloatBtn   = VD.PARRY_ShowFloatBtn or false
VD.AutoCrouch           = VD.AutoCrouch or false
VD.KILLER_AutoAttack         = VD.KILLER_AutoAttack or false
VD.KILLER_AutoAttackRange    = VD.KILLER_AutoAttackRange or 12
VD.KILLER_AutoAttackCooldown = VD.KILLER_AutoAttackCooldown or 0.15
VD.SURV_AutoFlee        = VD.SURV_AutoFlee or false
VD.SURV_AutoFleeDist    = VD.SURV_AutoFleeDist or 40
VD.SURV_AutoFleeCooldown= VD.SURV_AutoFleeCooldown or 1.5

VD.VeilEnabled          = VD.VeilEnabled or false
VD.VeilShowFOV          = VD.VeilShowFOV ~= false
VD.VeilShowTracker      = VD.VeilShowTracker or false
VD.VeilAutoPredict      = VD.VeilAutoPredict ~= false
VD.VeilFOV              = VD.VeilFOV or 150
VD.VeilMaxDist          = VD.VeilMaxDist or 280
VD.VeilSpearSpeed       = VD.VeilSpearSpeed or 165
VD.VeilGravity          = VD.VeilGravity or 103
VD.VeilAuraSpearSpeed   = VD.VeilAuraSpearSpeed or 165
VD.VeilAuraSpearGravity = VD.VeilAuraSpearGravity or 96
VD.VeilLeadMultiplier   = VD.VeilLeadMultiplier or 1.4

VD.TOF_SilentAim    = VD.TOF_SilentAim    or false
VD.TOF_TargetMode   = VD.TOF_TargetMode   or "Killer"
VD.TOF_Key          = VD.TOF_Key          or "Q"
VD.TOF_Laser        = VD.TOF_Laser        ~= false
VD.TOF_WallCheck    = VD.TOF_WallCheck    ~= false
VD.TOF_BlockKnocked = VD.TOF_BlockKnocked ~= false

VD.Invis_Enabled       = VD.Invis_Enabled       or false
VD.Invis_ShowFloatBtn  = VD.Invis_ShowFloatBtn  or false
VD.Invis_Hotkey        = VD.Invis_Hotkey        or "G"

VD.KILLER_BypassLeap     = VD.KILLER_BypassLeap     or false
VD.KILLER_InfGrab        = VD.KILLER_InfGrab        or false
VD.KILLER_InfLakeMist    = VD.KILLER_InfLakeMist    or false
VD.KILLER_InfPursuit     = VD.KILLER_InfPursuit     or false
VD.KILLER_BypassCooldown = VD.KILLER_BypassCooldown or false
VD.KILLER_InfFrenzy      = VD.KILLER_InfFrenzy      or false
VD.KILLER_AntiBlind      = VD.KILLER_AntiBlind      or false
VD.KILLER_DestroyPallets = VD.KILLER_DestroyPallets or false
VD.KILLER_InfLunge       = VD.KILLER_InfLunge       or false
VD.KILLER_AutoHook       = VD.KILLER_AutoHook       or false

VD.KA_AutoStalk       = VD.KA_AutoStalk       or false
VD.KA_AutoStalkRange  = VD.KA_AutoStalkRange  or 150
VD.KA_AutoKillAll     = VD.KA_AutoKillAll     or false
VD.KA_DropAllPallet   = VD.KA_DropAllPallet   or false
VD.KA_BlockAllVault   = VD.KA_BlockAllVault   or false

VD.SURV_FakeParry           = VD.SURV_FakeParry           or false
VD.SURV_FakeParryAnim       = VD.SURV_FakeParryAnim       or "Enten"
VD.SURV_FakeParryCooldown   = VD.SURV_FakeParryCooldown   or 0.4
VD.SURV_FakeParryKey        = VD.SURV_FakeParryKey        or "V"
VD.SURV_FakeParryShowBtn    = VD.SURV_FakeParryShowBtn    or false
VD.SURV_FakeParryLocked     = VD.SURV_FakeParryLocked     or false

VD.NoFallDamage         = VD.NoFallDamage or false
VD.NextMapPredict       = VD.NextMapPredict or false
VD.ManualGen            = VD.ManualGen or false
VD.AutoGen              = VD.AutoGen or false
VD.KillerEscapeDist     = VD.KillerEscapeDist or 30

VD.Wisnu_AutoParry       = VD.Wisnu_AutoParry       or false
VD.Wisnu_ParryAggressive = VD.Wisnu_ParryAggressive or false
VD.Wisnu_ParrySafety     = VD.Wisnu_ParrySafety     or false
VD.Wisnu_ParryDistance   = VD.Wisnu_ParryDistance   or 6
VD.Wisnu_ParryFace       = VD.Wisnu_ParryFace       or 0.7
VD.Wisnu_ParryCircle     = VD.Wisnu_ParryCircle     or true
VD.Wisnu_IgnoredSkills   = VD.Wisnu_IgnoredSkills   or {}

VD.KillerPerksDisplay   = VD.KillerPerksDisplay   or false
VD.SpeedBoostEnabled    = VD.SpeedBoostEnabled    or false
VD.SpeedBoostValue      = VD.SpeedBoostValue      or 30
VD.CursorEnabled        = VD.CursorEnabled        or false

W.InstantHealSelf = W.InstantHealSelf or false
W.AutoHealAll     = W.AutoHealAll or false

_G.GLUTO_ACCENT     = Color3.fromRGB(120, 120, 120)
_G.GLUTO_ACCENT_BG  = Color3.fromRGB(0, 0, 0)
_G.GLUTO_NEUTRAL    = Color3.fromRGB(90, 90, 90)
_G.GLUTO_STROKE_OFF = Color3.fromRGB(25, 25, 25)
_G.GLUTO_BG_OFF     = Color3.fromRGB(0, 0, 0)

--====================================================--
-- PAZZHUB OBSIDIAN UI LOAD
--====================================================--
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

if not Library then warn("[PAZZHUB] Obsidian gagal load!"); return end

-- Tema Biru Neon
Library.Scheme.AccentColor     = Color3.fromRGB(0, 170, 255)
Library.Scheme.BackgroundColor = Color3.fromRGB(8, 14, 26)
Library.Scheme.MainColor       = Color3.fromRGB(16, 24, 42)
Library.Scheme.OutlineColor    = Color3.fromRGB(0, 120, 200)
Library.Scheme.FontColor       = Color3.fromRGB(200, 230, 255)

local TOGGLE_ICON = 72845574620852
local ACCENT = Color3.fromRGB(0, 170, 255)

W.Library = Library
W.ThemeManager = ThemeManager
W.SaveManager = SaveManager

--====================================================--
-- PAZZHUB FLOATING TOGGLE
--====================================================--
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
        game:GetService("TweenService"):Create(Glow, TweenInfo.new(.15), { Transparency = 0.3 }):Play()
    end)

    MainButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(MainButton, TweenInfo.new(.15), {
            BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        }):Play()
        game:GetService("TweenService"):Create(Glow, TweenInfo.new(.15), { Transparency = 0.6 }):Play()
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

CreatePazzToggle(TOGGLE_ICON)--====================================================--
-- MAIN FUNCTION
--====================================================--
local function __Gluto_Init_Main__()

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

    local LocalPlayer = Players.LocalPlayer
    local LP = LocalPlayer
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    local VirtualInputManager = nil
    pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)
    local VIM = VirtualInputManager

    --====================================================--
    -- WINDOW
    --====================================================--
    local Window = Library:CreateWindow({
        Title = "PAZZHUB",
        Footer = "Violence District",
        Icon = 72845574620852,
        IconSize = UDim2.fromOffset(34, 34),
        CornerRadius = 14,
        NotifySide = "Right",
        ShowCustomCursor = true,
        ShowMobileButtons = false,
        ToggleKeybind = Enum.KeyCode.LeftControl,
        Size = UDim2.fromOffset(500, 320),
        EnableSidebarResize = false,
        EnableCompacting = true,
        SidebarCompacted = true,
    })

    --====================================================--
    -- WATERMARK
    --====================================================--
    local Watermark = Library:AddDraggableLabel("PAZZHUB")
    local _Stats = game:GetService("Stats")
    local _FPS, _Frames, _LastTick = 0, 0, tick()
    RunService.RenderStepped:Connect(function()
        _Frames = _Frames + 1
        if tick() - _LastTick >= 1 then
            _FPS = _Frames; _Frames = 0; _LastTick = tick()
            local ok2, ping = pcall(function()
                return math.floor(_Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            Watermark:SetText(string.format("PAZZHUB | FPS: %d | PING: %d ms", _FPS, ping or 0))
        end
    end)

    --====================================================--
    -- TABS
    --====================================================--
    local SurvivorTab     = Window:AddTab("Survivor", "user")
    local ParryTab        = Window:AddTab("Parry", "shield")
    local GenTab          = Window:AddTab("Gen", "wrench")
    local SurvUtilTab     = Window:AddTab("Surv Util", "tool")
    local KillerTab       = Window:AddTab("Killer", "crosshair")
    local KillerAimTab    = Window:AddTab("Killer Aim", "target")
    local KillerVeilTab   = Window:AddTab("Killer Veil", "zap")
    local VisualsTab      = Window:AddTab("Visuals", "eye")
    local GraphicsTab     = Window:AddTab("Graphics", "monitor")
    local MiscTab         = Window:AddTab("Misc", "settings")
    local ConfigTab       = Window:AddTab("Config", "save")
    local InfoTab         = Window:AddTab("Info", "info")

    --====================================================--
    -- UID HELPER
    --====================================================--
    local _uid = 0
    local function UID(prefix)
        _uid = _uid + 1
        return tostring(prefix or "el") .. "_" .. _uid
    end

    --====================================================--
    -- INFO TAB
    --====================================================--
    local InfoBox = InfoTab:AddLeftGroupbox("Script Info", "info")
    InfoBox:AddLabel("Script: PAZZHUB")
    InfoBox:AddLabel("Shell: Obsidian UI")
    InfoBox:AddLabel("Base: ALFzxzzz v0.3.7")
    InfoBox:AddDivider()
    InfoBox:AddLabel("Owner: ALFzxzzz")
    InfoBox:AddLabel("Dev: Vanzxzz")

    local DiscBox = InfoTab:AddRightGroupbox("Discord", "message-circle")
    DiscBox:AddLabel("ALFzxzzz Hub - Community")
    DiscBox:AddDivider()
    DiscBox:AddLabel("Discord: discord.gg/NvZAbsYw")
    DiscBox:AddLabel("Info update & giveaway")

    --====================================================--
    -- NOTIFY
    --====================================================--
    W.NotifyEnabled = W.NotifyEnabled ~= false

    local function ShowNotify(title, message, duration)
        if not W.NotifyEnabled then return end
        pcall(function()
            Library:Notify({
                Title = tostring(title or "PAZZHUB"),
                Content = tostring(message or ""),
                Duration = tonumber(duration) or 2,
            })
        end)
    end
    local function VD_Notify(title, content, duration) ShowNotify(title, content, duration) end
    local function ForceNotify(title, message, duration)
        pcall(function()
            Library:Notify({
                Title = tostring(title or "PAZZHUB"),
                Content = tostring(message or ""),
                Duration = tonumber(duration) or 2,
            })
        end)
    end
    W.Notify = ShowNotify
    W.VD_Notify = VD_Notify
    W.ForceNotify = ForceNotify

    --====================================================--
    -- TEAM HELPER
    --====================================================--
    local function TeamIs(plr, role)
        if not plr or not plr.Team or not plr.Team.Name then return false end
        local tn = string.lower(plr.Team.Name)
        if role == "Killer" then return string.find(tn, "killer", 1, true) ~= nil end
        if role == "Survivor" then return string.find(tn, "survivor", 1, true) ~= nil end
        return false
    end
    W.TeamIs = TeamIs

    local function GetRole()
        if TeamIs(LP, "Killer") then return "Killer" end
        if TeamIs(LP, "Survivor") then return "Survivor" end
        return nil
    end
    W.GetRole = GetRole

    --====================================================--
    -- GENERATOR HELPERS
    --====================================================--
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

    --====================================================--
    -- GLOBAL VARIABEL UNTUK PART BERIKUTNYA
    --====================================================--
    W._LocalPlayer = LP
    W._Players = Players
    W._RunService = RunService
    W._UserInputService = UserInputService
    W._ReplicatedStorage = ReplicatedStorage
    W._Workspace = Workspace
    W._CoreGui = CoreGui
    W._CollectionService = CollectionService
    W._TweenService = TweenService
    W._GuiService = GuiService
    W._HttpService = HttpService
    W._Lighting = Lighting
    W._isMobile = isMobile
    W._VIM = VIM
    W._Window = Window
    W._UID = UID

    -- Tab globals
    W.T_Surv      = SurvivorTab
    W.T_Parry     = ParryTab
    W.T_Gen       = GenTab
    W.T_SurvUtil  = SurvUtilTab
    W.T_Kill      = KillerTab
    W.T_KillAim   = KillerAimTab
    W.T_KillVeil  = KillerVeilTab
    W.T_Vis       = VisualsTab
    W.T_Graphics  = GraphicsTab
    W.T_Misc      = MiscTab
    W.T_Cfg       = ConfigTab
    W.T_Info      = InfoTab--====================================================--
-- AUTO CROUCH DODGE
--====================================================--
function IsDowned(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local state = char:GetAttribute("State")
    return state == "Downed" or state == "Dead"
end
W.IsDowned = IsDowned

function TriggerCrouch()
    local startT = tick()
    task.spawn(function()
        local char = LP.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        pcall(function() char:SetAttribute("Crouching", true) end)
        pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
        pcall(function() ReplicatedStorage.Remotes.Chase.Runevent:FireServer(char, false) end)
        if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end) end
        pcall(function()
            local survMob = LP:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
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
            local survMob = LP:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
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
W.TriggerCrouch = TriggerCrouch

local DodgeAttached = {}
local function IsKiller(p) return p.Team and p.Team.Name == "Killer" end

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
            local myChar = LP.Character
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

local function TryAttach(p)
    if p ~= LP and IsKiller(p) and p.Character then AttachParrySensor(p.Character) end
end

local function SetupPlayer(p)
    if p == LP then return end
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

--====================================================--
-- AUTO ATTACK (KILLER)
--====================================================--
local lastAutoAttack = 0
function W.KA_AutoAttack()
    if not VD.KILLER_AutoAttack then return end
    if GetRole() ~= "Killer" then return end
    local now = tick()
    if now - lastAutoAttack < (VD.KILLER_AutoAttackCooldown or 0.15) then return end
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local closest, shortest = nil, VD.KILLER_AutoAttackRange or 12
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and TeamIs(plr, "Survivor") and plr.Character then
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

--====================================================--
-- AUTO FLEE KILLER (SURVIVOR)
--====================================================--
local lastAutoFlee = 0
function W.SURV_AutoFlee()
    if not VD.SURV_AutoFlee then return end
    if GetRole() ~= "Survivor" then return end
    local now = tick()
    if now - lastAutoFlee < (VD.SURV_AutoFleeCooldown or 1.5) then return end
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not myRoot or not hum or hum.Health <= 0 then return end
    local killerRoot = nil
    local nearest = math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and TeamIs(plr, "Killer") and plr.Character then
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
        VD_Notify("Auto Flee", "Teleported away from killer!", 2)
    end
end

task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(W.KA_AutoAttack)
        pcall(W.SURV_AutoFlee)
    end
end)--====================================================--
-- AUTO PARRY V1 (GLUTO ORIGINAL)
--====================================================--
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
    if i == LP.Character then ParryCooldown.IsSilenced = true end
end)
CollectionService:GetInstanceRemovedSignal("Silenced"):Connect(function(i)
    if i == LP.Character then ParryCooldown.IsSilenced = false end
end)
LP.CharacterAdded:Connect(function(c) task.wait(0.5); ParryHookSilenced(c) end)
if LP.Character then ParryHookSilenced(LP.Character) end

local ParryCharCache = { Char=nil, Root=nil, Hum=nil, UpperTorso=nil, CheckInt=nil }
local function ParryGetCharCache()
    local char = LP.Character
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
    local char = LP.Character
    if char then
        local d = char:FindFirstChild("Parrying Dagger")
        if ParryIsDaggerModel(d) then hasDagger = true end
    end
    if not hasDagger then
        local wsChar = Workspace:FindFirstChild(LP.Name)
        if wsChar then
            local d = wsChar:FindFirstChild("Parrying Dagger")
            if ParryIsDaggerModel(d) then hasDagger = true end
        end
    end
    DaggerCache.Value = hasDagger
    return hasDagger
end
LP.CharacterAdded:Connect(function() DaggerCache.Value = false; DaggerCache.LastCheck = 0 end)

local ParryCheckAttrs = {"isVaulting","isSliding","isDroppingPallet","isRepairing","isHealing","isUnhooking","isExiting"}
local function ParryIsBusy()
    local cc = ParryGetCharCache()
    if not cc.Char then return true end
    if LP:GetAttribute("IsDead") then return true end
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
    local pGui = LP:FindFirstChildOfClass("PlayerGui")
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
    if VD.PARRY_SilentParry then ParryExecuteSilent(); return end
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
local existingPGui = LP:FindFirstChildOfClass("PlayerGui")
if existingPGui then ParryAttachPlayerGui(existingPGui) end
LP.ChildAdded:Connect(function(c)
    if c:IsA("PlayerGui") then ParryAttachPlayerGui(c) end
end)

local function ParryGetHitboxPart(char)
    if not char then return nil end
    return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
end
local function ParryCheckAndParry(killerChar)
    if ParryIsOnCooldown() or ParryCooldown.WaitingForResult
        or ParryCooldown.IsSilenced or not ParryIsEquippedDagger() then return end
    local cc = ParryGetCharCache()
    local myRoot = cc.UpperTorso or cc.Root
    local killerPart = ParryGetHitboxPart(killerChar)
    if not myRoot or not killerPart then return end
    local dist = (myRoot.Position - killerPart.Position).Magnitude
    if VD.PARRY_Aggressive then
        local ping = math.clamp(LP:GetNetworkPing(), 0, 0.3)
        local killerRoot = killerChar:FindFirstChild("HumanoidRootPart") or killerPart
        local killerVel = killerRoot.AssemblyLinearVelocity
        local flatVel = Vector3.new(killerVel.X, 0, killerVel.Z)
        local predictedPos = killerPart.Position + flatVel * ping
        local predDist = (myRoot.Position - predictedPos).Magnitude
        if predDist <= ((VD.PARRY_Distance or 10) + 2.5) then
            if flatVel.Magnitude > 6 then
                local dir = myRoot.Position - killerPart.Position
                if dir.Magnitude > 0 and flatVel.Unit:Dot(dir.Unit) > 0.4 then ParryExecute(); return end
            end
        end
    end
    if dist <= (VD.PARRY_Distance or 10) then ParryExecute() end
end
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
getgenv()._Gluto_DestroyParryCircle = ParryDestroyCircle
local function ParryBuildCircle(radius)
    ParryDestroyCircle()
    local folder = Instance.new("Folder")
    folder.Name = "GlutoParryCircleDashes"
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
        if not VD.PARRY_Enabled then return end
        if not ParryIsEquippedDagger() then return end
        local at = ParryGetAnimType(track)
        if at then
            ParryState.ActiveAttackers[plr] = { char = char, track = track, type = at, registeredAt = os.clock() }
        end
    end)
end
local function ParryHookKillerPlayer(plr)
    if plr == LP then return end
    if plr.Character then ParryHookAnimatorOnChar(plr, plr.Character) end
    plr.CharacterAdded:Connect(function(char) task.wait(0.5); ParryHookAnimatorOnChar(plr, char) end)
end
for _, p in ipairs(Players:GetPlayers()) do ParryHookKillerPlayer(p) end
Players.PlayerAdded:Connect(ParryHookKillerPlayer)
local parryLastPoll = 0
local function ParryPollAttacks()
    if not VD.PARRY_Enabled or not ParryIsEquippedDagger() then return end
    local now = os.clock()
    if now - parryLastPoll < 0.15 then return end
    parryLastPoll = now
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
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
local function ParryUpdateLogic()
    if not VD.PARRY_Enabled then return end
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
    local char = LP.Character
    local myRoot = char and char:FindFirstChild("HumanoidRootPart")
    if VD.PARRY_ShowCircle and VD.PARRY_Enabled and ParryIsEquippedDagger() and myRoot then
        if not ParryState.CircleFolder or ParryState.CircleRadius ~= (VD.PARRY_Distance or 10) or not ParryState.CircleFolder.Parent then
            ParryBuildCircle(VD.PARRY_Distance or 10)
        end
        ParryUpdateCircle(myRoot)
    else
        if ParryState.CircleFolder then ParryDestroyCircle() end
    end
end

-- Expose ke W biar bisa diakses part lain
W._ParryState = ParryState
W._ParryCooldown = ParryCooldown
W._ParryDestroyCircle = ParryDestroyCircle

local parryLastLogic, parryLastCircle = 0, 0
RunService.Heartbeat:Connect(function()
    local now = os.clock()
    if now - parryLastCircle >= 0.033 then parryLastCircle = now; pcall(ParryUpdateCircleLogic) end
    if now - parryLastLogic >= 0.05 then parryLastLogic = now; pcall(ParryUpdateLogic) end
end)--====================================================--
-- AUTO PARRY V2 (WISNU PARRY)
--====================================================--
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

    local function W_IsKiller(p) return p and p.Team and p.Team.Name == "Killer" end
    local function W_IsDowned(char) return char and (char:GetAttribute("Knocked") == true or char:GetAttribute("IsHooked") == true) end
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

    local function W_PressRightClick()
        if not VirtualInputManager then return end
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
            task.wait()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
        end)
    end

    local function W_TapMobileParryButton()
        local playerGui = LP:FindFirstChild("PlayerGui")
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

    local function W_TriggerCrouch()
        local startT = tick()
        task.spawn(function()
            local char = LP.Character
            if not char then return end
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            pcall(function() char:SetAttribute("Crouching", true) end)
            pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
            pcall(function() ReplicatedStorage.Remotes.Chase.Runevent:FireServer(char, false) end)
            if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end) end
            pcall(function()
                local survMob = LP:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
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
                local survMob = LP:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
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

            if id == "80411309607666" and VD.AutoCrouch then
                local myChar = LP.Character
                if W_IsDowned(myChar) then return end
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local kHRP = kChar:FindFirstChild("HumanoidRootPart")
                if myHRP and kHRP then
                    if (myHRP.Position - kHRP.Position).Magnitude <= 40 then W_TriggerCrouch() end
                end
                return
            end

            if not VD.Wisnu_AutoParry then return end
            if W_State.Cooldown then return end
            if VD.Wisnu_IgnoredSkills and VD.Wisnu_IgnoredSkills[attackName] then return end

            local myChar = LP.Character
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
        if p ~= LP and W_IsKiller(p) and p.Character then W_AttachParrySensor(p.Character) end
    end

    local function W_SetupPlayer(p)
        if p == LP then return end
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

    RunService.Heartbeat:Connect(function()
        local char = LP.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if VD.Wisnu_ParryCircle and VD.Wisnu_AutoParry and hrp then
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
            local cR = VD.Wisnu_ParryDistance
            W_State.Adornment.Radius = cR
            W_State.Adornment.InnerRadius = math.max(0.1, cR - 0.15)
            W_State.Adornment.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(90), 0, 0)
            if W_State.Cooldown then
                W_State.Adornment.Color3 = Color3.fromRGB(128, 128, 128)
            else
                W_State.Adornment.Color3 = Color3.fromRGB(255, 255, 255)
            end
        elseif W_State.Adornment then
            W_State.Adornment:Destroy()
            W_State.Adornment = nil
        end
    end)

    W._WisnuParryState = W_State
  end--====================================================--
-- SELF HEAL
--====================================================--
function W.doSelfHealTrue()
    local c = LP.Character
    if not c then return end
    local hr = ReplicatedStorage.Remotes.Healing.HealEvent
    local hp = c:FindFirstChild("HumanoidRootPart")
    if not hp then return end
    pcall(function() hr:FireServer(hp, true) end)
end
function W.doSelfHealFalse()
    local c = LP.Character
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
        local char = LP.Character
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
    hookChar(LP.Character)
    W.SelfHeal_AnimMonitor.CharHook = LP.CharacterAdded:Connect(function(c)
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
            local c = LP.Character
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
                if p ~= LP and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local hu = p.Character:FindFirstChildOfClass("Humanoid")
                    if hu and hu.Health > 0 and hu.Health < hu.MaxHealth * 0.9 and hrp then
                        if ah[p] then
                            local c = LP.Character
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
LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if W.InstantHealSelf then W.setInstantHealSelf(true) end
    if W.AutoHealAll then W.setAutoHealAll(true) end
end)

--====================================================--
-- FAKE PERKS
--====================================================--
W.FP = W.FP or {
    ActiveBuffs = {}, Conns = {}, LastBuffEnd = 0, CooldownTime = 5, HB = nil,
    FlowstateOn = false, QuickRecOn = false, PerfLandOn = false, AdrenalineOn = false,
}
local FP = W.FP
local function FP_Char() return LP.Character end
local function FP_Hum() local c = FP_Char(); return c and c:FindFirstChildOfClass("Humanoid") end
local function FP_GetTotal()
    local t = 0
    for _, b in pairs(FP.ActiveBuffs) do if tick() < b.endTime then t = t + b.amt end end
    return t
end
local function FP_Apply()
    local c = FP_Char()
    local tb = FP_GetTotal()
    local h = FP_Hum()
    if c then
        if tb > 0 then c:SetAttribute("speedboost", 1 + (tb / 14))
        else c:SetAttribute("speedboost", 1) end
    end
    if h and tb > 0 then h.WalkSpeed = 16 + tb end
end
local PerkGUI = {
    Gui = nil, Container = nil, Layout = nil, Cards = {},
    PerkInfo = {
        Flowstate = { Icon = "✦", Label = "FLOWSTATE" },
        QuickRecovery = { Icon = "✚", Label = "QUICK RECOV" },
        PerfectLanding = { Icon = "▼", Label = "PERFECT LAND" },
        AdrenalineRush = { Icon = "♥", Label = "ADRENALINE" },
    }
}
local function PerkGUI_Create()
    if PerkGUI.Gui then return end
    local parent = LP:FindFirstChild("PlayerGui")
    if gethui then local ok2, hui = pcall(gethui); if ok2 and hui then parent = hui end end
    if not parent then return end
    local gui = Instance.new("ScreenGui")
    gui.Name = "GlutoPerkGUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 50
    gui.Parent = parent
    PerkGUI.Gui = gui
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.AnchorPoint = Vector2.new(1, 0)
    container.Position = UDim2.new(1, -12, 0, 100)
    container.Size = UDim2.new(0, 180, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.Parent = gui
    PerkGUI.Container = container
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    layout.Parent = container
    PerkGUI.Layout = layout
end
local function PerkGUI_AddCard(name)
    if PerkGUI.Cards[name] then return end
    if not PerkGUI.Gui then PerkGUI_Create() end
    if not PerkGUI.Gui then return end
    local info = PerkGUI.PerkInfo[name] or { Icon = "★", Label = string.upper(name) }
    local card = Instance.new("Frame")
    card.Name = "Card_" .. name
    card.Size = UDim2.new(0, 180, 0, 38)
    card.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    card.BackgroundTransparency = 1
    card.BorderSizePixel = 0
    card.ZIndex = 1
    card.LayoutOrder = #PerkGUI.Cards + 1
    card.Parent = PerkGUI.Container
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
    local grad = Instance.new("UIGradient")
    grad.Rotation = 135
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 28)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 10)),
    })
    grad.Parent = card
    local stroke = Instance.new("UIStroke", card)
    stroke.Name = "Stroke"
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1.2
    stroke.Transparency = 0.2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local iconHolder = Instance.new("Frame")
    iconHolder.Name = "IconHolder"
    iconHolder.Size = UDim2.fromOffset(26, 26)
    iconHolder.Position = UDim2.new(0, 6, 0.5, -13)
    iconHolder.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    iconHolder.BorderSizePixel = 0
    iconHolder.ZIndex = 3
    iconHolder.Parent = card
    Instance.new("UICorner", iconHolder).CornerRadius = UDim.new(1, 0)
    local iconTxt = Instance.new("TextLabel")
    iconTxt.Name = "Icon"
    iconTxt.Size = UDim2.fromScale(1, 1)
    iconTxt.BackgroundTransparency = 1
    iconTxt.Font = Enum.Font.GothamBlack
    iconTxt.Text = info.Icon
    iconTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconTxt.TextScaled = true
    iconTxt.ZIndex = 4
    iconTxt.Parent = iconHolder
    local nameLbl = Instance.new("TextLabel")
    nameLbl.Name = "Name"
    nameLbl.Size = UDim2.new(1, -46, 0, 12)
    nameLbl.Position = UDim2.new(0, 38, 0, 5)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.Text = info.Label
    nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLbl.TextSize = 10
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.ZIndex = 3
    nameLbl.Parent = card
    local timeLbl = Instance.new("TextLabel")
    timeLbl.Name = "Time"
    timeLbl.AnchorPoint = Vector2.new(1, 0)
    timeLbl.Size = UDim2.fromOffset(34, 12)
    timeLbl.Position = UDim2.new(1, -6, 0, 5)
    timeLbl.BackgroundTransparency = 1
    timeLbl.Font = Enum.Font.GothamBold
    timeLbl.Text = "3.0s"
    timeLbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    timeLbl.TextSize = 9
    timeLbl.TextXAlignment = Enum.TextXAlignment.Right
    timeLbl.ZIndex = 3
    timeLbl.Parent = card
    local barBg = Instance.new("Frame")
    barBg.Name = "BarBg"
    barBg.AnchorPoint = Vector2.new(0.5, 1)
    barBg.Size = UDim2.new(1, -12, 0, 3)
    barBg.Position = UDim2.new(0.5, 0, 1, -5)
    barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 46)
    barBg.BorderSizePixel = 0
    barBg.ZIndex = 4
    barBg.Parent = card
    Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)
    local barFill = Instance.new("Frame")
    barFill.Name = "BarFill"
    barFill.Size = UDim2.new(1, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    barFill.BorderSizePixel = 0
    barFill.ZIndex = 5
    barFill.Parent = barBg
    Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)
    PerkGUI.Cards[name] = {
        Card = card, BarFill = barFill, Stroke = stroke,
        TimeLbl = timeLbl, IconTxt = iconTxt,
    }
    card.Position = UDim2.new(0.4, 0, 0, 0)
    TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 0.05,
    }):Play()
end
local function PerkGUI_RemoveCard(name)
    local data = PerkGUI.Cards[name]
    if not data then return end
    PerkGUI.Cards[name] = nil
    local card = data.Card
    if not card or not card.Parent then return end
    TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0.4, 0, 0, 0),
        BackgroundTransparency = 1,
    }):Play()
    task.delay(0.28, function()
        if card and card.Parent then card:Destroy() end
    end)
end
task.spawn(function()
    while true do
        task.wait(0.05)
        for name in pairs(FP.ActiveBuffs) do
            if not PerkGUI.Cards[name] then PerkGUI_AddCard(name) end
        end
        for name, data in pairs(PerkGUI.Cards) do
            if not FP.ActiveBuffs[name] then
                PerkGUI_RemoveCard(name)
            else
                local b = FP.ActiveBuffs[name]
                if b and data.BarFill then
                    local remain = math.max(0, b.endTime - tick())
                    local dur = b.duration or 3
                    local ratio = math.clamp(remain / dur, 0, 1)
                    data.BarFill.Size = UDim2.new(ratio, 0, 1, 0)
                    data.BarFill.BackgroundColor3 = Color3.fromRGB(160, 160, 170):Lerp(Color3.fromRGB(255, 255, 255), ratio)
                    if data.TimeLbl then data.TimeLbl.Text = string.format("%.1fs", remain) end
                end
            end
        end
    end
end)
local function FP_EnsureHB()
    if FP.HB then return end
    FP.HB = RunService.Heartbeat:Connect(function()
        local exp = {}
        for n, b in pairs(FP.ActiveBuffs) do if tick() >= b.endTime then table.insert(exp, n) end end
        for _, n in ipairs(exp) do FP.ActiveBuffs[n] = nil end
        if #exp > 0 and FP_GetTotal() <= 0 then FP.LastBuffEnd = tick() end
        FP_Apply()
        if FP_GetTotal() <= 0 and next(FP.ActiveBuffs) == nil then
            if FP.HB then FP.HB:Disconnect(); FP.HB = nil end
            local c = FP_Char()
            if c then c:SetAttribute("speedboost", 1) end
        end
    end)
end
local function FP_TryBuff(name, amt, dur)
    if FP.ActiveBuffs[name] then return end
    if tick() - FP.LastBuffEnd < FP.CooldownTime and next(FP.ActiveBuffs) == nil then return end
    FP.ActiveBuffs[name] = { amt = amt, endTime = tick() + dur, duration = dur, startTime = tick() }
    FP_Apply(); FP_EnsureHB()
    VD_Notify("Fake Perks", "[" .. name .. "] Aktif! +" .. amt .. " Speed (" .. dur .. "s)", 3)
end
local function FP_Clean(name)
    if FP.Conns[name] then for _, c in ipairs(FP.Conns[name]) do pcall(function() c:Disconnect() end) end FP.Conns[name] = nil end
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
            task.delay(0.5, function() if FP.FlowstateOn then FP_TryBuff("Flowstate", 5, 3) end end)
        end
        if w then local vb = w:FindFirstChild("Vaultbindable"); if vb and vb:IsA("BindableEvent") then FP_Reg("Flowstate", vb.Event:Connect(onV)) end end
        if p then local sb = p:FindFirstChild("Slidebindable"); if sb and sb:IsA("BindableEvent") then FP_Reg("Flowstate", sb.Event:Connect(onV)) end end
        local function hookChar(cc)
            if not cc then return end
            local cn = cc:GetAttributeChangedSignal("__VaultFireCount"):Connect(function() if FP.FlowstateOn then onV() end end)
            FP_Reg("Flowstate", cn)
        end
        hookChar(LP.Character)
        FP_Reg("Flowstate", LP.CharacterAdded:Connect(function(cc) if FP.FlowstateOn then cc:SetAttribute("Flowstate", true); hookChar(cc) end end))
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
                    if nh > lh and (nh >= h.MaxHealth or (nh - lh) >= 15) then onH() end
                    lh = nh
                end)
                FP_Reg("QuickRecovery", cn)
            end
        end
        hookH(LP.Character)
        FP_Reg("QuickRecovery", LP.CharacterAdded:Connect(hookH))
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
            local cn = h.StateChanged:Connect(function(_, n)
                if not FP.PerfLandOn then return end
                if n == Enum.HumanoidStateType.Freefall then wf = true; fs = tick() end
                if wf and (n == Enum.HumanoidStateType.Landed or n == Enum.HumanoidStateType.Running) then
                    local ft = tick() - fs
                    wf = false
                    if ft >= 0.25 then FP_TryBuff("PerfectLanding", 8, 3) end
                end
            end)
            FP_Reg("PerfectLanding", cn)
        end
        hookF(LP.Character)
        FP_Reg("PerfectLanding", LP.CharacterAdded:Connect(hookF))
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
        hookD(LP.Character)
        FP_Reg("AdrenalineRush", LP.CharacterAdded:Connect(hookD))
    else
        FP_Clean("AdrenalineRush")
        FP.ActiveBuffs["AdrenalineRush"] = nil
    end
end

--====================================================--
-- STUN INDICATOR
--====================================================--
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
W.SInd_GetActiveSoundId = SInd_GetActiveSoundId
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
        snd.Name = "GlutoStunSound"
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
    bbg.Name = "GlutoStunIndicator"
    bbg.Size = UDim2.fromOffset(140, 42)
    bbg.StudsOffset = Vector3.new(0, 3.0, 0)
    bbg.AlwaysOnTop = true
    bbg.LightInfluence = 0
    bbg.MaxDistance = 500
    bbg.Adornee = head
    bbg.Parent = char
    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 140, 0, 34)
    main.Position = UDim2.new(0, 0, 0, 4)
    main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    main.BackgroundTransparency = 0.05
    main.BorderSizePixel = 0
    main.ZIndex = 1
    main.Parent = bbg
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 9)
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Name = "MainStroke"
    mainStroke.Color = Color3.fromRGB(255, 255, 255)
    mainStroke.Thickness = 1.3
    mainStroke.Transparency = 0.15
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -42, 0, 12)
    title.Position = UDim2.new(0, 34, 0, 4)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBlack
    title.Text = "STUNNED"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 11
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    title.TextStrokeTransparency = 0.5
    title.ZIndex = 3
    title.Parent = main
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, -42, 0, 8)
    sub.Position = UDim2.new(0, 34, 0, 18)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.GothamBold
    sub.Text = "SILENT"
    sub.TextColor3 = Color3.fromRGB(170, 170, 180)
    sub.TextSize = 7
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.ZIndex = 3
    sub.Parent = main
    local animActive = true
    local function StopAnim() animActive = false end
    task.spawn(function()
        local t = 0
        while animActive and bbg.Parent and main.Parent do
            t = t + 0.05
            local pulse = (math.sin(t * 3) + 1) * 0.5
            mainStroke.Transparency = 0.35 - pulse * 0.2
            mainStroke.Thickness = 1.2 + pulse * 0.3
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
            local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if not myRoot then return end
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and TeamIs(p, "Killer") and p.Character then
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
                            end                            end
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
end--====================================================--
-- FULL ESP SYSTEM
--====================================================--
W.FullESP = W.FullESP or {
    Survivor = false, Killer = false,
    Generator = false, Pallet = false, Window = false, SCP = false,
    Distance = 500,
}
W.FullESPStatus = W.FullESPStatus or {
    Enabled = false,
    ShowName = true, ShowDistance = true, ShowHealth = false,
    ShowAvatar = true, ShowAction = true, Radius = 500,
}
W.FullESPColors = W.FullESPColors or {
    Survivor = Color3.fromRGB(0, 190, 255), Killer = Color3.fromRGB(255, 0, 0),
    Generator = Color3.fromRGB(255, 255, 0), Window = Color3.fromRGB(255, 255, 255),
    Pallet = Color3.fromRGB(255, 165, 0), SCP = Color3.fromRGB(0, 255, 0),
}
local FESP = W.FullESP
local FESPS = W.FullESPStatus
local FESPC = W.FullESPColors

do
    local ESPObjects = {}
    local StatusESP = {}
    local CachedSCP = {}
    local CachedGen = {}
    local CachedPallet = {}
    local CachedWindow = {}
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

    local function RemoveStatusESP(char)
        if StatusESP[char] then
            pcall(function() StatusESP[char]:Destroy() end)
            StatusESP[char] = nil
        end
    end

    local function StatusESP_GetAction(char, hum)
        if not char or not hum then return "IDLE", Color3.fromRGB(150, 150, 150) end
        if hum.Health <= 0 then return "DEAD", Color3.fromRGB(200, 60, 60) end
        if char:GetAttribute("IsHooked") or char:GetAttribute("isHooked") or char:GetAttribute("Hooked") then
            return "HOOKED", Color3.fromRGB(255, 60, 60)
        end
        if char:GetAttribute("IsCarried") or char:GetAttribute("isCarried") or char:GetAttribute("Carried") then
            return "CARRIED", Color3.fromRGB(255, 100, 100)
        end
        local state = char:GetAttribute("State")
        if state == "Downed" or char:GetAttribute("Knocked") == true
           or char:GetAttribute("IsDown") == true or char:GetAttribute("Downed") == true then
            return "DOWNED", Color3.fromRGB(255, 130, 60)
        end
        local ci = char:FindFirstChild("CheckInterractable")
        if ci then
            if ci:GetAttribute("isRepairing") then return "REPAIR", Color3.fromRGB(255, 220, 60) end
            if ci:GetAttribute("isHealing") then return "HEAL", Color3.fromRGB(80, 220, 120) end
            if ci:GetAttribute("isVaulting") then return "VAULT", Color3.fromRGB(120, 200, 255) end
            if ci:GetAttribute("isSliding") then return "SLIDE", Color3.fromRGB(150, 180, 255) end
            if ci:GetAttribute("isDroppingPallet") then return "PALLET", Color3.fromRGB(255, 165, 60) end
            if ci:GetAttribute("isUnhooking") then return "UNHOOK", Color3.fromRGB(180, 120, 255) end
            if ci:GetAttribute("isExiting") then return "EXIT", Color3.fromRGB(80, 255, 180) end
        end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            local vel = root.AssemblyLinearVelocity
            local speed = Vector3.new(vel.X, 0, vel.Z).Magnitude
            if speed > 20 then return "SPRINT", Color3.fromRGB(120, 255, 200) end
            if speed > 2 then return "MOVE", Color3.fromRGB(200, 200, 220) end
        end
        return "IDLE", Color3.fromRGB(150, 150, 150)
    end

    local function CreateStatusESP(plr, char, root)
        if not FESPS.Enabled then RemoveStatusESP(char); return end
        if not root then return end
        local head = char:FindFirstChild("Head")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not head or not hum then return end

        local isDown = hum.Health <= 0 or hum.Health < 2
            or char:GetAttribute("Downed") == true
            or char:GetAttribute("IsDown") == true
            or char:GetAttribute("Knocked") == true

        local dist = (head.Position - root.Position).Magnitude
        if dist > FESPS.Radius then RemoveStatusESP(char); return end

        local accentColor = Color3.fromRGB(255, 255, 255)
        if TeamIs(plr, "Killer") then accentColor = FESPC.Killer
        elseif TeamIs(plr, "Survivor") then accentColor = FESPC.Survivor end
        if isDown then accentColor = Color3.fromRGB(255, 60, 60) end

        local hpPct = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
        local hpColor
        if hpPct > 0.6 then hpColor = Color3.fromRGB(80, 220, 120)
        elseif hpPct > 0.3 then hpColor = Color3.fromRGB(255, 200, 60)
        else hpColor = Color3.fromRGB(255, 80, 80) end

        local actionText, actionColor = StatusESP_GetAction(char, hum)

        local bb = StatusESP[char]
        if not bb or not bb.Parent then
            bb = Instance.new("BillboardGui")
            bb.Name = "GlutoStatusESP"
            bb.AlwaysOnTop = true
            bb.LightInfluence = 0
            bb.Adornee = head
            bb.StudsOffset = Vector3.new(0, 2.5, 0)
            bb.Size = UDim2.fromOffset(260, 40)
            bb.Parent = char

            local scaleObj = Instance.new("UIScale")
            scaleObj.Name = "DistScale"
            scaleObj.Scale = 1
            scaleObj.Parent = bb

            local nameLbl = Instance.new("TextLabel")
            nameLbl.Name = "NameLbl"
            nameLbl.BackgroundTransparency = 1
            nameLbl.Size = UDim2.new(1, 0, 0, 16)
            nameLbl.Position = UDim2.new(0, 0, 0, 0)
            nameLbl.Font = Enum.Font.GothamBold
            nameLbl.TextSize = 13
            nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLbl.TextStrokeTransparency = 0.2
            nameLbl.TextXAlignment = Enum.TextXAlignment.Center
            nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
            nameLbl.Parent = bb

            local pill = Instance.new("Frame")
            pill.Name = "Pill"
            pill.AnchorPoint = Vector2.new(0.5, 0)
            pill.Position = UDim2.new(0.5, 0, 0, 18)
            pill.Size = UDim2.fromOffset(120, 22)
            pill.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
            pill.BackgroundTransparency = 0.15
            pill.BorderSizePixel = 0
            pill.Parent = bb
            Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

            local pillStroke = Instance.new("UIStroke", pill)
            pillStroke.Name = "PillStroke"
            pillStroke.Color = accentColor
            pillStroke.Thickness = 1
            pillStroke.Transparency = 0.5
            pillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local layout = Instance.new("UIListLayout", pill)
            layout.FillDirection = Enum.FillDirection.Horizontal
            layout.Padding = UDim.new(0, 5)
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.VerticalAlignment = Enum.VerticalAlignment.Center
            layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

            local pad = Instance.new("UIPadding", pill)
            pad.PaddingLeft = UDim.new(0, 6)
            pad.PaddingRight = UDim.new(0, 8)

            local avatarHolder = Instance.new("Frame")
            avatarHolder.Name = "AvatarHolder"
            avatarHolder.Size = UDim2.fromOffset(18, 18)
            avatarHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
            avatarHolder.BorderSizePixel = 0
            avatarHolder.LayoutOrder = 1
            avatarHolder.ClipsDescendants = true
            avatarHolder.Parent = pill
            Instance.new("UICorner", avatarHolder).CornerRadius = UDim.new(1, 0)

            local avatarStroke = Instance.new("UIStroke", avatarHolder)
            avatarStroke.Name = "AvatarStroke"
            avatarStroke.Color = accentColor
            avatarStroke.Thickness = 1.2
            avatarStroke.Transparency = 0.3
            avatarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local avatarImg = Instance.new("ImageLabel")
            avatarImg.Name = "AvatarImg"
            avatarImg.Size = UDim2.fromScale(1, 1)
            avatarImg.BackgroundTransparency = 1
            avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=150&h=150"
            avatarImg.Parent = avatarHolder

            local dot = Instance.new("Frame")
            dot.Name = "Dot"
            dot.Size = UDim2.fromOffset(7, 7)
            dot.BackgroundColor3 = accentColor
            dot.BorderSizePixel = 0
            dot.LayoutOrder = 1
            dot.Visible = false
            dot.Parent = pill
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

            local distLbl = Instance.new("TextLabel")
            distLbl.Name = "DistLbl"
            distLbl.BackgroundTransparency = 1
            distLbl.Size = UDim2.fromOffset(32, 14)
            distLbl.Font = Enum.Font.GothamBold
            distLbl.TextSize = 11
            distLbl.TextColor3 = Color3.fromRGB(220, 220, 230)
            distLbl.Text = "0m"
            distLbl.LayoutOrder = 2
            distLbl.Parent = pill

            local actionLbl = Instance.new("TextLabel")
            actionLbl.Name = "ActionLbl"
            actionLbl.BackgroundTransparency = 1
            actionLbl.Size = UDim2.fromOffset(50, 14)
            actionLbl.Font = Enum.Font.GothamBold
            actionLbl.TextSize = 10
            actionLbl.TextColor3 = actionColor
            actionLbl.Text = "IDLE"
            actionLbl.LayoutOrder = 3
            actionLbl.Parent = pill

            local hpBarBg = Instance.new("Frame")
            hpBarBg.Name = "HPBarBg"
            hpBarBg.Size = UDim2.fromOffset(38, 4)
            hpBarBg.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            hpBarBg.BorderSizePixel = 0
            hpBarBg.LayoutOrder = 4
            hpBarBg.Parent = pill
            Instance.new("UICorner", hpBarBg).CornerRadius = UDim.new(1, 0)

            local hpBarFill = Instance.new("Frame")
            hpBarFill.Name = "HPBarFill"
            hpBarFill.Size = UDim2.new(1, 0, 1, 0)
            hpBarFill.BackgroundColor3 = hpColor
            hpBarFill.BorderSizePixel = 0
            hpBarFill.Parent = hpBarBg
            Instance.new("UICorner", hpBarFill).CornerRadius = UDim.new(1, 0)

            local downPill = Instance.new("Frame")
            downPill.Name = "DownPill"
            downPill.Size = UDim2.fromOffset(36, 14)
            downPill.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            downPill.BackgroundTransparency = 0.1
            downPill.BorderSizePixel = 0
            downPill.Visible = false
            downPill.LayoutOrder = 5
            downPill.Parent = pill
            Instance.new("UICorner", downPill).CornerRadius = UDim.new(1, 0)

            local downLbl = Instance.new("TextLabel")
            downLbl.Name = "DownLbl"
            downLbl.Size = UDim2.new(1, 0, 1, 0)
            downLbl.BackgroundTransparency = 1
            downLbl.Font = Enum.Font.GothamBold
            downLbl.TextSize = 9
            downLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            downLbl.Text = "DOWN"
            downLbl.Parent = downPill

            StatusESP[char] = bb
        end

        local nameLbl = bb:FindFirstChild("NameLbl")
        local pill = bb:FindFirstChild("Pill")
        if not pill then return end
        local pillStroke = pill:FindFirstChild("PillStroke")
        local avatarHolder = pill:FindFirstChild("AvatarHolder")
        local avatarImg = avatarHolder and avatarHolder:FindFirstChild("AvatarImg")
        local avatarStroke = avatarHolder and avatarHolder:FindFirstChild("AvatarStroke")
        local dot = pill:FindFirstChild("Dot")
        local distLbl = pill:FindFirstChild("DistLbl")
        local actionLbl = pill:FindFirstChild("ActionLbl")
        local hpBarBg = pill:FindFirstChild("HPBarBg")
        local hpBarFill = hpBarBg and hpBarBg:FindFirstChild("HPBarFill")
        local downPill = pill:FindFirstChild("DownPill")
        local distScale = bb:FindFirstChild("DistScale")

        if pillStroke then
            pillStroke.Color = accentColor
            pillStroke.Transparency = isDown and 0.2 or 0.5
        end
        if avatarHolder then
            avatarHolder.Visible = FESPS.ShowAvatar == true
            if avatarStroke then avatarStroke.Color = accentColor end
            if avatarImg and avatarImg.Image == "" then
                avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=150&h=150"
            end
        end
        if dot then
            dot.Visible = (FESPS.ShowAvatar ~= true)
            dot.BackgroundColor3 = accentColor
        end
        if nameLbl then
            nameLbl.Text = plr.Name
            nameLbl.Visible = FESPS.ShowName
            nameLbl.TextColor3 = isDown and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(255, 255, 255)
        end
        if distLbl then
            distLbl.Text = string.format("%.0fm", dist)
            distLbl.Visible = FESPS.ShowDistance
        end
        if actionLbl then
            actionLbl.Text = actionText
            actionLbl.TextColor3 = actionColor
            actionLbl.Visible = FESPS.ShowAction == true
            if actionText == "IDLE" then
                actionLbl.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
        if hpBarBg and hpBarFill then
            hpBarFill.Size = UDim2.new(hpPct, 0, 1, 0)
            hpBarFill.BackgroundColor3 = hpColor
            hpBarBg.Visible = FESPS.ShowHealth
        end
        if downPill then downPill.Visible = isDown end

        local totalW = 14
        local count = 0
        if FESPS.ShowAvatar then totalW = totalW + 18; count = count + 1
        else totalW = totalW + 7; count = count + 1 end
        if FESPS.ShowDistance then totalW = totalW + 32; count = count + 1 end
        if FESPS.ShowAction then totalW = totalW + 50; count = count + 1 end
        if FESPS.ShowHealth then totalW = totalW + 38; count = count + 1 end
        if isDown then totalW = totalW + 36; count = count + 1 end
        totalW = totalW + math.max(count - 1, 0) * 5
        if totalW < 50 then totalW = 50 end
        if totalW > 240 then totalW = 240 end
        pill.Size = UDim2.fromOffset(totalW, 22)

        local showPill = FESPS.ShowDistance or FESPS.ShowHealth or isDown
            or FESPS.ShowAction or FESPS.ShowAvatar
        pill.Visible = showPill

        local h = 16 + (showPill and 24 or 0)
        bb.Size = UDim2.fromOffset(260, h)

        if distScale then
            local scaleVal = 1 - (dist - 50) / 500
            scaleVal = math.clamp(scaleVal, 0.5, 1.05)
            distScale.Scale = scaleVal
        end
    end

    local function GetGameValue(obj, name)
        if not obj then return nil end
        local attr = obj:GetAttribute(name)
        if attr ~= nil then return attr end
        local child = obj:FindFirstChild(name)
        if child then
            local ok, v = pcall(function() return child.Value end)
            if ok then return v end
        end
        return nil
    end

    local function UpdateGenerator(gen)
        if not gen or not gen.Parent then return end
        if not FESP.Generator then
            local o = gen:FindFirstChild("GenESP"); if o then o:Destroy() end
            local h = gen:FindFirstChild("GenHighlight"); if h then h:Destroy() end
            return
        end
        local percent = GetGameValue(gen, "RepairProgress")
            or GetGameValue(gen, "Progress")
            or GetGameValue(gen, "ProgressRepair") or 0
        local bb = gen:FindFirstChild("GenESP")
        if percent >= 100 then if bb then bb:Destroy() end; return end
        local cp = math.clamp(percent, 0, 100)
        local color = FESPC.Generator:Lerp(Color3.fromRGB(0, 255, 120), cp / 100)
        local text = string.format("[%.0f%%]", percent)
        if not bb then
            bb = Instance.new("BillboardGui")
            bb.Name = "GenESP"
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
        local h = gen:FindFirstChild("GenHighlight") or Instance.new("Highlight")
        h.Name = "GenHighlight"
        h.Adornee = gen
        h.FillColor = color
        h.OutlineColor = color
        h.FillTransparency = 0.9
        h.OutlineTransparency = 0.3
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = gen
    end

    local function UpdateMapESP(obj, root)
        if not obj or not root or not obj.Parent then return end
        local pos
        if obj:IsA("Model") then
            if obj.PrimaryPart then pos = obj.PrimaryPart.Position
            else
                local ok, pivot = pcall(function() return obj:GetPivot().Position end)
                pos = ok and pivot or nil
                if not pos then
                    local bp = obj:FindFirstChildWhichIsA("BasePart", true)
                    if bp then pos = bp.Position end
                end
            end
        elseif obj:IsA("BasePart") then
            pos = obj.Position
        end
        if not pos then return end
        local dist = (pos - root.Position).Magnitude

        if obj.Name == "Pallet" or obj.Name == "Palletwrong" then
            if FESP.Pallet and dist <= FESP.Distance then
                CreateESP(obj, FESPC.Pallet)
            else
                RemoveESP(obj)
            end
        end
    end

    local function UpdateSCPEsp(root)
        if not FESP.SCP then
            for obj in pairs(CachedSCP) do RemoveESP(obj) end
            return
        end
        for obj in pairs(CachedSCP) do
            if obj and obj.Parent then
                local pos
                if obj:IsA("Model") then
                    local ok, pivot = pcall(function() return obj:GetPivot().Position end)
                    pos = ok and pivot or nil
                elseif obj:IsA("BasePart") then
                    pos = obj.Position
                end
                if pos then
                    local dist = (pos - root.Position).Magnitude
                    if dist <= FESP.Distance then
                        CreateESP(obj, FESPC.SCP)
                    else
                        RemoveESP(obj)
                    end
                end
            end
        end
    end

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
        if CachedWindow[model] then CachedWindow[model] = nil end
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
        box.Name = "GlutoWindowBox"
        box.Adornee = bottomPart
        box.Size = bottomPart.Size
        box.Color3 = FESPC.Window
        box.Transparency = 0.3
        box.AlwaysOnTop = true
        box.ZIndex = 5
        box.Parent = bottomPart

        local hl = Instance.new("Highlight")
        hl.Name = "GlutoWindowHighlight"
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

    local espLastUpdate = 0
    RunService.RenderStepped:Connect(function()
        local now = tick()
        if now - espLastUpdate < 0.05 then return end
        espLastUpdate = now

        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
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
        for obj in pairs(CachedPallet) do UpdateMapESP(obj, root) end
        UpdateSCPEsp(root)

        if FESP.Window then
            if not _G.GlutoWindowScanned then
                _G.GlutoWindowScanned = true
                pcall(ScanAllWindows)
            end
        else
            _G.GlutoWindowScanned = false
            for model in pairs(WindowObjects) do
                RemoveWindowESP(model)
            end
        end
    end)
end

--====================================================--
-- INVISIBLE (MengHub API)
--====================================================--
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
            local char = LP.Character
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
        if getgenv().Gluto_InvisBtn_UpdateVisual then
            pcall(getgenv().Gluto_InvisBtn_UpdateVisual)
        end
    end
    local function Invis_LoadAPI()
        if _G.MengHub and _G.MengHub.Invisible and Invis_ValidateAPI(_G.MengHub.Invisible) then
            MV.API = _G.MengHub.Invisible
            MV.Ready = true
            print("[GlutoInvis] MengHub API sudah tersedia di _G")
            return true
        end
        MV.Loading = true; MV.Ready = false
        for attempt = 1, MV._retryMax do
            MV._retries = attempt
            print(("[GlutoInvis] Loading API... (%d/%d)"):format(attempt, MV._retryMax))
            local ok, err = pcall(function()
                loadstring(game:HttpGet(INVIS_URL))()
            end)
            task.wait(0.5)
            if ok and _G.MengHub and _G.MengHub.Invisible and Invis_ValidateAPI(_G.MengHub.Invisible) then
                MV.API = _G.MengHub.Invisible
                MV.Ready = true; MV.Loading = false
                print(("[GlutoInvis] API loaded OK (attempt %d)"):format(attempt))
                Invis_RefreshButton()
                if MV._queueState ~= nil then
                    local queued = MV._queueState
                    MV._queueState = nil
                    task.defer(function() W.Invisible_SetState(queued, false) end)
                end
                return true
            else
                warn(("[GlutoInvis] Attempt %d gagal: %s"):format(attempt, tostring(err)))
                if attempt < MV._retryMax then task.wait(MV._retryDelay) end
            end
        end
        MV.Loading = false; MV.Ready = false
        print("[GlutoInvis] Semua retry gagal")
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
                VD_Notify("Invisible", "Loading API...", 2)
                MV._queueState = state
            else
                VD_Notify("Invisible", "API gagal, retry...", 2)
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
        VD.Invis_Enabled = state
        if state then
            local ok, err = pcall(function() MV.API.enable() end)
            if not ok then
                warn("[GlutoInvis] enable error:", err)
                MV.Enabled = false
                VD.Invis_Enabled = false
                Invis_Cleanup()
                if not fromButton then VD_Notify("Invisible", "Gagal enable", 2) end
            else
                if not fromButton then VD_Notify("Invisible", "Invisible AKTIF", 2) end
            end
        else
            pcall(function() MV.API.disable() end)
            Invis_Cleanup()
            if not fromButton then VD_Notify("Invisible", "Invisible Nonaktif", 2) end
        end
        Invis_RefreshButton()
    end
    function W.Invisible_SetEnabled(v)  W.Invisible_SetState(v and true or false, false) end
    function W.Invisible_Start()        W.Invisible_SetState(true, false)  end
    function W.Invisible_Stop()         W.Invisible_SetState(false, false) end
    function W.Invisible_Toggle()       W.Invisible_SetState(not MV.Enabled, false) end
    function W.Invisible_SetHotkey(kc)
        if kc and typeof(kc) == "EnumItem" then
            VD.Invis_Hotkey = kc.Name
        elseif type(kc) == "string" then
            VD.Invis_Hotkey = kc
        end
    end
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        local hkName = VD.Invis_Hotkey or "G"
        local hk = Enum.KeyCode[hkName]
        if hk and input.KeyCode == hk then
            W.Invisible_SetState(not MV.Enabled, false)
        end
    end)
    LP.CharacterAdded:Connect(function()
        task.wait(1.2)
        if MV.Enabled and MV.API then
            pcall(function() MV.API.enable() end)
            Invis_RefreshButton()
        end
    end)
    pcall(function()
        game:BindToClose(function()
            if MV.Enabled and MV.API then
                pcall(function() MV.API.disable() end)
            end
            Invis_Cleanup()
        end)
    end)
    Players.PlayerRemoving:Connect(function(plr)
        if plr == LP then
            if MV.Enabled and MV.API then
                pcall(function() MV.API.disable() end)
            end
            Invis_Cleanup()
        end
    end)
    W.Invisible_IsReady   = function() return MV.Ready and MV.API ~= nil end
    W.Invisible_IsLoading = function() return MV.Loading end
    W.Invisible_IsOn      = function() return MV.Enabled end
    W.Invisible_ReloadAPI = function() return Invis_LoadAPI() end
    W.Invisible_GetStatus = function()
        if MV.Loading then return "LOADING" end
        if not MV.Ready then return "FAILED" end
        if MV.Enabled then return "ON" end
        return "READY"
    end
end--====================================================--
-- HIDDEN LEAP BYPASS
--====================================================--
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
function W.BYPASS_StopHiddenCooldownBypass() end
function W.BYPASS_SetHiddenLeap(v)
    VD.KILLER_BypassLeap = v and true or false
    if VD.KILLER_BypassLeap then W.BYPASS_StartHiddenCooldownBypass()
    else W.BYPASS_StopHiddenCooldownBypass() end
end

--====================================================--
-- INF GRAB (MYERS)
--====================================================--
W.MyersGrabData = W.MyersGrabData or { Enabled = false, HotkeyCode = Enum.KeyCode.H }
local MyersGrabData = W.MyersGrabData
function W.getMyersTarget()
    local char = LP.Character
    if not char then return nil end
    local myHRP = char:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end
    local candidates = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Character then
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
    VD.KILLER_InfGrab = MyersGrabData.Enabled
    if getgenv().Gluto_MGrabBtn_UpdateVisual then pcall(getgenv().Gluto_MGrabBtn_UpdateVisual) end
end
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == MyersGrabData.HotkeyCode and MyersGrabData.Enabled then
        W.doMyersGrab()
    end
end)

--====================================================--
-- SLASHER BYPASS (LakeMist + Pursuit)
--====================================================--
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
function W.MAWWW_StopSlasherCooldownBypass()
    pcall(function()
        local jason = ReplicatedStorage:FindFirstChild("Remotes")
            and ReplicatedStorage.Remotes:FindFirstChild("Killers")
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Jason")
        if jason then
            if not VD.KILLER_InfLakeMist then
                local lm = jason:FindFirstChild("LakeMist")
                if lm then lm:FireServer(false) end
            end
            if not VD.KILLER_InfPursuit then
                local ps = jason:FindFirstChild("Pursuit")
                if ps then ps:FireServer(false) end
            end
        end
    end)
end
function W.MAWWW_SetLakeMist(v)
    VD.KILLER_InfLakeMist = v and true or false
    if VD.KILLER_InfLakeMist or VD.KILLER_InfPursuit then W.MAWWW_StartSlasherCooldownBypass()
    else W.MAWWW_StopSlasherCooldownBypass() end
end
function W.MAWWW_SetPursuit(v)
    VD.KILLER_InfPursuit = v and true or false
    if VD.KILLER_InfLakeMist or VD.KILLER_InfPursuit then W.MAWWW_StartSlasherCooldownBypass()
    else W.MAWWW_StopSlasherCooldownBypass() end
end

--====================================================--
-- ABYSS BYPASS
--====================================================--
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

--====================================================--
-- JEFF INF FRENZY
--====================================================--
getgenv().MAWWW_JeffCooldownBypassThread = nil
function W.MAWWW_StartJeffCooldownBypass()
    if getgenv().MAWWW_JeffCooldownBypassThread then return end
    getgenv().MAWWW_JeffCooldownBypassThread = task.spawn(function()
        while task.wait() do
            if not VD.KILLER_InfFrenzy then break end
            pcall(function()
                local char = LP.Character
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
        local char = LP.Character
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

--====================================================--
-- ANTI BLIND FLASHLIGHT
--====================================================--
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
                    if not checkcaller() and getgenv().VD and getgenv().VD.KILLER_AntiBlind and self == gb then
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

--====================================================--
-- DESTROY PALLET
--====================================================--
getgenv().MAWWW_IsBreakingPallet = false
function W.MAWWW_DestroyAllPallets()
    if not VD.KILLER_DestroyPallets then return end
    if W.GetRole() ~= "Killer" then return end
    if getgenv().MAWWW_IsBreakingPallet then return end

    local char = LP.Character
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

--====================================================--
-- INFINITE LUNGE
--====================================================--
local VD_OriginalLungeBoost = nil
function VD_UpdateInfiniteLunge()
    local char = LP.Character
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
W.VD_UpdateInfiniteLunge = VD_UpdateInfiniteLunge

LP.CharacterRemoving:Connect(function()
    VD_OriginalLungeBoost = nil
end)--====================================================--
-- AIMLOCK ATTACK (KILLER → SURVIVOR)
--====================================================--
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
        RayParams.FilterDescendantsInstances = { LP.Character }
        local origin = cam.CFrame.Position
        local dir = part.Position - origin
        local result = Workspace:Raycast(origin, dir, RayParams)
        if not result then return true end
        return result.Instance:IsDescendantOf(part.Parent)
    end
    local function AL_GetAttackButton()
        for _, path in ipairs(AttackPaths) do
            local current = LP:FindFirstChild("PlayerGui")
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
            if p ~= LP and p.Team and string.find(string.lower(p.Team.Name), "survivor", 1, true) and p.Character then
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

--====================================================--
-- AIMLOCK GUN (SURVIVOR SIDE)
--====================================================--
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
        rp.FilterDescendantsInstances = { LP.Character }
        local origin = cam.CFrame.Position
        local dir = part.Position - origin
        local result = Workspace:Raycast(origin, dir, rp)
        if not result then return true end
        return result.Instance:IsDescendantOf(part.Parent)
    end
    local function GA_GetButton()
        local current = LP:FindFirstChild("PlayerGui")
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
            if p ~= LP and p.Character and p.Team then
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

--====================================================--
-- AIM LOCK HIDDEN (ANY → ENEMY)
--====================================================--
do
    local AimLockEnabled = false
    local AimLockThread = nil
    local AimLockAiming = false
    local AimLockHoldKey = Enum.KeyCode.E
    local AimLockMobileHooks = {}
    local function AimLock_GetClosestTarget()
        local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil end
        local myTeam = LP.Team and LP.Team.Name or ""
        local myIsKiller = string.find(string.lower(myTeam), "killer", 1, true) ~= nil
        local closestTarget, shortestDist = nil, math.huge
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LP and player.Character then
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
            local pGui = LP:FindFirstChildOfClass("PlayerGui")
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
    LP.CharacterAdded:Connect(function()
        AimLockAiming = false
        if UserInputService.TouchEnabled then task.wait(2); AimLock_SetupMobile() end
    end)
    function W.AimLock_SetEnabled(state)
        AimLockEnabled = state
        if state then
            AimLock_Start()
            VD_Notify("Aim Lock Hidden", "Enabled — Hold M2/E", 2)
        else
            AimLockAiming = false
            if AimLockThread then task.cancel(AimLockThread); AimLockThread = nil end
            VD_Notify("Aim Lock Hidden", "Disabled", 2)
        end
    end
    function W.AimLock_SetKey(kc)
        if kc and typeof(kc) == "EnumItem" then
            AimLockHoldKey = kc
        elseif type(kc) == "string" then
            local ok, k = pcall(function() return Enum.KeyCode[kc:upper()] end)
            if ok and k then AimLockHoldKey = k end
        end
    end
end

--====================================================--
-- AIMBOT ZOMBIE
--====================================================--
do
    local Z = {
        Enabled = false, Holding = false, Strength = 1,
        Predict = true, PredictStrength = 0.12, FOV = 250,
        VisibilityCheck = true, AimPart = "HumanoidRootPart", Target = nil,
    }
    local ZConn = nil
    local function Z_IsVisible(part)
        local cam = Workspace.CurrentCamera
        if not cam then return true end
        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = { LP.Character }
        local origin = cam.CFrame.Position
        local dir = part.Position - origin
        local res = Workspace:Raycast(origin, dir, rp)
        if not res then return true end
        return res.Instance:IsDescendantOf(part.Parent)
    end
    local function Z_GetZombies()
        local l = {}
        local map = Workspace:FindFirstChild("Map")
        if not map then return l end
        for _, c in ipairs(map:GetDescendants()) do
            if c:IsA("Model") then
                local a = c:GetAttributes()
                local isZ = c:GetAttribute("CorpseCreated0492") ~= nil or c:GetAttribute("IsZombie") == true or next(a) ~= nil
                local hrp = c:FindFirstChild("HumanoidRootPart")
                local hum = c:FindFirstChildOfClass("Humanoid")
                if isZ and hrp and hum and hum.Health > 0 then table.insert(l, hrp) end
            end
        end
        return l
    end
    local function Z_GetClosest()
        local cam = Workspace.CurrentCamera
        if not cam then return nil end
        local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
        local best, bd = nil, Z.FOV
        for _, hrp in ipairs(Z_GetZombies()) do
            if hrp and hrp.Parent then
                local pos, on = cam:WorldToViewportPoint(hrp.Position)
                if on then
                    local d = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if d < bd then
                        if Z.VisibilityCheck and not Z_IsVisible(hrp) then continue end
                        bd = d; best = hrp
                    end
                end
            end
        end
        return best
    end
    local function Z_Start()
        if ZConn then return end
        ZConn = RunService.RenderStepped:Connect(function()
            if not Z.Enabled or not Z.Holding then return end
            local t = Z_GetClosest()
            if not t then return end
            Z.Target = t
            local pos = t.Position
            if Z.Predict then
                pos = pos + (t.AssemblyLinearVelocity * Z.PredictStrength)
            end
            local cam = Workspace.CurrentCamera
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, pos), Z.Strength)
        end)
    end
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType == Enum.UserInputType.MouseButton2 and Z.Enabled then
            Z.Holding = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            Z.Holding = false
        end
    end)
    function W.ZombieAim_SetEnabled(v)
        Z.Enabled = v and true or false
        if v and Z_Start then Z_Start() end
    end
    W.ZombieAim_Cfg = Z
        end--====================================================--
-- COUNTER AUTO PARRY
--====================================================--
local CounterParryEnabled = false
local CounterParryAnimList = {}
for id, _ in pairs(KillerAttackAnims) do
    table.insert(CounterParryAnimList, id)
end
task.spawn(function()
    while true do
        task.wait(0.5)
        if not CounterParryEnabled then continue end
        local char = LP.Character
        if not char then continue end
        local myRoot = char:FindFirstChild("HumanoidRootPart")
        if not myRoot then continue end
        local near = false
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Team and string.find(string.lower(p.Team.Name), "survivor", 1, true) then
                local r = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                if r and (myRoot.Position - r.Position).Magnitude <= 15 then
                    near = true
                    break
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
function W.CounterParry_Set(v) CounterParryEnabled = v and true or false end

--====================================================--
-- KILLER ABILITIES SYSTEM
--====================================================--
W.KillerAbilities = W.KillerAbilities or {
    AutoStalk = VD.KA_AutoStalk, AutoStalkRange = VD.KA_AutoStalkRange,
    AutoKillAll = VD.KA_AutoKillAll, DropAllPallet = VD.KA_DropAllPallet,
    BlockAllVault = VD.KA_BlockAllVault,
}
local KA = W.KillerAbilities

function W.KA_GetClosestSurvivor(range, minHealth)
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local closest, shortest = nil, (range or math.huge)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character and TeamIs(plr, "Survivor") then
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
    VD.KA_AutoStalk = KA.AutoStalk
    if KA.AutoStalk then W.KA_StartAutoStalk() else W.KA_StopAutoStalk() end
end

local KillAllTarget = nil
function W.KA_UpdateKillAll()
    if not KA.AutoKillAll then KillAllTarget = nil; return end
    if GetRole() ~= "Killer" then KillAllTarget = nil; return end
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
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
function W.KA_DropAllPallets_Force()
    lastDropAllPallet = 0
    local saved = KA.DropAllPallet
    KA.DropAllPallet = true
    pcall(W.KA_DropAllPallets)
    task.delay(0.1, function() KA.DropAllPallet = saved end)
end

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
function W.KA_BlockAllVaults_Force()
    pcall(W.KA_BlockAllVaults)
end

task.spawn(function()
    while true do
        task.wait(0.12)
        if KA.AutoKillAll then pcall(W.KA_UpdateKillAll) end
        if KA.DropAllPallet then pcall(W.KA_DropAllPallets) end
        if KA.BlockAllVault then pcall(W.KA_BlockAllVaults) end
        if VD.KILLER_DestroyPallets then pcall(W.MAWWW_DestroyAllPallets) end
        pcall(VD_UpdateInfiniteLunge)
    end
end)
LP.CharacterAdded:Connect(function()
    task.wait(1)
    if KA.AutoStalk then pcall(W.KA_StartAutoStalk) end
end)

--====================================================--
-- AUTO HOOK (KILLER)
--====================================================--
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
        local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil, nil end
        local closest, closestDist, closestChar = nil, math.huge, nil
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl == LP or not pl.Character then continue end
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
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
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
            local r2 = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
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

--====================================================--
-- KILLER PERKS DISPLAY
--====================================================--
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
        local pg = LP:FindFirstChild("PlayerGui")
        if gethui then
            local ok, hui = pcall(gethui)
            if ok and hui then pg = hui end
        end
        if not pg then return end
        local gui = Instance.new("ScreenGui")
        gui.Name = "GlutoKillerPerksDisplay"
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
        title.Name = "Title"
        title.Size = UDim2.new(1, -26, 1, 0)
        title.Position = UDim2.new(0, 10, 0, 0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.Text = "KILLER PERKS"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 11
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = header
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
        VD.KillerPerksDisplay = v and true or false
        if VD.KillerPerksDisplay then Start() else Stop() end
    end
end--====================================================--
-- SILENT FLASK (THE CURE)
--====================================================--
do
    VD.FLASK_SilentAim    = VD.FLASK_SilentAim    or false
    VD.FLASK_ShowBeam     = VD.FLASK_ShowBeam     ~= false
    VD.FLASK_ShowLanding  = VD.FLASK_ShowLanding  ~= false
    VD.FLASK_Predict      = VD.FLASK_Predict      ~= false
    VD.FLASK_Speed        = VD.FLASK_Speed        or 90
    VD.FLASK_Gravity      = VD.FLASK_Gravity      or 196
    VD.FLASK_LeadMult     = VD.FLASK_LeadMult     or 1.0
    VD.FLASK_Range        = VD.FLASK_Range        or 200
    VD.FLASK_BeamColor    = VD.FLASK_BeamColor    or Color3.fromRGB(255, 255, 255)
    VD.FLASK_AccentColor  = VD.FLASK_AccentColor  or Color3.fromRGB(25, 25, 25)
    local FlaskState = { Target = nil, PredictedPos = nil, BeamPart = nil, AccentPart = nil, LandingRing = nil }
    local function Flask_GetTarget()
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local maxR = tonumber(VD.FLASK_Range) or 200
        local best, bd = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and TeamIs(p, "Survivor") and p.Character then
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
        local c = LP.Character
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
            beam.Name = "GlutoFlaskBeam"
            beam.Anchored = true; beam.CanCollide = false
            beam.CanTouch = false; beam.CanQuery = false; beam.CastShadow = false
            beam.Material = Enum.Material.Neon
            beam.Color = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255)
            beam.Transparency = 0.2
            beam.Parent = Workspace
            FlaskState.BeamPart = beam
        end
        if not FlaskState.AccentPart or not FlaskState.AccentPart.Parent then
            local accent = Instance.new("Part")
            accent.Name = "GlutoFlaskBeamAccent"
            accent.Anchored = true; accent.CanCollide = false
            accent.CanTouch = false; accent.CanQuery = false; accent.CastShadow = false
            accent.Material = Enum.Material.SmoothPlastic
            accent.Color = VD.FLASK_AccentColor or Color3.fromRGB(25, 25, 25)
            accent.Transparency = 0.35
            accent.Parent = Workspace
            FlaskState.AccentPart = accent
        end
        if FlaskState.BeamPart then FlaskState.BeamPart.Color = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255) end
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
            ring.Name = "GlutoFlaskLanding"
            ring.Shape = Enum.PartType.Cylinder
            ring.Anchored = true; ring.CanCollide = false
            ring.CanTouch = false; ring.CanQuery = false; ring.CastShadow = false
            ring.Material = Enum.Material.Neon
            ring.Color = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255)
            ring.Size = Vector3.new(0.2, 5, 5)
            ring.Parent = Workspace
            FlaskState.LandingRing = ring
        end
        FlaskState.LandingRing.Color = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255)
        FlaskState.LandingRing.CFrame = CFrame.new(pos) * CFrame.Angles(0, 0, math.rad(90))
        FlaskState.LandingRing.Transparency = 0.35
    end

    W._FlaskState = FlaskState

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
            Flask_HideVisuals(); FlaskState.Target = nil; FlaskState.PredictedPos = nil; return
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

    W.Flask_SetEnabled = function(v) VD.FLASK_SilentAim = v and true or false; if not v then Flask_ClearVisuals() end end
    W.Flask_SetBeamColor   = function(c) VD.FLASK_BeamColor = c end
    W.Flask_SetAccentColor = function(c) VD.FLASK_AccentColor = c end
    W.Flask_SetSpeed       = function(v) VD.FLASK_Speed = tonumber(v) or 90 end
    W.Flask_SetGravity     = function(v) VD.FLASK_Gravity = tonumber(v) or 196 end
    W.Flask_SetLead        = function(v) VD.FLASK_LeadMult = tonumber(v) or 1.0 end
    W.Flask_SetRange       = function(v) VD.FLASK_Range = tonumber(v) or 200 end
end

--====================================================--
-- SPEAR AIMBOT
--====================================================--
do
    VD.SPEAR_Aimbot = VD.SPEAR_Aimbot or false
    VD.SPEAR_Gravity = VD.SPEAR_Gravity or 50
    VD.SPEAR_Speed = VD.SPEAR_Speed or 100
    local SpearBtnData = {
        UI = nil, Button = nil, Active = true, DragLocked = false,
        Dragging = false, DragStart = nil, DragStartPos = nil,
        ManualTarget = nil, TargetIndex = 0,
        TargetLabel = nil, LeftArrow = nil, RightArrow = nil,
    }
    local function SpearAimbotCalc(targetPos)
        if not VD.SPEAR_Aimbot or GetRole() ~= "Killer" then return nil end
        local char = LP.Character
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
    local function Spear_GetTargetList()
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        local list = {}
        if not root then return list end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LP and TeamIs(player, "Survivor") and player.Character then
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
            VD_Notify("Spear Aimbot", "Tidak ada target survivor.", 2)
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
        VD_Notify("Spear Aimbot", "Target: " .. SpearBtnData.ManualTarget.Name, 2)
        Spear_UpdateTargetLabel()
    end
    local function Spear_UpdateAim()
        if not VD.SPEAR_Aimbot then return end
        if SpearBtnData and not SpearBtnData.Active then return end
        if GetRole() ~= "Killer" then return end
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
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
                if player ~= LP and TeamIs(player, "Survivor") and player.Character then
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
        local pg = LP:FindFirstChild("PlayerGui")
        if not pg then return end
        SpearBtnData.UI = Instance.new("ScreenGui")
        SpearBtnData.UI.Name = "GlutoSpearAimbotUI"
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
        SpearBtnData.Button.TextColor3 = Color3.fromRGB(255, 100, 100)
        SpearBtnData.Button.TextSize = 11
        SpearBtnData.Button.Font = Enum.Font.GothamBold
        SpearBtnData.Button.Visible = false
        SpearBtnData.Button.ZIndex = 10
        SpearBtnData.Button.Parent = SpearBtnData.UI
        Instance.new("UICorner", SpearBtnData.Button).CornerRadius = UDim.new(1, 0)
        local spearStk = Instance.new("UIStroke", SpearBtnData.Button)
        spearStk.Color = Color3.fromRGB(255, 80, 80)
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
        targetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
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
        rightArrow.TextColor3 = Color3.fromRGB(255, 150, 150)
        rightArrow.TextSize = 16
        rightArrow.Font = Enum.Font.GothamBold
        rightArrow.ZIndex = 10
        rightArrow.Parent = SpearBtnData.Button
        Instance.new("UICorner", rightArrow).CornerRadius = UDim.new(1, 0)
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
                VD_Notify("Spear Aimbot", "Spear Aimbot AKTIF!", 3)
            else
                SpearBtnData.Button.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                SpearBtnData.Button.TextColor3 = Color3.fromRGB(255, 100, 100)
                spearStk.Color = Color3.fromRGB(255, 80, 80)
                VD_Notify("Spear Aimbot", "Spear Aimbot NONAKTIF", 3)
            end
        end)
    end
    RunService.RenderStepped:Connect(function() pcall(Spear_UpdateAim) end)
    RunService.Heartbeat:Connect(function()
        if SpearBtnData and SpearBtnData.Button then
            local shouldShow = VD.SPEAR_Aimbot and GetRole() == "Killer"
            SpearBtnData.Button.Visible = shouldShow
            if shouldShow then pcall(Spear_UpdateTargetLabel) end
        end
    end)
    LP.CharacterAdded:Connect(function()
        task.wait(0.5)
        if VD.SPEAR_Aimbot then pcall(Spear_SetupButton) end
    end)
    W.SpearAimbot_SetEnabled = function(v)
        VD.SPEAR_Aimbot = v and true or false
        if v then SpearBtnData.Active = true; Spear_SetupButton()
        else
            if SpearBtnData.UI then pcall(function() SpearBtnData.UI:Destroy() end); SpearBtnData.UI = nil end
            SpearBtnData.Button = nil
        end
    end
    W.SpearAimbot_SetGravity = function(v) VD.SPEAR_Gravity = tonumber(v) or 50 end
    W.SpearAimbot_SetSpeed   = function(v) VD.SPEAR_Speed   = tonumber(v) or 100 end
    W.SpearAimbot_CycleTarget = Spear_CycleTarget
end

--====================================================--
-- SILENT VEIL V1
--====================================================--
local VeilState = { target = nil, lookVector = nil, velHistory = {} }
W._VeilState = VeilState
do
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
            VeilState.target = nil; VeilState.lookVector = nil; return
        end
        local cam = Workspace.CurrentCamera
        if not cam then return end
        if not VD.VeilEnabled then VeilState.target = nil; VeilState.lookVector = nil; return end
        local char = LP.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
        local nearest, nearestPart = nil, nil
        local bestDist = VD.VeilFOV or 150
        local bestStudDist = VD.VeilMaxDist or 500
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and Veil_IsSurvivorVeil(p) and p.Character then
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
            if dist > 0.1 and dist <= (VD.VeilMaxDist or 500) then
                local isAuraActive = char:GetAttribute("special") == true
                local prof
                if isAuraActive then
                    prof = { v0 = VD.VeilAuraSpearSpeed or 165, g = VD.VeilAuraSpearGravity or 96.5, windup = 0.10, latency = 0.04, maxlead = 25, scale = VD.VeilLeadMultiplier or 1.4 }
                else
                    prof = { v0 = VD.VeilSpearSpeed or 165, g = VD.VeilGravity or 103, windup = 0.10, latency = 0.04, maxlead = 45, scale = VD.VeilLeadMultiplier or 1.4 }
                end
                local aimPoint = tp
                if VD.VeilAutoPredict then
                    local vel = Veil_getCharacterVelocity(nearest.Character)
                    if vel.Magnitude > 0.5 then
                        local h0 = Vector3.new(dir.X, 0, dir.Z)
                        local _, tFlight = Veil_solvePitch(prof, h0.Magnitude, dir.Y)
                        local ping = 0.08
                        pcall(function() ping = math.clamp(LP:GetNetworkPing(), 0, 0.35) end)
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
            end
        else
            VeilState.target = nil; VeilState.lookVector = nil
        end
    end
    RunService.RenderStepped:Connect(function() pcall(Veil_UpdateAimbot) end)
end

--====================================================--
-- SILENT VEIL V2 (W424)
--====================================================--
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
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local closestFovDist = AimConfig.Veil_FOV
        local closestTarget = nil
        local cam = workspace.CurrentCamera
        local centerScreen = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Team and p.Team.Name == "Survivors" and p.Character then
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

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        local isTouch = (input.UserInputType == Enum.UserInputType.Touch)
        if gameProcessed and not isTouch then return end
        local char = LP.Character
        local isSpearMode = char and char:GetAttribute("spearmode") == true
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if IsVeilSilentOn() and isSpearMode then isChargingSpear = true end
        end
        if isTouch then
            if IsVeilSilentOn() and isSpearMode then
                local playerGui = LP:FindFirstChild("PlayerGui")
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
            local myChar = LP.Character
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
        local char = LP.Character
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

    W.W424Veil_API = {
        AimConfig = AimConfig,
        Config = Config,
        getClosestSurvivor = getClosestSurvivor,
        IsVeilSilentOn = IsVeilSilentOn,
        setTracker = function(v) VeilTrackerEnabled = v end,
    }
end

--====================================================--
-- HOOK GLOBAL (Veil + Flask + Fall + AntiBlind + Carry)
--====================================================--
task.spawn(function()
    pcall(function()
        if typeof(hookmetamethod) ~= "function" then return end
        local oldNC
        oldNC = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if checkcaller() then return oldNC(self, ...) end
            local ok, n = pcall(function() return self.Name end)

            -- No Fall Damage
            if method == "FireServer" and VD.NoFallDamage and ok and n == "Fall" then
                local par = self.Parent
                if par and par.Name == "Mechanics" then return nil end
            end

            -- Anti Blind
            if method == "FireServer" and VD.KILLER_AntiBlind and ok and n == "GotBlinded" then
                local par = self.Parent
                if par and par.Name == "Flashlight" and GetRole() == "Killer" then return nil end
            end

            -- Veil (Spearthrow)
            if method == "FireServer" and ok and n == "Spearthrow" then
                local args = {...}
                local V1On = VD.VeilEnabled and W._VeilState and typeof(W._VeilState.lookVector) == "Vector3"
                local API = W.W424Veil_API
                local V2Block = false
                local V2Predict = false
                if API and API.AimConfig then
                    if API.AimConfig.Aim_SilentVeil and not API.AimConfig.Aim_SilentVeilV2 then V2Block = true end
                    if API.AimConfig.Aim_SilentVeilV2 then V2Predict = true end
                end

                if V2Block then return nil end

                if V2Predict and API then
                    local ac = API.AimConfig
                    local cfg = API.Config
                    local lookVec, speed, originPos = args[1], args[2], args[3]
                    speed = speed or ac.SPEAR_Speed or 165
                    local myChar = LP.Character
                    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local startPart = myChar and (myChar:FindFirstChild("Head") or myHRP)
                    local isSpecial = myChar and myChar:GetAttribute("special") == true
                    if cfg and cfg.SpearSmart_enable then
                        speed = isSpecial and 165 or 142.5
                    else
                        speed = ac.SPEAR_Speed or 165
                    end
                    originPos = originPos or (myHRP and myHRP.Position) or (startPart and startPart.Position)
                    local bestDir = lookVec
                    local targetPart = API.getClosestSurvivor and API.getClosestSurvivor()
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
                        local leadMult = ac.Veil_LeadMultiplier or 1.4
                        local predicted = targetPos + (targetVel * (timeToHit * leadMult))
                        local spearG = workspace.Gravity * 0.5
                        local drop = 0.5 * spearG * (timeToHit * timeToHit)
                        local finalPos = predicted + Vector3.new(0, drop - 1.5, 0)
                        bestDir = (finalPos - originPos).Unit
                    end
                    args[1] = bestDir
                    args[2] = speed
                    args[3] = originPos
                    return oldNC(self, unpack(args))
                end

                if V1On then
                    if typeof(args[1]) == "Vector3" then
                        args[1] = W._VeilState.lookVector
                        return oldNC(self, unpack(args))
                    end
                end
            end

            -- Silent Flask
            if method == "FireServer" and VD.FLASK_SilentAim and ok and n == "ThrowFlask" then
                local FS = W._FlaskState
                if FS and FS.PredictedPos and GetRole() == "Killer" then
                    local args = {...}
                    if typeof(args[2]) == "Vector3" then
                        local o = args[2]
                        local dir = (FS.PredictedPos - o)
                        if dir.Magnitude > 0.1 then
                            args[1] = dir.Unit
                            return oldNC(self, unpack(args))
                        end
                    elseif typeof(args[1]) == "Vector3" then
                        local hand = LP.Character and (LP.Character:FindFirstChild("LeftHand") or LP.Character:FindFirstChild("Left Arm") or LP.Character:FindFirstChild("HumanoidRootPart"))
                        if hand then
                            local dir = (FS.PredictedPos - hand.Position)
                            if dir.Magnitude > 0.1 then
                                args[1] = dir.Unit
                                return oldNC(self, unpack(args))
                            end
                        end
                    end
                end
            end

            -- Unlock Carry
            if method == "GetAttribute" and W.W424_CarryConfig and W.W424_CarryConfig.Enabled then
                local args = {...}
                if args[1] == "IsCarrying" then return false end
            end

            return oldNC(self, ...)
        end)
    end)
end)--====================================================--
-- SWIFT VAULT
--====================================================--
do
    VD.SURV_AutoVault  = VD.SURV_AutoVault  or false
    VD.SURV_FastVault  = VD.SURV_FastVault  or false
    VD.SURF_VaultSpeed = VD.SURF_VaultSpeed or 13
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
    RunService.Heartbeat:Connect(function()
        if VD.SURV_FastVault then
            pcall(function()
                local char = LP.Character
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
            local char   = LP.Character
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
                    if fastvault     then pcall(function() fastvault:FireServer(LP) end) end
                    if vaultComplete1 then pcall(function() vaultComplete1:FireServer() end) end
                    if vaultComplete  then pcall(function() vaultComplete:FireServer(finalTarget, false) end) end
                end
                _vaultedWindows[rootWindow] = tick()
                break
            end
        end)
    end)
    LP.CharacterAdded:Connect(function()
        task.wait(0.5); _vaultedWindows = {}
    end)
    W.SwiftVault_SetEnabled = function(v)
        VD.SURV_AutoVault = v and true or false; _vaultedWindows = {}
    end
    W.SwiftVaultV2_SetEnabled = function(v)
        VD.SURV_FastVault = v and true or false
        if not v then
            local char = LP.Character
            if char then pcall(function() char:SetAttribute("vaultspeed", 1) end) end
        end
    end
    W.SwiftVault_SetSpeed = function(v) VD.SURF_VaultSpeed = tonumber(v) or 13 end
end

--====================================================--
-- PALLET REFLEX
--====================================================--
do
    VD.SURV_AutoPallet     = VD.SURV_AutoPallet     or false
    VD.SURV_AutoPalletDist = VD.SURV_AutoPalletDist or 20
    local _lastPalletDrop = 0
    local _usedPallets = {}
    local function Pallet_GetKillerRoot()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and TeamIs(plr, "Killer") and plr.Character then
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
            local char   = LP.Character
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
    LP.CharacterAdded:Connect(function()
        task.wait(0.5); _usedPallets = {}
    end)
    W.PalletReflex_SetEnabled = function(v)
        VD.SURV_AutoPallet = v and true or false; _usedPallets = {}
    end
    W.PalletReflex_SetDistance = function(v) VD.SURV_AutoPalletDist = tonumber(v) or 20 end
end

--====================================================--
-- AUTO SKILL CHECK
--====================================================--
W.SkillCheck = W.SkillCheck or { Enabled=false, Mode="Legit", Busy=false, Connection=nil }
local SC = W.SkillCheck
local SC_TouchID = 8822
local SC_ActionPath = "Survivor-mob.Controls.action.check"
local function SC_PressSpace()
    if not VirtualInputManager then return end
    pcall(function()
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        task.wait()
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    end)
end
local function SC_GetActionTarget()
    local pGui = LP:FindFirstChildOfClass("PlayerGui")
    if not pGui then return nil end
    local current = pGui
    for seg in string.gmatch(SC_ActionPath, "[^%.]+") do
        current = current and current:FindFirstChild(seg)
    end
    return current
end
local function SC_TriggerMobileButton()
    local b = SC_GetActionTarget()
    if b and b:IsA("GuiObject") then
        local p, s = b.AbsolutePosition, b.AbsoluteSize
        local i = GuiService:GetGuiInset()
        local cx, cy = p.X + (s.X/2) + i.X, p.Y + (s.Y/2) + i.Y
        pcall(function()
            VirtualInputManager:SendTouchEvent(SC_TouchID, 0, cx, cy)
            task.wait(0.01)
            VirtualInputManager:SendTouchEvent(SC_TouchID, 2, cx, cy)
        end)
    end
end
function W.SkillCheck_Start()
    if SC.Connection then SC.Connection:Disconnect(); SC.Connection = nil end
    SC.Connection = RunService.RenderStepped:Connect(function()
        if not SC.Enabled or SC.Busy then return end
        local pGui = LP:FindFirstChildOfClass("PlayerGui")
        if not pGui then return end
        local prompt = pGui:FindFirstChild("SkillCheckPromptGui")
        if not prompt then return end
        local check = prompt:FindFirstChild("Check")
        if not check or not check.Visible then return end
        local line = check:FindFirstChild("Line")
        local goal = check:FindFirstChild("Goal")
        if not line or not goal then return end
        if SC.Mode == "Instant" then
            line.Rotation = goal.Rotation + 109
            SC.Busy = true
            task.spawn(function()
                if UserInputService.TouchEnabled then SC_TriggerMobileButton() else SC_PressSpace() end
                task.wait(0.2); SC.Busy = false
            end)
        else
            local lr = line.Rotation % 360
            local gr = goal.Rotation % 360
            local sR = (gr + 102) % 360
            local eR = (gr + 116) % 360
            local success = (sR > eR and (lr >= sR or lr <= eR)) or (lr >= sR and lr <= eR)
            if success then
                SC.Busy = true
                task.spawn(function()
                    if UserInputService.TouchEnabled then SC_TriggerMobileButton() else SC_PressSpace() end
                    task.wait(0.05); SC.Busy = false
                end)
            end
        end
    end)
end
function W.SkillCheck_Stop()
    if SC.Connection then SC.Connection:Disconnect(); SC.Connection = nil end
    SC.Busy = false
end
function W.SkillCheck_SetEnabled(v)
    SC.Enabled = v and true or false
    if SC.Enabled then W.SkillCheck_Start() else W.SkillCheck_Stop() end
end

--====================================================--
-- BYPASS GENERATOR
--====================================================--
W.GenBypass = W.GenBypass or {
    Enabled=false, Cache={}, CacheTimer=0,
    Processed={}, HotkeyCode=Enum.KeyCode.B, TriggerRange=8
}
local GenBypass = W.GenBypass
function W.GB_GetAllGeneratorsCached()
    local now = tick()
    if now - GenBypass.CacheTimer < 5 then return GenBypass.Cache end
    GenBypass.Cache = {}; GenBypass.CacheTimer = now
    local mf = Workspace:FindFirstChild("Map")
    if not mf then return GenBypass.Cache end
    pcall(function()
        for _, v in pairs(mf:GetDescendants()) do
            if not v:IsA("Model") then continue end
            if v.Name ~= "Generator" then continue end
            local real = v:GetAttribute("RepairProgress") ~= nil
                      or v:GetAttribute("kickcount") ~= nil
                      or v:GetAttribute("ProgressRepair") ~= nil
            if real then table.insert(GenBypass.Cache, v) end
        end
    end)
    return GenBypass.Cache
end
function W.GB_WaitRepairing(pt, t)
    local s = tick()
    while tick() - s < (t or 1) do
        if pt:GetAttribute("IsRepairing") == true then return true end
        task.wait(0.05)
    end
    return false
end
function W.GB_DoRepair(tp)
    local gm = tp.Parent
    if GenBypass.Processed[gm] then return end
    GenBypass.Processed[gm] = true
    local c = LP.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if not hrp then GenBypass.Processed[gm] = nil; return end
    local re = ReplicatedStorage:FindFirstChild("Remotes")
        and ReplicatedStorage.Remotes:FindFirstChild("Generator")
        and ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
    local og = hrp.CFrame
    pcall(function()
        for _, p in pairs(W.GB_GetPoints(gm)) do
            if p ~= tp and p.Parent then
                hrp.Anchored = true
                hrp.CFrame = p.CFrame
                task.wait(0.15)
                pcall(function() if re then re:FireServer(p, true) end end)
                if not W.GB_WaitRepairing(p, 0.8) then
                    pcall(function() if re then re:FireServer(p, false) end end)
                    task.wait(0.1)
                    hrp.CFrame = p.CFrame
                    task.wait(0.15)
                    pcall(function() if re then re:FireServer(p, true) end end)
                    W.GB_WaitRepairing(p, 0.5)
                end
                hrp.Anchored = false
                task.wait(0.05)
            end
        end
    end)
    pcall(function()
        if hrp and hrp.Parent then hrp.Anchored = false; hrp.CFrame = og end
    end)
    task.wait(0.1)
    pcall(function() if re then re:FireServer(tp, false) end end)
end
function W.GB_GetNearestPoint()
    local c = LP.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local best, bd = nil, math.huge
    for _, g in pairs(W.GB_GetAllGeneratorsCached()) do
        for _, p in pairs(W.GB_GetPoints(g)) do
            local d = (hrp.Position - p.Position).Magnitude
            if d < bd then bd = d; best = p end
        end
    end
    return best, bd
end
UserInputService.InputBegan:Connect(function(input, gp)
    if gp or isMobile then return end
    if input.KeyCode == GenBypass.HotkeyCode and GenBypass.Enabled then
        local bp, bd = W.GB_GetNearestPoint()
        if not bp or bd > GenBypass.TriggerRange then return end
        if GenBypass.Processed[bp.Parent] then return end
        W.GB_DoRepair(bp)
    end
end)
task.spawn(function()
    while true do
        task.wait(2)
        local c = LP.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp then
            for gm in pairs(GenBypass.Processed) do
                if not gm or not gm.Parent then GenBypass.Processed[gm] = nil; continue end
                local near = false
                for _, p in pairs(W.GB_GetPoints(gm)) do
                    if p.Parent and (hrp.Position - p.Position).Magnitude <= 10 then near = true; break end
                end
                if not near then GenBypass.Processed[gm] = nil end
            end
        end
    end
end)
function W.setGenBypass(v) GenBypass.Enabled = v end

--====================================================--
-- MOONWALK
--====================================================--
do
    VD.Moonwalk_SideSpeed = VD.Moonwalk_SideSpeed or 0.9
    VD.Moonwalk_BackSpeed = VD.Moonwalk_BackSpeed or 1.2
    VD.Moonwalk_Interval  = VD.Moonwalk_Interval  or 0.07
    local moonwalkEnabled = false
    local moonwalkConn = nil
    local function stopMoonwalk()
        if moonwalkConn then moonwalkConn:Disconnect(); moonwalkConn = nil end
    end
    local function startMoonwalk()
        stopMoonwalk()
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        local lastSwitch = 0
        local direction = 1
        moonwalkConn = RunService.RenderStepped:Connect(function()
            if not moonwalkEnabled then return end
            local c = LP.Character
            if not c then return end
            local cHrp = c:FindFirstChild("HumanoidRootPart")
            local cHum = c:FindFirstChildOfClass("Humanoid")
            if not cHrp or not cHum or cHum.Health <= 0 then return end
            local now = tick()
            if now - lastSwitch >= (VD.Moonwalk_Interval or 0.07) then
                direction = direction * -1
                lastSwitch = now
            end
            local back = cHrp.CFrame.LookVector * -(VD.Moonwalk_BackSpeed or 1.2)
            local side = cHrp.CFrame.RightVector * (direction * (VD.Moonwalk_SideSpeed or 0.9))
            cHum:Move(back + side, false)
        end)
    end
    function W.Moonwalk_Set(state)
        moonwalkEnabled = state and true or false
        if moonwalkEnabled then startMoonwalk() else stopMoonwalk() end
        if getgenv().Gluto_MoonwalkBtn_UpdateVisual then pcall(getgenv().Gluto_MoonwalkBtn_UpdateVisual) end
    end
    function W.Moonwalk_IsOn() return moonwalkEnabled end
    function W.Moonwalk_SetSide(v) VD.Moonwalk_SideSpeed = tonumber(v) or 0.9 end
    function W.Moonwalk_SetBack(v) VD.Moonwalk_BackSpeed = tonumber(v) or 1.2 end
    function W.Moonwalk_SetInterval(v) VD.Moonwalk_Interval = tonumber(v) or 0.07 end
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.F8 then W.Moonwalk_Set(not moonwalkEnabled) end
    end)
    LP.CharacterAdded:Connect(function()
        task.wait(2)
        if moonwalkEnabled then startMoonwalk() end
    end)
end

--====================================================--
-- NO FALL DAMAGE
--====================================================--
-- Note: Hook Fall remote ada di hook global PART 11
-- Part ini cuma nyimpen flag VD.NoFallDamage

--====================================================--
-- NEXT MAP PREDICTION
--====================================================--
do
    local MapPredictState = { Gui = nil, Thread = nil, Enabled = false }
    local function DetectMapName(map)
        if not map then return nil end
        if map:FindFirstChild("random shakes") or map:FindFirstChild("SCP-173 Room") or map:FindFirstChild("SCP-205 Room") then
            return "Site 68"
        elseif map:FindFirstChild("HooksMeat") then return "BLOODBATH! Club"
        elseif map:FindFirstChild("Gate") and map.Gate:FindFirstChild("vfx") then return "Firelink Shrine"
        elseif map:FindFirstChild("Bldg_Addon_RooftopUnit_A") or map:FindFirstChild("Rooftop") then return "Mercy Hospital Rooftop"
        elseif map:FindFirstChild("White Armored Car") then return "Mount Massive Asylum"
        elseif map:FindFirstChild("Dumbster") then return "The Bay Harbor"
        elseif map:FindFirstChild("water pump") then return "Valdelobos Village"
        elseif map:FindFirstChild("LargeBoulder01") then return "Woodview Cabin" end
        return nil
    end
    local function BuildMapGui()
        if MapPredictState.Gui then pcall(function() MapPredictState.Gui:Destroy() end) end
        local pg = LP:FindFirstChild("PlayerGui")
        if gethui then
            local ok, hui = pcall(gethui)
            if ok and hui then pg = hui end
        end
        if not pg then return end
        local gui = Instance.new("ScreenGui")
        gui.Name = "GlutoMapPredict"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 50
        gui.Parent = pg
        local frame = Instance.new("Frame")
        frame.Name = "MainFrame"
        frame.Size = UDim2.new(0, 210, 0, 54)
        frame.Position = UDim2.new(0.5, -105, 0, 110)
        frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        frame.BackgroundTransparency = 0.15
        frame.BorderSizePixel = 0
        frame.Active = true
        frame.Parent = gui
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
        local stroke = Instance.new("UIStroke", frame)
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.Thickness = 1.5
        stroke.Transparency = 0.2
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 15)
        title.Position = UDim2.new(0, 0, 0, 5)
        title.BackgroundTransparency = 1
        title.Text = "NEXT MAP PREDICTION"
        title.TextColor3 = Color3.fromRGB(150, 180, 255)
        title.Font = Enum.Font.GothamBold
        title.TextSize = 10
        title.Parent = frame
        local mapName = Instance.new("TextLabel")
        mapName.Name = "MapName"
        mapName.Size = UDim2.new(1, -12, 0, 18)
        mapName.Position = UDim2.new(0, 6, 0, 21)
        mapName.BackgroundTransparency = 1
        mapName.Text = "Scanning..."
        mapName.TextColor3 = Color3.fromRGB(255, 255, 255)
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
        VD.NextMapPredict = v and true or false
        if VD.NextMapPredict then Start() else Stop() end
    end
end

--====================================================--
-- MANUAL & AUTO GENERATOR
--====================================================--
do
    local RepairEvent = nil
    pcall(function()
        RepairEvent = ReplicatedStorage.Remotes.Generator.RepairEvent
    end)
    local REPAIR_ANIM_ID = "rbxassetid://92960319113695"
    local ManualThread, AutoThread = nil, nil
    local ManualPoint, AutoPoint = nil, nil
    local LastFire = 0
    local RepairAnimTrack = nil
    local function IsKillerNearPos(pos, radius)
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= LP and TeamIs(pl, "Killer") and pl.Character then
                local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - pos).Magnitude <= radius then return true end
            end
        end
        return false
    end
    local function GetNearestKillerDist()
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil, math.huge end
        local best, dist = nil, math.huge
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= LP and TeamIs(pl, "Killer") and pl.Character then
                local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local d = (hrp.Position - myRoot.Position).Magnitude
                    if d < dist then dist = d; best = hrp end
                end
            end
        end
        return best, dist
    end
    local function PlayRepairAnim()
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if not animator then return end
        if RepairAnimTrack and RepairAnimTrack.IsPlaying then return end
        pcall(function()
            local anim = Instance.new("Animation")
            anim.AnimationId = REPAIR_ANIM_ID
            RepairAnimTrack = animator:LoadAnimation(anim)
            RepairAnimTrack.Priority = Enum.AnimationPriority.Action
            RepairAnimTrack:Play()
        end)
    end
    local function StopRepairAnim()
        if RepairAnimTrack and RepairAnimTrack.IsPlaying then
            pcall(function() RepairAnimTrack:Stop() end)
        end
        RepairAnimTrack = nil
    end
    local function StopRepair(point)
        StopRepairAnim()
        if point and RepairEvent then
            pcall(function() RepairEvent:FireServer(point, false) end)
        end
    end
    local function IsGenDone(gen)
        local p = gen:GetAttribute("RepairProgress") or gen:GetAttribute("ProgressRepair") or 0
        return p >= 100
    end
    local function GetNearestGenPointInReach()
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local bestPt, bestDist = nil, 5.5
        for _, gen in ipairs(W.GB_GetAllGenerators()) do
            for _, pt in ipairs(W.GB_GetPoints(gen)) do
                if pt and pt.Parent then
                    local d = (myRoot.Position - pt.Position).Magnitude
                    if d < bestDist then bestDist = d; bestPt = pt end
                end
            end
        end
        return bestPt
    end
    local function GetSafeNearestGenPoint()
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local bestPt, bestDist = nil, math.huge
        for _, gen in ipairs(W.GB_GetAllGenerators()) do
            if IsGenDone(gen) then continue end
            local genPivot
            pcall(function() genPivot = gen:GetPivot().Position end)
            if genPivot and IsKillerNearPos(genPivot, VD.KillerEscapeDist) then continue end
            for _, pt in ipairs(W.GB_GetPoints(gen)) do
                if pt and pt.Parent then
                    local d = (pt.Position - myRoot.Position).Magnitude
                    if d < bestDist then bestDist = d; bestPt = pt end
                end
            end
        end
        return bestPt
    end
    local function StartManualThread()
        if ManualThread then pcall(function() task.cancel(ManualThread) end); ManualThread = nil end
        ManualThread = task.spawn(function()
            while VD.ManualGen do
                local myChar = LP.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then task.wait(0.2); continue end
                local _, kd = GetNearestKillerDist()
                if kd <= VD.KillerEscapeDist then
                    if ManualPoint then
                        StopRepair(ManualPoint)
                        ManualPoint = nil
                        VD_Notify("Manual Gen", "Killer near — release repair", 2)
                    end
                    task.wait(0.3)
                    continue
                end
                local pt = GetNearestGenPointInReach()
                if pt then
                    ManualPoint = pt
                    local now = tick()
                    if now - LastFire >= 0.5 then
                        pcall(function() if RepairEvent then RepairEvent:FireServer(pt, true) end end)
                        PlayRepairAnim()
                        LastFire = now
                    end
                else
                    if ManualPoint then StopRepair(ManualPoint); ManualPoint = nil end
                end
                task.wait(0.1)
            end
            if ManualPoint then StopRepair(ManualPoint) end
            ManualPoint = nil
        end)
    end
    local function StopManualThread()
        if ManualThread then pcall(function() task.cancel(ManualThread) end); ManualThread = nil end
        if ManualPoint then StopRepair(ManualPoint) end
        ManualPoint = nil
    end
    local function StartAutoThread()
        if AutoThread then pcall(function() task.cancel(AutoThread) end); AutoThread = nil end
        AutoThread = task.spawn(function()
            while VD.AutoGen do
                local myChar = LP.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then task.wait(0.3); continue end
                local _, kd = GetNearestKillerDist()
                if kd <= VD.KillerEscapeDist then
                    if AutoPoint then StopRepair(AutoPoint); AutoPoint = nil end
                    local safePt = GetSafeNearestGenPoint()
                    if safePt then
                        AutoPoint = safePt
                        pcall(function() myRoot.CFrame = CFrame.new(safePt.Position + Vector3.new(0, 3, 0)) end)
                        task.wait(0.2)
                    end
                    task.wait(0.2)
                    continue
                end
                if AutoPoint and AutoPoint.Parent then
                    local now = tick()
                    if now - LastFire >= 0.5 then
                        pcall(function() if RepairEvent then RepairEvent:FireServer(AutoPoint, true) end end)
                        PlayRepairAnim()
                        LastFire = now
                    end
                else
                    local pt = GetNearestGenPointInReach()
                    if pt then AutoPoint = pt
                    else
                        local safePt = GetSafeNearestGenPoint()
                        if safePt then
                            AutoPoint = safePt
                            pcall(function() myRoot.CFrame = CFrame.new(safePt.Position + Vector3.new(0, 3, 0)) end)
                            task.wait(0.2)
                        end
                    end
                end
                task.wait(0.1)
            end
            if AutoPoint then StopRepair(AutoPoint) end
            AutoPoint = nil
        end)
    end
    local function StopAutoThread()
        if AutoThread then pcall(function() task.cancel(AutoThread) end); AutoThread = nil end
        if AutoPoint then StopRepair(AutoPoint) end
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
    W.GenAuto_SetDistance = function(v) VD.KillerEscapeDist = tonumber(v) or 30 end
    LP.CharacterAdded:Connect(function()
        task.wait(1)
        if VD.ManualGen then StartManualThread() end
        if VD.AutoGen then StartAutoThread() end
    end)
end

--====================================================--
-- BYPASS SELF UNHOOK
--====================================================--
W.SelfUnhook = W.SelfUnhook or {
    Enabled=false, Following=false, FollowDuration=30, FollowDistance=20,
    MonitorConn=nil, TriggerCount=0, _lastTrigger=0, _cooldown=3,
    _hookPos=nil, _hookCFrame=nil, _activeThread=nil, _wasHooked=false
}
local SU = W.SelfUnhook
function W.SU_IsHooked()
    local char = LP.Character
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
        if p ~= LP and TeamIs(p, "Killer") and p.Character then
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
    SU.TriggerCount = SU.TriggerCount + 1
    local char = LP.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then SU._hookPos = hrp.Position; SU._hookCFrame = hrp.CFrame end
    end
    SU._activeThread = task.spawn(function()
        local c = LP.Character
        if not c then SU.Following = false; SU._activeThread = nil; return end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if not hrp then SU.Following = false; SU._activeThread = nil; return end
        local re = ReplicatedStorage:FindFirstChild("Remotes")
            and ReplicatedStorage.Remotes:FindFirstChild("Generator")
            and ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
        if not W.SU_IsHooked() then SU.Following = false; SU._activeThread = nil; return end
        local tp = W.SU_GetRandomGeneratorPoint()
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
                VD_Notify("Bypass Self Unhook", "Udah lepas hook - STOP", 2)
                return
            end
            local cc = LP.Character
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
            local c2 = LP.Character
            if c2 then
                local r2 = c2:FindFirstChild("HumanoidRootPart")
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
        local char = LP.Character
        if not char then return end
        local isH = W.SU_IsHooked()
        if not isH then SU._wasHooked = false; return end
        if not SU._wasHooked and not SU.Following then SU._wasHooked = true; W.SU_Trigger() end
    end)
end
function W.SU_Stop()
    if SU.MonitorConn then SU.MonitorConn:Disconnect(); SU.MonitorConn = nil end
    W.SU_Abort(); SU._wasHooked = false
end
function W.SU_SetEnabled(v)
    SU.Enabled = v
    if v then W.SU_Start() else W.SU_Stop() end
end--====================================================--
-- DASH LOCK
--====================================================--
do
    VD.DashLockEnabled       = VD.DashLockEnabled      or false
    VD.DashLockDuration      = VD.DashLockDuration     or 1.5
    VD.DashLockSmoothness    = VD.DashLockSmoothness   or 0.3
    VD.FreezeDuringDashLock  = VD.FreezeDuringDashLock or false
    VD._DashLockActive       = false
    VD._DashLockTarget       = nil
    VD._DashLockConnection   = nil
    local DashAnimationId = "rbxassetid://98163597193511"
    local function DashLock_Update()
        if not VD.DashLockEnabled or not VD._DashLockActive then return end
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then VD._DashLockTarget = nil; return end
        local target, targetDist = nil, math.huge
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LP and TeamIs(player, "Survivor") then
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
                VD._DashLockConnection = RunService.RenderStepped:Connect(function() pcall(DashLock_Update) end)
            end
        else
            if VD._DashLockConnection then
                pcall(function() VD._DashLockConnection:Disconnect() end)
                VD._DashLockConnection = nil
            end
            VD._DashLockTarget = nil
            if VD.FreezeDuringDashLock then
                local char = LP.Character
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
                task.delay(VD.DashLockDuration or 1.5, function() DashLock_SetActive(false) end)
            end
        end)
    end
    if LP.Character then DashLock_HookCharacter(LP.Character) end
    LP.CharacterAdded:Connect(function(c)
        task.wait(0.5); DashLock_HookCharacter(c)
    end)
    W.DashLock_SetActive = DashLock_SetActive
    W.DashLock_SetEnabled = function(v)
        VD.DashLockEnabled = v and true or false
        if not v then DashLock_SetActive(false) end
    end
end

--====================================================--
-- GRAPHICS SYSTEM
--====================================================--
W.Graphics = W.Graphics or {
    Fullbright = false, NoShadow = false, LowGraphics = false,
    NoScreenEffects = false, CleanSky = false,
    ClockTimeEnabled = false, ClockTime = 14, Brightness = 2,
    UnlimitedZoom = false, MaxZoomDistance = 1000,
    FOVEnabled = false, FOV = 70, PotatoEnabled = false,
}
local G = W.Graphics
local original = {
    Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
    Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
    GlobalShadows = Lighting.GlobalShadows,
    FOV = Workspace.CurrentCamera and Workspace.CurrentCamera.FieldOfView or 70,
}
local LastState = { Fullbright = nil, NoShadow = nil, Ambient = nil, Brightness = nil, ClockTime = nil }
local LastOptimize = { LowGraphics = nil, CleanSky = nil }
local DisabledEffects = {}
local ScreenEffectTypes = { "ColorCorrectionEffect", "DepthOfFieldEffect", "BlurEffect", "SunRaysEffect", "BloomEffect" }
local function Graphics_Apply(force)
    if force or LastState.Fullbright ~= G.Fullbright then
        LastState.Fullbright = G.Fullbright
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
    end
    if force or LastState.NoShadow ~= G.NoShadow then
        LastState.NoShadow = G.NoShadow
        Lighting.GlobalShadows = not G.NoShadow
    end
    local ambientChanged = LastState.Ambient ~= G.ClockTimeEnabled or LastState.Brightness ~= G.Brightness or LastState.ClockTime ~= G.ClockTime
    if force or ambientChanged then
        LastState.Ambient = G.ClockTimeEnabled
        LastState.Brightness = G.Brightness
        LastState.ClockTime = G.ClockTime
        if G.ClockTimeEnabled then
            Lighting.ClockTime  = G.ClockTime; Lighting.Brightness = G.Brightness
        elseif not G.Fullbright then
            Lighting.Brightness = original.Brightness
            Lighting.ClockTime  = original.ClockTime
        end
    end
end
local function Graphics_ApplyOptimization(force)
    if force or LastOptimize.LowGraphics ~= G.LowGraphics then
        LastOptimize.LowGraphics = G.LowGraphics
        pcall(function()
            if G.LowGraphics then settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            else settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end
        end)
    end
    if force or LastOptimize.CleanSky ~= G.CleanSky then
        LastOptimize.CleanSky = G.CleanSky
        if G.CleanSky then
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("Sky") then v:Destroy() end
            end
        end
    end
end
local function Graphics_ApplyNoScreenEffects()
    if G.NoScreenEffects then
        for _, v in pairs(Lighting:GetChildren()) do
            for _, t in ipairs(ScreenEffectTypes) do
                if v:IsA(t) then
                    if DisabledEffects[v] == nil then DisabledEffects[v] = v.Enabled end
                    v.Enabled = false
                end
            end
        end
    else
        for obj, state in pairs(DisabledEffects) do
            if obj and obj.Parent then obj.Enabled = state end
        end
        DisabledEffects = {}
    end
end
Lighting.ChildAdded:Connect(function(v)
    if not G.NoScreenEffects then return end
    task.wait()
    for _, t in ipairs(ScreenEffectTypes) do
        if v:IsA(t) then
            if DisabledEffects[v] == nil then DisabledEffects[v] = v.Enabled end
            v.Enabled = false
        end
    end
end)
local function Graphics_ApplyZoom()
    if G.UnlimitedZoom then
        LP.CameraMaxZoomDistance = G.MaxZoomDistance
        LP.CameraMinZoomDistance = 0
    else
        LP.CameraMaxZoomDistance = 128
        LP.CameraMinZoomDistance = 0.5
    end
end
local function Graphics_ApplyFOV()
    local cam = Workspace.CurrentCamera
    if not cam then return end
    if G.FOVEnabled then cam.FieldOfView = G.FOV
    else cam.FieldOfView = original.FOV end
end

-- POTATO MODE
local Potato_Enabled = false
local Potato_Busy = false
local Potato_Changed = {}
local Potato_Connections = {}
local POTATO_BATCH_SIZE = 40
local function Potato_Save(obj, prop)
    if not Potato_Changed[obj] then Potato_Changed[obj] = {} end
    if Potato_Changed[obj][prop] == nil then
        local ok, val = pcall(function() return obj[prop] end)
        if ok then Potato_Changed[obj][prop] = val end
    end
end
local function Potato_Set(obj, prop, value)
    if not obj or not obj.Parent then return end
    Potato_Save(obj, prop)
    pcall(function() obj[prop] = value end)
end
local function Potato_Optimize(obj)
    if not Potato_Enabled or not obj then return end
    if obj:IsA("BasePart") then
        Potato_Set(obj, "CastShadow", false)
        Potato_Set(obj, "Reflectance", 0)
        pcall(function() Potato_Set(obj, "Material", Enum.Material.Plastic) end)
    end
    if obj:IsA("MeshPart") then
        pcall(function() Potato_Set(obj, "RenderFidelity", Enum.RenderFidelity.Performance) end)
    end
    if obj:IsA("Texture") or obj:IsA("Decal") then Potato_Set(obj, "Transparency", 1) end
    if obj:IsA("ParticleEmitter") then Potato_Set(obj, "Enabled", false) end
    if obj:IsA("Trail") then Potato_Set(obj, "Enabled", false) end
    if obj:IsA("Beam") then Potato_Set(obj, "Enabled", false) end
    if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then Potato_Set(obj, "Enabled", false) end
end
local function Potato_Enable()
    if Potato_Enabled then return end
    Potato_Enabled = true
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    Potato_Set(Lighting, "GlobalShadows", false)
    Potato_Set(Lighting, "Brightness", 1)
    if not Potato_Connections.NewObject then
        Potato_Connections.NewObject = Workspace.DescendantAdded:Connect(function(obj)
            if not Potato_Enabled then return end
            task.defer(function() if Potato_Enabled then Potato_Optimize(obj) end end)
        end)
    end
    task.spawn(function()
        if Potato_Busy then return end
        Potato_Busy = true
        local objects = Workspace:GetDescendants()
        local total = #objects
        local index = 1
        while Potato_Enabled and index <= total do
            local finish = math.min(index + POTATO_BATCH_SIZE - 1, total)
            for i = index, finish do
                if not Potato_Enabled then break end
                Potato_Optimize(objects[i])
            end
            RunService.Heartbeat:Wait()
            index = finish + 1
        end
        Potato_Busy = false
    end)
end
local function Potato_Disable()
    if not Potato_Enabled then return end
    Potato_Enabled = false
    for name, conn in pairs(Potato_Connections) do
        pcall(function() conn:Disconnect() end)
        Potato_Connections[name] = nil
    end
    task.spawn(function()
        local count = 0
        for obj, properties in pairs(Potato_Changed) do
            if obj and obj.Parent then
                for prop, value in pairs(properties) do
                    pcall(function() obj[prop] = value end)
                    count = count + 1
                    if count >= POTATO_BATCH_SIZE then task.wait(); count = 0 end
                end
            end
        end
        Potato_Changed = {}
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
    if LP.CameraMaxZoomDistance ~= G.MaxZoomDistance then
        LP.CameraMaxZoomDistance = G.MaxZoomDistance
    end
    if LP.CameraMinZoomDistance ~= 0 then LP.CameraMinZoomDistance = 0 end
end)
W.Graphics_Apply             = Graphics_Apply
W.Graphics_ApplyOptimization = Graphics_ApplyOptimization
W.Graphics_ApplyNoScreenFx   = Graphics_ApplyNoScreenEffects
W.Graphics_ApplyZoom         = Graphics_ApplyZoom
W.Graphics_ApplyFOV          = Graphics_ApplyFOV
W.Potato_SetEnabled = function(v)
    G.PotatoEnabled = v and true or false
    if G.PotatoEnabled then Potato_Enable() else Potato_Disable() end
end
W.Potato_IsEnabled = function() return Potato_Enabled end
LP.CharacterAdded:Connect(function()
    task.wait(1)
    Graphics_Apply(true); Graphics_ApplyOptimization(true)
    Graphics_ApplyNoScreenEffects(); Graphics_ApplyZoom(); Graphics_ApplyFOV()
end)

--====================================================--
-- LOCK POV
--====================================================--
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

--====================================================--
-- CAMERA DBD SYSTEM
--====================================================--
do
    VD.CamDBD_SmoothEnabled   = VD.CamDBD_SmoothEnabled   or false
    VD.CamDBD_SmoothSpeed     = VD.CamDBD_SmoothSpeed     or 5
    VD.CamDBD_POVEnabled      = VD.CamDBD_POVEnabled      or false
    VD.CamDBD_TargetPOV       = VD.CamDBD_TargetPOV       or 85
    VD.CamDBD_POVSmooth       = VD.CamDBD_POVSmooth       or 9
    local CameraBindName = "Gluto_CameraDBD_Smooth"
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
            if VD.CamDBD_SmoothEnabled then
                local CurrentCFrame   = Camera.CFrame
                local CurrentPosition = CurrentCFrame.Position
                local CurrentRotation = CurrentCFrame.Rotation
                if not PreviousPosition or not PreviousRotation then
                    PreviousPosition = CurrentPosition
                    PreviousRotation = CurrentRotation
                else
                    local smoothSpeed = tonumber(VD.CamDBD_SmoothSpeed) or 5
                    local posAlpha = 1 - math.exp(-smoothSpeed * DeltaTime)
                    PreviousPosition = PreviousPosition:Lerp(CurrentPosition, posAlpha)
                    local rotAlpha = 1 - math.exp(-(smoothSpeed * 1.90) * DeltaTime)
                    PreviousRotation = PreviousRotation:Lerp(CurrentRotation, rotAlpha)
                    Camera.CFrame = CFrame.new(PreviousPosition) * PreviousRotation
                end
            else
                PreviousPosition = nil; PreviousRotation = nil
            end
            if VD.CamDBD_POVEnabled then
                local povSpeed = tonumber(VD.CamDBD_POVSmooth) or 9
                local alpha = 1 - math.exp(-povSpeed * DeltaTime)
                local target = tonumber(VD.CamDBD_TargetPOV) or 85
                Camera.FieldOfView = Camera.FieldOfView + (target - Camera.FieldOfView) * alpha
            end
        end
    )
    LP.CharacterAdded:Connect(function()
        task.wait(0.5); PreviousPosition = nil; PreviousRotation = nil
    end)
    W.CamDBD_SetSmooth = function(v)
        VD.CamDBD_SmoothEnabled = v and true or false
        if not v then PreviousPosition = nil; PreviousRotation = nil
        else
            local cam = Workspace.CurrentCamera
            if cam then
                PreviousPosition = cam.CFrame.Position
                PreviousRotation = cam.CFrame.Rotation
            end
        end
    end
    W.CamDBD_SetSmoothSpeed = function(v) VD.CamDBD_SmoothSpeed = tonumber(v) or 5 end
    W.CamDBD_SetPOVLock = function(v)
        VD.CamDBD_POVEnabled = v and true or false
        if not v then
            local cam = Workspace.CurrentCamera
            if cam then cam.FieldOfView = OriginalPOV end
        else
            local cam = Workspace.CurrentCamera
            if cam then OriginalPOV = cam.FieldOfView end
        end
    end
    W.CamDBD_SetTargetPOV = function(v) VD.CamDBD_TargetPOV = tonumber(v) or 85 end
    W.CamDBD_SetPOVSmooth = function(v) VD.CamDBD_POVSmooth = tonumber(v) or 9 end
              end--====================================================--
-- EMOTE SYSTEM
--====================================================--
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
    local char = LP.Character
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
W.Emote_Set = W.EmoteSystem_SetEnabled
W.Emote_Stop = W.EmoteSystem_Stop
W.Emote_Select = W.EmoteSystem_SelectEmote
W.Emote = ES
LP.CharacterRemoving:Connect(function() W.EmoteSystem_Stop() end)
LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if ES.Enabled then W.EmoteSystem_Play() end
end)

--====================================================--
-- JERK OFF TOOL
--====================================================--
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
        local character = LP.Character
        if not character then return end
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        local backpack = LP:FindFirstChildWhichIsA("Backpack")
        if not humanoid or not backpack then return end
        local tool = Instance.new("Tool")
        tool.Name = JerkTool.ToolName
        tool.ToolTip = 'in the stripped club. straight up "jorking it".'
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
    LP.CharacterAdded:Connect(function()
        task.wait(1)
        if JerkTool.Enabled then jerkRunning = true; W.JerkOff_Create() end
    end)
end

--====================================================--
-- FAKE AVATAR
--====================================================--
W.FakeAvatar = W.FakeAvatar or { Enabled = false, SelectedId = LP.UserId }
do
    local FA = W.FakeAvatar
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
    function W.FakeAvatar_Apply()
        local character = LP.Character
        if not character or not FA.SelectedId then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        task.spawn(function()
            local success, appearance = pcall(function()
                return Players:GetCharacterAppearanceAsync(FA.SelectedId)
            end)
            if not success or not appearance then warn("[FakeAvatar] Gagal load data avatar!"); return end
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
                local info = Players:GetCharacterAppearanceInfoAsync(FA.SelectedId)
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
        FA.Enabled = v and true or false
        if v then W.FakeAvatar_Apply() end
    end
    function W.FakeAvatar_SetId(id)
        FA.SelectedId = id or LP.UserId
        if FA.Enabled then W.FakeAvatar_Apply() end
    end
    function W.FakeAvatar_FromUsername(username)
        if not username or username == "" then return end
        local ok, userId = pcall(function() return Players:GetUserIdFromNameAsync(username) end)
        if not ok or not userId then
            ForceNotify("Fake Avatar", "Username tidak ditemukan: " .. username, 2); return
        end
        FA.SelectedId = userId
        W.FakeAvatar_Apply()
        ForceNotify("Fake Avatar", "Applied: @" .. username, 2)
    end
    LP.CharacterAdded:Connect(function()
        if FA.Enabled then task.wait(1); W.FakeAvatar_Apply() end
    end)
end

--====================================================--
-- FAKE KORLESS MORPH
--====================================================--
W.KorlessMorph = W.KorlessMorph or { Enabled = false, Connection = nil }
do
    local KM = W.KorlessMorph
    local function ApplyKorless()
        local plr = LP
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
        if KM.Connection then KM.Connection:Disconnect() end
        KM.Connection = LP.CharacterAdded:Connect(function()
            task.wait(1)
            Morph()
        end)
    end
    local function RemoveKorless()
        local char = LP.Character
        if char then
            local mesh = char:FindFirstChild("KorlessHead")
            if mesh then mesh:Destroy() end
            if char:FindFirstChild("Head") then char.Head.Transparency = 0 end
            if char:FindFirstChild("Right Leg") then char["Right Leg"].Transparency = 0 end
        end
        if KM.Connection then
            KM.Connection:Disconnect()
            KM.Connection = nil
        end
    end
    function W.Korless_Set(v)
        KM.Enabled = v and true or false
        if v then ApplyKorless() else RemoveKorless() end
    end
end

--====================================================--
-- HEADER TITLE
--====================================================--
W.HeaderState = W.HeaderState or {
    Enabled = false, Text = "PAZZHUB", Color = Color3.fromRGB(255, 255, 255),
    Billboard = nil, TextLabel = nil, ShineLabel = nil, ShineGradient = nil, SizeConnection = nil,
}
do
    local HS = W.HeaderState
    local BASE_WIDTH = isMobile and 90 or 140
    local BASE_HEIGHT = isMobile and 20 or 32
    local BASE_DISTANCE = 12
    local MIN_SCALE = 0.6
    local MAX_SCALE = isMobile and 1.1 or 1.4
    local function Header_Create()
        if HS.Billboard then HS.Billboard:Destroy() end
        local character = LP.Character or LP.CharacterAdded:Wait()
        if not character:FindFirstChild("Head") then return end
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "GlutoHeaderBillboard"
        billboard.Adornee = character.Head
        billboard.Size = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT)
        billboard.StudsOffset = Vector3.new(0, 1.5, 0)
        billboard.AlwaysOnTop = true; billboard.LightInfluence = 0
        billboard.Parent = character
        HS.Billboard = billboard
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "BaseText"; textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1; textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamBold; textLabel.TextStrokeTransparency = 0.5
        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.TextColor3 = HS.Color
        textLabel.Text = HS.Text; textLabel.ZIndex = 1; textLabel.Parent = billboard
        HS.TextLabel = textLabel
        local shineLabel = Instance.new("TextLabel")
        shineLabel.Name = "ShineText"; shineLabel.Size = UDim2.new(1, 0, 1, 0)
        shineLabel.BackgroundTransparency = 1; shineLabel.TextScaled = true
        shineLabel.Font = Enum.Font.GothamBold; shineLabel.TextStrokeTransparency = 1
        shineLabel.Text = HS.Text; shineLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        shineLabel.ZIndex = 2; shineLabel.Parent = billboard
        HS.ShineLabel = shineLabel
        local shineGradient = Instance.new("UIGradient")
        shineGradient.Name = "ShineGradient"; shineGradient.Rotation = 20
        shineGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.30, 1),
            NumberSequenceKeypoint.new(0.42, 0), NumberSequenceKeypoint.new(0.58, 0),
            NumberSequenceKeypoint.new(0.70, 1), NumberSequenceKeypoint.new(1.00, 1),
        })
        shineGradient.Offset = Vector2.new(-1, 0); shineGradient.Parent = shineLabel
        HS.ShineGradient = shineGradient
        if HS.SizeConnection then HS.SizeConnection:Disconnect() end
        HS.SizeConnection = RunService.RenderStepped:Connect(function()
            if not billboard or not billboard.Parent then HS.SizeConnection:Disconnect(); return end
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
    local function Header_Toggle(enabled)
        if enabled then Header_Create()
        else
            if HS.SizeConnection then HS.SizeConnection:Disconnect(); HS.SizeConnection = nil end
            if HS.Billboard then HS.Billboard:Destroy() end
            HS.Billboard = nil; HS.TextLabel = nil
            HS.ShineLabel = nil; HS.ShineGradient = nil
        end
    end
    function W.Header_Set(v)
        HS.Enabled = v and true or false
        Header_Toggle(HS.Enabled)
    end
    function W.Header_SetText(text)
        HS.Text = text or "PAZZHUB"
        if HS.TextLabel then HS.TextLabel.Text = HS.Text end
        if HS.ShineLabel then HS.ShineLabel.Text = HS.Text end
    end
    function W.Header_SetColor(c)
        HS.Color = c
        if HS.TextLabel then HS.TextLabel.TextColor3 = c end
    end
    LP.CharacterAdded:Connect(function()
        task.wait(1)
        if HS.Enabled then Header_Toggle(true) end
    end)
end

--====================================================--
-- SPECTATOR COUNTER
--====================================================--
do
    local SpecEnabled = false
    local SpecGui = nil
    local SpecLabel = nil
    local SpecThread = nil
    local SpecExpanded = true
    local function Spec_CreateUI()
        if SpecGui then SpecGui:Destroy(); SpecGui = nil end
        SpecGui = Instance.new("ScreenGui")
        SpecGui.Name = "GlutoSpectatorCounter"
        SpecGui.ResetOnSpawn = false; SpecGui.IgnoreGuiInset = true
        SpecGui.Parent = CoreGui
        local mainFrame = Instance.new("Frame", SpecGui)
        mainFrame.Name = "MainBox"
        mainFrame.AnchorPoint = Vector2.new(0.5, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.42, 0)
        mainFrame.Size = UDim2.new(0, 145, 0, 52)
        mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        mainFrame.BackgroundTransparency = 0.1
        mainFrame.BorderSizePixel = 0; mainFrame.Active = true
        Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)
        local topBar = Instance.new("Frame", mainFrame)
        topBar.Name = "TopBar"; topBar.Size = UDim2.new(1, 0, 0, 4)
        topBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255); topBar.BorderSizePixel = 0
        Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 6)
        local header = Instance.new("Frame", mainFrame)
        header.Name = "Header"; header.Size = UDim2.new(1, 0, 0, 18)
        header.Position = UDim2.new(0, 0, 0, 4)
        header.BackgroundTransparency = 1; header.Active = true
        local title = Instance.new("TextLabel", header)
        title.Name = "Title"; title.Size = UDim2.new(1, -20, 1, 0)
        title.BackgroundTransparency = 1; title.Font = Enum.Font.GothamBold
        title.Text = "Spectators"; title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 10; title.TextXAlignment = Enum.TextXAlignment.Center
        local minBtn = Instance.new("TextButton", header)
        minBtn.Name = "MinBtn"; minBtn.Size = UDim2.new(0, 18, 0, 18)
        minBtn.Position = UDim2.new(1, -19, 0, 0)
        minBtn.BackgroundTransparency = 1; minBtn.Text = "−"
        minBtn.TextColor3 = Color3.fromRGB(255, 255, 255); minBtn.Font = Enum.Font.GothamBold
        minBtn.TextSize = 13; minBtn.AutoButtonColor = false
        local divider = Instance.new("Frame", mainFrame)
        divider.Name = "Divider"; divider.Size = UDim2.new(1, -12, 0, 1)
        divider.Position = UDim2.new(0, 6, 0, 23)
        divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
        eye.ImageColor3 = Color3.fromRGB(255, 255, 255); eye.LayoutOrder = 1
        SpecLabel = Instance.new("TextLabel", body)
        SpecLabel.Name = "CountLabel"; SpecLabel.BackgroundTransparency = 1
        SpecLabel.Font = Enum.Font.GothamMedium; SpecLabel.Text = "No spectators"
        SpecLabel.TextColor3 = Color3.fromRGB(220, 220, 220); SpecLabel.TextSize = 10
        SpecLabel.AutomaticSize = Enum.AutomaticSize.X; SpecLabel.LayoutOrder = 2
        local function setExpanded(state)
            SpecExpanded = state
            if state then
                mainFrame.Size = UDim2.new(0, 145, 0, 52)
                divider.Visible = true; body.Visible = true; minBtn.Text = "−"
            else
                mainFrame.Size = UDim2.new(0, 145, 0, 22)
                divider.Visible = false; body.Visible = false; minBtn.Text = "+"
            end
        end
        minBtn.MouseButton1Click:Connect(function() setExpanded(not SpecExpanded) end)
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
        if not SpecEnabled or not SpecLabel then return end
        local count = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Team and p.Team.Name == "Spectator" then count = count + 1 end
        end
        if count == 0 then
            SpecLabel.Text = "No spectators"; SpecLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        else
            SpecLabel.Text = count .. " spectators"; SpecLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    function W.Spectator_Set(v)
        SpecEnabled = v and true or false
        if SpecThread then task.cancel(SpecThread); SpecThread = nil end
        if v then
            Spec_CreateUI(); Spec_Update()
            SpecThread = task.spawn(function()
                while SpecEnabled do Spec_Update(); task.wait(1.2) end
            end)
        else
            if SpecGui then SpecGui:Destroy(); SpecGui = nil; SpecLabel = nil end
        end
    end
end

--====================================================--
-- SPEED BOOST
--====================================================--
do
    local SpeedBoostConnection = nil
    local function ShouldDisableSpeedBoost()
        local char = LP.Character
        if not char then return true end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
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
        VD.SpeedBoostEnabled = v and true or false
        if SpeedBoostConnection then SpeedBoostConnection:Disconnect(); SpeedBoostConnection = nil end
        if not VD.SpeedBoostEnabled then
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then pcall(function() hum.WalkSpeed = 16 end) end
            return
        end
        SpeedBoostConnection = RunService.Heartbeat:Connect(function()
            if not VD.SpeedBoostEnabled then return end
            if ShouldDisableSpeedBoost() then return end
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= VD.SpeedBoostValue then
                pcall(function() hum.WalkSpeed = VD.SpeedBoostValue end)
            end
        end)
    end
    W.SpeedBoost_SetValue = function(v) VD.SpeedBoostValue = tonumber(v) or 30 end
    LP.CharacterAdded:Connect(function()
        task.wait(0.8)
        if VD.SpeedBoostEnabled then W.SpeedBoost_SetEnabled(true) end
    end)
end

--====================================================--
-- CURSOR FEATURE
--====================================================--
do
    local CursorThread = nil
    local savedOriginal = { MouseIconEnabled = nil, MouseBehavior = nil, AutoRotate = nil }
    function W.Cursor_SetEnabled(v)
        VD.CursorEnabled = v and true or false
        if v then
            savedOriginal.MouseIconEnabled = UserInputService.MouseIconEnabled
            savedOriginal.MouseBehavior = UserInputService.MouseBehavior
            local char = LP.Character
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
                    local c = LP.Character
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
            local c = LP.Character
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
    LP.CharacterAdded:Connect(function()
        task.wait(1)
        if VD.CursorEnabled then W.Cursor_SetEnabled(true) end
    end)
end

--====================================================--
-- SKIP END SCREEN + HIDE NAME + HIDE SURVIVOR ICON
--====================================================--
W.SkipEnd = W.SkipEnd or { Enabled = false }
local function PU_ShowInstantResults()
    if not W.SkipEnd.Enabled then return end
    pcall(function()
        local cam = Workspace.CurrentCamera
        if cam then cam.CameraType = Enum.CameraType.Custom; cam.FieldOfView = 70 end
        UserInputService.MouseIconEnabled = true
        LP:SetAttribute("isspectating", true)
        local pg = LP:FindFirstChild("PlayerGui")
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
            ev.OnClientEvent:Connect(PU_ShowInstantResults)
        end
    end
end)
function W.SkipEnd_Set(v) W.SkipEnd.Enabled = v and true or false end

W.HideName = W.HideName or { Enabled = false, Conn = nil }
local function ProcessHideName(obj)
    if not obj then return end
    local ok, isText = pcall(function()
        return obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")
    end)
    if not ok or not isText then return end
    local txt = ""
    pcall(function() txt = tostring(obj.Text or "") end)
    if txt == "" then return end
    if txt == LP.Name or txt == LP.DisplayName
        or txt:find(LP.Name, 1, true) ~= nil then
        pcall(function() obj.Visible = not W.HideName.Enabled end)
    end
end
function W.HideName_Set(enabled)
    W.HideName.Enabled = enabled and true or false
    if W.HideName.Conn then
        pcall(function() W.HideName.Conn:Disconnect() end)
        W.HideName.Conn = nil
    end
    local pg = LP:FindFirstChildOfClass("PlayerGui")
    if not pg then return end
    for _, d in ipairs(pg:GetDescendants()) do ProcessHideName(d) end
    if W.HideName.Enabled then
        W.HideName.Conn = pg.DescendantAdded:Connect(function(obj)
            task.defer(ProcessHideName, obj)
        end)
    end
end

W.HideIcon = W.HideIcon or { Enabled = false, OrigIcons = {} }
function W.HideIcon_Apply()
    local pg = LP:FindFirstChild("PlayerGui")
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
                            if not W.HideIcon.OrigIcons[il] then
                                W.HideIcon.OrigIcons[il] = { Image = il.Image, ImageTransparency = il.ImageTransparency }
                            end
                            il.Image = "rbxassetid://92826170205694"
                            il.ImageTransparency = 0
                        end
                        if tl and tl:IsA("TextLabel") then
                            if not W.HideIcon.OrigIcons[tl] then
                                W.HideIcon.OrigIcons[tl] = { Text = tl.Text, TextTransparency = tl.TextTransparency }
                            end
                            tl.Text = "ALFzxzz"
                            tl.TextTransparency = 0
                        end
                    end
                end
            end
        end
    end
end
function W.HideIcon_Restore()
    for obj, data in pairs(W.HideIcon.OrigIcons) do
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
    W.HideIcon.OrigIcons = {}
end
RunService.Heartbeat:Connect(function()
    if W.HideIcon.Enabled then W.HideIcon_Apply() end
end)
function W.HideIcon_Set(v)
    W.HideIcon.Enabled = v and true or false
    if v then W.HideIcon_Apply() else W.HideIcon_Restore() end
end--====================================================--
-- TROLL TELEPORT
--====================================================--
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
        VD_Notify("Troll Teleport", "Trigger #" .. TT.TriggerCount .. " | Delay " .. delay .. "s", 2)
        task.spawn(function()
            if track.IsPlaying then pcall(function() track.Stopped:Wait() end) end
            task.wait(delay)
            local c = LP.Character
            local rp = c and c:FindFirstChild("HumanoidRootPart")
            if rp and rp.Parent then pcall(function() rp.CFrame = startCF end) end
            TT.IsProcessing = false
        end)
    end)
end
function W.TrollTeleport_Start()
    if TT.AnimatorHook then return end
    TT.IsProcessing = false
    TT_HookCharacter(LP.Character)
    TT.CharHook = LP.CharacterAdded:Connect(function(c) task.wait(0.4); TT_HookCharacter(c) end)
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

--====================================================--
-- INSTANT ESCAPE
--====================================================--
W.Escape = W.Escape or { Enabled = false, FinishLineName = "fininshline", TeleportCount = 0 }
local Esc = W.Escape
function W.Escape_Teleport()
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not root then ForceNotify("Escape", "Character not found", 2); return false end
    local found = nil
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if string.lower(obj.Name) == string.lower(Esc.FinishLineName) and obj:IsA("BasePart") then
            found = obj; break
        end
    end
    if not found then ForceNotify("Escape", "Finish line not found", 2); return false end
    pcall(function() root.CFrame = found.CFrame + Vector3.new(0, 5, 0) end)
    Esc.TeleportCount = Esc.TeleportCount + 1
    VD_Notify("Instant Escape", "Teleported! (#" .. Esc.TeleportCount .. ")", 2)
    return true
end

--====================================================--
-- FLOATING BUTTON SYSTEM
--====================================================--
local function CreateFloatingButton(cfg)
    local state = cfg.state
    state.Connections = state.Connections or {}
    local function ClearConns()
        for _, c in ipairs(state.Connections) do pcall(function() c:Disconnect() end) end
        state.Connections = {}
    end
    local function DestroyBtn()
        ClearConns()
        if state.Gui then pcall(function() state.Gui:Destroy() end); state.Gui = nil end
    end
    local function UpdateVisual()
        if not state.Gui then return end
        local main = state.Gui:FindFirstChild("MainBtn", true)
        if not main then return end
        local isOn = cfg.isOn()
        local sp = main:FindFirstChild("StatusPill")
        local st = sp and sp:FindFirstChild("StatusText")
        local sd = sp and sp:FindFirstChild("StatusDot")
        local str = main:FindFirstChild("MainStroke")
        local ic = main:FindFirstChild("IconCircle")
        local idot = ic and ic:FindFirstChild("IconDot")
        if isOn then
            TweenService:Create(main, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play()
            if ic then TweenService:Create(ic, TweenInfo.new(0.25), { BackgroundColor3 = _G.GLUTO_ACCENT, BackgroundTransparency = 0.15 }):Play() end
            if idot then TweenService:Create(idot, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play() end
            if sp then TweenService:Create(sp, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play() end
            if st then st.Text = "ON"; TweenService:Create(st, TweenInfo.new(0.25), { TextColor3 = _G.GLUTO_ACCENT }):Play() end
            if sd then TweenService:Create(sd, TweenInfo.new(0.25), { BackgroundColor3 = _G.GLUTO_ACCENT }):Play() end
            if str then TweenService:Create(str, TweenInfo.new(0.25), { Color = Color3.fromRGB(255, 255, 255) }):Play() end
        else
            TweenService:Create(main, TweenInfo.new(0.25), { BackgroundColor3 = _G.GLUTO_BG_OFF }):Play()
            if ic then TweenService:Create(ic, TweenInfo.new(0.25), { BackgroundColor3 = _G.GLUTO_NEUTRAL, BackgroundTransparency = 0.4 }):Play() end
            if idot then TweenService:Create(idot, TweenInfo.new(0.25), { BackgroundColor3 = _G.GLUTO_BG_OFF }):Play() end
            if sp then TweenService:Create(sp, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play() end
            if st then st.Text = "OFF"; TweenService:Create(st, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(120, 120, 120) }):Play() end
            if sd then TweenService:Create(sd, TweenInfo.new(0.25), { BackgroundColor3 = _G.GLUTO_NEUTRAL }):Play() end
            if str then TweenService:Create(str, TweenInfo.new(0.25), { Color = _G.GLUTO_STROKE_OFF }):Play() end
        end
    end
    local function ToggleBtn()
        local s = not cfg.isOn()
        cfg.onToggle(s)
        UpdateVisual()
        if s then VD_Notify(cfg.notifyTitle, "Enabled", 2) end
    end
    local function CreateBtn()
        DestroyBtn()
        local parent = LP:FindFirstChild("PlayerGui")
        if gethui then local ok2, hui = pcall(gethui); if ok2 and hui then parent = hui end end
        if not parent then return end
        local gui = Instance.new("ScreenGui")
        gui.Name = "Gluto" .. cfg.id .. "Btn"; gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = parent
        state.Gui = gui
        local container = Instance.new("Frame")
        container.Name = "Container"
        container.Size = UDim2.fromOffset(180, 40)
        container.Position = state.SavedPos
        container.BackgroundTransparency = 1
        container.Parent = gui
        local main = Instance.new("Frame")
        main.Name = "MainBtn"
        main.Size = UDim2.fromOffset(132, 40)
        main.BackgroundColor3 = _G.GLUTO_BG_OFF
        main.BorderSizePixel = 0; main.ZIndex = 1; main.Parent = container
        Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
        local mainStroke = Instance.new("UIStroke", main)
        mainStroke.Name = "MainStroke"
        mainStroke.Color = _G.GLUTO_STROKE_OFF
        mainStroke.Thickness = 1.2; mainStroke.Transparency = 0.2
        local ic = Instance.new("Frame")
        ic.Name = "IconCircle"
        ic.Size = UDim2.fromOffset(24, 24)
        ic.Position = UDim2.new(0, 8, 0.5, -12)
        ic.BackgroundColor3 = _G.GLUTO_NEUTRAL
        ic.BackgroundTransparency = 0.4
        ic.BorderSizePixel = 0; ic.ZIndex = 2; ic.Parent = main
        Instance.new("UICorner", ic).CornerRadius = UDim.new(1, 0)
        local idot = Instance.new("Frame")
        idot.Name = "IconDot"
        idot.Size = UDim2.fromOffset(10, 10)
        idot.Position = UDim2.new(0.5, -5, 0.5, -5)
        idot.BackgroundColor3 = _G.GLUTO_BG_OFF
        idot.BorderSizePixel = 0; idot.ZIndex = 3
        idot.Rotation = cfg.iconRotation or 0
        idot.Parent = ic
        Instance.new("UICorner", idot).CornerRadius = UDim.new(0, 2)
        local ml = Instance.new("TextLabel")
        ml.Name = "MainLabel"
        ml.Size = UDim2.new(1, -70, 1, 0)
        ml.Position = UDim2.new(0, 38, 0, 0)
        ml.BackgroundTransparency = 1
        ml.Font = Enum.Font.GothamBold
        ml.Text = cfg.title
        ml.TextColor3 = Color3.fromRGB(240, 240, 245)
        ml.TextSize = 13
        ml.TextXAlignment = Enum.TextXAlignment.Left
        ml.ZIndex = 2; ml.Parent = main
        local sp = Instance.new("Frame")
        sp.Name = "StatusPill"
        sp.AnchorPoint = Vector2.new(1, 0.5)
        sp.Size = UDim2.fromOffset(42, 20)
        sp.Position = UDim2.new(1, -8, 0.5, 0)
        sp.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        sp.BorderSizePixel = 0; sp.ZIndex = 2; sp.Parent = main
        Instance.new("UICorner", sp).CornerRadius = UDim.new(1, 0)
        local sd = Instance.new("Frame")
        sd.Name = "StatusDot"
        sd.Size = UDim2.fromOffset(6, 6)
        sd.Position = UDim2.new(0, 7, 0.5, -3)
        sd.BackgroundColor3 = _G.GLUTO_NEUTRAL
        sd.BorderSizePixel = 0; sd.ZIndex = 3; sd.Parent = sp
        Instance.new("UICorner", sd).CornerRadius = UDim.new(1, 0)
        local st = Instance.new("TextLabel")
        st.Name = "StatusText"
        st.Size = UDim2.new(1, -18, 1, 0)
        st.Position = UDim2.new(0, 16, 0, 0)
        st.BackgroundTransparency = 1
        st.Font = Enum.Font.GothamBold
        st.Text = "OFF"
        st.TextColor3 = Color3.fromRGB(140, 140, 152)
        st.TextSize = 10
        st.TextXAlignment = Enum.TextXAlignment.Center
        st.ZIndex = 3; st.Parent = sp
        local lock = Instance.new("TextButton")
        lock.Name = "LockBtn"
        lock.Size = UDim2.fromOffset(40, 40)
        lock.Position = UDim2.new(1, -44, 0, 0)
        lock.BackgroundColor3 = _G.GLUTO_BG_OFF
        lock.BorderSizePixel = 0; lock.Text = ""
        lock.AutoButtonColor = false; lock.ZIndex = 1; lock.Parent = container
        Instance.new("UICorner", lock).CornerRadius = UDim.new(0, 12)
        local ls = Instance.new("UIStroke", lock)
        ls.Color = _G.GLUTO_STROKE_OFF
        ls.Thickness = 1.2; ls.Transparency = 0.2
        ls.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local li = Instance.new("TextLabel")
        li.Name = "LockIcon"
        li.Size = UDim2.fromScale(1, 1)
        li.BackgroundTransparency = 1
        li.Font = Enum.Font.GothamBold
        li.Text = "🔓"
        li.TextColor3 = Color3.fromRGB(180, 180, 190)
        li.TextSize = 16; li.ZIndex = 2; li.Parent = lock
        local function UpdateLockVisual()
            if state.DragLocked then
                li.Text = "🔒"
                TweenService:Create(ls, TweenInfo.new(0.2), { Color = _G.GLUTO_ACCENT, Transparency = 0, Thickness = 1.5 }):Play()
                TweenService:Create(lock, TweenInfo.new(0.2), { BackgroundColor3 = _G.GLUTO_ACCENT_BG }):Play()
                TweenService:Create(li, TweenInfo.new(0.2), { TextColor3 = _G.GLUTO_ACCENT }):Play()
            else
                li.Text = "🔓"
                TweenService:Create(ls, TweenInfo.new(0.2), { Color = _G.GLUTO_STROKE_OFF, Transparency = 0.2, Thickness = 1.2 }):Play()
                TweenService:Create(lock, TweenInfo.new(0.2), { BackgroundColor3 = _G.GLUTO_BG_OFF }):Play()
                TweenService:Create(li, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(180, 180, 190) }):Play()
            end
        end
        local cd = Instance.new("TextButton")
        cd.Name = "ClickDetect"
        cd.Size = UDim2.fromScale(1, 1)
        cd.BackgroundTransparency = 1; cd.Text = ""
        cd.AutoButtonColor = false; cd.ZIndex = 5; cd.Parent = main
        local drag = false
        local dStart, sPos
        local dDist = 0
        table.insert(state.Connections, cd.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dStart = inp.Position; sPos = container.Position; dDist = 0
                if not state.DragLocked then drag = true end
            end
        end))
        table.insert(state.Connections, cd.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                if drag then drag = false; state.SavedPos = container.Position end
                if dDist < 8 then ToggleBtn() end
            end
        end))
        table.insert(state.Connections, UserInputService.InputChanged:Connect(function(inp)
            if not drag then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                local d = inp.Position - dStart
                dDist = math.abs(d.X) + math.abs(d.Y)
                container.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
            end
        end))
        table.insert(state.Connections, lock.MouseButton1Click:Connect(function()
            state.DragLocked = not state.DragLocked
            if state.DragLocked then drag = false end
            UpdateLockVisual()
            VD_Notify(cfg.notifyTitle .. " Button", state.DragLocked and "Locked" or "Unlocked", 1)
        end))
        UpdateVisual(); UpdateLockVisual()
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
W.CreateFloatingButton = CreateFloatingButton

-- 9 Floating Buttons
local SelfHealBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.28,0), Connections={} }
local SelfHealState = CreateFloatingButton({
    id="SelfHeal", title="Heal", notifyTitle="Self Heal", state=SelfHealBtnState,
    isOn=function() return W.InstantHealSelf end,
    onToggle=function(v) W.setInstantHealSelf(v) end,
    iconRotation=0,
})
getgenv().Gluto_SHB_SetEnabled = function(en) SelfHealState.SetEnabled(en) end
getgenv().Gluto_SHB_UpdateVisual = function() SelfHealState.UpdateVisual() end

local SelfUnhookBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.35,0), Connections={} }
local SelfUnhookState = CreateFloatingButton({
    id="SelfUnhook", title="Hook", notifyTitle="Self Unhook", state=SelfUnhookBtnState,
    isOn=function() return W.SelfUnhook.Enabled end,
    onToggle=function(v) W.SU_SetEnabled(v) end,
    iconRotation=135,
})
getgenv().Gluto_SUB_SetEnabled = function(en) SelfUnhookState.SetEnabled(en) end
getgenv().Gluto_SUB_UpdateVisual = function() SelfUnhookState.UpdateVisual() end

local TrollBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.42,0), Connections={} }
local TrollState = CreateFloatingButton({
    id="TrollTP", title="T_TP", notifyTitle="Troll Teleport", state=TrollBtnState,
    isOn=function() return W.TrollTeleport.Enabled end,
    onToggle=function(v) W.TrollTeleport_SetEnabled(v) end,
    iconRotation=225,
})
getgenv().Gluto_TTB_SetEnabled = function(en) TrollState.SetEnabled(en) end
getgenv().Gluto_TTB_UpdateVisual = function() TrollState.UpdateVisual() end

local EscapeBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.49,0), Connections={} }
local EscapeState = CreateFloatingButton({
    id="Escape", title="Escape", notifyTitle="Instant Escape", state=EscapeBtnState,
    isOn=function() return W.Escape.Enabled end,
    onToggle=function(v) W.Escape.Enabled = v; if v then W.Escape_Teleport() end end,
    iconRotation=45,
})
getgenv().Gluto_Escape_SetEnabled = function(en) EscapeState.SetEnabled(en) end
getgenv().Gluto_Escape_UpdateVisual = function() EscapeState.UpdateVisual() end

local ParryBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.56,0), Connections={} }
local ParryStateBtn = CreateFloatingButton({
    id="Parry", title="Parry", notifyTitle="Parry", state=ParryBtnState,
    isOn=function() return VD.PARRY_Enabled end,
    onToggle=function(v)
        VD.PARRY_Enabled = v
        if not v then W._ParryState.ActiveAttackers = {} end
    end,
    iconRotation=45,
})
getgenv().Gluto_ParryBtn_SetEnabled = function(en) ParryStateBtn.SetEnabled(en) end
getgenv().Gluto_ParryBtn_UpdateVisual = function() ParryStateBtn.UpdateVisual() end

local InvisBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.63,0), Connections={} }
local InvisStateBtn = CreateFloatingButton({
    id="Invisible", title="Invis", notifyTitle="invisibility", state=InvisBtnState,
    isOn=function()
        local MV = getgenv().GlutoInvis
        return MV and MV.Enabled or false
    end,
    onToggle=function(v) W.Invisible_SetState(v, true) end,
    iconRotation=180,
})
getgenv().Gluto_InvisBtn_SetEnabled   = function(en) InvisStateBtn.SetEnabled(en) end
getgenv().Gluto_InvisBtn_UpdateVisual = function() InvisStateBtn.UpdateVisual() end

local MyersGrabBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.70,0), Connections={} }
local MyersGrabBtn = CreateFloatingButton({
    id="MyersGrab", title="Grab", notifyTitle="Myers Grab", state=MyersGrabBtnState,
    isOn=function() return W.MyersGrabData.Enabled end,
    onToggle=function(v) W.setMyersGrab(v) end,
    iconRotation=90,
})
getgenv().Gluto_MGrabBtn_SetEnabled   = function(en) MyersGrabBtn.SetEnabled(en) end
getgenv().Gluto_MGrabBtn_UpdateVisual = function() MyersGrabBtn.UpdateVisual() end

local VeilBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.77,0), Connections={} }
local VeilBtn = CreateFloatingButton({
    id="SilentVeil", title="Veil", notifyTitle="Silent Veil", state=VeilBtnState,
    isOn=function() return VD.VeilEnabled end,
    onToggle=function(v)
        VD.VeilEnabled = v
        if not v then VD_Notify("Silent Veil", "Disabled", 2)
        else VD_Notify("Silent Veil", "Enabled", 2) end
    end,
    iconRotation=0,
})
getgenv().Gluto_VeilBtn_SetEnabled   = function(en) VeilBtn.SetEnabled(en) end
getgenv().Gluto_VeilBtn_UpdateVisual = function() VeilBtn.UpdateVisual() end

-- Moonwalk Button
local MoonwalkBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.84,0), Connections={} }
local MoonwalkFloatingState = CreateFloatingButton({
    id = "Moonwalk", title = "Moon", notifyTitle = "Moonwalk", state = MoonwalkBtnState,
    isOn = function() return W.Moonwalk_IsOn and W.Moonwalk_IsOn() or false end,
    onToggle = function(v) W.Moonwalk_Set(v) end, iconRotation = 0,
})
getgenv().Gluto_MoonwalkBtn_SetEnabled   = function(en) MoonwalkFloatingState.SetEnabled(en) end
getgenv().Gluto_MoonwalkBtn_UpdateVisual = function() MoonwalkFloatingState.UpdateVisual() end--====================================================--
-- UI: SURVIVOR TAB
--====================================================--
do
    -- ===== INSTANT ESCAPE =====
    local escSection = SurvivorTab:AddLeftGroupbox("Instant Escape", "door-open")
    escSection:AddToggle(UID("escBtn"), {
        Text = "Enable Escape Button",
        Default = false,
        Callback = function(v)
            if getgenv().Gluto_Escape_SetEnabled then getgenv().Gluto_Escape_SetEnabled(v) end
            if v then VD_Notify("Escape Button", "Shown", 2) end
        end
    })
    escSection:AddButton({
        Text = "Teleport Now",
        Func = function() W.Escape_Teleport() end
    })

    -- ===== SELF HEAL =====
    local healSection = SurvivorTab:AddRightGroupbox("Self Heal", "heart")
    healSection:AddToggle(UID("healProg"), {
        Text = "Self Heal Progress",
        Default = false,
        Callback = function(v)
            W.setInstantHealSelf(v)
            if getgenv().Gluto_SHB_UpdateVisual then getgenv().Gluto_SHB_UpdateVisual() end
            if v then VD_Notify("Self Heal", "Enabled", 2) end
        end
    })
    healSection:AddToggle(UID("healAll"), {
        Text = "Auto Heal All",
        Default = false,
        Callback = function(v)
            W.setAutoHealAll(v)
            if v then VD_Notify("Auto Heal All", "Enabled", 2) end
        end
    })
    healSection:AddToggle(UID("healBtn"), {
        Text = "Show Self Heal Button",
        Default = false,
        Callback = function(v)
            if getgenv().Gluto_SHB_SetEnabled then getgenv().Gluto_SHB_SetEnabled(v) end
        end
    })

    -- ===== GOD MODE =====
    local GodSection = SurvivorTab:AddLeftGroupbox("God Mode", "shield-check")
    local GodEnabled = false
    local GodThread = nil
    GodSection:AddToggle(UID("godMode"), {
        Text = "God Mode (Auto Heal)",
        Default = false,
        Callback = function(v)
            GodEnabled = v
            if v then
                if GodThread then task.cancel(GodThread) end
                GodThread = task.spawn(function()
                    while GodEnabled do
                        local c = LP.Character
                        local h = c and c:FindFirstChildOfClass("Humanoid")
                        if h and h.Health > 0 and h.Health < h.MaxHealth then
                            pcall(function() h.Health = h.MaxHealth end)
                        end
                        task.wait(0.1)
                    end
                    GodThread = nil
                end)
                VD_Notify("God Mode", "Enabled", 2)
            else
                if GodThread then task.cancel(GodThread); GodThread = nil end
                VD_Notify("God Mode", "Disabled", 2)
            end
        end
    })

    -- ===== AUTO CROUCH =====
    local AutoCrouchSection = SurvivorTab:AddRightGroupbox("Auto Crouch Dodge", "footprints")
    AutoCrouchSection:AddToggle(UID("autoCrouch"), {
        Text = "Enable Auto Crouch Dodge",
        Default = VD.AutoCrouch,
        Callback = function(v)
            VD.AutoCrouch = v
            VD_Notify("Auto Crouch Dodge", v and "Enabled" or "Disabled", 2)
        end
    })

    -- ===== VAULT =====
    local VaultSection = SurvivorTab:AddLeftGroupbox("Vault", "door-closed")
    local UVaultEnabled = false
    local UVaultConn = nil
    VaultSection:AddToggle(UID("unlimVault"), {
        Text = "Unlimited Vault",
        Default = false,
        Callback = function(state)
            if state then
                UVaultEnabled = true
                for _, v in ipairs(CollectionService:GetTagged("Blocked")) do
                    CollectionService:RemoveTag(v, "Blocked")
                end
                if UVaultConn then UVaultConn:Disconnect() end
                UVaultConn = CollectionService:GetInstanceAddedSignal("Blocked"):Connect(function(inst)
                    CollectionService:RemoveTag(inst, "Blocked")
                end)
            else
                UVaultEnabled = false
                if UVaultConn then UVaultConn:Disconnect(); UVaultConn = nil end
            end
            VD_Notify("Unlimited Vault", state and "Enabled" or "Disabled", 2)
        end
    })
    local ASVaultEnabled = false
    local ASVaultConn = nil
    VaultSection:AddToggle(UID("antiSlowVault"), {
        Text = "Anti Slow Vault",
        Default = false,
        Callback = function(state)
            if state then
                ASVaultEnabled = true
                for _, v in ipairs(CollectionService:GetTagged("SlowVault")) do
                    CollectionService:RemoveTag(v, "SlowVault")
                end
                if ASVaultConn then ASVaultConn:Disconnect() end
                ASVaultConn = CollectionService:GetInstanceAddedSignal("SlowVault"):Connect(function(inst)
                    CollectionService:RemoveTag(inst, "SlowVault")
                end)
            else
                ASVaultEnabled = false
                if ASVaultConn then ASVaultConn:Disconnect(); ASVaultConn = nil end
            end
            VD_Notify("Anti Slow Vault", state and "Enabled" or "Disabled", 2)
        end
    })

    -- ===== PALLET REFLEX =====
    local PalletSection = SurvivorTab:AddRightGroupbox("Pallet Reflex", "hand")
    PalletSection:AddToggle(UID("palletReflex"), {
        Text = "Enable Pallet Reflex",
        Default = VD.SURV_AutoPallet,
        Callback = function(v)
            W.PalletReflex_SetEnabled(v)
            VD_Notify("Pallet Reflex", v and "Enabled" or "Disabled", 2)
        end
    })
    PalletSection:AddSlider(UID("palletDist"), {
        Text = "Trigger Distance",
        Min = 5, Max = 50, Default = VD.SURV_AutoPalletDist, Rounding = 1, Suffix = " studs",
        Callback = function(v) W.PalletReflex_SetDistance(v) end
    })

    -- ===== SWIFT VAULT =====
    local SwiftVaultSection = SurvivorTab:AddLeftGroupbox("Swift Vault", "move-right")
    SwiftVaultSection:AddToggle(UID("swiftVault"), {
        Text = "Swift Vault (Auto)",
        Default = VD.SURV_AutoVault,
        Callback = function(v)
            W.SwiftVault_SetEnabled(v)
            VD_Notify("Swift Vault", v and "Enabled" or "Disabled", 2)
        end
    })
    SwiftVaultSection:AddToggle(UID("swiftVaultV2"), {
        Text = "Swift Vault V2 (Custom Speed)",
        Default = VD.SURV_FastVault,
        Callback = function(v)
            W.SwiftVaultV2_SetEnabled(v)
            VD_Notify("Swift Vault V2", v and "Enabled" or "Disabled", 2)
        end
    })
    SwiftVaultSection:AddSlider(UID("vaultSpeed"), {
        Text = "Vault Speed",
        Min = 10, Max = 20, Default = VD.SURF_VaultSpeed, Rounding = 1,
        Callback = function(v) W.SwiftVault_SetSpeed(v) end
    })

    -- ===== AUTO FLEE =====
    local FleeSection = SurvivorTab:AddRightGroupbox("Auto Flee Killer", "footprints")
    FleeSection:AddToggle(UID("autoFlee"), {
        Text = "Enable Auto Flee",
        Default = VD.SURV_AutoFlee,
        Callback = function(v)
            VD.SURV_AutoFlee = v
            VD_Notify("Auto Flee", v and "Enabled" or "Disabled", 2)
        end
    })
    FleeSection:AddSlider(UID("fleeDist"), {
        Text = "Detect Distance",
        Min = 15, Max = 150, Default = VD.SURV_AutoFleeDist, Rounding = 1, Suffix = " studs",
        Callback = function(v) VD.SURV_AutoFleeDist = v end
    })
    FleeSection:AddSlider(UID("fleeCD"), {
        Text = "Flee Cooldown",
        Min = 0.5, Max = 10, Default = VD.SURV_AutoFleeCooldown, Rounding = 0.5, Suffix = "s",
        Callback = function(v) VD.SURV_AutoFleeCooldown = v end
    })

    -- ===== AUTO RUN =====
    local AutoRunSection = SurvivorTab:AddLeftGroupbox("Auto Run", "person-standing")
    local ARPC, ARMobile = false, false
    local ARPCThread, ARMobileThread = nil, nil
    AutoRunSection:AddToggle(UID("arPC"), {
        Text = "Auto Run [PC]",
        Default = false,
        Callback = function(v)
            ARPC = v
            if v then
                if ARPCThread then task.cancel(ARPCThread) end
                ARPCThread = task.spawn(function()
                    while ARPC do
                        pcall(function()
                            if VirtualInputManager then
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, LP:GetMouse())
                            end
                        end)
                        task.wait(0.1)
                    end
                    pcall(function()
                        if VirtualInputManager then VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LP:GetMouse()) end
                    end)
                    ARPCThread = nil
                end)
            else
                if ARPCThread then task.cancel(ARPCThread); ARPCThread = nil end
            end
            VD_Notify("Auto Run PC", v and "Enabled" or "Disabled", 2)
        end
    })
    AutoRunSection:AddToggle(UID("arMob"), {
        Text = "Auto Run [Mobile]",
        Default = false,
        Callback = function(v)
            ARMobile = v
            if v then
                if ARMobileThread then task.cancel(ARMobileThread) end
                ARMobileThread = task.spawn(function()
                    while ARMobile do
                        local char = LP.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        if hum and hum.MoveDirection.Magnitude > 0.12 then
                            local pg = LP:FindFirstChild("PlayerGui")
                            local sm = pg and pg:FindFirstChild("Survivor-mob")
                            local ct = sm and sm:FindFirstChild("Controls")
                            local sp = ct and ct:FindFirstChild("sprint")
                            if sp and type(firesignal) == "function" then
                                pcall(function() firesignal(sp.MouseButton1Click) end)
                            end
                        end
                        task.wait(0.12)
                    end
                    ARMobileThread = nil
                end)
                VD_Notify("Auto Run Mobile", "Enabled", 2)
            else
                if ARMobileThread then task.cancel(ARMobileThread); ARMobileThread = nil end
                VD_Notify("Auto Run Mobile", "Disabled", 2)
            end
        end
    })

    -- ===== MOONWALK (Survivor Tab) =====
    local MWalkSec = SurvivorTab:AddRightGroupbox("Moonwalk", "footprints")
    MWalkSec:AddToggle(UID("moonwalk"), {
        Text = "Moonwalk (F8)",
        Default = false,
        Callback = function(v)
            W.Moonwalk_Set(v)
            if getgenv().Gluto_MoonwalkBtn_UpdateVisual then getgenv().Gluto_MoonwalkBtn_UpdateVisual() end
            VD_Notify("Moonwalk", v and "Enabled" or "Disabled", 2)
        end
    })
    MWalkSec:AddSlider(UID("mwSide"), {
        Text = "Side Speed", Min = 0.1, Max = 3, Default = 0.9, Rounding = 0.1,
        Callback = function(v) W.Moonwalk_SetSide(v) end
    })
    MWalkSec:AddSlider(UID("mwBack"), {
        Text = "Back Speed", Min = 0.1, Max = 3, Default = 1.2, Rounding = 0.1,
        Callback = function(v) W.Moonwalk_SetBack(v) end
    })
    MWalkSec:AddSlider(UID("mwInt"), {
        Text = "Switch Interval", Min = 0.02, Max = 0.5, Default = 0.07, Rounding = 0.01,
        Callback = function(v) W.Moonwalk_SetInterval(v) end
    })

    -- ===== NO FALL =====
    local FallSec = SurvivorTab:AddLeftGroupbox("Anti Fall Damage", "arrow-down")
    FallSec:AddToggle(UID("noFall"), {
        Text = "Enable No Fall Damage",
        Default = false,
        Callback = function(v)
            VD.NoFallDamage = v
            VD_Notify("No Fall Damage", v and "Enabled" or "Disabled", 2)
        end
    })

    -- ===== MAP PREDICT =====
    local MapPredSec = SurvivorTab:AddRightGroupbox("Next Map", "map")
    MapPredSec:AddToggle(UID("mapPred"), {
        Text = "Enable Map Prediction",
        Default = false,
        Callback = function(v)
            if W.NextMapPredict_SetEnabled then W.NextMapPredict_SetEnabled(v) end
            VD_Notify("Map Prediction", v and "Enabled" or "Disabled", 2)
        end
    })

    -- ===== TROLL TELEPORT (Survivor Tab) =====
    local TrollSec = SurvivorTab:AddLeftGroupbox("Troll Teleport", "skull")
    TrollSec:AddToggle(UID("trollTP"), {
        Text = "Enable Troll Teleport",
        Default = false,
        Callback = function(v)
            W.TrollTeleport_SetEnabled(v)
            if getgenv().Gluto_TTB_UpdateVisual then getgenv().Gluto_TTB_UpdateVisual() end
            if v then VD_Notify("Troll Teleport", "Enabled", 2) end
        end
    })
    TrollSec:AddToggle(UID("trollBtn"), {
        Text = "Show Troll TP Button",
        Default = false,
        Callback = function(v)
            if getgenv().Gluto_TTB_SetEnabled then getgenv().Gluto_TTB_SetEnabled(v) end
        end
    })

    -- ===== KILLER PERKS DISPLAY =====
    local KPerksSec = SurvivorTab:AddRightGroupbox("Killer Perks", "eye")
    KPerksSec:AddToggle(UID("kPerks"), {
        Text = "Enable Killer Perks Display",
        Default = false,
        Callback = function(v)
            if W.KillerPerksDisplay_SetEnabled then W.KillerPerksDisplay_SetEnabled(v) end
            VD_Notify("Killer Perks Display", v and "Enabled" or "Disabled", 2)
        end
    })
end

--====================================================--
-- UI: PARRY TAB
--====================================================--
do
    local ParrySection = ParryTab:AddLeftGroupbox("Auto Parry V1", "shield")
    ParrySection:AddToggle(UID("parryV1"), {
        Text = "Enable Auto Parry",
        Default = VD.PARRY_Enabled,
        Callback = function(v)
            VD.PARRY_Enabled = v
            if not v then W._ParryState.ActiveAttackers = {} end
            if getgenv().Gluto_ParryBtn_UpdateVisual then getgenv().Gluto_ParryBtn_UpdateVisual() end
            if v then VD_Notify("Auto Parry", "Enabled", 2) end
        end
    })
    ParrySection:AddToggle(UID("parryBtnShow"), {
        Text = "Show Parry Button",
        Default = false,
        Callback = function(v)
            VD.PARRY_ShowFloatBtn = v
            if getgenv().Gluto_ParryBtn_SetEnabled then getgenv().Gluto_ParryBtn_SetEnabled(v) end
        end
    })
    ParrySection:AddToggle(UID("parryAggr"), {
        Text = "Auto Parry Aggressive",
        Default = VD.PARRY_Aggressive,
        Callback = function(v) VD.PARRY_Aggressive = v end
    })
    ParrySection:AddSlider(UID("parryDist"), {
        Text = "Parry Distance",
        Min = 4, Max = 30, Default = VD.PARRY_Distance, Rounding = 1,
        Callback = function(v) VD.PARRY_Distance = v end
    })
    ParrySection:AddToggle(UID("parryCircle"), {
        Text = "Show Parry Range",
        Default = VD.PARRY_ShowCircle,
        Callback = function(v)
            VD.PARRY_ShowCircle = v
            if not v and getgenv()._Gluto_DestroyParryCircle then
                pcall(getgenv()._Gluto_DestroyParryCircle)
            end
        end
    })
    ParrySection:AddToggle(UID("silentParry"), {
        Text = "Silent Parry (Legit)",
        Default = VD.PARRY_SilentParry,
        Callback = function(v) VD.PARRY_SilentParry = v end
    })

    -- ===== AUTO PARRY V2 (Wisnu) =====
    local WisnuSection = ParryTab:AddRightGroupbox("Auto Parry V2", "shield-check")
    WisnuSection:AddToggle(UID("wisnuParry"), {
        Text = "Enable Auto Parry V2",
        Default = VD.Wisnu_AutoParry,
        Callback = function(v)
            VD.Wisnu_AutoParry = v
            VD_Notify("Auto Parry V2", v and "Enabled" or "Disabled", 2)
        end
    })
    WisnuSection:AddToggle(UID("wisnuAggr"), {
        Text = "Aggressive Mode",
        Default = VD.Wisnu_ParryAggressive,
        Callback = function(v) VD.Wisnu_ParryAggressive = v end
    })
    WisnuSection:AddToggle(UID("wisnuSafety"), {
        Text = "Safety Parry",
        Default = VD.Wisnu_ParrySafety,
        Callback = function(v) VD.Wisnu_ParrySafety = v end
    })
    WisnuSection:AddSlider(UID("wisnuDist"), {
        Text = "Parry Distance",
        Min = 4, Max = 25, Default = VD.Wisnu_ParryDistance, Rounding = 1, Suffix = " studs",
        Callback = function(v) VD.Wisnu_ParryDistance = v end
    })
    WisnuSection:AddSlider(UID("wisnuFace"), {
        Text = "Face Sensitivity",
        Min = -1, Max = 1, Default = VD.Wisnu_ParryFace, Rounding = 0.05,
        Callback = function(v) VD.Wisnu_ParryFace = v end
    })
    WisnuSection:AddToggle(UID("wisnuCircle"), {
        Text = "Wisnu Show Circle",
        Default = VD.Wisnu_ParryCircle,
        Callback = function(v) VD.Wisnu_ParryCircle = v end
    })

    -- ===== FAKE PARRY =====
    local FakeParrySection = ParryTab:AddLeftGroupbox("Fake Parry", "ghost")
    FakeParrySection:AddToggle(UID("fakeParry"), {
        Text = "Enable Fake Parry",
        Default = false,
        Callback = function(v)
            W.FakeParry_SetEnabled(v)
            if v then VD_Notify("Fake Parry", "Enabled — press " .. (VD.SURV_FakeParryKey or "V"), 2)
            else VD_Notify("Fake Parry", "Disabled", 2) end
        end
    })
    FakeParrySection:AddDropdown(UID("fakeParryAnim"), {
        Text = "Animation",
        Values = { "Enten", "Stopwatch", "Fih", "BloodShield" },
        Default = VD.SURV_FakeParryAnim or "Enten",
        Multi = false,
        Callback = function(v)
            local val = type(v) == "table" and (v[1] or next(v)) or v
            if val then
                W.FakeParry_SetAnim(val)
                VD_Notify("Fake Parry", "Anim: " .. tostring(val), 2)
            end
        end
    })
    FakeParrySection:AddInput(UID("fakeParryKey"), {
        Text = "Keybind",
        Default = VD.SURV_FakeParryKey or "V",
        Placeholder = "V / G / F / X / B",
        Callback = function(input)
            input = tostring(input or ""):gsub("%s+", "")
            if input == "" then return end
            if W.FakeParry_SetKeybind(input) then
                VD_Notify("Fake Parry", "Keybind: " .. input:upper(), 2)
            else ForceNotify("Fake Parry", "Key invalid: " .. input, 2) end
        end
    })
    FakeParrySection:AddSlider(UID("fakeParryCD"), {
        Text = "Cooldown",
        Min = 0, Max = 3, Default = VD.SURV_FakeParryCooldown or 0.4, Rounding = 0.1, Suffix = "s",
        Callback = function(v) VD.SURV_FakeParryCooldown = v end
    })
    FakeParrySection:AddToggle(UID("fakeParryBtn"), {
        Text = "Show Floating Button",
        Default = false,
        Callback = function(v) W.FakeParry_SetShowButton(v) end
    })
    FakeParrySection:AddButton({
        Text = "Test Fake Parry",
        Func = function()
            W.FakeParry_Trigger()
            ForceNotify("Fake Parry", "Playing...", 2)
        end
    })

    -- ===== FAKE PERKS =====
    local FPBox = ParryTab:AddRightGroupbox("Fake Perks", "sparkles")
    FPBox:AddToggle(UID("fpFlow"), {
        Text = "Flowstate (Vault/Slide)",
        Default = false,
        Callback = function(v)
            W.FP_SetupFlowstate(v)
            if v then VD_Notify("Fake Perks", "Flowstate ON", 2) end
        end
    })
    FPBox:AddToggle(UID("fpQuick"), {
        Text = "Quick Recovery",
        Default = false,
        Callback = function(v)
            W.FP_SetupQuickRecovery(v)
            if v then VD_Notify("Fake Perks", "Quick Recovery ON", 2) end
        end
    })
    FPBox:AddToggle(UID("fpLand"), {
        Text = "Perfect Landing",
        Default = false,
        Callback = function(v)
            W.FP_SetupPerfectLanding(v)
            if v then VD_Notify("Fake Perks", "Perfect Landing ON", 2) end
        end
    })
    FPBox:AddToggle(UID("fpAdren"), {
        Text = "Adrenaline Rush",
        Default = false,
        Callback = function(v)
            W.FP_SetupAdrenalineRush(v)
            if v then VD_Notify("Fake Perks", "Adrenaline Rush ON", 2) end
        end
    })
    FPBox:AddSlider(UID("fpCD"), {
        Text = "Perk Cooldown",
        Min = 0, Max = 30, Default = 5, Rounding = 1, Suffix = "s",
        Callback = function(v) W.FP.CooldownTime = v end
    })
    FPBox:AddButton({
        Text = "Clear All Buffs",
        Func = function()
            for k in pairs(W.FP.ActiveBuffs) do W.FP.ActiveBuffs[k] = nil end
            local c = LP.Character
            if c then c:SetAttribute("speedboost", 1) end
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = 16 end
            ForceNotify("Fake Perks", "Cleared", 2)
        end
    })
end

--====================================================--
-- UI: GEN TAB
--====================================================--
do
    local SKillSec = GenTab:AddLeftGroupbox("Auto Skill Check", "zap")
    SKillSec:AddToggle(UID("skillCheck"), {
        Text = "Enable Auto Skill Check",
        Default = false,
        Callback = function(v)
            W.SkillCheck_SetEnabled(v)
            if v then VD_Notify("Auto Skill Check", "Enabled", 2) end
        end
    })
    SKillSec:AddDropdown(UID("skillMode"), {
        Text = "Mode",
        Values = { "Legit", "Instant" },
        Default = "Legit",
        Multi = false,
        Callback = function(v)
            local val = type(v) == "table" and (v[1] or next(v)) or v
            if val then W.SkillCheck.Mode = val end
        end
    })

    local GenBypassSec = GenTab:AddRightGroupbox("Bypass Generator", "wrench")
    GenBypassSec:AddToggle(UID("genBypass"), {
        Text = "Enable Bypass Generator",
        Default = false,
        Callback = function(v)
            W.setGenBypass(v)
            if v then VD_Notify("Bypass Gen", "Enabled (Hotkey: B)", 3) end
        end
    })
    GenBypassSec:AddSlider(UID("genRange"), {
        Text = "Trigger Range",
        Min = 3, Max = 20, Default = 8, Rounding = 1, Suffix = " studs",
        Callback = function(v) W.GenBypass.TriggerRange = v end
    })
    GenBypassSec:AddButton({
        Text = "Force Repair Nearest",
        Func = function()
            local bp, bd = W.GB_GetNearestPoint()
            if bp and bd <= W.GenBypass.TriggerRange then
                W.GB_DoRepair(bp); ForceNotify("Bypass Gen", "Forcing...", 2)
            else ForceNotify("Bypass Gen", "Terlalu jauh", 2) end
        end
    })

    local ManGenSec = GenTab:AddLeftGroupbox("Manual Generator", "hammer")
    ManGenSec:AddToggle(UID("manGen"), {
        Text = "Enable Manual Generator",
        Default = false,
        Callback = function(v)
            if W.ManualGen_SetEnabled then W.ManualGen_SetEnabled(v) end
            VD_Notify("Manual Gen", v and "Enabled" or "Disabled", 2)
        end
    })
    ManGenSec:AddSlider(UID("escapeDist"), {
        Text = "Killer Escape Distance",
        Min = 10, Max = 80, Default = 30, Rounding = 5, Suffix = " studs",
        Callback = function(v) if W.GenAuto_SetDistance then W.GenAuto_SetDistance(v) end end
    })

    local AutoGenSec = GenTab:AddRightGroupbox("Auto Generator", "bot")
    AutoGenSec:AddToggle(UID("autoGen"), {
        Text = "Enable Auto Generator",
        Default = false,
        Callback = function(v)
            if W.AutoGen_SetEnabled then W.AutoGen_SetEnabled(v) end
            VD_Notify("Auto Gen", v and "Enabled" or "Disabled", 2)
        end
    })

    local SelfUnhookSec = GenTab:AddLeftGroupbox("Self Unhook", "unlink")
    SelfUnhookSec:AddToggle(UID("selfUnhook"), {
        Text = "Enable Bypass Self Unhook",
        Default = false,
        Callback = function(v)
            W.SU_SetEnabled(v)
            if getgenv().Gluto_SUB_UpdateVisual then getgenv().Gluto_SUB_UpdateVisual() end
            if v then VD_Notify("Self Unhook", "Enabled", 2) end
        end
    })
    SelfUnhookSec:AddToggle(UID("selfUnhookBtn"), {
        Text = "Show Self Unhook Button",
        Default = false,
        Callback = function(v)
            if getgenv().Gluto_SUB_SetEnabled then getgenv().Gluto_SUB_SetEnabled(v) end
        end
    })
    SelfUnhookSec:AddSlider(UID("unhookDur"), {
        Text = "Follow Duration",
        Min = 5, Max = 120, Default = 30, Rounding = 5, Suffix = "s",
        Callback = function(v) W.SelfUnhook.FollowDuration = v end
    })
    SelfUnhookSec:AddSlider(UID("unhookDist"), {
        Text = "Follow Distance",
        Min = 5, Max = 60, Default = 20, Rounding = 1, Suffix = " studs",
        Callback = function(v) W.SelfUnhook.FollowDistance = v end
    })
end

--====================================================--
-- UI: SURV UTIL TAB
--====================================================--
do
    local TOFSec = SurvUtilTab:AddLeftGroupbox("Silent Aim TOF", "target")
    TOFSec:AddToggle(UID("tofAim"), {
        Text = "Enable Silent Aim",
        Default = VD.TOF_SilentAim,
        Callback = function(v)
            W.SetToFEnabled(v)
            if v then VD_Notify("Silent Aim TOF", "Enabled", 2) end
        end
    })
    TOFSec:AddDropdown(UID("tofTarget"), {
        Text = "Target Mode",
        Values = { "Killer", "Survivors", "Zombie" },
        Default = "Killer",
        Multi = false,
        Callback = function(v)
            local val = type(v) == "table" and (v[1] or next(v)) or v
            if val then W.ToF_SetTargetMode(val, true) end
        end
    })
    TOFSec:AddToggle(UID("tofLaser"), {
        Text = "Show Laser Beam",
        Default = true,
        Callback = function(v)
            VD.TOF_Laser = v
            if not v and W.ToF_ClearLaser then W.ToF_ClearLaser() end
        end
    })
    TOFSec:AddToggle(UID("tofWall"), {
        Text = "Wall Check",
        Default = true,
        Callback = function(v) VD.TOF_WallCheck = v end
    })
    TOFSec:AddToggle(UID("tofBlock"), {
        Text = "Block When Knocked",
        Default = true,
        Callback = function(v) VD.TOF_BlockKnocked = v end
    })

    local FlashSec = SurvUtilTab:AddRightGroupbox("Silent Flashlight", "flashlight")
    FlashSec:AddToggle(UID("flashAim"), {
        Text = "Enable Silent Flashlight",
        Default = VD.FLASH_SilentAim,
        Callback = function(v)
            W.Flash_SetEnabled(v)
            VD_Notify("Silent Flashlight", v and "Enabled" or "Disabled", 2)
        end
    })
    FlashSec:AddDropdown(UID("flashPart"), {
        Text = "Target Part",
        Values = { "Head", "UpperTorso", "Torso", "HumanoidRootPart" },
        Default = VD.FLASH_TargetPart,
        Multi = false,
        Callback = function(v)
            local val = type(v) == "table" and (v[1] or next(v)) or v
            VD.FLASH_TargetPart = val or "Head"
        end
    })
    FlashSec:AddSlider(UID("flashRange"), {
        Text = "Max Range",
        Min = 20, Max = 250, Default = VD.FLASH_Range, Rounding = 5, Suffix = " studs",
        Callback = function(v) VD.FLASH_Range = v end
    })
    FlashSec:AddSlider(UID("flashSmooth"), {
        Text = "Smoothness",
        Min = 0.05, Max = 1, Default = VD.FLASH_Smooth, Rounding = 0.05,
        Callback = function(v) VD.FLASH_Smooth = v end
    })
    FlashSec:AddToggle(UID("flashLaser"), {
        Text = "Show Laser",
        Default = VD.FLASH_Laser,
        Callback = function(v)
            VD.FLASH_Laser = v
            if not v and W.Flash_ClearLaser then W.Flash_ClearLaser() end
        end
    })

    local GunAimSec = SurvUtilTab:AddLeftGroupbox("Aim Lock Gun", "crosshair")
    GunAimSec:AddToggle(UID("gunAim"), {
        Text = "Enable Aim Lock Gun",
        Default = false,
        Callback = function(v)
            if W.GunAim_Cfg then W.GunAim_Cfg.Enabled = v end
            if v and W.GunAim_Start then W.GunAim_Start() end
            if v then VD_Notify("Aim Lock Gun", "Hold M2 to lock", 2) end
        end
    })
    GunAimSec:AddDropdown(UID("gunAimTarget"), {
        Text = "Target Mode",
        Values = { "Killer", "Survivor" },
        Default = "Killer",
        Multi = false,
        Callback = function(v)
            local val = type(v) == "table" and (v[1] or next(v)) or v
            if W.GunAim_Cfg then W.GunAim_Cfg.TargetMode = val end
        end
    })
    GunAimSec:AddSlider(UID("gunFOV"), {
        Text = "FOV Radius",
        Min = 50, Max = 1000, Default = 250, Rounding = 10,
        Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.FOV = v end end
    })
    GunAimSec:AddSlider(UID("gunSmooth"), {
        Text = "Aim Smoothness",
        Min = 0.1, Max = 1, Default = 0.5, Rounding = 0.05,
        Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.Strength = v end end
    })

    local VeilTabSec = SurvUtilTab:AddRightGroupbox("Silent Veil (Spear)", "zap")
    VeilTabSec:AddToggle(UID("veilEnabled"), {
        Text = "Enable Silent Veil V1",
        Default = VD.VeilEnabled,
        Callback = function(v)
            VD.VeilEnabled = v
            if not v then
                W._VeilState.target = nil; W._VeilState.lookVector = nil
            end
            if getgenv().Gluto_VeilBtn_UpdateVisual then getgenv().Gluto_VeilBtn_UpdateVisual() end
            VD_Notify("Silent Veil V1", v and "Enabled" or "Disabled", 2)
        end
    })
    VeilTabSec:AddToggle(UID("veilBtnShow"), {
        Text = "Show Veil Floating Button",
        Default = false,
        Callback = function(v)
            if getgenv().Gluto_VeilBtn_SetEnabled then getgenv().Gluto_VeilBtn_SetEnabled(v) end
        end
    })
    VeilTabSec:AddToggle(UID("veilAutoPred"), {
        Text = "Auto Predict",
        Default = VD.VeilAutoPredict,
        Callback = function(v) VD.VeilAutoPredict = v end
    })
    VeilTabSec:AddSlider(UID("veilFOV"), {
        Text = "FOV Size", Min = 50, Max = 500, Default = VD.VeilFOV, Rounding = 10,
        Callback = function(v) VD.VeilFOV = v end
    })
    VeilTabSec:AddSlider(UID("veilMaxDist"), {
        Text = "Max Distance", Min = 50, Max = 280, Default = VD.VeilMaxDist, Rounding = 10,
        Callback = function(v) VD.VeilMaxDist = v end
    })
end--====================================================--
-- UI: KILLER TAB
--====================================================--
do
    local AutoAtkSec = KillerTab:AddLeftGroupbox("Auto Attack", "sword")
    AutoAtkSec:AddToggle(UID("autoAtk"), {
        Text = "Enable Auto Attack",
        Default = VD.KILLER_AutoAttack,
        Callback = function(v)
            VD.KILLER_AutoAttack = v
            VD_Notify("Auto Attack", v and "Enabled" or "Disabled", 2)
        end
    })
    AutoAtkSec:AddSlider(UID("autoAtkRange"), {
        Text = "Attack Range", Min = 5, Max = 30, Default = VD.KILLER_AutoAttackRange, Rounding = 1, Suffix = " studs",
        Callback = function(v) VD.KILLER_AutoAttackRange = v end
    })
    AutoAtkSec:AddSlider(UID("autoAtkCD"), {
        Text = "Attack Cooldown", Min = 0.05, Max = 1, Default = VD.KILLER_AutoAttackCooldown, Rounding = 0.05, Suffix = "s",
        Callback = function(v) VD.KILLER_AutoAttackCooldown = v end
    })

    local LungeSec = KillerTab:AddRightGroupbox("Infinite Lunge", "zap")
    LungeSec:AddToggle(UID("infLunge"), {
        Text = "Infinite Lunge (Basic Attack)",
        Default = false,
        Callback = function(v) VD.KILLER_InfLunge = v end
    })

    local CounterParrySec = KillerTab:AddLeftGroupbox("Counter Auto Parry", "shield-off")
    CounterParrySec:AddToggle(UID("counterParry"), {
        Text = "Enable Counter Auto Parry",
        Default = false,
        Callback = function(v)
            W.CounterParry_Set(v)
            VD_Notify("Counter Parry", v and "Enabled" or "Disabled", 2)
        end
    })

    local BypassSec = KillerTab:AddRightGroupbox("Bypass No Cooldown", "unlock")
    BypassSec:AddToggle(UID("bpLeap"), {
        Text = "Hidden - Leap Bypass",
        Default = false,
        Callback = function(v)
            W.BYPASS_SetHiddenLeap(v)
            if v then VD_Notify("Bypass", "Hidden Leap ON", 2) end
        end
    })
    BypassSec:AddToggle(UID("bpGrab"), {
        Text = "Myers - Infinite Grab (H)",
        Default = false,
        Callback = function(v)
            W.setMyersGrab(v)
            if v then VD_Notify("Bypass", "Inf Grab ON (H)", 2) end
        end
    })
    BypassSec:AddToggle(UID("bpMist"), {
        Text = "Slasher - Infinite LakeMist",
        Default = false,
        Callback = function(v) W.MAWWW_SetLakeMist(v) end
    })
    BypassSec:AddToggle(UID("bpPursuit"), {
        Text = "Slasher - Infinite Pursuit",
        Default = false,
        Callback = function(v) W.MAWWW_SetPursuit(v) end
    })
    BypassSec:AddToggle(UID("bpAbyss"), {
        Text = "Abyss - Bypass Cooldown",
        Default = false,
        Callback = function(v) W.MAWWW_SetAbyssBypass(v) end
    })
    BypassSec:AddToggle(UID("bpFrenzy"), {
        Text = "Jeff - Infinite Frenzy",
        Default = false,
        Callback = function(v) W.MAWWW_SetJeffFrenzy(v) end
    })

    local AntiBlindSec = KillerTab:AddLeftGroupbox("Anti Blind", "eye-off")
    AntiBlindSec:AddToggle(UID("antiBlind"), {
        Text = "Anti Blind (Flashlight)",
        Default = false,
        Callback = function(v)
            VD.KILLER_AntiBlind = v
            if v and W.SetupAntiBlind then pcall(W.SetupAntiBlind) end
            if v then VD_Notify("Anti Blind", "Enabled", 2) end
        end
    })

    local DestroyPalletSec = KillerTab:AddRightGroupbox("Destroy Pallet", "hammer")
    DestroyPalletSec:AddToggle(UID("destroyPallet"), {
        Text = "Auto Destroy Pallet",
        Default = false,
        Callback = function(v)
            VD.KILLER_DestroyPallets = v
            if v then VD_Notify("Destroy Pallet", "Enabled", 2) end
        end
    })

    local MaskedSec = KillerTab:AddLeftGroupbox("Select Masked Power", "mask")
    local MaskedPowers = { "Cobra", "Richter", "Brandon", "Rabbit", "Alex", "Tony" }
    MaskedSec:AddDropdown(UID("maskedPower"), {
        Text = "Masked Power",
        Values = MaskedPowers,
        Default = "Cobra",
        Multi = false,
        Callback = function(v)
            local val = type(v) == "table" and (v[1] or next(v)) or v
            if W.Masked then W.Masked.CurrentPower = val end
            VD_Notify("Select Masked", "Selected: " .. tostring(val), 1)
        end
    })
    MaskedSec:AddButton({
        Text = "Activate Power",
        Func = function() W.Masked_Activate() end
    })
    MaskedSec:AddButton({
        Text = "Deactivate Power",
        Func = function() W.Masked_Deactivate() end
    })

    local CounterParrySec2 = KillerTab:AddRightGroupbox("Killer Abilities", "skull")
    CounterParrySec2:AddToggle(UID("autoStalk"), {
        Text = "Auto Stalk (Myers)",
        Default = false,
        Callback = function(v) W.KA_SetAutoStalk(v) end
    })
    CounterParrySec2:AddSlider(UID("autoStalkRange"), {
        Text = "Stalk Range", Min = 20, Max = 500, Default = 150, Rounding = 10, Suffix = " studs",
        Callback = function(v) W.KillerAbilities.AutoStalkRange = v end
    })
    CounterParrySec2:AddToggle(UID("autoKillAll"), {
        Text = "Auto Kill All",
        Default = false,
        Callback = function(v) W.KA_SetAutoKillAll(v) end
    })
    CounterParrySec2:AddToggle(UID("dropAllPallet"), {
        Text = "Drop All Pallet",
        Default = false,
        Callback = function(v) W.KA_SetDropAllPallet(v) end
    })
    CounterParrySec2:AddToggle(UID("blockAllVault"), {
        Text = "Block All Vault",
        Default = false,
        Callback = function(v) W.KA_SetBlockAllVault(v) end
    })
    CounterParrySec2:AddToggle(UID("autoHook"), {
        Text = "Auto Hook",
        Default = false,
        Callback = function(v) if W.KA_SetAutoHook then W.KA_SetAutoHook(v) end end
    })

    local UnlockCarrySec = KillerTab:AddLeftGroupbox("Unlock Skill While Carry", "hand")
    UnlockCarrySec:AddToggle(UID("unlockCarry"), {
        Text = "Enable Unlock Carry",
        Default = false,
        Callback = function(v)
            W.W424_CarryConfig = W.W424_CarryConfig or { Enabled = false }
            W.W424_CarryConfig.Enabled = v and true or false
            VD_Notify("Unlock Carry", v and "Enabled" or "Disabled", 2)
        end
    })

    local BypassForceSec = KillerTab:AddRightGroupbox("Instant Abilities (1x)", "zap")
    BypassForceSec:AddButton({
        Text = "Instant Drop All Pallet",
        Func = function()
            if W.KA_DropAllPallets_Force then W.KA_DropAllPallets_Force() end
            VD_Notify("Drop Pallet", "Triggered", 2)
        end
    })
    BypassForceSec:AddButton({
        Text = "Instant Block All Vault",
        Func = function()
            if W.KA_BlockAllVaults_Force then W.KA_BlockAllVaults_Force() end
            VD_Notify("Block Vault", "Triggered", 2)
        end
    })
    BypassForceSec:AddButton({
        Text = "Unblock All Vault",
        Func = function()
            local VaultCompleteEvent = ReplicatedStorage:FindFirstChild("Remotes")
                and ReplicatedStorage.Remotes:FindFirstChild("Window")
                and ReplicatedStorage.Remotes.Window:FindFirstChild("VaultCompleteEvent")
            if not VaultCompleteEvent then return end
            local count = 0
            local map = workspace:FindFirstChild("Map"); if not map then return end
            for _, trigger in ipairs(map:GetDescendants()) do
                if trigger.Name == "VaultPointInUse" then
                    local vaultParent = trigger.Parent
                    if vaultParent then
                        pcall(function()
                            VaultCompleteEvent:FireServer(vaultParent, false)
                            count = count + 1
                        end)
                    end
                end
            end
            ForceNotify("Block Vault", "Unblock " .. count .. " vaults!", 3)
        end
    })
end

--====================================================--
-- UI: KILLER AIM TAB
--====================================================--
do
    local AimHiddenSec = KillerAimTab:AddLeftGroupbox("Aim Lock Hidden", "target")
    AimHiddenSec:AddToggle(UID("aimHidden"), {
        Text = "Enable (Hold M2/E)",
        Default = false,
        Callback = function(v) W.AimLock_SetEnabled(v) end
    })
    AimHiddenSec:AddInput(UID("aimHiddenKey"), {
        Text = "Hold Keybind",
        Default = "E",
        Placeholder = "E / Q / F",
        Callback = function(inp)
            inp = tostring(inp or ""):gsub("%s+", "")
            if inp == "" then return end
            W.AimLock_SetKey(inp)
            VD_Notify("Aim Lock Hidden", "Key: " .. inp:upper(), 2)
        end
    })

    local AimAttackSec = KillerAimTab:AddRightGroupbox("Aim Lock Attack", "crosshair")
    AimAttackSec:AddToggle(UID("aimAttack"), {
        Text = "Enable (Hold M2)",
        Default = false,
        Callback = function(v)
            if W.AttackAim_Cfg then W.AttackAim_Cfg.Enabled = v end
            if v and W.AttackAim_Start then W.AttackAim_Start() end
            VD_Notify("Aim Lock Attack", v and "Enabled" or "Disabled", 2)
        end
    })
    AimAttackSec:AddSlider(UID("aimAttackFOV"), {
        Text = "FOV Radius", Min = 50, Max = 1000, Default = 250, Rounding = 10,
        Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.FOV = v end end
    })
    AimAttackSec:AddSlider(UID("aimAttackPredict"), {
        Text = "Prediction Strength", Min = 0, Max = 1, Default = 0.12, Rounding = 0.01,
        Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.PredictStrength = v end end
    })

    local ZombieAimSec = KillerAimTab:AddLeftGroupbox("Aimbot Zombie", "ghost")
    ZombieAimSec:AddToggle(UID("zombieAim"), {
        Text = "Enable (Hold M2)",
        Default = false,
        Callback = function(v)
            if W.ZombieAim_SetEnabled then W.ZombieAim_SetEnabled(v) end
            VD_Notify("Aimbot Zombie", v and "Enabled" or "Disabled", 2)
        end
    })
    ZombieAimSec:AddSlider(UID("zombieAimFOV"), {
        Text = "FOV Radius", Min = 50, Max = 1000, Default = 250, Rounding = 10,
        Callback = function(v) if W.ZombieAim_Cfg then W.ZombieAim_Cfg.FOV = v end end
    })
end

--====================================================--
-- UI: KILLER VEIL TAB
--====================================================--
do
    local FlaskSec = KillerVeilTab:AddLeftGroupbox("Silent Flask (The Cure)", "flask-conical")
    FlaskSec:AddToggle(UID("flaskEnable"), {
        Text = "Enable Silent Flask",
        Default = VD.FLASK_SilentAim,
        Callback = function(v)
            W.Flask_SetEnabled(v)
            VD_Notify("Silent Flask", v and "Enabled" or "Disabled", 2)
        end
    })
    FlaskSec:AddToggle(UID("flaskBeam"), {
        Text = "Show Beam",
        Default = VD.FLASK_ShowBeam,
        Callback = function(v) VD.FLASK_ShowBeam = v and true or false end
    })
    FlaskSec:AddToggle(UID("flaskLanding"), {
        Text = "Show Landing Marker",
        Default = VD.FLASK_ShowLanding,
        Callback = function(v) VD.FLASK_ShowLanding = v and true or false end
    })
    FlaskSec:AddToggle(UID("flaskPredict"), {
        Text = "Enable Prediction",
        Default = VD.FLASK_Predict,
        Callback = function(v) VD.FLASK_Predict = v and true or false end
    })
    FlaskSec:AddSlider(UID("flaskSpeed"), {
        Text = "Flask Speed", Min = 30, Max = 200, Default = VD.FLASK_Speed, Rounding = 5,
        Callback = function(v) W.Flask_SetSpeed(v) end
    })
    FlaskSec:AddSlider(UID("flaskGravity"), {
        Text = "Flask Gravity", Min = 50, Max = 400, Default = VD.FLASK_Gravity, Rounding = 5,
        Callback = function(v) W.Flask_SetGravity(v) end
    })
    FlaskSec:AddSlider(UID("flaskLead"), {
        Text = "Lead Multiplier", Min = 0, Max = 3, Default = VD.FLASK_LeadMult, Rounding = 0.1,
        Callback = function(v) W.Flask_SetLead(v) end
    })
    FlaskSec:AddSlider(UID("flaskRange"), {
        Text = "Max Range", Min = 50, Max = 500, Default = VD.FLASK_Range, Rounding = 10, Suffix = " studs",
        Callback = function(v) W.Flask_SetRange(v) end
    })

    local SpearSec = KillerVeilTab:AddRightGroupbox("Spear Aimbot", "sword")
    SpearSec:AddToggle(UID("spearAim"), {
        Text = "Enable Spear Aimbot",
        Default = VD.SPEAR_Aimbot,
        Callback = function(v)
            W.SpearAimbot_SetEnabled(v)
            VD_Notify("Spear Aimbot", v and "Enabled" or "Disabled", 2)
        end
    })
    SpearSec:AddSlider(UID("spearGravity"), {
        Text = "Spear Gravity", Min = 10, Max = 200, Default = VD.SPEAR_Gravity, Rounding = 1,
        Callback = function(v) W.SpearAimbot_SetGravity(v) end
    })
    SpearSec:AddSlider(UID("spearSpeed"), {
        Text = "Spear Speed", Min = 50, Max = 300, Default = VD.SPEAR_Speed, Rounding = 5,
        Callback = function(v) W.SpearAimbot_SetSpeed(v) end
    })

    local DashLockSec = KillerVeilTab:AddLeftGroupbox("Dash Lock", "lock")
    DashLockSec:AddToggle(UID("dashLock"), {
        Text = "Enable Dash Lock",
        Default = VD.DashLockEnabled,
        Callback = function(v)
            W.DashLock_SetEnabled(v)
            VD_Notify("Dash Lock", v and "Enabled" or "Disabled", 2)
        end
    })
    DashLockSec:AddSlider(UID("dashDur"), {
        Text = "Lock Duration", Min = 0.5, Max = 5, Default = VD.DashLockDuration, Rounding = 0.1, Suffix = "s",
        Callback = function(v) VD.DashLockDuration = v end
    })
    DashLockSec:AddSlider(UID("dashSmooth"), {
        Text = "Camera Smoothness", Min = 0.05, Max = 1, Default = VD.DashLockSmoothness, Rounding = 0.05,
        Callback = function(v) VD.DashLockSmoothness = v end
    })
    DashLockSec:AddToggle(UID("dashFreeze"), {
        Text = "Freeze Character",
        Default = VD.FreezeDuringDashLock,
        Callback = function(v)
            VD.FreezeDuringDashLock = v and true or false
            if not v then
                local char = LP.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed == 0 then hum.WalkSpeed = 16 end
            end
        end
    })

    local Veil2Sec = KillerVeilTab:AddRightGroupbox("Silent Spear Veil V2", "zap-off")
    Veil2Sec:AddToggle(UID("veilV1"), {
        Text = "V1 (Block Remote)",
        Default = false,
        Callback = function(v)
            if W.W424Veil_API and W.W424Veil_API.AimConfig then
                W.W424Veil_API.AimConfig.Aim_SilentVeil = v
            end
        end
    })
    Veil2Sec:AddToggle(UID("veilV2"), {
        Text = "V2 (Auto Predict)",
        Default = false,
        Callback = function(v)
            if W.W424Veil_API and W.W424Veil_API.AimConfig then
                W.W424Veil_API.AimConfig.Aim_SilentVeilV2 = v
            end
            VD_Notify("Silent Veil V2", v and "ON" or "OFF", 2)
        end
    })
    Veil2Sec:AddToggle(UID("veil2Smart"), {
        Text = "Auto Predict Mode",
        Default = false,
        Callback = function(v)
            if W.W424Veil_API and W.W424Veil_API.Config then
                W.W424Veil_API.Config.SpearSmart_enable = v
            end
        end
    })
    Veil2Sec:AddSlider(UID("veil2Lead"), {
        Text = "Lead Multiplier", Min = 0.5, Max = 5, Default = 1.4, Rounding = 0.1,
        Callback = function(v)
            if W.W424Veil_API and W.W424Veil_API.AimConfig then
                W.W424Veil_API.AimConfig.Veil_LeadMultiplier = v
            end
        end
    })
    Veil2Sec:AddSlider(UID("veil2Speed"), {
        Text = "Spear Speed", Min = 50, Max = 200, Default = 165, Rounding = 5,
        Callback = function(v)
            if W.W424Veil_API and W.W424Veil_API.AimConfig then
                W.W424Veil_API.AimConfig.SPEAR_Speed = v
            end
        end
    })
    Veil2Sec:AddSlider(UID("veil2Gravity"), {
        Text = "Spear Gravity", Min = 0, Max = 200, Default = 103, Rounding = 1,
        Callback = function(v)
            if W.W424Veil_API and W.W424Veil_API.AimConfig then
                W.W424Veil_API.AimConfig.SPEAR_Gravity = v
            end
        end
    })
    Veil2Sec:AddToggle(UID("veil2Tracker"), {
        Text = "ESP Tracker",
        Default = false,
        Callback = function(v)
            if W.W424Veil_API and W.W424Veil_API.setTracker then
                W.W424Veil_API.setTracker(v)
            end
        end
    })
                      end    --====================================================--
    -- UI: VISUALS TAB
    --====================================================--
    do
        local ESPBox = VisualsTab:AddLeftGroupbox("Full ESP System", "eye")
        ESPBox:AddToggle(UID("espSurv"), {
            Text = "ESP Survivor", Default = false,
            Callback = function(v) FESP.Survivor = v end
        })
        ESPBox:AddColorPicker(UID("espSurvCol"), {
            Title = "Survivor Color", Default = FESPC.Survivor, Save = false,
            Callback = function(c) FESPC.Survivor = c end
        })
        ESPBox:AddToggle(UID("espKill"), {
            Text = "ESP Killer", Default = false,
            Callback = function(v) FESP.Killer = v end
        })
        ESPBox:AddColorPicker(UID("espKillCol"), {
            Title = "Killer Color", Default = FESPC.Killer, Save = false,
            Callback = function(c) FESPC.Killer = c end
        })
        ESPBox:AddToggle(UID("espGen"), {
            Text = "ESP Generator", Default = false,
            Callback = function(v) FESP.Generator = v end
        })
        ESPBox:AddColorPicker(UID("espGenCol"), {
            Title = "Generator Color", Default = FESPC.Generator, Save = false,
            Callback = function(c) FESPC.Generator = c end
        })
        ESPBox:AddToggle(UID("espPallet"), {
            Text = "ESP Pallet", Default = false,
            Callback = function(v) FESP.Pallet = v end
        })
        ESPBox:AddColorPicker(UID("espPalletCol"), {
            Title = "Pallet Color", Default = FESPC.Pallet, Save = false,
            Callback = function(c) FESPC.Pallet = c end
        })
        ESPBox:AddToggle(UID("espWin"), {
            Text = "ESP Window", Default = false,
            Callback = function(v)
                FESP.Window = v
                _G.GlutoWindowScanned = false
            end
        })
        ESPBox:AddColorPicker(UID("espWinCol"), {
            Title = "Window Color", Default = FESPC.Window, Save = false,
            Callback = function(c) FESPC.Window = c end
        })
        ESPBox:AddToggle(UID("espSCP"), {
            Text = "ESP SCP", Default = false,
            Callback = function(v) FESP.SCP = v end
        })
        ESPBox:AddColorPicker(UID("espSCPCol"), {
            Title = "SCP Color", Default = FESPC.SCP, Save = false,
            Callback = function(c) FESPC.SCP = c end
        })
        ESPBox:AddSlider(UID("espRadius"), {
            Text = "ESP Radius", Min = 10, Max = 1000, Default = 500, Rounding = 10,
            Callback = function(v) FESP.Distance = v end
        })

        local ESPStatusBox = VisualsTab:AddRightGroupbox("ESP Status", "info")
        ESPStatusBox:AddToggle(UID("espStatus"), {
            Text = "Enable Status ESP", Default = false,
            Callback = function(v) FESPS.Enabled = v end
        })
        ESPStatusBox:AddToggle(UID("espStatusName"), {
            Text = "Show Name", Default = true,
            Callback = function(v) FESPS.ShowName = v end
        })
        ESPStatusBox:AddToggle(UID("espStatusDist"), {
            Text = "Show Distance", Default = true,
            Callback = function(v) FESPS.ShowDistance = v end
        })
        ESPStatusBox:AddToggle(UID("espStatusAva"), {
            Text = "Show Avatar", Default = true,
            Callback = function(v) FESPS.ShowAvatar = v end
        })
        ESPStatusBox:AddToggle(UID("espStatusAct"), {
            Text = "Show Action", Default = true,
            Callback = function(v) FESPS.ShowAction = v end
        })
        ESPStatusBox:AddToggle(UID("espStatusHP"), {
            Text = "Show Health Bar", Default = false,
            Callback = function(v) FESPS.ShowHealth = v end
        })
        ESPStatusBox:AddSlider(UID("espStatusRadius"), {
            Text = "Status Radius", Min = 20, Max = 1000, Default = 500, Rounding = 10,
            Callback = function(v) FESPS.Radius = v end
        })
    end

    --====================================================--
    -- UI: GRAPHICS TAB
    --====================================================--
    do
        local GraphicsSec = GraphicsTab:AddLeftGroupbox("Graphics", "monitor")
        GraphicsSec:AddToggle(UID("gFullbright"), {
            Text = "Fullbright", Default = false,
            Callback = function(v)
                W.Graphics.Fullbright = v
                W.Graphics_Apply()
            end
        })
        GraphicsSec:AddToggle(UID("gNoShadow"), {
            Text = "No Shadow", Default = false,
            Callback = function(v)
                W.Graphics.NoShadow = v
                W.Graphics_Apply()
            end
        })
        GraphicsSec:AddToggle(UID("gLowGfx"), {
            Text = "Low Graphics", Default = false,
            Callback = function(v)
                W.Graphics.LowGraphics = v
                W.Graphics_ApplyOptimization()
            end
        })
        GraphicsSec:AddToggle(UID("gNoScreenFx"), {
            Text = "No Screen Effects", Default = false,
            Callback = function(v)
                W.Graphics.NoScreenEffects = v
                W.Graphics_ApplyNoScreenFx()
            end
        })
        GraphicsSec:AddToggle(UID("gCleanSky"), {
            Text = "Clean Sky", Default = false,
            Callback = function(v)
                W.Graphics.CleanSky = v
                W.Graphics_ApplyOptimization()
            end
        })
        GraphicsSec:AddToggle(UID("gPotato"), {
            Text = "Potato Mode", Default = false,
            Callback = function(v)
                if W.Potato_SetEnabled then
                    W.Potato_SetEnabled(v)
                    if v then VD_Notify("Potato Mode", "Enabled", 3) end
                end
            end
        })

        local TimeSec = GraphicsTab:AddRightGroupbox("Clock & Ambient", "clock")
        TimeSec:AddToggle(UID("gClockOverride"), {
            Text = "Enable Clock Override", Default = false,
            Callback = function(v)
                W.Graphics.ClockTimeEnabled = v
                W.Graphics_Apply()
            end
        })
        TimeSec:AddSlider(UID("gClock"), {
            Text = "Clock Time", Min = 0, Max = 24, Default = 14, Rounding = 1,
            Callback = function(v)
                W.Graphics.ClockTime = v
                W.Graphics.ClockTimeEnabled = true
                W.Graphics_Apply()
            end
        })
        TimeSec:AddSlider(UID("gBrightness"), {
            Text = "Brightness", Min = 0, Max = 5, Default = 2, Rounding = 0.1,
            Callback = function(v)
                W.Graphics.Brightness = v
                W.Graphics.ClockTimeEnabled = true
                W.Graphics_Apply()
            end
        })

        local ZoomSec = GraphicsTab:AddLeftGroupbox("Zoom & FOV", "zoom-in")
        ZoomSec:AddToggle(UID("gUnlimZoom"), {
            Text = "Unlimited Zoom", Default = false,
            Callback = function(v)
                W.Graphics.UnlimitedZoom = v
                W.Graphics_ApplyZoom()
            end
        })
        ZoomSec:AddSlider(UID("gMaxZoom"), {
            Text = "Max Zoom Distance", Min = 100, Max = 5000, Default = 1000, Rounding = 50,
            Callback = function(v)
                W.Graphics.MaxZoomDistance = v
                if W.Graphics.UnlimitedZoom then W.Graphics_ApplyZoom() end
            end
        })
        ZoomSec:AddToggle(UID("gCustomFOV"), {
            Text = "Custom FOV", Default = false,
            Callback = function(v)
                W.Graphics.FOVEnabled = v
                W.Graphics_ApplyFOV()
            end
        })
        ZoomSec:AddSlider(UID("gFOV"), {
            Text = "Camera FOV", Min = 40, Max = 120, Default = 70, Rounding = 5,
            Callback = function(v)
                W.Graphics.FOV = v
                if W.Graphics.FOVEnabled then W.Graphics_ApplyFOV() end
            end
        })

        local LockPOVSec = GraphicsTab:AddRightGroupbox("Lock POV", "lock")
        LockPOVSec:AddToggle(UID("lockPOV"), {
            Text = "Enable Lock POV", Default = false,
            Callback = function(v)
                W.LockPOV_SetEnabled(v)
                if v then VD_Notify("Lock POV", "Enabled", 2) end
            end
        })
        LockPOVSec:AddSlider(UID("lockPOVVal"), {
            Text = "Locked FOV", Min = 40, Max = 120, Default = 80, Rounding = 5,
            Callback = function(v)
                W.LockPOV.LockedFOV = v
                if W.LockPOV.Enabled then
                    local cam = Workspace.CurrentCamera
                    if cam then cam.FieldOfView = v end
                end
            end
        })

        local CamDBDSec = GraphicsTab:AddLeftGroupbox("Camera DBD", "video")
        CamDBDSec:AddToggle(UID("camDBDSmooth"), {
            Text = "DBD Camera (Smooth Follow)", Default = false,
            Callback = function(v)
                W.CamDBD_SetSmooth(v)
                VD_Notify("Camera DBD", v and "Smooth ON" or "Smooth OFF", 2)
            end
        })
        CamDBDSec:AddSlider(UID("camDBDSpeed"), {
            Text = "Camera Smoothness", Min = 1, Max = 30, Default = 4, Rounding = 1,
            Callback = function(v) W.CamDBD_SetSmoothSpeed(v) end
        })
        CamDBDSec:AddToggle(UID("camDBDPOV"), {
            Text = "POV Lock", Default = false,
            Callback = function(v)
                W.CamDBD_SetPOVLock(v)
                VD_Notify("Camera DBD", v and "POV Lock ON" or "POV Lock OFF", 2)
            end
        })
        CamDBDSec:AddSlider(UID("camDBDPOVVal"), {
            Text = "POV Value", Min = 60, Max = 120, Default = 85, Rounding = 1, Suffix = "°",
            Callback = function(v) W.CamDBD_SetTargetPOV(v) end
        })
        CamDBDSec:AddSlider(UID("camDBDPOVSmooth"), {
            Text = "POV Smoothness", Min = 3, Max = 20, Default = 9, Rounding = 1,
            Callback = function(v) W.CamDBD_SetPOVSmooth(v) end
        })
    end

    --====================================================--
    -- UI: MISC TAB
    --====================================================--
    do
        local StunSec = MiscTab:AddLeftGroupbox("Stun Indicator", "star")
        StunSec:AddToggle(UID("stunInd"), {
            Text = "Enable Stun Indicator", Default = false,
            Callback = function(v)
                W.SInd_SetEnabled(v)
                if v then VD_Notify("Stun Indicator", "Enabled", 2) end
            end
        })
        StunSec:AddDropdown(UID("stunSound"), {
            Text = "Stun Sound",
            Values = { "Default","Clash Royale","Blash","Coin","Kururin Kuru","Spongebob","Fahhhh","Cave","Aughhh","Samsung","iPhone","Siren" },
            Default = "Default",
            Multi = false,
            Callback = function(v)
                local val = type(v) == "table" and (v[1] or next(v)) or v
                if W.StunIndicator then W.StunIndicator.SelectedSound = val end
            end
        })
        StunSec:AddToggle(UID("stunSoundAlert"), {
            Text = "Stun Sound Alert", Default = true,
            Callback = function(v) if W.StunIndicator then W.StunIndicator.SoundEnabled = v end end
        })
        StunSec:AddButton({
            Text = "Preview Sound",
            Func = function()
                pcall(function()
                    local sid = "18843924331"
                    if W.SInd_GetActiveSoundId then sid = W.SInd_GetActiveSoundId() end
                    local snd = Instance.new("Sound")
                    snd.SoundId = "rbxassetid://" .. tostring(sid)
                    snd.Volume = (W.StunIndicator and W.StunIndicator.SoundVolume) or 1.5
                    snd.Parent = LP:FindFirstChildOfClass("PlayerGui") or Workspace
                    snd:Play()
                    snd.Ended:Connect(function() pcall(function() snd:Destroy() end) end)
                    task.delay(5, function() pcall(function() if snd and snd.Parent then snd:Destroy() end end) end)
                end)
            end
        })
        StunSec:AddSlider(UID("stunRange"), {
            Text = "Detect Range", Min = 50, Max = 2000, Default = 500, Rounding = 25, Suffix = " studs",
            Callback = function(v) if W.StunIndicator then W.StunIndicator.Range = v end end
        })
        StunSec:AddSlider(UID("stunVol"), {
            Text = "Sound Volume", Min = 0, Max = 5, Default = 1.5, Rounding = 0.1,
            Callback = function(v) if W.StunIndicator then W.StunIndicator.SoundVolume = v end end
        })

        local InvisSec = MiscTab:AddRightGroupbox("Invisibility", "eye-off")
        InvisSec:AddToggle(UID("invisToggle"), {
            Text = "Enable Invisibility", Default = false,
            Callback = function(v)
                W.Invisible_SetState(v, false)
                if getgenv().Gluto_InvisBtn_UpdateVisual then getgenv().Gluto_InvisBtn_UpdateVisual() end
            end
        })
        InvisSec:AddToggle(UID("invisBtnShow"), {
            Text = "Show Invisibility Button", Default = false,
            Callback = function(v)
                if getgenv().Gluto_InvisBtn_SetEnabled then getgenv().Gluto_InvisBtn_SetEnabled(v) end
            end
        })
        InvisSec:AddKeybind(UID("invisKey"), {
            Title = "Toggle Hotkey", Default = Enum.KeyCode.G,
            Callback = function(kc)
                if kc then VD.Invis_Hotkey = kc.Name end
                ForceNotify("Invisible", "Hotkey: " .. (kc and kc.Name or "None"), 2)
            end
        })

        local PUSec = MiscTab:AddLeftGroupbox("Player Utility", "user")
        PUSec:AddToggle(UID("puSpeed"), {
            Text = "Speed Hack", Default = false,
            Callback = function(v)
                VD.PU_SpeedEnabled = v
                if not v then
                    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum.WalkSpeed = 16 end
                end
                if v then VD_Notify("Player Utility", "Speed Hack ON", 2) end
            end
        })
        PUSec:AddSlider(UID("puSpeedVal"), {
            Text = "Speed Value", Min = 16, Max = 200, Default = 16, Rounding = 1,
            Callback = function(v) VD.PU_SpeedValue = v end
        })
        PUSec:AddToggle(UID("puShift"), {
            Text = "Shift Lock", Default = false,
            Callback = function(v)
                VD.PU_ShiftLock = v and true or false
                if v then VD_Notify("Player Utility", "Shift Lock ON", 2) end
            end
        })
        PUSec:AddToggle(UID("puZoom"), {
            Text = "Unlimited Zoom", Default = false,
            Callback = function(v)
                VD.PU_UnlimitedZoom = v and true or false
                if not v then
                    pcall(function()
                        LP.CameraMaxZoomDistance = 128
                        LP.CameraMinZoomDistance = 0.5
                    end)
                end
            end
        })
        PUSec:AddToggle(UID("puNoclip"), {
            Text = "Noclip", Default = false,
            Callback = function(v)
                VD.PU_Noclip = v and true or false
                if v then VD_Notify("Player Utility", "Noclip ON", 2) end
            end
        })
        PUSec:AddToggle(UID("puSkipEnd"), {
            Text = "Skip End Screen", Default = false,
            Callback = function(v) W.SkipEnd_Set(v) end
        })
        PUSec:AddToggle(UID("puHideName"), {
            Text = "Hide Name", Default = false,
            Callback = function(v) W.HideName_Set(v) end
        })
        PUSec:AddToggle(UID("puHideIcon"), {
            Text = "Hide Survivor Icon", Default = false,
            Callback = function(v) W.HideIcon_Set(v) end
        })

        local SBSec = MiscTab:AddRightGroupbox("Speed Boost", "gauge")
        SBSec:AddToggle(UID("sbToggle"), {
            Text = "Enable Speed Boost", Default = false,
            Callback = function(v)
                if W.SpeedBoost_SetEnabled then W.SpeedBoost_SetEnabled(v) end
                VD_Notify("Speed Boost", v and "Enabled" or "Disabled", 2)
            end
        })
        SBSec:AddSlider(UID("sbVal"), {
            Text = "Speed Value", Min = 16, Max = 100, Default = 30, Rounding = 1,
            Callback = function(v) if W.SpeedBoost_SetValue then W.SpeedBoost_SetValue(v) end end
        })

        local CursorSec = MiscTab:AddLeftGroupbox("Cursor Feature", "mouse-pointer")
        CursorSec:AddToggle(UID("cursorToggle"), {
            Text = "Enable Cursor Unlock", Default = false,
            Callback = function(v)
                if W.Cursor_SetEnabled then W.Cursor_SetEnabled(v) end
                VD_Notify("Cursor Unlock", v and "Enabled" or "Disabled", 2)
            end
        })
        CursorSec:AddButton({
            Text = "Toggle Cursor Now",
            Func = function()
                if W.Cursor_SetEnabled then W.Cursor_SetEnabled(not VD.CursorEnabled) end
                VD_Notify("Cursor Unlock", VD.CursorEnabled and "ON" or "OFF", 2)
            end
        })

        local SpectatorSec = MiscTab:AddRightGroupbox("Spectator Counter", "users")
        SpectatorSec:AddToggle(UID("spectatorToggle"), {
            Text = "Enable Spectator Counter", Default = false,
            Callback = function(v) W.Spectator_Set(v) end
        })

        local JerkSec = MiscTab:AddLeftGroupbox("Jerk Off", "banana")
        JerkSec:AddToggle(UID("jerkToggle"), {
            Text = "Enable Jerk Off Tool", Default = false,
            Callback = function(v)
                W.JerkOff_SetEnabled(v)
                VD_Notify("Jerk Off", v and "Tool spawned!" or "Tool removed", 2)
            end
        })

        local EmoteSec = MiscTab:AddRightGroupbox("Emote", "music")
        EmoteSec:AddToggle(UID("emoteToggle"), {
            Text = "Enable Emote", Default = false,
            Callback = function(v)
                W.EmoteSystem_SetEnabled(v)
                VD_Notify("Emote", v and ("Playing: " .. W.EmoteSystem.SelectedEmote) or "Stopped", 2)
            end
        })
        EmoteSec:AddDropdown(UID("emoteSelect"), {
            Text = "Select Emote",
            Values = W.EmoteSystem.Options,
            Default = "Friday Night",
            Multi = false,
            Callback = function(v)
                local val = type(v) == "table" and (v[1] or next(v)) or v
                W.EmoteSystem_SelectEmote(val or "Friday Night")
                VD_Notify("Emote", "Selected: " .. W.EmoteSystem.SelectedEmote, 2)
            end
        })
        EmoteSec:AddButton({
            Text = "Stop Emote",
            Func = function()
                W.EmoteSystem_Stop()
                W.EmoteSystem.Enabled = false
                VD_Notify("Emote", "Stopped", 2)
            end
        })

        local HeaderSec = MiscTab:AddLeftGroupbox("Header Title", "text")
        HeaderSec:AddInput(UID("headerText"), {
            Text = "Header Text",
            Default = "PAZZHUB",
            Placeholder = "Nama header...",
            Callback = function(input) W.Header_SetText(input) end
        })
        HeaderSec:AddToggle(UID("headerToggle"), {
            Text = "Enable Header", Default = false,
            Callback = function(v) W.Header_Set(v) end
        })
        HeaderSec:AddColorPicker(UID("headerColor"), {
            Title = "Header Color",
            Default = Color3.fromRGB(255, 255, 255),
            Save = false,
            Callback = function(c) W.Header_SetColor(c) end
        })
    end

    --====================================================--
    -- UI: CONFIG TAB (PAZZHUB Theme + SaveManager)
    --====================================================--
    do
        local ConfigBoxL = ConfigTab:AddLeftGroupbox("Settings", "wrench")
        ConfigBoxL:AddDropdown(UID("notifySide"), {
            Text = "Notification Side",
            Values = {"Left", "Right"},
            Default = "Right",
            Multi = false,
            Callback = function(v)
                local val = type(v) == "table" and (v[1] or next(v)) or v
                if val then Library:SetNotifySide(val) end
            end
        })
        ConfigBoxL:AddDropdown(UID("dpiScale"), {
            Text = "DPI Scale",
            Values = {"50%", "75%", "85%", "100%", "125%", "150%"},
            Default = "85%",
            Multi = false,
            Callback = function(v)
                local val = type(v) == "table" and (v[1] or next(v)) or v
                if val then
                    local num = tonumber(val:gsub("%%", ""))
                    if num then Library:SetDPIScale(num) end
                end
            end
        })
        ConfigBoxL:AddToggle(UID("customCursor"), {
            Text = "Custom Cursor",
            Default = true,
            Callback = function(v) Library.ShowCustomCursor = v end
        })
        ConfigBoxL:AddToggle(UID("watermarkToggle"), {
            Text = "Watermark",
            Default = true,
            Callback = function(v) Watermark.Visible = v end
        })

        local ConfigBoxR = ConfigTab:AddRightGroupbox("Theme", "palette")
        ConfigBoxR:AddLabel("Tema: Biru Neon")
        ConfigBoxR:AddDivider()
        ConfigBoxR:AddSlider(UID("uiCorner"), {
            Text = "Corner Radius",
            Min = 0, Max = 20, Default = Library.CornerRadius or 14, Rounding = 0,
            Callback = function(v) Window:SetCornerRadius(v) end
        })
        ConfigBoxR:AddButton({
            Text = "Unload Script",
            Func = function() Library:Unload() end
        })

        ThemeManager:SetLibrary(Library)
        SaveManager:SetLibrary(Library)
        SaveManager:IgnoreThemeSettings()
        SaveManager:SetIgnoreIndexes({})
        ThemeManager:SetFolder("PazzHub")
        SaveManager:SetFolder("PazzHub/configs")
    end

    --====================================================--
    -- READY NOTIFY
    --====================================================--
    task.spawn(function()
        task.wait(0.5)
        pcall(function()
            Library:Notify({
                Title = "PAZZHUB Loaded",
                Content = "All features loaded. LeftControl to toggle.",
                Duration = 4,
            })
        end)
    end)
    print("[PAZZHUB x ALFzxzzz] Loaded OK")
    print("  Tab: Survivor / Parry / Gen / Surv Util / Killer / Killer Aim / Killer Veil")
    print("        / Visuals / Graphics / Misc / Config / Info")

end  -- ⬅️ PENUTUP __Gluto_Init_Main__()

--====================================================--
-- EXECUTE
--====================================================--
__Gluto_Init_Main__()
