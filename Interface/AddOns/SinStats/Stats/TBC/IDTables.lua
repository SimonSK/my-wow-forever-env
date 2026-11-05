local AddName, Ns = ...
local L = Ns.L


--------------------------
--		Stat Init		--
--------------------------

-- Init
Ns.greenText, Ns.redText, Ns.orangeText = "|cff71FFC9", "|cffC41E3A", "|cffFF7C0A"
 

--mage
Ns.firepowerMod = 0
Ns.apFire = 0
Ns.pierceMod = 0
Ns.apFrost = 0
Ns.combustionCount = 0
Ns.arcaneMod = 0
Ns.aiMod = 0
Ns.arcanePower = 0
Ns.playFire = 0
Ns.arcticWind = 0
Ns.maxmana = 0
Ns.impSorch = 0
Ns.wintersChill = 0
Ns.arcaneFocus = ""
Ns.arcanePotencyTalent = 0
Ns.impFrostbolt = 0
Ns.impFbDmg = 0
-- paladin
Ns.bowisdom = 0
Ns.judgeCrusader = 0
Ns.crusaderTalent = 0
Ns.crusader = 0
Ns.avenWrath = 0
--Ns.wisTalent = 0
Ns.sancAura = 0
Ns.vengStacks = 0
Ns.vengeance = 0
Ns.vengBuff = 0
-- shaman
Ns.emberstorm = 0
Ns.totemMana = 0
Ns.stormStrike = 0
Ns.tidalMastery = 0
Ns.callofThunder = ""
--Ns.tideTotem = 0
Ns.spiritualHealing = 0
Ns.springTotem = 0
Ns.purification = 0
Ns.natGuidance = 0
Ns.elePrecision = 0
Ns.unrStorm = 0
Ns.natBlessing = 0
Ns.eleMastery = 0
Ns.totemWrath = 0
Ns.manaTide = 0
Ns.totemTalent = 0
-- warlock
Ns.felEnergy = 0 
Ns.dsImp = 0
Ns.dsSuc = 0
Ns.shadowMastery = 0
Ns.silithyst = 0
Ns.shadowDmg = 0
Ns.curseElements = 0
Ns.Suppression = ""
Ns.devastation = 0
Ns.masterDemo = 0
Ns.curseOfReck = 0
-- warrior
Ns.bloodFrenzy = 0
Ns.sunderArmor = 0
-- rogue
Ns.hemoDmg = 0
Ns.exposeArmor = 0
-- priest
Ns.shadowFormDmg = 0
Ns.DarkNessTalent = 0
Ns.epiphany = 0
Ns.innerFocus = 0
Ns.misery = 0
-- druid
Ns.balancePower = 0
Ns.DreamState = 0
Ns.giftNature = 0
Ns.innervate = 0
Ns.insectSwarm = 0
Ns.survFittest = 0
Ns.starlight = 0
Ns.faerieFire = 0
Ns.feralAP = 0
-- hunter
Ns.pouchCounter = 0
Ns.huntersMark = 0
Ns.scorpidSting = 0
Ns.hmIncrements = 0
--Ns.hmCap = 0
Ns.savedHM = 0
Ns.hmInc = 0
-- other
Ns.className, Ns.classFilename, Ns.classId = UnitClass("player") 
Ns.playerLevel = UnitLevel("player")
_, Ns.raceFile, _ = UnitRace("player")
Ns.headerHeight = 15
Ns.weaponTag = "Weapon"
Ns.headerLoc = "Weapon Skills"
Ns.defenseLoc = DEFENSE		
Ns.spellSuccess = false
Ns.regenBase = 0
Ns.warchief = 0
Ns.regenCasting = 0
Ns.adjustedRegen = 0
Ns.tempRegen = 0
Ns.manaUsed = 0
Ns.oldMana = 0
Ns.ManaUpdate = false
Ns.speedColor = ""
Ns.hitMod = 0
Ns.expTalent = 0
Ns.mp5 = 0
Ns.notcasting = 0
Ns.zoneBuff = 0
Ns.aspectViper = 0
Ns.secondWind = 0   
Ns.hasteMeleeMod = 0
Ns.hasteRangedMod = 0
Ns.hasteSpellMod = 0
Ns.meleeHaste = 0
Ns.rangedHaste = 0
Ns.castHaste = 0
Ns.hasteHead = 0
Ns.hasteLegs = 0
Ns.hasteHands = 0
Ns.serpentSwift = 0
Ns.inspiSpellHit = 0
Ns.tierPieces = 0
Ns.zgPieces = 0
Ns.inspiringPresence = 0
Ns.heroicPresence = 0
Ns.dwarfRacial = false
Ns.shadowVuln = 0
Ns.targetGUID = 0
Ns.huntersMark = 0
Ns.buffCount = 0
Ns.debuffCount = 0
Ns.shatterArmor = 0
Ns.targetArmor = 0
Ns.missMod = 0
Ns.playerGUID = UnitGUID("player")

