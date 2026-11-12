----------------------------------
--			SinStats			--
----------------------------------
local AddName, Ns = ...
local L = Ns.L

local headerWidth, headerHeight, updateSpeed = 200, 15, 1

Ns.ConfigDefaultFontSize = 17 -- right side
Ns.TexturePath = "Interface\\AddOns\\"..AddName.."\\Textures\\"
local _P = "Interface\\AddOns\\"..AddName.."\\Textures\\png\\minimap\\"

Ns.IgnoreFormat = 0x1 -- just return the icon without any |T...:0|t. Can be used to display in Texture widgets
Ns.ForceIcon = 0x2 -- fors the use of the icon key is the source table has both a spell and and icon key
--Ns.IgnoreColor = ""
Ns.BottomLeft = 1 -- Option 1 use for anchor point of ident (indent???) stat. positioning
Ns.BottomRight = 2 -- Option 2 use for anchor point of ident (indent???) stat. positioning
Ns.LWin = LibStub("LibWindow-1.1")
Ns.AceSerializer = LibStub("AceSerializer-3.0")

function Ns.Band(var, flag)
	if var == nil then
		return false
	end
	if bit.band(var, flag) == flag then
		return true
	end
	return false
end

Ns.FunctionList = {}

------------------------------------------
--		  Bar Options Init			--
------------------------------------------

