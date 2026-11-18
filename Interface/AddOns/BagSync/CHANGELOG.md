# BagSync

## [v20.41](https://github.com/Xruptor/BagSync/tree/v20.41) (2026-11-17)
[Full Changelog](https://github.com/Xruptor/BagSync/compare/v20.40...v20.41) [Previous Releases](https://github.com/Xruptor/BagSync/releases)

- WoW Forever Bank Fix (part 2)  
    * Fixed bank items on your other characters still not showing on WoW Forever.  BagSync was only watching for the "Banker" interaction to know you were at the bank, but the bank window can also be opened by the Character Banker and Account Banker types.  When that happened BagSync never knew you were at the bank, so nothing in your bank was ever saved.  It now uses the bank window open/close events like other bag addons do. (Fixes #481) (Fixes #482)  
    * Bags placed in the bank bag slots on WoW Forever are now saved and counted for your other characters.  
    * Opening the bank at a Warband-only banker will no longer save your character bank, since your character bank can't be viewed there.  
    * The Warband bank is now only scanned once when the bank opens, instead of once for the bank window and again for the Warband banker.  Several Warband tab changes in a row are also grouped into a single scan.  
    * Fixed the item type tooltip line leaking a global variable, which could cause taint issues with other addons.  
