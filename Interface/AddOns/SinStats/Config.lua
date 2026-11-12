local AddName, Ns = ...
local L = Ns.L
local K = Ns.K
local sidePanelWidth
local redColor = { r=1, g=0, b=0.658 }
local orangeColor = { r=1, g=0.741, b=0.313 }
local white = { r=1, g=1, b=1 }

local function IsTexturePath(s)
	return type(s) == "string" and (s:find("\\", 1, true) or s:find("/", 1, true))
end

local atlasExistsCache = {}
local function AtlasExists(atlas)
	if type(atlas) ~= "string" or atlas == "" then return false end
	local cached = atlasExistsCache[atlas]
	if cached ~= nil then return cached end
	local ok = false

	if C_Texture and C_Texture.GetAtlasInfo then
		local info = C_Texture.GetAtlasInfo(atlas)
		ok = info ~= nil
	else
		local probe = UIParent:CreateTexture(nil, "BACKGROUND")
		local success = pcall(probe.SetAtlas, probe, atlas, false)
		ok = success and probe:GetAtlas() == atlas
		probe:SetTexture(nil)
		probe:ClearAllPoints()
		probe:Hide()
	end
	atlasExistsCache[atlas] = ok
	return ok
end

function Ns:ApplyAtlasOrFallback(texture, atlasKey, fallback)
	if not texture then return end
	local value = Ns.ConfigAtlas and Ns.ConfigAtlas[atlasKey]
	local ok = false
	if value and value ~= "" then
		if IsTexturePath(value) then
			if texture.SetTexture then texture:SetTexture(value) end
			ok = true
		elseif texture.SetAtlas and AtlasExists(value) then
			texture:SetAtlas(value, false)
			ok = true
		end
	end
	if not ok and fallback then fallback(texture) end
	return ok
end

function Ns:ApplyIconAtlasOrFallback(texture, value, fallback)
	if not texture then return false end
	if value and value ~= "" then
		if IsTexturePath(value) then
			if texture.SetTexture then texture:SetTexture(value) end
			return true
		elseif texture.SetAtlas and AtlasExists(value) then
			texture:SetAtlas(value, false)
			return true
		end
	end
	if fallback then fallback(texture) end
	return false
end

local CONFIG_BORDER_TEXTURES = {
	top = Ns.TexturePath.."png\\border\\_GenericMetal2-NineSlice-EdgeTop.png",
	bottom = Ns.TexturePath.."png\\border\\_GenericMetal2-NineSlice-EdgeBottom.png",
	left = Ns.TexturePath.."png\\border\\!GenericMetal2-NineSlice-EdgeLeft.png",
	right = Ns.TexturePath.."png\\border\\!GenericMetal2-NineSlice-EdgeRight.png",
	topLeft = Ns.TexturePath.."png\\border\\GenericMetal2-NineSlice-CornerTopLeft.png",
	topRight = Ns.TexturePath.."png\\border\\GenericMetal2-NineSlice-CornerTopRight.png",
	bottomLeft = Ns.TexturePath.."png\\border\\GenericMetal2-NineSlice-CornerBottomLeft.png",
	bottomRight = Ns.TexturePath.."png\\border\\GenericMetal2-NineSlice-CornerBottomRight.png",
}

local function CreateConfigTextureBorder(frame)
	if not frame then return nil end

	local scale = (K.BORDER_SCALE and K.BORDER_SCALE > 0) and K.BORDER_SCALE or 1
	local outsetPx = (K.BORDER_OUTSET or 0) / scale
	local border = CreateFrame("Frame", nil, frame)
	border:SetPoint("TOPLEFT", frame, "TOPLEFT", -outsetPx, outsetPx)
	border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", outsetPx, -outsetPx)
	border:SetFrameLevel(frame:GetFrameLevel() + 10)
	border:SetScale(scale)

	local function CreatePiece(path)
		local tex = border:CreateTexture(nil, "OVERLAY", nil, 0)
		tex:SetTexture(path)
		if Ns.PP and Ns.PP.DisableSnap then
			Ns.PP.DisableSnap(tex)
		end
		return tex
	end

	border.TopLeft = CreatePiece(CONFIG_BORDER_TEXTURES.topLeft)
	border.TopRight = CreatePiece(CONFIG_BORDER_TEXTURES.topRight)
	border.BottomLeft = CreatePiece(CONFIG_BORDER_TEXTURES.bottomLeft)
	border.BottomRight = CreatePiece(CONFIG_BORDER_TEXTURES.bottomRight)
	border.Top = CreatePiece(CONFIG_BORDER_TEXTURES.top)
	border.Bottom = CreatePiece(CONFIG_BORDER_TEXTURES.bottom)
	border.Left = CreatePiece(CONFIG_BORDER_TEXTURES.left)
	border.Right = CreatePiece(CONFIG_BORDER_TEXTURES.right)

	border.TopLeft:SetSize(80, 80)
	border.TopLeft:SetPoint("TOPLEFT", border, "TOPLEFT", -6, 6)
	border.TopRight:SetSize(80, 80)
	border.TopRight:SetPoint("TOPRIGHT", border, "TOPRIGHT", 6, 6)
	border.BottomLeft:SetSize(80, 80)
	border.BottomLeft:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT", -6, -6)
	border.BottomRight:SetSize(80, 80)
	border.BottomRight:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT", 6, -6)

	border.Top:SetPoint("TOPLEFT", border.TopLeft, "TOPRIGHT", 0, 0)
	border.Top:SetPoint("TOPRIGHT", border.TopRight, "TOPLEFT", 0, 0)
	border.Top:SetHeight(80)

	border.Bottom:SetPoint("BOTTOMLEFT", border.BottomLeft, "BOTTOMRIGHT", 0, 0)
	border.Bottom:SetPoint("BOTTOMRIGHT", border.BottomRight, "BOTTOMLEFT", 0, 0)
	border.Bottom:SetHeight(80)

	border.Left:SetPoint("TOPLEFT", border.TopLeft, "BOTTOMLEFT", 0, 0)
	border.Left:SetPoint("BOTTOMLEFT", border.BottomLeft, "TOPLEFT", 0, 0)
	border.Left:SetWidth(80)

	border.Right:SetPoint("TOPRIGHT", border.TopRight, "BOTTOMRIGHT", 0, 0)
	border.Right:SetPoint("BOTTOMRIGHT", border.BottomRight, "TOPRIGHT", 0, 0)
	border.Right:SetWidth(80)

	return border
end

local function _NearestPixel(size, scale)
	if PixelUtil then return PixelUtil.GetNearestPixelSize(size, scale, 1) end
	return math.max(1, math.floor(size * scale + 0.5) / scale)
end

function Ns:SnapToPixels(region)
	if not region then return end
	local scale = region:GetEffectiveScale()
	if not scale or scale <= 0 then return end
	local w, h = region:GetWidth(), region:GetHeight()
	if w and h and w > 0 and h > 0 then
		local pw, ph = _NearestPixel(w, scale), _NearestPixel(h, scale)
		if pw ~= w or ph ~= h then region:SetSize(pw, ph) end
	end
end

do
	local phH = select(2, GetPhysicalScreenSize())
	local unitPixel = 768 / phH

	Ns.PP = {}
	local PP = Ns.PP

	function PP.DisableSnap(obj)
		if not obj then return end
		if obj.IsForbidden and obj:IsForbidden() then return end
		if obj.SetSnapToPixelGrid then
			obj:SetSnapToPixelGrid(false)
			obj:SetTexelSnappingBias(0)
		end
	end

	local registry = {}

	local function SnapEntry(entry)
		local ok, es = pcall(entry.holder.GetEffectiveScale, entry.holder)
		if not ok or not es or es <= 0 then return end
		local px    = unitPixel / es
		local thick = math.max(px, math.floor(entry.size + 0.5) * px)
		local t, b, l, r = entry.strips[1], entry.strips[2], entry.strips[3], entry.strips[4]
		local fr = entry.frame
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT",  fr, "TOPLEFT",  0, 0)
		t:SetPoint("TOPRIGHT", fr, "TOPRIGHT", 0, 0)
		t:SetHeight(thick)
		b:ClearAllPoints()
		b:SetPoint("BOTTOMLEFT",  fr, "BOTTOMLEFT",  0, 0)
		b:SetPoint("BOTTOMRIGHT", fr, "BOTTOMRIGHT", 0, 0)
		b:SetHeight(thick)
		l:ClearAllPoints()
		l:SetPoint("TOPLEFT",    fr, "TOPLEFT",    0, -thick)
		l:SetPoint("BOTTOMLEFT", fr, "BOTTOMLEFT", 0,  thick)
		l:SetWidth(thick)
		r:ClearAllPoints()
		r:SetPoint("TOPRIGHT",    fr, "TOPRIGHT",    0, -thick)
		r:SetPoint("BOTTOMRIGHT", fr, "BOTTOMRIGHT", 0,  thick)
		r:SetWidth(thick)
	end

	function PP.CreateBorder(frame, r, g, b, a, size)
		r = r or 0; g = g or 0; b = b or 0; a = a or 1; size = size or 1
		local WHITE = "Interface\\Buttons\\WHITE8X8"
		local holder = CreateFrame("Frame", nil, frame)
		holder:SetAllPoints(frame)
		holder:SetFrameLevel(frame:GetFrameLevel() + 1)
		local strips = {}
		for i = 1, 4 do
			local tx = holder:CreateTexture(nil, "BORDER", nil, 0)
			tx:SetTexture(WHITE)
			tx:SetVertexColor(r, g, b, a)
			PP.DisableSnap(tx)
			strips[i] = tx
		end
		local entry = {
			holder = holder, frame = frame, strips = strips,
			r = r, g = g, b = b, a = a, size = size,
		}
		tinsert(registry, entry)
		frame._PPBorder = entry
		frame.Borders   = strips  -- expose for ColorBorders / legacy callers
		SnapEntry(entry)
		local ticks = 0
		holder:SetScript("OnUpdate", function(self)
			ticks = ticks + 1
			SnapEntry(entry)
			if ticks >= 2 then self:SetScript("OnUpdate", nil) end
		end)
		return entry
	end

	function PP.SetBorderColor(frame, r, g, b, a)
		local entry = frame and frame._PPBorder
		if not entry then return end
		a = a or 1
		entry.r = r; entry.g = g; entry.b = b; entry.a = a
		for i = 1, 4 do
			entry.strips[i]:SetVertexColor(r, g, b, a)
			PP.DisableSnap(entry.strips[i])
		end
	end

	function PP.ResnapBorder(frame)
		local entry = frame and frame._PPBorder
		if entry then pcall(SnapEntry, entry) end
	end

	function PP.ResnapAllBorders()
		for i = 1, #registry do
			pcall(SnapEntry, registry[i])
		end
	end

	function PP.SnapFrameToPixels(frame)
		local l = frame:GetLeft()
		local b = frame:GetBottom()
		if not l or not b then return end

		local pxSize = unitPixel / UIParent:GetEffectiveScale()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",
			math.floor(l / pxSize + 0.5) * pxSize,
			math.floor(b / pxSize + 0.5) * pxSize)
	end

	local scaleWatcher = CreateFrame("Frame")
	scaleWatcher:RegisterEvent("UI_SCALE_CHANGED")
	scaleWatcher:RegisterEvent("DISPLAY_SIZE_CHANGED")
	scaleWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
	scaleWatcher:SetScript("OnEvent", function(_, event)
		if event == "DISPLAY_SIZE_CHANGED" then
			phH = select(2, GetPhysicalScreenSize())
			unitPixel = 768 / phH
		end
		PP.ResnapAllBorders()
	end)
end

local addVer = C_AddOns.GetAddOnMetadata(AddName, "Version")

local groupTitles = {
	[2] = { text="GroupSetup", icon="Settings" },
	[3] = { text="GroupCaps", icon="Settings" },
	[4] = { text="GroupTextColor", icon="ValueColor" },
	[5] = { text="GroupStatusBars", icon="HUDBorder" },
}

if GetLocale() == 'zhCN' or GetLocale() == 'zhTW' or GetLocale() == 'koKR' then
    Ns.ConfigDefaultFont = Ns.LSM:Fetch("font", Ns.LSM:GetDefault("font"))
end
Ns.ConfigDefaultFontSize = 16
Ns.TooltipYOffset = 3
-----------------------------------------------
--			SV Items and Groupings			---
-----------------------------------------------
Ns.SettingsGroupOrder = {
	[1] = { stat="HUD", svnotintable=true, icon="Settings", widget={ type="TopTab" }, activeonload=true, },
	--[2] = { stat="MinimapT", svnotintable=true, icon="MinimapIcon", widget={ type="TopTab" }, },
}

Ns.TextGroupOrder = {
	[1] = { stat="Text", svnotintable=true, icon="Fonts", widget={ type="TopTab" }, activeonload=true, },
}

Ns.LayoutGroupOrder = {
	[1] = { stat="DisplayOrder", description=true, svnotintable=true, icon="Layout", widget={ type="TopTab" }, enabledval=3, activeonload=true, },
}

Ns.LayoutDisplayOrder = { ignoretoptabs=true, 
	{ stat="StatOrderSettings", icon="", svnotintable=true, spellclass="DisplayOrder", widget={ type="DisplayOrderConfig", data="Profiles", width=200}, },
}

Ns.EventsGroupOrder = {
	[1] = { stat="Events", svnotintable=true, icon="Events", widget={ type="TopTab" }, activeonload=true, },
	[2] = { stat="EventSettings", svnotintable=true, icon="Settings", widget={ type="TopTab" }, },
}

Ns.EventsDisplayOrder = { --ignoretoptabs=true,
	--events
	{ stat="EventEnable", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, tooltip=true, linked={ "EventWorld", false, "EventDelves", false, "EventDungeon", false, "EventRaid", false, "EventPvP", false, "EventArena", false, "EventCombat", false, "EventResting", false, "EventMounted", false, "EventMouseOver", false, "EventTarget", false, "EventTargetHostile", false }, onclick="ToggleMouseOver", }, --subgroup={ text="Events", icon="cm" }, },
	{ stat="EventWorld", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, subgroup={ text="ShowStats", icon="cm" }, newline=true, },
	{ stat="EventDelves", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, },
	{ stat="EventDungeon", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, newline=true, },
	{ stat="EventRaid", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, },
	{ stat="EventPvP", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, subgroup={ text="HideStats", icon="cm" }, newline=true, },
	{ stat="EventArena", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, },
	{ stat="EventCombat", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, newline=true, },
	{ stat="EventMouseOver", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, onclick="ToggleMouseOver", },
	{ stat="EventTarget", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, linked={ "EventTargetHostile", false }, newline=true, },
	{ stat="EventTargetHostile", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, },
	{ stat="EventResting", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, newline=true, },
	{ stat="EventMounted", spellclass="Events", icon="", default=false, widget={ type="CheckBox", }, },
	--setings
	{ stat="EventTimer", spellclass="EventSettings", icon="", default=false, widget={ type="CheckBox", }, linked={ "EventTime", false }, },
	{ stat="EventTime", spellclass="EventSettings", icon="", default=0.5, widget={ type="Slider", min=0.5, max=5, valuestep=0.5, width=170, }, },
	{ stat="EventOpacity", spellclass="EventSettings", icon="", default=false, widget={ type="CheckBox", }, tooltip=true, linked={ "EventOpacityValue", false }, newline=true, },
	{ stat="EventOpacityValue", spellclass="EventSettings", icon="", default=0.3, widget={ type="Slider", min=0, max=1, valuestep=0.05, width=170, }, },
}

Ns.ProfileGroupOrder = {
	[1] = { stat="Profiles", svnotintable=true, icon="Profiles", widget={ type="TopTab" }, activeonload=true, },
}

Ns.ProfileDisplayOrder = { ignoretoptabs=true, 
	{ stat="Profiles", icon="", svnotintable=true, spellclass="Profiles", widget={ type="ProfileConfig", data="Profiles", width=200, }, },
}

Ns.PanelGroupOrder = {
	[1] = { stat="PanelManagement", svnotintable=true, icon="HUDStudio", widget={ type="TopTab" }, activeonload=true, },
}

Ns.PanelDisplayOrder = { ignoretoptabs=true,
	{ stat="PanelManagement", icon="", svnotintable=true, spellclass="PanelManagement", widget={ type="PanelConfig", data="Panels", width=200, }, },
}

Ns.SearchGroupOrder = {
	[1] = { stat="Search", description=false, svnotintable=true, icon="Search", widget={ type="TopTab" }, enabledval=3, activeonload=true, },
}

Ns.SearchDisplayOrder = { ignoretoptabs=true,
	{ stat="Search", icon="", svnotintable=true, spellclass="Search", widget={ type="SearchConfig", data="Search", width=200, }, },
}

