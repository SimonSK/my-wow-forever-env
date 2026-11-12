---@diagnostic disable: unbalanced-assignments
local AddName, Ns = ...
local L = Ns.L
local issecretvalue = Ns.issecretvalue
local Safe = Ns.Safe

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, SameLevel, BossLevel, Casting = 3, 1, 2, 1, 2, 2

local function AnySecret(...)
	for i = 1, select("#", ...) do
		if issecretvalue((select(i, ...))) then return true end
	end
	return false
end

local cachedSpellCrit = 0
local cachedSpellCritBoss = 0

------------------------------
--		Global Updater		--
------------------------------

Ns.hitSpellChance, Ns.hitSpellGear, Ns.regenBase, Ns.regenCasting, Ns.regenBaseBasic, Ns.regenCastingBasic  = 0, 0, 0, 0, 0, 0
Ns.healSpell, Ns.holySpell, Ns.natureSpell, Ns.shadowSpell, Ns.fireSpell, Ns.frostSpell, Ns.arcaneSpell = 0, 0, 0, 0, 0, 0, 0


function Ns.SpellUpdate()

 	Ns.targetLevel = Ns.playerLevel + 3
	if UnitCanAttack("player", "target") then
		Ns.targetLevel = UnitLevel("target")
		if Ns.targetLevel <= 0 then
			Ns.targetLevel = Ns.playerLevel + 3
		end
	end

	local spirit = UnitStat("player", 5)
	if not issecretvalue(spirit) then
		Ns.spirit = spirit
	end

	-- Spell Power
	local healSpell = GetSpellBonusHealing()
	local holySpell = GetSpellBonusDamage(2)
	local natureSpell = GetSpellBonusDamage(4)
	local shadowSpell = GetSpellBonusDamage(6)
	local fireSpell = GetSpellBonusDamage(3)
	local frostSpell = GetSpellBonusDamage(5)
	local arcaneSpell = GetSpellBonusDamage(7)
	local hitSpellRating = GetCombatRatingBonus(8)
	local hitSpellGear = GetSpellHitModifier()

	-- Forever: these values are secret in restricted content; keep the last readable totals (cache)
	if AnySecret(healSpell, holySpell, natureSpell, shadowSpell, fireSpell, frostSpell, arcaneSpell, hitSpellRating, hitSpellGear) then
		return
	end

	healSpell = healSpell or 0
	holySpell = holySpell or 0
	natureSpell = natureSpell or 0
	shadowSpell = shadowSpell or 0
	fireSpell = fireSpell or 0
	frostSpell = frostSpell or 0
	arcaneSpell = arcaneSpell or 0

	Ns.healSpell = healSpell + (healSpell * Ns.spiritualHealing) + (healSpell * Ns.purification)
	Ns.holySpell = (holySpell + (holySpell * Ns.dmfbuff) + (holySpell * Ns.silithyst) + (holySpell * Ns.sancAura) + (holySpell * Ns.vengeance))
	Ns.natureSpell = (natureSpell + (natureSpell * Ns.dmfbuff) + (natureSpell * Ns.silithyst))
	Ns.shadowSpell = (shadowSpell + (shadowSpell * Ns.shadowMastery) + (shadowSpell * Ns.DarkNessTalent) + (shadowSpell * Ns.dsSuc) + (shadowSpell * Ns.dmfbuff) + (shadowSpell * Ns.silithyst) + (shadowSpell * Ns.shadowFormDmg))
	Ns.fireSpell = (fireSpell + (fireSpell * Ns.firepowerMod) + (fireSpell * Ns.aiMod) + (fireSpell * Ns.emberstorm) + (fireSpell * Ns.dsImp) + (fireSpell * Ns.dmfbuff) + (fireSpell * Ns.silithyst) + (fireSpell * Ns.arcanePower))
	Ns.frostSpell = (frostSpell + (frostSpell * Ns.pierceMod) + (frostSpell * Ns.aiMod) + (frostSpell * Ns.dmfbuff) + (frostSpell * Ns.silithyst) + (frostSpell * Ns.arcanePower))
	Ns.arcaneSpell = (arcaneSpell + (arcaneSpell * Ns.aiMod) + (arcaneSpell * Ns.dmfbuff) + (arcaneSpell * Ns.silithyst) + (arcaneSpell * Ns.arcanePower))

	-- Hit
	if hitSpellRating == nil or hitSpellGear == nil then
		Ns.hitSpellChance = 0
		Ns.hitSpellGear = 0
	else
		Ns.hitSpellChance = hitSpellRating
		Ns.hitSpellGear = hitSpellGear
	end

end
-------------------------------------------------

