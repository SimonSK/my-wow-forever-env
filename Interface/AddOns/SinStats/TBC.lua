local AddName, Ns = ...
local L = Ns.L


------------------------------
--		Stat Options		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Melee, Ranged, World, Realm, Equipped, Overall, Level, Honor, Max, Live, Enchanted, Ingenuity = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 2
local Percentage, Rating, MainHand, OffHand, SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Average, Low, Static, Normal, Shadowflame = 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 3, 2, 1, 1
local Season, Expansion, Spark, Splinter, Gigantic, Plump, Current, Earned, Empty, Vintage = 1, 2, 1, 2, 1, 2, 1, 2, 1, 2

Ns.ConfigWidth = 975
Ns.ConfigHeight = 675

--local honorIcon = 73824
--local faction = UnitFactionGroup("player")
--if faction == "Horde" then honorIcon = 59641 end

------------------------------
--		Global Updater		--
------------------------------
function Ns.MeleeUpdate() end
function Ns.DefenseUpdate() end
function Ns.RangedUpdate() end
function Ns.SpellUpdate() end

------------------------------
--		Display Order		--
------------------------------
Ns.DefaultOrder = {
{ stat="AP", onupdate=true, events={}, spell=29834, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, Cap_Rating=true, WithBar=true, }, subgroup=true, activeonload=true, },
{ stat="RAP", onupdate=true, events={}, spell=34497, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, Cap_Rating=true, WithBar=true, }, subgroup=true, activeonload=true, },
{ stat="DMG", onupdate=true, events={}, spell=29801, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, Color_Effect=true, }, subgroup=true },
{ stat="mDPS", onupdate=true, events={}, spell=29623, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true, Color_Effect=true, }, subgroup=true },
{ stat="RDMG", onupdate=true, events={}, spell=34482, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, Color_Effect=true, }, subgroup=true },
{ stat="rDPS", onupdate=true, events={}, spell=36554, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true, Color_Effect=true, }, subgroup=true },
{ stat="Fire", onupdate=true, events={}, updatespeed=1, spell=34293, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, Enhanced_Base=true, Decimals_Default=true, }, subgroup=true, activeonload=true, },
{ stat="Frost", onupdate=true, events={}, spell=31674, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, Enhanced_Base=true, Decimals_Default=true, }, subgroup=true, },
{ stat="Arcane", onupdate=true, events={}, spell=31571, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
{ stat="Shadow", onupdate=true, events={}, spell=30293, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, Enhanced_Base=true, Decimals_Default=true, }, subgroup=true, },
{ stat="Nature", onupdate=true, events={}, spell=16578, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
{ stat="Healing", onupdate=true, events={}, spell=26022, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
{ stat="Holy", onupdate=true, events={}, spell=31837, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, Enhanced_Base=true, Decimals_Default=true, }, subgroup=true },
{ stat="Crit", onupdate=true, events={}, spell=29859, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Level_Same_Boss=true, Decimals_Two=true, Cap_Percent=true, Display_Rating=true, Display_Simulate=true, }, subgroup=true },
{ stat="CritCap", onupdate=true, events={}, spell=30819, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true, Color_Effect=true, }, subgroup=true },
{ stat="RangedCrit", onupdate=true, events={}, spell=34506, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Level_Same_Boss=true, Decimals_Two=true, Cap_Percent=true, Display_Rating=true, Display_Simulate=true}, subgroup=true },
{ stat="SpellCrit", onupdate=true, events={}, spell=30288, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Level_Same_Boss=true, Decimals_Two=true, Cap_Percent=true, Display_Rating=true, Display_Simulate=true }, subgroup=true },
{ stat="Hit", onupdate=true, events={}, spell=31241, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Hit=true, }, subgroup=true },
{ stat="RangedHit", onupdate=true, events={}, spell=34485, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Hit=true, }, subgroup=true },
{ stat="SpellHit", onupdate=true, events={}, spell=34935, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Spell_Hit=true, }, subgroup=true },
{ stat="HasteMelee", onupdate=true, events={}, spell=31244, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, }, subgroup=true },
{ stat="weaponSpeed", onupdate=true, events={}, spell=30664, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true, }, subgroup=true },
{ stat="HasteRanged", onupdate=true, events={}, spell=23989, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, }, subgroup=true },
{ stat="rangedSpeed", onupdate=true, events={}, spell=34948, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true, }, subgroup=true },
{ stat="HasteCaster", onupdate=true, events={}, spell=30060, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, }, subgroup=true, },
{ stat="ArmorPenetration", onupdate=true, events={}, spell=26866, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Decimals_Two=true, Cap_Percent=true, }, subgroup=true },
{ stat="BossReduc", onupdate=true, events={}, spell=20164, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true, Color_Effect=true, }, subgroup=true, },
{ stat="Expertise", onupdate=true, events={}, spell=30920, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Melee_Exp=true, Display_Simulate=true, Exp_Add=true }, subgroup=true },
{ stat="MeleeMiss", onupdate=true, events={}, spell=1329, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, WithBar="MeleeMiss", Level_Same_Boss=true, Decimals_Two=true, Display_Simulate=true, }, subgroup=true },
{ stat="Avoidance", onupdate=true, events={}, spell=31223, spellclass="Defensive", widget={ type="CheckBox" }, options={ Show=true, WithBar="Avoidance", Decimals_Two=true, Color_Effect=true, }, subgroup=true, activeonload=true, },
{ stat="Crushing", onupdate=true, events={}, spell=32175, spellclass="Defensive", widget={ type="CheckBox" }, options={ Show=true, WithBar="Crushing", Decimals_Two=true, Color_Effect=true, }, subgroup=true },
{ stat="CritReceived", onupdate=true, events={}, spell=33856, spellclass="Defensive", widget={ type="CheckBox" }, options={ Chance_Reduction=true, Decimals_Two=true, Display_Simulate=true, WithBar="CritReceived", Color_Effect=true, }, subgroup=true },
{ stat="EHP", onupdate=true, events={}, spell=31837, spellclass="Defensive", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, Cap_Ehp=true, WithBar=true }, subgroup=true },
{ stat="RangedMiss", onupdate=true, events={}, spell=34460, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, WithBar="RangedMiss", Level_Same_Boss=true, Decimals_Two=true, Display_Simulate=true, }, subgroup=true },
{ stat="SpellPenetration", onupdate=true, events={}, spell=11242, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true, }, subgroup=true },
{ stat="SpellMiss", onupdate=true, events={}, spell=30108, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, WithBar="SpellMiss", Level_Same_Boss=true, Decimals_Two=true, Display_Simulate=true, }, subgroup=true },
{ stat="ManaRegen", onupdate=true, events={}, spell=31833, spellclass="Spell", widget={ type="CheckBox" }, options={ Regen_Normal_Casting=true, Decimals_Two=true, }, subgroup=true },
{ stat="MP5", onupdate=true, events={}, spell=34861, spellclass="Spell", widget={ type="CheckBox" }, options={ Regen_Normal_Casting=true, Decimals_Two=true, }, subgroup=true, },
{ stat="Resilience", onupdate=true, events={}, spell=29623, spellclass="Defensive", widget={ type="CheckBox" }, options={ Crit_Damage_Taken=true, Display_Rating=true, Cap_Rating=true, Decimals_Two=true, }, subgroup=true },
{ stat="Armor", onupdate=true, events={}, spell=29140, spellclass="Defensive", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, Cap_Def_Armor=true, WithBar="Armor"}, subgroup=true },
{ stat="Stamina", onupdate=true, events={}, spell=25389, spellclass="Defensive", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, Color_Effect=true, }, subgroup=true },
{ stat="NPCArmor", onupdate=true, events={}, spell=44520, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
{ stat="DMGReduc", onupdate=true, events={}, spell=871, spellclass="Defensive", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true, Cap_Def_Mit=true, WithBar="DMGReduc" }, subgroup=true },
{ stat="Defense", onupdate=true, events={}, spell=32700, spellclass="Defensive", widget={ type="CheckBox" }, options={ Total_Rating=true, Display_Basic=true, Decimals_Default=true, Cap_Def_Def=true, WithBar="Defense", }, subgroup=true },
{ stat="Dodge", onupdate=true, events={}, spell=13981, spellclass="Defensive", widget={ type="CheckBox" }, options={ Percent_Rating=true, Decimals_Two=true, Display_Simulate=true, }, subgroup=true },
{ stat="Parry", onupdate=true, events={}, spell=3127, spellclass="Defensive", widget={ type="CheckBox" }, options={ Percent_Rating=true, Decimals_Two=true, Display_Simulate=true, }, subgroup=true },
{ stat="Block", onupdate=true, events={}, spell=2565, spellclass="Defensive", widget={ type="CheckBox" }, options={ Percent_Rating=true, Decimals_Two=true, Display_Simulate=true, }, subgroup=true },
{ stat="FireResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=18459, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, Color_Effect=true, Cap_Rating=true, WithBar=true, }, subgroup=true, activeonload=true, },
{ stat="FrostResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=31667, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, Color_Effect=true, Cap_Rating=true, WithBar=true, }, subgroup=true },
{ stat="ShadowResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=30283, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, Color_Effect=true, Cap_Rating=true, WithBar=true, }, subgroup=true },
{ stat="ArcaneResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=16850, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, Color_Effect=true, Cap_Rating=true, WithBar=true, }, subgroup=true },
{ stat="NatureResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=30675, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, Color_Effect=true, Cap_Rating=true, WithBar=true, }, subgroup=true },
{ stat="Speed", onupdate=true, events={}, updatespeed=1, spell=31641, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar="Speed", Show=true, Color_Effect=true, }, subgroup=true, activeonload=true, },
{ stat="TargetSpeed", onupdate=true, events={}, spell=31641, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Color_Effect=true, }, subgroup=true },
{ stat="Durability", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=3100, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar="Dura", Show=true, AutoColorOff=true }, subgroup=true },
{ stat="BuffCounter", onupdate=true, events={}, spell=22888, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="DebuffCounter", onupdate=true, events={}, spell=23154, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="Travel", onupdate=true, events={}, updatespeed=1, spell=1850, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Yards_KM=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
{ stat="Jump", onupdate=true, events={}, spell=40493, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
--{ stat="KillCounter", events={ NAME_PLATE_UNIT_ADDED=true, NAME_PLATE_UNIT_REMOVED=true, }, spell=5308, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, NPC_Players=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
{ stat="CombatTimer", onupdate=true, events={}, updatespeed=1, spell=34712, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Combat_Color=true, Timer_Format=true, }, subgroup=true },
{ stat="InstanceTimer", onupdate=true, events={}, updatespeed=1, spell=36212, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Timer_Format=true, Send_Chat=true, }, subgroup=true },
--{ stat="MobCounter", events={ NAME_PLATE_UNIT_ADDED=true, NAME_PLATE_UNIT_REMOVED=true, }, spell=199483, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Editbox_MobRange=true, }, subgroup=true },
{ stat="Lag", onupdate=true, events={}, spell=33592, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="FPS", onupdate=true, events={}, spell=19498, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Color_Effect=true, }, subgroup=true },
{ stat="Money", onupdate=true, events={}, spell=921, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="Guild", events={ GUILD_ROSTER_UPDATE=true, }, item=23705, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, Show=true, Display_Total=true }, subgroup=true },
{ stat="Friends", events={ FRIENDLIST_UPDATE=true, BN_FRIEND_INFO_CHANGED=true, }, item=22260, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, BNet_Realm=true }, subgroup=true },
}

