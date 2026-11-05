local AddName, Ns = ...
local L = Ns.L

------------------------------
--		Options Equates		--
------------------------------

local Season, World, Equipped, Percentage, BNet, Rank, Raids, Yards, NPC, Spec, Level = 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
local Expansion, Realm, Max, Rating, Rep, Dungeons, Kilometers, Players, Hero, Name = 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
local Both = 3

----------------------
--		Misc		--
----------------------

-- Target Speed
function Ns.FunctionList.TargetSpeed(HUD, data, options, ...)

	local speedColor = ""
	local rawSpeed = GetUnitSpeed("target")
	if Ns.issecretvalue(rawSpeed) then
		local ok, text = pcall(Ns.DecimalNumber, 2, rawSpeed)
		HUD:UpdateText(data, ok and (text .. " y/s") or "0")
		return
	end
	local targetSpeed = rawSpeed / 7 * 100

	if targetSpeed == 0 or targetSpeed == 100 then speedColor = ""
	elseif targetSpeed < 100 then speedColor = "|cffC41E3A"
	elseif targetSpeed > 100 then speedColor = "|cff71FFC9" end

	HUD:UpdateText(data, speedColor .. string.format("%.0f%%", targetSpeed))
end
------------------------------------------------

-- Durability
function Ns.FunctionList.Durability(HUD, data, options, ...)
	local Durability, Current, Full, Percent
	local LowestCurrent, LowestFull, t1, t2, t3 = 500, 0, 0, 0, 100
	local statusbar

	for i=1,19 do
		Current, Full = GetInventoryItemDurability(i)		if Current and Full then
			Percent = floor(100*Current/Full + 0.5)
			if (Percent < t3) then
				t3 = Percent
			end
			if (Current < LowestCurrent) then
				LowestCurrent = Current
				LowestFull = Full
			end
			t1 = t1 + Current
			t2 = t2 + Full
		end
	end
	if t2 == 0 then
		Durability = "N/A"
	else
		Durability = floor(t1 * 100 / t2)
	end
	local Text = ""
	if type(Durability) == "number" then
		if not options.AutoColorOff then
			Text = Ns:GradientColorCode(Durability / 100) .. Text
		end
		Text = Text..Durability.."%"
		statusbar = Durability
	end

	HUD:UpdateText(data, Text)
	HUD:UpdateBar(data, statusbar, 100)
end
------------------------------------------------

-- Repair Cost
-- function Ns.FunctionList.RepairCost(HUD, data, options, ...)

-- 	local repairCost = GetRepairAllCost()
-- 	local returnText = "0"

-- 	if repairCost and repairCost > 0 then
-- 		local gold = floor(repairCost / 1e4)
-- 		if options.Display_Gold then
-- 			returnText = Ns.DecimalNumber(options.Decimals_Default, gold)
-- 		else
-- 			returnText = C_CurrencyInfo.GetCoinTextureString(repairCost)
-- 		end
-- 	end

-- 	HUD:UpdateText(data, returnText)
-- end
------------------------------------------------

-- Item Level
function Ns.FunctionList.ItemLevel(HUD, data, options, ...)

	local EB = options.Equipped_Overall
	local overall, equipped = GetAverageItemLevel()
	local returnText, decimals

	decimals = Ns.DecimalFormat(options.Decimals_Two)

	if Ns.Band(EB, Equipped) then returnText = (decimals):format(equipped) end
	if Ns.Band(EB, Max) then returnText = (decimals):format(overall) end
	if Ns.Band(EB, Both) then returnText = (decimals):format(equipped) .. "/" .. (decimals):format(overall) end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- PvP iLvl
function Ns.FunctionList.PvPiLvl(HUD, data, options, ...)

	local pvp = select(3, GetAverageItemLevel())
	local decimals

	decimals = Ns.DecimalFormat(options.Decimals_Two)

	HUD:UpdateText(data, (decimals):format(pvp))
end
------------------------------------------------

-- Global Cooldown
local gcd, oldgcd = 0, 0
function Ns.FunctionList.GlobalCD(HUD, data, options, ...)

	_, gcd = C_Spell.GetSpellCooldown(61304) or 0
	local display = 0
	if gcd then display = gcd.duration end
	local decimals

	if gcd == 0 then display = oldgcd
	else oldgcd = gcd end

	decimals = Ns.DecimalFormat(options.Decimals_Two)

	HUD:UpdateText(data, (decimals):format(display))
end
------------------------------------------------

