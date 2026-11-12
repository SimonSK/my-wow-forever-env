local AddName, Ns = ...
local L = Ns.L
local K = Ns.K

local newTicker, rowWidget
local gttFont, gttFontSize, gttFontFlags
local settingsOffsetY, dropListRowHeight = -15, 18

local checkBoxHeight, radioSize, defaultLabelOsW, MainMenuButtonHeight = 30, 14, 40, 21
Ns.TopTabHeight = 21

local function SetButtonBgRest(button, r, g, b, a)
	local bg = button and button.BgTexture
	if not bg then return end
	bg.restR, bg.restG, bg.restB, bg.restA = r, g, b, a or 1
	bg:SetVertexColor(r, g, b, a or 1)
end
local function RestoreButtonBgRest(button)
	local bg = button and button.BgTexture
	if not bg then return end
	bg:SetVertexColor(bg.restR or 1, bg.restG or 1, bg.restB or 1, bg.restA or 1)
end
local topTabColor = { r=0.298, g=0.298, b=0.298, a=0}
local greenColor = { r=0.443, g=1, b=0.788 }
local redColor = { r=1, g=0, b=0.658 }
local orangeColor = { r=1, g=0.741, b=0.313 }

local anchorLableHeight = 10

Ns.WidgetDisplayFormat = "%s %s"

local opPoints = {
	LEFT = { point="RIGHT", x=-5, y=0, use="x", },
	RIGHT = { point="LEFT", x=5, y=0, use="x" },
	CENTER = { point="CENTER", use="xy" },
}

local TooltipOffsets = {
	Default = { point="RIGHT", topoint="LEFT", x=100, y=24 },
	CheckBox = { point="LEFT", topoint="RIGHT", x=-2, y=4 },
    EditBox = { point="LEFT", topoint="RIGHT", x=6, y=1 },
	Slider = { point="LEFT", topoint="RIGHT", x=-55, y=16 },
}

local Mixins, WidgetPool = { scripts={}, functions={} }, {}
local ApplyIconTextButtonStyle

local W = {}
Ns.W = W
Ns.Mixins = Mixins

local function ColorBorders(self, r, g, b, a)
    if Ns.PP and self._PPBorder then
        Ns.PP.SetBorderColor(self, r, g, b, a and a or 1)
    elseif self.Borders then
        for i = 1, 4 do
            self.Borders[i]:SetColorTexture(r, g, b, a and a or 1)
        end
    end
end
Ns.ColorBorders = ColorBorders

local function CreateBorder(frame, size)
    frame.SetBorderColor = frame.SetBorderColor or ColorBorders
    if Ns.PP then
        Ns.PP.CreateBorder(frame, 0, 0, 0, 1, size or 1)
    else
        local scale  = frame:GetEffectiveScale()
        local t      = (1 / scale) * (size or 1)
        local offset = t / 2
        frame.Borders = frame.Borders or {}
        for i = 1, 4 do
            if not frame.Borders[i] then
                frame.Borders[i] = frame:CreateLine(nil, "BORDER", nil, 0)
            end
            local b = frame.Borders[i]
            b:SetThickness(t)
            b:SetColorTexture(0, 0, 0, 1)
            if i == 1 then
                b:SetStartPoint("TOPLEFT",     -offset, 0); b:SetEndPoint("TOPRIGHT",     offset,  0)
            elseif i == 2 then
                b:SetStartPoint("TOPRIGHT",    0,  offset); b:SetEndPoint("BOTTOMRIGHT",  0,      -offset)
            elseif i == 3 then
                b:SetStartPoint("BOTTOMRIGHT", offset, 0);  b:SetEndPoint("BOTTOMLEFT",  -offset,  0)
            else
                b:SetStartPoint("BOTTOMLEFT",  0, -offset); b:SetEndPoint("TOPLEFT",      0,        offset)
            end
        end
    end
end
Ns.CreateBorder = CreateBorder

local WidgetBG = {
	bgFile="Interface/BUTTONS/WHITE8X8",
	--edgeFile="Interface/Tooltips/UI-Tooltip-Border",
	tile=false,
	edgeSize=3,
	tileSize=0,
	insets={ left=1, right=1, top=1, bottom=1, },
}

local EditBoxBG = {
	bgFile="Interface/BUTTONS/WHITE8X8",
	--edgeFile="Interface/BUTTONS/WHITE8X8",
	tile=false,
	edgeSize=1,
	tileSize=0,
	insets={ left=1, right=1, top=1, bottom=1 },
}

local RadioBG = {
	bgFile="Interface/BUTTONS/WHITE8X8",
	--edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
	tile=false,
	edgeSize=1,
	tileSize=0,
	insets={ left=1, right=4, top=1, bottom=9, },
}

-- local PlainButtonBG = {
-- 	bgFile="Interface/BUTTONS/WHITE8X8",
-- 	edgeFile="Interface/Tooltips/UI-Tooltip-Border",
-- 	tile=false,
-- 	edgeSize=8,
-- 	tileSize=0,
-- 	insets={ left=2, right=2, top=2, bottom=2 },
-- }

local SliderBG = {
	bgFile="Interface/BUTTONS/WHITE8X8",
	--edgeFile="Interface/Tooltips/UI-Tooltip-Border",
	tile=false,
	edgeSize=4,
	tileSize=0,
	insets={ left=1, right=1, top=1, bottom=1, },
}

local DragBG = {
	bgFile="Interface/BUTTONS/WHITE8X8",
	edgeFile="Interface/Tooltips/UI-Tooltip-Border",
	tile=false,
	edgeSize=7,
	tileSize=0,
	insets={ left=0, right=0, top=0, bottom=0, },
}

----------------------------------
--			Fonts Init			--
----------------------------------
local LSM = LibStub("LibSharedMedia-3.0")
Ns.LSM = LSM
LSM:Register("font", "Accidental Presidency", [[Interface\Addons\SinStats\fonts\Accidental Presidency.ttf]])
LSM:Register("font", "Oswald", [[Interface\Addons\SinStats\fonts\Oswald-Regular.otf]])
LSM:Register("font", "FORCED SQUARE", [[Interface\Addons\SinStats\fonts\FORCED SQUARE.ttf]])
LSM:Register("font", "Bazooka", [[Interface\Addons\SinStats\fonts\Bazooka.ttf]])
LSM:Register("font", "DorisPP", [[Interface\Addons\SinStats\fonts\DORISPP.ttf]])
LSM:Register("font", "Enigmatic", [[Interface\Addons\SinStats\fonts\Enigma__2.ttf]])
LSM:Register("font", "White Rabbit", [[Interface\Addons\SinStats\fonts\WHITRABT.ttf]])
LSM:Register("font", "Monofonto", [[Interface\Addons\SinStats\fonts\MONOFONT.ttf]])
LSM:Register("font", "DM Sans", [[Interface\Addons\SinStats\fonts\DMSans-Regular.ttf]])
LSM:Register("font", "DM Sans Medium", [[Interface\Addons\SinStats\fonts\DMSans-Medium.ttf]])
LSM:Register("font", "DM Sans Semi Bold", [[Interface\Addons\SinStats\fonts\DMSans-SemiBold.ttf]])
LSM:Register("font", "AlbertSans", [[Interface\Addons\SinStats\fonts\AlbertSans-Regular.ttf]])
LSM:Register("font", "AlbertSans Medium", [[Interface\Addons\SinStats\fonts\AlbertSans-Medium.ttf]])
LSM:Register("font", "AlbertSans Semi Bold", [[Interface\Addons\SinStats\fonts\AlbertSans-SemiBold.ttf]])
LSM:Register("font", "Rethink", [[Interface\Addons\SinStats\fonts\RethinkSans-Regular.ttf]])
LSM:Register("font", "Rethink Medium", [[Interface\Addons\SinStats\fonts\RethinkSans-Medium.ttf]])
LSM:Register("font", "Rethink Semi Bold", [[Interface\Addons\SinStats\fonts\RethinkSans-SemiBold.ttf]])
LSM:Register("font", "Outfit", [[Interface\Addons\SinStats\fonts\Outfit-Regular.ttf]])
LSM:Register("font", "Outfit Medium", [[Interface\Addons\SinStats\fonts\Outfit-Medium.ttf]])
LSM:Register("font", "Outfit Semi Bold", [[Interface\Addons\SinStats\fonts\Outfit-SemiBold.ttf]])


Ns.ConfigDefaultFont = Ns.LSM:Fetch("font", "Rethink Medium")
Ns.ConfigDefaultFont2 = Ns.LSM:Fetch("font", "Rethink Semi Bold")

if GetLocale() == 'zhCN' or GetLocale() == 'zhTW' or GetLocale() == 'koKR' then
    Ns.ConfigDefaultFont = Ns.LSM:Fetch("font", Ns.LSM:GetDefault("font"))
	Ns.ConfigDefaultFont2 = Ns.LSM:Fetch("font", Ns.LSM:GetDefault("font"))
end

----------------------------------------------
--			Droplist Source Tables			--
----------------------------------------------
local ListData = {}
ListData.FontFlags = {
	{ text=L["None"], value="" },
	{ text=L["Thin"], value="OUTLINE", },
	{ text=L["Thick"], value="THICKOUTLINE" },
	{ text=L["Monochrome"], value="MONOCHROME" },
	{ text=L["Thin Monochrome"], value="OUTLINE, MONOCHROME" },
	{ text=L["Thick Monochrome"], value="THICKOUTLINE, MONOCHROME" },
}
ListData.TextDataSeparator = {
	{ text=L[":"], value=":", },
	{ text=L["-"], value=" -", },
	{ text=L["|"], value=" | ", },
	{ text=L["/"], value=" /", },
	{ text=L[">"], value=" >", },
	{ text=L["<"], value=" <", },
	{ text=L["None"], value="", },
}
ListData.Alignments = {
	{ text=L["Left"], value="TOPLEFT", },
	{ text=L["Right"], value="TOPRIGHT", },
	{ text=L["Center"], value="TOP", },
}
ListData.IconAlignments = {
	{ text=L["Left"], value="TOPLEFT", },
	{ text=L["Right"], value="TOPRIGHT", },
}
ListData.GrowDirections = {
	{ text=L["Top to Bottom"], value="DOWN", },
	{ text=L["Bottom to Top"], value="UP", },
}
ListData.Rows = {
	{ text=1, value=1, },
	{ text=2, value=2, },
	{ text=3, value=3, },
	{ text=4, value=4, },
	{ text=5, value=5, },
}
ListData.Strata = {
	{ text=L["Lowest"], value="BACKGROUND", },
	{ text=L["Low"], value="LOW", },
	{ text=L["Medium"], value="MEDIUM", },
	{ text=L["High"], value="HIGH", },
	{ text=L["Highest"], value="TOOLTIP", },
}

ListData.Decimals = {
	{ text=0, value=0, },
	{ text=1, value=1, },
	{ text=2, value=2, },
	{ text=3, value=3, },
}

ListData.Fonts = {}
for k, v in ipairs(Ns.LSM:List("font")) do
	tinsert(ListData.Fonts, { text=v, value=v, })
end

ListData.BarTextures = {}
for k, v in ipairs(Ns.LSM:List("statusbar")) do
	tinsert(ListData.BarTextures, { text=v, value=v, })
end

ListData.BorderTextures = {}
for k, v in ipairs(Ns.LSM:List("border")) do
	tinsert(ListData.BorderTextures, { text=v, value=v, })
end

ListData.BarMaxMode = {
	{ text=L["BarMaxCap"], value=1, },
	{ text=L["Custom"], value=2, },
}

ListData.BarCustomMode = {
	{ text=L["Custom"], value=1, },
}

ListData.JourneyBarMode = {
	{ text=L["NextRank"], value=1, },
	{ text=L["MaxRank"], value=2, },
}

ListData.SpeedBar = {
	{ text=L["Auto"], value=1, },
	{ text=L["Steady Flying"], value=2, },
	{ text=L["Skyriding"], value=3, },
	{ text=L["On Foot"], value=4, },
	{ text=L["Custom"], value=5, },
	{ text=L["Mounted"], value=6, },
}

ListData.TimerFormat = {
	{ text="0:00", value=1, },
	{ text="00:00", value=2, },
	{ text="0m 00s", value=3, },
	{ text="0m00s", value=4, },
}

ListData.Profiles = {}
local function UpdateProfiles()
	wipe(ListData.Profiles)
	for k, v in pairs(SinStatsDB.profiles) do
		tinsert(ListData.Profiles, { text=k, value=k })
	end
	sort(ListData.Profiles, function(a, b)
		return a.text < b.text
	end)
end

ListData.Panels = {}
local function UpdatePanels()
	wipe(ListData.Panels)
	if Ns.ProfileRoot and Ns.ProfileRoot.PanelOrder then
		for _, pName in ipairs(Ns.ProfileRoot.PanelOrder) do
			tinsert(ListData.Panels, { text = pName, value = pName })
		end
	end
end

--------------------------------------
--			Local Functions			--
--------------------------------------
local TipFormat = "%s"
local function AdjustCheckTip(self, text)
--	self:SetWidth(self:GetWidth() + self.Label:GetWidth())
	self.Tip:SetText(format(TipFormat, L[text.."Tip"]))
	self.Tip:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
end

local function AdjustTopTabText(self, text)
	self:SetWidth(self.Label:GetWidth() + defaultLabelOsW)
end

local function AddTipText(self)
	self.Tip = self:CreateFontString(nil, "OVERLAY")
	self.Tip:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, Ns.TooltipYOffset) -- CHECKBOX TIP TEXT
	self.Tip:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize -4) -- TIP TEXT SIZE
	self.Tip:SetJustifyH("LEFT")
	self.Tip:SetJustifyV("TOP")
end

local function AddLabel(self)
	self.Label = self:CreateFontString(nil, "OVERLAY")
	Mixin(self.Label, Mixins.functions.Labels)
	Mixin(self, Mixins.functions.HasFontString)
	self:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize -4)
end

local function AnchorWidget(self, location, x, y, notrelative) -- location = where the lab el will be located in relation to the parent
	location = strupper(location)
	local anchor = (notrelative and location) or opPoints[location] or location  -- because the anchor point will actually be the opposite of the location (topoint)
	self:ClearAllPoints()
	self:SetPoint(anchor.point or location, self:GetParent(), location, x or anchor.x, y or anchor.y)
end

local function CancelTicker(self, leaveshown)
	self:Cancel()
	if not leaveshown then
		rowWidget:Hide()
	end
	rowWidget = nil
	newTicker = nil
end

local function GetLabelText(text, myinformation, noicons)
	if noicons then
		return strtrim(L[text])
	else
		return format(Ns.WidgetDisplayFormat, Ns:GetSpellIcon(myinformation), strtrim(L[text]))
	end
end

local function KillPage(page)
	if Ns.ConfigFrame[page] then
		Ns:KillWidget(Ns.ConfigFrame[page])
		Ns.ConfigFrame[page] = nil
	end
	if page == "MainAnchor" and Ns.ConfigFrame.StatHeaderBg then
		Ns.ConfigFrame.StatHeaderBg:Hide()
	end
end

local function OnEnterFunc(self)
	if newTicker then
		if rowWidget and rowWidget == self.List then
			CancelTicker(newTicker, true)
		else
			CancelTicker(newTicker)
		end
	end
end

local function OnLeaveFunc(self)
	if not self:IsMouseOver() and not self.List:IsMouseOver() and self.List:IsShown() and not self.List.ThumbDragging then
		rowWidget = self.List
		if newTicker then
			CancelTicker(newTicker)
		end
		newTicker = C_Timer.NewTicker(1, CancelTicker)
	end
end

local function PlayOnTab()
	PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN, "Ambience")
end

local function PlayOnCheck()
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON, "Ambience")
end

local function SetAnchorText(self, text, anchorcenter)
	if #self.CurrentWidgets == 0 or strtrim(text) == "" then
		return
	end
	self:SetAnchor()
end

function Ns.InitCustomColors(self, stat, settings, myinformation)
	if self:GetChecked() then
		if not settings.ColorName then
			settings.ColorName = {}
			if Ns.Profile.StatTextColor then
				Ns.CopyTable(Ns.Profile.StatTextColor, settings.ColorName)
			else
				Ns.CopyTable(myinformation.ColorName.default, settings.ColorName)
			end
			settings.ColorValue = {}
			if Ns.Profile.DataColor then
				Ns.CopyTable(Ns.Profile.DataColor, settings.ColorValue)
			else
				Ns.CopyTable(myinformation.ColorValue.default, settings.ColorValue)
			end
			local parent = self:GetParent():GetParent()
			if not parent.CurrentWidgets then
				parent = self:GetParent():GetParent():GetParent():GetParent()
			end
			for k, v in pairs(parent.CurrentWidgets) do
				if v.MyInformation and (v.MyInformation.stat == "ColorName" or  v.MyInformation.stat == "ColorValue") then
					v:ColorInit()
				end
			end
		end
	end
end

function Ns.InitValueColor(self, key, settings, myinformation)
	if self:GetChecked() and not settings.ColorValue then
		settings.ColorValue = {}
		if Ns.Profile and Ns.Profile.DataColor then
			Ns.CopyTable(Ns.Profile.DataColor, settings.ColorValue)
		elseif myinformation and myinformation.ColorValue and myinformation.ColorValue.default then
			Ns.CopyTable(myinformation.ColorValue.default, settings.ColorValue)
		else
			settings.ColorValue = { r = 1, g = 1, b = 1 }
		end
	end
end

function Ns.OnBarMaxModeChange(self, key, settings, myinformation)
	local anchor = self.AnchorFrame
	if not anchor or not anchor.CurrentWidgets then return end
	local isCustom = settings[key] == 2
	for k, v in ipairs(anchor.CurrentWidgets) do
		if v.MyInformation and v.MyInformation.stat == "BarMaxCustom" then
			v:SetEnabled(isCustom)
			break
		end
	end
end

--------------------------------------
--			Label Functions			--
--------------------------------------
Mixins.functions.Labels = {}

function Mixins.functions.Labels.Anchor(self, location, x, y, notrelative)
	AnchorWidget(self, location, x, y, notrelative)
end

------------------------------------------
--	Parents with Label Functions		--
------------------------------------------
Mixins.functions.HasFontString = {}
function Mixins.functions.HasFontString.AnchorLabel(self, location, x, y, notrelative)
	AnchorWidget(self.Label, location, x, y, notrelative)
end

function Mixins.functions.HasFontString.GetLabel(self)
	return self.Label:GetText()
end

function Mixins.functions.HasFontString.GetLabelHeight(self)
	return math.ceil(self.Label:GetHeight())
end

function Mixins.functions.HasFontString.SetFont(self, font, size, flags)
	local text = self.Label
	local setFont = font or Ns.ConfigDefaultFont
	local setSize = size or Ns.ConfigDefaultFontSize
	text:SetFont(setFont, setSize)
end

function Mixins.functions.HasFontString.SetFontSize(self, size)
	local f, s = self.Label:GetFont()
	if not f then
		self.Label:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize -4, "")
		f = Ns.ConfigDefaultFont
	end
	self.Label:SetFont(f, size)
end

function Mixins.functions.HasFontString.SetJustifyH(self, justify)
	self.Label:SetJustifyH(justify)
end

function Mixins.functions.HasFontString.SetJustifyV(self, justify)
	self.Label:SetJustifyV(justify)
end

function Mixins.functions.HasFontString.SetTextColor(self, r, g, b, a)
	self.Label:SetTextColor(r, g, b, a)
end

function Mixins.functions.HasFontString.SetLabel(self, text)
	self.Label:SetText(text)
end

------------------------------------------
--			Widgets and Mixins			--
------------------------------------------
function W.AnchorScroll(parent)
	local f = CreateFrame("ScrollFrame", nil, parent)
	f:SetClipsChildren(true)

	f.ScrollChild = CreateFrame("Frame", nil, f)
	f.ScrollChild:SetSize(180, 500)
	f.ScrollChild:SetPoint("TOPLEFT", f)
	f:SetScrollChild(f.ScrollChild)

	local arrowSize = 11 -- width and height of arrow buttons
	local scrollStep = 40
	local arrowXOffset = 14
	local thumbXOffset = 0

	local function CreateArrowButton(parentFrame, texture)
		local btn = CreateFrame("Button", nil, parentFrame)
		btn:SetSize(arrowSize, arrowSize)
		btn.Icon = btn:CreateTexture(nil, "ARTWORK")
		btn.Icon:SetAllPoints()
		btn.Icon:SetTexture(Ns.TexturePath .. texture)
		btn.Icon:SetDesaturated(true)
		btn.Icon:SetVertexColor(orangeColor.r, orangeColor.g, orangeColor.b, 0.7)
		btn:SetScript("OnEnter", function(self) self.Icon:SetVertexColor(orangeColor.r, orangeColor.g, orangeColor.b, 1) end)
		btn:SetScript("OnLeave", function(self) self.Icon:SetVertexColor(orangeColor.r, orangeColor.g, orangeColor.b, 0.7) end)
		return btn
	end

	-- Up arrow
	local upBtn = CreateArrowButton(parent, "ArrowUp")
	upBtn:SetPoint("TOPRIGHT", f, "TOPRIGHT", arrowXOffset, 0)
	upBtn:Hide()
	f.UpArrow = upBtn

	-- Down arrow
	local downBtn = CreateArrowButton(parent, "ArrowDown")
	downBtn:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", arrowXOffset, 0)
	downBtn:Hide()
	f.DownArrow = downBtn

	-- scrollbar
	local bar = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
	bar:SetWidth(8)
	bar:SetPoint("TOP", upBtn, "BOTTOM", thumbXOffset, -1)
	bar:SetPoint("BOTTOM", downBtn, "TOP", thumbXOffset, 1)
	bar:SetBackdrop({bgFile = "Interface/BUTTONS/WHITE8X8"})
	bar:SetBackdropColor(0.1, 0.1, 0.1, 0.4)
	bar:Hide()
	f.ScrollBar = bar

	local capH = 4
	local thumb = CreateFrame("Frame", nil, bar)
	thumb:SetWidth(8)
	local topCap = thumb:CreateTexture(nil, "ARTWORK")
	topCap:SetPoint("TOPLEFT")
	topCap:SetPoint("TOPRIGHT")
	topCap:SetHeight(capH)
	topCap:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask")
	topCap:SetTexCoord(0, 1, 0, 0.5)
	topCap:SetVertexColor(0.388, 0.380, 0.388, 1)
	local midTex = thumb:CreateTexture(nil, "ARTWORK")
	midTex:SetPoint("TOPLEFT", thumb, "TOPLEFT", thumbXOffset, -capH)
	midTex:SetPoint("BOTTOMRIGHT", thumb, "BOTTOMRIGHT", thumbXOffset, capH)
	midTex:SetTexture("Interface/AddOns/SinStats/Textures/Scrollbar")
	midTex:SetVertexColor(1, 1, 1, 0.5)
	local botCap = thumb:CreateTexture(nil, "ARTWORK")
	botCap:SetPoint("BOTTOMLEFT")
	botCap:SetPoint("BOTTOMRIGHT")
	botCap:SetHeight(capH)
	botCap:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask")
	botCap:SetTexCoord(0, 1, 0.5, 1)
	botCap:SetVertexColor(1, 1, 1, 0.5)
	thumb:SetPoint("TOP", 0, 0)
	thumb:SetHeight(20)
	thumb:EnableMouse(true)
	bar.Thumb = thumb

	local function UpdateScrollBar()
		local range = f:GetVerticalScrollRange()
		if range <= 0 then
			bar:Hide()
			upBtn:Hide()
			downBtn:Hide()
			return
		end
		bar:Show()
		upBtn:Show()
		downBtn:Show()
		local trackH = bar:GetHeight()
		local ratio = f:GetHeight() / (f:GetHeight() + range)
		local thumbH = math.max(20, trackH * ratio)
		thumb:SetHeight(thumbH)
		local travel = trackH - thumbH
		local scrollPos = f:GetVerticalScroll()
		local offset = travel > 0 and (scrollPos / range) * travel or 0
		thumb:SetPoint("TOP", 0, -offset)
	end
	f.UpdateScrollBar = UpdateScrollBar

	-- Mouse wheel scrolling
	f:EnableMouseWheel(true)
	f:SetScript("OnMouseWheel", function(self, delta)
		local range = self:GetVerticalScrollRange()
		if range <= 0 then return end
		local current = self:GetVerticalScroll()
		local newScroll = math.max(0, math.min(range, current - delta * scrollStep))
		local sfScale = self:GetEffectiveScale()
		newScroll = math.floor(newScroll * sfScale + 0.5) / sfScale
		self:SetVerticalScroll(newScroll)
		UpdateScrollBar()
		if Ns.PP then Ns.PP.ResnapAllBorders() end
	end)

	f:SetScript("OnScrollRangeChanged", function()
		UpdateScrollBar()
	end)

	upBtn:SetScript("OnClick", function()
		local range = f:GetVerticalScrollRange()
		if range <= 0 then return end
		local sfScale = f:GetEffectiveScale()
		local newScroll = math.floor(math.max(0, f:GetVerticalScroll() - scrollStep) * sfScale + 0.5) / sfScale
		f:SetVerticalScroll(newScroll)
		UpdateScrollBar()
		if Ns.PP then Ns.PP.ResnapAllBorders() end
	end)
	downBtn:SetScript("OnClick", function()
		local range = f:GetVerticalScrollRange()
		if range <= 0 then return end
		local sfScale = f:GetEffectiveScale()
		local newScroll = math.floor(math.min(range, f:GetVerticalScroll() + scrollStep) * sfScale + 0.5) / sfScale
		f:SetVerticalScroll(newScroll)
		UpdateScrollBar()
		if Ns.PP then Ns.PP.ResnapAllBorders() end
	end)

	local function ThumbOnUpdate(self)
		local _, cursorY = GetCursorPosition()
		local scale = self:GetEffectiveScale()
		cursorY = cursorY / scale
		local deltaY = f.DragStartY - cursorY
		local trackH = bar:GetHeight()
		local thumbH = self:GetHeight()
		local travel = trackH - thumbH
		local range = f:GetVerticalScrollRange()
		if travel <= 0 or range <= 0 then return end
		local scrollDelta = deltaY * (range / travel)
		local newScroll = math.max(0, math.min(range, (f.DragStartScroll or 0) + scrollDelta))
		local sfScale = f:GetEffectiveScale()
		newScroll = math.floor(newScroll * sfScale + 0.5) / sfScale
		f:SetVerticalScroll(newScroll)
		UpdateScrollBar()
		if Ns.PP then Ns.PP.ResnapAllBorders() end
	end
	thumb:SetScript("OnMouseDown", function(self, button)
		if button ~= "LeftButton" then return end
		local _, cursorY = GetCursorPosition()
		local scale = self:GetEffectiveScale()
		f.DragStartY = cursorY / scale
		f.DragStartScroll = f:GetVerticalScroll()
		self:SetScript("OnUpdate", ThumbOnUpdate)
	end)
	thumb:SetScript("OnMouseUp", function(self, button)
		if button ~= "LeftButton" then return end
		self:SetScript("OnUpdate", nil)
	end)

	bar:EnableMouse(true)
	bar:SetScript("OnMouseDown", function(self, button)
		if button ~= "LeftButton" then return end
		local range = f:GetVerticalScrollRange()
		if range <= 0 then return end
		local _, cursorY = GetCursorPosition()
		local scale = self:GetEffectiveScale()
		cursorY = cursorY / scale
		local thumbCenter = select(2, thumb:GetCenter())
		local pageStep = 150
		local sfScale = f:GetEffectiveScale()
		local rawScroll
		if cursorY < thumbCenter then
			rawScroll = math.min(range, f:GetVerticalScroll() + pageStep)
		else
			rawScroll = math.max(0, f:GetVerticalScroll() - pageStep)
		end
		f:SetVerticalScroll(math.floor(rawScroll * sfScale + 0.5) / sfScale)
		UpdateScrollBar()
		if Ns.PP then Ns.PP.ResnapAllBorders() end
	end)

	return f
end

--------------------------------------
--			Anchor Frame			--
--------------------------------------
function W.AnchorFrame(parent)
	local f = CreateFrame("Frame", nil, parent)
	f:SetSize(5, 5)
	f.SpecialType = "AnchorFrame"
	f:SetFrameStrata("HIGH")
	local borderOffset = Ns.maxOptionsWidth / 2.5

	f.HeaderIcon = f:CreateTexture(nil, "ARTWORK")
	f.HeaderIcon:SetSize(18, 18)
	f.HeaderIcon:Hide()

	-- Decorative button texture behind the header label+icon (shown by Expand()).
	f.HeaderButton = f:CreateTexture(nil, "BACKGROUND", nil, 0)
	f.HeaderButton:Hide()

	AddLabel(f)
	--f:AnchorLabel("TOP", 0, 0, true)  -- tracks TOP_SEPARATOR_Y so header moves with separator
	f:AnchorLabel("TOP", 0, K.TOP_SEPARATOR_Y+30, true)  -- tracks TOP_SEPARATOR_Y so header moves with separator
	if K.STAT_HEADER_USE_MORPHEUS then
		local morpheus = Ns.LSM:Fetch("font", "Morpheus")
		if morpheus then
			f.Label:SetFont(morpheus, K.STAT_HEADER_FONT_SIZE)
		else
			f.Label:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize + anchorLableHeight)
		end
	else
		f.Label:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize + anchorLableHeight)
	end
	f.Label:SetJustifyH("CENTER")

	f.Description = f:CreateFontString()
	if K.STAT_DESC_USE_MORPHEUS then
		local morpheus = Ns.LSM:Fetch("font", "Morpheus")
		f.Description:SetFont(morpheus or Ns.ConfigDefaultFont, K.STAT_DESC_FONT_SIZE)
	else
		f.Description:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize -3)
	end
	f.Description:SetPoint("TOP", f.Label, "BOTTOM", K.STAT_DESC_X_OFFSET, -5)
	f.Description:SetJustifyH(K.STAT_DESC_JUSTIFY or "LEFT")
	f.Description:SetTextColor(K.STAT_DESC_R, K.STAT_DESC_G, K.STAT_DESC_B, K.STAT_DESC_A)
	f.Description:SetWidth(Ns.maxOptionsWidth - (borderOffset / 2))

	f.CurrentWidgets = {}
	Mixin(f, Mixins.functions.AnchorFrames)
	hooksecurefunc(f, "SetLabel", SetAnchorText)

	return f
end

Mixins.functions.AnchorFrames = {}
function Mixins.functions.AnchorFrames.AddWidget(self, widget, parent)
	widget:SetParent(parent or self)
	tinsert(self.CurrentWidgets, widget)
end

function Mixins.functions.AnchorFrames.Reset(self)
	self.ActiveWidget = nil
	self.CenterAlign = nil
	self:SetLabel("")
	if self.HeaderIcon then
		self.HeaderIcon:Hide()
		self.HeaderIcon:SetTexture(nil)
	end
	if self.HeaderButton then
		self.HeaderButton:Hide()
	end
	if K.STAT_DESC_USE_MORPHEUS then
		local morpheus = Ns.LSM:Fetch("font", "Morpheus")
		self.Description:SetFont(morpheus or Ns.ConfigDefaultFont2, K.STAT_DESC_FONT_SIZE)
	else
		self.Description:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize -3)
	end
	self.Description:SetJustifyH(K.STAT_DESC_JUSTIFY or "LEFT")
	self.Description:SetTextColor(K.STAT_DESC_R, K.STAT_DESC_G, K.STAT_DESC_B, K.STAT_DESC_A)
	for k = 1, #self.CurrentWidgets do
		Ns:KillWidget(self.CurrentWidgets[k])
	end
	wipe(self.CurrentWidgets)
	if self.TopSeparator then
		Ns:KillWidget(self.TopSeparator)
		self.TopSeparator = nil
	end
	if self.BottomSeparator then
		Ns:KillWidget(self.BottomSeparator)
		self.BottomSeparator = nil
	end
	-- Tips and Info side panel is per-stat.. hide it whenever options reset.
	if Ns.HideStatInfo then Ns:HideStatInfo() end
	-- Quick Color side panel.. hide whenever options reset.
	if Ns.HideQuickColor then Ns:HideQuickColor() end
	-- Quick Bars side panel.. hide whenever options reset.
	if Ns.HideQuickBars then Ns:HideQuickBars() end
	-- Global Settings bar is per-stat-group.. hide whenever options reset.
	if self.GlobalBar then self.GlobalBar:Hide() end
end

function Mixins.functions.AnchorFrames.SetActive(self, widget)
	local w = self.ActiveWidget
	self.ActiveWidget = widget
	if w and w ~= self.ActiveWidget then
		w:Click()
	end
end

function Mixins.functions.AnchorFrames.SetAnchor(self, anchor, width, height)
	if #self.CurrentWidgets == 0 or not anchor then
		return
	end
	self.PageAnchor = anchor
	self.BaseWidth = width and width or self.BaseWidth
	self.BaseHeight = height and height or self.BaseHeight
	self:ClearAllPoints()
	self:SetPoint("TOP", anchor, "BOTTOM", 0, settingsOffsetY)
	local reAnchor = self.CurrentWidgets[1]
	--local p, r, t, x, y = reAnchor:GetPoint(1)
 	local offsetY = 0
	self:SetSize(self.BaseWidth, self.BaseHeight + offsetY)
end

----------------------------------
--			Group Background	--
----------------------------------
function W.GroupBG(parent)
	local f = CreateFrame("Frame", nil, parent)
	f.SpecialType = "GroupBG"
	f.Texture = f:CreateTexture(nil, "BACKGROUND")
	f.Texture:SetAllPoints()
	f.Texture:SetColorTexture(0.08020, 0.08020, 0.08020, 0.8)
	f.Title = f:CreateFontString(nil, "OVERLAY")
	f.Title:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4) -- Compartment title font size (tweak the -5)
	f.Title:SetPoint("TOPLEFT", f, "TOPLEFT", 10, 15) -- Compartment title offset
	f.Title:SetTextColor(0.8, 0.8, 0.8, 1)
	f.Title:SetText("")
	Mixin(f, Mixins.functions.GroupBG)
	f:SetFrameLevel(1)
	f:Hide()
	return f
end

Mixins.functions.GroupBG = {}
function Mixins.functions.GroupBG.Reset(self)
	self.Title:SetText("")
	self.Title:ClearAllPoints()
	self.Title:SetPoint("TOPLEFT", self, "TOPLEFT", 10, 15) -- restore default anchor
	self:ClearAllPoints()
	self:SetHeight(0)
	self:EnableMouse(false)
	self:SetScript("OnMouseDown", nil)
	self:SetScript("OnMouseUp", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self._isInfoBtn = nil
	self._infoOpen = nil
	if self.Highlight then
		self.Highlight:Hide()
	end
	if self.Texture then
		self.Texture:ClearAllPoints()
		self.Texture:SetAllPoints(self)
		if self.Texture.SetDesaturated then
			self.Texture:SetDesaturated(false)
		end
		self.Texture:SetVertexColor(1, 1, 1, 1)
	end
end

----------------------------------
--			Separator			--
----------------------------------
function W.Separator(parent)
	local f = CreateFrame("Frame", nil, parent)
	local sepW = K.TOP_SEPARATOR_WIDTH > 0 and K.TOP_SEPARATOR_WIDTH or Ns.SeparatorWidth
	f:SetSize(sepW, K.TOP_SEPARATOR_HEIGHT)
	f.SpecialType = "Separator"
	f.Texture = f:CreateTexture()
	f.Texture:SetAllPoints()
	f.Texture:SetTexture(K.TOP_SEPARATOR_TEX)
	--f.Texture:SetVertexColor(greenColor.r, greenColor.g, greenColor.b)
	--f.Texture:SetVertexColor(1, 1, 1, 0.7)
	AddLabel(f)
	f:AnchorLabel("TOPLEFT", 0, 20, true)
	f:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize -3)
	f.Label:SetJustifyH("LEFT")
	--f.Label:SetJustifyV("BOTTOM")
	Mixin(f, Mixins.functions.Separator)
	for k, v in pairs(Mixins.scripts.Separator) do
		f:SetScript(k, v)
	end
	f.OrangeColor = orangeColor
	f:Hide()
	return f
end

Mixins.functions.Separator = {}
function Mixins.functions.Separator.Init(self, bottomlabel)
	if bottomlabel then
		self:AnchorLabel("TOPLEFT", 30, -20, true)
		self:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5)
		--self.Label:SetJustifyV("TOP")
	end
end

function Mixins.functions.Separator.EnableToolip(self, enable)
	self:SetHyperlinksEnabled(enable)
end

function Mixins.functions.Separator.Reset(self)
	self:SetLabel("")
	self:AnchorLabel("TOPLEFT", 0, 20, true)
	self:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize -3)
	self:SetTextColor(1,1,1)
	self:EnableToolip(false)
	--self.Label:SetJustifyV("BOTTOM")
end

Mixins.scripts.Separator = {}
function Mixins.scripts.Separator.OnHyperlinkEnter(self, link, text, region, left, bottom, width, height)
	GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
	GameTooltip:SetHyperlink(link)
	GameTooltip:Show()
end

function Mixins.scripts.Separator.OnHyperlinkLeave(self)
	GameTooltip:Hide()
end

