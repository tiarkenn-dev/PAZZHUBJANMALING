-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB SURVIVOR | PART S1: Helper + Self Heal + Swift Vault
-- ═══════════════════════════════════════════════════════════════════

-- === HELPER ===
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local CoreGui           = game:GetService("CoreGui")
local CollectionService = game:GetService("CollectionService")
local TweenService      = game:GetService("TweenService")
local LP                = Players.LocalPlayer
local isMobile          = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local VIM = nil
pcall(function() VIM = game:GetService("VirtualInputManager") end)

-- W2 State Container
getgenv().W2 = getgenv().W2 or {}
local W = getgenv()
W.Players = Players
W.RunService = RunService
W.UserInputService = UserInputService
W.ReplicatedStorage = ReplicatedStorage
W.Workspace = Workspace
W.CoreGui = CoreGui
W.CollectionService = CollectionService
W.TweenService = TweenService
W.LP = LP
W.isMobile = isMobile
W.VIM = VIM

-- Notify wrapper (pake Library dari luar)
W.Notify = function(title, msg, dur)
    pcall(function()
        Library:Notify({ Title = title or "PAZZHUB", Content = msg or "", Duration = dur or 2 })
    end)
end
W.W2_Notify = W.Notify

-- Team helper
function W.TeamIs(plr, role)
    if not plr or not plr.Team or not plr.Team.Name then return false end
    local tn = string.lower(plr.Team.Name)
    if role == "Killer"   then return tn:find("killer",   1, true) ~= nil end
    if role == "Survivor" then return tn:find("survivor", 1, true) ~= nil end
    return false
end
function W.GetRole()
    if W.TeamIs(LP, "Killer")   then return "Killer"   end
    if W.TeamIs(LP, "Survivor") then return "Survivor" end
    return nil
end

-- Generator helpers
function W.GB_GetAllGenerators()
    local gens = {}
    local mf = Workspace:FindFirstChild("Map")
    if not mf then return gens end
    for _, obj in ipairs(mf:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Generator" then
            if obj:GetAttribute("RepairProgress")
               or obj:GetAttribute("kickcount")
               or obj:GetAttribute("ProgressRepair") then
                table.insert(gens, obj)
            end
        end
    end
    return gens
end
function W.GB_GetPoints(m)
    local pts = {}
    if not m then return pts end
    for _, o in ipairs(m:GetChildren()) do
        if o:IsA("BasePart") and o.Name:find("GeneratorPoint") then
            table.insert(pts, o)
        end
    end
    return pts
end

-- === TAB SURVIVOR ===
local SurvTab = Window:AddTab("Survivor", "user")
local SurvLeft  = SurvTab:AddLeftGroupbox("Self Heal", "heart")
local SurvLeft2 = SurvTab:AddLeftGroupbox("Swift Vault", "wind")
local SurvLeft3 = SurvTab:AddLeftGroupbox("Pallet Reflex", "shield")
local SurvRight1 = SurvTab:AddRightGroupbox("Fake Perks", "sparkles")

W.SurvTab = SurvTab
W.SurvGB = { L1 = SurvLeft, L2 = SurvLeft2, L3 = SurvLeft3, R1 = SurvRight1 }

-- ═══════════════════════════════════════════════════════
-- SELF HEAL
-- ═══════════════════════════════════════════════════════
W2.SelfHeal_Enabled = false
W2.SelfHeal_AutoAll = false
W.SelfHeal_BlockedAnim = "95836365038528"

function W.HealSelf(v)
    local c = LP.Character
    if not c then return end
    local ev = ReplicatedStorage.Remotes.Healing.HealEvent
    local hp = c:FindFirstChild("HumanoidRootPart")
    if not hp then return end
    pcall(function() ev:FireServer(hp, v) end)
end
function W.HealOther(p, v)
    if not p or not p.Character then return end
    local hp = p.Character:FindFirstChild("HumanoidRootPart")
    if not hp then return end
    local ev = ReplicatedStorage.Remotes.Healing.HealEvent
    pcall(function() ev:FireServer(hp, v) end)
end

function W.setSelfHeal(v)
    W2.SelfHeal_Enabled = v
    if W._SelfHealConn then W._SelfHealConn:Disconnect(); W._SelfHealConn = nil end
    if v then
        W._SelfHealConn = RunService.Heartbeat:Connect(function()
            if not W2.SelfHeal_Enabled then return end
            local c = LP.Character
            if not c then return end
            local h = c:FindFirstChildOfClass("Humanoid")
            if not h then return end
            local a = h:FindFirstChildOfClass("Animator")
            if not a then return end
            local ok2, tracks = pcall(function() return a:GetPlayingAnimationTracks() end)
            if not ok2 then return end
            for _, t in ipairs(tracks) do
                local aid = t.Animation and t.Animation.AnimationId or ""
                if aid:match("%d+") == W.SelfHeal_BlockedAnim then
                    pcall(function() t:Stop(0) end)
                end
            end
        end)
        local ha = false
        if W._SelfHealLoop then W._SelfHealLoop:Disconnect() end
        W._SelfHealLoop = RunService.Heartbeat:Connect(function()
            if not W2.SelfHeal_Enabled then return end
            local c = LP.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not h then return end
            if h.Health >= h.MaxHealth * 0.9 then
                if ha then ha = false; W.HealSelf(false) end
                return
            end
            if ha then
                local ci = c:FindFirstChild("CheckInterractable")
                if ci and not ci:GetAttribute("isHealing") then ha = false end
            end
            if not ha then ha = true; W.HealSelf(true) end
        end)
    else
        if W._SelfHealLoop then W._SelfHealLoop:Disconnect(); W._SelfHealLoop = nil end
        pcall(function() W.HealSelf(false) end)
    end
end

function W.setAutoHealAll(v)
    W2.SelfHeal_AutoAll = v
    if W._AutoHealLoop then W._AutoHealLoop:Disconnect(); W._AutoHealLoop = nil end
    if v then
        local ah = {}
        W._AutoHealLoop = RunService.Heartbeat:Connect(function()
            if not W2.SelfHeal_AutoAll then return end
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    local hu = p.Character:FindFirstChildOfClass("Humanoid")
                    if hu and hu.Health > 0 and hu.Health < hu.MaxHealth * 0.9 then
                        if not ah[p] then ah[p] = true; W.HealOther(p, true) end
                    else
                        if ah[p] then ah[p] = nil; W.HealOther(p, false) end
                    end
                end
            end
        end)
    end
end

LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if W2.SelfHeal_Enabled then W.setSelfHeal(true) end
    if W2.SelfHeal_AutoAll then W.setAutoHealAll(true) end
end)

-- UI Self Heal
SurvLeft:AddToggle("SelfHeal_T", {
    Text = "Enable Self Heal",
    Default = false,
    Callback = function(v)
        W.setSelfHeal(v)
        W.W2_Notify("Self Heal", v and "Enabled" or "Disabled", 2)
    end
})
SurvLeft:AddToggle("AutoHealAll_T", {
    Text = "Auto Heal All",
    Default = false,
    Callback = function(v)
        W.setAutoHealAll(v)
        W.W2_Notify("Auto Heal All", v and "Enabled" or "Disabled", 2)
    end
})

-- ═══════════════════════════════════════════════════════
-- SWIFT VAULT
-- ═══════════════════════════════════════════════════════
W2.SwiftVault_Enabled = false
W2.SwiftVault_V2      = false
W2.SwiftVault_Speed   = 13

do
    local _vaulted = {}
    local _lastScan = 0

    local function BuildGroups()
        local g = {}
        local map = Workspace:FindFirstChild("Map")
        if not map then return g end
        local seen = {}
        for _, o in ipairs(map:GetDescendants()) do
            if o:IsA("BasePart") and (o.Name == "VaultTrigger" or o.Name == "VaultPoint") then
                if not seen[o] then
                    seen[o] = true
                    local root = o.Parent
                    if o.Name == "VaultPoint" and o.Parent and o.Parent.Name == "VaultTrigger" then
                        root = o.Parent.Parent
                    elseif o.Name == "VaultTrigger" then
                        root = o.Parent
                    end
                    if root then
                        g[root] = g[root] or {}
                        table.insert(g[root], o)
                    end
                end
            end
        end
        return g
    end

    RunService.Heartbeat:Connect(function()
        if W2.SwiftVault_V2 then
            pcall(function()
                local c = LP.Character
                if c then c:SetAttribute("vaultspeed", (W2.SwiftVault_Speed or 13) / 10) end
            end)
        end
    end)

    RunService.Heartbeat:Connect(function()
        if not W2.SwiftVault_Enabled then return end
        if W.GetRole() ~= "Survivor" then return end
        if tick() - _lastScan < 0.15 then return end
        _lastScan = tick()
        pcall(function()
            local c = LP.Character
            local root = c and c:FindFirstChild("HumanoidRootPart")
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not root or not h or h.Health <= 0 then return end
            if root.AssemblyLinearVelocity.Magnitude < 1 then return end
            for rw in pairs(BuildGroups()) do
                local allVT = {}
                for _, ch in ipairs(rw:GetChildren()) do
                    if ch.Name == "VaultTrigger" then table.insert(allVT, ch) end
                end
                if #allVT == 0 then continue end
                local near, nd = nil, math.huge
                for _, vt in ipairs(allVT) do
                    local pos = vt:IsA("BasePart") and vt.Position or (vt.PrimaryPart and vt.PrimaryPart.Position)
                    if pos then
                        local d = (root.Position - pos).Magnitude
                        if d < nd then nd = d; near = vt end
                    end
                end
                if not near or nd > 6 then continue end
                if tick() - (_vaulted[rw] or 0) < 3 then continue end
                local rf = ReplicatedStorage:FindFirstChild("Remotes")
                local wf = rf and rf:FindFirstChild("Window")
                if wf then
                    pcall(function() wf:FindFirstChild("VaultEvent"):FireServer(near, true) end)
                    pcall(function() wf:FindFirstChild("Vaultbindable"):Fire(near, true) end)
                    pcall(function() wf:FindFirstChild("fastvault"):FireServer(LP) end)
                    pcall(function() wf:FindFirstChild("VaultCompleteEventpart1"):FireServer() end)
                    pcall(function() wf:FindFirstChild("VaultCompleteEvent"):FireServer(near, false) end)
                end
                _vaulted[rw] = tick()
                break
            end
        end)
    end)

    LP.CharacterAdded:Connect(function() task.wait(0.5); _vaulted = {} end)

    function W.SwiftVault_Set(v) W2.SwiftVault_Enabled = v and true or false; _vaulted = {} end
    function W.SwiftVaultV2_Set(v)
        W2.SwiftVault_V2 = v and true or false
        if not v then
            local c = LP.Character
            if c then pcall(function() c:SetAttribute("vaultspeed", 1) end) end
        end
    end
    function W.SwiftVault_SetSpeed(v) W2.SwiftVault_Speed = tonumber(v) or 13 end
