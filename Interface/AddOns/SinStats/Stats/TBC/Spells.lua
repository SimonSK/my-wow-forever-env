local _, Ns = ...

local SameLevel, BossLevel, Both = 1, 2, 3
local Regen, Casting = 1, 2
local Enhanced, Base = 1, 2
local Percentage, Rating = 1, 2

------------------------------
--		Global Updater		--
------------------------------

Ns.critSpellChance, Ns.hitSpell, Ns.hitSpellRating, Ns.regenBase, Ns.regenCasting, Ns.critSpellBase, Ns.regenBaseBasic, Ns.regenCastingBasic  = 0, 0, 0, 0, 0, 0, 0, 0
Ns.unitStat, Ns.masterDemonologist = 0, 0

function Ns.SpellUpdate()

 	Ns.targetLevel = Ns.playerLevel + 3
	if UnitCanAttack("player", "target") then
		Ns.targetLevel = UnitLevel("target")
		if Ns.targetLevel <= 0 then
			Ns.targetLevel = Ns.playerLevel + 3
		end
	end

	local _, stat, _, _ = UnitStat("player", 4)
	Ns.unitStat = stat

	Ns.masterDemonologist = 0

	local _, petStamina, _, _ = UnitStat("pet", 4)
	local _, petIntellect, _, _ = UnitStat("pet", 3)

	petStamina = petStamina + petIntellect

	Ns.masterDemonologist = Ns.masterDemo
	if petStamina <= 0 then
		Ns.masterDemonologist = 0
	end

	-- Critical
	Ns.critSpellChance = 0
	local holySchool = GetSpellCritChance(2) or 0
	local fireSchool = GetSpellCritChance(3) or 0
	local natureSchool = GetSpellCritChance(4) or 0
	local frostSchool = GetSpellCritChance(5) or 0
	local shadowSchool = GetSpellCritChance(6) or 0
	local arcaneSchool = GetSpellCritChance(7) or 0

	Ns.critSpellChance = max(holySchool, fireSchool, natureSchool, frostSchool, shadowSchool, arcaneSchool)

	-- Hit
	Ns.hitSpell = GetCombatRatingBonus(CR_HIT_SPELL)

	if Ns.hitSpell == nil then
		Ns.hitSpell = 0
	end

	Ns.hitSpell = Ns.hitSpell + Ns.hitMod + Ns.elePrecision + Ns.natGuidance + Ns.balancePower + Ns.totemWrath + Ns.inspiSpellHit + Ns.inspiringPresence

	-- Regen
	local notcasting = notcasting
	local tempRegen = 0
	Ns.regenBase, Ns.regenCasting = GetManaRegen()
	local tierBonus = 0
	local zgBonus = 0

	Ns.regenBase = Ns.regenBase * 2
	Ns.regenCasting = (Ns.regenCasting * 2)

	if Ns.regenBase == Ns.regenCasting then
		if notcasting then
			Ns.regenBase = notcasting
		end
	else
		notcasting = Ns.regenBase
	end

	if Ns.tierPieces >= 3 then
		tierBonus = 8
	end
	if Ns.zgPieces >= 2 then
		zgBonus = 1.6
	end

	tempRegen = ((stat * Ns.DreamState) * 0.4) + Ns.felEnergy + Ns.springTotem + (Ns.epiphany * 0.4) + Ns.aspectViper + Ns.secondWind + Ns.manaTide + tierBonus + zgBonus + Ns.warchief

	if Ns.innervate then
		Ns.regenCasting = Ns.regenBase
		Ns.regenBase = (Ns.regenBase * 4)
	end

	Ns.regenCasting = Ns.regenCasting + tempRegen + (stat * (Ns.unrStorm/100) * 0.4)
	Ns.regenBase = Ns.regenBase + (stat * (Ns.unrStorm/100) * 0.4) + Ns.springTotem + Ns.felEnergy + ((stat * Ns.DreamState) * 0.4) + Ns.evoc + (Ns.epiphany * 0.4) + Ns.aspectViper + Ns.secondWind + Ns.manaTide + Ns.tierPieces + zgBonus + Ns.warchief

end
-------------------------------------------------

