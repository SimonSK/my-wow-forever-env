local AddName, Ns = ...
local L = Ns.L

----------------------------
-- Local Helper Functions --
----------------------------
function Ns.ShortNumbers(num, places)
    local ret
    local placeValue = ("%%.%df"):format(places or 0)
    if not num then return 0
	elseif num < 1000 then return num
    elseif num < 1000000 then ret = placeValue:format(num / 1000) .. "k"
	elseif num >= 1000000 then ret = placeValue:format(num / 1000000) .. "M"
	else ret = num
    end
    return ret
end

function Ns.DecimalFormat(val, suffix)
	local s = suffix or ""
	if val == 0 then return "%.0f" .. s
	elseif val == 1 then return "%.1f" .. s
	elseif val == 2 then return "%.2f" .. s
	else return "%.3f" .. s end
end

-- secret value check
Ns.issecretvalue = issecretvalue or function() return false end
Ns.Safe = function(v) return Ns.issecretvalue(v) and 0 or v end

local function GetPlayerBuffData(index)
	return C_UnitAuras.GetBuffDataByIndex("player", index, "HELPFUL")
end

local function ArePlayerBuffsReadable()
	for i = 1, 40 do
		local aura = GetPlayerBuffData(i)
		if not aura then return true end
		if Ns.issecretvalue(aura.spellId) then return false end
	end
	return true
end

local function GetTalentPoints(tabIndex, talentIndex)
	if not GetTalentInfo then return 0 end

	local ok, name, _, _, _, points = pcall(GetTalentInfo, tabIndex, talentIndex)
	if not ok or type(name) ~= "string" or Ns.issecretvalue(points) then return 0 end
	return tonumber(points) or 0
end

local function GetMainHandEnchantID()
	local enchantInfo = C_PaperDollInfo.GetTemporaryEnchantmentInfo(INVSLOT_MAINHAND)
	return enchantInfo and enchantInfo.enchantID
end

function Ns.GetSpeedGlideColor(speed)
	local ratio = speed / 930
	if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
	local r, g, b
	if ratio < 0.5 then
		local t = ratio * 2
		r = 196 + (255 - 196) * t
		g = 30 + (255 - 30) * t
		b = 58 - 58 * t
	else
		local t = (ratio - 0.5) * 2
		r = 255 + (113 - 255) * t
		g = 255
		b = 201 * t
	end
	return ("|cff%02x%02x%02x"):format(r, g, b)
end

local kAbbrevOpts = {
	[0] = { breakpointData = {
		{ breakpoint = 1e6, significandDivisor = 1e6,  fractionDivisor = 1,   abbreviation = "M", abbreviationIsGlobal = false },
		{ breakpoint = 1e3, significandDivisor = 1e3,  fractionDivisor = 1,   abbreviation = "k", abbreviationIsGlobal = false },
		{ breakpoint = 1,   significandDivisor = 1,    fractionDivisor = 1,   abbreviation = "",  abbreviationIsGlobal = false },
	}},
	[1] = { breakpointData = {
		{ breakpoint = 1e6, significandDivisor = 1e5,  fractionDivisor = 10,  abbreviation = "M", abbreviationIsGlobal = false },
		{ breakpoint = 1e3, significandDivisor = 1e2,  fractionDivisor = 10,  abbreviation = "k", abbreviationIsGlobal = false },
		{ breakpoint = 1,   significandDivisor = 0.1,  fractionDivisor = 10,  abbreviation = "",  abbreviationIsGlobal = false },
	}},
	[2] = { breakpointData = {
		{ breakpoint = 1e6, significandDivisor = 1e4,  fractionDivisor = 100, abbreviation = "M", abbreviationIsGlobal = false },
		{ breakpoint = 1e3, significandDivisor = 10,   fractionDivisor = 100, abbreviation = "k", abbreviationIsGlobal = false },
		{ breakpoint = 1,   significandDivisor = 0.01, fractionDivisor = 100, abbreviation = "",  abbreviationIsGlobal = false },
	}},
}

function Ns.DecimalNumber(val, num)
	if val == 0 then
		if Ns.issecretvalue(num) then return ("%.0f"):format(num) end
		return BreakUpLargeNumbers(num)
	end

	local places = (tonumber(val) or 3) - 1  -- val 1=0dec, 2=1dec, 3=2dec
	if Ns.issecretvalue(num) then return AbbreviateNumbers(num, kAbbrevOpts[places]) end
	return Ns.ShortNumbers(num, places)
end

-- gradient text color: red (low) to green (max)
function Ns.GradientRedGreen(value, max)
	if not value or not max or max == 0 then return "" end
	local ratio = value / max
	if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
	return Ns:GradientColorCode(ratio)
end

-- gradient text color: green (low) to red (max)
function Ns.GradientGreenRed(value, max)
	if not value or not max or max == 0 then return "" end
	local ratio = value / max
	if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
	return Ns:GradientColorCode(1 - ratio)
end

function Ns.shapeshitCheck()
	if (Ns.classFilename == "DRUID") then
		local index = GetShapeshiftForm()
		if (index == 1) or (index == 3) then
			return true
		else
			return false
		end
	end
end