end

-- UI Swift Vault
SurvLeft2:AddToggle("SwiftVault_T", {
    Text = "Swift Vault",
    Default = false,
    Callback = function(v)
        W.SwiftVault_Set(v)
        W.W2_Notify("Swift Vault", v and "Enabled" or "Disabled", 2)
    end
})
SurvLeft2:AddToggle("SwiftVaultV2_T", {
    Text = "Swift Vault V2",
    Default = false,
    Callback = function(v)
        W.SwiftVaultV2_Set(v)
        W.W2_Notify("Swift Vault V2", v and "Enabled" or "Disabled", 2)
    end
})
SurvLeft2:AddSlider("VaultSpeed_S", {
    Text = "Vault Speed",
    Min = 10, Max = 20, Default = 13, Rounding = 0,
    Callback = function(v) W.SwiftVault_SetSpeed(v) end
})

print("[PAZZHUB] PART S1 loaded — Self Heal + Swift Vault")-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB SURVIVOR | PART S2: Pallet Reflex + Fake Perks
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════
-- PALLET REFLEX
-- ═══════════════════════════════════════════════════════
W2.PalletReflex_Enabled = false
W2.PalletReflex_Dist    = 20

do
    local _lastDrop = 0
    local _used = {}

    local function GetKillerRoot()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and W.TeamIs(p, "Killer") and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then return hrp end
            end
        end
        return nil
    end

    local _lastScan = 0
    RunService.Heartbeat:Connect(function()
        if not W2.PalletReflex_Enabled then return end
        if W.GetRole() ~= "Survivor" then return end
        local now = tick()
        if now - _lastScan < 0.2 then return end
        _lastScan = now
        if now - _lastDrop < 2.5 then return end
        pcall(function()
            local c = LP.Character
            local root = c and c:FindFirstChild("HumanoidRootPart")
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not root or not h or h.Health <= 0 then return end
            local kr = GetKillerRoot()
            if not kr then return end
            if (root.Position - kr.Position).Magnitude > (W2.PalletReflex_Dist or 20) then return end
            local rf = ReplicatedStorage:FindFirstChild("Remotes")
            local pf = rf and rf:FindFirstChild("Pallet")
            local drop = pf and pf:FindFirstChild("PalletDropEvent")
            if not drop then return end
            local map = Workspace:FindFirstChild("Map")
            if not map then return end
            local best, bd = nil, 8
            for _, obj in ipairs(map:GetDescendants()) do
                if obj.Name == "Palletwrong" and (obj:IsA("Model") or obj:IsA("Folder")) and not _used[obj] then
                    local ref = obj:FindFirstChild("PalletPointSlide") or obj:FindFirstChild("PalletPoint") or obj:FindFirstChildWhichIsA("BasePart", true)
                    if ref then
                        local d = (root.Position - ref.Position).Magnitude
                        if d < bd then bd = d; best = obj end
                    end
                end
            end
            if best then
                local tgt = best:FindFirstChild("PalletPointSlide") or best:FindFirstChild("PalletPoint")
                if tgt then
                    pcall(function() drop:FireServer(tgt) end)
                    _used[best] = true
                    _lastDrop = tick()
                end
            end
        end)
    end)

    LP.CharacterAdded:Connect(function() task.wait(0.5); _used = {} end)
    function W.PalletReflex_Set(v) W2.PalletReflex_Enabled = v and true or false; _used = {} end
    function W.PalletReflex_SetDist(v) W2.PalletReflex_Dist = tonumber(v) or 20 end
end

-- UI Pallet Reflex
W.SurvGB.L3:AddToggle("PalletReflex_T", {
    Text = "Enable Pallet Reflex",
    Default = false,
    Callback = function(v)
        W.PalletReflex_Set(v)
        W.W2_Notify("Pallet Reflex", v and "Enabled" or "Disabled", 2)
    end
})
W.SurvGB.L3:AddSlider("PalletReflexDist_S", {
    Text = "Distance",
    Min = 5, Max = 50, Default = 20, Rounding = 0, Suffix = " studs",
    Callback = function(v) W.PalletReflex_SetDist(v) end
})

-- ═══════════════════════════════════════════════════════
-- FAKE PERKS (Cooldown 40s)
-- ═══════════════════════════════════════════════════════
W.FP = W.FP or { ActiveBuffs = {}, Conns = {}, LastBuffTime = {}, CooldownTime = 40 }
local FP = W.FP
if not FP.LastBuffTime then FP.LastBuffTime = {} end

local function FP_Char() return LP.Character end
local function FP_Hum() local c = FP_Char(); return c and c:FindFirstChildOfClass("Humanoid") end
local function FP_Total()
    local t = 0
    for _, b in pairs(FP.ActiveBuffs) do if tick() < b.endTime then t = t + b.amt end end
    return t
end
local function FP_Apply()
    local c = FP_Char(); local tb = FP_Total(); local h = FP_Hum()
    if c then c:SetAttribute("speedboost", tb > 0 and (1 + tb/14) or 1) end
    if h and tb > 0 then h.WalkSpeed = 16 + tb end
end
local function FP_HB()
    if FP.HB then return end
    FP.HB = RunService.Heartbeat:Connect(function()
        local exp = {}
        for n, b in pairs(FP.ActiveBuffs) do if tick() >= b.endTime then table.insert(exp, n) end end
        for _, n in ipairs(exp) do FP.ActiveBuffs[n] = nil end
        FP_Apply()
        if FP_Total() <= 0 and not next(FP.ActiveBuffs) then
            if FP.HB then FP.HB:Disconnect(); FP.HB = nil end
            local c = FP_Char(); if c then c:SetAttribute("speedboost", 1) end
            local h = FP_Hum(); if h then h.WalkSpeed = 16 end
        end
    end)
end

local function FP_Buff(name, amt, dur)
    if FP.ActiveBuffs[name] then return end
    FP.LastBuffTime = FP.LastBuffTime or {}
    local now = tick()
    local lastTime = FP.LastBuffTime[name] or 0
    local cdTime = tonumber(FP.CooldownTime) or 40
    if now - lastTime < cdTime then return end
    FP.LastBuffTime[name] = now
    FP.ActiveBuffs[name] = { amt = amt, endTime = now + (dur or 3), duration = dur or 3 }
    FP_Apply(); FP_HB()
    W.W2_Notify("Fake Perks", name .. " +" .. amt .. " (CD 40s)", 3)
end

local function FP_Clean(name)
    if FP.Conns[name] then for _, c in ipairs(FP.Conns[name]) do pcall(function() c:Disconnect() end) end FP.Conns[name] = nil end
end
local function FP_Reg(name, conn)
    FP.Conns[name] = FP.Conns[name] or {}
    table.insert(FP.Conns[name], conn)
end

-- FLOWSTATE (+5 speed, 3s, CD 40s)
function W.FP_Flowstate(v)
    FP.FlowstateOn = v
    local c = FP_Char()
    if c then c:SetAttribute("Flowstate", v) end
    if v then
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local w = r and r:FindFirstChild("Window")
        local p = r and r:FindFirstChild("Pallet")
        local function on()
            if FP.FlowstateOn then
                task.delay(0.5, function()
                    if FP.FlowstateOn then FP_Buff("Flowstate", 5, 3) end
                end)
            end
        end
        if w then
            local vb = w:FindFirstChild("Vaultbindable")
            if vb and vb:IsA("BindableEvent") then FP_Reg("Flowstate", vb.Event:Connect(on)) end
        end
        if p then
            local sb = p:FindFirstChild("Slidebindable")
            if sb and sb:IsA("BindableEvent") then FP_Reg("Flowstate", sb.Event:Connect(on)) end
        end
    else
        FP_Clean("Flowstate"); FP.ActiveBuffs["Flowstate"] = nil
        local c2 = FP_Char(); if c2 then c2:SetAttribute("Flowstate", false) end
    end
end

-- QUICK RECOVERY (+6 speed, 3s, CD 40s)
function W.FP_QuickRec(v)
    FP.QuickRecOn = v
    if v then
        local function on()
            if FP.QuickRecOn then FP_Buff("QuickRecovery", 6, 3) end
        end
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local hf = r and r:FindFirstChild("Healing")
        if hf then
            local hd = hf:FindFirstChild("Healdone")
            if hd and hd:IsA("BindableEvent") then
                FP_Reg("QuickRecovery", hd.Event:Connect(on))
            end
        end
    else
        FP_Clean("QuickRecovery"); FP.ActiveBuffs["QuickRecovery"] = nil
    end
