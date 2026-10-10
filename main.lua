-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB — SURVIVOR TAB (ALFzxzzz Fusion)
--  Logo: 72845574620852
--  Tema: Biru Neon · Compact Layout
--  CornerRadius: 20
-- ═══════════════════════════════════════════════════════════════════

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

-- ═══════════════ SERVICES ═══════════════
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local CoreGui           = game:GetService("CoreGui")
local CollectionService = game:GetService("CollectionService")
local TweenService      = game:GetService("TweenService")
local LP                = Players.LocalPlayer
local VIM               = game:GetService("VirtualInputManager")
local isMobile          = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ═══════════════ NOTIFY HELPER ═══════════════
local function Notify(title, content, dur)
    pcall(function()
        Library:Notify({
            Title = title or "PazzHub",
            Content = content or "",
            Duration = dur or 2
        })
    end)
end

-- ═══════════════ TEAM HELPER ═══════════════
local function TeamIs(plr, role)
    if not plr or not plr.Team or not plr.Team.Name then return false end
    local tn = string.lower(plr.Team.Name)
    if role == "Killer"   then return tn:find("killer",   1, true) ~= nil end
    if role == "Survivor" then return tn:find("survivor", 1, true) ~= nil end
    return false
end

local function GetRole()
    if TeamIs(LP, "Killer")   then return "Killer"   end
    if TeamIs(LP, "Survivor") then return "Survivor" end
    return nil
end

-- ═══════════════ GENERATOR HELPERS ═══════════════
local function GB_GetAllGenerators()
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
local function GB_GetPoints(m)
    local pts = {}
    if not m then return pts end
    for _, o in ipairs(m:GetChildren()) do
        if o:IsA("BasePart") and o.Name:find("GeneratorPoint") then
            table.insert(pts, o)
        end
    end
    return pts
end

-- ═══════════════════════════════════════════════════════════════════
--                    FLOATING TOGGLE
-- ═══════════════════════════════════════════════════════════════════
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

    MainButton.MouseEnter:Connect(function()
        TweenService:Create(MainButton, TweenInfo.new(.15), { BackgroundColor3 = Color3.fromRGB(16, 24, 42) }):Play()
        TweenService:Create(Glow, TweenInfo.new(.15), { Transparency = 0.3 }):Play()
    end)
    MainButton.MouseLeave:Connect(function()
        TweenService:Create(MainButton, TweenInfo.new(.15), { BackgroundColor3 = Color3.fromRGB(8, 14, 26) }):Play()
        TweenService:Create(Glow, TweenInfo.new(.15), { Transparency = 0.6 }):Play()
    end)
    MainButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainButton, TweenInfo.new(.08), { Size = UDim2.fromOffset(36, 36) }):Play()
        task.wait(.08)
        TweenService:Create(MainButton, TweenInfo.new(.08), { Size = UDim2.fromOffset(42, 42) }):Play()
        Library:Toggle()
    end)

    Library:MakeDraggable(MainButton, MainButton, true)
end
CreatePazzToggle(TOGGLE_ICON)

-- ═══════════════ WINDOW ═══════════════
local Window = Library:CreateWindow({
    Title = "PAZZHUB",
    Footer = "PazzHub x ALFzxzzz",
    Icon = TOGGLE_ICON,
    IconSize = UDim2.fromOffset(34, 34),
    CornerRadius = 20,
    NotifySide = "Right",
    ShowCustomCursor = true,
    ShowMobileButtons = false,
    ToggleKeybind = Enum.KeyCode.LeftControl,
    Size = UDim2.fromOffset(500, 320),
    EnableSidebarResize = false,
    EnableCompacting = true,
    SidebarCompacted = false,
})

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
end)

-- ═══════════════ THEME & SAVE ═══════════════
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
ThemeManager:SetFolder("PazzHub")
SaveManager:SetFolder("PazzHub/configs")

-- ═══════════════ TABS ═══════════════
local SurvTab = Window:CreateTab("Survivor", 4483362458)
local VisTab  = Window:CreateTab("Visuals", 4483362458)
local KillTab = Window:CreateTab("Killer", 4483362458)

