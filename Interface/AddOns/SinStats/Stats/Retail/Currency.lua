local AddName, Ns = ...
local L = Ns.L

------------------------------
--		Options Equates		--
------------------------------
local Current, Level, Spark, Core, Mythical = 1, 1, 1, 1, 1
local Earned, Honor, Splinter, Shard, Heroic = 2, 2, 2, 2, 2
local Both = 3

--------------------------
--		Currency		--
--------------------------

-- Money
function Ns.FunctionList.Gold(HUD, data, options, ...)

	local money = GetMoney()
	local gold = floor(money / 1e4)
	local formattedMoney = (C_CurrencyInfo.GetCoinTextureString(money))

	if options.Display_Gold then
		formattedMoney = Ns.DecimalNumber(options.Decimals_Default, gold)
	end

	HUD:UpdateText(data, formattedMoney)
end
------------------------------------------------

-- WoW Token
local tokenNextUpdate = 0
local TOKEN_UPDATE_INTERVAL = 300 -- 5 minutes
function Ns.FunctionList.WowToken(HUD, data, options, ...)

	local now = GetTime()
	if now >= tokenNextUpdate then
		C_WowTokenPublic.UpdateMarketPrice()
		tokenNextUpdate = now + TOKEN_UPDATE_INTERVAL
	end
	local token = C_WowTokenPublic.GetCurrentMarketPrice() or 0
	local display, color = 0, ""

	token = floor(token / 10000)

	display = Ns.DecimalNumber(options.Decimals_Default, token)

	if options.Cap_Token and options.Cap_Token > 0 then
		if token < options.Cap_Token then
			color = Ns.redText
		else
			color = Ns.greenText
		end
	end

	HUD:UpdateText(data, color .. display)
end
------------------------------------------------

-- Honor
function Ns.FunctionList.Honor(HUD, data, options, ...)

	local EB = options.Level_HonorPoints
	local honorLevel = UnitHonorLevel("player")
	local honorPoints = C_CurrencyInfo.GetCurrencyInfo(1792)--UnitHonor("player")
	local ratedHonor = C_CurrencyInfo.GetCurrencyInfo(1891)
	local ratedTotal, hpDisplay = 0, 0
	local returnText

	if honorPoints.name and tonumber(honorPoints.quantity) then hpDisplay = honorPoints.quantity else hpDisplay = 0 end
	if ratedHonor.name and tonumber(ratedHonor.quantity) then ratedTotal = ratedHonor.quantity end

	if options.Display_Rated then hpDisplay = ratedTotal end

	if Ns.Band(EB, Level) then returnText = honorLevel end
	if Ns.Band(EB, Honor) then returnText = hpDisplay end
	if Ns.Band(EB, Both) then returnText = honorLevel .. "/" .. hpDisplay end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Crests
local function CrestCurrency(currencyId)
	return function(HUD, data, options, ...)
		local EB = options.Current_Earned
		local currency = C_CurrencyInfo.GetCurrencyInfo(currencyId)
		local max = currency.maxQuantity or 0
		local earn = currency.totalEarned or 0
		local display = 0
		local capColor = ""
		local cap = ""
		local returnText

		if currency.name and tonumber(currency.quantity) then display = currency.quantity
		else display = 0 end

		if options.Display_Weekly then cap = "/" .. max end
		if options.Display_Max and earn == max then capColor = Ns.redText end

		if Ns.Band(EB, Current) then returnText = capColor .. display .. cap end
		if Ns.Band(EB, Earned) then returnText = capColor .. earn .. cap end
		if Ns.Band(EB, Both) then returnText = capColor .. display .. "/" .. earn .. cap end
		if returnText == nil then returnText = 0 end

		HUD:UpdateText(data, returnText)
		HUD:UpdateBar(data, earn, max)
	end
end

for name, currencyId in pairs(Ns.CrestData) do
	Ns.FunctionList[name] = CrestCurrency(currencyId)
end
----------------------------------------------