Ns.totalDefense = 0
Ns.baseDefense, Ns.defenseRating, Ns.gearDefense = 0, 0, 0

Ns.meleeCrit, Ns.spellCrit, Ns.rangedCrit, Ns.meleeMissTracker, Ns.spellMissTracker, Ns.rangedMissTracker, Ns.totalParryDodge = 0, 0, 0, 0, 0, 0, 0
Ns.critReceived, Ns.totalDodge, Ns.totalParry, Ns.totalBlock, Ns.simEnabled, Ns.classDR, Ns.buffDR, Ns.auraDR = 0, 0, 0, 0, 0, 1, 1, 1

if (GetLocale() == "frFR") then
	Ns.headerLoc = "Compétences d’armes"
	Ns.weaponTag = "Arme"
	Ns.defenseLoc = DEFENSE	
elseif (GetLocale() == "esES") then
	Ns.weaponTag = "Arma"
	Ns.headerLoc = "Habilidades con armas"
	Ns.defenseLoc = DEFENSE	
elseif (GetLocale() == "deDE") then
	Ns.weaponTag = "Waffe"
	Ns.headerLoc = "Waffenfertigkeiten"
	Ns.defenseLoc = DEFENSE		
elseif (GetLocale() == "itIT") then
	Ns.weaponTag = "Arma"
	Ns.headerLoc = "Abilità con le armi"
	Ns.defenseLoc = DEFENSE		
elseif (GetLocale() == "ruRU") then
	Ns.weaponTag = "Oружие"
	Ns.headerLoc = "Оружейные навыки"
	Ns.defenseLoc = DEFENSE		
elseif (GetLocale() == "ptBR") then
	Ns.weaponTag = "Arma"
	Ns.headerLoc = "Weapon Skills"
	Ns.defenseLoc = DEFENSE	
elseif (GetLocale() == "zhCN") then
	Ns.headerLoc = "武器技能"
	Ns.defenseLoc = DEFENSE	
elseif (GetLocale() == "koKR") then
	Ns.headerLoc = "무기 기술"
	Ns.defenseLoc = "방어"	
elseif (GetLocale() == "zhTW") then
	Ns.headerLoc = "武器技能"
	Ns.defenseLoc = DEFENSE		
else 
	Ns.weaponTag = "Weapon"
	Ns.headerLoc = "Weapon Skills"
	Ns.defenseLoc = DEFENSE	
end

Ns.manaTideCheck = {
	[16190] = true,
	[39609] = true,
}

--------------------------
-- Draenei racial check --
--------------------------
if (Ns.raceFile == "Draenei" and Ns.classFilename == "MAGE") or (Ns.raceFile == "Draenei" and Ns.classFilename == "PRIEST") or (Ns.raceFile == "Draenei" and Ns.classFilename == "SHAMAN") then
	Ns.inspiSpellHit = 1
end

------------------------
-- Dwarf racial check --
------------------------
if (Ns.raceFile == "Dwarf") then
	Ns.dwarfRacial = true
end

Ns.huntersMarkRanks = {
	[1130] = true,
    [14323] = true,
    [14324] = true,
    [14325] = true,
}

Ns.hunterSpells = {
    [GetSpellInfo(2643)] = true,
    [GetSpellInfo(14287)] = true,
    [GetSpellInfo(19434)] = true,
    [GetSpellInfo(34120)] = true,
}