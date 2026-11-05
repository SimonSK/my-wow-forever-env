local AddName, Ns = ...

local L = Ns.RegisterLocale("enUS", true)


-- Global entries
L["Settings"] = "Settings"
L["SettingsDescription"] = ""
L["TextMenu"] = "Text"
L["MinimapTMenu"] = "Minimap"
L["Text"] = "Text"
L["TextDescription"] = ""
L["Layout"] = "Layout"
L["LayoutDescription"] = ""
L["Events"] = "Smart HUD"
L["EventsDescription"] = ""
L["Profiles"] = "Profiles"
L["ProfilesDescription"] = ""
L["JourneysDescription"] = ""
L["Journeys"] = "Journeys"

-- Spellclass
L["HUDMenu"] = "Settings"
L["HUDsMenu"] = "HUD"
L["FontsMenu"] = "Fonts"
L["DisplayMenu"] = "Display"
L["DisplayOrderMenu"] = "Layout"
L["EventsMenu"] = "Events"
L["ProfilesMenu"] = "Profiles"
L["FAQMenu"] = "FAQ"

L["Physical"] = "Physical"
L["PhysicalDescription"] = ""
L["Enhancement"] = "Enhancement"
L["EnhancementDescription"] = ""
L["Spell"] = "Spell"
L["SpellDescription"] = ""
L["Misc"] = "Misc"
L["MiscDescription"] = ""
L["Currency"] = "Currency"
L["CurrencyDescription"] = ""
L["Melee"] = "Melee"
L["MeleeDescription"] = ""
L["Ranged"] = "Ranged"
L["RangedDescription"] = ""
L["Defensive"] = "Defense"
L["DefensiveDescription"] = ""
L["Resistance"] = "Resistance"
L["ResistanceDescription"] = ""

-- HUD
L["SettingsDescription"] = ""
L["HideHUD"] = "Hide"
L["HideHUDTip"] = ""
L["LockHUD"] = "Lock"
L["LockHUDTip"] = ""
L["PanelMenu"] = "Character Panel"
L["PanelDisplay"] = "Attach"
L["PanelDisplayTip"] = ""
L["ConfigShortcut"] = "Settings icon"
L["ConfigShortcutTip"] = ""
L["OpenSettings"] = "Open Settings"
L["BackgroundMenu"] = "Background"
L["HUDBgTexture"] = "Texture"
L["HUDBgTextureTip"] = ""
L["HUDBgColor"] = "Color"
L["HUDBgColorTip"] = ""
L["HUDBgAlpha"] = "Opacity"
L["HUDBgAlphaTip"] = ""
L["BorderMenu"] = "Border"
L["HUDBorder"] = "Border"
L["HUDBorderTip"] = ""
L["HUDBorderTexture"] = "Texture"
L["HUDBorderTextureTip"] = ""
L["HUDBorderColor"] = "Color"
L["HUDBorderColorTip"] = ""
L["HUDBorderSize"] = "Size"
L["HUDBorderSizeTip"] = ""
L["HUDBorderInset"] = "Inset"
L["HUDBorderInsetTip"] = ""
L["HideHeader"] = "Header text"
L["HideHeaderTip"] = ""
L["HeaderOpacity"] = "Header opacity"
L["HeaderOpacityTip"] = ""
L["ResetPosition"] = "Reset HUD Position"
L["ResetPositionTip"] = "Reset the stats HUD's position"
L["HUDStrataTip"] = ""
L["HUDStrata"] = "Frame Strata"
L["MinimapGroupText"] = "Minimap"
L["Minimap"] = "Minimap Button"
L["MinimapTip"] = ""
L["CompButton"] = "Compartment Button"
L["CompButtonTip"] = ""
L["Lowest"] = "Lowest"
L["Low"] = "Low"
L["Medium"] = "Medium"
L["High"] = "High"
L["Highest"] = "Highest"

-- Text
L["OutlineMenu"] = "Outline"
L["StatFont"] = "Fonts"
L["StatFontTip"] = ""
L["StatFontSize"] = "Size"
L["StatFontSizeTip"] = ""
L["StatFontFlags"] = "Outline"
L["StatFontFlagsTip"] = ""
L["FontShadowTip"] = ""
L["FontShadow"] = "Shadow"
L["ShadowX"] = "X Offset"
L["ShadowXTip"] = ""
L["ShadowY"] = "Y Offset"
L["ShadowYTip"] = ""
L["Default Font"] = "Arial Narrow"
L["Thin"] = "Thin"
L["Thick"] = "Thick"
L["Monochrome"] = "Monochrome"
L["Thin Monochrome"] = "Thin Monochrome"
L["Thick Monochrome"] = "Thick Monochrome"
L["None"] = "None"
L["SpacingMenu"] = "Spacing"
L["StatWidth"] = "String Length"
L["StatWidthTip"] = ""
L["StatSpacingH"] = "Text Width"
L["StatSpacingHTip"] = ""
L["StatSpacingV"] = "Text Height"
L["StatSpacingVTip"] = ""
L["AlignMenu"] = "Alignment"
L["AlignValuesTip"] = ""
L["AlignValues"] = "Align values"
L["AlignValuesTooltip"] = Ns.Colors.Green .. "Align values|r\nAlign stat values in a clean column"
L["AlignGap"] = "Label to Value gap"
L["AlignGapTip"] = ""
L["StatIconsTip"] = ""
L["StatIcons"] = "Icons"
L["StatTextCapsTip"] = ""
L["StatTextCaps"] = "Uppercase"
L["StatTextColorTip"] = ""
L["StatTextColor"] = "Labels"
L["ClassColorsTip"] = ""
L["ClassColors"] = "Class color"
L["StatWidthTooltip"] = Ns.Colors.Green .. "Text string width|r\n" .. "Adjust the text string width to fit your stats \nIncrease the width to create more space if \na text is truncated (...) \n\nThis option is disabled when displaying your \nstats on 1 row or on 1 column (see Layout)"
L["StatAlignmentTip"] = ""
L["StatAlignment"] = "Align Text"
L["IconAlignment"] = "Align icons"
L["IconAlignmentTip"] = ""
L["GrowDirectionTip"] = ""
L["GrowDirection"] = "Grow Direction"
L["Top to Bottom"] = "Top to bottom"
L["Bottom to Top"] = "Bottom to top"
L["GlobalColorMenu"] = "Global colors"
L["DataColor"] = "Values"
L["DataColorTip"] = ""
L["SplitColors"] = "Color values"
L["SplitColorsTip"] = ""
L["SplitColorsTooltip"] = Ns.Colors.Green .. "Value text color|r\n" .. "Enabling this option will allow stat \nvalues to be set in a different color \nfrom the stat name \n\nUse the" .. Ns.Colors.Green .. " Text color (Value)|r color \npicker to set a color"
L["Left"] = "Left"
L["Right"] = "Right"
L["Center"] = "Center"
L["TextSeparator"] = "Separator"
L["TextSeparatorTip"] = ""
L["HideText"] = "Labels"
L["HideTextTip"] = ""

