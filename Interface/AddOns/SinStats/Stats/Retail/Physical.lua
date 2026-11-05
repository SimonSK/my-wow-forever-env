local AddName, Ns = ...
local L = Ns.L
local issecretvalue = Ns.issecretvalue
local Safe = Ns.Safe

------------------------------
--		Options Equates		--
------------------------------
local Enhanced, Percent, Melee, Max = 1, 1, 1, 1
local Base, Rating, Ranged, Average = 2, 2, 2, 2
local Both, Low = 3, 3

--------------------------
--		Physical		--
--------------------------
-- Strength
function Ns.FunctionList.Strength(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local base, stat, _, negBuff = UnitStat("Player", 1)
	local debuffColor = ""
	local returnText

	if not base then base = 0 end
	if not stat then stat = 0 end

	if Safe(negBuff) < 0 then debuffColor = "|cffC41E3A" end

	stat = Ns.DecimalNumber(options.Decimals_Default, stat)
	base = Ns.DecimalNumber(options.Decimals_Default, base)

	if Ns.Band(EB, Enhanced) then returnText = debuffColor .. stat end
	if Ns.Band(EB, Base) then returnText = base end
	if Ns.Band(EB, Both) then returnText = debuffColor .. stat .. "|r/" .. base end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- Agility
function Ns.FunctionList.Agility(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local _, stat, _, negBuff = UnitStat("Player", 2)
	local debuffColor = ""
	local returnText
	local base = stat

	if not base then base = 0 end
	if not stat then stat = 0 end

	if Safe(negBuff) < 0 then debuffColor = "|cffC41E3A" end

	stat = Ns.DecimalNumber(options.Decimals_Default, stat)
	base = Ns.DecimalNumber(options.Decimals_Default, base)

	if Ns.Band(EB, Enhanced) then returnText = debuffColor .. stat end
	if Ns.Band(EB, Base) then returnText = base end
	if Ns.Band(EB, Both) then returnText = debuffColor .. stat .. "|r/" .. base end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- Attack Power
function Ns.FunctionList.AP(HUD, data, options, ...)

	local EB = options.Melee_Ranged
	local base, posBuff, negBuff = UnitAttackPower("player");
	local effectiveAP
	if not issecretvalue(base) and not issecretvalue(posBuff) and not issecretvalue(negBuff) then
		effectiveAP = base + posBuff + negBuff
	else
		effectiveAP = base
	end
	local base, posBuff, negBuff = UnitRangedAttackPower("player");
	local effectiveRanged
	if not issecretvalue(base) and not issecretvalue(posBuff) and not issecretvalue(negBuff) then
		effectiveRanged = base + posBuff + negBuff
	else
		effectiveRanged = base
	end
	local debuffColor = ""
	local returnText

	if negBuff ~= nil and not issecretvalue(negBuff) and negBuff < 0 then debuffColor = "|cffC41E3A" end

	if not effectiveAP then effectiveAP = 0 end
	if not effectiveRanged then effectiveRanged = 0 end

	effectiveAP = Ns.DecimalNumber(options.Decimals_Default, effectiveAP)
	effectiveRanged = Ns.DecimalNumber(options.Decimals_Default, effectiveRanged)

	if Ns.Band(EB, Melee) then returnText = debuffColor .. effectiveAP end
	if Ns.Band(EB, Ranged) then returnText = debuffColor .. effectiveRanged end
	if Ns.Band(EB, Both) then returnText = debuffColor .. effectiveAP .. "|r/" .. debuffColor .. effectiveRanged end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- Damage
function Ns.FunctionList.DMG(HUD, data, options, ...)

	local EB = options.Max_Average_Damage
	local rawLow, rawHi, rawOHLow, rawOHHi, _, rawNeg = UnitDamage("player")
	local lowDmg = rawLow
	local hiDmg = rawHi
	local offlowDmg = rawOHLow
	local offhiDmg = rawOHHi
	local negBuff = rawNeg
	local totalDamage = hiDmg
	local meleeDamageOH = offhiDmg
	local avgDamage
	if not issecretvalue(hiDmg) and not issecretvalue(lowDmg) then
		avgDamage = (hiDmg + lowDmg) / 2
	else
		avgDamage = hiDmg
	end
	local speed = UnitRangedDamage("player")
	local debuffColor = ""
	local ohID = GetInventoryItemID("player", 17)
	local ohsubId = 0
	local returnText, decimals

	decimals = Ns.DecimalFormat(options.Decimals_Damage)

	local avgOhDmg, lowOH
	if not issecretvalue(offhiDmg) and not issecretvalue(offlowDmg) then
		avgOhDmg = "/" .. Ns.DecimalNumber(options.Decimals_Default, ((offhiDmg + offlowDmg) / 2))
		lowOH = "/" .. Ns.DecimalNumber(options.Decimals_Default, offlowDmg)
	else
		avgOhDmg = "/" .. Ns.DecimalNumber(options.Decimals_Default, offhiDmg)
		lowOH = "/" .. Ns.DecimalNumber(options.Decimals_Default, offlowDmg)
	end

	if not issecretvalue(speed) and speed > 0 then
		local _, rawRLow, rawRHi, _ = UnitRangedDamage("player")
		local rlowDmg = rawRLow
		local rhiDmg = rawRHi

		if not issecretvalue(rhiDmg) and not issecretvalue(rlowDmg) then
			avgDamage = (rhiDmg + rlowDmg) / 2
		else
			avgDamage = rhiDmg
		end
		avgOhDmg = ""
		lowDmg = rlowDmg
		lowOH = ""
	end

	if ohID then ohsubId = select(13, C_Item.GetItemInfo(ohID)) end
	if ohID or ohsubId == 2 then
		meleeDamageOH = "/" .. Ns.DecimalNumber(options.Decimals_Default, meleeDamageOH)
	else
		meleeDamageOH = ""
		avgOhDmg = ""
		lowOH = ""
	end

	if options.Display_MainHand then meleeDamageOH = ""; avgOhDmg = ""; lowOH = "" end

	if not issecretvalue(negBuff) and negBuff ~= nil and negBuff < 0 then debuffColor = "|cffC41E3A" end

	if Ns.Band(EB, Max) then returnText = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, totalDamage) .. meleeDamageOH end
	if Ns.Band(EB, Average) then returnText = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, avgDamage) .. avgOhDmg end
	if Ns.Band(EB, Low) then returnText = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, lowDmg) .. lowOH end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- Damage Bonus
