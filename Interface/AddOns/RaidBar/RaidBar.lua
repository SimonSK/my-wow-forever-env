-- RaidBar.lua  (WoW 12.0.1 – Midnight)
-- Compact moveable raid marker & utility bar.
--
-- /raidbar           → open / close Settings panel
-- /raidbar blizzui   → toggle Blizzard raid manager panel
-- /raidbar reset     → wipe SavedVariables + reload
-- /raidbar show/hide → force show or hide the bar

local ADDON = ... -- Client support versions are declared in the TOC.

local trim = strtrim or function(value)
    value = tostring(value or "")
    value = value:gsub("^%s+", "")
    value = value:gsub("%s+$", "")
    return value
end

local HAS_WORLD_MARKERS = type(ClearRaidMarker) == "function"
local HAS_PULL_COUNTDOWN = C_PartyInfo and type(C_PartyInfo.DoCountdown) == "function"
local HAS_SETTINGS_API = Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory

local function WithBackdropTemplate(template)
    if not BackdropTemplateMixin then
        return template
    end
    if template and template ~= "" then
        if string.find(template, "BackdropTemplate", 1, true) then
            return template
        end
        return template .. ",BackdropTemplate"
    end
    return "BackdropTemplate"
end

local function GetColorPickerAlpha()
    if ColorPickerFrame and ColorPickerFrame.GetColorAlpha then
        local alpha = ColorPickerFrame:GetColorAlpha()
        if alpha ~= nil then
            return alpha
        end
    end
    if OpacitySliderFrame and OpacitySliderFrame.GetValue then
        return 1 - OpacitySliderFrame:GetValue()
    end
    return 1
end

local function OpenColorPickerCompat(info)
    if not ColorPickerFrame then return false end

    if ColorPickerFrame.SetupColorPickerAndShow then
        ColorPickerFrame:SetupColorPickerAndShow(info)
        return true
    end

    ColorPickerFrame.func = info.swatchFunc
    ColorPickerFrame.opacityFunc = info.opacityFunc or info.swatchFunc
    ColorPickerFrame.cancelFunc = info.cancelFunc
    ColorPickerFrame.hasOpacity = info.hasOpacity and true or false
    ColorPickerFrame.opacity = info.hasOpacity and (1 - (info.opacity or 1)) or nil
    ColorPickerFrame.previousValues = {
        r = info.r or 1,
        g = info.g or 1,
        b = info.b or 1,
        opacity = ColorPickerFrame.opacity,
    }
    ColorPickerFrame:SetColorRGB(info.r or 1, info.g or 1, info.b or 1)
    ColorPickerFrame:Hide()
    ColorPickerFrame:Show()
    return true
end

local function StartPullCountdown(seconds)
    if HAS_PULL_COUNTDOWN then
        C_PartyInfo.DoCountdown(seconds)
        return true
    end
    return false
end

local function LeaveCurrentGroup()
    if C_PartyInfo and type(C_PartyInfo.LeaveParty) == "function" then
        C_PartyInfo.LeaveParty()
        return true
    end
    if type(LeaveParty) == "function" then
        LeaveParty()
        return true
    end
    return false
end

local function BuildTargetMarkerMacro(index)
    return string.format("%s !%d", SLASH_TARGET_MARKER1 or "/tm", index)
end

local function BuildClearTargetMarkerMacro()
    return string.format("%s 0", SLASH_TARGET_MARKER1 or "/tm")
end

local function BuildClearMarkersMacro()
    local target = BuildClearTargetMarkerMacro()
    if not HAS_WORLD_MARKERS then return target end
    -- The clear-world-marker slash command compares against the localized ALL.
    -- Run through a secure hardware-click macro, never an insecure /run call.
    return string.format("%s %s\n%s", SLASH_CLEAR_WORLD_MARKER1 or "/cwm", ALL or "all", target)
end

local function ConfigureMarkerButton(btn, worldMarkerIndex, targetMarkerIndex)
    btn:RegisterForClicks("AnyDown")
    btn:SetAttribute("type", nil)
    btn:SetAttribute("type1", nil)
    btn:SetAttribute("type2", nil)
    btn:SetAttribute("action1", nil)
    btn:SetAttribute("marker", nil)
    btn:SetAttribute("macrotext1", nil)
    btn:SetAttribute("macrotext2", nil)

    if HAS_WORLD_MARKERS then
        btn:SetAttribute("type1", "worldmarker")
        btn:SetAttribute("marker", tostring(worldMarkerIndex))
        btn:SetAttribute("action1", "set")
    else
        btn:SetAttribute("type1", "macro")
        btn:SetAttribute("macrotext1", BuildTargetMarkerMacro(targetMarkerIndex))
    end

    btn:SetAttribute("type2", "macro")
    btn:SetAttribute("macrotext2", BuildTargetMarkerMacro(targetMarkerIndex))
end

local function SetButtonAvailable(btn, available)
    btn:SetAlpha(available and 1 or 0.45)
end

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
local DEFAULT_BS = 28
local MIN_BS           = 20
local MAX_BS           = 42
local BS_STEP          = 1
local DEFAULT_GAP      = 2
local DEFAULT_PAD      = 4
local MIN_GAP          = 0
local MAX_GAP          = 8
local GAP_STEP         = 1
local MINI_W           = DEFAULT_BS
local DEFAULT_SCALE    = 0.75
local MIN_SCALE        = 0.50
local MAX_SCALE        = 1.50
local SCALE_STEP       = 0.05
local MODERN_BG        = { r=0.025, g=0.033, b=0.043, a=0.92 }
local MODERN_PANEL     = { r=0.045, g=0.060, b=0.078, a=0.84 }
local MODERN_FIELD     = { r=0.035, g=0.045, b=0.060, a=0.96 }
local MODERN_BORDER    = { r=0.220, g=0.310, b=0.400 }
local MODERN_ACCENT    = { r=0.880, g=0.920, b=0.960 }
local MODERN_INACTIVE  = { r=0.055, g=0.067, b=0.082 }
local MODERN_HOVER     = { r=0.135, g=0.175, b=0.220 }
local MODERN_DOWN      = { r=0.035, g=0.045, b=0.060 }

-- Markers: { /wm index,  /tm index,  display name }
local MARKERS = {
    {8, 8, "Skull"},
    {7, 5, "Moon"},
    {6, 2, "Circle"},
    {5, 1, "Star"},
    {4, 7, "Cross"},
    {3, 3, "Diamond"},
    {2, 4, "Triangle"},
    {1, 6, "Square"},
}

-------------------------------------------------------------------------------
-- Theme presets
-- Preset index 0 is reserved for "custom" (saved separately in DB).
-------------------------------------------------------------------------------
local BORDER_PRESETS = {
    { name="Modern Slate", r=0.22, g=0.31, b=0.40 },
    { name="Silver", r=0.75, g=0.75, b=0.82 },
    { name="Gold",   r=0.80, g=0.65, b=0.05 },
    { name="Blue",   r=0.20, g=0.55, b=0.95 },
    { name="Green",  r=0.20, g=0.80, b=0.20 },
    { name="Red",    r=0.90, g=0.20, b=0.20 },
    { name="Purple", r=0.70, g=0.20, b=0.90 },
    { name="Teal",   r=0.10, g=0.80, b=0.70 },
    { name="White",  r=0.92, g=0.92, b=0.92 },
}

-- display = brighter stand-in shown in the swatch button
local BG_PRESETS = {
    { name="Ghost", r=0.025, g=0.033, b=0.043, a=0.30, display={0.18, 0.22, 0.26} },
    { name="Slate", r=0.025, g=0.033, b=0.043, a=0.92, display={0.08, 0.10, 0.13} },
    { name="Solid", r=0.025, g=0.033, b=0.043, a=0.99, display={0.04, 0.05, 0.06} },
}

local GOLD = {MODERN_ACCENT.r, MODERN_ACCENT.g, MODERN_ACCENT.b, 1}

-------------------------------------------------------------------------------
-- SavedVariables
-------------------------------------------------------------------------------
RaidBarDB = RaidBarDB or {}
local function DB(k, v)
    if v ~= nil then RaidBarDB[k] = v end
    return RaidBarDB[k]
end

-- Returns the active border preset table (handles preset 0 = custom).
local function GetBorderPreset()
    local idx = DB("borderPreset") or 1
    if idx == 0 then
        return {
            name = "Custom",
            r = DB("borderCustomR") or MODERN_BORDER.r,
            g = DB("borderCustomG") or MODERN_BORDER.g,
            b = DB("borderCustomB") or MODERN_BORDER.b,
        }
    end
    return BORDER_PRESETS[idx] or BORDER_PRESETS[1]
end

-- Returns the active background preset table (handles preset 0 = custom).
local function GetBGPreset()
    local idx = DB("bgPreset") or 2
    if idx == 0 then
        return {
            name = "Custom",
            r = DB("bgCustomR") or MODERN_BG.r,
            g = DB("bgCustomG") or MODERN_BG.g,
            b = DB("bgCustomB") or MODERN_BG.b,
            a = DB("bgCustomA") or MODERN_BG.a,
        }
    end
    return BG_PRESETS[idx] or BG_PRESETS[2]
