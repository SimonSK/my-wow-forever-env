
local _, Ns = ...
local L = Ns.L
local statPool = {}
local PDFHooked
local fontObjCounter = 0
local classId = select(2, UnitClass("player"))
local rClass, gClass, bClass = GetClassColor(classId)
local setClassColor = { r=rClass, g=gClass, b=bClass, a=0}
Ns.eventChecked = false
Ns.RunCheck = nil
Ns.dataColor = ""
Ns.TextSep = ":"

local OpPoints = {
    TOPLEFT="BOTTOMLEFT",
    TOPRIGHT="BOTTOMRIGHT",
    TOP="BOTTOM",
}

local UpAlign = {
    TOPLEFT  = "BOTTOMLEFT",
    TOPRIGHT = "BOTTOMRIGHT",
    TOP      = "BOTTOM",
}
local UpOpPoints = {
    BOTTOMLEFT  = "TOPLEFT",
    BOTTOMRIGHT = "TOPRIGHT",
    BOTTOM      = "TOP",
}

Ns.HUDAnchor = nil

----------------------------------
--		Local Accociations		--
----------------------------------
local function CreateStat(parentHUD)
	if #statPool > 0 then
		local stat = tremove(statPool)
		stat:SetParent(parentHUD)
		stat.BarBg:SetParent(parentHUD)
		stat.Bar:SetParent(parentHUD)
		stat.ValueText:SetParent(parentHUD)

		if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
			stat:SetToDefaults()
			stat:SetDrawLayer("OVERLAY")
			stat.ValueText:SetToDefaults()
			stat.ValueText:SetDrawLayer("OVERLAY")
		end
		return stat
	end
	local f = parentHUD:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	Mixin(f, Ns.StatMixin)
	f:SetVertexColor(1, 1, 1)
	f.ProfileSettings = {}

	f.BarBg = parentHUD:CreateTexture(nil, "ARTWORK", nil, 6)
	f.BarBg:SetTexture("Interface/BUTTONS/WHITE8X8")
	f.BarBg:SetVertexColor(0.1, 0.1, 0.1, 0.6)
	f.BarBg:Hide()

	f.Bar = parentHUD:CreateTexture(nil, "ARTWORK", nil, 7)
	f.Bar:SetTexture("Interface/BUTTONS/WHITE8X8")
	f.Bar:SetVertexColor(0.2, 0.6, 0.2, 1)
	f.Bar:Hide()

	f.ValueText = parentHUD:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	f.ValueText:SetVertexColor(1, 1, 1)
	f.ValueText:SetJustifyV("TOP")
	f.ValueText:SetJustifyH("LEFT")
	f.ValueText:SetWordWrap(false)
	f.ValueText:Hide()
	return f
end

local function InsertStat(panelHUD, panelFrame, profile, statdata, statoptions)
	local newWidget = CreateStat(panelHUD)
	newWidget.PanelData = profile -- per-panel data reference for UpdateText/UpdateBar
	newWidget.PanelFrame = panelFrame -- header frame for this panel
	local newStat = { widget=newWidget, data=statdata, options=statoptions, func=Ns.FunctionList[statdata.stat], newcolumn=profile.NewColumns and profile.NewColumns[statdata.stat]}
	tinsert(panelHUD.StatList, newStat)
	newWidget:SetJustifyV("TOP")
	if profile.StatAlignment == "TOPLEFT" then
		newWidget:SetJustifyH("LEFT")
	elseif profile.StatAlignment == "TOP" then
		newWidget:SetJustifyH("CENTER")
	else
		newWidget:SetJustifyH("RIGHT")
	end
	newWidget:SetSize(0, 0)

	if statdata.events then
		for event, evendata in pairs(statdata.events) do
			if not Ns.EventList[event] then
				Ns.EventList[event] = {}
			end
			newStat.units = evendata
			tinsert(Ns.EventList[event], newStat)
		end
	end
	if statdata.onupdate then
		if statdata.updatespeed then
			Ns:RegisterForOtherUpdate(statdata.updatespeed, newStat)
		else
			tinsert(Ns.OnUpdateList, newStat)
		end
	end
	Ns.dataColor = ""
	if statoptions.ColorCustom then
		if statoptions.ColorClass then
			newWidget:SetVertexColor(setClassColor.r, setClassColor.g, setClassColor.b)
		else
			newWidget:SetVertexColor(statoptions.ColorName.r, statoptions.ColorName.g, statoptions.ColorName.b)
		end
		if statoptions.ColorValueEndable then
			local valueColor = statoptions.ColorValue or profile.DataColor or { r=1, g=1, b=1 }
			Ns.dataColor = CreateColor(valueColor.r, valueColor.g, valueColor.b)
			Ns.dataColor = Ns.dataColor:GenerateHexColorMarkup()
		end
	else
		if profile.StatTextColor then
			if profile.ClassColors then
				newWidget:SetVertexColor(setClassColor.r, setClassColor.g, setClassColor.b)
			else
				newWidget:SetVertexColor(profile.StatTextColor.r, profile.StatTextColor.g, profile.StatTextColor.b)
			end
		end
		if profile.DataColor and profile.SplitColors then
			Ns.dataColor = CreateColor(profile.DataColor.r, profile.DataColor.g, profile.DataColor.b)
			Ns.dataColor = Ns.dataColor:GenerateHexColorMarkup()
		end
	end
	newWidget.DataColor = Ns.dataColor

	if newWidget.ValueText then
		newWidget.ValueText:SetJustifyV("TOP")
		newWidget.ValueText:SetJustifyH("LEFT")
		newWidget.ValueText:SetWordWrap(false)
		newWidget.ValueText:SetVertexColor(newWidget:GetTextColor())
	end
	newWidget.TextSep = profile.TextSeparator or ":"
end

local function PDFOnShow(self)
	for pName, pFrame in pairs(Ns.PanelFrames) do
		local pd = Ns.ProfileRoot and Ns.ProfileRoot.Panels[pName]
		if pd and pd.PanelDisplay then
			if not pd.LockHUD then
				pFrame:Show()
			end
			pFrame.HUD:Show()
		end
	end
end

local function PDFOnHide(self)
	for pName, pFrame in pairs(Ns.PanelFrames) do
		local pd = Ns.ProfileRoot and Ns.ProfileRoot.Panels[pName]
		if pd and pd.PanelDisplay then
			pFrame:Hide()
			pFrame.HUD:Hide()
		end
	end
