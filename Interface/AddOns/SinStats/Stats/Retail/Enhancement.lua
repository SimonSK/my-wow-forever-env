local AddName, Ns = ...
local L = Ns.L
local issecretvalue = Ns.issecretvalue
local Safe = Ns.Safe
local ReverseDR = Ns.ReverseDR
local GetDRColor = Ns.GetDRColor
local GetSpeedGlideColor = Ns.GetSpeedGlideColor

------------------------------
--		Options Equates		--
------------------------------
local Damage, Percent, Live, Enhanced = 1, 1, 1, 1
local DamageTaken, Rating, Static, Base = 2, 2, 2, 2
local Both = 3
local Auto, SteadyFlying, Skyriding, OnFoot, Custom, Mounted = 1, 2, 3, 4, 5, 6
local Speed_Percent, Speed_Yards, Speed_Km = 1, 2, 3


------------------------------
--		Secret Cache		--
------------------------------
local cachedCritRatingIndex = 0  -- 0=melee, 1=ranged, 2=spell
local cachedCritDrColor = ""
local cachedCritDrLoss = 0

local cachedHasteDrColor = ""
local cachedHasteDrLoss = 0

local cachedMasteryDrColor = ""
local cachedMasteryDrLoss = 0

local cachedVersDrColor = ""
local cachedVersDmgDrLoss = 0
local cachedVersMitDrLoss = 0
local cachedVersDmg = 0
local cachedVersMitigate = 0
local cachedVersAura = false

local cachedFullSpeed = 0
local cachedRawFullSpeed = 0
local cachedRawStaticSpeed = 0
local cachedStaticSpeed = 0

------------------------------
--		Enhancements		--
------------------------------

-- Primary
local cachedPrimaryIndex = 4  -- default to intellect until first read
function Ns.FunctionList.Primary(HUD, data, options, ...)

	local EB = options.Enhanced_Base

	local _s1, str1 = UnitStat("player", 1)
	if not issecretvalue(str1) then
		local _s2, str2 = UnitStat("player", 2)
		local _s4, str4 = UnitStat("player", 4)
		str1 = str1 or 0
		str2 = str2 or 0
		str4 = str4 or 0
		if str1 >= str2 and str1 >= str4 then
			cachedPrimaryIndex = 1
		elseif str2 >= str1 and str2 >= str4 then
			cachedPrimaryIndex = 2
		else
			cachedPrimaryIndex = 4
		end
	end

	local stat, base, negBuff, autoName
	local b, s, _, n = UnitStat("player", cachedPrimaryIndex)
	base, stat, negBuff = b, s, n
	if cachedPrimaryIndex == 1 then autoName = L["Strength"]
	elseif cachedPrimaryIndex == 2 then autoName = L["Agility"]
	else autoName = L["Intellect"] end

	if options.Auto_Name then
		Ns.primaryAutoName = autoName
	else
		Ns.primaryAutoName = nil
	end

	local debuffColor = ""
	local returnText

	if base == nil then base = 0 end
	if stat == nil then stat = 0 end

	if negBuff ~= nil and not issecretvalue(negBuff) and negBuff < 0 then debuffColor = "|cffC41E3A" end

	stat = Ns.DecimalNumber(options.Decimals_Default, stat)
	base = Ns.DecimalNumber(options.Decimals_Default, base)

	if Ns.Band(EB, Enhanced) then returnText = debuffColor .. stat end
	if Ns.Band(EB, Base) then returnText = base end
	if Ns.Band(EB, Both) then returnText = debuffColor .. stat .. "|r/" .. base end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- Critical
