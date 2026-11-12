local AddName, Ns = ...

if GetLocale() ~= "koKR" then return end

local L = Ns.RegisterLocale("koKR")

-- Global entries
L["Settings"] = "설정"
L["SettingsDescription"] = ""
L["TextMenu"] = "텍스트"
L["MinimapTMenu"] = "미니맵"
L["Text"] = "텍스트"
L["TextDescription"] = ""
L["Layout"] = "배치"
L["LayoutDescription"] = ""
L["Events"] = "스마트 HUD"
L["EventsDescription"] = ""
L["Profiles"] = "프로필"
L["ProfilesDescription"] = ""
L["JourneysDescription"] = ""
L["Journeys"] = "여정"

-- Spellclass
L["HUDMenu"] = "설정"
L["HUDsMenu"] = "HUD"
L["FontsMenu"] = "글꼴"
L["DisplayMenu"] = "표시"
L["DisplayOrderMenu"] = "배치"
L["EventsMenu"] = "이벤트"
L["ProfilesMenu"] = "프로필"
L["FAQMenu"] = "FAQ"

L["Attributes"] = "기본 능력치"
L["AttributesDescription"] = ""
L["Melee"] = "근접"
L["MeleeDescription"] = ""
L["Defense"] = "방어"
L["DefenseDescription"] = ""
L["Ranged"] = "원거리"
L["RangedDescription"] = ""
L["Spell"] = "주문"
L["SpellDescription"] = ""
L["Resistance"] = "저항"
L["ResistanceDescription"] = ""
L["Misc"] = "기타"
L["MiscDescription"] = ""
L["Pet"] = "소환수"
L["PetDescription"] = ""
L["Currency"] = "화폐"
L["CurrencyDescription"] = ""

-- HUD
L["HideHUD"] = "숨기기"
L["HideHUDTip"] = ""
L["LockHUD"] = "잠금"
L["LockHUDTip"] = ""
L["PanelMenu"] = "캐릭터 창"
L["PanelDisplay"] = "부착"
L["PanelDisplayTip"] = ""
L["ConfigShortcut"] = "설정 아이콘"
L["ConfigShortcutTip"] = ""
L["OpenSettings"] = "설정 열기"
L["BackgroundMenu"] = "배경"
L["HUDBgTexture"] = "텍스처"
L["HUDBgTextureTip"] = ""
L["HUDBgColor"] = "색상"
L["HUDBgColorTip"] = ""
L["HUDBgAlpha"] = "불투명도"
L["HUDBgAlphaTip"] = ""
L["BorderMenu"] = "테두리"
L["HUDBorder"] = "테두리"
L["HUDBorderTip"] = ""
L["HUDBorderTexture"] = "텍스처"
L["HUDBorderTextureTip"] = ""
L["HUDBorderColor"] = "색상"
L["HUDBorderColorTip"] = ""
L["HUDBorderSize"] = "크기"
L["HUDBorderSizeTip"] = ""
L["HUDBorderInset"] = "안쪽 여백"
L["HUDBorderInsetTip"] = ""
L["HideHeader"] = "헤더 텍스트"
L["HideHeaderTip"] = ""
L["HeaderOpacity"] = "헤더 투명도"
L["HeaderOpacityTip"] = ""
L["ResetPosition"] = "HUD 위치 초기화"
L["ResetPositionTip"] = "능력치 HUD 위치를 초기화합니다"
L["HUDStrataTip"] = ""
L["HUDStrata"] = "프레임 우선순위"
L["MinimapGroupText"] = "미니맵"
L["Minimap"] = "미니맵 버튼"
L["MinimapTip"] = ""
L["CompButton"] = "컴파트먼트 버튼"
L["CompButtonTip"] = ""
L["Lowest"] = "최하"
L["Low"] = "낮음"
L["Medium"] = "중간"
L["High"] = "높음"
L["Highest"] = "최상"
L["BarReverse"] = "반전"
L["BarReverseTooltip"] = Ns.Colors.Green .. "반전|r\n" .. "막대를 왼쪽 대신 오른쪽 끝에서부터\n채웁니다.\n\n동적 바에만 적용됩니다"
L["BarInvert"] = "채우기 반전"
L["BarInvertTooltip"] = Ns.Colors.Green .. "채우기 반전|r\n" .. "값이 감소할수록 막대가 채워져,\n현재 수치 대신 부족한 양을\n표시합니다.\n\n동적 바에만 적용됩니다"
L["BarHeight"] = "막대 높이"
L["PanelAttach"] = "고정"
L["PanelAttachTooltip"] = Ns.Colors.Green .. "고정|r\n" .. "HUD를 캐릭터 창의\n오른쪽에 고정합니다|r"
L["PanelAttachX"] = "고정 X 오프셋"
L["PanelAttachY"] = "고정 Y 오프셋"

-- Text
L["OutlineMenu"] = "외곽선"
L["StatFont"] = "글꼴"
L["StatFontTip"] = ""
L["StatFontSize"] = "크기"
L["StatFontSizeTip"] = ""
L["StatFontFlags"] = "외곽선"
L["StatFontFlagsTip"] = ""
L["FontShadowTip"] = ""
L["FontShadow"] = "그림자"
L["ShadowX"] = "X 오프셋"
L["ShadowXTip"] = ""
L["ShadowY"] = "Y 오프셋"
L["ShadowYTip"] = ""
L["Default Font"] = "Arial Narrow"
L["Thin"] = "얇게"
L["Thick"] = "두껍게"
L["Monochrome"] = "모노크롬"
L["Thin Monochrome"] = "얇은 모노크롬"
L["Thick Monochrome"] = "두꺼운 모노크롬"
L["None"] = "없음"

L["SpacingMenu"] = "간격"
L["StatWidth"] = "문자 길이"
L["StatWidthTip"] = ""
L["StatSpacingH"] = "텍스트 너비"
L["StatSpacingHTip"] = ""
L["StatSpacingV"] = "텍스트 높이"
L["StatSpacingVTip"] = ""

L["AlignMenu"] = "정렬"
L["AlignValuesTip"] = ""
L["AlignValues"] = "값 정렬"
L["AlignValuesTooltip"] = Ns.Colors.Green .. "값 정렬|r\n능력치 값을 깔끔한 열 형태로 정렬합니다"

L["AlignGap"] = "이름-값 간격"
L["AlignGapTip"] = ""

L["StatIconsTip"] = ""
L["StatIcons"] = "아이콘"

L["StatTextCapsTip"] = ""
L["StatTextCaps"] = "대문자"

L["StatTextColorTip"] = ""
L["StatTextColor"] = "레이블"

L["ClassColorsTip"] = ""
L["ClassColors"] = "직업 색상"

L["StatWidthTooltip"] = Ns.Colors.Green .. "텍스트 문자열 너비|r\n" ..
    "능력치 텍스트가 잘리지 않도록 문자열 너비를 조정합니다\n" ..
    "너비를 늘리면 더 많은 공간을 확보할 수 있습니다\n\n" ..
    "1줄 또는 1열 배치일 때는 이 옵션이 비활성화됩니다 (배치 메뉴 참고)"

L["StatAlignmentTip"] = ""
L["StatAlignment"] = "텍스트 정렬"

L["IconAlignment"] = "아이콘 정렬"
L["IconAlignmentTip"] = ""

L["GrowDirectionTip"] = ""
L["GrowDirection"] = "증가 방향"
L["Top to Bottom"] = "위에서 아래로"
L["Bottom to Top"] = "아래에서 위로"

L["GlobalColorMenu"] = "전체 색상"
L["DataColor"] = "값"
L["DataColorTip"] = ""

L["SplitColors"] = "값 색상"
L["SplitColorsTip"] = ""
L["SplitColorsTooltip"] =
    Ns.Colors.Green .. "값 텍스트 색상|r\n" ..
    "능력치 이름과 값의 색상을 분리하여 설정할 수 있습니다\n\n" ..
    "값 색상은 " .. Ns.Colors.Green .. "텍스트 색상 (값)|r 색상 선택기를 사용합니다"

L["Left"] = "왼쪽"
L["Right"] = "오른쪽"
L["Center"] = "가운데"

L["TextSeparator"] = "구분자"
L["TextSeparatorTip"] = ""

L["HideText"] = "레이블"
L["HideTextTip"] = ""

-- Profiles
L["Selected"] = "적용"
L["ProfileSelectLabel"] = "선택"
L["ProfileCreateCopy"] = "복사 생성"
L["ProfileCreateDefault"] = "기본 생성"
L["ProfileCopyFrom"] = "복사"
L["ProfileCopyWarning"] = "%s에서 %s로 프로필을 복사하시겠습니까?"
L["ProfileCopiedMsg"] = "프로필 %s이(가) %s로 복사되었습니다"
L["ProfileCreatedCopy"] = "프로필 %s이(가) %s에서 복사되어 생성되었습니다"
L["ProfileCreatedDefault"] = "기본 프로필 %s이(가) 성공적으로 생성되었습니다"
L["ProfileDeleteWarning"] = "이 프로필을 잃게 될 캐릭터:"
L["ProfileDeleteNoChars"] = "현재 이 프로필을 사용하는 캐릭터가 없습니다"
L["SpecProfilesEnable"] = "전문화 프로필"
L["SpecProfilesEnableTip"] =
    Ns.Colors.Green .. "전문화 프로필|r\n" ..
    "전문화를 변경할 때 자동으로 프로필을 전환합니다\n" ..
    "아래에서 각 전문화에 프로필을 지정하세요."
