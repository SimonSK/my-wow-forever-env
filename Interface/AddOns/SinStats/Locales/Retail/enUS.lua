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

-- HUD
L["SettingsDescription"] = ""
L["HideHUD"] = "Hide"
L["HideHUDTip"] = ""
L["LockHUD"] = "Lock"
L["LockHUDTip"] = ""
L["PanelMenu"] = "Character Panel"
L["PanelDisplay"] = "Attach"
L["PanelDisplayTip"] = ""
L["PanelAttach"] = "Anchor"
L["PanelAttachTooltip"] = Ns.Colors.Green .. "Anchor |r\n" .. "Anchor the HUD to the right " .. "\nside of the character panel|r"
L["PanelAttachX"] = "Anchor offset X"
L["PanelAttachY"] = "Anchor offset Y"
L["ConfigShortcut"] = "Settings icon"
L["ConfigShortcutTooltip"] = ""
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
L["GrowDirection"] = "Grow direction"
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
L["HideText"] = "Hide labels"
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
L["GlobalBar_QuickBars"] = "Quick bars"
L["QuickBars_EnableDynamic"] = "Enable all dynamic bars"
L["QuickBars_ConfirmEnableDynamic"] = "Enable dynamic bars for every stat in this group?"
L["QuickBars_EnableStatic"] = "Enable all static bars"
L["QuickBars_ConfirmEnableStatic"] = "Enable static bars for every stat in this group?"
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
L["ProfilesHint"] = "Create and manage your profiles | Setup spec-specific profiles"

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
L["BarHeight"] = "Bar height"
L["BarHeightTip"] = ""
L["BarHeightTooltip"] = Ns.Colors.Green .. "Bar Height|r\nSet the status bar height in pixels. 0 means automatic: the bar fills the stat row"
L["BarBgColor"] = "Background color"
L["BarBgColorTip"] = ""
L["BarBgAlpha"] = ""
L["BarBgAlpha"] = "Background opacity"
L["BarBgAlphaTip"] = ""
L["BarAutoColor"] = "Progression color"
L["BarReverse"] = "Reverse"
L["BarReverseTooltip"] = Ns.Colors.Green .. "Reverse|r\n" .. "Fill the bar from the right edge \ninstead of the left. \n\nOnly affects dynamic bars"
L["BarInvert"] = "Invert"
L["BarInvertTooltip"] = Ns.Colors.Green .. "Invert|r\n" .. "Fill the bar as the value decreases, \nshowing what is missing instead of \nthe current amount. \n\nOnly affects dynamic bars"
L["BarAutoColorTooltip"] = Ns.Colors.Green .. "Progression Color|r\n" .. "Automatically color the bar from \nred (empty) to green (full) gradient"
L["AutoColorOff"] = "Disable gradient text"
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


-----------------------------------------
---       Expansion sub options       ---
-----------------------------------------

