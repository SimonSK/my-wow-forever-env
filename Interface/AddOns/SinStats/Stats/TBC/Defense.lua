local _, Ns = ...

------------------------------
--		Global Updater		--
------------------------------

Ns.armorValue, Ns.armorDebuff, Ns.ohID = 0, 0, 0
Ns.dodgeChance, Ns.parryChance, Ns.blockChance, Ns.avoid, Ns.defAdjust, Ns.avoidBase = 0, 0, 0, 0, 0, 0
local CritTaken, DamageTaken, Both = 1, 2, 3
local Percentage, Rating = 1, 2
local Total = 1
local Chance, Reduction = 1, 2

local function GetCritGradient(ratio)
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

function Ns.DefenseUpdate()

 	Ns.targetLevel = Ns.playerLevel + 3
	if UnitCanAttack("player", "target") then Ns.targetLevel = UnitLevel("target")
		if Ns.targetLevel <= 0 then Ns.targetLevel = Ns.playerLevel + 3 end
	end

	-- Armor
	local _, effectiveArmor, _, _, negBuff = UnitArmor("player")
	Ns.armorValue = effectiveArmor
	Ns.armorDebuff = negBuff

	-- Block, Parry, Dodge
	Ns.blockChance = GetBlockChance()
	Ns.parryChance = GetParryChance()
	Ns.dodgeChance = GetDodgeChance()

	-- Avoidance / Crushing
	local ohID = GetInventoryItemID("player", 17)

	local miss = 5

	if ohID == nil then  Ns.blockChance = 0 end

	Ns.avoid = (miss + Ns.dodgeChance + Ns.parryChance + Ns.blockChance)
	Ns.avoidBase = (miss + Ns.dodgeChance + Ns.parryChance + Ns.blockChance)
end
------------------------------------------------

-- Armor
function Ns.FunctionList.Armor(HUD, data, options, ...)

	local returnText
	local debuffColor = ""
	local statusbar, maxbar

	if Ns.armorDebuff < 0 then
		debuffColor = "|cffC41E3A"
	end

	returnText = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, Ns.armorValue)

	local capColor = ""
	if Ns.armorValue >= options.Cap_Def_Armor then capColor = Ns.greenText end
	if options.Cap_Def_Armor == 0 then capColor = "" end

	statusbar = Ns.armorValue
	maxbar = options.Cap_Def_Armor

	HUD:UpdateText(data, capColor .. returnText)
	HUD:UpdateBar(data, statusbar, maxbar)
end
------------------------------------------------

-- Defense
function Ns.FunctionList.Defense(HUD, data, options, ...)

	local EB = options.Total_Rating
	--local statFormat = Double_Rating_Format[EB]
	local defenseDisplay = Ns.totalDefense
	local returnText, decimals
	local capColor, endColor = "", ""

	if options.Display_Basic then defenseDisplay = Ns.baseDefense end

	if defenseDisplay >= options.Cap_Def_Def then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if options.Decimals_Default == 0 then decimals = "%.0f"
	elseif options.Decimals_Default == 1 then decimals = "%.1f"
	elseif options.Decimals_Default == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	if Ns.Band(EB, Total) then returnText = capColor .. (decimals):format(defenseDisplay) end
	if Ns.Band(EB, Rating) then returnText = ("%.0f"):format(Ns.defenseRating) end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(defenseDisplay) .. endColor .. " (" .. ("%.0f"):format(Ns.defenseRating) .. ")" end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, defenseDisplay, options.Cap_Def_Def)
end
------------------------------------------------

-- Stamina
function Ns.FunctionList.Stamina(HUD, data, options, ...)

	local _, stat, _, negBuff = UnitStat("Player", 3)
	local debuffColor = ""

	if options.Color_Effect and negBuff < 0 then debuffColor = "|cffC41E3A" end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, stat))
end
------------------------------------------------