function Ns.FunctionList.DMGMod(HUD, data, options, ...)

	local EB = options.Melee_Ranged
	local pmod = select(7,UnitDamage("player"))
	local rpmod = select(6, UnitRangedDamage("player"))
	local rawBonus29 = GetVersatilityBonus(29)
	local rawRating29 = GetCombatRatingBonus(29)
	local verDamage
	if not issecretvalue(rawBonus29) and not issecretvalue(rawRating29) then
		verDamage = rawBonus29 + rawRating29
	else
		verDamage = rawBonus29
	end
	local spec = GetSpecialization()
	local mastery, rmastery = 0, 0
	local masteryFx = GetMasteryEffect()
	local dmgMod, rdmgMod = 0, 0
	local color, rcolor = "", ""
	local decimals, returnText

	decimals = Ns.DecimalFormat(options.Decimals_Default, "%%")

	-- Mastery Effect
	if Ns.classId == 1 then -- warrior
		if (spec == 1) then mastery = masteryFx end
		if (spec == 2) and Ns.enrage then mastery = masteryFx end
	elseif Ns.classId == 2 then -- paladin
		if (spec == 3) then mastery = masteryFx end
	elseif Ns.classId == 3 then -- hunter
		if (spec == 1) or (spec == 3) then rmastery = masteryFx end
		if (spec == 2) then
			if not issecretvalue(masteryFx) then rmastery = masteryFx*2.233 else rmastery = masteryFx end
		end
	elseif Ns.classId == 6 then -- death knight
		if (spec == 2) then mastery = masteryFx end
	elseif Ns.classId == 7 then -- shaman
		if (spec == 1) then
			if not issecretvalue(masteryFx) then mastery = masteryFx/3.351 else mastery = masteryFx end
		end
	elseif Ns.classId == 10 then -- monk
		if (spec == 3) and (Ns.hitCombo > 0) then mastery = masteryFx end
	elseif Ns.classId == 12 then -- demon hunter
		if (spec == 1) then mastery = masteryFx end
	end

	local dmgModBase, rdmgModBase
	if not issecretvalue(verDamage) and not issecretvalue(mastery) and not issecretvalue(pmod) then
		dmgMod = (Ns.mysticTouch * 100) + (Ns.colossusSmash * 100) + (Ns.razorIce * 100) + (Ns.felSunder * 100) + (Ns.jadeFire * 100) +
				 (Ns.serenity * 100) + (Ns.luckOfDraw * 100) + (Ns.brittle * 100) + Ns.loneWolf + Ns.hitCombo + verDamage + Ns.demonSoul +
				 Ns.ferocityXuen + Ns.tigersFury + Ns.finalReck + Ns.momentum + (Ns.seethChaos * 100) + Ns.symbolsDeath +
				 (Ns.ebonMight * 100) + Ns.avatar + Ns.battleShout - Ns.defStance + Ns.feralSpirit + (Ns.ghostlyStrike * 100) + Ns.retAura +
				 Ns.inertia + (Ns.huntersMark * 100) + Ns.avWrath + mastery + Ns.martial + Ns.delver
		dmgMod = dmgMod + (pmod * 10) + 100
	else
		dmgMod = 100
	end

	if not issecretvalue(rmastery) and not issecretvalue(rpmod) then
		rdmgMod = (Ns.mysticTouch * 100) + (Ns.razorIce * 100) + (Ns.luckOfDraw * 100) + Ns.loneWolf  + Ns.bestialWrath
			  + (Ns.mysticTouch * 100) + Ns.retAura + (Ns.huntersMark * 100)  + rmastery + Ns.delver
		rdmgMod = rdmgMod + (rpmod * 10) + 100
	else
		rdmgMod = 100
	end

	if dmgMod <= 0 then dmgMod = 100 end
	if rdmgMod <= 0 then rdmgMod = 100 end
	if dmgMod > 100 then color = Ns.greenText end
	if rdmgMod > 100 then rcolor = Ns.greenText end

	if Ns.Band(EB, Melee) then returnText = color .. (decimals):format(dmgMod) end
	if Ns.Band(EB, Ranged) then returnText = rcolor .. (decimals):format(rdmgMod) end
	if Ns.Band(EB, Both) then returnText = color .. (decimals):format(dmgMod) .. "|r/" .. rcolor .. (decimals):format(rdmgMod) end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- DPS
