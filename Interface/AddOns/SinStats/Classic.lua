local AddName, Ns = ...
local L = Ns.L

------------------------------
--		Stat Options		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, World, Realm, Heroism, Valor, Equipped, Percentage = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 1
local SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total, Max, Average, Auto, Chance, Reduction, Bags, Honor, Kills, Rating = 1, 2, 1, 2, 1, 2, 1, 1, 2, 3, 1, 2, 3, 1, 2, 2


Ns.ConfigWidth = 975
Ns.ConfigHeight = 675--540
Ns.targetLevel, Ns.ohID = 0, 0

local honorIcon = 301091
local faction = UnitFactionGroup("player")

if faction == "Horde" then honorIcon = 301089 end

------------------------------
--		Display Order		--
------------------------------
Ns.DefaultOrder = {
	{ stat="AP", onupdate=true, events={}, spell=6673, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true, activeonload=true, },
	{ stat="APUD", onupdate=true, events={}, spell=17926, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
	{ stat="RAP", onupdate=true, events={}, spell=19506, spellclass="Ranged", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true, activeonload=true, },
	{ stat="RAPUD", onupdate=true, events={}, spell=5502, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
	{ stat="DMG", onupdate=true, events={}, spell=12328, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, Display_Average=true, Decimals_Default=true }, subgroup=true },
	{ stat="mDPS", onupdate=true, events={}, spell=8512, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, Display_Average=true, Decimals_Default=true }, subgroup=true },
	{ stat="RDMG", onupdate=true, events={}, spell=19434, spellclass="Ranged", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, Decimals_Default=true, }, subgroup=true },
	{ stat="rDPS", onupdate=true, events={}, spell=2643, spellclass="Ranged", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, Decimals_Default=true, }, subgroup=true },
	{ stat="Fire", onupdate=true, events={}, spell=11366, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true, activeonload=true, },
	{ stat="Frost", onupdate=true, events={}, spell=10181, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
	{ stat="Arcane", onupdate=true, events={}, spell=5143, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
	{ stat="Shadow", onupdate=true, events={}, spell=686, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
	{ stat="Nature", onupdate=true, events={}, spell=16901, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
	{ stat="Holy", onupdate=true, events={}, spell=7294, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
	{ stat="Healing", onupdate=true, events={}, spell=139, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
	{ stat="SpellUD", onupdate=true, events={}, spell=17959, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
	{ stat="Crit", onupdate=true, events={}, spell=1719, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar=true, Level_Same_Boss=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="CritCap", onupdate=true, events={}, spell=30920, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar="CritCap", Decimals_Two=true, }, subgroup=true },
	{ stat="RangedCrit", onupdate=true, events={}, spell=24395, spellclass="Ranged", widget={ type="CheckBox" }, options={ WithBar=true, Level_Same_Boss=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="SpellCrit", onupdate=true, events={}, spell=11115, spellclass="Spell", widget={ type="CheckBox" }, options={ WithBar=true, Level_Same_Boss=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="Hit", onupdate=true, events={}, spell=14294, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar=true, Enhanced_Base=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="RangedHit", onupdate=true, events={}, spell=1130, spellclass="Ranged", widget={ type="CheckBox" }, options={ WithBar=true, Enhanced_Base=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="SpellHit", onupdate=true, events={}, spell=11160, spellclass="Spell", widget={ type="CheckBox" }, options={ WithBar=true, Enhanced_Base=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="HasteMelee", onupdate=true, events={}, spell=6774, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar=true, Enhanced_Base=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="weaponSpeed", onupdate=true, events={}, spell=12974, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, Decimals_Two=true, }, subgroup=true },
	{ stat="HasteRanged", onupdate=true, events={}, spell=6150, spellclass="Ranged", widget={ type="CheckBox" }, options={ WithBar=true, Enhanced_Base=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="rangedSpeed", onupdate=true, events={}, spell=3045, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true, }, subgroup=true },
	{ stat="HasteCaster", onupdate=true, events={}, spell=12042, spellclass="Spell", widget={ type="CheckBox" }, options={ WithBar=true, Enhanced_Base=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="MeleeMiss", onupdate=true, events={}, spell=13807, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar="Miss", Level_Same_Boss=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="RangedMiss", onupdate=true, events={}, spell=19151, spellclass="Ranged", widget={ type="CheckBox" }, options={ WithBar="Miss", Level_Same_Boss=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="SpellMiss", onupdate=true, events={}, spell=15060, spellclass="Spell", widget={ type="CheckBox" }, options={ WithBar="Miss", Level_Same_Boss=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="ManaRegen", onupdate=true, events={}, spell=724, spellclass="Spell", widget={ type="CheckBox" }, options={ Regen_Normal_Casting=true, Decimals_Two=true, }, subgroup=true },
	{ stat="MP5", onupdate=true, events={}, spell=19742, spellclass="Spell", widget={ type="CheckBox" }, options={ Regen_Normal_Casting=true, Decimals_Two=true, }, subgroup=true },
	{ stat="Mitigation", onupdate=true, events={}, spell=16301, spellclass="Defensive", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true, activeonload=true, },
	{ stat="Defense", onupdate=true, events={}, spell=12753, spellclass="Defensive", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="Armor", onupdate=true, events={}, spell=12962, spellclass="Defensive", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
	{ stat="Dodge", onupdate=true, events={}, spell=24297, spellclass="Defensive", widget={ type="CheckBox" }, options={ Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="Parry", onupdate=true, events={}, spell=3127, spellclass="Defensive", widget={ type="CheckBox" }, options={ Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="Block", onupdate=true, events={}, spell=2565, spellclass="Defensive", widget={ type="CheckBox" }, options={ Cap_Percent=true, Decimals_Two=true, }, subgroup=true },
	{ stat="FireResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=18459, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, Cap_Percent=true, WithBar=true,  }, subgroup=true, activeonload=true, },
	{ stat="FrostResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=10161, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, Cap_Percent=true, WithBar=true,  }, subgroup=true },
	{ stat="ShadowResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=10958, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, Cap_Percent=true, WithBar=true,  }, subgroup=true },
	{ stat="ArcaneResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=1449, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, Cap_Percent=true, WithBar=true,  }, subgroup=true },
	{ stat="NatureResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=9858, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, Cap_Percent=true, WithBar=true,  }, subgroup=true },
	{ stat="Speed", onupdate=true, events={}, updatespeed=1, spell=2983, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar="Speed", Decimals_Two=true, }, subgroup=true, activeonload=true, },
	{ stat="TargetSpeed", onupdate=true, events={}, spell=23218, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true, }, subgroup=true },
	{ stat="Threat", onupdate=true, events={}, spell=355, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, }, subgroup=true },
	{ stat="Durability", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=3100, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar="Dura", Show=true, AutoColorOff=true }, subgroup=true },
	{ stat="RepairCost", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=20593, spellclass="Misc", widget={ type="CheckBox" }, options={ Total_Equipped_Bags=true, }, subgroup=true },
	{ stat="Honor", onupdate=true, events={}, spell=honorIcon, spellclass="Misc", widget={ type="CheckBox" }, options={ Honor_Kills=true, }, subgroup=true },
	{ stat="BuffCounter", onupdate=true, events={}, spell=22888, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar="Buff", }, subgroup=true },
	{ stat="DebuffCounter", onupdate=true, events={}, spell=23154, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Travel", onupdate=true, events={}, updatespeed=1, spell=1850, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Yards_KM=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
	{ stat="Jump", onupdate=true, events={}, spell=28683, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
	--{ stat="KillCounter", events={ NAME_PLATE_UNIT_ADDED=true, NAME_PLATE_UNIT_REMOVED=true, }, spell=5308, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, NPC_Players=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
	{ stat="CombatTimer", onupdate=true, events={}, updatespeed=1, spell=401462, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Combat_Color=true, Timer_Format=true, }, subgroup=true },
	{ stat="InstanceTimer", onupdate=true, events={}, updatespeed=1, spell=1233543, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Timer_Format=true, Send_Chat=true, }, subgroup=true },
	--{ stat="MobCounter", events={ NAME_PLATE_UNIT_ADDED=true, NAME_PLATE_UNIT_REMOVED=true, }, spell=199483, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Editbox_MobRange=true, }, subgroup=true },
	{ stat="Lag", onupdate=true, events={}, spell=1265, spellclass="Misc", widget={ type="CheckBox" }, options={ World_Realm=true, }, subgroup=true },
	{ stat="FPS", onupdate=true, events={}, spell=19498, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Money", events={ PLAYER_MONEY=true, }, item=5061, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Guild", events={ GUILD_ROSTER_UPDATE=true, }, item=23705, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, Show=true, Display_Total=true }, subgroup=true },
	{ stat="Friends", events={ FRIENDLIST_UPDATE=true, }, item=22260, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, Show=true, }, subgroup=true },
}

------------------------------
--		Global Events		--
------------------------------
Ns.GlobalEvents = {
	UNIT_AURA={ "player", "target", },
	UNIT_INVENTORY_CHANGED={ "player", },
	UNIT_STATS={ "player", },
	UNIT_DEFENSE={ "player", },
	BAG_CLOSED=true,
	BIND_ENCHANT=true,
	CHARACTER_POINTS_CHANGED=true,
	PLAYER_LEVEL_UP=true,
	REPLACE_ENCHANT=true,
	PLAYER_TARGET_CHANGED=true,
}

------------------------------
--		Settings Groups		--
------------------------------

local _P = "Interface\\AddOns\\SinStats\\Textures\\png\\left-menu\\"
local _T = "Interface\\AddOns\\SinStats\\Textures\\"

Ns.SpellClass = {
	[0] = { stat="Settings", grp=Ns.SettingsGroupOrder, order=Ns.SettingsDisplayOrder, icon="Settings", },
	[1] = { stat="Text", grp=Ns.TextGroupOrder, order=Ns.TextDisplayOrder, icon="Fonts", },
	[2] = { stat="Layout", grp=Ns.LayoutGroupOrder, order=Ns.LayoutDisplayOrder, icon="Layout", },
	[3] = { stat="Events", grp=Ns.EventsGroupOrder, order=Ns.EventsDisplayOrder, icon="Events", },
	[4] = { stat="Panels", grp=Ns.PanelGroupOrder, order=Ns.PanelDisplayOrder, icon="Layout", },
	[5] = { stat="Profiles", grp=Ns.ProfileGroupOrder, order=Ns.ProfileDisplayOrder, icon="Profiles", },
	[6] = { stat="", },
	[7] = { stat="Search", icon="Search", },
	[8] = { stat="Melee", icon="Physical", headerIcon="Physical", texture=_P.."left1.png", overlay="", background=_P.."8.png", backgroundMask=true, bgTex=_P.."8.png", },
	[9] = { stat="Defensive", icon="Defense", headerIcon="Defense", texture=_P.."left1.png", overlay="", background=_P.."9.png", backgroundMask=true, bgTex=_P.."9.png", },
	[10] = { stat="Ranged", icon="Ranged", headerIcon="Currency", texture=_P.."left1.png", overlay="", background=_P.."11.png", backgroundMask=true, bgTex=_P.."11.png", },
	[11] = { stat="Spell", icon="Spell", headerIcon="Spell", texture=_P.."left1.png", overlay="", background=_P.."10.png", backgroundMask=true, bgTex=_P.."10.png", },
	[12] = { stat="Resistance", icon="Resistance", headerIcon="Journeys", texture=_P.."left1.png", overlay="", background=_P.."12.png", backgroundMask=true, bgTex=_P.."12.png", },
	[13] = { stat="Misc", icon="Miscs", headerIcon="MiscStat", texture=_P.."left1.png", overlay="", background=_P.."13.png", backgroundMask=true, bgTex=_P.."13.png", },
	[14] = { stat="", },
	--[15] = { stat="FAQ", icon="Misc", },
}

------------------------------
--		Stat Options		--
------------------------------
Ns.Options = {
	{ stat="Show", group=1, widget={ type="CheckBox", } },
	{ stat="CustName", group=1, widget={ type="EditBox", width=140, height=23, numeric=false, }, tooltip=true, newline=true },
	{ stat="Enhanced_Base", group=2, spellclass="Enhanced_Base", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Enhanced", "Basic", "Both"}, newline=true },
	{ stat="Percent_Rating", group=2, spellclass="Percent_Rating", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Percentage", "Rating", "Both"}, newline=true },
	{ stat="Level_Same_Boss", group=2, spellclass="Level_Same_Boss", widget={ type="Radio", }, tooltip=true, default=1, labels={ "SameLevel", "BossLevel", "Both"}, newline=true },
	{ stat="Regen_Normal_Casting", group=2, spellclass="Regen_Normal_Casting", widget={ type="Radio", }, tooltip=true, default=1, labels={ "OutOfCombat", "Casting", "Both"}, newline=true },
	{ stat="Max_Average_Damage", group=2, spellclass="Max_Average_Damage", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Max", "Average", "Both"}, newline=true },
	{ stat="Main_Off_Auto", group=2, spellclass="Main_Off_Auto", widget={ type="Radio", }, tooltip=true, default=1, labels={ "MainHand", "OffHand", "Auto"}, newline=true },
	{ stat="Honor_Kills", group=2, spellclass="Honor_Kills", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Honor", "Kills", "Both"}, newline=true },
	{ stat="World_Realm", group=2, spellclass="World_Realm", widget={ type="Radio", }, tooltip=true, default=1, labels={ "World", "Realm", "Both"}, newline=true },
	{ stat="Total_Equipped_Bags", group=2, spellclass="Total_Equipped_Bags", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Total", "Equipped", "Bags"}, newline=true },

	{ stat="Display_Average", group=2, spellclass="Display_Average", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Average"}, newline=true },

	-- decimals
	{ stat="Decimals_Default", group=2, spellclass="Decimals_Default", default=0, widget={ type="Slider", min=0, max=3, valuestep=1, width=140, } , newline=true, },
	{ stat="Decimals_Two", group=2, spellclass="Decimals_Two", default=2, widget={ type="Slider", min=0, max=3, valuestep=1, width=140, } , newline=true, },


	{ stat="Display_Basic", group=2, spellclass="Display_Basic", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Basic"}, newline=true },
	{ stat="Display_MainHand", group=2, spellclass="Display_MainHand", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_MainHand"}, newline=true },
	{ stat="AutoColorOff", group=2, spellclass="AutoColorOff", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "AutoColorOff"}, newline=true, },
	{ stat="GradientText", group=2, spellclass="GradientText", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "GradientText"}, newline=true, },
	{ stat="Cap_Percent", group=3, spellclass="Cap_Percent", default=100, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.2f%%", }, },
	{ stat="Display_Total", group=2, spellclass="Display_Total", widget={ type="CheckBox", }, default=false, labels={ "Display_Total"}, newline=true, },
	{ stat="Yards_KM", group=2, spellclass="Yards_KM", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Yards", "Kilometers", "Both"}, newline=true, },
	{ stat="NPC_Players", group=2, spellclass="NPC_Players", widget={ type="Radio", }, tooltip=true, default=1, labels={ "NPC", "Players", "Both"}, newline=true, },
	{ stat="Reset_Login", group=2, spellclass="Reset_Login", widget={ type="CheckBox", }, default=false, labels={ "Reset_Login"}, newline=true, },

	{ stat="Combat_Color", group=2, spellclass="Combat_Color", widget={ type="CheckBox", }, tooltip=false, default=true, labels={ "Combat_Color"}, newline=true, },
	{ stat="Timer_Format", group=2, spellclass="Timer_Format", widget={ type="DropList", data="TimerFormat", width=120, }, default=1, newline=true, },
	{ stat="Send_Chat", group=2, spellclass="Send_Chat", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Send_Chat"}, newline=true, },
	{ stat="Editbox_MobRange", group=2, spellclass="Editbox_MobRange", default=0, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, newline=true, },



	-- colors
	{ stat="ColorCustom", group=4, default=false, widget={ type="CheckBox", }, linked={ "ColorName", false, "ColorClass", false, "ColorValue", false, "ColorValueEndable", false, }, onclick="InitCustomColors", newline=true },
	{ stat="ColorName", group=4, default={ r=1, g=1, b=1, }, widget={ type="ColorPicker", }, newline=true },
	{ stat="ColorClass", group=4, default=false, widget={ type="CheckBox", }, },
	{ stat="ColorValueEndable", group=4, default=false, widget={ type="CheckBox", }, linked={ "ColorValue", false, }, onclick="InitValueColor", newline=true },
	{ stat="ColorValue", group=4, default={ r=1, g=1, b=1, }, widget={ type="ColorPicker", }, },

	-- stat bars (using baremode to estrict key to specific)
	{ stat="ShowBar", group=5, spellclass="ShowBar", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "ShowBar"}, baropt=true, newline=true, },
	{ stat="StaticBar", group=5, spellclass="StaticBar", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "StaticBar"}, baropt=true, staticopt=true, newline=true, },
	{ stat="BarMaxMode", group=5, spellclass="BarMaxMode", widget={ type="DropList", data="BarMaxMode", width=120, }, default=1, onchange="OnBarMaxModeChange", baropt=true, barmode="Default", newline=true, },
	{ stat="SpeedBar", group=5, spellclass="SpeedBar", widget={ type="DropList", data="SpeedBar", width=120, }, default=1, baropt=true, barmode="Speed", newline=true, },
	{ stat="BarMaxCustom", group=5, spellclass="BarMaxCustom", default=100, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, baropt=true, barmode="Default,Speed", },
	{ stat="BarReverse", group=5, spellclass="BarReverse", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "BarReverse"}, baropt=true, newline=true, },
	{ stat="BarInvert", group=5, spellclass="BarInvert", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "BarInvert"}, baropt=true, },	
	{ stat="BarTexture", group=5, spellclass="BarTexture", widget={ type="DropList", data="BarTextures", width=170, }, default="Blizzard", baropt=true, staticopt=true, newline=true, },
	{ stat="BarColor", group=5, spellclass="BarColor", default={ r=0.2, g=0.6, b=0.2, }, widget={ type="ColorPicker", }, baropt=true, staticopt=true, newline=true, },
	{ stat="BarAutoColor", group=5, spellclass="BarAutoColor", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "BarAutoColor"}, baropt=true, linked={ "BarColor", true, }, },
	{ stat="BarAlpha", group=5, spellclass="BarAlpha", default=1, widget={ type="Slider", min=0, max=1, valuestep=0.01, width=145, }, baropt=true, staticopt=true, newline=true, },
	{ stat="BarHeight", group=5, spellclass="BarHeight", default=0, widget={ type="Slider", min=0, max=100, valuestep=1, width=145, }, tooltip=false, baropt=true, staticopt=true, newline=true, },
	{ stat="BarBgColor", group=5, spellclass="BarBgColor", default={ r=0.1, g=0.1, b=0.1, }, widget={ type="ColorPicker", }, baropt=true, newline=true, },
	{ stat="BarBgAlpha", group=5, spellclass="BarBgAlpha", default=1, widget={ type="Slider", min=0, max=1, valuestep=0.01, width=145, }, baropt=true, newline=true, },
}

--------------------------
--		Class & ID		--
--------------------------
Ns.byPlayerClass = {
	["DRUID"] = 11,
	["HUNTER"] = 3,
	["MAGE"] = 8,
	["PALADIN"] = 2,
	["PRIEST"] = 5,
	["ROGUE"] = 4,
	["SHAMAN"] = 7,
	["WARLOCK"] = 9,
	["WARRIOR"] = 1,
}

------------------------------
--		Class defaults		--
------------------------------
function Ns:GetClassDefaults(class)
	local defaults = {
		DRUID = {
			AP = true,
			Nature = true,
			Healing = true,
			MP5 = true,
			Crit = true,
			SpellCrit = true,
			SpellHit = true,
			SpellMiss = true,
			Mitigation = true,
			Speed = true,
			Durability = true,
		},
		HUNTER = {
			RAP = true,
			RDMG = true,
			rDPS = true,
			RangedCrit = true,
			RangedHit = true,
			HasteRanged = true,
			RangedMiss = true,
			RangedPen = true,
			Speed = true,
			Durability = true,
		},
		MAGE = {
			Frost = true,
			Fire = true,
			SpellCrit = true,
			SpellHit = true,
			SpellMiss = true,
			HasteCaster = true,
			ManaRegen = true,
			Speed = true,
			Durability = true,
		},
		PALADIN = {
			AP = true,
			Holy = true,
			Healing = true,
			MP5 = true,
			Crit = true,
			HasteMelee = true,
			Armor = true,
			SpellCrit = true,
			Mitigation = true,
			Speed = true,
			Durability = true,
		},
		PRIEST = {
			Healing = true,
			Shadow = true,
			SpellCrit = true,
			SpellHit = true,
			SpellMiss = true,
			HasteCaster = true,
			ManaRegen = true,
			Speed = true,
			Durability = true,
		},
		ROGUE = {
			AP = true,
			DMG = true,
			mDPS = true,
			weaponSpeed = true,
			Crit = true,
			CritCap = true,
			Hit = true,
			HasteMelee = true,
			Speed = true,
			Durability = true,
		},
		SHAMAN = {
			AP = true,
			Nature = true,
			Healing = true,
			MP5 = true,
			Crit = true,
			SpellCrit = true,
			SpellHit = true,
			SpellMiss = true,
			Speed = true,
			Durability = true,
		},
		WARLOCK = {
			Shadow = true,
			SpellCrit = true,
			SpellHit = true,
			SpellMiss = true,
			HasteCaster = true,
			ManaRegen = true,
			Speed = true,
			Durability = true,
		},
		WARRIOR = {
			AP = true,
			DMG = true,
			mDPS = true,
			Mitigation = true,
			Crit = true,
			CritCap = true,
			Hit = true,
			HasteMelee = true,
			Defense = true,
			Speed = true,
			Durability = true,
		},
	}
	return class and defaults[strupper(class)] or defaults
end
