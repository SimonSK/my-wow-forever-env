local AddName, Ns = ...
local L = Ns.L


------------------------------
--		Stat Options		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Melee, Ranged, World, Realm, Equipped, Overall, Level, Honor, Max, Live, Enchanted, Ingenuity = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 2
local Percentage, Rating, MainHand, OffHand, SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Average, Low, Static, Normal, Shadowflame = 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 3, 2, 1, 1
local Season, Expansion, Spark, Splinter, Gigantic, Plump, Current, Earned, Empty, Vintage, Core, Shard, Key, Name = 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2
local Spec, Hero, Mythical, Heroic = 1, 2, 1, 2

Ns.ConfigWidth = 975--990
Ns.ConfigHeight = 675--540
-- if GetLocale() == "frFR" or GetLocale() == "zhCN" or GetLocale() == "zhTW" or GetLocale() == "koKR" then
-- 	Ns.ConfigWidth = 960
-- end

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
Ns.DefaultOrder = { -- grp = SpellClass, options order = display order, ["on"]/["off"] option is implied in all stats so not required in the table. The [1]..[2] not required but just for example
{ stat="Primary", onupdate=true, events={}, spell=261769, spellclass="Enhancement", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Auto_Name=true, Decimals_Default=true }, subgroup=true, activeonload=true, },
{ stat="CritChance", onupdate=true, events={}, spell=1217605, spellclass="Enhancement", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, Cap_Rating=true, DR_Display=true, DR_Gradient=true }, subgroup=true, },
{ stat="Haste", onupdate=true, events={}, spell=342245, spellclass="Enhancement", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, Cap_Rating=true, DR_Display=true, DR_Gradient=true }, subgroup=true },
{ stat="Mastery", onupdate=true, events={}, spell=207684, spellclass="Enhancement", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, Cap_Rating=true, DR_Display=true, DR_Gradient=true }, subgroup=true },
{ stat="Versatility", onupdate=true, events={}, spell=202137, spellclass="Enhancement", widget={ type="CheckBox" }, options={ WithBar=true, Damage_Taken=true, Display_Rating=true, Rating_Only=true, Decimals_Two=true, Cap_Percent=true, DR_Display=true, DR_Gradient=true, }, subgroup=true },
{ stat="Avoidance", onupdate=true, events={}, spell=202138, spellclass="Enhancement", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, Cap_Rating=true }, subgroup=true },
{ stat="Leech", onupdate=true, events={}, spell=204021, spellclass="Enhancement", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, Cap_Rating=true }, subgroup=true },
{ stat="Speed", onupdate=true, events={}, updatespeed=1, spell=109215, spellclass="Enhancement", widget={ type="CheckBox" }, options={ WithBar="Speed", Speed_Static=true, Speed_Color=true, Speed_Mode=true, Speed_Unit=true, Speed_Secret=true, Decimals_Default=true }, subgroup=true },
{ stat="Strength", onupdate=true, events={}, spell=48743, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true, activeonload=true, },
{ stat="Agility", onupdate=true, events={}, spell=319032, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
{ stat="Intellect", onupdate=true, events={}, spell=23030, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true, activeonload=true, },
{ stat="AP", onupdate=true, events={}, spell=29838, spellclass="Physical", widget={ type="CheckBox" }, options={ Melee_Ranged=true, Decimals_Default=true }, subgroup=true },
{ stat="DMG", onupdate=true, events={}, spell=315720, spellclass="Physical", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, Display_MainHand=true, Decimals_Default=true }, subgroup=true },
{ stat="DMGMod", onupdate=true, events={}, spell=152175, spellclass="Physical", widget={ type="CheckBox" }, options={ Melee_Ranged=true, Decimals_Default=true }, subgroup=true },
{ stat="DPS", onupdate=true, events={}, spell=115080, spellclass="Physical", widget={ type="CheckBox" }, options={ Melee_Ranged=true, Display_MainHand=true, Decimals_Default=true }, subgroup=true },
{ stat="SpellPower", onupdate=true, events={}, spell=321358, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
{ stat="DMGModSpell", onupdate=true, events={}, spell=385899, spellclass="Spell", widget={ type="CheckBox" }, options={ Decimals_Default=true }, subgroup=true },
{ stat="Healing", onupdate=true, events={}, spell=2050, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
{ stat="weaponSpeed", onupdate=true, events={}, spell=321281, spellclass="Physical", widget={ type="CheckBox" }, options={ Melee_Ranged=true, Decimals_Two=true }, subgroup=true },
{ stat="ManaRegen", onupdate=true, events={}, spell=63733, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="EnergyRegen", onupdate=true, events={}, spell=212283, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_One=true }, subgroup=true },
{ stat="Stamina", onupdate=true, events={}, spell=320380, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, Decimals_Default=true }, subgroup=true },
{ stat="Mitigation", onupdate=true, events={}, spell=155147, spellclass="Physical", widget={ type="CheckBox" }, options={ Show=true, Decimals_One=true }, subgroup=true },
{ stat="Armor", onupdate=true, events={}, spell=321708, spellclass="Physical", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Dodge", onupdate=true, events={}, spell=115008, spellclass="Physical", widget={ type="CheckBox" }, options={ Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, Cap_Rating=true }, subgroup=true },
{ stat="Parry", onupdate=true, events={}, spell=118038, spellclass="Physical", widget={ type="CheckBox" }, options={ Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, Cap_Rating=true  }, subgroup=true },
{ stat="Block", onupdate=true, events={}, spell=203177, spellclass="Physical", widget={ type="CheckBox" }, options={ Percent_Rating=true, Decimals_Two=true, Cap_Percent=true, Cap_Rating=true  }, subgroup=true },
{ stat="Absorb", events={ UNIT_ABSORB_AMOUNT_CHANGED=true, }, spell=343744, spellclass="Physical", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
{ stat="Stagger", onupdate=true, events={}, spell=280195, spellclass="Physical", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true }, subgroup=true },
{ stat="Delver", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, spell=471521, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true, }, subgroup=true, activeonload=true, },
{ stat="Kindojan", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, currency=3537, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true,  }, subgroup=true },
{ stat="Companion", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, spell=220172, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true, }, subgroup=true, },
{ stat="Prey", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, currency=3386, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true, }, subgroup=true, },
{ stat="Ritual", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, currency=3428, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true,  }, subgroup=true },
{ stat="Zuljarra", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, currency=3504, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true,  }, subgroup=true },
{ stat="Aqir", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, item=286563, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true,  }, subgroup=true },
{ stat="Tokka", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, currency=3540, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true,  }, subgroup=true },
{ stat="Silvermoon", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, currency=3365, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true,  }, subgroup=true },
{ stat="Amani", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, currency=3354, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true,  }, subgroup=true },
{ stat="Arati", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, currency=3370, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true,  }, subgroup=true },
{ stat="Singularity", events={ MAJOR_FACTION_RENOWN_LEVEL_CHANGED=true, UPDATE_FACTION=true, }, currency=3389, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Journey", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true,  }, subgroup=true },
{ stat="Slayer", events={ UPDATE_FACTION=true, }, currency=3410, spellclass="Journeys", widget={ type="CheckBox" }, options={ WithBar="Rep", Rank_Rep=true, Display_Percentage=true, Decimals_Default=true, }, subgroup=true },
{ stat="Delves", events={ SCENARIO_COMPLETED=true, WALK_IN_DATA_UPDATE=true, QUEST_TURNED_IN=true, WEEKLY_REWARDS_UPDATE=true, }, currency=3386, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Display_All=true, Editbox_DP=true, Display_Tier8=true, Vault_Tooltip=true, WithBar="DelvesPrey, "}, subgroup=true, activeonload=true,},
--{ stat="Delves", events={ WEEKLY_REWARDS_UPDATE=true, SCENARIO_COMPLETED=true, WALK_IN_DATA_UPDATE=true}, spell=471521, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Editbox_D=true, Display_Delves=true, }, subgroup=true, },
{ stat="GreatVault", events={ WEEKLY_REWARDS_UPDATE=true, }, item=228942, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Raids_Dungeons=true, Display_Weekly=true, WithBar="GreatVault", }, subgroup=true },
{ stat="MythicPlus", events={ CHALLENGE_MODE_COMPLETED=true, }, item=138019, spellclass="Misc", widget={ type="CheckBox" }, options={ Season_Exp=true }, subgroup=true, },
{ stat="Keystone", events={ UNIT_INVENTORY_CHANGED=true, }, item=180653, spellclass="Misc", widget={ type="CheckBox" }, options={ Key_Name=true, Abbrev=true }, subgroup=true, },
{ stat="Threat", onupdate=true, events={}, spell=185245, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, Percent_Rating=true, GradientText=true }, subgroup=true },
{ stat="ItemLevel", onupdate=true, events={}, spell=48792, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Equipped_Overall=true, Decimals_Two=true }, subgroup=true },
{ stat="PvPiLvl", onupdate=true, events={}, spell=347503, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true }, subgroup=true },
{ stat="TargetSpeed", onupdate=true, events={}, spell=52358, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="Durability", events={ UPDATE_INVENTORY_DURABILITY=true, PLAYER_ENTERING_WORLD=true, BAG_UPDATE_DELAYED=true, }, spell=3100, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, Show=true, AutoColorOff=true }, subgroup=true },
{ stat="GlobalCD", events={ UNIT_SPELLCAST_SUCCEEDED={ "player" }, }, spell=363929, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Decimals_Two=true }, subgroup=true },
{ stat="Adventurer", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3442, spellclass="Currency", widget={ type="CheckBox" }, options={ WithBar="Crest", Current_Earned=true, Display_Max=true, Display_Weekly=true }, subgroup=true, activeonload=true, },
{ stat="Veteran", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3443, spellclass="Currency", widget={ type="CheckBox" }, options={ WithBar="Crest", Current_Earned=true, Display_Max=true, Display_Weekly=true }, subgroup=true },
{ stat="Champion", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3444, spellclass="Currency", widget={ type="CheckBox" }, options={ WithBar="Crest", Current_Earned=true, Display_Max=true, Display_Weekly=true  }, subgroup=true },
{ stat="Hero", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3445, spellclass="Currency", widget={ type="CheckBox" }, options={ WithBar="Crest", Current_Earned=true, Display_Max=true, Display_Weekly=true  }, subgroup=true },
{ stat="Myth", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3446, spellclass="Currency", widget={ type="CheckBox" }, options={ WithBar="Crest", Current_Earned=true, Display_Max=true, Display_Weekly=true  }, subgroup=true },
{ stat="Catalyst", events={ UNIT_INVENTORY_CHANGED=true, }, currency=3465, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Display_Max=true, }, subgroup=true },
{ stat="Voidcore", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3418, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Ascendant", events={ UNIT_INVENTORY_CHANGED=true, }, item=280562, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, WithBar="Ascendant", }, subgroup=true, },
{ stat="Mythical", events={ UNIT_INVENTORY_CHANGED=true, }, item=285065, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Myth_Hero=true, }, subgroup=true, },
{ stat="Spark", events={ UNIT_INVENTORY_CHANGED=true, }, item=274476, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Splint_Spark=true, Display_Max=true, WithBar="Spark", }, subgroup=true },
{ stat="Stash", events={ WALK_IN_DATA_UPDATE=true, MINIMAP_UPDATE_ZOOM=true, }, spell=1216211, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, WithBar="Stash" }, subgroup=true },
{ stat="CofferKey", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3310, spellclass="Currency", widget={ type="CheckBox" }, options={ Current_Earned=true, Decimals_Default=true, Display_Max=true, Display_Weekly=true, WithBar="CofferKey", }, subgroup=true },
{ stat="RestoredKey", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3028, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true }, subgroup=true },
{ stat="Undercoin", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=2803, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="ManaCrystals", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3356, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, Display_Max=true, }, subgroup=true },
{ stat="Corrosive", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3448, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="CorroSoul", events={ UNIT_INVENTORY_CHANGED=true, }, item=273000, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Venom", events={ UNIT_INVENTORY_CHANGED=true, }, item=279382, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="AqirToken", events={ UNIT_INVENTORY_CHANGED=true, }, item=286563, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true }, subgroup=true },
{ stat="Ossified", events={ UNIT_INVENTORY_CHANGED=true, }, item=274422, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="VoidVestige", events={ UNIT_INVENTORY_CHANGED=true, }, item=279576, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Accolade", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3405, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="DarkParticle", events={ UNIT_INVENTORY_CHANGED=true, }, item=267051, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="CoiledFil", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3546, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="AnglerPearls", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3373, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Voidlight", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3316, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Illusionary", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3393, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, }, subgroup=true },
{ stat="Anguish", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3392, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Arcana", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3379, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Abundance", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3377, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Dundun", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3376, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="VoidSample", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3377, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true }, subgroup=true },
{ stat="Luminous", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3385, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Skyshards", events={ UNIT_INVENTORY_CHANGED=true, }, item=255826, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="VileEssence", events={ UNIT_INVENTORY_CHANGED=true, }, item=259361, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="MarkHonor", events={ UNIT_INVENTORY_CHANGED=true, }, item=137642, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="ValorPoints", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=1191, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="BloodyTokens", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=2123, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="Honor", events={ CURRENCY_DISPLAY_UPDATE=true, }, spell=269083, spellclass="Currency", widget={ type="CheckBox" }, options={ Level_HonorPoints=true, Display_Rated=true, }, subgroup=true },
{ stat="Conquest", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=1602, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Timewarped", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=1166, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Coupons", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3363, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="TraderTender", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=2032, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Brewfest", events={ UNIT_INVENTORY_CHANGED=true, }, item=37829, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true }, subgroup=true },
{ stat="Darkmoon", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=515, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true }, subgroup=true },
{ stat="Coordinates", onupdate=true, events={}, updatespeed=1, item=140731, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Decimals_One=true }, subgroup=true },
{ stat="Travel", onupdate=true, events={}, updatespeed=1, spell=87840, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Yards_KM=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
{ stat="Jump", onupdate=true, events={}, spell=6544, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
--{ stat="KillCounter", events={ NAME_PLATE_UNIT_ADDED=true, NAME_PLATE_UNIT_REMOVED=true, }, spell=5308, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, NPC_Players=true, Reset_Login=true, Reset_Counter=true, }, subgroup=true },
--{ stat="EnemiesSlain", events={ PARTY_KILL=true, }, spell=5308, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Player_Party=true, Reset_Login=false, Reset_Counter=true, }, subgroup=true },
{ stat="CombatTimer", onupdate=true, events={}, updatespeed=1, spell=69042, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Combat_Color=true, Timer_Format=true, }, subgroup=true },
{ stat="InstanceTimer", onupdate=true, events={}, updatespeed=1, spell=390692, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Timer_Format=true, Send_Chat=true, }, subgroup=true },
----{ stat="MobCounter", events={ NAME_PLATE_UNIT_ADDED=true, NAME_PLATE_UNIT_REMOVED=true, }, spell=199483, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Editbox_MobRange=true, }, subgroup=true },
{ stat="Spec", events={ TRAIT_CONFIG_UPDATED=true, }, spell=674, spellclass="Misc", widget={ type="CheckBox" }, options={ Spec_Hero=true, Abbrev=true, }, subgroup=true },
{ stat="Loadout", events={ TRAIT_CONFIG_UPDATED=true, }, spell=292271, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="Lag", onupdate=true, events={}, spell=190447, spellclass="Misc", widget={ type="CheckBox" }, options={ World_Realm=true, }, subgroup=true },
{ stat="FPS", onupdate=true, events={}, updatespeed=1, spell=6196, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
{ stat="Gold", events={ PLAYER_MONEY=true, }, spell=303624, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Display_Gold=true, Decimals_Default=true, }, subgroup=true },
{ stat="WowToken", onupdate=true, events={}, item=122284, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Default=true, Cap_Token=true, }, subgroup=true },
{ stat="Guild", events={ GUILD_ROSTER_UPDATE=true, }, item=69210, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, Show=true, Display_Total=true }, subgroup=true },
{ stat="Friends", events={ FRIENDLIST_UPDATE=true, BN_FRIEND_INFO_CHANGED=true, }, spell=456726, spellclass="Misc", widget={ type="CheckBox" }, options={ WithBar=true, BNet_Realm=true }, subgroup=true },
--{ stat="RepairCost", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=52774, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Display_Gold=true, Decimals_Default=true }, subgroup=true },
}

