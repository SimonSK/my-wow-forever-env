local AddName, Ns = ...
local L = Ns.L
local issecretvalue = Ns.issecretvalue
local Safe = Ns.Safe
local GetSpeedGlideColor = Ns.GetSpeedGlideColor

---------------------
-- Options Equates --
---------------------
local World, Realm, Both, Overall, Equipped, Heroism, Valor, Total, Equipped, Bags, Honor, Kills, Percentage, Rating, Yards, Kilometers, NPC, Players = 1, 2, 3, 2, 2, 1, 2, 1, 2, 3, 1, 2, 1, 2, 1, 2, 1, 2
local Live, Static = 1, 2
local Auto, SteadyFlying, Skyriding, OnFoot, Custom, Mounted = 1, 2, 3, 4, 5, 6
local Speed_Percent, Speed_Yards, Speed_Km = 1, 2, 3
local repairTooltip = CreateFrame("GameTooltip", "SinStatsTooltipClassic", nil, "GameTooltipTemplate")
repairTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

local cachedFullSpeed = 0
local cachedStaticSpeed = 0
local cachedRawFullSpeed = 0
local cachedRawStaticSpeed = 0

-- Money
function Ns.FunctionList.Money(HUD, data, options, ...)

	local money = GetMoney()
	local formattedMoney = (C_CurrencyInfo.GetCoinTextureString(money))

	HUD:UpdateText(data, formattedMoney)
end
------------------------------------------------

-- Honor
function Ns.FunctionList.Honor(HUD, data, options, ...)

	local EB = options.Honor_Kills
	local hk, hp = GetPVPSessionStats()
	local returnText

	if Ns.Band(EB, Honor) then returnText = hp end
	if Ns.Band(EB, Kills) then returnText = hk end
	if Ns.Band(EB, Both) then returnText = hp .. "/" .. hk end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Speed
function Ns.FunctionList.Speed(HUD, data, options, ...)

	local EB = options.Speed_Static
	local speedColor, staticColor, endColor = "", "", ""
	local vehicleSpeed = GetUnitSpeed("vehicle")
	local vehicleSpeedSafe = issecretvalue(vehicleSpeed) and 0 or vehicleSpeed
	local fsRaw, rsRaw, fltRaw, swRaw = GetUnitSpeed("player")
	local speedSecret = issecretvalue(fsRaw)
	local fullSpeed  = speedSecret and 0 or fsRaw
	local runSpeed   = speedSecret and 0 or rsRaw
	local flightSpeed = speedSecret and 0 or fltRaw
	local swimSpeed  = speedSecret and 0 or swRaw
	local isGliding, canGlide, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
	local staticSpeed
	local returnText, decimals, statusbar

	if IsFlying() then staticSpeed = flightSpeed
	elseif IsSwimming() then staticSpeed = swimSpeed
	elseif vehicleSpeedSafe > 0 then staticSpeed = vehicleSpeedSafe
	elseif UnitOnTaxi("player") then staticSpeed = fullSpeed
	else staticSpeed = runSpeed end

	if fullSpeed == 0 and vehicleSpeedSafe > 0 then fullSpeed = vehicleSpeedSafe end

	local rawFullSpeed = fullSpeed
	local rawStaticSpeed = staticSpeed

	fullSpeed = fullSpeed / 0.07
	staticSpeed = staticSpeed / 0.07

	if canGlide then
		local baseRaw = isGliding and forwardSpeed or fsRaw
		if not issecretvalue(baseRaw) then
			local movespeed = Round(baseRaw / BASE_MOVEMENT_SPEED * 100)
			fullSpeed = movespeed
			staticSpeed = movespeed
		end
	end

	if speedSecret then
		fullSpeed = cachedFullSpeed
		staticSpeed = cachedStaticSpeed
		rawFullSpeed = cachedRawFullSpeed
		rawStaticSpeed = cachedRawStaticSpeed
	else
		cachedFullSpeed = fullSpeed
		cachedStaticSpeed = staticSpeed
		cachedRawFullSpeed = rawFullSpeed
		cachedRawStaticSpeed = rawStaticSpeed
	end

	if options.Speed_Color then
		if isGliding then
			speedColor = GetSpeedGlideColor(fullSpeed)
			staticColor = GetSpeedGlideColor(staticSpeed)
		else
			local baseSpeed = 100
			if IsFlying() then baseSpeed = canGlide and 929 or 530
			elseif IsMounted() then baseSpeed = 200
			elseif IsSwimming() then baseSpeed = 67
			end

			if fullSpeed > baseSpeed + 0.5 then speedColor = Ns.greenText
			elseif fullSpeed > 0 and fullSpeed < baseSpeed - 0.5 then speedColor = Ns.redText
			end

			if staticSpeed > baseSpeed + 0.5 then staticColor = Ns.greenText
			elseif staticSpeed > 0 and staticSpeed < baseSpeed - 0.5 then staticColor = Ns.redText
			end
		end
	end

	if speedColor ~= "" then endColor = "|r" end

	local speedMode = options.Speed_Mode or Speed_Percent
	local displayFull, displayStatic, suffix

	if speedSecret and options.Speed_Secret then
		displayFull = fsRaw
		displayStatic = fsRaw
		suffix = options.Speed_Unit and " yd/s" or ""
		decimals = Ns.DecimalFormat(options.Decimals_Default)
	elseif speedMode == Speed_Yards then
		displayFull = speedSecret and fsRaw or rawFullSpeed
		displayStatic = speedSecret and fsRaw or rawStaticSpeed
		suffix = options.Speed_Unit and " yd/s" or ""
		decimals = Ns.DecimalFormat(options.Decimals_Default)
	elseif speedMode == Speed_Km then
		displayFull = rawFullSpeed * 23.04
		displayStatic = rawStaticSpeed * 23.04
		suffix = options.Speed_Unit and " km/h" or ""
		decimals = Ns.DecimalFormat(options.Decimals_Default)
	else -- Speed_Percent (default)
		displayFull = fullSpeed
		displayStatic = staticSpeed
		suffix = ""
		decimals = Ns.DecimalFormat(options.Decimals_Default, "%%")
	end

	local mode = options.SpeedBar or Auto
	local barMax = 107
	if mode == SteadyFlying then barMax = 530
	elseif mode == Skyriding then barMax = 1220
	elseif mode == OnFoot then barMax = 110
	elseif mode == Mounted then barMax = 220
	elseif mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	elseif mode == Auto then
		barMax = 107
		if IsMounted() then barMax = 220 end
		if IsFlying() then
			barMax = 530
			if canGlide then barMax = 1220 end
		end
	end

	if Ns.Band(EB, Live) then
		returnText = speedColor .. (decimals):format(displayFull) .. suffix
		statusbar = fullSpeed
	end
	if Ns.Band(EB, Static) then
		returnText = staticColor .. (decimals):format(displayStatic) .. suffix
		statusbar = staticSpeed
	end
	if Ns.Band(EB, Both) then
		returnText = speedColor .. (decimals):format(displayFull) .. suffix .. endColor .. " (" .. staticColor .. (decimals):format(displayStatic) .. suffix .. ")"
		statusbar = fullSpeed
	end

	if speedSecret and (options.Speed_Secret or speedMode == Speed_Yards) then
		statusbar = fsRaw
		barMax = barMax * 0.07
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar, barMax)
end
------------------------------------------------

