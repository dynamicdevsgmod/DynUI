local PANEL = {}

function PANEL:Init()
    self.Minimized = false
end

function PANEL:DoHeader()
    self.Header = self:Add("DPanel")
    self.Header:Dock(TOP)
    self.Header:SetTall(30)
    self.Header:SetCursor("sizeall")
    self.Header.Paint = function(me,w,h)
        draw.RoundedBoxEx(4, 0, 0, w, h, DynUI.Header, true, true, false, false)
        draw.SimpleText(self.Title or "Window", "DynUI_Title", self:GetWide() * .5, me:GetTall() * .5 , DynUI.Title, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.Header.OnMousePressed = function(me,kc)
        if kc != MOUSE_LEFT then return end
        if self.Header:IsChildHovered() then return end
        self.Dragging = true
        self:MouseCapture(true)
    end
    self.Header.OnMouseReleased = function(me,kc)
        self.Dragging = nil
        self:MouseCapture(false)
    end
    self.Header.Think = function(me) -- TODO make it not snap cursor to center of panel
        if not self.Dragging then return end
        if not input.IsMouseDown(MOUSE_LEFT) then self:MouseCapture(false) self.Dragging = nil return end
    
        local x,y = gui.MouseX() - self:GetWide() * .5 , gui.MouseY() - self.Header:GetTall() * .5

        if x > ScrW() - self:GetWide() - 5 then x = ScrW() - self:GetWide() end
        if y < -5 then y = 0 end
        self:SetPos(x,y)
    end

    self.ResetHeight = self:GetTall()
    self.MinHeight = self.Header:GetTall()
    
    local close = self.Header:Add("DButton")
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
        DynUI:DrawCircle( w * .5, h * .5, 8, 120 )
    end
    close.DoClick = function(me)
        self:Remove()
    end

    local minimize = self.Header:Add("DButton")
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
        DynUI:DrawCircle( w * .5, h * .5, 8, 120 )
    end
    minimize.DoClick = function(me)
        if not self.Minimized then
            self:SetTall(self.MinHeight)
            self:KillFocus()
			self:SetMouseInputEnabled(false)
			self:SetKeyboardInputEnabled(false)
			self:SetAlpha(200)

			gui.HideGameUI()

            self.Minimized = true
        end
    end

end

function PANEL:SetBlur(blur)
    if not blur then return self.Blur end
    self.Blur = blur
end

function PANEL:SetTitle(title)
    if not self.Header then return end
    
    self.Title = title
end

function PANEL:Paint(w,h)
    if self.Blur then
        Derma_DrawBackgroundBlur(self)
    end
    draw.RoundedBox( 4, 0, 0, w, h, DynUI.Primary )
end

derma.DefineControl("DynFrame", "Dynamic VGUI Frame", PANEL, "EditablePanel")