end

-------------------------------------------------------------------------------
-- Themed frames + ApplyTheme
-------------------------------------------------------------------------------
local themedFrames = {}
local barFrames = {}
local modernPanelFrames = {}
local themedRules = {}
local modernButtons = {}
local layoutItems = {}
local UpdateSwatchSelections    -- forward declaration; assigned after settings panel
local UpdateOrientationBtn      -- forward declaration; assigned after settings panel
local UpdateFloatingBtn         -- forward declaration; assigned after settings panel
local UpdateMarkersOnlyBtn      -- forward declaration; assigned after settings panel
local UpdateTooltipBtn          -- forward declaration; assigned after settings panel
local UpdateLeaveBtn            -- forward declaration; assigned after settings panel
local UpdateVisibilityBtn       -- forward declaration; assigned after settings panel
local UpdateScaleControls       -- forward declaration; assigned after settings panel
local UpdateIconSizeControls    -- forward declaration; assigned after settings panel
local UpdateSpacingControls     -- forward declaration; assigned after settings panel
local ApplyLayout               -- forward declaration; assigned after buttons are created
local RefreshContentVisibility  -- forward declaration; assigned after buttons are created
local UpdateBarFrameSize        -- forward declaration; assigned after buttons are created
local RequestBarRefresh         -- forward declaration; assigned after ApplyMinimize
local RefreshBarVisibility      -- forward declaration; assigned after main frame

local function GetOrientation()
    return (DB("orientation") == "vertical") and "vertical" or "horizontal"
end

local function IsVertical()
    return GetOrientation() == "vertical"
end

local function IsFloating()
    return DB("floating") == true
end

local function IsMarkersOnly()
    return DB("markersOnly") == true
end

local function AreTooltipsEnabled()
    return DB("tooltips") ~= false
end

local function IsLeaveHidden()
    return DB("hideLeave") == true
end

local function IsLeaderAssistVisibilityEnabled()
    return DB("hideUnlessRaidLeadAssist") == true
end

local function IsPlayerRaidLeaderOrAssistant()
    if type(IsInRaid) ~= "function" or not IsInRaid() then
        return false
    end
    if type(UnitIsGroupLeader) == "function" and UnitIsGroupLeader("player") then
        return true
    end
    if type(UnitIsGroupAssistant) == "function" and UnitIsGroupAssistant("player") then
        return true
    end
    return false
end

local function ClampScale(scale)
    scale = tonumber(scale) or DEFAULT_SCALE
    scale = math.max(MIN_SCALE, math.min(MAX_SCALE, scale))
    return math.floor((scale / SCALE_STEP) + 0.5) * SCALE_STEP
end

local function ClampButtonSize(size)
    size = tonumber(size) or DEFAULT_BS
    size = math.max(MIN_BS, math.min(MAX_BS, size))
    return math.floor((size / BS_STEP) + 0.5) * BS_STEP
end

local function GetButtonSize()
    return ClampButtonSize(DB("buttonSize") or DEFAULT_BS)
end

local function ClampGap(gap)
    gap = tonumber(gap) or DEFAULT_GAP
    gap = math.max(MIN_GAP, math.min(MAX_GAP, gap))
    return math.floor((gap / GAP_STEP) + 0.5) * GAP_STEP
end

local function GetBarGap()
    return ClampGap(DB("spacing") or DEFAULT_GAP)
end

local function GetBarPad()
    return math.max(2, math.floor((GetBarGap() * (DEFAULT_PAD / DEFAULT_GAP)) + 0.5))
end

local function ApplyModernBackdrop(frame, alpha)
    if not frame or not frame.SetBackdrop then return end
    frame:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile=false, tileSize=0, edgeSize=1,
        insets={left=1, right=1, top=1, bottom=1},
    })
    frame:SetBackdropColor(MODERN_BG.r, MODERN_BG.g, MODERN_BG.b, alpha or MODERN_BG.a)
    local bp = GetBorderPreset()
    frame:SetBackdropBorderColor(bp.r, bp.g, bp.b, 0.95)
end

local function GetModernButtonBorder(btn)
    if btn and btn._rbFixedModern then
        return MODERN_BORDER
    end
    return GetBorderPreset()
end

local function SetModernButtonState(btn, state)
    if not (btn and btn.SetBackdropColor) then return end

    -- The minimize/drag button is part of the bar itself.  In floating mode its
    -- normal, hover, and pressed states must all remain fully transparent.
    if btn._rbTransparentWhenFloating and IsFloating() then
        btn:SetBackdropColor(0, 0, 0, 0)
        btn:SetBackdropBorderColor(0, 0, 0, 0)
        return
    end

    local color = MODERN_INACTIVE
    if state == "hover" then
        color = MODERN_HOVER
    elseif state == "down" then
        color = MODERN_DOWN
    end
    local bp = GetModernButtonBorder(btn)
    btn:SetBackdropColor(color.r, color.g, color.b, 0.95)
    btn:SetBackdropBorderColor(bp.r, bp.g, bp.b, state == "hover" and 1 or 0.9)
end

