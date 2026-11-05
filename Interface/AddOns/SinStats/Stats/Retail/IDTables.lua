local AddName, Ns = ...
local L = Ns.L


--------------------------
--		Stat Init		--
--------------------------

Ns.greenText, Ns.redText, Ns.orangeText, Ns.blueText, Ns.purpleText, Ns.whiteText = "|cff71FFC9", "|cffC41E3A", "|cffFF7C0A", "|cff0070FF", "|cffA335EE", "|cffffffff"

-- Spec abbreviations (specID -> abbrev), English PvP conventions. Used on
-- English clients only; other locales abbreviate their localized names via
-- Ns.AbbreviateName (Updater.lua).
Ns.SpecAbbrevs = {
	[62] = "Arc",    [63] = "Fire",   [64] = "Frost",
	[65] = "Holy",   [66] = "Prot",   [70] = "Ret",
	[71] = "Arms",   [72] = "Fury",   [73] = "Prot",
	[102] = "Bal",   [103] = "Feral", [104] = "Guard", [105] = "Resto",
	[250] = "Blood", [251] = "Frost", [252] = "UH",
	[253] = "BM",    [254] = "MM",    [255] = "SV",
	[256] = "Disc",  [257] = "Holy",  [258] = "Shadow",
	[259] = "Sin",   [260] = "Outlaw", [261] = "Sub",
	[262] = "Ele",   [263] = "Enh",   [264] = "Resto",
	[265] = "Aff",   [266] = "Demo",  [267] = "Destro",
	[268] = "Brew",  [269] = "WW",    [270] = "MW",
	[577] = "Havoc", [581] = "Veng",
	[1467] = "Devo", [1468] = "Pres", [1473] = "Aug",
}

-- Exact abbreviations for hero talent trees (subTreeID -> abbrev);
-- fill entries as needed, Ns.AbbreviateName handles the rest.
Ns.HeroAbbrevs = {}

Ns.classFilename = select(2, UnitClass("player"))
Ns.classId = select(3, UnitClass("player"))
Ns.shatteringStar, Ns.combustion, Ns.luckOfDraw, Ns.percentLoamm = 0, 0, 0, 0
Ns.masteryFx, Ns.delver = 0, 0
-- evoker
Ns.InstinctArcana, Ns.iridescence, Ns.ebonMight = 0, 0, 0
-- monk
Ns.mysticTouch, Ns.jadeFire, Ns.serenity, Ns.hitCombo = 0, 0, 0, 0
Ns.ferocityXuen, Ns.FerocityXuen, Ns.martial, Ns.MartialInstincts = 0, 0, 0, 0
-- mage
Ns.arcaneSurge, Ns.enlightened, Ns.impetus = 0, 0, 0
-- dh
Ns.chaosBrand, Ns.demonSoul = 0, 0
-- rogue
Ns.betweenEyes, Ns.symbolsDeath, Ns.ghostlyStrike = 0, 0, 0
-- warrior
Ns.colossusSmash, Ns.avatar, Ns.battleShout, Ns.defStance = 0, 0, 0, 0
Ns.enrage = false
-- dk
Ns.razorIce = 0
-- warlock
Ns.felSunder, Ns.eradication, Ns.demonicSynergy = 0, 0, 0
-- mage
Ns.overflowEnergy, Ns.runePower, Ns.incanterFlow, Ns.touchOfIce = 0, 0, 0, 0
-- priest
Ns.shadowForm = 0
-- hunter
Ns.LoneWolf, Ns.barbedShot, Ns.bestialWrath, Ns.huntersMark = 0, 0, 0, 0
-- druid
Ns.tigersFury = 0
-- paladin
Ns.finalReck, Ns.retAura, Ns.avWrath = 0, 0, 0
-- demon hunter
Ns.momentum, Ns.seethChaos, Ns.inertia = 0, 0, 0
-- shaman
Ns.equilibrium, Ns.Equilibrium, Ns.feralSpirit = 0, 0, 0
-- druid
Ns.friendFae, Ns.wanTwilight = 0, 0

-- stats compute
Ns.combustion, Ns.serenity, Ns.overflowEnergy, Ns.luckOfDraw = 0, 0, 0, 0
Ns.hitCombo, Ns.shadowForm, Ns.loneWolf, Ns.runePower = 0, 0, 0, 0
Ns.incanterFlow, Ns.demonSoul, Ns.tigersFury, Ns.momentum = 0, 0, 0, 0
Ns.touchOfIce, Ns.demonicSynergy, Ns.seethChaos, Ns.equilibrium = 0, 0, 0, 0
Ns.iridescence, Ns.arcaneSurge, Ns.enlightened, Ns.symbolsDeath = 0, 0, 0, 0
Ns.ebonMight, Ns.avatar, Ns.battleShout, Ns.defStance, Ns.feralSpirit = 0, 0, 0, 0, 0
Ns.bestialWrath, Ns.friendFae, Ns.retAura, Ns.inertia = 0, 0, 0, 0
Ns.avWrath, Ns.delver, Ns.impetus, Ns.enrage = 0, 0, 0, false

-- sinlive
Ns.shatteringStar, Ns.betweenEyes = 0, 0
Ns.chaosBrand, Ns.mysticTouch, Ns.colossusSmash, Ns.razorIce = 0, 0, 0, 0
Ns.felSunder, Ns.jadeFire, Ns.brittle, Ns.eradication = 0, 0, 0, 0
Ns.finalReck = 0
Ns.ghostlyStrike, Ns.wanTwilight, Ns.huntersMark = 0, 0, 0

