local AddName, Ns = ...
local L = Ns.L


-- Init
local hitTimes, selfhitTimes, critTimes, spellhitTimes, spellcritTimes, swingMissed, swingParryDodge, swingCount, critCount, selfSpellhitTimes, spMissCount, rMissCount, parrydodgeCount = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
local dodgeCount, parryCount, blockCount, rangedcritTimes, rangedhitTimes = 0, 0, 0, 0, 0

function Ns.PouchHasteClassSet(self)

	Ns.pouchCounter = 0
	if (Ns.classFilename ~= "WARRIOR") and (Ns.classFilename ~= "ROGUE") then
		for i=1,23 do
			local itemLink = GetInventoryItemLink("player", i)
			if itemLink then
				if (Ns.classFilename == "PRIEST") or (Ns.classFilename == "DRUID") or (Ns.classFilename == "PALADIN") or (Ns.classFilename == "SHAMAN") then
					local itemName = C_Item.GetItemNameByID(GetInventoryItemLink("player", i))
					if itemName then
						if Ns.classId == 5 then
							if string.sub(itemName, -13) == "Transcendence" then
								Ns.tierPieces = Ns.tierPieces + 1
							end
						elseif Ns.classId == 11 then
							if string.sub(itemName, 1, 9) == "Stormrage" then
								Ns.tierPieces = Ns.tierPieces + 1
							end
							if (string.sub(itemName, 10, 17) == "Haruspex") or
								(string.sub(itemName, -15) == "South Seas Kelp") or
								(string.sub(itemName, 1, 9) == "Wushoolay") then
									Ns.zgPieces = Ns.zgPieces + 1
							end
						elseif Ns.classId == 2 then
							if (string.sub(itemName, 10, 20) == "Freethinker") or
								(string.sub(itemName, 1, 7) == "Gri'lek") or
								(string.sub(itemName, 1, 12) == "Hero's Brand") then
									Ns.zgPieces = Ns.zgPieces + 1
							end
						elseif Ns.classId == 7 then
							if (string.sub(itemName, 1, 5) == "Augur") or
								(string.sub(itemName, 1, 8) == "Unmarred") or
								(string.sub(itemName, 1, 9) == "Wushoolay") then
									Ns.zgPieces = Ns.zgPieces + 1
							end
						end
					end
				end
				if (Ns.classFilename == "HUNTER") then
					local itemName = C_Item.GetItemNameByID(GetInventoryItemLink("player", i))
					if itemName then
						if (string.sub(itemName, 1, 10) == "Ammo Pouch") or
							(string.sub(itemName, 1, 10) == "Small Shot") or
							(string.sub(itemName, -9) == "Ammo Sack") or
							(string.sub(itemName, -6) == "Quiver") then
								Ns.pouchCounter = 10
						elseif (string.sub(itemName, 1, 9) == "Bandolier") or
							(string.sub(itemName, -11) == "Night Watch") then
								Ns.pouchCounter = 11
						elseif (string.sub(itemName, 1, 13) == "Heavy Leather") or
							(string.sub(itemName, 1, 12) == "Heavy Quiver") then
								Ns.pouchCounter = 12
						elseif (string.sub(itemName, 1, 13) == "Thick Leather") or
							(string.sub(itemName, 1, 9) == "Quickdraw") then
								Ns.pouchCounter = 13
						elseif (string.sub(itemName, 1, 8) == "Ribbly's") then
							Ns.pouchCounter = 14
						elseif (string.sub(itemName, 1, 10) == "Gnoll Skin") or
							(string.sub(itemName, 1, 10) == "Harpy Hide") or
							(string.sub(itemName, -6) == "Lamina") or
							(string.sub(itemName, 1, 9) == "Clefthoof") or
							(string.sub(itemName, 1, 9) == "Worg Hide") or
							(string.sub(itemName, 1, 15) == "Smuggler's Ammo") then
								Ns.pouchCounter = 15
						end
					end
				end
			end
		end
	end
end

