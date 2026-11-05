local _, Ns = ...


local SameLevel, BossLevel, Both = 1, 2, 3
local Percentage, Rating = 1, 2

------------------------------
--		Global Updater		--
------------------------------

function Ns.MeleeUpdate()

	Ns.targetLevel = Ns.playerLevel + 3
	Ns.targetLvlBase = Ns.playerLevel

	if UnitCanAttack("player", "target") then
	Ns.targetLevel = UnitLevel("target")
	if Ns.targetLevel <= 0 then
		Ns.targetLevel = Ns.playerLevel + 3
	end

	Ns.targetLvlBase = UnitLevel("target")
	if Ns.targetLvlBase == -1 then
		Ns.targetLvlBase = Ns.playerLevel + 3
	elseif Ns.targetLvlBase == 0 then
		Ns.targetLvlLive = Ns.playerLevel
	end
	end

	Ns.mhID = GetInventoryItemID("player", 16);
	Ns.ohID = GetInventoryItemID("player", 17);

	Ns.hitRating = GetCombatRatingBonus(CR_HIT_MELEE)

	if Ns.hitRating == nil then
		Ns.hitRating = 0
	end
	Ns.hitChance = GetHitModifier("player")
	if Ns.hitChance == nil then
		Ns.hitChance = 0
	end

	Ns.hitChance = Ns.hitChance + Ns.hitRating + Ns.heroicPresence

end
------------------------------------------------

-- Attack Power
function Ns.FunctionList.AP(HUD, data, options, ...)

	local base, posBuff, negBuff = UnitAttackPower("player")
	local effectiveAP = base + posBuff + negBuff
	local rt
	local debuffColor = ""
	local barV, barM = 0, 0

	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	if Ns.classFilename == "DRUID" then
		if Ns.druidFormChk() then
			effectiveAP = effectiveAP + Ns.feralAP
		end
	end

	local capColor = ""
	if effectiveAP >= options.Cap_Rating then capColor = Ns.greenText end
	if options.Cap_Rating == 0 then capColor = "" end

	barV = effectiveAP
	local mode = options.BarMaxMode
	if mode == 1 then barM = options.Cap_Rating
	else barM = options.BarMaxCustom end

	rt = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, effectiveAP)

	HUD:UpdateText(data, capColor .. rt)
	HUD:UpdateBar(data, barV, barM)
end
------------------------------------------------

-- Damage
function Ns.FunctionList.DMG(HUD, data, options, ...)


	local _, hiDmg, _, _, _, negBuff, _ = UnitDamage("player")
	local dmgeffect = hiDmg
	local debuffColor = ""
	local returnText

	dmgeffect = dmgeffect + (dmgeffect * Ns.bloodFrenzy) + Ns.hemoDmg

	if options.Color_Effect and negBuff < 0 then
		debuffColor = "|cffC41E3A"
	end

	returnText = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, dmgeffect)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- DPS
function Ns.FunctionList.mDPS(HUD, data, options, ...)

	local lowDmg, hiDmg, _, _, _, negBuff, _ = UnitDamage("player")
	local mainSpeed = UnitAttackSpeed("player")
	local dmgeffect = hiDmg
	local returnText
	local debuffColor = ""
	local meleeDPS = 0
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	dmgeffect = dmgeffect + (dmgeffect * Ns.bloodFrenzy) + Ns.hemoDmg

	if mainSpeed ~= 0 then
		meleeDPS = ((lowDmg + dmgeffect) / 2) / mainSpeed
	end
	if options.Color_Effect and negBuff < 0 then
		debuffColor = "|cffC41E3A"
	end

	returnText = debuffColor .. (decimals):format(meleeDPS)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critical
function Ns.FunctionList.Crit(HUD, data, options, ...)

	local EB = options.Level_Same_Boss
	local critChance = GetCritChance("player")
	local levelDifference, critBoss = 0, 0
	local critAura = 1.84
	local returnText
	local statusbar
	local decimals, liveCrit
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end
	local capColor, endColor = "", ""

	if Ns.crusader then
		critChance = critChance + Ns.crusaderTalent
	end

	levelDifference = Ns.targetLevel - Ns.playerLevel

	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	end

	critBoss = critChance - levelDifference - critAura

	if critChance < 0 then
		critChance = 0
	end

	if critChance >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	local ratingText = ""
	if options.Display_Rating then
		local critRating = GetCombatRating(CR_CRIT_MELEE)
		ratingText = " (" .. critRating .. ")"
	end

	if options.Display_Simulate then liveCrit = " > " .. (decimals):format(Ns.meleeCrit)
	else liveCrit = "" end

	if Ns.Band(EB, SameLevel) then returnText = capColor .. (decimals):format(critChance) .. endColor .. ratingText .. liveCrit; statusbar = critChance end
	if Ns.Band(EB, BossLevel) then returnText = capColor .. (decimals):format(critBoss) .. endColor .. ratingText .. liveCrit; statusbar = critBoss end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(critChance) .. "/" .. (decimals):format(critBoss) .. endColor .. ratingText .. liveCrit; statusbar = critChance end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Critical Cap