function Ns.FunctionList.DPS(HUD, data, options, ...)

	local EB = options.Melee_Ranged
	local rawLow, rawHi, rawOHLow, rawOHHi = UnitDamage("player")
	local lowDmg = rawLow
	local hiDmg = rawHi
	local offlowDmg = rawOHLow
	local offhiDmg = rawOHHi
	local rawRS, rawRL, rawRH = UnitRangedDamage("player")
	local rangedSpeed = rawRS or 0
	local rlowDmg = rawRL
	local rhiDmg = rawRH
	local rawMS, rawMOS = UnitAttackSpeed("player")
	local meleeSpeed = rawMS or 0
	local meleeoffSpeed = rawMOS or 0
	local mainDPS, rangedDPS = 0, 0
	local offDPS = 0
	local separator = ""
	local returnText

	if not issecretvalue(meleeSpeed) and meleeSpeed > 0 then
		if not issecretvalue(lowDmg) and not issecretvalue(hiDmg) and not issecretvalue(meleeSpeed) then
			mainDPS = ((lowDmg + hiDmg) / 2) / meleeSpeed
		end
	end

	if not issecretvalue(meleeoffSpeed) and meleeoffSpeed > 0 then
		if not issecretvalue(offlowDmg) and not issecretvalue(offhiDmg) and not issecretvalue(meleeoffSpeed) then
			offDPS = (((offlowDmg + offhiDmg) / 2) / meleeoffSpeed)
		end
		separator = "/"
	end

	if not issecretvalue(rangedSpeed) and rangedSpeed > 0 then
		if not issecretvalue(rlowDmg) and not issecretvalue(rhiDmg) and not issecretvalue(rangedSpeed) then
			rangedDPS = ((rlowDmg + rhiDmg) / 2) / rangedSpeed
		end
	end

	local fmt = Ns.DecimalFormat(options.Decimals_Default)
	mainDPS = (fmt):format(mainDPS)
	offDPS = (fmt):format(offDPS)
	rangedDPS = (fmt):format(rangedDPS)

	if options.Display_MainHand then offDPS = ""; separator = "" end
	if not issecretvalue(meleeoffSpeed) and meleeoffSpeed == 0 then offDPS = "" end

	if Ns.Band(EB, Melee) then returnText = mainDPS .. separator .. offDPS end
	if Ns.Band(EB, Ranged) then returnText = rangedDPS end
	if Ns.Band(EB, Both) then returnText = mainDPS .. separator .. offDPS .. " (" .. rangedDPS .. ")" end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- Weapon Speed