end

local function KillStat(stat)
	tinsert(statPool, stat.widget)
	wipe(stat.widget.ProfileSettings)
	stat.widget.PanelData = nil
	stat.widget.PanelFrame = nil
	stat.widget:Hide()
	stat.widget:ClearAllPoints()
	stat.widget.BarShown = false
	stat.widget.BarCacheRatio = nil
	stat.widget.BarCacheWidth = nil
	stat.widget.AlignedBarWidth = nil
	stat.widget._cachedBarWidth = nil
	stat.widget._staticOnly = false
	if stat.widget.BarBg then
		stat.widget.BarBg:Hide()
		stat.widget.BarBg:ClearAllPoints()
	end
	if stat.widget.Bar then
		stat.widget.Bar:Hide()
		stat.widget.Bar:ClearAllPoints()
	end
	if stat.widget.ValueText then
		stat.widget.ValueText:Hide()
		stat.widget.ValueText:ClearAllPoints()
		stat.widget.ValueText:SetText("")
	end
end

------------------------------------------
--		Shared Functions and Data		--
------------------------------------------

Ns.StatMixin = {}

function Ns.StatMixin.UpdateText(self, data, funcdata)
    if funcdata == nil then return end  -- stat returned no value; leave display unchanged
    local pd = self.PanelData or Ns.Profile
    local statName
    local rawName = pd.Stats[data.stat].CustName
    local hideStatName = rawName and rawName ~= "" and string.trim(rawName) == ""
    local custName = rawName and string.trim(rawName) or nil
    if hideStatName then
        statName = ""
    elseif custName and custName ~= "" then
    	statName = custName
    elseif data.stat == "Primary" and Ns.primaryAutoName then
    	statName = Ns.primaryAutoName
    else
    	statName = L[data.stat]
    end
    if pd.StatTextCaps then
        statName = strupper(statName)
    end
    local sep = self.TextSep or Ns.TextSep
    local alignActive = self.PanelFrame and self.PanelFrame.HUD and self.PanelFrame.HUD.AlignActive
    if alignActive and self.ValueText then -- 2nd fontstring..
        local labelText, valueText
        if pd.HideText then
            if pd.IconAlignment == "TOPLEFT" then
                labelText = self.ProfileSettings.Icon
                valueText = format("%s%s", self.DataColor, funcdata)
            else
                labelText = ""
                valueText = format("%s%s %s", self.DataColor, funcdata, self.ProfileSettings.Icon)
            end
        elseif pd.IconAlignment == "TOPLEFT" then
            labelText = format("%s %s%s", self.ProfileSettings.Icon, statName, sep)
            valueText = format("%s%s", self.DataColor, funcdata)
        else
            labelText = format("%s%s", statName, sep)
            valueText = format("%s%s %s", self.DataColor, funcdata, self.ProfileSettings.Icon)
        end
        self:SetText(labelText)
        self.ValueText:SetText(valueText)
        self.ValueText:Show()
    else
        if self.ValueText then self.ValueText:Hide() end
        if pd.HideText then
            if pd.IconAlignment == "TOPLEFT" then
                self:SetText(format("%s %s%s", self.ProfileSettings.Icon, self.DataColor, funcdata))
            else
                self:SetText(format("%s%s %s", self.DataColor, funcdata, self.ProfileSettings.Icon))
            end
        elseif pd.IconAlignment == "TOPLEFT" then
		self:SetText(format("%s %s%s%s %s", self.ProfileSettings.Icon, statName, sep, self.DataColor, funcdata))
        else
            self:SetText(format("%s%s%s %s %s", statName, sep, self.DataColor, funcdata, self.ProfileSettings.Icon))
        end
    end
    if self._staticOnly then
        self:UpdateBar(data, 0)
    end
end

function Ns.StatMixin.UpdateBar(self, data, value, maxValue)
	if not self.Bar then return end
	local pd = self.PanelData or Ns.Profile
	local options = pd.Stats[data.stat]
	if not options or (not options.ShowBar and not options.StaticBar) then
		if self.BarShown then
			self.Bar:Hide()
			if self.BarBg then self.BarBg:Hide() end
			self.BarShown = false
			self.BarCacheRatio = nil
			self.BarCacheWidth = nil
		end
		return
	end
	local totalWidth = self.AlignedBarWidth or self._cachedBarWidth
	if not totalWidth or totalWidth <= 0 then
		local w = self:GetWidth()
		if not (issecretvalue and issecretvalue(w)) and w > 0 then
			totalWidth = w
			self._cachedBarWidth = w
		else
			local pd = self.PanelData or Ns.Profile
			totalWidth = pd.StatWidth or 150
		end
	end

	if not options.ShowBar then
		-- clearing garbage..
		if self.BarShown and self.BarCacheRatio == -1 and self.BarCacheWidth == totalWidth then
			return
		end
		self.Bar:ClearAllPoints()
		self.Bar:SetPoint("TOPLEFT", self, "TOPLEFT")
		self.Bar:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")
		self.Bar:SetWidth(totalWidth)
		self.Bar:Show()
		if self.BarBg then self.BarBg:Hide() end
		self.BarShown = true
		self.BarCacheRatio = -1
		self.BarCacheWidth = totalWidth
		return
	end

	local maxVal = maxValue or 100
	if not maxValue then
		local mode = options.BarMaxMode or 1
		if mode == 1 then
			maxVal = (options.Cap_Percent and options.Cap_Percent > 0) and options.Cap_Percent or 100
		elseif mode == 2 then
			maxVal = (options.BarMaxCustom and options.BarMaxCustom > 0) and options.BarMaxCustom or 100
		end
	end

	local safeValue = (issecretvalue and issecretvalue(value)) and 0 or (value or 0)
	local ratio = (maxVal > 0) and math.min(safeValue / maxVal, 1) or 0

	if self.BarShown and self.BarCacheRatio == ratio and self.BarCacheWidth == totalWidth then
		return
	end
	self.BarCacheRatio = ratio
	self.BarCacheWidth = totalWidth
	self.BarShown = true

	if options.BarAutoColor then
		local r, g, b
		local colorRatio = (data.stat == "Threat") and (1 - ratio) or ratio
		r, g, b = Ns:GradientColor(colorRatio)
		self.Bar:SetVertexColor(r, g, b, options.BarAlpha or 1)
	end

	local iconOffset = 0
	if self.ProfileSettings.Icon and self.ProfileSettings.Icon ~= "" and pd.IconAlignment == "TOPLEFT" and pd.StatIcons then
		local _, fontSize = self:GetFont()
		iconOffset = (fontSize or 0) + 2
	end

	if self.BarBg then
		self.BarBg:ClearAllPoints()
		self.BarBg:SetPoint("TOPLEFT", self, "TOPLEFT")
		self.BarBg:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")
		self.BarBg:SetWidth(totalWidth)
		self.BarBg:Show()
	end

	local barAreaWidth = totalWidth - iconOffset
	local barWidth = ratio > 0 and (iconOffset + barAreaWidth * ratio) or 0
	self.Bar:ClearAllPoints()
	self.Bar:SetPoint("TOPLEFT", self, "TOPLEFT")
	self.Bar:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", barWidth, 0)
	self.Bar:Show()
