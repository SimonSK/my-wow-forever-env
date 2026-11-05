local AddName, Ns = ...
local L = Ns.L

------------------------------
--		Options Equates		--
------------------------------
local Both, MainHand, OffHand, SameLevel, BossLevel, Auto, Enhanced, Base = 3, 1, 2, 1, 2, 3, 1, 2

------------------------------
--		Global Updater		--
------------------------------

Ns.missMod, Ns.meleeSameLevel, Ns.meleeBossLevel = 0,0,0

function Ns.MeleeUpdate()

 	Ns.targetLevel = Ns.playerLevel + 3
	if UnitCanAttack("player", "target") then
		Ns.targetLevel = UnitLevel("target")
		if Ns.targetLevel <= 0 then
			Ns.targetLevel = Ns.playerLevel + 3
		end
	end

	-- Miss
	Ns.meleeSameLevel = 0
	Ns.meleeBossLevel = 0
	local mainBase, mainMod = UnitAttackBothHands("player")
	local levelDiffDef = 0
	levelDiffDef = Ns.targetLevel - Ns.playerLevel
	local liveDefense = Ns.playerLevel * 5
	local bossDefense = (Ns.playerLevel + levelDiffDef) * 5
	local mWeaponSkill = (mainBase + mainMod)
	local meleeSkillDiff = liveDefense - mWeaponSkill
	local bossSkillDiff = bossDefense - mWeaponSkill
	local bossSkillMod = bossDefense - mWeaponSkill
	Ns.missMod = 0
	local _, isOffHand = UnitAttackSpeed("player")
	local hitChance = GetHitModifier()
	if hitChance == nil then
		hitChance = 0
	end

	if isOffHand ~= nil then
		if meleeSkillDiff > 10 then
			Ns.meleeSameLevel = (26 + ((meleeSkillDiff - 10) * 0.4))
			Ns.meleeSameLevel = Ns.meleeSameLevel - hitChance
		elseif meleeSkillDiff <= 10 then
			Ns.meleeSameLevel = (24 + ((meleeSkillDiff) * 0.1))
			Ns.meleeSameLevel = Ns.meleeSameLevel - hitChance
		end
		if bossSkillDiff > 10 then
			Ns.meleeBossLevel = (26 + ((bossSkillDiff - 10) * 0.4))
			Ns.meleeBossLevel = Ns.meleeBossLevel - hitChance
			Ns.missMod = (26 + ((bossSkillMod - 10) * 0.4))
			Ns.missMod = Ns.missMod - hitChance
		elseif bossSkillDiff <= 10 then
			Ns.meleeBossLevel = (24 + ((bossSkillDiff) * 0.1))
			Ns.meleeBossLevel = Ns.meleeBossLevel - hitChance
			Ns.missMod = (26 + ((bossSkillMod - 10) * 0.4))
			Ns.missMod = Ns.missMod - hitChance
		end
	else
		if Ns.shapeshitCheck() then
			Ns.meleeSameLevel = 5 - hitChance
			Ns.meleeBossLevel = 9 - hitChance
		else
			if meleeSkillDiff > 10 then
				Ns.meleeSameLevel = (7 + ((meleeSkillDiff - 10) * 0.4))
				Ns.meleeSameLevel = Ns.meleeSameLevel - hitChance
			elseif meleeSkillDiff <= 10 then
				Ns.meleeSameLevel = (5 + ((meleeSkillDiff) * 0.1))
				Ns.meleeSameLevel = Ns.meleeSameLevel - hitChance
			end
			if bossSkillDiff > 10 then
				Ns.meleeBossLevel = (7 + ((bossSkillDiff - 10) * 0.4))
				Ns.meleeBossLevel = Ns.meleeBossLevel - hitChance
				Ns.missMod = (7 + ((bossSkillMod - 10) * 0.4))
				Ns.missMod = Ns.missMod - hitChance
			elseif bossSkillDiff <= 10 then
				Ns.meleeBossLevel = (5 + ((bossSkillDiff) * 0.1))
				Ns.meleeBossLevel = Ns.meleeBossLevel - hitChance
				Ns.missMod = (5 + ((bossSkillMod - 10) * 0.1))
				Ns.missMod = Ns.missMod - hitChance
			end
		end
	end

	if Ns.meleeSameLevel < 0 then
		Ns.meleeSameLevel = 0
	elseif Ns.meleeSameLevel > 100 then
		Ns.meleeSameLevel = 100
	end
	if Ns.meleeBossLevel < 0 then
		Ns.meleeBossLevel = 0
	elseif Ns.meleeBossLevel > 100 then
		Ns.meleeBossLevel = 100
	end