function Ns.FunctionList.weaponSpeed(HUD, data, options, ...)

	local EB = options.Melee_Ranged
	local mainSpeed, offSpeed = UnitAttackSpeed("player")
	local rangedSpeed = UnitRangedDamage("player")
	local returnText, decimals

	decimals = Ns.DecimalFormat(options.Decimals_Two)

	if offSpeed == nil then offSpeed = ""
	else offSpeed = "/" .. (decimals):format(offSpeed) end

	if Ns.Band(EB, Melee) then returnText = (decimals):format(mainSpeed) .. offSpeed end
	if Ns.Band(EB, Ranged) then returnText = (decimals):format(rangedSpeed) end
	if Ns.Band(EB, Both) then returnText = (decimals):format(mainSpeed) .. offSpeed .. "|r (" .. (decimals):format(rangedSpeed) .. ")" end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- Energy Regen
function Ns.FunctionList.EnergyRegen(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local haste = GetHaste()
	local energyRegen
	if not issecretvalue(haste) then
		energyRegen = 10 + (haste * 0.1)
	else
		energyRegen = haste
	end
	local returnText, decimals

	decimals = Ns.DecimalFormat(options.Decimals_One)

	if Ns.Band(EB, Enhanced) then returnText = (decimals):format(energyRegen) end
	if Ns.Band(EB, Base) then returnText = (decimals):format(energyRegen) end
	if Ns.Band(EB, Both) then returnText = (decimals):format(energyRegen) .. " (" .. (decimals):format(energyRegen) .. ")" end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- Stamina
function Ns.FunctionList.Stamina(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local _, stat, _, negBuff = UnitStat("Player", 3)
	local debuffColor = ""
	local returnText

	if Safe(negBuff) < 0 then debuffColor = "|cffC41E3A" end

	if not stat then stat = 0 end

	stat = Ns.DecimalNumber(options.Decimals_Default, stat)

	if Ns.Band(EB, Enhanced) then returnText = debuffColor .. stat end
	if Ns.Band(EB, Base) then returnText = stat end
	if Ns.Band(EB, Both) then returnText = debuffColor .. stat .. "|r (" .. stat .. ")" end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end

-- Mitigation
function Ns.FunctionList.Mitigation(HUD, data, options, ...)

	local armor = select(2, UnitArmor("player"))
	--local safeArmor = Safe(armor)
	if issecretvalue(armor) then return end

	local playerLvl = UnitLevel("player")
	local rawDrBase = C_PaperDollInfo.GetArmorEffectiveness(armor, playerLvl)
	local dr
	if not issecretvalue(rawDrBase) then
		dr = rawDrBase * 100
	else
		dr = rawDrBase
	end
	local vers
	local rawBonus = GetVersatilityBonus(31)
	local rawRating = GetCombatRatingBonus(31)
	if not issecretvalue(rawBonus) and not issecretvalue(rawRating) then
		vers = rawBonus + rawRating
	else
		vers = rawBonus
	end
	local exist = UnitExists("target")
	local decimals

	if exist then
		local rawDr = C_PaperDollInfo.GetArmorEffectivenessAgainstTarget(armor)
		if rawDr then
			if not issecretvalue(rawDr) then dr = rawDr * 100 else dr = rawDr end
		end
	end

	if dr == nil then dr = 0 end

	if not issecretvalue(dr) and not issecretvalue(vers) then
		dr = dr + vers
	end

	decimals = Ns.DecimalFormat(options.Decimals_One, "%%")

	HUD:UpdateText(data, (decimals):format(dr))
end

-- Armor
function Ns.FunctionList.Armor(HUD, data, options, ...)

	local _, armor, _, _, negBuff = UnitArmor("player")
	local debuffColor = ""
	local returnText

	if negBuff == nil then negBuff = 0 end
	if Safe(negBuff) < 0 then debuffColor = "|cffC41E3A" end

	if armor == nil then armor = 0 end

	returnText = Ns.DecimalNumber(options.Decimals_Default, armor)

	HUD:UpdateText(data, debuffColor .. returnText)
end

-- Dodge
function Ns.FunctionList.Dodge(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local percent = GetDodgeChance()
	local rating = GetCombatRating(CR_DODGE)
	local returnText, decimals
	local capColor, endColor, rateColor = "", "", ""

	if returnText == nil then returnText = 0 end

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Safe(percent) >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Safe(rating) >= options.Cap_Rating then rateColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end
	if options.Cap_Rating == 0 then rateColor = "" end

	if not issecretvalue(rating) then rating = BreakUpLargeNumbers(rating) end

	if Ns.Band(EB, Percent) then returnText = capColor .. (decimals):format(percent) end
	if Ns.Band(EB, Rating) then returnText = rateColor .. rating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(percent) .. endColor .. " / " .. rateColor .. rating .. endColor end

	HUD:UpdateText(data, returnText)
end

-- Parry
function Ns.FunctionList.Parry(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local percent = GetParryChance()
	local rating = GetCombatRating(CR_PARRY)
	local decimals, returnText
	local capColor, endColor, rateColor = "", "", ""

	if returnText == nil then returnText = 0 end

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Safe(percent) >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Safe(rating) >= options.Cap_Rating then rateColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end
	if options.Cap_Rating == 0 then rateColor = "" end

	if not issecretvalue(rating) then rating = BreakUpLargeNumbers(rating) end

	if Ns.Band(EB, Percent) then returnText = capColor .. (decimals):format(percent) end
	if Ns.Band(EB, Rating) then returnText = rateColor .. rating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(percent) .. endColor .. " / " .. rateColor .. rating .. endColor end

	HUD:UpdateText(data, returnText)
end

-- Block
function Ns.FunctionList.Block(HUD, data, options, ...)

	local EB = options.Percent_Rating
	local percent = GetBlockChance()
	local rating = GetCombatRating(CR_BLOCK)
	local decimals, returnText
	local capColor, endColor, rateColor = "", "", ""

	if returnText == nil then returnText = 0 end

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Safe(percent) >= options.Cap_Percent then capColor = Ns.greenText end
	if capColor ~= "" then endColor = "|r" end

	if Safe(rating) >= options.Cap_Rating then rateColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end
	if options.Cap_Rating == 0 then rateColor = "" end

	if not issecretvalue(rating) then rating = BreakUpLargeNumbers(rating) end

	if Ns.Band(EB, Percent) then returnText = capColor .. (decimals):format(percent) end
	if Ns.Band(EB, Rating) then returnText = rateColor .. rating end
	if Ns.Band(EB, Both) then returnText = capColor .. (decimals):format(percent) .. endColor .. " / " .. rateColor .. rating .. endColor end

	HUD:UpdateText(data, returnText)
end

-- Stagger
function Ns.FunctionList.Stagger(HUD, data, options, ...)

	local stagger = Ns.Safe(C_PaperDollInfo.GetStaggerPercentage("player"))
	local decimals

	if stagger == nil then stagger = 0 end

	decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	HUD:UpdateText(data, (decimals):format(stagger))
end

-- Absorb
function Ns.FunctionList.Absorb(HUD, data, options, ...)

	local absorb = UnitGetTotalAbsorbs("player")
	local returnText

	returnText = Ns.DecimalNumber(options.Decimals_Default, absorb)

	--HUD:UpdateBar(data, absorb, UnitHealthMax("player"))
	HUD:UpdateText(data, returnText)
end