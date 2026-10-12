-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 1: Core + Survivor Utama
-- ═══════════════════════════════════════════════════════════════════

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
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local VirtualInputManager = nil
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

local Library  = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then
    warn("[FAZZHUB Part 1] Load UI dulu + tambahin getgenv().FAZZTabs = Tabs")
    return
end

getgenv().VD = getgenv().VD or {}
local VD = getgenv().VD
local W  = getgenv()

VD.PARRY_Enabled        = VD.PARRY_Enabled or false
VD.PARRY_Aggressive     = VD.PARRY_Aggressive or false
VD.PARRY_Distance       = VD.PARRY_Distance or 10
VD.PARRY_ShowCircle     = VD.PARRY_ShowCircle or false
VD.PARRY_SilentParry    = VD.PARRY_SilentParry or false
VD.AutoCrouch           = VD.AutoCrouch or false
VD.SURV_AutoFlee        = VD.SURV_AutoFlee or false
VD.SURV_AutoFleeDist    = VD.SURV_AutoFleeDist or 40
VD.SURV_AutoFleeCooldown= VD.SURV_AutoFleeCooldown or 1.5
VD.SURV_FakeParry       = VD.SURV_FakeParry or false
VD.SURV_FakeParryAnim   = VD.SURV_FakeParryAnim or "Enten"
VD.SURV_FakeParryCooldown = VD.SURV_FakeParryCooldown or 0.4
VD.SURV_FakeParryKey    = VD.SURV_FakeParryKey or "V"
VD.SURV_FakeParryShowBtn= VD.SURV_FakeParryShowBtn or false
VD.Wisnu_AutoParry      = VD.Wisnu_AutoParry or false
VD.Wisnu_ParryAggressive= VD.Wisnu_ParryAggressive or false
VD.Wisnu_ParrySafety    = VD.Wisnu_ParrySafety or false
VD.Wisnu_ParryDistance  = VD.Wisnu_ParryDistance or 6
VD.Wisnu_ParryFace      = VD.Wisnu_ParryFace or 0.7
VD.Wisnu_ParryCircle    = VD.Wisnu_ParryCircle ~= false
VD.Wisnu_IgnoredSkills  = VD.Wisnu_IgnoredSkills or {}
VD.SURV_AutoVault       = VD.SURV_AutoVault or false
VD.SURV_FastVault       = VD.SURV_FastVault or false
VD.SURF_VaultSpeed      = VD.SURF_VaultSpeed or 13
VD.SURV_AutoPallet      = VD.SURV_AutoPallet or false
VD.SURV_AutoPalletDist  = VD.SURV_AutoPalletDist or 20
VD.NoFallDamage         = VD.NoFallDamage or false
VD.ManualGen            = VD.ManualGen or false
VD.AutoGen              = VD.AutoGen or false
VD.KillerEscapeDist     = VD.KillerEscapeDist or 30

W.InstantHealSelf = W.InstantHealSelf or false
W.AutoHealAll     = W.AutoHealAll or false
W.NotifyEnabled   = W.NotifyEnabled ~= false

local function VD_Notify(t, c, d)
    if not W.NotifyEnabled then return end
    pcall(function() Library:Notify({ Title = t or "FAZZHUB", Content = c or "", Duration = d or 2 }) end)
end
local function ForceNotify(t, c, d) VD_Notify(t, c, d) end
W.VD_Notify = VD_Notify

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
end
W.GetRole = GetRole

local function IsDowned(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local state = char:GetAttribute("State")
    return state == "Downed" or state == "Dead"
end
W.IsDowned = IsDowned

-- ▸ TRIGGER CROUCH
function W.TriggerCrouch()
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
    end)
end

-- ▸ SELF HEAL
function W.doSelfHealTrue()
    local c = LocalPlayer.Character; if not c then return end
    local hp = c:FindFirstChild("HumanoidRootPart"); if not hp then return end
    pcall(function() ReplicatedStorage.Remotes.Healing.HealEvent:FireServer(hp, true) end)
end
function W.doSelfHealFalse()
    local c = LocalPlayer.Character; if not c then return end
    local hp = c:FindFirstChild("HumanoidRootPart"); if not hp then return end
    pcall(function() ReplicatedStorage.Remotes.Healing.HealEvent:FireServer(hp, false) end)
end
function W.doOthersHealTrue(tp)
    if not tp or not tp.Character then return end
    local hrp = tp.Character:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    pcall(function() ReplicatedStorage.Remotes.Healing.HealEvent:FireServer(hrp, true) end)
end
function W.doOthersHealFalse(tp)
    if not tp or not tp.Character then return end
    local hrp = tp.Character:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    pcall(function() ReplicatedStorage.Remotes.Healing.HealEvent:FireServer(hrp, false) end)
end

function W.setInstantHealSelf(v)
    W.InstantHealSelf = v
    if v then
        if W.InstantHealConnection then W.InstantHealConnection:Disconnect() end
        W.InstantHealConnection = RunService.Heartbeat:Connect(function()
            if not W.InstantHealSelf then return end
            local c = LocalPlayer.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not h then return end
            if h.Health >= h.MaxHealth * 0.9 then W.doSelfHealFalse(); return end
            W.doSelfHealTrue()
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
                        if not ah[p] then ah[p] = true; W.doOthersHealTrue(p) end
                    else
                        if ah[p] then ah[p] = nil; W.doOthersHealFalse(p) end
                    end
                end
            end
        end)
    else
        if W.AutoHealAllConnection then W.AutoHealAllConnection:Disconnect(); W.AutoHealAllConnection = nil end
    end
end

-- ▸ AUTO FLEE
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
    local kRoot, nearest = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and TeamIs(plr, "Killer") and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = (hrp.Position - myRoot.Position).Magnitude
                if d < nearest then nearest = d; kRoot = hrp end
            end
        end
    end
    if not kRoot then return end
    if nearest > (VD.SURV_AutoFleeDist or 40) then return end
    lastAutoFlee = now
    local bestPt, bestDist = nil, 0
    local mf = Workspace:FindFirstChild("Map")
    if mf then
        for _, obj in ipairs(mf:GetDescendants()) do
            if obj:IsA("BasePart") and string.find(obj.Name, "^GeneratorPoint%d+$") then
                local d = (obj.Position - kRoot.Position).Magnitude
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
        pcall(W.SURV_AutoFlee)
    end
end)

-- ▸ SWIFT VAULT
do
    local _vaulted = {}
    local _lastScan = 0
    local function GetVT(vt)
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
        if tick() - _lastScan < 0.15 then return end
        _lastScan = tick()
        pcall(function()
            local char = LocalPlayer.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not myRoot or not hum or hum.Health <= 0 then return end
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            local winFold = remotes and remotes:FindFirstChild("Window")
            if not winFold then return end
            local map = Workspace:FindFirstChild("Map")
            if not map then return end
            for _, vt in ipairs(map:GetDescendants()) do
                if vt:IsA("BasePart") and vt.Name == "VaultTrigger" then
                    local pos = GetVT(vt)
                    if pos and (myRoot.Position - pos).Magnitude <= 6 then
                        local parent = vt.Parent
                        if not _vaulted[parent] or tick() - _vaulted[parent] > 3 then
                            local ve = winFold:FindFirstChild("VaultEvent")
                            local vb = winFold:FindFirstChild("Vaultbindable")
                            local fv = winFold:FindFirstChild("fastvault")
                            local vc = winFold:FindFirstChild("VaultCompleteEvent")
                            if ve then pcall(function() ve:FireServer(vt, true) end) end
                            if vb then pcall(function() vb:Fire(vt, true) end) end
                            if fv then pcall(function() fv:FireServer(LocalPlayer) end) end
                            if vc then pcall(function() vc:FireServer(vt, false) end) end
                            _vaulted[parent] = tick()
                        end
                        break
                    end
                end
            end
        end)
    end)
    W.SwiftVault_SetEnabled = function(v) VD.SURV_AutoVault = v and true or false; _vaulted = {} end
    W.SwiftVaultV2_SetEnabled = function(v) VD.SURV_FastVault = v and true or false end
    W.SwiftVault_SetSpeed = function(v) VD.SURF_VaultSpeed = tonumber(v) or 13 end
end

-- ▸ PALLET REFLEX
do
    local _lastDrop = 0
    local _used = {}
    local function GetKillerRoot()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then return hrp end
            end
        end
        return nil
    end
    local _lastScan = 0
    RunService.Heartbeat:Connect(function()
        if not VD.SURV_AutoPallet then return end
        if GetRole() ~= "Survivor" then return end
        local now = tick()
        if now - _lastScan < 0.2 then return end
        _lastScan = now
        if now - _lastDrop < 2.5 then return end
        pcall(function()
            local char = LocalPlayer.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not myRoot or not hum or hum.Health <= 0 then return end
            local kRoot = GetKillerRoot()
            if not kRoot then return end
            if (myRoot.Position - kRoot.Position).Magnitude > (VD.SURV_AutoPalletDist or 20) then return end
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            local palletFold = remotes and remotes:FindFirstChild("Pallet")
            local dropEvent = palletFold and palletFold:FindFirstChild("PalletDropEvent")
            if not dropEvent then return end
            local map = Workspace:FindFirstChild("Map")
            if not map then return end
            local bestPal, bestDist = nil, 8
            for _, pal in ipairs(map:GetDescendants()) do
                if pal.Name == "Palletwrong" and (pal:IsA("Model") or pal:IsA("Folder")) then
                    if not _used[pal] then
                        local pt = pal:FindFirstChild("PalletPointSlide") or pal:FindFirstChild("PalletPoint")
                        if pt then
                            local d = (myRoot.Position - pt.Position).Magnitude
                            if d < bestDist then bestDist = d; bestPal = pal end
                        end
                    end
                end
            end
            if bestPal then
                local pt = bestPal:FindFirstChild("PalletPointSlide") or bestPal:FindFirstChild("PalletPoint")
                if pt then
                    pcall(function() dropEvent:FireServer(pt) end)
                    _used[bestPal] = true
                    _lastDrop = tick()
                end
            end
        end)
    end)
    W.PalletReflex_SetEnabled = function(v) VD.SURV_AutoPallet = v and true or false; _used = {} end
    W.PalletReflex_SetDistance = function(v) VD.SURV_AutoPalletDist = tonumber(v) or 20 end
end

-- ▸ FAKE PARRY
do
    local Track = nil
    local Last = 0
    local FakeParryAnims = {
        ["Enten"] = "rbxassetid://127096285501517",
        ["Stopwatch"] = "rbxassetid://81793464499285",
        ["Fih"] = "rbxassetid://123307242865945",
        ["BloodShield"] = "rbxassetid://75939529748815",
    }
    local function Stop() if Track then pcall(function() Track:Stop(0.05) end); Track = nil end end
    local function Play()
        if not VD.SURV_FakeParry then return end
        if GetRole() ~= "Survivor" then return end
        local now = tick()
        if now - Last < (tonumber(VD.SURV_FakeParryCooldown) or 0.4) then return end
        Last = now
        local char = LocalPlayer.Character; if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
        local animator = hum:FindFirstChildOfClass("Animator")
        if not animator then animator = Instance.new("Animator"); animator.Parent = hum end
        Stop()
        local animId = FakeParryAnims[VD.SURV_FakeParryAnim] or FakeParryAnims["Enten"]
        pcall(function()
            local anim = Instance.new("Animation")
            anim.AnimationId = animId
            local t = animator:LoadAnimation(anim)
            t.Priority = Enum.AnimationPriority.Action4
            t.Looped = false
            t:Play(0.1)
            Track = t
            task.delay(2, function() if Track == t then Stop() end end)
        end)
    end
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        local keyName = VD.SURV_FakeParryKey or "V"
        local kc = Enum.KeyCode[keyName]
        if kc and input.KeyCode == kc then Play() end
    end)
    W.FakeParry_SetEnabled = function(v) VD.SURV_FakeParry = v and true or false; if not v then Stop() end end
    W.FakeParry_SetAnim = function(n) VD.SURV_FakeParryAnim = (n and FakeParryAnims[n]) and n or "Enten" end
    W.FakeParry_Trigger = Play
    W.FakeParry_SetShowButton = function(v) VD.SURV_FakeParryShowBtn = v and true or false end
    W.FakeParry_SetKeybind = function(n)
        local ok, kc = pcall(function() return Enum.KeyCode[tostring(n):upper()] end)
        if ok and kc then VD.SURV_FakeParryKey = kc.Name; return true end
        return false
    end
end

-- ▸ ESCAPE
W.Escape = W.Escape or { Enabled = false, FinishLineName = "fininshline", TeleportCount = 0 }
function W.Escape_Teleport()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then ForceNotify("Escape", "Character not found", 2); return false end
    local found = nil
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if string.lower(obj.Name) == string.lower(W.Escape.FinishLineName) and obj:IsA("BasePart") then
            found = obj; break
        end
    end
    if not found then ForceNotify("Escape", "Finish line not found", 2); return false end
    pcall(function() root.CFrame = found.CFrame + Vector3.new(0, 5, 0) end)
    W.Escape.TeleportCount = W.Escape.TeleportCount + 1
    VD_Notify("Instant Escape", "Teleported! (#" .. W.Escape.TeleportCount .. ")", 2)
    return true
end

-- ▸ TROLL TELEPORT
W.TrollTeleport = W.TrollTeleport or { Enabled = false, IsProcessing = false, TriggerCount = 0, CharHook = nil,
    BlockedAnimList = { ["123812278891591"] = 1, ["74099023522626"] = 2 } }
local TT = W.TrollTeleport
local function TT_Hook(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
    local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3)
    if not anim then return end
    local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
    anim.AnimationPlayed:Connect(function(track)
        if not TT.Enabled or TT.IsProcessing then return end
        local aid = track.Animation and track.Animation.AnimationId or ""
        local numId = aid:match("%d+")
        local delay = numId and TT.BlockedAnimList[numId]
        if not delay then return end
        TT.IsProcessing = true
        TT.TriggerCount = TT.TriggerCount + 1
        local startCF = root.CFrame
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
    TT.IsProcessing = false
    TT_Hook(LocalPlayer.Character)
    if TT.CharHook then TT.CharHook:Disconnect() end
    TT.CharHook = LocalPlayer.CharacterAdded:Connect(function(c) task.wait(0.4); TT_Hook(c) end)
end
function W.TrollTeleport_Stop()
    if TT.CharHook then pcall(function() TT.CharHook:Disconnect() end); TT.CharHook = nil end
    TT.IsProcessing = false
end
function W.TrollTeleport_SetEnabled(v)
    TT.Enabled = v and true or false
    if TT.Enabled then W.TrollTeleport_Start() else W.TrollTeleport_Stop() end
end

print("[FAZZHUB Part 1] Core + Survivor utama loaded.")-- ═══════════════════════════════════════════════════════════════════
--  ALFzxzzz HUB → PAZZHUB Port | PART 2: Survivor Lanjutan
--  (Load SETELAH Part 1)
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local TweenService      = game:GetService("TweenService")
local GuiService        = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local VirtualInputManager = nil
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

local Library = getgenv().PazzLibrary
local PazzTabs = getgenv().PazzTabs
if not Library or not PazzTabs then warn("[ALF-Port Part 2] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local SurvivorTab = PazzTabs.Survivor
local VD_Notify = W.VD_Notify or function() end

-- ▸ AUTO PARRY V1 (mini)
W.ParryState = W.ParryState or { ActiveAttackers = {} }
W.ParryCooldown = W.ParryCooldown or { OnCooldown=false, CooldownEnd=0, WaitingForResult=false, LastFiredAt=0 }

-- ▸ AUTO PARRY V2 (Wisnu)
do
    local validIds = {
        ["122812055447896"]="Veil lunge",["133963973694098"]="Mayers Basic",
        ["117042998468241"]="Mayers lunge",["135002183282873"]="cure lunge",
        ["121216847022485"]="cure Basic",["132817836308238"]="Jeff Basic",
        ["129784271201071"]="Jeff lunge",["82666958311998"]="Jeff Frenzy",
        ["78432063483146"]="Abyssal Basic",["118907603246885"]="Abyssal lunge",
        ["139369275981139"]="Jason Basic",["110355011987939"]="Jason lunge",
        ["111920872708571"]="Masked Basic",["105374834496520"]="Masked lunge",
        ["74968262036854"]="Hidden Basic",["113255068724446"]="Hidden lunge",
    }
    local Cooldown = false
    local attached = {}
    local function IsKiller(p) return p and p.Team and p.Team.Name == "Killer" end
    local function IsSafe(char)
        if not VD.Wisnu_ParrySafety then return true end
        if not char then return false end
        local ci = char:FindFirstChild("CheckInterractable")
        if ci then
            for _, n in ipairs({"isVaulting","isRepairing","isUnhooking","isHealing","isSliding"}) do
                if ci:GetAttribute(n) == true then return false end
            end
        end
        return true
    end
    local function ExecParry()
        if Cooldown then return end
        Cooldown = true
        pcall(function()
            local r = ReplicatedStorage:FindFirstChild("Remotes")
            local i = r and r:FindFirstChild("Items")
            local d = i and i:FindFirstChild("Parrying Dagger")
            local p = d and d:FindFirstChild("parry")
            if p then for _=1,10 do p:FireServer() end end
        end)
        task.delay(2, function() Cooldown = false end)
    end
    local function Attach(kChar)
        if not kChar or attached[kChar] then return end
        attached[kChar] = true
        local hum = kChar:FindFirstChildOfClass("Humanoid"); if not hum then return end
        local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 5)
        if not anim then return end
        anim.AnimationPlayed:Connect(function(track)
            if not VD.Wisnu_AutoParry or Cooldown then return end
            local aid = track.Animation and track.Animation.AnimationId or ""
            local id = aid:match("%d+")
            if not validIds[id] then return end
            if VD.Wisnu_IgnoredSkills and VD.Wisnu_IgnoredSkills[validIds[id]] then return end
            local myChar = LocalPlayer.Character
            if W.IsDowned(myChar) or not IsSafe(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if not myHRP or not kHRP then return end
            if (myHRP.Position - kHRP.Position).Magnitude > VD.Wisnu_ParryDistance then return end
            ExecParry()
        end)
    end
    local function TryAttach(p)
        if p ~= LocalPlayer and IsKiller(p) and p.Character then Attach(p.Character) end
    end
    for _, p in ipairs(Players:GetPlayers()) do TryAttach(p) end
    Players.PlayerAdded:Connect(function(p)
        p.CharacterAdded:Connect(function() TryAttach(p) end)
        if p.Character then TryAttach(p) end
    end)
    task.spawn(function()
        while true do
            task.wait(5)
            for _, p in ipairs(Players:GetPlayers()) do TryAttach(p) end
        end
    end)
end

-- ▸ SELF UNHOOK
W.SelfUnhook = W.SelfUnhook or { Enabled=false, Following=false, FollowDuration=30, FollowDistance=20,
    MonitorConn=nil, TriggerCount=0, _lastTrigger=0, _cooldown=3, _hookPos=nil, _hookCFrame=nil, _activeThread=nil, _wasHooked=false }
local SU = W.SelfUnhook
function W.SU_IsHooked()
    local char = LocalPlayer.Character
    if not char then return false end
    return char:GetAttribute("IsHooked") == true or char:GetAttribute("isHooked") == true
end
function W.SU_GetKillerHRP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and W.TeamIs(p, "Killer") and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then return hrp end
        end
    end
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
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then SU._hookPos = hrp.Position; SU._hookCFrame = hrp.CFrame end
    end
    SU._activeThread = task.spawn(function()
        local fUntil = tick() + (SU.FollowDuration or 30)
        local bOff = SU.FollowDistance or 20
        while tick() < fUntil and SU.Enabled do
            if not W.SU_IsHooked() then
                SU.Following = false; SU._activeThread = nil
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
                    local tPos = Vector3.new(khrp.Position.X, khrp.P-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 3: Fake Perks + Auto Skill Check + Bypass Generator
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local TweenService      = game:GetService("TweenService")
local GuiService        = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local VirtualInputManager = nil
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 3] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local ForceNotify = W.VD_Notify or function() end
local TeamIs = W.TeamIs
local GetRole = W.GetRole

-- ▸ FAKE PERKS
W.FP = W.FP or {
    ActiveBuffs = {}, Conns = {}, LastBuffEnd = 0, CooldownTime = 5, HB = nil,
    FlowstateOn = false, QuickRecOn = false, PerfLandOn = false, AdrenalineOn = false,
}
local FP = W.FP

local function FP_Char() return LocalPlayer.Character end
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
        if tb > 0 then c:SetAttribute("speedboost", 1 + (tb / 14)) else c:SetAttribute("speedboost", 1) end
    end
    if h and tb > 0 then h.WalkSpeed = 16 + tb end
end

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
    if gethui then local ok2, hui = pcall(gethui); if ok2 and hui then parent = hui end end
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
    PerkGUI.Cards[name] = { Card = card, BarFill = barFill, Stroke = stroke, TimeLbl = timeLbl, IconTxt = iconTxt }
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
    task.delay(0.28, function() if card and card.Parent then card:Destroy() end end)
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
    if FP.Conns[name] then
        for _, c in ipairs(FP.Conns[name]) do pcall(function() c:Disconnect() end) end
        FP.Conns[name] = nil
    end
end
local function FP_Reg(name, conn)
    if not FP.Conns[name] then FP.Conns[name] = {} end
    table.insert(FP.Conns[name], conn)
end

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
        hookChar(LocalPlayer.Character)
        FP_Reg("Flowstate", LocalPlayer.CharacterAdded:Connect(function(cc) if FP.FlowstateOn then cc:SetAttribute("Flowstate", true); hookChar(cc) end end))
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
        if hf then
            local hd = hf:FindFirstChild("Healdone")
            if hd and hd:IsA("BindableEvent") then FP_Reg("QuickRecovery", hd.Event:Connect(onH)) end
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

-- ▸ AUTO SKILL CHECK
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

-- ▸ BYPASS GENERATOR
W.GenBypass = W.GenBypass or {
    Enabled=false, Button=nil, UI=nil, Cache={}, CacheTimer=0,
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
function W.GB_GetPoints(m)
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
    local c = LocalPlayer.Character
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
    pcall(function() if hrp and hrp.Parent then hrp.Anchored = false; hrp.CFrame = og end end)
    task.wait(0.1)
    pcall(function() if re then re:FireServer(tp, false) end end)
end
function W.GB_GetNearestPoint()
    local c = LocalPlayer.Character
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
function W.GB_IsPromptVisible()
    local ok2, fr = pcall(function() return LocalPlayer.PlayerGui.pcprompts.Frame.GeneratorRepair end)
    return ok2 and fr and fr.Visible
end
function W.GB_UpdateButton()
    if GenBypass.Enabled then
        if not GenBypass._Wrap or not GenBypass.UI or not GenBypass.UI.Parent then
            W.GB_CreateButton(); task.wait(0.05)
        end
        if GenBypass._ShowCard then GenBypass._ShowCard() end
    else
        if GenBypass._HideCard then GenBypass._HideCard() end
    end
end
function W.GB_CreateButton()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return end
    local old = pg:FindFirstChild("BypassGenUI"); if old then old:Destroy() end
    if GenBypass._StopAnim then pcall(GenBypass._StopAnim); GenBypass._StopAnim = nil end
    GenBypass.UI = Instance.new("ScreenGui")
    GenBypass.UI.Name = "BypassGenUI"
    GenBypass.UI.ResetOnSpawn = false
    GenBypass.UI.IgnoreGuiInset = true
    GenBypass.UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    GenBypass.UI.DisplayOrder = 100
    GenBypass.UI.Parent = pg
    local wrap = Instance.new("Frame")
    wrap.Name = "Wrap"; wrap.AnchorPoint = Vector2.new(1, 0)
    wrap.Position = UDim2.new(1, -20, 0.48, 0)
    wrap.Size = UDim2.fromOffset(110, 110)
    wrap.BackgroundTransparency = 1; wrap.Active = true
    wrap.ZIndex = 2; wrap.Parent = GenBypass.UI
    local glow = Instance.new("Frame")
    glow.Name = "Glow"; glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.Size = UDim2.fromOffset(88, 88)
    glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    glow.BackgroundTransparency = 0.85; glow.BorderSizePixel = 0
    glow.ZIndex = 1; glow.Parent = wrap
    Instance.new("UICorner", glow).CornerRadius = UDim.new(1, 0)
    local mainCircle = Instance.new("Frame")
    mainCircle.Name = "MainCircle"; mainCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    mainCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainCircle.Size = UDim2.fromOffset(64, 64)
    mainCircle.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    mainCircle.BackgroundTransparency = 0.05; mainCircle.BorderSizePixel = 0
    mainCircle.ZIndex = 4; mainCircle.Parent = wrap
    Instance.new("UICorner", mainCircle).CornerRadius = UDim.new(1, 0)
    local mainStroke = Instance.new("UIStroke", mainCircle)
    mainStroke.Name = "MainStroke"; mainStroke.Color = Color3.fromRGB(255, 255, 255)
    mainStroke.Thickness = 1.6; mainStroke.Transparency = 0.15
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local genText = Instance.new("TextLabel")
    genText.Name = "GenText"; genText.AnchorPoint = Vector2.new(0.5, 0.5)
    genText.Position = UDim2.new(0.5, 0, 0.5, 0)
    genText.Size = UDim2.fromOffset(60, 30)
    genText.BackgroundTransparency = 1; genText.Font = Enum.Font.GothamBlack
    genText.Text = "GEN"; genText.TextColor3 = Color3.fromRGB(255, 255, 255)
    genText.TextSize = 20; genText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    genText.TextStrokeTransparency = 0.5
    genText.ZIndex = 7; genText.Parent = wrap
    local actionBtn = Instance.new("TextButton")
    actionBtn.Name = "ActionBtn"; actionBtn.Size = UDim2.fromScale(1, 1)
    actionBtn.BackgroundTransparency = 1; actionBtn.Text = ""
    actionBtn.AutoButtonColor = false; actionBtn.ZIndex = 10; actionBtn.Parent = wrap
    mainCircle.Size = UDim2.fromOffset(0, 0)
    glow.Size = UDim2.fromOffset(0, 0)
    genText.TextTransparency = 1; genText.TextStrokeTransparency = 1
    GenBypass._Wrap = wrap; GenBypass._Glow = glow
    GenBypass._MainCircle = mainCircle; GenBypass._MainStroke = mainStroke
    GenBypass._GenText = genText; GenBypass._ActionBtn = actionBtn
    local function ShowCard()
        wrap.Visible = true
        TweenService:Create(glow, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(88, 88), BackgroundTransparency = 0.85,
        }):Play()
        TweenService:Create(mainCircle, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(64, 64), BackgroundTransparency = 0.05,
        }):Play()
        TweenService:Create(genText, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0, TextStrokeTransparency = 0.5,
        }):Play()
    end
    local function HideCard()
        TweenService:Create(glow, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1,
        }):Play()
        TweenService:Create(mainCircle, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1,
        }):Play()
        TweenService:Create(genText, TweenInfo.new(0.2), {
            TextTransparency = 1, TextStrokeTransparency = 1,
        }):Play()
        task.delay(0.3, function()
            if GenBypass._StopAnim then pcall(GenBypass._StopAnim); GenBypass._StopAnim = nil end
            if GenBypass.UI then pcall(function() GenBypass.UI:Destroy() end); GenBypass.UI = nil end
            GenBypass._Wrap = nil; GenBypass._ShowCard = nil
            GenBypass._HideCard = nil; GenBypass._SetStatus = nil
        end)
    end
    GenBypass._ShowCard = ShowCard; GenBypass._HideCard = HideCard
    local animActive = true
    GenBypass._StopAnim = function() animActive = false end
    task.spawn(function()
        local t = 0
        while animActive and wrap.Parent do
            t = t + 0.035
            if GenBypass.Enabled then
                local pulse = (math.sin(t * 3) + 1) * 0.5
                mainStroke.Transparency = 0.35 - pulse * 0.2
                mainStroke.Thickness = 1.6 + pulse * 0.4
                glow.BackgroundTransparency = 0.85 - pulse * 0.12
                glow.Size = UDim2.fromOffset(88 + pulse * 5, 88 + pulse * 5)
                genText.Rotation = math.sin(t * 1.2) * 1.5
            end
            task.wait(0.03)
        end
    end)
    local function SetStatus(mode)
        if mode == "ready" then
            mainStroke.Color = Color3.fromRGB(120, 255, 160)
            genText.TextColor3 = Color3.fromRGB(120, 255, 160)
            glow.BackgroundColor3 = Color3.fromRGB(120, 255, 160)
        elseif mode == "busy" then
            mainStroke.Color = Color3.fromRGB(255, 200, 100)
            genText.TextColor3 = Color3.fromRGB(255, 200, 100)
            glow.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
        elseif mode == "searching" then
            mainStroke.Color = Color3.fromRGB(150, 200, 255)
            genText.TextColor3 = Color3.fromRGB(150, 200, 255)
            glow.BackgroundColor3 = Color3.fromRGB(150, 200, 255)
        else
            mainStroke.Color = Color3.fromRGB(255, 255, 255)
            genText.TextColor3 = Color3.fromRGB(255, 255, 255)
            glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    GenBypass._SetStatus = SetStatus
    local drag = false
    local dStart, sPos, dragDist = nil, nil, 0
    wrap.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true; dStart = inp.Position; sPos = wrap.Position; dragDist = 0
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if not drag then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local d = inp.Position - dStart
            dragDist = math.abs(d.X) + math.abs(d.Y)
            wrap.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
    actionBtn.MouseButton1Up:Connect(function()
        if not GenBypass.Enabled then return end
        if dragDist > 6 then return end
        TweenService:Create(mainCircle, TweenInfo.new(0.08), { Size = UDim2.fromOffset(54, 54) }):Play()
        task.delay(0.1, function()
            TweenService:Create(mainCircle, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(64, 64) }):Play()
        end)
        local ripple = Instance.new("Frame")
        ripple.AnchorPoint = Vector2.new(0.5, 0.5)
        ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
        ripple.Size = UDim2.fromOffset(64, 64)
        ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ripple.BackgroundTransparency = 0.55; ripple.BorderSizePixel = 0
        ripple.ZIndex = 3; ripple.Parent = wrap
        Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
        TweenService:Create(ripple, TweenInfo.new(0.6), { Size = UDim2.fromOffset(160, 160), BackgroundTransparency = 1 }):Play()
        task.delay(0.6, function() if ripple then ripple:Destroy() end end)
        SetStatus("searching")
        local bp, bd = W.GB_GetNearestPoint()
        if bp and bd <= GenBypass.TriggerRange then
            SetStatus("busy")
            task.spawn(function()
                W.GB_DoRepair(bp); task.wait(0.5); SetStatus("ready")
            end)
        else
            task.wait(0.6); SetStatus("standby")
        end
    end)
    task.spawn(function()
        task.wait(0.1)
        if GenBypass.Enabled then ShowCard() end
    end)
