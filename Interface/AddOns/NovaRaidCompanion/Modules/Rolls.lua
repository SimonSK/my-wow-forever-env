------------------------------
---NovaRaidCompanion Talents--
------------------------------
local addonName, NRC = ...;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaRaidCompanion");
local GetItemInfo = GetItemInfo or C_Item.GetItemInfo;
local issecretvalue = issecretvalue;
local lastChatMsg;
local lastChatMsgWho;
local lastChatMsgEvent;
local lastChatClass;

local function isStillInRecordedRaid()
	--Keep recording rolls if loot is done outside the raid instance but still in the same raid group;
	if (NRC.lastRaidID and NRC.db.global.instances[1] and NRC.lastRaidID == NRC.db.global.instances[1].raidID) then
		return true;
	end
end

local function addRoll(who, msg, roll, min, max)
	local raid;
	if (NRC.raid) then
		raid = NRC.raid;
	elseif isStillInRecordedRaid() then
		raid = NRC.db.global.instances[1];
	end
	if (raid) then
		if (not raid.rolls) then
			raid.rolls = {};
		end
		local name, realm = strsplit("-", who, 2);
		if (realm and (realm == GetNormalizedRealmName() or realm == NRC.realm)) then
			--Strip realm name if it's our realm.
			who = name;
		end
		if (lastChatMsg) then
			local t = {
				chat = lastChatMsg,
				who = lastChatMsgWho,
				event = lastChatMsgEvent,
				time = GetServerTime(),
				class = lastChatClass,
			};
			tinsert(raid.rolls, t);
			lastChatMsg = nil;
		end
		local t = {
			who = who,
			msg = msg,
			--roll = roll,
			--min = min,
			--max = max,
			time = GetServerTime(),
		};
		tinsert(raid.rolls, t);
	end
	--print("adding roll", who, roll, min, max);
end

--Gargul's pattern matching func, copied this with permission of the author.
local function createPattern(pattern, maximize)
    pattern = string.gsub(pattern, "[%(%)%-%+%[%]]", "%%%1");
    pattern = string.gsub(pattern, "%%c", "%+");
    if (not maximize) then
        pattern = string.gsub(pattern, "%%s", "(.-)");
    else
        pattern = string.gsub(pattern, "%%s", "(.+)");
    end
    pattern = string.gsub(pattern, "%%d", "%(%%d-%)");
    if (not maximize) then
        pattern = string.gsub(pattern, "%%%d%$s", "(.-)");
    else
        pattern = string.gsub(pattern, "%%%d%$s", "(.+)");
    end
    return string.gsub(pattern, "%%%d$d", "%(%%d-%)");
end

local function parseChatMsg(msg, who, event, class)
	if (not issecretvalue or not issecretvalue(msg)) then
		if (string.match(msg, "|Hitem:")) then
			local itemID = string.match(msg, "|Hitem:(%d+):");
			if (itemID) then
				--0 	Poor 	Poor 	ITEM_QUALITY0_DESC
				--1 	Common 	Common 	ITEM_QUALITY1_DESC
				--2 	Uncommon 	Uncommon 	ITEM_QUALITY2_DESC
				--3 	Rare 	Rare 	ITEM_QUALITY3_DESC
				--4 	Epic 	Epic 	ITEM_QUALITY4_DESC
				--5 	Legendary 	Legendary 	ITEM_QUALITY5_DESC
				--6 	Artifact 	Artifact 	ITEM_QUALITY6_DESC
				--7 	Heirloom 	Heirloom 	ITEM_QUALITY7_DESC
				--8 	WoWToken 	WoW Token 	ITEM_QUALITY8_DESC
				itemID = tonumber(itemID);
				local _, _, itemRarity = GetItemInfo(itemID);
				if (itemRarity and itemRarity > 1) then
					local name, realm = strsplit("-", who, 2);
					if (realm and (realm == GetNormalizedRealmName() or realm == NRC.realm)) then
						--Strip realm name if it's our realm.
						who = name;
					end
					lastChatMsg = msg;
					lastChatMsgWho = who;
					lastChatMsgEvent = event;
					lastChatClass = class;
				end
			end
		end
	end
end

local f = CreateFrame("Frame");
f:RegisterEvent("CHAT_MSG_SYSTEM");
f:RegisterEvent("CHAT_MSG_PARTY");
f:RegisterEvent("CHAT_MSG_PARTY_LEADER");
f:RegisterEvent("CHAT_MSG_RAID");
f:RegisterEvent("CHAT_MSG_RAID_WARNING");
f:RegisterEvent("CHAT_MSG_RAID_LEADER");
f:SetScript("OnEvent", function(self, event, ...)
	if (event == "CHAT_MSG_SYSTEM") then
		local msg = ...;
		if (not issecretvalue or not issecretvalue(msg)) then
			local pattern = createPattern(RANDOM_ROLL_RESULT)
			if (string.match(msg, pattern)) then --%s rolls %d (%d-%d)
				local who, roll, min, max = string.match(msg, pattern);
				if (who) then
					addRoll(who, msg, roll, min, max);
				end
			end
		end
	elseif (event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_WARNING"
			or event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_PARTY_LEADER") then
		if (NRC.raid or isStillInRecordedRaid()) then
			local msg, who, _, _, _, _, _, _, _, _, _, guid = ...;
			if (not issecretvalue or not issecretvalue(msg)) then
				local _, class = GetPlayerInfoByGUID(guid);
				parseChatMsg(msg, who, event, class);
			end
		end
	end
end)