-- Effective HP 
function Ns.FunctionList.EHP(HUD, data, options, ...)

	local maxHP = UnitHealthMax("player")
	local ehp, armorDR, classDR, barV, barM = 0, 0, 1, 0, 0
	local capColor = ""

	if Ns.classFilename == "WARRIOR" and GetShapeshiftForm() == 2 then
		classDR = (1 - 0.1)
	end

	armorDR = (Ns.armorValue / ((73 * 467.5) + Ns.armorValue - 22167.5))

	if Ns.targetLevel < 73  then
		armorDR = (Ns.armorValue / ((Ns.targetLevel * 467.5) + Ns.armorValue - 10557.5))
	end

    ehp = maxHP / (classDR - armorDR )

	if ehp >= options.Cap_Ehp then capColor = Ns.greenText end
	if options.Cap_Ehp == 0 then capColor = "" end

	barV = ehp
	local mode = options.BarMaxMode
	if mode == 1 then barM = options.Cap_Ehp
	else barM = options.BarMaxCustom end

	ehp = Ns.DecimalNumber(options.Decimals_Default, ehp)

	HUD:UpdateText(data, capColor .. ehp)
	HUD:UpdateBar(data, barV, barM)
end
------------------------------------------------

-- Resilience
function Ns.FunctionList.Resilience(HUD, data, options, ...)

	local EB = options.Crit_Damage_Taken
	local returnText, decimals, dualdec
	local capColor = ""

	local Resilience = GetCombatRatingBonus(15)
	local resiDamage = GetCombatRatingBonus(16)
	local rating = GetCombatRating(15)
	resiDamage = resiDamage + Resilience

	if options.Decimals_Two == 0 then decimals = "%.0f%%" ; dualdec = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%" ; dualdec = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%" ; dualdec = "%.2f"
	else decimals = "%.3f%%"; dualdec = "%.3f" end

	if Ns.Band(EB, CritTaken) then returnText = (decimals):format(Resilience) end
	if Ns.Band(EB, DamageTaken) then returnText = (decimals):format(resiDamage) end
	if Ns.Band(EB, Both) then returnText = (dualdec):format(Resilience) .. "/" .. (decimals):format(resiDamage) end

	if options.Display_Rating then returnText = returnText .. " (" .. rating .. ")" end

	if rating >= options.Cap_Rating then capColor = Ns.greenText end
	if options.Cap_Rating == 0 then capColor = "" end

	HUD:UpdateText(data, capColor .. returnText)
end
------------------------------------------------

-- Mitigation
function Ns.FunctionList.DMGReduc(HUD, data, options, ...)

	local returnText
	local debuffColor = ""
	local decimals, statusbar
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end

	local armorReduction = (Ns.armorValue/(Ns.armorValue+400+85*((5.5 * Ns.targetLevel)-265.5))) * 100

	if Ns.targetLevel <= Ns.playerLevel then
		armorReduction = (PaperDollFrame_GetArmorReduction(Ns.armorValue, Ns.targetLevel) / 100) or 0
	end

	if Ns.armorDebuff < 0 then
		debuffColor = "|cffC41E3A"
	end

	if armorReduction < 0 then armorReduction = 0 end

	returnText = debuffColor .. (decimals):format(armorReduction)

	statusbar = armorReduction

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Crit Immunity
function Ns.FunctionList.CritReceived(HUD, data, options, ...)

	local EB = options.Chance_Reduction
	local chanceGetCrit = 19
	local getCritLevel = (Ns.targetLevel - Ns.playerLevel) * 0.2 -- 0.2 / 0.4 / 0.6 
	--local getCritDefense = (Ns.totalDefense) * 0.04
	local uncritCap = 5
	local critTakenCap = 5.6
	local returnText, decimals, liveImmunity
	local resilCrit = GetDodgeBlockParryChanceFromDefense()
	local resilvalue = GetCombatRatingBonus(15)
	local bar

	chanceGetCrit = (uncritCap + getCritLevel) - resilCrit - Ns.survFittest - resilvalue

	--if chanceGetCrit < 0 then chanceGetCrit = 0 end

	critTakenCap = critTakenCap - chanceGetCrit

	local chanceColor, reductionColor = "", ""
	if options.Color_Effect then
		chanceColor = GetCritGradient((5.6 - chanceGetCrit) / 5.6)
		reductionColor = GetCritGradient(critTakenCap / 5.6)
	end

	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end

	if options.Display_Simulate then liveImmunity = " > " .. (decimals):format(Ns.critReceived)
	else liveImmunity = "" end

	if Ns.Band(EB, Chance) then returnText = chanceColor .. (decimals):format(chanceGetCrit) .. "|r" .. liveImmunity; bar = 5.6 - chanceGetCrit; maxBar = 5.6 end
	if Ns.Band(EB, Reduction) then returnText = reductionColor .. (decimals):format(critTakenCap) .. "|r" .. liveImmunity; bar = critTakenCap; maxBar = 5.6 end
	if Ns.Band(EB, Both) then returnText = chanceColor .. (decimals):format(chanceGetCrit) .. " |r(" .. reductionColor .. (decimals):format(critTakenCap) .. "|r)" .. liveImmunity; bar = 5.6 - chanceGetCrit; maxBar = 5.6 end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, bar, maxBar)

