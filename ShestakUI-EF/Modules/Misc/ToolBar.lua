local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true or C.ef.use_right_toolbar ~= true then return end

----------------------------------------------------------------------------------------
--	ToolBar(by m2jest1c for Dark ShestakUI)(edited by Vittore)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "ToolBar", UIParent)
frame:CreatePanel("Invisible", 16, C.chat.background and C.chat.height + 5 or C.chat.height + 1, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -2, C.chat.background and 25 or 20)
if C.ef.right_toolbar_mouseover == true then
	frame:SetAlpha(0)
	frame:SetScript("OnEnter", function()
		frame:FadeIn()
	end)
	frame:SetScript("OnLeave", function()
		frame:FadeOut()
	end)
end

local lootButton = CreateFrame("Button", "$parentLootButton", frame)
lootButton:CreatePanel("Transparent", 16, 16, "BOTTOM", frame, "BOTTOM", 0, 0)
lootButton:SetFrameStrata("HIGH")
lootButton:SetFrameLevel(2)
lootButton:SetBackdropBorderColor(0.3, 0.3, 0.9)
lootButton.t = lootButton:CreateTexture(nil, "ARTWORK")
lootButton.t:SetTexture(C.media.blank)
lootButton.t:SetVertexColor(1, 0.82, 0, 1)
lootButton.t:SetPoint("TOPLEFT", lootButton, "TOPLEFT", 2, -2)
lootButton.t:SetPoint("BOTTOMRIGHT", lootButton, "BOTTOMRIGHT", -2, 2)
lootButton:HookScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:AddLine("Loot Frame")
	GameTooltip:AddLine("|cffffffff".."Right click to show or hide loot frame")
	GameTooltip:Show()
end)
lootButton:HookScript("OnLeave", function()
	GameTooltip:Hide()
end)

local damageButton = CreateFrame("Button", "$parentDamageButton", frame)
damageButton:CreatePanel("Transparent", 16, 16, "BOTTOM", lootButton, "TOP", 0, C.chat.background and 4 or 3)
damageButton:SetFrameStrata("HIGH")
damageButton:SetFrameLevel(2)
damageButton:SetBackdropBorderColor(0.9, 0.1, 0.1)
damageButton.t = damageButton:CreateTexture(nil, "ARTWORK")
damageButton.t:SetTexture(C.media.blank)
damageButton.t:SetVertexColor(1, 0.82, 0, 1)
damageButton.t:SetPoint("TOPLEFT", damageButton, "TOPLEFT", 2, -2)
damageButton.t:SetPoint("BOTTOMRIGHT", damageButton, "BOTTOMRIGHT", -2, 2)
damageButton:HookScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:AddLine("Damage Meter")
	GameTooltip:AddLine("|cffffffff".."Right click to show or hide damage meter")
	GameTooltip:Show()
end)
damageButton:HookScript("OnLeave", function()
	GameTooltip:Hide()
end)

local combatLogButton = CreateFrame("Button", "$parentCombatLogButton", frame)
combatLogButton:CreatePanel("Transparent", 16, 16, "BOTTOM", damageButton, "TOP", 0, C.chat.background and 4 or 3)
combatLogButton:SetFrameStrata("HIGH")
combatLogButton:SetFrameLevel(2)
combatLogButton:SetBackdropBorderColor(0.3, 0.9, 0.3)
combatLogButton.t = combatLogButton:CreateTexture(nil, "ARTWORK")
combatLogButton.t:SetTexture(C.media.blank)
combatLogButton.t:SetVertexColor(1, 0.82, 0, 1)
combatLogButton.t:SetPoint("TOPLEFT", combatLogButton, "TOPLEFT", 2, -2)
combatLogButton.t:SetPoint("BOTTOMRIGHT", combatLogButton, "BOTTOMRIGHT", -2, 2)
combatLogButton:HookScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:AddLine("Combat Log")
	GameTooltip:AddLine("|cffffffff".."Right click to enable or disable logging")
	GameTooltip:Show()
end)
combatLogButton:HookScript("OnLeave", function()
	GameTooltip:Hide()
end)

local damagemeter = false