-- Profiles
L["Selected"] = "Apply"
L["ProfileSelectLabel"] = "Select"
L["ProfileCreateCopy"] = "Create Copy"
L["ProfileCreateDefault"] = "Create Default"
L["ProfileCopyFrom"] = "Copy"
L["ProfileCopyWarning"] = "Copy profile from %s to %s?"
L["ProfileCopiedMsg"] = "Profile %s has been copied to %s"
L["ProfileCreatedCopy"] = "Profile %s copied from %s successfully created"
L["ProfileCreatedDefault"] = "A default profile %s successfully created"
L["ProfileDeleteWarning"] = "Characters that will lose this profile:"
L["ProfileDeleteNoChars"] = "No characters currently use this profile"
L["SpecProfilesEnable"] = "Spec Profiles"
L["SpecProfilesEnableTip"] = Ns.Colors.Green .. "Spec Profiles|r\nAutomatically switch profiles when \nchanging specs\nAssign a profile to each spec below."
L["SpecProfileLabel"] = "%s:"
L["SpecProfileNone"] = "None"
L["SelectProfile"] = "Manage your profiles: Select, Create, Copy or Delete"
L["ProfileSelected"] = "Profiles"
L["ProfileUsed"] = "Profile is currently in use, unable to delete!"
L["NewProfile"] = "Create"
L["CurrentProfile"] = "Active Profile"
L["Copy"] = "Copy from"
L["Delete"] = "Delete"
L["ConfirmDelete"] = "Confirm"
L["Cancel"] = "Cancel"
L["Clear"] = "Clear"
L["ProfileCopyDelete"] = "Select, delete or copy to new profile."
L["ProfileRenameLabel"] = "Rename"
L["ProfileExport"] = "Export"
L["ProfileImport"] = "Import"
L["ProfileExportTitle"] = "Export Profile"
L["ProfileImportTitle"] = "Import Profile"
L["ProfileExportCopy"] = "Copy to Clipboard"
L["ProfileImportApply"] = "Import"
L["ProfileImportError"] = "Invalid import string!"
L["ProfileImportSuccess"] = "Profile '%s' imported successfully!"
L["ProfileImportPlaceholder"] = "Paste import string here..."

-- HUD Studio
L["Panels"] = "HUD Studio"
L["PanelManagementMenu"] = "HUD Studio"
L["PanelCurrent"] = "Active HUD"
L["PanelsDescription"] = ""
L["PanelSelectLabel"] = "Select"
L["PanelSwitch"] = "Switch"
L["PanelCreateLabel"] = "Create"
L["PanelCopyCurrent"] = "Copy active HUD"
L["PanelCreate"] = "Create"
L["PanelDeleteLabel"] = "Delete"
L["PanelRenameLabel"] = "Rename"
L["PanelRename"] = "Rename"
L["PanelDeleteWarning"] = "Delete %s? \nThis cannot be undone."
L["PanelDeletedMsg"] = "%s has successfully been deleted"

-- HUD Export/Import (success msg differs from profile)
L["HUDImportSuccess"] = "HUD '%s' imported successfully!"

-- Search
L["Search"] = "Search"
L["SearchDescription"] = ""
L["SearchMenu"] = "Search"
L["RecentSearches"] = "Recent Search"
L["CurrText"] = "Displays the currency "
L["RenoText"] = "Displays the renown rank of "

-- Global bar
L["GlobalBar_EnableAll"] = "Enable all stats"
L["GlobalBar_DisableAll"] = "Disable all stats"
L["GlobalBar_RemoveBars"] = "Remove all bars"
L["GlobalBar_ResetColor"] = "Reset text color"
L["GlobalBar_TextColor"] = "Text color"
L["GlobalBar_ConfirmEnable"] = "Enable every stat in this group?"
L["GlobalBar_ConfirmDisable"] = "Disable every stat in this group?"
L["GlobalBar_ConfirmRemove"] = "Remove every bar in this group?"
L["GlobalBar_ConfirmReset"] = "Reset text color for every stat in this group?"
L["GlobalBar_QuickColor"] = "Quick color"
L["QuickColor_EnableAll"] = "Enable individual colors"

-- Layout
L["ClearAllColumns"] = "Reset"
L["Rows"] = "Row Presets"
L["Columns"] = "Column Presets"
L["OneRow"] = "1"
L["TwoRows"] = "2"
L["ThreeRows"] = "3"
L["FourRows"] = "4"
L["DisplayOrderDescription"] = ""
L["LayoutHint"] = "Drag to reorder  |  Right-click to toggle column break  |  Apply when done"
L["PanelsHint"] = "Create and manage additional HUD panels"
L["ProfilesHint"] = "Create and manage your profiles"

-- Events
L["EventEnable"] = "Enable"
L["EventEnableTip"] = ""
L["EventEnableTooltip"] = Ns.Colors.Green .. "Smart HUD|r\n" .. "Show or Hide the HUD automatically when \nany of the conditions below are met \n\nCombat has a higher priority"
L["EventWorld"] = "Open World"
L["EventWorldTip"] = ""
L["EventDungeon"] = "Dungeons"
L["EventRaid"] = "Raids"
L["EventPvP"] = "Battlegrounds"
L["EventArena"] = "Arena"
L["EventCombat"] = "Combat"
L["ShowStats"] = "Show stats only while"
L["HideStats"] = "Hide stats when"
L["EventOpacity"] = "Fade"
L["EventOpacityTip"] = ""
L["EventOpacityTooltip"] = Ns.Colors.Green .. "Fade Opacity|r\nMakes the HUD fade instead of hide"
L["EventDelves"] = "Delves"
L["EventResting"] = "Resting (City/Inn)"
L["EventMounted"] = "Mounted"
L["EventMouseOver"] = "Mouse Over"
L["EventTarget"] = "Target"
L["EventTargetHostile"] = "Hostile Only"
L["EventSettingsMenu"] = "Settings"
L["EventTimerTip"] = ""
L["EventTimer"] = "Hide delay"
L["EventOpacityValue"] = "Opacity"
L["EventOpacityValueTip"] = ""
L["EventTime"] = "Seconds"
L["EventTimeTip"] = ""
L["FAQDescription"] = ""

