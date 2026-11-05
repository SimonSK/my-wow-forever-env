local _, Ns = ...

local FADE_DURATION = 0.35

local function StopFade(panelFrame)
	if panelFrame.fadeAnim then
		panelFrame.fadeAnim:Stop()
	end
end

--- Fade a single panel frame to targetAlpha.
local function FadePanel(panelFrame, panelData, targetAlpha)
	local hud = panelFrame.HUD
	StopFade(panelFrame)
	if not panelFrame.fadeAnim then
		local ag = hud:CreateAnimationGroup()
		local anim = ag:CreateAnimation("Alpha")
		anim:SetDuration(FADE_DURATION)
		anim:SetSmoothing("IN_OUT")
		ag:SetScript("OnFinished", function()
			hud:SetAlpha(ag.targetAlpha)
			local pd = ag.panelData
			local mouseOver = pd and pd.Stats and pd.Stats.EventMouseOver
			local mouseOverHidden = ag.panelFrame and ag.panelFrame.mouseOverHidden
			if pd and not pd.LockHUD then
				ag.panelFrame:SetAlpha(ag.targetAlpha)
				if ag.targetAlpha <= 0 and (not mouseOver or mouseOverHidden) then
					ag.panelFrame:Hide()
				end
			end
			if ag.targetAlpha <= 0 and (not mouseOver or mouseOverHidden) then
				hud:Hide()
			end
		end)
		panelFrame.fadeAnim = ag
		panelFrame.fadeAnim.anim = anim
	end
	panelFrame.fadeAnim.panelFrame = panelFrame
	panelFrame.fadeAnim.panelData = panelData
	local current = hud:GetAlpha()
	if current == targetAlpha then
		local mouseOver = panelData.Stats and panelData.Stats.EventMouseOver
		local mouseOverHidden = panelFrame.mouseOverHidden
		if not panelData.LockHUD then
			panelFrame:SetAlpha(targetAlpha)
		end
		if targetAlpha <= 0 then
			if not mouseOver or mouseOverHidden then
				hud:Hide()
				if not panelData.LockHUD then
					panelFrame:Hide()
				end
			end
		end
		return
	end
	hud:Show()
	panelFrame.fadeAnim.targetAlpha = targetAlpha
	panelFrame.fadeAnim.anim:SetFromAlpha(current)
	panelFrame.fadeAnim.anim:SetToAlpha(targetAlpha)
	panelFrame.fadeAnim:Play()
end

--- Fade ALL panel frames to targetAlpha.
local function FadeAllPanels(targetAlpha)
	if not Ns.ProfileRoot then return end
	for _, pName in ipairs(Ns.ProfileRoot.PanelOrder) do
		local pf = Ns.PanelFrames[pName]
		local pd = Ns.ProfileRoot.Panels[pName]
		if pf and pd then
			FadePanel(pf, pd, targetAlpha)
		end
	end
end

local INSTANCE_EVENTS = {
	{ type = "party",    key = "EventDungeon" },
	{ type = "raid",     key = "EventRaid" },
	{ type = "pvp",      key = "EventPvP" },
	{ type = "arena",    key = "EventArena" },
	{ type = "scenario", key = "EventDelves" },
}

--- Show a single panel HUD.
local function ShowPanelHUD(pf, pd)
	if pf.hideTimer then pf.hideTimer:Cancel(); pf.hideTimer = nil end
	pd.HideHUD = false
	if not pd.LockHUD then
		pf:SetAlpha(1)
		pf:Show()
	end
	pf.HUD.Background:SetAlpha(pd.HUDBgAlpha or 0)
	FadePanel(pf, pd, 1)
	if #pf.HUD.StatList == 0 then
		Ns:QueueProfileRefresh()
	end
end

--- Hide a single panel HUD using its own event opacity settings.
local function HidePanelHUD(pf, pd)
	local stats = pd.Stats
	local useOpacity = stats and stats.EventOpacity
	local targetAlpha = useOpacity and (stats.EventOpacityValue or 0.3) or 0

	local mouseOver = stats and stats.EventMouseOver
	local function DoHide()
		if not useOpacity and not mouseOver then
			pd.HideHUD = true
		end
		FadePanel(pf, pd, targetAlpha)
	end

	if stats and stats.EventTimer and stats.EventTime then
		if pf.hideTimer then pf.hideTimer:Cancel() end
		pf.hideTimer = C_Timer.NewTimer(stats.EventTime, function()
			pf.hideTimer = nil
			DoHide()
		end)
	else
		if pf.hideTimer then pf.hideTimer:Cancel(); pf.hideTimer = nil end
		DoHide()
	end