-- Healing
function Ns.FunctionList.Healing(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local base = GetSpellBonusHealing()
	local mod = 0
	local returnText

	Ns.unitStat = Ns.unitStat * Ns.natBlessing
	mod = (base + (base * Ns.spiritualHealing) + (base * Ns.giftNature) + (base * Ns.purification))

	base = format("%.0f", base)
	mod = format("%.0f", mod)

	if Ns.Band(EB, Enhanced) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) end
	if Ns.Band(EB, Base) then returnText = Ns.DecimalNumber(options.Decimals_Default, base) end
	if Ns.Band(EB, Both) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) .. "/" .. Ns.DecimalNumber(options.Decimals_Default, base) end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Holy
function Ns.FunctionList.Holy(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local base = GetSpellBonusDamage(2)
	local mod = GetSpellBonusDamage(2)
	local returnText

	mod = (mod + (mod * Ns.sancAura) + (mod * Ns.vengBuff) + (mod * Ns.avenWrath) + (mod * Ns.zoneBuff))
	mod = mod + (mod * Ns.misery) + Ns.judgeCrusader

	base = format("%.0f", base)
	mod = format("%.0f", mod)

	if Ns.Band(EB, Enhanced) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) end
	if Ns.Band(EB, Base) then returnText = Ns.DecimalNumber(options.Decimals_Default, base) end
	if Ns.Band(EB, Both) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) .. "/" .. Ns.DecimalNumber(options.Decimals_Default, base) end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Nature
function Ns.FunctionList.Nature(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local base = GetSpellBonusDamage(4)
	local mod = GetSpellBonusDamage(4)
	local returnText

	mod = mod + (mod * Ns.misery) + (mod * Ns.stormStrike) + (mod * Ns.zoneBuff)

	base = format("%.0f", base)
	mod = format("%.0f", mod)

	if Ns.Band(EB, Enhanced) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) end
	if Ns.Band(EB, Base) then returnText = Ns.DecimalNumber(options.Decimals_Default, base) end
	if Ns.Band(EB, Both) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) .. "/" .. Ns.DecimalNumber(options.Decimals_Default, base) end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Shadow
function Ns.FunctionList.Shadow(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local base = GetSpellBonusDamage(6)
	local mod = GetSpellBonusDamage(6)
	local returnText

	mod = (mod + (mod * Ns.shadowMastery) + (mod * Ns.DarkNessTalent) + (mod * Ns.dsSuc) + (mod * Ns.zoneBuff))
	mod = (mod + (mod * Ns.shadowFormDmg))
	mod = mod + (mod * Ns.misery) + (mod * Ns.shadowVuln) + (mod * Ns.shadowDmg) + (mod * Ns.curseElements) + (mod * Ns.masterDemonologist)

	base = format("%.0f", base)
	mod = format("%.0f", mod)

	if Ns.Band(EB, Enhanced) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) end
	if Ns.Band(EB, Base) then returnText = Ns.DecimalNumber(options.Decimals_Default, base) end
	if Ns.Band(EB, Both) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) .. "/" .. Ns.DecimalNumber(options.Decimals_Default, base) end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Fire
function Ns.FunctionList.Fire(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local base = GetSpellBonusDamage(3)
	local mod = GetSpellBonusDamage(3)
	local returnText

	mod = (mod + (mod * Ns.firepowerMod) + (mod * Ns.aiMod) + (mod * Ns.zoneBuff) + (mod * Ns.emberstorm) + (mod * Ns.dsImp) + (mod * Ns.playFire))
	mod = mod + (mod * Ns.arcanePower)
	mod = mod + (mod * Ns.misery) + (mod * Ns.curseElements) + (mod * Ns.impSorch) + (mod * Ns.masterDemonologist)

	base = format("%.0f", base)
	mod = format("%.0f", mod)

	if Ns.Band(EB, Enhanced) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) end
	if Ns.Band(EB, Base) then returnText = Ns.DecimalNumber(options.Decimals_Default, base) end
	if Ns.Band(EB, Both) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) .. "/" .. Ns.DecimalNumber(options.Decimals_Default, base) end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Frost
