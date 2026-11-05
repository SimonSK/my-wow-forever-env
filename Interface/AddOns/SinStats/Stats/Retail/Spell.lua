local AddName, Ns = ...
local L = Ns.L
local issecretvalue = Ns.issecretvalue
local Safe = Ns.Safe

------------------------------
--		Options Equates		--
------------------------------
local Enhanced = 1
local Base = 2
local Both = 3

----------------------------------
--		Text Return Formats		--
----------------------------------
local Double_Rating_Format = { "%.0f", "%.0f", "%.0f/%.0f", }

--------------------------
--		Physical		--
--------------------------

-- Intellect
function Ns.FunctionList.Intellect(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local debuffColor = ""
	local returnText

	local _s4, str4, _s5, intNeg = UnitStat("player", 4)
	local stat = str4 or 0
	local negBuff = intNeg

	if negBuff ~= nil and not issecretvalue(negBuff) and negBuff < 0 then debuffColor = "|cffC41E3A" end

	if stat then
		stat = Ns.DecimalNumber(options.Decimals_Default, stat)
	end

	if Ns.Band(EB, Enhanced) then returnText = debuffColor .. stat end
	if Ns.Band(EB, Base) then returnText = stat end
	if Ns.Band(EB, Both) then returnText = debuffColor .. stat .. "|r/" .. stat end

	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- Spell Power
function Ns.FunctionList.SpellPower(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local holySchool = GetSpellBonusDamage(2)
	local fireSchool = GetSpellBonusDamage(3)
	local natureSchool = GetSpellBonusDamage(4)
	local frostSchool = GetSpellBonusDamage(5)
	local shadowSchool = GetSpellBonusDamage(6)
	local arcaneSchool = GetSpellBonusDamage(7)
	local returnText

	local basePower = holySchool
	if not issecretvalue(holySchool) then
		basePower = max(holySchool, fireSchool, natureSchool, frostSchool, shadowSchool, arcaneSchool)
	end
	local spellPower = basePower
	if not issecretvalue(basePower) then
		spellPower = basePower + (basePower * Ns.shatteringStar) + (basePower * Ns.chaosBrand) + (basePower * Ns.felSunder) + (basePower * Ns.serenity) +
				(basePower * Ns.luckOfDraw) + (basePower * Ns.shadowForm) + (basePower * Ns.runePower) + (basePower * (Ns.incanterFlow/100)) + (basePower * (Ns.eradication/100)) +
				(basePower * Ns.touchOfIce) + (basePower * Ns.demonicSynergy) + (basePower * (Ns.equilibrium/100)) + (basePower * (Ns.InstinctArcana/100)) + (basePower * (Ns.iridescence/100)) +
				(basePower * Ns.ebonMight) + (basePower * (Ns.friendFae/100)) + (basePower * (Ns.wanTwilight/100)) + (basePower * (Ns.huntersMark/100)) + (basePower * (Ns.delver/100))
	end

	if spellPower then
		spellPower = Ns.DecimalNumber(options.Decimals_Default, spellPower)
	end

	if basePower then
		basePower = Ns.DecimalNumber(options.Decimals_Default, basePower)
	end

	if Ns.Band(EB, Enhanced) then returnText = spellPower end
	if Ns.Band(EB, Base) then returnText = basePower end
	if Ns.Band(EB, Both) then returnText = spellPower .. "/" .. basePower end

	HUD:UpdateText(data, returnText)
end

-- Spell Damage
function Ns.FunctionList.DMGModSpell(HUD, data, options, ...)

	local spellMod = 0
	local bonus = Safe(GetVersatilityBonus(29))
	local rating = Safe(GetCombatRatingBonus(29))
	local verDamage = bonus + rating
	local spec = GetSpecialization()
	local mastery = 0
	local masteryFx = Safe(GetMasteryEffect())
	local color = ""
	local decimals

	decimals = Ns.DecimalFormat(options.Decimals_Default, "%%")

		-- Mastery Effect
		if Ns.classId == 2 then -- paladin
			if (spec == 3) then mastery = masteryFx end
		elseif Ns.classId == 7 then -- shaman
			if (spec == 1) then mastery = masteryFx/3.351 end --3.3514517926155319148936170212766 coeff
			if (spec == 2) then mastery = masteryFx end
		elseif Ns.classId == 8 then -- mage
			if (spec == 1) then mastery = Safe(GetMastery()) end
		elseif Ns.classId == 13 then -- evoker
			if (spec == 1) then mastery = Safe(GetMastery()) end
		end

	spellMod = (Ns.shatteringStar * 100) + (Ns.chaosBrand * 100) + (Ns.felSunder * 100) + (Ns.serenity * 100) +
			   (Ns.luckOfDraw * 100) + verDamage + (Ns.shadowForm * 100) + (Ns.runePower * 100) + Ns.incanterFlow + Ns.tigersFury +
				Ns.eradication + (Ns.touchOfIce * 100) + (Ns.demonicSynergy * 100) + Ns.equilibrium + Ns.InstinctArcana + Ns.iridescence +
				Ns.arcaneSurge + Ns.enlightened + (Ns.ebonMight * 100) + Ns.friendFae + Ns.wanTwilight + Ns.retAura +
				Ns.huntersMark + mastery + Ns.delver + Ns.impetus
	spellMod = spellMod + 100

	if spellMod <= 0 then spellMod = 100 end
	if spellMod > 100 then color = Ns.greenText end

	HUD:UpdateText(data, color .. (decimals):format(spellMod))
end

-- Healing Power
function Ns.FunctionList.Healing(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local healPower = GetSpellBonusHealing()
	local baseHeal = healPower
	local returnText

	if not issecretvalue(healPower) then
		healPower = healPower + (healPower * Ns.serenity) + (healPower * Ns.luckOfDraw)
	end

	healPower = Ns.DecimalNumber(options.Decimals_Default, healPower)
	baseHeal = Ns.DecimalNumber(options.Decimals_Default, baseHeal)

	if Ns.Band(EB, Enhanced) then returnText = healPower end
	if Ns.Band(EB, Base) then returnText = baseHeal end
	if Ns.Band(EB, Both) then returnText = healPower .. "/" .. baseHeal end

	HUD:UpdateText(data, returnText)
end

-- Mana Regen
function Ns.FunctionList.ManaRegen(HUD, data, options, ...)

	local regen = GetManaRegen()
	if not issecretvalue(regen) then regen = (regen or 0) * 5 end

	regen = Ns.DecimalNumber(options.Decimals_Default, regen)

	HUD:UpdateText(data, regen)
end
