local _, Ns = ...

---------------------
-- Options Equates --
---------------------
local World, Equipped, Total, Live, Percentage, BNet, Yards, NPC = 1, 1, 1, 1, 1, 1, 1, 1
local Realm, Static, Rating, Max, Kilometers, Players = 2, 2, 2, 2, 2, 2
local Both, Bags = 3, 3

-- Gold
function Ns.FunctionList.Money(HUD, data, options, ...)

	local money = GetMoney()
	local formattedMoney = (GetCoinTextureString(money))
	local returnText

	returnText = formattedMoney

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Speed
function Ns.FunctionList.Speed(HUD, data, options, ...)

	local fullSpeed = GetUnitSpeed("player") / 7 * 100
	local speedColor = ""
	local returnText
	local statusbar = fullSpeed

	if options.Color_Effect then
		if fullSpeed == 0 or fullSpeed == 100 then
			speedColor = ""
		elseif fullSpeed < 100 then
			speedColor = "|cffC41E3A"
		elseif fullSpeed > 100 then
			speedColor = "|cff00f26d"
		end
	end

	returnText = speedColor .. string.format("%d%%", ("%.0f"):format(fullSpeed))

	HUD:UpdateText(data, returnText)

	local barMax = 100
	if IsMounted() then barMax = 209 end
	if IsSwimming() then barMax = 100 end
	HUD:UpdateBar(data, statusbar, barMax)
end
------------------------------------------------

-- Target Speed
function Ns.FunctionList.TargetSpeed(HUD, data, options, ...)

	local targetSpeed = GetUnitSpeed("target") / 7 * 100
	local speedColor = ""

	if options.Color_Effect then
		if targetSpeed == 0 or targetSpeed == 100 then speedColor = ""
		elseif targetSpeed < 100 then speedColor = "|cffC41E3A"
		elseif targetSpeed > 100 then speedColor = "|cff71FFC9" end
	end

	HUD:UpdateText(data, speedColor .. string.format("%d%%", ("%.0f"):format(targetSpeed)))
end
------------------------------------------------

-- FPS
function Ns.FunctionList.FPS(HUD, data, options, ...)

	local framerate = GetFramerate()
	local fpsColor = ""

	if options.Color_Effect then
		if framerate <= 30 then fpsColor = "|cffC41E3A"
		elseif framerate > 30 and framerate < 50 then fpsColor = "|cffFF7C0A"
		elseif framerate >= 50 then fpsColor = "|cff71FFC9" end
	end

	HUD:UpdateText(data, fpsColor .. floor(framerate))
end
------------------------------------------------

-- Lag
function Ns.FunctionList.Lag(HUD, data, options, ...)

	local _, _, _, lagWorld = GetNetStats()
	local returnText

	if lagWorld <= 90 then
		returnText = "|cff00f26d" .. lagWorld .. " ms|r"
	elseif lagWorld >= 90 and lagWorld < 200 then
		returnText = "|cffFF7C0A" .. lagWorld .. " ms|r"
	elseif lagWorld >= 200 then
		returnText = "|cffC41E3A" .. lagWorld .. " ms|r"
	end

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
	local numFriends, realmOnline = C_FriendList.GetNumFriends()
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

	if travelData.lastX and travelData.lastMap == mapID then
		local dx = x - travelData.lastX
		local dy = y - travelData.lastY
		local dt = now - travelData.lastTime

		if speed > 0 and (dx ~= 0 or dy ~= 0) and dt > 0 and dt < 5 then
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