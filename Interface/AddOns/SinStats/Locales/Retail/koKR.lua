local AddName, Ns = ...

if GetLocale() ~= "koKR" then return end

local L = Ns.RegisterLocale("koKR", true)

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

-- Categories
L["HUDMenu"] = "HUD"
L["FontsMenu"] = "간격"
L["DisplayMenu"] = "화면"
L["DisplayOrderMenu"] = "정리하다"
L["EventsMenu"] = "이벤트"
L["ProfilesMenu"] = "프로필"
L["Settings"] = "설정"
L["SettingsDescription"] = ""
L["Physical"] = "물리"
L["PhysicalDescription"] = ""
L["Enhancement"] = "고급"
L["EnhancementDescription"] = ""
L["Spell"] = "주문"
L["SpellDescription"] = ""
L["Misc"] = "기본"
L["MiscDescription"] = ""
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
L["CurrText"] = "현재 통화: "
L["RenoText"] = "명성 순위를 표시합니다 "

L["ScalingText"] = Ns.Colors.Green .. "\n[대상 스케일링] |r\n"
L["TipsAndInfo"] = Ns.Colors.Green .. "팁과 정보! |r\n\n"
L["SinLive"] = Ns.Colors.Green .. "SinLive™ 통계! \n이 스탯은 대상과 상호작용하며 스케일에 따라 조정됩니다 |r\n\n"
L["ScalingText2"] = Ns.Colors.Green .. "\n대상 스케일링: |r"
L["NPCAnyLevel"] = "아무 레벨"
L["DefaultValueText"] = Ns.Colors.Green .. "\n\n기본값:|r  "
L["NPCSameLevel"] = "플레이어 레벨"

L["Display_AverageTooltip"] = Ns.Colors.Green .. "평균|r\n" .. "최대값 대신 평균값을 표시합니다"
L["Display_BasicTooltip"] = Ns.Colors.Green .. "기본|r\n" .. "캐릭터창의 기본 값을 표시합니다"
L["Enhanced_BaseTooltip"] = Ns.Colors.Green .. "고급|r\n" .. "특성, 버프, 물약, 마법 부여 등을 통해 최대한 정확한 값을 표시합니다\n\n" .. Ns.Colors.Green .. "기본|r\n" .. "캐릭터창의 기본 값을 표시합니다"
L["Percent_RatingTooltip"] = Ns.Colors.Green .. "퍼센트는|r\n" .. "이 스탯의 백분율 값을 표시합니다 \n\n" .. Ns.Colors.Green .. "수치는|r\n" .. "이 스탯의 수치 값을 표시합니다"
L["Regen_Normal_CastingTooltip"] = Ns.Colors.Green .. "일반|r\n" .. "비시전 5초 규칙 이후 마나 재생 값을 표시합니다\n\n" .. Ns.Colors.Green .. "시전|r\n" .. "시전중 마나 재쟁 값을 표시합니다"
L["World_RealmTooltip"] = Ns.Colors.Green .. "사용자|r\n" .. "내컴퓨터와 블리자드 서버 간의 평균 연결 지연 시간을 밀리초로 표시합니다 (핑)\n\n" .. Ns.Colors.Green .. "서버|r\n" .. "내컴퓨터와 서버 간의 게임 지연 시간을 표시합니다 (서버랙)"
L["Melee_RangedTooltip"] = Ns.Colors.Green .. "근접|r\n" .. "이 능력치의 근접 공격 값을 표시합니다\n\n" .. Ns.Colors.Green .. "원거리|r\n" .. "이 능력치의 원거리 공격 값을 표시합니다"
L["Max_Average_DamageTooltip"] = Ns.Colors.Green .. "최대|r\n" .. "최고 데미지 값 표시 \n\n" .. Ns.Colors.Green .. "평균|r\n" .. "평균 데미지 표시 \n\n" .. Ns.Colors.Green .. "낮은|r\n" .. "가장 낮은 손상 값 표시"
L["Damage_TakenTooltip"] = Ns.Colors.Green .. "공격|r\n" .. "공격력, 치유량 증가 값을 표시합니다\n\n" .. Ns.Colors.Green .. "방어|r\n" .. "받는 피해 감소 값을 표시합니다"
L["Show_Proc"] = "실시간 발동"
L["Show_ProcTooltip"] = Ns.Colors.Green .. "실시간 발동|r\n" .. "전투 중 능력치가 비공개일 때 \n캐시된 총합 옆에 전투 등급 \n발동 보너스를 +값으로 표시"
L["Speed_StaticTooltip"] = Ns.Colors.Green .. "실시간|r\n" .. "캐릭터의 모든 이동 속도를 실시간으로 표시합니다(서기, 달리기, \n수영, 비행, RP 걷기 등) \n\n" .. Ns.Colors.Green .. "정적|r\n" .. "캐릭터의 이동 속도는 정적이며 \n이동 방법이 변경될 때만 변경됩니다"
L["Equipped_OverallTooltip"] = Ns.Colors.Green .. "갖추게 하는|r\n" .. "장착한 장비의 평균 아이템 레벨 \n\n" .. Ns.Colors.Green .. "최대|r\n" .. "가방을 포함한 모든 장비의 최대 아이템 레벨"
L["Normal_EnchantedTooltip"] = Ns.Colors.Green .. "일반|r\n" .. "가방과 은행을 포함하여 항목의 총 수량을 표시합니다 \n\n" .. Ns.Colors.Green .. "마력 깃든|r\n" .. "가방과 은행을 포함하여 인챈트된 아이템의 수량을 표시합니다"
L["Season_ExpTooltip"] = Ns.Colors.Green .. "시즌|r\n" .. "현재 시즌의 신화+ 등급 표시 \n\n" .. Ns.Colors.Green .. "확장|r\n" .. "현재 확장팩의 최고의 신화+ 등급 표시"
L["Splint_SparkTooltip"] = Ns.Colors.Green .. "불꽃|r\n" .. "행운의 불꽃 \n\n" .. Ns.Colors.Green .. "분열된|r\n" .. "분열된 행운의 불꽃"
L["Current_EarnedTooltip"] = Ns.Colors.Green .. "현재의|r\n" .. "현재 보유 수량을 표시합니다 \n\n" .. Ns.Colors.Green .. "획득|r\n" .. "획득한 총액을 표시합니다"
L["Empty_VintageTooltip"] = Ns.Colors.Green .. "빈 카자콜라|r\n" .. "빈 카자콜라 깡통의 수량을 표시합니다.\n\n" .. Ns.Colors.Green .. "오래된|r\n" .. "오래된 카자콜라 깡통의 수량을 표시합니다."
L["Key_NameTooltip"] = ""