Ns.TextDisplayOrder = { ignoretoptabs=true,
	{ stat="StatFont", icon="", spellclass="Text", default="Arial Narrow",  widget={ type="DropList", data="Fonts", width=185, }, subgroup={ text="FontsMenu", icon="Fonts" }, newline=true, },
	{ stat="StatFontSize", icon="", spellclass="Text", default=16, widget={ type="Slider", min=8, max=45, valuestep=1, width=185, }, newline=true, },
	{ stat="FontShadow", icon="", spellclass="Text", default=false, widget={ type="CheckBox", }, linked={ "ShadowX", false, "ShadowY", false }, subgroup={ text="OutlineMenu", icon="Outline" }, newline=true, },
	{ stat="ShadowX", icon="", spellclass="Text", default=1, widget={ type="Slider", min=-5, max=5, valuestep=1, width=185, }, newline=true, },
	{ stat="ShadowY", icon="", spellclass="Text", default=-1, widget={ type="Slider", min=-5, max=5, valuestep=1, width=185, }, newline=true, },
	{ stat="StatFontFlags", icon="", spellclass="Text", default="", widget={ type="DropList", data="FontFlags", width=150, }, newline=true, },
	{ stat="StatWidth", icon="", spellclass="Text", default=150, widget={ type="Slider", min=70, max=500, valuestep=0.01, width=185, }, tooltip=true, subgroup={ text="SpacingMenu", icon="Width" }, newline=true, },
	{ stat="StatSpacingH", icon="", spellclass="Text", default=1, widget={ type="Slider", min=1, max=100, width=185, }, newline=true, },
	{ stat="StatSpacingV", icon="", spellclass="Text", default=0, widget={ type="Slider", min=0, max=100, valuestep=0.01, width=185, }, newline=true, },
	{ stat="AlignValues", icon="", spellclass="Text", default=false, widget={ type="CheckBox", }, tooltip=true, linked={ "AlignGap", false }, subgroup={ text="AlignMenu", icon="Align" }, newline=true, },
	{ stat="AlignGap", icon="", spellclass="Text", default=5, widget={ type="Slider", min=0, max=200, valuestep=1, width=185, }, newline=true, },
	{ stat="StatAlignment", icon="", spellclass="Text", default="TOPLEFT", widget={ type="DropList", data="Alignments", width=110, }, newline=true, },
	{ stat="IconAlignment", icon="", spellclass="Text", default="TOPLEFT", widget={ type="DropList", data="IconAlignments", width=110, }, newline=true, },
	{ stat="GrowDirection", icon="", spellclass="Text", default="DOWN", widget={ type="DropList", data="GrowDirections", width=140, }, newline=true, },
	{ stat="TextSeparator", icon="", spellclass="Text", default=":", widget={ type="DropList", data="TextDataSeparator", width=90, }, subgroup={ text="DisplayMenu", icon="Display", }, newline=true,},
	{ stat="StatIcons", icon="", spellclass="Text", default=true, widget={ type="CheckBox", }, newline=true, },
	{ stat="HideText", icon="", spellclass="Text", default=false, widget={ type="CheckBox", }, newline=true, },
	{ stat="StatTextCaps", spellclass="Text", icon="", default=false, widget={ type="CheckBox", }, newline=true, },
	{ stat="StatTextColor", icon="", spellclass="Text", default={ r=1, g=1, b=1, }, widget={ type="ColorPicker", }, subgroup={ text="GlobalColorMenu", icon="ValueColor" }, newline=true, },
	{ stat="ClassColors", spellclass="Text", icon="", default=false, widget={ type="CheckBox", }, linked={ "StatTextColor", true }, },
	{ stat="SplitColors", spellclass="Text", icon="", default=false, widget={ type="CheckBox", }, linked={ "DataColor", false }, tooltip=true, newline=true, },
	{ stat="DataColor", icon="", spellclass="Text", default={ r=1, g=1, b=1, }, widget={ type="ColorPicker", }, },
}

Ns.SettingsDisplayOrder = { ignoretoptabs=true,
	{ stat="HideHUD", icon="", spellclass="HUD", default=false, widget={ type="CheckBox", }, subgroup={ text="HUDsMenu", icon="HUD" }, newline=true, },
	{ stat="LockHUD", icon="", spellclass="HUD", default=false, widget={ type="CheckBox", }, },
	{ stat="HideHeader", icon="", spellclass="HUD", default=false, widget={ type="CheckBox", }, onclick="OnClickHideHeader", newline=true, },
	{ stat="ConfigShortcut", icon="", spellclass="HUD", default=true, widget={ type="CheckBox", }, onclick="OnClickConfigShortcut", },
	{ stat="HeaderOpacity", icon="", spellclass="HUD", default=1, widget={ type="Slider", min=0, max=1, valuestep=0.01, width=165, }, newline=true, },
	{ stat="HUDStrata", icon="", spellclass="HUD", default="MEDIUM", widget={ type="DropList", data="Strata", width=120, }, newline=true, },
	{ stat="ResetPosition", icon="", spellclass="HUD", default=false, widget={ type="PlainButton", }, },
	{ stat="HUDBgTexture", icon="", spellclass="HUD", default="Solid", widget={ type="DropList", data="BarTextures", width=170, }, subgroup={ text="BackgroundMenu", icon="Background" }, newline=true,},
	{ stat="HUDBgColor", icon="", spellclass="HUD", default={ r=0.1, g=0.1, b=0.1, }, widget={ type="ColorPicker", }, newline=true, },
	{ stat="HUDBgAlpha", icon="", spellclass="HUD", default=0, widget={ type="Slider", min=0, max=1, valuestep=0.01, width=185, }, newline=true,},
	{ stat="HUDBorder", icon="", spellclass="HUD", default=false, widget={ type="CheckBox", }, subgroup={ text="BorderMenu", icon="HUDBorder" }, linked={ "HUDBorderTexture", false, "HUDBorderColor", false, "HUDBorderColor", false, "HUDBorderSize", false, "HUDBorderInset", false }, newline=true, },
	{ stat="HUDBorderTexture", icon="", spellclass="HUD", default="None", widget={ type="DropList", data="BorderTextures", width=170, }, newline=true, },
	{ stat="HUDBorderColor", icon="", spellclass="HUD", default={ r=0.1, g=0.1, b=0.1, }, widget={ type="ColorPicker", }, newline=true, },
	{ stat="HUDBorderSize", icon="", spellclass="HUD", default=1, widget={ type="Slider", min=1, max=6, valuestep=1, width=185, }, newline=true, },
	{ stat="HUDBorderInset", icon="", spellclass="HUD", default=0, widget={ type="Slider", min=-20, max=20, valuestep=1, width=185, }, newline=true, },
	{ stat="PanelDisplay", icon="", spellclass="HUD", default=false, widget={ type="CheckBox", }, linked={ "PanelAttach", false }, subgroup={ text="PanelMenu", icon="Attach" }, newline=true, },
	{ stat="PanelAttach", icon="", spellclass="HUD", default=false, widget={ type="CheckBox", }, tooltip=true, linked={ "PanelAttachX", false, "PanelAttachY", false }, },
	-- Anchor offsets: retail/Forever clear the paper doll's top-right sidebar tabs by default
	{ stat="PanelAttachX", icon="", spellclass="HUD", default=4, widget={ type="Slider", min=-600, max=600, valuestep=1, width=185, }, tooltip=false, newline=true, },
	{ stat="PanelAttachY", icon="", spellclass="HUD", default=0, widget={ type="Slider", min=-600, max=600, valuestep=1, width=185, }, tooltip=false, newline=true, },
	{ stat="Minimap", icon="", spellclass="HUD", default={ Show=true, }, widget={ type="MinimapButton", }, subgroup={ text="MinimapGroupText", icon="MinimapMenu", }, newline=true, },
	--{ stat="Minimap", icon="", spellclass="HUD", default={ Show=true, }, widget={ type="MinimapButton", }, subgroup={ text="MinimapGroupText", icon="MinimapIcon", }, newline=true, },
	{ stat="CompButton", spellclass="HUD", icon="", default=true, widget={ type="CheckBox", }, newline=true, },
}

Ns.ProfileRootOrders = { Ns.SettingsDisplayOrder, Ns.TextDisplayOrder }

--------------------------------------
--		Multi-Panel Data Layer		--
--------------------------------------

local PROFILE_ROOT_KEYS = {
	Panels = true,
	PanelOrder = true,
	ActivePanel = true,
}

function Ns:MigrateToPanel(profile)
	if profile.Panels then
		for key in pairs(profile) do
			if not PROFILE_ROOT_KEYS[key] then
				profile[key] = nil
			end
		end
		return
	end

	local panelData = {}
	for key, value in pairs(profile) do
		if not PROFILE_ROOT_KEYS[key] then
			panelData[key] = value
			profile[key] = nil
		end
	end
	profile.Panels = { Main = panelData }
	profile.PanelOrder = { "Main" }
	profile.ActivePanel = "Main"
end

function Ns:CreateNewPanel(profileRoot, panelName, copyFromPanel)
	if profileRoot.Panels[panelName] then return false end
	if copyFromPanel and profileRoot.Panels[copyFromPanel] then
		profileRoot.Panels[panelName] = {}
		Ns.CopyTable(profileRoot.Panels[copyFromPanel], profileRoot.Panels[panelName])
		profileRoot.Panels[panelName].HUDPos = { point = "CENTER", x = 20, y = -20, scale = 1 }
	else
		local panelData = {}
		for _, displayOrder in ipairs(Ns.ProfileRootOrders) do
			for _, options in pairs(displayOrder) do
				if type(options) == "table" and options.stat and not options.svnotintable then
					panelData[options.stat] = type(options.default) == "table"
						and Ns.CopyTable(options.default, {}) or options.default
				end
			end
		end
		panelData.Stats = {}
		Ns:CheckForStats(panelData, Ns.Class or "WARRIOR")

		for _, v in pairs(panelData.Stats) do v.Show = false end
		panelData.HUDPos = { point = "CENTER", x = 0, y = 0, scale = 1 }
		panelData.Minimap = { Show = true }
		panelData.CompButton = true
		profileRoot.Panels[panelName] = panelData
	end
	tinsert(profileRoot.PanelOrder, panelName)
	return true
end

function Ns:DeletePanel(profileRoot, panelName)
	if not profileRoot.Panels[panelName] then return false end

	local count = 0
	for _ in pairs(profileRoot.Panels) do count = count + 1 end
	if count <= 1 then return false end
	profileRoot.Panels[panelName] = nil
	for i = #profileRoot.PanelOrder, 1, -1 do
		if profileRoot.PanelOrder[i] == panelName then
			tremove(profileRoot.PanelOrder, i)
			break
		end
	end

	if profileRoot.ActivePanel == panelName then
		profileRoot.ActivePanel = profileRoot.PanelOrder[1]
	end
	return true
end

--- Rename a panel.
function Ns:RenamePanel(profileRoot, oldName, newName)
	if not profileRoot.Panels[oldName] then return false end
	if profileRoot.Panels[newName] then return false end
	if oldName == newName then return false end
	profileRoot.Panels[newName] = profileRoot.Panels[oldName]
	profileRoot.Panels[oldName] = nil
	for i, name in ipairs(profileRoot.PanelOrder) do
		if name == oldName then
			profileRoot.PanelOrder[i] = newName
			break
		end
	end
	if profileRoot.ActivePanel == oldName then
		profileRoot.ActivePanel = newName
	end
	return true
end

Ns.FAQGroupOrder = {
	[1] = { stat="FAQ", description=false, svnotintable=true, icon="Misc", widget={ type="TopTab" }, enabledval=3, activeonload=true, },
}

Ns.FAQDisplayOrder = { ignoretoptabs=true,
	{ stat="FAQ", icon="", svnotintable=true, spellclass="FAQ", widget={ type="FAQConfig", data="Profiles", width=200, }, },
}

--------------------------------------
--			Droplist tables			--
--------------------------------------
function Ns.CopyTable(src, dest)
	for index, value in pairs(src) do
		if type(value) == "table" then
			dest[index] = {}
			Ns.CopyTable(value, dest[index])
		else
			dest[index] = value
		end
	end
end

function Ns:CheckForStats(currentprofile, class)
	if not currentprofile.Stats then
		currentprofile.Stats = {}
	end
	local statSettings = Ns:GetClassDefaults(class)
	for k, v in pairs(Ns.DefaultOrder) do
		if not currentprofile.Stats[v.stat] then
			currentprofile.Stats[v.stat] = {}
			currentprofile.Stats[v.stat].Show = statSettings[v.stat] or false
			if v.options then
				for o,_ in pairs(v.options) do
					for _, so in pairs(Ns.Options) do
						if so.stat == o and so.default ~= nil then
							currentprofile.Stats[v.stat][so.stat] = so.default
							break
						end
					end
				end
			end
		end
	end
end

function Ns:CreateProfile(newprofile, currentprofile, class) -- copies settings from the current to the new one
	if not currentprofile then
		if not class then
			print("Sinstats: No profile to copy from")
			return
		end
		-- Build a panel-aware profile from scratch
		currentprofile = {}
		local panelData = {}
		for _, displayOrder in ipairs(Ns.ProfileRootOrders) do
			for _, options in pairs(displayOrder) do
				if type(options) == "table" and options.stat and not options.svnotintable then
					panelData[options.stat] = options.default
				end
			end
		end
		panelData.Stats = {}
		Ns:CheckForStats(panelData, class)
		currentprofile.Panels = { Main = panelData }
		currentprofile.PanelOrder = { "Main" }
		currentprofile.ActivePanel = "Main"
	else
		-- If copying from a pre-panel profile, migrate the source first
		if not currentprofile.Panels then
			Ns:MigrateToPanel(currentprofile)
		end
	end
	SinStatsDB.profiles[newprofile] = {}
	Ns.CopyTable(currentprofile, SinStatsDB.profiles[newprofile])
end

------------------------------------------
--		Global Settings Bar (per-stat)	--
------------------------------------------

local GLOBAL_BAR_HEIGHT       = 30
local GLOBAL_BAR_TOP_GAP      = 16  -- gap below the stat-group label
local GLOBAL_BAR_BOTTOM_GAP   = 2   -- gap above the top tabs row
local GLOBAL_BAR_BTN_GAP      = 18  -- horizontal gap between actions

local function ForEachStatInSpellClass(spellclass, fn)
	if not spellclass or not Ns.DefaultOrder or not Ns.Profile or not Ns.Profile.Stats then
		return
	end
	for _, entry in ipairs(Ns.DefaultOrder) do
		if type(entry) == "table" and entry.spellclass == spellclass and entry.stat then
			local data = Ns.Profile.Stats[entry.stat]
			if type(data) == "table" then
				fn(entry, data)
			end
		end
	end
end

local function ReExpandActiveMenu()
	local active = Ns.ConfigFrame and Ns.ConfigFrame.MainMenuSelected
	if active and active.Refresh then
		active:Refresh()
	end
end

local function GlobalBar_EnableAllStats(spellclass)
	ForEachStatInSpellClass(spellclass, function(entry, data)
		data.Show = true
	end)
	Ns:QueueProfileRefresh()
	Ns:InitialiseAllPanels()
	ReExpandActiveMenu()
end

local function GlobalBar_DisableAllStats(spellclass)
	ForEachStatInSpellClass(spellclass, function(entry, data)
		data.Show = false
	end)
	Ns:QueueProfileRefresh()
	Ns:InitialiseAllPanels()
	ReExpandActiveMenu()
end

local function SetAllBarsEnabled(spellclass, enabled)
	ForEachStatInSpellClass(spellclass, function(entry, data)
		if data.ShowBar  ~= nil then data.ShowBar  = enabled end
		if data.StaticBar ~= nil then data.StaticBar = enabled end
	end)
	Ns:QueueProfileRefresh()
	Ns:InitialiseAllPanels()
end

local function EnableBarsOfType(spellclass, key)
	ForEachStatInSpellClass(spellclass, function(entry, data)
		if data[key] ~= nil then data[key] = true end
	end)
	Ns:QueueProfileRefresh()
	Ns:InitialiseAllPanels()
end

local function ResetAllTextColors(spellclass)
	ForEachStatInSpellClass(spellclass, function(entry, data)
		if data.ColorCustom ~= nil then data.ColorCustom = false end
		if type(data.ColorName) == "table" then
			data.ColorName.r, data.ColorName.g, data.ColorName.b = 1, 1, 1
		end
	end)
	Ns:QueueProfileRefresh()
end

local sinConfirmFrame
local function MakeConfirmButton(parent, label)
	local b = CreateFrame("Button", nil, parent)
	b:SetSize(90, 25)
	local bg = b:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetTexture(K.SINCONFIRM_BTN_TEX)
	bg:SetVertexColor(1, 1, 1, 1)
	b.BgTexture = bg
	if K.SINCONFIRM_HIGHLIGHT_TEX ~= "" then
		local hl = b:CreateTexture(nil, "HIGHLIGHT")
		hl:SetAllPoints()
		hl:SetTexture(K.SINCONFIRM_HIGHLIGHT_TEX)
		hl:SetDesaturated(K.SINCONFIRM_HIGHLIGHT_DESATURATED)
		hl:SetVertexColor(K.SINCONFIRM_HIGHLIGHT_R, K.SINCONFIRM_HIGHLIGHT_G, K.SINCONFIRM_HIGHLIGHT_B, K.SINCONFIRM_HIGHLIGHT_A)
		b:SetHighlightTexture(hl)
	end
	b.Label = b:CreateFontString(nil, "OVERLAY")
	b.Label:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 2)
	b.Label:SetPoint("CENTER")
	b.Label:SetText(label)
	b.RestTexturePath = K.SINCONFIRM_BTN_TEX
	b.PressedTexturePath = K.SINCONFIRM_BTN_PRESSED_TEX
	b:SetScript("OnMouseDown", function(self)
		if not self:IsEnabled() then return end
		self.BgTexture:SetTexture(self.PressedTexturePath or K.SINCONFIRM_BTN_PRESSED_TEX)
		if self.ApplyIconTextTextOffset then
			self:ApplyIconTextTextOffset(self.IconTextPressedY or self.IconTextBaseY or 0)
		end
	end)
	b:SetScript("OnMouseUp", function(self)
		if not self:IsEnabled() then return end
		self.BgTexture:SetTexture(self.RestTexturePath or K.SINCONFIRM_BTN_TEX)
		if self.ApplyIconTextTextOffset then
			self:ApplyIconTextTextOffset(self.IconTextBaseY or 0)
		end
	end)
	return b