-- unused entries (seasonal, etc)
--{ stat="LoveToken", events={ UNIT_INVENTORY_CHANGED=true, }, item=49927, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true }, subgroup=true },
--{ stat="Puzzling", events={ UNIT_INVENTORY_CHANGED=true, }, item=250741, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true }, subgroup=true },
--{ stat="CofferKey", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3028, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true }, subgroup=true },
--{ stat="Bronze", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=3252, spellclass="Currency", widget={ type="CheckBox" }, options={ Show=true, Decimals_Bronze=true, Decimals_Default=true }, subgroup=true },



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
	[8]  = { stat="Enhancement", icon="Physical", headerIcon="Physical", texture=_P.."left1.png", overlay="", background=_P.."8.png", backgroundMask=true, bgTex=_P.."8.png", },
	[9]  = { stat="Physical",    icon="Defense", headerIcon="Defense", texture=_P.."left1.png", overlay="", background=_P.."9.png", backgroundMask=true, bgTex=_P.."9.png", },
	[10] = { stat="Spell",    icon="Spell", headerIcon="Spell", texture=_P.."left1.png", overlay="", background=_P.."10.png", backgroundMask=true, bgTex=_P.."10.png", },
	[11] = { stat="Currency", icon="Currency", headerIcon="Currency", texture=_P.."left1.png", overlay="", background=_P.."11.png", backgroundMask=true, bgTex=_P.."11.png", },
	[12] = { stat="Journeys", icon="Journeys", headerIcon="Journeys", texture=_P.."left1.png", overlay="", background=_P.."12.png", backgroundMask=true, bgTex=_P.."12.png", },
	[13] = { stat="Misc",     icon="MiscStat", headerIcon="MiscStat", texture=_P.."left1.png", overlay="", background=_P.."13.png", backgroundMask=true, bgTex=_P.."13.png", },
	[14] = { stat="", },
	--[15] = { stat="FAQ", icon="Misc", },
}

