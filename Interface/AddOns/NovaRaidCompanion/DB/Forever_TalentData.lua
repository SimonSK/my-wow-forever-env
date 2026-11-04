----------------------------------
---NovaRaidCompanion Talent Data--
----------------------------------

local addonName, NRC = ...;
if (not NRC.isForever) then
	return;
end
local ipairs = ipairs;

--From Camelot/Blizzard_ClassTalentsUtil.lua
--[[local SpecializationVisuals = {
	-- Mage
	[1482] = { background = "talent-background-mage", heroContainerOffset = 0, useAtlasSize = TextureKitConstants.IgnoreAtlasSize },
	-- Druid
	[1484] = { background = "talent-background-druid", heroContainerOffset = 0, useAtlasSize = TextureKitConstants.IgnoreAtlasSize },
	-- Hunter
	[1485] = { background = "talent-background-hunter", heroContainerOffset = 0, useAtlasSize = TextureKitConstants.IgnoreAtlasSize },
	-- Paladin
	[1486] = { background = "talent-background-paladin", heroContainerOffset = 0, useAtlasSize = TextureKitConstants.IgnoreAtlasSize },
	-- Priest
	[1487] = { background = "talent-background-priest", heroContainerOffset = 0, useAtlasSize = TextureKitConstants.IgnoreAtlasSize },
	-- Rogue
	[1488] = { background = "talent-background-rogue", heroContainerOffset = 0, useAtlasSize = TextureKitConstants.IgnoreAtlasSize },
	-- Shaman
	[1489] = { background = "talent-background-shaman", heroContainerOffset = 0, useAtlasSize = TextureKitConstants.IgnoreAtlasSize },
	-- Warlock
	[1490] = { background = "talent-background-warlock", heroContainerOffset = 0, useAtlasSize = TextureKitConstants.IgnoreAtlasSize },
	-- Warrior
	[1491] = { background = "talent-background-warrior", heroContainerOffset = 0, useAtlasSize = TextureKitConstants.IgnoreAtlasSize },
};]]
	
local specData = {
	--classID.
	[1] = {
		name = "WARRIOR",
		icon = 626008,
		iconPath = "Interface\\Icons\\ClassIcon_Warrior",
		backgroundEra = "",
		backgroundForever = "talent-background-warrior",
		--Specs, id is from talent book left to right.
		[1] = {
			name = "Arms",
			icon = 132219,
			iconPath = "Interface\\Icons\\Ability_Kick",
		},
		[2] = {
			name = "Fury",
			icon = 132347,
			iconPath = "Interface\\Icons\\Ability_Warrior_InnerRage",
		},
		[3] = {
			name = "Protection",
			icon = 132341,
			iconPath = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
		},
	},
	[2] = {
		name = "PALADIN",
		icon = 626003,
		iconPath = "Interface\\Icons\\ClassIcon_Paladin",
		backgroundForever = "talent-background-paladin",
		[1] = {
			name = "Holy",
			icon = 135920,
			iconPath = "Interface\\Icons\\Spell_Holy_HolyBolt",
			--backgroundEra = "PaladinHoly",
		},
		[2] = {
			name = "Protection",
			icon = 135893,
			iconPath = "Interface\\Icons\\SPELL_HOLY_DEVOTIONAURA",
			--backgroundEra = "PaladinProtection",
		},
		[3] = {
			name = "Retribution",
			icon = 135873,
			iconPath = "Interface\\Icons\\Spell_Holy_AuraOfLight",
			--backgroundEra = "PaladinCombat",
		},
	},
	[3] = {
		name = "HUNTER",
		icon = 626000,
		iconPath = "Interface\\Icons\\ClassIcon_Hunter",
		backgroundForever = "talent-background-hunter",
		[1] = {
			name = "Beast Mastery",
			icon = 132164,
			iconPath = "Interface\\Icons\\Ability_Hunter_BeastTaming",
		},
		[2] = {
			name = "Marksmanship",
			icon = 132222,
			iconPath = "Interface\\Icons\\Ability_Marksmanship",
		},
		[3] = {
			name = "Survival",
			icon = 132215,
			iconPath = "Interface\\Icons\\Ability_Hunter_SwiftStrike",
		},
	},
	[4] = {
		name = "ROGUE",
		icon = 626005,
		iconPath = "Interface\\Icons\\ClassIcon_Rogue",
		backgroundForever = "talent-background-rogue",
		[1] = {
			name = "Assassination",
			icon = 132292,
			iconPath = "Interface\\Icons\\Ability_Rogue_Eviscerate",
		},
		[2] = {
			name = "Combat",
			icon = 132090,
			iconPath = "Interface\\Icons\\Ability_BackStab",
		},
		[3] = {
			name = "Subtlety",
			icon = 132320,
			iconPath = "Interface\\Icons\\Ability_Stealth",
		},
	},
	[5] = {
		name = "PRIEST",
		icon = 626004,
		iconPath = "Interface\\Icons\\ClassIcon_Priest",
		backgroundForever = "talent-background-priest",
		[1] = {
			name = "Discipline",
			icon = 135940,
			iconPath = "Interface\\Icons\\spell_holy_powerwordshield",
		},
		[2] = {
			name = "Holy",
			--icon = 135920, --Classic/TBC
			--iconPath = "Interface\\Icons\\Spell_Holy_HolyBolt",
			--icon = 237542, --Better holy priest icon but doesn't exist in Classic/TBC.
			--iconPath = "Interface\\Icons\\Spell_Holy_GuardianSpirit",
			--Use addon path for both, should be fine as icon is just for setextures for now.
			icon = "Interface\\AddOns\\NovaRaidCompanion\\Media\\Blizzard\\Spell_Holy_GuardianSpirit",
			iconPath = "Interface\\AddOns\\NovaRaidCompanion\\Media\\Blizzard\\Spell_Holy_GuardianSpirit",
		},
		[3] = {
			name = "Shadow",
			icon = 136207,
			iconPath = "Interface\\Icons\\Spell_Shadow_ShadowWordPain",
		},
	},
	[7] = {
		name = "SHAMAN",
		icon = 626006,
		iconPath = "Interface\\Icons\\ClassIcon_Shaman",
		backgroundForever = "talent-background-shaman",
		[1] = {
			name = "Elemental",
			icon = 136048,
			iconPath = "Interface\\Icons\\Spell_Nature_Lightning",
		},
		[2] = {
			name = "Enhancement",
			icon = 136051,
			iconPath = "Interface\\Icons\\Spell_Nature_LightningShield",
		},
		[3] = {
			name = "Restoration",
			icon = 136052,
			iconPath = "Interface\\Icons\\Spell_Nature_MagicImmunity",
		},
	},
	[8] = {
		name = "MAGE",
		icon = 626001,
		iconPath = "Interface\\Icons\\ClassIcon_Mage",
		backgroundForever = "talent-background-mage",
		[1] = {
			name = "Arcane",
			icon = 135932,
			iconPath = "Interface\\Icons\\Spell_Holy_MagicalSentry",
		},
		[2] = {
			name = "Fire",
			icon = 135810,
			iconPath = "Interface\\Icons\\Spell_Fire_FireBolt02",
		},
		[3] = {
			name = "Frost",
			icon = 135846,
			iconPath = "Interface\\Icons\\Spell_Frost_FrostBolt02",
		},
	},
	[9] = {
		name = "WARLOCK",
		icon = 626007,
		iconPath = "Interface\\Icons\\ClassIcon_Warlock",
		backgroundForever = "talent-background-warlock",
		--Specs, id is from talent book left to right.
		[1] = {
			name = "Affliction",
			icon = 136145,
			iconPath = "Interface\\Icons\\Spell_Shadow_DeathCoil",
		},
		[2] = {
			name = "Demonology",
			icon = 136172,
			iconPath = "Interface\\Icons\\Spell_Shadow_Metamorphosis",
		},
		[3] = {
			name = "Destruction",
			icon = 136186,
			iconPath = "Interface\\Icons\\Spell_Shadow_RainOfFire",
		},
	},
	[11] = {
		name = "DRUID",
		icon = 625999,
		iconPath = "Interface\\Icons\\ClassIcon_Druid",
		backgroundForever = "talent-background-druid",
		[1] = {
			name = "Balance",
			icon = 136096,
			iconPath = "Interface\\Icons\\Spell_Nature_StarFall",
		},
		[2] = {
			name = "Feral",
			icon = 132276,
			iconPath = "Interface\\Icons\\Ability_Racial_BearForm",
		},
		--[3] = {
		--	name = "Guardian",
		--	icon = 132276,
			--iconPath = "Interface\\Icons\\Ability_Racial_BearForm",
		--},
		[3] = { --Needs changing to 4 once druids gain 4th spec.
			name = "Restoration",
			icon = 136041,
			iconPath = "Interface\\Icons\\SPELL_NATURE_HEALINGTOUCH",
		},
	},
};