L["Enhanced_BaseTooltip"] = Ns.Colors.Green .. "Enhanced|r\n" .. "Provides the best accuracy by adding \ntalents, buffs, debuffs, flasks, gems, \nenchants and other sources \n\n" .. Ns.Colors.Green .. "Basic|r\n" .. "Displays the stat as is, without additions \nand may not be the most accurate"
L["Percent_RatingTooltip"] = Ns.Colors.Green .. "Percentage|r\n" .. "Displays the stat in percentage \n\n" .. Ns.Colors.Green .. "Rating|r\n" .. "Displays the rating value"
L["Regen_Normal_CastingTooltip"] = Ns.Colors.Green .. "Normal|r\n" .. "Mana regeneration while not casting \n\n" .. Ns.Colors.Green .. "Casting|r\n" .. "Mana regeneration while casting"
L["World_RealmTooltip"] = Ns.Colors.Green .. "Realm|r\n" .. "Average latency from your computer to \nthe Blizzard server in milliseconds\n\n" .. Ns.Colors.Green .. "World|r\n" .. "In-game latency from your computer to \nthe Game World"
L["Melee_RangedTooltip"] = Ns.Colors.Green .. "Melee|r\n" .. "Displays your melee weapon value \n\n" .. Ns.Colors.Green .. "Ranged|r\n" .. "Displays your ranged weapon value"
L["Equipped_OverallTooltip"] = Ns.Colors.Green .. "Equipped|r\n" .. "Average item level of your \nequipped gear \n\n" .. Ns.Colors.Green .. "Max|r\n" .. "Max item level of all your \ngear, including in bags"
L["Max_Average_DamageTooltip"] = Ns.Colors.Green .. "Max, Average and Low|r\n" .. "Displays your full damage range"
L["Damage_TakenTooltip"] = Ns.Colors.Green .. "Offense|r\n" .. "Increase in damage and healing done \n\n" .. Ns.Colors.Green .. "Defense|r\n" .. "Reduction in damage taken"
L["Show_Proc"] = "Live Proc"
L["Show_ProcTooltip"] = Ns.Colors.Green .. "Live Proc|r\n" .. "Shows the combat rating proc bonus as a \n+value next to the cached total when stat \nvalues are secret during combat"
L["Level_HonorPointsTooltip"] = Ns.Colors.Green .. "Level|r\n" .. "Your current Honor level \n\n" .. Ns.Colors.Green .. "Points|r\n" .. "Your total honor earned"
L["Speed_StaticTooltip"] = Ns.Colors.Green .. "Real-time|r\n" .. "Displays the movement speed of your character's \nevery movement, in real-time (Standing, running, \nswimming, flying, RP walking, Skyriding etc.) \n\n" .. Ns.Colors.Green .. "Static|r\n" .. "Your character's movement speed is static and \nwill change only when traveling methods change \nor speed value increases"
L["Normal_EnchantedTooltip"] = Ns.Colors.Green .. "Normal|r\n" .. "Displays the item's total quantity, including \nin your bags and bank \n\n" .. Ns.Colors.Green .. "Enchanted|r\n" .. "Displays the Enchanted item's quantity, \nincluding in your bags and bank"
L["Season_ExpTooltip"] = Ns.Colors.Green .. "Season|r\n" .. "Displays your Mythic+ rating of \nthe current season \n\n" .. Ns.Colors.Green .. "Expansion|r\n" .. "Displays your best Mythic+ rating \nof the current expansion"
L["Splint_SparkTooltip"] = Ns.Colors.Green .. "Spark|r\n" .. "Displays the total quantity of \nSpark of Fortunes \n\n" .. Ns.Colors.Green .. "Dust|r\n" .. "Displays the total quantity of \nFractured Sparks obtained"
L["Current_EarnedTooltip"] = Ns.Colors.Green .. "Current|r\n" .. "Displays the current quantity \n\n" .. Ns.Colors.Green .. "Earned|r\n" .. "Displays the total earned \nthis season"
L["Empty_VintageTooltip"] = Ns.Colors.Green .. "Empty|r\n" .. "Displays the quanity of \nEmpty Kaja'Cola Cans \n\n" .. Ns.Colors.Green .. "Vintage|r\n" .. "Displays the quantity of \nVintage Kaja'Cola Cans"
L["Core_ShardTooltip"] = Ns.Colors.Green .. "Core|r\n" .. "Displays the total quantity \nof void cores  \n\n" .. Ns.Colors.Green .. "Shard|r\n" .. "Displays the total quantity \nof void shards"
L["Key_NameTooltip"] = ""
L["Myth_HeroTooltip"] = Ns.Colors.Green .. "Mythical|r\n" .. "Displays the total quantity \nof Mythical Soul Fragment  \n\n" .. Ns.Colors.Green .. "Hero|r\n" .. "Displays the total quantity \nof Heroic Soul Fragment"

L["Core"] = "Core"
L["Shard"] = "Shard"
L["Spec_HeroTooltip"] = ""

L["Display_AverageTooltip"] = Ns.Colors.Green .. "Average|r\n" .. "Switches from maximum to \naverage values"
L["Display_BasicTooltip"] = Ns.Colors.Green .. "Basic|r\n" .. "Displays the stat as is, without additions \nand may not be the most accurate"
L["Display_RatedTooltip"] = Ns.Colors.Green .. "Rated|r\n" .. "Displays your rated Honor"
L["Display_MainHandTooltip"] = Ns.Colors.Green .. "Main-Hand Only|r\n" .. "Disables the automatic \ndisplay of the Off-hand \nvalue if applicable"
L["Hide_ReputationTooltip"] = Ns.Colors.Green .. "Hide Maxed Reputation|r\n" .. "Hides the Renown level of a faction \nwhen maxed out"
L["Display_PercentageTooltip"] = Ns.Colors.Green .. "Progression|r\n" .. "Displays the progression percentage"
L["Rank_RepTooltip"] = Ns.Colors.Green .. "Rank|r\n" .. "Displays the rank \n\n" .. Ns.Colors.Green .. "Rep|r\n" .. "Displays the reputation value"
L["Display_MythicBestTooltip"] = Ns.Colors.Green .. "Top score|r\n" .. "Displays your top Mythic+ score of the current expansion"
L["Display_MaxTooltip"] = Ns.Colors.Green .. "Cap color|r\n" .. "Colors your quantity in red \nwhen the weekly cap of this \ncurrency is reached"
L["Display_TotalTooltip"] = Ns.Colors.Green .. "Total|r\n" .. "Displays the total member count \nnext to the online count"
L["BNet_RealmTooltip"] = Ns.Colors.Green .. "BattleNet|r\n" .. "Displays online BattleNet friends \n\n" .. Ns.Colors.Green .. "Realm|r\n" .. "Displays online realm friends \n\n" .. Ns.Colors.Green .. "Both|r\n" .. "Displays both BattleNet and \nrealm friends online"


-- SinLive abilities
L["ScalingText"] = ""--Ns.Colors.Green .. "\nTarget Debuff Scaling |r\n"
L["ScalingText2"] = ""--Ns.Colors.Green .. "\nTarget Scaling: |r"
L["TipsAndInfo"] = "Tips and Info!|r\n\n"
L["SinLive"] = "SinLive™ Stat\nThis stat is interactive and scales with your target|r\n\n"
L["NPCAnyLevel"] = "Target level"
L["DefaultValueText"] = Ns.Colors.Green .. "\n\nDefault value:|r  "
L["NPCSameLevel"] = "Player level"

