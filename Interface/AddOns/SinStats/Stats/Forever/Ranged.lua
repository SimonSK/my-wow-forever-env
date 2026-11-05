---@diagnostic disable: unbalanced-assignments
local AddName, Ns = ...
local L = Ns.L
local issecretvalue = Ns.issecretvalue
local Safe = Ns.Safe

------------------------------
--		Options Equates		--
------------------------------
local Both, SameLevel, BossLevel, Max, Average, Enhanced, Base = 3, 1, 2, 1, 2, 1, 2

------------------------------
--		Weapon Skill		--
------------------------------

local RANGED_SKILL_ID = {
	[Enum.ItemWeaponSubclass.Bows] = 45,
	[Enum.ItemWeaponSubclass.Guns] = 46,
	[Enum.ItemWeaponSubclass.Crossbow] = 226,
	[Enum.ItemWeaponSubclass.Thrown] = 176,
	[Enum.ItemWeaponSubclass.Wand] = 228,
}

local function GetRangedWeaponSkill()
	if UnitRangedAttack then
		local base, mod = UnitRangedAttack("player")
		if base ~= nil and not issecretvalue(base) and (mod == nil or not issecretvalue(mod)) then
			return base + (mod or 0)
		end
	end

	local itemID = GetInventoryItemID("player", INVSLOT_RANGED)
	if not itemID then return (Ns.playerLevel or 0) * 5 end

	local _, _, _, _, _, classID, subclassID = C_Item.GetItemInfoInstant(itemID)
	local skillID = classID == Enum.ItemClass.Weapon and RANGED_SKILL_ID[subclassID]
	if not skillID then return (Ns.playerLevel or 0) * 5 end

	local skillInfo = C_SkillInfo.GetSkillLineInfoByID(skillID)
	if skillInfo then return skillInfo.rank + skillInfo.modifier end
	return (Ns.playerLevel or 0) * 5
end

------------------------------
--		Global Updater		--
------------------------------

Ns.speed, Ns.lowDmg, Ns.hiDmg, Ns.critRanged, Ns.gunEquipped, Ns.hitRanged, Ns.posBuff, Ns.negBuff = 0, 0, 0, 0, 0, 0, 0, 0

function Ns.RangedUpdate()

 	Ns.targetLevel = Ns.playerLevel + 3
	if UnitCanAttack("player", "target") then
		Ns.targetLevel = UnitLevel("target")
		if Ns.targetLevel <= 0 then
			Ns.targetLevel = Ns.playerLevel + 3
		end
	end

	-- Attack Speed
	Ns.speed, Ns.lowDmg, Ns.hiDmg, Ns.posBuff, Ns.negBuff = UnitRangedDamage("player")

end

-- Attack Power
local cachedRangedAP = 0

function Ns.FunctionList.RAP(HUD, data, options, ...)

	local EB = options.Enhanced_Base or 1
	local base, posBuff, negBuff = UnitRangedAttackPower("player");
	local baseRangedAP = base
	local rangedAttack
	local BuffColor = ""
	local returnText

	if not issecretvalue(base) and not issecretvalue(posBuff) and not issecretvalue(negBuff) then
		rangedAttack = base + posBuff + negBuff + Ns.huntersMark + Ns.exposeWeakness
		cachedRangedAP = rangedAttack
	else
		rangedAttack = cachedRangedAP ~= 0 and cachedRangedAP or base
	end

	if (Ns.huntersMark > 0) then
		BuffColor = Ns.greenText
	end
	if negBuff ~= nil and not issecretvalue(negBuff) and negBuff < 0 then
		BuffColor = Ns.redText
	end

	if Ns.Band(EB, Both) then
		returnText = BuffColor .. Ns.DecimalNumber(options.Decimals_Default, rangedAttack) .. "|r (" .. Ns.DecimalNumber(options.Decimals_Default, baseRangedAP) .. ")"
	elseif Ns.Band(EB, Base) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, baseRangedAP)
	else
		returnText = BuffColor .. Ns.DecimalNumber(options.Decimals_Default, rangedAttack)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Attack Power vs Undead
local cachedRangedAPUD = 0