-- Gilded Stash
function Ns.FunctionList.Stash(HUD, data, options, ...)

	local stash = C_UIWidgetManager.GetSpellDisplayVisualizationInfo(7591)
	local currency = "N/A"
	local max = 3
	local bar = 0

	local renown = C_MajorFactions.GetMajorFactionData(Ns.RenownData.Delver)
	local level = renown.renownLevel or 0

	if level >= 4 then max = 4 end

    if stash ~= nil then
    	currency = strmatch(stash.spellInfo.tooltip, '(%d)') or "N/A"
	end

	if currency == "N/A" then
		bar = 0
	else
		bar = currency
	end

	HUD:UpdateText(data, currency)
	HUD:UpdateBar(data, bar, max)
end
----------------------------------------------

-- Other currencies
local function Currency(currencyId, hasDecimals)
	return function(HUD, data, options, ...)
		local currency = C_CurrencyInfo.GetCurrencyInfo(currencyId)
		local max = currency.maxQuantity or 0
		local earn = currency.totalEarned or 0
		local weekly = currency.maxWeeklyQuantity or 0
		local capColor, cap = "", ""
		local display = 0

		if currency.name and tonumber(currency.quantity) then display = currency.quantity end

		if options.Display_Max and earn == max then capColor = Ns.redText end
		if options.Display_Weekly then cap = "/" .. weekly end

		if hasDecimals then
			display = Ns.DecimalNumber(options.Decimals_Default, display)
		end

		HUD:UpdateText(data, capColor .. display .. cap)
	end
end

for name, info in pairs(Ns.CurrencyData) do
	Ns.FunctionList[name] = Currency(info.id, info.decimals)
end
------------------------------------------------

-- Coffer Key Shards
function Ns.FunctionList.CofferKey(HUD, data, options, ...)

		local EB = options.Current_Earned
		local currency = C_CurrencyInfo.GetCurrencyInfo(3310)
		local max = currency.maxWeeklyQuantity or 0
		local earn = currency.quantityEarnedThisWeek or 0

		local capColor, cap = "", ""
		local display = 0
		local returnText

		if currency.name and tonumber(currency.quantity) then display = currency.quantity end

		if options.Display_Max and earn == max then capColor = Ns.redText end
		if options.Display_Weekly then cap = "/" .. max end

		if Ns.Band(EB, Current) then returnText = capColor .. display .. cap end
		if Ns.Band(EB, Earned) then returnText = capColor .. earn .. cap end
		if Ns.Band(EB, Both) then returnText = capColor .. display .. "/" .. earn .. cap end
--print("Name:", currency.name, "Quantity:", currency.quantity, "Total Earned:", currency.totalEarned, "Max Quantity:", currency.maxQuantity, "Max Weekly Quantity:", currency.maxWeeklyQuantity, "ID:", currency.id, "Icon File ID:", currency.iconFileID, "Is Header:", currency.isHeader, "Has Weekly Max:", currency.hasWeeklyMax, "Is Unused:", currency.isUnused, "Quantity Earned This Week:", currency.quantityEarnedThisWeek, "Total Earned This Week:", currency.totalEarnedThisWeek, "Weekly Max:", currency.weeklyMax, "Earned This Week:", currency.earnedThisWeek, "Weekly Max:", currency.weeklyMax, "Is Account Wide:", currency.isAccountWide, "Is Faction Specific:", currency.isFactionSpecific, "Is Seasonal:", currency.isSeasonal, "Season ID:", currency.seasonID, "Is Yearly:", currency.isYearly, "Yearly Reset Time:", currency.yearlyResetTime)

		HUD:UpdateText(data, returnText)
		HUD:UpdateBar(data, earn, max)
end