-- Stats
L["Primary"] = "Primary"
L["PrimaryMenu"] = "Primary"
L["PrimaryDescription"] = L["TipsAndInfo"] .. "Displays your spec's primary stat: " .. Ns.Colors.Green .. "Strength|r, " .. Ns.Colors.Green .. "Agility|r, or " .. Ns.Colors.Green .. "Intellect|r\n"

L["CritChance"] = "Crit"
L["CritChanceMenu"] = "Critical Strike"
L["CritChanceDescription"] = ""

L["Haste"] = "Haste"
L["HasteMenu"] = "Haste"
L["HasteDescription"] = ""

L["Mastery"] = "Mastery"
L["MasteryMenu"] = "Mastery"
L["MasteryDescription"] = ""

L["Versatility"] = "Versatility"
L["VersatilityMenu"] = "Versatility"
L["VersatilityDescription"] = ""

L["Avoidance"] = "Avoidance"
L["AvoidanceMenu"] = "Avoidance"
L["AvoidanceDescription"] = ""

L["Leech"] = "Leech"
L["LeechMenu"] = "Leech"
L["LeechDescription"] = ""

L["Strength"] = "Strength"
L["StrengthMenu"] = "Strength"
L["StrengthDescription"] = L["TipsAndInfo"] .. "A red " .. Ns.Colors.Red .. "Strength|r value indicates that you are affected by a debuff \n"

L["Agility"] = "Agility"
L["AgilityMenu"] = "Agility"
L["AgilityDescription"] = L["TipsAndInfo"] .. "A red " .. Ns.Colors.Red .. "Agility|r value indicates that you are affected by a debuff \n"

L["AP"] = "AP"
L["APMenu"] = "Attack Power"
L["APDescription"] = L["TipsAndInfo"] .. "A red " .. Ns.Colors.Red .. "Attack Power|r value indicates that you are affected by a debuff \n"

L["DMG"] = "Damage"
L["DMGMenu"] = "Damage"
L["DMGDescription"] = L["TipsAndInfo"] .. "A red " .. Ns.Colors.Red .. "Damage|r value indicates that you are affected by a debuff \n"

L["DPS"] = "DPS"
L["DPSMenu"] = "DPS"
L["DPSDescription"] = ""

L["DMGMod"] = "DMG+"
L["DMGModMenu"] = "Damage Bonus"
L["DMGModDescription"] = ""

L["weaponSpeed"] = "Atk Speed"
L["weaponSpeedMenu"] = "Weapon Speed"
L["weaponSpeedDescription"] = L["TipsAndInfo"] .. "This stat automatically detects your weapon type and display its value accordingly"

L["EnergyRegen"] = "Energy"
L["EnergyRegenMenu"] = "Energy Regen"
L["EnergyRegenDescription"] = ""

L["Stamina"] = "Stamina"
L["StaminaMenu"] = "Stamina"
L["StaminaDescription"] = L["TipsAndInfo"] .. "A red " .. Ns.Colors.Red .. "Stamina|r value indicates that you are affected by a debuff"

L["Mitigation"] = "DR"
L["MitigationMenu"] = "Mitigation"
L["MitigationDescription"] = L["SinLive"] .. "Damage Reduction against attackers of all levels \n" .. L["DefaultValueText"] .. L["NPCAnyLevel"]

L["Armor"] = "Armor"
L["ArmorMenu"] = "Armor"
L["ArmorDescription"] = L["TipsAndInfo"] .. "A red " .. Ns.Colors.Red .. "Armor|r value indicates that you are affected by a debuff"

L["Dodge"] = "Dodge"
L["DodgeMenu"] = "Dodge"
L["DodgeDescription"] = ""

L["Parry"] = "Parry"
L["ParryMenu"] = "Parry"
L["ParryDescription"] = ""

L["Block"] = "Block"
L["BlockMenu"] = "Block"
L["BlockDescription"] = ""

L["Absorb"] = "Absorb"
L["AbsorbMenu"] = "Absorb"
L["AbsorbDescription"] = ""

L["Health"] = "Health"
L["HealthMenu"] = "Health"
L["HealthDescription"] = L["TipsAndInfo"] .. "Displays your current and maximum health. The bar fills based on your health percentage."

L["Stagger"] = "Stagger"
L["StaggerMenu"] = "Stagger"
L["StaggerDescription"] = ""

L["Intellect"] = "Intellect"
L["IntellectMenu"] = "Intellect"
L["IntellectDescription"] = L["TipsAndInfo"] .. "A red " .. Ns.Colors.Red .. "Intellect|r text indicates that you are affected by a debuff \n"

L["SpellPower"] = "Spell"
L["SpellPowerMenu"] = "Spell Power"
L["SpellPowerDescription"] = ""

L["DMGModSpell"] = "Spell+"
L["DMGModSpellMenu"] = "Damage Bonus"
L["DMGModSpellDescription"] = L["TipsAndInfo"] .. "Spell damage bonus"

