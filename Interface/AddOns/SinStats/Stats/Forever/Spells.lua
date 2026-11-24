
local AddName, Ns = ...
local L = Ns.L
local issecretvalue = Ns.issecretvalue
local Safe = Ns.Safe

------------------------------
--		Options Equates		--
------------------------------
local Both, SameLevel, BossLevel, Casting, Rating = 3, 1, 2, 2, 2
local Percentage = 1

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

	local hitSpellRating = GetCombatRatingBonus(8)
	local hitSpellGear = GetSpellHitModifier()

	if not issecretvalue(hitSpellRating) and not issecretvalue(hitSpellGear) then
		if hitSpellRating == nil or hitSpellGear == nil then
			Ns.hitSpellChance = 0
			Ns.hitSpellGear = 0
		else
			Ns.hitSpellChance = hitSpellRating
			Ns.hitSpellGear = hitSpellGear
		end
	end

end
-------------------------------------------------

-- Critical
function Ns.FunctionList.SpellCrit(HUD, data, options, ...)

	local EB = options.Level_Same_Boss
	local spellCrit = GetSpellCritChance()
	local levelDifference = 0
	local critAura = 1.8
	local capColor = ""
	local statusbar = 0
	local returnText
	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")
	local combatSecret = false
	local bossCrit = 0

	levelDifference = Ns.targetLevel - Ns.playerLevel
	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	elseif levelDifference >= 3 then
		critAura = 1.8
	end

	local suppression = levelDifference + critAura

	if not issecretvalue(spellCrit) then
		bossCrit = spellCrit - suppression
		cachedSpellCritBoss = bossCrit
	else
		combatSecret = true
		if options.CombatMode then
			bossCrit = spellCrit
		else
			bossCrit = cachedSpellCritBoss
		end
	end

	local cap = options.Cap_Percent or 100
	if cap > 0 and Safe(spellCrit) >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	local suppressionText = ""
	if options.CombatMode and combatSecret then
		suppressionText = " +" .. (decimals):format(suppression)
	end

	if Ns.Band(EB, SameLevel) then
		returnText = capColor .. (decimals):format(spellCrit); statusbar = spellCrit
	end
	if Ns.Band(EB, BossLevel) then
		returnText = capColor .. (decimals):format(bossCrit) .. suppressionText; statusbar = bossCrit
	end
	if Ns.Band(EB, Both) then
		returnText = capColor .. (decimals):format(spellCrit) .. "|r (" .. (decimals):format(bossCrit) .. ")"; statusbar = spellCrit
	end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Hit
local cachedSpellHitChance = 0   -- frozen sum shown when CombatMode is off

function Ns.FunctionList.SpellHit(HUD, data, options, ...)

	local EB = options.Percent_Rating or 1
	local hitMod = GetSpellHitModifier()
	local hitBonus = GetCombatRatingBonus(CR_HIT_SPELL)
	local hitRating = GetCombatRating(CR_HIT_SPELL)
	local returnText, decimals, statusbar
	local capColor, endColor, rateColor = "", "", ""
	local combatSecret = false
	local totalHit = 0

	if not issecretvalue(hitMod) and not issecretvalue(hitBonus) then
		totalHit = hitMod + hitBonus
		cachedSpellHitChance = totalHit
	else
		combatSecret = true
		if options.CombatMode then
			totalHit = hitMod
		else
			totalHit = cachedSpellHitChance
		end
	end

	local rating = hitRating

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Safe(totalHit) >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Safe(rating) >= options.Cap_Rating then rateColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end
	if options.Cap_Rating == 0 then rateColor = "" end

	local bonusText = ""
	if options.CombatMode and combatSecret then
		bonusText = endColor .. " +" .. (decimals):format(hitBonus)
	end

	if Ns.Band(EB, Percentage) then
		returnText = capColor .. (decimals):format(totalHit) .. bonusText
		statusbar = totalHit
	end
	if Ns.Band(EB, Rating) then
		returnText = rateColor .. rating
		statusbar = rating
	end
	if Ns.Band(EB, Both) then
		returnText = capColor .. (decimals):format(totalHit) .. endColor .. " (" .. rateColor .. rating .. endColor .. ")"
		statusbar = totalHit
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

	local hitSpell = (Ns.hitSpellChance) + (Ns.hitSpellGear) + (Ns.hitMod)

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

	local missValue = enhancedStat or baseStat
	local cap = options.Cap_Percent
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

	local power = GetSpellBonusHealing()
	local returnText

	returnText = Ns.DecimalNumber(options.Decimals_Default, power)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Holy
function Ns.FunctionList.Holy(HUD, data, options, ...)

	local power = GetSpellBonusDamage(2)
	local returnText

	returnText = Ns.DecimalNumber(options.Decimals_Default, power)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Nature
function Ns.FunctionList.Nature(HUD, data, options, ...)

	local power = GetSpellBonusDamage(4)
	local returnText

	returnText = Ns.DecimalNumber(options.Decimals_Default, power)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Shadow
function Ns.FunctionList.Shadow(HUD, data, options, ...)

	local power = GetSpellBonusDamage(6)
	local returnText

	returnText = Ns.DecimalNumber(options.Decimals_Default, power)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Fire
function Ns.FunctionList.Fire(HUD, data, options, ...)

	local power = GetSpellBonusDamage(3)
	local returnText

	returnText = Ns.DecimalNumber(options.Decimals_Default, power)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Frost
function Ns.FunctionList.Frost(HUD, data, options, ...)

	local power = GetSpellBonusDamage(5)
	local returnText

	returnText = Ns.DecimalNumber(options.Decimals_Default, power)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Arcane
function Ns.FunctionList.Arcane(HUD, data, options, ...)

	local power = GetSpellBonusDamage(7)
	local returnText

	returnText = Ns.DecimalNumber(options.Decimals_Default, power)

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

	local EB = options.Percent_Rating or 1
	local haste = UnitSpellHaste("player")
	local rating = GetCombatRating(CR_HASTE_SPELL)
	local returnText, decimals, statusbar
	local capColor, endColor, rateColor = "", "", ""

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Safe(haste) >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Safe(rating) >= options.Cap_Rating then rateColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end
	if options.Cap_Rating == 0 then rateColor = "" end

	if not issecretvalue(rating) then rating = BreakUpLargeNumbers(rating) end

	if Ns.Band(EB, Percentage) then returnText = capColor .. (decimals):format(haste); statusbar = haste end
	if Ns.Band(EB, Rating) then returnText = rateColor .. rating; statusbar = rating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(haste) .. endColor .. "/" .. rateColor .. rating .. endColor; statusbar = haste end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------


-- Mana regeneration
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
------------------------------------------------

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
