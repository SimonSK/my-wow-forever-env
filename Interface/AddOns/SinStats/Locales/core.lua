local AddName, Ns = ...

local defaultLocale, newLocale
function Ns.RegisterLocale(locale, default)
	if default then
		if locale == "enUS" and not defaultLocale then
			defaultLocale, newLocale = {}, {}
			Ns.L = setmetatable(newLocale, { __index = function(t, k)
				local v = defaultLocale[k]
				if v ~= nil then return v end
				if type(k) == "string" and k:sub(-3) == "Tip" then return "" end
				return tostring(k)
			end})
			return defaultLocale
		end
	end
	return newLocale
end

-- icons
local path = "Interface\\AddOns\\"..AddName.."\\Textures\\"
local png ="Interface\\AddOns\\"..AddName.."\\Textures\\png\\buttons\\"

Ns.MiscIcon = "\124T" .. path .."MiscStat:13\124t "
Ns.SettingsIcon = "\124T" .. path .."Settings:13\124t "
Ns.DisplayIcon = "\124T" .. path .."Display:13\124t "
Ns.SpacingIcon = "\124T" .. path .."Spacing:13\124t "
Ns.LayoutIcon = "\124T" .. path .."Layout:13\124t "
Ns.ColumnIcon = "\124T" .. path .."CheckColumn:13\124t "
Ns.EventsIcon = "\124T" .. path .."Events:13\124t "
Ns.LockIcon = "\124T" .. path .."Lock:12\124t "
Ns.HideIcon = "\124T" .. path .."Hide:12\124t "
Ns.AttachIcon = "\124T" .. path .."Attach:12\124t "
Ns.StrataIcon = "\124T" .. path .."Strata:12\124t "
Ns.OutlineIcon = "\124T" .. path .."Outline:12\124t "
Ns.BackgroundIcon = "\124T" .. path .."Background:12\124t "
Ns.FontsIcon = "\124T" .. path .."Fonts:12\124t "
Ns.FontSizeIcon = "\124T" .. path .."FontSize:12\124t "
Ns.AlignIcon = "\124T" .. path .."Align:12\124t "
Ns.WidthIcon = "\124T" .. path .."Width:12\124t "
Ns.WidthStringIcon = "\124T" .. path .."WidthString:12\124t "
Ns.HeightIcon = "\124T" .. path .."Height:12\124t "
Ns.CapsIcon = "\124T" .. path .."Caps:12\124t "
Ns.TextColorIcon = "\124T" .. path .."TextColor:12\124t "
Ns.ValueColorIcon = "\124T" .. path .."ValueColor:12\124t "
Ns.AbbreviateIcon = "\124T" .. path .."Abbreviate:12\124t "
Ns.ToggleIconsIcon = "\124T" .. path .."ToggleIcons:12\124t "
Ns.SeparatorIcon = "\124T" .. path .."TextSeparator:12\124t "
Ns.MiniMenuIcon = "\124T" .. path .."MinimapMenu:12\124t "
Ns.CompIcon = "\124T" .. path .."Compartment:12\124t "
Ns.HUDIcon = "\124T" .. path .."HUD:12\124t "
Ns.ValueIcon = "\124T" .. path .."ValueColor:12\124t "
Ns.ToggleText = "\124T" .. path .."ToggleText:12\124t "
Ns.HUDBorder = "\124T" .. path .."HUDBorder:12\124t "

Ns.NewIcon = "\124T" .. png .."new.png:40\124t"
-- icon textures

local function getItem(itemId)
	local _,_,_,_,icon = C_Item.GetItemInfoInstant(itemId)
	return icon
end

local function getCurrencyIcon(currencyId)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyId)
	return info and info.iconFileID
end

local function getCurrency(varName, currencyId)
	local icon = getCurrencyIcon(currencyId) and ("|T" .. getCurrencyIcon(currencyId) .. ":0|t") or ""
	Ns[varName] = icon
	local ok, link = pcall(C_CurrencyInfo.GetCurrencyLink, currencyId)
	if ok and link then
		Ns[varName] = icon .. link
	end
end