----------------------------------
--			CheckButton			--
----------------------------------
function W.CheckButton(parent)
	local f = CreateFrame("CheckButton", nil, parent)
	f:SetSize(K.CHECKBOX_SIZE, K.CHECKBOX_SIZE)
	f.SpecialType = "CheckButton"
	f:SetNormalTexture("")
	f:SetPushedTexture("")
	f:SetHighlightTexture("")
	f.FrameTex = f:CreateTexture(nil, "ARTWORK", nil, 0)
	f.FrameTex:SetAllPoints()
	f.FrameTex:SetTexture(K.CHECKBOX_FRAME_TEX)
	f.FrameTex:SetBlendMode("BLEND")
	f:SetCheckedTexture(K.CHECKBOX_CHECK_TEX)
	local checked = f:GetCheckedTexture()
	checked:SetBlendMode("BLEND")
	checked:SetDesaturated(K.CHECKBOX_CHECK_DESATURATED)
	if K.CHECKBOX_CHECK_DESATURATED then
		checked:SetVertexColor(K.CHECKBOX_CHECK_R, K.CHECKBOX_CHECK_G, K.CHECKBOX_CHECK_B, K.CHECKBOX_CHECK_A)
	else
		checked:SetVertexColor(1, 1, 1, 1)
	end
	if K.CHECKBOX_CHECK_SIZE and K.CHECKBOX_CHECK_SIZE > 0 then
		checked:ClearAllPoints()
		checked:SetPoint("CENTER")
		checked:SetSize(K.CHECKBOX_CHECK_SIZE, K.CHECKBOX_CHECK_SIZE)
	end
	Mixin(f, Mixins.functions.CheckButton)
	for k, v in pairs(Mixins.scripts.CheckButton) do
		f:SetScript(k, v)
	end
	return f
end

Mixins.functions.CheckButton = {}
function Mixins.functions.CheckButton.Reset(self)
	self.ParentLink = nil
	self.ChildLink = nil
	self.Settings = nil
	self.Key = nil
	self:SetChecked(false)
	self:SetEnabled(true)
	self:Show()
end

local function LinkEnable(parent, self, forceDisable)
	if parent.Linked and #parent.Linked > 0 then
		local pendingOnChange = nil
		for k, v in ipairs(parent.Linked) do
			local enabled = not forceDisable and (self:GetChecked() ~= v[2])
			v[1]:SetEnabled(enabled)
			if v[1].Linked then
				LinkEnable(v[1], v[1].Check, not enabled)
			end
			if enabled and v[1].MyInformation and v[1].MyInformation.onchange and v[1].DropButton then
				pendingOnChange = v[1]
			end
		end
		if pendingOnChange then
			Ns[pendingOnChange.MyInformation.onchange](pendingOnChange, pendingOnChange.DropButton.Key, pendingOnChange.DropButton.Settings, pendingOnChange.MyInformation)
		end
	end
end

Mixins.scripts.CheckButton = {}
function Mixins.scripts.CheckButton.OnClick(self)
	PlayOnCheck()
	self.Settings[self.Key] = self:GetChecked() and true or false
	local parent = self:GetParent()
	if parent.SpecialType == "MinimapButton" then
		self.Settings.hide = not self.Settings[self.Key]
	end
	LinkEnable(parent, self)
	if not parent.MyInformation then
		parent = parent:GetParent()
	end
	if parent.MyInformation.onclick then
		Ns[parent.MyInformation.onclick](self, self.Key, self.Settings, parent.MyInformation)
	end
	if not self.DelayInit then
		Ns:QueueProfileRefresh()
	end
	if self.ParentLink then
		self.ParentLink:SetChecked(self:GetChecked())
	end
	if self.ChildLink then
		self.ChildLink:SetChecked(self:GetChecked())
	end
end

function Mixins.scripts.CheckButton.OnEnable(self)
	if self.FrameTex then self.FrameTex:SetVertexColor(1, 1, 1, 1) end
	local ct = self:GetCheckedTexture()
	if ct then
		if K.CHECKBOX_CHECK_DESATURATED then
			ct:SetVertexColor(K.CHECKBOX_CHECK_R, K.CHECKBOX_CHECK_G, K.CHECKBOX_CHECK_B, K.CHECKBOX_CHECK_A)
		else
			ct:SetVertexColor(1, 1, 1, 1)
		end
	end
end

function Mixins.scripts.CheckButton.OnDisable(self)
	if self.FrameTex then self.FrameTex:SetVertexColor(0.5, 0.5, 0.5, 0.6) end
	local ct = self:GetCheckedTexture()
	if ct then ct:SetVertexColor(0.5, 0.5, 0.5, 0.6) end
end
----------------------------------
--			ColorPicker			--
----------------------------------
function W.ColorPicker(parent)
	local f = CreateFrame("Button", nil, parent)
	f:SetSize(K.COLOR_PICKER_SIZE, K.COLOR_PICKER_SIZE)
	f.SpecialType = "ColorPicker"
	AddLabel(f)
	f:AnchorLabel("LEFT", 2, 0, true)
	AddTipText(f)
	if K.COLOR_PICKER_TIP_Y_OFFSET ~= 0 then
		f.Tip:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, Ns.TooltipYOffset + K.COLOR_PICKER_TIP_Y_OFFSET)
	end

	f.ColorPad = f:CreateTexture(nil, "BACKGROUND", nil, 1)
	f.ColorPad:SetPoint("TOPLEFT", f.Label, "TOPRIGHT", K.WIDGET_LABEL_GAP, 3)
	f.ColorPad:SetSize(K.COLOR_PICKER_SIZE, K.COLOR_PICKER_SIZE)
	f.ColorPad:SetTexture(Ns.TexturePath.."ColorPad")
	f.ColorBorder = f:CreateTexture(nil, "BACKGROUND", nil, 4)
	f.ColorBorder:SetPoint("TOPLEFT",     f.ColorPad, "TOPLEFT",     -K.COLOR_PICKER_BORDER_OVERSIZE, K.COLOR_PICKER_BORDER_OVERSIZE)
	f.ColorBorder:SetPoint("BOTTOMRIGHT", f.ColorPad, "BOTTOMRIGHT",  K.COLOR_PICKER_BORDER_OVERSIZE,-K.COLOR_PICKER_BORDER_OVERSIZE)
	f.ColorBorder:SetTexture(K.COLOR_PICKER_TEX)

	f.ColorPadProxy = CreateFrame("Button", nil, f)
	f.ColorPadProxy:SetAllPoints(f.ColorPad)
	f.ColorPadProxy:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	Mixin(f, Mixins.functions.ColorPicker)
	for k, v in pairs(Mixins.scripts.ColorPicker) do
		f:SetScript(k, v)
	end

	local onclick = f:GetScript("OnClick")
	f:SetScript("OnClick", nil)
	f.ColorPadProxy:SetScript("OnClick", function(proxy, button, down)
		onclick(proxy:GetParent(), button, down)
	end)
	return f
end

local function SetPickerPadColor(self, r, g, b)
	self.ColorPad:SetVertexColor(r, g, b)
end

local function ColourPickerCancel(self)
	local colour = ColorPickerFrame.previousValues
	ColorPickerFrame.colourBox.Settings[ColorPickerFrame.colourBox.Key] = colour
	SetPickerPadColor(ColorPickerFrame.colourBox, colour.r, colour.g, colour.b)
	Ns:QueueProfileRefresh()
end

local function ColourPickerChange(self)
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local colour = { r=r, g=g, b=b }
	ColorPickerFrame.colourBox.Settings[ColorPickerFrame.colourBox.Key] = colour
	SetPickerPadColor(ColorPickerFrame.colourBox, colour.r, colour.g, colour.b)
	Ns:QueueProfileRefresh()
end

Mixins.functions.ColorPicker = {}
function Mixins.functions.ColorPicker.Init(self, anchorframe, parent)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.Key = self.MyInformation.stat
	self:ColorInit()
end

function Mixins.functions.ColorPicker.Reset(self)
	self:SetEnabled(true)
end

function Mixins.functions.ColorPicker.ColorInit(self)
	local colour = self.Settings[self.Key]
	if not colour then
		colour = { r=1, g=1, b=1 }
	end
	self.ColorPad:SetVertexColor(colour.r, colour.g, colour.b)
	self:SetLabel(GetLabelText(self.MyInformation.stat, self.MyInformation, true))

	self.Label:ClearAllPoints()
	self.Label:SetPoint("LEFT", self, "LEFT", 2, -3)
	self.Label:SetJustifyH("LEFT")
	self.Label:SetTextColor(K.WIDGET_LABEL_R, K.WIDGET_LABEL_G, K.WIDGET_LABEL_B, K.WIDGET_LABEL_A)
	self.Tip:SetText(format(TipFormat, L[self.MyInformation.stat.."Tip"]))
	self.Tip:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	self.Tip:Show()
end

Mixins.scripts.ColorPicker = {}
function Mixins.scripts.ColorPicker.OnClick(self, button, down)
	if button == "RightButton" then
		if self.DefaultColor then
			SetPickerPadColor(self, self.DefaultColor.r, self.DefaultColor.g, self.DefaultColor.b)
			self.Settings[self.Key].r = self.DefaultColor.r
			self.Settings[self.Key].g = self.DefaultColor.g
			self.Settings[self.Key].b = self.DefaultColor.b
			self:ColorInit()
		end
		return
	end

	local basecolour = self.Settings[self.Key]
	local colour = { r=basecolour.r, g=basecolour.g, b=basecolour.b, }
	ColorPickerFrame.previousValues = colour
	ColorPickerFrame.colourBox = self
    if ColorPickerFrame.SetupColorPickerAndShow then -- 10.2.5 suport for ColorPicker changes
        local info = UIDropDownMenu_CreateInfo()
        info.r, info.g, info.b = colour.r, colour.g, colour.b
        info.swatchFunc = ColourPickerChange
        info.cancelFunc = ColourPickerCancel
        ColorPickerFrame:SetupColorPickerAndShow(info)
        if ColorPickerFrame.Content then
			ColorPickerFrame.Content.ColorPicker:SetColorRGB(colour.r, colour.g, colour.b)
		else
			ColorPickerFrame:SetColorRGB(colour.r, colour.g, colour.b)
		end
    else
        ColorPickerFrame.func = ColourPickerChange
        ColorPickerFrame.cancelFunc = ColourPickerCancel
        ColorPickerFrame:SetColorRGB(colour.r, colour.g, colour.b)
    end
    ColorPickerFrame:ClearAllPoints()
	--ColorPickerFrame.cancelFunc = ColourPickerCancel
	--ColorPickerFrame.func = ColourPickerChange
	-- ColorPickerFrame:SetColorRGB(colour.r, colour.g, colour.b)

	if self:GetRight() < UIParent:GetWidth() / 2 then
		ColorPickerFrame:SetPoint("LEFT", self, "RIGHT", 10, 0)
	else
		ColorPickerFrame:SetPoint("RIGHT", self, "LEFT", -10, 0)
	end
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	ColorPickerFrame:Show()
end

function Mixins.scripts.ColorPicker.OnDisable(self)
	self:SetAlpha(0.5)
end

function Mixins.scripts.ColorPicker.OnEnable(self)
	self:SetAlpha(1)
end

------------------------------
--			Radio			--
------------------------------
function W.Radio(parent)
	local f = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
	f:SetSize(30, 27)
	f.SpecialType = "Radio"
	f:SetBackdrop(RadioBG)
	f:SetBackdropColor(0.184, 0.184, 0.184, 0.4)
	f:SetBackdropBorderColor(0.184, 0.184, 0.184, 0)
	f.BgAtlas = f:CreateTexture(nil, "BACKGROUND", nil, 1)
	f.BgAtlas:SetPoint("TOPLEFT",     f, "TOPLEFT",     -K.RADIO_BG_INSET_L,  K.RADIO_BG_INSET_T)
	f.BgAtlas:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT",  K.RADIO_BG_INSET_R, -K.RADIO_BG_INSET_B)
	f.BgAtlas:SetTexture(K.RADIO_BG_TEX)
	f.BgAtlas:SetDesaturated(K.RADIO_BG_DESATURATED)
	f.BgAtlas:SetVertexColor(K.RADIO_BG_R, K.RADIO_BG_G, K.RADIO_BG_B, K.RADIO_BG_A)
	f:SetBackdropColor(0, 0, 0, 0)
	Mixin(f, Mixins.functions.Radio)
	AddTipText(f)
	f.Tip:SetText(format(TipFormat, L["OptionsTip"]))

	f.Tip:ClearAllPoints()
	f.Tip:SetPoint("LEFT", f, "LEFT", 0, 0)  -- placeholder; repositioned in Init after width is known
	f.Radios = {}
	local btnH = K.RADIO_BTN_GAP_H
	for i=1, 3 do
		local r = CreateFrame("CheckButton", nil, f)

		r:SetNormalTexture("")
		r:SetPushedTexture("")
		r:SetHighlightTexture("")
		r:SetHeight(btnH)
		tinsert(f.Radios, r)

		r.BgTex = r:CreateTexture(nil, "ARTWORK", nil, -1)
		r.BgTex:SetAllPoints()
		r.BgTex:SetTexture(K.RADIO_BUTTON_TEX ~= "" and K.RADIO_BUTTON_TEX or (Ns.TexturePath..""))
		r.BgTex:SetDesaturated(K.RADIO_BG_DESATURATED)
		r.BgTex:SetVertexColor(K.RADIO_BG_R, K.RADIO_BG_G, K.RADIO_BG_B, K.RADIO_BG_A)
		r:SetCheckedTexture(K.RADIO_DOT_CHECK_TEX ~= "" and K.RADIO_DOT_CHECK_TEX or (Ns.TexturePath..""))
		local ct = r:GetCheckedTexture()
		ct:SetVertexColor(K.RADIO_HLT_R, K.RADIO_HLT_G, K.RADIO_HLT_B, 0.4)
		--ct:SetBlendMode("ADD")
		if K.RADIO_HIGHLIGHT_GAP > 0 then
			ct:ClearAllPoints()
			ct:SetPoint("TOPLEFT",     r, "TOPLEFT",     -K.RADIO_HIGHLIGHT_GAP,  0)
			ct:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT",  K.RADIO_HIGHLIGHT_GAP,  0)
		end

		local hlTex = K.RADIO_HIGHLIGHT_TEX ~= "" and K.RADIO_HIGHLIGHT_TEX or (Ns.TexturePath.."Highlight")
		r:SetHighlightTexture(hlTex)
		local ht = r:GetHighlightTexture()
		ht:SetVertexColor(K.RADIO_HLT_R, K.RADIO_HLT_G, K.RADIO_HLT_B, K.RADIO_HLT_A)
		if K.RADIO_HIGHLIGHT_GAP > 0 then
			ht:ClearAllPoints()
			ht:SetPoint("TOPLEFT",     r, "TOPLEFT",     -K.RADIO_HIGHLIGHT_GAP,  0)
			ht:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT",  K.RADIO_HIGHLIGHT_GAP,  0)
		end
		AddLabel(r)
		r.Label:SetPoint("CENTER", 0, 0)
		for k, v in pairs(Mixins.scripts.Radio) do
			r:SetScript(k, v)
		end
		if i == 1 then
			r:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 6, K.RADIO_BTN_Y_OFFSET)
		else
			r:SetPoint("BOTTOMLEFT", f.Radios[i-1], "BOTTOMRIGHT", 8, 0)
		end
	end
	return f
end

