local _, Ns = ...

----------------------------
-- Local Helper Functions --
----------------------------

-- break number
function Ns.ShortNumbers(num, places)
    local ret
    local placeValue = ("%%.%df"):format(places or 0)
    if not num then return 0
	elseif num < 1000 then return num
    elseif num < 1000000 then ret = placeValue:format(num / 1000) .. "k"
	elseif num >= 1000000 then ret = placeValue:format(num / 1000000) .. "M"
	else ret = num -- hundreds
    end
    return ret
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

-- rounding decimals
function Ns.DecimalFormat(val, suffix)
	local s = suffix or ""
	if val == 0 then return "%.0f" .. s
	elseif val == 1 then return "%.1f" .. s
	elseif val == 2 then return "%.2f" .. s
	else return "%.3f" .. s end
end

-- break number
function Ns.DecimalNumber(val, num)
	if val == 0 then
		if Ns.issecretvalue(num) then return num end  -- BreakUpLargeNumbers is not secret-safe
		return BreakUpLargeNumbers(num)
	end

	local places = val - 1  -- val 1=0dec, 2=1dec, 3=2dec
	if Ns.issecretvalue(num) then return AbbreviateNumbers(num, kAbbrevOpts[places]) end
	return Ns.ShortNumbers(num, places)
end

function Ns.GradientRedGreen(value, max)
	if not value or not max or max == 0 then return "" end
	local ratio = value / max
	if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
	return Ns:GradientColorCode(ratio)
end

function Ns.GradientGreenRed(value, max)
	if not value or not max or max == 0 then return "" end
	local ratio = value / max
	if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
	return Ns:GradientColorCode(1 - ratio)
end

-- secret value check
Ns.issecretvalue = issecretvalue or function() return false end
Ns.Safe = function(v) return Ns.issecretvalue(v) and 0 or v end

------------------------------
--		Name Abbreviation	--
------------------------------