end
local function GetSinConfirmFrame()
	if sinConfirmFrame then return sinConfirmFrame end
	local f = CreateFrame("Frame", "SinStatsConfirmDialog", UIParent)
	f:SetSize(380, 130)
	f:SetPoint("CENTER")
	f:SetFrameStrata("DIALOG")
	f:EnableMouse(true)
	f:SetMovable(true)
	f:Hide()

	local bg = f:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetTexture(K.SINCONFIRM_BG_TEX)
	bg:SetVertexColor(0.12, 0.12, 0.12, 1)

	--Ns.CreateBorder(f, 1)
	--Ns.ColorBorders(f, 0, 0, 0)

	f.Text = f:CreateFontString(nil, "OVERLAY")
	f.Text:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 1)
	f.Text:SetPoint("TOP", 0, -25)
	f.Text:SetWidth(340)
	f.Text:SetJustifyH("CENTER")
	f.Text:SetTextColor(1, 1, 1)

	f.Yes = MakeConfirmButton(f, YES)
	f.No  = MakeConfirmButton(f, NO)
	f.Yes:SetPoint("BOTTOM", f, "BOTTOM", -20, 18)
	f.No:SetPoint("BOTTOM", f, "BOTTOM",  60, 18)

	if Ns.buttonStyle then
		Ns.buttonStyle(f.Yes, {
			normalTex = K.CONFIRM_YES_BTN_TEX,
			pressedTex = K.CONFIRM_YES_BTN_PRESSED_TEX,
			highlightTex = K.CONFIRM_YES_BTN_HIGHLIGHT_TEX,
			highlightW = K.CONFIRM_YES_BTN_HIGHLIGHT_W,
			pressedTextYOffset = -1,
			w = K.CONFIRM_YES_BTN_W,
			h = K.CONFIRM_YES_BTN_H,
			x = K.CONFIRM_YES_BTN_X,
			y = K.CONFIRM_YES_BTN_Y,
		})
		Ns.buttonStyle(f.No, {
			normalTex = K.CONFIRM_NO_BTN_TEX,
			pressedTex = K.CONFIRM_NO_BTN_PRESSED_TEX,
			highlightTex = K.CONFIRM_NO_BTN_HIGHLIGHT_TEX,
			highlightW = K.CONFIRM_NO_BTN_HIGHLIGHT_W,
			pressedTextYOffset = -1,
			w = K.CONFIRM_NO_BTN_W,
			h = K.CONFIRM_NO_BTN_H,
			x = K.CONFIRM_NO_BTN_X,
			y = K.CONFIRM_NO_BTN_Y,
		})
	end

	f.Yes:SetScript("OnClick", function()
		local cb = f._onAccept
		f._onAccept, f._onCancel = nil, nil
		f:Hide()
		if cb then cb() end
	end)
	f.No:SetScript("OnClick", function()
		local cb = f._onCancel
		f._onAccept, f._onCancel = nil, nil
		f:Hide()
		if cb then cb() end
	end)
	f:SetScript("OnKeyDown", function(self, key)
		if key == "ESCAPE" then self.No:Click() end
	end)
	f:SetPropagateKeyboardInput(true)
	sinConfirmFrame = f
	return f
end

function Ns:Confirm(message, onAccept, onCancel)
	local f = GetSinConfirmFrame()
	f:ClearAllPoints()
	if Ns.ConfigFrame and Ns.ConfigFrame.IsShown and Ns.ConfigFrame:IsShown() then
		f:SetPoint("CENTER", Ns.ConfigFrame, "CENTER", 0, 0)
	else
		f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
	f.Text:SetText(message or "")
	f._onAccept = onAccept
	f._onCancel = onCancel
	f:Show()
	f:Raise()
end
local function ConfirmThen(message, onAccept)
	Ns:Confirm(message, onAccept)
end

local function MakeBarButton(parent, key, text)
	local b = parent[key]
	if not b then
		b = CreateFrame("Button", nil, parent)
		b:SetHeight(GLOBAL_BAR_HEIGHT)
		b.Label = b:CreateFontString(nil, "OVERLAY")
		b.Label:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4)
		b.Label:SetPoint("LEFT", 0, 0)
		b.Label:SetPoint("RIGHT", 0, 0)
		b.Label:SetJustifyH("CENTER")
		b.Label:SetTextColor(K.GLOBAL_BAR_LABEL_R, K.GLOBAL_BAR_LABEL_G, K.GLOBAL_BAR_LABEL_B, K.GLOBAL_BAR_LABEL_A)
		b:SetScript("OnEnter", function(self)
			self.Label:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b, 1)
		end)
		b:SetScript("OnLeave", function(self)
			self.Label:SetTextColor(K.GLOBAL_BAR_LABEL_R, K.GLOBAL_BAR_LABEL_G, K.GLOBAL_BAR_LABEL_B, K.GLOBAL_BAR_LABEL_A)
		end)
		parent[key] = b
	end
	b.Label:SetText(text)
	b.Label:SetTextColor(K.GLOBAL_BAR_LABEL_R, K.GLOBAL_BAR_LABEL_G, K.GLOBAL_BAR_LABEL_B, K.GLOBAL_BAR_LABEL_A)
	b:SetWidth(b.Label:GetStringWidth() + 18)
	b:Show()
	return b
end

local atlasTexture = "collections-slotheader"
local function BuildGlobalSettingsBar(anchorframe, spellclass)
	local bar = anchorframe.GlobalBar
	if not bar then
		bar = CreateFrame("Frame", nil, anchorframe)
		bar:SetHeight(GLOBAL_BAR_HEIGHT)
		bar:SetFrameLevel(anchorframe:GetFrameLevel() + 2)
		-- Atlas background (Blizzard "GO-bg-header"). If the atlas is
		-- unavailable we just leave the texture blank.
		bar.BG = bar:CreateTexture(nil, "BACKGROUND")
		bar.BG:SetAllPoints(bar)
		if bar.BG.SetAtlas then
			--bar.BG:SetAtlas("GO-bg-header", false)
			--bar.BG:SetAtlas("shop-header-menu-BG-right-dis", false)
			--bar.BG:SetAtlas("auctionhouse-background-index", false)
			--bar.BG:SetAtlas("shop-card-label-bg", false)
			bar.BG:SetAtlas(atlasTexture, false)
		end
		anchorframe.GlobalBar = bar
	end

	-- Anchor below the Label, full width matching the options area.
	local labelH = anchorframe.Label and anchorframe.Label:GetHeight() or 0
	bar:ClearAllPoints()
	bar:SetPoint("TOP", anchorframe, "TOP", 0, -(labelH + GLOBAL_BAR_TOP_GAP))
	bar:SetWidth(Ns.SeparatorWidth or (Ns.maxOptionsWidth or 600))

	local btnEnable   = MakeBarButton(bar, "BtnEnable",  L["GlobalBar_EnableAll"]   or "Enable all stats")
	local btnDisable  = MakeBarButton(bar, "BtnDisable", L["GlobalBar_DisableAll"]  or "Disable all stats")
	local btnQColor   = MakeBarButton(bar, "BtnQColor",  L["GlobalBar_QuickColor"]  or "Quick color")
	local btnQBars    = MakeBarButton(bar, "BtnQBars",   L["GlobalBar_QuickBars"]   or "Quick bars")

	btnEnable:SetScript("OnMouseDown", function()
		ConfirmThen(L["GlobalBar_ConfirmEnable"]  or "Enable every stat in this group?",
			function() GlobalBar_EnableAllStats(spellclass) end)
	end)
	btnDisable:SetScript("OnMouseDown", function()
		ConfirmThen(L["GlobalBar_ConfirmDisable"] or "Disable every stat in this group?",
			function() GlobalBar_DisableAllStats(spellclass) end)
	end)

	btnQColor:SetScript("OnMouseDown", function()
		Ns:ShowQuickColor(spellclass)
	end)

	btnQBars:SetScript("OnMouseDown", function()
		Ns:ShowQuickBars(spellclass)
	end)

	local items = { btnEnable, btnDisable, btnQColor, btnQBars }
	local total = 0
	for i, item in ipairs(items) do
		total = total + item:GetWidth()
		if i > 1 then total = total + GLOBAL_BAR_BTN_GAP end
	end
	local x = -total / 2
	for _, item in ipairs(items) do
		item:ClearAllPoints()
		item:SetPoint("LEFT", bar, "CENTER", x, 0)
		x = x + item:GetWidth() + GLOBAL_BAR_BTN_GAP
	end

	bar:Show()
	return bar
end

