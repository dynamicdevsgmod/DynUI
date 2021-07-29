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
        DynUI:DrawCircle( w * .5, h * .5, 9.5, 30 )
    end

    self.Color = DynUI.Switch.Disabled
end

function PANEL:ToggleLerpColor(status)
    self.Animating = true

    local col
    
    if not status then
        col = DynUI.Switch.Disabled        
    else
        col = DynUI.Switch.Enabled
    end

    local anim = self:NewAnimation( .4, 0, nil, function() 
        self.Animating = false 
    end )
	anim.Think = function(this, _panel, fraction)
        self.Color = DynUI:LerpColor(.4, self.Color, col)
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

    self:ToggleLerpColor(self.Toggle)
end

function PANEL:DoToggle(bool)
    if not bool then return self.Toggle end

    if type(bool) != "boolean" then error("Wrong type passed to DynSwitch:Toggle()") end
    self.Toggle = bool
    self.Button:SetPos(self:GetWide() - self.Button:GetWide() - 3, 0)

    if bool then
        self.Color = DynUI.Switch.Enabled
    else
        self.Color = DynUI.Switch.Disabled
    end
end

function PANEL:Paint(w,h)
    draw.RoundedBox(16, 0, 0, w, h, self.Color)
end

derma.DefineControl("DynSwitch", "Dynamic VGUI Toggle Switch", PANEL, "DPanel")