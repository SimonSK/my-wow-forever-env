local AddonName,SAO=...
local GetItemInfo=C_Item and C_Item.GetItemInfo or GetItemInfo
function SAO.GetItemText(self,itemID)
local name,_,_,_,_,_,_,_,_,icon=GetItemInfo(itemID)
if name then
return "|T"..icon..":0|t "..name
end
end
local function registerHealingTrance(self,label,spellID,itemID)
local itemTextFunc=function()
local itemText=self:GetItemText(itemID)
if itemText then
return itemText
else
local item=Item:CreateFromItemID(itemID)
return function(callback)
item:ContinueOnItemLoad(callback)
end
end
end
self:CreateEffect(
label,
SAO.ALL_PROJECTS,
spellID,
"aura",
{
overlay={
texture="genericarc_04",
position="Left + Right (Flipped)",outer=0.2,scale=1.2,
color={255,192,255},
pulse=false,
option={subText=itemTextFunc},
},
}
)
end
function SAO.RegisterAuraEyeOfGruul(self,label,spellID)
if self.IsTBC()then
registerHealingTrance(self,label,spellID,28823)
end
end
function SAO.RegisterAuraSoulPreserver(self,label,spellID)
if self.IsWrath()then
registerHealingTrance(self,label,spellID,37111)
end
end
function SAO:CreateRevelationEffect(label,spellID)
self:CreateEffect(
label,
SAO.FOREVER,
spellID,
"aura",
{
overlay={
texture="genericarc_02",
position="Left + Right (Flipped)",outer=1,
color={210,145,178},
pulse=false,
option={subText=WEAPON_ENCHANTMENT},
},
}
)
end