------------------------------------------
--			Design Functions			--
------------------------------------------
local function DisplayHorizontal(self, anchorframe, align, astab, noicons, ignoretoptabs)--, displayOrder, key, matchwith, noicons)
	local rowGap = astab and K.TOP_TAB_ROW_GAP or K.HOptionsOffsetY
	local colGap = astab and K.TOP_TAB_COL_GAP or K.HOptionsOffsetX
	local ChildAnchor
	anchorframe.HasScroll = nil
	anchorframe.TabScroll = nil
	if not astab then
		ChildAnchor = Ns:GetWidget("AnchorScroll" , anchorframe, 99999)
		anchorframe.HasScroll = ChildAnchor
		ChildAnchor.MyInformation = ChildAnchor.MyInformation or {}
		local xOfs = K.WIDGET_ROW_X_OFFSET or 0
		ChildAnchor:SetPoint("TOPLEFT", anchorframe.Description, xOfs, -30)
		ChildAnchor:SetPoint("BOTTOMRIGHT", Ns.ConfigFrame, -50, 10)
	else
		ChildAnchor = anchorframe
	end
	local largestWidgetWidth, largestWidgetHeight, sepOffset, tooltipOffset = 0, 0, 0
	local rowStarts = {}  -- first widget of each row, for row bg textures
	--widget = widget and strtrim(widget) or nil  -- dead code: 'widget' is not a parameter or local (global leak)
	local tipped = {}
	for k, v in ipairs(self.DisplayOrder) do
		if not v.spellclass or v.spellclass == self.MyInformation.stat or (self.MyInformation.options and self.MyInformation.options[v.spellclass]) then
			local f = Ns:GetWidget(astab and "TopTab" or v.widget.type, ChildAnchor.ScrollChild and ChildAnchor.ScrollChild or anchorframe, k)
			anchorframe:AddWidget(f, ChildAnchor.ScrollChild and ChildAnchor.ScrollChild or anchorframe)
			f.ActiveOnInit = astab and v.activeonload -- must come before f:Init
			f:Init(anchorframe, self, noicons)
			local w = f:GetWidth()
			local h = f:GetHeight()
			if f.Tip then
				local tipW = f.Tip:GetWidth() + 20
				if tipW > largestWidgetWidth then
					largestWidgetWidth = tipW
				end
				tipped[f] = true
				if not tooltipOffset then
					tooltipOffset = max(f.Tip:GetHeight(), 12) + Ns.TooltipYOffset
				end
			end
			if w > largestWidgetWidth then
				largestWidgetWidth = w
			end
			local extraHeight = 0
			if f.Tip then --if f.Tip and f.Tip:IsVisible() and f.Tip:GetText() and f.Tip:GetText() ~= "" then
				extraHeight = extraHeight + max(f.Tip:GetHeight(), 12) + Ns.TooltipYOffset
			end
			if f.SpecialType == "Slider" and f.Edit then--if f.SpecialType == "Slider" and f.Edit and f.Edit:IsVisible() then
				extraHeight = extraHeight + f.Edit:GetHeight() + 1
			end
			if h + extraHeight > largestWidgetHeight then
				largestWidgetHeight = h + extraHeight
			end
			if v.tooltip then
				f.Tooltip = Ns:GetWidget("Tooltip", f)
				f.Tooltip:Init(f, v)
			end
		end
	end
	largestWidgetHeight = ceil(largestWidgetHeight)
	largestWidgetWidth = ceil(largestWidgetWidth)

	local largestLabelW = 0
	for _, v in ipairs(anchorframe.CurrentWidgets) do
		if v.SpecialType ~= "TopTab" and v.Label and v.Label:GetText() and v.Label:GetText() ~= "" then
			local lw = ceil(v.Label:GetStringWidth() or 0)
			if lw > largestLabelW then largestLabelW = lw end
		end
	end
	if largestLabelW > 0 then
		for _, v in ipairs(anchorframe.CurrentWidgets) do
			if v.SpecialType ~= "TopTab" and v.Label and v.Label:GetText() and v.Label:GetText() ~= "" then
				v.Label:SetWidth(largestLabelW + 4)
				if v.Check then
					v.Check:ClearAllPoints()
					v.Check:SetPoint("LEFT", v.Label, "RIGHT", K.WIDGET_LABEL_GAP, 0)
				elseif v.SpecialType == "DropList" or v.SpecialType == "Slider" or v.SpecialType == "EditBox" then
					-- Frame holds label + gap + control; widen to fit padded label
					v:SetWidth(largestLabelW + 4 + K.WIDGET_LABEL_GAP + (v.MyInformation.widget.width or 140))
					if v.SpecialType == "EditBox" then

						v:SetTextInsets(largestLabelW + 4 + 2 + K.WIDGET_LABEL_GAP + 2, 0, 0, 0)
					end
					if v.SpecialType == "EditBox" and v._baseTextInsets then
						local ri, ti, bi = unpack(v._baseTextInsets)
						v:SetTextInsets(v._baseLeftInset + largestLabelW + 4 + 2 + K.WIDGET_LABEL_GAP, ri, ti, bi)
					end
				end
			end
		end

		for _, v in ipairs(anchorframe.CurrentWidgets) do
			local w = v:GetWidth()
			if w > largestWidgetWidth then
				largestWidgetWidth = w
			end
		end
	end
 	local maxItemsPerRow = floor(Ns.maxOptionsWidth / (largestWidgetWidth + colGap))
 	local rows, modOffset = 0, 1
 	local firstOnRow = ChildAnchor.ScrollChild and ChildAnchor.ScrollChild or anchorframe
 	local lastAnchor = firstOnRow
 	local cols = min(maxItemsPerRow, #anchorframe.CurrentWidgets)
 	local pageAlignment = anchorframe.CenterAlign and "TOP" or "TOPLEFT"
 	--local headerHeight = anchorframe.Description:GetHeight() + 24 -- y offset between header and top tabs
 	local headerHeight = 14 -- y offset between header and top tabs

	local spellclassName = self.SpellClass or (self.MyInformation and self.MyInformation.stat)
	local showGlobalBar = astab and self.DisplayOrder == Ns.DefaultOrder and spellclassName
	if showGlobalBar then
		BuildGlobalSettingsBar(anchorframe, spellclassName)
		headerHeight = headerHeight + GLOBAL_BAR_HEIGHT + GLOBAL_BAR_TOP_GAP + GLOBAL_BAR_BOTTOM_GAP
	elseif anchorframe.GlobalBar then
		anchorframe.GlobalBar:Hide()
	end
 	local subGroups = {}
	local visibleRowCount = 0
	local addTip
	local lastOptionGroup
	local descText = ""
	local descHeader = ""
	local descBody = ""
	if not astab and self.MyInformation.options then
		local rawText = L[self.MyInformation.stat .. "Description"]
		if rawText then
			descText = string.trim(rawText)
			if descText ~= "" then
				local headerEnd = descText:find("|r")
				if headerEnd then
					descHeader = descText:sub(1, headerEnd + 1)
					descBody = string.trim(descText:sub(headerEnd + 2))
				else
					descHeader = descText
					descBody = ""
				end
			end
		end
	end
	if ignoretoptabs then
		largestWidgetHeight = 0
	else
		for k, v in ipairs(anchorframe.CurrentWidgets) do
			if astab then
				v:SetWidth(largestWidgetWidth)
			end
			v:ClearAllPoints()
			local modVal = (k-modOffset) % maxItemsPerRow
			local hasSubgroup = v.MyInformation.subgroup and type(v.MyInformation.subgroup) == "table"
			local optGroup = (not astab and self.DisplayOrder == Ns.Options) and v.MyInformation.group or nil
			local groupChanged = optGroup and lastOptionGroup and optGroup ~= lastOptionGroup
			if k == 1 or v.MyInformation.newline or hasSubgroup or groupChanged or modVal == 0 then
				addTip = 0
				for i=k, k + maxItemsPerRow do
					if anchorframe.CurrentWidgets[i] and anchorframe.CurrentWidgets[i].newline then
						break
					end
					if tipped[anchorframe.CurrentWidgets[i]] then
						addTip = tooltipOffset
						break
					end
				end
				local yos = addTip
				if k == 1 then
					yos = (rowGap * 2) + (headerHeight + 2) + anchorframe.Label:GetHeight() + (not astab and (K.TOP_SEPARATOR_WIDGET_GAP + K.WIDGET_Y_OFFSET or 0) or 0)
				else
					if v.MyInformation.newline or hasSubgroup or groupChanged then
						modOffset = modOffset + modVal
					end
				end
				if v.Tip then
					yos = yos + 17  -- CHANGES THE Y OFFSET OF 1ST ROW AND 2ND ROW OPTIONS - TOGETHER
				end
			
				rows = rows + 1
				yos = k == 1 and -yos or -(yos + largestWidgetHeight + rowGap)
				if hasSubgroup then
					local text = v.MyInformation.subgroup.text or v.MyInformation.subgroup.stat
					tinsert(subGroups, {
						widget = v,
						label = format(Ns.WidgetDisplayFormat, Ns:GetSpellIcon(v.MyInformation.subgroup), L[text]),
						background = v.MyInformation.subgroup.background,
					})
					-- See K.SUBHEADER_RESERVE_Y in LAYOUT TWEAK KNOBS at the top.
					yos = yos - K.SUBHEADER_RESERVE_Y
				end

				if groupChanged then
					local grpInfo = groupTitles[optGroup]
					if grpInfo then
						tinsert(subGroups, {
							widget = v,
							label = format(Ns.WidgetDisplayFormat, Ns:GetSpellIcon(grpInfo), L[grpInfo.text]),
							background = grpInfo.background,
						})
						-- See K.SUBHEADER_RESERVE_Y in LAYOUT TWEAK KNOBS at the top.
						yos = yos - K.SUBHEADER_RESERVE_Y
					else
						yos = yos - 20
					end
				end
				v:SetPoint("TOPLEFT", firstOnRow, "TOPLEFT", 0, yos)
				if k ~= 1 then
					local p, r, t, x, y = firstOnRow:GetPoint(1)
					if y then
						sepOffset = sepOffset + firstOnRow:GetHeight() + y + yos
					end
					visibleRowCount = visibleRowCount + 1
				end
				tinsert(rowStarts, v)
				firstOnRow = v
				--savYos = yos
			else
				v:SetPoint(pageAlignment, lastAnchor, largestWidgetWidth + colGap, 0)
			end
			lastAnchor = v
			if optGroup then
				lastOptionGroup = optGroup
			end
			if v.SetLink then
				v:SetLink(anchorframe, self)
			end
			v:Show() -- required because widgets are hidden when they are "killed"
		end

		local _rowBgAtlas = Ns.ConfigAtlas and Ns.ConfigAtlas.WidgetRowBg or ""
		local _pageStat = (self.Parent and self.Parent.MyInformation and self.Parent.MyInformation.stat) or ""
		local _tabStat  = (self.MyInformation and self.MyInformation.stat) or ""
		local _noRowBg  = (_pageStat == "Layout") or (_pageStat == "Search") or (_pageStat == "Profiles")
		               or (_pageStat == "FAQ")    or (_pageStat == "Panels")
		if not _noRowBg and K.WIDGET_ROW_BG_ENABLED and (_rowBgAtlas ~= "" or K.WIDGET_ROW_BG_TEX ~= "" or K.WIDGET_ROW_BG_COLOR ~= "") and not astab and ChildAnchor and ChildAnchor.ScrollChild then
			local scrollChild = ChildAnchor.ScrollChild
			ChildAnchor.RowBgTexPool = ChildAnchor.RowBgTexPool or {}
			ChildAnchor.FullBgBorderPool = ChildAnchor.FullBgBorderPool or {}
			ChildAnchor.FullBgGradientPool = ChildAnchor.FullBgGradientPool or {}
			for _, t in ipairs(ChildAnchor.RowBgTexPool) do t:Hide() end
			for _, f in ipairs(ChildAnchor.FullBgBorderPool) do f:Hide() end
			for _, f in ipairs(ChildAnchor.FullBgGradientPool) do f:Hide() end
			local bgW = K.WIDGET_ROW_BG_W > 0 and K.WIDGET_ROW_BG_W or Ns.maxOptionsWidth
			local bgH = K.WIDGET_ROW_BG_H > 0 and K.WIDGET_ROW_BG_H or (largestWidgetHeight + K.WIDGET_ROW_BG_GAP)
			local padL, padR, padT, padB = K.WIDGET_ROW_BG_PAD_L, K.WIDGET_ROW_BG_PAD_R, K.WIDGET_ROW_BG_PAD_T, K.WIDGET_ROW_BG_PAD_B
			local subgroupStarts = {}
			for _, sg in ipairs(subGroups) do
				subgroupStarts[sg.widget] = true
			end
			local function ApplyBgStyle(tex, alpha, r, g, b, a)
				Ns:ApplyAtlasOrFallback(tex, "WidgetRowBg", function(t)
					if K.WIDGET_ROW_BG_TEX ~= "" then t:SetTexture(K.WIDGET_ROW_BG_TEX)
					elseif K.WIDGET_ROW_BG_COLOR ~= "" then t:SetTexture(K.WIDGET_ROW_BG_COLOR) end
				end)
				tex:SetVertexColor(r or K.WIDGET_ROW_BG_R, g or K.WIDGET_ROW_BG_G, b or K.WIDGET_ROW_BG_B, (a or K.WIDGET_ROW_BG_A) * alpha)
			end
			if K.WIDGET_FULL_BG then
				local texIdx = 0
				local sgStart, sgLast = nil, nil
				local insetL = K.WIDGET_FULL_BG_INSET_L or 0
				local insetR = K.WIDGET_FULL_BG_INSET_R or 0
				local al, ar = K.DROPLIST_LIST_BG_INSET_L, K.DROPLIST_LIST_BG_INSET_R
				local at, ab = K.DROPLIST_LIST_BG_INSET_T, K.DROPLIST_LIST_BG_INSET_B
				local function FlushFullBg()
					if not sgStart or not sgLast then return end
					texIdx = texIdx + 1
					local botWidget = sgLast
					local botOffset = -padB - ab
					if botWidget.SpecialType == "Slider" and botWidget.Edit then
						botOffset = botOffset - botWidget.Edit:GetHeight() - 1
					end

					if K.WIDGET_FULL_BG_ATLAS ~= "" then
						local atlas = ChildAnchor.FullBgBorderPool[texIdx]
						if not atlas then
							atlas = scrollChild:CreateTexture(nil, "BACKGROUND", nil, -1)
							ChildAnchor.FullBgBorderPool[texIdx] = atlas
						end
						Ns:ApplyAtlasOrFallback(atlas, "FullBg", function(t)
							if K.WIDGET_FULL_BG_EDGE_TEX ~= "" then
								t:SetTexture(K.WIDGET_FULL_BG_EDGE_TEX)
							else
								t:SetTexture("Interface/BUTTONS/WHITE8X8")
							end
							t:SetVertexColor(K.WIDGET_FULL_BG_R, K.WIDGET_FULL_BG_G, K.WIDGET_FULL_BG_B, K.WIDGET_FULL_BG_A * K.WIDGET_ROW_BG_ALPHA_FIRST)
						end)
						atlas:SetVertexColor(K.WIDGET_FULL_BG_EDGE_R, K.WIDGET_FULL_BG_EDGE_G, K.WIDGET_FULL_BG_EDGE_B, K.WIDGET_FULL_BG_EDGE_A)
						atlas:ClearAllPoints()
						atlas:SetPoint("TOPLEFT", sgStart, "TOPLEFT", -(padL + al) + insetL, K.WIDGET_ROW_BG_Y - padT + at)
						atlas:SetPoint("BOTTOM", botWidget, "BOTTOM", 0, botOffset)
						atlas:SetWidth(bgW + padL + padR + al + ar - insetL - insetR)
						atlas:Show()
					end
					if K.WIDGET_FULL_BG_GRADIENT then
						local gradient = ChildAnchor.FullBgGradientPool[texIdx]
						if not gradient then
							gradient = scrollChild:CreateTexture(nil, "BACKGROUND", nil, 0)
							ChildAnchor.FullBgGradientPool[texIdx] = gradient
						end
						gradient:SetTexture("Interface/BUTTONS/WHITE8X8")
						local ovR, ovG, ovB = K.WIDGET_FULL_BG_GRADIENT_OVERLAY_R or 0.4, K.WIDGET_FULL_BG_GRADIENT_OVERLAY_G or 0.38, K.WIDGET_FULL_BG_GRADIENT_OVERLAY_B or 0.35
						local topA = K.WIDGET_FULL_BG_GRADIENT_TOP_A or 0
						local washA = K.WIDGET_FULL_BG_GRADIENT_BOTTOM_A or 0.35
						local dir = K.WIDGET_FULL_BG_GRADIENT_DIRECTION or "TOP_BOTTOM"
						local orient, color1, color2
						if dir == "BOTTOM_TOP" then
							orient, color1, color2 = "VERTICAL", CreateColor(ovR, ovG, ovB, washA), CreateColor(ovR, ovG, ovB, topA)
						elseif dir == "LEFT_RIGHT" then
							orient, color1, color2 = "HORIZONTAL", CreateColor(ovR, ovG, ovB, topA), CreateColor(ovR, ovG, ovB, washA)
						elseif dir == "RIGHT_LEFT" then
							orient, color1, color2 = "HORIZONTAL", CreateColor(ovR, ovG, ovB, washA), CreateColor(ovR, ovG, ovB, topA)
						else -- "TOP_BOTTOM" (default)
							orient, color1, color2 = "VERTICAL", CreateColor(ovR, ovG, ovB, topA), CreateColor(ovR, ovG, ovB, washA)
						end
						gradient:SetGradient(orient, color1, color2)
						gradient:ClearAllPoints()
						local gpL = K.WIDGET_FULL_BG_GRADIENT_PAD_L or 0
						local gpR = K.WIDGET_FULL_BG_GRADIENT_PAD_R or 0
						local gpT = K.WIDGET_FULL_BG_GRADIENT_PAD_T or 0
						local gpB = K.WIDGET_FULL_BG_GRADIENT_PAD_B or 0
						local atlas = K.WIDGET_FULL_BG_ATLAS ~= "" and ChildAnchor.FullBgBorderPool[texIdx] or nil
						if atlas then
							-- Anchor to the atlas, inset by border width + padding.
							gradient:SetPoint("TOPLEFT", atlas, "TOPLEFT", al + gpL, -at - gpT)
							gradient:SetPoint("BOTTOMRIGHT", atlas, "BOTTOMRIGHT", -(ar + gpR), ab + gpB)
						else
							-- No atlas; anchor directly to the widget interior + padding.
							gradient:SetPoint("TOPLEFT", sgStart, "TOPLEFT", -padL + insetL + gpL, K.WIDGET_ROW_BG_Y - padT - gpT)
							gradient:SetPoint("BOTTOM", botWidget, "BOTTOM", 0, -padB + gpB)
							gradient:SetWidth(bgW + padL + padR - insetL - insetR - gpL - gpR)
						end
						gradient:Show()
					end
				end
				for idx, rowStart in ipairs(rowStarts) do
					if subgroupStarts[rowStart] and sgStart then
						FlushFullBg()
						sgLast = nil
					end
					if subgroupStarts[rowStart] then
						sgStart = rowStart
					end
					if sgStart then
						sgLast = rowStart
					end
				end
				FlushFullBg()
			else

				local rowIndexInSubgroup = 0
				for idx, rowStart in ipairs(rowStarts) do
					if subgroupStarts[rowStart] then
						rowIndexInSubgroup = 0
					end
					local rowAlpha = (rowIndexInSubgroup % 2 == 0) and K.WIDGET_ROW_BG_ALPHA_FIRST or K.WIDGET_ROW_BG_ALPHA_SECOND
					local tex = ChildAnchor.RowBgTexPool[idx]
					if not tex then
						tex = scrollChild:CreateTexture(nil, "BACKGROUND", nil, -1)
						ChildAnchor.RowBgTexPool[idx] = tex
					end
					ApplyBgStyle(tex, rowAlpha)
					tex:ClearAllPoints()
					tex:SetPoint("TOPLEFT", rowStart, "TOPLEFT", -padL, K.WIDGET_ROW_BG_Y - padT)
					tex:SetSize(bgW + padL + padR, bgH + padT + padB)
					tex:Show()
					rowIndexInSubgroup = rowIndexInSubgroup + 1
				end
			end
		end

		if not astab and #subGroups > 0 and ChildAnchor and ChildAnchor.ScrollChild then
			local scrollChild = ChildAnchor.ScrollChild
			local inset = (Ns.SubHeaderInset ~= nil) and Ns.SubHeaderInset or K.SUBHEADER_INSET
			local xOffset = (Ns.SubHeaderXOffset ~= nil) and Ns.SubHeaderXOffset or K.SUBHEADER_X_OFFSET
			local frameWidth = Ns.maxOptionsWidth - 5
			local headerToWidgetGap = Ns.SubHeaderToWidgetGap or K.SUBHEADER_TO_WIDGET_GAP
			local bgPosition = string.upper(K.SUBHEADER_BG_POSITION or "CENTER")
			local centered = (bgPosition ~= "LEFT")
			local centeredWidth = max(frameWidth - (inset * 2), 0)
			local leftWidth = (K.SUBHEADER_BG_W and K.SUBHEADER_BG_W > 0) and K.SUBHEADER_BG_W or frameWidth
			local textureWidth = centered and centeredWidth or leftWidth
			for _, sg in ipairs(subGroups) do
				local hdr = Ns:GetWidget("GroupBG", scrollChild)
				anchorframe:AddWidget(hdr, scrollChild)
				hdr:ClearAllPoints()
				hdr:SetPoint("BOTTOMLEFT", sg.widget, "TOPLEFT", -3, headerToWidgetGap)
				hdr:SetWidth(frameWidth)
				hdr:SetHeight(K.SUBHEADER_HEIGHT)
				hdr.Texture:ClearAllPoints()
				if centered then
					local centeredOffset = floor((frameWidth - textureWidth) / 2 + 0.5) + xOffset
					hdr.Texture:SetPoint("TOPLEFT", hdr, "TOPLEFT", centeredOffset, 0)
				else
					hdr.Texture:SetPoint("TOPLEFT", hdr, "TOPLEFT", xOffset, 0)
				end
				hdr.Texture:SetSize(textureWidth, K.SUBHEADER_HEIGHT)
				if K.SUBHEADER_BG_ENABLED then
					Ns:ApplyAtlasOrFallback(hdr.Texture, "SubHeader", function(t)
						if K.SUBHEADER_BG_TEX ~= "" then
							t:SetTexture(K.SUBHEADER_BG_TEX)
						else
							t:SetColorTexture(0.08020, 0.08020, 0.08020, 0.9)
						end
					end)
				else
					hdr.Texture:SetColorTexture(0, 0, 0, 0)
				end
				if hdr.Texture.SetDesaturated then
					hdr.Texture:SetDesaturated(K.SUBHEADER_BG_DESATURATED)
				end
				hdr.Texture:SetVertexColor(K.SUBHEADER_BG_R, K.SUBHEADER_BG_G, K.SUBHEADER_BG_B, K.SUBHEADER_BG_A)
				hdr.Title:ClearAllPoints()
				local titlePosition = string.upper(K.SUBHEADER_TITLE_TEXT_POSITION or "LEFT")
				if titlePosition == "CENTER" then
					hdr.Title:SetPoint("CENTER", K.SUBHEADER_TITLE_TEXT_X, K.SUBHEADER_TITLE_TEXT_Y)
				else
					hdr.Title:SetPoint("LEFT", K.SUBHEADER_TITLE_TEXT_X, K.SUBHEADER_TITLE_TEXT_Y)
				end
				hdr:SetFrameLevel(max(scrollChild:GetFrameLevel(), 1))
				hdr.Title:SetText(sg.label)
				hdr.Title:SetTextColor(1, 1,1,1)
				hdr:Show()
			end
		end

		if not astab and descHeader ~= "" and ChildAnchor and ChildAnchor.ScrollChild then
			local firstWidget = anchorframe.CurrentWidgets[1]
			if firstWidget then
				local descBtn = Ns:GetWidget("GroupBG", anchorframe)
				anchorframe:AddWidget(descBtn, anchorframe)
				descBtn.Title:SetText("")
				descBtn.Texture:SetTexture(K.INFO_BTN_TEX ~= "" and K.INFO_BTN_TEX or (Ns.TexturePath.."Misc"))
				descBtn.Texture:SetVertexColor(1, 1, 1, 1)
				if K.INFO_BTN_HIGHLIGHT_TEX ~= "" then
					descBtn.Highlight = descBtn:CreateTexture(nil, "OVERLAY")
					descBtn.Highlight:SetAllPoints(descBtn.Texture)
					descBtn.Highlight:SetTexture(K.INFO_BTN_HIGHLIGHT_TEX)
					descBtn.Highlight:SetVertexColor(K.INFO_BTN_HIGHLIGHT_R, K.INFO_BTN_HIGHLIGHT_G, K.INFO_BTN_HIGHLIGHT_B, K.INFO_BTN_HIGHLIGHT_A)
					descBtn.Highlight:SetBlendMode("ADD")
					descBtn.Highlight:Hide()
				end
				descBtn._isInfoBtn = true -- marker for HideStatInfo lookups
				descBtn:ClearAllPoints()
				descBtn:SetPoint("BOTTOMRIGHT", anchorframe, "TOP", (Ns.SeparatorWidth / 2) + K.INFO_BTN_X_OFFSET, K.INFO_BTN_Y_OFFSET)
				descBtn:SetSize(K.INFO_BTN_W, K.INFO_BTN_H)
				descBtn:SetFrameLevel(anchorframe:GetFrameLevel() + 5)
				descBtn:EnableMouse(true)
				descBtn:Show()

				local rawTextForBtn = descText
				descBtn:SetScript("OnMouseDown", function(self)
					Ns:ShowStatInfo(rawTextForBtn, self)
				end)
				descBtn:SetScript("OnEnter", function(self)
					if not self._infoOpen then
						self.Texture:SetVertexColor(1, 1, 0.6, 1)
						if self.Highlight then self.Highlight:Show() end
					end
				end)
				descBtn:SetScript("OnLeave", function(self)
					if not self._infoOpen then
						self.Texture:SetVertexColor(1, 1, 1, 1)
						if self.Highlight then self.Highlight:Hide() end
					end
				end)
			end
		end
	end
	if visibleRowCount == 2 then
		sepOffset = sepOffset + -(anchorframe.CurrentWidgets[1]:GetHeight() + (rowGap * 2))
	end
	local width
	if not astab then
		anchorframe.TopSeparator = Ns:GetWidget("Separator", anchorframe)
		anchorframe.TopSeparator:SetPoint("CENTER", anchorframe, "TOP", 0, K.TOP_SEPARATOR_Y)
		anchorframe.TopSeparator:Show()
		do
			anchorframe.BottomSeparator = Ns:GetWidget("Separator", anchorframe)
			anchorframe.BottomSeparator:Hide()
			if not astab then
				anchorframe.BottomSeparator:SetParent(ChildAnchor.ScrollChild)
			end
			anchorframe.BottomSeparator:Init(true)
			anchorframe.BottomSeparator:ClearAllPoints()
			local sepY = -(largestWidgetHeight + rowGap + 10)
			anchorframe.BottomSeparator:SetPoint("TOP", firstOnRow, "BOTTOMLEFT", Ns.SeparatorWidth / 2, sepY)
			if self.MyInformation.description and not self.MyInformation.options then
				local rawDescText = string.trim(L[self.MyInformation.stat.."Description"] or "")
				if rawDescText ~= "" then
					local descBtn = Ns:GetWidget("GroupBG", anchorframe)
					anchorframe:AddWidget(descBtn, anchorframe)
					descBtn.Title:SetText("")
					descBtn.Texture:SetTexture(K.INFO_BTN_TEX ~= "" and K.INFO_BTN_TEX or (Ns.TexturePath.."Misc"))
					descBtn.Texture:SetVertexColor(1, 1, 1, 1)
					-- Highlight overlay
					if K.INFO_BTN_HIGHLIGHT_TEX ~= "" then
						descBtn.Highlight = descBtn:CreateTexture(nil, "OVERLAY")
						descBtn.Highlight:SetAllPoints(descBtn.Texture)
						descBtn.Highlight:SetTexture(K.INFO_BTN_HIGHLIGHT_TEX)
						descBtn.Highlight:SetVertexColor(K.INFO_BTN_HIGHLIGHT_R, K.INFO_BTN_HIGHLIGHT_G, K.INFO_BTN_HIGHLIGHT_B, K.INFO_BTN_HIGHLIGHT_A)
						descBtn.Highlight:SetBlendMode("ADD")
						descBtn.Highlight:Hide()
					end
					descBtn._isInfoBtn = true
					descBtn:ClearAllPoints()
					descBtn:SetPoint("BOTTOMRIGHT", anchorframe, "TOP", (Ns.SeparatorWidth / 2) + K.INFO_BTN_X_OFFSET, K.INFO_BTN_Y_OFFSET)
					descBtn:SetSize(K.INFO_BTN_W, K.INFO_BTN_H)
					descBtn:SetFrameLevel(anchorframe:GetFrameLevel() + 5)
					descBtn:EnableMouse(true)
					descBtn:Show()

					descBtn:SetScript("OnMouseDown", function(self)
						Ns:ShowStatInfo(rawDescText, self)
					end)
					descBtn:SetScript("OnEnter", function(self)
						if not self._infoOpen then
							self.Texture:SetVertexColor(1, 1, 0.6, 1)
							if self.Highlight then self.Highlight:Show() end
						end
					end)
					descBtn:SetScript("OnLeave", function(self)
						if not self._infoOpen then
							self.Texture:SetVertexColor(1, 1, 1, 1)
							if self.Highlight then self.Highlight:Hide() end
						end
					end)
				end
			end
			anchorframe.BottomSeparator:SetTextColor(1,1,1) -- description text for stats
			anchorframe.BottomSeparator:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4) -- font size
			anchorframe.BottomSeparator:EnableToolip(true)
			
		end

		width = Ns.SeparatorWidth
	else
		width = cols * (largestWidgetWidth + colGap) - (rows == 1 and colGap or 0)
	end
	local height
	if ignoretoptabs then
		height = 0
		for _, w in ipairs(anchorframe.CurrentWidgets) do
			local h = w:GetHeight()
			if h > height then height = h end
		end
		height = height + rowGap + 20
	else
		height = rows * (largestWidgetHeight + rowGap) + rowGap + headerHeight + anchorframe.Label:GetHeight() + 20
		height = height + (#subGroups * 50) -- account for subgroup headers (matches yos = yos - 50 above)
	end
	local maxTabRows = 5 -- add a scrollbar after these tab rows... reducing need to resize again
	if astab and rows > maxTabRows then
		local tabScroll = Ns:GetWidget("AnchorScroll", anchorframe, 99999)
		tabScroll.MyInformation = tabScroll.MyInformation or {}
		tabScroll.UpArrow:SetParent(anchorframe)
		tabScroll.DownArrow:SetParent(anchorframe)
		tabScroll.ScrollBar:SetParent(anchorframe)
		local headerTotalH = (rowGap * 2) + (headerHeight + 2) + anchorframe.Label:GetHeight()
		local rowH = largestWidgetHeight + rowGap
		local fullContentH = rows * rowH + rowGap + 4
		local visibleH = maxTabRows * rowH + rowGap + 4
		tabScroll:ClearAllPoints()
		tabScroll:SetPoint("TOPLEFT", anchorframe, "TOPLEFT", 0, -headerTotalH)
		tabScroll:SetSize(width, visibleH)
		tabScroll.ScrollChild:SetSize(width, fullContentH)
		for _, v in ipairs(anchorframe.CurrentWidgets) do
			v:SetParent(tabScroll.ScrollChild)
		end
		local firstWidget = anchorframe.CurrentWidgets[1]
		if firstWidget then
			local _, _, _, _, origY = firstWidget:GetPoint(1)
			firstWidget:ClearAllPoints()
			firstWidget:SetPoint("TOPLEFT", tabScroll.ScrollChild, "TOPLEFT", 0, -(rowGap + 2))
		end
		anchorframe:AddWidget(tabScroll)
		anchorframe.TabScroll = tabScroll
		height = visibleH + headerTotalH + 20
	end
	anchorframe:SetAnchor(align, width, height)-- + headerHeight)
	if not astab then
		anchorframe:AddWidget(ChildAnchor)
		ChildAnchor.ScrollChild:SetSize(width, height)
	end

	C_Timer.After(0, function() if Ns.PP then Ns.PP.ResnapAllBorders() end end)
