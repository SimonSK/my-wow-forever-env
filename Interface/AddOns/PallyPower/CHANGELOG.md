# PallyPower Classic

## [v1.6.10-classic](https://github.com/AznamirWoW/PallyPower/tree/v1.6.10-classic) (2026-11-16)
[Full Changelog](https://github.com/AznamirWoW/PallyPower/compare/v1.6.5-classic...v1.6.10-classic) [Previous Releases](https://github.com/AznamirWoW/PallyPower/releases)

- avoiding Greater Salv check on Forever client  
- Merge pull request #50 from orionshock/fix/forever-live-blessing-colors  
    Fix live individual blessing colors on Forever  
- Show live Forever blessing status with native tile layers  
    Reuse each individual timer slot for a satisfied-state background and derive the missing color from current assignments. Preserve accepted blessing alternatives, configured background skins, timer text, secure controls and estimated class timers. Avoid private aura queries and discard failed slot initialization.  
    Cache skin setup, keep countdown opacity separate from tile opacity, and add configuration-only color diagnostics. Mask and animation experiments are excluded.  
    Validation: manual in-game present/missing/override checks by the user, Lua 5.1 syntax checks, and git diff --check. Changing satisfied-state opacity still requires reload; timer alpha isolation should also be checked in game with translucent settings.  
- Native Auras patch by orionshock  
- Mousewheel patch for wow-forever client by orionshock  
- Merge pull request #48 from Gogo1951/update-workflow-actions  
    Update GitHub Actions in release workflow  
- Update GitHub Actions in release workflow  
    Bump actions/checkout from v3 to v7.  
    Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>  
- Merge pull request #46 from DemonFire7/oath-of-light  
    Forever: Oath of Light button and timer  
- Forever: give the Oath of Light button its backdrop  
    The button showed its icon and timer but no background box, because it was missing from the  
    backdrop setup that the class and player buttons go through.  
    Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>  
    Claude-Session: https://claude.ai/code/session\_016DLaTSu5Q9E2tp7vXDDDfD  
- Forever: place the Oath of Light button correctly in the horizontal layouts  
    In layouts 5 and 6 the player buttons stack above or below the class button, so the  
    Oath button now goes on the opposite side instead of overlapping the next class button.  
    Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>  
    Claude-Session: https://claude.ai/code/session\_016DLaTSu5Q9E2tp7vXDDDfD  
- Forever: Oath of Light button and timer  
    Adds an Oath of Light button to the drop-out beside each class button (shown  
    once the talent is known) and a timer for it inside the aura button.  
    - Left/right click swears the Oath on a player of that class: tank first,  
      otherwise whoever is missing it, then whoever was done longest ago.  
    - Tracks 5 minute duration and that only one Oath can be active per Paladin,  
      including when the client hides other players' auras.  
    - Oath of Light is not a blessing, so casting it does not clear remembered blessings.  
    Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>  
    Claude-Session: https://claude.ai/code/session\_016DLaTSu5Q9E2tp7vXDDDfD  
- Merge pull request #45 from Marrislul/forever-combat-blessings  
    Forever: show your own blessings cast during combat  
- Forever: show your own blessings cast during combat  
    Player buttons note their target in combat too, blessings from macros  
    and keybinds are matched via UNIT\_SPELLCAST\_SENT, every successful own  
    blessing is remembered (not only when the aura call fails), and any own  
    blessing (including Protection, Freedom, Sacrifice) drops the one it  
    replaces. The buttons are redrawn right after the cast.  
    Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>  