function Ns.FunctionList.CritCap(HUD, data, options, ...)

	local mainBase, mainMod, offBase, offMod = UnitAttackBothHands("player")
	local critChance = GetCritChance("player")
	local mWeaponSkill = (mainBase + mainMod)
	local returnText
	local itemType = 0
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end

	if Ns.ohID and itemType == Ns.weaponTag then
		mWeaponSkill = math.min((mainBase + mainMod), (offBase + offMod))

	end

	local skillDiff = 365 - mWeaponSkill
	local critSupp = 4.8
	local dodgeBoss = 5 + (skillDiff * 0.1)
	local glancingBoss = 40
	local extraWeaponSkill = mWeaponSkill - (Ns.playerLevel * 5)
	local mcritCap = 100 - Ns.missMod - dodgeBoss - glancingBoss + critSupp + (extraWeaponSkill * 0.04)
	local debuffColor = ""

	if options.Color_Effect then
		if critChance > mcritCap then
			debuffColor = "|cffC41E3A"
		elseif critChance == mcritCap then
			debuffColor = "|cffFF7C0A"
		else
			debuffColor = "|cff00f26d"
		end
	end

	if mcritCap > 100 then
		mcritCap = 100
	end

	returnText = debuffColor .. (decimals):format(mcritCap) .. "|r"

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Hit
function Ns.FunctionList.Hit(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local returnText
	local statusbar
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end
	local capColor, endColor = "", ""
	if Ns.hitChance >= options.Cap_Hit then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Ns.Band(EB, Percentage) then returnText = capColor .. (decimals):format(Ns.hitChance) .. endColor; statusbar = Ns.hitChance end
	if Ns.Band(EB, Rating) then returnText = Ns.hitRating; statusbar = Ns.hitChance end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(Ns.hitChance) .. endColor .. "/" .. Ns.hitRating; statusbar = Ns.hitChance end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Haste
function Ns.FunctionList.HasteMelee(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local haste = GetCombatRatingBonus(CR_HASTE_MELEE)
	local hasteRating = GetCombatRating(CR_HASTE_MELEE)
	local returnText, hasteMod = _, 0
	local statusbar
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end
	local capColor, endColor = "", ""

	hasteMod = Ns.meleeHaste + Ns.hasteHands + Ns.serpentSwift + haste

	if hasteMod >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Ns.Band(EB, Percentage) then returnText = capColor .. (decimals):format(hasteMod) .. endColor; statusbar = hasteMod end
	if Ns.Band(EB, Rating) then returnText = hasteRating; statusbar = hasteMod end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(hasteMod) .. endColor .. "/" .. hasteRating; statusbar = hasteMod end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Attack Speed
function Ns.FunctionList.weaponSpeed(HUD, data, options, ...)

	local mainSpeed, offSpeed = UnitAttackSpeed("player")
	local returnText
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	if offSpeed == nil then
		offSpeed = ""
	else
		offSpeed = "/" .. (decimals):format(offSpeed)
	end

	returnText = (decimals):format(mainSpeed) .. offSpeed

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Armor Penenetration
function Ns.FunctionList.ArmorPenetration(HUD, data, options, ...)

	local armorPen = GetArmorPenetration()
	local returnText
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end
	local capColor, endColor = "", ""
	if armorPen >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	returnText = capColor .. (decimals):format(armorPen) .. endColor

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, armorPen)
end
------------------------------------------------

-- Target Armor
function Ns.FunctionList.NPCArmor(HUD, data, options, ...)

	local targetArmorReduced = (Ns.targetArmor - Ns.sunderArmor - Ns.exposeArmor - Ns.faerieFire - Ns.curseOfReck - Ns.shatterArmor) or 0
	local returnText
	local debuffColor = ""

	if (Ns.sunderArmor or Ns.exposeArmor or Ns.faerieFire or Ns.curseOfReck or Ns.shatterArmor) > 0 then
		debuffColor = "|cff00f26d"
	end

	returnText = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, targetArmorReduced)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

------------------------------------------------

local racial_expertise = {
	Human = { [7] = 5, [8] = 5 },					-- one/two-handed swords
	Orc   = { [0] = 5, [1] = 5 },					-- one/two-handed axes
}
local EXPERTISE_PERCENT_PER_POINT = 0.25
local EXPERTISE_RATING_PER_POINT = { [60] = 2.34483, [70] = 3.69761 }

