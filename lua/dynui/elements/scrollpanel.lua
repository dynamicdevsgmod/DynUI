local PANEL = {}

function PANEL:Init()
    local bar = self:GetVBar()
    bar:SetWide(8)
    bar:SetHideButtons(true)
    bar.Paint = nil

    local col = DynUI.Neutral
    local col2 = DynUI:LightenColor(DynUI.Neutral, 20)

    bar.btnGrip.Paint = function(me,w,h)

        if me:IsHovered() or me.Depressed then
            col = col2
        else
            col = DynUI.Neutral
        end
        
        draw.RoundedBox(12,0,0,w,h,col)
    end
end

derma.DefineControl("DynScrollPanel", "Dynamic VGUI scroll panel with custom spinner.", PANEL, "DScrollPanel")