Mixins.functions.Radio = {}
function Mixins.functions.Radio.Init(self, anchorframe, parent)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	if parent.MyInformation.svnotintable then
		self.Settings = parent.SvTable
		self.Tip:SetText(format(TipFormat, L[self.MyInformation.stat]))
		self.UpdateFunc = self.MyInformation.updatefunc
		self.AnchorFrame = anchorframe
	else
		self.Settings = parent.SvTable[parent.MyInformation.stat]
	end
	self.Key = self.MyInformation.stat
	self.Option = Ns.Options[self.MyInformation.option]
	local width = 12 -- 6 left + 6 right padding
	for k, v in ipairs(self.Radios) do
		v.OptionVal = k
		v:SetLabel(L[self.MyInformation.labels[k]])
		v:SetChecked(false)
		local btnW = v.Label:GetStringWidth() + K.RADIO_BTN_GAP_W * 2 + 4
		v:SetWidth(btnW)
		width = width + btnW
	end
	width = width + 16 -- 8 gap * 2 (between 3 buttons)

	self.Tip:ClearAllPoints()
	self.Tip:SetPoint("LEFT", self.Radios[#self.Radios], "RIGHT", K.RADIO_TIP_X_OFFSET, K.RADIO_TIP_Y_OFFSET)
	self.Tip:SetJustifyH("LEFT")
	width = width + (self.Tip:GetStringWidth() or 0) + K.RADIO_TIP_X_OFFSET
	self:SetWidth(width)
	self.Radios[self.Settings[self.Key]]:SetChecked(true)
end

function Mixins.functions.Radio.Reset(self)
	self.MyInformation = nil
	self.Settings = nil
	self.Key = nil
	self.Option = nil
	self.OptionVal = nil
	self.AnchorFrame = nil
	self.UpdateFunc = nil
	for k, v in ipairs(self.Radios) do
		v:SetChecked(false)
	end
end

Mixins.scripts.Radio = {}
function Mixins.scripts.Radio.OnClick(self)
	PlayOnCheck()
	for k, v in ipairs(self:GetParent().Radios) do
		if v == self then
			v:SetChecked(true)
		else
			v:SetChecked(false)
		end
	end
	self:GetParent().Settings[self:GetParent().Key] = self.OptionVal
	if self:GetParent().UpdateFunc then
		Ns[self:GetParent().UpdateFunc](self, self.OptionVal)
	end
	Ns:QueueProfileRefresh()
end

----------------------------------
--			Checkbox			--
----------------------------------
function W.CheckBox(parent)
	local f = CreateFrame("Button", nil, parent)
	f:SetSize(10, checkBoxHeight)
	f.SpecialType = "CheckBox"
	Mixin(f, Mixins.functions.CheckBoxFrame)
	f:SetHighlightTexture(Ns.TexturePath.."Highlight")
	if K.CHECKBOX_HIGHLIGHT ~= "" then
		f:SetHighlightTexture(K.CHECKBOX_HIGHLIGHT)
		--Ns:ApplyAtlasOrFallback(f:GetHighlightTexture(), "ButtonHighlight", function(t) t:SetTexture(K.CHECKBOX_HIGHLIGHT) end)
		--f:SetDesaturated(K.CHECKBOX_HIGHLIGHT_DESATURATED)
		--f:SetBlendMode("ADD")
	end
	local ht = f:GetHighlightTexture()
	ht:SetVertexColor(K.CHECKBOX_HIGHLIGHT_R, K.CHECKBOX_HIGHLIGHT_G, K.CHECKBOX_HIGHLIGHT_B, K.CHECKBOX_HIGHLIGHT_A)
	ht:ClearAllPoints()
	if K.CHECKBOX_HIGHLIGHT_W > 0 and K.CHECKBOX_HIGHLIGHT_H > 0 then
		ht:SetPoint("CENTER", f, "CENTER", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		ht:SetSize(K.CHECKBOX_HIGHLIGHT_W, K.CHECKBOX_HIGHLIGHT_H)
	elseif K.CHECKBOX_HIGHLIGHT_H > 0 then
		ht:SetPoint("LEFT", f, "LEFT", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		ht:SetPoint("RIGHT", f, "RIGHT", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		ht:SetHeight(K.CHECKBOX_HIGHLIGHT_H)
	elseif K.CHECKBOX_HIGHLIGHT_W > 0 then
		ht:SetPoint("TOP", f, "TOP", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		ht:SetPoint("BOTTOM", f, "BOTTOM", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		ht:SetWidth(K.CHECKBOX_HIGHLIGHT_W)
	else
		ht:SetPoint("TOPLEFT", f, "TOPLEFT", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		ht:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
	end
	ht:SetAlpha(1)
	AddLabel(f)
	f:AnchorLabel("LEFT",  K.CHECKBOX_LABEL_GAP + K.CHECKBOX_X_OFFSET, 5, true)
	f:SetLabel("")
	AddTipText(f)
	if K.CHECKBOX_TIP_Y_OFFSET ~= 0 then
		f.Tip:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, Ns.TooltipYOffset + K.CHECKBOX_TIP_Y_OFFSET)
	end

	for k, v in pairs(Mixins.scripts.CheckBoxFrame) do
		f:SetScript(k, v)
	end
	f.Check = Ns:GetWidget("CheckButton", f)
	f.Check:SetPoint("LEFT", 9 + K.CHECKBOX_X_OFFSET, 5)
	f.Check:SetSize(K.CHECKBOX_SIZE, K.CHECKBOX_SIZE)
	f.Check:SetFrameLevel(parent:GetFrameLevel())
	f.Check:SetHighlightTexture(K.CHECKBOX_CHECK_HIGHLIGHT ~= "" and K.CHECKBOX_CHECK_HIGHLIGHT or K.CHECKBOX_HIGHLIGHT ~= "" and K.CHECKBOX_HIGHLIGHT or (Ns.TexturePath.."Highlight"))
	f.Check:GetHighlightTexture():SetDesaturated(K.CHECKBOX_CHECK_HIGHLIGHT_DESATURATED)
	f.Check:GetHighlightTexture():SetVertexColor(K.CHECKBOX_CHECK_HIGHLIGHT_R, K.CHECKBOX_CHECK_HIGHLIGHT_G, K.CHECKBOX_CHECK_HIGHLIGHT_B, K.CHECKBOX_CHECK_HIGHLIGHT_A)
	f.Check:GetHighlightTexture():ClearAllPoints()
	f.Check:GetHighlightTexture():SetAllPoints(f.Check)
	f:SetPoint("CENTER")
	return f
end

Mixins.functions.CheckBoxFrame = {}
function Mixins.functions.CheckBoxFrame.Init(self, anchorframe, parent)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Check.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.Check.Key = self.MyInformation.stat
	if self.Linked then
		wipe(self.Linked)
	end
	self.DisableOn = nil
	local val = self.Check.Settings[self.MyInformation.stat]
	self.Check:SetChecked(val == true)
	self:SetLabel(GetLabelText(self.MyInformation.stat, self.MyInformation, true))
	-- Label at left edge, checkmark at right edge
	self.Label:ClearAllPoints()
	self.Label:SetPoint("LEFT", self, "LEFT", 2, 4)
	self.Label:SetJustifyH("LEFT")
	self.Label:SetTextColor(K.WIDGET_LABEL_R, K.WIDGET_LABEL_G, K.WIDGET_LABEL_B, K.WIDGET_LABEL_A)
	self.Check:ClearAllPoints()
	self.Check:SetPoint("RIGHT", self, "RIGHT", -4, 0)
	self:SetWidth(self.Check:GetWidth() + self.Label:GetStringWidth() + 20)
	AdjustCheckTip(self, self.MyInformation.stat)
end

function Mixins.functions.CheckBoxFrame.Reset(self)
	self.Check:Reset()
	self:SetEnabled(true)
	self:SetLabel("")
	self:SetWidth(5)
end

function Mixins.functions.CheckBoxFrame.SetLink(self, anchorframe, parent)
	if not self.MyInformation.linked or #self.MyInformation.linked == 0 then
		return
	end
	self.Linked = self.Linked or {}
	wipe(self.Linked)
	local selfEnabled = self.Check:IsEnabled()
	local i, total = 1, #self.MyInformation.linked
	while i < total do-- #self.MyInformation.linked do 
		--local link = self.MyInformation.linked[i]
		for k, v in ipairs(anchorframe.CurrentWidgets) do
			if parent.DisplayOrder[v:GetID()].stat == self.MyInformation.linked[i] then
				tinsert(self.Linked, { v, self.MyInformation.linked[i+1] })
				v:SetEnabled(selfEnabled and (self.Check:GetChecked() ~= self.MyInformation.linked[i+1]))
				break
			end
		end
		i=i+2
	end

	for k, v in ipairs(self.Linked) do
		local widget = v[1]
		if widget.MyInformation and widget.MyInformation.onchange and widget.DropButton then
			Ns[widget.MyInformation.onchange](widget, widget.DropButton.Key, widget.DropButton.Settings, widget.MyInformation)
		end
	end
end

Mixins.scripts.CheckBoxFrame = {}
function Mixins.scripts.CheckBoxFrame.OnClick(self)
	PlayOnCheck()
	self.Check:Click()
end

function Mixins.scripts.CheckBoxFrame.OnEnable(self)
	self.Check:SetEnabled(true)
	self:SetAlpha(1)
end

function Mixins.scripts.CheckBoxFrame.OnDisable(self)
	self.Check:SetEnabled(false)
	self:SetAlpha(0.5)
end

----------------------------------
--			Droplists			--
----------------------------------

-- updates content position + scrollbar thumb from list.ScrollOffset
local function DropList_UpdateScroll(list)
	if list.Content then
		list.Content:SetPoint("TOPLEFT", 0, list.ScrollOffset or 0)
	end
	if list.ScrollBar and list.ScrollBar:IsShown() and (list.MaxScroll or 0) > 0 then
		local trackH = list:GetHeight() - 4
		local thumbH = list.ScrollBar.Thumb:GetHeight()
		local travel = trackH - thumbH
		local ratio = (list.ScrollOffset or 0) / list.MaxScroll
		list.ScrollBar.Thumb:SetPoint("TOP", list.ScrollBar, "TOP", 0, -(ratio * travel))
	end
end

function W.DropList(parent)
	local f = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
	f:SetSize(140, K.DROPLIST_HEIGHT)
	f.SpecialType = "DropList"
	AddTipText(f)
	Mixin(f, Mixins.functions.DropListFrame)
	for k, v in pairs(Mixins.scripts.DropListFrame) do
		f:SetScript(k, v)
	end
	f:SetBackdrop(WidgetBG)
	--f:SetBackdropColor(0.184, 0.184, 0.184, 0.3)
	f:SetBackdropColor(0.27451, 0.27451, 0.27451, K.DROPLIST_BG_ALPHA)
	f:SetBackdropBorderColor(0, 0, 0, 1)

	f.Label = f:CreateFontString()
	f.Label:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.Label:SetJustifyH("LEFT")
	f.Label:SetPoint("LEFT", f, "LEFT", 2, -1)
	f.Label:SetTextColor(K.WIDGET_LABEL_R, K.WIDGET_LABEL_G, K.WIDGET_LABEL_B, K.WIDGET_LABEL_A)
	f.Label:Hide()

	f.BgAtlas = f:CreateTexture(nil, "BACKGROUND", nil, 1)
	f.BgAtlas:SetPoint("TOP",    f,       "TOP",    0,  K.DROPLIST_BG_INSET_T)
	f.BgAtlas:SetPoint("BOTTOM", f,       "BOTTOM", 0, -K.DROPLIST_BG_INSET_B)
	f.BgAtlas:SetPoint("LEFT",   f.Label, "RIGHT",  K.WIDGET_LABEL_GAP - K.DROPLIST_BG_INSET_L, 0)
	f.BgAtlas:SetPoint("RIGHT",  f,       "RIGHT",  K.DROPLIST_BG_INSET_R, 0)
	f.BgAtlas:SetTexture(K.DROPLIST_NORMAL_TEX)
	f:SetBackdropColor(0, 0, 0, 0)
	f:SetBackdropBorderColor(0, 0, 0, 0)
	f.DropButton = CreateFrame("Button", nil, f)
	f.DropButton:SetSize(13, 13)
	f.DropButton:SetPoint("TOPRIGHT", -4, -4)
	for k, v in pairs(Mixins.scripts.DropListButton) do
		f.DropButton:SetScript(k, v)
	end
	f.Text = f:CreateFontString()
	f.Text:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4)
	f.Text:SetJustifyH("CENTER")
	f.Text:SetWordWrap(false)
	f.Text:SetPoint("LEFT", f.BgAtlas, "LEFT", 20, -1)

	f.List = CreateFrame("Frame", nil, f, BackdropTemplateMixin and "BackdropTemplate")
	f.List:Hide()
	f.List:SetSize(150, 70)
	f.List:SetPoint("TOPLEFT", f.BgAtlas, "BOTTOMLEFT", 0, K.DROPLIST_LIST_GAP)
	f.List:SetFrameStrata("TOOLTIP")
	f.List.Buttons = {}

	f.List.ListBgAtlas = f.List:CreateTexture(nil, "OVERLAY", nil, -7)
	f.List.ListBgAtlas:SetPoint("TOPLEFT",     f.List, "TOPLEFT",     -K.DROPLIST_LIST_BG_INSET_L,  K.DROPLIST_LIST_BG_INSET_T)
	f.List.ListBgAtlas:SetPoint("BOTTOMRIGHT", f.List, "BOTTOMRIGHT",  K.DROPLIST_LIST_BG_INSET_R, -K.DROPLIST_LIST_BG_INSET_B)
	Ns:ApplyAtlasOrFallback(f.List.ListBgAtlas, "DropListListBg", function(t)
		t:SetTexture(K.DROPLIST_LIST_BG_TEX ~= "" and K.DROPLIST_LIST_BG_TEX or nil)
	end)
	f.List.ListBgAtlas:SetVertexColor(K.DROPLIST_LIST_BG_VERTEX_R, K.DROPLIST_LIST_BG_VERTEX_G, K.DROPLIST_LIST_BG_VERTEX_B, K.DROPLIST_LIST_BG_VERTEX_A)
	f.List.ListBgAtlas:Hide()  -- hidden until list opens

	f.List.ClipContainer = CreateFrame("Frame", nil, f.List)
	f.List.ClipContainer:SetAllPoints(f.List)
	f.List.ClipContainer:SetClipsChildren(true)

	f.List.Content = CreateFrame("Frame", nil, f.List.ClipContainer)
	f.List.Content:SetPoint("TOPLEFT", 0, 0)
	f.List.Content:SetSize(150, 70)

	f.List.ScrollBar = CreateFrame("Frame", nil, f.List, BackdropTemplateMixin and "BackdropTemplate")
	f.List.ScrollBar:SetWidth(8)
	f.List.ScrollBar:SetPoint("TOPRIGHT", -1, -2)
	f.List.ScrollBar:SetPoint("BOTTOMRIGHT", -1, 2)
	f.List.ScrollBar:SetBackdrop({bgFile = "Interface/BUTTONS/WHITE8X8"})
	f.List.ScrollBar:SetBackdropColor(0.1, 0.1, 0.1, 0.4)
	f.List.ScrollBar:Hide()

	local dlCapH = 4
	f.List.ScrollBar.Thumb = CreateFrame("Frame", nil, f.List.ScrollBar)
	f.List.ScrollBar.Thumb:SetWidth(8)
	local dlTopCap = f.List.ScrollBar.Thumb:CreateTexture(nil, "ARTWORK")
	dlTopCap:SetPoint("TOPLEFT")
	dlTopCap:SetPoint("TOPRIGHT")
	dlTopCap:SetHeight(dlCapH)
	dlTopCap:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask")
	dlTopCap:SetTexCoord(0, 1, 0, 0.5)
	dlTopCap:SetVertexColor(0.388, 0.380, 0.388, 1)
	local dlMidTex = f.List.ScrollBar.Thumb:CreateTexture(nil, "ARTWORK")
	dlMidTex:SetPoint("TOPLEFT", f.List.ScrollBar.Thumb, "TOPLEFT", 0, -dlCapH)
	dlMidTex:SetPoint("BOTTOMRIGHT", f.List.ScrollBar.Thumb, "BOTTOMRIGHT", 0, dlCapH)
	dlMidTex:SetTexture("Interface/AddOns/SinStats/Textures/Scrollbar")
	dlMidTex:SetVertexColor(1, 1, 1, 0.5)
	local dlBotCap = f.List.ScrollBar.Thumb:CreateTexture(nil, "ARTWORK")
	dlBotCap:SetPoint("BOTTOMLEFT")
	dlBotCap:SetPoint("BOTTOMRIGHT")
	dlBotCap:SetHeight(dlCapH)
	dlBotCap:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask")
	dlBotCap:SetTexCoord(0, 1, 0.5, 1)
	dlBotCap:SetVertexColor(1, 1, 1, 0.5)
	f.List.ScrollBar.Thumb:SetPoint("TOP", 0, 0)
	f.List.ScrollBar.Thumb:SetHeight(20)
	f.List.ScrollBar.Thumb:EnableMouse(true)
	local function DropThumbOnUpdate(thumb)
		local list = thumb:GetParent():GetParent()
		local _, cursorY = GetCursorPosition()
		local scale = thumb:GetEffectiveScale()
		cursorY = cursorY / scale
		local deltaY = list.DragStartY - cursorY -- positive = dragged down = scroll down
		local trackH = list:GetHeight() - 4
		local thumbH = thumb:GetHeight()
		local travel = trackH - thumbH
		if travel <= 0 or (list.MaxScroll or 0) <= 0 then return end
		local scrollDelta = deltaY * (list.MaxScroll / travel)
		local newOffset = math.max(0, math.min(list.MaxScroll, (list.DragStartOffset or 0) + scrollDelta))
		list.ScrollOffset = newOffset
		DropList_UpdateScroll(list)
	end
	f.List.ScrollBar.Thumb:SetScript("OnMouseDown", function(thumb, button)
		if button ~= "LeftButton" then return end
		local list = thumb:GetParent():GetParent()
		local _, cursorY = GetCursorPosition()
		local scale = thumb:GetEffectiveScale()
		list.DragStartY = cursorY / scale
		list.DragStartOffset = list.ScrollOffset or 0
		list.ThumbDragging = true
		thumb:SetScript("OnUpdate", DropThumbOnUpdate)
	end)
	f.List.ScrollBar.Thumb:SetScript("OnMouseUp", function(thumb, button)
		if button ~= "LeftButton" then return end
		local list = thumb:GetParent():GetParent()
		list.ThumbDragging = false
		thumb:SetScript("OnUpdate", nil)
	end)
	--end)

	f.List.ScrollOffset = 0
	f.List.MaxScroll = 0

	Mixin(f.List, Mixins.functions.DropList)
	for k, v in pairs(Mixins.scripts.DropList) do
		f.List:SetScript(k, v)
	end
	-- scrollbar track
	f.List.ScrollBar:EnableMouse(true)
	f.List.ScrollBar:SetScript("OnMouseDown", function(track, button)
		if button ~= "LeftButton" then return end
		local list = track:GetParent()
		if (list.MaxScroll or 0) <= 0 then return end
		local _, cursorY = GetCursorPosition()
		local scale = track:GetEffectiveScale()
		cursorY = cursorY / scale
		local thumbCenter = select(2, track.Thumb:GetCenter())
		local pageStep = dropListRowHeight * K.DROPLIST_LIST_MAX_VISIBLE_ROWS * 0.75
		if cursorY < thumbCenter then
			list.ScrollOffset = math.min(list.MaxScroll, (list.ScrollOffset or 0) + pageStep)
		else
			list.ScrollOffset = math.max(0, (list.ScrollOffset or 0) - pageStep)
		end
		DropList_UpdateScroll(list)
	end)
	return f
end

function W.DropListRow(parent)
	local f = CreateFrame("CheckButton", nil, parent)
	f:SetSize(40, dropListRowHeight+2)
	f.SpecialType = "DropListRow"
	f:SetCheckedTexture(K.DROPLIST_LIST_HIGHLIGHT)
	--f:GetCheckedTexture():SetAlpha(0.6)
	f:GetCheckedTexture():SetBlendMode("ADD")
	f:SetHighlightTexture(K.DROPLIST_LIST_HIGHLIGHT)
	f.Text = f:CreateFontString()
	f.Text:SetPoint("LEFT")
	f.Text:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.Text:SetJustifyH("LEFT")
	Mixin(f, Mixins.functions.DropListRow)
	for k, v in pairs(Mixins.scripts.DropListRow) do
		f:SetScript(k, v)
	end
	return f

end

Mixins.functions.DropListFrame = {}
function Mixins.functions.DropListFrame.Init(self, anchorframe, parent, displaylist)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.AnchorFrame = anchorframe
	self:SetEnabled(true)
	self:SetWidth(self.MyInformation.widget.width)
	self:SetFrameStrata("DIALOG")
	self.DropButton.MyInformation = parent.DisplayOrder[self:GetID()]
	self.DropButton.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.DropButton.Key = self.MyInformation.stat ~= "Profiles" and self.MyInformation.stat or parent.Key
	self.DropButton.Data = ListData[self.MyInformation.widget.data]
	for k, v in ipairs(self.DropButton.Data) do
		if v.value == self.DropButton.Settings[self.DropButton.Key] then
			self:SetText(v.text)
			break
		end
	end
	self.Tip:SetText(format(TipFormat, L[self.DropButton.Key.."Tip"]))
	self.Tip:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	self.Tip:Show()

	if self.Label then
		if anchorframe.SpecialType == "AnchorFrame" then
			self.Label:SetText(L[self.MyInformation.stat] or L[self.MyInformation.stat.."Menu"] or "")
			self.Label:SetJustifyH("LEFT")
			self.Label:SetTextColor(K.WIDGET_LABEL_R, K.WIDGET_LABEL_G, K.WIDGET_LABEL_B, K.WIDGET_LABEL_A)
			self.Label:Show()

			local labelW = ceil(self.Label:GetStringWidth() or 0)
			self:SetWidth(labelW + K.WIDGET_LABEL_GAP + (self.MyInformation.widget.width or 140))

			self.BgAtlas:ClearAllPoints()
			self.BgAtlas:SetPoint("TOP",    self,       "TOP",    0,  K.DROPLIST_BG_INSET_T)
			self.BgAtlas:SetPoint("BOTTOM", self,       "BOTTOM", 0, -K.DROPLIST_BG_INSET_B)
			self.BgAtlas:SetPoint("LEFT",   self.Label, "RIGHT",  K.WIDGET_LABEL_GAP - K.DROPLIST_BG_INSET_L, 0)
			self.BgAtlas:SetPoint("RIGHT",  self,       "RIGHT",  K.DROPLIST_BG_INSET_R, 0)
		else
			self.Label:Hide()
			self.BgAtlas:ClearAllPoints()
			self.BgAtlas:SetPoint("TOPLEFT",     self, "TOPLEFT",     -K.DROPLIST_BG_INSET_L,  K.DROPLIST_BG_INSET_T)
			self.BgAtlas:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT",  K.DROPLIST_BG_INSET_R, -K.DROPLIST_BG_INSET_B)
		end
	end
end

function Mixins.functions.DropListFrame.Reset(self)
	self.List:Hide()
	for k, v in pairs(Mixins.scripts.DropListButton) do
		self.DropButton:SetScript(k, v)
	end
end

local function SetDropListBgState(f, state)
	if not f or not f.BgAtlas then return end
	if state == "normal" then
		f.BgAtlas:SetTexture(K.DROPLIST_NORMAL_TEX)
	else
		f.BgAtlas:SetTexture(K.DROPLIST_HOVER_TEX)
	end
end

function Mixins.functions.DropListFrame.SetEnabled(self, enabled)
	self:SetBackdropBorderColor(0.184, 0.184, 0.184, 0.8)
	self.Text:SetAlpha(enabled and 1 or 0.5)
	self.DropButton:SetEnabled(enabled)
	self.DropButton:SetAlpha(enabled and 1 or 0.5)
	if self.Label then self.Label:SetAlpha(enabled and 1 or 0.5) end
	if not enabled then
		SetDropListBgState(self, "normal")
	end
end

function Mixins.functions.DropListFrame.SetText(self, text)
    self.Text:SetText(text)

    local barW = self.MyInformation.widget.width or self:GetWidth()
    if barW > 41 then
        self.Text:SetWidth(barW - 41)
    end

    self.Text:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4)
    if self.DropButton.Data == ListData.Fonts then
        local font = Ns.LSM:Fetch("font", text)
        if font then
            self.Text:SetFont(font, Ns.ConfigDefaultFontSize - 4)
        end
    end
end

Mixins.scripts.DropListFrame = {}
function Mixins.scripts.DropListFrame.OnEnter(self)
	OnEnterFunc(self)
	if self.DropButton:IsEnabled() then
		SetDropListBgState(self, (self.List and self.List:IsShown()) and "open" or "hover")
	end
end

function Mixins.scripts.DropListFrame.OnLeave(self)
	OnLeaveFunc(self)
	SetDropListBgState(self, (self.List and self.List:IsShown()) and "open" or "normal")
end

function Mixins.scripts.DropListFrame.OnMouseUp(self, button)
	if button == "LeftButton" and self.DropButton:IsEnabled() then
		local onClick = self.DropButton:GetScript("OnClick")
		if onClick then onClick(self.DropButton) end
	end
end

Mixins.scripts.DropListButton = {}
function Mixins.scripts.DropListButton.OnClick(self)
	PlayOnCheck()
	local parent = self:GetParent()
	if not self:GetParent().List:IsShown() then
		parent.List.MyInformation = self.MyInformation
		parent.List.Settings = self.Settings
		parent.List.Key = self.Key
		parent.List.Data = self.Data
	end
	self:GetParent().List:SetShown(not self:GetParent().List:IsShown())
	SetDropListBgState(parent, parent.List:IsShown() and "open" or "hover")
end

function Mixins.scripts.DropListButton.OnEnter(self)
	OnEnterFunc(self:GetParent())
	SetDropListBgState(self:GetParent(), (self:GetParent().List and self:GetParent().List:IsShown()) and "open" or "hover")
end

function Mixins.scripts.DropListButton.OnLeave(self)
	self:GetParent():GetScript("OnLeave")(self:GetParent())
end

Mixins.functions.DropList = {}
function Mixins.functions.DropList.Reset(self)

	local dropWidget = self.DropParent or self:GetParent()
	self.DropParent = nil
	self:SetParent(dropWidget)
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", dropWidget.BgAtlas or dropWidget, "BOTTOMLEFT", 0, K.DROPLIST_LIST_GAP)
	self:SetSize(5, 5)
	self.MyInformation = nil
	self.Settings = nil
	self.Key = nil
	self.Data = nil
	self.IsCopyList = nil
	self.IsDeleteList = nil
	self.IsSpecList = nil
	self.IsPanelSelect = nil
	self.SpecIndex = nil
	self.ScrollOffset = 0
	self.MaxScroll = 0
	self.ThumbDragging = false
	if self.Content then
		self.Content:SetPoint("TOPLEFT", 0, 0)
	end
	if self.ScrollBar then
		self.ScrollBar:Hide()
	end
	for k, v in ipairs(self.Buttons) do
		Ns:KillWidget(v)
	end
	wipe(self.Buttons)
end

Mixins.scripts.DropList = {}
function Mixins.scripts.DropList.OnHide(self)
	if self.ListBgAtlas then
		self.ListBgAtlas:Hide()
	end
	if self.DropParent then
		SetDropListBgState(self.DropParent, "normal")
	end
	self:Reset()
end

function Mixins.scripts.DropList.OnEnter(self)
	OnEnterFunc(self.DropParent or self:GetParent())
end

function Mixins.scripts.DropList.OnLeave(self)
	local dp = self.DropParent or self:GetParent()
	dp:GetScript("OnLeave")(dp)
end

function Mixins.scripts.DropList.OnShow(self)

	if self.ListBgAtlas then
		self.ListBgAtlas:Show()
	end
	self:SetFrameStrata("FULLSCREEN_DIALOG")
	self:SetSize(5, 5)
	self.ScrollOffset = 0
	self.MaxScroll = 0
	self.ThumbDragging = false
	if self.Content then
		self.Content:ClearAllPoints()
		self.Content:SetPoint("TOPLEFT", 0, 0)
	end

	local widest = 0
	local container = self.Content or self
	for k, v in ipairs(self.Data) do
		local row = Ns:GetWidget("DropListRow", container, k)
		row:SetChecked(false)
		tinsert(self.Buttons, row)
		local w = row:Init(self, v)
		if w > widest then
			widest = w
		end
		if v.value == self.Settings[self.Key] then
			self:GetParent():SetText(v.text)
			row:SetChecked(true)
		else
			row:SetChecked(false)
		end
	end

	local total = #self.Data
	widest = widest + 10 + K.DROPLIST_ROW_EXTRA_W

	local numCols = math.max(1, math.min(4, K.DROPLIST_LIST_COLUMNS))
	local rowsPerCol = math.ceil(total / numCols)
	local colGap = (numCols > 1) and 5 or 0
	local colStarts, last = {}, nil
	for i, v in ipairs(self.Buttons) do
		v:ClearAllPoints()
		v:SetWidth(widest)
		local _ht = v:GetHighlightTexture()
		if _ht then _ht:ClearAllPoints(); _ht:SetAllPoints(v) end
		local _ct = v:GetCheckedTexture()
		if _ct then _ct:ClearAllPoints(); _ct:SetAllPoints(v) end
		local col = math.floor((i - 1) / rowsPerCol) + 1
		local rowInCol = (i - 1) % rowsPerCol + 1
		if rowInCol == 1 then
			colStarts[col] = v
			if col == 1 then
				v:SetPoint("TOPLEFT", container, "TOPLEFT", K.DROPLIST_LIST_PAD_L, -K.DROPLIST_LIST_PAD_T)
			else
				v:SetPoint("TOPLEFT", colStarts[col-1], "TOPRIGHT", colGap, 0)
			end
		else
			v:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, 0)
		end
		last = v
	end

	local maxVisPerCol = math.ceil(K.DROPLIST_LIST_MAX_VISIBLE_ROWS / numCols)
	local visibleRows = math.min(rowsPerCol, maxVisPerCol)
	local rowFrameH = dropListRowHeight + 2  -- actual row frame height (SetSize in DropListRow)
	local contentH = rowsPerCol * rowFrameH + K.DROPLIST_LIST_PAD_T + K.DROPLIST_LIST_PAD_B
	local visibleH = visibleRows * rowFrameH + K.DROPLIST_LIST_PAD_T + K.DROPLIST_LIST_PAD_B
	local listWidth = (numCols * widest) + (numCols - 1) * colGap + K.DROPLIST_LIST_PAD_L + K.DROPLIST_LIST_PAD_R

	if numCols == 1 then
		local dropWidget = self:GetParent()
		local btnW = dropWidget.BgAtlas and dropWidget.BgAtlas:GetWidth() or dropWidget:GetWidth()
		listWidth = math.max(listWidth, (btnW or 140) + K.DROPLIST_LIST_PAD_L + K.DROPLIST_LIST_PAD_R)

		local contentW = listWidth - K.DROPLIST_LIST_PAD_L - K.DROPLIST_LIST_PAD_R
		if contentW > widest then
			widest = contentW
			for _, v in ipairs(self.Buttons) do
				v:SetWidth(widest)
			end
		end
	end
	local scrollBarPad = 0

	if self.Content then
		self.Content:SetSize(listWidth, contentH)
	end

	if rowsPerCol > maxVisPerCol and self.ScrollBar then
		self.ScrollBar:Show()
		self.MaxScroll = contentH - visibleH
		scrollBarPad = 8
		local trackH = visibleH - 4
		local thumbH = math.max(16, trackH * (visibleRows / rowsPerCol))
		self.ScrollBar.Thumb:SetHeight(thumbH)
		self.ScrollBar.Thumb:ClearAllPoints()
		self.ScrollBar.Thumb:SetPoint("TOP", self.ScrollBar, "TOP", 0, 0)
	elseif self.ScrollBar then
		self.ScrollBar:Hide()
	end

	self:SetSize(listWidth + scrollBarPad, math.max(visibleH, rowFrameH + K.DROPLIST_LIST_PAD_T + K.DROPLIST_LIST_PAD_B))

	local dropWidget = self:GetParent()
	self.DropParent = dropWidget
	self:SetParent(UIParent)
	self:SetFrameStrata("FULLSCREEN_DIALOG")
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", dropWidget.BgAtlas or dropWidget, "BOTTOMLEFT", 0, K.DROPLIST_LIST_GAP)

	self:EnableMouseWheel(rowsPerCol > maxVisPerCol)
	self:SetScript("OnMouseWheel", function(sf, delta)
		if sf.MaxScroll <= 0 then return end
		sf.ScrollOffset = math.max(0, math.min(sf.MaxScroll, sf.ScrollOffset - delta * dropListRowHeight * 2))
		DropList_UpdateScroll(sf)
	end)
end

Mixins.functions.DropListRow = {}
function Mixins.functions.DropListRow.Init(self, parent, rowdata)--, id)
	local container = parent.Content or parent
	self:SetParent(container)
	self.Parent = parent
	self.RowData = rowdata
	local widthExtra = 0
	local t, v = parent.Data[self:GetID()].text, parent.Data[self:GetID()].value
	if parent.Data == ListData.Fonts then
		local f = Ns.LSM:Fetch("font", v)
		self.Text:SetFont(f, 15)
		if select(1, self.Text:GetFont()) ~= f then
			widthExtra = 60
		end
	else
		self.Text:SetFont(Ns.ConfigDefaultFont2, 12)
	end
	if parent.Data == ListData.BarTextures then
		if not self.BarSwatch then
			self.BarSwatch = self:CreateTexture(nil, "ARTWORK")
			self.BarSwatch:SetHeight(dropListRowHeight - 4)
		end
		self.BarSwatch:SetTexture(Ns.LSM:Fetch("statusbar", v))
		self.BarSwatch:SetVertexColor(0.65, 0.65, 0.65)
		self.BarSwatch:ClearAllPoints()
		self.BarSwatch:SetPoint("LEFT", self, "LEFT", 2, 0)
		self.BarSwatch:SetWidth(60)
		self.BarSwatch:Show()
		self.Text:SetPoint("LEFT", self.BarSwatch, "RIGHT", 4, 0)
		widthExtra = 66
	elseif self.BarSwatch then
		self.BarSwatch:Hide()
		self.Text:SetPoint("LEFT")
	end
	self.Text:SetText(t)
	self:Show()
	return self.Text:GetWidth() + widthExtra
end

Mixins.scripts.DropListRow = {}
function Mixins.scripts.DropListRow.OnClick(self)
	PlayOnCheck()
	local list = self.Parent
	local value = self.RowData.value
	local text = self.RowData.text
	local settings = list.Settings
	local key = list.Key
	local isCopyList = list.IsCopyList
	local isDeleteList = list.IsDeleteList
	local isSpecList = list.IsSpecList
	local isPanelSelect = list.IsPanelSelect
	local specIndex = list.SpecIndex

	local dropWidget = list.DropParent or list:GetParent()
	dropWidget:SetText(text)
	list:Hide()

	local profileFrame = dropWidget:GetParent()
	if profileFrame and profileFrame.RunAction then
		if isCopyList then
			profileFrame.CopySourceProfile = value
			profileFrame:RunAction("copyselect")
		elseif isDeleteList then
			profileFrame.DeleteTargetProfile = value
			profileFrame:RunAction("deleteselect")
		elseif isSpecList then
			if not SinStatsDB.specProfiles then SinStatsDB.specProfiles = {} end
			if not SinStatsDB.specProfiles[Ns.ProfileKey] then SinStatsDB.specProfiles[Ns.ProfileKey] = {} end
			SinStatsDB.specProfiles[Ns.ProfileKey][specIndex] = value
			-- auto-switch active spec
			local currentSpec = GetSpecialization and GetSpecialization()
			if currentSpec and currentSpec == specIndex then
				Ns:OnSpecChanged()
				if profileFrame.CurrentProfileText then
					profileFrame.CurrentProfileText:SetText(format("%s: %s", L["CurrentProfile"], SinStatsDB.profileKeys[Ns.ProfileKey]))
				end
			end
		elseif isPanelSelect then
			profileFrame.SelectedPanel = value
			profileFrame:RunAction("select")
		else
			settings[key] = value
			profileFrame:RunAction("select")
		end
		return
	end
	settings[key] = value
	if dropWidget.MyInformation and dropWidget.MyInformation.onchange then
		Ns[dropWidget.MyInformation.onchange](dropWidget, key, settings, dropWidget.MyInformation)
	end
	Ns:QueueProfileRefresh()
end

function Mixins.scripts.DropListRow.OnEnter(self)
	local dropListFrame = self.Parent.DropParent or self.Parent:GetParent()
	OnEnterFunc(dropListFrame)
end

function Mixins.scripts.DropListRow.OnLeave(self)
	local dropListFrame = self.Parent.DropParent or self.Parent:GetParent()
	dropListFrame:GetScript("OnLeave")(dropListFrame)
end

function Mixins.scripts.DropListRow.OnMouseWheel(self, delta)
	local list = self.Parent
	if list and list:GetScript("OnMouseWheel") then
		list:GetScript("OnMouseWheel")(list, delta)
	end
end

------------------------------------------
--			Main Menu Button			--
------------------------------------------
function W.MainMenuButton(parent, width)
	local f = CreateFrame("Button", nil, parent)
	f.SpecialType = "MainMenuButton"
	f.NoResize = true
	Mixin(f, Mixins.functions.MainMenuButton)

	-- Separate icon texture (independent size from text)
	f.Icon = f:CreateTexture(nil, "ARTWORK")
	f.Icon:SetSize(17, 17)
	f.Icon:SetPoint("LEFT", f, "LEFT", 0, 0)

	AddLabel(f)
	f.Label:SetPoint("LEFT", f.Icon, "RIGHT", 4, 0)
	f:SetJustifyH("LEFT")
	local secTex = K.MAIN_MENU_SECTION_TEX ~= "" and K.MAIN_MENU_SECTION_TEX or Ns.TexturePath.."HighlightMenu"
	f:SetNormalTexture(secTex)
	f:GetNormalTexture():SetAlpha(0)
	f:SetHighlightTexture(secTex)
	if K.MAIN_MENU_SECTION_TEX_W > 0 then
		f:GetNormalTexture():SetWidth(K.MAIN_MENU_SECTION_TEX_W)
		f:GetHighlightTexture():SetWidth(K.MAIN_MENU_SECTION_TEX_W)
	end
	if K.MAIN_MENU_SECTION_TEX_H > 0 then
		f:GetNormalTexture():SetHeight(K.MAIN_MENU_SECTION_TEX_H)
		f:GetHighlightTexture():SetHeight(K.MAIN_MENU_SECTION_TEX_H)
	end
	if K.MAIN_MENU_SECTION_HIGHLIGHT_Y ~= 0 then
		local nt = f:GetNormalTexture()
		local ht = f:GetHighlightTexture()
		nt:ClearAllPoints()
		ht:ClearAllPoints()
		nt:SetPoint("LEFT",  f, "LEFT",  0, K.MAIN_MENU_SECTION_HIGHLIGHT_Y)
		nt:SetPoint("RIGHT", f, "RIGHT", 0, K.MAIN_MENU_SECTION_HIGHLIGHT_Y)
		ht:SetPoint("LEFT",  f, "LEFT",  0, K.MAIN_MENU_SECTION_HIGHLIGHT_Y)
		ht:SetPoint("RIGHT", f, "RIGHT", 0, K.MAIN_MENU_SECTION_HIGHLIGHT_Y)
		if K.MAIN_MENU_SECTION_TEX_H > 0 then
			nt:SetHeight(K.MAIN_MENU_SECTION_TEX_H)
			ht:SetHeight(K.MAIN_MENU_SECTION_TEX_H)
		end
	end
	f.Collapsed = true
	f:SetSize(width, MainMenuButtonHeight)
	for k, v in pairs(Mixins.scripts.MainMenuButton) do
		f:SetScript(k, v)
	end
	return f
end

local function ApplyMainMenuStatIconStyle(icon, state)
	if not icon then return end
	local desat = state == "idle" and K.MAIN_MENU_STAT_ICON_IDLE_DESATURATED or K.MAIN_MENU_STAT_ICON_DESATURATED
	icon:SetDesaturated(desat)
	icon:SetVertexColor(K.MAIN_MENU_STAT_ICON_R, K.MAIN_MENU_STAT_ICON_G, K.MAIN_MENU_STAT_ICON_B, 1)
end

local function ApplyStatHeaderFade(texture)
	if not texture then return end
	local rightAlpha = K.STAT_HEADER_BG_ALPHA or 1
	local leftAlpha = rightAlpha * (K.STAT_HEADER_FADE_LEFT_ALPHA or 0)
	texture:SetAlpha(1)
	texture:SetGradient("HORIZONTAL", CreateColor(1, 1, 1, leftAlpha), CreateColor(1, 1, 1, rightAlpha))
end

function Ns.GetMainMenuDecoGradientAlphas(state)
	local opaqueAlpha, fadedAlpha
	if state == "hover" then
		opaqueAlpha = K.LEFT_DECO_BG_HOVER_ALPHA or 0
		fadedAlpha = K.LEFT_DECO_BG_HOVER_FADE_OPACITY or 0
	elseif state == "select" then
		opaqueAlpha = K.LEFT_DECO_BG_SELECT_ALPHA or 0
		fadedAlpha = K.LEFT_DECO_BG_SELECT_FADE_OPACITY or 0
	else
		opaqueAlpha = K.LEFT_DECO_BG_ALPHA or 0
		fadedAlpha = K.LEFT_BG_FADE_OPACITY or 0
	end

	fadedAlpha = math.min(fadedAlpha, opaqueAlpha)
	if K.LEFT_BG_FADE_LTR then
		return opaqueAlpha, fadedAlpha
	end
	return fadedAlpha, opaqueAlpha
end

Mixins.functions.MainMenuButton = {}
function Mixins.functions.MainMenuButton.ApplyStatLayout(self)
	if not self.Icon or not self.Label then return end

	self.Icon:ClearAllPoints()
	if K.MAIN_MENU_STAT_ICON_SIDE == "RIGHT" then
		self.Icon:SetPoint("RIGHT", self, "RIGHT", -K.MAIN_MENU_STAT_ICON_X, K.MAIN_MENU_STAT_ICON_Y)
	else
		self.Icon:SetPoint("LEFT", self, "LEFT", K.MAIN_MENU_STAT_ICON_X, K.MAIN_MENU_STAT_ICON_Y)
	end

	self.Label:ClearAllPoints()
	if self.Icon:GetTexture() and self.Icon:GetWidth() > 0 and self.Icon:GetHeight() > 0 then
		if K.MAIN_MENU_STAT_ICON_SIDE == "RIGHT" then
			self.Label:SetPoint("LEFT", self, "LEFT", 4 + K.MAIN_MENU_STAT_TEXT_X_OFFSET, K.MAIN_MENU_STAT_TEXT_Y_OFFSET)
		else
			self.Label:SetPoint("LEFT", self.Icon, "RIGHT", 4 + K.MAIN_MENU_STAT_TEXT_X_OFFSET, K.MAIN_MENU_STAT_TEXT_Y_OFFSET)
		end
	else
		self.Label:SetPoint("LEFT", self, "LEFT", 4 + K.MAIN_MENU_STAT_TEXT_X_OFFSET, K.MAIN_MENU_STAT_TEXT_Y_OFFSET)
	end

	self:SetFontSize(K.MAIN_MENU_STAT_TEXT_SIZE)
end

function Mixins.functions.MainMenuButton.Collapse(self)
	if self.Collapsed then
		return
	end
	self.Collapsed = true
	if self.SelectGlow then
		self.SelectGlow:SetAlpha(0)
		local _ht = self:GetHighlightTexture()
		if _ht then _ht:SetAlpha(K.MAIN_MENU_STAT_HOVER_A or 1) end
	else
		self:GetNormalTexture():SetAlpha(0)
	end
	if self.StatBgTex then
		local startA, endA = Ns.GetMainMenuDecoGradientAlphas("idle")
		self.StatBgTex:SetGradient("HORIZONTAL", CreateColor(1, 1, 1, startA), CreateColor(1, 1, 1, endA))
	end

	if self.IsStatSection then
		ApplyMainMenuStatIconStyle(self.Icon, "idle")
		self.Icon:SetAlpha(K.MAIN_MENU_STAT_ICON_IDLE_ALPHA)
		self.Label:SetTextColor(K.MAIN_MENU_STAT_TEXT_R, K.MAIN_MENU_STAT_TEXT_G, K.MAIN_MENU_STAT_TEXT_B, K.MAIN_MENU_STAT_TEXT_A)
	else
		self.Label:SetTextColor(K.MAIN_MENU_SECTION_TEXT_R, K.MAIN_MENU_SECTION_TEXT_G, K.MAIN_MENU_SECTION_TEXT_B, K.MAIN_MENU_SECTION_TEXT_A)
	end
	local configFrame = self:GetParent()
	if configFrame.MainMenuSelected.Anchor then
		Ns:KillWidget(configFrame.MainMenuSelected.Anchor)
		configFrame.MainMenuSelected.Anchor = nil
	end
	configFrame.MainMenuSelected = nil
end

function Mixins.functions.MainMenuButton.Expand(self)
	if not self.Collapsed then
		return
	end
	self.Collapsed = false
	if self.SelectGlow then
		self.SelectGlow:SetAlpha(K.MAIN_MENU_STAT_SELECT_A or 1)
		local _ht = self:GetHighlightTexture()
		if _ht then _ht:SetAlpha(0) end
	else
		self:GetNormalTexture():SetAlpha(1)
	end
	if self.StatBgTex then
		local startA, endA = Ns.GetMainMenuDecoGradientAlphas("select")
		self.StatBgTex:SetGradient("HORIZONTAL", CreateColor(1, 1, 1, startA), CreateColor(1, 1, 1, endA))
	end
	-- Apply selected icon alpha
	if self.IsStatSection then
		ApplyMainMenuStatIconStyle(self.Icon, "select")
		self.Icon:SetAlpha(K.MAIN_MENU_STAT_ICON_SELECT_ALPHA)
		self.Label:SetTextColor(K.MAIN_MENU_STAT_SELECT_TEXT_R, K.MAIN_MENU_STAT_SELECT_TEXT_G, K.MAIN_MENU_STAT_SELECT_TEXT_B, K.MAIN_MENU_STAT_SELECT_TEXT_A)
	else
		self.Label:SetTextColor(K.MAIN_MENU_SECTION_SELECT_TEXT_R, K.MAIN_MENU_SECTION_SELECT_TEXT_G, K.MAIN_MENU_SECTION_SELECT_TEXT_B, K.MAIN_MENU_SECTION_SELECT_TEXT_A)
	end
	local configFrame = self:GetParent()
	configFrame.MainMenuSelected = self
	if not self.DisplayFunc then
		print("|cffff0000SinStats: No display function supplied for Main Menu item:", self.MyInformation.stat.."!")
		return
	end
	Ns.ConfigFrame.MainAnchor = Ns:GetWidget("AnchorFrame", configFrame)
	local hideSectionHeader = K.HIDE_MAIN_MENU_SECTION_HEADERS and not self.IsStatSection
	local headerIconPath
	if not self.IsStatSection then
		if not hideSectionHeader then
			headerIconPath = Ns:GetSpellIcon(self.MyInformation, Ns.IgnoreFormat)
			if headerIconPath and headerIconPath ~= "" then
				local hi = Ns.ConfigFrame.MainAnchor.HeaderIcon
				hi:SetTexture(headerIconPath)
				hi:SetDesaturated(K.MAIN_MENU_SECTION_ICON_DESATURATED)
				hi:SetVertexColor(K.MAIN_MENU_SECTION_ICON_R, K.MAIN_MENU_SECTION_ICON_G, K.MAIN_MENU_SECTION_ICON_B, K.MAIN_MENU_SECTION_ICON_A)
				hi:ClearAllPoints()
				hi:SetPoint("RIGHT", Ns.ConfigFrame.MainAnchor.Label, "LEFT", -K.MAIN_MENU_SECTION_ICON_TEXT_GAP, 0)
				hi:Show()
			end
		end
		Ns.ConfigFrame.MainAnchor:SetLabel(hideSectionHeader and "" or (L[self.MyInformation.stat] or self.MyInformation.stat))
	else
		if Ns.ConfigFrame.MainAnchor.HeaderIcon then
			Ns.ConfigFrame.MainAnchor.HeaderIcon:Hide()
		end
		Ns.ConfigFrame.MainAnchor:SetLabel(format(Ns.WidgetDisplayFormat, self.HeaderIconStr or Ns:GetSpellIcon(self.MyInformation), (L[self.MyInformation.stat])))
	end
	if not hideSectionHeader then
		Ns.ConfigFrame.MainAnchor:SetFontSize(16)
		if K.STAT_HEADER_USE_MORPHEUS then
			local morpheus = Ns.LSM:Fetch("font", "Morpheus")
			if morpheus then
				Ns.ConfigFrame.MainAnchor.Label:SetFont(morpheus, K.STAT_HEADER_FONT_SIZE)
			end
		end
		Ns.ConfigFrame.MainAnchor:SetTextColor(1,1,1)
		Ns.ConfigFrame.MainAnchor.Description:SetText(L[self.MyInformation.stat.."Description"])
	else
		Ns.ConfigFrame.MainAnchor.Description:SetText("")
	end
	Ns.ConfigFrame.MainAnchor.CenterAlign = self.MyInformation.centeralign
	local hdrBtn = Ns.ConfigFrame.MainAnchor.HeaderButton
	if hdrBtn then
		if not hideSectionHeader and K.STAT_HEADER_BUTTON_TEX ~= "" then
			hdrBtn:SetTexture(K.STAT_HEADER_BUTTON_TEX)
			hdrBtn:SetVertexColor(K.STAT_HEADER_BUTTON_R, K.STAT_HEADER_BUTTON_G, K.STAT_HEADER_BUTTON_B, K.STAT_HEADER_BUTTON_A)
			if K.STAT_HEADER_BUTTON_DESATURATED and hdrBtn.SetDesaturated then
				hdrBtn:SetDesaturated(true)
			end
			local hi = Ns.ConfigFrame.MainAnchor.HeaderIcon
			local leftAnchor = (hi and hi:IsShown()) and hi or Ns.ConfigFrame.MainAnchor.Label
			hdrBtn:ClearAllPoints()
			hdrBtn:SetPoint("TOPLEFT",     leftAnchor, "TOPLEFT",     -K.STAT_HEADER_BUTTON_PAD_L,  K.STAT_HEADER_BUTTON_PAD_T)
			hdrBtn:SetPoint("BOTTOMRIGHT", Ns.ConfigFrame.MainAnchor.Label, "BOTTOMRIGHT", K.STAT_HEADER_BUTTON_PAD_R, -K.STAT_HEADER_BUTTON_PAD_B)
			hdrBtn:Show()
		else
			hdrBtn:Hide()
		end
	end
	self.DisplayFunc(self, Ns.ConfigFrame.MainAnchor, Ns.TopAnchor, true, nil, self.NextDisplayOrder.ignoretoptabs)
	Ns.ConfigFrame.MainAnchor:Show()
	local hdrBg = Ns.ConfigFrame.StatHeaderBg
	if hdrBg then
		if not hideSectionHeader and self.HeaderTex and self.HeaderTex ~= "" then
			hdrBg:SetTexture(self.HeaderTex)
			ApplyStatHeaderFade(hdrBg)
			hdrBg:Show()
		else
			hdrBg:Hide()
		end
	end
end

Mixins.scripts.MainMenuButton = {}
function Mixins.scripts.MainMenuButton.OnEnter(self)
	if self.StatBgTex then
		local startA, endA = Ns.GetMainMenuDecoGradientAlphas("hover")
		self.StatBgTex:SetGradient("HORIZONTAL", CreateColor(1, 1, 1, startA), CreateColor(1, 1, 1, endA))
	end
	if self.IsStatSection then
		ApplyMainMenuStatIconStyle(self.Icon, "hover")
		self.Icon:SetAlpha(K.MAIN_MENU_STAT_ICON_HOVER_ALPHA)
		self.Label:SetTextColor(K.MAIN_MENU_STAT_HOVER_TEXT_R, K.MAIN_MENU_STAT_HOVER_TEXT_G, K.MAIN_MENU_STAT_HOVER_TEXT_B, K.MAIN_MENU_STAT_HOVER_TEXT_A)
	else
		self.Label:SetTextColor(K.MAIN_MENU_SECTION_HOVER_TEXT_R, K.MAIN_MENU_SECTION_HOVER_TEXT_G, K.MAIN_MENU_SECTION_HOVER_TEXT_B, K.MAIN_MENU_SECTION_HOVER_TEXT_A)
	end
end

function Mixins.scripts.MainMenuButton.OnLeave(self)
	if self.Collapsed then

		if self.StatBgTex then
			local startA, endA = Ns.GetMainMenuDecoGradientAlphas("idle")
			self.StatBgTex:SetGradient("HORIZONTAL", CreateColor(1, 1, 1, startA), CreateColor(1, 1, 1, endA))
		end
		if self.IsStatSection then
			ApplyMainMenuStatIconStyle(self.Icon, "idle")
			self.Icon:SetAlpha(K.MAIN_MENU_STAT_ICON_IDLE_ALPHA)
			self.Label:SetTextColor(K.MAIN_MENU_STAT_TEXT_R, K.MAIN_MENU_STAT_TEXT_G, K.MAIN_MENU_STAT_TEXT_B, K.MAIN_MENU_STAT_TEXT_A)
		else
			self.Label:SetTextColor(K.MAIN_MENU_SECTION_TEXT_R, K.MAIN_MENU_SECTION_TEXT_G, K.MAIN_MENU_SECTION_TEXT_B, K.MAIN_MENU_SECTION_TEXT_A)
		end
	else

		if self.StatBgTex then
			local startA, endA = Ns.GetMainMenuDecoGradientAlphas("select")
			self.StatBgTex:SetGradient("HORIZONTAL", CreateColor(1, 1, 1, startA), CreateColor(1, 1, 1, endA))
		end
		if self.IsStatSection then
			ApplyMainMenuStatIconStyle(self.Icon, "select")
			self.Icon:SetAlpha(K.MAIN_MENU_STAT_ICON_SELECT_ALPHA)
			self.Label:SetTextColor(K.MAIN_MENU_STAT_SELECT_TEXT_R, K.MAIN_MENU_STAT_SELECT_TEXT_G, K.MAIN_MENU_STAT_SELECT_TEXT_B, K.MAIN_MENU_STAT_SELECT_TEXT_A)
		else
			self.Label:SetTextColor(K.MAIN_MENU_SECTION_SELECT_TEXT_R, K.MAIN_MENU_SECTION_SELECT_TEXT_G, K.MAIN_MENU_SECTION_SELECT_TEXT_B, K.MAIN_MENU_SECTION_SELECT_TEXT_A)
		end
	end
end

function Mixins.scripts.MainMenuButton.OnClick(self)
	PlayOnTab()
	local configFrame = self:GetParent()
	if  configFrame.MainMenuSelected and configFrame.MainMenuSelected == self then
		return
	end
	if  configFrame.MainMenuSelected and configFrame.MainMenuSelected ~= self then
		KillPage("MainAnchor")
		KillPage("ChildAnchor")
		configFrame.MainMenuSelected:Collapse()
	end
	if self.Collapsed then
		self:Expand()
	else
		self:Collapse()
	end
end

function Mixins.functions.MainMenuButton.Refresh(self)
	if self.Collapsed then return end
	KillPage("MainAnchor")
	KillPage("ChildAnchor")
	self:Collapse()
	self:Expand()
end

--------------------------------------
--			Panel Switcher			--
--------------------------------------

function W.PanelSwitcher(parent)
	local f = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
	f.SpecialType = "PanelSwitcher"
	local _psW = K.PANEL_SWITCHER_W > 0 and K.PANEL_SWITCHER_W or 140
	local _psH = K.PANEL_SWITCHER_H > 0 and K.PANEL_SWITCHER_H or 20
	f:SetSize(_psW, _psH)
	f:SetBackdrop({ bgFile = K.PANEL_SWITCHER_BAR_TEX ~= "" and K.PANEL_SWITCHER_BAR_TEX or "Interface/BUTTONS/WHITE8X8" })
	f:SetBackdropColor(0.27451, 0.27451, 0.27451, 0.3)
	if Ns.PP then Ns.PP.CreateBorder(f, 0, 0, 0, 1, 1) end

	f.Label = f:CreateFontString(nil, "OVERLAY")
	f.Label:SetFont(Ns.ConfigDefaultFont2, 10)
	f.Label:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 2)
	f.Label:SetTextColor(1, 1, 1, 0.7)
	f.Label:SetText(L["PanelCurrent"] or "Active HUD")

	f.Text = f:CreateFontString(nil, "OVERLAY")
	f.Text:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4)
	f.Text:SetJustifyH("LEFT")
	f.Text:SetPoint("TOPLEFT", 4, -4)
	f.Text:SetPoint("BOTTOMRIGHT", -18, 2)

	f.Arrow = f:CreateTexture(nil, "OVERLAY")
	f.Arrow:SetSize(15, 15)
	f.Arrow:SetPoint("RIGHT", -4, 0)
	f.Arrow:SetTexture(K.PANEL_SWITCHER_ARROW_TEX ~= "" and K.PANEL_SWITCHER_ARROW_TEX or Ns.TexturePath .. "DropNormal")
	f.Arrow:SetVertexColor(orangeColor.r, orangeColor.g, orangeColor.b, 0.6)

	-- Dropdown list
	f.List = CreateFrame("Frame", nil, f, BackdropTemplateMixin and "BackdropTemplate")
	f.List:SetBackdrop({ bgFile = K.PANEL_SWITCHER_LIST_TEX ~= "" and K.PANEL_SWITCHER_LIST_TEX or "Interface/BUTTONS/WHITE8X8" })
	f.List:SetBackdropColor(0.150, 0.150, 0.150, 1)
	if Ns.PP then Ns.PP.CreateBorder(f.List, 0, 0, 0, 0.3, 1) end
	f.List:SetFrameStrata("FULLSCREEN_DIALOG")
	f.List:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, K.DROPLIST_LIST_GAP)
	f.List:Hide()
	f.List.Buttons = {}

	local function BuildList()
		for _, btn in ipairs(f.List.Buttons) do btn:Hide() end
		if not Ns.ProfileRoot or not Ns.ProfileRoot.PanelOrder then return end
		local rowH = 18
		local widest = 0
		for i, pName in ipairs(Ns.ProfileRoot.PanelOrder) do
			local btn = f.List.Buttons[i]
			if not btn then
				btn = CreateFrame("Button", nil, f.List)
				btn:SetHeight(rowH)
				local _psHL = K.PANEL_SWITCHER_LIST_HIGHLIGHT ~= "" and K.PANEL_SWITCHER_LIST_HIGHLIGHT or Ns.TexturePath .. "HighlightMenu"
				btn:SetHighlightTexture(_psHL)
				btn.Text = btn:CreateFontString(nil, "OVERLAY")
				btn.Text:SetFont(Ns.ConfigDefaultFont2, 11)
				btn.Text:SetJustifyH("LEFT")
				btn.Text:SetPoint("LEFT", 4, 0)
				btn.Text:SetPoint("RIGHT", -4, 0)
				f.List.Buttons[i] = btn
			end
			btn.value = pName
			btn.Text:SetText(pName)
			if pName == Ns.ProfileRoot.ActivePanel then
				btn.Text:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
			else
				btn.Text:SetTextColor(1, 1, 1)
			end
			btn:SetPoint("TOPLEFT", 1, -(i - 1) * rowH - 1)
			btn:SetPoint("TOPRIGHT", -1, -(i - 1) * rowH - 1)
			local tw = btn.Text:GetStringWidth() + 12
			if tw > widest then widest = tw end
			btn:SetScript("OnClick", function(self)
				local target = self.value
				if target and target ~= Ns.ProfileRoot.ActivePanel and Ns.ProfileRoot.Panels[target] then
					Ns.ProfileRoot.ActivePanel = target
					Ns.Profile = Ns.ProfileRoot.Panels[target]
					Ns:UpdateProfile()
					Ns:InitialiseAllPanels()
					f.Text:SetText(target)
					local sel = Ns.ConfigFrame and Ns.ConfigFrame.MainMenuSelected
					if sel and not sel.Collapsed then
						if Ns.ConfigFrame.MainAnchor then
							Ns:KillWidget(Ns.ConfigFrame.MainAnchor)
							Ns.ConfigFrame.MainAnchor = nil
						end
						if Ns.ConfigFrame.ChildAnchor then
							Ns:KillWidget(Ns.ConfigFrame.ChildAnchor)
							Ns.ConfigFrame.ChildAnchor = nil
						end
						sel.Collapsed = true
						Ns.ConfigFrame.MainMenuSelected = nil
						sel:Expand()
					end
				end
				f.List:Hide()
			end)
			btn:Show()
		end
		local count = #Ns.ProfileRoot.PanelOrder
		local w = math.max(_psW, widest + 4)
		f.List:SetSize(w, count * rowH + 2)
	end

	f:EnableMouse(true)
	f:SetScript("OnMouseDown", function(self)
		if self.List:IsShown() then
			self.List:Hide()
		else
			BuildList()
			self.List:Show()
		end
	end)
	f.List:SetScript("OnHide", function(self) self:Hide() end)

	function f:Refresh()
		self.Text:SetText(Ns.ProfileRoot and Ns.ProfileRoot.ActivePanel or "Main")
	end

	return f
