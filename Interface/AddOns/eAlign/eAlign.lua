SLASH_EA1 = "/align"
SLASH_EA2 = "/ea"
SLASH_EA3 = "/ealign"

local f

SlashCmdList["EA"] = function()
	if f then
		f:Hide()
		f = nil		
	else
		f = CreateFrame('Frame', nil, UIParent) 
		f:SetAllPoints(UIParent)
		
		local size = 20
		
		local halfCols = math.ceil((GetScreenWidth() / 2) / size)
		local halfRows = math.ceil((GetScreenHeight() / 2) / size)
		
		for i = -halfCols, halfCols do
			local t = f:CreateTexture(nil, 'BACKGROUND')
			if i == 0 then
				t:SetColorTexture(1, 1, 0, 0.5)
			else
				t:SetColorTexture(1, 1, 1, 0.15)
			end
			t:SetPoint('TOPLEFT', f, 'TOP', i * size - 1, 0)
			t:SetPoint('BOTTOMRIGHT', f, 'BOTTOM', i * size + 1, 0)
		end
		for i = -halfRows, halfRows do 
			local t = f:CreateTexture(nil, 'BACKGROUND')
			if i == 0 then
				t:SetColorTexture(1, 1, 0, 0.5)
			else
				t:SetColorTexture(1, 1, 1, 0.15)
			end
			t:SetPoint('TOPLEFT', f, 'LEFT', 0, i * size + 1)
			t:SetPoint('BOTTOMRIGHT', f, 'RIGHT', 0, i * size - 1)
		end	
	end
end