end

-- PERFECT LANDING (+8 speed, 3s, CD 40s)
function W.FP_PerfLand(v)
    FP.PerfLandOn = v
    if v then
        local function hook(c)
            if not c then return end
            local h = c:FindFirstChildOfClass("Humanoid")
            if not h then return end
            local wf, fs = false, 0
            FP_Reg("PerfectLanding", h.StateChanged:Connect(function(_, n)
                if not FP.PerfLandOn then return end
                if n == Enum.HumanoidStateType.Freefall then wf = true; fs = tick() end
                if wf and (n == Enum.HumanoidStateType.Landed or n == Enum.HumanoidStateType.Running) then
                    local ft = tick() - fs; wf = false
                    if ft >= 0.25 then FP_Buff("PerfectLanding", 8, 3) end
                end
            end))
        end
        hook(LP.Character)
        FP_Reg("PerfectLanding", LP.CharacterAdded:Connect(hook))
    else
        FP_Clean("PerfectLanding"); FP.ActiveBuffs["PerfectLanding"] = nil
    end
end

-- ADRENALINE RUSH (+4 speed, 5s, CD 40s)
function W.FP_Adrenaline(v)
    FP.AdrenalineOn = v
    if v then
        local function hook(c)
            if not c then return end
            local h = c:FindFirstChildOfClass("Humanoid")
            if not h then return end
            local lh = h.Health
            FP_Reg("AdrenalineRush", h.HealthChanged:Connect(function(nh)
                if not FP.AdrenalineOn then return end
                if nh < lh and nh <= 50 and nh > 0 then FP_Buff("AdrenalineRush", 4, 5) end
                lh = nh
            end))
        end
        hook(LP.Character)
        FP_Reg("AdrenalineRush", LP.CharacterAdded:Connect(hook))
    else
        FP_Clean("AdrenalineRush"); FP.ActiveBuffs["AdrenalineRush"] = nil
    end
end

-- UI Fake Perks
W.SurvGB.R1:AddToggle("FP_Flowstate_T", {
    Text = "Flowstate",
    Default = false,
    Callback = function(v)
        W.FP_Flowstate(v)
        if v then W.W2_Notify("Fake Perks", "Flowstate ON (CD 40s)", 2) end
    end
})
W.SurvGB.R1:AddToggle("FP_QuickRec_T", {
    Text = "Quick Recovery",
    Default = false,
    Callback = function(v)
        W.FP_QuickRec(v)
        if v then W.W2_Notify("Fake Perks", "Quick Recovery ON (CD 40s)", 2) end
    end
})
W.SurvGB.R1:AddToggle("FP_PerfLand_T", {
    Text = "Perfect Landing",
    Default = false,
    Callback = function(v)
        W.FP_PerfLand(v)
        if v then W.W2_Notify("Fake Perks", "Perfect Landing ON (CD 40s)", 2) end
    end
})
W.SurvGB.R1:AddToggle("FP_Adrenaline_T", {
    Text = "Adrenaline Rush",
    Default = false,
    Callback = function(v)
        W.FP_Adrenaline(v)
        if v then W.W2_Notify("Fake Perks", "Adrenaline ON (CD 40s)", 2) end
    end
})
W.SurvGB.R1:AddSlider("FP_Cooldown_S", {
    Text = "Perk Cooldown",
    Min = 0, Max = 120, Default = 40, Rounding = 0, Suffix = "s",
    Callback = function(v)
        FP.CooldownTime = tonumber(v) or 40
        W.W2_Notify("Fake Perks", "Cooldown: " .. tostring(v) .. "s", 2)
    end
})

print("[PAZZHUB] PART S2 loaded — Pallet Reflex + Fake Perks")-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB SURVIVOR | PART S3: Auto Skill Check + Bypass Generator
-- ═══════════════════════════════════════════════════════════════════

-- Buat groupbox baru
W.SurvGB.L4 = W.SurvTab:AddLeftGroupbox("Auto Skill Check", "target")
W.SurvGB.L5 = W.SurvTab:AddLeftGroupbox("Bypass Generator", "zap")

-- ═══════════════════════════════════════════════════════
-- AUTO SKILL CHECK
-- ═══════════════════════════════════════════════════════
W.SC = W.SC or { Enabled = false, Mode = "Legit", Busy = false, Conn = nil }
local SC = W.SC

local function SC_FindPrompt()
    local pg = LP:FindFirstChildOfClass("PlayerGui")
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
    if VIM then
        local ok = pcall(function()
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.02)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
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
    local pg = LP:FindFirstChildOfClass("PlayerGui")
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
    W2.SkillCheck_Enabled = v
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

-- UI Skill Check
W.SurvGB.L4:AddToggle("SC_T", {
    Text = "Enable Auto Skill Check",
    Default = false,
    Callback = function(v)
        W.SC_Set(v)
        W.W2_Notify("Auto Skill Check", v and "Enabled" or "Disabled", 2)
    end
})
W.SurvGB.L4:AddDropdown("SC_Mode_D", {
    Text = "Mode",
    Values = {"Legit", "Instant"},
    Default = "Legit",
    Callback = function(v) SC.Mode = v end
})

-- ═══════════════════════════════════════════════════════
-- BYPASS GENERATOR
-- ═══════════════════════════════════════════════════════
W.GB = W.GB or { Enabled = false, Cache = {}, Timer = 0, Processed = {}, Hotkey = Enum.KeyCode.B, Range = 8 }
local GB = W.GB
W2.GenBypass_Enabled = false
W2.GenBypass_Range = 8

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
    local c = LP.Character
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
    local c = LP.Character
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
        local c = LP.Character
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

-- UI Bypass Generator
W.SurvGB.L5:AddToggle("GB_T", {
    Text = "Enable Bypass Generator",
    Default = false,
    Callback = function(v)
        GB.Enabled = v; W2.GenBypass_Enabled = v
        if v then W.W2_Notify("Bypass Generator", "Enabled (Hotkey: B)", 3) end
    end
})
W.SurvGB.L5:AddSlider("GB_Range_S", {
    Text = "Trigger Range",
    Min = 3, Max = 20, Default = 8, Rounding = 0, Suffix = " studs",
    Callback = function(v) GB.Range = v; W2.GenBypass_Range = v end
})
W.SurvGB.L5:AddButton({
    Text = "Force Repair Nearest Generator",
    Func = function()
        local bp, bd = W.GB_Nearest()
        if bp and bd <= GB.Range then
            W.GB_Repair(bp)
            W.Notify("Bypass Generator", "Forcing repair...", 2)
        else
            W.Notify("Bypass Generator", "Terlalu jauh", 2)
        end
    end
})

print("[PAZZHUB] PART S3 loaded — Skill Check + Gen Bypass")-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB SURVIVOR | PART S4: Unlimited Vault + Anti Slow Vault + Auto Run
-- ═══════════════════════════════════════════════════════════════════

-- Buat groupbox baru
W.SurvGB.R2 = W.SurvTab:AddRightGroupbox("Unlimited Vault", "unlock")
W.SurvGB.R3 = W.SurvTab:AddRightGroupbox("Anti Slow Vault", "gauge")
W.SurvGB.L6 = W.SurvTab:AddLeftGroupbox("Auto Run", "footprints")

-- ═══════════════════════════════════════════════════════
-- UNLIMITED VAULT
-- ═══════════════════════════════════════════════════════
local UVOn, UVConn = false, nil
function W.UV_Set(v)
    W2.UnlimitedVault = v
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

-- UI Unlimited Vault
W.SurvGB.R2:AddToggle("UV_T", {
    Text = "Unlimited Vault",
    Default = false,
    Callback = function(v)
        W.UV_Set(v)
        W.W2_Notify("Unlimited Vault", v and "Enabled" or "Disabled", 2)
    end
})

-- ═══════════════════════════════════════════════════════
-- ANTI SLOW VAULT
-- ═══════════════════════════════════════════════════════
local ASVOn, ASVConn = false, nil
function W.ASV_Set(v)
    W2.AntiSlowVault = v
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

-- UI Anti Slow Vault
W.SurvGB.R3:AddToggle("ASV_T", {
    Text = "Anti Slow Vault",
    Default = false,
    Callback = function(v)
        W.ASV_Set(v)
        W.W2_Notify("Anti Slow Vault", v and "Enabled" or "Disabled", 2)
    end
})

-- ═══════════════════════════════════════════════════════
-- AUTO RUN
-- ═══════════════════════════════════════════════════════
W2.AutoRun_PC     = false
W2.AutoRun_Mobile = false

do
    local tPC, tMob = nil, nil

    local function startPC()
        if tPC then task.cancel(tPC) end
        tPC = task.spawn(function()
            while W2.AutoRun_PC do
                pcall(function() VIM:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, LP:GetMouse()) end)
                task.wait(0.1)
            end
            pcall(function() VIM:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LP:GetMouse()) end)
            tPC = nil
        end)
    end

    local function stopPC()
        W2.AutoRun_PC = false
        if tPC then task.cancel(tPC); tPC = nil end
        pcall(function() VIM:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LP:GetMouse()) end)
    end

    local function getSprint()
        local pg = LP:FindFirstChild("PlayerGui"); if not pg then return nil end
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
            while W2.AutoRun_Mobile do
                local c = LP.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if h and h.MoveDirection.Magnitude > 0.12 then pressSprint() end
                task.wait(0.12)
            end
            tMob = nil
        end)
    end

    function W.AutoRunPC(v)
        W2.AutoRun_PC = v
        if v then startPC() else stopPC() end
    end
    function W.AutoRunMobile(v)
        W2.AutoRun_Mobile = v
        if v then startMob() else W2.AutoRun_Mobile = false end
    end
end