end

function Ns:UpdateProfile()
	if not Ns.ConfigFrame then return end
	if SinStatsFrame and SinStatsFrame._SinStatsConfigBtn then
		SinStatsFrame._SinStatsConfigBtn:SetShown(Ns.Profile.ConfigShortcut ~= false)
	end
	for i=0, #Ns.ConfigFrame.MainMenuItems do
		local item = Ns.ConfigFrame.MainMenuItems[i]
		local stat = item and item.SpellClass
		if stat == "Settings" or stat == "Text" then
			item.SvTable = Ns.Profile
		elseif stat and stat ~= "" then
			item.SvTable = Ns.Profile.Stats
		end
	end
	-- Refresh global panel switcher
	if Ns.ConfigFrame.PanelSwitcher then
		Ns.ConfigFrame.PanelSwitcher:Refresh()
	end
end

----------------------------------
--			Main Menu			--
----------------------------------
local function CreateMainMenu()
	local last, click
	for i=0, #Ns.SpellClass do
		local v = Ns.SpellClass[i]
		local f = Ns:GetWidget("MainMenuButton", Ns.ConfigFrame, sidePanelWidth) -- -10)
		f:SetEnabled(true)
		if string.trim(Ns.SpellClass[i].stat) == "" then
			f:SetEnabled(false)
 		end
		Ns.ConfigFrame.MainMenuItems[i] = f
		f:SetID(i)
		--f:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
		f:SetTextColor(1,1,1)
		local headerV = (v.headerIcon ~= nil) and { icon = v.headerIcon } or v
		f.HeaderIconStr = Ns:GetSpellIcon(headerV)
		local appliedAtlas = Ns:ApplyIconAtlasOrFallback(f.Icon, v.iconAtlas)
		if v.icon == "" then
			-- Explicit empty string = no icon; hide it and pull the label left.
			f.Icon:SetSize(0, 0)
			f.Label:ClearAllPoints()
			f.Label:SetPoint("LEFT", f, "LEFT", 10, 0)
		elseif not appliedAtlas then
			local iconPath = Ns:GetSpellIcon(v, Ns.IgnoreFormat)
			if iconPath and iconPath ~= "" then
				f.Icon:SetTexture(iconPath)
			else
				f.Icon:SetSize(0, 0)
				f.Label:ClearAllPoints()
				f.Label:SetPoint("LEFT", f, "LEFT", 0, 0)
			end
		end
		if f.IsStatSection or (string.trim(v.stat) ~= "" and v.stat ~= "Settings" and v.stat ~= "Text"
				and v.stat ~= "Layout" and v.stat ~= "Events" and v.stat ~= "Profiles"
				and v.stat ~= "Panels" and v.stat ~= "Search" and v.stat ~= "FAQ") then
			f.Icon:SetDesaturated(K.MAIN_MENU_STAT_ICON_IDLE_DESATURATED)
			f.Icon:SetVertexColor(K.MAIN_MENU_STAT_ICON_R, K.MAIN_MENU_STAT_ICON_G, K.MAIN_MENU_STAT_ICON_B, 1)
			f.Icon:SetAlpha(K.MAIN_MENU_STAT_ICON_IDLE_ALPHA)
		end
		f:SetLabel(L[Ns.SpellClass[i].stat])
		--f:SetFont(Ns.ConfigDefaultFont2)
		f:SetFontSize(K.MAIN_MENU_SECTION_TEXT_SIZE)
		f.SpellClass = v.stat
		if v.stat == "Settings" then
			click = f
			f.DisplayOrder = Ns.SettingsGroupOrder
			f.GroupOrder = Ns.SettingsGroupOrder
			f.NextDisplayOrder = Ns.SettingsDisplayOrder
		elseif v.stat == "Text" then
			f.DisplayOrder = Ns.TextGroupOrder
			f.GroupOrder = Ns.TextGroupOrder
			f.NextDisplayOrder = Ns.TextDisplayOrder
		elseif v.stat == "Layout" then
			f.DisplayOrder = Ns.LayoutGroupOrder
			f.GroupOrder = Ns.LayoutGroupOrder
			f.NextDisplayOrder = Ns.LayoutDisplayOrder
		elseif v.stat == "Events" then
			f.DisplayOrder = Ns.EventsGroupOrder
			f.GroupOrder = Ns.EventsGroupOrder
			f.NextDisplayOrder = Ns.EventsDisplayOrder
		elseif v.stat == "Profiles" then
			f.DisplayOrder = Ns.ProfileGroupOrder
			f.GroupOrder = Ns.ProfileGroupOrder
			f.NextDisplayOrder = Ns.ProfileDisplayOrder
		elseif v.stat == "Panels" then
			f.DisplayOrder = Ns.PanelGroupOrder
			f.GroupOrder = Ns.PanelGroupOrder
			f.NextDisplayOrder = Ns.PanelDisplayOrder
		elseif v.stat == "Search" then
			f.DisplayOrder = Ns.SearchGroupOrder
			f.GroupOrder = Ns.SearchGroupOrder
			f.NextDisplayOrder = Ns.SearchDisplayOrder
		elseif v.stat == "FAQ" then
			f.DisplayOrder = Ns.FAQGroupOrder
			f.GroupOrder = Ns.FAQGroupOrder
			f.NextDisplayOrder = Ns.FAQDisplayOrder
		else  -- SpellClass Tabs (stat sections)
			f.DisplayOrder = Ns.DefaultOrder
			f.GroupOrder = Ns.SpellClass
			f.NextDisplayOrder = Ns.Options --Ns.OptionsList --Ns.GetStatOptionDefaults