function NRC.getSpecData(classID, specID)
	if (specData[classID] and specData[classID][specID]) then
		local name = specData[classID][specID].name;
		local icon = specData[classID][specID].icon;
		local iconPath = specData[classID][specID].iconPath;
		local backgroundEra = specData[classID][specID].backgroundEra;
		local backgroundForever = specData[classID].backgroundForever;
		return name, icon, iconPath, backgroundEra, backgroundForever;
	end
end

--Pasted directly from my importer so it looks messy.
--This is just a backup for when the API fails as it does on occasion.
local talents = {
["warrior"] = {
{
["numtalents"] = 17,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105958,
["name"] = "Improved Heroic Strike",
["column"] = 1,
["icon"] = 132282,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105957,
["name"] = "Deflection",
["column"] = 2,
["icon"] = 132269,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105956,
["name"] = "Improved Rend",
["column"] = 3,
["icon"] = 132155,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105955,
["name"] = "Improved Charge",
["column"] = 1,
["icon"] = 132337,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105954,
["name"] = "Improved Tactical Mastery",
["column"] = 2,
["icon"] = 136031,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105952,
["name"] = "Improved Overpower",
["column"] = 4,
["icon"] = 135275,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105951,
["name"] = "Anger Management",
["column"] = 2,
["icon"] = 135881,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105950,
["name"] = "Deep Wounds",
["column"] = 3,
["icon"] = 132090,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105949,
["name"] = "Spearing Strike",
["column"] = 1,
["icon"] = 135124,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105948,
["name"] = "Two-Handed Weapon Specialization",
["column"] = 2,
["icon"] = 132400,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105947,
["name"] = "Impale",
["column"] = 3,
["icon"] = 132312,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 110524,
["name"] = "Bloodthrill",
["column"] = 1,
["icon"] = 135271,
["row"] = 5,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105945,
["name"] = "Sweeping Strikes",
["column"] = 2,
["icon"] = 132306,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105944,
["name"] = "Weaponmaster",
["column"] = 3,
["icon"] = 1085608,
["row"] = 5,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 110858,
["name"] = "Improved Slam",
["column"] = 1,
["icon"] = 132340,
["row"] = 6,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105942,
["name"] = "Improved Hamstring",
["column"] = 3,
["icon"] = 132316,
["row"] = 6,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105941,
["name"] = "Mortal Strike",
["column"] = 2,
["icon"] = 132355,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Arms",
["icon"] = 132292,
},
},
{
["numtalents"] = 17,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105938,
["name"] = "Booming Voice",
["column"] = 2,
["icon"] = 136075,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105939,
["name"] = "Cruelty",
["column"] = 3,
["icon"] = 132292,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 110857,
["name"] = "Lingering Rage",
["column"] = 2,
["icon"] = 132356,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105937,
["name"] = "Unbridled Wrath",
["column"] = 3,
["icon"] = 136097,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105953,
["name"] = "Furious Precision",
["column"] = 1,
["icon"] = 236309,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105935,
["name"] = "Piercing Howl",
["column"] = 2,
["icon"] = 136147,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105934,
["name"] = "Blood Craze",
["column"] = 3,
["icon"] = 136218,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105933,
["name"] = "Dual Wield Specialization",
["column"] = 1,
["icon"] = 132147,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105977,
["name"] = "Raging Blows",
["column"] = 2,
["icon"] = 132369,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105931,
["name"] = "Enrage",
["column"] = 3,
["icon"] = 136224,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105932,
["name"] = "Improved Execute",
["column"] = 4,
["icon"] = 135358,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105978,
["name"] = "Improved Berserker Rage",
["column"] = 1,
["icon"] = 136009,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105927,
["name"] = "Death Wish",
["column"] = 2,
["icon"] = 136146,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105926,
["name"] = "Improved Intercept",
["column"] = 4,
["icon"] = 132307,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105928,
["name"] = "Flurry",
["column"] = 2,
["icon"] = 132152,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 113569,
["name"] = "Gore Drinker",
["column"] = 3,
["icon"] = 135727,
["row"] = 6,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105930,
["name"] = "Bloodthirst",
["column"] = 2,
["icon"] = 136012,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Fury",
["icon"] = 132347,
},
},
{
["numtalents"] = 18,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105974,
["name"] = "Improved Bloodrage",
["column"] = 1,
["icon"] = 132277,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105976,
["name"] = "Shield Specialization",
["column"] = 2,
["icon"] = 134952,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 113570,
["name"] = "Iron Will",
["column"] = 3,
["icon"] = 135995,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105975,
["name"] = "Anticipation",
["column"] = 1,
["icon"] = 136056,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105969,
["name"] = "Improved Revenge",
["column"] = 3,
["icon"] = 132353,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105972,
["name"] = "Improved Thunder Clap",
["column"] = 4,
["icon"] = 132326,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105970,
["name"] = "Last Stand",
["column"] = 1,
["icon"] = 135871,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105971,
["name"] = "Master of Defense",
["column"] = 2,
["icon"] = 132359,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105967,
["name"] = "Improved Disarm",
["column"] = 3,
["icon"] = 132343,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 110856,
["name"] = "Defiance",
["column"] = 4,
["icon"] = 132347,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105968,
["name"] = "Improved Sunder Armor",
["column"] = 1,
["icon"] = 132363,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105966,
["name"] = "Vanguard",
["column"] = 2,
["icon"] = 4667427,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105963,
["name"] = "Improved Shield Bash",
["column"] = 3,
["icon"] = 132357,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105964,
["name"] = "Improved Shield Wall",
["column"] = 1,
["icon"] = 132362,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105965,
["name"] = "Concussion Blow",
["column"] = 2,
["icon"] = 132325,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105961,
["name"] = "Focused Rage",
["column"] = 3,
["icon"] = 132345,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105962,
["name"] = "Bastion",
["column"] = 3,
["icon"] = 134950,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 18,
["nodeID"] = 105959,
["name"] = "Shield Slam",
["column"] = 2,
["icon"] = 134951,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Protection",
["icon"] = 132341,
},
},
},
["paladin"] = {
{
["numtalents"] = 17,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105639,
["name"] = "Divine Strength",
["column"] = 2,
["icon"] = 132154,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105332,
["name"] = "Divine Intellect",
["column"] = 3,
["icon"] = 136090,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105333,
["name"] = "Healing Light",
["column"] = 1,
["icon"] = 135920,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105335,
["name"] = "Spiritual Focus",
["column"] = 2,
["icon"] = 135736,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105334,
["name"] = "Improved Seals",
["column"] = 3,
["icon"] = 132325,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105331,
["name"] = "Unyielding Faith",
["column"] = 4,
["icon"] = 135984,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105330,
["name"] = "Voice of Truth",
["column"] = 1,
["icon"] = 134229,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 110871,
["name"] = "Reverence",
["column"] = 2,
["icon"] = 135895,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105327,
["name"] = "Purifying Power",
["column"] = 3,
["icon"] = 135950,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 110873,
["name"] = "Infusion of Light",
["column"] = 1,
["icon"] = 236254,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105329,
["name"] = "Illumination",
["column"] = 2,
["icon"] = 135913,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105325,
["name"] = "Divine Favor",
["column"] = 3,
["icon"] = 135915,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105324,
["name"] = "Divine Precision",
["column"] = 1,
["icon"] = 135918,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105323,
["name"] = "Holy Shock",
["column"] = 2,
["icon"] = 135972,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 110872,
["name"] = "Consecrated Ground",
["column"] = 3,
["icon"] = 135926,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105321,
["name"] = "Holy Power",
["column"] = 3,
["icon"] = 135938,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105320,
["name"] = "Light's Vigil",
["column"] = 2,
["icon"] = 236256,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Holy",
["icon"] = 135920,
},
},
{
["numtalents"] = 16,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105630,
["name"] = "Toughness",
["column"] = 2,
["icon"] = 135892,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105626,
["name"] = "Redoubt",
["column"] = 3,
["icon"] = 132110,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105638,
["name"] = "Precision",
["column"] = 1,
["icon"] = 132282,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105637,
["name"] = "Guardian's Favor",
["column"] = 2,
["icon"] = 135964,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105636,
["name"] = "Anticipation",
["column"] = 4,
["icon"] = 135994,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 110875,
["name"] = "Improved Seal of Fury",
["column"] = 1,
["icon"] = 135960,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105634,
["name"] = "Improved Righteous Fury",
["column"] = 2,
["icon"] = 135962,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 110874,
["name"] = "Shield Specialization",
["column"] = 3,
["icon"] = 134952,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105632,
["name"] = "Sacred Duty",
["column"] = 4,
["icon"] = 135896,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 110878,
["name"] = "Swift Judgement",
["column"] = 1,
["icon"] = 236258,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105629,
["name"] = "One-Handed Weapon Specialization",
["column"] = 2,
["icon"] = 135321,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105633,
["name"] = "Improved Hammer of Justice",
["column"] = 3,
["icon"] = 135963,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105625,
["name"] = "Templar's Bulwark",
["column"] = 2,
["icon"] = 236264,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105627,
["name"] = "Reckoning",
["column"] = 3,
["icon"] = 135882,
["row"] = 5,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 110879,
["name"] = "Iron Creed",
["column"] = 3,
["icon"] = 135925,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105628,
["name"] = "Holy Shield",
["column"] = 2,
["icon"] = 135880,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Protection",
["icon"] = 135893,
},
},
{
["numtalents"] = 17,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105707,
["name"] = "Deflection",
["column"] = 2,
["icon"] = 132269,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105706,
["name"] = "Benediction",
["column"] = 3,
["icon"] = 135863,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105705,
["name"] = "Improved Judgement",
["column"] = 1,
["icon"] = 135959,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105704,
["name"] = "Holy Conduit",
["column"] = 2,
["icon"] = 237539,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105703,
["name"] = "Conviction",
["column"] = 3,
["icon"] = 135957,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105702,
["name"] = "Vindication",
["column"] = 1,
["icon"] = 135985,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105701,
["name"] = "Sanctified Judgement",
["column"] = 2,
["icon"] = 236255,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105696,
["name"] = "Seal of Command",
["column"] = 3,
["icon"] = 132347,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105699,
["name"] = "Pursuit of Justice",
["column"] = 4,
["icon"] = 135937,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105698,
["name"] = "Eye for an Eye",
["column"] = 1,
["icon"] = 135904,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105700,
["name"] = "Sacred Arbiter",
["column"] = 3,
["icon"] = 135278,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105697,
["name"] = "Two-Handed Weapon Specialization",
["column"] = 1,
["icon"] = 133041,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105693,
["name"] = "Vengeance",
["column"] = 2,
["icon"] = 132275,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105694,
["name"] = "Repentance",
["column"] = 3,
["icon"] = 135942,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 110882,
["name"] = "Champion of the Light",
["column"] = 2,
["icon"] = 236251,
["row"] = 6,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 110880,
["name"] = "Instrument of Law",
["column"] = 3,
["icon"] = 135897,
["row"] = 6,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105692,
["name"] = "Twist of Light",
["column"] = 2,
["icon"] = 135878,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Retribution",
["icon"] = 135873,
},
},
},
["shaman"] = {
{
["numtalents"] = 16,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 104773,
["name"] = "Convection",
["column"] = 2,
["icon"] = 136116,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 104772,
["name"] = "Concussion",
["column"] = 3,
["icon"] = 136026,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 104769,
["name"] = "Elemental Devastation",
["column"] = 1,
["icon"] = 135791,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 104767,
["name"] = "Reverberation",
["column"] = 2,
["icon"] = 135850,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 104771,
["name"] = "Elemental Alacrity",
["column"] = 3,
["icon"] = 135990,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 104770,
["name"] = "Call of Flame",
["column"] = 4,
["icon"] = 135817,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 104768,
["name"] = "Elemental Focus",
["column"] = 1,
["icon"] = 136170,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 104765,
["name"] = "Elemental Warding",
["column"] = 2,
["icon"] = 136094,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 104764,
["name"] = "Trial by Fire",
["column"] = 1,
["icon"] = 135824,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 104763,
["name"] = "Eye of the Storm",
["column"] = 2,
["icon"] = 136032,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 104762,
["name"] = "Earthbound",
["column"] = 4,
["icon"] = 136100,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 104761,
["name"] = "Elemental Reach",
["column"] = 1,
["icon"] = 136099,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 104760,
["name"] = "Lava Burst",
["column"] = 2,
["icon"] = 237582,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 104759,
["name"] = "Lightning Overload",
["column"] = 3,
["icon"] = 136050,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 104766,
["name"] = "Elemental Fury",
["column"] = 3,
["icon"] = 135830,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 104758,
["name"] = "Elemental Mastery",
["column"] = 2,
["icon"] = 136115,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Elemental Combat",
["icon"] = 136048,
},
},
{
["numtalents"] = 18,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 104757,
["name"] = "Earth's Grasp",
["column"] = 1,
["icon"] = 136097,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 104753,
["name"] = "Thundering Strikes",
["column"] = 2,
["icon"] = 132325,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 104756,
["name"] = "Ancestral Knowledge",
["column"] = 3,
["icon"] = 136162,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 104754,
["name"] = "Guardian Totems",
["column"] = 1,
["icon"] = 136098,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 104755,
["name"] = "Mental Dexterity",
["column"] = 2,
["icon"] = 136055,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 104752,
["name"] = "Improved Ghost Wolf",
["column"] = 3,
["icon"] = 136095,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 104751,
["name"] = "Improved Lightning Shield",
["column"] = 4,
["icon"] = 136051,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 104750,
["name"] = "Elemental Weapons",
["column"] = 1,
["icon"] = 135814,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 104749,
["name"] = "Shamanistic Focus",
["column"] = 3,
["icon"] = 136027,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 104748,
["name"] = "Anticipation",
["column"] = 4,
["icon"] = 136056,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 104746,
["name"] = "Toughness",
["column"] = 1,
["icon"] = 135892,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 104747,
["name"] = "Flurry",
["column"] = 2,
["icon"] = 132152,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 104743,
["name"] = "Stormstrike",
["column"] = 3,
["icon"] = 132314,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 104745,
["name"] = "Spirit Weapons",
["column"] = 1,
["icon"] = 132269,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 104744,
["name"] = "Mental Quickness",
["column"] = 2,
["icon"] = 136090,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 104742,
["name"] = "Improved Stormstrike",
["column"] = 3,
["icon"] = 237581,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 104741,
["name"] = "Maelstrom Weapon",
["column"] = 3,
["icon"] = 237584,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 18,
["nodeID"] = 104740,
["name"] = "Rage of the Farseer",
["column"] = 2,
["icon"] = 136012,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Enhancement",
["icon"] = 136051,
},
},
{
["numtalents"] = 16,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 104739,
["name"] = "Improved Healing Wave",
["column"] = 2,
["icon"] = 136052,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 104729,
["name"] = "Tidal Focus",
["column"] = 3,
["icon"] = 135859,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 104734,
["name"] = "Mindfulness",
["column"] = 1,
["icon"] = 136090,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 104736,
["name"] = "Natural Grace",
["column"] = 2,
["icon"] = 136041,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 104735,
["name"] = "Totemic Focus",
["column"] = 3,
["icon"] = 136057,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 104737,
["name"] = "Improved Reincarnation",
["column"] = 4,
["icon"] = 136080,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 104731,
["name"] = "Ancestral Healing",
["column"] = 1,
["icon"] = 136109,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 104733,
["name"] = "Healing Focus",
["column"] = 2,
["icon"] = 136043,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 104732,
["name"] = "Water Shield",
["column"] = 3,
["icon"] = 132315,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 104738,
["name"] = "Tidal Mastery",
["column"] = 1,
["icon"] = 136107,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 104730,
["name"] = "Restorative Totems",
["column"] = 2,
["icon"] = 136053,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 104728,
["name"] = "Mana Tide Totem",
["column"] = 3,
["icon"] = 135861,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 104727,
["name"] = "Healing Way",
["column"] = 2,
["icon"] = 136044,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 104726,
["name"] = "Nature's Swiftness",
["column"] = 3,
["icon"] = 136076,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 104725,
["name"] = "Purification",
["column"] = 3,
["icon"] = 135865,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 104724,
["name"] = "Riptide",
["column"] = 2,
["icon"] = 252995,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Restoration",
["icon"] = 136052,
},
},
},
["rogue"] = {
{
["numtalents"] = 17,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105742,
["name"] = "Improved Gouge",
["column"] = 1,
["icon"] = 132155,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105723,
["name"] = "Remorseless Attacks",
["column"] = 2,
["icon"] = 132151,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105722,
["name"] = "Malice",
["column"] = 3,
["icon"] = 132277,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105721,
["name"] = "Ruthlessness",
["column"] = 1,
["icon"] = 132122,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105720,
["name"] = "Murder",
["column"] = 2,
["icon"] = 136147,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105739,
["name"] = "Improved Slice and Dice",
["column"] = 4,
["icon"] = 132306,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105759,
["name"] = "Relentless Strikes",
["column"] = 1,
["icon"] = 132340,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105717,
["name"] = "Improved Expose Armor",
["column"] = 2,
["icon"] = 132354,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105716,
["name"] = "Lethality",
["column"] = 3,
["icon"] = 132109,
["row"] = 3,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105714,
["name"] = "Vile Poisons",
["column"] = 1,
["icon"] = 132293,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105715,
["name"] = "Cold Blood",
["column"] = 2,
["icon"] = 135988,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105713,
["name"] = "Improved Poisons",
["column"] = 3,
["icon"] = 132273,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105718,
["name"] = "Vigor",
["column"] = 1,
["icon"] = 136023,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105709,
["name"] = "Mutilate",
["column"] = 2,
["icon"] = 236270,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105711,
["name"] = "Improved Kidney Shot",
["column"] = 3,
["icon"] = 132298,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105710,
["name"] = "Seal Fate",
["column"] = 3,
["icon"] = 136130,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105712,
["name"] = "Venom",
["column"] = 2,
["icon"] = 135341,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Assassination",
["icon"] = 132292,
},
},
{
["numtalents"] = 17,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105708,
["name"] = "Improved Eviscerate",
["column"] = 1,
["icon"] = 132292,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105741,
["name"] = "Improved Sinister Strike",
["column"] = 2,
["icon"] = 136189,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 113398,
["name"] = "Lightning Reflexes",
["column"] = 3,
["icon"] = 136047,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105719,
["name"] = "Puncturing Wounds",
["column"] = 1,
["icon"] = 132090,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105738,
["name"] = "Deflection",
["column"] = 2,
["icon"] = 132269,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105737,
["name"] = "Precision",
["column"] = 3,
["icon"] = 132222,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105736,
["name"] = "Endurance",
["column"] = 1,
["icon"] = 136205,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105735,
["name"] = "Riposte",
["column"] = 2,
["icon"] = 132336,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105732,
["name"] = "Improved Sprint",
["column"] = 4,
["icon"] = 132307,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105733,
["name"] = "Improved Kick",
["column"] = 1,
["icon"] = 132219,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 108100,
["name"] = "Flawless Execution",
["column"] = 2,
["icon"] = 135345,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105740,
["name"] = "Dual Wield Specialization",
["column"] = 3,
["icon"] = 132147,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105728,
["name"] = "Blade Flurry",
["column"] = 2,
["icon"] = 132350,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105727,
["name"] = "Hack and Slash",
["column"] = 3,
["icon"] = 135328,
["row"] = 5,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105726,
["name"] = "Weapon Expertise",
["column"] = 2,
["icon"] = 135882,
["row"] = 6,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105730,
["name"] = "Aggression",
["column"] = 3,
["icon"] = 132275,
["row"] = 6,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105724,
["name"] = "Adrenaline Rush",
["column"] = 2,
["icon"] = 136206,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Combat",
["icon"] = 132090,
},
},
{
["numtalents"] = 19,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105756,
["name"] = "Camouflage",
["column"] = 1,
["icon"] = 132320,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105761,
["name"] = "Master of Deception",
["column"] = 2,
["icon"] = 136129,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105760,
["name"] = "Opportunity",
["column"] = 3,
["icon"] = 132366,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105751,
["name"] = "Setup",
["column"] = 1,
["icon"] = 136056,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105753,
["name"] = "Elusiveness",
["column"] = 2,
["icon"] = 135994,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105757,
["name"] = "Dirty Tricks",
["column"] = 3,
["icon"] = 132310,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105749,
["name"] = "Improved Ambush",
["column"] = 4,
["icon"] = 132282,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105755,
["name"] = "Initiative",
["column"] = 1,
["icon"] = 136159,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105754,
["name"] = "Ghostly Strike",
["column"] = 2,
["icon"] = 136136,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 110868,
["name"] = "Improved Distract",
["column"] = 3,
["icon"] = 132289,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105747,
["name"] = "Heightened Senses",
["column"] = 1,
["icon"] = 132089,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105743,
["name"] = "Premeditation",
["column"] = 2,
["icon"] = 136183,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105752,
["name"] = "Serrated Blades",
["column"] = 3,
["icon"] = 135315,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105745,
["name"] = "Dirty Deeds",
["column"] = 1,
["icon"] = 136220,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105746,
["name"] = "Preparation",
["column"] = 2,
["icon"] = 136121,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105748,
["name"] = "Hemorrhage",
["column"] = 3,
["icon"] = 136168,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 110867,
["name"] = "Quietus",
["column"] = 1,
["icon"] = 132297,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 18,
["nodeID"] = 105750,
["name"] = "Cutthroat",
["column"] = 3,
["icon"] = 626005,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 19,
["nodeID"] = 110866,
["name"] = "Thousand Cuts",
["column"] = 2,
["icon"] = 132302,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Subtlety",
["icon"] = 132320,
},
},
},
["mage"] = {
{
["numtalents"] = 19,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105815,
["name"] = "Wand Specialization",
["column"] = 1,
["icon"] = 135463,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105814,
["name"] = "Arcane Focus",
["column"] = 2,
["icon"] = 135892,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105813,
["name"] = "Improved Channeling",
["column"] = 3,
["icon"] = 136096,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105802,
["name"] = "Missile Barrage",
["column"] = 4,
["icon"] = 236221,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105812,
["name"] = "Arcane Subtlety",
["column"] = 1,
["icon"] = 135894,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105811,
["name"] = "Magic Absorption",
["column"] = 2,
["icon"] = 136011,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105810,
["name"] = "Arcane Concentration",
["column"] = 3,
["icon"] = 136170,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105809,
["name"] = "Arcane Resilience",
["column"] = 4,
["icon"] = 135733,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105808,
["name"] = "Arcane Geometry",
["column"] = 1,
["icon"] = 6035311,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105807,
["name"] = "Arcane Impact",
["column"] = 2,
["icon"] = 136116,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105806,
["name"] = "Arcane Blast",
["column"] = 4,
["icon"] = 135735,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105805,
["name"] = "Arcane Shielding",
["column"] = 1,
["icon"] = 136153,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105804,
["name"] = "Improved Counterspell",
["column"] = 2,
["icon"] = 135856,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105803,
["name"] = "Arcane Meditation",
["column"] = 3,
["icon"] = 136208,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 113627,
["name"] = "Arcane Wrath",
["column"] = 4,
["icon"] = 236222,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105801,
["name"] = "Presence of Mind",
["column"] = 2,
["icon"] = 136031,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105800,
["name"] = "Arcane Mind",
["column"] = 3,
["icon"] = 136129,
["row"] = 5,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 18,
["nodeID"] = 105799,
["name"] = "Arcane Instability",
["column"] = 3,
["icon"] = 136222,
["row"] = 6,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 19,
["nodeID"] = 105798,
["name"] = "Arcane Power",
["column"] = 2,
["icon"] = 136048,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Arcane",
["icon"] = 135932,
},
},
{
["numtalents"] = 17,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105797,
["name"] = "Improved Fire Blast",
["column"] = 1,
["icon"] = 135819,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105796,
["name"] = "Incineration",
["column"] = 2,
["icon"] = 135813,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105795,
["name"] = "Improved Fireball",
["column"] = 3,
["icon"] = 135812,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105794,
["name"] = "Ignite",
["column"] = 1,
["icon"] = 135818,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105793,
["name"] = "Flame Throwing",
["column"] = 2,
["icon"] = 135815,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105792,
["name"] = "Impact",
["column"] = 3,
["icon"] = 135821,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105789,
["name"] = "Burning Soul",
["column"] = 1,
["icon"] = 135805,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105791,
["name"] = "Improved Flamestrike",
["column"] = 2,
["icon"] = 135826,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105790,
["name"] = "Pyroblast",
["column"] = 3,
["icon"] = 135808,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105788,
["name"] = "Improved Scorch",
["column"] = 1,
["icon"] = 135827,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105787,
["name"] = "Improved Fire Ward",
["column"] = 2,
["icon"] = 135806,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105786,
["name"] = "Heating Up",
["column"] = 3,
["icon"] = 135809,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105785,
["name"] = "Master of Elements",
["column"] = 4,
["icon"] = 135820,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105784,
["name"] = "Critical Mass",
["column"] = 2,
["icon"] = 136115,
["row"] = 5,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105783,
["name"] = "Blast Wave",
["column"] = 3,
["icon"] = 135903,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105782,
["name"] = "Fire Power",
["column"] = 3,
["icon"] = 135817,
["row"] = 6,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105781,
["name"] = "Combustion",
["column"] = 2,
["icon"] = 135824,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Fire",
["icon"] = 135810,
},
},
{
["numtalents"] = 18,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105780,
["name"] = "Frost Warding",
["column"] = 1,
["icon"] = 135850,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105779,
["name"] = "Improved Frostbolt",
["column"] = 2,
["icon"] = 135846,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105778,
["name"] = "Elemental Precision",
["column"] = 3,
["icon"] = 135989,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105777,
["name"] = "Ice Shards",
["column"] = 1,
["icon"] = 135855,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105774,
["name"] = "Frostbite",
["column"] = 2,
["icon"] = 135842,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105775,
["name"] = "Improved Frost Nova",
["column"] = 3,
["icon"] = 135840,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105776,
["name"] = "Permafrost",
["column"] = 4,
["icon"] = 135864,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105772,
["name"] = "Frost Channeling",
["column"] = 1,
["icon"] = 135860,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105771,
["name"] = "Improved Blizzard",
["column"] = 2,
["icon"] = 135857,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105767,
["name"] = "Ice Lance",
["column"] = 3,
["icon"] = 135844,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105770,
["name"] = "Arctic Reach",
["column"] = 1,
["icon"] = 136141,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105769,
["name"] = "Ice Block",
["column"] = 2,
["icon"] = 135841,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105768,
["name"] = "Shatter",
["column"] = 4,
["icon"] = 135849,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105765,
["name"] = "Improved Cone of Cold",
["column"] = 1,
["icon"] = 135852,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105766,
["name"] = "Cold Snap",
["column"] = 2,
["icon"] = 135865,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105764,
["name"] = "Fingers of Frost",
["column"] = 3,
["icon"] = 236227,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105763,
["name"] = "Winter's Chill",
["column"] = 3,
["icon"] = 135836,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 18,
["nodeID"] = 105762,
["name"] = "Ice Barrier",
["column"] = 2,
["icon"] = 135988,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Frost",
["icon"] = 135846,
},
},
},
["druid"] = {
{
["numtalents"] = 16,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 104923,
["name"] = "Improved Wrath",
["column"] = 2,
["icon"] = 136006,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 104924,
["name"] = "Genesis",
["column"] = 3,
["icon"] = 135730,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 104925,
["name"] = "Moonglow",
["column"] = 1,
["icon"] = 136087,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 104931,
["name"] = "Improved Moonfire",
["column"] = 2,
["icon"] = 136096,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 104927,
["name"] = "Nature's Majesty",
["column"] = 3,
["icon"] = 135138,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 104929,
["name"] = "Nature's Reach",
["column"] = 4,
["icon"] = 136065,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 104926,
["name"] = "Improved Entangling Roots",
["column"] = 1,
["icon"] = 136100,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 104928,
["name"] = "Nature's Splendor",
["column"] = 3,
["icon"] = 136061,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 104930,
["name"] = "Insect Swarm",
["column"] = 1,
["icon"] = 136045,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 104932,
["name"] = "Vengeance",
["column"] = 2,
["icon"] = 136075,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 104933,
["name"] = "Improved Starfire",
["column"] = 3,
["icon"] = 135753,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 110844,
["name"] = "Overgrowth",
["column"] = 1,
["icon"] = 134196,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 104934,
["name"] = "Nature's Grace",
["column"] = 2,
["icon"] = 136062,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 104935,
["name"] = "Eclipse",
["column"] = 3,
["icon"] = 236151,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 104936,
["name"] = "Moonfury",
["column"] = 2,
["icon"] = 136057,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 104937,
["name"] = "Moonkin Form",
["column"] = 2,
["icon"] = 136036,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Balance",
["icon"] = 136096,
},
},
{
["numtalents"] = 20,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 104938,
["name"] = "Ferocity",
["column"] = 2,
["icon"] = 132190,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 104939,
["name"] = "Heart of the Wild",
["column"] = 3,
["icon"] = 135879,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 104943,
["name"] = "Feral Swiftness",
["column"] = 1,
["icon"] = 136095,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 104940,
["name"] = "Feral Instinct",
["column"] = 2,
["icon"] = 132089,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 104941,
["name"] = "Brutal Impact",
["column"] = 3,
["icon"] = 132114,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 104942,
["name"] = "Thick Hide",
["column"] = 4,
["icon"] = 134355,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 104945,
["name"] = "Shredding Attacks",
["column"] = 1,
["icon"] = 136231,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 104948,
["name"] = "Savage Fury",
["column"] = 2,
["icon"] = 132141,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 104944,
["name"] = "Feral Charge",
["column"] = 3,
["icon"] = 132183,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 104946,
["name"] = "Sharpened Claws",
["column"] = 4,
["icon"] = 134297,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 104951,
["name"] = "Shifting Power",
["column"] = 1,
["icon"] = 538514,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 104949,
["name"] = "Primal Bite",
["column"] = 2,
["icon"] = 132278,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 104952,
["name"] = "Predatory Strikes",
["column"] = 3,
["icon"] = 132185,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 104947,
["name"] = "Blood Frenzy",
["column"] = 4,
["icon"] = 132152,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 113563,
["name"] = "Improved Shifting Power",
["column"] = 1,
["icon"] = 236172,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 104955,
["name"] = "Leader of the Pack",
["column"] = 2,
["icon"] = 136112,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 104950,
["name"] = "Natural Instinct",
["column"] = 4,
["icon"] = 132138,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 18,
["nodeID"] = 104954,
["name"] = "Natural Reaction",
["column"] = 1,
["icon"] = 132091,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 19,
["nodeID"] = 104953,
["name"] = "Rend and Tear",
["column"] = 3,
["icon"] = 236164,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 20,
["nodeID"] = 104956,
["name"] = "Berserk",
["column"] = 2,
["icon"] = 236149,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Feral Combat",
["icon"] = 132276,
},
},
{
["numtalents"] = 16,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 104957,
["name"] = "Nature's Focus",
["column"] = 2,
["icon"] = 136042,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 104958,
["name"] = "Furor",
["column"] = 3,
["icon"] = 135881,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 104922,
["name"] = "Naturalist",
["column"] = 1,
["icon"] = 136041,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 104920,
["name"] = "Subtlety",
["column"] = 2,
["icon"] = 132150,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 104919,
["name"] = "Natural Shapeshifter",
["column"] = 3,
["icon"] = 136116,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 104917,
["name"] = "Reflection",
["column"] = 2,
["icon"] = 135863,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 104916,
["name"] = "Gift of Nature",
["column"] = 3,
["icon"] = 136074,
["row"] = 3,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 104918,
["name"] = "Gift of the Earthmother",
["column"] = 4,
["icon"] = 136094,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 104915,
["name"] = "Tranquil Spirit",
["column"] = 2,
["icon"] = 135900,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 104914,
["name"] = "Improved Rejuvenation",
["column"] = 3,
["icon"] = 136081,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 104912,
["name"] = "Swiftmend",
["column"] = 4,
["icon"] = 134914,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 104921,
["name"] = "Nature's Swiftness",
["column"] = 1,
["icon"] = 136076,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 104911,
["name"] = "Living Spirit",
["column"] = 2,
["icon"] = 136037,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 104909,
["name"] = "Improved Tranquility",
["column"] = 4,
["icon"] = 136107,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 104913,
["name"] = "Improved Regrowth",
["column"] = 3,
["icon"] = 136085,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 104910,
["name"] = "Wild Growth",
["column"] = 2,
["icon"] = 236153,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Restoration",
["icon"] = 136041,
},
},
},
["priest"] = {
{
["numtalents"] = 18,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 110853,
["name"] = "Power in Light",
["column"] = 1,
["icon"] = 135972,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105850,
["name"] = "Wand Specialization",
["column"] = 2,
["icon"] = 135463,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105849,
["name"] = "Twin Disciplines",
["column"] = 3,
["icon"] = 135969,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105848,
["name"] = "Silent Resolve",
["column"] = 1,
["icon"] = 136053,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 110852,
["name"] = "Holy Precision",
["column"] = 2,
["icon"] = 135895,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105837,
["name"] = "Mental Strength",
["column"] = 3,
["icon"] = 136031,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105845,
["name"] = "Martyrdom",
["column"] = 4,
["icon"] = 136107,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105842,
["name"] = "Mental Agility",
["column"] = 1,
["icon"] = 132156,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105844,
["name"] = "Inner Focus",
["column"] = 2,
["icon"] = 135863,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105846,
["name"] = "Improved Power Word: Shield",
["column"] = 3,
["icon"] = 135940,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105843,
["name"] = "Meditation",
["column"] = 4,
["icon"] = 136090,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105841,
["name"] = "Improved Inner Fire",
["column"] = 1,
["icon"] = 135926,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105838,
["name"] = "Improved Mana Burn",
["column"] = 2,
["icon"] = 136170,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105839,
["name"] = "Soul Warding",
["column"] = 3,
["icon"] = 135948,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105834,
["name"] = "Penance",
["column"] = 2,
["icon"] = 237545,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105835,
["name"] = "Renewed Hope",
["column"] = 3,
["icon"] = 135923,
["row"] = 5,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105840,
["name"] = "Divine Aegis",
["column"] = 3,
["icon"] = 237539,
["row"] = 6,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 18,
["nodeID"] = 105836,
["name"] = "Power Infusion",
["column"] = 2,
["icon"] = 135939,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Discipline",
["icon"] = 135987,
},
},
{
["numtalents"] = 17,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105867,
["name"] = "Twilight Focus",
["column"] = 1,
["icon"] = 135918,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105866,
["name"] = "Improved Renew",
["column"] = 2,
["icon"] = 135953,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 110855,
["name"] = "Holy Specialization",
["column"] = 3,
["icon"] = 135967,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105864,
["name"] = "Spell Warding",
["column"] = 2,
["icon"] = 135976,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105863,
["name"] = "Divine Fury",
["column"] = 3,
["icon"] = 135971,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105862,
["name"] = "Holy Nova",
["column"] = 1,
["icon"] = 135922,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105861,
["name"] = "Blessed Recovery",
["column"] = 2,
["icon"] = 135877,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105860,
["name"] = "Inspiration",
["column"] = 4,
["icon"] = 135928,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105859,
["name"] = "Holy Reach",
["column"] = 1,
["icon"] = 135949,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105858,
["name"] = "Improved Healing",
["column"] = 2,
["icon"] = 135916,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105857,
["name"] = "Searing Light",
["column"] = 3,
["icon"] = 135973,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105856,
["name"] = "Binding Heal",
["column"] = 4,
["icon"] = 135883,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105855,
["name"] = "Litany of Light",
["column"] = 1,
["icon"] = 134943,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105854,
["name"] = "Spirit of Redemption",
["column"] = 2,
["icon"] = 132864,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105853,
["name"] = "Spiritual Guidance",
["column"] = 3,
["icon"] = 135977,
["row"] = 5,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105852,
["name"] = "Spiritual Healing",
["column"] = 3,
["icon"] = 136057,
["row"] = 6,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105851,
["name"] = "Prayer of Mending",
["column"] = 2,
["icon"] = 135944,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Holy",
["icon"] = 135920,
},
},
{
["numtalents"] = 17,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 110851,
["name"] = "Shadow Focus",
["column"] = 1,
["icon"] = 136126,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105832,
["name"] = "Blackout",
["column"] = 2,
["icon"] = 136160,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105833,
["name"] = "Spirit Tap",
["column"] = 3,
["icon"] = 136188,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105831,
["name"] = "Improved Mind Blast",
["column"] = 1,
["icon"] = 136224,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105830,
["name"] = "Improved Shadow Word: Pain",
["column"] = 3,
["icon"] = 136207,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105829,
["name"] = "Shadow Reach",
["column"] = 4,
["icon"] = 136130,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105828,
["name"] = "Improved Psychic Scream",
["column"] = 2,
["icon"] = 136184,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105826,
["name"] = "Mind Flay",
["column"] = 3,
["icon"] = 136208,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105825,
["name"] = "Improved Mind Flay",
["column"] = 4,
["icon"] = 136213,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105823,
["name"] = "Dark Inspiration",
["column"] = 1,
["icon"] = 463284,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105820,
["name"] = "Vampiric Embrace",
["column"] = 2,
["icon"] = 136230,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105821,
["name"] = "Shadow Weaving",
["column"] = 3,
["icon"] = 136123,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105824,
["name"] = "Silence",
["column"] = 1,
["icon"] = 136164,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105819,
["name"] = "Devouring Contagion",
["column"] = 3,
["icon"] = 252996,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 110854,
["name"] = "Early Demise",
["column"] = 1,
["icon"] = 136149,
["row"] = 6,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105818,
["name"] = "Darkness",
["column"] = 3,
["icon"] = 136223,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105817,
["name"] = "Shadowform",
["column"] = 2,
["icon"] = 136200,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Shadow Magic",
["icon"] = 136207,
},
},
},
["hunter"] = {
{
["numtalents"] = 16,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 104960,
["name"] = "Deadly Aspects",
["column"] = 2,
["icon"] = 136076,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 104976,
["name"] = "Endurance Training",
["column"] = 3,
["icon"] = 136080,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 104975,
["name"] = "Focused Fire",
["column"] = 1,
["icon"] = 135539,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 104974,
["name"] = "Improved Aspect of the Monkey",
["column"] = 2,
["icon"] = 132159,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 104973,
["name"] = "Pathfinding",
["column"] = 3,
["icon"] = 132242,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 104972,
["name"] = "Improved Revive Pet",
["column"] = 4,
["icon"] = 132163,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 104970,
["name"] = "Bestial Swiftness",
["column"] = 2,
["icon"] = 132120,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 104969,
["name"] = "Unleashed Fury",
["column"] = 3,
["icon"] = 132091,
["row"] = 3,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 104968,
["name"] = "Improved Mend Pet",
["column"] = 1,
["icon"] = 132179,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 104967,
["name"] = "Ferocity",
["column"] = 3,
["icon"] = 134297,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 104966,
["name"] = "Summon Hawk",
["column"] = 4,
["icon"] = 132158,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 104965,
["name"] = "Spirit Bond",
["column"] = 1,
["icon"] = 132121,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 104964,
["name"] = "Intimidation",
["column"] = 2,
["icon"] = 132111,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 104963,
["name"] = "Bestial Discipline",
["column"] = 4,
["icon"] = 136006,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 104962,
["name"] = "Frenzy",
["column"] = 3,
["icon"] = 134296,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 104961,
["name"] = "Bestial Wrath",
["column"] = 2,
["icon"] = 132127,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Beast Mastery",
["icon"] = 132164,
},
},
{
["numtalents"] = 16,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105013,
["name"] = "Hawk Eye",
["column"] = 1,
["icon"] = 132327,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105012,
["name"] = "Improved Concussive Shot",
["column"] = 2,
["icon"] = 135860,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105011,
["name"] = "Lethal Attacks",
["column"] = 3,
["icon"] = 132312,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 110870,
["name"] = "Improved Stings",
["column"] = 1,
["icon"] = 132204,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105009,
["name"] = "Efficiency",
["column"] = 2,
["icon"] = 135865,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105008,
["name"] = "Careful Aim",
["column"] = 3,
["icon"] = 132217,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105005,
["name"] = "Rapid Killing",
["column"] = 1,
["icon"] = 132205,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105006,
["name"] = "Improved Arcane Shot",
["column"] = 2,
["icon"] = 132218,
["row"] = 3,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105007,
["name"] = "Lone Wolf",
["column"] = 4,
["icon"] = 132266,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105004,
["name"] = "Trueshot Aura",
["column"] = 2,
["icon"] = 132329,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105002,
["name"] = "Mortal Shots",
["column"] = 3,
["icon"] = 132271,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 104999,
["name"] = "Rapid Recuperation",
["column"] = 1,
["icon"] = 236201,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105001,
["name"] = "Barrage",
["column"] = 3,
["icon"] = 132330,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105000,
["name"] = "Scatter Shot",
["column"] = 4,
["icon"] = 132153,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 104998,
["name"] = "Ranged Weapon Specialization",
["column"] = 3,
["icon"] = 135615,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 104997,
["name"] = "Sniper Shot",
["column"] = 2,
["icon"] = 1412205,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Marksmanship",
["icon"] = 132222,
},
},
{
["numtalents"] = 18,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 104996,
["name"] = "Improved Tracking",
["column"] = 2,
["icon"] = 134154,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 104995,
["name"] = "Deflection",
["column"] = 3,
["icon"] = 132269,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 104994,
["name"] = "Entrapment",
["column"] = 1,
["icon"] = 136100,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 104993,
["name"] = "Savage Strikes",
["column"] = 2,
["icon"] = 132277,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 104992,
["name"] = "Survivalist",
["column"] = 3,
["icon"] = 136223,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 104990,
["name"] = "Improved Wing Clip",
["column"] = 4,
["icon"] = 132309,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 104991,
["name"] = "Clever Traps",
["column"] = 1,
["icon"] = 136106,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 104987,
["name"] = "Surefooted",
["column"] = 2,
["icon"] = 132219,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 104986,
["name"] = "Deterrence",
["column"] = 3,
["icon"] = 132369,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 104988,
["name"] = "Survival Tactics",
["column"] = 1,
["icon"] = 132149,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 110861,
["name"] = "Predator's Edge",
["column"] = 2,
["icon"] = 132147,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 104989,
["name"] = "Counterattack",
["column"] = 3,
["icon"] = 132336,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 104983,
["name"] = "Resourcefulness",
["column"] = 1,
["icon"] = 132207,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 104985,
["name"] = "Expose Prey",
["column"] = 2,
["icon"] = 132215,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 110860,
["name"] = "Survivalist's Discipline",
["column"] = 3,
["icon"] = 132178,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 104981,
["name"] = "Strider Kick",
["column"] = 4,
["icon"] = 132198,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 110859,
["name"] = "Lightning Reflexes",
["column"] = 3,
["icon"] = 136047,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 18,
["nodeID"] = 104984,
["name"] = "Lacerating Strikes",
["column"] = 2,
["icon"] = 132155,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Survival",
["icon"] = 132215,
},
},
},
["warlock"] = {
{
["numtalents"] = 17,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105921,
["name"] = "Improved Life Tap",
["column"] = 1,
["icon"] = 136126,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105925,
["name"] = "Suppression",
["column"] = 2,
["icon"] = 136230,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105924,
["name"] = "Improved Corruption",
["column"] = 3,
["icon"] = 136118,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105923,
["name"] = "Grim Reach",
["column"] = 1,
["icon"] = 136127,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105922,
["name"] = "Soul Harvest",
["column"] = 2,
["icon"] = 132851,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105920,
["name"] = "Improved Drains",
["column"] = 3,
["icon"] = 136163,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105919,
["name"] = "Improved Bane of Agony",
["column"] = 1,
["icon"] = 136139,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105918,
["name"] = "Fel Concentration",
["column"] = 2,
["icon"] = 136157,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105916,
["name"] = "Amplify Curse",
["column"] = 3,
["icon"] = 136132,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105917,
["name"] = "Pandemic",
["column"] = 4,
["icon"] = 136227,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 110876,
["name"] = "Malevolence",
["column"] = 1,
["icon"] = 136158,
["row"] = 4,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105914,
["name"] = "Nightfall",
["column"] = 2,
["icon"] = 136223,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105913,
["name"] = "Curse of Exhaustion",
["column"] = 3,
["icon"] = 136162,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105912,
["name"] = "Siphon Life",
["column"] = 2,
["icon"] = 136188,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105911,
["name"] = "Soul Siphon",
["column"] = 3,
["icon"] = 136169,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105910,
["name"] = "Shadow Mastery",
["column"] = 3,
["icon"] = 136195,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105909,
["name"] = "Wrack",
["column"] = 2,
["icon"] = 460687,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Affliction",
["icon"] = 136145,
},
},
{
["numtalents"] = 19,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105905,
["name"] = "Improved Health Funnel",
["column"] = 1,
["icon"] = 136168,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105908,
["name"] = "Improved Imp",
["column"] = 2,
["icon"] = 136218,
["row"] = 1,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105907,
["name"] = "Demonic Embrace",
["column"] = 3,
["icon"] = 136172,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105906,
["name"] = "Unholy Power",
["column"] = 4,
["icon"] = 136206,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105902,
["name"] = "Demonic Aegis",
["column"] = 1,
["icon"] = 136185,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105904,
["name"] = "Improved Voidwalker",
["column"] = 2,
["icon"] = 136221,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105903,
["name"] = "Fel Vitality",
["column"] = 3,
["icon"] = 136150,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105899,
["name"] = "Demonic Energies",
["column"] = 4,
["icon"] = 237564,
["row"] = 2,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105901,
["name"] = "Improved Sayaad",
["column"] = 1,
["icon"] = 4352493,
["row"] = 3,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105900,
["name"] = "Demonic Sacrifice",
["column"] = 2,
["icon"] = 136184,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105898,
["name"] = "Master Summoner",
["column"] = 3,
["icon"] = 136164,
["row"] = 3,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105897,
["name"] = "Decimation",
["column"] = 1,
["icon"] = 135808,
["row"] = 4,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105895,
["name"] = "Fel Domination",
["column"] = 3,
["icon"] = 136082,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105896,
["name"] = "Demonic Brand",
["column"] = 4,
["icon"] = 4226151,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105894,
["name"] = "Improved Felhunter",
["column"] = 1,
["icon"] = 136217,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105892,
["name"] = "Soul Link",
["column"] = 2,
["icon"] = 136160,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 17,
["nodeID"] = 105893,
["name"] = "Demonic Knowledge",
["column"] = 3,
["icon"] = 136165,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 18,
["nodeID"] = 105891,
["name"] = "Master Demonologist",
["column"] = 3,
["icon"] = 136203,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 19,
["nodeID"] = 105890,
["name"] = "Demonic Pact",
["column"] = 2,
["icon"] = 5927650,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Demonology",
["icon"] = 136172,
},
},
{
["numtalents"] = 16,
["talents"] = {
{
["info"] = {
["wowTreeIndex"] = 1,
["nodeID"] = 105881,
["name"] = "Destructive Reach",
["column"] = 1,
["icon"] = 136133,
["row"] = 1,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 2,
["nodeID"] = 105889,
["name"] = "Improved Shadow Bolt",
["column"] = 2,
["icon"] = 136197,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 3,
["nodeID"] = 105888,
["name"] = "Bane",
["column"] = 3,
["icon"] = 136146,
["row"] = 1,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 4,
["nodeID"] = 105885,
["name"] = "Molten Skin",
["column"] = 1,
["icon"] = 132221,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 5,
["nodeID"] = 105887,
["name"] = "Cataclysm",
["column"] = 2,
["icon"] = 135831,
["row"] = 2,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 6,
["nodeID"] = 105886,
["name"] = "Aftermath",
["column"] = 3,
["icon"] = 135805,
["row"] = 2,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 7,
["nodeID"] = 105883,
["name"] = "Ruin",
["column"] = 2,
["icon"] = 136207,
["row"] = 3,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 8,
["nodeID"] = 105884,
["name"] = "Shadowburn",
["column"] = 3,
["icon"] = 136191,
["row"] = 3,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 9,
["nodeID"] = 105882,
["name"] = "Intensity",
["column"] = 1,
["icon"] = 135819,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 10,
["nodeID"] = 105879,
["name"] = "Agonizing Flames",
["column"] = 2,
["icon"] = 135827,
["row"] = 4,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 11,
["nodeID"] = 105880,
["name"] = "Conflagrate",
["column"] = 3,
["icon"] = 135807,
["row"] = 4,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 12,
["nodeID"] = 105878,
["name"] = "Pyroclasm",
["column"] = 1,
["icon"] = 135830,
["row"] = 5,
["ranks"] = 2,
},
},
{
["info"] = {
["wowTreeIndex"] = 13,
["nodeID"] = 105876,
["name"] = "Bane of Havoc",
["column"] = 2,
["icon"] = 460695,
["row"] = 5,
["ranks"] = 1,
},
},
{
["info"] = {
["wowTreeIndex"] = 14,
["nodeID"] = 105877,
["name"] = "Fire and Brimstone",
["column"] = 3,
["icon"] = 135821,
["row"] = 5,
["ranks"] = 3,
},
},
{
["info"] = {
["wowTreeIndex"] = 15,
["nodeID"] = 105875,
["name"] = "Shadow and Flame",
["column"] = 3,
["icon"] = 135823,
["row"] = 6,
["ranks"] = 5,
},
},
{
["info"] = {
["wowTreeIndex"] = 16,
["nodeID"] = 105874,
["name"] = "Incinerate",
["column"] = 2,
["icon"] = 135789,
["row"] = 7,
["ranks"] = 1,
},
},
},
["info"] = {
["name"] = "Destruction",
["icon"] = 136186,
},
},
},
};



