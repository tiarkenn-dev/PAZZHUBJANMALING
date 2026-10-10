-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB — HUB v0.4.0
--  Logo: 72845574620852
--  Tema: Biru Neon · Compact Layout
--  Tabs: Survivor · Visuals · Killer · Misc · Troll · Config
--  Base: FAZZHUB HUB (all-in-one)
-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 1] UI Shell + Tema + Floating Toggle + Window + Watermark
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ LOAD LIBRARY ═══════════════
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

-- ═══════════════ TEMA BIRU NEON ═══════════════
Library.Scheme.AccentColor     = Color3.fromRGB(0, 170, 255)
Library.Scheme.BackgroundColor = Color3.fromRGB(8, 14, 26)
Library.Scheme.MainColor       = Color3.fromRGB(16, 24, 42)
Library.Scheme.OutlineColor    = Color3.fromRGB(0, 120, 200)
Library.Scheme.FontColor       = Color3.fromRGB(200, 230, 255)

local TOGGLE_ICON = 72845574620852
local ACCENT = Color3.fromRGB(0, 170, 255)

-- ═══════════════ GLOBAL VARIABLES ═══════════════
getgenv().VD = getgenv().VD or {}
local W = getgenv()

W.VERSION = "v0.4.0"
W.BUILD   = "FAZZHUB"
W.NotifyEnabled = W.NotifyEnabled ~= false

-- Service shortcut
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

-- ═══════════════ NOTIFY HELPER ═══════════════
local NotifySide = "Right"

local function ShowNotify(title, content, duration)
    if not W.NotifyEnabled then return end
    pcall(function()
        Library:Notify({
            Title = title or "FAZZHUB",
            Content = content or "",
            Duration = duration or 3,
            Side = NotifySide,
        })
    end)
end

local function VD_Notify(title, content, duration) ShowNotify(title, content, duration) end
local function ForceNotify(title, content, duration) ShowNotify(title, content, duration) end

W.VD_Notify = VD_Notify
W.ForceNotify = ForceNotify
W.ShowNotify = ShowNotify

-- ═══════════════ FLOATING TOGGLE ═══════════════
local function CreateFazzToggle(IconId)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FazzToggle"
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
        TweenService:Create(Glow, TweenInfo.new(.15), {
            Transparency = 0.3
        }):Play()
    end)

    MainButton.MouseLeave:Connect(function()
        TweenService:Create(MainButton, TweenInfo.new(.15), {
            BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        }):Play()
        TweenService:Create(Glow, TweenInfo.new(.15), {
            Transparency = 0.6
        }):Play()
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
    return ScreenGui, MainButton
end

CreateFazzToggle(TOGGLE_ICON)

-- ═══════════════ WINDOW ═══════════════
local Window = Library:CreateWindow({
    Title = "FAZZHUB",
    Footer = "FAZZHUB",
    Icon = TOGGLE_ICON,
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

-- ═══════════════ WATERMARK ═══════════════
local Watermark = Library:AddDraggableLabel("FAZZHUB | Loading...")

local FPS, Frames, LastTick = 0, 0, tick()
RunService.RenderStepped:Connect(function()
    Frames += 1
    if tick() - LastTick >= 1 then
        FPS = Frames; Frames = 0; LastTick = tick()
        local Ping = 0
        pcall(function()
            Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        Watermark:SetText(string.format("FAZZHUB | FPS: %d | PING: %d ms", FPS, Ping))
    end
end)

-- ═══════════════ TABS ═══════════════
local Tabs = {
    Survivor = Window:AddTab("Survivor", "user"),
    Visuals  = Window:AddTab("Visuals", "eye"),
    Killer   = Window:AddTab("Killer", "swords"),
    Misc     = Window:AddTab("Misc", "wrench"),
    Troll    = Window:AddTab("Troll", "ghost"),
    Config   = Window:AddTab("Config", "settings"),
}

W.Tabs = Tabs
W.Window = Window
W.Library = Library
W.ThemeManager = ThemeManager
W.SaveManager = SaveManager
W.ACCENT = ACCENT
W.TOGGLE_ICON = TOGGLE_ICON

-- ═══════════════ SECTION 1 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 1 loaded — UI Shell ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 2] Core Helper Functions
--  Role Detect · Team Check · Char Cache · Utility Global
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ TEAM / ROLE DETECTION ═══════════════
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

-- ═══════════════ CHARACTER CACHE ═══════════════
local CharCache = { Char = nil, Root = nil, Hum = nil, Head = nil, UpperTorso = nil, CheckInt = nil }

local function GetCharCache()
    local char = LocalPlayer.Character
    if char ~= CharCache.Char then
        CharCache.Char = char
        CharCache.Root = nil
        CharCache.Hum = nil
        CharCache.Head = nil
        CharCache.UpperTorso = nil
        CharCache.CheckInt = nil
    end
    if not char then return CharCache end
    if not CharCache.Root then CharCache.Root = char:FindFirstChild("HumanoidRootPart") end
    if not CharCache.Hum then CharCache.Hum = char:FindFirstChildOfClass("Humanoid") end
    if not CharCache.Head then CharCache.Head = char:FindFirstChild("Head") end
    if not CharCache.UpperTorso then
        CharCache.UpperTorso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    end
    if not CharCache.CheckInt then CharCache.CheckInt = char:FindFirstChild("CheckInterractable") end
    return CharCache
end
W.GetCharCache = GetCharCache

-- ═══════════════ IS DOWNED / DEAD CHECK ═══════════════
local function IsDowned(char)
    if not char then return true end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local state = char:GetAttribute("State")
    return state == "Downed" or state == "Dead"
end
W.IsDowned = IsDowned

local function IsAliveChar(char)
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if char:GetAttribute("State") == "Dead" then return false end
    return true
end
W.IsAliveChar = IsAliveChar

-- ═══════════════ GET ALL PLAYERS BY ROLE ═══════════════
local function GetAllByRole(role, ignoreLocal)
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if not (ignoreLocal and p == LocalPlayer) then
            if TeamIs(p, role) and p.Character then
                table.insert(list, p)
            end
        end
    end
    return list
end
W.GetAllByRole = GetAllByRole

-- ═══════════════ GET CLOSEST PLAYER ═══════════════
local function GetClosestPlayer(role, maxRange)
    local cc = GetCharCache()
    if not cc.Root then return nil, math.huge end
    local best, bestDist = nil, maxRange or math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and TeamIs(p, role) and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local d = (hrp.Position - cc.Root.Position).Magnitude
                if d < bestDist then bestDist = d; best = p end
            end
        end
    end
    return best, bestDist
end
W.GetClosestPlayer = GetClosestPlayer

-- ═══════════════ PLAYER GUI GETTER ═══════════════
local function GetPlayerGui()
    return LocalPlayer:FindFirstChildOfClass("PlayerGui")
end
W.GetPlayerGui = GetPlayerGui

-- ═══════════════ MOBILE BUTTON FIRER ═══════════════
local function FireMobileButton(btn)
    if not btn then return end
    pcall(function()
        if type(firesignal) == "function" then
            firesignal(btn.MouseButton1Down)
            task.wait(0.05)
            firesignal(btn.MouseButton1Up)
            firesignal(btn.MouseButton1Click)
        end
    end)
end
W.FireMobileButton = FireMobileButton

-- ═══════════════ VIRTUAL CLICK (Mobile) ═══════════════
local function VirtualClick(x, y, id)
    if not VirtualInputManager then return end
    id = id or 8822
    pcall(function()
        VirtualInputManager:SendTouchEvent(id, 0, x, y)
        task.wait(0.01)
        VirtualInputManager:SendTouchEvent(id, 2, x, y)
    end)
end
W.VirtualClick = VirtualClick

-- ═══════════════ VIRTUAL KEYPRESS (PC) ═══════════════
local function VirtualKeyPress(keyCode, holdTime)
    if not VirtualInputManager then return end
    pcall(function()
        VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
        task.wait(holdTime or 0.05)
        VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
    end)
end
W.VirtualKeyPress = VirtualKeyPress

-- ═══════════════ VIRTUAL MOUSE CLICK (PC) ═══════════════
local function VirtualMouseClick(button, holdTime)
    if not VirtualInputManager then return end
    button = button or 2 -- 1=Left, 2=Right, 3=Middle
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, button, true, game, 0)
        task.wait(holdTime or 0.05)
        VirtualInputManager:SendMouseButtonEvent(0, 0, button, false, game, 0)
    end)
end
W.VirtualMouseClick = VirtualMouseClick

-- ═══════════════ RAYCAST VISIBILITY CHECK ═══════════════
local function IsVisible(fromPos, toPos, ignoreList)
    if not fromPos or not toPos then return false end
    local dir = toPos - fromPos
    local dist = dir.Magnitude
    if dist < 0.1 then return true end
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    local ex = {}
    if LocalPlayer.Character then table.insert(ex, LocalPlayer.Character) end
    if ignoreList then
        for _, v in ipairs(ignoreList) do table.insert(ex, v) end
    end
    rp.FilterDescendantsInstances = ex
    local result = Workspace:Raycast(fromPos, dir.Unit * dist, rp)
    return result == nil
end
W.IsVisible = IsVisible

-- ═══════════════ SMOOTH CAMERA LOCK ═══════════════
local function SmoothCameraLock(targetPos, smoothness)
    local cam = Workspace.CurrentCamera
    if not cam or not targetPos then return end
    smoothness = math.clamp(smoothness or 0.3, 0.05, 1)
    cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, targetPos), smoothness)
end
W.SmoothCameraLock = SmoothCameraLock

-- ═══════════════ GLOBAL FPS / PING ═══════════════
W.FPSData = { Value = 0, Ping = 0, Frames = 0, LastTick = tick() }
RunService.RenderStepped:Connect(function()
    W.FPSData.Frames = W.FPSData.Frames + 1
    local now = tick()
    if now - W.FPSData.LastTick >= 1 then
        W.FPSData.Value = W.FPSData.Frames
        W.FPSData.Frames = 0
        W.FPSData.LastTick = now
        pcall(function()
            W.FPSData.Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
    end
end)

-- ═══════════════ CLEANUP ON DEATH ═══════════════
LocalPlayer.CharacterRemoving:Connect(function()
    -- clear cache untuk hindari memory leak
    CharCache.Char = nil
    CharCache.Root = nil
    CharCache.Hum = nil
    CharCache.Head = nil
    CharCache.UpperTorso = nil
    CharCache.CheckInt = nil
end)

-- ═══════════════ SECTION 2 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 2 loaded — Core Helpers ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 3] Core Logic: Auto Crouch Dodge + Parry V1 System
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ AUTO CROUCH DODGE ═══════════════

-- Variabel default (kalau belum ada)
VD.AutoCrouch = VD.AutoCrouch or false

-- Trigger Crouch (dipanggil saat killer pakai anim Abyssal S1)
function W.TriggerCrouch()
    local startT = tick()
    task.spawn(function()
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        pcall(function() char:SetAttribute("Crouching", true) end)
        pcall(function()
            ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true)
        end)
        pcall(function()
            ReplicatedStorage.Remotes.Chase.Runevent:FireServer(char, false)
        end)
        if humanoid then
            pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end)
        end
        pcall(function()
            local survMob = LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
            if survMob then
                local controls = survMob:FindFirstChild("Controls")
                if controls then
                    local crouchBtn = controls:FindFirstChild("crouch")
                    if crouchBtn then
                        if type(firesignal) == "function" then
                            firesignal(crouchBtn.MouseButton1Click)
                        end
                    end
                end
            end
        end)
        while tick() - startT < 1.2 do
            pcall(function()
                ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true)
            end)
            task.wait(0.1)
        end
        pcall(function() char:SetAttribute("Crouching", false) end)
        pcall(function()
            ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", false)
        end)
        if humanoid then
            pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end)
        end
        pcall(function()
            local survMob = LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
            if survMob then
                local controls = survMob:FindFirstChild("Controls")
                if controls then
                    local crouchBtn = controls:FindFirstChild("crouch")
                    if crouchBtn then
                        if type(firesignal) == "function" then
                            firesignal(crouchBtn.MouseButton1Click)
                        end
                    end
                end
            end
        end)
    end)
end

-- Attach Crouch Sensor ke killer
local DodgeAttached = {}
function W.AttachCrouchSensor(kChar)
    if not kChar or DodgeAttached[kChar] then return end
    DodgeAttached[kChar] = true
    local humanoid = kChar:FindFirstChild("Humanoid")
    if not humanoid then humanoid = kChar:WaitForChild("Humanoid", 5); if not humanoid then return end end
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then animator = humanoid:WaitForChild("Animator", 5); if not animator then return end end

    humanoid.ChildAdded:Connect(function(child)
        if child:IsA("Animator") then
            DodgeAttached[kChar] = nil
            W.AttachCrouchSensor(kChar)
        end
    end)
    kChar.AncestryChanged:Connect(function(_, parent)
        if not parent then DodgeAttached[kChar] = nil end
    end)

    animator.AnimationPlayed:Connect(function(track)
        local animId = track.Animation and track.Animation.AnimationId or ""
        local id = animId:match("%d+")
        if id == "80411309607666" and VD.AutoCrouch then
            local myChar = LocalPlayer.Character
            if IsDowned(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if myHRP and kHRP then
                local dist = (myHRP.Position - kHRP.Position).Magnitude
                if dist <= 40 then W.TriggerCrouch() end
            end
        end
    end)
end

-- Setup Crouch Player
local function SetupCrouchPlayer(p)
    if p == LocalPlayer then return end
    if TeamIs(p, "Killer") and p.Character then W.AttachCrouchSensor(p.Character) end
    p.CharacterAdded:Connect(function() 
        if TeamIs(p, "Killer") then W.AttachCrouchSensor(p.Character) end
    end)
    p:GetPropertyChangedSignal("Team"):Connect(function()
        if TeamIs(p, "Killer") and p.Character then W.AttachCrouchSensor(p.Character) end
    end)
end

for _, p in ipairs(Players:GetPlayers()) do SetupCrouchPlayer(p) end
Players.PlayerAdded:Connect(SetupCrouchPlayer)
task.spawn(function()
    while true do
        task.wait(5)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                W.AttachCrouchSensor(p.Character)
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════
--  PARRY V1 SYSTEM
-- ═══════════════════════════════════════════════════════════════════

-- Variables
VD.PARRY_Enabled     = VD.PARRY_Enabled or false
VD.PARRY_Aggressive  = VD.PARRY_Aggressive or false
VD.PARRY_Distance    = VD.PARRY_Distance or 10
VD.PARRY_ShowCircle  = VD.PARRY_ShowCircle or false
VD.PARRY_SilentParry = VD.PARRY_SilentParry or false

-- Parry State
local ParryState = {
    LastParry = 0,
    ActiveAttackers = {},
    CircleFolder = nil,
    CircleDashes = {},
    CircleRotCFs = {},
    CircleOffsets = {},
    CircleRadius = 0,
    CircleBuiltForDagger = false,
    CircleLastX = math.huge,
    CircleLastY = math.huge,
    CircleLastZ = math.huge,
    CircleSpawnTime = 0,
    CircleSpawnDuration = 0.55,
}
W.ParryState = ParryState

-- Parry Cooldown
local ParryCooldown = {
    OnCooldown = false,
    CooldownEnd = 0,
    WaitingForResult = false,
    WaitingStart = 0,
    WaitTimeout = 2.0,
    FallbackCooldown = 60,
    MaxCooldown = 90,
    LastFiredAt = 0,
    IsSilenced = false,
    JustFired = false,
    ManualDetect = false,
    ManualIgnoreWindow = 0.35,
}
W.ParryCooldown = ParryCooldown

-- Remote references
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

-- Killer Attack Animations list (untuk deteksi attack & lunge)
W.KillerAttackAnims = {
    ["78432063483146"] = "attack",   ["121216847022485"] = "attack",
    ["74968262036854"] = "attack",   ["132817836308238"] = "attack",
    ["82666958311998"] = "attack",   ["111920872708571"] = "attack",
    ["106871536134254"] = "attack",  ["109402730355822"] = "attack",
    ["130593238885843"] = "attack",  ["138720291317243"] = "attack",
    ["139369275981139"] = "attack",  ["133963973694098"] = "attack",
    ["78935059863801"] = "attack",
    ["118907603246885"] = "lungehold",["135002183282873"] = "lungehold",
    ["113255068724446"] = "lungehold",["129784271201071"] = "lungehold",
    ["105374834496520"] = "lungehold",["117070354890871"] = "lungehold",
    ["115244153053858"] = "lungehold",["110355011987939"] = "lungehold",
    ["117042998468241"] = "lungehold",["122812055447896"] = "lungehold",
}

-- Cooldown management
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
    if os.clock() >= ParryCooldown.CooldownEnd then
        ParryClearCooldown()
        return false
    end
    return true
end

-- Parry result listener
if parryResultRemote then
    parryResultRemote.OnClientEvent:Connect(function(success, cd)
        if not ParryCooldown.WaitingForResult and not ParryCooldown.JustFired then return end
        local c = tonumber(cd) or 0
        if success and c > 0 then
            ParryStartCooldown(math.min(c, ParryCooldown.MaxCooldown))
        else
            ParryStartCooldown(ParryCooldown.FallbackCooldown)
        end
    end)
end

-- Silenced tag hook
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

-- Dagger detection (cache 0.15s)
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
LocalPlayer.CharacterAdded:Connect(function()
    DaggerCache.Value = false; DaggerCache.LastCheck = 0
end)

-- Busy check
local ParryCheckAttrs = {
    "isVaulting","isSliding","isDroppingPallet","isRepairing",
    "isHealing","isUnhooking","isExiting"
}
local function ParryIsBusy()
    local cc = GetCharCache()
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
W.ParryIsBusy = ParryIsBusy

local function ParryIsLowHealth()
    local cc = GetCharCache()
    if not cc.Hum then return false end
    return cc.Hum.Health < cc.Hum.MaxHealth * 0.5
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
W.ParryCanFire = ParryCanFire

-- Parry execution methods
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
        local remote = ReplicatedStorage:FindFirstChild("Remotes")
        local items = remote and remote:FindFirstChild("Items")
        local dagger = items and items:FindFirstChild("Parrying Dagger")
        local parry = dagger and dagger:FindFirstChild("parry")
        if parry then
            pcall(function() parry:FireServer() end)
        end
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
    if parryFireRemote then
        return pcall(function() parryFireRemote:FireServer() end)
    end
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
    if isMobile then
        ParryExecuteMobile()
    else
        ParryExecutePC()
    end
end
W.ParryExecute = ParryExecute

-- Manual parry detection (klik kanan)
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

-- Hook mobile parry button
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

-- Hitbox getter
local function ParryGetHitboxPart(char)
    if not char then return nil end
    return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
end

-- Check & parry
local function ParryCheckAndParry(killerChar)
    if ParryIsOnCooldown() or ParryCooldown.WaitingForResult
        or ParryCooldown.IsSilenced or not ParryIsEquippedDagger() then return end
    local cc = GetCharCache()
    local myRoot = cc.UpperTorso or cc.Root
    local killerPart = ParryGetHitboxPart(killerChar)
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

    if dist <= (VD.PARRY_Distance or 10) then
        ParryExecute()
    end
end

-- Circle ESP destroy
local function ParryDestroyCircle()
    if ParryState.CircleFolder then
        pcall(function()
            if ParryState.CircleFolder.Parent then ParryState.CircleFolder:Destroy() end
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
getgenv()._FAZZ_DestroyParryCircle = ParryDestroyCircle

-- Circle ESP build
local function ParryBuildCircle(radius)
    ParryDestroyCircle()
    local folder = Instance.new("Folder")
    folder.Name = "FAZZParryCircle"
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

-- Circle ESP update
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

-- Anim type detection
local function ParryGetAnimType(track)
    if not track or not track.Animation then return nil end
    local animId = track.Animation.AnimationId or ""
    local numId = animId:match("%d+") or ""
    local name = string.lower(track.Animation.Name or "")
    local v = W.KillerAttackAnims[animId]
    if v then return v end
    if numId ~= "" then
        v = W.KillerAttackAnims[numId]
        if v then return v end
    end
    if string.find(name, "lunge", 1, true) or string.find(name, "charge", 1, true) then return "lungehold" end
    if string.find(name, "attack", 1, true) or string.find(name, "slash", 1, true)
        or string.find(name, "swing", 1, true) or string.find(name, "stab", 1, true)
        or string.find(name, "melee", 1, true) then return "attack" end
    return nil
end

-- Hook killer animator
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

-- Poll attacks
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

-- Cleanup attackers
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

-- Main logic update
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

-- Circle logic update
local function ParryUpdateCircleLogic()
    local char = LocalPlayer.Character
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

-- Heartbeat loop
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
end)

-- ═══════════════ SECTION 3 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 3 loaded — Crouch + Parry V1 ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 4] Auto Attack (Killer) + Auto Flee (Survivor)
--  + Auto Parry V2 System
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ AUTO ATTACK (KILLER) ═══════════════
VD.KILLER_AutoAttack         = VD.KILLER_AutoAttack or false
VD.KILLER_AutoAttackRange    = VD.KILLER_AutoAttackRange or 12
VD.KILLER_AutoAttackCooldown = VD.KILLER_AutoAttackCooldown or 0.15

local lastAutoAttack = 0

function W.KA_AutoAttack()
    if not VD.KILLER_AutoAttack then return end
    if GetRole() ~= "Killer" then return end
    local now = tick()
    if now - lastAutoAttack < (VD.KILLER_AutoAttackCooldown or 0.15) then return end
    local cc = GetCharCache()
    if not cc.Root then return end

    local closest, shortest = nil, VD.KILLER_AutoAttackRange or 12
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and TeamIs(plr, "Survivor") and plr.Character then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 35 then
                local d = (hrp.Position - cc.Root.Position).Magnitude
                if d <= shortest then
                    shortest = d
                    closest = plr
                end
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

-- ═══════════════ AUTO FLEE (SURVIVOR) ═══════════════
VD.SURV_AutoFlee         = VD.SURV_AutoFlee or false
VD.SURV_AutoFleeDist     = VD.SURV_AutoFleeDist or 40
VD.SURV_AutoFleeCooldown = VD.SURV_AutoFleeCooldown or 1.5

local lastAutoFlee = 0

function W.SURV_AutoFlee()
    if not VD.SURV_AutoFlee then return end
    if GetRole() ~= "Survivor" then return end
    local now = tick()
    if now - lastAutoFlee < (VD.SURV_AutoFleeCooldown or 1.5) then return end

    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not myRoot or not hum or hum.Health <= 0 then return end

    -- Cari killer terdekat
    local killerRoot = nil
    local nearest = math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and TeamIs(plr, "Killer") and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = (hrp.Position - myRoot.Position).Magnitude
                if d < nearest then
                    nearest = d
                    killerRoot = hrp
                end
            end
        end
    end

    if not killerRoot then return end
    if nearest > (VD.SURV_AutoFleeDist or 40) then return end

    lastAutoFlee = now

    -- Cari generator point terjauh dari killer
    local bestPt, bestDist = nil, 0
    local mf = Workspace:FindFirstChild("Map")
    if mf then
        for _, obj in ipairs(mf:GetDescendants()) do
            if obj:IsA("BasePart") and string.find(obj.Name, "^GeneratorPoint%d+$") then
                local d = (obj.Position - killerRoot.Position).Magnitude
                if d > bestDist then
                    bestDist = d
                    bestPt = obj
                end
            end
        end
    end

    if bestPt then
        pcall(function()
            myRoot.CFrame = bestPt.CFrame + Vector3.new(0, 5, 0)
        end)
        VD_Notify("Auto Flee", "Teleported away from killer!", 2)
    end
end

-- Loop Auto Attack + Auto Flee
task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(W.KA_AutoAttack)
        pcall(W.SURV_AutoFlee)
    end
end)

-- ═══════════════════════════════════════════════════════════════════
--  AUTO PARRY V2 SYSTEM
-- ═══════════════════════════════════════════════════════════════════

VD.FAZZ_ParryV2_Enabled     = VD.FAZZ_ParryV2_Enabled or false
VD.FAZZ_ParryV2_Aggressive  = VD.FAZZ_ParryV2_Aggressive or false
VD.FAZZ_ParryV2_Safety      = VD.FAZZ_ParryV2_Safety or false
VD.FAZZ_ParryV2_Distance    = VD.FAZZ_ParryV2_Distance or 6
VD.FAZZ_ParryV2_Face        = VD.FAZZ_ParryV2_Face or 0.7
VD.FAZZ_ParryV2_Circle      = VD.FAZZ_ParryV2_Circle ~= false
VD.FAZZ_ParryV2_IgnoredSkills = VD.FAZZ_ParryV2_IgnoredSkills or {}

-- Valid Parry Animation IDs
local V2_VALID_PARRY_IDS = {
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
    ["80411309607666"]  = "Abyssal S1",
}

-- V2 State
local V2_State = {
    Cooldown = false,
    CooldownThread = nil,
    lastParry = 0,
    Adornment = nil,
}
local V2_Attached = {}

local function V2_IsKiller(p)
    return p and p.Team and p.Team.Name == "Killer"
end

local function V2_IsDowned(char)
    return char and (char:GetAttribute("Knocked") == true or char:GetAttribute("IsHooked") == true)
end

local function V2_IsSafeToParry(char)
    if not VD.FAZZ_ParryV2_Safety then return true end
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

local function V2_PressRightClick()
    if not VirtualInputManager then return end
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
        task.wait()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
    end)
end

local function V2_TapMobileParryButton()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return end
    local survivorMob = playerGui:FindFirstChild("Survivor-mob")
    local parryBtn = survivorMob and survivorMob:FindFirstChild("Controls")
        and survivorMob.Controls:FindFirstChild("Gui-mob")
    if parryBtn and parryBtn.Visible then
        if type(firesignal) == "function" then
            pcall(function()
                firesignal(parryBtn.MouseButton1Down)
                task.wait(0.01)
                firesignal(parryBtn.MouseButton1Up)
            end)
        end
    else
        V2_PressRightClick()
    end
end

local function V2_ExecuteParry()
    if V2_State.Cooldown then return end
    V2_State.lastParry = tick()
    pcall(function()
        local parryRemote = ReplicatedStorage:FindFirstChild("Remotes")
            :FindFirstChild("Items")
            :FindFirstChild("Parrying Dagger")
            :FindFirstChild("parry")
        if parryRemote then
            for i = 1, 10 do
                parryRemote:FireServer()
            end
        end
        task.spawn(V2_TapMobileParryButton)
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
            V2_State.Cooldown = true
            if V2_State.CooldownThread then task.cancel(V2_State.CooldownThread) end
            V2_State.CooldownThread = task.delay(cdDur, function()
                V2_State.Cooldown = false
            end)
        end)
    end
end)

-- V2 Auto Crouch Trigger (untuk Abyssal S1 di V2)
local function V2_TriggerCrouch()
    local startT = tick()
    task.spawn(function()
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        pcall(function() char:SetAttribute("Crouching", true) end)
        pcall(function()
            ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true)
        end)
        pcall(function()
            ReplicatedStorage.Remotes.Chase.Runevent:FireServer(char, false)
        end)
        if humanoid then
            pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end)
        end
        pcall(function()
            local survMob = LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
            if survMob then
                local controls = survMob:FindFirstChild("Controls")
                if controls then
                    local crouchBtn = controls:FindFirstChild("crouch")
                    if crouchBtn and type(firesignal) == "function" then
                        firesignal(crouchBtn.MouseButton1Click)
                    end
                end
            end
        end)
        while tick() - startT < 1.2 do
            pcall(function()
                ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true)
            end)
            task.wait(0.1)
        end
        pcall(function() char:SetAttribute("Crouching", false) end)
        pcall(function()
            ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", false)
        end)
        if humanoid then
            pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end)
        end
        pcall(function()
            local survMob = LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
            if survMob then
                local controls = survMob:FindFirstChild("Controls")
                if controls then
                    local crouchBtn = controls:FindFirstChild("crouch")
                    if crouchBtn and type(firesignal) == "function" then
                        firesignal(crouchBtn.MouseButton1Click)
                    end
                end
            end
        end)
    end)
end

-- V2 Attach Parry Sensor
local function V2_AttachParrySensor(kChar)
    if not kChar or V2_Attached[kChar] then return end
    V2_Attached[kChar] = true
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
            V2_Attached[kChar] = nil
            V2_AttachParrySensor(kChar)
        end
    end)
    kChar.AncestryChanged:Connect(function(_, parent)
        if not parent then V2_Attached[kChar] = nil end
    end)

    animator.AnimationPlayed:Connect(function(track)
        local animId = track.Animation and track.Animation.AnimationId or ""
        local id = animId:match("%d+")
        local attackName = V2_VALID_PARRY_IDS[id]
        if not attackName then return end

        -- Auto Crouch (Abyssal S1)
        if id == "80411309607666" and VD.AutoCrouch then
            local myChar = LocalPlayer.Character
            if V2_IsDowned(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if myHRP and kHRP then
                if (myHRP.Position - kHRP.Position).Magnitude <= 40 then
                    V2_TriggerCrouch()
                end
            end
            return
        end

        if not VD.FAZZ_ParryV2_Enabled then return end
        if V2_State.Cooldown then return end
        if VD.FAZZ_ParryV2_IgnoredSkills and VD.FAZZ_ParryV2_IgnoredSkills[attackName] then return end

        local myChar = LocalPlayer.Character
        if V2_IsDowned(myChar) or not V2_IsSafeToParry(myChar) then return end
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local kHRP = kChar:FindFirstChild("HumanoidRootPart")
        if not myHRP or not kHRP then return end

        local startDistance = (myHRP.Position - kHRP.Position).Magnitude

        if VD.FAZZ_ParryV2_Aggressive then
            local aggressiveRadius = 12
            local detectionRadius = VD.FAZZ_ParryV2_Distance + 5
            if startDistance > detectionRadius then return end
            if startDistance <= aggressiveRadius then
                V2_ExecuteParry()
            else
                local tracker
                local startTime = os.clock()
                tracker = RunService.Heartbeat:Connect(function()
                    if os.clock() - startTime >= 1.5 or V2_State.Cooldown
                        or not myHRP or not kHRP or V2_IsDowned(myChar) then
                        if tracker then tracker:Disconnect() end
                        return
                    end
                    if (myHRP.Position - kHRP.Position).Magnitude <= aggressiveRadius then
                        V2_ExecuteParry()
                        if tracker then tracker:Disconnect() end
                    end
                end)
            end
        else
            if startDistance > VD.FAZZ_ParryV2_Distance then return end
            local myPosFlat = Vector3.new(myHRP.Position.X, 0, myHRP.Position.Z)
            local kPosFlat = Vector3.new(kHRP.Position.X, 0, kHRP.Position.Z)
            local flatDelta = myPosFlat - kPosFlat
            if flatDelta.Magnitude > 0 then
                local flatDirection = flatDelta.Unit
                local kLookFlat = Vector3.new(kHRP.CFrame.LookVector.X, 0, kHRP.CFrame.LookVector.Z).Unit
                if kLookFlat:Dot(flatDirection) < VD.FAZZ_ParryV2_Face then return end
            end
            V2_ExecuteParry()
        end
    end)
end

-- V2 Setup Players
local function V2_TryAttach(p)
    if p ~= LocalPlayer and V2_IsKiller(p) and p.Character then
        V2_AttachParrySensor(p.Character)
    end
end

local function V2_SetupPlayer(p)
    if p == LocalPlayer then return end
    p.CharacterAdded:Connect(function() V2_TryAttach(p) end)
    p:GetPropertyChangedSignal("Team"):Connect(function() V2_TryAttach(p) end)
    if p.Character then V2_TryAttach(p) end
end

for _, p in ipairs(Players:GetPlayers()) do V2_SetupPlayer(p) end
Players.PlayerAdded:Connect(V2_SetupPlayer)
task.spawn(function()
    while true do
        task.wait(5)
        for _, p in ipairs(Players:GetPlayers()) do V2_TryAttach(p) end
    end
end)

-- V2 Circle ESP
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if VD.FAZZ_ParryV2_Circle and VD.FAZZ_ParryV2_Enabled and hrp then
        if not V2_State.Adornment or V2_State.Adornment.Parent ~= hrp then
            if V2_State.Adornment then V2_State.Adornment:Destroy() end
            V2_State.Adornment = Instance.new("CylinderHandleAdornment")
            V2_State.Adornment.Name = "FAZZAutoParryV2Circle"
            V2_State.Adornment.Height = 0.05
            V2_State.Adornment.Transparency = 0.3
            V2_State.Adornment.Adornee = hrp
            V2_State.Adornment.Parent = hrp
            V2_State.Adornment.ZIndex = 0
            V2_State.Adornment.AlwaysOnTop = false
        end
        local cR = VD.FAZZ_ParryV2_Distance
        V2_State.Adornment.Radius = cR
        V2_State.Adornment.InnerRadius = math.max(0.1, cR - 0.15)
        V2_State.Adornment.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(90), 0, 0)
        if V2_State.Cooldown then
            V2_State.Adornment.Color3 = Color3.fromRGB(128, 128, 128)
        else
            V2_State.Adornment.Color3 = Color3.fromRGB(255, 255, 255)
        end
    elseif V2_State.Adornment then
        V2_State.Adornment:Destroy()
        V2_State.Adornment = nil
    end