local function getSpell(varName, spellId)
	local name, _, icon = C_Spell.GetSpellInfo(spellId)
	local iconStr = icon and ("|T" .. icon .. ":0|t") or ""
	Ns[varName] = iconStr
	local ok, link = pcall(C_Spell.GetSpellLink, spellId)
	if ok and link then
		Ns[varName] = iconStr .. link
	elseif name then
		Ns[varName] = iconStr .. "["..name.."]"
	end
end

-- spell links
if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then

	getCurrency("AdventurerLink", 3442)
	getCurrency("VeteranLink", 3443)
	getCurrency("ChampLink", 3444)
	getCurrency("HeroLink", 3445)
	getCurrency("MythLink", 3446)
	getCurrency("CrystalLink", 2815)
	getCurrency("DonorLink", 2897)
	getCurrency("ValorPvPLink", 1191)
	getCurrency("BloodyLink", 2123)
	getCurrency("HonorLink", 1792)
	getCurrency("ConqLink", 1602)
	getCurrency("TimeLink", 1166)
	getCurrency("TenderLink", 2032)
	getCurrency("CartelLink", 3120)
	getCurrency("HalloLink", 2899)
	getCurrency("AssemLink", 2902)
	getCurrency("SevereLink", 2903)
	getCurrency("CofferLink", 3310)
	getCurrency("CoinLink", 2803)
	getCurrency("CatalystLink", 3465)
	getCurrency("CelebLink", 3100)
	getCurrency("DarkfuseLink", 3177)
	getCurrency("GallaLink", 3136)
	getCurrency("RadianceLink", 3283)
	getCurrency("KareshLink", 3129)
	getCurrency("UntethLink", 3303)
	getCurrency("EtherealLink", 3278)
	getCurrency("BronzeLink", 3252)
	getCurrency("TwilightLink", 3319)
	getCurrency("VoidlightLink", 3316)
	getCurrency("CouponsLink", 3363)
	getCurrency("ArcanaLink", 3379)
	getCurrency("SilverLink", 3365)
	getCurrency("AmaniLink", 3354)
	getCurrency("AratiLink", 3370)
	getCurrency("ZuljarraLink", 3504)
	getCurrency("TokkaLink", 3540)
	getCurrency("SingLink", 3389)
	getCurrency("AbundLink", 3377)
	getCurrency("AnguishLink", 3392)
	getCurrency("CoiledFilLink", 3546)
	getCurrency("DarkmoonLink", 515)
	getCurrency("LuminousLink", 3385)
	getCurrency("DundunLink", 3376)
	getCurrency("RestoredKeyLink", 3028)
	getCurrency("ManaLink", 3356)
	getCurrency("VoidSampleLink", 3400)
	getCurrency("SlayerLink", 3410)
	getCurrency("PreyLink", 3386)
	getCurrency("RitualLink", 3428)
	getCurrency("AccoladeLink", 3405)
	getCurrency("AnglerPearlsLink", 3373)
	getCurrency("VoidcoreLink", 3418)
	getCurrency("IllusionaryLink", 3393)
	getCurrency("CorrosiveLink", 3448)
	getCurrency("KindojanLink", 3537)
	getCurrency("AqirRepLink", 3544)

	Ns.SparkLink = "|T".. getItem(274476)..":0|t"
	Ns.PuzzlingLink = "|T".. getItem(237502)..":0|t"
	Ns.SkyshardsLink = "|T".. getItem(255826)..":0|t"
	Ns.VileEssenceLink = "|T".. getItem(259361)..":0|t"
	Ns.AscendantLink = "|T".. getItem(280562)..":0|t"
	Ns.GalacticVoidLink = "|T".. getItem(271342)..":0|t"
	Ns.DarkParticleLink = "|T".. getItem(267051)..":0|t"
	Ns.MarkHonorLink = "|T".. getItem(137642)..":0|t"
	Ns.CorroSoulLink = "|T".. getItem(273000)..":0|t"
	Ns.OssifiedLink = "|T".. getItem(274422)..":0|t"
	Ns.VenomLink = "|T".. getItem(279382)..":0|t"
	Ns.VoidVestigeLink = "|T".. getItem(279576)..":0|t"
	Ns.BrewfestLink = "|T".. getItem(37829)..":0|t"
	Ns.MythicalLink = "|T".. getItem(285065)..":0|t"
	Ns.AqirLink = "|T".. getItem(286563)..":0|t"
	getSpell("DelverLink", 471521)
	getSpell("CompanionLink", 220172)
	getSpell("StashLink", 1216211)