end

--- Handle a single event for one panel based on that panel's own Stats.
local function HandlePanelEvent(pf, pd, event)
	local stats = pd.Stats
	if not stats or not stats.EventEnable then return end

	if event == "PLAYER_ENTERING_WORLD" then
		local inInstance, instanceType = IsInInstance()

		if not Ns.CharPanel and not stats.EventCombat then
			local shouldShow, shouldHide = false, false

			for _, entry in ipairs(INSTANCE_EVENTS) do
				local enabled = stats[entry.key]
				if instanceType == entry.type then
					if enabled then
						shouldShow = true
					elseif Ns.eventChecked then
						shouldHide = true
					end
				elseif enabled and not inInstance then
					shouldHide = true
				end
			end

			if stats.EventWorld and instanceType == "none" then
				shouldShow = true
				shouldHide = false
			end

			if shouldShow then
				ShowPanelHUD(pf, pd)
			elseif shouldHide then
				HidePanelHUD(pf, pd)
			end
		end

		if stats.EventCombat
			and not stats.EventWorld
			and not stats.EventDungeon
			and not stats.EventRaid
			and not stats.EventPvP
			and not stats.EventArena
			and not stats.EventDelves
			and (not UnitAffectingCombat("player") or not InCombatLockdown())
		then
			HidePanelHUD(pf, pd)
		end

		if stats.EventTarget
			and not stats.EventWorld
			and not stats.EventDungeon
			and not stats.EventRaid
			and not stats.EventPvP
			and not stats.EventArena
			and not stats.EventDelves
			and not stats.EventCombat
			and not UnitExists("target")
		then
			HidePanelHUD(pf, pd)
		end

	elseif event == "PLAYER_REGEN_DISABLED" then
		if stats.EventCombat and not Ns.CharPanel
			and (UnitAffectingCombat("player") or InCombatLockdown())
		then
			ShowPanelHUD(pf, pd)
		end

	elseif event == "PLAYER_REGEN_ENABLED" then
		if stats.EventCombat and not Ns.CharPanel
			and (not UnitAffectingCombat("player") or not InCombatLockdown())
		then
			HidePanelHUD(pf, pd)
		end

	elseif event == "PLAYER_TARGET_CHANGED" then
		if stats.EventTarget and not Ns.CharPanel then
			if UnitExists("target") then
				if not stats.EventTargetHostile or UnitIsEnemy("player", "target") then
					ShowPanelHUD(pf, pd)
					return
				end
			end
			HidePanelHUD(pf, pd)
		end
	end

	if not Ns.CharPanel then
		if stats.EventResting then
			if IsResting() then
				HidePanelHUD(pf, pd)
				return
			elseif event == "PLAYER_UPDATE_RESTING" then
				ShowPanelHUD(pf, pd)
				return
			end
		end

		if stats.EventMounted then
			if IsMounted() then
				HidePanelHUD(pf, pd)
				return
			elseif event == "PLAYER_MOUNT_DISPLAY_CHANGED" then
				ShowPanelHUD(pf, pd)
				return
			end
		end
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event)

	-- Pet battle events affect ALL panels unconditionally
	if event == "PET_BATTLE_OPENING_START" then
		if Ns.ProfileRoot then
			for _, pName in ipairs(Ns.ProfileRoot.PanelOrder) do
				local pd = Ns.ProfileRoot.Panels[pName]
				if pd then pd.HideHUD = true end
			end
		end
		FadeAllPanels(0)
		return
	elseif event == "PET_BATTLE_OVER" then
		if Ns.ProfileRoot then
			for _, pName in ipairs(Ns.ProfileRoot.PanelOrder) do
				local pd = Ns.ProfileRoot.Panels[pName]
				if pd then pd.HideHUD = false end
			end
		end
		FadeAllPanels(1)
		return
	end

	-- Per-panel event handling
	if not Ns.ProfileRoot then return end
	for _, pName in ipairs(Ns.ProfileRoot.PanelOrder) do
		local pd = Ns.ProfileRoot.Panels[pName]
		local pf = Ns.PanelFrames[pName]
		if pd and pf then
			HandlePanelEvent(pf, pd, event)
		end
	end