L["Max_Average_DamageTooltip"] = Ns.Colors.Green .. "최대, 평균 및 낮음|r\n" .. "전체 피해 범위 표시"
L["Level_HonorPointsTooltip"] = Ns.Colors.Green .. "[레벨]|r\n" .. "명예 레벨을 표시합니다\n\n" .. Ns.Colors.Green .. "[점수]|r\n" .. "명예 점수를 표시합니다"
L["Display_RatedTooltip"] = Ns.Colors.Green .. "[평점]|r\n" .. "평점제 획득 명예 점수를 표시합니다"
L["Display_RatingTooltip"] = Ns.Colors.Green .. "[수치는]|r\n" .. "이 스탯의 수치 값을 표시합니다"
L["Display_MainHandTooltip"] = Ns.Colors.Green .. "[보조 장비 비활성화]|r\n" .. "해당되는 경우 보조무기의 자동 표시를 \n비활성화합니다"
L["Display_PercentageTooltip"] = Ns.Colors.Green .. "퍼센트|r\n" .. "현재 레벨의 \n완료율을 표시합니다"
L["Rank_RepTooltip"] = Ns.Colors.Green .. "평판|r\n" .. "평판 등급 이름을 표시합니다 \n\n" .. Ns.Colors.Green .. "평판값|r\n" .. "평판 수치를 표시합니다"
L["Display_MaxTooltip"] = Ns.Colors.Green .. "주간 한도|r\n" .. "이 통화의 주간 한도에 도달하면 \n수량을 빨간색으로 표시합니다"
L["Display_TotalTooltip"] = Ns.Colors.Green .. "총 인원|r\n" .. "접속 수 옆에 총 인원 수를 \n표시합니다"
L["BNet_RealmTooltip"] = Ns.Colors.Green .. "BattleNet|r\n" .. "접속 중인 BattleNet 친구를 표시합니다 \n\n" .. Ns.Colors.Green .. "서버|r\n" .. "접속 중인 서버 친구를 표시합니다 \n\n" .. Ns.Colors.Green .. "모두|r\n" .. "BattleNet과 서버 친구를 \n모두 표시합니다"
L["Raids_DungeonsTooltip"] = Ns.Colors.Green .. "레이드|r\n" .. "레이드 보스 처치 수를 표시합니다 \n\n" .. Ns.Colors.Green .. "던전|r\n" .. "던전 완료 수를 표시합니다 \n\n" .. Ns.Colors.Green .. "모두|r\n" .. "레이드와 던전을 \n모두 표시합니다"

L["CritChance"] = "치명타"
L["CritChanceMenu"] = "치명타"
L["CritChanceTip"] = ""
L["CritChanceDescription"] = ""

L["Haste"] = "가속"
L["HasteMenu"] = "가속"
L["HasteTip"] = ""
L["HasteDescription"] = ""

L["Mastery"] = "특화"
L["Primary"] = "주 능력치"
L["PrimaryMenu"] = "주 능력치"
L["PrimaryTip"] = ""
L["PrimaryDescription"] = ""

L["MasteryMenu"] = "특화"
L["MasteryTip"] = ""
L["MasteryDescription"] = ""

L["Versatility"] = "유연성"
L["VersatilityMenu"] = "유연성"
L["VersatilityTip"] = ""
L["VersatilityDescription"] = ""

L["Avoidance"] = "광역 회피"
L["AvoidanceMenu"] = "광역 회피"
L["AvoidanceTip"] = ""
L["AvoidanceDescription"] = ""

L["Leech"] = "생기 흡수"
L["LeechMenu"] = "생기 흡수"
L["LeechTip"] = ""
L["LeechDescription"] = ""