function NRC:getTalentData(class)
	class = string.lower(class);
	return talents[class];
end

local talentDataCache = {};
function NRC:getTalentDataFromAPI(class)
	if (talentDataCache[class]) then
		return talentDataCache[class];
	end
	--This is a mixture of new stuff and stuff from my old era talent exporter, it might look a bit odd.
	--It has to build the old structure that matches the era data to work with the rest of the addon.
	local treeID = NRC.LibTalentTree:GetClassTreeID(class); --Get the single classID for this class (forever has 1 tree only that poiints to the entire class)
	local configID = Constants.TraitConsts.VIEW_TRAIT_CONFIG_ID;
	local talentData = {};
	local temp = {};
    local nodes = C_Traits.GetTreeNodes(treeID)
    for i, nodeID in ipairs(nodes) do
    	local nodeInfo = C_Traits.GetNodeInfo(configID, nodeID);
    	if (not nodeInfo) then
    		NRC:debug("Missing nodeinfo:", i, nodeID, treeID);
    		--Use backup local db when cache fails, I update when I remember to export it after blizzard changes something, usually it's not needed.
			return NRC:getTalentData(class);
    	end
    	local spellInfo;
		for _, entryID in pairs(nodeInfo.entryIDs) do
			local entryInfo = C_Traits.GetEntryInfo(configID, entryID)
		    if entryInfo and entryInfo.definitionID then
		        local definitionInfo = C_Traits.GetDefinitionInfo(entryInfo.definitionID)
		        spellInfo = C_Spell.GetSpellInfo(definitionInfo.spellID);
		    end
		end
    	local column, row = NRC.LibTalentTree:GetNodeGridPosition(nodeID);
    	--If column or row is mssing it's a talent outside the UI blizz hasn't removed yet.
    	if (column and row) then
	    	local tab = column < 5 and 1 or column < 9 and 2 or 3;
	    	--Convert the overall column to per spec column.
	    	if (tab == 2) then
	    		column = column - 4;
	    	end
	    	if (tab == 3) then
	    		column = column - 8;
	    	end
			local t = {
				row = row,
				icon = spellInfo.iconID,
				ranks = nodeInfo.maxRanks,
				--wowTreeIndex = count, --This is inserted below.
				column = column,
				name = spellInfo.name,
				nodeID = nodeID,
			};
			
			local talentInfoQuery = {
				specializationIndex = 1,
			    talentIndex = 1,
			    --tier = 1,
			};
			--talentID is dead in forever.
			--[[local talentInfo = C_SpecializationInfo.GetTalentInfo(talentInfoQuery);
			local talentID = talentInfo.talentID;
			if (data[talentID]) then
				local r = {};
				for k, v in pairs(data[talentID]) do
					--0 means no rank exists for this rank num.
					if (v ~= 0) then
						tinsert(r, v);
					end
				end
				t.talentRankSpellIds = r;
			end]]
			
			if (not temp[tab]) then
	    		temp[tab] = {};
	    	end
			tinsert(temp[tab], t);
			temp[tab].treeID = treeID;
		end
    end
	
	for tab, tabData in ipairs(temp) do
		talentData[tab] = {};
		talentData[tab].talents = {};
		local count = 0;
		for k, v in ipairs(tabData) do
			count = count + 1;
			talentData[tab].talents[count] = {};
			talentData[tab].talents[count].info = {
				row = v.row,
				icon = v.icon,
				ranks = v.ranks,
				--wowTreeIndex = count, --This is inserted below.
				column = v.column,
				name = v.name,
				talentRankSpellIds = v.talentRankSpellIds;
				nodeID = v.nodeID,
			};
			--audit = audit + 1;
		end
		talentData[tab].numtalents = count;
		local displayInfo = C_Traits.GetGroupDisplayInfoByTreeID(tabData.treeID);
		talentData[tab].info = {
			--background = "PaladinHoly", --We don't us background in Forever, using the new atlas instead.
			name = displayInfo[tab].displayName,
			icon = displayInfo[tab].icon,
		};
	end
	--Now we have the data we need to order it by the wowTreeIndex (the order left to right then down that actual talents appear on the UI).
	--The wowTreeIndex is not the same as how blizzard has the index ordered in GetTalentInfo(tab, index).
	--Number 1 in the Blizzard index could be number 15 in the order they're displayed etc.
	--We want our table ordered in the order they're displayed for eaze of use (and how Nova Raid Companion requires it).
	--Bit messy, but works..
	local rows = {};
	for tab, tabData in ipairs(talentData) do
		--Create tables with row/column for each talent in order.
		if (not rows[tab]) then
			rows[tab] = {};
		end
		for k, talent in ipairs(tabData.talents) do
			if (not rows[tab][talent.info.row]) then
				rows[tab][talent.info.row] = {};
			end
			rows[tab][talent.info.row][talent.info.column] = talent.info.name;
		end
	end
	--Iterate the row/colum data in order for each tree and assign the wowTreeIndex number.
	for tab, tabData in ipairs(rows) do
		local count = 0;
		for row, rowData in ipairs(tabData) do
			for column, talentName in NRC:pairsByKeys(rowData) do
				count = count + 1;
				--Find the correct talent name and insert the index, should work fine as talent names are always unique (I hope).
				for k, v in ipairs(talentData[tab].talents) do
					if (v.info.name == talentName) then
						v.info.wowTreeIndex = count;
					end
				end
			end
		end
	end
	--Finally sort each tab by wowTreeIndex.
	for tab, tabData in ipairs(talentData) do
		table.sort(tabData.talents, function(a, b) return a.info.wowTreeIndex < b.info.wowTreeIndex end);
	end
	talentDataCache[class] = talentData;
	return talentData;
end

function NRC:getTabData(class)
	class = string.lower(class);
	if (talents[class]) then
		local tabData = {};
		for k, v in ipairs(talents[class]) do
			tabData[k] = {
				numTalents = v.numtalents;
			};
		end
		return tabData;
	end
end