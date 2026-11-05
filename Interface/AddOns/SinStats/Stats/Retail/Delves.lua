local _, Ns = ...
local L = Ns.L

local function GetDelvePreyOpts()
	if Ns.ProfileRoot and Ns.ProfileRoot.Panels then
		for _, pd in pairs(Ns.ProfileRoot.Panels) do
			local opts = pd.Stats and pd.Stats["DelvesPrey"]
			if opts then return opts end
		end
	end
	return Ns.Profile and Ns.Profile.Stats and Ns.Profile.Stats["DelvesPrey"]
end

-- Delves/Prety tracker
local SECONDS_PER_WEEK = 604800
local US_RESET_EPOCH = 1736262000
local EU_RESET_EPOCH = 1736319600

local function GetWeekID()
	local region = GetCurrentRegion()
	local epoch = (region == 3) and EU_RESET_EPOCH or US_RESET_EPOCH
	return floor((GetServerTime() - epoch) / SECONDS_PER_WEEK)
end

function Ns.GetTrackerData()
	if not SinStatsDB.delveTracker then SinStatsDB.delveTracker = {} end
	local key = Ns.ProfileKey
	if not key then return nil end
	local weekID = GetWeekID()
	if not SinStatsDB.delveTracker[key] or SinStatsDB.delveTracker[key].weekID ~= weekID then
		SinStatsDB.delveTracker[key] = { weekID = weekID, runs = {}, countAll = 0, countTier8 = 0 }
	end
	return SinStatsDB.delveTracker[key]
end

function Ns.GetVaultTier1Bonus()
	local trackerData = Ns.GetTrackerData()
	if not trackerData then return 0 end
	local activities = C_WeeklyRewards.GetActivities(6)
	local vaultTotal = 0

	if activities then
		for i = 1, #activities do
			local p = activities[i].progress or 0
			if p > vaultTotal then
				vaultTotal = p
			end
		end
		if vaultTotal > 0 then
			trackerData.vaultTotal = vaultTotal
		end
	end

	if vaultTotal == 0 then
		vaultTotal = trackerData.vaultTotal or 0
	end

	local trackedCount = #trackerData.runs
	local bonus = vaultTotal - trackedCount
	return bonus > 0 and bonus or 0
end

