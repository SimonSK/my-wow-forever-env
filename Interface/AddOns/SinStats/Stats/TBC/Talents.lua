local _, Ns = ...

local function knownRank(spellIDs)
	for i = #spellIDs, 1, -1 do
		if C_SpellBook.IsSpellKnown(spellIDs[i]) then
			return i
		end
	end
	return 0
end

local TalentSpells = {
	MAGE = {
		ArcaneMind       = {11232, 12500, 12501, 12502, 12503},
		EmpoweredFB      = {31656, 31657, 31658, 31659, 31660},
		ElementalPrec    = {29438, 29439, 29440},
		PlayingWithFire  = {31638, 31639, 31640},
		ArcticWinds      = {31674, 31675, 31676, 31677, 31678},
		FirePower        = {11124, 12378, 12398, 12399, 12400},
		PiercingIce      = {11151, 12952, 12953},
		ArcaneFocus      = {11222, 12839, 12840, 12841, 12842},
	},
	PRIEST = {
		ShadowFocus      = {15260, 15327, 15328, 15329, 15330},
		Darkness         = {15259, 15307, 15308, 15309, 15310},
		SpiritualHealing = {14898, 15349, 15354, 15355, 15356},
	},
	PALADIN = {
		Conviction       = {20117, 20118, 20119, 20120, 20121},
		Vengeance        = {20049, 20056, 20057, 20058, 20059},
		CombatExpertise  = {31858, 31859, 31860, 31861, 31862},
	},
	ROGUE = {
		WeaponExpertise  = {30919, 30920},
	},
	WARRIOR = {
		Defiance         = {12303, 12788, 12789},
	},
	WARLOCK = {
		ShadowMastery    = {18271, 18272, 18273, 18274, 18275},
		Emberstorm       = {17954, 17955, 17956, 17957, 17958},
		Suppression      = {18174, 18175, 18176, 18177, 18178},
		MasterDemo       = {23785, 23822, 23823, 23824, 23825},
		Devastation      = {18130, 18131, 18132, 18133, 18134},
	},
	HUNTER = {
		SerpentSwift     = {34466, 34467, 34468, 34469, 34470},
	},
	SHAMAN = {
		Purification     = {16178, 16210, 16211, 16212, 16213},
		NatGuidance      = {16180, 16196, 16198},
		ElePrecision     = {30672, 30673, 30674},
		UnrelentingStorm = {30664, 30665, 30666, 30667, 30668},
		NatBlessing      = {30867, 30868, 30869},
		TotemicFocus     = {16173, 16222, 16223, 16224, 16225},
		TidalMastery     = {16194, 16218, 16219, 16220, 16221},
		CallOfThunder    = {16041, 16117, 16118, 16119, 16120},
	},
	DRUID = {
		BalanceOfPower   = {33592, 33596},
		GiftOfNature     = {17104, 24943, 24944, 24945, 24946},
		SurvOfFittest    = {33853, 33855, 33856},
		StarlightWrath   = {16814, 16815, 16816, 16817, 16818},
		DreamState       = {33597, 33599, 33956},
	},
}

function Ns.talentScan()
	local _, classFilename = UnitClass("player")
	local spells = TalentSpells[classFilename]
	if not spells then return end

	if classFilename == "MAGE" then
		local points = knownRank(spells.ArcaneMind)
		Ns.arcaneMod = points * 1
		Ns.aiMod = (points * 1) / 100

		points = knownRank(spells.EmpoweredFB)
		Ns.impFrostbolt = points * 1
		Ns.impFbDmg = (points * 2) / 100

		points = knownRank(spells.ElementalPrec)
		Ns.hitMod = points

		points = knownRank(spells.PlayingWithFire)
		Ns.playFire = (points * 1) / 100

		points = knownRank(spells.ArcticWinds)
		Ns.arcticWind = (points * 1) / 100

		points = knownRank(spells.FirePower)
		Ns.firepowerMod = (points * 2) / 100

		points = knownRank(spells.PiercingIce)
		Ns.pierceMod = (points * 2) / 100

		points = knownRank(spells.ArcaneFocus)
		Ns.arcaneFocus = (points * 2)
		if Ns.arcaneFocus > 0 then
			Ns.arcaneFocus = "|cff8788EE +" .. (points * 2) .. "|r"
		else
			Ns.arcaneFocus = ""
		end

	elseif classFilename == "PRIEST" then
		local points = knownRank(spells.ShadowFocus)
		Ns.hitMod = points * 2

		points = knownRank(spells.Darkness)
		Ns.DarkNessTalent = (points * 2) / 100

		points = knownRank(spells.SpiritualHealing)
		Ns.spiritualHealing = (points * 2) / 100

	elseif classFilename == "PALADIN" then
		local points = knownRank(spells.Conviction)
		Ns.crusaderTalent = points * 1

		points = knownRank(spells.Vengeance)
		Ns.vengeance = points * 1

		points = knownRank(spells.CombatExpertise)
		Ns.expTalent = points * 1

	elseif classFilename == "ROGUE" then
		Ns.expTalent = knownRank(spells.WeaponExpertise) * 5

	elseif classFilename == "WARRIOR" then
		Ns.expTalent = knownRank(spells.Defiance) * 2

	elseif classFilename == "WARLOCK" then
		local points = knownRank(spells.ShadowMastery)
		Ns.shadowMastery = (points * 2) / 100

		points = knownRank(spells.Emberstorm)
		Ns.emberstorm = (points * 2) / 100

		points = knownRank(spells.Suppression)
		Ns.Suppression = (points * 2)
		if Ns.Suppression > 0 then
			Ns.Suppression = "|cff8788EE +" .. (points * 2) .. "|r"
		else
			Ns.Suppression = ""
		end

		points = knownRank(spells.MasterDemo)
		Ns.masterDemo = (points * 2) / 100

		points = knownRank(spells.Devastation)
		Ns.devastation = points * 1

	elseif classFilename == "HUNTER" then
		local points = knownRank(spells.SerpentSwift)
		Ns.serpentSwift = points * 4

	elseif classFilename == "SHAMAN" then
		local points = knownRank(spells.Purification)
		Ns.purification = (points * 2) / 100

		points = knownRank(spells.NatGuidance)
		Ns.natGuidance = points

		points = knownRank(spells.ElePrecision)
		Ns.elePrecision = points * 2

		points = knownRank(spells.UnrelentingStorm)
		Ns.unrStorm = points * 2

		points = knownRank(spells.NatBlessing)
		Ns.natBlessing = (points * 10) / 100

		points = knownRank(spells.TotemicFocus)
		Ns.totemTalent = (points * 5) / 100

		points = knownRank(spells.TidalMastery)
		Ns.tidalMastery = points * 1

		points = knownRank(spells.CallOfThunder)
		Ns.callofThunder = points * 1
		if Ns.callofThunder > 0 then
			Ns.callofThunder = "|cff0070DD +" .. (points * 1) .. "|r"
		else
			Ns.callofThunder = ""
		end

	elseif classFilename == "DRUID" then
		local points = knownRank(spells.BalanceOfPower)
		Ns.balancePower = points * 2

		points = knownRank(spells.GiftOfNature)
		Ns.giftNature = (points * 2) / 100

		points = knownRank(spells.SurvOfFittest)
		Ns.survFittest = points * 1

		points = knownRank(spells.StarlightWrath)
		Ns.starlight = points * 2

		points = knownRank(spells.DreamState)
		if points == 1 then
			Ns.DreamState = 0.04
		elseif points == 2 then
			Ns.DreamState = 0.07
		elseif points == 3 then
			Ns.DreamState = 0.1
		end
	end
end