-- UI Auto Run
W.SurvGB.L6:AddToggle("AutoRunPC_T", {
    Text = "Auto Run [PC]",
    Default = false,
    Callback = function(v)
        W.AutoRunPC(v)
        W.W2_Notify("Auto Run PC", v and "Enabled" or "Disabled", 2)
    end
})
W.SurvGB.L6:AddToggle("AutoRunMob_T", {
    Text = "Auto Run [Mobile]",
    Default = false,
    Callback = function(v)
        W.AutoRunMobile(v)
        W.W2_Notify("Auto Run Mobile", v and "Enabled" or "Disabled", 2)
    end
})

print("[PAZZHUB] PART S4 loaded — UnlimitedVault + AntiSlowVault + AutoRun")-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB SURVIVOR | PART S5: Crouch Dodge + Auto Flee + No Fall + God + TrollTP
-- ═══════════════════════════════════════════════════════════════════

-- Buat groupbox baru
W.SurvGB.L7 = W.SurvTab:AddLeftGroupbox("Auto Crouch Dodge", "shield-half")
W.SurvGB.L8 = W.SurvTab:AddLeftGroupbox("Auto Flee Killer", "footprints")
W.SurvGB.R4 = W.SurvTab:AddRightGroupbox("No Fall Damage", "feather")
W.SurvGB.R5 = W.SurvTab:AddRightGroupbox("Troll Teleport", "ghost")
W.SurvGB.R6 = W.SurvTab:AddRightGroupbox("God Mode", "shield-check")

-- ═══════════════════════════════════════════════════════
-- AUTO CROUCH DODGE
-- ═══════════════════════════════════════════════════════
W2.AutoCrouchDodge = false

W.IsDowned = function(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local s = char:GetAttribute("State")
    return s == "Downed" or s == "Dead"
end

W.TriggerCrouch = function()
    local startT = tick()
    task.spawn(function()
        local c = LP.Character
        if not c then return end
        local h = c:FindFirstChildOfClass("Humanoid")
        pcall(function() c:SetAttribute("Crouching", true) end)
        pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
        pcall(function() ReplicatedStorage.Remotes.Chase.Runevent:FireServer(c, false) end)
        if h then pcall(function() h:ChangeState(Enum.HumanoidStateType.Landed) end) end
        pcall(function()
            local mob = LP:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
            local ctrl = mob and mob:FindFirstChild("Controls")
            local btn = ctrl and ctrl:FindFirstChild("crouch")
            if btn and firesignal then firesignal(btn.MouseButton1Click) end
        end)
        while tick() - startT < 1.2 do
            pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
            task.wait(0.1)
        end
        pcall(function() c:SetAttribute("Crouching", false) end)
        pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", false) end)
        if h then pcall(function() h:ChangeState(Enum.HumanoidStateType.Landed) end) end
        pcall(function()
            local mob = LP:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
            local ctrl = mob and mob:FindFirstChild("Controls")
            local btn = ctrl and ctrl:FindFirstChild("crouch")
            if btn and firesignal then firesignal(btn.MouseButton1Click) end
        end)
    end)
end

local DodgeAttached = {}
local function attachCrouch(kChar)
    if not kChar or DodgeAttached[kChar] then return end
    DodgeAttached[kChar] = true
    local h = kChar:FindFirstChild("Humanoid") or kChar:WaitForChild("Humanoid", 5)
    if not h then return end
    local a = h:FindFirstChildOfClass("Animator") or h:WaitForChild("Animator", 5)
    if not a then return end
    kChar.AncestryChanged:Connect(function(_, p) if not p then DodgeAttached[kChar] = nil end end)
    a.AnimationPlayed:Connect(function(t)
        if not W2.AutoCrouchDodge then return end
        local aid = t.Animation and t.Animation.AnimationId or ""
        if aid:match("%d+") == "80411309607666" then
            local myChar = LP.Character
            if W.IsDowned(myChar) then return end
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kRoot = kChar:FindFirstChild("HumanoidRootPart")
            if myRoot and kRoot then
                if (myRoot.Position - kRoot.Position).Magnitude <= 40 then W.TriggerCrouch() end
            end
        end
    end)
end

local function tryCrouchAttach(p)
    if p ~= LP and p.Team and p.Team.Name == "Killer" and p.Character then
        attachCrouch(p.Character)
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LP then
        p.CharacterAdded:Connect(function() tryCrouchAttach(p) end)
        p:GetPropertyChangedSignal("Team"):Connect(function() tryCrouchAttach(p) end)
        tryCrouchAttach(p)
    end
end
Players.PlayerAdded:Connect(function(p)
    if p ~= LP then
        p.CharacterAdded:Connect(function() tryCrouchAttach(p) end)
        p:GetPropertyChangedSignal("Team"):Connect(function() tryCrouchAttach(p) end)
    end
end)
task.spawn(function()
    while true do
        task.wait(5)
        for _, p in ipairs(Players:GetPlayers()) do tryCrouchAttach(p) end
    end
end)

-- UI Crouch Dodge
W.SurvGB.L7:AddToggle("CrouchDodge_T", {
    Text = "Enable",
    Default = false,
    Callback = function(v)
        W2.AutoCrouchDodge = v
        W.W2_Notify("Crouch Dodge", v and "Enabled" or "Disabled", 2)
    end
})

-- ═══════════════════════════════════════════════════════
-- AUTO FLEE KILLER
-- ═══════════════════════════════════════════════════════
W2.AutoFlee = false
W2.AutoFleeDist = 40
W2.AutoFleeCooldown = 1.5

local lastFlee = 0
task.spawn(function()
    while true do
        task.wait(0.1)
        if W2.AutoFlee and W.GetRole() == "Survivor" then
            local now = tick()
            if now - lastFlee >= (W2.AutoFleeCooldown or 1.5) then
                local c = LP.Character
                local root = c and c:FindFirstChild("HumanoidRootPart")
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if root and h and h.Health > 0 then
                    local kr, nd = nil, math.huge
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LP and W.TeamIs(p, "Killer") and p.Character then
                            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local d = (hrp.Position - root.Position).Magnitude
                                if d < nd then nd = d; kr = hrp end
                            end
                        end
                    end
                    if kr and nd <= (W2.AutoFleeDist or 40) then
                        lastFlee = now
                        local best, bd = nil, 0
                        local map = Workspace:FindFirstChild("Map")
                        if map then
                            for _, obj in ipairs(map:GetDescendants()) do
                                if obj:IsA("BasePart") and obj.Name:match("^GeneratorPoint%d+$") then
                                    local d = (obj.Position - kr.Position).Magnitude
                                    if d > bd then bd = d; best = obj end
                                end
                            end
                        end
                        if best then
                            pcall(function() root.CFrame = best.CFrame + Vector3.new(0, 5, 0) end)
                            W.W2_Notify("Auto Flee", "Teleported away!", 2)
                        end
                    end
                end
            end
        end
    end
end)

-- UI Auto Flee
W.SurvGB.L8:AddToggle("AutoFlee_T", {
    Text = "Enable",
    Default = false,
    Callback = function(v)
        W2.AutoFlee = v
        W.W2_Notify("Auto Flee", v and "Enabled" or "Disabled", 2)
    end
})
W.SurvGB.L8:AddSlider("AutoFleeDist_S", {
    Text = "Detect Distance",
    Min = 15, Max = 150, Default = 40, Rounding = 0, Suffix = " studs",
    Callback = function(v) W2.AutoFleeDist = v end
})
W.SurvGB.L8:AddSlider("AutoFleeCD_S", {
    Text = "Flee Cooldown",
    Min = 0.5, Max = 10, Default = 1.5, Rounding = 1, Suffix = "s",
    Callback = function(v) W2.AutoFleeCooldown = v end
})

-- ═══════════════════════════════════════════════════════
-- NO FALL DAMAGE
-- ═══════════════════════════════════════════════════════
W2.NoFallDamage = false

-- UI No Fall Damage
W.SurvGB.R4:AddToggle("NoFall_T", {
    Text = "Enable No Fall Damage",
    Default = false,
    Callback = function(v)
        W2.NoFallDamage = v
        W.W2_Notify("No Fall Damage", v and "Enabled" or "Disabled", 2)
    end
})

-- ═══════════════════════════════════════════════════════
-- TROLL TELEPORT
-- ═══════════════════════════════════════════════════════
W.TT = W.TT or {
    Enabled = false, Processing = false, Count = 0,
    BlockedAnim = { ["123812278891591"] = 1, ["74099023522626"] = 2 }
}
local TT = W.TT

local function TTHook(char)
    if not char then return end
    local h = char:FindFirstChildOfClass("Humanoid")
    if not h then return end
    local a = h:FindFirstChildOfClass("Animator") or h:WaitForChild("Animator", 3)
    if not a then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    a.AnimationPlayed:Connect(function(t)
        if not TT.Enabled or TT.Processing then return end
        local aid = t.Animation and t.Animation.AnimationId or ""
        local id = aid:match("%d+")
        local delay = id and TT.BlockedAnim[id]
        if not delay then return end
        TT.Processing = true
        TT.Count = TT.Count + 1
        local startCF = root.CFrame
        W.W2_Notify("Troll Teleport", "Trigger #" .. TT.Count, 2)
        task.spawn(function()
            if t.IsPlaying then pcall(function() t.Stopped:Wait() end) end
            task.wait(delay)
            local c = LP.Character
            local rp = c and c:FindFirstChild("HumanoidRootPart")
            if rp and rp.Parent then pcall(function() rp.CFrame = startCF end) end
            TT.Processing = false
        end)
    end)
end

function W.TT_Set(v)
    TT.Enabled = v
    W2.TrollTeleport = v
    if v then
        if TT.Hook then return end
        TT.Processing = false
        TTHook(LP.Character)
        TT.Hook = LP.CharacterAdded:Connect(function(c) task.wait(0.4); TTHook(c) end)
    else
        if TT.Hook then pcall(function() TT.Hook:Disconnect() end); TT.Hook = nil end
        TT.Processing = false
    end
end

-- UI Troll Teleport
W.SurvGB.R5:AddToggle("TrollTP_T", {
    Text = "Enable",
    Default = false,
    Callback = function(v)
        W.TT_Set(v)
        W.W2_Notify("Troll Teleport", v and "Enabled" or "Disabled", 2)
    end
})

-- ═══════════════════════════════════════════════════════
-- GOD MODE
-- ═══════════════════════════════════════════════════════
W2.GodMode = false
local GodThread = nil
function W.God_Set(v)
    W2.GodMode = v
    if GodThread then task.cancel(GodThread); GodThread = nil end
    if v then
        GodThread = task.spawn(function()
            while W2.GodMode do
                local c = LP.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if h and h.Health > 0 and h.Health < h.MaxHealth then
                    pcall(function() h.Health = h.MaxHealth end)
                end
                task.wait(0.1)
            end
        end)
    end
end

-- UI God Mode
W.SurvGB.R6:AddToggle("God_T", {
    Text = "Enable",
    Default = false,
    Callback = function(v)
        W.God_Set(v)
        W.W2_Notify("God Mode", v and "Enabled" or "Disabled", 2)
    end
})

print("[PAZZHUB] PART S5 loaded — Crouch Dodge + Flee + NoFall + God + TrollTP")-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB SURVIVOR | PART S6: Manual Generator + Auto Generator
-- ═══════════════════════════════════════════════════════════════════

-- Buat groupbox baru
W.SurvGB.L9 = W.SurvTab:AddLeftGroupbox("Manual Generator", "wrench")
W.SurvGB.L10 = W.SurvTab:AddLeftGroupbox("Auto Generator", "cpu")

W2.ManualGen = false
W2.AutoGen = false
W2.KillerEscapeDist = 30

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
            if pl ~= LP and W.TeamIs(pl, "Killer") and pl.Character then
                local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - pos).Magnitude <= radius then
                    return true
                end
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
            if pl ~= LP and W.TeamIs(pl, "Killer") and pl.Character then
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
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local bestPt, bestDist = nil, math.huge
        for _, gen in ipairs(W.GB_GetAllGenerators()) do
            if IsGenDone(gen) then continue end
            local genPivot
            pcall(function() genPivot = gen:GetPivot().Position end)
            if genPivot and IsKillerNearPos(genPivot, W2.KillerEscapeDist) then
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
            while W2.ManualGen do
                local myChar = LP.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then task.wait(0.2); continue end

                local _, kd = GetNearestKillerDist()
                if kd <= W2.KillerEscapeDist then
                    if ManualPoint then
                        StopRepair(ManualPoint)
                        ManualPoint = nil
                        W.W2_Notify("Manual Gen", "Killer near — release repair", 2)
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
            while W2.AutoGen do
                local myChar = LP.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then task.wait(0.3); continue end

                local _, kd = GetNearestKillerDist()
                if kd <= W2.KillerEscapeDist then
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

    function W.ManualGen_Set(v)
        W2.ManualGen = v and true or false
        if W2.ManualGen then StartManualThread() else StopManualThread() end
    end

    function W.AutoGen_Set(v)
        W2.AutoGen = v and true or false
        if W2.AutoGen then StartAutoThread() else StopAutoThread() end
    end

    function W.GenAuto_SetDistance(v)
        W2.KillerEscapeDist = tonumber(v) or 30
    end

    LP.CharacterAdded:Connect(function()
        task.wait(1)
        if W2.ManualGen then StartManualThread() end
        if W2.AutoGen then StartAutoThread() end
    end)
