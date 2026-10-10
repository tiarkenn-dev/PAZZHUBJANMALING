-- ═══════════════════════════════════════════════════════════════════
--  PAZZHUB — SURVIVOR TAB (ALFzxzzz Fusion) v2
--  Logo: 72845574620852
--  Tema: Biru Neon · Compact Layout
--  CornerRadius: 20
-- ═══════════════════════════════════════════════════════════════════

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

-- ═══════════════ TEMA ═══════════════
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

-- ═══════════════ HELPER ═══════════════
local function Notify(t, c, d)
    pcall(function()
        Library:Notify({ Title = t or "PazzHub", Content = c or "", Duration = d or 2 })
    end)
end

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

-- ═══════════════ FLOATING TOGGLE ═══════════════
local function CreatePazzToggle(IconId)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PazzToggle"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    local MainButton = Instance.new("TextButton")
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

local function Notify(t, c, d)
    pcall(function()
        Library:Notify({ Title = t or "PazzHub", Content = c or "", Duration = d or 2 })
    end)
end

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

-- ═══════════════ SELF HEAL ═══════════════
SurvTab:CreateSection("Self Heal")

local SelfHeal_Enabled = false
local SelfHeal_BlockedAnim = "95836365038528"
local _SelfHealConn, _SelfHealLoop, _AutoHealLoop

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

SurvTab:CreateToggle({
    Name = "Enable Self Heal",
    CurrentValue = false,
    Flag = "SelfHeal_Toggle",
    Callback = function(v)
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
        Notify("Self Heal", v and "Enabled" or "Disabled", 2)
    end,
})