L["SpecProfileLabel"] = "%s:"
L["SpecProfileNone"] = "없음"
L["SelectProfile"] = "프로필 관리: 선택, 생성, 복사, 삭제"
L["ProfileSelected"] = "프로필"
L["ProfileUsed"] = "현재 사용 중인 프로필이므로 삭제할 수 없습니다!"
L["NewProfile"] = "생성"
L["CurrentProfile"] = "활성 프로필"
L["Copy"] = "복사 대상"
L["Delete"] = "삭제"
L["ConfirmDelete"] = "확인"
L["Cancel"] = "취소"
L["Clear"] = "초기화"
L["ProfileCopyDelete"] = "선택 후 삭제하거나 새 프로필로 복사합니다."
L["ProfileRenameLabel"] = "이름 변경"
L["ProfileExport"] = "내보내기"
L["ProfileImport"] = "가져오기"
L["ProfileExportTitle"] = "프로필 내보내기"
L["ProfileImportTitle"] = "프로필 가져오기"
L["ProfileExportCopy"] = "클립보드로 복사"
L["ProfileImportApply"] = "가져오기"
L["ProfileImportError"] = "잘못된 가져오기 문자열입니다!"
L["ProfileImportSuccess"] = "프로필 '%s'이(가) 성공적으로 가져와졌습니다!"
L["ProfileImportPlaceholder"] = "가져오기 문자열을 여기에 붙여넣으세요..."
L["SaveSpecRouting"] = "선택 저장"
L["SaveSpecRoutingTip"] = Ns.Colors.Green .. "선택 저장|r\n현재 프로필에 전문화 선택을 저장합니다"

-- HUD Studio
L["Panels"] = "HUD 스튜디오"
L["PanelManagementMenu"] = "HUD 스튜디오"
L["PanelCurrent"] = "활성 HUD"
L["PanelsDescription"] = ""
L["PanelSelectLabel"] = "선택"
L["PanelSwitch"] = "전환"
L["PanelCreateLabel"] = "생성"
L["PanelCopyCurrent"] = "활성 HUD 복사"
L["PanelCreate"] = "생성"
L["PanelDeleteLabel"] = "삭제"
L["PanelRenameLabel"] = "이름 변경"
L["PanelRename"] = "이름 변경"
L["PanelDeleteWarning"] = "%s을(를) 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다."
L["PanelDeletedMsg"] = "%s이(가) 성공적으로 삭제되었습니다"

-- HUD Import/Export
L["HUDImportSuccess"] = "HUD '%s'이(가) 성공적으로 가져와졌습니다!"

-- Search
L["Search"] = "검색"
L["SearchDescription"] = ""
L["SearchMenu"] = "검색"
L["RecentSearches"] = "최근 검색"
L["CurrText"] = "화폐를 표시합니다 "
L["RenoText"] = "평판 등급을 표시합니다 "

-- Global bar
L["GlobalBar_EnableAll"] = "모든 능력치 활성화"
L["GlobalBar_DisableAll"] = "모든 능력치 비활성화"
L["GlobalBar_RemoveBars"] = "모든 바 제거"
L["GlobalBar_ResetColor"] = "텍스트 색상 초기화"
L["GlobalBar_TextColor"] = "텍스트 색상"
L["GlobalBar_ConfirmEnable"] = "이 그룹의 모든 능력치를 활성화하시겠습니까?"
L["GlobalBar_ConfirmDisable"] = "이 그룹의 모든 능력치를 비활성화하시겠습니까?"
L["GlobalBar_ConfirmRemove"] = "이 그룹의 모든 바를 제거하시겠습니까?"
L["GlobalBar_ConfirmReset"] = "이 그룹의 모든 능력치 텍스트 색상을 초기화하시겠습니까?"
L["GlobalBar_QuickColor"] = "빠른 색상"
L["QuickColor_EnableAll"] = "개별 색상 활성화"

-- Layout
L["ClearAllColumns"] = "초기화"
L["Rows"] = "행 프리셋"
L["Columns"] = "열 프리셋"
L["OneRow"] = "1"
L["TwoRows"] = "2"
L["ThreeRows"] = "3"
L["FourRows"] = "4"
L["DisplayOrderDescription"] = ""
L["LayoutHint"] = "드래그하여 재정렬 | 우클릭으로 열 구분 | 완료 후 적용"
L["PanelsHint"] = "추가 HUD 패널 생성 및 관리"
L["ProfilesHint"] = "프로필 생성 및 관리 | 전문화별 프로필 설정"

-- Events
L["EventEnable"] = "활성화"
L["EventEnableTip"] = ""
L["EventEnableTooltip"] =
    Ns.Colors.Green .. "스마트 HUD|r\n" ..
    "아래 조건이 충족되면 HUD를 자동으로 표시하거나 숨깁니다\n\n" ..
    "전투가 가장 높은 우선순위를 가집니다"
L["EventWorld"] = "야외"
L["EventWorldTip"] = ""
L["EventDungeon"] = "던전"
L["EventRaid"] = "공격대"
L["EventPvP"] = "전장"
L["EventArena"] = "투기장"
L["EventCombat"] = "전투"
L["ShowStats"] = "능력치 표시 조건"
L["HideStats"] = "능력치 숨김 조건"
L["EventOpacity"] = "페이드"
L["EventOpacityTip"] = ""
L["EventOpacityTooltip"] = Ns.Colors.Green .. "페이드 불투명도|r\nHUD를 숨기는 대신 서서히 사라지게 합니다"
L["EventDelves"] = "델브"
L["EventResting"] = "휴식 (도시/여관)"
L["EventMounted"] = "탈것 탑승"
L["EventMouseOver"] = "마우스 오버"
L["EventTarget"] = "대상"
L["EventTargetHostile"] = "적대적 대상만"
L["EventSettingsMenu"] = "설정"
L["EventTimerTip"] = ""
L["EventTimer"] = "숨김 지연"
L["EventOpacityValue"] = "불투명도"
L["EventOpacityValueTip"] = ""
L["EventTime"] = "초"
L["EventTimeTip"] = ""
L["FAQDescription"] = ""

-- Minimap
L["QuickAccess"] = "빠른 접근"
L["OpenSettings"] = "설정 열기"
L["EnableDisable"] = "HUD 활성/비활성"
L["ShiftRightClick"] = "+ Shift"
L["UnlockHUD"] = "HUD 잠금/해제"

-- Gradient
L["GradientText"] = "그라데이션 텍스트"
L["GradientTextTip"] = ""
L["GradientTextTooltip"] =
    Ns.Colors.Green .. "그라데이션 텍스트|r\n" ..
    "현재 값과 최대 값의 비율에 따라 능력치 값을 그라데이션 색상으로 표시합니다"

-- Instance Timer
L["InstanceTimer"] = "타이머"
L["InstanceTimerMenu"] = "인스턴스 타이머"
L["InstanceTimerDescription"] =
    "던전 또는 공격대 내부에서 경과 시간을 표시합니다.\n\n" ..
    Ns.Colors.Green .. "입장 시 시작됩니다.\n" ..
    Ns.Colors.Green .. "퇴장 또는 완료 시 종료됩니다."

L["Timer_Format"] = "형식"
L["Timer_FormatTip"] = ""
L["Send_Chat"] = "채팅으로 전송"
L["Send_ChatTooltip"] =
    Ns.Colors.Green .. "채팅으로 전송|r\n" ..
    "완료 시간을 인스턴스 채팅에 전송합니다"

-- Custom Name
L["CustName"] = "이름"
L["CustNameTooltip"] =
    Ns.Colors.Green .. "이름|r\n" ..
    "이 능력치에 사용할 사용자 지정 이름을 입력합니다\n\n" ..
    "비워두면 기본 텍스트를 사용합니다\n\n" ..
    "공백을 입력하면 능력치 이름을 숨깁니다"

-- Stats text color
L["ColorCustom"] = "활성화"
L["ColorName"] = "레이블"
L["ColorClass"] = "직업 색상"
L["ColorValue"] = "값"
L["ColorValueEndableTip"] = ""
L["ColorValueEndable"] = "값 색상"