-- Minimap
L["QuickAccess"] = "Quick Access"
L["OpenSettings"] = "Open Settings"
L["EnableDisable"] = "Enable/Disable HUD"
L["ShiftRightClick"] = "+ Shift"
L["UnlockHUD"] = "Lock/Unlock HUD"

L["GradientText"] = "Gradient text"
L["GradientTextTip"] = ""
L["GradientTextTooltip"] = Ns.Colors.Green .. "Gradient Text|r\n" .. "Color the stat value using a gradient based \non its current value relative to its maximum"

L["InstanceTimer"] = "Timer"
L["InstanceTimerMenu"] = "Instance Timer"
L["InstanceTimerDescription"] = "Displays the elapsed time inside a dungeon or raid.\n\n" .. Ns.Colors.Green .. "Starts when entering the instance.\n" .. Ns.Colors.Green .. "Stops when leaving or upon completion"

L["Timer_Format"] = "Format"
L["Timer_FormatTip"] = ""
L["Send_Chat"] = "Send to chat"
L["Send_ChatTooltip"] = Ns.Colors.Green .. "Send to chat|r\n" .. "Send the completion time to\ninstance chat when complete"

-- SS6 new entries --
-- Fizz Custom Name
L["CustName"] = "Name"
L["CustNameTooltip"] = Ns.Colors.Green .. "Name|r\n" .. "Enter a custom name for this \nstat \n\n" .. "Leaving it blank will use the \ndefault text \n\n" .. "Enter a space to hide the stat \nname"

-- Stats text color
L["ColorCustom"] = ""--"Custom Color"
L["ColorCustom"] = "Enable"
L["ColorName"] = "Label"
L["ColorClass"] = "Class color"
L["ColorValue"] = "Value"
L["ColorValueEndableTip"] = ""
L["ColorValueEndable"] = "Value color"

-- FAQ
L["FAQSixth"] = Ns.MiscIcon .. Ns.Colors.Orange .. "Some of the stats' text is truncated (...)|r\n\n " .. Ns.SettingsIcon .. "Settings >> " .. Ns.DisplayIcon .. "Display >> " .. Ns.SpacingIcon .. "Spacing & Alignment: Adjust the " .. Ns.WidthStringIcon .. Ns.Colors.Green .. "Text: Width|r slider"
L["FAQFourth"] = Ns.MiscIcon .. Ns.Colors.Orange .. "How to display the stats in columns or rows|r\n\n " .. Ns.SettingsIcon .. "Settings >> " .. Ns.LayoutIcon .. "Layout: Mouse-over its " .. Ns.MiscIcon .. "icon for more details"
L["FAQSecond"] = Ns.MiscIcon .. Ns.Colors.Orange .. "How can I set my stat text in colors|r\n\n " .. Ns.SettingsIcon .. "Settings >> " .. Ns.HUDIcon .. "HUD >> " .. Ns.DisplayIcon .. "Display >> " .. Ns.Colors.Green .. Ns.ValueIcon .. "Global Text Color|r to change the text color of all stats \ntogether, or enable " .. Ns.Colors.Green .. "Custom Color|r in each stat's settings to set custom colors for each stat separately"
L["FAQFifth"] = Ns.MiscIcon .. Ns.Colors.Orange .. "How to enable stats in-combat only or in other specific situations|r\n\n " .. Ns.SettingsIcon .. "Settings >> " .. Ns.EventsIcon .. "Smart HUD: Make the stats only visible in the selected events"
L["FAQThird"] = Ns.MiscIcon .. Ns.Colors.Orange .. "How to display the stats on one single row|r\n\n " .. Ns.SettingsIcon .. "Settings >> " .. Ns.LayoutIcon .. "Layout: Click the 1 button in " .. Ns.Colors.Green .. "Row Presets|r or right-click each stat to toggle column breaks"
L["FAQFirst"] = Ns.MiscIcon .. Ns.Colors.Orange .. "How to re-order the stats|r\n\n " .. Ns.SettingsIcon .. "Settings >> " .. Ns.LayoutIcon .. "Layout: Drag and drop the stats on the preview"
L["FAQSeventh"] = Ns.MiscIcon .. Ns.Colors.Orange .. "How to hide stat names|r\n\n " .. Ns.SettingsIcon .. "Settings >> " .. Ns.HUDIcon .. "HUD >> " .. Ns.DisplayIcon .. "Display >> " .. Ns.Colors.Green .. Ns.ToggleText .. "Hide stat names|r hides all stat names globally \nTo hide an individual stat name, enter a space in its " .. Ns.Colors.Green .. "Name|r editbox in the stat's settings"
L["FAQEighth"] = Ns.MiscIcon .. Ns.Colors.Orange .. "What are status bars|r\n\n Status bars are visual fill bars that appear behind each stat. \nThey fill based on the stat's current value relative to a \nmaximum value \n\n Enable them per stat in its settings under " .. Ns.Colors.Green .. "Status bars|r and choose a max \nvalue mode, color, texture and opacity"