L["Healing"] = "Healing"
L["HealingMenu"] = "Healing Power"
L["HealingDescription"] = ""

L["ManaRegen"] = "Mana"
L["ManaRegenMenu"] = "Mana Regen"
L["ManaRegenDescription"] = ""

L["Durability"] = "Dura"
L["DurabilityMenu"] = "Durability"
L["DurabilityDescription"] = L["TipsAndInfo"] .. "Durability percentage of your currently equipped gear and weapons"

L["RepairCost"] = "Repair"
L["RepairCostMenu"] = "Repair Cost"
L["RepairCostDescription"] = L["TipsAndInfo"] .. "Total repair cost"

L["Speed"] = "Speed"
L["SpeedMenu"] = "Speed"
L["SpeedDescription"] = L["TipsAndInfo"] .. "Your character's movement speed in real-time, including your " .. Ns.Colors.Green .. "Skyriding speed|r.\n\nA red " .. Ns.Colors.Red .. "Speed|r value indicates that you are affected by slowing effects or moving at a slower speed than normal"

L["Zuljarra"] = "Zuljarra"
L["ZuljarraMenu"] = "Zul'jarra's Forces"
L["ZuljarraDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.ZuljarraLink

L["Tokka"] = "Tokka"
L["TokkaMenu"] = "Captain Tokka"
L["TokkaDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.TokkaLink

L["Silvermoon"] = "Silvermoon"
L["SilvermoonMenu"] = "Silvermoon Court"
L["SilvermoonDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.SilverLink

L["Amani"] = "Amani"
L["AmaniMenu"] = "Amani Tribe"
L["AmaniDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.AmaniLink

L["Arati"] = "Hara'ti"
L["AratiMenu"] = "Hara'ti"
L["AratiDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.AratiLink

L["Singularity"] = "Singularity"
L["SingularityMenu"] = "The Singularity"
L["SingularityDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.SingLink

L["Slayer"] = "Slayer"
L["SlayerMenu"] = "Slayer's Duellum"
L["SlayerDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.SlayerLink

L["Prey"] = "Prey"
L["PreyMenu"] = "Prey: Season 2"
L["PreyDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.PreyLink

L["TargetSpeed"] = "Target Speed"
L["TargetSpeedMenu"] = "Target Speed"
L["TargetSpeedDescription"] = L["TipsAndInfo"] .. "The current movement speed of your target, in real-time\n\n" .. Ns.Colors.Red .. "Speed|r value in red indicates that your target is affected by slowing effects or moving at a slower speed than normal"

L["ItemLevel"] = "iLevel"
L["ItemLevelMenu"] = "Item Level"
L["ItemLevelDescription"] = L["TipsAndInfo"] .. "Average item level"

L["Threat"] = "Threat"
L["ThreatMenu"] = "Threat"
L["ThreatDescription"] = L["SinLive"] .. "Threat against current target in percentage, value or both"

L["PvPiLvl"] = "PvP iLvl"
L["PvPiLvlMenu"] = "PvP Item Level"
L["PvPiLvlDescription"] = L["TipsAndInfo"] .. "Player vs player item level"

L["GlobalCD"] = "Gcd"
L["GlobalCDMenu"] = "Global CD"
L["GlobalCDDescription"] = L["TipsAndInfo"] .. "Global cooldown"

L["BloodyTokens"] = "Bloody"
L["BloodyTokensMenu"] = "Bloody Tokens"
L["BloodyTokensDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.BloodyLink

L["Honor"] = "Honor"
L["HonorMenu"] = "Honor"
L["HonorDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.HonorLink

L["Adventurer"] = "Adventurer"
L["AdventurerMenu"] = "Adventurer"
L["AdventurerDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AdventurerLink

L["Veteran"] = "Veteran"
L["VeteranMenu"] = "Veteran"
L["VeteranDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VeteranLink

L["Champion"] = "Champion"
L["ChampionMenu"] = "Champion"
L["ChampionDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.ChampLink

L["Hero"] = "Hero"
L["HeroMenu"] = "Hero"
L["HeroDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.HeroLink

L["Myth"] = "Myth"
L["MythMenu"] = "Myth"
L["MythDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.MythLink

L["Stash"] = "Stash"
L["StashMenu"] = "Gilded Stash"
L["StashDescription"] = L["TipsAndInfo"] .. "Displays the quantity of looted " .. Ns.StashLink

-- L["LoveToken"] = "Love"
-- L["LoveTokenMenu"] = "Love Token"
-- L["LoveTokenTip"] = ""
-- L["LoveTokenDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.LoveLink

-- L["Puzzling"] = "Chip"
-- L["PuzzlingMenu"] = "Cartel Chip"
-- L["PuzzlingTip"] = ""
-- L["PuzzlingDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.PuzzlingLink

L["Catalyst"] = "Catalyst"
L["CatalystMenu"] = "Catalyst"
L["CatalystDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CatalystLink

L["CofferKey"] = "Shards"
L["CofferKeyMenu"] = "Key Shards"
L["CofferKeyDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CofferLink

L["RestoredKey"] = "Keys"
L["RestoredKeyMenu"] = "Coffer Keys"
L["RestoredKeyDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.RestoredKeyLink

L["Undercoin"] = "Coin"
L["UndercoinMenu"] = "Undercoin"
L["UndercoinDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CoinLink

L["Corrosive"] = "Corrosive"
L["CorrosiveMenu"] = "Corrosive Coin"
L["CorrosiveDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CorrosiveLink

L["CorroSoul"] = "Soul"
L["CorroSoulMenu"] = "Corrosive Soul"
L["CorroSoulDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CorroSoulLink .. "Corrosive Soul"

L["Ossified"] = "Ossified"
L["OssifiedMenu"] = "Ossified"
L["OssifiedDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.OssifiedLink .. "Ossified Relic"

L["Venom"] = "Venom"
L["VenomMenu"] = "Venom-Cursed"
L["VenomDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VenomLink .. "Venom-Cursed Fragments"

L["VoidVestige"] = "Vestige"
L["VoidVestigeMenu"] = "Void Vestige"
L["VoidVestigeDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VoidVestigeLink .. "Void Vestige"

L["Brewfest"] = "Brewfest"
L["BrewfestMenu"] = "Brewfest Token"
L["BrewfestDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.BrewfestLink .. "Brewfest Prize Token"

L["ManaCrystals"] = "Mana"
L["ManaCrystalsMenu"] = "Mana-Crystals"
L["ManaCrystalsDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.ManaLink

L["Spark"] = "Spark"
L["SparkMenu"] = "Crafting Spark"
L["SparkDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.SparkLink .. "Spark of Tides"

L["Anguish"] = "Anguish"
L["AnguishMenu"] = "Anguish"
L["AnguishDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AnguishLink

L["Illusionary"] = "Illusionary"
L["IllusionaryMenu"] = "Illusionary"
L["IllusionaryDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.IllusionaryLink

L["Accolade"] = "Accolade"
L["AccoladeMenu"] = "Field Accolade"
L["AccoladeDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AccoladeLink

L["DarkParticle"] = "Particle"
L["DarkParticleMenu"] = "Dark Particle"
L["DarkParticleDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.DarkParticleLink .. "Dark Particle"

L["CoiledFil"] = "Coiled"
L["CoiledFilMenu"] = "Coiled Filament"
L["CoiledFilDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CoiledFilLink

L["AnglerPearls"] = "Angler Pearls"
L["AnglerPearlsMenu"] = "Angler Pearls"
L["AnglerPearlsDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AnglerPearlsLink

L["Voidcore"] = "Voidcore"
L["VoidcoreMenu"] = "Voidcore"
L["VoidcoreDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VoidcoreLink

L["Ascendant"] = "Venom"
L["AscendantMenu"] = "Venomstones"
L["AscendantDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AscendantLink .. "Ascendant Venomstone"

L["GalacticVoid"] = "Galactic"
L["GalacticVoidMenu"] = "Galactic Void"
L["GalacticVoidDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.GalacticVoidLink .. "Galactic Void"

L["Ritual"] = "Ritual"
L["RitualMenu"] = "Ritual Sites"
L["RitualDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.RitualLink

L["Kindojan"] = "Kindo'jan"
L["KindojanMenu"] = "Labyrinth Kindo'jan"
L["KindojanDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.KindojanLink

L["Mythical"] = "Soul"
L["MythicalMenu"] = "Soul Fragment"
L["MythicalDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.MythicalLink .. "Mythical and Heroic Soul Fragment"

L["Abundance"] = "Abundance"
L["AbundanceMenu"] = "Abundance"
L["AbundanceDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AbundLink

L["AqirToken"] = "Aqir"
L["AqirTokenMenu"] = "Aqir Token"
L["AqirTokenDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AqirLink .. "Aqir Research Token"

L["Aqir"] = "Aqir"
L["AqirMenu"] = "Aqir Enclave"
L["AqirDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AqirRepLink

L["VoidSample"] = "Void Sample"
L["VoidSampleMenu"] = "Void Sample"
L["VoidSampleDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VoidSampleLink

L["Luminous"] = "Luminous"
L["LuminousMenu"] = "Luminous"
L["LuminousDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.LuminousLink

L["Skyshards"] = "Skyshards"
L["SkyshardsMenu"] = "Skyshards"
L["SkyshardsDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.SkyshardsLink .. "Mysterious Skyshards"

L["VileEssence"] = "Essence"
L["VileEssenceMenu"] = "Vile Essence"
L["VileEssenceDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VileEssenceLink .. "Vile Essence"

L["Dundun"] = "Dundun"
L["DundunMenu"] = "Dundun"
L["DundunDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.DundunLink

L["Voidlight"] = "Voidlight"
L["VoidlightMenu"] = "Voidlight"
L["VoidlightDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VoidlightLink

L["Arcana"] = "Arcana"
L["ArcanaMenu"] = "Arcana"
L["ArcanaDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.ArcanaLink

L["MarkHonor"] = "Marks"
L["MarkHonorMenu"] = "Mark of Honor"
L["MarkHonorDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.MarkHonorLink .. "Mark of Honor"

L["ValorPoints"] = "Valor"
L["ValorPointsMenu"] = "Valor"
L["ValorPointsDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.ValorPvPLink

L["Conquest"] = "Conquest"
L["ConquestMenu"] = "Conquest"
L["ConquestDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.ConqLink

L["Timewarped"] = "Timewarped"
L["TimewarpedMenu"] = "Timewarped"
L["TimewarpedDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.TimeLink

L["TraderTender"] = "Tender"
L["TraderTenderMenu"] = "Trader's Tender"
L["TraderTenderDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.TenderLink

L["Darkmoon"] = "Darkmoon"
L["DarkmoonMenu"] = "Darkmoon"
L["DarkmoonDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.DarkmoonLink

L["Coupons"] = "Coupons"
L["CouponsMenu"] = "Coupons"
L["CouponsDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CouponsLink

-- L["Delves"] = "World"
-- L["DelvesMenu"] = "Great Vault: World"
-- L["DelvesTip"] = ""
-- L["DelvesDescription"] = L["TipsAndInfo"] .. "Displays the number of completed Delves, Prey and World activities in the Great Vault \nSelect the Tier to track or track only Tier 8 completed runs and above \n\nPrey completion is included. Nightmare level counts as Tier 8"

L["Delves"] = "Delves"
L["DelvesMenu"] = "Delves/Prey"
L["DelvesDescription"] = L["TipsAndInfo"] .. "Tracks the number of completed " .. Ns.Colors.Green .. "Delves, Prey, Ritual Sites and World activities|r runs for the current week \nby " .. Ns.Colors.Green .. "tier level\n\n|r" .. Ns.Colors.Green .. "Prey:|r Normal (Tier 1), Hardcore (Tier 5), Nightmare (Tier 8) \n\n" .. Ns.Colors.Green .. "Ritual Sites:|r Tier 1 = Tier 4 Reward, Tier 2 = Tier 6 Reward, Tier 3 = Tier 7 Reward, Tier 4 = Tier 12 Reward, Tier 5+ = Tier 13 Reward \n\n" .. Ns.Colors.Green .. "SinStats|r must be enabled for the tracking to work. \nData " .. Ns.Colors.Red .. "resets|r automatically each weekly reset"

L["Delver"] = "Delver"
L["DelverMenu"] = "Delves: Season 2"
L["DelverDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.DelverLink .. "Delves: Season 2"

L["Companion"] = "Valeera"
L["CompanionMenu"] = "Valeera Sanguinar"
L["CompanionDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CompanionLink .. "Valeera Sanguinar"

L["MythicPlus"] = "Mythic+"
L["MythicPlusMenu"] = "Mythic+ Rating"
L["MythicPlusDescription"] = L["TipsAndInfo"] .. "Displays your Mythic+ rating for the current season or your expansion's best rating"

L["Keystone"] = "Key"
L["KeystoneMenu"] = "Mythic Keystone"
L["KeystoneDescription"] = L["TipsAndInfo"] .. "Displays your current Mythic+ keystone level and/or name. \nUse the Abbreviate option to abbreviate the dungeon name"

L["GreatVault"] = "Vault"
L["GreatVaultMenu"] = "Great Vault"
L["GreatVaultDescription"] = L["TipsAndInfo"] .. "Displays how many Great Vault reward slots you have filled across all activity types (M+, Raid, PvP, World)"

L["Spec"] = "Spec"
L["SpecMenu"] = "Spec"
L["SpecDescription"] = L["TipsAndInfo"] .. "Displays your current spec and/or hero talent"

L["Loadout"] = "Loadout"
L["LoadoutMenu"] = "Loadout"
L["LoadoutDescription"] = L["TipsAndInfo"] .. "Displays your current talent loadout"

L["Lag"] = "Ping"
L["LagMenu"] = "Ping"
L["LagDescription"] = L["TipsAndInfo"] .. "Connection latency (Ping)"

L["FPS"] = "FPS"
L["FPSMenu"] = "FPS"
L["FPSDescription"] = L["TipsAndInfo"] .. "Frames per second [FPS]"

L["Coordinates"] = "Coords"
L["CoordinatesMenu"] = "Coordinates"
L["CoordinatesDescription"] = L["TipsAndInfo"] .. "Your current map coordinates (X, Y)"

L["Travel"] = "Distance"
L["TravelMenu"] = "Travel"
L["TravelDescription"] = L["TipsAndInfo"] .. "Total distance traveled\n\nTracking is disabled inside instances"

L["Jump"] = "Jumps"
L["JumpMenu"] = "Jump!"
L["JumpDescription"] = L["TipsAndInfo"] .. "Make your Jumps meaningful and count them!"

L["CombatTimer"] = "Combat"
L["CombatTimerMenu"] = "Combat Timer"
L["CombatTimerDescription"] = L["TipsAndInfo"] .. "Displays the time spent in combat.\nResets when entering combat again"

L["MobCounter"] = "Mobs"
L["MobCounterMenu"] = "Mob Counter"
L["MobCounterDescription"] = L["TipsAndInfo"] .. "Number of hostile NPCs near you\n\nUses nameplate detection"

L["KillCounter"] = "Kills"
L["KillCounterMenu"] = "Kill Counter"
L["KillCounterDescription"] = L["TipsAndInfo"] .. "Count kills from nearby NPCs and players\n\nUses nameplate detection"

L["EnemiesSlain"] = "Slain"
L["EnemiesSlainMenu"] = "Enemies Slain"
L["EnemiesSlainDescription"] = L["TipsAndInfo"] .. "Counts enemies you (or your party) kill\n\nUses the PARTY_KILL event (CLEU is no longer available to addons in 12.0.0)"

L["Gold"] = "Gold"
L["GoldMenu"] = "Money"
L["GoldDescription"] = L["TipsAndInfo"] .. "Total amount of money in your character's possession"

L["WowToken"] = "Token"
L["WowTokenMenu"] = "WoW Token"
L["WowTokenDescription"] = L["TipsAndInfo"] .. "Live value of the WoW Token in your region"

L["Guild"] = "Guild"
L["GuildMenu"] = "Guild"
L["GuildDescription"] = L["TipsAndInfo"] .. "Number of guild members currently online"

L["Friends"] = "Friends"
L["FriendsMenu"] = "Friends"
L["FriendsDescription"] = L["TipsAndInfo"] .. "Number of friends currently online"

------------------
--    Config    --
------------------

-- Categories


-- Settings Options
L["OptionsTip"] = "" --"|cffFFBD50" .. 
L["Show"] = "Show"
L["Enhanced"] = "Enhanced"
L["Base"] = "Basic"
L["Display_Rating"] = "Add rating"
L["Rating_Only"] = "Display rating only"
L["Damage"] = "Offense"
L["DamageTaken"] = "Defense"
L["World"] = "World"
L["Realm"] = "Realm"
L["Max"] = "Max"
L["Low"] = "Low"
L["Average"] = "Average"
L["Level"] = "Level"
L["Honor"] = "Points"
L["Both"] = "Both"
L["Player"] = "Player"
L["Party"] = "Party"
L["Player_PartyTooltip"] = Ns.Colors.Green .. "Player|r\n" .. "Count only kills landed by you \n\n" .. Ns.Colors.Green .. "Party|r\n" .. "Count only kills landed by your \nparty or raid members \n\n" .. Ns.Colors.Green .. "Both|r\n" .. "Count every PARTY_KILL event"
L["MainHand"] = "Main-Hand"
L["OffHand"] = "Off-Hand"
L["Live"] = "Real-time"
L["Static"] = "Static"
L["Speed_Unit"] = "Show unit"
L["Speed_UnitTooltip"] = Ns.Colors.Green .. "Show unit|r\n" .. "Add yd/s or km/h next to the speed \nvalue when Yards or Km display \nmode is selected"
L["Speed_Secret"] = "Restricted"
L["Speed_SecretTooltip"] = Ns.Colors.Green .. "Restricted|r\n" .. "Auto switches speed to yards per second \nin restricted areas (combat, m+, arena). \n\nThis allows to show the live speed \ninstead of a cached one due to \nthe game's restrictions"
L["Speed_Color"] = "Speed color"
L["Percent"] = "Percent"
L["Yards"] = "Yards"
L["Km"] = "Km"
L["Speed_ModeTooltip"] = Ns.Colors.Green .. "Speed display|r\n" .. "Choose how your speed is displayed \n\n" .. Ns.Colors.Green .. "Percent|r \nSpeed value in percent \n\n" .. Ns.Colors.Green .. "Yards|r \nYards per second. Works in \ncombat, Mythic+ and Arenas \n\n" .. Ns.Colors.Green .. "Km|r \nKilometers per hour" 
L["Display_Percentage"] = "Progression"
L["Rank"] = "Rank"
L["Rep"] = "Rep"
L["Normal"] = "Normal"
L["Enchanted"] = "Enchanted"
L["Shadowflame"] = "Shadowflame"
L["Ingenuity"] = "Ingenuity"
L["Season"] = "Season"
L["Expansion"] = "Expansion"
L["Spark"] = "Spark"
L["Splinter"] = "Dust"
L["Gigantic"] = "Gigantic"
L["Plump"] = "Plump"
L["Current"] = "Current"
L["Owned"] = "Owned"
L["Empty"] = "Empty"
L["Vintage"] = "Vintage"
L["Display_Average"] = "Average"
L["Display_Rated"] = "Rated"
L["Display_Basic"] = "Basic"
L["Auto_Name"] = "Auto Name"
L["Auto_NameTooltip"] = Ns.Colors.Green .. "Auto Name|r\n" .. "Automatically sets the stat name to\nthe main primary stat:\nStrength, Agility, or Intellect"
L["Display_MainHand"] = "Disable Off-Hand"
L["Hide_Reputation"] = "Hide Maxed Renown"
L["Season"] = "Season"
L["Expansion"] = "Expansion"
L["Display_Short"] = "Short Number"
L["Display_Max"] = "Cap color"
L["Display_Gold"] = "Show Gold only"
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
L["Editbox_MobRange"] = "Range"
L["Editbox_MobRangeTooltip"] = "Set the detection range in yards\n\n0 = all visible nameplates"
L["Display_Weekly"] = "Show cap"
L["Raids"] = "Raids"
L["Dungeons"] = "Dungeons"
L["Raids_DungeonsTooltip"] = Ns.Colors.Green .. "Raids|r\n" .. "Displays raid boss kills \n\n" .. Ns.Colors.Green .. "Dungeons|r\n" .. "Displays dungeon completions"
L["Display_Delves"] = "Tier 8 and above"
L["Display_DelvesTip"] = ""
L["Editbox_D"] = "Tier"
L["Editbox_DTooltip"] = Ns.Colors.Green .. "Tier|r\n" .. "Set the World Tier level to display \nthe number of runs eligible in the \nGreat Vault \n\n" .. "The option " .. Ns.Colors.Green .. "Tier 8+|r will override \nthis option"
L["Editbox_DP"] = "Tier"
L["Editbox_DPTooltip"] = Ns.Colors.Green .. "Tier|r\n" .. "Set the Delves/Prey runs tier \nto track \n\n" .. "The options " .. Ns.Colors.Green .. "All & Tier 8+|r will \noverride this option"
L["Display_All"] = "Show total"
L["Display_Tier8"] = "Tier 8+ only"
L["Display_Tier8Tip"] = ""
L["Vault_Tooltip"] = "Great Vault"
L["Vault_TooltipTooltip"] = Ns.Colors.Green .. "Great Vault|r\n" .. "Show all your Delves, Prey \nand World runs in the \nGreat Vault tooltip"
L["VT_Header"] = ": Weekly runs"
L["VT_Delves"] = "Delves"
L["VT_Prey"] = "Prey"
L["VT_Tier"] = "Tier"
L["VT_Normal"] = "Normal"
L["VT_Hard"] = "Hard"
L["VT_Nightmare"] = "Nightmare"
L["Display_Total"] = "Show total"
L["BNet"] = "BattleNet"
L["Spec"] = "Spec"
L["Hero"] = "Hero"
L["Abbrev"] = "Abbreviate"
L["Name"] = "Name"
L["Mythical"] = "Mythical"
L["Heroic"] = "Heroic"

-- Decimals
L["Decimals_Default"] = "Number Break Place"
L["Decimals_DefaultTip"] = ""
L["Decimals_One"] = "Decimals"
L["Decimals_Two"] = "Decimals"
L["Decimals_OneTip"] = ""
L["Decimals_TwoTip"] = ""

-- Caps
L["Cap_Percent"] = "Percentage cap"
L["Cap_PercentTooltip"] = Ns.Colors.Green .. "Percentage cap|r\n" .. "Set the percentage of your soft \nor hard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nSet value to 0 to disable cap \ncolors"
L["Cap_Rating"] = "Rating cap"
L["Cap_RatingTooltip"] = Ns.Colors.Green .. "Rating cap|r\n" .. "Set the rating of your soft or \nhard cap. It can also be used \nto set a diminishing return cap \nor any other personal threshold \n\nYour stat will be colored green \nupon reaching the set value \n\nSet value to 0 to disable cap \ncolors"
L["Cap_Token"] = "Token cap"
L["Cap_TokenTooltip"] = Ns.Colors.Green .. "Token cap|r\n" .. "Set a target price for the WoW Token \n\nThe token value will be colored " .. Ns.Colors.Red .. "red|r if \nbelow the cap, and " .. Ns.Colors.Green .. "green|r if equal \nor above \n\nSet value to 0 to disable cap \ncolors"

-- Diminishing Returns
L["DR_Display"] = "Show DR"
L["DR_DisplayTooltip"] = Ns.Colors.Green .. "Diminishing returns|r\n" .. "Adds the percentage lost to \ndiminishing returns next to the \nstat value \n\nOnly visible when rating bonus \nexceeds 30% (DR threshold)"
L["DR_Gradient"] = "DR color"
L["DR_GradientTooltip"] = Ns.Colors.Green .. "DR color|r\nColors the stat value based on your \ncurrent diminishing returns bracket \n\n" .. "|cff71ffc9100%|r" .. " efficiency \n" .. "|cff66ff0090%|r" .. " efficiency \n" .. "|cffffff0080%|r" .. " efficiency \n" .. "|cffff880070%|r" .. " efficiency \n" .. "|cffff440060%|r" .. " efficiency \n" .. "|cffff000050%|r" .. " efficiency"

-- Stat Bars
L["StaticBar"] = "Static"
L["StaticBarTooltip"] = Ns.Colors.Green .. "Static|r\n" .. "Enables a static background bar \nbehind each stat for cosmetic \npurposes \n\nDynamic bars take priority when \nboth are enabled"
L["ShowBar"] = "Dynamic"
L["ShowBarTooltip"] = Ns.Colors.Green .. "Dynamic|r\n" .. "Enables status bars that fill based \non the stat's value towards a set \nmax value \n\nThe max value can be set manually \nor be a currency's weekly cap, \na stat's soft cap or hard cap, etc"

