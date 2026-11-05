local AddName, Ns = ...
local L = Ns.L

------------------------------
--		Options Equates		--
------------------------------

-- Fire
function Ns.FunctionList.FireResist(HUD, data, options, ...)

	local bonus = select(3, UnitResistance("player",2))
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0

	if options.Color_Effect and bonus > 0 then buffColor = Ns.greenText end

	if bonus >= options.Cap_Rating then capColor = Ns.greenText end

	if options.Cap_Rating == 0 then capColor = "" end

	if bonus == nil then bonus = "" end

	barValue = bonus
	local mode = options.BarMaxMode
	if mode == 1 then barMax = options.Cap_Rating
	else barMax = options.BarMaxCustom end

	HUD:UpdateText(data, buffColor.. capColor .. bonus)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Nature
function Ns.FunctionList.NatureResist(HUD, data, options, ...)

	local bonus = select(3, UnitResistance("player",3))
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0

	if options.Color_Effect and bonus > 0 then buffColor = Ns.greenText end

	if bonus >= options.Cap_Rating then capColor = Ns.greenText end

	if options.Cap_Rating == 0 then capColor = "" end

	if bonus == nil then bonus = "" end

	barValue = bonus
	local mode = options.BarMaxMode
	if mode == 1 then barMax = options.Cap_Rating
	else barMax = options.BarMaxCustom end

	HUD:UpdateText(data, buffColor.. capColor .. bonus)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Frost
function Ns.FunctionList.FrostResist(HUD, data, options, ...)

	local bonus = select(3, UnitResistance("player",4))
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0

	if options.Color_Effect and bonus > 0 then buffColor = Ns.greenText end

	if bonus >= options.Cap_Rating then capColor = Ns.greenText end

	if options.Cap_Rating == 0 then capColor = "" end

	if bonus == nil then bonus = "" end

	barValue = bonus
	local mode = options.BarMaxMode
	if mode == 1 then barMax = options.Cap_Rating
	else barMax = options.BarMaxCustom end

	HUD:UpdateText(data, buffColor.. capColor .. bonus)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Shadow
function Ns.FunctionList.ShadowResist(HUD, data, options, ...)

	local bonus = select(3, UnitResistance("player",5))
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0

	if options.Color_Effect and bonus > 0 then buffColor = Ns.greenText end

	if bonus >= options.Cap_Rating then capColor = Ns.greenText end

	if options.Cap_Rating == 0 then capColor = "" end

	if bonus == nil then bonus = "" end

	barValue = bonus
	local mode = options.BarMaxMode
	if mode == 1 then barMax = options.Cap_Rating
	else barMax = options.BarMaxCustom end

	HUD:UpdateText(data, buffColor.. capColor .. bonus)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------

-- Arcane
function Ns.FunctionList.ArcaneResist(HUD, data, options, ...)

	local bonus = select(3, UnitResistance("player",6))
	local buffColor, capColor = "", ""
	local barValue, barMax = 0, 0

	if options.Color_Effect and bonus > 0 then buffColor = Ns.greenText end

	if bonus >= options.Cap_Rating then capColor = Ns.greenText end

	if options.Cap_Rating == 0 then capColor = "" end

	if bonus == nil then bonus = "" end

	barValue = bonus
	local mode = options.BarMaxMode
	if mode == 1 then barMax = options.Cap_Rating
	else barMax = options.BarMaxCustom end

	HUD:UpdateText(data, buffColor.. capColor .. bonus)
	HUD:UpdateBar(data, barValue, barMax)
end
------------------------------------------------