end

Ns.OnUpdateList = {}
Ns.EventList = {}
Ns.StatToDefaultOrder = {}

local byPlayerClassId

local rawIconCache = setmetatable({}, {__mode = "k"})

function Ns:GetSpellIcon(lookup, flags)
	local icon
	if type(lookup) == "table" then
		if rawIconCache[lookup] ~= nil then
			icon = rawIconCache[lookup]
		elseif WOW_PROJECT_ID == WOW_PROJECT_MAINLINE or WOW_PROJECT_ID == WOW_PROJECT_CAMELOT then
			if lookup.spell and not Ns.Band(flags, Ns.ForceIcon)  then
				icon = C_Spell.GetSpellInfo(lookup.spell)
				icon = icon.iconID
			elseif lookup.item and not Ns.Band(flags, Ns.ForceIcon)  then
				_,_,_,_,icon = C_Item.GetItemInfoInstant(lookup.item)
			elseif lookup.currency and not Ns.Band(flags, Ns.ForceIcon)  then
				icon = C_CurrencyInfo.GetCurrencyInfo(lookup.currency)
				if icon then icon = icon.iconFileID end
			elseif lookup.icon then
				icon = lookup.icon
				if not icon or strtrim(icon) == "" then
					icon = "NoIcon"
				end
				if not strfind(icon, "\\") and not strfind(icon, "/") then
					icon = Ns.TexturePath .. icon
				end
			end
			rawIconCache[lookup] = icon or false
		else
			if lookup.spell and not Ns.Band(flags, Ns.ForceIcon)  then
				icon = select(3, GetSpellInfo(lookup.spell))
			elseif lookup.item and not Ns.Band(flags, Ns.ForceIcon)  then
				icon = select(5, GetItemInfoInstant(lookup.item))
			elseif lookup.currency and not Ns.Band(flags, Ns.ForceIcon)  then
				icon = C_CurrencyInfo.GetCurrencyInfo(lookup.currency)
				if icon then icon = icon.iconFileID end
			elseif lookup.icon then
				icon = lookup.icon
				if not icon or strtrim(icon) == "" then
					icon = "NoIcon"
				end
				if not strfind(icon, "\\") and not strfind(icon, "/") then
					icon = Ns.TexturePath .. icon
				end
			end
			rawIconCache[lookup] = icon or false
		end

		if icon == false then icon = nil end
	else
		icon = lookup
	end
	if Ns.Band(flags, Ns.IgnoreFormat) then
		return icon
	end
	if icon then
		icon = "|T"..icon..":0|t"
	end
	return icon or ""
end

-- Fonts registered by other addons may arrive after the HUD is first built.
-- Remember missing fonts and rebuild once they get registered in LibSharedMedia.
local pendingFonts = {}
local fontWatchReady = false

local function WatchFonts()
	if fontWatchReady then return end
	fontWatchReady = true
	local watcher = CreateFrame("Frame")
	LibStub("CallbackHandler-1.0"):New(watcher)
	Ns.LSM.RegisterCallback(watcher, "LibSharedMedia_Registered", function(_, mediaType, key)
		if mediaType == "font" and pendingFonts[key] then
			pendingFonts[key] = nil
			Ns:QueueProfileRefresh()
		end
	end)
end

function Ns:InitStat(self, profile, statdata)
	self.ProfileSettings.Icon = ""

	if profile.StatIcons and (statdata.spell or statdata.item or statdata.currency) then
    self.ProfileSettings.Icon = Ns:GetSpellIcon(statdata)
	end
	-- 12.0.7: SetShadowOffset directly on FontString is broken after SetFont.
	-- Workaround: set font + shadow on a Font object, then assign via SetFontObject.
	if not self._fontObj then
		fontObjCounter = fontObjCounter + 1
		self._fontObj = CreateFont("SinStats_Stat_" .. fontObjCounter)
	end
	-- noDefault: a font registered by another addon may not exist yet; keep our own until it does
	local fontPath = Ns.LSM:Fetch("font", profile.StatFont, true)
	if not fontPath then
		if profile.StatFont then pendingFonts[profile.StatFont] = true end
		WatchFonts()
		fontPath = Ns.ConfigDefaultFont
	end
	local fontObj = self._fontObj
	fontObj:SetFont(fontPath, profile.StatFontSize, profile.StatFontFlags)
	if profile.FontShadow then
		fontObj:SetShadowOffset(profile.ShadowX or 1, profile.ShadowY or -2)
		fontObj:SetShadowColor(0, 0, 0, 1)
	else
		fontObj:SetShadowOffset(0, 0)
		fontObj:SetShadowColor(0, 0, 0, 0)
	end
	self:SetFontObject(fontObj)

	if self.ValueText then
		if not self._valFontObj then
			fontObjCounter = fontObjCounter + 1
			self._valFontObj = CreateFont("SinStats_Val_" .. fontObjCounter)
		end
		local valFontObj = self._valFontObj
		valFontObj:SetFont(fontPath, profile.StatFontSize, profile.StatFontFlags)
		if profile.FontShadow then
			valFontObj:SetShadowOffset(profile.ShadowX or 1, profile.ShadowY or -2)
			valFontObj:SetShadowColor(0, 0, 0, 1)
		else
			valFontObj:SetShadowOffset(0, 0)
			valFontObj:SetShadowColor(0, 0, 0, 0)
		end
		self.ValueText:SetFontObject(valFontObj)
	end
	--local h = self:GetHeight()
	self:SetText(" ")
	local curH = self:GetHeight()
	local fontH = profile.StatFontSize or 12

	if (issecretvalue and issecretvalue(curH)) or not curH or curH < fontH then
		curH = fontH
	end
	self:SetHeight(curH)
	-- Other options


	local statOpts = profile.Stats and profile.Stats[statdata.stat]
	if self.Bar and statOpts and (statOpts.StaticBar or statOpts.ShowBar) then
		local barTexPath
		if statOpts.BarTexture then
			barTexPath = Ns.LSM:Fetch("statusbar", statOpts.BarTexture)
		end
		local barColor = statOpts.BarColor or { r=0.2, g=0.6, b=0.2 }
		local barAlpha = statOpts.BarAlpha or 1
		self.Bar:SetTexture(barTexPath or "Interface/BUTTONS/WHITE8X8")
		self.Bar:SetVertexColor(barColor.r, barColor.g, barColor.b, barAlpha)
		self.Bar:Hide()
		local bgColor = statOpts.BarBgColor or { r=0.1, g=0.1, b=0.1 }
		local bgAlpha = statOpts.BarBgAlpha or 0.6
		self.BarBg:SetTexture(barTexPath or "Interface/BUTTONS/WHITE8X8")
		self.BarBg:SetVertexColor(bgColor.r, bgColor.g, bgColor.b, bgAlpha)
		self.BarBg:Hide()
		self._staticOnly = statOpts.StaticBar and not statdata.options.ShowBar
	elseif self.Bar then
		self.Bar:Hide()
		self.BarBg:Hide()
		self._staticOnly = false
	end
