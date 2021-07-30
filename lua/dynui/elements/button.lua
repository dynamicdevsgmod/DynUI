local PANEL = {}

function PANEL:Init()
    self.H = self:GetTall()
    self:SetText("")
end

function PANEL:HoverCol(exit)
    self.Animating = true

    local nCol, nDarkCol
    
    if not exit then
        nCol = DynUI:LightenColor(self.Color)
        nDarkCol = DynUI:LightenColor(self.DarkColor)        
    else
        nCol = self.BckpClr
        nDarkCol = self.BckpClrDark
    end

    local anim = self:NewAnimation( .25, 0, nil, function() 
        self.Animating = false 
    end )
	anim.Think = function(this, _panel, fraction)
        self.Color = DynUI:LerpColor(.25, self.Color, nCol)
        self.DarkColor = DynUI:LerpColor(.25, self.DarkColor, nDarkCol)
    end
end

function PANEL:OnCursorEntered()
    self:HoverCol(false)
end

function PANEL:OnCursorExited()
    self:HoverCol(true)
end

function PANEL:OnMousePressed(key)
    if key == MOUSE_LEFT then
        self:HoverCol(true)
    end
end

function PANEL:OnMouseReleased(key)
   if key == MOUSE_LEFT then
       self:HoverCol(false)
   end 

   self:DoClick()
end


function PANEL:Paint(w,h)
    draw.RoundedBox(6, 0, 2, w, h - 4, self.DarkColor or color_white)

    if self:IsHovered() and input.IsMouseDown(MOUSE_LEFT) then
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
    self.DText = text
    return self.DText
end

derma.DefineControl("DynButton", "Dynamic VGUI Button", PANEL, "DButton")