-- Stat options
L["GroupSetup"] = "설정"
L["GroupCaps"] = "능력치 상한"
L["GroupTextColor"] = "텍스트 색상"
L["GroupStatusBars"] = "상태 바"
L["BarMaxMode"] = "최대 값"
L["BarMaxModeTip"] = ""
L["BarMaxCustom"] = "사용자 지정"
L["BarMaxCustomTooltip"] = Ns.Colors.Green .. "사용자 지정|r\n능력치 바가 채워질 최대 값을 직접 설정합니다"
L["BarTexture"] = "텍스처"
L["BarTextureTip"] = ""
L["BarColor"] = "바 색상"
L["BarColorTip"] = ""
L["BarAlpha"] = "바 불투명도"
L["BarAlphaTip"] = ""
L["BarBgColor"] = "배경 색상"
L["BarBgColorTip"] = ""
L["BarBgAlpha"] = "배경 불투명도"
L["BarBgAlphaTip"] = ""
L["BarAutoColor"] = "진행도 색상"
L["BarAutoColorTooltip"] = Ns.Colors.Green .. "진행도 색상|r\n바의 현재 값에 따라 빨강(빈 상태)에서 초록(가득 찬 상태)으로 자동 그라데이션 적용"
L["AutoColorOff"] = "그라데이션 텍스트 비활성화"
L["AutoColorOffTip"] = ""
L["AutoColorOffTooltip"] = Ns.Colors.Green .. "그라데이션 텍스트|r\n능력치 값을 빨강(빈 상태)에서 초록(가득 찬 상태)으로 자동 그라데이션 적용"
L["Percentage"] = "백분율"
L["BarMaxCap"] = "상한"
L["Custom"] = "사용자 지정"
L["NextRank"] = "다음 등급"
L["MaxRank"] = "최대 등급"
L["JourneyBarMode"] = "최대 값"
L["JourneyBarModeTip"] = ""
L["SpeedBar"] = "최대 값"
L["SpeedBarTip"] = ""
L["Auto"] = "자동"
L["Steady Flying"] = "안정 비행"
L["Skyriding"] = "스카이라이딩"
L["On Foot"] = "도보"
L["Mounted"] = "탈것 탑승"

L["SpellPowerModifiers"] = "주문력 수정자\n"
L["BossArmorModifier"] = "레이드 보스 방어구 값\n"
L["TipsAndInfo"] = Ns.Colors.Green .. "팁과 정보! |r\n\n"
L["SinLive"] = Ns.Colors.Green .. "SinLive™ 통계! \n이 스탯은 대상과 상호작용하며 스케일에 따라 조정됩니다 |r\n\n"
L["NPCPlus3"] = "+3레벨 \n"
L["NPCPlus4"] = "+4레벨 \n"
L["NPC1to5"] = "+1~ +8레벨 \n"
L["NPCAnyLevel"] = "아무 레벨 \n"
L["NPCSameLevel"] = "동일 레벨 \n"	
L["DefaultValueText"] = Ns.Colors.Green .. "\n\n[기본값] |r\n"
L["ScalingText"] = Ns.Colors.Green .. "\n[대상 스케일링] |r\n"

L["CommonScaling"] = "이 스탯은 다른 스탯들과 함께 스케일링 됩니다. \n"
L["Enhanced_BaseTooltip"] = Ns.Colors.Green .. "[강화된]|r\n" .. "툴팁은 특성, 버프, 보석, 마부 등을 포함하여 최고의 정확도을 제공합니다 \n\n" .. Ns.Colors.Green .. "[기본]|r\n" .. "툴팁은 추가내용 없이 캐릭터 패널에 표시되는 기본값을 표시합니다"
L["Percent_RatingTooltip"] = Ns.Colors.Green .. "[퍼센트는]|r\n" .. "이 스탯의 백분율 값을 표시합니다 \n\n" .. Ns.Colors.Green .. "[수치는]|r\n" .. "이 스탯의 수치 값을 표시합니다"
L["Main_Off_HandTooltip"] = Ns.Colors.Green .. "[주무기는]|r\n" .. "이 스탯의 주무기 값을 표시합니다 \n\n" .. Ns.Colors.Green .. "[보조무기는]|r\n" .. "이 스탯의 보조무기 값을 표시합니다"
L["Level_Same_BossTooltip"] = Ns.Colors.Green .. "[동일레벨은]|r\n" .. "자신과 같은 레벨의 NPC에 대한 값을 표시합니다 \n\n" .. Ns.Colors.Green .. "[보스레벨은]|r\n" .. "자신보다 1~5레벨 높은 NPC에 대한 값을 표시합니다"
L["Crit_Damage_TakenTooltip"] = Ns.Colors.Green .. "[피치명은]|r\n" .. "도트뎀의 감소와 치명타 피격 확률의 감소를 표시합니다 \n\n" .. Ns.Colors.Green .. "[뎀감은]|r\n" .. "플레이어와 소환수로부터 받는 모든 피해 감소율을 표시합니다"
L["Chance_ReductionTooltip"] = Ns.Colors.Green .. "[확률은]|r\n" .. "치명타에 맞을 확률을 표시합니다 \n\n" .. Ns.Colors.Green .. "[감소는]|r\n" .. "치명이뮨에 도달하기 위한 감소값을 표시합니다"
L["Total_RatingTooltip"] = Ns.Colors.Green .. "[전체]|r\n" .. "기본값과 보너스를 모두 포함하는 총 방어숙련도 값을 표시합니다 \n\n" .. Ns.Colors.Green .. "[수치는]|r\n" .. "이 스탯의 수치 값을 표시합니다"
L["Max_Average_DamageTooltip"] = Ns.Colors.Green .. "[최대는]|r\n" .. "데미지의 최대값을 표시합니다 \n\n" .. Ns.Colors.Green .. "[평균은]|r\n" .. "최대값을 평균값으로 바꿔줍니다"
L["Regen_Normal_CastingTooltip"] = Ns.Colors.Green .. "[평상시는]|r\n" .. "전투 중이 아닐 때 마나 재생량을 표시합니다 \n\n" .. Ns.Colors.Green .. "[전투]|r\n" .. "전투 중 마나 재생량을 표시합니다"
L["World_RealmTooltip"] = Ns.Colors.Green .. "[월드는]|r\n" .. "컴퓨터와 게임 월드간 연결의 게임내 지연시간을 표시합니다 \n\n" .. Ns.Colors.Green .. "[서버는]|r\n" .. "컴퓨터와 블리자드 서버간 연결 평균 지연 시간을 밀리초 단위로 표시합니다"
L["Main_Off_AutoTooltip"] = Ns.Colors.Green .. "[주무기는]|r\n" .. "이 스탯의 주무기 값을 표시합니다 \n\n" .. Ns.Colors.Green .. "[보조무기는]|r\n" .. "이 스탯의 보조무기 값을 표시합니다 \n\n" .. Ns.Colors.Green .. "[자동은]|r\n" .. "양손인지 쌍수인지를 자동으로 감지하고 그에 따른 스탯을 표시합니다 \n"
L["Total_Equipped_BagsTooltip"] = Ns.Colors.Green .. "[총합]|r\n" .. "장비한 장비와 가방에 담긴 장비의 총 수리 비용을 표시합니다 \n\n" .. Ns.Colors.Green .. "[갖추어 준]|r\n" .. "장착 장비의 수리 비용만 표시 \n\n" .. Ns.Colors.Green .. "[자루]|r\n" .. "가방에 있는 장비의 수리 비용만 표시"
L["Heroism_ValorTooltip"] = Ns.Colors.Green .. "[무용]|r\n" .. "영웅의 문양 수량을 표시합니다 \n\n" .. Ns.Colors.Green .. "[용맹]|r\n" .. "용맹의 상징 수량을 표시합니다"
L["Shards_MarksTooltip"] = Ns.Colors.Green .. "[파편]|r\n" .. "돌지기의 조각 수량을 표시합니다 \n\n" .. Ns.Colors.Green .. "[훈장]|r\n" .. "겨울손아귀 명예 훈장의 수량을 표시합니다"
L["Honor_ArenaTooltip"] = Ns.Colors.Green .. "[명예]|r\n" .. "총 명예 점수를 표시합니다 \n\n" .. Ns.Colors.Green .. "[투기장]|r\n" .. "총 투기장 화재를 표시합니다"
L["Player_PetTooltip"] = Ns.Colors.Green .. "[플레이어]|r\n" .. "플레이어의 마법 저항력 표시 \n\n" .. Ns.Colors.Green .. "[애완동물]|r\n" .. "펫의 마법 저항력을 표시합니다"
L["Mood_DamageTooltip"] = Ns.Colors.Green .. "[분위기]|r\n" .. "애완 동물의 기분에 대한 정보 표시 \n\n" .. Ns.Colors.Green .. "[뎀감은]|r\n" .. "애완 동물의 손상 수정자를 표시합니다"
L["Speed_StaticTooltip"] = Ns.Colors.Green .. "실시간|r\n" .. "캐릭터의 모든 이동 속도를 실시간으로 표시합니다(서기, 달리기, \n수영, 비행, RP 걷기 등) \n\n" .. Ns.Colors.Green .. "정적|r\n" .. "캐릭터의 이동 속도는 정적이며 \n이동 방법이 변경될 때만 변경됩니다"
L["Total_ModifiersTooltip"] = Ns.Colors.Green .. "전체|r\n" .. "추가된 모든 수정자를 포함하여 총 완화를 표시합니다 \n\n" .. Ns.Colors.Green .. "기본|r\n" .. "수정자를 제외하고 기본 완화를 표시합니다 \n\n" .. Ns.Colors.Green .. "수정자|r\n" .. "모든 완화 수정자의 백분율을 표시합니다"
L["Value_RatingTooltip"] = Ns.Colors.Green .. "값|r\n" .. "값을 표시합니다 \n\n" .. Ns.Colors.Green .. "[수치는]|r\n" .. "이 스탯의 수치 값을 표시합니다"
L["Equip_MaxTooltip"] = Ns.Colors.Green .. "갖추게 하는|r\n" .. "장착한 장비의 평균 아이템 레벨 \n\n" .. Ns.Colors.Green .. "최대|r\n" .. "가방을 포함한 모든 장비의 최대 아이템 레벨"

