local _, Ns = ...
local Safe = Ns.Safe

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

	if Safe(negBuff) < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end

-- Strength
function Ns.FunctionList.Strength(HUD, data, options, ...)

	local _, stat, _, negBuff = UnitStat("Player", 1)
	local debuffColor = ""

	if Safe(negBuff) < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end

-- Intellect
function Ns.FunctionList.Intellect(HUD, data, options, ...)

	local _, stat, _, negBuff = UnitStat("Player", 4)
	local debuffColor = ""

	if Safe(negBuff) < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end

-- Spirit
function Ns.FunctionList.Spirit(HUD, data, options, ...)

	local _, stat, _, negBuff = UnitStat("Player", 5)
	local debuffColor = ""

	if Safe(negBuff) < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end

-- Stamina
function Ns.FunctionList.Stamina(HUD, data, options, ...)

	local _, stat, _, negBuff = UnitStat("Player", 3)
	local debuffColor = ""

	if Safe(negBuff) < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end

-- Health regeneration per 5 seconds, out of combat
-- GetHealthRegen returns health per second; the paper doll prints it per 5 seconds
-- DecimalFormat maps the slider directly: 0 = no decimals, 1 = one decimal, ...
function Ns.FunctionList.HealthRegen(HUD, data, options, ...)

	local regen = Safe(GetHealthRegen()) * 5

	HUD:UpdateText(data, Ns.DecimalFormat(options.Decimals_Default):format(regen))
end