end

-- UI Manual Generator
W.SurvGB.L9:AddToggle("ManualGen_T", {
    Text = "Enable Manual Generator",
    Default = false,
    Callback = function(v)
        W.ManualGen_Set(v)
        W.W2_Notify("Manual Gen", v and "Enabled" or "Disabled", 2)
    end
})
W.SurvGB.L9:AddSlider("ManualGenDist_S", {
    Text = "Killer Escape Distance",
    Min = 10, Max = 80, Default = 30, Rounding = 0, Suffix = " studs",
    Callback = function(v) W.GenAuto_SetDistance(v) end
})

-- UI Auto Generator
W.SurvGB.L10:AddToggle("AutoGen_T", {
    Text = "Enable Auto Generator",
    Default = false,
    Callback = function(v)
        W.AutoGen_Set(v)
        W.W2_Notify("Auto Gen", v and "Enabled" or "Disabled", 2)
    end
})

print("[PAZZHUB] PART S6 loaded — Manual Gen + Auto Gen")-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB SURVIVOR | PART S7: Parry V1 + Parry V2 + Fake Parry
-- ═══════════════════════════════════════════════════════════════════

-- Buat groupbox baru
W.SurvGB.L11 = W.SurvTab:AddLeftGroupbox("Auto Parry V1", "sword")
W.SurvGB.L12 = W.SurvTab:AddLeftGroupbox("Auto Parry V2", "sword")
W.SurvGB.R7  = W.SurvTab:AddRightGroupbox("Fake Parry", "sparkles")

-- === Shared: Killer Attack Anims ===
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

-- ═══════════════════════════════════════════════════════
-- PARRY V1
-- ═══════════════════════════════════════════════════════
W2.ParryV1_Enabled    = false
W2.ParryV1_Aggressive = false
W2.ParryV1_Distance   = 10
W2.ParryV1_ShowRange  = false
W2.ParryV1_Silent     = false