end
W.GB_CreateButton()
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5); W.GB_CreateButton(); W.GB_UpdateButton()
end)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp or isMobile then return end
    if input.KeyCode == GenBypass.HotkeyCode and GenBypass.Enabled then
        if not W.GB_IsPromptVisible() then return end
        local bp, bd = W.GB_GetNearestPoint()
        if not bp or bd > GenBypass.TriggerRange then return end
        if GenBypass.Processed[bp.Parent] then return end
        W.GB_DoRepair(bp)
    end
end)
task.spawn(function()
    while true do
        task.wait(2)
        local c = LocalPlayer.Character
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
function W.setGenBypass(v) GenBypass.Enabled = v; W.GB_UpdateButton() end

print("[FAZZHUB Part 3] Fake Perks + Auto Skill Check + Bypass Generator loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 4: Vault + God Mode + Auto Run + NoFall
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local TweenService      = game:GetService("TweenService")
local GuiService        = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local VirtualInputManager = nil
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 4] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end

-- ▸ UNLIMITED VAULT
W.UnlimitedVaultEnabled = false
W.UnlimitedVaultConn = nil
function W.EnableUnlimitedVault()
    if W.UnlimitedVaultEnabled then return end
    W.UnlimitedVaultEnabled = true
    if W.UnlimitedVaultConn then W.UnlimitedVaultConn:Disconnect() end
    for _, v in ipairs(CollectionService:GetTagged("Blocked")) do
        CollectionService:RemoveTag(v, "Blocked")
    end
    W.UnlimitedVaultConn = CollectionService:GetInstanceAddedSignal("Blocked"):Connect(function(instance)
        CollectionService:RemoveTag(instance, "Blocked")
    end)
end
function W.DisableUnlimitedVault()
    W.UnlimitedVaultEnabled = false
    if W.UnlimitedVaultConn then W.UnlimitedVaultConn:Disconnect(); W.UnlimitedVaultConn = nil end
end

-- ▸ ANTI SLOW VAULT
W.AntiSlowVaultEnabled = false
W.AntiSlowVaultConn = nil
function W.EnableAntiSlowVault()
    if W.AntiSlowVaultEnabled then return end
    W.AntiSlowVaultEnabled = true
    for _, v in ipairs(CollectionService:GetTagged("SlowVault")) do
        CollectionService:RemoveTag(v, "SlowVault")
    end
    if W.AntiSlowVaultConn then W.AntiSlowVaultConn:Disconnect() end
    W.AntiSlowVaultConn = CollectionService:GetInstanceAddedSignal("SlowVault"):Connect(function(instance)
        CollectionService:RemoveTag(instance, "SlowVault")
    end)
end
function W.DisableAntiSlowVault()
    W.AntiSlowVaultEnabled = false
    if W.AntiSlowVaultConn then W.AntiSlowVaultConn:Disconnect(); W.AntiSlowVaultConn = nil end
end

-- ▸ GOD MODE
W.GodModeEnabled = false
W.GodModeThread = nil
function W.StartGodMode()
    if W.GodModeThread then task.cancel(W.GodModeThread) end
    W.GodModeThread = task.spawn(function()
        while W.GodModeEnabled do
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function()
                    if hum.Health < hum.MaxHealth and hum.Health > 0 then hum.Health = hum.MaxHealth end
                end)
            end
            task.wait(0.1)
        end
        W.GodModeThread = nil
    end)
end
function W.StopGodMode()
    W.GodModeEnabled = false
    if W.GodModeThread then task.cancel(W.GodModeThread); W.GodModeThread = nil end
end

-- ▸ AUTO RUN (PC)
W.AutoRunPCEnabled = false
W.AutoRunPCThread = nil
function W.StartAutoRunPC()
    if W.AutoRunPCThread then task.cancel(W.AutoRunPCThread) end
    W.AutoRunPCThread = task.spawn(function()
        while W.AutoRunPCEnabled do
            pcall(function()
                if VirtualInputManager then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse())
                end
            end)
            task.wait(0.1)
        end
        pcall(function()
            if VirtualInputManager then VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse()) end
        end)
        W.AutoRunPCThread = nil
    end)
end
function W.StopAutoRunPC()
    W.AutoRunPCEnabled = false
    if W.AutoRunPCThread then task.cancel(W.AutoRunPCThread); W.AutoRunPCThread = nil end
    pcall(function()
        if VirtualInputManager then VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse()) end
    end)
end

-- ▸ AUTO RUN (MOBILE)
W.AutoRunMobileEnabled = false
W.AutoRunMobileThread = nil
function W.GetMobileSprintButton()
    local pg = LocalPlayer:FindFirstChild("PlayerGui"); if not pg then return nil end
    local mob = pg:FindFirstChild("Survivor-mob"); if not mob then return nil end
    local controls = mob:FindFirstChild("Controls"); if not controls then return nil end
    local sprint = controls:FindFirstChild("sprint"); if not sprint then return nil end
    if sprint:IsA("GuiButton") then return sprint end
    local icon = sprint:FindFirstChild("icon")
    if icon and icon:IsA("GuiButton") then return icon end
    if icon and icon.Parent and icon.Parent:IsA("GuiButton") then return icon.Parent end
    if sprint.Parent and sprint.Parent:IsA("GuiButton") then return sprint.Parent end
    return sprint
end
function W.PressSprint()
    local btn = W.GetMobileSprintButton()
    if not btn then return false end
    pcall(function()
        if type(firesignal) == "function" then
            firesignal(btn.MouseButton1Click)
            firesignal(btn.MouseButton1Down)
            task.wait(0.04)
            firesignal(btn.MouseButton1Up)
        elseif VirtualInputManager and GuiService then
            local pos = btn.AbsolutePosition; local size = btn.AbsoluteSize
            local inset = GuiService:GetGuiInset()
            local x = pos.X + size.X / 2 + inset.X
            local y = pos.Y + size.Y / 2 + inset.Y
            local id = 9901
            VirtualInputManager:SendTouchEvent(id, 0, x, y)
            task.wait(0.04)
            VirtualInputManager:SendTouchEvent(id, 2, x, y)
        end
    end)
    return true
end
function W.IsMoving()
    local char = LocalPlayer.Character; if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return false end
    if hum.MoveDirection.Magnitude > 0.12 then return true end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local v = hrp.AssemblyLinearVelocity
        if Vector3.new(v.X, 0, v.Z).Magnitude > 1.5 then return true end
    end
    return false
end
function W.IsCrouching()
    local char = LocalPlayer.Character; if not char then return false end
    return char:GetAttribute("Crouching") == true or char:GetAttribute("Crouchingserver") == true
end
function W.IsActuallySprinting()
    local char = LocalPlayer.Character; if not char then return false end
    return char:GetAttribute("Sprinting") == true or char:GetAttribute("IsRunning") == true
end
function W.StartAutoRunMobile()
    if W.AutoRunMobileThread then return end
    W.AutoRunMobileThread = task.spawn(function()
        while W.AutoRunMobileEnabled do
            local moving = W.IsMoving()
            local crouching = W.IsCrouching()
            local sprinting = W.IsActuallySprinting()
            if crouching then
                if sprinting then W.PressSprint() end
            else
                if moving and not sprinting then W.PressSprint()
                elseif not moving and sprinting then W.PressSprint() end
            end
            task.wait(0.12)
        end
        if W.IsActuallySprinting() then W.PressSprint() end
        W.AutoRunMobileThread = nil
    end)
end
function W.StopAutoRunMobile() W.AutoRunMobileEnabled = false end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if W.AutoRunPCEnabled then W.StartAutoRunPC() end
    if W.AutoRunMobileEnabled then W.AutoRunMobileThread = nil; W.StartAutoRunMobile() end
end)

-- ▸ NO FALL DAMAGE
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
                    if not checkcaller() and getgenv().VD and getgenv().VD.NoFallDamage then
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
                    return oldnamecall(self, ...)
                end)
                if setreadonly then setreadonly(mt, true) end
            end)
        end)
    end
    InstallNoFallHook()
end

print("[FAZZHUB Part 4] Vault + God Mode + Auto Run + NoFall loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 5: Next Map Prediction + Manual/Auto Generator
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local TweenService      = game:GetService("TweenService")
local GuiService        = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 5] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local TeamIs = W.TeamIs
local GetRole = W.GetRole

-- ▸ NEXT MAP PREDICTION
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

-- ▸ MANUAL & AUTO GENERATOR
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

    local function GB_GetAllGenerators()
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
    local function GB_GetPoints(m)
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
        for _, gen in ipairs(GB_GetAllGenerators()) do
            for _, pt in ipairs(GB_GetPoints(gen)) do
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
        for _, gen in ipairs(GB_GetAllGenerators()) do
            if IsGenDone(gen) then continue end
            local genPivot
            pcall(function() genPivot = gen:GetPivot().Position end)
            if genPivot and IsKillerNearPos(genPivot, VD.KillerEscapeDist) then
                continue
            end
            for _, pt in ipairs(GB_GetPoints(gen)) do
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
                if not myRoot or not hum or hum.Health <= 0 then task.wait(0.2); continue end

                local _, kd = GetNearestKillerDist()
                if kd <= VD.KillerEscapeDist then
                    if ManualPoint then
                        StopRepair(ManualPoint)
                        ManualPoint = nil
                        VD_Notify("Manual Gen", "Killer near - release repair", 2)
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
                if not myRoot or not hum or hum.Health <= 0 then task.wait(0.3); continue end

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
    W.GenAuto_SetDistance = function(v)
        VD.KillerEscapeDist = tonumber(v) or 30
    end

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if VD.ManualGen then StartManualThread() end
        if VD.AutoGen then StartAutoThread() end
    end)
end

print("[FAZZHUB Part 5] Next Map + Manual/Auto Gen loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 6: Silent Aim TOF + Silent Flashlight + Aim Lock Gun
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local TweenService      = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 6] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local TeamIs = W.TeamIs
local GetRole = W.GetRole

-- ▸ SILENT AIM TOF
do
    VD.TOF_SilentAim    = VD.TOF_SilentAim    or false
    VD.TOF_TargetMode   = VD.TOF_TargetMode   or "Killer"
    VD.TOF_Key          = VD.TOF_Key          or "Q"
    VD.TOF_Laser        = VD.TOF_Laser        ~= false
    VD.TOF_WallCheck    = VD.TOF_WallCheck    ~= false
    VD.TOF_BlockKnocked = VD.TOF_BlockKnocked ~= false

    local ToFState = {
        Connection = nil, LaserBeam = nil, TargetGui = nil,
        InputBegan = nil, InputEnded = nil, TouchInput = nil,
        IsAiming = false, SavedUIPos = UDim2.new(0.5, -100, 0, 110),
        SCPCache = {}, SCPCacheTimer = 0
    }
    local ToFKeyCodes = { None=nil, Q=Enum.KeyCode.Q, E=Enum.KeyCode.E, R=Enum.KeyCode.R, T=Enum.KeyCode.T,
        F=Enum.KeyCode.F, G=Enum.KeyCode.G, H=Enum.KeyCode.H, J=Enum.KeyCode.J, K=Enum.KeyCode.K,
        L=Enum.KeyCode.L, X=Enum.KeyCode.X, Z=Enum.KeyCode.Z }

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
        if not (g and c) then return nil, nil, nil, nil end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil, nil, nil, nil end
        local mp = hrp.Position
        local op
        if c:GetAttribute("IsCarried") then op = hrp.Position + (hrp.CFrame.LookVector * 2)
        else
            pcall(function() op = g:IsA("BasePart") and g.Position or (g:FindFirstChildOfClass("BasePart") and g:FindFirstChildOfClass("BasePart").Position) end)
            op = op or Vector3.new(mp.X, mp.Y + 1.5, mp.Z)
        end
        local function predict(t, tc)
            local tp = t.Position
            if VD.TOF_WallCheck and not ToF_IsVisible(op, tp, tc) then return nil, nil, nil, nil end
            local tv = Vector3.new(0, 0, 0)
            local rp = tc and (tc:FindFirstChild("HumanoidRootPart") or t)
            if rp then tv = rp.Velocity end
            local dr = tp - op; local d = dr.Magnitude
            if d < 0.1 then return nil, nil, nil, nil end
            if d < 5 then return dr.Unit, g, op, tp end
            local tt = d / 400
            local pp = tp + (tv * tt)
            for _ = 1, 2 do local nd = (pp - op).Magnitude; tt = nd / 400; pp = tp + (tv * tt) end
            local fd = pp - op
            if fd.Magnitude < 0.1 then return nil, nil, nil, nil end
            return fd.Unit, g, op, pp
        end
        local mode = VD.TOF_TargetMode or "Killer"
        if mode == "Killer" then
            local bt, bc, bs = nil, nil, math.huge
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                    local t = p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("HumanoidRootPart")
                    if t then local d = (mp - t.Position).Magnitude; if d < bs then bs = d; bt = t; bc = p.Character end end
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
                    local t = p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("HumanoidRootPart")
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
            l.Name = "ToFLaser"; l.Anchored = true; l.CanCollide = false; l.CanTouch = false; l.CastShadow = false
            l.Material = Enum.Material.Neon; l.Color = Color3.fromRGB(255, 255, 255); l.Parent = workspace
            ToFState.LaserBeam = l
        end
        local d = (tp - op).Magnitude
        ToFState.LaserBeam.Size = Vector3.new(0.05, 0.05, d)
        ToFState.LaserBeam.CFrame = CFrame.new((op + tp) / 2, tp)
        ToFState.LaserBeam.Transparency = 0
    end
    local function ToF_ClearLaser()
        if ToFState.LaserBeam then pcall(function() ToFState.LaserBeam:Destroy() end); ToFState.LaserBeam = nil end
    end
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
        local p = input.Position; local ap = sb.AbsolutePosition; local az = sb.AbsoluteSize
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
        ToFState.IsAiming = false; ToF_ClearLaser()
    end
    local function ToF_SetTargetMode(mode, notify)
        if mode ~= "Killer" and mode ~= "Survivors" and mode ~= "Zombie" then return end
        VD.TOF_TargetMode = mode
        if notify then VD_Notify("ToF Target", mode, 1) end
    end
    local function ToF_EnsureInputs()
        if not ToFState.InputBegan then
            ToFState.InputBegan = UserInputService.InputBegan:Connect(function(inp, gp)
                if gp then return end
                local k = ToFKeyCodes[VD.TOF_Key or "None"]
                if k and inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == k then
                    W.SetToFSilentAim(not VD.TOF_SilentAim); return
                end
                if not VD.TOF_SilentAim then return end
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
    W.SetToFSilentAim = function(en)
        VD.TOF_SilentAim = en and true or false
        ToF_EnsureInputs()
        if VD.TOF_SilentAim then ToF_StartConn() else ToF_StopConn() end
    end
    W.ToF_ClearLaser = ToF_ClearLaser
    W.ToF_SetTargetMode = ToF_SetTargetMode
    ToF_EnsureInputs()
end

-- ▸ SILENT FLASHLIGHT
do
    VD.FLASH_SilentAim  = VD.FLASH_SilentAim  or false
    VD.FLASH_Laser      = VD.FLASH_Laser      ~= false
    VD.FLASH_TargetPart = VD.FLASH_TargetPart or "Head"
    VD.FLASH_Range      = VD.FLASH_Range      or 120
    VD.FLASH_Smooth     = VD.FLASH_Smooth     or 0.35
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
            l.Anchored = true; l.CanCollide = false; l.CanTouch = false; l.CanQuery = false; l.CastShadow = false
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
        if VD.FLASH_Laser and op then pcall(Flash_UpdateLaser, op, tp.Position)
        elseif FlashState.LaserBeam then FlashState.LaserBeam.Transparency = 1 end
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
        if FlashState.Connection then pcall(function() FlashState.Connection:Disconnect() end); FlashState.Connection = nil end
    end
    W.Flash_SetEnabled = function(v)
        VD.FLASH_SilentAim = v and true or false
        if v then Flash_Start() else Flash_Stop() end
    end
    W.Flash_SetActive = function(active, part)
        FlashState.Active = active and true or false
        if FlashState.Active and part then FlashState.FlashlightPart = part
        elseif not FlashState.Active then FlashState.FlashlightPart = nil end
        if not FlashState.Active and FlashState.LaserBeam then FlashState.LaserBeam.Transparency = 1 end
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

-- ▸ AIM LOCK GUN
do
    local GunAim = {
        Enabled = false, Holding = false, TargetMode = "Killer",
        Strength = 1, Predict = true, PredictStrength = 0.12,
        FOV = 250, VisibilityCheck = true,
        AimPart = "HumanoidRootPart", Target = nil,
    }
    W.GunAim_Cfg = GunAim
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
        local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
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
            if not GunAim.Enabled or not GunAim.Holding then GunAim.Target = nil; return end
            local target = GA_GetClosestTarget()
            if not target then return end
            GunAim.Target = target
            local pos = target.Position
            if GunAim.Predict then pos = pos + (target.AssemblyLinearVelocity * GunAim.PredictStrength) end
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
end

print("[FAZZHUB Part 6] Silent TOF + Silent Flashlight + Aim Lock Gun loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 7: Auto Crouch + Moonwalk + Killer Perks Display
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local TweenService      = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 7] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local TeamIs = W.TeamIs
local GetRole = W.GetRole
local IsDowned = W.IsDowned

-- ▸ AUTO CROUCH DODGE
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
            local myChar = LocalPlayer.Character
            if IsDowned(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if myHRP and kHRP then
                local dist = (myHRP.Position - kHRP.Position).Magnitude
                if dist <= 40 then W.TriggerCrouch() end
            end
            return
        end
    end)
end
local function TryAttach(p)
    if p ~= LocalPlayer and IsKiller(p) and p.Character then AttachParrySensor(p.Character) end
end
local function SetupPlayer(p)
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

-- ▸ MOONWALK
W.MoonwalkEnabled = false
W.MoonwalkConn = nil
W.MOONWALK_SIDE_SPEED = 0.9
W.MOONWALK_BACK_SPEED = 1.2
W.MOONWALK_INTERVAL = 0.07

function W.stopMoonwalk()
    if W.MoonwalkConn then W.MoonwalkConn:Disconnect(); W.MoonwalkConn = nil end
end
function W.startMoonwalk()
    W.stopMoonwalk()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    local lastSwitch = 0
    local direction = 1
    W.MoonwalkConn = RunService.RenderStepped:Connect(function()
        if not W.MoonwalkEnabled then return end
        local c = LocalPlayer.Character
        if not c then return end
        local cHrp = c:FindFirstChild("HumanoidRootPart")
        local cHum = c:FindFirstChildOfClass("Humanoid")
        if not cHrp or not cHum or cHum.Health <= 0 then return end
        local now = tick()
        if now - lastSwitch >= W.MOONWALK_INTERVAL then
            direction = direction * -1
            lastSwitch = now
        end
        local back = cHrp.CFrame.LookVector * -W.MOONWALK_BACK_SPEED
        local side = cHrp.CFrame.RightVector * (direction * W.MOONWALK_SIDE_SPEED)
        cHum:Move(back + side, false)
    end)
end
function W.setMoonwalk(state)
    W.MoonwalkEnabled = state
    if state then W.startMoonwalk() else W.stopMoonwalk() end
end
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F8 then W.setMoonwalk(not W.MoonwalkEnabled) end
end)
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    if W.MoonwalkEnabled then W.startMoonwalk() end
end)