end

--------------------------------------
--			Minimap Button			--
--------------------------------------
function W.MinimapButton(parent) -- All the funcions to do Profiles
	local f = Ns:GetWidget("CheckBox", parent)
	f.SpecialType = "MinimapButton"
	Mixin(f, Mixins.functions.MinimapButton)
	return f
end

Mixins.functions.MinimapButton = {}
function Mixins.functions.MinimapButton.Init(self, anchorframe, parent)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Check.Settings = parent.SvTable[self.MyInformation.stat]
	self.Check.Key = "Show"
	self.Check:SetChecked(self.Check.Settings[self.Check.Key])
	self:SetLabel(GetLabelText(self.MyInformation.stat, self.MyInformation, true))
	self.Label:ClearAllPoints()
	self.Label:SetPoint("LEFT", self, "LEFT", 2, 4)
	self.Label:SetJustifyH("LEFT")
	self.Check:ClearAllPoints()
	self.Check:SetPoint("RIGHT", self, "RIGHT", -4, 0)
	self:SetWidth(self.Check:GetWidth() + self.Label:GetStringWidth() + 20)
	AdjustCheckTip(self, self.MyInformation.stat)
end

----------------------------------
--			Plain Button		--
----------------------------------
function W.PlainButton(parent, width)
	local f = CreateFrame("Button", nil, parent)
	f:SetSize(50, 25)
	f.SpecialType = "PlainButton"
	Mixin(f, Mixins.functions.PlainButton)
	AddLabel(f)
	f:AnchorLabel("CENTER")

	local bg = f:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetTexture(K.BUTTON_IDLE_TEX)
	SetButtonBgRest(f, 1, 1, 1, 1)
	f.BgTexture = bg
	f.RestTexturePath = K.BUTTON_IDLE_TEX
	f.PressedTexturePath = K.BUTTON_PRESSED_TEX

	f:SetScript("OnMouseDown", function(self)
		if not self:IsEnabled() then return end
		self.BgTexture:SetTexture(self.PressedTexturePath or K.BUTTON_PRESSED_TEX)
		if self.ApplyIconTextTextOffset then
			self:ApplyIconTextTextOffset(self.IconTextPressedY or self.IconTextBaseY or 0)
		end
	end)
	f:SetScript("OnMouseUp", function(self)
		if not self:IsEnabled() then return end
		self.BgTexture:SetTexture(self.RestTexturePath or K.BUTTON_IDLE_TEX)
		if self.ApplyIconTextTextOffset then
			self:ApplyIconTextTextOffset(self.IconTextBaseY or 0)
		end
		RestoreButtonBgRest(self)
	end)

	for k, v in pairs(Mixins.scripts.PlainButton) do
		f:HookScript(k, v)
	end
	return f
end

Mixins.functions.PlainButton = {}
function Mixins.functions.PlainButton.Init(self, anchorframe, parent)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.Key = self.MyInformation.stat
	self:SetLabel(GetLabelText(self.MyInformation.stat, self.MyInformation, true))
	self:SetWidth(self.Label:GetWidth() + 30)
	if self.Key == "ResetPosition" and ApplyIconTextButtonStyle then
		ApplyIconTextButtonStyle(self, {
			normalTex = K.HUD_RESET_BTN_TEX,
			pressedTex = K.HUD_RESET_BTN_PRESSED_TEX,
			highlightTex = K.HUD_RESET_BTN_HIGHLIGHT_TEX,
			highlightW = K.HUD_RESET_BTN_HIGHLIGHT_W,
			pressedTextYOffset = -1,
			w = K.HUD_RESET_BTN_W,
			h = K.HUD_RESET_BTN_H,
			x = K.HUD_RESET_BTN_X,
			y = K.HUD_RESET_BTN_Y,
		})
	end
end

function Mixins.functions.PlainButton.Reset(self)
	self.MyInformation = nil
	self:SetLabel("")
	self:SetWidth(10)
	self.BgTexture:ClearAllPoints()
	self.BgTexture:SetAllPoints()
	self.BgTexture:SetTexture(K.BUTTON_IDLE_TEX)
	self.RestTexturePath = K.BUTTON_IDLE_TEX
	self.PressedTexturePath = K.BUTTON_PRESSED_TEX
	self:SetHighlightTexture("")
	self:SetHitRectInsets(0, 0, 0, 0)
	self.Label:ClearAllPoints()
	self.Label:SetPoint("CENTER")
	self.ApplyIconTextTextOffset = nil
end

Mixins.scripts.PlainButton = {}
function Mixins.scripts.PlainButton.OnClick(self)
	self.Settings[self.Key] = true
	Ns:QueueProfileRefresh()
end

----------------------------------
--			Profiles			--
----------------------------------
local CurrentProfileFormat = "%s: %s"

local function FindInProfilekys(find)
	for k, v in pairs(SinStatsDB.profileKeys) do
		if v == find then
			return true
		end
	end
end

-- Return a list of "CharName-Realm" strings whose profileKey == profileName
local function GetCharactersUsingProfile(profileName)
	local chars = {}
	for charKey, pName in pairs(SinStatsDB.profileKeys) do
		if pName == profileName then
			tinsert(chars, charKey)
		end
	end
	sort(chars)
	return chars
end

local function ProfileDisableAll(self)
	-- select section
	self.SelectList:SetEnabled(true)
	self.LoadBtn:SetEnabled(false)
	-- create section
	self.CreateCopyBtn:SetEnabled(false)
	self.CreateDefaultBtn:SetEnabled(false)
	-- copy section
	self.CopyBtn:SetEnabled(false)
	self.CopyConfirmBtn:Hide()
	self.CopyCancelBtn:Hide()
	self.CopyBtn:Show()
	self.CopyWarning:SetText("")
	self.CopyWarning:Hide()
	-- delete section
	self.DeleteBtn:SetEnabled(false)
	self.DeleteConfirmBtn:Hide()
	self.DeleteCancelBtn:Hide()
	self.DeleteBtn:Show()
	self.DeleteWarning:SetText("")
	self.DeleteWarning:Hide()
	-- rename section
	self.RenameBtn:SetEnabled(false)
	-- status message
	self.StatusMessage:SetText("")
	self.StatusMessage:Hide()
end

local function ResetProfileConfig(self)
	UpdateProfiles()
	wipe(self.CurrentProfile)
	self.CurrentProfile[Ns.ProfileKey] = SinStatsDB.profileKeys[Ns.ProfileKey]
	self.SvTable = self.CurrentProfile
	self.Key = Ns.ProfileKey
	-- Refresh select droplist
	self.SelectList:Init(self, self)
	self.SelectList.Tip:Hide()
	-- Refresh copy‑from droplist
	self.CopyList:Init(self, self)
	self.CopyList.Tip:Hide()
	-- Refresh delete droplist
	self.DeleteList:Init(self, self)
	self.DeleteList.Tip:Hide()
	-- Refresh spec droplists
	if self.HasSpecProfiles then
		self:UpdateSpecSection()
	end
	self:RunAction("select")
end

Mixins.scripts.ProfileConfigButton = {}
function Mixins.scripts.ProfileConfigButton.OnClick(self)
	PlayOnTab()
	self:GetParent():RunAction(self.Action)
end

function Mixins.scripts.ProfileConfigButton.OnEnable(self)
	self:SetAlpha(1)
	RestoreButtonBgRest(self)
end

function Mixins.scripts.ProfileConfigButton.OnDisable(self)
	self:SetAlpha(0.5)
	self.BgTexture:SetVertexColor(topTabColor.r, topTabColor.g, topTabColor.b, 0.5)
end

ApplyIconTextButtonStyle = function(button, options)
	local textRegion = button and (button.Text or button.Label)
	if not button or not button.BgTexture or not textRegion then return end
	if not options or not options.normalTex or options.normalTex == "" then return end

	local iconW = (options.w and options.w > 0) and options.w or 14
	local iconH = (options.h and options.h > 0) and options.h or 14
	local iconX = options.x or 0
	local iconY = options.y or 0
	local textGap = options.textGap or 4
	local normalTex = options.normalTex
	local pressedTex = (options.pressedTex and options.pressedTex ~= "") and options.pressedTex or normalTex
	local labelText = textRegion:GetText() or ""
	local textW = (labelText ~= "") and math.ceil(textRegion:GetStringWidth()) or 0
	local contentW = iconW + ((textW > 0) and (textGap + textW + 2) or 0)
	local highlightW = contentW + (options.highlightW or 0)
	local textBaseY = options.textY or 0
	local pressedTextY = textBaseY + (options.pressedTextYOffset or 0)

	button.RestTexturePath = normalTex
	button.PressedTexturePath = pressedTex
	button.IconTextTextGap = textGap
	button.IconTextBaseY = textBaseY
	button.IconTextPressedY = pressedTextY

	button.ApplyIconTextTextOffset = function(self, yOffset)
		local region = self.Text or self.Label
		region:ClearAllPoints()
		region:SetPoint("LEFT", self.BgTexture, "RIGHT", self.IconTextTextGap or 4, yOffset or 0)
		region:SetWidth(textW + 2)
		region:SetJustifyH("LEFT")
	end

	button.BgTexture:ClearAllPoints()
	button.BgTexture:SetPoint("LEFT", button, "LEFT", iconX, iconY)
	button.BgTexture:SetSize(iconW, iconH)
	button.BgTexture:SetTexture(normalTex)
	button.BgTexture:SetVertexColor(1, 1, 1, 1)
	button.BgTexture:SetAlpha(1)

	button:ApplyIconTextTextOffset(textBaseY)

	button:SetHitRectInsets(iconX, button:GetWidth() - (iconX + highlightW), -iconY, iconY)

	if options.highlightTex and options.highlightTex ~= "" then
		button:SetHighlightTexture(options.highlightTex)
		local ht = button:GetHighlightTexture()
		if ht then
			ht:ClearAllPoints()
			ht:SetPoint("LEFT", button.BgTexture, "LEFT", 0, 0)
			ht:SetWidth(highlightW)
			ht:SetPoint("TOP", button, "TOP", 0, iconY)
			ht:SetPoint("BOTTOM", button, "BOTTOM", 0, iconY)
			ht:SetVertexColor(options.highlightR or 1, options.highlightG or 1, options.highlightB or 1, options.highlightA or 1)
		end
	else
		button:SetHighlightTexture("")
	end

	local pressedIconY = iconY + (pressedTextY - textBaseY)
	if pressedIconY ~= iconY then
		button._iconX = iconX
		button._iconY = iconY
		button._iconPressedY = pressedIconY
		button:HookScript("OnMouseDown", function(btn)
			if not btn:IsEnabled() then return end
			btn.BgTexture:ClearAllPoints()
			btn.BgTexture:SetPoint("LEFT", btn, "LEFT", btn._iconX, btn._iconPressedY)
			if btn.ApplyIconTextTextOffset then
				btn:ApplyIconTextTextOffset(textBaseY)
			end
		end)
		button:HookScript("OnMouseUp", function(btn)
			btn.BgTexture:ClearAllPoints()
			btn.BgTexture:SetPoint("LEFT", btn, "LEFT", btn._iconX, btn._iconY)
		end)
	end
end
Ns.buttonStyle = ApplyIconTextButtonStyle

local function AttachActiveHeaderBackground(parent, textRegion)
	if not parent or not textRegion then return nil end
	local padLeft = K.ACTIVE_HEADER_BG_PAD_LEFT or 28
	local padRight = K.ACTIVE_HEADER_BG_PAD_RIGHT or padLeft

	local bg = parent:CreateTexture(nil, "BACKGROUND", nil, 1)
	bg:ClearAllPoints()
	bg:SetPoint("TOPLEFT", textRegion, "TOPLEFT", -padLeft, 6)
	bg:SetPoint("BOTTOMRIGHT", textRegion, "BOTTOMRIGHT", padRight, -6)
	bg:SetTexture(K.ACTIVE_HEADER_BG_TEX)
	bg:SetVertexColor(K.ACTIVE_HEADER_BG_R, K.ACTIVE_HEADER_BG_G, K.ACTIVE_HEADER_BG_B, K.ACTIVE_HEADER_BG_A)
	bg:SetShown(K.ACTIVE_HEADER_BG_TEX ~= "")

	return bg
end

local function CreateProfileButton(self, label, action)
	local f = CreateFrame("Button", nil, self)
	f:SetSize(80, 26)
	f.Text = f:CreateFontString()
	f.Text:SetPoint("CENTER")
	f.Text:SetFont(Ns.ConfigDefaultFont2, 11)
	f.Text:SetJustifyH("CENTER")
	local bg = f:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetTexture(K.BUTTON_IDLE_TEX)
	SetButtonBgRest(f, 1, 1, 1, 1)
	f.BgTexture = bg
	f.RestTexturePath = K.BUTTON_IDLE_TEX
	f.PressedTexturePath = K.BUTTON_PRESSED_TEX
	f:SetScript("OnMouseDown", function(btn)
		if not btn:IsEnabled() then return end
		btn.BgTexture:SetTexture(btn.PressedTexturePath or K.BUTTON_PRESSED_TEX)
		if btn.ApplyIconTextTextOffset then
			btn:ApplyIconTextTextOffset(btn.IconTextPressedY or btn.IconTextBaseY or 0)
		end
	end)
	f:SetScript("OnMouseUp", function(btn)
		if not btn:IsEnabled() then return end
		btn.BgTexture:SetTexture(btn.RestTexturePath or K.BUTTON_IDLE_TEX)
		if btn.ApplyIconTextTextOffset then
			btn:ApplyIconTextTextOffset(btn.IconTextBaseY or 0)
		end
		RestoreButtonBgRest(btn)
	end)
	f.Text:SetText(label)
	f.Action = action
	for k, v in pairs(Mixins.scripts.ProfileConfigButton) do
		f:HookScript(k, v)
	end
	return f
end


function W.CreateImpExpEditBox(parent, w, h, bgR, bgG, bgB, bgA, anchorTo, anchor, x, y)
	local scroll = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
	scroll:SetSize(w, h)
	scroll:SetPoint("TOPLEFT", anchorTo, anchor, x, y)
	scroll.BG = scroll:CreateTexture(nil, "BACKGROUND", nil, -1)
	scroll.BG:SetPoint("TOPLEFT",     scroll, "TOPLEFT",     -K.DROPLIST_LIST_BG_INSET_L,  K.DROPLIST_LIST_BG_INSET_T)
	scroll.BG:SetPoint("BOTTOMRIGHT", scroll, "BOTTOMRIGHT",  K.DROPLIST_LIST_BG_INSET_R, -K.DROPLIST_LIST_BG_INSET_B)
	Ns:ApplyAtlasOrFallback(scroll.BG, "DropListListBg", function(t)
		t:SetColorTexture(0.15, 0.15, 0.15, 0.8)
	end)
	scroll.BG:SetVertexColor(bgR, bgG, bgB, bgA)
	local edit = CreateFrame("EditBox", nil, scroll, "InputBoxTemplate")
	edit:SetMultiLine(true)
	edit:SetMaxLetters(0)
	edit:SetFont(Ns.ConfigDefaultFont2, 10, "")
	edit:SetWidth(w)
	edit:SetTextInsets(4, 4, 4, 4)
	edit:SetAutoFocus(false)

	if edit.Left then edit.Left:Hide() end
	if edit.Right then edit.Right:Hide() end
	if edit.Middle then edit.Middle:Hide() end

	edit:SetScript("OnShow", function(self) self:ClearFocus() end)
	edit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	scroll:SetScrollChild(edit)
	scroll:SetScript("OnMouseDown", function() edit:SetFocus() end)
	return scroll, edit
end

function W.ProfileConfig(parent)
	local f = CreateFrame("Frame", "$parentProfiles", parent)
	f.SpecialType = "ProfileConfig"
	f:SetSize(500, 100)
	Mixin(f, Mixins.functions.ProfileConfig)

	ListData.Deafults = {}
	for k, v in pairs(Ns:GetClassDefaults()) do
		tinsert(ListData.Deafults, { text=k, value=v })
	end
	sort(ListData.Deafults, function(a, b) return a.text < b.text end)

	-- column offsets
	local rightCol = 400
	f._rightCol = rightCol
	local rowGap = K.PROFILE_ROW_GAP_Y or 80

	-- Hint text (below separator, above ACTIVE header)
	f.Hint = f:CreateFontString()
	f.Hint:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 5)
	f.Hint:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.Hint:SetPoint("TOP", 80, 2)
	f.Hint:SetText(L["ProfilesHint"])

	f.CurrentProfileText = f:CreateFontString()
	f.CurrentProfileText:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 2)
	f.CurrentProfileText:SetTextColor(1, 1, 1)
	f.CurrentProfileText:SetPoint("TOP", 80, -30)
	f.CurrentProfileText:SetJustifyH("CENTER")
	f.CurrentProfileTextBg = AttachActiveHeaderBackground(f, f.CurrentProfileText)

	-- Row 1 Y: labels at TOPLEFT
	local row1Y = -74

	f.SelectLabel = f:CreateFontString()
	f.SelectLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.SelectLabel:SetPoint("TOPLEFT", 0, row1Y)
	f.SelectLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.SelectLabel:SetJustifyH("LEFT")
	f.SelectLabel:SetText(L["ProfileSelectLabel"])

	f.CreateLabel = f:CreateFontString()
	f.CreateLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.CreateLabel:SetPoint("TOPLEFT", rightCol, row1Y)
	f.CreateLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.CreateLabel:SetJustifyH("LEFT")
	f.CreateLabel:SetText(L["NewProfile"])

	f.LoadBtn = CreateProfileButton(f, L["Selected"], "load")
	ApplyIconTextButtonStyle(f.LoadBtn, {
		normalTex = K.PROFILE_APPLY_BTN_TEX,
		pressedTex = K.PROFILE_APPLY_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_APPLY_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_APPLY_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_APPLY_BTN_W,
		h = K.PROFILE_APPLY_BTN_H,
		x = K.PROFILE_APPLY_BTN_X,
		y = K.PROFILE_APPLY_BTN_Y,
	})

	f.Edit = W.BaseEditBox(f, 240, 27)
	f.Edit:SetPoint("TOPLEFT", f.CreateLabel, "BOTTOMLEFT", 0, -4)
	f.Edit.Action = "edit"
	f.Edit:SetScript("OnTextChanged", function(self)
		self:GetParent():RunAction(self.Action)
	end)

	f.CreateCopyBtn = CreateProfileButton(f, L["ProfileCreateCopy"], "createcopy")
	f.CreateCopyBtn:SetSize(120, 26)
	f.CreateCopyBtn:SetPoint("TOPLEFT", f.Edit, "BOTTOMLEFT", 0, -4)
	ApplyIconTextButtonStyle(f.CreateCopyBtn, {
		normalTex = K.PROFILE_CREATE_BTN_TEX,
		pressedTex = K.PROFILE_CREATE_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_CREATE_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_CREATE_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_CREATE_BTN_W,
		h = K.PROFILE_CREATE_BTN_H,
		x = K.PROFILE_CREATE_BTN_X,
		y = K.PROFILE_CREATE_BTN_Y,
	})

	f.CreateDefaultBtn = CreateProfileButton(f, L["ProfileCreateDefault"], "createdefault")
	f.CreateDefaultBtn:SetSize(120, 26)
	f.CreateDefaultBtn:SetPoint("LEFT", f.CreateCopyBtn, "RIGHT", 10, 0)
	ApplyIconTextButtonStyle(f.CreateDefaultBtn, {
		normalTex = K.PROFILE_CREATE_BTN_TEX,
		pressedTex = K.PROFILE_CREATE_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_CREATE_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_CREATE_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_CREATE_BTN_W,
		h = K.PROFILE_CREATE_BTN_H,
		x = K.PROFILE_CREATE_BTN_X,
		y = K.PROFILE_CREATE_BTN_Y,
	})

	-- Row 2 Y: Rename (left) / Copy (right) — same Y
	local row2Y = row1Y - rowGap

	f.RenameLabel = f:CreateFontString()
	f.RenameLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.RenameLabel:SetPoint("TOPLEFT", rightCol, row2Y)
	f.RenameLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.RenameLabel:SetJustifyH("LEFT")
	f.RenameLabel:SetText(L["ProfileRenameLabel"] or "Rename Profile")

	f.CopyLabel = f:CreateFontString()
	f.CopyLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.CopyLabel:SetPoint("TOPLEFT", 0, row2Y)
	f.CopyLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.CopyLabel:SetJustifyH("LEFT")
	f.CopyLabel:SetText(L["ProfileCopyFrom"])

	f.RenameEdit = W.BaseEditBox(f, 240, 27)
	f.RenameEdit:SetPoint("TOPLEFT", f.RenameLabel, "BOTTOMLEFT", 0, -4)
	f.RenameEdit.Action = "editrename"
	f.RenameEdit:SetScript("OnTextChanged", function(self)
		self:GetParent():RunAction(self.Action)
	end)

	f.RenameBtn = CreateProfileButton(f, L["Rename"] or "Rename", "rename")
	f.RenameBtn:SetSize(120, 26)
	f.RenameBtn:SetPoint("TOPLEFT", f.RenameEdit, "BOTTOMLEFT", 0, -4)
	ApplyIconTextButtonStyle(f.RenameBtn, {
		normalTex = K.HUD_RENAME_BTN_TEX,
		pressedTex = K.HUD_RENAME_BTN_PRESSED_TEX,
		highlightTex = K.HUD_RENAME_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_RENAME_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_RENAME_BTN_W,
		h = K.HUD_RENAME_BTN_H,
		x = K.HUD_RENAME_BTN_X,
		y = K.HUD_RENAME_BTN_Y,
	})

	f.CopyBtn = CreateProfileButton(f, L["Copy"], "copy")
	ApplyIconTextButtonStyle(f.CopyBtn, {
		normalTex = K.PROFILE_COPY_BTN_TEX,
		pressedTex = K.PROFILE_COPY_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_COPY_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_COPY_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_COPY_BTN_W,
		h = K.PROFILE_COPY_BTN_H,
		x = K.PROFILE_COPY_BTN_X,
		y = K.PROFILE_COPY_BTN_Y,
	})

	f.CopyConfirmBtn = CreateProfileButton(f, L["ConfirmDelete"], "copyapply")
	ApplyIconTextButtonStyle(f.CopyConfirmBtn, {
		normalTex = K.PROFILE_CONFIRM_BTN_TEX,
		pressedTex = K.PROFILE_CONFIRM_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_CONFIRM_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_CONFIRM_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_CONFIRM_BTN_W,
		h = K.PROFILE_CONFIRM_BTN_H,
		x = K.PROFILE_CONFIRM_BTN_X,
		y = K.PROFILE_CONFIRM_BTN_Y,
	})
	f.CopyConfirmBtn:Hide()

	f.CopyCancelBtn = CreateProfileButton(f, L["Cancel"], "copycancel")
	ApplyIconTextButtonStyle(f.CopyCancelBtn, {
		normalTex = K.PROFILE_CANCEL_BTN_TEX,
		pressedTex = K.PROFILE_CANCEL_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_CANCEL_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_CANCEL_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_CANCEL_BTN_W,
		h = K.PROFILE_CANCEL_BTN_H,
		x = K.PROFILE_CANCEL_BTN_X,
		y = K.PROFILE_CANCEL_BTN_Y,
	})
	f.CopyCancelBtn:Hide()

	f.CopyWarning = f:CreateFontString()
	f.CopyWarning:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5)
	f.CopyWarning:SetPoint("TOPLEFT", f.CopyLabel, "BOTTOMLEFT", 0, -30)
	f.CopyWarning:SetJustifyH("LEFT")
	f.CopyWarning:Hide()

	-- Delete section: appears in row 3 alongside spec profiles
	f.DeleteBtn = CreateProfileButton(f, L["Delete"], "delete")
	f.DeleteBtn:SetSize(120, 26)
	ApplyIconTextButtonStyle(f.DeleteBtn, {
		normalTex = K.PROFILE_DELETE_BTN_TEX,
		pressedTex = K.PROFILE_DELETE_BTN_PRESSED_TEX,
		highlightTex = (K.PROFILE_DELETE_BTN_HIGHLIGHT_TEX ~= "" and K.PROFILE_DELETE_BTN_HIGHLIGHT_TEX)
			or (K.HUD_DELETE_CLOSE_TEX ~= "" and K.HUD_DELETE_CLOSE_TEX)
			or (K.PROFILE_DELETE_BTN_TEX ~= "" and K.PROFILE_DELETE_BTN_TEX)
			or (Ns.TexturePath .. "Close"),
		highlightR = 1,
		highlightG = 1,
		highlightB = 1,
		highlightA = 1,
		highlightW = K.PROFILE_DELETE_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_DELETE_BTN_W,
		h = K.PROFILE_DELETE_BTN_H,
		x = K.PROFILE_DELETE_BTN_X,
		y = K.PROFILE_DELETE_BTN_Y,
	})

	f.DeleteConfirmBtn = CreateProfileButton(f, L["ConfirmDelete"], "confirmdelete")
	f.DeleteConfirmBtn:SetSize(120, 26)
	ApplyIconTextButtonStyle(f.DeleteConfirmBtn, {
		normalTex = K.PROFILE_CONFIRM_BTN_TEX,
		pressedTex = K.PROFILE_CONFIRM_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_CONFIRM_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_CONFIRM_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_CONFIRM_BTN_W,
		h = K.PROFILE_CONFIRM_BTN_H,
		x = K.PROFILE_CONFIRM_BTN_X,
		y = K.PROFILE_CONFIRM_BTN_Y,
	})
	f.DeleteConfirmBtn:Hide()

	f.DeleteCancelBtn = CreateProfileButton(f, L["Cancel"], "deletecancel")
	f.DeleteCancelBtn:SetSize(120, 26)
	ApplyIconTextButtonStyle(f.DeleteCancelBtn, {
		normalTex = K.PROFILE_CANCEL_BTN_TEX,
		pressedTex = K.PROFILE_CANCEL_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_CANCEL_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_CANCEL_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_CANCEL_BTN_W,
		h = K.PROFILE_CANCEL_BTN_H,
		x = K.PROFILE_CANCEL_BTN_X,
		y = K.PROFILE_CANCEL_BTN_Y,
	})
	f.DeleteCancelBtn:Hide()

	f.DeleteWarning = f:CreateFontString()
	f.DeleteWarning:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5)
	f.DeleteWarning:SetJustifyH("LEFT")
	f.DeleteWarning:SetWidth(275)
	f.DeleteWarning:SetWordWrap(true)
	f.DeleteWarning:SetNonSpaceWrap(false)
	f.DeleteWarning:Hide()

	-- Row 3: Spec profiles (left) / Delete (right) — same Y
	local row3Y = row2Y - rowGap

	-- Delete label always exists (all versions)
	f.DeleteLabel = f:CreateFontString()
	f.DeleteLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.DeleteLabel:SetPoint("TOPLEFT", rightCol, row3Y)
	f.DeleteLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.DeleteLabel:SetJustifyH("LEFT")
	f.DeleteLabel:SetText(L["Delete"])

	-- spec profiles for retail and mists
	f.HasSpecProfiles = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) or (WOW_PROJECT_ID == 19)
	if f.HasSpecProfiles then
		f.SpecEnableCheck = CreateFrame("CheckButton", nil, f)
		f.SpecEnableCheck:SetSize(K.CHECKBOX_SIZE, K.CHECKBOX_SIZE)
		f.SpecEnableCheck:SetPoint("TOPLEFT", 0, row3Y)
		f.SpecEnableCheck:SetNormalTexture("")
		f.SpecEnableCheck:SetPushedTexture("")
		f.SpecEnableCheck:SetHighlightTexture("")
		f.SpecEnableCheck.FrameTex = f.SpecEnableCheck:CreateTexture(nil, "ARTWORK", nil, 0)
		f.SpecEnableCheck.FrameTex:SetAllPoints()
		f.SpecEnableCheck.FrameTex:SetTexture(K.CHECKBOX_FRAME_TEX)
		f.SpecEnableCheck.FrameTex:SetBlendMode("BLEND")
		f.SpecEnableCheck:SetCheckedTexture(K.CHECKBOX_CHECK_TEX)
		local specCheckTex = f.SpecEnableCheck:GetCheckedTexture()
		specCheckTex:SetBlendMode("BLEND")
		specCheckTex:SetVertexColor(K.CHECKBOX_CHECK_R, K.CHECKBOX_CHECK_G, K.CHECKBOX_CHECK_B, K.CHECKBOX_CHECK_A)
		if K.CHECKBOX_CHECK_DESATURATED then specCheckTex:SetDesaturated(true) end
		if K.CHECKBOX_CHECK_SIZE and K.CHECKBOX_CHECK_SIZE > 0 then
			specCheckTex:ClearAllPoints()
			specCheckTex:SetPoint("CENTER")
			specCheckTex:SetSize(K.CHECKBOX_CHECK_SIZE, K.CHECKBOX_CHECK_SIZE)
		end

		f.SpecEnableLabel = f:CreateFontString()
		f.SpecEnableLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
		f.SpecEnableLabel:SetPoint("LEFT", f.SpecEnableCheck, "RIGHT", 6, 0)
		f.SpecEnableLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
		f.SpecEnableLabel:SetText(L["SpecProfilesEnable"])

		f.SpecEnableTip = CreateFrame("Frame", nil, f)
		f.SpecEnableTip:SetSize(K.TOOLTIP_ICON_W, K.TOOLTIP_ICON_H)
		f.SpecEnableTip:SetPoint("LEFT", f.SpecEnableLabel, "RIGHT", 4, 0)
		f.SpecEnableTip.Texture = f.SpecEnableTip:CreateTexture()
		f.SpecEnableTip.Texture:SetAllPoints()
		f.SpecEnableTip.Texture:SetTexture(K.TOOLTIP_ICON_TEX ~= "" and K.TOOLTIP_ICON_TEX or (Ns.TexturePath.."Misc"))
		f.SpecEnableTip:SetScript("OnEnter", function(self)
			if not gttFont then
				gttFont, gttFontSize, gttFontFlags = GameTooltipHeaderText:GetFont()
			end
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
			GameTooltipHeaderText:SetFont(Ns.ConfigDefaultFont, 12, "")
			GameTooltip:SetText(L["SpecProfilesEnableTip"])
		end)
		f.SpecEnableTip:SetScript("OnLeave", function()
			GameTooltipHeaderText:SetFont(gttFont, gttFontSize, gttFontFlags)
			GameTooltip:Hide()
		end)

		f.SpecLists = {}
		f.SpecLabels = {}

		f.SpecEnableCheck:SetScript("OnClick", function(btn)
			PlayOnCheck()
			local checked = btn:GetChecked()
			if not SinStatsDB.specProfiles then SinStatsDB.specProfiles = {} end
			if not SinStatsDB.specProfiles[Ns.ProfileKey] then SinStatsDB.specProfiles[Ns.ProfileKey] = {} end
			SinStatsDB.specProfiles[Ns.ProfileKey].enabled = checked
			f:UpdateSpecSection()
			f:RunAction("select")
			if checked and GetSpecialization then
				Ns:OnSpecChanged()
				f.CurrentProfileText:SetText(format("%s: %s", L["CurrentProfile"], SinStatsDB.profileKeys[Ns.ProfileKey]))
			end
		end)
	end

	-- Spec list anchor: starts below the enable checkbox on row 3
	f.SpecListAnchorY = row3Y - 25
	f.SpecLists = {}
	f.SpecLabels = {}

	f.StatusMessage = f:CreateFontString()
	f.StatusMessage:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5)
	f.StatusMessage:SetPoint("TOPLEFT", 0, row3Y - 60 - rowGap)
	f.StatusMessage:SetJustifyH("LEFT")
	f.StatusMessage:Hide()

	function f.UpdateSpecSection(self)
		for i, dl in pairs(self.SpecLists) do
			if dl then Ns:KillWidget(dl); self.SpecLists[i] = nil end
		end
		for i, lbl in pairs(self.SpecLabels) do
			if lbl then lbl:Hide() end
		end

		if not self.HasSpecProfiles then return end

		local specData = SinStatsDB.specProfiles and SinStatsDB.specProfiles[Ns.ProfileKey]
		local enabled = specData and specData.enabled
		self.SpecEnableCheck:SetChecked(enabled and true or false)

		local numSpecs = GetNumSpecializations()
		local specYOfs = self.SpecListAnchorY
		for i = 1, numSpecs do
			local specName, specIcon
			if GetSpecializationInfo then
				_, specName, _, specIcon = GetSpecializationInfo(i)
			elseif GetSpecializationInfoForClassID then
				local _, classID = UnitClassBase("player")
				_, specName, _, specIcon = GetSpecializationInfoForClassID(classID, i)
			end
			specName = specName or ("Spec " .. i)
			if not self.SpecLabels[i] then
				self.SpecLabels[i] = self:CreateFontString()
				self.SpecLabels[i]:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
				self.SpecLabels[i]:SetJustifyH("LEFT")
			end
			self.SpecLabels[i]:ClearAllPoints()
			self.SpecLabels[i]:SetPoint("TOPLEFT", 0, specYOfs - 4)
			self.SpecLabels[i]:SetTextColor(1, 1, 1)
			local iconStr = specIcon and ("|T" .. specIcon .. ":20:20|t ") or ""
			self.SpecLabels[i]:SetText(iconStr .. format(L["SpecProfileLabel"], specName or ("Spec " .. i)))
			self.SpecLabels[i]:Show()

			self.SpecLists[i] = Ns:GetWidget("DropList", self, self:GetID())
			self.SpecLists[i]:SetParent(self)
			self.SpecLists[i]:ClearAllPoints()
			self.SpecLists[i]:SetPoint("TOPLEFT", 140, specYOfs)
			self.SpecLists[i]:Init(self, self)
			self.SpecLists[i].Tip:Hide()
			self.SpecLists[i]:Show()
			self.SpecLists[i]:SetEnabled(enabled and true or false)

			local specIndex = i
			if not SinStatsDB.specProfiles[Ns.ProfileKey] then SinStatsDB.specProfiles[Ns.ProfileKey] = {} end
			self.SpecLists[i].DropButton.Settings = SinStatsDB.specProfiles[Ns.ProfileKey]
			self.SpecLists[i].DropButton.Key = specIndex

			local savedProfile = SinStatsDB.specProfiles[Ns.ProfileKey][specIndex]
			if savedProfile and SinStatsDB.profiles[savedProfile] then
				self.SpecLists[i]:SetText(savedProfile)
			else
				local activeProfile = SinStatsDB.profileKeys[Ns.ProfileKey]
				SinStatsDB.specProfiles[Ns.ProfileKey][specIndex] = activeProfile
				self.SpecLists[i]:SetText(activeProfile)
			end

			self.SpecLists[i].DropButton:SetScript("OnClick", function(btn)
				PlayOnCheck()
				local listParent = btn:GetParent()
				if not listParent.List:IsShown() then
					listParent.List.MyInformation = btn.MyInformation
					listParent.List.Settings = btn.Settings
					listParent.List.Key = btn.Key
					listParent.List.Data = btn.Data
					listParent.List.IsSpecList = true
					listParent.List.SpecIndex = specIndex
				end
				listParent.List:SetShown(not listParent.List:IsShown())
			end)

			specYOfs = specYOfs - 28
		end
	end

	function f.RunAction(self, action)
		ProfileDisableAll(self)
		local newProfile = strtrim(self.Edit:GetText())

		if action == "load" then
			SinStatsDB.profileKeys[Ns.ProfileKey] = self.CurrentProfile[self.Key]
			Ns.ProfileRoot = SinStatsDB.profiles[SinStatsDB.profileKeys[Ns.ProfileKey]]
			Ns:MigrateToPanel(Ns.ProfileRoot)
			Ns.Profile = Ns.ProfileRoot.Panels[Ns.ProfileRoot.ActivePanel]
			Ns.NewSettings(Ns.ProfileRoot, Ns.Class)
			self.CurrentProfileText:SetText(format(CurrentProfileFormat, L["CurrentProfile"], SinStatsDB.profileKeys[Ns.ProfileKey]))
			ResetProfileConfig(self)
			Ns:UpdateProfile()
			local p = self:GetParent()
			if not p.PageAnchor then
				p = self:GetParent():GetParent():GetParent()
			end
			for k, v in pairs(p.PageAnchor.CurrentWidgets) do
				v.SvTable = v.Parent.SvTable
			end
			Ns:InitialiseProfile(Ns.Profile)
			return
		end

		if action == "select" then
			local specEnabled = self.HasSpecProfiles and SinStatsDB.specProfiles
				and SinStatsDB.specProfiles[Ns.ProfileKey]
				and SinStatsDB.specProfiles[Ns.ProfileKey].enabled
			if specEnabled then
				self.SelectList:SetEnabled(false)
				self.LoadBtn:SetEnabled(false)
			else
				if self.SvTable[self.Key] ~= SinStatsDB.profileKeys[Ns.ProfileKey] then
					self.LoadBtn:SetEnabled(true)
				end
			end
			return
		end

		if action == "edit" then
			if newProfile ~= "" and not SinStatsDB.profiles[newProfile] then
				self.CreateCopyBtn:SetEnabled(true)
				self.CreateDefaultBtn:SetEnabled(true)
			end
			return
		end

		if action == "createcopy" then
			if newProfile == "" or SinStatsDB.profiles[newProfile] then return end
			local sourceName = SinStatsDB.profileKeys[Ns.ProfileKey]
			SinStatsDB.profiles[newProfile] = {}
			Ns.CopyTable(SinStatsDB.profiles[sourceName], SinStatsDB.profiles[newProfile])
			UpdateProfiles()
			-- Switch to the new profile
			SinStatsDB.profileKeys[Ns.ProfileKey] = newProfile
			Ns.ProfileRoot = SinStatsDB.profiles[newProfile]
			Ns:MigrateToPanel(Ns.ProfileRoot)
			Ns.Profile = Ns.ProfileRoot.Panels[Ns.ProfileRoot.ActivePanel]
			Ns.NewSettings(Ns.ProfileRoot, Ns.Class)
			self.Edit:SetText("")
			self.CurrentProfileText:SetText(format(CurrentProfileFormat, L["CurrentProfile"], newProfile))
			ResetProfileConfig(self)
			self.StatusMessage:SetText(format(L["ProfileCreatedCopy"], Ns.Colors.Orange .. newProfile .. "|r", Ns.Colors.Orange .. sourceName .. "|r"))
			self.StatusMessage:Show()
			Ns:UpdateProfile()
			Ns:InitialiseProfile(Ns.Profile)
			return
		end

		if action == "createdefault" then
			if newProfile == "" or SinStatsDB.profiles[newProfile] then return end
			Ns:CreateProfile(newProfile, nil, Ns.Class)
			UpdateProfiles()
			-- Switch to the new profile
			SinStatsDB.profileKeys[Ns.ProfileKey] = newProfile
			Ns.ProfileRoot = SinStatsDB.profiles[newProfile]
			Ns:MigrateToPanel(Ns.ProfileRoot)
			Ns.Profile = Ns.ProfileRoot.Panels[Ns.ProfileRoot.ActivePanel]
			Ns.NewSettings(Ns.ProfileRoot, Ns.Class)
			self.Edit:SetText("")
			self.CurrentProfileText:SetText(format(CurrentProfileFormat, L["CurrentProfile"], newProfile))
			ResetProfileConfig(self)
			self.StatusMessage:SetText(format(L["ProfileCreatedDefault"], Ns.Colors.Orange .. newProfile .. "|r"))
			self.StatusMessage:Show()
			Ns:UpdateProfile()
			Ns:InitialiseProfile(Ns.Profile)
			return
		end

		if action == "copyselect" then
			local sourceProfile = self.CopySourceProfile
			if sourceProfile and SinStatsDB.profiles[sourceProfile] then
				self.CopyBtn:SetEnabled(true)
			end
			return
		end

		if action == "copy" then
			local sourceProfile = self.CopySourceProfile
			if not sourceProfile or not SinStatsDB.profiles[sourceProfile] then return end
			local currentName = SinStatsDB.profileKeys[Ns.ProfileKey]
			self.CopyWarning:SetText(format(L["ProfileCopyWarning"], Ns.Colors.Orange .. sourceProfile .. "|r", Ns.Colors.Orange .. currentName .. "|r"))
			self.CopyWarning:Show()
			self.CopyBtn:Hide()
			self.CopyConfirmBtn:Show()
			self.CopyCancelBtn:Show()
			return
		end

		if action == "copyapply" then
			local sourceProfile = self.CopySourceProfile
			if not sourceProfile or not SinStatsDB.profiles[sourceProfile] then return end
			local currentName = SinStatsDB.profileKeys[Ns.ProfileKey]
			wipe(SinStatsDB.profiles[currentName])
			Ns.CopyTable(SinStatsDB.profiles[sourceProfile], SinStatsDB.profiles[currentName])
			Ns.ProfileRoot = SinStatsDB.profiles[currentName]
			Ns:MigrateToPanel(Ns.ProfileRoot)
			Ns.Profile = Ns.ProfileRoot.Panels[Ns.ProfileRoot.ActivePanel]
			Ns.NewSettings(Ns.ProfileRoot, Ns.Class)
			ResetProfileConfig(self)
			self.StatusMessage:SetText(format(L["ProfileCopiedMsg"], Ns.Colors.Orange .. sourceProfile .. "|r", Ns.Colors.Orange .. currentName .. "|r"))
			self.StatusMessage:Show()
			Ns:UpdateProfile()
			Ns:InitialiseProfile(Ns.Profile)
			return
		end

		if action == "copycancel" then
			ProfileDisableAll(self)
			ResetProfileConfig(self)
			return
		end

		if action == "deleteselect" then
			local target = self.DeleteTargetProfile
			if target and target ~= "Default" and SinStatsDB.profiles[target] then
				self.DeleteBtn:SetEnabled(true)
			end
			return
		end

		if action == "delete" then
			local target = self.DeleteTargetProfile
			if not target or target == "Default" then return end
			local chars = GetCharactersUsingProfile(target)
			if #chars > 0 then
				local coloredChars = {}
				for _, c in ipairs(chars) do
					tinsert(coloredChars, Ns.Colors.Green .. c .. "|r")
				end
				self.DeleteWarning:SetText(L["ProfileDeleteWarning"] .. "\n" .. table.concat(coloredChars, ", "))
			else
				self.DeleteWarning:SetText(L["ProfileDeleteNoChars"])
			end
			self.DeleteWarning:Show()
			self.DeleteBtn:Hide()
			self.DeleteConfirmBtn:Show()
			self.DeleteCancelBtn:Show()
			return
		end

		if action == "confirmdelete" then
			local target = self.DeleteTargetProfile
			if not target or target == "Default" then return end
			for charKey, pName in pairs(SinStatsDB.profileKeys) do
				if pName == target then
					SinStatsDB.profileKeys[charKey] = "Default"
				end
			end
			SinStatsDB.profiles[target] = nil
			UpdateProfiles()
			if SinStatsDB.profileKeys[Ns.ProfileKey] == "Default" then
				Ns.ProfileRoot = SinStatsDB.profiles["Default"]
				Ns:MigrateToPanel(Ns.ProfileRoot)
				Ns.Profile = Ns.ProfileRoot.Panels[Ns.ProfileRoot.ActivePanel]
				Ns.NewSettings(Ns.ProfileRoot, Ns.Class)
				Ns:UpdateProfile()
				Ns:InitialiseProfile(Ns.Profile)
			end
			self.CurrentProfileText:SetText(format(CurrentProfileFormat, L["CurrentProfile"], SinStatsDB.profileKeys[Ns.ProfileKey]))
			ResetProfileConfig(self)
			return
		end

		if action == "editrename" then
			local renameName = strtrim(self.RenameEdit:GetText())
			local currentName = SinStatsDB.profileKeys[Ns.ProfileKey]
			if renameName ~= "" and renameName ~= currentName and not SinStatsDB.profiles[renameName] then
				self.RenameBtn:SetEnabled(true)
			end
			return
		end

		if action == "rename" then
			local newName = strtrim(self.RenameEdit:GetText())
			local oldName = SinStatsDB.profileKeys[Ns.ProfileKey]
			if newName == "" or newName == oldName or SinStatsDB.profiles[newName] then
				self.StatusMessage:SetText(L["ProfileRenameError"] or "Cannot rename: name is empty, unchanged, or already exists.")
				self.StatusMessage:Show()
				return
			end
			SinStatsDB.profiles[newName] = {}
			Ns.CopyTable(SinStatsDB.profiles[oldName], SinStatsDB.profiles[newName])
			for charKey, pName in pairs(SinStatsDB.profileKeys) do
				if pName == oldName then
					SinStatsDB.profileKeys[charKey] = newName
				end
			end
			if SinStatsDB.specProfiles then
				for charKey, specData in pairs(SinStatsDB.specProfiles) do
					for specIdx, profName in pairs(specData) do
						if profName == oldName then
							specData[specIdx] = newName
						end
					end
				end
			end
			SinStatsDB.profiles[oldName] = nil
			UpdateProfiles()
			Ns.ProfileRoot = SinStatsDB.profiles[newName]
			Ns:MigrateToPanel(Ns.ProfileRoot)
			Ns.Profile = Ns.ProfileRoot.Panels[Ns.ProfileRoot.ActivePanel]
			Ns.NewSettings(Ns.ProfileRoot, Ns.Class)
			self.RenameEdit:SetText("")
			self.CurrentProfileText:SetText(format(CurrentProfileFormat, L["CurrentProfile"], newName))
			ResetProfileConfig(self)
			self.StatusMessage:SetText(format(L["ProfileRenamed"] or "Profile renamed to %s.", Ns.Colors.Orange .. newName .. "|r"))
			self.StatusMessage:Show()
			Ns:UpdateProfile()
			Ns:InitialiseProfile(Ns.Profile)
			return
		end

		if action == "deletecancel" then
			ProfileDisableAll(self)
			ResetProfileConfig(self)
			return
		end
	end

	f.CurrentProfile = {}
	f.CopySourceProfile = nil
	f.DeleteTargetProfile = nil

	------------------------------------------
	--    Export / Import Profile           --
	------------------------------------------
	local row4Y = (f.HasSpecProfiles and (f.SpecListAnchorY or -180)) or -180
	row4Y = row4Y - 70
	if f.HasSpecProfiles then
		row4Y = row4Y + (K.PROFILE_IMPEXP_Y_OFFSET or 0)
	else
		row4Y = row4Y + (K.PROFILE_IMPEXP_Y_OFFSET_CLASSIC or 0)
	end

	local impExpLabel = f:CreateFontString()
	impExpLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	impExpLabel:SetPoint("TOPLEFT", 0, row4Y)
	impExpLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	impExpLabel:SetJustifyH("LEFT")
	impExpLabel:SetText(L["ProfileExport"] .. " / " .. L["ProfileImport"])

	local expLabel = f:CreateFontString()
	expLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5)
	expLabel:SetPoint("TOPLEFT", impExpLabel, "BOTTOMLEFT", 4, -6)
	expLabel:SetTextColor(K.GLOBAL_BAR_LABEL_R, K.GLOBAL_BAR_LABEL_G, K.GLOBAL_BAR_LABEL_B, K.GLOBAL_BAR_LABEL_A)
	expLabel:SetText(L["ProfileExport"])

	local impLabel = f:CreateFontString()
	impLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5)
	impLabel:SetPoint("TOPLEFT", expLabel, "TOPLEFT", rightCol, 0)
	impLabel:SetTextColor(K.GLOBAL_BAR_LABEL_R, K.GLOBAL_BAR_LABEL_G, K.GLOBAL_BAR_LABEL_B, K.GLOBAL_BAR_LABEL_A)
	impLabel:SetText(L["ProfileImport"])


	f.ExportScroll, f.ExportEdit = W.CreateImpExpEditBox(f,
		K.PROFILE_IMPEXP_W, K.PROFILE_IMPEXP_H,
		K.PROFILE_IMPEXP_BG_R, K.PROFILE_IMPEXP_BG_G, K.PROFILE_IMPEXP_BG_B, K.PROFILE_IMPEXP_BG_A,
		expLabel, "BOTTOMLEFT", 0, -2)
	f.ImportScroll, f.ImportEdit = W.CreateImpExpEditBox(f,
		K.PROFILE_IMPEXP_W, K.PROFILE_IMPEXP_H,
		K.PROFILE_IMPEXP_BG_R, K.PROFILE_IMPEXP_BG_G, K.PROFILE_IMPEXP_BG_B, K.PROFILE_IMPEXP_BG_A,
		impLabel, "BOTTOMLEFT", 0, -2)
	f.ImportEdit:SetScript("OnTextChanged", function(self)
		local text = self:GetText()
		f.ImportBtn:SetEnabled(text ~= "" and strtrim(text) ~= "")
	end)

	f.ExportBtn = CreateProfileButton(f, L["ProfileExport"], "export")
	f.ExportBtn:ClearAllPoints()
	f.ExportBtn:SetPoint("TOPLEFT", f.ExportScroll, "BOTTOMLEFT", 0, -4)
	f.ExportBtn:SetSize(90, 26)
	ApplyIconTextButtonStyle(f.ExportBtn, {
		normalTex = K.HUD_RENAME_BTN_TEX,
		pressedTex = K.HUD_RENAME_BTN_PRESSED_TEX,
		highlightTex = K.HUD_RENAME_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_RENAME_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_RENAME_BTN_W, h = K.HUD_RENAME_BTN_H,
		x = K.HUD_RENAME_BTN_X, y = K.HUD_RENAME_BTN_Y,
	})

	f.ExportClearBtn = CreateProfileButton(f, L["Clear"] or "Clear", "exportclear")
	f.ExportClearBtn:ClearAllPoints()
	f.ExportClearBtn:SetPoint("LEFT", f.ExportBtn, "RIGHT", 8, 0)
	f.ExportClearBtn:SetSize(80, 26)
	ApplyIconTextButtonStyle(f.ExportClearBtn, {
		normalTex = K.PROFILE_CANCEL_BTN_TEX,
		pressedTex = K.PROFILE_CANCEL_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_CANCEL_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_CANCEL_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_CANCEL_BTN_W, h = K.PROFILE_CANCEL_BTN_H,
		x = K.PROFILE_CANCEL_BTN_X, y = K.PROFILE_CANCEL_BTN_Y,
	})
	f.ExportClearBtn:HookScript("OnClick", function() f.ExportEdit:SetText("") end)

	f.ExportBtn:HookScript("OnClick", function()
		local profileName = SinStatsDB.profileKeys[Ns.ProfileKey]
		local profileData = SinStatsDB.profiles[profileName]
		if not profileData then return end
		local exportData = { name = profileName, data = profileData }
		f.ExportEdit:SetText(Ns.AceSerializer:Serialize(exportData))
		f.ExportEdit:SetFocus()
		f.ExportEdit:HighlightText()
	end)

	f.ImportBtn = CreateProfileButton(f, L["ProfileImportApply"], "import")
	f.ImportBtn:ClearAllPoints()
	f.ImportBtn:SetPoint("TOPLEFT", f.ImportScroll, "BOTTOMLEFT", 0, -4)
	f.ImportBtn:SetSize(90, 26)
	f.ImportBtn:SetEnabled(false)
	ApplyIconTextButtonStyle(f.ImportBtn, {
		normalTex = K.PROFILE_APPLY_BTN_TEX,
		pressedTex = K.PROFILE_APPLY_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_APPLY_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_APPLY_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_APPLY_BTN_W, h = K.PROFILE_APPLY_BTN_H,
		x = K.PROFILE_APPLY_BTN_X, y = K.PROFILE_APPLY_BTN_Y,
	})

	f.ImportClearBtn = CreateProfileButton(f, L["Clear"] or "Clear", "importclear")
	f.ImportClearBtn:ClearAllPoints()
	f.ImportClearBtn:SetPoint("LEFT", f.ImportBtn, "RIGHT", 8, 0)
	f.ImportClearBtn:SetSize(80, 26)
	ApplyIconTextButtonStyle(f.ImportClearBtn, {
		normalTex = K.PROFILE_CANCEL_BTN_TEX,
		pressedTex = K.PROFILE_CANCEL_BTN_PRESSED_TEX,
		highlightTex = K.PROFILE_CANCEL_BTN_HIGHLIGHT_TEX,
		highlightW = K.PROFILE_CANCEL_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.PROFILE_CANCEL_BTN_W, h = K.PROFILE_CANCEL_BTN_H,
		x = K.PROFILE_CANCEL_BTN_X, y = K.PROFILE_CANCEL_BTN_Y,
	})
	f.ImportClearBtn:HookScript("OnClick", function()
		f.ImportEdit:SetText("")
		f.ImportBtn:SetEnabled(false)
	end)

	f.ImportBtn:HookScript("OnClick", function()
		local raw = strtrim(f.ImportEdit:GetText() or "")
		if raw == "" then return end
		local ok, exportData = Ns.AceSerializer:Deserialize(raw)
		if not ok or type(exportData) ~= "table" or type(exportData.data) ~= "table" then
			f.StatusMessage:SetText(Ns.Colors.Red .. (L["ProfileImportError"] or "Invalid import string!") .. "|r")
			f.StatusMessage:Show()
			return
		end
		local baseName = exportData.name or "Imported"
		-- if the name already exists
		local newName = baseName
		if SinStatsDB.profiles[newName] then
			local idx = 2
			while SinStatsDB.profiles[baseName .. " " .. idx] do
				idx = idx + 1
			end
			newName = baseName .. " " .. idx
		end
		SinStatsDB.profiles[newName] = exportData.data
		UpdateProfiles()
		f.ImportEdit:SetText("")
		f.ImportBtn:SetEnabled(false)
		f.StatusMessage:SetText(format(L["ProfileImportSuccess"] or "Profile '%s' imported successfully!", Ns.Colors.Orange .. newName .. "|r"))
		f.StatusMessage:Show()
		ResetProfileConfig(f)
		Ns:UpdateProfile()
	end)

	-- Move status message below the import/export section
	f.StatusMessage:ClearAllPoints()
	f.StatusMessage:SetPoint("TOPLEFT", f.ImportBtn, "BOTTOMLEFT", 0, -8)

	return f
