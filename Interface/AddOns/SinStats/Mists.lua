local AddName, Ns = ...
local L = Ns.L

------------------------------
--		Stat Options		--
------------------------------
local Both, Enhanced, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, World, Realm, Heroism, Valor, Equipped, Honor, Arena, Player, Mood, Static = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 1
local SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total, Max, Average, Auto, Chance, Reduction, Bags, StoneKeeper, Marks, Pet, Damage, Live = 1, 2, 1, 2, 1, 2, 1, 1, 2, 3, 1, 2, 3, 1, 2, 2, 2, 1
local Basic, Base, Modifiers, Complete, Points, Value, Normal, Special = 2, 2, 3, 1, 1, 1, 1, 2


Ns.ConfigWidth = 975
Ns.ConfigHeight = 675 --700
Ns.targetLevel, Ns.ohID = 0, 0

local honorIcon = 73824
local faction = UnitFactionGroup("player")

if faction == "Horde" then honorIcon = 59641 end

------------------------------
--		Display Order		--
------------------------------
Ns.DefaultOrder = {
	{ stat="AP", onupdate=true, events={}, spell=66776, spellclass="Melee", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true, activeonload=true, },
	{ stat="RAP", onupdate=true, events={}, spell=56343, spellclass="Ranged", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true, }, subgroup=true, activeonload=true, },
	{ stat="DMG", onupdate=true, events={}, spell=1329, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, Display_Average=true }, subgroup=true },
	{ stat="mDPS", onupdate=true, events={}, spell=35551, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, Display_Average=true }, subgroup=true },
	{ stat="RDMG", onupdate=true, events={}, spell=53232, spellclass="Ranged", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, }, subgroup=true },
	{ stat="rDPS", onupdate=true, events={}, spell=62173, spellclass="Ranged", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, }, subgroup=true },
	{ stat="Fire", onupdate=true, events={}, spell=86949, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true, activeonload=true, },
	{ stat="Frost", onupdate=true, events={}, spell=62381, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
	{ stat="Arcane", onupdate=true, events={}, spell=50045, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
	{ stat="Shadow", onupdate=true, events={}, spell=47230, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
	{ stat="Nature", onupdate=true, events={}, spell=48514, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
	{ stat="Holy", onupdate=true, events={}, spell=63018, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
	{ stat="Healing", onupdate=true, events={}, spell=88684, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
	{ stat="Mastery", onupdate=true, events={}, spell=77223, spellclass="Attributes", widget={ type="CheckBox" }, options={ WithBar=true, Point_Rating=true, Decimals_Two=true, Cap_Percent=true }, subgroup=true, activeonload=true, },
	{ stat="Strength", onupdate=true, events={}, spell=46917, spellclass="Attributes", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
	{ stat="Agility", onupdate=true, events={}, spell=51723, spellclass="Attributes", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
	{ stat="Crit", onupdate=true, events={}, spell=143440, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, Display_Basic=true, Decimals_Two=true, Display_Simulate=true, Cap_Percent=true }, subgroup=true },
	{ stat="CritBoss", onupdate=true, events={}, spell=58426, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar=true, Enhanced_Base=true, Decimals_Two=true, Cap_Percent=true }, subgroup=true },
	{ stat="CritCap", onupdate=true, events={}, spell=51690, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar="CritCap", Enhanced_Base=true, Decimals_One=true }, subgroup=true },
	{ stat="RangedCrit", onupdate=true, events={}, spell=137619, spellclass="Ranged", widget={ type="CheckBox" }, options={ WithBar="RangedCrit", Percent_Rating=true, Decimals_Two=true, Cap_Ranged_Crit=true, Display_Simulate=true }, subgroup=true },
	{ stat="RangedCritBoss", onupdate=true, events={}, spell=76577, spellclass="Ranged", widget={ type="CheckBox" }, options={ WithBar="RangedCritBoss", Enhanced_Base=true, Decimals_Two=true, Cap_Ranged_Crit=true }, subgroup=true },
	{ stat="Intellect", onupdate=true, events={}, spell=81206, spellclass="Attributes", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
	{ stat="SpellCrit", onupdate=true, events={}, spell=103795, spellclass="Spell", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, Display_Basic=true, Decimals_Two=true, Cap_Percent=true, Display_Simulate=true }, subgroup=true },
	{ stat="SpellCritBoss", onupdate=true, events={}, spell=70598, spellclass="Spell", widget={ type="CheckBox" }, options={ WithBar=true, Enhanced_Base=true, Decimals_Two=true, Cap_Percent=true }, subgroup=true },
	{ stat="Hit", onupdate=true, events={}, spell=82925, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar="Hit", Percent_Rating=true, Display_Decimals=true, Decimals_Two=true, Cap_Hit=true, }, subgroup=true },
	{ stat="RangedHit", onupdate=true, events={}, spell=51919, spellclass="Ranged", widget={ type="CheckBox" }, options={ WithBar="RangedHit", Percent_Rating=true, Decimals_Two=true, Cap_Hit=true }, subgroup=true },
	{ stat="SpellHit", onupdate=true, events={}, spell=47573, spellclass="Spell", widget={ type="CheckBox" }, options={ WithBar="SpellHit", Percent_Rating=true, Decimals_Two=true, Cap_Spell_Hit=true }, subgroup=true },
	{ stat="HasteMelee", onupdate=true, events={}, spell=63150, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, Display_Basic=true, Decimals_Two=true, Cap_Melee_Haste=true }, subgroup=true },
	{ stat="HasteRanged", onupdate=true, events={}, spell=108687, spellclass="Ranged", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, Display_Basic=true, Decimals_Two=true, Cap_Melee_Haste=true }, subgroup=true },
	{ stat="HasteCaster", onupdate=true, events={}, spell=29310, spellclass="Spell", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, Display_Basic=true, Decimals_Two=true }, subgroup=true },
	{ stat="ArmorPen", onupdate=true, events={}, spell=84963, spellclass="Melee", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true, Decimals_Two=true }, subgroup=true },
	{ stat="RangedPen", onupdate=true, events={}, spell=53238, spellclass="Ranged", widget={ type="CheckBox" }, options={ Percent_Rating=true, Decimals_Two=true, Cap_Ranged_ArP=true }, subgroup=true },
	{ stat="SpellPenetration", onupdate=true, events={}, spell=95920, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_One=true }, subgroup=true },
	{ stat="Expertise", onupdate=true, events={}, spell=53365, spellclass="Melee", widget={ type="CheckBox" }, options={ Value_Rating=true, Display_Expertise=true, Display_MainHand=true, Decimals_Default=true, Cap_Melee_Exp=true, Display_Simulate=true }, subgroup=true },
	{ stat="MeleeMiss", onupdate=true, events={}, spell=79134, spellclass="Melee", widget={ type="CheckBox" }, options={ WithBar="Miss", Level_Same_Boss=true, Decimals_Two=true, Display_Special=true, Display_Simulate=true }, subgroup=true },
	{ stat="RangedMiss", onupdate=true, events={}, spell=49530, spellclass="Ranged", widget={ type="CheckBox" }, options={ WithBar="Miss", Level_Same_Boss=true, Decimals_Two=true, Display_Simulate=true }, subgroup=true },
	{ stat="SpellMiss", onupdate=true, events={}, spell=85222, spellclass="Spell", widget={ type="CheckBox" }, options={ WithBar="Miss", Level_Same_Boss=true, Decimals_Two=true, Display_Simulate=true }, subgroup=true },
	{ stat="Avoidance", onupdate=true, events={}, spell=40080, spellclass="Defense", widget={ type="CheckBox" }, options={ WithBar="Avoidance", Enhanced_Base=true, Decimals_Two=true, Cap_Def_Avo=true, Add_Block=true }, subgroup=true, activeonload=true, },
 	{ stat="NPCArmor", onupdate=true, events={}, spell=44520, spellclass="Melee", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="BossReduc", onupdate=true, events={}, spell=48792, spellclass="Melee", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_One=true }, subgroup=true },
	{ stat="weaponSpeed", onupdate=true, events={}, spell=109935, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, Decimals_Two=true }, subgroup=true },
	{ stat="CritReceived", onupdate=true, events={}, spell=46867, spellclass="Defense", widget={ type="CheckBox" }, options={ WithBar="Crits", Chance_Reduction=true, Decimals_Two=true, Display_Simulate=true }, subgroup=true },
	{ stat="rangedSpeed", onupdate=true, events={}, spell=34483, spellclass="Ranged", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
	{ stat="Spirit", onupdate=true, events={}, spell=48104, spellclass="Attributes", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
	{ stat="ManaRegen", onupdate=true, events={}, spell=115294, spellclass="Spell", widget={ type="CheckBox" }, options={ Regen_Normal_Casting=true, Display_Basic=true, Decimals_One=true }, subgroup=true },
	{ stat="MP5", onupdate=true, events={}, spell=47585, spellclass="Spell", widget={ type="CheckBox" }, options={ Regen_Normal_Casting=true, Display_Basic=true, Decimals_One=true }, subgroup=true },
	{ stat="Mitigation", onupdate=true, events={}, spell=114029, spellclass="Defense", widget={ type="CheckBox" }, options={ WithBar=true, Total_Modifiers=true, Decimals_Two=true, Cap_Def_Mit=true }, subgroup=true },
	{ stat="EHP", onupdate=true, events={}, item=40753, spellclass="Defense", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
	{ stat="Resilience", onupdate=true, events={}, spell=74001, spellclass="Defense", widget={ type="CheckBox" }, options={ Decimals_Two=true }, subgroup=true },
	{ stat="Stamina", onupdate=true, events={}, spell=114713, spellclass="Attributes", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true  }, subgroup=true },
	{ stat="Armor", onupdate=true, events={}, spell=13459, spellclass="Defense", widget={ type="CheckBox" }, options={ WithBar=true, Enhanced_Base=true, Decimals_Default=true, Cap_Def_Armor=true }, subgroup=true },
	{ stat="Dodge", onupdate=true, events={}, spell=55342, spellclass="Defense", widget={ type="CheckBox" }, options={ Percent_Rating=true, Decimals_Two=true, Display_Simulate=true }, subgroup=true },
	{ stat="Parry", onupdate=true, events={}, spell=3127, spellclass="Defense", widget={ type="CheckBox" }, options={ Percent_Rating=true, Decimals_Two=true, Display_Simulate=true }, subgroup=true },
	{ stat="Block", onupdate=true, events={}, spell=52127, spellclass="Defense", widget={ type="CheckBox" }, options={ Percent_Rating=true, Decimals_Two=true, Block_Damage=true, Display_Simulate=true }, subgroup=true },
	{ stat="petAP", onupdate=true, events={}, spell=53270, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true, activeonload=true, },
	{ stat="petDMG", onupdate=true, events={}, spell=80367, spellclass="Pet", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, }, subgroup=true },
	{ stat="petDPS", onupdate=true, events={}, spell=19623, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="petSpell", onupdate=true, events={}, spell=3716, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="petCrit", onupdate=true, events={}, spell=50334, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="petAtkSpeed", onupdate=true, events={}, spell=71232, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="petArmor", onupdate=true, events={}, spell=60114, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	--{ stat="PvP", events={ CURRENCY_DISPLAY_UPDATE=true, }, spell=honorIcon, spellclass="Currency", widget={ type="CheckBox" }, options={ Honor_Arena=true, }, subgroup=true },	
	{ stat="Money", events={ PLAYER_MONEY=true, }, spell=67368, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Display_Gold=true, Decimals_Default=true, }, subgroup=true, activeonload=true, },
	{ stat="WowToken", onupdate=true, events={}, item=122284, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Display_Short=true, Decimals_Default=true, }, subgroup=true },
	{ stat="DarkmoonTicket", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=515, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
	{ stat="JusticePoints", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=395, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
	{ stat="AugustShard", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3414, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
	{ stat="AugustFragment", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3350, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
	{ stat="PlatinumCoins", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3407, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
	--{ stat="LoveToken", events={ UNIT_INVENTORY_CHANGED=true, }, item=49927, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true }, subgroup=true },
	{ stat="Speed", onupdate=true, events={}, updatespeed=1, spell=91381, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar="Speed", Speed_Static=true, }, subgroup=true, activeonload=true, },
	{ stat="TargetSpeed", onupdate=true, events={}, spell=52358, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Threat", onupdate=true, events={}, spell=355, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, }, subgroup=true },
	{ stat="ItemLevel", onupdate=true, events={}, spell=66666, spellclass="Misc", widget={ type="CheckBox" }, options={ Equip_Max=true, Decimals_One=true }, subgroup=true },
	{ stat="GlobalCD", events={ UNIT_SPELLCAST_SUCCEEDED={ "player" }, }, spell=71328, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true }, subgroup=true },
	{ stat="Durability", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=3100, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar="Dura", AutoColorOff=true }, subgroup=true },
	{ stat="RepairCost", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=11209, spellclass="Misc", widget={ type="CheckBox" }, options={ Total_Equipped_Bags=true, }, subgroup=true },
	{ stat="Travel", onupdate=true, events={}, updatespeed=1, spell=87840, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Yards_KM=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
	{ stat="Jump", onupdate=true, events={}, spell=69295, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
	--{ stat="KillCounter", events={ NAME_PLATE_UNIT_ADDED=true, NAME_PLATE_UNIT_REMOVED=true, }, spell=5308, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, NPC_Players=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
	{ stat="CombatTimer", onupdate=true, events={}, updatespeed=1, spell=34712, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Combat_Color=true, Timer_Format=true, }, subgroup=true },
	{ stat="InstanceTimer", onupdate=true, events={}, updatespeed=1, spell=110909, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Timer_Format=true, Send_Chat=true, }, subgroup=true },
	--{ stat="MobCounter", events={ NAME_PLATE_UNIT_ADDED=true, NAME_PLATE_UNIT_REMOVED=true, }, spell=199483, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Editbox_MobRange=true, }, subgroup=true },
	{ stat="Lag", onupdate=true, events={}, spell=110166, spellclass="Misc", widget={ type="CheckBox" }, options={ World_Realm=true, }, subgroup=true },
	{ stat="FPS", onupdate=true, events={}, updatespeed=1, spell=62695, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="BuffCounter", onupdate=true, events={}, spell=22888, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="DebuffCounter", onupdate=true, events={}, spell=23154, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Guild", events={ GUILD_ROSTER_UPDATE=true, }, item=69210, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, Show=true, Display_Total=true }, subgroup=true },
	{ stat="Friends", events={ FRIENDLIST_UPDATE=true, BN_FRIEND_INFO_CHANGED=true, }, item=22260, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, BNet_Realm=true }, subgroup=true },
}

------------------------------
--		Global Events		--
------------------------------
Ns.GlobalEvents = {
	UNIT_AURA={ "player", "target", "pet"},
	UNIT_INVENTORY_CHANGED={ "player", },
	UNIT_STATS={ "player", },
	UNIT_DEFENSE={ "player", },
	BAG_CLOSED=true,
	BIND_ENCHANT=true,
	CHARACTER_POINTS_CHANGED=true,
	COMBAT_LOG_EVENT_UNFILTERED=true,
	PLAYER_REGEN_DISABLED=true,
	PLAYER_LEVEL_UP=true,
	PLAYER_TARGET_CHANGED=true,
	REPLACE_ENCHANT=true,
	GLYPH_ADDED=true,
	GLYPH_REMOVED=true,
	GLYPH_UPDATED=true,
	PLAYER_TALENT_UPDATE=true,
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
	[8] = { stat="Attributes", icon="Attributes", headerIcon="Attributes", texture=_P.."left1.png", overlay="", background=_P.."8.png", backgroundMask=true, bgTex=_P.."8.png", },
	[9] = { stat="Melee", icon="Melee", headerIcon="Melee", texture=_P.."left1.png", overlay="", background=_P.."9.png", backgroundMask=true, bgTex=_P.."9.png", },
	[10] = { stat="Defense", icon="Defense", headerIcon="Defense", texture=_P.."left1.png", overlay="", background=_P.."10.png", backgroundMask=true, bgTex=_P.."10.png", },
	[11] = { stat="Ranged", icon="Ranged", headerIcon="Ranged", texture=_P.."left1.png", overlay="", background=_P.."11.png", backgroundMask=true, bgTex=_P.."11.png", },
	[12] = { stat="Spell", icon="Spell", headerIcon="Spell", texture=_P.."left1.png", overlay="", background=_P.."12.png", backgroundMask=true, bgTex=_P.."12.png", },
	[13] = { stat="Pet", icon="Pet", headerIcon="Pet", texture=_P.."left1.png", overlay="", background=_P.."13.png", backgroundMask=true, bgTex=_P.."13.png", },
	[14] = { stat="Currency", icon="Currency", headerIcon="Currency", texture=_P.."left1.png", overlay="", background=_P.."14.png", backgroundMask=true, bgTex=_P.."14.png", },
	[15] = { stat="Misc", icon="Miscs", texture=_P.."left1.png", overlay="", background=_P.."15.png", backgroundMask=true, bgTex=_P.."15.png", },
	[16] = { stat="", },
	--[17] = { stat="FAQ", icon="Misc", },
}

	-- [8]  = { stat="Enhancement", icon="Physical", headerIcon="Physical", texture=_P.."left1.png", overlay="", background=_P.."8.png", backgroundMask=true, bgTex=_P.."8.png", },
	-- [9]  = { stat="Physical",    icon="Defense", headerIcon="Defense", texture=_P.."left1.png", overlay="", background=_P.."9.png", backgroundMask=true, bgTex=_P.."9.png", },
	-- [10] = { stat="Spell",    icon="Spell", headerIcon="Spell", texture=_P.."left1.png", overlay="", background=_P.."10.png", backgroundMask=true, bgTex=_P.."10.png", },
	-- [11] = { stat="Currency", icon="Currency", headerIcon="Currency", texture=_P.."left1.png", overlay="", background=_P.."11.png", backgroundMask=true, bgTex=_P.."11.png", },
	-- [12] = { stat="Journeys", icon="Journeys", headerIcon="Journeys", texture=_P.."left1.png", overlay="", background=_P.."12.png", backgroundMask=true, bgTex=_P.."12.png", },
	-- [13] = { stat="Misc",     icon="MiscStat", headerIcon="MiscStat", texture=_P.."left1.png", overlay="", background=_P.."13.png", backgroundMask=true, bgTex=_P.."13.png", },

------------------------------
--		Stat Options		--
------------------------------
Ns.Options = {
	-- stat options
	{ stat="Show", group=1, widget={ type="CheckBox", } },
	{ stat="CustName", group=1, widget={ type="EditBox", width=150, height=25, numeric=false, }, tooltip=true, newline=true, },
	{ stat="Enhanced_Base", group=2, spellclass="Enhanced_Base", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Enhanced", "Basic", "Both"}, newline=true, },
	{ stat="Total_Modifiers", group=2, spellclass="Total_Modifiers", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Complete", "Base", "Modifiers"}, newline=true, },
	{ stat="Percent_Rating", group=2, spellclass="Percent_Rating", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Percentage", "Rating", "Both"}, newline=true, },
	{ stat="Point_Rating", group=2, spellclass="Point_Rating", widget={ type="Radio", }, tooltip=false, default=1, labels={ "Points", "Rating", "Both"}, newline=true, },
	{ stat="Main_Off_Hand", group=2, spellclass="Main_Off_Hand", widget={ type="Radio", }, tooltip=true, default=1, labels={ "MainHand", "OffHand", "Both"}, newline=true, },
	{ stat="Level_Same_Boss", group=2, spellclass="Level_Same_Boss", widget={ type="Radio", }, tooltip=true, default=1, labels={ "SameLevel", "BossLevel", "Both"}, newline=true, },
	{ stat="Regen_Normal_Casting", group=2, spellclass="Regen_Normal_Casting", widget={ type="Radio", }, tooltip=true, default=1, labels={ "OutOfCombat", "Casting", "Both"}, newline=true, },
	{ stat="Crit_Damage_Taken", group=2, spellclass="Crit_Damage_Taken", widget={ type="Radio", }, tooltip=true, default=1, labels={ "CritTaken", "DamageTaken", "Both"}, newline=true, },
	{ stat="Total_Rating", group=2, spellclass="Total_Rating", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Total", "Rating", "Both"}, newline=true, },
	{ stat="Max_Average_Damage", group=2, spellclass="Max_Average_Damage", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Max", "Average", "Both"}, newline=true, },
	{ stat="Main_Off_Auto", group=2, spellclass="Main_Off_Auto", widget={ type="Radio", }, tooltip=true, default=1, labels={ "MainHand", "OffHand", "Auto"}, newline=true, },
	{ stat="Value_Rating", group=2, spellclass="Value_Rating", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Value", "Rating", "Both"}, newline=true, },
	{ stat="World_Realm", group=2, spellclass="World_Realm", widget={ type="Radio", }, tooltip=true, default=1, labels={ "World", "Realm", "Both"}, newline=true, },
	{ stat="Total_Equipped_Bags", group=2, spellclass="Total_Equipped_Bags", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Total", "Equipped", "Bags"}, newline=true, },
	{ stat="Heroism_Valor", group=2, spellclass="Heroism_Valor", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Heroism", "Valor", "Both"}, newline=true, },
	{ stat="Shards_Marks", group=2, spellclass="Shards_Marks", widget={ type="Radio", }, tooltip=true, default=1, labels={ "StoneKeeper", "Marks", "Both"}, newline=true, },
	{ stat="Honor_Arena", group=2, spellclass="Honor_Arena", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Honor", "Arena", "Both"}, newline=true, },
	{ stat="Player_Pet", group=2, spellclass="Player_Pet", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Player", "Pet", "Both"}, newline=true, },
	{ stat="Mood_Damage", group=2, spellclass="Mood_Damage", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Mood", "Damage", "Both"}, newline=true, },
	{ stat="Chance_Reduction", group=2, spellclass="Chance_Reduction", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Chance", "Reduction", "Both"}, newline=true, },
	{ stat="Equip_Max", group=2, spellclass="Equip_Max", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Equipped", "Max", "Both"}, newline=true, },
	--
	{ stat="Display_Average", group=2, spellclass="Display_Average", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Average"}, newline=true, },
	{ stat="Display_Basic", group=2, spellclass="Display_Basic", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Basic"}, newline=true, },
	{ stat="Display_Expertise", group=2, spellclass="Display_Expertise", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Expertise"}, newline=true, },
	{ stat="Display_MainHand", group=2, spellclass="Display_MainHand", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_MainHand"}, newline=true, },
	{ stat="Speed_Static", group=2, spellclass="Speed_Static", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Live", "Static", "Both"}, newline=true, },
	{ stat="Score_Color", group=2, spellclass="Score_Color", widget={ type="CheckBox", }, tooltip=false, default=true, labels={ "Score_Color"}, newline=true, },
	{ stat="Add_Block", group=2, spellclass="Add_Block", widget={ type="CheckBox", }, tooltip=false, default=false, labels={ "Add_Block"}, newline=true, },
	{ stat="Block_Damage", group=2, spellclass="Block_Damage", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Block_Damage"}, newline=true, },
	{ stat="Display_Special", group=2, spellclass="Display_Special", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Special"}, newline=true, },
	{ stat="Display_Simulate", group=2, spellclass="Display_Simulate", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Simulate"}, newline=true, },

	-- decimals
	{ stat="Decimals_Default", group=2, spellclass="Decimals_Default", default=0, widget={ type="Slider", min=0, max=3, valuestep=1, width=140, } , newline=true, },
	{ stat="Decimals_One", group=2, spellclass="Decimals_One", default=1, widget={ type="Slider", min=0, max=3, valuestep=1, width=140, } , newline=true, },
	{ stat="Decimals_Two", group=2, spellclass="Decimals_Two", default=2, widget={ type="Slider", min=0, max=3, valuestep=1, width=140, } , newline=true, },

	{ stat="Display_Gold", group=2, spellclass="Display_Gold", widget={ type="CheckBox", }, tooltip=false, default=false, labels={ "Display_Gold"}, newline=true, },
	{ stat="Yards_KM", group=2, spellclass="Yards_KM", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Yards", "Kilometers", "Both"}, newline=true, },
	{ stat="NPC_Players", group=2, spellclass="NPC_Players", widget={ type="Radio", }, tooltip=true, default=1, labels={ "NPC", "Players", "Both"}, newline=true, },
	{ stat="Reset_Login", group=2, spellclass="Reset_Login", widget={ type="CheckBox", }, default=false, labels={ "Reset_Login"}, newline=true, },

	{ stat="Combat_Color", group=2, spellclass="Combat_Color", widget={ type="CheckBox", }, tooltip=false, default=true, labels={ "Combat_Color"}, newline=true, },
	{ stat="Send_Chat", group=2, spellclass="Send_Chat", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Send_Chat"}, newline=true, },	
	{ stat="Timer_Format", group=2, spellclass="Timer_Format", widget={ type="DropList", data="TimerFormat", width=120, }, default=1, newline=true, },
	{ stat="Editbox_MobRange", group=2, spellclass="Editbox_MobRange", default=0, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, newline=true, },
	{ stat="Display_Short", group=2, spellclass="Display_Short", widget={ type="CheckBox", }, tooltip=false,  default=false, labels={ "Display_Short"}, newline=true, },
	{ stat="AutoColorOff", group=2, spellclass="AutoColorOff", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "AutoColorOff"}, newline=true, },
	{ stat="GradientText", group=2, spellclass="GradientText", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "GradientText"}, newline=true, },
	{ stat="Display_Total", group=2, spellclass="Display_Total", widget={ type="CheckBox", }, default=false, labels={ "Display_Total"}, newline=true, },
	{ stat="BNet_Realm", group=2, spellclass="BNet_Realm", widget={ type="Radio", }, tooltip=true, default=1, labels={ "BNet", "Realm", "Both"}, newline=true, },

	-- caps
	{ stat="Cap_Percent", group=3, spellclass="Cap_Percent", default=100, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f%%", }, },
	{ stat="Cap_Melee_Haste", group=3, spellclass="Cap_Melee_Haste", default=200, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f%%", }, },	
	{ stat="Cap_Hit", group=3, spellclass="Cap_Hit", default=8, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f%%", }, },
	{ stat="Cap_Spell_Hit", group=3, spellclass="Cap_Spell_Hit", default=17, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f%%", }, },
	{ stat="Cap_Melee_Exp", group=3, spellclass="Cap_Melee_Exp", default=26, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f", }, },	
	{ stat="Cap_Def_Def", group=3, spellclass="Cap_Def_Def", default=540, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f", }, },
	{ stat="Cap_Def_Armor", group=3, spellclass="Cap_Def_Armor", default=49905, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.0f", }, },
	{ stat="Cap_Def_Mit", group=3, spellclass="Cap_Def_Mit", default=75, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.0f%%", }, },
	{ stat="Cap_Def_Avo", group=3, spellclass="Cap_Def_Avo", default=102.4, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f%%", }, },
	{ stat="Cap_Ranged_Crit", group=3, spellclass="Cap_Ranged_Crit", default=104.8, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.1f%%", }, },
	{ stat="Cap_Ranged_ArP", group=3, spellclass="Cap_Ranged_ArP", default=1440, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.0f", }, },


	

	-- { stat="Cap_Def_Mit", group=3, spellclass="Cap_Def_Mit", default=75, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f%%", }, },
	-- { stat="Cap_Melee_Exp", group=3, spellclass="Cap_Melee_Exp", default=103, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, },
	-- { stat="Cap_Def_Def", group=3, spellclass="Cap_Def_Def", default=490, tooltip=true, widget={ type="EditBox", width=50, height=20, numeric=true, format="%.2f", }, },
	-- { stat="Cap_Def_Armor", group=3, spellclass="Cap_Def_Armor", default=35880, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, },
	

	-- Other options
	
	{ stat="Add_Speed", group=2, spellclass="Add_Speed", widget={ type="CheckBox", }, tooltip=true, default=true, labels={ "Add_Speed"}, },
	{ stat="Add_AtkSpeed", group=2, spellclass="Add_AtkSpeed", widget={ type="CheckBox", }, tooltip=true, default=true, labels={ "Add_AtkSpeed"}, },

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
	{ stat="JourneyBarMode", group=5, spellclass="JourneyBarMode", widget={ type="DropList", data="JourneyBarMode", width=120, }, default=1, baropt=true, barmode="Journey", newline=true, },
	{ stat="BarTexture", group=5, spellclass="BarTexture", widget={ type="DropList", data="BarTextures", width=170, }, default="Blizzard", baropt=true, staticopt=true, newline=true, },
	{ stat="BarColor", group=5, spellclass="BarColor", default={ r=0.2, g=0.6, b=0.2, }, widget={ type="ColorPicker", }, baropt=true, staticopt=true, newline=true, },
	{ stat="BarAutoColor", group=5, spellclass="BarAutoColor", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "BarAutoColor"}, baropt=true, linked={ "BarColor", true, }, },
	{ stat="BarAlpha", group=5, spellclass="BarAlpha", default=1, widget={ type="Slider", min=0, max=1, valuestep=0.01, width=145, }, baropt=true, staticopt=true, newline=true, },
	{ stat="BarBgColor", group=5, spellclass="BarBgColor", default={ r=0.1, g=0.1, b=0.1, }, widget={ type="ColorPicker", }, baropt=true, newline=true, },
	{ stat="BarBgAlpha", group=5, spellclass="BarBgAlpha", default=1, widget={ type="Slider", min=0, max=1, valuestep=0.01, width=145, }, baropt=true, newline=true, },
}

--------------------------
--		Class & ID		--
--------------------------
Ns.byPlayerClass = {
	["DEATHKNIGHT"] = 6,
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
		DEATHKNIGHT = {
			AP = true,
			DMG = true,
			Crit = true,
			Hit = true,
			HasteMelee = true,
			MeleeMiss = true,
			Armor = true,
			ArmorPen = true,
			Defense = true,
			BossReduc = true,
			GearScore = true,
			Speed = true,
			Durability = true,
		},
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
			GearScore = true,
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
			MP2 = true,
			GearScore = true,
			Speed = true,
			Durability = true,
		},
		MAGE = {
			Frost = true,
			Fire = true,
			SpellCrit = true,
			SpellHit = true,
			SpellPenetration = true,
			SpellMiss = true,
			HasteCaster = true,
			ManaRegen = true,
			GearScore = true,
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
			Avoidance = true,
			GearScore = true,
			Speed = true,
			Durability = true,
		},
		PRIEST = {
			Healing = true,
			Shadow = true,
			SpellCrit = true,
			SpellHit = true,
			SpellPenetration = true,
			SpellMiss = true,
			HasteCaster = true,
			ManaRegen = true,
			GearScore = true,
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
			Expertise = true,
			ArmorPen = true,
			GearScore = true,
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
			GearScore = true,
			Speed = true,
			Durability = true,
		},
		WARLOCK = {
			Shadow = true,
			SpellCrit = true,
			SpellHit = true,
			SpellPenetration = true,
			SpellMiss = true,
			HasteCaster = true,
			ManaRegen = true,
			GearScore = true,
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
			BossReduc = true,
			Resilience = true,
			GearScore = true,
			Speed = true,
			Durability = true,
		},
	}
	return class and defaults[strupper(class)] or defaults
end