function Ns.TargetArmor(self)

	Ns.targetArmor = 0
	local NPCguid, NPCname = UnitGUID("target"), UnitName("target")
	if NPCguid ~= nil then
		local NPCtype, _, _, _, _, npc_id, _ = strsplit("-",NPCguid)
		npc_id = tonumber(npc_id)
			if NPCtype == "Creature" then
				if Ns.BossArmor[npc_id] then
					Ns.targetArmor = Ns.BossArmor[npc_id][1]
				end
			end
	end
end

function Ns.druidFormChk()
	if (Ns.classFilename == "DRUID") then
		local index = GetShapeshiftForm()
		if (index == 1) or (index == 3) then
			return true
		else
			return false
		end
	end
end

function Ns.ScanFeralAP()
	Ns.feralAP = 0
	if Ns.classFilename ~= "DRUID" then return end
	local link = GetInventoryItemLink("player", 16)
	if not link then return end
	local stats = GetItemStats(link)
	if stats and stats["ITEM_MOD_FERAL_ATTACK_POWER_SHORT"] then
		Ns.feralAP = stats["ITEM_MOD_FERAL_ATTACK_POWER_SHORT"]
	end
end

function Ns.ShortNumbers(num, places)
    local ret
    local placeValue = ("%%.%df"):format(places or 0)
    if not num then return 0
	elseif num < 1000 then return num
    elseif num < 1000000 then ret = placeValue:format(num / 1000) .. "k"
	elseif num >= 1000000 then ret = placeValue:format(num / 1000000) .. "M"
	else ret = num
    end
    return ret
end

function Ns.DecimalFormat(val, suffix)
	local s = suffix or ""
	if val == 0 then return "%.0f" .. s
	elseif val == 1 then return "%.1f" .. s
	elseif val == 2 then return "%.2f" .. s
	else return "%.3f" .. s end
end

function Ns.DecimalNumber(val, num)
	local numFormat = math.floor(num) or 0
	if val == 0 then return BreakUpLargeNumbers(numFormat)
	elseif val == 1 then return Ns.ShortNumbers(numFormat, 0)
	elseif val == 2 then return Ns.ShortNumbers(numFormat, 1)
	else return Ns.ShortNumbers(numFormat, 2) end
end

-- gradient text color: red (low) to green (max)
function Ns.GradientRedGreen(value, max)
	if not value or not max or max == 0 then return "" end
	local ratio = value / max
	if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
	return Ns:GradientColorCode(ratio)
end

-- gradient text color: green (low) to red (max)
function Ns.GradientGreenRed(value, max)
	if not value or not max or max == 0 then return "" end
	local ratio = value / max
	if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
	return Ns:GradientColorCode(1 - ratio)
end

-- Stats computing
function Ns.StatsCompute()

	-- Init

	Ns.evoc = 0
	Ns.felEnergy = 0
	Ns.innervate = false
	Ns.bowisdom = 0
	Ns.springTotem = 0
	Ns.dsSuc = 0
	Ns.dsImp = 0
	--tideTotem = 0
	Ns.secondWind = 0
	Ns.warchief = 0
	Ns.meleeHaste = 100
	Ns.rangedHaste = 100
	Ns.castHaste = 100
	Ns.aspectViper = 0
	Ns.epiphany = 0
	Ns.arcanePower = 0
	Ns.sancAura = 0
	Ns.combustionCount = 0
	Ns.shadowFormDmg = 0
	Ns.maxmana = 0
	Ns.vengStacks = 0
	Ns.vengBuff = 0
	Ns.totemMana = 0
	Ns.zoneBuff = 0
	Ns.totemWrath = 0
	Ns.innerFocus = 0
	Ns.totemTalent = 0
	Ns.inspiringPresence = 0
	Ns.heroicPresence = 0
	local buffCount = 0
	Ns.arcanePotency = 0
	Ns.avenWrath = 0