--			f.SvTable = Ns.Profile.Stats
			if string.trim(v.stat) ~= "" then
				f.IsStatSection = true
			end
		end
		if f.IsStatSection then
			f:ApplyStatLayout()
		elseif f.Icon and f.Icon:GetWidth() > 0 and f.Icon:GetHeight() > 0 then
			if K.MAIN_MENU_SECTION_ICON_SIZE and K.MAIN_MENU_SECTION_ICON_SIZE > 0 then
				f.Icon:SetSize(K.MAIN_MENU_SECTION_ICON_SIZE, K.MAIN_MENU_SECTION_ICON_SIZE)
			end
			f.Icon:SetDesaturated(K.MAIN_MENU_SECTION_ICON_DESATURATED)
			f.Icon:SetVertexColor(K.MAIN_MENU_SECTION_ICON_R, K.MAIN_MENU_SECTION_ICON_G, K.MAIN_MENU_SECTION_ICON_B, K.MAIN_MENU_SECTION_ICON_A)
			f.Label:ClearAllPoints()
			f.Label:SetPoint("LEFT", f.Icon, "RIGHT", K.MAIN_MENU_SECTION_ICON_TEXT_GAP or 4, 0)
		end
		f.MyInformation = v
		f.DisplayFunc = DisplayHorizontal
		f.HeaderTex = v.bgTex
		if f.IsStatSection then
			local permTexPath   = (v.texture and v.texture ~= "") and v.texture or ((v.overlay and v.overlay ~= "") and v.overlay or K.MAIN_MENU_HIGHLIGHT_TEX)
			local bgTexPath     = (v.background and v.background ~= "") and v.background or K.LEFT_DECO_BG_TEX
			local bgMaskEnabled = v.backgroundMask == true -- round mask for the background texture
			local bgMaskTexPath = (v.backgroundMaskTex and v.backgroundMaskTex ~= "") and v.backgroundMaskTex or permTexPath
			local hoverTexPath  = K.MAIN_MENU_STAT_HOVER_TEX  ~= "" and K.MAIN_MENU_STAT_HOVER_TEX  or permTexPath
			local selectTexPath = K.MAIN_MENU_STAT_SELECT_TEX ~= "" and K.MAIN_MENU_STAT_SELECT_TEX or permTexPath
			if permTexPath ~= "" then
				local sg = f:CreateTexture(nil, "OVERLAY", nil, 0)
				sg:SetTexture(selectTexPath)
				local _sgY = K.MAIN_MENU_STAT_HIGHLIGHT_Y
				if K.MAIN_MENU_STAT_GLOW_W > 0 and K.MAIN_MENU_STAT_GLOW_H > 0 then
					sg:SetPoint("CENTER", f, "CENTER", 0, _sgY)
					sg:SetSize(K.MAIN_MENU_STAT_GLOW_W, K.MAIN_MENU_STAT_GLOW_H)
				elseif K.MAIN_MENU_STAT_GLOW_H > 0 then
					sg:SetPoint("LEFT",  f, "LEFT",  0, _sgY)
					sg:SetPoint("RIGHT", f, "RIGHT", -K.MAIN_MENU_STAT_TEX_RIGHT_GAP, _sgY)
					sg:SetHeight(K.MAIN_MENU_STAT_GLOW_H)
				elseif K.MAIN_MENU_STAT_GLOW_W > 0 then
					sg:SetPoint("TOP",    f, "TOP",    0, _sgY)
					sg:SetPoint("BOTTOM", f, "BOTTOM", 0, _sgY)
					sg:SetWidth(K.MAIN_MENU_STAT_GLOW_W)
				else
					sg:SetPoint("TOPLEFT",     f, "TOPLEFT",     0, 0)
					sg:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -K.MAIN_MENU_STAT_TEX_RIGHT_GAP, 0)
				end
				sg:SetDesaturated(K.MAIN_MENU_STAT_SELECT_DESATURATED)
				sg:SetVertexColor(K.MAIN_MENU_STAT_SELECT_R, K.MAIN_MENU_STAT_SELECT_G, K.MAIN_MENU_STAT_SELECT_B, 1)
				sg:SetAlpha(0)  -- hidden until Expand(); toggled by Expand()/Collapse()
				f.SelectGlow = sg
				-- HighlightTexture: hover glow (separate object — independently tweakable).
				f:SetHighlightTexture(hoverTexPath)
				local ht = f:GetHighlightTexture()
				ht:ClearAllPoints()
				ht:SetDesaturated(K.MAIN_MENU_STAT_HOVER_DESATURATED)
				ht:SetVertexColor(K.MAIN_MENU_STAT_HOVER_R, K.MAIN_MENU_STAT_HOVER_G, K.MAIN_MENU_STAT_HOVER_B, 1)
				ht:SetAlpha(K.MAIN_MENU_STAT_HOVER_A or 1)
				local _htY = K.MAIN_MENU_STAT_HIGHLIGHT_Y
				if K.MAIN_MENU_STAT_GLOW_W > 0 and K.MAIN_MENU_STAT_GLOW_H > 0 then
					ht:SetPoint("CENTER", f, "CENTER", 0, _htY)
					ht:SetSize(K.MAIN_MENU_STAT_GLOW_W, K.MAIN_MENU_STAT_GLOW_H)
				elseif K.MAIN_MENU_STAT_GLOW_H > 0 then
					ht:SetPoint("LEFT",  f, "LEFT",  0, _htY)
					ht:SetPoint("RIGHT", f, "RIGHT", -K.MAIN_MENU_STAT_TEX_RIGHT_GAP, _htY)
					ht:SetHeight(K.MAIN_MENU_STAT_GLOW_H)
				elseif K.MAIN_MENU_STAT_GLOW_W > 0 then
					ht:SetPoint("TOP",    f, "TOP",    0, _htY)
					ht:SetPoint("BOTTOM", f, "BOTTOM", 0, _htY)
					ht:SetWidth(K.MAIN_MENU_STAT_GLOW_W)
				else
					ht:SetPoint("TOPLEFT",     f, "TOPLEFT",     0, 0)
					ht:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -K.MAIN_MENU_STAT_TEX_RIGHT_GAP, 0)
				end
			end

			if permTexPath ~= "" then
				local permTex = f:CreateTexture(nil, "BACKGROUND", nil, 0)
				if K.MAIN_MENU_STAT_TEX_H > 0 then
					permTex:SetPoint("LEFT",  f, "LEFT",  0, 0)
					permTex:SetPoint("RIGHT", f, "RIGHT", -K.MAIN_MENU_STAT_TEX_RIGHT_GAP, 0)
					permTex:SetHeight(K.MAIN_MENU_STAT_TEX_H)
				else
					permTex:SetPoint("TOPLEFT",     f, "TOPLEFT",     0, 0)
					permTex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -K.MAIN_MENU_STAT_TEX_RIGHT_GAP, 0)
				end
				permTex:SetTexture(permTexPath)
				permTex:SetAlpha(K.MAIN_MENU_STAT_PERM_TEX_ALPHA)
				f.PermHighlightTex = permTex
			end

			if bgTexPath ~= "" then
				local bgTex = f:CreateTexture(nil, "BACKGROUND", nil, 1)
				local bgAnchor = f.PermHighlightTex or f
				local bgInsetLeft   = K.LEFT_DECO_BG_INSET_LEFT or 0
				local bgInsetRight  = K.LEFT_DECO_BG_INSET_RIGHT or 0
				local bgInsetTop    = K.LEFT_DECO_BG_INSET_TOP or 0
				local bgInsetBottom = K.LEFT_DECO_BG_INSET_BOTTOM or 0
				local bgOffsetX = K.LEFT_DECO_BG_X or 0
				local bgOffsetY = K.LEFT_DECO_BG_Y or 0
				local bgCenterX = bgOffsetX + (bgInsetLeft - bgInsetRight) / 2
				local bgCenterY = bgOffsetY + (bgInsetBottom - bgInsetTop) / 2
				local bgW, bgH = K.LEFT_DECO_BG_W > 0, K.LEFT_DECO_BG_H > 0
				if bgW and bgH then
					bgTex:SetPoint("CENTER", bgAnchor, "CENTER", bgCenterX, bgCenterY)
					bgTex:SetSize(K.LEFT_DECO_BG_W, K.LEFT_DECO_BG_H)
				elseif bgH then
					bgTex:SetPoint("LEFT",  bgAnchor, "LEFT",  bgInsetLeft + bgOffsetX, bgOffsetY)
					bgTex:SetPoint("RIGHT", bgAnchor, "RIGHT", -bgInsetRight + bgOffsetX, bgOffsetY)
					bgTex:SetHeight(K.LEFT_DECO_BG_H)
				elseif bgW then
					bgTex:SetPoint("TOP",    bgAnchor, "TOP",    bgCenterX, -bgInsetTop + bgOffsetY)
					bgTex:SetPoint("BOTTOM", bgAnchor, "BOTTOM", bgCenterX, bgInsetBottom + bgOffsetY)
					bgTex:SetWidth(K.LEFT_DECO_BG_W)
				else
					bgTex:SetPoint("TOPLEFT",     bgAnchor, "TOPLEFT",     bgInsetLeft + bgOffsetX, -bgInsetTop + bgOffsetY)
					bgTex:SetPoint("BOTTOMRIGHT", bgAnchor, "BOTTOMRIGHT", -bgInsetRight + bgOffsetX, bgInsetBottom + bgOffsetY)
				end
				bgTex:SetTexture(bgTexPath)
				local startA, endA = Ns.GetMainMenuDecoGradientAlphas("idle")
				bgTex:SetGradient("HORIZONTAL", CreateColor(1, 1, 1, startA), CreateColor(1, 1, 1, endA))
				if K.LEFT_DECO_BG_BLEND ~= "" then bgTex:SetBlendMode(K.LEFT_DECO_BG_BLEND) end
				if bgMaskEnabled and bgMaskTexPath ~= "" then
					local bgMask = f:CreateMaskTexture(nil, "BACKGROUND", nil, 2)
					bgMask:SetTexture(bgMaskTexPath)
					bgMask:SetAllPoints(bgTex)
					bgTex:AddMaskTexture(bgMask)
					f.StatBgMask = bgMask
				end
				f.StatBgTex = bgTex
			end

			if K.MAIN_MENU_STAT_TEX_H > 0 then
				f:SetHeight(K.MAIN_MENU_STAT_TEX_H)
			end
			if K.MAIN_MENU_STAT_W > 0 then
				f:SetWidth(K.MAIN_MENU_STAT_W)
			end
		else
			if K.MAIN_MENU_SECTION_W > 0 then
				f:SetWidth(K.MAIN_MENU_SECTION_W)
			end
			if K.MAIN_MENU_SECTION_PERM_TEX ~= "" then
				local permTex = f:CreateTexture(nil, "BACKGROUND", nil, 0)
				permTex:SetAllPoints()
				permTex:SetTexture(K.MAIN_MENU_SECTION_PERM_TEX)
				f.PermTex = permTex
			end
		end
		if f.IsStatSection then
			f.Label:SetTextColor(K.MAIN_MENU_STAT_TEXT_R, K.MAIN_MENU_STAT_TEXT_G, K.MAIN_MENU_STAT_TEXT_B, K.MAIN_MENU_STAT_TEXT_A)
		else
			f.Label:SetTextColor(K.MAIN_MENU_SECTION_TEXT_R, K.MAIN_MENU_SECTION_TEXT_G, K.MAIN_MENU_SECTION_TEXT_B, K.MAIN_MENU_SECTION_TEXT_A)
		end
		local currentMenuXOffset = f.IsStatSection and K.MAIN_MENU_STAT_X_OFFSET or 0
		local previousMenuXOffset = last and last.MainMenuXOffset or 0
		if i == 0 then
			f:SetPoint("TOPLEFT", Ns.ConfigFrame.TopBorder, "LEFT", currentMenuXOffset, K.mainMenuYOffset) -- the first main menu item position relative to the top border line
			last = f
		else
			f:SetPoint("TOPLEFT", last, "BOTTOMLEFT", currentMenuXOffset - previousMenuXOffset, f.IsStatSection and K.MAIN_MENU_ITEM_GAP or -5)
			last = f
		end
		f.MainMenuXOffset = currentMenuXOffset
 		Ns:UpdateProfile()
	end
	click:Click()
end

--------------------------------------
--			Config frame			--
--------------------------------------
local ColorBorders = Ns.ColorBorders
local CreateBorder = Ns.CreateBorder

local f = CreateFrame("frame", "SinStatsConfigFrame", UIParent)
f:SetPoint("CENTER")
f:SetMovable(true)
f:SetUserPlaced(true)
f:EnableMouse(true)
f:Hide()

local function InitConfig()
	local f = SinStatsConfigFrame
	Ns.ConfigFrame = f
	f.MainMenuItems = {} -- Toplevel items always visible

	f.Background = f:CreateTexture()
	f.Background:SetAllPoints()
	f.Background:SetTexture(K.RIGHT_BODY_BG_TEX)
	f.Background:SetVertexColor(
	K.RIGHT_BODY_BG_COLOR_R,
	K.RIGHT_BODY_BG_COLOR_G,
	K.RIGHT_BODY_BG_COLOR_B,
	K.RIGHT_BODY_BG_COLOR_A)
	f:SetSize(Ns.ConfigWidth or 800, Ns.ConfigHeight or 500)

	f.SideBackground = f:CreateTexture()
	f.SideBackground:SetDrawLayer("ARTWORK", 1)
	f.SideBackground:SetSize(K.LEFT_PANEL_W, Ns.ConfigHeight)
	f.SideBackground:SetPoint("TOPLEFT", 0, 0)
	if K.LEFT_MENU_BG_TEX ~= "" then
		f.SideBackground:SetTexture(K.LEFT_MENU_BG_TEX)
		f.SideBackground:SetVertexColor(
			K.LEFT_MENU_BG_COLOR_R,
			K.LEFT_MENU_BG_COLOR_G,
			K.LEFT_MENU_BG_COLOR_B,
			K.LEFT_MENU_BG_COLOR_A)
	else
		f.SideBackground:SetColorTexture(
			K.LEFT_MENU_BG_COLOR_R,
			K.LEFT_MENU_BG_COLOR_G,
			K.LEFT_MENU_BG_COLOR_B,
			K.LEFT_MENU_BG_COLOR_A)
	end

	f:SetClampedToScreen(false)
	f:SetScript("OnShow", function(self)
		Ns.PP.SnapFrameToPixels(self)
		Ns.PP.ResnapAllBorders()

		if not self._initialLayoutDone then
			self._initialLayoutDone = true
			C_Timer.After(0.005, function()
				ReExpandActiveMenu()
			end)
		end
	end)
	f:SetFrameStrata("HIGH")
	tinsert(UISpecialFrames, Ns.ConfigFrame:GetName())
	f.Close = CreateFrame('Button', '$parentClose', f, "UIPanelCloseButton")
	f.Close:SetPoint('TOPRIGHT', -11, -5)
	f.Close:SetSize(15, 15)
	f.Close:SetFrameLevel(4)
	f.Close:SetHighlightTexture(Ns.TexturePath.."Close")
	f.Close:GetHighlightTexture():SetVertexColor(redColor.r, redColor.g, redColor.b, 1)
	f.Close:SetNormalTexture(Ns.TexturePath.."Close")
	f.Close:GetNormalTexture():SetVertexColor(white.r, white.g, white.b, 0.3)
	f.Close:SetPushedTexture(Ns.TexturePath.."Close")
	f.Close:GetPushedTexture():SetVertexColor(redColor.r, redColor.g, redColor.b, 0.9)
	f.Close:SetScript('OnClick', function(self)
		self:GetParent():Hide()
	end)
	f:HookScript("OnHide", function() if Ns.HideStatInfo then Ns:HideStatInfo() end if Ns.HideQuickColor then Ns:HideQuickColor() end if Ns.HideQuickBars then Ns:HideQuickBars() end end)

	f.Title = f:CreateFontString("$parentTitle", "OVERLAY")
	f.Title:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize)
	f.Title:SetPoint("TOP", 0, -15)
	f.Logo = f:CreateTexture("$parentLogo", "OVERLAY")
	f.Logo:SetTexture(Ns.TexturePath.."SinStatsLogo")
--[[
	f.Logo:SetSize(300, 300) -- So the frame isn't mostly blank when first opened (MainMenuScripts.OnClick for where it's moved)
	f.Logo:SetPoint("CENTER", 70, -10)
]]--
	f.Logo:SetSize(90, 90)
	f.Logo:SetPoint("TOPLEFT", 25, 3)
	f.Logo:SetAlpha(0.7)

	f.Caption = CreateFrame("Frame", nil, f) -- Menu anchor point (see CreateMainMenu)
	f.Caption:SetPoint("TOPLEFT")
	f.Caption:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", 0, -50)

	f.TopBorder = f:CreateLine()
	f.TopBorder:SetDrawLayer("OVERLAY", 1)
	f.TopBorder:SetThickness(3)
	f.TopBorder:SetAlpha(0.5)
	f.TopBorder:SetStartPoint("BOTTOMLEFT", f.Caption, 10, 100)
	f.TopBorder:SetEndPoint("BOTTOMRIGHT", f.Caption, -10, -2)
	f.TopBorder:SetColorTexture(0.05, 0.05, 0.05, 0)

	f.DragBar = CreateFrame("Frame", nil, f)
	f.DragBar:SetPoint("TOPLEFT", f.Logo, "TOPLEFT", 0, 0)
	f.DragBar:SetPoint("TOPRIGHT", f.Close, "TOPRIGHT", 0, 0)
	f.DragBar:SetHeight(K.CONFIG_DRAG_HEIGHT)
	f.DragBar:EnableMouse(true)
	f.DragBar:RegisterForDrag("LeftButton")
	f.DragBar:SetScript("OnDragStart", function() f:StartMoving() end)
	f.DragBar:SetScript("OnDragStop", function()
		f:StopMovingOrSizing()
		Ns.PP.SnapFrameToPixels(f)
		Ns.PP.ResnapAllBorders()
	end)

	-- local scale = f:GetEffectiveScale()
	-- local pixel = 1 / scale
	-- local sideX = math.floor(151 * scale + 0.5) / scale + pixel / 2
	-- f.SideBorder = f:CreateLine()
	-- f.SideBorder:SetDrawLayer("OVERLAY", 1)
	-- f.SideBorder:SetThickness(pixel)
	-- f.SideBorder:SetAlpha(1)
	-- f.SideBorder:SetStartPoint("LEFT", f.TopBorder, sideX - 10, 0)
	-- f.SideBorder:SetEndPoint("BOTTOMLEFT", f, sideX, 0)
	-- f.SideBorder:SetColorTexture(0, 0, 0)

	f.SideBorder = f:CreateTexture(nil, "OVERLAY", nil, 1)
	f.SideBorder:SetTexture(K.SIDE_SEPARATOR_TEX)
	f.SideBorder:SetTexCoord(K.SIDE_SEPARATOR_TEX_L, K.SIDE_SEPARATOR_TEX_R, K.SIDE_SEPARATOR_TEX_T, K.SIDE_SEPARATOR_TEX_B)
	f.SideBorder:SetVertexColor(K.SIDE_SEPARATOR_R, K.SIDE_SEPARATOR_G, K.SIDE_SEPARATOR_B, K.SIDE_SEPARATOR_A)
	f.SideBorder:SetWidth(K.SIDE_SEPARATOR_W)
	f.SideBorder:SetPoint("TOPLEFT", f, "TOPLEFT", K.LEFT_PANEL_W-3, 0)
	f.SideBorder:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", K.LEFT_PANEL_W, 0)

	-- Version
	f.Version = f:CreateFontString("$parentTitle", "OVERLAY")
	f.Version:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 6)
	f.Version:SetPoint("BOTTOMLEFT", 65, 1)
	f.Version:SetText(Ns.Colors.Orange .. addVer .. "|r")

	sidePanelWidth = K.LEFT_PANEL_W - 10
	Ns.maxOptionsWidth = f:GetWidth() - sidePanelWidth - 30 -- -30 right indent size
	Ns.SeparatorWidth  = Ns.maxOptionsWidth / 1.15
	f.StatHeaderBg = f:CreateTexture(nil, "ARTWORK", nil, 2)
	if K.STAT_HEADER_WIDTH > 0 then
		-- sidePanelWidth/2 right of frame centre = centre of the right content area.
		f.StatHeaderBg:SetPoint("TOP", f, "TOP", sidePanelWidth / 2, 0)
		f.StatHeaderBg:SetSize(K.STAT_HEADER_WIDTH, K.STAT_HEADER_HEIGHT)
	else
		-- 0 = span the full right content area
		f.StatHeaderBg:SetPoint("TOPLEFT",     f, "TOPLEFT",  sidePanelWidth, 0)
		f.StatHeaderBg:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", 0, -K.STAT_HEADER_HEIGHT)
	end
	f.StatHeaderBg:SetAlpha(1)
	f.StatHeaderBg:Hide()
	f.TopAnchor = CreateFrame("Frame", nil, f)
	f.TopAnchor:SetSize(5, 2)
	f.TopAnchor:SetPoint("TOP", (sidePanelWidth/2), -10) -- x,y entire right side panel content
	Ns.TopAnchor = f.TopAnchor

	CreateMainMenu()

	-- Global HUD switcher (right panel area, top-left)
	f.PanelSwitcher = Ns:GetWidget("PanelSwitcher", f)
	f.PanelSwitcher:SetPoint("TOPLEFT", f, "TOPLEFT", sidePanelWidth + 15, -26)
	f.PanelSwitcher:SetFrameLevel(f:GetFrameLevel() + 3)
	f.PanelSwitcher:Refresh()

	f.NineSlice = CreateConfigTextureBorder(f)
end

------------------
--  Tips & Info --
------------------

local function ParseInfoSegments(rawText)
	local segments = {}
	if not rawText or rawText == "" then return segments end
	local body = rawText
	local headerEnd = body:find("|r")
	if headerEnd then
		body = body:sub(headerEnd + 2)
	end
	body = string.trim(body)
	if body == "" then return segments end

	local current
	for line in (body .. "\n"):gmatch("(.-)\n") do
		local sub = line:match("^%s*##%s*(.-)%s*$")
		if sub then
			if current then tinsert(segments, current) end
			tinsert(segments, { kind = "subheader", text = sub })
			current = nil
		else
			if current then
				current.text = current.text .. "\n" .. line
			else
				current = { kind = "text", text = line }
			end
		end
	end
	if current then tinsert(segments, current) end

	for _, seg in ipairs(segments) do
		seg.text = string.trim(seg.text)
	end
	return segments
end

