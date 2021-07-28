local PANEL = {}

function PANEL:Init()
    self.H = self:GetTall()
    self:SetText("")
end

function PANEL:OnCursorEntered()
    self.BackupColor = self.Color
    self.DarkBackupColor = self.DarkColor

    self.Color = DynUI:LightenColor(self.Color)
    self.DarkColor = DynUI:LightenColor(self.DarkColor)
end

function PANEL:OnCursorExited()
    self.Color = self.BackupColor
    self.DarkColor = self.DarkBackupColor

    self.BackupColor = self.Color
    self.DarkBackupColor = self.DarkColor
end

function PANEL:Paint(w,h)
    draw.RoundedBox(6, 0, 2, w, h - 4, self.DarkColor or color_white)

    if self:IsHovered() and input.IsMouseDown(MOUSE_LEFT) then
        draw.RoundedBox(6, 0, 2, w, h - 4, self.Color or color_white)
        draw.SimpleText(self.DText or "Button", "DynUI_Button", w * .5, (h * .5) - 2, self.TextColor or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
        draw.RoundedBox(6, 0, 0, w, h - 6, self.Color or color_white)
        draw.SimpleText(self.DText or "Button", "DynUI_Button", w * .5, (h * .5) - 4, self.TextColor or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:SetColor(clr) 
    self.Color = clr
    self.DarkColor = DynUI:DarkenColor(clr)
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