local function StyleModernButton(btn)
    if not btn or not btn.SetBackdrop then return end
    btn._rbModernButton = true
    modernButtons[#modernButtons+1] = btn
    ApplyModernBackdrop(btn, 0.95)
    btn:SetBackdropColor(MODERN_INACTIVE.r, MODERN_INACTIVE.g, MODERN_INACTIVE.b, 0.95)
    local hi = btn:CreateTexture(nil, "HIGHLIGHT")
    hi:SetAllPoints()
    hi:SetColorTexture(MODERN_HOVER.r, MODERN_HOVER.g, MODERN_HOVER.b, 0.22)
    btn:SetHighlightTexture(hi, "ADD")
    btn._rbHighlightTexture = hi
    local pushed = btn:CreateTexture(nil, "BACKGROUND")
    pushed:SetAllPoints()
    pushed:SetColorTexture(MODERN_DOWN.r, MODERN_DOWN.g, MODERN_DOWN.b, 0.70)
    btn:SetPushedTexture(pushed)
    btn._rbPushedTexture = pushed
    btn:SetScript("OnEnter", function(self)
        SetModernButtonState(self, "hover")
    end)
    btn:SetScript("OnLeave", function(self)
        SetModernButtonState(self, "normal")
    end)
    btn:SetScript("OnMouseDown", function(self)
        SetModernButtonState(self, "down")
    end)
    btn:SetScript("OnMouseUp", function(self)
        SetModernButtonState(self, "hover")
    end)
end

local function ApplyTheme()
    local bp = GetBorderPreset()
    local bg = GetBGPreset()
    for _, fr in ipairs(themedFrames) do
        fr:SetBackdropBorderColor(bp.r, bp.g, bp.b, 1)
        fr:SetBackdropColor(bg.r, bg.g, bg.b, bg.a)
    end
    for _, rule in ipairs(themedRules) do
        rule:SetColorTexture(bp.r, bp.g, bp.b, 0.72)
    end
    for _, fr in ipairs(modernPanelFrames) do
        if fr.SetBackdropColor then
            fr:SetBackdropColor(bg.r, bg.g, bg.b, bg.a)
            fr:SetBackdropBorderColor(bp.r, bp.g, bp.b, 0.95)
        end
    end
    for _, btn in ipairs(modernButtons) do
        local transparent = btn._rbTransparentWhenFloating and IsFloating()
        if btn._rbHighlightTexture then btn._rbHighlightTexture:SetAlpha(transparent and 0 or 1) end
        if btn._rbPushedTexture then btn._rbPushedTexture:SetAlpha(transparent and 0 or 1) end
        SetModernButtonState(btn, "normal")
    end
    if IsFloating() then
        for _, fr in ipairs(barFrames) do
            fr:SetBackdropBorderColor(bp.r, bp.g, bp.b, 0)
            fr:SetBackdropColor(0, 0, 0, 0)
        end
    end
    if UpdateSwatchSelections then UpdateSwatchSelections() end
    if UpdateOrientationBtn then UpdateOrientationBtn() end
    if UpdateFloatingBtn then UpdateFloatingBtn() end
    if UpdateMarkersOnlyBtn then UpdateMarkersOnlyBtn() end
    if UpdateTooltipBtn then UpdateTooltipBtn() end
    if UpdateLeaveBtn then UpdateLeaveBtn() end
    if UpdateVisibilityBtn then UpdateVisibilityBtn() end
    if UpdateScaleControls then UpdateScaleControls() end
    if UpdateIconSizeControls then UpdateIconSizeControls() end
    if UpdateSpacingControls then UpdateSpacingControls() end
end

-------------------------------------------------------------------------------
-- Main frame
-------------------------------------------------------------------------------
local f = CreateFrame("Frame", "RaidBarFrame", UIParent, WithBackdropTemplate())
f:SetClampedToScreen(true)
f:SetMovable(true)
ApplyModernBackdrop(f)
themedFrames[#themedFrames+1] = f
barFrames[#barFrames+1] = f

local encounterActive = false

local function ShouldShowBar()
    if IsLeaderAssistVisibilityEnabled() and not IsPlayerRaidLeaderOrAssistant() then
        return false
    end
    if DB("encounterAutoShow") and not encounterActive then
        return false
    end
    return true
end

RefreshBarVisibility = function()
    -- The bar parents secure raid-target buttons, so Show/Hide on the
    -- frame is protected in combat. Defer until PLAYER_REGEN_ENABLED,
    -- which already calls RefreshBarVisibility again.
    if InCombatLockdown() then return end
    if ShouldShowBar() then
        f:Show()
    else
        f:Hide()
    end
end

-------------------------------------------------------------------------------
-- Layout helpers
-------------------------------------------------------------------------------
local function AddSep(group)
    local s = f:CreateTexture(nil, "ARTWORK")
    s:SetTexture("Interface\\Buttons\\WHITE8x8")
    s:SetVertexColor(GOLD[1], GOLD[2], GOLD[3], 0.35)
    layoutItems[#layoutItems+1] = { kind = "sep", frame = s, group = group or "main" }
end

local function AddBtn(name, template, group)
    local btn = CreateFrame("Button", name, f, template)
    btn:SetSize(DEFAULT_BS, DEFAULT_BS)
    btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("TOPLEFT",     btn, "TOPLEFT",      2, -2)
    icon:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -2,  2)
    btn.icon = icon
    layoutItems[#layoutItems+1] = { kind = "btn", frame = btn, group = group or "main" }
    return btn
end

local function Tip(w, title, sub)
    w:SetScript("OnEnter", function(self)
        if self._rbModernButton and self.SetBackdropColor then
            SetModernButtonState(self, "hover")
        end
        if not AreTooltipsEnabled() then return end
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(title, 1, 1, 1)
        if sub then GameTooltip:AddLine(sub, 0.7, 0.7, 0.7, true) end
        GameTooltip:Show()
    end)
    w:SetScript("OnLeave", function(self)
        if self._rbModernButton and self.SetBackdropColor then
            SetModernButtonState(self, "normal")
        end
        GameTooltip:Hide()
    end)
end

local function GoldLabel(btn, text)
    local fs = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fs:SetAllPoints()
    fs:SetText(text)
    fs:SetTextColor(unpack(GOLD))
    fs:SetJustifyH("CENTER"); fs:SetJustifyV("MIDDLE")
end

-------------------------------------------------------------------------------
-- Mini / collapse button
-------------------------------------------------------------------------------
local miniBtn = CreateFrame("Button", "RaidBarMiniBtn", f, WithBackdropTemplate("SecureActionButtonTemplate"))
miniBtn:RegisterForClicks("AnyDown", "AnyUp")
miniBtn:SetAttribute("type2", "macro")
miniBtn:SetAttribute("macrotext2", BuildClearMarkersMacro())
miniBtn:SetSize(MINI_W, DEFAULT_BS)
miniBtn._rbTransparentWhenFloating = true
StyleModernButton(miniBtn)
themedFrames[#themedFrames+1] = miniBtn
barFrames[#barFrames+1] = miniBtn

local miniLbl = miniBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
miniLbl:SetAllPoints()
miniLbl:SetText("-")
miniLbl:SetTextColor(unpack(GOLD))
miniLbl:SetJustifyH("CENTER"); miniLbl:SetJustifyV("MIDDLE")

Tip(miniBtn, "RaidBar",
    "Drag: Move bar  |  Left-click: Minimize/Expand\n"..
    "Right-click: Clear all ground markers and your target's icon\n"..
    "/raidbar: Settings")

local function SavePos()
    -- GetLeft/GetBottom already return UIParent coordinates (not affected by
    -- the frame's own scale), so no conversion is needed before storing.
    DB("lx", math.floor(f:GetLeft()   + 0.5))
    DB("y",  math.floor(f:GetBottom() + 0.5))
end

local function GetMiniBtnCenter()
    local x, y = miniBtn:GetCenter()
    if x and y then return x, y end
end

local function ReanchorFrameToKeepMiniBtn(oldX, oldY)
    if not (oldX and oldY) then return end

    local newX, newY = miniBtn:GetCenter()
    local left = f:GetLeft()
    local bottom = f:GetBottom()

    if not (newX and newY and left and bottom) then return end

    f:ClearAllPoints()
    f:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left + (oldX - newX), bottom + (oldY - newY))
    SavePos()
end

local currentFullW = GetBarPad() * 2 + GetButtonSize()
local currentFullH = GetBarPad() * 2 + GetButtonSize()

UpdateBarFrameSize = function()
    local pad = GetBarPad()
    local btnSize = GetButtonSize()
    if DB("minimized") then
        f:SetSize(pad * 2 + btnSize, pad * 2 + btnSize)
    else
        f:SetSize(currentFullW, currentFullH)
    end
end

RefreshContentVisibility = function()
    local minimized = DB("minimized")
    for _, item in ipairs(layoutItems) do
        if minimized or item.hiddenByLayout then
            item.frame:Hide()
        else
            item.frame:Show()
        end
    end
    miniLbl:SetText(minimized and "+" or "-")
    UpdateBarFrameSize()
end

ApplyLayout = function()
    local vertical = IsVertical()
    local floating = IsFloating()
    local markersOnly = IsMarkersOnly()
    local btnSize = GetButtonSize()
    local pad = GetBarPad()
    local gap = GetBarGap()
    local inset = math.max(2, math.floor(btnSize * 0.08 + 0.5))
    local cursor = pad

    miniBtn:SetSize(btnSize, btnSize)
    miniBtn:ClearAllPoints()
    if vertical then
        miniBtn:SetPoint("TOP", f, "TOP", 0, -cursor)
    else
        miniBtn:SetPoint("LEFT", f, "LEFT", cursor, 0)
    end
    cursor = cursor + btnSize

    for _, item in ipairs(layoutItems) do
        local widget = item.frame
        local spanW, spanH = btnSize, btnSize

        widget:ClearAllPoints()
        item.hiddenByLayout =
            (markersOnly and (item.group == "utility" or item.group == "leave")) or
            (IsLeaveHidden() and item.group == "leave")

        if not item.hiddenByLayout and item.kind == "sep" then
            if floating then
                item.hiddenByLayout = true
                spanW, spanH = 0, 0
            elseif vertical then
                spanW, spanH = btnSize - 4, 1
            else
                spanW, spanH = 1, btnSize - 4
            end
        end

        if not item.hiddenByLayout then
            widget:SetSize(spanW, spanH)
            if item.kind == "btn" and widget.icon then
                widget.icon:ClearAllPoints()
                widget.icon:SetPoint("TOPLEFT", widget, "TOPLEFT", inset, -inset)
                widget.icon:SetPoint("BOTTOMRIGHT", widget, "BOTTOMRIGHT", -inset, inset)
            end
            cursor = cursor + gap
            if vertical then
                widget:SetPoint("TOP", f, "TOP", 0, -cursor)
            else
                widget:SetPoint("LEFT", f, "LEFT", cursor, 0)
            end
            if vertical then
                cursor = cursor + spanH
            else
                cursor = cursor + spanW
            end
        end
    end

    if vertical then
        currentFullW = pad * 2 + btnSize
        currentFullH = cursor + pad
    else
        currentFullW = cursor + pad
        currentFullH = pad * 2 + btnSize
    end

    RefreshContentVisibility()
end

local function SetBarScale(newScale)
    DB("scale", ClampScale(newScale))
    RequestBarRefresh()
    if UpdateScaleControls then UpdateScaleControls() end
end

local function SetButtonSize(newSize)
    DB("buttonSize", ClampButtonSize(newSize))
    RequestBarRefresh()
    if UpdateIconSizeControls then UpdateIconSizeControls() end
end

local function SetBarSpacing(newGap)
    DB("spacing", ClampGap(newGap))
    RequestBarRefresh()
    if UpdateSpacingControls then UpdateSpacingControls() end
end

-------------------------------------------------------------------------------
-- Hide the manager's chrome, never its protected raid/party container.
-------------------------------------------------------------------------------
-- Never hook OnShow or replace Show on CompactRaidFrameManager: even an
-- out-of-combat installation leaves addon code in Blizzard's protected update
-- path. Old hooks/method overrides disappear on reload with this version.
local blizzAlpha, blizzMouse = {}, {}

local function SuppressAlpha(region)
    if not region then return end
    if blizzAlpha[region] == nil then blizzAlpha[region] = region:GetAlpha() end
    region:SetAlpha(0)
end

local function SuppressMouse(frame)
    if not frame then return end
    if blizzMouse[frame] == nil then blizzMouse[frame] = frame:IsMouseEnabled() end
    frame:EnableMouse(false)
end

local function SuppressControlMouse(frame)
    if not frame then return end
    SuppressMouse(frame)
    for _, child in ipairs({ frame:GetChildren() }) do
        SuppressControlMouse(child)
    end
end

local function ApplyBlizzRaidUI()
    if InCombatLockdown() then return end
    if DB("blizzui") ~= false then
        for region, alpha in pairs(blizzAlpha) do region:SetAlpha(alpha) end
        for frame, enabled in pairs(blizzMouse) do frame:EnableMouse(enabled) end
        wipe(blizzAlpha)
        wipe(blizzMouse)
        return
    end

    local manager = _G.CompactRaidFrameManager
    if not manager then return end -- Retried after load-on-demand UI loads.
    -- Do not change manager alpha: Classic parents CompactRaidFrameContainer
    -- to it. Only target the manager's own regions and its two control trees.
    for _, region in ipairs({ manager:GetRegions() }) do SuppressAlpha(region) end
    SuppressMouse(manager)
    local display = manager.displayFrame or _G.CompactRaidFrameManagerDisplayFrame
    local toggle = manager.toggleButton or _G.CompactRaidFrameManagerToggleButton
    SuppressAlpha(display)
    SuppressAlpha(toggle)
    SuppressControlMouse(display)
    SuppressControlMouse(toggle)

    -- Newer clients add more chrome (the arrow toggles, the edge strip). Hide
    -- every other child of the manager too, except the protected raid container.
    local container = manager.container or _G.CompactRaidFrameContainer
    local extras = { _G.CompactRaidFrameManagerToggleButtonForward,
                     _G.CompactRaidFrameManagerToggleButtonBack,
                     manager.toggleButtonForward, manager.toggleButtonBack }
    for _, child in ipairs({ manager:GetChildren() }) do extras[#extras + 1] = child end
    for _, child in ipairs(extras) do
        if child and child ~= container and child ~= display and child ~= toggle then
            SuppressAlpha(child)
            SuppressControlMouse(child)
        end
    end
end

local function ToggleBlizzRaidUI()
    local visible = DB("blizzui") == false
    DB("blizzui", visible)
    ApplyBlizzRaidUI()
    local status = visible and "shown" or "hidden"
    if InCombatLockdown() then status = status .. " after combat" end
    print("|cFFD8DDE6RaidBar:|r Blizzard raid manager panel " .. status .. ".")
end

-------------------------------------------------------------------------------
-- miniBtn: drag + click (fixes stuck-to-mouse bug)
-------------------------------------------------------------------------------
local ApplyMinimize       -- forward declaration; defined after the full layout
local rbDownX, rbDownY = nil, nil

miniBtn:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        rbDownX, rbDownY = GetCursorPosition()
        if not InCombatLockdown() and not DB("locked") then
            f:StartMoving()
        end
    end
end)

miniBtn:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        if not InCombatLockdown() and not DB("locked") then
            f:StopMovingOrSizing()
            -- Re-anchor explicitly to BOTTOMLEFT so the saved coords are always
            -- in a clean, consistent state regardless of how WoW left the anchor
            -- after the drag.
            local bx, by = f:GetLeft(), f:GetBottom()
            f:ClearAllPoints()
            f:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", bx, by)
            SavePos()
        end
        if rbDownX then
            local x, y = GetCursorPosition()
            if math.abs(x - rbDownX) < 5 and math.abs(y - rbDownY) < 5 then
                ApplyMinimize(not DB("minimized"))
            end
            rbDownX, rbDownY = nil, nil
        end
    end
end)

AddSep("main")

-------------------------------------------------------------------------------
-- Raid marker buttons
-------------------------------------------------------------------------------
local wmActive = {}

local function SetWMGlow(btn, active)
    if btn.activeGlow then
        if active then btn.activeGlow:Show() else btn.activeGlow:Hide() end
    end
end

miniBtn:HookScript("PostClick", function(self, button)
    if button ~= "RightButton" or not HAS_WORLD_MARKERS or not IsRaidMarkerActive then return end
    -- Read actual state after the secure click; a rejected clear must not
    -- falsely turn off the marker glows. Both click phases are registered.
    for i, m in ipairs(MARKERS) do
        wmActive[m[1]] = IsRaidMarkerActive(m[1])
        local btn = _G["RaidBarMarker"..i]
        if btn then SetWMGlow(btn, wmActive[m[1]]) end
    end
end)

for i, m in ipairs(MARKERS) do
    local wmIdx, tmIdx, mName = m[1], m[2], m[3]
    local btn = AddBtn("RaidBarMarker"..i, "SecureActionButtonTemplate", "markers")
    btn.icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..tmIdx)
    if HAS_WORLD_MARKERS then
        Tip(btn, mName.." Marker",
            "Left: Place world marker  |  Right: Stamp target icon")
    else
        Tip(btn, mName.." Marker",
            "World markers are unavailable on this client.\nLeft/Right: Stamp target icon")
    end
    ConfigureMarkerButton(btn, wmIdx, tmIdx)
    local glow = btn:CreateTexture(nil, "OVERLAY", nil, 7)
    glow:SetAllPoints()
    glow:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
    glow:SetBlendMode("ADD")
    glow:SetVertexColor(1, 0.85, 0.1, 1)
    glow:Hide()
    btn.activeGlow = glow
    btn:HookScript("OnMouseDown", function(self, button)
        if HAS_WORLD_MARKERS and button == "LeftButton" then
            wmActive[wmIdx] = not wmActive[wmIdx]
            SetWMGlow(self, wmActive[wmIdx])
        end
    end)
end

AddSep("utility")

-------------------------------------------------------------------------------
-- Utility buttons
-------------------------------------------------------------------------------
local rcBtn = AddBtn("RaidBarRC", nil, "utility")
GoldLabel(rcBtn, "RC")
Tip(rcBtn, "Ready Check", "Requires group leader or assistant")
rcBtn:SetScript("OnClick", function()
    if IsInGroup() then DoReadyCheck() end
end)

local pt5Btn = AddBtn("RaidBarPT5", nil, "utility")
GoldLabel(pt5Btn, "5s")
Tip(pt5Btn, "Pull Timer — 5 seconds", "Requires group leader or assistant")
if HAS_PULL_COUNTDOWN then
    Tip(pt5Btn, "Pull Timer - 5 seconds", "Requires group leader or assistant")
else
    Tip(pt5Btn, "Pull Timer Unavailable", "This client does not expose the pull countdown API")
end
pt5Btn:SetScript("OnClick", function()
    if IsInGroup() and not StartPullCountdown(5) then
        print("|cFFD8DDE6RaidBar:|r Pull countdowns are not available on this client.")
    end
end)
SetButtonAvailable(pt5Btn, HAS_PULL_COUNTDOWN)

local pt10Btn = AddBtn("RaidBarPT10", nil, "utility")
GoldLabel(pt10Btn, "10s")
Tip(pt10Btn, "Pull Timer — 10 seconds", "Requires group leader or assistant")
if HAS_PULL_COUNTDOWN then
    Tip(pt10Btn, "Pull Timer - 10 seconds", "Requires group leader or assistant")
else
    Tip(pt10Btn, "Pull Timer Unavailable", "This client does not expose the pull countdown API")
end
pt10Btn:SetScript("OnClick", function()
    if IsInGroup() and not StartPullCountdown(10) then
        print("|cFFD8DDE6RaidBar:|r Pull countdowns are not available on this client.")
    end
end)
SetButtonAvailable(pt10Btn, HAS_PULL_COUNTDOWN)

local cwBtn = AddBtn("RaidBarCW", "SecureActionButtonTemplate", "utility")
GoldLabel(cwBtn, "|cFFFF8888CW|r")
Tip(cwBtn, "Clear World Markers", "Removes all 8 ground/world markers")
cwBtn:RegisterForClicks("AnyDown", "AnyUp")
if HAS_WORLD_MARKERS then
    -- A missing marker attribute clears all markers in Blizzard's secure
    -- worldmarker action. Only the hardware left click performs the action.
    cwBtn:SetAttribute("type1", "worldmarker")
    cwBtn:SetAttribute("action1", "clear")
end
cwBtn:HookScript("PostClick", function(self, button)
    if not HAS_WORLD_MARKERS then
        print("|cFFD8DDE6RaidBar:|r World markers are not available on this client.")
        return
    end
    if button == "LeftButton" then
        for i, m in ipairs(MARKERS) do
            wmActive[m[1]] = false
            local btn = _G["RaidBarMarker"..i]
            if btn then SetWMGlow(btn, false) end
        end
    end
end)
if not HAS_WORLD_MARKERS then
    Tip(cwBtn, "World Markers Unavailable", "This client only supports target icons")
end
SetButtonAvailable(cwBtn, HAS_WORLD_MARKERS)

local ctBtn = AddBtn("RaidBarCT", "SecureActionButtonTemplate", "utility")
GoldLabel(ctBtn, "|cFFFF8888CT|r")
Tip(ctBtn, "Clear Target Mark", "Removes raid icon from your current target")
ctBtn:RegisterForClicks("AnyDown", "AnyUp")
ctBtn:SetAttribute("type", "macro")
ctBtn:SetAttribute("macrotext", BuildClearTargetMarkerMacro())

local lvBtn = AddBtn("RaidBarLeave", nil, "leave")
GoldLabel(lvBtn, "|cFFFF4444X|r")
Tip(lvBtn, "Leave Group",
    "Click: Leave party/raid\nShift+Right-click: Toggle Blizzard raid UI")
lvBtn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
lvBtn:SetScript("OnClick", function(self, btn)
    if btn == "RightButton" and IsShiftKeyDown() then
        ToggleBlizzRaidUI()
    elseif btn == "LeftButton" then
        if IsInGroup() then StaticPopup_Show("RAIDBAR_LEAVE_GROUP") end
    end
end)

StaticPopupDialogs["RAIDBAR_LEAVE_GROUP"] = {
    text="Leave the current group?", button1="Leave", button2="Cancel",
    OnAccept=function() LeaveCurrentGroup() end,
    timeout=0, whileDead=true, hideOnEscape=true,
}

-------------------------------------------------------------------------------
-- Minimize / expand
-------------------------------------------------------------------------------
local pendingMini = nil
local pendingBarRefresh = false

ApplyMinimize = function(mini)   -- assigns to forward-declared upvalue
    if InCombatLockdown() then pendingMini = mini; return end
    local oldX, oldY = GetMiniBtnCenter()
    DB("minimized", mini)
    RefreshContentVisibility()
    ReanchorFrameToKeepMiniBtn(oldX, oldY)
end

RequestBarRefresh = function()
    if InCombatLockdown() then
        pendingBarRefresh = true
        return
    end
    local oldX, oldY = GetMiniBtnCenter()
    local scale = ClampScale(DB("scale") or DEFAULT_SCALE)

    pendingBarRefresh = false
    DB("scale", scale)
    ApplyLayout()
    f:SetScale(scale)
    ApplyTheme()
    ReanchorFrameToKeepMiniBtn(oldX, oldY)
end

-------------------------------------------------------------------------------
-- Settings panel helpers (defined before the panel so closures can call them)
-------------------------------------------------------------------------------

-- Open WoW's native color picker for the border color.
local function OpenBorderColorPicker()
    if not ColorPickerFrame then return end
    local bp = GetBorderPreset()
    local prevPreset = DB("borderPreset") or 1
    local prevR = DB("borderCustomR")
    local prevG = DB("borderCustomG")
    local prevB = DB("borderCustomB")
    OpenColorPickerCompat({
        r = bp.r, g = bp.g, b = bp.b,
        swatchFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            DB("borderPreset",  0)
            DB("borderCustomR", r)
            DB("borderCustomG", g)
            DB("borderCustomB", b)
            ApplyTheme()
        end,
        cancelFunc = function()
            DB("borderPreset",  prevPreset)
            DB("borderCustomR", prevR)
            DB("borderCustomG", prevG)
            DB("borderCustomB", prevB)
            ApplyTheme()
        end,
    })
end

-- Open WoW's native color picker (with opacity) for the background.
local function OpenBGColorPicker()
    if not ColorPickerFrame then return end
    local bg = GetBGPreset()
    local prevPreset = DB("bgPreset") or 2
    local prevR = DB("bgCustomR")
    local prevG = DB("bgCustomG")
    local prevB = DB("bgCustomB")
    local prevA = DB("bgCustomA")
    OpenColorPickerCompat({
        r = bg.r, g = bg.g, b = bg.b,
        opacity    = bg.a,     -- 0 = transparent, 1 = opaque
        hasOpacity = true,
        swatchFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = GetColorPickerAlpha()
            DB("bgPreset",  0)
            DB("bgCustomR", r)
            DB("bgCustomG", g)
            DB("bgCustomB", b)
            DB("bgCustomA", a)
            ApplyTheme()
        end,
        cancelFunc = function()
            DB("bgPreset",  prevPreset)
            DB("bgCustomR", prevR)
            DB("bgCustomG", prevG)
            DB("bgCustomB", prevB)
            DB("bgCustomA", prevA)
            ApplyTheme()
        end,
    })
end

-- Creates a 1px white outline ring around a frame used as a "selected" indicator.
-- Returns a table with Show() / Hide() methods.
local function MakeSelRing(parent)
    local lines = {}
    local function MkLine(p1, x1, y1, p2, x2, y2)
        local t = parent:CreateTexture(nil, "OVERLAY")
        t:SetTexture("Interface\\Buttons\\WHITE8x8")
        t:SetVertexColor(1, 1, 1, 1)
        t:SetPoint(p1, parent, p1, x1,  y1)
        t:SetPoint(p2, parent, p2, x2,  y2)
        t:Hide()
        lines[#lines+1] = t
    end
    MkLine("TOPLEFT",     0,  0, "TOPRIGHT",     0, -1)
    MkLine("BOTTOMLEFT",  0,  1, "BOTTOMRIGHT",  0,  0)
    MkLine("TOPLEFT",     0,  0, "BOTTOMLEFT",   1,  0)
    MkLine("TOPRIGHT",   -1,  0, "BOTTOMRIGHT",  0,  0)
    return {
        Show = function() for _, t in ipairs(lines) do t:Show() end end,
        Hide = function() for _, t in ipairs(lines) do t:Hide() end end,
    }
end

-------------------------------------------------------------------------------
-- Settings panel
-------------------------------------------------------------------------------
local SF_W   = 280
local SF_H   = 574
local SF_PAD = 10

local settingsFrame = CreateFrame("Frame", "RaidBarSettingsFrame", UIParent, WithBackdropTemplate())
settingsFrame:SetSize(SF_W, SF_H)
settingsFrame:SetMovable(true)
settingsFrame:EnableMouse(true)
settingsFrame:RegisterForDrag("LeftButton")
settingsFrame:SetScript("OnDragStart", settingsFrame.StartMoving)
settingsFrame:SetScript("OnDragStop",  settingsFrame.StopMovingOrSizing)
settingsFrame:SetClampedToScreen(true)
settingsFrame:SetFrameStrata("HIGH")
settingsFrame:Hide()
ApplyModernBackdrop(settingsFrame)
do
    local bp = GetBorderPreset()
    local bg = GetBGPreset()
    settingsFrame:SetBackdropColor(bg.r, bg.g, bg.b, bg.a)
    settingsFrame:SetBackdropBorderColor(bp.r, bp.g, bp.b, 0.95)
end
modernPanelFrames[#modernPanelFrames+1] = settingsFrame

local sfHeaderBg = settingsFrame:CreateTexture(nil, "BACKGROUND")
sfHeaderBg:SetPoint("TOPLEFT", 6, -6)
sfHeaderBg:SetPoint("TOPRIGHT", -6, -6)
sfHeaderBg:SetHeight(36)
sfHeaderBg:SetColorTexture(MODERN_PANEL.r, MODERN_PANEL.g, MODERN_PANEL.b, MODERN_PANEL.a)

local sfHeaderRule = settingsFrame:CreateTexture(nil, "BORDER")
sfHeaderRule:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", 6, -42)
sfHeaderRule:SetPoint("TOPRIGHT", settingsFrame, "TOPRIGHT", -6, -42)
sfHeaderRule:SetHeight(1)
sfHeaderRule:SetColorTexture(MODERN_BORDER.r, MODERN_BORDER.g, MODERN_BORDER.b, 0.72)
themedRules[#themedRules+1] = sfHeaderRule

-- Title
local sfTitle = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
sfTitle:SetPoint("TOP", settingsFrame, "TOP", 0, -12)
sfTitle:SetText("|cFFD8DDE6RaidBar Settings|r")

-- Close [X] button
local sfClose = CreateFrame("Button", nil, settingsFrame, WithBackdropTemplate())
sfClose:SetSize(24, 22)
sfClose:SetPoint("TOPRIGHT", settingsFrame, "TOPRIGHT", -10, -10)
StyleModernButton(sfClose)
local sfCloseLbl = sfClose:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
sfCloseLbl:SetAllPoints()
sfCloseLbl:SetText("|cFFD8DDE6X|r")
sfCloseLbl:SetJustifyH("CENTER"); sfCloseLbl:SetJustifyV("MIDDLE")
sfClose:SetScript("OnClick", function() settingsFrame:Hide() end)
Tip(sfClose, "Close Settings")

-- Section header helper
local function SFHeader(text, yOff)
    local fs = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fs:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", SF_PAD, yOff)
    fs:SetText("|cFFD8DDE6" .. text .. "|r")
end

-- Action button helper (LEFT or RIGHT anchor, two-column layout)
local function SFBtn(label, w, yOff, xMode, onClick)
    local btn = CreateFrame("Button", nil, settingsFrame, WithBackdropTemplate())
    btn:SetSize(w, 22)
    if xMode == "LEFT" then
        btn:SetPoint("TOPLEFT",  settingsFrame, "TOPLEFT",  SF_PAD,  yOff)
    else
        btn:SetPoint("TOPRIGHT", settingsFrame, "TOPRIGHT", -SF_PAD, yOff)
    end
    StyleModernButton(btn)
    local fs = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fs:SetAllPoints()
    fs:SetText(label)
    fs:SetTextColor(unpack(GOLD))
    fs:SetJustifyH("CENTER"); fs:SetJustifyV("MIDDLE")
    btn.label = fs
    if onClick then btn:SetScript("OnClick", onClick) end
    return btn
end

-- ── Section: Border Color ─────────────────────────────────────────────────────
SFHeader("Border Color", -30)

local borderSwatches = {}
local SW   = 22    -- swatch size
local SWGP =  3    -- gap between swatches

for i, p in ipairs(BORDER_PRESETS) do
    local sw = CreateFrame("Button", nil, settingsFrame, WithBackdropTemplate())
    sw:SetSize(SW, SW)
    sw:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT",
        SF_PAD + (i-1)*(SW+SWGP), -48)
    sw:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        insets   = {left=1, right=1, top=1, bottom=1},
    })
    sw:SetBackdropColor(p.r, p.g, p.b, 1)
    sw:SetBackdropBorderColor(MODERN_BORDER.r, MODERN_BORDER.g, MODERN_BORDER.b, 0.80)
    Tip(sw, p.name .. " Border")
    -- setSelected: white border = active, dark = inactive
    sw.setSelected = function(sel)
        sw:SetBackdropBorderColor(sel and 1 or MODERN_BORDER.r, sel and 1 or MODERN_BORDER.g, sel and 1 or MODERN_BORDER.b, sel and 1 or 0.8)
    end
    borderSwatches[i] = sw
    sw:SetScript("OnClick", function()
        DB("borderPreset", i)
        ApplyTheme()
    end)
end

-- Rainbow "Custom" border swatch — opens WoW color picker
local customBorderSwatch = CreateFrame("Button", nil, settingsFrame)
customBorderSwatch:SetSize(SW, SW)
customBorderSwatch:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT",
    SF_PAD + #BORDER_PRESETS*(SW+SWGP), -48)

do  -- rainbow color bands (vertical strips)
    local RAINBOW = {
        {1.0, 0.10, 0.10},
        {1.0, 0.50, 0.05},
        {0.95, 0.95, 0.05},
        {0.10, 0.90, 0.10},
        {0.10, 0.40, 1.00},
        {0.70, 0.10, 1.00},
    }
    local n = #RAINBOW
    for i, c in ipairs(RAINBOW) do
        local x0 = math.floor((i-1) * SW / n)
        local x1 = math.floor(i     * SW / n)
        local seg = customBorderSwatch:CreateTexture(nil, "BACKGROUND")
        seg:SetTexture("Interface\\Buttons\\WHITE8x8")
        seg:SetVertexColor(c[1], c[2], c[3], 1)
        seg:SetPoint("TOPLEFT",     customBorderSwatch, "TOPLEFT",     x0,  0)
        seg:SetPoint("BOTTOMRIGHT", customBorderSwatch, "BOTTOMLEFT", x1,  0)
    end
end

Tip(customBorderSwatch, "Custom Border Color", "Opens the color picker")
customBorderSwatch.ring = MakeSelRing(customBorderSwatch)
customBorderSwatch.setSelected = function(sel)
    if sel then customBorderSwatch.ring.Show() else customBorderSwatch.ring.Hide() end
end
customBorderSwatch:SetScript("OnClick", OpenBorderColorPicker)

-- ── Section: Background Style ─────────────────────────────────────────────────
SFHeader("Background Style", -82)

-- Auto-size BG buttons to fill the interior width (3 presets + 1 custom)
local numBGBtns = #BG_PRESETS + 1
local BG_GP = 3
local BG_W  = math.floor((SF_W - SF_PAD*2 - (numBGBtns-1)*BG_GP) / numBGBtns)

local bgSwatches = {}

for i, p in ipairs(BG_PRESETS) do
    local sw = CreateFrame("Button", nil, settingsFrame, WithBackdropTemplate())
    sw:SetSize(BG_W, SW)
    sw:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT",
        SF_PAD + (i-1)*(BG_W+BG_GP), -100)
    sw:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        insets   = {left=1, right=1, top=1, bottom=1},
    })
    local d = p.display
    sw:SetBackdropColor(d[1], d[2], d[3], 1)
    sw:SetBackdropBorderColor(MODERN_BORDER.r, MODERN_BORDER.g, MODERN_BORDER.b, 0.80)
    local lbl = sw:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    lbl:SetAllPoints()
    lbl:SetText(p.name)
    lbl:SetTextColor(0.95, 0.95, 0.95)
    lbl:SetJustifyH("CENTER"); lbl:SetJustifyV("MIDDLE")
    Tip(sw, p.name .. " Background")
    sw.setSelected = function(sel)
        sw:SetBackdropBorderColor(sel and 1 or MODERN_BORDER.r, sel and 1 or MODERN_BORDER.g, sel and 1 or MODERN_BORDER.b, sel and 1 or 0.8)
    end
    bgSwatches[i] = sw
    sw:SetScript("OnClick", function()
        DB("bgPreset", i)
        ApplyTheme()
    end)
end

-- Gradient "Custom" background swatch — opens WoW color picker with opacity
local customBGSwatch = CreateFrame("Button", nil, settingsFrame)
customBGSwatch:SetSize(BG_W, SW)
customBGSwatch:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT",
    SF_PAD + #BG_PRESETS*(BG_W+BG_GP), -100)

do  -- gradient: lighter left → darker right (suggests color+opacity control)
    local grad = customBGSwatch:CreateTexture(nil, "BACKGROUND")
    grad:SetAllPoints()
    grad:SetTexture("Interface\\Buttons\\WHITE8x8")
    if CreateColor then
        grad:SetGradient("HORIZONTAL",
            CreateColor(0.50, 0.50, 0.50, 1),
            CreateColor(0.08, 0.08, 0.08, 1))
    else
        grad:SetVertexColor(0.30, 0.30, 0.30, 1)
    end
    local lbl = customBGSwatch:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    lbl:SetAllPoints()
    lbl:SetText("|cFFFFFFFF+|r")
    lbl:SetJustifyH("CENTER"); lbl:SetJustifyV("MIDDLE")
end

Tip(customBGSwatch, "Custom Background", "Opens color + opacity picker")
customBGSwatch.ring = MakeSelRing(customBGSwatch)
customBGSwatch.setSelected = function(sel)
    if sel then customBGSwatch.ring.Show() else customBGSwatch.ring.Hide() end
end
customBGSwatch:SetScript("OnClick", OpenBGColorPicker)

-- ── Divider ───────────────────────────────────────────────────────────────────
local sfDiv = settingsFrame:CreateTexture(nil, "ARTWORK")
sfDiv:SetHeight(1)
sfDiv:SetPoint("TOPLEFT",  settingsFrame, "TOPLEFT",   SF_PAD, -132)
sfDiv:SetPoint("TOPRIGHT", settingsFrame, "TOPRIGHT", -SF_PAD, -132)
sfDiv:SetTexture("Interface\\Buttons\\WHITE8x8")
sfDiv:SetVertexColor(0.50, 0.50, 0.50, 0.40)

-- ── Section: Actions ──────────────────────────────────────────────────────────
SFHeader("Layout", -142)

local ACT_W = math.floor((SF_W - SF_PAD*2 - 4) / 2)

local orientationBtn = SFBtn("", ACT_W, -160, "LEFT", function()
    if GetOrientation() == "vertical" then
        DB("orientation", "horizontal")
    else
        DB("orientation", "vertical")
    end
    if UpdateOrientationBtn then UpdateOrientationBtn() end
    RequestBarRefresh()
end)

UpdateOrientationBtn = function()
    if GetOrientation() == "vertical" then
        orientationBtn.label:SetText("Layout: Vertical")
    else
        orientationBtn.label:SetText("Layout: Horizontal")
    end
end
Tip(orientationBtn, "Bar Orientation", "Switch between horizontal and vertical layouts")

local floatingBtn = SFBtn("", ACT_W, -160, "RIGHT", function()
    DB("floating", not IsFloating())
    if UpdateFloatingBtn then UpdateFloatingBtn() end
    RequestBarRefresh()
end)

UpdateFloatingBtn = function()
    if IsFloating() then
        floatingBtn.label:SetText("Buttons: Floating")
    else
        floatingBtn.label:SetText("Buttons: Framed")
    end
end
Tip(floatingBtn, "Background Style", "Hide the background bar and use floating buttons only")

local markersOnlyBtn = SFBtn("", SF_W - SF_PAD * 2, -186, "LEFT", function()
    DB("markersOnly", not IsMarkersOnly())
    if UpdateMarkersOnlyBtn then UpdateMarkersOnlyBtn() end
    RequestBarRefresh()
end)

UpdateMarkersOnlyBtn = function()
    if IsMarkersOnly() then
        markersOnlyBtn.label:SetText("Buttons: Markers Only")
    else
        markersOnlyBtn.label:SetText("Buttons: Full Bar")
    end
end
Tip(markersOnlyBtn, "Markers Only", "Hide the utility buttons and keep only the raid marker icons")

local tooltipBtn = SFBtn("", ACT_W, -212, "LEFT", function()
    DB("tooltips", not AreTooltipsEnabled())
    if UpdateTooltipBtn then UpdateTooltipBtn() end
    GameTooltip:Hide()
end)

UpdateTooltipBtn = function()
    if AreTooltipsEnabled() then
        tooltipBtn.label:SetText("Tooltips: On")
    else
        tooltipBtn.label:SetText("Tooltips: Off")
    end
end
Tip(tooltipBtn, "Tooltips", "Turn RaidBar tooltips on or off")

local leaveBtnToggle = SFBtn("", ACT_W, -212, "RIGHT", function()
    DB("hideLeave", not IsLeaveHidden())
    if UpdateLeaveBtn then UpdateLeaveBtn() end
    RequestBarRefresh()
end)

UpdateLeaveBtn = function()
    if IsLeaveHidden() then
        leaveBtnToggle.label:SetText("Leave Btn: Hidden")
    else
        leaveBtnToggle.label:SetText("Leave Btn: Shown")
    end
end
Tip(leaveBtnToggle, "Leave Button", "Show or hide the leave group button")

local visibilityBtn = SFBtn("", SF_W - SF_PAD * 2, -238, "LEFT", function()
    DB("hideUnlessRaidLeadAssist", not IsLeaderAssistVisibilityEnabled())
    if UpdateVisibilityBtn then UpdateVisibilityBtn() end
    if RefreshBarVisibility then RefreshBarVisibility() end
end)

UpdateVisibilityBtn = function()
    if IsLeaderAssistVisibilityEnabled() then
        visibilityBtn.label:SetText("Visibility: Raid Lead/Assist Only")
    else
        visibilityBtn.label:SetText("Visibility: Always Available")
    end
end
Tip(visibilityBtn, "Raid Lead/Assist Visibility", "Hide RaidBar unless you are in a raid and are raid leader or assistant")

SFHeader("Size", -274)
local updatingScaleSlider = false

local scaleValueLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
scaleValueLabel:SetPoint("TOP", settingsFrame, "TOP", 0, -292)
scaleValueLabel:SetTextColor(unpack(GOLD))
scaleValueLabel:SetJustifyH("CENTER")

local scaleSlider = CreateFrame("Slider", "RaidBarScaleSlider", settingsFrame, "OptionsSliderTemplate")
scaleSlider:SetWidth(SF_W - SF_PAD * 2 - 12)
scaleSlider:SetHeight(16)
scaleSlider:SetPoint("TOP", settingsFrame, "TOP", 0, -314)
scaleSlider:SetMinMaxValues(MIN_SCALE * 100, MAX_SCALE * 100)
scaleSlider:SetValueStep(SCALE_STEP * 100)
scaleSlider:SetObeyStepOnDrag(true)

RaidBarScaleSliderLow:SetText(string.format("%d%%", math.floor(MIN_SCALE * 100 + 0.5)))
RaidBarScaleSliderHigh:SetText(string.format("%d%%", math.floor(MAX_SCALE * 100 + 0.5)))
RaidBarScaleSliderText:SetText("")

scaleSlider:SetScript("OnValueChanged", function(self, value)
    if updatingScaleSlider then return end
    local snapped = ClampScale(value / 100)
    local pct = math.floor(snapped * 100 + 0.5)
    scaleValueLabel:SetText(string.format("Size: %d%%", pct))
    if math.abs((DB("scale") or DEFAULT_SCALE) - snapped) > 0.0001 then
        SetBarScale(snapped)
    end
end)

Tip(scaleSlider, "Bar Size", "Drag to resize RaidBar")

UpdateScaleControls = function()
    local pct = math.floor(((DB("scale") or DEFAULT_SCALE) * 100) + 0.5)
    updatingScaleSlider = true
    scaleSlider:SetValue(pct)
    updatingScaleSlider = false
    scaleValueLabel:SetText(string.format("Size: %d%%", pct))
end

SFHeader("Icon Size", -342)

local updatingIconSizeSlider = false

local iconSizeValueLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
iconSizeValueLabel:SetPoint("TOP", settingsFrame, "TOP", 0, -360)
iconSizeValueLabel:SetTextColor(unpack(GOLD))
iconSizeValueLabel:SetJustifyH("CENTER")

local iconSizeSlider = CreateFrame("Slider", "RaidBarIconSizeSlider", settingsFrame, "OptionsSliderTemplate")
iconSizeSlider:SetWidth(SF_W - SF_PAD * 2 - 12)
iconSizeSlider:SetHeight(16)
iconSizeSlider:SetPoint("TOP", settingsFrame, "TOP", 0, -382)
iconSizeSlider:SetMinMaxValues(MIN_BS, MAX_BS)
iconSizeSlider:SetValueStep(BS_STEP)
iconSizeSlider:SetObeyStepOnDrag(true)

RaidBarIconSizeSliderLow:SetText(tostring(MIN_BS))
RaidBarIconSizeSliderHigh:SetText(tostring(MAX_BS))
RaidBarIconSizeSliderText:SetText("")

iconSizeSlider:SetScript("OnValueChanged", function(self, value)
    if updatingIconSizeSlider then return end
    local size = ClampButtonSize(value)
    iconSizeValueLabel:SetText(string.format("Icon Size: %d", size))
    if (DB("buttonSize") or DEFAULT_BS) ~= size then
        SetButtonSize(size)
    end
end)

Tip(iconSizeSlider, "Icon Size", "Drag to change the size of the RaidBar buttons/icons without changing the full bar scale")

UpdateIconSizeControls = function()
    local size = GetButtonSize()
    updatingIconSizeSlider = true
    iconSizeSlider:SetValue(size)
    updatingIconSizeSlider = false
    iconSizeValueLabel:SetText(string.format("Icon Size: %d", size))
end

SFHeader("Spacing", -410)

local updatingSpacingSlider = false

local spacingValueLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
spacingValueLabel:SetPoint("TOP", settingsFrame, "TOP", 0, -428)
spacingValueLabel:SetTextColor(unpack(GOLD))
spacingValueLabel:SetJustifyH("CENTER")

local spacingSlider = CreateFrame("Slider", "RaidBarSpacingSlider", settingsFrame, "OptionsSliderTemplate")
spacingSlider:SetWidth(SF_W - SF_PAD * 2 - 12)
spacingSlider:SetHeight(16)
spacingSlider:SetPoint("TOP", settingsFrame, "TOP", 0, -450)
spacingSlider:SetMinMaxValues(MIN_GAP, MAX_GAP)
spacingSlider:SetValueStep(GAP_STEP)
spacingSlider:SetObeyStepOnDrag(true)

RaidBarSpacingSliderLow:SetText(tostring(MIN_GAP))
RaidBarSpacingSliderHigh:SetText(tostring(MAX_GAP))
RaidBarSpacingSliderText:SetText("")

spacingSlider:SetScript("OnValueChanged", function(self, value)
    if updatingSpacingSlider then return end
    local gap = ClampGap(value)
    local pad = math.max(2, gap * 2)
    spacingValueLabel:SetText(string.format("Spacing: %d  Padding: %d", gap, pad))
    if (DB("spacing") or DEFAULT_GAP) ~= gap then
        SetBarSpacing(gap)
    end
end)

Tip(spacingSlider, "Bar Spacing", "Drag to change button spacing and outer padding together")

UpdateSpacingControls = function()
    local gap = GetBarGap()
    local pad = GetBarPad()
    updatingSpacingSlider = true
    spacingSlider:SetValue(gap)
    updatingSpacingSlider = false
    spacingValueLabel:SetText(string.format("Spacing: %d  Padding: %d", gap, pad))
end

SFHeader("Actions", -478)

-- Row 1: Lock Position | Fix Buttons
local lockBtnLabel  -- fontstring reference, set inside the closure
local lockBtn = CreateFrame("Button", nil, settingsFrame, WithBackdropTemplate())
lockBtn:SetSize(ACT_W, 22)
lockBtn:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", SF_PAD, -496)
StyleModernButton(lockBtn)
lockBtnLabel = lockBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
lockBtnLabel:SetAllPoints()
lockBtnLabel:SetJustifyH("CENTER"); lockBtnLabel:SetJustifyV("MIDDLE")
local function UpdateLockBtn()
    if DB("locked") then
        lockBtnLabel:SetText("|cFF00FF00Position: Locked|r")
    else
        lockBtnLabel:SetText("|cFFD8DDE6Position: Unlocked|r")
    end
end
UpdateLockBtn()
Tip(lockBtn, "Position Lock", "Prevent dragging RaidBar until you unlock it")
lockBtn:SetScript("OnClick", function()
    local newLocked = not DB("locked")
    DB("locked", newLocked)
    UpdateLockBtn()
    if newLocked then
        print("|cFFD8DDE6RaidBar:|r Position |cFF00FF00locked|r.")
    else
        print("|cFFD8DDE6RaidBar:|r Position |cFFFFAA00unlocked|r.")
    end
end)

SFBtn("Fix Buttons", ACT_W, -496, "RIGHT", function()
    for i, m in ipairs(MARKERS) do
        local btn = _G["RaidBarMarker"..i]
        if btn then
            ConfigureMarkerButton(btn, m[1], m[2])
        end
    end
    ctBtn:SetAttribute("type", "macro")
    ctBtn:SetAttribute("macrotext", BuildClearTargetMarkerMacro())
    print("|cFFD8DDE6RaidBar:|r Buttons re-wired.")
end)

-- Row 2: Toggle Blizz UI | Reset All
SFBtn("Toggle Blizz UI", ACT_W, -522, "LEFT", ToggleBlizzRaidUI)

SFBtn("|cFFFF6666Reset All|r", ACT_W, -522, "RIGHT", function()
    StaticPopup_Show("RAIDBAR_RESET_CONFIRM")
end)

StaticPopupDialogs["RAIDBAR_RESET_CONFIRM"] = {
    text = "Reset all RaidBar settings to defaults?\nThis will reload your UI.",
    button1 = "Reset", button2 = "Cancel",
    OnAccept = function() RaidBarDB = {}; ReloadUI() end,
    timeout=0, whileDead=true, hideOnEscape=true,
}

-- ── UpdateSwatchSelections (assigned to forward declaration) ───────────────────
-- Highlights the active swatch in each section. Regular swatches use backdrop
-- border colour; custom swatches use a 1px white outline ring.
UpdateSwatchSelections = function()
    local selBorder = DB("borderPreset") or 1
    for i, sw in ipairs(borderSwatches) do
        sw.setSelected(i == selBorder)
    end
    customBorderSwatch.setSelected(selBorder == 0)

    local selBG = DB("bgPreset") or 2
    for i, sw in ipairs(bgSwatches) do
        sw.setSelected(i == selBG)
    end
    customBGSwatch.setSelected(selBG == 0)
end

-------------------------------------------------------------------------------
-- Slash commands
-------------------------------------------------------------------------------
SLASH_RAIDBAR1 = "/raidbar"
SlashCmdList["RAIDBAR"] = function(msg)
    -- Copy this line into support reports to identify the addon and client.
    if type(msg) == "string" and msg:match("^%s*(.-)%s*$"):lower() == "version" then
        local getMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
        local installedVersion = getMetadata and getMetadata("RaidBar", "Version") or "1.1.17"
        local clientVersion, clientBuild = "unknown", "unknown"
        if type(GetBuildInfo) == "function" then clientVersion, clientBuild = GetBuildInfo() end
        print("Raid Markers " .. tostring(installedVersion) .. " | WoW " .. tostring(clientVersion) .. " (build " .. tostring(clientBuild) .. ")")
        return
    end

    msg = trim(msg):lower()

    if msg == "" then
        if settingsFrame:IsShown() then
            settingsFrame:Hide()
        else
            settingsFrame:ClearAllPoints()
            settingsFrame:SetPoint("BOTTOM", f, "TOP", 0, 8)
            settingsFrame:Show()
        end

    elseif msg == "blizzui" then
        ToggleBlizzRaidUI()

    elseif msg == "reset" then
        RaidBarDB = {}; ReloadUI()

    elseif msg == "lock" then
        local newLocked = not DB("locked")
        DB("locked", newLocked)
        UpdateLockBtn()
        if newLocked then
            print("|cFFD8DDE6RaidBar:|r Position |cFF00FF00locked|r.")
        else
            print("|cFFD8DDE6RaidBar:|r Position |cFFFFAA00unlocked|r.")
        end

    elseif msg == "show" then f:Show()
    elseif msg == "hide" then f:Hide()

    else
        print("|cFFD8DDE6RaidBar|r — |cFF888888/raidbar|r opens Settings, or:")
        print("  blizzui | lock | show | hide | reset")
    end
end

-------------------------------------------------------------------------------
-- Events
-------------------------------------------------------------------------------
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
-- "Hide unless raid leader or assistant" reads UnitIsGroupLeader /
-- UnitIsGroupAssistant, and a promotion or demotion is a rank change rather
-- than a roster change, so GROUP_ROSTER_UPDATE alone could leave the bar in the
-- wrong state until something else refreshed it.
f:RegisterEvent("PARTY_LEADER_CHANGED")
f:RegisterEvent("ENCOUNTER_START")
f:RegisterEvent("ENCOUNTER_END")

f:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" then
        ApplyBlizzRaidUI()
        return
    end
    if event == "ENCOUNTER_START" then
        encounterActive = true
        RefreshBarVisibility()
        return
    elseif event == "ENCOUNTER_END" then
        encounterActive = false
        RefreshBarVisibility()
        return
    elseif event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD"
        or event == "PARTY_LEADER_CHANGED" then
        ApplyBlizzRaidUI()
        RefreshBarVisibility()
        return
    end

    if event == "PLAYER_LOGIN" then
        DB("buttonSize", GetButtonSize())
        DB("spacing", GetBarGap())
        ApplyLayout()
        ApplyTheme()

        ApplyBlizzRaidUI()

        -- Scale must be set BEFORE SetPoint so the frame's coordinate space
        -- matches the UIParent coords we saved in SavePos.
        local scale = ClampScale(DB("scale") or DEFAULT_SCALE)
        DB("scale", scale)
        f:SetScale(scale)
        if UpdateScaleControls then UpdateScaleControls() end
        local scrW, scrH = GetScreenWidth(), GetScreenHeight()
        local startW = DB("minimized") and (GetBarPad() * 2 + GetButtonSize()) or currentFullW
        local lx = DB("lx") or math.floor((scrW - (startW * scale)) / 2)
        local y  = DB("y")  or math.floor(scrH * 0.5 + 200)
        f:ClearAllPoints()
        f:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", lx, y)
        RefreshContentVisibility()

        print("|cFFD8DDE6RaidBar|r ready  |cFF888888/raidbar|r to open Settings")

        RefreshBarVisibility()

    elseif event == "PLAYER_REGEN_ENABLED" then
        ApplyBlizzRaidUI()
        if pendingBarRefresh then
            RequestBarRefresh()
        end
        if pendingMini ~= nil then
            ApplyMinimize(pendingMini); pendingMini = nil
        end
        RefreshBarVisibility()
    end
end)