end
------------------------------------------------

-- Attack Power
function Ns.FunctionList.AP(HUD, data, options, ...)

	local base, posBuff, negBuff = UnitAttackPower("player")
	local attackPower = base + posBuff + negBuff
	local debuffColor = ""

	if negBuff < 0 then
		debuffColor = Ns.redText
	end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalNumber(options.Decimals_Default, attackPower))
end
------------------------------------------------

-- Attack Power vs Undead
function Ns.FunctionList.APUD(HUD, data, options, ...)

	local udTrinket = 0
	local markTrinket = 0
	local mhEnchant = 0
	local ohEnchant = 0
	local slayerSet = 0
	local trinketCheck = GetInventoryItemID("player", 13);
	local trinketCheck2 = GetInventoryItemID("player", 14);
	local glovesCheck = GetInventoryItemID("player", 10);
	local bracersCheck = GetInventoryItemID("player", 9);
	local chestCheck = GetInventoryItemID("player", 5);
	local _, _, _, mainHandEnchantID, _, _, _, offHandEnchantId  = GetWeaponEnchantInfo()
	if trinketCheck == 13209 or trinketCheck2 == 13209 then
		udTrinket = 81
	end
	if trinketCheck == 23206 or trinketCheck2 == 23206 then
		markTrinket = 150
	end
	if (mainHandEnchantID == 2684) then
		mhEnchant = 100
	end
	if (offHandEnchantId == 2684) then
		ohEnchant = 100
	end
	if glovesCheck == 23078 or glovesCheck == 23081 then
		slayerSet = slayerSet + 60
	end
	if bracersCheck == 23093 or bracersCheck == 23090 then
		slayerSet = slayerSet + 45
	end
	if chestCheck == 23087 or chestCheck == 23089 then
		slayerSet = slayerSet + 81
	end

	local base, posBuff, negBuff = UnitAttackPower("player")
	local undeadAP = base + posBuff + negBuff + mhEnchant + ohEnchant + udTrinket + markTrinket + slayerSet

	HUD:UpdateText(data, Ns.DecimalNumber(options.Decimals_Default, undeadAP))
end
------------------------------------------------