-- Matches Blizzard's Great Vault tooltip: combineSharedDifficulty = true.
-- Since 12.1.5 (Labyrinth of Kindo'jan), uncombined entries can split one tier's
-- points across multiple entries, which skews per-entry gap math vs the vault UI.
local function GetVaultTierCounts()
	local sorted = C_WeeklyRewards.GetSortedProgressForActivity(6, true)
	if not sorted then return {} end
	local counts = {}
	for _, entry in ipairs(sorted) do
		counts[entry.difficulty] = (counts[entry.difficulty] or 0) + entry.numPoints
	end
	return counts
end

function Ns.GetVaultTierBreakdown(trackerData)
	if not trackerData then return {} end
	Ns.gvFallback(trackerData)
	local vaultCounts = GetVaultTierCounts()
	if not vaultCounts or not next(vaultCounts) then return {} end
	local trackedByTier = {}
	for _, run in ipairs(trackerData.runs) do
		local t = type(run) == "table" and run.tier or run
		trackedByTier[t] = (trackedByTier[t] or 0) + 1
	end
	local extra = {}
	for tier, vaultCount in pairs(vaultCounts) do
		local gap = vaultCount - (trackedByTier[tier] or 0)
		if gap > 0 then extra[tier] = gap end
	end
	return extra
end

local DELVES_WIDGET_ID = 6183

local RITUAL_TROVE_SCENARIO_ID = 3420

function Ns.gvFallback(trackerData)
	if not trackerData or #trackerData.runs == 0 then return false end
	local vaultCounts = GetVaultTierCounts()
	if not vaultCounts or not next(vaultCounts) then return false end

	local trackedByTier = {}
	for _, run in ipairs(trackerData.runs) do
		local t = type(run) == "table" and run.tier or run
		trackedByTier[t] = (trackedByTier[t] or 0) + 1
	end

	local trimmed = false
	for tier, vaultCount in pairs(vaultCounts) do
		local excess = (trackedByTier[tier] or 0) - vaultCount
		if excess > 0 then

			for i = #trackerData.runs, 1, -1 do
				if excess <= 0 then break end
				local run = trackerData.runs[i]
				if type(run) == "table" and (run.source == "delve" or not run.source) and run.tier == tier then
					tremove(trackerData.runs, i)
					excess = excess - 1
					trimmed = true
				end
			end
		end
	end

	if trimmed then
		trackerData.countAll = #trackerData.runs
		local t8 = 0
		for _, run in ipairs(trackerData.runs) do
			local t = type(run) == "table" and run.tier or run
			if t >= 8 then t8 = t8 + 1 end
		end
		trackerData.countTier8 = t8
	end
	return trimmed
end

local cachedPreyQuestID

local PREY_WORDS_BY_LOCALE = {
	enUS = { "nightmare", "hard" },
	enGB = { "nightmare", "hard" },
	frFR = { "cauchemar", "difficile" },
	deDE = { "albtraum", "schwer" },
	esES = { "pesadilla", "dificil" },
	esMX = { "pesadilla", "dificil" },
	ptBR = { "pesadelo" },
	itIT = { "incubo" },
	ruRU = { "кошмар", "сложный" },
	koKR = { "악몽", "어려움" },
	zhCN = { "梦魇", "困难" },
	zhTW = { "夢魘", "困難" },
}

local localeWords = PREY_WORDS_BY_LOCALE[GetLocale()] or PREY_WORDS_BY_LOCALE.enUS

local function GetPreyTierFromTitle(questID)
	local title = C_QuestLog.GetTitleForQuestID(questID)
	if not title then return 1 end
	local lower = title:lower()
	if localeWords[1] and lower:find(localeWords[1], 1, true) then return 8 end
	if localeWords[2] and lower:find(localeWords[2], 1, true) then return 5 end
	return 1
end

local vaultHooked = false
local vaultShowHooked = false
local function TryHookGreatVault()
	if vaultHooked then return end
	local frame = WeeklyRewardsFrame
	if not frame then return end
	if not frame.Activities or #frame.Activities == 0 then
		if not vaultShowHooked then
			vaultShowHooked = true
			frame:HookScript("OnShow", TryHookGreatVault)
		end
		return
	end
	vaultHooked = true

	local function AddTrackerLines()
		local opts = GetDelvePreyOpts()
		if not opts or not opts.Vault_Tooltip then return end
		local trackerData = Ns.GetTrackerData()
		if not trackerData then return end
		local runs = trackerData.runs
		local vaultExtra = Ns.GetVaultTierBreakdown(trackerData)
		if #runs == 0 and not next(vaultExtra) then return end

		local tiers = {}
		local maxTier = 0
		for i = 1, #runs do
			local run = runs[i]
			local tier = type(run) == "table" and run.tier or run
			tiers[tier] = (tiers[tier] or 0) + 1
			if tier > maxTier then maxTier = tier end
		end

		for tier, count in pairs(vaultExtra) do
			tiers[tier] = (tiers[tier] or 0) + count
			if tier > maxTier then maxTier = tier end
		end

		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("SinStats " .. (L["VT_Header"] or ": Weekly runs"))
		for tier = 1, maxTier do
			if tiers[tier] then
				GameTooltip:AddDoubleLine(Ns.Colors.Green .. (L["VT_Tier"] or "Tier") .. " " .. tier .. "|r", tiers[tier], 1, 1, 1)
			end
		end
		GameTooltip:Show()
	end

	for _, actFrame in ipairs(frame.Activities) do
		if actFrame.info and actFrame.info.type == 6 then -- Only world section (delves)
			actFrame:HookScript("OnEnter", AddTrackerLines)
		end
	end
end

local delveTrackerFrame = CreateFrame("Frame")

function Ns.OnVaultTooltipToggle(self, key, settings)
	if settings[key] and not vaultHooked then
		if C_AddOns.IsAddOnLoaded("Blizzard_WeeklyRewards") then
			TryHookGreatVault()
		else
			delveTrackerFrame:RegisterEvent("ADDON_LOADED")
		end
	end
end

local cachedScenarioName = nil
local cachedScenarioTier = nil
local cachedScenarioID = nil
local pendingRitualSiteName = nil
local cachedVaultTierCounts = nil

delveTrackerFrame:RegisterEvent("SCENARIO_COMPLETED")
delveTrackerFrame:RegisterEvent("SCENARIO_UPDATE")
delveTrackerFrame:RegisterEvent("QUEST_ACCEPTED")
delveTrackerFrame:RegisterEvent("QUEST_TURNED_IN")
delveTrackerFrame:RegisterEvent("QUEST_REMOVED")
delveTrackerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
delveTrackerFrame:RegisterEvent("WEEKLY_REWARDS_UPDATE")
delveTrackerFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "WEEKLY_REWARDS_UPDATE" then
		Ns.GetVaultTier1Bonus()
		if pendingRitualSiteName then
			local newCounts = GetVaultTierCounts()
			local detectedGVTier = nil
			for diff, newCount in pairs(newCounts) do
				local prevCount = cachedVaultTierCounts and (cachedVaultTierCounts[diff] or 0) or 0
				if newCount > prevCount then
					detectedGVTier = diff
					break
				end
			end
			if detectedGVTier then
				local data = Ns.GetTrackerData()
				if data then
					tinsert(data.runs, { name = pendingRitualSiteName, tier = detectedGVTier, source = "ritual" })
					data.countAll = (data.countAll or 0) + 1
					if detectedGVTier >= 8 then data.countTier8 = (data.countTier8 or 0) + 1 end
				end
			end
			pendingRitualSiteName = nil
			cachedVaultTierCounts = nil
		end
		Ns.gvFallback(Ns.GetTrackerData())
		return
	end

	if event == "SCENARIO_UPDATE" then
		local widgetInfo = C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(DELVES_WIDGET_ID)
		if widgetInfo and widgetInfo.headerText ~= "" then
			cachedScenarioName = widgetInfo.headerText
			local t = tonumber(widgetInfo.tierText)
			if t and t > 0 then cachedScenarioTier = t end
		else
			-- Not a Delve — cache name and scenarioID from C_Scenario (for Ritual Site detection)
			local sName, _, _, _, _, _, _, _, _, _, _, _, sID = C_Scenario.GetInfo()
			if sName and sName ~= "" then cachedScenarioName = sName end
			if sID and sID > 0 then cachedScenarioID = sID end
		end
		return
	end

	if event == "PLAYER_ENTERING_WORLD" or event == "QUEST_ACCEPTED" then
		cachedScenarioName = nil
		cachedScenarioTier = nil
		cachedScenarioID = nil
		pendingRitualSiteName = nil
		cachedVaultTierCounts = nil
		if C_QuestLog.GetActivePreyQuest then
			cachedPreyQuestID = C_QuestLog.GetActivePreyQuest()
		end
		if event == "PLAYER_ENTERING_WORLD" and not vaultHooked then
			local statOpts = GetDelvePreyOpts()
			if statOpts and statOpts.Vault_Tooltip then
				if C_AddOns.IsAddOnLoaded("Blizzard_WeeklyRewards") then
					TryHookGreatVault()
				else
					self:RegisterEvent("ADDON_LOADED")
				end
			end
		end
		if event == "PLAYER_ENTERING_WORLD" then
			Ns.gvFallback(Ns.GetTrackerData())
		end
		return
	end

	if event == "ADDON_LOADED" then
		local addonName = ...
		if addonName == "Blizzard_WeeklyRewards" then
			self:UnregisterEvent("ADDON_LOADED")
			local statOpts = GetDelvePreyOpts()
			if statOpts and statOpts.Vault_Tooltip then
				C_Timer.After(0, TryHookGreatVault)
			end
		end
		return
	end

	if event == "QUEST_TURNED_IN" then
		local questID = ...
		if cachedPreyQuestID and cachedPreyQuestID == questID then
			local title = C_QuestLog.GetTitleForQuestID(questID) or "Prey"
			local tier = GetPreyTierFromTitle(questID)
			local data = Ns.GetTrackerData()
			if not data then return end
			tinsert(data.runs, { name = title, tier = tier, source = "prey" })
			data.countAll = (data.countAll or 0) + 1
			if tier >= 8 then data.countTier8 = (data.countTier8 or 0) + 1 end
			cachedPreyQuestID = nil
		end
		return
	end

	if event == "QUEST_REMOVED" then
		local questID = ...
		if cachedPreyQuestID and cachedPreyQuestID == questID then
			cachedPreyQuestID = nil
		end
		return
	end

	if event == "SCENARIO_COMPLETED" then
		local widgetInfo = C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(DELVES_WIDGET_ID)

		local name = (widgetInfo and widgetInfo.headerText and widgetInfo.headerText ~= "")
			and widgetInfo.headerText or cachedScenarioName or "Unknown"
		local tier = (widgetInfo and tonumber(widgetInfo.tierText)) or cachedScenarioTier

		if tier and tier >= 1 then
			local data = Ns.GetTrackerData()
			if data then
				tinsert(data.runs, { name = name, tier = tier, source = "delve" })
				data.countAll = (data.countAll or 0) + 1
				if tier >= 8 then data.countTier8 = (data.countTier8 or 0) + 1 end
			end
		else
			local sID = cachedScenarioID
			if sID ~= RITUAL_TROVE_SCENARIO_ID and not pendingRitualSiteName then
				pendingRitualSiteName = name
				cachedVaultTierCounts = GetVaultTierCounts()
			end
		end
		cachedScenarioName = nil ; cachedScenarioTier = nil ; cachedScenarioID = nil
	end
end)