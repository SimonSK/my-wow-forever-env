local AddName, Ns = ...
local L = Ns.L

-- Fire
function Ns.FunctionList.FireResist(HUD, data, options, ...)

	local bonus = select(2, UnitResistance("player",2))
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0

	if options.Color_Effect and bonus > 0 then buffColor = Ns.greenText end

	if bonus >= options.Cap_Percent then capColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end

	if bonus == nil then bonus = "" end

	barValue = bonus
	local mode = options.WithBar
	if mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	else
		barMax = options.Cap_Percent
	end

	HUD:UpdateText(data, buffColor.. capColor .. bonus)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Nature
function Ns.FunctionList.NatureResist(HUD, data, options, ...)

	local bonus = select(2, UnitResistance("player",3))
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0

	if options.Color_Effect and bonus > 0 then buffColor = Ns.greenText end

	if bonus >= options.Cap_Percent then capColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end

	if bonus == nil then bonus = "" end

	barValue = bonus
	local mode = options.WithBar
	if mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	else
		barMax = options.Cap_Percent
	end

	HUD:UpdateText(data, buffColor.. capColor .. bonus)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Frost
function Ns.FunctionList.FrostResist(HUD, data, options, ...)

	local bonus = select(2, UnitResistance("player",4))
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0

	if options.Color_Effect and bonus > 0 then buffColor = Ns.greenText end

	if bonus >= options.Cap_Percent then capColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end

	if bonus == nil then bonus = "" end

	barValue = bonus
	local mode = options.WithBar
	if mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	else
		barMax = options.Cap_Percent
	end

	HUD:UpdateText(data, buffColor.. capColor .. bonus)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Shadow
function Ns.FunctionList.ShadowResist(HUD, data, options, ...)

	local bonus = select(2, UnitResistance("player",5))
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0

	if options.Color_Effect and bonus > 0 then buffColor = Ns.greenText end

	if bonus >= options.Cap_Percent then capColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end

	if bonus == nil then bonus = "" end

	barValue = bonus
	local mode = options.WithBar
	if mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	else
		barMax = options.Cap_Percent
	end

	HUD:UpdateText(data, buffColor.. capColor .. bonus)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Arcane
function Ns.FunctionList.ArcaneResist(HUD, data, options, ...)

	local bonus = select(2, UnitResistance("player",6))
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0

	if options.Color_Effect and bonus > 0 then buffColor = Ns.greenText end

	if bonus >= options.Cap_Percent then capColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end

	if bonus == nil then bonus = "" end

	barValue = bonus
	local mode = options.WithBar
	if mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	else
		barMax = options.Cap_Percent
	end

	HUD:UpdateText(data, buffColor.. capColor .. bonus)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------