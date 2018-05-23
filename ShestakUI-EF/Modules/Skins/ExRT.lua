local T, C, L, _ = unpack(select(2, ...))
if C.ef.skins.exrt ~= true then return end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)	
	if not IsAddOnLoaded("ExRT") then return end
	
	SetModifiedBackdrop = function(self)
		local mainFrame = GExRT.A["MarksBar"].frame
		local name = GExRT.A.Marks:GetName(self._i)	
		
		if not (name and ExRT.A.Marks.Enabled) then
			if C.ef.use_custom_color then
				local color = C.ef.custom_color;
				mainFrame.markbuts[self._i]:SetBackdropBorderColor(color.r, color.g, color.b)	
			else
				mainFrame.markbuts[self._i]:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
			end	
		end
	end

	SetOriginalBackdrop = function(self)
		local mainFrame = GExRT.A["MarksBar"].frame
		local name = GExRT.A.Marks:GetName(self._i)
		if not (name and ExRT.A.Marks.Enabled) then
			mainFrame.markbuts[self._i]:SetBackdropBorderColor(unpack(C.media.border_color))
		end			
	end

	-- MarksBar
	local mainFrame = GExRT.A["MarksBar"].frame
	mainFrame:SetTemplate("Overlay")	
	mainFrame.edge:Hide()
	
	mainFrame.wmarksbuts.b:CreateBackdrop("Default")
	mainFrame.wmarksbuts.b.t:StripTextures()	
	
	-- Marks
	for _,markbut in pairs(mainFrame.markbuts) do
		markbut:SkinButton()			
		markbut.but:SetScript("OnEnter", SetModifiedBackdrop)
		markbut.but:SetScript("OnLeave", SetOriginalBackdrop)			
	end

	-- Start
	mainFrame.start:SkinButton()	
	-- Del
	mainFrame.del:SkinButton()	
	-- readyCheck
	mainFrame.readyCheck:SkinButton()	
	-- pull
	mainFrame.pull:SkinButton()		
end)