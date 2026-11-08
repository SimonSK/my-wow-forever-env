# BagSync

## [v20.39](https://github.com/Xruptor/BagSync/tree/v20.39) (2026-11-07)
[Full Changelog](https://github.com/Xruptor/BagSync/compare/v20.38...v20.39) [Previous Releases](https://github.com/Xruptor/BagSync/releases)

- WoW Forever surname support + live client fixes (Fixes #479)  
    - Forever characters are now saved as "FirstName Surname". Forever's UnitName()  
      returns the surname as a second value, so alts sharing a first name were  
      overwriting each other. Existing first-name-only entries are migrated  
      automatically when the matching character (by GUID) logs in.  
    - Currency transfers on Forever now look up the source character by GUID first.  
    - Fixed IsForever detection on the live client.  
    - Search modules button uses BSYC.IsRetail instead of a raw MAINLINE check.  
    - Warband bank is only used when it's actually available. Forever has the  
      account bank API but the feature is locked, which caused an empty 0g Warband  
      entry to show in Gold, Search, Sort Order and Details. It's re-checked on  
      login and bank open, so it will turn on automatically if Blizzard enables it.  