-- Target Speed
function Ns.FunctionList.TargetSpeed(HUD, data, options, ...)

	local speedColor = ""
	local rawSpeed = GetUnitSpeed("target")

	if issecretvalue(rawSpeed) then
		local ok, text = pcall(Ns.DecimalNumber, 2, rawSpeed)
		HUD:UpdateText(data, ok and (text .. " y/s") or "0")
		return
	end

	local targetSpeed = rawSpeed / 7 * 100
	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if targetSpeed == 0 or targetSpeed == 100 then speedColor = ""
	elseif targetSpeed < 100 then speedColor = "|cffC41E3A"
	elseif targetSpeed > 100 then speedColor = "|cff71FFC9" end

	HUD:UpdateText(data, speedColor .. (decimals):format(targetSpeed))
end
------------------------------------------------

-- FPS
function Ns.FunctionList.FPS(HUD, data, options, ...)

	local framerate = GetFramerate()
	local fpsColor = ""

	if framerate <= 30 then fpsColor = "|cffC41E3A"
	elseif framerate > 30 and framerate < 50 then fpsColor = "|cffFF7C0A"
	elseif framerate >= 50 then fpsColor = "|cff71FFC9" end

	HUD:UpdateText(data, fpsColor .. floor(framerate))
end
------------------------------------------------

-- Lag
function Ns.FunctionList.Lag(HUD, data, options, ...)

	local EB = options.World_Realm
	local _, _, lagRealm, lagWorld = GetNetStats()
	local lagColor = ""
	local returnText

	if lagWorld <= 90 or lagRealm <= 90 then
		lagColor = "|cff71FFC9"
	elseif (lagWorld >= 90 and lagWorld < 200) or (lagRealm >= 90 and lagRealm < 200) then
		lagColor = "|cffFF7C0A"
	elseif lagWorld >= 200 or lagRealm >= 200 then
		lagColor = "|cffC41E3A"
	end

	if Ns.Band(EB, World) then returnText = lagColor .. floor(lagWorld) end
	if Ns.Band(EB, Realm) then returnText = lagColor .. floor(lagRealm) end
	if Ns.Band(EB, Both) then returnText = lagColor .. floor(lagWorld) .. "/" .. floor(lagRealm) end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Debuffs
