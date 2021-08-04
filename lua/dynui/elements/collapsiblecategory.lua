local PANEL = {}

function PANEL:Init()
    self.Color = DynUI.Sidebar.Primary

    self.Header.VBarHeight = 0
    self.Header.VBarOffset = 5
    if not self:GetExpanded() then
        self.Header.VBarHeight = 12
        self.Header.VBarOffset = 0
    end

    self:SetHeaderHeight(30)
    self.Header:SetFont("DynUI_Title")
    self.Header.Paint = function(me,w,h)
        surface.SetDrawColor(self.Color)
        surface.DrawRect(0,0,w,h)
                
        surface.SetDrawColor(color_white)
        surface.DrawRect(w - 30, h * .5, 12, 2)

        if self:GetExpanded() then
            
        else
            surface.DrawRect(w - 25, (h * .5) - me.VBarOffset, 2, me.VBarHeight)
            -- surface.DrawRect(w - 25, h * .5 - 5, 2, self.Header.VBarHeight)
            -- surface.DrawRect(w - 25, h * .5 + 2, 2, self.Header.VBarHeight)
        end
    end
end

function PANEL:OnToggle(expanded)
    local to = 0
    local OffsetTo = 0

    if self.Header.VBarHeight < 5 then
        to = 12
        OffsetTo = 5
    end

    local anim = self.Header:NewAnimation(.25, 0, 1)
    anim.Think = function()
        self.Header.VBarHeight = math.Approach(self.Header.VBarHeight,to,2)
        self.Header.VBarOffset = math.Approach(self.Header.VBarOffset,OffsetTo,2)
    end

end

function PANEL:SetFont(font)
    self.Header:SetFont(font)
end

function PANEL:SetColor(color)
    self.Color = color
end

derma.DefineControl("DynCollapsibleCategory", "Dynamic VGUI collapsible category", PANEL, "DCollapsibleCategory")