-- Critical
function Ns.FunctionList.SpellCrit(HUD, data, options, ...)

	local EB = options.Level_Same_Boss
	local critSpellChance = 0
	local spellCritTable = {
		GetSpellCritChance(2), -- holy
		GetSpellCritChance(3), -- fire
		GetSpellCritChance(4), -- nature
		GetSpellCritChance(5), -- frost
		GetSpellCritChance(6), -- shadow
		GetSpellCritChance(7), -- arcane
	}
	local levelDifference = 0
	local critAura = 1.8
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

	-- Forever: school crit values are secret in restricted content; keep the last readable result (cache)
	if AnySecret(unpack(spellCritTable)) then
		critSpellChance = cachedSpellCrit
		Ns.critSpellBoss = cachedSpellCritBoss
	else
		table.sort(spellCritTable)
		critSpellChance = spellCritTable[#spellCritTable]
		critSpellChance = critSpellChance + Ns.combustionCount + Ns.arcaneMod + Ns.spellCritMod
		cachedSpellCrit = critSpellChance
		cachedSpellCritBoss = critSpellChance - levelDifference - critAura
		Ns.critSpellBoss = cachedSpellCritBoss
	end

	local cap = options.Cap_Percent or 100
	if cap > 0 and Safe(critSpellChance) >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	if Ns.Band(EB, SameLevel) then
		returnText = capColor .. (decimals):format(critSpellChance); statusbar = critSpellChance
	end
	if Ns.Band(EB, BossLevel) then
		returnText = capColor .. (decimals):format(Ns.critSpellBoss); statusbar = Ns.critSpellBoss
	end
	if Ns.Band(EB, Both) then
		returnText = capColor .. (decimals):format(critSpellChance) .. "|r (" .. (decimals):format(Ns.critSpellBoss) .. ")"; statusbar = critSpellChance
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Hit
function Ns.FunctionList.SpellHit(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local capColor = ""
	local statusbar = 0
	local returnText
	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	local baseHit = (Ns.hitSpellChance or 0) + (Ns.hitSpellGear or 0)
	local enhancedHit = baseHit + (Ns.hitMod or 0)

	local cap = options.Cap_Percent or 16
	if cap > 0 and Safe(enhancedHit) >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	if Ns.Band(EB, Enhanced) then
		returnText = capColor .. (decimals):format(enhancedHit) .. Ns.labelHit; statusbar = enhancedHit
	end
	if Ns.Band(EB, Base) then
		returnText = capColor .. (decimals):format(baseHit); statusbar = baseHit
	end
	if Ns.Band(EB, Both) then
		returnText = capColor .. (decimals):format(enhancedHit) .. Ns.labelHit .. "|r (" .. (decimals):format(baseHit) .. ")"; statusbar = enhancedHit
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Miss
function Ns.FunctionList.SpellMiss(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")
	local capColor = ""
	local statusbar = 0

	local missSameLevel = 3
	local missBossLevel = 16

	local hitSpell = (Ns.hitSpellChance or 0) + (Ns.hitSpellGear or 0) + (Ns.hitMod or 0)

	missSameLevel = (missSameLevel - hitSpell)
	missBossLevel = (missBossLevel - hitSpell)

	if missSameLevel < 0 then
		missSameLevel = 0
	elseif missSameLevel > 100 then
		missSameLevel = 100
	end
	if missBossLevel < 0 then
		missBossLevel = 0
	elseif missBossLevel > 100 then
		missBossLevel = 100
	end

	if Ns.Band(EB, SameLevel) then
		enhancedStat = missSameLevel
	end
	if  Ns.Band(EB, BossLevel) then
		baseStat = missBossLevel
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

-- Healing
function Ns.FunctionList.Healing(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local healBase = GetSpellBonusHealing()

	if Ns.Band(EB, Enhanced) then
		enhancedStat = Ns.healSpell
	end
	if  Ns.Band(EB, Base) then
		baseStat = healBase
	end

	local returnText
	if Ns.Band(EB, Both) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat) .. " (" .. Ns.DecimalNumber(options.Decimals_Default, baseStat) .. ")"
	else
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Holy
function Ns.FunctionList.Holy(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local holyBase = GetSpellBonusDamage(2)

	if Ns.Band(EB, Enhanced) then
		enhancedStat = Ns.holySpell
	end
	if  Ns.Band(EB, Base) then
		baseStat = holyBase
	end

	local returnText
	if Ns.Band(EB, Both) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat) .. " (" .. Ns.DecimalNumber(options.Decimals_Default, baseStat) .. ")"
	else
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Nature
function Ns.FunctionList.Nature(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local natureBase = GetSpellBonusDamage(4)

	if Ns.Band(EB, Enhanced) then
		enhancedStat = Ns.natureSpell
	end
	if  Ns.Band(EB, Base) then
		baseStat = natureBase
	end

	local returnText
	if Ns.Band(EB, Both) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat) .. " (" .. Ns.DecimalNumber(options.Decimals_Default, baseStat) .. ")"
	else
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Shadow
function Ns.FunctionList.Shadow(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local shadowBase = GetSpellBonusDamage(6)

	if Ns.Band(EB, Enhanced) then
		enhancedStat = Ns.shadowSpell
	end
	if  Ns.Band(EB, Base) then
		baseStat = shadowBase
	end

	local returnText
	if Ns.Band(EB, Both) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat) .. " (" .. Ns.DecimalNumber(options.Decimals_Default, baseStat) .. ")"
	else
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Fire
function Ns.FunctionList.Fire(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local fireBase = GetSpellBonusDamage(3)

	if Ns.Band(EB, Enhanced) then
		enhancedStat = Ns.fireSpell
	end
	if  Ns.Band(EB, Base) then
		baseStat = fireBase
	end

	local returnText
	if Ns.Band(EB, Both) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat) .. " (" .. Ns.DecimalNumber(options.Decimals_Default, baseStat) .. ")"
	else
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Frost
function Ns.FunctionList.Frost(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local frostBase = GetSpellBonusDamage(5)

	if Ns.Band(EB, Enhanced) then
		enhancedStat = Ns.frostSpell
	end
	if  Ns.Band(EB, Base) then
		baseStat = frostBase
	end

	local returnText
	if Ns.Band(EB, Both) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat) .. " (" .. Ns.DecimalNumber(options.Decimals_Default, baseStat) .. ")"
	else
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Arcane
function Ns.FunctionList.Arcane(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local arcaneBase = GetSpellBonusDamage(7)

	if Ns.Band(EB, Enhanced) then
		enhancedStat = Ns.arcaneSpell
	end
	if  Ns.Band(EB, Base) then
		baseStat = arcaneBase
	end

	local returnText
	if Ns.Band(EB, Both) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat) .. " (" .. Ns.DecimalNumber(options.Decimals_Default, baseStat) .. ")"
	else
		returnText = Ns.DecimalNumber(options.Decimals_Default, enhancedStat and enhancedStat or baseStat)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Undead Spell Power
function Ns.FunctionList.SpellUD(HUD, data, options, ...)

	local undeadSpell = 0
	local cleansingSet = 0
	local udTrinket = 0
	local markTrinket = 0
	local mhEnchant = 0
	local ohEnchant = 0
	local glovesCheck = GetInventoryItemID("player", 10)
	local bracersCheck = GetInventoryItemID("player", 9)
	local chestCheck = GetInventoryItemID("player", 5)
	local trinketCheck = GetInventoryItemID("player", 13)
	local trinketCheck2 = GetInventoryItemID("player", 14)
	local mainHandEnchant = C_PaperDollInfo.GetTemporaryEnchantmentInfo(INVSLOT_MAINHAND)
	local offHandEnchant = C_PaperDollInfo.GetTemporaryEnchantmentInfo(INVSLOT_OFFHAND)
	local mainHandEnchantID = mainHandEnchant and mainHandEnchant.enchantID
	local offHandEnchantId = offHandEnchant and offHandEnchant.enchantID

	if trinketCheck == 19812 or trinketCheck2 == 19812 then
		udTrinket = 48
	end
	if trinketCheck == 23207 or trinketCheck2 == 23207 then
		markTrinket = 85
	end

	if (mainHandEnchantID == 2685) then
		mhEnchant = 60
	end
	if (offHandEnchantId == 2685) then
		ohEnchant = 60
	end
	if glovesCheck == 23084 then
		cleansingSet = cleansingSet + 35
	end
	if bracersCheck == 23091 then
		cleansingSet = cleansingSet + 26
	end
	if chestCheck == 23085 then
		cleansingSet = cleansingSet + 48
	end

	local spellTable = {Ns.frostSpell, Ns.fireSpell, Ns.arcaneSpell, Ns.shadowSpell, Ns.natureSpell, Ns.holySpell}
	table.sort(spellTable)
	undeadSpell = spellTable[#spellTable]
	undeadSpell = undeadSpell + udTrinket + markTrinket + mhEnchant + ohEnchant + cleansingSet

	HUD:UpdateText(data, Ns.DecimalNumber(options.Decimals_Default, undeadSpell))
end
------------------------------------------------

-- Haste
function Ns.FunctionList.HasteCaster(HUD, data, options, ...)

	local EB = options.Enhanced_Base or 1
	local capColor = ""
	local haste = Ns.castHaste
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

--------------------
-- Mana regeneration
--------------------

local cachedRegenBase, cachedRegenCasting = 0, 0

local function CacheManaRegen(base, casting)
	if not issecretvalue(base) and not issecretvalue(casting) then
		cachedRegenBase, cachedRegenCasting = base, casting
		return base, casting
	end
	return cachedRegenBase, cachedRegenCasting
end

local function FormatManaRegen(options, scale)
	local base, casting = GetManaRegen()
	local mode = options.Auto_Switch and Casting or options.Regen_Normal_Casting

	if not options.Combat_Mode then
		base, casting = CacheManaRegen(base, casting)
		base, casting = base * scale, casting * scale
	end

	local decimals = Ns.DecimalFormat(options.Decimals_Two)

	if mode == Both then
		return (decimals):format(base) .. " (" .. (decimals):format(casting) .. ")"
	elseif mode == Casting then
		return (decimals):format(casting)
	end
	return (decimals):format(base)
end

-- MP2
function Ns.FunctionList.ManaRegen(HUD, data, options, ...)

	HUD:UpdateText(data, FormatManaRegen(options, 2))
end
------------------------------------------------

-- MP5
function Ns.FunctionList.MP5(HUD, data, options, ...)

	HUD:UpdateText(data, FormatManaRegen(options, 5))
end
------------------------------------------------
