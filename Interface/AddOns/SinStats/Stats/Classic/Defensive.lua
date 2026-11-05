local AddName, Ns = ...
local L = Ns.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base = 3, 1, 2

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
	local baseDefense = 0
	local bonusDefense = 0
	local DefGearIndex = 0
	local DefGear = GetNumSkillLines()
	local DefHeader = nil
	local capColor = ""

	for i = 1, DefGear do
		local DefName = select(1, GetSkillLineInfo(i))
		local headerCheck = select(2, GetSkillLineInfo(i))
		if headerCheck ~= nil and headerCheck then
			DefHeader = DefName;
		else
			if (DefHeader == Ns.headerLoc) and (DefName == Ns.defenseLoc) then
				DefGearIndex = i
				break
			end
		end
	end
	if (DefGearIndex > 0) then
		baseDefense = select(4, GetSkillLineInfo(DefGearIndex))
		bonusDefense = select(6, GetSkillLineInfo(DefGearIndex))
	end

	local totalDefense = baseDefense + bonusDefense
	local cap = options.Cap_Percent or 100
	if cap > 0 and totalDefense >= cap then capColor = Ns.greenText end
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
	local _, effectiveArmor, _, _, negBuff = UnitArmor("player")

	if negBuff < 0 then
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
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player");
	local armorReduction = effectiveArmor/((85 * Ns.targetLevel) + 400);
	armorReduction = 100 * (armorReduction/(armorReduction + 1));

	local mitBase = armorReduction
	armorReduction = armorReduction

	if GetShapeshiftForm() == 2 and (Ns.classFilename == "WARRIOR") then
		armorReduction = armorReduction + 10
	end

	if negBuff < 0 then
		debuffColor = Ns.redText
	end

	local cap = options.Cap_Percent or 100
	local mitValue = armorReduction
	if Ns.Band(EB, Base) then mitValue = mitBase end
	if cap > 0 and mitValue >= cap then capColor = Ns.greenText end
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
	if cap > 0 and dodgeChance >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	HUD:UpdateText(data, capColor .. Ns.DecimalFormat(options.Decimals_Two, "%%"):format(dodgeChance))
end
------------------------------------------------

-- Parry
function Ns.FunctionList.Parry(HUD, data, options, ...)

	local parryChance = GetParryChance()
	local capColor = ""

	local cap = options.Cap_Percent or 100
	if cap > 0 and parryChance >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	HUD:UpdateText(data, capColor .. Ns.DecimalFormat(options.Decimals_Two, "%%"):format(parryChance))
end
------------------------------------------------

-- Block
function Ns.FunctionList.Block(HUD, data, options, ...)

	local blockChance = GetBlockChance()
	local capColor = ""

	local cap = options.Cap_Percent or 100
	if cap > 0 and blockChance >= cap then capColor = Ns.greenText end
	if cap == 0 then capColor = "" end

	HUD:UpdateText(data, capColor .. Ns.DecimalFormat(options.Decimals_Two, "%%"):format(blockChance))
end
------------------------------------------------


