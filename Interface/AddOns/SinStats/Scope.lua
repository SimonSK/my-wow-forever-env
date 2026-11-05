local AddName, Ns = ...

-- shared table for all widget and config knobs

local _P = "Interface\\AddOns\\SinStats\\Textures\\png\\"
local _T = "Interface\\AddOns\\"..AddName.."\\Textures\\"
local red = {r=0.549, g=0, b=0.071, a=1}
local orange = { r=1, g=0.741, b=0.313, a=1 }


Ns.K = {
	-- ── W.TopTab tint knobs ───────────────────────────────────────────────────
	-- Idle = unselected/un-hovered state; Normal = explicit TOP_TAB_NORMAL_TEX; Checked = selected base layer; Hover/Checked 2 use the highlight slot.
	TOP_TAB_IDLE_R    = 1, TOP_TAB_IDLE_G    = 1, TOP_TAB_IDLE_B    = 1, TOP_TAB_IDLE_A    = 1,
	TOP_TAB_NORMAL_R  = 1,     TOP_TAB_NORMAL_G  = 1,     TOP_TAB_NORMAL_B  = 1,     TOP_TAB_NORMAL_A  = 0,
	TOP_TAB_CHECKED_R = orange.r, TOP_TAB_CHECKED_G = orange.g, TOP_TAB_CHECKED_B = orange.b, TOP_TAB_CHECKED_A = 1,
	TOP_TAB_CHECKED_BLEND_MODE = "", -- BLEND, ADD, MOD, ALPHAKEY, DISABLE

	SLIDER_BG_ALPHA   = 0.6,  -- W.Slider track
	EDITBOX_BG_ALPHA  = 0.3,  -- W.BaseEditBox / W.EditBox
	DROPLIST_BG_ALPHA = 0.3,  -- W.DropList closed bar

	WIDGET_FULL_BG_EDGE_TEX  = "",
	-- WIDGET_FULL_BG_EDGE_R = 0.122, WIDGET_FULL_BG_EDGE_G = 0.118, WIDGET_FULL_BG_EDGE_B = 0.012, WIDGET_FULL_BG_EDGE_A = 0.2,
	WIDGET_FULL_BG_EDGE_R = 0.078, WIDGET_FULL_BG_EDGE_G = 0.063, WIDGET_FULL_BG_EDGE_B = 0.051, WIDGET_FULL_BG_EDGE_A = 0.25,

	CHECKBOX_SIZE          = 18,  -- W.CheckButton + W.CheckBox.f.Check (square)
	CHECKBOX_CHECK_SIZE    = 20,
	TOP_TAB_CHECK_SIZE     = 14,
	TOP_TAB_CHECKMARK_SIZE = 16,
	COLOR_PICKER_SIZE      = 17,  -- W.ColorPicker swatch (square)
	DROPLIST_HEIGHT        = 23,  -- W.DropList bar height

	CHECKBOX_X_OFFSET     = -6,  -- W.CheckBox: shift the check + label leftward
	COLOR_PICKER_X_OFFSET =  2,  -- W.ColorPicker: shift swatch + label rightward

	CHECKBOX_LABEL_GAP     = 35,  -- W.CheckBox
	COLOR_PICKER_LABEL_GAP = 25,  -- W.ColorPicker
	WIDGET_LABEL_GAP       = 20,  -- px between aligned label column and widget column

	CHECKBOX_TIP_Y_OFFSET     = 0,
	COLOR_PICKER_TIP_Y_OFFSET = 0,

	EDITBOX_BG_X_INSET = 2,
	EDITBOX_BG_Y_INSET = -1,

	DROPLIST_BG_INSET_L = 5, DROPLIST_BG_INSET_R = 5,
	DROPLIST_BG_INSET_T = 5, DROPLIST_BG_INSET_B = 5,

	DROPLIST_LIST_BG_INSET_L = 21, DROPLIST_LIST_BG_INSET_R = 21,
	DROPLIST_LIST_BG_INSET_T = 12, DROPLIST_LIST_BG_INSET_B = 22,
	DROPLIST_LIST_GAP        = 0, -- gap between closed bar and popup list
	DROPLIST_ROW_EXTRA_W     = 10,  -- extra px added to every row width beyond its text width; raises minimum selection area for short labels
    DROPLIST_LIST_HIGHLIGHT  = _P.."buttons\\highlight.png",

	DROPLIST_LIST_BG_COLOR_R = 0.161, DROPLIST_LIST_BG_COLOR_G = 0.161, DROPLIST_LIST_BG_COLOR_B = 0.161, DROPLIST_LIST_BG_COLOR_A = 0.97,  -- popup list fill color (matches PanelSwitcher dark style)
	DROPLIST_LIST_EDGE_SIZE   = 0,   -- border edge size for rounded corners; 0 = no border
	DROPLIST_LIST_EDGE_R = 0.20, DROPLIST_LIST_EDGE_G = 0.20, DROPLIST_LIST_EDGE_B = 0.20, DROPLIST_LIST_EDGE_A = 0.7,  -- border color
	DROPLIST_LIST_BG_VERTEX_R = 1, DROPLIST_LIST_BG_VERTEX_G = 1, DROPLIST_LIST_BG_VERTEX_B = 1, DROPLIST_LIST_BG_VERTEX_A = 1,  -- vertex color tint for the popup list background (atlas or PNG)
	DROPLIST_LIST_PAD_L = 10, DROPLIST_LIST_PAD_T = 2, DROPLIST_LIST_PAD_R = 0, DROPLIST_LIST_PAD_B = 4,  -- inner padding in px between the list frame edges and the rows (L=left, T=top, R=right, B=bottom)
	DROPLIST_LIST_COLUMNS        = 1,   -- number of columns to split the popup list content across (1-4)
	DROPLIST_LIST_MAX_VISIBLE_ROWS = 15, -- max visible rows before the scrollbar appears

	RADIO_BG_INSET_L = 0, RADIO_BG_INSET_R = 0,
	RADIO_BG_INSET_T = 4, RADIO_BG_INSET_B = -6,

	CHECKBOX_FRAME_TEX        = _P.."checkbox\\checkbox.png",
	CHECKBOX_CHECK_TEX        = _P.."checkbox\\checkmark.png",
	CHECKBOX_CHECK_DESATURATED = false,
	CHECKBOX_CHECK_R = 1, CHECKBOX_CHECK_G = 1, CHECKBOX_CHECK_B = 1, CHECKBOX_CHECK_A = 1,
	CHECKBOX_HIGHLIGHT = _P.."buttons\\highlight2.png",
	CHECKBOX_HIGHLIGHT_DESATURATED = true,
	CHECKBOX_HIGHLIGHT_R = orange.r, CHECKBOX_HIGHLIGHT_G = orange.g, CHECKBOX_HIGHLIGHT_B = orange.b, CHECKBOX_HIGHLIGHT_A = 1,
	CHECKBOX_HIGHLIGHT_W = 0, CHECKBOX_HIGHLIGHT_H = 0,  -- 0 = keep the current auto-fill size
	CHECKBOX_HIGHLIGHT_X_OFFSET = -13, CHECKBOX_HIGHLIGHT_Y_OFFSET = 4,
	CHECKBOX_CHECK_HIGHLIGHT = _P.."buttons\\highlight2.png",  -- highlight when hovering the checkbox button itself; "" = use CHECKBOX_HIGHLIGHT
	CHECKBOX_CHECK_HIGHLIGHT_DESATURATED = true,
	CHECKBOX_CHECK_HIGHLIGHT_R = red.r, CHECKBOX_CHECK_HIGHLIGHT_G = red.g, CHECKBOX_CHECK_HIGHLIGHT_B = red.b, CHECKBOX_CHECK_HIGHLIGHT_A = 1,

	-- BUTTON_IDLE_TEX      = _P.."buttons\\button-idle.png",
	-- BUTTON_PRESSED_TEX   = _P.."buttons\\button-pressed.png",
	-- BUTTON_HIGHLIGHT_TEX = _P.."buttons\\highlight.png",
	BUTTON_IDLE_TEX      = _P.."buttons\\b-normal.png",
	BUTTON_PRESSED_TEX   = _P.."buttons\\b-pressed.png",
	BUTTON_HIGHLIGHT_TEX = _P.."buttons\\highlight.png",

	EDITBOX_TEX           = _P.."editbox\\editbox.png",
	RADIO_BG_TEX          = "",--_P.."radio-bg\\radio-bg4.png",
	RADIO_BG_DESATURATED  = false,
	RADIO_BG_R = 1, RADIO_BG_G = 1, RADIO_BG_B = 1, RADIO_BG_A = 1,  -- vertex color + alpha applied to the radio bg texture after optional desaturation

	RADIO_DOT_TEX         = "",--_P.."radio-bg\\radio.png",       -- unchecked state
	RADIO_DOT_CHECK_TEX   = _P.."buttons\\highlight3.png", -- checked state
	RADIO_DOT_W           = 14,  -- face width  in px (0 = keep radioSize local)
	RADIO_DOT_H           = 14,  -- face height in px (0 = keep radioSize local)
	RADIO_BTN_GAP_W       = 8,   -- horizontal padding inside each radio button
	RADIO_BTN_GAP_H       = 18,  -- height of each radio button in px
	RADIO_BTN_Y_OFFSET    = 7,  -- Y offset of radio buttons from frame bottom
	RADIO_BTN_GAP         = 8,   -- gap between consecutive radio buttons
	RADIO_HIGHLIGHT_TEX   = _P.."buttons\\highlight3.png",  -- highlight texture; "" = default
	RADIO_BUTTON_TEX 	 = _P.."radio-bg\\radio-bg4.png",  -- button texture; "" = defaults
	RADIO_HLT_R = red.r, RADIO_HLT_G = red.g, RADIO_HLT_B = red.b, RADIO_HLT_A = 0.5,
	RADIO_HIGHLIGHT_GAP   = 5,   -- extra px on each side for highlight / checked textures; 0 = match button size
	RADIO_TIP_X_OFFSET    = 0,  -- horizontal gap between last radio button and tooltip text
	RADIO_TIP_Y_OFFSET    = 0,   -- vertical offset of tooltip text relative to radio button
	DROPLIST_NORMAL_TEX   = _P.."droplist\\dropbox-normal.png",
	DROPLIST_HOVER_TEX    = _P.."droplist\\dropbox-hover.png",  -- hover AND open
	DROPLIST_LIST_BG_TEX  = "",--_P.."droplist\\dropbox-list-bg.png",
	TOP_SEPARATOR_TEX     = _P.."topseparator\\topsep.png",
	COLOR_PICKER_TEX      = _P.."colorpicker\\colorpicker.png",
	TOP_TAB_NORMAL_TEX    = _P.."toptabs\\top.png",
	TOP_TAB_IDLE_TEX     = _P.."toptabs\\top.png",
	TOP_TAB_CHECKED_TEX   = _P.."toptabs\\topy.png",--_P.."buttons\\highlight2.png",
	TOP_TAB_CHECKED_2_TEX = "",--_P.."toptabs\\topy.png",--_T.."LabelBGLine",
	TOP_TAB_HOVER_TEX     = _T.."LabelBGLine", --_P.."buttons\\highlight.png",
	-- L/R/T/B inset gaps (px) applied to the tab background textures
	-- (TOP_TAB_IDLE_TEX and TOP_TAB_NORMAL_TEX). Positive = shrink inward.
	TOP_TAB_TEX_GAP_L = -2, TOP_TAB_TEX_GAP_R = -3,
	TOP_TAB_TEX_GAP_T = 0, TOP_TAB_TEX_GAP_B = -11,
	-- L/R/T/B inset gaps (px) for the checked tab texture (TOP_TAB_CHECKED_TEX).
	TOP_TAB_CHECKED_GAP_L = 0, TOP_TAB_CHECKED_GAP_R = 0,
	TOP_TAB_CHECKED_GAP_T = 0, TOP_TAB_CHECKED_GAP_B = 0,
	TOP_TAB_FALLBACK_IDLE_TEX    = "",--_T.."LabelBG",
	TOP_TAB_FALLBACK_CHECKED_TEX = "",--_T.."LabelBGLine",
	TOP_TAB_FALLBACK_CHECKED_2_TEX = "",--_T.."LabelBGLine",
	TOP_TAB_FALLBACK_HOVER_TEX   = "",--_T.."LabelBGLine",
	TOP_TAB_NORMAL_DESATURATED  = false,
	TOP_TAB_CHECKED_DESATURATED = false,
	TOP_TAB_HOVER_DESATURATED   = true,
	TOP_TAB_HOVER_R = orange.r, TOP_TAB_HOVER_G = orange.g, TOP_TAB_HOVER_B = orange.b, TOP_TAB_HOVER_A = 1,
	TOP_TAB_ROW_GAP  = 0,  -- vertical gap between rows of top tabs
	TOP_TAB_COL_GAP  = 5,  -- horizontal gap between top tabs in the same row

	HUD_DELETE_BAR_TEX    = _P.."bars\\bars.png",
	HUD_CREATE_BTN_TEX = _P.."buttons\\create.png",
	HUD_CREATE_BTN_PRESSED_TEX = _P.."buttons\\create-pressed.png",
	HUD_CREATE_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	HUD_CREATE_BTN_HIGHLIGHT_W = 0, -- 0 = auto-fit icon + text
	HUD_CREATE_BTN_W = 14, HUD_CREATE_BTN_H = 14,
	HUD_CREATE_BTN_X = 0, HUD_CREATE_BTN_Y = 0,
	HUD_DELETE_CLOSE_TEX      = _P.."buttons\\delete.png",  -- X icon on HUD delete rows; "" = default (Close.blp)
	HUD_DELETE_CLOSE_NORMAL_R = 1, HUD_DELETE_CLOSE_NORMAL_G = 1, HUD_DELETE_CLOSE_NORMAL_B = 1, HUD_DELETE_CLOSE_NORMAL_A = 1,
	HUD_SWITCH_BTN_TEX = _P.."buttons\\rename.png",
	HUD_SWITCH_BTN_PRESSED_TEX = _P.."buttons\\rename.png",
	HUD_SWITCH_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	HUD_SWITCH_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	HUD_SWITCH_BTN_W = 14, HUD_SWITCH_BTN_H = 14,
	HUD_SWITCH_BTN_X = 0, HUD_SWITCH_BTN_Y = 0,
	HUD_RENAME_BTN_TEX = _P.."buttons\\rename.png",
	HUD_RENAME_BTN_PRESSED_TEX = _P.."buttons\\rename.png",
	HUD_RENAME_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	HUD_RENAME_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	HUD_RENAME_BTN_W = 14, HUD_RENAME_BTN_H = 14,
	HUD_RENAME_BTN_X = 0, HUD_RENAME_BTN_Y = 0,
	HUD_RESET_BTN_TEX = _P.."buttons\\reset.png",
	HUD_RESET_BTN_PRESSED_TEX = _P.."buttons\\reset.png",
	HUD_RESET_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	HUD_RESET_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	HUD_RESET_BTN_W = 14, HUD_RESET_BTN_H = 14,
	HUD_RESET_BTN_X = 0, HUD_RESET_BTN_Y = 0,
	HUD_CONFIRM_BTN_TEX = _P.."checkbox\\cm.png",
	HUD_CONFIRM_BTN_PRESSED_TEX = _P.."checkbox\\cm.png",
	HUD_CONFIRM_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	HUD_CONFIRM_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	HUD_CONFIRM_BTN_W = 14, HUD_CONFIRM_BTN_H = 14,
	HUD_CONFIRM_BTN_X = 0, HUD_CONFIRM_BTN_Y = 0,
	HUD_CANCEL_BTN_TEX = _P.."buttons\\reset.png",
	HUD_CANCEL_BTN_PRESSED_TEX = "",
	HUD_CANCEL_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	HUD_CANCEL_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	HUD_CANCEL_BTN_W = 14, HUD_CANCEL_BTN_H = 14,
	HUD_CANCEL_BTN_X = 0, HUD_CANCEL_BTN_Y = 0,
	PROFILE_APPLY_BTN_TEX = _P.."checkbox\\cm.png",
	PROFILE_APPLY_BTN_PRESSED_TEX = _P.."checkbox\\cm.png",
	PROFILE_APPLY_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	PROFILE_APPLY_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	PROFILE_APPLY_BTN_W = 14, PROFILE_APPLY_BTN_H = 14,
	PROFILE_APPLY_BTN_X = 0, PROFILE_APPLY_BTN_Y = 0,
	PROFILE_COPY_BTN_TEX = _P.."checkbox\\cm.png",
	PROFILE_COPY_BTN_PRESSED_TEX = _P.."checkbox\\cm.png",
	PROFILE_COPY_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	PROFILE_COPY_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	PROFILE_COPY_BTN_W = 14, PROFILE_COPY_BTN_H = 14,
	PROFILE_COPY_BTN_X = 0, PROFILE_COPY_BTN_Y = 0,
	PROFILE_CREATE_BTN_TEX = _P.."buttons\\create.png",
	PROFILE_CREATE_BTN_PRESSED_TEX = _P.."buttons\\create-pressed.png",
	PROFILE_CREATE_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	PROFILE_CREATE_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	PROFILE_CREATE_BTN_W = 14, PROFILE_CREATE_BTN_H = 14,
	PROFILE_CREATE_BTN_X = 0, PROFILE_CREATE_BTN_Y = 0,
	PROFILE_DELETE_BTN_TEX = _P.."buttons\\delete.png",
	PROFILE_DELETE_BTN_PRESSED_TEX = "",
	PROFILE_DELETE_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png", -- blank = use HUD delete highlight texture path
	PROFILE_DELETE_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	PROFILE_DELETE_BTN_W = 14, PROFILE_DELETE_BTN_H = 14,
	PROFILE_DELETE_BTN_X = 200, PROFILE_DELETE_BTN_Y = 31,
	PROFILE_ROW_GAP_Y = 120,  -- Y gap between consecutive rows in the Profiles page (Rename/Copy, Specs/Delete)
	PROFILE_IMPEXP_Y_OFFSET = -80,  -- Y offset for Export/Import on Retail/Mists (has spec section)
	PROFILE_IMPEXP_Y_OFFSET_CLASSIC = -185,  -- Y offset for Export/Import on Classic/TBC (no spec section)
	PROFILE_IMPEXP_W = 270,  -- width of Export/Import edit boxes
	PROFILE_IMPEXP_H = 80,   -- height of Export/Import edit boxes
	PROFILE_IMPEXP_BG_R = 0.122, PROFILE_IMPEXP_BG_G = 0.118, PROFILE_IMPEXP_BG_B = 0.027, PROFILE_IMPEXP_BG_A = 0.6,  -- vertex color for the edit box atlas background
	HUD_IMPEXP_Y_OFFSET = -45,  -- Y offset for the HUD Export/Import section (0 = directly after Rename)
	HUD_IMPEXP_W = 200,  -- width of HUD Export/Import edit boxes
	HUD_IMPEXP_H = 70,   -- height of HUD Export/Import edit boxes
	HUD_IMPEXP_BG_R = 0.122, HUD_IMPEXP_BG_G = 0.118, HUD_IMPEXP_BG_B = 0.027, HUD_IMPEXP_BG_A = 0.6,
	PROFILE_CONFIRM_BTN_TEX = _P.."checkbox\\cm.png",
	PROFILE_CONFIRM_BTN_PRESSED_TEX = _P.."checkbox\\cm.png",
	PROFILE_CONFIRM_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	PROFILE_CONFIRM_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	PROFILE_CONFIRM_BTN_W = 14, PROFILE_CONFIRM_BTN_H = 14,
	PROFILE_CONFIRM_BTN_X = 0, PROFILE_CONFIRM_BTN_Y = 0,
	PROFILE_CANCEL_BTN_TEX = _P.."buttons\\reset.png",
	PROFILE_CANCEL_BTN_PRESSED_TEX = "",
	PROFILE_CANCEL_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	PROFILE_CANCEL_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	PROFILE_CANCEL_BTN_W = 14, PROFILE_CANCEL_BTN_H = 14,
	PROFILE_CANCEL_BTN_X = 0, PROFILE_CANCEL_BTN_Y = 0,
	RECENT_SEARCH_BAR_TEX = _P.."bars\\bars.png",
	LAYOUT_STAT_BAR_TEX   = _P.."bars\\bars.png",
	RECENT_SEARCH_CLOSE           = _P.."buttons\\delete.png",
	RECENT_SEARCH_CLOSE_NORMAL_R  = 1, RECENT_SEARCH_CLOSE_NORMAL_G = 1, RECENT_SEARCH_CLOSE_NORMAL_B = 1, RECENT_SEARCH_CLOSE_NORMAL_A = 1,

	-- cross-ref: assigned to BUTTON_HIGHLIGHT_TEX below
	BAR_BTN_HIGHLIGHT_TEX     = _P.."buttons\\highlight.png",
	BAR_BTN_HIGHLIGHT_R = 0.769, BAR_BTN_HIGHLIGHT_G = 0.118, BAR_BTN_HIGHLIGHT_B = 0.227, BAR_BTN_HIGHLIGHT_A = 1,

	-- cross-ref: assigned to BUTTON_HIGHLIGHT_TEX below
	LAYOUT_STAT_HIGHLIGHT_TEX = _P.."buttons\\highlight.png",
	-- LAYOUT_STAT_HIGHLIGHT_R = 0.769, LAYOUT_STAT_HIGHLIGHT_G = 0.118, LAYOUT_STAT_HIGHLIGHT_B = 0.227, LAYOUT_STAT_HIGHLIGHT_A = 1,
	LAYOUT_STAT_HIGHLIGHT_R = red.r, LAYOUT_STAT_HIGHLIGHT_G = red.g, LAYOUT_STAT_HIGHLIGHT_B = red.b, LAYOUT_STAT_HIGHLIGHT_A = red.a,

	LAYOUT_PRESET_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",  -- hover highlight for Row/Column preset buttons; "" = no highlight
	LAYOUT_PRESET_HIGHLIGHT_DESATURATED = true,
	LAYOUT_PRESET_HIGHLIGHT_R = orange.r, LAYOUT_PRESET_HIGHLIGHT_G = orange.g, LAYOUT_PRESET_HIGHLIGHT_B = orange.b, LAYOUT_PRESET_HIGHLIGHT_A = 1,

	LAYOUT_APPLY_BTN_TEX = _P.."checkbox\\cm.png",
	LAYOUT_APPLY_BTN_PRESSED_TEX = _P.."checkbox\\cm.png",
	LAYOUT_APPLY_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	LAYOUT_APPLY_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	LAYOUT_APPLY_BTN_W = 14, LAYOUT_APPLY_BTN_H = 14,
	LAYOUT_APPLY_BTN_X = 0, LAYOUT_APPLY_BTN_Y = 0,
	LAYOUT_RESET_BTN_TEX = _P.."buttons\\reset.png",
	LAYOUT_RESET_BTN_PRESSED_TEX = _P.."buttons\\reset.png",
	LAYOUT_RESET_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	LAYOUT_RESET_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	LAYOUT_RESET_BTN_W = 14, LAYOUT_RESET_BTN_H = 14,
	LAYOUT_RESET_BTN_X = 0, LAYOUT_RESET_BTN_Y = 0,

	CONFIRM_BOX_BG_TEX          = "",   -- blank = none
	-- cross-ref: assigned from BUTTON_IDLE_TEX / BUTTON_HIGHLIGHT_TEX below
	CONFIRM_BTN_TEX             = _P.."buttons\\button-idle.png",
	CONFIRM_HIGHLIGHT_TEX       = _P.."buttons\\highlight.png",
	CONFIRM_HIGHLIGHT_DESATURATED = true,
	CONFIRM_HIGHLIGHT_R = 1, CONFIRM_HIGHLIGHT_G = 0.9, CONFIRM_HIGHLIGHT_B = 0.2, CONFIRM_HIGHLIGHT_A = 0.8,

	COLOR_PICKER_BORDER_OVERSIZE = 3,

	SLIDER_TRACK_TEX = "",      -- PNG overlay on the track bar (blank = backdrop only)
	SLIDER_TRACK_H   = 8,
	SLIDER_TRACK_R   = 0.27451, SLIDER_TRACK_G = 0.27451, SLIDER_TRACK_B = 0.27451,

	SLIDER_THUMB_TEX = "",
	SLIDER_THUMB_W   = 22, SLIDER_THUMB_H = 16,
	SLIDER_THUMB_R   = 1, SLIDER_THUMB_G = 0.741, SLIDER_THUMB_B = 0.313, SLIDER_THUMB_A = 1,

	SLIDER_ARROW_LEFT = _P.."sliders\\left.png",
	SLIDER_ARROW_RIGHT = _P.."sliders\\right.png",
	SLIDER_ARROW_W   = 12, SLIDER_ARROW_H = 12,
	SLIDER_ARROW_R   = 0.443, SLIDER_ARROW_G = 1, SLIDER_ARROW_B = 0.788, SLIDER_ARROW_A = 1,

	TOP_SEPARATOR_WIDTH  = 550,
	TOP_SEPARATOR_HEIGHT = 5,
	TOP_SEPARATOR_Y      = -28,  -- Y offset from TOP of anchorframe (negative = below the top edge)
	TOP_SEPARATOR_WIDGET_GAP = 39, --20 with no subheader at the top -- additional px pushed between the separator line and the first row of widgets below it
	WIDGET_Y_OFFSET     = 33,   -- extra px added to the first widget row Y offset (negative = up)
	WIDGET_ROW_X_OFFSET = -40,  -- X offset for the scroll frame on subheader pages (negative = left, toward divider)

	TOOLTIP_ICON_TEX = _P.."buttons\\help.png",
	TOOLTIP_ICON_W   = 25, TOOLTIP_ICON_H = 25,
	TOOLTIP_ICON_GAP = 4,   -- px between the end of the widget's text and the tooltip icon

	SIDE_SEPARATOR_TEX = _P.."border\\!GenericMetal2-NineSlice-EdgeLeft.png",
	SIDE_SEPARATOR_W   = 13,  -- width in px of the vertical separator texture
	SIDE_SEPARATOR_R   = 1, SIDE_SEPARATOR_G = 1, SIDE_SEPARATOR_B = 1, SIDE_SEPARATOR_A = 0.5,
	SIDE_SEPARATOR_TEX_L = 0, SIDE_SEPARATOR_TEX_R = 1, SIDE_SEPARATOR_TEX_T = 0, SIDE_SEPARATOR_TEX_B = 1,

	HOptionsOffsetX  = 35, HOptionsOffsetY = -42,  ---13 -- vertical gap added between widget rows on the right side
	mainMenuYOffset  = -92,
	separatorOffsetY = 30,

	SUBHEADER_BG_ENABLED     = true, -- show/hide the background texture on stat subheader bars
	SUBHEADER_HEIGHT         = 25,   -- height of the subheader texture/frame in px
	SUBHEADER_INSET          = 0,    -- px stripped from each side; 0 = frame-wide
	SUBHEADER_X_OFFSET       = -40, -- corrected below: SUBHEADER_INSET - 100
	SUBHEADER_BG_POSITION    = "LEFT", -- "LEFT" or "CENTER"
	SUBHEADER_BG_W           = 600, -- texture width in px when position is LEFT; 0 = fill available width
	SUBHEADER_BG_DESATURATED = false,
	-- SUBHEADER_BG_R = 0.502, SUBHEADER_BG_G = 0.4, SUBHEADER_BG_B = 0.035, SUBHEADER_BG_A = 0.3,
	SUBHEADER_BG_R = 0.33, SUBHEADER_BG_G = 0.33, SUBHEADER_BG_B = 0.30, SUBHEADER_BG_A = 0.4,
	SUBHEADER_TITLE_TEXT_POSITION = "LEFT", -- "LEFT" or "CENTER"
	SUBHEADER_TITLE_TEXT_X   = 10,
	SUBHEADER_TITLE_TEXT_Y   = 0,
	SUBHEADER_TO_WIDGET_GAP  = 15,
	SUBHEADER_RESERVE_Y      = 50,   -- must be ≥ bar height + gap + padding

	WIDGET_ROW_BG_ENABLED = true, -- master switch: enable background textures behind widget rows
	WIDGET_ROW_BG_TEX = "",  -- texture behind each widget row on the right side; "" = none
	WIDGET_ROW_BG_COLOR = "Interface\\BUTTONS\\WHITE8X8", -- solid color fallback when atlas and TEX are both empty/missing (e.g. "Interface\\BUTTONS\\WHITE8X8")
	WIDGET_ROW_BG_W   = 0,   -- width in px; 0 = full right-side content width
	WIDGET_ROW_BG_H   = 0,   -- height in px; 0 = match tallest widget in that row
	WIDGET_ROW_BG_GAP = 0,   -- extra px added to each row bg height; 0 = no extra space
	WIDGET_ROW_BG_Y   = 17,  -- Y offset from row start's TOPLEFT (positive = down)
	-- Color+opacity tint applied to the row bg texture (ignored when using a non-white texture)
	WIDGET_ROW_BG_R = 0.08, WIDGET_ROW_BG_G = 0.08, WIDGET_ROW_BG_B = 0.08, WIDGET_ROW_BG_A = 0.9,
	-- Color+opacity for the FULL background (separate from individual row BGs above)
	WIDGET_FULL_BG_R = 0.08, WIDGET_FULL_BG_G = 0.08, WIDGET_FULL_BG_B = 0.08, WIDGET_FULL_BG_A = 0.5,
	-- Padding added to each side of the row bg (positive = expand outward, negative = shrink inward)
	WIDGET_ROW_BG_PAD_L = 3, WIDGET_ROW_BG_PAD_R = 3,
	WIDGET_ROW_BG_PAD_T = 3, WIDGET_ROW_BG_PAD_B = 3,
	-- Horizontal insets for the full BG backdrop (positive = shrink inward on that side).
	-- Creates breathing room so 8-slice border corners aren't clipped by the frame edge.
	WIDGET_FULL_BG_INSET_L = 7,
	WIDGET_FULL_BG_INSET_R = 120,

	WIDGET_FULL_BG    = true, -- true = single full background per subgroup; false = individual row backgrounds
	WIDGET_FULL_BG_ATLAS = "common-dropdown-c-bg",  -- atlas for the full BG border+fill; "" = disabled (no atlas, gradient-only if enabled)
	WIDGET_FULL_BG_GRADIENT = true,  -- true = gradient overlay wash on top of atlas: transparent at top, light-wash at bottom
	WIDGET_FULL_BG_GRADIENT_DIRECTION = "TOP_BOTTOM",  -- gradient direction: "TOP_BOTTOM", "BOTTOM_TOP", "LEFT_RIGHT", "RIGHT_LEFT"
	WIDGET_FULL_BG_GRADIENT_OVERLAY_R = 0.35,  -- wash overlay color: red component (lighter values wash out the dark atlas fill)
	WIDGET_FULL_BG_GRADIENT_OVERLAY_G = 0.33,  -- wash overlay color: green component
	WIDGET_FULL_BG_GRADIENT_OVERLAY_B = 0.30,  -- wash overlay color: blue component
	WIDGET_FULL_BG_GRADIENT_TOP_A = 0,  -- wash strength at top (0 = transparent, atlas shows through; higher = more wash at top)
	WIDGET_FULL_BG_GRADIENT_BOTTOM_A = 0.3,  -- wash strength at bottom (0 = no wash, uniform dark; higher = lighter bottom)
	WIDGET_FULL_BG_GRADIENT_PAD_L = -5,  -- left padding inside atlas border (positive = shrink gradient inward)
	WIDGET_FULL_BG_GRADIENT_PAD_R = -3,  -- right padding
	WIDGET_FULL_BG_GRADIENT_PAD_T = -2,  -- top padding
	WIDGET_FULL_BG_GRADIENT_PAD_B = -3,  -- bottom padding
	WIDGET_ROW_BG_ALPHA_FIRST  = 0.5,   -- alpha for the 1st, 3rd, 5th... widget row under a subheader
	WIDGET_ROW_BG_ALPHA_SECOND = 0.5, -- alpha for the 2nd, 4th, 6th... widget row under a subheader

	FAQ_ROW_BG_ENABLED = true,
	FAQ_ROW_BG_TEX   = "", -- texture behind each FAQ entry; "" = use FAQ_ROW_BG_COLOR fallback
	FAQ_ROW_BG_COLOR = "Interface\\BUTTONS\\WHITE8X8", -- solid color fallback
	FAQ_ROW_BG_R = 0.08, FAQ_ROW_BG_G = 0.08, FAQ_ROW_BG_B = 0.08, FAQ_ROW_BG_A = 0.9,
	FAQ_ROW_BG_PAD_L = 0, FAQ_ROW_BG_PAD_R = 0,
	FAQ_ROW_BG_PAD_T = 0, FAQ_ROW_BG_PAD_B = 0,

	INFO_FRAME_WIDTH           = 300,
	INFO_TITLE_TOP_Y           = -16,
	INFO_TITLE_SEPARATOR_GAP   = -2,
	INFO_TITLE_SEPARATOR_INSET = 24,
	INFO_SCROLL_TOP_Y          = -66,
	INFO_SCROLL_BOTTOM_PAD     = 8,
	INFO_FRAME_CHROME_Y        = 74,  -- corrected below: -INFO_SCROLL_TOP_Y + INFO_SCROLL_BOTTOM_PAD
	INFO_TEXT_SIDE_PAD         = 14,
	INFO_TITLE_USE_MORPHEUS    = true,  -- true = use Morpheus font for the Tips and Info title
	INFO_TITLE_FONT_SIZE       = 18,     -- font size when INFO_TITLE_USE_MORPHEUS is true

	LEFT_MENU_BG_COLOR_R = 0.75, LEFT_MENU_BG_COLOR_G = 0.75,
	LEFT_MENU_BG_COLOR_B = 0.75, LEFT_MENU_BG_COLOR_A = 1,

	RIGHT_BODY_BG_COLOR_R = 1, RIGHT_BODY_BG_COLOR_G = 1,
	RIGHT_BODY_BG_COLOR_B = 1, RIGHT_BODY_BG_COLOR_A = 1,

	BORDER_OUTSET = 5.5,
	BORDER_SCALE  = 0.2,

	WIDGET_LABEL_R = 1, WIDGET_LABEL_G = 1, WIDGET_LABEL_B = 1, WIDGET_LABEL_A = 1,

	GLOBAL_BAR_LABEL_R = 1, GLOBAL_BAR_LABEL_G = 1, GLOBAL_BAR_LABEL_B = 1, GLOBAL_BAR_LABEL_A = 0.9,

	DROPLIST_LIST_BG_ATLAS = "common-dropdown-c-bg",
	BUTTON_HIGHLIGHT_ATLAS = "",
	EDITBOX_BG_ATLAS       = "",

	RIGHT_BODY_BG_TEX = _P.."bg\\bg-right-side.png",
	LEFT_PANEL_W      = 158,  -- total width of the left menu panel in px; the vertical divider line sits here; right panel starts here
	CONFIG_DRAG_HEIGHT = 95,   -- height in px of the draggable top bar area (covers logo → close button)
	LEFT_MENU_BG_TEX  = _P.."bg\\bg-right-side.png",
	INFO_FRAME_BG_TEX = _P.."bg\\side.png",
	SUBHEADER_BG_TEX  = _P.."subheaders\\sub-wood.png",

	SINCONFIRM_BTN_TEX               = _P.."buttons\\button-idle.png",
	SINCONFIRM_BTN_PRESSED_TEX       = _P.."buttons\\button-pressed.png",
	SINCONFIRM_HIGHLIGHT_TEX         = _P.."buttons\\highlight.png",
	SINCONFIRM_HIGHLIGHT_DESATURATED = true,
	SINCONFIRM_HIGHLIGHT_R = 1, SINCONFIRM_HIGHLIGHT_G = 0.9, SINCONFIRM_HIGHLIGHT_B = 0.2, SINCONFIRM_HIGHLIGHT_A = 0.8,
	SINCONFIRM_BG_TEX = _P.."bg\\side.png",  -- corrected below: = LEFT_MENU_BG_TEX
	CONFIRM_YES_BTN_TEX = _P.."checkbox\\cm.png",
	CONFIRM_YES_BTN_PRESSED_TEX = _P.."checkbox\\cm.png",
	CONFIRM_YES_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	CONFIRM_YES_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	CONFIRM_YES_BTN_W = 14, CONFIRM_YES_BTN_H = 14,
	CONFIRM_YES_BTN_X = 0, CONFIRM_YES_BTN_Y = 0,
	CONFIRM_NO_BTN_TEX = _P.."buttons\\reset.png",
	CONFIRM_NO_BTN_PRESSED_TEX = "",
	CONFIRM_NO_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	CONFIRM_NO_BTN_HIGHLIGHT_W = 12, -- 0 = auto-fit icon + text
	CONFIRM_NO_BTN_W = 14, CONFIRM_NO_BTN_H = 14,
	CONFIRM_NO_BTN_X = 0, CONFIRM_NO_BTN_Y = 0,

	INFO_BTN_TEX      = _P.."buttons\\help.png",
	INFO_BTN_W        = 33, INFO_BTN_H = 33,
	INFO_BTN_X_OFFSET = -2, INFO_BTN_Y_OFFSET = -30,
	INFO_BTN_HIGHLIGHT_TEX = _P.."buttons\\highlight2.png",
	INFO_BTN_HIGHLIGHT_R = red.r, INFO_BTN_HIGHLIGHT_G = red.g, INFO_BTN_HIGHLIGHT_B = red.b, INFO_BTN_HIGHLIGHT_A = 1,

	STAT_HEADER_HEIGHT   = 60,
	STAT_HEADER_WIDTH    = 0,
	STAT_HEADER_BG_ALPHA = 0.15, -- right-edge alpha for the stat header texture
	STAT_HEADER_FADE_LEFT_ALPHA = 0, -- 0 = fully faded at the left edge, 1 = match STAT_HEADER_BG_ALPHA (no fade)
	STAT_HEADER_USE_MORPHEUS = false,  -- true = use the game's Morpheus font for the stat title (Label)
	STAT_HEADER_FONT_SIZE    = 27,     -- font size for the stat title (only when STAT_HEADER_USE_MORPHEUS is true)
	STAT_DESC_USE_MORPHEUS   = true,  -- true = use Morpheus for the stat name above the separator (Description)
	STAT_DESC_FONT_SIZE      = 18,     -- font size when STAT_DESC_USE_MORPHEUS is true
	STAT_DESC_JUSTIFY        = "CENTER", -- "LEFT", "CENTER", or "RIGHT"
	STAT_DESC_X_OFFSET       = 0,    -- X offset from the Label's BOTTOM anchor
	STAT_DESC_R = orange.r, STAT_DESC_G = orange.g, STAT_DESC_B = orange.b, STAT_DESC_A = 1,  -- text color
	ACTIVE_HEADER_BG_TEX = _P.."bars\\header.png",
	-- ACTIVE_HEADER_BG_TEX = _P.."stats-headers\\header-button2.png",
	-- ACTIVE_HEADER_BG_R = 1, ACTIVE_HEADER_BG_G = 1, ACTIVE_HEADER_BG_B = 1, ACTIVE_HEADER_BG_A = 0.7,
	ACTIVE_HEADER_BG_R = 0.2, ACTIVE_HEADER_BG_G = 0.2, ACTIVE_HEADER_BG_B = 0.2, ACTIVE_HEADER_BG_A = 1,
	-- ACTIVE_HEADER_BG_PAD_LEFT = 20,
	-- ACTIVE_HEADER_BG_PAD_RIGHT = 20,
	ACTIVE_HEADER_BG_PAD_LEFT = 50,
	ACTIVE_HEADER_BG_PAD_RIGHT = 50,

	STAT_HEADER_BUTTON_TEX = _P.."subheaders\\sub-woodd.png",--_P.."stats-headers\\header-button.png",
	STAT_HEADER_BUTTON_DESATURATED = true,  -- true = desaturate the header button background texture
	STAT_HEADER_BUTTON_R = orange.r, STAT_HEADER_BUTTON_G = orange.g, STAT_HEADER_BUTTON_B = orange.b, STAT_HEADER_BUTTON_A = 0.5,
	-- STAT_HEADER_BUTTON_PAD_L = 20, STAT_HEADER_BUTTON_PAD_R = 20,
	-- STAT_HEADER_BUTTON_PAD_T = 6, STAT_HEADER_BUTTON_PAD_B = 7,
	-- header-button texture
	-- STAT_HEADER_BUTTON_PAD_L = 23, STAT_HEADER_BUTTON_PAD_R = 23,
	-- STAT_HEADER_BUTTON_PAD_T = 12, STAT_HEADER_BUTTON_PAD_B = 12,
	-- sub-woode texture
	STAT_HEADER_BUTTON_PAD_L = 80, STAT_HEADER_BUTTON_PAD_R = 80,
	STAT_HEADER_BUTTON_PAD_T = 5, STAT_HEADER_BUTTON_PAD_B = 5,

	HIDE_MAIN_MENU_SECTION_HEADERS = false,  -- true = hide the right-panel header (icon+text+texture) for section headers (Settings, Text, Layout, HUD Studio, Profiles, etc.)

	MAIN_MENU_HIGHLIGHT_TEX      = _P.."left-menu\\left1.png",   -- permanent static per stat button; used as the global fallback when SpellClass doesn't define texture=
	MAIN_MENU_STAT_PERM_TEX_ALPHA = 1,    -- alpha of the always-visible PermHighlightTex; reduce to lighten the selected state (SelectGlow stacks on top of it)
	MAIN_MENU_STAT_TEX_H         = 35, --30   -- permanent texture height in px; 0 = fill button height
	MAIN_MENU_STAT_W          = 145, -- 158    -- stat section button width in px; 0 = fill left panel width (sidePanelWidth)
	MAIN_MENU_STAT_X_OFFSET   = -3,      -- horizontal offset of stat section buttons from the left menu baseline (positive = right, negative = left)
	MAIN_MENU_STAT_GLOW_W     = 0,    -- hover/select glow width  in px; 0 = fill button width
	MAIN_MENU_STAT_GLOW_H     = 30,   -- hover/select glow height in px; 0 = fill button height
	MAIN_MENU_STAT_HIGHLIGHT_Y    = 0,  -- Y offset for stat section highlight / select-glow textures (positive = up)
	MAIN_MENU_STAT_TEX_RIGHT_GAP  = 0,  -- gap in px between the right edge of the hover/select/perm textures and the button's right edge; keeps auto-width while creating breathing room before the vertical divider line

	MAIN_MENU_STAT_SELECT_TEX         = _P.."left-menu\\hl2.png",   -- selected/expanded glow texture; "" = fall back to MAIN_MENU_HIGHLIGHT_TEX
	MAIN_MENU_STAT_SELECT_DESATURATED = false,
	MAIN_MENU_STAT_SELECT_R = orange.r, MAIN_MENU_STAT_SELECT_G = orange.g, MAIN_MENU_STAT_SELECT_B = orange.b, MAIN_MENU_STAT_SELECT_A = 0.5,

	-- ── Hover state — HighlightTexture slot, shown while mouse is over the button ──
	MAIN_MENU_STAT_HOVER_TEX          = _P.."buttons\\highlight.png",   -- hover glow texture; "" = fall back to MAIN_MENU_HIGHLIGHT_TEX
	MAIN_MENU_STAT_HOVER_DESATURATED  = false,
	MAIN_MENU_STAT_HOVER_R = red.r, MAIN_MENU_STAT_HOVER_G = red.g, MAIN_MENU_STAT_HOVER_B = red.b, MAIN_MENU_STAT_HOVER_A = 0,
	LEFT_DECO_BG_TEX        = "",--_P.."left-menu\\left-bg.png",  -- permanent gradient background per stat button
	-- LEFT_DECO_BG_W          = 130,    -- background texture width  in px; 0 = fill the inset rect inside MAIN_MENU_HIGHLIGHT_TEX
	-- LEFT_DECO_BG_H          = 20,   -- background texture height in px; 0 = fill the inset rect inside MAIN_MENU_HIGHLIGHT_TEX
	-- LEFT_DECO_BG_ALPHA      = 0.8,  -- alpha at the opaque end of the gradient
	LEFT_DECO_BG_W          = 0,    -- background texture width  in px; 0 = fill the inset rect inside MAIN_MENU_HIGHLIGHT_TEX
	LEFT_DECO_BG_H          = 0,   -- background texture height in px; 0 = fill the inset rect inside MAIN_MENU_HIGHLIGHT_TEX
	LEFT_DECO_BG_INSET_LEFT  = 1,    -- left inset in px applied when fitting LEFT_DECO_BG_TEX inside MAIN_MENU_HIGHLIGHT_TEX
	LEFT_DECO_BG_INSET_RIGHT = 2,    -- right inset in px applied when fitting LEFT_DECO_BG_TEX inside MAIN_MENU_HIGHLIGHT_TEX
	LEFT_DECO_BG_INSET_TOP   = 0,    -- top inset in px applied when fitting LEFT_DECO_BG_TEX inside MAIN_MENU_HIGHLIGHT_TEX
	LEFT_DECO_BG_INSET_BOTTOM = 2,   -- bottom inset in px applied when fitting LEFT_DECO_BG_TEX inside MAIN_MENU_HIGHLIGHT_TEX
	LEFT_DECO_BG_ALPHA              = 0.2,  -- alpha at the opaque end of the gradient when idle
	LEFT_DECO_BG_HOVER_ALPHA        = 1,    -- alpha at the opaque end when the button is hovered; 1 = fully opaque
	LEFT_DECO_BG_SELECT_ALPHA       = 1,    -- alpha at the opaque end when the button is selected/expanded
	LEFT_BG_FADE_OPACITY            = 1,  -- alpha at the transparent end (0 = fully transparent) when idle
	LEFT_DECO_BG_HOVER_FADE_OPACITY = 1,   -- alpha at the transparent end when hovered; 1 = fully opaque
	LEFT_DECO_BG_SELECT_FADE_OPACITY= 0.8,   -- alpha at the transparent end when selected/expanded
	LEFT_BG_FADE_LTR        = false, -- false = right-to-left (opaque right, fades left); true = left-to-right
	LEFT_DECO_BG_BLEND      = "ADD", -- texture blend mode: "BLEND" (normal), "ADD" (additive glow-on-glow), "MOD" (multiply)
	LEFT_DECO_BG_X          = 0,   -- X offset of the deco bg rect after insets are applied (negative = shift left)
	LEFT_DECO_BG_Y          = 0,    -- Y offset of the deco bg rect after insets are applied (positive = shift up)

	MAIN_MENU_STAT_ICON_IDLE_ALPHA   = 0.5,  -- icon alpha when button is idle (not hovered, not selected)
	MAIN_MENU_STAT_ICON_HOVER_ALPHA  = 1,    -- icon alpha when button is hovered
	MAIN_MENU_STAT_ICON_SELECT_ALPHA = 1,    -- icon alpha when button is selected/expanded
	MAIN_MENU_STAT_ICON_DESATURATED  = false,         -- global fallback (hover & select)
	MAIN_MENU_STAT_ICON_IDLE_DESATURATED = true,    -- desaturate icons in idle state
	MAIN_MENU_STAT_ICON_R            = 1,
	MAIN_MENU_STAT_ICON_G            = 1,
	MAIN_MENU_STAT_ICON_B            = 1,
	MAIN_MENU_STAT_ICON_X            = 9,    -- icon X offset from the LEFT anchor (positive = right)
	MAIN_MENU_STAT_ICON_Y            = 0,    -- icon Y offset (positive = up)
	MAIN_MENU_STAT_ICON_SIDE         = "RIGHT",  -- "LEFT" or "RIGHT" — side of the button the icon anchors to
	MAIN_MENU_STAT_TEXT_X_OFFSET     = 7,
	MAIN_MENU_STAT_TEXT_Y_OFFSET     = 0,
	MAIN_MENU_STAT_TEXT_SIZE         = 12,

	MAIN_MENU_STAT_TEXT_R        = 1, MAIN_MENU_STAT_TEXT_G        = 1, MAIN_MENU_STAT_TEXT_B        = 1, MAIN_MENU_STAT_TEXT_A        = 0.6,  -- idle
	MAIN_MENU_STAT_HOVER_TEXT_R  = 1, MAIN_MENU_STAT_HOVER_TEXT_G  = 1, MAIN_MENU_STAT_HOVER_TEXT_B  = 1, MAIN_MENU_STAT_HOVER_TEXT_A  = 1,  -- hovered
	MAIN_MENU_STAT_SELECT_TEXT_R = 1, MAIN_MENU_STAT_SELECT_TEXT_G = 1, MAIN_MENU_STAT_SELECT_TEXT_B = 1, MAIN_MENU_STAT_SELECT_TEXT_A = 1,  -- selected/expanded


	MAIN_MENU_SECTION_TEXT_R        = 1, MAIN_MENU_SECTION_TEXT_G        = 1, MAIN_MENU_SECTION_TEXT_B        = 1, MAIN_MENU_SECTION_TEXT_A        = 1,  -- idle
	MAIN_MENU_SECTION_HOVER_TEXT_R  = 1, MAIN_MENU_SECTION_HOVER_TEXT_G  = 1, MAIN_MENU_SECTION_HOVER_TEXT_B  = 1, MAIN_MENU_SECTION_HOVER_TEXT_A  = 1,  -- hovered
	MAIN_MENU_SECTION_SELECT_TEXT_R = 1, MAIN_MENU_SECTION_SELECT_TEXT_G = 1, MAIN_MENU_SECTION_SELECT_TEXT_B = 1, MAIN_MENU_SECTION_SELECT_TEXT_A = 1,  -- selected/expanded
	MAIN_MENU_SECTION_ICON_TEXT_GAP = 6,
	MAIN_MENU_SECTION_ICON_SIZE = 20, -- square icon size in px for non-stat menu buttons; 0 = keep current size
	MAIN_MENU_SECTION_ICON_DESATURATED = false,
	MAIN_MENU_SECTION_ICON_R = 1, MAIN_MENU_SECTION_ICON_G = 1, MAIN_MENU_SECTION_ICON_B = 1, MAIN_MENU_SECTION_ICON_A = 1,
	--MAIN_MENU_SECTION_ICON_R = 0.812, MAIN_MENU_SECTION_ICON_G = 0.686, MAIN_MENU_SECTION_ICON_B = 0.43, MAIN_MENU_SECTION_ICON_A = 0.8,
	MAIN_MENU_SECTION_W       = 0,    -- button width in px; 0 = fill left panel width (sidePanelWidth)
	MAIN_MENU_SECTION_PERM_TEX = "",  -- permanent background texture on every non-stat button; "" = none
	MAIN_MENU_SECTION_TEX   = _P.."buttons\\highlight.png",   -- texture path for hover and selected state
	MAIN_MENU_SECTION_TEX_W = 0,   -- texture width  in px; 0 = fill button width
	MAIN_MENU_SECTION_TEX_H = 0,   -- texture height in px; 0 = fill button height
	MAIN_MENU_SECTION_HIGHLIGHT_Y = 0,  -- Y offset for non-stat section button highlight texture (positive = up)
	MAIN_MENU_SECTION_TEXT_SIZE = 12,  -- font size for non-stat section buttons (Settings, Text, Layout, Profiles, etc.)

	MAIN_MENU_ITEM_GAP      = 0,   -- vertical gap between consecutive STAT section buttons only (negative = upward); non-stat buttons always use -5

	-- ── Active HUD Panel Switcher (top of right-side content area) ──────────────
	PANEL_SWITCHER_W              = 120,  -- width  in px of the closed bar
	PANEL_SWITCHER_H              = 20,   -- height in px of the closed bar
	PANEL_SWITCHER_ARROW_TEX      = _P.."droplist\\button.png",   -- open/close arrow icon; "" = default DropNormal icon
	PANEL_SWITCHER_BAR_TEX        = "",   -- bg texture of the closed bar; "" = solid colour backdrop
	PANEL_SWITCHER_LIST_TEX       = "",   -- bg texture of the popup list frame; "" = solid colour backdrop
	PANEL_SWITCHER_LIST_HIGHLIGHT = _P.."buttons\\highlight.png",   -- highlight texture on each list row; "" = default HighlightMenu
}