SurvTab:CreateToggle({
    Name = "Auto Heal All",
    CurrentValue = false,
    Flag = "AutoHealAll_Toggle",
    Callback = function(v)
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
        Notify("Auto Heal All", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ SWIFT VAULT ═══════════════
SurvTab:CreateSection("Swift Vault")

local SwiftVault_Enabled = false
local SwiftVault_V2      = false
local SwiftVault_Speed   = 13
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

SurvTab:CreateToggle({
    Name = "Swift Vault",
    CurrentValue = false,
    Flag = "SwiftVault_Toggle",
    Callback = function(v)
        SwiftVault_Enabled = v
        _vaulted = {}
        Notify("Swift Vault", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateToggle({
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
SurvTab:CreateSlider({
    Name = "Vault Speed",
    Min = 10, Max = 20, Default = 13,
    Flag = "SwiftVault_Speed",
    Callback = function(v) SwiftVault_Speed = v end,
})

-- ═══════════════ PALLET REFLEX ═══════════════
SurvTab:CreateSection("Pallet Reflex")

local PalletReflex_Enabled = false
local PalletReflex_Dist    = 20
local _lastDrop = 0
local _usedPallet = {}

local function GetKillerRoot()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and TeamIs(p, "Killer") and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then return hrp end
        end
    end
    return nil
end

local _lastPalletScan = 0
RunService.Heartbeat:Connect(function()
    if not PalletReflex_Enabled then return end
    if GetRole() ~= "Survivor" then return end
    local now = tick()
    if now - _lastPalletScan < 0.2 then return end
    _lastPalletScan = now
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
            if obj.Name == "Palletwrong" and (obj:IsA("Model") or obj:IsA("Folder")) and not _usedPallet[obj] then
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
                _usedPallet[best] = true
                _lastDrop = tick()
            end
        end
    end)
end)
LP.CharacterAdded:Connect(function() task.wait(0.5); _usedPallet = {} end)

SurvTab:CreateToggle({
    Name = "Enable Pallet Reflex",
    CurrentValue = false,
    Flag = "PalletReflex_Toggle",
    Callback = function(v)
        PalletReflex_Enabled = v
        _usedPallet = {}
        Notify("Pallet Reflex", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateSlider({
    Name = "Trigger Distance",
    Min = 5, Max = 50, Default = 20,
    Suffix = " studs",
    Flag = "PalletReflex_Dist",
    Callback = function(v) PalletReflex_Dist = v end,
})

-- ═══════════════ FAKE PERKS ═══════════════
SurvTab:CreateSection("Fake Perks")

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
    if c then
        if tb > 0 then c:SetAttribute("speedboost", 1 + (tb / 14)) else c:SetAttribute("speedboost", 1) end
    end
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
    if FP.Conns[name] then
        for _, c in ipairs(FP.Conns[name]) do pcall(function() c:Disconnect() end) end
        FP.Conns[name] = nil
    end
end
local function FP_Reg(name, conn)
    if not FP.Conns[name] then FP.Conns[name] = {} end
    table.insert(FP.Conns[name], conn)
end

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
        FP_Reg("Flowstate", LP.CharacterAdded:Connect(function(cc)
            if FP.FlowstateOn then cc:SetAttribute("Flowstate", true); hookChar(cc) end
        end))
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

SurvTab:CreateToggle({
    Name = "Flowstate",
    Description = "Buff saat vault/slide (+5 speed 3s)",
    CurrentValue = false,
    Flag = "FP_Flowstate",
    Callback = function(v)
        FP_Flowstate(v)
        if v then Notify("Fake Perks", "Flowstate ON", 2) end
    end,
})
SurvTab:CreateToggle({
    Name = "Quick Recovery",
    Description = "Buff saat heal (+6 speed 3s)",
    CurrentValue = false,
    Flag = "FP_QuickRecovery",
    Callback = function(v)
        FP_QuickRecovery(v)
        if v then Notify("Fake Perks", "Quick Recovery ON", 2) end
    end,
})
SurvTab:CreateToggle({
    Name = "Perfect Landing",
    Description = "Buff saat mendarat (+8 speed 3s)",
    CurrentValue = false,
    Flag = "FP_PerfectLanding",
    Callback = function(v)
        FP_PerfectLanding(v)
        if v then Notify("Fake Perks", "Perfect Landing ON", 2) end
    end,
})
SurvTab:CreateToggle({
    Name = "Adrenaline Rush",
    Description = "Buff saat HP rendah (+4 speed 5s)",
    CurrentValue = false,
    Flag = "FP_AdrenalineRush",
    Callback = function(v)
        FP_AdrenalineRush(v)
        if v then Notify("Fake Perks", "Adrenaline ON", 2) end
    end,
})
SurvTab:CreateSlider({
    Name = "Perk Cooldown",
    Min = 0, Max = 30, Default = 5,
    Suffix = "s",
    Flag = "FP_Cooldown",
    Callback = function(v) FP.CooldownTime = tonumber(v) or 5 end,
})
SurvTab:CreateButton({
    Name = "Clear All Active Buffs",
    Callback = function()
        for k in pairs(FP.ActiveBuffs) do FP.ActiveBuffs[k] = nil end
        local c = LP.Character
        if c then c:SetAttribute("speedboost", 1) end
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 end
        Notify("Fake Perks", "Buffs cleared", 2)
    end,
})-- ═══════════════ AUTO SKILL CHECK ═══════════════
SurvTab:CreateSection("Auto Skill Check")

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

SurvTab:CreateToggle({
    Name = "Enable Auto Skill Check",
    CurrentValue = false,
    Flag = "SC_Enabled",
    Callback = function(v)
        SC_Set(v)
        Notify("Auto Skill Check", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateDropdown({
    Name = "Mode",
    Options = { "Legit", "Instant" },
    CurrentOption = "Legit",
    Flag = "SC_Mode",
    Callback = function(v) SC.Mode = v end,
})

-- ═══════════════ BYPASS GENERATOR ═══════════════
SurvTab:CreateSection("Bypass Generator")

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

SurvTab:CreateToggle({
    Name = "Enable Bypass Generator",
    Description = "Hotkey: B",
    CurrentValue = false,
    Flag = "GB_Enabled",
    Callback = function(v)
        GB.Enabled = v
        if v then Notify("Bypass Generator", "Enabled (Hotkey: B)", 3) end
    end,
})
SurvTab:CreateSlider({
    Name = "Trigger Range",
    Min = 3, Max = 20, Default = 8,
    Suffix = " studs",
    Flag = "GB_Range",
    Callback = function(v) GB.Range = v end,
})
SurvTab:CreateButton({
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
SurvTab:CreateSection("Unlimited Vault")

local UVOn, UVConn = false, nil
local ASVOn, ASVConn = false, nil

SurvTab:CreateToggle({
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
SurvTab:CreateToggle({
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
SurvTab:CreateSection("Auto Run")

local AutoRun_PC     = false
local AutoRun_Mobile = false
local tPC, tMob = nil, nil

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

SurvTab:CreateToggle({
    Name = "Auto Run [PC]",
    CurrentValue = false,
    Flag = "AutoRun_PC",
    Callback = function(v)
        AutoRun_PC = v
        if v then startPC() else stopPC() end
        Notify("Auto Run PC", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateToggle({
    Name = "Auto Run [Mobile]",
    CurrentValue = false,
    Flag = "AutoRun_Mobile",
    Callback = function(v)
        AutoRun_Mobile = v
        if v then startMob() else AutoRun_Mobile = false end
        Notify("Auto Run Mobile", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ AUTO CROUCH DODGE ═══════════════
SurvTab:CreateSection("Auto Crouch Dodge")

local AutoCrouchDodge = false

local function IsDowned(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local s = char:GetAttribute("State")
    return s == "Downed" or s == "Dead"
end

local function TriggerCrouch()
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

SurvTab:CreateToggle({
    Name = "Enable Auto Crouch Dodge",
    CurrentValue = false,
    Flag = "AutoCrouchDodge",
    Callback = function(v)
        AutoCrouchDodge = v
        Notify("Crouch Dodge", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ AUTO FLEE KILLER ═══════════════
SurvTab:CreateSection("Auto Flee Killer")

local AutoFlee         = false
local AutoFleeDist     = 40
local AutoFleeCooldown = 1.5
local lastFlee         = 0

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

SurvTab:CreateToggle({
    Name = "Enable Auto Flee",
    CurrentValue = false,
    Flag = "AutoFlee",
    Callback = function(v)
        AutoFlee = v
        Notify("Auto Flee", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateSlider({
    Name = "Detect Distance",
    Min = 15, Max = 150, Default = 40,
    Suffix = " studs",
    Flag = "AutoFleeDist",
    Callback = function(v) AutoFleeDist = v end,
})
SurvTab:CreateSlider({
    Name = "Flee Cooldown",
    Min = 0.5, Max = 10, Default = 1.5,
    Suffix = "s",
    Flag = "AutoFleeCooldown",
    Callback = function(v) AutoFleeCooldown = v end,
})

-- ═══════════════ NO FALL DAMAGE ═══════════════
SurvTab:CreateSection("No Fall Damage")

local NoFallDamage = false

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

SurvTab:CreateToggle({
    Name = "Enable No Fall Damage",
    CurrentValue = false,
    Flag = "NoFallDamage",
    Callback = function(v)
        NoFallDamage = v
        Notify("No Fall Damage", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ GOD MODE ═══════════════
SurvTab:CreateSection("God Mode")

local GodMode = false
local GodThread = nil

SurvTab:CreateToggle({
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
SurvTab:CreateSection("Troll Teleport")

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

SurvTab:CreateToggle({
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
SurvTab:CreateSection("Next Map Prediction")

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

SurvTab:CreateToggle({
    Name = "Enable Map Prediction",
    CurrentValue = false,
    Flag = "MapPredict",
    Callback = function(v)
        if v then MPS_Start() else MPS_Stop() end
        Notify("Map Predict", v and "Enabled" or "Disabled", 2)
    end,
})-- ═══════════════ MANUAL / AUTO GENERATOR ═══════════════
SurvTab:CreateSection("Generator")

local ManualGen        = false
local AutoGen          = false
local KillerEscapeDist = 30
local ManualThread, AutoThread = nil, nil
local ManualPoint, AutoPoint = nil, nil
local LastFire = 0
local RepairAnimTrack = nil
local RepairEvent = nil
pcall(function() RepairEvent = ReplicatedStorage.Remotes.Generator.RepairEvent end)
local REPAIR_ANIM_ID = "rbxassetid://92960319113695"

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
    for _, gen in ipairs(GB_GetAllGenerators()) do
        for _, pt in ipairs(GB_GetPoints(gen)) do
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
    for _, gen in ipairs(GB_GetAllGenerators()) do
        if IsGenDone(gen) then continue end
        local genPivot
        pcall(function() genPivot = gen:GetPivot().Position end)
        if genPivot and IsKillerNearPos(genPivot, KillerEscapeDist) then continue end
        for _, pt in ipairs(GB_GetPoints(gen)) do
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
        while ManualGen do
            local myChar = LP.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
            if not myRoot or not hum or hum.Health <= 0 then task.wait(0.2); continue end
            local _, kd = GetNearestKillerDist()
            if kd <= KillerEscapeDist then
                if ManualPoint then
                    StopRepair(ManualPoint)
                    ManualPoint = nil
                    Notify("Manual Gen", "Killer near — release repair", 2)
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
        while AutoGen do
            local myChar = LP.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
            if not myRoot or not hum or hum.Health <= 0 then task.wait(0.3); continue end
            local _, kd = GetNearestKillerDist()
            if kd <= KillerEscapeDist then
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

SurvTab:CreateToggle({
    Name = "Enable Manual Generator",
    Description = "Auto repair gen terdekat. Release kalau killer dekat.",
    CurrentValue = false,
    Flag = "ManualGen",
    Callback = function(v)
        ManualGen = v
        if v then StartManualThread() else StopManualThread() end
        Notify("Manual Gen", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateSlider({
    Name = "Killer Escape Distance",
    Min = 10, Max = 80, Default = 30,
    Suffix = " studs",
    Flag = "KillerEscapeDist",
    Callback = function(v) KillerEscapeDist = v end,
})
SurvTab:CreateToggle({
    Name = "Enable Auto Generator",
    Description = "Auto TP ke gen aman kalau killer dekat",
    CurrentValue = false,
    Flag = "AutoGen",
    Callback = function(v)
        AutoGen = v
        if v then StartAutoThread() else StopAutoThread() end
        Notify("Auto Gen", v and "Enabled" or "Disabled", 2)
    end,
})

-- ═══════════════ SELF UNHOOK ═══════════════
SurvTab:CreateSection("Bypass Self Unhook")

local SU = {
    Enabled = false, Following = false, FollowDuration = 30, FollowDistance = 20,
    MonitorConn = nil, _lastTrigger = 0, _cooldown = 3,
    _hookPos = nil, _hookCFrame = nil, _activeThread = nil, _wasHooked = false
}
local function SU_IsHooked()
    local c = LP.Character
    if not c then return false end
    return c:GetAttribute("IsHooked") == true or c:GetAttribute("isHooked") == true
        or c:GetAttribute("Hooked") == true or c:GetAttribute("HookedState") == true
end
local function SU_GetGenPoint()
    local gens = GB_GetAllGenerators()
    if not gens or #gens == 0 then return nil end
    local v = {}
    for _, g in ipairs(gens) do
        if g and g.Parent then
            for _, p in ipairs(GB_GetPoints(g)) do
                if p and p.Parent then table.insert(v, p) end
            end
        end
    end
    if #v == 0 then return nil end
    return v[math.random(1, #v)]
end
local function SU_GetKillerHRP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and TeamIs(p, "Killer") and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then return hrp end
        end
    end
    return nil
end
local function SU_Abort()
    SU.Following = false
    if SU._activeThread and coroutine.status(SU._activeThread) ~= "dead" then
        pcall(function() task.cancel(SU._activeThread) end)
    end
    SU._activeThread = nil
end
local function SU_Trigger()
    if SU.Following then return end
    local now = tick()
    if now - SU._lastTrigger < SU._cooldown then return end
    if not SU_IsHooked() then return end
    SU._lastTrigger = now; SU.Following = true
    local c = LP.Character
    if c then
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if hrp then SU._hookPos = hrp.Position; SU._hookCFrame = hrp.CFrame end
    end
    SU._activeThread = task.spawn(function()
        local cc = LP.Character
        if not cc then SU.Following = false; SU._activeThread = nil; return end
        local hrp = cc:FindFirstChild("HumanoidRootPart")
        if not hrp then SU.Following = false; SU._activeThread = nil; return end
        local re = ReplicatedStorage:FindFirstChild("Remotes")
            and ReplicatedStorage.Remotes:FindFirstChild("Generator")
            and ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
        if not SU_IsHooked() then SU.Following = false; SU._activeThread = nil; return end
        local tp = SU_GetGenPoint()
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
            if not SU_IsHooked() then
                SU.Following = false; SU._activeThread = nil
                Notify("Self Unhook", "Released - STOP", 2)
                return
            end
            local c2 = LP.Character
            if not c2 then break end
            local r = c2:FindFirstChild("HumanoidRootPart")
            if not r then break end
            local khrp = SU_GetKillerHRP()
            if khrp then
                pcall(function()
                    r.Velocity = Vector3.zero
                    local tPos = Vector3.new(khrp.Position.X, khrp.Position.Y - bOff, khrp.Position.Z)
                    r.CFrame = CFrame.new(tPos, tPos + Vector3.new(0, 0, -1))
                end)
            end
            task.wait(0.03)
        end
        if SU_IsHooked() then
            local c3 = LP.Character
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
local function SU_Start()
    if SU.MonitorConn then return end
    SU._wasHooked = false
    SU.MonitorConn = RunService.Heartbeat:Connect(function()
        if not SU.Enabled then return end
        local c = LP.Character
        if not c then return end
        local isH = SU_IsHooked()
        if not isH then SU._wasHooked = false; return end
        if not SU._wasHooked and not SU.Following then SU._wasHooked = true; SU_Trigger() end
    end)
end
local function SU_Stop()
    if SU.MonitorConn then SU.MonitorConn:Disconnect(); SU.MonitorConn = nil end
    SU_Abort(); SU._wasHooked = false
end

SurvTab:CreateToggle({
    Name = "Enable Bypass Self Unhook",
    CurrentValue = false,
    Flag = "SelfUnhook_Enabled",
    Callback = function(v)
        SU.Enabled = v
        if v then SU_Start() else SU_Stop() end
        Notify("Self Unhook", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateSlider({
    Name = "Follow Duration",
    Min = 5, Max = 120, Default = 30,
    Suffix = "s",
    Flag = "SU_Duration",
    Callback = function(v) SU.FollowDuration = v end,
})
SurvTab:CreateSlider({
    Name = "Follow Distance",
    Min = 5, Max = 60, Default = 20,
    Suffix = " studs",
    Flag = "SU_Distance",
    Callback = function(v) SU.FollowDistance = v end,
})

-- ═══════════════ SILENT AIM TOF ═══════════════
SurvTab:CreateSection("Silent Aim TOF")

local ToFState = {
    Conn = nil, Laser = nil, InputBegan = nil, InputEnded = nil,
    TouchInput = nil, IsAiming = false, SCPCache = {}, SCPCacheTimer = 0
}
local ToFKeys = { None=nil, Q=Enum.KeyCode.Q, E=Enum.KeyCode.E, R=Enum.KeyCode.R, T=Enum.KeyCode.T, F=Enum.KeyCode.F, G=Enum.KeyCode.G, H=Enum.KeyCode.H, J=Enum.KeyCode.J, K=Enum.KeyCode.K, L=Enum.KeyCode.L, X=Enum.KeyCode.X, Z=Enum.KeyCode.Z }
local TOF_Enabled, TOF_Laser, TOF_WallCheck, TOF_BlockKnocked, TOF_TargetMode = false, true, true, true, "Killer"

local function ToF_Downed(c)
    if not c then return true end
    local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return true end
    local h = c:FindFirstChildOfClass("Humanoid"); if h and h.Health <= 0 then return true end
    if c:GetAttribute("Knocked") == true then return true end
    if c:GetAttribute("IsHooked") == true then return true end
    if c:GetAttribute("IsCarried") == true then return true end
    return false
end
local function ToF_Blocked()
    if TOF_BlockKnocked == false then return false end
    local c = LP.Character
    if not c then return true end
    return ToF_Downed(c)
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
    local c = LP.Character
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
local function ToF_Visible(op, tp, tc)
    local d = tp - op
    local dist = d.Magnitude
    if dist < 0.1 then return true end
    local rp = RaycastParams.new(); rp.FilterType = Enum.RaycastFilterType.Exclude
    local ex = {}
    local lc = LP.Character
    if lc then table.insert(ex, lc) end
    if tc and tc ~= lc then table.insert(ex, tc) end
    if ToFState.Laser then table.insert(ex, ToFState.Laser) end
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
    local g = ToF_GetGun(); local c = LP.Character
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
        if TOF_WallCheck and not ToF_Visible(op, tp, tc) then return nil,nil,nil,nil end
        local tv = Vector3.new(0,0,0)
        local rp = tc and (tc:FindFirstChild("HumanoidRootPart") or t)
        if rp then tv = rp.Velocity end
        local dr = tp - op
        local d = dr.Magnitude
        if d < 0.1 then return nil,nil,nil,nil end
        if d < 5 then return dr.Unit, g, op, tp end
        local tt = d / 400
        local pp = tp + (tv * tt)
        for _ = 1, 2 do local nd = (pp - op).Magnitude; tt = nd/400; pp = tp + (tv*tt) end
        local fd = pp - op
        if fd.Magnitude < 0.1 then return nil,nil,nil,nil end
        return fd.Unit, g, op, pp
    end
    local mode = TOF_TargetMode or "Killer"
    if mode == "Killer" then
        local bt, bc, bs = nil, nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and TeamIs(p, "Killer") and p.Character then
                local t = p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("HumanoidRootPart")
                if t then local d = (mp - t.Position).Magnitude; if d < bs then bs = d; bt = t; bc = p.Character end end
            end
        end
        if not bt then return nil,nil,nil,nil end
        return predict(bt, bc)
    elseif mode == "Survivors" then
        local bt, bc, bd = nil, nil, -math.huge
        local cam = workspace.CurrentCamera
        local cl = cam.CFrame.LookVector
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and TeamIs(p, "Survivor") and p.Character then
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
        if not bt then return nil,nil,nil,nil end
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
        if not bp then return nil,nil,nil,nil end
        return predict(bp, bp.Parent)
    end
    return nil,nil,nil,nil
end
local function ToF_UpdateLaser(op, tp)
    if not ToFState.Laser then
        local l = Instance.new("Part")
        l.Name = "PazzToFLaser"; l.Anchored = true; l.CanCollide = false
        l.CanTouch = false; l.CastShadow = false
        l.Material = Enum.Material.Neon
        l.Color = ACCENT
        l.Parent = workspace
        ToFState.Laser = l
    end
    local d = (tp - op).Magnitude
    ToFState.Laser.Size = Vector3.new(0.05, 0.05, d)
    ToFState.Laser.CFrame = CFrame.new((op + tp) / 2, tp)
    ToFState.Laser.Transparency = 0
end
local function ToF_ClearLaser()
    if ToFState.Laser then pcall(function() ToFState.Laser:Destroy() end); ToFState.Laser = nil end
end
local function ToF_Shoot()
    if not TOF_Enabled then return end
    if ToF_Blocked() then return end
    local td, g, op, tp = ToF_GetTarget()
    if not (td and g and tp and op) then return end
    local e = ToF_GetEvent()
    if not e then return end
    local fd = tp - op
    if fd.Magnitude < 0.1 then return end
    pcall(function() e:FireServer(g, fd.Unit) end)
end
local function ToF_StartConn()
    if ToFState.Conn then return end
    ToFState.Conn = RunService.Heartbeat:Connect(function()
        if ToF_Blocked() then
            ToFState.IsAiming = false
            if ToFState.TouchInput then ToFState.TouchInput = nil end
            if ToFState.Laser then ToFState.Laser.Transparency = 1 end
            return
        end
        if not TOF_Enabled or not ToFState.IsAiming then
            if ToFState.Laser then ToFState.Laser.Transparency = 1 end
            return
        end
        local _, _, op, tp = ToF_GetTarget()
        if op and tp then
            pcall(function()
                local c = LP.Character
                local hrp = c and c:FindFirstChild("HumanoidRootPart")
                if hrp and not c:GetAttribute("IsCarried") then
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(tp.X, hrp.Position.Y, tp.Z))
                end
            end)
            if TOF_Laser then ToF_UpdateLaser(op, tp)
            elseif ToFState.Laser then ToFState.Laser.Transparency = 1 end
        elseif ToFState.Laser then ToFState.Laser.Transparency = 1 end
    end)
end
local function ToF_StopConn()
    if ToFState.Conn then pcall(function() ToFState.Conn:Disconnect() end); ToFState.Conn = nil end
    ToFState.IsAiming = false
    ToF_ClearLaser()
end
local function ToF_EnsureInputs()
    if not ToFState.InputBegan then
        ToFState.InputBegan = UserInputService.InputBegan:Connect(function(inp, gp)
            if gp then return end
            if not TOF_Enabled then return end
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                if ToF_Blocked() then ToFState.IsAiming = false; return end
                ToFState.IsAiming = true
            end
        end)
    end
    if not ToFState.InputEnded then
        ToFState.InputEnded = UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                local wa = ToFState.IsAiming
                ToFState.IsAiming = false
                if ToFState.Laser then ToFState.Laser.Transparency = 1 end
                if wa then ToF_Shoot() end
            end
        end)
    end
end
ToF_EnsureInputs()

SurvTab:CreateToggle({
    Name = "Enable Silent Aim",
    CurrentValue = false,
    Flag = "TOF_Enabled",
    Callback = function(v)
        TOF_Enabled = v
        if v then ToF_StartConn() else ToF_StopConn() end
        Notify("Silent Aim TOF", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateDropdown({
    Name = "Target Mode",
    Options = { "Killer", "Survivors", "Zombie" },
    CurrentOption = "Killer",
    Flag = "TOF_Mode",
    Callback = function(v) TOF_TargetMode = v end,
})
SurvTab:CreateToggle({
    Name = "Show Laser",
    CurrentValue = true,
    Flag = "TOF_Laser",
    Callback = function(v) TOF_Laser = v end,
})
SurvTab:CreateToggle({
    Name = "Wall Check",
    CurrentValue = true,
    Flag = "TOF_WallCheck",
    Callback = function(v) TOF_WallCheck = v end,
})
SurvTab:CreateToggle({
    Name = "Block When Knocked",
    CurrentValue = true,
    Flag = "TOF_BlockKnocked",
    Callback = function(v) TOF_BlockKnocked = v end,
})

-- ═══════════════ SILENT FLASHLIGHT ═══════════════
SurvTab:CreateSection("Silent Flashlight")

local Flash_Enabled = false
local Flash_TargetPart = "Head"
local Flash_Range = 120
local Flash_Smooth = 0.35
local FS = { Active = false, Laser = nil, Part = nil, Conn = nil }

local function Flash_targetPart(char)
    if not char then return nil end
    local p = char:FindFirstChild(Flash_TargetPart)
    if p and p:IsA("BasePart") then return p end
    return char:FindFirstChild("Head") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
end
local function Flash_alive(char)
    local h = char and char:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return false end
    return char:GetAttribute("State") ~= "Dead"
end
local function Flash_getTarget()
    local c = LP.Character
    local root = c and c:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local maxR = tonumber(Flash_Range) or 120
    local best, bd = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and Flash_alive(p.Character) and TeamIs(p, "Killer") then
            local pt = Flash_targetPart(p.Character)
            if pt then
                local d = (root.Position - pt.Position).Magnitude
                if d <= maxR and d < bd then bd = d; best = pt end
            end
        end
    end
    return best
end
local function Flash_clearLaser()
    if FS.Laser then pcall(function() FS.Laser:Destroy() end); FS.Laser = nil end
end
local function Flash_getOrigin(cam)
    if FS.Part and FS.Part:IsA("BasePart") then return FS.Part.Position end
    local c = LP.Character
    local hand = c and (c:FindFirstChild("RightHand") or c:FindFirstChild("Right Arm") or c:FindFirstChild("HumanoidRootPart"))
    if hand and hand:IsA("BasePart") then return hand.Position end
    return cam and cam.CFrame.Position or nil
end
local function Flash_updateLaser(op, tp)
    if not FS.Laser then
        local l = Instance.new("Part")
        l.Name = "PazzFlashLaser"; l.Anchored = true; l.CanCollide = false
        l.CanTouch = false; l.CanQuery = false; l.CastShadow = false
        l.Material = Enum.Material.Neon
        l.Color = ACCENT
        l.Parent = Workspace
        FS.Laser = l
    end
    local d = (tp - op).Magnitude
    if d < 0.1 then return end
    FS.Laser.Size = Vector3.new(0.16, 0.16, d)
    FS.Laser.CFrame = CFrame.new((op + tp) / 2, tp)
    FS.Laser.Transparency = 0.35
end
local function Flash_step()
    if not (Flash_Enabled and FS.Active) then
        if FS.Laser then FS.Laser.Transparency = 1 end
        return
    end
    local cam = Workspace.CurrentCamera
    local tp = Flash_getTarget()
    if not (cam and tp) then
        if FS.Laser then FS.Laser.Transparency = 1 end
        return
    end
    local smooth = math.clamp(tonumber(Flash_Smooth) or 0.35, 0.05, 1)
    local op = Flash_getOrigin(cam)
    if op then pcall(Flash_updateLaser, op, tp.Position)
    elseif FS.Laser then FS.Laser.Transparency = 1 end    pcall(function() cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, tp.Position), smooth) end)
    pcall(function()
        local c = LP.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(tp.Position.X, hrp.Position.Y, tp.Position.Z)) end
    end)
end
local function Flash_start()
    if FS.Conn then return end
    FS.Conn = RunService.RenderStepped:Connect(function() pcall(Flash_step) end)
end
local function Flash_stop()
    FS.Active = false; FS.Part = nil
    Flash_clearLaser()
    if FS.Conn then pcall(function() FS.Conn:Disconnect() end); FS.Conn = nil end
end
-- Hook Flashlight Activate remote
task.spawn(function()
    pcall(function()
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local i = r and r:FindFirstChild("Items")
        local f = i and i:FindFirstChild("Flashlight")
        local a = f and f:FindFirstChild("Activate")
        if not a then return end
        if typeof(hookmetamethod) ~= "function" then return end
        local oldNC
        oldNC = hookmetamethod(game, "__namecall", function(self, ...)
            if getnamecallmethod() == "FireServer" and self == a then
                local args = {...}
                pcall(function()
                    FS.Active = args[2] == true
                    if FS.Active and args[1] then FS.Part = args[1] else FS.Part = nil end
                end)
            end
            return oldNC(self, ...)
        end)
    end)
end)

SurvTab:CreateToggle({
    Name = "Enable Silent Flashlight",
    CurrentValue = false,
    Flag = "Flash_Enabled",
    Callback = function(v)
        Flash_Enabled = v
        if v then Flash_start() else Flash_stop() end
        Notify("Silent Flashlight", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateDropdown({
    Name = "Target Part",
    Options = { "Head", "UpperTorso", "Torso", "HumanoidRootPart" },
    CurrentOption = "Head",
    Flag = "Flash_TargetPart",
    Callback = function(v) Flash_TargetPart = v end,
})
SurvTab:CreateSlider({
    Name = "Max Range",
    Min = 20, Max = 250, Default = 120,
    Suffix = " studs",
    Flag = "Flash_Range",
    Callback = function(v) Flash_Range = v end,
})
SurvTab:CreateSlider({
    Name = "Smoothness",
    Min = 0.05, Max = 1, Default = 0.35,
    Flag = "Flash_Smooth",
    Callback = function(v) Flash_Smooth = v end,
})

-- ═══════════════ AIM LOCK GUN ═══════════════
SurvTab:CreateSection("Aim Lock Gun")

local GA = {
    Enabled = false, Holding = false, TargetMode = "Killer",
    Strength = 0.5, Predict = true, PredictStrength = 0.12,
    FOV = 250, VisCheck = true,
    AimPart = "HumanoidRootPart", Target = nil,
}
local GA_Conn = nil
local GA_CurrBtn = nil

local function GA_visible(part)
    local cam = Workspace.CurrentCamera
    if not cam then return true end
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances = { LP.Character }
    local o = cam.CFrame.Position
    local d = part.Position - o
    local res = Workspace:Raycast(o, d, rp)
    if not res then return true end
    return res.Instance:IsDescendantOf(part.Parent)
end
local function GA_getBtn()
    local cur = LP:FindFirstChild("PlayerGui")
    for s in string.gmatch("Survivor-mob.Controls.Gui-mob", "[^%.]+") do
        cur = cur and cur:FindFirstChild(s)
    end
    return cur
end
local function GA_closest()
    local cam = Workspace.CurrentCamera
    if not cam then return nil end
    local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
    local best, bd = nil, GA.FOV
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Team then
            local valid = false
            if GA.TargetMode == "Killer" and TeamIs(p, "Killer") then valid = true
            elseif GA.TargetMode == "Survivor" and TeamIs(p, "Survivor") then valid = true end
            if valid then
                local hrp = p.Character:FindFirstChild(GA.AimPart)
                local h = p.Character:FindFirstChildOfClass("Humanoid")
                if hrp and h and h.Health > 0 then
                    local pos, on = cam:WorldToViewportPoint(hrp.Position)
                    if on then
                        local d = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        if d < bd then
                            if GA.VisCheck and not GA_visible(hrp) then continue end
                            bd = d; best = hrp
                        end
                    end
                end
            end
        end
    end
    return best
end
local function GA_start()
    if GA_Conn then return end
    GA_Conn = RunService.RenderStepped:Connect(function()
        if not GA.Enabled or not GA.Holding then GA.Target = nil; return end
        local t = GA_closest()
        if not t then return end
        GA.Target = t
        local pos = t.Position
        if GA.Predict then pos = pos + (t.AssemblyLinearVelocity * GA.PredictStrength) end
        local cam = Workspace.CurrentCamera
        cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, pos), GA.Strength)
    end)
end
UserInputService.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.UserInputType == Enum.UserInputType.MouseButton2 and GA.Enabled then
        GA.Holding = true
    end
end)
UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton2 then GA.Holding = false end
end)
task.spawn(function()
    while true do
        task.wait(1)
        local b = GA_getBtn()
        if b and b ~= GA_CurrBtn then
            GA_CurrBtn = b
            b.InputBegan:Connect(function(inp)
                if (inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton2) and GA.Enabled then
                    GA.Holding = true
                end
            end)
            b.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton2 then
                    GA.Holding = false
                end
            end)
        end
    end
end)

SurvTab:CreateToggle({
    Name = "Enable Aim Lock Gun (Hold M2)",
    CurrentValue = false,
    Flag = "GunAim_Enabled",
    Callback = function(v)
        GA.Enabled = v
        if v and GA_start then GA_start() end
        Notify("Aim Lock Gun", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateDropdown({
    Name = "Target Mode",
    Options = { "Killer", "Survivor" },
    CurrentOption = "Killer",
    Flag = "GunAim_Mode",
    Callback = function(v) GA.TargetMode = v end,
})
SurvTab:CreateSlider({
    Name = "FOV Radius",
    Min = 50, Max = 1000, Default = 250, Increment = 10,
    Flag = "GunAim_FOV",
    Callback = function(v) GA.FOV = v end,
})

-- ═══════════════ MOONWALK ═══════════════
SurvTab:CreateSection("Moonwalk")

local MW_enabled = false
local MW_conn = nil
local MW_SideSpeed = 0.9
local MW_BackSpeed = 1.2
local MW_Interval = 0.07

local function MW_stop()
    if MW_conn then MW_conn:Disconnect(); MW_conn = nil end
end
local function MW_start()
    MW_stop()
    local c = LP.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local h = c:FindFirstChildOfClass("Humanoid")
    if not hrp or not h then return end
    local lastSwitch = 0
    local dir = 1
    MW_conn = RunService.RenderStepped:Connect(function()
        if not MW_enabled then return end
        local cc = LP.Character
        if not cc then return end
        local chrp = cc:FindFirstChild("HumanoidRootPart")
        local chum = cc:FindFirstChildOfClass("Humanoid")
        if not chrp or not chum or chum.Health <= 0 then return end
        local now = tick()
        if now - lastSwitch >= MW_Interval then
            dir = dir * -1
            lastSwitch = now
        end
        local back = chrp.CFrame.LookVector * -MW_BackSpeed
        local side = chrp.CFrame.RightVector * (dir * MW_SideSpeed)
        chum:Move(back + side, false)
    end)
end

SurvTab:CreateToggle({
    Name = "Enable Moonwalk (F8)",
    CurrentValue = false,
    Flag = "Moonwalk_Enabled",
    Callback = function(v)
        MW_enabled = v
        if v then MW_start() else MW_stop() end
        Notify("Moonwalk", v and "Enabled" or "Disabled", 2)
    end,
})
SurvTab:CreateSlider({
    Name = "Side Speed",
    Min = 0.1, Max = 3, Default = 0.9, Increment = 0.1,
    Flag = "MW_Side",
    Callback = function(v) MW_SideSpeed = v end,
})
SurvTab:CreateSlider({
    Name = "Back Speed",
    Min = 0.1, Max = 3, Default = 1.2, Increment = 0.1,
    Flag = "MW_Back",
    Callback = function(v) MW_BackSpeed = v end,
})
SurvTab:CreateSlider({
    Name = "Switch Interval",
    Min = 0.02, Max = 0.5, Default = 0.07, Increment = 0.01,
    Flag = "MW_Interval",
    Callback = function(v) MW_Interval = v end,
})
UserInputService.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.F8 then
        MW_enabled = not MW_enabled
        if MW_enabled then MW_start() else MW_stop() end
    end
end)

-- ═══════════════ CLOSING ═══════════════
Notify("PAZZHUB Survivor", "Semua fitur ALFzxzzz udah di-load!", 5)
print("[PAZZHUB] Survivor Tab loaded with ALL ALFzxzzz features")