if (Ns.classFilename ~= "WARRIOR") and (Ns.classFilename ~= "ROGUE") then

		for i = 1, 40 do

		local _, _, count, _, _, _, _, _, _, spellId = UnitBuff("player",i, "HELPFUL")
		if not spellId  then break end

		if spellId then
			buffCount = i
		end
		buffCount = buffCount

		if spellId == 29166 then
			Ns.innervate = true
		end

		if spellId == 28878 then
			if (Ns.raceFile ~= "Draenei" and Ns.classFilename ~= "MAGE") or (Ns.raceFile ~= "Draenei" and Ns.classFilename ~= "PRIEST") or (Ns.raceFile ~= "Draenei" and Ns.classFilename ~= "SHAMAN") then
				Ns.inspiringPresence = 1
			end
		end

		if spellId == 6562 then
			if (Ns.raceFile ~= "Draenei" and Ns.classFilename ~= "HUNTER") or (Ns.raceFile ~= "Draenei" and Ns.classFilename ~= "WARRIOR") or (Ns.raceFile ~= "Draenei" and Ns.classFilename ~= "PALADIN") then
				Ns.heroicPresence = 1
			end
		end

		if spellId == 32071 or spellId == 32049 or spellId == 33779 or spellId == 33377 or spellId == 33795 then
			Ns.zoneBuff = 0.05
		end

		if spellId == 30708 then
			Ns.totemWrath = 3
		end

		if spellId == 15167 then -- windsor frenzy
			Ns.meleeHaste = (Ns.meleeHaste + 65)
		end

		if spellId == 32182 then
			Ns.rangedHaste = (Ns.rangedHaste + 30)
			Ns.meleeHaste = (Ns.meleeHaste + 30)
			Ns.castHaste = (Ns.castHaste + 30)
		end

		if spellId == 28093 then
			Ns.meleeHaste = (Ns.meleeHaste + 2)
		end

		if spellId == 26635 then
			local health = UnitHealth("player")
			local max_health = UnitHealthMax("player")
			local percenthealth = ((health/max_health) * 100)
			if percenthealth > 40 then
				Ns.rangedHaste = (Ns.rangedHaste + 10)
				Ns.meleeHaste = (Ns.meleeHaste + 10)
				Ns.castHaste = (Ns.castHaste + 10)
			else
				Ns.rangedHaste = (Ns.rangedHaste + 30)
				Ns.meleeHaste = (Ns.meleeHaste + 30)
				Ns.castHaste = (Ns.castHaste + 30)
			end
		end

		-- totems
		if spellId == 5677 then
				Ns.springTotem = 6 + (6 * Ns.totemTalent)

		elseif spellId == 10491 then
				Ns.springtotem = 9 + (9 * Ns.totemTalent)

		elseif spellId == 10493 then
				Ns.springtotem = 13 + (13 * Ns.totemTalent)

		elseif spellId == 10494 then
				Ns.springTotem = 17 + (17 * Ns.totemTalent)

		elseif spellId == 25569 then
			Ns.springTotem = 20 + (20 * Ns.totemTalent)
		 end

		if spellId == 15604 then
			Ns.secondWind = 60
		end

	if (Ns.classFilename == "MAGE") then

			if spellId == 28682 then
				Ns.combustionCount = count
				Ns.combustionCount = Ns.combustionCount * 10
			end

			if spellId == 12051 then
				Ns.maxmana = UnitPowerMax("player", Enum.PowerType.Mana)
				Ns.evoc = ((Ns.maxmana * 0.6) / 8) * 2
			end

			if spellId == 12042 then
				Ns.arcanePower = 0.3
			end

			if spellId == 12472 then
				Ns.castHaste = Ns.castHaste + 20
			end
	end

	if (Ns.classFilename == "WARLOCK") then
			local maxpower = UnitPowerMax("player" , Enum.PowerType.Mana)
			if spellId == 18792 then
				Ns.felEnergy = ((maxpower * 0.03) / 2)
			end

			if spellId == 18791 then
				Ns.dsSuc = 0.15
			elseif spellId == 18789 then
				Ns.dsImp = 0.15
			end

			-- if debuffId == 15258 then
				-- shadowVuln = dcount
				-- shadowVuln = shadowVuln * 2
			-- end

		end

	if (Ns.classFilename == "DRUID") then
		if Ns.druidFormChk() then
			if spellId == 13494 then
				Ns.meleeHaste = (Ns.meleeHaste + 50)
			end
		end
	end

	if (Ns.classFilename == "HUNTER") then
			if spellId == 3045 then
				Ns.rangedHaste = (Ns.rangedHaste + 40)
			end

			if spellId == 6150 then
				Ns.rangedHaste = (Ns.rangedHaste + 30)
			end

			if spellId == 34074 then
				local _, currIntellect, _, _ = UnitStat("player", 4);
				local playerMana = UnitPower("player", Enum.PowerType.Mana)
				local playerMaxMana = UnitPowerMax("player", Enum.PowerType.Mana)
				playerMana = (playerMana / playerMaxMana) * 100

				if playerMana >= 90 then
					Ns.aspectViper = ((currIntellect * 0.11) + (Ns.playerLevel * 0.35)) * 0.4
				elseif playerMana >= 70 and playerMana < 90 then
					Ns.aspectViper = ((currIntellect * 0.24) + (Ns.playerLevel * 0.35)) * 0.4
				elseif playerMana >= 50 and playerMana < 70 then
					Ns.aspectViper = ((currIntellect * 0.37) + (Ns.playerLevel * 0.35)) * 0.4
				elseif playerMana > 20 and playerMana < 50 then
					Ns.aspectViper = ((currIntellect * 0.50) + (Ns.playerLevel * 0.35)) * 0.4
				elseif playerMana <= 20 then
					Ns.aspectViper = ((currIntellect * 0.55) + (Ns.playerLevel * 0.35)) * 0.4
				end
			end
	end

	if (Ns.classFilename == "PALADIN") then
		if spellId == 20050 then
			Ns.vengStacks = count
			if Ns.vengeance == 5 and Ns.vengStacks > 0 then
				Ns.vengBuff = (Ns.vengStacks * Ns.vengeance) / 100
			elseif Ns.vengeance == 4 and Ns.vengStacks > 0 then
				Ns.vengBuff = (Ns.vengStacks * Ns.vengeance) / 100
			elseif Ns.vengeance == 3 and Ns.vengStacks > 0 then
				Ns.vengBuff = (Ns.vengStacks * Ns.vengeance) / 100
			elseif Ns.vengeance == 2 and Ns.vengStacks > 0 then
				Ns.vengBuff = (Ns.vengStacks * Ns.vengeance) / 100
			elseif Ns.vengeance == 1 and Ns.vengStacks > 0 then
			Ns.	vengBuff = (Ns.vengStacks * Ns.vengeance) / 100
			end
		end

		if spellId == 23733 then
			Ns.meleeHaste = (Ns.meleeHaste + 25)
			Ns.castHaste = (Ns.castHaste + 33)
		end
		if spellId == 20218 then
			Ns.sancAura = 0.1
		end
		if spellId == 31884 then
			Ns.avenWrath = 0.3
		end
	end

	if (Ns.classFilename == "PRIEST") then
		if spellId == 28804 then
			Ns.epiphany = 24
		end
		if spellId == 20218 then
			Ns.sancAura = 0.1
		end
		if spellId == 15473 then
			Ns.shadowFormDmg = 0.15
		end
		if spellId == 14751 then
			Ns.innerFocus = 25
		end
	end

	if (Ns.classFilename == "SHAMAN") then
		if spellId == 16166 then
			Ns.eleMastery = 100
		else
			Ns.eleMastery = 0
		end
	end

	end
