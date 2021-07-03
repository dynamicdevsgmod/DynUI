local PANEL = {}
AccessorFunc(PANEL, "tgl_header", "Header", FORCE_BOOL)

function PANEL:Init()
    self.Minimized = false
end

function PANEL:DoHeader()
    self.Header = true
    local header = self:Add("DPanel")
    header:Dock(TOP)
    header:SetTall(30)
    header.Paint = function(me,w,h)
        draw.RoundedBoxEx(4, 0, 0, w, h, DynUI.Header, true, true, false, false)
        draw.SimpleText(self.Title or "Window", "DynUI_Title", self:GetWide() * .5, me:GetTall() * .5 , DynUI.Title, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    self.ResetHeight = self:GetTall()
    self.MinHeight = header:GetTall()
    
    local close = header:Add("DButton")
    close:Dock(RIGHT)
    close:SetWide(30)
    close:SetText("")
    local hov_close = DynUI:DarkenColor(DynUI.Close)
    close.Paint = function(me,w,h)
        if not me:IsHovered() then
            surface.SetDrawColor(DynUI.Close)
        else
            surface.SetDrawColor(hov_close)
        end
        draw.NoTexture()
        DynUI:DrawCircle( w * .5, h * .5, 9, 120 )
    end
    close.DoClick = function(me)
        self:Remove()
    end

    local minimize = header:Add("DButton")
    minimize:SetDisabled(true)
    minimize:Dock(RIGHT)
    minimize:SetWide(30)
    minimize:SetText("")
    local hov_min = DynUI:DarkenColor(DynUI.Minimize)
    minimize.Paint = function(me,w,h)
        if not me:IsHovered() then
            surface.SetDrawColor(DynUI.Minimize)
        else
            surface.SetDrawColor(hov_min)
        end
        draw.NoTexture()
        DynUI:DrawCircle( w * .5, h * .5, 9, 120 )
    end
    minimize.DoClick = function(me)
        if not self.Minimized then
            self:SetTall(self.MinHeight)
        else
            self:SetTall(self.ResetHeight)
        end

        self.Minimized = not self.Minimized
    end

end

function PANEL:SetTitle(title)
    if not self.Header then return end
    
    self.Title = title
end

function PANEL:Paint(w,h)
    draw.RoundedBox( 4, 0, 0, w, h, DynUI.Primary )
end

derma.DefineControl("DynFrame", "Dynamic VGUI Frame", PANEL, EditablePanel)