local function GetWeaponSubclass(slot)
	local itemID = GetInventoryItemID("player", slot)
	if not itemID then return nil end
	return select(13, C_Item.GetItemInfo(itemID))
end


local function GetRacialExpertise()
	local racial = racial_expertise[Ns.raceFile]
	if not racial then return 0, 0 end
	return racial[GetWeaponSubclass(16)] or 0, racial[GetWeaponSubclass(17)] or 0
end

local function IsExpertisePerPoint(value)
	return value and value > 1 and value < 10
end

local function GetExpertiseRatingPerPoint()
	local rating, bonus = GetCombatRating(CR_EXPERTISE), GetCombatRatingBonus(CR_EXPERTISE)
	if rating and rating > 0 and bonus and bonus > 0 then
		local perPoint = rating / bonus
		if not IsExpertisePerPoint(perPoint) then
			perPoint = rating / (bonus / EXPERTISE_PERCENT_PER_POINT)
		end
		if IsExpertisePerPoint(perPoint) then return perPoint end
	end

	local hitRating, hitBonus = GetCombatRating(CR_HIT_MELEE), GetCombatRatingBonus(CR_HIT_MELEE)
	if hitRating and hitRating > 0 and hitBonus and hitBonus > 0 then
		local perPoint = (hitRating / hitBonus) / 4
		if IsExpertisePerPoint(perPoint) then return perPoint end
	end

	local level = UnitLevel("player") or 70
	if level >= 70 then return EXPERTISE_RATING_PER_POINT[70] end
	if level <= 60 then return EXPERTISE_RATING_PER_POINT[60] end
	return EXPERTISE_RATING_PER_POINT[60] + (EXPERTISE_RATING_PER_POINT[70] - EXPERTISE_RATING_PER_POINT[60]) * (level - 60) / 10
end
------------------------------------------------