elseif WOW_PROJECT_ID == 14 then
	-- Ns.DeathEmbLink = ""--"|T"..select(3, GetSpellInfo(47198))..":0|t"..GetSpellLink(47198).."   "
	-- Ns.FaeFireLink = ""--"|T"..select(3, GetSpellInfo(91565))..":0|t"..GetSpellLink(91565).."   "
	-- Ns.EarMoonLink = ""--"|T"..select(3, GetSpellInfo(60433))..":0|t"..GetSpellLink(60433).."   "
	-- Ns.HuntMarkLink = ""--"|T"..select(3, GetSpellInfo(1130))..":0|t"..GetSpellLink(1130).."   "
	-- Ns.ScarFeverLink = ""--"|T"..select(3, GetSpellInfo(81130))..":0|t"..GetSpellLink(81130).."   "
	-- Ns.ExpArmLink = ""--"|T"..select(3, GetSpellInfo(8647))..":0|t"..GetSpellLink(8647).."   "
	-- Ns.SunArmLink = ""--"|T"..select(3, GetSpellInfo(58567))..":0|t"..GetSpellLink(58567).."   "
	-- Ns.CursEleLink = ""--"|T"..select(3, GetSpellInfo(1490))..":0|t"..GetSpellLink(1490).."   "
	-- Ns.BeaSlayLink = ""--"|T"..select(3, GetSpellInfo(20557))..":0|t"..GetSpellLink(20557).."   "
	-- Ns.MolFuryLink = ""--"|T"..select(3, GetSpellInfo(31679))..":0|t"
	-- Ns.BrittleLink = ""--"|T"..select(3, GetSpellInfo(81326))..":0|t"..GetSpellLink(81326).."   "
	-- Ns.SavCombLink = ""--"|T"..select(3, GetSpellInfo(58413))..":0|t"
	-- Ns.MasPoisLink = ""--"|T"..select(3, GetSpellInfo(93068))..":0|t"..GetSpellLink(93068).."   "
	-- Ns.BloFrenLink = ""--"|T"..select(3, GetSpellInfo(30070))..":0|t"..GetSpellLink(30070).."   "
	-- Ns.NoEscapeLink = ""--"|T"..select(3, GetSpellInfo(53298))..":0|t"
	-- Ns.ShadFlameLink = ""--"|T"..select(3, GetSpellInfo(76768))..":0|t"..GetSpellLink(17800).."   "
	-- Ns.VindiLink = ""--"|T"..select(3, GetSpellInfo(26017))..":0|t"..GetSpellLink(26017).."   "
	-- Ns.LightBreathLink = ""--"|T"..select(3, GetSpellInfo(24844))..":0|t"..GetSpellLink(24844).."   "

elseif WOW_PROJECT_ID == 19 then -- mists
	Ns.DeathEmbLink = ""--"|T"..select(3, GetSpellInfo(47198))..":0|t"..GetSpellLink(47198).."   "
	Ns.FaeFireLink = ""--"|T"..select(3, GetSpellInfo(91565))..":0|t"..GetSpellLink(91565).."   "
	Ns.EarMoonLink = ""--"|T"..select(3, GetSpellInfo(60433))..":0|t"..GetSpellLink(60433).."   "
	Ns.HuntMarkLink = ""--"|T"..select(3, GetSpellInfo(1130))..":0|t"..GetSpellLink(1130).."   "
	Ns.ScarFeverLink = ""--"|T"..select(3, GetSpellInfo(81130))..":0|t"..GetSpellLink(81130).."   "
	Ns.ExpArmLink = ""--"|T"..select(3, GetSpellInfo(8647))..":0|t"..GetSpellLink(8647).."   "
	Ns.SunArmLink = ""--"|T"..select(3, GetSpellInfo(58567))..":0|t"..GetSpellLink(58567).."   "
	Ns.CursEleLink = ""--"|T"..select(3, GetSpellInfo(1490))..":0|t"..GetSpellLink(1490).."   "
	Ns.BeaSlayLink = ""--"|T"..select(3, GetSpellInfo(20557))..":0|t"..GetSpellLink(20557).."   "
	Ns.MolFuryLink = ""--"|T"..select(3, GetSpellInfo(31679))..":0|t"
	Ns.BrittleLink = ""--"|T"..select(3, GetSpellInfo(81326))..":0|t"..GetSpellLink(81326).."   "
	Ns.SavCombLink = ""--"|T"..select(3, GetSpellInfo(58413))..":0|t"
	Ns.MasPoisLink = ""--"|T"..select(3, GetSpellInfo(93068))..":0|t"..GetSpellLink(93068).."   "
	Ns.BloFrenLink = ""--"|T"..select(3, GetSpellInfo(30070))..":0|t"..GetSpellLink(30070).."   "
	Ns.NoEscapeLink = ""--"|T"..select(3, GetSpellInfo(53298))..":0|t"
	Ns.ShadFlameLink = ""--"|T"..select(3, GetSpellInfo(76768))..":0|t"..GetSpellLink(17800).."   "
	Ns.VindiLink = ""--"|T"..select(3, GetSpellInfo(26017))..":0|t"..GetSpellLink(26017).."   "
	Ns.LightBreathLink = ""--"|T"..select(3, GetSpellInfo(24844))..":0|t"..GetSpellLink(24844).."   "

