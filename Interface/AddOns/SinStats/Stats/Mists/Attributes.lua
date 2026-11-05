local AddName, Ns = ...
local L = Ns.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Percentage, Rating, Points = 3, 1, 2, 1

------------------------------
--		Global Updater		--
------------------------------

-- Agility
function Ns.FunctionList.Agility(HUD, data, options, ...)

	local _, stat, _, negBuff = UnitStat("Player", 2)
	local debuffColor = ""

	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end

-- Strength
function Ns.FunctionList.Strength(HUD, data, options, ...)

	local _, stat, _, negBuff = UnitStat("Player", 1)
	local debuffColor = ""

	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end

-- Intellect
function Ns.FunctionList.Intellect(HUD, data, options, ...)

	local _, stat, _, negBuff = UnitStat("Player", 4)
	local debuffColor = ""

	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end

-- Spirit
function Ns.FunctionList.Spirit(HUD, data, options, ...)

	local _, stat, _, negBuff = UnitStat("Player", 5)
	local debuffColor = ""

	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end

-- Stamina
function Ns.FunctionList.Stamina(HUD, data, options, ...)

	local _, stat, _, negBuff = UnitStat("Player", 3)
	local debuffColor = ""

	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end

-- Mastery
function Ns.FunctionList.Mastery(HUD, data, options, ...)

	local EB = options.Point_Rating
	local mastery = GetMastery()--GetCombatRatingBonus(CR_MASTERY)
	local masteryRating = GetCombatRating(CR_MASTERY)
	local returnText, decimals, statusbar
	local capColor, endColor = "", ""

	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	if mastery >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Ns.Band(EB, Points) then returnText = capColor .. (decimals):format(mastery); statusbar = mastery end
	if Ns.Band(EB, Rating) then returnText = masteryRating; statusbar = masteryRating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(mastery) .. endColor .. " (" .. masteryRating .. ")"; statusbar = mastery end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