end)

W.V2_State = V2_State

-- ═══════════════ SECTION 4 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 4 loaded — Auto Attack + Auto Flee + Parry V2 ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 5] Self Heal + Fake Perks + Perk GUI + Stun Indicator
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ SELF HEAL SYSTEM ═══════════════
W.InstantHealSelf = W.InstantHealSelf or false
W.AutoHealAll     = W.AutoHealAll or false

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
        task.wait(0.3)
        hookChar(c)
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
                if ha then
                    ha = false
                    W.doSelfHealFalse()
                end
                return
            end
            if ha then
                local ci = c:FindFirstChild("CheckInterractable")
                if ci and not ci:GetAttribute("isHealing") then
                    ha = false
                end
            end
            if not ha then
                ha = true
                W.doSelfHealTrue()
            end
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
                            if ci and not ci:GetAttribute("isHealing") then
                                ah[p] = nil
                            end
                        end
                        if not ah[p] then
                            ah[p] = true
                            W.doOthersHealTrue(p)
                        end
                    else
                        if ah[p] then
                            ah[p] = nil
                            W.doOthersHealFalse(p)
                        end
                    end
                else
                    if ah[p] then
                        ah[p] = nil
                        pcall(function() W.doOthersHealFalse(p) end)
                    end
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

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if W.InstantHealSelf then W.setInstantHealSelf(true) end
    if W.AutoHealAll then W.setAutoHealAll(true) end
end)

-- ═══════════════════════════════════════════════════════════════════
--  FAKE PERKS SYSTEM
-- ═══════════════════════════════════════════════════════════════════

W.FP = W.FP or {
    ActiveBuffs = {}, Conns = {}, LastBuffEnd = 0, CooldownTime = 5, HB = nil,
    FlowstateOn = false, QuickRecOn = false, PerfLandOn = false, AdrenalineOn = false,
}
local FP = W.FP

local function FP_Char() return LocalPlayer.Character end
local function FP_Hum()
    local c = FP_Char()
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function FP_GetTotal()
    local t = 0
    for _, b in pairs(FP.ActiveBuffs) do
        if tick() < b.endTime then t = t + b.amt end
    end
    return t
end

local function FP_Apply()
    local c = FP_Char()
    local tb = FP_GetTotal()
    local h = FP_Hum()
    if c then
        if tb > 0 then
            c:SetAttribute("speedboost", 1 + (tb / 14))
        else
            c:SetAttribute("speedboost", 1)
        end
    end
    if h and tb > 0 then h.WalkSpeed = 16 + tb end
end

-- Perk GUI
local PerkGUI = {
    Gui = nil, Container = nil, Layout = nil, Cards = {},
    PerkInfo = {
        Flowstate      = { Icon = "✦", Label = "FLOWSTATE" },
        QuickRecovery  = { Icon = "✚", Label = "QUICK RECOV" },
        PerfectLanding = { Icon = "▼", Label = "PERFECT LAND" },
        AdrenalineRush = { Icon = "♥", Label = "ADRENALINE" },
    }
}

local function PerkGUI_Create()
    if PerkGUI.Gui then return end
    local parent = LocalPlayer:FindFirstChild("PlayerGui")
    if gethui then
        local ok2, hui = pcall(gethui)
        if ok2 and hui then parent = hui end
    end
    if not parent then return end

    local gui = Instance.new("ScreenGui")
    gui.Name = "FAZZPerkGUI"
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

    local iconGrad = Instance.new("UIGradient", iconHolder)
    iconGrad.Rotation = 135
    iconGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 44)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 14, 18)),
    })

    local iconStroke = Instance.new("UIStroke", iconHolder)
    iconStroke.Color = Color3.fromRGB(255, 255, 255)
    iconStroke.Thickness = 1
    iconStroke.Transparency = 0.25

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
    nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLbl.TextStrokeTransparency = 0.5
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

-- Perk GUI update loop
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
                    if data.TimeLbl then
                        data.TimeLbl.Text = string.format("%.1fs", remain)
                    end
                end
            end
        end
    end
end)

-- Perk buffer
local function FP_EnsureHB()
    if FP.HB then return end
    FP.HB = RunService.Heartbeat:Connect(function()
        local exp = {}
        for n, b in pairs(FP.ActiveBuffs) do
            if tick() >= b.endTime then table.insert(exp, n) end
        end
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
    FP_Apply()
    FP_EnsureHB()
    VD_Notify("Fake Perks", "[" .. name .. "] Aktif! +" .. amt .. " Speed (" .. dur .. "s)", 3)
end

local function FP_Clean(name)
    if FP.Conns[name] then
        for _, c in ipairs(FP.Conns[name]) do pcall(function() c:Disconnect() end) end
        FP.Conns[name] = nil
    end
end
local function FP_Reg(name, conn)
    if not FP.Conns[name] then FP.Conns[name] = {} end
    table.insert(FP.Conns[name], conn)
end

-- Flowstate
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
            task.delay(0.5, function()
                if FP.FlowstateOn then FP_TryBuff("Flowstate", 5, 3) end
            end)
        end
        if w then
            local vb = w:FindFirstChild("Vaultbindable")
            if vb and vb:IsA("BindableEvent") then FP_Reg("Flowstate", vb.Event:Connect(onV)) end
        end
        if p then
            local sb = p:FindFirstChild("Slidebindable")
            if sb and sb:IsA("BindableEvent") then FP_Reg("Flowstate", sb.Event:Connect(onV)) end
        end
        local function hookChar(cc)
            if not cc then return end
            local cn = cc:GetAttributeChangedSignal("__VaultFireCount"):Connect(function()
                if FP.FlowstateOn then onV() end
            end)
            FP_Reg("Flowstate", cn)
        end
        hookChar(LocalPlayer.Character)
        FP_Reg("Flowstate", LocalPlayer.CharacterAdded:Connect(function(cc)
            if FP.FlowstateOn then
                cc:SetAttribute("Flowstate", true)
                hookChar(cc)
            end
        end))
    else
        FP_Clean("Flowstate")
        FP.ActiveBuffs["Flowstate"] = nil
        local c2 = FP_Char()
        if c2 then c2:SetAttribute("Flowstate", false) end
    end
end

-- Quick Recovery
function W.FP_SetupQuickRecovery(val)
    FP.QuickRecOn = val
    if val then
        local function onH()
            if not FP.QuickRecOn then return end
            FP_TryBuff("QuickRecovery", 6, 3)
        end
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local hf = r and r:FindFirstChild("Healing")
        if hf then
            local hd = hf:FindFirstChild("Healdone")
            if hd and hd:IsA("BindableEvent") then
                FP_Reg("QuickRecovery", hd.Event:Connect(onH))
            end
        end
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
        hookH(LocalPlayer.Character)
        FP_Reg("QuickRecovery", LocalPlayer.CharacterAdded:Connect(hookH))
    else
        FP_Clean("QuickRecovery")
        FP.ActiveBuffs["QuickRecovery"] = nil
    end
end

-- Perfect Landing
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
                if n == Enum.HumanoidStateType.Freefall then
                    wf = true; fs = tick()
                end
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

-- Adrenaline Rush
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
                if nh < lh and nh <= 50 and nh > 0 then
                    FP_TryBuff("AdrenalineRush", 4, 5)
                end
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

-- ═══════════════════════════════════════════════════════════════════
--  STUN INDICATOR SYSTEM
-- ═══════════════════════════════════════════════════════════════════

W.StunSounds = W.StunSounds or {
    ["Default"]      = "18843924331",
    ["Clash Royale"] = "114072050006157",
    ["Blash"]        = "89068385567682",
    ["Coin"]         = "75510526696824",
    ["Kururin Kuru"] = "119896940405402",
    ["Spongebob"]    = "6835794541",
    ["Fahhhh"]       = "123562480982353",
    ["Cave"]         = "3173566193",
    ["Aughhh"]       = "9095205664",
    ["Samsung"]      = "6879335951",
    ["iPhone"]       = "4203251375",
    ["Siren"]        = "130677853589923",
}

W.StunIndicator = W.StunIndicator or {
    Enabled = false,
    Cache = {},
    HeartbeatConn = nil,
    Range = 500,
    Icon = "rbxassetid://81633822407558",
    SoundEnabled = true,
    SoundId = "18843924331",
    SoundVolume = 1.5,
    SoundRange = 500,
    SelectedSound = "Default",
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
        snd.Name = "FAZZStunSound"
        snd.SoundId = "rbxassetid://" .. tostring(SInd_GetActiveSoundId())
        snd.Volume = SInd.SoundVolume or 1.5
        snd.PlaybackSpeed = 1
        snd.RollOffMaxDistance = SInd.SoundRange or 500
        snd.RollOffMinDistance = 10
        snd.RollOffMode = Enum.RollOffMode.InverseTapered
        snd.Parent = attachTo
        snd:Play()
        snd.Ended:Connect(function() pcall(function() snd:Destroy() end) end)
        task.delay(5, function()
            pcall(function()
                if snd and snd.Parent then snd:Destroy() end
            end)
        end)
    end)
end

local function SInd_Create(char)
    if SInd.Cache[char] then return SInd.Cache[char] end
    local head = char:FindFirstChild("Head")
    if not head then return nil end

    local bbg = Instance.new("BillboardGui")
    bbg.Name = "FAZZStunIndicator"
    bbg.Size = UDim2.fromOffset(140, 42)
    bbg.StudsOffset = Vector3.new(0, 3.0, 0)
    bbg.AlwaysOnTop = true
    bbg.LightInfluence = 0
    bbg.MaxDistance = 500
    bbg.Adornee = head
    bbg.Parent = char

    -- Pulse frames
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
    p1s.Color = Color3.fromRGB(255, 255, 255)
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
    p2s.Color = Color3.fromRGB(200, 200, 210)
    p2s.Thickness = 1.8
    p2s.Transparency = 0.4
    p2s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- Main card
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

    local bodyGrad = Instance.new("UIGradient")
    bodyGrad.Rotation = 135
    bodyGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 28)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 10)),
    })
    bodyGrad.Parent = main

    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Name = "MainStroke"
    mainStroke.Color = Color3.fromRGB(255, 255, 255)
    mainStroke.Thickness = 1.3
    mainStroke.Transparency = 0.15
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local iconHolder = Instance.new("Frame")
    iconHolder.Name = "IconHolder"
    iconHolder.Size = UDim2.fromOffset(24, 24)
    iconHolder.Position = UDim2.new(0, 5, 0.5, -12)
    iconHolder.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    iconHolder.BorderSizePixel = 0
    iconHolder.ZIndex = 3
    iconHolder.Parent = main
    Instance.new("UICorner", iconHolder).CornerRadius = UDim.new(1, 0)

    local iconGrad = Instance.new("UIGradient", iconHolder)
    iconGrad.Rotation = 135
    iconGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 44)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 14, 18)),
    })

    local iconStroke = Instance.new("UIStroke", iconHolder)
    iconStroke.Color = Color3.fromRGB(255, 255, 255)
    iconStroke.Thickness = 1
    iconStroke.Transparency = 0.25

    local starIcon = Instance.new("TextLabel")
    starIcon.Name = "StarIcon"
    starIcon.Size = UDim2.fromScale(1, 1)
    starIcon.BackgroundTransparency = 1
    starIcon.Font = Enum.Font.GothamBlack
    starIcon.Text = "★"
    starIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
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
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
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
    sub.TextColor3 = Color3.fromRGB(170, 170, 180)
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
    accent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
        task.delay(0.28, function()
            pcall(function() bbg:Destroy() end)
        end)
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
                            if not wasStunned then
                                SInd_PlaySound(char)
                                SInd_Create(char)
                            end
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
        if SInd.HeartbeatConn then
            SInd.HeartbeatConn:Disconnect()
            SInd.HeartbeatConn = nil
        end
        for _, data in pairs(SInd.Cache) do
            pcall(function()
                if data.StopAnim then data.StopAnim() end
                if data.Gui then data.Gui:Destroy() end
            end)
        end
        SInd.Cache = {}
    end
end

-- ═══════════════ SECTION 5 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 5 loaded — Self Heal + Fake Perks + Stun Indicator ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 6] Full ESP System + ESP Status
-- ═══════════════════════════════════════════════════════════════════

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
    Survivor  = Color3.fromRGB(0, 190, 255),
    Killer    = Color3.fromRGB(255, 0, 0),
    Generator = Color3.fromRGB(255, 255, 0),
    Window    = Color3.fromRGB(255, 255, 255),
    Pallet    = Color3.fromRGB(255, 165, 0),
    SCP       = Color3.fromRGB(0, 255, 0),
}

local FESP  = W.FullESP
local FESPS = W.FullESPStatus
local FESPC = W.FullESPColors

do
    -- ═══════════════ ESP CACHE ═══════════════
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
        CachedSCP[obj] = nil
        CachedGen[obj] = nil
        CachedPallet[obj] = nil
        CachedWindow[obj] = nil
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

    -- ═══════════════ ACTION DETECTION ═══════════════
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

    -- ═══════════════ STATUS ESP CREATE ═══════════════
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
            bb.Name = "FAZZStatusESP"
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
            nameLbl.TextYAlignment = Enum.TextYAlignment.Center
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

        -- Update elements
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

        -- Dynamic pill width
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

    -- ═══════════════ GENERATOR ESP ═══════════════
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
            local o = gen:FindFirstChild("FAZZGenESP"); if o then o:Destroy() end
            local h = gen:FindFirstChild("FAZZGenHighlight"); if h then h:Destroy() end
            return
        end
        local percent = GetGameValue(gen, "RepairProgress")
            or GetGameValue(gen, "Progress")
            or GetGameValue(gen, "ProgressRepair") or 0
        local bb = gen:FindFirstChild("FAZZGenESP")
        if percent >= 100 then
            if bb then bb:Destroy() end
            return
        end
        local cp = math.clamp(percent, 0, 100)
        local color = FESPC.Generator:Lerp(Color3.fromRGB(0, 255, 120), cp / 100)
        local text = string.format("[%.0f%%]", percent)
        if not bb then
            bb = Instance.new("BillboardGui")
            bb.Name = "FAZZGenESP"
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
            if lbl then
                lbl.Text = text
                lbl.TextColor3 = color
            end
        end
        local h = gen:FindFirstChild("FAZZGenHighlight") or Instance.new("Highlight")
        h.Name = "FAZZGenHighlight"
        h.Adornee = gen
        h.FillColor = color
        h.OutlineColor = color
        h.FillTransparency = 0.9
        h.OutlineTransparency = 0.3
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = gen
    end

    -- ═══════════════ MAP ESP (Pallet, SCP, Window) ═══════════════
    local function UpdateMapESP(obj, root)
        if not obj or not root or not obj.Parent then return end
        local pos
        if obj:IsA("Model") then
            if obj.PrimaryPart then
                pos = obj.PrimaryPart.Position
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

    -- ═══════════════ WINDOW ESP ═══════════════
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
                if p:IsA("BasePart") and p.Name ~= "VaultTrigger"
                    and p.Name ~= "inviswall" and p.Size.Magnitude > bestSize then
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
        box.Name = "FAZZWindowBox"
        box.Adornee = bottomPart
        box.Size = bottomPart.Size
        box.Color3 = FESPC.Window
        box.Transparency = 0.3
        box.AlwaysOnTop = true
        box.ZIndex = 5
        box.Parent = bottomPart

        local hl = Instance.new("Highlight")
        hl.Name = "FAZZWindowHighlight"
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

    -- ═══════════════ MAIN ESP LOOP ═══════════════
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
        for obj in pairs(CachedPallet) do UpdateMapESP(obj, root) end
        UpdateSCPEsp(root)

        if FESP.Window then
            if not _G.FAZZWindowScanned then
                _G.FAZZWindowScanned = true
                pcall(ScanAllWindows)
            end
        else
            _G.FAZZWindowScanned = false
            for model in pairs(WindowObjects) do
                RemoveWindowESP(model)
            end
        end
    end)
end

-- ═══════════════ SECTION 6 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 6 loaded — Full ESP System ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 7] Bypass System
--  Hidden Leap · Myers Grab · Slasher · Abyss · Jeff · Anti Blind
--  + Destroy Pallet + Infinite Lunge
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ DEFAULT VARIABLES ═══════════════
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

-- ═══════════════ HIDDEN LEAP BYPASS ═══════════════
getgenv().FAZZ_HiddenLeapThread = nil
function W.Bypass_HiddenLeap_Start()
    if getgenv().FAZZ_HiddenLeapThread then return end
    getgenv().FAZZ_HiddenLeapThread = task.spawn(function()
        local leapFunction, m2Function
        local function scanGC()
            pcall(function()
                for _, v in pairs(getgc(true)) do
                    if type(v) == "function" and islclosure(v) then
                        local info
                        pcall(function() info = debug.getinfo(v) end)
                        if info then
                            if info.name == "tryActivate" then
                                leapFunction = v
                            elseif info.name == "playM2Animation" then
                                m2Function = v
                            end
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
                if os.clock() - lastScan >= 2 then
                    lastScan = os.clock()
                    scanGC()
                end
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
        getgenv().FAZZ_HiddenLeapThread = nil
    end)
end

function W.Bypass_HiddenLeap_Stop() end
function W.Bypass_SetHiddenLeap(v)
    VD.KILLER_BypassLeap = v and true or false
    if VD.KILLER_BypassLeap then
        W.Bypass_HiddenLeap_Start()
    else
        W.Bypass_HiddenLeap_Stop()
    end
end

-- ═══════════════ MYERS INFINITE GRAB ═══════════════
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
                    player = player,
                    dist = (hrp.Position - myHRP.Position).Magnitude,
                    health = hum.Health
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
    pcall(function()
        ReplicatedStorage.Remotes.Killers.Stalker.grab:FireServer(target.Character)
    end)
end

function W.setMyersGrab(v)
    MyersGrabData.Enabled = v and true or false
    VD.KILLER_InfGrab = MyersGrabData.Enabled
    if getgenv().Gluto_MGrabBtn_UpdateVisual then
        pcall(getgenv().Gluto_MGrabBtn_UpdateVisual)
    end
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == MyersGrabData.HotkeyCode and MyersGrabData.Enabled then
        W.doMyersGrab()
    end
end)

-- ═══════════════ SLASHER BYPASS (LakeMist + Pursuit) ═══════════════
getgenv().FAZZ_SlasherThread = nil
function W.Bypass_Slasher_Start()
    if getgenv().FAZZ_SlasherThread then return end
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
    getgenv().FAZZ_SlasherThread = task.spawn(function()
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
                        if hasOffset and hasLinear and hasAction and hasTweenInfo and not hasPursuit then
                            toggleFunc = v
                        end
                        if hasPursuit and hasTweenInfo and hasAction and hasWalkSpeed then
                            pursuitHandler = v
                        end
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
                if os.clock() - lastScan >= 2 then
                    scanGCForSlasher()
                    lastScan = os.clock()
                end
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
        getgenv().FAZZ_SlasherThread = nil
    end)
end

function W.Bypass_Slasher_Stop()
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

function W.Bypass_SetLakeMist(v)
    VD.KILLER_InfLakeMist = v and true or false
    if VD.KILLER_InfLakeMist or VD.KILLER_InfPursuit then
        W.Bypass_Slasher_Start()
    else
        W.Bypass_Slasher_Stop()
    end
end

function W.Bypass_SetPursuit(v)
    VD.KILLER_InfPursuit = v and true or false
    if VD.KILLER_InfLakeMist or VD.KILLER_InfPursuit then
        W.Bypass_Slasher_Start()
    else
        W.Bypass_Slasher_Stop()
    end
end

-- ═══════════════ ABYSS BYPASS COOLDOWN ═══════════════
getgenv().FAZZ_AbyssConn = nil
getgenv().FAZZ_CorruptHandlerFunc = nil
function W.Bypass_Abyss_Start()
    if not getgenv().FAZZ_CorruptHandlerFunc then
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if type(v) == "function" and islclosure(v) then
                    local constants = debug.getconstants(v)
                    if table.find(constants, "corrupt") and table.find(constants, "Immobile") then
                        getgenv().FAZZ_CorruptHandlerFunc = v
                        break
                    end
                end
            end
        end)
    end
    if not getgenv().FAZZ_CorruptHandlerFunc then return end
    if getgenv().FAZZ_AbyssConn then
        getgenv().FAZZ_AbyssConn:Disconnect()
    end
    getgenv().FAZZ_AbyssConn = RunService.Heartbeat:Connect(function()
        if not VD.KILLER_BypassCooldown then return end
        if getgenv().FAZZ_CorruptHandlerFunc then
            local upvalues = debug.getupvalues(getgenv().FAZZ_CorruptHandlerFunc)
            for idx, val in pairs(upvalues) do
                if type(val) == "boolean" and val == false then
                    debug.setupvalue(getgenv().FAZZ_CorruptHandlerFunc, idx, true)
                end
            end
        end
    end)
end

function W.Bypass_Abyss_Stop()
    if getgenv().FAZZ_AbyssConn then
        getgenv().FAZZ_AbyssConn:Disconnect()
        getgenv().FAZZ_AbyssConn = nil
    end
end

function W.Bypass_SetAbyss(v)
    VD.KILLER_BypassCooldown = v and true or false
    if VD.KILLER_BypassCooldown then
        W.Bypass_Abyss_Start()
    else
        W.Bypass_Abyss_Stop()
    end
end

-- ═══════════════ JEFF INFINITE FRENZY ═══════════════
getgenv().FAZZ_JeffThread = nil
function W.Bypass_JeffFrenzy_Start()
    if getgenv().FAZZ_JeffThread then return end
    getgenv().FAZZ_JeffThread = task.spawn(function()
        while task.wait() do
            if not VD.KILLER_InfFrenzy then break end
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:GetAttribute("Frenzy") ~= true then
                    char:SetAttribute("Frenzy", true)
                end
            end)
        end
        getgenv().FAZZ_JeffThread = nil
    end)
end

function W.Bypass_JeffFrenzy_Stop()
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

function W.Bypass_SetJeffFrenzy(v)
    VD.KILLER_InfFrenzy = v and true or false
    if VD.KILLER_InfFrenzy then
        W.Bypass_JeffFrenzy_Start()
    else
        W.Bypass_JeffFrenzy_Stop()
    end
end

-- ═══════════════ BOOLEAN MATH FIX ═══════════════
function W.Bypass_FixBooleanMath()
    pcall(function()
        local b = true
        local mt = debug.getmetatable(b)
        if not mt then
            mt = {}
            debug.setmetatable(b, mt)
        end
        if setreadonly then setreadonly(mt, false) end
        mt.__div = function() return 0 end
        mt.__mul = function() return 0 end
        mt.__add = function() return 0 end
        mt.__sub = function() return 0 end
        if setreadonly then setreadonly(mt, true) end
    end)
    ForceNotify("Bypass", "Boolean failsafe applied", 2)
end

-- ═══════════════ ANTI BLIND FLASHLIGHT ═══════════════
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

-- ═══════════════ DESTROY PALLET ═══════════════
getgenv().FAZZ_IsBreakingPallet = false

function W.DestroyPallets_Run()
    if not VD.KILLER_DestroyPallets then return end
    if GetRole() ~= "Killer" then return end
    if getgenv().FAZZ_IsBreakingPallet then return end

    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not root then return end

    local stunned  = char:GetAttribute("IsStunned") or char:GetAttribute("isStunned")
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
            if d < minDist then
                minDist = d
                nearest = p
            end
        end
    end
    if not nearest then return end

    getgenv().FAZZ_IsBreakingPallet = true
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
        getgenv().FAZZ_IsBreakingPallet = false
    end)
end

-- ═══════════════ INFINITE LUNGE ═══════════════
local VD_OriginalLungeBoost = nil
function W.UpdateInfiniteLunge()
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
W.UpdateInfiniteLunge = W.UpdateInfiniteLunge

LocalPlayer.CharacterRemoving:Connect(function()
    VD_OriginalLungeBoost = nil
end)

-- ═══════════════ BYPASS UPDATE LOOP ═══════════════
task.spawn(function()
    while true do
        task.wait(0.12)
        if VD.KILLER_DestroyPallets then pcall(W.DestroyPallets_Run) end
        pcall(W.UpdateInfiniteLunge)
    end
end)

-- ═══════════════ SECTION 7 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 7 loaded — Bypass System ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 8] Silent Aim System
--  Veil V1 · Veil V2 · ToF · Flashlight · Flask · Spear Aimbot
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ DEFAULT VARIABLES ═══════════════
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

-- ═══════════════════════════════════════════════════════════════════
--  SILENT VEIL V1
-- ═══════════════════════════════════════════════════════════════════

local VeilState = { target = nil, lookVector = nil, velHistory = {} }
local VeilVisuals = {}

pcall(function()
    if typeof(Drawing) ~= "table" or not Drawing.new then return end
    local V = VeilVisuals
    local ACCENT = Color3.fromRGB(0, 170, 255)
    local BLACK  = Color3.fromRGB(0, 0, 0)
    local WHITE  = Color3.fromRGB(255, 255, 255)

    V.FOVOuterRing = Drawing.new("Circle")
    V.FOVOuterRing.Color = BLACK
    V.FOVOuterRing.Thickness = 3
    V.FOVOuterRing.Filled = false
    V.FOVOuterRing.Transparency = 0.4
    V.FOVOuterRing.Visible = false
    V.FOVOuterRing.NumSides = 90

    V.FOVMainRing = Drawing.new("Circle")
    V.FOVMainRing.Color = ACCENT
    V.FOVMainRing.Thickness = 1.6
    V.FOVMainRing.Filled = false
    V.FOVMainRing.Transparency = 0.85
    V.FOVMainRing.Visible = false
    V.FOVMainRing.NumSides = 90

    V.FOVInnerRing = Drawing.new("Circle")
    V.FOVInnerRing.Color = ACCENT
    V.FOVInnerRing.Thickness = 1
    V.FOVInnerRing.Filled = false
    V.FOVInnerRing.Transparency = 0.35
    V.FOVInnerRing.Visible = false
    V.FOVInnerRing.NumSides = 90

    V.FOVCrossLines = {}
    for i = 1, 4 do
        local line = Drawing.new("Line")
        line.Color = WHITE
        line.Thickness = 1.5
        line.Transparency = 0.9
        line.Visible = false
        V.FOVCrossLines[i] = line
    end
    V.FOVTicks = {}
    for i = 1, 4 do
        local line = Drawing.new("Line")
        line.Color = ACCENT
        line.Thickness = 2.2
        line.Transparency = 0.95
        line.Visible = false
        V.FOVTicks[i] = line
    end
    V.TrackerOuterRing = Drawing.new("Circle")
    V.TrackerOuterRing.Color = BLACK
    V.TrackerOuterRing.Thickness = 3
    V.TrackerOuterRing.Filled = false
    V.TrackerOuterRing.Transparency = 0.3
    V.TrackerOuterRing.NumSides = 40
    V.TrackerOuterRing.Visible = false

    V.TrackerMainRing = Drawing.new("Circle")
    V.TrackerMainRing.Color = ACCENT
    V.TrackerMainRing.Thickness = 1.6
    V.TrackerMainRing.Filled = false
    V.TrackerMainRing.Transparency = 0.9
    V.TrackerMainRing.NumSides = 40
    V.TrackerMainRing.Visible = false

    V.TrackerDotFill = Drawing.new("Circle")
    V.TrackerDotFill.Color = ACCENT
    V.TrackerDotFill.Thickness = 1
    V.TrackerDotFill.Filled = true
    V.TrackerDotFill.Transparency = 0.9
    V.TrackerDotFill.Radius = 3
    V.TrackerDotFill.NumSides = 20
    V.TrackerDotFill.Visible = false

    V.TrackerDotOutline = Drawing.new("Circle")
    V.TrackerDotOutline.Color = BLACK
    V.TrackerDotOutline.Thickness = 3
    V.TrackerDotOutline.Filled = false
    V.TrackerDotOutline.Transparency = 0.3
    V.TrackerDotOutline.Radius = 6
    V.TrackerDotOutline.NumSides = 20
    V.TrackerDotOutline.Visible = false

    V.TrackerLine = Drawing.new("Line")
    V.TrackerLine.Color = ACCENT
    V.TrackerLine.Thickness = 1.5
    V.TrackerLine.Transparency = 0.6
    V.TrackerLine.Visible = false
end)

local function Veil_IsSurvivor(p)
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

local function Veil_getCharVelocity(char)
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
    if V.FOVOuterRing then
        V.FOVOuterRing.Visible = false
        V.FOVOuterRing.Position = OFF
        V.FOVOuterRing.Radius = 0
        V.FOVOuterRing.Transparency = 1
    end
    if V.FOVMainRing then
        V.FOVMainRing.Visible = false
        V.FOVMainRing.Position = OFF
        V.FOVMainRing.Radius = 0
        V.FOVMainRing.Transparency = 1
    end
    if V.FOVInnerRing then
        V.FOVInnerRing.Visible = false
        V.FOVInnerRing.Position = OFF
        V.FOVInnerRing.Radius = 0
        V.FOVInnerRing.Transparency = 1
    end
    if V.FOVCrossLines then
        for _, s in ipairs(V.FOVCrossLines) do
            s.Visible = false
            s.From = OFF
            s.To = OFF
        end
    end
    if V.FOVTicks then
        for _, s in ipairs(V.FOVTicks) do
            s.Visible = false
            s.From = OFF
            s.To = OFF
        end
    end
end

local function Veil_HideTracker()
    local V = VeilVisuals
    local OFF = Vector2.new(-9999, -9999)
    if V.TrackerOuterRing then
        V.TrackerOuterRing.Visible = false
        V.TrackerOuterRing.Position = OFF
        V.TrackerOuterRing.Radius = 0
        V.TrackerOuterRing.Transparency = 1
    end
    if V.TrackerMainRing then
        V.TrackerMainRing.Visible = false
        V.TrackerMainRing.Position = OFF
        V.TrackerMainRing.Radius = 0
        V.TrackerMainRing.Transparency = 1
    end
    if V.TrackerDotFill then
        V.TrackerDotFill.Visible = false
        V.TrackerDotFill.Position = OFF
        V.TrackerDotFill.Radius = 0
    end
    if V.TrackerDotOutline then
        V.TrackerDotOutline.Visible = false
        V.TrackerDotOutline.Position = OFF
        V.TrackerDotOutline.Radius = 0
    end
    if V.TrackerLine then
        V.TrackerLine.Visible = false
        V.TrackerLine.From = OFF
        V.TrackerLine.To = OFF
    end
end

local function Veil_HideAll() Veil_HideFOV(); Veil_HideTracker() end

local function Veil_UpdateFOV(center)
    local V = VeilVisuals
    if not V.FOVOuterRing then return end
    local radius = VD.VeilFOV or 150
    local t = tick()
    local pulse = (math.sin(t * 3) + 1) * 0.5
    local slowPulse = (math.sin(t * 1.2) + 1) * 0.5
    V.FOVOuterRing.Position = center
    V.FOVOuterRing.Radius = radius + 2
    V.FOVOuterRing.Transparency = 0.3 + pulse * 0.15
    V.FOVOuterRing.Visible = true
    V.FOVMainRing.Position = center
    V.FOVMainRing.Radius = radius
    V.FOVMainRing.Transparency = 0.7 + pulse * 0.25
    V.FOVMainRing.Visible = true
    V.FOVInnerRing.Position = center
    V.FOVInnerRing.Radius = radius - 10
    V.FOVInnerRing.Transparency = 0.25 + slowPulse * 0.2
    V.FOVInnerRing.Visible = true
    local gap, armLen = 4, 12
    V.FOVCrossLines[1].From = Vector2.new(center.X, center.Y - gap)
    V.FOVCrossLines[1].To = Vector2.new(center.X, center.Y - gap - armLen)
    V.FOVCrossLines[1].Visible = true
    V.FOVCrossLines[2].From = Vector2.new(center.X, center.Y + gap)
    V.FOVCrossLines[2].To = Vector2.new(center.X, center.Y + gap + armLen)
    V.FOVCrossLines[2].Visible = true
    V.FOVCrossLines[3].From = Vector2.new(center.X - gap, center.Y)
    V.FOVCrossLines[3].To = Vector2.new(center.X - gap - armLen, center.Y)
    V.FOVCrossLines[3].Visible = true
    V.FOVCrossLines[4].From = Vector2.new(center.X + gap, center.Y)
    V.FOVCrossLines[4].To = Vector2.new(center.X + gap + armLen, center.Y)
    V.FOVCrossLines[4].Visible = true
    local tickLen = 9
    for i = 1, 4 do
        local angle = (i - 1) * math.pi / 2
        local dirX, dirY = math.cos(angle), math.sin(angle)
        V.FOVTicks[i].From = Vector2.new(center.X + dirX * radius, center.Y + dirY * radius)
        V.FOVTicks[i].To = Vector2.new(center.X + dirX * (radius - tickLen), center.Y + dirY * (radius - tickLen))
        V.FOVTicks[i].Visible = true
    end