elseif WOW_PROJECT_ID == 5 then -- tbc
	getSpell("BloodFrenzyLink", 29859)
	getSpell("CurseofElementsLink", 1490)
	getSpell("FireVulnerabilityLink", 22959)
	getSpell("HemorrhageLink", 16511)
	getSpell("HuntersMarkLink", 1130)
	getSpell("InsectSwarmLink", 5570)
	getSpell("MiseryLink", 33191)
	getSpell("SealofCrusaderLink", 21082)
	getSpell("ScorpidStingLink", 3043)
	getSpell("SurvivalofFittestLink", 33853)
	getSpell("ShadowWeavingLink", 15257)
	getSpell("ShadowVulnerabilityLink", 17794)
	getSpell("StormstrikeLink", 17364)
	getSpell("WintersChillLink", 12579)
	getSpell("SunderArmorLink", 7386)
	getSpell("ExposeArmorLink", 8647)
	getSpell("FaerieFireLink", 770)
	getSpell("CurseOfReckLink", 704)
	getSpell("ArmorShatterLink", 16928)
end

-- class colors
Ns.Colors = {
	Green = "|cff71ffc9",
	Red = "|cffC41E3A"	,
	Orange = "|cffffbc35",
	Warrior = "|cffC69B6D",
	Rogue = "|cffFFF468",
	Warlock = "|cff8788EE",
	Paladin = "|cffF48CBA",
	DeathKnight = "|cffC41E3A",
	Druid = "|cffFF7C0A",
	Hunter = "|cffAAD372",
	Mage = "|cff3FC7EB",
	Shaman = "|cff0070DD",
	Evoker = "|cff33937F",
	Monk = "|cff00FF98",
	DemonHunter = "|cffA330C9",
}

Ns.ColorsRGB = {
	Green  = { r = 0x71/255, g = 0xff/255, b = 0xc9/255 }, -- 0.443, 1.000, 0.788
	Orange = { r = 0xFF/255, g = 0x88/255, b = 0x00/255 }, -- midpoint stop (#FF8800)
	Red    = { r = 0xC4/255, g = 0x1E/255, b = 0x3A/255 },
}

function Ns:GradientColor(ratio)
	if ratio == nil then return 1, 1, 1 end
	if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
	local lo, hi, t
	if ratio < 0.5 then
		local tl = ratio / 0.5
		lo, hi, t = Ns.ColorsRGB.Red, Ns.ColorsRGB.Orange, tl * tl  -- ease-in: red lingers
	else
		lo, hi, t = Ns.ColorsRGB.Orange, Ns.ColorsRGB.Green, (ratio - 0.5) / 0.5
	end
	local r = lo.r + (hi.r - lo.r) * t
	local g = lo.g + (hi.g - lo.g) * t
	local b = lo.b + (hi.b - lo.b) * t
	return r, g, b
end

function Ns:GradientColorCode(ratio)
	local r, g, b = Ns:GradientColor(ratio)
	return string.format("|cff%02x%02x%02x", math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5))
end