function Ns.FunctionList.RAPUD(HUD, data, options, ...)

	local udTrinket = 0
	local markTrinket = 0
	local mhEnchant = 0
	local ohEnchant = 0
	local slayerSet = 0
	local trinketCheck = GetInventoryItemID("player", 13)
	local trinketCheck2 = GetInventoryItemID("player", 14)
	local glovesCheck = GetInventoryItemID("player", 10)
	local bracersCheck = GetInventoryItemID("player", 9)
	local chestCheck = GetInventoryItemID("player", 5)
	local mainHandEnchant = C_PaperDollInfo.GetTemporaryEnchantmentInfo(INVSLOT_MAINHAND)
	local offHandEnchant = C_PaperDollInfo.GetTemporaryEnchantmentInfo(INVSLOT_OFFHAND)
	local mainHandEnchantID = mainHandEnchant and mainHandEnchant.enchantID
	local offHandEnchantId = offHandEnchant and offHandEnchant.enchantID
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

	local base, posBuff, negBuff = UnitRangedAttackPower("player")
	local undeadrAP
	if not issecretvalue(base) and not issecretvalue(posBuff) and not issecretvalue(negBuff) then
		undeadrAP = base + posBuff + negBuff + mhEnchant + ohEnchant + udTrinket + markTrinket + slayerSet + Ns.huntersMark + Ns.exposeWeakness
		cachedRangedAPUD = undeadrAP
	else
		undeadrAP = cachedRangedAPUD ~= 0 and cachedRangedAPUD or base
	end

	HUD:UpdateText(data, Ns.DecimalNumber(options.Decimals_Default, undeadrAP))
end
------------------------------------------------

-- Attack Speed
function Ns.FunctionList.rangedSpeed(HUD, data, options, ...)

	HUD:UpdateText(data, Ns.DecimalFormat(options.Decimals_Two):format(Ns.speed))
end
------------------------------------------------

-- Damage
function Ns.FunctionList.RDMG(HUD, data, options, ...)

	local EB = options.Max_Average_Damage
	local hiDmg = Ns.hiDmg
	local avgDamage = hiDmg
	local maxDisplay = hiDmg
	local avgDisplay

	if not issecretvalue(hiDmg) then
		avgDamage = hiDmg / 2
		maxDisplay = math.floor(hiDmg + 1)
	end
	avgDisplay = avgDamage
	if not issecretvalue(avgDamage) then
		avgDisplay = math.floor(avgDamage + 1)
	end

	local returnText

	if Ns.Band(EB, Max) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, maxDisplay)
	end
	if  Ns.Band(EB, Average) then
        returnText = returnText and (returnText .. "/") or ""
		returnText = returnText .. Ns.DecimalNumber(options.Decimals_Default, avgDisplay)
	end

	if returnText == nil then
		returnText = ""
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- DPS
-- Forever: UnitRangedDamage turns secret in restricted content; DPS needs arithmetic, so cache it
local cachedRangedDPS, cachedRangedAvgDPS = 0, 0

function Ns.FunctionList.rDPS(HUD, data, options, ...)

	local EB = options.Max_Average_Damage
	local maxDamage = Ns.hiDmg
	local lowDamage = Ns.lowDmg
	local speed = Ns.speed
	local maxDPS = 0
	local avgDPS = 0
	local BuffColor = ""
	local returnText

	if not issecretvalue(speed) and not issecretvalue(maxDamage) and not issecretvalue(lowDamage) and speed ~= 0 then
		avgDPS = (maxDamage + lowDamage / 2) / speed
		maxDPS = (maxDamage / speed)
		cachedRangedDPS, cachedRangedAvgDPS = maxDPS, avgDPS
	else
		maxDPS, avgDPS = cachedRangedDPS, cachedRangedAvgDPS
	end

	if Ns.negBuff ~= nil and not issecretvalue(Ns.negBuff) and Ns.negBuff < 0 then
		BuffColor = Ns.redText
	end

	if Ns.Band(EB, Max) then returnText = BuffColor .. Ns.DecimalNumber(options.Decimals_Default, math.floor(maxDPS)) end
	if Ns.Band(EB, Average) then
        returnText = returnText and (returnText .. "/") or ""
		returnText = returnText .. Ns.DecimalNumber(options.Decimals_Default, math.floor(avgDPS))
	end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critcal