end

if (Ns.classFilename == "WARRIOR") then
	for i = 1, 40 do
		local _, _, _, _, _, _, _, _, _, spellId = UnitBuff("player",i, "HELPFUL")
		if not spellId then break end

		if spellId then
			buffCount = i
		end
		buffCount = buffCount + 1

		if spellId == 12966 then
			Ns.meleeHaste = (Ns.meleeHaste + 5)
		elseif spellId == 12967 then
			Ns.meleeHaste = (Ns.meleeHaste + 10)
		elseif spellId == 12968 then
			Ns.meleeHaste = (Ns.meleeHaste + 15)
		elseif spellId == 12969 then
			Ns.meleeHaste = (Ns.meleeHaste + 20)
		elseif spellId == 12970 then
			Ns.meleeHaste = (Ns.meleeHaste + 25)
		end

		if spellId == 355366 then
			if Ns.playerLevel < 63 then
				Ns.meleeHaste = (Ns.meleeHaste + 15)
			end
		end

		if spellId == 32182 then
			Ns.rangedHaste = (Ns.rangedHaste + 30)
			Ns.meleeHaste = (Ns.meleeHaste + 30)
		end

		if spellId == 28093 then
			Ns.meleeHaste = (Ns.meleeHaste + 2)
		end

		if spellId == 26635 then
			local health = UnitHealth("player")
			local max_health = UnitHealthMax("player")
			local percenthealth = ((health/max_health) * 100)
			if percenthealth > 40 then
				Ns.rangedHaste = (Ns.rangedHaste + 10)
				Ns.meleeHaste = (Ns.meleeHaste + 10)
				Ns.castHaste = (Ns.castHaste + 10)
			else
				Ns.rangedHaste = (Ns.rangedHaste + 30)
				Ns.meleeHaste = (Ns.meleeHaste + 30)
				Ns.castHaste = (Ns.castHaste + 30)
			end
		end
	end