-- Damage
function Ns.FunctionList.DMG(HUD, data, options, ...)

	local EB = options.Main_Off_Auto
	local lowDmg, hiDmg, offlowDmg, offhiDmg, _, negBuff, _ = UnitDamage("player")
	local ohID = GetInventoryItemID("player", 17)
	local maxDamage = hiDmg
	local lowDamage = lowDmg
	local maxDamageOH = offhiDmg
	local lowDamageOH = offlowDmg
	local debuffColor = ""
	local returnText
	local classId = 0

	if ohID then classId = select(12, GetItemInfo(ohID))
	end

	if options.Display_Average then
		maxDamage = (maxDamage + lowDamage) / 2
		maxDamageOH = (maxDamageOH + lowDamageOH) / 2
	end

	local maxDamageAlt = maxDamageOH

	if classId == Ns.weaponID then
		maxDamageOH = "/" .. Ns.DecimalNumber(options.Decimals_Default, math.floor(maxDamageOH))
	else
		maxDamageOH = ""
	end

	 if negBuff < 0 then
		debuffColor = Ns.redText
	end

	if Ns.Band(EB, MainHand) then
		returnText = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, math.floor(maxDamage))
	end
	if  Ns.Band(EB, OffHand) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, math.floor(maxDamageAlt))
	end
	if Ns.Band(EB, Auto) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, math.floor(maxDamage)) .. maxDamageOH
	end

	if returnText == nil then
		returnText = ""
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- DPS
function Ns.FunctionList.mDPS(HUD, data, options, ...)

	local EB = options.Main_Off_Auto
	local lowDmg, hiDmg, offlowDmg, offhiDmg, _, negBuff, _ = UnitDamage("player")
	local ohID = GetInventoryItemID("player", 17)
	local mainSpeed= UnitAttackSpeed("player")
	local maxDamage = hiDmg
	local lowDamage = lowDmg
	local maxDamageOH = offhiDmg
	local lowDamageOH = offlowDmg
	local DPS = 0
	local DPSOH = 0
	local debuffColor = ""
	local classId = 0
	local returnText

	if ohID then classId = select(12, GetItemInfo(ohID)) end

	if options.Display_Average then
		maxDamage = (maxDamage + lowDamage) / 2
		maxDamageOH = (maxDamageOH + lowDamageOH) / 2
	end

	if mainSpeed ~= 0 then
	DPS = ((lowDamage + maxDamage) / 2) / mainSpeed
	DPSOH = ((lowDamageOH + maxDamageOH) / 2) / mainSpeed
	end

	local DPSOH2 = DPSOH

	if classId == Ns.weaponID then
		DPSOH = "/" .. Ns.DecimalNumber(options.Decimals_Default, math.floor(DPSOH+1))
	else
		DPSOH = ""
	end

	if negBuff < 0 then debuffColor = Ns.redText end

	if Ns.Band(EB, MainHand) then returnText = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, math.floor(DPS+1)) end
	if Ns.Band(EB, OffHand) then returnText = Ns.DecimalNumber(options.Decimals_Default, math.floor(DPSOH2+1)) end
	if Ns.Band(EB, Auto) then returnText = Ns.DecimalNumber(options.Decimals_Default, math.floor(DPS+1)) .. DPSOH end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critical
function Ns.FunctionList.Crit(HUD, data, options, ...)

	local EB = options.Level_Same_Boss
	local critChance = GetCritChance()
	local critBoss = critChance
	local levelDifference = 0
	local critAura = 0
	local capColor = ""
	local statusbar = 0
	local returnText
	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")
	levelDifference = Ns.targetLevel - Ns.playerLevel

	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	elseif levelDifference >= 3 then
		critAura = 1.8
	end
	critBoss = critBoss - levelDifference - critAura

	if critChance < 0 then
		critChance = 0
	end
	if critBoss < 0 then
		critBoss = 0
	end

	local cap = options.Cap_Percent or 100
	if cap > 0 and critChance >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	if Ns.Band(EB, SameLevel) then
		returnText = capColor .. (decimals):format(critChance); statusbar = critChance
	end
	if  Ns.Band(EB, BossLevel) then
		returnText = capColor .. (decimals):format(critBoss); statusbar = critBoss
	end
	if  Ns.Band(EB, Both) then
		returnText = capColor .. (decimals):format(critChance) .. "|r (" .. (decimals):format(critBoss) .. ")"; statusbar = critChance
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Critical Cap
function Ns.FunctionList.CritCap(HUD, data, options, ...)

	local ohID = GetInventoryItemID("player", 17)
	local classId = 0
	if ohID then classId = select(12, GetItemInfo(ohID))
	end

	local mainBase, mainMod, offBase, offMod = UnitAttackBothHands("player")
	local mWeaponSkill = (mainBase + mainMod)

	if classId == Ns.weaponID then
		mWeaponSkill = math.min((mainBase + mainMod), (offBase + offMod))
	end

	local critChance = GetCritChance()
	local skillDiff = 315 - mWeaponSkill
	local critSupp = 4.8
	local dodgeBoss = 5 + (skillDiff * 0.1)
	local glancingBoss = 40
	local extraWeaponSkill = mWeaponSkill - 300
	local mcritCap = 100 - Ns.missMod - dodgeBoss - glancingBoss + critSupp + (extraWeaponSkill * 0.04)
	local debuffColor = ""

	if critChance < 0 then
		critChance = 0
	end

	if critChance > mcritCap then
		debuffColor = Ns.redText
	elseif critChance == mcritCap then
		debuffColor = Ns.orangeText
	else
		debuffColor = Ns.greenText
	end

	if mcritCap > 100 then
		mcritCap = 100
	elseif mcritCap < 0 then
		mcritCap = 0
	end

	HUD:UpdateText(data, debuffColor .. Ns.DecimalFormat(options.Decimals_Two, "%%"):format(mcritCap))
	HUD:UpdateBar(data, critChance, mcritCap)