function Ns.FunctionList.Frost(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local base = GetSpellBonusDamage(5)
	local mod = GetSpellBonusDamage(5)
	local returnText

	mod = (mod + (mod * Ns.pierceMod) + (mod * Ns.aiMod) + (mod * Ns.zoneBuff) + (mod * Ns.playFire) + (mod * Ns.impFbDmg) + (mod * Ns.arcticWind))
	mod = (mod + (mod * Ns.arcanePower))
	mod = mod + (mod * Ns.misery) + (mod * Ns.curseElements)

	base = format("%.0f", base)
	mod = format("%.0f", mod)

	if Ns.Band(EB, Enhanced) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) end
	if Ns.Band(EB, Base) then returnText = Ns.DecimalNumber(options.Decimals_Default, base) end
	if Ns.Band(EB, Both) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) .. "/" .. Ns.DecimalNumber(options.Decimals_Default, base) end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Arcane
function Ns.FunctionList.Arcane(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local base = GetSpellBonusDamage(7)
	local mod = GetSpellBonusDamage(7)
	local returnText

	mod = (mod + (mod * Ns.aiMod) + (mod * Ns.arcanePower) + (mod * Ns.playFire) + (mod * Ns.zoneBuff))
	mod = mod + (mod * Ns.misery) + (mod * Ns.curseElements)

	base = format("%.0f", base)
	mod = format("%.0f", mod)

	if Ns.Band(EB, Enhanced) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) end
	if Ns.Band(EB, Base) then returnText = Ns.DecimalNumber(options.Decimals_Default, base) end
	if Ns.Band(EB, Both) then returnText = Ns.DecimalNumber(options.Decimals_Default, mod) .. "/" .. Ns.DecimalNumber(options.Decimals_Default, base) end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critical
function Ns.FunctionList.SpellCrit(HUD, data, options, ...)

	local EB = options.Level_Same_Boss
	local crit = 0
	local wintersChillEffect = ""
	local returnText
	local statusbar
	local decimals, liveCrit
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end
	local capColor, endColor = "", ""
	local ratingText = ""

	crit = Ns.critSpellChance + Ns.combustionCount + Ns.arcaneMod + Ns.eleMastery + Ns.tidalMastery + Ns.devastation + Ns.arcanePotency + Ns.starlight + Ns.impFrostbolt

	if (Ns.wintersChill > 0) then
		if Ns.wintersChill ~= 0 then
			wintersChillEffect = "|cff3FC7EB +" .. Ns.wintersChill .. "|r"
		end
	end
	if Ns.crusader then
		crit = Ns.critSpellChance + Ns.crusaderTalent
	end

	local levelDifference = 0
	local critAura = 1.84

	levelDifference = Ns.targetLevel - Ns.playerLevel
	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	end
	crit = Ns.critSpellChance - levelDifference - critAura
	if crit < 0 then
		crit = 0
	end

	if Ns.critSpellChance >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if options.Display_Rating then
		local critRating = GetCombatRating(CR_CRIT_SPELL)
		ratingText = " (" .. critRating .. ")"
	end

	if options.Display_Simulate then liveCrit = " > " .. (decimals):format(Ns.spellCrit)
	else liveCrit = "" end

	if Ns.Band(EB, SameLevel) then returnText = capColor .. (decimals):format(Ns.critSpellChance) .. ratingText .. Ns.callofThunder .. wintersChillEffect .. endColor .. liveCrit; statusbar = Ns.critSpellChance end
	if Ns.Band(EB, BossLevel) then returnText = capColor .. (decimals):format(crit) .. ratingText .. Ns.callofThunder .. wintersChillEffect .. endColor .. liveCrit; statusbar = crit end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(Ns.critSpellChance) .. "/" .. (decimals):format(crit) .. ratingText .. Ns.callofThunder .. wintersChillEffect .. endColor .. liveCrit; statusbar = Ns.critSpellChance end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Haste