end

function Ns:GetClass(class)
	if type(class) == "string" then
		return Ns.byPlayerClass[strupper(strtrim(class))]
	elseif type(class) == "number" then
		return byPlayerClassId[class]
	else
		print("Sinstats: No class listed for ", class)
	end
end

function Ns:FillDisplayOrder(orderedlist, profile, configfill)
	local added, removed
	if profile.CustomOrderList then
		for k, stat in ipairs(profile.CustomOrderList) do
			if profile.Stats[stat].Show then
				tinsert(orderedlist, Ns.DefaultOrder[Ns.StatToDefaultOrder[stat]])
			else
				removed = true
			end
		end
	end
	for k, v in ipairs(Ns.DefaultOrder) do
		if profile.Stats[v.stat].Show then
			local found
			if profile.CustomOrderList then
				for i, stat in ipairs(profile.CustomOrderList) do
					if stat == v.stat then
						found = true
						break
					end
				end
			end
			if not found then
				added = true
				if configfill then
					tinsert(orderedlist, { stat=v.stat, id=Ns.StatToDefaultOrder[v.stat], })
				else
					tinsert(orderedlist, v)
				end
			end
		end
	end
	return added, removed
end

function Ns:InitialiseVersionData()
	for k, v in ipairs(Ns.DefaultOrder) do
		Ns.StatToDefaultOrder[v.stat] = k
	end
end

function Ns:ResetHUD(panelName)
	local pd = panelName and Ns.ProfileRoot and Ns.ProfileRoot.Panels[panelName] or Ns.Profile
	pd.HUDPos = pd.HUDPos or {}
	wipe(pd.HUDPos)
	pd.HUDPos.point = "CENTER"
	pd.HUDPos.y = 0
	pd.HUDPos.x = 0
	pd.HUDPos.scale = 1
end