L["Display_MainHandTooltip"] = Ns.Colors.Green .. "[주무기만은]|r\n" .. "해당되는 경우 보조무기의 자동 표시를 비활성화합니다"L["Display_TotalTooltip"] = Ns.Colors.Green .. "총 인원|r\n" .. "접속 수 옆에 총 인원 수를 \n표시합니다"
L["BNet_RealmTooltip"] = Ns.Colors.Green .. "BattleNet|r\n" .. "접속 중인 BattleNet 친구를 표시합니다 \n\n" .. Ns.Colors.Green .. "서버|r\n" .. "접속 중인 서버 친구를 표시합니다 \n\n" .. Ns.Colors.Green .. "모두|r\n" .. "BattleNet과 서버 친구를 \n모두 표시합니다"L["Display_AverageTooltip"] = Ns.Colors.Green .. "[평균은]|r\n" .. "최대값을 평균값으로 바꿔줍니다"
L["Display_BasicTooltip"] = Ns.Colors.Green .. "[기본은]|r\n" .. "추가사항 없이 캐릭터 창에 표시되는 기본값 만을 표시합니다"
L["Display_SimulateTooltip"] = "시뮬레이트는 \n전투에서 수행한 실제 수치에서 수집한 통계 값을 보여줍니다. \n\n트래커는 전투에 들어가 \n다시 피해를 입히면 재설정됩니다"

L["AP"] = "전투력"
L["APMenu"] = "전투력"
L["APTip"] = ""
L["APDescription"] = L["TipsAndInfo"] .. "근접 전투력 \n" .. Ns.Colors.Red .. "붉은색 값|r은 디버프에 영향받는 중임을 알려줍니다"

L["DMG"] = "데미지"
L["DMGMenu"] = "데미지"
L["DMGTip"] = ""
L["DMGDescription"] = L["SinLive"].. Ns.Colors.Red .. "붉은색 값|r은 디버프에 영향받는 중임을 알려줍니다 \n"