end
------------------------------------------------

-- Hit
function Ns.FunctionList.Hit(HUD, data, options, ...)

	local EB = options.Enhanced_Base or 1
	local hitChance = GetHitModifier()
	local capColor = ""
	local statusbar = 0

	if hitChance == nil then
		hitChance = 0
	end

	local cap = options.Cap_Percent or 9
	if cap > 0 and hitChance >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	local baseHit = hitChance
	local enhancedHit = hitChance
	local returnText
	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Ns.Band(EB, Both) then
		returnText = capColor .. (decimals):format(enhancedHit) .. "|r (" .. (decimals):format(baseHit) .. ")"; statusbar = enhancedHit
	elseif Ns.Band(EB, Base) then
		returnText = capColor .. (decimals):format(baseHit); statusbar = baseHit
	else
		returnText = capColor .. (decimals):format(enhancedHit); statusbar = enhancedHit
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Haste
function Ns.FunctionList.HasteMelee(HUD, data, options, ...)

	local EB = options.Enhanced_Base or 1
	local capColor = ""
	local haste = Ns.totalHaste
	local statusbar = haste
	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	local cap = options.Cap_Percent or 100
	if cap > 0 and haste >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	local returnText

	if Ns.Band(EB, Both) then
		returnText = capColor .. (decimals):format(haste) .. "|r (" .. (decimals):format(haste) .. ")"
	elseif Ns.Band(EB, Base) then
		returnText = capColor .. (decimals):format(haste)
	else
		returnText = capColor .. (decimals):format(haste)
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Attack Speed
function Ns.FunctionList.weaponSpeed(HUD, data, options, ...)

	local EB = options.Main_Off_Auto
	local mainSpeed, offSpeed = UnitAttackSpeed("player")
	local ohID = GetInventoryItemID("player", 17)
	local returnText
	local decimals = Ns.DecimalFormat(options.Decimals_Two)

	if offSpeed == nil then
		offSpeed = 0
	end

	local offHandSpeed = offSpeed
	local offHandAuto = offSpeed
	local classId = 0

	if ohID then classId = select(12, GetItemInfo(ohID))
	end

	if classId == Ns.weaponID then offHandSpeed = "/" .. (decimals):format(offHandSpeed)
	else offHandSpeed = "" end

	if Ns.Band(EB, MainHand) then returnText = (decimals):format(mainSpeed) end
	if Ns.Band(EB, OffHand) then returnText = (decimals):format(offHandAuto) end
	if Ns.Band(EB, Auto) then returnText = (decimals):format(mainSpeed) .. offHandSpeed end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Miss
function Ns.FunctionList.MeleeMiss(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")
	local capColor = ""
	local statusbar = 0

	if Ns.Band(EB, SameLevel) then
		enhancedStat = Ns.meleeSameLevel
	end
	if  Ns.Band(EB, BossLevel) then
		baseStat = Ns.meleeBossLevel
	end

	local missValue = enhancedStat or baseStat or 0
	local cap = options.Cap_Percent or 0
	if cap > 0 and missValue <= cap then capColor = Ns.greenText end
	if cap == 0 and missValue <= 0 then capColor = Ns.greenText end

	statusbar = math.max(0, 100 - missValue)

	local returnText
	if Ns.Band(EB, Both) then
		returnText = capColor .. (decimals):format(enhancedStat and enhancedStat or baseStat) .. "/" .. (decimals):format(baseStat)
	else
		returnText = capColor .. (decimals):format(enhancedStat and enhancedStat or baseStat)
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