function Ns.FunctionList.RangedCrit(HUD, data, options, ...)

	local EB = options.Level_Same_Boss
	local critRanged = GetRangedCritChance()
	local levelDifference = 0
	local critAura = 1.8
	local critBoss = critRanged
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

	critBoss = critRanged

	local cap = options.Cap_Percent or 100
	if not issecretvalue(critRanged) then
		critBoss = critRanged - levelDifference - critAura
		if critBoss < 0 then
			critBoss = 0
		end
		if critRanged < 0 then
			critRanged = 0
		end
	end
	if cap > 0 and Safe(critRanged) >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	if Ns.Band(EB, SameLevel) then
		returnText = capColor .. (decimals):format(critRanged); statusbar = critRanged
	end
	if Ns.Band(EB, BossLevel) then
		returnText = capColor .. (decimals):format(critBoss); statusbar = critBoss
	end
	if Ns.Band(EB, Both) then
		returnText = capColor .. (decimals):format(critRanged) .. "|r (" .. (decimals):format(critBoss) .. ")"; statusbar = critRanged
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Haste
function Ns.FunctionList.HasteRanged(HUD, data, options, ...)

	local EB = options.Enhanced_Base or 1
	local capColor = ""
	local haste = Ns.totalRangedHaste
	local statusbar = haste
	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	local cap = options.Cap_Percent or 100
	if cap > 0 and Safe(haste) >= cap then capColor = Ns.greenText end
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

-- Hit
function Ns.FunctionList.RangedHit(HUD, data, options, ...)

	local EB = options.Enhanced_Base or 1
	local hitRangedChance = 0
	local capColor = ""
	local statusbar = 0
	local returnText

	if (Ns.classFilename == "HUNTER") then
		local slotId = GetInventorySlotInfo("RangedSlot")
		local link = GetInventoryItemLink("player", slotId)
		if link then
			hitRangedChance = GetHitModifier()
			if hitRangedChance == nil then
				hitRangedChance = 0
			end
			local itemId, enchantId = link:match("item:(%d+):(%d+)")
			if enchantId then
				enchantId = tonumber(enchantId)
				if enchantId == 2523 and not issecretvalue(hitRangedChance) then
					hitRangedChance = hitRangedChance + 3
				end
			end
		end
	else
		hitRangedChance = GetHitModifier()
		if hitRangedChance == nil then hitRangedChance = 0 end
	end

	local cap = options.Cap_Percent or 9
	if cap > 0 and Safe(hitRangedChance) >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	local baseHit = hitRangedChance
	local enhancedHit = hitRangedChance
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

-- Miss
function Ns.FunctionList.RangedMiss(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")
	local capColor = ""
	local statusbar = 0

	local rangedMissLevel = 0
	local rangedMissBoss = 0
	local rWeaponSkill = GetRangedWeaponSkill()
	local levelDiffDef = Ns.targetLevel - Ns.playerLevel
	local levelDefense = Ns.playerLevel * 5
	local bossDefense = (Ns.playerLevel + levelDiffDef) * 5
	local rangedSkillDiff = levelDefense - rWeaponSkill
	local rbossSkillDiff = bossDefense - rWeaponSkill

	if rangedSkillDiff > 10 then
		rangedMissLevel = (7 + ((rangedSkillDiff - 10) * 0.4))
		rangedMissLevel = rangedMissLevel - Ns.hitRanged
	elseif rangedSkillDiff <= 10 then
		rangedMissLevel = (5 + ((rangedSkillDiff) * 0.1))
		rangedMissLevel = rangedMissLevel - Ns.hitRanged
	end

	if rbossSkillDiff > 10 then
		rangedMissBoss = (7 + ((rbossSkillDiff - 10) * 0.4))
		rangedMissBoss = rangedMissBoss - Ns.hitRanged
	elseif rbossSkillDiff <= 10 then
		rangedMissBoss = (5 + ((rbossSkillDiff) * 0.1))
		rangedMissBoss = rangedMissBoss - Ns.hitRanged
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

	if Ns.Band(EB, SameLevel) then
		enhancedStat = rangedMissLevel
	end
	if  Ns.Band(EB, BossLevel) then
		baseStat = rangedMissBoss
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