do
    local ParryState = {
        LastParry = 0, ActiveAttackers = {},
        CircleFolder = nil, CircleDashes = {}, CircleRotCFs = {}, CircleOffsets = {},
        CircleRadius = 0, CircleSpawnTime = 0, CircleSpawnDuration = 0.55,
    }
    local ParryCooldown = {
        OnCooldown = false, CooldownEnd = 0,
        WaitingForResult = false, WaitingStart = 0, WaitTimeout = 2.0,
        FallbackCooldown = 60, MaxCooldown = 90, LastFiredAt = 0,
        IsSilenced = false, JustFired = false, ManualDetect = false, ManualIgnoreWindow = 0.35
    }
    local parryResultRemote, parryFireRemote
    pcall(function()
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local i = r and r:FindFirstChild("Items")
        local d = i and i:FindFirstChild("Parrying Dagger")
        if d then
            parryResultRemote = d:FindFirstChild("parryResult")
            parryFireRemote = d:FindFirstChild("parry")
        end
    end)

    local function ParryStartCD(d)
        d = math.clamp(tonumber(d) or 0, 0, ParryCooldown.MaxCooldown)
        if d <= 0 then d = ParryCooldown.FallbackCooldown end
        ParryCooldown.OnCooldown = true
        ParryCooldown.CooldownEnd = os.clock() + d
        ParryCooldown.WaitingForResult = false
        ParryCooldown.JustFired = false
        ParryCooldown.ManualDetect = false
    end
    local function ParryClearCD()
        ParryCooldown.OnCooldown = false
        ParryCooldown.CooldownEnd = 0
        ParryCooldown.WaitingForResult = false
        ParryCooldown.JustFired = false
        ParryCooldown.ManualDetect = false
    end
    local function ParryIsCD()
        if not ParryCooldown.OnCooldown then return false end
        if os.clock() >= ParryCooldown.CooldownEnd then ParryClearCD(); return false end
        return true
    end

    if parryResultRemote then
        parryResultRemote.OnClientEvent:Connect(function(success, cd)
            if not ParryCooldown.WaitingForResult and not ParryCooldown.JustFired then return end
            local c = tonumber(cd) or 0
            if success and c > 0 then ParryStartCD(math.min(c, ParryCooldown.MaxCooldown))
            else ParryStartCD(ParryCooldown.FallbackCooldown) end
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

    local PCharCache = { Char=nil, Root=nil, Hum=nil, UpperTorso=nil, CheckInt=nil }
    local function ParryGetChar()
        local char = LP.Character
        if char ~= PCharCache.Char then
            PCharCache.Char = char
            PCharCache.Root = nil; PCharCache.Hum = nil
            PCharCache.UpperTorso = nil; PCharCache.CheckInt = nil
        end
        if not char then return PCharCache end
        if not PCharCache.Root then PCharCache.Root = char:FindFirstChild("HumanoidRootPart") end
        if not PCharCache.Hum then PCharCache.Hum = char:FindFirstChildOfClass("Humanoid") end
        if not PCharCache.UpperTorso then
            PCharCache.UpperTorso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
        end
        if not PCharCache.CheckInt then PCharCache.CheckInt = char:FindFirstChild("CheckInterractable") end
        return PCharCache
    end

    local DaggerCache = { Value = false, LastCheck = 0, Interval = 0.15 }
    local function ParryIsDagger(inst)
        if not inst then return false end
        return inst:IsA("Model") or inst:IsA("Tool") or inst:IsA("Accessory")
    end
    local function ParryHasDagger()
        local now = os.clock()
        if now - DaggerCache.LastCheck < DaggerCache.Interval then return DaggerCache.Value end
        DaggerCache.LastCheck = now
        local has = false
        local c = LP.Character
        if c then
            local d = c:FindFirstChild("Parrying Dagger")
            if ParryIsDagger(d) then has = true end
        end
        if not has then
            local ws = Workspace:FindFirstChild(LP.Name)
            if ws then
                local d = ws:FindFirstChild("Parrying Dagger")
                if ParryIsDagger(d) then has = true end
            end
        end
        DaggerCache.Value = has
        return has
    end
    LP.CharacterAdded:Connect(function() DaggerCache.Value = false; DaggerCache.LastCheck = 0 end)

    local ParryAttrs = {"isVaulting","isSliding","isDroppingPallet","isRepairing","isHealing","isUnhooking","isExiting"}
    local function ParryBusy()
        local cc = ParryGetChar()
        if not cc.Char then return true end
        if LP:GetAttribute("IsDead") then return true end
        if cc.Char:GetAttribute("IsCarried") then return true end
        if cc.Char:GetAttribute("IsHooked") then return true end
        if cc.Root and CollectionService:HasTag(cc.Root, "doing action") then return true end
        if cc.CheckInt then
            for i = 1, #ParryAttrs do
                if cc.CheckInt:GetAttribute(ParryAttrs[i]) then return true end
            end
        end
        return false
    end
    local function ParryLowHP()
        local h = ParryGetChar().Hum
        if not h then return false end
        return h.Health < h.MaxHealth * 0.5
    end
    local function ParryCanFire()
        if not ParryHasDagger() then return false end
        if ParryCooldown.IsSilenced then return false end
        if ParryIsCD() then return false end
        if ParryCooldown.WaitingForResult then return false end
        if ParryBusy() then return false end
        if ParryLowHP() then return false end
        return true
    end

    local function ParryMobile()
        local didFire = false
        local pg = LP:FindFirstChildOfClass("PlayerGui")
        if pg and type(firesignal) == "function" then
            local mob = pg:FindFirstChild("Survivor-mob")
            local ctrl = mob and mob:FindFirstChild("Controls")
            if ctrl then
                for _, n in ipairs({"Gui-mob","action","Gui-mobile","Gui_mob","Parry","parry"}) do
                    local b = ctrl:FindFirstChild(n)
                    if b and b:IsA("GuiButton") then
                        pcall(function()
                            firesignal(b.MouseButton1Down)
                            task.delay(0.05, function()
                                if b and b.Parent then
                                    firesignal(b.MouseButton1Up)
                                    firesignal(b.MouseButton1Click)
                                end
                            end)
                        end)
                        didFire = true; break
                    end
                end
            end
        end
        if not didFire then
            local r = ReplicatedStorage:FindFirstChild("Remotes")
            local i = r and r:FindFirstChild("Items")
            local d = i and i:FindFirstChild("Parrying Dagger")
            local p = d and d:FindFirstChild("parry")
            if p then pcall(function() p:FireServer() end) end
        end
    end

    local function ParryPC()
        if not VIM then return end
        pcall(function()
            VIM:SendMouseMoveEvent(0, 0, game)
            task.wait(0.005)
            VIM:SendMouseButtonEvent(0, 0, 2, true, game, 0)
            task.wait(0.05)
            VIM:SendMouseButtonEvent(0, 0, 2, false, game, 0)
        end)
    end

    local function ParrySilent()
        if parryFireRemote then return pcall(function() parryFireRemote:FireServer() end) end
        return false
    end

    local function ParryFire()
        if not ParryCanFire() then return end
        ParryState.LastParry = os.clock()
        ParryCooldown.LastFiredAt = os.clock()
        ParryCooldown.WaitingForResult = true
        ParryCooldown.WaitingStart = os.clock()
        ParryCooldown.JustFired = true
        ParryCooldown.ManualDetect = false
        if W2.ParryV1_Silent then ParrySilent(); return end
        if isMobile then ParryMobile() else ParryPC() end
    end

    local function ParryMarkManual()
        if not ParryHasDagger() then return end
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

    local function ParryHitbox(char)
        if not char then return nil end
        return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    end

    local function ParryCheck(kChar)
        if ParryIsCD() or ParryCooldown.WaitingForResult
            or ParryCooldown.IsSilenced or not ParryHasDagger() then return end
        local cc = ParryGetChar()
        local myRoot = cc.UpperTorso or cc.Root
        local kPart = ParryHitbox(kChar)
        if not myRoot or not kPart then return end
        local dist = (myRoot.Position - kPart.Position).Magnitude
        if W2.ParryV1_Aggressive then
            local ping = math.clamp(LP:GetNetworkPing(), 0, 0.3)
            local kRoot = kChar:FindFirstChild("HumanoidRootPart") or kPart
            local kVel = kRoot.AssemblyLinearVelocity
            local flatVel = Vector3.new(kVel.X, 0, kVel.Z)
            local pred = kPart.Position + flatVel * ping
            if (myRoot.Position - pred).Magnitude <= ((W2.ParryV1_Distance or 10) + 2.5) then
                if flatVel.Magnitude > 6 then
                    local dir = myRoot.Position - kPart.Position
                    if dir.Magnitude > 0 and flatVel.Unit:Dot(dir.Unit) > 0.4 then ParryFire(); return end
                end
            end
        end
        if dist <= (W2.ParryV1_Distance or 10) then ParryFire() end
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
        ParryState.CircleSpawnTime = 0
    end
    getgenv()._Pazz_DestroyParryCircle = ParryDestroyCircle

    local function ParryBuildCircle(radius)
        ParryDestroyCircle()
        local folder = Instance.new("Folder")
        folder.Name = "PazzParryCircleDashes"
        local dashCount = math.clamp(math.floor(radius * 6), 24, 120)
        local slotLen = (2 * math.pi * radius) / dashCount
        local dashLen = slotLen * 0.55
        local thickness = 0.03
        local dashes, rotCFs, offsets = {}, {}, {}
        for i = 1, dashCount do
            local part = Instance.new("Part")
            part.Name = "Dash" .. i
            part.Anchored = true; part.CanCollide = false
            part.CanTouch = false; part.CanQuery = false; part.CastShadow = false
            part.Material = Enum.Material.Neon
            part.Color = Color3.fromRGB(255, 255, 255)
            part.Transparency = 1
            part.Size = Vector3.new(thickness, thickness, dashLen)
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
        ParryState.CircleSpawnTime = tick()
    end

    local function ParryUpdateCircle(myRoot)
        if not ParryState.CircleFolder or not ParryState.CircleFolder.Parent then return end
        local dashes = ParryState.CircleDashes
        local dc = #dashes
        if dc == 0 then return end
        local center = myRoot.Position - Vector3.new(0, (myRoot.Size.Y * 0.5) + 1.0, 0)
        local el = tick() - (ParryState.CircleSpawnTime or 0)
        local spawnT = math.clamp(el / (ParryState.CircleSpawnDuration or 0.55), 0, 1)
        local eased = 1 - (1 - spawnT)^3
        local scaleMult = eased
        if spawnT < 0.7 and spawnT > 0 then
            local bt = spawnT / 0.7
            scaleMult = eased + math.sin(bt * math.pi) * 0.1
        end
        local spinRot = (1 - eased) * math.pi * 2
        local spawnAlpha = 1 - eased
        local busy = ParryBusy()
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
        local rotCFs = ParryState.CircleRotCFs
        local offsets = ParryState.CircleOffsets
        local rotCF = CFrame.Angles(0, spinRot, 0)
        for i = 1, dc do
            local dash = dashes[i]
            if dash and dash.Parent then
                local scaled = offsets[i] * scaleMult
                local rotated = rotCF:VectorToWorldSpace(scaled)
                local wp = Vector3.new(center.X + rotated.X, center.Y, center.Z + rotated.Z)
                dash.CFrame = (rotCF * rotCFs[i]) + wp
                dash.Color = tc
                dash.Transparency = finalT
            end
        end
    end

    local function ParryAnimType(track)
        if not track or not track.Animation then return nil end
        local aid = track.Animation.AnimationId or ""
        local nid = aid:match("%d+") or ""
        local name = string.lower(track.Animation.Name or "")
        local v = KillerAttackAnims[aid]
        if v then return v end
        if nid ~= "" then v = KillerAttackAnims[nid]; if v then return v end end
        if name:find("lunge") or name:find("charge") then return "lungehold" end
        if name:find("attack") or name:find("slash") or name:find("swing")
            or name:find("stab") or name:find("melee") then return "attack" end
        return nil
    end

    local function ParryHookAnim(plr, char)
        if not char then return end
        local h = char:FindFirstChildOfClass("Humanoid")
        if not h then return end
        local a = h:FindFirstChildOfClass("Animator") or h:WaitForChild("Animator", 3)
        if not a then return end
        a.AnimationPlayed:Connect(function(t)
            if not W2.ParryV1_Enabled then return end
            if not ParryHasDagger() then return end
            local at = ParryAnimType(t)
            if at then
                ParryState.ActiveAttackers[plr] = { char = char, track = t, type = at, registeredAt = os.clock() }
            end
        end)
    end

    local function ParryHookKiller(plr)
        if plr == LP then return end
        if plr.Character then ParryHookAnim(plr, plr.Character) end
        plr.CharacterAdded:Connect(function(c) task.wait(0.5); ParryHookAnim(plr, c) end)
    end
    for _, p in ipairs(Players:GetPlayers()) do ParryHookKiller(p) end
    Players.PlayerAdded:Connect(ParryHookKiller)

    local parryLastPoll, parryLastCleanup = 0, 0
    local function ParryPollAttacks()
        if not W2.ParryV1_Enabled or not ParryHasDagger() then return end
        local now = os.clock()
        if now - parryLastPoll < 0.15 then return end
        parryLastPoll = now
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP then
                local c = plr.Character
                if c then
                    local h = c:FindFirstChildOfClass("Humanoid")
                    if h then
                        for _, t in ipairs(h:GetPlayingAnimationTracks()) do
                            local at = ParryAnimType(t)
                            if at then
                                local ex = ParryState.ActiveAttackers[plr]
                                if not ex or ex.track ~= t then
                                    ParryState.ActiveAttackers[plr] = { char = c, track = t, type = at, registeredAt = now }
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    local function ParryCleanup()
        local now = os.clock()
        if now - parryLastCleanup < 1.0 then return end
        parryLastCleanup = now
        for plr, data in pairs(ParryState.ActiveAttackers) do
            if not plr or not plr.Parent or not data.track or not data.track.IsPlaying then
                ParryState.ActiveAttackers[plr] = nil
            end
        end
    end

    local function ParryUpdate()
        if not W2.ParryV1_Enabled then return end
        if not ParryHasDagger() then ParryState.ActiveAttackers = {}; return end
        if ParryCooldown.WaitingForResult then
            if os.clock() - ParryCooldown.WaitingStart > ParryCooldown.WaitTimeout then
                if ParryCooldown.ManualDetect then
                    ParryCooldown.WaitingForResult = false
                    ParryCooldown.JustFired = false
                    ParryCooldown.ManualDetect = false
                else
                    ParryStartCD(ParryCooldown.FallbackCooldown)
                end
            end
        end
        if ParryIsCD() or ParryCooldown.WaitingForResult then return end
        ParryPollAttacks()
        ParryCleanup()
        for plr, data in pairs(ParryState.ActiveAttackers) do
            if plr and plr.Parent and data.track and data.track.IsPlaying then
                local check = false
                if data.type == "attack" then
                    if data.track.TimePosition < 0.35 then check = true end
                elseif data.type == "lungehold" then
                    check = true
                end
                if check then
                    ParryCheck(data.char)
                    if ParryCooldown.WaitingForResult then break end
                end
            else
                ParryState.ActiveAttackers[plr] = nil
            end
        end
    end

    local function ParryCircleUpdate()
        local c = LP.Character
        local root = c and c:FindFirstChild("HumanoidRootPart")
        if W2.ParryV1_ShowRange and W2.ParryV1_Enabled and ParryHasDagger() and root then
            if not ParryState.CircleFolder or ParryState.CircleRadius ~= (W2.ParryV1_Distance or 10) or not ParryState.CircleFolder.Parent then
                ParryBuildCircle(W2.ParryV1_Distance or 10)
            end
            ParryUpdateCircle(root)
        else
            if ParryState.CircleFolder then ParryDestroyCircle() end
        end
    end

    local lastLogic, lastCircle = 0, 0
    RunService.Heartbeat:Connect(function()
        local now = os.clock()
        if now - lastCircle >= 0.033 then lastCircle = now; pcall(ParryCircleUpdate) end
        if now - lastLogic >= 0.05 then lastLogic = now; pcall(ParryUpdate) end
    end)
end

-- UI Parry V1
W.SurvGB.L11:AddToggle("ParryV1_T", {
    Text = "Enable",
    Default = false,
    Callback = function(v)
        W2.ParryV1_Enabled = v
        if not v and getgenv()._Pazz_DestroyParryCircle then pcall(getgenv()._Pazz_DestroyParryCircle) end
        W.W2_Notify("Parry V1", v and "Enabled" or "Disabled", 2)
    end
})
W.SurvGB.L11:AddToggle("ParryV1Agg_T", {
    Text = "Aggressive",
    Default = false,
    Callback = function(v) W2.ParryV1_Aggressive = v end
})
W.SurvGB.L11:AddSlider("ParryV1Dist_S", {
    Text = "Distance",
    Min = 4, Max = 30, Default = 10, Rounding = 0, Suffix = " studs",
    Callback = function(v) W2.ParryV1_Distance = v end
})
W.SurvGB.L11:AddToggle("ParryV1Range_T", {
    Text = "Show Range",
    Default = false,
    Callback = function(v)
        W2.ParryV1_ShowRange = v
        if not v and getgenv()._Pazz_DestroyParryCircle then pcall(getgenv()._Pazz_DestroyParryCircle) end
    end
})
W.SurvGB.L11:AddToggle("ParryV1Silent_T", {
    Text = "Silent Parry",
    Default = false,
    Callback = function(v) W2.ParryV1_Silent = v end
})

-- ═══════════════════════════════════════════════════════
-- PARRY V2
-- ═══════════════════════════════════════════════════════
W2.ParryV2_Enabled    = false
W2.ParryV2_Aggressive = false
W2.ParryV2_Safety     = false
W2.ParryV2_Distance   = 6
W2.ParryV2_Face       = 0.7
W2.ParryV2_ShowCircle = true

do
    local ValidIDs = {
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
    local State = { CD = false, CDThread = nil, Adornment = nil }
    local Attached = {}

    local function isKiller(p) return p and p.Team and p.Team.Name == "Killer" end
    local function isDowned(c) return c and (c:GetAttribute("Knocked") == true or c:GetAttribute("IsHooked") == true) end
    local function isSafe(c)
        if not W2.ParryV2_Safety then return true end
        if not c then return false end
        local ci = c:FindFirstChild("CheckInterractable")
        if ci then
            if ci:GetAttribute("isVaulting") then return false end
            if ci:GetAttribute("isRepairing") then return false end
            if ci:GetAttribute("isUnhooking") then return false end
            if ci:GetAttribute("isHealing") then return false end
            if ci:GetAttribute("isSliding") then return false end
        end
        return true
    end

    local function pressRC()
        if not VIM then return end
        pcall(function()
            VIM:SendMouseButtonEvent(0, 0, 1, true, game, 0)
            task.wait()
            VIM:SendMouseButtonEvent(0, 0, 1, false, game, 0)
        end)
    end

    local function tapMobile()
        local pg = LP:FindFirstChild("PlayerGui")
        if not pg then return end
        local mob = pg:FindFirstChild("Survivor-mob")
        local btn = mob and mob:FindFirstChild("Controls") and mob.Controls:FindFirstChild("Gui-mob")
        if btn and btn.Visible then
            if firesignal then pcall(function()
                firesignal(btn.MouseButton1Down)
                task.wait(0.01)
                firesignal(btn.MouseButton1Up)
            end) end
        else
            pressRC()
        end
    end

    local function execute()
        if State.CD then return end
        pcall(function()
            local p = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Items"):FindFirstChild("Parrying Dagger"):FindFirstChild("parry")
            if p then for i = 1, 10 do p:FireServer() end end
            task.spawn(tapMobile)
        end)
    end

    task.spawn(function()
        local r = ReplicatedStorage:WaitForChild("Remotes", 5)
        local d = r and r:WaitForChild("Items", 5):WaitForChild("Parrying Dagger", 5)
        local pr = d and d:WaitForChild("parryResult", 5)
        if pr then
            pr.OnClientEvent:Connect(function(a, b)
                local cdDur = tonumber(b) or ((a == true) and 90 or 60)
                State.CD = true
                if State.CDThread then task.cancel(State.CDThread) end
                State.CDThread = task.delay(cdDur, function() State.CD = false end)
            end)
        end
    end)

    local function attach(kChar)
        if not kChar or Attached[kChar] then return end
        Attached[kChar] = true
        local h = kChar:FindFirstChild("Humanoid") or kChar:WaitForChild("Humanoid", 5)
        if not h then return end
        local a = h:FindFirstChildOfClass("Animator") or h:WaitForChild("Animator", 5)
        if not a then return end
        kChar.AncestryChanged:Connect(function(_, p) if not p then Attached[kChar] = nil end end)
        a.AnimationPlayed:Connect(function(t)
            local aid = t.Animation and t.Animation.AnimationId or ""
            local id = aid:match("%d+")
            local nm = ValidIDs[id]
            if not nm then return end
            if not W2.ParryV2_Enabled then return end
            if State.CD then return end
            local myChar = LP.Character
            if isDowned(myChar) or not isSafe(myChar) then return end
            local myR = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kR = kChar:FindFirstChild("HumanoidRootPart")
            if not myR or not kR then return end
            local dist = (myR.Position - kR.Position).Magnitude
            if W2.ParryV2_Aggressive then
                local agg = 12
                local det = W2.ParryV2_Distance + 5
                if dist > det then return end
                if dist <= agg then
                    execute()
                else
                    local tracker
                    local st = os.clock()
                    tracker = RunService.Heartbeat:Connect(function()
                        if os.clock() - st >= 1.5 or State.CD or not myR or not kR or isDowned(myChar) then
                            if tracker then tracker:Disconnect() end
                            return
                        end
                        if (myR.Position - kR.Position).Magnitude <= agg then
                            execute()
                            if tracker then tracker:Disconnect() end
                        end
                    end)
                end
            else
                if dist > W2.ParryV2_Distance then return end
                local mf = Vector3.new(myR.Position.X, 0, myR.Position.Z)
                local kf = Vector3.new(kR.Position.X, 0, kR.Position.Z)
                local fd = mf - kf
                if fd.Magnitude > 0 then
                    local fdu = fd.Unit
                    local kl = Vector3.new(kR.CFrame.LookVector.X, 0, kR.CFrame.LookVector.Z).Unit
                    if kl:Dot(fdu) < W2.ParryV2_Face then return end
                end
                execute()
            end
        end)
    end

    local function tryAttach(p)
        if p ~= LP and isKiller(p) and p.Character then attach(p.Character) end
    end

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            p.CharacterAdded:Connect(function() tryAttach(p) end)
            p:GetPropertyChangedSignal("Team"):Connect(function() tryAttach(p) end)
            tryAttach(p)
        end
    end
    Players.PlayerAdded:Connect(function(p)
        if p ~= LP then
            p.CharacterAdded:Connect(function() tryAttach(p) end)
            p:GetPropertyChangedSignal("Team"):Connect(function() tryAttach(p) end)
        end
    end)
    task.spawn(function()
        while true do
            task.wait(5)
            for _, p in ipairs(Players:GetPlayers()) do tryAttach(p) end
        end
    end)

    RunService.Heartbeat:Connect(function()
        local c = LP.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if W2.ParryV2_ShowCircle and W2.ParryV2_Enabled and hrp then
            if not State.Adornment or State.Adornment.Parent ~= hrp then
                if State.Adornment then State.Adornment:Destroy() end
                State.Adornment = Instance.new("CylinderHandleAdornment")
                State.Adornment.Name = "PazzParryV2Circle"
                State.Adornment.Height = 0.05
                State.Adornment.Transparency = 0.3
                State.Adornment.Adornee = hrp
                State.Adornment.Parent = hrp
                State.Adornment.ZIndex = 0
                State.Adornment.AlwaysOnTop = false
            end
            local r = W2.ParryV2_Distance
            State.Adornment.Radius = r
            State.Adornment.InnerRadius = math.max(0.1, r - 0.15)
            State.Adornment.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(90), 0, 0)
            State.Adornment.Color3 = State.CD and Color3.fromRGB(128,128,128) or Color3.fromRGB(255,255,255)
        elseif State.Adornment then
            State.Adornment:Destroy()
            State.Adornment = nil
        end
    end)
end

-- UI Parry V2
W.SurvGB.L12:AddToggle("ParryV2_T", {
    Text = "Enable",
    Default = false,
    Callback = function(v)
        W2.ParryV2_Enabled = v
        W.W2_Notify("Parry V2", v and "Enabled" or "Disabled", 2)
    end
})
W.SurvGB.L12:AddToggle("ParryV2Agg_T", {
    Text = "Aggressive",
    Default = false,
    Callback = function(v) W2.ParryV2_Aggressive = v end
})
W.SurvGB.L12:AddToggle("ParryV2Safe_T", {
    Text = "Safety",
    Default = false,
    Callback = function(v) W2.ParryV2_Safety = v end
})
W.SurvGB.L12:AddSlider("ParryV2Dist_S", {
    Text = "Distance",
    Min = 4, Max = 25, Default = 6, Rounding = 0, Suffix = " studs",
    Callback = function(v) W2.ParryV2_Distance = v end
})
W.SurvGB.L12:AddSlider("ParryV2Face_S", {
    Text = "Face Sensitivity",
    Min = -1, Max = 1, Default = 0.7, Rounding = 2,
    Callback = function(v) W2.ParryV2_Face = v end
})
W.SurvGB.L12:AddToggle("ParryV2Circle_T", {
    Text = "Show Circle",
    Default = true,
    Callback = function(v) W2.ParryV2_ShowCircle = v end
})

-- ═══════════════════════════════════════════════════════
-- FAKE PARRY
-- ═══════════════════════════════════════════════════════
W2.SURV_FakeParry         = false
W2.SURV_FakeParryAnim     = "Enten"
W2.SURV_FakeParryCooldown = 0.4
W2.SURV_FakeParryKey      = "V"
W2.SURV_FakeParryShowBtn  = false
W2.SURV_FakeParryLocked   = false

do
    local FakeParryTrack = nil
    local FakeParryLast  = 0
    local FakeParryButtonGui = nil

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
        if not W2.SURV_FakeParry then return end
        if W.GetRole() ~= "Survivor" then return end
        local now = tick()
        if now - FakeParryLast < (tonumber(W2.SURV_FakeParryCooldown) or 0.4) then return end
        FakeParryLast = now

        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local animator = hum:FindFirstChildOfClass("Animator")
        if not animator then
            animator = Instance.new("Animator")
            animator.Parent = hum
        end

        FakeParry_Stop()
        local animId = FakeParryAnims[W2.SURV_FakeParryAnim] or FakeParryAnims["Enten"]
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
        local pg = LP:FindFirstChild("PlayerGui")
        if not pg then return end

        local sg = Instance.new("ScreenGui")
        sg.Name = "PazzFakeParryBtn"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.DisplayOrder = 100
        sg.Parent = pg

        local btn = Instance.new("TextButton")
        btn.Name = "FakeParryBtn"
        btn.Size = UDim2.fromOffset(64, 64)
        btn.Position = UDim2.new(0.82, 0, 0.62, 0)
        btn.AnchorPoint = Vector2.new(0.5, 0.5)
        btn.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
        btn.BackgroundTransparency = 0.15
        btn.Text = "FAKE\nPARRY"
        btn.TextColor3 = Color3.fromRGB(0, 170, 255)
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamBold
        btn.ZIndex = 10
        btn.Parent = sg
        Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(0, 170, 255)
        stroke.Thickness = 2
        stroke.Transparency = 0.2

        local lockBtn = Instance.new("TextButton")
        lockBtn.Size = UDim2.new(0, 22, 0, 22)
        lockBtn.Position = UDim2.new(1, -5, 0, -5)
        lockBtn.AnchorPoint = Vector2.new(1, 0)
        lockBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        lockBtn.BackgroundTransparency = 0.3
        lockBtn.Text = W2.SURV_FakeParryLocked and "X" or "L"
        lockBtn.TextSize = 10
        lockBtn.Font = Enum.Font.GothamBold
        lockBtn.TextColor3 = Color3.new(1, 1, 1)
        lockBtn.ZIndex = 11
        lockBtn.Parent = btn
        Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(1, 0)

        lockBtn.MouseButton1Click:Connect(function()
            W2.SURV_FakeParryLocked = not W2.SURV_FakeParryLocked
            lockBtn.Text = W2.SURV_FakeParryLocked and "X" or "L"
            lockBtn.BackgroundColor3 = W2.SURV_FakeParryLocked and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(60, 60, 60)
        end)

        local dragging, dragStart, startPos = false, nil, nil
        local moved = false
        btn.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                if W2.SURV_FakeParryLocked then return end
                dragging = true; moved = false
                dragStart = inp.Position
                startPos = btn.Position
            end
        end)
        btn.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                if dragging and not moved then FakeParry_Play() end
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if not dragging or W2.SURV_FakeParryLocked then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                local d = inp.Position - dragStart
                if math.abs(d.X) + math.abs(d.Y) > 6 then moved = true end
                btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)

        FakeParryButtonGui = sg
    end

    local function FakeParry_RemoveButton()
        if FakeParryButtonGui then
            pcall(function() FakeParryButtonGui:Destroy() end)
            FakeParryButtonGui = nil
        end
    end

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        local kc = Enum.KeyCode[W2.SURV_FakeParryKey or "V"]
        if kc and input.KeyCode == kc then FakeParry_Play() end
    end)

    task.spawn(function()
        local pg = LP:FindFirstChild("PlayerGui")
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

    LP.CharacterAdded:Connect(function()
        task.wait(0.5)
        if W2.SURV_FakeParryShowBtn and W2.SURV_FakeParry then
            FakeParry_RemoveButton()
            FakeParry_CreateButton()
        end
    end)

    function W.FakeParry_SetEnabled(v)
        W2.SURV_FakeParry = v and true or false
        if not v then FakeParry_Stop() end
        if v and UserInputService.TouchEnabled and W2.SURV_FakeParryShowBtn then
            FakeParry_CreateButton()
        end
    end
    function W.FakeParry_SetAnim(name)
        if name and FakeParryAnims[name] then W2.SURV_FakeParryAnim = name
        else W2.SURV_FakeParryAnim = "Enten" end
    end
    function W.FakeParry_Trigger() FakeParry_Play() end
    function W.FakeParry_SetShowButton(v)
        W2.SURV_FakeParryShowBtn = v and true or false
        if v then FakeParry_CreateButton() else FakeParry_RemoveButton() end
    end
    function W.FakeParry_SetKeybind(name)
        local ok, kc = pcall(function() return Enum.KeyCode[tostring(name):upper()] end)
        if ok and kc then W2.SURV_FakeParryKey = kc.Name; return true end
        return false
    end
end

-- UI Fake Parry
W.SurvGB.R7:AddToggle("FakeParry_T", {
    Text = "Enable Fake Parry",
    Default = false,
    Callback = function(v)
        W.FakeParry_SetEnabled(v)
        W.W2_Notify("Fake Parry", v and ("Enabled — Key: " .. (W2.SURV_FakeParryKey or "V")) or "Disabled", 2)
    end
})
W.SurvGB.R7:AddDropdown("FakeParryAnim_D", {
    Text = "Animation",
    Values = {"Enten","Stopwatch","Fih","BloodShield"},
    Default = "Enten",
    Callback = function(v) W.FakeParry_SetAnim(v) end
})
W.SurvGB.R7:AddInput("FakeParryKey_I", {
    Text = "Keybind",
    Default = "V",
    Placeholder = "V / G / F / X / B",
    Callback = function(input)
        input = tostring(input or ""):gsub("%s+", "")
        if input == "" then return end
        W.FakeParry_SetKeybind(input)
    end
})
W.SurvGB.R7:AddSlider("FakeParryCD_S", {
    Text = "Cooldown",
    Min = 0, Max = 3, Default = 0.4, Rounding = 1, Suffix = "s",
    Callback = function(v) W2.SURV_FakeParryCooldown = v end
})
W.SurvGB.R7:AddToggle("FakeParryBtn_T", {
    Text = "Show Floating Button",
    Default = false,
    Callback = function(v) W.FakeParry_SetShowButton(v) end
})
W.SurvGB.R7:AddButton({
    Text = "Test Fake Parry Now",
    Func = function()
        W.FakeParry_Trigger()
        W.Notify("Fake Parry", "Playing...", 2)
    end
})

print("[PAZZHUB] PART S7 loaded — Parry V1 + V2 + Fake Parry")
print("═══════════════════════════════════════════")
print("[PAZZHUB] SURVIVOR TAB SELESAI! ✅")
print("═══════════════════════════════════════════")