end

Mixins.functions.ProfileConfig = {}
function Mixins.functions.ProfileConfig.Init(self, anchorframe, parent, displaylist)
	UpdateProfiles()
	self.Anchoreframe = anchorframe
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.DisplayOrder = parent.DisplayOrder
	self.Edit:SetText("")
	self.CurrentProfile[Ns.ProfileKey] = SinStatsDB.profileKeys[Ns.ProfileKey]
	self.SvTable = self.CurrentProfile
	self.Key = Ns.ProfileKey
	self.CurrentProfileText:SetText(format(CurrentProfileFormat, L["CurrentProfile"], Ns.Colors.Orange .. SinStatsDB.profileKeys[Ns.ProfileKey] .. "|r"))

	self.SelectList = Ns:GetWidget("DropList", self, self:GetID())
	self.SelectList:SetParent(self)
	self.SelectList:ClearAllPoints()
	self.SelectList:SetPoint("TOPLEFT", self.SelectLabel, "BOTTOMLEFT", 0, -4)
	self.SelectList:Init(self, self)
	self.SelectList.Tip:Hide()
	self.SelectList:Show()
	self.LoadBtn:ClearAllPoints()
	self.LoadBtn:SetPoint("LEFT", self.SelectList, "RIGHT", 10, 0)

	self.CopyList = Ns:GetWidget("DropList", self, self:GetID())
	self.CopyList:SetParent(self)
	self.CopyList:ClearAllPoints()
	self.CopyList:SetPoint("TOPLEFT", self.CopyLabel, "BOTTOMLEFT", 0, -4)
	self.CopyList:Init(self, self)
	self.CopyList.Tip:Hide()
	self.CopyList:Show()

	self.CopyList.DropButton:SetScript("OnClick", function(btn)
		PlayOnCheck()
		local listParent = btn:GetParent()
		if not listParent.List:IsShown() then
			listParent.List.MyInformation = btn.MyInformation
			listParent.List.Settings = btn.Settings
			listParent.List.Key = btn.Key
			listParent.List.Data = btn.Data
			listParent.List.IsCopyList = true
		end
		listParent.List:SetShown(not listParent.List:IsShown())
	end)
	self.CopyBtn:ClearAllPoints()
	self.CopyBtn:SetPoint("LEFT", self.CopyList, "RIGHT", 10, 0)
	self.CopyConfirmBtn:ClearAllPoints()
	self.CopyConfirmBtn:SetPoint("TOPLEFT", self.CopyWarning, "BOTTOMLEFT", 0, -4)
	self.CopyCancelBtn:ClearAllPoints()
	self.CopyCancelBtn:SetPoint("LEFT", self.CopyConfirmBtn, "RIGHT", 10, 0)

	self.DeleteList = Ns:GetWidget("DropList", self, self:GetID())
	self.DeleteList:SetParent(self)
	self.DeleteList:ClearAllPoints()
	self.DeleteList:SetPoint("TOPLEFT", self.DeleteLabel, "BOTTOMLEFT", 0, -4)
	self.DeleteList:Init(self, self)
	self.DeleteList.Tip:Hide()
	self.DeleteList:Show()
	self.DeleteList.DropButton:SetScript("OnClick", function(btn)
		PlayOnCheck()
		local listParent = btn:GetParent()
		if not listParent.List:IsShown() then
			listParent.List.MyInformation = btn.MyInformation

			if self.DeleteConfirmBtn:IsShown() and self.DeleteTargetProfile then
				listParent.List.Settings = { [btn.Key] = self.DeleteTargetProfile }
			else
				listParent.List.Settings = btn.Settings
			end
			listParent.List.Key = btn.Key
			listParent.List.Data = btn.Data
			listParent.List.IsDeleteList = true
		end
		listParent.List:SetShown(not listParent.List:IsShown())
	end)
	self.DeleteBtn:ClearAllPoints()
	self.DeleteBtn:SetPoint("TOPLEFT", self.DeleteList, "BOTTOMLEFT", 0, -8)
	self.DeleteConfirmBtn:ClearAllPoints()
	self.DeleteConfirmBtn:SetPoint("TOPLEFT", self.DeleteList, "BOTTOMLEFT", 0, -8)
	self.DeleteCancelBtn:ClearAllPoints()
	self.DeleteCancelBtn:SetPoint("LEFT", self.DeleteConfirmBtn, "RIGHT", 10, 0)
	self.DeleteWarning:ClearAllPoints()
	self.DeleteWarning:SetPoint("TOPLEFT", self.DeleteBtn, "BOTTOMLEFT", 0, -8)

	if self.HasSpecProfiles then

		if not SinStatsDB.specProfiles then SinStatsDB.specProfiles = {} end
		if not SinStatsDB.specProfiles[Ns.ProfileKey] then SinStatsDB.specProfiles[Ns.ProfileKey] = {} end
		self:UpdateSpecSection()
	end

	self:RunAction("select")
end

function Mixins.functions.ProfileConfig.Reset(self)
	if self.SelectList then Ns:KillWidget(self.SelectList); self.SelectList = nil end
	if self.CopyList then Ns:KillWidget(self.CopyList); self.CopyList = nil end
	if self.DeleteList then Ns:KillWidget(self.DeleteList); self.DeleteList = nil end
	if self.SpecLists then
		for i, dl in pairs(self.SpecLists) do
			if dl then Ns:KillWidget(dl); self.SpecLists[i] = nil end
		end
	end
end

------------------------------------------
--			Panel Config				--
------------------------------------------
local function ResetPanelConfig(self)
	UpdatePanels()
	self.SelectedPanel = Ns.ProfileRoot and Ns.ProfileRoot.ActivePanel or "Main"
	self.SvTable["PanelManagement"] = self.SelectedPanel
	-- Refresh select droplist
	self.SelectList:Init(self, self)
	self.SelectList.Tip:Hide()
	-- Refresh delete list
	self:UpdateDeleteList()
	self:RunAction("select")
end

Mixins.scripts.PanelConfigButton = {}
function Mixins.scripts.PanelConfigButton.OnClick(self)
	PlayOnTab()
	self:GetParent():RunAction(self.Action)
end
function Mixins.scripts.PanelConfigButton.OnEnable(self)
	self:SetAlpha(1)
	RestoreButtonBgRest(self)
end
function Mixins.scripts.PanelConfigButton.OnDisable(self)
	self:SetAlpha(0.5)
	self.BgTexture:SetVertexColor(topTabColor.r, topTabColor.g, topTabColor.b, 0.5)
end

local function CreatePanelButton(self, label, action)
	local f = CreateFrame("Button", nil, self)
	f:SetSize(90, 26)
	f.Text = f:CreateFontString()
	f.Text:SetPoint("CENTER")
	f.Text:SetFont(Ns.ConfigDefaultFont2, 11)
	f.Text:SetJustifyH("CENTER")
	local bg = f:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetTexture(K.BUTTON_IDLE_TEX)
	SetButtonBgRest(f, 1, 1, 1, 1)
	f.BgTexture = bg
	f.RestTexturePath = K.BUTTON_IDLE_TEX
	f.PressedTexturePath = K.BUTTON_PRESSED_TEX
	f:SetScript("OnMouseDown", function(btn)
		if not btn:IsEnabled() then return end
		btn.BgTexture:SetTexture(btn.PressedTexturePath or K.BUTTON_PRESSED_TEX)
		if btn.ApplyIconTextTextOffset then
			btn:ApplyIconTextTextOffset(btn.IconTextPressedY or btn.IconTextBaseY or 0)
		end
	end)
	f:SetScript("OnMouseUp", function(btn)
		if not btn:IsEnabled() then return end
		btn.BgTexture:SetTexture(btn.RestTexturePath or K.BUTTON_IDLE_TEX)
		if btn.ApplyIconTextTextOffset then
			btn:ApplyIconTextTextOffset(btn.IconTextBaseY or 0)
		end
		RestoreButtonBgRest(btn)
	end)
	f.Text:SetText(label)
	f.Action = action
	for k, v in pairs(Mixins.scripts.PanelConfigButton) do
		f:HookScript(k, v)
	end
	return f
end