-- Stat options
L["GroupSetup"] = "Setup"
L["GroupCaps"] = "Stat caps"
L["GroupTextColor"] = "Text color"
L["GroupStatusBars"] = "Status bars"
L["BarMaxMode"] = "Max value"
L["BarMaxModeTip"] = ""
L["BarMaxCustom"] = "Custom"
L["BarMaxCustomTooltip"] = Ns.Colors.Green .. "Custom|r\n" .. "Set a custom maximum value \nfor the stat bar fill"
L["BarTexture"] = "Texture"
L["BarTextureTip"] = ""
L["BarColor"] = "Bar color"
L["BarColorTip"] = ""
L["BarAlpha"] = ""
L["BarAlpha"] = "Bar opacity"
L["BarAlphaTip"] = ""
L["BarBgColor"] = "Background color"
L["BarBgColorTip"] = ""
L["BarBgAlpha"] = ""
L["BarBgAlpha"] = "Background opacity"
L["BarBgAlphaTip"] = ""
L["BarAutoColor"] = "Progression color"
L["BarAutoColorTooltip"] = Ns.Colors.Green .. "Progression Color|r\n" .. "Automatically color the bar from \nred (empty) to green (full) gradient"
L["AutoColorOff"] = "Disable gradient"
L["AutoColorOffTip"] = ""
L["AutoColorOffTooltip"] = Ns.Colors.Green .. "Gradient text|r\n" .. "Automatically color the value from a \nred (empty) to green (full) gradient"
L["Percentage"] = "Percentage"
L["BarMaxCap"] = "Cap"
L["Custom"] = "Custom"
L["NextRank"] = "Next Rank"
L["MaxRank"] = "Max Rank"
L["JourneyBarMode"] = "Max value"
L["JourneyBarModeTip"] = ""
L["SpeedBar"] = "Max value"
L["SpeedBarTip"] = ""
L["Auto"] = "Auto"
L["Steady Flying"] = "Steady Flying"
L["Skyriding"] = "Skyriding"
L["On Foot"] = "On Foot"
L["Mounted"] = "Mounted"

L["SpellPowerModifiers"] = "Spell Power Modifiers\n"
L["BossArmorModifier"] = "Raid boss armor value\n"
L["TipsAndInfo"] = "Tips and Info!|r\n\n"
L["SinLive"] = Ns.Colors.Green .. "SinLive™ Stat!\nThis stat is interactive and scales with your current target|r\n\n"
L["NPCPlus3"] = "+3 levels\n"
L["NPCPlus4"] = "+4 levels\n"
L["NPC1to5"] = "Target level: +1 to +8\n"
L["NPCAnyLevel"] = "Unit level\n"
L["NPCSameLevel"] = "Same level\n"
L["DefaultValueText"] = Ns.Colors.Green .. "\n\nDefault value:|r  "
L["ScalingText"] = Ns.Colors.Green .. "\nTarget Scaling|r \n"

L["CommonScaling"] = "This stat scales with other stats\n"
L["Level_Same_BossTooltip"] = Ns.Colors.Green .. "Same Level|r\n" .. "Chance to miss against an NPC \nof the same level as yours \n\n" .. Ns.Colors.Green .. "Boss Level|r\n" .. "Chance to miss against an NPC \nof 1 to 5 level higher than yours \nSee the Default cap below"
L["Regen_Normal_CastingTooltip"] = Ns.Colors.Green .. "Normal|r\n" .. "Mana regeneration while not in \ncombat \n\n" .. Ns.Colors.Green .. "Combat|r\n" .. "Mana regeneration while in \ncombat"
L["Display_TotalTooltip"] = Ns.Colors.Green .. "Total|r\n" .. "Displays the total member count \nnext to the online count"
L["BNet_RealmTooltip"] = Ns.Colors.Green .. "BattleNet|r\n" .. "Displays online BattleNet friends \n\n" .. Ns.Colors.Green .. "Realm|r\n" .. "Displays online realm friends \n\n" .. Ns.Colors.Green .. "Both|r\n" .. "Displays both BattleNet and \nrealm friends online"
L["Enhanced_BaseTooltip"] = Ns.Colors.Green .. "Enhanced|r\n" .. "Provides the best accuracy by adding \ntalents, buffs, debuffs, flasks, gems, \nenchants and other sources \n\n" .. Ns.Colors.Green .. "Basic|r\n" .. "Displays the stat as is, without additions \nand may not be the most accurate"
L["Percent_RatingTooltip"] = Ns.Colors.Green .. "Percentage|r\n" .. "Displays the stat in percentage \n\n" .. Ns.Colors.Green .. "Rating|r\n" .. "Displays the rating value"
L["Display_RatingTooltip"] = Ns.Colors.Green .. "Rating|r\n" .. "Displays the rating value"

L["Display_Rating"] = "Rating"

L["DamageTaken"] = "Damage Taken"
L["CritTaken"] = "Crit taken"
L["Crit_Damage_TakenTooltip"] = Ns.Colors.Green .. "Crit Taken|r\n" .. "Reduction in periodic damage and in \nthe chance to be critically hit \n\n" .. Ns.Colors.Green .. "Damage Taken|r\n" .. "Reduction in mana-drains effects and \nin the damage of critical strikes"

L["BloodFrenzy"] = Ns.BloodFrenzyLink
L["CurseofElements"] = Ns.CurseofElementsLink
L["FireVulnerability"] = Ns.FireVulnerabilityLink
L["Hemorrhage"] = Ns.HemorrhageLink
L["HuntersMark"] = Ns.HuntersMarkLink
L["InsectSwarm"] = Ns.InsectSwarmLink
L["Misery"] = Ns.MiseryLink
L["SealofCrusader"] = Ns.SealofCrusaderLink .. " (Improved)"
L["ScorpidSting"] = Ns.ScorpidStingLink
L["SurvivalofFittest"] = Ns.SurvivalofFittestLink
L["ShadowWeaving"] = Ns.ShadowWeavingLink
L["ShadowVulnerability"] = Ns.ShadowVulnerabilityLink
L["Stormstrike"] = Ns.StormstrikeLink
L["WintersChill"] = Ns.WintersChillLink
L["SunderArmor"] = Ns.SunderArmorLink
L["ExposeArmor"] = Ns.ExposeArmorLink
L["FaerieFire"] = Ns.FaerieFireLink
L["CurseOfReck"] = Ns.CurseOfReckLink
L["ArmorShatter"] = Ns.ArmorShatterLink .. " (Annihilator Proc)"