-- Expertise
function Ns.FunctionList.Expertise(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local expertisePercent, offhandExpertisePercent = GetExpertisePercent()
	local expRating = GetCombatRating(CR_EXPERTISE)

	if options.Exp_Add then
		local racialMH, racialOH = GetRacialExpertise()
		local flatExpertise = (Ns.expTalent or 0) + math.max(racialMH, racialOH)
		if flatExpertise > 0 then
			expRating = expRating + flatExpertise * GetExpertiseRatingPerPoint()
		end
	end
	expRating = math.floor(expRating + 0.5)

	local expPercent = 0
	local returnText
	local statusbar
	local decimals, liveExp
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end
	local capColor, endColor = "", ""
	if expRating >= options.Cap_Melee_Exp then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Ns.ohID and offhandExpertisePercent > 0 then
		offhandExpertisePercent = "/" .. (decimals):format(offhandExpertisePercent)
	else
		offhandExpertisePercent = ""
	end
 
	if options.Display_Simulate then liveExp = " > " .. (decimals):format(Ns.totalParryDodge)
	else liveExp = "" end	

	if Ns.Band(EB, Percentage) then returnText = capColor .. (decimals):format(expertisePercent) .. offhandExpertisePercent .. "%" .. endColor .. liveExp; statusbar = expRating end
	if Ns.Band(EB, Rating) then returnText = capColor .. expRating .. endColor .. liveExp; statusbar = expRating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(expertisePercent) .. offhandExpertisePercent .. "%/" .. expRating .. endColor .. liveExp; statusbar = expRating end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Damage Reduction
function Ns.FunctionList.BossReduc(HUD, data, options, ...)

	local targetArmorReduced = (Ns.targetArmor - Ns.sunderArmor - Ns.exposeArmor - Ns.faerieFire - Ns.curseOfReck - Ns.shatterArmor) or 0
	local damageReduction = (targetArmorReduced / ((467.5 * Ns.targetLevel) + targetArmorReduced - 22167.5)) * 100
	local returnText
	local debuffColor, valueSign = "", ""
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end

	if options.Color_Effect and (Ns.sunderArmor or Ns.exposeArmor or Ns.faerieFire or Ns.curseOfReck or Ns.shatterArmor) > 0 then
		debuffColor = "|cff00f26d"
	end
		if damageReduction < 0 then
			damageReduction = math.abs(damageReduction)
			valueSign = "+"
		end

		returnText = debuffColor .. valueSign .. (decimals):format(damageReduction)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Miss
function Ns.FunctionList.MeleeMiss(HUD, data, options, ...)

	local EB = options.Level_Same_Boss
	local meleeSameLevel = 0
	local meleeBossLevel = 0
	local mainBase, mainMod, offBase, offMod = UnitAttackBothHands("player")
	local levelDefense = Ns.playerLevel * 5
	local levelDiffDef = 0
	levelDiffDef = Ns.targetLevel - Ns.playerLevel
	local liveDefense = Ns.playerLevel * 5
	local bossDefense = (Ns.playerLevel + levelDiffDef) * 5
	local mWeaponSkill = (mainBase + mainMod)
	local returnText
	local decimals, liveMiss
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	local meleeSkillDiff = liveDefense - mWeaponSkill
	local bossSkillDiff = bossDefense - mWeaponSkill
	local bossSkillMod = bossDefense - mWeaponSkill
	Ns.missMod = 0
	local missModboss = 0
	local itemType = 0

	missModboss = meleeBossLevel

	if Ns.ohID then
		_,_,_,_,_,itemType = C_Item.GetItemInfo(Ns.ohID)
	end

	if (Ns.mhID and (Ns.ohID and itemType == Ns.weaponTag)) or (not Ns.mhID and (itemType == Ns.weaponTag)) then
		if (Ns.classFilename == "WARRIOR") or (Ns.classFilename == "ROGUE") or (Ns.classFilename == "HUNTER") then
			if meleeSkillDiff > 10 then
				meleeSameLevel = (26 + ((meleeSkillDiff - 10) * 0.4))
				meleeSameLevel = meleeSameLevel - Ns.hitChance
			elseif meleeSkillDiff <= 10 then
				meleeSameLevel = (24 + ((meleeSkillDiff) * 0.1))
				meleeSameLevel = meleeSameLevel - Ns.hitChance
			end

			if bossSkillDiff > 10 then
				meleeBossLevel = (26 + ((bossSkillDiff - 10) * 0.4))
				meleeBossLevel = meleeBossLevel - Ns.hitChance
				Ns.missMod = (26 + ((bossSkillMod - 10) * 0.4))
				Ns.missMod = Ns.missMod - Ns.hitChance
			elseif bossSkillDiff <= 10 then
				meleeBossLevel = (24 + ((bossSkillDiff) * 0.1))
				meleeBossLevel = meleeBossLevel - Ns.hitChance
				Ns.missMod = (26 + ((bossSkillMod - 10) * 0.4))
				Ns.missMod = Ns.missMod - Ns.hitChance
			end
		end

	elseif (Ns.mhID and (Ns.ohID and itemType ~= Ns.weaponTag)) or (not Ns.mhID and (itemType ~= Ns.weaponTag)) or (Ns.mhID and not Ns.ohID) or (not Ns.mhID and not Ns.ohID) then
		if Ns.druidFormChk() then
			meleeSameLevel = 5 - Ns.hitChance
			meleeBossLevel = 9 - Ns.hitChance
		else
			if meleeSkillDiff > 10 then
				meleeSameLevel = (7 + ((meleeSkillDiff - 10) * 0.4))
				meleeSameLevel = meleeSameLevel - Ns.hitChance
			elseif meleeSkillDiff <= 10 then
				meleeSameLevel = (5 + ((meleeSkillDiff) * 0.1))
				meleeSameLevel = meleeSameLevel - Ns.hitChance
			end

			if bossSkillDiff > 10 then
				meleeBossLevel = (7 + ((bossSkillDiff - 10) * 0.4))
				meleeBossLevel = meleeBossLevel - Ns.hitChance
				Ns.missMod = (7 + ((bossSkillMod - 10) * 0.4))
				Ns.missMod = Ns.missMod - Ns.hitChance
			elseif bossSkillDiff <= 10 then
				meleeBossLevel = (5 + ((bossSkillDiff) * 0.1))
				meleeBossLevel = meleeBossLevel - Ns.hitChance
				Ns.missMod = (5 + ((bossSkillMod - 10) * 0.1))
				Ns.missMod = Ns.missMod - Ns.hitChance
			end
		end

	end

	if meleeSameLevel < 0 then
		meleeSameLevel = 0
	elseif meleeSameLevel > 100 then
		meleeSameLevel = 100
	end
	if meleeBossLevel < 0 then
		meleeBossLevel = 0
	elseif meleeBossLevel > 100 then
		meleeBossLevel = 100
	end

	local statusbar

	if options.Display_Simulate then liveMiss = " > " .. (decimals):format(Ns.meleeMissTracker)
	else liveMiss = "" end	

	if Ns.Band(EB, SameLevel) then returnText = (decimals):format(meleeSameLevel) .. "%" .. liveMiss; statusbar = meleeSameLevel end
	if Ns.Band(EB, BossLevel) then returnText = (decimals):format(meleeBossLevel) .. "%" .. liveMiss; statusbar = meleeBossLevel end
	if Ns.Band(EB, Both) then returnText = (decimals):format(meleeSameLevel) .. "%" .. " / " .. (decimals):format(meleeBossLevel) .. "%" .. liveMiss; statusbar = meleeSameLevel end

	statusbar = math.max(0, 100 - (statusbar or 0))

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------