function W.PanelConfig(parent)
	local f = CreateFrame("Frame", "$parentPanels", parent)
	f.SpecialType = "PanelConfig"
	f:SetSize(500, 100)
	Mixin(f, Mixins.functions.PanelConfig)

	local leftCol = 40
	local rightCol = 430
	f._leftCol = leftCol
	local yOfs = 0

	-- Hint text (below separator, above ACTIVE header)
	f.Hint = f:CreateFontString()
	f.Hint:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 5)
	f.Hint:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.Hint:SetPoint("TOP", 80, 2)
	f.Hint:SetText(L["PanelsHint"])

	-- Current panel header
	f.CurrentPanelText = f:CreateFontString()
	f.CurrentPanelText:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 2)
	f.CurrentPanelText:SetTextColor(1, 1, 1)
	f.CurrentPanelText:SetPoint("TOP", 80, -30)
	f.CurrentPanelText:SetJustifyH("CENTER")
	f.CurrentPanelTextBg = AttachActiveHeaderBackground(f, f.CurrentPanelText)

	yOfs = -30
	yOfs = yOfs - 37

	-- Switch Panel section
	f.SelectLabel = f:CreateFontString()
	f.SelectLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.SelectLabel:SetPoint("TOPLEFT", leftCol, yOfs - 7)
	f.SelectLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.SelectLabel:SetJustifyH("LEFT")

	-- Create New Panel section (right column)
	f.CreateLabel = f:CreateFontString()
	f.CreateLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.CreateLabel:SetPoint("TOPLEFT", rightCol, yOfs - 7)
	f.CreateLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.CreateLabel:SetJustifyH("LEFT")

	yOfs = yOfs - 22
	f.SelectListAnchorY = yOfs

	f.SwitchBtn = CreatePanelButton(f, L["PanelSwitch"] or "Switch", "switch")
	ApplyIconTextButtonStyle(f.SwitchBtn, {
		normalTex = K.HUD_SWITCH_BTN_TEX,
		pressedTex = K.HUD_SWITCH_BTN_PRESSED_TEX,
		highlightTex = K.HUD_SWITCH_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_SWITCH_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_SWITCH_BTN_W,
		h = K.HUD_SWITCH_BTN_H,
		x = K.HUD_SWITCH_BTN_X,
		y = K.HUD_SWITCH_BTN_Y,
	})

	f.CreateEdit = W.BaseEditBox(f, 240, 27)
	f.CreateEdit:SetPoint("TOPLEFT", rightCol, yOfs)
	f.CreateEdit.Action = "editcreate"
	f.CreateEdit:SetScript("OnTextChanged", function(self)
		self:GetParent():RunAction(self.Action)
	end)

	yOfs = yOfs - 30

	-- Copy from current checkbox
	f.CopyCheck = CreateFrame("CheckButton", nil, f)
	f.CopyCheck:SetSize(K.CHECKBOX_SIZE, K.CHECKBOX_SIZE)
	f.CopyCheck:SetPoint("TOPLEFT", rightCol, yOfs)
	f.CopyCheck:SetNormalTexture("")
	f.CopyCheck:SetPushedTexture("")
	f.CopyCheck:SetHighlightTexture("")
	f.CopyCheck.FrameTex = f.CopyCheck:CreateTexture(nil, "ARTWORK", nil, 0)
	f.CopyCheck.FrameTex:SetAllPoints()
	f.CopyCheck.FrameTex:SetTexture(K.CHECKBOX_FRAME_TEX)
	f.CopyCheck.FrameTex:SetBlendMode("BLEND")
	f.CopyCheck:SetCheckedTexture(K.CHECKBOX_CHECK_TEX)
	local copyCheckTex = f.CopyCheck:GetCheckedTexture()
	copyCheckTex:SetBlendMode("BLEND")
	copyCheckTex:SetVertexColor(K.CHECKBOX_CHECK_R, K.CHECKBOX_CHECK_G, K.CHECKBOX_CHECK_B, K.CHECKBOX_CHECK_A)
	if K.CHECKBOX_CHECK_DESATURATED then copyCheckTex:SetDesaturated(true) end
	if K.CHECKBOX_CHECK_SIZE and K.CHECKBOX_CHECK_SIZE > 0 then
		copyCheckTex:ClearAllPoints()
		copyCheckTex:SetPoint("CENTER")
		copyCheckTex:SetSize(K.CHECKBOX_CHECK_SIZE, K.CHECKBOX_CHECK_SIZE)
	end
	f.CopyCheck:SetHighlightTexture(K.CHECKBOX_HIGHLIGHT ~= "" and K.CHECKBOX_HIGHLIGHT or (Ns.TexturePath.."Highlight"))
	local copyHt = f.CopyCheck:GetHighlightTexture()
	copyHt:SetVertexColor(K.CHECKBOX_HIGHLIGHT_R, K.CHECKBOX_HIGHLIGHT_G, K.CHECKBOX_HIGHLIGHT_B, K.CHECKBOX_HIGHLIGHT_A)
	copyHt:ClearAllPoints()
	if K.CHECKBOX_HIGHLIGHT_W > 0 and K.CHECKBOX_HIGHLIGHT_H > 0 then
		copyHt:SetPoint("CENTER", f.CopyCheck, "CENTER", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		copyHt:SetSize(K.CHECKBOX_HIGHLIGHT_W, K.CHECKBOX_HIGHLIGHT_H)
	elseif K.CHECKBOX_HIGHLIGHT_H > 0 then
		copyHt:SetPoint("LEFT", f.CopyCheck, "LEFT", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		copyHt:SetPoint("RIGHT", f.CopyCheck, "RIGHT", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		copyHt:SetHeight(K.CHECKBOX_HIGHLIGHT_H)
	elseif K.CHECKBOX_HIGHLIGHT_W > 0 then
		copyHt:SetPoint("TOP", f.CopyCheck, "TOP", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		copyHt:SetPoint("BOTTOM", f.CopyCheck, "BOTTOM", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		copyHt:SetWidth(K.CHECKBOX_HIGHLIGHT_W)
	else
		copyHt:SetPoint("TOPLEFT", f.CopyCheck, "TOPLEFT", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
		copyHt:SetPoint("BOTTOMRIGHT", f.CopyCheck, "BOTTOMRIGHT", K.CHECKBOX_HIGHLIGHT_X_OFFSET, K.CHECKBOX_HIGHLIGHT_Y_OFFSET)
	end
	copyHt:SetAlpha(0.2)
	f.CopyCheck:SetChecked(true)

	f.CopyCheckLabel = f:CreateFontString()
	f.CopyCheckLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.CopyCheckLabel:SetPoint("LEFT", f.CopyCheck, "RIGHT", 6, 0)
	f.CopyCheckLabel:SetTextColor(K.GLOBAL_BAR_LABEL_R, K.GLOBAL_BAR_LABEL_G, K.GLOBAL_BAR_LABEL_B, K.GLOBAL_BAR_LABEL_A)

	f.CreateBtn = CreatePanelButton(f, L["PanelCreate"] or "Create", "create")
	f.CreateBtn:SetPoint("LEFT", f.CopyCheckLabel, "RIGHT", 10, 0)
	ApplyIconTextButtonStyle(f.CreateBtn, {
		normalTex = K.HUD_CREATE_BTN_TEX,
		pressedTex = K.HUD_CREATE_BTN_PRESSED_TEX,
		highlightTex = K.HUD_CREATE_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_CREATE_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_CREATE_BTN_W,
		h = K.HUD_CREATE_BTN_H,
		x = K.HUD_CREATE_BTN_X,
		y = K.HUD_CREATE_BTN_Y,
	})

	yOfs = yOfs - 45

	-- Rename section (left column)
	f.RenameLabel = f:CreateFontString()
	f.RenameLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.RenameLabel:SetPoint("TOPLEFT", leftCol, yOfs - 7)
	f.RenameLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.RenameLabel:SetJustifyH("LEFT")

	-- Delete section (right column)
	f.DeleteLabel = f:CreateFontString()
	f.DeleteLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	f.DeleteLabel:SetPoint("TOPLEFT", rightCol, yOfs - 7)
	f.DeleteLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.DeleteLabel:SetJustifyH("LEFT")

	yOfs = yOfs - 22
	f.DeleteListAnchorY = yOfs

	f.DeleteWarning = f:CreateFontString()
	f.DeleteWarning:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5)
	f.DeleteWarning:SetJustifyH("LEFT")
	f.DeleteWarning:Hide()

	f.DeleteConfirmBtn = CreatePanelButton(f, L["ConfirmDelete"] or "Confirm", "confirmdelete")
	f.DeleteConfirmBtn:SetSize(120, 26)
	ApplyIconTextButtonStyle(f.DeleteConfirmBtn, {
		normalTex = K.HUD_CONFIRM_BTN_TEX,
		pressedTex = K.HUD_CONFIRM_BTN_PRESSED_TEX,
		highlightTex = K.HUD_CONFIRM_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_CONFIRM_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_CONFIRM_BTN_W,
		h = K.HUD_CONFIRM_BTN_H,
		x = K.HUD_CONFIRM_BTN_X,
		y = K.HUD_CONFIRM_BTN_Y,
	})
	f.DeleteConfirmBtn:Hide()

	f.DeleteCancelBtn = CreatePanelButton(f, L["Cancel"] or "Cancel", "deletecancel")
	f.DeleteCancelBtn:SetSize(120, 26)
	ApplyIconTextButtonStyle(f.DeleteCancelBtn, {
		normalTex = K.HUD_CANCEL_BTN_TEX,
		pressedTex = K.HUD_CANCEL_BTN_PRESSED_TEX,
		highlightTex = K.HUD_CANCEL_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_CANCEL_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_CANCEL_BTN_W,
		h = K.HUD_CANCEL_BTN_H,
		x = K.HUD_CANCEL_BTN_X,
		y = K.HUD_CANCEL_BTN_Y,
	})
	f.DeleteCancelBtn:Hide()

	f.DeleteItems = {}

	f.RenameEdit = W.BaseEditBox(f, 240, 27)
	f.RenameEdit:SetPoint("TOPLEFT", leftCol, yOfs)
	f.RenameEdit.Action = "editrename"
	f.RenameEdit:SetScript("OnTextChanged", function(self)
		self:GetParent():RunAction(self.Action)
	end)

	yOfs = yOfs - 30

	f.RenameBtn = CreatePanelButton(f, L["PanelRename"] or "Rename", "rename")
	f.RenameBtn:SetPoint("TOPLEFT", leftCol, yOfs)
	ApplyIconTextButtonStyle(f.RenameBtn, {
		normalTex = K.HUD_RENAME_BTN_TEX,
		pressedTex = K.HUD_RENAME_BTN_PRESSED_TEX,
		highlightTex = K.HUD_RENAME_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_RENAME_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_RENAME_BTN_W,
		h = K.HUD_RENAME_BTN_H,
		x = K.HUD_RENAME_BTN_X,
		y = K.HUD_RENAME_BTN_Y,
	})

	yOfs = yOfs - 25

	------------------------------------------
	--    Export / Import HUD              --
	------------------------------------------
	local impExpY = yOfs + (K.HUD_IMPEXP_Y_OFFSET or 0)

	local hudImpExpLabel = f:CreateFontString()
	hudImpExpLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	hudImpExpLabel:SetPoint("TOPLEFT", leftCol, impExpY)
	hudImpExpLabel:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	hudImpExpLabel:SetJustifyH("LEFT")
	hudImpExpLabel:SetText(L["ProfileExport"] .. " / " .. L["ProfileImport"])

	-- Export label
	local hudExpLabel = f:CreateFontString()
	hudExpLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5)
	hudExpLabel:SetPoint("TOPLEFT", hudImpExpLabel, "BOTTOMLEFT", 4, -6)
	hudExpLabel:SetTextColor(K.GLOBAL_BAR_LABEL_R, K.GLOBAL_BAR_LABEL_G, K.GLOBAL_BAR_LABEL_B, K.GLOBAL_BAR_LABEL_A)
	hudExpLabel:SetText(L["ProfileExport"])

	-- Export edit box
	f.HUDExportScroll, f.HUDExportEdit = W.CreateImpExpEditBox(f,
		K.HUD_IMPEXP_W, K.HUD_IMPEXP_H,
		K.HUD_IMPEXP_BG_R, K.HUD_IMPEXP_BG_G, K.HUD_IMPEXP_BG_B, K.HUD_IMPEXP_BG_A,
		hudExpLabel, "BOTTOMLEFT", 0, -2)

	-- Export button
	f.HUDExportBtn = CreatePanelButton(f, L["ProfileExport"] or "Export", "hudexport")
	f.HUDExportBtn:ClearAllPoints()
	f.HUDExportBtn:SetPoint("TOPLEFT", f.HUDExportScroll, "BOTTOMLEFT", 0, -4)
	f.HUDExportBtn:SetSize(90, 26)
	ApplyIconTextButtonStyle(f.HUDExportBtn, {
		normalTex = K.HUD_RENAME_BTN_TEX,
		pressedTex = K.HUD_RENAME_BTN_PRESSED_TEX,
		highlightTex = K.HUD_RENAME_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_RENAME_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_RENAME_BTN_W, h = K.HUD_RENAME_BTN_H,
		x = K.HUD_RENAME_BTN_X, y = K.HUD_RENAME_BTN_Y,
	})
	f.HUDExportBtn:HookScript("OnClick", function()
		local panelName = Ns.ProfileRoot and Ns.ProfileRoot.ActivePanel or "Main"
		local panelData = Ns.ProfileRoot.Panels[panelName]
		if not panelData then return end
		local exportData = { name = panelName, data = panelData }
		f.HUDExportEdit:SetText(Ns.AceSerializer:Serialize(exportData))
		f.HUDExportEdit:SetFocus()
		f.HUDExportEdit:HighlightText()
	end)

	-- Export Clear button
	f.HUDExportClearBtn = CreatePanelButton(f, L["Clear"] or "Clear", "hudexportclear")
	f.HUDExportClearBtn:ClearAllPoints()
	f.HUDExportClearBtn:SetPoint("LEFT", f.HUDExportBtn, "RIGHT", 8, 0)
	f.HUDExportClearBtn:SetSize(80, 26)
	ApplyIconTextButtonStyle(f.HUDExportClearBtn, {
		normalTex = K.HUD_CANCEL_BTN_TEX,
		pressedTex = K.HUD_CANCEL_BTN_PRESSED_TEX,
		highlightTex = K.HUD_CANCEL_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_CANCEL_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_CANCEL_BTN_W, h = K.HUD_CANCEL_BTN_H,
		x = K.HUD_CANCEL_BTN_X, y = K.HUD_CANCEL_BTN_Y,
	})
	f.HUDExportClearBtn:HookScript("OnClick", function() f.HUDExportEdit:SetText("") end)

	-- Import label (below export button, left-aligned)
	local hudImpLabel = f:CreateFontString()
	hudImpLabel:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5)
	hudImpLabel:SetPoint("TOPLEFT", f.HUDExportBtn, "BOTTOMLEFT", 0, -12)
	hudImpLabel:SetTextColor(K.GLOBAL_BAR_LABEL_R, K.GLOBAL_BAR_LABEL_G, K.GLOBAL_BAR_LABEL_B, K.GLOBAL_BAR_LABEL_A)
	hudImpLabel:SetText(L["ProfileImport"])

	-- Import edit box
	f.HUDImportScroll, f.HUDImportEdit = W.CreateImpExpEditBox(f,
		K.HUD_IMPEXP_W, K.HUD_IMPEXP_H,
		K.HUD_IMPEXP_BG_R, K.HUD_IMPEXP_BG_G, K.HUD_IMPEXP_BG_B, K.HUD_IMPEXP_BG_A,
		hudImpLabel, "BOTTOMLEFT", 0, -2)

	f.HUDImportEdit:SetScript("OnTextChanged", function(self)
		local text = self:GetText()
		f.HUDImportBtn:SetEnabled(text ~= "" and strtrim(text) ~= "")
	end)

	-- Import button
	f.HUDImportBtn = CreatePanelButton(f, L["ProfileImportApply"] or "Import", "hudimport")
	f.HUDImportBtn:ClearAllPoints()
	f.HUDImportBtn:SetPoint("TOPLEFT", f.HUDImportScroll, "BOTTOMLEFT", 0, -4)
	f.HUDImportBtn:SetSize(90, 26)
	f.HUDImportBtn:SetEnabled(false)
	ApplyIconTextButtonStyle(f.HUDImportBtn, {
		normalTex = K.HUD_CONFIRM_BTN_TEX,
		pressedTex = K.HUD_CONFIRM_BTN_PRESSED_TEX,
		highlightTex = K.HUD_CONFIRM_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_CONFIRM_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_CONFIRM_BTN_W, h = K.HUD_CONFIRM_BTN_H,
		x = K.HUD_CONFIRM_BTN_X, y = K.HUD_CONFIRM_BTN_Y,
	})
	f.HUDImportBtn:HookScript("OnClick", function()
		local raw = strtrim(f.HUDImportEdit:GetText() or "")
		if raw == "" then return end
		local ok, exportData = Ns.AceSerializer:Deserialize(raw)
		if not ok or type(exportData) ~= "table" or type(exportData.data) ~= "table" then
			f.StatusMessage:SetText(Ns.Colors.Red .. (L["ProfileImportError"] or "Invalid import string!") .. "|r")
			f.StatusMessage:Show()
			return
		end
		local baseName = exportData.name or "Imported"
		local newName = baseName
		if Ns.ProfileRoot.Panels[newName] then
			local idx = 2
			while Ns.ProfileRoot.Panels[baseName .. " " .. idx] do
				idx = idx + 1
			end
			newName = baseName .. " " .. idx
		end
		Ns.ProfileRoot.Panels[newName] = exportData.data
		tinsert(Ns.ProfileRoot.PanelOrder, newName)
		Ns.PanelFrames[newName] = Ns:CreatePanelFrame(newName)
		local pd = Ns.ProfileRoot.Panels[newName]
		Ns.LWin.RegisterConfig(Ns.PanelFrames[newName], pd.HUDPos)
		Ns.LWin.MakeDraggable(Ns.PanelFrames[newName])
		f.HUDImportEdit:SetText("")
		f.HUDImportBtn:SetEnabled(false)
		ResetPanelConfig(f)
		f.StatusMessage:SetText(format(L["HUDImportSuccess"] or "HUD '%s' imported successfully!", Ns.Colors.Orange .. newName .. "|r"))
		f.StatusMessage:Show()
		Ns:UpdateProfile()
		Ns:InitialiseAllPanels()
	end)

	-- Import Clear button
	f.HUDImportClearBtn = CreatePanelButton(f, L["Clear"] or "Clear", "hudimportclear")
	f.HUDImportClearBtn:ClearAllPoints()
	f.HUDImportClearBtn:SetPoint("LEFT", f.HUDImportBtn, "RIGHT", 8, 0)
	f.HUDImportClearBtn:SetSize(80, 26)
	ApplyIconTextButtonStyle(f.HUDImportClearBtn, {
		normalTex = K.HUD_CANCEL_BTN_TEX,
		pressedTex = K.HUD_CANCEL_BTN_PRESSED_TEX,
		highlightTex = K.HUD_CANCEL_BTN_HIGHLIGHT_TEX,
		highlightW = K.HUD_CANCEL_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.HUD_CANCEL_BTN_W, h = K.HUD_CANCEL_BTN_H,
		x = K.HUD_CANCEL_BTN_X, y = K.HUD_CANCEL_BTN_Y,
	})
	f.HUDImportClearBtn:HookScript("OnClick", function()
		f.HUDImportEdit:SetText("")
		f.HUDImportBtn:SetEnabled(false)
	end)

	yOfs = yOfs - (K.HUD_IMPEXP_H * 2) - 65

	-- Status message (below import section)
	f.StatusMessageAnchorY = yOfs
	f.StatusMessage = f:CreateFontString()
	f.StatusMessage:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5)
	f.StatusMessage:SetPoint("TOPLEFT", 0, f.StatusMessageAnchorY)
	f.StatusMessage:SetJustifyH("LEFT")
	f.StatusMessage:Hide()
	-- Anchor below HUD import button (same pattern as profile import/export)
	f.StatusMessage:ClearAllPoints()
	f.StatusMessage:SetPoint("TOPLEFT", f.HUDImportBtn, "BOTTOMLEFT", 0, -4)

	function f.PanelDisableAll(self)
		self.SwitchBtn:SetEnabled(false)
		self.CreateBtn:SetEnabled(false)
		self.RenameBtn:SetEnabled(false)
		self.DeleteConfirmBtn:Hide()
		self.DeleteCancelBtn:Hide()
		self.DeleteWarning:Hide()
		self.StatusMessage:Hide()
	end

	function f.RunAction(self, action)
		self:PanelDisableAll()
		if not Ns.ProfileRoot then return end
		local newName = strtrim(self.CreateEdit:GetText())
		local renameName = strtrim(self.RenameEdit:GetText())

		if action == "switch" then
			local target = self.SelectedPanel
			if target and Ns.ProfileRoot.Panels[target] then
				Ns.ProfileRoot.ActivePanel = target
				Ns.Profile = Ns.ProfileRoot.Panels[target]
				self.CurrentPanelText:SetText(format("%s: %s", L["PanelCurrent"] or "Active Panel", Ns.Colors.Orange .. target .. "|r"))
				ResetPanelConfig(self)
				Ns:UpdateProfile()
				Ns:InitialiseAllPanels()
			end
			return
		end

		if action == "select" then
			if self.SelectedPanel ~= Ns.ProfileRoot.ActivePanel then
				self.SwitchBtn:SetEnabled(true)
			end
			return
		end

		if action == "editcreate" then
			if newName ~= "" and not Ns.ProfileRoot.Panels[newName] then
				self.CreateBtn:SetEnabled(true)
			end
			return
		end

		if action == "create" then
			if newName == "" or Ns.ProfileRoot.Panels[newName] then return end
			local copyFrom = self.CopyCheck:GetChecked() and Ns.ProfileRoot.ActivePanel or nil
			if Ns:CreateNewPanel(Ns.ProfileRoot, newName, copyFrom) then
				-- Create the panel frame
				Ns.PanelFrames[newName] = Ns:CreatePanelFrame(newName)
				local pd = Ns.ProfileRoot.Panels[newName]

				Ns.LWin.RegisterConfig(Ns.PanelFrames[newName], pd.HUDPos)
				Ns.LWin.MakeDraggable(Ns.PanelFrames[newName])
				-- Switch to it
				Ns.ProfileRoot.ActivePanel = newName
				Ns.Profile = Ns.ProfileRoot.Panels[newName]
				self.CreateEdit:SetText("")
				self.CurrentPanelText:SetText(format("%s: %s", L["PanelCurrent"] or "Active Panel", Ns.Colors.Orange .. newName .. "|r"))
				ResetPanelConfig(self)
				self.StatusMessage:SetText(format(L["PanelCreatedMsg"] or "Panel %s created.", Ns.Colors.Orange .. newName .. "|r"))
				self.StatusMessage:Show()
				Ns:UpdateProfile()
				Ns:InitialiseAllPanels()
			end
			return
		end

		if action == "editrename" then
			if renameName ~= "" and not Ns.ProfileRoot.Panels[renameName] and renameName ~= Ns.ProfileRoot.ActivePanel then
				self.RenameBtn:SetEnabled(true)
			end
			return
		end

		if action == "rename" then
			if renameName == "" or Ns.ProfileRoot.Panels[renameName] then return end
			local oldName = Ns.ProfileRoot.ActivePanel
			-- Move panel frame reference
			local pf = Ns.PanelFrames[oldName]
			if Ns:RenamePanel(Ns.ProfileRoot, oldName, renameName) then
				if pf then
					Ns.PanelFrames[renameName] = pf
					Ns.PanelFrames[oldName] = nil
					pf.Title:SetText(renameName)
				end
				Ns.Profile = Ns.ProfileRoot.Panels[Ns.ProfileRoot.ActivePanel]
				self.RenameEdit:SetText("")
				self.CurrentPanelText:SetText(format("%s: %s", L["PanelCurrent"] or "Active Panel", Ns.Colors.Orange .. renameName .. "|r"))
				ResetPanelConfig(self)
				self.StatusMessage:SetText(format(L["PanelRenamedMsg"] or "Panel renamed to %s.", Ns.Colors.Orange .. renameName .. "|r"))
				self.StatusMessage:Show()
				Ns:UpdateProfile()
				Ns:InitialiseAllPanels()
			end
			return
		end

		if action == "delete" then
			local target = self.DeleteTargetPanel
			local anchor = self.DeleteTargetBtn
			if not target or not anchor or #Ns.ProfileRoot.PanelOrder <= 1 then return end
			self.DeleteWarning:ClearAllPoints()
			self.DeleteWarning:SetPoint("TOPRIGHT", anchor, "TOPLEFT", -10, 0)
			self.DeleteWarning:SetText(format(L["PanelDeleteWarning"] or "Delete %s? \nThis cannot be undone.", Ns.Colors.Orange .. target .. "|r"))
			self.DeleteWarning:Show()
			self.DeleteConfirmBtn:ClearAllPoints()
			self.DeleteConfirmBtn:SetPoint("TOPRIGHT", self.DeleteWarning, "BOTTOMRIGHT", 0, -6)
			self.DeleteConfirmBtn:Show()
			self.DeleteCancelBtn:ClearAllPoints()
			self.DeleteCancelBtn:SetPoint("TOPRIGHT", self.DeleteConfirmBtn, "BOTTOMRIGHT", 0, -4)
			self.DeleteCancelBtn:Show()
			return
		end

		if action == "confirmdelete" then
			local target = self.DeleteTargetPanel
			if not target then return end
			-- Remove panel frame
			local pf = Ns.PanelFrames[target]
			if pf then
				pf:Hide()
				pf.HUD:Hide()
				Ns.PanelFrames[target] = nil
			end
			Ns:DeletePanel(Ns.ProfileRoot, target)
			Ns.Profile = Ns.ProfileRoot.Panels[Ns.ProfileRoot.ActivePanel]
			self.CurrentPanelText:SetText(format("%s: %s", L["PanelCurrent"] or "Active Panel", Ns.Colors.Orange .. Ns.ProfileRoot.ActivePanel .. "|r"))
			ResetPanelConfig(self)
			self.StatusMessage:ClearAllPoints()
			if self.DeleteWarning then
				self.StatusMessage:SetPoint("TOPRIGHT", self.DeleteWarning, "TOPRIGHT", 0, 0)
			else
				self.StatusMessage:SetPoint("TOPLEFT", 0, self.StatusMessageAnchorY or 0)
			end
			self.StatusMessage:SetText(format(L["PanelDeletedMsg"] or "%s has successfully been deleted", Ns.Colors.Orange .. target .. "|r"))
			self.StatusMessage:Show()
			Ns:UpdateProfile()
			Ns:InitialiseAllPanels()
			return
		end

		if action == "deletecancel" then
			self:PanelDisableAll()
			ResetPanelConfig(self)
			return
		end
	end

	f.SelectedPanel = nil
	f.DeleteTargetPanel = nil
	f.DeleteTargetBtn = nil

	return f
end

Mixins.functions.PanelConfig = {}
function Mixins.functions.PanelConfig.Init(self, anchorframe, parent, displaylist)
	UpdatePanels()
	self.Anchoreframe = anchorframe
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.DisplayOrder = parent.DisplayOrder
	self.CreateEdit:SetText("")
	self.RenameEdit:SetText("")
	self.SelectedPanel = Ns.ProfileRoot and Ns.ProfileRoot.ActivePanel or "Main"
	self.SvTable = {}
	self.Key = "PanelManagement"
	self.SvTable["PanelManagement"] = self.SelectedPanel
	self.CurrentPanelText:SetText(format("%s: %s", L["PanelCurrent"] or "Active Panel", Ns.Colors.Orange .. self.SelectedPanel .. "|r"))

	self.SelectLabel:SetText(L["PanelSelectLabel"] or "Switch Panel")
	self.CreateLabel:SetText(L["PanelCreateLabel"] or "Create New Panel")
	self.DeleteLabel:SetText(L["PanelDeleteLabel"] or "Delete")
	self.RenameLabel:SetText(L["PanelRenameLabel"] or "Rename")
	self.CopyCheckLabel:SetText(L["PanelCopyCurrent"] or "Copy from current")

	self.SelectList = Ns:GetWidget("DropList", self, self:GetID())
	self.SelectList:SetParent(self)
	self.SelectList:ClearAllPoints()
	self.SelectList:SetPoint("TOPLEFT", self._leftCol or 0, self.SelectListAnchorY)
	self.SelectList:Init(self, self)
	self.SelectList.Tip:Hide()
	self.SelectList:Show()
	self.SwitchBtn:ClearAllPoints()
	self.SwitchBtn:SetPoint("LEFT", self.SelectList, "RIGHT", 10, 0)

	self.SelectList.DropButton:SetScript("OnClick", function(btn)
		PlayOnCheck()
		local listParent = btn:GetParent()
		if not listParent.List:IsShown() then
			listParent.List.MyInformation = btn.MyInformation
			listParent.List.Settings = btn.Settings
			listParent.List.Key = btn.Key
			listParent.List.Data = btn.Data
			listParent.List.IsPanelSelect = true
		end
		listParent.List:SetShown(not listParent.List:IsShown())
	end)

	self:UpdateDeleteList()

	self:RunAction("select")
end

function Mixins.functions.PanelConfig.UpdateDeleteList(self)
	-- Hide all existing items
	for _, btn in ipairs(self.DeleteItems) do
		btn:Hide()
	end
	self.DeleteConfirmBtn:Hide()
	self.DeleteCancelBtn:Hide()
	self.DeleteWarning:Hide()

	if not Ns.ProfileRoot or not Ns.ProfileRoot.PanelOrder then return end

	local btnWidth = 240
	local btnHeight = 22
	local btnSpacing = 3

	for i, pName in ipairs(Ns.ProfileRoot.PanelOrder) do
		local btn = self.DeleteItems[i]
		if not btn then
			btn = CreateFrame("Button", nil, self, "BackdropTemplate")
			btn:SetSize(btnWidth, btnHeight)
			btn:SetBackdrop(EditBoxBG)
			btn:SetBackdropColor(0, 0, 0, 0)
			btn:SetBackdropBorderColor(0, 0, 0, 0)

			btn.BgAtlas = btn:CreateTexture(nil, "BACKGROUND", nil, 0)
			btn.BgAtlas:SetAllPoints()
			btn.BgAtlas:SetTexture(K.HUD_DELETE_BAR_TEX)
			if K.BAR_BTN_HIGHLIGHT_TEX ~= "" then
				btn:SetHighlightTexture(K.BAR_BTN_HIGHLIGHT_TEX)
				Ns:ApplyAtlasOrFallback(btn:GetHighlightTexture(), "ButtonHighlight", function(t) t:SetTexture(K.BAR_BTN_HIGHLIGHT_TEX) end)
				btn:GetHighlightTexture():SetVertexColor(K.BAR_BTN_HIGHLIGHT_R, K.BAR_BTN_HIGHLIGHT_G, K.BAR_BTN_HIGHLIGHT_B, K.BAR_BTN_HIGHLIGHT_A)
			end
			btn.Text = btn:CreateFontString(nil, "OVERLAY")
			btn.Text:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4, "")
			btn.Text:SetPoint("LEFT", 8, 0)
			btn.Text:SetPoint("RIGHT", btn, "RIGHT", -22, 0)
			btn.Text:SetJustifyH("LEFT")

			btn.Remove = CreateFrame("Button", nil, btn)
			btn.Remove:SetSize(14, 14)
			btn.Remove:SetPoint("RIGHT", -4, 0)
			local _delTex = K.HUD_DELETE_CLOSE_TEX ~= "" and K.HUD_DELETE_CLOSE_TEX or (Ns.TexturePath .. "Close")
			btn.Remove:SetNormalTexture(_delTex)
			btn.Remove:GetNormalTexture():SetVertexColor(0.6, 0.6, 0.6, 1)
			btn.Remove:SetHighlightTexture(_delTex)
			btn.Remove:GetHighlightTexture():SetVertexColor(1, 0.3, 0.3, 1)
			self.DeleteItems[i] = btn
		end

		btn.Text:SetText(pName)

		-- Only allow deleting non-Main, non-active panels when more than 1 exists
		local canDelete = (#Ns.ProfileRoot.PanelOrder > 1) and (pName ~= "Main") and (pName ~= Ns.ProfileRoot.ActivePanel)
		btn.Remove:SetShown(canDelete)

		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT", self.DeleteLabel, "BOTTOMLEFT", 0, -(5 + (i - 1) * (btnHeight + btnSpacing)))

		local targetName = pName
		local itemBtn = btn
		btn.Remove:SetScript("OnClick", function()
			PlayOnCheck()
			self.DeleteTargetPanel = targetName
			self.DeleteTargetBtn = itemBtn
			self:RunAction("delete")
		end)

		btn:Show()
	end

	-- Hide extra items from previous list
	for i = #Ns.ProfileRoot.PanelOrder + 1, #self.DeleteItems do
		self.DeleteItems[i]:Hide()
	end
end

function Mixins.functions.PanelConfig.Reset(self)
	if self.SelectList then Ns:KillWidget(self.SelectList); self.SelectList = nil end
	for _, btn in ipairs(self.DeleteItems) do
		btn:Hide()
	end
end

------------------------------
--			Sliders			--
------------------------------
function W.Slider(parent)

	local wrap = CreateFrame("Frame", nil, parent)
	wrap.SpecialType = "Slider"
	AddTipText(wrap)

	wrap.Label = wrap:CreateFontString()
	wrap.Label:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4)
	wrap.Label:SetJustifyH("LEFT")
	wrap.Label:SetPoint("LEFT", wrap, "LEFT", 2, -6)
	wrap.Label:SetTextColor(K.WIDGET_LABEL_R, K.WIDGET_LABEL_G, K.WIDGET_LABEL_B, K.WIDGET_LABEL_A)
	wrap.Label:Hide()

	local f = CreateFrame("Slider", nil, wrap, BackdropTemplateMixin and "BackdropTemplate")
	wrap.Slider = f
	f:SetSize(100, K.SLIDER_TRACK_H)
	f:SetPoint("RIGHT", wrap, "RIGHT", 0, 0)
	f:SetPoint("TOP", wrap, "TOP", 0, 0)
	f:SetPoint("BOTTOM", wrap, "BOTTOM", 0, 0)
	wrap:SetHeight(K.SLIDER_TRACK_H)
	f:SetBackdrop(SliderBG)
	f:SetBackdropColor(K.SLIDER_TRACK_R, K.SLIDER_TRACK_G, K.SLIDER_TRACK_B, K.SLIDER_BG_ALPHA)
	f:SetBackdropBorderColor(0.184, 0.184, 0.184, 0.3)
	if K.SLIDER_TRACK_TEX ~= "" then
		f.TrackTex = f:CreateTexture(nil, "BACKGROUND", nil, 1)
		f.TrackTex:SetAllPoints()
		f.TrackTex:SetTexture(K.SLIDER_TRACK_TEX)
		f.TrackTex:SetVertexColor(K.SLIDER_TRACK_R, K.SLIDER_TRACK_G, K.SLIDER_TRACK_B, K.SLIDER_BG_ALPHA)
	end
	f:SetValueStep(1)
	f:SetObeyStepOnDrag(true)
	f:SetOrientation("HORIZONTAL")
	f:SetFrameLevel(4)
	--CreateBorder(f, 0)
	--local thumbTex = K.c ~= "" and K.SLIDER_THUMB_TEX or (Ns.TexturePath.."SliderThumb")
	local thumbTex = Ns.TexturePath.."SliderThumb"
	f:SetThumbTexture(thumbTex)
	f:GetThumbTexture():SetSize(K.SLIDER_THUMB_W, K.SLIDER_THUMB_H)
	f:GetThumbTexture():SetVertexColor(K.SLIDER_THUMB_R, K.SLIDER_THUMB_G, K.SLIDER_THUMB_B, K.SLIDER_THUMB_A)
	f:GetThumbTexture():SetBlendMode("ADD")
	f:SetFrameStrata("DIALOG")
	f.Min = f:CreateFontString()
	f.Min:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 5)
	f.Min:SetPoint("LEFT", 3, -12)
	f.Min:SetJustifyH("LEFT")
	f.Min:SetJustifyV("BOTTOM")
	f.Max = f:CreateFontString()
	f.Max:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 5)
	f.Max:SetPoint("RIGHT", -4, -12)
	f.Max:SetJustifyH("RIGHT")
	f.Max:SetJustifyV("BOTTOM")
	f.Edit = W.BaseEditBox(f, 50, 16)
	f.Edit:SetPoint("TOP", f, "BOTTOM", 0, -2)
	--CreateBorder(f.Edit, 0)
	f.Edit:SetFont(Ns.ConfigDefaultFont2, 11, "")
	f.Edit:SetTextColor(1, 1, 1)
	f.Edit:SetJustifyH("CENTER")
	Mixin(f.Edit, Mixins.functions.SliderEdit)
	for k, v in pairs(Mixins.scripts.SliderEdit) do
		f.Edit:SetScript(k, v)
	end

	local leftArrowTex = K.SLIDER_ARROW_LEFT ~= "" and K.SLIDER_ARROW_LEFT
	local rightArrowTex = K.SLIDER_ARROW_RIGHT ~= "" and K.SLIDER_ARROW_RIGHT
	local leftArrow = CreateFrame("Button", nil, f)
	leftArrow:SetSize(K.SLIDER_ARROW_W, K.SLIDER_ARROW_H)
	leftArrow:SetPoint("RIGHT", f.Edit, "LEFT", 0, 0)
	leftArrow.Icon = leftArrow:CreateTexture(nil, "ARTWORK")
	leftArrow.Icon:SetAllPoints()
	leftArrow.Icon:SetTexture(leftArrowTex)
	--leftArrow.Icon:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
	--leftArrow.Icon:SetVertexColor(K.SLIDER_ARROW_R, K.SLIDER_ARROW_G, K.SLIDER_ARROW_B, K.SLIDER_ARROW_A)
	leftArrow:SetScript("OnEnter", function(self) self.Icon:SetAlpha(K.SLIDER_ARROW_A) end)
	leftArrow:SetScript("OnLeave", function(self) self.Icon:SetAlpha(1) end)
	leftArrow:SetScript("OnClick", function()
		local step = f:GetValueStep()
		f:SetValue(f:GetValue() - step)
	end)
	f.LeftArrow = leftArrow

	local rightArrow = CreateFrame("Button", nil, f)
	rightArrow:SetSize(K.SLIDER_ARROW_W, K.SLIDER_ARROW_H)
	rightArrow:SetPoint("LEFT", f.Edit, "RIGHT", 0, 0)
	rightArrow.Icon = rightArrow:CreateTexture(nil, "ARTWORK")
	rightArrow.Icon:SetAllPoints()
	rightArrow.Icon:SetTexture(rightArrowTex)
	--rightArrow.Icon:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0)
	--rightArrow.Icon:SetVertexColor(K.SLIDER_ARROW_R, K.SLIDER_ARROW_G, K.SLIDER_ARROW_B, K.SLIDER_ARROW_A)
	rightArrow:SetScript("OnEnter", function(self) self.Icon:SetAlpha(K.SLIDER_ARROW_A) end)
	rightArrow:SetScript("OnLeave", function(self) self.Icon:SetAlpha(1) end)
	rightArrow:SetScript("OnClick", function()
		local step = f:GetValueStep()
		f:SetValue(f:GetValue() + step)
	end)
	f.RightArrow = rightArrow

	wrap.Edit = f.Edit
	wrap.Min  = f.Min
	wrap.Max  = f.Max

	wrap.GetValue        = function(self) return f:GetValue() end
	wrap.SetValue        = function(self, v) f:SetValue(v) end
	wrap.GetMinMaxValues = function(self) return f:GetMinMaxValues() end
	wrap.SetMinMaxValues = function(self, min, max) f:SetMinMaxValues(min, max) end
	wrap.GetValueStep    = function(self) return f:GetValueStep() end
	wrap.SetValueStep    = function(self, v) f:SetValueStep(v) end
	wrap.SetObeyStepOnDrag = function(self, b) f:SetObeyStepOnDrag(b) end
	wrap.SetThumbTexture = function(self, t) f:SetThumbTexture(t) end
	wrap.GetThumbTexture = function(self) return f:GetThumbTexture() end
	wrap.SetOrientation  = function(self, o) f:SetOrientation(o) end

	wrap.SetEnabled = function(self, e)
		f:SetEnabled(e)
		f:SetAlpha(e and 1 or 0.5)
		if self.Label then self.Label:SetAlpha(e and 1 or 0.5) end
	end

	Mixin(wrap, Mixins.functions.Slider)
	for k, v in pairs(Mixins.scripts.Slider) do
		f:SetScript(k, v)
	end
	return wrap
end

Mixins.functions.SliderEdit = {}
function Mixins.functions.SliderEdit.GetValue(self)
	return self:GetNumber()
end

function Mixins.functions.SliderEdit.SetValue(self, value)
	local n = format("%.1f", value)
	self:SetText(n)
end


Mixins.scripts.SliderEdit = {}
function Mixins.scripts.SliderEdit.OnEnterPressed(self)
	local value = self:GetValue()
	local min, max = self:GetParent():GetMinMaxValues()
	if value < min then
		value = min
	end
	if value > max then
		value = max
	end
	self:SetValue(value)
	self:GetParent():SetValue(value)
	self:ClearFocus()
end

Mixins.functions.Slider = {}
--local minMaxFormat = "- %s -"
function Mixins.functions.Slider.Init(self, anchorframe, parent, displaylist, orderlist)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.Key = self.MyInformation.stat

	local s = self.Slider  -- the actual Slider child
	s.MyInformation = self.MyInformation
	s.Settings = self.Settings
	s.Key = self.Key
	s:SetEnabled(true)
	s:SetWidth(self.MyInformation.widget.width)

	local min, max, value = self.MyInformation.widget.min, self.MyInformation.widget.max, self.Settings[self.Key]
	if value == nil then value = self.MyInformation.default or min end
	s.Min:SetText(type(min) == "string" and L[min] or min)
	s.Max:SetText(type(max) == "string" and L[max] or max)
	s:SetMinMaxValues(min, max)
	local step = self.MyInformation.widget.valuestep
	if step then s:SetValueStep(step) end
	s:SetValue(value)

	self.Tip:SetText(format(TipFormat, L[self.Key.."Tip"]))
	self.Tip:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	s.Edit:SetValue(value)

	if self.Label then
		self.Label:SetText(L[self.MyInformation.stat] or L[self.MyInformation.stat.."Menu"] or "")
		self.Label:SetJustifyH("LEFT")
		self.Label:SetTextColor(K.WIDGET_LABEL_R, K.WIDGET_LABEL_G, K.WIDGET_LABEL_B, K.WIDGET_LABEL_A)
		self.Label:Show()
		local labelW = ceil(self.Label:GetStringWidth() or 0)
		self:SetWidth(labelW + K.WIDGET_LABEL_GAP + (self.MyInformation.widget.width or 100))
	end
end

Mixins.scripts.Slider = {}
function Mixins.scripts.Slider.OnValueChanged(self, value)
    if self.Settings[self.Key] == value then return end
    	self.Edit:SetValue(value)
	self.Settings[self.Key] = value
	Ns:QueueProfileRefresh()
end
function Mixins.scripts.Slider.OnDisable(self)
	self:SetAlpha(0.5)
	local wrap = self:GetParent()
	if wrap.Label then wrap.Label:SetAlpha(0.5) end
end

function Mixins.scripts.Slider.OnEnable(self)
	self:SetAlpha(1)
	local wrap = self:GetParent()
	if wrap.Label then wrap.Label:SetAlpha(1) end
end

------------------------------
--			ToolTip			--
------------------------------
function W.Tooltip(parent)
	if not gttFont then
		gttFont, gttFontSize, gttFontFlags = GameTooltipHeaderText:GetFont()
	end
	local f = CreateFrame("Frame")
	f.SpecialType = "Tooltip"
	f:SetSize(K.TOOLTIP_ICON_W, K.TOOLTIP_ICON_H)
	f.Texture = f:CreateTexture()
	f.Texture:SetAllPoints()
	f.Texture:SetTexture(K.TOOLTIP_ICON_TEX ~= "" and K.TOOLTIP_ICON_TEX or (Ns.TexturePath.."Misc"))
	Mixin(f, Mixins.functions.Tooltip)
	for k, v in pairs(Mixins.scripts.Tooltip) do
		f:SetScript(k, v)
	end
	return f
end

Mixins.functions.Tooltip = {}
function Mixins.functions.Tooltip.Init(self, parent, settings)
	self:Show()
	self:SetFrameStrata(parent:GetFrameStrata())
	self:SetFrameLevel(parent:GetFrameLevel() + 1)
	self:ClearAllPoints()
	local gap = K.TOOLTIP_ICON_GAP or 4
	if parent.Label and parent.Label:GetText() and parent.Label:GetText() ~= "" then
		local textW = parent.Label:GetStringWidth() or 0
		if textW > 0 then
			self:SetPoint("LEFT", parent.Label, "LEFT", textW + gap, 1)
		elseif parent.Tip then
			self:SetPoint("LEFT", parent.Tip, "RIGHT", gap, 1)
		else
			local points = TooltipOffsets[parent.SpecialType] or TooltipOffsets.Default
			self:SetPoint(points.point, parent, points.topoint, points.x, points.y)
		end
	elseif parent.Tip then
		self:SetPoint("LEFT", parent.Tip, "RIGHT", gap, 1)
	else
		local points = TooltipOffsets[parent.SpecialType] or TooltipOffsets.Default
		self:SetPoint(points.point, parent, points.topoint, points.x, points.y)
	end
	self.Tip = settings.stat.."Tooltip"
end

function Mixins.functions.Tooltip.Reset(self)
	self.Tip = nil
	self:Hide()
end

Mixins.functions.Tooltip = {}
function Mixins.functions.Tooltip.Init(self, parent, settings)
	self:SetParent(parent)
	self:Show()
	self:SetFrameStrata(parent:GetFrameStrata())
	self:SetFrameLevel(parent:GetFrameLevel() + 1)
	self:ClearAllPoints()
	local gap = K.TOOLTIP_ICON_GAP or 4
	if parent.Label and parent.Label:GetText() and parent.Label:GetText() ~= "" then
		local textW = parent.Label:GetStringWidth() or 0
		if textW > 0 then
			self:SetPoint("LEFT", parent.Label, "LEFT", textW + gap, 1)
		elseif parent.Tip then
			self:SetPoint("LEFT", parent.Tip, "RIGHT", gap, 1)
		else
			local points = TooltipOffsets[parent.SpecialType] or TooltipOffsets.Default
			self:SetPoint(points.point, parent, points.topoint, points.x, points.y)
		end
	elseif parent.Tip then
		self:SetPoint("LEFT", parent.Tip, "RIGHT", gap, 1)
	else
		local points = TooltipOffsets[parent.SpecialType] or TooltipOffsets.Default
		self:SetPoint(points.point, parent, points.topoint, points.x, points.y)
	end
	self.Tip = settings.stat.."Tooltip"
end

function Mixins.functions.Tooltip.Reset(self)
	self.Tip = nil
	self:Hide()
end

Mixins.scripts.Tooltip = {}
function Mixins.scripts.Tooltip.OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
	GameTooltipHeaderText:SetFont(Ns.ConfigDefaultFont, 12, "")
	GameTooltip:SetText(L[self.Tip])
end
function Mixins.scripts.Tooltip.OnLeave(self)
	GameTooltipHeaderText:SetFont(gttFont, gttFontSize, gttFontFlags)
	GameTooltip:Hide()
end

----------------------------------
--			Top Tabs			--
----------------------------------

local function ApplyTopTabTex(button, slot, tex)
	if tex == "" then
		if slot == "highlight" then
			tex = K.TOP_TAB_FALLBACK_HOVER_TEX
		else
			tex = K.TOP_TAB_FALLBACK_IDLE_TEX
		end
	end
	if slot == "normal" then
		button:SetNormalTexture(tex)
	else
		button:SetHighlightTexture(tex)
	end
	local texture = (slot == "normal") and button:GetNormalTexture() or button:GetHighlightTexture()
	-- Apply L/R/T/B inset gaps to the tab's idle/normal background textures.
	if tex == K.TOP_TAB_IDLE_TEX or tex == K.TOP_TAB_NORMAL_TEX then
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", K.TOP_TAB_TEX_GAP_L, -K.TOP_TAB_TEX_GAP_T)
		texture:SetPoint("BOTTOMRIGHT", -K.TOP_TAB_TEX_GAP_R, K.TOP_TAB_TEX_GAP_B)
	elseif tex == K.TOP_TAB_CHECKED_TEX or tex == K.TOP_TAB_FALLBACK_CHECKED_TEX then
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", K.TOP_TAB_CHECKED_GAP_L, -K.TOP_TAB_CHECKED_GAP_T)
		texture:SetPoint("BOTTOMRIGHT", -K.TOP_TAB_CHECKED_GAP_R, K.TOP_TAB_CHECKED_GAP_B)
	else
		texture:ClearAllPoints()
		texture:SetAllPoints()
	end
	return texture
end

function W.TopTab(parent, width)
	local f = CreateFrame("Button", nil, parent)
	f:SetSize(50, Ns.TopTabHeight)
	f.SpecialType = "TopTab"
	Mixin(f, Mixins.functions.TopTab)
	AddLabel(f)
	f:AnchorLabel("CENTER")
	hooksecurefunc(f, "SetLabel", AdjustTopTabText)
	f.Properties = {}
	local nt = ApplyTopTabTex(f, "normal",    K.TOP_TAB_NORMAL_TEX)
	if K.TOP_TAB_NORMAL_TEX ~= "" then
		nt:SetVertexColor(K.TOP_TAB_NORMAL_R, K.TOP_TAB_NORMAL_G, K.TOP_TAB_NORMAL_B, K.TOP_TAB_NORMAL_A)
	else
		nt:SetVertexColor(K.TOP_TAB_IDLE_R, K.TOP_TAB_IDLE_G, K.TOP_TAB_IDLE_B, K.TOP_TAB_IDLE_A)
	end
	nt:SetBlendMode("BLEND")
	nt:SetDesaturated(K.TOP_TAB_NORMAL_DESATURATED)
	local ht = ApplyTopTabTex(f, "highlight", K.TOP_TAB_HOVER_TEX)
	ht:SetVertexColor(K.TOP_TAB_HOVER_R, K.TOP_TAB_HOVER_G, K.TOP_TAB_HOVER_B, K.TOP_TAB_HOVER_A)
	ht:SetDesaturated(K.TOP_TAB_HOVER_DESATURATED)
	-- Second checked-state texture (TOP_TAB_CHECKED_2_TEX). Shown only while
	-- checked; the highlight slot stays hover-only.
	f.Checked2 = f:CreateTexture(nil, "ARTWORK", nil, 1)
	f.Checked2:Hide()
	for k, v in pairs(Mixins.scripts.TopTab) do
		f:SetScript(k, v)
	end

	f.Status = Ns:GetWidget("CheckButton", f) -- TOP TAB CHECKBOX
	f.Status:SetSize(K.TOP_TAB_CHECK_SIZE, K.TOP_TAB_CHECK_SIZE)

	if K.TOP_TAB_CHECKMARK_SIZE and K.TOP_TAB_CHECKMARK_SIZE > 0 then
		local ct = f.Status:GetCheckedTexture()
		if ct then
			ct:ClearAllPoints()
			ct:SetPoint("CENTER", f.Status, "CENTER")
			ct:SetSize(K.TOP_TAB_CHECKMARK_SIZE, K.TOP_TAB_CHECKMARK_SIZE)
		end
	end
	f.Status:SetPoint("RIGHT", -4, 0)
	f.Status:SetFrameLevel(f:GetFrameLevel() + 4)
	local sht = ApplyTopTabTex(f.Status, "highlight", K.TOP_TAB_HOVER_TEX)
	f.Status:GetHighlightTexture():ClearAllPoints()
	f.Status:GetHighlightTexture():SetAllPoints(f:GetHighlightTexture())
	sht:SetVertexColor(K.TOP_TAB_HOVER_R, K.TOP_TAB_HOVER_G, K.TOP_TAB_HOVER_B, K.TOP_TAB_HOVER_A)
	sht:SetDesaturated(K.TOP_TAB_HOVER_DESATURATED)
	return f