-- Ping
function Ns.FunctionList.Lag(HUD, data, options, ...)

	local EB = options.World_Realm
	local _, _, lagRealm, lagWorld = GetNetStats()
	local lagColor = ""
	local returnText

	if lagWorld <= 90 or lagRealm <= 90 then lagColor = "|cff71FFC9"
	elseif (lagWorld >= 90 and lagWorld < 200) or  (lagRealm >= 90 and lagRealm < 200) then lagColor = "|cffFF7C0A"
	elseif lagWorld >= 200 or lagRealm >= 200 then lagColor = "|cffC41E3A" end

	if Ns.Band(EB, World) then returnText = lagColor .. floor(lagWorld) end
	if  Ns.Band(EB, Realm) then returnText = lagColor .. floor(lagRealm) end
	if  Ns.Band(EB, Both) then returnText = lagColor .. floor(lagWorld) .. "/" .. floor(lagRealm) end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- FPS
function Ns.FunctionList.FPS(HUD, data, options, ...)

	local framerate = GetFramerate()
	local fpsColor = ""
	local returnText

	if framerate < 30 then fpsColor = "|cffC41E3A"
	elseif framerate > 30 and framerate < 50 then fpsColor = "|cffFF7C0A"
	elseif framerate > 50 then fpsColor = "|cff71FFC9" end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, fpsColor .. floor(framerate))
end
------------------------------------------------

-- Coordinates
function Ns.FunctionList.Coordinates(HUD, data, options, ...)

	local mapID = C_Map.GetBestMapForUnit("player")
	local returnText = "--"

	if mapID then
		local pos = C_Map.GetPlayerMapPosition(mapID, "player")
		if pos then
			local x, y = pos:GetXY()
			local fmt = Ns.DecimalFormat(options.Decimals_One)
			local decimals = fmt .. ", " .. fmt

			returnText = (decimals):format(x * 100, y * 100)
		end
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Renown Factions
local function RenownFaction(factionId)
	return function(HUD, data, options, ...)
		local EB = options.Rank_Rep
		local renown = C_MajorFactions.GetMajorFactionData(factionId)
		local returnText
		local earned = renown.renownReputationEarned or 0
		local max = renown.renownLevelThreshold or 1

		if renown == nil then renown = 0 end

		local percent = earned / max * 100

		--percent = (percent * 0.04)
		returnText = renown.renownLevel or 0


		if Ns.Band(EB, Rank) then returnText = renown.renownLevel or 0 end
		if Ns.Band(EB, Rep) then returnText = Ns.DecimalNumber(options.Decimals_Default, earned) end
		if Ns.Band(EB, Both) then returnText = (renown.renownLevel or 0) .. "/" .. Ns.DecimalNumber(options.Decimals_Default, earned) end

		if options.Display_Percentage then returnText = returnText .. " (" .. ("%.0f%%"):format(percent) .. ")" end

		HUD:UpdateText(data, returnText)

		if type(renown) == "table" then
			local barMode = options.JourneyBarMode or 1
			if barMode == 2 then
				local levels = C_MajorFactions.GetRenownLevels(factionId)
				local maxLevel = levels and #levels or 1
				HUD:UpdateBar(data, renown.renownLevel, maxLevel)
			else
				HUD:UpdateBar(data, earned, max or 0)
				---print("Name: ", renown.name, "Renown Earned: ", renown.renownReputationEarned, "Renown Level Threshold: ", renown.renownLevelThreshold)
			end
		end
	end
end

for name, factionId in pairs(Ns.RenownData) do
	Ns.FunctionList[name] = RenownFaction(factionId)
end
------------------------------------------------