elseif (Ns.classFilename == "ROGUE") then
for i = 1, 40 do
	local _, _, _, _, _, _, _, _, _, spellId = UnitBuff("player",i, "HELPFUL")
	if not spellId then break end

		if spellId then
			buffCount = i
		end
		buffCount = buffCount
		if spellId == 5171 then
			Ns.meleeHaste = (Ns.meleeHaste + 20)
		elseif spellId == 6774 then
			Ns.meleeHaste = (Ns.meleeHaste + 30)
		end

		if spellId == 13877 then
			Ns.meleeHaste = (Ns.meleeHaste + 20)
		end

		if spellId == 355366 then
			if Ns.playerLevel < 63 then
				Ns.meleeHaste = (Ns.meleeHaste + 15)
			end
		end

		if spellId == 15167 then
			Ns.meleeHaste = (Ns.meleeHaste + 65)
		end

		if spellId == 32182 then
			Ns.rangedHaste = (Ns.rangedHaste + 30)
			Ns.meleeHaste = (Ns.meleeHaste + 30)
		end

		if spellId == 28093 then
			Ns.meleeHaste = (Ns.meleeHaste + 2)
		end

		if spellId == 26635 then
			local health = UnitHealth("player")
			local max_health = UnitHealthMax("player")
			local percenthealth = ((health/max_health) * 100)
			if percenthealth > 40 then
				Ns.rangedHaste = (Ns.rangedHaste + 10)
				Ns.meleeHaste = (Ns.meleeHaste + 10)
				Ns.castHaste = (Ns.castHaste + 10)
			else
				Ns.rangedHaste = (Ns.rangedHaste + 30)
				Ns.meleeHaste = (Ns.meleeHaste + 30)
				Ns.castHaste = (Ns.castHaste + 30)
			end
		end

	end
end

	Ns.hasteHead = 0
	Ns.hasteLegs = 0
	Ns.hasteHands = 0

	local link = GetInventoryItemLink("player", 10)
	if link then
		local itemId, enchantId = link:match("item:(%d+):(%d+)")
		if enchantId then
			enchantId = tonumber(enchantId)
			if enchantId == 931 then
				Ns.hasteHands = Ns.hasteHands + 1
			end
		end
	end

	local slotId = GetInventorySlotInfo("HeadSlot")
	local link = GetInventoryItemLink("player", slotId)
	if link then
		local itemId, enchantId = link:match("item:(%d+):(%d+)")
		if enchantId then
			enchantId = tonumber(enchantId)
			if enchantId == 2543 then
				Ns.hasteHands = Ns.hasteHands + 1
			end
		end
	end

	local link = GetInventoryItemLink("player", 7)
	if link then
		local itemId, enchantId = link:match("item:(%d+):(%d+)")
		if enchantId then
			enchantId = tonumber(enchantId)
			if enchantId == 2543 then
				Ns.hasteHands = Ns.hasteHands + 1
			end
		end
	end

	Ns.PouchHasteClassSet()
	Ns.ScanFeralAP()


	-- defense
	Ns.baseDefense, Ns.gearDefense = UnitDefense("player")
	Ns.defenseBonus = GetCombatRatingBonus(CR_DEFENSE_SKILL)
	Ns.defenseRating = GetCombatRating(CR_DEFENSE_SKILL)
	Ns.totalDefense = 0
	local numberLines = GetNumSkillLines()
	local defGearBonus = 0


	if Ns.defenseBonus == nil then Ns.defenseBonus = 0 end
	if Ns.defenseRating == nil then Ns.defenseRating = 0 end

	for i = 1, numberLines do
		local skillName, header, _, _, _, skillModifier  = GetSkillLineInfo(i)

		if skillName == nil then break end
		if (not header) and (skillName == DEFENSE) then defGearBonus = skillModifier break end
	end
	Ns.totalDefense = Ns.defenseBonus + defGearBonus + Ns.baseDefense

