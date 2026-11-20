# Raid Markers 1.2.0

- Fixed the marker buttons doing nothing for players with the game's "cast on key down" option (ActionButtonUseKeyDown) turned off (reported on CurseForge). The game then only acts when the mouse button is released, and the marker buttons only listened for the press. They now listen for both, like the clear buttons, and the game acts once. Not run in the game.
- New: Border setting in /raidbar settings (Layout, next to Show). Click to cycle the bar's outer border through 100%, 75%, 50%, 25% and Off (requested on CurseForge). Floating buttons still hide the whole frame.
- New: the Show setting (was Visibility) now cycles Always, In Group (party or raid) and Lead/Assist (in a raid as leader or assistant) (requested on CurseForge). Your existing Lead/Assist choice is kept. The same "in a party or raid" option is also a checkbox on the RaidBar page in the game's AddOn options, and those checkboxes now show the current choices.

# Raid Markers 1.1.19

- Swap Click Buttons now stays on after a relog or /reload (reported on CurseForge: it had to be set again every login). The marker buttons were set up while the addon loaded, before the game had read your saved settings, so they always started with left click = world marker and the setting button showed the default. They are now set up again once your settings are loaded (after combat if you log in during combat). Not run in the game.

# Raid Markers 1.1.18

- New setting: Swap Click Buttons (in /raidbar settings). Choose whether left or right click places the world marker on each marker button; the other click stamps the target icon. Default is unchanged (left = world marker). The tooltip follows your choice. If you change it in combat it applies when combat ends.
- New: Window Style option for the settings window. Forever (brown and gold, matching Grind Tracker and Animated Blizzard Portraits) or Default (slate). It starts on Forever on the Forever client, once, and switching it reloads the UI. The bar itself keeps its own border and background settings.

# Raid Markers 1.1.17

- Hide Blizzard raid UI now also hides the left-edge strip and arrow toggles (CompactRaidFrameManagerToggleButtonForward/Back and any other manager chrome) that newer clients added. The protected raid container is left untouched.

# Raid Markers 1.1.16

- Minor Lua source readability cleanup and release-version updates. Existing gameplay behavior and settings are unchanged.

# Raid Markers 1.1.15

- Added Cataclysm Classic 4.4.2 interface 40402 to every shipped TOC. Cataclysm gameplay has not been verified.
- Minor Lua source readability cleanup. Compiled Lua 5.1 bytecode was verified unchanged before release-version metadata was bumped.

# Raid Markers 1.1.14

- Added Cataclysm Classic 4.4.2 interface 40402 to every shipped TOC. This is a manifest update; Cataclysm gameplay has not been verified.

# Raid Markers 1.1.13

- Added Mists of Pandaria Classic (5.5.4) and Wrath of the Lich King Classic (3.4.5) support: the TOC now lists interfaces 50504 and 30405, so the addon loads as up to date on those clients. The code only uses APIs that are checked for before use; it was reviewed, not run on a MoP or Wrath client.

# Raid Markers 1.1.12

- Added support for game patch 12.1.7: the TOC now lists retail interface 120107 (120105 for 12.1.5 is kept), so the addon is not marked out of date.

# Raid Markers 1.1.11

- Right-click the minus/plus button to clear all ground markers and the overhead icon on your current target. Enabled by default in both expanded and minimized states.
- Uses a secure click macro with localized clear commands; no direct protected clear calls from addon Lua.
- Left-click still minimizes/expands, and dragging still moves the bar outside combat. Combat clicks avoid protected movement operations.
- CW and CT remain available. CT now supports both click-on-press and click-on-release settings.
- Shortcut glow updates read actual ground-marker state, preserving glows if permissions prevent clearing.

Checks: original bug regression tests, shortcut/click/drag/combat mocks on world-marker and target-only clients, localized command tests, Lua syntax, manifest references and ZIP/source equality. Actual secure execution and gameplay are not yet verified.

In-game test: use /reload, place ground markers, select a marked target, and right-click - while expanded and + while minimized. Confirm ground markers and the current target icon clear, left-click still toggles, dragging still works outside combat, and CW/CT still work. Test both ActionButtonUseKeyDown settings, in/out of combat and leader/assistant permissions. This shortcut does not clear overhead icons on other targets.

Not uploaded to CurseForge.

---

# RaidBar 1.1.10

- Move Clear World Markers to the secure worldmarker clear action triggered by a hardware left click. Remove the direct protected API call.

Verification: focused Lua regression mocks reproduce the original report and pass with the fix. Lua syntax, manifest and ZIP checks are run by the Workshop packaging tool.

In-game testing required: As group leader/assistant, place several world markers and left-click CW both out of combat and in combat. Test both ActionButtonUseKeyDown settings. Confirm right-click does not clear markers and test Classic clients without world markers.

Not uploaded or deployed.

---

# Raid Markers 1.1.8

- Added `/raidbar version` to report the installed addon version and game build in one line for support.
- The command accepts uppercase letters and surrounding spaces.
- Aligned all included client and module manifests to 1.1.8.
- Existing settings and normal commands are preserved.

Validation: all 1 packaged Lua files compile under Lua 5.1; version reporting checked with modern, legacy and unavailable metadata APIs; normal-command fall-through checked; manifest references verified.

In-game visual testing has not been performed for this maintenance patch.