-- made it so that no processing is done if background is set to 0. avoids unnecessary calculations
function Ns.ResizeBackground(profile, panelFrame, NumCols, NumRows, onerow)
	if not panelFrame then
		panelFrame = SinStatsFrame
	end
	local hud = panelFrame.HUD
	if not hud or not hud.StatList or #hud.StatList == 0 then return end
	profile = profile or hud._profile or Ns.Profile
	local noBackground = (profile.HUDBgAlpha or 0) == 0 and not profile.HUDBorder

	NumCols = NumCols or hud._numCols or 1
	NumRows = NumRows or hud._numRows or 1 
	if onerow == nil then onerow = hud._oneRow end
	local width = 0
	local height = 0

	local function safeWidth(widget)
		local w = widget.AlignedBarWidth or widget:GetWidth()
		if issecretvalue and issecretvalue(w) then return profile.StatWidth or 150 end
		return w
	end
	local function safeHeight(widget)
		local h = widget:GetHeight()
		local fh = profile.StatFontSize or 12
		if (issecretvalue and issecretvalue(h)) or not h or h < fh then return fh end
		return h
	end
	if onerow then
		local r = hud.StatList[#hud.StatList].widget:GetRight()
		local l = hud.StatList[1].widget:GetLeft()
		if not (issecretvalue and issecretvalue(r)) and not (issecretvalue and issecretvalue(l)) then
			width = r - l + 25
		else
			for _, v in ipairs(hud.StatList) do
				width = width + safeWidth(v.widget)
			end
			width = width + 25
		end
		height = NumRows * (safeHeight(hud.StatList[1].widget) + profile.StatSpacingV)
	elseif NumCols > 1 then
		local lastWidget = hud.StatList[#hud.StatList].widget
		local lastWidth = safeWidth(lastWidget)
		local lastLeft = lastWidget:GetLeft()
		local firstLeft = hud.StatList[1].widget:GetLeft()
		if not (issecretvalue and issecretvalue(lastLeft)) and not (issecretvalue and issecretvalue(firstLeft)) then
			width = (lastLeft - firstLeft) + lastWidth
		else
			width = NumCols * lastWidth + (NumCols - 1) * (profile.StatSpacingH or 5)
		end
	else
		for k, v in pairs(hud.StatList) do
			local w = safeWidth(v.widget)
			if w > width then
				width = w
			end
		end
		width = width + profile.StatSpacingH + 15
	end
	if not onerow then
		height = (NumRows * safeHeight(hud.StatList[1].widget)) + (NumRows - 1) * profile.StatSpacingV
	end
	height = height + 2
	if not noBackground then
		hud.Background:SetSize(width, height)
	end

	panelFrame._hudW = width
	panelFrame._hudH = height
	panelFrame._growUp = profile.GrowDirection == "UP"
	if panelFrame.MouseOverFrame then

		local mofH = panelFrame:GetHeight() + height
		panelFrame.MouseOverFrame:ClearAllPoints()
		if panelFrame._growUp then
			panelFrame.MouseOverFrame:SetPoint("BOTTOMLEFT", panelFrame, "BOTTOMLEFT")
		else
			panelFrame.MouseOverFrame:SetPoint("TOPLEFT", panelFrame, "TOPLEFT")
		end
		panelFrame.MouseOverFrame:SetSize(width, mofH)
	end
	panelFrame:SetWidth(width)
end


function Ns:AlignStatValues(profile, panelFrame, NumCols)
	if not panelFrame then panelFrame = SinStatsFrame end
	local hud = panelFrame.HUD
	if not hud.AlignActive then
		if hud.StatList then
			for _, v in ipairs(hud.StatList) do
				if v.widget.ValueText then
					v.widget.ValueText:Hide()
					v.widget.ValueText:SetWidth(0)
				end
				v.widget.AlignedBarWidth = nil
			end
		end
		return
	end
	if not hud.StatList or #hud.StatList == 0 then return end

	local maxLabelWidth = 0
	local maxValueWidth = 0
	local anyNonSecretLabel = false
	local anyNonSecretValue = false
	for _, v in ipairs(hud.StatList) do
		if v.widget then
			local lw = v.widget:GetStringWidth() or 0
			if Ns.SinStatsDebug then
				print(string.format("|cffff9900SinStats AlignDbg:|r stat=%s lw=%.1f labelText=%q hudShown=%s",
					tostring(v.data and v.data.stat),
					lw,
					tostring(v.widget:GetText()),
					tostring(hud:IsShown())))
			end
			if not (issecretvalue and issecretvalue(lw)) then
				anyNonSecretLabel = true
				if lw > maxLabelWidth then maxLabelWidth = lw end
			end
			if v.widget.ValueText then
				local vw = v.widget.ValueText:GetStringWidth() or 0
				if Ns.SinStatsDebug then
					print(string.format("|cffff9900SinStats AlignDbg:|r   valueWidth=%.1f valueText=%q vtShown=%s",
						vw,
						tostring(v.widget.ValueText:GetText()),
						tostring(v.widget.ValueText:IsShown())))
				end
				if issecretvalue and issecretvalue(vw) then
					-- used cached width below..
				else
					anyNonSecretValue = true
					if vw > maxValueWidth then maxValueWidth = vw end
				end
			end
		end
	end

	if anyNonSecretLabel then
		hud._cachedMaxLabelWidth = maxLabelWidth
	else
		maxLabelWidth = hud._cachedMaxLabelWidth or maxLabelWidth
	end
	if anyNonSecretValue then
		hud._cachedMaxValueWidth = maxValueWidth
	else
		maxValueWidth = hud._cachedMaxValueWidth or maxValueWidth
	end

	local gap = profile.AlignGap or 5
	local alignedWidth = maxLabelWidth + gap + maxValueWidth
	if Ns.SinStatsDebug then
		print(string.format("|cffff9900SinStats AlignDbg:|r maxLabelW=%.1f maxValueW=%.1f gap=%s alignedW=%.1f AlignActive=%s stats=%d",
			maxLabelWidth, maxValueWidth, tostring(profile.AlignGap), alignedWidth,
			tostring(hud.AlignActive), #hud.StatList))
	end
	local statWidth = profile.StatWidth or 150
	local isMultiCol = NumCols and NumCols > 1

	local isRight = profile.StatAlignment == "TOPRIGHT"

	for _, v in ipairs(hud.StatList) do
		local vt = v.widget.ValueText
		if vt then
			vt:ClearAllPoints()
			if isRight then
				vt:SetPoint("TOPLEFT", v.widget, "TOPRIGHT", gap, 0)
				vt:SetJustifyH("RIGHT")
				if isMultiCol then
					local labelArea = math.max(1, statWidth - maxValueWidth - gap)
					vt:SetWidth(math.max(1, statWidth - labelArea - gap))
				else
					vt:SetWidth(maxValueWidth)
				end
			else
				vt:SetPoint("TOPLEFT", v.widget, "TOPLEFT", maxLabelWidth + gap, 0)
				vt:SetJustifyH("LEFT")
				if isMultiCol then
					local availWidth = statWidth - maxLabelWidth - gap
					vt:SetWidth(math.max(1, availWidth))
				else
					vt:SetWidth(0) -- auto-size for single column
				end
			end
			vt:Show()
		end

		if isMultiCol then
			if isRight then
				v.widget:SetWidth(math.max(1, statWidth - maxValueWidth - gap))
			end
			v.widget.AlignedBarWidth = statWidth
		elseif isRight then
			v.widget:SetWidth(maxLabelWidth)
			v.widget.AlignedBarWidth = alignedWidth
		else
			v.widget:SetWidth(alignedWidth)
			v.widget.AlignedBarWidth = alignedWidth
		end
		v.widget._cachedBarWidth = v.widget.AlignedBarWidth
	end

	if isRight then
		if isMultiCol then
			local widthDelta = maxValueWidth + gap
			for _, v in ipairs(hud.StatList) do
				if v.newcolumn then
					local p, r, rp, x, y = v.widget:GetPoint(1)
					v.widget:ClearAllPoints()
					v.widget:SetPoint(p, r, rp, (x or 0) + widthDelta, y or 0)
				end
			end
		elseif #hud.StatList > 0 then
			local w1 = hud.StatList[1].widget
			local p, r, rp, x, y = w1:GetPoint(1)
			w1:ClearAllPoints()
			w1:SetPoint(p, r, rp, (x or 0) - maxValueWidth - gap, y or 0)
		end
	end
end

----------------------------------
--	Profile Refresh (config)	--
----------------------------------
local profileDirty = false
function Ns:QueueProfileRefresh()
	if profileDirty then return end
	profileDirty = true
	C_Timer.After(0, function()
		profileDirty = false
		Ns:InitialiseAllPanels()
	end)
end

------------------------------------------
--		Initialise Stat. Widgets		--
------------------------------------------
function Ns:InitialisePanel(panelName)
	local profile = Ns.ProfileRoot.Panels[panelName]
	local panelFrame = Ns.PanelFrames[panelName]
	if not profile or not panelFrame then return end
	local hud = panelFrame.HUD

	if not byPlayerClassId then
		byPlayerClassId = {}
		for k, v in pairs(Ns.byPlayerClass) do
			if not C_CreatureInfo.GetClassInfo(v) then
				Ns.byPlayerClass[k] = nil
			end
		end
		for k, v in pairs(Ns.byPlayerClass) do
			byPlayerClassId[v] = k
		end
	end
	if profile.HUDBgTexture then
		local texPath = Ns.LSM:Fetch("statusbar", profile.HUDBgTexture)
		hud.Background:SetTexture(texPath or "Interface/BUTTONS/WHITE8X8")
	end
	if profile.HUDBgColor then
		hud.Background:SetVertexColor(profile.HUDBgColor.r, profile.HUDBgColor.g, profile.HUDBgColor.b)
	end
	if profile.LockHUD or profile.HideHUD then
		panelFrame:Hide()
	elseif panelFrame.mouseOverHidden then
		-- already hidden by mouse-over event
	else
		panelFrame:Show()
	end

	if profile.ResetPosition then
		profile.ResetPosition = false
		Ns:Confirm(L["ResetPosition"] or "Reset HUD Position?",
			function()
				Ns:ResetHUD(panelName)
				Ns:InitialiseAllPanels()
			end)
	end
	if not profile.HUDPos then
		Ns:ResetHUD(panelName)
	end

	Ns.LWin.RegisterConfig(panelFrame, profile.HUDPos)
	Ns.LWin.RestorePosition(panelFrame)
	if not Ns.PanelShowHooked then
		if profile.PanelShow then
			if WOW_PROJECT_ID == 14 then
				Ns.PanelShowHooked = true
				local function statsShow()
					if CharacterFrameExpandButton and PaperDollFrame:IsVisible() then
						if not CharacterStatsPane:IsShown() then
								CharacterFrameExpandButton:Click()
						end
					end
				end
				PaperDollFrame:HookScript("OnShow", statsShow)
			end
		else
			if WOW_PROJECT_ID == 14 then
				Ns.PanelShowHooked = true
				local function statsHide()
					if CharacterFrameExpandButton and PaperDollFrame:IsVisible() then
						if CharacterStatsPane:IsShown() then
								CharacterFrameExpandButton:Click()
						end
					end
				end
				PaperDollFrame:HookScript("OnShow", statsHide)
			end
		end
	end

	if profile.Stats.EventEnable and profile.Stats.EventWorld or profile.Stats.EventDungeon or profile.Stats.EventRaid or profile.Stats.EventPvP or profile.Stats.EventArena or profile.Stats.EventCombat or profile.Stats.EventDelves then
		Ns.eventChecked = true
	end

	if profile.Stats.EventEnable and not panelFrame.mouseOverHidden then
		local stats = profile.Stats
		local shouldHide = false
		local hasAnyEvent = stats.EventWorld or stats.EventDungeon or stats.EventRaid
			or stats.EventPvP or stats.EventArena or stats.EventCombat
			or stats.EventDelves or stats.EventResting or stats.EventMounted

		if hasAnyEvent then
			local inInstance, instanceType = IsInInstance()
			local INSTANCE_RULES = {
				{ type = "party",    key = "EventDungeon" },
				{ type = "raid",     key = "EventRaid" },
				{ type = "pvp",      key = "EventPvP" },
				{ type = "arena",    key = "EventArena" },
				{ type = "scenario", key = "EventDelves" },
			}

			if not profile.PanelDisplay and not stats.EventCombat then
				for _, rule in ipairs(INSTANCE_RULES) do
					local enabled = stats[rule.key]
					if enabled and instanceType == rule.type then
						-- Inside matching instance — show
					elseif enabled and not inInstance then
						shouldHide = true
					elseif not enabled and Ns.eventChecked and instanceType == rule.type then
						shouldHide = true
					end
				end

				if stats.EventWorld and instanceType == "none" then
					shouldHide = false
				end
			end

			if stats.EventCombat and not profile.PanelDisplay then
				shouldHide = not (UnitAffectingCombat("player") or InCombatLockdown())
			end

			if stats.EventResting and not profile.PanelDisplay and IsResting() then
				shouldHide = true
			end
			if stats.EventMounted and not profile.PanelDisplay and IsMounted() then
				shouldHide = true
			end
		end

		if shouldHide then
			local useOpacity = stats.EventOpacity
			local targetAlpha = useOpacity and (stats.EventOpacityValue or 0.3) or 0
			if not useOpacity then
				profile.HideHUD = true
			end
			hud:SetAlpha(targetAlpha)
			if targetAlpha <= 0 then
				hud:Hide()
			end
			if not profile.LockHUD then
				panelFrame:SetAlpha(targetAlpha)
				if targetAlpha <= 0 then
					panelFrame:Hide()
				end
			end
		else
			profile.HideHUD = false
			hud:SetAlpha(1)
			hud:Show()
			if not profile.LockHUD then
				panelFrame:SetAlpha(1)
				panelFrame:Show()
			end
		end
	end

	hud.Background:SetAlpha((profile.HideHUD and 0) or profile.HUDBgAlpha or 0)

	if hud.BorderFrame then
		local borderTex = profile.HUDBorder and profile.HUDBorderTexture and profile.HUDBorderTexture ~= "None"
			and Ns.LSM:Fetch("border", profile.HUDBorderTexture)
		if borderTex then
			local c = profile.HUDBorderColor or { r=0.1, g=0.1, b=0.1 }
			local borderPx = (profile.HUDBorderSize or 1) * 4
			local inset = profile.HUDBorderInset or 0
			local totalOffset = borderPx + inset

			hud.BorderFrame:ClearAllPoints()
			hud.BorderFrame:SetPoint("TOPLEFT", hud.Background, "TOPLEFT", -totalOffset, totalOffset)
			hud.BorderFrame:SetPoint("BOTTOMRIGHT", hud.Background, "BOTTOMRIGHT", totalOffset, -totalOffset)
			hud.BorderFrame:SetBackdrop({ edgeFile = borderTex, edgeSize = borderPx })
			hud.BorderFrame:SetBackdropBorderColor(c.r, c.g, c.b, 1)
			hud.BorderFrame:Show()
		else
			hud.BorderFrame:SetBackdrop(nil)
			hud.BorderFrame:Hide()
		end
	end

	if profile.HUDStrata == nil then profile.HUDStrata = "MEDIUM" end
	hud:SetFrameStrata(profile.HUDStrata)
	panelFrame:SetFrameStrata(profile.HUDStrata)
	if panelFrame.Title then
		panelFrame.Title:SetShown(not profile.HideHeader)
	end
	if panelFrame.Background then
		panelFrame.Background:SetAlpha(profile.HeaderOpacity or 1)
	end

	hud:Hide()
	for i=#hud.StatList, 1, -1 do
		KillStat(hud.StatList[i])
	end
	wipe(hud.StatList)

	if profile.HideHUD then
		if Ns.SinStatsDebug then print("|cffff9900SinStats Debug:|r InitialisePanel("..tostring(panelName)..") early return: HideHUD=true") end
		return
	end

	local orderedList = {}
	local oneRow = profile.NewColumns and true or false
	Ns:FillDisplayOrder(orderedList, profile, nil)

	local isCompact = false
	if oneRow and not profile.RowLayoutRows and profile.CustomOrderList and #profile.CustomOrderList > 1 then
		isCompact = true
		for k = 2, #profile.CustomOrderList do
			if not profile.NewColumns[profile.CustomOrderList[k]] then
				isCompact = false
				break
			end
		end
	end

	local NumRows, NumCols, RowCount = 0, 1, 1
	for k, v in ipairs(orderedList) do
		if profile.Stats[v.stat] and profile.Stats[v.stat].Show then
			if isCompact and not profile.NewColumns[v.stat] then
				profile.NewColumns[v.stat] = true
			end
			if profile.NewColumns and #hud.StatList > 1 then
				if not profile.NewColumns[v.stat] then
					oneRow = false
				else
					NumCols = NumCols + 1
				end
			end
			InsertStat(hud, panelFrame, profile, v, profile.Stats[v.stat])
		end
	end
	if #hud.StatList == 0 then
		if Ns.SinStatsDebug then print("|cffff9900SinStats Debug:|r InitialisePanel("..tostring(panelName)..") early return: StatList empty (no enabled stats)") end
		return
	end

	local growUp = profile.GrowDirection == "UP"
	-- Anchor params for the default TOPLEFT-aligned chain.
	local firstPoint  = growUp and "BOTTOMLEFT" or "TOPLEFT"
	local firstRel    = growUp and "TOPLEFT"    or "BOTTOMLEFT"
	local chainPoint  = growUp and "BOTTOMLEFT" or "TOPLEFT"
	local chainRel    = growUp and "TOPLEFT"    or "BOTTOMLEFT"
	local chainSpacingY = growUp and (profile.StatSpacingV) or (-profile.StatSpacingV)
	local totalRows = #hud.StatList
	local firstOnRow, lastAnchor
	if totalRows > 0 then
		local rows = profile.StatRows or 1

		for k, v in ipairs(hud.StatList) do
			v.widget:ClearAllPoints()
			if not oneRow and NumCols > 1 then
				v.widget:SetWidth(profile.StatWidth or 100)
				v.widget._cachedBarWidth = profile.StatWidth or 100
			end
			if k == 1 then
				v.widget:SetPoint(firstPoint, panelFrame, firstRel)
				firstOnRow = v.widget
				lastAnchor = v.widget
			else
				if v.newcolumn then
					v.widget:SetPoint("LEFT", firstOnRow, "RIGHT", profile.StatSpacingH, 0)
					firstOnRow = v.widget
					RowCount = 1
				else
					oneRow = false
					v.widget:SetPoint(chainPoint, lastAnchor, chainRel, 0, chainSpacingY)
					RowCount = RowCount + 1
				end
			end
			lastAnchor = v.widget
			if RowCount > NumRows then
				NumRows = RowCount
			end
			v.widget:Show()
			Ns:InitStat(v.widget, profile, v.data)
		end
	end
	if NumCols == 1 and profile.StatAlignment ~= "TOPLEFT" then
		local alignPoint = growUp and UpAlign[profile.StatAlignment] or profile.StatAlignment
		local alignRel   = growUp and UpOpPoints[alignPoint] or OpPoints[profile.StatAlignment]
		local spacingY   = growUp and profile.StatSpacingV or -profile.StatSpacingV
		for i, v in ipairs(hud.StatList) do
			v.widget:ClearAllPoints()
			v.widget:SetPoint(alignPoint, i == 1 and panelFrame or hud.StatList[i-1].widget, alignRel, 0, i == 1 and 0 or spacingY)
		end
	elseif oneRow and profile.StatAlignment == "TOPRIGHT" then
		for i=#hud.StatList, 1, -1 do
			local v = hud.StatList[i]
			v.widget:ClearAllPoints()
			if i == #hud.StatList then
				v.widget:SetPoint("TOPRIGHT", panelFrame, "BOTTOMRIGHT", 0, 0)
			else
				v.widget:SetPoint("RIGHT", hud.StatList[i + 1].widget, "LEFT", -profile.StatSpacingH, 0)
			end
		end
	end

	if hud.Background then
		hud.Background:ClearAllPoints()
		if growUp then
			hud.Background:SetPoint("BOTTOMLEFT", panelFrame, "TOPLEFT", 0, -1)
		else
			hud.Background:SetPoint("TOPLEFT", panelFrame, "BOTTOMLEFT", 0, 1)
		end
	end

	hud._profile = profile
	hud._numCols = NumCols
	hud._numRows = NumRows
	oneRow = oneRow and #hud.StatList > 1 -- to differentiate between one row and a single stat
	hud._oneRow = oneRow

	hud.AlignActive = profile.AlignValues and not oneRow and (
		profile.StatAlignment == "TOPLEFT" or
		profile.StatAlignment == "TOPRIGHT"
	)
	if Ns.SinStatsDebug then
		print(string.format("|cffff9900SinStats AlignDbg:|r Panel '%s' AlignActive=%s AlignValues=%s oneRow=%s StatAlignment=%s",
			tostring(panelName), tostring(hud.AlignActive),
			tostring(profile.AlignValues), tostring(oneRow), tostring(profile.StatAlignment)))
	end

	return { profile = profile, panelFrame = panelFrame, hud = hud, NumCols = NumCols, NumRows = NumRows, oneRow = oneRow }
end

--- Initialise all panels. Wipes global dispatch lists first, then rebuilds each panel.
function Ns:InitialiseAllPanels()
	if not Ns.ProfileRoot then return end

	local activePanels = { Main = true }
	for _, pName in ipairs(Ns.ProfileRoot.PanelOrder) do
		activePanels[pName] = true
		if pName ~= "Main" and not Ns.PanelFrames[pName] then
			Ns.PanelFrames[pName] = Ns:CreatePanelFrame(pName)
			local pd = Ns.ProfileRoot.Panels[pName]
			if pd then
				if not pd.HUDPos then
					pd.HUDPos = { point = "CENTER", x = 0, y = 0, scale = 1 }
				end
				if Ns.LWin then
					Ns.LWin.RegisterConfig(Ns.PanelFrames[pName], pd.HUDPos)
					Ns.LWin.MakeDraggable(Ns.PanelFrames[pName])
				end
			end
		end
	end
	for pName, pf in pairs(Ns.PanelFrames) do
		if not activePanels[pName] then
			if pf.HUD then

				if pf.HUD.StatList then
					for i = #pf.HUD.StatList, 1, -1 do
						KillStat(pf.HUD.StatList[i])
					end
					wipe(pf.HUD.StatList)
				end
				pf.HUD:UnregisterAllEvents()
				pf.HUD:Hide()
			end
			pf:Hide()

			Ns.PanelFrames[pName] = nil
		end
	end

	-- Wipe global dispatch lists (aggregated from all panels)
	SinStatsFrame.HUD:UnregisterAllEvents()
	wipe(Ns.OnUpdateList)
	Ns:ClearOtherUpdates()
	wipe(Ns.EventList)

	-- Initialise each panel and collect finalization data
	local panelResults = {}
	for _, panelName in ipairs(Ns.ProfileRoot.PanelOrder) do
		panelResults[panelName] = Ns:InitialisePanel(panelName)
		if Ns.SinStatsDebug then
			local info = panelResults[panelName]
			local pd = Ns.ProfileRoot.Panels[panelName]
			print("|cffff9900SinStats Debug:|r Panel '"..panelName.."': built="..tostring(info ~= nil).." HideHUD="..tostring(pd and pd.HideHUD).." stats="..tostring(info and #info.hud.StatList or 0))
		end
	end

	-- Register all per-stat events (aggregated from all panels) on the central dispatch frame
	for event, widgets in pairs(Ns.EventList) do
		for widget, widgetinfo in pairs(widgets) do
			if type(widgetinfo.units) == "table" then
				local units = { player=true, target=true }
				for _,unit in pairs(widgetinfo.units) do
					units[unit] = true
					SinStatsFrame.HUD:GetScript("OnEvent")(SinStatsFrame.HUD, event, unit)
				end
				local unit1, unit2
				if units.player then
					unit1 = "player"
				end
				if units.target then
					if not unit1 then
						unit1 = "target"
					else
						unit2 = "target"
					end
				end
				SinStatsFrame.HUD:RegisterUnitEvent(event, unit1, unit2)
			else
				SinStatsFrame.HUD:RegisterEvent(event)
				SinStatsFrame.HUD:GetScript("OnEvent")(SinStatsFrame.HUD, event)
			end
		end
	end

	-- Minimap / Compartment (from active panel, shared across addon)
	local mainPanel = Ns.Profile
	if mainPanel and mainPanel.Minimap and Ns.sshMiniButton then
		mainPanel.Minimap.hide = not mainPanel.Minimap.Show
		if mainPanel.Minimap.Show then
			Ns.sshMiniButton:Show("SinStats")
		else
			Ns.sshMiniButton:Hide("SinStats")
		end
	end
	if mainPanel and Ns.sshMiniButton and Ns.sshMiniButton:IsButtonCompartmentAvailable() then
		if mainPanel.CompButton then
			Ns.sshMiniButton:AddButtonToCompartment("SinStats")
		else
			Ns.sshMiniButton:RemoveButtonFromCompartment("SinStats")
		end
	end

	-- Register global events on the main dispatch frame
	for event, eveninfo in pairs(Ns.GlobalEvents) do
		if type(eveninfo) == "table" then
			SinStatsFrame.HUD:RegisterUnitEvent(event, unpack(eveninfo))
			for _, unit in pairs(eveninfo) do
				SinStatsFrame.HUD:GetScript("OnEvent")(SinStatsFrame.HUD, event, unit)
			end
		else
			SinStatsFrame.HUD:RegisterEvent(event)
			SinStatsFrame.HUD:GetScript("OnEvent")(SinStatsFrame.HUD, event)
		end
	end

	if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
		SinStatsFrame.HUD:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	end
	SinStatsFrame.HUD.Elapsed = 0
	SinStatsFrame.HUD:GetScript("OnUpdate")(SinStatsFrame.HUD, 10)

	for _, panelName in ipairs(Ns.ProfileRoot.PanelOrder) do
		local info = panelResults[panelName]
		if info then
			if info.NumCols == 1 then
				for i = 1, #info.hud.StatList do
					local v = info.hud.StatList[i]
					if v.func then v.func(v.widget, v.data, v.options) end
				end
			end

			Ns:AlignStatValues(info.profile, info.panelFrame, info.NumCols)

			if info.NumCols == 1 then
				for i = 1, #info.hud.StatList do
					local v = info.hud.StatList[i]
					if v.func then v.func(v.widget, v.data, v.options) end
				end
			end
			Ns.ResizeBackground(info.profile, info.panelFrame, info.NumCols, info.NumRows, info.oneRow)
			info.hud:Show()

			if info.profile.PanelDisplay then
				if not PDFHooked then
					PDFHooked = true
					PaperDollFrame:HookScript("OnShow", PDFOnShow)
					PaperDollFrame:HookScript("OnHide", PDFOnHide)
				end
				if not PaperDollFrame:IsVisible() then
					info.panelFrame:Hide()
					info.hud:Hide()
				end
				Ns.CharPanel = true
				info.panelFrame:Hide()
				info.hud:Hide()
			else
				Ns.CharPanel = false
			end
		end
	end

	if Ns.RefreshAllStatCounts then
		Ns:RefreshAllStatCounts()
	end
end

function Ns:InitialiseProfile(profile)
	Ns:InitialiseAllPanels()
end