end

local function Veil_UpdateTracker(targetPos, dist)
    local V = VeilVisuals
    if not V.TrackerOuterRing then return end
    local t = tick()
    local pulse = (math.sin(t * 4) + 1) * 0.5
    local baseRadius = math.clamp(1000 / math.max(dist, 1), 20, 48)
    V.TrackerOuterRing.Position = targetPos
    V.TrackerOuterRing.Radius = baseRadius + 3
    V.TrackerOuterRing.Transparency = 0.25 + pulse * 0.15
    V.TrackerOuterRing.Visible = true
    V.TrackerMainRing.Position = targetPos
    V.TrackerMainRing.Radius = baseRadius
    V.TrackerMainRing.Transparency = 0.75 + pulse * 0.2
    V.TrackerMainRing.Visible = true
    V.TrackerDotFill.Position = targetPos
    V.TrackerDotFill.Radius = 2.5 + pulse * 1.2
    V.TrackerDotFill.Transparency = 0.85 + pulse * 0.15
    V.TrackerDotFill.Visible = true
    V.TrackerDotOutline.Position = targetPos
    V.TrackerDotOutline.Radius = 5 + pulse * 1.5
    V.TrackerDotOutline.Transparency = 0.35
    V.TrackerDotOutline.Visible = true
end

local function Veil_UpdateAimbot()
    if GetRole() ~= "Killer" then
        VeilState.target = nil
        VeilState.lookVector = nil
        Veil_HideAll()
        return
    end
    local cam = Workspace.CurrentCamera
    if not cam then return end
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)

    if VD.VeilShowFOV and VD.VeilEnabled then
        Veil_UpdateFOV(center)
    else
        Veil_HideFOV()
    end

    if not VD.VeilEnabled then
        VeilState.target = nil
        VeilState.lookVector = nil
        Veil_HideTracker()
        return
    end

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local nearest, nearestPart = nil, nil
    local bestDist = VD.VeilFOV or 150
    local bestStudDist = VD.VeilMaxDist or 500

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and Veil_IsSurvivor(p) and p.Character then
            local pc = p.Character
            local isDown = pc:GetAttribute("Knocked") == true
                or pc:GetAttribute("HookProgressDepleting") == true
            if not isDown then
                local hum = pc:FindFirstChildOfClass("Humanoid")
                local targetPart = pc:FindFirstChild("UpperTorso")
                    or pc:FindFirstChild("Torso")
                    or pc:FindFirstChild("HumanoidRootPart")
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
                    windup = 0.10,
                    latency = 0.04,
                    maxlead = 25,
                    scale = VD.VeilLeadMultiplier or 1.4,
                }
            else
                prof = {
                    v0 = VD.VeilSpearSpeed or 165,
                    g = VD.VeilGravity or 103,
                    windup = 0.10,
                    latency = 0.04,
                    maxlead = 45,
                    scale = VD.VeilLeadMultiplier or 1.4,
                }
            end
            local aimPoint = tp
            if VD.VeilAutoPredict then
                local vel = Veil_getCharVelocity(nearest.Character)
                if vel.Magnitude > 0.5 then
                    local h0 = Vector3.new(dir.X, 0, dir.Z)
                    local _, tFlight = Veil_solvePitch(prof, h0.Magnitude, dir.Y)
                    local ping = 0.08
                    pcall(function()
                        ping = math.clamp(LocalPlayer:GetNetworkPing(), 0, 0.35)
                    end)
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

            if VD.VeilShowTracker then
                local sp, vis = cam:WorldToViewportPoint(tp)
                if vis and sp.Z > 0 then
                    local screenDist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if screenDist <= (VD.VeilFOV or 150) + 100 then
                        Veil_UpdateTracker(Vector2.new(sp.X, sp.Y), dist)
                        local bottomCenter = Vector2.new(center.X, cam.ViewportSize.Y)
                        local V = VeilVisuals
                        if V.TrackerLine then
                            V.TrackerLine.From = bottomCenter
                            V.TrackerLine.To = Vector2.new(sp.X, sp.Y)
                            V.TrackerLine.Visible = true
                        end
                    else
                        Veil_HideTracker()
                    end
                end
            else
                Veil_HideTracker()
            end
        end
    else
        VeilState.target = nil
        VeilState.lookVector = nil
        Veil_HideTracker()
    end
end

-- Veil Interceptor
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
            VeilHookState.remoteHooked = true
        end)
    end)
end
Veil_setupInterceptor()

W.VeilState = VeilState

-- ═══════════════════════════════════════════════════════════════════
--  SILENT VEIL V2
-- ═══════════════════════════════════════════════════════════════════

do
    local V2_Config = {}
    local V2_Camera = Workspace.CurrentCamera

    local V2_AimConfig = V2_AimConfig or {}
    V2_AimConfig.Aim_SilentVeil = false
    V2_AimConfig.Aim_SilentVeilV2 = false
    V2_AimConfig.Veil_ShowFOV = true
    V2_AimConfig.SpearSmart_enable = false
    V2_AimConfig.Veil_FOV = 150
    V2_AimConfig.SPEAR_Speed = 165
    V2_AimConfig.SPEAR_Gravity = workspace.Gravity * 0.5
    V2_AimConfig.SPEAR_MaxDist = 200
    V2_AimConfig.Veil_LeadMultiplier = 1.4
    V2_AimConfig.AIM_Auto = false
    V2_AimConfig.AIM_TargetPart = "Torso"

    local isChargingSpear = false
    local isAttackCooldown = false
    local isFiringSpear = false
    local currentTouchInput = nil

    local function IsVeilV2SilentOn()
        return V2_AimConfig.Aim_SilentVeil or V2_AimConfig.Aim_SilentVeilV2
    end

    local function getTargetPartObject(char)
        if V2_AimConfig.AIM_TargetPart == "Head" then
            return char:FindFirstChild("Head")
        elseif V2_AimConfig.AIM_TargetPart == "Root" or V2_AimConfig.AIM_TargetPart == "HumanoidRootPart" then
            return char:FindFirstChild("HumanoidRootPart")
        else
            return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart")
        end
    end

    local function getClosestSurvivorV2()
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local closestFovDist = V2_AimConfig.Veil_FOV
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
                    if dist3D <= V2_AimConfig.SPEAR_MaxDist then
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
    veilTargetHighlight.Name = "FAZZ_VeilV2Target"
    veilTargetHighlight.FillColor = Color3.fromRGB(150, 150, 150)
    veilTargetHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    veilTargetHighlight.FillTransparency = 0.5
    veilTargetHighlight.OutlineTransparency = 0

    local VeilV2TrackerEnabled = false
    local VeilV2TrackerLine = nil
    local currentVeilBillboard = nil

    local function setupVeilV2TrackerGui()
        if CoreGui:FindFirstChild("FAZZ_VeilV2Tracker") then return end
        local sg = Instance.new("ScreenGui")
        sg.Name = "FAZZ_VeilV2Tracker"
        sg.IgnoreGuiInset = true
        sg.ResetOnSpawn = false
        sg.Parent = CoreGui

        VeilV2TrackerLine = Instance.new("Frame")
        VeilV2TrackerLine.Name = "Line"
        VeilV2TrackerLine.AnchorPoint = Vector2.new(0.5, 0.5)
        VeilV2TrackerLine.BackgroundColor3 = Color3.fromRGB(138, 138, 138)
        VeilV2TrackerLine.BackgroundTransparency = 0.2
        VeilV2TrackerLine.BorderSizePixel = 0
        VeilV2TrackerLine.Visible = false
        VeilV2TrackerLine.Parent = sg
    end
    setupVeilV2TrackerGui()

    local VeilV2FOVFrame = nil
    if not CoreGui:FindFirstChild("FAZZ_VeilV2FOV") then
        local FOVGui = Instance.new("ScreenGui")
        FOVGui.Name = "FAZZ_VeilV2FOV"
        FOVGui.Parent = CoreGui
        FOVGui.ResetOnSpawn = false
        FOVGui.IgnoreGuiInset = true

        VeilV2FOVFrame = Instance.new("Frame")
        VeilV2FOVFrame.BackgroundTransparency = 1
        VeilV2FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        VeilV2FOVFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        VeilV2FOVFrame.Visible = false
        VeilV2FOVFrame.Parent = FOVGui
        Instance.new("UICorner", VeilV2FOVFrame).CornerRadius = UDim.new(1, 0)
        local VeilV2FOVStroke = Instance.new("UIStroke", VeilV2FOVFrame)
        VeilV2FOVStroke.Color = Color3.fromRGB(222, 222, 222)
        VeilV2FOVStroke.Thickness = 1.5
    end

    local SpearInterceptorHooked = false
    local function setupSpearInterceptor()
        if SpearInterceptorHooked then return end
        if not getrawmetatable or not setreadonly then
            warn("[FAZZ SpearInterceptor]: Executor tidak support.")
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
            if method == "FireServer" and not checkcaller() and typeof(self) == "Instance"
                and self.ClassName == "RemoteEvent" and self.Name == "Spearthrow" then
                if V2_AimConfig.Aim_SilentVeil and not V2_AimConfig.Aim_SilentVeilV2 then
                    return nil
                end
                if V2_AimConfig.Aim_SilentVeilV2 and not isFiringSpear then
                    local lookVec, speed, originPos = ...
                    speed = speed or V2_AimConfig.SPEAR_Speed or 165
                    local myChar = LocalPlayer.Character
                    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local startPart = myChar and (myChar:FindFirstChild("Head") or myHRP)
                    local isSpecial = myChar and myChar:GetAttribute("special") == true
                    if V2_Config.SpearSmart_enable then
                        speed = isSpecial and 165 or 142.5
                    else
                        speed = V2_AimConfig.SPEAR_Speed or 165
                    end
                    originPos = originPos or (V2_Config.SpearSmart_enable and myHRP and myHRP.Position) or (startPart and startPart.Position)
                    local bestDir = lookVec
                    local targetPart = getClosestSurvivorV2()
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
                        if V2_Config.SpearSmart_enable then
                            local leadMultiplier = V2_AimConfig.Veil_LeadMultiplier or 1.4
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
                            local gravity = V2_AimConfig.AIM_Auto and autoGravity or (V2_AimConfig.SPEAR_Gravity or workspace.Gravity * 0.5)
                            local drop = 0.5 * gravity * (timeToHit * timeToHit) * distanceMultiplier
                            local finalAimPos = predictedPos + Vector3.new(0, drop, 0)
                            bestDir = (finalAimPos - originPos).Unit
                        end
                    end
                    isFiringSpear = true
                    pcall(function()
                        if Spearthrow then
                            Spearthrow:FireServer(bestDir, speed, originPos)
                        else
                            self:FireServer(bestDir, speed, originPos)
                        end
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
            if IsVeilV2SilentOn() and isSpearMode then
                isChargingSpear = true
            end
        end
        if isTouch then
            if IsVeilV2SilentOn() and isSpearMode then
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
                                if pos.X >= absPos.X and pos.X <= (absPos.X + absSize.X)
                                    and pos.Y >= absPos.Y and pos.Y <= (absPos.Y + absSize.Y) then
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
                local startPos = V2_Config.SpearSmart_enable and myHRP.Position or startPart.Position
                local currentSpearSpeed = V2_Config.SpearSmart_enable and (isSpecial and 165 or 142.5) or V2_AimConfig.SPEAR_Speed
                local targetPart = getClosestSurvivorV2()
                local aimDirection
                if targetPart then
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
                    local distance = (targetPos - startPos).Magnitude
                    local timeToHit = distance / currentSpearSpeed
                    if V2_Config.SpearSmart_enable then
                        local leadMultiplier = V2_AimConfig.Veil_LeadMultiplier or 1.4
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
                        local gravity = V2_AimConfig.AIM_Auto and autoGravity or V2_AimConfig.SPEAR_Gravity
                        local dropCompensation = 0.5 * gravity * (timeToHit ^ 2) * distanceMultiplier
                        local finalAimPos = predictedPos + Vector3.new(0, dropCompensation, 0)
                        aimDirection = (finalAimPos - startPos).Unit
                    end
                else
                    aimDirection = V2_Camera.CFrame.LookVector
                end
                if V2_AimConfig.Aim_SilentVeil then
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

        if VeilV2FOVFrame then
            if IsVeilV2SilentOn() and V2_AimConfig.Veil_ShowFOV and isSpearMode then
                VeilV2FOVFrame.Visible = true
                VeilV2FOVFrame.Size = UDim2.new(0, V2_AimConfig.Veil_FOV * 2, 0, V2_AimConfig.Veil_FOV * 2)
            else
                VeilV2FOVFrame.Visible = false
            end
        end

        if IsVeilV2SilentOn() and isSpearMode and cam then
            local targetPart = getClosestSurvivorV2()
            if targetPart and targetPart.Parent then
                veilTargetHighlight.Parent = targetPart.Parent
                if VeilV2TrackerEnabled then
                    if not currentVeilBillboard or currentVeilBillboard.Parent ~= targetPart then
                        if currentVeilBillboard then currentVeilBillboard:Destroy() end
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "FAZZ_VeilV2TrackerBB"
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
                    if onScreen and sp.Z > 0 and VeilV2TrackerLine then
                        local vp = cam.ViewportSize
                        local fromX = vp.X * 0.5
                        local fromY = vp.Y
                        local toX, toY = sp.X, sp.Y
                        local dx, dy = toX - fromX, toY - fromY
                        local length = math.sqrt(dx * dx + dy * dy)
                        VeilV2TrackerLine.Size = UDim2.fromOffset(math.max(length, 1), 1)
                        VeilV2TrackerLine.Position = UDim2.fromOffset((fromX + toX) * 0.5, (fromY + toY) * 0.5)
                        VeilV2TrackerLine.Rotation = math.deg(math.atan2(dy, dx))
                        VeilV2TrackerLine.Visible = true
                    else
                        if VeilV2TrackerLine then VeilV2TrackerLine.Visible = false end
                    end
                else
                    if currentVeilBillboard then
                        currentVeilBillboard:Destroy()
                        currentVeilBillboard = nil
                    end
                    if VeilV2TrackerLine then VeilV2TrackerLine.Visible = false end
                end
            else
                veilTargetHighlight.Parent = nil
                if currentVeilBillboard then
                    currentVeilBillboard:Destroy()
                    currentVeilBillboard = nil
                end
                if VeilV2TrackerLine then VeilV2TrackerLine.Visible = false end
            end
        else
            veilTargetHighlight.Parent = nil
            if currentVeilBillboard then
                currentVeilBillboard:Destroy()
                currentVeilBillboard = nil
            end
            if VeilV2TrackerLine then VeilV2TrackerLine.Visible = false end
        end
    end)

    W.VeilV2_API = {
        AimConfig = V2_AimConfig,
        Config = V2_Config,
        getClosestSurvivor = getClosestSurvivorV2,
        IsVeilSilentOn = IsVeilV2SilentOn,
        setTracker = function(v) VeilV2TrackerEnabled = v end,
    }
end

-- ═══════════════════════════════════════════════════════════════════
--  SILENT AIM ToF (Twist of Fate)
-- ═══════════════════════════════════════════════════════════════════

VD.TOF_SilentAim    = VD.TOF_SilentAim or false
VD.TOF_TargetMode   = VD.TOF_TargetMode or "Killer"
VD.TOF_Key          = VD.TOF_Key or "Q"
VD.TOF_Laser        = VD.TOF_Laser ~= false
VD.TOF_WallCheck    = VD.TOF_WallCheck ~= false
VD.TOF_BlockKnocked = VD.TOF_BlockKnocked ~= false

local ToFState = {
    Connection = nil,
    LaserBeam = nil,
    TargetGui = nil,
    InputBegan = nil,
    InputEnded = nil,
    TouchInput = nil,
    IsAiming = false,
    SavedUIPos = UDim2.new(0.5, -100, 0, 110),
    SCPCache = {},
    SCPCacheTimer = 0,
}

local ToFKeyCodes = {
    None = nil, Q = Enum.KeyCode.Q, E = Enum.KeyCode.E, R = Enum.KeyCode.R,
    T = Enum.KeyCode.T, F = Enum.KeyCode.F, G = Enum.KeyCode.G, H = Enum.KeyCode.H,
    J = Enum.KeyCode.J, K = Enum.KeyCode.K, L = Enum.KeyCode.L, X = Enum.KeyCode.X,
    Z = Enum.KeyCode.Z,
}

local function ToF_IsDowned(c)
    if not c then return true end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local h = c:FindFirstChildOfClass("Humanoid")
    if h and h.Health <= 0 then return true end
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
        local g = ra:FindFirstChild("gun")
        if g then return g end
        local e = ra:FindFirstChild("EmperorGun")
        if e then return e end
    end
    return b
end

local function ToF_IsVisible(op, tp, tc)
    local d = tp - op
    local dist = d.Magnitude
    if dist < 0.1 then return true end
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
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
                    local r = c:FindFirstChild("HumanoidRootPart")
                    if r then table.insert(nt, r) end
                end
            end
        end
    end
    ToFState.SCPCache = nt
    ToFState.SCPCacheTimer = tick()
    return nt
end

local function ToF_GetTarget()
    local g = ToF_GetGun()
    local c = LocalPlayer.Character
    if not (g and c) then return nil, nil, nil, nil end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil, nil, nil, nil end
    local mp = hrp.Position
    local op
    if c:GetAttribute("IsCarried") then
        op = hrp.Position + (hrp.CFrame.LookVector * 2)
    else
        pcall(function()
            op = g:IsA("BasePart") and g.Position
                or (g:FindFirstChildOfClass("BasePart") and g:FindFirstChildOfClass("BasePart").Position)
        end)
        op = op or Vector3.new(mp.X, mp.Y + 1.5, mp.Z)
    end

    local function predict(t, tc)
        local tp = t.Position
        if VD.TOF_WallCheck and not ToF_IsVisible(op, tp, tc) then return nil, nil, nil, nil end
        local tv = Vector3.new(0, 0, 0)
        local rp = tc and (tc:FindFirstChild("HumanoidRootPart") or t)
        if rp then tv = rp.Velocity end
        local dr = tp - op
        local d = dr.Magnitude
        if d < 0.1 then return nil, nil, nil, nil end
        if d < 5 then return dr.Unit, g, op, tp end
        local tt = d / 400
        local pp = tp + (tv * tt)
        for _ = 1, 2 do
            local nd = (pp - op).Magnitude
            tt = nd / 400
            pp = tp + (tv * tt)
        end
        local fd = pp - op
        if fd.Magnitude < 0.1 then return nil, nil, nil, nil end
        return fd.Unit, g, op, pp
    end

    local mode = VD.TOF_TargetMode or "Killer"
    if mode == "Killer" then
        local bt, bc, bs = nil, nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                local t = p.Character:FindFirstChild("Torso")
                    or p.Character:FindFirstChild("UpperTorso")
                    or p.Character:FindFirstChild("HumanoidRootPart")
                if t then
                    local d = (mp - t.Position).Magnitude
                    if d < bs then bs = d; bt = t; bc = p.Character end
                end
            end
        end
        if not bt then return nil, nil, nil, nil end
        return predict(bt, bc)
    elseif mode == "Survivors" then
        local bt, bc, bd = nil, nil, -math.huge
        local cam = workspace.CurrentCamera
        local cl = cam.CFrame.LookVector
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TeamIs(p, "Survivor") and p.Character then
                local t = p.Character:FindFirstChild("Torso")
                    or p.Character:FindFirstChild("UpperTorso")
                    or p.Character:FindFirstChild("HumanoidRootPart")
                if t then
                    local dt = t.Position - cam.CFrame.Position
                    if dt.Magnitude > 0.1 then
                        local dot = cl:Dot(dt.Unit)
                        if dot > 0.5 and dot > bd then bd = dot; bt = t; bc = p.Character end
                    end
                end
            end
        end
        if not bt then return nil, nil, nil, nil end
        return predict(bt, bc)
    elseif mode == "Zombie" then
        local bp, bd = nil, -math.huge
        local cam = workspace.CurrentCamera
        local cl = cam.CFrame.LookVector
        for _, r in ipairs(ToF_GetSCPs()) do
            if r and r.Parent then
                local dt = r.Position - cam.CFrame.Position
                if dt.Magnitude > 0.1 then
                    local dot = cl:Dot(dt.Unit)
                    if dot > 0.5 and dot > bd then bd = dot; bp = r end
                end
            end
        end
        if not bp then return nil, nil, nil, nil end
        return predict(bp, bp.Parent)
    end
    return nil, nil, nil, nil
end

local function ToF_UpdateLaser(op, tp)
    if not ToFState.LaserBeam then
        local l = Instance.new("Part")
        l.Name = "FAZZToFLaser"
        l.Anchored = true
        l.CanCollide = false
        l.CanTouch = false
        l.CastShadow = false
        l.Material = Enum.Material.Neon
        l.Color = Color3.fromRGB(255, 255, 255)
        l.Parent = workspace
        ToFState.LaserBeam = l
    end
    local d = (tp - op).Magnitude
    ToFState.LaserBeam.Size = Vector3.new(0.05, 0.05, d)
    ToFState.LaserBeam.CFrame = CFrame.new((op + tp) / 2, tp)
    ToFState.LaserBeam.Transparency = 0
end

local function ToF_ClearLaser()
    if ToFState.LaserBeam then
        pcall(function() ToFState.LaserBeam:Destroy() end)
        ToFState.LaserBeam = nil
    end
end
W.ToF_ClearLaser = ToF_ClearLaser

local function ToF_GetMobileBtn()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    local sm = pg and pg:FindFirstChild("Survivor-mob")
    local ct = sm and sm:FindFirstChild("Controls")
    local gm = ct and ct:FindFirstChild("Gui-mob")
    if not gm then return nil end
    for _, n in ipairs({"attack", "Attack", "shoot", "Shoot", "fire", "Fire"}) do
        local b = gm:FindFirstChild(n, true)
        if b and b:IsA("GuiObject") then return b end
    end
    for _, o in ipairs(gm:GetDescendants()) do
        if o:IsA("GuiButton") and o.Visible then return o end
    end
    return gm:IsA("GuiObject") and gm or nil
end

local function ToF_IsTouchShoot(input)
    local sb = ToF_GetMobileBtn()
    if not (sb and sb.Visible) then return false end
    local p = input.Position
    local ap = sb.AbsolutePosition
    local az = sb.AbsoluteSize
    return p.X >= ap.X and p.X <= ap.X + az.X and p.Y >= ap.Y and p.Y <= ap.Y + az.Y
end

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

local function ToF_SetTargetMode(mode, notify)
    if mode ~= "Killer" and mode ~= "Survivors" and mode ~= "Zombie" then return end
    VD.TOF_TargetMode = mode
    if notify then VD_Notify("ToF Target", mode, 1) end
end
W.ToF_SetTargetMode = ToF_SetTargetMode

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
            if VD.TOF_Laser then
                ToF_UpdateLaser(op, tp)
            elseif ToFState.LaserBeam then
                ToFState.LaserBeam.Transparency = 1
            end
        elseif ToFState.LaserBeam then
            ToFState.LaserBeam.Transparency = 1
        end
    end)
end

local function ToF_StopConn()
    if ToFState.Connection then
        pcall(function() ToFState.Connection:Disconnect() end)
        ToFState.Connection = nil
    end
    ToFState.IsAiming = false
    ToF_ClearLaser()
end

local SetToFSilentAim
local function ToF_EnsureInputs()
    if not ToFState.InputBegan then
        ToFState.InputBegan = UserInputService.InputBegan:Connect(function(inp, gp)
            if gp then return end
            local k = ToFKeyCodes[VD.TOF_Key or "None"]
            if k and inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == k then
                SetToFSilentAim(not VD.TOF_SilentAim)
                return
            end
            if not VD.TOF_SilentAim then return end
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or (inp.UserInputType == Enum.UserInputType.Touch and ToF_IsTouchShoot(inp)) then
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
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or (inp.UserInputType == Enum.UserInputType.Touch and inp == ToFState.TouchInput) then
                local wa = ToFState.IsAiming
                ToFState.IsAiming = false
                if inp == ToFState.TouchInput then ToFState.TouchInput = nil end
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
    if VD.TOF_SilentAim then
        ToF_StartConn()
    else
        ToF_StopConn()
    end
end
W.SetToFSilentAim = SetToFSilentAim
ToF_EnsureInputs()

-- ═══════════════════════════════════════════════════════════════════
--  SILENT FLASHLIGHT
-- ═══════════════════════════════════════════════════════════════════

VD.FLASH_SilentAim  = VD.FLASH_SilentAim or false
VD.FLASH_Laser      = VD.FLASH_Laser ~= false
VD.FLASH_TargetPart = VD.FLASH_TargetPart or "Head"
VD.FLASH_Range      = VD.FLASH_Range or 120
VD.FLASH_Smooth     = VD.FLASH_Smooth or 0.35

do
    local FlashState = {
        Active = false, LaserBeam = nil, FlashlightPart = nil,
        Connection = nil, Hooked = false,
    }

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
    W.Flash_ClearLaser = Flash_ClearLaser

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
            l.Name = "FAZZFlashlightLaser"
            l.Anchored = true
            l.CanCollide = false
            l.CanTouch = false
            l.CanQuery = false
            l.CastShadow = false
            l.Material = Enum.Material.Neon
            l.Color = Color3.fromRGB(255, 255, 255)
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
        pcall(function()
            local c = LocalPlayer.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(tp.Position.X, hrp.Position.Y, tp.Position.Z))
            end
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

-- ═══════════════════════════════════════════════════════════════════
--  SILENT FLASK (The Cure)
-- ═══════════════════════════════════════════════════════════════════

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

do
    local FlaskState = {
        Target = nil, PredictedPos = nil, BeamPart = nil,
        AccentPart = nil, LandingRing = nil,
    }

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
            beam.Name = "FAZZFlaskBeam"
            beam.Anchored = true
            beam.CanCollide = false
            beam.CanTouch = false
            beam.CanQuery = false
            beam.CastShadow = false
            beam.Material = Enum.Material.Neon
            beam.Color = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255)
            beam.Transparency = 0.2
            beam.Parent = Workspace
            FlaskState.BeamPart = beam
        end
        if not FlaskState.AccentPart or not FlaskState.AccentPart.Parent then
            local accent = Instance.new("Part")
            accent.Name = "FAZZFlaskBeamAccent"
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
            ring.Name = "FAZZFlaskLanding"
            ring.Shape = Enum.PartType.Cylinder
            ring.Anchored = true
            ring.CanCollide = false
            ring.CanTouch = false
            ring.CanQuery = false
            ring.CastShadow = false
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
        if VD.FLASK_ShowBeam then
            pcall(Flask_UpdateBeam, hand.Position, landing)
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

    W.Flask_SetEnabled = function(v)
        VD.FLASK_SilentAim = v and true or false
        if not v then Flask_ClearVisuals() end
    end
    W.Flask_SetBeamColor   = function(c) VD.FLASK_BeamColor = c end
    W.Flask_SetAccentColor = function(c) VD.FLASK_AccentColor = c end
    W.Flask_SetSpeed       = function(v) VD.FLASK_Speed = tonumber(v) or 90 end
    W.Flask_SetGravity     = function(v) VD.FLASK_Gravity = tonumber(v) or 196 end
    W.Flask_SetLead        = function(v) VD.FLASK_LeadMult = tonumber(v) or 1.0 end
    W.Flask_SetRange       = function(v) VD.FLASK_Range = tonumber(v) or 200 end
end

-- ═══════════════════════════════════════════════════════════════════
--  SPEAR AIMBOT
-- ═══════════════════════════════════════════════════════════════════

VD.SPEAR_Aimbot = VD.SPEAR_Aimbot or false
VD.SPEAR_Gravity = VD.SPEAR_Gravity or 50
VD.SPEAR_Speed = VD.SPEAR_Speed or 100

do
    local SpearBtnData = {
        UI = nil, Button = nil, Active = true, DragLocked = false,
        Dragging = false, DragStart = nil, DragStartPos = nil,
        ManualTarget = nil, TargetIndex = 0,
        TargetLabel = nil, LeftArrow = nil, RightArrow = nil,
    }

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
            SpearBtnData.ManualTarget = nil
            SpearBtnData.TargetIndex = 0
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
        else
            nextIdx = 1
        end
        SpearBtnData.TargetIndex  = nextIdx
        SpearBtnData.ManualTarget = list[nextIdx]
        VD_Notify("Spear Aimbot", "Target: " .. SpearBtnData.ManualTarget.Name, 2)
        Spear_UpdateTargetLabel()
    end

    local function Spear_UpdateAim()
        if not VD.SPEAR_Aimbot then return end
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
            if valid then
                target = p
            else
                SpearBtnData.ManualTarget = nil
                Spear_UpdateTargetLabel()
            end
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
                    if cam then
                        cam.CFrame = CFrame.new(cam.CFrame.Position, aimPos)
                    end
                end
            end
        end
    end

    local function Spear_SetupButton()
        if SpearBtnData.UI then pcall(function() SpearBtnData.UI:Destroy() end) end
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if not pg then return end
        SpearBtnData.UI = Instance.new("ScreenGui")
        SpearBtnData.UI.Name = "FAZZSpearAimbotUI"
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
        local leftStk = Instance.new("UIStroke", leftArrow)
        leftStk.Color = Color3.fromRGB(255, 80, 80)
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
        rightArrow.TextColor3 = Color3.fromRGB(255, 150, 150)
        rightArrow.TextSize = 16
        rightArrow.Font = Enum.Font.GothamBold
        rightArrow.ZIndex = 10
        rightArrow.Parent = SpearBtnData.Button
        Instance.new("UICorner", rightArrow).CornerRadius = UDim.new(1, 0)
        local rightStk = Instance.new("UIStroke", rightArrow)
        rightStk.Color = Color3.fromRGB(255, 80, 80)
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
            if SpearBtnData.Dragging and not SpearBtnData.DragLocked
                and (input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch) then
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

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        if VD.SPEAR_Aimbot then pcall(Spear_SetupButton) end
    end)

    W.SpearAimbot_SetEnabled = function(v)
        VD.SPEAR_Aimbot = v and true or false
        if v then
            SpearBtnData.Active = true
            Spear_SetupButton()
        else
            if SpearBtnData.UI then pcall(function() SpearBtnData.UI:Destroy() end); SpearBtnData.UI = nil end
            SpearBtnData.Button = nil
        end
    end
    W.SpearAimbot_SetGravity = function(v) VD.SPEAR_Gravity = tonumber(v) or 50 end
    W.SpearAimbot_SetSpeed   = function(v) VD.SPEAR_Speed   = tonumber(v) or 100 end
    W.SpearAimbot_CycleTarget = Spear_CycleTarget
end

-- ═══════════════ VEIL UPDATE LOOP ═══════════════
RunService.RenderStepped:Connect(function() pcall(Veil_UpdateAimbot) end)

-- ═══════════════ SECTION 8 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 8 loaded — Silent Aim System ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 9] Utility Systems
--  Auto Skill Check · Swift Vault · Moonwalk · Generator · Self Unhook
--  · No Fall Damage · Next Map Prediction
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ AUTO SKILL CHECK ═══════════════
W.SkillCheck = W.SkillCheck or { Enabled = false, Mode = "Legit", Busy = false, Connection = nil }
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
    local pGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
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
        local cx, cy = p.X + (s.X / 2) + i.X, p.Y + (s.Y / 2) + i.Y
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
        local pGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
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
                task.wait(0.2)
                SC.Busy = false
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
                    task.wait(0.05)
                    SC.Busy = false
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

-- ═══════════════ SWIFT VAULT SYSTEM ═══════════════
VD.SURV_AutoVault  = VD.SURV_AutoVault  or false
VD.SURV_FastVault  = VD.SURV_FastVault  or false
VD.SURF_VaultSpeed = VD.SURF_VaultSpeed or 13

do
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

    -- Vault speed attribute
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

    -- Auto Vault main loop
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
                    if child.Name == "VaultTrigger" then
                        table.insert(allVTs, child)
                    end
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

    W.SwiftVault_SetEnabled = function(v)
        VD.SURV_AutoVault = v and true or false
        _vaultedWindows = {}
    end
    W.SwiftVaultV2_SetEnabled = function(v)
        VD.SURV_FastVault = v and true or false
        if not v then
            local char = LocalPlayer.Character
            if char then pcall(function() char:SetAttribute("vaultspeed", 1) end) end
        end
    end
    W.SwiftVault_SetSpeed = function(v) VD.SURF_VaultSpeed = tonumber(v) or 13 end