end

--------------------------------------
--		Global OnEvent function		--
--------------------------------------
function Ns.OnEventFunc(event, ...)

if event == "CHARACTER_POINTS_CHANGED" then
	Ns.talentScan()

elseif event == "PLAYER_LEVEL_UP" then
	Ns.playerLevel = UnitLevel("player")

elseif event == "PLAYER_TARGET_CHANGED" then
	local exists = UnitExists("target")
	local hostile = UnitCanAttack("player", "target")

	if hostile or not exists then Ns.SinLive() end

	Ns.TargetArmor()

elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then

local _, subevent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()
local spellID, amount, critical, missType, healCrit, spellCritical
local playerGUID = UnitGUID("player")
local storedGUID = UnitGUID("target")
-- local storedGUID

Ns.manaTide = 0

	if (subevent == "SPELL_AURA_APPLIED" or subevent == "SPELL_AURA_REFRESH") and (Ns.huntersMarkRanks[spellId]) then

		Ns.savedHM = spellId
		Ns.hmIncrements = 0
		--storedGUID = UnitGUID("target")

	elseif subevent == "RANGE_DAMAGE" or (subevent == "SPELL_DAMAGE" and Ns.hunterSpells[spellName]) then

		if (destGUID == storedGUID) then


			if Ns.savedHM == 1130 then
				Ns.hmInc = 2
				if Ns.hmIncrements <= 58 then
					Ns.hmIncrements = Ns.hmIncrements + Ns.hmInc
				end
			elseif Ns.savedHM == 14323 then
				Ns.hmInc = 5
				if Ns.hmIncrements <= 130 then
					Ns.hmIncrements = Ns.hmIncrements + Ns.hmInc
				end
			elseif Ns.savedHM == 14324 then
				Ns.hmInc = 8
				if Ns.hmIncrements <= 217 then
					Ns.hmIncrements = Ns.hmIncrements + Ns.hmInc
				end
			elseif Ns.savedHM == 14325 then
				Ns.hmInc = 11
				if Ns.hmIncrements <= 319 then
					Ns.hmIncrements = Ns.hmIncrements + Ns.hmInc
				end
			end
		end

    elseif subevent == "SPELL_AURA_REMOVED" and Ns.huntersMarkRanks[spellId] and (destGUID == storedGUID) then
		Ns.hmIncrements = 0
		Ns.huntersMark = 0
		Ns.hmInc = 0
    end

	if (Ns.manaTideCheck[spellId]) and (destGUID == Ns.playerGUID) then
		local TideMana = UnitPowerMax("player", Enum.PowerType.Mana)
		Ns.manaTide = ((TideMana * 0.06) / 3) * 2
		Ns.manaTide = Ns.manaTide
	end

	if subevent == "SWING_DAMAGE" then
		if sourceGUID == playerGUID then
			amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
			hitTimes = hitTimes + 1
			if critical then critTimes = critTimes + 1 end
			Ns.meleeCrit = ((critTimes + spellcritTimes) / (hitTimes + spellhitTimes) * 100)
			Ns.totalParryDodge = (parrydodgeCount / hitTimes) * 100
			Ns.meleeMissTracker = ((swingMissed + spMissCount) / (hitTimes + spellhitTimes)) * 100
		end
		if destGUID == playerGUID then
			amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
			selfhitTimes = selfhitTimes + 1
			if critical then critCount = critCount + 1 end
			Ns.critReceived = (critCount/selfhitTimes) * 100
			Ns.totalDodge = (dodgeCount/selfhitTimes) * 100
			Ns.totalParry = (parryCount/selfhitTimes) * 100
			Ns.totalBlock = (blockCount/selfhitTimes) * 100
		end

	elseif subevent == "SWING_MISSED" then
		if sourceGUID == playerGUID then
			missType = select(12, CombatLogGetCurrentEventInfo())
			hitTimes = hitTimes + 1
			Ns.meleeCrit = ((critTimes + spellcritTimes) / (hitTimes + spellhitTimes) * 100)
			swingMissed = swingMissed + 1
			Ns.meleeMissTracker = ((swingMissed + spMissCount) / (hitTimes + spellhitTimes)) * 100
			if missType == "PARRY" or missType == "DODGE" then
				parrydodgeCount = parrydodgeCount + 1
			end
		end
		if destGUID == playerGUID then
			missType = select(12, CombatLogGetCurrentEventInfo())
			selfhitTimes = selfhitTimes + 1
			if missType == "DODGE" then dodgeCount = dodgeCount + 1 end
			if missType == "PARRY" then parryCount = parryCount + 1 end
			if missType == "BLOCK" then blockCount = blockCount + 1 end
		end

	elseif subevent == "SPELL_DAMAGE" or subevent == "SPELL_HEAL" then
		if sourceGUID == playerGUID then
			_, _, _, _, _, _, healCrit, _, _, spellCritical = select(12, CombatLogGetCurrentEventInfo())
			spellhitTimes = spellhitTimes + 1
		if spellCritical or healCrit then
			spellCritical = false
			healCrit = false
			spellcritTimes = spellcritTimes + 1
		end
			Ns.spellCrit = ((spellcritTimes / spellhitTimes) * 100)
			Ns.spellMissTracker = ((spMissCount / spellhitTimes) * 100)
			Ns.rangedCrit = ((rangedcritTimes + spellcritTimes) / (rangedhitTimes + spellhitTimes)) * 100
			Ns.rangedMissTracker = ((rMissCount + spMissCount) / (rangedhitTimes + spellhitTimes)) * 100
			Ns.meleeMissTracker = ((swingMissed + spMissCount) / (hitTimes + spellhitTimes)) * 100
		end

	elseif subevent == "SPELL_MISSED" and sourceGUID == playerGUID then
		spellhitTimes = spellhitTimes + 1
		spMissCount = spMissCount + 1
		Ns.rangedCrit = ((rangedcritTimes + spellcritTimes) / (rangedhitTimes + spellhitTimes)) * 100
		Ns.meleeMissTracker = ((swingMissed + spMissCount) / (hitTimes + spellhitTimes)) * 100
		Ns.spellMissTracker = ((spMissCount / spellhitTimes) * 100)
		Ns.rangedMissTracker = ((rMissCount + spMissCount) / (rangedhitTimes + spellhitTimes)) * 100

	elseif subevent == "RANGE_DAMAGE" and sourceGUID == playerGUID then
		_, _, _, _, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
		rangedhitTimes = rangedhitTimes + 1
		if critical then rangedcritTimes = rangedcritTimes + 1 end
		Ns.rangedCrit = ((rangedcritTimes + spellcritTimes) / (rangedhitTimes + spellhitTimes)) * 100
		Ns.rangedMissTracker = ((rMissCount + spMissCount) / (rangedhitTimes + spellhitTimes)) * 100

	elseif subevent == "RANGE_MISSED" and sourceGUID == playerGUID then
		rangedhitTimes = rangedhitTimes + 1
		rMissCount = rMissCount + 1
		Ns.rangedCrit = ((rangedcritTimes + spellcritTimes) / (rangedhitTimes + spellhitTimes)) * 100
		Ns.rangedMissTracker = ((rMissCount + spMissCount) / (rangedhitTimes + spellhitTimes)) * 100
	end
	-----
	elseif event == "PLAYER_REGEN_DISABLED" then
		hitTimes, selfhitTimes, critTimes, spellhitTimes, spellcritTimes, critCount, rMissCount, swingMissed = 1, 1, 0, 0, 0, 0, 0, 0
		swingParryDodge, parrydodgeCount, dodgeCount, parryCount, blockCount, spMissCount, rangedhitTimes, rangedcritTimes = 0, 0, 0, 0, 0, 0, 0, 0
		Ns.meleeCrit, Ns.spellCrit, Ns.meleeMissTracker, Ns.totalParryDodge, Ns.totalDodge = 0, 0, 0, 0, 0
		Ns.spellMissTracker, Ns.rangedMissTracker, Ns.totalParry, Ns.totalBlock, Ns.critReceived = 0, 0, 0, 0, 0	