end

Mixins.functions.TopTab = {}
function Mixins.functions.TopTab.Init(self, anchorframe, parent, noicons)
	self.AnchorFrame = anchorframe
	self.Parent = parent
	self.MyInformation = parent.DisplayOrder[self:GetID()]
--	self.GroupOrder = nil
	self.DisplayOrder = parent.NextDisplayOrder
	self.SvTable = parent.SvTable
	self.Key = self.MyInformation.stat.."Menu"
	if self.ActiveOnInit then
		self:Click()
		self.ActiveOnInit = nil
	else
		--self:GetNormalTexture():SetAlpha(0.3)
		local nt = ApplyTopTabTex(self, "normal", K.TOP_TAB_IDLE_TEX)
		nt:SetVertexColor(K.TOP_TAB_IDLE_R, K.TOP_TAB_IDLE_G, K.TOP_TAB_IDLE_B, K.TOP_TAB_IDLE_A)
		nt:SetBlendMode("BLEND")
		nt:SetDesaturated(K.TOP_TAB_NORMAL_DESATURATED)
		self:UnlockHighlight()
		if self.Checked2 then self.Checked2:Hide() end
		self.Properties.Checked = false
		--self.Label:SetTextColor(0.7, 0.7, 0.7)
	end
	self:SetLabel(GetLabelText(self.Key, self.MyInformation, noicons))
	if type(self.SvTable[self.MyInformation.stat]) == "table" then --[self.MyInformation.stat].Show then
		self.Status.MyInformation = parent.DisplayOrder[self:GetID()]
		self.Status.Settings = self.SvTable[self.MyInformation.stat]
		self.Status.Key = "Show"
		self.Status:SetChecked(self.Status.Settings[self.Status.Key])
		self.Status:Show()
		self:AnchorLabel("LEFT", 6, 0, true)
	else
		if self.MyInformation.enabled and self.MyInformation.enabledval then
			if Ns.Profile[self.MyInformation.enabled] ~= self.MyInformation.enabledval then
				self:SetEnabled(false)
			end
		end
		self:AnchorLabel("CENTER")
		self.Status:Hide()
	end
end

function Mixins.functions.TopTab.Reset(self)
	wipe(self.Properties)
	self:UnlockHighlight()
	if self.Checked2 then self.Checked2:Hide() end
	self.Status:Reset()
end

Mixins.scripts.TopTab = {}
function Mixins.scripts.TopTab.OnClick(self)
	--PlayOnTab()
	local parent = self.AnchorFrame or self:GetParent()
	if parent.ActiveWidget and parent.ActiveWidget == self then
		return
	end
	self.Properties.Checked = not self.Properties.Checked
	if self.Properties.Checked then
		--self:GetNormalTexture():SetVertexColor(greenColor.r, greenColor.g, greenColor.b, 0.3)
		local checkedTex = K.TOP_TAB_CHECKED_TEX ~= "" and K.TOP_TAB_CHECKED_TEX or K.TOP_TAB_FALLBACK_CHECKED_TEX
		local nt = ApplyTopTabTex(self, "normal", checkedTex)
		nt:SetVertexColor(K.TOP_TAB_CHECKED_R, K.TOP_TAB_CHECKED_G, K.TOP_TAB_CHECKED_B, K.TOP_TAB_CHECKED_A)
		nt:SetBlendMode(K.TOP_TAB_CHECKED_BLEND_MODE ~= "" and K.TOP_TAB_CHECKED_BLEND_MODE or "BLEND")
		nt:SetDesaturated(K.TOP_TAB_CHECKED_DESATURATED)
		-- Dedicated checked-state second texture (hover slot is hover-only).
		local checked2Tex = K.TOP_TAB_CHECKED_2_TEX ~= "" and K.TOP_TAB_CHECKED_2_TEX or K.TOP_TAB_FALLBACK_CHECKED_2_TEX
		if checked2Tex and checked2Tex ~= "" and self.Checked2 then
			self.Checked2:ClearAllPoints()
			self.Checked2:SetAllPoints()
			self.Checked2:SetTexture(checked2Tex)
			self.Checked2:SetVertexColor(1, 1, 1, 1)
			self.Checked2:SetBlendMode("BLEND")
			self.Checked2:SetDesaturated(K.TOP_TAB_CHECKED_DESATURATED)
			self.Checked2:Show()
		elseif self.Checked2 then
			self.Checked2:Hide()
		end
		--self:GetNormalTexture():SetAlpha(1)
		--self.Label:SetTextColor(1, 1, 1)
	else
		--self:GetNormalTexture():SetVertexColor(topTabColor.r, topTabColor.g, topTabColor.b, 0.3)
		local nt = ApplyTopTabTex(self, "normal", K.TOP_TAB_IDLE_TEX)
		nt:SetVertexColor(K.TOP_TAB_IDLE_R, K.TOP_TAB_IDLE_G, K.TOP_TAB_IDLE_B, K.TOP_TAB_IDLE_A)
		nt:SetBlendMode("BLEND")
		nt:SetDesaturated(K.TOP_TAB_NORMAL_DESATURATED)
		self:UnlockHighlight()
		if self.Checked2 then self.Checked2:Hide() end
		--self.Label:SetTextColor(1, 1,m)
	end
	KillPage("ChildAnchor")
	if self.Properties.Checked then
		self.AnchorFrame:SetActive(self)
		Ns.ConfigFrame.ChildAnchor = Ns:GetWidget("AnchorFrame", Ns.ConfigFrame)
		Ns.ConfigFrame.ChildAnchor:SetLabel("")
		Ns.ConfigFrame.ChildAnchor.Description:SetText(format(Ns.WidgetDisplayFormat, Ns:GetSpellIcon(self.MyInformation), L[self.MyInformation.stat.."Menu"])) -- .."Description" STATS TOP LINE TEXT
		Ns.ConfigFrame.ChildAnchor.Description:SetTextColor(K.STAT_DESC_R, K.STAT_DESC_G, K.STAT_DESC_B, K.STAT_DESC_A)
		Ns.ConfigFrame.ChildAnchor.CenterAlign = self.MyInformation.centeralign
		self.Parent.DisplayFunc(self, Ns.ConfigFrame.ChildAnchor, self.AnchorFrame, false, true, self.MyInformation.taboffset)
		for k, v in pairs(Ns.ConfigFrame.ChildAnchor.CurrentWidgets) do
			if v.Check and v.Check.Key == "Show" then
				v.Check.ParentLink = self.Status
				self.Status.ChildLink = v.Check
			end
		end
		Ns.ConfigFrame.ChildAnchor:Show()
	end
end

function Mixins.scripts.TopTab.OnDisable(self)
	self:SetAlpha(0.5)
end

function Mixins.scripts.TopTab.OnEnable(self)
	self:SetAlpha(1)
end

------------------------------------------
--			Get/Kill Widgets			--
------------------------------------------
function Ns:GetWidget(widgettype, parent, id)
	local widget
	if WidgetPool[widgettype] and #WidgetPool[widgettype] > 0 then
		local pool = WidgetPool[widgettype]
		widget = pool[#pool]
		pool[#pool] = nil
	end
	if not widget then
		widget = W[widgettype](parent, id)
	elseif parent then
		widget:SetParent(parent)
	end
	if type(id) == "number" then
		widget:SetID(id)
	end
	return widget
end

function Ns:KillWidget(widget)
	widget:Hide()
	local widgettype = widget.SpecialType or widget:GetObjectType()
	if not WidgetPool[widgettype] then
		WidgetPool[widgettype] = {}
	end
	tinsert(WidgetPool[widgettype], widget)
	widget:ClearAllPoints()
	widget:SetID(-1)
	if widget.Reset then
		widget:Reset()
	end
	if widget.Tooltip then
		Ns:KillWidget(widget.Tooltip)
		widget.Tooltip = nil
	end
end

----------------------------------
--			Edit Box			--
----------------------------------
--[[
local function EditBox_Init(self)--, data, index)
	local text = self.Data[self.Index]
	if not text then
		text = ""
	end
	self.prevvalue = text
	self:SetText(text)
end
]]--

function W.BaseEditBox(parent, width, height)
	local templates = "InputBoxTemplate"
	if BackdropTemplateMixin then
		templates = templates .. ", BackdropTemplate"
	end
	local f = CreateFrame("EditBox", nil, parent, templates)
	f:SetBackdrop(EditBoxBG)
	f:SetBackdropColor(0.27451, 0.27451, 0.27451, K.EDITBOX_BG_ALPHA)
	f:SetBackdropBorderColor(0, 0, 0, 1)
	f.Left:Hide()
	f.Right:Hide()
	f.Middle:Hide()
	f.BgAtlas = f:CreateTexture(nil, "BACKGROUND", nil, 1)
	f.BgAtlas:SetPoint("TOPLEFT",     f, "TOPLEFT",     -K.EDITBOX_BG_X_INSET,  K.EDITBOX_BG_Y_INSET)
	f.BgAtlas:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT",  K.EDITBOX_BG_X_INSET, -K.EDITBOX_BG_Y_INSET)
	Ns:ApplyAtlasOrFallback(f.BgAtlas, "EditBoxBg", function(t) t:SetTexture(K.EDITBOX_TEX) end)
	f:SetBackdropColor(0, 0, 0, 0)
	f:SetBackdropBorderColor(0, 0, 0, 0)
	f:SetFont(Ns.ConfigDefaultFont, 12, "")
	f:SetJustifyH("LEFT")

	f._extraLeftPad = 6
	local origSetTextInsets = f.SetTextInsets
	f.SetTextInsets = function(self, l, r, t, b)
		return origSetTextInsets(self, (l or 0) + (self._extraLeftPad or 0), r, t, b)
	end

	local l, r, t, b = f:GetTextInsets()
	f:SetTextInsets(l, r, t, b)
	if width and height then
		f:SetSize(width, height)
	end
	f:SetMaxLetters(80)
	f:SetAutoFocus(false)
	f:SetScript("OnEscapePressed", function(self)
		if self.prevvalue then
			self:SetText(self.prevvalue)
		else
			self:SetText("")
		end
		self:ClearFocus()
	end)
	return f
end

function W.EditBox(parent)
	local f = W.BaseEditBox(parent)
	f.SpecialType = "EditBox"
	Mixin(f, Mixins.functions.EditBox)
	AddLabel(f)

	f.Label:SetPoint("LEFT", f, "LEFT", 2 - 4, 0)
	f.Label:Hide()
	AddTipText(f)
	for k, v in pairs(Mixins.scripts.EditBox) do
		f:SetScript(k, v)
	end
	return f
end

Mixins.functions.EditBox = {}
function Mixins.functions.EditBox.Init(self, anchorframe, parent, displaylist, orderlist)
--	self:SetParent(parent)
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.Settings = parent.MyInformation.svnotintable and parent.SvTable or parent.SvTable[parent.MyInformation.stat]
	self.Key = self.MyInformation.stat
	local wi = self.MyInformation.widget
	if wi.width  then self:SetWidth(wi.width)   end
	if wi.height then self:SetHeight(wi.height) end
			self:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4, "")

	self._extraLeftPad = 2
	local l, r, t, b = self:GetTextInsets()
	self:SetTextInsets(l, r, t, b)
	self:SetValue(self.Settings[self.Key] or "")

	if anchorframe.SpecialType == "AnchorFrame" then
		self:SetJustifyH("LEFT")
	end

	if self.Label then
		if anchorframe.SpecialType == "AnchorFrame" then
			self:SetLabel(GetLabelText(self.MyInformation.stat, self.MyInformation, true))
			self.Label:SetTextColor(K.WIDGET_LABEL_R, K.WIDGET_LABEL_G, K.WIDGET_LABEL_B, K.WIDGET_LABEL_A)
			self.Label:ClearAllPoints()
			self.Label:SetPoint("LEFT", self, "LEFT", 2, 0)
			self.Label:Show()
			self.Tip:SetText(format(TipFormat, L[self.Key.."Tip"]))
			self.Tip:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)

			local labelW = ceil(self.Label:GetStringWidth() or 0)
			self:SetWidth(labelW + K.WIDGET_LABEL_GAP + (wi.width or 100))

			if self.BgAtlas then
				self.BgAtlas:ClearAllPoints()
				self.BgAtlas:SetPoint("TOP",    self,       "TOP",    0,  K.EDITBOX_BG_Y_INSET)
				self.BgAtlas:SetPoint("BOTTOM", self,       "BOTTOM", 0, -K.EDITBOX_BG_Y_INSET)
				self.BgAtlas:SetPoint("LEFT",   self.Label, "RIGHT",  K.WIDGET_LABEL_GAP - K.EDITBOX_BG_X_INSET, 0)
				self.BgAtlas:SetPoint("RIGHT",  self,       "RIGHT",  K.EDITBOX_BG_X_INSET, 0)
			end
		else

			self.Label:Hide()
			if self.BgAtlas then
				self.BgAtlas:ClearAllPoints()
				self.BgAtlas:SetPoint("TOPLEFT",     self, "TOPLEFT",     -K.EDITBOX_BG_X_INSET,  K.EDITBOX_BG_Y_INSET)
				self.BgAtlas:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT",  K.EDITBOX_BG_X_INSET, -K.EDITBOX_BG_Y_INSET)
			end
		end
	end
end

function Mixins.functions.EditBox.SetEnabled(self, enabled)
	self:EnableMouse(enabled)
	self:EnableKeyboard(enabled)
	if enabled then
		self:SetAlpha(1)
	else
		self:ClearFocus()
		self:SetAlpha(0.4)
	end
end

function Mixins.functions.EditBox.Reset(self)
	self:SetEnabled(true)
end

function Mixins.functions.EditBox.GetValue(self)
	if self.MyInformation.widget.numeric then
		return self:GetNumber()
	else
		return self:GetText()
	end
end

function Mixins.functions.EditBox.SetValue(self, value)
	if self.MyInformation.widget.numeric then
		value = tonumber(value)
		if self.MyInformation.widget.format then
			value = format(self.MyInformation.widget.format, value)
		end
	end
	self:SetText(value)
	self.prevvalue = value
end

Mixins.scripts.EditBox = {}
function Mixins.scripts.EditBox.OnEditFocusGained(self)
	self:HighlightText()
end

function Mixins.scripts.EditBox.OnEnterPressed(self)
	local value = self:GetValue()
	self:SetValue(value)
	self.Settings[self.Key] = value
	self:ClearFocus()
	Ns:QueueProfileRefresh()
end

----------------------------------
--			DragStat			--
----------------------------------
local DSWidth, DSHeight, Spacer = 120, 20, 12
function W.DragStat(parent)
	local f = CreateFrame("Button", nil, parent, "BackdropTemplate")
	f.SpecialType = "DragStat"
	f:SetSize(DSWidth, DSHeight)
	f:EnableMouse(false)
	f.IdText = f:CreateFontString()
	f.IdText:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 6)
	f.IdText:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b, 1)
	f.IdText:SetPoint("LEFT", 5, 0)
	f.Icon = f:CreateTexture(nil, "ARTWORK")
	f.Icon:SetSize(14, 14)
	f.Icon:SetPoint("LEFT", f.IdText, "RIGHT", 3, 0)
	f.Text = f:CreateFontString()
	f.Text:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4)
	f.Text:SetJustifyH("LEFT")
	f.Text:SetPoint("LEFT", f.Icon, "RIGHT", 3, 0)
	f:SetBackdrop(DragBG)
	f:SetBackdropColor(0, 0, 0, 0)
	--f:SetBackdropBorderColor(greenColor.r, greenColor.g, greenColor.b, 0)

	f.BgAtlas = f:CreateTexture(nil, "BACKGROUND", nil, 0)
	f.BgAtlas:SetAllPoints()
	if K.LAYOUT_STAT_BAR_TEX ~= "" then f.BgAtlas:SetTexture(K.LAYOUT_STAT_BAR_TEX) end
	if K.LAYOUT_STAT_HIGHLIGHT_TEX ~= "" then
		f:SetHighlightTexture(K.LAYOUT_STAT_HIGHLIGHT_TEX)
		Ns:ApplyAtlasOrFallback(f:GetHighlightTexture(), "ButtonHighlight", function(t) t:SetTexture(K.LAYOUT_STAT_HIGHLIGHT_TEX) end)
		f:GetHighlightTexture():SetVertexColor(K.LAYOUT_STAT_HIGHLIGHT_R, K.LAYOUT_STAT_HIGHLIGHT_G, K.LAYOUT_STAT_HIGHLIGHT_B, K.LAYOUT_STAT_HIGHLIGHT_A)
	end
	Mixin(f, Mixins.functions.DragStat)
	for k, v in pairs(Mixins.scripts.DragStat) do
		f:SetScript(k, v)
	end

	f.NewColumn = Ns:GetWidget("CheckButton", f)
	f.NewColumn:SetPoint("RIGHT", -3, 0)
	f.NewColumn:SetSize(12,12)
	f.NewColumn:SetCheckedTexture(Ns.TexturePath.."CheckColumn")
	f.NewColumn:GetCheckedTexture():SetVertexColor(1, 1, 1)

	return f
end
Mixins.functions.DragStat = {}

function Mixins.functions.DragStat.Init(self, parent, id, shufflefunc)
	self:SetParent(parent)
	self.ID = id
	if not self.LastOrder then
		if self.ID == 1 then
			if self.NewColumn:GetChecked() then
				self.NewColumn:Click()
			end
			self.NewColumn:Hide()
		elseif self.ID > 1 then
			self.NewColumn:Show()
		end
	end
	self.ShuffleFunc = shufflefunc
end

function Mixins.functions.DragStat.GetText(self)
	return self.Text:GetText()
end

function Mixins.functions.DragStat.Reset(self)
	self.ID = nil
	self.IdText:SetText("")
	self.ShuffleFunc = nil
end

function Mixins.functions.DragStat.SetIDText(self, text)
	self.IdText:SetText(text)
end

function Mixins.functions.DragStat.SetText(self, text)
	self.Text:SetText(text)
end

Mixins.scripts.DragStat = {}
function Mixins.scripts.DragStat.OnEnter(self)
end

function Mixins.scripts.DragStat.OnHide(self)
end

function Mixins.scripts.DragStat.OnLeave(self)
end

function Mixins.scripts.DragStat.OnMouseDown(self)
end

function Mixins.scripts.DragStat.OnMouseUp(self)
end

--------------------------------------
--			Display Order			--
--------------------------------------

local CellW, CellH = 135, 18
local CellW_Compact = 68
local CellGapV, CellGapH = 2, 6
local PreviewPad = 6
local PreviewMaxW = 590 -- max visible width before horizontal scroll kicks in

local function UpdateHScrollUI(self)
	local maxH = self.MaxHScroll or 0
	local hOff = self.HScrollOffset or 0

	if self.HScrollLeft then
		if hOff > 0 then self.HScrollLeft:Show() else self.HScrollLeft:Hide() end
	end
	if self.HScrollRight then
		if hOff < maxH then self.HScrollRight:Show() else self.HScrollRight:Hide() end
	end

	if self.HScrollBar then
		if maxH > 0 then
			self.HScrollBar:Show()
			local trackW = self.HScrollBar:GetWidth()
			if trackW > 0 then
				local visW = self.Preview:GetWidth()
				local contentW = visW + maxH
				local thumbW = math.max(20, trackW * (visW / contentW))
				self.HScrollBar.Thumb:SetWidth(thumbW)
				local travel = trackW - thumbW
				local ratio = (maxH > 0) and (hOff / maxH) or 0
				self.HScrollBar.Thumb:SetPoint("LEFT", self.HScrollBar, "LEFT", travel * ratio, 0)
			end
		else
			self.HScrollBar:Hide()
		end
	end
end

local function RefreshPreviewLayout(self)
	if not self.WidgetList or #self.WidgetList == 0 then return end

	local totalStats = #self.StatList
	local hOff = self.HScrollOffset or 0

	if self.RowLayoutRows and self.RowLayoutRows > 1 then
		self.CompactMode = false
		local rows = self.RowLayoutRows
		local cols = math.ceil(totalStats / rows)
		local maxRow = 0
		for k = 1, totalStats do
			local cell = self.WidgetList[k]
			if not cell then break end
			local c = math.floor((k - 1) / rows)
			local r = (k - 1) % rows
			cell.ColIndex = c + 1
			cell.RowIndex = r + 1
			cell:ClearAllPoints()
			cell:SetPoint("TOPLEFT", self.Preview, "TOPLEFT",
				PreviewPad + c * (CellW + CellGapH) - hOff,
				-(PreviewPad + r * (CellH + CellGapV)))
			cell:SetSize(CellW, CellH)
			cell:Show()
			cell.IdText:Show()
			cell.Icon:ClearAllPoints()
			cell.Icon:SetPoint("LEFT", cell.IdText, "RIGHT", 3, 0)
			if cell.Icon:IsShown() then cell.Icon:SetSize(14, 14) end
			cell.Text:ClearAllPoints()
			cell.Text:SetPoint("LEFT", cell.Icon, "RIGHT", 3, 0)
			cell.IdText:SetText(k .. ".")
			if r + 1 > maxRow then maxRow = r + 1 end
		end
		local contentW = cols * CellW + (cols - 1) * CellGapH + PreviewPad * 2
		local ph = maxRow * (CellH + CellGapV) - CellGapV + PreviewPad * 2
		local visW = math.min(math.max(contentW, 130), PreviewMaxW)
		local actualH = math.max(ph, 30)
		self.Preview:SetSize(visW, actualH)
		self.MaxHScroll = math.max(0, contentW - visW)
		if hOff > self.MaxHScroll then
			self.HScrollOffset = self.MaxHScroll
		end
		local hBarExtra = (self.MaxHScroll > 0) and 10 or 0
		local topBarH = self.Save:GetHeight() + 26
		local hintH = self.Hint:GetStringHeight() + 4
		self:SetHeight(topBarH + hintH + actualH + hBarExtra + 10)
		UpdateHScrollUI(self)
		return
	end

	local preComputedCols = 1
	for k = 2, totalStats do
		if self.ColumnBreaks[k] then preComputedCols = preComputedCols + 1 end
	end

	local isCompact = (preComputedCols == totalStats and totalStats > 1)
	local cellW = isCompact and CellW_Compact or CellW
	self.CompactMode = isCompact

	local preContentW = preComputedCols * cellW + (preComputedCols - 1) * CellGapH + PreviewPad * 2
	local preVisW = math.min(math.max(preContentW, 130), PreviewMaxW)
	local preMaxH = math.max(0, preContentW - preVisW)
	if hOff > preMaxH then
		self.HScrollOffset = preMaxH
		hOff = preMaxH
	end

	local col, row = 1, 1
	local colX = 0
	local maxRowPerCol = {}

	for k = 1, totalStats do
		local cell = self.WidgetList[k]
		if not cell then break end

		local isNewCol = (k > 1) and (self.ColumnBreaks[k] == true)
		if isNewCol then
			col = col + 1
			row = 1
			colX = colX + cellW + CellGapH
		end

		cell.ColIndex = col
		cell.RowIndex = row
		cell:ClearAllPoints()
		cell:SetPoint("TOPLEFT", self.Preview, "TOPLEFT",
			PreviewPad + colX - hOff,
			-(PreviewPad + (row - 1) * (CellH + CellGapV)))
		cell:SetSize(cellW, CellH)
		cell:Show()

		if isCompact then
			cell.IdText:Hide()
			cell.Icon:ClearAllPoints()
			cell.Icon:SetPoint("LEFT", 3, 0)
			if cell.Icon:IsShown() then cell.Icon:SetSize(10, 10) end
			cell.Text:ClearAllPoints()
			cell.Text:SetPoint("LEFT", cell.Icon, "RIGHT", 2, 0)
			cell.Text:SetPoint("RIGHT", cell, "RIGHT", -2, 0)
		else
			cell.IdText:Show()
			cell.Icon:ClearAllPoints()
			cell.Icon:SetPoint("LEFT", cell.IdText, "RIGHT", 3, 0)
			if cell.Icon:IsShown() then cell.Icon:SetSize(14, 14) end
			cell.Text:ClearAllPoints()
			cell.Text:SetPoint("LEFT", cell.Icon, "RIGHT", 3, 0)
		end

		maxRowPerCol[col] = row
		row = row + 1
	end

	local totalCols = col
	local maxRow = 0
	for _, r in pairs(maxRowPerCol) do
		if r > maxRow then maxRow = r end
	end
	local contentW = totalCols * cellW + (totalCols - 1) * CellGapH + PreviewPad * 2
	local ph = maxRow * (CellH + CellGapV) - CellGapV + PreviewPad * 2
	local visW = math.min(math.max(contentW, 130), PreviewMaxW)
	local actualH = math.max(ph, 30)
	self.Preview:SetSize(visW, actualH)

	self.MaxHScroll = math.max(0, contentW - visW)
	if hOff > self.MaxHScroll then
		self.HScrollOffset = self.MaxHScroll
	end


	local hBarExtra = (self.MaxHScroll > 0) and 10 or 0
	local topBarH = self.Save:GetHeight() + 26 -- gap between top and hint
	local hintH = self.Hint:GetStringHeight() + 4 -- hint text + gap
	self:SetHeight(topBarH + hintH + actualH + hBarExtra + 10)
	UpdateHScrollUI(self)

	local cellsByRow = {}
	for k = 1, totalStats do
		local cell = self.WidgetList[k]
		if cell then
			local r = cell.RowIndex or 1
			if not cellsByRow[r] then cellsByRow[r] = {} end
			tinsert(cellsByRow[r], cell)
		end
	end
	local visualNum = 1
	for r = 1, maxRow do
		if cellsByRow[r] then
			table.sort(cellsByRow[r], function(a, b) return a.ColIndex < b.ColIndex end)
			for _, cell in ipairs(cellsByRow[r]) do
				cell.IdText:SetText(visualNum .. ".")
				visualNum = visualNum + 1
			end
		end
	end
end

local function GridCell_OnEnter(self)
	local parent = self.ConfigParent
	if parent.IsDragging then
		parent.DropTarget = self
	end
end

local function GridCell_OnLeave(self)
	local parent = self.ConfigParent
	if parent.DropTarget == self then
		parent.DropTarget = nil
	end
end

local function GridCell_OnMouseDown(self, button)
	local parent = self.ConfigParent
	if button == "RightButton" then
		if self.ID > 1 then
			if parent.RowLayoutRows and parent.RowLayoutRows > 1 then
				local clickedStat = parent.StatList[self.ID]
				local total = #parent.StatList
				local rows = parent.RowLayoutRows
				local cols = math.ceil(total / rows)
				local colMajor = {}
				local newBreaks = {}
				for c = 0, cols - 1 do
					for r = 0, rows - 1 do
						local visualIdx = c * rows + r + 1
						if visualIdx <= total then
							tinsert(colMajor, parent.StatList[visualIdx])
							if c > 0 and r == 0 then
								newBreaks[#colMajor] = true
							end
						end
					end
				end

				local newClickID

				for k = 1, total do
					parent.StatList[k] = colMajor[k]
					parent.ColumnBreaks[k] = newBreaks[k] or false
					if colMajor[k] == clickedStat then newClickID = k end
				end

				for k, v in ipairs(parent.StatList) do
					parent.WidgetList[k].ID = k
					parent.WidgetList[k].Text:SetText(L[v.stat])
				end
				parent.RowLayoutRows = nil

				if newClickID and newClickID > 1 then
					parent.ColumnBreaks[newClickID] = not parent.ColumnBreaks[newClickID]
				end
			else
				parent.ColumnBreaks[self.ID] = not parent.ColumnBreaks[self.ID]
			end
			RefreshPreviewLayout(parent)
			parent.Save:SetEnabled(true)
			parent.Cancel:SetEnabled(true)
		end
		return
	end

	parent.IsDragging = true
	parent.DragOrigin = self
	parent.DropTarget = nil
	parent.DropMode = nil   -- "swap" or "insert"
	parent.InsertAt = nil

	parent.Ghost:SetText(self:GetText())
	if self.Icon:IsShown() then
		parent.Ghost.Icon:SetTexture(self.Icon:GetTexture())
		parent.Ghost.Icon:SetSize(14, 14)
		parent.Ghost.Icon:Show()
	else
		parent.Ghost.Icon:SetTexture(nil)
		parent.Ghost.Icon:SetSize(0.1, 0.1)
		parent.Ghost.Icon:Hide()
	end
	local ghostW = parent.CompactMode and CellW_Compact or CellW
	parent.Ghost:SetSize(ghostW, CellH)
	if parent.CompactMode then
		parent.Ghost.Icon:SetSize(10, 10)
	else
		parent.Ghost.Icon:SetSize(14, 14)
	end
	parent.Ghost:Show()

	self:SetAlpha(0.35)
	parent.DragNextCheck = 0
	parent:SetScript("OnUpdate", function(p, elapsed)
		if not IsMouseButtonDown("LeftButton") then
			p.IsDragging = false
			p:SetScript("OnUpdate", nil)
			p.Ghost:Hide()
			p.InsertBar:Hide()
			if p.DragOrigin then p.DragOrigin:SetAlpha(1) end
			if p.DropTarget then
				p.DropTarget:SetBackdropBorderColor(0.25, 0.25, 0.25, 0.6)
				p.DropTarget:SetBackdropColor(0, 0, 0, 0)
			end
			p.DragOrigin = nil
			p.DropTarget = nil
			p.DropMode = nil
			p.InsertAt = nil
			return
		end

		local scale = p:GetEffectiveScale()
		local cx, cy = GetCursorPosition()
		cx, cy = cx / scale, cy / scale
		p.Ghost:ClearAllPoints()
		p.Ghost:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cx, cy)

		p.DragNextCheck = (p.DragNextCheck or 0) - elapsed -- throttling hit-detection a bit
		if p.DragNextCheck > 0 then return end
		p.DragNextCheck = 0.033

		local best, bestMode, bestInsert
		for k = 1, #p.StatList do
			local cell = p.WidgetList[k]
			if cell and cell:IsMouseOver() and cell ~= p.DragOrigin then
				local cellL = cell:GetLeft()
				local cellR = cell:GetRight()
				local cellT = cell:GetTop()
				local cellB = cell:GetBottom()
				if cellL and cellR and cellT and cellB then
					local cellW = cellR - cellL
					local cellH = cellT - cellB
					local edgeH = cellW * 0.37  -- 35% edge zone on left/right
					local edgeV = cellH * 0.42   -- 40% edge zone on top/bottom
					local relX = cx - cellL
					local relY = cellT - cy

					local isRow = p.CompactMode
					if isRow then
						if relX < edgeH then
							bestMode = "insert"
							bestInsert = cell.ID
						elseif relX > cellW - edgeH then
							bestMode = "insert"
							bestInsert = cell.ID + 1
						else
							bestMode = "swap"
						end
					else

						if relY < edgeV then
							bestMode = "insert"
							bestInsert = cell.ID
						elseif relY > cellH - edgeV then
							bestMode = "insert"
							bestInsert = cell.ID + 1
						else
							bestMode = "swap"
						end
					end
				end
				best = cell
				break
			end
		end

		if p.DropTarget and (p.DropTarget ~= best or p.DropMode ~= bestMode) then
			p.DropTarget:SetBackdropBorderColor(0.25, 0.25, 0.25, 0.6)
			p.DropTarget:SetBackdropColor(0, 0, 0, 0)
		end
		p.InsertBar:Hide()

		if best then
			p.DropTarget = best
			p.DropMode = bestMode
			p.InsertAt = bestInsert
				if bestMode == "swap" then
				best:SetBackdropColor(0, 0, 0, 0.6)
				--best:SetBackdropBorderColor(greenColor.r, greenColor.g, greenColor.b, 0.5)
			else
				local isRow = p.CompactMode
				if isRow then
					p.InsertBar:SetSize(2, CellH)
					p.InsertBar:ClearAllPoints()
					if bestInsert <= best.ID then
						p.InsertBar:SetPoint("RIGHT", best, "LEFT", -CellGapH / 2, 0)
					else
						p.InsertBar:SetPoint("LEFT", best, "RIGHT", CellGapH / 2, 0)
					end
				else
					p.InsertBar:SetSize(CellW, 2)
					p.InsertBar:ClearAllPoints()
					if bestInsert <= best.ID then
						p.InsertBar:SetPoint("BOTTOM", best, "TOP", 0, CellGapV / 2)
					else
						p.InsertBar:SetPoint("TOP", best, "BOTTOM", 0, -CellGapV / 2)
					end
				end
				p.InsertBar:Show()
			end
		else
			p.DropTarget = nil
			p.DropMode = nil
			p.InsertAt = nil
		end
	end)
end

local function GridCell_OnMouseUp(self, button)
	if button ~= "LeftButton" then return end
	local parent = self.ConfigParent
	if not parent.IsDragging then return end

	parent.IsDragging = false
	parent:SetScript("OnUpdate", nil)
	parent.Ghost:Hide()
	parent.InsertBar:Hide()

	if parent.DragOrigin then
		parent.DragOrigin:SetAlpha(1)
	end

	if parent.DropTarget then
		parent.DropTarget:SetBackdropBorderColor(0.25, 0.25, 0.25, 0.6)
		parent.DropTarget:SetBackdropColor(0, 0, 0, 0)
	end

	local target = parent.DropTarget
	local mode = parent.DropMode or "swap"
	local insertAt = parent.InsertAt
	if not target and self ~= parent.DragOrigin then
		target = self
		mode = "swap"
	end

	local origin = parent.DragOrigin
	if origin and target and origin ~= target then
		local fromID = origin.ID
		local toID = target.ID
		local changed = false

		if mode == "swap" then
			parent.StatList[fromID], parent.StatList[toID] = parent.StatList[toID], parent.StatList[fromID]
			changed = true
		else
			local insertingAbove = (insertAt == toID) -- true = above target cell
			if insertAt and (insertAt == fromID or insertAt == fromID + 1) then
				if insertAt == fromID and parent.ColumnBreaks[fromID] then
					parent.ColumnBreaks[fromID] = false
					if fromID + 1 <= #parent.ColumnBreaks then
						parent.ColumnBreaks[fromID + 1] = true
					end
					changed = true
				elseif insertAt == fromID + 1 and fromID + 1 <= #parent.ColumnBreaks and parent.ColumnBreaks[fromID + 1] then
					parent.ColumnBreaks[fromID + 1] = false
					if fromID > 1 and not parent.ColumnBreaks[fromID] then
						parent.ColumnBreaks[fromID] = true
					end
					changed = true
				end
				parent.ColumnBreaks[1] = false
			elseif insertAt then
				local targetIsColStart = insertingAbove
					and insertAt <= #parent.ColumnBreaks
					and parent.ColumnBreaks[insertAt]
				local movedStat = tremove(parent.StatList, fromID)
				local hadBreak = parent.ColumnBreaks[fromID]
				tremove(parent.ColumnBreaks, fromID)

				if hadBreak and fromID <= #parent.ColumnBreaks then
					parent.ColumnBreaks[fromID] = true
				end

				if fromID < insertAt then insertAt = insertAt - 1 end
				tinsert(parent.StatList, insertAt, movedStat)
				tinsert(parent.ColumnBreaks, insertAt, false)

				if targetIsColStart and insertAt + 1 <= #parent.ColumnBreaks then
					parent.ColumnBreaks[insertAt] = true
					parent.ColumnBreaks[insertAt + 1] = false
				end
				parent.ColumnBreaks[1] = false
				changed = true
			end
		end

		if changed then
			for k, v in ipairs(parent.StatList) do
				parent.WidgetList[k].ID = k
				parent.WidgetList[k].Text:SetText(L[v.stat])
				local defIdx = Ns.StatToDefaultOrder[v.stat]
				if defIdx then
					local iconTexture = Ns:GetSpellIcon(Ns.DefaultOrder[defIdx], Ns.IgnoreFormat)
					if iconTexture and iconTexture ~= "" then
						parent.WidgetList[k].Icon:SetTexture(iconTexture)
						parent.WidgetList[k].Icon:SetSize(14, 14)
						parent.WidgetList[k].Icon:Show()
					else
						parent.WidgetList[k].Icon:SetTexture(nil)
						parent.WidgetList[k].Icon:SetSize(0.1, 0.1)
						parent.WidgetList[k].Icon:Hide()
					end
				else
					parent.WidgetList[k].Icon:SetTexture(nil)
					parent.WidgetList[k].Icon:SetSize(0.1, 0.1)
					parent.WidgetList[k].Icon:Hide()
				end
			end
			RefreshPreviewLayout(parent)
			parent.Save:SetEnabled(true)
			parent.Cancel:SetEnabled(true)
		end
	end

	parent.DragOrigin = nil
	parent.DropTarget = nil
	parent.DropMode = nil
	parent.InsertAt = nil