end

-- ═══════════════ MOONWALK ═══════════════
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
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
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
        if getgenv().Gluto_MoonwalkBtn_UpdateVisual then
            pcall(getgenv().Gluto_MoonwalkBtn_UpdateVisual)
        end
    end

    W.Moonwalk_SetEnabled = setMoonwalk
    W.Moonwalk_IsEnabled = function() return moonwalkEnabled end
    W.Moonwalk_SetSideSpeed = function(v) MOONWALK_SIDE_SPEED = v end
    W.Moonwalk_SetBackSpeed = function(v) MOONWALK_BACK_SPEED = v end
    W.Moonwalk_SetInterval  = function(v) MOONWALK_INTERVAL = v end

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.F8 then
            setMoonwalk(not moonwalkEnabled)
        end
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(2)
        if moonwalkEnabled then startMoonwalk() end
    end)
end

-- ═══════════════ BYPASS SELF UNHOOK ═══════════════
W.SelfUnhook = W.SelfUnhook or {
    Enabled = false, Following = false, FollowDuration = 30, FollowDistance = 20,
    MonitorConn = nil, TriggerCount = 0, _lastTrigger = 0, _cooldown = 3,
    _hookPos = nil, _hookCFrame = nil, _activeThread = nil, _wasHooked = false,
}
local SU = W.SelfUnhook

-- Generator helpers
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
    SU._lastTrigger = now
    SU.Following = true
    SU.TriggerCount = SU.TriggerCount + 1
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            SU._hookPos = hrp.Position
            SU._hookCFrame = hrp.CFrame
        end
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
            SU.Following = false
            SU._activeThread = nil
            return
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
                SU.Following = false
                SU._activeThread = nil
                VD_Notify("Bypass Self Unhook", "Udah lepas hook - STOP", 2)
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
                        pcall(function() r2.Velocity = Vector3.zero; r2.CFrame = SU._hookCFrame end)
                    elseif SU._hookPos then
                        pcall(function() r2.Velocity = Vector3.zero; r2.CFrame = CFrame.new(SU._hookPos + Vector3.new(0, 3, 0)) end)
                    end
                end
            end
        end
        SU.Following = false
        SU._activeThread = nil
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
    W.SU_Abort()
    SU._wasHooked = false
end

function W.SU_SetEnabled(v)
    SU.Enabled = v
    if v then W.SU_Start() else W.SU_Stop() end
end

-- ═══════════════ NO FALL DAMAGE ═══════════════
VD.NoFallDamage = VD.NoFallDamage or false

do
    local FallHookInstalled = false
    local function InstallNoFallHook()
        if FallHookInstalled then return end
        FallHookInstalled = true
        task.spawn(function()
            pcall(function()
                local mt = getrawmetatable and getrawmetatable(game)
                if not mt then return end
                local oldNamecall = mt.__namecall
                if setreadonly then setreadonly(mt, false) end
                mt.__namecall = newcclosure(function(self, ...)
                    if not checkcaller() and getgenv().VD.NoFallDamage then
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
    InstallNoFallHook()
end

-- ═══════════════ NEXT MAP PREDICTION ═══════════════
VD.NextMapPredict = VD.NextMapPredict or false

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
        gui.Name = "FAZZMapPredict"
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
        stroke.Color = Color3.fromRGB(0, 170, 255)
        stroke.Thickness = 1.5
        stroke.Transparency = 0.2
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 15)
        title.Position = UDim2.new(0, 0, 0, 5)
        title.BackgroundTransparency = 1
        title.Text = "NEXT MAP PREDICTION"
        title.TextColor3 = Color3.fromRGB(0, 170, 255)
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
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if not dragging then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch then
                local d = input.Position - dragStart
                frame.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + d.X,
                    startPos.Y.Scale, startPos.Y.Offset + d.Y
                )
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        MapPredictState.Gui = gui
    end

    local function Stop()
        MapPredictState.Enabled = false
        if MapPredictState.Thread then
            pcall(function() task.cancel(MapPredictState.Thread) end)
            MapPredictState.Thread = nil
        end
        if MapPredictState.Gui then
            pcall(function() MapPredictState.Gui:Destroy() end)
            MapPredictState.Gui = nil
        end
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

-- ═══════════════ MANUAL & AUTO GENERATOR ═══════════════
VD.ManualGen = VD.ManualGen or false
VD.AutoGen = VD.AutoGen or false
VD.KillerEscapeDist = VD.KillerEscapeDist or 30

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
                    if d < dist then
                        dist = d
                        best = hrp
                    end
                end
            end
        end
        return best, dist
    end

    local function PlayRepairAnim()
        local char = LocalPlayer.Character
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

    local function GetSafeNearestGenPoint()
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local bestPt, bestDist = nil, math.huge
        for _, gen in ipairs(W.GB_GetAllGenerators()) do
            if IsGenDone(gen) then continue end
            local genPivot
            pcall(function() genPivot = gen:GetPivot().Position end)
            if genPivot and IsKillerNearPos(genPivot, VD.KillerEscapeDist) then
                continue
            end
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

    local function StartManualThread()
        if ManualThread then pcall(function() task.cancel(ManualThread) end); ManualThread = nil end
        ManualThread = task.spawn(function()
            while VD.ManualGen do
                local myChar = LocalPlayer.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then
                    task.wait(0.2)
                    continue
                end
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
                local myChar = LocalPlayer.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then
                    task.wait(0.3)
                    continue
                end
                local _, kd = GetNearestKillerDist()
                if kd <= VD.KillerEscapeDist then
                    if AutoPoint then StopRepair(AutoPoint); AutoPoint = nil end
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
                        pcall(function() if RepairEvent then RepairEvent:FireServer(AutoPoint, true) end end)
                        PlayRepairAnim()
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

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if VD.ManualGen then StartManualThread() end
        if VD.AutoGen then StartAutoThread() end
    end)
end

-- ═══════════════ SECTION 9 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 9 loaded — Utility Systems ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 10] Killer Systems
--  Killer Abilities · Auto Hook · Select Masked · Dash Lock
--  · Counter Auto Parry · Aim Lock Hidden · Aim Lock Attack
--  · Auto Crouch Dodge (Killer side)
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ KILLER ABILITIES ═══════════════
VD.KA_AutoStalk       = VD.KA_AutoStalk       or false
VD.KA_AutoStalkRange  = VD.KA_AutoStalkRange  or 150
VD.KA_AutoKillAll     = VD.KA_AutoKillAll     or false
VD.KA_DropAllPallet   = VD.KA_DropAllPallet   or false
VD.KA_BlockAllVault   = VD.KA_BlockAllVault   or false

W.KillerAbilities = W.KillerAbilities or {
    AutoStalk = VD.KA_AutoStalk, AutoStalkRange = VD.KA_AutoStalkRange,
    AutoKillAll = VD.KA_AutoKillAll, DropAllPallet = VD.KA_DropAllPallet,
    BlockAllVault = VD.KA_BlockAllVault,
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
                if d <= shortest then
                    shortest = d
                    closest = plr
                end
            end
        end
    end
    return closest
end

-- ═══════════════ AUTO STALK ═══════════════
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

-- ═══════════════ AUTO KILL ALL ═══════════════
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

-- ═══════════════ DROP ALL PALLET ═══════════════
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

-- ═══════════════ BLOCK ALL VAULT ═══════════════
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

-- ═══════════════ UNBLOCK ALL VAULT ═══════════════
function W.KA_UnblockAllVaults()
    local VaultCompleteEvent = ReplicatedStorage:FindFirstChild("Remotes")
        and ReplicatedStorage.Remotes:FindFirstChild("Window")
        and ReplicatedStorage.Remotes.Window:FindFirstChild("VaultCompleteEvent")
    if not VaultCompleteEvent then return end
    local count = 0
    local map = workspace:FindFirstChild("Map")
    if not map then return end
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

-- Killer ability loop
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

-- ═══════════════ AUTO HOOK ═══════════════
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
                if hp then
                    table.insert(hooks, { model = obj, part = hp })
                end
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
            if d < closestDist then
                closestDist = d
                closest = h
            end
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

-- ═══════════════ SELECT MASKED POWER ═══════════════
W.Masked = W.Masked or {
    CurrentPower = "Cobra",
    Powers = {"Cobra", "Richter", "Brandon", "Rabbit", "Alex", "Tony"},
}
local Masked = W.Masked

function W.Masked_Activate()
    local ev = ReplicatedStorage:FindFirstChild("Remotes", true)
        and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
        and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
        and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Activatepower")
    if ev then
        pcall(function() ev:FireServer(Masked.CurrentPower) end)
        VD_Notify("Select Masked", "Activated: " .. Masked.CurrentPower, 2)
    else
        ForceNotify("Select Masked", "Activatepower remote not found", 2)
    end
end

function W.Masked_Deactivate()
    local ev = ReplicatedStorage:FindFirstChild("Remotes", true)
        and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
        and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
        and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Deactivatepower")
    if ev then
        pcall(function() ev:FireServer() end)
        VD_Notify("Select Masked", "Deactivated", 2)
    else
        ForceNotify("Select Masked", "Deactivatepower remote not found", 2)
    end
end

-- ═══════════════ AIM LOCK HIDDEN ═══════════════
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
                    local isEnemy = (myIsKiller and not theirIsKiller)
                        or ((not myIsKiller) and theirIsKiller)
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
        if input.UserInputType == Enum.UserInputType.Keyboard
            and input.KeyCode == AimLockHoldKey then AimLockAiming = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if not AimLockEnabled then return end
        if input.UserInputType == Enum.UserInputType.MouseButton2 then AimLockAiming = false end
        if input.UserInputType == Enum.UserInputType.Keyboard
            and input.KeyCode == AimLockHoldKey then AimLockAiming = false end
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
            local NAMES = {"attack", "shoot", "fire", "basicattack", "tembak",
                "hidden", "skill", "ability", "power", "skill1", "ability1", "gui-mob"}
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
                    if i.UserInputType == Enum.UserInputType.Touch
                        or i.UserInputType == Enum.UserInputType.MouseButton1 then
                        if AimLockEnabled then AimLockAiming = true end
                    end
                end))
                table.insert(AimLockMobileHooks, btn.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.Touch
                        or i.UserInputType == Enum.UserInputType.MouseButton1 then
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
            table.insert(AimLockMobileHooks, pGui.ChildAdded:Connect(function()
                task.wait(0.3)
                scan()
            end))
        end)
    end

    if UserInputService.TouchEnabled then AimLock_SetupMobile() end

    LocalPlayer.CharacterAdded:Connect(function()
        AimLockAiming = false
        if UserInputService.TouchEnabled then
            task.wait(2)
            AimLock_SetupMobile()
        end
    end)

    W.AimLockHidden_SetEnabled = function(state)
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
    W.AimLockHidden_SetKey = function(kc) AimLockHoldKey = kc end
end

-- ═══════════════ AIM LOCK ATTACK ═══════════════
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
        local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
        local closest, shortest = nil, AttackAim.FOV
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Team
                and string.find(string.lower(p.Team.Name), "survivor", 1, true)
                and p.Character then
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
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, pos), AttackAim.Strength)
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
                if p ~= LocalPlayer and p.Team
                    and string.find(string.lower(p.Team.Name), "survivor", 1, true) then
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

    W.CounterParry_SetEnabled = function(v)
        AntiAutoParryEnabled = v
        if v then VD_Notify("Counter Auto Parry", "Enabled", 2) end
    end
end

-- ═══════════════ DASH LOCK ═══════════════
VD.DashLockEnabled       = VD.DashLockEnabled      or false
VD.DashLockDuration      = VD.DashLockDuration     or 1.5
VD.DashLockSmoothness    = VD.DashLockSmoothness   or 0.3
VD.FreezeDuringDashLock  = VD.FreezeDuringDashLock or false
VD._DashLockActive       = false
VD._DashLockTarget       = nil
VD._DashLockConnection   = nil

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
                        if dist < targetDist then
                            targetDist = dist
                            target = root
                        end
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

    W.DashLock_SetActive = DashLock_SetActive
    W.DashLock_SetEnabled = function(v)
        VD.DashLockEnabled = v and true or false
        if not v then DashLock_SetActive(false) end
    end
end

-- ═══════════════ UNLOCK SKILL WHILE CARRYING ═══════════════
if not W.FAZZ_CarryConfig then
    W.FAZZ_CarryConfig = { Enabled = false, Hooked = false }
end
local CarryCfg = W.FAZZ_CarryConfig

local function SetupCarryHook()
    if CarryCfg.Hooked then return end
    if typeof(getrawmetatable) ~= "function" then return end
    pcall(function()
        local mt = getrawmetatable(game)
        if setreadonly then setreadonly(mt, false) end
        local oldNamecall = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if CarryCfg.Enabled and method == "GetAttribute" and not checkcaller() then
                if args[1] == "IsCarrying" then return false end
            end
            return oldNamecall(self, ...)
        end)
        if setreadonly then setreadonly(mt, true) end
        CarryCfg.Hooked = true
    end)
end

W.UnlockCarry_SetEnabled = function(v)
    CarryCfg.Enabled = v
    if v then
        SetupCarryHook()
        VD_Notify("Unlock Carry", "Enabled", 2)
    else
        VD_Notify("Unlock Carry", "Disabled", 2)
    end
end

-- ═══════════════ SECTION 10 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 10 loaded — Killer Systems ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 11] Misc Systems
--  Player Utility · Stun · Graphics · Camera DBD · Speed Boost
--  · Cursor · Emote · Fake Avatar · Korless · Header · Spectator
--  · Jerk Tool · Invisibility
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ PLAYER UTILITY ═══════════════
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

-- Skip End Screen
local function PU_ShowInstantResults()
    if not PU.SkipEndScreen then return end
    pcall(function()
        local cam = workspace.CurrentCamera
        if cam then
            cam.CameraType = Enum.CameraType.Custom
            cam.FieldOfView = 70
        end
        UserInputService.MouseIconEnabled = true
        LocalPlayer:SetAttribute("isspectating", true)
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if pg then
            local Results   = pg:FindFirstChild("Results")
            local EndScreen = pg:FindFirstChild("EndScreen")
            local Darkness  = pg:FindFirstChild("Darkness")
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
    for _, n in ipairs({"endscreencutscene", "cutsceneEnd", "cutsceneEnd2", "cutsceneEndwithownchar"}) do
        local ev = gf:FindFirstChild(n)
        if ev and ev:IsA("RemoteEvent") then
            table.insert(PU._Connections, ev.OnClientEvent:Connect(PU_ShowInstantResults))
        end
    end
end)

-- Shift Lock
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
        if flat.Magnitude > 0.001 then
            root.CFrame = CFrame.new(root.Position, root.Position + flat.Unit)
        end
    elseif PU._shiftLockWasActive then
        hum.AutoRotate = true
        PU._shiftLockWasActive = false
    end
end))

-- No Cutscene Hook
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

-- Hide Survivor Icon
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
                                PU._origIcons[il] = {
                                    Image = il.Image,
                                    ImageTransparency = il.ImageTransparency,
                                }
                            end
                            il.Image = "rbxassetid://92826170205694"
                            il.ImageTransparency = 0
                        end
                        if tl and tl:IsA("TextLabel") then
                            if not PU._origIcons[tl] then
                                PU._origIcons[tl] = {
                                    Text = tl.Text,
                                    TextTransparency = tl.TextTransparency,
                                }
                            end
                            tl.Text = "FAZZHUB"
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
W.PU_RestoreSurvivorIcon = PU_RestoreSurvivorIcon
table.insert(PU._Connections, RunService.Heartbeat:Connect(function()
    if PU.HideSurvivorIcon then PU_ApplyHideSurvivorIcon() end
end))

-- Ping/FPS HUD
local function PU_CreatePingFPS()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return end
    if PU._pingGui and PU._pingGui.Parent then return end
    local old = pg:FindFirstChild("FAZZPU_PingFPS")
    if old then old:Destroy() end
    local sg = Instance.new("ScreenGui")
    sg.Name = "FAZZPU_PingFPS"
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

-- Hide Name
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

-- Unlimited Zoom
table.insert(PU._Connections, RunService.RenderStepped:Connect(function()
    if not PU.UnlimitedZoom then return end
    if LocalPlayer.CameraMaxZoomDistance ~= math.huge then
        LocalPlayer.CameraMaxZoomDistance = math.huge
    end
    if LocalPlayer.CameraMinZoomDistance ~= 0 then
        LocalPlayer.CameraMinZoomDistance = 0
    end
end))

-- Noclip
table.insert(PU._Connections, RunService.Stepped:Connect(function()
    if not PU.Noclip then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            if PU._origCanCollide[d] == nil then
                PU._origCanCollide[d] = d.CanCollide
            end
            d.CanCollide = false
        end
    end
end))

local function PU_RestoreNoclip()
    for part, cc in pairs(PU._origCanCollide) do
        if part and part.Parent then
            pcall(function() part.CanCollide = cc end)
        end
    end
    PU._origCanCollide = {}
end
W.PU_RestoreNoclip = PU_RestoreNoclip

LocalPlayer.CharacterRemoving:Connect(function(char)
    if char == LocalPlayer.Character then PU._origCanCollide = {} end
end)

-- ═══════════════ CAMERA DBD ═══════════════
VD.CamDBD_SmoothEnabled = VD.CamDBD_SmoothEnabled or false
VD.CamDBD_SmoothSpeed   = VD.CamDBD_SmoothSpeed   or 5
VD.CamDBD_POVEnabled    = VD.CamDBD_POVEnabled    or false
VD.CamDBD_TargetPOV     = VD.CamDBD_TargetPOV     or 85
VD.CamDBD_POVSmooth     = VD.CamDBD_POVSmooth     or 9

do
    local CameraBindName = "FAZZ_CameraDBD_Smooth"
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
                PreviousPosition = nil
                PreviousRotation = nil
                return
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
                PreviousPosition = nil
                PreviousRotation = nil
            end
            if VD.CamDBD_POVEnabled then
                local povSpeed = tonumber(VD.CamDBD_POVSmooth) or 9
                local alpha = 1 - math.exp(-povSpeed * DeltaTime)
                local target = tonumber(VD.CamDBD_TargetPOV) or 85
                Camera.FieldOfView = Camera.FieldOfView + (target - Camera.FieldOfView) * alpha
            end
        end
    )

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        PreviousPosition = nil
        PreviousRotation = nil
    end)

    W.CamDBD_SetSmooth = function(v)
        VD.CamDBD_SmoothEnabled = v and true or false
        if not v then
            PreviousPosition = nil
            PreviousRotation = nil
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
end

-- ═══════════════ LOCK POV ═══════════════
local LockPOV = { Enabled = false, LockedFOV = 80, OriginalFOV = nil, Connection = nil }

local function LockPOV_Update()
    if not LockPOV.Enabled then return end
    local cam = Workspace.CurrentCamera
    if not cam then return end
    if math.abs(cam.FieldOfView - LockPOV.LockedFOV) > 0.1 then
        cam.FieldOfView = LockPOV.LockedFOV
    end
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

-- ═══════════════ SPEED BOOST ═══════════════
VD.SpeedBoostEnabled = VD.SpeedBoostEnabled or false
VD.SpeedBoostValue   = VD.SpeedBoostValue   or 30

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
                        if id and W.KillerAttackAnims["rbxassetid://" .. id] then return true end
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
        if SpeedBoostConnection then
            SpeedBoostConnection:Disconnect()
            SpeedBoostConnection = nil
        end
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

    W.SpeedBoost_SetValue = function(v)
        VD.SpeedBoostValue = tonumber(v) or 30
    end

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.8)
        if VD.SpeedBoostEnabled then W.SpeedBoost_SetEnabled(true) end
    end)
end

-- ═══════════════ CURSOR FEATURE ═══════════════
VD.CursorEnabled = VD.CursorEnabled or false

do
    local CursorThread = nil
    local savedOriginal = {
        MouseIconEnabled = nil,
        MouseBehavior = nil,
        AutoRotate = nil,
    }

    function W.Cursor_SetEnabled(v)
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
            if h then
                pcall(function() h.AutoRotate = savedOriginal.AutoRotate or true end)
            end
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

-- ═══════════════ STUN INDICATOR (handled di Section 5) ═══════════════
-- (Section 5 sudah handle Stun Indicator lengkap)

-- ═══════════════ FAZZ_FULLBRIGHT GRAPHICS ═══════════════
W.Graphics = W.Graphics or {
    Fullbright = false, NoShadow = false, LowGraphics = false,
    NoScreenEffects = false, CleanSky = false,
    ClockTimeEnabled = false, ClockTime = 14, Brightness = 2,
    UnlimitedZoom = false, MaxZoomDistance = 1000,
    FOVEnabled = false, FOV = 70, PotatoEnabled = false,
}
local G = W.Graphics
local original = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    GlobalShadows = Lighting.GlobalShadows,
    FOV = Workspace.CurrentCamera and Workspace.CurrentCamera.FieldOfView or 70,
}
local LastState = { Fullbright = nil, NoShadow = nil, Ambient = nil, Brightness = nil, ClockTime = nil }
local LastOptimize = { LowGraphics = nil, CleanSky = nil }
local DisabledEffects = {}
local ScreenEffectTypes = {
    "ColorCorrectionEffect", "DepthOfFieldEffect", "BlurEffect",
    "SunRaysEffect", "BloomEffect",
}

local function Graphics_Apply(force)
    if force or LastState.Fullbright ~= G.Fullbright then
        LastState.Fullbright = G.Fullbright
        if G.Fullbright then
            Lighting.Brightness     = 2
            Lighting.ClockTime      = 14
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
    local ambientChanged = LastState.Ambient ~= G.ClockTimeEnabled
        or LastState.Brightness ~= G.Brightness
        or LastState.ClockTime ~= G.ClockTime
    if force or ambientChanged then
        LastState.Ambient    = G.ClockTimeEnabled
        LastState.Brightness = G.Brightness
        LastState.ClockTime  = G.ClockTime
        if G.ClockTimeEnabled then
            Lighting.ClockTime  = G.ClockTime
            Lighting.Brightness = G.Brightness
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
            if G.LowGraphics then
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            else
                settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
            end
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
        LocalPlayer.CameraMaxZoomDistance = G.MaxZoomDistance
        LocalPlayer.CameraMinZoomDistance = 0
    else
        LocalPlayer.CameraMaxZoomDistance = 128
        LocalPlayer.CameraMinZoomDistance = 0.5
    end
end

local function Graphics_ApplyFOV()
    local cam = Workspace.CurrentCamera
    if not cam then return end
    if G.FOVEnabled then
        cam.FieldOfView = G.FOV
    else
        cam.FieldOfView = original.FOV
    end
end

W.Graphics_Apply             = Graphics_Apply
W.Graphics_ApplyOptimization = Graphics_ApplyOptimization
W.Graphics_ApplyNoScreenFx   = Graphics_ApplyNoScreenEffects
W.Graphics_ApplyZoom         = Graphics_ApplyZoom
W.Graphics_ApplyFOV          = Graphics_ApplyFOV

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
    if LocalPlayer.CameraMinZoomDistance ~= 0 then
        LocalPlayer.CameraMinZoomDistance = 0
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    Graphics_Apply(true)
    Graphics_ApplyOptimization(true)
    Graphics_ApplyNoScreenEffects()
    Graphics_ApplyZoom()
    Graphics_ApplyFOV()
end)

-- ═══════════════ POTATO MODE ═══════════════
do
    local Potato_Enabled = false
    local Potato_Busy = false
    local Potato_Changed = {}
    local Potato_Connections = {}
    local POTATO_BATCH_SIZE = 40
    local POTATO_BATCH_DELAY = 1

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
            pcall(function()
                Potato_Set(obj, "RenderFidelity", Enum.RenderFidelity.Performance)
            end)
        end
        if obj:IsA("Texture") or obj:IsA("Decal") then
            Potato_Set(obj, "Transparency", 1)
        end
        if obj:IsA("SurfaceAppearance") then
            pcall(function()
                Potato_Set(obj, "ColorMap", "")
                Potato_Set(obj, "MetalnessMap", "")
                Potato_Set(obj, "NormalMap", "")
                Potato_Set(obj, "RoughnessMap", "")
            end)
        end
        if obj:IsA("ParticleEmitter") then Potato_Set(obj, "Enabled", false) end
        if obj:IsA("Trail") then Potato_Set(obj, "Enabled", false) end
        if obj:IsA("Beam") then Potato_Set(obj, "Enabled", false) end
        if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            Potato_Set(obj, "Enabled", false)
        end
        if obj:IsA("Clouds") then
            Potato_Set(obj, "Cover", 0)
            Potato_Set(obj, "Density", 0)
        end
    end

    local function Potato_LowLighting()
        Potato_Set(Lighting, "GlobalShadows", false)
        Potato_Set(Lighting, "Brightness", 1)
        pcall(function()
            Potato_Set(Lighting, "EnvironmentDiffuseScale", 0)
            Potato_Set(Lighting, "EnvironmentSpecularScale", 0)
        end)
    end

    local function Potato_LowTerrain()
        local Terrain = Workspace:FindFirstChildOfClass("Terrain")
        if not Terrain then return end
        Potato_Set(Terrain, "Decoration", false)
        Potato_Set(Terrain, "WaterWaveSize", 0)
        Potato_Set(Terrain, "WaterWaveSpeed", 0)
        Potato_Set(Terrain, "WaterReflectance", 0)
    end

    local function Potato_ProcessMap()
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
            if index % (POTATO_BATCH_SIZE * 5) == 1 then
                task.wait(POTATO_BATCH_DELAY / 10)
            end
            index = finish + 1
        end
        Potato_Busy = false
    end

    local function Potato_StartNewObjectHandler()
        if Potato_Connections.NewObject then return end
        Potato_Connections.NewObject = Workspace.DescendantAdded:Connect(function(obj)
            if not Potato_Enabled then return end
            task.defer(function()
                if Potato_Enabled then Potato_Optimize(obj) end
            end)
        end)
    end

    local function Potato_Enable()
        if Potato_Enabled then return end
        Potato_Enabled = true
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)
        Potato_LowLighting()
        Potato_LowTerrain()
        Potato_StartNewObjectHandler()
        task.spawn(Potato_ProcessMap)
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
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end)
    end

    W.Potato_SetEnabled = function(v)
        G.PotatoEnabled = v and true or false
        if G.PotatoEnabled then Potato_Enable() else Potato_Disable() end
    end
    W.Potato_IsEnabled = function() return Potato_Enabled end
end

-- ═══════════════ EMOTE SYSTEM ═══════════════
W.EmoteSystem = W.EmoteSystem or {
    Enabled = false, CurrentTrack = nil, CurrentSound = nil,
    SelectedEmote = "Friday Night",
    Options = {
        "Friday Night", "WarCry", "24 Hour Cinderella", "Applause",
        "Arm Swing", "Backflip", "California Girls", "Christmas Spirit",
        "Floating Rest", "Ghoul", "Griddy", "Kyoufuu", "OnePlays", "Vulnerable",
    },
    Data = {
        ["Friday Night"]       = { Anim = "rbxassetid://83229063951016",  Sound = "rbxassetid://85355610204255" },
        ["WarCry"]             = { Anim = "rbxassetid://82600868380136",  Sound = "rbxassetid://120101930689931" },
        ["24 Hour Cinderella"] = { Anim = "rbxassetid://137195203725366", Sound = "rbxassetid://121099446613414" },
        ["Applause"]           = { Anim = "rbxassetid://96328361165090",  Sound = "rbxassetid://115490787020749" },
        ["Arm Swing"]          = { Anim = "rbxassetid://80552139463944",  Sound = "rbxassetid://74216458932348" },
        ["Backflip"]           = { Anim = "rbxassetid://74705617908505",  Sound = nil },
        ["California Girls"]   = { Anim = "rbxassetid://123552803041504", Sound = "rbxassetid://87899327891544" },
        ["Christmas Spirit"]   = { Anim = "rbxassetid://137859761110514", Sound = nil },
        ["Floating Rest"]      = { Anim = "rbxassetid://114593021219597", Sound = nil },
        ["Ghoul"]              = { Anim = "rbxassetid://130415594909401", Sound = "rbxassetid://123004139176580" },
        ["Griddy"]             = { Anim = "rbxassetid://75586690784894",  Sound = nil },
        ["Kyoufuu"]            = { Anim = "rbxassetid://137322894494527", Sound = "rbxassetid://129064643026442" },
        ["OnePlays"]           = { Anim = "rbxassetid://140625405103474", Sound = "rbxassetid://94749073728335" },
        ["Vulnerable"]         = { Anim = "rbxassetid://121773684313913", Sound = "rbxassetid://135265751184744" },
    },
}
local ES = W.EmoteSystem

function W.EmoteSystem_Stop()
    if ES.CurrentTrack then
        pcall(function() ES.CurrentTrack:Stop() end)
        ES.CurrentTrack = nil
    end
    if ES.CurrentSound then
        pcall(function() ES.CurrentSound:Destroy() end)
        ES.CurrentSound = nil
    end
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

-- ═══════════════ FAKE AVATAR ═══════════════
do
    local FakeAvatarEnabled = false
    local SelectedFakeAva = LocalPlayer.UserId

    local function LoadAppearanceIntoChar(appearance, character, head)
        local items = appearance:GetChildren()
        local function applyMesh(obj)
            if obj:IsA("CharacterMesh") or obj:IsA("BodyColors")
                or obj:IsA("Shirt") or obj:IsA("Pants") then
                local existing = character:FindFirstChild(obj.Name)
                if existing and existing.ClassName == obj.ClassName then
                    existing:Destroy()
                end
                obj:Clone().Parent = character
            end
        end
        for _, item in pairs(items) do
            if item:IsA("Folder") or item:IsA("Model") then
                for _, subItem in pairs(item:GetChildren()) do applyMesh(subItem) end
            else
                applyMesh(item)
            end
        end
        for _, item in pairs(items) do
            if item:IsA("SpecialMesh") and head then
                local targetMesh = head:FindFirstChildOfClass("SpecialMesh")
                    or Instance.new("SpecialMesh", head)
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
                            weld.Part0 = handle
                            weld.Part1 = targetAtt.Parent
                            weld.C0 = att.CFrame
                            weld.C1 = targetAtt.CFrame
                            weld.Parent = handle
                        end
                    end
                    handle.CanCollide = false
                    handle.Massless = true
                    clone.Parent = character
                end
            end
        end
    end

    local function ApplyFakeAvatar()
        local character = LocalPlayer.Character
        if not character or not SelectedFakeAva then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        task.spawn(function()
            local success, appearance = pcall(function()
                return game:GetService("Players"):GetCharacterAppearanceAsync(SelectedFakeAva)
            end)
            if not success or not appearance then
                warn("[FAZZ FakeAvatar] Gagal load data avatar!")
                return
            end
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
                m.MeshType = Enum.MeshType.Head
                m.Scale = Vector3.new(1, 1, 1)
            end
            local scaleDefaults = {
                BodyDepthScale = 1, BodyHeightScale = 1, BodyWidthScale = 1,
                HeadScale = 1, BodyTypeScale = 0, BodyProportionScale = 0,
            }
            for scaleName, val in pairs(scaleDefaults) do
                local s = humanoid:FindFirstChild(scaleName)
                if s then s.Value = val end
            end
            task.wait(0.1)
            LoadAppearanceIntoChar(appearance, character, head)
            pcall(function()
                local info = game:GetService("Players"):GetCharacterAppearanceInfoAsync(SelectedFakeAva)
                if head and info.assets then
                    for _, asset in pairs(info.assets) do
                        if asset.assetType.name == "Face" then
                            if head:FindFirstChild("face") then head.face:Destroy() end
                            local f = Instance.new("Decal", head)
                            f.Name = "face"
                            f.Texture = "rbxassetid://" .. asset.id
                            break
                        end
                    end
                end
            end)
        end)
    end

    local FakeAvatarIds = {
        ["Self Avatar"] = LocalPlayer.UserId,
        ["Random 1"] = 2888298851, ["Random 2"] = 10074747755,
        ["Random 3"] = 5209567453, ["Random 4"] = 8991982843,
        ["Random 5"] = 5796319029, ["Random 6"] = 9744452117,
        ["Random 7"] = 8476755006,
        ["WoozyNate"] = 146089324, ["Nicholas"] = 909635,
        ["yvlyf"] = 181751703, ["traevp"] = 471607078,
        ["J0LLY"] = 1073847038, ["LucashDev"] = 2525651744,
        ["CEOofIsaac"] = 63238912, ["Stealthy"] = 56602747,
        ["Wildes"] = 40397833, ["Talon"] = 75974130,
        ["Relukt"] = 65042011, ["Sammy"] = 2678001507,
        ["Diesel"] = 9123921576, ["S4ans03"] = 35439794,
        ["Aura"] = 2275806428, ["iJava"] = 276557820,
        ["White Guy"] = 8843268357, ["Purple King"] = 9070758608,
        ["Kachaaaa Gay"] = 8956318334, ["Mpruyyy"] = 8340163775,
    }

    W.FakeAvatar_SetId = function(id)
        SelectedFakeAva = id
        if FakeAvatarEnabled then ApplyFakeAvatar() end
    end

    W.FakeAvatar_SetByName = function(name)
        if not name or name == "" then
            ForceNotify("Fake Avatar", "Masukkan username dulu!", 2)
            return
        end
        local ok, userId = pcall(function()
            return game:GetService("Players"):GetUserIdFromNameAsync(name)
        end)
        if not ok or not userId then
            ForceNotify("Fake Avatar", "Username tidak ditemukan: " .. name, 2)
            return
        end
        SelectedFakeAva = userId
        ApplyFakeAvatar()
        ForceNotify("Fake Avatar", "Applied: @" .. name, 2)
    end

    W.FakeAvatar_SetEnabled = function(state)
        FakeAvatarEnabled = state
        if state then ApplyFakeAvatar() end
    end

    W.FakeAvatar_GetIds = function() return FakeAvatarIds end

    LocalPlayer.CharacterAdded:Connect(function()
        if FakeAvatarEnabled then
            task.wait(1)
            ApplyFakeAvatar()
        end
    end)