-- Cross-references: values that depend on other K entries.
local K = Ns.K
K.BAR_BTN_HIGHLIGHT_TEX     = K.BUTTON_HIGHLIGHT_TEX
K.LAYOUT_STAT_HIGHLIGHT_TEX = K.BUTTON_HIGHLIGHT_TEX
K.CONFIRM_BTN_TEX           = K.BUTTON_IDLE_TEX
K.CONFIRM_HIGHLIGHT_TEX     = K.BUTTON_HIGHLIGHT_TEX
--K.SINCONFIRM_BG_TEX         = K.LEFT_MENU_BG_TEX
--K.SUBHEADER_X_OFFSET        = K.SUBHEADER_INSET - 100
K.INFO_FRAME_CHROME_Y       = -K.INFO_SCROLL_TOP_Y + K.INFO_SCROLL_BOTTOM_PAD

-- Atlas config (consumed by Config.lua and IsTexturePath helper).
Ns.ConfigAtlas = {
	SubHeader       = "",
	FullBg          = K.WIDGET_FULL_BG_ATLAS,
	DropListListBg  = "common-dropdown-c-bg",
	EditBoxBg       = K.EDITBOX_BG_ATLAS,
	ButtonHighlight = K.BUTTON_HIGHLIGHT_ATLAS,
	WidgetRowBg     = "",--"collections-slotheader",  -- atlas for row bg; "" = use WIDGET_ROW_BG_TEX fallback
}