local LootShow = function()
	ChatFrame3:ClearAllPoints()	
	if C.chat.background == true then
		ChatFrame3:SetPoint("BOTTOMRIGHT", C.position.chat[2], "BOTTOMRIGHT", -C.position.chat[4] - 1, C.position.chat[5] + 4)
		if C.chat.tabs_mouseover == true then
			TooltipAnchor:SetPoint("BOTTOMRIGHT", ChatBackgroundRight, "TOPRIGHT", 0, 3)
		else
			TooltipAnchor:SetPoint("BOTTOMRIGHT", ChatTabsPanelRight, "TOPRIGHT", 0, 3)
		end
	else
		ChatFrame3:SetPoint("BOTTOMRIGHT", C.position.chat[2], "BOTTOMRIGHT", -C.position.chat[4] - 1, C.position.chat[5])
		TooltipAnchor:SetPoint("BOTTOMRIGHT", RightPanel, "TOPRIGHT", 0, 3)
	end
	lootButton.t:SetAlpha(1)
	ChatFrame3Tab:Show()
	SavedOptionsPerChar.LootFrame = true
end

local LootHide = function()
	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", 20, 0)	
	lootButton.t:SetAlpha(0)
	ChatFrame3Tab:Hide()
	SavedOptionsPerChar.LootFrame = false
end

local DamageShow = function()
	if damagemeter == "Recount" then
		Recount_MainWindow:Show()
		TooltipAnchor:SetPoint("BOTTOMRIGHT", Recount_MainWindow, "TOPRIGHT", 2, 5)
	elseif damagemeter == "alDamageMeter" then
		alDamageMeterFrame:ClearAllPoints()
		alDamageMeterFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -23, 26)
		TooltipAnchor:SetPoint("BOTTOMRIGHT", alDamageMeterFrame, "TOPRIGHT", 2, 5)
	elseif damagemeter == "Details" then
		_detalhes:ReabrirTodasInstancias()
	end
	damageButton.t:SetAlpha(1)
	SavedOptionsPerChar.DamageMeter = true
end

local DamageHide = function()
	if damagemeter == "Recount" then
		Recount_MainWindow:Hide()
	elseif damagemeter == "alDamageMeter" then
		alDamageMeterFrame:ClearAllPoints()
		alDamageMeterFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", 23, 26)
	elseif damagemeter == "Details" then
		_detalhes:ShutDownAllInstances()		
	end
	damageButton.t:SetAlpha(0)
	SavedOptionsPerChar.DamageMeter = false
end