end
------------------------------------------------

-- Dodge
function Ns.FunctionList.Dodge(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local dodgeRating =	GetCombatRating(CR_DODGE)
	local returnText, decimals, liveDodge

	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end

	if options.Display_Simulate then liveDodge = " > " .. (decimals):format(Ns.totalDodge)
	else liveDodge = "" end

	if Ns.Band(EB, Percentage) then returnText = (decimals):format(Ns.dodgeChance) .. liveDodge end
	if Ns.Band(EB, Rating) then returnText = dodgeRating .. liveDodge end
	if Ns.Band(EB, Both) then returnText = (decimals):format(Ns.dodgeChance) .. " (" .. dodgeRating .. ")" .. liveDodge end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Parry
function Ns.FunctionList.Parry(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local parryRating =	GetCombatRating(CR_PARRY)
	local returnText, decimals, liveParry

	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end

	if options.Display_Simulate then liveParry = " > " .. (decimals):format(Ns.totalParry)
	else liveParry = "" end

	if Ns.Band(EB, Percentage) then returnText = (decimals):format(Ns.parryChance) .. liveParry end
	if Ns.Band(EB, Rating) then returnText = parryRating .. liveParry end
	if Ns.Band(EB, Both) then returnText = (decimals):format(Ns.parryChance) .. " (" .. parryRating .. ")" .. liveParry end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Block
function Ns.FunctionList.Block(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local blockRating =	GetCombatRating(CR_BLOCK)
	local returnText, decimals, liveBlock

	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end

	if options.Display_Simulate then liveBlock = " > " .. (decimals):format(Ns.totalBlock)
	else liveBlock = "" end

	if Ns.Band(EB, Percentage) then returnText = (decimals):format(Ns.blockChance) .. liveBlock end
	if Ns.Band(EB, Rating) then returnText = blockRating .. liveBlock end
	if Ns.Band(EB, Both) then returnText = (decimals):format(Ns.blockChance) .. " (" .. blockRating .. ")" .. liveBlock end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Avoidance
function Ns.FunctionList.Avoidance(HUD, data, options, ...)

	local avoidColor = ""
	local defAdjust = (5 + (Ns.totalDefense - (Ns.playerLevel * 5)) * 0.04)
	local avoid = (defAdjust + Ns.dodgeChance + Ns.parryChance + Ns.blockChance)
	local returnText
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end

	avoid = avoid - Ns.scorpidSting - Ns.insectSwarm


	if options.Color_Effect and avoid >= 102.4 then
		avoidColor = "|cff00f26d+"
	end

	returnText = avoidColor .. (decimals):format(avoid) .. "|r"

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, avoid, 102.4)
end
------------------------------------------------

-- Crushing
function Ns.FunctionList.Crushing(HUD, data, options, ...)

	local crushColor = ""
	local defAdjust = (5 + (Ns.totalDefense - (Ns.playerLevel * 5)) * 0.04)
	local avoid = (defAdjust + Ns.dodgeChance + Ns.parryChance + Ns.blockChance)
	local returnText
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end

	avoid = avoid - Ns.scorpidSting - Ns.insectSwarm

	local crush = 102.4 - avoid

	if options.Color_Effect and crush <= 0 then
		crushColor = "|cff00f26d+"
	end

	returnText = crushColor .. (decimals):format(crush)

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, 102.4 - crush, 102.4)
end
------------------------------------------------