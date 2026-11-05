local AddName, Ns = ...
local L = Ns.L
local issecretvalue = Ns.issecretvalue
local Safe = Ns.Safe

-- Fire
function Ns.FunctionList.FireResist(HUD, data, options, ...)

	local _, _, resistance, bonus = UnitResistance("player",2)
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0
	local cap = tonumber(options.Cap_Percent) or 0

	if options.Color_Effect and not issecretvalue(bonus) and bonus > 0 then buffColor = Ns.greenText end

	if cap > 0 and Safe(resistance) >= cap then capColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end

	if resistance == nil then resistance = 0 end

	barValue = resistance
	local mode = options.WithBar
	if mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	else
		barMax = tonumber(options.Cap_Percent) or 100
	end

	HUD:UpdateText(data, buffColor.. capColor .. resistance)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Nature
function Ns.FunctionList.NatureResist(HUD, data, options, ...)

	local _, _, resistance, bonus = UnitResistance("player",3)
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0
	local cap = tonumber(options.Cap_Percent) or 0

	if options.Color_Effect and not issecretvalue(bonus) and bonus > 0 then buffColor = Ns.greenText end

	if cap > 0 and Safe(resistance) >= cap then capColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end

	if resistance == nil then resistance = 0 end

	barValue = resistance
	local mode = options.WithBar
	if mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	else
		barMax = tonumber(options.Cap_Percent) or 100
	end

	HUD:UpdateText(data, buffColor.. capColor .. resistance)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Frost
function Ns.FunctionList.FrostResist(HUD, data, options, ...)

	local _, _, resistance, bonus = UnitResistance("player",4)
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0
	local cap = tonumber(options.Cap_Percent) or 0

	if options.Color_Effect and not issecretvalue(bonus) and bonus > 0 then buffColor = Ns.greenText end

	if cap > 0 and Safe(resistance) >= cap then capColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end

	if resistance == nil then resistance = 0 end

	barValue = resistance
	local mode = options.WithBar
	if mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	else
		barMax = tonumber(options.Cap_Percent) or 100
	end

	HUD:UpdateText(data, buffColor.. capColor .. resistance)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Shadow
function Ns.FunctionList.ShadowResist(HUD, data, options, ...)

	local _, _, resistance, bonus = UnitResistance("player",5)
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0
	local cap = tonumber(options.Cap_Percent) or 0

	if options.Color_Effect and not issecretvalue(bonus) and bonus > 0 then buffColor = Ns.greenText end

	if cap > 0 and Safe(resistance) >= cap then capColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end

	if resistance == nil then resistance = 0 end

	barValue = resistance
	local mode = options.WithBar
	if mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	else
		barMax = tonumber(options.Cap_Percent) or 100
	end

	HUD:UpdateText(data, buffColor.. capColor .. resistance)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Arcane
function Ns.FunctionList.ArcaneResist(HUD, data, options, ...)

	local _, _, resistance, bonus = UnitResistance("player",6)
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0
	local cap = tonumber(options.Cap_Percent) or 0

	if options.Color_Effect and not issecretvalue(bonus) and bonus > 0 then buffColor = Ns.greenText end

	if cap > 0 and Safe(resistance) >= cap then capColor = Ns.greenText end

	if options.Cap_Percent == 0 then capColor = "" end

	if resistance == nil then resistance = 0 end

	barValue = resistance
	local mode = options.WithBar
	if mode == Custom and options.BarMaxCustom and options.BarMaxCustom > 0 then
		barMax = options.BarMaxCustom
	else
		barMax = tonumber(options.Cap_Percent) or 100
	end

	HUD:UpdateText(data, buffColor.. capColor .. resistance)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------