function Ns.FirstChars(s, n)
	local chars = {}
	local i, len = 1, #s
	while i <= len and #chars < n do
		local b = s:byte(i)
		local size = 1
		if b >= 0xF0 then size = 4
		elseif b >= 0xE0 then size = 3
		elseif b >= 0xC0 then size = 2
		end
		chars[#chars+1] = s:sub(i, i + size - 1)
		i = i + size
	end
	return table.concat(chars)
end

function Ns.AbbreviateName(name)
	if not name or name == "" then return "" end
	local words = {}
	for word in name:gmatch("[^%s%-'`]+") do
		tinsert(words, word)
	end
	if #words <= 1 then
		return strupper(Ns.FirstChars(name:gsub("[%s%-'`]", ""), 2))
	end
	local initials = {}
	for _, word in ipairs(words) do
		tinsert(initials, Ns.FirstChars(word, 1))
	end
	return strupper(table.concat(initials))
end

-- dr updaters
function Ns.ReverseDR(ratingBonus)
	if ratingBonus <= 0 then return 0 end
	if ratingBonus <= 30 then return ratingBonus end
	if ratingBonus <= 39 then return 30 + (ratingBonus - 30) / 0.9 end
	if ratingBonus <= 47 then return 30 + 9 / 0.9 + (ratingBonus - 39) / 0.8 end
	if ratingBonus <= 54 then return 30 + 9 / 0.9 + 8 / 0.8 + (ratingBonus - 47) / 0.7 end
	if ratingBonus <= 66 then return 30 + 9 / 0.9 + 8 / 0.8 + 7 / 0.7 + (ratingBonus - 54) / 0.6 end
	return 30 + 9 / 0.9 + 8 / 0.8 + 7 / 0.7 + 12 / 0.6 + (ratingBonus - 66) / 0.5
end

function Ns.GetDRColor(ratingBonus)
	if ratingBonus <= 30 then return "|cff71ffc9" end
	if ratingBonus <= 39 then return "|cff66ff00" end   --  90%: green-yellow
	if ratingBonus <= 47 then return "|cffffff00" end   --  80%: yellow
	if ratingBonus <= 54 then return "|cffff8800" end   --  70%: orange
	if ratingBonus <= 66 then return "|cffff4400" end   --  60%: red-orange
	return "|cffff0000"                                  --  50%: red
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

-- StatsCompute is currently a no-op (aura scanning disabled)
function Ns.StatsCompute()

	-- Init
	-- Ns.combustion, Ns.serenity, Ns.overflowEnergy, Ns.luckOfDraw = 0, 0, 0, 0
	-- Ns.hitCombo, Ns.shadowForm, Ns.loneWolf, Ns.runePower = 0, 0, 0, 0
	-- Ns.incanterFlow, Ns.demonSoul, Ns.tigersFury, Ns.momentum = 0, 0, 0, 0
	-- Ns.touchOfIce, Ns.demonicSynergy, Ns.seethChaos, Ns.equilibrium = 0, 0, 0, 0
	-- Ns.iridescence, Ns.arcaneSurge, Ns.enlightened, Ns.symbolsDeath = 0, 0, 0, 0
	-- Ns.ebonMight, Ns.avatar, Ns.battleShout, Ns.defStance, Ns.feralSpirit = 0, 0, 0, 0, 0
	-- Ns.bestialWrath, Ns.friendFae, Ns.retAura, Ns.inertia = 0, 0, 0, 0
	-- Ns.avWrath, Ns.delver, Ns.impetus, Ns.enrage = 0, 0, 0, false

	-- for i = 1, 40 do
	-- 	local aura = C_UnitAuras.GetAuraDataByIndex("player",i, "HELPFUL")

	-- 	if not aura then break end

		-- if Ns.Combustion[aura.spellId] then Ns.combustion = Ns.Combustion[aura.spellId][1] end
		-- if Ns.Serenity[aura.spellId] then Ns.serenity = Ns.Serenity[aura.spellId][1] end
		-- if Ns.Overflowing[aura.spellId] then Ns.overflowEnergy = aura.applications * 2 end
		-- if Ns.LuckOfTheDraw[aura.spellId] then Ns.luckOfDraw = ((aura.applications * 5) / 100 ) end
		-- if Ns.HitCombo[aura.spellId] then Ns.hitCombo = aura.applications end
		-- if Ns.Shadowform[aura.spellId] then Ns.shadowForm = Ns.Shadowform[aura.spellId][1] end
		-- if Ns.LoneWolf[aura.spellId] then Ns.loneWolf = Ns.LoneWolf[aura.spellId][1] end
		-- if Ns.RuneOfPower[aura.spellId] then Ns.runePower = Ns.RuneOfPower[aura.spellId][1] end
		-- if Ns.DemonSoul[aura.spellId] then Ns.demonSoul = Ns.DemonSoul[aura.spellId][1] end
		-- if Ns.TigersFury[aura.spellId] then Ns.tigersFury = Ns.TigersFury[aura.spellId][1] end
		-- if Ns.Momentum[aura.spellId] then Ns.momentum = Ns.Momentum[aura.spellId][1] end
		-- if Ns.TouchOfIce[aura.spellId] then Ns.touchOfIce = Ns.TouchOfIce[aura.spellId][1] end
		-- if Ns.SeethChaos[aura.spellId] then Ns.seethChaos = Ns.SeethChaos[aura.spellId][1] end
		-- if Ns.DemonicSynergy[aura.spellId] then Ns.demonicSynergy = Ns.DemonicSynergy[aura.spellId][1] end
		-- if Ns.IncanterFlow[aura.spellId] then Ns.incanterFlow = aura.applications * 4 end
		-- if Ns.ElementalEquilibrium[aura.spellId] then Ns.equilibrium = Ns.Equilibrium end
		-- if Ns.Iridescence[aura.spellId] then Ns.iridescence = Ns.Iridescence[aura.spellId][1] end
		-- if Ns.ArcaneSurge[aura.spellId] then Ns.arcaneSurge = Ns.ArcaneSurge[aura.spellId][1] end
		-- if Ns.Enlightened[aura.spellId] then Ns.enlightened = Ns.Enlightened[aura.spellId][1] end
		-- if Ns.Enrage[aura.spellId] then Ns.enrage = true end
		-- if Ns.SymbolsDeath[aura.spellId] then Ns.symbolsDeath = Ns.SymbolsDeath[aura.spellId][1] end
		-- if Ns.EbonMight[aura.spellId] then Ns.ebonMight = Ns.EbonMight[aura.spellId][1] end
		-- if Ns.Avatar[aura.spellId] then Ns.avatar = Ns.Avatar[aura.spellId][1] end
		-- if Ns.BattleShout[aura.spellId] then Ns.battleShout = Ns.BattleShout[aura.spellId][1] end
		-- if Ns.DefStance[aura.spellId] then Ns.defStance = Ns.DefStance[aura.spellId][1] end
		-- if Ns.FeralSpirit[aura.spellId] then Ns.feralSpirit = Ns.FeralSpirit[aura.spellId][1] end
		-- if Ns.BestialWrath[aura.spellId] then Ns.bestialWrath = Ns.BestialWrath[aura.spellId][1] end
		-- if Ns.FriendFae[aura.spellId] then Ns.friendFae = Ns.FriendFae[aura.spellId][1] end
		-- if Ns.AvengeWrath[aura.spellId] then Ns.avWrath = Ns.AvengeWrath[aura.spellId][1] end
		-- if Ns.RetAura[aura.spellId] then Ns.retAura = Ns.RetAura[aura.spellId][1] end
		-- if Ns.Inertia[aura.spellId] then Ns.inertia = Ns.Inertia[aura.spellId][1] end
		-- if Ns.Delver[aura.spellId] then Ns.delver = Ns.Delver[aura.spellId][1] end
		-- if Ns.Impetus[aura.spellId] then Ns.impetus = Ns.Impetus[aura.spellId][1] end

-- 	end
end

--------------------------------------
--		Global OnEvent function		--
--------------------------------------
function Ns.OnEventFunc(event, ...)
	-- SinLive
	-- local unit = ...
	-- if unit == "target" then Ns.SinLive() return end

end

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
	-- default (1): 0:00
	if hours > 0 then return string.format("%d:%02d:%02d", hours, minutes, secs)
	else return string.format("%d:%02d", minutes, secs) end
end

--------------------------------------
--		Instance Timer				--
--------------------------------------
Ns.InstanceTimerData = { startTime = 0, running = false, completed = false, lastDisplay = "0:00", finalTime = nil, sentToChat = false, useMPlus = false, initialized = false }

function Ns.InitInstanceTimer()
	if Ns.InstanceTimerData.initialized then return end
	Ns.InstanceTimerData.initialized = true
	local d = Ns.InstanceTimerData
	local f = CreateFrame("Frame")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	if C_ChallengeMode then
		f:RegisterEvent("CHALLENGE_MODE_START")
		f:RegisterEvent("CHALLENGE_MODE_COMPLETED")
	end
	f:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_ENTERING_WORLD" then
			local inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == "party" or instanceType == "raid") then
				if not d.running then
					d.useMPlus = C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive and C_ChallengeMode.IsChallengeModeActive() or false
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
		elseif event == "CHALLENGE_MODE_START" then
			d.startTime = GetTime()
			d.running = true
			d.completed = false
			d.sentToChat = false
			d.finalTime = nil
			d.useMPlus = true
		elseif event == "CHALLENGE_MODE_COMPLETED" then
			d.running = false
			d.completed = true
			local _, _, time = C_ChallengeMode.GetCompletionInfo()
			if time then
				d.finalTime = time / 1000
			else
				d.finalTime = GetTime() - d.startTime
			end
		end
	end)
end