L["mDPS"] = "DPS"
L["mDPSMenu"] = "DPS"
L["mDPSTip"] = ""
L["mDPSDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "붉은색 값|r은 디버프에 영향받는 중임을 알려줍니다 \n" .. "이 스탯은 공속과 데미지에 의한 보정을 받습니다"

L["Crit"] = "치명타"
L["CritMenu"] = "치명타"
L["CritTip"] = ""
L["CritDescription"] = L["TipsAndInfo"] .. "근접 치명타 확률. PvP 특정 치명 특성에 의한 치명타 확률은 현재 확률 옆에 색칠되어 나옵니다"

L["CritBoss"] = "치명타+"
L["CritBossMenu"] = "치명타 vs 보스"
L["CritBossTip"] = ""
L["CritBossDescription"] = L["SinLive"] .. "PVE에서 높은레벨의NPC(우두머리)에 대한 근접 치명타 값. 모든 치명타 보정 오라를 포함합니다" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPC1to5"]

L["CritCap"] = "치명 캡"
L["CritCapMenu"] = "치명타 캡"
L["CritCapTip"] = ""
L["CritCapDescription"] = L["TipsAndInfo"] .. "보스에 대한 치명타 캡을 표시합니다. 이 스탯은 사용중인 무기에 의해 스케일링됩니다 \n" .. Ns.Colors.Red .. "붉은색 치명타캡 값|r은 치명타 캡에 도달했다는 것을 알려줍니다 \n\n"

L["Hit"] = "적중"
L["HitMenu"] = "적중"
L["HitTip"] = ""
L["HitDescription"] = L["TipsAndInfo"] .. "근접 적중을 표시합니다 (퍼센트, 수치, 모두) \n" .. Ns.Colors.Green .. "녹색 값|r은 적중값 목표를 달성했음을 알려줍니다"

L["HasteMelee"] = "가속"
L["HasteMeleeMenu"] = "가속"
L["HasteMeleeTip"] = ""
L["HasteMeleeDescription"] = L["TipsAndInfo"] .. "근접 가속을 표시합니다 (퍼센트, 수치, 모두)"

L["weaponSpeed"] = "공격속도"
L["weaponSpeedMenu"] = "공격속도"
L["weaponSpeedTip"] = ""
L["weaponSpeedDescription"] = "근접 공격속도를 표시합니다 (주무기, 보조무기, 자동)"

L["Expertise"] = "숙련도"
L["ExpertiseMenu"] = "숙련도"
L["ExpertiseTip"] = ""
L["ExpertiseDescription"] = L["TipsAndInfo"] .. "공격이 회피되거나 무기막기에 막힐 (확률, 수치, 모두) \n" .. Ns.Colors.Green .. "녹색 값|r은 숙련도값 목표를 달성했음을 알려줍니다"

L["ArmorPen"] = "방어구 관통"
L["ArmorPenMenu"] = "방어구 관통"
L["ArmorPenTip"] = ""
L["ArmorPenDescription"] = L["TipsAndInfo"] .. "대상의 방어도가 무시될 (확률, 수치, 모두)"

L["NPCArmor"] = "방어력+"
L["NPCArmorMenu"] = "보스 방어력"
L["NPCArmorTip"] = ""
L["NPCArmorDescription"] = L["SinLive"] .. "보스NPC의 방어도값. 방어도값을 표시하려면 대상을 선택해야 합니다 \n" .. L["ScalingText"] .. L["BossArmorModifier"]

L["BossReduc"] = "데미지-"
L["BossReducMenu"] = "데미지 감소"
L["BossReducTip"] = ""
L["BossReducDescription"] = L["SinLive"] .. "보스NPC의 방어도에 기반한 물리피해 감소 비율 \n일반몹을 대상잡을 경우, 방어력 감소 디버프의 총 값이 표시됩니다 \n감소값을 표시하려면 대상을 선택해야 합니다 \n" .. L["ScalingText"] .. L["NPCPlus3"] .. L["BossArmorModifier"]

L["MeleeMiss"] = "빗맞힘"
L["MeleeMissMenu"] = "빗맞힘률"
L["MeleeMissTip"] = ""
L["MeleeMissDescription"] = L["SinLive"] .. "NPC에 대한 근접무기의 빗맞힘률 (동일레벨, 보스레벨, 모두)" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPC1to5"]

L["Avoidance"] = "CTC"
L["AvoidanceMenu"] = "CTC"
L["AvoidanceTip"] = ""
L["AvoidanceDescription"] = L["SinLive"] .. "전투 테이블 범위 (Combat Table Coverage) '적중 불가능'이라고도 합니다 \n" .. Ns.Colors.Green .. "녹색의 회피|r값은 회피 한도에 도달했음을 나타냅니다" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPC1to5"]

L["Crushing"] = "강타"
L["CrushingMenu"] = "강타"
L["CrushingTip"] = ""
L["CrushingDescription"] = L["SinLive"] .. "강타에 맞을 확률입니다 \n" .. Ns.Colors.Green .. "녹색 강타|r 값은 당신이 강타에 맞지 않는다는 것을 알려줍니다" .. L["DefaultValueText"] .. L["NPCPlus4"] .. L["ScalingText"] .. L["NPCAnyLevel"]

L["CritReceived"] = "치명피격률"
L["CritReceivedMenu"] = "치명피격률" 
L["CritReceivedTip"] = ""
L["CritReceivedDescription"] = L["SinLive"] .. "치명타 적중 확률 \n" .. Ns.Colors.Green .. "녹색 치명타 율|r은 치명타 면역을 나타냅니다 \n" .. Ns.Colors.Red .. "붉은색 치명피격|r률은 치명타 맞을 확률이 존재한다는 것을 알려줍니다" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPCAnyLevel"]

L["EHP"] = "EHP"
L["EHPMenu"] = "EHP"
L["EHPTip"] = ""
L["EHPDescription"] = L["SinLive"] .. Ns.Colors.Green .. "유효 HP(완화되지 않은 총 피해)"  .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPCAnyLevel"]

L["MobMiss"] = "Miss+"
L["MobMissMenu"] = "Boss Miss"
L["MobMissTip"] = ""
L["MobMissDescription"] = L["TipsAndInfo"] .. "보스 레벨 NPC가 당신에 대한 공격을 놓칠 확률"

L["Resilience"] = "탄력도"
L["ResilienceMenu"] = "탄력도"
L["ResilienceTip"] = ""
L["ResilienceDescription"] = L["TipsAndInfo"] .. "탄력도는 피치명과 플레이어 뎀감률을 표시합니다"

L["Armor"] = "갑옷"
L["ArmorMenu"] = "갑옷"
L["ArmorTip"] = ""
L["ArmorDescription"] = L["TipsAndInfo"] .. "보정을 포함한 방어도값 입니다 \n" .. Ns.Colors.Red .. "붉은색 방어도 값|r은 디버프의 영향을 받고 있음을 알려줍니다 \n" ..  Ns.Colors.Green ..  "녹색의 방어구 |r은 방어구 한도에 도달했음을 나타냅니다"

L["Mitigation"] = "데미지 감소"
L["MitigationMenu"] = "데미지 감소"
L["MitigationTip"] = ""
L["MitigationDescription"] = L["SinLive"] .. "데미지 감소 퍼센트입니다 \n" .. Ns.Colors.Green .. "녹색 데미지 감소 값|r은 뎀감 캡에 도달했다는 것을 알려줍니다" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPCAnyLevel"]

L["DefenseStat"] = "방어 숙련"
L["DefenseStatMenu"] = "방어 숙련도"
L["DefenseStatTip"] = ""
L["DefenseStatDescription"] = L["TipsAndInfo"] .. "방어 숙련도를 표시합니다(종합, 수치, 모두) \n" .. Ns.Colors.Green .. "녹색의 방어 숙련도 값|r은 레이드 보스에 대한 방숙 캡에 도달했음을 알려줍니다"

L["HitReduction"] = "피격률 감소"
L["HitReductionMenu"] = "피격률 감소"
L["HitReductionTip"] = ""
L["HitReductionDescription"] = L["TipsAndInfo"] .. "특성이나 디버프에 의한 물리공격의 피격률 감소입니다"

L["Dodge"] = "회피율"
L["DodgeMenu"] = "회피율"
L["DodgeTip"] = ""
L["DodgeDescription"] = L["TipsAndInfo"] .. "공격을 회피할 확률입니다(퍼센트, 수치, 모두)"

L["Parry"] = "무기막기"
L["ParryMenu"] = "무기막기"
L["ParryTip"] = ""
L["ParryDescription"] = L["TipsAndInfo"] .. "공격을 무기막기할 확률입니다(퍼센트, 수치, 모두)"

L["Block"] = "방패막기"
L["BlockMenu"] = "방패막기"
L["BlockTip"] = ""
L["BlockDescription"] = L["TipsAndInfo"] .. "공격을 방패막기할 확률입니다(퍼센트, 수치, 모두)"

L["RAP"] = "원거리 전투력"
L["RAPMenu"] = "전투력"
L["RAPTip"] = ""
L["RAPDescription"] = L["SinLive"] .. "원거리 전투력 \n"  .. Ns.Colors.Red .. "붉은색 값|r은 디버프에 영향받는 중임을 알려줍니다 \n"

L["RDMG"] = "원거리 데미지"
L["RDMGMenu"] = "데미지"
L["RDMGTip"] = ""
L["RDMGDescription"] = L["SinLive"] .. Ns.Colors.Red .. "붉은색 값|r은 디버프에 영향받는 중임을 알려줍니다 \n"

L["rDPS"] = "원거리 DPS"
L["rDPSMenu"] = "DPS"
L["rDPSTip"] = ""
L["rDPSDescription"] = L["TipsAndInfo"] .. "DPS를 표시합니다. (최대, 평균, 모두) \n" .. Ns.Colors.Red .. "붉은색 값|r은 디버프에 영향받는 중임을 표시해줍니다 \n\n" .. "이 스탯은 공속과 데미지에 의한 보정을 받습니다"

L["RangedCrit"] = "원거리 치명"
L["RangedCritMenu"] = "치명타율"
L["RangedCritTip"] = ""
L["RangedCritDescription"] = L["SinLive"] .. "치명타 확률을 표시합니다(퍼센트, 수치, 모두) \nPvP 특정 치명 특성에 의한 치명타 확률은 현재 확률 옆에 색칠되어 나옵니다 \n"

L["RangedCritBoss"] = "원거리 치명+"
L["RangedCritBossMenu"] = "치명타율 vs 보스"
L["RangedCritBossTip"] = ""
L["RangedCritBossDescription"] = L["SinLive"] .. "PVE에서 높은레벨의NPC(우두머리)에 대한 원거리 치명타 값. \n모든 치명타 보정 오라를 포함합니다" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPC1to5"]

L["RangedHit"] = "원거리 적중"
L["RangedHitMenu"] = "적중"
L["RangedHitTip"] = ""
L["RangedHitDescription"] = L["TipsAndInfo"] .. "원거리 적중을 표시합니다.(퍼센트, 수치, 모두) \n" .. Ns.Colors.Green .. "녹색 값|r은 적중값 목표를 달성했음을 알려줍니다"

L["HasteRanged"] = "원거리 가속"
L["HasteRangedMenu"] = "가속"
L["HasteRangedTip"] = ""
L["HasteRangedDescription"] = L["TipsAndInfo"] .. "원거리 가속을 표시합니다.(퍼센트, 수치, 모두)"

L["RangedPen"] = "원거리 방관"
L["RangedPenMenu"] = "방어구 관통"
L["RangedPenTip"] = ""
L["RangedPenDescription"] = L["TipsAndInfo"] .. "원거리 공격으로 대상의 방어도를 무시할 확률입니다"

L["rangedSpeed"] = "원거리 공격 속도"
L["rangedSpeedMenu"] = "공격 속도"
L["rangedSpeedTip"] = ""
L["rangedSpeedDescription"] = L["TipsAndInfo"] .. "착용 중인 원거리 무기의 공격 속도입니다"

L["RangedMiss"] = "원거리 빗맞힘률"
L["RangedMissMenu"] = "빗맞힘률"
L["RangedMissTip"] = ""
L["RangedMissDescription"] = L["SinLive"] .. "원거리 빗맞힘률을 표시합니다 (동일 레벨, 보스 레벨, 모두)" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPC1to5"]

L["Fire"] = "화염"
L["FireMenu"] = "화염 주문력"
L["FireTip"] = ""
L["FireDescription"] = L["SinLive"] .. "화염 주문력 \n" .. L["ScalingText"] .. L["SpellPowerModifiers"]

L["Frost"] = "냉기"
L["FrostMenu"] = "냉기 주문력"
L["FrostTip"] = ""
L["FrostDescription"] = L["SinLive"] .. "냉기 주문력 \n" .. L["ScalingText"] .. L["SpellPowerModifiers"]

L["Arcane"] = "비전"
L["ArcaneMenu"] = "비전 주문력"
L["ArcaneTip"] = ""
L["ArcaneDescription"] = L["SinLive"] .. "비전 주문력 \n" .. L["ScalingText"] .. L["SpellPowerModifiers"]

L["Shadow"] = "암흑"
L["ShadowMenu"] = "암흑 주문력"
L["ShadowTip"] = ""
L["ShadowDescription"] = L["SinLive"] .. "암흑 주문력 \n" .. L["ScalingText"] .. L["SpellPowerModifiers"]

L["Nature"] = "자연"
L["NatureMenu"] = "자연 주문력"
L["NatureTip"] = ""
L["NatureDescription"] = L["SinLive"] .. "자연 주문력 \n" .. L["ScalingText"] .. L["SpellPowerModifiers"]

L["Healing"] = "치유"
L["HealingMenu"] = "주문 치유량"
L["HealingTip"] = ""
L["HealingDescription"] = L["TipsAndInfo"] .. "주문 치유량"

L["Holy"] = "신성"
L["HolyMenu"] = "신성 주문력"
L["HolyTip"] = ""
L["HolyDescription"] = L["SinLive"] .. "신성 데미지 \n" .. L["ScalingText"] .. L["SpellPowerModifiers"]

L["SpellCrit"] = "주문 치명"
L["SpellCritMenu"] = "치명타 확률"
L["SpellCritTip"] = ""
L["SpellCritDescription"] = L["SinLive"] .. "치명타 확률을 표시합니다(퍼센트, 수치, 모두) \nPvP 특정 치명 특성에 의한 치명타 확률은 현재 확률 옆에 색칠되어 나옵니다 \n"

L["SpellCritBoss"] = "주문 치명+"
L["SpellCritBossMenu"] = "치명 vs 보스"
L["SpellCritBossTip"] = ""
L["SpellCritBossDescription"] = L["SinLive"] .. "PVE에서 높은레벨의NPC(우두머리)에 대한 주문 치명타 값. 모든 치명타 보정 오라를 포함합니다" .. L["DefaultValueText"] .. L["NPCPlus3"] .. L["ScalingText"] .. L["NPCAnyLevel"]

L["SpellHit"] = "주문 적중"
L["SpellHitMenu"] = "적중"
L["SpellHitTip"] = ""
L["SpellHitDescription"] = L["SinLive"] .. "주문 적중을 표시합니다 (퍼센트, 수치, 모두) \n" .. Ns.Colors.Green .. "녹색 값|r은 적중값 목표를 달성했음을 알려줍니다"

L["HasteCaster"] = "주문 가속"
L["HasteCasterMenu"] = "가속"
L["HasteCasterTip"] = ""
L["HasteCasterDescription"] = L["TipsAndInfo"] .. "주문 가속을 표시합니다 (퍼센트, 수치, 모두)"

L["SpellPenetration"] = "주문 관통"
L["SpellPenetrationMenu"] = "관통"
L["SpellPenetrationTip"] = ""
L["SpellPenetrationDescription"] = L["TipsAndInfo"] .. "주문이 타겟의 주문 저항을 무시할 확률입니다"

L["SpellMiss"] = "주문 빗맞힘률"
L["SpellMissMenu"] = "빗맞힘률"
L["SpellMissTip"] = ""
L["SpellMissDescription"] = L["SinLive"] .. "주문 빗맞힘률을 표시합니다 (동일 레벨, 보스 레벨, 모두) \n" .. L["ScalingText"] .. L["NPC1to5"]

L["ManaRegen"] = "마젠2"
L["ManaRegenMenu"] = "마젠2"
L["ManaRegenTip"] = ""
L["ManaRegenDescription"] = L["TipsAndInfo"] .. "2초당 마나 회복량을 표시합니다"

L["MP5"] = "마젠5"
L["MP5Menu"] = "마젠5"
L["MP5Tip"] = ""
L["MP5Description"] = L["TipsAndInfo"] .. "5초당 마나 회복량을 표시합니다"

L["FireResist"] = "화염 저항"
L["FireResistMenu"] = "화염 저항"
L["FireResistTip"] = ""
L["FireResistDescription"] = L["TipsAndInfo"] .. "화염 주문 데미지에 대한 저항값을 표시합니다"

L["FrostResist"] = "냉기 저항"
L["FrostResistMenu"] = "냉기 저항"
L["FrostResistTip"] = ""
L["FrostResistDescription"] = "냉기 주문 데미지에 대한 저항값을 표시합니다"

L["ShadowResist"] = "암흑 저항"
L["ShadowResistMenu"] = "암흑 저항"
L["ShadowResistTip"] = ""
L["ShadowResistDescription"] = "암흑 주문 데미지에 대한 저항값을 표시합니다"

L["ArcaneResist"] = "바전 저항"
L["ArcaneResistMenu"] = "비전 저항"
L["ArcaneResistTip"] = ""
L["ArcaneResistDescription"] = "비전 주문 데미지에 대한 저항값을 표시합니다"

L["NatureResist"] = "자연 저항"
L["NatureResistMenu"] = "자연 저항"
L["NatureResistTip"] = ""
L["NatureResistDescription"] = "자연 주문 데미지에 대한 저항값을 표시합니다"

L["Threat"] = "위협"
L["ThreatMenu"] = "위협"
L["ThreatTip"] = ""
L["ThreatDescription"] = L["TipsAndInfo"] .. "백분율, 값 또는 둘 다로 현재 대상에 대한 위협"

L["GearScore"] = "GearScore"
L["GearScoreMenu"] = "GearScore"
L["GearScoreTip"] = ""
L["GearScoreDescription"] = L["TipsAndInfo"] .. "장착한 장비의 평균 장비 점수"

L["ItemLevel"] = "아이템 레벨"
L["ItemLevelMenu"] = "아이템 레벨"
L["ItemLevelTip"] = ""
L["ItemLevelDescription"] = L["TipsAndInfo"] .. STAT_AVERAGE_ITEM_LEVEL_TOOLTIP

L["GlobalCD"] = "Gcd"
L["GlobalCDMenu"] = "GCD"
L["GlobalCDTip"] = ""
L["GlobalCDDescription"] = L["TipsAndInfo"] .. "전역 재사용 대기시간"

L["ValorPoints"] = "용맹 점수"
L["ValorPointsMenu"] = "용맹 점수"
L["ValorPointsTip"] = ""
L["ValorPointsDescription"] = L["TipsAndInfo"] .. "용맹 점수"

L["JusticePoints"] = "정의 점수"
L["JusticePointsMenu"] = "정의 점수"
L["JusticePointsTip"] = ""
L["JusticePointsDescription"] = L["TipsAndInfo"] .. "정의 점수"

L["ScourgeStone"] = "스컬지석"
L["ScourgeStoneMenu"] = "스컬지석"
L["ScourgeStoneTip"] = ""
L["ScourgeStoneDescription"] = L["TipsAndInfo"] .. "모독자의 스컬지석"

L["Sidereal"] = "항성의 정수"
L["SiderealMenu"] = "항성의 정수"
L["SiderealTip"] = ""
L["SiderealDescription"] = L["TipsAndInfo"] .. "항성의 정수"

L["PvP"] = "PvP 점수"
L["PvPMenu"] = "PvP 점수"
L["PvPTip"] = ""
L["PvPDescription"] = L["TipsAndInfo"] .. "총 명예 점수, 투기장 점수 또는 둘 다를 표시합니다"

L["Speed"] = "이속"
L["SpeedMenu"] = "이동속도"
L["SpeedTip"] = ""
L["SpeedDescription"] = L["TipsAndInfo"] .. "플레이어의 이동속도를 실시간으로 표시합니다 \n" .. Ns.Colors.Red .. "붉은색|r은 평소보다 느린 것을 나타냅니다"

L["TargetSpeed"] = "대상 이속"
L["TargetSpeedMenu"] = "대상 이동속도"
L["TargetSpeedTip"] = ""
L["TargetSpeedDescription"] = L["SinLive"] .. "대상의 이동속도를 실시간으로 표시합니다 \n" .. Ns.Colors.Red .. "붉은|r색은 평소보다 느린 것을 나타냅니다 \n" .. L["ScalingText"] .. "표적 NPC"

L["Durability"] = "내구도"
L["DurabilityMenu"] = "내구도"
L["DurabilityTip"] = ""
L["DurabilityDescription"] = L["TipsAndInfo"] .. "현재 착용중인 장비와 무기의 내구도 퍼센트를 표시합니다"

L["RepairCost"] = "수리"
L["RepairCostMenu"] = "수리 비용"
L["RepairCostTip"] = ""
L["RepairCostDescription"] = L["TipsAndInfo"] .. "총 장비, 장착 장비 또는 가방 내 장비의 수리 비용"

L["BuffCounter"] = "버프"
L["BuffCounterMenu"] = "플레이어 버프"
L["BuffCounterTip"] = ""
L["BuffCounterDescription"] = "플레이어에게 적용된 버프 개수의 총합을 표시합니다"

L["DebuffCounter"] = "디버프"
L["DebuffCounterMenu"] = "디버프"
L["DebuffCounterTip"] = ""
L["DebuffCounterDescription"] = L["SinLive"] .. "플레이어에게 적용된 디버프 개수의 총합을 표시합니다 \n" .. L["ScalingText"] .. "표적 NPC"

L["Lag"] = "핑"
L["LagMenu"] = "핑"
L["LagTip"] = ""
L["LagDescription"] = ""

L["FPS"] = "FPS"
L["FPSMenu"] = "FPS"
L["FPSTip"] = ""
L["FPSDescription"] = L["TipsAndInfo"] .. "Frames per second [FPS]"

L["Travel"] = "거리"
L["TravelMenu"] = "이동 거리"
L["TravelTip"] = ""
L["TravelDescription"] = L["TipsAndInfo"] .. "로그인 이후 총 이동 거리\n\n인스턴스 내에서는 추적이 비활성화되며\n캐릭터가 움직이지 않으면 일시중지됩니다"

L["Jump"] = "점프"
L["JumpMenu"] = "점프 카운터"
L["JumpTip"] = ""
L["JumpDescription"] = L["TipsAndInfo"] .. "이번 세션에서 수행한 점프 횟수"

L["CombatTimer"] = "전투"
L["CombatTimerMenu"] = "전투 타이머"
L["CombatTimerTip"] = ""
L["CombatTimerDescription"] = L["TipsAndInfo"] .. "전투 중 경과 시간을 표시합니다.\n전투에 다시 진입하면 초기화됩니다"

L["InstanceTimer"] = "인스턴스"
L["InstanceTimerMenu"] = "인스턴스 타이머"
L["InstanceTimerTip"] = ""
L["InstanceTimerDescription"] = L["TipsAndInfo"] .. "던전이나 레이드에 입장하면 타이머가 시작됩니다.\n완료하거나 나가면 중지됩니다"

L["MobCounter"] = "몬스터"
L["MobCounterMenu"] = "적 수 카운터"
L["MobCounterTip"] = ""
L["MobCounterDescription"] = L["TipsAndInfo"] .. "근처의 적대적 NPC 수\n\n이름표시줄 감지 사용"

L["KillCounter"] = "처치"
L["KillCounterMenu"] = "처치 카운터"
L["KillCounterTip"] = ""
L["KillCounterDescription"] = L["TipsAndInfo"] .. "근처 NPC 및 플레이어 처치 수\n\n이름표시줄 감지 사용"

L["Money"] = "골드"
L["MoneyMenu"] = "골드"
L["MoneyTip"] = ""
L["MoneyDescription"] = L["TipsAndInfo"] .. "현재 캐릭터가 소유중인 총 골드를 표시합니다"

L["WowToken"] = "토큰"
L["WowTokenMenu"] = "WoW 토큰"
L["WowTokenTip"] = ""
L["WowTokenDescription"] = L["TipsAndInfo"] .. "해당 지역의 WoW 토큰의 실시간 가치"

-- L["LoveToken"] = "사랑의 징표"
-- L["LoveTokenMenu"] = "사랑의 징표"
-- L["LoveTokenTip"] = ""
-- L["LoveTokenDescription"] = L["TipsAndInfo"] .. "통화를 표시합니다 " .. Ns.LoveLink .. "사랑의 징표"

L["DarkmoonTicket"] = "다크문 축제 상품권"
L["DarkmoonTicketMenu"] = "다크문 축제 상품권"
L["DarkmoonTicketTip"] = ""
L["DarkmoonTicketDescription"] = L["TipsAndInfo"] .. "다크문 축제 상품권"

L["JusticePoints"] = "정의"
L["JusticePointsMenu"] = "정의 포인트"
L["JusticePointsTip"] = ""
L["JusticePointsDescription"] = L["TipsAndInfo"] .. "정의 포인트 통화"

L["AugustShard"] = "천신석 조각"
L["AugustShardMenu"] = "천신석 조각"
L["AugustShardTip"] = ""
L["AugustShardDescription"] = L["TipsAndInfo"] .. "천신석 조각 통화"

L["AugustFragment"] = "천신석 파편"
L["AugustFragmentMenu"] = "천신석 파편"
L["AugustFragmentTip"] = ""
L["AugustFragmentDescription"] = L["TipsAndInfo"] .. "천신석 파편 통화"

L["PlatinumCoins"] = "백금 동전"
L["PlatinumCoinsMenu"] = "백금 동전"
L["PlatinumCoinsTip"] = ""
L["PlatinumCoinsDescription"] = L["TipsAndInfo"] .. "백금 동전 통화"

L["petAP"] = "전투력"
L["petAPMenu"] = "전투력"
L["petAPTip"] = ""
L["petAPDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "붉은색 값|r은 디버프에 영향받는 중임을 알려줍니다"

L["petDMG"] = "데미지"
L["petDMGMenu"] = "데미지"
L["petDMGTip"] = ""
L["petDMGDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "붉은색 값|r은 디버프에 영향받는 중임을 알려줍니다"

L["petSpell"] = "주문"
L["petSpellMenu"] = "주문"
L["petSpellTip"] = ""
L["petSpellDescription"] = ""

L["petCrit"] = "치명"
L["petCritMenu"] = "치명"
L["petCritTip"] = ""
L["petCritDescription"] = ""

L["petDPS"] = "DPS"
L["petDPSMenu"] = "DPS"
L["petDPSTip"] = ""
L["petDPSDescription"] = ""

L["petAtkSpeed"] = "공격 속도"
L["petAtkSpeedMenu"] = "공격 속도"
L["petAtkSpeedTip"] = ""
L["petAtkSpeedDescription"] = ""

L["petArmor"] = "갑옷"
L["petArmorMenu"] = "갑옷"
L["petArmorTip"] = ""
L["petArmorDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "붉은색 방어도 값|r은 디버프의 영향을 받고 있음을 알려줍니다"

L["Mastery"] = "특화"
L["MasteryMenu"] = "특화"
L["MasteryTip"] = ""
L["MasteryDescription"] = ""

L["Strength"] = "힘"
L["StrengthMenu"] = "힘"
L["StrengthTip"] = ""
L["StrengthDescription"] = ""

L["Agility"] = "민첩"
L["AgilityMenu"] = "민첩"
L["AgilityTip"] = ""
L["AgilityDescription"] = ""

L["Stamina"] = "체력"
L["StaminaMenu"] = "체력"
L["StaminaTip"] = ""
L["StaminaDescription"] = ""

L["Intellect"] = "지능"
L["IntellectMenu"] = "지능"
L["IntellectTip"] = ""
L["IntellectDescription"] = ""

L["Spirit"] = "정신력"
L["SpiritMenu"] = "정신력"
L["SpiritTip"] = ""
L["SpiritDescription"] = ""

L["Guild"] = "길드"
L["GuildMenu"] = "길드"
L["GuildTip"] = ""
L["GuildDescription"] = L["TipsAndInfo"] .. "현재 접속 중인 길드원 수"

L["Friends"] = "친구"
L["FriendsMenu"] = "친구"
L["FriendsTip"] = ""
L["FriendsDescription"] = L["TipsAndInfo"] .. "현재 접속 중인 친구 수"
------------------
--    Config    --
------------------

-- Categories
L["HUDMenu"] = "HUD"
L["FontsMenu"] = "간격"
L["DisplayMenu"] = "화면"
L["DisplayOrderMenu"] = "정리하다"
L["EventsMenu"] = "이벤트"
L["ProfilesMenu"] = "프로필"
L["Settings"] = "설정"
L["SettingsDescription"] = ""
L["Attributes"] = "속성"
L["AttributesDescription"] = ""
L["Melee"] = "근접"
L["MeleeDescription"] = ""
L["Defense"] = "방어"
L["DefenseDescription"] = ""
L["Ranged"] = "원거리"
L["RangedDescription"] = ""
L["Spell"] = "주문"
L["SpellDescription"] = ""
L["Resistance"] = "저항"
L["ResistanceDescription"] = ""
L["Misc"] = "기타"
L["MiscDescription"] = ""
L["Pet"] = "애완동물"
L["PetDescription"] = ""
L["Currency"] = "화폐"
L["CurrencyDescription"] = ""

-- FAQ
L["FAQMenu"] = "돕다"
L["FAQSixth"] = Ns.MiscIcon .. Ns.Colors.Green .. "일부 통계 텍스트가 잘립니다(...)|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.DisplayIcon .. "화면 >> " .. Ns.SpacingIcon .. "정렬 및 간격: " .. Ns.WidthStringIcon .. Ns.Colors.Green .. "텍스트: 너비|r 슬라이더 조정"
L["FAQFourth"] = Ns.MiscIcon .. Ns.Colors.Green .. "열 또는 행에 통계를 표시하는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.LayoutIcon .. "정리하다: 관련 " .. Ns.MiscIcon .. " 아이콘을 가리키면 자세한 정보가 표시됩니다."
L["FAQSecond"] = Ns.MiscIcon .. Ns.Colors.Green .. "통계 텍스트의 색상을 설정하는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.HUDIcon .. "HUD >> " .. Ns.DisplayIcon .. "화면 >> " .. Ns.Colors.Green .. Ns.ValueIcon .. "전체 텍스트 색상|r 으로 모든 통계 텍스트 색상을 \n한꺼번에 변경하거나, 각 통계 설정에서 " .. Ns.Colors.Green .. "사용자 정의 색상|r 을 활성화하여 개별적으로 색상을 설정할 수 있습니다"
L["FAQFifth"] = Ns.MiscIcon .. Ns.Colors.Green .. "전투 중이거나 다른 특정 상황에서만 통계를 활성화하는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.EventsIcon .. "스마트 HUD: 선택한 이벤트에서만 통계를 볼 수 있습니다"
L["FAQThird"] = Ns.MiscIcon .. Ns.Colors.Green .. "단일 행에 통계를 표시하는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.LayoutIcon .. "정리하다: " .. Ns.Colors.Green .. "행 사전 설정|r에서 1 버튼을 클릭하거나 각 통계를 우클릭하여 열 구분을 전환"
L["FAQFirst"] = Ns.MiscIcon .. Ns.Colors.Green .. "통계를 재구성하는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.LayoutIcon .. "정리하다: 미리보기에서 통계를 드래그 앤 드롭합니다"L["FAQSeventh"] = Ns.MiscIcon .. Ns.Colors.Green .. "능력치 이름을 숨기는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.HUDIcon .. "HUD >> " .. Ns.DisplayIcon .. "표시 >> " .. Ns.Colors.Green .. "능력치 이름 숨기기|r 모든 능력치 이름을 전체적으로 숨깁니다 \n\n 개별 능력치 이름을 숨기려면 해당 능력치 설정의 " .. Ns.Colors.Green .. "이름|r 입력란에 공백을 입력하세요"
L["FAQEighth"] = Ns.MiscIcon .. Ns.Colors.Green .. "상태 바란 무엇인가요|r\n\n 상태 바는 각 능력치 뒤에 나타나는 시각적 채움 바입니다. \n현재 값과 최대값의 비율에 따라 채워집니다 \n\n 각 능력치 설정의 " .. Ns.Colors.Green .. "상태 바|r에서 활성화하고 최대값 모드, \n색상, 텍스처 및 불투명도를 선택하세요"

-- Sub options
L["OptionsTip"] = ""
L["Show"] = "표시"
L["Enhanced"] = "강화"
L["Basic"] = "기본"
L["Base"] = "기본"
L["Modifiers"] = "수정자"
L["Complete"] = "전체"
L["Damage"] = "데미지"
L["DamageTaken"] = "뎀감"
L["Percentage"] = "퍼센트"
L["Rating"] = "수치"
L["Points"] = "포인트들"
L["MainHand"] = "주무기"
L["OffHand"] = "보조무기"
L["SameLevel"] = "동일 레벨"
L["BossLevel"] = "보스 레벨"
L["Regen"] = "평상시 회복"
L["OutOfCombat"] = "평상시"
L["Casting"] = "전투"
L["CritTaken"] = "피치명"
L["Total"] = "전체"
L["Equipped"] = "갖추어 준"
L["Bags"] = "자루"
L["Max"] = "최대"
L["World"] = "월드"
L["Realm"] = "서버"
L["Average"] = "평균"
L["Chance"] = "확률"
L["Reduction"] = "감소"
L["Auto"] = "자동"
L["Heroism"] = "무용"
L["Valor"] = "용맹"
L["StoneKeeper"] = "파편"
L["Marks"] = "훈장"
L["Honor"] = "명예"
L["Arena"] = "투기장"
L["Both"] = "모두"
L["Player"] = "플레이어"
L["Mood"] = "분위기"
L["Live"] = "실시간"
L["Static"] = "정적"
L["Value"] = "값"
L["Display_Average"] = "평균"
L["Display_Basic"] = "기본"
L["Display_MainHand"] = "주무기만 표시"
L["Display_Simulate"] = "시뮬레이트"
L["Display_Expertise"] = "숙련도"
L["Display_ExpertiseTooltip"] = Ns.Colors.Green .. "숙련도|r\n" .. "값 대신 전문 지식 비율을 표시합니다"
L["Display_Special"] = "특수 공격"
L["Display_SpecialTooltip"] = Ns.Colors.Green .. "특수 공격|r\n" .. "특수 능력(노란색 공격)의 실패 확률을 표시합니다"
L["Score_Color"] = "GearScore 색상"
L["Add_Speed"] = "시전 속도"
L["Add_SpeedTooltip"] = Ns.Colors.Green .. "시전 속도|r\n" .. "캐스팅 속도만 증가시키는 주문과 재능을 추가합니다"
L["Add_AtkSpeed"] = "공격속도"
L["Add_AtkSpeedTooltip"] = Ns.Colors.Green .. "공격속도|r\n" .. "공격 속도만 증가시키는 능력과 재능을 추가합니다"
L["Add_Block"] = "방어"
L["Display_Short"] = "짧은 숫자"
L["Display_Gold"] = "금만 표시"
L["Yards"] = "야드"
L["Kilometers"] = "킬로미터"
L["Yards_KMTooltip"] = Ns.Colors.Green .. "야드|r\n" .. "이동 거리를 야드로 \n표시합니다\n\n" .. Ns.Colors.Green .. "킬로미터|r\n" .. "이동 거리를 킬로미터로 \n표시합니다"
L["NPC"] = "NPC"
L["Players"] = "플레이어"
L["NPC_PlayersTooltip"] = Ns.Colors.Green .. "NPC|r\n" .. "NPC 처치 수만 표시\n\n" .. Ns.Colors.Green .. "플레이어|r\n" .. "플레이어 처치 수만 표시\n\n" .. Ns.Colors.Green .. "모두|r\n" .. "NPC와 플레이어\n처치 총 수 표시"
L["Reset_Login"] = "로그인 시 초기화"
L["Reset_LoginTooltip"] = "활성화하면 로그인할 때마다\n카운터가 초기화됩니다"
L["Reset_Counter"] = "초기화"
L["Reset_CounterConfirm"] = "이 카운터를 초기화할까요?"
L["Combat_Color"] = "전투 색상"
L["Combat_ColorTooltip"] = "전투 중 타이머 텍스트를\n빨간색으로 표시"
L["Timer_Format"] = "타이머 형식"
L["Timer_FormatTip"] = ""
L["Send_Chat"] = "채팅 전송"
L["Send_ChatTooltip"] = Ns.Colors.Green .. "채팅 전송|r\n" .. "완료 시 인스턴스 채팅으로\n완료 시간 전송"
L["Editbox_MobRange"] = "범위"
L["Editbox_MobRangeTooltip"] = "감지 범위 (야드)\n\n0 = 모든 보이는 이름표시줄"
L["Display_Total"] = "총 인원 표시"
L["BNet"] = "BattleNet"

-- Decimals
L["Decimals_Default"] = "자리수 구분"
L["Decimals_DefaultTip"] = ""
L["Decimals_One"] = "소수점 반올림"
L["Decimals_Two"] = "소수점 반올림"
L["Decimals_OneTip"] = ""
L["Decimals_TwoTip"] = ""


-- Bars
L["BarTexture"] = "텍스처"
L["BarTextureTip"] = ""
L["BarColor"] = "바 색상"
L["BarColorTip"] = ""
L["BarAlpha"] = "바 불투명도"
L["BarAlphaTip"] = ""
L["BarBgColor"] = "배경 색상"
L["BarBgColorTip"] = ""
L["BarBgAlpha"] = "배경 불투명도"
L["BarBgAlphaTip"] = ""
L["BarAutoColor"] = "진행도 색상"
L["BarAutoColorTooltip"] =
    Ns.Colors.Green .. "진행도 색상|r\n" ..
    "바의 현재 값에 따라 빨강(빈 상태)에서 초록(가득 찬 상태)으로 자동 그라데이션 적용"
L["AutoColorOff"] = "그라데이션 텍스트 비활성화"
L["AutoColorOffTip"] = ""
L["AutoColorOffTooltip"] =
    Ns.Colors.Green .. "그라데이션 텍스트|r\n" ..
    "능력치 값을 빨강(빈 상태)에서 초록(가득 찬 상태)으로 자동 그라데이션 적용"
L["Percentage"] = "백분율"
L["BarMaxCap"] = "상한"
L["Custom"] = "사용자 지정"
L["NextRank"] = "다음 등급"
L["MaxRank"] = "최대 등급"
L["JourneyBarMode"] = "최대 값"
L["JourneyBarModeTip"] = ""
L["SpeedBar"] = "최대 값"
L["SpeedBarTip"] = ""
L["Auto"] = "자동"
L["Steady Flying"] = "안정 비행"
L["Skyriding"] = "스카이라이딩"
L["On Foot"] = "도보"
L["Mounted"] = "탈것 탑승"


-- Caps
L["Cap_Percent"] = "치명타 상한"
L["Cap_PercentTooltip"] =
    Ns.Colors.Green .. "치명타 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다."

L["Cap_Melee_Haste"] = "가속 상한"
L["Cap_Melee_HasteTooltip"] =
    Ns.Colors.Green .. "가속 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다."

L["Cap_Hit"] = "적중 상한"
L["Cap_HitTooltip"] =
    Ns.Colors.Green .. "적중 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다.\n\n" ..
    "기본 상한: " .. Ns.Colors.Green .. "8%"

L["Cap_Spell_Hit"] = "주문 적중 상한"
L["Cap_Spell_HitTooltip"] =
    Ns.Colors.Green .. "적중 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다.\n\n" ..
    "기본 상한: " .. Ns.Colors.Green .. "17%"

L["Cap_Def_Def"] = "방어도 상한"
L["Cap_Def_DefTooltip"] =
    Ns.Colors.Green .. "방어도 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다.\n\n" ..
    "기본 상한: " .. Ns.Colors.Green .. "540"

L["Cap_Def_Armor"] = "방어 상한"
L["Cap_Def_ArmorTooltip"] =
    Ns.Colors.Green .. "방어 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다.\n\n" ..
    "기본 상한: " .. Ns.Colors.Green .. "49,905"

L["Cap_Def_Mit"] = "피해 경감 상한"
L["Cap_Def_MitTooltip"] =
    Ns.Colors.Green .. "피해 경감 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다.\n\n" ..
    "기본 상한: " .. Ns.Colors.Green .. "75%"

L["Cap_Def_Avo"] = "CTC 상한"
L["Cap_Def_AvoTooltip"] =
    Ns.Colors.Green .. "CTC 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다.\n\n" ..
    "기본 상한: " .. Ns.Colors.Green .. "102.4%"

L["Cap_Ranged_Crit"] = "원거리 치명타 상한"
L["Cap_Ranged_CritTooltip"] =
    Ns.Colors.Green .. "치명타 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다.\n\n" ..
    "기본 상한: " .. Ns.Colors.Green .. "104.8%"

L["Cap_Ranged_ArP"] = "방어 관통 상한"
L["Cap_Ranged_ArPTooltip"] =
    Ns.Colors.Green .. "ArP 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다.\n\n" ..
    "기본 상한: " .. Ns.Colors.Green .. "1440"

L["Cap_Melee_Exp"] = "숙련 상한"
L["Cap_Melee_ExpTooltip"] =
    Ns.Colors.Green .. "숙련 상한|r\n" ..
    "능력치의 소프트/하드 캡을 설정합니다.\n" ..
    "감소 구간(DR) 또는 개인 임계값으로도 사용할 수 있습니다.\n\n" ..
    "설정한 값에 도달하면 능력치가 초록색으로 표시됩니다.\n\n" ..
    "기본 상한: " .. Ns.Colors.Green .. "26"

-- Decimals
L["Decimals_Default"] = "자리수 구분"
L["Decimals_DefaultTip"] = ""
L["Decimals_One"] = "소수점 반올림"
L["Decimals_Two"] = "소수점 반올림"
L["Decimals_OneTip"] = ""
L["Decimals_TwoTip"] = ""

-- Stat Bars
L["StaticBar"] = "정적"
L["StaticBarTooltip"] =
    Ns.Colors.Green .. "정적|r\n" ..
    "각 능력치 뒤에 꾸미기용 정적 배경 바를 표시합니다\n\n" ..
    "정적 바와 동적 바가 모두 활성화된 경우 동적 바가 우선 적용됩니다"

L["ShowBar"] = "동적"
L["ShowBarTooltip"] =
    Ns.Colors.Green .. "동적|r\n" ..
    "능력치의 현재 값과 설정된 최대 값에 따라 채워지는 상태 바를 표시합니다"