function Ns.FunctionList.DebuffCounter(HUD, data, options, ...)

	HUD:UpdateText(data, Ns.debuffCount)
end
------------------------------------------------

-- Buffs
function Ns.FunctionList.BuffCounter(HUD, data, options, ...)

	HUD:UpdateText(data, Ns.buffCount)
	HUD:UpdateBar(data, Ns.buffCount, 32)
end
------------------------------------------------

-- Repair cost
function Ns.FunctionList.RepairCost(HUD, data, options, ...)

	local EB = options.Total_Equipped_Bags
	local totalCost = 0
	local equippedCost = 0
	local bagsCost = 0
	local returnText

	for bagNum = 0,4 do
	local cost = 0
		for bagSlot = 1,C_Container.GetContainerNumSlots(bagNum) do
			local item = C_Container.GetContainerItemLink(bagNum, bagSlot)
			if (item) then
				local dur, max = C_Container.GetContainerItemDurability(bagNum, bagSlot)
				if (dur~=nil) then
					local dif = max - dur
					repairTooltip:ClearLines()
					cost = select(2, repairTooltip:SetBagItem(bagNum, bagSlot)) or 0
					bagsCost = bagsCost + cost
				end
			end
		end
	end

	for slot = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
	if not slot then break end
		repairTooltip:ClearLines()
		local repairCost = select(3, repairTooltip:SetInventoryItem("player", slot)) or 0
		equippedCost = equippedCost + repairCost
	end

	totalCost = equippedCost + bagsCost

	if Ns.Band(EB, Total) then
		returnText = C_CurrencyInfo.GetCoinTextureString(totalCost)
	end
	if  Ns.Band(EB, Equipped) then
		returnText = C_CurrencyInfo.GetCoinTextureString(equippedCost)
	end
	if  Ns.Band(EB, Bags) then
		returnText = C_CurrencyInfo.GetCoinTextureString(bagsCost)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Durability
function Ns.FunctionList.Durability(HUD, data, options, ...)
	local Durability, Current, Full, Percent
	local LowestCurrent, LowestFull, t1, t2, t3 = 500, 0, 0, 0, 100
	local statusbar

	for i=1,19 do
		Current, Full = GetInventoryItemDurability(i)
		if Current and Full then
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

-- Threat
function Ns.FunctionList.Threat(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local _, _, threatpct, _, threatvalue = UnitDetailedThreatSituation("player", "target")
	local returnText, statusbar
	local threatColor = ""

	if threatpct == nil then threatpct = 0 end
	if threatvalue == nil then threatvalue = 0 end

	local safePct = Safe(threatpct)
	if safePct <= 59 then threatColor = Ns.greenText
	elseif safePct >= 60 and safePct < 100 then threatColor = Ns.orangeText
	elseif safePct == 100 then threatColor = Ns.redText end

	local threatText
	if issecretvalue(threatvalue) then
		threatText = ("%.0f"):format(threatvalue)
	else
		threatText = BreakUpLargeNumbers(threatvalue)
	end

	if Ns.Band(EB, Percentage) then returnText = threatColor .. ("%.0f%%"):format(threatpct); statusbar = threatpct end
	if Ns.Band(EB, Rating) then returnText = threatColor .. threatText; statusbar = threatvalue end
	if Ns.Band(EB, Both) then returnText = threatColor .. ("%.0f%%"):format(threatpct) .. " |r(" .. threatText .. ")"; statusbar = threatpct end

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

	local numFriends = C_FriendList.GetNumFriends()
	local numOnline = C_FriendList.GetNumOnlineFriends()
	local returnText = tostring(numOnline)

	HUD:UpdateBar(data, numOnline, numFriends)
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

	if travelData.lastX and travelData.lastMap == mapID then
		local dx = x - travelData.lastX
		local dy = y - travelData.lastY
		local dt = now - travelData.lastTime

		if not issecretvalue(speed) and speed > 0 and (dx ~= 0 or dy ~= 0) and dt > 0 and dt < 5 then
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
	if Ns.Band(EB, Kilometers) then returnText = km ..  " km" end
	if Ns.Band(EB, Both) then returnText = yards .. " yd/" .. km ..  " km" end
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
		if JumpOrAscendStart then
			hooksecurefunc("JumpOrAscendStart", function()
				jumpData.count = jumpData.count + 1
				SaveJumpSV()
			end)
		end
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