------------------------------
--		Global Events		--
------------------------------
Ns.GlobalEvents = {
	UNIT_AURA={ "player", "target", },
	UNIT_INVENTORY_CHANGED={ "player", },
	UNIT_STATS={ "player", },
	UPDATE_INVENTORY_DURABILITY=true,
	UPDATE_FACTION=true,
	BIND_ENCHANT=true,
	CHARACTER_POINTS_CHANGED=true,
	PLAYER_LEVEL_UP=true,
	PLAYER_TARGET_CHANGED=true,
	REPLACE_ENCHANT=true,
	GET_ITEM_INFO_RECEIVED=true,
	TRAIT_CONFIG_UPDATED=true,
	MASTERY_UPDATE=true,
	UNIT_RESISTANCES={ "player", },
	UNIT_DAMAGE=true,
	UNIT_RANGEDDAMAGE=true,
	UNIT_ATTACK_POWER=true,
	UNIT_RANGED_ATTACK_POWER=true,
	UNIT_DEFENSE={ "player", },
	BAG_CLOSED=true,
	COMBAT_LOG_EVENT_UNFILTERED=true,
	PLAYER_REGEN_DISABLED=true,
	INSPECT_READY=true,
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
	[4] = { stat="Panels", grp=Ns.PanelGroupOrder, order=Ns.PanelDisplayOrder, icon="HUDStudio", },
	[5] = { stat="Profiles", grp=Ns.ProfileGroupOrder, order=Ns.ProfileDisplayOrder, icon="Profiles", },
	[6] = { stat="", },
	[7] = { stat="Search", icon="Search", },
	[8] = { stat="Melee", icon="Physical", headerIcon="Physical", texture=_P.."left1.png", overlay="", background=_P.."8.png", backgroundMask=true, bgTex=_P.."8.png", },
	[9] = { stat="Defensive", icon="Defense", headerIcon="Defense", texture=_P.."left1.png", overlay="", background=_P.."10.png", backgroundMask=true, bgTex=_P.."10.png", },
	[10] = { stat="Ranged", icon="Ranged", headerIcon="Ranged", texture=_P.."left1.png", overlay="", background=_P.."9.png", backgroundMask=true, bgTex=_P.."9.png", },
	[11] = { stat="Spell", icon="Spell", headerIcon="Spell", texture=_P.."left1.png", overlay="", background=_P.."11.png", backgroundMask=true, bgTex=_P.."11.png", },
	[12] = { stat="Resistance", icon="Resistance", headerIcon="Resistance", texture=_P.."left1.png", overlay="", background=_P.."14.png", backgroundMask=true, bgTex=_P.."14.png", },
	[13] = { stat="Misc", icon="Miscs", headerIcon="MiscStat", texture=_P.."left1.png", overlay="", background=_P.."13.png", backgroundMask=true, bgTex=_P.."13.png", },
	[14] = { stat="", },
	--[15] = { stat="FAQ", icon="Misc", },
}