function Ns.FunctionList.CritChance(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local totalCrit, rating
	local returnText, decimals, statusbar
	local critChance = GetCritChance()
	local critSpellChance = GetSpellCritChance()
	local critRangedChance = GetRangedCritChance()
	local meleeRating = GetCombatRating(CR_CRIT_MELEE)
	local rangedRating = GetCombatRating(CR_CRIT_RANGED)
	local spellRating = GetCombatRating(CR_CRIT_SPELL)
	if not issecretvalue(critChance) then
		totalCrit = max(critChance, critSpellChance, critRangedChance)
		-- Cache which rating type is dominant while values are readable
		if spellRating >= meleeRating and spellRating >= rangedRating then
			cachedCritRatingIndex = 2
		elseif rangedRating >= meleeRating then
			cachedCritRatingIndex = 1
		else
			cachedCritRatingIndex = 0
		end
		rating = max(meleeRating, rangedRating, spellRating)
	else
		-- Values are secret: crit percent just uses any (all render identically via string.format)
		totalCrit = critChance
		-- For rating, use the cached dominant type so casters show spell rating, etc.
		if cachedCritRatingIndex == 2 then rating = spellRating
		elseif cachedCritRatingIndex == 1 then rating = rangedRating
		else rating = meleeRating end
	end
	--local baseCrit = totalCrit
	local capColor, endColor, rateColor = "", "", ""

	if not issecretvalue(totalCrit) then
		totalCrit = totalCrit + Ns.combustion + Ns.betweenEyes + Ns.overflowEnergy
	end

	--if options.Display_Basic then totalCrit = baseCrit end

	-- DR stuff
	local drLoss, drColor = 0, ""
	if options.DR_Display or options.DR_Gradient then
		local rb1 = GetCombatRatingBonus(CR_CRIT_MELEE)
		if not issecretvalue(rb1) then
			local ratingBonus = max(rb1, GetCombatRatingBonus(CR_CRIT_RANGED), GetCombatRatingBonus(CR_CRIT_SPELL))
			local noDRBonus = ReverseDR(ratingBonus)
			drLoss = noDRBonus - ratingBonus
			if options.DR_Gradient then drColor = GetDRColor(ratingBonus) end
			cachedCritDrColor = drColor
			cachedCritDrLoss = drLoss
		else
			drColor = cachedCritDrColor
			drLoss = cachedCritDrLoss
		end
	end

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Safe(totalCrit) >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Safe(rating) >= options.Cap_Rating then rateColor = Ns.greenText end

	if not issecretvalue(rating) then rating = BreakUpLargeNumbers(rating) end

	if options.Cap_Percent == 0 then capColor = "" end
	if options.Cap_Rating == 0 then rateColor = "" end

	if drColor ~= "" and capColor == "" then capColor = drColor; endColor = "|r" end

	if Ns.Band(EB, Percent) then returnText = capColor .. (decimals):format(totalCrit); statusbar = totalCrit end
	if Ns.Band(EB, Rating) then returnText = rateColor .. rating; statusbar = rating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(totalCrit) .. endColor .. "/" .. rateColor .. rating .. endColor; statusbar = totalCrit end

	if options.DR_Display and drLoss > 0 and Ns.Band(EB, Percent) then
		returnText = returnText .. endColor .. " (" .. Ns.redText .. "-" .. (decimals):format(drLoss) .. "|r)"
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end

-- Haste
function Ns.FunctionList.Haste(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local haste = GetHaste()
	local rating = GetCombatRating(CR_HASTE_MELEE)
	local returnText, decimals, statusbar
	local capColor, endColor, rateColor = "", "", ""

	-- DR stuff
	local drLoss, drColor = 0, ""
	if options.DR_Display or options.DR_Gradient then
		local ratingBonus = GetCombatRatingBonus(CR_HASTE_MELEE)
		if not issecretvalue(ratingBonus) then
			local noDRBonus = ReverseDR(ratingBonus)
			drLoss = noDRBonus - ratingBonus
			if options.DR_Gradient then drColor = GetDRColor(ratingBonus) end
			cachedHasteDrColor = drColor
			cachedHasteDrLoss = drLoss
		else
			drColor = cachedHasteDrColor
			drLoss = cachedHasteDrLoss
		end
	end

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Safe(haste) >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Safe(rating) >= options.Cap_Rating then rateColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end
	if options.Cap_Rating == 0 then rateColor = "" end

	if drColor ~= "" and capColor == "" then capColor = drColor; endColor = "|r" end

	if not issecretvalue(rating) then rating = BreakUpLargeNumbers(rating) end

	if Ns.Band(EB, Percent) then returnText = capColor .. (decimals):format(haste); statusbar = haste end
	if Ns.Band(EB, Rating) then returnText = rateColor .. rating; statusbar = rating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(haste) .. endColor .. "/" .. rateColor .. rating .. endColor; statusbar = haste end

	if options.DR_Display and drLoss > 0 and Ns.Band(EB, Percent) then
		returnText = returnText .. endColor .. " (" .. Ns.redText .. "-" .. (decimals):format(drLoss) .. "|r)"
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end

-- Mastery
function Ns.FunctionList.Mastery(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local masteryRaw, coefficientRaw = GetMasteryEffect()
	local mastery = masteryRaw
	local coefficient = coefficientRaw
	local rating = GetCombatRating(CR_MASTERY)
	local returnText, decimals, statusbar
	local capColor, endColor, rateColor = "", "", ""

	if options.Display_Basic then mastery = mastery end

	-- DR stuff
	local drLoss, drColor = 0, ""
	if options.DR_Display or options.DR_Gradient then
		local ratingBonus = GetCombatRatingBonus(CR_MASTERY)
		if not issecretvalue(ratingBonus) then
			local noDRBonus = ReverseDR(ratingBonus)
			local rawLoss = noDRBonus - ratingBonus
			if not issecretvalue(coefficient) then
				drLoss = rawLoss * (coefficient or 1)
			else
				drLoss = rawLoss
			end
			if options.DR_Gradient then drColor = GetDRColor(ratingBonus) end
			cachedMasteryDrColor = drColor
			cachedMasteryDrLoss = drLoss
		else
			drColor = cachedMasteryDrColor
			drLoss = cachedMasteryDrLoss
		end
	end

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Safe(mastery) >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Safe(rating) >= options.Cap_Rating then rateColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end
	if options.Cap_Rating == 0 then rateColor = "" end

	if drColor ~= "" and capColor == "" then capColor = drColor; endColor = "|r" end

	if not issecretvalue(rating) then rating = BreakUpLargeNumbers(rating) end

	if Ns.Band(EB, Percent) then returnText = capColor .. (decimals):format(mastery); statusbar = mastery end
	if Ns.Band(EB, Rating) then returnText = rateColor .. rating; statusbar = rating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(mastery) .. endColor .. "/" .. rateColor .. rating .. endColor; statusbar = mastery end

	if options.DR_Display and drLoss > 0 and Ns.Band(EB, Percent) then
		returnText = returnText .. endColor .. " (" .. Ns.redText .. "-" .. (decimals):format(drLoss) .. "|r)"
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end

-- Versatility
function Ns.FunctionList.Versatility(HUD, data, options, ...)

	local EB = options.Damage_Taken
	local vrb29 = GetCombatRatingBonus(29)
	local versRatingBonusSafe = Safe(vrb29)  -- for DR stuff (needs a real number)
	local vb29 = GetVersatilityBonus(29)
	local cbr31 = GetCombatRatingBonus(31)
	local vb31 = GetVersatilityBonus(31)
	local dmg, mitigate
	local isSecret = issecretvalue(vb29) or issecretvalue(vrb29)

	if not isSecret then
		dmg = vb29 + vrb29
		-- cachedVersAura = C_UnitAuras.GetPlayerAuraBySpellID(389501) ~= nil
		-- if cachedVersAura then
		-- 	cachedVersAura = 3
		-- end
		--cachedVersDmg = dmg
	else
		 --fallback to raw value when cache was never populated
		dmg = vrb29
	end
	if not issecretvalue(cbr31) and not issecretvalue(vb31) then
		mitigate = vb31 + cbr31
		cachedVersMitigate = mitigate
	else
		mitigate = cachedVersMitigate ~= 0 and cachedVersMitigate or vb31
	end
	local rating = ""
	local mitRating = ""
	local returnText, decimals, statusbar
	local capColor, endColor = "", ""

	-- DR stuff
	local dmgDRLoss, mitDRLoss, drColor = 0, 0, ""
	if options.DR_Display or options.DR_Gradient then
		if not issecretvalue(vrb29) then
			local noDRBonus = ReverseDR(versRatingBonusSafe)
			dmgDRLoss = noDRBonus - versRatingBonusSafe
			mitDRLoss = dmgDRLoss / 2
			if options.DR_Gradient then drColor = GetDRColor(versRatingBonusSafe) end
			cachedVersDrColor = drColor
			cachedVersDmgDrLoss = dmgDRLoss
			cachedVersMitDrLoss = mitDRLoss
		else
			drColor = cachedVersDrColor
			dmgDRLoss = cachedVersDmgDrLoss
			mitDRLoss = cachedVersMitDrLoss
		end
	end

	if options.Display_Rating or options.Rating_Only then
		local rawRating = GetCombatRating(29)
		local rawMitRating = GetCombatRating(31)
		local rText = (not issecretvalue(rawRating) and BreakUpLargeNumbers(rawRating)) or rawRating
		local mText = (not issecretvalue(rawMitRating) and BreakUpLargeNumbers(rawMitRating)) or rawMitRating
		if options.Rating_Only then
			rating = rText
			mitRating = mText
		else
			rating = " (" .. rText .. ")"
		end
	end

	if options.Rating_Only then
		if Ns.Band(EB, Damage) then returnText = rating end
		if Ns.Band(EB, DamageTaken) then returnText = mitRating or rating end
		if Ns.Band(EB, Both) then returnText = rating .. " / " .. (mitRating or rating) end
		statusbar = 0
	else
		decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")
		--local decNoPct = Ns.DecimalFormat(options.Decimals_Two, "")  -- same precision no %

		local versProc, mitProc = "", ""
		-- if isSecret and options.Show_Proc then
		-- 	versProc = "+" .. (decNoPct):format(cachedVersAura)
		-- 	mitProc  = "+" .. (decNoPct):format(cachedVersAura)
		-- end

		if Safe(dmg) >= options.Cap_Percent then capColor = Ns.greenText end
		if capColor ~= "" then endColor = "|r" end

		if options.Cap_Percent == 0 then capColor = "" end

		if drColor ~= "" and capColor == "" then capColor = drColor; endColor = "|r" end

		if Ns.Band(EB, Damage) then returnText = capColor .. (decimals):format(dmg) .. versProc .. endColor .. rating; statusbar = dmg end
		if Ns.Band(EB, DamageTaken) then returnText = capColor .. (decimals):format(mitigate) .. mitProc .. endColor .. rating; statusbar = mitigate end
		if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(dmg) .. versProc .. endColor .. "/" .. (decimals):format(mitigate) .. mitProc .. rating; statusbar = dmg end

		if options.DR_Display and dmgDRLoss > 0 then
			local lossVal
			if Ns.Band(EB, Both) then lossVal = dmgDRLoss
			elseif Ns.Band(EB, Damage) then lossVal = dmgDRLoss
			elseif Ns.Band(EB, DamageTaken) then lossVal = mitDRLoss
			end
			if lossVal then
				returnText = returnText .. " (" .. Ns.redText .. "-" .. (decimals):format(lossVal) .. "|r)"
			end
		end
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end

-- Avoidance
function Ns.FunctionList.Avoidance(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local avoidance = GetAvoidance()
	local rating = Safe(GetCombatRating(CR_AVOIDANCE))
	local returnText, decimals, statusbar
	local capColor, endColor, rateColor = "", "", ""

	if not issecretvalue(avoidance) then avoidance = avoidance + Ns.martial end

	if options.Display_Basic then avoidance = avoidance end

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Safe(avoidance) >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Safe(rating) >= options.Cap_Rating then rateColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end
	if options.Cap_Rating == 0 then rateColor = "" end

	if not issecretvalue(rating) then rating = BreakUpLargeNumbers(rating) end

	if Ns.Band(EB, Percent) then returnText = capColor .. (decimals):format(avoidance); statusbar = avoidance end
	if Ns.Band(EB, Rating) then returnText = capColor .. rating; statusbar = rating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(avoidance) .. endColor .. "/" .. rateColor .. rating .. endColor; statusbar = avoidance end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end

-- Leech
function Ns.FunctionList.Leech(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local leech = GetLifesteal()
	local rating = GetCombatRating(CR_LIFESTEAL)
	local returnText, decimals, statusbar
	local capColor, endColor, rateColor = "", "", ""

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Safe(leech) >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Safe(rating) >= options.Cap_Rating then rateColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end
	if options.Cap_Rating == 0 then rateColor = "" end

	if not issecretvalue(rating) then rating = BreakUpLargeNumbers(rating) end

	if Ns.Band(EB, Percent) then returnText = capColor .. (decimals):format(leech); statusbar = leech end
	if Ns.Band(EB, Rating) then returnText = rateColor .. rating; statusbar = rating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(leech) .. endColor .. "/" .. rateColor .. rating .. endColor; statusbar = leech end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end

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