L["Strength"] = "힘"
L["StrengthMenu"] = "힘"
L["StrengthTip"] = ""
L["StrengthDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "빨간|r 값은 이 능력치와 관련된 디버프에 걸린 것을 나타냅니다 \n"

L["Agility"] = "민첩"
L["AgilityMenu"] = "민첩"
L["AgilityTip"] = ""
L["AgilityDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "빨간|r 값은 이 능력치와 관련된 디버프에 걸린 것을 나타냅니다 \n"

L["AP"] = "공격력"
L["APMenu"] = "공격력"
L["APTip"] = ""
L["APDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "빨간|r 값은 이 능력치와 관련된 디버프에 걸린 것을 나타냅니다 \n"

L["DMG"] = "피해"
L["DMGMenu"] = "피해"
L["DMGTip"] = ""
L["DMGDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "빨간|r 값은 이 능력치와 관련된 디버프에 걸린 것을 나타냅니다"

L["DPS"] = "DPS"
L["DPSMenu"] = "DPS"
L["DPSTip"] = ""
L["DPSDescription"] = ""

L["DMGMod"] = "피해+"
L["DMGModMenu"] = "피해+"
L["DMGModTip"] = ""
L["DMGModDescription"] = ""

L["weaponSpeed"] = "공격 속도"
L["weaponSpeedMenu"] = "공격 속도"
L["weaponSpeedTip"] = ""
L["weaponSpeedDescription"] = ""

L["EnergyRegen"] = "에너지 재생"
L["EnergyRegenMenu"] = "에너지 재생"
L["EnergyRegenTip"] = ""
L["EnergyRegenDescription"] = ""

L["Stamina"] = "체력"
L["StaminaMenu"] = "체력"
L["StaminaTip"] = ""
L["StaminaDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "빨간|r 값은 이 능력치와 관련된 디버프에 걸린 것을 나타냅니다"

L["Mitigation"] = "데미지 감소"
L["MitigationMenu"] = "데미지 감소"
L["MitigationTip"] = ""
L["MitigationDescription"] = L["SinLive"] .. "모든 레벨의 공격자에 대한 피해 감소 \n" .. L["DefaultValueText"] .. L["NPCSameLevel"] .. L["ScalingText2"] .. L["NPCAnyLevel"]

L["Armor"] = "방어도"
L["ArmorMenu"] = "방어도"
L["ArmorTip"] = ""
L["ArmorDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "빨간|r 값은 이 능력치와 관련된 디버프에 걸린 것을 나타냅니다"

L["Dodge"] = "회피"
L["DodgeMenu"] = "회피"
L["DodgeTip"] = ""
L["DodgeDescription"] = ""

L["Parry"] = "무기 막기"
L["ParryMenu"] = "무기 막기"
L["ParryTip"] = ""
L["ParryDescription"] = ""

L["Block"] = "방패 막기"
L["BlockMenu"] = "방패 막기"
L["BlockTip"] = ""
L["BlockDescription"] = ""

L["Absorb"] = "흡수"
L["AbsorbMenu"] = "흡수"
L["AbsorbDescription"] = L["TipsAndInfo"] .. "흡수|r\n현재 적용된 모든 흡수 보호막의 총량을 표시합니다"

L["Health"] = "생명력"
L["HealthMenu"] = "생명력"
L["HealthTip"] = ""
L["HealthDescription"] = L["TipsAndInfo"] .. "현재 및 최대 생명력을 표시합니다. 바는 생명력 비율에 따라 채워집니다."

L["Stagger"] = "시간차"
L["StaggerMenu"] = "시간차"
L["StaggerTip"] = ""
L["StaggerDescription"] = ""

L["Intellect"] = "지능"
L["IntellectMenu"] = "지능"
L["IntellectTip"] = ""
L["IntellectDescription"] = L["TipsAndInfo"] .. Ns.Colors.Red .. "빨간|r 값은 이 능력치와 관련된 디버프에 걸린 것을 나타냅니다"

L["SpellPower"] = "주문력"
L["SpellPowerMenu"] = "주문력"
L["SpellPowerTip"] = ""
L["SpellPowerDescription"] = ""

L["DMGModSpell"] = "주문력+"
L["DMGModSpellMenu"] = "주문력 보너스"
L["DMGModSpellTip"] = ""
L["DMGModSpellDescription"] = L["TipsAndInfo"] .. "주문력 보너스"

L["Healing"] = "치유"
L["HealingMenu"] = "치유"
L["HealingTip"] = ""
L["HealingDescription"] = ""

L["ManaRegen"] = "마나 재생"
L["ManaRegenMenu"] = "마나 재생"
L["ManaRegenTip"] = ""
L["ManaRegenDescription"] = ""

L["Durability"] = "내구도"
L["DurabilityMenu"] = "내구도"
L["DurabilityTip"] = ""
L["DurabilityDescription"] = L["TipsAndInfo"] .. "현재 착용중인 무기와 장비의 내구도 퍼센트입니다"

L["RepairCost"] = "수리"
L["RepairCostMenu"] = "수리 비용"
L["RepairCostTip"] = ""
L["RepairCostDescription"] = L["TipsAndInfo"] .. "총 수리 비용"

L["Speed"] = "이동 속도"
L["SpeedMenu"] = "이동 속도"
L["SpeedTip"] = ""
L["SpeedDescription"] = L["TipsAndInfo"] .. "캐릭터의 실시간 이동 속도입니다.\n\n빨간 " .. Ns.Colors.Red .. "이동 속도|r 값은 이동 속도 감소 효과에 걸렸거나 기본 속도보다 느리게 움직이는 것을 나타냅니다"

L["Zuljarra"] = "줄자라의 군대"
L["ZuljarraMenu"] = "줄자라의 군대"
L["ZuljarraTip"] = ""
L["ZuljarraDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.ZuljarraLink

L["Tokka"] = "선장 토카"
L["TokkaMenu"] = "선장 토카"
L["TokkaDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.TokkaLink

L["Silvermoon"] = "실버문 궁정"
L["SilvermoonMenu"] = "실버문 궁정"
L["SilvermoonTip"] = ""
L["SilvermoonDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.SilverLink

L["Amani"] = "아마니 부족"
L["AmaniMenu"] = "아마니 부족"
L["AmaniTip"] = ""
L["AmaniDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.AmaniLink

L["Arati"] = "하라티"
L["AratiMenu"] = "하라티"
L["AratiTip"] = ""
L["AratiDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.AratiLink

L["Singularity"] = "특이점"
L["SingularityMenu"] = "특이점"
L["SingularityTip"] = ""
L["SingularityDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.SingLink

L["Slayer"] = "학살자의"
L["SlayerMenu"] = "학살자의 결전장"
L["SlayerTip"] = ""
L["SlayerDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.SlayerLink

L["Prey"] = "사냥감"
L["PreyMenu"] = "사냥감: 2 시즌"
L["PreyTip"] = ""
L["PreyDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.PreyLink

L["Ritual"] = "의식 지점"
L["RitualMenu"] = "의식 지점"
L["RitualTip"] = ""
L["RitualDescription"] = L["TipsAndInfo"] .. L["RenoText"] .. Ns.RitualLink

L["TargetSpeed"] = "대상 이동 속도"
L["TargetSpeedMenu"] = "대상 이동 속도"
L["TargetSpeedTip"] = ""
L["TargetSpeedDescription"] = L["TipsAndInfo"] .. "대상의 실시간 이동 속도입니다\n\n빨간 " .. Ns.Colors.Red .. "이동 속도|r 값은 이동 속도 감소 효과에 걸렸거나 기본 속도보다 느리게 움직이는 것을 나타냅니다"

L["ItemLevel"] = "템렙"
L["ItemLevelMenu"] = "아이템 레벨"
L["ItemLevelTip"] = ""
L["ItemLevelDescription"] = L["TipsAndInfo"] .. "평균 아이템 레벨"

L["PvPiLvl"] = "PvP iLvl"
L["PvPiLvlMenu"] = "PvP 아이템 레벨"
L["PvPiLvlTip"] = ""
L["PvPiLvlDescription"] = L["TipsAndInfo"] .. "PvP 아이템 레벨"

L["GlobalCD"] = "Gcd"
L["GlobalCDMenu"] = "GCD"
L["GlobalCDTip"] = ""
L["GlobalCDDescription"] = L["TipsAndInfo"] .. "전역 재사용 대기시간"

L["BloodyTokens"] = "피투성이 증표"
L["BloodyTokensMenu"] = "피투성이 증표"
L["BloodyTokensTip"] = ""
L["BloodyTokensDescription"] = L["TipsAndInfo"] .. L["CurrText"]  .. Ns.BloodyLink

L["Honor"] = "명예"
L["HonorMenu"] = "명예"
L["HonorTip"] = ""
L["HonorDescription"] = L["TipsAndInfo"] .. L["CurrText"]  .. Ns.HonorLink

L["Adventurer"] = "모험가"
L["AdventurerMenu"] = "모험가 여명문장"
L["AdventurerTip"] = ""
L["AdventurerDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AdventurerLink

L["Veteran"] = "노련가"
L["VeteranMenu"] = "노련가 여명문장"
L["VeteranTip"] = ""
L["VeteranDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VeteranLink

L["Champion"] = "챔피언"
L["ChampionMenu"] = "챔피언 여명문장"
L["ChampionTip"] = ""
L["ChampionDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.ChampLink

L["Hero"] = "영웅"
L["HeroMenu"] = "영웅 여명문장"
L["HeroTip"] = ""
L["HeroDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.HeroLink

L["Myth"] = "신화"
L["MythMenu"] = "신화 여명문장"
L["MythTip"] = ""
L["MythDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.MythLink

L["Stash"] = "금빛 보관함"
L["StashMenu"] = "금빛 보관함"
L["StashTip"] = ""
L["StashDescription"] = L["TipsAndInfo"] .. "통화를 표시합니다 " .. Ns.StashLink

-- L["Puzzling"] = "칩"
-- L["PuzzlingMenu"] = "무역회사 칩"
-- L["PuzzlingTip"] = ""
-- L["PuzzlingDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.PuzzlingLink .. "수수께끼의 무역회사 칩"

L["Twilight"] = "황혼의"
L["TwilightAbrev"] = "황혼의"
L["TwilightMenu"] = "황혼의 칼날단 휘장"
L["TwilightTip"] = ""
L["TwilightDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.TwilightLink

-- L["LoveToken"] = "사랑의 징표"
-- L["LoveTokenMenu"] = "사랑의 징표"
-- L["LoveTokenTip"] = ""
-- L["LoveTokenDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.LoveLink .. "사랑의 징표"

L["Catalyst"] = "새벽빛 마나용제"
L["CatalystMenu"] = "새벽빛 마나용제"
L["CatalystTip"] = ""
L["CatalystDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CatalystLink

L["CofferKey"] = "금고 열쇠"
L["CofferKeyMenu"] = "금고 열쇠 파편"
L["CofferKeyTip"] = ""
L["CofferKeyDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CofferLink

L["RestoredKey"] = "복원된 금고 열쇠"
L["RestoredKeyMenu"] = "복원된 금고 열쇠"
L["RestoredKeyTip"] = ""
L["RestoredKeyDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.RestoredKeyLink

L["Undercoin"] = "지하의 주화"
L["UndercoinMenu"] = "지하의 주화"
L["UndercoinDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CoinLink

L["Corrosive"] = "부식하는 동전"
L["CorrosiveMenu"] = "부식하는 동전"
L["CorrosiveDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CorrosiveLink

L["CorroSoul"] = "부식의 영혼"
L["CorroSoulMenu"] = "부식의 영혼"
L["CorroSoulDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CorroSoulLink .. "부식의 영혼"

L["Venom"] = "맹독의 저주에"
L["VenomMenu"] = "맹독의 저주에"
L["VenomDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VenomLink .. "맹독의 저주에 걸린 파편"

L["Ossified"] = "골화 성물"
L["OssifiedMenu"] = "골화 성물"
L["OssifiedDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.OssifiedLink .. "골화 성물"

L["VoidVestige"] = "공허의 잔흔"
L["VoidVestigeMenu"] = "공허의 잔흔"
L["VoidVestigeDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VoidVestigeLink .. "공허의 잔흔"

L["Brewfest"] = "가을 축제"
L["BrewfestMenu"] = "가을 축제"
L["BrewfestDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.BrewfestLink .. "가을 축제 상품 교환 동전"

L["ManaCrystals"] = "정순한 마나 수정"
L["ManaCrystalsMenu"] = "정순한 마나 수정"
L["ManaCrystalsDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.ManaLink

L["Spark"] = "광휘의 불꽃"
L["SparkMenu"] = "광휘의 불꽃"
L["SparkDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.SparkLink .. "해일의 불꽃"

L["Anguish"] = "고뇌의 잔여물"
L["AnguishMenu"] = "고뇌의 잔여물"
L["AnguishDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AnguishLink

L["Illusionary"] = "환영 동전"
L["IllusionaryMenu"] = "환영 동전"
L["IllusionaryDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.IllusionaryLink

L["Accolade"] = "야전 훈장"
L["AccoladeMenu"] = "야전 훈장"
L["AccoladeDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AccoladeLink

L["DarkParticle"] = "암흑 입자"
L["DarkParticleMenu"] = "암흑 입자"
L["DarkParticleTip"] = ""
L["DarkParticleDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.DarkParticleLink .. "암흑 입자"

L["CoiledFil"] = "똬리 실"
L["CoiledFilMenu"] = "똬리 실"
L["CoiledFilDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CoiledFilLink

L["AnglerPearls"] = "강태공 진주"
L["AnglerPearlsMenu"] = "강태공 진주"
L["AnglerPearlsTip"] = ""
L["AnglerPearlsDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AnglerPearlsLink

L["Voidcore"] = "성운의 공허핵"
L["VoidcoreMenu"] = "성운의 공허핵"
L["VoidcoreTip"] = ""
L["VoidcoreDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VoidcoreLink

L["Ascendant"] = "승천의 맹독석"
L["AscendantMenu"] = "승천의 맹독석"
L["AscendantTip"] = ""
L["AscendantDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AscendantLink .. "승천의 맹독석"

L["GalacticVoid"] = "우주의 공허"
L["GalacticVoidMenu"] = "우주의 공허"
L["GalacticVoidTip"] = ""
L["GalacticVoidDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.GalacticVoidLink .. "우주의 공허"

L["Abundance"] = "순수한 풍요"
L["AbundanceMenu"] = "순수한 풍요"
L["AbundanceTip"] = ""
L["AbundanceDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AbundLink

L["VoidSample"] = "않은 공허 표본"
L["VoidSampleMenu"] = "않은 공허 표본"
L["VoidSampleTip"] = ""
L["VoidSampleDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VoidSampleLink

L["Voidlight"] = "공허불빛 이회토"
L["VoidlightMenu"] = "공허불빛 이회토"
L["VoidlightTip"] = ""
L["VoidlightDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VoidlightLink

L["Arcana"] = "비전력"
L["ArcanaMenu"] = "넘쳐흐르는 비전력"
L["ArcanaTip"] = ""
L["ArcanaDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.ArcanaLink

L["MarkHonor"] = "명예 훈장"
L["MarkHonorMenu"] = "명예 훈장"
L["MarkHonorTip"] = ""
L["MarkHonorDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.MarkHonorLink .. "명예 훈장"

L["ValorPoints"] = "용맹 점수"
L["ValorPointsMenu"] = "용맹 점수"
L["ValorPointsTip"] = ""
L["ValorPointsDescription"] = L["TipsAndInfo"] .. L["CurrText"]  .. Ns.ValorPvPLink

L["Conquest"] = "정복"
L["ConquestMenu"] = "정복"
L["ConquestTip"] = ""
L["ConquestDescription"] = L["TipsAndInfo"] .. L["CurrText"]  .. Ns.ConqLink

-- L["Celebration"] = "청동"
-- L["CelebrationMenu"] = "청동 기념제 징표"
-- L["CelebrationTip"] = ""
-- L["CelebrationDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CelebLink

L["Timewarped"] = "시간왜곡의"
L["TimewarpedMenu"] = "시간왜곡의"
L["TimewarpedTip"] = ""
L["TimewarpedDescription"] = L["TipsAndInfo"] .. L["CurrText"]  .. Ns.TimeLink

L["TraderTender"] = "여행자의"
L["TraderTenderMenu"] = "신화+ 평점"
L["TraderTenderTip"] = ""
L["TraderTenderDescription"] = L["TipsAndInfo"] .. L["CurrText"]  .. Ns.TenderLink

L["Darkmoon"] = "티켓"
L["DarkmoonMenu"] = "다크문 상품권"
L["DarkmoonTip"] = ""
L["DarkmoonDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.DarkmoonLink

L["Luminous"] = "영롱한 가루"
L["LuminousMenu"] = "영롱한 가루"
L["LuminousTip"] = ""
L["LuminousDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.LuminousLink

L["Skyshards"] = "하늘조각"
L["SkyshardsMenu"] = "수수께끼의 하늘조각"
L["SkyshardsTip"] = ""
L["SkyshardsDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.SkyshardsLink .. "수수께끼의 하늘조각"

L["VileEssence"] = "더러운 정수"
L["VileEssenceMenu"] = "더러운 정수"
L["VileEssenceTip"] = ""
L["VileEssenceDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.VileEssenceLink .. "더러운 정수"

L["Delver"] = "구렁"
L["DelverMenu"] = "구렁: 1 시즌"
L["DelverTip"] = ""
L["DelverDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.DelverLink .. "구렁: 1 시즌"

L["Kindojan"] = "킨도잔의 미궁"
L["KindojanMenu"] = "킨도잔의 미궁"
L["KindojanDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.KindojanLink

L["Mythical"] = "신화의 영혼 파편"
L["MythicalMenu"] = "신화의 영혼 파편"
L["MythicalDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.MythicalLink .. "신화의 영혼 파편"

L["Companion"] = "발리라"
L["CompanionMenu"] = "발리라 생귀나르"
L["CompanionTip"] = ""
L["CompanionDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CompanionLink .. "발리라 생귀나르"

L["Dundun"] = "둔둔의 조각"
L["DundunMenu"] = "둔둔의 조각"
L["DundunTip"] = ""
L["DundunDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.DundunLink

L["AqirToken"] = "아기르"
L["AqirTokenMenu"] = "아기르 연구 징표"
L["AqirTokenDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AqirLink .. "아기르 연구 징표"

L["Aqir"] = "아퀴르 연구단"
L["AqirMenu"] = "아퀴르 연구단"
L["AqirDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.AqirRepLink

L["Coupons"] = "공동체 상품권"
L["CouponsMenu"] = "공동체 상품권"
L["CouponsTip"] = ""
L["CouponsDescription"] = L["TipsAndInfo"] .. L["CurrText"] .. Ns.CouponsLink

-- L["Delves"] = "구렁"
-- L["DelvesMenu"] = "구렁"
-- L["DelvesTip"] = ""
-- L["DelvesDescription"] = L["TipsAndInfo"] .. "완료된 구렁(Delves) 수행 횟수를 표시합니다.\n추적할 티어를 선택하거나 티어 8 이상을 모두 추적하도록 설정하세요."

L["Delves"] = "구렵/먹잇감"
L["DelvesMenu"] = "구렵/먹잇감 완료"
L["DelvesTip"] = ""
L["DelvesDescription"] = L["TipsAndInfo"] .. "이번 주 완료한 " .. Ns.Colors.Green .. "구렵 및 먹잇감|r 횟수를 추적합니다 \n" .. Ns.Colors.Green .. "먹잇감:|r 일반(티어 1), 하드코어(티어 5), 악몽(티어 8) \n\n" .. Ns.Colors.Green .. "SinStats|r가 활성화되어 있어야 추적이 작동합니다. \n데이터는 매주 자동으로 " .. Ns.Colors.Red .. "초기화|r됩니다"

L["MythicPlus"] = "신화++"
L["MythicPlusMenu"] = "신화+"
L["MythicPlusDescription"] = L["TipsAndInfo"] .. "현재 시즌의 신화+ 등급을 표시합니다"

L["Keystone"] = "신화 쐐기돌"
L["KeystoneMenu"] = "신화 쐐기돌"
L["KeystoneDescription"] = L["TipsAndInfo"] .. "현재 보유 중인 신화+ 쐐기돌의 레벨 및/또는 이름을 표시합니다. \n던전 이름을 줄이려면 약어 옵션을 사용하세요"

L["GreatVault"] = "보물창고"
L["GreatVaultMenu"] = "대보물창고"
L["GreatVaultTip"] = ""
L["GreatVaultDescription"] = L["TipsAndInfo"] .. "모든 활동 유형(M+, 레이드, PvP, 월드)에서 채운 대보물창고 보상 슬롯 수를 표시합니다"

L["Spec"] = "전문화"
L["SpecialTypeMenu"] = "전문화"
L["SpecDescription"] = L["TipsAndInfo"] .. "현재 전문화 및/또는 영웅 특성을 표시합니다"

L["Spec"] = "전문화"
L["Hero"] = "영웅"
L["Abbrev"] = "약어"
L["Name"] = "이름"
L["Mythical"] = "신화의"
L["Heroic"] = "영웅의"

L["Loadout"] = "특성 구성"
L["LoadoutMenu"] = "특성 구성"
L["LoadoutDescription"] = L["TipsAndInfo"] .. "현재 사용 중인 특성 구성을 표시합니다"

L["Lag"] = "핑"
L["LagMenu"] = "핑"
L["LagTip"] = ""
L["LagDescription"] = ""

L["FPS"] = "FPS"
L["FPSMenu"] = "FPS"
L["FPSTip"] = ""
L["FPSDescription"] = ""

L["Coordinates"] = "좌표"
L["CoordinatesMenu"] = "좌표"
L["CoordinatesTip"] = ""
L["CoordinatesDescription"] = L["TipsAndInfo"] .. "현재 지도 좌표 (X, Y)"

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

L["Gold"] = "소지금"
L["GoldMenu"] = "소지금"
L["GoldTip"] = ""
L["GoldDescription"] = ""

L["WowToken"] = "토큰"
L["WowTokenMenu"] = "WoW 토큰"
L["WowTokenTip"] = ""
L["WowTokenDescription"] = L["TipsAndInfo"] .. "해당 지역의 WoW 토큰의 실시간 가치"

L["Guild"] = "길드"
L["GuildMenu"] = "길드"
L["GuildTip"] = ""
L["GuildDescription"] = L["TipsAndInfo"] .. "현재 접속 중인 길드원 수"

L["Friends"] = "친구"
L["FriendsMenu"] = "친구"
L["FriendsTip"] = ""
L["FriendsDescription"] = L["TipsAndInfo"] .. "현재 접속 중인 친구 수"

-- FAQ
L["FAQMenu"] = "돕다"
L["FAQSixth"] = Ns.MiscIcon .. Ns.Colors.Green .. "일부 통계 텍스트가 잘립니다(...)|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.DisplayIcon .. "화면 >> " .. Ns.SpacingIcon .. "정렬 및 간격: " .. Ns.WidthStringIcon .. Ns.Colors.Green .. "텍스트: 너비|r 슬라이더 조정"
L["FAQFourth"] = Ns.MiscIcon .. Ns.Colors.Green .. "열 또는 행에 통계를 표시하는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.LayoutIcon .. "정리하다: 관련 " .. Ns.MiscIcon .. " 아이콘을 가리키면 자세한 정보가 표시됩니다."
L["FAQSecond"] = Ns.MiscIcon .. Ns.Colors.Green .. "통계 텍스트의 색상을 설정하는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.HUDIcon .. "HUD >> " .. Ns.DisplayIcon .. "화면 >> " .. Ns.Colors.Green .. Ns.ValueIcon .. "전체 텍스트 색상|r 으로 모든 통계 텍스트 색상을 \n한꺼번에 변경하거나, 각 통계 설정에서 " .. Ns.Colors.Green .. "사용자 정의 색상|r 을 활성화하여 개별적으로 색상을 설정할 수 있습니다"
L["FAQFifth"] = Ns.MiscIcon .. Ns.Colors.Green .. "전투 중이거나 다른 특정 상황에서만 통계를 활성화하는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.EventsIcon .. "스마트 HUD: 선택한 이벤트에서만 통계를 볼 수 있습니다"
L["FAQThird"] = Ns.MiscIcon .. Ns.Colors.Green .. "단일 행에 통계를 표시하는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.LayoutIcon .. "정리하다: " .. Ns.Colors.Green .. "행 사전 설정|r에서 1 버튼을 클릭하거나 각 통계를 우클릭하여 열 구분을 전환"
L["FAQFirst"] = Ns.MiscIcon .. Ns.Colors.Green .. "통계를 재구성하는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.LayoutIcon .. "정리하다: 미리보기에서 통계를 드래그 앤 드롭합니다"L["FAQSeventh"] = Ns.MiscIcon .. Ns.Colors.Green .. "능력치 이름을 숨기는 방법|r\n\n " .. Ns.SettingsIcon .. "설정 >> " .. Ns.HUDIcon .. "HUD >> " .. Ns.DisplayIcon .. "표시 >> " .. Ns.Colors.Green .. "능력치 이름 숨기기|r 모든 능력치 이름을 전체적으로 숨깁니다 \n\n 개별 능력치 이름을 숨기려면 해당 능력치 설정의 " .. Ns.Colors.Green .. "이름|r 입력란에 공백을 입력하세요"
L["FAQEighth"] = Ns.MiscIcon .. Ns.Colors.Green .. "상태 바란 무엇인가요|r\n\n 상태 바는 각 능력치 뒤에 나타나는 시각적 채움 바입니다. \n현재 값과 최대값의 비율에 따라 채워집니다 \n\n 각 능력치 설정의 " .. Ns.Colors.Green .. "상태 바|r에서 활성화하고 최대값 모드, \n색상, 텍스처 및 불투명도를 선택하세요"

-- Sub Options
L["OptionsTip"] = ""
L["Show"] = "표시"
L["Enhanced"] = "고급"
L["Base"] = "기본"
L["Percentage"] = "퍼센트"
L["Rating"] = "수치"
L["Display_Rating"] = "수치"
L["Rating_Only"] = "Rating만"
L["Damage"] = "공격"
L["DamageTaken"] = "방어"
L["World"] = "서버"
L["Realm"] = "사용자"
L["Max"] = "최대"
L["Low"] = "낮은"
L["Average"] = "평균"
L["Level"] = "레벨"
L["Honor"] = "명예"
L["Both"] = "모두"
L["Live"] = "실시간"
L["Static"] = "정적"
L["Speed_Unit"] = "단위 표시"
L["Speed_UnitTooltip"] = Ns.Colors.Green .. "단위 표시|r\n" .. "야드 또는 Km 표시 모드가 선택된 경우 \n속도 값 옆에 해당 단위 레이블 \n(yd/s 또는 km/h)을 추가합니다"
L["Speed_Secret"] = "제한 구역"
L["Speed_Secret"] = "제한 구역"
L["Speed_SecretTooltip"] = Ns.Colors.Green .. "제한 구역|r\n" .. "전투, 신화+, 투기장 등 제한 구역에서는 \n" .. "자동으로 초당 야드 속도로 전환됩니다. \n\n" .. "이 기능은 게임 제한으로 인해 \n" .. "캐시된 값이 아닌 실제 속도를 \n" .. "표시할 수 있게 해줍니다"
L["Speed_Color"] = "속도 색상"
L["Percent"] = "퍼센트"
L["Yards"] = "야드"
L["Km"] = "킬로미터"
L["Speed_ModeTooltip"] = Ns.Colors.Green .. "속도 표시|r\n" .. "속도 표시 방법을 선택하세요 \n\n" .. Ns.Colors.Green .. "퍼센트|r — 기본 백분율 (현재) \n" .. Ns.Colors.Green .. "야드|r — 계산 없는 원시 값, \n쐐기에서 안전하게 사용 가능 \n" .. Ns.Colors.Green .. "킬로미터|r — 시간당 킬로미터"
L["Cap_Token"] = "WoW 토큰 상한"
L["Cap_TokenTooltip"] = Ns.Colors.Green .. "토큰 상한|r\n" ..
"WoW 토큰의 목표 가격을 설정합니다 \n\n" ..
"토큰 가격이 상한보다 낮으면 " .. Ns.Colors.Red .. "빨간색|r, \n상한 이상이면 " .. Ns.Colors.Green .. "초록색|r 으로 표시됩니다 \n\n" ..
"상한 색상을 비활성화하려면 값을 0으로 설정하세요"

L["Display_Percentage"] = "퍼센트"
L["Rank"] = "평판 등급"
L["Rep"] = "평판값"
L["Normal"] = "일반"
L["Enchanted"] = "마력 깃든"
L["Shadowflame"] = "암흑불길"
L["Ingenuity"] = "창의성"
L["Melee"] = "근접"
L["Ranged"] = "원거리"
L["Equipped"] = "착용중"
-- L["Overall"] = "가방포함"
L["Empty"] = "빈 카자콜라"
L["Vintage"] = "오래된"
L["Display_Average"] = "평균"
L["Display_Rated"] = "평점"
L["Display_Basic"] = "기본"
L["Auto_Name"] = "자동 이름"
L["Auto_NameTooltip"] = Ns.Colors.Green .. "자동 이름|r\n" .. "감지된 주 능력치에 따라\n능력치 이름을 자동으로 설정:\n힘, 민첩 또는 지능"
L["Display_MainHand"] = "보조 장비 비활성화"
L["Season"] = "시즌"
L["Expansion"] = "확장"
L["Spark"] = "불꽃"
L["Splinter"] = "분열된"
L["Gigantic"] = "거대한"
L["Plump"] = "통통한"
L["Current"] = "현재의"
-- L["Earned"] = "획득"
L["Display_Short"] = "짧은 숫자"
L["Display_Max"] = "주간 한도"
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
L["Reset_CounterTooltip"] = ""
L["Reset_CounterConfirm"] = "이 카운터를 초기화할까요?"
L["Combat_Color"] = "전투 색상"
L["Combat_ColorTooltip"] = "전투 중 타이머 텍스트를\n빨간색으로 표시"
L["Editbox_MobRange"] = "범위"
L["Editbox_MobRangeTooltip"] = "감지 범위 (야드)\n\n0 = 모든 보이는 이름표시줄"
L["Display_Weekly"] = "시즌 최대치"
L["Raids"] = "레이드"
L["Dungeons"] = "던전"
L["Display_Delves"] = "티어 8+"
L["Display_DelvesTip"] = ""
L["Editbox_D"] = "구렁 티어"
L["Editbox_DTooltip"] = Ns.Colors.Green .. "구렁 티어|r\n" .. "표시할 완료된 구렁 던전의 티어를 설정하세요.\n\n" .. "옵션 " .. Ns.Colors.Green .. "티어 8+|r 가 선택되어 있으면 이 설정은 무시됩니다"L["Editbox_DP"] = "최소 티어"
L["Editbox_DPTooltip"] = Ns.Colors.Green .. "최소 티어|r\n" .. "구렵/먹잇감 완료\n횟수에 포함할 최소 티어\n\n옵션 " .. Ns.Colors.Green .. "티어 8+|r 가 선택되어 있으면 이 설정은 무시됩니다"
L["Display_All"] = "전체"
L["Display_Tier8"] = "티어 8+"
L["Display_Tier8Tip"] = ""
L["Vault_Tooltip"] = "대금고에 추가"
L["Vault_TooltipTooltip"] = Ns.Colors.Green .. "대금고에 추가|r\n" .. "대금고: 세계 툴팁에 \n구렛/먹잇감 완료 횟수를 \n표시합니다"
L["VT_Header"] = ": Weekly runs"
L["VT_Delves"] = "구렛"
L["VT_Prey"] = "먹잇감"
L["VT_Tier"] = "티어"
L["VT_Normal"] = "일반"
L["VT_Hard"] = "어려움"
L["VT_Nightmare"] = "악몽"
L["Display_Total"] = "총 인원 표시"
L["Display_Total"] = "총 인원"
L["BNet"] = "BattleNet"

-- Decimals
L["Decimals_DefaultTip"] = ""
L["Decimals_OneTip"] = ""
L["Decimals_TwoTip"] = ""
L["Decimals_Default"] = "반올림 소수점"
L["Decimals_One"] = "반올림 소수점"
L["Decimals_Two"] = "반올림 소수점"

-- Caps
-- Caps
L["Cap_Percent"] = "퍼센트 상한"
L["Cap_PercentTooltip"] = Ns.Colors.Green .. "퍼센트 상한|r\n" .. "소프트 또는 하드 상한의 백분율을 설정합니다.\n감소 수익 상한이나 기타 개인 임계값으로도 사용할 수 있습니다.\n\n설정 값에 도달하면 해당 능력치가 녹색으로 표시됩니다.\n\n값을 0으로 설정하면 상한 색상을 비활성화합니다."
L["Cap_Rating"] = "수치 상한"
L["Cap_RatingTooltip"] = Ns.Colors.Green .. "수치 상한|r\n" .. "소프트 또는 하드 상한의 수치(등급)를 설정합니다.\n감소 수익 상한이나 기타 개인 임계값으로도 사용할 수 있습니다.\n\n설정 값에 도달하면 해당 능력치가 녹색으로 표시됩니다.\n\n값을 0으로 설정하면 상한 색상을 비활성화합니다."

-- Diminishing Returns
L["DR_Display"] = "DR 표시"
L["DR_DisplayTooltip"] = Ns.Colors.Green .. "수확 체감|r\n" .. "수확 체감으로 인해 손실된 퍼센트를 \n능력치 값 옆에 표시합니다 \n\n점수 보너스가 30%를 초과할 때만 \n표시됩니다 (체감 임계값)"
L["DR_Gradient"] = "체감 색상"
L["DR_GradientTooltip"] = Ns.Colors.Green .. "체감 색상|r\n현재 수확 체감 구간에 따라 \n능력치 값에 색상을 적용합니다 \n\n" .. "|cff71ffc9100%|r" .. " 효율 \n" .. "|cff66ff0090%|r" .. " 효율 \n" .. "|cffffff0080%|r" .. " 효율 \n" .. "|cffff880070%|r" .. " 효율 \n" .. "|cffff440060%|r" .. " 효율 \n" .. "|cffff000050%|r" .. " 효율"

-- Stat Bars
L["StaticBar"] = "정적 바"
L["StaticBarTooltip"] = Ns.Colors.Green .. "정적 바|r\n" .. "각 능력치 뒤에 장식용\n정적 배경 바를 활성화합니다 \n\n둘 다 활성화하면 동적 바가 \n우선 표시됩니다"
L["ShowBar"] = "동적 바"
L["ShowBarTooltip"] = Ns.Colors.Green .. "동적 바|r\n" .. "능력치 값을 설정된 최대값까지\n채워 표시하는 상태바를\n활성화합니다"