--------------------------
--		ID Tables		--
--------------------------

Ns.CrestData = {
	Adventurer	= 3442,
	Veteran		= 3443,
	Champion	= 3444,
	Hero		= 3445,
	Myth		= 3446,
}

Ns.RenownData = {
	Silvermoon	= 2710,
	Amani		= 2696,
	Arati		= 2704,
	Singularity	= 2699,
	Delver 		= 2796,
	Prey		= 2808,
	Ritual 		= 2792,
	Zuljarra	= 2772,
	Tokka		= 2773,
	Kindojan	= 2836,
	Aqir		= 2838,
}

Ns.CurrencyData = {
	Darkmoon		= { id = 515 },
	Undercoin		= { id = 2803, decimals = true },
	Voidlight		= { id = 3316, decimals = true },
	Arcana			= { id = 3379, decimals = true },
	Timewarped		= { id = 1166, decimals = true },
	TraderTender	= { id = 2032, decimals = true },
	Coupons			= { id = 3363, decimals = true },
	Twilight		= { id = 3319, decimals = true },
	Abundance		= { id = 3377, decimals = true },
	Anguish			= { id = 3392, decimals = true },
	Catalyst		= { id = 3465 },
	RestoredKey		= { id = 3028 },
	BloodyTokens	= { id = 2123 },
	ValorPoints		= { id = 1191 },
	Conquest		= { id = 1602, decimals = true },
	Luminous		= { id = 3385, decimals = true },
	Dundun			= { id = 3376, decimals = true },
	ManaCrystals	= { id = 3356, decimals = true },
	VoidSample		= { id = 3400 },
	Accolade		= { id = 3405, decimals = true },
	AnglerPearls	= { id = 3373, decimals = true },
	Voidcore		= { id = 3418, decimals = true },
	Illusionary		= { id = 3393, decimals = true },
	CoiledFil		= { id = 3546, decimals = true },
	Corrosive		= { id = 3448, decimals = true },
}

Ns.ShatteringStar = {
	[370452] = {0.2},
}

Ns.GhostlyStrike = {
	[196937] = {0.15},
}

Ns.FriendFae = {
	[394083] = {10},
}

Ns.Delver = {
	[455329] = {10},
}

Ns.WaningTwilight = {
	[393957] = {6},
}

Ns.Momentum = {
	[208628] = {8},
}

Ns.Enrage = {
	[184362] = {22},
}

Ns.Impetus = {
	[393939] = {10},
}

Ns.HuntersMark = {
	[257284] = {0.08},
}

Ns.Combustion = {
	[190319] = {100},
}

Ns.ArcaneSurge = {
	[365362] = {35},
}

Ns.Enlightened = {
	[321388] = {6},
}

Ns.AvengeWrath = {
	[31884] = {20},
}

Ns.SymbolsDeath = {
	[212283] = {10},
}

Ns.Iridescence = {
	[386399] = {20},
}

Ns.BetweenEyes = {
	[315341] = {20},
}

Ns.ChaosBrand = {
	[1490] = {0.03},
}

Ns.MysticTouch = {
	[113746] = {0.05},
}

Ns.ColossusSmash = {
	[208086] = {0.3},
}

Ns.ElementalEquilibrium = {
	[378275] = true,
}

Ns.LoneWolf = {
	[164273] = {5},
}

Ns.RazorIce = {
	[51714] = true,
}

Ns.FelSunder = {
	[387402] = true,
}

Ns.Jadefire = {
	[395414] = {0.06},
}

Ns.EbonMight = {
	[395296] = {0.14},
}

Ns.Serenity = {
	[152173] = {0.15},
}

Ns.Overflowing = {
	[394195] = true,
}

Ns.LuckOfTheDraw = {
	[72221] = true,
}

Ns.HitCombo = {
	[196741] = true,
}

Ns.Shadowform = {
	[232698] = {0.10},
}

Ns.Brittle = {
	[374557] = {0.06},
}

Ns.TigersFury = {
	[5217] = {15},
}

Ns.Eradication = {
	[196414] = {5},
}

Ns.RuneOfPower = {
	[116014] = {0.40},
}

Ns.IncanterFlow = {
	[116267] = true,
}

Ns.DemonSoul = {
	[347765] = {20},
}

Ns.FinalReckoning = {
	[343721] = {30},

}

Ns.TouchOfIce = {
	[394994] = {0.08},
}

Ns.DemonicSynergy = {
	[171982] = {0.1},
}

Ns.SeethChaos = {
	[394934] = {0.05},
}

Ns.Avatar = {
	[107574] = {20},
}

Ns.BattleShout = {
	[6673] = {5},
}

Ns.RetAura = {
	[404996] = {5},
}

Ns.Inertia = {
	[427641] = {18},
}

Ns.Spark = {
	Shadowflame = 204440,
	Ingenuity = 190453,
	Dreams = 206959,
	splDreams = 208396,
	Awake = 211516,
	splAwake = 211515,
}

Ns.DefStance = {
	[386208] = {10},
}

Ns.FeralSpirit = {
	[333957] = {15},
}

Ns.BarbedShot = {
	[272790] = {3},
}

Ns.Seeds = {
	Gigantic = 208047,
	Plump = 208067,
	Bloom = 211376,
}

Ns.BestialWrath = {
	[19574] = {25},
}