-- ═══════════════════════════════════════════════════════════════════
--                    SURVIVOR TAB
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════ SELF HEAL ═══════════════
local SelfHealSection = SurvTab:CreateSection("Self Heal")

local SelfHeal_Enabled = false
local SelfHeal_BlockedAnim = "95836365038528"

local function HealSelf(v)
    local c = LP.Character
    if not c then return end
    local ev = ReplicatedStorage.Remotes.Healing.HealEvent
    local hp = c:FindFirstChild("HumanoidRootPart")
    if not hp then return end
    pcall(function() ev:FireServer(hp, v) end)
end
local function HealOther(p, v)
    if not p or not p.Character then return end
    local hp = p.Character:FindFirstChild("HumanoidRootPart")
    if not hp then return end
    local ev = ReplicatedStorage.Remotes.Healing.HealEvent
    pcall(function() ev:FireServer(hp, v) end)
end

local _SelfHealConn, _SelfHealLoop, _AutoHealLoop

local function setSelfHeal(v)
    SelfHeal_Enabled = v
    if _SelfHealConn then _SelfHealConn:Disconnect(); _SelfHealConn = nil end
    if v then
        _SelfHealConn = RunService.Heartbeat:Connect(function()
            if not SelfHeal_Enabled then return end
            local c = LP.Character
            if not c then return end
            local h = c:FindFirstChildOfClass("Humanoid")
            if not h then return end
            local a = h:FindFirstChildOfClass("Animator")
            if not a then return end
            local ok, tracks = pcall(function() return a:GetPlayingAnimationTracks() end)
            if not ok then return end
            for _, t in ipairs(tracks) do
                local aid = t.Animation and t.Animation.AnimationId or ""
                if aid:match("%d+") == SelfHeal_BlockedAnim then
                    pcall(function() t:Stop(0) end)
                end
            end
        end)
        local ha = false
        if _SelfHealLoop then _SelfHealLoop:Disconnect() end
        _SelfHealLoop = RunService.Heartbeat:Connect(function()
            if not SelfHeal_Enabled then return end
            local c = LP.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not h then return end
            if h.Health >= h.MaxHealth * 0.9 then
                if ha then ha = false; HealSelf(false) end
                return
            end
            if ha then
                local ci = c:FindFirstChild("CheckInterractable")
                if ci and not ci:GetAttribute("isHealing") then ha = false end
            end
            if not ha then ha = true; HealSelf(true) end
        end)
    else
        if _SelfHealLoop then _SelfHealLoop:Disconnect(); _SelfHealLoop = nil end
        pcall(function() HealSelf(false) end)
    end
end

local function setAutoHealAll(v)
    if _AutoHealLoop then _AutoHealLoop:Disconnect(); _AutoHealLoop = nil end
    if v then
        local ah = {}
        _AutoHealLoop = RunService.Heartbeat:Connect(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    local hu = p.Character:FindFirstChildOfClass("Humanoid")
                    if hu and hu.Health > 0 and hu.Health < hu.MaxHealth * 0.9 then
                        if not ah[p] then ah[p] = true; HealOther(p, true) end
                    else
                        if ah[p] then ah[p] = nil; HealOther(p, false) end
                    end
                end
            end
        end)
    end
end

LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if SelfHeal_Enabled then setSelfHeal(true) end
end)

