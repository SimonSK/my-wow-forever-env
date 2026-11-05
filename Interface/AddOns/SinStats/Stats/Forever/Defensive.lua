local AddName, Ns = ...
local L = Ns.L
local issecretvalue = Ns.issecretvalue
local Safe = Ns.Safe

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base = 3, 1, 2
local cachedDefenseBase = 0
local cachedDefenseBonus = 0
local cachedMitigation = 0
local cachedMitigationBase = 0

------------------------------
--		Global Updater		--
------------------------------
function Ns.DefenseUpdate()

 	Ns.targetLevel = Ns.playerLevel + 3
	if UnitCanAttack("player", "target") then
		Ns.targetLevel = UnitLevel("target")
		if Ns.targetLevel <= 0 then
			Ns.targetLevel = Ns.playerLevel + 3
		end
	end

end

-- Defense
function Ns.FunctionList.Defense(HUD, data, options, ...)

	local EB = options.Enhanced_Base or 1
	local capColor = ""
	local baseDefense, bonusDefense = UnitDefenseSkill("player")

	if not issecretvalue(baseDefense) and not issecretvalue(bonusDefense) then
		cachedDefenseBase = baseDefense or 0
		cachedDefenseBonus = bonusDefense or 0
	else
		baseDefense = cachedDefenseBase
		bonusDefense = cachedDefenseBonus
	end

	local totalDefense = baseDefense + bonusDefense
	local cap = options.Cap_Percent or 100
	if cap > 0 and Safe(totalDefense) >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	local returnText
	local decimals = Ns.DecimalFormat(options.Decimals_Two)

	if Ns.Band(EB, Both) then
		returnText = capColor .. (decimals):format(totalDefense) .. "|r (" .. (decimals):format(baseDefense) .. ")"
	elseif Ns.Band(EB, Base) then
		returnText = capColor .. (decimals):format(baseDefense)
	else
		returnText = capColor .. (decimals):format(totalDefense)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Armor
function Ns.FunctionList.Armor(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local returnText
	local debuffColor = ""
	local _, effectiveArmor, _, bonus = UnitArmor("player")

	if bonus ~= nil and not issecretvalue(bonus) and bonus < 0 then
		debuffColor = Ns.redText
	end

	if Ns.Band(EB, Enhanced) then
		returnText = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, effectiveArmor)
	end
	if  Ns.Band(EB, Base) then
		returnText = Ns.DecimalNumber(options.Decimals_Default, effectiveArmor)
	end
	if  Ns.Band(EB, Both) then
		returnText = debuffColor .. Ns.DecimalNumber(options.Decimals_Default, effectiveArmor) .. " |r/ " .. Ns.DecimalNumber(options.Decimals_Default, effectiveArmor)
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Mitigation
function Ns.FunctionList.Mitigation(HUD, data, options, ...)

	local EB = options.Enhanced_Base
	local returnText
	local debuffColor = ""
	local capColor = ""
	local _, effectiveArmor, _, bonus = UnitArmor("player");
	local armorReduction, mitBase

	if not issecretvalue(effectiveArmor) then
		armorReduction = effectiveArmor/((85 * Ns.targetLevel) + 400);
		armorReduction = 100 * (armorReduction/(armorReduction + 1));
		mitBase = armorReduction

		if GetShapeshiftForm() == 2 and (Ns.classFilename == "WARRIOR") then
			armorReduction = armorReduction + 10
		end

		cachedMitigationBase = mitBase
		cachedMitigation = armorReduction
	else
		mitBase = cachedMitigationBase
		armorReduction = cachedMitigation
	end

	if bonus ~= nil and not issecretvalue(bonus) and bonus < 0 then
		debuffColor = Ns.redText
	end

	local cap = options.Cap_Percent or 100
	local mitValue = armorReduction
	if Ns.Band(EB, Base) then mitValue = mitBase end
	if cap > 0 and Safe(mitValue) >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	local decimals = Ns.DecimalFormat(options.Decimals_Two, "%%")

	if Ns.Band(EB, Enhanced) then
		returnText = capColor .. debuffColor ..  (decimals):format(armorReduction)
	end
	if Ns.Band(EB, Base) then
		returnText = capColor .. (decimals):format(mitBase)
	end
	if Ns.Band(EB, Both) then
		returnText = capColor .. debuffColor ..  (decimals):format(armorReduction) .. "|r (" .. (decimals):format(mitBase) .. ")"
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Dodge
function Ns.FunctionList.Dodge(HUD, data, options, ...)

	local dodgeChance = GetDodgeChance()
	local capColor = ""

	local cap = options.Cap_Percent or 100
	if cap > 0 and Safe(dodgeChance) >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	HUD:UpdateText(data, capColor .. Ns.DecimalFormat(options.Decimals_Two, "%%"):format(dodgeChance))
end
------------------------------------------------

-- Parry
function Ns.FunctionList.Parry(HUD, data, options, ...)

	local parryChance = GetParryChance()
	local capColor = ""

	local cap = options.Cap_Percent or 100
	if cap > 0 and Safe(parryChance) >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	HUD:UpdateText(data, capColor .. Ns.DecimalFormat(options.Decimals_Two, "%%"):format(parryChance))
end
------------------------------------------------

-- Block
function Ns.FunctionList.Block(HUD, data, options, ...)

	local blockChance = GetBlockChance()
	local capColor = ""

	local cap = options.Cap_Percent or 100
	if cap > 0 and Safe(blockChance) >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	HUD:UpdateText(data, capColor .. Ns.DecimalFormat(options.Decimals_Two, "%%"):format(blockChance))
end
------------------------------------------------


