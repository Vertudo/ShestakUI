local T, C, L, _ = unpack(select(2, ...))

-- EF
local template = "ClassColor"
if C.ef.use_custom_color then
	template = "Default"
end
local shadow = ""
if C.ef.use_shadow then
	shadow = "Shadow"
end
local borderColor = T.color;
if C.ef.use_custom_color then
	borderColor = {r = C.media.border_color[1], g = C.media.border_color[2], b = C.media.border_color[3]}
end

----------------------------------------------------------------------------------------
--	Bottom bars anchor
----------------------------------------------------------------------------------------
local bottombaranchor = CreateFrame("Frame", "ActionBarAnchor", oUF_PetBattleFrameHider)
bottombaranchor:CreatePanel("Invisible", 1, 1, unpack(C.position.bottom_bars))
bottombaranchor:SetWidth((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
if C.actionbar.bottombars == 2 then
	bottombaranchor:SetHeight((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.actionbar.bottombars == 3 then
	if C.actionbar.split_bars == true then
		bottombaranchor:SetHeight((C.actionbar.button_size * 2) + C.actionbar.button_space)
	else
		bottombaranchor:SetHeight((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
	end
else
	bottombaranchor:SetHeight(C.actionbar.button_size)
end
bottombaranchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Right bars anchor
----------------------------------------------------------------------------------------
local rightbaranchor = CreateFrame("Frame", "RightActionBarAnchor", oUF_PetBattleFrameHider)
rightbaranchor:CreatePanel("Invisible", 1, 1, unpack(C.position.right_bars))
rightbaranchor:SetHeight((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
if C.actionbar.rightbars == 1 then
	rightbaranchor:SetWidth(C.actionbar.button_size)
elseif C.actionbar.rightbars == 2 then
	rightbaranchor:SetWidth((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.actionbar.rightbars == 3 then
	rightbaranchor:SetWidth((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
else
	rightbaranchor:Hide()
end
rightbaranchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Split bar anchor
----------------------------------------------------------------------------------------
if C.actionbar.split_bars == true then
	local SplitBarLeft = CreateFrame("Frame", "SplitBarLeft", oUF_PetBattleFrameHider)
	SplitBarLeft:CreatePanel("Invisible", (C.actionbar.button_size * 3) + (C.actionbar.button_space * 2), (C.actionbar.button_size * 2) + C.actionbar.button_space, "BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -C.actionbar.button_space, 0)
	SplitBarLeft:SetFrameStrata("LOW")

	local SplitBarRight = CreateFrame("Frame", "SplitBarRight", oUF_PetBattleFrameHider)
	SplitBarRight:CreatePanel("Invisible", (C.actionbar.button_size * 3) + (C.actionbar.button_space * 2), (C.actionbar.button_size * 2) + C.actionbar.button_space, "BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", C.actionbar.button_space, 0)
	SplitBarRight:SetFrameStrata("LOW")
end

----------------------------------------------------------------------------------------
--	Pet bar anchor
----------------------------------------------------------------------------------------
local petbaranchor = CreateFrame("Frame", "PetActionBarAnchor", oUF_PetBattleFrameHider)
if C.actionbar.petbar_horizontal == true then
	petbaranchor:CreatePanel("Invisible", (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), (C.actionbar.button_size + C.actionbar.button_space), unpack(C.position.pet_horizontal))
elseif C.ef.use_actionbar_panels == true then
	petbaranchor:CreatePanel("Invisible", C.actionbar.button_size, (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), "RIGHT", rightbaranchor, "LEFT", -5, 0)	 
elseif C.actionbar.rightbars > 0 then
	petbaranchor:CreatePanel("Invisible", C.actionbar.button_size + 3, (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), "RIGHT", rightbaranchor, "LEFT", 0, 0)
else
	petbaranchor:CreatePanel("Invisible", (C.actionbar.button_size + C.actionbar.button_space), (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), unpack(C.position.right_bars))
end
petbaranchor:SetFrameStrata("LOW")
RegisterStateDriver(petbaranchor, "visibility", "[pet,novehicleui,nopossessbar,nopetbattle] show; hide")

----------------------------------------------------------------------------------------
--	Stance bar anchor
----------------------------------------------------------------------------------------
local shiftanchor = CreateFrame("Frame", "ShapeShiftBarAnchor", oUF_PetBattleFrameHider)
shiftanchor:RegisterEvent("PLAYER_LOGIN")
shiftanchor:RegisterEvent("PLAYER_ENTERING_WORLD")
shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
shiftanchor:SetScript("OnEvent", function(self, event, ...)
	local forms = GetNumShapeshiftForms()
	if forms > 0 then
		if C.actionbar.stancebar_horizontal ~= true then
			shiftanchor:SetWidth(C.actionbar.button_size + 3)
			shiftanchor:SetHeight((C.actionbar.button_size * forms) + ((C.actionbar.button_space * forms) - 3))
			shiftanchor:SetPoint("TOPLEFT", _G["StanceButton1"], "TOPLEFT")
		else
			shiftanchor:SetWidth((C.actionbar.button_size * forms) + ((C.actionbar.button_space * forms) - 3))
			shiftanchor:SetHeight(C.actionbar.button_size)
			shiftanchor:SetPoint("TOPLEFT", _G["StanceButton1"], "TOPLEFT")
		end
	end
end)

----------------------------------------------------------------------------------------
--	Bottom line
----------------------------------------------------------------------------------------
local bottompanel = CreateFrame("Frame", "BottomPanel", UIParent)
bottompanel:CreatePanel(template, 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 20)
bottompanel:SetPoint("LEFT", UIParent, "LEFT", 21, 0)
bottompanel:SetPoint("RIGHT", UIParent, "RIGHT", -21, 0)
bottompanel:SetTemplate("Default", "Shadow")

----------------------------------------------------------------------------------------
--	Chat background
----------------------------------------------------------------------------------------
if C.chat.background == true then
	local chatbd = CreateFrame("Frame", "ChatBackground", UIParent)
	chatbd:CreatePanel("Transparent", C.chat.width + 7, C.chat.height + 4, "TOPLEFT", ChatFrame1, "TOPLEFT", -3, 1, shadow)	
	chatbd:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b)
	chatbd:SetBackdropColor(0, 0, 0, C.chat.background_alpha)

	if C.chat.tabs_mouseover ~= true then
		local chattabs = CreateFrame("Frame", "ChatTabsPanel", UIParent)
		chattabs:CreatePanel("Transparent", chatbd:GetWidth(), 20, "BOTTOM", chatbd, "TOP", 0, 3, shadow)
		chattabs:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b)
		chattabs:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
	end
else
	local leftpanel = CreateFrame("Frame", "LeftPanel", UIParent)
	leftpanel:CreatePanel(template, 1, C.chat.height - 2, "BOTTOMLEFT", bottompanel, "LEFT", 0, 0)
	leftpanel:SetTemplate("Default", "Shadow")
end

----------------------------------------------------------------------------------------
--	Top panel
----------------------------------------------------------------------------------------
if C.toppanel.enable ~= true then return end

local toppanelanchor = CreateFrame("Frame", "TopPanelAnchor", oUF_PetBattleFrameHider)
toppanelanchor:SetPoint(unpack(C.position.top_panel))
toppanelanchor:SetSize(C.toppanel.width, C.toppanel.height / 2)

local toppanel = CreateFrame("Frame", "TopPanel", oUF_PetBattleFrameHider)
toppanel:SetPoint("CENTER", toppanelanchor, "CENTER", 0, 0)
toppanel:SetSize(C.toppanel.width, C.toppanel.height / 2)
if C.toppanel.mouseover == true then
	toppanel:SetAlpha(0)
	toppanel:SetScript("OnEnter", function()
		if InCombatLockdown() then return end
		toppanel:SetAlpha(1)
	end)
	toppanel:SetScript("OnLeave", function()
		toppanel:SetAlpha(0)
	end)
end

toppanel.bgl = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgl:SetPoint("RIGHT", toppanel, "CENTER", 0, 0)
toppanel.bgl:SetSize(C.toppanel.width / 2, C.toppanel.height / 2)
toppanel.bgl:SetTexture(C.media.blank)
toppanel.bgl:SetGradientAlpha("HORIZONTAL", borderColor.r, borderColor.g, borderColor.b, 0, borderColor.r, borderColor.g, borderColor.b, 0.1)

toppanel.bgr = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgr:SetPoint("LEFT", toppanel, "CENTER", 0, 0)
toppanel.bgr:SetSize(C.toppanel.width / 2, C.toppanel.height / 2)
toppanel.bgr:SetTexture(C.media.blank)
toppanel.bgr:SetGradientAlpha("HORIZONTAL", borderColor.r, borderColor.g, borderColor.b, 0.1, borderColor.r, borderColor.g, borderColor.b, 0)

toppanel.tbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbl:SetPoint("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tbl:SetSize(C.toppanel.width / 2, 3)
toppanel.tbl:SetTexture(C.media.blank)
toppanel.tbl:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 1)

toppanel.tcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcl:SetPoint("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tcl:SetSize(C.toppanel.width / 2, 1)
toppanel.tcl:SetTexture(C.media.blank)
toppanel.tcl:SetGradientAlpha("HORIZONTAL", borderColor.r, borderColor.g, borderColor.b, 0, borderColor.r, borderColor.g, borderColor.b, 1)

toppanel.tbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbr:SetPoint("LEFT", toppanel, "TOP", 0, 0)
toppanel.tbr:SetSize(C.toppanel.width / 2, 3)
toppanel.tbr:SetTexture(C.media.blank)
toppanel.tbr:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 1, 0, 0, 0, 0)

toppanel.tcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcr:SetPoint("LEFT", toppanel, "TOP", 0, 0)
toppanel.tcr:SetSize(C.toppanel.width / 2, 1)
toppanel.tcr:SetTexture(C.media.blank)
toppanel.tcr:SetGradientAlpha("HORIZONTAL", borderColor.r, borderColor.g, borderColor.b, 1, borderColor.r, borderColor.g, borderColor.b, 0)

toppanel.bbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbl:SetPoint("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bbl:SetSize(C.toppanel.width / 2, 3)
toppanel.bbl:SetTexture(C.media.blank)
toppanel.bbl:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 1)

toppanel.bcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcl:SetPoint("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bcl:SetSize(C.toppanel.width / 2, 1)
toppanel.bcl:SetTexture(C.media.blank)
toppanel.bcl:SetGradientAlpha("HORIZONTAL", borderColor.r, borderColor.g, borderColor.b, 0, borderColor.r, borderColor.g, borderColor.b, 1)

toppanel.bbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbr:SetPoint("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bbr:SetSize(C.toppanel.width / 2, 3)
toppanel.bbr:SetTexture(C.media.blank)
toppanel.bbr:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 1, 0, 0, 0, 0)

toppanel.bcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcr:SetPoint("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bcr:SetSize(C.toppanel.width / 2, 1)
toppanel.bcr:SetTexture(C.media.blank)
toppanel.bcr:SetGradientAlpha("HORIZONTAL", borderColor.r, borderColor.g, borderColor.b, 1, borderColor.r, borderColor.g, borderColor.b, 0)

----------------------------------------------------------------------------------------
--	EF
----------------------------------------------------------------------------------------
if C.ef.use_actionbar_panels == true then
	local bpanel = CreateFrame("Frame", "ActionBarPanel", bottombaranchor)
	bpanel:SetTemplate("Default", "Shadow")
	bpanel:SetPoint("TOP", bottombaranchor, "TOP", 0, C.actionbar.button_space)
	if C.actionbar.split_bars == true then
		bpanel:SetPoint("BOTTOMLEFT", SplitBarLeft, "BOTTOMLEFT", -C.actionbar.button_space, -C.actionbar.button_space)
		bpanel:SetPoint("BOTTOMRIGHT", SplitBarRight, "BOTTOMRIGHT", C.actionbar.button_space, -C.actionbar.button_space)
	else
		bpanel:SetPoint("BOTTOMLEFT", bottombaranchor, "BOTTOMLEFT", -C.actionbar.button_space, -C.actionbar.button_space)
		bpanel:SetPoint("BOTTOMRIGHT", bottombaranchor, "BOTTOMRIGHT", C.actionbar.button_space, -C.actionbar.button_space)
	end

	local rpanel = CreateFrame("Frame", nil, rightbaranchor)
	rpanel:SetTemplate("Default", "Shadow")
	rpanel:SetFrameLevel(1)
	rpanel:SetFrameStrata("BACKGROUND")
	rpanel:SetPoint("BOTTOMLEFT", rightbaranchor, "BOTTOMLEFT", -C.actionbar.button_space, -C.actionbar.button_space)
	rpanel:SetPoint("TOPRIGHT", rightbaranchor, "TOPRIGHT", C.actionbar.button_space, C.actionbar.button_space)
	
	local ppanel = CreateFrame("Frame", nil, PetActionButton1)
	ppanel:SetTemplate("Default", "Shadow")
	ppanel:SetFrameLevel(1)
	ppanel:SetFrameStrata("BACKGROUND")
	ppanel:SetPoint("BOTTOMLEFT", petbaranchor, "BOTTOMLEFT", -C.actionbar.button_space, -C.actionbar.button_space)
	ppanel:SetPoint("TOPRIGHT", petbaranchor, "TOPRIGHT", C.actionbar.button_space, C.actionbar.button_space)
end

if C.ef.use_right_toolbar then
	if C.chat.background == true then
		local chatbdright = CreateFrame("Frame", "ChatBackgroundRight", ChatFrame3)
		chatbdright:CreatePanel("Transparent", C.chat.width + 7, C.chat.height + 4, "TOPLEFT", ChatFrame3, "TOPLEFT", -3, 1, shadow)
		chatbdright:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b)
		chatbdright:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
		
		if C.chat.tabs_mouseover ~= true then
			local chattabsright = CreateFrame("Frame", "ChatTabsPanelRight", chatbdright)
			chattabsright:CreatePanel("Transparent", chatbdright:GetWidth(), 20, "BOTTOM", chatbdright, "TOP", 0, 3, shadow)
			chattabsright:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b)
			chattabsright:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
		end
	else
		local rightpanel = CreateFrame("Frame", "RightPanel", UIParent)
		rightpanel:CreatePanel(template, 1, C.chat.height - 2, "BOTTOMRIGHT", bottompanel, "RIGHT", 0, 0)
		rightpanel:SetTemplate("Default", "Shadow")				
	end
end