else -- Other Events


	local unit = ...
	if unit == "target" then
		Ns.SinLive()
	return
	end

	-- Ns.baseDefense = 0
	-- local DefGearIndex = 0
	-- Ns.defenseRating = 0
	-- local DefGear = GetNumSkillLines()
	-- local DefHeader = nil

	-- for i = 1, DefGear do
	-- 	local DefName = select(1, GetSkillLineInfo(i))
	-- 	local headerCheck = select(2, GetSkillLineInfo(i))

	-- 	if headerCheck ~= nil and headerCheck then
	-- 		DefHeader = DefName;
	-- 	else
	-- 		if (DefHeader == Ns.headerLoc or (not headerCheck)) and (DefName == Ns.defenseLoc) then
	-- 			DefGearIndex = i
	-- 			break
	-- 		end
	-- 	end
	-- end
	-- if (DefGearIndex > 0) then
	-- 	Ns.baseDefense = UnitDefense("player")
	-- end

	-- Ns.defenseRating = GetCombatRatingBonus(CR_DEFENSE_SKILL) + Ns.baseDefense
	-- Ns.defenseRating = Ns.defenseRating


	-----

	local unit = ...
	if unit == "target" then Ns.SinLive() return end

	Ns.StatsCompute()

end -- end events
end -- end function