end

-- ═══════════════ FAKE KORLESS ═══════════════
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
                local old = char:FindFirstChild("FAZZKorlessHead")
                if old then old:Destroy() end
                local mesh = Instance.new("MeshPart")
                mesh.Name = "FAZZKorlessHead"
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
            local mesh = char:FindFirstChild("FAZZKorlessHead")
            if mesh then mesh:Destroy() end
            if char:FindFirstChild("Head") then char.Head.Transparency = 0 end
            if char:FindFirstChild("Right Leg") then char["Right Leg"].Transparency = 0 end
        end
        if KorlessMorph.Connection then
            KorlessMorph.Connection:Disconnect()
            KorlessMorph.Connection = nil
        end
    end

    W.Korless_SetEnabled = function(v)
        KorlessMorph.Enabled = v
        if v then
            ApplyKorless()
            VD_Notify("Korless Morph", "Enabled", 2)
        else
            RemoveKorless()
            VD_Notify("Korless Morph", "Disabled", 2)
        end
    end
end

-- ═══════════════ HEADER TITLE ═══════════════
do
    local HeaderEnabled = false
    local HeaderText = "FAZZHUB"
    local HeaderState = {
        Billboard = nil, TextLabel = nil, ShineLabel = nil,
        ShineGradient = nil, SizeConnection = nil,
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
        billboard.Name = "FAZZHeaderBillboard"
        billboard.Adornee = character.Head
        billboard.Size = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT)
        billboard.StudsOffset = Vector3.new(0, 1.5, 0)
        billboard.AlwaysOnTop = true
        billboard.LightInfluence = 0
        billboard.Parent = character
        HeaderState.Billboard = billboard

        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "BaseText"
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextStrokeTransparency = 0.5
        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
        textLabel.Text = HeaderText
        textLabel.ZIndex = 1
        textLabel.Parent = billboard
        HeaderState.TextLabel = textLabel

        local shineLabel = Instance.new("TextLabel")
        shineLabel.Name = "ShineText"
        shineLabel.Size = UDim2.new(1, 0, 1, 0)
        shineLabel.BackgroundTransparency = 1
        shineLabel.TextScaled = true
        shineLabel.Font = Enum.Font.GothamBold
        shineLabel.TextStrokeTransparency = 1
        shineLabel.Text = HeaderText
        shineLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        shineLabel.ZIndex = 2
        shineLabel.Parent = billboard
        HeaderState.ShineLabel = shineLabel

        local shineGradient = Instance.new("UIGradient")
        shineGradient.Name = "ShineGradient"
        shineGradient.Rotation = 20
        shineGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0.00, 1),
            NumberSequenceKeypoint.new(0.30, 1),
            NumberSequenceKeypoint.new(0.42, 0),
            NumberSequenceKeypoint.new(0.58, 0),
            NumberSequenceKeypoint.new(0.70, 1),
            NumberSequenceKeypoint.new(1.00, 1),
        })
        shineGradient.Offset = Vector2.new(-1, 0)
        shineGradient.Parent = shineLabel
        HeaderState.ShineGradient = shineGradient

        if HeaderState.SizeConnection then HeaderState.SizeConnection:Disconnect() end
        HeaderState.SizeConnection = RunService.RenderStepped:Connect(function()
            if not billboard or not billboard.Parent then
                HeaderState.SizeConnection:Disconnect()
                return
            end
            local head = character:FindFirstChild("Head")
            if not head then return end
            local dist = (Workspace.CurrentCamera.CFrame.Position - head.Position).Magnitude
            local scaleFactor = math.clamp(BASE_DISTANCE / dist, MIN_SCALE, MAX_SCALE)
            billboard.Size = UDim2.new(0, BASE_WIDTH * scaleFactor, 0, BASE_HEIGHT * scaleFactor)
        end)

        task.spawn(function()
            while shineLabel and shineLabel.Parent and shineGradient and shineGradient.Parent do
                shineGradient.Offset = Vector2.new(-1, 0)
                local tween = TweenService:Create(
                    shineGradient,
                    TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    { Offset = Vector2.new(1, 0) }
                )
                tween:Play()
                tween.Completed:Wait()
                task.wait(2)
            end
        end)
    end

    local function Header_UpdateText(text)
        HeaderText = text or "FAZZHUB"
        if HeaderState.TextLabel then HeaderState.TextLabel.Text = HeaderText end
        if HeaderState.ShineLabel then HeaderState.ShineLabel.Text = HeaderText end
    end

    local function Header_Toggle(enabled)
        if enabled then
            Header_Create()
        else
            if HeaderState.SizeConnection then
                HeaderState.SizeConnection:Disconnect()
                HeaderState.SizeConnection = nil
            end
            if HeaderState.Billboard then HeaderState.Billboard:Destroy() end
            HeaderState.Billboard = nil
            HeaderState.TextLabel = nil
            HeaderState.ShineLabel = nil
            HeaderState.ShineGradient = nil
        end
    end

    W.Header_UpdateText = Header_UpdateText
    W.Header_Toggle = Header_Toggle
    W.Header_SetColor = function(c)
        if HeaderState.TextLabel then HeaderState.TextLabel.TextColor3 = c end
    end

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if HeaderEnabled then Header_Toggle(true) end
    end)
end

-- ═══════════════ SPECTATOR COUNTER ═══════════════
do
    local SpecEnabled = false
    local SpecGui = nil
    local SpecLabel = nil
    local SpecThread = nil
    local SpecExpanded = true

    local function Spec_CreateUI()
        if SpecGui then SpecGui:Destroy(); SpecGui = nil end
        SpecGui = Instance.new("ScreenGui")
        SpecGui.Name = "FAZZSpectatorCounter"
        SpecGui.ResetOnSpawn = false
        SpecGui.IgnoreGuiInset = true
        SpecGui.Parent = CoreGui

        local mainFrame = Instance.new("Frame", SpecGui)
        mainFrame.Name = "MainBox"
        mainFrame.AnchorPoint = Vector2.new(0.5, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.42, 0)
        mainFrame.Size = UDim2.new(0, 145, 0, 52)
        mainFrame.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        mainFrame.BackgroundTransparency = 0.1
        mainFrame.BorderSizePixel = 0
        mainFrame.Active = true
        Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)

        local topBar = Instance.new("Frame", mainFrame)
        topBar.Name = "TopBar"
        topBar.Size = UDim2.new(1, 0, 0, 4)
        topBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        topBar.BorderSizePixel = 0
        Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 6)

        local header = Instance.new("Frame", mainFrame)
        header.Name = "Header"
        header.Size = UDim2.new(1, 0, 0, 18)
        header.Position = UDim2.new(0, 0, 0, 4)
        header.BackgroundTransparency = 1
        header.Active = true

        local title = Instance.new("TextLabel", header)
        title.Name = "Title"
        title.Size = UDim2.new(1, -20, 1, 0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.Text = "Spectators"
        title.TextColor3 = Color3.fromRGB(200, 230, 255)
        title.TextSize = 10
        title.TextXAlignment = Enum.TextXAlignment.Center

        local minBtn = Instance.new("TextButton", header)
        minBtn.Name = "MinBtn"
        minBtn.Size = UDim2.new(0, 18, 0, 18)
        minBtn.Position = UDim2.new(1, -19, 0, 0)
        minBtn.BackgroundTransparency = 1
        minBtn.Text = "−"
        minBtn.TextColor3 = Color3.fromRGB(200, 230, 255)
        minBtn.Font = Enum.Font.GothamBold
        minBtn.TextSize = 13
        minBtn.AutoButtonColor = false

        local divider = Instance.new("Frame", mainFrame)
        divider.Name = "Divider"
        divider.Size = UDim2.new(1, -12, 0, 1)
        divider.Position = UDim2.new(0, 6, 0, 23)
        divider.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        divider.BackgroundTransparency = 0.7
        divider.BorderSizePixel = 0

        local body = Instance.new("Frame", mainFrame)
        body.Name = "Body"
        body.Size = UDim2.new(1, 0, 1, -25)
        body.Position = UDim2.new(0, 0, 0, 25)
        body.BackgroundTransparency = 1
        body.ClipsDescendants = true

        local bodyLayout = Instance.new("UIListLayout", body)
        bodyLayout.FillDirection = Enum.FillDirection.Horizontal
        bodyLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        bodyLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        bodyLayout.Padding = UDim.new(0, 5)

        local eye = Instance.new("ImageLabel", body)
        eye.Name = "EyeIcon"
        eye.Size = UDim2.new(0, 13, 0, 13)
        eye.BackgroundTransparency = 1
        eye.Image = "rbxassetid://13321848320"
        eye.ImageColor3 = Color3.fromRGB(0, 170, 255)
        eye.LayoutOrder = 1

        SpecLabel = Instance.new("TextLabel", body)
        SpecLabel.Name = "CountLabel"
        SpecLabel.BackgroundTransparency = 1
        SpecLabel.Font = Enum.Font.GothamMedium
        SpecLabel.Text = "No spectators"
        SpecLabel.TextColor3 = Color3.fromRGB(200, 230, 255)
        SpecLabel.TextSize = 10
        SpecLabel.AutomaticSize = Enum.AutomaticSize.X
        SpecLabel.LayoutOrder = 2

        local function setExpanded(state)
            SpecExpanded = state
            if state then
                mainFrame.Size = UDim2.new(0, 145, 0, 52)
                divider.Visible = true
                body.Visible = true
                minBtn.Text = "−"
            else
                mainFrame.Size = UDim2.new(0, 145, 0, 22)
                divider.Visible = false
                body.Visible = false
                minBtn.Text = "+"
            end
        end
        minBtn.MouseButton1Click:Connect(function() setExpanded(not SpecExpanded) end)
        setExpanded(true)

        local dragging, dragStart, startPos = false, nil, nil
        mainFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if not dragging then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch then
                local delta = input.Position - dragStart
                mainFrame.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    local function Spec_Update()
        if not SpecEnabled or not SpecLabel then return end
        local count = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Team and p.Team.Name == "Spectator" then count = count + 1 end
        end
        if count == 0 then
            SpecLabel.Text = "No spectators"
            SpecLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        else
            SpecLabel.Text = count .. " spectators"
            SpecLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
        end
    end

    W.Spectator_SetEnabled = function(state)
        SpecEnabled = state
        if SpecThread then task.cancel(SpecThread); SpecThread = nil end
        if state then
            Spec_CreateUI()
            Spec_Update()
            SpecThread = task.spawn(function()
                while SpecEnabled do
                    Spec_Update()
                    task.wait(1.2)
                end
            end)
        else
            if SpecGui then
                SpecGui:Destroy()
                SpecGui = nil
                SpecLabel = nil
            end
        end
    end
end

-- ═══════════════ JERK OFF TOOL ═══════════════
W.JerkTool = W.JerkTool or { Enabled = false, ToolName = "Jerk Off" }

do
    local JerkTool = W.JerkTool
    local currentJerkTool = nil
    local jerkRunning = false

    function W.JerkOff_Destroy()
        if currentJerkTool then
            pcall(function() currentJerkTool:Destroy() end)
            currentJerkTool = nil
        end
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
            if track then
                pcall(function() track:Stop() end)
                track = nil
            end
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
                    anim.AnimationId = not isR15 and "rbxassetid://72042024"
                        or "rbxassetid://698251653"
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
        if JerkTool.Enabled then
            jerkRunning = true
            W.JerkOff_Create()
        end
    end)
end

-- ═══════════════ INVISIBILITY ═══════════════
do
    local MV = getgenv().FAZZInvis
    if not MV then
        MV = {
            Enabled = false, Loading = false, Ready = false, API = nil,
            _lastToggle = 0, _retries = 0, _retryMax = 3,
            _retryDelay = 2, _queueState = nil,
        }
        getgenv().FAZZInvis = MV
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

    local function Invis_LoadAPI()
        if _G.FAZZInternal and _G.FAZZInternal.Invisible
            and Invis_ValidateAPI(_G.FAZZInternal.Invisible) then
            MV.API = _G.FAZZInternal.Invisible
            MV.Ready = true
            return true
        end
        MV.Loading = true
        MV.Ready = false
        for attempt = 1, MV._retryMax do
            MV._retries = attempt
            local ok, err = pcall(function()
                loadstring(game:HttpGet(INVIS_URL))()
            end)
            task.wait(0.5)
            if ok and _G.FAZZInternal and _G.FAZZInternal.Invisible
                and Invis_ValidateAPI(_G.FAZZInternal.Invisible) then
                MV.API = _G.FAZZInternal.Invisible
                MV.Ready = true
                MV.Loading = false
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
        MV.Loading = false
        MV.Ready = false
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
            return
        end
        MV._lastToggle = now
        MV.Enabled = state
        VD.Invis_Enabled = state
        if state then
            local ok, err = pcall(function() MV.API.enable() end)
            if not ok then
                warn("[FAZZInvis] enable error:", err)
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
    end

    function W.Invisible_SetEnabled(v)  W.Invisible_SetState(v and true or false, false) end
    function W.Invisible_Start()        W.Invisible_SetState(true, false)  end
    function W.Invisible_Stop()         W.Invisible_SetState(false, false) end
    function W.Invisible_Toggle()       W.Invisible_SetState(not MV.Enabled, false) end
    function W.Invisible_IsReady()      return MV.Ready and MV.API ~= nil end
    function W.Invisible_IsLoading()    return MV.Loading end
    function W.Invisible_IsOn()         return MV.Enabled end
    function W.Invisible_ReloadAPI()    return Invis_LoadAPI() end
    function W.Invisible_GetStatus()
        if MV.Loading then return "LOADING" end
        if not MV.Ready then return "FAILED" end
        if MV.Enabled then return "ON" end
        return "READY"
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

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1.2)
        if MV.Enabled and MV.API then
            pcall(function() MV.API.enable() end)
        end
    end)
end

-- ═══════════════ SECTION 11 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 11 loaded — Misc Systems ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 12] Floating Button System + Boombox Music + Mini GUI
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ FLOATING BUTTON FACTORY ═══════════════
-- Style: Biru Neon (ACCENT 0,170,255), rounded, logo 72845574620852
-- Posisi default di kiri layar, drag-able, lock-able

local FAZZ_FLOAT_ICON = 72845574620852
local FAZZ_ACCENT = Color3.fromRGB(0, 170, 255)
local FAZZ_BG_ON  = Color3.fromRGB(8, 14, 26)
local FAZZ_BG_OFF = Color3.fromRGB(18, 18, 22)
local FAZZ_STROKE_ON  = FAZZ_ACCENT
local FAZZ_STROKE_OFF = Color3.fromRGB(60, 60, 72)

local function CreateFAZZFloatingButton(cfg)
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
        local isOn = cfg.isOn()
        local str = main:FindFirstChild("MainStroke")
        local icon = main:FindFirstChild("IconImg")
        local glow = main:FindFirstChild("GlowStroke")
        if isOn then
            TweenService:Create(main, TweenInfo.new(0.25), {
                BackgroundColor3 = FAZZ_BG_ON,
            }):Play()
            if str then
                TweenService:Create(str, TweenInfo.new(0.25), {
                    Color = FAZZ_STROKE_ON,
                    Transparency = 0,
                    Thickness = 1.8,
                }):Play()
            end
            if glow then
                TweenService:Create(glow, TweenInfo.new(0.25), {
                    Transparency = 0.3,
                }):Play()
            end
            if icon then
                TweenService:Create(icon, TweenInfo.new(0.25), {
                    ImageColor3 = FAZZ_ACCENT,
                }):Play()
            end
        else
            TweenService:Create(main, TweenInfo.new(0.25), {
                BackgroundColor3 = FAZZ_BG_OFF,
            }):Play()
            if str then
                TweenService:Create(str, TweenInfo.new(0.25), {
                    Color = FAZZ_STROKE_OFF,
                    Transparency = 0.3,
                    Thickness = 1.2,
                }):Play()
            end
            if glow then
                TweenService:Create(glow, TweenInfo.new(0.25), {
                    Transparency = 1,
                }):Play()
            end
            if icon then
                TweenService:Create(icon, TweenInfo.new(0.25), {
                    ImageColor3 = Color3.fromRGB(200, 230, 255),
                }):Play()
            end
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
        local parent = LocalPlayer:FindFirstChild("PlayerGui")
        if gethui then
            local ok2, hui = pcall(gethui)
            if ok2 and hui then parent = hui end
        end
        if not parent then return end

        local gui = Instance.new("ScreenGui")
        gui.Name = "FAZZ" .. cfg.id .. "Btn"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = parent
        state.Gui = gui

        -- Container
        local container = Instance.new("Frame")
        container.Name = "Container"
        container.Size = UDim2.fromOffset(180, 42)
        container.Position = state.SavedPos or UDim2.new(0, 15, 0, 200)
        container.BackgroundTransparency = 1
        container.Parent = gui

        -- Main button
        local main = Instance.new("TextButton")
        main.Name = "MainBtn"
        main.Size = UDim2.fromOffset(46, 46)
        main.BackgroundColor3 = FAZZ_BG_OFF
        main.BorderSizePixel = 0
        main.Text = ""
        main.AutoButtonColor = false
        main.ZIndex = 1
        main.Parent = container
        Instance.new("UICorner", main).CornerRadius = UDim.new(1, 0)

        local mainStroke = Instance.new("UIStroke", main)
        mainStroke.Name = "MainStroke"
        mainStroke.Color = FAZZ_STROKE_OFF
        mainStroke.Thickness = 1.2
        mainStroke.Transparency = 0.3
        mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local glowStroke = Instance.new("UIStroke", main)
        glowStroke.Name = "GlowStroke"
        glowStroke.Color = FAZZ_ACCENT
        glowStroke.Thickness = 4
        glowStroke.Transparency = 1
        glowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        -- Icon
        local iconImg = Instance.new("ImageLabel")
        iconImg.Name = "IconImg"
        iconImg.Size = UDim2.fromScale(0.6, 0.6)
        iconImg.Position = UDim2.fromScale(0.2, 0.2)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = "rbxassetid://" .. FAZZ_FLOAT_ICON
        iconImg.ImageColor3 = Color3.fromRGB(200, 230, 255)
        iconImg.ZIndex = 2
        iconImg.Parent = main

        -- Label
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(0, 120, 1, 0)
        label.Position = UDim2.new(0, 50, 0, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.Text = cfg.title
        label.TextColor3 = Color3.fromRGB(200, 230, 255)
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.TextStrokeTransparency = 0.6
        label.ZIndex = 2
        label.Parent = container

        -- Lock button
        local lockBtn = Instance.new("TextButton")
        lockBtn.Name = "LockBtn"
        lockBtn.Size = UDim2.fromOffset(24, 24)
        lockBtn.Position = UDim2.new(1, -28, 0, 0)
        lockBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
        lockBtn.BorderSizePixel = 0
        lockBtn.Text = state.DragLocked and "🔒" or "🔓"
        lockBtn.TextSize = 12
        lockBtn.Font = Enum.Font.GothamBold
        lockBtn.TextColor3 = FAZZ_ACCENT
        lockBtn.AutoButtonColor = false
        lockBtn.ZIndex = 3
        lockBtn.Parent = container
        Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(1, 0)
        local lockStroke = Instance.new("UIStroke", lockBtn)
        lockStroke.Color = FAZZ_ACCENT
        lockStroke.Thickness = 1
        lockStroke.Transparency = 0.4

        -- Drag logic
        local drag = false
        local dStart, sPos
        local dDist = 0

        table.insert(state.Connections, main.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or inp.UserInputType == Enum.UserInputType.Touch then
                dStart = inp.Position
                sPos = container.Position
                dDist = 0
                if not state.DragLocked then drag = true end
            end
        end))

        table.insert(state.Connections, main.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or inp.UserInputType == Enum.UserInputType.Touch then
                if drag then
                    drag = false
                    state.SavedPos = container.Position
                end
                if dDist < 8 then ToggleBtn() end
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

        table.insert(state.Connections, lockBtn.MouseButton1Click:Connect(function()
            state.DragLocked = not state.DragLocked
            if state.DragLocked then drag = false end
            lockBtn.Text = state.DragLocked and "🔒" or "🔓"
            VD_Notify(cfg.notifyTitle .. " Button", state.DragLocked and "Locked" or "Unlocked", 1)
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

W.CreateFAZZFloatingButton = CreateFAZZFloatingButton

-- ═══════════════════════════════════════════════════════════════════
--  REGISTER 13 FLOATING BUTTONS
-- ═══════════════════════════════════════════════════════════════════

-- 1. HEAL (Self Heal)
local HealBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 200), Connections = {} }
local HealBtn = CreateFAZZFloatingButton({
    id = "Heal", title = "Heal", notifyTitle = "Self Heal",
    state = HealBtnState,
    isOn = function() return W.InstantHealSelf end,
    onToggle = function(v) W.setInstantHealSelf(v) end,
})
getgenv().Gluto_SHB_SetEnabled = function(en) HealBtn.SetEnabled(en) end
getgenv().Gluto_SHB_UpdateVisual = function() HealBtn.UpdateVisual() end

-- 2. HOOK (Bypass Self Unhook)
local HookBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 255), Connections = {} }
local HookBtn = CreateFAZZFloatingButton({
    id = "Hook", title = "Hook", notifyTitle = "Self Unhook",
    state = HookBtnState,
    isOn = function() return W.SelfUnhook.Enabled end,
    onToggle = function(v) W.SU_SetEnabled(v) end,
})
getgenv().Gluto_SUB_SetEnabled = function(en) HookBtn.SetEnabled(en) end
getgenv().Gluto_SUB_UpdateVisual = function() HookBtn.UpdateVisual() end

-- 3. T_TP (Troll Teleport)
local TrollBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 310), Connections = {} }
local TrollBtn = CreateFAZZFloatingButton({
    id = "TrollTP", title = "T_TP", notifyTitle = "Troll Teleport",
    state = TrollBtnState,
    isOn = function() return W.TrollTeleport.Enabled end,
    onToggle = function(v) W.TrollTeleport_SetEnabled(v) end,
})
getgenv().Gluto_TTB_SetEnabled = function(en) TrollBtn.SetEnabled(en) end
getgenv().Gluto_TTB_UpdateVisual = function() TrollBtn.UpdateVisual() end

-- 4. ESCAPE (Instant Escape)
local EscapeBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 365), Connections = {} }
local EscapeBtn = CreateFAZZFloatingButton({
    id = "Escape", title = "Escape", notifyTitle = "Instant Escape",
    state = EscapeBtnState,
    isOn = function() return W.Escape.Enabled end,
    onToggle = function(v)
        W.Escape.Enabled = v
        if v then W.Escape_Teleport() end
    end,
})
getgenv().Gluto_Escape_SetEnabled = function(en) EscapeBtn.SetEnabled(en) end
getgenv().Gluto_Escape_UpdateVisual = function() EscapeBtn.UpdateVisual() end

-- 5. PARRY (Auto Parry V1)
local ParryBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 420), Connections = {} }
local ParryBtn = CreateFAZZFloatingButton({
    id = "Parry", title = "Parry", notifyTitle = "Auto Parry V1",
    state = ParryBtnState,
    isOn = function() return VD.PARRY_Enabled end,
    onToggle = function(v)
        VD.PARRY_Enabled = v
        if not v then ParryState.ActiveAttackers = {} end
    end,
})
getgenv().Gluto_ParryBtn_SetEnabled = function(en) ParryBtn.SetEnabled(en) end
getgenv().Gluto_ParryBtn_UpdateVisual = function() ParryBtn.UpdateVisual() end

-- 6. INVIS (Invisibility)
local InvisBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 475), Connections = {} }
local InvisBtn = CreateFAZZFloatingButton({
    id = "Invisible", title = "Invis", notifyTitle = "Invisibility",
    state = InvisBtnState,
    isOn = function()
        local MV = getgenv().FAZZInvis
        return MV and MV.Enabled or false
    end,
    onToggle = function(v) W.Invisible_SetState(v, true) end,
})
getgenv().Gluto_InvisBtn_SetEnabled   = function(en) InvisBtn.SetEnabled(en) end
getgenv().Gluto_InvisBtn_UpdateVisual = function() InvisBtn.UpdateVisual() end

-- 7. GRAB (Myers Infinite Grab)
local GrabBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 530), Connections = {} }
local GrabBtn = CreateFAZZFloatingButton({
    id = "MyersGrab", title = "Grab", notifyTitle = "Myers Grab",
    state = GrabBtnState,
    isOn = function() return W.MyersGrabData.Enabled end,
    onToggle = function(v) W.setMyersGrab(v) end,
})
getgenv().Gluto_MGrabBtn_SetEnabled   = function(en) GrabBtn.SetEnabled(en) end
getgenv().Gluto_MGrabBtn_UpdateVisual = function() GrabBtn.UpdateVisual() end

-- 8. VEIL (Silent Veil V1)
local VeilBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 585), Connections = {} }
local VeilBtn = CreateFAZZFloatingButton({
    id = "SilentVeil", title = "Veil", notifyTitle = "Silent Veil V1",
    state = VeilBtnState,
    isOn = function() return VD.VeilEnabled end,
    onToggle = function(v)
        VD.VeilEnabled = v
        if not v then
            VeilState.target = nil
            VeilState.lookVector = nil
        end
        VD_Notify("Silent Veil", v and "Enabled" or "Disabled", 2)
    end,
})
getgenv().Gluto_VeilBtn_SetEnabled   = function(en) VeilBtn.SetEnabled(en) end
getgenv().Gluto_VeilBtn_UpdateVisual = function() VeilBtn.UpdateVisual() end

-- 9. MOONWALK
local MoonwalkBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 640), Connections = {} }
local MoonwalkBtn = CreateFAZZFloatingButton({
    id = "Moonwalk", title = "Moonwalk", notifyTitle = "Moonwalk",
    state = MoonwalkBtnState,
    isOn = function() return W.Moonwalk_IsEnabled and W.Moonwalk_IsEnabled() or false end,
    onToggle = function(v) if W.Moonwalk_SetEnabled then W.Moonwalk_SetEnabled(v) end end,
})
getgenv().Gluto_MoonwalkBtn_SetEnabled   = function(en) MoonwalkBtn.SetEnabled(en) end
getgenv().Gluto_MoonwalkBtn_UpdateVisual = function() MoonwalkBtn.UpdateVisual() end

-- 10. GEN (Bypass Generator)
local GenBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 695), Connections = {} }
local GenBtn = CreateFAZZFloatingButton({
    id = "BypassGen", title = "GEN", notifyTitle = "Bypass Generator",
    state = GenBtnState,
    isOn = function() return W.GenBypass and W.GenBypass.Enabled end,
    onToggle = function(v) if W.setGenBypass then W.setGenBypass(v) end end,
})
getgenv().Gluto_GenBtn_SetEnabled   = function(en) GenBtn.SetEnabled(en) end
getgenv().Gluto_GenBtn_UpdateVisual = function() GenBtn.UpdateVisual() end

-- 11. SPEAR (Spear Aimbot)
local SpearBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 750), Connections = {} }
local SpearBtn = CreateFAZZFloatingButton({
    id = "SpearAim", title = "Spear", notifyTitle = "Spear Aimbot",
    state = SpearBtnState,
    isOn = function() return VD.SPEAR_Aimbot end,
    onToggle = function(v) if W.SpearAimbot_SetEnabled then W.SpearAimbot_SetEnabled(v) end end,
})
getgenv().Gluto_SpearBtn_SetEnabled   = function(en) SpearBtn.SetEnabled(en) end
getgenv().Gluto_SpearBtn_UpdateVisual = function() SpearBtn.UpdateVisual() end

-- 12. FAKE PARRY
local FakeParryBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 805), Connections = {} }
local FakeParryBtn = CreateFAZZFloatingButton({
    id = "FakeParry", title = "Fake Parry", notifyTitle = "Fake Parry",
    state = FakeParryBtnState,
    isOn = function() return VD.SURV_FakeParry end,
    onToggle = function(v) if W.FakeParry_SetEnabled then W.FakeParry_SetEnabled(v) end end,
})
getgenv().Gluto_FakeParryBtn_SetEnabled   = function(en) FakeParryBtn.SetEnabled(en) end
getgenv().Gluto_FakeParryBtn_UpdateVisual = function() FakeParryBtn.UpdateVisual() end

-- 13. FAKE PERKS
local FakePerksBtnState = { Enabled = false, DragLocked = false, Gui = nil,
    SavedPos = UDim2.new(0, 15, 0, 860), Connections = {} }
local FakePerksBtn = CreateFAZZFloatingButton({
    id = "FakePerks", title = "Fake Perks", notifyTitle = "Fake Perks",
    state = FakePerksBtnState,
    isOn = function()
        local FP = W.FP
        return FP and (FP.FlowstateOn or FP.QuickRecOn or FP.PerfLandOn or FP.AdrenalineOn) or false
    end,
    onToggle = function(v)
        if v then
            if W.FP_SetupFlowstate then W.FP_SetupFlowstate(true) end
            if W.FP_SetupQuickRecovery then W.FP_SetupQuickRecovery(true) end
            if W.FP_SetupPerfectLanding then W.FP_SetupPerfectLanding(true) end
            if W.FP_SetupAdrenalineRush then W.FP_SetupAdrenalineRush(true) end
        else
            if W.FP_SetupFlowstate then W.FP_SetupFlowstate(false) end
            if W.FP_SetupQuickRecovery then W.FP_SetupQuickRecovery(false) end
            if W.FP_SetupPerfectLanding then W.FP_SetupPerfectLanding(false) end
            if W.FP_SetupAdrenalineRush then W.FP_SetupAdrenalineRush(false) end
        end
    end,
})
getgenv().Gluto_FakePerksBtn_SetEnabled   = function(en) FakePerksBtn.SetEnabled(en) end
getgenv().Gluto_FakePerksBtn_UpdateVisual = function() FakePerksBtn.UpdateVisual() end

-- Periodic visual sync
task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function() HealBtn.UpdateVisual() end)
        pcall(function() HookBtn.UpdateVisual() end)
        pcall(function() TrollBtn.UpdateVisual() end)
        pcall(function() EscapeBtn.UpdateVisual() end)
        pcall(function() ParryBtn.UpdateVisual() end)
        pcall(function() InvisBtn.UpdateVisual() end)
        pcall(function() GrabBtn.UpdateVisual() end)
        pcall(function() VeilBtn.UpdateVisual() end)
        pcall(function() MoonwalkBtn.UpdateVisual() end)
        pcall(function() GenBtn.UpdateVisual() end)
        pcall(function() SpearBtn.UpdateVisual() end)
        pcall(function() FakeParryBtn.UpdateVisual() end)
        pcall(function() FakePerksBtn.UpdateVisual() end)
    end
end)

-- ═══════════════════════════════════════════════════════════════════
--  BOOMBOX MUSIC SYSTEM
-- ═══════════════════════════════════════════════════════════════════

