local _, Ns = ...

local SameLevel, BossLevel, Both = 1, 2, 3
local Percentage, Rating = 1, 2

------------------------------
--		Global Updater		--
------------------------------

function Ns.RangedUpdate()

 	Ns.targetLevel = Ns.playerLevel + 3
	if UnitCanAttack("player", "target") then Ns.targetLevel = UnitLevel("target")
		if Ns.targetLevel <= 0 then Ns.targetLevel = Ns.playerLevel + 3 end
	end

	Ns.savedGUID = UnitGUID("target")

	-- Attack Speed
	Ns.speed, Ns.lowDmg, Ns.hiDmg, Ns.posBuff, Ns.negBuff, Ns.percentMod = UnitRangedDamage("player")

	-- Critical
	Ns.critRanged = GetRangedCritChance()
	Ns.gunEquipped = IsEquippedItemType("Guns")
	Ns.bowEquipped = IsEquippedItemType("Bows")

	-- Dwarf racial [Crit]
	if Ns.gunEquipped and Ns.dwarfRacial then Ns.critRanged = Ns.critRanged + 1 end
	-- Troll racial [Crit]
	if Ns.bowEquipped and Ns.bowSpec then Ns.critRanged = Ns.critRanged + 1 end

	-- Hit
	local hitModifier = GetHitModifier()
	Ns.hitRanged = GetCombatRatingBonus(CR_HIT_RANGED)

	if Ns.hitRanged == nil then Ns.hitRanged = 0 end
	if hitModifier == nil then hitModifier = 0 end

	Ns.hitRanged = Ns.hitRanged + hitModifier

end