-- Delves Companion
function Ns.FunctionList.Companion(HUD, data, options, ...)

	local EB = options.Rank_Rep
	local returnText = "0"
	local barValue, barMax = 0, 1

	local factionID = C_DelvesUI.GetFactionForCompanion(2)
	if factionID and factionID > 0 then
		local fr = C_GossipInfo.GetFriendshipReputation(factionID)
		local ranks = C_GossipInfo.GetFriendshipReputationRanks(factionID)
		if fr and ranks then
			local level = ranks.currentLevel or 0
			local base = fr.reactionThreshold or 0
			local cap = fr.nextThreshold or base
			local rep = (fr.standing or 0) - base
			local threshold = cap - base
			if threshold <= 0 then threshold = 1 end

			if Ns.Band(EB, Rank) then returnText = level end
			if Ns.Band(EB, Rep) then returnText = Ns.DecimalNumber(options.Decimals_Default, rep) end
			if Ns.Band(EB, Both) then returnText = level .. "/" .. Ns.DecimalNumber(options.Decimals_Default, rep) end

			if options.Display_Percentage then
				local percent = rep / threshold * 100
				returnText = returnText .. " (" .. ("%.0f%%"):format(percent) .. ")"
			end

			local barMode = options.JourneyBarMode or 1
			if barMode == 2 then
				-- barValue = level
				-- barMax = ranks.maxLevel or 60
				local mod = (ranks.maxLevel - level) or 0
				barValue = rep
				barMax = threshold * mod
			else
				barValue = rep
				barMax = threshold
			end
		end
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Slayer's Duellum
function Ns.FunctionList.Slayer(HUD, data, options, ...)

	local EB = options.Rank_Rep
	local rep = C_Reputation.GetFactionDataByID(2770)
	local returnText = "0"
	local barValue, barMax = 0, 1

	if rep and rep.currentStanding and rep.currentReactionThreshold then
		local base = rep.currentReactionThreshold
		local cap = rep.nextReactionThreshold or base
		barValue = rep.currentStanding - base
		barMax = cap - base
		if barMax <= 0 then barMax = 1 end

		local standing = rep.reaction and _G["FACTION_STANDING_LABEL" .. rep.reaction] or ""

		if Ns.Band(EB, Rank) then returnText = standing end
		if Ns.Band(EB, Rep) then returnText = Ns.DecimalNumber(options.Decimals_Default, barValue) end
		if Ns.Band(EB, Both) then returnText = standing .. "/" .. Ns.DecimalNumber(options.Decimals_Default, barValue) end

		if options.Display_Percentage then
			local percent = barValue / barMax * 100
			returnText = returnText .. " (" .. ("%.0f%%"):format(percent) .. ")"
		end
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Aqir Research Enclave
function Ns.FunctionList.Aqir(HUD, data, options, ...)

	local EB = options.Rank_Rep
	local rep = C_GossipInfo.GetFriendshipReputation(2838)--C_Reputation.GetFactionDataByID(286563)
	local ranks = C_GossipInfo.GetFriendshipReputationRanks(2838)
	local returnText = "0"
	local barValue, barMax = 0, 1

	if rep and rep.standing and rep.nextThreshold then
		local base = (rep.standing - 500) or 0
		local cap = (rep.nextThreshold - 500) or 0
		if barMax <= 0 then barMax = 1 end
		if base < 0 then base = 0 end
		if cap < 0 then cap = 0 end

		local level = ranks and ranks.currentLevel or 0
		local standing = base
		local maxRep = rep.maxRep or 0

		local barMode = options.JourneyBarMode or 1
		if barMode == 2 then
			barValue = base
			barMax = maxRep
		else
			barValue = base
			barMax = cap
		end

		if Ns.Band(EB, Rank) then returnText = level end
		if Ns.Band(EB, Rep) then returnText = Ns.DecimalNumber(options.Decimals_Default, standing) end
		if Ns.Band(EB, Both) then returnText = level .. "/" .. Ns.DecimalNumber(options.Decimals_Default, standing) end

		if options.Display_Percentage then
			local percent = barValue / barMax * 100
			returnText = returnText .. " (" .. ("%.0f%%"):format(percent) .. ")"
		end
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Captain Tokka
function Ns.FunctionList.Tokka(HUD, data, options, ...)

	local EB = options.Rank_Rep
	local rep = C_GossipInfo.GetFriendshipReputation(2773)--C_Reputation.GetFactionDataByID(2773)
	local ranks = C_GossipInfo.GetFriendshipReputationRanks(2773)
	local returnText = "0"
	local barValue, barMax = 0, 1

	if rep and rep.standing and rep.nextThreshold then
		local base = (rep.standing - 100) or 0
		local cap = (rep.nextThreshold - 100) or 0
		if barMax <= 0 then barMax = 1 end
		if base < 0 then base = 0 end
		if cap < 0 then cap = 0 end

		local level = ranks and ranks.currentLevel or 0
		local standing = base
		local maxRep = rep.maxRep or 0

		local barMode = options.JourneyBarMode or 1
		if barMode == 2 then
			barValue = base
			barMax = maxRep
		else
			barValue = base
			barMax = cap
		end

		if Ns.Band(EB, Rank) then returnText = level end
		if Ns.Band(EB, Rep) then returnText = Ns.DecimalNumber(options.Decimals_Default, standing) end
		if Ns.Band(EB, Both) then returnText = level .. "/" .. Ns.DecimalNumber(options.Decimals_Default, standing) end

		if options.Display_Percentage then
			local percent = barValue / barMax * 100
			returnText = returnText .. " (" .. ("%.0f%%"):format(percent) .. ")"
		end
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Mythic Plus rating
function Ns.FunctionList.MythicPlus(HUD, data, options, ...)

	local EB = options.Season_Exp
	local expRating = C_MythicPlus.GetSeasonBestMythicRatingFromThisExpansion()
	local rating = C_ChallengeMode.GetOverallDungeonScore()
	local color = C_ChallengeMode.GetDungeonScoreRarityColor(rating)
	local colorBest = C_ChallengeMode.GetDungeonScoreRarityColor(expRating)
	local coloredRating, coloredBest = "", ""
	local returnText

	if color then coloredRating = color:WrapTextInColorCode(rating) end
	if colorBest then coloredBest = colorBest:WrapTextInColorCode(expRating) end

	if Ns.Band(EB, Season) then returnText = coloredRating end
	if Ns.Band(EB, Expansion) then returnText = coloredBest end
	if Ns.Band(EB, Both) then returnText = coloredRating .. "|r/" .. coloredBest end

	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Mythic Keystone
