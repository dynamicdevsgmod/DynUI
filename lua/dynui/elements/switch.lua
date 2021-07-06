local PANEL = {}

function PANEL:Init()
    self.Toggle = false
    self:SetCursor("hand")

    self.Button = self:Add("DPanel")
    self.Button:SetSize(20, self:GetTall())
    self.Button:SetX(3)
    self.Button:SetMouseInputEnabled(false)

    self.Button.Paint = function(me,w,h)
        surface.SetDrawColor(color_white)
        draw.NoTexture()
        DynUI:DrawCircle( w * .5, h * .5, 10, 120 )
    end
end

function PANEL:OnMousePressed( key )
    if key != MOUSE_LEFT then return end

    if self.Toggle then
        self.Button:MoveTo(3, 0, .4, 0, .5, function()
            self.Toggling = false
        end )
    else
        self.Button:MoveTo(self:GetWide() - self.Button:GetWide() - 3, 0, .4, 0, .5, function()
            self.Toggling = false
        end)
    end

    self.Toggle = not self.Toggle
end

function PANEL:DoToggle(bool)
    if not bool then return self.Toggle end

    if type(bool) != "boolean" then error("Wrong type passed to DynSwitch:Toggle()") end
    self.Toggle = bool
    self.Button:SetPos(self:GetWide() - self.Button:GetWide(), 0)
end

function PANEL:Paint(w,h)
    if self.Toggle then
        draw.RoundedBox(12, 0, 0, w, h, DynUI.Switch.Enabled)
    else
        draw.RoundedBox(14, 0, 0, w, h, DynUI.Switch.Disabled)
    end
end

derma.DefineControl("DynSwitch", "Dynamic VGUI Toggle Switch", PANEL, "DPanel")