function Ns.FunctionList.HasteCaster(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local haste = GetCombatRatingBonus(CR_HASTE_SPELL)
	local rating = GetCombatRating(CR_HASTE_SPELL)
	local returnText
	local statusbar
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end
	local capColor, endColor = "", ""

	if haste >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Ns.Band(EB, Percentage) then returnText = capColor .. (decimals):format(haste) .. endColor; statusbar = haste end
	if Ns.Band(EB, Rating) then returnText = rating; statusbar = haste end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(haste) .. endColor .. "/" .. rating; statusbar = haste end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Hit
function Ns.FunctionList.SpellHit(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local rating = GetCombatRating(CR_HIT_SPELL)
	local returnText
	local statusbar
	local hit =	Ns.hitSpell
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f%%"
	elseif options.Decimals_Two == 1 then decimals = "%.1f%%"
	elseif options.Decimals_Two == 2 then decimals = "%.2f%%"
	else decimals = "%.3f%%" end
	local capColor, endColor = "", ""

	if hit == nil then
		hit = 0
	end

	if hit >= options.Cap_Spell_Hit then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Ns.Band(EB, Percentage) then returnText = capColor .. (decimals):format(hit) .. Ns.Suppression .. Ns.arcaneFocus .. endColor; statusbar = hit end
	if Ns.Band(EB, Rating) then returnText = capColor .. rating .. endColor; statusbar = hit end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(hit) .. "/" .. rating .. Ns.Suppression .. Ns.arcaneFocus .. endColor; statusbar = hit end
	if returnText == nil then returnText = "" end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- Miss
function Ns.FunctionList.SpellMiss(HUD, data, options, ...)

	local EB = options.Level_Same_Boss
	local returnText
	local hit =	Ns.hitSpell
	local decimals, liveMiss
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	local spellSameLevel = 3
	local spellBossLevel = 16
	spellSameLevel = (spellSameLevel - hit)
	spellBossLevel = (spellBossLevel - hit)
	if spellSameLevel < 0 then
		spellSameLevel = 0
	elseif spellSameLevel > 100 then
		spellSameLevel = 100
	end
	if spellBossLevel < 0 then
		spellBossLevel = 0
	elseif spellBossLevel > 100 then
		spellBossLevel = 100
	end

	local statusbar

	if options.Display_Simulate then liveMiss = " > " .. (decimals):format(Ns.spellMissTracker)
	else liveMiss = "" end

	if Ns.Band(EB, SameLevel) then returnText = (decimals):format(spellSameLevel) .. "%" .. liveMiss; statusbar = spellSameLevel end
	if Ns.Band(EB, BossLevel) then returnText = (decimals):format(spellBossLevel) .. "%" .. liveMiss; statusbar = spellBossLevel end
	if Ns.Band(EB, Both) then returnText = (decimals):format(spellSameLevel) .. "%" .. " (" .. (decimals):format(spellBossLevel) .. "%" .. liveMiss; statusbar = spellSameLevel end

	statusbar = math.max(0, 100 - (statusbar or 0))

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, statusbar)
end
------------------------------------------------

-- MP2
function Ns.FunctionList.ManaRegen(HUD, data, options, ...)

	local EB = options.Regen_Normal_Casting
	local returnText
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	if Ns.Band(EB, Regen) then returnText = (decimals):format(Ns.regenBase) end
	if Ns.Band(EB, Casting) then returnText = (decimals):format(Ns.regenCasting) end
	if Ns.Band(EB, Both) then returnText = (decimals):format(Ns.regenBase) .. " (" .. (decimals):format(Ns.regenCasting) .. ")" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- MP5
function Ns.FunctionList.MP5(HUD, data, options, ...)

	local EB = options.Regen_Normal_Casting
	local returnText
	local mp5, mpcast = 0, 0
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	mp5 = (Ns.regenBase / 2) * 5
	mpcast = (Ns.regenCasting / 2) * 5

	if Ns.Band(EB, Regen) then returnText = (decimals):format(mp5) end
	if Ns.Band(EB, Casting) then returnText = (decimals):format(mpcast) end
	if Ns.Band(EB, Both) then returnText = (decimals):format(mp5) .. " (" .. (decimals):format(mpcast) .. ")" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Spell Penetration
function Ns.FunctionList.SpellPenetration(HUD, data, options, ...)

	local spellPenetration = GetSpellPenetration()
	local returnText
	local decimals
	if options.Decimals_Two == 0 then decimals = "%.0f"
	elseif options.Decimals_Two == 1 then decimals = "%.1f"
	elseif options.Decimals_Two == 2 then decimals = "%.2f"
	else decimals = "%.3f" end

	returnText = (decimals):format(spellPenetration)

	HUD:UpdateText(data, returnText)
end
------------------------------------------------