-- ▸ KILLER PERKS DISPLAY
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
            head = true, torso = true, humanoid = true,
            ["left arm"] = true, ["right arm"] = true,
            ["left leg"] = true, ["right leg"] = true,
            ["humanoidrootpart"] = true,
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
                        local bn = tostring(k):gsub("[Ll]evel", ""):gsub("[Pp]erk", "")
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
        gui.Name = "FAZZKillerPerksDisplay"
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
        minBtn.Text = "-"
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
                minBtn.Text = "-"
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
        if PerkDisplayState.Thread then pcall(function() task.cancel(PerkDisplayState.Thread) end); PerkDisplayState.Thread = nil end
        if PerkDisplayState.Gui then pcall(function() PerkDisplayState.Gui:Destroy() end); PerkDisplayState.Gui = nil end
    end
    local function Start()
        if PerkDisplayState.Enabled then return end
        PerkDisplayState.Enabled = true
        BuildGui()
        task.spawn(function() task.wait(0.05); UpdateDisplay() end)
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
end

print("[FAZZHUB Part 7] Auto Crouch + Moonwalk + Killer Perks Display loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 8: Killer Part 1 — Auto Attack + Lunge + Counter Parry
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local TweenService      = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local VirtualInputManager = nil
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 8] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local TeamIs = W.TeamIs
local GetRole = W.GetRole

VD.KILLER_AutoAttack         = VD.KILLER_AutoAttack         or false
VD.KILLER_AutoAttackRange    = VD.KILLER_AutoAttackRange    or 12
VD.KILLER_AutoAttackCooldown = VD.KILLER_AutoAttackCooldown or 0.15
VD.KILLER_InfLunge           = VD.KILLER_InfLunge           or false
VD.KILLER_AntiBlind          = VD.KILLER_AntiBlind          or false
VD.KILLER_DestroyPallets     = VD.KILLER_DestroyPallets     or false

local KillerAttackAnims = W.KillerAttackAnims or {
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

-- ▸ AUTO ATTACK (KILLER)
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
            local attacks = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Attacks")
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

-- ▸ INFINITE LUNGE
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
        task.wait(0.12)
        pcall(W.VD_UpdateInfiniteLunge)
    end
end)

-- ▸ COUNTER AUTO PARRY
do
    local AntiAutoParryEnabled = false
    local CounterParryAnimList = {}
    for id, _ in pairs(KillerAttackAnims) do
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
                if p ~= LocalPlayer and p.Team and string.find(string.lower(p.Team.Name), "survivor", 1, true) then
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
    function W.CounterParry_SetEnabled(v)
        AntiAutoParryEnabled = v and true or false
        if v then VD_Notify("Counter Auto Parry", "Enabled", 2) end
    end
end

-- ▸ AIM LOCK HIDDEN
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
    function W.AimLockHidden_SetEnabled(state)
        AimLockEnabled = state
        if state then
            AimLock_Start()
            VD_Notify("Aim Lock Hidden", "Enabled - Hold M2/E", 2)
        else
            AimLockAiming = false
            if AimLockThread then task.cancel(AimLockThread); AimLockThread = nil end
            VD_Notify("Aim Lock Hidden", "Disabled", 2)
        end
    end
    function W.AimLockHidden_SetHoldKey(keyName)
        local map = {
            ["leftshift"]=Enum.KeyCode.LeftShift,["rightshift"]=Enum.KeyCode.RightShift,
            ["leftalt"]=Enum.KeyCode.LeftAlt,["rightalt"]=Enum.KeyCode.RightAlt,
            ["leftctrl"]=Enum.KeyCode.LeftControl,["rightctrl"]=Enum.KeyCode.RightControl,
            ["leftcontrol"]=Enum.KeyCode.LeftControl,["rightcontrol"]=Enum.KeyCode.RightControl,
            ["space"]=Enum.KeyCode.Space,["tab"]=Enum.KeyCode.Tab,
        }
        local input = tostring(keyName or ""):gsub("%s+", "")
        if input == "" then return false end
        local newKey = map[input:lower()]
        if not newKey then
            local ok, kc = pcall(function() return Enum.KeyCode[input:upper():sub(1,1) .. input:lower():sub(2)] end)
            if ok and kc then newKey = kc end
        end
        if newKey then
            AimLockHoldKey = newKey
            VD_Notify("Aim Lock", "Hold key: " .. newKey.Name, 2)
            return true
        end
        return false
    end
end

-- ▸ AIM LOCK ATTACK
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
end

-- ▸ ANTI BLIND
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

-- ▸ DESTROY PALLET
getgenv().FAZZ_IsBreakingPallet = false
function W.MAWWW_DestroyAllPallets()
    if not VD.KILLER_DestroyPallets then return end
    if GetRole() ~= "Killer" then return end
    if getgenv().FAZZ_IsBreakingPallet then return end
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
task.spawn(function()
    while true do
        task.wait(0.12)
        if VD.KILLER_DestroyPallets then pcall(W.MAWWW_DestroyAllPallets) end
    end
end)

print("[FAZZHUB Part 8] Auto Attack + Lunge + Counter Parry + Aim Locks + Anti Blind + Destroy Pallet loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 9: Masked + Silent Veil V1 + Veil V2
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local TweenService      = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 9] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local TeamIs = W.TeamIs
local GetRole = W.GetRole

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

-- ▸ SELECT MASKED
W.Masked = W.Masked or { CurrentPower = "Cobra", Powers = {"Cobra", "Richter", "Brandon", "Rabbit", "Alex", "Tony"} }
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
        W.ForceNotify and W.ForceNotify("Select Masked", "Activatepower remote not found", 2)
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
        W.ForceNotify and W.ForceNotify("Select Masked", "Deactivatepower remote not found", 2)
    end
end

-- ▸ SILENT VEIL V1
do
    local VeilState = { target = nil, lookVector = nil, velHistory = {} }
    local VeilVisuals = {}

    pcall(function()
        if typeof(Drawing) ~= "table" or not Drawing.new then return end
        local V = VeilVisuals
        local ACCENT = Color3.fromRGB(120, 120, 120)
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
        local radius = VD.VeilFOV or 150
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
        if VD.VeilShowFOV and VD.VeilEnabled then Veil_UpdateFOVVisuals(center)
        else Veil_HideFOV() end
        if not VD.VeilEnabled then VeilState.target = nil; VeilState.lookVector = nil; Veil_HideTracker(); return end
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
                if VD.VeilShowTracker then
                    local sp, vis = cam:WorldToViewportPoint(tp)
                    if vis and sp.Z > 0 then
                        local screenDist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        if screenDist <= (VD.VeilFOV or 150) + 100 then
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
                        if self.Name == "Spearthrow" and VD.VeilEnabled and typeof(VeilState.lookVector) == "Vector3" and GetRole() == "Killer" then
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
end

-- ▸ SILENT VEIL V2
do
    local Config = {}
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
    local Camera = Workspace.CurrentCamera

    local function IsVeilSilentOn()
        return AimConfig.Aim_SilentVeil or AimConfig.Aim_SilentVeilV2
    end

    function getTargetPartObject(char)
        if AimConfig.AIM_TargetPart == "Head" then return char:FindFirstChild("Head")
        elseif AimConfig.AIM_TargetPart == "Root" or AimConfig.AIM_TargetPart == "HumanoidRootPart" then return char:FindFirstChild("HumanoidRootPart")
        else return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart") end
    end
    function getClosestSurvivor()
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
    veilTargetHighlight.Name = "FAZZ_VeilTarget"
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
        if not getrawmetatable or not setreadonly then warn("[SpearInterceptor]: not supported."); return end
        local Spearthrow = nil
        pcall(function() Spearthrow = ReplicatedStorage.Remotes.Killers.Veil.Spearthrow end)
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldNamecall = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" and not checkcaller() and typeof(self) == "Instance" and self.ClassName == "RemoteEvent" and self.Name == "Spearthrow" then
                if AimConfig.Aim_SilentVeil and not AimConfig.Aim_SilentVeilV2 then return nil end
                if AimConfig.Aim_SilentVeilV2 and not isFiringSpear then
                    local lookVec, speed, originPos = ...
                    speed = speed or AimConfig.SPEAR_Speed or 165
                    local myChar = LocalPlayer.Character
                    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local startPart = myChar and (myChar:FindFirstChild("Head") or myHRP)
                    local isSpecial = myChar and myChar:GetAttribute("special") == true
                    if Config.SpearSmart_enable then speed = isSpecial and 165 or 142.5
                    else speed = AimConfig.SPEAR_Speed or 165 end
                    originPos = originPos or (Config.SpearSmart_enable and myHRP and myHRP.Position) or (startPart and startPart.Position)
                    local bestDir = lookVec
                    local targetPart = getClosestSurvivor()
                    if targetPart and originPos then
                        local targetHRP = targetPart:IsA("Model") and targetPart:FindFirstChild("HumanoidRootPart") or targetPart
                        local targetPos = targetHRP.Position
                        local targetVel = Vector3.new(0,0,0)
                        local targetHum = targetPart.Parent and targetPart.Parent:FindFirstChildOfClass("Humanoid")
                        if targetHum and targetHum.MoveDirection.Magnitude > 0 then targetVel = targetHum.MoveDirection * targetHum.WalkSpeed
                        elseif targetHRP:IsA("BasePart") then targetVel = targetHRP.AssemblyLinearVelocity end
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
            if IsVeilSilentOn() and isSpearMode then isChargingSpear = true end
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
                    if targetHum and targetHum.MoveDirection.Magnitude > 0 then targetVel = targetHum.MoveDirection * targetHum.WalkSpeed
                    elseif targetHRP:IsA("BasePart") then targetVel = targetHRP.AssemblyLinearVelocity end
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
                else aimDirection = Camera.CFrame.LookVector end
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
            else VeilFOVFrame.Visible = false end
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
                    else if VeilTrackerLine then VeilTrackerLine.Visible = false end end
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

    W.VeilV2_API = {
        AimConfig = AimConfig,
        Config = Config,
        getClosestSurvivor = getClosestSurvivor,
        IsVeilSilentOn = IsVeilSilentOn,
        setTracker = function(v) VeilTrackerEnabled = v end,
    }
end

print("[FAZZHUB Part 9] Masked + Silent Veil V1 + Veil V2 loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 10: Bypass + Unlock Carry + Spear Aimbot + Killer Abilities
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local TweenService      = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local VirtualInputManager = nil
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 10] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local ForceNotify = W.VD_Notify or function() end
local TeamIs = W.TeamIs
local GetRole = W.GetRole

VD.KILLER_BypassLeap     = VD.KILLER_BypassLeap     or false
VD.KILLER_InfGrab        = VD.KILLER_InfGrab        or false
VD.KILLER_InfLakeMist    = VD.KILLER_InfLakeMist    or false
VD.KILLER_InfPursuit     = VD.KILLER_InfPursuit     or false
VD.KILLER_BypassCooldown = VD.KILLER_BypassCooldown or false
VD.KILLER_InfFrenzy      = VD.KILLER_InfFrenzy      or false
VD.KILLER_AutoHook       = VD.KILLER_AutoHook       or false
VD.KA_AutoStalk       = VD.KA_AutoStalk       or false
VD.KA_AutoStalkRange  = VD.KA_AutoStalkRange  or 150
VD.KA_AutoKillAll     = VD.KA_AutoKillAll     or false
VD.KA_DropAllPallet   = VD.KA_DropAllPallet   or false
VD.KA_BlockAllVault   = VD.KA_BlockAllVault   or false

-- ▸ HIDDEN LEAP BYPASS
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

-- ▸ INF GRAB (MYERS)
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
    VD.KILLER_InfGrab = MyersGrabData.Enabled
    if getgenv().FAZZ_MGrabBtn_UpdateVisual then pcall(getgenv().FAZZ_MGrabBtn_UpdateVisual) end
end
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == MyersGrabData.HotkeyCode and MyersGrabData.Enabled then
        W.doMyersGrab()
    end
end)