SelfHealSection:CreateToggle({
    Name = "Enable Self Heal",
    CurrentValue = false,
    Flag = "SelfHeal_Toggle",
    Callback = function(v)
        setSelfHeal(v)
        Notify("Self Heal", v and "Enabled" or "Disabled", 2)
    end,
})
SelfHealSection:CreateToggle({
    Name = "Auto Heal All",
    CurrentValue = false,
    Flag = "AutoHealAll_Toggle",
    Callback = function(v)
        setAutoHealAll(v)
        Notify("Auto Heal All", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ SWIFT VAULT ═══════════════
local SwiftVaultSection = SurvTab:CreateSection("Swift Vault")

local SwiftVault_Enabled = false
local SwiftVault_V2      = false
local SwiftVault_Speed   = 13

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
        if SwiftVault_V2 then
            pcall(function()
                local c = LP.Character
                if c then c:SetAttribute("vaultspeed", (SwiftVault_Speed or 13) / 10) end
            end)
        end
    end)
    RunService.Heartbeat:Connect(function()
        if not SwiftVault_Enabled then return end
        if GetRole() ~= "Survivor" then return end
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

    SwiftVaultSection:CreateToggle({
        Name = "Swift Vault",
        CurrentValue = false,
        Flag = "SwiftVault_Toggle",
        Callback = function(v)
            SwiftVault_Enabled = v
            Notify("Swift Vault", v and "Enabled" or "Disabled", 2)
        end,
    })
    SwiftVaultSection:CreateToggle({
        Name = "Swift Vault V2",
        CurrentValue = false,
        Flag = "SwiftVaultV2_Toggle",
        Callback = function(v)
            SwiftVault_V2 = v
            if not v then
                local c = LP.Character
                if c then pcall(function() c:SetAttribute("vaultspeed", 1) end) end
            end
            Notify("Swift Vault V2", v and "Enabled" or "Disabled", 2)
        end,
    })
    SwiftVaultSection:CreateSlider({
        Name = "Vault Speed",
        Min = 10, Max = 20, Default = 13,
        Flag = "SwiftVault_Speed",
        Callback = function(v) SwiftVault_Speed = v end,
    })
end

-- ═══════════════ PALLET REFLEX ═══════════════
local PalletSection = SurvTab:CreateSection("Pallet Reflex")

local PalletReflex_Enabled = false
local PalletReflex_Dist    = 20

do
    local _lastDrop = 0
    local _used = {}
    local function GetKillerRoot()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and TeamIs(p, "Killer") and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then return hrp end
            end
        end
        return nil
    end
    local _lastScan = 0
    RunService.Heartbeat:Connect(function()
        if not PalletReflex_Enabled then return end
        if GetRole() ~= "Survivor" then return end
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
            if (root.Position - kr.Position).Magnitude > (PalletReflex_Dist or 20) then return end
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

    PalletSection:CreateToggle({
        Name = "Enable Pallet Reflex",
        CurrentValue = false,
        Flag = "PalletReflex_Toggle",
        Callback = function(v)
            PalletReflex_Enabled = v
            Notify("Pallet Reflex", v and "Enabled" or "Disabled", 2)
        end,
    })
    PalletSection:CreateSlider({
        Name = "Distance",
        Min = 5, Max = 50, Default = 20,
        Suffix = " studs",
        Flag = "PalletReflex_Dist",
        Callback = function(v) PalletReflex_Dist = v end,
    })
end

-- ═══════════════ FAKE PERKS ═══════════════
local FakePerksSection = SurvTab:CreateSection("Fake Perks")

local FP = {
    ActiveBuffs = {}, Conns = {}, LastBuffEnd = 0, CooldownTime = 5, HB = nil,
    FlowstateOn = false, QuickRecOn = false, PerfLandOn = false, AdrenalineOn = false,
}

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
    if c then if tb > 0 then c:SetAttribute("speedboost", 1 + (tb / 14)) else c:SetAttribute("speedboost", 1) end end
    if h and tb > 0 then h.WalkSpeed = 16 + tb end
end
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
    Notify("Fake Perks", "[" .. name .. "] Aktif! +" .. amt .. " Speed (" .. dur .. "s)", 3)
end
local function FP_Clean(name)
    if FP.Conns[name] then for _, c in ipairs(FP.Conns[name]) do pcall(function() c:Disconnect() end) end FP.Conns[name] = nil end
end
local function FP_Reg(name, conn) if not FP.Conns[name] then FP.Conns[name] = {} end table.insert(FP.Conns[name], conn) end

local function FP_Flowstate(val)
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

local function FP_QuickRecovery(val)
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

local function FP_PerfectLanding(val)
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

local function FP_AdrenalineRush(val)
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

FakePerksSection:CreateToggle({
    Name = "Flowstate",
    CurrentValue = false,
    Flag = "FP_Flowstate",
    Callback = function(v)
        FP_Flowstate(v)
        if v then Notify("Fake Perks", "Flowstate ON", 2) end
    end,
})
FakePerksSection:CreateToggle({
    Name = "Quick Recovery",
    CurrentValue = false,
    Flag = "FP_QuickRecovery",
    Callback = function(v)
        FP_QuickRecovery(v)
        if v then Notify("Fake Perks", "Quick Recovery ON", 2) end
    end,
})
FakePerksSection:CreateToggle({
    Name = "Perfect Landing",
    CurrentValue = false,
    Flag = "FP_PerfectLanding",
    Callback = function(v)
        FP_PerfectLanding(v)
        if v then Notify("Fake Perks", "Perfect Landing ON", 2) end
    end,
})
FakePerksSection:CreateToggle({
    Name = "Adrenaline Rush",
    CurrentValue = false,
    Flag = "FP_AdrenalineRush",
    Callback = function(v)
        FP_AdrenalineRush(v)
        if v then Notify("Fake Perks", "Adrenaline ON", 2) end
    end,
})
FakePerksSection:CreateSlider({
    Name = "Perk Cooldown",
    Min = 0, Max = 30, Default = 5,
    Suffix = "s",
    Flag = "FP_Cooldown",
    Callback = function(v) FP.CooldownTime = tonumber(v) or 5 end,
})
FakePerksSection:CreateButton({
    Name = "Clear All Active Buffs",
    Callback = function()
        for k in pairs(FP.ActiveBuffs) do FP.ActiveBuffs[k] = nil end
        local c = LP.Character
        if c then c:SetAttribute("speedboost", 1) end
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 end
        Notify("Fake Perks", "Buffs cleared", 2)
    end,
})

-- ═══════════════ AUTO SKILL CHECK ═══════════════
local SkillSection = SurvTab:CreateSection("Auto Skill Check")

local SC = { Enabled = false, Mode = "Legit", Busy = false, Conn = nil }

local function SC_FindPrompt()
    local pg = LP:FindFirstChildOfClass("PlayerGui")
    if not pg then return nil end
    for _, name in ipairs({ "SkillCheckPromptGui", "SkillCheck", "SkillcheckGui", "SkillCheckGui", "SkillcheckPrompt", "CheckPrompt" }) do
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
        if (d:IsA("Frame") or d:IsA("ImageLabel")) and d.Visible and d.AbsoluteSize.X > 30 then return d end
    end
    return nil
end
local function SC_FindPointerTarget(check)
    local pointer, target
    for _, d in ipairs(check:GetDescendants()) do
        if d:IsA("GuiObject") then
            local n = d.Name:lower()
            if n:find("pointer") or n:find("line") or n:find("spinner") or n:find("needle") or n:find("cursor") then
                pointer = d
            elseif n:find("target") or n:find("goal") or n:find("zone") or n:find("success") or n:find("hit") then
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
    local pg = LP:FindFirstChildOfClass("PlayerGui")
    local mob = pg and pg:FindFirstChild("Survivor-mob")
    local ctrl = mob and mob:FindFirstChild("Controls")
    if ctrl then
        for _, n in ipairs({ "action", "Gui-mob", "Parry", "attack" }) do
            local btn = ctrl:FindFirstChild(n)
            if btn and btn:IsA("GuiButton") and firesignal then
                pcall(function() firesignal(btn.MouseButton1Click) end)
                return true
            end
        end
    end
    return false
end

local function SC_Set(v)
    SC.Enabled = v
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
            task.spawn(function() SC_Press(); task.wait(0.25); SC.Busy = false end)
            return
        end
        if pointer and target then
            local pr = pointer.Rotation % 360
            local tr = target.Rotation % 360
            local diff = math.abs((pr - tr + 180) % 360 - 180)
            if diff <= 12 then
                SC.Busy = true
                task.spawn(function() SC_Press(); task.wait(0.05); SC.Busy = false end)
            end
        elseif pointer then
            local r = pointer.Rotation % 360
            if r > 100 and r < 130 then
                SC.Busy = true
                task.spawn(function() SC_Press(); task.wait(0.05); SC.Busy = false end)
            end
        end
    end)
end

SkillSection:CreateToggle({
    Name = "Enable Auto Skill Check",
    CurrentValue = false,
    Flag = "SC_Enabled",
    Callback = function(v)
        SC_Set(v)
        Notify("Auto Skill Check", v and "Enabled" or "Disabled", 2)
    end,
})
SkillSection:CreateDropdown({
    Name = "Mode",
    Options = { "Legit", "Instant" },
    CurrentOption = "Legit",
    Flag = "SC_Mode",
    Callback = function(v) SC.Mode = v end,
})

-- ═══════════════ BYPASS GENERATOR ═══════════════
local GenSection = SurvTab:CreateSection("Bypass Generator")

local GB = { Enabled = false, Cache = {}, Timer = 0, Processed = {}, Hotkey = Enum.KeyCode.B, Range = 8 }

local function GB_Cached()
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
local function GB_Nearest()
    local c = LP.Character
    local root = c and c:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local best, bd = nil, math.huge
    for _, g in pairs(GB_Cached()) do
        for _, p in pairs(GB_GetPoints(g)) do
            local d = (root.Position - p.Position).Magnitude
            if d < bd then bd = d; best = p end
        end
    end
    return best, bd
end
local function GB_Repair(tp)
    local gm = tp.Parent
    if GB.Processed[gm] then return end
    GB.Processed[gm] = true
    local c = LP.Character
    local root = c and c:FindFirstChild("HumanoidRootPart")
    if not root then GB.Processed[gm] = nil; return end
    local re = ReplicatedStorage.Remotes.Generator.RepairEvent
    local og = root.CFrame
    pcall(function()
        for _, p in pairs(GB_GetPoints(gm)) do
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
        local bp, bd = GB_Nearest()
        if not bp or bd > GB.Range then return end
        if GB.Processed[bp.Parent] then return end
        GB_Repair(bp)
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
                for _, p in pairs(GB_GetPoints(gm)) do
                    if p.Parent and (root.Position - p.Position).Magnitude <= 10 then near = true; break end
                end
                if not near then GB.Processed[gm] = nil end
            end
        end
    end
end)

GenSection:CreateToggle({
    Name = "Enable Bypass Generator",
    Description = "Hotkey: B",
    CurrentValue = false,
    Flag = "GB_Enabled",
    Callback = function(v)
        GB.Enabled = v
        if v then Notify("Bypass Generator", "Enabled (Hotkey: B)", 3) end
    end,
})
GenSection:CreateSlider({
    Name = "Trigger Range",
    Min = 3, Max = 20, Default = 8,
    Suffix = " studs",
    Flag = "GB_Range",
    Callback = function(v) GB.Range = v end,
})
GenSection:CreateButton({
    Name = "Force Repair Nearest Generator",
    Callback = function()
        local bp, bd = GB_Nearest()
        if bp and bd <= GB.Range then
            GB_Repair(bp)
            Notify("Bypass Generator", "Forcing repair...", 2)
        else
            Notify("Bypass Generator", "Terlalu jauh", 2)
        end
    end,
})

-- ═══════════════ UNLIMITED VAULT + ANTI SLOW ═══════════════
local VaultSection = SurvTab:CreateSection("Unlimited Vault")

local UVOn, UVConn = false, nil
local ASVOn, ASVConn = false, nil

VaultSection:CreateToggle({
    Name = "Unlimited Vault",
    Description = "Remove 'Blocked' tag",
    CurrentValue = false,
    Flag = "UV_Enabled",
    Callback = function(v)
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
        Notify("Unlimited Vault", v and "Enabled" or "Disabled", 2)
    end,
})
VaultSection:CreateToggle({
    Name = "Anti Slow Vault",
    Description = "Remove 'SlowVault' tag",
    CurrentValue = false,
    Flag = "ASV_Enabled",
    Callback = function(v)
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
        Notify("Anti Slow Vault", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ AUTO RUN ═══════════════
local AutoRunSection = SurvTab:CreateSection("Auto Run")

local AutoRun_PC      = false
local AutoRun_Mobile  = false

do
    local tPC, tMob = nil, nil
    local function startPC()
        if tPC then task.cancel(tPC) end
        tPC = task.spawn(function()
            while AutoRun_PC do
                pcall(function() VIM:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, LP:GetMouse()) end)
                task.wait(0.1)
            end
            pcall(function() VIM:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LP:GetMouse()) end)
            tPC = nil
        end)
    end
    local function stopPC()
        AutoRun_PC = false
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
            while AutoRun_Mobile do
                local c = LP.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if h and h.MoveDirection.Magnitude > 0.12 then pressSprint() end
                task.wait(0.12)
            end
            tMob = nil
        end)
    end

    AutoRunSection:CreateToggle({
        Name = "Auto Run [PC]",
        CurrentValue = false,
        Flag = "AutoRun_PC",
        Callback = function(v)
            AutoRun_PC = v
            if v then startPC() else stopPC() end
            Notify("Auto Run PC", v and "Enabled" or "Disabled", 2)
        end,
    })
    AutoRunSection:CreateToggle({
        Name = "Auto Run [Mobile]",
        CurrentValue = false,
        Flag = "AutoRun_Mobile",
        Callback = function(v)
            AutoRun_Mobile = v
            if v then startMob() else AutoRun_Mobile = false end
            Notify("Auto Run Mobile", v and "Enabled" or "Disabled", 2)
        end,
    })
end

-- ═══════════════ AUTO CROUCH DODGE ═══════════════
local CrouchSection = SurvTab:CreateSection("Auto Crouch Dodge")

local AutoCrouchDodge = false

local IsDowned = function(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local s = char:GetAttribute("State")
    return s == "Downed" or s == "Dead"
end

local TriggerCrouch = function()
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
        if not AutoCrouchDodge then return end
        local aid = t.Animation and t.Animation.AnimationId or ""
        if aid:match("%d+") == "80411309607666" then
            local myChar = LP.Character
            if IsDowned(myChar) then return end
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kRoot = kChar:FindFirstChild("HumanoidRootPart")
            if myRoot and kRoot then
                if (myRoot.Position - kRoot.Position).Magnitude <= 40 then TriggerCrouch() end
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

CrouchSection:CreateToggle({
    Name = "Enable Auto Crouch Dodge",
    CurrentValue = false,
    Flag = "AutoCrouchDodge",
    Callback = function(v)
        AutoCrouchDodge = v
        Notify("Crouch Dodge", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ AUTO FLEE KILLER ═══════════════
local FleeSection = SurvTab:CreateSection("Auto Flee Killer")

local AutoFlee        = false
local AutoFleeDist    = 40
local AutoFleeCooldown= 1.5
local lastFlee        = 0

task.spawn(function()
    while true do
        task.wait(0.1)
        if AutoFlee and GetRole() == "Survivor" then
            local now = tick()
            if now - lastFlee >= (AutoFleeCooldown or 1.5) then
                local c = LP.Character
                local root = c and c:FindFirstChild("HumanoidRootPart")
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if root and h and h.Health > 0 then
                    local kr, nd = nil, math.huge
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LP and TeamIs(p, "Killer") and p.Character then
                            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local d = (hrp.Position - root.Position).Magnitude
                                if d < nd then nd = d; kr = hrp end
                            end
                        end
                    end
                    if kr and nd <= (AutoFleeDist or 40) then
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
                            Notify("Auto Flee", "Teleported away!", 2)
                        end
                    end
                end
            end
        end
    end
end)

FleeSection:CreateToggle({
    Name = "Enable Auto Flee",
    CurrentValue = false,
    Flag = "AutoFlee",
    Callback = function(v)
        AutoFlee = v
        Notify("Auto Flee", v and "Enabled" or "Disabled", 2)
    end,
})
FleeSection:CreateSlider({
    Name = "Detect Distance",
    Min = 15, Max = 150, Default = 40,
    Suffix = " studs",
    Flag = "AutoFleeDist",
    Callback = function(v) AutoFleeDist = v end,
})
FleeSection:CreateSlider({
    Name = "Flee Cooldown",
    Min = 0.5, Max = 10, Default = 1.5,
    Suffix = "s",
    Flag = "AutoFleeCooldown",
    Callback = function(v) AutoFleeCooldown = v end,
})

-- ═══════════════ NO FALL DAMAGE ═══════════════
local FallSection = SurvTab:CreateSection("No Fall Damage")

local NoFallDamage = false

-- Hook __namecall untuk block Mechanics.Fall
task.spawn(function()
    pcall(function()
        if typeof(hookmetamethod) ~= "function" then return end
        local oldNC
        oldNC = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if checkcaller() then return oldNC(self, ...) end
            if method == "FireServer" and NoFallDamage then
                local ok, n = pcall(function() return self.Name end)
                if ok and n == "Fall" then
                    local par = self.Parent
                    if par and par.Name == "Mechanics" then return nil end
                end
            end
            return oldNC(self, ...)
        end)
    end)
end)

FallSection:CreateToggle({
    Name = "Enable No Fall Damage",
    CurrentValue = false,
    Flag = "NoFallDamage",
    Callback = function(v)
        NoFallDamage = v
        Notify("No Fall Damage", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ GOD MODE ═══════════════
local GodSection = SurvTab:CreateSection("God Mode")

local GodMode = false
local GodThread = nil

GodSection:CreateToggle({
    Name = "Enable God Mode",
    CurrentValue = false,
    Flag = "GodMode",
    Callback = function(v)
        GodMode = v
        if GodThread then task.cancel(GodThread); GodThread = nil end
        if v then
            GodThread = task.spawn(function()
                while GodMode do
                    local c = LP.Character
                    local h = c and c:FindFirstChildOfClass("Humanoid")
                    if h and h.Health > 0 and h.Health < h.MaxHealth then
                        pcall(function() h.Health = h.MaxHealth end)
                    end
                    task.wait(0.1)
                end
            end)
        end
        Notify("God Mode", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ TROLL TELEPORT ═══════════════
local TrollSection = SurvTab:CreateSection("Troll Teleport")

local TT = {
    Enabled = false, Processing = false, Count = 0,
    BlockedAnim = { ["123812278891591"] = 1, ["74099023522626"] = 2 }
}

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
        Notify("Troll Teleport", "Trigger #" .. TT.Count, 2)
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

TrollSection:CreateToggle({
    Name = "Enable Troll Teleport",
    CurrentValue = false,
    Flag = "TrollTeleport",
    Callback = function(v)
        TT.Enabled = v
        if v then
            if TT.Hook then return end
            TT.Processing = false
            TTHook(LP.Character)
            TT.Hook = LP.CharacterAdded:Connect(function(c) task.wait(0.4); TTHook(c) end)
        else
            if TT.Hook then pcall(function() TT.Hook:Disconnect() end); TT.Hook = nil end
            TT.Processing = false
        end
        Notify("Troll Teleport", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ NEXT MAP PREDICTION ═══════════════
local MapSection = SurvTab:CreateSection("Next Map Prediction")

local MPS = { Gui = nil, Thread = nil, Enabled = false }

local function MPS_detect(map)
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

local function MPS_build()
    if MPS.Gui then pcall(function() MPS.Gui:Destroy() end) end
    local pg = LP:FindFirstChild("PlayerGui")
    if gethui then local ok, hui = pcall(gethui); if ok and hui then pg = hui end end
    if not pg then return end
    local gui = Instance.new("ScreenGui")
    gui.Name = "PazzMapPredict"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 50
    gui.Parent = pg
    local f = Instance.new("Frame")
    f.Name = "Main"
    f.Size = UDim2.new(0, 210, 0, 54)
    f.Position = UDim2.new(0.5, -105, 0, 110)
    f.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
    f.BackgroundTransparency = 0.15
    f.BorderSizePixel = 0
    f.Active = true
    f.Parent = gui
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
    local s = Instance.new("UIStroke", f)
    s.Color = ACCENT
    s.Thickness = 1.5
    s.Transparency = 0.2
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1, 0, 0, 15)
    t.Position = UDim2.new(0, 0, 0, 5)
    t.BackgroundTransparency = 1
    t.Text = "NEXT MAP PREDICTION"
    t.TextColor3 = ACCENT
    t.Font = Enum.Font.GothamBold
    t.TextSize = 10
    local mn = Instance.new("TextLabel", f)
    mn.Name = "MapName"
    mn.Size = UDim2.new(1, -12, 0, 18)
    mn.Position = UDim2.new(0, 6, 0, 21)
    mn.BackgroundTransparency = 1
    mn.Text = "Scanning..."
    mn.TextColor3 = Color3.fromRGB(255, 255, 255)
    mn.Font = Enum.Font.GothamBold
    mn.TextSize = 13
    mn.TextXAlignment = Enum.TextXAlignment.Center
    local st = Instance.new("TextLabel", f)
    st.Name = "StatusLabel"
    st.Size = UDim2.new(1, -12, 0, 12)
    st.Position = UDim2.new(0, 6, 0, 38)
    st.BackgroundTransparency = 1
    st.Text = "Status: Waiting"
    st.TextColor3 = Color3.fromRGB(150, 150, 150)
    st.Font = Enum.Font.GothamMedium
    st.TextSize = 9
    st.TextXAlignment = Enum.TextXAlignment.Center
    local dragging, dStart, sPos = false, nil, nil
    f.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dStart = inp.Position; sPos = f.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if not dragging then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local d = inp.Position - dStart
            f.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    MPS.Gui = gui
end

local function MPS_Start()
    if MPS.Enabled then return end
    MPS.Enabled = true
    MPS_build()
    MPS.Thread = task.spawn(function()
        local lastDetected, lastExisted = nil, false
        while MPS.Enabled do
            local map = Workspace:FindFirstChild("Map")
            local exists = map ~= nil
            local det = exists and MPS_detect(map) or nil
            local gui = MPS.Gui
            local frame = gui and gui:FindFirstChild("Main")
            local nl = frame and frame:FindFirstChild("MapName")
            local sl = frame and frame:FindFirstChild("StatusLabel")
            if nl and sl then
                if lastExisted and not exists then
                    nl.Text = lastDetected or "Unknown"
                    sl.Text = "Status: Loading next map..."
                    sl.TextColor3 = Color3.fromRGB(255, 200, 50)
                elseif exists then
                    lastDetected = det or "Unknown"
                    nl.Text = det or "Unknown"
                    sl.Text = "Status: In-Game"
                    sl.TextColor3 = Color3.fromRGB(120, 255, 120)
                else
                    nl.Text = "Waiting..."
                    sl.Text = "Status: Lobby"
                    sl.TextColor3 = Color3.fromRGB(150, 150, 160)
                end
            end
            lastExisted = exists
            task.wait(0.5)
        end
    end)
end
local function MPS_Stop()
    MPS.Enabled = false
    if MPS.Thread then pcall(function() task.cancel(MPS.Thread) end); MPS.Thread = nil end
    if MPS.Gui then pcall(function() MPS.Gui:Destroy() end); MPS.Gui = nil end
end

MapSection:CreateToggle({
    Name = "Enable Map Prediction",
    CurrentValue = false,
    Flag = "MapPredict",
    Callback = function(v)
        if v then MPS_Start() else MPS_Stop() end
        Notify("Map Predict", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ NOTIFY LOADED ═══════════════
Notify("PAZZHUB — Survivor Tab", "ALFzxzzz fitur udah di-load!", 4)
print("[PAZZHUB] Survivor Tab loaded with ALFzxzzz features")
