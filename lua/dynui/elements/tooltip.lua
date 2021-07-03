local PANEL = {}

function PANEL:Init()
    self:Center()
    self:MoveToFront()
    self.Prnt = nil
    self:SetDrawOnTop(true)
    self:SetTall(40)
    self:SetWide(100)
end

function PANEL:SetTTParent(panel)
    if type(panel) != "Panel" then error("SetTooltipParent (SetTTParent) expected panel, got "..type(panel)) end
    self.Prnt = panel
end

function PANEL:SetTTText(message)
    self.Text = message
end

function PANEL:Paint(w,h)
    draw.RoundedBox(2, 0,0,w,h - 10,DynUI.Tooltip)
    draw.SimpleText(self.Text or "Tooltip Test", "DynUI_Tooltip", w * .5, 15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    surface.SetDrawColor( DynUI.Tooltip )
	draw.NoTexture()
	surface.DrawPoly({
        { x = w * .4, y = 30 },
        { x = w * .6, y = 30 },
        { x = w * .5, y = 40 }
    })
end

function PANEL:Think()
    if not self.Prnt then return end
    if not IsValid(self.Prnt) then self:Remove() end

    if self.Prnt:IsHovered() or self.Prnt:IsChildHovered() then
        local mx,my = self:GetParent():CursorPos()
        self:SetAlpha(255)
        self:SetPos(mx - (self:GetWide() * .5) , my - 50)
    else
        if self:GetAlpha() > 0 then self:SetAlpha(0) end
    end
end
derma.DefineControl("DynTooltip", "Dynamic VGUI Tooltip", PANEL, "DPanel")