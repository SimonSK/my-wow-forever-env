local _, Ns = ...

----------------------
--		SinLive		--
----------------------
function Ns.SinLive(self)

	Ns.misery = 0
	Ns.huntersMark = 0
	Ns.scorpidSting = 0
	Ns.insectSwarm = 0
	Ns.shadowVuln = 0
	Ns.shadowDmg = 0
	Ns.curseElements = 0
	Ns.bloodFrenzy = 0
	Ns.judgeCrusader = 0
	Ns.crusader = false
	Ns.stormStrike = 0
	Ns.hemoDmg = 0
	Ns.impSorch = 0
	Ns.wintersChill = 0
	Ns.debuffCount = 0
	Ns.sunderArmor = 0
	Ns.curseOfReck = 0
	Ns.exposeArmor = 0
	Ns.faerieFire = 0
	Ns.shatterArmor = 0
	
	for i = 1, 40 do
	local _, _, dcount, _, _, _, _, _, _, debuffId = UnitDebuff("target", i)
		if not debuffId then break end
		
		Ns.targetGUID = UnitGUID("target") 
		
		if debuffId then
			Ns.debuffCount = i
		end
		
		Ns.debuffCount = Ns.debuffCount
		
		if Ns.ArmorDebuffs.ExposeArmor[debuffId] then
			Ns.exposeArmor = Ns.ArmorDebuffs.ExposeArmor[debuffId][1]
		end
		
		if Ns.ArmorDebuffs.SunderArmor[debuffId] then
			Ns.sunderArmor = dcount
			Ns.sunderArmor = (Ns.sunderArmor * Ns.ArmorDebuffs.SunderArmor[debuffId][1])
		end
		
		if Ns.ArmorDebuffs.FaerieFire[debuffId] then
			Ns.faerieFire = Ns.ArmorDebuffs.FaerieFire[debuffId][1]
		end
		
		if Ns.ArmorDebuffs.CurseOfReck[debuffId] then
			Ns.curseOfReck = Ns.ArmorDebuffs.CurseOfReck[debuffId][1]
		end
		
		if debuffId == 16928 then
			Ns.shatterArmor = dcount
			Ns.shatterArmor = Ns.shatterArmor * 200
		end		
		
		if debuffId == 1130 then
			Ns.huntersMark = 20
		elseif debuffId == 14323 then
			Ns.huntersMark = 45
		elseif debuffId == 14324 then
			Ns.huntersMark = 75
		elseif debuffId == 14325 then
			Ns.huntersMark = 110
		end
		
		if debuffId == 3043 then
			Ns.scorpidSting = 5
		end
		
		if debuffId == 5570 or 
		debuffId == 24974 or 
		debuffId == 24975 or 
		debuffId == 24976 or 
		debuffId == 24977 then
			Ns.insectSwarm = 2
		end
		
		if debuffId == 33196 then
			Ns.misery = 0.01
		elseif debuffId == 33197 then
			Ns.misery = 0.02
		elseif debuffId == 33198 then
			Ns.misery = 0.03
		elseif debuffId == 33199 then
			Ns.misery = 0.04		
		elseif debuffId == 33200 then
			Ns.misery = 0.05
		end
		
		if debuffId == 15258 then
			Ns.shadowVuln = dcount
			Ns.shadowVuln = (Ns.shadowVuln * 2) / 100
		end	
		
		if debuffId == 17794 then
			Ns.shadowDmg = 0.04
		elseif debuffId == 17798 then
			Ns.shadowDmg = 0.08
		elseif debuffId == 17797 then
			Ns.shadowDmg = 0.12
		elseif debuffId == 17800 then
			Ns.shadowDmg = 0.2
		end
		
		if debuffId == 1490 then
			Ns.curseElements = 0.06
		elseif debuffId == 11721 then
			Ns.curseElements = 0.08
		elseif debuffId == 11722 or debuffId == 27228 then 
			Ns.curseElements = 0.10
		end
		
		if debuffId == 30069 then
			Ns.bloodFrenzy = 0.02
		elseif debuffId == 30070 then
			Ns.bloodFrenzy = 0.04
		end
		
		if debuffId == 27159 then
			Ns.judgeCrusader = 219
			if Ns.crusaderTalent > 0 then
				Ns.crusader = true
			end
		end
		
		if debuffId == 17364 then
			Ns.stormStrike = 0.2
		end
		
		if debuffId == 16511 then
			Ns.hemoDmg = 13
		elseif debuffId == 17347 then
			Ns.hemoDmg = 21
		elseif debuffId == 17348 then
			Ns.hemoDmg = 29
		elseif debuffId == 26864 then
			Ns.hemoDmg = 42
		end
		
		if debuffId == 22959 then
			if dcount == 1 then
				Ns.impSorch = 0.03
			elseif dcount == 2 then
				Ns.impSorch = 0.06
			elseif dcount == 3 then
				Ns.impSorch = 0.09
			elseif dcount == 4 then
				Ns.impSorch = 0.12
			elseif dcount == 5 then
				Ns.impSorch = 0.15
			end
		end
		
		if debuffId == 12579 then
			if dcount == 1 then
				Ns.wintersChill = 2
			elseif dcount == 2 then
				Ns.wintersChill = 4
			elseif dcount == 3 then
				Ns.wintersChill = 6
			elseif dcount == 4 then
				Ns.wintersChill = 8
			elseif dcount == 5 then
				Ns.wintersChill = 10
			end
		end
	end
end