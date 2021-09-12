local PANEL = {}
local spinner = Material("dynui/loader2.png", "smooth")

function PANEL:Init()
    self:SetText("")
end

function PANEL:DoSpinner(color)
    self.text = self:SetDText()
    self:SetDText("")

    self.Spinner = self:Add("DPanel")
    self.Spinner:SetSize(self:GetSize())

    function self.Spinner:Paint(w,h)
        if (not self.EndTime or SysTime() >= self.EndTime) then
            self.EndTime = SysTime() + 2
        end
        self.Rotation = ((self.EndTime - SysTime()) / 2) * 720

        draw.NoTexture()
        surface.SetDrawColor(color or color_white)
        surface.SetMaterial(spinner)
        surface.DrawTexturedRectRotated( w * .5, h * .5 - 3, 20, 20, math.Round(self.Rotation) )
    end
end

function PANEL:EndSpinner()
    self.Spinner:Remove()
    self:SetDText(self.text)
end

function PANEL:HoverCol(exit)
    self.Animating = true
    
    if not exit then
        self.nCol = DynUI:LightenColor(self.Color)
        self.nDarkCol = DynUI:LightenColor(self.DarkColor)        
    else
        self.nCol = self.BckpClr
        self.nDarkCol = self.BckpClrDark
    end
end

function PANEL:OnCursorEntered()
    if not self:IsEnabled() then self:SetCursor("no") return end

    self:HoverCol(false)
end

function PANEL:OnCursorExited()
    if not self:IsEnabled() then return end

    self:HoverCol(true)
end

function PANEL:OnMousePressed(key)
    if not self:IsEnabled() then return end

    if key == MOUSE_LEFT then
        self:HoverCol(true)
        surface.PlaySound("dynui/btn_down.mp3")
    end
end

function PANEL:OnMouseReleased(key)
    if not self:IsEnabled() then return end

    if key == MOUSE_LEFT then
       self:HoverCol(false)
       surface.PlaySound("dynui/btn_up.mp3")
       self:DoClick()
    end 
end


function PANEL:Paint(w,h)
    if !self.Animating then goto skipanim end

    self.Color = DynUI:LerpColor(self.Color, self.nCol, 50)
    self.DarkColor = DynUI:LerpColor(self.DarkColor, self.nDarkCol, 50)

    ::skipanim::

    draw.RoundedBox(6, 0, 2, w, h - 4, self.DarkColor or color_white)

    if self:IsHovered() and input.IsMouseDown(MOUSE_LEFT) and self:IsEnabled() then
        draw.RoundedBox(6, 0, 2, w, h - 4, self.Color or color_white)
        draw.SimpleText(self.DText or "Button", "DynUI_Button", w * .5, (h * .5) - 2, self.TextColor or DynUI.Grey, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
        draw.RoundedBox(6, 0, 0, w, h - 6, self.Color or color_white)
        draw.SimpleText(self.DText or "Button", "DynUI_Button", w * .5, (h * .5) - 4, self.TextColor or DynUI.Grey, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:SetColor(clr) 
    self.Color = clr
    self.DarkColor = DynUI:DarkenColor(clr)

    self.BckpClr = self.Color
    self.BckpClrDark = self.DarkColor
    return self.Color
end

function PANEL:SetTextColor(clr)
    self.TextColor = clr
    return self.TextColor
end

function PANEL:SetDText(text)
    if not text then return self.DText end
    self.DText = text
end

derma.DefineControl("DynButton", "Dynamic VGUI Button", PANEL, "DButton")