local Songs = {
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

local MusicState = {
    Enabled = false,
    CurrentIndex = 1,
    CurrentSound = nil,
    Volume = 2,
    Looped = true,
    Shuffle = false,
    AttachedTo = "LocalPlayer",
    TargetPlayer = nil,
    SoundParent = nil,
    AutoNext = true,
}
W.MusicState = MusicState
W.MusicSongs = Songs

local SongTitles = {}
for _, s in ipairs(Songs) do
    table.insert(SongTitles, s.judul)
end

local function Music_GetSoundParent()
    if MusicState.AttachedTo == "LocalPlayer" then
        local char = LocalPlayer.Character
        if char then
            return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
        end
        return nil
    elseif MusicState.AttachedTo == "TargetPlayer" then
        if MusicState.TargetPlayer and MusicState.TargetPlayer.Character then
            return MusicState.TargetPlayer.Character:FindFirstChild("Head")
                or MusicState.TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
        end
        return nil
    elseif MusicState.AttachedTo == "Workspace" then
        return Workspace
    end
    return nil
end

local function Music_Stop()
    if MusicState.CurrentSound then
        pcall(function()
            MusicState.CurrentSound:Stop()
            MusicState.CurrentSound:Destroy()
        end)
        MusicState.CurrentSound = nil
    end
end

local function Music_PlayByIndex(idx)
    Music_Stop()
    if not MusicState.Enabled then return end
    local song = Songs[idx]
    if not song then return end
    local parent = Music_GetSoundParent()
    if not parent then
        VD_Notify("Boombox", "Parent tidak ditemukan (belum spawn?)", 2)
        return
    end
    local snd = Instance.new("Sound")
    snd.Name = "FAZZBoombox_" .. song.judul
    snd.SoundId = "rbxassetid://" .. song.id
    snd.Volume = MusicState.Volume
    snd.Looped = MusicState.Looped
    snd.RollOffMaxDistance = 200
    snd.RollOffMinDistance = 10
    snd.RollOffMode = Enum.RollOffMode.InverseTapered
    snd.Parent = parent
    snd:Play()
    MusicState.CurrentSound = snd
    MusicState.CurrentIndex = idx
    MusicState.SoundParent = parent
    snd.Ended:Connect(function()
        if MusicState.AutoNext and MusicState.Enabled then
            local nextIdx
            if MusicState.Shuffle then
                nextIdx = math.random(1, #Songs)
            else
                nextIdx = idx + 1
                if nextIdx > #Songs then nextIdx = 1 end
            end
            task.wait(0.3)
            Music_PlayByIndex(nextIdx)
        end
    end)
    VD_Notify("🎵 Boombox", "Now Playing: " .. song.judul, 3)
end

local function Music_PlayByName(name)
    for i, s in ipairs(Songs) do
        if s.judul == name then
            Music_PlayByIndex(i)
            return
        end
    end
end

local function Music_SetEnabled(v)
    MusicState.Enabled = v and true or false
    if MusicState.Enabled then
        Music_PlayByIndex(MusicState.CurrentIndex)
        VD_Notify("🎵 Boombox", "Enabled — " .. Songs[MusicState.CurrentIndex].judul, 2)
    else
        Music_Stop()
        VD_Notify("🎵 Boombox", "Disabled", 2)
    end
end

W.Music_SetEnabled = Music_SetEnabled
W.Music_PlayByName = Music_PlayByName
W.Music_PlayByIndex = Music_PlayByIndex
W.Music_Stop = Music_Stop

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1.5)
    if MusicState.Enabled then
        Music_PlayByIndex(MusicState.CurrentIndex)
    end
end)

task.spawn(function()
    while true do
        task.wait(5)
        if MusicState.TargetPlayer and not MusicState.TargetPlayer.Parent then
            MusicState.TargetPlayer = nil
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════
--  BOOMBOX MINI GUI (collapse + progress bar + drag)
-- ═══════════════════════════════════════════════════════════════════

do
    local MiniGui = nil
    local MiniState = {
        Collapsed = false,
        Dragging = false,
        DragStart = nil,
        SavedPos = UDim2.new(1, -300, 1, -140),
        ProgressConn = nil,
    }
    W.MiniState = MiniState

    local function Mini_UpdateProgress()
        if not MiniGui then return end
        local frame = MiniGui:FindFirstChild("MiniFrame")
        if not frame then return end
        local snd = MusicState.CurrentSound
        local titleLbl = frame:FindFirstChild("TitleLbl", true)
        local barFill = frame:FindFirstChild("BarFill", true)
        local timeLbl = frame:FindFirstChild("TimeLbl", true)

        if titleLbl then
            local song = Songs[MusicState.CurrentIndex]
            titleLbl.Text = song and song.judul or "No Track"
        end

        if snd and snd.IsPlaying then
            local length = snd.TimeLength
            local pos = snd.TimePosition
            if length > 0 and barFill then
                barFill.Size = UDim2.new(math.clamp(pos / length, 0, 1), 0, 1, 0)
            end
            if timeLbl then
                local function fmt(t)
                    t = math.floor(t or 0)
                    return string.format("%d:%02d", math.floor(t / 60), t % 60)
                end
                timeLbl.Text = fmt(pos) .. " / " .. fmt(length)
            end
        else
            if barFill then barFill.Size = UDim2.new(0, 0, 1, 0) end
            if timeLbl then timeLbl.Text = "0:00 / 0:00" end
        end
    end

    local function Mini_Create()
        if MiniGui then
            pcall(function() MiniGui:Destroy() end)
        end
        local parent = LocalPlayer:FindFirstChild("PlayerGui")
        if gethui then
            local ok2, hui = pcall(gethui)
            if ok2 and hui then parent = hui end
        end
        if not parent then return end

        local sg = Instance.new("ScreenGui")
        sg.Name = "FAZZBoomboxMini"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        sg.DisplayOrder = 60
        sg.Parent = parent
        MiniGui = sg

        local frame = Instance.new("Frame")
        frame.Name = "MiniFrame"
        frame.AnchorPoint = Vector2.new(1, 1)
        frame.Position = MiniState.SavedPos
        frame.Size = UDim2.fromOffset(280, 110)
        frame.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        frame.BackgroundTransparency = 0.05
        frame.BorderSizePixel = 0
        frame.Active = true
        frame.ClipsDescendants = true
        frame.Parent = sg
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

        local frameStroke = Instance.new("UIStroke", frame)
        frameStroke.Color = FAZZ_ACCENT
        frameStroke.Thickness = 1.5
        frameStroke.Transparency = 0.15
        frameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        -- Header
        local header = Instance.new("Frame")
        header.Name = "Header"
        header.Size = UDim2.new(1, 0, 0, 28)
        header.Position = UDim2.new(0, 0, 0, 0)
        header.BackgroundTransparency = 1
        header.Active = true
        header.Parent = frame

        local headerIcon = Instance.new("ImageLabel")
        headerIcon.Name = "HeaderIcon"
        headerIcon.Size = UDim2.fromOffset(18, 18)
        headerIcon.Position = UDim2.new(0, 8, 0.5, -9)
        headerIcon.BackgroundTransparency = 1
        headerIcon.Image = "rbxassetid://" .. FAZZ_FLOAT_ICON
        headerIcon.ImageColor3 = FAZZ_ACCENT
        headerIcon.Parent = header

        local headerTitle = Instance.new("TextLabel")
        headerTitle.Name = "HeaderTitle"
        headerTitle.Size = UDim2.new(1, -70, 1, 0)
        headerTitle.Position = UDim2.new(0, 32, 0, 0)
        headerTitle.BackgroundTransparency = 1
        headerTitle.Font = Enum.Font.GothamBold
        headerTitle.Text = "FAZZ BOOMBOX"
        headerTitle.TextColor3 = FAZZ_ACCENT
        headerTitle.TextSize = 11
        headerTitle.TextXAlignment = Enum.TextXAlignment.Left
        headerTitle.Parent = header

        -- Collapse button
        local collapseBtn = Instance.new("TextButton")
        collapseBtn.Name = "CollapseBtn"
        collapseBtn.Size = UDim2.fromOffset(22, 22)
        collapseBtn.Position = UDim2.new(1, -26, 0.5, -11)
        collapseBtn.BackgroundColor3 = Color3.fromRGB(20, 28, 46)
        collapseBtn.BorderSizePixel = 0
        collapseBtn.Text = "▼"
        collapseBtn.TextColor3 = FAZZ_ACCENT
        collapseBtn.Font = Enum.Font.GothamBold
        collapseBtn.TextSize = 10
        collapseBtn.AutoButtonColor = false
        collapseBtn.Parent = header
        Instance.new("UICorner", collapseBtn).CornerRadius = UDim.new(0, 5)

        -- Body
        local body = Instance.new("Frame")
        body.Name = "Body"
        body.Size = UDim2.new(1, -16, 1, -34)
        body.Position = UDim2.new(0, 8, 0, 30)
        body.BackgroundTransparency = 1
        body.Parent = frame

        -- Title label (song name)
        local titleLbl = Instance.new("TextLabel")
        titleLbl.Name = "TitleLbl"
        titleLbl.Size = UDim2.new(1, 0, 0, 16)
        titleLbl.Position = UDim2.new(0, 0, 0, 0)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Font = Enum.Font.GothamBold
        titleLbl.Text = "No Track"
        titleLbl.TextColor3 = Color3.fromRGB(220, 230, 255)
        titleLbl.TextSize = 11
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.TextTruncate = Enum.TextTruncate.AtEnd
        titleLbl.Parent = body

        -- Progress bar background
        local barBg = Instance.new("Frame")
        barBg.Name = "BarBg"
        barBg.Size = UDim2.new(1, 0, 0, 6)
        barBg.Position = UDim2.new(0, 0, 0, 20)
        barBg.BackgroundColor3 = Color3.fromRGB(20, 28, 46)
        barBg.BorderSizePixel = 0
        barBg.Parent = body
        Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

        local barFill = Instance.new("Frame")
        barFill.Name = "BarFill"
        barFill.Size = UDim2.new(0, 0, 1, 0)
        barFill.BackgroundColor3 = FAZZ_ACCENT
        barFill.BorderSizePixel = 0
        barFill.Parent = barBg
        Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

        -- Time label
        local timeLbl = Instance.new("TextLabel")
        timeLbl.Name = "TimeLbl"
        timeLbl.Size = UDim2.new(1, 0, 0, 12)
        timeLbl.Position = UDim2.new(0, 0, 0, 30)
        timeLbl.BackgroundTransparency = 1
        timeLbl.Font = Enum.Font.GothamBold
        timeLbl.Text = "0:00 / 0:00"
        timeLbl.TextColor3 = Color3.fromRGB(160, 200, 255)
        timeLbl.TextSize = 9
        timeLbl.TextXAlignment = Enum.TextXAlignment.Left
        timeLbl.Parent = body

        -- Controls
        local ctrlFrame = Instance.new("Frame")
        ctrlFrame.Name = "Controls"
        ctrlFrame.Size = UDim2.new(1, 0, 0, 24)
        ctrlFrame.Position = UDim2.new(0, 0, 0, 46)
        ctrlFrame.BackgroundTransparency = 1
        ctrlFrame.Parent = body

        local ctrlLayout = Instance.new("UIListLayout", ctrlFrame)
        ctrlLayout.FillDirection = Enum.FillDirection.Horizontal
        ctrlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        ctrlLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        ctrlLayout.Padding = UDim.new(0, 6)

        local function makeCtrlBtn(name, text, order)
            local b = Instance.new("TextButton")
            b.Name = name
            b.Size = UDim2.fromOffset(24, 24)
            b.BackgroundColor3 = Color3.fromRGB(20, 28, 46)
            b.BorderSizePixel = 0
            b.Text = text
            b.TextColor3 = FAZZ_ACCENT
            b.Font = Enum.Font.GothamBold
            b.TextSize = 11
            b.AutoButtonColor = false
            b.LayoutOrder = order
            b.Parent = ctrlFrame
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
            local s = Instance.new("UIStroke", b)
            s.Color = FAZZ_ACCENT
            s.Thickness = 1
            s.Transparency = 0.4
            return b
        end

        local prevBtn = makeCtrlBtn("Prev", "⏮", 1)
        local playBtn = makeCtrlBtn("Play", "⏯", 2)
        local nextBtn = makeCtrlBtn("Next", "⏭", 3)
        local stopBtn = makeCtrlBtn("Stop", "⏹", 4)

        -- Volume slider mini
        local volBtn = Instance.new("TextButton")
        volBtn.Name = "VolBtn"
        volBtn.Size = UDim2.fromOffset(28, 24)
        volBtn.BackgroundColor3 = Color3.fromRGB(20, 28, 46)
        volBtn.BorderSizePixel = 0
        volBtn.Text = "🔊"
        volBtn.TextColor3 = FAZZ_ACCENT
        volBtn.Font = Enum.Font.GothamBold
        volBtn.TextSize = 11
        volBtn.AutoButtonColor = false
        volBtn.LayoutOrder = 5
        volBtn.Parent = ctrlFrame
        Instance.new("UICorner", volBtn).CornerRadius = UDim.new(0, 5)

        local volBtnStroke = Instance.new("UIStroke", volBtn)
        volBtnStroke.Color = FAZZ_ACCENT
        volBtnStroke.Thickness = 1
        volBtnStroke.Transparency = 0.4

        -- Volume bar
        local volBarBg = Instance.new("Frame")
        volBarBg.Name = "VolBarBg"
        volBarBg.Size = UDim2.new(1, -140, 0, 6)
        volBarBg.Position = UDim2.new(0, 140, 0, 54)
        volBarBg.BackgroundColor3 = Color3.fromRGB(20, 28, 46)
        volBarBg.BorderSizePixel = 0
        volBarBg.Parent = body
        Instance.new("UICorner", volBarBg).CornerRadius = UDim.new(1, 0)

        local volBarFill = Instance.new("Frame")
        volBarFill.Name = "VolBarFill"
        volBarFill.Size = UDim2.new(MusicState.Volume / 10, 0, 1, 0)
        volBarFill.BackgroundColor3 = FAZZ_ACCENT
        volBarFill.BorderSizePixel = 0
        volBarFill.Parent = volBarBg
        Instance.new("UICorner", volBarFill).CornerRadius = UDim.new(1, 0)

        -- Event handlers
        prevBtn.MouseButton1Click:Connect(function()
            local n = MusicState.CurrentIndex - 1
            if n < 1 then n = #Songs end
            Music_PlayByIndex(n)
        end)
        nextBtn.MouseButton1Click:Connect(function()
            local n = MusicState.CurrentIndex + 1
            if n > #Songs then n = 1 end
            Music_PlayByIndex(n)
        end)
        playBtn.MouseButton1Click:Connect(function()
            local snd = MusicState.CurrentSound
            if snd and snd.IsPlaying then
                snd:Pause()
            elseif snd then
                snd:Resume()
            else
                Music_PlayByIndex(MusicState.CurrentIndex)
            end
        end)
        stopBtn.MouseButton1Click:Connect(function()
            Music_Stop()
        end)

        -- Volume controls
        local draggingVol = false
        volBarBg.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or inp.UserInputType == Enum.UserInputType.Touch then
                draggingVol = true
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if not draggingVol then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement
                or inp.UserInputType == Enum.UserInputType.Touch then
                local rel = math.clamp((inp.Position.X - volBarBg.AbsolutePosition.X) / volBarBg.AbsoluteSize.X, 0, 1)
                MusicState.Volume = rel * 10
                volBarFill.Size = UDim2.new(rel, 0, 1, 0)
                if MusicState.CurrentSound then
                    pcall(function() MusicState.CurrentSound.Volume = MusicState.Volume end)
                end
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or inp.UserInputType == Enum.UserInputType.Touch then
                draggingVol = false
            end
        end)

        -- Collapse toggle
        collapseBtn.MouseButton1Click:Connect(function()
            MiniState.Collapsed = not MiniState.Collapsed
            if MiniState.Collapsed then
                TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                    Size = UDim2.fromOffset(280, 30),
                }):Play()
                body.Visible = false
                collapseBtn.Text = "▲"
            else
                TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                    Size = UDim2.fromOffset(280, 110),
                }):Play()
                task.wait(0.1)
                body.Visible = true
                collapseBtn.Text = "▼"
            end
        end)

        -- Drag (header)
        header.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or inp.UserInputType == Enum.UserInputType.Touch then
                MiniState.Dragging = true
                MiniState.DragStart = inp.Position
                MiniState.DragStartPos = frame.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if not MiniState.Dragging then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement
                or inp.UserInputType == Enum.UserInputType.Touch then
                local d = inp.Position - MiniState.DragStart
                frame.Position = UDim2.new(
                    MiniState.DragStartPos.X.Scale, MiniState.DragStartPos.X.Offset + d.X,
                    MiniState.DragStartPos.Y.Scale, MiniState.DragStartPos.Y.Offset + d.Y
                )
                MiniState.SavedPos = frame.Position
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or inp.UserInputType == Enum.UserInputType.Touch then
                MiniState.Dragging = false
            end
        end)

        -- Progress loop
        if MiniState.ProgressConn then MiniState.ProgressConn:Disconnect() end
        MiniState.ProgressConn = RunService.Heartbeat:Connect(function()
            pcall(Mini_UpdateProgress)
        end)
    end

    W.BoomboxMini_Show = Mini_Create
    W.BoomboxMini_Hide = function()
        if MiniGui then
            pcall(function() MiniGui:Destroy() end)
            MiniGui = nil
        end
        if MiniState.ProgressConn then
            MiniState.ProgressConn:Disconnect()
            MiniState.ProgressConn = nil
        end
    end
    W.BoomboxMini_Toggle = function()
        if MiniGui then
            W.BoomboxMini_Hide()
        else
            W.BoomboxMini_Show()
        end
    end
end

-- ═══════════════ SECTION 12 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 12 loaded — Floating Buttons + Boombox ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 13] UI Build — Survivor Tab + Visuals Tab
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════════
--  SURVIVOR TAB
-- ═══════════════════════════════════════════════════════════════════
local SURV_L = Tabs.Survivor:AddLeftGroupbox("Survivor Utility", "user")
local SURV_R = Tabs.Survivor:AddRightGroupbox("Abilities", "shield")

-- ─── SELF HEAL ───
SURV_L:AddLabel("⚕️ Self Heal System")
SURV_L:AddDivider()
SURV_L:AddToggle("InstantHealSelf", {
    Text = "Self Heal (Instant)",
    Default = false,
    Callback = function(v)
        W.setInstantHealSelf(v)
        if getgenv().Gluto_SHB_UpdateVisual then getgenv().Gluto_SHB_UpdateVisual() end
        if v then VD_Notify("Self Heal", "Enabled", 2) end
    end,
})
SURV_L:AddToggle("AutoHealAll", {
    Text = "Auto Heal All Survivors",
    Default = false,
    Callback = function(v)
        W.setAutoHealAll(v)
        if v then VD_Notify("Auto Heal All", "Enabled", 2) end
    end,
})
SURV_L:AddToggle("ShowHealBtn", {
    Text = "Show Heal Floating Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_SHB_SetEnabled then getgenv().Gluto_SHB_SetEnabled(v) end
    end,
})

-- ─── SWIFT VAULT ───
SURV_L:AddDivider()
SURV_L:AddLabel("🏃 Swift Vault")
SURV_L:AddToggle("SwiftVault", {
    Text = "Swift Vault (Auto Vault)",
    Default = false,
    Callback = function(v)
        W.SwiftVault_SetEnabled(v)
        if v then VD_Notify("Swift Vault", "Enabled", 2) end
    end,
})
SURV_L:AddToggle("SwiftVaultV2", {
    Text = "Swift Vault V2 (Custom Speed)",
    Default = false,
    Callback = function(v) W.SwiftVaultV2_SetEnabled(v) end,
})
SURV_L:AddSlider("VaultSpeed", {
    Text = "Vault Speed",
    Min = 10, Max = 20, Default = 13, Rounding = 0,
    Suffix = "x",
    Callback = function(v) W.SwiftVault_SetSpeed(v) end,
})

-- ─── PALLET REFLEX ───
SURV_L:AddDivider()
SURV_L:AddLabel("🪵 Pallet Reflex")
SURV_L:AddToggle("PalletReflex", {
    Text = "Enable Pallet Reflex",
    Default = false,
    Callback = function(v)
        W.PalletReflex_SetEnabled(v)
        if v then VD_Notify("Pallet Reflex", "Enabled", 2) end
    end,
})
SURV_L:AddSlider("PalletReflexDist", {
    Text = "Trigger Distance",
    Min = 5, Max = 50, Default = 20, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.PalletReflex_SetDistance(v) end,
})

-- ─── AUTO FLEE ───
SURV_L:AddDivider()
SURV_L:AddLabel("🏃 Auto Flee Killer")
SURV_L:AddToggle("AutoFlee", {
    Text = "Enable Auto Flee",
    Default = false,
    Callback = function(v)
        VD.SURV_AutoFlee = v
        if v then VD_Notify("Auto Flee", "Enabled", 2) end
    end,
})
SURV_L:AddSlider("AutoFleeDist", {
    Text = "Detect Distance",
    Min = 15, Max = 150, Default = 40, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) VD.SURV_AutoFleeDist = v end,
})
SURV_L:AddSlider("AutoFleeCooldown", {
    Text = "Flee Cooldown",
    Min = 0.5, Max = 10, Default = 1.5, Rounding = 1,
    Suffix = "s",
    Callback = function(v) VD.SURV_AutoFleeCooldown = v end,
})

-- ─── FAKE PERKS ───
SURV_L:AddDivider()
SURV_L:AddLabel("✨ Fake Perks")
SURV_L:AddToggle("FP_Flowstate", {
    Text = "Flowstate (Buff on Vault/Slide)",
    Default = false,
    Callback = function(v)
        W.FP_SetupFlowstate(v)
        if v then VD_Notify("Fake Perks", "Flowstate Enabled", 2) end
    end,
})
SURV_L:AddToggle("FP_QuickRecovery", {
    Text = "Quick Recovery (Buff on Heal)",
    Default = false,
    Callback = function(v)
        W.FP_SetupQuickRecovery(v)
        if v then VD_Notify("Fake Perks", "Quick Recovery Enabled", 2) end
    end,
})
SURV_L:AddToggle("FP_PerfectLanding", {
    Text = "Perfect Landing (Buff on Land)",
    Default = false,
    Callback = function(v)
        W.FP_SetupPerfectLanding(v)
        if v then VD_Notify("Fake Perks", "Perfect Landing Enabled", 2) end
    end,
})
SURV_L:AddToggle("FP_AdrenalineRush", {
    Text = "Adrenaline Rush (Buff on Low HP)",
    Default = false,
    Callback = function(v)
        W.FP_SetupAdrenalineRush(v)
        if v then VD_Notify("Fake Perks", "Adrenaline Rush Enabled", 2) end
    end,
})
SURV_L:AddSlider("FP_Cooldown", {
    Text = "Perk Cooldown",
    Min = 0, Max = 30, Default = 5, Rounding = 0,
    Suffix = "s",
    Callback = function(v) W.FP.CooldownTime = v end,
})
SURV_L:AddButton({
    Text = "Clear All Active Buffs",
    Func = function()
        for k in pairs(W.FP.ActiveBuffs) do W.FP.ActiveBuffs[k] = nil end
        local c = LocalPlayer.Character
        if c then c:SetAttribute("speedboost", 1) end
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 end
        ForceNotify("Fake Perks", "Buffs cleared", 2)
    end,
})

-- ─── BYPASS GENERATOR ───
SURV_L:AddDivider()
SURV_L:AddLabel("⚡ Bypass Generator")
SURV_L:AddToggle("BypassGen", {
    Text = "Enable Bypass Generator",
    Default = false,
    Callback = function(v)
        W.setGenBypass(v)
        if getgenv().Gluto_GenBtn_UpdateVisual then getgenv().Gluto_GenBtn_UpdateVisual() end
        if v then VD_Notify("Bypass Generator", "Enabled (Hotkey: B)", 3) end
    end,
})
SURV_L:AddToggle("ShowGenBtn", {
    Text = "Show GEN Floating Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_GenBtn_SetEnabled then getgenv().Gluto_GenBtn_SetEnabled(v) end
    end,
})
SURV_L:AddSlider("GenTriggerRange", {
    Text = "Trigger Range",
    Min = 3, Max = 20, Default = 8, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.GenBypass.TriggerRange = v end,
})
SURV_L:AddButton({
    Text = "Force Repair Nearest Generator",
    Func = function()
        local bp, bd = W.GB_GetNearestPoint()
        if bp and bd <= W.GenBypass.TriggerRange then
            W.GB_DoRepair(bp)
            ForceNotify("Bypass Generator", "Forcing repair...", 2)
        else
            ForceNotify("Bypass Generator", "Terlalu jauh", 2)
        end
    end,
})

-- ─── UNLIMITED VAULT ───
SURV_L:AddDivider()
local UnlimitedVaultEnabled = false
local UnlimitedVaultConn = nil
SURV_L:AddToggle("UnlimitedVault", {
    Text = "Unlimited Vault",
    Default = false,
    Callback = function(state)
        if state then
            if UnlimitedVaultEnabled then return end
            UnlimitedVaultEnabled = true
            for _, v in ipairs(CollectionService:GetTagged("Blocked")) do
                CollectionService:RemoveTag(v, "Blocked")
            end
            if UnlimitedVaultConn then UnlimitedVaultConn:Disconnect() end
            UnlimitedVaultConn = CollectionService:GetInstanceAddedSignal("Blocked"):Connect(function(instance)
                CollectionService:RemoveTag(instance, "Blocked")
            end)
        else
            UnlimitedVaultEnabled = false
            if UnlimitedVaultConn then UnlimitedVaultConn:Disconnect(); UnlimitedVaultConn = nil end
        end
        VD_Notify("Unlimited Vault", state and "Enabled" or "Disabled", 2)
    end,
})

-- ─── ANTI SLOW VAULT ───
local AntiSlowVaultEnabled = false
local AntiSlowVaultConn = nil
SURV_L:AddToggle("AntiSlowVault", {
    Text = "Anti Slow Vault",
    Default = false,
    Callback = function(state)
        if state then
            if AntiSlowVaultEnabled then return end
            AntiSlowVaultEnabled = true
            for _, v in ipairs(CollectionService:GetTagged("SlowVault")) do
                CollectionService:RemoveTag(v, "SlowVault")
            end
            if AntiSlowVaultConn then AntiSlowVaultConn:Disconnect() end
            AntiSlowVaultConn = CollectionService:GetInstanceAddedSignal("SlowVault"):Connect(function(instance)
                CollectionService:RemoveTag(instance, "SlowVault")
            end)
        else
            AntiSlowVaultEnabled = false
            if AntiSlowVaultConn then AntiSlowVaultConn:Disconnect(); AntiSlowVaultConn = nil end
        end
        VD_Notify("Anti Slow Vault", state and "Enabled" or "Disabled", 2)
    end,
})

-- ─── GOD MODE ───
local GodModeEnabled = false
local GodModeThread = nil
SURV_L:AddToggle("GodMode", {
    Text = "God Mode (Auto-Heal)",
    Default = false,
    Callback = function(state)
        GodModeEnabled = state
        if state then
            if GodModeThread then task.cancel(GodModeThread) end
            GodModeThread = task.spawn(function()
                while GodModeEnabled do
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        pcall(function()
                            if hum.Health < hum.MaxHealth and hum.Health > 0 then
                                hum.Health = hum.MaxHealth
                            end
                        end)
                    end
                    task.wait(0.1)
                end
                GodModeThread = nil
            end)
            VD_Notify("God Mode", "Enabled", 2)
        else
            if GodModeThread then task.cancel(GodModeThread); GodModeThread = nil end
            VD_Notify("God Mode", "Disabled", 2)
        end
    end,
})

-- ─── AUTO RUN ───
SURV_L:AddDivider()
SURV_L:AddLabel("🏃 Auto Run")
local AutoRunPCEnabled = false
local AutoRunPCThread = nil
SURV_L:AddToggle("AutoRunPC", {
    Text = "Auto Run [PC]",
    Default = false,
    Callback = function(v)
        AutoRunPCEnabled = v
        if v then
            if AutoRunPCThread then task.cancel(AutoRunPCThread) end
            AutoRunPCThread = task.spawn(function()
                while AutoRunPCEnabled do
                    pcall(function()
                        if VirtualInputManager then
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse())
                        end
                    end)
                    task.wait(0.1)
                end
                pcall(function()
                    if VirtualInputManager then
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse())
                    end
                end)
                AutoRunPCThread = nil
            end)
            VD_Notify("Auto Run PC", "Enabled", 2)
        else
            if AutoRunPCThread then task.cancel(AutoRunPCThread); AutoRunPCThread = nil end
            VD_Notify("Auto Run PC", "Disabled", 2)
        end
    end,
})

-- ─── AUTO CROUCH DODGE ───
SURV_L:AddDivider()
SURV_L:AddToggle("AutoCrouchDodge", {
    Text = "Auto Crouch Dodge",
    Default = VD.AutoCrouch,
    Callback = function(v)
        VD.AutoCrouch = v
        if v then VD_Notify("Auto Crouch Dodge", "Enabled", 2) else VD_Notify("Auto Crouch Dodge", "Disabled", 2) end
    end,
})

-- ─── TROLL TELEPORT ───
SURV_L:AddDivider()
SURV_L:AddLabel("🌀 Troll Teleport")
SURV_L:AddToggle("TrollTP", {
    Text = "Enable Troll Teleport",
    Default = false,
    Callback = function(v)
        W.TrollTeleport_SetEnabled(v)
        if getgenv().Gluto_TTB_UpdateVisual then getgenv().Gluto_TTB_UpdateVisual() end
        if v then VD_Notify("Troll Teleport", "Enabled", 2) end
    end,
})
SURV_L:AddToggle("ShowTrollBtn", {
    Text = "Show Troll TP Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_TTB_SetEnabled then getgenv().Gluto_TTB_SetEnabled(v) end
    end,
})

-- ═══════════════════════════════════════════════════════════════════
--  SURVIVOR RIGHT COLUMN — ABILITIES
-- ═══════════════════════════════════════════════════════════════════

-- ─── AUTO PARRY V1 ───
SURV_R:AddLabel("🛡️ Auto Parry V1")
SURV_R:AddToggle("ParryV1", {
    Text = "Enable Auto Parry V1",
    Default = false,
    Callback = function(v)
        VD.PARRY_Enabled = v
        if not v then ParryState.ActiveAttackers = {} end
        if getgenv().Gluto_ParryBtn_UpdateVisual then getgenv().Gluto_ParryBtn_UpdateVisual() end
        if v then VD_Notify("Auto Parry V1", "Enabled", 2) end
    end,
})
SURV_R:AddToggle("ShowParryBtn", {
    Text = "Show Parry Floating Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_ParryBtn_SetEnabled then getgenv().Gluto_ParryBtn_SetEnabled(v) end
    end,
})
SURV_R:AddToggle("ParryV1Aggressive", {
    Text = "Aggressive Mode",
    Default = false,
    Callback = function(v) VD.PARRY_Aggressive = v end,
})
SURV_R:AddSlider("ParryV1Dist", {
    Text = "Parry Distance",
    Min = 4, Max = 30, Default = 10, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) VD.PARRY_Distance = v end,
})
SURV_R:AddToggle("ParryV1ShowCircle", {
    Text = "Show Parry Range",
    Default = false,
    Callback = function(v)
        VD.PARRY_ShowCircle = v
        if not v and getgenv()._FAZZ_DestroyParryCircle then
            pcall(getgenv()._FAZZ_DestroyParryCircle)
        end
    end,
})
SURV_R:AddToggle("ParryV1Silent", {
    Text = "Silent Parry (Legit)",
    Default = false,
    Callback = function(v) VD.PARRY_SilentParry = v end,
})

-- ─── AUTO PARRY V2 ───
SURV_R:AddDivider()
SURV_R:AddLabel("🛡️ Auto Parry V2")
SURV_R:AddToggle("ParryV2", {
    Text = "Enable Auto Parry V2",
    Default = false,
    Callback = function(v)
        VD.FAZZ_ParryV2_Enabled = v and true or false
        if v then VD_Notify("Auto Parry V2", "Enabled", 2)
        else VD_Notify("Auto Parry V2", "Disabled", 2) end
    end,
})
SURV_R:AddToggle("ParryV2Aggressive", {
    Text = "Aggressive Mode",
    Default = false,
    Callback = function(v) VD.FAZZ_ParryV2_Aggressive = v and true or false end,
})
SURV_R:AddToggle("ParryV2Safety", {
    Text = "Safety Parry",
    Default = false,
    Callback = function(v) VD.FAZZ_ParryV2_Safety = v and true or false end,
})
SURV_R:AddSlider("ParryV2Dist", {
    Text = "Parry Distance",
    Min = 4, Max = 25, Default = 6, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) VD.FAZZ_ParryV2_Distance = v end,
})
SURV_R:AddSlider("ParryV2Face", {
    Text = "Face Sensitivity Killer",
    Min = -1, Max = 1, Default = 0.7, Rounding = 2,
    Callback = function(v) VD.FAZZ_ParryV2_Face = v end,
})
SURV_R:AddToggle("ParryV2Circle", {
    Text = "Show Range Circle",
    Default = true,
    Callback = function(v) VD.FAZZ_ParryV2_Circle = v and true or false end,
})