end

local CellBG = {
	bgFile = "Interface/BUTTONS/WHITE8X8",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = false,
	edgeSize = 6,
	tileSize = 0,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

---------------------------------------------------------------------------
-- DisplayOrderConfig constructor
---------------------------------------------------------------------------
function W.DisplayOrderConfig(parent)
	local f = CreateFrame("Frame", "$parentOrder", parent)
	f.SpecialType = "DisplayOrderConfig"
	f:SetSize(600, 400)
	f.WidgetList = {}
	f.ColumnBreaks = {} -- [index] = true/false
	Mixin(f, Mixins.functions.DisplayOrderConfig)

	-- Action buttons at top
	f.Save = CreateProfileButton(f, L["Selected"])
	f.Save:SetSize(65, 20)
	f.Save:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	ApplyIconTextButtonStyle(f.Save, {
		normalTex = K.LAYOUT_APPLY_BTN_TEX,
		pressedTex = K.LAYOUT_APPLY_BTN_PRESSED_TEX,
		highlightTex = K.LAYOUT_APPLY_BTN_HIGHLIGHT_TEX,
		highlightW = K.LAYOUT_APPLY_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.LAYOUT_APPLY_BTN_W,
		h = K.LAYOUT_APPLY_BTN_H,
		x = K.LAYOUT_APPLY_BTN_X,
		y = K.LAYOUT_APPLY_BTN_Y,
	})
	f.Save:SetEnabled(false)
	f.Save.Action = "Save"

	f.Cancel = CreateProfileButton(f, L["Cancel"])
	f.Cancel:SetPoint("LEFT", f.Save, "RIGHT", 10, 0)
	f.Cancel:SetSize(65, 20)
	ApplyIconTextButtonStyle(f.Cancel, {
		normalTex = K.LAYOUT_RESET_BTN_TEX,
		pressedTex = K.LAYOUT_RESET_BTN_PRESSED_TEX,
		highlightTex = K.LAYOUT_RESET_BTN_HIGHLIGHT_TEX,
		highlightW = K.LAYOUT_RESET_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.LAYOUT_RESET_BTN_W,
		h = K.LAYOUT_RESET_BTN_H,
		x = K.LAYOUT_RESET_BTN_X,
		y = K.LAYOUT_RESET_BTN_Y,
	})
	f.Cancel:SetEnabled(false)
	f.Cancel.Action = "Cancel"

	f.ClearAllColumns = CreateProfileButton(f, L["ClearAllColumns"])
	f.ClearAllColumns:SetPoint("LEFT", f.Cancel, "RIGHT", 10, 0)
	f.ClearAllColumns:SetSize(65, 20)
	ApplyIconTextButtonStyle(f.ClearAllColumns, {
		normalTex = K.LAYOUT_RESET_BTN_TEX,
		pressedTex = K.LAYOUT_RESET_BTN_PRESSED_TEX,
		highlightTex = K.LAYOUT_RESET_BTN_HIGHLIGHT_TEX,
		highlightW = K.LAYOUT_RESET_BTN_HIGHLIGHT_W,
		pressedTextYOffset = -1,
		w = K.LAYOUT_RESET_BTN_W,
		h = K.LAYOUT_RESET_BTN_H,
		x = K.LAYOUT_RESET_BTN_X,
		y = K.LAYOUT_RESET_BTN_Y,
	})
	f.ClearAllColumns.Action = "ClearAllColumns"

	-- Row / Column preset buttons (below action buttons)
	local function PresetBtn(label, prev, gap, action)
		local btn = CreateProfileButton(f, label)
		btn:SetSize(30, 30)
		btn:SetPoint("LEFT", prev, "RIGHT", gap, 0)
		btn.Action = action
		if K.LAYOUT_PRESET_HIGHLIGHT_TEX ~= "" then
			btn:SetHighlightTexture(K.LAYOUT_PRESET_HIGHLIGHT_TEX)
			local ht = btn:GetHighlightTexture()
			ht:SetDesaturated(K.LAYOUT_PRESET_HIGHLIGHT_DESATURATED)
			ht:SetVertexColor(K.LAYOUT_PRESET_HIGHLIGHT_R, K.LAYOUT_PRESET_HIGHLIGHT_G, K.LAYOUT_PRESET_HIGHLIGHT_B, K.LAYOUT_PRESET_HIGHLIGHT_A)
		end
		return btn
	end

	local function CreatePresetGroup(label, anchorTo, anchorGap, actionStart)
		local header = f:CreateFontString()
		header:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4)
		header:SetText(label)
		header:SetPoint("LEFT", anchorTo, "RIGHT", anchorGap, 0)
		local b1 = PresetBtn(L["OneRow"],    header, 3, actionStart)
		local b2 = PresetBtn(L["TwoRows"],   b1,     2, actionStart + 1)
		local b3 = PresetBtn(L["ThreeRows"], b2,     2, actionStart + 2)
		local b4 = PresetBtn(L["FourRows"],  b3,     2, actionStart + 3)
		return header, b1, b2, b3, b4
	end

	f.Rows, f.OneRow, f.TwoRows, f.ThreeRows, f.FourRows = CreatePresetGroup(L["Rows"], f, 20, 1)
	f.Rows:ClearAllPoints()
	f.Rows:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -36)

	f.Columns, f.OneCol, f.TwoCol, f.ThreeCol, f.FourCol = CreatePresetGroup(L["Columns"], f.FourRows, 20, 6)

	-- hint label (below presets)
	f.Hint = f:CreateFontString()
	f.Hint:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 5)
	f.Hint:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b)
	f.Hint:SetPoint("TOPLEFT", f.Save, "BOTTOMLEFT", 0, -52)
	f.Hint:SetText(L["LayoutHint"])

	f.Preview = CreateFrame("Frame", nil, f, "BackdropTemplate")
	f.Preview:SetPoint("TOPLEFT", f.Hint, "BOTTOMLEFT", 0, -4)
	f.Preview:SetBackdrop({
		bgFile = "Interface/BUTTONS/WHITE8X8",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false,
		edgeSize = 8,
		tileSize = 0,
		insets = { left = 1, right = 1, top = 1, bottom = 1 },
	})
	f.Preview:SetBackdropColor(0.08, 0.08, 0.08, 0.85)
	f.Preview:SetBackdropBorderColor(0.2, 0.2, 0.2, 0.5)
	f.Preview:SetClipsChildren(true)
	f.Preview:EnableMouse(true) -- absorb clicks so the config frame doesn't drag
	f.Preview:SetSize(PreviewMaxW, 80) -- width capped; height sized dynamically
	f.HScrollOffset = 0
	f.MaxHScroll = 0

	local hArrowSize = 14
	local hScrollStep = 60

	local leftArrow = CreateFrame("Button", nil, f)
	leftArrow:SetSize(hArrowSize, hArrowSize)
	leftArrow:SetPoint("RIGHT", f.Preview, "LEFT", -2, 0)
	leftArrow.Icon = leftArrow:CreateTexture(nil, "ARTWORK")
	leftArrow.Icon:SetAllPoints()
	leftArrow.Icon:SetTexture(Ns.TexturePath .. "ArrowUp")
	leftArrow.Icon:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1) -- rotate 90° CCW → points left
	leftArrow.Icon:SetDesaturated(true)
	leftArrow.Icon:SetVertexColor(orangeColor.r, orangeColor.g, orangeColor.b, 1)
	leftArrow:SetScript("OnEnter", function(self) self.Icon:SetVertexColor(orangeColor.r, orangeColor.g, orangeColor.b, 1) end)
	leftArrow:SetScript("OnLeave", function(self) self.Icon:SetVertexColor(orangeColor.r, orangeColor.g, orangeColor.b, 0.7) end)
	leftArrow:SetScript("OnClick", function()
		f.HScrollOffset = math.max(0, (f.HScrollOffset or 0) - hScrollStep)
		RefreshPreviewLayout(f)
	end)
	leftArrow:Hide()
	f.HScrollLeft = leftArrow

	local rightArrow = CreateFrame("Button", nil, f)
	rightArrow:SetSize(hArrowSize, hArrowSize)
	rightArrow:SetPoint("LEFT", f.Preview, "RIGHT", 2, 0)
	rightArrow.Icon = rightArrow:CreateTexture(nil, "ARTWORK")
	rightArrow.Icon:SetAllPoints()
	rightArrow.Icon:SetTexture(Ns.TexturePath .. "ArrowUp")
	rightArrow.Icon:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0) -- rotate 90° CW → points right
	rightArrow.Icon:SetDesaturated(true)
	rightArrow.Icon:SetVertexColor(orangeColor.r, orangeColor.g, orangeColor.b, 1)
	rightArrow:SetScript("OnEnter", function(self) self.Icon:SetVertexColor(orangeColor.r, orangeColor.g, orangeColor.b, 1) end)
	rightArrow:SetScript("OnLeave", function(self) self.Icon:SetVertexColor(orangeColor.r, orangeColor.g, orangeColor.b, 0.7) end)
	rightArrow:SetScript("OnClick", function()
		f.HScrollOffset = math.min(f.MaxHScroll or 0, (f.HScrollOffset or 0) + hScrollStep)
		RefreshPreviewLayout(f)
	end)
	rightArrow:Hide()
	f.HScrollRight = rightArrow

	local hbar = CreateFrame("Frame", nil, f, BackdropTemplateMixin and "BackdropTemplate")
	hbar:SetHeight(6)
	hbar:SetPoint("TOPLEFT", f.Preview, "BOTTOMLEFT", 0, -2)
	hbar:SetPoint("TOPRIGHT", f.Preview, "BOTTOMRIGHT", 0, -2)
	hbar:SetBackdrop({bgFile = "Interface/BUTTONS/WHITE8X8"})
	hbar:SetBackdropColor(0.1, 0.1, 0.1, 0.4)
	hbar:EnableMouse(true)
	hbar:Hide()
	f.HScrollBar = hbar

	local hthumb = CreateFrame("Frame", nil, hbar, BackdropTemplateMixin and "BackdropTemplate")
	hthumb:SetHeight(6)
	hthumb:SetBackdrop({bgFile = "Interface/BUTTONS/WHITE8X8"})
	hthumb:SetBackdropColor(1, 1, 1, 0.5)
	hthumb:SetPoint("LEFT", 0, 0)
	hthumb:SetWidth(40)
	hthumb:EnableMouse(true)
	hbar.Thumb = hthumb

	local function HThumbOnUpdate(self)
		local cx = GetCursorPosition()
		local scale = self:GetEffectiveScale()
		cx = cx / scale
		local deltaX = cx - f.HDragStartX
		local trackW = hbar:GetWidth()
		local thumbW = self:GetWidth()
		local travel = trackW - thumbW
		local maxH = f.MaxHScroll or 0
		if travel <= 0 or maxH <= 0 then return end
		local scrollDelta = deltaX * (maxH / travel)
		f.HScrollOffset = math.max(0, math.min(maxH, (f.HDragStartOffset or 0) + scrollDelta))
		RefreshPreviewLayout(f)
	end
	hthumb:SetScript("OnMouseDown", function(self, button)
		if button ~= "LeftButton" then return end
		local cx = GetCursorPosition()
		local scale = self:GetEffectiveScale()
		f.HDragStartX = cx / scale
		f.HDragStartOffset = f.HScrollOffset or 0
		self:SetScript("OnUpdate", HThumbOnUpdate)
	end)
	hthumb:SetScript("OnMouseUp", function(self, button)
		if button ~= "LeftButton" then return end
		self:SetScript("OnUpdate", nil)
	end)

	hbar:SetScript("OnMouseDown", function(self, button)
		if button ~= "LeftButton" then return end
		local maxH = f.MaxHScroll or 0
		if maxH <= 0 then return end
		local cx = GetCursorPosition()
		local scale = self:GetEffectiveScale()
		cx = cx / scale
		local thumbCenterX = select(1, hthumb:GetCenter())
		if cx > thumbCenterX then
			f.HScrollOffset = math.min(maxH, (f.HScrollOffset or 0) + hScrollStep * 2)
		else
			f.HScrollOffset = math.max(0, (f.HScrollOffset or 0) - hScrollStep * 2)
		end
		RefreshPreviewLayout(f)
	end)

	f.Ghost = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	f.Ghost:SetBackdrop(CellBG)
	f.Ghost:SetBackdropColor(0, 0, 0, 0)
	f.Ghost:SetBackdropBorderColor(0, 0, 0, 0)
	f.Ghost:SetFrameStrata("TOOLTIP")
	f.Ghost:SetAlpha(0.65)
	f.Ghost.BgAtlas = f.Ghost:CreateTexture(nil, "BACKGROUND", nil, 0)
	f.Ghost.BgAtlas:SetAllPoints()
	if K.LAYOUT_STAT_BAR_TEX ~= "" then f.Ghost.BgAtlas:SetTexture(K.LAYOUT_STAT_BAR_TEX) end
	f.Ghost.Icon = f.Ghost:CreateTexture(nil, "ARTWORK")
	f.Ghost.Icon:SetSize(14, 14)
	f.Ghost.Icon:SetPoint("LEFT", 5, 0)
	f.Ghost.Text = f.Ghost:CreateFontString()
	f.Ghost.Text:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4)
	f.Ghost.Text:SetJustifyH("LEFT")
	f.Ghost.Text:SetPoint("LEFT", f.Ghost.Icon, "RIGHT", 3, 0)
	f.Ghost.Text:SetTextColor(1, 1, 1)
	f.Ghost:Hide()
	function f.Ghost:SetText(text) self.Text:SetText(text) end
	function f.Ghost:GetText() return self.Text:GetText() end

	f.InsertBar = f.Preview:CreateTexture(nil, "OVERLAY")
	f.InsertBar:SetColorTexture(orangeColor.r, orangeColor.g, orangeColor.b, 1)
	f.InsertBar:SetSize(2, CellH)
	f.InsertBar:Hide()

	return f
end

-------------------------------
-- DisplayOrderConfig mixins --
-------------------------------
Mixins.functions.DisplayOrderConfig = {}

function Mixins.functions.DisplayOrderConfig.Init(self, anchorframe, parent)
	self.Anchoreframe = anchorframe
	self.ParentRef = parent
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.DisplayOrder = parent.DisplayOrder
	self.SvTable = Ns.Profile

	if not self.StatList then
		self.StatList = {}
	end
	wipe(self.StatList)
	wipe(self.ColumnBreaks)
	self.HScrollOffset = 0

	local added, removed = Ns:FillDisplayOrder(self.StatList, self.SvTable, true)
	if added or removed then
		self.Save:SetEnabled(true)
		self.Cancel:SetEnabled(true)
	end

	for k, v in ipairs(self.StatList) do
		self.ColumnBreaks[k] = (k > 1) and (Ns.Profile.NewColumns and Ns.Profile.NewColumns[v.stat] == true) or false
	end

	if added and not Ns.Profile.RowLayoutRows then
		local savedCount = Ns.Profile.CustomOrderList and #Ns.Profile.CustomOrderList or 0
		if savedCount > 1 then
			local allBreaks = true
			for k = 2, savedCount do
				if not self.ColumnBreaks[k] then allBreaks = false; break end
			end
			if allBreaks then
				for k = savedCount + 1, #self.StatList do
					self.ColumnBreaks[k] = true
				end
			end
		end
	end

	local savedRows = Ns.Profile.RowLayoutRows
	if not savedRows and Ns.Profile.LayoutType == "rows" then
		local firstColLen = 0
		for k = 1, #self.StatList do
			if k > 1 and self.ColumnBreaks[k] then break end
			firstColLen = firstColLen + 1
		end
		if firstColLen > 1 then
			savedRows = firstColLen
		end
	end
	self.RowLayoutRows = savedRows
	if self.RowLayoutRows and self.RowLayoutRows > 1 then
		local total = #self.StatList
		local rows = self.RowLayoutRows
		local cols = math.ceil(total / rows)
		local columns = {{}}
		for k = 1, total do
			if k > 1 and self.ColumnBreaks[k] then tinsert(columns, {}) end
			tinsert(columns[#columns], self.StatList[k])
		end

		local visual = {}
		for _, col in ipairs(columns) do
			for _, stat in ipairs(col) do
				tinsert(visual, stat)
			end
		end
		for k = 1, total do
			self.StatList[k] = visual[k]
			self.ColumnBreaks[k] = false
		end
	else
		self.RowLayoutRows = nil
	end

	for k, v in ipairs(self.StatList) do
		local cell = Ns:GetWidget("DragStat", self.Preview, k)
		cell:SetParent(self.Preview)
		cell.ID = k
		cell.NewColumn:Hide()
		cell:SetBackdrop(CellBG)
		cell:SetBackdropColor(0, 0, 0, 0)
		cell:SetBackdropBorderColor(0.25, 0.25, 0.25, 0.6)
		cell:EnableMouse(true)
		cell.IdText:SetText(k .. ".")
		local defIdx = Ns.StatToDefaultOrder[v.stat]
		if defIdx then
			local iconTexture = Ns:GetSpellIcon(Ns.DefaultOrder[defIdx], Ns.IgnoreFormat)
			if iconTexture and iconTexture ~= "" then
				cell.Icon:SetTexture(iconTexture)
				cell.Icon:SetSize(14, 14)
				cell.Icon:Show()
			else
				cell.Icon:SetTexture(nil)
				cell.Icon:SetSize(0.1, 0.1)
				cell.Icon:Hide()
			end
		else
			cell.Icon:SetTexture(nil)
			cell.Icon:SetSize(0.1, 0.1)
			cell.Icon:Hide()
		end
		cell.Text:SetText(L[v.stat])
		cell.ConfigParent = self
		cell:SetScript("OnEnter", GridCell_OnEnter)
		cell:SetScript("OnLeave", GridCell_OnLeave)
		cell:SetScript("OnMouseDown", GridCell_OnMouseDown)
		cell:SetScript("OnMouseUp", GridCell_OnMouseUp)
		cell:EnableMouseWheel(true)
		cell:SetScript("OnMouseWheel", function(c, delta)
			local p = c.ConfigParent
			if (p.MaxHScroll or 0) <= 0 then return end
			p.HScrollOffset = math.max(0, math.min(p.MaxHScroll, (p.HScrollOffset or 0) - delta * 60))
			RefreshPreviewLayout(p)
		end)
		tinsert(self.WidgetList, cell)
	end

	RefreshPreviewLayout(self)
end

function Mixins.functions.DisplayOrderConfig.Reset(self)
	for k, widget in ipairs(self.WidgetList) do
		Ns:KillWidget(widget)
	end
	wipe(self.WidgetList)
	self.IsDragging = false
	self.HScrollOffset = 0
	self:SetScript("OnUpdate", nil)
	if self.Ghost then self.Ghost:Hide() end
end

function Mixins.functions.DisplayOrderConfig.RunAction(self, action)
	if action == "Save" then
		if not Ns.Profile.CustomOrderList then
			Ns.Profile.CustomOrderList = {}
		end
		if not Ns.Profile.NewColumns then
			Ns.Profile.NewColumns = {}
		end
		wipe(Ns.Profile.CustomOrderList)
		wipe(Ns.Profile.NewColumns)
		if self.RowLayoutRows and self.RowLayoutRows > 1 then
			local total = #self.StatList
			local rows = self.RowLayoutRows
			local cols = math.ceil(total / rows)
			local idx = 0
			for c = 0, cols - 1 do
				for r = 0, rows - 1 do
					local src = c * rows + r + 1
					if src <= total then
						idx = idx + 1
						Ns.Profile.CustomOrderList[idx] = self.StatList[src].stat
						if c > 0 and r == 0 then
							Ns.Profile.NewColumns[self.StatList[src].stat] = true
						end
					end
				end
			end
			Ns.Profile.RowLayoutRows = self.RowLayoutRows
		else
			for k, v in ipairs(self.StatList) do
				Ns.Profile.CustomOrderList[k] = v.stat
				if self.ColumnBreaks[k] then
					Ns.Profile.NewColumns[v.stat] = true
				end
			end
			Ns.Profile.RowLayoutRows = nil
		end
		Ns.Profile.LayoutType = nil
		Ns.Profile.CanonicalOrder = nil
		self.Save:SetEnabled(false)
		self.Cancel:SetEnabled(false)
		Ns:QueueProfileRefresh()

	elseif action == "Cancel" then
		self:Reset()
		self:Init(self.Anchoreframe, self.ParentRef)

	elseif action == "ClearAllColumns" then
		self.RowLayoutRows = nil
		for k = 2, #self.StatList do
			self.ColumnBreaks[k] = false
		end
		for k, v in ipairs(self.StatList) do
			self.WidgetList[k].ID = k
			self.WidgetList[k].Text:SetText(L[v.stat])
		end
		RefreshPreviewLayout(self)
		self.Save:SetEnabled(true)
		self.Cancel:SetEnabled(true)

	elseif type(action) == "number" then
		local total = #self.StatList
		if total == 0 then return end

		if action >= 1 and action <= 4 then
			local rows = action
			if rows == 1 then
				self.RowLayoutRows = nil
				for k = 1, total do
					self.ColumnBreaks[k] = (k > 1)
				end
			else
				self.RowLayoutRows = rows
				for k = 1, total do
					self.ColumnBreaks[k] = false
				end
			end
			for k, v in ipairs(self.StatList) do
				self.WidgetList[k].ID = k
				self.WidgetList[k].Text:SetText(L[v.stat])
			end
		elseif action >= 6 and action <= 9 then
			self.RowLayoutRows = nil
			local cols = action - 5
			if cols == 1 then
				for k = 1, total do
					self.ColumnBreaks[k] = false
				end
			else
				local perCol = math.floor(total / cols)
				local extras = total % cols
				local ki = 1
				for c = 1, cols do
					local colLen = perCol + (c <= extras and 1 or 0)
					for r = 1, colLen do
						self.ColumnBreaks[ki] = (c > 1 and r == 1)
						ki = ki + 1
					end
				end
			end
			for k, v in ipairs(self.StatList) do
				self.WidgetList[k].ID = k
				self.WidgetList[k].Text:SetText(L[v.stat])
			end
		end

		RefreshPreviewLayout(self)
		self.Save:SetEnabled(true)
		self.Cancel:SetEnabled(true)
	end
end

-----------------------------
--		Search Config	   --
-----------------------------
function W.SearchConfig(parent)
	local f = CreateFrame("Frame", "$parentSearch", parent)
	f.SpecialType = "SearchConfig"
	f:SetSize(600, 400)
	Mixin(f, Mixins.functions.SearchConfig)

	-- Search EditBox
	f.SearchBox = W.BaseEditBox(f, 250, 27)
	f.SearchBox:SetPoint("TOPLEFT", 0, 0)
	f.SearchBox:SetMaxLetters(40)
	f.SearchBox:SetAutoFocus(false)
	f.SearchBox:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 2, "")
	f.SearchBox.Instructions = f.SearchBox:CreateFontString(nil, "ARTWORK")
	f.SearchBox.Instructions:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 3, "")
	f.SearchBox.Instructions:SetPoint("LEFT", 5, 0)
	f.SearchBox.Instructions:SetTextColor(0.5, 0.5, 0.5)
	f.SearchBox.Instructions:SetText(Ns.L["Search"] .. "...")

	f.SearchBox:SetScript("OnEditFocusGained", function(self) self.Instructions:Hide() end)
	f.SearchBox:SetScript("OnEditFocusLost", function(self)
		if self:GetText() == "" then self.Instructions:Show() end
	end)
	f.SearchBox:SetScript("OnEscapePressed", function(self)
		self:SetText("")
		self:ClearFocus()
		self.Instructions:Show()
		f:UpdateResults("")
	end)
	f.SearchBox:SetScript("OnTextChanged", function(self)
		local text = self:GetText()
		if text == "" then
			self.Instructions:Show()
		else
			self.Instructions:Hide()
		end
		f:UpdateResults(text)
	end)

	f.Results = {}

	f.RecentTitle = f:CreateFontString(nil, "OVERLAY")
	f.RecentTitle:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4, "")
	f.RecentTitle:SetPoint("TOPLEFT", f.SearchBox, "TOPRIGHT", 100, 0)
	f.RecentTitle:SetTextColor(1, 1, 1, 1)
	f.RecentTitle:SetText(Ns.L["RecentSearches"] or "Recent Search")
	f.RecentItems = {}

	return f
end

Mixins.functions.SearchConfig = {}

function Mixins.functions.SearchConfig.Init(self, anchorframe, parent)
	self.Anchoreframe = anchorframe
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.DisplayOrder = parent.DisplayOrder
	self:UpdateRecentSearches()
end

function Mixins.functions.SearchConfig.AddRecentSearch(self, stat, spellclass)
	if not SinStatsDB then return end
	if not SinStatsDB.recentSearches then
		SinStatsDB.recentSearches = {}
	end
	-- remove duplicate if exists
	for i = #SinStatsDB.recentSearches, 1, -1 do
		if SinStatsDB.recentSearches[i].stat == stat then
			table.remove(SinStatsDB.recentSearches, i)
		end
	end
	-- insert at front
	table.insert(SinStatsDB.recentSearches, 1, { stat = stat, spellclass = spellclass })
	-- cap at 10
	while #SinStatsDB.recentSearches > 10 do
		table.remove(SinStatsDB.recentSearches)
	end
	self:UpdateRecentSearches()
end

function Mixins.functions.SearchConfig.RemoveRecentSearch(self, index)
	if not SinStatsDB or not SinStatsDB.recentSearches then return end
	table.remove(SinStatsDB.recentSearches, index)
	self:UpdateRecentSearches()
end

function Mixins.functions.SearchConfig.UpdateRecentSearches(self)

	for _, item in ipairs(self.RecentItems) do
		item:Hide()
	end
	if not SinStatsDB or not SinStatsDB.recentSearches or #SinStatsDB.recentSearches == 0 then
		self.RecentTitle:Hide()
		return
	end
	self.RecentTitle:Show()


	local btnHeight = 22
	local btnSpacing = 3
	local panelWidth = 250

	for i, entry in ipairs(SinStatsDB.recentSearches) do
		local btn = self.RecentItems[i]
		if not btn then
			btn = CreateFrame("Button", nil, self, "BackdropTemplate")
			btn:SetSize(panelWidth, btnHeight)
			btn:SetBackdrop(EditBoxBG)
			btn:SetBackdropColor(0, 0, 0, 0)
			btn:SetBackdropBorderColor(0, 0, 0, 0)
			-- Optional atlas overlay (RecentSearchBar). Empty atlas = unchanged.
			btn.BgAtlas = btn:CreateTexture(nil, "BACKGROUND", nil, 0)
			btn.BgAtlas:SetAllPoints()
			btn.BgAtlas:SetTexture(K.RECENT_SEARCH_BAR_TEX)
			if K.BAR_BTN_HIGHLIGHT_TEX ~= "" then
				btn:SetHighlightTexture(K.BAR_BTN_HIGHLIGHT_TEX)
				Ns:ApplyAtlasOrFallback(btn:GetHighlightTexture(), "ButtonHighlight", function(t) t:SetTexture(K.BAR_BTN_HIGHLIGHT_TEX) end)
				btn:GetHighlightTexture():SetVertexColor(K.BAR_BTN_HIGHLIGHT_R, K.BAR_BTN_HIGHLIGHT_G, K.BAR_BTN_HIGHLIGHT_B, K.BAR_BTN_HIGHLIGHT_A)
			end
			btn.Icon = btn:CreateTexture(nil, "ARTWORK")
			btn.Icon:SetSize(16, 16)
			btn.Icon:SetPoint("LEFT", 4, 0)
			btn.Text = btn:CreateFontString(nil, "OVERLAY")
			btn.Text:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4, "")
			btn.Text:SetPoint("LEFT", btn.Icon, "RIGHT", 4, 0)
			btn.Text:SetPoint("RIGHT", btn, "RIGHT", -22, 0)
			btn.Text:SetJustifyH("LEFT")
			btn.Category = btn:CreateFontString(nil, "OVERLAY")
			btn.Category:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5, "")
			btn.Category:SetPoint("RIGHT", -24, 0)
			btn.Category:SetJustifyH("RIGHT")
			btn.Category:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b, 0.7)

			btn.Remove = CreateFrame("Button", nil, btn)
			btn.Remove:SetSize(14, 14)
			btn.Remove:SetPoint("RIGHT", -4, 0)
			local _rsTex = K.RECENT_SEARCH_CLOSE ~= "" and K.RECENT_SEARCH_CLOSE or (Ns.TexturePath .. "Close")
			btn.Remove:SetNormalTexture(_rsTex)
			btn.Remove:GetNormalTexture():SetVertexColor(K.RECENT_SEARCH_CLOSE_NORMAL_R, K.RECENT_SEARCH_CLOSE_NORMAL_G, K.RECENT_SEARCH_CLOSE_NORMAL_B, K.RECENT_SEARCH_CLOSE_NORMAL_A)
			btn.Remove:SetHighlightTexture(_rsTex)
			btn.Remove:GetHighlightTexture():SetVertexColor(1, 0.3, 0.3, 1)
			self.RecentItems[i] = btn
		end

		local statName = L[entry.stat.."Menu"] or L[entry.stat] or entry.stat
		btn.Text:SetText(statName)
		btn.Category:SetText(entry.spellclass or "")

		local iconTexture
		for _, defEntry in ipairs(Ns.DefaultOrder) do
			if defEntry.stat == entry.stat then
				iconTexture = Ns:GetSpellIcon(defEntry, Ns.IgnoreFormat)
				break
			end
		end
		if iconTexture and iconTexture ~= "" then
			btn.Icon:SetTexture(iconTexture)
			btn.Icon:SetSize(16, 16)
		else
			btn.Icon:SetSize(0.1, 0.1)
		end

		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT", self.RecentTitle, "BOTTOMLEFT", 0, -(5 + (i - 1) * (btnHeight + btnSpacing)))

		local spellclass = entry.spellclass
		local targetStat = entry.stat
		btn:SetScript("OnClick", function()
			if not Ns.ConfigFrame or not Ns.ConfigFrame.MainMenuItems then return end
			for mi = 0, #Ns.ConfigFrame.MainMenuItems do
				local menuItem = Ns.ConfigFrame.MainMenuItems[mi]
				if menuItem and menuItem.SpellClass == spellclass and menuItem:IsEnabled() then
					menuItem:Click()
					if Ns.ConfigFrame.MainAnchor and Ns.ConfigFrame.MainAnchor.CurrentWidgets then
						for _, widget in ipairs(Ns.ConfigFrame.MainAnchor.CurrentWidgets) do
							if widget.MyInformation and widget.MyInformation.stat == targetStat then
								widget:Click()
								break
							end
						end
					end
					break
				end
			end
		end)

		-- my x button!
		local removeIndex = i
		btn.Remove:SetScript("OnClick", function()
			self:RemoveRecentSearch(removeIndex)
		end)

		btn:Show()
	end
end

function Mixins.functions.SearchConfig.UpdateResults(self, query)

	for _, btn in ipairs(self.Results) do
		btn:Hide()
	end

	if not query or strtrim(query) == "" then return end

	local L = Ns.L
	local lowerQuery = strlower(query)
	local resultIndex = 0
	local maxResults = 30
	local btnHeight = 22
	local btnSpacing = 3
	local colWidth = 270
	local maxPerCol = 14
	local maxCols = 2
	local maxVisible = maxPerCol * maxCols

	for _, entry in ipairs(Ns.DefaultOrder) do
		local statName = L[entry.stat.."Menu"] or L[entry.stat] or entry.stat
		local shortName = L[entry.stat] or entry.stat
		if strlower(statName):find(lowerQuery, 1, true) or strlower(shortName):find(lowerQuery, 1, true) or strlower(entry.stat):find(lowerQuery, 1, true) then
			resultIndex = resultIndex + 1
			if resultIndex > maxVisible then break end

			local btn = self.Results[resultIndex]
			if not btn then
				btn = CreateFrame("Button", nil, self, "BackdropTemplate")
				btn:SetFrameLevel(self:GetFrameLevel() + 10)
				btn:SetSize(colWidth - 5, btnHeight)
				btn:SetBackdrop(EditBoxBG)
				btn:SetBackdropColor(0.06020, 0.06020, 0.06020, 1)
				btn:SetBackdropBorderColor(0, 0, 0, 0.5)
				btn.Icon = btn:CreateTexture(nil, "ARTWORK")
				btn.Icon:SetSize(16, 16)
				btn.Icon:SetPoint("LEFT", 4, 0)
				btn.Text = btn:CreateFontString(nil, "OVERLAY")
				btn.Text:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 4, "")
				btn.Text:SetPoint("LEFT", btn.Icon, "RIGHT", 4, 0)
				btn.Text:SetJustifyH("LEFT")
				btn.Category = btn:CreateFontString(nil, "OVERLAY")
				btn.Category:SetFont(Ns.ConfigDefaultFont2, Ns.ConfigDefaultFontSize - 5, "")
				btn.Category:SetPoint("RIGHT", -6, 0)
				btn.Category:SetJustifyH("RIGHT")
				btn.Category:SetTextColor(orangeColor.r, orangeColor.g, orangeColor.b, 0.8)
				btn:SetScript("OnEnter", function(b) b:SetBackdropColor(orangeColor.r, orangeColor.g, orangeColor.b, 0.3) end)
				btn:SetScript("OnLeave", function(b) b:SetBackdropColor(0.06020, 0.06020, 0.06020, 1) end)
				self.Results[resultIndex] = btn
			end

			btn:SetParent(self)
			btn.Text:SetText(statName)
			btn.Category:SetText(entry.spellclass or "")
			local iconTexture = Ns:GetSpellIcon(entry, Ns.IgnoreFormat)
			if iconTexture and iconTexture ~= "" then
				btn.Icon:SetTexture(iconTexture)
				btn.Icon:SetSize(16, 16)
			else
				btn.Icon:SetSize(0.1, 0.1)
			end

			local col = math.floor((resultIndex - 1) / maxPerCol)
			local row = (resultIndex - 1) % maxPerCol
			btn:ClearAllPoints()
			btn:SetPoint("TOPLEFT", self.SearchBox, "BOTTOMLEFT", col * colWidth, -(10 + row * (btnHeight + btnSpacing)))

			local spellclass = entry.spellclass
			local targetStat = entry.stat
			btn:SetScript("OnClick", function()
				self:AddRecentSearch(targetStat, spellclass)
				if not Ns.ConfigFrame or not Ns.ConfigFrame.MainMenuItems then return end
				for i = 0, #Ns.ConfigFrame.MainMenuItems do
					local menuItem = Ns.ConfigFrame.MainMenuItems[i]
					if menuItem and menuItem.SpellClass == spellclass and menuItem:IsEnabled() then
						menuItem:Click()
						if Ns.ConfigFrame.MainAnchor and Ns.ConfigFrame.MainAnchor.CurrentWidgets then
							for _, widget in ipairs(Ns.ConfigFrame.MainAnchor.CurrentWidgets) do
								if widget.MyInformation and widget.MyInformation.stat == targetStat then
									widget:Click()
									break
								end
							end
						end
						break
					end
				end
			end)

			btn:Show()
		end
	end
end

--------------------------
--			FAQ			--
--------------------------
local FAQEntries = { "First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth" }

local function CreateFAQFontString(parent, key, anchor)
	local fs = parent:CreateFontString()
	fs:SetFont(Ns.ConfigDefaultFont, Ns.ConfigDefaultFontSize - 4)
	fs:SetJustifyH("LEFT")
	if anchor then
		fs:SetPoint("TOPLEFT", anchor, 0, -70)
	else
		fs:SetPoint("TOPLEFT", 0, 0)
	end
	fs:SetText(L["FAQ" .. key])

	if K.FAQ_ROW_BG_ENABLED and (K.FAQ_ROW_BG_TEX ~= "" or K.FAQ_ROW_BG_COLOR ~= "" or (Ns.ConfigAtlas and Ns.ConfigAtlas.WidgetRowBg ~= "")) then
		local bg = parent:CreateTexture(nil, "BACKGROUND", nil, -1)
		Ns:ApplyAtlasOrFallback(bg, "WidgetRowBg", function(t)
			if K.FAQ_ROW_BG_TEX ~= "" then t:SetTexture(K.FAQ_ROW_BG_TEX)
			elseif K.FAQ_ROW_BG_COLOR ~= "" then t:SetTexture(K.FAQ_ROW_BG_COLOR) end
		end)
		bg:SetVertexColor(K.FAQ_ROW_BG_R, K.FAQ_ROW_BG_G, K.FAQ_ROW_BG_B, K.FAQ_ROW_BG_A)
		local bgH = max(fs:GetStringHeight() or 0, fs:GetHeight() or 0, 15)
		local padL, padR = K.FAQ_ROW_BG_PAD_L, K.FAQ_ROW_BG_PAD_R
		local padT, padB = K.FAQ_ROW_BG_PAD_T, K.FAQ_ROW_BG_PAD_B
		bg:SetPoint("TOPLEFT",  fs, "TOPLEFT",  -padL, -padT)
		bg:SetPoint("TOPRIGHT", fs, "TOPRIGHT",  padR, -padT)
		bg:SetHeight(bgH + padT + padB)
	end
	return fs
end

function W.FAQConfig(parent)
	local f = CreateFrame("Frame", "$parentFAQ", parent )
	f.SpecialType = "FAQConfig"
	f:SetSize(400, 170)
	Mixin(f, Mixins.functions.FAQConfig)

	local prev
	for _, key in ipairs(FAQEntries) do
		f[key] = CreateFAQFontString(f, key, prev)
		prev = f[key]
	end

	return f
end

Mixins.functions.FAQConfig = {}
function Mixins.functions.FAQConfig.Init(self, anchorframe, parent)
	self.Anchoreframe = anchorframe
	self.MyInformation = parent.DisplayOrder[self:GetID()]
	self.DisplayOrder = parent.DisplayOrder
end