-- ▸ SLASHER BYPASS
getgenv().FAZZ_SlasherCooldownBypassThread = nil
function W.MAWWW_StartSlasherCooldownBypass()
    if getgenv().FAZZ_SlasherCooldownBypassThread then return end
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
    getgenv().FAZZ_SlasherCooldownBypassThread = task.spawn(function()
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
        getgenv().FAZZ_SlasherCooldownBypassThread = nil
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

-- ▸ ABYSS BYPASS
getgenv().FAZZ_AbyssCooldownBypassConnection = nil
getgenv().FAZZ_CorruptHandlerFunc = nil
function W.MAWWW_StartAbyssCooldownBypass()
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
    if getgenv().FAZZ_AbyssCooldownBypassConnection then
        getgenv().FAZZ_AbyssCooldownBypassConnection:Disconnect()
    end
    getgenv().FAZZ_AbyssCooldownBypassConnection = RunService.Heartbeat:Connect(function()
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
function W.MAWWW_StopAbyssCooldownBypass()
    if getgenv().FAZZ_AbyssCooldownBypassConnection then
        getgenv().FAZZ_AbyssCooldownBypassConnection:Disconnect()
        getgenv().FAZZ_AbyssCooldownBypassConnection = nil
    end
end
function W.MAWWW_SetAbyssBypass(v)
    VD.KILLER_BypassCooldown = v and true or false
    if VD.KILLER_BypassCooldown then W.MAWWW_StartAbyssCooldownBypass()
    else W.MAWWW_StopAbyssCooldownBypass() end
end

-- ▸ JEFF INF FRENZY
getgenv().FAZZ_JeffCooldownBypassThread = nil
function W.MAWWW_StartJeffCooldownBypass()
    if getgenv().FAZZ_JeffCooldownBypassThread then return end
    getgenv().FAZZ_JeffCooldownBypassThread = task.spawn(function()
        while task.wait() do
            if not VD.KILLER_InfFrenzy then break end
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:GetAttribute("Frenzy") ~= true then
                    char:SetAttribute("Frenzy", true)
                end
            end)
        end
        getgenv().FAZZ_JeffCooldownBypassThread = nil
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

-- ▸ UNLOCK SKILL WHILE CARRYING
do
    if not W.UnlockCarryConfig then W.UnlockCarryConfig = { Enabled = false, Hooked = false } end
    local CarryCfg = W.UnlockCarryConfig
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
    function W.UnlockCarry_SetEnabled(v)
        CarryCfg.Enabled = v and true or false
        if v then SetupCarryHook(); VD_Notify("Unlock Carry", "Enabled", 2)
        else VD_Notify("Unlock Carry", "Disabled", 2) end
    end
end

-- ▸ SPEAR AIMBOT
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
        else SpearBtnData.TargetLabel.Text = "AUTO" end
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
    LocalPlayer.CharacterAdded:Connect(function()
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

-- ▸ KILLER ABILITIES
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
function W.KA_UnblockAllVaults()
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

print("[FAZZHUB Part 10] Bypass + Unlock Carry + Spear Aimbot + Killer Abilities loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 11: Auto Hook + Silent Flask + Dash Lock
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local TweenService      = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 11] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local TeamIs = W.TeamIs
local GetRole = W.GetRole

VD.KILLER_AutoHook = VD.KILLER_AutoHook or false
VD.FLASK_SilentAim   = VD.FLASK_SilentAim   or false
VD.FLASK_ShowBeam    = VD.FLASK_ShowBeam    ~= false
VD.FLASK_ShowLanding = VD.FLASK_ShowLanding ~= false
VD.FLASK_Predict     = VD.FLASK_Predict     ~= false
VD.FLASK_Speed       = VD.FLASK_Speed       or 90
VD.FLASK_Gravity     = VD.FLASK_Gravity     or 196
VD.FLASK_LeadMult    = VD.FLASK_LeadMult    or 1.0
VD.FLASK_Range       = VD.FLASK_Range       or 200
VD.FLASK_BeamColor   = VD.FLASK_BeamColor   or Color3.fromRGB(255, 255, 255)
VD.FLASK_AccentColor = VD.FLASK_AccentColor or Color3.fromRGB(25, 25, 25)
VD.DashLockEnabled       = VD.DashLockEnabled      or false
VD.DashLockDuration      = VD.DashLockDuration     or 1.5
VD.DashLockSmoothness    = VD.DashLockSmoothness   or 0.3
VD.FreezeDuringDashLock  = VD.FreezeDuringDashLock or false
VD._DashLockActive       = false
VD._DashLockTarget       = nil
VD._DashLockConnection   = nil

-- ▸ AUTO HOOK (KILLER)
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

-- ▸ SILENT FLASK
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
            beam.Anchored = true; beam.CanCollide = false; beam.CanTouch = false; beam.CanQuery = false; beam.CastShadow = false
            beam.Material = Enum.Material.Neon
            beam.Color = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255)
            beam.Transparency = 0.2
            beam.Parent = Workspace
            FlaskState.BeamPart = beam
        end
        if not FlaskState.AccentPart or not FlaskState.AccentPart.Parent then
            local accent = Instance.new("Part")
            accent.Name = "FAZZFlaskBeamAccent"
            accent.Anchored = true; accent.CanCollide = false; accent.CanTouch = false; accent.CanQuery = false; accent.CastShadow = false
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
            ring.Anchored = true; ring.CanCollide = false; ring.CanTouch = false; ring.CanQuery = false; ring.CastShadow = false
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

-- ▸ DASH LOCK
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
                VD._DashLockConnection = RunService.RenderStepped:Connect(function() pcall(DashLock_Update) end)
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
                task.delay(VD.DashLockDuration or 1.5, function() DashLock_SetActive(false) end)
            end
        end)
    end
    if LocalPlayer.Character then DashLock_HookCharacter(LocalPlayer.Character) end
    LocalPlayer.CharacterAdded:Connect(function(c) task.wait(0.5); DashLock_HookCharacter(c) end)
    W.DashLock_SetActive = DashLock_SetActive
    W.DashLock_SetEnabled = function(v)
        VD.DashLockEnabled = v and true or false
        if not v then DashLock_SetActive(false) end
    end
end

print("[FAZZHUB Part 11] Auto Hook + Silent Flask + Dash Lock loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 12: Silent Veil V3
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local Config = {
    Enabled = false,
    ShowFOV = true,
    ShowTrajectory = true,
    FOV = 450,
    SpearSpeed = 165,
    Gravity = workspace.Gravity * 0.50,
    TargetPart = "HumanoidRootPart",
    PredictMode = "OFF",
    Veil_LeadMultiplier = 1.4,
}

local State = {
    chargingSpear = false,
    touchInput = nil,
    attackCooldown = false,
}

local renderConn = nil
local inputBeganConn = nil
local inputEndedConn = nil

local FOVCircle
pcall(function()
    if typeof(Drawing) == "table" and Drawing.new then
        FOVCircle = Drawing.new("Circle")
        FOVCircle.Color = Color3.fromRGB(170, 0, 255)
        FOVCircle.Thickness = 1.5
        FOVCircle.Filled = false
        FOVCircle.Visible = false
    end
end)

local PathFolder = workspace:FindFirstChild("FAZZHUB_Trajectory")
if PathFolder then PathFolder:Destroy() end
PathFolder = Instance.new("Folder")
PathFolder.Name = "FAZZHUB_Trajectory"
PathFolder.Parent = workspace

local TrajectoryParts = {}
local SEGMENTS = 15

for i = 1, SEGMENTS do
    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.Material = Enum.Material.Neon
    p.Color = Color3.fromRGB(170, 0, 255)
    p.Size = Vector3.new(0.15, 0.15, 1)
    p.Transparency = 1
    p.Parent = PathFolder
    TrajectoryParts[i] = p
end

local HitDot = Instance.new("Part")
HitDot.Name = "FAZZHUB_HitDot"
HitDot.Shape = Enum.PartType.Ball
HitDot.Size = Vector3.new(0.8, 0.8, 0.8)
HitDot.Anchored = true
HitDot.CanCollide = false
HitDot.Material = Enum.Material.Neon
HitDot.Color = Color3.fromRGB(170, 0, 255)
HitDot.Transparency = 1
HitDot.Parent = PathFolder

local function calculateAimVector(startPos, targetPos)
    local speed = Config.SpearSpeed
    local g = Config.Gravity
    local rawDiff = targetPos - startPos
    local horizontalDist = Vector3.new(rawDiff.X, 0, rawDiff.Z).Magnitude
    if horizontalDist < 286 then
        local adjustedTarget = targetPos + Vector3.new(0, 0.8, 0)
        local diff = adjustedTarget - startPos
        local horizontalDiff = Vector3.new(diff.X, 0, diff.Z)
        local x = horizontalDiff.Magnitude
        local y = diff.Y
        local v2 = speed * speed
        local v4 = v2 * v2
        local insideRoot = v4 - g * (g * (x * x) + 2 * y * v2)
        local theta
        if insideRoot < 0 or x <= 0.1 then
            theta = math.rad(42)
        else
            local tanTheta = (v2 - math.sqrt(insideRoot)) / (g * x)
            theta = math.atan(tanTheta)
        end
        local cosTheta = math.cos(theta)
        local sinTheta = math.sin(theta)
        local dir2D = horizontalDiff.Magnitude > 0 and horizontalDiff.Unit or Vector3.new(0, 0, 1)
        local aimDir = Vector3.new(dir2D.X * cosTheta, sinTheta, dir2D.Z * cosTheta).Unit
        local flightTime = x / (speed * math.max(cosTheta, 0.1))
        return aimDir, flightTime, g
    end
    local delta = math.clamp(horizontalDist - 285, 1, 5)
    local diff = targetPos - startPos
    local horizontalDiff = Vector3.new(diff.X, 0, diff.Z)
    local x = horizontalDiff.Magnitude
    local boostedAngleDeg = 43.4 + (delta * 0.32)
    local theta = math.rad(boostedAngleDeg)
    local cosTheta = math.cos(theta)
    local sinTheta = math.sin(theta)
    local dir2D = horizontalDiff.Magnitude > 0 and horizontalDiff.Unit or Vector3.new(0, 0, 1)
    local aimDir = Vector3.new(dir2D.X * cosTheta, sinTheta, dir2D.Z * cosTheta).Unit
    local flightTime = x / (speed * math.max(cosTheta, 0.1))
    return aimDir, flightTime, g
end

local function getV2PredictedPosition(targetPart, t)
    local targetHRP = targetPart:IsA("Model") and targetPart:FindFirstChild("HumanoidRootPart") or targetPart
    local targetPos = targetHRP.Position
    local targetVel = Vector3.zero
    local targetHum = targetPart.Parent and targetPart.Parent:FindFirstChildOfClass("Humanoid")
    if targetHum and targetHum.MoveDirection.Magnitude > 0 then
        targetVel = targetHum.MoveDirection * targetHum.WalkSpeed
    elseif targetHRP:IsA("BasePart") then
        targetVel = targetHRP.AssemblyLinearVelocity
    end
    targetVel = Vector3.new(targetVel.X, 0, targetVel.Z)
    return targetPos + (targetVel * (t * Config.Veil_LeadMultiplier))
end

local function isLocalPlayerKiller()
    local char = LocalPlayer.Character
    if char and char:GetAttribute("spearmode") ~= nil then
        return true
    end
    if LocalPlayer.Team then
        local name = LocalPlayer.Team.Name:lower()
        if name:find("killer") then
            return true
        end
    end
    return char and char:FindFirstChild("HumanoidRootPart") ~= nil and (char:GetAttribute("spearmode") == true or char:GetAttribute("spearmode") == false)
end

local function isSurvivorPlayer(p)
    if p == LocalPlayer then return false end
    if p.Team then
        local name = p.Team.Name:lower()
        if name:find("killer") then
            return false
        end
    end
    return true
end

local function getTargetPart(char)
    return char:FindFirstChild(Config.TargetPart) or char:FindFirstChild("Torso")
end

local function getClosestSurvivor()
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local cam = workspace.CurrentCamera
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    local bestDist = Config.FOV
    local bestTarget = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if isSurvivorPlayer(p) and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local part = getTargetPart(p.Character)
            if hum and hum.Health > 0 and part then
                local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if dist2D < bestDist then
                        bestDist = dist2D
                        bestTarget = { Player = p, Part = part, Humanoid = hum }
                    end
                end
            end
        end
    end
    return bestTarget
end

local function spawnHitNotification(character)
    local head = character:FindFirstChild("Head")
    if not head then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "HIT!"
    text.TextColor3 = Color3.fromRGB(170, 0, 255)
    text.TextStrokeTransparency = 1
    text.TextScaled = true
    text.Font = Enum.Font.GothamBlack
    text.Parent = billboard
    local ti = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(billboard, ti, {StudsOffset = Vector3.new(0, 5, 0)}):Play()
    TweenService:Create(text, ti, {TextTransparency = 1}):Play()
    task.delay(1.5, function()
        if billboard then billboard:Destroy() end
    end)
end

local function fire()
    if State.attackCooldown then return end
    State.attackCooldown = true
    task.delay(2, function() State.attackCooldown = false end)
    local myChar = LocalPlayer.Character
    local startPart = myChar and (myChar:FindFirstChild("Head") or myChar:FindFirstChild("HumanoidRootPart"))
    if not startPart then return end
    local startPos = startPart.Position
    local targetInfo = getClosestSurvivor()
    local aimDir
    if targetInfo and targetInfo.Part then
        local targetPart = targetInfo.Part
        local targetPos = targetPart.Position
        local speed = Config.SpearSpeed
        local distance = (targetPos - startPos).Magnitude
        local t = distance / speed
        local finalTargetPos = targetPos
        if Config.PredictMode == "V1" then
            local vel = targetPart.AssemblyLinearVelocity
            if vel and vel.Magnitude > 0.5 then
                finalTargetPos = targetPos + (Vector3.new(vel.X, 0, vel.Z) * t)
            else
                local lookVector = targetPart.CFrame.LookVector
                finalTargetPos = targetPos + (lookVector * 18.7 * t)
            end
        elseif Config.PredictMode == "V2" then
            finalTargetPos = getV2PredictedPosition(targetPart, t)
        end
        aimDir = calculateAimVector(startPos, finalTargetPos)
        if targetInfo.Humanoid then
            local hum = targetInfo.Humanoid
            local startHealth = hum.Health
            local hitConn
            hitConn = hum.HealthChanged:Connect(function(newHealth)
                if newHealth < startHealth then
                    spawnHitNotification(targetInfo.Player.Character)
                    if hitConn then hitConn:Disconnect() end
                end
            end)
            task.delay(2, function() if hitConn then hitConn:Disconnect() end end)
        end
    else
        aimDir = workspace.CurrentCamera.CFrame.LookVector
    end
    pcall(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        local killers = remotes and remotes:FindFirstChild("Killers")
        local veil = killers and killers:FindFirstChild("Veil")
        local spear = veil and veil:FindFirstChild("Spearthrow")
        if spear then
            spear:FireServer(aimDir, Config.SpearSpeed, startPos)
        end
    end)
end

pcall(function()
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if not checkcaller() and method == "FireServer" and self.Name == "Spearthrow" and Config.Enabled then
            return nil
        end
        return old(self, ...)
    end)
end)

inputBeganConn = UserInputService.InputBegan:Connect(function(input, gp)
    local isTouch = input.UserInputType == Enum.UserInputType.Touch
    if gp and not isTouch then return end
    local char = LocalPlayer.Character
    local isSpearMode = char and char:GetAttribute("spearmode") == true
    if not Config.Enabled or not isSpearMode then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        State.chargingSpear = true
    elseif isTouch then
        local pGui = LocalPlayer:FindFirstChild("PlayerGui")
        local slasher = pGui and pGui:FindFirstChild("Slasher-mob")
        local ctrl = slasher and slasher:FindFirstChild("Controls")
        local attackBtn = ctrl and ctrl:FindFirstChild("attack")
        if attackBtn and attackBtn.Visible then
            local pos = input.Position
            local absPos = attackBtn.AbsolutePosition
            local absSize = attackBtn.AbsoluteSize
            if pos.X >= absPos.X and pos.X <= absPos.X + absSize.X
            and pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y then
                State.chargingSpear = true
                State.touchInput = input
            end
        end
    end
end)

inputEndedConn = UserInputService.InputEnded:Connect(function(input)
    if State.chargingSpear and (input == State.touchInput or input.UserInputType == Enum.UserInputType.MouseButton1) then
        State.chargingSpear = false
        if State.touchInput == input then State.touchInput = nil end
        fire()
    end
end)

renderConn = RunService.RenderStepped:Connect(function()
    local cam = workspace.CurrentCamera
    local myChar = LocalPlayer.Character
    local isSpearMode = myChar and myChar:GetAttribute("spearmode") == true

    if not isLocalPlayerKiller() or not Config.Enabled then
        if FOVCircle then FOVCircle.Visible = false end
        for i = 1, SEGMENTS do TrajectoryParts[i].Transparency = 1 end
        HitDot.Transparency = 1
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local hl = p.Character:FindFirstChild("FAZZHUB_Highlight")
                if hl then hl:Destroy() end
            end
        end
        return
    end

    if FOVCircle then
        if Config.ShowFOV and isSpearMode then
            FOVCircle.Visible = true
            FOVCircle.Radius = Config.FOV
            FOVCircle.Position = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
        else
            FOVCircle.Visible = false
        end
    end

    for i = 1, SEGMENTS do TrajectoryParts[i].Transparency = 1 end
    HitDot.Transparency = 1

    local target = getClosestSurvivor()

    for _, p in ipairs(Players:GetPlayers()) do
        if isSurvivorPlayer(p) and p.Character then
            local char = p.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local isLockedTarget = (target and target.Player == p)
            local hl = char:FindFirstChild("FAZZHUB_Highlight")
            if isLockedTarget and hum and hum.Health > 0 then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "FAZZHUB_Highlight"
                    hl.Parent = char
                end
                hl.FillColor = Color3.fromRGB(0, 255, 100)
                hl.FillTransparency = 0.65
                hl.OutlineColor = Color3.fromRGB(0, 255, 150)
                hl.OutlineTransparency = 0.4
            else
                if hl then hl:Destroy() end
            end
        end
    end

    if not (isSpearMode and State.chargingSpear) then return end

    local indicatorColor = target and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(170, 0, 255)
    for i = 1, SEGMENTS do
        TrajectoryParts[i].Color = indicatorColor
    end
    HitDot.Color = indicatorColor

    if not target then return end

    local originPart = myChar:FindFirstChild("Head") or myChar:FindFirstChild("HumanoidRootPart")
    if not originPart then return end

    local originPos = originPart.Position
    local targetPart = target.Part
    local targetPos = targetPart.Position
    local speed = Config.SpearSpeed

    local distance = (targetPos - originPos).Magnitude
    local t = distance / speed
    local finalTargetPos = targetPos

    if Config.PredictMode == "V1" then
        local vel = targetPart.AssemblyLinearVelocity
        if vel and vel.Magnitude > 0.5 then
            finalTargetPos = targetPos + (Vector3.new(vel.X, 0, vel.Z) * t)
        else
            local lookVector = targetPart.CFrame.LookVector
            finalTargetPos = targetPos + (lookVector * 18.7 * t)
        end
    elseif Config.PredictMode == "V2" then
        finalTargetPos = getV2PredictedPosition(targetPart, t)
    end

    local aimDir, flightTime, simGravity = calculateAimVector(originPos, finalTargetPos)
    local aimVelocity = aimDir * speed

    if Config.ShowTrajectory then
        local simTime = flightTime or (distance / speed)
        local timeStep = simTime / SEGMENTS
        local currentPos = originPos
        for i = 1, SEGMENTS do
            local stepTime = i * timeStep
            local nextPos = originPos + (aimVelocity * stepTime) - Vector3.new(0, 0.5 * simGravity * (stepTime^2), 0)
            local part = TrajectoryParts[i]
            local dist = (nextPos - currentPos).Magnitude
            part.Size = Vector3.new(0.15, 0.15, dist)
            part.CFrame = CFrame.new((currentPos + nextPos) / 2, nextPos)
            part.Transparency = 0.2 + (i / SEGMENTS) * 0.5
            currentPos = nextPos
        end
        HitDot.Position = currentPos
        HitDot.Transparency = 0.15
    end
end)

task.spawn(function()
    local parent = nil
    if typeof(gethui) == "function" then
        pcall(function() parent = gethui() end)
    end
    if not parent then
        local s, cg = pcall(function() return game:GetService("CoreGui") end)
        if s and cg then
            local testS = pcall(function()
                local t = Instance.new("Folder")
                t.Parent = cg
                t:Destroy()
            end)
            if testS then parent = cg end
        end
    end
    if not parent then
        parent = LocalPlayer:WaitForChild("PlayerGui", 5)
    end

    if parent then
        local old = parent:FindFirstChild("FAZZHUB_SpearGUI_V3")
        if old then old:Destroy() end
    end
    local oldPgui = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("FAZZHUB_SpearGUI_V3")
    if oldPgui then oldPgui:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "FAZZHUB_SpearGUI_V3"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 999999
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = parent

    local cam = workspace.CurrentCamera
    local timeout = 0
    while (not cam or cam.ViewportSize.X <= 100) and timeout < 30 do
        task.wait(0.1)
        cam = workspace.CurrentCamera
        timeout = timeout + 1
    end

    local vpSize = (cam and cam.ViewportSize.X > 100) and cam.ViewportSize or Vector2.new(800, 600)
    local frameW, frameH = 220, 118
    local centerX = math.max(10, (vpSize.X / 2) - (frameW / 2))
    local centerY = math.max(10, (vpSize.Y / 2) - (frameH / 2))

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "Panel"
    MainFrame.Size = UDim2.fromOffset(frameW, frameH)
    MainFrame.Position = UDim2.new(0, centerX, 0, centerY)
    MainFrame.AnchorPoint = Vector2.new(0, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = gui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(170, 0, 255)
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame

    local InnerContainer = Instance.new("Frame")
    InnerContainer.Size = UDim2.new(1, -6, 1, -6)
    InnerContainer.Position = UDim2.new(0, 3, 0, 3)
    InnerContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    InnerContainer.ClipsDescendants = true
    InnerContainer.Parent = MainFrame
    Instance.new("UICorner", InnerContainer).CornerRadius = UDim.new(0, 6)

    local BgImage = Instance.new("ImageLabel")
    BgImage.Size = UDim2.new(1, 0, 1, 0)
    BgImage.BackgroundTransparency = 1
    BgImage.Image = "rbxassetid://93427694236333"
    BgImage.ScaleType = Enum.ScaleType.Crop
    BgImage.Parent = InnerContainer

    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 0.35
    Overlay.BorderSizePixel = 0
    Overlay.Parent = InnerContainer

    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 30)
    Header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Header.BackgroundTransparency = 0.4
    Header.BorderSizePixel = 0
    Header.Parent = Overlay

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "FAZZHUB SPEAR"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    Title.Parent = Header

    local BtnMin = Instance.new("TextButton")
    BtnMin.Size = UDim2.fromOffset(30, 30)
    BtnMin.Position = UDim2.new(1, -60, 0, 0)
    BtnMin.BackgroundTransparency = 1
    BtnMin.Text = "-"
    BtnMin.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnMin.Font = Enum.Font.GothamBold
    BtnMin.TextSize = 20
    BtnMin.Parent = Header

    local BtnClose = Instance.new("TextButton")
    BtnClose.Size = UDim2.fromOffset(30, 30)
    BtnClose.Position = UDim2.new(1, -30, 0, 0)
    BtnClose.BackgroundTransparency = 1
    BtnClose.Text = "X"
    BtnClose.TextColor3 = Color3.fromRGB(255, 50, 50)
    BtnClose.Font = Enum.Font.GothamBold
    BtnClose.TextSize = 16
    BtnClose.Parent = Header

    local dragging, dragInput, dragStart, startPos
    local targetPosition = MainFrame.Position

    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            targetPosition = startPos
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    local dragConn = UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local camera = workspace.CurrentCamera
            local viewportSize = camera.ViewportSize
            local newX = startPos.X.Offset + delta.X
            local newY = startPos.Y.Offset + delta.Y
            local frameWidth = MainFrame.AbsoluteSize.X
            local frameHeight = MainFrame.AbsoluteSize.Y
            newX = math.clamp(newX, 0, viewportSize.X - frameWidth)
            newY = math.clamp(newY, 0, viewportSize.Y - frameHeight)
            targetPosition = UDim2.new(0, newX, 0, newY)
        end
    end)

    local smoothMoveConn = RunService.RenderStepped:Connect(function(dt)
        if MainFrame and MainFrame.Parent then
            local currentPos = MainFrame.Position
            local alpha = math.clamp(dt * 20, 0, 1)
            local smoothX = currentPos.X.Offset + (targetPosition.X.Offset - currentPos.X.Offset) * alpha
            local smoothY = currentPos.Y.Offset + (targetPosition.Y.Offset - currentPos.Y.Offset) * alpha
            MainFrame.Position = UDim2.new(0, smoothX, 0, smoothY)
        end
    end)

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, 0, 1, -30)
    ContentFrame.Position = UDim2.new(0, 0, 0, 30)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = Overlay

    local BtnAim = Instance.new("TextButton")
    BtnAim.Size = UDim2.new(1, -20, 0, 32)
    BtnAim.Position = UDim2.new(0, 10, 0, 8)
    BtnAim.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    BtnAim.Text = "SILENT AIM: OFF"
    BtnAim.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnAim.Font = Enum.Font.GothamBold
    BtnAim.TextSize = 11
    BtnAim.Parent = ContentFrame
    Instance.new("UICorner", BtnAim).CornerRadius = UDim.new(0, 4)

    local BtnPredictV1 = Instance.new("TextButton")
    BtnPredictV1.Size = UDim2.new(0.5, -12, 0, 32)
    BtnPredictV1.Position = UDim2.new(0, 10, 0, 44)
    BtnPredictV1.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    BtnPredictV1.Text = "PRED V1: OFF"
    BtnPredictV1.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnPredictV1.Font = Enum.Font.GothamBold
    BtnPredictV1.TextSize = 11
    BtnPredictV1.Parent = ContentFrame
    Instance.new("UICorner", BtnPredictV1).CornerRadius = UDim.new(0, 4)

    local BtnPredictV2 = Instance.new("TextButton")
    BtnPredictV2.Size = UDim2.new(0.5, -12, 0, 32)
    BtnPredictV2.Position = UDim2.new(0.5, 2, 0, 44)
    BtnPredictV2.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    BtnPredictV2.Text = "PRED V2: OFF"
    BtnPredictV2.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnPredictV2.Font = Enum.Font.GothamBold
    BtnPredictV2.TextSize = 11
    BtnPredictV2.Parent = ContentFrame
    Instance.new("UICorner", BtnPredictV2).CornerRadius = UDim.new(0, 4)

    BtnAim.MouseButton1Click:Connect(function()
        Config.Enabled = not Config.Enabled
        if Config.Enabled then
            BtnAim.Text = "SILENT AIM: ON"
            BtnAim.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        else
            BtnAim.Text = "SILENT AIM: OFF"
            BtnAim.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        end
    end)

    local function updatePredictUI()
        if Config.PredictMode == "V1" then
            BtnPredictV1.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
            BtnPredictV1.Text = "PRED V1: ON"
            BtnPredictV2.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            BtnPredictV2.Text = "PRED V2: OFF"
        elseif Config.PredictMode == "V2" then
            BtnPredictV1.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            BtnPredictV1.Text = "PRED V1: OFF"
            BtnPredictV2.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            BtnPredictV2.Text = "PRED V2: ON"
        else
            BtnPredictV1.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            BtnPredictV1.Text = "PRED V1: OFF"
            BtnPredictV2.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            BtnPredictV2.Text = "PRED V2: OFF"
        end
    end

    BtnPredictV1.MouseButton1Click:Connect(function()
        if Config.PredictMode == "V1" then Config.PredictMode = "OFF"
        else Config.PredictMode = "V1" end
        updatePredictUI()
    end)

    BtnPredictV2.MouseButton1Click:Connect(function()
        if Config.PredictMode == "V2" then Config.PredictMode = "OFF"
        else Config.PredictMode = "V2" end
        updatePredictUI()
    end)

    local isMinimized = false
    BtnMin.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            BtnMin.Text = "+"
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(220, 30)}):Play()
        else
            BtnMin.Text = "-"
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(220, 118)}):Play()
        end
    end)

    BtnClose.MouseButton1Click:Connect(function()
        Config.Enabled = false
        Config.PredictMode = "OFF"
        Config.ShowFOV = false
        Config.ShowTrajectory = false
        State.chargingSpear = false
        State.touchInput = nil
        if renderConn then renderConn:Disconnect() renderConn = nil end
        if inputBeganConn then inputBeganConn:Disconnect() inputBeganConn = nil end
        if inputEndedConn then inputEndedConn:Disconnect() inputEndedConn = nil end
        if dragConn then dragConn:Disconnect() dragConn = nil end
        if smoothMoveConn then smoothMoveConn:Disconnect() smoothMoveConn = nil end
        if FOVCircle then
            pcall(function()
                FOVCircle.Visible = false
                FOVCircle:Remove()
            end)
            FOVCircle = nil
        end
        if PathFolder then
            PathFolder:Destroy()
            PathFolder = nil
        end
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local hl = p.Character:FindFirstChild("FAZZHUB_Highlight")
                if hl then hl:Destroy() end
            end
        end
        gui:Destroy()
    end)
end)

print("[FAZZHUB Part 12] Silent Veil V3 loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 13: UI Build (Window + Tabs + All Sections)
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local UserInputService  = game:GetService("UserInputService")
local CoreGui           = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 13] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local ForceNotify = W.VD_Notify or function() end

local SurvivorTab = FAZZTabs.Survivor
local VisualsTab  = FAZZTabs.Visuals
local KillerTab   = FAZZTabs.Killer
local MiscTab     = FAZZTabs.Misc
local ConfigTab   = FAZZTabs.Config

local function Sec(tab, name) return tab:AddSection(name) end

-- ═══════════════════════════════════════════════
-- SURVIVOR TAB
-- ═══════════════════════════════════════════════

local escSec = Sec(SurvivorTab, "Instant Escape")
escSec:AddToggle({ Title = "Enable Escape Button", Default = false, Callback = function(v)
    if getgenv().FAZZ_Escape_SetEnabled then getgenv().FAZZ_Escape_SetEnabled(v) end
end })
escSec:AddButton({ Title = "Teleport Now", Callback = function() W.Escape_Teleport() end })

local healSec = Sec(SurvivorTab, "Self Heal")
healSec:AddToggle({ Title = "Self Heal Progress", Default = false, Callback = function(v)
    W.setInstantHealSelf(v)
    if getgenv().FAZZ_SHB_UpdateVisual then getgenv().FAZZ_SHB_UpdateVisual() end
end })
healSec:AddToggle({ Title = "Auto Heal All", Default = false, Callback = function(v) W.setAutoHealAll(v) end })
healSec:AddToggle({ Title = "Show Self Heal Button", Default = false, Callback = function(v)
    if getgenv().FAZZ_SHB_SetEnabled then getgenv().FAZZ_SHB_SetEnabled(v) end
end })

local vaultSec = Sec(SurvivorTab, "Swift Vault")
vaultSec:AddToggle({ Title = "Swift Vault (Auto Vault)", Default = VD.SURV_AutoVault, Callback = function(v)
    W.SwiftVault_SetEnabled(v)
end })
vaultSec:AddToggle({ Title = "Swift Vault V2 (Custom Speed)", Default = VD.SURV_FastVault, Callback = function(v)
    W.SwiftVaultV2_SetEnabled(v)
end })
vaultSec:AddSlider({ Title = "Vault Speed", Min = 10, Max = 20, Default = VD.SURF_VaultSpeed, Increment = 1,
    Callback = function(v) W.SwiftVault_SetSpeed(v) end })

local palletSec = Sec(SurvivorTab, "Pallet Reflex")
palletSec:AddToggle({ Title = "Enable Pallet Reflex", Default = VD.SURV_AutoPallet, Callback = function(v)
    W.PalletReflex_SetEnabled(v)
end })
palletSec:AddSlider({ Title = "Trigger Distance", Min = 5, Max = 50, Default = VD.SURV_AutoPalletDist,
    Increment = 1, Suffix = " studs", Callback = function(v) W.PalletReflex_SetDistance(v) end })

local fpSec = Sec(SurvivorTab, "Fake Parry")
fpSec:AddToggle({ Title = "Enable Fake Parry", Default = false, Keybind = true, Callback = function(v)
    W.FakeParry_SetEnabled(v)
end })
fpSec:AddDropdown({ Title = "Animation", Options = { "Enten", "Stopwatch", "Fih", "BloodShield" },
    Default = VD.SURV_FakeParryAnim or "Enten", Multi = false, Callback = function(v)
        if type(v) == "table" then v = v[1] end
        W.FakeParry_SetAnim(v)
    end })
fpSec:AddInput({ Title = "Keybind", Default = VD.SURV_FakeParryKey or "V", Placeholder = "V / G / F / X / B",
    Callback = function(input)
        input = tostring(input or ""):gsub("%s+", "")
        if input == "" then return end
        W.FakeParry_SetKeybind(input)
    end })
fpSec:AddSlider({ Title = "Cooldown", Min = 0, Max = 3, Default = VD.SURV_FakeParryCooldown or 0.4, Increment = 0.1, Suffix = "s",
    Callback = function(v) VD.SURV_FakeParryCooldown = v end })
fpSec:AddToggle({ Title = "Show Floating Button", Default = false, Callback = function(v) W.FakeParry_SetShowButton(v) end })
fpSec:AddButton({ Title = "Test Fake Parry Now", Callback = function()
    W.FakeParry_Trigger()
    ForceNotify("Fake Parry", "Playing animation...", 2)
end })

local fleeSec = Sec(SurvivorTab, "Auto Flee Killer")
fleeSec:AddToggle({ Title = "Enable Auto Flee", Default = VD.SURV_AutoFlee, Callback = function(v)
    VD.SURV_AutoFlee = v
end })
fleeSec:AddSlider({ Title = "Detect Distance", Min = 15, Max = 150, Default = VD.SURV_AutoFleeDist, Increment = 5, Suffix = " studs",
    Callback = function(v) VD.SURV_AutoFleeDist = v end })
fleeSec:AddSlider({ Title = "Flee Cooldown", Min = 0.5, Max = 10, Default = VD.SURV_AutoFleeCooldown, Increment = 0.5, Suffix = "s",
    Callback = function(v) VD.SURV_AutoFleeCooldown = v end })

local fakePerksSec = Sec(SurvivorTab, "Fake Perks")
fakePerksSec:AddToggle({ Title = "Flowstate (Buff on Vault/Slide)", Default = false, Callback = function(v) W.FP_SetupFlowstate(v) end })
fakePerksSec:AddToggle({ Title = "Quick Recovery (Buff on Heal)", Default = false, Callback = function(v) W.FP_SetupQuickRecovery(v) end })
fakePerksSec:AddToggle({ Title = "Perfect Landing (Buff on Land)", Default = false, Callback = function(v) W.FP_SetupPerfectLanding(v) end })
fakePerksSec:AddToggle({ Title = "Adrenaline Rush (Buff on Low HP)", Default = false, Callback = function(v) W.FP_SetupAdrenalineRush(v) end })
fakePerksSec:AddSlider({ Title = "Perk Cooldown", Min = 0, Max = 30, Default = 5, Increment = 1, Suffix = "s",
    Callback = function(v) W.FP.CooldownTime = v end })
fakePerksSec:AddButton({ Title = "Clear All Active Buffs", Callback = function()
    for k in pairs(W.FP.ActiveBuffs) do W.FP.ActiveBuffs[k] = nil end
    local c = LocalPlayer.Character
    if c then c:SetAttribute("speedboost", 1) end
    local h = c and c:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = 16 end
end })

local skillSec = Sec(SurvivorTab, "Auto Skill Check")
skillSec:AddToggle({ Title = "Enable Auto Skill Check", Default = false, Callback = function(v) W.SkillCheck_SetEnabled(v) end })
skillSec:AddDropdown({ Title = "Mode", Options = {"Legit", "Instant"}, Default = "Legit",
    Callback = function(v) W.SkillCheck.Mode = v end })

local genSec = Sec(SurvivorTab, "Bypass Generator")
genSec:AddToggle({ Title = "Enable Bypass Generator", Default = false, Callback = function(v) W.setGenBypass(v) end })
genSec:AddSlider({ Title = "Trigger Range", Min = 3, Max = 20, Default = 8, Increment = 1, Suffix = " studs",
    Callback = function(v) W.GenBypass.TriggerRange = v end })
genSec:AddButton({ Title = "Force Repair Nearest Generator", Callback = function()
    local bp, bd = W.GB_GetNearestPoint()
    if bp and bd <= W.GenBypass.TriggerRange then W.GB_DoRepair(bp) end
end })

local uvSec = Sec(SurvivorTab, "Unlimited Vault")
uvSec:AddToggle({ Title = "Unlimited Vault", Default = false, Keybind = true, Callback = function(state)
    if state then W.EnableUnlimitedVault() else W.DisableUnlimitedVault() end
end })

local asvSec = Sec(SurvivorTab, "Anti Slow Vault")
asvSec:AddToggle({ Title = "Anti Slow Vault", Default = false, Keybind = true, Callback = function(state)
    if state then W.EnableAntiSlowVault() else W.DisableAntiSlowVault() end
end })

local godSec = Sec(SurvivorTab, "God Mode")
godSec:AddToggle({ Title = "God Mode", Default = false, Keybind = true, Callback = function(state)
    W.GodModeEnabled = state
    if state then W.StartGodMode() else W.StopGodMode() end
end })

local arSec = Sec(SurvivorTab, "Auto Run")
arSec:AddToggle({ Title = "Auto Run [PC]", Default = false, Callback = function(v)
    W.AutoRunPCEnabled = v
    if v then W.StartAutoRunPC() else W.StopAutoRunPC() end
end })
arSec:AddToggle({ Title = "Auto Run [Mobile]", Default = false, Callback = function(v)
    W.AutoRunMobileEnabled = v
    if v then W.StartAutoRunMobile() else W.StopAutoRunMobile() end
end })

