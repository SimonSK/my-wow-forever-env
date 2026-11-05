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