function Ns.FunctionList.Keystone(HUD, data, options, ...)

	local EB = options.Key_Name
	local key = C_MythicPlus.GetOwnedKeystoneLevel() or 0
	local id = C_MythicPlus.GetOwnedKeystoneChallengeMapID() or 0
	local name = ""
	local returnText

	if id and id > 0 then
		name = C_ChallengeMode.GetMapUIInfo(id) or name
	end

	if options.Abbrev then name = Ns.AbbreviateName(name) end

	if Ns.Band(EB, Level) then returnText = key end
	if Ns.Band(EB, Name) then returnText = name end
	if Ns.Band(EB, Both) then returnText = key .. " - " .. name end

	if returnText == nil then returnText = 0 end
	if name == "" then returnText = "N/A" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Great Vault
function Ns.FunctionList.GreatVault(HUD, data, options, ...)

	local EB = options.Raids_Dungeons
	local cap = options.Display_Weekly
	local returnText
	local bar

	local raidActivities = C_WeeklyRewards.GetActivities(3)
	local dungeonActivities = C_WeeklyRewards.GetActivities(1)

	local raidProgress = 0
	local raidCap = 0
	local dungeonProgress = 0
	local dungeonCap = 0
	local current = 0

	if raidActivities and #raidActivities > 0 then
		raidProgress = raidActivities[1].progress
		raidCap = raidActivities[#raidActivities].threshold
	end

	if dungeonActivities and #dungeonActivities > 0 then
		dungeonProgress = dungeonActivities[1].progress
		dungeonCap = dungeonActivities[#dungeonActivities].threshold
	end

	local raidText = tostring(raidProgress)
	local dungeonText = tostring(dungeonProgress)

	if cap then
		raidText = raidText .. "/" .. raidCap
		dungeonText = dungeonText .. "/" .. dungeonCap
	end

	if raidProgress >= raidCap and raidCap > 0 then raidText = "|cff71FFC9" .. raidText end
	if dungeonProgress >= dungeonCap and dungeonCap > 0 then dungeonText = "|cff71FFC9" .. dungeonText end

	if Ns.Band(EB, Raids) then returnText = raidText; bar = raidCap; current = raidProgress end
	if Ns.Band(EB, Dungeons) then returnText = dungeonText; bar = dungeonCap; current = dungeonProgress end
	if Ns.Band(EB, Both) then returnText = raidText .. "|r/" .. dungeonText end

	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, current, bar)
end
------------------------------------------------

-- Delves
-- function Ns.FunctionList.Delves(HUD, data, options, ...)

-- 	local entry = options.Editbox_D or 0
-- 	local delves = C_WeeklyRewards.GetActivities(6)
-- 	local tier = 0
-- 	local fallback = 0
-- 	local tier8 = options.Display_Delves
-- 	local matched = false
-- 	local hasUnlockedTier = false

-- 	if not delves then
-- 		HUD:UpdateText(data, tier)
-- 		return
-- 	end

-- 	for i=1,3 do
-- 		if delves[i] then
-- 			if delves[i].level == 0 then
-- 				fallback = delves[i].progress
-- 			else
-- 				hasUnlockedTier = true
-- 			end

-- 			if tier8 then
-- 				if delves[i].level >= 8 then
-- 					tier = delves[i].progress
-- 					matched = true
-- 				end
-- 			else
-- 				if delves[i].level == entry then
-- 					tier = delves[i].progress
-- 					matched = true
-- 				end
-- 			end
-- 		end
-- 	end

-- 	if not matched then
-- 		if not hasUnlockedTier then
-- 			tier = fallback
-- 		end
-- 	end

-- 	HUD:UpdateText(data, tier)
-- end
------------------------------------------------

-- Delves/Prey
function Ns.FunctionList.Delves(HUD, data, options, ...)

	local trackerData = Ns.GetTrackerData()
	local vaultExtra = Ns.GetVaultTierBreakdown(trackerData)
	local vaultExtraTotal = 0
	for _, c in pairs(vaultExtra) do vaultExtraTotal = vaultExtraTotal + c end
	local count

	if options.Display_All then
		count = (trackerData.countAll or #trackerData.runs) + vaultExtraTotal
	elseif options.Display_Tier8 then
		count = trackerData.countTier8 or 0
		for tier, c in pairs(vaultExtra) do
			if tier >= 8 then count = count + c end
		end
	else
		local minTier = options.Editbox_DP or 0
		if minTier > 0 then
			local runs = trackerData.runs
			count = 0
			for i = 1, #runs do
				local run = runs[i]
				local tier = type(run) == "table" and run.tier or run
				if tier == minTier then count = count + 1 end
			end
			count = count + (vaultExtra[minTier] or 0)
		else
			count = (trackerData.countAll or #trackerData.runs) + vaultExtraTotal
		end
	end

	HUD:UpdateText(data, count)
	HUD:UpdateBar(data, count, 8)
end
------------------------------------------------

-- Threat
function Ns.FunctionList.Threat(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local _, _, threatpct, _, threatvalue = UnitDetailedThreatSituation("player", "target")
	local returnText, statusbar
	local threatColor = ""

	if threatpct == nil then threatpct = 0 end
	if threatvalue == nil then threatvalue = 0 end

	if options.GradientText then
		threatColor = Ns.GradientGreenRed(threatpct, 100)
	end

	-- if threatpct <= 59 then threatColor = Ns.greenText
	-- elseif threatpct >= 60 and threatpct < 100 then threatColor = Ns.orangeText
	-- elseif threatpct == 100 then threatColor = Ns.redText end

	threatvalue = BreakUpLargeNumbers(threatvalue)

	if Ns.Band(EB, Percentage) then returnText = threatColor .. ("%.0f%%"):format(threatpct); statusbar = threatpct end
	if Ns.Band(EB, Rating) then returnText = threatColor .. ("%.0f"):format(threatvalue); statusbar = threatvalue end
	if Ns.Band(EB, Both) then returnText = threatColor .. ("%.0f%%"):format(threatpct) .. " |r(" .. ("%.0f"):format(threatvalue) .. ")"; statusbar = threatpct end

	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Guild
function Ns.FunctionList.Guild(HUD, data, options, ...)

	local totalMembers, numOnline = GetNumGuildMembers()
	local returnText

	if not IsInGuild() then
		HUD:UpdateBar(data, 0, 1)
		HUD:UpdateText(data, "0")
		return
	end

	if options.Display_Total then
		returnText = numOnline .. "/" .. totalMembers
	else
		returnText = tostring(numOnline)
	end

	HUD:UpdateBar(data, numOnline, totalMembers)
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Friends
function Ns.FunctionList.Friends(HUD, data, options, ...)

	local EB = options.BNet_Realm
	local bnetTotal, bnetOnline = BNGetNumFriends()
	local realmOnline = C_FriendList.GetNumOnlineFriends()
	local numFriends = C_FriendList.GetNumFriends()
	local returnText
	local barValue, barMax = 0, 1

	if Ns.Band(EB, BNet) then returnText = tostring(bnetOnline); barValue = bnetOnline; barMax = bnetTotal end
	if Ns.Band(EB, Realm) then returnText = tostring(realmOnline); barValue = realmOnline; barMax = numFriends end
	if Ns.Band(EB, Both) then returnText = bnetOnline .. "/" .. realmOnline; barValue = bnetOnline + realmOnline; barMax = bnetTotal + numFriends end

	HUD:UpdateBar(data, barValue, barMax)
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Travel Distance
local travelData = { total = 0, lastX = nil, lastY = nil, lastMap = nil, lastTime = nil, svLoaded = false }

local function GetTravelSV()
	if not SinStatsDB.travelDistance then SinStatsDB.travelDistance = {} end
	return SinStatsDB.travelDistance
end

local function SaveTravelSV()
	local sv = GetTravelSV()
	sv[Ns.ProfileKey] = travelData.total
end

function Ns.OnResetTravel(self, key, settings)
	travelData.total = 0
	travelData.lastX = nil
	SaveTravelSV()
end

function Ns.FunctionList.Travel(HUD, data, options, ...)

	-- if options.Reset_Counter then
	-- 	options.Reset_Counter = false
	-- 	travelData.total = 0
	-- 	travelData.lastX = nil
	-- 	SaveTravelSV()
	-- end

	if not travelData.svLoaded then
		travelData.svLoaded = true
		local sv = GetTravelSV()
		if options.Reset_Login then
			sv[Ns.ProfileKey] = 0
		else
			travelData.total = sv[Ns.ProfileKey] or 0
		end
	end

	local inInstance = IsInInstance()
	if inInstance then
		HUD:UpdateText(data, "--")
		return
	end

	local mapID = C_Map.GetBestMapForUnit("player")
	if not mapID then
		travelData.lastX = nil
		HUD:UpdateText(data, "--")
		return
	end

	local pos = C_Map.GetPlayerMapPosition(mapID, "player")
	if not pos then
		travelData.lastX = nil
		HUD:UpdateText(data, "--")
		return
	end

	local x, y = pos:GetXY()
	local now = GetTime()
	local speed = GetUnitSpeed("player")
	local speedSecret = Ns.issecretvalue(speed)

	if travelData.lastX and travelData.lastMap == mapID then
		local dx = x - travelData.lastX
		local dy = y - travelData.lastY
		local dt = now - travelData.lastTime

		if not speedSecret and speed > 0 and (dx ~= 0 or dy ~= 0) and dt > 0 and dt < 5 then
			travelData.total = travelData.total + (speed * dt)
			SaveTravelSV()
		end
	end

	travelData.lastX = x
	travelData.lastY = y
	travelData.lastMap = mapID
	travelData.lastTime = now

	local distance = travelData.total
	local EB = options.Yards_KM
	local returnText
	local yards = string.format("%.0f", distance)
	local km = string.format("%.2f", distance / 1093.613)

	if Ns.Band(EB, Yards) then returnText = yards .. " yd" end
	if Ns.Band(EB, Kilometers) then returnText = km .. " km" end
	if Ns.Band(EB, Both) then returnText = yards .. " yd/" .. km .. " km" end
	if returnText == nil then returnText = yards .. " yd" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Jump Counter
local jumpData = { count = 0, svLoaded = false, hooked = false }

local function GetJumpSV()
	if not SinStatsDB.jumpCount then SinStatsDB.jumpCount = {} end
	return SinStatsDB.jumpCount
end

local function SaveJumpSV()
	local sv = GetJumpSV()
	sv[Ns.ProfileKey] = jumpData.count
end

function Ns.OnResetJump(self, key, settings)
	jumpData.count = 0
	SaveJumpSV()
end

function Ns.FunctionList.Jump(HUD, data, options, ...)
	if not jumpData.hooked then
		jumpData.hooked = true
		hooksecurefunc("JumpOrAscendStart", function()
			jumpData.count = jumpData.count + 1
			SaveJumpSV()
		end)
	end
	if not jumpData.svLoaded then
		jumpData.svLoaded = true
		local sv = GetJumpSV()
		if options.Reset_Login then
			sv[Ns.ProfileKey] = 0
		else
			jumpData.count = sv[Ns.ProfileKey] or 0
		end
	end
	HUD:UpdateText(data, jumpData.count)
end
------------------------------------------------

-- local enemiesSlainData = { count = 0, svLoaded = false, playerGUID = nil }

-- local function GetEnemiesSlainSV()
-- 	if not SinStatsDB.enemiesSlain then SinStatsDB.enemiesSlain = {} end
-- 	return SinStatsDB.enemiesSlain
-- end

-- local function SaveEnemiesSlainSV()
-- 	GetEnemiesSlainSV()[Ns.ProfileKey] = enemiesSlainData.count
-- end

-- function Ns.OnResetEnemiesSlain(self, key, settings)
-- 	enemiesSlainData.count = 0
-- 	SaveEnemiesSlainSV()
-- end

-- function Ns.FunctionList.EnemiesSlain(HUD, data, options, event, attackerGUID)
-- 	if not enemiesSlainData.svLoaded then
-- 		enemiesSlainData.svLoaded = true
-- 		local sv = GetEnemiesSlainSV()
-- 		if options.Reset_Login then
-- 			sv[Ns.ProfileKey] = 0
-- 			enemiesSlainData.count = 0
-- 		else
-- 			enemiesSlainData.count = sv[Ns.ProfileKey] or 0
-- 		end
-- 	end
-- 	if event.EnemiesSlain == "PARTY_KILL" and attackerGUID then
-- 		if not enemiesSlainData.playerGUID then
-- 			enemiesSlainData.playerGUID = UnitGUID("player")
-- 		end
-- 		local mode = options.Player_Party or 1   -- 1=Player, 2=Party, 3=Both
-- 		local isPlayer = (attackerGUID == enemiesSlainData.playerGUID)
-- 		local count = (mode == 3) or (mode == 1 and isPlayer) or (mode == 2 and not isPlayer)
-- 		if count then
-- 			enemiesSlainData.count = enemiesSlainData.count + 1
-- 			SaveEnemiesSlainSV()
-- 		end
-- 	end
-- 	HUD:UpdateText(data, enemiesSlainData.count)
-- end
------------------------------------------------

-- Combat Timer
local combatTimer = { startTime = 0, inCombat = false, lastDisplay = "0:00" }

local combatTimerFrame = CreateFrame("Frame")
combatTimerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
combatTimerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
combatTimerFrame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_DISABLED" then
		combatTimer.startTime = GetTime()
		combatTimer.inCombat = true
	elseif event == "PLAYER_REGEN_ENABLED" then
		combatTimer.inCombat = false
	end
end)

function Ns.FunctionList.CombatTimer(HUD, data, options, ...)
	if combatTimer.inCombat then
		local elapsed = GetTime() - combatTimer.startTime
		combatTimer.lastDisplay = Ns.FormatTimerDisplay(elapsed, options.Timer_Format)
	end
	local display = combatTimer.lastDisplay
	if options.Combat_Color and combatTimer.inCombat then
		display = Ns.Colors.Red .. display
	end
	HUD:UpdateText(data, display)
end
------------------------------------------------

-- Instance Timer
function Ns.FunctionList.InstanceTimer(HUD, data, options, ...)
	Ns.InitInstanceTimer()
	local d = Ns.InstanceTimerData
	local fmt = options.Timer_Format

	if d.running then
		local elapsed = GetTime() - d.startTime
		d.lastDisplay = Ns.FormatTimerDisplay(elapsed, fmt)
	elseif d.completed and d.finalTime then
		d.lastDisplay = Ns.FormatTimerDisplay(d.finalTime, fmt)
	end

	local display = d.lastDisplay
	if d.running then
		display = Ns.Colors.Green .. display
	elseif d.completed then
		display = "|cff71FFC9" .. display
	end

	if d.completed and not d.sentToChat and options.Send_Chat then
		d.sentToChat = true
		local timeStr = Ns.FormatTimerDisplay(d.finalTime or 0, fmt)
		pcall(SendChatMessage, string.format("[SinStats] Instance completed: %s", timeStr), "INSTANCE_CHAT")
	end

	HUD:UpdateText(data, display)
end
------------------------------------------------

-- Spec
function Ns.FunctionList.Spec(HUD, data, options, ...)

	local EB = options.Spec_Hero
	local spec, hero = "", ""
	local rt

    -- Spec Name
    local specIndex = GetSpecialization()
    local specID
    if specIndex then
        specID, spec = GetSpecializationInfo(specIndex)
    end

    -- Hero Talent Name
    local configID = C_ClassTalents.GetActiveConfigID()
    local subTreeID = C_ClassTalents.GetActiveHeroTalentSpec()
    if configID and subTreeID then
        local info = C_Traits.GetSubTreeInfo(configID, subTreeID)
        if info and info.name then
            hero = info.name
        end
    end

    if options.Abbrev then
        local english = (GetLocale():sub(1, 2) == "en")
        spec = (english and Ns.SpecAbbrevs[specID]) or Ns.AbbreviateName(spec)
        hero = Ns.HeroAbbrevs[subTreeID] or Ns.AbbreviateName(hero)
    end

    if Ns.Band(EB, Spec) then rt = spec end
	if Ns.Band(EB, Hero) then rt = hero end
	if Ns.Band(EB, Both) then rt = spec .. "/" .. hero end

	HUD:UpdateText(data, rt)
end
------------------------------------------------

-- Talent loadout
function Ns.FunctionList.Loadout(HUD, data, options, ...)

	local display = ""
	local specID = PlayerUtil.GetCurrentSpecID()
	local configID = specID and C_ClassTalents.GetLastSelectedSavedConfigID(specID)

	if configID then
		local configInfo = C_Traits.GetConfigInfo(configID)
		if configInfo and configInfo.name then
			display = configInfo.name
		end
	end

	HUD:UpdateText(data, display)
end
------------------------------------------------

-- Mob Counter
-- local mobCounter = { count = 0 }
-- local mobUnits = {}

-- local mobCounterFrame = CreateFrame("Frame")
-- mobCounterFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
-- mobCounterFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
-- mobCounterFrame:SetScript("OnEvent", function(self, event, unit)
-- 	if event == "NAME_PLATE_UNIT_ADDED" then
-- 		if UnitCanAttack("player", unit) and not UnitIsFriend("player", unit) and not UnitIsPlayer(unit) then
-- 			mobUnits[unit] = true
-- 			mobCounter.count = mobCounter.count + 1
-- 		end
-- 	elseif event == "NAME_PLATE_UNIT_REMOVED" then
-- 		if mobUnits[unit] then
-- 			mobUnits[unit] = nil
-- 			mobCounter.count = math.max(0, mobCounter.count - 1)
-- 		end
-- 	end
-- end)

-- function Ns.FunctionList.MobCounter(HUD, data, options, ...)
-- 	local maxRange = options.Editbox_MobRange
-- 	if maxRange and maxRange > 0 then
-- 		local count = 0
-- 		for unit in pairs(mobUnits) do
-- 			if UnitExists(unit) and CheckInteractDistance(unit, 1) ~= nil then
-- 				local inRange = true
-- 				if maxRange <= 10 then
-- 					inRange = CheckInteractDistance(unit, 3) or false
-- 				elseif maxRange <= 28 then
-- 					inRange = CheckInteractDistance(unit, 2) or false
-- 				end
-- 				if inRange then count = count + 1 end
-- 			end
-- 		end
-- 		HUD:UpdateText(data, count)
-- 	else
-- 		HUD:UpdateText(data, mobCounter.count)
-- 	end
-- end
------------------------------------------------

-- Kill Counter
-- local killData = { npc = 0, pvp = 0, svLoaded = false, registered = false }
-- local killTracked = {}
-- local killFrame

-- local function GetKillSV()
-- 	if not SinStatsDB.killCount then SinStatsDB.killCount = {} end
-- 	return SinStatsDB.killCount
-- end

-- local function SaveKillSV()
-- 	local sv = GetKillSV()
-- 	sv[Ns.ProfileKey] = { npc = killData.npc, pvp = killData.pvp }
-- end

-- function Ns.OnResetKill(self, key, settings)
-- 	killData.npc = 0
-- 	killData.pvp = 0
-- 	SaveKillSV()
-- end

-- function Ns.FunctionList.KillCounter(HUD, data, options, ...)
-- 	if not killData.registered then
-- 		killData.registered = true
-- 		killFrame = CreateFrame("Frame")
-- 		killFrame:SetScript("OnEvent", function(self, event, unit)
-- 			if event == "NAME_PLATE_UNIT_ADDED" then
-- 				if UnitCanAttack("player", unit) and not UnitIsFriend("player", unit) then
-- 					killTracked[unit] = UnitIsPlayer(unit) and "pvp" or "npc"
-- 				end
-- 			elseif event == "NAME_PLATE_UNIT_REMOVED" then
-- 				local kind = killTracked[unit]
-- 				if kind and UnitIsDead(unit) then
-- 					killData[kind] = killData[kind] + 1
-- 					SaveKillSV()
-- 				end
-- 				killTracked[unit] = nil
-- 			end
-- 		end)
-- 		killFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
-- 		killFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
-- 	end
-- 	if not killData.svLoaded then
-- 		killData.svLoaded = true
-- 		local sv = GetKillSV()
-- 		if options.Reset_Login then
-- 			sv[Ns.ProfileKey] = { npc = 0, pvp = 0 }
-- 		else
-- 			local saved = sv[Ns.ProfileKey]
-- 			if saved then
-- 				killData.npc = saved.npc or 0
-- 				killData.pvp = saved.pvp or 0
-- 			end
-- 		end
-- 	end
-- 	local EB = options.NPC_Players
-- 	local returnText
-- 	if Ns.Band(EB, NPC) then returnText = killData.npc end
-- 	if Ns.Band(EB, Players) then returnText = killData.pvp end
-- 	if Ns.Band(EB, Both) then returnText = killData.npc + killData.pvp end
-- 	HUD:UpdateText(data, returnText or 0)
-- end
------------------------------------------------