L["AP"] = "AP"
L["APMenu"] = "Attack Power"
L["APDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "Attack Power|r in red indicates that you are affected by a debuff"

L["RAP"] = "rAP"
L["RAPMenu"] = "Attack Power"
L["RAPDescription"] = L["SinLive"] .. Ns.Colors.Red .. "Attack Power|r in red indicates that you are affected by a debuff\nA green |cff00f26dAttack Power|r value indicates that Hunter's Mark ability is applied on your target\n" .. L["ScalingText"] .. L["HuntersMark"]

L["DMG"] = "DMG"
L["DMGMenu"] = "Damage"
L["DMGDescription"] = L["SinLive"] .. Ns.Colors.Red .. "Damage|r in red indicates that you are affected by a debuff\n" .. L["ScalingText"] .."\n".. L["BloodFrenzy"] .."\n".. L["Hemorrhage"]

L["mDPS"] = "DPS"
L["mDPSMenu"] = "DPS"
L["mDPSDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "Attack Power|r in red indicates that you are affected by a debuff"

L["RDMG"] = "rDMG"
L["RDMGMenu"] = "Damage"
L["RDMGDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "Attack Power|r in red indicates that you are affected by a debuff\n" .. L["ScalingText"] .."\n".. L["BloodFrenzy"] .."\n".. L["Hemorrhage"]

L["rDPS"] = "rDPS"
L["rDPSMenu"] = "DPS"
L["rDPSDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "Attack Power|r in red indicates that you are affected by a debuff"

L["Fire"] = "Fire"
L["FireMenu"] = "Fire"
L["FireDescription"] = L["SinLive"] .. "Includes Fire damage from gear, consumables, enchants and talents\n" .. L["ScalingText"] .."\n".. L["SpellPowerModifiers"] .."\n".. L["Misery"] .."\n".. L["CurseofElements"] .."\n".. L["FireVulnerability"]

L["Frost"] = "Frost"
L["FrostMenu"] = "Frost"
L["FrostDescription"] = L["SinLive"] .. "Includes Frost damage from gear, consumables, enchants and talents\n" .. L["ScalingText"] .."\n".. L["SpellPowerModifiers"] .."\n".. L["Misery"] .."\n".. L["CurseofElements"]

L["Arcane"] = "Arcane"
L["ArcaneMenu"] = "Arcane"
L["ArcaneDescription"] = L["SinLive"] .. "Includes Arcane damage from gear, consumables, enchants and talents\n" .. L["ScalingText"] .."\n".. L["SpellPowerModifiers"] .."\n".. L["Misery"] .."\n".. L["CurseofElements"]

L["Shadow"] = "Shadow"
L["ShadowMenu"] = "Shadow"
L["ShadowDescription"] = L["SinLive"] .. "Includes Shadow damage from gear, consumables, enchants and talents\n" .. L["ScalingText"] .."\n".. L["SpellPowerModifiers"] .."\n".. L["Misery"] ..", "..  L["ShadowWeaving"] .."\n".. L["ShadowVulnerability"] ..", ".. L["CurseofElements"]

L["Nature"] = "Nature"
L["NatureMenu"] = "Nature"
L["NatureDescription"] = L["SinLive"] .. "Includes Nature damage from gear, consumables, enchants and talents\n" .. L["ScalingText"] .."\n".. L["SpellPowerModifiers"] .."\n".. L["Misery"] .."\n".. L["Stormstrike"]

L["Healing"] = "Healing"
L["HealingMenu"] = "Healing"
L["HealingDescription"] = L["TipsAndInfo"] .. "Includes +healing from gear, consumables, enchants and talents"

L["Holy"] = "Holy"
L["HolyMenu"] = "Holy"
L["HolyDescription"] = L["SinLive"] .. "Includes Holy damage from gear, consumables, enchants and talents\n" .. L["ScalingText"] .."\n".. L["SpellPowerModifiers"] .."\n".. L["Misery"] .."\n".. L["SealofCrusader"]

L["Crit"] = "Crit"
L["CritMenu"] = "Critical Strike"
L["CritDescription"] = L["SinLive"] .. "Spell book Melee Critical Strike value\nAlso represents your Critical Strike in PvP\n" .. L["ScalingText"] .."\n".. L["SealofCrusader"]

L["CritBoss"] = "Crit+"
L["CritBossMenu"] = "Critical vs Boss"
L["CritBossDescription"] = L["SinLive"] .. "Melee Critical Strike value in PvE, against a higher level NPC\nIncludes all Crit Suppressions Auras" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .."\n".. L["NPC1to5"] .."\n".. L["SealofCrusader"]

L["CritCap"] = "Crit Cap"
L["CritCapMenu"] = "Critical Cap"
L["CritCapDescription"] = L["TipsAndInfo"] .. "Displays the Melee Critical Strike Cap against a Raid Boss \nbased on the weapons used and other character stats"

L["RangedCrit"] = "rCrit"
L["RangedCritMenu"] = "Critical Strike"
L["RangedCritDescription"] = L["TipsAndInfo"] .. "Spell book Ranged Critical Strike value\nAlso represents your Critical Strike in PvP"

L["RangedCritBoss"] = "rCrit+"
L["RangedCritBossMenu"] = "Critical vs Boss"
L["RangedCritBossDescription"] = L["SinLive"] .. "Ranged Critical Strike value in PvE, against a higher level NPC\nIncludes all Crit Suppressions Auras" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPC1to5"]

L["SpellCrit"] = "sCrit"
L["SpellCritMenu"] = "Critical Strike"
L["SpellCritDescription"] = L["SinLive"] .. "Spell book Critical Strike value. Also represents your Critical Strike in PvP\nSpell-specific Crit Talents are colored and appear next to the current value\n" .. L["ScalingText"] .."\n".. L["SealofCrusader"] .."\n".. L["WintersChill"]

L["SpellCritBoss"] = "sCrit+"
L["SpellCritBossMenu"] = "Critical vs Boss"
L["SpellCritBossDescription"] = L["SinLive"] .. "Spell book Critical Strike value. Also represents your Critical Strike in PvP\nSpell-specific Crit Talents are colored and appear next to the current value\n" .. L["ScalingText"] .."\n".. L["SealofCrusader"] .."\n".. L["WintersChill"]

L["Hit"] = "Hit"
L["HitMenu"] = "Hit"
L["HitDescription"] = L["TipsAndInfo"] .. "Displays the Melee Hit Chance percentage. Includes all Hit rating sources"

L["RangedHit"] = "rHit"
L["RangedHitMenu"] = "Hit"
L["RangedHitDescription"] = L["TipsAndInfo"] .. "Displays the Ranged Hit Chance percentage. Includes all Hit rating sources"

L["HasteMelee"] = "Haste"
L["HasteMeleeMenu"] = "Haste"
L["HasteMeleeDescription"] = L["TipsAndInfo"] .. "Haste bonus percentage from abilities procs, enchants,\ntalents, trinkets, consumables and buffs"

L["weaponSpeed"] = "Atk Speed"
L["weaponSpeedMenu"] = "Attack Speed"
L["weaponSpeedDescription"] = L["TipsAndInfo"] .. "Weapon speed for Main Hand and Off Hand"

L["ArmorPenetration"] = "Armor Pen"
L["ArmorPenetrationMenu"] = "Armor Pen"
L["ArmorPenetrationDescription"] = L["TipsAndInfo"] .. "Percentage of your target's armor that your physical attacks ignore"

L["BossReduc"] = "DMG-"
L["BossReducMenu"] = "Damage Mod"
L["BossReducDescription"] = L["SinLive"] .. "Percentage of reduction to physical damage done against a Raid Boss NPC based on its armor\nWhen targeting a non-Raid Boss NPC, the total value of damage increase based on the armor reduction debuffs will be shown\nA target must be selected to see the reduction against it\n" .. L["ScalingText"] .."\n".. L["NPCPlus3"] .."\n".. L["SunderArmor"] .."\n".. L["ExposeArmor"] .."\n".. L["FaerieFire"] .."\n".. L["CurseOfReck"] .."\n".. L["ArmorShatter"]

L["Expertise"] = "Expertise"
L["ExpertiseMenu"] = "Expertise"
L["ExpertiseDescription"] = L["TipsAndInfo"] .. "Expertise reduction to chance to be dodged or parried, in percent for \nboth the Main-hand and the Off-hand"
L["Exp_Add"] = "Racial and talents"
L["Exp_AddTip"] = ""
L["Exp_AddTooltip"] = Ns.Colors.Green .. "Racial and talents|r\n" .. "Adds the expertise from racial \nweapon specializations and talents to \nthe expertise rating, which otherwise \nonly counts rating \n\n" .. Ns.Colors.Green .. "Racial specializations|r \n+5 for human swords \nand for orc axes \n\n" .. Ns.Colors.Green .. "Talents|r \nRogue Weapon Expertise \nWarrior Defiance \nPaladin Combat Expertise"

L["MeleeMiss"] = "Miss"
L["MeleeMissMenu"] = "Miss Chance"
L["MeleeMissDescription"] = L["SinLive"] .. "Miss chance with melee weapons against an NPC" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPC1to5"]

L["Avoidance"] = "Avoidance"
L["AvoidanceMenu"] = "Avoidance"
L["AvoidanceDescription"] = L["SinLive"] .. "Chance to avoid Crushing Blows \nA green |cff00f26dAvoidance|r text indicates that you are uncrushable" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .."\n".. L["ScorpidSting"] .."\n".. L["InsectSwarm"]

L["Crushing"] = "Crushing"
L["CrushingMenu"] = "Crushing"
L["CrushingDescription"] = L["SinLive"] .. "Chance to be hit by a Crushing Blow \nA green |cff00f26dCrushing|r text indicates that you are uncrushable" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .."\n".. L["ScorpidSting"] .."\n".. L["InsectSwarm"]

L["CritReceived"] = "Crit-"
L["CritReceivedMenu"] = "Crit Immunity"
L["CritReceivedDescription"] = L["SinLive"] .. "Chance to be Critically hit by an NPC \nA green |cff00f26dCrit Immunity|r text indicates that you cannot be critically hit\nA red |cffC41E3ACrit Immunity|r indicates that you are under the critical hit cap" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .."\n".. L["NPCAnyLevel"] .."\n".. L["SurvivalofFittest"]

L["EHP"] = "EHP"
L["EHPAbrev"] = "EHP"
L["EHPMenu"] = "EHP"
L["EHPDescription"] = L["SinLive"] .. "Effective HP (Total unmitigated Damage)"  .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPCAnyLevel"]

L["HasteRanged"] = "rHaste"
L["HasteRangedMenu"] = "Haste"
L["HasteRangedDescription"] = L["TipsAndInfo"] .. "Haste bonus percentage from abilities procs, enchants\ntalents, trinkets, consumables, and buffs"

L["rangedSpeed"] = "rAtk"
L["rangedSpeedMenu"] = "Attack Speed"
L["rangedSpeedDescription"] = L["TipsAndInfo"] .. "Weapon speed of the equipped range weapon"

L["RangedMiss"] = "rMiss"
L["RangedMissMenu"] = "Miss Chance"
L["RangedMissDescription"] = L["SinLive"] .. "Miss chance with range weapons against an NPC of +3 levels" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPC1to5"]

L["SpellHit"] = "Spell Hit"
L["SpellHitMenu"] = "Hit"
L["SpellHitDescription"] = L["TipsAndInfo"] .. "Spell-specific Hit Talents are colored"

L["HasteCaster"] = "Spell Haste"
L["HasteCasterMenu"] = "Haste"
L["HasteCasterDescription"] = L["TipsAndInfo"] .. "Haste bonus percentage from abilities procs,\ntalents, trinkets, consumables and buffs"

L["SpellPenetration"] = "Spell Pen"
L["SpellPenetrationMenu"] = "Penetration"
L["SpellPenetrationDescription"] = L["TipsAndInfo"] .. "Penetration of Spells. Amount of resistance reduced."

L["SpellMiss"] = "Spell Miss"
L["SpellMissMenu"] = "Miss Chance"
L["SpellMissDescription"] = L["SinLive"] .. "Chance to miss with spells" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPC1to5"]

L["ManaRegen"] = "MP2"
L["ManaRegenMenu"] = "Mana Regen"
L["ManaRegenDescription"] = L["TipsAndInfo"] .. "Mana Regeneration per tick (every 2 secs), also known as MP2 (outside 5-sec rule). \nIt reflects the mana bar regeneration"

L["MP5"] = "MP5"
L["MP5Menu"] = "MP5"
L["MP5Description"] = L["TipsAndInfo"] .. "Mana Regeneration per 5 seconds, also known as MP5"

L["Resilience"] = "Resilience"
L["ResilienceMenu"] = "Resilience"
L["ResilienceDescription"] = L["TipsAndInfo"] .. "Reduces periodic damage and chance to be critically hit\nReduces the effect of mana-drains and the damage of critical strikes"

L["Armor"] = "Armor"
L["ArmorMenu"] = "Armor"
L["ArmorDescription"] = L["TipsAndInfo"] .. "Effective Armor, including all modifiers\nA red |cffC41E3AArmor|r value indicates that you are affected by a debuff related to this stat"	

L["Stamina"] = "Stamina"
L["StaminaMenu"] = "Stamina"
L["StaminaDescription"] = ""

L["NPCArmor"] = "Boss Armor"
L["NPCArmorMenu"] = "Boss Armor"
L["NPCArmorDescription"] = L["SinLive"] .. "Armor value of a Raid Boss NPC of up to +3 levels.\nA target must be selected to see its armor value\n" .. L["ScalingText"] .."\n".. L["NPCPlus3"] .."\n".. L["SunderArmor"] .."\n".. L["ExposeArmor"] .."\n".. L["FaerieFire"] .."\n".. L["CurseOfReck"] .."\n".. L["ArmorShatter"]

L["DMGReduc"] = "Mitigation"
L["DMGReducMenu"] = "Mitigation"
L["DMGReducDescription"] = L["SinLive"] .. "Percentage of damage reduction against an NPC of +3 levels" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPCAnyLevel"]

L["Defense"] = "Defense"
L["DefenseMenu"] = "Defense"
L["DefenseDescription"] = L["TipsAndInfo"] .. "Displays the effective Defense skills. Includes all +Defense sources"

L["Dodge"] = "Dodge"
L["DodgeMenu"] = "Dodge"
L["DodgeDescription"] = L["TipsAndInfo"] .. "Displays the chance to Dodge an attack. Includes all Dodge rating sources"

L["Parry"] = "Parry"
L["ParryMenu"] = "Parry"
L["ParryDescription"] = L["TipsAndInfo"] .. "Displays the chance to Parry an attack. Includes all Parry rating sources"

L["Block"] = "Block"
L["BlockMenu"] = "Block"
L["BlockDescription"] = L["TipsAndInfo"] .. "Displays the chance to Block an attack. Includes all Block rating sources"

L["FireResist"] = "Fire+"
L["FireResistMenu"] = "Fire"
L["FireResistDescription"] = L["TipsAndInfo"] .. "Displays the resistance value of the Fire school of magic from all sources"

L["FrostResist"] = "Frost+"
L["FrostResistMenu"] = "Frost"
L["FrostResistDescription"] = L["TipsAndInfo"] .. "Displays the resistance value of the Frost school of magic from all sources"

L["NatureResist"] = "Nature+"
L["NatureResistMenu"] = "Nature"
L["NatureResistDescription"] = L["TipsAndInfo"] .. "Displays the resistance value of the Nature school of magic from all sources"

L["ShadowResist"] = "Shadow+"
L["ShadowResistMenu"] = "Shadow"
L["ShadowResistDescription"] = L["TipsAndInfo"] .. "Displays the resistance value of the Shadow school of magic from all sources"

L["ArcaneResist"] = "Arcane+"
L["ArcaneResistMenu"] = "Arcane"
L["ArcaneResistDescription"] = L["TipsAndInfo"] .. "Displays the resistance value of the Arcane school of magic from all sources"

L["Speed"] = "Speed"
L["SpeedMenu"] = "Speed"
L["SpeedDescription"] = L["TipsAndInfo"] .. "The current movement speed of your character, in real-time.\nA red |cffC41E3ASpeed|r value indicates that you are affected by a slowing\neffect or moving at a slower speed than normal"

L["TargetSpeed"] = "Target Speed"
L["TargetSpeedMenu"] = "Target Speed"
L["TargetSpeedDescription"] = L["SinLive"] .. "The current movement speed of your target, in real-time"

L["Durability"] = "Durability"
L["DurabilityMenu"] = "Durability"
L["DurabilityDescription"] = L["TipsAndInfo"] .. "Durability percentage of your currently equipped gear and weapons"

L["BuffCounter"] = "Buffs"
L["BuffCounterMenu"] = "Player Buffs"
L["BuffCounterDescription"] = L["TipsAndInfo"] .. "Displays the total number of beneficial auras applied to you"

L["DebuffCounter"] = "Deduffs"
L["DebuffCounterMenu"] = "Player Debuffs"
L["DebuffCounterDescription"] = L["SinLive"] .. "Displays the total number of non-beneficial auras (debuffs) applied to your current target\n" .. L["ScalingText"] .. "Targeted NPC"

L["Lag"] = "Lag"
L["LagMenu"] = "Latency"
L["LagDescription"] = L["TipsAndInfo"] .. "Latency from home computer to Blizzard server in milliseconds"

L["FPS"] = "FPS"
L["FPSMenu"] = "Framerate"
L["FPSDescription"] = L["TipsAndInfo"] .. " Frames per second [FPS]"

L["Travel"] = "Distance"
L["TravelMenu"] = "Travel"
L["TravelDescription"] = L["TipsAndInfo"] .. "Total distance traveled\n\nTracking is disabled inside instances"

L["Jump"] = "Jumps"
L["JumpMenu"] = "Jump!"
L["JumpDescription"] = L["TipsAndInfo"] .. "Make your Jumps meaningful and count them!"

L["CombatTimer"] = "Combat"
L["CombatTimerMenu"] = "Combat Timer"
L["CombatTimerDescription"] = L["TipsAndInfo"] .. "Displays the time spent in combat.\nResets when entering combat again"

L["InstanceTimer"] = "Instance"
L["InstanceTimerMenu"] = "Instance Timer"
L["InstanceTimerDescription"] = L["TipsAndInfo"] .. "Displays elapsed time inside a dungeon or raid.\nStarts when entering the instance.\nStops when leaving or upon completion"

L["MobCounter"] = "Mobs"
L["MobCounterMenu"] = "Mob Counter"
L["MobCounterDescription"] = L["TipsAndInfo"] .. "Number of hostile NPCs near you\n\nUses nameplate detection"

L["KillCounter"] = "Kills"
L["KillCounterMenu"] = "Kill Counter"
L["KillCounterDescription"] = L["TipsAndInfo"] .. "Count kills from nearby NPCs and players\n\nUses nameplate detection"

L["EnemiesSlain"] = "Slain"
L["EnemiesSlainMenu"] = "Enemies Slain"
L["EnemiesSlainDescription"] = L["TipsAndInfo"] .. "Counts enemies you (or your party) kill\n\nUses the PARTY_KILL event"

L["Money"] = "Gold"
L["MoneyMenu"] = "Gold"
L["MoneyDescription"] = L["TipsAndInfo"] .. "Total gold in your character's possession"

L["Guild"] = "Guild"
L["GuildMenu"] = "Guild"
L["GuildDescription"] = L["TipsAndInfo"] .. "Number of guild members currently online"

L["Friends"] = "Friends"
L["FriendsMenu"] = "Friends"
L["FriendsDescription"] = L["TipsAndInfo"] .. "Number of friends currently online"


-- Sub Options
L["OptionsTip"] = ""
L["Show"] = "Show"
L["SameLevel"] = "Same Level"
L["BossLevel"] = "Boss Level"
L["Regen"] = "Normal Regen"
L["Casting"] = "Combat"
L["Both"] = "Both"
L["Display_Total"] = "Show Total"
L["Yards"] = "Yards"
L["Kilometers"] = "Kilometers"
L["Yards_KMTooltip"] = Ns.Colors.Green .. "Yards|r\n" .. "Displays the distance traveled \nin yards\n\n" .. Ns.Colors.Green .. "Kilometers|r\n" .. "Displays the distance traveled \nin kilometers"
L["NPC"] = "NPC"
L["Players"] = "Players"
L["NPC_PlayersTooltip"] = Ns.Colors.Green .. "NPC|r\n" .. "Displays NPC kills only\n\n" .. Ns.Colors.Green .. "Players|r\n" .. "Displays player kills only\n\n" .. Ns.Colors.Green .. "Both|r\n" .. "Displays total kills from\nNPCs and players combined"
L["Reset_Login"] = "Reset on Login"
L["Reset_LoginTooltip"] = "When enabled, the counter will\nreset each time you log in"
L["Reset_Counter"] = "Reset"
L["Reset_CounterConfirm"] = "Reset this counter?"
L["Combat_Color"] = "Combat Color"
L["Combat_ColorTooltip"] = "Colors the timer text red\nwhen in combat"
L["Timer_Format"] = "Format"
L["Timer_FormatTip"] = ""
L["Send_Chat"] = "Send to chat"
L["Send_ChatTooltip"] = Ns.Colors.Green .. "Send to chat|r\n" .. "Send the completion time to\ninstance chat when complete"
L["Editbox_MobRange"] = "Range"
L["Editbox_MobRangeTooltip"] = "Set the detection range in yards\n\n0 = all visible nameplates"
L["BNet"] = "BattleNet"
L["Realm"] = "Realm"

L["Color_Effect"] = "Color effect"
L["Color_EffectTip"] = ""
L["Color_EffectTooltip"] = Ns.Colors.Green .. "Color Effect|r\n" .. "Automatically color stat values \nbased on thresholds or conditions"
L["Display_SimulateTooltip"] = Ns.Colors.Green .. "Simulate|r\n" .. "Shows your stat value gathered \nfrom your actual numbers done \nin combat \n\nThe simulated value resets upon \nentering combat and doing damage \nagain"
L["Display_Simulate"] = "Simulate"
L["Display_SimulateTip"] = ""
L["Display_Basic"] = "Basic"
L["Display_BasicTip"] = ""
L["Display_BasicTooltip"] = Ns.Colors.Green .. "Basic|r\n" .. "Displays the stat as shown on the \ncharacter panel, without additions \nand may not be the most accurate"


L["Display_Rating"] = "Rating"

-- Decimals
L["Decimals_Default"] = "Number Break Place"
L["Decimals_DefaultTip"] = ""
L["Decimals_Two"] = "Rounding decimals"
L["Decimals_TwoTip"] = ""

-- Caps
L["Cap_Hit"] = "Hit cap"
L["Cap_HitTooltip"] = Ns.Colors.Green .. "Hit Cap|r\n" .. "Set the value of your stat's soft \nor hard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nDefault cap: " .. Ns.Colors.Green .. "9%"
L["Cap_Melee_Exp"] = "Expertise cap"
L["Cap_Melee_ExpTooltip"] = Ns.Colors.Green .. "Expertise Cap|r\n" .. "Set the value of your stat's soft \nor hard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nDefault cap: " .. Ns.Colors.Green .. "103"
L["Cap_Percent"] = "Percentage cap"
L["Cap_PercentTooltip"] = Ns.Colors.Green .. "Percentage Cap|r\n" .. "Set the value of your stat's soft \nor hard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nDefault cap: " .. Ns.Colors.Green .. "100%"
L["Cap_Spell_Hit"] = "Hit cap"
L["Cap_Spell_HitTooltip"] = Ns.Colors.Green .. "Hit Cap|r\n" .. "Set the value of your stat's soft \nor hard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nDefault cap: " .. Ns.Colors.Green .. "16%"
L["Cap_Def_Def"] = "Defense cap"
L["Cap_Def_DefTooltip"] = Ns.Colors.Green .. "Defense Cap|r\n" .. "Set the value of your stat's soft \nor hard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nDefault cap: " .. Ns.Colors.Green .. "490"
L["Cap_Def_Armor"] = "Armor cap"
L["Cap_Def_ArmorTooltip"] = Ns.Colors.Green .. "Armor Cap|r\n" .. "Set the value of your stat's soft \nor hard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nDefault cap: " .. Ns.Colors.Green .. "35,880"
L["Cap_Def_Mit"] = "Mitigation cap"
L["Cap_Def_MitTooltip"] = Ns.Colors.Green .. "Mitigation Cap|r\n" .. "Set the value of your stat's soft \nor hard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nDefault cap: " .. Ns.Colors.Green .. "75%"
L["Cap_Rating"] = "Rating cap"
L["Cap_RatingTooltip"] = Ns.Colors.Green .. "Rating cap|r\n" .. "Set the rating of your soft or \nhard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nSet value to 0 to disable cap \ncolors"
L["Cap_Ehp"] = "EHP cap"
L["Cap_EhpTooltip"] = Ns.Colors.Green .. "Effective HP Cap|r\n" .. "Set the value of your stat's soft \nor hard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nDefault cap: " .. Ns.Colors.Green .. "54,000"

-- Decimals
L["Decimals_Default"] = "Number Break Place"
L["Decimals_DefaultTip"] = ""
L["Decimals_Two"] = "Rounding decimals"
L["Decimals_TwoTip"] = ""

-- Stat Bars
L["StaticBar"] = "Static"
L["StaticBarTooltip"] = Ns.Colors.Green .. "Static|r\n" .. "Enables a static background bar \nbehind each stat for cosmetic \npurposes \n\nDynamic bars take priority when \nboth are enabled"
L["ShowBar"] = "Dynamic"
L["ShowBarTooltip"] = Ns.Colors.Green .. "Dynamic|r\n" .. "Enables status bars that fill based \non the stat's value towards a \nset max value"