-------------------------------------------------------------------------------
-- Interface Options registration
-------------------------------------------------------------------------------
do
    local reg = CreateFrame("Frame")
    reg:RegisterEvent("ADDON_LOADED")
    reg:SetScript("OnEvent", function(self, event, arg1)
        if arg1 ~= "RaidBar" then return end
        self:UnregisterAllEvents()

        local panel = CreateFrame("Frame")
        panel.name = "RaidBar"

        local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("RaidBar")

        local desc = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
        desc:SetText("Compact moveable raid marker and utility bar.")

        local btn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
        btn:SetSize(160, 26)
        btn:SetPoint("TOPLEFT", 16, -70)
        btn:SetText("Open RaidBar Settings")
        btn:SetScript("OnClick", function() SlashCmdList["RAIDBAR"]("") end)

        local cmds = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        cmds:SetPoint("TOPLEFT", btn, "BOTTOMLEFT", 0, -10)
        cmds:SetText("/raidbar  \124  /raidbar lock  \124  /raidbar blizzui  \124  /raidbar reset")

        -- Encounter auto-show toggle
        local autoShowCb = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
        autoShowCb:SetPoint("TOPLEFT", cmds, "BOTTOMLEFT", -2, -14)
        autoShowCb:SetChecked(DB("encounterAutoShow") == true)
        autoShowCb:SetScript("OnClick", function(self)
            DB("encounterAutoShow", self:GetChecked())
            if RefreshBarVisibility then RefreshBarVisibility() end
        end)
        local autoShowLbl = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        autoShowLbl:SetPoint("LEFT", autoShowCb, "RIGHT", 4, 0)
        autoShowLbl:SetText("Auto-show bar on boss encounter start (hides otherwise)")

        local leadAssistCb = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
        leadAssistCb:SetPoint("TOPLEFT", autoShowCb, "BOTTOMLEFT", 0, -8)
        leadAssistCb:SetChecked(IsLeaderAssistVisibilityEnabled())
        leadAssistCb:SetScript("OnClick", function(self)
            DB("hideUnlessRaidLeadAssist", self:GetChecked())
            if UpdateVisibilityBtn then UpdateVisibilityBtn() end
            if RefreshBarVisibility then RefreshBarVisibility() end
        end)
        local leadAssistLbl = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        leadAssistLbl:SetPoint("LEFT", leadAssistCb, "RIGHT", 4, 0)
        leadAssistLbl:SetText("Hide bar unless in raid as leader or assistant")

        if HAS_SETTINGS_API then
            local cat = Settings.RegisterCanvasLayoutCategory(panel, "RaidBar", "RaidBar")
            Settings.RegisterAddOnCategory(cat)
        elseif InterfaceOptions_AddCategory then
            InterfaceOptions_AddCategory(panel)
        end
    end)
end
