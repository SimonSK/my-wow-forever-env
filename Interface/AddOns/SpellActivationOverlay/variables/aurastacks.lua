local AddonName,SAO=...
local Module="aurastacks"
local canaccessvalue=canaccessvalue
local InCombatLockdown=InCombatLockdown
SAO.AURASTACKS={
LEGACY=C_UnitAuras==nil,
MODERN=C_UnitAuras~=nil,
}
local HASH_AURA_ABSENT=1
local HASH_AURA_ANY=2
local HASH_AURA_ZERO=HASH_AURA_ANY
local HASH_AURA_MAX=HASH_AURA_ZERO + 10
local HASH_AURA_MASK=0xF
local bucketsByAuraInstanceID={}
local secretBuckets={}
local secretlessBuckets={}
SAO.Variable:register({
order=1,
core="AuraStacks",
trigger={
flag=SAO.TRIGGER_AURA,
name="aura",
},
hash={
mask=HASH_AURA_MASK,
key="aura_stacks",
setterFunc=function(self,stacks,bucket)
if stacks==nil then
self:setMaskedHash(HASH_AURA_ABSENT,HASH_AURA_MASK)
elseif type(stacks)~='number' or stacks < 0 then
SAO:Warn(Module, "Invalid stack count "..tostring(stacks))
elseif bucket and bucket.stackAgnostic then
self:setMaskedHash(HASH_AURA_ANY,HASH_AURA_MASK)
elseif stacks > 10 then
SAO:Debug(Module, "Stack overflow ("..stacks..") truncated to 10")
self:setMaskedHash(HASH_AURA_MAX,HASH_AURA_MASK)
else
self:setMaskedHash(HASH_AURA_ZERO + stacks,HASH_AURA_MASK)
end
end,
getterFunc=function(self)
local maskedHash=self:getMaskedHash(HASH_AURA_MASK)
if maskedHash==nil then return nil; end
if maskedHash==HASH_AURA_ABSENT then
return nil
end
return maskedHash - HASH_AURA_ZERO
end,
toAnyFunc=function(self)
return bit.band(self.hash,bit.bnot(HASH_AURA_MASK)) + HASH_AURA_ANY
end,
toValue=function(hash)
local auraStacks=hash:getAuraStacks()
return (auraStacks==nil) and "missing" or (auraStacks==0 and "any" or tostring(auraStacks))
end,
fromValue=function(hash,value)
if value=="missing" then
hash:setAuraStacks(nil)
return true
elseif value=="any" then
hash:setAuraStacks(0)
return true
elseif tostring(tonumber(value))==value then
hash:setAuraStacks(tonumber(value))
return true
else
return nil
end
end,
getHumanReadableKeyValue=function(hash)
local auraStacks=hash:getAuraStacks()
if auraStacks and auraStacks > 0 then
return SAO:NbStacks(auraStacks)
elseif auraStacks==nil then
return ACTION_SPELL_AURA_REMOVED_DEBUFF
else
return nil
end
end,
optionIndexer=function(hash)
return hash:getAuraStacks() or -1
end,
},
bucket={
impossibleValue=-1,
fetchAndSet=function(bucket)
if bucket.auraHasSecretRestrictions and InCombatLockdown()then
return
end
local auraStacks,auraInstanceID=SAO:GetPlayerAuraStacksBySpellID(bucket.spellID)
if auraStacks~=nil then
if bucket.stackAgnostic then
bucket:setAuraStacks(0)
else
bucket:setAuraStacks(auraStacks)
end
else
bucket:setAuraStacks(nil)
end
if SAO.AURASTACKS.MODERN then
bucket.lastKnownAuraStacks=auraStacks
if bucket.auraInstanceID~=auraInstanceID then
if bucket.auraInstanceID~=nil then
bucketsByAuraInstanceID[bucket.auraInstanceID]=nil
end
bucket.auraInstanceID=auraInstanceID
if auraInstanceID~=nil then
bucketsByAuraInstanceID[auraInstanceID]=bucket
end
end
end
end,
},
event={
isRequired=true,
names=SAO.AURASTACKS.MODERN and {"UNIT_AURA", "PLAYER_REGEN_ENABLED"} or {"COMBAT_LOG_EVENT_UNFILTERED"},
COMBAT_LOG_EVENT_UNFILTERED=SAO.AURASTACKS.LEGACY and function(...)
local _,event,_,_,_,_,_,destGUID=CombatLogGetCurrentEventInfo()
if ((event:sub(0,11)=="SPELL_AURA_") and (destGUID==UnitGUID("player")))then
local spellID,spellName=select(12,CombatLogGetCurrentEventInfo())
local auraApplied=event:sub(0,18)=="SPELL_AURA_APPLIED"; -- includes "SPELL_AURA_APPLIED" and "SPELL_AURA_APPLIED_DOSE"
local auraRemovedLast=event=="SPELL_AURA_REMOVED"
local auraRemovedDose=event=="SPELL_AURA_REMOVED_DOSE"
local auraRefresh=event=="SPELL_AURA_REFRESH"
if not auraApplied and not auraRemovedLast and not auraRemovedDose and not auraRefresh then
return
end
local bucket
bucket,spellID=SAO:GetBucketBySpellIDOrSpellName(spellID,spellName)
if not bucket then
return
end
if not bucket.trigger:reactsWith(SAO.TRIGGER_AURA)then
return
end
if (auraRefresh)then
bucket:refresh()
return
end
if (auraRemovedLast)then
bucket:setAuraStacks(nil); -- nil means "not currently holding any stacks"
return
end
local stacks=0
if not bucket.stackAgnostic then
if event~="SPELL_AURA_REMOVED" then
stacks=SAO:GetPlayerAuraStacksBySpellID(spellID) or 0
end
end
bucket:setAuraStacks(stacks)
end
end or nil,
UNIT_AURA=SAO.AURASTACKS.MODERN and function(unitTarget,updateInfo)
if unitTarget~="player" and (not canaccessvalue(UnitIsUnit(unitTarget, "player")) or not UnitIsUnit(unitTarget, "player"))then
return
end
if not canaccessvalue(updateInfo.isFullUpdate) or
not canaccessvalue(updateInfo.updatedAuraInstanceIDs) or
not canaccessvalue(updateInfo.removedAuraInstanceIDs) or
not canaccessvalue(updateInfo.addedAuras)
then
for _,bucket in ipairs(secretlessBuckets)do
SAO:Debug(Module, "Checking buckets manually for secretless aura",bucket.name)
bucket.trigger:manualCheck(SAO.TRIGGER_AURA)
end
if SAO.IsForever() or SAO.IsRetail()then
return
else
SAO:Warn(Module, "Dealing with secret aura information in a flavor which is not supposed to have them:",SAO.GetFlavorName())
end
end
if canaccessvalue(updateInfo.isFullUpdate) and updateInfo.isFullUpdate then
SAO:Debug(Module, "Full aura update detected,rechecking all buckets")
SAO:CheckManuallyAllBuckets(SAO.TRIGGER_AURA)
return
end
local addAura=function(auraInstanceID,aura,bucket)
bucket:setAuraStacks(bucket.stackAgnostic and 0 or aura.applications)
bucket.lastKnownAuraStacks=aura.applications
if bucket.auraInstanceID then
bucketsByAuraInstanceID[bucket.auraInstanceID]=nil
bucket:refresh()
end
bucket.auraInstanceID=auraInstanceID
bucketsByAuraInstanceID[auraInstanceID]=bucket
end
local removeAura=function(auraInstanceID,bucket)
bucket:setAuraStacks(nil)
bucket.lastKnownAuraStacks=nil
bucket.auraInstanceID=nil
bucketsByAuraInstanceID[auraInstanceID]=nil
end
local updateAura=function(auraInstanceID,aura,bucket)
if bucket.lastKnownAuraStacks~=aura.applications then
bucket:setAuraStacks(bucket.stackAgnostic and 0 or aura.applications)
bucket.lastKnownAuraStacks=aura.applications
else
bucket:refresh()
end
end
for _,aura in ipairs(canaccessvalue(updateInfo.addedAuras) and updateInfo.addedAuras or {})do
local bucket=SAO:GetBucketBySpellID(aura.spellId)
if bucket and bucket.trigger:reactsWith(SAO.TRIGGER_AURA)then
local auraInstanceID=aura.auraInstanceID
if bucket.auraInstanceID==auraInstanceID then
updateAura(auraInstanceID,aura,bucket)
else
addAura(auraInstanceID,aura,bucket)
end
end
end
for _,auraInstanceID in ipairs(canaccessvalue(updateInfo.updatedAuraInstanceIDs) and updateInfo.updatedAuraInstanceIDs or {})do
local bucket=bucketsByAuraInstanceID[auraInstanceID]
if bucket then
local aura=C_UnitAuras.GetAuraDataByAuraInstanceID(unitTarget,auraInstanceID)
if not aura then
removeAura(auraInstanceID,bucket)
else
updateAura(auraInstanceID,aura,bucket)
end
end
end
for _,auraInstanceID in ipairs(canaccessvalue(updateInfo.removedAuraInstanceIDs) and updateInfo.removedAuraInstanceIDs or {})do
local bucket=bucketsByAuraInstanceID[auraInstanceID]
if bucket then
removeAura(auraInstanceID,bucket)
end
end
end or nil,
PLAYER_REGEN_ENABLED=SAO.AURASTACKS.MODERN and function(self,event,...)
for _,bucket in ipairs(secretBuckets)do
SAO:Debug(Module, "Checking buckets manually for secret aura",bucket.name)
bucket.trigger:manualCheck(SAO.TRIGGER_AURA)
end
end or nil,
},
condition={
noeVar="aura",
hreVar="stacks",
noeDefault=0,
description="number of stacks",
checker=function(value) return type(value)=='number' and value >=-1 and value <=10 end,
noeToHash=function(value) return value >=0 and value or nil end,
},
import={
noeTrigger="aura",
hreTrigger="requireAura",
dependency=(C_Secrets and C_Secrets.GetSpellAuraSecrecy) and {
name="spellID",
expectedType="number",
default=function(effect) return effect.spellID end,
prepareBucket=function(bucket,value)
local secrecy=SAO:IsSpellSecret(value)
if secrecy==1 then
SAO:Debug(Module,bucket.description.." is based on spell "..value.." which has secret restrictions")
elseif secrecy==2 then
SAO:Debug(Module,bucket.description.." is based on spell "..value.." which is always secret")
end
local hasSecretRestrictions=type(secrecy)=='number' and secrecy > 0
bucket.auraHasSecretRestrictions=hasSecretRestrictions
if hasSecretRestrictions then
table.insert(secretBuckets,bucket)
else
table.insert(secretlessBuckets,bucket)
end
end,
} or nil,
classes={
force="aura",
ignore=nil,
},
},
macro={
getCondition=nil,
},
})