local detailsEmbedInit = function()
	details = _G._detalhes
	
	local detailsInstances = {}

	for _, instance in details:ListInstances() do
		tinsert(detailsInstances, instance)
	end
	
	local maxInstancesAmount = 2
	if (details:GetMaxInstancesAmount() < maxInstancesAmount) then
		details:SetMaxInstancesAmount(maxInstancesAmount)
	end
	
	local instancesAmount = details:GetNumInstancesAmount()

	for i = instancesAmount + 1, maxInstancesAmount do
		local newInstance = details:CreateInstance(i)

		if (type(newInstance) == "table") then
			tinsert(detailsInstances, newInstance)
		end
	end

	details:SetTooltipBackdrop("Blizzard Tooltip", 16, {1, 1, 1, 0})	
	
	local width = C.chat.width / 2
	local height = C.chat.height - 2
	
	EmbedDetailsWindow(detailsInstances[1], width, height, 'BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -(width+23), 23)
	EmbedDetailsWindow(detailsInstances[2], width, height, 'BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -23, 23)	
end

function EmbedDetailsWindow(window, width, height, point, relativeFrame, relativePoint, ofsx, ofsy)
	if not window then return end

	if (not window:IsEnabled()) then
		window:EnableInstance()
	end

	window:UngroupInstance()

	window.baseframe:ClearAllPoints()
	window.baseframe:SetParent(relativeFrame)
	window.baseframe:SetFrameStrata("LOW")
	window.baseframe:SetFrameLevel(1)

	ofsx = ofsx - 1
	if (window.skin == "Forced Square") then
		ofsx = ofsx - 1
		if (window:GetId() == 2) then
			window:SetSize(width+1, height - 20)
		else
			window:SetSize(width, height - 20)
		end
	elseif (window.skin == "ElvUI Frame Style") then
		if (window:GetId() == 2) then
			window:SetSize(width-1, height - 20)
		else
			if NumberToEmbed == 1 then
				window:SetSize(width-2, height - 20)
			else
				window:SetSize(width, height - 20)
			end
		end
	elseif (window.skin == "ElvUI Style II") then
		if (window:GetId() == 2) then
			window:SetSize(width, height - 20)
		else
			if NumberToEmbed == 1 then
				window:SetSize(width-2, height - 20)
			else
				window:SetSize(width-1, height - 20)
			end
		end
	else
		window:SetSize(width, height - 20)
	end

	window.baseframe:SetPoint(point, relativeFrame, relativePoint, ofsx, ofsy)
	window:SaveMainWindowPosition()
	window:RestoreMainWindowPosition()

	window:LockInstance(true)

	if (window:GetId() == 2) then
		window:MakeInstanceGroup({1})
	end

	if (window:GetId() == 1) then
		_G.DetailsRowFrame1:SetParent(_G.DetailsBaseFrame1)
		_G.DetailsRowFrame1:SetFrameLevel(_G.DetailsBaseFrame1:GetFrameLevel()+1)
	elseif (window:GetId() == 2) then
		_G.DetailsRowFrame2:SetParent(_G.DetailsBaseFrame2)
		_G.DetailsRowFrame2:SetFrameLevel(_G.DetailsBaseFrame2:GetFrameLevel()+1)
	end

	window:ChangeSkin()

	if (window.skin ~= "Forced Square") then
		if (AS:CheckOption("DetailsBackdrop")) then
			window:ShowSideBars()
		else
			window:HideSideBars()

			local skin = Details.skins[window.skin]

			window.row_info.space.left = skin.instance_cprops.row_info.space.left
			window.row_info.space.right = skin.instance_cprops.row_info.space.right

			window:InstanceWallpaper (false)

			window:SetBarGrowDirection()
		end
	elseif (window.skin == "Forced Square") then
		if C.chat.background == true then
			window:ShowSideBars()
			window:InstanceColor (1, 1, 1, 1, nil, true)
		else
			window:HideSideBars()
			window:InstanceColor (1, 1, 1, 0, nil, true)

			local skin = Details.skins[window.skin]

			window.row_info.space.left = skin.instance_cprops.row_info.space.left
			window.row_info.space.right = skin.instance_cprops.row_info.space.right

			window:InstanceWallpaper (false)

			window:SetBarGrowDirection()
		end
	end

	if (window:GetSegment() ~= 0) then
		window:SetDisplay (0)
	end
end

local function lootFrameInit()
	ChatFrame3:SetSize(C.chat.width, C.chat.height)
end

lootButton:SetScript("OnMouseUp", function(_, button)
	if button == "RightButton" then
		ToggleLootHistoryFrame()
	else
		if damagemeter ~= nil then
			if SavedOptionsPerChar.LootFrame == true and SavedOptionsPerChar.DamageMeter == false then
				LootHide()
				TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
			elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == true then
				LootShow()
				DamageHide()
			else
				LootShow()
			end
		else
			if SavedOptionsPerChar.LootFrame == true then
				LootHide()
				TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
			else
				LootShow()
			end
		end
	end
end)

damageButton:SetScript("OnMouseUp", function()
	if SavedOptionsPerChar.DamageMeter == true and SavedOptionsPerChar.LootFrame == false then
		DamageHide()
		TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
	elseif SavedOptionsPerChar.DamageMeter == false and SavedOptionsPerChar.LootFrame == true then
		DamageShow()
		LootHide()
	else
		DamageShow()
	end
end)

combatLogButton:SetScript("OnMouseUp", function()	
	if LoggingCombat() then
		combatLogButton.t:SetAlpha(0)
	else
		combatLogButton.t:SetAlpha(1)
	end
	SlashCmdList.COMBATLOG()
end)

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:HookScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then		
		self:UnregisterEvent(event)
		if LoggingCombat() then
			combatLogButton.t:SetAlpha(1)
		else
			combatLogButton.t:SetAlpha(0)
		end
		if IsAddOnLoaded("alDamageMeter") then
			damagemeter = "alDamageMeter"
		elseif IsAddOnLoaded("Recount") then
			damagemeter = "Recount"
			Recount_MainWindow:ClearAllPoints()
			Recount_MainWindow:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 18)
		elseif IsAddOnLoaded("Details") then
			damagemeter = "Details"
			detailsEmbedInit()		
		else
			damagemeter = false
		end
		lootFrameInit()
		if SavedOptionsPerChar.LootFrame == nil then SavedOptionsPerChar.LootFrame = true end
		if SavedOptionsPerChar.DamageMeter == nil then SavedOptionsPerChar.DamageMeter = false end
		if SavedOptionsPerChar.LootFrame == true and damagemeter ~= false then
			LootShow()
			DamageHide()
		elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == true and damagemeter ~= false then
			LootHide()
			DamageShow()
		elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == false and damagemeter ~= false then
			LootHide()
			DamageHide()
			TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
		elseif SavedOptionsPerChar.LootFrame == false then
			LootHide()
			damageButton:Hide()
			combatLogButton:SetPoint("BOTTOM", lootButton, "TOP", 0, C.chat.background and 4 or 3)
		else
			LootShow()
			damageButton:Hide()
			combatLogButton:SetPoint("BOTTOM", lootButton, "TOP", 0, C.chat.background and 4 or 3)
		end
	end
end)