------------------------------
--		Stat Options		--
------------------------------
Ns.Options = {
	{ stat="Show", group=1, widget={ type="CheckBox", } },
	{ stat="CustName", group=1, widget={ type="EditBox", width=150, height=25, numeric=false, }, tooltip=true, newline=true },
	{ stat="Level_Same_Boss", group=2, spellclass="Level_Same_Boss", widget={ type="Radio", }, tooltip=true, default=1, labels={ "SameLevel", "BossLevel", "Both"}, newline=true },
	{ stat="Regen_Normal_Casting", group=2, spellclass="Regen_Normal_Casting", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Regen", "Casting", "Both"}, newline=true },
	{ stat="Enhanced_Base", group=2, spellclass="Enhanced_Base", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Enhanced", "Base", "Both"}, newline=true, },
	{ stat="Percent_Rating", group=2, spellclass="Percent_Rating", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Percentage", "Rating", "Both"}, newline=true, },
	{ stat="Crit_Damage_Taken", group=2, spellclass="Crit_Damage_Taken", widget={ type="Radio", }, tooltip=true, default=1, labels={ "CritTaken", "DamageTaken", "Both"}, newline=true, },
	{ stat="Chance_Reduction", group=2, spellclass="Chance_Reduction", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Chance", "Reduction", "Both"}, newline=true, },
	{ stat="Total_Rating", group=2, spellclass="Total_Rating", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Total", "Rating", "Both"}, newline=true, },
	{ stat="Display_Rating", group=2, spellclass="Display_Rating", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Rating"}, newline=true },
	{ stat="Display_Basic", group=2, spellclass="Display_Basic", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Basic"}, newline=true },
	{ stat="Display_Simulate", group=2, spellclass="Display_Simulate", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Simulate"}, newline=true },
	{ stat="Color_Effect", group=2, spellclass="Color_Effect", widget={ type="CheckBox", }, tooltip=true, default=true, labels={ "Color_Effect"}, newline=true, },
	{ stat="Exp_Add", group=2, spellclass="Exp_Add", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Exp_Add"}, newline=true, },
	-- decimals
	{ stat="Decimals_Default", group=2, spellclass="Decimals_Default", default=0, widget={ type="Slider", min=0, max=3, valuestep=1, width=140, } , newline=true, },
	{ stat="Decimals_Two", group=2, spellclass="Decimals_Two", default=2, widget={ type="Slider", min=0, max=3, valuestep=1, width=140, } , newline=true, },

	-- caps
	{ stat="Cap_Percent", group=3, spellclass="Cap_Percent", default=100, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f%%", }, },
	{ stat="Cap_Rating", group=3, spellclass="Cap_Rating", default=0, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f", }, newline=true, },
	{ stat="Cap_Hit", group=3, spellclass="Cap_Hit", default=9, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f%%", }, },
	{ stat="Cap_Spell_Hit", group=3, spellclass="Cap_Spell_Hit", default=16, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.2f%%", }, },	
	{ stat="Cap_Def_Mit", group=3, spellclass="Cap_Def_Mit", default=75, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f%%", }, },
	{ stat="Cap_Melee_Exp", group=3, spellclass="Cap_Melee_Exp", default=103, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, },
	{ stat="Cap_Def_Def", group=3, spellclass="Cap_Def_Def", default=490, tooltip=true, widget={ type="EditBox", width=50, height=20, numeric=true, format="%.2f", }, },
	{ stat="Cap_Def_Armor", group=3, spellclass="Cap_Def_Armor", default=35880, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, },
	{ stat="Cap_Ehp", group=3, spellclass="Cap_Ehp", default=54000, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, },

	-- other widgets
	{ stat="Editbox_D", group=2, spellclass="Editbox_D", default=8, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, newline=true, },
	{ stat="Display_Delves", group=2, spellclass="Display_Delves", widget={ type="CheckBox", }, tooltip=false, default=false, labels={ "Display_Delves"}, },
	{ stat="AutoColorOff", group=2, spellclass="AutoColorOff", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "AutoColorOff"}, newline=true, },
	{ stat="GradientText", group=2, spellclass="GradientText", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "GradientText"}, newline=true, },

	{ stat="Display_Total", group=2, spellclass="Display_Total", widget={ type="CheckBox", }, default=false, labels={ "Display_Total"}, newline=true, },
	{ stat="Yards_KM", group=2, spellclass="Yards_KM", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Yards", "Kilometers", "Both"}, newline=true, },
	{ stat="NPC_Players", group=2, spellclass="NPC_Players", widget={ type="Radio", }, tooltip=true, default=1, labels={ "NPC", "Players", "Both"}, newline=true, },
	{ stat="Reset_Login", group=2, spellclass="Reset_Login", widget={ type="CheckBox", }, default=false, labels={ "Reset_Login"}, newline=true, },
	{ stat="Combat_Color", group=2, spellclass="Combat_Color", widget={ type="CheckBox", }, tooltip=false, default=true, labels={ "Combat_Color"}, newline=true, },
	{ stat="Send_Chat", group=2, spellclass="Send_Chat", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Send_Chat"}, newline=true, },	
	{ stat="Timer_Format", group=2, spellclass="Timer_Format", widget={ type="DropList", data="TimerFormat", width=120, }, default=1, newline=true, },
	{ stat="Editbox_MobRange", group=2, spellclass="Editbox_MobRange", default=0, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, newline=true, },
	{ stat="BNet_Realm", group=2, spellclass="BNet_Realm", widget={ type="Radio", }, tooltip=true, default=1, labels={ "BNet", "Realm", "Both"}, newline=true, },

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
--10.0 DF
	["EVOKER"] = 13,
--7.0 Legion
	["DEMONHUNTER"] = 12,
--5.0 Pandaria
	["MONK"] = 10,
--3.0 Wrath
	["DEATHKNIGHT"] = 6,
--1.0 Classic
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

--1.0 Classic
		DRUID = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			AP = true,
			SpellPower = true,
			Intellect = true,
			ManaRegen = true,
			EnergyRegen = true,
			Speed = true,
			Durability = true,
		},
		HUNTER = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Agility = true,
			Mastery = true,
			AP = true,
			Speed = true,
			Durability = true,
		},
		MAGE = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Intellect = true,
			SpellPower = true,
			ManaRegen = true,
			Speed = true,
			Durability = true,
		},
		PALADIN = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Intellect = true,
			ManaRegen = true,
			Healing = true,
			Speed = true,
			Durability = true,
		},
		PRIEST = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Intellect = true,
			ManaRegen = true,
			SpellPower = true,
			Healing = true,
			Speed = true,
			Durability = true,
		},
		ROGUE = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Agility = true,
			AP = true,
			EnergyRegen = true,
			Dodge = true,
			Speed = true,
			Durability = true,
		},
		SHAMAN = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Intellect = true,
			ManaRegen = true,
			SpellPower = true,
			Healing = true,
			Speed = true,
			Durability = true,
		},
		WARLOCK = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Intellect = true,
			SpellPower = true,
			Speed = true,
			Durability = true,
		},
		WARRIOR = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Strength = true,
			AP = true,
			Armor = true,
			Block = true,
			Dodge = true,
			Speed = true,
			Durability = true,
		},
	}
	return class and defaults[strupper(class)] or defaults
end