-- Haste
function Ns.FunctionList.HasteRanged(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local haste = GetCombatRatingBonus(CR_HASTE_RANGED)
	local rating = GetCombatRating(CR_HASTE_RANGED)
	local hasteMod = 0
	local returnText
	local statusbar
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end
	local capColor, endColor = "", ""

	hasteMod = Ns.rangedHaste + Ns.pouchCounter + Ns.hasteHands + Ns.serpentSwift + haste

	if hasteMod >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Ns.Band(EB, Percentage) then returnText = capColor .. (decimals):format(hasteMod) .. endColor; statusbar = hasteMod end
	if Ns.Band(EB, Rating) then returnText = rating; statusbar = hasteMod end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(hasteMod) .. endColor .. "/" .. rating; statusbar = hasteMod end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Attack Power
function Ns.FunctionList.RAP(HUD, data, options, ...)

	local base, posBuff, negBuff = UnitRangedAttackPower("player");
	local effectiveRanged = 0
	local hmBuffColor = ""
	local returnText

	effectiveRanged = base + posBuff + negBuff

	if Ns.targetGUID == Ns.savedGUID then
		effectiveRanged = base + posBuff + negBuff + Ns.huntersMark + Ns.hmIncrements
	end

	returnText = Ns.DecimalNumber(options.Decimals_Default, effectiveRanged)

	if negBuff < 0 then
		returnText = "|cffC41E3A" .. returnText .. "|r"
	else
		if (Ns.huntersMark > 0) and (Ns.targetGUID == Ns.savedGUID) then
			hmBuffColor = "|cff00f26d"
		end
		returnText = hmBuffColor .. returnText .. "|r"
	end

	local capColor = ""
	if effectiveRanged >= options.Cap_Rating then capColor = Ns.greenText end
	if options.Cap_Rating == 0 then capColor = "" end

	HUD:UpdateText(data, capColor .. returnText)
	HUD:UpdateBar(data, effectiveRanged, options.Cap_Rating)
end
------------------------------------------------

-- Attack Speed
function Ns.FunctionList.rangedSpeed(HUD, data, options, ...)

	local speed = UnitRangedDamage("player")
	local returnText
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	returnText = (decimals):format(speed)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Damage
function Ns.FunctionList.RDMG(HUD, data, options, ...)

	local _, _, hiDmg, _, negBuff = UnitRangedDamage("player")
	local returnText
	local debuffColor = ""

	hiDmg = hiDmg + (hiDmg * Ns.bloodFrenzy) + Ns.hemoDmg

	if options.Color_Effect and negBuff < 0 then debuffColor = "|cffC41E3A" end


	returnText = Ns.DecimalNumber(options.Decimals_Default, hiDmg)

	HUD:UpdateText(data, debuffColor .. returnText)
end
------------------------------------------------

-- DPS
function Ns.FunctionList.rDPS(HUD, data, options, ...)

	local speed, lowDmg, hiDmg, _, negBuff = UnitRangedDamage("player")
	local returnText
	local rangedDPS = 0
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	if speed ~= 0 then
		rangedDPS = ((lowDmg + hiDmg) / 2) / speed
	end
	if negBuff < 0 and options.Color_Effect then
		returnText = "|cffC41E3A" .. (decimals):format(rangedDPS) .. "|r"
	else
		returnText = (decimals):format(rangedDPS)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critcal
function Ns.FunctionList.RangedCrit(HUD, data, options, ...)

	local EB = options.Level_Same_Boss
	local critRangedChance = GetRangedCritChance("player")
	local critBoss = 0
	local returnText
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end
	local capColor, endColor = "", ""
	local ratingText = ""
	local statusbar, liveCrit

	if Ns.gunEquipped and Ns.dwarfRacial then
		critRangedChance = critRangedChance + 1
	end

	local levelDifference = 0
	local critAura = 1.84

	levelDifference = Ns.targetLevel - Ns.playerLevel
	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	end
	critBoss = critRangedChance - levelDifference - critAura
	if critRangedChance < 0 then
		critRangedChance = 0
	end

	if critRangedChance >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if options.Display_Rating then
		local critRating = GetCombatRating(CR_CRIT_RANGED)
		ratingText = " (" .. critRating .. ")"
	end

	if options.Display_Simulate then liveCrit = " > " .. (decimals):format(Ns.rangedCrit)
	else liveCrit = "" end

	if Ns.Band(EB, SameLevel) then returnText = capColor .. (decimals):format(critRangedChance) .. ratingText .. endColor .. liveCrit; statusbar = critRangedChance end
	if Ns.Band(EB, BossLevel) then returnText = capColor .. (decimals):format(critBoss) .. ratingText .. endColor .. liveCrit; statusbar = critBoss end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(critRangedChance) .. " / " .. (decimals):format(critBoss) .. ratingText .. endColor .. liveCrit; statusbar = critRangedChance end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Hit
function Ns.FunctionList.RangedHit(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local hitRangedRating = GetCombatRatingBonus(CR_HIT_RANGED)
	local hit = GetCombatRating(CR_HIT_RANGED)
	local returnText
	local statusbar
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end
	local capColor, endColor = "", ""

	if hitRangedRating == nil then
		hitRangedRating = 0
	end

	local hitRangedChance = GetHitModifier()
	if hitRangedChance == nil then
		hitRangedChance = 0
	end

	hitRangedChance = hitRangedChance + hitRangedRating + Ns.heroicPresence

	if hitRangedChance >= options.Cap_Hit then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Ns.Band(EB, Percentage) then returnText = capColor .. (decimals):format(hitRangedChance) .. endColor; statusbar = hitRangedChance end
	if Ns.Band(EB, Rating) then returnText = capColor .. hit .. endColor; statusbar = hitRangedChance end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(hitRangedChance) .. endColor .. " / " .. hit; statusbar = hitRangedChance end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Armor Penetration
function Ns.FunctionList.RangedPen(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local rangedPenetration = GetArmorPenetration()
	local rangedPenRating = GetCombatRating(CR_ARMOR_PENETRATION)
	local returnText, decimals
	local capColor, endColor = "", ""

	if options.Dec_Ranged_Pen == 0 then decimals = "%.0f%%"
	elseif options.Dec_Ranged_Pen == 1 then decimals = "%.1f%%"
	elseif options.Dec_Ranged_Pen == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end

	if rangedPenRating >= options.Cap_Ranged_ArP then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Ns.Band(EB, Percentage) then returnText = capColor .. (decimals):format(rangedPenetration) end
	if Ns.Band(EB, Rating) then returnText = capColor .. ("%.0f"):format(rangedPenRating) end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(rangedPenetration) .. endColor .. " (" .. ("%.0f"):format(rangedPenRating) .. ")" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Miss
function Ns.FunctionList.RangedMiss(HUD, data, options, ...)

	local EB = options.Level_Same_Boss
	local returnText

	local rangedMissLevel = 0
	local rangedMissBoss = 0
	local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
	local levelDiffDef = Ns.targetLevel - Ns.playerLevel
	local levelDefense = Ns.playerLevel * 5
	local bossDefense = (Ns.playerLevel + levelDiffDef) * 5
	local rWeaponSkill = (rangedAttackBase + rangedAttackMod)
	local rangedSkillDiff = levelDefense - rWeaponSkill
	local rbossSkillDiff = bossDefense - rWeaponSkill
	local decimals, liveMiss
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	local hitRangedRating = GetCombatRatingBonus(CR_HIT_RANGED)
	local returnText

	if hitRangedRating == nil then
		hitRangedRating = 0
	end

	local hitRangedChance = GetHitModifier()
	if hitRangedChance == nil then
		hitRangedChance = 0
	end

	hitRangedChance = hitRangedChance + hitRangedRating + Ns.heroicPresence


	if rangedSkillDiff > 10 then	
		rangedMissLevel = (7 + ((rangedSkillDiff - 10) * 0.4))
		rangedMissLevel = rangedMissLevel - hitRangedChance
	elseif rangedSkillDiff <= 10 then	
		rangedMissLevel = (5 + ((rangedSkillDiff) * 0.1))
		rangedMissLevel = rangedMissLevel - hitRangedChance
	end

	if rbossSkillDiff > 10 then
		rangedMissBoss = (7 + ((rbossSkillDiff - 10) * 0.4))
		rangedMissBoss = rangedMissBoss - hitRangedChance	
	elseif rbossSkillDiff <= 10 then
		rangedMissBoss = (5 + ((rbossSkillDiff) * 0.1))
		rangedMissBoss = rangedMissBoss - hitRangedChance	
	end 

	if rangedMissLevel < 0 then
		rangedMissLevel = 0
	elseif rangedMissLevel > 100 then
		rangedMissLevel = 100
	end

	if rangedMissBoss < 0 then
		rangedMissBoss = 0
	elseif rangedMissBoss > 100 then
		rangedMissBoss = 100
	end

	local statusbar

	if options.Display_Simulate then liveMiss = " > " .. (decimals):format(Ns.rangedMissTracker)
	else liveMiss = "" end

	if Ns.Band(EB, SameLevel) then returnText = (decimals):format(rangedMissLevel) .. "%" .. liveMiss; statusbar = rangedMissLevel end
	if Ns.Band(EB, BossLevel) then returnText = (decimals):format(rangedMissBoss) .. "%" .. liveMiss; statusbar = rangedMissBoss end
	if Ns.Band(EB, Both) then returnText = (decimals):format(rangedMissBoss) .. "%" .. " / " .. (decimals):format(rangedMissBoss) .. "%" .. liveMiss; statusbar = rangedMissBoss end

	statusbar = math.max(0, 100 - (statusbar or 0))

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

