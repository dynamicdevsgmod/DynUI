local PANEL = {}

function PANEL:Init()
    self.Toggle = false
    self:SetCursor("hand")

    self.Button = self:Add("DPanel")
    self.Button:SetSize(20, self:GetTall())
    self.Button:SetX(3)
    self.Button:SetMouseInputEnabled(false)

    self:SetWide(60)

    local cir = DynUI.Circles.New(CIRCLE_FILLED, 10, self.Button:GetWide() * .5, self.Button:GetTall() * .5)
    cir:SetDistance(1)
    
    self.Button.Paint = function(me,w,h)
        surface.SetDrawColor(color_white)
        draw.NoTexture()
        cir()
    end

    self.Color = DynUI.Switch.Disabled


    -- Two circles at the start and end of the switch for better rounding
    self.LeftCircle = DynUI.Circles.New(CIRCLE_FILLED, 12.3, 12, self:GetTall() * .5)
    self.LeftCircle:SetDistance(1)

    self.RightCircle = self.LeftCircle:Copy()
    self.RightCircle:SetX(self:GetWide() - 16)
    self.RightCircle:SetDistance(1)

    self.Status = false
end

function PANEL:ToggleLerpColor(status)
    self.Animating = true

    self.Status = !self.Status
end


function PANEL:OnMousePressed( key )
    if key != MOUSE_LEFT then return end

    if self.Toggle then
        self.Button:MoveTo(3, 0, .4, 0, .5, function()
            self.Toggling = false
        end )

        surface.PlaySound("dynui/switch_off.mp3")
    else
        self.Button:MoveTo((self:GetWide() - self.Button:GetWide()) - 8, 0, .4, 0, .5, function()
            self.Toggling = false
        end)

        surface.PlaySound("dynui/switch_on.mp3")
    end

    self.Toggle = not self.Toggle

    self:ToggleLerpColor(self.Toggle)
end

function PANEL:OnMouseReleased(key)
    if key == MOUSE_LEFT then
        self:DoClick()
    end
end

function PANEL:DoToggle(bool)
    if not bool then return self.Toggle end

    if type(bool) != "boolean" then error("Wrong type passed to DynSwitch:Toggle()") end
    self.Toggle = bool
    self.Button:SetPos(self:GetWide() - self.Button:GetWide() - 8, 0)

    if bool then
        self.Color = DynUI.Switch.Enabled
        self.Status = true
    else
        self.Color = DynUI.Switch.Disabled
        self.Status = false
    end
end

function PANEL:Paint(w,h)
    if !self.Animating then goto skipanim end

    if self.Status then
        self.Color = DynUI:LerpColor(self.Color, DynUI.Switch.Enabled, 600)
    else
        self.Color = DynUI:LerpColor(self.Color, DynUI.Switch.Disabled, 600)
    end
    ::skipanim::

    draw.RoundedBox(16, 1, 0, w - 8, h, self.Color)

    draw.NoTexture()
    surface.SetDrawColor(self.Color)

    self.LeftCircle()
    self.RightCircle()
end

derma.DefineControl("DynSwitch", "Dynamic VGUI Toggle Switch", PANEL, "DPanel")