local trollSec = Sec(SurvivorTab, "Troll Teleport")
trollSec:AddToggle({ Title = "Enable Troll Teleport", Default = false, Callback = function(v)
    W.TrollTeleport_SetEnabled(v)
    if getgenv().FAZZ_TTB_UpdateVisual then getgenv().FAZZ_TTB_UpdateVisual() end
end })
trollSec:AddToggle({ Title = "Show Troll TP Button", Default = false, Callback = function(v)
    if getgenv().FAZZ_TTB_SetEnabled then getgenv().FAZZ_TTB_SetEnabled(v) end
end })

local acSec = Sec(SurvivorTab, "Auto Crouch Dodge")
acSec:AddToggle({ Title = "Enable Auto Crouch Dodge", Default = VD.AutoCrouch, Callback = function(v) VD.AutoCrouch = v end })

local p1Sec = Sec(SurvivorTab, "Auto Parry V1")
p1Sec:AddToggle({ Title = "Enable Auto Parry", Default = VD.PARRY_Enabled, Callback = function(v)
    VD.PARRY_Enabled = v
    if not v and W.ParryState then W.ParryState.ActiveAttackers = {} end
end })
p1Sec:AddToggle({ Title = "Show Parry Button", Default = false, Callback = function(v)
    VD.PARRY_ShowFloatBtn = v
    if getgenv().FAZZ_ParryBtn_SetEnabled then getgenv().FAZZ_ParryBtn_SetEnabled(v) end
end })
p1Sec:AddToggle({ Title = "Auto Parry Aggressive", Default = VD.PARRY_Aggressive, Callback = function(v) VD.PARRY_Aggressive = v end })
p1Sec:AddSlider({ Title = "Parry Distance", Min = 4, Max = 30, Default = VD.PARRY_Distance, Increment = 1, Callback = function(v) VD.PARRY_Distance = v end })
p1Sec:AddToggle({ Title = "Show Parry Range", Default = VD.PARRY_ShowCircle, Callback = function(v)
    VD.PARRY_ShowCircle = v
    if not v and getgenv()._FAZZ_DestroyParryCircle then pcall(getgenv()._FAZZ_DestroyParryCircle) end
end })
p1Sec:AddToggle({ Title = "Silent Parry (Legit)", Default = VD.PARRY_SilentParry, Callback = function(v) VD.PARRY_SilentParry = v end })

local p2Sec = Sec(SurvivorTab, "Auto Parry V2")
p2Sec:AddToggle({ Title = "Enable Auto Parry V2", Default = VD.Wisnu_AutoParry, Callback = function(v)
    VD.Wisnu_AutoParry = v and true or false
end })
p2Sec:AddToggle({ Title = "Aggressive Mode", Default = VD.Wisnu_ParryAggressive, Callback = function(v) VD.Wisnu_ParryAggressive = v and true or false end })
p2Sec:AddToggle({ Title = "Safety Parry", Default = VD.Wisnu_ParrySafety, Callback = function(v) VD.Wisnu_ParrySafety = v and true or false end })
p2Sec:AddSlider({ Title = "Parry Distance", Min = 4, Max = 25, Default = VD.Wisnu_ParryDistance, Increment = 1, Suffix = " studs",
    Callback = function(v) VD.Wisnu_ParryDistance = v end })
p2Sec:AddSlider({ Title = "Face Sensitivity Killer", Min = -1, Max = 1, Default = VD.Wisnu_ParryFace, Increment = 0.05,
    Callback = function(v) VD.Wisnu_ParryFace = v end })
p2Sec:AddToggle({ Title = "Show Range Circle", Default = VD.Wisnu_ParryCircle, Callback = function(v) VD.Wisnu_ParryCircle = v and true or false end })
p2Sec:AddDropdown({ Title = "Ignore Skills", Options = { "Hidden S1", "Abyssal S1" }, Multi = true, Default = {},
    Callback = function(sel)
        local parsed = {}
        if type(sel) == "table" then
            for k, v in pairs(sel) do
                if type(k) == "string" and v then parsed[k] = true
                elseif type(v) == "string" then parsed[v] = true end
            end
        elseif type(sel) == "string" then parsed[sel] = true end
        VD.Wisnu_IgnoredSkills = parsed
    end })

local nfSec = Sec(SurvivorTab, "Anti Fall Damage")
nfSec:AddToggle({ Title = "Enable No Fall Damage", Default = false, Callback = function(v) VD.NoFallDamage = v and true or false end })

local mpSec = Sec(SurvivorTab, "Next Map Prediction")
mpSec:AddToggle({ Title = "Enable Map Prediction", Default = false, Callback = function(v)
    if W.NextMapPredict_SetEnabled then W.NextMapPredict_SetEnabled(v) end
end })

local mgSec = Sec(SurvivorTab, "Manual Generator")
mgSec:AddToggle({ Title = "Enable Manual Generator", Default = false, Callback = function(v)
    if W.ManualGen_SetEnabled then W.ManualGen_SetEnabled(v) end
end })
mgSec:AddSlider({ Title = "Killer Escape Distance", Min = 10, Max = 80, Default = 30, Increment = 5, Suffix = " studs",
    Callback = function(v) if W.GenAuto_SetDistance then W.GenAuto_SetDistance(v) end end })

local agSec = Sec(SurvivorTab, "Auto Generator")
agSec:AddToggle({ Title = "Enable Auto Generator", Default = false, Callback = function(v)
    if W.AutoGen_SetEnabled then W.AutoGen_SetEnabled(v) end
end })

local suSec = Sec(SurvivorTab, "Bypass Self Unhook")
suSec:AddToggle({ Title = "Enable Bypass Self Unhook", Default = false, Callback = function(v)
    W.SU_SetEnabled(v)
    if getgenv().FAZZ_SUB_UpdateVisual then getgenv().FAZZ_SUB_UpdateVisual() end
end })
suSec:AddToggle({ Title = "Show Self Unhook Button", Default = false, Callback = function(v)
    if getgenv().FAZZ_SUB_SetEnabled then getgenv().FAZZ_SUB_SetEnabled(v) end
end })
suSec:AddSlider({ Title = "Follow Duration", Min = 5, Max = 120, Default = 30, Increment = 5, Suffix = "s",
    Callback = function(v) W.SelfUnhook.FollowDuration = v end })
suSec:AddSlider({ Title = "Follow Distance", Min = 5, Max = 60, Default = 20, Increment = 1, Suffix = " studs",
    Callback = function(v) W.SelfUnhook.FollowDistance = v end })

local tofSec = Sec(SurvivorTab, "Silent Aim TOF")
tofSec:AddToggle({ Title = "Enable Silent Aim", Default = VD.TOF_SilentAim, Callback = function(v) W.SetToFSilentAim(v) end })
tofSec:AddDropdown({ Title = "Target Mode", Options = { "Killer", "Survivors", "Zombie" }, Default = "Killer",
    Callback = function(v) if W.ToF_SetTargetMode then W.ToF_SetTargetMode(v, true) end end })
tofSec:AddToggle({ Title = "Show Laser Beam", Default = true, Callback = function(v)
    VD.TOF_Laser = v
    if not v and W.ToF_ClearLaser then W.ToF_ClearLaser() end
end })
tofSec:AddToggle({ Title = "Wall Check", Default = true, Callback = function(v) VD.TOF_WallCheck = v end })
tofSec:AddToggle({ Title = "Block When Knocked", Default = true, Callback = function(v) VD.TOF_BlockKnocked = v end })

local flashSec = Sec(SurvivorTab, "Silent Flashlight")
flashSec:AddToggle({ Title = "Enable Silent Flashlight", Default = VD.FLASH_SilentAim, Callback = function(v) W.Flash_SetEnabled(v) end })
flashSec:AddDropdown({ Title = "Target Part", Options = {"Head", "UpperTorso", "Torso", "HumanoidRootPart"},
    Default = VD.FLASH_TargetPart, Callback = function(v) VD.FLASH_TargetPart = type(v) == "table" and v[1] or v or "Head" end })
flashSec:AddSlider({ Title = "Max Range", Min = 20, Max = 250, Default = VD.FLASH_Range, Increment = 5, Suffix = " studs", Callback = function(v) VD.FLASH_Range = v end })
flashSec:AddSlider({ Title = "Smoothness", Min = 0.05, Max = 1, Default = VD.FLASH_Smooth, Increment = 0.05, Callback = function(v) VD.FLASH_Smooth = v end })
flashSec:AddToggle({ Title = "Show Laser", Default = VD.FLASH_Laser, Callback = function(v)
    VD.FLASH_Laser = v
    if not v and W.Flash_ClearLaser then W.Flash_ClearLaser() end
end })

local gunSec = Sec(SurvivorTab, "Aim Lock Gun")
gunSec:AddToggle({ Title = "Enable Aim Lock Gun", Default = false, Keybind = true, Callback = function(v)
    if W.GunAim_Cfg then W.GunAim_Cfg.Enabled = v end
    if v and W.GunAim_Start then W.GunAim_Start() end
end })
gunSec:AddDropdown({ Title = "Target Mode", Options = { "Killer", "Survivor" }, Default = "Killer",
    Callback = function(v)
        local val = type(v) == "table" and v[1] or v
        if W.GunAim_Cfg then W.GunAim_Cfg.TargetMode = val end
    end })
gunSec:AddSlider({ Title = "FOV Radius", Min = 50, Max = 1000, Default = 250, Increment = 10,
    Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.FOV = v end end })
gunSec:AddSlider({ Title = "Aim Smoothness", Min = 0.1, Max = 1, Default = 0.5, Increment = 0.05,
    Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.Strength = v end end })
gunSec:AddSlider({ Title = "Prediction Strength", Min = 0, Max = 1, Default = 0.12, Increment = 0.01,
    Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.PredictStrength = v end end })
gunSec:AddToggle({ Title = "Visibility Check", Default = true,
    Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.VisibilityCheck = v end end })

local mwSec = Sec(SurvivorTab, "Moonwalk")
mwSec:AddToggle({ Title = "Moonwalk", Default = false, Keybind = true, Callback = function(v) W.setMoonwalk(v) end })
mwSec:AddSlider({ Title = "Side Speed", Min = 0.1, Max = 3, Default = 0.9, Increment = 0.1,
    Callback = function(v) W.MOONWALK_SIDE_SPEED = v end })
mwSec:AddSlider({ Title = "Back Speed", Min = 0.1, Max = 3, Default = 1.2, Increment = 0.1,
    Callback = function(v) W.MOONWALK_BACK_SPEED = v end })
mwSec:AddSlider({ Title = "Switch Interval", Min = 0.02, Max = 0.5, Default = 0.07, Increment = 0.01,
    Callback = function(v) W.MOONWALK_INTERVAL = v end })
mwSec:AddToggle({ Title = "Show Moonwalk Floating Button", Default = false, Callback = function(v)
    if getgenv().FAZZ_MoonwalkBtn_SetEnabled then getgenv().FAZZ_MoonwalkBtn_SetEnabled(v) end
end })

local kpSec = Sec(SurvivorTab, "Killer Perks Display")
kpSec:AddToggle({ Title = "Enable Killer Perks Display", Default = false, Callback = function(v)
    if W.KillerPerksDisplay_SetEnabled then W.KillerPerksDisplay_SetEnabled(v) end
end })

print("[FAZZHUB Part 13] UI Build Survivor loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 14: UI Visuals + UI Killer
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local UserInputService  = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 14] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local ForceNotify = W.VD_Notify or function() end

local VisualsTab = FAZZTabs.Visuals
local KillerTab  = FAZZTabs.Killer

local function Sec(tab, name) return tab:AddSection(name) end

-- ═══════════════════════════════════════════════
-- VISUALS TAB
-- ═══════════════════════════════════════════════

local espSec = Sec(VisualsTab, "Full ESP System")
espSec:AddToggle({ Title = "ESP Survivor", Default = false, Callback = function(v) W.FullESP.Survivor = v end })
espSec:AddColorPicker({ Title = "Survivor Color", Default = W.FullESPColors.Survivor, Save = false, Callback = function(c) W.FullESPColors.Survivor = c end })
espSec:AddToggle({ Title = "ESP Killer", Default = false, Callback = function(v) W.FullESP.Killer = v end })
espSec:AddColorPicker({ Title = "Killer Color", Default = W.FullESPColors.Killer, Save = false, Callback = function(c) W.FullESPColors.Killer = c end })
espSec:AddToggle({ Title = "ESP Generator", Default = false, Callback = function(v) W.FullESP.Generator = v end })
espSec:AddColorPicker({ Title = "Generator Color", Default = W.FullESPColors.Generator, Save = false, Callback = function(c) W.FullESPColors.Generator = c end })
espSec:AddToggle({ Title = "ESP Pallet", Default = false, Callback = function(v) W.FullESP.Pallet = v end })
espSec:AddColorPicker({ Title = "Pallet Color", Default = W.FullESPColors.Pallet, Save = false, Callback = function(c) W.FullESPColors.Pallet = c end })
espSec:AddToggle({ Title = "ESP Window", Default = false, Callback = function(v)
    W.FullESP.Window = v
    _G.FAZZWindowScanned = false
end })
espSec:AddColorPicker({ Title = "Window Color", Default = W.FullESPColors.Window, Save = false, Callback = function(c) W.FullESPColors.Window = c end })
espSec:AddToggle({ Title = "ESP SCP", Default = false, Callback = function(v) W.FullESP.SCP = v end })
espSec:AddColorPicker({ Title = "SCP Color", Default = W.FullESPColors.SCP, Save = false, Callback = function(c) W.FullESPColors.SCP = c end })
espSec:AddSlider({ Title = "ESP Radius", Min = 10, Max = 1000, Default = 500, Increment = 10, Callback = function(v) W.FullESP.Distance = v end })

local espStatSec = Sec(VisualsTab, "ESP Status")
espStatSec:AddToggle({ Title = "Enable Status ESP", Default = false, Callback = function(v) W.FullESPStatus.Enabled = v end })
espStatSec:AddToggle({ Title = "Show Name", Default = true, Callback = function(v) W.FullESPStatus.ShowName = v end })
espStatSec:AddToggle({ Title = "Show Distance", Default = true, Callback = function(v) W.FullESPStatus.ShowDistance = v end })
espStatSec:AddSlider({ Title = "Status Radius", Min = 20, Max = 1000, Default = 500, Increment = 10, Callback = function(v) W.FullESPStatus.Radius = v end })

local grSec = Sec(VisualsTab, "Graphics")
grSec:AddToggle({ Title = "Fullbright", Default = false, Callback = function(v) W.Graphics.Fullbright = v; W.Graphics_Apply() end })
grSec:AddToggle({ Title = "No Shadow", Default = false, Callback = function(v) W.Graphics.NoShadow = v; W.Graphics_Apply() end })
grSec:AddToggle({ Title = "Low Graphics", Default = false, Callback = function(v) W.Graphics.LowGraphics = v; W.Graphics_ApplyOptimization() end })
grSec:AddToggle({ Title = "No Screen Effects", Default = false, Callback = function(v) W.Graphics.NoScreenEffects = v; W.Graphics_ApplyNoScreenFx() end })
grSec:AddToggle({ Title = "Clean Sky", Default = false, Callback = function(v) W.Graphics.CleanSky = v; W.Graphics_ApplyOptimization() end })
grSec:AddToggle({ Title = "Potato Mode", Default = false, Callback = function(v)
    if W.Potato_SetEnabled then W.Potato_SetEnabled(v) end
end })

local tmSec = Sec(VisualsTab, "Clock & Ambient")
tmSec:AddToggle({ Title = "Enable Clock Override", Default = false, Callback = function(v) W.Graphics.ClockTimeEnabled = v; W.Graphics_Apply() end })
tmSec:AddSlider({ Title = "Clock Time", Min = 0, Max = 24, Default = 14, Increment = 1, Callback = function(v)
    W.Graphics.ClockTime = v; W.Graphics.ClockTimeEnabled = true; W.Graphics_Apply() end })
tmSec:AddSlider({ Title = "Brightness", Min = 0, Max = 5, Default = 2, Increment = 0.1, Callback = function(v)
    W.Graphics.Brightness = v; W.Graphics.ClockTimeEnabled = true; W.Graphics_Apply() end })

local zmSec = Sec(VisualsTab, "Zoom & FOV")
zmSec:AddToggle({ Title = "Unlimited Zoom", Default = false, Callback = function(v) W.Graphics.UnlimitedZoom = v; W.Graphics_ApplyZoom() end })
zmSec:AddSlider({ Title = "Max Zoom Distance", Min = 100, Max = 5000, Default = 1000, Increment = 50, Callback = function(v)
    W.Graphics.MaxZoomDistance = v; if W.Graphics.UnlimitedZoom then W.Graphics_ApplyZoom() end end })
zmSec:AddToggle({ Title = "Custom FOV", Default = false, Callback = function(v) W.Graphics.FOVEnabled = v; W.Graphics_ApplyFOV() end })
zmSec:AddSlider({ Title = "Camera FOV", Min = 40, Max = 120, Default = 70, Increment = 5, Callback = function(v)
    W.Graphics.FOV = v; if W.Graphics.FOVEnabled then W.Graphics_ApplyFOV() end end })

local povSec = Sec(VisualsTab, "Lock POV")
povSec:AddToggle({ Title = "Enable Lock POV", Default = false, Callback = function(v)
    if W.LockPOV_SetEnabled then W.LockPOV_SetEnabled(v) end
end })
povSec:AddSlider({ Title = "Locked FOV", Min = 40, Max = 120, Default = 80, Increment = 5,
    Callback = function(v)
        if W.LockPOV then
            W.LockPOV.LockedFOV = v
            if W.LockPOV.Enabled then
                local cam = workspace.CurrentCamera
                if cam then cam.FieldOfView = v end
            end
        end
    end })

-- ═══════════════════════════════════════════════
-- KILLER TAB
-- ═══════════════════════════════════════════════

local aaSec = Sec(KillerTab, "Auto Attack")
aaSec:AddToggle({ Title = "Enable Auto Attack", Default = VD.KILLER_AutoAttack, Callback = function(v) VD.KILLER_AutoAttack = v end })
aaSec:AddSlider({ Title = "Attack Range", Min = 5, Max = 30, Default = VD.KILLER_AutoAttackRange, Increment = 1, Suffix = " studs",
    Callback = function(v) VD.KILLER_AutoAttackRange = v end })
aaSec:AddSlider({ Title = "Attack Cooldown", Min = 0.05, Max = 1, Default = VD.KILLER_AutoAttackCooldown, Increment = 0.05, Suffix = "s",
    Callback = function(v) VD.KILLER_AutoAttackCooldown = v end })

local ilSec = Sec(KillerTab, "Infinite Lunge")
ilSec:AddToggle({ Title = "Infinite Lunge (Basic Attack)", Default = false, Callback = function(v) VD.KILLER_InfLunge = v end })

local cpSec = Sec(KillerTab, "Counter Auto Parry")
cpSec:AddToggle({ Title = "Counter Auto Parry", Default = false, Keybind = true, Callback = function(v)
    if W.CounterParry_SetEnabled then W.CounterParry_SetEnabled(v) end
end })

local alhSec = Sec(KillerTab, "Aim Lock Hidden")
alhSec:AddToggle({ Title = "Aim Lock Hidden (Hold)", Default = false, Keybind = true, Callback = function(state)
    if W.AimLockHidden_SetEnabled then W.AimLockHidden_SetEnabled(state) end
end })
alhSec:AddInput({ Title = "Hold Keybind", Default = "E", Placeholder = "E / Q / F / LeftShift",
    Callback = function(input)
        input = tostring(input or ""):gsub("%s+", "")
        if input == "" then return end
        if W.AimLockHidden_SetHoldKey then W.AimLockHidden_SetHoldKey(input) end
    end })

local alaSec = Sec(KillerTab, "Aim Lock Attack")
alaSec:AddToggle({ Title = "Enable Aim Lock Attack", Default = false, Keybind = true, Callback = function(v)
    if W.AttackAim_Cfg then W.AttackAim_Cfg.Enabled = v end
    if v and W.AttackAim_Start then W.AttackAim_Start() end
end })
alaSec:AddSlider({ Title = "FOV Radius", Min = 50, Max = 1000, Default = 250, Increment = 10,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.FOV = v end end })
alaSec:AddSlider({ Title = "Aim Smoothness", Min = 0.1, Max = 1, Default = 1, Increment = 0.05,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.Strength = v end end })
alaSec:AddSlider({ Title = "Prediction Strength", Min = 0, Max = 1, Default = 0.12, Increment = 0.01,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.PredictStrength = v end end })
alaSec:AddDropdown({ Title = "Aim Part", Options = { "Head", "HumanoidRootPart", "UpperTorso", "Torso" }, Default = "HumanoidRootPart",
    Callback = function(v)
        local val = type(v) == "table" and v[1] or v
        if W.AttackAim_Cfg then W.AttackAim_Cfg.AimPart = val end
    end })
alaSec:AddToggle({ Title = "Visibility Check", Default = true,
    Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.VisibilityCheck = v end end })

local abSec = Sec(KillerTab, "Anti Blind")
abSec:AddToggle({ Title = "Anti Blind (Flashlight)", Default = false, Callback = function(v)
    VD.KILLER_AntiBlind = v
    if v and W.SetupAntiBlind then pcall(W.SetupAntiBlind) end
end })

local dpSec = Sec(KillerTab, "Destroy Pallet")
dpSec:AddToggle({ Title = "Auto Destroy Pallet", Default = false, Keybind = true, Callback = function(v)
    VD.KILLER_DestroyPallets = v
end })

local mkSec = Sec(KillerTab, "Select Masked Power")
mkSec:AddDropdown({ Title = "Masked Power", Options = W.Masked.Powers, Default = W.Masked.CurrentPower,
    Callback = function(v)
        local val = type(v) == "table" and v[1] or v
        W.Masked.CurrentPower = val
    end })
mkSec:AddButton({ Title = "Activate Power", Callback = function() W.Masked_Activate() end })
mkSec:AddButton({ Title = "Deactivate Power", Callback = function() W.Masked_Deactivate() end })

local v1Sec = Sec(KillerTab, "Silent Spear Veil V1")
v1Sec:AddToggle({ Title = "Enable Silent Veil V1", Default = VD.VeilEnabled, Callback = function(v)
    VD.VeilEnabled = v
end })
v1Sec:AddToggle({ Title = "Show FOV Circle", Default = VD.VeilShowFOV, Callback = function(v) VD.VeilShowFOV = v end })
v1Sec:AddToggle({ Title = "Show Target Tracker", Default = VD.VeilShowTracker, Callback = function(v) VD.VeilShowTracker = v end })
v1Sec:AddToggle({ Title = "Auto Predict", Default = VD.VeilAutoPredict, Callback = function(v) VD.VeilAutoPredict = v end })
v1Sec:AddSlider({ Title = "FOV Size", Min = 50, Max = 500, Default = VD.VeilFOV, Increment = 10, Callback = function(v) VD.VeilFOV = v end })
v1Sec:AddSlider({ Title = "Max Distance", Min = 50, Max = 280, Default = VD.VeilMaxDist, Increment = 10, Callback = function(v) VD.VeilMaxDist = v end })
v1Sec:AddSlider({ Title = "Spear Speed", Min = 50, Max = 400, Default = VD.VeilSpearSpeed, Increment = 5, Callback = function(v) VD.VeilSpearSpeed = v end })
v1Sec:AddSlider({ Title = "Spear Gravity", Min = 10, Max = 300, Default = VD.VeilGravity, Increment = 1, Callback = function(v) VD.VeilGravity = v end })
v1Sec:AddSlider({ Title = "Lead Multiplier", Min = 0.1, Max = 5, Default = VD.VeilLeadMultiplier, Increment = 0.1, Callback = function(v) VD.VeilLeadMultiplier = v end })

local v2Sec = Sec(KillerTab, "Silent Spear Veil V2")
v2Sec:AddToggle({ Title = "Silent Veil V1", Default = false, Keybind = true, Callback = function(v)
    if W.VeilV2_API then W.VeilV2_API.AimConfig.Aim_SilentVeil = v end
end })
v2Sec:AddToggle({ Title = "Silent Veil V2", Default = false, Keybind = true, Callback = function(v)
    if W.VeilV2_API then W.VeilV2_API.AimConfig.Aim_SilentVeilV2 = v end
end })
v2Sec:AddToggle({ Title = "Auto Predict", Default = false, Callback = function(v)
    if W.VeilV2_API then W.VeilV2_API.Config.SpearSmart_enable = v end
end })
v2Sec:AddSlider({ Title = "Lead Multiplier", Min = 0.5, Max = 5, Default = 1.4,
    Callback = function(v) if W.VeilV2_API then W.VeilV2_API.AimConfig.Veil_LeadMultiplier = v end end })
v2Sec:AddSlider({ Title = "Spear Speed", Min = 50, Max = 200, Default = 165,
    Callback = function(v) if W.VeilV2_API then W.VeilV2_API.AimConfig.SPEAR_Speed = v end end })