-- ─── FAKE PARRY ───
SURV_R:AddDivider()
SURV_R:AddLabel("🎭 Fake Parry")
SURV_R:AddToggle("FakeParry", {
    Text = "Enable Fake Parry",
    Default = false,
    Callback = function(v)
        if W.FakeParry_SetEnabled then W.FakeParry_SetEnabled(v) end
        if getgenv().Gluto_FakeParryBtn_UpdateVisual then getgenv().Gluto_FakeParryBtn_UpdateVisual() end
        if v then VD_Notify("Fake Parry", "Enabled", 2) end
    end,
})
SURV_R:AddToggle("ShowFakeParryBtn", {
    Text = "Show Fake Parry Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_FakeParryBtn_SetEnabled then getgenv().Gluto_FakeParryBtn_SetEnabled(v) end
    end,
})

-- ─── AUTO SKILL CHECK ───
SURV_R:AddDivider()
SURV_R:AddLabel("🎯 Auto Skill Check")
SURV_R:AddToggle("SkillCheck", {
    Text = "Enable Auto Skill Check",
    Default = false,
    Callback = function(v)
        W.SkillCheck_SetEnabled(v)
        if v then VD_Notify("Auto Skill Check", "Enabled", 2) end
    end,
})
SURV_R:AddDropdown("SkillCheckMode", {
    Values = {"Legit", "Instant"},
    Default = "Legit",
    Text = "Mode",
    Callback = function(v) W.SkillCheck.Mode = v end,
})

-- ─── BYPASS SELF UNHOOK ───
SURV_R:AddDivider()
SURV_R:AddLabel("🪝 Bypass Self Unhook")
SURV_R:AddToggle("SelfUnhook", {
    Text = "Enable Bypass Self Unhook",
    Default = false,
    Callback = function(v)
        W.SU_SetEnabled(v)
        if getgenv().Gluto_SUB_UpdateVisual then getgenv().Gluto_SUB_UpdateVisual() end
        if v then VD_Notify("Bypass Self Unhook", "Enabled", 2) end
    end,
})
SURV_R:AddToggle("ShowHookBtn", {
    Text = "Show Hook Floating Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_SUB_SetEnabled then getgenv().Gluto_SUB_SetEnabled(v) end
    end,
})
SURV_R:AddSlider("SelfUnhookDuration", {
    Text = "Follow Duration",
    Min = 5, Max = 120, Default = 30, Rounding = 0,
    Suffix = "s",
    Callback = function(v) W.SelfUnhook.FollowDuration = v end,
})
SURV_R:AddSlider("SelfUnhookDist", {
    Text = "Follow Distance",
    Min = 5, Max = 60, Default = 20, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.SelfUnhook.FollowDistance = v end,
})

-- ─── SILENT AIM TOF ───
SURV_R:AddDivider()
SURV_R:AddLabel("🎯 Silent Aim ToF")
SURV_R:AddToggle("ToFSilentAim", {
    Text = "Enable Silent Aim",
    Default = false,
    Callback = function(v)
        W.SetToFSilentAim(v)
        if v then VD_Notify("Silent Aim ToF", "Enabled", 2) end
    end,
})
SURV_R:AddDropdown("ToFTargetMode", {
    Values = {"Killer", "Survivors", "Zombie"},
    Default = "Killer",
    Text = "Target Mode",
    Callback = function(v) W.ToF_SetTargetMode(v, true) end,
})
SURV_R:AddKeybind("ToFKey", {
    Text = "Toggle Key",
    Default = Enum.KeyCode.Q,
    Callback = function(kc) VD.TOF_Key = kc and kc.Name or "None" end,
})
SURV_R:AddToggle("ToFLaser", {
    Text = "Show Laser Beam",
    Default = true,
    Callback = function(v)
        VD.TOF_Laser = v
        if not v and W.ToF_ClearLaser then W.ToF_ClearLaser() end
    end,
})
SURV_R:AddToggle("ToFWallCheck", {
    Text = "Wall Check",
    Default = true,
    Callback = function(v) VD.TOF_WallCheck = v end,
})
SURV_R:AddToggle("ToFBlockKnocked", {
    Text = "Block When Knocked",
    Default = true,
    Callback = function(v) VD.TOF_BlockKnocked = v end,
})

-- ─── SILENT FLASHLIGHT ───
SURV_R:AddDivider()
SURV_R:AddLabel("🔦 Silent Flashlight")
SURV_R:AddToggle("FlashlightSilent", {
    Text = "Enable Silent Flashlight",
    Default = false,
    Callback = function(v)
        W.Flash_SetEnabled(v)
        if v then VD_Notify("Silent Flashlight", "Enabled", 2) end
    end,
})
SURV_R:AddDropdown("FlashlightTargetPart", {
    Values = {"Head", "UpperTorso", "Torso", "HumanoidRootPart"},
    Default = "Head",
    Text = "Target Part",
    Callback = function(v) VD.FLASH_TargetPart = v end,
})
SURV_R:AddSlider("FlashlightRange", {
    Text = "Max Range",
    Min = 20, Max = 250, Default = 120, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) VD.FLASH_Range = v end,
})
SURV_R:AddSlider("FlashlightSmooth", {
    Text = "Smoothness",
    Min = 0.05, Max = 1, Default = 0.35, Rounding = 2,
    Callback = function(v) VD.FLASH_Smooth = v end,
})
SURV_R:AddToggle("FlashlightLaser", {
    Text = "Show Laser",
    Default = true,
    Callback = function(v)
        VD.FLASH_Laser = v
        if not v and W.Flash_ClearLaser then W.Flash_ClearLaser() end
    end,
})

-- ─── AIM LOCK GUN ───
SURV_R:AddDivider()
SURV_R:AddLabel("🎯 Aim Lock Gun")
SURV_R:AddToggle("AimLockGun", {
    Text = "Enable Aim Lock Gun",
    Default = false,
    Callback = function(v)
        if W.GunAim_Cfg then W.GunAim_Cfg.Enabled = v end
        if v and W.GunAim_Start then W.GunAim_Start() end
        if v then VD_Notify("Aim Lock Gun", "Hold M2 to lock", 2) end
    end,
})

-- ─── ANTI FALL DAMAGE ───
SURV_R:AddDivider()
SURV_R:AddToggle("NoFallDamage", {
    Text = "Anti Fall Damage",
    Default = false,
    Callback = function(v)
        VD.NoFallDamage = v and true or false
        if v then VD_Notify("No Fall Damage", "Enabled", 2) end
    end,
})

-- ─── NEXT MAP PREDICTION ───
SURV_R:AddToggle("NextMapPredict", {
    Text = "Next Map Prediction",
    Default = false,
    Callback = function(v)
        if W.NextMapPredict_SetEnabled then W.NextMapPredict_SetEnabled(v) end
        if v then VD_Notify("Map Prediction", "Enabled", 2) end
    end,
})

-- ─── MANUAL GENERATOR ───
SURV_R:AddDivider()
SURV_R:AddLabel("⚡ Generator Automation")
SURV_R:AddToggle("ManualGen", {
    Text = "Enable Manual Generator",
    Default = false,
    Callback = function(v)
        if W.ManualGen_SetEnabled then W.ManualGen_SetEnabled(v) end
        if v then VD_Notify("Manual Gen", "Enabled", 2) end
    end,
})
SURV_R:AddToggle("AutoGen", {
    Text = "Enable Auto Generator",
    Default = false,
    Callback = function(v)
        if W.AutoGen_SetEnabled then W.AutoGen_SetEnabled(v) end
        if v then VD_Notify("Auto Gen", "Enabled", 2) end
    end,
})
SURV_R:AddSlider("GenEscapeDist", {
    Text = "Killer Escape Distance",
    Min = 10, Max = 80, Default = 30, Rounding = 0,
    Suffix = " studs",
    Callback = function(v)
        if W.GenAuto_SetDistance then W.GenAuto_SetDistance(v) end
    end,
})

-- ─── MOONWALK ───
SURV_R:AddDivider()
SURV_R:AddLabel("🌙 Moonwalk")
SURV_R:AddToggle("Moonwalk", {
    Text = "Enable Moonwalk (F8)",
    Default = false,
    Callback = function(v)
        if W.Moonwalk_SetEnabled then W.Moonwalk_SetEnabled(v) end
        if getgenv().Gluto_MoonwalkBtn_UpdateVisual then getgenv().Gluto_MoonwalkBtn_UpdateVisual() end
        if v then VD_Notify("Moonwalk", "Enabled", 2) end
    end,
})
SURV_R:AddToggle("ShowMoonwalkBtn", {
    Text = "Show Moonwalk Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_MoonwalkBtn_SetEnabled then getgenv().Gluto_MoonwalkBtn_SetEnabled(v) end
    end,
})
SURV_R:AddSlider("MoonwalkSide", {
    Text = "Side Speed",
    Min = 0.1, Max = 3, Default = 0.9, Rounding = 1,
    Callback = function(v) if W.Moonwalk_SetSideSpeed then W.Moonwalk_SetSideSpeed(v) end end,
})
SURV_R:AddSlider("MoonwalkBack", {
    Text = "Back Speed",
    Min = 0.1, Max = 3, Default = 1.2, Rounding = 1,
    Callback = function(v) if W.Moonwalk_SetBackSpeed then W.Moonwalk_SetBackSpeed(v) end end,
})

-- ─── FAKE PERKS FLOATING ───
SURV_R:AddDivider()
SURV_R:AddToggle("ShowFakePerksBtn", {
    Text = "Show Fake Perks Floating Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_FakePerksBtn_SetEnabled then getgenv().Gluto_FakePerksBtn_SetEnabled(v) end
    end,
})

-- ─── KILLER PERKS DISPLAY ───
SURV_R:AddToggle("KillerPerksDisplay", {
    Text = "Killer Perks Display",
    Default = false,
    Callback = function(v)
        if W.KillerPerksDisplay_SetEnabled then W.KillerPerksDisplay_SetEnabled(v) end
        if v then VD_Notify("Killer Perks Display", "Enabled", 2) end
    end,
})

-- ═══════════════════════════════════════════════════════════════════
--  VISUALS TAB
-- ═══════════════════════════════════════════════════════════════════
local VIS_L = Tabs.Visuals:AddLeftGroupbox("ESP", "eye")
local VIS_R = Tabs.Visuals:AddRightGroupbox("World & Graphics", "globe")

-- ─── FULL ESP SYSTEM ───
VIS_L:AddLabel("👁️ Full ESP System")
VIS_L:AddDivider()
VIS_L:AddToggle("ESP_Survivor", {
    Text = "ESP Survivor",
    Default = false,
    Callback = function(v) W.FullESP.Survivor = v end,
})
VIS_L:AddColorPicker("ESP_SurvivorColor", {
    Text = "Survivor Color",
    Default = W.FullESPColors.Survivor,
    Callback = function(c) W.FullESPColors.Survivor = c end,
})
VIS_L:AddToggle("ESP_Killer", {
    Text = "ESP Killer",
    Default = false,
    Callback = function(v) W.FullESP.Killer = v end,
})
VIS_L:AddColorPicker("ESP_KillerColor", {
    Text = "Killer Color",
    Default = W.FullESPColors.Killer,
    Callback = function(c) W.FullESPColors.Killer = c end,
})
VIS_L:AddToggle("ESP_Generator", {
    Text = "ESP Generator",
    Default = false,
    Callback = function(v) W.FullESP.Generator = v end,
})
VIS_L:AddColorPicker("ESP_GeneratorColor", {
    Text = "Generator Color",
    Default = W.FullESPColors.Generator,
    Callback = function(c) W.FullESPColors.Generator = c end,
})
VIS_L:AddToggle("ESP_Pallet", {
    Text = "ESP Pallet",
    Default = false,
    Callback = function(v) W.FullESP.Pallet = v end,
})
VIS_L:AddColorPicker("ESP_PalletColor", {
    Text = "Pallet Color",
    Default = W.FullESPColors.Pallet,
    Callback = function(c) W.FullESPColors.Pallet = c end,
})
VIS_L:AddToggle("ESP_Window", {
    Text = "ESP Window",
    Default = false,
    Callback = function(v)
        W.FullESP.Window = v
        _G.FAZZWindowScanned = false
    end,
})
VIS_L:AddColorPicker("ESP_WindowColor", {
    Text = "Window Color",
    Default = W.FullESPColors.Window,
    Callback = function(c) W.FullESPColors.Window = c end,
})
VIS_L:AddToggle("ESP_SCP", {
    Text = "ESP SCP",
    Default = false,
    Callback = function(v) W.FullESP.SCP = v end,
})
VIS_L:AddColorPicker("ESP_SCPColor", {
    Text = "SCP Color",
    Default = W.FullESPColors.SCP,
    Callback = function(c) W.FullESPColors.SCP = c end,
})
VIS_L:AddSlider("ESP_Radius", {
    Text = "ESP Radius",
    Min = 10, Max = 1000, Default = 500, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.FullESP.Distance = v end,
})

-- ─── ESP STATUS ───
VIS_L:AddDivider()
VIS_L:AddLabel("📋 ESP Status")
VIS_L:AddToggle("StatusESP", {
    Text = "Enable Status ESP",
    Default = false,
    Callback = function(v) W.FullESPStatus.Enabled = v end,
})
VIS_L:AddToggle("StatusESP_Name", {
    Text = "Show Name",
    Default = true,
    Callback = function(v) W.FullESPStatus.ShowName = v end,
})
VIS_L:AddToggle("StatusESP_Distance", {
    Text = "Show Distance",
    Default = true,
    Callback = function(v) W.FullESPStatus.ShowDistance = v end,
})
VIS_L:AddToggle("StatusESP_Avatar", {
    Text = "Show Avatar",
    Default = true,
    Callback = function(v) W.FullESPStatus.ShowAvatar = v end,
})
VIS_L:AddToggle("StatusESP_Action", {
    Text = "Show Action",
    Default = true,
    Callback = function(v) W.FullESPStatus.ShowAction = v end,
})
VIS_L:AddToggle("StatusESP_Health", {
    Text = "Show Health Bar",
    Default = false,
    Callback = function(v) W.FullESPStatus.ShowHealth = v end,
})
VIS_L:AddSlider("StatusESP_Radius", {
    Text = "Status Radius",
    Min = 20, Max = 1000, Default = 500, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.FullESPStatus.Radius = v end,
})

-- ═══════════════════════════════════════════════════════════════════
--  VISUALS RIGHT — WORLD & GRAPHICS
-- ═══════════════════════════════════════════════════════════════════

-- ─── GRAPHICS ───
VIS_R:AddLabel("🎨 Graphics")
VIS_R:AddDivider()
VIS_R:AddToggle("GFX_Fullbright", {
    Text = "Fullbright",
    Default = false,
    Callback = function(v) W.Graphics.Fullbright = v; W.Graphics_Apply() end,
})
VIS_R:AddToggle("GFX_NoShadow", {
    Text = "No Shadow",
    Default = false,
    Callback = function(v) W.Graphics.NoShadow = v; W.Graphics_Apply() end,
})
VIS_R:AddToggle("GFX_LowGraphics", {
    Text = "Low Graphics",
    Default = false,
    Callback = function(v) W.Graphics.LowGraphics = v; W.Graphics_ApplyOptimization() end,
})
VIS_R:AddToggle("GFX_NoScreenEffects", {
    Text = "No Screen Effects",
    Default = false,
    Callback = function(v) W.Graphics.NoScreenEffects = v; W.Graphics_ApplyNoScreenFx() end,
})
VIS_R:AddToggle("GFX_CleanSky", {
    Text = "Clean Sky",
    Default = false,
    Callback = function(v) W.Graphics.CleanSky = v; W.Graphics_ApplyOptimization() end,
})
VIS_R:AddToggle("GFX_Potato", {
    Text = "Potato Mode (Extreme)",
    Default = false,
    Callback = function(v)
        if W.Potato_SetEnabled then
            W.Potato_SetEnabled(v)
            if v then VD_Notify("Potato Mode", "Enabled", 3) else VD_Notify("Potato Mode", "Disabled", 3) end
        end
    end,
})

-- ─── CLOCK & AMBIENT ───
VIS_R:AddDivider()
VIS_R:AddLabel("🕐 Clock & Ambient")
VIS_R:AddToggle("GFX_ClockOverride", {
    Text = "Enable Clock Override",
    Default = false,
    Callback = function(v) W.Graphics.ClockTimeEnabled = v; W.Graphics_Apply() end,
})
VIS_R:AddSlider("GFX_ClockTime", {
    Text = "Clock Time",
    Min = 0, Max = 24, Default = 14, Rounding = 0,
    Callback = function(v)
        W.Graphics.ClockTime = v
        W.Graphics.ClockTimeEnabled = true
        W.Graphics_Apply()
    end,
})
VIS_R:AddSlider("GFX_Brightness", {
    Text = "Brightness",
    Min = 0, Max = 5, Default = 2, Rounding = 1,
    Callback = function(v)
        W.Graphics.Brightness = v
        W.Graphics.ClockTimeEnabled = true
        W.Graphics_Apply()
    end,
})

-- ─── ZOOM & FOV ───
VIS_R:AddDivider()
VIS_R:AddLabel("🔍 Zoom & FOV")
VIS_R:AddToggle("GFX_UnlimitedZoom", {
    Text = "Unlimited Zoom",
    Default = false,
    Callback = function(v) W.Graphics.UnlimitedZoom = v; W.Graphics_ApplyZoom() end,
})
VIS_R:AddSlider("GFX_MaxZoom", {
    Text = "Max Zoom Distance",
    Min = 100, Max = 5000, Default = 1000, Rounding = 0,
    Callback = function(v)
        W.Graphics.MaxZoomDistance = v
        if W.Graphics.UnlimitedZoom then W.Graphics_ApplyZoom() end
    end,
})
VIS_R:AddToggle("GFX_CustomFOV", {
    Text = "Custom FOV",
    Default = false,
    Callback = function(v) W.Graphics.FOVEnabled = v; W.Graphics_ApplyFOV() end,
})
VIS_R:AddSlider("GFX_FOV", {
    Text = "Camera FOV",
    Min = 40, Max = 120, Default = 70, Rounding = 0,
    Callback = function(v)
        W.Graphics.FOV = v
        if W.Graphics.FOVEnabled then W.Graphics_ApplyFOV() end
    end,
})

-- ─── LOCK POV ───
VIS_R:AddDivider()
VIS_R:AddLabel("📷 Lock POV")
VIS_R:AddToggle("LockPOV", {
    Text = "Enable Lock POV",
    Default = false,
    Callback = function(v)
        W.LockPOV_SetEnabled(v)
        if v then VD_Notify("Lock POV", "Enabled", 2) end
    end,
})
VIS_R:AddSlider("LockPOVValue", {
    Text = "Locked FOV",
    Min = 40, Max = 120, Default = 80, Rounding = 0,
    Callback = function(v)
        W.LockPOV.LockedFOV = v
        if W.LockPOV.Enabled then
            local cam = Workspace.CurrentCamera
            if cam then cam.FieldOfView = v end
        end
    end,
})

-- ═══════════════ SECTION 13 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 13 loaded — Survivor + Visuals Tab ready")-- ═══════════════════════════════════════════════════════════════════
--  [SECTION 14] UI Build — Killer Tab + Misc Tab + Troll Tab + Config
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════════
--  KILLER TAB
-- ═══════════════════════════════════════════════════════════════════
local KIL_L = Tabs.Killer:AddLeftGroupbox("Killer", "swords")
local KIL_R = Tabs.Killer:AddRightGroupbox("Combat", "crosshair")

-- ─── AUTO ATTACK ───
KIL_L:AddLabel("⚔️ Auto Attack")
KIL_L:AddDivider()
KIL_L:AddToggle("AutoAttack", {
    Text = "Enable Auto Attack",
    Default = false,
    Callback = function(v)
        VD.KILLER_AutoAttack = v
        if v then VD_Notify("Auto Attack", "Enabled", 2) else VD_Notify("Auto Attack", "Disabled", 2) end
    end,
})
KIL_L:AddSlider("AutoAttackRange", {
    Text = "Attack Range",
    Min = 5, Max = 30, Default = 12, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) VD.KILLER_AutoAttackRange = v end,
})
KIL_L:AddSlider("AutoAttackCooldown", {
    Text = "Attack Cooldown",
    Min = 0.05, Max = 1, Default = 0.15, Rounding = 2,
    Suffix = "s",
    Callback = function(v) VD.KILLER_AutoAttackCooldown = v end,
})

-- ─── INFINITE LUNGE ───
KIL_L:AddDivider()
KIL_L:AddToggle("InfiniteLunge", {
    Text = "Infinite Lunge (Basic Attack)",
    Default = false,
    Callback = function(v)
        VD.KILLER_InfLunge = v
        if v then VD_Notify("Infinite Lunge", "Enabled", 2) end
    end,
})

-- ─── AIM LOCK HIDDEN ───
KIL_L:AddDivider()
KIL_L:AddLabel("🎯 Aim Lock Hidden")
KIL_L:AddToggle("AimLockHidden", {
    Text = "Enable Aim Lock Hidden",
    Default = false,
    Callback = function(state) W.AimLockHidden_SetEnabled(state) end,
})
KIL_L:AddInput("AimLockHiddenKey", {
    Text = "Hold Keybind",
    Default = "E",
    Placeholder = "E / Q / F / LeftShift",
    Callback = function(input)
        input = tostring(input or ""):gsub("%s+", "")
        if input == "" then return end
        local map = {
            ["leftshift"] = Enum.KeyCode.LeftShift,
            ["rightshift"] = Enum.KeyCode.RightShift,
            ["leftalt"] = Enum.KeyCode.LeftAlt,
            ["rightalt"] = Enum.KeyCode.RightAlt,
            ["leftctrl"] = Enum.KeyCode.LeftControl,
            ["rightctrl"] = Enum.KeyCode.RightControl,
            ["leftcontrol"] = Enum.KeyCode.LeftControl,
            ["rightcontrol"] = Enum.KeyCode.RightControl,
            ["space"] = Enum.KeyCode.Space,
            ["tab"] = Enum.KeyCode.Tab,
        }
        local newKey = map[input:lower()]
        if not newKey then
            local ok, kc = pcall(function()
                return Enum.KeyCode[input:upper():sub(1, 1) .. input:lower():sub(2)]
            end)
            if ok and kc then newKey = kc end
        end
        if newKey and W.AimLockHidden_SetKey then
            W.AimLockHidden_SetKey(newKey)
            VD_Notify("Aim Lock", "Hold key: " .. newKey.Name, 2)
        end
    end,
})

-- ─── AIM LOCK ATTACK ───
KIL_L:AddDivider()
KIL_L:AddLabel("🎯 Aim Lock Attack")
KIL_L:AddToggle("AimLockAttack", {
    Text = "Enable Aim Lock Attack",
    Default = false,
    Callback = function(v)
        if W.AttackAim_Cfg then W.AttackAim_Cfg.Enabled = v end
        if v and W.AttackAim_Start then W.AttackAim_Start() end
        if v then VD_Notify("Aim Lock Attack", "Hold M2 to lock", 2) end
    end,
})
KIL_L:AddSlider("AimLockAttackFOV", {
    Text = "FOV Radius",
    Min = 50, Max = 1000, Default = 250, Rounding = 0,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.FOV = v end end,
})
KIL_L:AddSlider("AimLockAttackSmooth", {
    Text = "Aim Smoothness",
    Min = 0.1, Max = 1, Default = 1, Rounding = 2,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.Strength = v end end,
})
KIL_L:AddSlider("AimLockAttackPredict", {
    Text = "Prediction Strength",
    Min = 0, Max = 1, Default = 0.12, Rounding = 2,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.PredictStrength = v end end,
})
KIL_L:AddDropdown("AimLockAttackPart", {
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "Torso"},
    Default = "HumanoidRootPart",
    Text = "Aim Part",
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.AimPart = v end end,
})
KIL_L:AddToggle("AimLockAttackVisibility", {
    Text = "Visibility Check",
    Default = true,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.VisibilityCheck = v end end,
})

-- ─── ANTI BLIND ───
KIL_L:AddDivider()
KIL_L:AddToggle("AntiBlind", {
    Text = "Anti Blind (Flashlight)",
    Default = false,
    Callback = function(v)
        VD.KILLER_AntiBlind = v
        if v and W.SetupAntiBlind then pcall(W.SetupAntiBlind) end
        if v then VD_Notify("Anti Blind", "Enabled", 2) end
    end,
})

-- ─── DESTROY PALLET ───
KIL_L:AddDivider()
KIL_L:AddToggle("DestroyPallet", {
    Text = "Auto Destroy Pallet",
    Default = false,
    Callback = function(v)
        VD.KILLER_DestroyPallets = v
        if v then VD_Notify("Destroy Pallet", "Enabled", 2) end
    end,
})

-- ─── SELECT MASKED ───
KIL_L:AddDivider()
KIL_L:AddLabel("🎭 Select Masked Power")
KIL_L:AddDropdown("MaskedPower", {
    Values = W.Masked.Powers,
    Default = W.Masked.CurrentPower,
    Text = "Masked Power",
    Callback = function(v)
        W.Masked.CurrentPower = v
        VD_Notify("Select Masked", "Selected: " .. v, 1)
    end,
})
KIL_L:AddButton({
    Text = "Activate Power",
    Func = function() W.Masked_Activate() end,
})
KIL_L:AddButton({
    Text = "Deactivate Power",
    Func = function() W.Masked_Deactivate() end,
})

-- ─── SPEAR AIMBOT ───
KIL_L:AddDivider()
KIL_L:AddLabel("🗡️ Spear Aimbot")
KIL_L:AddToggle("SpearAimbot", {
    Text = "Enable Spear Aimbot",
    Default = false,
    Callback = function(v)
        if W.SpearAimbot_SetEnabled then W.SpearAimbot_SetEnabled(v) end
        if getgenv().Gluto_SpearBtn_UpdateVisual then getgenv().Gluto_SpearBtn_UpdateVisual() end
        if v then VD_Notify("Spear Aimbot", "Enabled", 2) end
    end,
})
KIL_L:AddToggle("ShowSpearBtn", {
    Text = "Show Spear Floating Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_SpearBtn_SetEnabled then getgenv().Gluto_SpearBtn_SetEnabled(v) end
    end,
})
KIL_L:AddSlider("SpearGravity", {
    Text = "Spear Gravity",
    Min = 10, Max = 200, Default = 50, Rounding = 0,
    Callback = function(v) if W.SpearAimbot_SetGravity then W.SpearAimbot_SetGravity(v) end end,
})
KIL_L:AddSlider("SpearSpeed", {
    Text = "Spear Speed",
    Min = 50, Max = 300, Default = 100, Rounding = 0,
    Callback = function(v) if W.SpearAimbot_SetSpeed then W.SpearAimbot_SetSpeed(v) end end,
})

-- ═══════════════════════════════════════════════════════════════════
--  KILLER RIGHT — COMBAT
-- ═══════════════════════════════════════════════════════════════════

-- ─── SILENT VEIL V1 ───
KIL_R:AddLabel("🗡️ Silent Veil V1")
KIL_R:AddToggle("VeilV1", {
    Text = "Enable Silent Veil V1",
    Default = false,
    Callback = function(v)
        VD.VeilEnabled = v
        if not v then
            VeilState.target = nil
            VeilState.lookVector = nil
        end
        if getgenv().Gluto_VeilBtn_UpdateVisual then getgenv().Gluto_VeilBtn_UpdateVisual() end
        if v then VD_Notify("Silent Veil V1", "Enabled", 2) end
    end,
})
KIL_R:AddToggle("ShowVeilBtn", {
    Text = "Show Veil Floating Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_VeilBtn_SetEnabled then getgenv().Gluto_VeilBtn_SetEnabled(v) end
    end,
})
KIL_R:AddToggle("VeilV1ShowFOV", {
    Text = "Show FOV Circle",
    Default = true,
    Callback = function(v) VD.VeilShowFOV = v end,
})
KIL_R:AddToggle("VeilV1Tracker", {
    Text = "Show Target Tracker",
    Default = false,
    Callback = function(v) VD.VeilShowTracker = v end,
})
KIL_R:AddToggle("VeilV1AutoPredict", {
    Text = "Auto Predict",
    Default = true,
    Callback = function(v) VD.VeilAutoPredict = v end,
})
KIL_R:AddSlider("VeilV1FOV", {
    Text = "FOV Size",
    Min = 50, Max = 500, Default = 150, Rounding = 0,
    Callback = function(v) VD.VeilFOV = v end,
})
KIL_R:AddSlider("VeilV1MaxDist", {
    Text = "Max Distance",
    Min = 50, Max = 280, Default = 280, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) VD.VeilMaxDist = v end,
})
KIL_R:AddSlider("VeilV1Speed", {
    Text = "Spear Speed",
    Min = 50, Max = 400, Default = 165, Rounding = 0,
    Callback = function(v) VD.VeilSpearSpeed = v end,
})
KIL_R:AddSlider("VeilV1Gravity", {
    Text = "Spear Gravity",
    Min = 10, Max = 300, Default = 103, Rounding = 0,
    Callback = function(v) VD.VeilGravity = v end,
})
KIL_R:AddSlider("VeilV1Lead", {
    Text = "Lead Multiplier",
    Min = 0.1, Max = 5, Default = 1.4, Rounding = 1,
    Callback = function(v) VD.VeilLeadMultiplier = v end,
})

-- ─── SILENT VEIL V2 ───
KIL_R:AddDivider()
KIL_R:AddLabel("🗡️ Silent Veil V2")
KIL_R:AddToggle("VeilV2_Enabled", {
    Text = "Silent Veil V2",
    Default = false,
    Callback = function(v)
        if W.VeilV2_API then
            W.VeilV2_API.AimConfig.Aim_SilentVeilV2 = v
            VD_Notify("Silent Veil V2", v and "ON" or "OFF", 2)
        end
    end,
})
KIL_R:AddToggle("VeilV2_AutoPredict", {
    Text = "Auto Predict",
    Default = false,
    Callback = function(v)
        if W.VeilV2_API then W.VeilV2_API.Config.SpearSmart_enable = v end
    end,
})
KIL_R:AddSlider("VeilV2_Lead", {
    Text = "Lead Multiplier",
    Min = 0.5, Max = 5, Default = 1.4, Rounding = 1,
    Callback = function(v)
        if W.VeilV2_API then W.VeilV2_API.AimConfig.Veil_LeadMultiplier = v end
    end,
})
KIL_R:AddSlider("VeilV2_Speed", {
    Text = "Spear Speed",
    Min = 50, Max = 200, Default = 165, Rounding = 0,
    Callback = function(v)
        if W.VeilV2_API then W.VeilV2_API.AimConfig.SPEAR_Speed = v end
    end,
})
KIL_R:AddSlider("VeilV2_Gravity", {
    Text = "Spear Gravity",
    Min = 0, Max = 200, Default = 103, Rounding = 0,
    Callback = function(v)
        if W.VeilV2_API then W.VeilV2_API.AimConfig.SPEAR_Gravity = v end
    end,
})
KIL_R:AddToggle("VeilV2_Tracker", {
    Text = "ESP Tracker Target",
    Default = false,
    Callback = function(v)
        if W.VeilV2_API and W.VeilV2_API.setTracker then W.VeilV2_API.setTracker(v) end
    end,
})
KIL_R:AddToggle("VeilV2_ShowFOV", {
    Text = "Show Veil FOV",
    Default = true,
    Callback = function(v)
        if W.VeilV2_API then W.VeilV2_API.AimConfig.Veil_ShowFOV = v end
    end,
})
KIL_R:AddSlider("VeilV2_FOV", {
    Text = "Veil FOV Radius",
    Min = 50, Max = 500, Default = 150, Rounding = 0,
    Callback = function(v)
        if W.VeilV2_API then W.VeilV2_API.AimConfig.Veil_FOV = v end
    end,
})

-- ─── BYPASS NO COOLDOWN ───
KIL_R:AddDivider()
KIL_R:AddLabel("⚡ Bypass No Cooldown")
KIL_R:AddToggle("Bypass_HiddenLeap", {
    Text = "Hidden - Leap Bypass",
    Default = false,
    Callback = function(v)
        W.Bypass_SetHiddenLeap(v)
        if v then VD_Notify("Bypass", "Hidden Leap: ON", 2) end
    end,
})
KIL_R:AddToggle("Bypass_MyersGrab", {
    Text = "Myers - Infinite Grab (H)",
    Default = false,
    Callback = function(v)
        W.setMyersGrab(v)
        if getgenv().Gluto_MGrabBtn_UpdateVisual then getgenv().Gluto_MGrabBtn_UpdateVisual() end
        if v then VD_Notify("Bypass", "Inf Grab: ON (H)", 2) end
    end,
})
KIL_R:AddToggle("Bypass_LakeMist", {
    Text = "Slasher - Infinite LakeMist",
    Default = false,
    Callback = function(v) W.Bypass_SetLakeMist(v) end,
})
KIL_R:AddToggle("Bypass_Pursuit", {
    Text = "Slasher - Infinite Pursuit",
    Default = false,
    Callback = function(v) W.Bypass_SetPursuit(v) end,
})
KIL_R:AddToggle("Bypass_Abyss", {
    Text = "Abyss - Bypass Cooldown",
    Default = false,
    Callback = function(v) W.Bypass_SetAbyss(v) end,
})
KIL_R:AddToggle("Bypass_JeffFrenzy", {
    Text = "Jeff - Infinite Frenzy",
    Default = false,
    Callback = function(v) W.Bypass_SetJeffFrenzy(v) end,
})
KIL_R:AddButton({
    Text = "Auto-Fix Boolean Math",
    Func = function() W.Bypass_FixBooleanMath() end,
})