function Ns.InitBarOptions()
	if Ns.BarKeys then return end
	local barSet = {}
	local dynamicLinked = {}
	local staticKeys = {}
	local dynamicBaseKeys = {}
	local modeKeys = {}
	local showBarEntry
	for _, entry in ipairs(Ns.Options) do
		if entry.baropt then
			barSet[entry.stat] = true
			if entry.stat == "ShowBar" then
				showBarEntry = entry
			end
			if entry.barmode then
				dynamicLinked[#dynamicLinked+1] = entry.stat
				dynamicLinked[#dynamicLinked+1] = false
				for mode in entry.barmode:gmatch("[^,]+") do
					if not modeKeys[mode] then modeKeys[mode] = {} end
					modeKeys[mode][#modeKeys[mode]+1] = entry.stat
				end
			elseif entry.staticopt then
				staticKeys[#staticKeys+1] = entry.stat
			else
				dynamicBaseKeys[#dynamicBaseKeys+1] = entry.stat
			end
		end
	end
	if showBarEntry then showBarEntry.linked = dynamicLinked end
	Ns.BarKeys = barSet

	for _, entry in ipairs(Ns.DefaultOrder) do
		if entry.options then
			for _, key in ipairs(staticKeys) do
				entry.options[key] = true
			end
			local mode = entry.options.WithBar
			if mode then
				entry.options.WithBar = nil
				if mode == true then mode = "Default" end
				for _, key in ipairs(dynamicBaseKeys) do
					entry.options[key] = true
				end
				if modeKeys[mode] then
					for _, key in ipairs(modeKeys[mode]) do
						entry.options[key] = true
					end
				end
			end
		end
	end
end

------------------------------------------
--			Initialize Icons			--
------------------------------------------
local function LibInit()
	Ns.sshMiniButton = LibStub("LibDBIcon-1.0", true)
	local MinimapIcon = LibStub("LibDataBroker-1.1"):NewDataObject("SinStats",
		{
			type = "data source",
			text = "SinStats",
			icon = Ns.TexturePath.."MiniMap",

			OnTooltipShow = function(tooltip)
				tooltip:SetText("|T"..Ns.TexturePath.."SinStatsLogo:35|t")
				tooltip:AddLine("|cffffbc35"..L["QuickAccess"].."|r")
				tooltip:AddLine("|T".._P.."left.png:23|t "..L["OpenSettings"], 1, 1, 1)
				tooltip:AddLine("|T".._P.."right.png:23|t "..L["EnableDisable"], 1, 1, 1)
				tooltip:AddLine("|T".._P.."right.png:23|t |cffffbc35"..L["ShiftRightClick"].."|r - "..L["UnlockHUD"], 1, 1, 1)
			end,

			OnClick = function(self, button, down)
                if button == "LeftButton" then
                    Ns:ToggleConfig()
                elseif button == "RightButton" then
                    if IsShiftKeyDown() then
                        Ns.Profile.LockHUD = not Ns.Profile.LockHUD
                        Ns:InitialiseProfile(Ns.Profile)
                    else
                        Ns.Profile.HideHUD = not Ns.Profile.HideHUD
                        Ns:InitialiseProfile(Ns.Profile)
                    end
                end

            end,
		}
	)
	Ns.Profile.Minimap.hide = not Ns.Profile.Minimap.Show
	if Ns.sshMiniButton then
		Ns.sshMiniButton:Register("SinStats", MinimapIcon, Ns.Profile.Minimap)
	end

end

local function InitDefaults()
	if SinStatsDB and SinStatsDB.profileKeys and SinStatsDB.profiles then

		if not SinStatsDB.profiles["Default"] then
			Ns:CreateProfile("Default", nil, "WARRIOR") -- just in case
		end

		for _, settings in pairs(SinStatsDB.profiles) do
			Ns:MigrateToPanel(settings)
		end

		if not SinStatsDB.specProfiles then
			SinStatsDB.specProfiles = {}
		end
		if not SinStatsDB.schemaMigrations then
			SinStatsDB.schemaMigrations = {}
		end

		if not SinStatsDB.schemaMigrations.hideTextReset then
			for _, settings in pairs(SinStatsDB.profiles) do
				for _, panelData in pairs(settings.Panels) do
					panelData.HideText = false
				end
			end
			SinStatsDB.schemaMigrations.hideTextReset = true
		end
		return
	end
	SinStatsDB = { profileKeys={}, profiles={}, specProfiles={}, schemaMigrations={} }
	Ns:CreateProfile("Default", nil, "WARRIOR")
	if Ns.byPlayerClass then
		for className in pairs(Ns.byPlayerClass) do
			Ns:CreateProfile(className, nil, className)
		end
	end
end

local function CheckForNewOptions()

	local settings = Ns.ProfileRoot
	if not settings then return end
	Ns:MigrateToPanel(settings)
	for _, panelData in pairs(settings.Panels) do
		for _, displayOrder in ipairs(Ns.ProfileRootOrders) do
			for _, value in pairs(displayOrder) do
				if type(value) == "table" and value.stat and not value.svnotintable then
					if panelData[value.stat] == nil and value.default ~= nil then
						panelData[value.stat] = value.default
					end
				end
			end
		end
		for stat, data in pairs(panelData.Stats or {}) do
			for _, statkey in pairs(Ns.DefaultOrder) do
				if statkey.stat == stat then
					if not statkey.options then
						break
					end
					for option, istrue in pairs(statkey.options) do
						for _, optionentry in pairs(Ns.Options) do
							if optionentry.stat == option then
								if istrue and (optionentry.default ~= nil) and data[option] == nil then
									data[option] = optionentry.default
								end
							end
						end
					end
				end
			end
		end
	end
end

local otherUpdateSpeeds = {
	[1] = 0.2,
}
local otherUpdateSpeedsElapsed, otherUpdateSpeedsStats = {}, {}

function Ns:RegisterForOtherUpdate(id, stat)
	if not otherUpdateSpeeds[id] then
		error("|cffff0000SinStats ERROR:|r Ns:RegisterForOtherUpdate - No Elapsed time available for id |cffffff00".. id .."|r")
	end
	if not otherUpdateSpeedsElapsed[id] then
		otherUpdateSpeedsElapsed[id] = otherUpdateSpeeds[id]
	end
	if not otherUpdateSpeedsStats[id] then
		otherUpdateSpeedsStats[id] = {}
	end
	tinsert(otherUpdateSpeedsStats[id], stat)
end

function Ns:ClearOtherUpdates()
	table.wipe(otherUpdateSpeedsElapsed)
	table.wipe(otherUpdateSpeedsStats)
end

local function MoveEvents(panelData)
	if panelData.EventEnable or panelData.EventEnable == false then
		for k, v in pairs(Ns.EventsDisplayOrder) do
			if type(v) == "table" and v.stat then
				panelData.Stats[v.stat] = panelData[v.stat]
				panelData[v.stat] = nil
			end
		end
	end
end

function Ns.NewSettings(profileRoot, class)
--[[ DO NOT REMOVE! ]]--
	Ns.InitBarOptions() -- Process baropt / WithBar tags before reading the data
	Ns:MigrateToPanel(profileRoot)
	for _, panelData in pairs(profileRoot.Panels) do
		Ns:CheckForStats(panelData, class) -- Check if any new stats have been added
		MoveEvents(panelData)
		-- Remove old GroupOrder SV entry
		if panelData.GroupOrder ~= nil then
			panelData.GroupOrder = nil
		end
		-- Fix for Font droplist with incorrect or blank setting
		if panelData.StatFont == "Fonts/ARIALN.ttf" then
			panelData.StatFont = "Arial Narrow"
		end
	end
	CheckForNewOptions() -- Check if any new options have been added to ALL profiles/panels
end

--------------------------
--	Spec Profile Switch --
--------------------------
local specSwitching = false
function Ns:OnSpecChanged()
	if specSwitching then return end
	if not SinStatsDB.specProfiles then return end
	local specData = SinStatsDB.specProfiles[Ns.ProfileKey]
	if not specData or not specData.enabled then return end

	if not GetSpecialization then return end
	local specIndex = GetSpecialization()
	if not specIndex then return end

	local targetProfile = specData[specIndex]
	if not targetProfile or not SinStatsDB.profiles[targetProfile] then return end

	-- Already on this profile? Skip.
	if SinStatsDB.profileKeys[Ns.ProfileKey] == targetProfile then return end

	-- Switch profile
	specSwitching = true
	SinStatsDB.profileKeys[Ns.ProfileKey] = targetProfile
	Ns.ProfileRoot = SinStatsDB.profiles[targetProfile]
	Ns:MigrateToPanel(Ns.ProfileRoot)
	Ns.Profile = Ns.ProfileRoot.Panels[Ns.ProfileRoot.ActivePanel]
	Ns.NewSettings(Ns.ProfileRoot, Ns.Class)
	Ns:UpdateProfile()
	Ns:InitialiseAllPanels()
	specSwitching = false
end

--------------------------
--	Panel Frame Factory --
--------------------------
Ns.ProfileRoot = nil
Ns.PanelFrames = {}

local CONFIG_SHORTCUT_SIZE = 12  -- slightly smaller than 15px header height

local function AttachConfigShortcut(header)
	if header._SinStatsConfigBtn then return header._SinStatsConfigBtn end
	local btn = CreateFrame("Button", nil, header)
	btn:SetSize(CONFIG_SHORTCUT_SIZE, CONFIG_SHORTCUT_SIZE)
	btn:SetPoint("TOPRIGHT", header, "TOPRIGHT", -2, -2)
	btn:SetFrameLevel((header:GetFrameLevel() or 1) + 2)
	btn:SetNormalTexture(Ns.TexturePath .. "Settings")
	btn:SetHighlightTexture(Ns.TexturePath .. "Settings", "ADD")
	btn:GetNormalTexture():SetVertexColor(1, 1, 1, 0.8)
	btn:SetScript("OnClick", function() Ns:ToggleConfig() end)
	btn:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText((Ns.L and Ns.L["OpenSettings"]) or "Open Settings")
		GameTooltip:Show()
	end)
	btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
	header._SinStatsConfigBtn = btn
	return btn
end

function Ns.OnClickConfigShortcut(check, key, settings, info)
	if SinStatsFrame and SinStatsFrame._SinStatsConfigBtn then
		SinStatsFrame._SinStatsConfigBtn:SetShown(settings[key] ~= false)
	end
end

function Ns.OnClickHideHeader(check, key, settings, info)
	local activePanelName = Ns.ProfileRoot and Ns.ProfileRoot.ActivePanel or "Main"
	local pFrame = Ns.PanelFrames and Ns.PanelFrames[activePanelName]
	if pFrame and pFrame.Title then
		pFrame.Title:SetShown(not settings[key])
	end
end

function Ns:CreatePanelFrame(panelName)
	local hw, hh = 200, 15
	local pf = CreateFrame("Frame", "SinStatsPanel_" .. panelName, UIParent)
	pf:SetSize(hw, hh)
	pf:EnableMouse(true)
	pf:SetFrameStrata("MEDIUM")
	pf.Background = pf:CreateTexture()
	pf.Background:SetAllPoints()
	pf.Background:SetColorTexture(0.09020, 0.09020, 0.09020, 1)
	pf.Title = pf:CreateFontString(nil, "OVERLAY")
	pf.Title:SetFontObject("GameFontHighlight")
	pf.Title:SetTextColor(1, 1, 1)
	pf.Title:SetText(panelName)
	pf.Title:SetPoint("CENTER")
	pf.HUD = CreateFrame("Frame", nil, UIParent)
	pf.HUD:SetSize(hw, 2)
	pf.HUD:SetPoint("TOPLEFT", pf, "BOTTOMLEFT")
	pf.HUD:SetFrameStrata("MEDIUM")
	pf.HUD.Background = pf.HUD:CreateTexture()
	pf.HUD.Background:SetTexture("Interface/BUTTONS/WHITE8X8")
	pf.HUD.Background:SetVertexColor(0.1, 0.1, 0.1, 0)
	pf.HUD.Background:SetPoint("TOPLEFT", pf, "BOTTOMLEFT", 0, 1)
	pf.HUD.BorderFrame = CreateFrame("Frame", nil, pf.HUD, BackdropTemplateMixin and "BackdropTemplate" or nil)
	pf.HUD.BorderFrame:SetAllPoints(pf.HUD.Background)
	pf.HUD.StatList = {}
	return pf
end

--------------------------
--			HUD			--
--------------------------
local f = CreateFrame("Frame", "SinStatsFrame", UIParent)
f:SetSize(headerWidth, headerHeight)
f:EnableMouse(true)
f:SetFrameStrata("MEDIUM")
f.Background = f:CreateTexture()
f.Background:SetAllPoints()
f.Background:SetColorTexture(0.09020, 0.09020, 0.09020, 1)
f.Title = f:CreateFontString(nil, "OVERLAY");
f.Title:SetFontObject("GameFontHighlight");
f.Title:SetTextColor(1, 1, 1)
f.Title:SetText("SinStats")
f.Title:SetPoint("CENTER")
AttachConfigShortcut(f)
f.HUD = CreateFrame("Frame", nil, UIParent)
f.HUD:SetSize(headerWidth, 2)
f.HUD:SetPoint("TOPLEFT", f, "BOTTOMLEFT")
f.HUD:SetFrameStrata("MEDIUM")
f.HUD.Background = f.HUD:CreateTexture()
f.HUD.Background:SetTexture("Interface/BUTTONS/WHITE8X8")
f.HUD.Background:SetVertexColor(0.1, 0.1, 0.1, 0)
f.HUD.Background:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, 1)

	f.HUD.BorderFrame = CreateFrame("Frame", nil, f.HUD, BackdropTemplateMixin and "BackdropTemplate" or nil)
	f.HUD.BorderFrame:SetAllPoints(f.HUD.Background)

f.HUD.StatList = {}
f.HUD:SetScript("OnEvent", function (self, event, ...)
	if event == "PLAYER_LOGIN" then
		Ns:InitialiseVersionData()
		Ns.Name = UnitName("player")
		local realm = GetRealmName()

		-- adding dual name to forever profiles
		local charName = Ns.Name
		local isForever = (WOW_PROJECT_ID == WOW_PROJECT_CAMELOT) or (WOW_PROJECT_ID == 14)
		if isForever and UnitFullName then
			local fullName, surname = UnitFullName("player")
			if fullName and not (issecretvalue and (issecretvalue(fullName) or issecretvalue(surname))) then
				if surname and surname ~= "" and surname ~= realm
					and not strfind(fullName, surname, 1, true) then
					charName = fullName .. "-" .. surname
				else
					charName = fullName
				end
			end
		end
		Ns.ProfileKey = charName .. "-" .. realm
		Ns.Class = select(2, UnitClass("player"))
		InitDefaults()

		-- forever dual name check
		if isForever then
			local legacyKey = Ns.Name .. "-" .. realm
			if Ns.ProfileKey ~= legacyKey
				and not SinStatsDB.profileKeys[Ns.ProfileKey]
				and SinStatsDB.profileKeys[legacyKey] then
				SinStatsDB.profileKeys[Ns.ProfileKey] = SinStatsDB.profileKeys[legacyKey]
				SinStatsDB.profileKeys[legacyKey] = nil
				local legacySpec = SinStatsDB.specProfiles and SinStatsDB.specProfiles[legacyKey]
				if legacySpec and not SinStatsDB.specProfiles[Ns.ProfileKey] then
					SinStatsDB.specProfiles[Ns.ProfileKey] = legacySpec
					SinStatsDB.specProfiles[legacyKey] = nil
				end
			end
		end
		if not SinStatsDB.profileKeys[Ns.ProfileKey] then
			SinStatsDB.profileKeys[Ns.ProfileKey] = "Default"
		end
		Ns.ProfileRoot = SinStatsDB.profiles[SinStatsDB.profileKeys[Ns.ProfileKey]]
		Ns:MigrateToPanel(Ns.ProfileRoot)
		Ns.Profile = Ns.ProfileRoot.Panels[Ns.ProfileRoot.ActivePanel]
		Ns.NewSettings(Ns.ProfileRoot, Ns.Class)
		LibInit()
		if SinStatsFrame._SinStatsConfigBtn then
			SinStatsFrame._SinStatsConfigBtn:SetShown(Ns.Profile.ConfigShortcut ~= false)
		end

		-- Create panel frames for all panels
		Ns.PanelFrames["Main"] = SinStatsFrame
		for _, pName in ipairs(Ns.ProfileRoot.PanelOrder) do
			if pName ~= "Main" and not Ns.PanelFrames[pName] then
				Ns.PanelFrames[pName] = Ns:CreatePanelFrame(pName)
			end
		end
		-- Register LibWindow for each panel
		for pName, pFrame in pairs(Ns.PanelFrames) do
			local pd = Ns.ProfileRoot.Panels[pName]
			if pd then
				if not pd.HUDPos then
					pd.HUDPos = { point = "CENTER", x = 0, y = 0, scale = 1 }
				end
				Ns.LWin.RegisterConfig(pFrame, pd.HUDPos)
				Ns.LWin.MakeDraggable(pFrame)
			end
		end

		Ns.talentScan()
		self:SetScript("OnEvent", function(self, event, ...)

			if event == "PLAYER_SPECIALIZATION_CHANGED" then
				local unit = ...
				if unit ~= "player" then return end
				Ns:OnSpecChanged()
			elseif event == "PLAYER_TALENT_UPDATE" then
				-- MoP Classic: spec changes fire PLAYER_TALENT_UPDATE
				if WOW_PROJECT_ID == 19 then
					Ns:OnSpecChanged()
				end
			end
			if Ns.EventList[event] then
				local list = Ns.EventList[event]
				for k = 1, #list do
					local v = list[k]
					v.func(v.widget, v.data, v.options, ...)
				end
			end
			Ns.OnEventFunc(event, ...)
		end)

		if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
			self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
		end
		-- MoP Classic already registers PLAYER_TALENT_UPDATE via Mists.lua events table 

		C_Timer.After(1, function()
			self:GetScript("OnEvent")(SinStatsFrame.HUD, "UPDATE_INVENTORY_DURABILITY")
			self:GetScript("OnEvent")(SinStatsFrame.HUD, "PLAYER_EQUIPMENT_CHANGED")
		end)
		
		self.Elapsed = updateSpeed
		self:SetScript("OnUpdate", function(self, elapsed)
			for elapseId = 1, #otherUpdateSpeeds do
				local elapseTime = otherUpdateSpeedsElapsed[elapseId]
				if elapseTime then
					elapseTime = elapseTime - elapsed
					if elapseTime > 0 then
						otherUpdateSpeedsElapsed[elapseId] = elapseTime
					else
						otherUpdateSpeedsElapsed[elapseId] = otherUpdateSpeeds[elapseId]
						local stats = otherUpdateSpeedsStats[elapseId]
						if stats then
							for k = 1, #stats do
								local v = stats[k]
								v.func(v.widget, v.data, v.options, elapsed)
							end
						end
					end
				end
			end
			self.Elapsed = self.Elapsed - elapsed
			if self.Elapsed >= 0 then
				return
			end
			self.Elapsed = updateSpeed
			Ns.MeleeUpdate()
			Ns.DefenseUpdate()
			Ns.RangedUpdate()
			Ns.SpellUpdate()
			for k, v in ipairs(Ns.OnUpdateList) do
				v.func(v.widget, v.data, v.options, elapsed)
			end
		end)
		Ns:InitialiseAllPanels()

		C_Timer.After(0.5, function()
			if Ns.ProfileRoot then Ns:InitialiseAllPanels() end
		end)

		-- Apply spec profile for the current spec at login
		if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) or (WOW_PROJECT_ID == 19) then
			C_Timer.After(0.5, function()
				Ns:OnSpecChanged()
			end)
		end
	end
end)
f.HUD:RegisterEvent("PLAYER_LOGIN")
f.HUD:RegisterEvent("UPDATE_INVENTORY_DURABILITY")

--------------------------------------
--			Slash commands			--
--------------------------------------
SLASH_SINSTATS1 = "/sinstats"
SLASH_SINSTATS2 = "/ss"
function SlashCmdList.SINSTATS(msg)
	if msg and msg:lower() == "debug" then
		Ns.SinStatsDebug = not Ns.SinStatsDebug
		print("SinStats debug: " .. (Ns.SinStatsDebug and "|cff00ff00ON|r" or "|cffff0000OFF|r"))
	else
		Ns:ToggleConfig()
	end
end