v2Sec:AddSlider({ Title = "Spear Gravity", Min = 0, Max = 200, Default = 103,
    Callback = function(v) if W.VeilV2_API then W.VeilV2_API.AimConfig.SPEAR_Gravity = v end end })
v2Sec:AddToggle({ Title = "ESP Tracker Target", Default = false, Callback = function(v)
    if W.VeilV2_API and W.VeilV2_API.setTracker then W.VeilV2_API.setTracker(v) end
end })
v2Sec:AddToggle({ Title = "Show Veil FOV", Default = true, Callback = function(v)
    if W.VeilV2_API then W.VeilV2_API.AimConfig.Veil_ShowFOV = v end
end })
v2Sec:AddSlider({ Title = "Veil FOV Radius", Min = 50, Max = 500, Default = 150,
    Callback = function(v) if W.VeilV2_API then W.VeilV2_API.AimConfig.Veil_FOV = v end end })

local v3Sec = Sec(KillerTab, "Silent Spear Veil V3")
v3Sec:AddButton({ Title = "Open Spear V3 GUI", Callback = function()
    ForceNotify("Veil V3", "GUI standalone - spawn otomatis kalau Part 12 di-load", 3)
end })

local bypSec = Sec(KillerTab, "Bypass No Cooldown")
bypSec:AddToggle({ Title = "Hidden - Leap Bypass", Default = false, Callback = function(v) W.BYPASS_SetHiddenLeap(v) end })
bypSec:AddToggle({ Title = "Myers - Infinite Grab", Default = false, Callback = function(v) W.setMyersGrab(v) end })
bypSec:AddToggle({ Title = "Slasher - Infinite LakeMist", Default = false, Callback = function(v) W.MAWWW_SetLakeMist(v) end })
bypSec:AddToggle({ Title = "Slasher - Infinite Pursuit", Default = false, Callback = function(v) W.MAWWW_SetPursuit(v) end })
bypSec:AddToggle({ Title = "Abyss - Bypass Cooldown", Default = false, Callback = function(v) W.MAWWW_SetAbyssBypass(v) end })
bypSec:AddToggle({ Title = "Jeff - Infinite Frenzy", Default = false, Callback = function(v) W.MAWWW_SetJeffFrenzy(v) end })
bypSec:AddButton({ Title = "Auto-Fix Boolean Math", Callback = function()
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
    ForceNotify("Bypass", "Boolean failsafe applied", 2)
end })

local ucSec = Sec(KillerTab, "Unlock Skill While Carrying")
ucSec:AddToggle({ Title = "Unlock Skill While Carrying", Default = false, Callback = function(v)
    if W.UnlockCarry_SetEnabled then W.UnlockCarry_SetEnabled(v) end
end })

local saSec = Sec(KillerTab, "Spear Aimbot")
saSec:AddToggle({ Title = "Enable Spear Aimbot", Default = VD.SPEAR_Aimbot, Callback = function(v)
    if W.SpearAimbot_SetEnabled then W.SpearAimbot_SetEnabled(v) end
end })
saSec:AddSlider({ Title = "Spear Gravity", Min = 10, Max = 200, Default = VD.SPEAR_Gravity, Increment = 1,
    Callback = function(v) W.SpearAimbot_SetGravity(v) end })
saSec:AddSlider({ Title = "Spear Speed", Min = 50, Max = 300, Default = VD.SPEAR_Speed, Increment = 5,
    Callback = function(v) W.SpearAimbot_SetSpeed(v) end })

local kabiSec = Sec(KillerTab, "Killer Abilities")
kabiSec:AddToggle({ Title = "Auto Stalk (Myers)", Default = VD.KA_AutoStalk, Callback = function(v) W.KA_SetAutoStalk(v) end })
kabiSec:AddSlider({ Title = "Auto Stalk Range", Min = 20, Max = 500, Default = VD.KA_AutoStalkRange, Increment = 10, Suffix = " studs",
    Callback = function(v) W.KillerAbilities.AutoStalkRange = v; VD.KA_AutoStalkRange = v end })
kabiSec:AddToggle({ Title = "Auto Kill All", Default = VD.KA_AutoKillAll, Callback = function(v) W.KA_SetAutoKillAll(v) end })
kabiSec:AddToggle({ Title = "Drop All Pallet", Default = VD.KA_DropAllPallet, Callback = function(v) W.KA_SetDropAllPallet(v) end })
kabiSec:AddToggle({ Title = "Block All Vault", Default = VD.KA_BlockAllVault, Callback = function(v) W.KA_SetBlockAllVault(v) end })
kabiSec:AddButton({ Title = "Instant Auto Kill (1x)", Callback = function()
    local saved = W.KillerAbilities.AutoKillAll
    W.KillerAbilities.AutoKillAll = true
    task.spawn(function() task.wait(0.3); W.KillerAbilities.AutoKillAll = saved end)
end })
kabiSec:AddButton({ Title = "Instant Drop All Pallet (1x)", Callback = function()
    pcall(W.KA_DropAllPallets)
end })
kabiSec:AddButton({ Title = "Instant Block All Vault (1x)", Callback = function()
    pcall(W.KA_BlockAllVaults)
end })
kabiSec:AddButton({ Title = "Unblock All Vault (1x)", Callback = function()
    pcall(W.KA_UnblockAllVaults)
end })
kabiSec:AddToggle({ Title = "Auto Hook", Default = false, Keybind = true, Callback = function(v)
    if W.KA_SetAutoHook then W.KA_SetAutoHook(v) end
end })

local flSec = Sec(KillerTab, "Silent Flask (The Cure)")
flSec:AddToggle({ Title = "Enable Silent Flask", Default = VD.FLASK_SilentAim, Callback = function(v) W.Flask_SetEnabled(v) end })
flSec:AddToggle({ Title = "Show Beam", Default = VD.FLASK_ShowBeam, Callback = function(v) VD.FLASK_ShowBeam = v and true or false end })
flSec:AddToggle({ Title = "Show Landing Marker", Default = VD.FLASK_ShowLanding, Callback = function(v) VD.FLASK_ShowLanding = v and true or false end })
flSec:AddToggle({ Title = "Enable Prediction", Default = VD.FLASK_Predict, Callback = function(v) VD.FLASK_Predict = v and true or false end })
flSec:AddColorPicker({ Title = "Beam Color", Default = VD.FLASK_BeamColor, Save = false, Callback = function(c) W.Flask_SetBeamColor(c) end })
flSec:AddColorPicker({ Title = "Accent Color", Default = VD.FLASK_AccentColor, Save = false, Callback = function(c) W.Flask_SetAccentColor(c) end })
flSec:AddSlider({ Title = "Flask Speed", Min = 30, Max = 200, Default = VD.FLASK_Speed, Increment = 5, Callback = function(v) W.Flask_SetSpeed(v) end })
flSec:AddSlider({ Title = "Flask Gravity", Min = 50, Max = 400, Default = VD.FLASK_Gravity, Increment = 5, Callback = function(v) W.Flask_SetGravity(v) end })
flSec:AddSlider({ Title = "Lead Multiplier", Min = 0, Max = 3, Default = VD.FLASK_LeadMult, Increment = 0.1, Callback = function(v) W.Flask_SetLead(v) end })
flSec:AddSlider({ Title = "Max Range", Min = 50, Max = 500, Default = VD.FLASK_Range, Increment = 10, Suffix = " studs", Callback = function(v) W.Flask_SetRange(v) end })

local dlSec = Sec(KillerTab, "Dash Lock")
dlSec:AddToggle({ Title = "Enable Dash Lock", Default = VD.DashLockEnabled, Callback = function(v) W.DashLock_SetEnabled(v) end })
dlSec:AddSlider({ Title = "Lock Duration", Min = 0.5, Max = 5, Default = VD.DashLockDuration, Increment = 0.1, Suffix = "s",
    Callback = function(v) VD.DashLockDuration = v end })
dlSec:AddSlider({ Title = "Camera Smoothness", Min = 0.05, Max = 1, Default = VD.DashLockSmoothness, Increment = 0.05,
    Callback = function(v) VD.DashLockSmoothness = v end })
dlSec:AddToggle({ Title = "Freeze Character During Lock", Default = VD.FreezeDuringDashLock, Callback = function(v)
    VD.FreezeDuringDashLock = v and true or false
    if not v then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.WalkSpeed == 0 then hum.WalkSpeed = 16 end
    end
end })

print("[FAZZHUB Part 14] UI Visuals + UI Killer loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 15: UI Misc + UI Config + UI Bombax
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local UserInputService  = game:GetService("UserInputService")
local HttpService       = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 15] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local ForceNotify = W.VD_Notify or function() end

local MiscTab   = FAZZTabs.Misc
local ConfigTab = FAZZTabs.Config
local BombaxTab = FAZZTabs.Bombax

local function Sec(tab, name) return tab:AddSection(name) end

-- ═══════════════════════════════════════════════
-- MISC TAB
-- ═══════════════════════════════════════════════

local setSec = Sec(MiscTab, "Settings")
setSec:AddToggle({ Title = "Enable Notifications", Default = true, Callback = function(v)
    W.NotifyEnabled = v
end })

local stunSec = Sec(MiscTab, "Stun Indicator")
stunSec:AddToggle({ Title = "Enable Stun Indicator", Default = false, Callback = function(v)
    if W.SInd_SetEnabled then W.SInd_SetEnabled(v) end
end })
stunSec:AddDropdown({ Title = "Stun Sound",
    Options = { "Default", "Clash Royale", "Blash", "Coin", "Kururin Kuru", "Spongebob", "Fahhhh", "Cave", "Aughhh", "Samsung", "iPhone", "Siren" },
    Default = "Default", Callback = function(v)
        local val = type(v) == "table" and v[1] or v
        if W.StunIndicator then W.StunIndicator.SelectedSound = val end
    end })
stunSec:AddToggle({ Title = "Stun Sound Alert", Default = true, Callback = function(v)
    if W.StunIndicator then W.StunIndicator.SoundEnabled = v end
end })
stunSec:AddSlider({ Title = "Detect Range", Min = 50, Max = 2000, Default = 500, Increment = 25, Suffix = " studs",
    Callback = function(v) if W.StunIndicator then W.StunIndicator.Range = v end end })
stunSec:AddSlider({ Title = "Sound Volume", Min = 0, Max = 5, Default = 1.5, Increment = 0.1,
    Callback = function(v) if W.StunIndicator then W.StunIndicator.SoundVolume = v end end })

local invisSec = Sec(MiscTab, "Invisibility")
invisSec:AddToggle({ Title = "Enable Invisibility", Default = false, Callback = function(v)
    if W.Invisible_SetState then W.Invisible_SetState(v, false) end
    if getgenv().FAZZ_InvisBtn_UpdateVisual then getgenv().FAZZ_InvisBtn_UpdateVisual() end
end })
invisSec:AddToggle({ Title = "Show Invisibility Floating Button", Default = false, Callback = function(v)
    if getgenv().FAZZ_InvisBtn_SetEnabled then getgenv().FAZZ_InvisBtn_SetEnabled(v) end
end })
invisSec:AddKeybind({ Title = "Toggle Hotkey", Default = Enum.KeyCode.G, Callback = function(kc)
    if W.Invisible_SetHotkey then W.Invisible_SetHotkey(kc) end
end })

local camSec = Sec(MiscTab, "Camera DBD")
camSec:AddToggle({ Title = "DBD Camera (Smooth Follow)", Default = false, Callback = function(v)
    if W.CamDBD_SetSmooth then W.CamDBD_SetSmooth(v) end
end })
camSec:AddSlider({ Title = "Camera Smoothness", Min = 1, Max = 30, Default = 4, Increment = 1,
    Callback = function(v) if W.CamDBD_SetSmoothSpeed then W.CamDBD_SetSmoothSpeed(v) end end })
camSec:AddToggle({ Title = "POV Lock", Default = false, Callback = function(v)
    if W.CamDBD_SetPOVLock then W.CamDBD_SetPOVLock(v) end
end })
camSec:AddSlider({ Title = "POV Value", Min = 60, Max = 120, Default = 85, Increment = 1, Suffix = "°",
    Callback = function(v) if W.CamDBD_SetTargetPOV then W.CamDBD_SetTargetPOV(v) end end })
camSec:AddSlider({ Title = "POV Smoothness", Min = 3, Max = 20, Default = 9, Increment = 1,
    Callback = function(v) if W.CamDBD_SetPOVSmooth then W.CamDBD_SetPOVSmooth(v) end end })

local puSec = Sec(MiscTab, "Player Utility")
puSec:AddToggle({ Title = "Speed Hack", Default = false, Callback = function(v)
    if W.PU then W.PU.SpeedEnabled = v and true or false
        if not v then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end
end })
puSec:AddSlider({ Title = "Speed Value", Min = 16, Max = 200, Default = 16, Increment = 1, Callback = function(v)
    if W.PU then W.PU.SpeedValue = v end
end })
puSec:AddToggle({ Title = "Skip End Screen", Default = false, Callback = function(v)
    if W.PU then W.PU.SkipEndScreen = v and true or false end
end })
puSec:AddToggle({ Title = "Shift Lock", Default = false, Callback = function(v)
    if W.PU then W.PU.ShiftLock = v and true or false end
end })
puSec:AddToggle({ Title = "Hide Survivor Icon", Default = false, Callback = function(v)
    if W.PU then W.PU.HideSurvivorIcon = v and true or false end
end })
puSec:AddToggle({ Title = "Show Ping & FPS", Default = false, Callback = function(v)
    if W.PU then W.PU.ShowPingFPS = v and true or false end
end })
puSec:AddToggle({ Title = "Hide Name", Default = false, Callback = function(v)
    if W.PU_SetHideName then W.PU_SetHideName(v) end
end })
puSec:AddToggle({ Title = "Unlimited Zoom", Default = false, Callback = function(v)
    if W.PU then W.PU.UnlimitedZoom = v and true or false end
end })
puSec:AddToggle({ Title = "Noclip", Default = false, Callback = function(v)
    if W.PU then W.PU.Noclip = v and true or false end
    if not v and W.PU_RestoreNoclip then W.PU_RestoreNoclip() end
end })

local sbSec = Sec(MiscTab, "Speed Boost")
sbSec:AddToggle({ Title = "Enable Speed Boost", Default = false, Keybind = true, Callback = function(v)
    if W.SpeedBoost_SetEnabled then W.SpeedBoost_SetEnabled(v) end
end })
sbSec:AddSlider({ Title = "Speed Value", Min = 16, Max = 100, Default = 30, Increment = 1,
    Callback = function(v) if W.SpeedBoost_SetValue then W.SpeedBoost_SetValue(v) end end })

local curSec = Sec(MiscTab, "Cursor Feature")
curSec:AddToggle({ Title = "Enable Cursor Unlock", Default = false, Keybind = true, Callback = function(v)
    if W.Cursor_SetEnabled then W.Cursor_SetEnabled(v) end
end })
curSec:AddButton({ Title = "Toggle Cursor Now", Callback = function()
    if W.Cursor_SetEnabled then W.Cursor_SetEnabled(not VD.CursorEnabled) end
end })

local jkSec = Sec(MiscTab, "Jerk Off")
jkSec:AddToggle({ Title = "Enable Jerk Off Tool", Default = false, Keybind = true, Callback = function(v)
    if W.JerkOff_SetEnabled then W.JerkOff_SetEnabled(v) end
end })

local emSec = Sec(MiscTab, "Emote")
emSec:AddToggle({ Title = "Enable Emote", Default = false, Callback = function(v)
    if W.EmoteSystem_SetEnabled then W.EmoteSystem_SetEnabled(v) end
end })
emSec:AddDropdown({ Title = "Select Emote", Options = W.EmoteSystem and W.EmoteSystem.Options or {}, Default = "Friday Night", Multi = false,
    Callback = function(v)
        local val = type(v) == "table" and v[1] or v
        if W.EmoteSystem_SelectEmote then W.EmoteSystem_SelectEmote(val or "Friday Night") end
    end })
emSec:AddButton({ Title = "Stop Emote", Callback = function()
    if W.EmoteSystem_Stop then W.EmoteSystem_Stop() end
    if W.EmoteSystem then W.EmoteSystem.Enabled = false end
end })
emSec:AddButton({ Title = "Replay Current Emote", Callback = function()
    if W.EmoteSystem_Play then W.EmoteSystem_Play() end
end })

local faSec = Sec(MiscTab, "Fake Avatar")
faSec:AddDropdown({ Title = "Fake Avatar (Username)",
    Options = {
        "Self Avatar","xn1vyu","nurblomst2013","kino_yk","nvratee","Sakaryle",
        "Grouchy1400","Kill_xsu","Jahxure","IIIlIIllIlIIIlII","LordTherion","xKami3D","116vv",
        "WoozyNate","Nicholas","yvlyf","traevp","J0LLY","LucashDev","CEOofIsaac","Stealthy",
        "Wildes","Talon","Relukt","Sammy","Diesel","S4ans03","Aura","iJava",
        "White Guy","Purple King","Kachaaaa Gay","Mpruyyy"
    },
    Default = "Self Avatar",
    Callback = function(option)
        if W.FakeAvatar_SelectByUsername then W.FakeAvatar_SelectByUsername(option) end
    end })
faSec:AddToggle({ Title = "Enable Fake Avatar", Default = false, Keybind = true, Callback = function(state)
    if W.FakeAvatar_SetEnabled then W.FakeAvatar_SetEnabled(state) end
end })
local faUserInput = ""
faSec:AddInput({ Title = "Fake Avatar Via Username", Placeholder = "username (tanpa @)",
    Callback = function(input) faUserInput = (input or ""):gsub("^@", "") end })
faSec:AddButton({ Title = "Apply From Username", Callback = function()
    if faUserInput == "" then ForceNotify("Fake Avatar", "Masukkan username dulu!", 2); return end
    if W.FakeAvatar_ApplyFromUsername then W.FakeAvatar_ApplyFromUsername(faUserInput) end
end })

local korSec = Sec(MiscTab, "Fake Korless")
korSec:AddToggle({ Title = "Korless Morph", Default = false, Callback = function(v)
    if W.Korless_SetEnabled then W.Korless_SetEnabled(v) end
end })

local hdSec = Sec(MiscTab, "Header Title")
local hdText = "FAZZHUB"
hdSec:AddInput({ Title = "Header Text", Default = "FAZZHUB", Placeholder = "Nama header lu...",
    Callback = function(input)
        hdText = input or "FAZZHUB"
        if W.Header_UpdateText then W.Header_UpdateText(hdText) end
    end })
hdSec:AddToggle({ Title = "Enable Header Title", Default = false, Callback = function(v)
    if W.Header_SetEnabled then W.Header_SetEnabled(v, hdText) end
end })
hdSec:AddColorPicker({ Title = "Header Color", Default = Color3.fromRGB(255, 255, 255), Save = false, Callback = function(c)
    if W.Header_SetColor then W.Header_SetColor(c) end
end })

local spSec = Sec(MiscTab, "Spectator Counter")
spSec:AddToggle({ Title = "Enable Spectator Counter", Default = false, Callback = function(v)
    if W.SpecCounter_SetEnabled then W.SpecCounter_SetEnabled(v) end
end })

-- ═══════════════════════════════════════════════
-- CONFIG TAB
-- ═══════════════════════════════════════════════

local cfgSec = Sec(ConfigTab, "Config Manager")
local currentName = ""
local selectedConfig = nil
local configList = nil

local function ConfigFolderPath() return "FAZZHUB/Config" end
local function EnsureConfigFolder()
    if isfolder and makefolder then
        if not isfolder("FAZZHUB") then makefolder("FAZZHUB") end
        if not isfolder(ConfigFolderPath()) then makefolder(ConfigFolderPath()) end
    end
end
EnsureConfigFolder()

local function RefreshConfigList()
    local list = {}
    if listfiles then
        EnsureConfigFolder()
        local ok2, files = pcall(listfiles, ConfigFolderPath())
        if ok2 and files then
            for _, f in ipairs(files) do
                local n = string.match(f, "([^/\\]+)%.json$")
                if n and n ~= "_autoload" then table.insert(list, n) end
            end
        end
    end
    if configList and configList.SetValues then configList:SetValues(list, selectedConfig, true) end
    return list
end

cfgSec:AddInput({ Title = "Config Name", Placeholder = "MyConfig", Save = false, Callback = function(text) currentName = text end })
configList = cfgSec:AddDropdown({ Title = "Saved Configs", Multi = false, Options = {}, Save = false, Callback = function(v) selectedConfig = v end })
RefreshConfigList()

cfgSec:AddButton({ Title = "Save", SubTitle = "Load",
    Callback = function()
        if currentName == nil or currentName == "" then ForceNotify("Config", "Isi nama config dulu!", 2); return end
        if not writefile or not HttpService then ForceNotify("Config", "Executor gak support", 2); return end
        EnsureConfigFolder()
        local snapshot = W.GetConfigSnapshot and W.GetConfigSnapshot() or (getgenv().ConfigData or {})
        local okEnc, encoded = pcall(function() return HttpService:JSONEncode(snapshot) end)
        if not okEnc or not encoded then ForceNotify("Config", "Gagal encode", 2); return end
        local okW = pcall(writefile, ConfigFolderPath() .. "/" .. currentName .. ".json", encoded)
        if not okW then ForceNotify("Config", "Gagal save", 2); return end
        ForceNotify("Config", "Saved: " .. currentName, 2)
        RefreshConfigList()
    end,
    SubCallback = function()
        if not selectedConfig or selectedConfig == "" then ForceNotify("Config", "Pilih config dulu!", 2); return end
        if not readfile or not isfile then ForceNotify("Config", "Executor gak support", 2); return end
        local path = ConfigFolderPath() .. "/" .. selectedConfig .. ".json"
        if not isfile(path) then ForceNotify("Config", "File gak ketemu", 2); return end
        local okR, raw = pcall(readfile, path)
        if not okR or not raw then ForceNotify("Config", "Gagal baca file", 2); return end
        local okD, dec = pcall(function() return HttpService:JSONDecode(raw) end)
        if not okD or type(dec) ~= "table" then ForceNotify("Config", "File corrupt", 2); return end
        if W.LoadConfigSnapshot then W.LoadConfigSnapshot(dec) end
        ForceNotify("Config", "Loaded: " .. selectedConfig, 2)
    end
})

cfgSec:AddButton({ Title = "Delete", SubTitle = "Refresh List",
    Callback = function()
        if not selectedConfig or selectedConfig == "" then ForceNotify("Config", "Pilih config dulu!", 2); return end
        local path = ConfigFolderPath() .. "/" .. selectedConfig .. ".json"
        if isfile and delfile and isfile(path) then
            pcall(delfile, path)
            ForceNotify("Config", "Deleted: " .. selectedConfig, 2)
            selectedConfig = nil; RefreshConfigList()
        end
    end,
    SubCallback = function() RefreshConfigList() end
})

cfgSec:AddButton({ Title = "Export to Clipboard", Callback = function()
    if not setclipboard then ForceNotify("Config", "Clipboard gak support", 2); return end
    local snapshot = W.GetConfigSnapshot and W.GetConfigSnapshot() or (getgenv().ConfigData or {})
    local okE, encoded = pcall(function() return HttpService:JSONEncode(snapshot) end)
    if okE and encoded then
        setclipboard(encoded)
        ForceNotify("Config", "Copied to clipboard!", 2)
    end
end })

-- ═══════════════════════════════════════════════
-- BOMBAX TAB
-- ═══════════════════════════════════════════════

local bombaxSec = Sec(BombaxTab, "Bombax Mini Player")
bombaxSec:AddToggle({ Title = "Enable Bombax Mini Player", Default = false, Callback = function(v)
    if v then
        if W.Bombax_BuildUI then W.Bombax_BuildUI() end
    else
        if W.Bombax_Destroy then W.Bombax_Destroy() end
    end
end })
bombaxSec:AddSlider({ Title = "Volume", Min = 0, Max = 10, Default = 2, Increment = 1, Callback = function(v)
    if W.Bombax_SetVolume then W.Bombax_SetVolume(v) end
end })
bombaxSec:AddButton({ Title = "Play / Pause", Callback = function()
    if W.Bombax_TogglePlay then W.Bombax_TogglePlay() end
end })
bombaxSec:AddButton({ Title = "Next Track", Callback = function()
    if W.Bombax_Next then W.Bombax_Next() end
end })
bombaxSec:AddButton({ Title = "Prev Track", Callback = function()
    if W.Bombax_Prev then W.Bombax_Prev() end
end })

print("[FAZZHUB Part 15] UI Misc + Config + Bombax loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 16: Logic Visual (Full ESP + Graphics + LockPOV)
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local Workspace         = game:GetService("Workspace")
local CoreGui           = game:GetService("CoreGui")
local TweenService      = game:GetService("TweenService")
local Lighting          = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 16] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local TeamIs = W.TeamIs