local function CreateInfoFrame(parent)
	local infoW = K.INFO_FRAME_WIDTH
	local f = CreateFrame("Frame", "SinStatsInfoFrame", parent)
	f:SetSize(infoW, 200)
	f:SetFrameStrata(parent:GetFrameStrata())
	f:SetFrameLevel(parent:GetFrameLevel() + 5)
	f:SetPoint("TOPLEFT", parent, "TOPRIGHT", 4, 0)
	f:Hide()

	f.Background = f:CreateTexture(nil, "BACKGROUND")
	f.Background:SetAllPoints()
	f.Background:SetTexture(K.INFO_FRAME_BG_TEX)
	f.Background:SetVertexColor(0.1, 0.1, 0.1, 1)

	--CreateBorder(f, 1)
	--ColorBorders(f, 0, 0, 0)

	f.Title = f:CreateFontString(nil, "OVERLAY")
	if K.INFO_TITLE_USE_MORPHEUS then
		local morpheus = Ns.LSM:Fetch("font", "Morpheus")
		f.Title:SetFont(morpheus or Ns.ConfigDefaultFont, K.INFO_TITLE_FONT_SIZE or 18)
	else
		f.Title:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize)
	end
	f.Title:SetPoint("TOP", 0, K.INFO_TITLE_TOP_Y)
	f.Title:SetText((L["TipsAndInfo"]:gsub("\n", "")))
	f.Title:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)

	if K.ACTIVE_HEADER_BG_TEX ~= "" then
		f.TitleBg = f:CreateTexture(nil, "BACKGROUND", nil, 1)
		f.TitleBg:SetPoint("TOPLEFT",     f.Title, "TOPLEFT",     -K.ACTIVE_HEADER_BG_PAD_LEFT,  6)
		f.TitleBg:SetPoint("BOTTOMRIGHT", f.Title, "BOTTOMRIGHT",  K.ACTIVE_HEADER_BG_PAD_RIGHT, -6)
		f.TitleBg:SetTexture(K.ACTIVE_HEADER_BG_TEX)
		f.TitleBg:SetVertexColor(0.3, 0.3, 0.3, K.ACTIVE_HEADER_BG_A)
	end

	f.Scroll = CreateFrame("ScrollFrame", nil, f)
	f.Scroll:SetPoint("TOPLEFT", 8, K.INFO_SCROLL_TOP_Y)
	f.Scroll:SetPoint("BOTTOMRIGHT", -8, K.INFO_SCROLL_BOTTOM_PAD)
	f.Scroll:EnableMouseWheel(true)
	f.Scroll:SetClipsChildren(true)
	f.Scroll.Child = CreateFrame("Frame", nil, f.Scroll)
	f.Scroll.Child:SetSize(infoW - 16, 1)
	f.Scroll:SetScrollChild(f.Scroll.Child)
	f.Scroll.Child:EnableMouse(true)
	if f.Scroll.Child.SetHyperlinksEnabled then
		f.Scroll.Child:SetHyperlinksEnabled(true)
	end
	f.Scroll.Child:SetScript("OnHyperlinkEnter", function(self, link)
		GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end)
	f.Scroll.Child:SetScript("OnHyperlinkLeave", function() GameTooltip:Hide() end)
	f.Scroll.Child:SetScript("OnHyperlinkClick", function(_, link, text, button)
		if IsModifiedClick("CHATLINK") and ChatEdit_InsertLink then
			ChatEdit_InsertLink(text or link)
		else
			SetItemRef(link, text, button)
		end
	end)
	f.Scroll:SetScript("OnMouseWheel", function(self, delta)
		local range = self:GetVerticalScrollRange()
		if range <= 0 then return end
		local cur = self:GetVerticalScroll()
		self:SetVerticalScroll(max(0, min(range, cur - delta * 20)))
	end)

	f.Segments = {}

	function f:SetContent(rawText)
		for _, fs in ipairs(self.Segments) do fs:Hide() end
		local segs = ParseInfoSegments(rawText)
		local child = self.Scroll.Child
		local textPad = K.INFO_TEXT_SIDE_PAD or 0
		local availW = math.max(1, child:GetWidth() - (textPad * 2))
		local y = 0
		for i, seg in ipairs(segs) do
			local fs = self.Segments[i]
			if not fs then
				fs = child:CreateFontString(nil, "OVERLAY")
				self.Segments[i] = fs
			end
			fs:ClearAllPoints()
			fs:SetWidth(availW)
			fs:SetJustifyH("CENTER")
			fs:SetJustifyV("TOP")
			if seg.kind == "subheader" then
				fs:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 2)
				fs:SetTextColor(0.443, 1, 0.788) -- Ns.Colors.Green RGB
				if i > 1 then y = y - 6 end
			else
				fs:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4)
				fs:SetTextColor(1, 1, 1)
			end
			fs:SetText(seg.text)
			fs:SetPoint("TOPLEFT", child, "TOPLEFT", textPad, y)
			fs:Show()
			local h = fs:GetStringHeight() + 4
			y = y - h
		end
		child:SetHeight(math.max(1, -y))
		local desiredH = math.min(540, math.max(80, -y + K.INFO_FRAME_CHROME_Y))
		self:SetHeight(desiredH)
		self.Scroll:SetVerticalScroll(0)
	end

	f:EnableMouse(true)
	f._activeBtn = nil
	f:HookScript("OnHide", function(self)
		if self._activeBtn then
			self._activeBtn._infoOpen = nil
			if self._activeBtn.Texture then
				self._activeBtn.Texture:SetVertexColor(1, 1, 1, 1)
			end
			self._activeBtn = nil
		end
		self._lastText = nil
	end)

	return f
end

------------------------------------------
--       Quick Color Side Panel         --
------------------------------------------
local QUICK_COLOR_ROW_H  = 26
local QUICK_COLOR_PAD_W  = 24
local QUICK_COLOR_PAD_H  = 20
local QUICK_COLOR_ICON_S = 18
local QUICK_COLOR_PANEL_W = K.INFO_FRAME_WIDTH

local function MakeQuickCheckButton(parent, label)
	local cb = CreateFrame("CheckButton", nil, parent)
	cb:SetSize(K.CHECKBOX_SIZE, K.CHECKBOX_SIZE)
	cb:SetNormalTexture("")
	cb:SetPushedTexture("")
	cb:SetHighlightTexture("")
	cb.FrameTex = cb:CreateTexture(nil, "ARTWORK", nil, 0)
	cb.FrameTex:SetAllPoints()
	cb.FrameTex:SetTexture(K.CHECKBOX_FRAME_TEX)
	cb:SetCheckedTexture(K.CHECKBOX_CHECK_TEX)
	local checked = cb:GetCheckedTexture()
	checked:SetBlendMode("BLEND")
	if K.CHECKBOX_CHECK_SIZE and K.CHECKBOX_CHECK_SIZE > 0 then
		checked:ClearAllPoints()
		checked:SetPoint("CENTER")
		checked:SetSize(K.CHECKBOX_CHECK_SIZE, K.CHECKBOX_CHECK_SIZE)
	end
	cb.Text = cb:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	cb.Text:SetPoint("LEFT", cb, "RIGHT", 4, 1)
	cb.Text:SetText(label)
	return cb
end

local function CreateQuickColorPanel(parent)
	local f = CreateFrame("Frame", nil, parent)
	f:SetSize(QUICK_COLOR_PANEL_W, 300)
	f:SetFrameStrata(parent:GetFrameStrata())
	f:SetFrameLevel(parent:GetFrameLevel() + 5)
	f:SetPoint("TOPLEFT", parent, "TOPRIGHT", 4, 0)
	f:Hide()

	f.Background = f:CreateTexture(nil, "BACKGROUND")
	f.Background:SetAllPoints()
	f.Background:SetTexture(K.INFO_FRAME_BG_TEX)
	f.Background:SetVertexColor(0.1, 0.1, 0.1, 1)

	-- Title
	f.Title = f:CreateFontString(nil, "OVERLAY")
	if K.INFO_TITLE_USE_MORPHEUS then
		local morpheus = Ns.LSM:Fetch("font", "Morpheus")
		f.Title:SetFont(morpheus or Ns.ConfigDefaultFont, K.INFO_TITLE_FONT_SIZE or 18)
	else
		f.Title:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize)
	end
	f.Title:SetPoint("TOP", 0, K.INFO_TITLE_TOP_Y)
	f.Title:SetText(L["GlobalBar_QuickColor"] or "Quick color")
	f.Title:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)

	if K.ACTIVE_HEADER_BG_TEX ~= "" then
		f.TitleBg = f:CreateTexture(nil, "BACKGROUND", nil, 1)
		f.TitleBg:SetPoint("TOPLEFT",     f.Title, "TOPLEFT",     -K.ACTIVE_HEADER_BG_PAD_LEFT,  6)
		f.TitleBg:SetPoint("BOTTOMRIGHT", f.Title, "BOTTOMRIGHT",  K.ACTIVE_HEADER_BG_PAD_RIGHT, -6)
		f.TitleBg:SetTexture(K.ACTIVE_HEADER_BG_TEX)
		f.TitleBg:SetVertexColor(0.3, 0.3, 0.3, K.ACTIVE_HEADER_BG_A)
	end

	-- Reset all text colors for the group (prompted button)
	local btnResetColors = MakeBarButton(f, "BtnResetColors", L["GlobalBar_ResetColor"] or "Reset text color")
	btnResetColors:SetPoint("TOPLEFT", 12, K.INFO_SCROLL_TOP_Y + 2)
	btnResetColors:SetScript("OnMouseDown", function()
		ConfirmThen(L["GlobalBar_ConfirmReset"] or "Reset text color for every stat in this group?",
			function()
				ResetAllTextColors(f._spellclass)
				if f._spellclass then f:Populate(f._spellclass) end
			end)
	end)

	f.EnableAllCB = MakeQuickCheckButton(f, L["QuickColor_EnableAll"] or "Enable individual colors")
	f.EnableAllCB:SetPoint("TOPLEFT", btnResetColors, "BOTTOMLEFT", 0, -4)

	f.EnableAllCB:SetScript("OnClick", function(cb)
		local checked = cb:GetChecked()
		local sc = f._spellclass
		if not sc then return end
		ForEachStatInSpellClass(sc, function(entry, data)
			data.ColorCustom = checked
		end)
		Ns:QueueProfileRefresh()
		Ns:InitialiseAllPanels()

		for _, row in ipairs(f.Rows or {}) do
			if row.CustomCB then
				row.CustomCB:SetChecked(checked)
			end
		end
	end)

	f.Scroll = CreateFrame("ScrollFrame", nil, f)
	f.Scroll:SetPoint("TOPLEFT", 8, K.INFO_SCROLL_TOP_Y - 56)
	f.Scroll:SetPoint("BOTTOMRIGHT", -8, K.INFO_SCROLL_BOTTOM_PAD)
	f.Scroll:EnableMouseWheel(true)
	f.Scroll:SetClipsChildren(true)
	f.Scroll.Child = CreateFrame("Frame", nil, f.Scroll)
	f.Scroll.Child:SetSize(QUICK_COLOR_PANEL_W - 16, 1)
	f.Scroll:SetScrollChild(f.Scroll.Child)
	f.Scroll:SetScript("OnMouseWheel", function(self, delta)
		local range = self:GetVerticalScrollRange()
		if range <= 0 then return end
		local cur = self:GetVerticalScroll()
		self:SetVerticalScroll(max(0, min(range, cur - delta * 20)))
	end)

	f.Rows = {}

	function f:Populate(spellclass)
		self._spellclass = spellclass
		for _, row in ipairs(self.Rows) do
			row:Hide()
		end

		local enabled = {}
		if spellclass and Ns.DefaultOrder and Ns.Profile and Ns.Profile.Stats then
			for _, entry in ipairs(Ns.DefaultOrder) do
				if type(entry) == "table" and entry.spellclass == spellclass and entry.stat then
					local data = Ns.Profile.Stats[entry.stat]
					if type(data) == "table" and data.Show then
						tinsert(enabled, { entry=entry, data=data })
					end
				end
			end
		end

		local child = self.Scroll.Child
		local y = 0
		local rowW = child:GetWidth()
		local allCustom = true

		for i, info in ipairs(enabled) do
			local row = self.Rows[i]
			if not row then
				row = CreateFrame("Frame", nil, child)
				row:SetSize(rowW, QUICK_COLOR_ROW_H)
				-- Spell icon
				row.Icon = row:CreateTexture(nil, "ARTWORK")
				row.Icon:SetSize(QUICK_COLOR_ICON_S, QUICK_COLOR_ICON_S)
				row.Icon:SetPoint("LEFT", 4, 0)
				-- Stat name
				row.Label = row:CreateFontString(nil, "OVERLAY")
				row.Label:SetPoint("LEFT", row.Icon, "RIGHT", 4, 0)
				row.Label:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4)
				row.Label:SetJustifyH("LEFT")
				row.Label:SetTextColor(1, 1, 1)

				row.CustomCB = CreateFrame("CheckButton", nil, row)
				row.CustomCB:SetSize(K.CHECKBOX_SIZE, K.CHECKBOX_SIZE)
				row.CustomCB:SetPoint("RIGHT", row, "RIGHT", -QUICK_COLOR_PAD_W - 18, 0)
				row.CustomCB:SetNormalTexture("")
				row.CustomCB:SetPushedTexture("")
				row.CustomCB:SetHighlightTexture("")
				row.CustomCB.FrameTex = row.CustomCB:CreateTexture(nil, "ARTWORK", nil, 0)
				row.CustomCB.FrameTex:SetAllPoints()
				row.CustomCB.FrameTex:SetTexture(K.CHECKBOX_FRAME_TEX)
				row.CustomCB:SetCheckedTexture(K.CHECKBOX_CHECK_TEX)
				local rcbChecked = row.CustomCB:GetCheckedTexture()
				rcbChecked:SetBlendMode("BLEND")
				if K.CHECKBOX_CHECK_SIZE and K.CHECKBOX_CHECK_SIZE > 0 then
					rcbChecked:ClearAllPoints()
					rcbChecked:SetPoint("CENTER")
					rcbChecked:SetSize(K.CHECKBOX_CHECK_SIZE, K.CHECKBOX_CHECK_SIZE)
				end
				row.CustomCB:SetScript("OnClick", function(cb)
					local d = row._data
					if d then
						d.ColorCustom = cb:GetChecked()
						Ns:QueueProfileRefresh()
						Ns:InitialiseAllPanels()
					end
				end)

				row.Swatch = CreateFrame("Button", nil, row)
				row.Swatch:SetSize(QUICK_COLOR_PAD_W, QUICK_COLOR_PAD_H)
				row.Swatch:SetPoint("RIGHT", -4, 0)
				row.Swatch.ColorTex = row.Swatch:CreateTexture(nil, "BACKGROUND")
				row.Swatch.ColorTex:SetAllPoints()
				row.Swatch.ColorTex:SetTexture(Ns.TexturePath.."ColorPad")
				row.Swatch.Border = row.Swatch:CreateTexture(nil, "BACKGROUND", nil, 1)
				row.Swatch.Border:SetPoint("TOPLEFT", -1, 1)
				row.Swatch.Border:SetPoint("BOTTOMRIGHT", 1, -1)
				row.Swatch.Border:SetColorTexture(0, 0, 0, 0.15)
				row.Swatch:SetScript("OnClick", function(sw, button)
					if button == "RightButton" then
						local d = row._data
						if d and d.ColorName then
							d.ColorName.r, d.ColorName.g, d.ColorName.b = 1, 1, 1
							sw.ColorTex:SetVertexColor(1, 1, 1)
							Ns:QueueProfileRefresh()
						end
						return
					end
					local d = row._data
					if not d then return end
					if not d.ColorName then d.ColorName = { r=1, g=1, b=1 } end
					local c = d.ColorName

					local function OnColorChange()
						local r1, g1, b1 = ColorPickerFrame:GetColorRGB()
						d.ColorName.r, d.ColorName.g, d.ColorName.b = r1, g1, b1
						sw.ColorTex:SetVertexColor(r1, g1, b1)
						Ns:QueueProfileRefresh()
					end

					local function OnColorCancel()
						local prev = ColorPickerFrame.previousValues
						if prev then
							d.ColorName.r, d.ColorName.g, d.ColorName.b = prev.r, prev.g, prev.b
							sw.ColorTex:SetVertexColor(prev.r, prev.g, prev.b)
						end
						Ns:QueueProfileRefresh()
					end

					ColorPickerFrame.previousValues = { r=c.r, g=c.g, b=c.b }
					if ColorPickerFrame.SetupColorPickerAndShow then
						local info = UIDropDownMenu_CreateInfo()
						info.r, info.g, info.b = c.r, c.g, c.b
						info.swatchFunc = OnColorChange
						info.cancelFunc = OnColorCancel
						ColorPickerFrame:SetupColorPickerAndShow(info)
						if ColorPickerFrame.Content then
							ColorPickerFrame.Content.ColorPicker:SetColorRGB(c.r, c.g, c.b)
						else
							ColorPickerFrame:SetColorRGB(c.r, c.g, c.b)
						end
					else
						ColorPickerFrame.func = OnColorChange
						ColorPickerFrame.cancelFunc = OnColorCancel
						ColorPickerFrame.hasOpacity = false
						ColorPickerFrame:SetColorRGB(c.r, c.g, c.b)
						ColorPickerFrame:Show()
					end
				end)
				self.Rows[i] = row
			end

			row._data = info.data
			row._entry = info.entry

			-- Icon
			local iconAtlas = info.entry.iconAtlas
			if iconAtlas then
				Ns:ApplyIconAtlasOrFallback(row.Icon, iconAtlas)
			elseif info.entry.spell then
				local spellInfo = C_Spell.GetSpellInfo(info.entry.spell)
				row.Icon:SetTexture(spellInfo and spellInfo.iconID or nil)
			elseif info.entry.item then
				local _, _, _, _, icon = C_Item.GetItemInfoInstant(info.entry.item)
				row.Icon:SetTexture(icon)
			elseif info.entry.currency then
				local info2 = C_CurrencyInfo.GetCurrencyInfo(info.entry.currency)
				row.Icon:SetTexture(info2 and info2.iconFileID or nil)
			else
				row.Icon:SetTexture(nil)
			end

			-- Label
			row.Label:SetText(L[info.entry.stat.."Menu"] or L[info.entry.stat] or info.entry.stat)

			-- ColorCustom checkbox
			row.CustomCB:SetChecked(info.data.ColorCustom == true)
			if not info.data.ColorCustom then allCustom = false end

			-- Color
			local c = info.data.ColorName
			if not c then
				info.data.ColorName = { r=1, g=1, b=1 }
				c = info.data.ColorName
			end
			row.Swatch.ColorTex:SetVertexColor(c.r, c.g, c.b)

			row:ClearAllPoints()
			row:SetPoint("TOPLEFT", child, "TOPLEFT", 0, y)
			row:Show()
			y = y - QUICK_COLOR_ROW_H - 2
		end

		-- Sync master checkbox
		self.EnableAllCB:SetChecked(allCustom)

		child:SetHeight(math.max(1, -y + 8))
		local desiredH = math.min(500, math.max(120, -y + 138))
		self:SetHeight(desiredH)
		self.Scroll:SetVerticalScroll(0)
	end

	f:EnableMouse(true)
	f:HookScript("OnHide", function(self)
		self._spellclass = nil
		for _, row in ipairs(self.Rows) do
			row:Hide()
			row._data = nil
			row._entry = nil
		end
	end)

	return f