------------------------------
--		Stat Options		--
------------------------------
Ns.Options = {
	{ stat="Show", group=1, widget={ type="CheckBox", } },
	{ stat="Auto_Name", group=1, spellclass="Auto_Name", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Auto_Name"}, newline=true, },
	{ stat="CustName", group=1, widget={ type="EditBox", width=150, height=25, numeric=false, }, tooltip=true, newline=true, },
	{ stat="Enhanced_Base", group=2, spellclass="Enhanced_Base", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Enhanced", "Base", "Both"}, newline=true, },
	{ stat="Percent_Rating", group=2, spellclass="Percent_Rating", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Percentage", "Rating", "Both"}, newline=true, },
	{ stat="Damage_Taken", group=2, spellclass="Damage_Taken", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Damage", "DamageTaken", "Both"}, newline=true, },
	{ stat="Melee_Ranged", group=2, spellclass="Melee_Ranged", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Melee", "Ranged", "Both"},newline=true, },
	{ stat="Display_Average", group=2, spellclass="Display_Average", widget={ type="CheckBox", }, tooltip=true,  default=false, labels={ "Display_Average"}, newline=true, },
	{ stat="World_Realm", group=2, spellclass="World_Realm", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "World", "Realm", "Both"}, newline=true, },
	{ stat="Player_Party", group=2, spellclass="Player_Party", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Player", "Party", "Both"}, newline=true, },
	{ stat="Equipped_Overall", group=2, spellclass="Equipped_Overall", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Equipped", "Max", "Both"}, newline=true, },
	{ stat="Level_HonorPoints", group=2, spellclass="Level_HonorPoints", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Level", "Honor", "Both"}, newline=true, },
	{ stat="Max_Average_Damage", group=2, spellclass="Max_Average_Damage", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Max", "Average", "Low"}, newline=true, },
	{ stat="Current_Earned", group=2, spellclass="Current_Earned", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Current", "Earned", "Both"}, newline=true, },
	{ stat="Myth_Hero", group=2, spellclass="Myth_Hero", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Mythical", "Heroic", "Both"}, newline=true, },
	{ stat="Rank_Rep", group=2, spellclass="Rank_Rep", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Rank", "Rep", "Both"}, newline=true, },
	{ stat="Core_Shard", group=2, spellclass="Core_Shard", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Core", "Shard", "Both"}, newline=true, },
	{ stat="Key_Name", group=2, spellclass="Key_Name", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Level", "Name", "Both"}, newline=true, },
	{ stat="Display_Rated", group=2, spellclass="Display_Rated", widget={ type="CheckBox", }, tooltip=true,  default=false, labels={ "Display_Rated"}, newline=true, },
	{ stat="Display_Rating", group=2, spellclass="Display_Rating", widget={ type="CheckBox", }, tooltip=false,  default=false, labels={ "Display_Rating"}, newline=true, },
	{ stat="Rating_Only", group=2, spellclass="Rating_Only", widget={ type="CheckBox", }, tooltip=false, default=false, labels={ "Rating_Only"}, newline=true, },
	{ stat="Display_Basic", group=2, spellclass="Display_Basic", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Basic"}, newline=true, },
	{ stat="Display_Percentage", group=2, spellclass="Display_Percentage", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Percentage"}, newline=true, },
	{ stat="Hide_Reputation", group=2, spellclass="Hide_Reputation", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Hide_Reputation"}, newline=true, },
	{ stat="Display_MainHand", group=2, spellclass="Display_MainHand", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_MainHand"}, newline=true, },
	{ stat="Display_Total", group=2, spellclass="Display_Total", widget={ type="CheckBox", }, default=false, labels={ "Display_Total"}, newline=true,},
	{ stat="BNet_Realm", group=2, spellclass="BNet_Realm", widget={ type="Radio", }, tooltip=true, default=1, labels={ "BNet", "Realm", "Both"}, newline=true, },
	{ stat="Spec_Hero", group=2, spellclass="Spec_Hero", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Spec", "Hero", "Both"}, newline=true, },
	{ stat="Speed_Static", group=2, spellclass="Speed_Static", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Live", "Static", "Both"}, newline=true, },
	{ stat="Speed_Mode", group=2, spellclass="Speed_Mode", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Percent", "Yards", "Km"}, newline=true, },
	{ stat="Speed_Unit", group=2, spellclass="Speed_Unit", widget={ type="CheckBox", }, tooltip=true, default=true, labels={ "Speed_Unit"}, newline=true, },
	{ stat="Speed_Secret", group=2, spellclass="Speed_Secret", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Speed_Secret"}, newline=true, },
	{ stat="Speed_Color", group=2, spellclass="Speed_Color", widget={ type="CheckBox", }, default=true, labels={ "Speed_Color"}, newline=true, },
	--{ stat="Normal_Enchanted", group=2, spellclass="Normal_Enchanted", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Normal", "Enchanted", "Both"}, newline=true, },
	{ stat="Shadow_Ing", group=2, spellclass="Shadow_Ing", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Shadowflame", "Ingenuity", "Both"}, newline=true, },
	{ stat="Season_Exp", group=2, spellclass="Season_Exp", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Season", "Expansion", "Both"}, newline=true, },
	{ stat="Raids_Dungeons", group=2, spellclass="Raids_Dungeons", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Raids", "Dungeons", "Both"}, newline=true, },
	{ stat="Splint_Spark", group=2, spellclass="Splint_Spark", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Spark", "Splinter", "Both"}, newline=true, },
	{ stat="Display_Gold", group=2, spellclass="Display_Gold", widget={ type="CheckBox", }, tooltip=false, default=false, labels={ "Display_Gold"}, newline=true, },
	{ stat="Yards_KM", group=2, spellclass="Yards_KM", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Yards", "Kilometers", "Both"}, newline=true, },
	{ stat="NPC_Players", group=2, spellclass="NPC_Players", widget={ type="Radio", }, tooltip=true, default=1, labels={ "NPC", "Players", "Both"}, newline=true, },
	{ stat="Reset_Login", group=2, spellclass="Reset_Login", widget={ type="CheckBox", }, default=false, labels={ "Reset_Login"}, newline=true, },
	{ stat="Abbrev", group=2, spellclass="Abbrev", widget={ type="CheckBox", }, default=false, labels={ "Abbrev"}, newline=true, },
-- 	{ stat="Reset_Counter", group=2, spellclass="Reset_Counter", widget={ type="PlainButton", }, default=false, },
	{ stat="Combat_Color", group=2, spellclass="Combat_Color", widget={ type="CheckBox", }, tooltip=false, default=true, labels={ "Combat_Color"}, newline=true, },
	{ stat="Send_Chat", group=2, spellclass="Send_Chat", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Send_Chat"}, newline=true, },
	{ stat="Timer_Format", group=2, spellclass="Timer_Format", widget={ type="DropList", data="TimerFormat", width=120, }, default=1, newline=true, },
	{ stat="Editbox_MobRange", group=2, spellclass="Editbox_MobRange", default=10, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, newline=true, },
	{ stat="AutoColorOff", group=2, spellclass="AutoColorOff", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "AutoColorOff"}, newline=true, },
	{ stat="GradientText", group=2, spellclass="GradientText", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "GradientText"}, newline=true, },
	{ stat="Empty_Vintage", group=2, spellclass="Empty_Vintage", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Empty", "Vintage", "Both"}, newline=true, },
	-- decimals
	{ stat="Decimals_Default", group=2, spellclass="Decimals_Default", default=0, widget={ type="Slider", min=0, max=3, valuestep=1, width=140, } , newline=true, },
	{ stat="Decimals_One", group=2, spellclass="Decimals_One", default=1, widget={ type="Slider", min=0, max=3, valuestep=1, width=140, } , newline=true, },
	{ stat="Decimals_Two", group=2, spellclass="Decimals_Two", default=2, widget={ type="Slider", min=0, max=3, valuestep=1, width=140, } , newline=true, },
	{ stat="Display_Max", group=3, spellclass="Display_Max", widget={ type="CheckBox", }, tooltip=true, default=true, labels={ "Display_Max"}, newline=true, },
	{ stat="Display_Weekly", group=3, spellclass="Display_Weekly", widget={ type="CheckBox", }, tooltip=false, default=false, labels={ "Display_Weekly"}, newline=true, },

	-- caps
	{ stat="Cap_Percent", group=3, spellclass="Cap_Percent", default=100, tooltip=true, widget={ type="EditBox", width=81, height=24, numeric=true, format="%.2f%%", }, },
	{ stat="Cap_Rating", group=3, spellclass="Cap_Rating", default=0, tooltip=true, widget={ type="EditBox", width=71, height=24, numeric=true, format="%.2f", }, newline=true, },
	{ stat="Cap_Token", group=3, spellclass="Cap_Token", default=0, tooltip=true, widget={ type="EditBox", width=71, height=24, numeric=true, format="%.2f", }, newline=true, },

	-- Diminishing Returns
	{ stat="DR_Display", group=3, spellclass="DR_Display", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "DR_Display"}, newline=true, },
	{ stat="DR_Gradient", group=3, spellclass="DR_Gradient", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "DR_Gradient"}, newline=true, },

	--{ stat="Show_Proc", group=2, spellclass="Show_Proc", widget={ type="CheckBox", }, tooltip=true, default=true, labels={ "Show_Proc"}, },
	{ stat="Editbox_D", group=2, spellclass="Editbox_D", default=8, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, newline=true, },
	{ stat="Display_Delves", group=2, spellclass="Display_Delves", widget={ type="CheckBox", }, tooltip=false, default=false, labels={ "Display_Delves"}, },
	{ stat="Editbox_DP", group=2, spellclass="Editbox_DP", default=11, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, newline=true, },
	{ stat="Display_Tier8", group=2, spellclass="Display_Tier8", widget={ type="CheckBox", }, tooltip=false, default=false, labels={ "Display_Tier8"}, linked={ "Editbox_DP", true }, },
	{ stat="Display_All", group=2, spellclass="Display_All", widget={ type="CheckBox", }, tooltip=false, default=false, labels={ "Display_All"}, linked={ "Display_Tier8", true }, },
	{ stat="Vault_Tooltip", group=2, spellclass="Vault_Tooltip", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Vault_Tooltip"}, onclick="OnVaultTooltipToggle", newline=true, },

	-- colors
	{ stat="ColorCustom", group=4, default=false, widget={ type="CheckBox", }, linked={ "ColorName", false, "ColorClass", false, "ColorValue", false, "ColorValueEndable", false, }, onclick="InitCustomColors", newline=true },
	{ stat="ColorName", group=4, default={ r=1, g=1, b=1, }, widget={ type="ColorPicker", }, newline=true },
	{ stat="ColorClass", group=4, default=false, widget={ type="CheckBox", }, },
	{ stat="ColorValueEndable", group=4, default=false, widget={ type="CheckBox", }, linked={ "ColorValue", false, }, onclick="InitValueColor", newline=true },
	{ stat="ColorValue", group=4, default={ r=1, g=1, b=1, }, widget={ type="ColorPicker", }, },

	-- stat bars (using baremode to estrict key to specific)
	{ stat="ShowBar", group=5, spellclass="ShowBar", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "ShowBar"}, baropt=true, newline=true, },
	{ stat="StaticBar", group=5, spellclass="StaticBar", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "StaticBar"}, baropt=true, staticopt=true, newline=true, linked={ "ShowBar", true, }, },
	{ stat="BarMaxMode", group=5, spellclass="BarMaxMode", widget={ type="DropList", data="BarMaxMode", width=120, }, default=1, onchange="OnBarMaxModeChange", baropt=true, barmode="Default", newline=true, },
	{ stat="SpeedBar", group=5, spellclass="SpeedBar", widget={ type="DropList", data="SpeedBar", width=120, }, default=1, baropt=true, barmode="Speed", newline=true, },
	{ stat="BarMaxCustom", group=5, spellclass="BarMaxCustom", default=100, tooltip=true, widget={ type="EditBox", width=60, height=20, numeric=true, format="%.0f", }, baropt=true, barmode="Default,Speed", },
	{ stat="JourneyBarMode", group=5, spellclass="JourneyBarMode", widget={ type="DropList", data="JourneyBarMode", width=120, }, default=1, baropt=true, barmode="Journey", newline=true, },
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
--10.0 DF
		EVOKER = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			ManaRegen = true,
			SpellPower = true,
			Healing = true,
			Speed = true,
			Durability = true,
		},
--7.0 Legion
		DEMONHUNTER  = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Leech = true,
			Strength = true,
			AP = true,
			DMG = true,
			Armor = true,
			Dodge = true,
			Speed = true,
			Durability = true,
		},
--5.0 Panda
		MONK = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Stagger = true,
			AP = true,
			Agility = true,
			Armor = true,
			Dodge = true,
			Speed = true,
			Durability = true,
		},
--3.0 Wrath
		DEATHKNIGHT = { -- setup will check the stat. exists for game version being played
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Leech = true,
			AP = true,
			Strength = true,
			Armor = true,
			Parry = true,
			Speed = true,
			Durability = true,
		},
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