-- ▸ FULL ESP SYSTEM
W.FullESP = W.FullESP or {
    Survivor = false, Killer = false,
    Generator = false, Pallet = false, Window = false, SCP = false,
    Distance = 500,
}
W.FullESPStatus = W.FullESPStatus or {
    Enabled = false,
    ShowName = true, ShowDistance = true,
    Radius = 500,
}
W.FullESPColors = W.FullESPColors or {
    Survivor  = Color3.fromRGB(0, 190, 255), Killer    = Color3.fromRGB(255, 0, 0),
    Generator = Color3.fromRGB(255, 255, 0), Window    = Color3.fromRGB(255, 255, 255),
    Pallet    = Color3.fromRGB(255, 165, 0), SCP       = Color3.fromRGB(0, 255, 0),
}
local FESP  = W.FullESP
local FESPS = W.FullESPStatus
local FESPC = W.FullESPColors

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
        if obj.Name == "Generator" then CachedGen[obj] = true
        elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then CachedPallet[obj] = true end
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

        local bb = StatusESP[char]
        if not bb or not bb.Parent then
            bb = Instance.new("BillboardGui")
            bb.Name = "FAZZStatusESP"
            bb.AlwaysOnTop = true
            bb.LightInfluence = 0
            bb.Adornee = head
            bb.StudsOffset = Vector3.new(0, 2.5, 0)
            bb.Size = UDim2.fromOffset(200, 40)
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
            pill.Size = UDim2.fromOffset(80, 22)
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
            local distLbl = Instance.new("TextLabel")
            distLbl.Name = "DistLbl"
            distLbl.BackgroundTransparency = 1
            distLbl.Size = UDim2.fromOffset(40, 14)
            distLbl.Font = Enum.Font.GothamBold
            distLbl.TextSize = 11
            distLbl.TextColor3 = Color3.fromRGB(220, 220, 230)
            distLbl.Text = "0m"
            distLbl.LayoutOrder = 1
            distLbl.Parent = pill
            StatusESP[char] = bb
        end

        local nameLbl = bb:FindFirstChild("NameLbl")
        local pill = bb:FindFirstChild("Pill")
        if not pill then return end
        local pillStroke = pill:FindFirstChild("PillStroke")
        local distLbl = pill:FindFirstChild("DistLbl")
        local distScale = bb:FindFirstChild("DistScale")

        if pillStroke then
            pillStroke.Color = accentColor
            pillStroke.Transparency = isDown and 0.2 or 0.5
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

        local totalW = 14
        if FESPS.ShowDistance then totalW = totalW + 40 end
        if totalW < 50 then totalW = 50 end
        if totalW > 200 then totalW = 200 end
        pill.Size = UDim2.fromOffset(totalW, 22)

        local showPill = FESPS.ShowDistance
        pill.Visible = showPill

        local h = 16 + (showPill and 24 or 0)
        bb.Size = UDim2.fromOffset(200, h)

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
        elseif obj:IsA("BasePart") then pos = obj.Position end
        if not pos then return end
        local dist = (pos - root.Position).Magnitude
        if obj.Name == "Pallet" or obj.Name == "Palletwrong" then
            if FESP.Pallet and dist <= FESP.Distance then CreateESP(obj, FESPC.Pallet)
            else RemoveESP(obj) end
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
                elseif obj:IsA("BasePart") then pos = obj.Position end
                if pos then
                    local dist = (pos - root.Position).Magnitude
                    if dist <= FESP.Distance then CreateESP(obj, FESPC.SCP)
                    else RemoveESP(obj) end
                end
            end
        end
    end

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
                            else RemoveESP(char) end
                        else RemoveESP(char) end
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
    end)
end

-- ▸ GRAPHICS SYSTEM
do
    local WorkspaceSvc = Workspace
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
        FOV = WorkspaceSvc.CurrentCamera and WorkspaceSvc.CurrentCamera.FieldOfView or 70,
    }
    local LastState = { Fullbright = nil, NoShadow = nil, Ambient = nil, Brightness = nil, ClockTime = nil }
    local LastOptimize = { LowGraphics = nil, CleanSky = nil }
    local DisabledEffects = {}
    local ScreenEffectTypes = { "ColorCorrectionEffect", "DepthOfFieldEffect", "BlurEffect", "SunRaysEffect", "BloomEffect" }

    local function Graphics_Apply(force)
        if force or LastState.Fullbright ~= G.Fullbright then
            LastState.Fullbright = G.Fullbright
            if G.Fullbright then
                Lighting.Brightness = 2; Lighting.ClockTime = 14
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            else
                Lighting.Brightness = original.Brightness
                Lighting.ClockTime = original.ClockTime
                Lighting.Ambient = original.Ambient
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
                Lighting.ClockTime = G.ClockTime; Lighting.Brightness = G.Brightness
            elseif not G.Fullbright then
                Lighting.Brightness = original.Brightness
                Lighting.ClockTime = original.ClockTime
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
            LocalPlayer.CameraMaxZoomDistance = G.MaxZoomDistance
            LocalPlayer.CameraMinZoomDistance = 0
        else
            LocalPlayer.CameraMaxZoomDistance = 128
            LocalPlayer.CameraMinZoomDistance = 0.5
        end
    end

    local function Graphics_ApplyFOV()
        local cam = WorkspaceSvc.CurrentCamera
        if not cam then return end
        if G.FOVEnabled then cam.FieldOfView = G.FOV
        else cam.FieldOfView = original.FOV end
    end

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
            pcall(function() Potato_Set(obj, "RenderFidelity", Enum.RenderFidelity.Performance) end)
        end
        if obj:IsA("Texture") or obj:IsA("Decal") then Potato_Set(obj, "Transparency", 1) end
        if obj:IsA("SurfaceAppearance") then
            pcall(function()
                Potato_Set(obj, "ColorMap", ""); Potato_Set(obj, "MetalnessMap", "")
                Potato_Set(obj, "NormalMap", ""); Potato_Set(obj, "RoughnessMap", "")
            end)
        end
        if obj:IsA("ParticleEmitter") then Potato_Set(obj, "Enabled", false) end
        if obj:IsA("Trail") then Potato_Set(obj, "Enabled", false) end
        if obj:IsA("Beam") then Potato_Set(obj, "Enabled", false) end
        if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then Potato_Set(obj, "Enabled", false) end
        if obj:IsA("Clouds") then
            Potato_Set(obj, "Cover", 0); Potato_Set(obj, "Density", 0)
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
        local Terrain = WorkspaceSvc:FindFirstChildOfClass("Terrain")
        if not Terrain then return end
        Potato_Set(Terrain, "Decoration", false)
        Potato_Set(Terrain, "WaterWaveSize", 0)
        Potato_Set(Terrain, "WaterWaveSpeed", 0)
        Potato_Set(Terrain, "WaterReflectance", 0)
    end
    local function Potato_ProcessMap()
        if Potato_Busy then return end
        Potato_Busy = true
        local objects = WorkspaceSvc:GetDescendants()
        local total = #objects
        local index = 1
        while Potato_Enabled and index <= total do
            local finish = math.min(index + POTATO_BATCH_SIZE - 1, total)
            for i = index, finish do
                if not Potato_Enabled then break end
                Potato_Optimize(objects[i])
            end
            RunService.Heartbeat:Wait()
            if index % (POTATO_BATCH_SIZE * 5) == 1 then task.wait(POTATO_BATCH_DELAY / 10) end
            index = finish + 1
        end
        Potato_Busy = false
    end
    local function Potato_StartNewObjectHandler()
        if Potato_Connections.NewObject then return end
        Potato_Connections.NewObject = WorkspaceSvc.DescendantAdded:Connect(function(obj)
            if not Potato_Enabled then return end
            task.defer(function() if Potato_Enabled then Potato_Optimize(obj) end end)
        end)
    end
    local function Potato_Enable()
        if Potato_Enabled then return end
        Potato_Enabled = true
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
        Potato_LowLighting(); Potato_LowTerrain(); Potato_StartNewObjectHandler()
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
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
    end

    RunService.RenderStepped:Connect(function()
        if G.FOVEnabled then
            local cam = WorkspaceSvc.CurrentCamera
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

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        Graphics_Apply(true); Graphics_ApplyOptimization(true)
        Graphics_ApplyNoScreenEffects(); Graphics_ApplyZoom(); Graphics_ApplyFOV()
    end)
end

-- ▸ LOCK POV
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

print("[FAZZHUB Part 16] Logic Visual (Full ESP + Graphics + LockPOV) loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 17: Logic Misc + Bombax Module
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local CoreGui           = game:GetService("CoreGui")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local SoundService      = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 17] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end
local ForceNotify = W.VD_Notify or function() end
local TeamIs = W.TeamIs

-- ▸ STUN INDICATOR
W.StunSounds = W.StunSounds or {
    ["Default"]="18843924331",["Clash Royale"]="114072050006157",["Blash"]="89068385567682",
    ["Coin"]="75510526696824",["Kururin Kuru"]="119896940405402",["Spongebob"]="6835794541",
    ["Fahhhh"]="123562480982353",["Cave"]="3173566193",["Aughhh"]="9095205664",
    ["Samsung"]="6879335951",["iPhone"]="4203251375",["Siren"]="130677853589923",
}
W.StunIndicator = W.StunIndicator or {
    Enabled = false, Cache = {}, HeartbeatConn = nil, Range = 500,
    Icon = "rbxassetid://81633822407558",
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
    local ci = char:FindFirstChild("CheckInterractable")
    if ci and ci:GetAttribute("isStunned") == true then return true end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local sv = hum:FindFirstChild("StunValue")
        if sv and sv.Value > 0 then return true end
    end
    return false
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
        task.delay(5, function() pcall(function() if snd and snd.Parent then snd:Destroy() end end) end)
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
    mainStroke.Color = Color3.fromRGB(255, 255, 255)
    mainStroke.Thickness = 1.3
    mainStroke.Transparency = 0.15
    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, -12, 1, 0)
    title.Position = UDim2.new(0, 6, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBlack
    title.Text = "STUNNED"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 16
    title.TextStrokeTransparency = 0.5
    SInd.Cache[char] = { Gui = bbg, Main = main }
    return SInd.Cache[char]
end
local function SInd_Remove(char)
    local data = SInd.Cache[char]
    if data then
        pcall(function() if data.Gui then data.Gui:Destroy() end end)
        SInd.Cache[char] = nil
    end
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
                            if wasStunned then SInd_Remove(char) end
                        end
                    end
                end
            end
        end)
    else
        if SInd.HeartbeatConn then SInd.HeartbeatConn:Disconnect(); SInd.HeartbeatConn = nil end
        for char, _ in pairs(SInd.Cache) do SInd_Remove(char) end
        SInd.Cache = {}
    end
end

-- ▸ INVISIBILITY
do
    local MV = getgenv().FAZZInvis
    if not MV then
        MV = { Enabled = false, Loading = false, Ready = false, API = nil, _lastToggle = 0 }
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
                        if part.Name ~= "Hurtbox" and part.Name ~= "HumanoidRootPart" and part.Name ~= "HRP_Clone" then
                            part.Transparency = 0
                            if part:IsA("BasePart") then part.LocalTransparencyModifier = 0 end
                        end
                    end
                end
            end
        end)
    end
    local function Invis_LoadAPI()
        if _G.MengHub and _G.MengHub.Invisible and Invis_ValidateAPI(_G.MengHub.Invisible) then
            MV.API = _G.MengHub.Invisible
            MV.Ready = true
            return true
        end
        MV.Loading = true; MV.Ready = false
        for attempt = 1, 3 do
            local ok = pcall(function() loadstring(game:HttpGet(INVIS_URL))() end)
            task.wait(0.5)
            if ok and _G.MengHub and _G.MengHub.Invisible and Invis_ValidateAPI(_G.MengHub.Invisible) then
                MV.API = _G.MengHub.Invisible
                MV.Ready = true; MV.Loading = false
                return true
            end
        end
        MV.Loading = false; MV.Ready = false
        return false
    end
    task.spawn(function() Invis_LoadAPI() end)
    function W.Invisible_SetState(state, fromButton)
        state = state and true or false
        local now = tick()
        if now - MV._lastToggle < 0.25 then return end
        if not MV.API then
            task.spawn(function()
                if Invis_LoadAPI() then W.Invisible_SetState(state, fromButton) end
            end)
            return
        end
        if MV.Enabled == state then
            if not state then Invis_Cleanup() end
            if getgenv().FAZZ_InvisBtn_UpdateVisual then pcall(getgenv().FAZZ_InvisBtn_UpdateVisual) end
            return
        end
        MV._lastToggle = now
        MV.Enabled = state
        VD.Invis_Enabled = state
        if state then
            pcall(function() MV.API.enable() end)
        else
            pcall(function() MV.API.disable() end)
            Invis_Cleanup()
        end
        if getgenv().FAZZ_InvisBtn_UpdateVisual then pcall(getgenv().FAZZ_InvisBtn_UpdateVisual) end
    end
    function W.Invisible_SetEnabled(v) W.Invisible_SetState(v and true or false, false) end
    function W.Invisible_SetHotkey(kc)
        if kc and typeof(kc) == "EnumItem" then VD.Invis_Hotkey = kc.Name
        elseif type(kc) == "string" then VD.Invis_Hotkey = kc end
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
        if MV.Enabled and MV.API then pcall(function() MV.API.enable() end) end
    end)
end

-- ▸ CAMERA DBD
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
            if Camera.CameraType ~= Enum.CameraType.Custom and Camera.CameraType ~= Enum.CameraType.Follow then
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
    LocalPlayer.CharacterAdded:Connect(function()
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
end

-- ▸ PLAYER UTILITY
do
    local PU = {
        SpeedEnabled = false, SpeedValue = 16,
        SkipEndScreen = false, ShiftLock = false,
        HideSurvivorIcon = false, ShowPingFPS = false, HideName = false,
        UnlimitedZoom = false, Noclip = false,
        _FPS = { frames = 0, last = tick(), value = 0, ping = 0 },
        _pingGui = nil, _shiftLockWasActive = false,
        _origCanCollide = {}, _Connections = {},
    }
    W.PU = PU

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
    end)
    RunService.RenderStepped:Connect(function()
        if not PU.UnlimitedZoom then return end
        if LocalPlayer.CameraMaxZoomDistance ~= math.huge then LocalPlayer.CameraMaxZoomDistance = math.huge end
        if LocalPlayer.CameraMinZoomDistance ~= 0 then LocalPlayer.CameraMinZoomDistance = 0 end
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
    W.PU_RestoreNoclip = function()
        for part, cc in pairs(PU._origCanCollide) do
            if part and part.Parent then pcall(function() part.CanCollide = cc end) end
        end
        PU._origCanCollide = {}
    end
    LocalPlayer.CharacterRemoving:Connect(function(char)
        if char == LocalPlayer.Character then PU._origCanCollide = {} end
    end)

    local function PU_GetPing()
        local ok, val = pcall(function()
            local stats = game:GetService("Stats")
            local net = stats and stats:FindFirstChild("Network")
            local sv = net and net:FindFirstChild("ServerStatsItem")
            local dp = sv and sv:FindFirstChild("Data Ping")
            if dp and dp.GetValue then return math.floor(dp:GetValue() + 0.5) end
        end)
        if ok and val then return val end
        return 0
    end
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
        frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        frame.BackgroundTransparency = 0.1
        frame.BorderSizePixel = 0
        frame.Parent = sg
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
        local lbl = Instance.new("TextLabel")
        lbl.Name = "Label"
        lbl.Size = UDim2.new(1, -12, 1, -8)
        lbl.Position = UDim2.new(0, 6, 0, 4)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 13
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Text = "PING: --ms\nFPS: --"
        lbl.Parent = frame
        PU._pingGui = sg
    end
    RunService.RenderStepped:Connect(function()
        if not PU.ShowPingFPS then return end
        PU._FPS.frames = PU._FPS.frames + 1
        local now = tick()
        if now - PU._FPS.last < 0.5 then return end
        PU._FPS.value = math.floor(PU._FPS.frames / (now - PU._FPS.last) + 0.5)
        PU._FPS.ping = PU_GetPing()
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
    end)

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
    W.PU_SetHideName = function(enabled)
        PU.HideName = enabled and true or false
        if PU._hideNameConn then
            pcall(function() PU._hideNameConn:Disconnect() end)
            PU._hideNameConn = nil
        end
        local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if not pg then return end
        for _, d in ipairs(pg:GetDescendants()) do PU_ProcessHideName(d) end
        if PU.HideName then
            PU._hideNameConn = pg.DescendantAdded:Connect(function(obj) task.defer(PU_ProcessHideName, obj) end)
        end
    end

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
                                il.Image = "rbxassetid://72845574620852"
                                il.ImageTransparency = 0
                            end
                            if tl and tl:IsA("TextLabel") then
                                tl.Text = "FAZZHUB"
                                tl.TextTransparency = 0
                            end
                        end
                    end
                end
            end
        end
    end
    RunService.Heartbeat:Connect(function()
        if PU.HideSurvivorIcon then PU_ApplyHideSurvivorIcon() end
    end)
end

-- ▸ SPEED BOOST
do
    local SpeedBoostConnection = nil
    local function ShouldDisableSpeedBoost()
        local char = LocalPlayer.Character
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
    W.SpeedBoost_SetValue = function(v) VD.SpeedBoostValue = tonumber(v) or 30 end
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.8)
        if VD.SpeedBoostEnabled then W.SpeedBoost_SetEnabled(true) end
    end)
end

-- ▸ CURSOR FEATURE
do
    local CursorThread = nil
    local savedOriginal = { MouseIconEnabled = nil, MouseBehavior = nil, AutoRotate = nil }
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
            if CursorThread then pcall(function() task.cancel(CursorThread) end); CursorThread = nil end
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
end

-- ▸ EMOTE SYSTEM
W.EmoteSystem = W.EmoteSystem or {
    Enabled = false, CurrentTrack = nil, CurrentSound = nil,
    SelectedEmote = "Friday Night",
    Options = { "Friday Night","WarCry","24 Hour Cinderella","Applause","Arm Swing","Backflip",
        "California Girls","Christmas Spirit","Floating Rest","Ghoul","Griddy","Kyoufuu","OnePlays","Vulnerable" },
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

-- ▸ JERK OFF TOOL
do
    W.JerkTool = W.JerkTool or { Enabled = false, ToolName = "Jerk Off" }
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

-- ▸ FAKE AVATAR (username-based)
do
    local FakeAvatarEnabled = false
    local SelectedFakeAva = LocalPlayer.UserId
    local AvatarCache = {}

    local function ResolveUsernameToId(username)
        if username == "Self Avatar" then return LocalPlayer.UserId end
        if AvatarCache[username] then return AvatarCache[username] end
        local ok, uid = pcall(function()
            return Players:GetUserIdFromNameAsync(username)
        end)
        if ok and uid then
            AvatarCache[username] = uid
            return uid
        end
        return nil
    end
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
        if not character or not SelectedFakeAva then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        task.spawn(function()
            local success, appearance = pcall(function()
                return Players:GetCharacterAppearanceAsync(SelectedFakeAva)
            end)
            if not success or not appearance then return end
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
            task.wait(0.1)
            LoadAppearanceIntoChar(appearance, character, head)
        end)
    end
    W.FakeAvatar_SelectByUsername = function(option)
        local uid = ResolveUsernameToId(option)
        if not uid then ForceNotify("Fake Avatar", "Username gak ketemu: " .. tostring(option), 2); return end
        SelectedFakeAva = uid
        if FakeAvatarEnabled then ApplyFakeAvatar() end
    end
    W.FakeAvatar_ApplyFromUsername = function(username)
        if username == "" then return end
        local ok, userId = pcall(function() return Players:GetUserIdFromNameAsync(username) end)
        if not ok or not userId then ForceNotify("Fake Avatar", "Username tidak ditemukan: " .. username, 2); return end
        SelectedFakeAva = userId
        ApplyFakeAvatar()
        ForceNotify("Fake Avatar", "Applied: @" .. username, 2)
    end
    W.FakeAvatar_SetEnabled = function(state)
        FakeAvatarEnabled = state
        if state then ApplyFakeAvatar() end
    end
    LocalPlayer.CharacterAdded:Connect(function()
        if FakeAvatarEnabled then task.wait(1); ApplyFakeAvatar() end
    end)
end

-- ▸ FAKE KORLESS
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
            task.wait(1); Morph()
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
    W.Korless_SetEnabled = function(v)
        KorlessMorph.Enabled = v
        if v then ApplyKorless() else RemoveKorless() end
    end
end

-- ▸ HEADER TITLE
do
    local HeaderEnabled = false
    local HeaderText = "FAZZHUB"
    local HeaderState = { Billboard = nil, TextLabel = nil, ShineLabel = nil, ShineGradient = nil, SizeConnection = nil }
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
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
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
            NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.30, 1),
            NumberSequenceKeypoint.new(0.42, 0), NumberSequenceKeypoint.new(0.58, 0),
            NumberSequenceKeypoint.new(0.70, 1), NumberSequenceKeypoint.new(1.00, 1),
        })
        shineGradient.Offset = Vector2.new(-1, 0)
        shineGradient.Parent = shineLabel
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
    local function Header_UpdateText(text)
        HeaderText = text or "FAZZHUB"
        if HeaderState.TextLabel then HeaderState.TextLabel.Text = HeaderText end
        if HeaderState.ShineLabel then HeaderState.ShineLabel.Text = HeaderText end
    end
    W.Header_UpdateText = Header_UpdateText
    W.Header_SetColor = function(c)
        if HeaderState.TextLabel then HeaderState.TextLabel.TextColor3 = c end
    end
    W.Header_SetEnabled = function(v, text)
        HeaderEnabled = v and true or false
        if text then Header_UpdateText(text) end
        if v then Header_Create()
        else
            if HeaderState.SizeConnection then HeaderState.SizeConnection:Disconnect(); HeaderState.SizeConnection = nil end
            if HeaderState.Billboard then HeaderState.Billboard:Destroy() end
            HeaderState.Billboard = nil; HeaderState.TextLabel = nil
            HeaderState.ShineLabel = nil; HeaderState.ShineGradient = nil
        end
    end
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if HeaderEnabled then W.Header_SetEnabled(true, HeaderText) end
    end)
end