-- Spark of Tides
function Ns.FunctionList.Spark(HUD, data, options, ...)

	local EB = options.Splint_Spark
	local returnText
	local spark = C_Item.GetItemCount(274476, true)
	local currency = C_CurrencyInfo.GetCurrencyInfo(3509)
	local splinter = 0
	local capColor = ""
	local max = currency.maxQuantity or 0
	local earn = currency.totalEarned or 0

	if currency.name and tonumber(currency.quantity) then splinter = currency.quantity
	else splinter = 0 end

	if options.Display_Max and earn == max then capColor = Ns.redText end

	if Ns.Band(EB, Spark) then returnText = capColor .. spark end
	if Ns.Band(EB, Splinter) then returnText = capColor .. splinter end
	if Ns.Band(EB, Both) then returnText = capColor .. spark .. "/" .. splinter end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
	HUD:UpdateBar(data, earn, max)
end
------------------------------------------------

-- Corrosive soul
function Ns.FunctionList.CorroSoul(HUD, data, options, ...)

	local item = C_Item.GetItemCount(273000, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
end
------------------------------------------------

-- Venom-Cursed Fragments
function Ns.FunctionList.Venom(HUD, data, options, ...)

	local item = C_Item.GetItemCount(279382, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
end
------------------------------------------------

-- Void Vestige
function Ns.FunctionList.VoidVestige(HUD, data, options, ...)

	local item = C_Item.GetItemCount(279576, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
end
------------------------------------------------

-- Ossified relic
function Ns.FunctionList.Ossified(HUD, data, options, ...)

	local item = C_Item.GetItemCount(2744225, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
end
------------------------------------------------

-- Aqir Research Token
function Ns.FunctionList.AqirToken(HUD, data, options, ...)

	local item = C_Item.GetItemCount(286563, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
end
------------------------------------------------

-- Mysterious Skyshards
function Ns.FunctionList.Skyshards(HUD, data, options, ...)

	local item = C_Item.GetItemCount(255826, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
end
------------------------------------------------

-- Vile Essence
function Ns.FunctionList.VileEssence(HUD, data, options, ...)

	local item = C_Item.GetItemCount(259361, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
end
------------------------------------------------

-- Brewfest Prize Token
function Ns.FunctionList.Brewfest(HUD, data, options, ...)

	local item = C_Item.GetItemCount(37829, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
end
------------------------------------------------

-- -- Akir Research Token
-- function Ns.FunctionList.Akir(HUD, data, options, ...)

-- 	local item = C_Item.GetItemCount(286563, true)

-- 	if item == nil then item = 0 end

-- 	HUD:UpdateText(data, item)
-- end
-- ------------------------------------------------

-- Ascendant Venomstone
function Ns.FunctionList.Ascendant(HUD, data, options, ...)

	local item = C_Item.GetItemCount(280562, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
	HUD:UpdateBar(data, item, 10)
end
------------------------------------------------

-- Soul Fragment
function Ns.FunctionList.Mythical(HUD, data, options, ...)

	local EB = options.Myth_Hero
	local mythical = C_Item.GetItemCount(285065, true)
	local heroic = C_Item.GetItemCount(285801, true)
	local returnText

	if mythical == nil then mythical = 0 end
	if heroic == nil then heroic = 0 end

	if Ns.Band(EB, Mythical) then returnText = mythical end
	if Ns.Band(EB, Heroic) then returnText = heroic end
	if Ns.Band(EB, Both) then returnText = mythical .. "/" .. heroic end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Galactic Void
function Ns.FunctionList.GalacticVoid(HUD, data, options, ...)

	local EB = options.Core_Shard
	local c = C_Item.GetItemCount(271342, true)
	local s = C_Item.GetItemCount(271341, true)
	local returnText

	if c == nil then c = 0 end
	if s == nil then s = 0 end

	if Ns.Band(EB, Core) then returnText = c end
	if Ns.Band(EB, Shard) then returnText = s end
	if Ns.Band(EB, Both) then returnText = c .. "/" .. s end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Dark Particle
function Ns.FunctionList.DarkParticle(HUD, data, options, ...)

	local item = C_Item.GetItemCount(267051, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
end

-- Mark of Honor
function Ns.FunctionList.MarkHonor(HUD, data, options, ...)

	local item = C_Item.GetItemCount(137642, true)

	if item == nil then item = 0 end

	HUD:UpdateText(data, item)
end