end)

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PET_BATTLE_OPENING_START")
f:RegisterEvent("PET_BATTLE_OVER")
f:RegisterEvent("PLAYER_UPDATE_RESTING")
f:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
f:RegisterEvent("PLAYER_TARGET_CHANGED")

-- Per-panel Mouse Over Smart HUD
local function EnablePanelMouseOver(pf, pName)
	if pf.MouseOverFrame then
		pf.MouseOverFrame:SetFrameStrata(pf:GetFrameStrata())
		pf.MouseOverFrame:SetFrameLevel(pf:GetFrameLevel() + 10)
		pf.MouseOverFrame:Show()
		return
	end

	local mof = CreateFrame("Frame", nil, UIParent)
	-- Total height = title bar (pf itself) + stat area.
	-- Anchor from BOTTOMLEFT when growing up so the frame extends toward the stats.
	local initW = pf._hudW or pf:GetWidth() or 150
	local initH = (pf._hudH or 50) + (pf:GetHeight() or 15)
	if pf._growUp then
		mof:SetPoint("BOTTOMLEFT", pf, "BOTTOMLEFT")
	else
		mof:SetPoint("TOPLEFT", pf, "TOPLEFT")
	end
	mof:SetSize(math.max(1, initW), math.max(1, initH))
	mof:SetFrameStrata(pf:GetFrameStrata())
	mof:SetFrameLevel(pf:GetFrameLevel() + 10)
	mof:EnableMouse(true)
	mof:SetPropagateMouseMotion(true)
	mof:SetPropagateMouseClicks(true)

	mof:SetScript("OnEnter", function()
		if not Ns.ProfileRoot then return end
		local pd = Ns.ProfileRoot.Panels[pName]
		if not pd then return end
		local stats = pd.Stats
		if stats and stats.EventEnable and stats.EventMouseOver and not Ns.CharPanel then
			ShowPanelHUD(pf, pd)
		end
	end)
	mof:SetScript("OnLeave", function()
		if not Ns.ProfileRoot then return end
		local pd = Ns.ProfileRoot.Panels[pName]
		if not pd then return end
		local stats = pd.Stats
		if stats and stats.EventEnable and stats.EventMouseOver and not Ns.CharPanel then
			HidePanelHUD(pf, pd)
		end
	end)
	pf.MouseOverFrame = mof
end

local function DisablePanelMouseOver(pf)
	if pf.MouseOverFrame then
		pf.MouseOverFrame:Hide()
	end
end

function Ns.RefreshAllMouseOver()
	if not Ns.ProfileRoot then return end
	for _, pName in ipairs(Ns.ProfileRoot.PanelOrder) do
		local pd = Ns.ProfileRoot.Panels[pName]
		local pf = Ns.PanelFrames[pName]
		if pd and pf then
			local stats = pd.Stats
			if stats and stats.EventEnable and stats.EventMouseOver then
				EnablePanelMouseOver(pf, pName)
				-- Start in hidden state so user must mouse over to reveal
				if not pf.mouseOverHidden then
					pf.mouseOverHidden = true
					HidePanelHUD(pf, pd)
				end
			else
				local wasMouseOver = pf.mouseOverHidden
				DisablePanelMouseOver(pf)
				pf.mouseOverHidden = nil
				-- Restore visibility when mouse over is disabled
				if wasMouseOver then
					ShowPanelHUD(pf, pd)
				end
			end
		end
	end
end

function Ns.ToggleMouseOver()
	Ns.RefreshAllMouseOver()
end

-- Initialise on login if any panel has mouse-over enabled
local moInit = CreateFrame("Frame")
moInit:RegisterEvent("PLAYER_LOGIN")
moInit:SetScript("OnEvent", function(self)
	self:UnregisterAllEvents()
	C_Timer.After(0, function()
		Ns.RefreshAllMouseOver()
	end)
end)