-- Stats computing
function Ns.StatsCompute()

	local currentSpirit = UnitStat("player", 5)
	if Ns.issecretvalue(currentSpirit) or not ArePlayerBuffsReadable() then
		return
	end
	Ns.spirit = currentSpirit

	-- Init

	local base = 0

	local mp5 = 0
	local tierPieces = 0
	local zgPieces = 0
	local pouchCounter = 0
	local atkspeed = 0
	local scourgeMp5 = 0

	local effectiveMR = 0
	local talentRegen = 0
	local totemTalent = 0

	local magearmor = 0
	local evoc = 0
	local felEnergy = 0
	local siphonregen = 0
	local siphoncast = 0
	local innerregen = 0
	local innercast = 0
	local bowisdom = 0
	local wismp5 = 0
	local springtotem = 0
	local tidetotem = 0
	local swregen = 0
	local fishsoup = 0
	local fishsoupmp5 = 0
	local sageFish = 0
	local warchief = 0
	local mageblood = 0
	local meleeHaste = 0
	local rangedHaste = 0
	local epiphany = 0
	local drinkRegen = 0
	local totemicPower = 0
	local tierBonusShield = 0
	Ns.arcanePower, Ns.sancAura, Ns.combustionCount, Ns.shadowFormDmg, Ns.dmfbuff, Ns.silithyst, Ns.vengeance = 0, 0, 0, 0, 0, 0, 0
	Ns.totalMP5, Ns.totalMP2, Ns.castingMP2, Ns.totalHaste, Ns.totalRangedHaste, Ns.buffCount = 0, 0, 0, 0, 0, 0
	Ns.castHaste = 0

	for i = 1, 40 do
		local aura = GetPlayerBuffData(i)
		if not aura then break end
		local spellId = aura.spellId
		local count = aura.applications
		if not spellId then break end

		if spellId then
			Ns.buffCount = i
		end

		Ns.buffCount = Ns.buffCount


	local hasteHead = 0
	local hasteLegs = 0
	local hasteHands = 0
	local oilEnchants = 0
	local oilRegen = 0
	local zgMP5 = 0

	Ns.totalMP51 = 0
	Ns.totalMP2 = 0
	Ns.castingMP2 = 0
	Ns.totalMP5 = 0
	Ns.castingMP5 = 0
	Ns.totalHaste = 0
	Ns.totalRangedHaste = 0

end
end

--------------------------------------
--		Global OnEvent function		--
--------------------------------------
function Ns.OnEventFunc(event, ...)

	local spirit = UnitStat("player", 5)
	if not Ns.issecretvalue(spirit) then
		Ns.spirit = spirit
	end

	if event == "CHARACTER_POINTS_CHANGED" then
	-----	
		if Ns.talentScan then Ns.talentScan() end
		Ns.StatsCompute()
	-----	
	elseif event == "PLAYER_LEVEL_UP" then
	-----	
		Ns.playerLevel = UnitLevel("player")
	-----	
	elseif event == "PLAYER_TARGET_CHANGED" then
		local exists = UnitExists("target")
		local hostile = UnitCanAttack("player", "target")

		if hostile or not exists then
			if Ns.SinLive then Ns.SinLive() end
		end
	-----	
	else
	-----

	-- SinLive
	local unit = ...
	if unit == "target" then
		if Ns.SinLive then Ns.SinLive() end
	return
	end
	Ns.StatsCompute()

end -- end events
end -- end function

--------------------------------------
--		Timer Format Utility		--
--------------------------------------
function Ns.FormatTimerDisplay(seconds, fmt)
	local hours = floor(seconds / 3600)
	local minutes = floor((seconds % 3600) / 60)
	local secs = floor(seconds % 60)
	fmt = tonumber(fmt) or 1
	if fmt == 2 then
		if hours > 0 then return string.format("%02d:%02d:%02d", hours, minutes, secs)
		else return string.format("%02d:%02d", minutes, secs) end
	elseif fmt == 3 then
		if hours > 0 then return string.format("%dh %dm %02ds", hours, minutes, secs)
		else return string.format("%dm %02ds", minutes, secs) end
	elseif fmt == 4 then
		if hours > 0 then return string.format("%dh%02dm%02ds", hours, minutes, secs)
		else return string.format("%dm%02ds", minutes, secs) end
	end
	if hours > 0 then return string.format("%d:%02d:%02d", hours, minutes, secs)
	else return string.format("%d:%02d", minutes, secs) end
end

--------------------------------------
--		Instance Timer				--
--------------------------------------
Ns.InstanceTimerData = { startTime = 0, running = false, completed = false, lastDisplay = "0:00", finalTime = nil, sentToChat = false, initialized = false }

function Ns.InitInstanceTimer()
	if Ns.InstanceTimerData.initialized then return end
	Ns.InstanceTimerData.initialized = true
	local d = Ns.InstanceTimerData
	local f = CreateFrame("Frame")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_ENTERING_WORLD" then
			local inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == "party" or instanceType == "raid") then
				if not d.running then
					d.startTime = GetTime()
					d.running = true
					d.completed = false
					d.sentToChat = false
					d.finalTime = nil
				end
			else
				if d.running and not d.completed then
					d.running = false
					d.completed = true
					d.finalTime = GetTime() - d.startTime
				end
			end
		end
	end)
end