-- ▸ SPECTATOR COUNTER
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
        mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        mainFrame.BackgroundTransparency = 0.1
        mainFrame.BorderSizePixel = 0
        Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)
        local topBar = Instance.new("Frame", mainFrame)
        topBar.Size = UDim2.new(1, 0, 0, 4)
        topBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        topBar.BorderSizePixel = 0
        Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 6)
        local header = Instance.new("Frame", mainFrame)
        header.Size = UDim2.new(1, 0, 0, 18)
        header.Position = UDim2.new(0, 0, 0, 4)
        header.BackgroundTransparency = 1
        local title = Instance.new("TextLabel", header)
        title.Size = UDim2.new(1, -20, 1, 0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.Text = "Spectators"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 10
        title.TextXAlignment = Enum.TextXAlignment.Center
        local body = Instance.new("Frame", mainFrame)
        body.Name = "Body"
        body.Size = UDim2.new(1, 0, 1, -25)
        body.Position = UDim2.new(0, 0, 0, 25)
        body.BackgroundTransparency = 1
        SpecLabel = Instance.new("TextLabel", body)
        SpecLabel.Name = "CountLabel"
        SpecLabel.Size = UDim2.new(1, 0, 1, 0)
        SpecLabel.BackgroundTransparency = 1
        SpecLabel.Font = Enum.Font.GothamMedium
        SpecLabel.Text = "No spectators"
        SpecLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        SpecLabel.TextSize = 11
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
            SpecLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    W.SpecCounter_SetEnabled = function(state)
        SpecEnabled = state
        if SpecThread then task.cancel(SpecThread); SpecThread = nil end
        if state then
            Spec_CreateUI(); Spec_Update()
            SpecThread = task.spawn(function()
                while SpecEnabled do Spec_Update(); task.wait(1.2) end
            end)
        else
            if SpecGui then SpecGui:Destroy(); SpecGui = nil; SpecLabel = nil end
        end
    end
end

-- ▸ BOMBAX MINI PLAYER
do
    local BG_ID = "rbxassetid://72845574620852"
    local ACCENT = Color3.fromRGB(29, 185, 84)
    local ACCENT_LIGHT = Color3.fromRGB(60, 230, 120)
    local ACCENT_DARK = Color3.fromRGB(18, 120, 55)
    local SPARKLE = Color3.fromRGB(150, 255, 180)
    local BG_DARK = Color3.fromRGB(6, 6, 8)
    local BG_LIGHT = Color3.fromRGB(28, 28, 34)
    local TEXT_WHITE = Color3.fromRGB(245, 245, 250)
    local TEXT_GRAY = Color3.fromRGB(150, 150, 165)

    local Songs = {
        {id="101985596918228", judul="One"},{id="78520199502339", judul="Two"},{id="78253224480952", judul="Three"},
        {id="136949217768985", judul="Four"},{id="92143860315842", judul="Five"},{id="96568301359656", judul="Six"},
        {id="96053601899287", judul="Seven"},{id="116537762304510", judul="Eight"},{id="111775377151665", judul="Nine"},
        {id="131317416582166", judul="Ten"},{id="107569604895628", judul="Eleven"},{id="80210594606101", judul="Danza Kuduro"},
        {id="135887188304832", judul="Ada Yang Tumbang Jos Jis"},{id="105372329671874", judul="Million Stars Asoy"},
        {id="79296696808534", judul="My Lope Lope (Speed Up)"},{id="70578919220987", judul="My Lope Lope (Andri Poter)"},
        {id="89338419772018", judul="Habibi Ishqi"},{id="93652038633690", judul="Santai Dulu"},
        {id="124582101215124", judul="DJ Akimilaku Im Back"},{id="121304834713825", judul="Dangdut Week Sebelas"},
        {id="102944382854479", judul="Lagu Misterius"},{id="126810420971446", judul="Anak Kota"},
        {id="94299109467073", judul="Cinderella Jedag Jedug"},{id="83463789936127", judul="Lagu Jawa (Kowe Siji)"},
        {id="771523191444498", judul="Cintaku Ini Istimewa"},{id="86422417888834", judul="Kini Tinggal Kenangan"},
        {id="70868757792328", judul="Mashup Dora Dora (Funky RMX)"},{id="128071048140468", judul="Always Loving You"},
        {id="136239433509180", judul="Mysterious Girl (Funky RMX)"},{id="101280279977761", judul="Kini Kita Pe Kisah"},
        {id="110337096446518", judul="DJ Onia"},{id="117080961502380", judul="Music Dubstep x Bangun Tidur Selfie"},
        {id="108556908140218", judul="Who Am I"},{id="95163564243987", judul="Never Stop (DJ WHO x Mokyy)"},
        {id="99445078556609", judul="Hope"},{id="132575056090579", judul="Heroes"},
        {id="124662835711453", judul="Where Do We Begin x An Angel's Love"},{id="91303938501044", judul="AKIMILAKU PUNYA ISTRI TIGA"},
    }
    local LIBRARY = {}
    for _, s in ipairs(Songs) do LIBRARY[s.judul] = "rbxassetid://" .. s.id end

    W.Bombax = W.Bombax or { Sound = nil, IsPlaying = false, IsPaused = false, Volume = 2, Looped = false,
        CurrentTrack = nil, CurrentId = nil, Gui = nil }
    local B = W.Bombax

    local function EnsureSound()
        if B.Sound and B.Sound.Parent then return B.Sound end
        local snd = Instance.new("Sound")
        snd.Name = "FAZZHUBBombaxHQ"
        snd.Volume = B.Volume
        snd.Looped = B.Looped
        snd.PlaybackSpeed = 1
        snd.RollOffMode = Enum.RollOffMode.Inverse
        snd.RollOffMinDistance = 8
        snd.RollOffMaxDistance = 1000
        snd.Parent = SoundService
        B.Sound = snd
        return snd
    end
    function W.Bombax_Play(soundId, trackName)
        local snd = EnsureSound()
        if snd.SoundId ~= soundId then snd.SoundId = soundId; snd.TimePosition = 0 end
        snd.Volume = B.Volume
        snd.Looped = B.Looped
        snd:Play()
        B.IsPlaying = true
        B.IsPaused = false
        B.CurrentTrack = trackName or soundId
        B.CurrentId = soundId
    end
    function W.Bombax_TogglePlay()
        if not B.Sound then
            W.Bombax_Play(LIBRARY["One"], "One")
            return
        end
        if B.Sound.IsPaused then B.Sound:Resume(); B.IsPaused = false
        elseif B.Sound.IsPlaying then B.Sound:Pause(); B.IsPaused = true
        else B.Sound:Play(); B.IsPlaying = true end
    end
    function W.Bombax_SetVolume(v)
        B.Volume = math.clamp(tonumber(v) or 2, 0, 10)
        if B.Sound then B.Sound.Volume = B.Volume end
    end
    function W.Bombax_Next()
        local keys = {}
        for k in pairs(LIBRARY) do table.insert(keys, k) end
        table.sort(keys)
        local curIdx = 1
        for i, k in ipairs(keys) do if k == B.CurrentTrack then curIdx = i; break end end
        local nextIdx = curIdx + 1
        if nextIdx > #keys then nextIdx = 1 end
        local nextName = keys[nextIdx]
        W.Bombax_Play(LIBRARY[nextName], nextName)
    end
    function W.Bombax_Prev()
        local keys = {}
        for k in pairs(LIBRARY) do table.insert(keys, k) end
        table.sort(keys)
        local curIdx = 1
        for i, k in ipairs(keys) do if k == B.CurrentTrack then curIdx = i; break end end
        local prevIdx = curIdx - 1
        if prevIdx < 1 then prevIdx = #keys end
        local prevName = keys[prevIdx]
        W.Bombax_Play(LIBRARY[prevName], prevName)
    end

    function W.Bombax_BuildUI()
        local parent = LocalPlayer:FindFirstChild("PlayerGui")
        if gethui then
            local ok, hui = pcall(gethui)
            if ok and hui then parent = hui end
        end
        if not parent then return end
        if B.Gui then pcall(function() B.Gui:Destroy() end) end
        local sg = Instance.new("ScreenGui")
        sg.Name = "FAZZHUBBombaxMini"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        sg.DisplayOrder = 300
        sg.Parent = parent
        B.Gui = sg

        local main = Instance.new("Frame")
        main.Name = "Main"
        main.Size = UDim2.fromOffset(200, 330)
        main.Position = UDim2.new(0.5, -100, 0.5, -165)
        main.BackgroundColor3 = BG_DARK
        main.BorderSizePixel = 0
        main.Active = true
        main.ClipsDescendants = true
        main.Parent = sg
        Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

        local bgImg = Instance.new("ImageLabel")
        bgImg.Size = UDim2.fromScale(1, 1)
        bgImg.BackgroundTransparency = 1
        bgImg.Image = BG_ID
        bgImg.ImageTransparency = 0.6
        bgImg.ScaleType = Enum.ScaleType.Crop
        bgImg.ZIndex = 0
        bgImg.Parent = main
        Instance.new("UICorner", bgImg).CornerRadius = UDim.new(0, 12)

        local header = Instance.new("Frame")
        header.Size = UDim2.new(1, 0, 0, 30)
        header.BackgroundTransparency = 1
        header.ZIndex = 5
        header.Active = true
        header.Parent = main

        local titleLbl = Instance.new("TextLabel")
        titleLbl.Size = UDim2.new(1, -80, 1, 0)
        titleLbl.Position = UDim2.new(0, 34, 0, 0)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Font = Enum.Font.GothamBlack
        titleLbl.Text = "BOMBAX"
        titleLbl.TextColor3 = TEXT_WHITE
        titleLbl.TextSize = 13
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.ZIndex = 6
        titleLbl.Parent = header

        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.fromOffset(20, 20)
        closeBtn.Position = UDim2.new(1, -22, 0, 5)
        closeBtn.BackgroundColor3 = BG_LIGHT
        closeBtn.BorderSizePixel = 0
        closeBtn.Text = "×"
        closeBtn.TextColor3 = TEXT_WHITE
        closeBtn.TextSize = 15
        closeBtn.Font = Enum.Font.GothamBlack
        closeBtn.ZIndex = 10
        closeBtn.Parent = header
        Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
        closeBtn.MouseButton1Click:Connect(function()
            sg:Destroy()
            B.Gui = nil
        end)

        local content = Instance.new("Frame")
        content.Size = UDim2.new(1, 0, 1, -30)
        content.Position = UDim2.new(0, 0, 0, 30)
        content.BackgroundTransparency = 1
        content.ZIndex = 5
        content.Parent = main

        local trackLabel = Instance.new("TextLabel")
        trackLabel.Name = "TrackLabel"
        trackLabel.Size = UDim2.new(1, -16, 0, 20)
        trackLabel.Position = UDim2.new(0, 8, 0, 6)
        trackLabel.BackgroundTransparency = 1
        trackLabel.Font = Enum.Font.GothamBold
        trackLabel.Text = "No Track Playing"
        trackLabel.TextColor3 = TEXT_WHITE
        trackLabel.TextSize = 11
        trackLabel.Parent = content

        local statusLabel = Instance.new("TextLabel")
        statusLabel.Name = "StatusLabel"
        statusLabel.Size = UDim2.new(1, -16, 0, 12)
        statusLabel.Position = UDim2.new(0, 8, 0, 26)
        statusLabel.BackgroundTransparency = 1
        statusLabel.Font = Enum.Font.GothamBlack
        statusLabel.Text = "READY"
        statusLabel.TextColor3 = ACCENT
        statusLabel.TextSize = 8
        statusLabel.Parent = content

        local songList = Instance.new("ScrollingFrame")
        songList.Size = UDim2.new(1, -16, 0, 200)
        songList.Position = UDim2.new(0, 8, 0, 44)
        songList.BackgroundColor3 = BG_DARK
        songList.BackgroundTransparency = 0.2
        songList.BorderSizePixel = 0
        songList.ScrollBarThickness = 3
        songList.ScrollBarImageColor3 = ACCENT
        songList.CanvasSize = UDim2.new(0, 0, 0, 0)
        songList.Parent = content
        Instance.new("UICorner", songList).CornerRadius = UDim.new(0, 7)
        local listLayout = Instance.new("UIListLayout", songList)
        listLayout.Padding = UDim.new(0, 2)
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        local plPad = Instance.new("UIPadding", songList)
        plPad.PaddingTop = UDim.new(0, 3)
        plPad.PaddingBottom = UDim.new(0, 3)

        local sortedSongs = {}
        for _, s in ipairs(Songs) do table.insert(sortedSongs, s) end
        table.sort(sortedSongs, function(a, b) return a.judul < b.judul end)
        for i, song in ipairs(sortedSongs) do
            local item = Instance.new("TextButton")
            item.Size = UDim2.new(1, 0, 0, 22)
            item.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
            item.BackgroundTransparency = 0.3
            item.BorderSizePixel = 0
            item.Text = "  " .. song.judul
            item.TextColor3 = TEXT_WHITE
            item.TextSize = 9
            item.Font = Enum.Font.GothamBold
            item.TextXAlignment = Enum.TextXAlignment.Left
            item.LayoutOrder = i
            item.Parent = songList
            Instance.new("UICorner", item).CornerRadius = UDim.new(0, 5)
            item.MouseButton1Click:Connect(function()
                W.Bombax_Play(LIBRARY[song.judul], song.judul)
                trackLabel.Text = song.judul
                statusLabel.Text = "PLAYING"
            end)
        end
        listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            songList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)
        end)

        local ctrlFrame = Instance.new("Frame")
        ctrlFrame.Size = UDim2.new(1, 0, 0, 50)
        ctrlFrame.Position = UDim2.new(0, 0, 1, -50)
        ctrlFrame.BackgroundTransparency = 1
        ctrlFrame.Parent = content

        local prevBtn = Instance.new("TextButton")
        prevBtn.AnchorPoint = Vector2.new(0.5, 0.5)
        prevBtn.Size = UDim2.fromOffset(36, 36)
        prevBtn.Position = UDim2.new(0.3, 0, 0.5, 0)
        prevBtn.BackgroundColor3 = BG_LIGHT
        prevBtn.BorderSizePixel = 0
        prevBtn.Text = "⏮"
        prevBtn.TextColor3 = TEXT_WHITE
        prevBtn.TextSize = 18
        prevBtn.Font = Enum.Font.GothamBlack
        prevBtn.Parent = ctrlFrame
        Instance.new("UICorner", prevBtn).CornerRadius = UDim.new(1, 0)
        prevBtn.MouseButton1Click:Connect(function()
            W.Bombax_Prev()
            trackLabel.Text = B.CurrentTrack or "-"
        end)

        local playBtn = Instance.new("TextButton")
        playBtn.Name = "PlayBtn"
        playBtn.AnchorPoint = Vector2.new(0.5, 0.5)
        playBtn.Size = UDim2.fromOffset(48, 48)
        playBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
        playBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        playBtn.BorderSizePixel = 0
        playBtn.Text = "▶"
        playBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        playBtn.TextSize = 20
        playBtn.Font = Enum.Font.GothamBlack
        playBtn.Parent = ctrlFrame
        Instance.new("UICorner", playBtn).CornerRadius = UDim.new(1, 0)
        playBtn.MouseButton1Click:Connect(function()
            W.Bombax_TogglePlay()
            if B.Sound and B.Sound.IsPlaying then
                playBtn.Text = "⏸"
                statusLabel.Text = "PLAYING"
            else
                playBtn.Text = "▶"
                statusLabel.Text = "PAUSED"
            end
            trackLabel.Text = B.CurrentTrack or "No Track Playing"
        end)

        local nextBtn = Instance.new("TextButton")
        nextBtn.AnchorPoint = Vector2.new(0.5, 0.5)
        nextBtn.Size = UDim2.fromOffset(36, 36)
        nextBtn.Position = UDim2.new(0.7, 0, 0.5, 0)
        nextBtn.BackgroundColor3 = BG_LIGHT
        nextBtn.BorderSizePixel = 0
        nextBtn.Text = "⏭"
        nextBtn.TextColor3 = TEXT_WHITE
        nextBtn.TextSize = 18
        nextBtn.Font = Enum.Font.GothamBlack
        nextBtn.Parent = ctrlFrame
        Instance.new("UICorner", nextBtn).CornerRadius = UDim.new(1, 0)
        nextBtn.MouseButton1Click:Connect(function()
            W.Bombax_Next()
            trackLabel.Text = B.CurrentTrack or "-"
        end)

        local dragging, dragStart, startPos = false, nil, nil
        header.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = inp.Position
                startPos = main.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if not dragging then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                local d = inp.Position - dragStart
                main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end
    function W.Bombax_Destroy()
        if B.Sound then pcall(function() B.Sound:Stop() end); pcall(function() B.Sound:Destroy() end); B.Sound = nil end
        if B.Gui then pcall(function() B.Gui:Destroy() end); B.Gui = nil end
        B.IsPlaying = false
        B.IsPaused = false
    end
end

-- ▸ CONFIG SNAPSHOT HELPERS
if type(getgenv().ConfigData) ~= "table" then getgenv().ConfigData = {} end
W.GetConfigSnapshot = function()
    local snap = {}
    for k, v in pairs(VD) do
        if type(v) ~= "table" and type(v) ~= "function" and type(v) ~= "userdata" and type(v) ~= "thread" then
            snap[k] = v
        end
    end
    return snap
end
W.LoadConfigSnapshot = function(dec)
    if type(dec) ~= "table" then return end
    for k, v in pairs(dec) do
        if type(v) ~= "table" then VD[k] = v end
    end
end

print("[FAZZHUB Part 17] Logic Misc + Bombax Module loaded.")-- ═══════════════════════════════════════════════════════════════════
--  FAZZHUB | PART 18: Floating Buttons + Final Assembly
-- ═══════════════════════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local CoreGui           = game:GetService("CoreGui")
local TweenService      = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Library = getgenv().FAZZLibrary
local FAZZTabs = getgenv().FAZZTabs
if not Library or not FAZZTabs then warn("[FAZZHUB Part 18] Load Part 1 dulu!"); return end

local VD = getgenv().VD
local W  = getgenv()
local VD_Notify = W.VD_Notify or function() end

local ICON_ID = "rbxassetid://72845574620852"

-- ▸ FLOATING BUTTON FACTORY
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
        local icImg = ic and ic:FindFirstChild("IconImage")
        if isOn then
            TweenService:Create(main, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play()
            if ic then TweenService:Create(ic, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 200, 100), BackgroundTransparency = 0.15 }):Play() end
            if sp then TweenService:Create(sp, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play() end
            if st then st.Text = "ON"; TweenService:Create(st, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(0, 200, 100) }):Play() end
            if sd then TweenService:Create(sd, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 200, 100) }):Play() end
            if str then TweenService:Create(str, TweenInfo.new(0.25), { Color = Color3.fromRGB(0, 200, 100) }):Play() end
        else
            TweenService:Create(main, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play()
            if ic then TweenService:Create(ic, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(90, 90, 90), BackgroundTransparency = 0.4 }):Play() end
            if sp then TweenService:Create(sp, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play() end
            if st then st.Text = "OFF"; TweenService:Create(st, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(120, 120, 120) }):Play() end
            if sd then TweenService:Create(sd, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(90, 90, 90) }):Play() end
            if str then TweenService:Create(str, TweenInfo.new(0.25), { Color = Color3.fromRGB(25, 25, 25) }):Play() end
        end
    end
    local function ToggleBtn()
        local s = not cfg.isOn()
        cfg.onToggle(s)
        UpdateVisual()
    end
    local function CreateBtn()
        DestroyBtn()
        local parent = LocalPlayer:FindFirstChild("PlayerGui")
        if gethui then local ok2, hui = pcall(gethui); if ok2 and hui then parent = hui end end
        if not parent then return end
        local gui = Instance.new("ScreenGui")
        gui.Name = "FAZZ" .. cfg.id .. "Btn"; gui.ResetOnSpawn = false
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
        main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        main.BorderSizePixel = 0; main.ZIndex = 1; main.Parent = container
        Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
        local mainStroke = Instance.new("UIStroke", main)
        mainStroke.Name = "MainStroke"
        mainStroke.Color = Color3.fromRGB(25, 25, 25)
        mainStroke.Thickness = 1.2; mainStroke.Transparency = 0.2
        local ic = Instance.new("Frame")
        ic.Name = "IconCircle"
        ic.Size = UDim2.fromOffset(20, 20)
        ic.Position = UDim2.new(0, 10, 0.5, -10)
        ic.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
        ic.BackgroundTransparency = 0.4
        ic.BorderSizePixel = 0; ic.ZIndex = 2; ic.Parent = main
        Instance.new("UICorner", ic).CornerRadius = UDim.new(1, 0)
        local icImg = Instance.new("ImageLabel")
        icImg.Name = "IconImage"
        icImg.Size = UDim2.fromScale(1, 1)
        icImg.BackgroundTransparency = 1
        icImg.Image = ICON_ID
        icImg.ZIndex = 3
        icImg.Parent = ic
        local icCorner = Instance.new("UICorner", icImg)
        icCorner.CornerRadius = UDim.new(1, 0)
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
        sd.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
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
        lock.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        lock.BorderSizePixel = 0; lock.Text = ""
        lock.AutoButtonColor = false; lock.ZIndex = 1; lock.Parent = container
        Instance.new("UICorner", lock).CornerRadius = UDim.new(0, 12)
        local ls = Instance.new("UIStroke", lock)
        ls.Color = Color3.fromRGB(25, 25, 25)
        ls.Thickness = 1.2; ls.Transparency = 0.2
        ls.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local li = Instance.new("TextLabel")
        li.Name = "LockIcon"
        li.Size = UDim2.fromScale(1, 1)
        li.BackgroundTransparency = 1
        li.Font = Enum.Font.GothamBold
        li.Text = "[ ]"
        li.TextColor3 = Color3.fromRGB(180, 180, 190)
        li.TextSize = 12; li.ZIndex = 2; li.Parent = lock
        local function UpdateLockVisual()
            if state.DragLocked then
                li.Text = "[X]"
                TweenService:Create(ls, TweenInfo.new(0.2), { Color = Color3.fromRGB(255, 80, 80), Transparency = 0, Thickness = 1.5 }):Play()
                TweenService:Create(li, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(255, 80, 80) }):Play()
            else
                li.Text = "[ ]"
                TweenService:Create(ls, TweenInfo.new(0.2), { Color = Color3.fromRGB(25, 25, 25), Transparency = 0.2, Thickness = 1.2 }):Play()
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

-- ▸ SELF HEAL BUTTON
local SelfHealBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.28,0), Connections={} }
local SelfHealState = CreateFloatingButton({
    id="SelfHeal", title="Heal", state=SelfHealBtnState,
    isOn=function() return W.InstantHealSelf end,
    onToggle=function(v) W.setInstantHealSelf(v) end,
})
getgenv().FAZZ_SHB_SetEnabled = function(en) SelfHealState.SetEnabled(en) end
getgenv().FAZZ_SHB_UpdateVisual = function() SelfHealState.UpdateVisual() end

-- ▸ SELF UNHOOK BUTTON
local SelfUnhookBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.35,0), Connections={} }
local SelfUnhookState = CreateFloatingButton({
    id="SelfUnhook", title="Hook", state=SelfUnhookBtnState,
    isOn=function() return W.SelfUnhook and W.SelfUnhook.Enabled end,
    onToggle=function(v) W.SU_SetEnabled(v) end,
})
getgenv().FAZZ_SUB_SetEnabled = function(en) SelfUnhookState.SetEnabled(en) end
getgenv().FAZZ_SUB_UpdateVisual = function() SelfUnhookState.UpdateVisual() end

-- ▸ TROLL TP BUTTON
local TrollBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.42,0), Connections={} }
local TrollState = CreateFloatingButton({
    id="TrollTP", title="T_TP", state=TrollBtnState,
    isOn=function() return W.TrollTeleport and W.TrollTeleport.Enabled end,
    onToggle=function(v) W.TrollTeleport_SetEnabled(v) end,
})
getgenv().FAZZ_TTB_SetEnabled = function(en) TrollState.SetEnabled(en) end
getgenv().FAZZ_TTB_UpdateVisual = function() TrollState.UpdateVisual() end

-- ▸ ESCAPE BUTTON
local EscapeBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.49,0), Connections={} }
local EscapeState = CreateFloatingButton({
    id="Escape", title="Escape", state=EscapeBtnState,
    isOn=function() return W.Escape and W.Escape.Enabled end,
    onToggle=function(v) W.Escape.Enabled = v; if v then W.Escape_Teleport() end end,
})
getgenv().FAZZ_Escape_SetEnabled = function(en) EscapeState.SetEnabled(en) end
getgenv().FAZZ_Escape_UpdateVisual = function() EscapeState.UpdateVisual() end

-- ▸ PARRY BUTTON
local ParryBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.56,0), Connections={} }
local ParryStateBtn = CreateFloatingButton({
    id="Parry", title="Parry", state=ParryBtnState,
    isOn=function() return VD.PARRY_Enabled end,
    onToggle=function(v)
        VD.PARRY_Enabled = v
        if not v and W.ParryState then W.ParryState.ActiveAttackers = {} end
    end,
})
getgenv().FAZZ_ParryBtn_SetEnabled = function(en) ParryStateBtn.SetEnabled(en) end
getgenv().FAZZ_ParryBtn_UpdateVisual = function() ParryStateBtn.UpdateVisual() end

-- ▸ INVIS BUTTON
local InvisBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.63,0), Connections={} }
local InvisStateBtn = CreateFloatingButton({
    id="Invisible", title="Invis", state=InvisBtnState,
    isOn=function()
        local MV = getgenv().FAZZInvis
        return MV and MV.Enabled or false
    end,
    onToggle=function(v) W.Invisible_SetState(v, true) end,
})
getgenv().FAZZ_InvisBtn_SetEnabled = function(en) InvisStateBtn.SetEnabled(en) end
getgenv().FAZZ_InvisBtn_UpdateVisual = function() InvisStateBtn.UpdateVisual() end

-- ▸ MYERS GRAB BUTTON
local MyersGrabBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.70,0), Connections={} }
local MyersGrabBtn = CreateFloatingButton({
    id="MyersGrab", title="Grab", state=MyersGrabBtnState,
    isOn=function() return W.MyersGrabData and W.MyersGrabData.Enabled end,
    onToggle=function(v) W.setMyersGrab(v) end,
})
getgenv().FAZZ_MGrabBtn_SetEnabled = function(en) MyersGrabBtn.SetEnabled(en) end
getgenv().FAZZ_MGrabBtn_UpdateVisual = function() MyersGrabBtn.UpdateVisual() end

-- ▸ VEIL BUTTON
local VeilBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.77,0), Connections={} }
local VeilBtn = CreateFloatingButton({
    id="SilentVeil", title="Veil", state=VeilBtnState,
    isOn=function() return VD.VeilEnabled end,
    onToggle=function(v) VD.VeilEnabled = v end,
})
getgenv().FAZZ_VeilBtn_SetEnabled = function(en) VeilBtn.SetEnabled(en) end
getgenv().FAZZ_VeilBtn_UpdateVisual = function() VeilBtn.UpdateVisual() end

-- ▸ MOONWALK BUTTON
local MoonwalkBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.84,0), Connections={} }
local MoonwalkState = CreateFloatingButton({
    id="Moonwalk", title="Moonwalk", state=MoonwalkBtnState,
    isOn=function() return W.MoonwalkEnabled end,
    onToggle=function(v) W.setMoonwalk(v) end,
})
getgenv().FAZZ_MoonwalkBtn_SetEnabled = function(en) MoonwalkState.SetEnabled(en) end
getgenv().FAZZ_MoonwalkBtn_UpdateVisual = function() MoonwalkState.UpdateVisual() end

print("[FAZZHUB Part 18] Floating Buttons + Final Assembly loaded.")
print("╔══════════════════════════════════════════════╗")
print("║   FAZZHUB v1.0 - Loaded Successfully!       ║")
print("║   Total Parts: 18                           ║")
print("║   All Features Ready                        ║")
print("╚══════════════════════════════════════════════╝")