-- ─── UNLOCK SKILL WHILE CARRYING ───
KIL_R:AddDivider()
KIL_R:AddToggle("UnlockCarry", {
    Text = "Unlock Skill While Carrying",
    Default = false,
    Callback = function(v) W.UnlockCarry_SetEnabled(v) end,
})

-- ─── KILLER ABILITIES ───
KIL_R:AddDivider()
KIL_R:AddLabel("🎯 Killer Abilities")
KIL_R:AddToggle("KA_AutoStalk", {
    Text = "Auto Stalk (Myers)",
    Default = false,
    Callback = function(v)
        W.KA_SetAutoStalk(v)
        VD_Notify("Auto Stalk", v and "Enabled" or "Disabled", 2)
    end,
})
KIL_R:AddSlider("KA_AutoStalkRange", {
    Text = "Auto Stalk Range",
    Min = 20, Max = 500, Default = 150, Rounding = 0,
    Suffix = " studs",
    Callback = function(v)
        W.KillerAbilities.AutoStalkRange = v
        VD.KA_AutoStalkRange = v
    end,
})
KIL_R:AddToggle("KA_AutoKillAll", {
    Text = "Auto Kill All",
    Default = false,
    Callback = function(v)
        W.KA_SetAutoKillAll(v)
        VD_Notify("Auto Kill All", v and "Enabled" or "Disabled", 2)
    end,
})
KIL_R:AddToggle("KA_DropAllPallet", {
    Text = "Drop All Pallet",
    Default = false,
    Callback = function(v)
        W.KA_SetDropAllPallet(v)
        VD_Notify("Drop All Pallet", v and "Enabled" or "Disabled", 2)
    end,
})
KIL_R:AddToggle("KA_BlockAllVault", {
    Text = "Block All Vault",
    Default = false,
    Callback = function(v)
        W.KA_SetBlockAllVault(v)
        VD_Notify("Block All Vault", v and "Enabled" or "Disabled", 2)
    end,
})
KIL_R:AddButton({
    Text = "Instant Auto Kill (1x)",
    Func = function()
        local saved = W.KillerAbilities.AutoKillAll
        W.KillerAbilities.AutoKillAll = true
        task.spawn(function()
            task.wait(0.3)
            W.KillerAbilities.AutoKillAll = saved
        end)
        VD_Notify("Auto Kill", "Triggered once", 2)
    end,
})
KIL_R:AddButton({
    Text = "Instant Drop All Pallet (1x)",
    Func = function()
        lastDropAllPallet = 0
        W.KillerAbilities.DropAllPallet = true
        pcall(W.KA_DropAllPallets)
        task.delay(0.3, function() W.KillerAbilities.DropAllPallet = false end)
    end,
})
KIL_R:AddButton({
    Text = "Instant Block All Vault (1x)",
    Func = function()
        pcall(W.KA_BlockAllVaults)
    end,
})
KIL_R:AddButton({
    Text = "Unblock All Vault (1x)",
    Func = function() W.KA_UnblockAllVaults() end,
})
KIL_R:AddToggle("KA_AutoHook", {
    Text = "Auto Hook",
    Default = false,
    Callback = function(v)
        if W.KA_SetAutoHook then W.KA_SetAutoHook(v) end
        if v then VD_Notify("Auto Hook", "Enabled", 2) else VD_Notify("Auto Hook", "Disabled", 2) end
    end,
})

-- ─── SILENT FLASK ───
KIL_R:AddDivider()
KIL_R:AddLabel("🧪 Silent Flask (The Cure)")
KIL_R:AddToggle("FlaskSilent", {
    Text = "Enable Silent Flask",
    Default = false,
    Callback = function(v)
        W.Flask_SetEnabled(v)
        if v then VD_Notify("Silent Flask", "Enabled", 2) end
    end,
})
KIL_R:AddToggle("FlaskBeam", {
    Text = "Show Beam",
    Default = true,
    Callback = function(v) VD.FLASK_ShowBeam = v and true or false end,
})
KIL_R:AddToggle("FlaskLanding", {
    Text = "Show Landing Marker",
    Default = true,
    Callback = function(v) VD.FLASK_ShowLanding = v and true or false end,
})
KIL_R:AddToggle("FlaskPredict", {
    Text = "Enable Prediction",
    Default = true,
    Callback = function(v) VD.FLASK_Predict = v and true or false end,
})
KIL_R:AddColorPicker("FlaskBeamColor", {
    Text = "Beam Color",
    Default = VD.FLASK_BeamColor,
    Callback = function(c) W.Flask_SetBeamColor(c) end,
})
KIL_R:AddColorPicker("FlaskAccentColor", {
    Text = "Accent Color",
    Default = VD.FLASK_AccentColor,
    Callback = function(c) W.Flask_SetAccentColor(c) end,
})
KIL_R:AddSlider("FlaskSpeed", {
    Text = "Flask Speed",
    Min = 30, Max = 200, Default = 90, Rounding = 0,
    Callback = function(v) W.Flask_SetSpeed(v) end,
})
KIL_R:AddSlider("FlaskGravity", {
    Text = "Flask Gravity",
    Min = 50, Max = 400, Default = 196, Rounding = 0,
    Callback = function(v) W.Flask_SetGravity(v) end,
})
KIL_R:AddSlider("FlaskLead", {
    Text = "Lead Multiplier",
    Min = 0, Max = 3, Default = 1.0, Rounding = 1,
    Callback = function(v) W.Flask_SetLead(v) end,
})
KIL_R:AddSlider("FlaskRange", {
    Text = "Max Range",
    Min = 50, Max = 500, Default = 200, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.Flask_SetRange(v) end,
})

-- ─── DASH LOCK ───
KIL_R:AddDivider()
KIL_R:AddLabel("⚡ Dash Lock")
KIL_R:AddToggle("DashLock", {
    Text = "Enable Dash Lock",
    Default = false,
    Callback = function(v)
        W.DashLock_SetEnabled(v)
        if v then VD_Notify("Dash Lock", "Enabled", 2) else VD_Notify("Dash Lock", "Disabled", 2) end
    end,
})
KIL_R:AddSlider("DashLockDuration", {
    Text = "Lock Duration",
    Min = 0.5, Max = 5, Default = 1.5, Rounding = 1,
    Suffix = "s",
    Callback = function(v) VD.DashLockDuration = v end,
})
KIL_R:AddSlider("DashLockSmooth", {
    Text = "Camera Smoothness",
    Min = 0.05, Max = 1, Default = 0.3, Rounding = 2,
    Callback = function(v) VD.DashLockSmoothness = v end,
})
KIL_R:AddToggle("DashLockFreeze", {
    Text = "Freeze Character During Lock",
    Default = false,
    Callback = function(v)
        VD.FreezeDuringDashLock = v and true or false
        if not v then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed == 0 then hum.WalkSpeed = 16 end
        end
    end,
})

-- ─── COUNTER AUTO PARRY ───
KIL_R:AddDivider()
KIL_R:AddToggle("CounterParry", {
    Text = "Counter Auto Parry",
    Default = false,
    Callback = function(v)
        if W.CounterParry_SetEnabled then W.CounterParry_SetEnabled(v) end
    end,
})

-- ═══════════════════════════════════════════════════════════════════
--  MISC TAB
-- ═══════════════════════════════════════════════════════════════════
local MISC_L = Tabs.Misc:AddLeftGroupbox("Misc", "wrench")
local MISC_R = Tabs.Misc:AddRightGroupbox("Server & Fun", "server")

-- ─── SETTINGS ───
MISC_L:AddLabel("⚙️ Settings")
MISC_L:AddDivider()
MISC_L:AddToggle("NotifyEnabled", {
    Text = "Enable Notifications",
    Default = true,
    Callback = function(v)
        W.NotifyEnabled = v
        if v then ForceNotify("Settings", "Notifications Enabled") end
    end,
})

-- ─── STUN INDICATOR ───
MISC_L:AddDivider()
MISC_L:AddLabel("💫 Stun Indicator")
MISC_L:AddToggle("StunIndicator", {
    Text = "Enable Stun Indicator",
    Default = false,
    Callback = function(v)
        W.SInd_SetEnabled(v)
        if v then VD_Notify("Stun Indicator", "Enabled", 2) end
    end,
})
MISC_L:AddDropdown("StunSound", {
    Values = {"Default", "Clash Royale", "Blash", "Coin", "Kururin Kuru",
        "Spongebob", "Fahhhh", "Cave", "Aughhh", "Samsung", "iPhone", "Siren"},
    Default = "Default",
    Text = "Stun Sound",
    Callback = function(v)
        W.StunIndicator.SelectedSound = v
        ForceNotify("Stun Indicator", "Sound: " .. v, 2)
    end,
})
MISC_L:AddToggle("StunSoundAlert", {
    Text = "Stun Sound Alert",
    Default = true,
    Callback = function(v) W.StunIndicator.SoundEnabled = v end,
})
MISC_L:AddSlider("StunRange", {
    Text = "Detect Range",
    Min = 50, Max = 2000, Default = 500, Rounding = 0,
    Suffix = " studs",
    Callback = function(v) W.StunIndicator.Range = v end,
})
MISC_L:AddSlider("StunVolume", {
    Text = "Sound Volume",
    Min = 0, Max = 5, Default = 1.5, Rounding = 1,
    Callback = function(v) W.StunIndicator.SoundVolume = v end,
})
MISC_L:AddButton({
    Text = "Preview Sound",
    Func = function()
        pcall(function()
            local snd = Instance.new("Sound")
            snd.SoundId = "rbxassetid://" .. tostring(W.SInd_GetActiveSoundId())
            snd.Volume = W.StunIndicator.SoundVolume or 1.5
            snd.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui") or Workspace
            snd:Play()
            snd.Ended:Connect(function() pcall(function() snd:Destroy() end) end)
            task.delay(5, function()
                pcall(function()
                    if snd and snd.Parent then snd:Destroy() end
                end)
            end)
        end)
    end,
})

-- ─── INVISIBILITY ───
MISC_L:AddDivider()
MISC_L:AddLabel("👻 Invisibility")
MISC_L:AddToggle("Invisibility", {
    Text = "Enable Invisibility",
    Default = false,
    Callback = function(v)
        W.Invisible_SetState(v, false)
        if getgenv().Gluto_InvisBtn_UpdateVisual then getgenv().Gluto_InvisBtn_UpdateVisual() end
    end,
})
MISC_L:AddToggle("ShowInvisBtn", {
    Text = "Show Invis Floating Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_InvisBtn_SetEnabled then getgenv().Gluto_InvisBtn_SetEnabled(v) end
    end,
})
MISC_L:AddKeybind("InvisHotkey", {
    Text = "Toggle Hotkey",
    Default = Enum.KeyCode.G,
    Callback = function(kc)
        if kc then VD.Invis_Hotkey = kc.Name end
        ForceNotify("Invisible", "Hotkey: " .. (kc and kc.Name or "None"), 2)
    end,
})

-- ─── CAMERA DBD ───
MISC_L:AddDivider()
MISC_L:AddLabel("🎥 Camera DBD")
MISC_L:AddToggle("CamDBD_Smooth", {
    Text = "DBD Camera (Smooth Follow)",
    Default = false,
    Callback = function(v)
        W.CamDBD_SetSmooth(v)
        VD_Notify("Camera DBD", v and "Smooth ON" or "Smooth OFF", 2)
    end,
})
MISC_L:AddSlider("CamDBD_Speed", {
    Text = "Camera Smoothness",
    Min = 1, Max = 30, Default = 4, Rounding = 0,
    Callback = function(v) W.CamDBD_SetSmoothSpeed(v) end,
})
MISC_L:AddToggle("CamDBD_POV", {
    Text = "POV Lock",
    Default = false,
    Callback = function(v)
        W.CamDBD_SetPOVLock(v)
        VD_Notify("Camera DBD", v and "POV Lock ON" or "POV Lock OFF", 2)
    end,
})
MISC_L:AddSlider("CamDBD_POVValue", {
    Text = "POV Value",
    Min = 60, Max = 120, Default = 85, Rounding = 0,
    Suffix = "°",
    Callback = function(v) W.CamDBD_SetTargetPOV(v) end,
})
MISC_L:AddSlider("CamDBD_POVSmooth", {
    Text = "POV Smoothness",
    Min = 3, Max = 20, Default = 9, Rounding = 0,
    Callback = function(v) W.CamDBD_SetPOVSmooth(v) end,
})

-- ─── PLAYER UTILITY ───
MISC_L:AddDivider()
MISC_L:AddLabel("👤 Player Utility")
MISC_L:AddToggle("PU_Speed", {
    Text = "Speed Hack",
    Default = false,
    Callback = function(v)
        W.PU.SpeedEnabled = v and true or false
        if not v then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
        if v then VD_Notify("Player Utility", "Speed Hack ON", 2) end
    end,
})
MISC_L:AddSlider("PU_SpeedValue", {
    Text = "Speed Value",
    Min = 16, Max = 200, Default = 16, Rounding = 0,
    Callback = function(v) W.PU.SpeedValue = v end,
})
MISC_L:AddToggle("PU_SkipEnd", {
    Text = "Skip End Screen",
    Default = false,
    Callback = function(v)
        W.PU.SkipEndScreen = v and true or false
        if v then VD_Notify("Player Utility", "Skip End Screen ON", 2) end
    end,
})
MISC_L:AddToggle("PU_ShiftLock", {
    Text = "Shift Lock",
    Default = false,
    Callback = function(v)
        W.PU.ShiftLock = v and true or false
        if not v and W.PU._shiftLockWasActive then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then pcall(function() hum.AutoRotate = true end) end
            W.PU._shiftLockWasActive = false
        end
        if v then VD_Notify("Player Utility", "Shift Lock ON", 2) end
    end,
})
MISC_L:AddToggle("PU_HideIcon", {
    Text = "Hide Survivor Icon",
    Default = false,
    Callback = function(v)
        W.PU.HideSurvivorIcon = v and true or false
    end,
})
MISC_L:AddToggle("PU_PingFPS", {
    Text = "Show Ping & FPS",
    Default = false,
    Callback = function(v)
        W.PU.ShowPingFPS = v and true or false
        if v then
            VD_Notify("Player Utility", "Ping & FPS ON", 2)
        elseif W.PU._pingGui then
            pcall(function() W.PU._pingGui:Destroy() end)
            W.PU._pingGui = nil
        end
    end,
})
MISC_L:AddToggle("PU_HideName", {
    Text = "Hide Name",
    Default = false,
    Callback = function(v)
        if W.PU_SetHideName then W.PU_SetHideName(v) end
    end,
})
MISC_L:AddToggle("PU_UnlimitedZoom", {
    Text = "Unlimited Zoom",
    Default = false,
    Callback = function(v)
        W.PU.UnlimitedZoom = v and true or false
        if not v then
            pcall(function()
                LocalPlayer.CameraMaxZoomDistance = 128
                LocalPlayer.CameraMinZoomDistance = 0.5
            end)
        end
    end,
})
MISC_L:AddToggle("PU_Noclip", {
    Text = "Noclip",
    Default = false,
    Callback = function(v)
        W.PU.Noclip = v and true or false
        if not v and W.PU_RestoreNoclip then W.PU_RestoreNoclip() end
        if v then VD_Notify("Player Utility", "Noclip ON", 2) end
    end,
})

-- ─── SPEED BOOST ───
MISC_L:AddDivider()
MISC_L:AddLabel("⚡ Speed Boost")
MISC_L:AddToggle("SpeedBoost", {
    Text = "Enable Speed Boost",
    Default = false,
    Callback = function(v)
        if W.SpeedBoost_SetEnabled then W.SpeedBoost_SetEnabled(v) end
        if v then VD_Notify("Speed Boost", "Enabled", 2) else VD_Notify("Speed Boost", "Disabled", 2) end
    end,
})
MISC_L:AddSlider("SpeedBoostValue", {
    Text = "Speed Value",
    Min = 16, Max = 100, Default = 30, Rounding = 0,
    Callback = function(v) if W.SpeedBoost_SetValue then W.SpeedBoost_SetValue(v) end end,
})

-- ─── CURSOR ───
MISC_L:AddDivider()
MISC_L:AddLabel("🖱️ Cursor")
MISC_L:AddToggle("CursorUnlock", {
    Text = "Enable Cursor Unlock (Alt)",
    Default = false,
    Callback = function(v)
        if W.Cursor_SetEnabled then W.Cursor_SetEnabled(v) end
        if v then VD_Notify("Cursor Unlock", "Enabled", 2) else VD_Notify("Cursor Unlock", "Disabled", 2) end
    end,
})
MISC_L:AddButton({
    Text = "Toggle Cursor Now",
    Func = function()
        if W.Cursor_SetEnabled then W.Cursor_SetEnabled(not VD.CursorEnabled) end
        VD_Notify("Cursor Unlock", VD.CursorEnabled and "ON" or "OFF", 2)
    end,
})

-- ─── EMOTE ───
MISC_L:AddDivider()
MISC_L:AddLabel("💃 Emote")
MISC_L:AddToggle("Emote", {
    Text = "Enable Emote",
    Default = false,
    Callback = function(v)
        W.EmoteSystem_SetEnabled(v)
        if v then VD_Notify("Emote", "Playing: " .. W.EmoteSystem.SelectedEmote, 2)
        else VD_Notify("Emote", "Stopped", 2) end
    end,
})
MISC_L:AddDropdown("EmoteSelect", {
    Values = W.EmoteSystem.Options,
    Default = "Friday Night",
    Text = "Select Emote",
    Callback = function(v) W.EmoteSystem_SelectEmote(v) end,
})
MISC_L:AddButton({
    Text = "Stop Emote",
    Func = function()
        W.EmoteSystem_Stop()
        W.EmoteSystem.Enabled = false
        VD_Notify("Emote", "Stopped", 2)
    end,
})

-- ═══════════════════════════════════════════════════════════════════
--  MISC RIGHT — SERVER & FUN
-- ═══════════════════════════════════════════════════════════════════

-- ─── BOOMBOX MUSIC ───
MISC_R:AddLabel("🎵 Boombox Music Player")
MISC_R:AddDivider()
MISC_R:AddToggle("BoomboxEnabled", {
    Text = "Enable Boombox",
    Default = false,
    Callback = function(v)
        W.Music_SetEnabled(v)
    end,
})
MISC_R:AddDropdown("BoomboxSong", {
    Values = SongTitles,
    Default = SongTitles[1] or "One",
    Text = "Pilih Lagu",
    Callback = function(v)
        W.Music_PlayByName(v)
    end,
})
MISC_R:AddDropdown("BoomboxControl", {
    Values = {"⏭ Next Track", "⏮ Previous Track", "🔀 Random Track"},
    Default = "⏭ Next Track",
    Text = "Next / Prev / Random",
    Callback = function(v)
        local MS = W.MusicState
        if v == "⏭ Next Track" then
            local n = MS.CurrentIndex + 1
            if n > #W.MusicSongs then n = 1 end
            W.Music_PlayByIndex(n)
        elseif v == "⏮ Previous Track" then
            local n = MS.CurrentIndex - 1
            if n < 1 then n = #W.MusicSongs end
            W.Music_PlayByIndex(n)
        elseif v == "🔀 Random Track" then
            W.Music_PlayByIndex(math.random(1, #W.MusicSongs))
        end
    end,
})
MISC_R:AddSlider("BoomboxVolume", {
    Text = "Volume",
    Min = 0, Max = 10, Default = 2, Rounding = 1,
    Callback = function(v)
        W.MusicState.Volume = v
        if W.MusicState.CurrentSound then
            pcall(function() W.MusicState.CurrentSound.Volume = v end)
        end
    end,
})
MISC_R:AddToggle("BoomboxLoop", {
    Text = "Loop Lagu",
    Default = true,
    Callback = function(v)
        W.MusicState.Looped = v and true or false
        if W.MusicState.CurrentSound then
            pcall(function() W.MusicState.CurrentSound.Looped = W.MusicState.Looped end)
        end
    end,
})
MISC_R:AddToggle("BoomboxShuffle", {
    Text = "Shuffle Mode",
    Default = false,
    Callback = function(v) W.MusicState.Shuffle = v and true or false end,
})
MISC_R:AddToggle("BoomboxAutoNext", {
    Text = "Auto Next Track",
    Default = true,
    Callback = function(v) W.MusicState.AutoNext = v and true or false end,
})
MISC_R:AddDropdown("BoomboxAttach", {
    Values = {"LocalPlayer", "TargetPlayer", "Workspace"},
    Default = "LocalPlayer",
    Text = "Attach Sound To",
    Callback = function(v)
        W.MusicState.AttachedTo = v
        if W.MusicState.Enabled then
            W.Music_PlayByIndex(W.MusicState.CurrentIndex)
        end
    end,
})
MISC_R:AddDropdown("BoomboxTargetPlayer", {
    Values = (function()
        local t = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then table.insert(t, p.Name) end
        end
        if #t == 0 then table.insert(t, "(no players)") end
        return t
    end)(),
    Default = "",
    Text = "Target Player",
    Callback = function(v)
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name == v then
                W.MusicState.TargetPlayer = p
                break
            end
        end
    end,
})
MISC_R:AddButton({
    Text = "⏹ Stop Music",
    Func = function()
        W.Music_Stop()
        VD_Notify("🎵 Boombox", "Stopped", 2)
    end,
})
MISC_R:AddButton({
    Text = "▶️ Play / Resume",
    Func = function()
        if W.MusicState.CurrentSound and not W.MusicState.CurrentSound.IsPlaying then
            W.MusicState.CurrentSound:Play()
        else
            W.Music_PlayByIndex(W.MusicState.CurrentIndex)
        end
    end,
})
MISC_R:AddButton({
    Text = "📋 Show Current Song",
    Func = function()
        local song = W.MusicSongs[W.MusicState.CurrentIndex]
        if song then
            ForceNotify("🎵 Now Playing", song.judul .. " (ID: " .. song.id .. ")", 4)
        end
    end,
})

-- ─── BOOMBOX MINI GUI ───
MISC_R:AddDivider()
MISC_R:AddLabel("📻 Boombox Mini Player")
MISC_R:AddToggle("BoomboxMini", {
    Text = "Show Mini Player (Progress Bar)",
    Default = false,
    Callback = function(v)
        if v and W.BoomboxMini_Show then
            W.BoomboxMini_Show()
        elseif W.BoomboxMini_Hide then
            W.BoomboxMini_Hide()
        end
    end,
})

-- ─── JERK OFF ───
MISC_R:AddDivider()
MISC_R:AddLabel("🎭 Jerk Off Tool")
MISC_R:AddToggle("JerkTool", {
    Text = "Enable Jerk Off Tool",
    Default = false,
    Callback = function(v)
        W.JerkOff_SetEnabled(v)
        if v then VD_Notify("Jerk Off", "Tool spawned!", 2)
        else VD_Notify("Jerk Off", "Tool removed", 2) end
    end,
})

-- ─── FAKE AVATAR ───
MISC_R:AddDivider()
MISC_R:AddLabel("🎭 Fake Avatar")
MISC_R:AddDropdown("FakeAvatarPreset", {
    Values = {"Self Avatar", "Random 1", "Random 2", "Random 3", "Random 4",
        "Random 5", "Random 6", "Random 7",
        "WoozyNate", "Nicholas", "yvlyf", "traevp", "J0LLY", "LucashDev",
        "CEOofIsaac", "Stealthy", "Wildes", "Talon", "Relukt", "Sammy",
        "Diesel", "S4ans03", "Aura", "iJava", "White Guy", "Purple King",
        "Kachaaaa Gay", "Mpruyyy"},
    Default = "Self Avatar",
    Text = "Preset",
    Callback = function(option)
        local ids = W.FakeAvatar_GetIds and W.FakeAvatar_GetIds() or {}
        local id = ids[option] or LocalPlayer.UserId
        if W.FakeAvatar_SetId then W.FakeAvatar_SetId(id) end
    end,
})
MISC_R:AddInput("FakeAvatarUsername", {
    Text = "Fake Avatar Via Username",
    Default = "",
    Placeholder = "username (tanpa @)",
    Callback = function(input) end,
})
MISC_R:AddButton({
    Text = "Apply From Username",
    Func = function()
        local input = ""
        pcall(function()
            local el = Library.Elements and Library.Elements.FakeAvatarUsername
            if el and el.Value then input = tostring(el.Value) end
        end)
        if input == "" then
            ForceNotify("Fake Avatar", "Isi username dulu di input!", 2)
            return
        end
        if W.FakeAvatar_SetByName then
            W.FakeAvatar_SetByName(input:gsub("^@", ""))
        end
    end,
})
MISC_R:AddToggle("FakeAvatarEnabled", {
    Text = "Enable Fake Avatar",
    Default = false,
    Callback = function(v) if W.FakeAvatar_SetEnabled then W.FakeAvatar_SetEnabled(v) end end,
})

-- ─── FAKE KORLESS ───
MISC_R:AddDivider()
MISC_R:AddLabel("💀 Fake Korless")
MISC_R:AddToggle("KorlessMorph", {
    Text = "Korless Morph",
    Default = false,
    Callback = function(v)
        if W.Korless_SetEnabled then W.Korless_SetEnabled(v) end
    end,
})

-- ─── HEADER TITLE ───
MISC_R:AddDivider()
MISC_R:AddLabel("👑 Header Title")
MISC_R:AddInput("HeaderText", {
    Text = "Header Text",
    Default = "FAZZHUB",
    Placeholder = "Nama header lu...",
    Callback = function(input)
        if W.Header_UpdateText then W.Header_UpdateText(input) end
    end,
})
MISC_R:AddToggle("HeaderEnabled", {
    Text = "Enable Header Title",
    Default = false,
    Callback = function(v)
        if W.Header_Toggle then W.Header_Toggle(v) end
    end,
})
MISC_R:AddColorPicker("HeaderColor", {
    Text = "Header Color",
    Default = Color3.fromRGB(0, 170, 255),
    Callback = function(c)
        if W.Header_SetColor then W.Header_SetColor(c) end
    end,
})

-- ─── SPECTATOR COUNTER ───
MISC_R:AddDivider()
MISC_R:AddToggle("SpectatorCounter", {
    Text = "Spectator Counter",
    Default = false,
    Callback = function(v)
        if W.Spectator_SetEnabled then W.Spectator_SetEnabled(v) end
    end,
})

-- ═══════════════════════════════════════════════════════════════════
--  TROLL TAB
-- ═══════════════════════════════════════════════════════════════════
local TROLL_L = Tabs.Troll:AddLeftGroupbox("Funny", "ghost")
local TROLL_R = Tabs.Troll:AddRightGroupbox("Chaos", "bomb")

-- ─── TROLL LEFT ───
TROLL_L:AddLabel("🌀 Teleport & Escape")
TROLL_L:AddDivider()
TROLL_L:AddToggle("TrollTP2", {
    Text = "Troll Teleport",
    Default = false,
    Callback = function(v)
        W.TrollTeleport_SetEnabled(v)
        if getgenv().Gluto_TTB_UpdateVisual then getgenv().Gluto_TTB_UpdateVisual() end
        if v then VD_Notify("Troll Teleport", "Enabled", 2) end
    end,
})
TROLL_L:AddToggle("ShowTrollBtn2", {
    Text = "Show Troll TP Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_TTB_SetEnabled then getgenv().Gluto_TTB_SetEnabled(v) end
    end,
})
TROLL_L:AddDivider()
TROLL_L:AddLabel("🚀 Instant Escape")
TROLL_L:AddToggle("EscapeBtn", {
    Text = "Enable Escape Button",
    Default = false,
    Callback = function(v)
        W.Escape.Enabled = v
        if v then W.Escape_Teleport() end
    end,
})
TROLL_L:AddToggle("ShowEscapeBtn", {
    Text = "Show Escape Floating Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_Escape_SetEnabled then getgenv().Gluto_Escape_SetEnabled(v) end
    end,
})
TROLL_L:AddButton({
    Text = "Teleport Now",
    Func = function() W.Escape_Teleport() end,
})

-- ─── TROLL RIGHT ───
TROLL_R:AddLabel("😈 Chaos Tools")
TROLL_R:AddDivider()
TROLL_R:AddToggle("MoonwalkChaos", {
    Text = "Moonwalk Toggle",
    Default = false,
    Callback = function(v)
        if W.Moonwalk_SetEnabled then W.Moonwalk_SetEnabled(v) end
        if getgenv().Gluto_MoonwalkBtn_UpdateVisual then getgenv().Gluto_MoonwalkBtn_UpdateVisual() end
    end,
})
TROLL_R:AddToggle("ShowMoonwalkBtn2", {
    Text = "Show Moonwalk Button",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_MoonwalkBtn_SetEnabled then getgenv().Gluto_MoonwalkBtn_SetEnabled(v) end
    end,
})
TROLL_R:AddDivider()
TROLL_R:AddLabel("🎭 Jerk Off")
TROLL_R:AddToggle("JerkTool2", {
    Text = "Enable Jerk Off Tool",
    Default = false,
    Callback = function(v) W.JerkOff_SetEnabled(v) end,
})
TROLL_R:AddDivider()
TROLL_R:AddLabel("💃 Emote Party")
TROLL_R:AddToggle("Emote2", {
    Text = "Enable Emote",
    Default = false,
    Callback = function(v) W.EmoteSystem_SetEnabled(v) end,
})
TROLL_R:AddDropdown("Emote2Select", {
    Values = W.EmoteSystem.Options,
    Default = "Friday Night",
    Text = "Select Emote",
    Callback = function(v) W.EmoteSystem_SelectEmote(v) end,
})

-- ═══════════════════════════════════════════════════════════════════
--  CONFIG TAB
-- ═══════════════════════════════════════════════════════════════════
local CFG_L = Tabs.Config:AddLeftGroupbox("Settings", "wrench")
local CFG_R = Tabs.Config:AddRightGroupbox("Theme", "palette")

CFG_L:AddDropdown("NotificationSide", {
    Values = {"Left", "Right"},
    Default = "Right",
    Text = "Notification Side",
    Callback = function(v)
        NotifySide = v
        pcall(function() Library:SetNotifySide(v) end)
    end,
})

CFG_L:AddDropdown("DPIDropdown", {
    Values = {"50%", "75%", "85%", "100%", "125%", "150%"},
    Default = "85%",
    Text = "DPI Scale",
    Callback = function(v)
        v = v:gsub("%%", "")
        pcall(function() Library:SetDPIScale(tonumber(v)) end)
    end,
})

CFG_L:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = true,
    Callback = function(v) Library.ShowCustomCursor = v end,
})

CFG_L:AddToggle("WatermarkToggle", {
    Text = "Watermark",
    Default = true,
    Callback = function(v) Watermark.Visible = v end,
})

CFG_R:AddLabel("Tema: Biru Neon")
CFG_R:AddDivider()

CFG_R:AddSlider("UICornerSlider", {
    Text = "Corner Radius",
    Default = 14,
    Min = 0, Max = 20, Rounding = 0,
    Callback = function(v)
        pcall(function() Window:SetCornerRadius(v) end)
    end,
})

CFG_R:AddButton({
    Text = "Unload Script",
    Func = function()
        pcall(function() Library:Unload() end)
    end,
})

-- ─── THEME & SAVE MANAGER ───
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
ThemeManager:SetFolder("FAZZHUB")
SaveManager:SetFolder("FAZZHUB/configs")

SaveManager:BuildConfigSection(Tabs.Config)
ThemeManager:ApplyToTab(Tabs.Config)

-- ═══════════════════════════════════════════════════════════════════
--  FINAL NOTIFICATION
-- ═══════════════════════════════════════════════════════════════════
Library:Notify({
    Title = "FAZZHUB v0.4.0 Loaded",
    Content = "6 tabs ready: Survivor, Visuals, Killer, Misc, Troll, Config",
    Duration = 5,
})

-- ═══════════════ SECTION 14 DONE ═══════════════
print("[FAZZHUB v0.4.0] SECTION 14 loaded — Killer + Misc + Troll + Config Tab ready")
print("[FAZZHUB v0.4.0] ALL SECTIONS LOADED SUCCESSFULLY!")
print("  ✅ Survivor Tab")
print("  ✅ Visuals Tab")
print("  ✅ Killer Tab")
print("  ✅ Misc Tab")
print("  ✅ Troll Tab")
print("  ✅ Config Tab")
print("  ✅ 13 Floating Buttons")
print("  ✅ Boombox Music + Mini GUI")
print("  ✅ Theme Manager + Save Manager")