end

function Ns:ShowQuickColor(spellclass)
	if not Ns.ConfigFrame or not spellclass then return end
	if not Ns.ConfigFrame.QuickColorPanel then
		Ns.ConfigFrame.QuickColorPanel = CreateQuickColorPanel(Ns.ConfigFrame)
	end
	local panel = Ns.ConfigFrame.QuickColorPanel
	if Ns.ConfigFrame.InfoFrame then
		Ns.ConfigFrame.InfoFrame:Hide()
	end
	if Ns.ConfigFrame.QuickBarsPanel then
		Ns.ConfigFrame.QuickBarsPanel:Hide()
	end
	-- Toggle
	if panel:IsShown() then
		panel:Hide()
		return
	end
	panel:Populate(spellclass)
	panel:Show()
end

function Ns:HideQuickColor()
	if Ns.ConfigFrame and Ns.ConfigFrame.QuickColorPanel then
		Ns.ConfigFrame.QuickColorPanel:Hide()
	end
end

------------------------------------------
--			Quick Bars Panel			--
------------------------------------------
local QUICK_BARS_PANEL_W = K.INFO_FRAME_WIDTH
local QUICK_BARS_PANEL_H = 300
local DEFAULT_BAR_COLOR = { r=0.2, g=0.6, b=0.2 }

local function CreateQuickBarsPanel(parent)
	local f = CreateFrame("Frame", nil, parent)
	f:SetSize(QUICK_BARS_PANEL_W, QUICK_BARS_PANEL_H)
	f:SetFrameStrata(parent:GetFrameStrata())
	f:SetFrameLevel(parent:GetFrameLevel() + 5)
	f:SetPoint("TOPLEFT", parent, "TOPRIGHT", 4, 0)
	f:Hide()

	f.Background = f:CreateTexture(nil, "BACKGROUND")
	f.Background:SetAllPoints()
	f.Background:SetTexture(K.INFO_FRAME_BG_TEX)
	f.Background:SetVertexColor(0.1, 0.1, 0.1, 1)

	-- Title
	f.Title = f:CreateFontString(nil, "OVERLAY")
	if K.INFO_TITLE_USE_MORPHEUS then
		local morpheus = Ns.LSM:Fetch("font", "Morpheus")
		f.Title:SetFont(morpheus or Ns.ConfigDefaultFont, K.INFO_TITLE_FONT_SIZE or 18)
	else
		f.Title:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize)
	end
	f.Title:SetPoint("TOP", 0, K.INFO_TITLE_TOP_Y)
	f.Title:SetText(L["GlobalBar_QuickBars"] or "Quick bars")
	f.Title:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)

	if K.ACTIVE_HEADER_BG_TEX ~= "" then
		f.TitleBg = f:CreateTexture(nil, "BACKGROUND", nil, 1)
		f.TitleBg:SetPoint("TOPLEFT",     f.Title, "TOPLEFT",     -K.ACTIVE_HEADER_BG_PAD_LEFT,  6)
		f.TitleBg:SetPoint("BOTTOMRIGHT", f.Title, "BOTTOMRIGHT",  K.ACTIVE_HEADER_BG_PAD_RIGHT, -6)
		f.TitleBg:SetTexture(K.ACTIVE_HEADER_BG_TEX)
		f.TitleBg:SetVertexColor(0.3, 0.3, 0.3, K.ACTIVE_HEADER_BG_A)
	end

	-- Shared settings proxy: every write is broadcast to all stats in the group.
	local shared = {}
	local settings = setmetatable({}, {
		__index = function(_, key)
			return rawget(shared, key)
		end,
		__newindex = function(_, key, value)
			rawset(shared, key, value)
			local sc = f._spellclass
			if sc then
				ForEachStatInSpellClass(sc, function(entry, data)
					data[key] = value
				end)
				Ns:QueueProfileRefresh()
			end
		end,
	})
	f.Settings = settings

	-- Enable dynamic / static bars for the whole group (prompted buttons;
	-- checkboxes were too easy to click by mistake). Removing all bars stays
	-- on the global quick bar only.
	local btnEnableDyn = MakeBarButton(f, "BtnEnableDyn", L["QuickBars_EnableDynamic"] or "Enable all dynamic bars")
	btnEnableDyn:SetPoint("TOPLEFT", 12, K.INFO_SCROLL_TOP_Y + 2)
	btnEnableDyn:SetScript("OnMouseDown", function()
		ConfirmThen(L["QuickBars_ConfirmEnableDynamic"] or "Enable dynamic bars for every stat in this group?",
			function() EnableBarsOfType(f._spellclass, "ShowBar") end)
	end)

	local btnEnableStatic = MakeBarButton(f, "BtnEnableStatic", L["QuickBars_EnableStatic"] or "Enable all static bars")
	btnEnableStatic:SetPoint("TOPLEFT", btnEnableDyn, "BOTTOMLEFT", 0, -10)
	btnEnableStatic:SetScript("OnMouseDown", function()
		ConfirmThen(L["QuickBars_ConfirmEnableStatic"] or "Enable static bars for every stat in this group?",
			function() EnableBarsOfType(f._spellclass, "StaticBar") end)
	end)

	local btnRemoveBars = MakeBarButton(f, "BtnRemoveBars", L["GlobalBar_RemoveBars"] or "Remove all bars")
	btnRemoveBars:SetPoint("TOPLEFT", btnEnableStatic, "BOTTOMLEFT", 0, -10)
	btnRemoveBars:SetScript("OnMouseDown", function()
		ConfirmThen(L["GlobalBar_ConfirmRemove"] or "Remove every bar in this group?",
			function() SetAllBarsEnabled(f._spellclass, false) end)
	end)

	-- Bar texture dropdown (LibSharedMedia statusbars)
	local drop = Ns:GetWidget("DropList", f, 9901)
	drop.MyInformation = { widget = { width = 140 } }
	drop:SetFrameStrata("DIALOG")
	drop:SetHeight(K.DROPLIST_HEIGHT)
	drop.Label:SetText(L["BarTexture"] or "Texture")
	drop.Label:SetWidth(0) -- pooled labels keep a stretched width from option pages
	drop.Label:SetTextColor(K.WIDGET_LABEL_R, K.WIDGET_LABEL_G, K.WIDGET_LABEL_B, K.WIDGET_LABEL_A)
	drop.Label:Show()
	drop.BgAtlas:ClearAllPoints()
	drop.BgAtlas:SetPoint("TOP",    drop,       "TOP",    0,  K.DROPLIST_BG_INSET_T)
	drop.BgAtlas:SetPoint("BOTTOM", drop,       "BOTTOM", 0, -K.DROPLIST_BG_INSET_B)
	drop.BgAtlas:SetPoint("LEFT",   drop.Label, "RIGHT",  K.WIDGET_LABEL_GAP - K.DROPLIST_BG_INSET_L, 0)
	drop.BgAtlas:SetPoint("RIGHT",  drop,       "RIGHT",  K.DROPLIST_BG_INSET_R, 0)
	local barTextures = {}
	local hasDefaultTex
	for _, name in ipairs(Ns.LSM:List("statusbar") or {}) do
		barTextures[#barTextures+1] = { text = name, value = name }
		if name == "Blizzard" then hasDefaultTex = true end
	end
	if not hasDefaultTex then
		tinsert(barTextures, 1, { text = "Blizzard", value = "Blizzard" })
	end
	drop.DropButton.Data = barTextures
	drop.DropButton.Settings = settings
	drop.DropButton.Key = "BarTexture"
	local labelW = ceil(drop.Label:GetStringWidth() or 0)
	drop:SetWidth(labelW + K.WIDGET_LABEL_GAP + 140)
	drop:SetPoint("TOPLEFT", btnRemoveBars, "BOTTOMLEFT", 0, -14)
	drop:Show()

	-- Bar color label + swatch
	f.ColorLabel = f:CreateFontString(nil, "OVERLAY")
	f.ColorLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.ColorLabel:SetTextColor(K.WIDGET_LABEL_R, K.WIDGET_LABEL_G, K.WIDGET_LABEL_B, K.WIDGET_LABEL_A)
	f.ColorLabel:SetText(L["BarColor"] or "Bar color")
	f.ColorLabel:SetPoint("TOPLEFT", drop, "BOTTOMLEFT", 2, -18)

	f.Swatch = CreateFrame("Button", nil, f)
	f.Swatch:SetSize(QUICK_COLOR_PAD_W, QUICK_COLOR_PAD_H)
	f.Swatch:SetPoint("LEFT", f.ColorLabel, "RIGHT", K.WIDGET_LABEL_GAP, 0)
	f.Swatch.ColorTex = f.Swatch:CreateTexture(nil, "BACKGROUND")
	f.Swatch.ColorTex:SetAllPoints()
	f.Swatch.ColorTex:SetTexture(Ns.TexturePath.."ColorPad")
	f.Swatch.Border = f.Swatch:CreateTexture(nil, "BACKGROUND", nil, 1)
	f.Swatch.Border:SetPoint("TOPLEFT", -1, 1)
	f.Swatch.Border:SetPoint("BOTTOMRIGHT", 1, -1)
	f.Swatch.Border:SetColorTexture(0, 0, 0, 0.15)

	local function ApplyBarColor(r, g, b)
		local sc = f._spellclass
		if not sc then return end
		ForEachStatInSpellClass(sc, function(entry, data)
			data.BarColor = { r=r, g=g, b=b }
		end)
		Ns:QueueProfileRefresh()
		Ns:InitialiseAllPanels()
	end

	f.Swatch:SetScript("OnClick", function(sw, button)
		local sc = f._spellclass
		if not sc then return end
		if button == "RightButton" then
			ApplyBarColor(DEFAULT_BAR_COLOR.r, DEFAULT_BAR_COLOR.g, DEFAULT_BAR_COLOR.b)
			sw.ColorTex:SetVertexColor(DEFAULT_BAR_COLOR.r, DEFAULT_BAR_COLOR.g, DEFAULT_BAR_COLOR.b)
			return
		end
		local c
		ForEachStatInSpellClass(sc, function(entry, data)
			if not c and data.BarColor then c = data.BarColor end
		end)
		c = c or DEFAULT_BAR_COLOR

		local function OnColorChange()
			local r1, g1, b1 = ColorPickerFrame:GetColorRGB()
			sw.ColorTex:SetVertexColor(r1, g1, b1)
			ApplyBarColor(r1, g1, b1)
		end

		local function OnColorCancel()
			local prev = ColorPickerFrame.previousValues
			if prev then
				sw.ColorTex:SetVertexColor(prev.r, prev.g, prev.b)
				ApplyBarColor(prev.r, prev.g, prev.b)
			else
				Ns:QueueProfileRefresh()
			end
		end

		ColorPickerFrame.previousValues = { r=c.r, g=c.g, b=c.b }
		if ColorPickerFrame.SetupColorPickerAndShow then
			local info = UIDropDownMenu_CreateInfo()
			info.r, info.g, info.b = c.r, c.g, c.b
			info.swatchFunc = OnColorChange
			info.cancelFunc = OnColorCancel
			ColorPickerFrame:SetupColorPickerAndShow(info)
			if ColorPickerFrame.Content then
				ColorPickerFrame.Content.ColorPicker:SetColorRGB(c.r, c.g, c.b)
			else
				ColorPickerFrame:SetColorRGB(c.r, c.g, c.b)
			end
		else
			ColorPickerFrame.func = OnColorChange
			ColorPickerFrame.cancelFunc = OnColorCancel
			ColorPickerFrame.hasOpacity = false
			ColorPickerFrame:SetColorRGB(c.r, c.g, c.b)
			ColorPickerFrame:Show()
		end
	end)

	-- Bar height slider (0 = auto fill, otherwise pixels)
	local sw = Ns:GetWidget("Slider", f, 9902)
	sw.MyInformation = { widget = { min=0, max=100, valuestep=1, width=145 } }
	sw.Label:SetText(L["BarHeight"] or "Bar height")
	sw.Label:SetWidth(0) -- pooled labels keep a stretched width from option pages
	sw.Label:SetTextColor(K.WIDGET_LABEL_R, K.WIDGET_LABEL_G, K.WIDGET_LABEL_B, K.WIDGET_LABEL_A)
	sw.Label:Show()
	sw:SetPoint("TOPLEFT", f.ColorLabel, "BOTTOMLEFT", -2, -26)
	local s = sw.Slider
	s.Settings = settings
	s.Key = "BarHeight"
	s:SetMinMaxValues(0, 100)
	s:SetValueStep(1)
	s:SetWidth(145)
	s.Min:SetText("0")
	s.Max:SetText("100")
	local swLabelW = ceil(sw.Label:GetStringWidth() or 0)
	sw:SetWidth(swLabelW + K.WIDGET_LABEL_GAP + 145)
	sw:Show()

	function f:Populate(spellclass)
		self._spellclass = spellclass

		local tex, col, hgt
		ForEachStatInSpellClass(spellclass, function(entry, data)
			if not tex and data.BarTexture then tex = data.BarTexture end
			if not col and data.BarColor then col = data.BarColor end
			if not hgt and data.BarHeight then hgt = data.BarHeight end
		end)
		tex = tex or "Blizzard"
		col = col or DEFAULT_BAR_COLOR
		hgt = hgt or 0

		-- seed the shared values so control updates don't re-write all stats
		rawset(shared, "BarTexture", tex)
		rawset(shared, "BarHeight", hgt)

		drop:SetText(tex)
		f.Swatch.ColorTex:SetVertexColor(col.r, col.g, col.b)
		s:SetValue(hgt)
		s.Edit:SetValue(hgt)
	end

	f:EnableMouse(true)
	f:HookScript("OnHide", function(self)
		self._spellclass = nil
	end)

	return f
end

function Ns:ShowQuickBars(spellclass)
	if not Ns.ConfigFrame or not spellclass then return end
	if not Ns.ConfigFrame.QuickBarsPanel then
		Ns.ConfigFrame.QuickBarsPanel = CreateQuickBarsPanel(Ns.ConfigFrame)
	end
	local panel = Ns.ConfigFrame.QuickBarsPanel
	if Ns.ConfigFrame.InfoFrame then
		Ns.ConfigFrame.InfoFrame:Hide()
	end
	if Ns.ConfigFrame.QuickColorPanel then
		Ns.ConfigFrame.QuickColorPanel:Hide()
	end
	-- Toggle
	if panel:IsShown() then
		panel:Hide()
		return
	end
	panel:Populate(spellclass)
	panel:Show()
end

function Ns:HideQuickBars()
	if Ns.ConfigFrame and Ns.ConfigFrame.QuickBarsPanel then
		Ns.ConfigFrame.QuickBarsPanel:Hide()
	end
end

function Ns:ShowStatInfo(rawText, btn)
	if not rawText or string.trim(rawText) == "" then return end
	if not Ns.ConfigFrame then return end

	if Ns.ConfigFrame.QuickColorPanel then
		Ns.ConfigFrame.QuickColorPanel:Hide()
	end
	if Ns.ConfigFrame.QuickBarsPanel then
		Ns.ConfigFrame.QuickBarsPanel:Hide()
	end
	if not Ns.ConfigFrame.InfoFrame then
		Ns.ConfigFrame.InfoFrame = CreateInfoFrame(Ns.ConfigFrame)
	end
	local frame = Ns.ConfigFrame.InfoFrame

	if frame:IsShown() and frame._activeBtn == btn then
		frame:Hide() -- OnHide reverts btn tint
		return
	end

	if frame._activeBtn and frame._activeBtn ~= btn then
		frame._activeBtn._infoOpen = nil
		if frame._activeBtn.Texture then
			frame._activeBtn.Texture:SetVertexColor(1, 1, 1, 1)
		end
	end
	frame._activeBtn = btn
	if btn then
		btn._infoOpen = true
		if btn.Texture then

			local g = Ns.ColorsRGB and Ns.ColorsRGB.Green
			if g then
				btn.Texture:SetVertexColor(0.769, 0.118, 0.227, 1)
			else
				btn.Texture:SetVertexColor(0.769, 0.118, 0.227, 1)
			end
		end
	end
	frame._lastText = rawText
	frame:SetContent(rawText)
	frame:Show()
end

function Ns:HideStatInfo()
	if Ns.ConfigFrame and Ns.ConfigFrame.InfoFrame then
		Ns.ConfigFrame.InfoFrame:Hide()
	end
end

function Ns:ToggleConfig()
	if not Ns.ConfigFrame then
		InitConfig()
	end
	Ns.ConfigFrame:SetShown(not Ns.ConfigFrame :IsShown())
end