--------------------------------------
--		Timer Format Utility		--
--------------------------------------
function Ns.FormatTimerDisplay(seconds, fmt)
	local hours = floor(seconds / 3600)
	local minutes = floor((seconds % 3600) / 60)
	local secs = floor(seconds % 60)
	fmt = tonumber(fmt) or 1
	if fmt == 2 then
		if hours > 0 then return string.format("%02d:%02d:%02d", hours, minutes, secs)
		else return string.format("%02d:%02d", minutes, secs) end
	elseif fmt == 3 then
		if hours > 0 then return string.format("%dh %dm %02ds", hours, minutes, secs)
		else return string.format("%dm %02ds", minutes, secs) end
	elseif fmt == 4 then
		if hours > 0 then return string.format("%dh%02dm%02ds", hours, minutes, secs)
		else return string.format("%dm%02ds", minutes, secs) end
	end
	if hours > 0 then return string.format("%d:%02d:%02d", hours, minutes, secs)
	else return string.format("%d:%02d", minutes, secs) end
end

--------------------------------------
--		Instance Timer				--
--------------------------------------
Ns.InstanceTimerData = { startTime = 0, running = false, completed = false, lastDisplay = "0:00", finalTime = nil, sentToChat = false, initialized = false }

function Ns.InitInstanceTimer()
	if Ns.InstanceTimerData.initialized then return end
	Ns.InstanceTimerData.initialized = true
	local d = Ns.InstanceTimerData
	local f = CreateFrame("Frame")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_ENTERING_WORLD" then
			local inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == "party" or instanceType == "raid") then
				if not d.running then
					d.startTime = GetTime()
					d.running = true
					d.completed = false
					d.sentToChat = false
					d.finalTime = nil
				end
			else
				if d.running and not d.completed then
					d.running = false
					d.completed = true
					d.finalTime = GetTime() - d.startTime
				end
			end
		end
	end)
end
