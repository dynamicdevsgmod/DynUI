local PANEL = {}

function PANEL:Init()
    self.H = self:GetTall()
    self:SetText("")
end

function PANEL:Paint(w,h)
    draw.RoundedBox(6, 0, 2, w, h - 4, self.darker_color or color_white)

    if self:IsHovered() and input.IsMouseDown(MOUSE_LEFT) then
        draw.RoundedBox(6, 0, 1, w, h - 2, self.Color or color_white)
        draw.SimpleText(self.DText or "Button", "DynUI_Button", w * .5, h * .44, self.TextColor or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
        draw.RoundedBox(6, 0, 0, w, h - 6, self.Color or color_white)
        draw.SimpleText(self.DText or "Button", "DynUI_Button", w * .5, h * .4, self.TextColor or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:SetColor(clr) 
    self.Color = clr
    self.darker_color = DynUI:DarkenColor(clr)
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