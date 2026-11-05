local _, Ns = ...

---------------------
-- Options Equates --
---------------------
local Both, Honor, Arena = 3, 1, 2

-- Money
function Ns.FunctionList.Money(HUD, data, options, ...)

	local money = GetMoney()
	local gold = floor(money / 1e4)
	local formattedMoney = (C_CurrencyInfo.GetCoinTextureString(money))

	if options.Display_Gold then
		if options.Decimals_Default == 0 then
			formattedMoney = BreakUpLargeNumbers(gold)
		elseif options.Decimals_Default == 1 then
			formattedMoney = Ns.ShortNumbers(gold, 0)
		elseif options.Decimals_Default == 2 then
			formattedMoney = Ns.ShortNumbers(gold, 1)
		else
			formattedMoney = Ns.ShortNumbers(gold, 2)
		end
	end

	HUD:UpdateText(data, formattedMoney)
end
------------------------------------------------

-- WoW Token
function Ns.FunctionList.WowToken(HUD, data, options, ...)

	C_WowTokenPublic.UpdateMarketPrice()
	local token = C_WowTokenPublic.GetCurrentMarketPrice() or 0
	token = floor(token / 10000)
	token = Ns.DecimalNumber(options.Decimals_Default, token)

	local formattedToken = token .. "|TInterface\\MoneyFrame\\UI-GoldIcon:0:0:2:0|t"

	HUD:UpdateText(data, formattedToken)
end
------------------------------------------------

-- Love Tokens
-- function Ns.FunctionList.LoveToken(HUD, data, options, ...)

-- 	local item = C_Item.GetItemCount(49927, true)

-- 	HUD:UpdateText(data, item)
-- end
----------------------------------------------

-- PvP Points
-- function Ns.FunctionList.PvP(HUD, data, options, ...)

-- 	local EB = options.Honor_Arena
-- 	local honor = C_CurrencyInfo.GetCurrencyInfo(1901)
-- 	local arena = C_CurrencyInfo.GetCurrencyInfo(103)
-- 	local honorDisplay, arenaDisplay, returnText

-- 	if honor.name and tonumber(honor.quantity) then honorDisplay = honor.quantity
-- 	else honorDisplay = 0 end

-- 	if arena.name and tonumber(arena.quantity) then arenaDisplay = arena.quantity
-- 	else arenaDisplay = 0 end

-- 	if Ns.Band(EB, Honor) then returnText = honorDisplay end
-- 	if Ns.Band(EB, Arena) then returnText = arenaDisplay end
-- 	if Ns.Band(EB, Both) then returnText = honorDisplay .. "/" .. arenaDisplay end

-- 	HUD:UpdateText(data, returnText)
-- end
------------------------------------------------

-- Darkmoon Prize Ticket
function Ns.FunctionList.DarkmoonTicket(HUD, data, options, ...)

	local info = C_CurrencyInfo.GetCurrencyInfo(515)
	local amount = info and info.quantity or 0

	HUD:UpdateText(data, amount)
end
------------------------------------------------

-- Justice Points
function Ns.FunctionList.JusticePoints(HUD, data, options, ...)

	local info = C_CurrencyInfo.GetCurrencyInfo(395)
	local amount = info and info.quantity or 0

	HUD:UpdateText(data, amount)
end
------------------------------------------------

-- August Celestial Shard
function Ns.FunctionList.AugustShard(HUD, data, options, ...)

	local info = C_CurrencyInfo.GetCurrencyInfo(3314)
	local amount = info and info.quantity or 0

	HUD:UpdateText(data, amount)
end
------------------------------------------------

-- August Celestial Fragment
function Ns.FunctionList.AugustFragment(HUD, data, options, ...)

	local info = C_CurrencyInfo.GetCurrencyInfo(3350)
	local amount = info and info.quantity or 0

	HUD:UpdateText(data, amount)
end
------------------------------------------------

-- Platinum Coins
function Ns.FunctionList.PlatinumCoins(HUD, data, options, ...)

	local info = C_CurrencyInfo.GetCurrencyInfo(3407)
	local amount = info and info.quantity or 0

	HUD:UpdateText(data, amount)
end
------------------------------------------------